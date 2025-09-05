Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CD5CA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 13:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuWqG-0001gR-TN; Fri, 05 Sep 2025 09:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uuWqB-0001eQ-Sj
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 09:50:59 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uuWq2-0006XH-Ri
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 09:50:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id B4E80C1090;
 Fri, 05 Sep 2025 16:50:44 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id foiXcl3Gh8c0-XkdiTCsX; Fri, 05 Sep 2025 16:50:44 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757080244;
 bh=dec+tS+435t4X7GDxrUR1YNWlwcVjqv8PqWOjR5ue+w=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=awZXidPnAL91P+3bnFe1U/4fAYNS3VRtFYF9h2JiFBS0SWOSX/1YlhOuCVTZ8gnft
 rqo0eeifDwAeAgik0D31IFkMjEwT21jpeF6yEmd+Eo2L0qTm3CpMwUZGKkix6f5Fj2
 vtxablYtjXcrSKzl6XBx7CHhvX//j6QuVwn3l05M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, peterx@redhat.com,
 mst@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: [PATCH v3 3/9] net/tap: refactor net_tap_setup_vhost()
Date: Fri,  5 Sep 2025 16:50:33 +0300
Message-ID: <20250905135039.2202924-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
 net/tap.c | 124 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 67 insertions(+), 57 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 4f3512a831..cf7f704a92 100644
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
@@ -334,6 +333,8 @@ static void tap_cleanup(NetClientState *nc)
         s->vhost_net = NULL;
     }
 
+    g_free(s->vhost_options);
+
     qemu_purge_queued_packets(nc);
 
     if (s->exit.notify) {
@@ -697,6 +698,64 @@ static int net_tap_open_one(const Netdev *netdev,
 
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
+static int net_tap_init_vhost(TAPState *s, Error **errp)
+{
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
@@ -762,7 +821,12 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
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
@@ -774,60 +838,6 @@ failed:
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


