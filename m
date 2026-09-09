Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C226C79FBB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Q71-0000Xn-Df; Wed, 09 Sep 2026 17:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4Q6z-0000XJ-4U
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:45:45 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4Q6x-0005P0-4E
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:45:44 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDBCB1FCDA;
 Wed,  9 Sep 2026 21:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788990337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZuzUP2AZtq+mwNfvS27ay2KDJ0kOoN1RI8BzZOMkr4=;
 b=oTEul7iAgZPHq58c0yMqJunQ2gTtN4g2LC7SrgQQq5DDYt7SLfuckl3PrABDH6GcEbXtsd
 Bg8tZIvJDEPzCUkFIn53zPSWYpyLaS+XnPHUHOBaIhjSwzF7mCYBnGcRNz+MSLBY0Cyg/H
 2SOC0SdRhiQs5cNcNSRmTusMJiMCC5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788990337;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZuzUP2AZtq+mwNfvS27ay2KDJ0kOoN1RI8BzZOMkr4=;
 b=vlxfcwsEP6bYZJ+4SkMNAlxEIohRfViYDEYMHOMhZ0iTYSybPnlabJ5v8Z5oLMxoMSmSM8
 bZGgY5Nv3Wh7NsCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788990333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZuzUP2AZtq+mwNfvS27ay2KDJ0kOoN1RI8BzZOMkr4=;
 b=OO1S1WDb9uC7f7RowTLygUydrvtpYQv6fUkNOiRKAbYxzvS6gQ5uWU6uZhhCS2mnJcG9rl
 33l2hd0XVo6kS81HuPxzZ3iRiiSnNYlGulDJD9ZlhIBf7w9636FSBEYye1WNlz0+naMecB
 iG9v79aIw/IUfjY6Ic/IuaUYhEtBHSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788990333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZuzUP2AZtq+mwNfvS27ay2KDJ0kOoN1RI8BzZOMkr4=;
 b=2FdwKGbePHqdrujhGtaiiPROoZp1wFfIDf50Aw67SljXC4A+Dbf4O83eyFFiZg9QE8KZDu
 FWKz6Pln+YWuMNBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3D9F13770;
 Wed,  9 Sep 2026 21:45:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wBDYLnvToWqzawAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 09 Sep 2026 21:45:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 09/18] tests/qtest/migration: Add a test for HMP
Date: Wed,  9 Sep 2026 18:44:59 -0300
Message-ID: <20260909214509.237309-10-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909214509.237309-1-farosas@suse.de>
References: <20260909214509.237309-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The following patches will change how parameters are set and shown in
HMP, add a test for it.

The test issues HMP migrate_set_parameters for each of the existing
migration parameters and queries them back with the info command. A
list is kept with the expected strings. A substring match function
inspired by glib's g_str_match_string is implemented for this test so
the test can produce a decent error output instead of just assert
failure. E.g:

 # HMP output mismatch for entry at line 55:
 # expected vs. found:
 #
 # max-bandwidth: 10356305952768 bytes/hour
 # ---
 # max-bandwidth: 10356305952768 bytes/second

(note that line 55 above is the source line where the test case for
max-bandwith is, which helps find the failing test in the list)

Usage:
QTEST_QEMU_BINARY=./qemu-system-x86_64 \
./tests/qtest/migration-test --full -p /x86_64/migration/hmp/parameters

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/misc-tests.c | 201 +++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 4e0deb7f18..533cf3d55d 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -22,6 +22,203 @@
 
 static char *tmpfs;
 
