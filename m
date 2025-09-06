Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BD9CA1002
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 21:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uv04b-0004kl-Oq; Sat, 06 Sep 2025 17:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv04Y-0004gU-N9; Sat, 06 Sep 2025 17:03:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uv04L-0006DK-Cv; Sat, 06 Sep 2025 17:03:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0FCFE150F90;
 Sun, 07 Sep 2025 00:00:56 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C88A7278698;
 Sun,  7 Sep 2025 00:00:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-stable@qemu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [Stable-7.2.20 34/34] block/curl: fix curl internal handles handling
Date: Sun,  7 Sep 2025 00:00:54 +0300
Message-ID: <20250906210056.127031-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
References: <qemu-stable-7.2.20-20250906235950@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

block/curl.c uses CURLMOPT_SOCKETFUNCTION to register a socket callback.
According to the documentation, this callback is called not just with
application-created sockets but also with internal curl sockets, - and
for such sockets, user data pointer is not set by the application, so
the result qemu crashing.

Pass BDRVCURLState directly to the callback function as user pointer,
instead of relying on CURLINFO_PRIVATE.

This problem started happening with update of libcurl from 8.9 to 8.10 --
apparently with this change curl started using private handles more.

(CURLINFO_PRIVATE is used in one more place, in curl_multi_check_completion() -
it might need a similar fix too)

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3081
Cc: qemu-stable@qemu.org
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 606978500c3d18fb89a49844f253097b17f757de)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/curl.c b/block/curl.c
index 0b125095e3..f9c5a1c182 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -161,13 +161,9 @@ static int curl_timer_cb(CURLM *multi, long timeout_ms, void *opaque)
 static int curl_sock_cb(CURL *curl, curl_socket_t fd, int action,
                         void *userp, void *sp)
 {
-    BDRVCURLState *s;
-    CURLState *state = NULL;
+    BDRVCURLState *s = userp;
     CURLSocket *socket;
 
-    curl_easy_getinfo(curl, CURLINFO_PRIVATE, (char **)&state);
-    s = state->s;
-
     socket = g_hash_table_lookup(s->sockets, GINT_TO_POINTER(fd));
     if (!socket) {
         socket = g_new0(CURLSocket, 1);
@@ -612,6 +608,7 @@ static void curl_attach_aio_context(BlockDriverState *bs,
     assert(!s->multi);
     s->multi = curl_multi_init();
     s->aio_context = new_context;
+    curl_multi_setopt(s->multi, CURLMOPT_SOCKETDATA, s);
     curl_multi_setopt(s->multi, CURLMOPT_SOCKETFUNCTION, curl_sock_cb);
     curl_multi_setopt(s->multi, CURLMOPT_TIMERDATA, s);
     curl_multi_setopt(s->multi, CURLMOPT_TIMERFUNCTION, curl_timer_cb);
-- 
2.47.3


