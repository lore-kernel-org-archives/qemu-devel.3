Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EE4CD6E43
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 19:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSJft-0006aK-DQ; Wed, 27 May 2026 15:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSJfk-0006Xo-9M
 for qemu-devel@nongnu.org; Wed, 27 May 2026 15:12:09 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSJff-0000bD-Fw
 for qemu-devel@nongnu.org; Wed, 27 May 2026 15:12:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2925:0:640:1f39:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7612A88481;
 Wed, 27 May 2026 22:12:01 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id qBf3L80XU0U0-7R18QPgU; Wed, 27 May 2026 22:12:00 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779909120;
 bh=qx1Ad2zujHxdEpruVjFNJqpz2VqXBNkmIJc/XEc8578=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Lmw7aQT0BGcEMIlA7uODtOQV7RjVQEW7ne8lYJk95HcQRFdR0gAmB0jQ3oWxusihI
 Cep8XI5QFv7d9hI2wdfbwlszRyGKpJXffg+1aOM8UBsIEAAqiu2JOCHqq5UDUyC7gL
 VE47yLeiTjUJKBDHiCSe7jPs/V9pq9oM2+S1KCaY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v17 08/10] net/tap: support local migration with virtio-net
Date: Wed, 27 May 2026 22:11:47 +0300
Message-ID: <20260527191150.250333-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527191150.250333-1-vsementsov@yandex-team.ru>
References: <20260527191150.250333-1-vsementsov@yandex-team.ru>
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

Support transferring of TAP state (including open fd).

Add new property "local-migration-supported", which defines,
is local-migration is actually supported for this TAP device.
Starting from 11.1 MT it's enabled by default.

Note, that local-migration (including migrating opened FDs
through migration channel, which must be UNIX socket), is
enabled by global "local" migration parameters. But individual
devices may have additional options to enable/disable it
personally.

Add new option "incoming-fds", which should be set to true on
target for incoming migration work. It says "do not open any
files, but instead wait for FDs coming from migration stream".
"local-migration-supported" option is not enough, as it work in pair
with migration parameter "local", and intialization process
of TAP device should not depend on migration parameters.

For new option require explicitly unset script and downscript,
to keep possibility of implementing support for them in the
future.

Note disabling read polling on source stop for TAP migration:
otherwise, source process may steal packages from TAP fd even
after source vm STOP.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/core/machine.c |   2 +
 net/tap.c         | 221 +++++++++++++++++++++++++++++++++++++++++++---
 qapi/net.json     |  20 ++++-
 3 files changed, 231 insertions(+), 12 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 63baff859f3..306f01b1a68 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -36,11 +36,13 @@
 #include "hw/virtio/virtio-pci.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/virtio/virtio-iommu.h"
+#include "net/tap.h"
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
 GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
