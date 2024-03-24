Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7445DC47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 19:19:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTLq-0007Pb-Ur; Sun, 24 Mar 2024 15:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLq-0007PM-1S
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLl-0005KM-Q7
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cMyuEOJ1+vREuuwStaw5g0LB6AfeqF4Tk/Im6T4lfrQ=; b=ImsQ9ClOVv4oRRHuu6eVnlFFHS
 /f23pIcyqs1X8Ei1jbJ/Z8SVWEtTZhE9mSxsWPRT0E38Rz3xwlVvHnNjexezHAF9kgc1dix5sKhOx
 uvtJYjnSpo9aT6DCEahVgbhL53mp2ietSn4VTY3ONlpgFUWi3Dlg9TlI13M8PvO6MDM7lVXHVLqAN
 wqxcFZfefGxFCGwbP3gumbHgJwZF05dcJuIS2EjMxBdadXUVbh5zTuX0LQK8zztD7HlQxykj19p/m
 OOE9qv2tMpu7h70aXabcxst9pJsfjrZMTSSjtUTGNcJ0zVd2axR1IEbz5V/l6wE1cY0Me3lBCuH2q
 gqHHW13N4UgK7UpihYnb4yZi0OICF6nirLHIb8EhO9AUPzzviWTz8R2zH6d9fedO8m+dI12a8a58g
 bnflOu2oLwJbIQYjEHw0pDMsqCHRjyZDsgaE42KM/R2Dma1s8c071qsAN8RwMoCsMGjhBdyLMprJr
 jSEc2HYTCc/PgQmhuHcs8IlkHNyUcuJSuMbcqE02/uqIw5wUsvHmVF1F528lHjK+Wvq5kAAaanaFX
 bOaKyhfG/JgnddsyfjlLux6XCsWX6iN69y9DGkOuZDN0TOf80IkRjz87izc8EpseBtxbBGIXG4rD9
 XRyRIw2JyO/jNfcYuSRngLeuyELRKMSLUIWrzMhdk=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTKl-0000dj-8S; Sun, 24 Mar 2024 19:16:47 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:16:55 +0000
Message-Id: <20240324191707.623175-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 06/17] esp.c: change esp_fifo_pop() to take ESPState
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

Now that all users of esp_fifo_pop() operate on the main FIFO there is no need
to pass the FIFO explicitly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/esp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 7e3338815b..d474268438 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -116,13 +116,13 @@ static void esp_fifo_push(ESPState *s, uint8_t val)
     fifo8_push(&s->fifo, val);
 }
 
-static uint8_t esp_fifo_pop(Fifo8 *fifo)
+static uint8_t esp_fifo_pop(ESPState *s)
 {
-    if (fifo8_is_empty(fifo)) {
+    if (fifo8_is_empty(&s->fifo)) {
         return 0;
     }
 
-    return fifo8_pop(fifo);
+    return fifo8_pop(&s->fifo);
 }
 
 static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
@@ -217,7 +217,7 @@ static uint8_t esp_pdma_read(ESPState *s)
 {
     uint8_t val;
 
-    val = esp_fifo_pop(&s->fifo);
+    val = esp_fifo_pop(s);
     return val;
 }
 
@@ -1184,7 +1184,7 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
 
     switch (saddr) {
     case ESP_FIFO:
-        s->rregs[ESP_FIFO] = esp_fifo_pop(&s->fifo);
+        s->rregs[ESP_FIFO] = esp_fifo_pop(s);
         val = s->rregs[ESP_FIFO];
         break;
     case ESP_RINTR:
-- 
2.39.2


