Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7723CFCC07C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 21:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vycmy-000234-GF; Fri, 06 Mar 2026 16:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vycmw-000223-2V
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 16:32:50 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vycmt-0007IJ-UA
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 16:32:49 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 96AC1808AD;
 Sat, 07 Mar 2026 00:32:46 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:33::1:4])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bW0W0m0BECg0-FLdU1XZC; Sat, 07 Mar 2026 00:32:45 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772832765;
 bh=h9MXV66q/bfxFJa65B4g76Pi3XVYBdDxXKUkPJyRw+M=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=DFQUyhNvhZuu/fvfqiFVN1sX7N/ZtsAOng0xsXg4+x5QdAKSTE+X/qjXdrUe7RGmb
 xzb6P8mnx7l4yEpR95KCvd0X08yrzbL9NxT6bVGWu9wzisnM/ODdGhZzaqxPEj/0QL
 vAd58PJ+HFf1IEApeAZEi69u+ykM2ulRTlQbQwao=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: thuth@redhat.com, armbru@redhat.com, eblake@redhat.com, farosas@suse.de,
 peterx@redhat.com, zhao1.liu@intel.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru, leiyang@redhat.com,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com
Subject: [PATCH v12 6/8] net/tap: support local migration with virtio-net
Date: Sat,  7 Mar 2026 00:32:33 +0300
Message-ID: <20260306213235.216863-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260306213235.216863-1-vsementsov@yandex-team.ru>
References: <20260306213235.216863-1-vsementsov@yandex-team.ru>
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c     | 114 +++++++++++++++++++++++++++++++++++++++++++++++---
 qapi/net.json |   6 ++-
 2 files changed, 113 insertions(+), 7 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 2b96348eb18..412b91d3780 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -94,19 +94,25 @@ static void launch_script(const char *setup_script, const char *ifname,
 static void tap_send(void *opaque);
 static void tap_writable(void *opaque);
 
+static bool tap_is_explicit_no_scirpt(const char *script_arg)
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
+    if (tap_is_explicit_no_scirpt(script_arg)) {
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
@@ -393,6 +399,65 @@ static VHostNetState *tap_get_vhost_net(NetClientState *nc)
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
@@ -412,7 +477,9 @@ static NetClientInfo net_tap_info = {
     .set_vnet_le = tap_set_vnet_le,
     .set_vnet_be = tap_set_vnet_be,
     .set_steering_ebpf = tap_set_steering_ebpf,
+    .is_wait_incoming = tap_is_wait_incoming,
     .get_vhost_net = tap_get_vhost_net,
+    .backend_vmsd = &vmstate_tap,
 };
 
 static TAPState *net_tap_fd_init(NetClientState *peer,
@@ -909,6 +976,24 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    if (tap->incoming_fds && (tap->fd || tap->fds || tap->helper)) {
+        error_setg(errp, "incoming-fds is incompatible with "
+                   "fd=, fds=, helper=");
+        return -1;
+    }
+
+    if (tap->incoming_fds &&
+        !(tap_is_explicit_no_scirpt(tap->script) &&
+          tap_is_explicit_no_scirpt(tap->downscript))) {
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
@@ -927,7 +1012,24 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
index 118bd349651..79f5ce9f431 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -355,6 +355,9 @@
 # @poll-us: maximum number of microseconds that could be spent on busy
 #     polling for tap (since 2.7)
 #
+# @incoming-fds: do not open/connnect any resources, instead wait for
+#     TAP state from incoming migration stream.  (Since 11.0)
+#
 # Since: 1.2
 ##
 { 'struct': 'NetdevTapOptions',
@@ -373,7 +376,8 @@
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


