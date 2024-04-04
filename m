Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B7FCD1299
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO3W-0005GE-9Q; Thu, 04 Apr 2024 10:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO3L-0005Af-TX
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:56 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO3K-00069J-CT
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=coXnANMghsafE8uP1sD5CawllyACVo682BarUP9QGNc=; b=AS8mxmegJgC88LLv6ipHIAclQd
 Bt8iYJGox0U0zzx8fakv1NsM8v9DzFzUDtR0NK34ny3MwzjgGTAfzeXOFFRH6wPfsLE8nmedm5Nxf
 gHJzka/uRJ/UCvgjIFVvdemhnykbQLkmWQiZ0GSFVVmQ7dMOTYZ9ngGMrkdw/Q3iZutP07olNGokh
 Ew/UZ/TxtTlgLpf/7wa59ifQ4CWdBM1CQXY8h7SATXYmR/sijNd47MLMugNSQ3aT6gcrmFdM1/g02
 ktQxSjEZMoEAfz5BI3ERP4/xPiKJ2cl2JR+eZR4DZqKyUXFcxpeYRyT0vrEU3TGzHctJx0lUDDq2Q
 Y9ziX61pUYnnEEyVweHCydsRUsHVn9mCDDWkqmBYJTasECchLgbieqBZttBhrje5UvWUxYL7n3oNI
 1FwLGhFPTdKooh3mmzZZA7iFIh9QjbOwgKPpaFwIFbRgPtiR/eNAdDuy8vQSUXM3p73PEoVMG1YeA
 Ec5OcpbFqthGUICC5anuSNndTZu8ecSz1ueuU1WAZ3ldjLDBRqNJ4kZAXxHXCUxrranKoylZsDUCp
 2yFj4kWI1LsnbI4T6TC36oGVpOXrBvMZ3Z1A9Ze9zEhgwrkEpXAvcpNBMCtkwQcNfiTFT3wZVxEFo
 7cVurCZLJTNsOLcteG1xQ/ByxmidMihK3TOry1s8s=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2B-000Bmt-UR; Thu, 04 Apr 2024 15:25:47 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:36 +0100
Message-Id: <20240404142539.711134-15-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 14/17] esp.c: introduce esp_update_drq() and update
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

This new function sets the DRQ line correctly according to the current transfer
mode, direction and FIFO contents. Update esp_fifo_push_buf() and esp_fifo_pop_buf()
to use it so that DRQ is always set correctly when reading/writing multiple bytes
to/from the FIFO.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240324191707.623175-15-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9e35c00927..6fd1a12f23 100644
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
@@ -180,7 +223,10 @@ static uint32_t esp_fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, int maxlen)
 
 static uint32_t esp_fifo_pop_buf(ESPState *s, uint8_t *dest, int maxlen)
 {
-    return esp_fifo8_pop_buf(&s->fifo, dest, maxlen);
+    uint32_t len = esp_fifo8_pop_buf(&s->fifo, dest, maxlen);
+
+    esp_update_drq(s);
+    return len;
 }
 
 static uint32_t esp_get_tc(ESPState *s)
-- 
2.39.2


