Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D120E6F08E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 22:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6zhl-0004MR-Hb; Fri, 01 Nov 2024 18:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zhi-0004Lx-7w
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 18:01:14 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zhg-0002os-DX
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 18:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=nNbqaq73wvELgQmDX95TXQpt1EGVEYkXwH7FUiKjs7g=; b=Hv3+3VNUp+EQyERTjSYpwf82hM
 tnZEE2ehChvNQgNe15fAwKafKSq6rffVIs1PSHn5BDH4m66dWGF3KqKFq0lQpFQT/up4pKoo21i/F
 DgrHzj3OSuid0sS+O9jNVlchEC073MbgyLlcFWU8q4QKBWOFKUcP2Q2EeaB40MtcVDA21BDGfielS
 L7BTX9VX2OHkeZv9Yp+ESpORMeqyGOjoUw4Y5hV5olmBW+f1mqxIwMO8QVA7qWYZLrlexGiw4ZQFe
 KBHnhdftcYjnQrh2S1AEnlsT7J1lA9fEd2RGSizLtXML04xx8q2Sa1l2eu3UiieW1S6sGiUhG0Pmx
 2mGvDNnVvBcS8z9y2aII0+uazNYrOeYl1woXa8jPy9bIj2pJ4HH4IBOBDmgGfPvPSUmaiuAvO4FvD
 WGZNFlCoWdKmgVrLyk/dYPmgP3DIulEpC2azw1GUQbCXiWl2ZDFTzpRWs4rISbL4wcIPYbG87t1rF
 e3bk1Yp+8sgL3YIogdMOQPE7AyWytv2gQJxStPiEYVBuY76VwZeCSQAMbbqu/U/tzi+NksuwZRjHz
 7rC7iLL0hi4j7nph7olH9SaKp6iGhP4K7nPARyeEFTjs0JO5l0WsAV/1fnZmOLKBhOFFJTWK3BnAL
 v6Myqr/TEX3W44SS6RF8n82pKNQ7flsxFRMWw2vb4=;
Received: from [2a00:23c4:8bb8:f600:91a1:336d:3931:745]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zhG-0002pk-Un; Fri, 01 Nov 2024 22:00:51 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Fri,  1 Nov 2024 22:00:50 +0000
Message-Id: <20241101220052.1463805-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101220052.1463805-1-mark.cave-ayland@ilande.co.uk>
References: <20241101220052.1463805-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:91a1:336d:3931:745
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 3/5] esp.h: remove separate ESPState typedef
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

This is not needed as it is now handled by the OBJECT_DECLARE_SIMPLE_TYPE() macro.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/hw/scsi/esp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 533d856aa3..c9afcb7cac 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -14,8 +14,6 @@ typedef void (*ESPDMAMemoryReadWriteFunc)(void *opaque, uint8_t *buf, int len);
 #define ESP_FIFO_SZ 16
 #define ESP_CMDFIFO_SZ 32
 
-typedef struct ESPState ESPState;
-
 #define TYPE_ESP "esp"
 OBJECT_DECLARE_SIMPLE_TYPE(ESPState, ESP)
 
-- 
2.39.5


