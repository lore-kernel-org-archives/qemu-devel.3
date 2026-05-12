Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384FDCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuPP-0005Gp-3X; Tue, 12 May 2026 17:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMuPB-0004kP-7e
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:12:42 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wMuP5-0004r7-59
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:12:40 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4317175FC7;
 Tue, 12 May 2026 21:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778620350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jnoN/Tz6O4AzecKz+r6ebQN9d3JB//KpmQgWzPeHqik=;
 b=OQ2rS17j5LpNbKmZA+IH7LfEh5tZLl//axCTmxOwgOuojJ2ChVrqfcRtgUILVh2+tIObmx
 LiJosUxgSHm/1klUKP9Keg4TdIhFgdJEZf6q9Cw8+VT8XplyPFj/tSQ9gtzaT0nyyTe90P
 Sev0e2T1Dcni7zvwmGqwMcC5yGLLAEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778620350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jnoN/Tz6O4AzecKz+r6ebQN9d3JB//KpmQgWzPeHqik=;
 b=tOEKz8xGgsUeqd29LMjpGDLFn8ayEc22QurqnVrIhcpauBlBJCArEk3OdWxQJyuKQpqjxG
 /+97sGjDuxe9pSAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778620350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jnoN/Tz6O4AzecKz+r6ebQN9d3JB//KpmQgWzPeHqik=;
 b=OQ2rS17j5LpNbKmZA+IH7LfEh5tZLl//axCTmxOwgOuojJ2ChVrqfcRtgUILVh2+tIObmx
 LiJosUxgSHm/1klUKP9Keg4TdIhFgdJEZf6q9Cw8+VT8XplyPFj/tSQ9gtzaT0nyyTe90P
 Sev0e2T1Dcni7zvwmGqwMcC5yGLLAEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778620350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jnoN/Tz6O4AzecKz+r6ebQN9d3JB//KpmQgWzPeHqik=;
 b=tOEKz8xGgsUeqd29LMjpGDLFn8ayEc22QurqnVrIhcpauBlBJCArEk3OdWxQJyuKQpqjxG
 /+97sGjDuxe9pSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E7FE593A9;
 Tue, 12 May 2026 21:12:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WOD5E72XA2r+IAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 12 May 2026 21:12:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 2/4] tests/qtest: Individual verbose switches
Date: Tue, 12 May 2026 18:12:19 -0300
Message-ID: <20260512211221.3173-3-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260512211221.3173-1-farosas@suse.de>
References: <20260512211221.3173-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

Allow logging to be set for specific parts of QTest. Having a single
QTEST_LOG knob creates an output stream that is almost useless due to
spamming from some operations.

Add a backward-compatible way of selecting which parts will be made
verbose. Reuse the existing QTEST_LOG variable. The new options are:

QTEST_LOG=
fuzz - fuzz.c
qga - unit/test-qga.c
qmp - libqmp.c
qtest - QTest device, i.e. -qtest-log option
test - generic term for usage of all tests

E.g.:

QTEST_LOG=fuzz,qga,qmp,qtest,test
  equivalent to QTEST_LOG=1

QTEST_LOG=qmp,qtest
  enables logging of qmp operations from libqmp.c and logging of the
  qtest device.

QTEST_LOG=test,qmp
  enable test output and libqmp.c output.

QTEST_LOG=-qmp
  enable all output, except for libqmp.c

Acked-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260429003130.15164-3-farosas@suse.de
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/fuzz/fuzz.c               |  7 ++--
 tests/qtest/fuzz/generic_fuzz.c       |  2 +-
 tests/qtest/libqmp.c                  |  7 ++--
 tests/qtest/libqtest.c                | 56 ++++++++++++++++++++++++++-
 tests/qtest/libqtest.h                | 11 ++++++
 tests/qtest/migration/framework.c     |  2 +-
 tests/qtest/migration/framework.h     |  5 ++-
 tests/qtest/migration/precopy-tests.c |  2 +-
 tests/unit/meson.build                |  2 +-
 tests/unit/test-qga.c                 |  2 +-
 10 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index ca248a51a6..d235598961 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -105,7 +105,7 @@ static void usage(char *path)
            "Set the environment variable FUZZ_SERIALIZE_QTEST=1 to serialize\n"
            "QTest commands into an ASCII protocol. Useful for building crash\n"
            "reproducers, but slows down execution.\n\n"
