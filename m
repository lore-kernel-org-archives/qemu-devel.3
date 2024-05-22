Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E5CC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9uKT-0005hZ-O6; Wed, 22 May 2024 18:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKQ-0005bJ-07
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:58 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s9uKN-0003n8-NT
 for qemu-devel@nongnu.org; Wed, 22 May 2024 18:20:57 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 88C4221C23;
 Wed, 22 May 2024 22:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6hQgeppo5RwzWRULw6ye/Z+4js+YblrE40V/y9r/eM=;
 b=tzMy46mh3feq/+6yzl73AGpgzJQXmPNXl/CtWHllTNRH5hZhwkX+pGYbZxC6qSWK4Ehg1o
 RwZYeMJJzwGbYrJPwuV+Xs9X9IVa2wZb1grNlWiPHKv43iW0IPShE/CoKFCjzRpCVYV276
 trKojzf3Z0BV+ffafvNYdd7n528hWLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6hQgeppo5RwzWRULw6ye/Z+4js+YblrE40V/y9r/eM=;
 b=a/C0ccfE3aBKT5J0NwAZIw3/kzz5b3lwspCNtmYVGWcfya9cU/ULpOq+JmbuwO3ZITlk30
 M3cSMww7cu2ljfAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tzMy46mh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="a/C0ccfE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716416454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6hQgeppo5RwzWRULw6ye/Z+4js+YblrE40V/y9r/eM=;
 b=tzMy46mh3feq/+6yzl73AGpgzJQXmPNXl/CtWHllTNRH5hZhwkX+pGYbZxC6qSWK4Ehg1o
 RwZYeMJJzwGbYrJPwuV+Xs9X9IVa2wZb1grNlWiPHKv43iW0IPShE/CoKFCjzRpCVYV276
 trKojzf3Z0BV+ffafvNYdd7n528hWLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716416454;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6hQgeppo5RwzWRULw6ye/Z+4js+YblrE40V/y9r/eM=;
 b=a/C0ccfE3aBKT5J0NwAZIw3/kzz5b3lwspCNtmYVGWcfya9cU/ULpOq+JmbuwO3ZITlk30
 M3cSMww7cu2ljfAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A72E13A6B;
 Wed, 22 May 2024 22:20:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uI+OOMRvTmaABAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 May 2024 22:20:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 8/9] tests/qtest/migration-test: Run some basic tests on s390x
 and ppc64 with TCG, too
Date: Wed, 22 May 2024 19:20:33 -0300
Message-Id: <20240522222034.4001-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240522222034.4001-1-farosas@suse.de>
References: <20240522222034.4001-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 88C4221C23
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Thomas Huth <thuth@redhat.com>

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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
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
2.35.3


