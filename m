Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD2BCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHnR-0005ul-Pc; Wed, 27 Aug 2025 11:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHir-0005xq-8P; Wed, 27 Aug 2025 11:06:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHip-0005L6-DP; Wed, 27 Aug 2025 11:06:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8371614C548;
 Wed, 27 Aug 2025 18:02:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 730F9269850;
 Wed, 27 Aug 2025 18:03:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [Stable-10.0.4 32/59] qga: correctly write to /sys/power/state on
 linux
Date: Wed, 27 Aug 2025 18:02:37 +0300
Message-ID: <20250827150323.2694101-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Commit v9.0.0-343-g2048129625 introduced usage of
g_file_set_contents() function to write to /sys/power/state.
This function uses G_FILE_SET_CONTENTS_CONSISTENT flag to
g_file_set_contents_full(), which is implemented by creating
a temp file in the same directory and renaming it to the final
destination.  Which is not how sysfs works.

Here, there's not a big deal to do open/write/close - it becomes
almost the same as using g_file_set_contents[_full]().  But it
does not have surprises like this.

Also, since this is linux code, it should be ok to use %m in
the error reporting function.

Fixes: 2048129625 "qga/commands-posix: don't do fork()/exec() when suspending via sysfs"
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3057
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20250801115316.6845-1-mjt@tls.msk.ru>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit b217d987a3c5c6e2473956723b396bc1ff0f5b2b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 9e8a934b9a..9dc0c82503 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -1400,20 +1400,22 @@ static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp)
 
 static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
 {
-    g_autoptr(GError) local_gerr = NULL;
     const char *sysfile_strs[3] = {"disk", "mem", NULL};
     const char *sysfile_str = sysfile_strs[mode];
+    int fd;
 
     if (!sysfile_str) {
         error_setg(errp, "unknown guest suspend mode");
         return;
     }
 
-    if (!g_file_set_contents(LINUX_SYS_STATE_FILE, sysfile_str,
-                             -1, &local_gerr)) {
-        error_setg(errp, "suspend: cannot write to '%s': %s",
-                   LINUX_SYS_STATE_FILE, local_gerr->message);
-        return;
+    fd = open(LINUX_SYS_STATE_FILE, O_WRONLY);
+    if (fd < 0 || write(fd, sysfile_str, strlen(sysfile_str)) < 0) {
+        error_setg(errp, "suspend: cannot write to '%s': %m",
+                   LINUX_SYS_STATE_FILE);
+    }
+    if (fd >= 0) {
+        close(fd);
     }
 }
 
-- 
2.47.2


