Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2126CD11BF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 19:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTMf-0000fZ-UB; Sun, 24 Mar 2024 15:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTMe-0000dR-C7
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:40 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTMc-0005OE-LQ
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MFYLWQfIU7b3foYufDjdCgiqAO0RlkeyE4Apvr6pzzM=; b=ugqRW+ophj8VClcRdkEpui5ov3
 4yZ3G2iuAB76eer8zejg4YiBN8/Q8YxXDJJtO9nrwv9kczGbgymMMlZFmN3PAWmEUz0ewtlHoojcl
 w3iGq/0tNrO+8iV5nXBozWop8jhculyKMNVk3RKzQYkdSLS988JE9tVEkFesong6P3vXVPGEAZmFi
 yivnNmz0c56oolVD25LjoK4Zu3MquSkkbbSxWFdijT+iZD0J3abKk+Jx0B2kSO7VMAHaM7ARFYUTZ
 UWkhF0s9zLiBvDpqWKMudcBlADpiJ68MTo6IrZn92RopFBJrDjzVAIQKPApDNlgcfSx1aS8qiBDhr
 2qmN8PN+2fag5jgtwZdxxA/JSGgKc4Nt6gWbQ2qu7/V+KIJmIYWeOwEeyM5bM/ayEljnmmfwhH96b
 1yC4iRslcQdMzzxCRfpoJa9ahCWovD6kKJHYg86x4Y4zYYWfLZ5Tx2Vq7RtNOkXfIoFmmytjXyZuT
 IdEC4Y9E+5Knh3dMqElj/3NfQ7QCqPLxnwxywk5YYFVwAPwPixbH8O9hBKF4efXAFzSfCJ4fVlINO
 bB8/yYaCvcBHSoBl+bvFIHXSQUlZqmFiD4SSglgEk8oMD+EfZjZDZSKsG1wuUMKILmODwgG/esGyd
 73QWAYGhND86nibQDymjLXA8f5rzeilQwJ8GDYo2U=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLU-0000dj-75; Sun, 24 Mar 2024 19:17:32 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:17:06 +0000
Message-Id: <20240324191707.623175-18-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 17/17] esp.c: remove explicit setting of DRQ within ESP
 state machine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now the esp_update_drq() is called for all reads/writes to the FIFO, there is
no need to manually raise and lower the DRQ signal.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/611
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1831
---
 hw/scsi/esp.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 04dfd90090..5d9b52632e 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -506,7 +506,6 @@ static void esp_dma_ti_check(ESPState *s)
     if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
         s->rregs[ESP_RINTR] |= INTR_BS;
         esp_raise_irq(s);
-        esp_lower_drq(s);
     }
 }
 
@@ -526,7 +525,6 @@ static void esp_do_dma(ESPState *s)
         } else {
             len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
-            esp_raise_drq(s);
         }
 
         fifo8_push_all(&s->cmdfifo, buf, len);
@@ -583,7 +581,6 @@ static void esp_do_dma(ESPState *s)
             len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
-            esp_raise_drq(s);
         }
         trace_esp_handle_ti_cmd(cmdlen);
         s->ti_size = 0;
@@ -615,7 +612,6 @@ static void esp_do_dma(ESPState *s)
                 len = MIN(s->async_len, ESP_FIFO_SZ);
                 len = MIN(len, fifo8_num_used(&s->fifo));
                 len = esp_fifo_pop_buf(s, s->async_buf, len);
-                esp_raise_drq(s);
             }
 
             s->async_buf += len;
@@ -667,7 +663,6 @@ static void esp_do_dma(ESPState *s)
                 /* Copy device data to FIFO */
                 len = MIN(len, fifo8_num_free(&s->fifo));
                 esp_fifo_push_buf(s, s->async_buf, len);
-                esp_raise_drq(s);
             }
 
             s->async_buf += len;
@@ -733,7 +728,6 @@ static void esp_do_dma(ESPState *s)
             if (fifo8_num_used(&s->fifo) < 2) {
                 s->rregs[ESP_RINTR] |= INTR_BS;
                 esp_raise_irq(s);
-                esp_lower_drq(s);
             }
             break;
         }
@@ -1021,9 +1015,6 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
     s->rregs[ESP_RINTR] |= INTR_BS;
     esp_raise_irq(s);
 
-    /* Ensure DRQ is set correctly for TC underflow or normal completion */
-    esp_dma_ti_check(s);
-
     if (s->current_req) {
         scsi_req_unref(s->current_req);
         s->current_req = NULL;
-- 
2.39.2


