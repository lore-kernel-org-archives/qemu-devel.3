Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BAFC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKiTQ-0003JZ-7B; Fri, 21 Jun 2024 13:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTO-0003Io-JS
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:54:54 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKiTM-0003Ka-EE
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:54:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D9CB1F7F2;
 Fri, 21 Jun 2024 17:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DM7bpjwD6k46025A+PQR6pcH6H0GhzHZ0gk1D0eZ6c=;
 b=AaNesnP+Wl6WawD1eTdqwUp1t/ulk4HOLN466Wddt3GQb8P821t6zbrwmwle91+nQ6vRaU
 Wgbo5FWA8cOOExCtz5n5cpAsI8EULul673qFhvsqqk9tJekd0wmekz8jkm4TcHYZ8p3viO
 zCGmrm7SeXZUSzcSKB7dF+a+W4ji9F8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DM7bpjwD6k46025A+PQR6pcH6H0GhzHZ0gk1D0eZ6c=;
 b=HYmI5JK6QTsi1xgfXSLGIBeh+vIZNuZcsfrs8h196pfOiX0IIKlgiRoaIIvdifrhDADfhB
 qq841a/Onr0tLEDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718992491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DM7bpjwD6k46025A+PQR6pcH6H0GhzHZ0gk1D0eZ6c=;
 b=AaNesnP+Wl6WawD1eTdqwUp1t/ulk4HOLN466Wddt3GQb8P821t6zbrwmwle91+nQ6vRaU
 Wgbo5FWA8cOOExCtz5n5cpAsI8EULul673qFhvsqqk9tJekd0wmekz8jkm4TcHYZ8p3viO
 zCGmrm7SeXZUSzcSKB7dF+a+W4ji9F8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718992491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DM7bpjwD6k46025A+PQR6pcH6H0GhzHZ0gk1D0eZ6c=;
 b=HYmI5JK6QTsi1xgfXSLGIBeh+vIZNuZcsfrs8h196pfOiX0IIKlgiRoaIIvdifrhDADfhB
 qq841a/Onr0tLEDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DE6E13AAA;
 Fri, 21 Jun 2024 17:54:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oC8iMWm+dWZNawAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 21 Jun 2024 17:54:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/28] monitor: Stop removing non-duplicated fds
Date: Fri, 21 Jun 2024 14:54:13 -0300
Message-Id: <20240621175434.31180-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240621175434.31180-1-farosas@suse.de>
References: <20240621175434.31180-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

monitor_fdsets_cleanup() currently has three responsibilities:

1- Remove the fds that have been marked for removal(->removed=true) by
   qmp_remove_fd(). This is overly complicated, but ok.

2- Remove any file descriptors that have been passed into QEMU and
   never duplicated[1,2]. A file descriptor without duplicates
   indicates that no part of QEMU has made use of it. This is
   problematic because the current implementation does it only if the
   guest is not running and the monitor is closed.

3- Remove/free fdsets that have become empty due to the above
   removals. This is ok.

The scenario described in (2) is starting to show some cracks now that
we're trying to consume fds from the migration code:

- Doing cleanup every time the last monitor connection closes works to
  reap unused fds, but also has the side effect of forcing the
  management layer to pass the file descriptors again in case of a
  disconnect/re-connect, if that happened to be the only monitor
  connection.

  Another side effect is that removing an fd with qmp_remove_fd() is
  effectively delayed until the last monitor connection closes.

  The usage of mon_refcount is also problematic because it's racy.

- Checking runstate_is_running() skips the cleanup unless the VM is
  running and avoids premature cleanup of the fds, but also has the
  side effect of blocking the legitimate removal of an fd via
  qmp_remove_fd() if the VM happens to be in another state.

  This affects qmp_remove_fd() and qmp_query_fdsets() in particular
  because requesting a removal at a bad time (guest stopped) might
  cause an fd to never be removed, or to be removed at a much later
  point in time, causing the query command to continue showing the
  supposedly removed fd/fdset.

Note that file descriptors that *have* been duplicated are owned by
the code that uses them and will be removed after qemu_close() is
called. Therefore we've decided that the best course of action to
avoid the undesired side-effects is to stop managing non-duplicated
file descriptors.

1- efb87c1697 ("monitor: Clean up fd sets on monitor disconnect")
2- ebe52b592d ("monitor: Prevent removing fd from set during init")

