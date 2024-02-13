Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB23C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0Q-0004NA-8X; Tue, 13 Feb 2024 15:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyz0-0002b7-BH
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:02:22 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyy-000249-Mv
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aJTWAvOYqywrLnvX1OR2Ngh7aiAwrAzm/3AnJXr6yik=; b=X5Ize7XVLzxFVaXA+kZbjk8qXY
 FyTDm6wimhNWrmmheUl5gxaWxjmxVAjPut8n+N8eDcxbnvrLaCdr0atRD+N5noLUgVeGNJgE5PAnC
 FO7uyYHyQHn8GFQWer+4Z23Syq9Bcv/7eYYXD3UWhNW7kuGxgim6u3d7vgtwqqdulqBnD3GyVtpgm
 0XpGSNo+XWdKW5QSyE/1nWeea7SkRc41LWF3/RsyY92TtR/hsTUtx3iig6OK2UJnz9/RZgnBTVxwL
 +9YiOs6EDmXQ/WG7Mad+1m2kFC7oiq89lsCL5fILC8kOmeTICmD3QT+0VMYwPN6zc7PQYoPgZX4BP
 EfPp1W4e8diS31xyZkivO55o0QciNX6nLEcdG3TW/SPE7TzI+tquUNfDj18ASW/bvSnV10WThTRU2
 0LS7Qfjhv8wpIWhqKbsgtFTzArPFI2s0kkDCc/OutmbNhWZ+Lyxx22jECEslyzHEyIxGBf7+iwENB
 m6b0V3WedK1uZKS4Y8hBZjXHGFExqV3riwO2y8b6FPzAQtctJvf3ycP1yR+t9R9g9lCDBRCCjm3eC
 bsg1bMmVdcYlqaoatoaxvTvwuyW6VJ809fgnrYR1qp9jBh4GtIfL7vm/0o+P9LYH5VQiHGJPqFdh7
 w9yiJ5YfltWNzTe5F7YV9oYEjKJzq0UGw/NWAyiM0=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygr-0008m4-83; Tue, 13 Feb 2024 19:43:41 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:23 +0000
Message-Id: <20240213194052.1162753-60-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 59/88] esp.c: separate logic based upon ESP command in
 esp_transfer_data()
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

The handling of the INTR_FC and INTR_BS bits is different depending upon the
last command executed by the ESP. Note that currently INTR_FC is managed
elsewhere, but that will change soon.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-60-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 75538f5859..b6cf1b43db 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -862,13 +862,33 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
     s->async_buf = scsi_req_get_buf(req);
 
     if (!to_device && !s->data_ready) {
-        /*
-         * Initial incoming data xfer is complete so raise command
-         * completion interrupt
-         */
         s->data_ready = true;
-        s->rregs[ESP_RINTR] |= INTR_BS;
-        esp_raise_irq(s);
+
+        switch (s->rregs[ESP_CMD]) {
+        case CMD_SEL | CMD_DMA:
+        case CMD_SEL:
+        case CMD_SELATN | CMD_DMA:
+        case CMD_SELATN:
+        case CMD_SELATNS | CMD_DMA:
+        case CMD_SELATNS:
+            /*
+             * Initial incoming data xfer is complete so raise command
+             * completion interrupt
+             */
+             s->rregs[ESP_RINTR] |= INTR_BS;
+             esp_raise_irq(s);
+             break;
+
+        case CMD_TI | CMD_DMA:
+        case CMD_TI:
+            /*
+             * Bus service interrupt raised because of initial change to
+             * DATA phase
+             */
+            s->rregs[ESP_RINTR] |= INTR_BS;
+            esp_raise_irq(s);
+            break;
+        }
     }
 
     /*
-- 
2.39.2


