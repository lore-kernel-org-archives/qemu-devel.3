Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C0BCFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd3x-0002NX-6c; Fri, 21 Nov 2025 21:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcSq-0008AO-T6; Fri, 21 Nov 2025 20:31:01 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcQp-0000pB-E0; Fri, 21 Nov 2025 20:30:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1117716CA71;
 Fri, 21 Nov 2025 21:44:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8DD82321CAD;
 Fri, 21 Nov 2025 21:44:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 54/81] net: pad packets to minimum length in
 qemu_receive_packet()
Date: Fri, 21 Nov 2025 21:43:53 +0300
Message-ID: <20251121184424.1137669-54-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Peter Maydell <peter.maydell@linaro.org>

In commits like 969e50b61a28 ("net: Pad short frames to minimum size
before sending from SLiRP/TAP") we switched away from requiring
network devices to handle short frames to instead having the net core
code do the padding of short frames out to the ETH_ZLEN minimum size.
We then dropped the code for handling short frames from the network
devices in a series of commits like 140eae9c8f7 ("hw/net: e1000:
Remove the logic of padding short frames in the receive path").

This missed one route where the device's receive code can still see a
short frame: if the device is in loopback mode and it transmits a
short frame via the qemu_receive_packet() function, this will be fed
back into its own receive code without being padded.

Add the padding logic to qemu_receive_packet().

This fixes a buffer overrun which can be triggered in the
e1000_receive_iov() logic via the loopback code path.

Other devices that use qemu_receive_packet() to implement loopback
are cadence_gem, dp8393x, lan9118, msf2-emac, pcnet, rtl8139
and sungem.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3043
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit a01344d9d78089e9e585faaeb19afccff2050abf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/net.c b/net/net.c
index 39d6f28158..c2d0d83bc9 100644
--- a/net/net.c
+++ b/net/net.c
@@ -757,10 +757,20 @@ ssize_t qemu_send_packet(NetClientState *nc, const uint8_t *buf, int size)
 
 ssize_t qemu_receive_packet(NetClientState *nc, const uint8_t *buf, int size)
 {
+    uint8_t min_pkt[ETH_ZLEN];
+    size_t min_pktsz = sizeof(min_pkt);
+
     if (!qemu_can_receive_packet(nc)) {
         return 0;
     }
 
+    if (net_peer_needs_padding(nc)) {
+        if (eth_pad_short_frame(min_pkt, &min_pktsz, buf, size)) {
+            buf = min_pkt;
+            size = min_pktsz;
+        }
+    }
+
     return qemu_net_queue_receive(nc->incoming_queue, buf, size);
 }
 
-- 
2.47.3


