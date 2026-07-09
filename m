Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B5BC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whoN9-0001fa-OW; Thu, 09 Jul 2026 09:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1whoMy-0001c2-88
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:00:53 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phind.uet@gmail.com>)
 id 1whoMu-0008W3-Tl
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:00:47 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso1525395a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783602043; x=1784206843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lkGkC2aHmdrtLDzb/HV2Nyjr4DO6xZ+D9HeDhIbAcCc=;
 b=V00+BiXj48ZfmAd3JvvcQRQNdL4yo+KsFl+SAI1tL/vY0OkCTJ+a9r/PFbjSK/Hl1h
 VFtsgtEy/ITKNoSq5KIWc6RcJMTffvA0DrZ5I2FsvKMeM6/2OgupXe55zhcEkh+ZjhjB
 f+SYztfUxfAppK0/9IHUkaKhl+ZX56yH5tcfvZO7IGzoYaO2arCI3tTDmrxSjNtT8jo4
 Cf4yPj2W21vyc8KcsaQkD2pYGl10m9dv76KFlfmRprKKD1c9aK1nzWko/Aq1vHU5wvPB
 nIqWEjJqTMDnpXEb0dN0A0WTajurdESIyXGvh8wfhQSYJi9nSey83ipnXgOEC7snolOV
 m2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783602043; x=1784206843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lkGkC2aHmdrtLDzb/HV2Nyjr4DO6xZ+D9HeDhIbAcCc=;
 b=anguP3kEC98hlaO6uVjl2BBxZSCkneWvWCzFbuZ2z1mJMURMY3WPHl9+xDUr22+wa1
 J2loe7FtNBabuQMevtNRy6xWd3nCyvi2wxxwQhLowqutK5y+vl04xTDFquCdzRiOlraV
 vD49VYxRwRcyhXimFrFISKoAf6jZ1ytYRPHl9nm5yBYCrP+/ZSqFdouSS7yPSJkIPD5J
 FZEkUbumQyKUqA1/KPS9jfXLfrJAzlZnTAqkIM1SL62sh7efKLNTTrZEN8INGkKjo/Md
 oUSthWReJPgQeJsv38/LRBHvFjK9rKmAx8wH+ZsNgxpbdkXb6z4Ibw6OnVKoYKHs+KjX
 gKrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoflmWp9FNXqEIyNDggUh76yeudHAzqkKsMRFlUyNrnGaHF9wUo0zCRXmkeElrHKHKbD2LDlmGMajMi@nongnu.org
X-Gm-Message-State: AOJu0YxFAmqArXOuWR+3koc3PiscMENc3AHXUisnqkmI8Lp8GL4XgNJt
 8kkqsh64/5XI1m6VJC6WwuchKEY2aebVwUo0QVH7PBE1IwELoDHjKzb2
X-Gm-Gg: AfdE7cmXeljx7i00iDjZs9qHJ5ng5R0bInzCCYG5by/zvZ90BRJ4gF2GtvHkb9QY9md
 fJCD0lpcEZahBuDHA45vhs/kMct8JxvV1I59UIPxXgiCOjNShVfDXHS8SSmL4PezG0Zd7hNshYE
 dOhJYbA2wj2Ye08xj61lRUL1ph1lCqE45zJ8cH8F2cnDaEEcDG48wZqzb0ncbsL1NhJOBhUKU26
 axLsQWuC7ANBpQXhjFDp9V/brRMluQ3O/UaWP9bQTsiUSuVstOsBw6JVmMPJMmbaneOvpqviRAA
 OESY3/OWWEqT2BPVzAWkIa57yy8Yqp7ZI1CHZ1FzbOvEGJ8etmkAbyj5yzzCUQ/L6k1Faur7BdS
 Ff8F7uZ94vREBcZXt/vw27swV8NyiOQ3Ca+04rLgAFwa19aaV1gnuyizuSDcHwN0PPZuIXfFdFk
 PkAajI9Heha/l0NzSA5+Ls3egfjbtaAuSWLHGUXSKaiWr4lP2aqalrKmQf
