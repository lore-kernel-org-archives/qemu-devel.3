Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC6EC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wod5w-00018y-Ij; Tue, 28 Jul 2026 04:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wod5v-00018Y-AV
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wod5s-000823-Vi
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785226999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lttZaqrUwFt+oZ5KQ6obExpV89xnr6gMd12tZmJ+0BA=;
 b=COS4eCDRp1Fb+D1c8m1Bt1cJRVbj75Bwot3qmkKMyq8+2605KtmW0nIHjSL7Dchef6wIEs
 GRQZBXJ9j4he+6kV+pNeUXMY50Nj/dyyEU/PEZ+TyI+BRmmN2LZIIlH3h7FBkUtDZCvciL
 KOKjK9BTKP9K9IOyejoqkXpBogWgUjs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-9-HlmzAGMnivxYQJO-LEtw-1; Tue,
 28 Jul 2026 04:23:15 -0400
X-MC-Unique: 9-HlmzAGMnivxYQJO-LEtw-1
X-Mimecast-MFC-AGG-ID: 9-HlmzAGMnivxYQJO-LEtw_1785226994
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFD2919560AD; Tue, 28 Jul 2026 08:23:14 +0000 (UTC)
Received: from lenovo-t14s.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5ECC180049F; Tue, 28 Jul 2026 08:23:12 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org,
 Yuri Benditovich <ybendito@redhat.com>, Sven <bestswngs@gmail.com>
Subject: [PATCH] hw/net/virtio-net: strip trailing padding when caching RSC
 segment
Date: Tue, 28 Jul 2026 10:23:11 +0200
Message-ID: <20260728082311.4179910-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
---
 hw/net/virtio-net.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 814b99a43d20..53796287528a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2195,13 +2195,31 @@ static void virtio_net_rsc_cache_buf(VirtioNetRscChain *chain,
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
2.54.0


