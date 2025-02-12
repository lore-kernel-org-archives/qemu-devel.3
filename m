Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B55C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiB65-0002JR-8v; Wed, 12 Feb 2025 06:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiB64-0002J7-4e
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:40:04 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiB5x-0000ft-G7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:40:03 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38dd14c9a66so2047628f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739360390; x=1739965190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BnA6bbjEyVqBso4cbRaO3wDSvFIUbqXqzqoiCcLIb3A=;
 b=wL4Gfl70fAf0Lu9uAS0xegvzZBfCWKfFGRL7DMevXm08Hp9pupXs++yKN+Ggw3zxAP
 eXcmS/6FOQ6geLR2dMOJsI5eJvOoRJ02N4dnaKXPSOERYhXVYx1/ttcGtodApdZ4qvzk
 HfpUmke9lLVpIfJb5MG8fMuAX5dwYvJfDT+6bbICOH55KddiBJW8js4TAfpNMtj6dLKZ
 VbzNqXV2jYiKXmtK1bqQ0FErBwMACu6YPAWhNL5hlNFUNtJxkabL9wq7STo8LqXHZenx
 rgtbPfRDx/Pz9vK/pDTHkw+AZdX6BK7wpNLdYqD83okn6N4W+q14sSlnxgddIJYrnU1h
 98LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739360390; x=1739965190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BnA6bbjEyVqBso4cbRaO3wDSvFIUbqXqzqoiCcLIb3A=;
 b=GXSshSRzCfXcpMrFjj2UyWz/yt+iwlgFVV/0gael5VXEwFwdJRJ9JpJJDlzv77qsI2
 z2a1N1SKmYjsL2DdMoGtFJ7xuAOiLNYpn1P7lZcrCFoKwo7eHdH/17jIIscrDCCCDQ+s
 U5FY8KOiE+gOav59yynscRjsPXjboE8e8787S7m3Dv40UFyKZEaHEtAI9mVZMyqMS3Im
 U2btd81cBv0t2weQTUaYFtFObQcD4Hty8uWfUSyXoBBsO8j4sAX1d3pGRuJXJJ4rJmCO
 kh7jPMAbsRZMP4mOaUfMtgNauYNAeShQm4zdx3k2aJVcdGyu6DoPup19g6zw2tQ28j0C
 LdCw==
X-Gm-Message-State: AOJu0YzFyC0gYvXnKfwE0MKt94iSjMAU76pAIapKXwYGC8UYWWpjJAAs
 LFY0G6Yxy+goCogotN0/rGBh7xfMB/V/zYM9CdITR8z5HvQ7G7lblWm9iVPqn4YYRWFwX6Ay5BO
 Ti4E=
X-Gm-Gg: ASbGncvboCxu97tU2D8u68CidU57aSwCmSFrtMvJMOzf6CIOQ1tjXZmVDl8J65b4Ydb
 yi2NW9g6yDrnhynW1/fiqa+PEpwS1CJtaoHaSHUtlZhvI3g2yNUoCll6VZkry6f1jrN02SRejGp
 /hEczRxfnWNNEY1IBcz/WPgJPFdo5DzR9EEbbsGQphWe4G6QpdLxVSEcp028ztQOzJyIhei17lg
 ZDYAcLq+t6mt8ZoB5gEQfORw82JbzIo2lwZWBpNF2hSwE+qk5LT3ATa0cUmgb9IlziWdEyhkF4R
 J0b7ezvW8bVGyOUXyTZMvqQ/apamxlyHUwNxGg8lngD/gHcYmbDcVJwS2AaiCF3Aqw==
X-Google-Smtp-Source: AGHT+IFFHjadMzwcsibwqusSkTajkLBZKUry+cKF2CQjo5NjWiQE0iW8MiDmQJ249dDv5YuC163EDg==
X-Received: by 2002:a5d:664f:0:b0:38d:e57e:d21 with SMTP id
 ffacd0b85a97d-38dea290b69mr1804312f8f.30.1739360390141; 
 Wed, 12 Feb 2025 03:39:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd4342502sm11666896f8f.26.2025.02.12.03.39.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 03:39:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@kernel.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jason Wang <jasowang@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH 2/5] hw/mips: Mark Boston machine devices as little-endian
Date: Wed, 12 Feb 2025 12:39:35 +0100
Message-ID: <20250212113938.38692-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212113938.38692-1-philmd@linaro.org>
References: <20250212113938.38692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The Boston machine is only built as little-endian.
Therefore the DEVICE_NATIVE_ENDIAN definition expand to
DEVICE_LITTLE_ENDIAN (besides, the DEVICE_BIG_ENDIAN case
isn't tested). Simplify directly using DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/boston.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 364c328032a..4690b254dda 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -220,7 +220,7 @@ static void boston_lcd_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps boston_lcd_ops = {
     .read = boston_lcd_read,
     .write = boston_lcd_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static uint64_t boston_platreg_read(void *opaque, hwaddr addr,
@@ -299,7 +299,7 @@ static void boston_platreg_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps boston_platreg_ops = {
     .read = boston_platreg_read,
     .write = boston_platreg_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void mips_boston_instance_init(Object *obj)
@@ -758,7 +758,7 @@ static void boston_mach_init(MachineState *machine)
 
     s->uart = serial_mm_init(sys_mem, boston_memmap[BOSTON_UART].base, 2,
                              get_cps_irq(&s->cps, 3), 10000000,
-                             serial_hd(0), DEVICE_NATIVE_ENDIAN);
+                             serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     lcd = g_new(MemoryRegion, 1);
     memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0x8);
-- 
2.47.1


