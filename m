Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B1CC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZygG-0007Zl-Nm; Tue, 13 Feb 2024 14:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygF-0007RQ-2Q
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:59 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygC-0006Qm-TK
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P1NfptW+n1Q4+bwv4LEHKcXl0PIqkO0R8wltEoCkpow=; b=RqBs9ULl5Grphoq7R2ZGha0x83
 ZVbdE5MooTsc3mti7UKB8Rt5/HTvDL2SKjAQ1NGuqaztNzsBlZcEmd7DK90Z/n16WhHkg7s6ws+e2
 o1Vd7FxZLngFY7aZb6MJfdMNkk5ZkWpgGw+xUQGdwoLb3DeBZhHqcJS54Fzefe3ULXijCm+iPXrJe
 awJ0nUweGrmm1Nk+0JYeT9coqDXbDL4CEruFhOKOgtg0b7NJaM6c/e54RdF6hxZQPx1gZzDJByJL5
 efQOlhJCY+92PR2S1MfSaBXa3x1z67zOS8JSfmBSQujG9uSpr4Utn4gMYGg705eHcGjzeEWs7Ndpa
 7/smiGe6RToASNyeSzw3eKkj0OSn+OO9jD8xpb16gpy8GLtT0MuqiQ9buE0gPCqwt2XYM5Z47/maE
 KT1Y+KEvaJbLFOUsoOPtZ9SvqQAwLSeeTnItG6cEMKBeiQDULhGZa8KrjHGf92vKExjqDJYQusQr+
 ICNZFJpGprFKKi7fzM21thRViwsymI6lqRoJh3RuuF0R+mH9Mu8Ep5qWfLLXUrLbm6tiqZ64AbPBT
 bwt5VVFHFQs86wkW38CMtxcBaJqegamouj8hkvTzCLvJgRynM+stSULoKTzvMNCG4ThKClLoHEkTH
 zh4dzsuwqfgjWphnAFYiaf2DFrOUs3om+6l1t+SlM=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfK-0008m4-4H; Tue, 13 Feb 2024 19:42:06 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:55 +0000
Message-Id: <20240213194052.1162753-32-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 31/88] esp.c: rename esp_dma_done() to esp_dma_ti_check()
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

This is because a single DMA request can be transferred using multiple TI
commands, and so a TC equal to zero may not represent the completion of
the SCSI DMA command.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-32-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 4d58a49c73..14c6d05253 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -543,7 +543,7 @@ static void write_response(ESPState *s)
     esp_raise_irq(s);
 }
 
-static void esp_dma_done(ESPState *s)
+static void esp_dma_ti_check(ESPState *s)
 {
     if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
         s->rregs[ESP_RINTR] |= INTR_BS;
@@ -613,7 +613,7 @@ static void do_dma_pdma_cb(ESPState *s)
             return;
         }
 
-        esp_dma_done(s);
+        esp_dma_ti_check(s);
     } else {
         if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
             /* Defer until the scsi layer has completed */
@@ -622,7 +622,7 @@ static void do_dma_pdma_cb(ESPState *s)
             return;
         }
 
-        esp_dma_done(s);
+        esp_dma_ti_check(s);
 
         /* Copy device data to FIFO */
         len = MIN(s->async_len, esp_get_tc(s));
@@ -708,7 +708,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            esp_dma_done(s);
+            esp_dma_ti_check(s);
         } else {
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
@@ -719,7 +719,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            esp_dma_done(s);
+            esp_dma_ti_check(s);
         }
     } else {
         if (s->dma_memory_write) {
@@ -736,7 +736,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            esp_dma_done(s);
+            esp_dma_ti_check(s);
         } else {
             /* Copy device data to FIFO */
             len = MIN(len, fifo8_num_free(&s->fifo));
@@ -754,7 +754,7 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            esp_dma_done(s);
+            esp_dma_ti_check(s);
         }
     }
 }
@@ -890,7 +890,7 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
          * this)
          */
         esp_set_tc(s, 0);
-        esp_dma_done(s);
+        esp_dma_ti_check(s);
     } else {
         /*
          * Transfer truncated: raise INTR_BS to indicate early change of
@@ -939,7 +939,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
 
     if (s->ti_cmd == (CMD_TI | CMD_DMA)) {
         /* When the SCSI layer returns more data, raise deferred INTR_BS */
-        esp_dma_done(s);
+        esp_dma_ti_check(s);
 
         esp_do_dma(s);
     } else if (s->ti_cmd == CMD_TI) {
-- 
2.39.2


