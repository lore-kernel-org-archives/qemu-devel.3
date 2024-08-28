Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE600C54FA6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 12:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjHhv-0006Uv-Lj; Wed, 28 Aug 2024 08:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhu-0006QG-8T
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:26 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhs-0001B3-Pg
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 08:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=amnbiaESMVkGu73EcfVAhp7lxkz3+iitVygR2r/zkrI=; b=zs3ZP1YeVDDdkBxkTN2nXbYxo2
 +DTJCZzUYLFGVFm9X3Xz06YGnrPvO5h88yF0Jz7zphb5rX0DWbTRITsoIgnjiGPf8GSW5jFNCos1v
 vWAlyq4XWrn9P9cPubL3afdiURUlo99GRuekEbhcBmnpvCNT0TcSYjGFU6LiV3GeOVs6gzA4p8bFT
 G2UaXn2Z/YpfNM5o/Fw83c6zH8n3r7Rhgs9bp4/Pqv+B0vB+z+zGwiagoTKw2RkZ0lMVRsuSOuSSG
 3dUfazbUmgl67nRY2N+haVOMBWW0SxmBIGpVmsxgbAdPeKsycScpXmfo3dBykvdB74YCBFZWuaYWZ
 lz2fkD7w2fvVrA4jvKOYv2tKW4oXGcOr2xwUjlB+5KEpHDjxYE9O1VXeP4dmQZfoc2V82J9Qxn8fa
 qGQkNor5M02Mslxq4sltuPRMJPdVidOPVpktXertAbfsD5jfadY/Z3rXLLNmyVeDrkM91w3N8Gfgi
 WJZJrVu93gakG6Tag4G5WVMi4QkdqLBbt3BT/MviK+o2wAOzob7SRWqVxFknbrrkNwRXSPaSH1eqv
 9xYE++yXJ+55IuRRxrVB28ShbrXQ+kHeJBrKbUsdIbA3prb3cYYTbe/vjNjcB5cj8B9Z0j+BeoM9H
 8jiv00SsTsoh73P5k/gnDkXVC9yWPtKZdMyAdAkrs=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sjHhZ-000B8d-Uj; Wed, 28 Aug 2024 13:23:10 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: philmd@linaro.org, Alistair.Francis@wdc.com, tavip@google.com,
 qemu-devel@nongnu.org
Date: Wed, 28 Aug 2024 13:22:52 +0100
Message-Id: <20240828122258.928947-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 3/9] fifo8: add skip parameter to fifo8_peekpop_bufptr()
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

The skip parameter specifies the number of bytes to be skipped from the current
FIFO head before the peek or pop operation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 util/fifo8.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index 5faa814a6e..62d6430b05 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -72,18 +72,20 @@ uint8_t fifo8_pop(Fifo8 *fifo)
 }
 
 static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fifo, uint32_t max,
-                                           uint32_t *numptr, bool do_pop)
+                                           uint32_t skip, uint32_t *numptr,
+                                           bool do_pop)
 {
     uint8_t *ret;
     uint32_t num, head;
 
     assert(max > 0 && max <= fifo->num);
-    head = fifo->head;
+    assert(skip <= fifo->num);
+    head = (fifo->head + skip) % fifo->capacity;
     num = MIN(fifo->capacity - head, max);
     ret = &fifo->data[head];
 
     if (do_pop) {
-        fifo->head += num;
+        fifo->head = head + num;
         fifo->head %= fifo->capacity;
         fifo->num -= num;
     }
@@ -95,12 +97,12 @@ static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fifo, uint32_t max,
 
 const uint8_t *fifo8_peek_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
 {
-    return fifo8_peekpop_bufptr(fifo, max, numptr, false);
+    return fifo8_peekpop_bufptr(fifo, max, 0, numptr, false);
 }
 
 const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
 {
-    return fifo8_peekpop_bufptr(fifo, max, numptr, true);
+    return fifo8_peekpop_bufptr(fifo, max, 0, numptr, true);
 }
 
 uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
-- 
2.39.2


