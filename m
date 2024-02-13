Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6A1C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0X-0004eJ-6B; Tue, 13 Feb 2024 15:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyzd-0003Fd-Qu
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:03:02 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyzY-00027o-5F
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wTIIn4LXMvqmJOH0ClVC7o3f1Q3UtQq1YSsuVb+bW9U=; b=038VrftRNVrLCE/+2pvD0dqIwr
 9z7svIqFiTpVpLdv4FX7rr/4/oUwt9peNkZHO6L07+yIpoUvMGatYITwhs72qCN2BuNlOtMp+OtG7
 70vse2i16HxiwRPjlxpFsuSpEZzYkR3msi2ITQTmk15d+khToRuS4kJZqkWvjWJKvpUrBAHsDsch4
 B+ZhN4VF+sZuR05tqD2F7roHkk9TkcZ2LrR6E55gEwKjZIHtY72bpDYBSDiOcJXDPY8mmUHtfEuvo
 UwbABdUMAiXeNbHsJdIT64op/zJQb9Aq4KAIY3/SFyVktEasgopXc1YT46555InB7OB5eLNIN3g/j
 fx6Mccyd/2xmys97BTeYZNoPUNzyTxQ1dVgwZkJlqJh0iU9d/shJBjs2N2b3BpI6MoMfrD9bw0VSc
 oThPItNODGpGPE7DpYT8BncO6rUBuPs83E3AdnF4NOwdnWfjjr9PMOBtH0zTXUbUjKQ4Vn6KsmEG7
 kO/S9fgBK5rDy5Jxr2GugpvyvxmnwQDfBNWs6Pj25PAS619atsnKfgBqW20p/cK+TWmmV/fYmA9W3
 JJEG85xZ7ZrfgDBg/C5GBS5puJ538hUfF3BIxe7IuoxkeM86RC5QLbKa1M8EszYQJFe+JtXI8y/24
 pc8MO2uBp/qI+ju2kHTVSOLpX+O1VYyk95RUZdQrU=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygv-0008m4-ET; Tue, 13 Feb 2024 19:43:44 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:24 +0000
Message-Id: <20240213194052.1162753-61-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 60/88] esp.c: use deferred interrupts for both DATA IN and DATA
 OUT phases
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

This brings DATA OUT transfers in line with DATA IN transfers by ensuring that
the guest visible function complete interrupt is only set once the SCSI layer
has returned.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-61-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index b6cf1b43db..d71465718c 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -248,10 +248,8 @@ static int esp_select(ESPState *s)
 
     /*
      * Note that we deliberately don't raise the IRQ here: this will be done
-     * either in do_command_phase() for DATA OUT transfers or by the deferred
-     * IRQ mechanism in esp_transfer_data() for DATA IN transfers
+     * either in esp_transfer_data() or esp_command_complete()
      */
-    s->rregs[ESP_RINTR] |= INTR_FC;
     s->rregs[ESP_RSEQ] = SEQ_CD;
     return 0;
 }
@@ -321,20 +319,17 @@ static void do_command_phase(ESPState *s)
     datalen = scsi_req_enqueue(s->current_req);
     s->ti_size = datalen;
     fifo8_reset(&s->cmdfifo);
+    s->data_ready = false;
     if (datalen != 0) {
         s->ti_cmd = 0;
+        /*
+         * Switch to DATA phase but wait until initial data xfer is
+         * complete before raising the command completion interrupt
+         */
         if (datalen > 0) {
-            /*
-             * Switch to DATA IN phase but wait until initial data xfer is
-             * complete before raising the command completion interrupt
-             */
-            s->data_ready = false;
             esp_set_phase(s, STAT_DI);
         } else {
             esp_set_phase(s, STAT_DO);
-            s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
-            esp_raise_irq(s);
-            esp_lower_drq(s);
         }
         scsi_req_continue(s->current_req);
         return;
@@ -832,9 +827,9 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
     case CMD_SELATN:
         /*
          * No data phase for sequencer command so raise deferred bus service
-         * interrupt
+         * and function complete interrupt
          */
-        s->rregs[ESP_RINTR] |= INTR_BS;
+        s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
         break;
     }
 
@@ -854,14 +849,13 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
 void esp_transfer_data(SCSIRequest *req, uint32_t len)
 {
     ESPState *s = req->hba_private;
-    int to_device = (esp_get_phase(s) == STAT_DO);
     uint32_t dmalen = esp_get_tc(s);
 
     trace_esp_transfer_data(dmalen, s->ti_size);
     s->async_len = len;
     s->async_buf = scsi_req_get_buf(req);
 
-    if (!to_device && !s->data_ready) {
+    if (!s->data_ready) {
         s->data_ready = true;
 
         switch (s->rregs[ESP_CMD]) {
@@ -869,6 +863,13 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
         case CMD_SEL:
         case CMD_SELATN | CMD_DMA:
         case CMD_SELATN:
+            /*
+             * Initial incoming data xfer is complete for sequencer command
+             * so raise deferred bus service and function complete interrupt
+             */
+             s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
+             break;
+
         case CMD_SELATNS | CMD_DMA:
         case CMD_SELATNS:
             /*
@@ -876,7 +877,6 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              * completion interrupt
              */
              s->rregs[ESP_RINTR] |= INTR_BS;
-             esp_raise_irq(s);
              break;
 
         case CMD_TI | CMD_DMA:
@@ -886,9 +886,10 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              * DATA phase
              */
             s->rregs[ESP_RINTR] |= INTR_BS;
-            esp_raise_irq(s);
             break;
         }
+
+        esp_raise_irq(s);
     }
 
     /*
-- 
2.39.2


