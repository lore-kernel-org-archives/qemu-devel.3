Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968FDCED635
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 09:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sySmr-0005FV-3w; Wed, 09 Oct 2024 05:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sySmp-0005ET-QW
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sySmn-0005IW-BN
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 05:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728465312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BDjLUVADw5Tg3f8vJdt5xhh1xd+qsXVhXbC+O0Tzl40=;
 b=fzhSDQHX9q6RottQYSL3r5xDE3KVRdvOKA2Q2bf2lo77zkfjLvo+htFLw1UGTSJqqsYQ/n
 sTEjli/DHM2XTyZiCa+Ej4RxFzQGPT8eCK9oQ2iC1EKBHg2NWWBC9PVKHeTl7BuS4KlNrL
 ylVL3XSda7/9bvmVwdlsNyKYzqPp4+Y=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-bCALua73Mf2mwKla-gUdUg-1; Wed,
 09 Oct 2024 05:14:05 -0400
X-MC-Unique: bCALua73Mf2mwKla-gUdUg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45C4C19560AD; Wed,  9 Oct 2024 09:14:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.160])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8D27300018D; Wed,  9 Oct 2024 09:14:00 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com,
	kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH v1 1/1] qemu-ga: Fix some potential issues find by coverity
Date: Wed,  9 Oct 2024 17:13:53 +0800
Message-Id: <20241009091353.17419-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Key changes:
1. Proper initialization of n to 0 for getline to function correctly.
2. Avoiding freeing line prematurely. It's now only freed at the end of the function.
3. sscanf return values are checked to ensure correct parsing.
4. Variable declarations moved to the beginning of blocks.
5. Followed the coding style of using snake_case for variable names.
6. Merged redundant route and networkroute variables.

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 qga/commands-linux.c | 139 ++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 74 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 51d5e3d927..72a9548a06 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -2094,26 +2094,28 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
     return head;
 }
 
-static char *hexToIPAddress(const void *hexValue, int is_ipv6)
+static char *hex_to_ip_address(const void *hex_value, int is_ipv6)
 {
     if (is_ipv6) {
         char addr[INET6_ADDRSTRLEN];
         struct in6_addr in6;
-        const char *hexStr = (const char *)hexValue;
+        const char *hex_str = (const char *)hex_value;
         int i;
 
         for (i = 0; i < 16; i++) {
-            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);
+            if (sscanf(&hex_str[i * 2], "%02hhx", &in6.s6_addr[i]) != 1) {
+                return NULL;
+            }
         }
         inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);
 
         return g_strdup(addr);
     } else {
-        unsigned int hexInt = *(unsigned int *)hexValue;
-        unsigned int byte1 = (hexInt >> 24) & 0xFF;
-        unsigned int byte2 = (hexInt >> 16) & 0xFF;
-        unsigned int byte3 = (hexInt >> 8) & 0xFF;
-        unsigned int byte4 = hexInt & 0xFF;
+        unsigned int hex_int = *(unsigned int *)hex_value;
+        unsigned int byte1 = (hex_int >> 24) & 0xFF;
+        unsigned int byte2 = (hex_int >> 16) & 0xFF;
+        unsigned int byte3 = (hex_int >> 8) & 0xFF;
+        unsigned int byte4 = hex_int & 0xFF;
 
         return g_strdup_printf("%u.%u.%u.%u", byte4, byte3, byte2, byte1);
     }
