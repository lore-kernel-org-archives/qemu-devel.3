Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B4FC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 09:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKS5-0007iC-Dv; Wed, 13 Mar 2024 04:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKS4-0007ht-Mi
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:08 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKS3-0002It-8e
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cqkIYrP2+End915WdRdFh5GYVktf4P5AsVieIYKOZqE=; b=vZ0Mf44r5J7eGx7KDkzN+sOv0h
 SG6EkJqPj//NRH0+d3mOPW1tcQd802MQcQs75N6HQzL/oVCheC+REh4PuDbsuRlvK3YagY5yXPtf6
 SEDzbZF31cwhs2CEbXEI+Ov9mnqfG1CYCThVPmwriYk8ay7MWQROWMVIi4C6tVVx0upQoyars//PN
 lnB6kaqr7ZsEZZkp5QJPH9Mjn3qiabGrCu+XwMd5KIRwt9weYi2qSMNHeJEH+kAeEB21s1AHpJnvV
 bAkhXv29Ffg1CUuEDaQvEYyTccqvPCBD4EpnEQQysV0wWEwzfJyh8iTbgrXgh8xY4sk/QNycgP9MW
 IGZ7t7h5D8IgD8nR0RVgsmGX3aNA4ZBKhR9fRvqQtxy33VgyySAdnqRsShEw9IqXJobFMb8zSekZp
 4/9nuILytPx21nJ7tv1afsEJpbEkR7XKEFUWL7e6F+Kr4TISHD8/WZOZdbk0BtB660mG7pUc8mycX
 MTBWT6CCYhtn/vRX/INn2zs0EVC6Sj2M/d527CE5ROo/Y+X69Emr4jSqvI/BGM6t+PWrqJ6/geqR9
 YYYSS/lPH2aHhOH/D8qbn1g50Sl5NcjZRCQMxKJM19WTPnShIdIWwgdwjBmiYVBYZs5ju0egeC6+M
 vjgnLvOCjKE6sZ6zy0r+shjsuw9smjswzlgskDGPU=;
Received: from [2a00:23c4:8bb3:1000:1218:d855:1998:7fa8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKR8-000CUN-Km; Wed, 13 Mar 2024 08:58:14 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Wed, 13 Mar 2024 08:58:02 +0000
Message-Id: <20240313085810.2655062-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1218:d855:1998:7fa8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 08/16] esp.c: introduce esp_fifo_push_buf() function for
 pushing to the FIFO
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

Instead of pushing data into the FIFO directly with fifo8_push_all(), add a new
esp_fifo_push_buf() function and use it accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 4d9220ab22..6b7a972947 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -116,6 +116,11 @@ static void esp_fifo_push(ESPState *s, uint8_t val)
     fifo8_push(&s->fifo, val);
 }
 
+static void esp_fifo_push_buf(ESPState *s, uint8_t *buf, int len)
+{
+    fifo8_push_all(&s->fifo, buf, len);
+}
+
 static uint8_t esp_fifo_pop(ESPState *s)
 {
     if (fifo8_is_empty(&s->fifo)) {
@@ -601,7 +606,7 @@ static void esp_do_dma(ESPState *s)
             } else {
                 /* Copy device data to FIFO */
                 len = MIN(len, fifo8_num_free(&s->fifo));
-                fifo8_push_all(&s->fifo, s->async_buf, len);
+                esp_fifo_push_buf(s, s->async_buf, len);
                 esp_raise_drq(s);
             }
 
@@ -650,7 +655,7 @@ static void esp_do_dma(ESPState *s)
                 if (s->dma_memory_write) {
                     s->dma_memory_write(s->dma_opaque, buf, len);
                 } else {
-                    fifo8_push_all(&s->fifo, buf, len);
+                    esp_fifo_push_buf(s, buf, len);
                 }
 
                 esp_set_tc(s, esp_get_tc(s) - len);
@@ -685,7 +690,7 @@ static void esp_do_dma(ESPState *s)
                 if (s->dma_memory_write) {
                     s->dma_memory_write(s->dma_opaque, buf, len);
                 } else {
-                    fifo8_push_all(&s->fifo, buf, len);
+                    esp_fifo_push_buf(s, buf, len);
                 }
 
                 esp_set_tc(s, esp_get_tc(s) - len);
-- 
2.39.2


