Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBB7CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Aug 2025 11:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usgXt-0002iy-Ck; Sun, 31 Aug 2025 07:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1usgXq-0002iF-SX; Sun, 31 Aug 2025 07:48:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1usgXo-0006Eu-EF; Sun, 31 Aug 2025 07:48:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 01B4914E37C;
 Sun, 31 Aug 2025 14:47:46 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A7DFA26BA98;
 Sun, 31 Aug 2025 14:48:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	Bin Meng <bin.meng@windriver.com>
Subject: [PATCH] block: honor $TMPDIR in create_tmp_file()
Date: Sun, 31 Aug 2025 14:48:17 +0300
Message-ID: <20250831114818.4136358-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

Current code uses g_get_tmp_dir() to get temporary directory,
and if the returned *value* is "/tmp", the code changes it to
"/var/tmp".  This is wrong, - we should use "/var/tmp" only if
$TMPDIR is not set, not if it is set to some specific value.
In particular, the code doesn't let us to use TMPDIR=/tmp.

Fix this by using g_get_tmp_dir() only on windows platform as
before, and open-code $TMPDIR usage on everything else.
g_get_tmp_dir() checks $TMP and $TEMP too, but these variables
are windows-specific and should not be used on *nix.

Fixes: 69fbfff95e84 "block: Refactor get_tmp_filename()"
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1626
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 8848e9a7ed..f86fc9db35 100644
--- a/block.c
+++ b/block.c
@@ -853,8 +853,6 @@ char *create_tmp_file(Error **errp)
     const char *tmpdir;
     g_autofree char *filename = NULL;
 
-    tmpdir = g_get_tmp_dir();
-#ifndef _WIN32
     /*
      * See commit 69bef79 ("block: use /var/tmp instead of /tmp for -snapshot")
      *
@@ -862,7 +860,12 @@ char *create_tmp_file(Error **errp)
      * so the files can become very large. /tmp is often a tmpfs where as
      * /var/tmp is usually on a disk, so more appropriate for disk images.
      */
-    if (!g_strcmp0(tmpdir, "/tmp")) {
+
+#ifdef _WIN32
+    tmpdir = g_get_tmp_dir();
+#else
+    tmpdir = getenv("TMPDIR");
+    if (!tmpdir) {
         tmpdir = "/var/tmp";
     }
 #endif
-- 
2.47.2


