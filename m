Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AC8CD1280
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 19:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTMA-0007nd-Ma; Sun, 24 Mar 2024 15:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTM9-0007cW-7d
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:09 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTM7-0005Md-Of
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QQUISc806oP3oomne8Ih+d9PgFxM/lENk1KtzGHEb8U=; b=VTgjCmqTGJK5o8arJXnEBVP2cn
 XD2ryFzs13dlX0frBBPZrIgq/y3NJSgWwTGr6ciAJwAf97vzW/6LTn/xVbtrlzow4OECFAqTManpZ
 o41ogvp1rJcMRXKo72orEOZeBvphXq2TQrt5XPGnH+J+kmga1sHvPW8N98ZfUsLZKYnHAlAbhS34F
 0TjCTjUIfBYVMWNGo8KVRYdY+aaLwTmqzvlmhh7QLYivwXWeCf5U/JwGcy58qteKO3Yc1Lt6izhFS
 e9PmRor46UpP36Fujz8jjvoDPT5NYw8qlBcA+puBkWdRnEM2RoIoNsbLJ6hPdz+bMkYAY8RvG53rC
 ulK0Zdg+58LXIthPfIrlJtMGP3L7gaYe5OWyKfIHGzeYJZOWYnBd9aOPj4ofZZmO3Dn8z4l4ie7zI
 4biZqIS7q5LiqoJrRFJ/pHnXB9qkLw0RI3W6T9ayw5tKEwCFnXNziwgHia31hMODCwp6u00/ed3cG
 FMah8HF4o+cYCPQnDA6wSzy+Stmw8E7IIJGHGk5ZzspryMyh0s5169vazwM9Xw75WTgVDWj3NWznI
 aFE95guwY/qFVBqYpi1MTyoxWix72/9nGhLdJ5Pj/N41ABrg1FWMqV0ZqcQfviZiJn4bVBVULwEjb
 v1hnAOh2uCr/LJCi966m0B76fKONFBvIYPQpJ+vEA=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTL9-0000dj-KQ; Sun, 24 Mar 2024 19:17:11 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:17:01 +0000
Message-Id: <20240324191707.623175-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 12/17] esp.c: prevent cmdfifo overflow in esp_cdb_ready()
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

During normal use the cmdfifo will never wrap internally and cmdfifo_cdb_offset
will always indicate the start of the SCSI CDB. However it is possible that a
malicious guest could issue an invalid ESP command sequence such that cmdfifo
wraps internally and cmdfifo_cdb_offset could point beyond the end of the FIFO
data buffer.

Add an extra check to fifo8_peek_buf() to ensure that if the cmdfifo has wrapped
internally then esp_cdb_ready() will exit rather than allow scsi_cdb_length() to
access data outside the cmdfifo data buffer.

Reported-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f47abc36d6..d8db33b921 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -429,13 +429,23 @@ static bool esp_cdb_ready(ESPState *s)
 {
     int len = fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset;
     const uint8_t *pbuf;
+    uint32_t n;
     int cdblen;
 
     if (len <= 0) {
         return false;
     }
 
-    pbuf = fifo8_peek_buf(&s->cmdfifo, len, NULL);
+    pbuf = fifo8_peek_buf(&s->cmdfifo, len, &n);
+    if (n < len) {
+        /*
+         * In normal use the cmdfifo should never wrap, but include this check
+         * to prevent a malicious guest from reading past the end of the
+         * cmdfifo data buffer below
+         */
+        return false;
+    }
+
     cdblen = scsi_cdb_length((uint8_t *)&pbuf[s->cmdfifo_cdb_offset]);
 
     return cdblen < 0 ? false : (len >= cdblen);
-- 
2.39.2


