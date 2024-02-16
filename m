Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29FEC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 21:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb5Qe-0006Dr-47; Fri, 16 Feb 2024 16:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5Qc-0006Dc-OW
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:26 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5QW-0005Ph-2I
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 16:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=91aoXrvj1OdEhkGYyOANAVWf4Lp8Edic++hD2qJwrwc=; b=Pw+JwVsHXFJQYMdrVEnw3FT0GO
 fJi+FpIJ1zC9eKjb0CMDiIQmBs65/oXPeVAxEdXnj7QT9vIaAXtWM/audZ3ltSvrheEMDFfqV+L5S
 7c1kpcDQyXK4wIi4pmVYYAOdXTC77OvdEjdCUPBkoTc15f9MzIh426tU+IGoXVJKCisnumWN+Rzdl
 Co59SPvhlh7NvzQEuFWMo1yo1Orp5sQxVWnSAddRyxDpM81zXRXEqrzNmn+VXDaX1CX8jBq/SyLwK
 q4JTUApp0zZx5356q0zujDeYx0pT3a2TM9Lqu6A8yxKNWa3KQRo9AJ60Svzrly7wBLbBAVw3inDtp
 lyYvnrHogocWp284be+x8QSsdG3F8NymbLQtsKJlEgHemd8B68hcaKdsZpWMBHtE3r/cT1mKcZtPO
 QZxhK/h8cM/pfdoDGk0qhtN7srAJzc7PLzik3muMnECuiMNrpqKOzTAgnpZTWcfPfGmKCRIS3NjRz
 HFjyD9y4TeyOTBkJCU1jHNIgnk2knRkbv4OUgY8+Bn7LRr81m8NZNOB62iQjvC7AirYIprsmufPJG
 LPgbgBcpI4+/cp2Fl8HrJxVXBks0eCN9nEK+CWMglx7ltWfYV367r2VE9/NhoWHqFyKy4dkcmcpok
 E7xMnvVJue09XcfqTz3BIDD35V07Uo3yhwCFtHPRY=;
Received: from [2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rb5Pi-0000vT-Jw; Fri, 16 Feb 2024 21:06:34 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Fri, 16 Feb 2024 21:06:30 +0000
Message-Id: <20240216210633.1376066-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
References: <20240216210633.1376066-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:b76e:9764:d1ca:4e3f
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 10/13] esp.c: introduce esp_update_drq() and update
 esp_fifo_{push, pop}_buf() to use it
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

This new function sets the DRQ line correctly according to the current transfer
mode, direction and FIFO contents. Update esp_fifo_push_buf() and esp_fifo_pop_buf()
to use it so that DRQ is always set correctly when reading/writing multiple bytes
to/from the FIFO.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 96aa576601..ca0fa5098d 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -124,6 +124,48 @@ void esp_request_cancelled(SCSIRequest *req)
     }
 }
 
+static void esp_update_drq(ESPState *s)
+{
+    bool to_device;
+
+    switch (esp_get_phase(s)) {
+    case STAT_MO:
+    case STAT_CD:
+    case STAT_DO:
+        to_device = true;
+        break;
+
+    case STAT_DI:
+    case STAT_ST:
+    case STAT_MI:
+        to_device = false;
+        break;
+
+    default:
+        return;
+    }
+
+    if (s->dma) {
+        /* DMA request so update DRQ according to transfer direction */
+        if (to_device) {
+            if (fifo8_num_free(&s->fifo) < 2) {
+                esp_lower_drq(s);
+            } else {
+                esp_raise_drq(s);
+            }
+        } else {
+            if (fifo8_num_used(&s->fifo) < 2) {
+                esp_lower_drq(s);
+            } else {
+                esp_raise_drq(s);
+            }
+        }
+    } else {
+        /* Not a DMA request */
+        esp_lower_drq(s);
+    }
+}
+
 static void esp_fifo_push(ESPState *s, uint8_t val)
 {
     if (fifo8_num_used(&s->fifo) == s->fifo.capacity) {
@@ -137,6 +179,7 @@ static void esp_fifo_push(ESPState *s, uint8_t val)
 static void esp_fifo_push_buf(ESPState *s, uint8_t *buf, int len)
 {
     fifo8_push_all(&s->fifo, buf, len);
+    esp_update_drq(s);
 }
 
 static uint8_t esp_fifo_pop(ESPState *s)
@@ -155,6 +198,7 @@ static uint32_t esp_fifo_pop_buf(ESPState *s, uint8_t *dest, int maxlen)
     int len;
 
     if (maxlen == 0) {
+        esp_update_drq(s);
         return 0;
     }
 
@@ -175,6 +219,7 @@ static uint32_t esp_fifo_pop_buf(ESPState *s, uint8_t *dest, int maxlen)
         n += n2;
     }
 
+    esp_update_drq(s);
     return n;
 }
 
-- 
2.39.2


