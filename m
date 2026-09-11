Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158FCC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9U-0002wl-Fh; Fri, 11 Sep 2026 05:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9J-0002RJ-C0
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9G-00089L-IJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U+LQxEq+xa1ZMmsDwLunNgJiMF+B5iHrSKttb1+MsNY=;
 b=GiKiqeHxzr1si6+WjYsCA+8Ef/7ItCfW4mPb+CXqPLvqW2UU6OiqpwWSX7hmacNMtWG+9U
 rpCqiZjcsZoLPvJiob86HT6pqtmRrFZaP7i+0j+shzgLAqYhv++1TDatMry/1GuNwE/czi
 HVAHGuhtdHbfl0HvCxNvj17GqQoRTvM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-ohiOhQRFNJeLSV8vHD_RwA-1; Fri, 11 Sep 2026 05:02:16 -0400
X-MC-Unique: ohiOhQRFNJeLSV8vHD_RwA-1
X-Mimecast-MFC-AGG-ID: ohiOhQRFNJeLSV8vHD_RwA_1789117335
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4858f06e142so499405f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117335; x=1789722135; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U+LQxEq+xa1ZMmsDwLunNgJiMF+B5iHrSKttb1+MsNY=;
 b=Hu1tf8/8yVMRlHFSFCT6yUm9M0P1gPhtLCiFdW1rrvexfWDfGa7UxNgJ+T0mGkVkmI
 ckN0KuoMNmgc6UliOxTUN5BLD+ZoqnEtHSGFzU4y06YA0AYLrF1qEfXQIyDoPU4j8coG
 2/x/xh0Op8ojXohFzrGr7Uzq6ozWt2xtoESznuidJokQJ+8LDpqz4lgF3lgJa8faAW1U
 BBNCk/z6dufWZGnRm4d2nurNZ+4dsAcHKR6fSItaR5G33a8qlAMgOepV2Qql33HpmcxW
 3dwba9eKeQLV07GfHNx43xeZwk1d7buffx08VzXXq0PEaWD3SPJfd35gnbI+G+1f/4Km
 18Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117335; x=1789722135;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U+LQxEq+xa1ZMmsDwLunNgJiMF+B5iHrSKttb1+MsNY=;
 b=IZdJsVJtVsE/6hrABGQKzncDvArc1tf8j78ogaNspO9OedQmwz6u5+JuJfo/TEbN9E
 RT7DPb/L4Jy4NmGT7W8JOJ1DVNUGRIW+9qNgrF8LagPqxsQYhv0zah4eXb+RdFNBfmHz
 B+5u10sO/S4hkdeFWdEYvEMJVuctFSqEjguahGQVwt8IkBtaMahjTW1YZtduVl8U5bh7
 feQOpNWZDN8SVXCvWER4PXOFxgCk7WjcFuFUhLU6Sixvo50UXroQNPQygulfnNwu8Aqd
 ddfKP+6W3inkuEMc9qSsTFuNe0qZBtsXMb2xzaD0pDCCghu3Bxl935dFLtxEOcpKp8u9
 gsyg==
X-Gm-Message-State: AFuF++ll++3G/BG+tEHJZRHM4JnLJbgt3BtMpxte9Qvo8U8wA34YiME4
 M0GGN6J68wvg91BBqnjqzCTTB4ebAW620/KAm9G2ihp/iEWpdA20JX4bzBZmhnOnywozjhc6rlm
 Oi4q2a5ngNzJ63xb2QfUD+B5tJXmeNISpo6C7qr18ktPBIRUw+FNDXJGmCwWvdtiNRRcSiLzcdd
 jrt7nZi5B0cVC3fmULpaUZEX6l6CKu2PaTtg==
X-Gm-Gg: AYBFou2pXGUa55WbRx/uWkGR1wQlyXLDTze46h1R16w8CRgu6I3zfoX+qmtLgUqmlhi
 A0uk1w987gwJcl23S35u7VYLQGVo3WwoWYsaGDEmWU2VkN4eGoEiRUVOyxvf3s+hWVK90dYQM07
 gzsdmZT9LtpXZl5T8AofaVR1gj7UCXVDVkAubhgtKFF34teLMFju71aJjlrYMkonSG26HRV0rFd
 9xAzmiY75HxigDqBiv34lZwF5FwGFEmaqoJ2+jaoL6QDzkpmgbf5R59rwd2fY3kU4cT2+0XaAvH
 bFdpfqjTYpmapP0ZNCFM67IDYhyNAbEH/us6zBmrzP2/vqH8t3u9ZDKw554/zat8jf+MnSmVLvp
 2/z8QqwXilJ9QJyt2pAArS/Q=
X-Received: by 2002:a5d:640f:0:b0:486:e5c6:cab with SMTP id
 ffacd0b85a97d-486eb31e8d9mr2672932f8f.32.1789117334763; 
 Fri, 11 Sep 2026 02:02:14 -0700 (PDT)
X-Received: by 2002:a5d:640f:0:b0:486:e5c6:cab with SMTP id
 ffacd0b85a97d-486eb31e8d9mr2672866f8f.32.1789117334065; 
 Fri, 11 Sep 2026 02:02:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33e020sm4654433f8f.18.2026.09.11.02.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:13 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL v2 23/75] net/tap: support local migration with virtio-net
Message-ID: <c4d884bb5444110f61085872885ffe463b3e104f.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


