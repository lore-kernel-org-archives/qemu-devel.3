Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277F5C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjfHm-0001Op-NP; Tue, 14 Jul 2026 11:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjfHi-0001Lx-1K
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:43:02 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjfHf-00084S-VO
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 11:43:01 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c1b:16:0:640:bc52:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 9CA2780B09;
 Tue, 14 Jul 2026 18:42:58 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:c5a::1:8])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id lgRdV71YDKo0-oIvU4MyO; Tue, 14 Jul 2026 18:42:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784043778;
 bh=rk3jpiKczHrXG+RJOKOqlMLCq/7RFqs8/9lPtTVxFxo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=SN4hxk0fN5LZG3ZXKMYe54u7kM0aLEnFp0rfX1skV6qox7DwB8uXpWnXjQg8GBmxt
 LuAfFG5oSlld2tpVo4d5fXfW+n+hFx9e8SIwWRCirnctez3eRD4B6cVfnuCbZ77gI1
 VcNDrQhzMXYYB/0wsmdfe7dz6dn9aJphVj3Nyj9g=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v19 11/15] virtio-net: support local migration of backend
Date: Tue, 14 Jul 2026 18:42:39 +0300
Message-ID: <20260714154246.1242856-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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
---
 hw/net/virtio-net.c            | 89 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-net.h |  1 +
 include/migration/vmstate.h    |  2 +
 include/net/net.h              |  2 +
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f0e3beb2903..c6e7f7a370f 100644
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
@@ -3060,7 +3061,17 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
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
@@ -3089,6 +3100,17 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
 
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
@@ -3185,6 +3207,7 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     int i, link_down;
     bool has_tunnel_hdr = virtio_has_tunnel_hdr(vdev->guest_features_ex);
+    Error *local_err = NULL;
 
     trace_virtio_net_post_load_device();
     virtio_net_set_mrg_rx_bufs(n, n->mergeable_rx_bufs,
@@ -3242,6 +3265,20 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
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
 
@@ -3392,6 +3429,14 @@ static int virtio_net_vnet_post_load(void *opaque, int version_id)
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
@@ -3871,6 +3916,42 @@ static bool failover_hide_primary_device(DeviceListener *listener,
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
@@ -4008,6 +4089,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
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
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 371e3764282..8c967760c2a 100644
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
index 1b7f295417e..bbc569adc52 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -178,6 +178,8 @@ typedef enum {
 
     MIG_PRI_LOW,                /* Must happen after default */
     MIG_PRI_DEFAULT,
+    MIG_PRI_BACKEND,            /* Must happen before emulated devices, */
+                                /* e.g. virtio-net */
     MIG_PRI_IOMMU,              /* Must happen before PCI devices */
     MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
     MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */
diff --git a/include/net/net.h b/include/net/net.h
index bdf16bb3e64..658b0d0aaf1 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -81,6 +81,7 @@ typedef void (SocketReadStateFinalize)(SocketReadState *rs);
 typedef void (NetAnnounce)(NetClientState *);
 typedef bool (SetSteeringEBPF)(NetClientState *, int);
 typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
+typedef bool (IsWaitIncoming)(NetClientState *);
 typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
 
 typedef struct NetClientInfo {
@@ -109,6 +110,7 @@ typedef struct NetClientInfo {
     NetAnnounce *announce;
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
+    IsWaitIncoming *is_wait_incoming;
     GetVHostNet *get_vhost_net;
 } NetClientInfo;
 
-- 
2.43.0


