Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95D0C87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 14:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uia5l-000674-9D; Sun, 03 Aug 2025 10:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uia5Y-00061N-QR
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 10:53:29 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uia5V-0008Ga-Ma
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 10:53:28 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 573Er4KE071233
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 3 Aug 2025 23:53:17 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=VZ5L6AH0SK3eoLZK2xt9RgBwaxpcc3SuF9wc5taoXA0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1754232797; v=1;
 b=BlcOUt/hh5bLCK4Y7UQLoG02N8f1hwNqpuJdn7F4zx3l6dEV33Y9z1F5675Rmkom
 NabEw5EMbiIzwTY7RpSbiuidyQ0kQYH/T3J2ARoWgtgw67f1IFKWDxKy2wJsxtqr
 u9M/D2+W2kRtPWgKvU2amwVbgxaP7afkkD9FUSqXKCxa3xZU2cWPbWOHh53F/JJV
 tswFIM1h8LZ7oL7ks6+jNl7sMUuw382Rujn9wMu/iFv4vNgyk4R/QvgLIjgDYwqL
 lRNEt85GqrCekGOaF5e89Unafcx3EThsfpUCOJl715snlWw/3eWywOyxC2kmgxbq
 lKEYcxTxNWIPtc/7YBnslQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 03 Aug 2025 23:52:57 +0900
Subject: [PATCH] error: Rewrite &error_warn with ERRP_GUARD()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250803-errp-v1-1-a59a73f63289@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAMh3j2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwNj3dSiogLdVFOTZAsjE6NUo5QUJaDSgqLUtMwKsDHRsbW1AEOb0K9
 WAAAA
X-Change-ID: 20250803-errp-e54c8242e2dd
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Without rewrite, an warning message may be printed before
error_prepend(); in such a scenario, error_prepend() will results in
NULL dereference because error_warn is NULL.

Rewrite &error_warn with ERRP_GUARD() to make sure error_prepend() is
reflected to printed messages and to avoid NULL dereference.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 include/qapi/error.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 41e38163804904874e5d114b699a3e2a93d3fc6d..4fa04980c2fd110aa68ced020dd1ec8a83d7d957 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -505,20 +505,20 @@ void error_set_internal(Error **errp,
  * It is safe to use even when it's not needed, but please avoid
  * cluttering the source with useless code.
  *
- * If @errp is NULL or &error_fatal, rewrite it to point to a local
- * Error variable, which will be automatically propagated to the
- * original @errp on function exit.
+ * If @errp is NULL, &error_fatal, or &error_warn, rewrite it to point
+ * to a local Error variable, which will be automatically propagated to
+ * the original @errp on function exit.
  *
  * Note: &error_abort is not rewritten, because that would move the
  * abort from the place where the error is created to the place where
  * it's propagated.
  */
-#define ERRP_GUARD()                                            \
-    g_auto(ErrorPropagator) _auto_errp_prop = {.errp = errp};   \
-    do {                                                        \
-        if (!errp || errp == &error_fatal) {                    \
-            errp = &_auto_errp_prop.local_err;                  \
-        }                                                       \
+#define ERRP_GUARD()                                                \
+    g_auto(ErrorPropagator) _auto_errp_prop = {.errp = errp};       \
+    do {                                                            \
+        if (!errp || errp == &error_fatal || errp == &error_warn) { \
+            errp = &_auto_errp_prop.local_err;                      \
+        }                                                           \
     } while (0)
 
 typedef struct ErrorPropagator {

---
base-commit: f0737158b483e7ec2b2512145aeab888b85cc1f7
change-id: 20250803-errp-e54c8242e2dd

Best regards,
-- 
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


