Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2423CAC5B1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zqR-0002ws-M6; Tue, 23 Sep 2025 06:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zqF-0002sK-8A
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:48 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zpu-0000vB-J2
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id CFB1080A49;
 Tue, 23 Sep 2025 13:01:21 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id C1Ug0C0Fha60-JWZ1vgup; Tue, 23 Sep 2025 13:01:21 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758621681;
 bh=iX6zXi/sEZUUGILdy0a/kLuIbyZSAaxyaU7qYN1vwBg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=z7XH5BdvfKKmrbXaaY78Twku5Pmvo1jhEruzjpAymfCXEJfb/Fihu8FNXjMTbw5S5
 BmflNGw1SD6yscJJy4DDToiarzECspDxV9TOXaHy6y5ZwE2YwJFgBImQG3A57wD2/N
 u3x2AY6hqhPfnLkMDJUVGMbQTJ4WWciStaL1UzKU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v6 15/19] net/tap: postpone tap setup to pre-incoming
Date: Tue, 23 Sep 2025 13:01:06 +0300
Message-ID: <20250923100110.70862-16-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923100110.70862-1-vsementsov@yandex-team.ru>
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

As described in previous commit, to support backend-transfer migration
for virtio-net/tap, we need to postpone the decision to open the device
or to wait for incoming fds up to pre-incoming point (when we actually
can decide).

This commit only postpones TAP-open case of initialization.
We don't try to postpone the all cases of initialization, as it will
require a lot more work of refactoring the code.

So we postpone only the simple case, for which we are going to support
fd-incoming migration:

1. No fds / fd parameters: obviously, if user give fd/fds the should
be used, no incoming backend-transfer migration is possible.

2. No helper: just for simplicity. It probably possible to allow it (and
just ignore in case of backend-transfer migration), to allow user use
same cmdline on target QEMU.. But that questionable, and postponable.

3. No sciprt/downscript. It's not simple to support downscript:
we should pass the responsiblity to call it on target QEMU with
migration.. And back to source QEMU on migration failure. It
feasible, but may be implemented later on demand.

3. Concrete ifname: to not try to share it between queues, when we only
can setup queues as separate entities. Supporting undecided ifname will
require to create some extra netdev state, connecting all the taps, to
be able to iterate through them.

No part of backend-transfer migration is here, we only prepare the code
for future implementation of it.

Are net-drivers prepared to postponed initialization of NICs?
For future feature of backend-transfer migration, we are mainly
interested in virtio-net. So, let's prepare virtio-net to work with
postponed initialization of TAP (two places about early set/get
features) and for other drivers let's simply finalize initialization on
setting netdev property. Support for other drivers may be added later if
needed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/net/virtio-net.c |  65 ++++++++++++++++-
 include/net/tap.h   |   2 +
 net/tap-win32.c     |   5 ++
 net/tap.c           | 172 +++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 242 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6b5b5dace3..70f688fc3a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -688,6 +688,21 @@ default_value:
     return VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE;
 }
 
+static bool peer_wait_incoming(VirtIONet *n)
+{
+    NetClientState *nc = qemu_get_queue(n->nic);
+
+    if (!nc->peer) {
+        return false;
+    }
+
+    if (nc->peer->info->type != NET_CLIENT_DRIVER_TAP) {
+        return false;
+    }
+
+    return tap_wait_incoming(nc->peer);
+}
+
 static int peer_attach(VirtIONet *n, int index)
 {
     NetClientState *nc = qemu_get_subqueue(n->nic, index);
@@ -2999,7 +3014,17 @@ static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue)
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
+    if (!peer_wait_incoming(n)) {
+        virtio_net_set_queue_pairs(n);
+    }
 }
 
 static int virtio_net_pre_load_queues(VirtIODevice *vdev, uint32_t n)
@@ -3028,6 +3053,17 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
 
     virtio_add_feature(&features, VIRTIO_NET_F_MAC);
 
+    if (peer_wait_incoming(n)) {
+        /*
+         * Excessive feature set is OK for early initialization when
+         * we wait for local incoming migration: actual guest-negotiated
+         * features will come with migration stream anyway. And we are sure
+         * that we support same host-features as source, because the backend
+         * is the same (the same TAP device, for example).
+         */
+        return features;
+    }
+
     if (!peer_has_vnet_hdr(n)) {
         virtio_clear_feature(&features, VIRTIO_NET_F_CSUM);
         virtio_clear_feature(&features, VIRTIO_NET_F_HOST_TSO4);
@@ -3106,6 +3142,32 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
     return features;
 }
 
