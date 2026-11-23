Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EAC606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=fZB/ciDM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWH9-0001KR-Pa; Mon, 23 Nov 2026 10:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <98d19860ac1d82610490d46382299d58d8d8a784@kylie.crudebyte.com>)
 id 1xVWH7-0001GU-2l
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:48:13 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <98d19860ac1d82610490d46382299d58d8d8a784@kylie.crudebyte.com>)
 id 1xVWH5-0005cT-Gp
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=hNCnHoBTyk4qCzZQXEAORbD24D2NnTcmbCQHmQ/pQyw=; b=fZB/c
 iDMo4xLqiVMbPiX5KdnDBIUBfNQBbPq/T4L+19tX0F9CJ3xPEjy5P2lPSn5620lROtv/vY4HyNQrd
 y8xXmYEY15OlMWi4kJjg8YhoYVckGGXlGgO3g7NnlLcSiTegck7X/h3dUDkhDgQn5W6ENBjZdRpZj
 FjUd3JG0rFiDdV2EHy7LInq3LG44z6o8ggEdT2zXgp8LCWggiU37jGiIdt0bc9+3x2rZinWjbIghX
 cp418saeQ0qiTT4F3GFuW4dkEI49YKIAQF2N/q5yz2A7aWAQf0LS8k2gYjkjN3jWJ6gWXXZEBKCcV
 sQnvolkq24yU9JO6Y88owTxEeBAd1kArpq2GhUlOu7DpWjepmmB5VzpNDlFg5fEJWcp4Ycctyoj5u
 U8zOaEcTMv1lFyXXRqsYQYGkUKF0qmW2cbDl9xGsCstOFe/cxxOpUAj+kil2JBB2sjW9S7+BaC/Av
 X79mL0xYuAuSPkOv/mVPWf+UFguBdGBloqUdgtq/RihDbzia+nKNhcWCrzLl725P4OaBvQFS7bQBQ
 aKIP5geHFiygVwy1mhhbqwVBTBVpBp58hUw9dyt/C8Hd3OrUJ6Fz73SVhkYctiqWN6KESDAE+gUEL
 fv8yhjl189OgX+a7h6ReBib8baclCUEpERuR7EwtaetmCwfq/O+1aXCZZvPxIM=;
Message-ID: <98d19860ac1d82610490d46382299d58d8d8a784.1795447869.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1795447869.git.qemu_oss@crudebyte.com>
References: <cover.1795447869.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 23 Nov 2026 16:25:06 +0100
Subject: [PATCH 7/7] tests/9p-internals: test 9p's local_path_sanity_check()
 function
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=98d19860ac1d82610490d46382299d58d8d8a784@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Test 9p local fs backend's internal local_path_sanity_check()
function (introduced by previous patch) for it to abort() the
process as expected on passed, corrupted V9fsPath objects.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/unit/test-9p-internals.c | 73 ++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tests/unit/test-9p-internals.c b/tests/unit/test-9p-internals.c
index 61c7fc7779..30c7c58afc 100644
--- a/tests/unit/test-9p-internals.c
+++ b/tests/unit/test-9p-internals.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "fsdev/file-op-9p.h"
+#include "hw/9pfs/9p.h"
 #include "hw/9pfs/9p-local.h"
 #include "forktest.h"
 #include <stdlib.h>
@@ -56,6 +57,29 @@ static const char *v9p_internals_corrupt_paths[] = {
     "",
 };
 
+/*
+ * Resembles a V9fsPath - @expect_abort reflects whether that state
+ * is expected to cause an abort
+ */
+typedef struct {
+    const char *data;
+    size_t size;
+    bool expect_abort;
+} V9pInternalsPathPair;
+
+static const V9pInternalsPathPair v9p_internals_path_pairs[] = {
+    { NULL, 0, true },
+    { NULL, 4, true },
+    /* short size: a copy would not be NUL-terminated */
+    { "abc", 2, true },
+    /* long size: captured copy would exceed the string */
+    { "abc", 99, true },
+    /* implausible size: larger than our hard-coded 4 MiB limit */
+    { "abc", 5 * 1024 * 1024, true },
+    /* valid size: this should not abort */
+    { "abc", 4, false },
+};
+
 /* shared test-suite state */
 typedef struct {
     LocalData localdata;
@@ -183,6 +207,53 @@ static void v9p_internals_local_open_nofollow_corrupt_paths(void *data)
     }
 }
 
+/*
+ * Called from within a child process, because the tested
+ * local_path_sanity_check() function aborts if it detected a
+ * corrupted V9fsPath. So we test whether the child process was
+ * aborted as expected (for corrupted paths).
+ */
+static void v9p_internals_check_v9fspath(void *opaque)
+{
+    const V9pInternalsPathPair *p = opaque;
+    V9fsPath pair;
+    V9fsPath dst;
+
+    pair = (V9fsPath) { .data = (char *)p->data, .size = p->size };
+
+    local_path_sanity_check(&pair);
+    if (p->expect_abort) {
+        forktest_exit(FORKTEST_EXIT_SURVIVED);
+    }
+
+    v9fs_path_init(&dst);
+    v9fs_path_copy(&dst, &pair);
+    g_assert_cmpuint(dst.size, ==, p->size);
+    g_assert_nonnull(dst.data);
+    g_assert_cmpint(dst.data[p->size - 1], ==, '\0');
+    v9fs_path_free(&dst);
+    forktest_exit(FORKTEST_EXIT_OK);
+}
+
+static void v9p_internals_local_path_sanity_check(void *data)
+{
+    size_t i;
+
+    for (i = 0; i < ARRAY_SIZE(v9p_internals_path_pairs); i++) {
+        const V9pInternalsPathPair *pair = &v9p_internals_path_pairs[i];
+        g_autofree char *name =
+            g_strdup_printf("path pair (data %s, size %zu)", pair->data,
+                            pair->size);
+
+        forktest_run((ForkTest) {
+            .child_fn = v9p_internals_check_v9fspath,
+            .opaque = (void *)pair,
+            .expect_abort = pair->expect_abort,
+            .name = name,
+        });
+    }
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -193,5 +264,7 @@ int main(int argc, char **argv)
     forktest_add("/9p-internals/local_open_nofollow/corrupt-paths",
                  v9p_internals_local_open_nofollow_corrupt_paths,
                  &v9p_internals_env);
+    forktest_add("/9p-internals/local_path_sanity_check",
+                 v9p_internals_local_path_sanity_check, NULL);
     return g_test_run();
 }
-- 
2.47.3