X-Received: by 2002:a05:6a21:103:b0:3c0:9c1b:d0b6 with SMTP id
 adf61e73a8af0-3c0bd31298fmr8676661637.65.1783602043090; 
 Thu, 09 Jul 2026 06:00:43 -0700 (PDT)
Received: from C02G720XMD6P.sg.corp.seagroup.com ([111.223.92.222])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-31174ac14f2sm32908611eec.27.2026.07.09.06.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:00:42 -0700 (PDT)
From: phind.uet@gmail.com
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Nguyen Dinh Phi <phind.uet@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] tests/migration: Factor out per-process launch and setup
 helpers
Date: Thu,  9 Jul 2026 21:00:25 +0800
Message-ID: <20260709130032.58667-2-phind.uet@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260709130032.58667-1-phind.uet@gmail.com>
References: <20260709130032.58667-1-phind.uet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=phind.uet@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Nguyen Dinh Phi <phind.uet@gmail.com>

migrate_start() always spawned source and destination together, and
migrate_start_set_capabilities() required both QTestState pointers at
once. This coupling prevents launching a third QEMU instance or
re-configuring an existing destination as a new source.

Split the logic into three public helpers:

  migrate_launch_source() / migrate_launch_dest()
    Spawn a single QEMU process and record its serial file path on
    the returned QTestState.

  migrate_setup_instance()
    Register the event callback and apply migration capabilities to
    one already-running process.  Can be called again to re-wire the
    same process for a different role.

migrate_start() is kept for backward compatibility and now delegates
to these helpers internally.

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 tests/qtest/migration/framework.c | 253 +++++++++++++++++-------------
 tests/qtest/migration/framework.h |  18 ++-
 2 files changed, 165 insertions(+), 106 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index a830b96f41..305b8968ff 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -208,9 +208,11 @@ static QList *migrate_start_get_qmp_capabilities(const MigrateStart *args)
     return capabilities;
 }
 
