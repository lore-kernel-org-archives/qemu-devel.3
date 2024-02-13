Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E4CC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0N-0004GO-Ny; Tue, 13 Feb 2024 15:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyY-0002IE-UG
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:57 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyX-0001we-Cf
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hViVfptURSaNNRc4wl0KKMQuepAQGRlsU+bgrRPmQ1Q=; b=AP80zht16pDQYnIsE+OJPKx7AW
 AaFmLrSNkzt+sFZp+9Pyti19lEKgakXGJKCg8uUrP3axBWdXPj6//ARrp2wA9yb+8yLCvAANM0LOV
 H4VBCmhj2Cz6Y/vG/08uIsQygvy1pqwXN4mZyIxEcZvSXJD/SwgOEFgME5gIOUC97LoW57USU536z
 dielfcEDlmF5Hzt2y6DxZVvec5L1PVGfIICp/OKix5GTkELQ0Cunh8uyHJIz0ssHlrUFQOkeR75JX
 l/awl+u4iZO1b6i1zObYDIRdEHzyuVl0ww3OfzSni5ShRCutIm3gkkYncoiZHyFP+4DN5eh1mMxZp
 ann2yxZJ03iIAZ53HJ7laHLEnhsMs2ND3P358YkWgQLGNsnI9bCAlGZTsFekZFhOt58NkTNmakPCb
 FZBiscavta90C6EyPZo6gOeyK62yDUicYtqcYb4DgAbE3azGX0UZVwutj6y06kDzlzt0INTKvnYQv
 6eYvMYyQO+QzSPSvogd0RFmplJPLVNpt07EbM+koLxVm9U3IHP3NDCs7oDtuCNUM/R64xyMjd0FrK
 WWEwTqrMx9/ibfQXLWzaRBtQLl10vrsodaXVXF1g5kMdOnutk+KRXgIgz4uJMtA4F2ZVyu6UcrKav
 eIj1oEjVNZ9HoFHhdWtIvsyBXt6zs3p75sM6HTu3I=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygV-0008m4-EA; Tue, 13 Feb 2024 19:43:19 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:16 +0000
Message-Id: <20240213194052.1162753-53-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 52/88] esp.c: move CMD_SELATNS end of command logic to
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

The special logic in satn_stop_pdma_cb() is now no longer required since
esp_do_dma() can be used as a direct replacement.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-53-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 82 +++++++++++++++++++++----------------------
 include/hw/scsi/esp.h |  1 -
 2 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 3cf8b2b4eb..29e3869173 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -418,54 +418,31 @@ static void handle_s_without_atn(ESPState *s)
     }
 }
 
-static void satn_stop_pdma_cb(ESPState *s)
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
-        trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
-        s->cmdfifo_cdb_offset = 1;
-        esp_set_phase(s, STAT_CD);
-        s->rregs[ESP_RSTAT] |= STAT_TC;
-        s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
-        s->rregs[ESP_RSEQ] = SEQ_CD;
-        esp_raise_irq(s);
-    }
-}
-
 static void handle_satn_stop(ESPState *s)
 {
-    int32_t cmdlen;
-
     if (s->dma && !s->dma_enabled) {
         s->dma_cb = handle_satn_stop;
         return;
     }
-    esp_set_pdma_cb(s, SATN_STOP_PDMA_CB);
+    esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
     if (esp_select(s) < 0) {
         return;
     }
-    cmdlen = get_cmd(s, 1);
-    if (cmdlen > 0) {
-        trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
-        s->cmdfifo_cdb_offset = 1;
-        esp_set_phase(s, STAT_MO);
-        s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
-        s->rregs[ESP_RSEQ] = SEQ_MO;
-        esp_raise_irq(s);
-    } else if (cmdlen == 0) {
-        if (s->dma) {
-            esp_raise_drq(s);
+
+    esp_set_phase(s, STAT_MO);
+    s->rregs[ESP_RSEQ] = SEQ_MO;
+
+    if (s->dma) {
+        esp_do_dma(s);
+    } else {
+        if (get_cmd(s, 1)) {
+            trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
+
+            /* Raise command completion interrupt */
+            s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
+            s->rregs[ESP_RSEQ] = SEQ_MO;
+            esp_raise_irq(s);
         }
-        /* Target present, switch to message out phase */
-        s->rregs[ESP_RSEQ] = SEQ_MO;
-        esp_set_phase(s, STAT_MO);
     }
 }
 
@@ -554,6 +531,19 @@ static void do_dma_pdma_cb(ESPState *s)
             }
             break;
 
+        case CMD_SELATNS | CMD_DMA:
+            if (fifo8_num_used(&s->cmdfifo) == 1) {
+                /* First byte received, stop in message out phase */
+                esp_set_phase(s, STAT_CD);
+                s->cmdfifo_cdb_offset = 1;
+
+                /* Raise command completion interrupt */
+                s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
+                s->rregs[ESP_RSEQ] = SEQ_CD;
+                esp_raise_irq(s);
+            }
+            break;
+
         case CMD_TI | CMD_DMA:
             /* ATN remains asserted until TC == 0 */
             if (esp_get_tc(s) == 0) {
@@ -676,6 +666,19 @@ static void esp_do_dma(ESPState *s)
             }
             break;
 
+        case CMD_SELATNS | CMD_DMA:
+            if (fifo8_num_used(&s->cmdfifo) == 1) {
+                /* First byte received, stop in message out phase */
+                esp_set_phase(s, STAT_CD);
+                s->cmdfifo_cdb_offset = 1;
+
+                /* Raise command completion interrupt */
+                s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
+                s->rregs[ESP_RSEQ] = SEQ_CD;
+                esp_raise_irq(s);
+            }
+            break;
+
         case CMD_TI | CMD_DMA:
             /* ATN remains asserted until TC == 0 */
             if (esp_get_tc(s) == 0) {
@@ -906,9 +909,6 @@ static void esp_do_nodma(ESPState *s)
 static void esp_pdma_cb(ESPState *s)
 {
     switch (s->pdma_cb) {
-    case SATN_STOP_PDMA_CB:
-        satn_stop_pdma_cb(s);
-        break;
     case WRITE_RESPONSE_PDMA_CB:
         write_response_pdma_cb(s);
         break;
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 9945645837..a4b2ed115c 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -152,7 +152,6 @@ struct SysBusESPState {
 
 /* PDMA callbacks */
 enum pdma_cb {
-    SATN_STOP_PDMA_CB = 2,
     WRITE_RESPONSE_PDMA_CB = 3,
     DO_DMA_PDMA_CB = 4
 };
-- 
2.39.2


