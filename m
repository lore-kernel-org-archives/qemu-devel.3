Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAC3CA0EFA
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 21:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upw6E-0004Um-6T; Sat, 23 Aug 2025 17:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upw6C-0004Td-F9
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 17:48:32 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upw69-000546-MC
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 17:48:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 69500807BA;
 Sun, 24 Aug 2025 00:48:27 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a5d::1:36])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Nmd3dr0GuSw0-9aPBcEQy; Sun, 24 Aug 2025 00:48:26 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755985707;
 bh=qskqYXjap40rdYlZ1SzEptRV2plpL6riqRQlHCIbGiU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=UAXOp5wLYIikFaL3N8x3CWkjURXAqpxNtDpiBMfqGNys80psO2wHV5X1p//bWjWZ3
 nX7ATMU+Yl5CdGNnkFyXnQbzQIMDrpsQPFI35x+yoowK0m6k4YTB1i91UX2Y9Z/xdy
 lz1GaW/ndbpbL6ikMZmO9EMPfyAbUNZwZi4hQkrE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, peterx@redhat.com, mst@redhat.com,
 farosas@suse.de, yc-core@yandex-team.ru
Subject: [RFC 4/7] net/tap: implement interfaces for local migration
Date: Sun, 24 Aug 2025 00:48:18 +0300
Message-ID: <20250823214821.48342-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823214821.48342-1-vsementsov@yandex-team.ru>
References: <20250823214821.48342-1-vsementsov@yandex-team.ru>
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
 net/tap.c         | 129 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 99 insertions(+), 34 deletions(-)

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
index c07af762b0..4d3cdc0662 100644
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
@@ -81,6 +83,7 @@ typedef struct TAPState {
     VHostNetState *vhost_net;
     unsigned host_vnet_hdr_len;
     Notifier exit;
+    bool local_incoming;
 } TAPState;
 
 static void launch_script(const char *setup_script, const char *ifname,
@@ -727,21 +730,25 @@ static int net_tap_open_one(const Netdev *netdev,
         vnet_hdr_required = 0;
     }
 
-    fd = RETRY_ON_EINTR(tap_open(ifname, ifname_sz, &vnet_hdr,
-                                 vnet_hdr_required, mq_required, errp));
-    if (fd < 0) {
-        return -1;
-    }
-
-    if (script &&
-        script[0] != '\0' &&
-        strcmp(script, "no") != 0) {
-        launch_script(script, ifname, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
-            close(fd);
+    if (tap->local_incoming) {
+        fd = -1;
+    } else {
+        fd = RETRY_ON_EINTR(tap_open(ifname, ifname_sz, &vnet_hdr,
+                                     vnet_hdr_required, mq_required, errp));
+        if (fd < 0) {
             return -1;
         }
+
+        if (script &&
+            script[0] != '\0' &&
+            strcmp(script, "no") != 0) {
+            launch_script(script, ifname, fd, &err);
+            if (err) {
+                error_propagate(errp, err);
+                close(fd);
+                return -1;
+            }
+        }
     }
 
     ret = net_tap_fd_init_common(netdev, peer, "tap", name, ifname,
@@ -757,6 +764,42 @@ static int net_tap_open_one(const Netdev *netdev,
 
 #define MAX_TAP_QUEUES 1024
 
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
+    s->exit.notify = tap_exit_notify;
+    qemu_add_exit_notifier(&s->exit);
+
+    return 0;
+}
+
 static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
                                   const char *model, const char *name,
                                   const char *ifname, const char *script,
@@ -764,30 +807,40 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
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
 
@@ -799,9 +852,8 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
     }
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
-    tap = &netdev->u.tap;
 
-    if (tap_set_sndbuf(s->fd, tap, errp) < 0) {
+    if (!local_incoming && tap_set_sndbuf(s->fd, tap, errp) < 0) {
         goto failed;
     }
 
@@ -822,9 +874,11 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
         }
     }
 
-    ret = net_tap_setup_vhost(s, tap, vhostfdname, errp);
-    if (ret < 0) {
-        goto failed;
+    if (!local_incoming) {
+        ret = net_tap_setup_vhost(s, tap, vhostfdname, errp);
+        if (ret < 0) {
+            goto failed;
+        }
     }
 
     return 0;
@@ -1081,3 +1135,10 @@ int tap_disable(NetClientState *nc)
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


