Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA01C61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvLX-0000Sm-8P; Fri, 28 Aug 2026 08:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvLT-0000Fd-Fz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:06:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvLR-0002qr-4C
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yt0VpsKg2fDyDNIGjlirNTDAOLTutkEjSjhvl7URPQE=;
 b=NweXSnQwytGMnpXefyFoFc1brLGNYLEcs8lrpFfGvjtm11n9tCl0B3+uMVO79voNPW84fF
 jgrps+oU3sJpXnxOO/WkSkaJaieQW+uYKVIn5o4Z7H5s4iA8T/krHPU6pm5flaH2k02HcD
 J8S9WFyj8KfOWblCqv9q6cnvTlcGuDs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-dDcWbKh8Psi-i_S6FgBWPA-1; Fri,
 28 Aug 2026 08:06:00 -0400
X-MC-Unique: dDcWbKh8Psi-i_S6FgBWPA-1
X-Mimecast-MFC-AGG-ID: dDcWbKh8Psi-i_S6FgBWPA_1787918759
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AC641886244; Fri, 28 Aug 2026 12:05:59 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5818A3000223; Fri, 28 Aug 2026 12:05:57 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:16 +0400
Subject: [PATCH v5 19/50] net: add x-query-network QMP command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-19-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=13535;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wQjIiCAccqRA4CBdG6zZlIj68jDJ3H6JF4Z3VjKkri8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk4LxAGhW4loNi7g2ePBiMIanhAuJP5c6hYZ
 qEDRe8AWFuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OAAKCRDa6OEJdZac
 5d1lD/4lJpfKlnDQrZHR9lkaepcg+onvxNE/wqQAnSrSBpQEJjq/LgcIEIBon939gGB7DLeiRm6
 l+8gNoXpgquyJRCYIozXGRKqsK7fvKKeSlPo8zc7Tz9BRGmN985ujPWogxeCMqo9XHbtPuW0QEo
 bpE/TyEuBTa9fhVaBQcY4HMWhviEHyEZJiNnp7W4yV6Um3Fvx9+d1h84LJCHF17mBqtjmR3UjPj
 hDbgkRSFWaQ3pgjYGFug+E1v3Yd3al4+IwTurfLiu6CIqAPR4bid9MMFRwtUDjYW20Lq0XnRb1Q
 uZGanuTx7MfdJ8rVtXhVNi69+fxRo8AyOoCgh91UMjr8mwFBAPxCVSNc6tH/MDBCUajWeK4yQ6Q
 /KUR1Z8cx0qhXLNsk1zTlFryWfC2s6XcbVh7iSrmfV9dwYpGc83lqQkdjdwTSnv1W0B86EiwlVz
 gTjonY93Mkf5N5Y+i+JrKd/3jFNaYGyf+D6Jz2U/tFtE/0m9lR26fBDGlnYGl4jZLeveELl1mNz
 N6WefEemt9H6ZH+vwiRssb34Rl8+rUndokUyzjMUUkbB4FCvS7JZNBWdBlQdezKl+1BHdWfGz7x
 cxQHT3VUgCwXtTnFiHIL+s0/DAnCyC9KH+mInn6aKO945Uz0AvnMxwdUhDj3aG0DQEsbp5d6Ca0
 uXKPxsbCj6OwWMQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

Add a structured x-query-network QMP command that returns network
configuration as a NetworkInfo struct with pre-grouped hub information
and a flat list of non-hub clients. Each hub includes its ports with
inlined peer client info, and each client includes attached netfilter
details.

Refactor hmp_info_network() to consume only the QMP result instead of
directly accessing internal net_clients state. This decouples HMP from
internal data structures, making it possible to remove HMP support
without losing programmatic network introspection.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/net/net.h  |   3 +-
 net/hub.c          |  29 +++++++------
 net/hub.h          |   4 +-
 net/net-hmp-cmds.c |  57 +++++++++++++++++++------
 net/net.c          |  70 +++++++++++++++++++++++-------
 qapi/net.json      | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 242 insertions(+), 43 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 9edfacf827ca..a7c49c543783 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -274,7 +274,6 @@ DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
 void qemu_create_nic_bus_devices(BusState *bus, const char *parent_type,
                                  const char *default_model,
                                  const char *alias, const char *alias_target);
-void print_net_client(Monitor *mon, NetClientState *nc);
 void net_socket_rs_init(SocketReadState *rs,
                         SocketReadStateFinalize *finalize,
                         bool vnet_hdr);
