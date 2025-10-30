Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5662CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEWK1-0001Pe-2m; Thu, 30 Oct 2025 13:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWJY-0001BF-My
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:57 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWJJ-0008Lt-CO
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:55 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id AC77F80807;
 Thu, 30 Oct 2025 20:19:18 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GJjc0O0FA0U0-7OvusgEp; Thu, 30 Oct 2025 20:19:18 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761844758;
 bh=ZzTQMVYEjB0S4uk/EFQKwFsi3FnRTfXbCtOvRoIniJc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=yLKJ5G+842nbH8wADiz0erpFutkgBV+B4UGkB4WhNNPrnFzV+k008hZJvDgs9ZoQc
 Zr+SG+BWuuDYBNXVYe7tCnQUk6Jt5XhdI7e5sRz7HrZWsYuYE36wDM52eSJGocYqDs
 oZAlZtYnN1Rlq3+RnG92Wa0iDyVhb0wgCGcTJFOQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com
Subject: [PATCH v9 1/9] net: introduce backend-connect concept
Date: Thu, 30 Oct 2025 20:19:06 +0300
Message-ID: <20251030171915.726441-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030171915.726441-1-vsementsov@yandex-team.ru>
References: <20251030171915.726441-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

To implement in future backend-transfer migration for virtio-net,
i.e. we are going to migrate TAP fd and some other TAP properties,
we'll need a possibility to postpone opening TAP device until the
point where we are know what user wants: open TAP device, or wait
from fd coming in migration stream.

So, new interface is here: since this commit, net backends may
postpone some initialization actions (like opening or connecting)
up to call of .backend_connect() handler.

Currently, for all net drivers, .backend_connect() is called
during set of netdev property, so drivers continue to work with
already "connected" backends.

Still, we add a possibility for drivers to use new
DEFINE_NIC_PROPERTIES_NO_CONNECT() instead of
DEFINE_NIC_PROPERTIES(). This way, driver take responsibility
to call net_backend_connect() in its own. So, in future we'll
use it in vritio-net, to finally implement backand-transfer
migration fot TAP backend.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/core/qdev-properties-system.c    | 29 +++++++++++++++++++++++++++--
 include/hw/qdev-properties-system.h |  2 ++
 include/net/net.h                   |  6 ++++++
 net/net.c                           | 15 +++++++++++++++
 4 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 13cc91680b..0b2668a45f 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -415,8 +415,8 @@ static void get_netdev(Object *obj, Visitor *v, const char *name,
     g_free(p);
 }
 
-static void set_netdev(Object *obj, Visitor *v, const char *name,
-                       void *opaque, Error **errp)
+static void do_set_netdev(Object *obj, Visitor *v, const char *name,
+                          void *opaque, bool connect, Error **errp)
 {
     const Property *prop = opaque;
     NICPeers *peers_ptr = object_field_prop_ptr(obj, prop);
@@ -463,6 +463,12 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
             }
         }
 
+        if (connect) {
+            if (!net_backend_connect(peers[i], errp)) {
+                goto out;
+            }
+        }
+
         ncs[i] = peers[i];
         ncs[i]->queue_index = i;
     }
@@ -474,6 +480,18 @@ out:
     g_free(str);
 }
 
+static void set_netdev(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    return do_set_netdev(obj, v, name, opaque, true, errp);
+}
+
+static void set_netdev_no_connect(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    return do_set_netdev(obj, v, name, opaque, false, errp);
+}
+
 const PropertyInfo qdev_prop_netdev = {
     .type  = "str",
     .description = "ID of a netdev to use as a backend",
@@ -481,6 +499,13 @@ const PropertyInfo qdev_prop_netdev = {
     .set   = set_netdev,
 };
 
+const PropertyInfo qdev_prop_netdev_no_connect = {
+    .type  = "str",
+    .description = "ID of a netdev to use as a backend",
+    .get   = get_netdev,
+    .set   = set_netdev_no_connect,
+};
+
 
 /* --- audiodev --- */
 static void get_audiodev(Object *obj, Visitor *v, const char* name,
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 5c6cc5eae8..f41b5edadc 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -41,6 +41,8 @@ extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
     DEFINE_PROP(_n, _s, _f, qdev_prop_chr, CharFrontend)
 #define DEFINE_PROP_NETDEV(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_netdev, NICPeers)
+#define DEFINE_PROP_NETDEV_NO_CONNECT(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_netdev_no_connect, NICPeers)
 #define DEFINE_PROP_DRIVE(_n, _s, _f) \
     DEFINE_PROP(_n, _s, _f, qdev_prop_drive, BlockBackend *)
 #define DEFINE_PROP_DRIVE_IOTHREAD(_n, _s, _f) \
diff --git a/include/net/net.h b/include/net/net.h
index 72b476ee1d..3aa67db57c 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -51,6 +51,9 @@ typedef struct NetOffloads {
     DEFINE_PROP_MACADDR("mac",   _state, _conf.macaddr),                \
     DEFINE_PROP_NETDEV("netdev", _state, _conf.peers)
 
+#define DEFINE_NIC_PROPERTIES_NO_CONNECT(_state, _conf)                 \
+    DEFINE_PROP_MACADDR("mac",   _state, _conf.macaddr),                \
+    DEFINE_PROP_NETDEV_NO_CONNECT("netdev", _state, _conf.peers)
 
 /* Net clients */
 
@@ -82,6 +85,7 @@ typedef void (NetAnnounce)(NetClientState *);
 typedef bool (SetSteeringEBPF)(NetClientState *, int);
 typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
 typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
+typedef bool (NetBackendConnect)(NetClientState *, Error **);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -110,6 +114,7 @@ typedef struct NetClientInfo {
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
     GetVHostNet *get_vhost_net;
+    NetBackendConnect *backend_connect;
 } NetClientInfo;
 
 struct NetClientState {
@@ -322,6 +327,7 @@ void net_cleanup(void);
 void hmp_host_net_add(Monitor *mon, const QDict *qdict);
 void hmp_host_net_remove(Monitor *mon, const QDict *qdict);
 void netdev_add(QemuOpts *opts, Error **errp);
+bool net_backend_connect(NetClientState *nc, Error **errp);
 
 int net_hub_id_for_client(NetClientState *nc, int *id);
 
diff --git a/net/net.c b/net/net.c
index 27e0d27807..4fc6b1d0a6 100644
--- a/net/net.c
+++ b/net/net.c
@@ -2162,3 +2162,18 @@ int net_fill_rstate(SocketReadState *rs, const uint8_t *buf, int size)
     assert(size == 0);
     return 0;
 }
+
+bool net_backend_connect(NetClientState *nc, Error **errp)
+{
+    if (!nc->info->backend_connect) {
+        /*
+         * For most net backends from net/, the connection with
+         * some external entity is don in init function, defined
+         * in net_client_init_fun[] list. They don't have separate
+         * .backend_connect.
+         */
+        return true;
+    }
+
+    return nc->info->backend_connect(nc, errp);
+}
-- 
2.48.1


