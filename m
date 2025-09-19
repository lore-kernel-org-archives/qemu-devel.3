Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86306CAC5A9
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzXqk-00066R-TJ; Fri, 19 Sep 2025 05:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqc-0005hv-OQ
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:11 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzXqY-0004bK-E5
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:56:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id AA15A80EEB;
 Fri, 19 Sep 2025 12:55:58 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a72::1:38])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ntP1fK1GvGk0-0NmJOvzS; Fri, 19 Sep 2025 12:55:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758275758;
 bh=IIlPANs5RbiCijmZSg5eH14iKMIBRIq618g22rPPVqE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=V+p/BvojW2sWfTCUDXhyi/5qvCgAW1nhzmc6XcE2n3MEcf5YCEQUYnTMN3OzyavcP
 JvTO3bT2DvMypmYmi2VbnBR0o3hA6uZGBZemV3kxfQuCveoZI+carxWl3VU2vrLktF
 xuAe+D5ffIzJfng9JCrJGmp4HLp3fyr3vKpoFyKU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 farosas@suse.de, peterx@redhat.com, berrange@redhat.com,
 jasowang@redhat.com, steven.sistare@oracle.com, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v5 10/19] net/tap: introduce net_tap_setup()
Date: Fri, 19 Sep 2025 12:55:36 +0300
Message-ID: <20250919095545.1912042-11-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
References: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Move most of net_init_tap_one() to net_tap_setup() - future pair
for net_tap_new(), for postponed setup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 87d851203b..b4682d7400 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -85,6 +85,10 @@ typedef struct TAPState {
     int sndbuf;
 } TAPState;
 
+static bool net_tap_setup(TAPState *s, const NetdevTapOptions *tap,
+                          const char *vhostfdname,
+                          int fd, int vnet_hdr, Error **errp);
+
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp);
 
@@ -697,11 +701,6 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              int vnet_hdr, int fd, Error **errp)
 {
     TAPState *s = net_tap_new(peer, model, name, tap);
-    int vhostfd;
-
-    if (!net_tap_set_fd(s, fd, vnet_hdr, errp)) {
-        goto failed;
-    }
 
     if (tap->fd || tap->fds) {
         qemu_set_info_str(&s->nc, "fd=%d", fd);
@@ -720,6 +719,21 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
     }
 
+    if (!net_tap_setup(s, tap, vhostfdname, fd, vnet_hdr, errp)) {
+        qemu_del_net_client(&s->nc);
+    }
+}
+
+static bool net_tap_setup(TAPState *s, const NetdevTapOptions *tap,
+                          const char *vhostfdname,
+                          int fd, int vnet_hdr, Error **errp)
+{
+    int vhostfd;
+
+    if (!net_tap_set_fd(s, fd, vnet_hdr, errp)) {
+        return false;
+    }
+
     if (tap->has_vhost ? tap->vhost :
         vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
         VhostNetOptions options;
@@ -735,23 +749,23 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         if (vhostfdname) {
             vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
             if (vhostfd == -1) {
-                goto failed;
+                return false;
             }
             if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
-                error_setg_errno(errp, errno, "%s: Can't use file descriptor %d",
-                                 name, fd);
-                goto failed;
+                error_setg_errno(errp, errno, "Can't use file descriptor %d",
+                                 fd);
+                return false;
             }
         } else {
             vhostfd = open("/dev/vhost-net", O_RDWR);
             if (vhostfd < 0) {
                 error_setg_errno(errp, errno,
                                  "tap: open vhost char device failed");
-                goto failed;
+                return false;
             }
             if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
                 error_setg_errno(errp, errno, "Failed to set FD nonblocking");
-                goto failed;
+                return false;
             }
         }
         options.opaque = (void *)(uintptr_t)vhostfd;
@@ -766,14 +780,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         if (!s->vhost_net) {
             error_setg(errp,
                        "vhost-net requested but could not be initialized");
-            goto failed;
+            return false;
         }
     }
 
-    return;
-
-failed:
-    qemu_del_net_client(&s->nc);
+    return true;
 }
 
 static int get_fds(char *str, char *fds[], int max)
-- 
2.48.1


