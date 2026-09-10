Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9FCC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4oiu-0006uE-F7; Thu, 10 Sep 2026 20:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lXR-0006iC-N6
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lXB-0004ki-9R
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZhK7m7LfrlPcMC5A9kLcc4Id8ZYHnzxhU78CaEvxc74=;
 b=cy8tgEjQU9kmsOxpV0MJxPq1Du+cJ7umIHkK0t/4HRiJ6LPqqDr913HLz4fEsZjcg1jRI/
 Lkni9r9YecpUKUbRezV18WcMAf2W+2xiTy1KLTR2F9oG5wPgVP5zZCmiMGL9H5sw11SO9m
 qA/Lx9wYWi04MSi5RqLH0AmI+N65kq0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-JCdXtTEgO1WFMMYOrzn3Dw-1; Thu, 10 Sep 2026 16:12:48 -0400
X-MC-Unique: JCdXtTEgO1WFMMYOrzn3Dw-1
X-Mimecast-MFC-AGG-ID: JCdXtTEgO1WFMMYOrzn3Dw_1789071167
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4955e865174so799585e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071167; x=1789675967; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZhK7m7LfrlPcMC5A9kLcc4Id8ZYHnzxhU78CaEvxc74=;
 b=SclS1a93sL3P2xG79mhp4gSE5QdHcD+8FhLo7lUm2aR0RmTzbClMtiWEUt0W7QoTuo
 NpfAu/98l6xsTfYyfuARPW+NRm/GzzyBzEYJQ9OPIAqUSl57EMq4YcI71gxKmQMS5EPo
 JUMU1fKKHx+dX4UcfbQAQtaqip7FUwrW3bAt/34Pv+Dq3liHT2UCamL74fX7BoE3qVFw
 zsu43auP6SymRPjkoRwbWJUqrf4XIDtaV6XA6cemU4fvX6tyAmsmg8c8wo72CvMJwAwA
 BGrCK4W+73VpKVA8grZ2aiSqcLmo16k9EWts9ZT5sDo4i0aVvm+eFeRX0puaLqjuY+PI
 z+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071167; x=1789675967;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZhK7m7LfrlPcMC5A9kLcc4Id8ZYHnzxhU78CaEvxc74=;
 b=Y8bZggdhqbYRaJx1NI9Gkkkv5Jov8gPCr8VnBo2IQHZO1hj2LL7+3qH8f/axl9wCvv
 VFRPsFbj1UlvqkSRPvIMu4i8+EO2ZB2ALa88S3PxFZ9NUwNjvfdD+kNjsWma9SufDIvO
 /nF3zxZ8bKYOaoZVGGkWAoatkKHOG27kgUx1dNycHT4byWO3kWdoHnRM8fZFIBtp7kvS
 exSMEG7csoZovSLeNjAHOx0FL+2n8lBe9EE+qH6wk4kckYI6Hs1R6MdblB1dIScvf383
 dx/Kd1b8/zP3O3SxPgZaQwjuZwdB2d0ZLrpzYlXkScDuK1Yy+Tv5cDdEcyGM6FiQ+Sx2
 2cxw==
X-Gm-Message-State: AFuF++nrOuk14XNSF7rIESGlfkkfk8LOYhAtaH0jIsC0PI/u1e7YL+Mb
 Rx7TJBcrQDP+pHOI08IDDSvz+YPo08ND7GOls2UCG//1HVbjXP3xxzfQmQUBKZjA69EM+w9S1Hp
 aYoJt7Zyr7ATjAnaPuRL06uPXCG0Xbrcy+EVDq7ODnuxj/eba7uJ7hO1TuaqEnTg1J7wi7WSpUW
 wJ8K40pCy0L3le9swPWlF0A1JwBDOhBEy1Sg==