Reviewed-by: Peter Xu <peterx@redhat.com>
[fix logic mistake: s/fdset_free/fdset_free_if_empty]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 monitor/fds.c                | 15 ++++---
 monitor/hmp.c                |  2 -
 monitor/monitor-internal.h   |  1 -
 monitor/monitor.c            |  1 -
 monitor/qmp.c                |  2 -
 tests/qtest/libqtest.c       | 15 ++++---
 tests/qtest/libqtest.h       |  2 +
 tests/qtest/migration-test.c | 82 ++++++++++++++++++++++++++++++++++++
 8 files changed, 102 insertions(+), 18 deletions(-)

diff --git a/monitor/fds.c b/monitor/fds.c
index bd45a26368..76199d4b3b 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -175,6 +175,11 @@ static void monitor_fdset_free(MonFdset *mon_fdset)
 
 static void monitor_fdset_free_if_empty(MonFdset *mon_fdset)
 {
+    /*
+     * Only remove an empty fdset. The fds are owned by the user and
+     * should have been removed with qmp_remove_fd(). The dup_fds are
+     * owned by QEMU and should have been removed with qemu_close().
+     */
     if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
         monitor_fdset_free(mon_fdset);
     }
@@ -194,9 +199,7 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
     MonFdsetFd *mon_fdset_fd_next;
 
     QLIST_FOREACH_SAFE(mon_fdset_fd, &mon_fdset->fds, next, mon_fdset_fd_next) {
-        if ((mon_fdset_fd->removed ||
-                (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
-                runstate_is_running()) {
+        if (mon_fdset_fd->removed) {
             monitor_fdset_fd_free(mon_fdset_fd);
         }
     }
@@ -211,7 +214,7 @@ void monitor_fdsets_cleanup(void)
 
     QEMU_LOCK_GUARD(&mon_fdsets_lock);
     QLIST_FOREACH_SAFE(mon_fdset, &mon_fdsets, next, mon_fdset_next) {
-        monitor_fdset_cleanup(mon_fdset);
+        monitor_fdset_free_if_empty(mon_fdset);
     }
 }
 
@@ -484,9 +487,7 @@ void monitor_fdset_dup_fd_remove(int dup_fd)
             if (mon_fdset_fd_dup->fd == dup_fd) {
                 QLIST_REMOVE(mon_fdset_fd_dup, next);
                 g_free(mon_fdset_fd_dup);
-                if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
-                    monitor_fdset_cleanup(mon_fdset);
-                }
+                monitor_fdset_free_if_empty(mon_fdset);
                 return;
             }
         }
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 69c1b7e98a..460e8832f6 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1437,11 +1437,9 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
             monitor_resume(mon);
         }
         qemu_mutex_unlock(&mon->mon_lock);
-        mon_refcount++;
         break;
 
     case CHR_EVENT_CLOSED:
-        mon_refcount--;
         monitor_fdsets_cleanup();
         break;
 
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 252de85681..cb628f681d 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -168,7 +168,6 @@ extern bool qmp_dispatcher_co_shutdown;
 extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
-extern int mon_refcount;
 
 extern HMPCommand hmp_cmds[];
 
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 01ede1babd..db52a9c7ef 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -71,7 +71,6 @@ static GHashTable *monitor_qapi_event_state;
 static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
 
 MonitorList mon_list;
-int mon_refcount;
 static bool monitor_destroyed;
 
 Monitor *monitor_cur(void)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index a239945e8d..5e538f34c0 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -466,7 +466,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
         data = qmp_greeting(mon);
         qmp_send_response(mon, data);
         qobject_unref(data);
-        mon_refcount++;
         break;
     case CHR_EVENT_CLOSED:
         /*
@@ -479,7 +478,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
         json_message_parser_destroy(&mon->parser);
         json_message_parser_init(&mon->parser, handle_qmp_command,
                                  mon, NULL);
-        mon_refcount--;
         monitor_fdsets_cleanup();
         break;
     case CHR_EVENT_BREAK:
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 18e2f7f282..c7f6897d78 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -514,11 +514,6 @@ static QTestState *qtest_init_internal(const char *qemu_bin,
         kill(s->qemu_pid, SIGSTOP);
     }
 #endif
-
-    /* ask endianness of the target */
-
-    s->big_endian = qtest_query_target_endianness(s);
-
     return s;
 }
 
@@ -527,11 +522,21 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     return qtest_init_internal(qtest_qemu_binary(NULL), extra_args);
 }
 
+QTestState *qtest_init_with_env_no_handshake(const char *var,
+                                             const char *extra_args)
+{
+    return qtest_init_internal(qtest_qemu_binary(var), extra_args);
+}
+
 QTestState *qtest_init_with_env(const char *var, const char *extra_args)
 {
     QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args);
     QDict *greeting;
 
