Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BF8C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 09:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKST-0000j4-NV; Wed, 13 Mar 2024 04:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKSR-0000cP-Vb
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:32 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKSQ-0002KQ-Hq
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eIAikjkEW9wDBWxLTvUpNDdrycvYswU4shGYX63s4gI=; b=u7mW8Bj3/hPg9S4kfy5JWjW6F4
 3VhqNxEu0kMzDD/gjPP7miGtXgGxByM+woEIks/RH7IbSfONDVZLnOb6M7WOg7lIr5ri+SM6CHtxO
 kaGioWPRaeJev0gMjEWhb1uAlDyTGKEklZfxEPrGnuOQo5sn6z4mv20+3aEsmPLk6/g93FN+XaMaW
 o7x03SJLz8EYLc3iNFX2axlH+gZCa/N9osjqPLxl2xmuoKCiSQ2EC6Zk+qzeU08XenKS5ECRDLptz
 CwE65vKzGdi13DCvxGmljKpxx4GQ6fU3NHGjaYDWOzTpxR/t8bpX2q9u0rdjfz7iS8FT9o3bVe3jV
 9o6MfDDMQllfMJ9yqxXdli5ANdSb2eXy5MDMa8DTIr3nSS2h+XdDaT6Ws0Cz7yU57G+L0i+SRbKlF
 Y9a49TvlcLQNC47I5hhhaomI79JKye5wP3ID0S9Y0fSwMTJN7JTNhaMMcQtMbtPPNWB/0ZaSC3jea
 buV8Vh7/TIjMk5nJFcF9HgzS2D0L2a6Siptjbqv9lumG5qjWeuD4D224Sn0c7C7Ubu8t/Ud516dxW
 wBUkAKDCkAeuuZTjPqgFH/IOacnX3TCRy2b9itbjBSpxlfyWnBeQ9gCiyCNh6XRzRUjRSRmT5sdg3
 qCDI1+HLZlnrr9PGkKcKG2tFjsJrD+fqjDo37z+wc=;
Received: from [2a00:23c4:8bb3:1000:1218:d855:1998:7fa8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRQ-000CUN-4n; Wed, 13 Mar 2024 08:58:28 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Wed, 13 Mar 2024 08:58:08 +0000
Message-Id: <20240313085810.2655062-15-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1218:d855:1998:7fa8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 14/16] esp.c: update esp_fifo_{push,
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
index 53a1c7ceaf..52a69599b2 100644
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


