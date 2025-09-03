Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D9ECA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utng6-0005H2-6l; Wed, 03 Sep 2025 09:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utnft-000584-4P
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:37:21 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utnfq-0004wC-5C
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:37:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id BFF5CC01A7;
 Wed, 03 Sep 2025 16:37:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BbgRSa3GomI0-H5C7rK5S; Wed, 03 Sep 2025 16:37:16 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756906636;
 bh=3KYcrL9COF6I/pEql3juewALPYmRgt15qbCAujjYteQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=rih6eT3xn7hslh1z/c5HYOIruhoTgvBOzNn0ZPYLVBq15idHB7Qph2faLJ+C4tRaS
 Hi2r4+QyW09Wp4xaIWAOkENDeJgw1/ZcxG4BULJOIaHgjtppmtLb4yIP9C36DRwZD7
 4a8Z8ZEaxVUhei6/C6jIt5dYSJEvsSBhSdtlq2RI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, peterx@redhat.com,
 mst@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, berrange@redhat.com
Subject: [PATCH v2 5/8] net/tap: implement interfaces for local migration
Date: Wed,  3 Sep 2025 16:37:02 +0300
Message-ID: <20250903133706.1177633-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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
 net/tap.c         | 136 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 119 insertions(+), 21 deletions(-)

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
index a9d955ac5f..499db756ea 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -35,6 +35,8 @@
 #include "net/eth.h"
 #include "net/net.h"
 #include "clients.h"
+#include "migration/migration.h"
+#include "migration/qemu-file.h"
 #include "monitor/monitor.h"
 #include "system/system.h"
 #include "qapi/error.h"
@@ -82,6 +84,7 @@ typedef struct TAPState {
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
     Notifier exit;
+    bool local_incoming;
 } TAPState;
 
 static void launch_script(const char *setup_script, const char *ifname,
@@ -803,6 +806,40 @@ static int net_tap_init_vhost(TAPState *s, Error **errp) {
     return 0;
 }
 
+int tap_save(NetClientState *nc, QEMUFile *f)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    qemu_file_put_fd(f, s->fd);
+    qemu_put_byte(f, s->using_vnet_hdr);
+    qemu_put_byte(f, s->has_ufo);
+    qemu_put_byte(f, s->has_uso);
+    qemu_put_byte(f, s->enabled);
+    qemu_put_be32(f, s->host_vnet_hdr_len);
+
+    return 0;
+}
+
+int tap_load(NetClientState *nc, QEMUFile *f)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+
+    s->fd = qemu_file_get_fd(f);
+    if (s->fd < 0) {
+        return -1;
+    }
+
+    s->using_vnet_hdr = qemu_get_byte(f);
+    s->has_ufo = qemu_get_byte(f);
+    s->has_uso = qemu_get_byte(f);
+    s->enabled = qemu_get_byte(f);
+    qemu_get_be32s(f, &s->host_vnet_hdr_len);
+
+    tap_read_poll(s, true);
+
+    return net_tap_init_vhost(s, NULL);
+}
+
 static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
                                   const char *model, const char *name,
                                   const char *ifname, const char *script,
@@ -810,30 +847,40 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
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
 
@@ -845,9 +892,8 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
     }
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
-    tap = &netdev->u.tap;
 
-    if (tap_set_sndbuf(s->fd, tap, errp) < 0) {
+    if (!local_incoming && tap_set_sndbuf(s->fd, tap, errp) < 0) {
         goto failed;
     }
 
@@ -873,9 +919,11 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
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
@@ -942,6 +990,38 @@ static int net_tap_open(const Netdev *netdev,
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
@@ -1030,6 +1110,13 @@ int net_init_tap(const Netdev *netdev, const char *name,
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
@@ -1078,3 +1165,10 @@ int tap_disable(NetClientState *nc)
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


