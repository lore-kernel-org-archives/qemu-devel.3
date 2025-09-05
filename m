Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B01CA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 13:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuWqD-0001fD-UZ; Fri, 05 Sep 2025 09:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uuWqC-0001dU-2E
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 09:51:00 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uuWq3-0006XN-9N
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 09:50:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 04A9FC1093;
 Fri, 05 Sep 2025 16:50:46 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id foiXcl3Gh8c0-2g50U4kW; Fri, 05 Sep 2025 16:50:45 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757080245;
 bh=9BRBRN4FugsQSiwFKEkHemuvQEzD3v1rNDoVEakXDW8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=DurQy7uM9nCHn7vczOe7dFX5he/8OWdeKzd/m2NFIW34csUeUu3Tho1DJApdJArTC
 1AAlraf1Mb5NKVF4Z7+T4PW+7yRccIKzgvKHdjlT3rmpABxdW9b8gWoyMMeQbjYayE
 stzXw4iXe45ySRZ3jPIrt6GWevAiWDxFF+l8kBFo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, peterx@redhat.com,
 mst@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: [PATCH v3 5/9] net/tap: implement interfaces for local migration
Date: Fri,  5 Sep 2025 16:50:35 +0300
Message-ID: <20250905135039.2202924-6-vsementsov@yandex-team.ru>
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

Handle local-incoming option:

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/net/tap.h |   4 ++
 net/tap.c         | 139 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 122 insertions(+), 21 deletions(-)

diff --git a/include/net/tap.h b/include/net/tap.h
index 6f34f13eae..3ef2e2dbae 100644
--- a/include/net/tap.h
+++ b/include/net/tap.h
@@ -30,7 +30,11 @@
 
 int tap_enable(NetClientState *nc);
 int tap_disable(NetClientState *nc);
+bool tap_local_incoming(NetClientState *nc);
 
 int tap_get_fd(NetClientState *nc);
 
+int tap_load(NetClientState *nc, QEMUFile *f);
+int tap_save(NetClientState *nc, QEMUFile *f);
+
 #endif /* QEMU_NET_TAP_H */
diff --git a/net/tap.c b/net/tap.c
index cf7f704a92..0fd7a7671c 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -35,6 +35,7 @@
 #include "net/eth.h"
 #include "net/net.h"
 #include "clients.h"
+#include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "system/system.h"
 #include "qapi/error.h"
@@ -44,6 +45,7 @@
 #include "qemu/sockets.h"
 #include "hw/virtio/vhost.h"
 #include "trace.h"
+#include "system/runstate.h"
 
 #include "net/tap.h"
 
@@ -82,6 +84,7 @@ typedef struct TAPState {
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
     Notifier exit;
+    bool local_incoming;
 } TAPState;
 
 static void launch_script(const char *setup_script, const char *ifname,
@@ -756,6 +759,43 @@ static int net_tap_init_vhost(TAPState *s, Error **errp)
     return 0;
 }
 
+static int tap_post_load(void *opaque, int version_id)
+{
+    TAPState *s = opaque;
+
+    tap_read_poll(s, true);
+
+    return net_tap_init_vhost(s, NULL);
+}
+
+static const VMStateDescription vmstate_tap = {
+    .name = "virtio-net-device",
+    .post_load = tap_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_FD(fd, TAPState),
+        VMSTATE_BOOL(using_vnet_hdr, TAPState),
+        VMSTATE_BOOL(has_ufo, TAPState),
+        VMSTATE_BOOL(has_uso, TAPState),
+        VMSTATE_BOOL(enabled, TAPState),
+        VMSTATE_UINT32(host_vnet_hdr_len, TAPState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+int tap_save(NetClientState *nc, QEMUFile *f)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    return vmstate_save_state(f, &vmstate_tap, s, 0);
+}
+
+int tap_load(NetClientState *nc, QEMUFile *f)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    return vmstate_load_state(f, &vmstate_tap, s, 0);
+}
+
 static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
                                   const char *model, const char *name,
                                   const char *ifname, const char *script,
