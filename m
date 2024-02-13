Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1013C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyez-0002pW-Gd; Tue, 13 Feb 2024 14:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyex-0002kz-Kh
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:39 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyew-0006HT-2R
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zqLutRoVYbdRbzEtVwJ/AxxYbcmeOYUsOM5J78wPJM8=; b=zWG3RH1t6YtTs6c3MnYVlOKvmi
 COHuE0XdW9whOGIRe7wAn1tLN2k6RMazHObNWuYFBPDZdQ+W3DFIx9s4H4alNkK0BoT4vNnXadvCn
 zRcTp9IP8r5Fh8tjjiakj6ajbfd8iAKqrX08XdM0+NsunVTZjj+Hmw+YWBU3M8+hsTHa/3190Flmx
 4VBy9OCa2pxqnJZ4DzN3kG3xkqGsX5aNW2gP9TZb84ajyrZpGPhummNPVmswvdeeX+Doyhm71hpRw
 TH5fH6d96j8sSaEgN1aQhD2L0AfGJa8yiNhsTpHXxWaToOFUzlmoFVvG1YxeizRDO1ksy4Rh5hiOp
 DAFX4RA8rWejRKCzaJgqGUqgOtkRBdQMczyY6Q3c2iUfBKhhgvVIdEunfbPznI0CVSczPfcjoOgXd
 8h73IpxNpZjPdig5lXP7nbiht9HU7g+K9BRxa/XpakwmIXDJ73zXTxTI08ve8op4ys/zz7whA+R9D
 wey5XecZQumyEyyauOeXWta5fspIe/GT7OnMlrXqCpv/gScr3fUO5ct42VgDyVpz/EUmOPsWs4Z4S
 XyEeAS/uUpVvzYJcc22KSywNGJmI5q2hJ1jfnxHcTca11yjWUn8Ko3uCgpHs4ihZm9BE6ZhBYBOpN
 b9KVpoc0CB//NIhXXtq0w9Rh4kzDVnUPZR0tU3th8=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeD-0008m4-DD; Tue, 13 Feb 2024 19:40:57 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:34 +0000
Message-Id: <20240213194052.1162753-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 10/88] esp.c: move buffer and TC logic into separate to/from
 device paths in esp_do_dma()
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

The ultimate aim is to for esp_do_dma() behaviour to be determined by the SCSI
bus phase, in which case it is necessary to have separate to/from device paths.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-11-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 65 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 63c828c1b2..9893840255 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -678,14 +678,53 @@ static void esp_do_dma(ESPState *s)
     if (to_device) {
         if (s->dma_memory_read) {
             s->dma_memory_read(s->dma_opaque, s->async_buf, len);
+
+            esp_set_tc(s, esp_get_tc(s) - len);
+            s->async_buf += len;
+            s->async_len -= len;
+            s->ti_size += len;
+
+            if (s->async_len == 0) {
+                scsi_req_continue(s->current_req);
+                /*
+                 * If there is still data to be read from the device then
+                 * complete the DMA operation immediately.  Otherwise defer
+                 * until the scsi layer has completed.
+                 */
+                return;
+            }
+
+            /* Partially filled a scsi buffer. Complete immediately.  */
+            esp_dma_done(s);
+            esp_lower_drq(s);
         } else {
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-            return;
         }
     } else {
         if (s->dma_memory_write) {
             s->dma_memory_write(s->dma_opaque, s->async_buf, len);
+
+            esp_set_tc(s, esp_get_tc(s) - len);
+            s->async_buf += len;
+            s->async_len -= len;
+            s->ti_size -= len;
+
+            if (s->async_len == 0) {
+                scsi_req_continue(s->current_req);
+                /*
+                 * If there is still data to be read from the device then
+                 * complete the DMA operation immediately.  Otherwise defer
+                 * until the scsi layer has completed.
+                 */
+                if (esp_get_tc(s) != 0 || s->ti_size == 0) {
+                    return;
+                }
+            }
+
+            /* Partially filled a scsi buffer. Complete immediately.  */
+            esp_dma_done(s);
+            esp_lower_drq(s);
         } else {
             /* Adjust TC for any leftover data in the FIFO */
             if (!fifo8_is_empty(&s->fifo)) {
@@ -713,32 +752,8 @@ static void esp_do_dma(ESPState *s)
             esp_set_tc(s, esp_get_tc(s) - len);
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-            return;
         }
     }
-    esp_set_tc(s, esp_get_tc(s) - len);
-    s->async_buf += len;
-    s->async_len -= len;
-    if (to_device) {
-        s->ti_size += len;
-    } else {
-        s->ti_size -= len;
-    }
-    if (s->async_len == 0) {
-        scsi_req_continue(s->current_req);
-        /*
-         * If there is still data to be read from the device then
-         * complete the DMA operation immediately.  Otherwise defer
-         * until the scsi layer has completed.
-         */
-        if (to_device || esp_get_tc(s) != 0 || s->ti_size == 0) {
-            return;
-        }
-    }
-
-    /* Partially filled a scsi buffer. Complete immediately.  */
-    esp_dma_done(s);
-    esp_lower_drq(s);
 }
 
 static void esp_do_nodma(ESPState *s)
-- 
2.39.2


