Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB4EC5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctzl-0003jQ-Mv; Wed, 21 Feb 2024 16:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctzN-0001Np-Nn; Wed, 21 Feb 2024 16:18:53 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctzL-00018y-Ez; Wed, 21 Feb 2024 16:18:49 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7F3AE4F803;
 Thu, 22 Feb 2024 00:16:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 370C5869BB;
 Thu, 22 Feb 2024 00:16:24 +0300 (MSK)
Received: (nullmailer pid 2335325 invoked by uid 1000);
 Wed, 21 Feb 2024 21:16:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 27/28] qemu-img: inline list of supported commands,
 remove qemu-img-cmds.h include
Date: Thu, 22 Feb 2024 00:16:08 +0300
Message-Id: <20240221211622.2335170-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708544927.git.mjt@tls.msk.ru>
References: <cover.1708544927.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

also add short description to each command and use it in --help

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index ea284dca2d..299e34e470 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -61,6 +61,7 @@
 typedef struct img_cmd_t {
     const char *name;
     int (*handler)(const struct img_cmd_t *ccmd, int argc, char **argv);
+    const char *description;
 } img_cmd_t;
 
 enum {
@@ -126,14 +127,14 @@ void cmd_help(const img_cmd_t *ccmd,
               const char *syntax, const char *arguments)
 {
     printf(
-"Usage:\n"
+"%s.  Usage:\n"
 "  %s %s %s"
 "\n"
 "Arguments:\n"
 "  -h, --help\n"
 "     print this help and exit\n"
 "%s\n",
-           "qemu-img", ccmd->name,
+           ccmd->description, "qemu-img", ccmd->name,
            syntax, arguments);
     exit(EXIT_SUCCESS);
 }
@@ -5824,10 +5825,36 @@ out:
 }
 
 static const img_cmd_t img_cmds[] = {
-#define DEF(option, callback, arg_string)        \
-    { option, callback },
-#include "qemu-img-cmds.h"
-#undef DEF
+    { "amend", img_amend,
+      "Update format-specific options of the image" },
+    { "bench", img_bench,
+      "Run simple image benchmark" },
+    { "bitmap", img_bitmap,
+      "Perform modifications of the persistent bitmap in the image" },
+    { "check", img_check,
+      "Check basic image integrity" },
+    { "commit", img_commit,
+      "Commit image to its backing file" },
+    { "compare", img_compare,
+      "Check if two images have the same contents" },
+    { "convert", img_convert,
+      "Copy one image to another with optional format conversion" },
+    { "create", img_create,
+      "Create and format new image file" },
+    { "dd", img_dd,
+      "Copy input to output with optional format conversion" },
+    { "info", img_info,
+      "Display information about image" },
+    { "map", img_map,
+      "Dump image metadata" },
+    { "measure", img_measure,
+      "Calculate file size requred for a new image" },
+    { "rebase", img_rebase,
+      "Change backing file of the image" },
+    { "resize", img_resize,
+      "Resize the image to the new size" },
+    { "snapshot", img_snapshot,
+      "List or manipulate snapshots within image" },
     { NULL, NULL, },
 };
 
@@ -5892,7 +5919,7 @@ QEMU_IMG_VERSION
 "\n"
 "Recognized commands (run qemu-img COMMAND --help for command-specific help):\n\n");
             for (cmd = img_cmds; cmd->name != NULL; cmd++) {
-                printf("  %s\n", cmd->name);
+                printf("  %s - %s\n", cmd->name, cmd->description);
             }
             printf("\nSupported image formats:\n");
             c = 99; /* force a newline */
-- 
2.39.2