X-Gm-Gg: AYBFou0Cq6EKQVEWvDFZvGude/uIMzFzVXXHNJc7znkPvFDjgcAPlcHQsER/nTTxff4
 PSQOHuwlyzKHJJ0QJFL5A8Vwdn91A6/aK3Lu5N72i+TMJAJ/Mdvu5bSzf2Suwhtr9A7b3DMKuL4
 KEHPtixGL3kQPfSUF7s///wEYcnGS16nij+2B7cT73F12IWAm2maxSryaV8efbGkKjj61FHpsiO
 dxLw7leUKZbEZVLhPEjRnZ0ibdOuPRs3TiuT0P5m+Llv0bSZLeZmXc06VdZ+/W06uTDCxt5sBsE
 V4WhWQ9+cuVSAcn1r9UQxQOdmwYAVXqeUFJ4hG/K7iOw8Ej50jB0da2yqZv7+xABAkAjHYRRfW5
 1x7dhaItCLR2/e6KrnCcGrkY=
X-Received: by 2002:a05:600c:3b1f:b0:49c:cee2:1697 with SMTP id
 5b1f17b1804b1-49e619e0f85mr7002995e9.16.1789071167430; 
 Thu, 10 Sep 2026 13:12:47 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1f:b0:49c:cee2:1697 with SMTP id
 5b1f17b1804b1-49e619e0f85mr7002525e9.16.1789071166939; 
 Thu, 10 Sep 2026 13:12:46 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb359f38sm689277f8f.30.2026.09.10.13.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:45 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 31/90] virtio-net: support local migration of backend
Message-ID: <9d1c9893233c0fd5da2b238441042b047e36fce0.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Next commit will introduce live-migration (with fd-passing) for
TAP net backend. So, now we prepare virtio-net for it
Add virtio-net option local-migration, which is true by default,
but false for older machine types, which doesn't support the feature.

We introduce interface for live-migrating backends:

1. ->is_wait_incoming() handler, so that virtio-net knows, that
   backend is not fully intialized, as it waits for incoming migration
   stream.

2. MIG_PRI_BACKEND priority: backends should migrate with higher
   priority than virtio-net, so that we can do final preparations
   here in post-load handlers and be sure, that backends are already
   prepared.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-14-vsementsov@yandex-team.ru>
---
 include/hw/virtio/virtio-net.h |  1 +
 include/migration/vmstate.h    |  2 +
 include/net/net.h              |  2 +
 hw/net/virtio-net.c            | 89 +++++++++++++++++++++++++++++++++-
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 371e376428..8c967760c2 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -230,6 +230,7 @@ struct VirtIONet {
     struct EBPFRSSContext ebpf_rss;
     uint32_t nr_ebpf_rss_fds;
     char **ebpf_rss_fds;
+    bool peers_wait_incoming;
 };
 
 size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index e72c3fae9a..7d2b786382 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -169,6 +169,8 @@ typedef enum {
 
     MIG_PRI_LOW,                /* Must happen after default */
     MIG_PRI_DEFAULT,
+    MIG_PRI_BACKEND,            /* Must happen before emulated devices, */
+                                /* e.g. virtio-net */
     MIG_PRI_IOMMU,              /* Must happen before PCI devices */
     MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
     MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */
diff --git a/include/net/net.h b/include/net/net.h
index ea07760b56..fdf6a2ddd4 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -82,6 +82,7 @@ typedef void (SocketReadStateFinalize)(SocketReadState *rs);
 typedef void (NetAnnounce)(NetClientState *);
 typedef bool (SetSteeringEBPF)(NetClientState *, int);
 typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
+typedef bool (IsWaitIncoming)(NetClientState *);
 typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
 
 typedef struct NetClientInfo {
@@ -110,6 +111,7 @@ typedef struct NetClientInfo {
     NetAnnounce *announce;
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
+    IsWaitIncoming *is_wait_incoming;
     GetVHostNet *get_vhost_net;
 } NetClientInfo;
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 814b99a43d..274fbcb0d6 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -40,6 +40,7 @@
 #include "migration/misc.h"
 #include "standard-headers/linux/ethtool.h"
 #include "system/system.h"
+#include "system/runstate.h"
 #include "system/replay.h"
 #include "trace.h"
 #include "monitor/qdev.h"
@@ -3079,7 +3080,17 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
     n->multiqueue = multiqueue;
     virtio_net_change_num_queues(n, max * 2 + 1);
 
-    virtio_net_set_queue_pairs(n);
+    /*
+     * virtio_net_set_multiqueue() called from set_features(0) on early
+     * reset, when peer may wait for incoming (and is not initialized
+     * yet).
+     * Don't worry about it: virtio_net_set_queue_pairs() will be called
+     * later from virtio_net_post_load_device(), and anyway will be
+     * no-op for local incoming migration with live backend passing.
+     */
+    if (!n->peers_wait_incoming) {
+        virtio_net_set_queue_pairs(n);
+    }
 }
 
 static int virtio_net_pre_load_queues(VirtIODevice *vdev, uint32_t n)
@@ -3108,6 +3119,17 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
 
     virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
 
+    if (n->peers_wait_incoming) {
+        /*
+         * Excessive feature set is OK for early initialization when
+         * we wait for local incoming migration: actual guest-negotiated
+         * features will come with migration stream anyway. And we are sure
+         * that we support same host-features as source, because the backend
+         * is the same (the same TAP device, for example).
+         */
+        return;
+    }
+
     if (!peer_has_vnet_hdr(n)) {
         virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
         virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO4);
@@ -3204,6 +3226,7 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     int i, link_down;
     bool has_tunnel_hdr = virtio_has_tunnel_hdr(vdev->guest_features_ex);
+    Error *local_err = NULL;
 
     trace_virtio_net_post_load_device();
     virtio_net_set_mrg_rx_bufs(n, n->mergeable_rx_bufs,
@@ -3261,6 +3284,20 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     }
 
     virtio_net_commit_rss_config(n);
+
+    /*
+     * If live-migration is enabled for some backend, than backend
+     * has already been migrated at higher priority (MIG_PRI_BACKEND)
+     * and virtio_net_vnet_post_load() has already called
+     * peer_test_vnet_hdr().  Recompute host_features so that virtio-net
+     * reflects the capabilities of the restored backend.
+     */
+    virtio_net_get_features(vdev, &vdev->host_features, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -EINVAL;
+    }
+
     return 0;
 }
 
