Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5678C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyfb-0003u6-9Q; Tue, 13 Feb 2024 14:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfU-0003PE-DZ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:12 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfN-0006KW-EF
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6uG9Tx27iG+4/+h2LAjDcJhD3VB945hLmfnIevydm4A=; b=k4FJG7GJUS+IFXCUpZ4kx8x8km
 +4AKVcuRdmbR7pahbYjubLx1RF8mga9pTC9uX/7yAx9zY/fhO8sk6xe++5HepfxAK3xte/ULFxYJR
 kJNjCIPFfF3A7Aj6hBuKZKF6pmqD5nZYl1XNzDBaQEMTgZac+dClt4q/zdebv4NraVjShYANRADQn
 7kPwMODIUqAMT0UbZkc3tDJjs5xocQBY0SprMFageu58rC9V3c8S/RR+NDzcp4kSHVMJ/c91bSNiv
 4BO7uSJMUpSwp8FF6al3mQZQPdfuXW2v6+bhbcwap058qnMz8oFTv6vdtFfX7yAiuV1I9NY6+x0J7
 6wqlkpj5Na9tarFp03NFi+NfqqZKcQsK5oKcb6zAjHiB21S+MzQThpL4Ec9+e3bsoFIQ+IXIerRoC
 FUtaX+Ofi10pQSYR5OsfLu3scaK2M1JlnLUtcpCxJbqjp+9/UCEi9x3wank7uCSXvqIfPhVn9WZmc
 yvtxxMBlNdcImbl+elqj50BtJIpJjqiE7BIYNo+YKsveYEa4nFUiCaSHjViOGdJtiHHVgcH1aZaj+
 0KrfKNXAz52pvgekl1/ne6npGrVLtcGee83pVxegmmYJ6irXjx3ulIXyWTIJ4q6wFnZ6KSKzPd7wG
 B7RNQky1fcicbl6W7NDOdex2sqHBY98Zt5qEr/+0U=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeU-0008m4-QK; Tue, 13 Feb 2024 19:41:14 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:39 +0000
Message-Id: <20240213194052.1162753-16-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 15/88] esp.c: remove another set of manual STAT_TC updates
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

Following on from the recent changes to when the TC is updated, it is now
possible to remove another set of manual STAT_TC updates so that its state
is now managed within esp_set_tc().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-16-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 3fc7417d7c..6fd5c8767a 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -513,7 +513,6 @@ static void handle_satn_stop(ESPState *s)
 static void write_response_pdma_cb(ESPState *s)
 {
     esp_set_phase(s, STAT_ST);
-    s->rregs[ESP_RSTAT] |= STAT_TC;
     s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
     s->rregs[ESP_RSEQ] = SEQ_CD;
     esp_raise_irq(s);
@@ -532,7 +531,6 @@ static void write_response(ESPState *s)
         if (s->dma_memory_write) {
             s->dma_memory_write(s->dma_opaque, buf, 2);
             esp_set_phase(s, STAT_ST);
-            s->rregs[ESP_RSTAT] |= STAT_TC;
             s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
             s->rregs[ESP_RSEQ] = SEQ_CD;
         } else {
@@ -550,10 +548,8 @@ static void write_response(ESPState *s)
 
 static void esp_dma_done(ESPState *s)
 {
-    s->rregs[ESP_RSTAT] |= STAT_TC;
     s->rregs[ESP_RINTR] |= INTR_BS;
     s->rregs[ESP_RFLAGS] = 0;
-    esp_set_tc(s, 0);
     esp_raise_irq(s);
 }
 
@@ -592,7 +588,6 @@ static void do_dma_pdma_cb(ESPState *s)
              */
             s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
             esp_set_phase(s, STAT_CD);
-            s->rregs[ESP_RSTAT] |= STAT_TC;
             s->rregs[ESP_RSEQ] = SEQ_CD;
             s->rregs[ESP_RINTR] |= INTR_BS;
             esp_raise_irq(s);
@@ -699,7 +694,6 @@ static void esp_do_dma(ESPState *s)
              */
             s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
             esp_set_phase(s, STAT_CD);
-            s->rregs[ESP_RSTAT] |= STAT_TC;
             s->rregs[ESP_RSEQ] = SEQ_CD;
             s->rregs[ESP_RINTR] |= INTR_BS;
             esp_raise_irq(s);
@@ -829,7 +823,6 @@ static void esp_do_nodma(ESPState *s)
              */
             s->cmdfifo_cdb_offset = fifo8_num_used(&s->cmdfifo);
             esp_set_phase(s, STAT_CD);
-            s->rregs[ESP_RSTAT] |= STAT_TC;
             s->rregs[ESP_RSEQ] = SEQ_CD;
             s->rregs[ESP_RINTR] |= INTR_BS;
             esp_raise_irq(s);
@@ -952,7 +945,6 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
          * completion interrupt
          */
         s->data_in_ready = true;
-        s->rregs[ESP_RSTAT] |= STAT_TC;
         s->rregs[ESP_RINTR] |= INTR_BS;
         esp_raise_irq(s);
     }
@@ -997,7 +989,6 @@ static void handle_ti(ESPState *s)
     if (s->dma) {
         dmalen = esp_get_tc(s);
         trace_esp_handle_ti(dmalen);
-        s->rregs[ESP_RSTAT] &= ~STAT_TC;
         esp_do_dma(s);
     } else {
         trace_esp_handle_ti(s->ti_size);
@@ -1152,7 +1143,6 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
                      * of the FIFO so switch to status phase
                      */
                     esp_set_phase(s, STAT_ST);
-                    s->rregs[ESP_RSTAT] |= STAT_TC;
                 }
             }
             s->rregs[ESP_FIFO] = esp_fifo_pop(&s->fifo);
-- 
2.39.2


