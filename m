Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C9ECD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO3a-0005LG-13; Thu, 04 Apr 2024 10:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO3Q-0005El-Sm
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:27:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO3P-00069c-0h
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q2mBq0lw1TxpTrwqJqbG8cvHvyVyuZsc/q44zAk+RD4=; b=Y92NwxWtJAHiVRlab2oeQ8iqcI
 tJg/IBBsv4KVpCgtmhfLlhDvDNTVXpM8u04o4fPGHPCEg5vxssrzZBC/Q90qP6/fEJzpQSIKXi9Kz
 Li4rKbVI5KByEW35E2KUXxRp/EvOJFfb8Rqi/WZezIaDfDkuUI78Eq/S82Y7gz4tWrMau0dQviYfV
 3SR1qcb+xLlmtbIwyeLlC4Mw2VK0LKPOIRU9vwzsJ4bA+88ToEFkDWQv8+uOKrqVQKGwVqhCKtjwf
 v0PiD6OvSy76IaAAlZywUW165OXZRo0UZb5OKloeOKMwOMt0LeVhPGQL4aQn3JH89MDW4ywrKbXT0
 TKdRCKq1DxJEqpqh+IjiiwM1laFPEDSry2v2Ey2oNdbSGmmV1Z7R5CQukIDid49geZGhgHU0nmQpx
 4vBUZVYm9rz1If35+RKrfe78VEBcX4nkcV5PKAZ1hj2j2GE613n7gjYsEy5LuTzvIvKRz6JWP9rbA
 QA1NQaJwwLtEb+dQukgJxAQbEWyUn6qfiobW82abK61Jnn9H6WgweLbbnWiNXXZU6IUZ3mGsrOLx7
 OTrRgyHLMcYjmjcPQmEmH3PxX9XKP9A4AX9yySkE39mAhOlc2ehuH2U+oYviPHHfa9sBdZnDq11Q/
 y3rVHRNv5p6BJZvfFxHQHHLV5R3LAme6GdPTcf0JI=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2G-000Bmt-4h; Thu, 04 Apr 2024 15:25:52 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:37 +0100
Message-Id: <20240404142539.711134-16-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 15/17] esp.c: update esp_fifo_{push,
 pop}() to call esp_update_drq()
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

This ensures that the DRQ line is always set correctly when reading/writing
single bytes to/from the FIFO.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240324191707.623175-16-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 6fd1a12f23..4895181ec1 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -170,10 +170,11 @@ static void esp_fifo_push(ESPState *s, uint8_t val)
 {
     if (fifo8_num_used(&s->fifo) == s->fifo.capacity) {
         trace_esp_error_fifo_overrun();
-        return;
+    } else {
+        fifo8_push(&s->fifo, val);
     }
 
-    fifo8_push(&s->fifo, val);
+    esp_update_drq(s);
 }
 
 static void esp_fifo_push_buf(ESPState *s, uint8_t *buf, int len)
@@ -184,11 +185,16 @@ static void esp_fifo_push_buf(ESPState *s, uint8_t *buf, int len)
 
 static uint8_t esp_fifo_pop(ESPState *s)
 {
+    uint8_t val;
+
     if (fifo8_is_empty(&s->fifo)) {
-        return 0;
+        val = 0;
+    } else {
+        val = fifo8_pop(&s->fifo);
     }
 
-    return fifo8_pop(&s->fifo);
+    esp_update_drq(s);
+    return val;
 }
 
 static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
-- 
2.39.2