+    /* ask endianness of the target */
+
+    s->big_endian = qtest_query_target_endianness(s);
+
     /* Read the QMP greeting and then do the handshake */
     greeting = qtest_qmp_receive(s);
     qobject_unref(greeting);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index beb96b18eb..c261b7e0b3 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -68,6 +68,8 @@ QTestState *qtest_init(const char *extra_args);
  */
 QTestState *qtest_init_with_env(const char *var, const char *extra_args);
 
+QTestState *qtest_init_with_env_no_handshake(const char *var,
+                                             const char *extra_args);
 /**
  * qtest_init_without_qmp_handshake:
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 22b07bc0ec..eb4d5948e0 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -64,6 +64,7 @@ static QTestMigrationState dst_state;
 #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
 
 #define ANALYZE_SCRIPT "scripts/analyze-migration.py"
+#define VMSTATE_CHECKER_SCRIPT "scripts/vmstate-static-checker.py"
 
 #define QEMU_VM_FILE_MAGIC 0x5145564d
 #define FILE_TEST_FILENAME "migfile"
@@ -1589,6 +1590,85 @@ static void test_analyze_script(void)
     test_migrate_end(from, to, false);
     cleanup("migfile");
 }
+
+static void test_vmstate_checker_script(void)
+{
+    g_autofree gchar *cmd_src = NULL;
+    g_autofree gchar *cmd_dst = NULL;
+    g_autofree gchar *vmstate_src = NULL;
+    g_autofree gchar *vmstate_dst = NULL;
+    const char *machine_alias, *machine_opts = "";
+    g_autofree char *machine = NULL;
+    const char *arch = qtest_get_arch();
+    int pid, wstatus;
+    const char *python = g_getenv("PYTHON");
+
+    if (!getenv(QEMU_ENV_SRC) && !getenv(QEMU_ENV_DST)) {
+        g_test_skip("Test needs two different QEMU versions");
+        return;
+    }
+
+    if (!python) {
+        g_test_skip("PYTHON variable not set");
+        return;
+    }
+
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        if (g_str_equal(arch, "i386")) {
+            machine_alias = "pc";
+        } else {
+            machine_alias = "q35";
+        }
+    } else if (g_str_equal(arch, "s390x")) {
+        machine_alias = "s390-ccw-virtio";
+    } else if (strcmp(arch, "ppc64") == 0) {
+        machine_alias = "pseries";
+    } else if (strcmp(arch, "aarch64") == 0) {
+        machine_alias = "virt";
+    } else {
+        g_assert_not_reached();
+    }
+
+    if (!qtest_has_machine(machine_alias)) {
+        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
+        g_test_skip(msg);
+        return;
+    }
+
+    machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
+                                      QEMU_ENV_DST);
+
+    vmstate_src = g_strdup_printf("%s/vmstate-src", tmpfs);
+    vmstate_dst = g_strdup_printf("%s/vmstate-dst", tmpfs);
+
+    cmd_dst = g_strdup_printf("-machine %s,%s -dump-vmstate %s",
+                              machine, machine_opts, vmstate_dst);
+    cmd_src = g_strdup_printf("-machine %s,%s -dump-vmstate %s",
+                              machine, machine_opts, vmstate_src);
+
+    qtest_init_with_env_no_handshake(QEMU_ENV_SRC, cmd_src);
+    qtest_init_with_env_no_handshake(QEMU_ENV_DST, cmd_dst);
+
+    pid = fork();
+    if (!pid) {
+        close(1);
+        open("/dev/null", O_WRONLY);
+        execl(python, python, VMSTATE_CHECKER_SCRIPT,
+              "-s", vmstate_src,
+              "-d", vmstate_dst,
+              NULL);
+        g_assert_not_reached();
+    }
+
+    g_assert(waitpid(pid, &wstatus, 0) == pid);
+    if (!WIFEXITED(wstatus) || WEXITSTATUS(wstatus) != 0) {
+        g_test_message("Failed to run vmstate-static-checker.py");
+        g_test_fail();
+    }
+
+    cleanup("vmstate-src");
+    cleanup("vmstate-dst");
+}
 #endif
 
 static void test_precopy_common(MigrateCommon *args)
@@ -3522,6 +3602,8 @@ int main(int argc, char **argv)
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
     migration_test_add("/migration/analyze-script", test_analyze_script);
+    migration_test_add("/migration/vmstate-checker-script",
+                       test_vmstate_checker_script);
 #endif
 
     /*
-- 
2.35.3


