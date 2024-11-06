Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DAAD29FBE
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 08:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8bc5-0005Uy-UF; Wed, 06 Nov 2024 03:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t8bc0-0005UG-K1
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 03:42:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t8bbv-0007TY-1Q
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 03:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730882514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HaJWEOS2a9nzhPUG1M6thfJXd91QMcJRIuC7D1z82ds=;
 b=Ivq1tYkDVa93ywVu/yTZbXsWny8d6YjyChuUenr+1wJMJofoenJgMKqO9UQ1R9+5Q3y1iy
 leRE2gbDYC58rwN60mppWG1D9XlhYV91mu9djKltYSYAJlMxLVFFAvssoORWlYHJCgMhbA
 5kBlpXU4gO6dFrQW7V5BZE28/whsVQ0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-tV2k78k_NcGCMcvC5u9s8w-1; Wed,
 06 Nov 2024 03:41:51 -0500
X-MC-Unique: tV2k78k_NcGCMcvC5u9s8w-1
X-Mimecast-MFC-AGG-ID: tV2k78k_NcGCMcvC5u9s8w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1609D19560B6; Wed,  6 Nov 2024 08:41:50 +0000 (UTC)
Received: from fedora.nay.redhat.com (unknown [10.66.57.68])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF75D1955F2F; Wed,  6 Nov 2024 08:41:46 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org, berrange@redhat.com
Subject: [PATCH v5 1/3] qemu-ga: Add 'Null' check and Redefine 'route'
Date: Wed,  6 Nov 2024 16:41:32 +0800
Message-Id: <20241106084134.1133061-2-demeng@redhat.com>
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

sscanf return values are checked and add 'Null' check for
mandatory parameters. And merged redundant route and
networkroute variables.

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 qga/commands-linux.c | 86 +++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 41 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 51d5e3d927..495de74b31 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -2103,7 +2103,9 @@ static char *hexToIPAddress(const void *hexValue, int is_ipv6)
         int i;
 
         for (i = 0; i < 16; i++) {
-            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);
+            if (sscanf(&hex_str[i * 2], "%02hhx", &in6.s6_addr[i]) != 1) {
+                return NULL;
+            }
         }
         inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);
 
@@ -2160,26 +2162,25 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
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
+                g_autoptr(GuestNetworkRoute) route = g_new0(GuestNetworkRoute, 1);
+
+                route->destination = hex_to_ip_address(destination, 1);
+                route->iface = g_strdup(iface);
+                if (route->destination == NULL) {
+                    continue;
+                }
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
             } else {
                 unsigned int Destination, Gateway, Mask, Flags;
                 int RefCnt, Use, Metric, MTU, Window, IRTT;
@@ -2191,26 +2192,29 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
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
+                g_autoptr(GuestNetworkRoute) route = g_new0(GuestNetworkRoute, 1);
+
+                route->destination = hex_to_ip_address(destination, 1);
+                route->iface = g_strdup(iface);
+                if (route->destination == NULL) {
+                    continue;
+                }
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
-- 
2.40.1


