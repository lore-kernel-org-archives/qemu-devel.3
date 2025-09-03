Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C138CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utmw3-00061Q-LJ; Wed, 03 Sep 2025 08:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvt-0005us-Df
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:50 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utmvq-0000lp-H9
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:49:49 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id CE202C018E;
 Wed, 03 Sep 2025 15:49:41 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id anf8gZ3GnW20-IQx8gFWS; Wed, 03 Sep 2025 15:49:41 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756903781;
 bh=FZvAZvYWMrzkrgCQAZGPX1Zwn7CYwj80wz3CxZgDdzM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=KCUsfGpilWKtqL2L3Kt10RVh+iSGZR7d0puiX+zAGUicvOIkjEaKRbPozsvTJ/DPO
 3llvBy0rusS/OPMXEbDw30/DmM1QXAtd9pAPYhq7mh9XFW3l25M1Mn5NnfkeINEwKg
 vmUly+cYLP/5rWr999Y7SfWfLBzJ1II3XuQ3g2jQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru
Subject: [PATCH v3 08/19] net/tap: use glib strings vector and g_strsplit for
 fds case
Date: Wed,  3 Sep 2025 15:49:22 +0300
Message-ID: <20250903124934.1169899-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
References: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/tap.c | 72 +++++++++++--------------------------------------------
 1 file changed, 14 insertions(+), 58 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index a1a315a9f0..cfa4ccc651 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -761,32 +761,6 @@ failed:
     return -1;
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
@@ -846,74 +820,56 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
     } else if (tap->fds) {
-        char **fds;
-        char **vhost_fds;
-        int nfds = 0, nvhosts = 0;
+        g_auto(GStrv) fds = NULL;
+        g_auto(GStrv) vhost_fds = NULL;
+        int nfds;
 
         if (tap->helper || tap->vhostfd) {
             error_setg(errp, "helper= and vhostfd= are invalid with fds=");
             return -1;
         }
 
-        fds = g_new0(char *, MAX_TAP_QUEUES);
-        vhost_fds = g_new0(char *, MAX_TAP_QUEUES);
+        fds = g_strsplit(tap->fds, ":", MAX_TAP_QUEUES);
+        nfds = g_strv_length(fds);
 
-        nfds = get_fds(tap->fds, fds, MAX_TAP_QUEUES);
         if (tap->vhostfds) {
-            nvhosts = get_fds(tap->vhostfds, vhost_fds, MAX_TAP_QUEUES);
-            if (nfds != nvhosts) {
+            vhost_fds = g_strsplit(tap->vhostfds, ":", MAX_TAP_QUEUES);
+            if (nfds != g_strv_length(vhost_fds)) {
                 error_setg(errp, "The number of fds passed does not match "
                            "the number of vhostfds passed");
-                ret = -1;
-                goto free_fail;
+                return -1;
             }
         }
 
         for (i = 0; i < nfds; i++) {
             fd = monitor_fd_param(monitor_cur(), fds[i], errp);
             if (fd == -1) {
-                ret = -1;
-                goto free_fail;
+                return -1;
             }
 
             if (!qemu_set_blocking(fd, false, errp)) {
-                ret = -1;
-                goto free_fail;
+                return -1;
             }
 
             if (i == 0) {
                 vnet_hdr = tap_probe_vnet_hdr(fd, errp);
                 if (vnet_hdr < 0) {
-                    ret = -1;
-                    goto free_fail;
+                    return -1;
                 }
             } else if (vnet_hdr != tap_probe_vnet_hdr(fd, NULL)) {
                 error_setg(errp,
                            "vnet_hdr not consistent across given tap fds");
-                ret = -1;
-                goto free_fail;
+                return -1;
             }
 
             ret = net_init_tap_one(tap, peer, "tap", name, NULL,
                                    NULL, NULL,
-                                   tap->vhostfds ? vhost_fds[i] : NULL,
+                                   vhost_fds ? vhost_fds[i] : NULL,
                                    vnet_hdr, fd, errp);
             if (ret < 0) {
-                ret = -1;
-                goto free_fail;
+                return -1;
             }
         }
-
-free_fail:
-        for (i = 0; i < nvhosts; i++) {
-            g_free(vhost_fds[i]);
-        }
-        for (i = 0; i < nfds; i++) {
-            g_free(fds[i]);
-        }
-        g_free(fds);
-        g_free(vhost_fds);
-        return ret;
     } else if (tap->helper) {
         if (tap->vhostfds) {
             error_setg(errp, "vhostfds= is invalid with helper=");
-- 
2.48.1


