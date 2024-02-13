Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA693C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyfM-00033K-Es; Tue, 13 Feb 2024 14:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfL-00033C-8w
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:03 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfJ-0006K7-Gk
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1XhA0oV5S1LQeoJiXw+URVI0N9FdYJbeufHJsP1rm8U=; b=AXisTelhoXFLKBBLDAM7uVd37A
 5rmlSv8P1P/GN2x2xJR9zzWPPi6v7qsS+kQ7MWMXZRXah29w4ZllxyQ+c+697ybrobSVpOC4v/9Lk
 9uCFSqm7rlxDi5IM1m59wv+9kh5HMk2WsPMHyHVPyndGlCONdkJvqFybvH+oc7FwFvBC9KIMJLxLA
 8Yza7vPQrqsX6kdhB+e8rkj1vlMfce1MQ4ddQo9cccxkB8S30zHKRnvS3lW2GAWs6fY9zWehC4SHn
 I73N68UjdDaVk70FDembGsjjZ2UeKVPHMjdgly1KSA+XhpLk7MtvQQo1Ga68qaIawia3i9B6Oh6b8
 Tye17c9/aPK20nLqfuhPkXf+Cr473S1L2WKC2LRF1VdNo1qe2Bbfk/SXolNOox5EyFWWiiz7gb+r/
 OPWNqWrS2b1QHkukjjjnfe3SjjvCXO9XqCDapnjpo4y3NK8FIUVSOFBvB84E+P2aojs7G7lMSt85w
 tUKNefQfQpWYzOD3Jq2qN2WywuURYx/Vrv6HhG0MFSf70TqNko9b7MD3iNgJNGEdtlI9I3mhJqoAQ
 IZxJl9axUJmhuZv3BUTaFPsh6I0hFZqAALfkGrGdvSP0RC14oD5h3NNYb6/Z1i9vqZQRHhAZbhjXA
 V7pLKOuRH/uuqsEpwiLHvyA9qoXm9xj0ohP7lTIxw=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeT-0008m4-Ph; Tue, 13 Feb 2024 19:41:10 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:38 +0000
Message-Id: <20240213194052.1162753-15-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 14/88] esp.c: introduce esp_set_phase() helper function
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

This function is used to set the current SCSI bus phase in the ESP_RSTAT register
without affecting any of flag bits.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-15-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c        | 51 ++++++++++++++++++++++++++++++--------------
 hw/scsi/trace-events |  1 +
 2 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f08b816aba..3fc7417d7c 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -183,6 +183,19 @@ static uint32_t esp_get_stc(ESPState *s)
     return dmalen;
 }
 
+static const char *esp_phase_names[8] = {
+    "DATA OUT", "DATA IN", "COMMAND", "STATUS",
+    "(reserved)", "(reserved)", "MESSAGE OUT", "MESSAGE IN"
+};
+
+static void esp_set_phase(ESPState *s, uint8_t phase)
+{
+    s->rregs[ESP_RSTAT] &= ~7;
+    s->rregs[ESP_RSTAT] |= phase;
+
+    trace_esp_set_phase(esp_phase_names[phase]);
+}
+
 static uint8_t esp_pdma_read(ESPState *s)
 {
     uint8_t val;
@@ -316,9 +329,9 @@ static void do_command_phase(ESPState *s)
              * complete before raising the command completion interrupt
              */
             s->data_in_ready = false;
-            s->rregs[ESP_RSTAT] |= STAT_DI;
+            esp_set_phase(s, STAT_DI);
         } else {
-            s->rregs[ESP_RSTAT] |= STAT_DO;
+            esp_set_phase(s, STAT_DO);
             s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
             esp_raise_irq(s);
             esp_lower_drq(s);
@@ -394,7 +407,7 @@ static void handle_satn(ESPState *s)
         s->do_cmd = 1;
         /* Target present, but no cmd yet - switch to command phase */
         s->rregs[ESP_RSEQ] = SEQ_CD;
-        s->rregs[ESP_RSTAT] = STAT_CD;
+        esp_set_phase(s, STAT_CD);
     }
 }
 
@@ -439,7 +452,7 @@ static void handle_s_without_atn(ESPState *s)
         s->do_cmd = 1;
         /* Target present, but no cmd yet - switch to command phase */
         s->rregs[ESP_RSEQ] = SEQ_CD;
-        s->rregs[ESP_RSTAT] = STAT_CD;
+        esp_set_phase(s, STAT_CD);
     }
 }
 
@@ -457,7 +470,8 @@ static void satn_stop_pdma_cb(ESPState *s)
         trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
         s->do_cmd = 1;
         s->cmdfifo_cdb_offset = 1;
-        s->rregs[ESP_RSTAT] = STAT_TC | STAT_CD;
+        esp_set_phase(s, STAT_CD);
+        s->rregs[ESP_RSTAT] |= STAT_TC;
         s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
         s->rregs[ESP_RSEQ] = SEQ_CD;
         esp_raise_irq(s);
