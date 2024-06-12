Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3A0C27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 04:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHFkO-0007Tz-5r; Wed, 12 Jun 2024 00:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sHFkL-0007Ph-5q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 00:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1sHFkJ-0000a8-J7
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 00:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718167082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uE4K5ZLQYGKeaE0btJTP07/oc+C0RFVQIXNB5Rr+EoI=;
 b=SohEalhwSMVpp2GZZAf36narTP20wgy1VSO2VEB/+8bt/cwJXT7sdJfMw/3Wsk/z3tYJMN
 oRh4OuB783OX3Odb6Y8gdYGN90UE3wPtn/KNlMHn/mxUytZQBeXckxeGHvShfcLVQD9fqn
 qkaJIu9rBRLlwH1WnX65WDWXtfQ2m8s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-8eo33FVKPr2hLZvKwHQm1A-1; Wed,
 12 Jun 2024 00:36:02 -0400
X-MC-Unique: 8eo33FVKPr2hLZvKwHQm1A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23523195608A; Wed, 12 Jun 2024 04:36:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.216])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B30330000C4; Wed, 12 Jun 2024 04:35:57 +0000 (UTC)
From: Dehan Meng <demeng@redhat.com>
To: qemu-devel@nongnu.org
Cc: demeng@redhat.com,
	kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH v4 1/1] qga/linux: Add new api 'guest-network-get-route'
Date: Wed, 12 Jun 2024 12:35:47 +0800
Message-Id: <20240612043547.282552-2-demeng@redhat.com>
In-Reply-To: <20240612043547.282552-1-demeng@redhat.com>
References: <20240612043547.282552-1-demeng@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
 qga/commands-posix.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
 qga/commands-win32.c |  6 ++++
 qga/qapi-schema.json | 68 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 6169bbf7a0..ffae88ca69 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2747,6 +2747,73 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
     return head;
 }
 
+char *hexToIPAddress(unsigned int hexValue, char ipAddress[16]);
+char *hexToIPAddress(unsigned int hexValue, char ipAddress[16])
+{
+    unsigned int byte1 = (hexValue >> 24) & 0xFF;
+    unsigned int byte2 = (hexValue >> 16) & 0xFF;
+    unsigned int byte3 = (hexValue >> 8) & 0xFF;
+    unsigned int byte4 = hexValue & 0xFF;
+
+    snprintf(ipAddress, 16, "%u.%u.%u.%u", byte4, byte3, byte2, byte1);
+
+    return ipAddress;
+}
+
+GuestNetworkRouteStatList *qmp_guest_network_get_route(Error **errp)
+{
+    GuestNetworkRouteStatList *head = NULL, **tail = &head;
+    const char *routeFile = "/proc/net/route";
+    FILE *fp;
+    size_t n;
+    char *line = NULL;
+
+    fp = fopen(routeFile, "r");
+    if (fp == NULL) {
+        error_setg_errno(errp, errno, "open(\"%s\")", routeFile);
+        return NULL;
+    }
+
+    while (getline(&line, &n, fp) != -1) {
+        GuestNetworkRouteStat *networkroute;
+        int i;
+        char Iface[16];
+        unsigned int Destination, Gateway, Mask, Flags;
+        int RefCnt, Use, Metric, MTU, Window, IRTT;
+
+        i = (sscanf(line, "%s %X %X %x %d %d %d %X %d %d %d",
+                    Iface, &Destination, &Gateway, &Flags, &RefCnt,
+                    &Use, &Metric, &Mask, &MTU, &Window, &IRTT) == 11);
+        if (i == EOF) {
+            continue;
+        }
+
+        networkroute = g_new0(GuestNetworkRouteStat, 1);
+
+        char DestAddress[16];
+        char GateAddress[16];
+        char MaskAddress[16];
+
+        networkroute->iface = g_strdup(Iface);
+        networkroute->destination = g_strdup(hexToIPAddress(Destination, DestAddress));
+        networkroute->gateway = g_strdup(hexToIPAddress(Gateway, GateAddress));
+        networkroute->mask = g_strdup(hexToIPAddress(Mask, MaskAddress));
+        networkroute->metric = Metric;
+        networkroute->flags = Flags;
+        networkroute->refcnt = RefCnt;
+        networkroute->use = Use;
+        networkroute->mtu = MTU;
+        networkroute->window = Window;
+        networkroute->irtt = IRTT;
+
+        QAPI_LIST_APPEND(tail, networkroute);
+    }
+
+    free(line);
+    fclose(fp);
+    return head;
+}
+
 #else /* defined(__linux__) */
 
 void qmp_guest_suspend_disk(Error **errp)
@@ -3118,6 +3185,12 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
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
index 876e2a8ea8..195f6cd4e7 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1789,3 +1789,71 @@
 { 'command': 'guest-get-cpustats',
   'returns': ['GuestCpuStats']
 }
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
+# @metric: Route metricls
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
+# Since: 9.1
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
+# @routes: A list of network route information.
+#
+# Since: 9.1
+##
+{ 'struct': 'GuestNetworkRoute',
+  'data': { 'routes': ['GuestNetworkRouteStat'] } }
+
+##
+# @guest-network-get-route:
+#
+# Retrieve information about route of network.
+# Returns: List of route info of guest.
+#
+# Since: 9.1
+##
+{ 'command': 'guest-network-get-route',
+  'returns': ['GuestNetworkRouteStat']
+}
-- 
2.40.1


