Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0222AC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 14:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNZ1l-0006q2-Jc; Sat, 29 Jun 2024 10:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sNZ1j-0006pJ-Vw; Sat, 29 Jun 2024 10:26:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sNZ1h-0004MF-T0; Sat, 29 Jun 2024 10:26:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1A9FF7540A;
 Sat, 29 Jun 2024 17:25:55 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 40A04F9C61;
 Sat, 29 Jun 2024 17:26:00 +0300 (MSK)
Received: (nullmailer pid 1088710 invoked by uid 1000);
 Sat, 29 Jun 2024 14:26:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, qemu-trivial@nongnu.org
Subject: [PATCH] block/curl: rewrite http header parsing function
Date: Sat, 29 Jun 2024 17:25:42 +0300
Message-Id: <20240629142542.1086076-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Existing code was long, unclear and twisty.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block/curl.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 419f7c89ef..9802d0319d 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -210,37 +210,29 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 {
     BDRVCURLState *s = opaque;
     size_t realsize = size * nmemb;
-    const char *header = (char *)ptr;
-    const char *end = header + realsize;
-    const char *accept_ranges = "accept-ranges:";
-    const char *bytes = "bytes";
+    const char *p = ptr;
+    const char *end = p + realsize;
+    const char *t = "accept-ranges : bytes "; /* A lowercase template */
 
-    if (realsize >= strlen(accept_ranges)
-        && g_ascii_strncasecmp(header, accept_ranges,
-                               strlen(accept_ranges)) == 0) {
-
-        char *p = strchr(header, ':') + 1;
-
-        /* Skip whitespace between the header name and value. */
-        while (p < end && *p && g_ascii_isspace(*p)) {
-            p++;
-        }
-
-        if (end - p >= strlen(bytes)
-            && strncmp(p, bytes, strlen(bytes)) == 0) {
-
-            /* Check that there is nothing but whitespace after the value. */
-            p += strlen(bytes);
-            while (p < end && *p && g_ascii_isspace(*p)) {
-                p++;
-            }
-
-            if (p == end || !*p) {
-                s->accept_range = true;
+    /* check if header matches the "t" template */
+    for (;;) {
+        if (*t == ' ') { /* space in t matches any amount of isspace in p */
+            if (p < end && g_ascii_isspace(*p)) {
+                ++p;
+            } else {
+                ++t;
             }
+        } else if (*t && p < end && *t == g_ascii_tolower(*p)) {
+            ++p, ++t;
+        } else {
+            break;
         }
     }
 
+    if (!*t && p == end) { /* if we managed to reach ends of both strings */
+        s->accept_range = true;
+    }
+
     return realsize;
 }
 
-- 
2.39.2


