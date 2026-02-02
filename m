Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F367E7FDC8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzua-0001WO-85; Mon, 02 Feb 2026 14:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmztw-0000tl-7i; Mon, 02 Feb 2026 14:48:05 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmztt-0003Gc-Vh; Mon, 02 Feb 2026 14:47:59 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C377F1850A3;
 Mon, 02 Feb 2026 22:46:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 72C4835B285;
 Mon, 02 Feb 2026 22:46:45 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 17/69] tests/vhost-user-bridge.c: Fix const qualifier
 build errors with recent glibc
Date: Mon,  2 Feb 2026 22:45:40 +0300
Message-ID: <20260202194638.939438-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Cédric Le Goater <clg@redhat.com>

A recent change in glibc 2.42.9000 [1] changes the return type of
strstr() and other string functions to be 'const char *' when the
input is a 'const char *'. This breaks the build in :

../tests/vhost-user-bridge.c: In function ‘vubr_parse_host_port’:
../tests/vhost-user-bridge.c:749:15: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  749 |     char *p = strchr(buf, ':');
      |               ^~~~~~

Fix this by using the glib g_strsplit() routine instead of strdup().

[1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Yodel Eldar <yodel.eldar@yodel.dev>
Tested-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251215101937.281722-3-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit e37a0d514a17a660434ea20c0dd84bc6c20ca517)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index a5c711b1de..ce4c3426d3 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -746,14 +746,12 @@ vubr_run(VubrDev *dev)
 static int
 vubr_parse_host_port(const char **host, const char **port, const char *buf)
 {
-    char *p = strchr(buf, ':');
-
-    if (!p) {
+    g_auto(GStrv) tokens = g_strsplit(buf, ":", 2);
+    if (!tokens[0] || !tokens[1]) {
         return -1;
     }
-    *p = '\0';
-    *host = strdup(buf);
-    *port = strdup(p + 1);
+    *host = g_steal_pointer(&tokens[0]);
+    *port = g_steal_pointer(&tokens[1]);
     return 0;
 }
 
-- 
2.47.3


