Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B5DCA0EE4
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 16:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upqin-0005Rh-N0; Sat, 23 Aug 2025 12:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqid-0005Oa-A9
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:52 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upqib-0000JW-0i
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 12:03:50 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 46FED806D1;
 Sat, 23 Aug 2025 19:03:37 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:c91::1:b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Q3YUrj0Gl8c0-BJ4ZPdxf; Sat, 23 Aug 2025 19:03:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755965016;
 bh=k60Q8EantLVMPvg4A/U7+0X4FHc8i8GygBsw8FNL2Kw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=1o2/mVN60qvQEf8tdvsVHo4IT02QrryHKyTKs+5yhEHXQQFlNmZgavs71aOLzCtzB
 LxzjL9xiH4xSAmY0mhRptzjtmfuHBJGUgB+VqblApUSg6h2W8Wcy9Fufrd8SlLE6qw
 XswJAww+xPE7TDeZanEKk27oSunhmWPxlo2bHw8I=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com
Subject: [PATCH v2 19/20] net/tap: drop net_tap_fd_init()
Date: Sat, 23 Aug 2025 19:03:22 +0300
Message-ID: <20250823160323.20811-20-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823160323.20811-1-vsementsov@yandex-team.ru>
References: <20250823160323.20811-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

It's called only from net_init_tap_one(), and there is no semantic
reason, why we do part of initialization in one function and continue
in another. Let's combine them into one net_tap_fd_init_common().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 97 +++++++++++++++++++++++++------------------------------
 1 file changed, 44 insertions(+), 53 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index f2c0f7fd06..08927088eb 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -88,11 +88,12 @@ static void launch_script(const char *setup_script, const char *ifname,
 static void tap_send(void *opaque);
 static void tap_writable(void *opaque);
 
-static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
-                            const char *model, const char *name,
-                            const char *ifname, const char *script,
-                            const char *downscript, const char *vhostfdname,
-                            int vnet_hdr, int fd, Error **errp);
+static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
+                                  const char *model, const char *name,
+                                  const char *ifname, const char *script,
+                                  const char *downscript,
+                                  const char *vhostfdname,
+                                  int vnet_hdr, int fd, Error **errp);
 static int net_tap_setup_vhost(TAPState *s, const NetdevTapOptions *tap,
                                const char *vhostfdname, Error **errp);
 
@@ -393,42 +394,6 @@ static NetClientInfo net_tap_info = {
     .get_vhost_net = tap_get_vhost_net,
 };
 
-static TAPState *net_tap_fd_init(NetClientState *peer,
-                                 const char *model,
-                                 const char *name,
-                                 int fd,
-                                 int vnet_hdr)
-{
-    NetClientState *nc;
-    TAPState *s;
-
-    nc = qemu_new_net_client(&net_tap_info, peer, model, name);
-
-    s = DO_UPCAST(TAPState, nc, nc);
-
-    s->fd = fd;
-    s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
-    s->using_vnet_hdr = false;
-    s->has_ufo = tap_probe_has_ufo(s->fd);
-    s->has_uso = tap_probe_has_uso(s->fd);
-    s->enabled = true;
-    tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
-    /*
-     * Make sure host header length is set correctly in tap:
-     * it might have been modified by another instance of qemu.
-     */
-    if (vnet_hdr) {
-        tap_fd_set_vnet_hdr_len(s->fd, s->host_vnet_hdr_len);
-    }
-    tap_read_poll(s, true);
-    s->vhost_net = NULL;
-
-    s->exit.notify = tap_exit_notify;
-    qemu_add_exit_notifier(&s->exit);
-
-    return s;
-}
-
 static void close_all_fds_after_fork(int excluded_fd)
 {
     const int skip_fd[] = {STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO,
@@ -651,9 +616,9 @@ static int net_tap_fd_init_external(const Netdev *netdev, NetClientState *peer,
         }
     }
 
-    return net_init_tap_one(netdev, peer, model, name,
-                            NULL, NULL, NULL,
-                            vhostfdname, vnet_hdr, fd, errp);
+    return net_tap_fd_init_common(netdev, peer, model, name,
+                                  NULL, NULL, NULL,
+                                  vhostfdname, vnet_hdr, fd, errp);
 }
 
 int net_init_bridge(const Netdev *netdev, const char *name,
@@ -723,9 +688,9 @@ static int net_tap_open_one(const Netdev *netdev,
         }
     }
 
-    ret = net_init_tap_one(netdev, peer, "tap", name, ifname,
-                           script, downscript,
-                           tap->vhostfd, vnet_hdr, fd, errp);
+    ret = net_tap_fd_init_common(netdev, peer, "tap", name, ifname,
+                                 script, downscript,
+                                 tap->vhostfd, vnet_hdr, fd, errp);
     if (ret < 0) {
         close(fd);
         return -1;
@@ -736,15 +701,41 @@ static int net_tap_open_one(const Netdev *netdev,
 
 #define MAX_TAP_QUEUES 1024
 
-static int net_init_tap_one(const Netdev *netdev, NetClientState *peer,
-                            const char *model, const char *name,
-                            const char *ifname, const char *script,
-                            const char *downscript, const char *vhostfdname,
-                            int vnet_hdr, int fd, Error **errp)
+static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
+                                  const char *model, const char *name,
+                                  const char *ifname, const char *script,
+                                  const char *downscript,
+                                  const char *vhostfdname,
+                                  int vnet_hdr, int fd, Error **errp)
 {
     const NetdevTapOptions *tap;
-    TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
     int ret;
+    NetClientState *nc;
+    TAPState *s;
+
+    nc = qemu_new_net_client(&net_tap_info, peer, model, name);
+
+    s = DO_UPCAST(TAPState, nc, nc);
+
+    s->fd = fd;
+    s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
+    s->using_vnet_hdr = false;
+    s->has_ufo = tap_probe_has_ufo(s->fd);
+    s->has_uso = tap_probe_has_uso(s->fd);
+    s->enabled = true;
+    tap_set_offload(&s->nc, 0, 0, 0, 0, 0, 0, 0);
+    /*
+     * Make sure host header length is set correctly in tap:
+     * it might have been modified by another instance of qemu.
+     */
+    if (vnet_hdr) {
+        tap_fd_set_vnet_hdr_len(s->fd, s->host_vnet_hdr_len);
+    }
+    tap_read_poll(s, true);
+    s->vhost_net = NULL;
+
+    s->exit.notify = tap_exit_notify;
+    qemu_add_exit_notifier(&s->exit);
 
     if (netdev->type == NET_CLIENT_DRIVER_BRIDGE) {
         const NetdevBridgeOptions *bridge = &netdev->u.bridge;
-- 
2.48.1


