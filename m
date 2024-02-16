Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CBAC48BF5
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 21:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb5Qd-0006Dk-2U; Fri, 16 Feb 2024 16:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5Qb-0006DA-0s
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:25 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5QZ-0005Pu-Mg
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QUfv1x5Fmy4iHLPilnaDDf+n20KuwA7XLLsoDAioGvM=; b=nLDHWrXiObYnR2U1g1XuLj+/Mn
 qY58NlAXxQZjdzqk6QMcerX23il3owPR/iPNw0mg2zbR/9wkrLhV+UmB/acIaK04esV+loXnLJ/J9
 Yr14Pjl2IxGQC8ruEAq1kySj9Zo9z2E6mdYZCJzguZvpsCaHuX0azL2Lf/ehHBlTpdpTkFzYDONja
 lST4PIecjzUTJb6GohWvziCxySWlQ6t91YlirJPWHg37a0FumfyUq1TZRbBdW7uPDvbebHlfbjLu+
 PhGGR0n7D7bvctEKBm/1CJ6IyGFdedxVB8c82ZQx2UM4yfRWMwuzbTTkthBftSXuUbVaCsQ3mjeE0
 j1JAuDSYCKycFNatx13qv1WEq67cqJoMo2PD55ke4yj4rEhUe789gIrLjOvHlGMUDT3axU5gP/L3f
 2eHWFhhaWZReqQzlgSEu9Ktysi0mKaHCTt0QVapOPNHbVH6tDqjbQKvjudeymRJ3vzpGkMNfgzpHG
 KkvY/g0OsVkfP7/6OKSTH88o5c+zsb32yeQ6TsOPzjNOftHRXV2tH8C2P3JKjv1zO4JnSXXf5tPDF
 xL5iXN2XhmEMhcus51I4P+ii/d0Cr+CrNhuyjGfwjhjaxQVIsfXQRmWuCtLe4NtxjgEat/4yKuxRd
 sq3oawna7XlXqpM+cxhfLavb0/6XVU4K+jlrEkamQ=;
Received: from [2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5Pm-0000vT-Tm; Fri, 16 Feb 2024 21:06:39 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Fri, 16 Feb 2024 21:06:31 +0000
Message-Id: <20240216210633.1376066-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
References: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 11/13] esp.c: update esp_fifo_{push,
 pop}() to call esp_update_drq()
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

This ensures that the DRQ line is always set correctly when reading/writing
single bytes to/from the FIFO.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ca0fa5098d..2150cd457b 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -170,10 +170,11 @@ static void esp_fifo_push(ESPState *s, uint8_t val)
 {
     if (fifo8_num_used(&s->fifo) == s->fifo.capacity) {
         trace_esp_error_fifo_overrun();
-        return;
+    } else {
+        fifo8_push(&s->fifo, val);
     }
 
-    fifo8_push(&s->fifo, val);
+    esp_update_drq(s);
 }
 
 static void esp_fifo_push_buf(ESPState *s, uint8_t *buf, int len)
@@ -184,11 +185,16 @@ static void esp_fifo_push_buf(ESPState *s, uint8_t *buf, int len)
 
 static uint8_t esp_fifo_pop(ESPState *s)
 {
+    uint8_t val;
+
     if (fifo8_is_empty(&s->fifo)) {
-        return 0;
+        val = 0;
+    } else {
+        val = fifo8_pop(&s->fifo);
     }
 
-    return fifo8_pop(&s->fifo);
+    esp_update_drq(s);
+    return val;
 }
 
 static uint32_t esp_fifo_pop_buf(ESPState *s, uint8_t *dest, int maxlen)
-- 
2.39.2


