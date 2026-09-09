Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D96AC79FBB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 21:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Q73-0000YO-Du; Wed, 09 Sep 2026 17:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4Q71-0000Xl-7N
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:45:47 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x4Q6z-0005PL-9F
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 17:45:46 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EE3551FCCD;
 Wed,  9 Sep 2026 21:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788990340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NrRt2zkbA6j0V7SUX18LjSlV5FjxLmUozt4V6iG7yGY=;
 b=Wk2Lte0eccnb4rfaAaws93FcZkqS9G09wFUon7pQ+Ve2FrtX2waRLjBH/75Ip+GmQeqTIo
 /8HlX4ROQqEvyVXb8nieT2Tdfo9ZmLk413ABk993Rjna0HH41otA1ZZqJ5VAmaHKh9BZjn
 U0m2wPJSFL0bMfshx/9KgIGUU31La2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788990340;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NrRt2zkbA6j0V7SUX18LjSlV5FjxLmUozt4V6iG7yGY=;
 b=FHf2SErsb1LlMpFvZCuZSKqrfyFNHjJCVGzqth2MBZPhH6QDMji3EXeQs0wWwu57tsauVg
 p5SBmhbrFX7Ca6Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Gwez1hke;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+zj8UL4l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788990335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NrRt2zkbA6j0V7SUX18LjSlV5FjxLmUozt4V6iG7yGY=;
 b=Gwez1hke80SntOkVq9YMYm5GjLR3A/fErkzz4nuzWBIZ4m8pmfpMvkI7oaJP9/5ERMuvLy
 zXwVt0Z71rZiXv8OcW83h+5O+Y3ZCBKDWHcB4vyFSIdsEZsf+L7lhdQZxJNN4a3n+WN+dk
 hF04u1r+ZToMkxKe9ZGGGe6l58AqM34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788990335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NrRt2zkbA6j0V7SUX18LjSlV5FjxLmUozt4V6iG7yGY=;
 b=+zj8UL4lwe35zpNY8kAJTbtk8uzo6GEdwyDLlvA+83t6PUb/U+eGRjbquLXo2KfvbCoWPm
 KwafSgN1E6PobkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20F5D137EC;
 Wed,  9 Sep 2026 21:45:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EDsAN33ToWqzawAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 09 Sep 2026 21:45:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 10/18] tests/qtest/migration: Add a test for HMP completion
Date: Wed,  9 Sep 2026 18:45:00 -0300
Message-ID: <20260909214509.237309-11-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909214509.237309-1-farosas@suse.de>
References: <20260909214509.237309-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE3551FCCD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

The following patches will touch HMP readline completion for migration
parameters, add a test case.

The test puts the monitor on a chardev via socket and bypasses qtest
facilities because it needs to emit raw codes to readline. It
therefore requires a couple of new helpers to read/write to the
monitor socket.

Usage:
QTEST_QEMU_BINARY=./qemu-system-x86_64 \
./tests/qtest/migration-test --full -p /x86_64/migration/hmp/completion

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/misc-tests.c | 192 +++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 533cf3d55d..04f46d5e81 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/sockets.h"
 #include "qapi/error.h"
 #include "qobject/qjson.h"
 #include "libqtest.h"
@@ -99,6 +100,46 @@ HMPTestData test_cases[] = {
          "can only be set through QMP"),
 };
 
