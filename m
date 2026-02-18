Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272EBE9A04B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 20:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsoAT-0007Ce-Lc; Wed, 18 Feb 2026 15:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsoA6-00075a-GX
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:28:42 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vsoA4-0007sW-Dm
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 15:28:42 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 34C00C0392;
 Wed, 18 Feb 2026 23:28:39 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:53d::1:1b])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VShB144A8iE0-DH4i0Afb; Wed, 18 Feb 2026 23:28:38 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771446518;
 bh=dhvf7c3k/uO9jHIwPOa/zbw14qpoj7QwL07+jRiyYfw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=A/S2jqPrfAI1xZjnTaiQEAdpO/I/JdmXKWZ5ewbnbHJQEgu5bclzoghkNyJiPuELQ
 tzWM+DNhmhCTBnKcDiEYtbw72mQVSxkVD4PQrOk8sCG9eNV5/rUwROtX79UCURxfQg
 vlxIGkWW0BzIl/HTgn951+xKECtxPvxIcU8XRIuE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru, Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v3 08/12] net: introduce net_parse_fds()
Date: Wed, 18 Feb 2026 23:28:24 +0300
Message-ID: <20260218202829.1322088-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Add common net_parse_fds() and net_free_fds() helpers and use them
in tap.c and af-xdp.c.

Choose returning queues instead of fds, because we'll have derived
helper in net/tap, which will be able to return fds=NULL and non-zero
queues on success. That's also why we move to INT_MAX for queues, to
support negative return value for net_parse_fds() (for failure paths).

Note that redundant restriction of MAX_TAP_QUEUES is dropped for tap.c

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/af-xdp.c | 33 ++-----------------
 net/tap.c    | 92 +++++++++++-----------------------------------------
 net/util.c   | 50 ++++++++++++++++++++++++++++
 net/util.h   | 14 ++++++++
 4 files changed, 85 insertions(+), 104 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index ff1cb30a98..1ffd6363a8 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -21,6 +21,7 @@
 #include "clients.h"
 #include "monitor/monitor.h"
 #include "net/net.h"
+#include "net/util.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
@@ -441,35 +442,6 @@ static NetClientInfo net_af_xdp_info = {
     .cleanup = af_xdp_cleanup,
 };
 
