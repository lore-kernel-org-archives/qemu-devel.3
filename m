Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6002ED2C55F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3FuZ-00026f-5w; Tue, 22 Oct 2024 10:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t3Fu0-0001cN-33
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:30:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t3Fty-0007Gm-HQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729607425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHowBr7x7UYYST4buL7npbj0tciDcR1xEyoNXjo5oMw=;
 b=fbf47yzQ8xdBKdrYERhoDkhNP7pYUl/3n+Cijqk/smk4fgLxZjLs+VLESGSv4arJxSBeZi
 gqlGlrN/NbUoaAVBEbA1L7hfKVL6VEwuJiO9fzlrnlH319k6pNuZeUsFuxpKQ+HzMpWoGE
 0bCGKIWyjG1SPpcOWg3VZ7zICiTy6Jk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-VLStvPG2MGy-eN0QbTWThg-1; Tue,
 22 Oct 2024 10:30:23 -0400
X-MC-Unique: VLStvPG2MGy-eN0QbTWThg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A58171954196; Tue, 22 Oct 2024 14:30:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.80])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1BEE19560AE; Tue, 22 Oct 2024 14:30:18 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org, berrange@redhat.com
Subject: [PATCH v4 5/5] qemu-ga:  Replace g_new0() with g_autoptr()
Date: Tue, 22 Oct 2024 22:29:48 +0800
Message-Id: <20241022142948.531325-6-demeng@redhat.com>
In-Reply-To: <20241022142948.531325-1-demeng@redhat.com>
References: <20241022142948.531325-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
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

Replace g_new0() with g_autoptr() to simplify the code

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 qga/commands-linux.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 9fb31956b4..ee4f345938 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -2158,15 +2158,13 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
                     continue;
                 }
 
-                GuestNetworkRoute *route = g_new0(GuestNetworkRoute, 1);
+                g_autoptr(GuestNetworkRoute) route = g_new0(GuestNetworkRoute, 1);
 
                 route->destination = hex_to_ip_address(destination, 1);
-                if (route->destination == NULL) {
-                    g_free(route);
+                route->iface = g_strdup(iface);
+                if (route->destination == NULL  || route->iface == NULL) {
                     continue;
                 }
-                route->iface = g_strdup(iface);
-                route->destination = hex_to_ip_address(destination, 1);
                 route->source = hex_to_ip_address(source, 1);
                 route->nexthop = hex_to_ip_address(next_hop, 1);
                 route->desprefixlen = g_strdup_printf("%d", des_prefixlen);
@@ -2188,15 +2186,13 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
                     continue;
                 }
 
-                GuestNetworkRoute *route = g_new0(GuestNetworkRoute, 1);
+                g_autoptr(GuestNetworkRoute) route = g_new0(GuestNetworkRoute, 1);
 
                 route->destination = hex_to_ip_address(destination, 1);
-                if (route->destination == NULL) {
-                    g_free(route);
+                route->iface = g_strdup(iface);
+                if (route->destination == NULL  || route->iface == NULL) {
                     continue;
                 }
-                route->iface = g_strdup(iface);
-                route->destination = hex_to_ip_address(&destination, 0);
                 route->gateway = hex_to_ip_address(&gateway, 0);
                 route->mask = hex_to_ip_address(&mask, 0);
                 route->metric = metric;
-- 
2.40.1


