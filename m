Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2AF606A32D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=comstyle.com header.i=@comstyle.com header.a=rsa-sha256 header.s=default header.b=roMN1jH3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xO4hO-0007d5-K0; Mon, 02 Nov 2026 21:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xO4h9-0007a1-92
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 21:56:20 -0500
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xO4h7-0002lr-0a
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 21:56:18 -0500
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4jJY9j1Fwbz8PbR;
 Mon,  2 Nov 2026 21:56:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=IeyQ/X9smltXf0DV2rxsd1Kodk9j8noitfzT2a7DEcs=; b=roMN
 1jH3cze3F5VJ2pmUDoGXEja/BcLxumotL1UszUfZf2buUiQaBfri9+gbdzH8qMry
 9LtaCX1vw90jdUCgRvYlsUrCBR09Bg++HzW+KflDLG4gMJjlZLThhgVSAgoaU3/L
 W4moZQiIYpyE7L5R6vIci3R3vMhjxcVcjWfpGA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=mLHH8ctOZyO4opqJYm4RQehyG3VKzjm1SdV6MpjEJkgzrNlaUDOXM
 ksqca0hL8ff8mTKxrenglhDktSVp17b7UCIh6nGQnjPVgZvZtRaO5aRiAkqeO9eN
 ihWFI/mJIi2rWwC27O/HEO1bNXTY0fWqxnhbP/5O9YxFim6Db1tcj0=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:e123:313f:39aa:c585])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4jJY9j05L2z8PbP;
 Mon,  2 Nov 2026 21:56:09 -0500 (EST)
Date: Mon, 2 Nov 2026 21:56:07 -0500
From: Brad Smith <brad@comstyle.com>
To: Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Roman Bogorodskiy <bogorodskiy@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Reinoud Zandijk <reinoud@netbsd.org>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2] qga: implement 'guest-network-get-route' for NetBSD and
 OpenBSD
Message-ID: <aulNR-5LSzYJXOPp@humpty.home.comstyle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend the FreeBSD routing table implementation to NetBSD and
OpenBSD. All three dump the table with the NET_RT_DUMP sysctl and
walk rt_msghdr messages, but differ in a few details:

- Locating the sockaddrs: OpenBSD places them after rtm_hdrlen
  bytes and pads each to sizeof(long). NetBSD uses RT_ROUNDUP() and
  FreeBSD SA_SIZE(). Add RT_FIRST_SA() and RT_SA_SIZE() macros to
  cover these.

- The sysctl MIB: NetBSD rejects the trailing routing table ID with
  EINVAL, so use the 6 element form there. FreeBSD and OpenBSD keep
  the 7 element form and dump table 0.

- ARP/NDP entries: OpenBSD and NetBSD return neighbour entries in
  the routing table dump. Skip them via RTF_LLINFO (OpenBSD) or
  RTF_LLDATA (NetBSD, which renamed the flag).

- IPv6 scope: NetBSD and OpenBSD return link-local and scoped
  multicast addresses with the KAME embedded scope ID in bytes 2-3
  of the address. Move it into sin6_scope_id before calling
  getnameinfo(), so these print as fe80::...%iface as on FreeBSD.
  This is a no-op on FreeBSD, where the kernel already does this.

Also use ARRAY_SIZE() instead of nitems(), which NetBSD lacks.

Tested on FreeBSD, NetBSD and OpenBSD, comparing the output
against netstat -rn.

Signed-off-by: Brad Smith <brad@comstyle.com>
Reviewed-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 qga/commands-bsd.c   | 98 +++++++++++++++++++++++++++++++++++++-------
 qga/qapi-schema.json | 23 +++++------
 2 files changed, 95 insertions(+), 26 deletions(-)

diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 830ad08ac0..d607f8df10 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -22,11 +22,9 @@
 #include <sys/mount.h>
 #include <net/if_dl.h>
 #include <sys/statvfs.h>
-#if defined(__FreeBSD__)
 #include <sys/sysctl.h>
 #include <net/route.h>
 #include <net/if.h>
-#endif
 #if defined(__NetBSD__) || defined(__OpenBSD__)
 #include <net/if_arp.h>
 #include <netinet/if_ether.h>
@@ -36,14 +34,27 @@
 #include <paths.h>
 #ifdef __FreeBSD__
 #include <ufs/ffs/fs.h>
+#include <devstat.h>
 #endif
+
 #ifdef __NetBSD__
 typedef struct statvfs bsd_fsinfo_t;
 #else
 typedef struct statfs bsd_fsinfo_t;
 #endif
