Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DE4C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyfs-00058C-8t; Tue, 13 Feb 2024 14:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfp-0004wS-Vt
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:34 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfo-0006Nx-Fj
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dF+0iXt3A2oU6ZpqfQ69+kz5PzEX70MTcPwj4fQaWo0=; b=aL52GBRBwrXOfwjkFzZMOOmmmX
 wugRlMJYY7/j5/Xo+YaRnE0QRCtJD0bNLXlvgglAT3QPzLspjXGYyoWLde82sMNNmYlYckdNGJd9z
 BZke1fuuj4YR7lsNC4TOGMn4PtxqwFrYX1PLSPa48fus7zfR1g9pnD40bBNQOgTTfoKVdqbkePl6j
 Si4jmKVx3PQWJ+L6tpSaqPLA8TqaNpgcQn2ZslHlHm6CJRO++whzBasDrzXERq9AQ5KaJqc7llkFp
 xAJ9Xb4j1lMTE2CY0/PJ080xx+J1t+saFqnzd+bO5rEQH3wy3EJJS8nkdPMnkff1WpieMpFBeMdpb
 MKfI5HkQpVMw3Lr9jUXRicfmYErCpQ8+WKu2/YFAPQUrmiZHtfxMvSHqNNkNFdgt+EjCH8xXnCxlD
 ag2A2XGYrnqF9MaRXyP2HZi3MmqVRsI61JSrmnM8v3oT/Qv+DS9KyySyaCRAbJK+VH9jHdVKH0pA0
 r/Zb8ICufNt/zw0Ay3nzv4l9owsJWRbhpXZGDGt7ePYumK8bOHG1eJD3kqXZ3IcAHWuASgdozgiQP
 ykDb4WIKtohsiFEqdo7q7q2mL63GIaKyIyjrP+uER8OeUKrm+E2UDikmb1TL66A5xKu2d42eRiSfr
 q3UkWz0Mg1egOay67EYitoSD9435uBgSDdjESJ9BU=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeu-0008m4-Tz; Tue, 13 Feb 2024 19:41:41 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:46 +0000
Message-Id: <20240213194052.1162753-23-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 22/88] esp.c: ensure that the PDMA callback is called for every
 device read
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

Rather than wait for the FIFO to fill up before calling the PDMA callback, push
that logic directly into the from_device logic in do_dma_pdma_cb().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-23-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 06be9f2e74..d80a38daa0 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -625,14 +625,14 @@ static void do_dma_pdma_cb(ESPState *s)
 
         return;
     } else {
-        if (s->async_len == 0) {
+        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
             /* Defer until the scsi layer has completed */
             scsi_req_continue(s->current_req);
             s->data_in_ready = false;
             return;
         }
 
-        if (esp_get_tc(s) == 0) {
+        if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
             esp_lower_drq(s);
             esp_dma_done(s);
         }
@@ -1419,9 +1419,7 @@ static uint64_t sysbus_esp_pdma_read(void *opaque, hwaddr addr,
         val = (val << 8) | esp_pdma_read(s);
         break;
     }
-    if (fifo8_num_used(&s->fifo) < 2) {
-        esp_pdma_cb(s);
-    }
+    esp_pdma_cb(s);
     return val;
 }
 
-- 
2.39.2


