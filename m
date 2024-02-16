Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18781C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayj0-0006XY-U1; Fri, 16 Feb 2024 08:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rayii-0006KK-TE
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:57:41 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rayia-0003e5-Ts
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:57:39 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dba94f9201so5564645ad.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 05:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708091848; x=1708696648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VuWkQa5G3p5yKcEgQcwfaDUggnii8C6Urb6dECN5vgg=;
 b=iKaRhSja1v+icyhlAiIn5fVVCqfVj4q7cFWvz4BpeK+UXJ/qnR6sT8WogFxt1xL+H3
 Nj7unUXMZZE0br86+k1DfHJaBUJ74SvsmsFpd+0vnqJDqh+T6derP6Czu8FxtX22vF+c
 RWohzAS1PIk0AOc9tkL8QR0ueZmGVWDtDHksaUWhQkBoI8NC+7uL7fPJWZ7IqW3hIEiR
 ErqRtWvb8695OkQCIvA8q/4M18KHmHzNQkcy/Eu8ycUiGQr5qkGMkM753JKVgWM0rH72
 Rf1P7YBQaJaq/vGGxMv9loA9xj0D500EXAxLVc/7w9MtfLW75xj2bKFNg4+8GvRJK26Z
 7Dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708091848; x=1708696648;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VuWkQa5G3p5yKcEgQcwfaDUggnii8C6Urb6dECN5vgg=;
 b=pLt78oK6RKOK15wB9bfllQOOBHolzrphVTC75hu9bzXobpgk9juFRJdUMPrFODAbNZ
 h15nVKhQ8gPglplGMoSvfG9lMvgxKymHsK9REZkaB68i3voTiOoBAHyd4aLXpswsNxok
 Z0UWVNFEr0+Wgr0uKSOVKf/SSqTVFbsBV1UjK4aqMF8jlAOsYY9ts5rnIuFmdhKh1gi+
 2Qq1XqcpnH5GLzx3kzQGUJRczK4Fl3l7AGPZaVnlb3l6/4XdU1L3GbEGR0OZO6LbBy6c
 b8t+ZKBP7gBPtU1sk+5ZzDdc1+YOpWd05mhkoEqeobwJq+did2BeSO/r11b2oohGDKQw
 wyAg==
X-Gm-Message-State: AOJu0Yziek/u6+mMgqvULXgmIrVcExqLIfqn8BQwFKG1mrQ6dBraWxCr
 xMyto9WCNjIXkD5k8HhJOGh3avW7kvX/eaq2bVZLiwAjGDBbtkF6nwm/Yyza1EZ6yV/pEnDQ6xi
 N
X-Google-Smtp-Source: AGHT+IE42nMyBwRxjJSJdUiWWeLqUWVcfkEYgj7zrKrEN5ydlSHUjd/9H8JZEz3Ue3CLrQSyaU2QXg==
X-Received: by 2002:a17:903:230b:b0:1d9:bdbc:388b with SMTP id
 d11-20020a170903230b00b001d9bdbc388bmr6356837plh.45.1708091848164; 
 Fri, 16 Feb 2024 05:57:28 -0800 (PST)
Received: from grind.. ([177.94.15.159]) by smtp.gmail.com with ESMTPSA id
 j18-20020a170902c3d200b001dbb06b6138sm889606plj.252.2024.02.16.05.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 05:57:27 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 richard.henderson@linaro.org, max.chou@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/3] riscv: set vstart_eq_zero on mark_vs_dirty 
Date: Fri, 16 Feb 2024 10:57:16 -0300
Message-ID: <20240216135719.1034289-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

This second version is based on feedback gave on the Gitlab bug [1] by
Vladimir Isaev. For this approach to work the 'vstart_eq_zero' flag
must be updated regardless of 'mstatus_vs' being marked as DIRTY or
not - there's no guarantee that we'll clean mstatus_vs after each change
in 'vstart'.

Patches based on alistair/riscv-to-apply.next.


[1] https://gitlab.com/qemu-project/qemu/-/issues/1976

Changes from v1:
- patch 3:
  - always update vstart_eq_zero, not only if "mstatus_vs !=
    EXT_STATUS_DIRTY"
- v1 link: https://lore.kernel.org/qemu-riscv/20240216112806.997948-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (3):
  trans_rvv.c.inc: write CSRs must call mark_vs_dirty() too
  trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
  target/riscv/translate.c: set vstart_eq_zero in mark_vs_dirty()

 target/riscv/insn_trans/trans_rvv.c.inc | 28 +++++++------------------
 target/riscv/translate.c                | 20 ++++++++++++++++++
 2 files changed, 27 insertions(+), 21 deletions(-)

-- 
2.43.0


