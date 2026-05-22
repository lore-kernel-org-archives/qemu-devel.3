Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8F3CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXb2-0001Lw-7g; Fri, 22 May 2026 17:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXaN-0000Un-Rk; Fri, 22 May 2026 17:39:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXaK-0002iz-5r; Fri, 22 May 2026 17:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485683; bh=WV4T/svhfK4my9Dm993k/8H9ELLbyrb6My9ko+knJWg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tujNc/R2oyVD2AAovqzQWVyH+RVtvWbRkSWIPnosatvq0Vx7q+KSRsIi3naDI6DIJ
 79vgirrtJPBF6F22r6Ok2svKBFvGiOsH/4q3N/0MhQHng8n8jQVh1XuE/4dL7ZhNwU
 FuKorkemyHd0TeClqH0rNDq/4loKPoxR0MjfIpMJVqxMvL3WbLXHQh015jCWLpB1Ot
 Y/OFgdEDil2F/V+9w+Mph4Q4RO4W7MeMJLGEWbXWI6XvJU2p8LRZQk+e4dhxW10bZl
 BMOJ7R57joHqOBxyHOZWjElznmaYTiwASOOvhhpBEwJfSAiVB+NCZcL1ulDvAga1TM
 VJRUDYqfn1w6g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1D2441AFB04;
 Sat, 23 May 2026 00:34:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 404363B7184;
 Sat, 23 May 2026 00:34:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Katherine Leaver <katherine.j.leaver@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 115/136] aspeed/hace: Fix out-of-bounds read in
 has_padding()
Date: Sat, 23 May 2026 00:34:23 +0300
Message-ID: <20260522213446.806182-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Cédric Le Goater <clg@redhat.com>

The has_padding() function reads the last 8 bytes of a DMA buffer
without validating req_len. req_len is guest-controlled (via
R_HASH_SRC_LEN register or scatter-gather entries) and values less
than 8 cause integer underflow. This can result in an out-of-bounds
read of QEMU process memory.

Add a check to ensure req_len >= 8 before accessing the buffer.

Reported-by: Katherine Leaver <katherine.j.leaver@gmail.com>
Cc: qemu-stable@nongnu.org
Fixes: 5cd7d8564a8b ("aspeed/hace: Support AST2600 HACE")
Link: https://lore.kernel.org/qemu-devel/20260504213421.710035-2-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit 534a52755befa7b8d49c921f8dc964185903efae)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 96997a03fc..212703cbe4 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -112,6 +112,14 @@ static bool has_padding(AspeedHACEState *s, struct iovec *iov,
                         hwaddr req_len, uint32_t *total_msg_len,
                         uint32_t *pad_offset)
 {
+    /* Need at least 8 bytes to read the total message length field */
+    if (req_len < 8) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid request length=0x%" HWADDR_PRIx "\n",
+                      __func__, req_len);
+        return false;
+    }
+
     *total_msg_len = (uint32_t)(ldq_be_p(iov->iov_base + req_len - 8) / 8);
     /*
      * SG_LIST_LEN_LAST asserted in the request length doesn't mean it is the
-- 
2.47.3


