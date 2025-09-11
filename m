Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66214CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 16:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwkW5-00038R-6q; Thu, 11 Sep 2025 12:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwkVx-0002wv-0X
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:51:17 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uwkVq-0004AU-9L
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 12:51:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C47B980730;
 Thu, 11 Sep 2025 19:51:06 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:b3c::1:2f])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2pOVKM0Fka60-F8iLlU56; Thu, 11 Sep 2025 19:51:06 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757609466;
 bh=lDIFm/NciBS2F0gopRTcAo1Mra2x5xPBU6oXwYj0/tM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=nqcqCzIbG47ovPYUfVqm/WI9mPE+YnLvITMVd3CkZgCwVqEamu8H27fuDWTiCP1NB
 5VxReN2VeS3roMzDrK3g1B7wpT0k2Bo3Ig3BuVbCUYEqi/k8ltLC0C61Fsl1JbyiUK
 pbWvZ7P2yo5zvpX/bM34CAr+zaQpA4o7E8fA9oJs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru,
 davydov-max@yandex-team.ru
Subject: [PATCH v4 4/8] net/tap: launch_script(): add return value
Date: Thu, 11 Sep 2025 19:50:57 +0300
Message-ID: <20250911165101.1637608-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250911165101.1637608-1-vsementsov@yandex-team.ru>
References: <20250911165101.1637608-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

Follow common recommendations to avoid error propagation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 49d4a29beb..13118515b9 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -82,7 +82,7 @@ typedef struct TAPState {
     Notifier exit;
 } TAPState;
 
-static void launch_script(const char *setup_script, const char *ifname,
+static bool launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp);
 
 static void tap_send(void *opaque);
@@ -439,7 +439,7 @@ static void close_all_fds_after_fork(int excluded_fd)
     qemu_close_all_open_fd(skip_fd, nskip);
 }
 
-static void launch_script(const char *setup_script, const char *ifname,
+static bool launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp)
 {
     int pid, status;
@@ -451,8 +451,9 @@ static void launch_script(const char *setup_script, const char *ifname,
     if (pid < 0) {
         error_setg_errno(errp, errno, "could not launch network script %s",
                          setup_script);
-        return;
+        return false;
     }
+
     if (pid == 0) {
         close_all_fds_after_fork(fd);
         parg = args;
@@ -461,17 +462,20 @@ static void launch_script(const char *setup_script, const char *ifname,
         *parg = NULL;
         execv(setup_script, args);
         _exit(1);
-    } else {
-        while (waitpid(pid, &status, 0) != pid) {
-            /* loop */
-        }
+    }
 
-        if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
-            return;
-        }
-        error_setg(errp, "network script %s failed with status %d",
-                   setup_script, status);
+    while (waitpid(pid, &status, 0) != pid) {
+        /* loop */
     }
+
+    if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
+        return true;
+    }
+
+    error_setg(errp, "network script %s failed with status %d",
+               setup_script, status);
+
+    return false;
 }
 
 static int recv_fd(int c)
@@ -647,7 +651,6 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
                         const char *setup_script, char *ifname,
                         size_t ifname_sz, int mq_required, Error **errp)
 {
-    Error *err = NULL;
     int fd, vnet_hdr_required;
 
     if (tap->has_vnet_hdr) {
@@ -667,9 +670,7 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
     if (setup_script &&
         setup_script[0] != '\0' &&
         strcmp(setup_script, "no") != 0) {
-        launch_script(setup_script, ifname, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!launch_script(setup_script, ifname, fd, errp)) {
             close(fd);
             return -1;
         }
-- 
2.48.1


