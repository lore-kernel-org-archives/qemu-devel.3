Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D33DC5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 18:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkce-0004Ms-8H; Wed, 19 Aug 2026 14:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwkcd-0004MU-DN
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:02:43 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwkca-0007S3-NA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 14:02:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 71800C08B3;
 Wed, 19 Aug 2026 21:02:39 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:c60::1:5])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id M2bUThDaVKo0-rooC7FPP; Wed, 19 Aug 2026 21:02:38 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787162558;
 bh=e2rBzwUCA7XeNrK1WrokcsWbKojtljjW4a/q86xAHFk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=pXBsnDQvpX5NgdlWrs+no4IT/8/YNT5wFrvcZxUgEeHA30Zv/zolGFu+w7OqtDiNN
 HGdk0SGfD9+hDJH5fAE0SyfskiI3oxtlmA/NeWJWorwx+WQM6QJbEFprnKWCCUD+WY
 fLX3czpKDPJk24oBToxGGI0lEeWa76Uj1EFA7cCc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v21 15/16] net/tap: support local migration with virtio-net
Date: Wed, 19 Aug 2026 21:01:58 +0300
Message-ID: <20260819180201.1970193-16-vsementsov@yandex-team.ru>
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

Support transferring of TAP state (including open fd).

Add new property "x-permit-local-migration", which defines whether
local migration is actually permitted for this TAP device.

Note that local-migration is enabled by global "local" migration
parameter, but individual devices may have additional options to
enable/disable it per device.

The tricky thing is that we need to know whether to call open/connect in
TAP initialization code, i.e. we need to know the value of migration
parameter "local" when creating the TAP device.  For incoming migration,
we can know only for TAP devices created with QMP after setting the
migration parameter with QMP.

So the full picture is:

On source, to start outgoing "local" migration you need:

 - migration parameter "local" set to true
 - "x-permit-local-migration" TAP option set to true

If at least one of these options is not set, TAP backend
doesn't participate in migration.

On target, things are more difficult:

Same, you need both "local" and "x-permit-local-migration"
be set. And same, if one of them is not set, TAP backend
is initialized as usual, and doesn't accept any incoming
state.

Additionally, if you are going to set "local", it must be
set before creating the TAP device. If TAP device created
with "local" unset, it initializes as usual. If you enable
"local" after it and start incoming migration, it will fail
in .pre_load handler of TAP backend.

