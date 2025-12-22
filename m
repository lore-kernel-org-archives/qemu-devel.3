Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FB4E674B9
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 14:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXh70-0000YS-Hw; Mon, 22 Dec 2025 09:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1vXh6y-0000Y8-TJ
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 09:42:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1vXh6w-0007l1-Pt
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 09:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766414529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WzwePHdklsGGhwqqgO87iuWqFCy5GPuHXUbtL7FvFls=;
 b=H0AvZgb0zzb6HMLIJxg736J4LIfxGLNE5rvpHN5w0jSIM1sw76dvn4SjgiRSvVZu3iBzNz
 cPqSQ9TTHQq5S7TDPA9VdxuOPqZ9crauXBHShD0xcvn49ALMSG7MNMDId3SsavilyLw+1u
 GW9cqJB1LG6TdU5e0+wkGU2yrSQNzg4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-4LyG7fQwOs6itKxsqCflJA-1; Mon,
 22 Dec 2025 09:40:58 -0500
X-MC-Unique: 4LyG7fQwOs6itKxsqCflJA-1
X-Mimecast-MFC-AGG-ID: 4LyG7fQwOs6itKxsqCflJA_1766414458
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6EBC19560B2
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 14:40:57 +0000 (UTC)
Received: from eashurov-thinkpadx1carbongen12.raanaii.csb (unknown
 [10.50.10.160])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D383180035F; Mon, 22 Dec 2025 14:40:56 +0000 (UTC)
From: Elizabeth Ashurov <eashurov@redhat.com>
To: qemu-devel@nongnu.org
Cc: kkostiuk@redhat.com,
	Elizabeth Ashurov <eashurov@redhat.com>
Subject: [PATCH v3] qga: implement guest-network-get-route for Windows
Date: Mon, 22 Dec 2025 16:40:31 +0200
Message-ID: <20251222144031.3115317-1-eashurov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=1.997 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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
---
 qga/commands-win32.c | 172 +++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json |  11 +--
 2 files changed, 178 insertions(+), 5 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index acc2c11589..577e00dc65 100644
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
index 5791b49dde..89ea5485cc 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1879,7 +1879,8 @@
 ##
 # @GuestNetworkRoute:
 #
-# Route information, currently, only linux supported.
+# Route information.  Supported on Linux (since 9.1) and Windows
+# (since 10.3).
 #
 # @iface: The destination network or host's egress network interface
 #     in the routing table
@@ -1916,7 +1917,7 @@
 #
 # @version: IP version (4 or 6)
 #
-# Since: 9.1
+# Since: 9.1 (Linux only); 10.3 (Windows)
 ##
 { 'struct': 'GuestNetworkRoute',
   'data': {'iface': 'str',
@@ -1936,7 +1937,7 @@
            '*nexthop': 'str',
            'version': 'int'
            },
-  'if': 'CONFIG_LINUX' }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
 
 ##
 # @guest-network-get-route:
@@ -1945,9 +1946,9 @@
 #
 # Returns: List of route info of guest.
 #
-# Since: 9.1
+# Since: 9.1 (Linux only); 10.3 (Windows)
 ##
 { 'command': 'guest-network-get-route',
   'returns': ['GuestNetworkRoute'],
-  'if': 'CONFIG_LINUX'
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
 }
-- 
2.51.0


