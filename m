Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BF9CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91SZ-0005VX-Dh; Wed, 15 Oct 2025 09:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91SH-0005L5-2e
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:16 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91S4-000347-B5
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:11 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 013B288ADA;
 Wed, 15 Oct 2025 16:21:50 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bLQ5oq0N5Os0-LKdf4lUi; Wed, 15 Oct 2025 16:21:49 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760534509;
 bh=bQt+gPOuzNBNYHmDfV4+WMNfu6qlQ2YEWlgC+gNksfY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=pDtaH8UPBuwdkiVwPvzFZ4ozBKUXWg6JbudhGqdKkhMOP1q+LPNAuo0/y3V0VIz8t
 BlEEj7wxeE3eOOyRFfddFbuHEKjFIyrkiyIOhRXv++bDYqxzrUaMi1Mp8as3IN0Fc1
 43iEacFCZp/w8Qn8qEbp+VBecnkrL4EoUcC50Md4=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, sw@weilnetz.de, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v8 11/19] net/tap: introduce net_tap_setup()
Date: Wed, 15 Oct 2025 16:21:27 +0300
Message-ID: <20251015132136.1083972-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
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
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index b5ac856a3d..b01cd4d6c2 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -88,6 +88,10 @@ typedef struct TAPState {
     int sndbuf;
 } TAPState;
 
+static bool net_tap_setup(TAPState *s, const NetdevTapOptions *tap,
+                          const char *vhostfdname,
+                          int fd, int vnet_hdr, Error **errp);
+
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp);
 
@@ -723,11 +727,6 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
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
@@ -746,6 +745,21 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
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
@@ -761,20 +775,20 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         if (vhostfdname) {
             vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
             if (vhostfd == -1) {
-                goto failed;
+                return false;
             }
             if (!qemu_set_blocking(vhostfd, false, errp)) {
-                goto failed;
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
             if (!qemu_set_blocking(vhostfd, false, errp)) {
-                goto failed;
+                return false;
             }
         }
         options.opaque = (void *)(uintptr_t)vhostfd;
@@ -789,14 +803,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
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


