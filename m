Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12538C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyei-0002R4-BX; Tue, 13 Feb 2024 14:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeg-0002Qh-LH
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:22 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyef-0006Fj-7d
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MVDMmvJTqOzEPP0u0xre999nw8BU0NcMg9uxPxgcwTs=; b=HODkoB9MMC79g23+Apc7B3wJEP
 OcEpUQYGXOw2EjMt/Uk0bXeAQRIbj0XgO3C+UAleveOquUi90O6gq32Nt7FubtUSPxdfSi9KujINY
 aEj4NrQoFoXEhbPTvdT7d600JrT9uf+Vfv8AkeRgLDGWeEpXRiUaTecTbiGuAFGJCWkxi1nXxNutJ
 4Wfn3wXG6Q6gnT1aQ4jT4qBN0fBhFy8jrtp/P7D+kAjIS6Ezgen+Lzi+Pj10/283oma1ttKG79k38
 4dCfOEUGOKu+tdtbagbCnZ7e3sJSIA6qM/7uoO/c8Vj5cyeNUrTAGJKLAZqNSKmDI05PP1ALe4jn1
 Kcgtph+Fma9bpiRxbk46Ex1SZGP0rgmp1Re5MLzDzVrq6FigRxWSMUMScNMPoQBjNQ0HI97H6Rh9v
 qgSVDp/nkwQTollLmXu370v8DUJ3Dd1jGwtQEgddNkmEjwlptKaP7uuc//gseW8Ww9/FC6wDs7Ca7
 YaOZzR5Ppadp10iOyhadwnxH80Y8T4UWmDCpFwdssekInSHoIodKsveXAEWjcLZoQBvcboTFi+M/K
 agny72NQknczsuzIC9k7UqvEYKWftQHFNwD9yID9/ykLQ0AsX3qdTPqgn2ssL6rH8gH0BXikSPSh1
 SdQQ+2I2IImrzUYQAmJKxEa+afRd1QgFvniY3Xpw8=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZydw-0008m4-GY; Tue, 13 Feb 2024 19:40:40 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:29 +0000
Message-Id: <20240213194052.1162753-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 05/88] esp.c: move esp_select() to ESP selection commands from
 get_cmd()
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

Since the DREQ value depends upon the result of the selection process, add a
workaround to each esp_select() to manually assert DREQ durring the MESSAGE OUT
and COMMAND phases.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-6-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 89fce05e58..8c1c6bfc1c 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -263,10 +263,6 @@ static uint32_t get_cmd(ESPState *s, uint32_t maxlen)
             dmalen = MIN(fifo8_num_free(&s->cmdfifo), dmalen);
             fifo8_push_all(&s->cmdfifo, buf, dmalen);
         } else {
-            if (esp_select(s) < 0) {
-                return -1;
-            }
-            esp_raise_drq(s);
             return 0;
         }
     } else {
@@ -280,9 +276,6 @@ static uint32_t get_cmd(ESPState *s, uint32_t maxlen)
     }
     trace_esp_get_cmd(dmalen, target);
 
-    if (esp_select(s) < 0) {
-        return -1;
-    }
     return dmalen;
 }
 
@@ -380,12 +373,18 @@ static void handle_satn(ESPState *s)
         return;
     }
     esp_set_pdma_cb(s, SATN_PDMA_CB);
+    if (esp_select(s) < 0) {
+        return;
+    }
     cmdlen = get_cmd(s, ESP_CMDFIFO_SZ);
     if (cmdlen > 0) {
         s->cmdfifo_cdb_offset = 1;
         s->do_cmd = 0;
         do_cmd(s);
     } else if (cmdlen == 0) {
+        if (s->dma) {
+            esp_raise_drq(s);
+        }
         s->do_cmd = 1;
         /* Target present, but no cmd yet - switch to command phase */
         s->rregs[ESP_RSEQ] = SEQ_CD;
@@ -411,12 +410,18 @@ static void handle_s_without_atn(ESPState *s)
         return;
     }
     esp_set_pdma_cb(s, S_WITHOUT_SATN_PDMA_CB);
+    if (esp_select(s) < 0) {
+        return;
+    }
     cmdlen = get_cmd(s, ESP_CMDFIFO_SZ);
     if (cmdlen > 0) {
         s->cmdfifo_cdb_offset = 0;
         s->do_cmd = 0;
         do_cmd(s);
     } else if (cmdlen == 0) {
+        if (s->dma) {
+            esp_raise_drq(s);
+        }
         s->do_cmd = 1;
         /* Target present, but no cmd yet - switch to command phase */
         s->rregs[ESP_RSEQ] = SEQ_CD;
@@ -446,6 +451,9 @@ static void handle_satn_stop(ESPState *s)
         return;
     }
     esp_set_pdma_cb(s, SATN_STOP_PDMA_CB);
+    if (esp_select(s) < 0) {
+        return;
+    }
     cmdlen = get_cmd(s, 1);
     if (cmdlen > 0) {
         trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
@@ -456,6 +464,9 @@ static void handle_satn_stop(ESPState *s)
         s->rregs[ESP_RSEQ] = SEQ_MO;
         esp_raise_irq(s);
     } else if (cmdlen == 0) {
+        if (s->dma) {
+            esp_raise_drq(s);
+        }
         s->do_cmd = 1;
         /* Target present, switch to message out phase */
         s->rregs[ESP_RSEQ] = SEQ_MO;
-- 
2.39.2


