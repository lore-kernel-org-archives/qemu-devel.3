Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959F8C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyxO-0000sc-5l; Tue, 13 Feb 2024 15:00:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyx3-0000hS-Jf
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:31 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyx1-0001dW-Up
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I/0aIaJ3v6q72PKhg5mEQTiEqIUx6SgVereXLL07mtg=; b=lkVy3QuyNz9kBoD7wGF9pnXZXz
 +WkXf6ZE//mVSEWg9kqKGSmB8EeLfVlG497b2BKmqKm6tjUJYlB1Tfat7WpeK/6S9DFaGrTOarUE/
 7TFZHrJqi4CBI/KJQ3G+0ZsN2KAqvgT97N3TiXNfak1047BhSCSzyzfzkZcP3IMuyjVkfoErTjFCw
 yNuUNscA+nhge3KNXa0ZCcQA5BJYDGGjo+xNlXMpKpAySBYodZr7ljbTVw9TfZabQvam0WHVa/Ahn
 IdwutpKJIk2qNXqEswCRk+pbV6fqB2WS5OalhjPgBaKmKzZa74jNrKDbjUvcgYUCsqWAaTzhjxKMP
 j6nra4DvFmfIwqW3cXFRlhFy02uQly5CZ2U/JuO0YKEaAEMqDZokbP+MNcDd//alL9McxNcHsM6Os
 Te4u+YQlmlnPOHhRZFXiFnMzQ6nzt8L+45jEWAVjw5MxHMyyQKfybirSYxdWyYNozhjxIkPK+W2MQ
 4NPpiVztOqau0cIhN+AXKcC7fsm98gFJB8eQTwP8RHVY09RZarQps9XK9DJ/VqEUlP+rMix6GCJkv
 sI9hbBie35M1zEq4vmMnlyX0vrxIO+llwxbnaJaXsoKOqR9y8IqTa6SgWmG2ruggG3f49/Sr9Iq2F
 1O81My3PVd5egSix1Q+uTp6DcMzipu9LGjZxtoMdU=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhm-0008m4-89; Tue, 13 Feb 2024 19:44:34 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:42 +0000
Message-Id: <20240213194052.1162753-79-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 78/88] esp.c: consolidate DMA and PDMA logic in DATA OUT phase
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

This allows the removal of duplicate logic shared between the two implementations.
Note that we restrict esp_raise_drq() to PDMA to help reduce the log verbosity
for normal DMA.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-79-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index d63039af89..394774c379 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -521,40 +521,29 @@ static void esp_do_dma(ESPState *s)
         if (len > s->async_len) {
             len = s->async_len;
         }
+
         if (s->dma_memory_read) {
             s->dma_memory_read(s->dma_opaque, s->async_buf, len);
-
             esp_set_tc(s, esp_get_tc(s) - len);
-            s->async_buf += len;
-            s->async_len -= len;
-            s->ti_size += len;
-
-            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
-                /* Defer until the scsi layer has completed */
-                scsi_req_continue(s->current_req);
-                return;
-            }
-
-            esp_dma_ti_check(s);
         } else {
             /* Copy FIFO data to device */
             len = MIN(s->async_len, ESP_FIFO_SZ);
             len = MIN(len, fifo8_num_used(&s->fifo));
-            n = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
-            s->async_buf += n;
-            s->async_len -= n;
-            s->ti_size += n;
-
+            len = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
             esp_raise_drq(s);
+        }
 
-            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
-                /* Defer until the scsi layer has completed */
-                scsi_req_continue(s->current_req);
-                return;
-            }
+        s->async_buf += len;
+        s->async_len -= len;
+        s->ti_size += len;
 
-            esp_dma_ti_check(s);
+        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+            /* Defer until the scsi layer has completed */
+            scsi_req_continue(s->current_req);
+            return;
         }
+
+        esp_dma_ti_check(s);
         break;
 
     case STAT_DI:
-- 
2.39.2


