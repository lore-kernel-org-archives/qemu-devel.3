Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE3CCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zqa-00038s-Sg; Tue, 23 Sep 2025 06:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zqF-0002sL-9W
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:48 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v0zpw-0000ur-JS
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:01:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 1982680A41;
 Tue, 23 Sep 2025 13:01:20 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id C1Ug0C0Fha60-DqZvLq09; Tue, 23 Sep 2025 13:01:19 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758621679;
 bh=0hyZv3Tmf7qh6fxmfFpnAzLfwhXELi2XZF0zR5DEdEY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=x2eL+kBaTTQliz+ZoHsyTs6C26oZglC9BkKB38rxUeKJQbAZfj6lhoUHXWRFzk5uk
 VvmGMe6k0Jjdcg5Be0aoJ2K669zDdCtfZByF67muoItoVMFeTcCbQQLmcleZLFPCQ3
 Qv23kc12rdNJ/HpwNpHNBnz3b2ZMBS/vA8ByaD2Q=
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
Subject: [PATCH v6 12/19] net/tap: move vhost fd initialization to
 net_tap_new()
Date: Tue, 23 Sep 2025 13:01:03 +0300
Message-ID: <20250923100110.70862-13-vsementsov@yandex-team.ru>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Continue the track to avoid dependency on @tap in net_tap_setup(),
no move the vhost fd initialization to net_tap_new(). So in
net_tap_setup() we simply check, do we have and vhostfd at this
point or not.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 90 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 40 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 877564405a..dbd1eb3a17 100644
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
@@ -351,6 +351,11 @@ static void tap_cleanup(NetClientState *nc)
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
@@ -409,12 +414,14 @@ static NetClientInfo net_tap_info = {
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
@@ -424,7 +431,36 @@ static TAPState *net_tap_new(NetClientState *peer, const char *model,
     s->sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
 
+    if (tap->has_vhost ? tap->vhost :
+        vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
+        if (vhostfdname) {
+            s->vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
+            if (s->vhostfd == -1) {
+                goto failed;
+            }
+            if (!qemu_set_blocking(s->vhostfd, false, errp)) {
+                goto failed;
+            }
+        } else {
+            s->vhostfd = open("/dev/vhost-net", O_RDWR);
+            if (s->vhostfd < 0) {
+                error_setg_errno(errp, errno,
+                                 "tap: open vhost char device failed");
+                goto failed;
+            }
+            if (!qemu_set_blocking(s->vhostfd, false, errp)) {
+                goto failed;
+            }
+        }
+
+        s->vhost_busyloop_timeout = tap->has_poll_us ? tap->poll_us : 0;
+    }
+
     return s;
+
+failed:
+    qemu_del_net_client(&s->nc);
+    return NULL;
 }
 
 static bool net_tap_set_fd(TAPState *s, int fd, int vnet_hdr, Error **errp)
@@ -671,7 +707,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    s = net_tap_new(peer, "bridge", name, NULL);
+    s = net_tap_new(peer, "bridge", name, NULL, NULL, &error_abort);
     net_tap_set_fd(s, fd, vnet_hdr, &error_abort);
 
     qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
@@ -712,7 +748,10 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
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
@@ -731,53 +770,24 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
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
-            if (!qemu_set_blocking(vhostfd, false, errp)) {
-                return false;
-            }
-        } else {
-            vhostfd = open("/dev/vhost-net", O_RDWR);
-            if (vhostfd < 0) {
-                error_setg_errno(errp, errno,
-                                 "tap: open vhost char device failed");
-                return false;
-            }
-            if (!qemu_set_blocking(vhostfd, false, errp)) {
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


