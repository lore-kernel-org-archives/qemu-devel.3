Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CCAD44D78
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zw3-0002sV-Cn; Thu, 07 Nov 2024 05:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8zw2-0002ro-0s
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:40:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8zw0-0005NJ-7z
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730976015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39G4SSB5PxAQODMuXUFB7erKJz/7b5wQAqPXDkj0Xos=;
 b=gvYw1sJX+P+gmMjyT7ZOsa6qEpItrydnlLtazfbnOFACzYyTZy5CA1dP0fHeUYAPE7Yx2R
 ek4NnQvnWLZjxpAttMBBjsY/qpBh+hIeF8AinKN5KjWy6Hdt2G4vcRhGV6wUsEpVc8aebt
 H/9stypK0gn40yjQ3z66yEITCk7Am+s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-3le4iSbcP86eD-ZTkks8-A-1; Thu,
 07 Nov 2024 05:40:12 -0500
X-MC-Unique: 3le4iSbcP86eD-ZTkks8-A-1
X-Mimecast-MFC-AGG-ID: 3le4iSbcP86eD-ZTkks8-A
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED6441955F34; Thu,  7 Nov 2024 10:40:10 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 517781956054; Thu,  7 Nov 2024 10:40:09 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/3] qemu-ga: Optimize var declaration and definition
Date: Thu,  7 Nov 2024 12:40:00 +0200
Message-ID: <20241107104001.66039-3-kkostiuk@redhat.com>
In-Reply-To: <20241107104001.66039-1-kkostiuk@redhat.com>
References: <20241107104001.66039-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Dehan Meng <demeng@redhat.com>

Variable declarations moved to the beginning of blocks
Followed the coding style of using snake_case for variable names.
Proper initialization of param 'size_t n' to '0' for

Signed-off-by: Dehan Meng <demeng@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Message-ID: <20241107102155.57573-3-kkostiuk@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-linux.c | 92 ++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 50 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index eaf53e1c17..b0704ad423 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -2093,12 +2093,12 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
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
@@ -2110,11 +2110,11 @@ static char *hexToIPAddress(const void *hexValue, int is_ipv6)

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
@@ -2123,20 +2123,21 @@ static char *hexToIPAddress(const void *hexValue, int is_ipv6)
 GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
 {
     GuestNetworkRouteList *head = NULL, **tail = &head;
-    const char *routeFiles[] = {"/proc/net/route", "/proc/net/ipv6_route"};
+    const char *route_files[] = {"/proc/net/route", "/proc/net/ipv6_route"};
     FILE *fp;
-    size_t n;
+    size_t n = 0;
     char *line = NULL;
     int firstLine;
     int is_ipv6;
     int i;
+    char iface[IFNAMSIZ];

     for (i = 0; i < 2; i++) {
         firstLine = 1;
         is_ipv6 = (i == 1);
-        fp = fopen(routeFiles[i], "r");
+        fp = fopen(route_files[i], "r");
         if (fp == NULL) {
-            error_setg_errno(errp, errno, "open(\"%s\")", routeFiles[i]);
+            error_setg_errno(errp, errno, "open(\"%s\")", route_files[i]);
             free(line);
             continue;
         }
@@ -2146,73 +2147,64 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
                 firstLine = 0;
                 continue;
             }
-            char Iface[IFNAMSIZ];
             g_autoptr(GuestNetworkRoute) route = g_new0(GuestNetworkRoute, 1);

             if (is_ipv6) {
-                char Destination[33], Source[33], NextHop[33];
-                int DesPrefixlen, SrcPrefixlen, Metric, RefCnt, Use, Flags;
-
-                /* Parse the line and extract the values */
+                char destination[33], source[33], next_hop[33];
+                int des_prefixlen, src_prefixlen, metric, refcnt, use, flags;
                 if (sscanf(line, "%32s %x %32s %x %32s %x %x %x %x %s",
-                           Destination, &DesPrefixlen, Source,
-                           &SrcPrefixlen, NextHop, &Metric, &RefCnt,
-                           &Use, &Flags, Iface) != 10) {
+                           destination, &des_prefixlen, source,
+                           &src_prefixlen, next_hop, &metric, &refcnt,
+                           &use, &flags, iface) != 10) {
                     continue;
                 }

-                route->iface = g_strdup(Iface);
-                route->destination = hexToIPAddress(Destination, 1);
+                route->destination = hex_to_ip_address(destination, 1);
                 if (route->destination == NULL) {
                     continue;
                 }
-                route->metric = Metric;
-                route->source = hexToIPAddress(Source, 1);
-                route->desprefixlen = g_strdup_printf(
-                    "%d", DesPrefixlen
-                );
-                route->srcprefixlen = g_strdup_printf(
-                    "%d", SrcPrefixlen
-                );
-                route->nexthop = hexToIPAddress(NextHop, 1);
+                route->iface = g_strdup(iface);
+                route->source = hex_to_ip_address(source, 1);
+                route->nexthop = hex_to_ip_address(next_hop, 1);
+                route->desprefixlen = g_strdup_printf("%d", des_prefixlen);
+                route->srcprefixlen = g_strdup_printf("%d", src_prefixlen);
+                route->metric = metric;
                 route->has_flags = true;
-                route->flags = Flags;
+                route->flags = flags;
                 route->has_refcnt = true;
-                route->refcnt = RefCnt;
+                route->refcnt = refcnt;
                 route->has_use = true;
-                route->use = Use;
+                route->use = use;
                 route->version = 6;
             } else {
-                unsigned int Destination, Gateway, Mask, Flags;
-                int RefCnt, Use, Metric, MTU, Window, IRTT;
-
-                /* Parse the line and extract the values */
+                unsigned int destination, gateway, mask, flags;
+                int refcnt, use, metric, mtu, window, irtt;
                 if (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d",
-                           Iface, &Destination, &Gateway, &Flags, &RefCnt,
-                           &Use, &Metric, &Mask, &MTU, &Window, &IRTT) != 11) {
+                           iface, &destination, &gateway, &flags, &refcnt,
+                           &use, &metric, &mask, &mtu, &window, &irtt) != 11) {
                     continue;
                 }

-                route->iface = g_strdup(Iface);
-                route->destination = hexToIPAddress(&Destination, 0);
+                route->destination = hex_to_ip_address(&destination, 0);
                 if (route->destination == NULL) {
                     continue;
                 }
-                route->gateway = hexToIPAddress(&Gateway, 0);
-                route->mask = hexToIPAddress(&Mask, 0);
-                route->metric = Metric;
+                route->iface = g_strdup(iface);
+                route->gateway = hex_to_ip_address(&gateway, 0);
+                route->mask = hex_to_ip_address(&mask, 0);
+                route->metric = metric;
                 route->has_flags = true;
-                route->flags = Flags;
+                route->flags = flags;
                 route->has_refcnt = true;
-                route->refcnt = RefCnt;
+                route->refcnt = refcnt;
                 route->has_use = true;
-                route->use = Use;
+                route->use = use;
                 route->has_mtu = true;
-                route->mtu = MTU;
+                route->mtu = mtu;
                 route->has_window = true;
-                route->window = Window;
+                route->window = window;
                 route->has_irtt = true;
-                route->irtt = IRTT;
+                route->irtt = irtt;
                 route->version = 4;
             }

--
2.47.0


