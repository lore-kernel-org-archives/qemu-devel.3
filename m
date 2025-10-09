Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B074DCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 13:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6qTY-0005p8-0i; Thu, 09 Oct 2025 09:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maochenxi@bosc.ac.cn>)
 id 1v6kn6-00059y-Kl; Thu, 09 Oct 2025 03:10:20 -0400
Received: from [115.124.28.115] (helo=out28-115.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maochenxi@bosc.ac.cn>)
 id 1v6kmq-0007BN-Tk; Thu, 09 Oct 2025 03:10:19 -0400
Received: from localhost.localdomain(mailfrom:maochenxi@bosc.ac.cn
 fp:SMTPD_---.evvMBKR_1759993219 cluster:ay29) by smtp.aliyun-inc.com;
 Thu, 09 Oct 2025 15:00:20 +0800
From: Chenxi Mao <maochenxi@bosc.ac.cn>
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Chenxi Mao <maochenxi@bosc.ac.cn>
Subject: [PATCH v1] Fix build break when LTO is enabled
Date: Thu,  9 Oct 2025 15:00:10 +0800
Message-ID: <20251009070010.1863345-1-maochenxi@bosc.ac.cn>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.115 (deferred)
Received-SPF: pass client-ip=115.124.28.115; envelope-from=maochenxi@bosc.ac.cn;
 helo=out28-115.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, T_SPF_HELO_TEMPERROR=0.01, T_SPF_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Oct 2025 09:14:29 -0400
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

QEMU build fails when LTO is enabled:
../configure --target-list=riscv64-softmmu --enable-lto
make

Several errors occur due to incorrect curl_easy_setopt usage:

../contrib/elf2dmp/download.c:30:16: error: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Werror=attribute-warning]
   30 |             || curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1) != CURLE_OK
      |                ^
lto1: all warnings being treated as errors
../block/curl.c: In function ‘curl_open’:
../block/curl.c:806:9: error: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Werror=attribute-warning]
  806 |     if (curl_easy_setopt(state->curl, CURLOPT_NOBODY, 1) ||
      |         ^
lto1: all warnings being treated as errors

The third parameter of curl_easy_setopt should be of long type.
Change integer constants to long by adding 'L' suffix.

After this change, build passes and runs without errors.

Signed-off-by: Chenxi Mao <maochenxi@bosc.ac.cn>
---
 block/curl.c               | 12 ++++++------
 contrib/elf2dmp/download.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index e0f98e035a..d7d93d967f 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -471,11 +471,11 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
                              (void *)curl_read_cb) ||
             curl_easy_setopt(state->curl, CURLOPT_WRITEDATA, (void *)state) ||
             curl_easy_setopt(state->curl, CURLOPT_PRIVATE, (void *)state) ||
-            curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1) ||
-            curl_easy_setopt(state->curl, CURLOPT_FOLLOWLOCATION, 1) ||
-            curl_easy_setopt(state->curl, CURLOPT_NOSIGNAL, 1) ||
+            curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1L) ||
+            curl_easy_setopt(state->curl, CURLOPT_FOLLOWLOCATION, 1L) ||
+            curl_easy_setopt(state->curl, CURLOPT_NOSIGNAL, 1L) ||
             curl_easy_setopt(state->curl, CURLOPT_ERRORBUFFER, state->errmsg) ||
-            curl_easy_setopt(state->curl, CURLOPT_FAILONERROR, 1)) {
+            curl_easy_setopt(state->curl, CURLOPT_FAILONERROR, 1L)) {
             goto err;
         }
         if (s->username) {
@@ -524,7 +524,7 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
 #endif
 
 #ifdef DEBUG_VERBOSE
-        if (curl_easy_setopt(state->curl, CURLOPT_VERBOSE, 1)) {
+        if (curl_easy_setopt(state->curl, CURLOPT_VERBOSE, 1L)) {
             goto err;
         }
 #endif
@@ -800,7 +800,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->accept_range = false;
-    if (curl_easy_setopt(state->curl, CURLOPT_NOBODY, 1) ||
+    if (curl_easy_setopt(state->curl, CURLOPT_NOBODY, 1L) ||
         curl_easy_setopt(state->curl, CURLOPT_HEADERFUNCTION, curl_header_cb) ||
         curl_easy_setopt(state->curl, CURLOPT_HEADERDATA, s)) {
         pstrcpy(state->errmsg, CURL_ERROR_SIZE,
diff --git a/contrib/elf2dmp/download.c b/contrib/elf2dmp/download.c
index 21306b3fd4..fa8da0f9a2 100644
--- a/contrib/elf2dmp/download.c
+++ b/contrib/elf2dmp/download.c
@@ -27,8 +27,8 @@ bool download_url(const char *name, const char *url)
     if (curl_easy_setopt(curl, CURLOPT_URL, url) != CURLE_OK
             || curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, NULL) != CURLE_OK
             || curl_easy_setopt(curl, CURLOPT_WRITEDATA, file) != CURLE_OK
-            || curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1) != CURLE_OK
-            || curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0) != CURLE_OK
+            || curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L) != CURLE_OK
+            || curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0L) != CURLE_OK
             || curl_easy_perform(curl) != CURLE_OK) {
         unlink(name);
         fclose(file);
-- 
2.47.3


