Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95919C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 22:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1tFu-0000v2-GX; Wed, 02 Sep 2026 18:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFt-0000u5-0B
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:29 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x1tFq-0002NZ-FK
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 18:16:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 202EE21CCB;
 Wed,  2 Sep 2026 22:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4GL64pN6fgcArizW0/7XTLoD2qsTEoytqZferYG/WY=;
 b=PWUjzXAV1TuGR51jTdjE1I3IQxhg1FudY3pIfSb90kvuyD1WQbHYqLkFuuRXUxoblKt00D
 UqhcgfFeuPs8a8bYhT0TDlZl4KWgmDM6zSd5T4qVxHLwMrlw/MwJyCzNkIpx34tkGl0m9D
 ZO1bHMDCeI+ikTp2q3ABWpnZheDskz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387381;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4GL64pN6fgcArizW0/7XTLoD2qsTEoytqZferYG/WY=;
 b=oRxp8u8AAZBx205SNK/temM/aK/ya3vbUoa7Y+PmcCQa3OtYNzPx3kc3ZbY+wUotW8KeRN
 4+7OgyvYxOLw16Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=P6l3hyYH;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NJDiahZ5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788387377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4GL64pN6fgcArizW0/7XTLoD2qsTEoytqZferYG/WY=;
 b=P6l3hyYHpc+dwbDnzvpcna31csqMK5psk9f8ZIBjkOOQ1FVOzoamtpsBln/MrzXwWYm0BR
 J3TJZRdZH07rj2yVXNKK17bz3a8d36bCDJVR+SrFhEpplIYLLva8eMo13lxRRROYLgF3Xj
 WJJCgLvTNStw6+EFUeQjYCU3JCkz0U8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788387377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4GL64pN6fgcArizW0/7XTLoD2qsTEoytqZferYG/WY=;
 b=NJDiahZ5noWN6YxjjQx4RoeJo4A067CCVSn1Ea/oTsaK7wy78TM3opRUWu5kxatLpe/57m
 Ekg76Aeym/RlMLAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCD7313736;
 Wed,  2 Sep 2026 22:16:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ACrxKi+gmGpxXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 02 Sep 2026 22:16:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 09/18] tests/qtest/migration: Add a test for HMP
Date: Wed,  2 Sep 2026 19:15:37 -0300
Message-ID: <20260902221547.1812481-10-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902221547.1812481-1-farosas@suse.de>
References: <20260902221547.1812481-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 202EE21CCB
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
HMP, including readline completion so add two minimal tests.

- set/info migrate_parameters

The test uses qtest facilities to issue HMP migrate_set_parameters for
each of the existing migration parameters and queries them back with
the info command. A list is kept with the expected strings. A
substring match function inspired by glib's g_str_match_string is
implemented for this test so the test can produce a decent error
output instead of just assert failure. E.g:

 # HMP output mismatch for entry at line 55:
 # expected vs. found:
 #
 # max-bandwidth: 10356305952768 bytes/hour
 # ---
 # max-bandwidth: 10356305952768 bytes/second

(note that line 55 above is the source line where the test case for
max-bandwith is)

- readline completion

The test puts the monitor on a chardev via socket and bypasses qtest
facilities because it needs to emit raw codes to readline. It
therefore requires a couple of new helpers to read/write to the
monitor socket.

Usage:
QTEST_QEMU_BINARY=./qemu-system-x86_64 \
./tests/qtest/migration-test --full -p /x86_64/migration/hmp

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/misc-tests.c | 319 +++++++++++++++++++++++++++++
 1 file changed, 319 insertions(+)

diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 4e0deb7f188..3554900b758 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "qobject/qjson.h"
 #include "libqtest.h"
