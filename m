Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BC6CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXqz-0006Cr-06; Fri, 19 Sep 2025 05:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqj-00066T-RY
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:18 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqa-0004bJ-8S
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 6A30380EEC;
 Fri, 19 Sep 2025 12:55:59 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a72::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ntP1fK1GvGk0-dH6gTk4y; Fri, 19 Sep 2025 12:55:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758275758;
 bh=YfB/zHdqRSdlEQYKyrkvvHQ8ka4OYKqJMpFDAmzCODs=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Ljd4lEAz+pw+i6QWFBIyvQ6Iwt23we8cqcwExgPeovYLNoWD6W0aYjgL6hZMHVgsc
 bLUHY7TozP3QsySFSymPvOFfOk7odBDtqfwD/KFqzm4qdPjXUjS3IoNda6ngtq2VLq
 PphrghqQF1eTUPB04GNN9pKhIEX5vjolpy8Ylioc=
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
Subject: [PATCH v5 11/19] net/tap: move vhost fd initialization to
 net_tap_new()
Date: Fri, 19 Sep 2025 12:55:37 +0300
Message-ID: <20250919095545.1912042-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
References: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Last step to get rid of dependency on @tap in net_tap_setup().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 96 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 43 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index b4682d7400..b7175e4b10 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -83,11 +83,11 @@ typedef struct TAPState {
 
     bool sndbuf_required;
     int sndbuf;
+    int vhostfd;
+    uint32_t vhost_busyloop_timeout;
 } TAPState;
 
-static bool net_tap_setup(TAPState *s, const NetdevTapOptions *tap,
-                          const char *vhostfdname,
-                          int fd, int vnet_hdr, Error **errp);
+static bool net_tap_setup(TAPState *s, int fd, int vnet_hdr, Error **errp);
 
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp);
@@ -336,6 +336,11 @@ static void tap_cleanup(NetClientState *nc)
     tap_write_poll(s, false);
     close(s->fd);
     s->fd = -1;
+
+    if (s->vhostfd != -1) {
+        close(s->vhostfd);
+        s->vhostfd = -1;
+    }
 }
 
 static void tap_poll(NetClientState *nc, bool enable)
@@ -394,12 +399,14 @@ static NetClientInfo net_tap_info = {
 };
 
 static TAPState *net_tap_new(NetClientState *peer, const char *model,
-                             const char *name, const NetdevTapOptions *tap)
+                             const char *name, const NetdevTapOptions *tap,
+                             const char *vhostfdname, Error **errp)
 {
     NetClientState *nc = qemu_new_net_client(&net_tap_info, peer, model, name);
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
 
     s->fd = -1;
+    s->vhostfd = -1;
 
     if (!tap) {
         return s;
@@ -409,7 +416,39 @@ static TAPState *net_tap_new(NetClientState *peer, const char *model,
     s->sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
 
+    if (tap->has_vhost ? tap->vhost :
+        vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
+        if (vhostfdname) {
+            s->vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
+            if (s->vhostfd == -1) {
+                goto failed;
+            }
+            if (!g_unix_set_fd_nonblocking(s->vhostfd, true, NULL)) {
+                error_setg_errno(errp, errno, "Can't use file descriptor %d",
+                                 s->fd);
+                goto failed;
+            }
+        } else {
+            s->vhostfd = open("/dev/vhost-net", O_RDWR);
+            if (s->vhostfd < 0) {
+                error_setg_errno(errp, errno,
+                                 "tap: open vhost char device failed");
+                goto failed;
+            }
+            if (!g_unix_set_fd_nonblocking(s->vhostfd, true, NULL)) {
+                error_setg_errno(errp, errno, "Failed to set FD nonblocking");
+                goto failed;
+            }
+        }
+
+        s->vhost_busyloop_timeout = tap->poll_us;
+    }
+
     return s;
+
+failed:
+    qemu_del_net_client(&s->nc);
+    return NULL;
 }
 
 static bool net_tap_set_fd(TAPState *s, int fd, int vnet_hdr, Error **errp)
@@ -657,7 +696,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    s = net_tap_new(peer, "bridge", name, NULL);
+    s = net_tap_new(peer, "bridge", name, NULL, NULL, &error_abort);
     net_tap_set_fd(s, fd, vnet_hdr, &error_abort);
 
     qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
@@ -700,7 +739,10 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *downscript, const char *vhostfdname,
                              int vnet_hdr, int fd, Error **errp)
 {
-    TAPState *s = net_tap_new(peer, model, name, tap);
+    TAPState *s = net_tap_new(peer, model, name, tap, vhostfdname, errp);
+    if (!s) {
+        return;
+    }
 
     if (tap->fd || tap->fds) {
         qemu_set_info_str(&s->nc, "fd=%d", fd);
@@ -719,56 +761,24 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
     }
 
-    if (!net_tap_setup(s, tap, vhostfdname, fd, vnet_hdr, errp)) {
+    if (!net_tap_setup(s, fd, vnet_hdr, errp)) {
         qemu_del_net_client(&s->nc);
     }
 }
 
-static bool net_tap_setup(TAPState *s, const NetdevTapOptions *tap,
-                          const char *vhostfdname,
-                          int fd, int vnet_hdr, Error **errp)
+static bool net_tap_setup(TAPState *s, int fd, int vnet_hdr, Error **errp)
 {
-    int vhostfd;
-
     if (!net_tap_set_fd(s, fd, vnet_hdr, errp)) {
         return false;
     }
 
-    if (tap->has_vhost ? tap->vhost :
-        vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
+    if (s->vhostfd != -1) {
         VhostNetOptions options;
 
         options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
         options.net_backend = &s->nc;
-        if (tap->has_poll_us) {
-            options.busyloop_timeout = tap->poll_us;
-        } else {
-            options.busyloop_timeout = 0;
-        }
-
-        if (vhostfdname) {
-            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
-            if (vhostfd == -1) {
-                return false;
-            }
-            if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
-                error_setg_errno(errp, errno, "Can't use file descriptor %d",
-                                 fd);
-                return false;
-            }
-        } else {
-            vhostfd = open("/dev/vhost-net", O_RDWR);
-            if (vhostfd < 0) {
-                error_setg_errno(errp, errno,
-                                 "tap: open vhost char device failed");
-                return false;
-            }
-            if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
-                error_setg_errno(errp, errno, "Failed to set FD nonblocking");
-                return false;
-            }
-        }
-        options.opaque = (void *)(uintptr_t)vhostfd;
+        options.busyloop_timeout = s->vhost_busyloop_timeout;
+        options.opaque = (void *)(uintptr_t)s->vhostfd;
         options.nvqs = 2;
         options.feature_bits = kernel_feature_bits;
         options.get_acked_features = NULL;
-- 
2.48.1


