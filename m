Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7B9CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO2r-0004Nv-85; Thu, 04 Apr 2024 10:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2q-0004NJ-71
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:24 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2o-000653-3G
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TCZFo18rWjN73WOUDD9YgtrR3Jw4b47qJOBkqwcPRX0=; b=GiDzg402GISXstKQQHqaXcpTsC
 rYcPHWo/BwgHxMklsIFBlE02Slaa9gK/fmfm8KrdxIF3wBnIe33TB7NuBIm8DI8ExvJJvgk/hWbmh
 xxb/PCBy1CLqgZe1J8K7gNr3y5I0mh+yuTMpEQF+eRsH5Zx+W+SVL2u/s8rhqRkDUxuH3MV75Q+5y
 Rjn4Uaihbv15ukOOGWw/RpXrUK7CNePoSN7ZojblaAeNd7NPVXW8B3HIcLMaSIVU8vKjwRKK4m5E7
 L9PnHxqi8Hlpq5W/+VFKTRvdrDMxYx0TUjn3YMTa1T3grcW6hVoXtoN8DTkpacAw7IY3rZgSIsMI8
 RJG9ow36Ts0dvjbdV2qUfFF2Ckg/HNiG6YSm3GX4Dpv4dsYHsl9q+EcoKCWIUkhpfC59v77CyqFM1
 Orot0cSio+9Wugokr6Zzq3vJpruiDA85eF1tVEdXN6/9c/E3HDOXbH0jtUi2tzOQcxqwGSiCGIxjD
 6IiTpAzT6nOvSdrHJfGG/5kXnju5pEN6AAWausp+mvRa3k8bjewZw38aDg6UW4AcCYPCYTOONi7LZ
 q1AZm5GgkJXQuiE+rkivLkYiEZ/uM6Y4x5m2k8RjABN+UPBPlqs6Rx3U6FRbtGX/tE3fe7oKMt7t1
 tOvPWLnHyMObyFw2K0pdznb9ILA8GNkwB++64MYiI=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO1o-000Bmt-Fw; Thu, 04 Apr 2024 15:25:24 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:28 +0100
Message-Id: <20240404142539.711134-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 06/17] esp.c: change esp_fifo_pop() to take ESPState
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
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240324191707.623175-7-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


