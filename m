Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242CDC5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkcd-0004MG-9l; Wed, 19 Aug 2026 14:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwkca-0004KX-Gk
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:02:40 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwkcY-0007RF-Dy
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:02:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 37662C0D2F;
 Wed, 19 Aug 2026 21:02:37 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:c60::1:5])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id M2bUThDaVKo0-y4SgSE5D; Wed, 19 Aug 2026 21:02:36 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787162556;
 bh=7RK20YNslrCWlxEAgyqrLGnjVNKJFiRRALhiNSDp1eA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=EqW4BwtDs59WKbRkJNeyf8F378BN79Gv88qN9cKP5pfvLKBK1UHqv71LtyXy16rf8
 NR7An8VlQSKlsudxhtmdGKVyr7TmiqOpCDhfTYNXAPKmZia9YlJuzRMdKThT41og+V
 QkiQbUvJfMCTohng+DVYDbIouiT/ut7KN6ANUzxc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v21 13/16] virtio-net: support local migration of backend
Date: Wed, 19 Aug 2026 21:01:56 +0300
Message-ID: <20260819180201.1970193-14-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
References: <20260819180201.1970193-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 hw/net/virtio-net.c            | 89 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-net.h |  1 +
 include/migration/vmstate.h    |  2 +
 include/net/net.h              |  2 +
 4 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 814b99a43d2..274fbcb0d60 100644
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
index 05d1db71eb8..a606d06e46a 100644
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