@@ -325,6 +324,8 @@ void netdev_add(QemuOpts *opts, Error **errp);
 
 int net_hub_id_for_client(NetClientState *nc, int *id);
 
+NetworkClientInfo *net_client_info(NetClientState *nc);
+
 #define DEFAULT_NETWORK_SCRIPT CONFIG_SYSCONFDIR "/qemu-ifup"
 #define DEFAULT_NETWORK_DOWN_SCRIPT CONFIG_SYSCONFDIR "/qemu-ifdown"
 #define DEFAULT_BRIDGE_HELPER CONFIG_QEMU_HELPERDIR "/qemu-bridge-helper"
diff --git a/net/hub.c b/net/hub.c
index ee5881f6d5cb..b53a4cc872ca 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "monitor/monitor.h"
+#include "qapi/util.h"
 #include "net/net.h"
 #include "clients.h"
 #include "hub.h"
@@ -199,26 +199,31 @@ NetClientState *net_hub_add_port(int hub_id, const char *name,
     return &port->nc;
 }
 
-/**
- * Print hub configuration
- */
-void net_hub_info(Monitor *mon)
+NetHubInfoList *net_hub_query_info(void)
 {
+    NetHubInfoList *head = NULL, **tail = &head;
     NetHub *hub;
-    NetHubPort *port;
 
     QLIST_FOREACH(hub, &hubs, next) {
-        monitor_printf(mon, "hub %d\n", hub->id);
+        NetHubInfo *hi = g_new0(NetHubInfo, 1);
+        NetHubPortInfoList **ptail = &hi->ports;
+        NetHubPort *port;
+
+        hi->id = hub->id;
+
         QLIST_FOREACH(port, &hub->ports, next) {
-            monitor_printf(mon, " \\ %s", port->nc.name);
+            NetHubPortInfo *pi = g_new0(NetHubPortInfo, 1);
+            pi->name = g_strdup(port->nc.name);
             if (port->nc.peer) {
-                monitor_printf(mon, ": ");
-                print_net_client(mon, port->nc.peer);
-            } else {
-                monitor_printf(mon, "\n");
+                pi->peer = net_client_info(port->nc.peer);
             }
+            QAPI_LIST_APPEND(ptail, pi);
         }
+
+        QAPI_LIST_APPEND(tail, hi);
     }
+
+    return head;
 }
 
 /**
diff --git a/net/hub.h b/net/hub.h
index ce45f7b399d3..cab6b1459b1a 100644
--- a/net/hub.h
+++ b/net/hub.h
@@ -15,10 +15,12 @@
 #ifndef NET_HUB_H
 #define NET_HUB_H
 
+#include "qapi/qapi-types-net.h"
+
 NetClientState *net_hub_add_port(int hub_id, const char *name,
                                  NetClientState *hubpeer);
-void net_hub_info(Monitor *mon);
 void net_hub_check_clients(void);
 bool net_hub_flush(NetClientState *nc);
+NetHubInfoList *net_hub_query_info(void);
 
 #endif /* NET_HUB_H */
diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
index 2b24c9e60498..52ac8da770d9 100644
--- a/net/net-hmp-cmds.c
+++ b/net/net-hmp-cmds.c
@@ -19,37 +19,66 @@
 #include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "net/net.h"
-#include "net/hub.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/qapi-commands-net.h"
 #include "qapi/qapi-visit-net.h"
+#include "qapi/error.h"
 #include "qobject/qdict.h"
 #include "qemu/config-file.h"
 #include "qemu/help_option.h"
 #include "qemu/option.h"
 
