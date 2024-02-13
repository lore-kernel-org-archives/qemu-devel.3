Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4834C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyhN-0003UP-Vs; Tue, 13 Feb 2024 14:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhE-0002qA-B3
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:44:02 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhC-0006eW-QP
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OX9tAdGC0Xi6/uPf3DfJDeljWUSeH7tBFFTxYDRwDNA=; b=Aj7bUdNs5OqoQw0TvyrK1kR1ln
 EBPndOx+X58M82TjjGsPsqno3vBLRDbP6OQ0ZI3vMZNHm/CVDWDyPbJGbIDaGPP4DQ2IvM3q+Zvv7
 svf/+zYuKrfkHzpWa1DrtU1eEBCc6BjeAH1Ywhu2MRl4f5eChbRnkguwHYXXX+pJ6QASTIU7Hjsql
 wavepHN6WhKUuUOYdtcthSuWr1XGtGjL6a5xEtuds+BdfV3v2QJKsjnlWqFQ8kZiJccGr92BjCmTR
 L5kB6fPNN94qxoU8LBIevBJkuhbnOeW5+lfh2xTlKtME9OqGy5GSLl/sFAcQUVY99rJ7qNQ+lzXdV
 RPAepa4+/iC+x4kvoIraE36SX+mlA/mZnAiWmO25Rt6AR0AY4M+JAN4cZrGqD2ubn4cdoIf5xhi54
 lgjqVb2/8U5Y5o69CY6EAOCBsZ5CdvEmJVNbZ7pa51Kc5gst52+BAuOb33NbQaSW3RZJ9wPVC+g2S
 Nn04Wa2I1RMq7cSyZtpn7hMfnGRmxxSRc2twUbiTpNilg9V1es2kTfnWfXBVGtT7b1qwPN6DSNfdf
 hx3Mdn0qVXMjk+GXHoWr8vMLCjyvcxq2diAy/6LL6SbIhdS85v6o4odMqlvnIyBumjUHpDr+yYhrS
 4ZTWpQtEej1Bk9VgwA0bxNFBd6iWqO1uO+/NDLFBs=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygK-0008m4-5L; Tue, 13 Feb 2024 19:43:08 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:13 +0000
Message-Id: <20240213194052.1162753-50-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 49/88] esp.c: move CMD_SELATN end of message phase detection to
 esp_do_dma() and do_dma_pdma_cb()
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

The special logic in satn_pdma_cb() is now no longer required since esp_do_dma()
can be used as a direct replacement.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-50-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 75 +++++++++++++++++++++++++------------------
 include/hw/scsi/esp.h |  1 -
 2 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 81144ace83..f8c20d0584 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -261,6 +261,9 @@ static int esp_select(ESPState *s)
     return 0;
 }
 
+static void esp_do_dma(ESPState *s);
+static void esp_do_nodma(ESPState *s);
+
 static uint32_t get_cmd(ESPState *s, uint32_t maxlen)
 {
     uint8_t buf[ESP_CMDFIFO_SZ];
@@ -368,45 +371,26 @@ static void do_cmd(ESPState *s)
     do_command_phase(s);
 }
 
-static void satn_pdma_cb(ESPState *s)
-{
-    uint8_t buf[ESP_FIFO_SZ];
-    int n;
-
-    /* Copy FIFO into cmdfifo */
-    n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-    n = MIN(fifo8_num_free(&s->cmdfifo), n);
-    fifo8_push_all(&s->cmdfifo, buf, n);
-
-    if (!esp_get_tc(s) && !fifo8_is_empty(&s->cmdfifo)) {
-        s->cmdfifo_cdb_offset = 1;
-        do_cmd(s);
-    }
-}
-
 static void handle_satn(ESPState *s)
 {
-    int32_t cmdlen;
-
     if (s->dma && !s->dma_enabled) {
         s->dma_cb = handle_satn;
         return;
     }
-    esp_set_pdma_cb(s, SATN_PDMA_CB);
+    esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
     if (esp_select(s) < 0) {
         return;
     }
-    cmdlen = get_cmd(s, ESP_CMDFIFO_SZ);
-    if (cmdlen > 0) {
-        s->cmdfifo_cdb_offset = 1;
-        do_cmd(s);
-    } else if (cmdlen == 0) {
-        if (s->dma) {
-            esp_raise_drq(s);
+
+    esp_set_phase(s, STAT_MO);
+
+    if (s->dma) {
+        esp_do_dma(s);
+    } else {
+        if (get_cmd(s, ESP_CMDFIFO_SZ)) {
+            s->cmdfifo_cdb_offset = 1;
+            do_cmd(s);
         }
-        /* Target present, but no cmd yet - switch to command phase */
-        s->rregs[ESP_RSEQ] = SEQ_CD;
-        esp_set_phase(s, STAT_CD);
     }
 }
 
@@ -558,6 +542,21 @@ static void do_dma_pdma_cb(ESPState *s)
         esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
         esp_raise_drq(s);
 
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_SELATN | CMD_DMA:
+            if (fifo8_num_used(&s->cmdfifo) >= 1) {
+                /* First byte received, switch to command phase */
+                esp_set_phase(s, STAT_CD);
+                s->cmdfifo_cdb_offset = 1;
+
+                if (fifo8_num_used(&s->cmdfifo) > 1) {
+                    /* Process any additional command phase data */
+                    esp_do_dma(s);
+                }
+            }
+            break;
+        }
+
         /* ATN remains asserted until TC == 0 */
         if (esp_get_tc(s) == 0) {
             esp_set_phase(s, STAT_CD);
@@ -663,6 +662,21 @@ static void esp_do_dma(ESPState *s)
         esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
         esp_raise_drq(s);
 
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_SELATN | CMD_DMA:
+            if (fifo8_num_used(&s->cmdfifo) >= 1) {
+                /* First byte received, switch to command phase */
+                esp_set_phase(s, STAT_CD);
+                s->cmdfifo_cdb_offset = 1;
+
+                if (fifo8_num_used(&s->cmdfifo) > 1) {
+                    /* Process any additional command phase data */
+                    esp_do_dma(s);
+                }
+            }
+            break;
+        }
+
         /* ATN remains asserted until TC == 0 */
         if (esp_get_tc(s) == 0) {
             esp_set_phase(s, STAT_CD);
@@ -890,9 +904,6 @@ static void esp_do_nodma(ESPState *s)
 static void esp_pdma_cb(ESPState *s)
 {
     switch (s->pdma_cb) {
-    case SATN_PDMA_CB:
-        satn_pdma_cb(s);
-        break;
     case SATN_STOP_PDMA_CB:
         satn_stop_pdma_cb(s);
         break;
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index b727181da9..9945645837 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -152,7 +152,6 @@ struct SysBusESPState {
 
 /* PDMA callbacks */
 enum pdma_cb {
-    SATN_PDMA_CB = 0,
     SATN_STOP_PDMA_CB = 2,
     WRITE_RESPONSE_PDMA_CB = 3,
     DO_DMA_PDMA_CB = 4
-- 
2.39.2


