Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42848C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9i22-0001Cx-LX; Wed, 22 May 2024 05:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s9i21-0001CH-Hk
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s9i1u-0002zB-Rz
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716369180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v5BFsiI/SZDDlfZhGSBVQSlAjC+zRcfdFXXRijqnJpE=;
 b=JmVpZlOV6SOlIqwAxo5tAHCtJ6siPiicUWcijpN7F/vudA5LUD455nRHTdJ8pwy1nkEb5b
 vxHQcJM5CUAd+sKWFw3Pzi9GWEZ+8q5SFEg+/bJ/oTtKoUni8BA2QbA+5ir9Zrx299bItm
 oPV9b3SDshzfL6JlfKMfaEs2WTb5BBo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-4M7vt8IdOSO3rHf1pGCRiw-1; Wed, 22 May 2024 05:12:59 -0400
X-MC-Unique: 4M7vt8IdOSO3rHf1pGCRiw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A46F81227E;
 Wed, 22 May 2024 09:12:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 057CE400057;
 Wed, 22 May 2024 09:12:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH] tests/qtest/migration-test: Run some basic tests on s390x and
 ppc64 with TCG, too
Date: Wed, 22 May 2024 11:12:55 +0200
Message-ID: <20240522091255.417263-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On s390x, we recently had a regression that broke migration / savevm
(see commit bebe9603fc ("hw/intc/s390_flic: Fix crash that occurs when
saving the machine state"). The problem was merged without being noticed
since we currently do not run any migration / savevm related tests on
x86 hosts.
While we currently cannot run all migration tests for the s390x target
on x86 hosts yet (due to some unresolved issues with TCG), we can at
least run some of the non-live tests to avoid such problems in the future.
Thus enable the "analyze-script" and the "bad_dest" tests before checking
for KVM on s390x or ppc64 (this also fixes the problem that the
"analyze-script" test was not run on s390x at all anymore since it got
disabled again by accident in a previous refactoring of the code).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 PS: Before anyone asks, yes, the quoted problem has been detected by the
 s390x runner in the gitlab-CI, but since that occasionally shows failure
 due to its slowness, it's considered as non-gating and nobody really looked
 at the failing jobs :-(

 tests/qtest/migration-test.c | 39 ++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e8d3555f56..5b4eca2b20 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3437,6 +3437,20 @@ int main(int argc, char **argv)
     arch = qtest_get_arch();
     is_x86 = !strcmp(arch, "i386") || !strcmp(arch, "x86_64");
 
+    tmpfs = g_dir_make_tmp("migration-test-XXXXXX", &err);
+    if (!tmpfs) {
+        g_test_message("Can't create temporary directory in %s: %s",
+                       g_get_tmp_dir(), err->message);
+    }
+    g_assert(tmpfs);
+
+    module_call_init(MODULE_INIT_QOM);
+
+    migration_test_add("/migration/bad_dest", test_baddest);
+#ifndef _WIN32
+    migration_test_add("/migration/analyze-script", test_analyze_script);
+#endif
+
     /*
      * On ppc64, the test only works with kvm-hv, but not with kvm-pr and TCG
      * is touchy due to race conditions on dirty bits (especially on PPC for
@@ -3444,8 +3458,8 @@ int main(int argc, char **argv)
      */
     if (g_str_equal(arch, "ppc64") &&
         (!has_kvm || access("/sys/module/kvm_hv", F_OK))) {
-        g_test_message("Skipping test: kvm_hv not available");
-        return g_test_run();
+        g_test_message("Skipping tests: kvm_hv not available");
+        goto test_add_done;
     }
 
     /*
@@ -3453,19 +3467,10 @@ int main(int argc, char **argv)
      * there until the problems are resolved
      */
     if (g_str_equal(arch, "s390x") && !has_kvm) {
-        g_test_message("Skipping test: s390x host with KVM is required");
-        return g_test_run();
+        g_test_message("Skipping tests: s390x host with KVM is required");
+        goto test_add_done;
     }
 
-    tmpfs = g_dir_make_tmp("migration-test-XXXXXX", &err);
-    if (!tmpfs) {
-        g_test_message("Can't create temporary directory in %s: %s",
-                       g_get_tmp_dir(), err->message);
-    }
-    g_assert(tmpfs);
-
-    module_call_init(MODULE_INIT_QOM);
-
     if (is_x86) {
         migration_test_add("/migration/precopy/unix/suspend/live",
                            test_precopy_unix_suspend_live);
@@ -3491,12 +3496,6 @@ int main(int argc, char **argv)
         }
     }
 
-    migration_test_add("/migration/bad_dest", test_baddest);
-#ifndef _WIN32
-    if (!g_str_equal(arch, "s390x")) {
-        migration_test_add("/migration/analyze-script", test_analyze_script);
-    }
-#endif
     migration_test_add("/migration/precopy/unix/plain",
                        test_precopy_unix_plain);
     migration_test_add("/migration/precopy/unix/xbzrle",
@@ -3653,6 +3652,8 @@ int main(int argc, char **argv)
                            test_vcpu_dirty_limit);
     }
 
+test_add_done:
+
     ret = g_test_run();
 
     g_assert_cmpint(ret, ==, 0);
-- 
2.45.1


