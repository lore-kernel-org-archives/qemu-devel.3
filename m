Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7A3CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 14:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo0Vn-0001Lt-SY; Mon, 18 Aug 2025 10:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vl-0001Jv-3x
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:57 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uo0Vh-0002B6-Fu
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 10:06:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 31DD2807B5;
 Mon, 18 Aug 2025 17:06:48 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b25::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id k6RC4003YeA0-1X2frNWW; Mon, 18 Aug 2025 17:06:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755526007;
 bh=XZ907GoTMSukCC5aa7hwWOOYOieaiLj2RzPVyep6PXA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Pe7PIoEh3unIECyzf7qdc3vzDM1IrZegliZ471idyqg+AFh6dRd0I8g35UeIFfcK8
 d5MEpf1cKQCfxRxi/vzU197ohAO+s3OM86le/07W2CHPXlOCGqO0D0Q4vdHjbMdLWg
 +CETGl1+rv0U5cOCTkKddVnpeLAw4K5tsDQNbhiQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru
Subject: [PATCH 02/19] net/tap: add set_fd_nonblocking() helper
Date: Mon, 18 Aug 2025 17:06:28 +0300
Message-ID: <20250818140645.27904-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250818140645.27904-1-vsementsov@yandex-team.ru>
References: <20250818140645.27904-1-vsementsov@yandex-team.ru>
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 531ef75e91..ba2731ee8a 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -609,6 +609,18 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
     }
 }
 
+static bool set_fd_nonblocking(int fd, const char *note, Error **errp)
+{
+    bool ok = g_unix_set_fd_nonblocking(fd, true, NULL);
+
+    if (!ok) {
+        error_setg_errno(errp, errno, "Failed to set fd %d (%s) nonblocking",
+                         fd, note);
+    }
+
+    return ok;
+}
+
 int net_init_bridge(const Netdev *netdev, const char *name,
                     NetClientState *peer, Error **errp)
 {
@@ -627,10 +639,10 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    if (!g_unix_set_fd_nonblocking(fd, true, NULL)) {
-        error_setg_errno(errp, errno, "Failed to set FD nonblocking");
+    if (!set_fd_nonblocking(fd, name, errp)) {
         return -1;
     }
+
     vnet_hdr = tap_probe_vnet_hdr(fd, errp);
     if (vnet_hdr < 0) {
         close(fd);
@@ -729,9 +741,7 @@ static int net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                 error_propagate(errp, err);
                 goto failed;
             }
-            if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
-                error_setg_errno(errp, errno, "%s: Can't use file descriptor %d",
-                                 name, fd);
+            if (!set_fd_nonblocking(vhostfd, vhostfdname, errp)) {
                 goto failed;
             }
         } else {
@@ -741,8 +751,7 @@ static int net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                                  "tap: open vhost char device failed");
                 goto failed;
             }
-            if (!g_unix_set_fd_nonblocking(vhostfd, true, NULL)) {
-                error_setg_errno(errp, errno, "Failed to set FD nonblocking");
+            if (!set_fd_nonblocking(vhostfd, "opened /dev/vhost-net", errp)) {
                 goto failed;
             }
         }
@@ -839,9 +848,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        if (!g_unix_set_fd_nonblocking(fd, true, NULL)) {
-            error_setg_errno(errp, errno, "%s: Can't use file descriptor %d",
-                             name, fd);
+        if (!set_fd_nonblocking(fd, tap->fd, errp)) {
             close(fd);
             return -1;
         }
@@ -893,10 +900,8 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            if (!g_unix_set_fd_nonblocking(fd, true, NULL)) {
+            if (!set_fd_nonblocking(fd, fds[i], errp)) {
                 ret = -1;
-                error_setg_errno(errp, errno, "%s: Can't use file descriptor %d",
-                                 name, fd);
                 goto free_fail;
             }
 
@@ -948,8 +953,7 @@ free_fail:
             return -1;
         }
 
-        if (!g_unix_set_fd_nonblocking(fd, true, NULL)) {
-            error_setg_errno(errp, errno, "Failed to set FD nonblocking");
+        if (!set_fd_nonblocking(fd, name, errp)) {
             return -1;
         }
         vnet_hdr = tap_probe_vnet_hdr(fd, errp);
-- 
2.48.1


