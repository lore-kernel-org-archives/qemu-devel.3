Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873DACDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrVp-0002hV-9W; Thu, 25 Jun 2026 17:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVm-0002QY-Ny
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVj-0003nc-BO
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGOFtTtIm18CbFS62rvFJ8CMdfn3xMDbvbzbBD1NSt0=;
 b=fmK4L7eB6BSyFhtefTs8zW5Mc8BxKCWNypOzLNPDQEq7wiHMUKHq0Kqw7Or1HPWzcAoOau
 c5RQ9/k4qIsly3zjkQDsg1CG8MoSA5q2XL7qrCJyCwxyVoKN5AkUDVn4B/+qf8Ro7OLWlP
 nqsv8/Y/uXKxbsy0uCKfe0kiPTfs9f8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-1Gvbxm8FOQ6BvySCfGWIHw-1; Thu,
 25 Jun 2026 17:21:20 -0400
X-MC-Unique: 1Gvbxm8FOQ6BvySCfGWIHw-1
X-Mimecast-MFC-AGG-ID: 1Gvbxm8FOQ6BvySCfGWIHw_1782422480
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC4F71801373; Thu, 25 Jun 2026 21:21:19 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FAC4195608D; Thu, 25 Jun 2026 21:21:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:21 +0400
Subject: [PATCH v2 20/39] net: add x-query-network QMP command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-20-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=13500;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9kHb/QW02A5Jfqrs46sTFz+867Gxvm3FA6wUvJDlhlE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtdatWBNPM6vfm/JV5yJASucRGhQOLnXUcXI
 XvCKhz4huuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXQAKCRDa6OEJdZac
 5cGrD/4zWlaul8b1CaUiroXC9dq7TC6j7kssnU2zAnAKYqy9yf/bl9jBpWoYaTc9jS0grLq9AhH
 tNbMf2DZ/vYfQyqiNhnVqtv9Z/8oV6I1tbnimGL4+QgzR36Pkcn6DIL4fUDLBsEhVlQiggx/T08
 rIdloQL9qERZCT+FuJ02TXocU7X+QBm/YxtOW3UCJ8rkV09MKo++10tWe7j8VTcDq7M9TIy5q24
 nm5d5hqDTsuvIPxbDQkSbbzARyMUESa2s8hPAQnEXcao+ZfGVBE2iS9hmG3rUaTuVralYojryKA
 XuP+ZkV7GI1Xynb88hHLEzdCwthkVVfuRPHG6Snqq/3iDoHMB0r5xNcfjJrSizEKHWISRwatuVh
 7Qex0WP24wCqXGzdeBQ0T+taoFASN/OxV0GJxDfDzxyD/Ey60cscIVk6uwYSMlT4OKeUl21EaTt
 HFQfAWWJ/YIRJOzFdnHkz2Wz0uXxYzvn2Tbp6upzXjSBRKR921Bi+Raje3lIRosaZR5h0rn390X
 YyyXseBg/1shPkNoKl7MCx2myhWspeoVxhzqRE3ysmbwahh+PAyR29vS9R/Q2sJapZa/dYnfVvs
 XzGyH3zXSQ4AMc1XmxeIEPL55e0s+8tmhm2gLGJlXL/PtZqRmBtFzwjUAN0XDfgBstcKTSW0itV
 iuPwIfM0svzKuCg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/net.json      | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/net/net.h  |   3 +-
 net/hub.h          |   4 +-
 net/hub.c          |  29 +++++++------
 net/net-hmp-cmds.c |  59 +++++++++++++++++++-------
 net/net.c          |  70 +++++++++++++++++++++++-------
 6 files changed, 243 insertions(+), 44 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 08ec7f37946..39db58b03d4 100644
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
+# Since: 11.1
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
+# Since: 11.1
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
+# Since: 11.1
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
+# Since: 11.1
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
+# Since: 11.1
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
+# Since: 11.1
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
diff --git a/include/net/net.h b/include/net/net.h
index 45bc86fc86b..0f0b524df00 100644
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
diff --git a/net/hub.h b/net/hub.h
index ce45f7b399d..cab6b1459b1 100644
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
diff --git a/net/hub.c b/net/hub.c
index ee5881f6d5c..b53a4cc872c 100644
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
diff --git a/net/net-hmp-cmds.c b/net/net-hmp-cmds.c
index 2b24c9e6049..52ac8da770d 100644
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
 
-void hmp_info_network(Monitor *mon, const QDict *qdict)
+static void hmp_print_client_info(Monitor *mon, NetworkClientInfo *ci)
 {
-    NetClientState *nc, *peer;
-    NetClientDriver type;
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
 
-    net_hub_info(mon);
+void hmp_info_network(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    g_autoptr(NetworkInfo) info = qmp_x_query_network(&err);
+    NetHubInfoList *h;
+    NetworkClientInfoList *entry;
 
-    QTAILQ_FOREACH(nc, &net_clients, next) {
-        peer = nc->peer;
-        type = nc->info->type;
+    if (hmp_handle_error(mon, err)) {
+        return;
+    }
 
-        /* Skip if already printed in hub info */
-        if (net_hub_id_for_client(nc, NULL) == 0) {
-            continue;
+    for (h = info->hubs; h; h = h->next) {
+        NetHubPortInfoList *p;
+
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
+
+    for (entry = info->clients; entry; entry = entry->next) {
+        NetworkClientInfo *ci = entry->value;
 
-        if (!peer || type == NET_CLIENT_DRIVER_NIC) {
-            print_net_client(mon, nc);
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
index 2892f1730d1..2bcd229cd9d 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1523,14 +1523,14 @@ void qmp_netdev_del(const char *id, Error **errp)
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
@@ -1540,29 +1540,69 @@ static void netfilter_print_info(Monitor *mon, NetFilterState *nf)
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

-- 
2.54.0


