Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018DFC4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZygZ-0000SR-Nf; Tue, 13 Feb 2024 14:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygY-0000Oe-89
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:18 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygW-0006UV-PE
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3lh4EKqM0Upn+N3VvhTeQfOb1mZrCBum2A1v0jFULbw=; b=Ya5vpiw9/g2iXSoJoVsRiwR915
 Nmsny+KsHEi98/G4PT3IUep5rExluZfdpGW53p7Vs6ZFBwy5AHfhBP5sFyf8B5obRFc6OHOp9vsYI
 v7pH6ISeVeX36bLy1YMA6cdYjZ8SWHPeY3vKGVd1RKaSYeziZT0DiyMQe71PBfDvoGB796xA6MXwz
 Ei+qB60rG+p350s0Ce/yf46b+OEdV0Y4bd+F5zjh9CjkpA7x1QZ7SPAxDybc/NmgPl487sXFt7S6q
 pAlWJKiDwhKICInl1uPAol4Thnz+qJmumFIt/SmTvdqTONoKxwtgoOZwXi1v9QF7qEiTI9lvRUFzs
 gwv9/mig3vjq2Pvtll5nvju59IbPxqNzWduu5ltg0R+3Uq681JO0f+xG6Bvh+f2LclSfcHpzngTdS
 NkvhsTQNSMhaTrUY3Bqbqf5v0r0eUQjpHDddvlgU406C+H4icxtkIumZtPi1xzeGp2ZLLbItk3Mj2
 e/BNCcukloEpsrQ8UfzN7CDjUKECG6JmiAu55UWv/86jY2HlgnMZqAnq98QtdEiM4VlMu92ue6wm9
 hXPocB2WytjDQW2OR61AKLX541j6PjFMfGnt+cKGeAnpEzosfj2Il4+9hv5PouNtti6QmMoYjQtEu
 xhAf8/TN+SMuVQkVpY3Z4HiexbXsnJJew0umGX0uc=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfd-0008m4-Vm; Tue, 13 Feb 2024 19:42:25 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:00 +0000
Message-Id: <20240213194052.1162753-37-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 36/88] esp.c: remove s_without_satn_pdma_cb() PDMA callback
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

This can now be handled by the existing do_dma_pdma_cb() function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-37-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 22 +---------------------
 include/hw/scsi/esp.h |  1 -
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index df4d5f8811..16cb6c72fd 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -408,23 +408,6 @@ static void handle_satn(ESPState *s)
     }
 }
 
-static void s_without_satn_pdma_cb(ESPState *s)
-{
-    uint8_t buf[ESP_FIFO_SZ];
-    int n;
-
-    /* Copy FIFO into cmdfifo */
-    n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
-    n = MIN(fifo8_num_free(&s->cmdfifo), n);
-    fifo8_push_all(&s->cmdfifo, buf, n);
-
-    if (!esp_get_tc(s) && !fifo8_is_empty(&s->cmdfifo)) {
-        s->cmdfifo_cdb_offset = 0;
-        s->do_cmd = 0;
-        do_cmd(s);
-    }
-}
-
 static void handle_s_without_atn(ESPState *s)
 {
     int32_t cmdlen;
@@ -433,7 +416,7 @@ static void handle_s_without_atn(ESPState *s)
         s->dma_cb = handle_s_without_atn;
         return;
     }
-    esp_set_pdma_cb(s, S_WITHOUT_SATN_PDMA_CB);
+    esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
     if (esp_select(s) < 0) {
         return;
     }
@@ -856,9 +839,6 @@ static void esp_pdma_cb(ESPState *s)
     case SATN_PDMA_CB:
         satn_pdma_cb(s);
         break;
-    case S_WITHOUT_SATN_PDMA_CB:
-        s_without_satn_pdma_cb(s);
-        break;
     case SATN_STOP_PDMA_CB:
         satn_stop_pdma_cb(s);
         break;
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 13b17496f8..b727181da9 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -153,7 +153,6 @@ struct SysBusESPState {
 /* PDMA callbacks */
 enum pdma_cb {
     SATN_PDMA_CB = 0,
-    S_WITHOUT_SATN_PDMA_CB = 1,
     SATN_STOP_PDMA_CB = 2,
     WRITE_RESPONSE_PDMA_CB = 3,
     DO_DMA_PDMA_CB = 4
-- 
2.39.2


