Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A0CC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 21:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb5Qx-0006hY-GP; Fri, 16 Feb 2024 16:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5Qo-0006Eq-Cy
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:39 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5Qm-0005Qp-Pt
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TndlSOqHn8wvYTLw9S+LlH2H/zQCMiOOADBR2HO3ZwI=; b=vlaqvMaHUwUn6PaOLHfHk7a/Ag
 0se9z/ZA3HExjdnvRggnT6qL9cM+7ONfldUWxWbD/KwOnufgrmsDdsyYW9Y7VWMdmAtTJqAHOsyiw
 bKBkOZRF8b3RXeaFSqVfZmN1MIfgO9mlr8+22CzbRoBdgUcFenuduAWfRCS3lliQeAhvhV1vE/w3S
 rtISiOP9ZPEZvBFReApKJ0nLTL7rC06gO79IOT3A6VkGsYOUmZSvOg8z9DYdNlBAz4RlEJjFGXcbD
 ZV2vi4swJjpbqO+44aRK39uJEq+XNLqOoyKmS+NwphOMy1XWuw5qNsHTWc9+DguVH2IMWz8MdGBgd
 0nWUUymdvTZlgR1KeAp3eAdJUkLxKNzJZTjGF0jZgpYzppY392xPv+RtmMxxuXhMT4PEgmi7OrS3y
 7Plq3Hzopg9Nmv0ps3Xaak7sLYGnovQ2PqOgOcy/tthjeIHYS8lu4+iDG+nLznsOnGxjtE8om0OqS
 eZ+J9OGzDCkrGSA7uJq547lNbF47h7OtO5KNcpPsbK3YgUuWnO2IAJQDSnibwSbVGvPl1Zpitg9IP
 xHwP0A0yGlLC19YFX1Yales7TwNrMiIm++wQbrj4nztje11Hmu97U1PUIMGSBv94+rO4ZjeH4eS1W
 M3JbgjbKZ+9ySstyU2OVvkAyHxfZI3BWLqeetcJVk=;
Received: from [2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5Pv-0000vT-AM; Fri, 16 Feb 2024 21:06:47 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Fri, 16 Feb 2024 21:06:33 +0000
Message-Id: <20240216210633.1376066-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
References: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 13/13] esp.c: remove explicit setting of DRQ within ESP state
 machine
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

Now the esp_update_drq() is called for all reads/writes to the FIFO, there is
no need to manually raise and lower the DRQ signal.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/611
Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1831
---
 hw/scsi/esp.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index a147509885..2f45bae940 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -495,7 +495,6 @@ static void esp_dma_ti_check(ESPState *s)
     if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
         s->rregs[ESP_RINTR] |= INTR_BS;
         esp_raise_irq(s);
-        esp_lower_drq(s);
     }
 }
 
@@ -515,7 +514,6 @@ static void esp_do_dma(ESPState *s)
         } else {
             len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
-            esp_raise_drq(s);
         }
 
         fifo8_push_all(&s->cmdfifo, buf, len);
@@ -572,7 +570,6 @@ static void esp_do_dma(ESPState *s)
             len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
-            esp_raise_drq(s);
         }
         trace_esp_handle_ti_cmd(cmdlen);
         s->ti_size = 0;
@@ -604,7 +601,6 @@ static void esp_do_dma(ESPState *s)
                 len = MIN(s->async_len, ESP_FIFO_SZ);
                 len = MIN(len, fifo8_num_used(&s->fifo));
                 len = esp_fifo_pop_buf(s, s->async_buf, len);
-                esp_raise_drq(s);
             }
 
             s->async_buf += len;
@@ -656,7 +652,6 @@ static void esp_do_dma(ESPState *s)
                 /* Copy device data to FIFO */
                 len = MIN(len, fifo8_num_free(&s->fifo));
                 esp_fifo_push_buf(s, s->async_buf, len);
-                esp_raise_drq(s);
             }
 
             s->async_buf += len;
@@ -722,7 +717,6 @@ static void esp_do_dma(ESPState *s)
             if (fifo8_num_used(&s->fifo) < 2) {
                 s->rregs[ESP_RINTR] |= INTR_BS;
                 esp_raise_irq(s);
-                esp_lower_drq(s);
             }
             break;
         }
@@ -1011,9 +1005,6 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
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