Moreover, there are interface restrictions: if you create TAP
device when QEMU is in INCOMING state, and both "local"
and "x-permit-local-migration" set, most of TAP options are
not allowed, and script/downscript are required to be explicitly
disabled.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 net/tap.c     | 167 ++++++++++++++++++++++++++++++++++++++++++++++++--
 qapi/net.json |  29 ++++++++-
 2 files changed, 189 insertions(+), 7 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 51d028d9567..d71e3dd1175 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -38,12 +38,17 @@
 #include "monitor/monitor.h"
 #include "system/runstate.h"
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
@@ -71,6 +76,8 @@ static const int kernel_feature_bits[] = {
 
 OBJECT_DECLARE_SIMPLE_TYPE(TAPState, TAP_NETDEV)
 
+static const VMStateDescription vmstate_tap;
+
 struct TAPState {
     Object parent_obj;
 
@@ -95,6 +102,7 @@ struct TAPState {
     int queue_index;
     bool enable_poll_on_resume;
     VMChangeStateEntry *vmstate;
+    bool permit_local_migration;
 };
 
 static void launch_script(const char *setup_script, const char *ifname,
@@ -412,6 +420,8 @@ static void tap_cleanup(NetClientState *nc)
     tap_write_poll(s, false);
     close(s->fd);
     s->fd = -1;
+
+    vmstate_unregister(VMSTATE_IF(s), &vmstate_tap, s);
 }
 
 static void tap_poll(NetClientState *nc, bool enable)
@@ -448,6 +458,78 @@ static VHostNetState *tap_get_vhost_net(NetClientState *nc)
     return s->vhost_net;
 }
 
+static bool tap_is_wait_incoming(NetClientState *nc)
+{
+    TAPState *s = container_of(nc, TAPState, nc);
+    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
+    return s->fd == -1;
+}
+
+static bool tap_pre_load(void *opaque, Error **errp)
+{
+    ERRP_GUARD();
+    TAPState *s = opaque;
+
+    if (s->fd != -1) {
+        error_setg(errp,
+                   "TAP is already initialized and cannot receive "
+                   "incoming fd");
+        error_append_hint(errp,
+                          "Migration parameter 'local' must be set"
+                          " before creating the TAP device.");
+        return false;
+    }
+
+    return true;
+}
+
+static bool tap_setup_vhost(TAPState *s, Error **errp);
+
+static bool tap_post_load(void *opaque, int version_id, Error **errp)
+{
+    ERRP_GUARD();
+    TAPState *s = opaque;
+
+    tap_read_poll(s, true);
+
+    if (s->fd < 0) {
+        error_setg(errp, "FD was not loaded during incoming migration");
+        return false;
+    }
+
+    if (!tap_setup_vhost(s, errp)) {
+        error_prepend(errp,
+                      "Failed to setup vhost during TAP post-load: ");
+        return false;
+    }
+
+    return true;
+}
+
+static bool tap_needed(void *opaque)
+{
+    TAPState *s = opaque;
+
+    return s->permit_local_migration && migrate_local();
+}
+
+static const VMStateDescription vmstate_tap = {
+    .name = "net-tap",
+    .priority = MIG_PRI_BACKEND,
+    .pre_load_errp = tap_pre_load,
+    .post_load_errp = tap_post_load,
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
@@ -456,17 +538,42 @@ static char *tap_vmstate_if_get_id(VMStateIf *obj)
     return res;
 }
 
+static bool tap_get_permit_local_migration_prop(Object *obj, Error **errp)
+{
+    TAPState *s = TAP_NETDEV(obj);
+    return s->permit_local_migration;
+}
+
+static void tap_set_permit_local_migration_prop(Object *obj, bool value,
+                                                Error **errp)
+{
+    TAPState *s = TAP_NETDEV(obj);
+    s->permit_local_migration = value;
+}
+
+static void tap_instance_init(Object *obj)
+{
+    TAPState *s = TAP_NETDEV(obj);
+    s->permit_local_migration = false;
+}
+
 static void tap_class_init(ObjectClass *klass, const void *data)
 {
     VMStateIfClass *vc = VMSTATE_IF_CLASS(klass);
 
     vc->get_id = tap_vmstate_if_get_id;
+
+    object_class_property_add_bool(klass, "x-permit-local-migration",
+                                   tap_get_permit_local_migration_prop,
+                                   tap_set_permit_local_migration_prop);
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
@@ -499,13 +606,16 @@ static NetClientInfo net_tap_info = {
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
+                         bool has_permit_local_migration,
+                         bool permit_local_migration)
 {
     TAPState *s = TAP_NETDEV(object_new(TYPE_TAP_NETDEV));
 
@@ -514,6 +624,12 @@ static TAPState *new_tap(NetClientState *peer,
 
     s->queue_index = queue_index;
 
+    if (has_permit_local_migration) {
+        s->permit_local_migration = permit_local_migration;
+    }
+
+    vmstate_register(VMSTATE_IF(s), VMSTATE_INSTANCE_ID_ANY, &vmstate_tap, s);
+
     return s;
 }
 
@@ -522,10 +638,14 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
                                  const char *name,
                                  int fd,
                                  int vnet_hdr,
-                                 int queue_index)
+                                 int queue_index,
+                                 bool has_permit_local_migration,
+                                 bool permit_local_migration)
 {
     NetOffloads ol = {};
-    TAPState *s = new_tap(peer, model, name, queue_index);
+    TAPState *s = new_tap(peer, model, name, queue_index,
+                          has_permit_local_migration,
+                          permit_local_migration);
 
     s->fd = fd;
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
@@ -762,7 +882,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         close(fd);
         return -1;
     }
-    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr, 0);
+    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr, 0, true, false);
 
     qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
 
