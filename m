Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE184CA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utng5-0005Fz-K8; Wed, 03 Sep 2025 09:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utnfu-00059U-Qh
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:37:23 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utnfp-0004vt-Se
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:37:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 73E6FC01A0;
 Wed, 03 Sep 2025 16:37:15 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BbgRSa3GomI0-nQmFWkf9; Wed, 03 Sep 2025 16:37:14 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756906634;
 bh=o3d7PuXgCNqOyrQ19Zdb3HH/QsFbltz5ybQynB3AbEY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qwshluS2t76eQLe75r/D85uB+rJLThFpnEEd8PWL0Ara3kcKGLycBCspjxFzgoyZl
 v2Iy8sfxj56hkxSrXwmRkwtyR1DKU+VJj4auENG8gbaSrXL4UTIrx3ZfIPPy3hubeV
 NfcsWKG6awT882bywzYiU2Ni7I+dbj/6+Ijx2e3w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, peterx@redhat.com,
 mst@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: [PATCH v2 3/8] net/tap: refactor net_tap_setup_vhost()
Date: Wed,  3 Sep 2025 16:37:00 +0300
Message-ID: <20250903133706.1177633-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
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

1. Move function higher. (we anyway want to split it into two functions,
and change the code a lot, so take an opportunity to get rid of extra
declaration).

2. Split into _set_options() and _init_vhost(): we'll need it later
to implement TAP local migration feature.

3. Split requires to store options somewhere, and to be able to call
_init_vhost() later (from migriation _load() in later commit), store
options in the TAPState.

4. So, take an opportunity to zero-initialize options:
 - be safe (avoid uninitialized options)
 - don't care to initialize half of the options to zero by hand

5. Also, don't worry too much about poll_us: absent option should be
zero-initialized anyway.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 123 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 66 insertions(+), 57 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 7dc8af1e57..a9d955ac5f 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -78,6 +78,7 @@ typedef struct TAPState {
     bool has_ufo;
     bool has_uso;
     bool enabled;
+    VhostNetOptions *vhost_options;
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
     Notifier exit;
@@ -95,8 +96,6 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
                                   const char *downscript,
                                   const char *vhostfdname,
                                   int vnet_hdr, int fd, Error **errp);
-static int net_tap_setup_vhost(TAPState *s, const NetdevTapOptions *tap,
-                               const char *vhostfdname, Error **errp);
 
 static void tap_update_fd_handler(TAPState *s)
 {
@@ -382,6 +381,8 @@ static void tap_cleanup(NetClientState *nc)
         s->vhost_net = NULL;
     }
 
+    g_free(s->vhost_options);
+
     qemu_purge_queued_packets(nc);
 
     if (s->exit.notify) {
@@ -745,6 +746,63 @@ static int net_tap_open_one(const Netdev *netdev,
 
 #define MAX_TAP_QUEUES 1024
 
+static int net_tap_set_vhost_options(TAPState *s, const NetdevTapOptions *tap,
+                                     const char *vhostfdname, Error **errp)
+{
+    int vhostfd;
+    bool vhost_on = tap->has_vhost ? tap->vhost :
+        vhostfdname || (tap->has_vhostforce && tap->vhostforce);
+
+    if (!vhost_on) {
+        return 0;
+    }
+
+    if (vhostfdname) {
+        vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
+        if (vhostfd == -1) {
+            return -1;
+        }
+    } else {
+        vhostfd = open("/dev/vhost-net", O_RDWR);
+        if (vhostfd < 0) {
+            error_setg_errno(errp, errno,
+                             "tap: open vhost char device failed");
+            return -1;
+        }
+    }
+
+    if (!qemu_set_blocking(vhostfd, false, errp)) {
+        return -1;
+    }
+
+    s->vhost_options = g_new(VhostNetOptions, 1);
+    *s->vhost_options = (VhostNetOptions) {
+        .backend_type = VHOST_BACKEND_TYPE_KERNEL,
+        .net_backend = &s->nc,
+        .busyloop_timeout = tap->poll_us,
+        .opaque = (void *)(uintptr_t)vhostfd,
+        .nvqs = 2,
+        .feature_bits = kernel_feature_bits,
+    };
+
+    return 0;
+}
+
+static int net_tap_init_vhost(TAPState *s, Error **errp) {
+    if (!s->vhost_options) {
+        return 0;
+    }
+
+    s->vhost_net = vhost_net_init(s->vhost_options);
+    if (!s->vhost_net) {
+        error_setg(errp,
+                   "vhost-net requested but could not be initialized");
+        return -1;
+    }
+
+    return 0;
+}
+
 static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
                                   const char *model, const char *name,
                                   const char *ifname, const char *script,
@@ -810,7 +868,12 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
         }
     }
 
-    ret = net_tap_setup_vhost(s, tap, vhostfdname, errp);
+    ret = net_tap_set_vhost_options(s, tap, vhostfdname, errp);
+    if (ret < 0) {
+        goto failed;
+    }
+
+    ret = net_tap_init_vhost(s, errp);
     if (ret < 0) {
         goto failed;
     }
@@ -822,60 +885,6 @@ failed:
     return -1;
 }
 
-static int net_tap_setup_vhost(TAPState *s, const NetdevTapOptions *tap,
-                               const char *vhostfdname, Error **errp)
-{
-    if (tap->has_vhost ? tap->vhost :
-        vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
-        VhostNetOptions options;
-        int vhostfd;
-
-        options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
-        options.net_backend = &s->nc;
-        if (tap->has_poll_us) {
-            options.busyloop_timeout = tap->poll_us;
-        } else {
-            options.busyloop_timeout = 0;
-        }
-
-        if (vhostfdname) {
-            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
-            if (vhostfd == -1) {
-                return -1;
-            }
-            if (!qemu_set_blocking(vhostfd, false, errp)) {
-                return -1;
-            }
-        } else {
-            vhostfd = open("/dev/vhost-net", O_RDWR);
-            if (vhostfd < 0) {
-                error_setg_errno(errp, errno,
-                                 "tap: open vhost char device failed");
-                return -1;
-            }
-            if (!qemu_set_blocking(vhostfd, false, errp)) {
-                return -1;
-            }
-        }
-        options.opaque = (void *)(uintptr_t)vhostfd;
-        options.nvqs = 2;
-        options.feature_bits = kernel_feature_bits;
-        options.get_acked_features = NULL;
-        options.save_acked_features = NULL;
-        options.max_tx_queue_size = 0;
-        options.is_vhost_user = false;
-
-        s->vhost_net = vhost_net_init(&options);
-        if (!s->vhost_net) {
-            error_setg(errp,
-                       "vhost-net requested but could not be initialized");
-            return -1;
-        }
-    }
-
-    return 0;
-}
-
 static int net_tap_from_monitor_fd(const Netdev *netdev, NetClientState *peer,
                                    const char *name, const char *vhostfdname,
                                    int *pvnet_hdr, const char *fdname,
-- 
2.48.1


