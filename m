Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBB1C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZygG-0007ae-S9; Tue, 13 Feb 2024 14:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygF-0007RO-2h
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:59 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyg9-0006Q4-Hc
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A7Ml3OJRuG9i9wCVUKZri2ee9kNdSQpXNdwl+PnHGcw=; b=1ABVLHiY1qs+tqCUxSYyUUf2lF
 TRfvxHcl7GlSPzFgrwnc9aP5rHQdxP59VM82dcvclcy4idBqOx4R77In8jkOYBJ/5wvvrx6ougndP
 f4MypvrJcAdUQCH/klZkixQYQ1FoWgmGFNP9Bu+3ifTTieLtq/AN3D0ROwQrYHoFPG0VyagBhUtgR
 S2OJlUpCS7Ohx2cZvmHt6eG0EdUL++mu7sfRC3E5KGWhs0x6vs450STT3Pw+o8Jowl0PeiqS/5vAe
 DG7ZTs2dFJdEaH4GX3RK01mojARelp45ROca1PAe0gZ9GK+zpARGT1Epr3OxwfD9gvgbkZFMq5Hlh
 vSYCeiITyHsYrNaNUBSt7YBI7hHMoXPEtmnHebIrP01TVD8pIghTQJzDu4rmfE2DT5xJsBtArLNkt
 VryBv8tHIDenSeuSfADw7exxBvGe8nGGYa1WZHWqxYYftMt/jSS0+X7z7QlzA8kAGRXcMSxLm7iBz
 lZRleR5vX+hIGktcLxoMw3QGwS+HBajZY02V2GnTvMZbdPNhVYVhEHncnFTdAAldIpaEaJs/zX/su
 WcMbJeoYaK0KnxNqk0v1+LDTV7Uxl/Sj014/hBs54zQ90BjPd41busaV2zEoykhmwbMNHWGY/w2FX
 zozWL9X3JztyZvMkTzA/QP+YBlWPczxGbQD93J7PA=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfG-0008m4-0n; Tue, 13 Feb 2024 19:42:01 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:54 +0000
Message-Id: <20240213194052.1162753-31-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 30/88] esp.c: move TC and FIFO check logic into esp_dma_done()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This helps simplify the existing implementation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-31-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index c6151d306e..4d58a49c73 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -545,8 +545,11 @@ static void write_response(ESPState *s)
 
 static void esp_dma_done(ESPState *s)
 {
-    s->rregs[ESP_RINTR] |= INTR_BS;
-    esp_raise_irq(s);
+    if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
+        s->rregs[ESP_RINTR] |= INTR_BS;
+        esp_raise_irq(s);
+        esp_lower_drq(s);
+    }
 }
 
 static void do_dma_pdma_cb(ESPState *s)
@@ -610,12 +613,7 @@ static void do_dma_pdma_cb(ESPState *s)
             return;
         }
 
-        if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
-            esp_lower_drq(s);
-            esp_dma_done(s);
-        }
-
-        return;
+        esp_dma_done(s);
     } else {
         if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
             /* Defer until the scsi layer has completed */
@@ -624,10 +622,7 @@ static void do_dma_pdma_cb(ESPState *s)
             return;
         }
 
-        if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
-            esp_lower_drq(s);
-            esp_dma_done(s);
-        }
+        esp_dma_done(s);
 
         /* Copy device data to FIFO */
         len = MIN(s->async_len, esp_get_tc(s));
@@ -713,10 +708,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
-                esp_dma_done(s);
-                esp_lower_drq(s);
-            }
+            esp_dma_done(s);
         } else {
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
@@ -727,10 +719,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
-                esp_dma_done(s);
-                esp_lower_drq(s);
-            }
+            esp_dma_done(s);
         }
     } else {
         if (s->dma_memory_write) {
@@ -747,10 +736,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
-                esp_dma_done(s);
-                esp_lower_drq(s);
-            }
+            esp_dma_done(s);
         } else {
             /* Copy device data to FIFO */
             len = MIN(len, fifo8_num_free(&s->fifo));
@@ -768,10 +754,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
-                esp_lower_drq(s);
-                esp_dma_done(s);
-            }
+            esp_dma_done(s);
         }
     }
 }
-- 
2.39.2


