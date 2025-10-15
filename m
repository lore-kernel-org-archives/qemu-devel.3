Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2ECCCD192
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91Sa-0005Ve-Ba; Wed, 15 Oct 2025 09:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91SO-0005OZ-Fa
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:22 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91S8-00034m-An
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:19 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 5C22088B0F;
 Wed, 15 Oct 2025 16:21:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bLQ5oq0N5Os0-NWwvEDBJ; Wed, 15 Oct 2025 16:21:54 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760534514;
 bh=AmK5dTR7FNJv8BYt1ii1QHE7ubRAYsDylzbe2+T8b9U=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=fz2iEiGT6d0xIoewgcCwzZuxx+hqQjq+QvqQeZ0aQPG4FICKIvsEqSBn9b9IqXmib
 qq/zt7Rb5Y7tEnkfPKiuEFe3qjta/xt32mWGU8bD2iw/hwwE5Xlq0R5zvWJ6UzaR7Q
 uA9FA+Q9+35zq08A+iUy5sxOf1N9ckkBhSmDGLWg=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, sw@weilnetz.de, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v8 17/19] virtio-net: support backend-transfer migration for
 virtio-net/tap
Date: Wed, 15 Oct 2025 16:21:33 +0300
Message-ID: <20251015132136.1083972-18-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Add virtio-net option backend-transfer, which is true by default,
but false for older machine types, which doesn't support the feature.

For backend-transfer migration, both global migration parameter
backend-transfer and virtio-net backend-transfer option should be
set to true.

With the parameters enabled (both on source and target) of-course, and
with unix-socket used as migration-channel, we do "migrate" the
virtio-net backend - TAP device, with all its fds.

This way management tool should not care about creating new TAP, and
should not handle switching to it. Migration downtime become shorter.

How it works:

1. For incoming migration, we postpone TAP initialization up to
   pre-incoming point.

2. At pre-incoming point we see that "virtio-net-tap" is set for
   backend-transfer, so we postpone TAP initialization up to
   post-load

3. During virtio-load, we get TAP state (and fds) as part of
   virtio-net state

4. In post-load we finalize TAP initialization

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/core/machine.c              |  1 +
 hw/net/virtio-net.c            | 75 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-net.h |  1 +
 include/net/tap.h              |  2 +
 net/tap.c                      | 45 +++++++++++++++++++-
 5 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 681adbb7ac..a3d77f5604 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,6 +40,7 @@
 
 GlobalProperty hw_compat_10_1[] = {
     { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
+    { TYPE_VIRTIO_NET, "backend-transfer", "false" },
 };
 const size_t hw_compat_10_1_len = G_N_ELEMENTS(hw_compat_10_1);
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 661413c72f..5f9711dee7 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -38,6 +38,7 @@
 #include "qapi/qapi-events-migration.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
+#include "migration/options.h"
 #include "standard-headers/linux/ethtool.h"
 #include "system/system.h"
 #include "system/replay.h"
@@ -3358,6 +3359,9 @@ struct VirtIONetMigTmp {
     uint16_t        curr_queue_pairs_1;
     uint8_t         has_ufo;
     uint32_t        has_vnet_hdr;
+
+    NetClientState *ncs;
+    uint32_t max_queue_pairs;
 };
 
 /* The 2nd and subsequent tx_waiting flags are loaded later than
@@ -3627,6 +3631,71 @@ static const VMStateDescription vhost_user_net_backend_state = {
     }
 };
 
+static bool virtio_net_is_tap_mig(void *opaque, int version_id)
+{
+    VirtIONet *n = opaque;
+    NetClientState *nc;
+
+    nc = qemu_get_queue(n->nic);
+
+    return migrate_backend_transfer() && n->backend_transfer && nc->peer &&
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
@@ -3658,6 +3727,9 @@ static const VMStateDescription vmstate_virtio_net_device = {
          * but based on the uint.
          */
         VMSTATE_BUFFER_POINTER_UNSAFE(vlans, VirtIONet, 0, MAX_VLAN >> 3),
+        VMSTATE_WITH_TMP_TEST(VirtIONet, virtio_net_is_tap_mig,
+                              struct VirtIONetMigTmp,
+                              vmstate_virtio_net_nic),
         VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
                          vmstate_virtio_net_has_vnet),
         VMSTATE_UINT8(mac_table.multi_overflow, VirtIONet),
@@ -4239,7 +4311,7 @@ static bool vhost_user_blk_pre_incoming(void *opaque, Error **errp)
     VirtIONet *n = opaque;
     int i;
 
-    if (peer_wait_incoming(n)) {
+    if (!virtio_net_is_tap_mig(opaque, 0) && peer_wait_incoming(n)) {
         for (i = 0; i < n->max_queue_pairs; i++) {
             if (!peer_postponed_init(n, i, errp)) {
                 return false;
@@ -4389,6 +4461,7 @@ static const Property virtio_net_properties[] = {
                                host_features_ex,
                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
                                false),
+    DEFINE_PROP_BOOL("backend-transfer", VirtIONet, backend_transfer, true),
 };
 
 static void virtio_net_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5b8ab7bda7..bf07f8a4cb 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -231,6 +231,7 @@ struct VirtIONet {
     struct EBPFRSSContext ebpf_rss;
     uint32_t nr_ebpf_rss_fds;
     char **ebpf_rss_fds;
+    bool backend_transfer;
 };
 
 size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
diff --git a/include/net/tap.h b/include/net/tap.h
index 5a926ba513..506f7ab719 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -36,4 +36,6 @@ int tap_get_fd(NetClientState *nc);
 bool tap_wait_incoming(NetClientState *nc);
 bool tap_postponed_init(NetClientState *nc, Error **errp);
 
+extern const VMStateDescription vmstate_tap;
+
 #endif /* QEMU_NET_TAP_H */
diff --git a/net/tap.c b/net/tap.c
index 8afbf3b407..b9c12dd64c 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -819,7 +819,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
 
 static bool net_tap_setup(TAPState *s, int fd, int vnet_hdr, Error **errp)
 {
-    if (!net_tap_set_fd(s, fd, vnet_hdr, errp)) {
+    if (fd != -1 && !net_tap_set_fd(s, fd, vnet_hdr, errp)) {
         return false;
     }
 
@@ -1225,6 +1225,49 @@ int tap_disable(NetClientState *nc)
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
+        VMSTATE_BOOL(has_tunnel, TAPState),
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


