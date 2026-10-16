Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7486DCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHktB-0003f1-01; Fri, 16 Oct 2026 12:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xHkt9-0003b1-99
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:34:35 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xHkt7-0003Si-02
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:34:34 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c3f10d2f255so10010166b.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792168471; x=1792773271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4FLoEJWG8j1hbHYpC3s/KLg42Ui3wRgsVUWImn/8ap0=;
 b=X4krydAtIlauFYlr57WRsCcpB93PKFrxR68EwxPWKNDUxIpQh4749heauIo6vmKwhN
 i0sqoJLxp6cXteeHaIfizSIGimQPvvaO6h30vXMwHbGey/oKJlgzKNoTPnf14mC+kN0g
 Ya7O84d+thHweu50F+qW/Nml4KVIqXW+nEmfPpeplQyLuEJETmv9a1+z59IWkmo08SQG
 ulbqj8pqkyiP5k/m77Da0lHWdYXXnCJ40S0vFWnZTm16ujGO7VxDJ5bslfFQ0erORoUv
 0zR9ZW/GZNgNWiZV0TZAsoDu0DysOdNmI9NosGRyurkDRqk3kA2XgMwl31K6BPIhG/+S
 ynIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792168471; x=1792773271;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4FLoEJWG8j1hbHYpC3s/KLg42Ui3wRgsVUWImn/8ap0=;
 b=K1giaemNAvL/q6DpcntQ41DNdpKWEGrnqX1paxR7dvBIheBA3tp9ZEIrAyx2zCeWDt
 N243bqVpZqOfl9OysZADwFxhQj4z2WqAPQkSi1Py2u0KkY6xCONAwLgFdLO+SZWtOISO
 oCZzN4hW0ENMYgaB+VhjNDYhFsFaTlcTZmSjJtVol5Wkekaa/CR8L1Vo/8J0O58DetqC
 BWiBTlMizfAzfRa51bJWFEf+2nAKB9thfV6+JE5pDThe561Fls95en4zpjLvEfWm0GBo
 13I/Vp4kxXlNsNb+DNN6NY5S73C27CZrnWxwSlz1YULEag1f6r0tIb6F5RbCZQbKBSlt
 LtbA==
X-Gm-Message-State: AFq9FYJ9ptZ+Lx3ZoT2rOMuWwsQz19VFXrltS4VauianVAX7lvbU7n6T
 RwELOKCQZxBKmY4W1zp8bSEygMW8qCMAFOhaK7lFFLiXU/AvNmh9+v6dDbiU9QoVzcY=
X-Gm-Gg: AYBFou0y52/d7clBkUQS66lwdKhyw3KAUoQNVIxnhzIqI5NuplwlU+FcXDhVMf3vyB/
 kHdbP48pELq391Hy58evCaZlR0UgCPpMj4vB6qiTi42Y8xhRBRFsBDtImXT6v1CNSTGZgpp569f
 lfYcsXzUHfM3elZd2qI9Am7UxDcvTFBzEvpGi693W7I+hylSUiVXi58jCDBm6gm4DRtot0guWFj
 mQ8ziWGpQW0EM77aPv/+vz3oW8dKzG+8hu1L3Vsmg8sqS1onLsIjdaBJ6SGRvlJFnZ4ZOav11kv
 ha5Vh7iI/UKAX8Jy8anl370KoYKZmY/vr1Aw0U+cwm6txgpZJEzVvBq060g7cJu4Lsl0Gd+pM2c
 4N+F+QjXe+TIyDGSW2IEVO37Ke4V/eVu1pz6/Gh6tL2l1P8pQzP/MlJ0ls1bR6Io+tKtil02W9D
 xQLE02jD8Cojv0UU32toMhXMYVwcZQzlRd+KTywoPaC9QTDp//LJJAlY4qEK7vWNu13okNjXKuO
 K4duqVjn8n5kvN8NChlo0wtaHBOdngPKr5vbbKJf9wT3/MJ838+S+1UgY2TEYY1pDZoDcFaLD3E
 YjDAIhEXxg==
