Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86568D5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGfQ-0001VT-3g; Mon, 15 Dec 2025 17:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGf9-0001Dk-QH
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:28 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGf7-00039V-Dg
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:27 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D40515BDDD;
 Mon, 15 Dec 2025 22:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WnqpBZJU2474UbbWD0OquXynqcPEoAQXGMMMbY0+ih0=;
 b=blXWxjIGPA2dQRqrB2ogXXEqxLJY1ob1zesz8I1si1pZgzo5IzP9CGPx57wPiNXnRGDdzR
 lBI0treeYGdwr6+6zBeJccZVAS9CTWKy9fIQaQL92hq7Kd8XADuCsl4MMaNjD3bfXLSDHP
 av4PsgRR85EtSZpXzLMDkg/PrT+OCHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WnqpBZJU2474UbbWD0OquXynqcPEoAQXGMMMbY0+ih0=;
 b=+fX7SZA7ZUCKJlv4LcwDINMfdwI+YrHzojujZD+4I9wze+Lrsf27j523LfyIqNVILVqU+u
 jtZ/37askLgFw5Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WnqpBZJU2474UbbWD0OquXynqcPEoAQXGMMMbY0+ih0=;
 b=blXWxjIGPA2dQRqrB2ogXXEqxLJY1ob1zesz8I1si1pZgzo5IzP9CGPx57wPiNXnRGDdzR
 lBI0treeYGdwr6+6zBeJccZVAS9CTWKy9fIQaQL92hq7Kd8XADuCsl4MMaNjD3bfXLSDHP
 av4PsgRR85EtSZpXzLMDkg/PrT+OCHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836169;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WnqpBZJU2474UbbWD0OquXynqcPEoAQXGMMMbY0+ih0=;
 b=+fX7SZA7ZUCKJlv4LcwDINMfdwI+YrHzojujZD+4I9wze+Lrsf27j523LfyIqNVILVqU+u
 jtZ/37askLgFw5Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAD3B3EA65;
 Mon, 15 Dec 2025 22:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sFjPIoeFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 47/51] tests/qtest/migration: Convert file tests to use
 config
Date: Mon, 15 Dec 2025 19:00:33 -0300
Message-ID: <20251215220041.12657-48-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.990];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Convert the file tests (including CPR) to use the config object.

The 'events' line can be removed because the capability is always set
in the config QDict in common code.

Temporarily, set the use-config key to enable the new method.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/cpr-tests.c  | 51 ++++++++++++++----------------
 tests/qtest/migration/file-tests.c | 39 ++++++++---------------
 tests/qtest/migration/framework.c  |  3 ++
 3 files changed, 41 insertions(+), 52 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 9883616cb5..a1b5a39f9f 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -21,14 +21,6 @@
 
 static char *tmpfs;
 
-static void *migrate_hook_start_mode_reboot(QTestState *from, QTestState *to)
-{
-    migrate_set_parameter_str(from, "mode", "cpr-reboot");
-    migrate_set_parameter_str(to, "mode", "cpr-reboot");
-
-    return NULL;
-}
-
 static void test_mode_reboot(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
@@ -36,21 +28,15 @@ static void test_mode_reboot(char *name, MigrateCommon *args)
 
     args->listen_uri = uri;
     args->connect_uri = uri;
-    args->start_hook = migrate_hook_start_mode_reboot;
 
     args->start.incoming_defer = true;
     args->start.mem_type = MEM_TYPE_SHMEM;
-    args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
 
+    qdict_put_bool(args->start.config, "x-ignore-shared", true);
+    qdict_put_str(args->start.config, "mode", "cpr-reboot");
     test_file_common(args, true);
 }
 