@@ -842,7 +962,9 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              Error **errp)
 {
     TAPState *s = net_tap_fd_init(peer, tap->helper ? "bridge" : "tap",
-                                  name, fd, vnet_hdr, queue_index);
+                                  name, fd, vnet_hdr, queue_index,
+                                  tap->has_x_permit_local_migration,
+                                  tap->x_permit_local_migration);
     bool sndbuf_required = tap->has_sndbuf;
     int sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
@@ -990,6 +1112,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
     /* for the no-fd, no-helper case */
     char ifname[128];
     int *fds = NULL, *vhost_fds = NULL;
+    bool incoming_fds;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
@@ -1012,6 +1135,23 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    incoming_fds = tap->x_permit_local_migration && migrate_local() &&
+                   runstate_check(RUN_STATE_INMIGRATE);
+
+    if (incoming_fds &&
+        (tap->fd || tap->fds || tap->helper || tap->br || tap->ifname ||
+         tap->has_sndbuf || tap->has_vnet_hdr ||
+         !tap_is_explicit_no_script("script", tap->script) ||
+         !tap_is_explicit_no_script("downscript", tap->downscript))) {
+        error_setg(errp, "Local incoming migration of TAP device (-incoming, "
+                   "migration parameter @local is set, "
+                   "TAP parameter @x-permit-local-migration is set) "
+                   "is incompatible with "
+                   "fd=, fds=, helper=, br=, ifname=, sndbuf= and vnet_hdr=, "
+                   "and requires explicit empty script= and downscript=");
+        return -1;
+    }
+
     queues = tap_parse_fds_and_queues(tap, &fds, errp);
     if (queues < 0) {
         return -1;
@@ -1030,7 +1170,22 @@ int net_init_tap(const Netdev *netdev, const char *name,
         goto fail;
     }
 
-    if (fds) {
+    if (incoming_fds) {
+        for (i = 0; i < queues; i++) {
+            TAPState *s = new_tap(peer, "tap", name, i,
+                                  tap->has_x_permit_local_migration,
+                                  tap->x_permit_local_migration);
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
index acb8594c952..a135767984b 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -437,6 +437,31 @@
 # @poll-us: maximum number of microseconds that could be spent on busy
 #     polling for tap (since 2.7)
 #
+# @x-permit-local-migration: permit local migration for this TAP
+#     backend.  When set, local migration is enabled/disabled by
+#     migration parameter @local for this TAP backend.  When unset,
+#     migration parameter @local is ignored for this TAP backend.
+#
+#     To be able to do incoming local migration of a TAP backend,
+#     migration parameter @local must be set _before_ creating the
+#     TAP backend.  Otherwise, TAP backend is initialized as usual,
+#     opening/creating TAP devices in kernel.  In this case further
+#     local incoming migration (with migration parameter @local set
+#     after creating TAP backend with @x-permit-local-migration
+#     parameter set) will simply fail.
+#
+#     Moreover, when QEMU is in incoming migration state, migration
+#     parameter @local is set and @x-permit-local-migration is set,
+#     the following options are not supported and must not be set:
+#     @fd, @fds, @helper, @br, @ifname, @sndbuf, @vnet_hdr.
+#     Additionally, @script and @downscript must be explicitly
+#     disabled then.
+#     (default: false, since 11.2)
+#
+# Features:
+#
+# @unstable: Member @x-permit-local-migration is experimental.
+#
 # Since: 1.2
 ##
 { 'struct': 'NetdevTapOptions',
@@ -455,7 +480,9 @@
     '*vhostfds':   'str',
     '*vhostforce': 'bool',
     '*queues':     'uint32',
-    '*poll-us':    'uint32'} }
+    '*poll-us':    'uint32',
+    '*x-permit-local-migration': {
+      'type': 'bool', 'features' : [ 'unstable'] } } }
 
 ##
 # @NetdevSocketOptions:
-- 
2.43.0


