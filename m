Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBB7E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 14:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVX9z-0006vi-FP; Wed, 08 Jan 2025 09:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tVX9t-0006ue-S6
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:35:45 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tVX9q-0006aR-64
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:35:45 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso8441907f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 06:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1736346939; x=1736951739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5PRSpyfcytXmuKAF8Pm3qLq6TiyleYEmr3I0311nig=;
 b=KCspFpUCf6CTjhocKmT5IEcnto5LfFCVubH19HRZ+JHtUYFrWLXC59bpp+y3W9MzTY
 Pb4/Vhknep8ej7+nvs9R7nkTsj0/OMf2K2KUos+ioucJC0of735bn14d/fwDuvWKQb3c
 AOlizZRXTef1Zi7WcKWMFUMnw7JM+SARYWLvp+3V/goS/V/E/0SWkrDKF3OPpvNLxG9s
 5Yv0S8jtmTmzzXvym8uFq7goW3CINvvdSOfNwH4uydHJnL8zReq45GKivf/mcXQvZwDa
 7E/rsj5VU+cp9FlEN5dFBdgUNNPma8p5A/jRvVYmYu1qT6iGWyKtEqKLClDuEnXNMM8q
 aJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736346939; x=1736951739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z5PRSpyfcytXmuKAF8Pm3qLq6TiyleYEmr3I0311nig=;
 b=ma4KBx+O3PcbHmB/ooQzeXMxx4GYwa/0IKj4/8aRTaJS0XRacCBqD0X30oBJYcqf/U
 UamTehDIAXmCzK6L7Hvb3a/ws6rpYNr194ZPG8h+EncgsPHeB0Itxc8netM6lud9NfMj
 aymO6MUVcG0ub5WntUDsX2zgall3fs9oxwlozNn7ZaB1DUbSoru8iQNWex870yf+mnVE
 fcH4MuKKTe0I+zv8NpIobUH1sVe2YFWzjd7A5EU7x3pmYVU/CIipiQ+vi4sFAvfdyal0
 UBW9uVW0Kr7MsCMEnfL9PrdJltpn6rz+XSbEun5JSbxO7Jpt4kcqftlhc3zTKOAYq2He
 CISg==
X-Gm-Message-State: AOJu0YwblKR/OJwx/62HmPF5iH8e9rLLQfPOr0S14nnWD1wngeqwMLhY
 1uyuqJ8yWmhB0wvhB4zDmIGwnuTxdxBC4xnQiRxZjoF1nmqKCQwoRgVw/OvS/C5Ijo6cLCd+sxO
 3vK4=
X-Gm-Gg: ASbGncueYUkH//4/g0TzVBkER4CCRLrv1UtSPMScQB19cpS2NLqSrbJ9xnZCG0L1yKf
 4XyiMy3uBtGc1Eim5oPLiQzPERZ4M2g1fa8At9+vUaLqj+RAthBTx6e+2xnl80RuSP6siDAsNoj
 0i/SEf7n2oHSoh/lf8X4R3vBzeRVc+b/7pArTNBaE6T0nQugbeZI9cpiW2Kss58WxZ9IGNawuqK
 VQEGBUqIzPuDxWbQxqxGyAJvH9rRVBnwDnGlX45x014ydso8Hb67rhD7bNnW2FC5fZvPKwfk47I
 N9eZiDyRJP86p/9qRzFGCehhQrk8YllyWMZG2OoIUOkG4CW3
X-Google-Smtp-Source: AGHT+IFQWpT0XywmqaiF6ig/2dNiaE8DZis8EL+9CFjK/aDmYcq/qWK6fSzDkAg4B4ASbUIGuYJsnQ==
X-Received: by 2002:a5d:59ab:0:b0:386:39fd:5ec with SMTP id
 ffacd0b85a97d-38a8731869dmr2606469f8f.57.1736346939588; 
 Wed, 08 Jan 2025 06:35:39 -0800 (PST)
Received: from dorian..
 (sals-04-b2-v4wan-167965-cust660.vm36.cable.virginm.net. [80.3.10.149])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8330d4sm52450316f8f.29.2025.01.08.06.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 06:35:39 -0800 (PST)
From: Craig Blackmore <craig.blackmore@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Craig Blackmore <craig.blackmore@embecosm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v8 0/1] target/riscv: rvv: Use wider accesses for unit stride
 load/store
Date: Wed,  8 Jan 2025 14:35:22 +0000
Message-ID: <20250108143523.153010-1-craig.blackmore@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=craig.blackmore@embecosm.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks Richard for the review on v7. I have updated the patch based on your suggestions.

Changes since v7:
- Remove CONFIG_INT128_TYPE guards.
- Strengthen condition for using atomic128.
- Use memcpy for misaligned accesses.
- Hoist atomic operation selection higher up the call stack.

Previous versions:
- v1: https://lore.kernel.org/all/20240717153040.11073-1-paolo.savini@embecosm.com/
- v2: https://lore.kernel.org/all/20241002135708.99146-1-paolo.savini@embecosm.com/
- v3: https://lore.kernel.org/all/20241014220153.196183-1-paolo.savini@embecosm.com/
- v4: https://lore.kernel.org/all/20241029194348.59574-1-paolo.savini@embecosm.com/
- v5: https://lore.kernel.org/all/20241211143118.661268-1-craig.blackmore@embecosm.com/
- v6: https://lore.kernel.org/all/20241218142937.1028602-1-craig.blackmore@embecosm.com/
- v7: https://lore.kernel.org/all/20241220122109.2083215-1-craig.blackmore@embecosm.com/

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Helene Chelin <helene.chelin@embecosm.com>
Cc: Nathan Egge <negge@google.com>
Cc: Max Chou <max.chou@sifive.com>

Craig Blackmore (1):
  target/riscv: rvv: Use wider accesses for unit stride load/store

 target/riscv/vector_helper.c | 90 ++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 8 deletions(-)

-- 
2.43.0


