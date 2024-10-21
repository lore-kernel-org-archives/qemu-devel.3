Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1113D15D90
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 13:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2sTU-0006EW-Jt; Mon, 21 Oct 2024 09:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t2sTL-0006DI-Hv
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1t2sTK-0000iF-64
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 09:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729517361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=34PkQkzS2fJKjA97jCvEOEfq09+BKhcwhQ4YHpj/pVU=;
 b=ac2r2mN+8dQo3puxa18fo0ebwj0G3DkTJQ/ctUFERogI2/OtldFNmy0RMnwEKR8Yg179h5
 G+7j/0CWXdP/OcwDC78KJwGwUR0Vijf6ky3TzhMsPwhLsP/sK5HXwRmhhdo8zKi/vgu4gH
 Assqq7MREw86dliAgUoQcYLmQVeTlyg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-YJhCWXwrP5mM0P1ztRFuZw-1; Mon,
 21 Oct 2024 09:29:20 -0400
X-MC-Unique: YJhCWXwrP5mM0P1ztRFuZw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F24011955EAD; Mon, 21 Oct 2024 13:29:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.80])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D40719560AA; Mon, 21 Oct 2024 13:29:14 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com, kkostiuk@redhat.com, michael.roth@amd.com,
 peter.maydell@linaro.org, berrange@redhat.com
Subject: [PATCH v3 1/4] qemu-ga: 'Null' check for mandatory parameters
Date: Mon, 21 Oct 2024 21:28:36 +0800
Message-Id: <20241021132839.463255-7-demeng@redhat.com>
In-Reply-To: <20241021132839.463255-1-demeng@redhat.com>
References: <20241021132839.463255-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
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
mandatory parameters.

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 qga/commands-linux.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 51d5e3d927..f0e9cdd27c 100644
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
 
@@ -2164,6 +2166,10 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
                 networkroute = route;
                 networkroute->iface = g_strdup(Iface);
                 networkroute->destination = hexToIPAddress(Destination, 1);
+                if (networkroute->destination == NULL) {
+                    g_free(route);
+                    continue;
+                }
                 networkroute->metric = Metric;
                 networkroute->source = hexToIPAddress(Source, 1);
                 networkroute->desprefixlen = g_strdup_printf(
@@ -2195,6 +2201,10 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
                 networkroute = route;
                 networkroute->iface = g_strdup(Iface);
                 networkroute->destination = hexToIPAddress(&Destination, 0);
+                if (networkroute->destination == NULL) {
+                    g_free(route);
+                    continue;
+                }
                 networkroute->gateway = hexToIPAddress(&Gateway, 0);
                 networkroute->mask = hexToIPAddress(&Mask, 0);
                 networkroute->metric = Metric;
-- 
2.40.1


