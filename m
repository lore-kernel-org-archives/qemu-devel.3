Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7EECA0EFA
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Aug 2025 21:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upw6F-0004VY-0O; Sat, 23 Aug 2025 17:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upw6D-0004Uo-Sv
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 17:48:33 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1upw6A-00054Q-IA
 for qemu-devel@nongnu.org; Sat, 23 Aug 2025 17:48:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7CA2C80818;
 Sun, 24 Aug 2025 00:48:28 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a5d::1:36])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Nmd3dr0GuSw0-FxGAKwFt; Sun, 24 Aug 2025 00:48:28 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755985708;
 bh=zKfF0Jr3ZNXBdyUSBJ7GUqENZhLe0Y59SMSSlwzFldU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=vBluVYAEm0HRd3eXs6En1RH0DMWTRMwRzrW7pYAxQShntPNs2wB6Hl7UIFZkGD2el
 StC9W1J51ZhHdPiGqQsSCbeiSR+vYP+MMJt15m5AdBPP4yYxz6Zwr2eUdOckcaQB/5
 PwdK9FenW0WfZIULajAYlXRyk78RP07xahhNba/8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, peterx@redhat.com, mst@redhat.com,
 farosas@suse.de, yc-core@yandex-team.ru
Subject: [RFC 6/7] net/tap: experimental support for vhost in local tap
 migration
Date: Sun, 24 Aug 2025 00:48:20 +0300
Message-ID: <20250823214821.48342-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250823214821.48342-1-vsementsov@yandex-team.ru>
References: <20250823214821.48342-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Just reinitialize vhost after getting the fd on target.
This significantly increase downtime (0.03s -> 0.06s in my
simple testing). So next step is to rework it, completely migrating
the vhost state to the new qemu without reinitialization.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 4d3cdc0662..7a4de07025 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -84,6 +84,9 @@ typedef struct TAPState {
     unsigned host_vnet_hdr_len;
     Notifier exit;
     bool local_incoming;
+    bool need_vhost;
+    char *vhost_fdname;
+    uint32_t vhost_busyloop_timeout;
 } TAPState;
 
 static void launch_script(const char *setup_script, const char *ifname,
@@ -98,8 +101,7 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
                                   const char *downscript,
                                   const char *vhostfdname,
                                   int vnet_hdr, int fd, Error **errp);
-static int net_tap_setup_vhost(TAPState *s, const NetdevTapOptions *tap,
-                               const char *vhostfdname, Error **errp);
+static int net_tap_setup_vhost(TAPState *s, Error **errp);
 
 static void tap_update_fd_handler(TAPState *s)
 {
@@ -384,6 +386,7 @@ static void tap_cleanup(NetClientState *nc)
         g_free(s->vhost_net);
         s->vhost_net = NULL;
     }
+    g_free(s->vhost_fdname);
 
     qemu_purge_queued_packets(nc);
 
@@ -794,10 +797,8 @@ int tap_load(NetClientState *nc, QEMUFile *f)
     qemu_get_be32s(f, &s->host_vnet_hdr_len);
 
     tap_read_poll(s, true);
-    s->exit.notify = tap_exit_notify;
-    qemu_add_exit_notifier(&s->exit);
 
-    return 0;
+    return net_tap_setup_vhost(s, NULL);
 }
 
 static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
@@ -874,8 +875,12 @@ static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
         }
     }
 
+    s->need_vhost = tap->has_vhost ? tap->vhost :
+        vhostfdname || (tap->has_vhostforce && tap->vhostforce);
+    s->vhost_fdname = g_strdup(vhostfdname);
+    s->vhost_busyloop_timeout = tap->has_poll_us ? tap->poll_us : 0;
     if (!local_incoming) {
-        ret = net_tap_setup_vhost(s, tap, vhostfdname, errp);
+        ret = net_tap_setup_vhost(s, errp);
         if (ret < 0) {
             goto failed;
         }
@@ -888,28 +893,22 @@ failed:
     return -1;
 }
 
-static int net_tap_setup_vhost(TAPState *s, const NetdevTapOptions *tap,
-                               const char *vhostfdname, Error **errp)
+static int net_tap_setup_vhost(TAPState *s, Error **errp)
 {
-    if (tap->has_vhost ? tap->vhost :
-        vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
+    if (s->need_vhost) {
         VhostNetOptions options;
         int vhostfd;
 
         options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
         options.net_backend = &s->nc;
-        if (tap->has_poll_us) {
-            options.busyloop_timeout = tap->poll_us;
-        } else {
-            options.busyloop_timeout = 0;
-        }
+        options.busyloop_timeout = s->vhost_busyloop_timeout;
 
-        if (vhostfdname) {
-            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
+        if (s->vhost_fdname) {
+            vhostfd = monitor_fd_param(monitor_cur(), s->vhost_fdname, errp);
             if (vhostfd == -1) {
                 return -1;
             }
-            if (!set_fd_nonblocking(vhostfd, vhostfdname, errp)) {
+            if (!set_fd_nonblocking(vhostfd, s->vhost_fdname, errp)) {
                 return -1;
             }
         } else {
-- 
2.48.1


