Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DABFCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWf2-0004Sg-9O; Fri, 06 Mar 2026 10:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWez-0004O6-Lq
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:14 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWex-0002jI-Of
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:13 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-480706554beso101649905e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809210; x=1773414010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KRbmW3kwir/mYPk9Kn+TgZcLL+Di3FtHW7Nn58l1/to=;
 b=M0/dD7PhDu5j4AmIxXhyHeEOvkvNpFo5jIIjG9UYRin27lDIcb8xwzIQnU1gkRLLql
 ccORRxoCFISKshjHrEopSv++62b6r+marp8AhuT1iaoaZKd0Pk3NhZ0oBs/wVh0lbOj/
 NWU3gBPUj/dVZIUnGsbVZACbUTDTHwIVspC/7Kws3c5cCeFUjP4/upeoH4y8UBiePHcY
 I33UMS5ULTrFGFRzChm3l53qtDlS1LdCVU5JmiorUn8nxMM1DYoF3NUlmhw8b99pt5Zw
 p9FnBa42JsOl01Xs3Otb4plNCPth/71CHz2C5uyvENMXJtfIa8pUybl9Z4TjQ0b/2URF
 ZKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809210; x=1773414010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KRbmW3kwir/mYPk9Kn+TgZcLL+Di3FtHW7Nn58l1/to=;
 b=IFCBeu8vPTP9x3umCqO8C90UtgbvhTShs+up/xhgIKFJZ8GTN4AL97g2e5a8extTmq
 CJFJr8b1Lt3pWJkKAn5fP6GhTtlaPCPSscaurmP3SjyMMa7mmF+uplrboRRHKstM8+wz
 158Frp6xPD54OKmEpRFKGewx3rr3Naui6ZzbtwV9WiJcUcO0imomdKpxiHOBKIIrYlzc
 wKy1o7+mR0qNatq+qHVVfWUDJ7iXaONroa1mUmONPphAVxpDyll9/DZR7AaBGLEDcrur
 A1Lwl8+nHfP96rHzVNFfB6DLMQ8x4PD3l6evDf8WebEbTQJZrR4aNHGgBCAVlP9aKpVz
 BBXw==
X-Gm-Message-State: AOJu0Yzt5MX5gNUjps6N8yQG8GFc4eY7vZCeBW32wGmanYpnhtMW6UKd
 s/3wOjfRtI6U8FelxAzaGaraqLYnX9My3o/cd/AFhk/WeV+ZNi22f4ngFQFuyq1CjM8Rj11JkMO
 4f5bk
X-Gm-Gg: ATEYQzw/qpQRSOwIf5D85dZUa4yV8DbXqYXRXv7PT4+cIsIA1fhutzhzbeGBCznEK/Q
 6AHOnfOIlU/cusZ/HL/txD7QELVKQE6kQg4bd0Rsnsd08HeZxZlAOPZcEwoXPPeJditwgslFY+K
 a85Bt0Fr6dOTifZSeeyx6t0nTpZos4rSag9CUqg0x3NhtPRk7ovSecplX7GDQ71nudYz0t2+ovb
 4dOAU8lM3FIJVyKH/nMvZZ3SI4sYlMXdRMixkGL4GwikLB190qy5BgssBY+TaYptbKaHZiYTZSi
 UVUuHxilOxMoPOt1uVgW+O1Zup/+4EcLXfKnCWk78nIkhUxivDu+S2V7G0oFY53y8zjv6nAYmgC
 aNE4UoDWCAmPTlOKiY39B5Nh888tMx0yo+LlF1SJ8PKmSwhHfdNe/TnvxP8y8g+GManH2T2DdaN
 HIWQ7u+gnnRxrMPfNwk9ymsA8B/G06LWitIkYxGXz3QCnD4l398wu2mHKABpNIe+vO+oZ4H8GSW
 DU/o1pDYw6c70KPcCzFUoHdOBSXIfWmeR1LBaB5+g==
X-Received: by 2002:a05:600c:4fc2:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-4852692b621mr41004335e9.12.1772809210007; 
 Fri, 06 Mar 2026 07:00:10 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/49] tests/qtest/qos-test: Plug a couple of leaks
Date: Fri,  6 Mar 2026 14:59:19 +0000
Message-ID: <20260306145939.2162189-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

The walk_path() function of qos-test.c, which walks the graph and adds
tests to the test suite uses GLib's g_test_add_data_func_full()
function:

g_test_add_data_func_full (const char     *testpath,
                           gpointer        test_data,
                           GTestDataFunc   test_func,
                           GDestroyNotify  data_free_func)

