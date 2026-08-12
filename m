Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A049C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8fA-0002Aj-5o; Wed, 12 Aug 2026 09:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8f8-00026x-3P; Wed, 12 Aug 2026 09:06:30 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8f5-0004zi-R8; Wed, 12 Aug 2026 09:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=Z+pQRnfF0hWJpexbuGJPNPabVbGRvRKIYyYPgsztAG0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gKEeyeEh53rtQ7W5CNcJz/xbbk8Ns0KbLuITDlXLCyK12xSGmAuu5egribVHDZ4FT
 OPgWXgYUBYbrLKMx5/XQdLTXPYxvsVHHz0DvhTPJcTP8jmtRnyI2j3JUlPkdgWNDUo
 v1pa0iyMsSzGJIb57JZmZGmG3ITXEaJckjgyjiUxA2CupTlowOanBbgQ5KjhJ3kgFG
 l8JRor+YNDoMdyDtLh6jOdANM1PL2nTKQI5P6Cr+xHRrlZlBZ7kL2c1Ze5eiOPFAYg
 HtluuR2eOTjbzBghZGn119QKhym8pN3NkSduXTlrvF4iMFgGXdfgDcWZQMbYDSuxaK
 hOasNzFBhGE8Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD3611CA4A4;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id F2BB1409B87;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2BC342F8DE; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 huntr bubble <bubblehuntr@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 037/102] virtio-net: fix short frame OOB read in
 receive_filter()
Date: Wed, 12 Aug 2026 16:01:12 +0300
Message-ID: <20260812130233.621965-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: "Michael S. Tsirkin" <mst@redhat.com>

Within virtio-net, receive_filter() reads Ethernet header fields without
any length checks.

But virtio-net sets do_not_pad in NetClientState, so backends such as
socket forward frames at the size supplied by the peer without padding
to the Ethernet minimum. A short frame thus causes an out-of-bounds
read.

Add size checks in receive_filter() and drop the truncated frames.

Fixes: CVE-2026-63320
Fixes: 3831ab2094 ("qemu:virtio-net: Enable filtering based on MAC, promisc, broadcast and allmulti (Alex Williamson)")
Cc: Jason Wang <jasowangio@gmail.com>
Cc: Alex Williamson <alex@shazbot.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3626
Reported-by: huntr bubble <bubblehuntr@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <ee5c77b96ab66b2dd518f146def8727216a5c495.1784895727.git.mst@redhat.com>
(cherry picked from commit 772488562053c1299fc3667a49b3ff1858f83979)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 1f603179173..24256e866cd 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1750,10 +1750,21 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
     if (n->promisc)
         return 1;
 
+    if (size < n->host_hdr_len + 14) {
+        /* Truncated ethernet packet */
+        return 0;
+    }
+
     ptr += n->host_hdr_len;
 
     if (!memcmp(&ptr[12], vlan, sizeof(vlan))) {
-        int vid = lduw_be_p(ptr + 14) & 0xfff;
+        int vid;
+
+        /* Truncated vlan packet */
+        if (size < n->host_hdr_len + 16) {
+            return 0;
+        }
+        vid = lduw_be_p(ptr + 14) & 0xfff;
         if (!(n->vlans[vid >> 5] & (1U << (vid & 0x1f))))
             return 0;
     }
-- 
2.47.3


