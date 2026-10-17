Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6A7CCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 13:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI4aE-00013o-J4; Sat, 17 Oct 2026 09:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xI4aC-00013b-9B
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 09:36:20 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xI4aA-0000Of-1y
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 09:36:20 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6b1afcd2d23so872067a12.1
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 06:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792244176; x=1792848976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+JD1IcntPBG79+wKxFAFefg1pxUx/lMyRuNBhGHXN94=;
 b=odJ9XiFjiPUwEhBU7mwyF9TNbXCQOjZhn7YHfa+mxEpSKEesJoURNdFryK5gt6QkSD
 IwF3jneQalbMXsQHqsGN0/LcrneEzGGm1x6gXtONtp/7ti9EdON3M28SH+ML3IQZbYWD
 E5Z8kqapI9M7mz6w2vYf6qr1eTXxbXnZc63bsUW5KSETcR8ziyvzzmAL/B2WfCqRpByX
 w03pSQzjSSfMQIlJ0mmCnm+Fnr5qeCeXnw/lJfMz1k34AfKhGsgX1EZgOSqYVty1HPEK
 wTBWGoqM8mWqxBM/lhc4r6WMN5g/DNATFFD795r5Op+/T9NprZ+Q7udZbwroCCyw2uvc
 GiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792244176; x=1792848976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+JD1IcntPBG79+wKxFAFefg1pxUx/lMyRuNBhGHXN94=;
 b=zT3mzX3WO0Q4axVVh69OdiiCjJKW/h23Jl66216GbT71fArXdruJTmACM1b7rwZj4D
 vBseS51EYBIzUCXPm3f7S85ttovi8vG7JvmUSbNomaZC2/NEwaDNsI4SHwuwKiPI/5Tw
 RlsvglidjARyQBK7TQ1TSqoLTkFFYsCbOjLDuUn7wd2LtrRuc/S9j115EyEHSgB0bZaF
 HPwrnt4qaodDznrqBICTmAr1vFDE930hN4/GZRYlnMNiUdf8EYCYHYL3TW9VZagIcJm6
 M66X8ntp/NN4O/G222MQvj7EuUKgEUodEem5CDylS/kaItAm9kjsJjVI0EVobe0pO5Gc
 429g==
X-Gm-Message-State: AFq9FYIdBGr78Uj1DTRi1bbNMt2xqp2EFIwEp4vTpxRALrrhFAh6l8Lg
 /+99awIwcUZXHDo1GvsSa7jmTaybksL2+fv6+I42sm8iW6unthLz9SIvBTOZ8kAm+CA=
X-Gm-Gg: AYBFou3cxVgb//2B9yk05DijZ0Kddk3Wwp7iMy7eqmZG4c/xcB7n/24wMz76JrfqwEp
 Kpkf3VtyxhUM/WuOspYVmFIVQGy+e9e5pI7gxN5BzDYqVAXLuV0LdQ62fK1jhusYBByS4318wV1
 vNhkhHRL8UiF2zGA+WcONvHn9GpBPsTRcQQVNMBbGguB83AUa6buO89EfNgtN8EvILn8JwrL/Zl
 2vZcoWB/fbOmkHY/ectaQ4ghcbJibCGHbMbwzzfhuUVLiKkMVmoGIWmOLKcjxGY8RDSVlesEYQ4
 20Toq1zRTJxqW8HtuOcASR7MMveQ74Auf/fHRPYYmBApHxR5AgeaAsMn9kakQUYzVlPVG/8Pi6/
 N3BUSxFPoVmI/bUgrNJm7pxYZHrQcdPtwF3KAPPuzQZeV51ajMg/lDIs6E79x/KPq4wRlqAPDq3
 aFfVHZdgCTP/4UQ3+Ds1n6rgiHxDGpPbSFVpdc0WIniCFfGcyWPhtskBndFXM6Jx6ECYliipL7S
 Ly/YBUpsf48rtgHyX1Y7euMJ9lteH++cLKzkAn5FNByTJTxZ0sqWLnmIGD/2NZGVb67nK/BOGLs
 2mmQlrgelg==
X-Received: by 2002:a17:907:944c:b0:c40:6ed9:b961 with SMTP id
 a640c23a62f3a-c419a05c502mr202365566b.5.1792244175878; 
 Sat, 17 Oct 2026 06:36:15 -0700 (PDT)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c40919c03bbsm169064366b.64.2026.10.17.06.36.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 06:36:14 -0700 (PDT)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2] qga: implement 'guest-network-get-route' for FreeBSD
Date: Sat, 17 Oct 2026 15:35:32 +0200
Message-ID: <20261017133532.64567-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ed1-x530.google.com
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

While here, spell Windows correctly in @GuestNetworkRoute documentation
in qapi-schema.json.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
Changes since v1:

 - qga/qapi-schema.json spelling: windows -> Windows, freebsd -> FreeBSD
   in the "@GuestNetworkRoute" documentation.
 - meson.build: check that the 'struct rt_metrics' has 'rmx_metric'
   member which is available only on FreeBSD 16.

 meson.build          |   6 ++
 qga/commands-bsd.c   | 180 +++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json |  31 ++++----
 3 files changed, 202 insertions(+), 15 deletions(-)

diff --git a/meson.build b/meson.build
index 255c887e8e..cb69d5a3c7 100644
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
index 1c51d099eb..63254e0812 100644
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
@@ -228,4 +233,179 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
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
index 05fe4ea484..a28d836d8a 100644
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
2.55.0


