Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E505C606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 05:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=MhIAChjT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQHzf-00075B-80; Mon, 09 Nov 2026 00:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHzK-0006uk-UJ; Mon, 09 Nov 2026 00:32:16 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQHzG-0006HY-IO; Mon, 09 Nov 2026 00:32:14 -0500
Received: from [10.42.0.1] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A95VLtZ046789
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 14:31:36 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ZKb5PN6RhPS1l3+YDe3BEoCbM5fz7xEF9hZR8A16oZ8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794202296; v=1;
 b=MhIAChjTBa8oIaC/YpLR7Ldv7CUnkEY8ZSe6EPmO6mrWX1BJKLPa4NnKGucM22F7
 gwsPOzfVe6sxG0/5X7ticnGoB6vvrp9xNgiEpy4IHAo+fTq6gLmGR4iBuSo/sn0x
 Al2FbtF+QrXjGh/BNJDlifE0rIU9BQYwMuJzT3KMFH5NtyhrjruieUdgqzynxYRH
 NkScjP7j12QZJLSnIYLWEyJYtKjv+wMgYWirHafhxjlxdfFh3rBIj1ifiW4PJfsQ
 Wboyz9iDnIKw/7dm0nnXw/3vca+OdPT317H/mYusAXT9u+QlottYgfc2qYcpIqWp
 KSuaHXLHyAwmJ2yOF/5f6Q==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 14:23:56 +0900
Subject: [PATCH v2 11/14] hw/net/net_tx_pkt: Sanity check GSO headers in
 net_tx_pkt_build_vheader()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-eth-v2-11-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
References: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowangio@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-stable@nongnu.org
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2886;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=aw/3ouOQZLGh3jgpEqT+G3NA5+gdqPYnnaYVqZGfkGw=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHqGX6jenan2yYfvnnhhhdq95hlXta4d+yS2bH+Yut/
 xXwr+DpKGVhEONikBVTZEkp2s2tEV37qTAhvgVmDisTyBAGLk4BmMi8dIa/EqlmvtaLjzuXtq+L
 lnoaKFW6jld9z2VPKU8jHbdHy597M/z31st9Ws2/Rtutd/9z20U/vqkwuvGZ20W6aDWsK7y/XYc
 PAA==
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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
---
 hw/net/net_tx_pkt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index b134348fe809..b2935900fe7f 100644
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
2.56.0


