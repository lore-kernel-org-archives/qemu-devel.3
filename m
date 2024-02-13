Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1497CC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz03-0003nw-JP; Tue, 13 Feb 2024 15:03:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyQ-000298-GM
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:49 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyO-0001tq-V3
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y5k/Qsj7Cz3nbSk7L69u+FdeVqYBrUsnn213llf00Ts=; b=s2uayqGZRoimD2DDtTGBE46OlC
 +lZg7lDXy2uHPE/KzsfSSJCQgBLVtgzDXiGnmj2ocw5GiC3bHT4DTXlyP+wxn6NWeA35g9FF0Tr5i
 uWjMuA0oJppkFzPc6cNEfrfHAL51j3CcH4la9kmH+/Swhf5/KH+gNErP024hLn22GpwR5qIMBfaEL
 rKIyTh7jmjZORPWRdwzYhkm2qYwqAK7cSiZPfJJljt7wbhmGlee44pr/VPJTTHU5NISLVs4uqcMMA
 gzQBZMLEhuf27TYoZkneSpFCdlngj/ZrfVWlz6E2HZ6DwasUWEznixV59VrLVG2Dvy9ZrUaLhUWr/
 dnzmOf5pngzRMMlNuoMIeV8dUCZTgIIF7B1RMGyDX5EvvruVXYECknUWtEGvM9eQcfbDBcakDra9C
 RbJTS2jTb927by2sVRPkIpKy8C5SyyJ26K0KM0IfmwjCR5HYjX2MVtvzqVzxqWQMTiX8F4L+urYW4
 uCEByPr5gnessvxjvzGYhgSvbeMUmFZJ/RsiuPJMowGA4322uee26v3TNnCCOKDAVIQ/sELY6fs+4
 JlT9ebFqs4DPZ7bDEtgvTnPIkja2gDdhnTEtEvC1xvlxqTyzflGO2bZ3gUCpMX1v63XNuiOdzo6Dl
 BSzJn/lrwwjOAfw8ID6YFtMzaAqVkVdYf9m1DiN34=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhD-0008m4-Bs; Tue, 13 Feb 2024 19:44:03 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:32 +0000
Message-Id: <20240213194052.1162753-69-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 68/88] esp.c: move write_response() non-DMA logic to
 esp_do_nodma()
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

This moves the remaining non-DMA STATUS and MESSAGE IN phase logic from
write_response() to esp_do_nodma(). Note that we can also now drop the extra
fifo_reset() which is no longer required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-69-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 277eb8647b..824ebe9ff0 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -392,20 +392,12 @@ static void handle_satn_stop(ESPState *s)
 
 static void write_response(ESPState *s)
 {
-    uint8_t buf[2];
-
     trace_esp_write_response(s->status);
 
     if (s->dma) {
         esp_do_dma(s);
     } else {
-        buf[0] = s->status;
-        buf[1] = 0;
-
-        fifo8_reset(&s->fifo);
-        fifo8_push_all(&s->fifo, buf, 2);
-        s->rregs[ESP_RFLAGS] = 2;
-        esp_raise_irq(s);
+        esp_do_nodma(s);
     }
 }
 
@@ -815,6 +807,28 @@ static void esp_do_nodma(ESPState *s)
         s->rregs[ESP_RINTR] |= INTR_BS;
         esp_raise_irq(s);
         break;
+
+    case STAT_ST:
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_ICCS:
+            fifo8_push(&s->fifo, s->status);
+            esp_set_phase(s, STAT_MI);
+
+            /* Process any message in phase data */
+            esp_do_nodma(s);
+            break;
+        }
+        break;
+
+    case STAT_MI:
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_ICCS:
+            fifo8_push(&s->fifo, 0);
+
+            esp_raise_irq(s);
+            break;
+        }
+        break;
     }
 }
 
-- 
2.39.2


