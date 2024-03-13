Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81F1C54E60
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 09:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKSU-0000mR-Tq; Wed, 13 Mar 2024 04:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKSS-0000dZ-BB
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:32 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKSQ-0002KU-OA
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qELr3Q32KiKjiCbBinPtYdx/SGPTR47wLITRxGSIDgQ=; b=yhl+J5ZwPBF/lBhTMjM3CK+y6K
 W4fY71U5jaKiCA9PYpn3cTEVv02darsyhGA6gH2/xRnWQsc7HDTomNzgILo83E2sGe1cTzf3f7igD
 D23n8i5P5oZ4VM3PaKQ8+GaqZTBg6yy6NKxj9C3fyD7G6a34UtvuJM4533euwWww17tOHVVA3ZnXw
 hYLqMC+SgsW2SqtcJnEXChXWtxY99fhLnRruypT0xarRogmxQbIP7yhD4cPqN1DsNVGhO7v3rm0HA
 1gbPEfaEAxRBVXfh621RlXFfs6ND4fbE1rVEixLmDsFrrRMUR0aQ0nynSv4StSMnjqFAvqwBjIJe7
 lQlXrcuvD81LK6YQAwCQ74tto4L7bk8+OouZof1XosVbPpMj2sfMpi8/jAqR0BRicDj8TmgIuCMij
 k8UPoz3u/9QNHEaoHaxp6VujhD/IVYBHNtXtpqwp/dDyZQ88jLJd295fen8pwj5C1MWj4pCVysI6/
 Bt8fZMTwCwYBAq5W5g6EQb9DkMLVM5X6YhlNO5FYhH+YkTKVVvt7v0/6GXyp+rwYhz0k047oSWjrj
 dO9wx0UwyqdHGKHIuRnoC0bCHeEOTdi0Ju77ODmA7W+kgaFv9BoCdKVNLE3g3zE75PD9qz6xbhecv
 /0AfzmmrW+doNDJglWNQniQTDWsrsH2HtKDRMlipg=;
Received: from [2a00:23c4:8bb3:1000:1218:d855:1998:7fa8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRP-000CUN-KV; Wed, 13 Mar 2024 08:58:27 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Wed, 13 Mar 2024 08:58:07 +0000
Message-Id: <20240313085810.2655062-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1218:d855:1998:7fa8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 13/16] esp.c: introduce esp_update_drq() and update
 esp_fifo_{push, pop}_buf() to use it
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

This new function sets the DRQ line correctly according to the current transfer
mode, direction and FIFO contents. Update esp_fifo_push_buf() and esp_fifo_pop_buf()
to use it so that DRQ is always set correctly when reading/writing multiple bytes
to/from the FIFO.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 86145256ea..53a1c7ceaf 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -124,6 +124,48 @@ void esp_request_cancelled(SCSIRequest *req)
     }
 }
 
+static void esp_update_drq(ESPState *s)
+{
+    bool to_device;
+
+    switch (esp_get_phase(s)) {
+    case STAT_MO:
+    case STAT_CD:
+    case STAT_DO:
+        to_device = true;
+        break;
+
+    case STAT_DI:
+    case STAT_ST:
+    case STAT_MI:
+        to_device = false;
+        break;
+
+    default:
+        return;
+    }
+
+    if (s->dma) {
+        /* DMA request so update DRQ according to transfer direction */
+        if (to_device) {
+            if (fifo8_num_free(&s->fifo) < 2) {
+                esp_lower_drq(s);
+            } else {
+                esp_raise_drq(s);
+            }
+        } else {
+            if (fifo8_num_used(&s->fifo) < 2) {
+                esp_lower_drq(s);
+            } else {
+                esp_raise_drq(s);
+            }
+        }
+    } else {
+        /* Not a DMA request */
+        esp_lower_drq(s);
+    }
+}
+
 static void esp_fifo_push(ESPState *s, uint8_t val)
 {
     if (fifo8_num_used(&s->fifo) == s->fifo.capacity) {
@@ -137,6 +179,7 @@ static void esp_fifo_push(ESPState *s, uint8_t val)
 static void esp_fifo_push_buf(ESPState *s, uint8_t *buf, int len)
 {
     fifo8_push_all(&s->fifo, buf, len);
+    esp_update_drq(s);
 }
 
 static uint8_t esp_fifo_pop(ESPState *s)
@@ -155,6 +198,7 @@ static uint32_t esp_fifo_pop_buf(ESPState *s, uint8_t *dest, int maxlen)
     int len;
 
     if (maxlen == 0) {
+        esp_update_drq(s);
         return 0;
     }
 
@@ -175,6 +219,7 @@ static uint32_t esp_fifo_pop_buf(ESPState *s, uint8_t *dest, int maxlen)
         n += n2;
     }
 
+    esp_update_drq(s);
     return n;
 }
 
-- 
2.39.2