+    { TYPE_TAP_NETDEV, "local-migration-supported", "false" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/net/tap.c b/net/tap.c
index 529ed4b0f5b..c84daad9895 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -36,13 +36,19 @@
 #include "net/net.h"
 #include "clients.h"
 #include "monitor/monitor.h"
+#include "system/runstate.h"
 #include "system/system.h"
+#include "migration/misc.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/sockets.h"
 #include "hw/virtio/vhost.h"
+#include "hw/core/vmstate-if.h"
+#include "migration/vmstate.h"
+#include "qom/object.h"
+#include "qom/compat-properties.h"
 
 #include "net/tap.h"
 #include "net/util.h"
@@ -70,6 +76,8 @@ static const int kernel_feature_bits[] = {
 
 OBJECT_DECLARE_SIMPLE_TYPE(TAPState, TAP_NETDEV)
 
+static const VMStateDescription vmstate_tap;
+
 struct TAPState {
     Object parent_obj;
 
@@ -92,6 +100,9 @@ struct TAPState {
     Notifier exit;
 
     int queue_index;
+    bool read_poll_detached;
+    VMChangeStateEntry *vmstate;
+    bool local_migration_supported;
 };
 
 static void launch_script(const char *setup_script, const char *ifname,
@@ -100,19 +111,25 @@ static void launch_script(const char *setup_script, const char *ifname,
 static void tap_send(void *opaque);
 static void tap_writable(void *opaque);
 
+static bool tap_is_explicit_no_script(const char *script_arg)
+{
+    return script_arg &&
+        (script_arg[0] == '\0' || strcmp(script_arg, "no") == 0);
+}
+
 static char *tap_parse_script(const char *script_arg, const char *default_path)
 {
     g_autofree char *res = g_strdup(script_arg);
 
-    if (!res) {
-        res = get_relocated_path(default_path);
+    if (tap_is_explicit_no_script(script_arg)) {
+        return NULL;
     }
 
-    if (res[0] == '\0' || strcmp(res, "no") == 0) {
-        return NULL;
+    if (!script_arg) {
+        return get_relocated_path(default_path);
     }
 
-    return g_steal_pointer(&res);
+    return g_strdup(script_arg);
 }
 
 static void tap_update_fd_handler(TAPState *s)
@@ -129,6 +146,23 @@ static void tap_read_poll(TAPState *s, bool enable)
     tap_update_fd_handler(s);
 }
 
+static void tap_vm_state_change(void *opaque, bool running, RunState state)
+{
+    TAPState *s = opaque;
+
+    if (running) {
+        if (s->read_poll_detached) {
+            tap_read_poll(s, true);
+            s->read_poll_detached = false;
+        }
+    } else if (state == RUN_STATE_FINISH_MIGRATE) {
+        if (s->read_poll) {
+            s->read_poll_detached = true;
+            tap_read_poll(s, false);
+        }
+    }
+}
+
 static void tap_write_poll(TAPState *s, bool enable)
 {
     s->write_poll = enable;
@@ -359,10 +393,17 @@ static void tap_cleanup(NetClientState *nc)
         s->exit.notify = NULL;
     }
 
+    if (s->vmstate) {
+        qemu_del_vm_change_state_handler(s->vmstate);
+        s->vmstate = NULL;
+    }
+
     tap_read_poll(s, false);
     tap_write_poll(s, false);
     close(s->fd);
     s->fd = -1;
+
+    vmstate_unregister(VMSTATE_IF(s), &vmstate_tap, s);
 }
 
 static void tap_poll(NetClientState *nc, bool enable)
@@ -399,6 +440,73 @@ static VHostNetState *tap_get_vhost_net(NetClientState *nc)
     return s->vhost_net;
 }
 
+static bool tap_is_wait_incoming(NetClientState *nc)
+{
+    TAPState *s = container_of(nc, TAPState, nc);
+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
+    return s->fd == -1;
+}
+
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
+static bool tap_setup_vhost(TAPState *s, Error **errp);
+
+static int tap_post_load(void *opaque, int version_id)
+{
+    TAPState *s = opaque;
+    Error *local_err = NULL;
+
+    tap_read_poll(s, true);
+
+    if (s->fd < 0) {
+        return -1;
+    }
+
+    if (!tap_setup_vhost(s, &local_err)) {
+        error_prepend(&local_err,
+                      "Failed to setup vhost during TAP post-load: ");
+        error_report_err(local_err);
+        return -1;
+    }
+
+    return 0;
+}
+
+static bool tap_needed(void *opaque)
+{
+    TAPState *s = opaque;
+
+    return s->local_migration_supported && migrate_local();
+}
+
+static const VMStateDescription vmstate_tap = {
+    .name = "net-tap",
+    .priority = MIG_PRI_BACKEND,
+    .pre_load = tap_pre_load,
+    .post_load = tap_post_load,
+    .needed = tap_needed,
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
 
 static char *tap_vmstate_if_get_id(VMStateIf *obj)
 {
@@ -407,17 +515,42 @@ static char *tap_vmstate_if_get_id(VMStateIf *obj)
     return res;
 }
 
+static bool tap_get_local_migration_supported_prop(Object *obj, Error **errp)
+{
+    TAPState *s = TAP_NETDEV(obj);
+    return s->local_migration_supported;
+}
+
+static void tap_set_local_migration_supported_prop(Object *obj, bool value,
+                                                   Error **errp)
+{
+    TAPState *s = TAP_NETDEV(obj);
+    s->local_migration_supported = value;
+}
+
+static void tap_instance_init(Object *obj)
+{
+    TAPState *s = TAP_NETDEV(obj);
+    s->local_migration_supported = true;
+}
+
 static void tap_class_init(ObjectClass *klass, const void *data)
 {
     VMStateIfClass *vc = VMSTATE_IF_CLASS(klass);
 
     vc->get_id = tap_vmstate_if_get_id;
+
+    object_class_property_add_bool(klass, "local-migration-supported",
+                                   tap_get_local_migration_supported_prop,
+                                   tap_set_local_migration_supported_prop);
 }
 
 static const TypeInfo tap_netdev_info = {
     .name = TYPE_TAP_NETDEV,
     .parent = TYPE_OBJECT,
     .instance_size = sizeof(TAPState),
+    .instance_init = tap_instance_init,
+    .instance_post_init = object_apply_compat_props,
     .class_init = tap_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_VMSTATE_IF },
@@ -450,13 +583,16 @@ static NetClientInfo net_tap_info = {
     .set_vnet_le = tap_set_vnet_le,
     .set_vnet_be = tap_set_vnet_be,
     .set_steering_ebpf = tap_set_steering_ebpf,
+    .is_wait_incoming = tap_is_wait_incoming,
     .get_vhost_net = tap_get_vhost_net,
 };
 
 static TAPState *new_tap(NetClientState *peer,
                          const char *model,
                          const char *name,
-                         int queue_index)
+                         int queue_index,
+                         bool has_local_migration_supported,
+                         bool local_migration_supported)
 {
     TAPState *s = TAP_NETDEV(object_new(TYPE_TAP_NETDEV));
 
@@ -465,6 +601,12 @@ static TAPState *new_tap(NetClientState *peer,
 
     s->queue_index = queue_index;
 
+    if (has_local_migration_supported) {
+        s->local_migration_supported = local_migration_supported;
+    }
+
+    vmstate_register(VMSTATE_IF(s), VMSTATE_INSTANCE_ID_ANY, &vmstate_tap, s);
+
     return s;
 }
 
@@ -473,10 +615,14 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
                                  const char *name,
                                  int fd,
                                  int vnet_hdr,
-                                 int queue_index)
+                                 int queue_index,
+                                 bool has_local_migration_supported,
+                                 bool local_migration_supported)
 {
     NetOffloads ol = {};
-    TAPState *s = new_tap(peer, model, name, queue_index);
+    TAPState *s = new_tap(peer, model, name, queue_index,
+                          has_local_migration_supported,
+                          local_migration_supported);
 
     s->fd = fd;
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
@@ -713,7 +859,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         close(fd);
         return -1;
     }
-    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr, 0);
+    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr, 0, true, false);
 
     qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
 
@@ -793,11 +939,16 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              Error **errp)
 {
     TAPState *s = net_tap_fd_init(peer, tap->helper ? "bridge" : "tap",
-                                  name, fd, vnet_hdr, queue_index);
+                                  name, fd, vnet_hdr, queue_index,
+                                  tap->has_local_migration_supported,
+                                  tap->local_migration_supported);
     bool sndbuf_required = tap->has_sndbuf;
     int sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
 