@@ -2122,103 +2124,92 @@ static char *hexToIPAddress(const void *hexValue, int is_ipv6)
 GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
 {
     GuestNetworkRouteList *head = NULL, **tail = &head;
-    const char *routeFiles[] = {"/proc/net/route", "/proc/net/ipv6_route"};
+    const char *route_files[] = {"/proc/net/route", "/proc/net/ipv6_route"};
     FILE *fp;
-    size_t n;
+    size_t n = 0;
     char *line = NULL;
-    int firstLine;
-    int is_ipv6;
     int i;
 
     for (i = 0; i < 2; i++) {
-        firstLine = 1;
-        is_ipv6 = (i == 1);
-        fp = fopen(routeFiles[i], "r");
+        int first_line = 1;
+        int is_ipv6 = (i == 1);
+        fp = fopen(route_files[i], "r");
         if (fp == NULL) {
-            error_setg_errno(errp, errno, "open(\"%s\")", routeFiles[i]);
-            free(line);
+            error_setg_errno(errp, errno, "open(\"%s\")", route_files[i]);
             continue;
         }
 
         while (getline(&line, &n, fp) != -1) {
-            if (firstLine && !is_ipv6) {
-                firstLine = 0;
+            if (first_line && !is_ipv6) {
+                first_line = 0;
                 continue;
             }
-            GuestNetworkRoute *route = NULL;
-            GuestNetworkRoute *networkroute;
-            char Iface[IFNAMSIZ];
+
+            GuestNetworkRoute *route = g_new0(GuestNetworkRoute, 1);
+            char iface[IFNAMSIZ];
+
             if (is_ipv6) {
-                char Destination[33], Source[33], NextHop[33];
-                int DesPrefixlen, SrcPrefixlen, Metric, RefCnt, Use, Flags;
+                char destination[33], source[33], next_hop[33];
+                int des_prefixlen, src_prefixlen, metric, refcnt, use, flags;
 
-                /* Parse the line and extract the values */
                 if (sscanf(line, "%32s %x %32s %x %32s %x %x %x %x %s",
-                           Destination, &DesPrefixlen, Source,
-                           &SrcPrefixlen, NextHop, &Metric, &RefCnt,
-                           &Use, &Flags, Iface) != 10) {
+                           destination, &des_prefixlen, source,
+                           &src_prefixlen, next_hop, &metric, &refcnt,
+                           &use, &flags, iface) != 10) {
                     continue;
                 }
 
-                route = g_new0(GuestNetworkRoute, 1);
-                networkroute = route;
-                networkroute->iface = g_strdup(Iface);
-                networkroute->destination = hexToIPAddress(Destination, 1);
-                networkroute->metric = Metric;
-                networkroute->source = hexToIPAddress(Source, 1);
-                networkroute->desprefixlen = g_strdup_printf(
-                    "%d", DesPrefixlen
-                );
-                networkroute->srcprefixlen = g_strdup_printf(
-                    "%d", SrcPrefixlen
-                );
-                networkroute->nexthop = hexToIPAddress(NextHop, 1);
-                networkroute->has_flags = true;
-                networkroute->flags = Flags;
-                networkroute->has_refcnt = true;
-                networkroute->refcnt = RefCnt;
-                networkroute->has_use = true;
-                networkroute->use = Use;
-                networkroute->version = 6;
+                route->iface = g_strdup(iface);
+                route->destination = hex_to_ip_address(destination, 1);
+                route->source = hex_to_ip_address(source, 1);
+                route->nexthop = hex_to_ip_address(next_hop, 1);
+                route->desprefixlen = g_strdup_printf("%d", des_prefixlen);
+                route->srcprefixlen = g_strdup_printf("%d", src_prefixlen);
+                route->metric = metric;
+                route->has_flags = true;
+                route->flags = flags;
+                route->has_refcnt = true;
+                route->refcnt = refcnt;
+                route->has_use = true;
+                route->use = use;
+                route->version = 6;
+
             } else {
-                unsigned int Destination, Gateway, Mask, Flags;
-                int RefCnt, Use, Metric, MTU, Window, IRTT;
+                unsigned int destination, gateway, mask, flags;
+                int refcnt, use, metric, mtu, window, irtt;
 
-                /* Parse the line and extract the values */
                 if (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d",
-                           Iface, &Destination, &Gateway, &Flags, &RefCnt,
-                           &Use, &Metric, &Mask, &MTU, &Window, &IRTT) != 11) {
+                           iface, &destination, &gateway, &flags, &refcnt,
+                           &use, &metric, &mask, &mtu, &window, &irtt) != 11) {
                     continue;
                 }
 
-                route = g_new0(GuestNetworkRoute, 1);
-                networkroute = route;
-                networkroute->iface = g_strdup(Iface);
-                networkroute->destination = hexToIPAddress(&Destination, 0);
-                networkroute->gateway = hexToIPAddress(&Gateway, 0);
-                networkroute->mask = hexToIPAddress(&Mask, 0);
-                networkroute->metric = Metric;
-                networkroute->has_flags = true;
-                networkroute->flags = Flags;
-                networkroute->has_refcnt = true;
-                networkroute->refcnt = RefCnt;
-                networkroute->has_use = true;
-                networkroute->use = Use;
-                networkroute->has_mtu = true;
-                networkroute->mtu = MTU;
-                networkroute->has_window = true;
-                networkroute->window = Window;
-                networkroute->has_irtt = true;
-                networkroute->irtt = IRTT;
-                networkroute->version = 4;
+                route->iface = g_strdup(iface);
+                route->destination = hex_to_ip_address(&destination, 0);
+                route->gateway = hex_to_ip_address(&gateway, 0);
+                route->mask = hex_to_ip_address(&mask, 0);
+                route->metric = metric;
+                route->has_flags = true;
+                route->flags = flags;
+                route->has_refcnt = true;
+                route->refcnt = refcnt;
+                route->has_use = true;
+                route->use = use;
+                route->has_mtu = true;
+                route->mtu = mtu;
+                route->has_window = true;
+                route->window = window;
+                route->has_irtt = true;
+                route->irtt = irtt;
+                route->version = 4;
             }
 
             QAPI_LIST_APPEND(tail, route);
         }
 
-        free(line);
         fclose(fp);
     }
 
+    free(line);
     return head;
 }
-- 
2.40.1


