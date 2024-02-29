Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A04C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 06:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfaDy-0008Dz-Vc; Thu, 29 Feb 2024 01:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rfaDq-0007Y6-3T
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1rfaDn-0006Sh-Qg
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 01:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709189326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mQCP5bSjozG8LmFXoLkvGhAXZKDeV798KdP9aJSa9Q4=;
 b=hFHB1IMMfJUBpvenY7wDvYrxzcjGsPynEhE6bZu5xC43ClAbexq1+yxIeScHfCRvXz9Nbn
 agZ/KdmL/v8CNDSOmlGJtV1D0Gc0BKQIVo0M9SPSnOBHL3kwUYv5+yiW3JBG3yEDRja7YW
 0wC8xGX5UiHg5sGGV/yCNHLoDs2qhrs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-hAuvT-i6NS6BbN5HcCujKg-1; Thu, 29 Feb 2024 01:48:45 -0500
X-MC-Unique: hAuvT-i6NS6BbN5HcCujKg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D355D185A781;
 Thu, 29 Feb 2024 06:48:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.116.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DDE01121312;
 Thu, 29 Feb 2024 06:48:41 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com,
	kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH v3 1/1] qga/linux: Add new api 'guest-network-get-route'
Date: Thu, 29 Feb 2024 14:48:36 +0800
Message-Id: <20240229064836.21867-2-demeng@redhat.com>
In-Reply-To: <20240229064836.21867-1-demeng@redhat.com>
References: <20240229064836.21867-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The Route information of the Linux VM needs to be used
by administrators and users when debugging network problems
and troubleshooting.

Signed-off-by: Dehan Meng <demeng@redhat.com>
---
 qga/commands-posix.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c |  6 ++++
 qga/qapi-schema.json | 80 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 6169bbf7a0..3ac517423f 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2747,6 +2747,81 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
     return head;
 }
 
+static char *hexToIPAddress(unsigned int hexValue)
+{
+    unsigned int byte1 = (hexValue >> 24) & 0xFF;
+    unsigned int byte2 = (hexValue >> 16) & 0xFF;
+    unsigned int byte3 = (hexValue >> 8) & 0xFF;
+    unsigned int byte4 = hexValue & 0xFF;
+
+    return g_strdup_printf("%u.%u.%u.%u", byte4, byte3, byte2, byte1);
+}
+
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
+{
+    GuestNetworkRouteList *head = NULL, **tail = &head;
+    const char *routeFile = "/proc/net/route";
+    FILE *fp;
+    size_t n;
+    char *line = NULL;
+    int firstLine = 1;
+
+    fp = fopen(routeFile, "r");
+    if (fp == NULL) {
+        error_setg_errno(errp, errno, "open(\"%s\")", routeFile);
+        free(line);
+        return NULL;
+    }
+
+    while (getline(&line, &n, fp) != -1) {
+        if (firstLine) {
+            firstLine = 0;
+            continue;
+        }
+        GuestNetworkRoute *route = NULL;
+        GuestNetworkRouteStat *networkroute;
+        int i;
+	char Iface[IFNAMSIZ];
+        unsigned int Destination, Gateway, Mask, Flags;
+        int RefCnt, Use, Metric, MTU, Window, IRTT;
+
+        /* Parse the line and extract the values */
+        i = (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d",
+                    Iface, &Destination, &Gateway, &Flags, &RefCnt,
+                    &Use, &Metric, &Mask, &MTU, &Window, &IRTT) == 11);
+        if (i == EOF) {
+            continue;
+        }
+
+        route = g_new0(GuestNetworkRoute, 1);
+
+        networkroute = &route->u.q_linux;
+        networkroute->iface = g_strdup(Iface);
+        networkroute->destination = hexToIPAddress(Destination);
+        networkroute->gateway = hexToIPAddress(Gateway);
+        networkroute->mask = hexToIPAddress(Mask);
+        networkroute->metric = Metric;
+	networkroute->has_flags = true;
+        networkroute->flags = Flags;
+        networkroute->has_refcnt = true;
+        networkroute->refcnt = RefCnt;
+        networkroute->has_use = true;
+        networkroute->use = Use;
+        networkroute->has_mtu = true;
+        networkroute->mtu = MTU;
+        networkroute->has_window = true;
+        networkroute->window = Window;
+        networkroute->has_irtt = true;
+        networkroute->irtt = IRTT;
+
+        QAPI_LIST_APPEND(tail, route);
+    }
+
+    free(line);
+    fclose(fp);
+    return head;
+}
+
 #else /* defined(__linux__) */
 
 void qmp_guest_suspend_disk(Error **errp)
@@ -3118,6 +3193,12 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
     return NULL;
 }
 
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
+
 #endif /* CONFIG_FSFREEZE */
 
 #if !defined(CONFIG_FSTRIM)
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 697c65507c..e62c04800a 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -2522,3 +2522,9 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
     error_setg(errp, QERR_UNSUPPORTED);
     return NULL;
 }
+
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
+{
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 876e2a8ea8..eed9539bb7 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1789,3 +1789,83 @@
 { 'command': 'guest-get-cpustats',
   'returns': ['GuestCpuStats']
 }
+
+##
+# @GuestNetworkRouteType:
+#
+# An enumeration of OS type
+#
+# Since: 8.2
+##
+{ 'enum': 'GuestNetworkRouteType',
+  'data': [ 'linux' ] }
+
+##
+# @GuestNetworkRouteStat:
+#
+# Route information, currently, only linux supported.
+#
+# @iface: The destination network or host's egress network interface in the routing table
+#
+# @destination: The IP address of the target network or host, The final destination of the packet
+#
+# @gateway: The IP address of the next hop router
+#
+# @mask: Subnet Mask
+#
+# @metric: Route metric
+#
+# @flags: Route flags (not for windows)
+#
+# @irtt: Initial round-trip delay (not for windows)
+#
+# @refcnt: The route's reference count (not for windows)
+#
+# @use: Route usage count (not for windows)
+#
+# @window: TCP window size, used for flow control (not for windows)
+#
+# @mtu: Data link layer maximum packet size (not for windows)
+#
+# Since: 8.2
+
+##
+{ 'struct': 'GuestNetworkRouteStat',
+  'data': {'iface': 'str',
+           'destination': 'str',
+           'gateway': 'str',
+           'metric': 'int',
+           'mask': 'str',
+           '*irtt': 'int',
+           '*flags': 'uint64',
+           '*refcnt': 'int',
+           '*use': 'int',
+           '*window': 'int',
+           '*mtu': 'int'
+           }}
+
+##
+# @GuestNetworkRoute:
+#
+# Get route information of system.
+#
+# - @linux: Linux style network route
+#
+# Since: 8.2
+##
+{ 'union': 'GuestNetworkRoute',
+  'base': { 'type': 'GuestNetworkRouteType' },
+  'discriminator': 'type',
+  'data': { 'linux': 'GuestNetworkRouteStat' } }
+
+##
+# @guest-network-get-route:
+#
+# Retrieve information about route of network.
+# Returns: List of route info of guest.
+#
+# Since: 8.2
+##
+{ 'command': 'guest-network-get-route',
+  'returns': ['GuestNetworkRoute']
+}
-- 
2.40.1


