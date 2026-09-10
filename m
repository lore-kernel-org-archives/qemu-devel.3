Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610EEC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mcj-0004or-Cy; Thu, 10 Sep 2026 17:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lLe-00032d-0e
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lLQ-0000T5-5B
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U+LQxEq+xa1ZMmsDwLunNgJiMF+B5iHrSKttb1+MsNY=;
 b=RORjQLr6tHAHN+EMReNDzSZV02U2HCsCNVs4nL9i/ZyBQgOSNdHuy3NEKWzjjvbjsMH8fk
 iYniKYvUBY47vG4q8I1e6Y59BHUYkGHiJRTqep7bH6snqCIEUj1Qs+x4HDqxbnPxcScgUX
 2yPMy7SJpRFyDhoayvOzmZS3G3Fj2/M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-16T8oqJAM1Cmpxh2LBsRBA-1; Thu, 10 Sep 2026 16:12:53 -0400
X-MC-Unique: 16T8oqJAM1Cmpxh2LBsRBA-1
X-Mimecast-MFC-AGG-ID: 16T8oqJAM1Cmpxh2LBsRBA_1789071172
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-495569acf8dso874695e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071172; x=1789675972; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U+LQxEq+xa1ZMmsDwLunNgJiMF+B5iHrSKttb1+MsNY=;
 b=YtCDvmTIX0BqDxNwYJvldmSYAhQdchtm2Un7iyDZ8iLv4Nc6MFk2f9vD7XyiR1iJnY
 xrIshsIjQ6VOErgKFFbtFlVIlVYB5EZemuTYTw045onmYX49HPc46XG1DDmLKUrQ+Lj8
 TNJvvXob9kSfL2WmRo0CpoZ9iC0CjjV1IsjqYJsFDh0qKzQlUfR1bWjyRHujNtG+0+MG
 7llMCRxxh2E0us5bmb4HSOS4WV0gtiZoi93ERHHzOtDYanO4a1IkgENu6tXWQjXFUoQs
 JE/PFUxtSq8v3RjKjE4IdM3QwG+ny8P4Cdjf4UUgxoTKV6Qchh67EoYzL4pa4VCKWWYR
 RE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071172; x=1789675972;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U+LQxEq+xa1ZMmsDwLunNgJiMF+B5iHrSKttb1+MsNY=;
 b=DMXFLW7us7RXRccBSC0imQVKtnUHVOiI2JtN0wnxuAbsQIgcUZWcawIRWzuY2C4NpI
 NOOVeKxQlzwSWTy4Vx4aNvId52nH1bekqJfuVD5/dF0u11wkJxdM5lVXtd07+fmYiMvd
 cXtbkCa8UBC6Dn8r4ndMBvYzes24zC/3EO5YMUibOVhpiWOkOc6N90w6iKcIodb7vHRV
 MhXPagiyXNsm8YSj/NiJN0iRzVdtHBHbSW+MApGDUkqMlyZR2nlXCa5dJJvgSPz9247g
 MBaKy9cOb2ZmzyfnEaYdebTC/d0jexbjHQ0w9JNz3reCnEJpmun+alATj35aAvzSIAs3
 tC7g==
X-Gm-Message-State: AFuF++m1AwF+ypcaRMnq5h8/mFJd0M9ErhBa9ncykbEFeKXGH0b8gi5r
 kLZlGkEOjrvewtJmhxENdmsYfkqyUMT+rZiOQto+KQ7kaV+dkWVPpmfOgqYJ8pt9ZOUIKsCr7QZ
 0cR3NpLPQtGYqfuBiN7uzEpHQAbOFEgl83fHmS2Ea1uy5SlNhszu3wHr7HAaIe60IPgf/W/V83h
 +hrOgBQ88oRrl84oJ3fI2IX9AnUBM9n3Sd+g==
X-Gm-Gg: AYBFou2N4vdB/HOzl41zrgFZJP4ksmwK0e4PUKEHTCc36H+GCp0jjZH5c/rrUg8xw1b
 9cPIemCw7dxvo7C8ehZtUgrVO6CHYHV+xJdxHTEEljm4K7LmTfePFV+yQoxtPi/YjDbPuK/CQJh
 IfkutlTt5WpS+t6/oDOYfvX9lIVb7fPwzvRXnoQWwPIQd3WIhj3ZI4NqTJ1asygm7ENvKiK8fMj
 1s79Q8zN2NQnTxkZjA8xOe3JVgOy2vmtGB3WmnbYHMAJRS2tg48HpXi6pg0vHR3EVCXv7GM0KfW
 0YetfymkYJHrm2qfQ7qed9GaIDVQUmt9+VhDfdExUY0z1qdKwN9fU6K05RYs9x6vP8VrjB63bXH
 daErueq6S9P4HNQTG9MWtS5c=
X-Received: by 2002:a05:600c:4e0c:b0:49c:ed94:cdd8 with SMTP id
 5b1f17b1804b1-49e6198734emr20904895e9.6.1789071172082; 
 Thu, 10 Sep 2026 13:12:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0c:b0:49c:ed94:cdd8 with SMTP id
 5b1f17b1804b1-49e6198734emr20903925e9.6.1789071171540; 
 Thu, 10 Sep 2026 13:12:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60a8a89esm18273605e9.1.2026.09.10.13.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:51 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 33/90] net/tap: support local migration with virtio-net
Message-ID: <332b7ea34541d246b556964a04f1d9767f2f3556.1789071042.git.mst@redhat.com>
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
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-16-vsementsov@yandex-team.ru>
---
 qapi/net.json |  29 ++++++++-
 net/tap.c     | 167 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 189 insertions(+), 7 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index dccf95bbbc..64c0ef1f6d 100644
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
diff --git a/net/tap.c b/net/tap.c
index 51d028d956..d71e3dd117 100644
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
-- 
MST