+#ifdef CONFIG_HMP
+static int test_case_line;
+
+#define TEST(i1, i2, e) { i1, i2, e , .line = __LINE__, }
+#define SKIP(i1, i2, e) { i1, i2, e , .skip = true, }
+#define BG_SNAP_MSG ("Error: Background-snapshot is not compatible with " \
+                     "currently set capabilities")
+
+typedef struct HMPTestData {
+    const char *input1;
+    const char *input2;
+    const char *output1;
+    bool skip;
+    int line;
+} HMPTestData;
+
+/*
+ * .input1: string to be used as parameter name
+ * .input2: string to be used as parameter value
+ * .output1: expected output of migrate_set_parameters
+ * E.g:
+ * (qemu) migrate_set_parameters .input1 .input2
+ * .output1
+ */
+HMPTestData test_cases[] = {
+    TEST("", "", "migrate_set_parameter: string expected"),
+    TEST("foo", "", "migrate_set_parameter: string expected"),
+    TEST("foo", "on", "Error: invalid parameter value: foo"),
+
+    /* bool */
+    TEST("cpu-throttle-tailslow", "on", "on"),
+    TEST("direct-io", "on", "on"),
+
+    /* uint64_t */
+    TEST("announce-initial", "60", "60 ms"),
+    TEST("announce-max", "600", "600 ms"),
+    TEST("announce-rounds", "6", "6"),
+    TEST("announce-step", "15", "15 ms"),
+    TEST("downtime-limit", "400", "400 ms"),
+    TEST("avail-switchover-bandwidth", "2097152", "2199023255552 bytes/second"),
+    TEST("max-bandwidth", "9876543", "10356305952768 bytes/second"),
+    TEST("max-postcopy-bandwidth", "1048576", "1048576 bytes/second"),
+    TEST("vcpu-dirty-limit", "20", "20 MB/s"),
+    TEST("x-rdma-chunk-size", "1048576", "1048576 bytes"),
+    TEST("x-vcpu-dirty-limit-period", "750", "750 ms"),
+    TEST("xbzrle-cache-size", "67108864", "67108864 bytes"),
+
+    /* uint32_t */
+    TEST("x-checkpoint-delay", "5000", "5000 ms"),
+
+    /* uint8_t */
+    TEST("cpu-throttle-increment", "15", "15"),
+    TEST("cpu-throttle-initial", "25", "25"),
+    TEST("max-cpu-throttle", "85", "85"),
+    TEST("multifd-channels", "8", "8"),
+    TEST("throttle-trigger-threshold", "65", "65"),
+
+    /* complex types */
+    TEST("mode", "cpr-exec", "cpr-exec"),
+    TEST("multifd-compression", "zlib", "zlib"),
+    TEST("zero-page-detection", "none", "none"),
+    TEST("tls-authz", "my_authz", "'my_authz'"),
+    TEST("tls-creds", "null", "'null'"),
+    TEST("tls-hostname", "localhost", "'localhost'"),
+    TEST("cpr-exec-command", "/bin/true foobar", "/bin/true foobar"),
+
+    /* can be set but are currently missing in the query output */
+    SKIP("multifd-qatzip-level", "5", "5"),
+    SKIP("multifd-zlib-level", "4", "4"),
+    SKIP("multifd-zstd-level", "6", "6"),
+
+    /* cannot be set */
+    TEST("block-bitmap-mapping", "[]",
+         "Error: The block-bitmap-mapping parameter "
+         "can only be set through QMP"),
+};
+
+/*
+ * Find a contiguous run of tokens in @larger that match the sequence
+ * of tokens in @smaller, ignoring mismatches due to sequences of
+ * empty tokens.
+ *
+ * Returns whether a match was found. @last is set if at least one
+ * token has matched.
+ */
+static bool token_list_is_substr(char **smaller, char **larger, int *last)
+{
+    int i, j, k = 0;
+    bool match = false;
+
+    for (i = 0; smaller[i]; i++) {
+        for (j = k; larger[j]; j++) {
+            if (!*larger[j]) {
+                continue;
+            }
+
+            /* readline adds several escape sequences */
+            if (*larger[j] == '\033') {
+                continue;
+            }
+
+            if (g_str_equal(larger[j], smaller[i])) {
+                match = true;
+                *last = j;
+                k = j + 1;
+                break;
+            }
+
+            if (match) {
+                return false;
+            } else {
+                match = false;
+            }
+        }
+    }
+
+    return match;
+}
+
+static void assert_hmp_match_line(const char *str, const char *text)
+{
+    g_auto(GStrv) tok_str = g_strsplit_set(str, " ", -1);
+    g_auto(GStrv) lines = g_strsplit_set(text, " \r\n", -1);
+    int i, idx = -1;
+
+    /*
+     * Note that the reason the 'str' above is split is to allow
+     * token_list_is_substr() to first match on the parameter name so
+     * matching can stop immediately after a mismatched value is
+     * found. This provides a better output for failing test cases
+     * than simply "str != line".
+     */
+
+    for (i = 0; lines[i]; i++) {
+        if (token_list_is_substr(tok_str, (char **)&lines[i], &idx)) {
+            return;
+        }
+
+        if (idx >= 0) {
+            break;
+        }
+    }
+
+    g_test_message("HMP output mismatch for entry at line %d:", test_case_line);
+    g_test_message("expected vs. found:\n\n%s\n---\n%s %s", str, lines[idx],
+                   lines[idx + 1]);
+    g_assert_not_reached();
+}
+
+static void assert_hmp_success(const char *str)
+{
+    if (!g_str_equal(str, "")) {
+        g_test_message("HMP command failed:\n\n%s", str);
+        g_assert_not_reached();
+    }
+}
+
+static void test_hmp_migration_parameters(char *name, MigrateCommon *args)
+{
+    QTestState *qts;
+
+    /* force TCG so it can run in all targets */
+    qts = qtest_init("-accel tcg -nodefaults -S");
+
+    for (int i = 0; i < G_N_ELEMENTS(test_cases); i++) {
+        g_autofree char *resp = NULL;
+        g_autofree char *line = NULL;
+        struct HMPTestData *t = &test_cases[i];
+
+        if (t->skip) {
+            continue;
+        }
+
+        test_case_line = t->line;
+
+        resp = qtest_hmp(qts, "migrate_set_parameter %s %s", t->input1,
+                         t->input2);
+
+        if (g_str_has_prefix(t->output1, "Error:") ||
+            g_str_has_prefix(resp, "migrate_set_parameter:")) {
+
+            assert_hmp_match_line(t->output1, resp);
+            continue;
+        }
+        assert_hmp_success(resp);
+        g_free(resp);
+
+        resp = qtest_hmp(qts, "info migrate_parameters");
+
+        line = g_strconcat(t->input1, ": ", t->output1, NULL);
+        assert_hmp_match_line(line, resp);
+    }
+
+    qtest_quit(qts);
+}
+#endif /* CONFIG_HMP */
+
 static void test_baddest(char *name, MigrateCommon *args)
 {
     QTestState *from, *to;
@@ -260,4 +457,8 @@ void migration_test_add_misc(MigrationTestEnv *env)
                        test_validate_uri_channels_both_set);
     migration_test_add("/migration/validate_uri/channels/none_set",
                        test_validate_uri_channels_none_set);
+#ifdef CONFIG_HMP
+    migration_test_add("/migration/hmp/parameters",
+                       test_hmp_migration_parameters);
+#endif
 }
-- 
2.53.0


