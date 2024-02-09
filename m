Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546EDC4829B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYLU-0007Al-Vr; Fri, 09 Feb 2024 16:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYLT-00079A-Cs; Fri, 09 Feb 2024 16:23:39 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYLR-0000Cw-T1; Fri, 09 Feb 2024 16:23:39 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2EA934BF67;
 Sat, 10 Feb 2024 00:24:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1B87F77EE1;
 Sat, 10 Feb 2024 00:22:48 +0300 (MSK)
Received: (nullmailer pid 1123184 invoked by uid 1000);
 Fri, 09 Feb 2024 21:22:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 15/23] qemu-img: resize: do not always eat last argument
Date: Sat, 10 Feb 2024 00:22:36 +0300
Message-Id: <7e0e7cb2470d572e8c0a48ba85c993be3bdb1c07.1707513011.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1707513011.git.mjt@tls.msk.ru>
References: <cover.1707513011.git.mjt@tls.msk.ru>
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

'qemu-img resize --help' does not work, since it wants more arguments.
Only eat last option at the beginning if it starts like -N.., and allow
getopt() to do its work, and eat it up at the end if not already eaten.
This will not allow to mix options and size anyway, but it is better
than now.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 69d41e0a92..929a25a021 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4271,13 +4271,13 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
 
     /* Remove size from argv manually so that negative numbers are not treated
      * as options by getopt. */
-    if (argc < 3) {
-        error_exit(ccmd, "Not enough arguments");
-        return 1;
+    if (argc > 1 && argv[argc - 1][0] == '-'
+        && argv[argc-1][1] >= '0' && argv[argc-1][1] <= '9') {
+        size = argv[--argc];
+    } else {
+        size = NULL;
     }
 
-    size = argv[--argc];
-
     /* Parse getopt arguments */
     fmt = NULL;
     for(;;) {
@@ -4329,10 +4329,13 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
             break;
         }
     }
-    if (optind != argc - 1) {
+    if (optind + 1 + (size == NULL) != argc) {
         error_exit(ccmd, "Expecting image file name and size");
     }
     filename = argv[optind++];
+    if (!size) {
+        size = argv[optind++];
+    }
 
     /* Choose grow, shrink, or absolute resize mode */
     switch (size[0]) {
-- 
2.39.2