-static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
-                                           MigrateStart *args)
+void migrate_setup_instance(QTestState *who, QTestMigrationState *state,
+                   MigrateStart *args)
 {
+    qtest_qmp_set_event_callback(who, migrate_watch_for_events, state);
+    *state = (QTestMigrationState) { .suspend_me = args->suspend_me };
     /*
      * MigrationCapability_lookup and MIGRATION_CAPABILITY_ constants
      * are from qapi-types-migration.h.
@@ -220,25 +222,13 @@ static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
      * Enable return path first, since other features depend on it.
      */
     if (args->caps[MIGRATION_CAPABILITY_RETURN_PATH]) {
-        if (from) {
-            migrate_set_capability(from, "return-path", true);
-        }
-        if (to) {
-            migrate_set_capability(to, "return-path", true);
-        }
+        migrate_set_capability(who, "return-path", true);
     }
 
     for (uint8_t i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-        if (!args->caps[i]) {
-            continue;
-        }
-        if (from) {
-            migrate_set_capability(from,
-                            MigrationCapability_lookup.array[i], true);
-        }
-        if (to) {
-            migrate_set_capability(to,
-                            MigrationCapability_lookup.array[i], true);
+        if (args->caps[i]) {
+            migrate_set_capability(who, MigrationCapability_lookup.array[i],
+                                   true);
         }
     }
 
@@ -246,26 +236,17 @@ static void migrate_start_set_capabilities(QTestState *from, QTestState *to,
      * Always enable migration events.  Libvirt always uses it, let's try
      * to mimic as closer as that.
      */
-    migrate_set_capability(from, "events", true);
-    if (!args->defer_target_connect && to) {
-        migrate_set_capability(to, "events", true);
-    }
+    migrate_set_capability(who, "events", true);
 
-    /*
+     /*
      * Default number of channels should be fine for most
      * tests. Individual tests can override by calling
      * migrate_set_parameter() directly.
      */
     if (args->caps[MIGRATION_CAPABILITY_MULTIFD]) {
-        migrate_set_parameter_int(from, "multifd-channels",
+        migrate_set_parameter_int(who, "multifd-channels",
                                   MULTIFD_TEST_CHANNELS);
-        if (to) {
-            migrate_set_parameter_int(to, "multifd-channels",
-                                      MULTIFD_TEST_CHANNELS);
-        }
     }
-
-    return;
 }
 
 static char *test_shmem_path(void)
@@ -308,12 +289,28 @@ static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
     return opts;
 }
 
-int migrate_args(char **from, char **to, MigrateStart *args)
+/*
+ * Build a QEMU command line for one migration participant.
+ *
+ * @serial_name  : serial output file basename under tmpfs
+ * @is_target    : set to true if the new qemu process is destination side
+ * @extra_opts   : extra arguments
+ * @defer_events : when true and is_target is set, use the command-line
+ *                 event flag instead of the QMP capability (for deferred
+ *                 monitor connections)
+ * @args         : common process settings
+ *
+ * Returns 0 and sets *cmd_out on success.  Returns -1 and calls
+ * g_test_skip() if the machine type is not available.
+ */
+static int migrate_build_cmd(const char *serial_name,
+                             bool is_target,
+                             const char *extra_opts,
+                             bool defer_events,
+                             MigrateStart *args,
+                             char **cmd_out)
 {
-    /* options for source and target */
     g_autofree gchar *arch_opts = NULL;
-    gchar *cmd_source = NULL;
-    gchar *cmd_target = NULL;
     const gchar *ignore_stderr;
     g_autofree char *mem_object = NULL;
     const char *kvm_opts = NULL;
@@ -323,16 +320,10 @@ int migrate_args(char **from, char **to, MigrateStart *args)
     g_autofree char *machine = NULL;
     const char *bootpath = bootfile_get();
     g_autofree char *memory_backend = NULL;
-    const char *events;
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         memory_size = "150M";
-
-        if (g_str_equal(arch, "i386")) {
-            machine_alias = "pc";
-        } else {
-            machine_alias = "q35";
-        }
+        machine_alias = g_str_equal(arch, "i386") ? "pc" : "q35";
         arch_opts = g_strdup_printf(
             "-drive if=none,id=d0,file=%s,format=raw "
             "-device ide-hd,drive=d0,secs=1,cyls=1,heads=1", bootpath);
@@ -346,13 +337,13 @@ int migrate_args(char **from, char **to, MigrateStart *args)
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
         memory_size = "256M";
-        start_address = PPC_TEST_MEM_START;
-        end_address = PPC_TEST_MEM_END;
         machine_alias = "pseries";
         machine_opts = "vsmt=8";
         arch_opts = g_strdup_printf(
             "-nodefaults -machine " PSERIES_DEFAULT_CAPABILITIES " "
             "-bios %s", bootpath);
+        start_address = PPC_TEST_MEM_START;
+        end_address = PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") == 0) {
         memory_size = "150M";
         machine_alias = "virt";
@@ -394,53 +385,103 @@ int migrate_args(char **from, char **to, MigrateStart *args)
     }
 
     if (!qtest_has_machine(machine_alias)) {
-        g_autofree char *msg = g_strdup_printf("machine %s not supported", machine_alias);
+        g_autofree char *msg = g_strdup_printf("machine %s not supported",
+                                               machine_alias);
         g_test_skip(msg);
         return -1;
     }
 
     machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
                                       QEMU_ENV_DST);
-
     g_test_message("Using machine type: %s", machine);
 
-    cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
-                                 "-machine %s,%s "
-                                 "-name source,debug-threads=on "
-                                 "%s "
-                                 "-serial file:%s/src_serial "
-                                 "%s %s %s",
-                                 kvm_opts ? kvm_opts : "",
-                                 machine, machine_opts,
-                                 memory_backend, tmpfs,
-                                 arch_opts ? arch_opts : "",
-                                 args->opts_source ? args->opts_source : "",
-                                 ignore_stderr);
+    if (is_target) {
+        /*
+         * If the monitor connection is deferred, enable events on the command
+         * line so none are missed. This is for testing only, do not set
+         * migration options like this in general.
+         */
+        const char *events = defer_events ? "-global migration.x-events=on"
+                                          : "";
+        *cmd_out = g_strdup_printf(
+            "-accel kvm%s -accel tcg "
+            "-machine %s,%s "
+            "-name target,debug-threads=on "
+            "%s "
+            "-serial file:%s/%s "
+            "-incoming defer "
+            "%s %s %s %s",
+            kvm_opts ? kvm_opts : "",
+            machine, machine_opts,
+            memory_backend, tmpfs, serial_name,
+            events,
+            arch_opts ? arch_opts : "",
+            extra_opts ? extra_opts : "",
+            ignore_stderr);
+    } else {
+        *cmd_out = g_strdup_printf(
+            "-accel kvm%s -accel tcg "
+            "-machine %s,%s "
+            "-name source,debug-threads=on "
+            "%s "
+            "-serial file:%s/%s "
+            "%s %s %s",
+            kvm_opts ? kvm_opts : "",
+            machine, machine_opts,
+            memory_backend, tmpfs, serial_name,
+            arch_opts ? arch_opts : "",
+            extra_opts ? extra_opts : "",
+            ignore_stderr);
+    }
 