@@ -3411,6 +3448,14 @@ static int virtio_net_vnet_post_load(void *opaque, int version_id)
 {
     struct VirtIONetMigTmp *tmp = opaque;
 
+    /*
+     * If live-migration is enabled for some backend, than backend
+     * has already been migrated at higher priority (MIG_PRI_BACKEND),
+     * so n->has_vnet_hdr can be refreshed from the live backend right
+     * here.
+     */
+    peer_test_vnet_hdr(tmp->parent);
+
     if (tmp->has_vnet_hdr && !peer_has_vnet_hdr(tmp->parent)) {
         error_report("virtio-net: saved image requires vnet_hdr=on");
         return -EINVAL;
@@ -3890,6 +3935,42 @@ static bool failover_hide_primary_device(DeviceListener *listener,
     return qatomic_read(&n->failover_primary_hidden);
 }
 
+static bool virtio_net_check_peers_wait_incoming(VirtIONet *n, bool *waiting,
+                                                 Error **errp)
+{
+    bool has_waiting = false;
+    bool has_not_waiting = false;
+
+    for (int i = 0; i < n->max_queue_pairs; i++) {
+        NetClientState *peer = n->nic->ncs[i].peer;
+        if (!peer) {
+            continue;
+        }
+
+        if (peer->info->is_wait_incoming &&
+            peer->info->is_wait_incoming(peer)) {
+            has_waiting = true;
+        } else {
+            has_not_waiting = true;
+        }
+
+        if (has_waiting && has_not_waiting) {
+            error_setg(errp, "Mixed peer states: some peers wait for incoming "
+                       "migration while others don't");
+            return false;
+        }
+    }
+
+    if (has_waiting && !runstate_check(RUN_STATE_INMIGRATE)) {
+        error_setg(errp, "Peers wait for incoming, but it's not an incoming "
+                   "migration.");
+        return false;
+    }
+
+    *waiting = has_waiting;
+    return true;
+}
+
 static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -4027,6 +4108,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->nic->ncs[i].do_not_pad = true;
     }
 
+    if (!virtio_net_check_peers_wait_incoming(n, &n->peers_wait_incoming,
+                                              errp)) {
+        virtio_cleanup(vdev);
+        return;
+    }
+
     peer_test_vnet_hdr(n);
     if (peer_has_vnet_hdr(n)) {
         n->host_hdr_len = sizeof(struct virtio_net_hdr);
-- 
MST