X-Received: by 2002:a17:907:ea8a:b0:c34:cf13:a930 with SMTP id
 a640c23a62f3a-c419f9ffa42mr29361466b.34.1792168470412; 
 Fri, 16 Oct 2026 09:34:30 -0700 (PDT)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c40913c4c5dsm90151866b.39.2026.10.16.09.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:34:29 -0700 (PDT)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] qga: implement 'guest-network-get-route' for FreeBSD
Date: Fri, 16 Oct 2026 18:33:45 +0200
Message-ID: <20261016163345.15303-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement 'guest-network-get-route' for FreeBSD. This
implementation uses the sysctl(3) interface to get
the routing table.

Limitations:

 - This implementation does not populate irtt, refcnt, use,
   window, source, and srcprefixlen fields.
 - The implementation uses the default FIB (routing table) 0.
   Selecting QGA's active FIB is left for the follow-up patch.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
---
 qga/commands-bsd.c   | 178 +++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json |  27 +++----
 2 files changed, 192 insertions(+), 13 deletions(-)

diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 1c51d099eb..87c749a4c5 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -21,6 +21,11 @@
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
@@ -228,4 +233,177 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
     free_fs_mount_list(&mounts);
     return ret;
 }
+
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
+        char ifname[IFNAMSIZ] = "?";
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
+        if_indextoname(rtm->rtm_index, ifname);
+
+        route->iface = g_strdup(ifname);
+        route->metric = rtm->rtm_rmx.rmx_metric;
+
+        dst = addresses[RTAX_DST];
+        if (!dst) {
+            continue;
+        }
+
+        if (dst->sa_family == AF_INET) {
+            if (inet_ntop(AF_INET,
+                          &((const struct sockaddr_in *)dst)->sin_addr,
+                          destination, NI_MAXHOST) == NULL) {
+                continue;
+            }
+            route->version = 4;
+        } else if (dst->sa_family == AF_INET6) {
+            if (getnameinfo(dst, dst->sa_len,
+                            destination, NI_MAXHOST,
+                            NULL, 0, NI_NUMERICHOST) != 0)
+                continue;
+            route->version = 6;
+        } else {
+            continue;
+        }
+        route->destination = g_strdup(destination);
+
+        gw = addresses[RTAX_GATEWAY];
+        if (gw) {
+            if (gw->sa_family == AF_INET) {
+                if (inet_ntop(AF_INET,
+                              &((const struct sockaddr_in *)gw)->sin_addr,
+                              gateway, NI_MAXHOST) == NULL) {
+                    continue;
+                }
+                route->gateway = g_strdup(gateway);
+            } else if (gw->sa_family == AF_INET6) {
+                if (getnameinfo(gw, gw->sa_len,
+                                gateway, NI_MAXHOST,
+                                NULL, 0, NI_NUMERICHOST) != 0) {
+                    continue;
+                }
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
 #endif /* __FreeBSD__ */
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 05fe4ea484..2f9d9f13a0 100644
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
+# @irtt: Initial round-trip delay (not for windows and freebsd,
+#     IPv4 only)
 #
 # @flags: Route flags (not for windows)
 #
-# @refcnt: The route's reference count (not for windows)
+# @refcnt: The route's reference count (not for windows and freebsd)
 #
-# @use: Route usage count (not for windows)
+# @use: Route usage count (not for windows and freebsd)
 #
-# @window: TCP window size, used for flow control (not for windows,
-#     IPv4 only)
+# @window: TCP window size, used for flow control (not for windows
+#     and freebsd, IPv4 only)
 #
 # @mtu: Data link layer maximum packet size (not for windows)
 #
 # @desprefixlen: Destination prefix length (for IPv6)
 #
-# @source: Source IP address (for IPv6)
+# @source: Source IP address (not for freebsd, IPv6 only)
 #
-# @srcprefixlen: Source prefix length (for IPv6)
+# @srcprefixlen: Source prefix length (not for freebsd, IPv6 only)
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
2.55.0


