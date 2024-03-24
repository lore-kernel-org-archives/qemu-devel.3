Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B900C6FD1F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 19:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTM8-0007Sh-38; Sun, 24 Mar 2024 15:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTM6-0007SG-Ce
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:06 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTM4-0005MP-SB
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=77dk6wnZ2bSAejWshvXrKexdiyTpCPKPvwX9iyAhCFE=; b=QgwLHof3v46EWCNARk4N4s9odV
 k1I1DB0DkfH4xP4qtXuxKDd/N1oQvJ+6uViyBVDqQV35WNZ6KsrYbhrum8NNXE7S4UxZ5ZkPYsiC0
 FCdc+Q4l2Zug7bN+k2MTGkXmSXPQ1e6yEQkq+e+kSRcmVKh+IFpjibquXUuhq6SPYdbgGGz/ceLwp
 GIwOi0DesdBfRMS4pm1A2C8e5/1wVCnTmdPQdpmglfMw8DpedTK67fax9OHIgvSdOZQmdKV5JArUH
 RxLDuoIUjH4bZ/3YXJ88/sgXpg2sZiOdXQI97MLagSOQXRATGo/3KFB0xvG6e3io9BCYEm9z++4MI
 G6advuACBzGZ2Nn2iHShPrt5JAF/Bvn+0sIBGjztgl/PiHjgukXp5iQcTA1GqkltfCLQR4Pd6SkqU
 t8jKImG3Ewpdht+TNdAp0H/LUVPhoO06sdHAndgXJnidwTu7rIfiZWqSWGsiJpn2IXZm4O4Zenqkj
 WlgKjTFaK9Zf6KF2nMGJC706S86sxYarQDS3D2f3yH1/EXV3Bvr6RO8KrdeGDlBN+pW/l66BNf/g+
 yYpWvy8EyNXMDAYHwski6E1u1EAfl6SXd0cQtnsI7zIt3O74Gd1QaMdkpKADPhdkyBkbLCBuqO6Yv
 CxP3bDBppmMg4ZJtkkbCRGWnya11n1/HLgz5j0nac=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTL5-0000dj-EC; Sun, 24 Mar 2024 19:17:07 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:17:00 +0000
Message-Id: <20240324191707.623175-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 11/17] esp.c: rework esp_cdb_length() into esp_cdb_ready()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The esp_cdb_length() function is only used as part of a calculation to determine
whether the cmdfifo contains an entire SCSI CDB. Rework esp_cdb_length() into a
new esp_cdb_ready() function which both enables us to handle the case where
scsi_cdb_length() returns -1, plus simplify the logic for its callers.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f3aa5364cf..f47abc36d6 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -425,20 +425,20 @@ static void write_response(ESPState *s)
     }
 }
 
-static int esp_cdb_length(ESPState *s)
+static bool esp_cdb_ready(ESPState *s)
 {
+    int len = fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset;
     const uint8_t *pbuf;
-    int cmdlen, len;
+    int cdblen;
 
-    cmdlen = fifo8_num_used(&s->cmdfifo);
-    if (cmdlen < s->cmdfifo_cdb_offset) {
-        return 0;
+    if (len <= 0) {
+        return false;
     }
 
-    pbuf = fifo8_peek_buf(&s->cmdfifo, cmdlen, NULL);
-    len = scsi_cdb_length((uint8_t *)&pbuf[s->cmdfifo_cdb_offset]);
+    pbuf = fifo8_peek_buf(&s->cmdfifo, len, NULL);
+    cdblen = scsi_cdb_length((uint8_t *)&pbuf[s->cmdfifo_cdb_offset]);
 
-    return len;
+    return cdblen < 0 ? false : (len >= cdblen);
 }
 
 static void esp_dma_ti_check(ESPState *s)
@@ -806,10 +806,9 @@ static void esp_do_nodma(ESPState *s)
             trace_esp_handle_ti_cmd(cmdlen);
 
             /* CDB may be transferred in one or more TI commands */
-            if (esp_cdb_length(s) && esp_cdb_length(s) ==
-                fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset) {
-                    /* Command has been received */
-                    do_cmd(s);
+            if (esp_cdb_ready(s)) {
+                /* Command has been received */
+                do_cmd(s);
             } else {
                 /*
                  * If data was transferred from the FIFO then raise bus
@@ -832,10 +831,9 @@ static void esp_do_nodma(ESPState *s)
             fifo8_push_all(&s->cmdfifo, buf, len);
 
             /* Handle when DMA transfer is terminated by non-DMA FIFO write */
-            if (esp_cdb_length(s) && esp_cdb_length(s) ==
-                fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset) {
-                    /* Command has been received */
-                    do_cmd(s);
+            if (esp_cdb_ready(s)) {
+                /* Command has been received */
+                do_cmd(s);
             }
             break;
 
-- 
2.39.2


