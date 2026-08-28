Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C668C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Px-0007MX-Q1; Fri, 28 Aug 2026 16:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Pv-0007LT-UQ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Pt-0008Pa-Fx
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVv6I3EZZZj47/5Fs3nxoceopjIyEJE+Ae9MSTveG7I=;
 b=Xi6tBJyY2uYWI6Xxhy2qNxFWQeK90y6WjV3RN+veIPwAJeOHEQJwiJQ21xwvX5Fy5VrHOp
 iZ/VZ5IqslI+0wIXYPxCRt6w+SU/76uW38EvqY3V1/O8aFyLHN8r81KzteyZ0XJxXCZ0aV
 h5sE6H1WXQgpDDaRXLpfgwSSKQoxjhE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-390-YuYM4eGjPiqou07Zy-J7Jw-1; Fri,
 28 Aug 2026 16:43:08 -0400
X-MC-Unique: YuYM4eGjPiqou07Zy-J7Jw-1
X-Mimecast-MFC-AGG-ID: YuYM4eGjPiqou07Zy-J7Jw_1787949787
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B412F18A3C04; Fri, 28 Aug 2026 20:43:07 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5B7C1955F75; Fri, 28 Aug 2026 20:43:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:58 +0400
Subject: [GIT PULL 19/50] net: add x-query-network QMP command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-19-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Jason Wang <jasowangio@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=13601;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=DbpXld2HO8z+5kerREPDBzzqqNoJfLjnpB1QXcMe3nE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUhMBk45KFwELfSlynD819XjTsypC1mvMnh
 fFjr+4aRlKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5c1xD/wNuFM33zNmtHnSFg3c1NjTmkyDxOx3aOPBHTFouIcb/HFtJWWCzLybeKRCMOyQ7eZfMwQ
 sp4kis3bJyvN8qZFAZzoAGivJAH5Ll4ny6gbOBIPG9RCMifSfLazBmcohOTbDHh941CHF+Szgnm
 B6bGH/ln3zfbgCRG1RFAWYb9xbBDGWcbmk2/I2F9X+lZycIj7Fw5ZVWcy7ODgy9NgVrU1xPBD9W
 rUBRXtAK3vxXAsvRlPT/EXU4BwoK1VEyXFJSixU8JcqqwFz5+IV4A6rcOen4lGoaXFBk1Z9BxeV
 4nYBurLWKc0C0sRBNvX5D3zCHjdjorrC9tLvyxdDNxvA4woOct4CfoAx2Ea5eYM47fh+JtIR1aH
 EQhoX2S+L1sTy1bxkMPHK4HoLtXI+1dn0l1qfi6L12LIHGdOLn8wKAOJQ1U/0OjzsmdCfDKojHf
 PYfFmzacN8IrgFqMbG9q3Nk8Q0M2+hDA2r9FfSUiUi/8/wPtgIxpFt7Cm/qvKzyRn4p2esAFIas
 n7zjj1lXnN3nnuHekCowjEE39wbh49CoJuT8EoPqA3EC9pIUJImsd40R5nUq2VaqkbFpnKxOTay
 MYTwYEO5bALG6LI5sW1B3XLGRZ4mp86hhls5lE9njjXNGO/pcoqs85Fohy026oqNe4uVJbZAds3
 jaBpiuXKvOWPN2A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Message-ID: <20260828-qemu-no-hmp-v5-19-9227de146347@redhat.com>
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