-    /*
-     * If the monitor connection is deferred, enable events on the command line
-     * so none are missed.  This is for testing only, do not set migration
-     * options like this in general.
-     */
-    events = args->defer_target_connect ? "-global migration.x-events=on" : "";
-
-    cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
-                                 "-machine %s,%s "
-                                 "-name target,debug-threads=on "
-                                 "%s "
-                                 "-serial file:%s/dest_serial "
-                                 "-incoming defer "
-                                 "%s %s %s %s",
-                                 kvm_opts ? kvm_opts : "",
-                                 machine, machine_opts,
-                                 memory_backend, tmpfs,
-                                 events,
-                                 arch_opts ? arch_opts : "",
-                                 args->opts_target ? args->opts_target : "",
-                                 ignore_stderr);
-
-    *from = cmd_source;
-    *to = cmd_target;
+    return 0;
+}
+
+/*
+ * Launch a QEMU process as a migration source.
+ * Returns the QTestState on success, or NULL otherwise
+ */
+QTestState *migrate_launch_source(const char *serial_name, MigrateStart *args)
+{
+    g_autofree char *cmd = NULL;
+    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
+
+    if (migrate_build_cmd(serial_name, false, args->opts_source,
+                          false, args, &cmd)) {
+        return NULL;
+    }
+    return qtest_init_ext(QEMU_ENV_SRC, cmd, capabilities, true);
+}
+
+/*
+ * Launch a QEMU process as a migration destination.
+ * Returns the QTestState on success, or NULL otherwise
+ */
+QTestState *migrate_launch_dest(const char *serial_name, MigrateStart *args)
+{
+    g_autofree char *cmd = NULL;
+    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
+
+    if (migrate_build_cmd(serial_name, true, args->opts_target,
+                          args->defer_target_connect, args, &cmd)) {
+        return NULL;
+    }
+    return qtest_init_ext(QEMU_ENV_DST, cmd, capabilities,
+                          !args->defer_target_connect);
+}
+
+int migrate_args(char **from, char **to, MigrateStart *args)
+{
+    if (migrate_build_cmd("src_serial", false, args->opts_source,
+                          false, args, from)) {
+        return -1;
+    }
+    if (migrate_build_cmd("dest_serial", true, args->opts_target,
+                          args->defer_target_connect, args, to)) {
+        g_free(*from);
+        *from = NULL;
+        return -1;
+    }
     return 0;
 }
 