+    s->read_poll_detached = false;
+    s->vmstate = qemu_add_vm_change_state_handler(tap_vm_state_change, s);
+
     if (!tap_set_sndbuf(fd, sndbuf, sndbuf_required ? errp : NULL) &&
         sndbuf_required) {
         goto failed;
@@ -960,6 +1111,31 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    if (tap->incoming_fds &&
+        (tap->fd || tap->fds || tap->helper || tap->br || tap->ifname ||
+         tap->has_sndbuf || tap->has_vnet_hdr)) {
+        error_setg(errp, "incoming-fds is incompatible with "
+                   "fd=, fds=, helper=, br=, ifname=, sndbuf= and vnet_hdr=");
+        return -1;
+    }
+
+    if (tap->incoming_fds &&
+        !(tap_is_explicit_no_script(tap->script) &&
+          tap_is_explicit_no_script(tap->downscript))) {
+        /*
+         * script="" and downscript="" are silently supported to be consistent
+         * with cases without incoming_fds, but do not care to put this into
+         * error message.
+         */
+        error_setg(errp, "incoming-fds requires script=no and downscript=no");
+        return -1;
+    }
+
+    if (tap->incoming_fds && !runstate_check(RUN_STATE_INMIGRATE)) {
+        error_setg(errp, "incoming-fds requires -incoming commandline option");
+        return -1;
+    }
+
     queues = tap_parse_fds_and_queues(tap, &fds, errp);
     if (queues < 0) {
         return -1;
@@ -978,7 +1154,30 @@ int net_init_tap(const Netdev *netdev, const char *name,
         goto fail;
     }
 
-    if (fds) {
+    if (tap->incoming_fds) {
+        for (i = 0; i < queues; i++) {
+            TAPState *s = new_tap(peer, "tap", name, i,
+                                  tap->has_local_migration_supported,
+                                  tap->local_migration_supported);
+
+            if (!s->local_migration_supported) {
+                error_setg(errp,
+                           "incoming-fds=true requires local-migration-supported=true");
+                qemu_del_net_client(&s->nc);
+                return -1;
+            }
+
+            qemu_set_info_str(&s->nc, "incoming");
+
+            s->fd = -1;
+            if (vhost_fds) {
+                s->vhostfd = vhost_fds[i];
+                s->vhost_busyloop_timeout = tap->has_poll_us ? tap->poll_us : 0;
+            } else {
+                s->vhostfd = -1;
+            }
+        }
+    } else if (fds) {
         for (i = 0; i < queues; i++) {
             if (i == 0) {
                 vnet_hdr = tap_probe_vnet_hdr(fds[i], errp);
diff --git a/qapi/net.json b/qapi/net.json
index 1a6382825c5..c5d87ba308b 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -425,6 +425,22 @@
 # @poll-us: maximum number of microseconds that could be spent on busy
 #     polling for tap (since 2.7)
 #
+# @incoming-fds: do not open or create any TAP devices.  Prepare for
+#     getting TAP file descriptors from incoming migration stream.
+#     The option is incompatible with any of @fd, @fds, @helper, @br,
+#     @ifname, @sndbuf and @vnet_hdr options, and requires @script and
+#     @downscript be explicitly set to nothing (empty string or "no"),
+#     and requires also @local-migration-supported to be true, "local"
+#     migration parameter be set as well, and QEMU being in incoming
+#     migration state.  (Since 11.1)
+#
+# @local-migration-supported: enable local migration for this TAP
+#     backend.  When set, local migration is enabled/disabled by
+#     "local" migration parameter for this TAP backend.  When unset,
+#     "local" migration parameter is ignored for this TAP backend.
+#     (Since 11.1.  Defaults to true for MT >= 11.1, and to false for
+#     MT < 11.1)
+#
 # Since: 1.2
 ##
 { 'struct': 'NetdevTapOptions',
@@ -443,7 +459,9 @@
     '*vhostfds':   'str',
     '*vhostforce': 'bool',
     '*queues':     'uint32',
-    '*poll-us':    'uint32'} }
+    '*poll-us':    'uint32',
+    '*incoming-fds': 'bool',
+    '*local-migration-supported': 'bool' } }
 
 ##
 # @NetdevSocketOptions:
-- 
2.52.0