-static void *test_mode_transfer_start(QTestState *from, QTestState *to)
-{
-    migrate_set_parameter_str(from, "mode", "cpr-transfer");
-    return NULL;
-}
-
 /*
  * cpr-transfer mode cannot use the target monitor prior to starting the
  * migration, and cannot connect synchronously to the monitor, so defer
@@ -94,13 +80,17 @@ static void test_mode_transfer_common(MigrateCommon *args)
     args->listen_uri = uri;
     args->connect_channels = connect_channels;
     args->cpr_channel = cpr_channel;
-    args->start_hook = test_mode_transfer_start;
 
     args->start.opts_source = opts;
     args->start.opts_target = opts_target;
     args->start.defer_target_connect = true;
     args->start.mem_type = MEM_TYPE_MEMFD;
 
+    qdict_put_str(args->start.config, "mode", "cpr-transfer");
+
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
+
     if (test_precopy_common(args) < 0) {
         close(cpr_sockfd);
         unlink(cpr_path);
@@ -119,6 +109,18 @@ static void test_mode_transfer_defer(char *name, MigrateCommon *args)
     test_mode_transfer_common(args);
 }
 
+static void set_cpr_exec_command(QDict *config, char **strv)
+{
+    QList *list = qlist_new();
+
+    while (*strv) {
+        qlist_append_str(list, *strv);
+        strv++;
+    }
+
+    qdict_put_obj(config, "cpr-exec-command", (QObject *)list);
+}
+
 static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
 {
     g_autofree char *qtest_from_args = NULL;
@@ -157,7 +159,7 @@ static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
     exec_args = g_strconcat(qtest_qemu_binary(migration_get_env()->qemu_dst),
                             " -incoming defer ", from_str, NULL);
     argv = g_strsplit(exec_args, " ", -1);
-    migrate_set_parameter_strv(who, "cpr-exec-command", argv);
+    set_cpr_exec_command(args->start.config, argv);
 }
 
 static void wait_for_migration_event(QTestState *who, const char *waitfor)
@@ -187,6 +189,9 @@ static void test_cpr_exec(MigrateCommon *args)
                                                 FILE_TEST_FILENAME);
     g_autofree char *channels = NULL;
 
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
+
     if (migrate_start(&from, NULL, args->listen_uri, &args->start)) {
         return;
     }
@@ -200,7 +205,6 @@ static void test_cpr_exec(MigrateCommon *args)
 
     wait_for_serial("src_serial");
     set_cpr_exec_args(from, args);
-    migrate_set_capability(from, "events", true);
     migrate_qmp(from, NULL, connect_uri, NULL, args->start.config, "{}");
     wait_for_migration_event(from, "completed");
 
@@ -229,13 +233,6 @@ static void test_cpr_exec(MigrateCommon *args)
     migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
 }
 
-static void *test_mode_exec_start(QTestState *from, QTestState *to)
-{
-    assert(!to);
-    migrate_set_parameter_str(from, "mode", "cpr-exec");
-    return NULL;
-}
-
 static void test_mode_exec(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
@@ -244,12 +241,12 @@ static void test_mode_exec(char *name, MigrateCommon *args)
 
     args->connect_uri = uri;
     args->listen_uri = listen_uri;
-    args->start_hook = test_mode_exec_start;
 
     args->start.only_source = true;
     args->start.opts_source = "-machine aux-ram-share=on -nodefaults";
     args->start.mem_type = MEM_TYPE_MEMFD;
 
+    qdict_put_str(args->start.config, "mode", "cpr-exec");
     test_cpr_exec(args);
 }
 
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 57117b2496..c7a4eb145b 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -118,8 +118,8 @@ static void test_precopy_file_mapped_ram_live(char *name, MigrateCommon *args)
     args->listen_uri = uri;
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
+    qdict_put_bool(args->start.config, "mapped-ram", true);
     test_file_common(args, false);
 }
 
@@ -132,8 +132,8 @@ static void test_precopy_file_mapped_ram(char *name, MigrateCommon *args)
     args->listen_uri = uri;
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
+    qdict_put_bool(args->start.config, "mapped-ram", true);
     test_file_common(args, true);
 }
 
@@ -145,9 +145,9 @@ static void test_multifd_file_mapped_ram_live(char *name, MigrateCommon *args)
     args->listen_uri = uri;
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
-    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_bool(args->start.config, "mapped-ram", true);
     test_file_common(args, false);
 }
 
@@ -160,38 +160,29 @@ static void test_multifd_file_mapped_ram(char *name, MigrateCommon *args)
     args->listen_uri = uri;
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
-    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_bool(args->start.config, "mapped-ram", true);
     test_file_common(args, true);
 }
 
-static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
-                                                       QTestState *to)
-{
-    migrate_set_parameter_bool(from, "direct-io", true);
-    migrate_set_parameter_bool(to, "direct-io", true);
-
-    return NULL;
-}
-
 static void test_multifd_file_mapped_ram_dio(char *name, MigrateCommon *args)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
     args->listen_uri = uri;
-    args->start_hook = migrate_hook_start_multifd_mapped_ram_dio;
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     if (!probe_o_direct_support(tmpfs)) {
         g_test_skip("Filesystem does not support O_DIRECT");
         return;
     }
 
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_bool(args->start.config, "mapped-ram", true);
+    qdict_put_bool(args->start.config, "direct-io", true);
     test_file_common(args, true);
 }
 
@@ -230,9 +221,6 @@ static void *migrate_hook_start_multifd_mapped_ram_fdset_dio(QTestState *from,
     fdset_add_fds(from, file, O_WRONLY, 2, true);
     fdset_add_fds(to, file, O_RDONLY, 2, true);
 
-    migrate_set_parameter_bool(from, "direct-io", true);
-    migrate_set_parameter_bool(to, "direct-io", true);
-
     return NULL;
 }
 
@@ -258,9 +246,9 @@ static void test_multifd_file_mapped_ram_fdset(char *name, MigrateCommon *args)
     args->end_hook = migrate_hook_end_multifd_mapped_ram_fdset;
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_bool(args->start.config, "mapped-ram", true);
     test_file_common(args, true);
 }
 
@@ -276,14 +264,15 @@ static void test_multifd_file_mapped_ram_fdset_dio(char *name,
     args->end_hook = migrate_hook_end_multifd_mapped_ram_fdset;
 
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
     if (!probe_o_direct_support(tmpfs)) {
         g_test_skip("Filesystem does not support O_DIRECT");
         return;
     }
 
+    qdict_put_bool(args->start.config, "multifd", true);
+    qdict_put_bool(args->start.config, "mapped-ram", true);
+    qdict_put_bool(args->start.config, "direct-io", true);
     test_file_common(args, true);
 }
 #endif /* !_WIN32 */
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 44ef80cf0c..6cf2bbf9cc 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -1056,6 +1056,9 @@ void test_file_common(MigrateCommon *args, bool stop_src)
     void *data_hook = NULL;
     bool check_offset = false;
 
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
+
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
     }
-- 
2.51.0


