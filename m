Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3CBC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZygw-0001GY-O9; Tue, 13 Feb 2024 14:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygo-0000uA-8i
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:34 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyge-0006VE-N6
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b7eg0dzE654FUliKtZMmVkvW1/RaVBoC5GMBhFJ4dD0=; b=IsehB2xUnYtfTd0YR1PzPEvJDy
 I/Ric9QsipGVhBp6mlwZt18YiI5OTlHv5tZnZF5JhRA6Lr9VDOlXhb6qvntBtna1FdMS7jnrVYkpX
 QSbhhlgc7OqdG1M4MKPkptFzfo0P6MQH+D/UPimfcb1etdaRe61Le/z9Xv1be/jYUvKUFkjR9nkoE
 Q4ZgP/pv3Bz5u2GQitGoGbMtZKfdGb1c7FIXyzNgHCowKkx+AibLOi8+13uv2HYXh7C8VRpOuP0EI
 tDBeyHKacDm453z3b3xxoJxIGmdt7hkt6lv9PepQmbtF1E/I50zXfIQ39Yl3LeH89Hw1EDT3PqbnA
 uRKQdYjpHlOJ/th31N3eGxGJpZYtMDDd+Mhq77eZ29E3igHS5xuxQqzoNIkZiVxbPrXUJzVPZ2zfi
 GeRj3ezG5RN9g63EXelR7JzbiJ9s52/vBH/fQZqpgWHDPYxv/WKdR3jKi78ADkvRNTJ6CJ4fhcK+0
 8nNDrbM52NAwfML9YOzMpsyUeVbkTOeaxVc/L8hHwWShZmmue7/jwbuiTT6V0peEyykrV18d87aQ4
 WB+0cy4ZpkvJg+iQJFHd/IURMtIKlbEXRmwQv0wvYddldKTUv4/6rEsahsjcx6nZPmOmcRyeVQLyU
 vNSfxN3ZMKJ038/zK15ASbMtTrNOWA1Zdn4FbVgW0=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfm-0008m4-Ff; Tue, 13 Feb 2024 19:42:33 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:03 +0000
Message-Id: <20240213194052.1162753-40-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 39/88] esp.c: convert do_dma_pdma_db() to switch statement
 based upon SCSI phase
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

Currently only the DATA IN and DATA OUT phases are supported.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-40-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 67d1d39db2..f6d05b0de7 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -542,7 +542,6 @@ static void esp_dma_ti_check(ESPState *s)
 
 static void do_dma_pdma_cb(ESPState *s)
 {
-    int to_device = (esp_get_phase(s) == STAT_DO);
     uint8_t buf[ESP_CMDFIFO_SZ];
     int len;
     uint32_t n;
@@ -582,11 +581,11 @@ static void do_dma_pdma_cb(ESPState *s)
         return;
     }
 
-    if (!s->current_req) {
-        return;
-    }
-
-    if (to_device) {
+    switch (esp_get_phase(s)) {
+    case STAT_DO:
+        if (!s->current_req) {
+            return;
+        }
         /* Copy FIFO data to device */
         len = MIN(s->async_len, ESP_FIFO_SZ);
         len = MIN(len, fifo8_num_used(&s->fifo));
@@ -602,7 +601,12 @@ static void do_dma_pdma_cb(ESPState *s)
         }
 
         esp_dma_ti_check(s);
-    } else {
+        break;
+
+    case STAT_DI:
+        if (!s->current_req) {
+            return;
+        }
         /* Copy device data to FIFO */
         len = MIN(s->async_len, esp_get_tc(s));
         len = MIN(len, fifo8_num_free(&s->fifo));
@@ -620,6 +624,7 @@ static void do_dma_pdma_cb(ESPState *s)
         }
 
         esp_dma_ti_check(s);
+        break;
     }
 }
 
-- 
2.39.2