@@ -482,43 +523,45 @@ static void migrate_mem_type_cleanup(MemType type)
 
 int migrate_start(QTestState **from, QTestState **to, MigrateStart *args)
 {
-    g_autofree gchar *cmd_source = NULL;
-    g_autofree gchar *cmd_target = NULL;
-    g_autoptr(QList) capabilities = migrate_start_get_qmp_capabilities(args);
-
     if (!migrate_mem_type_prepare(args->mem_type)) {
         return -1;
     }
 
-    dst_state = (QTestMigrationState) { };
-    src_state = (QTestMigrationState) { };
+    src_state = (QTestMigrationState){};
+    dst_state = (QTestMigrationState){};
     bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
-    src_state.suspend_me = args->suspend_me;
-
-    if (migrate_args(&cmd_source, &cmd_target, args)) {
-        return -1;
-    }
 
     if (!args->only_target) {
-        *from = qtest_init_ext(QEMU_ENV_SRC, cmd_source, capabilities, true);
-        qtest_qmp_set_event_callback(*from,
-                                     migrate_watch_for_events,
-                                     &src_state);
+        *from = migrate_launch_source("src_serial", args);
+        if (!*from) {
+            return -1;
+        }
+        migrate_setup_instance(*from, &src_state, args);
     }
 
     if (!args->only_source) {
-        *to = qtest_init_ext(QEMU_ENV_DST, cmd_target, capabilities,
-                             !args->defer_target_connect);
-        qtest_qmp_set_event_callback(*to,
-                                     migrate_watch_for_events,
-                                     &dst_state);
+        *to = migrate_launch_dest("dest_serial", args);
+        if (!*to) {
+            if (!args->only_target) {
+                qtest_quit(*from);
+            }
+            return -1;
+        }
+        if (!args->defer_target_connect) {
+            migrate_setup_instance(*to, &dst_state, args);
+        } else {
+            /*
+             * The monitor is not connected yet; only register the event
+             * callback so no events are missed.
+             * The caller must call migrate_setup_instance() after
+             * qtest_connect() if it wants to setup any capability
+             */
+            qtest_qmp_set_event_callback(*to, migrate_watch_for_events,
+                                         &dst_state);
+        }
     }
 
     migrate_mem_type_cleanup(args->mem_type);
-    migrate_start_set_capabilities(*from,
-                                   args->only_source ? NULL : *to,
-                                   args);
-
     return 0;
 }
 
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 941cbd7102..f054ef8f4d 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -225,10 +225,27 @@ typedef struct {
     bool live;
 } MigrateCommon;
 
+typedef struct QTestMigrationState QTestMigrationState;
+
 void wait_for_serial(const char *side);
 void migrate_prepare_for_dirty_mem(QTestState *from);
 void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
 
+/*
+ * Start a QEMU process which has serial set to @serial_name
+ */
+QTestState *migrate_launch_source(const char *serial_name, MigrateStart *args);
+/*
+ * Start a QEMU process which has serial set to @serial_name
+ */
+QTestState *migrate_launch_dest(const char *serial_name, MigrateStart *args);
+/*
+ * Registers the event callback and sets migration capabilities on an
+ * already-running process
+ */
+void migrate_setup_instance(QTestState *who, QTestMigrationState *state,
+                   MigrateStart *args);
+
 int migrate_args(char **from, char **to, MigrateStart *args);
 int migrate_start(QTestState **from, QTestState **to, MigrateStart *args);
 void migrate_end(QTestState *from, QTestState *to, bool test_dest);
@@ -240,7 +257,6 @@ int test_precopy_common(MigrateCommon *args);
 void test_precopy_unix_common(MigrateCommon *args);
 void test_file_common(MigrateCommon *args, bool stop_src);
 
-typedef struct QTestMigrationState QTestMigrationState;
 QTestMigrationState *get_src(void);
 QTestMigrationState *get_dst(void);
 
-- 
2.50.1 (Apple Git-155)


