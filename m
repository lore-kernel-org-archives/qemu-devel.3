Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F0EBC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyev-0002it-S3; Tue, 13 Feb 2024 14:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeu-0002il-DA
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:36 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyet-0006HD-0M
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nO+ngFbqX34GmWdyHyDwlZOuxb9VSNiPAp1CSju1IoQ=; b=q9DpdXp/mMLAWYx0xdvmZzNgvD
 i7batKoXDJRflAre8sbl22d3uh5nJGCPA8iNdy5vZ2km1DVFq+AyxoXsYcWDCEbag6oZ5/EZ8N7ew
 IM/yCm4MK6e92kbpGdBKE7ZVWpDXQF7RQ+63x7+YQwAi5KAxzcKKgtuN8Mj0uxam86hmtdbZU5Syv
 Lca+w6+ICmpL8/6oEwBPHGahAnIerujdqF6Bs2sZextadspa0v2IQ7nnoYE19heUAgchrY0KmpQ94
 y3qEUGZ+zN7yUJcwBpsLCu/orx8W0PvVUaE5B48eJThnCiG1DYDrFf15oK7DtJiebToNuVFr/GgT0
 nPY4lRUveulx41kMx6YBRERYayNIzSBhxEqrroOVvfUutrXO+/lZgjhCrIKO7BNDbtfrIfjyZeVWd
 CNyoGX69rfLkocO3aE/qfC84OV0WfS3KKYS0r7Cj2DkEU6tl9cIl8ImES1ap/+uUUTdAeiUKoq28H
 zjprvzA+a9uGX1GSktzAENF7N1dDJ76FoeAV6OJG8gz8rH9zGiIfWxWZuqUADKLKh5nUBpkWjbxr2
 wYEEbVrwsutEQjHJaw7MQflWkPXCpbGHh8v/ozpXRv9Ops79hfbJ2gNr93EId6wpmeKbza38KdkDq
 yKaTdB3dI1Eq46rCxEou6uda5XASiXp+JN8s5uvjA=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZye9-0008m4-A7; Tue, 13 Feb 2024 19:40:53 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:33 +0000
Message-Id: <20240213194052.1162753-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 09/88] esp.c: update TC check logic in do_dma_pdma_cb() to
 check for TC == 0
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

Invert the logic so that the end of DMA transfer check becomes one that checks
for TC == 0 in the from device path in do_dma_pdma_cb().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-10-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index fecfef7c89..63c828c1b2 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -602,21 +602,19 @@ static void do_dma_pdma_cb(ESPState *s)
             return;
         }
 
-        if (esp_get_tc(s) != 0) {
-            /* Copy device data to FIFO */
-            len = MIN(s->async_len, esp_get_tc(s));
-            len = MIN(len, fifo8_num_free(&s->fifo));
-            fifo8_push_all(&s->fifo, s->async_buf, len);
-            s->async_buf += len;
-            s->async_len -= len;
-            s->ti_size -= len;
-            esp_set_tc(s, esp_get_tc(s) - len);
-            return;
+        if (esp_get_tc(s) == 0) {
+            esp_lower_drq(s);
+            esp_dma_done(s);
         }
 
-        /* Partially filled a scsi buffer. Complete immediately.  */
-        esp_lower_drq(s);
-        esp_dma_done(s);
+        /* Copy device data to FIFO */
+        len = MIN(s->async_len, esp_get_tc(s));
+        len = MIN(len, fifo8_num_free(&s->fifo));
+        fifo8_push_all(&s->fifo, s->async_buf, len);
+        s->async_buf += len;
+        s->async_len -= len;
+        s->ti_size -= len;
+        esp_set_tc(s, esp_get_tc(s) - len);
     }
 }
 
-- 
2.39.2