@@ -763,30 +803,40 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
                                   const char *vhostfdname,
                                   int vnet_hdr, int fd, Error **errp)
 {
-    const NetdevTapOptions *tap;
+    const NetdevTapOptions *tap = NULL;
     int ret;
     NetClientState *nc;
     TAPState *s;
+    bool local_incoming = false;
+
+    if (netdev->type == NET_CLIENT_DRIVER_TAP) {
+        tap = &netdev->u.tap;
+        local_incoming = tap->local_incoming;
+    }
 
     nc = qemu_new_net_client(&net_tap_info, peer, model, name);
 
     s = DO_UPCAST(TAPState, nc, nc);
-
-    s->fd = fd;
-    s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
-    s->using_vnet_hdr = false;
-    s->has_ufo = tap_probe_has_ufo(s->fd);
-    s->has_uso = tap_probe_has_uso(s->fd);
-    s->enabled = true;
-    tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
-    /*
-     * Make sure host header length is set correctly in tap:
-     * it might have been modified by another instance of qemu.
-     */
-    if (vnet_hdr) {
-        tap_fd_set_vnet_hdr_len(s->fd, s->host_vnet_hdr_len);
+    s->local_incoming = local_incoming;
+
+    if (!local_incoming) {
+        s->fd = fd;
+        s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
+        s->using_vnet_hdr = false;
+        s->has_ufo = tap_probe_has_ufo(s->fd);
+        s->has_uso = tap_probe_has_uso(s->fd);
+        s->enabled = true;
+        tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
+        /*
+         * Make sure host header length is set correctly in tap:
+         * it might have been modified by another instance of qemu.
+         */
+        if (vnet_hdr) {
+            tap_fd_set_vnet_hdr_len(s->fd, s->host_vnet_hdr_len);
+        }
+        tap_read_poll(s, true);
     }
-    tap_read_poll(s, true);
+
     s->vhost_net = NULL;
     s->exit.notify = NULL;
 
@@ -798,9 +848,8 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
     }
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
-    tap = &netdev->u.tap;
 
-    if (tap_set_sndbuf(s->fd, tap, errp) < 0) {
+    if (!local_incoming && tap_set_sndbuf(s->fd, tap, errp) < 0) {
         goto failed;
     }
 
@@ -826,9 +875,11 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
         goto failed;
     }
 
-    ret = net_tap_init_vhost(s, errp);
-    if (ret < 0) {
-        goto failed;
+    if (!local_incoming) {
+        ret = net_tap_init_vhost(s, errp);
+        if (ret < 0) {
+            goto failed;
+        }
     }
 
     return 0;
@@ -895,6 +946,38 @@ static int net_tap_open(const Netdev *netdev,
     return 0;
 }
 
+static int net_init_local_incoming(const Netdev *netdev,
+                                   const char *name,
+                                   NetClientState *peer,
+                                   Error **errp)
+{
+    const NetdevTapOptions *tap = &netdev->u.tap;
+    const char *downscript = tap->downscript;
+    int queues = tap->has_queues ? tap->queues : 1;
+    g_autofree char *default_downscript = NULL;
+    int i, ret;
+
+    assert(netdev->type == NET_CLIENT_DRIVER_TAP);
+    assert(!tap->script);
+
+    if (!downscript) {
+        downscript = default_downscript =
+                             get_relocated_path(DEFAULT_NETWORK_DOWN_SCRIPT);
+    }
+
+    for (i = 0; i < queues; i++) {
+        ret = net_tap_fd_init_common(netdev, peer, "tap", name,
+                                     tap->ifname ?: "",
+                                     "no", downscript,
+                                     tap->vhostfd, -1, -1, errp);
+        if (ret < 0) {
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
 static int net_init_tap_fds(const Netdev *netdev, const char *name,
                             NetClientState *peer, Error **errp)
 {
@@ -983,6 +1066,13 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         return net_init_bridge(netdev, name, peer, errp);
+    } else if (tap->local_incoming) {
+        if (tap->script) {
+            error_setg(errp, "script= is invalid with local-incoming");
+            return -1;
+        }
+
+        return net_init_local_incoming(netdev, name, peer, errp);
     }
 
     if (tap->vhostfds) {
@@ -1031,3 +1121,10 @@ int tap_disable(NetClientState *nc)
         return ret;
     }
 }
+
+bool tap_local_incoming(NetClientState *nc)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    return s->local_incoming && runstate_check(RUN_STATE_INMIGRATE);
+}
-- 
2.48.1


