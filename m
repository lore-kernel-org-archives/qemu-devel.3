Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F49C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyfr-000553-BW; Tue, 13 Feb 2024 14:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfn-0004a7-72
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:31 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfk-0006NT-JF
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+iBKlrCd0SeFLixRh0a+X917yw2Et/Lod3SuX2H3jdo=; b=gOr/kM1c+FAdIYf5G2SYvCylP7
 b4LoajafxtSZwSUhM3zIFkjsiR5SI2iX5x+a6xWOxd/Ol155NzIP6kXJeFWeMpyWIFyq2Y8aOjWPk
 WUjTta2+uYbXfq/LWwvlXiclJ8V307szNaNnXY8yXD+VLjVjOK1KML+5jsGp+oAz7OCRDb5BuBEkx
 kkWsLXVDrCVpMH5YezAnlulXi0Dcg59pzUADxRX3nAZ2na5Y+5ARGf8odoQO5x2pprDLRC06B9b2K
 muA8TqrNogqWgWiLtaosM1kgxLt/Ht/N103dOos8ANl0qX9QMx9zeQ/OvfBkkmP5NargHexae7Ypg
 1srV6LI+j09VHzOZ0+PhGYf4DmG7WDpI8gVAM7NWfdrbU/RkDLut82k+w16JCn8/davFAPQFntnlW
 J647n3f6oAvQn/BKWzV98oiOFddLiqUIGDmvyWdPX4F1cQJtlFZDSQKsxDKJ3UO8VV5kyjJUb3vzZ
 18GCbo0QOvCATwYjk25PTaYHPn2lIOHaQP36wYYoRcnsKfld3f2yU1IfrJo9zQL3djc3Vfb9VmEn1
 O0hCfshL8e9B4aBnVPebwkfuDYTnSMk3uBiy+qvpLGjO9875a4T59QMgSwgvm1UEZzcv3/xQRU0Td
 k8Rsmh9IiEavZHse5x5fJokYo6myoItK5lZzEOzEY=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyer-0008m4-B2; Tue, 13 Feb 2024 19:41:36 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:45 +0000
Message-Id: <20240213194052.1162753-22-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 21/88] esp.c: update condition for esp_dma_done() in
 esp_do_dma() to device path
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

Ensure that esp_dma_done() is only called when TC is zero, which is currently
always the case for DMA transfers.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-22-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 96723efcf3..06be9f2e74 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -725,9 +725,11 @@ static void esp_do_dma(ESPState *s)
                 return;
             }
 
-            /* Partially filled a scsi buffer. Complete immediately.  */
-            esp_dma_done(s);
-            esp_lower_drq(s);
+            if (esp_get_tc(s) == 0) {
+                /* Partially filled a scsi buffer. Complete immediately.  */
+                esp_dma_done(s);
+                esp_lower_drq(s);
+            }
         } else {
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-- 
2.39.2


