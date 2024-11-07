Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C320D3E787
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zeY-00009P-3c; Thu, 07 Nov 2024 05:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8zeT-0008VW-9r
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:22:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1t8zeR-00020v-Jk
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730974926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7fSJvxsikWEVlSLTMUF4hTpiUDgpuukmhQKCTHqmb3A=;
 b=FmumR6aUc711sh2TnBJHIYr1Y5iMQdKtmkQRaJM5PpT6DADU8v9ZBxt32RZMxTjzIBESbg
 B1BQ0JQNOMYHdUDczjO3otNQ3atUUTUzHjV0YHFoJybTl+EEcNGuwCxB3L4zNDxScT1vlM
 Q5A6CJeWVcgeqFVkgRj839d9bZQpUDE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-aU4ddEyLNj6cm-HccNGrfA-1; Thu,
 07 Nov 2024 05:22:02 -0500
X-MC-Unique: aU4ddEyLNj6cm-HccNGrfA-1
X-Mimecast-MFC-AGG-ID: aU4ddEyLNj6cm-HccNGrfA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FD001955EBB
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2024 10:22:02 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F069D195E480; Thu,  7 Nov 2024 10:21:59 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org,
	Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH v6 1/3] qemu-ga: Add 'Null' check and Redefine 'route'
Date: Thu,  7 Nov 2024 12:21:53 +0200
Message-ID: <20241107102155.57573-2-kkostiuk@redhat.com>
In-Reply-To: <20241107102155.57573-1-kkostiuk@redhat.com>
References: <20241107102155.57573-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

sscanf return values are checked and add 'Null' check for
mandatory parameters. And merged redundant route and
networkroute variables.

Signed-off-by: Dehan Meng <demeng@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-linux.c | 83 +++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 39 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 9b1746b24f..eaf53e1c17 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -2102,7 +2102,9 @@ static char *hexToIPAddress(const void *hexValue, int is_ipv6)
         int i;

         for (i = 0; i < 16; i++) {
-            sscanf(&hexStr[i * 2], "%02hhx", &in6.s6_addr[i]);
+            if (sscanf(&hex_str[i * 2], "%02hhx", &in6.s6_addr[i]) != 1) {
+                return NULL;
+            }
         }
         inet_ntop(AF_INET6, &in6, addr, INET6_ADDRSTRLEN);

@@ -2144,9 +2146,9 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
                 firstLine = 0;
                 continue;
             }
-            GuestNetworkRoute *route = NULL;
-            GuestNetworkRoute *networkroute;
             char Iface[IFNAMSIZ];
+            g_autoptr(GuestNetworkRoute) route = g_new0(GuestNetworkRoute, 1);
+
             if (is_ipv6) {
                 char Destination[33], Source[33], NextHop[33];
                 int DesPrefixlen, SrcPrefixlen, Metric, RefCnt, Use, Flags;
@@ -2159,26 +2161,27 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
                     continue;
                 }

-                route = g_new0(GuestNetworkRoute, 1);
-                networkroute = route;
-                networkroute->iface = g_strdup(Iface);
-                networkroute->destination = hexToIPAddress(Destination, 1);
-                networkroute->metric = Metric;
-                networkroute->source = hexToIPAddress(Source, 1);
-                networkroute->desprefixlen = g_strdup_printf(
+                route->iface = g_strdup(Iface);
+                route->destination = hexToIPAddress(Destination, 1);
+                if (route->destination == NULL) {
+                    continue;
+                }
+                route->metric = Metric;
+                route->source = hexToIPAddress(Source, 1);
+                route->desprefixlen = g_strdup_printf(
                     "%d", DesPrefixlen
                 );
-                networkroute->srcprefixlen = g_strdup_printf(
+                route->srcprefixlen = g_strdup_printf(
                     "%d", SrcPrefixlen
                 );
-                networkroute->nexthop = hexToIPAddress(NextHop, 1);
-                networkroute->has_flags = true;
-                networkroute->flags = Flags;
-                networkroute->has_refcnt = true;
-                networkroute->refcnt = RefCnt;
-                networkroute->has_use = true;
-                networkroute->use = Use;
-                networkroute->version = 6;
+                route->nexthop = hexToIPAddress(NextHop, 1);
+                route->has_flags = true;
+                route->flags = Flags;
+                route->has_refcnt = true;
+                route->refcnt = RefCnt;
+                route->has_use = true;
+                route->use = Use;
+                route->version = 6;
             } else {
                 unsigned int Destination, Gateway, Mask, Flags;
                 int RefCnt, Use, Metric, MTU, Window, IRTT;
@@ -2190,29 +2193,31 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
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
+                route->iface = g_strdup(Iface);
+                route->destination = hexToIPAddress(&Destination, 0);
+                if (route->destination == NULL) {
+                    continue;
+                }
+                route->gateway = hexToIPAddress(&Gateway, 0);
+                route->mask = hexToIPAddress(&Mask, 0);
+                route->metric = Metric;
+                route->has_flags = true;
+                route->flags = Flags;
+                route->has_refcnt = true;
+                route->refcnt = RefCnt;
+                route->has_use = true;
+                route->use = Use;
+                route->has_mtu = true;
+                route->mtu = MTU;
+                route->has_window = true;
+                route->window = Window;
+                route->has_irtt = true;
+                route->irtt = IRTT;
+                route->version = 4;
             }

             QAPI_LIST_APPEND(tail, route);
+            route = NULL;
         }

         free(line);
--
2.47.0


