Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEB2CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpIY-0005ur-Ty; Fri, 29 May 2026 00:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIW-0005tV-M0
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIU-00089C-Jd
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lXBpO/M4FGwucGl9YxH11gyjZXTSpbMqtOVX+sjCIEQ=;
 b=XoCWFU0RemxvdUqj0spLXOpaHryXr19w5ngVWhQVtG/3FrfbI6Z9+8WmB7INLS5DjsYhpS
 6suD6IAZFF7CL426LDiR9KkA8dvloKGoLel2z93FG2YTmEwNnrVuSItASj8v1xNe+w980m
 W1oDxsMEl/WKGrYg4mW9118h+e9K8QM=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-Mifx91fzPG-iJVU_ay_mHQ-1; Fri, 29 May 2026 00:58:12 -0400
X-MC-Unique: Mifx91fzPG-iJVU_ay_mHQ-1
X-Mimecast-MFC-AGG-ID: Mifx91fzPG-iJVU_ay_mHQ_1780030691
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304d8613efbso1750970eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030691; x=1780635491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXBpO/M4FGwucGl9YxH11gyjZXTSpbMqtOVX+sjCIEQ=;
 b=J9iYcEED/PGGvJoHpBshvGWALeqYa2KsKCjmw3sGV9EayLRt52RSzDS57T4T+njoK0
 qJKqOzWJnK0taILKfyqUQN9UQ6sLIrPM37JC8FTuhMbqz3NKBE4rj0bk5xfDrxKGRmlm
 VvD46S24CAqWLus8xWNyUZUxpBxlXYE6MrB2ooVHjXKRh+iayLFenes9Rr6G+qu6LZhd
 UP3s4MLJuUCeD7Vh65KYq0oFbmSQoKQnA56cxdk+FVks98W6gFjSe3diNfhkKHkRrE40
 bUTqQCdzc5mE7EUQvsyY3zkNeMkWrfS1ObGZtDk7surMrWBRDWucgtYVDxyodIwLAvBj
 jANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030691; x=1780635491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lXBpO/M4FGwucGl9YxH11gyjZXTSpbMqtOVX+sjCIEQ=;
 b=aPdM/RWjkfId5SiQTbM/TqRUk0ta7xmM1CLgat7YgGakLeEmkS94YCHoU/vN40a/qu
 ULiAXVuabdAMT61n/C0C1T4FgdLh/WvQa4/41wN92vGnxpdCdwRZLulZG7vJci3Pk2BQ
 UYE1kiogfgJvdNWyn/I/cxjVuCZa3jLWag0r6fc86sKS9tSu+jKvPyEvSXqn71vv3PFm
 1mbhHBl0CE419ngnGjPAa9MNxs8TRE3sjXhcNyKxWqdARxT1t5QjHnkxse6o3jkcZhbc
 qCut+VsRwVq8VgkWQO5ppOkGjIZ3CV8NEw2O493cN/1q3V5SlWKvQbr10YLeXmThRyra
 3bsQ==
X-Gm-Message-State: AOJu0Ywdtem7nSdLUbi4DeNMQ1FX/zxMtLvqdGRw6C82PM0rfSI9u3O4
 NothgLN4EooM3AdJTDmvkc/wJP9hV7WT4WT0egKYxd32emf/tX3s4D2eOg+dt5U1tMbgZBXDYIm
 9xON/PsqNpuZE2/z7TS22pxLF2VHkzhb55PCXRUJTDZ03g1i/ET+S+MreXSrIZytz822k9OieZ3
 QYOxhv67A8bwf8KbvZ0KTYAOmqsAGyHKv0+spf6MgvDTY=
X-Gm-Gg: Acq92OHDI8Q9ayDI92po8g46avNkFpuVLgeglr+FR7XALuWsGln3qoVdm2tUM5bbu/Q
 bFxU8V3TTzDrlqJzUi7qTbTTQq0808oaYTis6foWHge2eK+nCsOtmmYqgICaHe5o1qd6VIIi7xm
 Jm9yfAfEXaJ2J07T6JJqa5NVg5rHaeBcE4tmIFnIil6qiJsqGLv86gsMPzbI0FXzS/sL91nXDhF
 epvi/qYXtnd8D8o1mWUhjSvEhBsaPhSzzmu+LXsGlcLw3//qcroQwmHqlPTxJnywFkZ0gid90or
 j8HqCqoSIZn0gSRqaaUUFFiSpij7L8qlL0xkn5qaxgPvf49ocKM42PApJBzi9VFpsH1e22VVb0N
 2jA3maTb8D0/A73XGhvL1798XMAxXhI/lYyy+6BtfaYOJ8POK76mhh7wHmoILcswBtH7/9gJ8
X-Received: by 2002:a05:7300:a286:b0:304:8361:a87e with SMTP id
 5a478bee46e88-304eb25db22mr597470eec.33.1780030691020; 
 Thu, 28 May 2026 21:58:11 -0700 (PDT)
X-Received: by 2002:a05:7300:a286:b0:304:8361:a87e with SMTP id
 5a478bee46e88-304eb25db22mr597447eec.33.1780030690292; 
 Thu, 28 May 2026 21:58:10 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.58.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:58:09 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 08/15] net: introduce net_parse_fds()
Date: Fri, 29 May 2026 12:57:23 +0800
Message-ID: <20260529045730.90322-9-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529045730.90322-1-jasowang@redhat.com>
References: <20260529045730.90322-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Add common net_parse_fds() and net_free_fds() helpers and use them
in tap.c and af-xdp.c.

Choose returning queues instead of fds, because we'll have derived
helper in net/tap, which will be able to return fds=NULL and non-zero
queues on success. That's also why we move to INT_MAX for queues, to
support negative return value for net_parse_fds() (for failure paths).

Note that redundant restriction of MAX_TAP_QUEUES is dropped for tap.c

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
2.54.0


