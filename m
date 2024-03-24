Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BF3CD11BF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 19:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTLj-0007Om-TZ; Sun, 24 Mar 2024 15:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLi-0007OH-3W
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:42 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLf-0005Ib-Ny
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ci6+5b/zrByBEGWIujEIPiiZF4s1D1uzyPAnTdJyzjQ=; b=OMD7FKfDlBHW2p/1Pnp0S5g570
 ZJfMmTGuj6rk9te5WzkipWTwvpWcZiKkEXDtcZOgsYXljTtXOqR6yi70iAJhybOh3cJWWz89Z4yeI
 1H1dJA5zUbDsaujVHfwwSotrHHQwqHIRhwpEWC0KWvUGETpyZAXUdIYwVrtxJOn5FSHUzI1ybuyLP
 X+ipbfGpvDRVosMw9QgH+CFe3muroP3EZtVFCujcd1DqrY+rWLu1GJRG/UB76ajmzUB9abE+jABKU
 ZfTdBH4r9J4joC/RQqikcbhFJJlTWIUaQleg/2oiTBGb823r/i0XnY76dyBxPSDoQuX8yAK4T2foB
 iA6IAEh18Wr65ZlUOsbOlzq/NsVYGYczZ50St40EFRXKW4LO3VNkEREfqmXH9CuIEtomD2Ok7+b35
 QYSdYoZRId2ZeZ0nQKt6w+2hx5kI2Iu29HZ4p/KcANQOZ7BjvrPRfYV7ITRHyfU6WcxAvEpcEWF0y
 4ZTy3MR6rDl8aFD7ZYRrBCdk3iZ44f0V92+7oJymlTJNRKdEULPRu8ArvBblawZa9+/Ewla7snQK9
 dGrGOV+XZk2Sl+BSzIDxx3S6nTB5zktTlr0eJAv6pj89lPCnAjbXRj7aHC2pPJ7EfmStnSmJk2fqf
 EpCdlFPnZFto+Lx3if6oiN5KZqvQ/YW0537jl59oc=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTKh-0000dj-2F; Sun, 24 Mar 2024 19:16:43 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:16:54 +0000
Message-Id: <20240324191707.623175-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 05/17] esp.c: change esp_fifo_push() to take ESPState
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

Now that all users of esp_fifo_push() operate on the main FIFO there is no need
to pass the FIFO explicitly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 5b169b3720..7e3338815b 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -106,14 +106,14 @@ void esp_request_cancelled(SCSIRequest *req)
     }
 }
 
-static void esp_fifo_push(Fifo8 *fifo, uint8_t val)
+static void esp_fifo_push(ESPState *s, uint8_t val)
 {
-    if (fifo8_num_used(fifo) == fifo->capacity) {
+    if (fifo8_num_used(&s->fifo) == s->fifo.capacity) {
         trace_esp_error_fifo_overrun();
         return;
     }
 
-    fifo8_push(fifo, val);
+    fifo8_push(&s->fifo, val);
 }
 
 static uint8_t esp_fifo_pop(Fifo8 *fifo)
@@ -229,7 +229,7 @@ static void esp_pdma_write(ESPState *s, uint8_t val)
         return;
     }
 
-    esp_fifo_push(&s->fifo, val);
+    esp_fifo_push(s, val);
 
     dmalen--;
     esp_set_tc(s, dmalen);
@@ -1240,7 +1240,7 @@ void esp_reg_write(ESPState *s, uint32_t saddr, uint64_t val)
         break;
     case ESP_FIFO:
         if (!fifo8_is_full(&s->fifo)) {
-            esp_fifo_push(&s->fifo, val);
+            esp_fifo_push(s, val);
         }
         esp_do_nodma(s);
         break;
-- 
2.39.2