+static int virtio_net_update_host_features(VirtIONet *n)
+{
+    Error *local_err = NULL;
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+
+    peer_test_vnet_hdr(n);
+
+    vdev->host_features = virtio_net_get_features(vdev, vdev->host_features,
+                                                  &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int virtio_net_pre_load_device(void *opaque)
+{
+    /*
+     * Probably backend initialization was postponed to
+     * pre-incoming point. So, update information now.
+     */
+    return virtio_net_update_host_features(opaque);
+}
+
 static int virtio_net_post_load_device(void *opaque, int version_id)
 {
     VirtIONet *n = opaque;
@@ -3498,6 +3560,7 @@ static const VMStateDescription vmstate_virtio_net_device = {
     .name = "virtio-net-device",
     .version_id = VIRTIO_NET_VM_VERSION,
     .minimum_version_id = VIRTIO_NET_VM_VERSION,
+    .pre_load = virtio_net_pre_load_device,
     .post_load = virtio_net_post_load_device,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(mac, VirtIONet, ETH_ALEN),
diff --git a/include/net/tap.h b/include/net/tap.h
index 6f34f13eae..c6f9c1aeb1 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -33,4 +33,6 @@ int tap_disable(NetClientState *nc);
 
 int tap_get_fd(NetClientState *nc);
 
+bool tap_wait_incoming(NetClientState *nc);
+
 #endif /* QEMU_NET_TAP_H */
diff --git a/net/tap-win32.c b/net/tap-win32.c
index 38baf90e0b..d526c42b7b 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -766,3 +766,8 @@ int tap_disable(NetClientState *nc)
 {
     abort();
 }
+
+bool tap_wait_incoming(NetClientState *nc)
+{
+    return false;
+}
diff --git a/net/tap.c b/net/tap.c
index 340d8d0cda..b959547492 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -35,7 +35,9 @@
 #include "net/eth.h"
 #include "net/net.h"
 #include "clients.h"
+#include "migration/misc.h"
 #include "monitor/monitor.h"
+#include "system/runstate.h"
 #include "system/system.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
@@ -85,8 +87,20 @@ typedef struct TAPState {
     int sndbuf;
     int vhostfd;
     uint32_t vhost_busyloop_timeout;
+
+    /* for postponed setup */
+    QTAILQ_ENTRY(TAPState) next;
+    bool vnet_hdr_required;
+    int vnet_hdr;
+    bool mq_required;
+    char *ifname;
 } TAPState;
 
+static QTAILQ_HEAD(, TAPState) postponed_taps =
+    QTAILQ_HEAD_INITIALIZER(postponed_taps);
+static NotifierWithReturn pre_incoming_notifier;
+
+static bool tap_postponed_init(TAPState *s, Error **errp);
 static bool net_tap_setup(TAPState *s, int fd, int vnet_hdr, Error **errp);
 
 static void launch_script(const char *setup_script, const char *ifname,
@@ -356,6 +370,8 @@ static void tap_cleanup(NetClientState *nc)
         close(s->vhostfd);
         s->vhostfd = -1;
     }
+
+    g_free(s->ifname);
 }
 
 static void tap_poll(NetClientState *nc, bool enable)
@@ -373,6 +389,25 @@ static bool tap_set_steering_ebpf(NetClientState *nc, int prog_fd)
     return tap_fd_set_steering_ebpf(s->fd, prog_fd) == 0;
 }
 
+static bool tap_check_peer_type(NetClientState *nc, ObjectClass *oc,
+                                Error **errp)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    const char *driver = object_class_get_name(oc);
+
+    if (!g_str_has_prefix(driver, "virtio-net-")) {
+        /*
+         * Only virtio-net support postponed TAP initialization, so
+         * for other drivers let's finalize initialization now.
+         */
+        if (tap_wait_incoming(nc)) {
+            return tap_postponed_init(s, errp);
+        }
+    }
+
+    return true;
+}
+
 int tap_get_fd(NetClientState *nc)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -411,6 +446,7 @@ static NetClientInfo net_tap_info = {
     .set_vnet_be = tap_set_vnet_be,
     .set_steering_ebpf = tap_set_steering_ebpf,
     .get_vhost_net = tap_get_vhost_net,
+    .check_peer_type = tap_check_peer_type,
 };
 
 static TAPState *net_tap_new(NetClientState *peer, const char *model,
@@ -831,6 +867,124 @@ static int get_fds(char *str, char *fds[], int max)
     return i;
 }
 
+#define TAP_OPEN_IFNAME_SZ 128
+
+static bool tap_postponed_init(TAPState *s, Error **errp)
+{
+    char ifname[TAP_OPEN_IFNAME_SZ];
+    int vnet_hdr = s->vnet_hdr;
+    int fd;
+
+    pstrcpy(ifname, sizeof(ifname), s->ifname);
+    fd = net_tap_open(&vnet_hdr, s->vnet_hdr_required, NULL,
+                      ifname, sizeof(ifname),
+                      s->mq_required, errp);
+    if (fd < 0) {
+        goto fail;
+    }
+
+    if (!net_tap_setup(s, fd, vnet_hdr, errp)) {
+        goto fail;
+    }
+
+    QTAILQ_REMOVE(&postponed_taps, s, next);
+    return true;
+
+fail:
+    QTAILQ_REMOVE(&postponed_taps, s, next);
+    qemu_del_net_client(&s->nc);
+    return false;
+}
+
+static int tap_pre_incoming(NotifierWithReturn *notifier,
+                            MigrationEvent *e,
+                            Error **errp)
+{
+    TAPState *s;
+    bool ok = true;
+
+    if (e->type != MIG_EVENT_PRE_INCOMING) {
+        return 0;
+    }
+
+    while (!QTAILQ_EMPTY(&postponed_taps)) {
+        s = QTAILQ_FIRST(&postponed_taps);
+        if (ok) {
+            ok = tap_postponed_init(s, errp);
+        } else {
+            QTAILQ_REMOVE(&postponed_taps, s, next);
+            qemu_del_net_client(&s->nc);
+        }
+    }
+
+    return ok ? 0 : -1;
+}
+
+static bool check_no_script(const char *script_arg)
+{
+    return script_arg &&
+        (script_arg[0] == '\0' || strcmp(script_arg, "no") == 0);
+}
+
+static bool tap_postpone_init(const NetdevTapOptions *tap,
+                              const char *name, NetClientState *peer,
+                              bool *postponed, Error **errp)
+{
+    int queues = tap->has_queues ? tap->queues : 1;
+
+    *postponed = false;
+
+    if (!runstate_check(RUN_STATE_INMIGRATE)) {
+        return true;
+    }
+
+    if (tap->fd || tap->fds || tap->helper || tap->vhostfds) {
+        return true;
+    }
+
+    if (!tap->ifname || tap->ifname[0] == '\0' ||
+        strstr(tap->ifname, "%d") != NULL) {
+        /*
+         * It's hard to postpone logic of parsing template or
+         * absent ifname
+         */
+        return true;
+    }
+
+    /*
+     * Supporting downscipt means understanding and realizing the logic of
+     * transfer of responsibility to call it in target QEMU process. Or in
+     * source QEMU process in case of migration failure. So for simplicity we
+     * don't support scripts together with fds migration.
+     */
+    if (!check_no_script(tap->script) || !check_no_script(tap->downscript)) {
+        return true;
+    }
+
+    for (int i = 0; i < queues; i++) {
+        TAPState *s = net_tap_new(peer, "tap", name, tap, NULL, errp);
+        if (!s) {
+            return false;
+        }
+
+        s->vnet_hdr_required = tap->has_vnet_hdr && tap->vnet_hdr;
+        s->vnet_hdr = tap->has_vnet_hdr ? tap->vnet_hdr : 1;
+        s->mq_required = queues > 1;
+        s->ifname = g_strdup(tap->ifname);
+        qemu_set_info_str(&s->nc, "ifname=%s,script=no,downscript=no",
+                          tap->ifname);
+
+        QTAILQ_INSERT_TAIL(&postponed_taps, s, next);
+    }
+
+    if (!pre_incoming_notifier.notify) {
+        migration_add_notifier(&pre_incoming_notifier, tap_pre_incoming);
+    }
+
+    *postponed = true;
+    return true;
+}
+
 int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
@@ -839,8 +993,9 @@ int net_init_tap(const Netdev *netdev, const char *name,
     /* for the no-fd, no-helper case */
     Error *err = NULL;
     const char *vhostfdname;
-    char ifname[128];
+    char ifname[TAP_OPEN_IFNAME_SZ];
     int ret = 0;
+    bool postponed = false;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
@@ -859,6 +1014,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    if (!tap_postpone_init(tap, name, peer, &postponed, errp)) {
+        return -1;
+    }
+
+    if (postponed) {
+        return 0;
+    }
+
     if (tap->fd) {
         if (tap->ifname || tap->script || tap->downscript ||
             tap->has_vnet_hdr || tap->helper || tap->has_queues ||
@@ -1083,3 +1246,10 @@ int tap_disable(NetClientState *nc)
         return ret;
     }
 }
+
+bool tap_wait_incoming(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    return s->fd == -1;
+}
-- 
2.48.1


