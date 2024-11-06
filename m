Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DE6D29FB3
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 08:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8bc7-0005Uz-46; Wed, 06 Nov 2024 03:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t8bc2-0005Uj-R4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 03:42:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t8bc1-0007U2-4i
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 03:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730882520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GVXTpK/mspqiOPCZlz7gscB3TB7EwyQVYzQzxIcTB30=;
 b=HHxGHkTJTtw8TohhL2YxfjsXP6ibMlDVWlI3uhzEqiwitDWG86A5SzbKYWcpql/PbqvbKL
 brK+b/ld1/5pWl2AqqTs9UwvJo5lGhcRpGSqo+tJWt2VZ7OPlOGD8vlLawz6hKmrILeu49
 lj0RqNqzIZE7W6ewV0bdgqdC/FN0hnc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-FWSKpz0KNH21jCUCnzOs3w-1; Wed,
 06 Nov 2024 03:41:55 -0500
X-MC-Unique: FWSKpz0KNH21jCUCnzOs3w-1
X-Mimecast-MFC-AGG-ID: FWSKpz0KNH21jCUCnzOs3w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 557941955F43; Wed,  6 Nov 2024 08:41:54 +0000 (UTC)
Received: from fedora.nay.redhat.com (unknown [10.66.57.68])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6E541955F40; Wed,  6 Nov 2024 08:41:50 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org, berrange@redhat.com
Subject: [PATCH v5 2/3] qemu-ga: Optimize var declaration and definition
Date: Wed,  6 Nov 2024 16:41:33 +0800
Message-Id: <20241106084134.1133061-3-demeng@redhat.com>
In-Reply-To: <20241106084134.1133061-1-demeng@redhat.com>
References: <20241106084134.1133061-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
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

Variable declarations moved to the beginning of blocks
Followed the coding style of using snake_case for variable names.
Proper initialization of param 'size_t n' to '0' for

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 qga/commands-linux.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 495de74b31..55c35bfc8f 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -2094,12 +2094,12 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
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
@@ -2111,11 +2111,11 @@ static char *hexToIPAddress(const void *hexValue, int is_ipv6)
 
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
@@ -2126,11 +2126,12 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
     GuestNetworkRouteList *head = NULL, **tail = &head;
     const char *routeFiles[] = {"/proc/net/route", "/proc/net/ipv6_route"};
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
@@ -2147,18 +2148,14 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
                 firstLine = 0;
                 continue;
             }
-            GuestNetworkRoute *route = NULL;
-            GuestNetworkRoute *networkroute;
-            char Iface[IFNAMSIZ];
+            
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
 
@@ -2182,13 +2179,11 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
                 route->use = use;
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
 
-- 
2.40.1


