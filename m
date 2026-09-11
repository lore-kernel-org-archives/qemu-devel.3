Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954FEC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9R-0002j2-MG; Fri, 11 Sep 2026 05:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9E-0002Mv-6y
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9C-00088U-3M
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZhK7m7LfrlPcMC5A9kLcc4Id8ZYHnzxhU78CaEvxc74=;
 b=NIe/R54FnMpGBPufHHLnj+Bp3e1artZ2gSRXahNpYTWXW+P7/hd9cyZVjiUVnfrvxuLOlY
 uJDXwMfrzaXxSiWpnAvY/kE375w5Rcjf1rbSl2Z9Uh2eyz3Gw+wlc25Pz7+UwCTwejX72S
 vC+yzew3gTKypxVG4ThdPwQctig9Ba4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-A_VeqHRsPQaM4HMaMMr9Hg-1; Fri, 11 Sep 2026 05:02:12 -0400
X-MC-Unique: A_VeqHRsPQaM4HMaMMr9Hg-1
X-Mimecast-MFC-AGG-ID: A_VeqHRsPQaM4HMaMMr9Hg_1789117331
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c251c140b41so73869866b.3
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117331; x=1789722131; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZhK7m7LfrlPcMC5A9kLcc4Id8ZYHnzxhU78CaEvxc74=;
 b=oYEtfJCNnReiOVIS7TOCxUmozTbamjbPwfCd2asCgD2dXsYZuNnqrKJSNv+Kfvra/F
 /6plx/AuFgQ4Q3065ZRPXOKsDDxclSg1OPnR6ZKGMD632nN7WruC+NDwyrDtzackPLgA
 TAYAyokCx7uVXeFRWalx0SGE1wkKV6dZye/ganffxLsplrmgfGYKRLnTwRCb6enFnC+7
 BUnrEFTu5irjYAQA2gbg+OE0+F3UIXTEA/OEtqKYt8YB9DI1xLsbtcAIpJ6DV2ePQcrw
 mqlCdODTGxiH6rtyBkpKsKv+WyZjMzZtIcuB0Krwljm5wyz2zobEFnEv8knPbiEBUFL8
 1SoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117331; x=1789722131;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZhK7m7LfrlPcMC5A9kLcc4Id8ZYHnzxhU78CaEvxc74=;
 b=m/t+C3PDmVKcNPlyDnhjSlSBMjLE0rKjZ616WoyhSMkjILU6vaFvMWodeOY4yQYRUG
 O2FvghS0n4m07jomoYdjUJHpsMLYwlXVWaApDkwKAIq4jyZZHUmL3heetOyRFbPpPWpE
 CDKwES8bEMrT/mhoh2oWIsf5Cy3EaMUY91qduHnGsNoJl9L7mbbH92ynqKEJG0U4KtFI
 mOGY97dCp9pRzTF4inq99U6PQNMzCAisPJjr856aM2XozYeELQADNuC1B9sIK45tkXBl
 dU/iQhDr+lMABPIyB40iskmgqtyhck/62kgXpoMbvAw65aKN8o9WbUzhEYW5TTxYxCfw
 1A+A==
X-Gm-Message-State: AFuF++lGUNKGuBCR164r6+fwKpu6bHcjWmf52l2sEnYtz88hOrAPD6Sx
 460q8a/29R+MYRd8zoo6Ke4iqKOGZl+X87b7bj3geqOJ3YyOJmydl3YE1AkRNUqi9mM7DM65PSu
 Hq7DJazoGO8jWUMytXBrk+Ohg2TY3GHv3mMXV63KfF9SFitQaikpHq6P2edRLe9EVVROD65OqLN
 FXAgZoAA2qMj+nXQgq4Nhc19xCvCj0A9IIhQ==
X-Gm-Gg: AYBFou1TrphdjOJ32ZZt91vh0gcnaMEsBcSxNRKODenaY9psTgZ/KAmCm+O6LWqvfDW
 DQ4M0qZXMOrcSObYYyY9G8EJjxp6p+YtOiT8Hm6vHIF0Cmg7ctqt4qygdM/azdUcda73y2QVsOt
 lNxYU4aZHXbruohNjJHDh95gBa26WEbWSuZ/HsGphj0yfLShVA/sObZCh4dPGeic3/NBDrH7zCq
 XZlb74Mc8l43dIlIf+ug3p/lFC4N8WQyCa6iO5lQ3U3JdJgHVe0RRq58PgbgZkEPQfb9R6rIihB
 shOatddUsUzE5tKLxel0lFqOqVIkCijPKGEgWOCjr0lfnlmwFXyc0XMpR9d1vNTeg73QEjsjGU0
 ZrCaPywhF
X-Received: by 2002:a17:907:d789:b0:c24:6445:d19 with SMTP id
 a640c23a62f3a-c29665b941fmr126527466b.17.1789117330457; 
 Fri, 11 Sep 2026 02:02:10 -0700 (PDT)
X-Received: by 2002:a17:907:d789:b0:c24:6445:d19 with SMTP id
 a640c23a62f3a-c29665b941fmr126521666b.17.1789117329718; 
 Fri, 11 Sep 2026 02:02:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e6f1sm4458260f8f.6.2026.09.11.02.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:09 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL v2 21/75] virtio-net: support local migration of backend
Message-ID: <bb71b1bffe58df1b443f60069687dc8a8e48cb07.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
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


