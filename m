Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EA3D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6yl-0002b7-Ih; Fri, 09 Jan 2026 02:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ve6yd-0002Lg-SK
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:32:08 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1ve6yb-0008HZ-Vi
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:32:07 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81db1530173so423908b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767943924; x=1768548724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iuQizEdZh7B0v1fvwjupPNpbFPCDEo2KXzeqX+tKdDg=;
 b=HexBtikwmLoWnR9bjLBJ6UzfE26VH/W1CmERi/2MMGYrl6Zsh4J5eAGICYdjJKgUAm
 qFCZSyUW7W3Z1dep6iWgLtP8iOSxk2Tl9Q4D2/55TE5MioaQVZwjUMB8zCcGjwQ4vq7q
 UIiDBzN8fm9fLQ/doQipq/E3GNUOpwnz2c5NhX96BIEGGLdZFh+AZ005gEudlGcYNtrW
 wHsDa7qW7s/VSI9DI7LMvwDA3SrHeW61mr/BYjJIEYhIjAK+7//Xi0xV+lQnRtQcEJ4s
 QRRQR+9L8SZsx2q5i283Qf0huSgyzHgOqpJqdQT0FyHYAPm2Ht/lQhbt9ziV+e3DRIuR
 oDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767943924; x=1768548724;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iuQizEdZh7B0v1fvwjupPNpbFPCDEo2KXzeqX+tKdDg=;
 b=munwAaIAJeTMpjwkDhbc16TYRx+UsrvL57G85qCkrnFNoLXKKDNSJrDzOROKEEJror
 DpJa0wP8uRadhi7OM8khxlufQr0yPmGVp+uSEH6+xvMSPE3MEWgSRPfCbZC5IoyGOrNG
 FlTesZpFe+rJXz6BOopnEMA/vd1/Ka1j5fB87TK9RygZ9TNNXlLytb2CsiX8fph6XJU+
 Six7eW9Gs6xAmjiO38+GE/LfcbujNm4a6l6K04E7QtKwYJRsvpGEyZRcKPY/FkoPpbHS
 y6LY1eVo2MrHvAfZ4HZAI/pUp5Wh/iJ5eWmUTLrE/f67zwQzvVUCqPl+xEIECPY9fHXp
 3egw==
X-Gm-Message-State: AOJu0Yz0f745X5KiGwludySVlGd2CsyFuK/fPIcFxQbnaqkuW1glLImq
 j2jq/ccbl7HfTQ4tEzV0Ga4atu6Wuhe6VaiaC6QfbvEkjppYkSGo6xvJ7hNUs2Zz3B4WGvmpknU
 fGRIzSGP0hC/QIPzjfYlqiSb1FfIjf8CcO5wCWsAvRTlOcyx+wu+hP+pP0EMAwmGvSu09BHBUgT
 S7gknk9KWlTg005IkK7Of21Fdmgwq9af1FG0Tw1Q0=
X-Gm-Gg: AY/fxX7UQLCwQ9vQ9PT4W7txkMpyth9RzhpzV3lK+78SOcITSf56A+7C0AmLNGpTeBy
 2avCWbgk6ArXmCTD9/OhwJj8fztZXUVhNLCkzIvrFDs3LF2E3HkJqeDiGjMEvpIcGcEFUnGkGO/
 i2U0VTvSn9ldqy5b/JJCo7fBZCT6TafLOF/5uuSLsAoAL8+lP/KvhPedmZ7QiImZ/zBEzWu4AuQ
 50ODfPsRKHW0eOUJe6I8m2FNTnk2rP4x4CUkbR5rgH7SO2JH7wZ7gl6aBz0KoLTKqllZj7x1PUA
 xTN2SvRklCRiKRJ9bA0wRcTQ8hd05mr+dW1L6ISS5MkO0oSGoqE30F6J+1WJ9Pt6Bq7ldJ4eBGC
 NoIleBAIGPkR+rq8THa1dIpt4bGTWUdfgaq6gcMSPRo8p+JNwEEKedicyg6kiaQt5bkJ+kGwTQh
 7UVVutZ5fCCcDCEmkRVKLzS+WVbYs4eo3TUW5obInqsKJE5qP/maAm1IQ=
X-Google-Smtp-Source: AGHT+IFjBkJ0SR8xa2m44KAtWi9Uw3AZ86LZQ2p9rlHLPRiJ6ch+AJjyvxhWrnO1qMj7XVo8X8BJ/w==
X-Received: by 2002:a05:6a00:4c0d:b0:81e:7aa8:c262 with SMTP id
 d2e1a72fcca58-81e7aa8dbb3mr700224b3a.45.1767943924310; 
 Thu, 08 Jan 2026 23:32:04 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c52fd904sm9490421b3a.33.2026.01.08.23.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 23:32:04 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v5 0/4] Add RISC-V Zvqdotq extension support
Date: Fri,  9 Jan 2026 15:31:50 +0800
Message-ID: <20260109073154.46251-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch series adds Zvqdotq support.

The isa spec of Zvqdotq extension is not ratified yet, so this patch
series is based on the latest draft of the spec (v0.0.2) and make the Zvqdotq
extension as an experimental extension.

The draft of the Zvqdotq isa spec:
https://github.com/riscv/riscv-dot-product

v5:
* Add disassembler support
* Rebase to riscv-to-apply.next branch

v4:
* Update the PRIV_VERSION (Thanks for Daniel Henrique Barboza's
* suggestion)

v3:
* Fix casting and simplify vs1/vs2 access (Thanks for Richard
* Henderson's
  suggestion)

v2:
* Remove unnecessary variable and mask (Thanks for Richard Henderson's
  suggestion)

Max Chou (4):
  target/riscv: Add Zvqdotq cfg property
  target/riscv: rvv: Add Zvqdotq support
  target/riscv: Expose Zvqdotq extension as a cpu property
  disas/riscv: Support the Zvqdotq extension

 disas/riscv.c                                 | 21 +++++++
 target/riscv/cpu.c                            |  2 +
 target/riscv/cpu_cfg_fields.h.inc             |  1 +
 target/riscv/helper.h                         | 10 +++
 target/riscv/insn32.decode                    |  9 +++
 target/riscv/insn_trans/trans_rvzvqdotq.c.inc | 61 +++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                    |  5 ++
 target/riscv/translate.c                      |  1 +
 target/riscv/vector_helper.c                  | 57 +++++++++++++++++
 9 files changed, 167 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzvqdotq.c.inc

-- 
2.43.7


