Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0FA606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=KoUrk1Uw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWovb-0003pd-4g; Fri, 27 Nov 2026 00:55:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWovW-0003bw-SY; Fri, 27 Nov 2026 00:55:19 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWovU-0007XE-Ue; Fri, 27 Nov 2026 00:55:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758870; bh=7sZOXQeK5rPj529XoEbTEC5X5Dy8rlGvCDOSt3gtVbo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KoUrk1Uw3kn4Lnr9gMojfu3t/iBnbboswIcElD2TnNtUQ/6cqF+jij1qyNzO7xs20
 vOhqvgRvPrxCNOAuXbonSIfvnBp9XJoviq75KVkunwBf0Ng4WmQWo2sC8UW0nybDlp
 xJGtfTKyp7Lc6dE+kB+U/RJFwcndhALR6NeuyTNaQ9L0iSS8Vqp67FHY3901+CpCdq
 smj+ZUYPDGMiZkPmYjVWfqOVUsXOHuYhO04Fvlh38iq7DE/hG0LXNGq9/S5AubuCKh
 jPYZpb3rv25m0+WHtDeqjftszQwkJIBtDIi4pw4zsmuWB1kFQg49E8fHl9jObFk1l1
 na9Ltr+5709Cg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D08181EA2CE;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CE2A346990C;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B4404CF224; Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 071/140] hw/net/net_tx_pkt: Sanity check GSO
 headers in net_tx_pkt_build_vheader()
Date: Fri, 27 Nov 2026 08:52:57 +0300
Message-ID: <20261127055421.39015-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
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


