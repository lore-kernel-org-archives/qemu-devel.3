Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B740E7BD87
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrvrv-0005xp-O2; Mon, 16 Feb 2026 05:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vrvrp-0005wy-7E
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:30:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vrvrj-0006tR-6p
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771237806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WvUaSFB8HP1XCS6dInIhNCPXrB8b8qtH6GVNa9LJnTk=;
 b=e5d26VFEsGLYfS/D96PpTIesMnDwsuqFpjK5kX3eva8Pvg62hiZNKKj2hXUrRTRq0xiQRu
 DCB25Pfvb+2gRH1PZdhwH5rYJrZ/4vL7oISCeDZWOelXRNhUTCF9+2zORVVwgAFRHS/R6T
 kmAJvAaluGR5e0uNry5m8A0PVr8FnF8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-UvMDd7-mMFSPHsHTYaOhDw-1; Mon,
 16 Feb 2026 05:30:01 -0500
X-MC-Unique: UvMDd7-mMFSPHsHTYaOhDw-1
X-Mimecast-MFC-AGG-ID: UvMDd7-mMFSPHsHTYaOhDw_1771237800
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3B4218004BB; Mon, 16 Feb 2026 10:30:00 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.156])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6548B1800465; Mon, 16 Feb 2026 10:29:59 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 3/5] qga: implement guest-network-get-route for Windows
Date: Mon, 16 Feb 2026 12:29:49 +0200
Message-ID: <20260216102951.150381-4-kkostiuk@redhat.com>
In-Reply-To: <20260216102951.150381-1-kkostiuk@redhat.com>
References: <20260216102951.150381-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Elizabeth Ashurov <eashurov@redhat.com>

Add Windows implementation of guest-network-get-route command to provide
network routing information on Windows guests.

Features implemented:
- IPv4 and IPv6 route information retrieval using GetIpForwardTable2
- Human-readable interface names via GetAdaptersAddresses
- Proper route metrics combining route and interface metrics
- MTU information for network interfaces
- Support for destination, gateway, mask, and metric fields for IPv4
- Support for destination, nexthop, and desprefixlen fields for IPv6

Implementation uses modern Windows IP Helper API (GetIpForwardTable2,
GetIfEntry2).

Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251222144031.3115317-1-eashurov@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-win32.c | 172 +++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json |  12 +--
 2 files changed, 178 insertions(+), 6 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 8227480810..d892cf5773 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2592,3 +2592,175 @@ GuestLoadAverage *qmp_guest_get_load(Error **errp)
     ret->load15m = load_avg_15m;
     return ret;
 }
