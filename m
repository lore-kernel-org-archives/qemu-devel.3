Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14035C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZygx-0001Om-Jp; Tue, 13 Feb 2024 14:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygn-0000lV-7G
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:34 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygi-0006VZ-6W
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lS57P6Rml/Felg/6eLbNqxqYrNxDTK3LO+WE0zSQ2p0=; b=hIKg0CaAJ8SgIZgjvzJ25LxAsn
 ZRpKvO117lEXGTmJ3ioanNpxYit16S6W2L25n2UdC98A+e9eIfuiYKQZLVuOkiZbi9MVrf9ADtiZO
 Zsd2yBH/8thGp2Xb0i3aOg6rj12EtOAfTdA7XGIxCqOdBb1opIsOO/fEaV42tzgHid/8mffmhNyN+
 VZ7UXYHmdc7h0esBFwOSfZT5oth1VSDrYYbkOmCBh7MFrX4sx7H87cOHXX85d/rZu2SpSHT0CW1ks
 m8umn8+KUOphpOPDWbJNExcsI2jA2ctpHU0z8kHTTT/+/TQyo8Ws08cySUTz+94c3Niv3ZaKqRnhn
 BHm5kaachsd8GbHMkMrCceXkmvE8o5f/ZQYA5jLs+1PrT1f+Apa91T7JkgInqbhJvMhqbsMOtbZq9
 gUfTHrIBvG9TDIJ0rrG26bEs98RPbNrZ2ONuHGE49xFCnISyAgM6+Qr+zdUifBE9qdi8v167a7onf
 PYe7FWrccXQlp4UBNCgYXXF/niqrz44NSvpDzbp9Ts864KKaQGqwAFPzQ4rtxv0uXFVCim2+SCn6m
 FU6aU3qatjxb96ZOBZ9Rc6mEvKGl6vtmt7apscf4GGiLuyu3Q6B7AftB1HFw+rtk5Uc7U6uqTQcNK
 eJBjwSpvlR88PwG0JmWEZuGIAHqrZknI31q5jjMss=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfq-0008m4-2C; Tue, 13 Feb 2024 19:42:37 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:04 +0000
Message-Id: <20240213194052.1162753-41-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 40/88] esp.c: convert esp_do_nodma() to switch statement based
 upon SCSI phase
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
Message-Id: <20240112125420.514425-41-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 54 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f6d05b0de7..c1b44e5f18 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -786,7 +786,6 @@ static void esp_do_dma(ESPState *s)
 
 static void esp_do_nodma(ESPState *s)
 {
-    int to_device = (esp_get_phase(s) == STAT_DO);
     uint8_t buf[ESP_FIFO_SZ];
     uint32_t cmdlen;
     int len, n;
@@ -823,38 +822,55 @@ static void esp_do_nodma(ESPState *s)
         return;
     }
 
-    if (!s->current_req) {
-        return;
-    }
-
-    if (s->async_len == 0) {
-        /* Defer until data is available.  */
-        return;
-    }
-
-    if (to_device) {
+    switch (esp_get_phase(s)) {
+    case STAT_DO:
+        if (!s->current_req) {
+            return;
+        }
+        if (s->async_len == 0) {
+            /* Defer until data is available.  */
+            return;
+        }
         len = MIN(s->async_len, ESP_FIFO_SZ);
         len = MIN(len, fifo8_num_used(&s->fifo));
         esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
         s->async_buf += len;
         s->async_len -= len;
         s->ti_size += len;
-    } else {
+
+        if (s->async_len == 0) {
+            scsi_req_continue(s->current_req);
+            return;
+        }
+
+        s->rregs[ESP_RINTR] |= INTR_BS;
+        esp_raise_irq(s);
+        break;
+
+    case STAT_DI:
+        if (!s->current_req) {
+            return;
+        }
+        if (s->async_len == 0) {
+            /* Defer until data is available.  */
+            return;
+        }
         if (fifo8_is_empty(&s->fifo)) {
             fifo8_push(&s->fifo, s->async_buf[0]);
             s->async_buf++;
             s->async_len--;
             s->ti_size--;
         }
-    }
 
-    if (s->async_len == 0) {
-        scsi_req_continue(s->current_req);
-        return;
-    }
+        if (s->async_len == 0) {
+            scsi_req_continue(s->current_req);
+            return;
+        }
 
-    s->rregs[ESP_RINTR] |= INTR_BS;
-    esp_raise_irq(s);
+        s->rregs[ESP_RINTR] |= INTR_BS;
+        esp_raise_irq(s);
+        break;
+    }
 }
 
 static void esp_pdma_cb(ESPState *s)
-- 
2.39.2


