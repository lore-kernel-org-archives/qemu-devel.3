Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19242C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 14:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJaAw-0003qu-Hs; Tue, 18 Jun 2024 10:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJaAu-0003qL-KJ; Tue, 18 Jun 2024 10:51:08 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJaAs-0003DP-TS; Tue, 18 Jun 2024 10:51:08 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52cc5d5179aso952439e87.0; 
 Tue, 18 Jun 2024 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718722264; x=1719327064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XFOP2OQTAOjEHDiaLrKVn5ROR94pabwwhGZRP/1DVv4=;
 b=RbWO2sq5/vvC8464jwHEd2i/bGFvWyCPQ0JOXTAhGq9oPQcsIoJX7a8aD+jifPTgEJ
 hWix5/G0Ee6a7JtcR5mjECgqKAvUJNF/dOHL96dJs0eQ4SQdPl3dZM6UpklLjDE52jp0
 8MRLeKJGLplg+rOdi+/5S4ylUtrj6OfzfMAfv/DhzU4N8J5DJ7Zw9JtjrYzR0gIiJLhb
 tWAME/9COxA23SdonSIsnrOjAQn8hjeF5uE6PMoMyz/JEFuahtn6JIUoPhBfogITuQaL
 EJcZo4+Y5M2mhKvrOnYxrI/mqbdFlsJjs5kkRZJa3NYXVeX4z4/tuC/2kIbkLyIGJY97
 SC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718722264; x=1719327064;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XFOP2OQTAOjEHDiaLrKVn5ROR94pabwwhGZRP/1DVv4=;
 b=kzgrTBgsOwLOzr3tgHlqTU0mfR91eCF9F7DUTVWn4oL/5d8JLI2fpXfjFhVZ2DY1Dg
 FC/dyNIF+GYW3kgU7cHuyxrhiqAdJUx/ddv3A/RN9j6mWVCjU5LJlAaP/GVFdNZcfUg4
 R5Mp9hRdN8RUexn2CzljSCsE7dTm/DWlyUvLaxm0yyXG5nH14AxhAHhfUSHBGt4JMIt9
 8QkYKGr9XMXI0quhbTdSWRDhX66YSyZ+uheXA1SzeHQxLAjtGfnEderQiloyGgzG4nFd
 zCHpein+7AUrjpvbTXcvFwD6EZVC8Gz8fk3LFtdvjwwPdDjbXLqRPLVcLgMk3xNZb1ea
 ORDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/hBTei1Oc0wHNaDCRmEgoc6nBq+dNe1m35gMzeH/pAtQS5+YKDyyFT9R7QmfGESgZoYjwXFah81W0zePf8/chbb+ElYCLhpp6OPi6OTqWVPMlUnYOmo2UG3A=
X-Gm-Message-State: AOJu0YyqOJXTtj9P14g4qrtMaOeJvHOs0DtE5QFjuV7JerKvqlqMvtlR
 sosBKSgZ14XVHU/tQNKiFFIGTpoLcERUc4myBA74wwsxgVwAuf8=
X-Google-Smtp-Source: AGHT+IHqoTd6vh0p2J7VHtVFpWsOkWkpgPODEBrKHh+VHBTfx6e7SF4li0UUKNrBlj9ktYaY6mj6wA==
X-Received: by 2002:ac2:464f:0:b0:52c:93b1:3c78 with SMTP id
 2adb3069b0e04-52ca6e6596fmr9310370e87.23.1718722264113; 
 Tue, 18 Jun 2024 07:51:04 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750ad221sm14319598f8f.58.2024.06.18.07.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 07:51:03 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] hw/misc: Fix invalid size assertions in exynos4210_rng
 read/write functions
Date: Tue, 18 Jun 2024 16:50:54 +0200
Message-Id: <20240618145054.3144311-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=zheyuma97@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit updates the exynos4210_rng_read() and exynos4210_rng_write()
functions to handle cases where the size is not 4 bytes. Instead of
asserting, which causes the program to abort, the functions now log an
error message and return a default value for reads or do nothing for
writes when the size is invalid.

Reproducer:
cat << EOF | qemu-system-aarch64 -display none \
-machine accel=qtest, -m 512M -machine smdkc210 -qtest stdio
readb 0x10830454
EOF

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/misc/exynos4210_rng.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 0756bd3205..307d4eea43 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -146,7 +146,12 @@ static uint64_t exynos4210_rng_read(void *opaque, hwaddr offset,
     Exynos4210RngState *s = (Exynos4210RngState *)opaque;
     uint32_t val = 0;
 
-    assert(size == 4);
+    if (size != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid read size %u at offset 0x%" HWADDR_PRIx
+                      "\n", __func__, size, offset);
+        return 0;
+    }
 
     switch (offset) {
     case EXYNOS4210_RNG_CONTROL_1:
@@ -181,7 +186,12 @@ static void exynos4210_rng_write(void *opaque, hwaddr offset,
 {
     Exynos4210RngState *s = (Exynos4210RngState *)opaque;
 
-    assert(size == 4);
+    if (size != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid write size %u at offset 0x%" HWADDR_PRIx
+                      "\n", __func__, size, offset);
+        return;
+    }
 
     switch (offset) {
     case EXYNOS4210_RNG_CONTROL_1:
-- 
2.34.1


