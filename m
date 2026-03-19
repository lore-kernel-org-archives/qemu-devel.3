Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51B2109023F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 15:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Fh6-0003aT-Nz; Thu, 19 Mar 2026 11:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w3Fh0-0003Xz-0w
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 11:53:50 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w3Fgw-0007gn-Fm
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 11:53:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1640E8081C;
 Thu, 19 Mar 2026 18:53:45 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:d57::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id arQgWZ2AA0U0-T7eWNYub; Thu, 19 Mar 2026 18:53:44 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773935624;
 bh=s062yJXwsO6uzOC71AsCs2XtO+NbaWUIILJXwfEhv1o=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=oLN4/jxfcO0sq71gu3D03FdhYjM7Qvm0OyZjzAzJnmSSQfTDkdL7DFOwQwHzvDkt+
 Nvom/zhxbJ5zorra0F/YRbhp7CHoNfLNEqYPbZ6i9hXnj4yQNUH2O0x0dvqytG3yuq
 RGsP2LElkLtQM3OTmAHs2vipuMdLSDhdzAfXx1Oo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, eblake@redhat.com, farosas@suse.de, peterx@redhat.com,
 zhao1.liu@intel.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru, leiyang@redhat.com,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, th.huth+qemu@posteo.eu,
 berrange@redhat.com, pbonzini@redhat.com
Subject: [PATCH v13 5/8] virtio-net: support local migration of backend
Date: Thu, 19 Mar 2026 18:53:29 +0300
Message-ID: <20260319155333.260341-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319155333.260341-1-vsementsov@yandex-team.ru>
References: <20260319155333.260341-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
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

Add virtio-net option local-migration, which is true by default,
but false for older machine types, which doesn't support the feature.

When both global migration parameter "local" and new virtio-net
parameter "local-migration" are true, virtio-net transfer the whole
net backend to the destination, including open file descriptors.
Of-course, its only for local migration and the channel must be
UNIX domain socket.

This way management tool should not care about creating new TAP, and
should not handle switching to it. Migration downtime become shorter.

Support for TAP will come in the next commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/core/machine.c              |   1 +
 hw/net/virtio-net.c            | 137 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-net.h |   2 +
 include/net/net.h              |   2 +
 4 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index a14ad05b9a6..8b2e666854b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,6 +40,7 @@
 
 GlobalProperty hw_compat_10_2[] = {
     { "scsi-block", "migrate-pr", "off" },
+    { TYPE_VIRTIO_NET, "local-migration", "false" },
 };
 const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 2a5d642a647..158b9247a58 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -38,8 +38,10 @@
 #include "qapi/qapi-events-migration.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
+#include "migration/options.h"
 #include "standard-headers/linux/ethtool.h"
 #include "system/system.h"
+#include "system/runstate.h"
 #include "system/replay.h"
 #include "trace.h"
 #include "monitor/qdev.h"
@@ -3060,7 +3062,17 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
     n->multiqueue = multiqueue;
     virtio_net_change_num_queues(n, max * 2 + 1);
 
-    virtio_net_set_queue_pairs(n);
+    /*
+     * virtio_net_set_multiqueue() called from set_features(0) on early
+     * reset, when peer may wait for incoming (and is not initialized
+     * yet).
+     * Don't worry about it: virtio_net_set_queue_pairs() will be called
+     * later form virtio_net_post_load_device(), and anyway will be
+     * noop for local incoming migration with live backend passing.
+     */
+    if (!n->peers_wait_incoming) {
+        virtio_net_set_queue_pairs(n);
+    }
 }
 
 static int virtio_net_pre_load_queues(VirtIODevice *vdev, uint32_t n)
@@ -3089,6 +3101,17 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
 
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
@@ -3179,6 +3202,18 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
     }
 }
 
