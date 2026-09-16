Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DDEC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kMN-0001Nt-DG; Wed, 16 Sep 2026 03:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kM6-0000Y7-PX; Wed, 16 Sep 2026 03:47:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kM4-0005Lm-Uo; Wed, 16 Sep 2026 03:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544618; bh=7kefvAB12X0/1GvXh9KP0ZRk1BYFccayQLhwWx636TM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RDBizDYSHxKXnmw4p4hK/jE5DRVxucY/REj6wVZIHyDRCuidiabg5Js/S+tFmGroI
 3FfJQiDBOVp2f9U01skem0lBIddueKYjfWBSgehw02c7610IUMl092VYu62NnP3rry
 sSEsQR10eGS1CJgZVrNhNjU3BCPjppnqVEklkoZFo3liD3B0F935D39p9d33ul32Nl
 OysrbwFfOJBY1OB/jgn3VQdsLn6yqxLcWBP2STnqFyyNAN/kg/mzz2EZFC9++ofp8G
 cUX4e+DJUxxt772PW2ckOfrdwFkuBp5Aw1zBsEV7m8beCghHH9Kl6FdBEaiAO+TE6g
 U3Jxw1ZxHuMag==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EB2D01D55B6;
 Wed, 16 Sep 2026 10:43:38 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7A93A429B6F;
 Wed, 16 Sep 2026 10:44:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 49A065A711; Wed, 16 Sep 2026 10:44:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Yuri Benditovich <ybendito@redhat.com>, Sven <bestswngs@gmail.com>,
 Michael S. Tsirkin <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 40/49] hw/net/virtio-net: strip trailing padding when
 caching RSC segment
Date: Wed, 16 Sep 2026 10:42:58 +0300
Message-ID: <20260916074346.671467-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
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
index ad4b0d8d9a1..5954dd70de3 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2202,13 +2202,31 @@ static void virtio_net_rsc_cache_buf(VirtioNetRscChain *chain,
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


