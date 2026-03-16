Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03864EFCBBB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:11:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w226V-0007zL-Mk; Mon, 16 Mar 2026 03:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w225n-0007VY-LD; Mon, 16 Mar 2026 03:10:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w225m-0007lZ-2C; Mon, 16 Mar 2026 03:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773645002; bh=jVK/qfgVEH5cnnXZl16F3o/kjCyYnwZdxeWXTPL7H1c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aGUrQMbJTZhpJ6dqM33ZKVb43Tx9HJ3YgZLySPYWiC++2avDEMEX2QerC3RxALOHg
 GtT1giz/dsMYhBsMH71F0z97XePlpyKyNr2N73UqQ5Xf+sggIa4ll25ECQf9N0StAh
 dS5xutmVfTubKMYDZUNqlRajaZoWLwnCaFd6nzI24q4q/9P82hF1lNmmLHorlv2V/I
 OMW1+IubOGsmuukY/UrHS8WTBh1WXkM77s1R07tOQRBsk7K0Ka7hF2P/jgj6KpsnNB
 zTX2J/A33+CzyA/D3oG9b26ktkAIpHhm+e+W21uNo5l/3JKIsBn+3LPU4aCcbPZsMl
 DfkPDjhmLYilw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BE14B193C27;
 Mon, 16 Mar 2026 10:10:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id BC4F738004F;
 Mon, 16 Mar 2026 10:10:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Sergei Heifetz <heifetz@yandex-team.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 05/14] hw/usb/core.c: reorder usage and assertion of p->ep
Date: Mon, 16 Mar 2026 10:09:53 +0300
Message-ID: <20260316071005.91624-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316071005.91624-1-mjt@tls.msk.ru>
References: <20260316071005.91624-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Sergei Heifetz <heifetz@yandex-team.com>

Reorder the code so the assertion of p->ep occurs before it is
used in the subsequent lines.

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/usb/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/core.c b/hw/usb/core.c
index b3f811c513..9572a870cc 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -423,10 +423,10 @@ void usb_handle_packet(USBDevice *dev, USBPacket *p)
         p->status = USB_RET_NODEV;
         return;
     }
+    assert(p->ep);
     assert(dev == p->ep->dev);
     assert(dev->state == USB_STATE_DEFAULT);
     usb_packet_check_state(p, USB_PACKET_SETUP);
-    assert(p->ep != NULL);
 
     /* Submitting a new packet clears halt */
     if (p->ep->halted) {
-- 
2.47.3