@@ -21,6 +22,320 @@
 #define ANALYZE_SCRIPT "scripts/analyze-migration.py"
 
 static char *tmpfs;
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
+ * .input1: partial string with an ending TAB (as if pressed by
+ *          the user).
+ * .input2: common root of the completions, i.e. what the partial
+ *          part of .input1 string completes to.
+ * .expected: full list of completion suggestions for the string
+ *          in .input2.
+ * E.g:
+ * (qemu) .input1
+ * <after TAB>
+ * (qemu) .input2
+ * .output1
+ */
+HMPTestData completion_cases[] = {
+    TEST("migra\t",
+         "migrate",
+         "migrate migrate_cancel migrate_continue migrate_incoming "
+         "migrate_pause migrate_recover migrate_set_capability "
+         "migrate_set_parameter migrate_start_postcopy"),
+
+    /*
+     * Note QEMU doesn't keep 'info' when offering the completions
+     * suggestions.
+     */
+    TEST("info migra\t",
+         "migrate",
+         "migrate migrate_capabilities migrate_parameters"),
+};
+
+/*
+ * Find a contiguous run of tokens in @larger that match the sequence
+ * of tokens in @smaller. If @strip_empty, ignore mismatches due to
+ * sequences of empty tokens.
+ *
+ * Returns whether a match was found.
+ * Updates the indices:
+ *   @last_match: which token in @larger last matched a token in
+ *                @smaller
+ *   @last_tried: which token in @smaller was last compared with a
+ *                token in @larger
+ */
+static bool token_list_is_substr(char **smaller, char **larger,
+                                 int *last_match, int *last_tried,
+                                 bool skip_empty)
+{
+    int i, j, k = 0;
+    bool match = true;
+
+    for (i = 0; smaller[i]; i++) {
+        for (j = k; larger[j]; j++) {
+
+            if (!*larger[j] && skip_empty) {
+                continue;
+            }
+
+            if (!g_str_has_prefix(larger[j], smaller[i])) {
+                continue;
+            }
+
+            match = true;
+            k = j;
+            goto next;
+        }
+
+        match = false;
+        break;
+    next:
+        ;
+    }
+
+    *last_match = k;
+    *last_tried = i;
+
+    return match;
+}
+
+static void assert_hmp_match(const char *str, const char *text, bool per_line)
+{
+    const char *delim = per_line ? ":\n" : " \r\n";
+    g_auto(GStrv) t1 = g_strsplit_set(str, delim, -1);
+    g_auto(GStrv) t2 = g_strsplit_set(text, delim, -1);
+    int match, mismatch;
+
+    if (token_list_is_substr(t1, t2, &match, &mismatch, !per_line)) {
+        return;
+    }
+
+    g_test_message("HMP output mismatch for entry at line %d:", test_case_line);
+
+    if (per_line) {
+        if (mismatch == 0) {
+            g_test_message("'%s' not present in output", t1[mismatch]);
+        } else {
+            g_test_message("expected vs. found:\n\n%s\n---\n%s:%s", str,
+                           t2[match], t2[match + 1]);
+            /*
+             * + 1 above is safe because HMP output has an ending newline
+             * and the glib array ends on two NULL slots.
+             */
+        }
+    } else {
+        g_test_message("expected vs. found (whitespace ignored):"
+                       "\n---\n%s\n---\n%s\n---", str, g_strjoinv(" ", t2));
+    }
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
+            assert_hmp_match(t->output1, resp, true);
+            continue;
+        }
+        assert_hmp_success(resp);
+        g_free(resp);
+
+        resp = qtest_hmp(qts, "info migrate_parameters");
+
+        line = g_strconcat(t->input1, ": ", t->output1, NULL);
+        assert_hmp_match(line, resp, true);
+    }
+
+    qtest_quit(qts);
+}
+
+static void hmp_sock_write(int fd, const char *buf)
+{
+    size_t sz = strlen(buf);
+
+    assert(fd > 0);
+    assert(write(fd, buf, sz) == sz);
+}
+
+static void hmp_sock_read(int fd, char *buf, size_t buf_sz)
+{
+    char *p = buf;
+    size_t sz = buf_sz - 1;
+
+    assert(fd >= 0);
+    memset(buf, 0, buf_sz);
+
+    while (sz > 0) {
+        ssize_t r = read(fd, p, sz);
+        char *prompt;
+
+        if (!r) {
+            break;
+        } else if (r < 0) {
+            if (errno == EINTR) {
+                continue;
+            }
+            g_assert_not_reached();
+        }
+
+        p += r;
+        sz -= r;
+
+        prompt = strstr(buf, "(qemu) ");
+        if (prompt) {
+            *prompt = '\0';
+            break;
+        }
+    }
+}
+
+static void test_hmp_completion(char *name, MigrateCommon *args)
+{
+    g_autofree char *cmdline;
+    QTestState *qts;
+    char buf[1024];
+    int sockfds[2];
+
+    assert(!qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, sockfds));
+    qemu_clear_cloexec(sockfds[1]);
+
+    cmdline = g_strdup_printf("-chardev socket,id=mon0,fd=%d "
+                              "-mon chardev=mon0,mode=readline -S",
+                              sockfds[1]);
+    qts = qtest_init(cmdline);
+    close(sockfds[1]);
+
+    /* read HMP banner */
+    hmp_sock_read(sockfds[0], buf, sizeof(buf));
+
+    for (int i = 0; i < G_N_ELEMENTS(completion_cases); i++) {
+        const struct HMPTestData *t = &completion_cases[i];
+        char *output;
+
+        hmp_sock_write(sockfds[0], t->input1);
+        hmp_sock_read(sockfds[0], buf, sizeof(buf));
+
+        /*
+         * readline first rewrites the input to the common root of the
+         * completions, then outputs the completion suggestions:
+         *
+         * (qemu) info migr<TAB>
+         * (qemu) migrate migrate_parameters
+         * migrate_capabilities ...
+         */
+        output = strstr(buf, t->input2);
+        assert_hmp_match(t->output1, output, false);
+
+        /* ^U backward kill line */
+        hmp_sock_write(sockfds[0], "\x15");
+    }
+
+    close(sockfds[0]);
+    qtest_quit(qts);
+}
 
 static void test_baddest(char *name, MigrateCommon *args)
 {
@@ -260,4 +575,8 @@ void migration_test_add_misc(MigrationTestEnv *env)
                        test_validate_uri_channels_both_set);
     migration_test_add("/migration/validate_uri/channels/none_set",
                        test_validate_uri_channels_none_set);
+    migration_test_add("/migration/hmp/parameters",
+                       test_hmp_migration_parameters);
+    migration_test_add("/migration/hmp/completion",
+                       test_hmp_completion);
 }
-- 
2.53.0