-static int *parse_socket_fds(const char *sock_fds_str,
-                             int n_expected, Error **errp)
-{
-    gchar **substrings = g_strsplit(sock_fds_str, ":", -1);
-    int i, n_sock_fds = g_strv_length(substrings);
-    int *sock_fds = NULL;
-
-    if (n_sock_fds != n_expected) {
-        error_setg(errp, "expected %d socket fds, got %d",
-                   n_expected, n_sock_fds);
-        goto exit;
-    }
-
-    sock_fds = g_new(int, n_sock_fds);
-
-    for (i = 0; i < n_sock_fds; i++) {
-        sock_fds[i] = monitor_fd_param(monitor_cur(), substrings[i], errp);
-        if (sock_fds[i] < 0) {
-            g_free(sock_fds);
-            sock_fds = NULL;
-            goto exit;
-        }
-    }
-
-exit:
-    g_strfreev(substrings);
-    return sock_fds;
-}
-
 /*
  * The exported init function.
  *
@@ -530,8 +502,7 @@ int net_init_af_xdp(const Netdev *netdev,
     }
 
     if (opts->sock_fds) {
-        sock_fds = parse_socket_fds(opts->sock_fds, queues, errp);
-        if (!sock_fds) {
+        if (net_parse_fds(opts->sock_fds, &sock_fds, queues, errp) < 0) {
             return -1;
         }
     }
diff --git a/net/tap.c b/net/tap.c
index db3fe380a4..2d4630c350 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -45,6 +45,7 @@
 #include "hw/virtio/vhost.h"
 
 #include "net/tap.h"
+#include "net/util.h"
 
 #include "net/vhost_net.h"
 
@@ -701,8 +702,6 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
     return fd;
 }
 
-#define MAX_TAP_QUEUES 1024
-
 static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *name,
                              const char *ifname, const char *script,
@@ -782,32 +781,6 @@ failed:
     return false;
 }
 
-static int get_fds(char *str, char *fds[], int max)
-{
-    char *ptr = str, *this;
-    size_t len = strlen(str);
-    int i = 0;
-
-    while (i < max && ptr < str + len) {
-        this = strchr(ptr, ':');
-
-        if (this == NULL) {
-            fds[i] = g_strdup(ptr);
-        } else {
-            fds[i] = g_strndup(ptr, this - ptr);
-        }
-
-        i++;
-        if (this == NULL) {
-            break;
-        } else {
-            ptr = this + 1;
-        }
-    }
-
-    return i;
-}
-
 int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
@@ -815,9 +788,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
     int fd = -1, vhostfd = -1, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
     char ifname[128];
-    char **fds = NULL, **vhost_fds = NULL;
-    int nfds = 0, nvhosts = 0;
-
+    int *fds = NULL, *vhost_fds = NULL;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
@@ -890,46 +861,31 @@ int net_init_tap(const Netdev *netdev, const char *name,
             goto fail;
         }
     } else if (tap->fds) {
-        fds = g_new0(char *, MAX_TAP_QUEUES);
-        vhost_fds = g_new0(char *, MAX_TAP_QUEUES);
-
-        nfds = get_fds(tap->fds, fds, MAX_TAP_QUEUES);
-        if (tap->vhostfds) {
-            nvhosts = get_fds(tap->vhostfds, vhost_fds, MAX_TAP_QUEUES);
-            if (nfds != nvhosts) {
-                error_setg(errp, "The number of fds passed does not match "
-                           "the number of vhostfds passed");
-                goto fail;
-            }
+        queues = net_parse_fds(tap->fds, &fds, 0, errp);
+        if (queues < 0) {
+            goto fail;
         }
 
-        for (i = 0; i < nfds; i++) {
-            fd = monitor_fd_param(monitor_cur(), fds[i], errp);
-            if (fd == -1) {
-                goto fail;
-            }
+        if (tap->vhostfds && net_parse_fds(tap->vhostfds, &vhost_fds,
+                                           queues, errp) < 0) {
+            goto fail;
+        }
 
-            if (!qemu_set_blocking(fd, false, errp)) {
+        for (i = 0; i < queues; i++) {
+            if (!qemu_set_blocking(fds[i], false, errp)) {
                 goto fail;
             }
 
-            if (tap->vhostfds) {
-                vhostfd = monitor_fd_param(monitor_cur(), vhost_fds[i], errp);
-                if (vhostfd == -1) {
-                    goto fail;
-                }
-
-                if (!qemu_set_blocking(vhostfd, false, errp)) {
-                    goto fail;
-                }
+            if (vhost_fds && !qemu_set_blocking(vhost_fds[i], false, errp)) {
+                goto fail;
             }
 
             if (i == 0) {
-                vnet_hdr = tap_probe_vnet_hdr(fd, errp);
+                vnet_hdr = tap_probe_vnet_hdr(fds[i], errp);
                 if (vnet_hdr < 0) {
                     goto fail;
                 }
-            } else if (vnet_hdr != tap_probe_vnet_hdr(fd, NULL)) {
+            } else if (vnet_hdr != tap_probe_vnet_hdr(fds[i], NULL)) {
                 error_setg(errp,
                            "vnet_hdr not consistent across given tap fds");
                 goto fail;
@@ -937,8 +893,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
             if (!net_init_tap_one(tap, peer, name, ifname,
                                   NULL, NULL,
-                                  vhostfd,
-                                  vnet_hdr, fd, errp)) {
+                                  vhost_fds ? vhost_fds[i] : -1,
+                                  vnet_hdr, fds[i], errp)) {
                 goto fail;
             }
         }
@@ -1003,18 +959,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
 fail:
     close(fd);
     close(vhostfd);
-    if (vhost_fds) {
-        for (i = 0; i < nvhosts; i++) {
-            g_free(vhost_fds[i]);
-        }
-        g_free(vhost_fds);
-    }
-    if (fds) {
-        for (i = 0; i < nfds; i++) {
-            g_free(fds[i]);
-        }
-        g_free(fds);
-    }
+    net_free_fds(fds, queues);
+    net_free_fds(vhost_fds, queues);
     return -1;
 }
 
diff --git a/net/util.c b/net/util.c
index 0b3dbfe5d3..1998a6554e 100644
--- a/net/util.c
+++ b/net/util.c
@@ -23,6 +23,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "monitor/monitor.h"
+#include "qapi/error.h"
 #include "util.h"
 
 int net_parse_macaddr(uint8_t *macaddr, const char *p)
@@ -57,3 +59,51 @@ int net_parse_macaddr(uint8_t *macaddr, const char *p)
 
     return 0;
 }
+
+void net_free_fds(int *fds, int nfds)
+{
+    int i;
+
+    if (!fds || nfds <= 0) {
+        return;
+    }
+
+    for (i = 0; i < nfds; i++) {
+        if (fds[i] != -1) {
+            close(fds[i]);
+        }
+    }
+
+    g_free(fds);
+}
+
+int net_parse_fds(const char *fds_param, int **fds, int expected_nfds,
+                  Error **errp)
+{
+    g_auto(GStrv) fdnames = g_strsplit(fds_param, ":", -1);
+    unsigned nfds = g_strv_length(fdnames);
+    int i;
+
+    if (nfds > INT_MAX) {
+        error_setg(errp, "fds parameter exceeds maximum of %d", INT_MAX);
+        return -1;
+    }
+
+    if (expected_nfds && nfds != expected_nfds) {
+        error_setg(errp, "expected %u socket fds, got %u", expected_nfds, nfds);
+        return -1;
+    }
+
+    *fds = g_new(int, nfds);
+
+    for (i = 0; i < nfds; i++) {
+        (*fds)[i] = monitor_fd_param(monitor_cur(), fdnames[i], errp);
+        if ((*fds)[i] == -1) {
+            net_free_fds(*fds, i);
+            *fds = NULL;
+            return -1;
+        }
+    }
+
+    return nfds;
+}
diff --git a/net/util.h b/net/util.h
index 288312979f..4dbc5d416d 100644
--- a/net/util.h
+++ b/net/util.h
@@ -83,4 +83,18 @@ static inline bool in6_equal_net(const struct in6_addr *a,
 
 int net_parse_macaddr(uint8_t *macaddr, const char *p);
 
+/*
+ * Close all @fds and free @fds itself
+ */
+void net_free_fds(int *fds, int nfds);
+
+/*
+ * Parse @fds_param, where monitor fds are separated by a colon.
+ * @nfds must be non-NULL. If *@nfds is zero - set it accordingly.
+ * If *@nfds is non-zero - check that we have exactly *@nfds fds
+ * and fail otherwise.
+ */
+int net_parse_fds(const char *fds_param, int **fds, int expected_nfds,
+                  Error **errp);
+
 #endif /* QEMU_NET_UTIL_H */
-- 
2.52.0


