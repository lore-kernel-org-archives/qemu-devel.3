Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E5B606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=i6NVOp3H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp6I-0003sf-0u; Fri, 27 Nov 2026 01:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp3X-0005WR-6V; Fri, 27 Nov 2026 01:03:36 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp3V-0003XR-9Y; Fri, 27 Nov 2026 01:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759041; bh=7sZOXQeK5rPj529XoEbTEC5X5Dy8rlGvCDOSt3gtVbo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=i6NVOp3H29MztRo+oZobeHWmkRruUAXZReXiuRs3O7yQQSX6Gz4enbTrta9X8c18w
 osBT7SscxF3vN4O266jG4y+Rvkv0b1G7SZZHa2X/jy8est8OUkQw/7EEuri86bFBg8
 SahYWQk5b58tumQbJqX5UJlpzmNKxyD106Dc2DHnyD/0iSkSL5C4RtKFc2VPWmtrnf
 hFKcT7uobrqPdIJTap9q7NfWKbe0qZ4pbUoqV2Qs2BRP9l8MdvCbFzpUjkiF9WKmNH
 3j8pra5AEUSPs0xAdIfdaimDa8J3I99pHooC/l4kzGxk37YswqYQ8KhlTf9YGv7yyJ
 jj82uoCFeC38A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 91AC01EA33D;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8F677469969;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 70C4FCF2CA; Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 076/152] hw/net/net_tx_pkt: Sanity check GSO
 headers in net_tx_pkt_build_vheader()
Date: Fri, 27 Nov 2026 08:53:34 +0300
Message-ID: <20261127055709.39630-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

In net_tx_pkt_build_vheader(), we are insufficiently cautious
about headers from the packet from the guest. Add more checking:
 * that the segment offload payload gso_size isn't 0
 * that the packet is not too small
 * that the TCP th_off is inside the payload
 * that we aren't going to overflow in our header length calculation

Of these, the most significant extra check is in calculation of the
virt_hdr length.  We calculate this with
 pkt->virt_hdr.hdr_len = pkt->hdr_len + l4hdr.th_off * sizeof(uint32_t);

The struct field is 16 bits, and so this can overflow if the guest
hands us a packet of close to 64K in size and an appropriate
l4hdr.th_off. The effect is that we record a bogus virt_hdr.hdr_len,
and later on in net_tx_pkt_tcp_fragment_init() this will cause us
to make a very large allocation that causes g_malloc() to abort.

This is a hardening issue rather than a security issue, because the
amount of guest control over the allocation size is such that it can
only generate allocations very close to SIZE_MAX which always make
g_malloc() abort, and so it's a guest self-denial-of-service only.

Cc: qemu-stable@nongnu.org
Fixes: e263cd49c73c595 ("Packet abstraction for VMWARE network devices")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3648
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20261109-eth-v2-11-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit bd649f019f4d12cea6a658a4878030e0c759cb0e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index b134348fe80..b2935900fe7 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -335,6 +335,11 @@ bool net_tx_pkt_build_vheader(struct NetTxPkt *pkt, bool tso_enable,
         break;
 
     case VIRTIO_NET_HDR_GSO_UDP:
+        if (IP_FRAG_ALIGN_SIZE(gso_size) == 0 ||
+            pkt->payload_len < sizeof(struct udp_header) ||
+            pkt->hdr_len + sizeof(struct udp_header) > UINT16_MAX) {
+            return false;
+        }
         pkt->virt_hdr.gso_size = gso_size;
         pkt->virt_hdr.hdr_len = pkt->hdr_len + sizeof(struct udp_header);
         break;
@@ -344,7 +349,10 @@ bool net_tx_pkt_build_vheader(struct NetTxPkt *pkt, bool tso_enable,
         bytes_read = iov_to_buf(&pkt->vec[NET_TX_PKT_PL_START_FRAG],
                                 pkt->payload_frags, 0, &l4hdr, sizeof(l4hdr));
         if (bytes_read < sizeof(l4hdr) ||
-            l4hdr.th_off * sizeof(uint32_t) < sizeof(l4hdr)) {
+            gso_size == 0 ||
+            l4hdr.th_off * sizeof(uint32_t) < sizeof(l4hdr) ||
+            l4hdr.th_off * sizeof(uint32_t) > pkt->payload_len ||
+            pkt->hdr_len + l4hdr.th_off * sizeof(uint32_t) > UINT16_MAX) {
             return false;
         }
 
-- 
2.47.3


