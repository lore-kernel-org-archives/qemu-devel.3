Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCB5CD1299
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO3e-0005h8-Kx; Thu, 04 Apr 2024 10:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO3a-0005OH-6T
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:27:12 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO3W-0006A9-MN
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=blP8UFFj6QUHSfDOOmDrN4xK9P/1AP0mWNYec6Y20e0=; b=EGbKy2U6oeedsFTmODfxtT0dY5
 o8GYKJCKkOa+s9b2t9xidAnFFx1gssGDVeDjxk5BkyxuCRm4EV5vRteM9e6eIwQ1Nqdxxf6I19e3j
 +EM9ztdWEstwRyxy4Lt2TA+3PYuBnKqEGDRCEJesbgZ7Q5uymscBbQ1kZvwrA6S/Rz+UZ2R8/GzB5
 8oIEGvpVscGxSs1R5ZzEEJElZA+lFOq+NsO4OanYaHyHPGWPYkyuX9uy7F/hMdROfhmZ9AWda6blU
 Gg5XTX0WVty7vRzYtz4NijquUwcris5gJfN0I2razm+lwgFyVlsELMMkDaBauw0cFrR4LJHsTA5/6
 jrFrtcstpoogCvuX8572n6J3c6HYXkzn/UdUCyY2syxApBaBYwxLlWRKOJq+KxGhlkWoOm/ZqyRVd
 4sVw7rzb5THe36VtIwT4ioHkMY5JJHEZHTYjtLM+UlpenAPbo4ivC6dReNq7q6MoTj90yvPRo2WEr
 ZwOza0hNsg32PeMKPXs2wzrn+SzkYmH5VmrAKX7taqXZhvtpD/6VOhRULwtjjrRZLMzcSovrcVHvE
 jiBh+JQJ9yhURZw8Mjiu4XE0fDX2d7UH2016YWei7AwxDle0xQhnefbILNGvXZ6fvFzkgKYM4aGVk
 sxVIIeDyiv/VOj5lJLbuxG7Ud/ggIcy1T54kyxOH8=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2O-000Bmt-O1; Thu, 04 Apr 2024 15:26:00 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:39 +0100
Message-Id: <20240404142539.711134-18-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 17/17] esp.c: remove explicit setting of DRQ within ESP state
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
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240324191707.623175-18-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


