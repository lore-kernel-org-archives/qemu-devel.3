Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA01E65298
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 16:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmaBS-0001Bq-Oy; Sun, 01 Feb 2026 11:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vmaBO-0001AT-64
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 11:20:18 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vmaBK-0005Ye-8V
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 11:20:17 -0500
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E7CA8807F6;
 Sun, 01 Feb 2026 19:20:12 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:765::1:3b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 4Kp2C46Aq8c0-ufP40ES0; Sun, 01 Feb 2026 19:20:12 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769962812;
 bh=P1HaemTso6fzJD5byCYPxAqcpX9YE+ug+soY+b3svcs=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=b3TWEPpZeTlsTYgHvsbKfDPZeiEsb6RrhPwzHmqqD1P5iRy/krROqaOMMSbRJcEmj
 ww0oE1D2h5wWh/3DkBQFfYwJt2g/OviyLVtNkKiTNazjsDW4BVKIezLzs5dEzs9Rdt
 pYXeuMAkz7RxAXVNH51C6lSJ3aVYA5m+AvEcffxM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, thuth@redhat.com,
 armbru@redhat.com, eblake@redhat.com, farosas@suse.de, peterx@redhat.com,
 zhao1.liu@intel.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru, leiyang@redhat.com,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com
Subject: [PATCH v10 6/8] net/tap: support backend-transfer migration
Date: Sun,  1 Feb 2026 19:19:58 +0300
Message-ID: <20260201162001.296328-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201162001.296328-1-vsementsov@yandex-team.ru>
References: <20260201162001.296328-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
migration stream.

Add new option, incoming-fds, which should be set to true to
trigger new logic.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c     | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 qapi/net.json |  6 +++-
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index bd19c71c42..57d4d2d9f8 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -393,6 +393,65 @@ static VHostNetState *tap_get_vhost_net(NetClientState *nc)
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
@@ -412,7 +471,9 @@ static NetClientInfo net_tap_info = {
     .set_vnet_le = tap_set_vnet_le,
     .set_vnet_be = tap_set_vnet_be,
     .set_steering_ebpf = tap_set_steering_ebpf,
+    .is_wait_incoming = tap_is_wait_incoming,
     .get_vhost_net = tap_get_vhost_net,
+    .backend_vmsd = &vmstate_tap,
 };
 
 static TAPState *net_tap_fd_init(NetClientState *peer,
@@ -907,6 +968,14 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    if (tap->incoming_fds &&
+        (tap->fd || tap->fds || tap->helper || tap->script ||
+         tap->downscript)) {
+        error_setg(errp, "incoming-fds is incompatible with "
+                   "fd=, fds=, helper=, script=, downscript=");
+        return -1;
+    }
+
     queues = tap_parse_fds_and_queues(tap, &fds, errp);
     if (queues < 0) {
         return -1;
@@ -925,7 +994,24 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
index 118bd34965..79f5ce9f43 100644
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


