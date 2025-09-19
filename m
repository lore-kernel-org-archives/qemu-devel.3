Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F08CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXqu-0006AI-19; Fri, 19 Sep 2025 05:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqf-0005nx-1f
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:13 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqY-0004bX-BI
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id F080B80624;
 Fri, 19 Sep 2025 12:56:03 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a72::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ntP1fK1GvGk0-7Md5G5IF; Fri, 19 Sep 2025 12:56:03 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758275763;
 bh=ZOT4nc4PuASqIOudC/cUMhlxHtQE++eLa6dzdOEVzdA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=IiSp9Mik+D3360kmAlIISMNRoLFyJZ6jff+PMaIrg2U7Tc1PhpKv3UHoByuMIL7cO
 RryXhzDZD1+PIINv1ms+6cmv+9ZiAaH7Hqd4WrrJi7R3zy3tx5T1brAM7XZOfkeioN
 TKTDkHemBLRIZQunCjxFBlX+c9x8NjHtis0pHNnA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v5 17/19] virtio-net: support fds migration of TAP backend
Date: Fri, 19 Sep 2025 12:55:43 +0300
Message-ID: <20250919095545.1912042-18-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
References: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Finally implement the new migration option fds = [virtio-net].

With this enabled (both on source and target) of-course, and with
unix-socket used as migration-channel, we do "migrate" the virtio-net
backend - TAP devices, with all its fds.

This way management tool should not care about creating new TAP, and
handling switching to it. Migration downtime become shorter.

How it works:

1. For incoming migration, we postpone TAP initialization up to
   pre-incoming point.

2. At pre-incoming point we see that virtio-net target for fds
   migration is set, so we postpone TAP initialization up to
   post-load

3. During virtio-load, we get TAP state (and fds) as part of
   virtio-net state

4. In post-load we finalize TAP initialization

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/net/virtio-net.c | 73 +++++++++++++++++++++++++++++++++++++++++++++
 include/net/tap.h   |  3 ++
 migration/options.c |  5 ----
 net/tap.c           | 54 ++++++++++++++++++++++++++++++++-
 4 files changed, 129 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 70f688fc3a..2817c0f198 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -26,6 +26,7 @@
 #include "qemu/option.h"
 #include "qemu/option_int.h"
 #include "qemu/config-file.h"
+#include "qemu/typedefs.h"
 #include "qobject/qdict.h"
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
@@ -38,6 +39,8 @@
 #include "qapi/qapi-events-migration.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
+#include "migration/migration.h"
+#include "migration/options.h"
 #include "standard-headers/linux/ethtool.h"
 #include "system/system.h"
 #include "system/replay.h"
@@ -3147,6 +3150,11 @@ static int virtio_net_update_host_features(VirtIONet *n)
     Error *local_err = NULL;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
 
+    if (peer_wait_incoming(n)) {
+        /* It's too early for updating options. */
+        return 0;
+    }
+
     peer_test_vnet_hdr(n);
 
     vdev->host_features = virtio_net_get_features(vdev, vdev->host_features,
@@ -3287,6 +3295,9 @@ struct VirtIONetMigTmp {
     uint16_t        curr_queue_pairs_1;
     uint8_t         has_ufo;
     uint32_t        has_vnet_hdr;
+
+    NetClientState *ncs;
+    uint32_t max_queue_pairs;
 };
 
 /* The 2nd and subsequent tx_waiting flags are loaded later than
@@ -3556,6 +3567,65 @@ static const VMStateDescription vhost_user_net_backend_state = {
     }
 };
 
+static bool virtio_net_is_tap_fds_mig(void *opaque, int version_id)
+{
+    VirtIONet *n = opaque;
+    NetClientState *nc;
+
+    nc = qemu_get_queue(n->nic);
+
+    return migrate_fds_virtio_net() && nc->peer &&
+        nc->peer->info->type == NET_CLIENT_DRIVER_TAP;
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
+
+    return virtio_net_update_host_features(tmp->parent);
+}
+
+static const VMStateDescription vmstate_virtio_net_nic_nc = {
+    .name = "virtio-net-nic-nc",
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT_POINTER(peer, NetClientState, vmstate_tap,
+                               NetClientState),
+        VMSTATE_END_OF_LIST()
+   },
+};
+
+static const VMStateDescription vmstate_virtio_net_nic = {
+    .name      = "virtio-net-nic",
+    .pre_load  = virtio_net_nic_pre_load,
+    .pre_save  = virtio_net_nic_pre_save,
+    .post_load  = virtio_net_nic_post_load,
+    .fields    = (const VMStateField[]) {
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(ncs, struct VirtIONetMigTmp,
+                                             max_queue_pairs,
+                                             vmstate_virtio_net_nic_nc,
+                                             struct NetClientState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_virtio_net_device = {
     .name = "virtio-net-device",
     .version_id = VIRTIO_NET_VM_VERSION,
@@ -3588,6 +3658,9 @@ static const VMStateDescription vmstate_virtio_net_device = {
          * but based on the uint.
          */
         VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN >> 3),
