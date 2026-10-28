Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591CB60A260C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dd3Xdd7X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM0BF-0007Gf-FA; Wed, 28 Oct 2026 05:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM0Ai-0006x9-24
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xM0Af-0008Sj-Bd
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793180532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcFcpHWK8R0UlF01J7rf8ed8TzZOVdZWuJn5gK2yT5A=;
 b=dd3Xdd7XID6PXksl464um+78tAW7MklS8hHl6LK+/xLxDjWJE/MGr2GQRdPTGbxlel0Ep4
 R+i6RhkU1mMohPPpkD4W+eq19bHxbxNGjktH3poQEsGmDp406Q0n3Dx/ZxBrY8JG5LKDWM
 MhemZSGllH6Py2rQDYpKQSZoOu3HJC4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-ls5lYK0CNcqWFxc5gbVvOA-1; Wed,
 28 Oct 2026 05:42:08 -0400
X-MC-Unique: ls5lYK0CNcqWFxc5gbVvOA-1
X-Mimecast-MFC-AGG-ID: ls5lYK0CNcqWFxc5gbVvOA_1793180527
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 868F91800620; Wed, 28 Oct 2026 09:42:07 +0000 (UTC)
Received: from Kostiantyns-MacBook-Pro.redhat.com (unknown [10.44.32.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A5C81956086; Wed, 28 Oct 2026 09:42:06 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 6/6] qga: implement 'guest-network-get-route' for FreeBSD
Date: Wed, 28 Oct 2026 11:41:52 +0200
Message-ID: <20261028094152.14934-7-kkostiuk@redhat.com>
In-Reply-To: <20261028094152.14934-1-kkostiuk@redhat.com>
References: <20261028094152.14934-1-kkostiuk@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Roman Bogorodskiy <bogorodskiy@gmail.com>

Implement 'guest-network-get-route' for FreeBSD. This
implementation uses the sysctl(3) interface to get
the routing table.

Limitations:

 - This implementation does not populate irtt, refcnt, use,
   window, source, and srcprefixlen fields.
 - The implementation uses the default FIB (routing table) 0.
   Selecting QGA's active FIB is left for the follow-up patch.

While here, spell Windows correctly in @GuestNetworkRoute documentation
in qapi-schema.json.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261026190352.14293-1-bogorodskiy@gmail.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
---
 meson.build          |   6 ++
 qga/commands-bsd.c   | 174 ++++++++++++++++++++++++++++++++++++++++++-
 qga/qapi-schema.json |  31 ++++----
 3 files changed, 195 insertions(+), 16 deletions(-)

diff --git a/meson.build b/meson.build
index 671511c419..7ec3fb9023 100644
--- a/meson.build
+++ b/meson.build
@@ -2759,6 +2759,12 @@ config_host_data.set('HAVE_STRUCT_STAT_ST_ATIM',
 config_host_data.set('HAVE_BLK_ZONE_REP_CAPACITY',
                      cc.has_member('struct blk_zone', 'capacity',
                                    prefix: '#include <linux/blkzoned.h>'))
+config_host_data.set('HAVE_STRUCT_RT_METRICS_RMX_METRIC',
+                     cc.has_member('struct rt_metrics', 'rmx_metric',
+                                   prefix: '''
+                                       #include <sys/types.h>
+                                       #include <sys/socket.h>
+                                       #include <net/route.h>'''))
 
 # has_type
 config_host_data.set('CONFIG_IOVEC',
diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 7c7616699b..830ad08ac0 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -22,6 +22,11 @@
 #include <sys/mount.h>
 #include <net/if_dl.h>
 #include <sys/statvfs.h>
+#if defined(__FreeBSD__)
+#include <sys/sysctl.h>
+#include <net/route.h>
+#include <net/if.h>
+#endif
 #if defined(__NetBSD__) || defined(__OpenBSD__)
 #include <net/if_arp.h>
 #include <netinet/if_ether.h>
@@ -354,4 +359,171 @@ error:
     return NULL;
 }
 
-#endif /* CONFIG_FREEBSD */
+GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
+{
+    GuestNetworkRouteList *head = NULL, **tail = &head;
+    int mib[] = { CTL_NET, PF_ROUTE, 0, AF_UNSPEC, NET_RT_DUMP, 0, 0 };
+    g_autofree char *buf = NULL;
+    size_t len;
+
+    if (sysctl(mib, nitems(mib), NULL, &len, NULL, 0) == -1) {
+        error_setg_errno(errp, errno, "sysctl size");
+        return NULL;
+    }
+
+    buf = g_malloc0(len);
+
+    if (sysctl(mib, nitems(mib), buf, &len, NULL, 0) == -1) {
+        error_setg_errno(errp, errno, "sysctl routes");
+        return NULL;
+    }
+
+    for (char *p = buf, *end = buf + len; p < end; ) {
+        struct rt_msghdr *rtm = (struct rt_msghdr *)p;
+        struct sockaddr *addresses[RTAX_MAX] = { NULL };
+        struct sockaddr *sa;
+        char destination[NI_MAXHOST];
+        char gateway[NI_MAXHOST];
+        char ifname[IFNAMSIZ];
+        const struct sockaddr *dst = NULL;
+        const struct sockaddr *gw = NULL;
+        const struct sockaddr *netmask = NULL;
+        struct sockaddr_in normalized_mask = { 0 };
+        char netmask_buf[INET_ADDRSTRLEN];
+
+        g_autoptr(GuestNetworkRoute) route = g_new0(GuestNetworkRoute, 1);
+
+        if ((size_t)(end - p) < sizeof(*rtm) ||
+            rtm->rtm_msglen < sizeof(*rtm) ||
+            rtm->rtm_msglen > (size_t)(end - p)) {
+            break;
+        }
+
+        p += rtm->rtm_msglen;
+
+        if (rtm->rtm_version != RTM_VERSION) {
+            continue;
+        }
+
+        sa = (struct sockaddr *)(rtm + 1);
+        for (int i = 0; i < RTAX_MAX; i++) {
+            if (rtm->rtm_addrs & (1U << i)) {
+                addresses[i] = sa;
+                sa = (struct sockaddr *)((char *)sa + SA_SIZE(sa));
+            }
+        }
+
+        if (if_indextoname(rtm->rtm_index, ifname)) {
+            route->iface = g_strdup(ifname);
+        } else {
+            route->iface = g_strdup_printf("if%u", rtm->rtm_index);
+        }
+
+#if defined(HAVE_STRUCT_RT_METRICS_RMX_METRIC)
+        route->metric = rtm->rtm_rmx.rmx_metric;
+#endif
+
+        dst = addresses[RTAX_DST];
+        if (!dst) {
+            continue;
+        }
+
+        if (dst->sa_family == AF_INET) {
+            route->version = 4;
+        } else if (dst->sa_family == AF_INET6) {
+            route->version = 6;
+        } else {
+            continue;
+        }
+        if (getnameinfo(dst, dst->sa_len,
+                        destination, NI_MAXHOST,
+                        NULL, 0, NI_NUMERICHOST) != 0)
+            continue;
+        route->destination = g_strdup(destination);
+
+        gw = addresses[RTAX_GATEWAY];
+        if (gw && (gw->sa_family == AF_INET || gw->sa_family == AF_INET6)) {
+            if (getnameinfo(gw, gw->sa_len,
+                            gateway, NI_MAXHOST,
+                            NULL, 0, NI_NUMERICHOST) != 0) {
+                continue;
+            }
+            if (gw->sa_family == AF_INET) {
+                route->gateway = g_strdup(gateway);
+            } else if (gw->sa_family == AF_INET6) {
+                route->nexthop = g_strdup(gateway);
+            }
+        }
+
+        netmask = addresses[RTAX_NETMASK];
+        if (dst->sa_family == AF_INET) {
+            if (netmask && netmask->sa_len != 0) {
+                memcpy(&normalized_mask, netmask,
+                       MIN(netmask->sa_len, sizeof(normalized_mask)));
+            } else if (rtm->rtm_flags & RTF_HOST) {
+                normalized_mask.sin_addr.s_addr = 0xFFFFFFFF;
+            }
+
+            if (inet_ntop(AF_INET, &normalized_mask.sin_addr,
+                          netmask_buf, sizeof(netmask_buf)) != NULL) {
+                route->mask = g_strdup(netmask_buf);
+            } else {
+                route->mask = NULL;
+            }
+        } else if (dst->sa_family == AF_INET6) {
+            struct sockaddr_in6 normalized_mask6;
+            memset(&normalized_mask6, 0, sizeof(normalized_mask6));
+
+            if (netmask && netmask->sa_len != 0) {
+                int prefix_len = 0;
+                bool valid_mask = true;
+                bool zero_found = false;
+
+                memcpy(&normalized_mask6, netmask,
+                       MIN(netmask->sa_len, sizeof(normalized_mask6)));
+
+                for (int i = 0; i < sizeof(normalized_mask6.sin6_addr); i++) {
+                    uint8_t byte = normalized_mask6.sin6_addr.s6_addr[i];
+                    for (int bit = 7; bit >= 0; bit--) {
+                        if ((byte >> bit) & 1) {
+                            if (zero_found) {
+                                valid_mask = false;
+                                break;
+                            }
+                            prefix_len++;
+                        } else {
+                            zero_found = true;
+                        }
+                    }
+                    if (!valid_mask) {
+                        break;
+                    }
+                }
+
+                if (valid_mask) {
+                    route->desprefixlen = g_strdup_printf("%d", prefix_len);
+                } else {
+                    route->desprefixlen = NULL;
+                }
+            } else if (rtm->rtm_flags & RTF_HOST) {
+                route->desprefixlen = g_strdup("128");
+            } else {
+                route->desprefixlen = g_strdup("0");
+            }
+        }
+
+        if (rtm->rtm_rmx.rmx_mtu) {
+            route->mtu = rtm->rtm_rmx.rmx_mtu;
+            route->has_mtu = true;
+        }
+
+        route->flags = (uint32_t)rtm->rtm_flags;
+        route->has_flags = true;
+
+        QAPI_LIST_APPEND(tail, route);
+        route = NULL;
+    }
+
+    return head;
+}
+#endif /* __FreeBSD__ */
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 308ed9acf1..7b937713e6 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1823,8 +1823,8 @@
 
 ##
 # @GuestNetworkRoute:
-#     Route information.  Supported on Linux (since 9.1) and Windows
-#     (since 11.0).
+#     Route information.  Supported on Linux (since 9.1), Windows
+#     (since 11.0), and FreeBSD (since 11.2).
 #
 # @iface: The destination network or host's egress network interface
 #     in the routing table
@@ -1838,30 +1838,31 @@
 #
 # @mask: Subnet Mask (IPv4 only)
 #
-# @irtt: Initial round-trip delay (not for windows, IPv4 only)
+# @irtt: Initial round-trip delay (not for Windows and FreeBSD,
+#     IPv4 only)
 #
-# @flags: Route flags (not for windows)
+# @flags: Route flags (not for Windows)
 #
-# @refcnt: The route's reference count (not for windows)
+# @refcnt: The route's reference count (not for Windows and FreeBSD)
 #
-# @use: Route usage count (not for windows)
+# @use: Route usage count (not for Windows and FreeBSD)
 #
-# @window: TCP window size, used for flow control (not for windows,
-#     IPv4 only)
+# @window: TCP window size, used for flow control (not for Windows
+#     and FreeBSD, IPv4 only)
 #
-# @mtu: Data link layer maximum packet size (not for windows)
+# @mtu: Data link layer maximum packet size (not for Windows)
 #
 # @desprefixlen: Destination prefix length (for IPv6)
 #
-# @source: Source IP address (for IPv6)
+# @source: Source IP address (not for FreeBSD, IPv6 only)
 #
-# @srcprefixlen: Source prefix length (for IPv6)
+# @srcprefixlen: Source prefix length (not for FreeBSD, IPv6 only)
 #
 # @nexthop: Next hop IP address (for IPv6)
 #
 # @version: IP version (4 or 6)
 #
-# Since: 9.1 (Linux only); 11.0 (Windows)
+# Since: 9.1 (Linux only); 11.0 (Windows); 11.2 (FreeBSD)
 ##
 { 'struct': 'GuestNetworkRoute',
   'data': {'iface': 'str',
@@ -1881,7 +1882,7 @@
            '*nexthop': 'str',
            'version': 'int'
            },
-  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] } }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_FREEBSD'] } }
 
 ##
 # @guest-network-get-route:
@@ -1889,9 +1890,9 @@
 #
 # Returns: List of route info of guest.
 #
-# Since: 9.1 (Linux only); 11.0 (Windows)
+# Since: 9.1 (Linux only); 11.0 (Windows); 11.2 (FreeBSD)
 ##
 { 'command': 'guest-network-get-route',
   'returns': ['GuestNetworkRoute'],
-  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_FREEBSD'] }
 }
-- 
2.54.0 (Apple Git-157)


