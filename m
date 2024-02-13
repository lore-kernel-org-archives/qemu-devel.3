Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D22AC4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyfp-0004uh-S4; Tue, 13 Feb 2024 14:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfn-0004Zt-4y
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:31 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfi-0006N0-MZ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BCkhcY2O5ooyqkqZePv9Rcdiugc/548cCTEiXFiu3jE=; b=DHMbTuIQV5m50hHaxljZ7FeTRu
 TnpnP11nNHqv34VD6fluMkTA7KcS/LGWbsIRMceUi5bZP+qh2HAtqTKrQmN9QtoThKRJrK+PexEOG
 e2p9Rsf3KkJlPpL0KLoJJQVax3W6SZMTA16U0RwkZVyWkLzLmHQG72jWoOAVCF78s79gssFvLODSL
 i2j0Dl2Murt9hLuKQYGwgNSPWb/ym9V5HrhUMu3Zj8evg2qop85EqNo6fbvgazJZuo3UI7rrubmWg
 oOD1Cl/8raBZe4Ly2sDxrwPYh+k7t52oqTcIfNKV3JL9jvF1RvaU26tj7CVJsH2m7RBTDWf31lwpy
 cb66T4IL7THRXiPEE8DljunsNrOF+rNqoobsmbAx/rcozNKJugwU1pbJYL82gz+4+jDXcWjd0MXZ8
 zYdMRfs1aA5b0AP6kTPLAzXOHjh2lumwiliyM72+73FjFSNq/WL92+az7ZTZIy7AhIChh8zdZZfon
 vdxXkRGnlYZuGwQ8NUaRpJeFZYJyrJ8aSEC10Sr91bNzFED1xpFvY0xdnp91aWeYQHPqQ8PyZKmrt
 9Y6PXeK5UUnm+pkg/zL7teHEZ56Fcy7QWC/GI6IVPnkTo4l10V/Kznx/QZ6cXK/YJFZcXCiSW3Dyu
 j7X1Hi+SJTBVL5Q0wh3+9nuNb691aimhrSRglp3QM=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyen-0008m4-OZ; Tue, 13 Feb 2024 19:41:33 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:44 +0000
Message-Id: <20240213194052.1162753-21-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 20/88] esp.c: update condition for esp_dma_done() in
 esp_do_dma() from device path
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

No change to the condition itself, other than to clarify that esp_dma_done()
must be called when TC is zero.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-21-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index dc515e6435..96723efcf3 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -743,19 +743,13 @@ static void esp_do_dma(ESPState *s)
 
             if (s->async_len == 0) {
                 scsi_req_continue(s->current_req);
-                /*
-                 * If there is still data to be read from the device then
-                 * complete the DMA operation immediately.  Otherwise defer
-                 * until the scsi layer has completed.
-                 */
-                if (esp_get_tc(s) != 0) {
-                    return;
-                }
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
             /* Adjust TC for any leftover data in the FIFO */
             if (!fifo8_is_empty(&s->fifo)) {
-- 
2.39.2