-           "Set the environment variable QTEST_LOG=1 to log all qtest commands"
+           "Set the environment variable QTEST_LOG=fuzz to log all qtest commands"
            "\n");
     exit(0);
 }
@@ -168,6 +168,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
     GString *cmd_line;
     gchar *pretty_cmd_line;
     bool serialize = false;
+    bool verbose = qtest_verbose("fuzz");
 
     /* Initialize qgraph and modules */
     qos_graph_init();
@@ -211,14 +212,14 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
     /* Run QEMU's system main with the fuzz-target dependent arguments */
     cmd_line = fuzz_target->get_init_cmdline(fuzz_target);
     g_string_append_printf(cmd_line, " %s -qtest /dev/null ",
-                           getenv("QTEST_LOG") ? "" : "-qtest-log none");
+                           verbose ? "" : "-qtest-log none");
 
     /* Split the runcmd into an argv and argc */
     wordexp_t result;
     wordexp(cmd_line->str, &result, 0);
     g_string_free(cmd_line, true);
 
-    if (getenv("QTEST_LOG")) {
+    if (verbose) {
         pretty_cmd_line  = g_strjoinv(" ", result.we_wordv + 1);
         printf("Starting %s with Arguments: %s\n",
                 result.we_wordv[0], pretty_cmd_line);
diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index 440de25034..e48f868775 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -776,7 +776,7 @@ static void generic_pre_fuzz(QTestState *s)
     if (!getenv("QEMU_FUZZ_OBJECTS")) {
         usage();
     }
-    if (getenv("QTEST_LOG")) {
+    if (qtest_verbose("fuzz")) {
         qtest_log_enabled = 1;
     }
     if (getenv("QEMU_AVOID_DOUBLE_FETCH")) {
diff --git a/tests/qtest/libqmp.c b/tests/qtest/libqmp.c
index 16fe546885..cd12bd2678 100644
--- a/tests/qtest/libqmp.c
+++ b/tests/qtest/libqmp.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "libqmp.h"
+#include "libqtest.h"
 
 #ifndef _WIN32
 #include <sys/socket.h>
@@ -62,7 +63,7 @@ static void qmp_response(void *opaque, QObject *obj, Error *err)
 QDict *qmp_fd_receive(int fd)
 {
     QMPResponseParser qmp;
-    bool log = getenv("QTEST_LOG") != NULL;
+    bool log = qtest_verbose("qmp");
 
     qmp.response = NULL;
     json_message_parser_init(&qmp.parser, qmp_response, &qmp, NULL);
@@ -149,7 +150,7 @@ _qmp_fd_vsend_fds(int fd, int *fds, size_t fds_num,
 
     /* No need to send anything for an empty QObject.  */
     if (qobj) {
-        int log = getenv("QTEST_LOG") != NULL;
+        bool log = qtest_verbose("qmp");
         GString *str = qobject_to_json(qobj);
 
         /*
@@ -220,7 +221,7 @@ void qmp_fd_send(int fd, const char *fmt, ...)
 
 void qmp_fd_vsend_raw(int fd, const char *fmt, va_list ap)
 {
-    bool log = getenv("QTEST_LOG") != NULL;
+    bool log = qtest_verbose("qmp");
     char *str = g_strdup_vprintf(fmt, ap);
 
     if (log) {
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index dc4a665cfa..bf9284b9a1 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -469,7 +469,7 @@ gchar *qtest_qemu_args(const char *extra_args)
                       "-accel qtest",
 
                       socket_path,
-                      getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL,
+                      qtest_verbose("qtest") ? DEV_STDERR : DEV_NULL,
                       qmp_socket_path,
                       can_exit_with_parent() ?
                       "-run-with exit-with-parent=on" : "",
@@ -2142,3 +2142,57 @@ bool mkimg(const char *file, const char *fmt, unsigned size_mb)
 
     return ret && !err;
 }
+
+bool qtest_verbose(const char *domain)
+{
+    const char *log = getenv("QTEST_LOG");
+    char *found;
+
+    assert(domain);
+
+    if (log) {
+        /*
+         * verbose=true for all domains if:
+         *  QTEST_LOG=
+         *  QTEST_LOG=1
+         *  other one-character variations
+         */
+        if (log[0] == '\0' || log[1] == '\0') {
+            return true;
+        }
+
+        /*
+         * verbose=true for specified domains if:
+         *  QTEST_LOG=<domain>
+         *  QTEST_LOG=<domain1>,<domain2>
+         *  allows other separators, except - and +
+         *
+         * verbose=false for specified domains if:
+         *  QTEST_LOG=-<domain>
+         *  QTEST_LOG=<domain1>,-<domain2> (only false for domain2)
+         *  allows other separators, except - and +
+         */
+        found = strstr(log, domain);
+
+        if (found) {
+            /* reject options given twice */
+            assert(!strstr(found + strlen(domain), domain));
+
+            if (found > log) {
+                ptrdiff_t i = found - log - 1;
+                if (log[i] == '-') {
+                    return false;
+                }
+            }
+            return true;
+        } else {
+            /*
+             * If filtering out a specific domain, all others are
+             * enabled.
+             */
+            return !!strstr(log, "-");
+        }
+    }
+
+    return false;
+}
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 9c118c89ca..950ea2baaf 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -1178,4 +1178,15 @@ bool have_qemu_img(void);
  */
 bool mkimg(const char *file, const char *fmt, unsigned size_mb);
 
+/**
+ * qtest_verbose:
+ * @domain: The logging domain
+ *
+ * Read the QTEST_LOG environment variable and return whether the
+ * specified domain is enabled for verbose logging. Enable specific
+ * logging domains with QTEST_LOG=<domain> or use QTEST_LOG=-<domain> to
+ * enable all domains except for the specific one.
+ */
+bool qtest_verbose(const char *domain);
+
 #endif
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 9f71d51f1e..49c7f37e60 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -365,7 +365,7 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
         g_assert_not_reached();
     }
 
-    if (!getenv("QTEST_LOG") && args->hide_stderr) {
+    if (!qtest_verbose("test") && args->hide_stderr) {
 #ifndef _WIN32
         ignore_stderr = "2>/dev/null";
 #else
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 79604c60f5..bb534b8110 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -118,8 +118,9 @@ typedef void (*TestMigrateEndHook)(QTestState *from,
  */
 typedef struct {
     /*
-     * QTEST_LOG=1 may override this.  When QTEST_LOG=1, we always dump errors
-     * unconditionally, because it means the user would like to be verbose.
+     * QTEST_LOG=test may override this in which case we dump errors
+     * unconditionally, because it means the user would like to be
+     * verbose.
      */
     bool hide_stderr;
     MemType mem_type;
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index a0e3ff0547..e65d9e04a5 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -130,7 +130,7 @@ static bool mlock_check(void)
 static int new_rdma_link(char *buffer, bool ipv6)
 {
     char cmd[256];
-    bool verbose = g_getenv("QTEST_LOG");
+    bool verbose = qtest_verbose("test");
 
     snprintf(cmd, sizeof(cmd), "IP_FAMILY=%s %s detect %s",
              ipv6 ? "ipv6" : "ipv4", RDMA_MIGRATION_HELPER,
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 03d36748c7..de64f9501f 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -161,7 +161,7 @@ if have_system
 endif
 
 if have_ga and host_os == 'linux'
-  tests += {'test-qga': ['../qtest/libqmp.c']}
+  tests += {'test-qga': ['../qtest/libqmp.c', '../qtest/libqtest.c']}
   test_deps += {'test-qga': qga}
 endif
 
diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
index 587e30c7e4..01ccf826e6 100644
--- a/tests/unit/test-qga.c
+++ b/tests/unit/test-qga.c
@@ -68,7 +68,7 @@ fixture_setup(TestFixture *fixture, gconstpointer data, gchar **envp)
     cmd = g_strdup_printf("%s%cqga%cqemu-ga -m unix-listen -t %s -p %s %s %s",
                           cwd, G_DIR_SEPARATOR, G_DIR_SEPARATOR,
                           fixture->test_dir, path,
-                          getenv("QTEST_LOG") ? "-v" : "",
+                          qtest_verbose("qga") ? "-v" : "",
                           extra_arg ?: "");
     g_shell_parse_argv(cmd, NULL, &argv, &error);
     g_assert_no_error(error);
-- 
2.51.0