+
+/* Helper function to get interface name with fallbacks */
+static char *get_interface_name(const MIB_IPFORWARD_ROW2 *row,
+                                IP_ADAPTER_ADDRESSES *adptr_addrs)
+{
+    IP_ADAPTER_ADDRESSES *adapter;
+    char *iface_name = NULL;
+
+    if (adptr_addrs) {
+        for (adapter = adptr_addrs; adapter; adapter = adapter->Next) {
+            if (adapter->Luid.Value == row->InterfaceLuid.Value) {
+                iface_name = guest_wctomb_dup(adapter->FriendlyName);
+                break;
+            }
+        }
+    }
+
+    if (!iface_name) {
+        iface_name = g_strdup_printf("if%lu", row->InterfaceIndex);
+    }
+
+    return iface_name;
+}
+
+/* Helper function to fill IPv4 route information */
+static void fill_ipv4_route_info(GuestNetworkRoute *route,
+                                 const MIB_IPFORWARD_ROW2 *row)
+{
+    struct sockaddr_in *addr_in;
+    char addr_str[INET_ADDRSTRLEN];
+
+    addr_in = (struct sockaddr_in *)&row->DestinationPrefix.Prefix;
+    if (inet_ntop(AF_INET, &addr_in->sin_addr, addr_str, INET_ADDRSTRLEN)) {
+        route->destination = g_strdup(addr_str);
+    } else {
+        route->destination = g_strdup("0.0.0.0");
+    }
+
+    if (row->DestinationPrefix.PrefixLength == 0) {
+        route->mask = g_strdup("0.0.0.0");
+    } else {
+        uint32_t mask = htonl(0xFFFFFFFF << (32 -
+                               row->DestinationPrefix.PrefixLength));
+        struct in_addr mask_addr = { .s_addr = mask };
+        route->mask = g_strdup(inet_ntoa(mask_addr));
+    }
+
+    addr_in = (struct sockaddr_in *)&row->NextHop;
+    if (inet_ntop(AF_INET, &addr_in->sin_addr, addr_str, INET_ADDRSTRLEN)) {
+        route->gateway = g_strdup(addr_str);
+    } else {
+        route->gateway = g_strdup("0.0.0.0");
+    }
+
+    route->version = 4;
+}
+
+/* Helper function to fill IPv6 route information */
+static void fill_ipv6_route_info(GuestNetworkRoute *route,
+                                 const MIB_IPFORWARD_ROW2 *row)
+{
+    struct sockaddr_in6 *addr_in6;
+    char addr_str[INET6_ADDRSTRLEN];
+
+    addr_in6 = (struct sockaddr_in6 *)&row->DestinationPrefix.Prefix;
+    if (inet_ntop(AF_INET6, &addr_in6->sin6_addr, addr_str, INET6_ADDRSTRLEN)) {
+        route->destination = g_strdup(addr_str);
+    } else {
+        route->destination = g_strdup("::");
+    }
+
+    addr_in6 = (struct sockaddr_in6 *)&row->NextHop;
+    if (inet_ntop(AF_INET6, &addr_in6->sin6_addr, addr_str, INET6_ADDRSTRLEN)) {
+        route->nexthop = g_strdup(addr_str);
+    } else {
+        route->nexthop = g_strdup("::");
+    }
+
+    route->desprefixlen = g_strdup_printf("%u",
+                                          row->DestinationPrefix.PrefixLength);
+    route->version = 6;
+}
+
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
+{
+    GuestNetworkRouteList *head = NULL, **tail = &head;
+    PMIB_IPFORWARD_TABLE2 pIpForwardTable2;
+    DWORD dwRetVal = 0;
+    DWORD i;
+    PMIB_IPFORWARD_ROW2 row;
+    GuestNetworkRoute *route;
+    IP_ADAPTER_ADDRESSES *adptr_addrs;
+    MIB_IPINTERFACE_ROW ipifrow;
+    MIB_IF_ROW2 ifrow2;
+    Error *local_err = NULL;
+    GHashTable *interface_metric_cache;
+
+    dwRetVal = GetIpForwardTable2(AF_UNSPEC, &pIpForwardTable2);
+    if (dwRetVal != NO_ERROR) {
+        error_setg_win32(errp, dwRetVal, "failed to get IP routes");
+        return NULL;
+    }
+
+    interface_metric_cache = g_hash_table_new_full(g_str_hash, g_str_equal,
+                                                   g_free, NULL);
+    adptr_addrs = guest_get_adapters_addresses(&local_err);
+    if (local_err) {
+        error_free(local_err);
+        adptr_addrs = NULL;
+    }
+
+    for (i = 0; i < pIpForwardTable2->NumEntries; i++) {
+        row = &pIpForwardTable2->Table[i];
+
+        if (row->DestinationPrefix.Prefix.si_family == AF_INET) {
+            route = g_new0(GuestNetworkRoute, 1);
+            fill_ipv4_route_info(route, row);
+        } else if (row->DestinationPrefix.Prefix.si_family == AF_INET6) {
+            route = g_new0(GuestNetworkRoute, 1);
+            fill_ipv6_route_info(route, row);
+        } else {
+            continue;
+        }
+
+        route->iface = get_interface_name(row, adptr_addrs);
+
+        /*
+         * Get interface metric for combined route metric calculation.
+         * Windows calculates effective route metric as route + interface metric.
+         * This matches the values displayed by Windows 'route print' command.
+         * See:
+         * https://learn.microsoft.com/en-us/windows/win32/api/netioapi/ns-netioapi-mib_ipforward_row2
+         */
+        gchar *luid_key = g_strdup_printf("%" G_GUINT64_FORMAT,
+                                          row->InterfaceLuid.Value);
+        gpointer cached_metric = g_hash_table_lookup(interface_metric_cache,
+                                                     luid_key);
+
+        if (cached_metric) {
+            route->metric = (int)row->Metric + GPOINTER_TO_INT(cached_metric);
+            g_free(luid_key);
+        } else {
+            memset(&ipifrow, 0, sizeof(ipifrow));
+            InitializeIpInterfaceEntry(&ipifrow);
+            ipifrow.InterfaceLuid = row->InterfaceLuid;
+            ipifrow.Family = row->DestinationPrefix.Prefix.si_family;
+            if (GetIpInterfaceEntry(&ipifrow) == NO_ERROR) {
+                g_hash_table_insert(interface_metric_cache, luid_key,
+                                   GINT_TO_POINTER(ipifrow.Metric));
+                route->metric = (int)row->Metric + (int)ipifrow.Metric;
+            } else {
+                route->metric = (int)row->Metric;
+                g_free(luid_key);
+            }
+        }
+
+        memset(&ifrow2, 0, sizeof(ifrow2));
+        ifrow2.InterfaceLuid = row->InterfaceLuid;
+        if (GetIfEntry2(&ifrow2) == NO_ERROR) {
+            route->has_mtu = true;
+            route->mtu = (int)ifrow2.Mtu;
+        }
+
+        QAPI_LIST_APPEND(tail, route);
+        route = NULL;
+    }
+
+    FreeMibTable(pIpForwardTable2);
+    g_free(adptr_addrs);
+    g_hash_table_destroy(interface_metric_cache);
+    return head;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 8162d888bb..6d5c0630e8 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1879,7 +1879,8 @@
 ##
 # @GuestNetworkRoute:
 #
-# Route information, currently, only linux supported.
+# Route information. Supported on Linux (since 9.1) and Windows
+# (since 11.0).
 #
 # @iface: The destination network or host's egress network interface in the routing table
 #
@@ -1913,8 +1914,7 @@
 #
 # @version: IP version (4 or 6)
 #
-# Since: 9.1
-
+# Since: 9.1 (Linux only); 11.0 (Windows)
 ##
 { 'struct': 'GuestNetworkRoute',
   'data': {'iface': 'str',
@@ -1934,7 +1934,7 @@
            '*nexthop': 'str',
            'version': 'int'
            },
-  'if': 'CONFIG_LINUX' }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }

 ##
 # @guest-network-get-route:
@@ -1943,9 +1943,9 @@
 #
 # Returns: List of route info of guest.
 #
-# Since: 9.1
+# Since: 9.1 (Linux only); 11.0 (Windows)
 ##
 { 'command': 'guest-network-get-route',
   'returns': ['GuestNetworkRoute'],
-  'if': 'CONFIG_LINUX'
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
 }
--
2.52.0