-#ifdef CONFIG_FREEBSD
-#include <devstat.h>
+
+#if defined(__OpenBSD__)
+#define RT_FIRST_SA(rtm) \
+    ((struct sockaddr *)((char *)(rtm) + (rtm)->rtm_hdrlen))
+#define RT_SA_SIZE(sa) \
+    ((sa)->sa_len > 0 ? 1 + (((sa)->sa_len - 1) | (sizeof(long) - 1)) \
+                      : sizeof(long))
+#elif defined(__NetBSD__)
+#define RT_FIRST_SA(rtm)  ((struct sockaddr *)((rtm) + 1))
+#define RT_SA_SIZE(sa)    RT_ROUNDUP((sa)->sa_len)
+#else /* FreeBSD, DragonFly */
+#define RT_FIRST_SA(rtm)  ((struct sockaddr *)((rtm) + 1))
+#define RT_SA_SIZE(sa)    SA_SIZE(sa)
 #endif
 
 bool build_fs_mount_list(FsMountList *mounts, Error **errp)
@@ -358,22 +369,51 @@ error:
     free(dev_select);
     return NULL;
 }
+#endif
+
+static void sockaddr_in6_normalize(const struct sockaddr *sa,
+                                   struct sockaddr_in6 *sin6)
+{
+    size_t len = MIN(sa->sa_len, sizeof(*sin6));
+
+    memset(sin6, 0, sizeof(*sin6));
+    memcpy(sin6, sa, len);
+
+    sin6->sin6_len = sizeof(*sin6);
+
+    if (IN6_IS_ADDR_LINKLOCAL(&sin6->sin6_addr) ||
+        (sin6->sin6_addr.s6_addr[0] == 0xff &&
+        ((sin6->sin6_addr.s6_addr[1] & 0x0f) == 1 ||
+        (sin6->sin6_addr.s6_addr[1] & 0x0f) == 2))) {
+        if (sin6->sin6_scope_id == 0) {
+            sin6->sin6_scope_id =
+                (sin6->sin6_addr.s6_addr[2] << 8) |
+                 sin6->sin6_addr.s6_addr[3];
+            sin6->sin6_addr.s6_addr[2] = 0;
+            sin6->sin6_addr.s6_addr[3] = 0;
+        }
+    }
+}
 
 GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
 {
     GuestNetworkRouteList *head = NULL, **tail = &head;
+#ifdef __NetBSD__
+    int mib[] = { CTL_NET, PF_ROUTE, 0, AF_UNSPEC, NET_RT_DUMP, 0 };
+#else
     int mib[] = { CTL_NET, PF_ROUTE, 0, AF_UNSPEC, NET_RT_DUMP, 0, 0 };
+#endif
     g_autofree char *buf = NULL;
     size_t len;
 
-    if (sysctl(mib, nitems(mib), NULL, &len, NULL, 0) == -1) {
+    if (sysctl(mib, ARRAY_SIZE(mib), NULL, &len, NULL, 0) == -1) {
         error_setg_errno(errp, errno, "sysctl size");
         return NULL;
     }
 
     buf = g_malloc0(len);
 
-    if (sysctl(mib, nitems(mib), buf, &len, NULL, 0) == -1) {
+    if (sysctl(mib, ARRAY_SIZE(mib), buf, &len, NULL, 0) == -1) {
         error_setg_errno(errp, errno, "sysctl routes");
         return NULL;
     }
@@ -382,14 +422,17 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
         struct rt_msghdr *rtm = (struct rt_msghdr *)p;
         struct sockaddr *addresses[RTAX_MAX] = { NULL };
         struct sockaddr *sa;
+        struct sockaddr_in6 sin6;
         char destination[NI_MAXHOST];
         char gateway[NI_MAXHOST];
         char ifname[IFNAMSIZ];
         const struct sockaddr *dst = NULL;
         const struct sockaddr *gw = NULL;
         const struct sockaddr *netmask = NULL;
+        const struct sockaddr *fmt_sa;
         struct sockaddr_in normalized_mask = { 0 };
         char netmask_buf[INET_ADDRSTRLEN];
+        socklen_t salen;
 
         g_autoptr(GuestNetworkRoute) route = g_new0(GuestNetworkRoute, 1);
 
@@ -405,11 +448,23 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
             continue;
         }
 
-        sa = (struct sockaddr *)(rtm + 1);
+#if defined(RTF_LLINFO)
+        /* OpenBSD: skip ARP/NDP entries */
+        if (rtm->rtm_flags & RTF_LLINFO) {
+            continue;
+        }
+#elif defined(RTF_LLDATA)
+        /* NetBSD: skip ARP/NDP entries */
+        if (rtm->rtm_flags & RTF_LLDATA) {
+            continue;
+        }
+#endif
+
+        sa = RT_FIRST_SA(rtm);
         for (int i = 0; i < RTAX_MAX; i++) {
             if (rtm->rtm_addrs & (1U << i)) {
                 addresses[i] = sa;
-                sa = (struct sockaddr *)((char *)sa + SA_SIZE(sa));
+                sa = (struct sockaddr *)((char *)sa + RT_SA_SIZE(sa));
             }
         }
 
@@ -435,17 +490,33 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
         } else {
             continue;
         }
-        if (getnameinfo(dst, dst->sa_len,
+
+        fmt_sa = dst;
+        salen = dst->sa_len;
+        if (dst->sa_family == AF_INET6) {
+            sockaddr_in6_normalize(dst, &sin6);
+            fmt_sa = (struct sockaddr *)&sin6;
+            salen = sizeof(sin6);
+        }
+        if (getnameinfo(fmt_sa, salen,
                         destination, NI_MAXHOST,
-                        NULL, 0, NI_NUMERICHOST) != 0)
+                        NULL, 0, NI_NUMERICHOST) != 0) {
             continue;
+        }
         route->destination = g_strdup(destination);
 
         gw = addresses[RTAX_GATEWAY];
         if (gw && (gw->sa_family == AF_INET || gw->sa_family == AF_INET6)) {
-            if (getnameinfo(gw, gw->sa_len,
-                            gateway, NI_MAXHOST,
-                            NULL, 0, NI_NUMERICHOST) != 0) {
+            fmt_sa = gw;
+            salen = gw->sa_len;
+            if (gw->sa_family == AF_INET6) {
+                sockaddr_in6_normalize(gw, &sin6);
+                fmt_sa = (struct sockaddr *)&sin6;
+                salen = sizeof(sin6);
+            }
+            if (getnameinfo(fmt_sa, salen, gateway,
+                            NI_MAXHOST, NULL, 0,
+                            NI_NUMERICHOST) != 0) {
                 continue;
             }
             if (gw->sa_family == AF_INET) {
@@ -526,4 +597,3 @@ GuestNetworkRouteList *qmp_guest_network_get_route(Error **errp)
 
     return head;
 }
-#endif /* __FreeBSD__ */
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 7b937713e6..380a7f83ab 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1823,8 +1823,7 @@
 
 ##
 # @GuestNetworkRoute:
-#     Route information.  Supported on Linux (since 9.1), Windows
-#     (since 11.0), and FreeBSD (since 11.2).
+#     Route information.
 #
 # @iface: The destination network or host's egress network interface
 #     in the routing table
@@ -1838,31 +1837,31 @@
 #
 # @mask: Subnet Mask (IPv4 only)
 #
-# @irtt: Initial round-trip delay (not for Windows and FreeBSD,
+# @irtt: Initial round-trip delay (not for Windows and BSD,
 #     IPv4 only)
 #
 # @flags: Route flags (not for Windows)
 #
-# @refcnt: The route's reference count (not for Windows and FreeBSD)
+# @refcnt: The route's reference count (not for Windows and BSD)
 #
-# @use: Route usage count (not for Windows and FreeBSD)
+# @use: Route usage count (not for Windows and BSD)
 #
 # @window: TCP window size, used for flow control (not for Windows
-#     and FreeBSD, IPv4 only)
+#     and BSD, IPv4 only)
 #
 # @mtu: Data link layer maximum packet size (not for Windows)
 #
 # @desprefixlen: Destination prefix length (for IPv6)
 #
-# @source: Source IP address (not for FreeBSD, IPv6 only)
+# @source: Source IP address (not for BSD, IPv6 only)
 #
-# @srcprefixlen: Source prefix length (not for FreeBSD, IPv6 only)
+# @srcprefixlen: Source prefix length (not for BSD, IPv6 only)
 #
 # @nexthop: Next hop IP address (for IPv6)
 #
 # @version: IP version (4 or 6)
 #
-# Since: 9.1 (Linux only); 11.0 (Windows); 11.2 (FreeBSD)
+# Since: 9.1 (Linux only); 11.0 (Windows); 11.2 (BSD)
 ##
 { 'struct': 'GuestNetworkRoute',
   'data': {'iface': 'str',
@@ -1882,7 +1881,7 @@
            '*nexthop': 'str',
            'version': 'int'
            },
-  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_FREEBSD'] } }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_BSD'] } }
 
 ##
 # @guest-network-get-route:
@@ -1890,9 +1889,9 @@
 #
 # Returns: List of route info of guest.
 #
-# Since: 9.1 (Linux only); 11.0 (Windows); 11.2 (FreeBSD)
+# Since: 9.1 (Linux only); 11.0 (Windows); 11.2 (BSD)
 ##
 { 'command': 'guest-network-get-route',
   'returns': ['GuestNetworkRoute'],
-  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_FREEBSD'] }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32', 'CONFIG_BSD'] }
 }
-- 
2.56.0


