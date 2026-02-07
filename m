Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6315EE0AE9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Feb 2026 13:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voign-0004QV-2y; Sat, 07 Feb 2026 08:49:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voiga-0003t1-2i
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:49:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1voigX-0003IV-4f
 for qemu-devel@nongnu.org; Sat, 07 Feb 2026 08:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770472156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgR+tk+UJ3NFFcdM8r6q6wQSuI+asu9PhIQYUGAd+/o=;
 b=EavbAWgM0XwhWBRrxtAiVtX5jduWGF5GqyAHbKG5c88B3WntCGudUrCpEdc8L1wbrkmlfQ
 IS3f71JWa+A5ydofEBtDpXsmfFPNVqvjbY6mhEfUXRAthhUq68hxvyoNQV5LCt5WdtpbA1
 zpezsGLGTmHYfQfEcYBQ7dZ6GVWeJmY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-2r4o3HLJO-ux3JRUtAMImA-1; Sat,
 07 Feb 2026 08:49:12 -0500
X-MC-Unique: 2r4o3HLJO-ux3JRUtAMImA-1
X-Mimecast-MFC-AGG-ID: 2r4o3HLJO-ux3JRUtAMImA_1770472151
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B3141800464; Sat,  7 Feb 2026 13:49:11 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 45D8C18004AD; Sat,  7 Feb 2026 13:49:07 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, qemu-devel@nongnu.org
Subject: [PATCH 11/12] virtio-net: re-apply vnet_hdr state after virtio_load
Date: Sat,  7 Feb 2026 21:47:27 +0800
Message-ID: <20260207134728.1495932-11-lulu@redhat.com>
In-Reply-To: <20260207134728.1495932-1-lulu@redhat.com>
References: <20260207134728.1495932-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

virtio_load() restores guest_features after vmstate post_load hooks. Re-apply
vnet_hdr related state in virtio_net_post_load_virtio() so backend header
lengths match the migrated feature set (important for netfilter pipelines).

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d6d2188863..125aa0108d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3282,6 +3282,21 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
 static int virtio_net_post_load_virtio(VirtIODevice *vdev)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
+    bool has_tunnel_hdr = virtio_has_tunnel_hdr(vdev->guest_features_ex);
+
+    /*
+     * virtio_load() restores guest_features after vmstate post_load hooks.
+     * Re-apply vnet_hdr related state here so the backend vnet_hdr_len and
+     * n->host_hdr_len match the migrated feature set (important for receiving
+     * packets from netfilters like redirector/buffer during COLO/migration).
+     */
+    peer_test_vnet_hdr(n);
+    virtio_net_set_mrg_rx_bufs(n, n->mergeable_rx_bufs,
+                               virtio_vdev_has_feature(vdev,
+                                                       VIRTIO_F_VERSION_1),
+                               virtio_vdev_has_feature(vdev,
+                                                      VIRTIO_NET_F_HASH_REPORT),
+                               has_tunnel_hdr);
     /*
      * The actual needed state is now in saved_guest_offloads,
      * see virtio_net_post_load_device for detail.
-- 
2.52.0


