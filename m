Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA70C0219B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgL9k-0006zC-Od; Fri, 07 Feb 2025 05:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgL9h-0006vz-6a; Fri, 07 Feb 2025 05:00:13 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgL9f-00025W-EK; Fri, 07 Feb 2025 05:00:12 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2BDBDE734B;
 Fri, 07 Feb 2025 12:59:18 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 959241B09CF;
 Fri,  7 Feb 2025 12:59:59 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 86E9252D7F; Fri, 07 Feb 2025 12:59:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Xiaohui Li <xiaohli@redhat.com>, akihiko.odaki@daynix.com,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 47/49] net: Fix announce_self
Date: Fri,  7 Feb 2025 12:59:49 +0300
Message-Id: <20250207095956.2238705-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250207102656@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250207102656@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Laurent Vivier <lvivier@redhat.com>

b9ad513e1876 ("net: Remove receive_raw()") adds an iovec entry
in qemu_deliver_packet_iov() to add the virtio-net header
in the data when QEMU_NET_PACKET_FLAG_RAW is set but forgets
to increase the number of iovec entries in the array, so
receive_iov() will only send the first entry (the virtio-net
entry, full of 0) and no data. The packet will be discarded.

The only user of QEMU_NET_PACKET_FLAG_RAW is announce_self.

We can see the problem with tcpdump:

- QEMU parameters:

  .. -monitor stdio \
     -netdev bridge,id=netdev0,br=virbr0 \
     -device virtio-net,mac=9a:2b:2c:2d:2e:2f,netdev=netdev0 \

- HMP command:

  (qemu) announce_self

- TCP dump:

  $ sudo tcpdump -nxi virbr0

  without the fix:

    <nothing>

  with the fix:

   ARP, Reverse Request who-is 9a:2b:2c:2d:2e:2f tell 9a:2b:2c:2d:2e:2f, length 46
        0x0000:  0001 0800 0604 0003 9a2b 2c2d 2e2f 0000
        0x0010:  0000 9a2b 2c2d 2e2f 0000 0000 0000 0000
        0x0020:  0000 0000 0000 0000 0000 0000 0000

Reported-by: Xiaohui Li <xiaohli@redhat.com>
Bug: https://issues.redhat.com/browse/RHEL-73891
Fixes: b9ad513e1876 ("net: Remove receive_raw()")
Cc: akihiko.odaki@daynix.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 84dfdcbff33fff185528501be408c25c44499f32)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/net.c b/net/net.c
index 7ef6885876..fefa701bb2 100644
--- a/net/net.c
+++ b/net/net.c
@@ -822,6 +822,7 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
         iov_copy[0].iov_len =  nc->vnet_hdr_len;
         memcpy(&iov_copy[1], iov, iovcnt * sizeof(*iov));
         iov = iov_copy;
+        iovcnt++;
     }
 
     if (nc->info->receive_iov) {
-- 
2.39.5