@@ -481,7 +495,7 @@ static void handle_satn_stop(ESPState *s)
         trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
         s->do_cmd = 1;
         s->cmdfifo_cdb_offset = 1;
-        s->rregs[ESP_RSTAT] = STAT_MO;
+        esp_set_phase(s, STAT_MO);
         s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
         s->rregs[ESP_RSEQ] = SEQ_MO;
         esp_raise_irq(s);
@@ -492,13 +506,14 @@ static void handle_satn_stop(ESPState *s)
         s->do_cmd = 1;
         /* Target present, switch to message out phase */
         s->rregs[ESP_RSEQ] = SEQ_MO;
-        s->rregs[ESP_RSTAT] = STAT_MO;
+        esp_set_phase(s, STAT_MO);
     }
 }
 
 static void write_response_pdma_cb(ESPState *s)
 {
-    s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
+    esp_set_phase(s, STAT_ST);
+    s->rregs[ESP_RSTAT] |= STAT_TC;
     s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
     s->rregs[ESP_RSEQ] = SEQ_CD;
     esp_raise_irq(s);
@@ -516,7 +531,8 @@ static void write_response(ESPState *s)
     if (s->dma) {
         if (s->dma_memory_write) {
             s->dma_memory_write(s->dma_opaque, buf, 2);
-            s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
+            esp_set_phase(s, STAT_ST);
+            s->rregs[ESP_RSTAT] |= STAT_TC;
             s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
             s->rregs[ESP_RSEQ] = SEQ_CD;
         } else {
@@ -575,7 +591,8 @@ static void do_dma_pdma_cb(ESPState *s)
              * and then switch to command phase
              */
             s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
-            s->rregs[ESP_RSTAT] = STAT_TC | STAT_CD;
+            esp_set_phase(s, STAT_CD);
+            s->rregs[ESP_RSTAT] |= STAT_TC;
             s->rregs[ESP_RSEQ] = SEQ_CD;
             s->rregs[ESP_RINTR] |= INTR_BS;
             esp_raise_irq(s);
@@ -681,7 +698,8 @@ static void esp_do_dma(ESPState *s)
              * and then switch to command phase
              */
             s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
-            s->rregs[ESP_RSTAT] = STAT_TC | STAT_CD;
+            esp_set_phase(s, STAT_CD);
+            s->rregs[ESP_RSTAT] |= STAT_TC;
             s->rregs[ESP_RSEQ] = SEQ_CD;
             s->rregs[ESP_RINTR] |= INTR_BS;
             esp_raise_irq(s);
@@ -810,7 +828,8 @@ static void esp_do_nodma(ESPState *s)
              * and then switch to command phase
              */
             s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
-            s->rregs[ESP_RSTAT] = STAT_TC | STAT_CD;
+            esp_set_phase(s, STAT_CD);
+            s->rregs[ESP_RSTAT] |= STAT_TC;
             s->rregs[ESP_RSEQ] = SEQ_CD;
             s->rregs[ESP_RINTR] |= INTR_BS;
             esp_raise_irq(s);
@@ -904,8 +923,7 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
      * transfers from the target the last byte is still in the FIFO
      */
     if (s->ti_size == 0) {
-        s->rregs[ESP_RSTAT] &= ~7;
-        s->rregs[ESP_RSTAT] |= STAT_ST;
+        esp_set_phase(s, STAT_ST);
         esp_dma_done(s);
         esp_lower_drq(s);
     }
@@ -1065,7 +1083,7 @@ static void esp_run_cmd(ESPState *s)
         trace_esp_mem_writeb_cmd_iccs(cmd);
         write_response(s);
         s->rregs[ESP_RINTR] |= INTR_FC;
-        s->rregs[ESP_RSTAT] |= STAT_MI;
+        esp_set_phase(s, STAT_MI);
         break;
     case CMD_MSGACC:
         trace_esp_mem_writeb_cmd_msgacc(cmd);
@@ -1133,7 +1151,8 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
                      * The last byte of a non-DMA transfer has been read out
                      * of the FIFO so switch to status phase
                      */
-                    s->rregs[ESP_RSTAT] = STAT_TC | STAT_ST;
+                    esp_set_phase(s, STAT_ST);
+                    s->rregs[ESP_RSTAT] |= STAT_TC;
                 }
             }
             s->rregs[ESP_FIFO] = esp_fifo_pop(&s->fifo);
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index bdd4e2c7c7..d72f741ed8 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -197,6 +197,7 @@ esp_mem_writeb_cmd_selatns(uint32_t val) "Select with ATN & stop (0x%2.2x)"
 esp_mem_writeb_cmd_ensel(uint32_t val) "Enable selection (0x%2.2x)"
 esp_mem_writeb_cmd_dissel(uint32_t val) "Disable selection (0x%2.2x)"
 esp_mem_writeb_cmd_ti(uint32_t val) "Transfer Information (0x%2.2x)"
+esp_set_phase(const char *phase) "setting bus phase to %s"
 
 # esp-pci.c
 esp_pci_error_invalid_dma_direction(void) "invalid DMA transfer direction"
-- 
2.39.2


