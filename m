Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E56E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnig-0000xH-4x; Sun, 29 Dec 2024 02:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRniF-0007Wy-Kx
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:47 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRniC-0002QM-Oo
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:27:47 -0500
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-aa66ead88b3so1545136266b.0
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:27:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457263; x=1736062063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WiBy0J8yqLlyV4J5K+8NrqYNcSUPfedA9uj7buimwak=;
 b=BUNRUDfN1FN4qCkkT3YSCEgL6U44LLGXhDsU2cQzaUQfbqygqO/nT/6TdginlApHhF
 jr3LFT39Q3WS1q5vuA7gTXTqa0ipTulECqq/drvmnCG52aUVUEhXLR8SSLvOLZSqeeDD
 nF4zsW32+xWGk2xzeriVwkB2rPMdXMEan44Zfy8dL1Y0+DEJuO3vF9v4S67darM3uvw0
 e4Gyi1jj2JgZdGZ0lQ4nl+JKkj2Djf82xaPew6JLKdAlF5uu1AvAE69WLu9W3XRm26OS
 y0ha9xG86TJzNkqibqLB9auSB3gJhojkbzYTq7bLnwq4e/mUbt8Ga6GVR2lCT8MboQPl
 zTTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqOh+dlvVENzUnMoXlYMrgt/qCVKlA08KHxFUDVOHRaGD6HcHgG6uS3sfFZqhMiZoIeDYoefS8repP@nongnu.org
X-Gm-Message-State: AOJu0YwPbPBjfqgIl1f0HMojNPb5gLmII0fx0bVL2oMfv2lgFn4zbQVD
 +x/dSrU3TsGHGECkuMNkMzYzvFzp4PlNjb8TafUeU9NBTTRkTcNR
X-Gm-Gg: ASbGncve8H0Y5zCB3AWdzCZmWbCRYcqwl0FypNKUmwakpn8RFUrov5sIcsqpHYQ4kHZ
 FfRARVxIsLq4h4oestxih2mzQBtseS07qGeYIyubbeq+Ug4tki0n0jFjM3ViizMOjOR2wkCipiA
 Yyy97yuEhIjo315rCOJEgvkif2Ob5nOvPZHtzf/d4IpfwaXyXRheyMe4Skh4XTAlzh0pwntR2Fr
 R0PAPdu+QnnpBXSJ1s0RtD2zSTAizpNiHMfGJ9BSR8Bz0153Sb2rW7SHJzIEJRX4+p5kkFP03/9
 g5Y=
X-Google-Smtp-Source: AGHT+IFicz2nqAt3e1+14crZsqv4JWhuEdxZS7tUf4shZuFsq+3KyLZZ0llBUM3MWcriGk6p3NFGAQ==
X-Received: by 2002:a17:906:c10d:b0:aa6:6c08:dc71 with SMTP id
 a640c23a62f3a-aac2ad8ba3fmr2679643866b.23.1735457262825; 
 Sat, 28 Dec 2024 23:27:42 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:27:41 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 33/35] next-cube: move next_rtc_cmd_is_write() and
 next_rtc_data_in_irq() functions
Date: Sun, 29 Dec 2024 08:25:24 +0100
Message-ID: <20241229072526.166555-34-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.48; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f48.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Move these functions in next-cube.c so that they are with the rest of the
next-rtc functions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-32-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 172 ++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 9f40640b5d..360a46c32e 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -175,92 +175,6 @@ static void next_scr2_led_update(NeXTPC *s)
     }
 }
 