+static bool virtio_net_update_host_features(VirtIONet *n, Error **errp)
+{
+    ERRP_GUARD();
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    peer_test_vnet_hdr(n);
+
+    virtio_net_get_features(vdev, &vdev->host_features, errp);
+
+    return !*errp;
+}
+
 static int virtio_net_post_load_device(void *opaque, int version_id)
 {
     VirtIONet *n = opaque;
@@ -3300,6 +3335,9 @@ struct VirtIONetMigTmp {
     uint16_t        curr_queue_pairs_1;
     uint8_t         has_ufo;
     uint32_t        has_vnet_hdr;
+
+    NetClientState *ncs;
+    uint32_t max_queue_pairs;
 };
 
 /* The 2nd and subsequent tx_waiting flags are loaded later than
@@ -3569,6 +3607,57 @@ static const VMStateDescription vhost_user_net_backend_state = {
     }
 };
 
+static bool virtio_net_migrate_local(void *opaque, int version_id)
+{
+    VirtIONet *n = opaque;
+
+    return migrate_local() && n->local_migration;
+}
+
+static int virtio_net_nic_pre_save(void *opaque)
+{
+    struct VirtIONetMigTmp *tmp = opaque;
+
+    tmp->ncs = tmp->parent->nic->ncs;
+    tmp->max_queue_pairs = tmp->parent->max_queue_pairs;
+
+    return 0;
+}
+
+static int virtio_net_nic_pre_load(void *opaque)
+{
+    /* Reuse the pointer setup from save */
+    virtio_net_nic_pre_save(opaque);
+
+    return 0;
+}
+
+static int virtio_net_nic_post_load(void *opaque, int version_id)
+{
+    struct VirtIONetMigTmp *tmp = opaque;
+    Error *local_err = NULL;
+
+    if (!virtio_net_update_host_features(tmp->parent, &local_err)) {
+        error_report_err(local_err);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_virtio_net_nic = {
+    .name      = "virtio-net-nic",
+    .pre_load  = virtio_net_nic_pre_load,
+    .pre_save  = virtio_net_nic_pre_save,
+    .post_load  = virtio_net_nic_post_load,
+    .fields    = (const VMStateField[]) {
+        VMSTATE_VARRAY_UINT32(ncs, struct VirtIONetMigTmp,
+                              max_queue_pairs, 0, vmstate_net_peer_backend,
+                              NetClientState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_virtio_net_device = {
     .name = "virtio-net-device",
     .version_id = VIRTIO_NET_VM_VERSION,
@@ -3600,6 +3689,9 @@ static const VMStateDescription vmstate_virtio_net_device = {
          * but based on the uint.
          */
         VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN >> 3),
+        VMSTATE_WITH_TMP_TEST(VirtIONet, virtio_net_migrate_local,
+                              struct VirtIONetMigTmp,
+                              vmstate_virtio_net_nic),
         VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
                          vmstate_virtio_net_has_vnet),
         VMSTATE_UINT8(mac_table.multi_overflow, VirtIONet),
@@ -3864,6 +3956,42 @@ static bool failover_hide_primary_device(DeviceListener *listener,
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
@@ -4001,6 +4129,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
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
@@ -4310,6 +4444,7 @@ static const Property virtio_net_properties[] = {
                                host_features_ex,
                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
                                true),
+    DEFINE_PROP_BOOL("local-migration", VirtIONet, local_migration, true),
 };
 
 static void virtio_net_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 371e3764282..0c14e314409 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -230,6 +230,8 @@ struct VirtIONet {
     struct EBPFRSSContext ebpf_rss;
     uint32_t nr_ebpf_rss_fds;
     char **ebpf_rss_fds;
+    bool peers_wait_incoming;
+    bool local_migration;
 };
 
 size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
diff --git a/include/net/net.h b/include/net/net.h
index aa34043b1ac..d4cf399d4a8 100644
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
     const VMStateDescription *backend_vmsd;
 } NetClientInfo;
-- 
2.52.0