+/*
+ * .input1:  partial string with an ending TAB (as if pressed by
+ *           the user).
+ * .input2:  common root of the completions, i.e. what the partial
+ *           part of .input1 string completes to.
+ * .output1: full list of completion suggestions for the string
+ *           in .input2.
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
+
+    TEST("migrate_se\t",
+         "migrate_set_",
+         "migrate_set_capability migrate_set_parameter"),
+
+    /*
+     * parameters and capabilities are not listed here to avoid having
+     * to enumerate them all, see test_hmp_completion().
+     */
+    TEST("migrate_set_parameter \t", "migrate_set_parameter ", "@params@"),
+    TEST("migrate_set_capability \t", "migrate_set_capability ", "@caps@"),
+};
+
 /*
  * Find a contiguous run of tokens in @larger that match the sequence
  * of tokens in @smaller, ignoring mismatches due to sequences of
@@ -141,6 +182,22 @@ static bool token_list_is_substr(char **smaller, char **larger, int *last)
     return match;
 }
 
+static void assert_hmp_match_text(const char *str, const char *text)
+{
+    g_auto(GStrv) tok_str = g_strsplit_set(str, " ", -1);
+    g_auto(GStrv) tok_txt = g_strsplit_set(text, " \r\n", -1);
+    int idx;
+
+    if (token_list_is_substr(tok_str, tok_txt, &idx)) {
+        return;
+    }
+
+    g_test_message("HMP output mismatch for entry at line %d:", test_case_line);
+    g_test_message("expected vs. found (whitespace ignored):\n\n%s\n---\n%s",
+                   str, text);
+    g_assert_not_reached();
+}
+
 static void assert_hmp_match_line(const char *str, const char *text)
 {
     g_auto(GStrv) tok_str = g_strsplit_set(str, " ", -1);
@@ -217,6 +274,139 @@ static void test_hmp_migration_parameters(char *name, MigrateCommon *args)
 
     qtest_quit(qts);
 }
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
+static int comp(const void *a, const void *b)
+{
+    return strcmp(*(const char **) a, *(const char **) b);
+}
+
+static void get_migration_opts_sorted(GString *exp, const char * const *lookup, int n)
+{
+    g_autofree char **opts_array = g_new0(char *, n);
+    uint8_t i;
+
+    for (i = 0; i < n; i++) {
+        opts_array[i] = g_strdup(lookup[i]);
+    }
+
+    qsort(opts_array, n, sizeof(char *), comp);
+
+    for (i = 0; i < n; i++) {
+        g_string_append(exp, opts_array[i]);
+        if (i + 1 != n) {
+            g_string_append(exp, " ");
+        }
+    }
+
+    for (i = 0; i < n; i++) {
+        g_free(opts_array[i]);
+    }
+}
+
+static void hmp_completion_single(int fd, const struct HMPTestData *t)
+{
+    g_autoptr(GString) exp = g_string_new("");
+    char buf[8192];
+    char *output;
+
+    test_case_line = t->line;
+
+    if (g_str_equal(t->output1, "@caps@")) {
+        g_string_append(exp, "migrate_set_capability ");
+        get_migration_opts_sorted(exp, MigrationCapability_lookup.array,
+                                  MIGRATION_CAPABILITY__MAX);
+    } else if (g_str_equal(t->output1, "@params@")) {
+        g_string_append(exp, "migrate_set_parameter ");
+        get_migration_opts_sorted(exp, MigrationParameter_lookup.array,
+                                  MIGRATION_PARAMETER__MAX);
+    } else {
+        g_string_append(exp, t->output1);
+    }
+
+    hmp_sock_write(fd, t->input1);
+    hmp_sock_read(fd, buf, sizeof(buf));
+
+    /*
+     * readline first rewrites the input to the common root of the
+     * completions, then outputs the completion suggestions:
+     *
+     * (qemu) info migr<TAB>
+     * (qemu) migrate migrate_parameters
+     * migrate_capabilities ...
+     */
+    output = strstr(buf, t->input2);
+    assert_hmp_match_text(exp->str, output);
+
+    /* ^U backward kill line */
+    hmp_sock_write(fd, "\x15");
+}
+
+static void test_hmp_completion(char *name, MigrateCommon *args)
+{
+    g_autofree char *cmdline;
+    char buf[1024];
+    QTestState *qts;
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
+        hmp_completion_single(sockfds[0], &completion_cases[i]);
+    }
+
+    close(sockfds[0]);
+    qtest_quit(qts);
+}
 #endif /* CONFIG_HMP */
 
 static void test_baddest(char *name, MigrateCommon *args)
@@ -460,5 +650,7 @@ void migration_test_add_misc(MigrationTestEnv *env)
 #ifdef CONFIG_HMP
     migration_test_add("/migration/hmp/parameters",
                        test_hmp_migration_parameters);
+    migration_test_add("/migration/hmp/completion",
+                       test_hmp_completion);
 #endif
 }
-- 
2.53.0