-static bool next_rtc_cmd_is_write(uint8_t cmd)
-{
-    return (cmd >= 0x80 && cmd <= 0x9f) ||
-           (cmd == 0xb1);
-}
-
-static void next_rtc_data_in_irq(void *opaque, int n, int level)
-{
-    NeXTRTC *rtc = NEXT_RTC(opaque);
-
-    if (rtc->phase < 8) {
-        rtc->command = (rtc->command << 1) | level;
-
-        if (rtc->phase == 7 && !next_rtc_cmd_is_write(rtc->command)) {
-            if (rtc->command <= 0x1f) {
-                /* RAM registers */
-                rtc->retval = rtc->ram[rtc->command];
-            }
-            if ((rtc->command >= 0x20) && (rtc->command <= 0x2f)) {
-                /* RTC */
-                time_t time_h = time(NULL);
-                struct tm *info = localtime(&time_h);
-                rtc->retval = 0;
-
-                switch (rtc->command) {
-                case 0x20:
-                    rtc->retval = SCR2_TOBCD(info->tm_sec);
-                    break;
-                case 0x21:
-                    rtc->retval = SCR2_TOBCD(info->tm_min);
-                    break;
-                case 0x22:
-                    rtc->retval = SCR2_TOBCD(info->tm_hour);
-                    break;
-                case 0x24:
-                    rtc->retval = SCR2_TOBCD(info->tm_mday);
-                    break;
-                case 0x25:
-                    rtc->retval = SCR2_TOBCD((info->tm_mon + 1));
-                    break;
-                case 0x26:
-                    rtc->retval = SCR2_TOBCD((info->tm_year - 100));
-                    break;
-                }
-            }
-            if (rtc->command == 0x30) {
-                /* read the status 0x30 */
-                rtc->retval = rtc->status;
-            }
-            if (rtc->command == 0x31) {
-                /* read the control 0x31 */
-                rtc->retval = rtc->control;
-            }
-        }
-    }
-    if (rtc->phase >= 8 && rtc->phase < 16) {
-        if (next_rtc_cmd_is_write(rtc->command)) {
-            /* Shift in value to write */
-            rtc->value = (rtc->value << 1) | level;
-        } else {
-            /* Shift out value to read */
-            if (rtc->retval & (0x80 >> (rtc->phase - 8))) {
-                qemu_irq_raise(rtc->data_out_irq);
-            } else {
-                qemu_irq_lower(rtc->data_out_irq);
-            }
-        }
-    }
-
-    rtc->phase++;
-    if (rtc->phase == 16 && next_rtc_cmd_is_write(rtc->command)) {
-        if (rtc->command >= 0x80 && rtc->command <= 0x9f) {
-            /* RAM registers */
-            rtc->ram[rtc->command - 0x80] = rtc->value;
-        }
-        if (rtc->command == 0xb1) {
-            /* write to 0x30 register */
-            if (rtc->value & 0x04) {
-                /* clear FTU */
-                rtc->status = rtc->status & (~0x18);
-                qemu_irq_lower(rtc->power_irq);
-            }
-        }
-    }
-}
-
 static void next_scr2_rtc_update(NeXTPC *s)
 {
     uint8_t old_scr2, scr2_2;
@@ -1012,6 +926,92 @@ static const MemoryRegionOps next_dummy_en_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static bool next_rtc_cmd_is_write(uint8_t cmd)
+{
+    return (cmd >= 0x80 && cmd <= 0x9f) ||
+           (cmd == 0xb1);
+}
+
+static void next_rtc_data_in_irq(void *opaque, int n, int level)
+{
+    NeXTRTC *rtc = NEXT_RTC(opaque);
+
+    if (rtc->phase < 8) {
+        rtc->command = (rtc->command << 1) | level;
+
+        if (rtc->phase == 7 && !next_rtc_cmd_is_write(rtc->command)) {
+            if (rtc->command <= 0x1f) {
+                /* RAM registers */
+                rtc->retval = rtc->ram[rtc->command];
+            }
+            if ((rtc->command >= 0x20) && (rtc->command <= 0x2f)) {
+                /* RTC */
+                time_t time_h = time(NULL);
+                struct tm *info = localtime(&time_h);
+                rtc->retval = 0;
+
+                switch (rtc->command) {
+                case 0x20:
+                    rtc->retval = SCR2_TOBCD(info->tm_sec);
+                    break;
+                case 0x21:
+                    rtc->retval = SCR2_TOBCD(info->tm_min);
+                    break;
+                case 0x22:
+                    rtc->retval = SCR2_TOBCD(info->tm_hour);
+                    break;
+                case 0x24:
+                    rtc->retval = SCR2_TOBCD(info->tm_mday);
+                    break;
+                case 0x25:
+                    rtc->retval = SCR2_TOBCD((info->tm_mon + 1));
+                    break;
+                case 0x26:
+                    rtc->retval = SCR2_TOBCD((info->tm_year - 100));
+                    break;
+                }
+            }
+            if (rtc->command == 0x30) {
+                /* read the status 0x30 */
+                rtc->retval = rtc->status;
+            }
+            if (rtc->command == 0x31) {
+                /* read the control 0x31 */
+                rtc->retval = rtc->control;
+            }
+        }
+    }
+    if (rtc->phase >= 8 && rtc->phase < 16) {
+        if (next_rtc_cmd_is_write(rtc->command)) {
+            /* Shift in value to write */
+            rtc->value = (rtc->value << 1) | level;
+        } else {
+            /* Shift out value to read */
+            if (rtc->retval & (0x80 >> (rtc->phase - 8))) {
+                qemu_irq_raise(rtc->data_out_irq);
+            } else {
+                qemu_irq_lower(rtc->data_out_irq);
+            }
+        }
+    }
+
+    rtc->phase++;
+    if (rtc->phase == 16 && next_rtc_cmd_is_write(rtc->command)) {
+        if (rtc->command >= 0x80 && rtc->command <= 0x9f) {
+            /* RAM registers */
+            rtc->ram[rtc->command - 0x80] = rtc->value;
+        }
+        if (rtc->command == 0xb1) {
+            /* write to 0x30 register */
+            if (rtc->value & 0x04) {
+                /* clear FTU */
+                rtc->status = rtc->status & (~0x18);
+                qemu_irq_lower(rtc->power_irq);
+            }
+        }
+    }
+}
+
 static void next_rtc_cmd_reset_irq(void *opaque, int n, int level)
 {
     NeXTRTC *rtc = NEXT_RTC(opaque);
-- 
2.47.1