Despite GLib's documentation stating that @data_free_func is a
destructor for @test_data, this is not the case. The destructor is
supposed to be paired with a constructor, which GLib only accepts via
g_test_create_case().

Providing externally allocated data plus a destructor function only
works if the test is guaranteed to execute, otherwise the test_data is
never deallocated.

Due to how subprocessess are implemented in qos-test, each test gets
added twice and an extra test gets added per subprocess. In a regular
run, the extra subprocess will not be executed and in a single test
run (-p), none of the other tests will be executed (+1 per
subprocess), leaking 'path_vec' and 'subprocess_path'.

Fix this by storing all the path vectors in a list and freeing them
all at the end of the program (including subprocess invocations) and
moving the allocation of 'subprocess_path' into run_one_subprocess().

While here add some documentation explaining why the graph needs to be
walked twice and tests re-added.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260302092225.4088227-10-peter.maydell@linaro.org
[PMM: rebased; rewrote the comment in main() a bit to account
 for the if (g_test_subprocess()) block it was previously inside
 no longer being present. ]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/qos-test.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index 00f39f33f6..50fa0ceef3 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -31,6 +31,7 @@
 #include "libqos/qos_external.h"
 
 static char *old_path;
+static GSList *path_vecs;
 
 
 /**
@@ -182,11 +183,16 @@ static void run_one_test(const void *arg)
 
 static void subprocess_run_one_test(const void *arg)
 {
-    const gchar *path = arg;
-    g_test_trap_subprocess(path, 180 * G_USEC_PER_SEC,
+    char **path_vec = (char **) arg;
+    gchar *path = g_strjoinv("/", path_vec + 1);
+    gchar *subprocess_path = g_strdup_printf("/%s/subprocess", path);
+
+    g_test_trap_subprocess(subprocess_path, 180 * G_USEC_PER_SEC,
                            G_TEST_SUBPROCESS_INHERIT_STDOUT |
                            G_TEST_SUBPROCESS_INHERIT_STDERR);
     g_test_trap_assert_passed();
+    g_free(path);
+    g_free(subprocess_path);
 }
 
 static void destroy_pathv(void *arg)
@@ -238,6 +244,7 @@ static void walk_path(QOSGraphNode *orig_path, int len)
     GString *cmd_line = g_string_new("");
     GString *cmd_line2 = g_string_new("");
 
+    path_vecs = g_slist_append(path_vecs, path_vec);
     path = qos_graph_get_node(node_name); /* root */
     node_name = qos_graph_edge_get_dest(path->path_edge); /* machine name */
 
@@ -297,15 +304,15 @@ static void walk_path(QOSGraphNode *orig_path, int len)
     path_vec[0] = g_string_free(cmd_line, false);
 
     if (path->u.test.subprocess) {
-        gchar *subprocess_path = g_strdup_printf("/%s/%s/subprocess",
-                                                 qtest_get_arch(), path_str);
-        qtest_add_data_func_full(path_str, subprocess_path,
-                                 subprocess_run_one_test, g_free);
-        g_test_add_data_func_full(subprocess_path, path_vec,
-                                  run_one_test, destroy_pathv);
+        gchar *subprocess_path = g_strdup_printf("%s/%s", path_str,
+                                                 "subprocess");
+
+        qtest_add_data_func(path_str, path_vec, subprocess_run_one_test);
+        qtest_add_data_func(subprocess_path, path_vec, run_one_test);
+
+        g_free(subprocess_path);
     } else {
-        qtest_add_data_func_full(path_str, path_vec,
-                                 run_one_test, destroy_pathv);
+        qtest_add_data_func(path_str, path_vec, run_one_test);
     }
 
     g_free(path_str);
@@ -340,6 +347,14 @@ int main(int argc, char **argv, char** envp)
     module_call_init(MODULE_INIT_LIBQOS);
     qos_set_machines_devices_available();
 
+    /*
+     * Even if this invocation was done to run a single test in a
+     * subprocess (i.e. g_test_subprocess() is true), gtester doesn't
+     * expose the test name, so w still need to execute the whole
+     * thing as normal, including walking the QOS graph to add all
+     * the tests, in order for g_test_run() to find the one /subprocess
+     * test that it is going to execute.
+     */
     qos_graph_foreach_test_path(walk_path);
     if (g_test_verbose()) {
         qos_dump_graph();
@@ -348,5 +363,6 @@ int main(int argc, char **argv, char** envp)
     qtest_end();
     qos_graph_destroy();
     g_free(old_path);
+    g_slist_free_full(path_vecs, (GDestroyNotify)destroy_pathv);
     return 0;
 }
-- 
2.43.0