+        VMSTATE_WITH_TMP_TEST(VirtIONet, virtio_net_is_tap_fds_mig,
+                              struct VirtIONetMigTmp,
+                              vmstate_virtio_net_nic),
         VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
                          vmstate_virtio_net_has_vnet),
         VMSTATE_UINT8(mac_table.multi_overflow, VirtIONet),
diff --git a/include/net/tap.h b/include/net/tap.h
index c6f9c1aeb1..0be083f8da 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -26,6 +26,7 @@
 #ifndef QEMU_NET_TAP_H
 #define QEMU_NET_TAP_H
 
+#include "qemu/typedefs.h"
 #include "standard-headers/linux/virtio_net.h"
 
 int tap_enable(NetClientState *nc);
@@ -35,4 +36,6 @@ int tap_get_fd(NetClientState *nc);
 
 bool tap_wait_incoming(NetClientState *nc);
 
+extern const VMStateDescription vmstate_tap;
+
 #endif /* QEMU_NET_TAP_H */
diff --git a/migration/options.c b/migration/options.c
index 061a1b8eaf..c6eeadaab5 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1192,11 +1192,6 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
         return false;
     }
 
-    if (params->has_fds) {
-        error_setg(errp, "Not implemented");
-        return false;
-    }
-
     return true;
 }
 
diff --git a/net/tap.c b/net/tap.c
index 13efea7e4f..dcbc6466e5 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -36,6 +36,7 @@
 #include "net/net.h"
 #include "clients.h"
 #include "migration/misc.h"
+#include "migration/options.h"
 #include "monitor/monitor.h"
 #include "system/runstate.h"
 #include "system/system.h"
@@ -94,6 +95,7 @@ typedef struct TAPState {
     int vnet_hdr;
     bool mq_required;
     char *ifname;
+    bool attached_to_virtio_net;
 } TAPState;
 
 static QTAILQ_HEAD(, TAPState) postponed_taps =
@@ -390,6 +392,8 @@ static bool tap_check_peer_type(NetClientState *nc, ObjectClass *oc,
         }
     }
 
+    s->attached_to_virtio_net = true;
+
     return true;
 }
 
@@ -801,7 +805,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
 
 static bool net_tap_setup(TAPState *s, int fd, int vnet_hdr, Error **errp)
 {
-    if (!net_tap_set_fd(s, fd, vnet_hdr, errp)) {
+    if (fd > -1 && !net_tap_set_fd(s, fd, vnet_hdr, errp)) {
         return false;
     }
 
@@ -893,6 +897,7 @@ static int tap_pre_incoming(NotifierWithReturn *notifier,
 {
     TAPState *s;
     bool ok = true;
+    bool mig_fds = migrate_fds_virtio_net();
 
     if (e->type != MIG_EVENT_PRE_INCOMING) {
         return 0;
@@ -901,6 +906,11 @@ static int tap_pre_incoming(NotifierWithReturn *notifier,
     while (!QTAILQ_EMPTY(&postponed_taps)) {
         s = QTAILQ_FIRST(&postponed_taps);
         if (ok) {
+            if (mig_fds && s->attached_to_virtio_net) {
+                /* We'll get fds from incoming migration */
+                QTAILQ_REMOVE(&postponed_taps, s, next);
+                continue;
+            }
             ok = tap_postponed_init(s, errp);
         } else {
             QTAILQ_REMOVE(&postponed_taps, s, next);
@@ -1253,6 +1263,48 @@ int tap_disable(NetClientState *nc)
     }
 }
 
+static int tap_pre_load(void *opaque)
+{
+    TAPState *s = opaque;
+
+    if (s->fd != -1) {
+        error_report(
+            "TAP is already initialized and cannot receive incoming fd");
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int tap_post_load(void *opaque, int version_id)
+{
+    TAPState *s = opaque;
+    Error *local_err = NULL;
+
+    if (!net_tap_setup(s, -1, -1, &local_err)) {
+        error_report_err(local_err);
+        qemu_del_net_client(&s->nc);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+const VMStateDescription vmstate_tap = {
+    .name = "net-tap",
+    .pre_load = tap_pre_load,
+    .post_load = tap_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_FD(fd, TAPState),
+        VMSTATE_BOOL(using_vnet_hdr, TAPState),
+        VMSTATE_BOOL(has_ufo, TAPState),
+        VMSTATE_BOOL(has_uso, TAPState),
+        VMSTATE_BOOL(enabled, TAPState),
+        VMSTATE_UINT32(host_vnet_hdr_len, TAPState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 bool tap_wait_incoming(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
-- 
2.48.1


