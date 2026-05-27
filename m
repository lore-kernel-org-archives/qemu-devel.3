Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AC2CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 19:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSJfs-0006Zw-MP; Wed, 27 May 2026 15:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSJfg-0006Wb-Fa
 for qemu-devel@nongnu.org; Wed, 27 May 2026 15:12:05 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSJfb-0000ZZ-9H
 for qemu-devel@nongnu.org; Wed, 27 May 2026 15:12:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2925:0:640:1f39:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E64D8C047E;
 Wed, 27 May 2026 22:11:54 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id qBf3L80XU0U0-c8yOarQc; Wed, 27 May 2026 22:11:54 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779909114;
 bh=DkBQ+3UK9HWOhVq6Ht+r7CrNRq1WQFFe3oGX/Jg2oPM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=o4yTz5n5peYFm4fFSn2srnan3XnxtM+PV73/6h8yP1i0qSPAJnCCEomlb8+9owdK1
 Gxkdqw7RMxrkpUQ7eH4hPGLmdb32HX7oOeyO++xK0F/IzSjV3nXT6+fAq9JA/GoXfx
 VkZ/0rwfevh0AtX1uCXeM7IiYpwjbcVhNXxW3gIw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com
Subject: [PATCH v17 01/10] net/tap: move vhost-net open() calls to
 tap_parse_vhost_fds()
Date: Wed, 27 May 2026 22:11:40 +0300
Message-ID: <20260527191150.250333-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260527191150.250333-1-vsementsov@yandex-team.ru>
References: <20260527191150.250333-1-vsementsov@yandex-team.ru>
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

1. Simplify code path: get vhostfds for all cases in one function.

2. Prepare for further tap-fd-migraton feature, when we'll need to
postpone vhost initialization up to post-load stage.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 net/tap.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 57ffb09885c..d941c67895e 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -736,8 +736,7 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
     }
 
-    if (tap->has_vhost ? tap->vhost :
-        (vhostfd != -1) || (tap->has_vhostforce && tap->vhostforce)) {
+    if (vhostfd != -1) {
         VhostNetOptions options;
 
         options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
@@ -747,17 +746,6 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         } else {
             options.busyloop_timeout = 0;
         }
-
-        if (vhostfd == -1) {
-            vhostfd = open("/dev/vhost-net", O_RDWR);
-            if (vhostfd < 0) {
-                error_setg_file_open(errp, errno, "/dev/vhost-net");
-                goto failed;
-            }
-            if (!qemu_set_blocking(vhostfd, false, errp)) {
-                goto failed;
-            }
-        }
         options.opaque = (void *)(uintptr_t)vhostfd;
         options.nvqs = 2;
         options.feature_bits = kernel_feature_bits;
@@ -843,14 +831,31 @@ static int tap_parse_fds_and_queues(const NetdevTapOptions *tap, int **fds,
 static bool tap_parse_vhost_fds(const NetdevTapOptions *tap, int **vhost_fds,
                                 int queues, Error **errp)
 {
-    if (!(tap->vhostfd || tap->vhostfds)) {
+    bool need_vhost = tap->has_vhost ? tap->vhost :
+        ((tap->vhostfd || tap->vhostfds) ||
+         (tap->has_vhostforce && tap->vhostforce));
+
+    if (!need_vhost) {
         *vhost_fds = NULL;
         return true;
     }
 
-    if (net_parse_fds(tap->vhostfd ?: tap->vhostfds,
-                      vhost_fds, queues, errp) < 0) {
-        return false;
+    if (tap->vhostfd || tap->vhostfds) {
+        if (net_parse_fds(tap->vhostfd ?: tap->vhostfds,
+                          vhost_fds, queues, errp) < 0) {
+            return false;
+        }
+    } else {
+        *vhost_fds = g_new(int, queues);
+        for (int i = 0; i < queues; i++) {
+            int vhostfd = open("/dev/vhost-net", O_RDWR);
+            if (vhostfd < 0) {
+                error_setg_file_open(errp, errno, "/dev/vhost-net");
+                net_free_fds(*vhost_fds, i);
+                return false;
+            }
+            (*vhost_fds)[i] = vhostfd;
+        }
     }
 
     if (!unblock_fds(*vhost_fds, queues, errp)) {
-- 
2.52.0