+static void hmp_print_client_info(Monitor *mon, NetworkClientInfo *ci)
+{
+    NetFilterInfoList *f;
+
+    monitor_printf(mon, "%s: index=%" PRIu32 ",type=%s,%s\n",
+                   ci->name, ci->queue_index,
+                   NetClientDriver_str(ci->type), ci->info_str);
+    if (ci->filters) {
+        monitor_printf(mon, "filters:\n");
+        for (f = ci->filters; f; f = f->next) {
+            monitor_printf(mon, "  - %s: type=%s%s%s\n",
+                           f->value->name, f->value->type,
+                           f->value->info[0] ? "," : "", f->value->info);
+        }
+    }
+}
+
 void hmp_info_network(Monitor *mon, const QDict *qdict)
 {
-    NetClientState *nc, *peer;
-    NetClientDriver type;
+    Error *err = NULL;
+    g_autoptr(NetworkInfo) info = qmp_x_query_network(&err);
+    NetHubInfoList *h;
+    NetworkClientInfoList *entry;
 
-    net_hub_info(mon);
+    if (hmp_handle_error(mon, err)) {
+        return;
+    }
 
-    QTAILQ_FOREACH(nc, &net_clients, next) {
-        peer = nc->peer;
-        type = nc->info->type;
+    for (h = info->hubs; h; h = h->next) {
+        NetHubPortInfoList *p;
 
-        /* Skip if already printed in hub info */
-        if (net_hub_id_for_client(nc, NULL) == 0) {
-            continue;
+        monitor_printf(mon, "hub %d\n", (int)h->value->id);
+        for (p = h->value->ports; p; p = p->next) {
+            if (p->value->peer) {
+                monitor_printf(mon, " \\ %s: ", p->value->name);
+                hmp_print_client_info(mon, p->value->peer);
+            } else {
+                monitor_printf(mon, " \\ %s\n", p->value->name);
+            }
         }
+    }
 
-        if (!peer || type == NET_CLIENT_DRIVER_NIC) {
-            print_net_client(mon, nc);
+    for (entry = info->clients; entry; entry = entry->next) {
+        NetworkClientInfo *ci = entry->value;
+
+        if (!ci->peer || ci->type == NET_CLIENT_DRIVER_NIC) {
+            hmp_print_client_info(mon, ci);
         } /* else it's a netdev connected to a NIC, printed with the NIC */
-        if (peer && type == NET_CLIENT_DRIVER_NIC) {
+        if (ci->peer && ci->type == NET_CLIENT_DRIVER_NIC) {
             monitor_printf(mon, " \\ ");
-            print_net_client(mon, peer);
+            hmp_print_client_info(mon, ci->peer);
         }
     }
 }
diff --git a/net/net.c b/net/net.c
index 0a30579ca4a7..1161183e183d 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1525,14 +1525,14 @@ void qmp_netdev_del(const char *id, Error **errp)
     }
 }
 
-static void netfilter_print_info(Monitor *mon, NetFilterState *nf)
+static char *netfilter_get_info_str(NetFilterState *nf)
 {
     char *str;
     ObjectProperty *prop;
     ObjectPropertyIterator iter;
     Visitor *v;
+    GString *buf = g_string_new(NULL);
 
-    /* generate info str */
     object_property_iter_init(&iter, OBJECT(nf));
     while ((prop = object_property_iter_next(&iter))) {
         if (!strcmp(prop->name, "type")) {
@@ -1542,29 +1542,69 @@ static void netfilter_print_info(Monitor *mon, NetFilterState *nf)
         object_property_get(OBJECT(nf), prop->name, v, NULL);
         visit_complete(v, &str);
         visit_free(v);
-        monitor_printf(mon, ",%s=%s", prop->name, str);
+        if (buf->len > 0) {
+            g_string_append_c(buf, ',');
+        }
+        g_string_append_printf(buf, "%s=%s", prop->name, str);
         g_free(str);
     }
-    monitor_printf(mon, "\n");
+
+    return g_string_free(buf, false);
 }
 
-void print_net_client(Monitor *mon, NetClientState *nc)
+static NetworkClientInfo *net_client_info_no_peer(NetClientState *nc)
 {
+    NetworkClientInfo *info = g_new0(NetworkClientInfo, 1);
     NetFilterState *nf;
 
-    monitor_printf(mon, "%s: index=%d,type=%s,%s\n", nc->name,
-                   nc->queue_index,
-                   NetClientDriver_str(nc->info->type),
-                   nc->info_str);
+    info->name = g_strdup(nc->name);
+    info->queue_index = nc->queue_index;
+    info->type = nc->info->type;
+    info->info_str = g_strdup(nc->info_str);
+
     if (!QTAILQ_EMPTY(&nc->filters)) {
-        monitor_printf(mon, "filters:\n");
+        NetFilterInfoList **ftail = &info->filters;
+        QTAILQ_FOREACH(nf, &nc->filters, next) {
+            NetFilterInfo *fi = g_new0(NetFilterInfo, 1);
+            fi->name = g_strdup(
+                object_get_canonical_path_component(OBJECT(nf)));
+            fi->type = g_strdup(object_get_typename(OBJECT(nf)));
+            fi->info = netfilter_get_info_str(nf);
+            QAPI_LIST_APPEND(ftail, fi);
+        }
     }
-    QTAILQ_FOREACH(nf, &nc->filters, next) {
-        monitor_printf(mon, "  - %s: type=%s",
-                       object_get_canonical_path_component(OBJECT(nf)),
-                       object_get_typename(OBJECT(nf)));
-        netfilter_print_info(mon, nf);
+
+    return info;
+}
+
+NetworkClientInfo *net_client_info(NetClientState *nc)
+{
+    NetworkClientInfo *info = net_client_info_no_peer(nc);
+
+    if (nc->peer) {
+        info->peer = net_client_info_no_peer(nc->peer);
     }
+
+    return info;
+}
+
+NetworkInfo *qmp_x_query_network(Error **errp)
+{
+    NetworkInfo *info = g_new0(NetworkInfo, 1);
+    NetworkClientInfoList **tail = &info->clients;
+    NetClientState *nc;
+
+    info->hubs = net_hub_query_info();
+
+    QTAILQ_FOREACH(nc, &net_clients, next) {
+        /* Skip if already gathered in hub info */
+        if (net_hub_id_for_client(nc, NULL) == 0) {
+            continue;
+        }
+        QAPI_LIST_APPEND(tail, net_client_info(nc));
+    }
+
+    return info;
 }
 
 RxFilterInfoList *qmp_query_rx_filter(const char *name, Error **errp)
diff --git a/qapi/net.json b/qapi/net.json
index 5d3342fba23b..85c78710fe88 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1305,3 +1305,125 @@
   'returns': ['UsernetInfo'],
   'if': 'CONFIG_SLIRP',
   'features': [ 'unstable' ] }
+
+##
+# @NetFilterInfo:
+#
+# Information about a netfilter attached to a network client.
+#
+# @name: filter object name (QOM path component)
+#
+# @type: QOM type name (e.g. "filter-mirror")
+#
+# @info: filter properties as comma-separated key=value pairs
+#        (excluding @type)
+#
+# Since: 11.2
+##
+{ 'struct': 'NetFilterInfo',
+  'data': {
+    'name': 'str',
+    'type': 'str',
+    'info': 'str' } }
+
+##
+# @NetworkClientInfo:
+#
+# Information about a network client.
+#
+# @name: unique network client identifier
+#
+# @queue-index: index of this queue (0 for single-queue clients)
+#
+# @type: network client driver type
+#
+# @info-str: driver-specific formatted information string (e.g.
+#            "model=e1000,macaddr=52:54:00:12:34:56")
+#
+# @peer: the connected peer client (always a leaf; the peer's own
+#        peer field is never populated)
+#
+# @filters: attached netfilters
+#
+# Since: 11.2
+##
+{ 'struct': 'NetworkClientInfo',
+  'data': {
+    'name': 'str',
+    'queue-index': 'uint32',
+    'type': 'NetClientDriver',
+    'info-str': 'str',
+    '*peer': 'NetworkClientInfo',
+    'filters': ['NetFilterInfo'] } }
+
+##
+# @NetHubPortInfo:
+#
+# Information about a hub port.
+#
+# @name: hub port identifier
+#
+# @peer: the network client connected through this port
+#
+# Since: 11.2
+##
+{ 'struct': 'NetHubPortInfo',
+  'data': {
+    'name': 'str',
+    '*peer': 'NetworkClientInfo' } }
+
+##
+# @NetHubInfo:
+#
+# Information about a network hub.
+#
+# @id: hub identifier
+#
+# @ports: list of ports on this hub
+#
+# Since: 11.2
+##
+{ 'struct': 'NetHubInfo',
+  'data': {
+    'id': 'int',
+    'ports': ['NetHubPortInfo'] } }
+
+##
+# @NetworkInfo:
+#
+# Information about the network configuration.
+#
+# @hubs: network hubs and their ports
+#
+# @clients: network clients not associated with a hub
+#
+# Since: 11.2
+##
+{ 'struct': 'NetworkInfo',
+  'data': {
+    'hubs': ['NetHubInfo'],
+    'clients': ['NetworkClientInfo'] } }
+
+##
+# @x-query-network:
+#
+# Query the network configuration including hubs and clients.
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: @NetworkInfo describing hubs and clients.
+#
+# Since: 11.2
+#
+# .. qmp-example::
+#
+#     -> { "execute": "x-query-network" }
+#     <- { "return": { "clients": [ { "name": "st0",
+#                      "queue-index": 0, "type": "stream",
+#                      "info-str": "listening" } ] } }
+##
+{ 'command': 'x-query-network',
+  'returns': 'NetworkInfo',
+  'features': [ 'unstable' ] }

-- 
2.55.0.543.g5ebe2ebe4ea8


