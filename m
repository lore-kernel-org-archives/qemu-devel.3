Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DB5C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n4O-0001fo-Ql; Wed, 16 Sep 2026 06:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n3S-0007au-Ay; Wed, 16 Sep 2026 06:39:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n3Q-00028m-2s; Wed, 16 Sep 2026 06:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789554957; bh=gRtC9Ai0tnc5O4cbrhFyCgkmjJzmeR6tZluv7lJ8n2U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TiBLj8H3tNhqf3T8D25inzhct/h+pSMIfhlemgZvGMF8qOD6xe+LH9CRksDMFNP/H
 kuJdyRoO8/mDjR61a3icBRiyCNCBAQlBbbGJo2BM7+XJF1A9mewh4K9ifv32NqzwDW
 gYZEmU8DEWE1e7VjjPz4Eel8+nFHEH82yN+mLPayMmfl0uyO7nCsE32a4Mit4EMZKo
 LqPuTKszwAfA9Oy+1LJQ/04RW9qDY9RnXT/0cnEetKmsb36fXMcslecRxbBV0Qx/Yr
 cpv/2RyRE12pCx5jpycZE97pkN3Q/KvvzFaJCNRVFRHu700jD+HR9hUokLaw4esD1f
 +yHoSv2gke/Zg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D524E1D5821;
 Wed, 16 Sep 2026 13:35:57 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A0166429F8F;
 Wed, 16 Sep 2026 13:36:40 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 92AB55A837; Wed, 16 Sep 2026 13:36:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Yuri Benditovich <ybendito@redhat.com>, Sven <bestswngs@gmail.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 43/56] hw/net/virtio-net: strip trailing padding when
 caching RSC segment
Date: Wed, 16 Sep 2026 13:36:01 +0300
Message-ID: <20260916103622.684817-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
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

From: Laurent Vivier <lvivier@redhat.com>

When an RSC candidate packet has trailing padding bytes beyond the
declared IP payload, virtio_net_rsc_cache_buf() copies the full wire
size into the coalescing buffer and sets seg->size to that value.
The bounds check in virtio_net_rsc_coalesce_data() uses the IP
length field (o_ip_len) which does not include the padding, so the
check can pass while the subsequent memmove() overflows the buffer.

Fix this by computing the actual IP packet size from the IP header
and using it for both the memcpy and seg->size, so that seg->size
stays in sync with the IP length field. virtio_net_rsc_sanity_check4/6()
guarantees that ip_size <= size.

Fixes: CVE-2026-66900
Fixes: 2974e916df87 ("virtio-net: support RSC v4/v6 tcp traffic for Windows HCK")
Cc: qemu-stable@nongnu.org
Cc: Yuri Benditovich <ybendito@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3879
Reported-by: Sven <bestswngs@gmail.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260728082311.4179910-1-lvivier@redhat.com>
(cherry picked from commit 73c3d017ef6a01f92463b398db61c1c1e430fb6d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 93653581cb6..310a7c2f007 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2199,13 +2199,31 @@ static void virtio_net_rsc_cache_buf(VirtioNetRscChain *chain,
 {
     uint16_t hdr_len;
     VirtioNetRscSeg *seg;
+    size_t ip_size;
 
     hdr_len = chain->n->guest_hdr_len;
+
+    /*
+     * Strip any trailing padding beyond the IP payload so that seg->size
+     * stays in sync with the IP length field used by the bounds check in
+     * virtio_net_rsc_coalesce_data(). virtio_net_rsc_sanity_check4/6()
+     * guarantees that ip_size <= size.
+     */
+    ip_size = hdr_len + sizeof(struct eth_header);
+    if (chain->proto == ETH_P_IP) {
+        struct ip_header *ip = (struct ip_header *)(buf + ip_size);
+        ip_size += htons(ip->ip_len);
+    } else {
+        struct ip6_header *ip6 = (struct ip6_header *)(buf + ip_size);
+        ip_size += sizeof(struct ip6_header)
+                   + htons(ip6->ip6_ctlun.ip6_un1.ip6_un1_plen);
+    }
+
     seg = g_new(VirtioNetRscSeg, 1);
     seg->buf = g_malloc(hdr_len + sizeof(struct eth_header)
         + sizeof(struct ip6_header) + VIRTIO_NET_MAX_TCP_PAYLOAD);
-    memcpy(seg->buf, buf, size);
-    seg->size = size;
+    memcpy(seg->buf, buf, ip_size);
+    seg->size = ip_size;
     seg->packets = 1;
     seg->dup_ack = 0;
     seg->is_coalesced = 0;
-- 
2.47.3


