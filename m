Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4830CCD5BB5
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 12:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQOdT-0001lJ-Th; Fri, 22 May 2026 08:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wQOdR-0001kc-NJ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 08:05:49 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wQOdP-0000YL-Iy
 for qemu-devel@nongnu.org; Fri, 22 May 2026 08:05:49 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2E52480789;
 Fri, 22 May 2026 15:05:46 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:55c::1:1d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id Z5T7aO0g14Y0-X80J1ERx; Fri, 22 May 2026 15:05:45 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779451545;
 bh=12pqg3dT9WJWWFoeSjTe916/MEY1KbGJxOg3vTcaqb4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=YYHVfDxA7YSocwXY0SBRj8KSNRpIQu/q8k3ey+BYX3vLSP/u+O42RnzLQ2zDbEv/R
 p+MVGdT4E9rdQbCEwmRwJXWGhwa+ucvoQcmWHV+VbWWpc2A6unC15no4NYY3qlkCqT
 9hCa5m9QIZZo0YYIRWcMRI3I68p4juenPOaVkdnk=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, Eric Blake <eblake@redhat.com>
Subject: [PATCH v16 6/8] net/tap: support local migration with virtio-net
Date: Fri, 22 May 2026 15:05:31 +0300
Message-ID: <20260522120534.77653-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260522120534.77653-1-vsementsov@yandex-team.ru>
References: <20260522120534.77653-1-vsementsov@yandex-team.ru>
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

Support transferring of TAP state (including open fd) through
migration stream as part of viritio-net "local-migration".

Add new option, incoming-fds, which should be set to true to
trigger new logic.

For new option require explicitly unset script and downscript,
to keep possibility of implementing support for them in future.

Note disabling read polling on source stop for TAP migration:
otherwise, source process may steal packages from TAP fd even
after source vm STOP.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 net/tap.c     | 147 +++++++++++++++++++++++++++++++++++++++++++++++---
 qapi/net.json |  10 +++-
 2 files changed, 150 insertions(+), 7 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 9d6213fc3e5..9b1d4613a0b 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -36,6 +36,7 @@
 #include "net/net.h"
 #include "clients.h"
 #include "monitor/monitor.h"
+#include "system/runstate.h"
 #include "system/system.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
@@ -86,6 +87,9 @@ typedef struct TAPState {
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
     Notifier exit;
+
+    bool read_poll_detached;
+    VMChangeStateEntry *vmstate;
 } TAPState;
 
 static void launch_script(const char *setup_script, const char *ifname,
@@ -94,19 +98,25 @@ static void launch_script(const char *setup_script, const char *ifname,
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
@@ -123,6 +133,23 @@ static void tap_read_poll(TAPState *s, bool enable)
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
@@ -353,6 +380,11 @@ static void tap_cleanup(NetClientState *nc)
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
@@ -393,6 +425,65 @@ static VHostNetState *tap_get_vhost_net(NetClientState *nc)
     return s->vhost_net;
 }
 
+static bool tap_is_wait_incoming(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
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
+static const VMStateDescription vmstate_tap = {
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
 /* fd support */
 
 static NetClientInfo net_tap_info = {
@@ -412,7 +503,9 @@ static NetClientInfo net_tap_info = {
     .set_vnet_le = tap_set_vnet_le,
     .set_vnet_be = tap_set_vnet_be,
     .set_steering_ebpf = tap_set_steering_ebpf,
+    .is_wait_incoming = tap_is_wait_incoming,
     .get_vhost_net = tap_get_vhost_net,
+    .backend_vmsd = &vmstate_tap,
 };
 
 static TAPState *net_tap_fd_init(NetClientState *peer,
@@ -748,6 +841,9 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     int sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
 
+    s->read_poll_detached = false;
+    s->vmstate = qemu_add_vm_change_state_handler(tap_vm_state_change, s);
+
     if (!tap_set_sndbuf(fd, sndbuf, sndbuf_required ? errp : NULL) &&
         sndbuf_required) {
         goto failed;
@@ -779,6 +875,8 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     return true;
 
 failed:
+    qemu_del_vm_change_state_handler(s->vmstate);
+    s->vmstate = NULL;
     qemu_del_net_client(&s->nc);
     return false;
 }
@@ -910,6 +1008,26 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
     queues = tap_parse_fds_and_queues(tap, &fds, errp);
     if (queues < 0) {
         return -1;
@@ -928,7 +1046,24 @@ int net_init_tap(const Netdev *netdev, const char *name,
         goto fail;
     }
 
-    if (fds) {
+    if (tap->incoming_fds) {
+        for (i = 0; i < queues; i++) {
+            NetClientState *nc;
+            TAPState *s;
+
+            nc = qemu_new_net_client(&net_tap_info, peer, "tap", name);
+            qemu_set_info_str(nc, "incoming");
+
+            s = DO_UPCAST(TAPState, nc, nc);
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
index 1a6382825c5..82ddbb51cd7 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -425,6 +425,13 @@
 # @poll-us: maximum number of microseconds that could be spent on busy
 #     polling for tap (since 2.7)
 #
+# @incoming-fds: do not open or create any TAP devices.  Prepare for
+#     getting TAP file descriptors from incoming migration stream.
+#     The option is incompatible with any of @fd, @fds, @helper, @br,
+#     @ifname, @sndbuf and @vnet_hdr options, and requires @script and
+#     @downscript be explicitly set to nothing (empty string or "no")
+#     (Since 11.1)
+#
 # Since: 1.2
 ##
 { 'struct': 'NetdevTapOptions',
@@ -443,7 +450,8 @@
     '*vhostfds':   'str',
     '*vhostforce': 'bool',
     '*queues':     'uint32',
-    '*poll-us':    'uint32'} }
+    '*poll-us':    'uint32',
+    '*incoming-fds': 'bool' } }
 
 ##
 # @NetdevSocketOptions:
-- 
2.52.0


