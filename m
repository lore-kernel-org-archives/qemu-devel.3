Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96518C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 20:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAEuZ-0000ZV-BJ; Thu, 23 May 2024 16:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sAEuX-0000Y4-Uh
 for qemu-devel@nongnu.org; Thu, 23 May 2024 16:19:37 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sAEuW-0002Gv-77
 for qemu-devel@nongnu.org; Thu, 23 May 2024 16:19:37 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E9AD422CA0;
 Thu, 23 May 2024 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716495575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TV9fz7QaqOmoOjB1sjErTUxyrFvJZEhe1nfzY/PClgo=;
 b=pc+MvFLKsug2ANYm5BsW/vFObOLWy6NBkjQQXtgIwt9F59TRUjPbhW1nfdPyR4omzXuYqC
 fxYjqU6b95qEHFpUEW2R5RSISdEgG+3sgNC0nUGIG4ka5+Y86bv9czGe9S+qJuUH8HKV4S
 pzEfzl5OvJ072mYQeeJyGtEKI1jq0fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716495575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TV9fz7QaqOmoOjB1sjErTUxyrFvJZEhe1nfzY/PClgo=;
 b=h+9n2G7cGsmbCgOdwikFHwdhHsnwWGpRcplE4H6iad/038WZVjJrykG/2KVyJUDCDQT4Wj
 h/MqQujRpQDH3HCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716495574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TV9fz7QaqOmoOjB1sjErTUxyrFvJZEhe1nfzY/PClgo=;
 b=M5bYby6qOwQ8zBn6GlUYB9EFWz6KEeA1bO2jcKLEdspEedABTvGCBS6/KyktV/IS4vJMuq
 rDfKVlhkTmQlDyh9312C5lNQDGYQ5BIZ94cqbC2P8Opx381kwsZ0SAvR7h7Tx0Xui02HBx
 EdTXfRuK7ZS1mN2tUqSse4Z89+xczRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716495574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TV9fz7QaqOmoOjB1sjErTUxyrFvJZEhe1nfzY/PClgo=;
 b=IGesqfATtTIs51OPNZOwEUZ79nJ/I+nEnf6tHvHhTxToLFHhoAsKH+JlWYDWtuG7oewiDM
 HvJBETGTJOxCWmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A473A13A6C;
 Thu, 23 May 2024 20:19:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QO2PGtSkT2ZqcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 20:19:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Het Gala <het.gala@nutanix.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 3/4] tests/qtest/migration: Add support for simple device
 tests
Date: Thu, 23 May 2024 17:19:21 -0300
Message-Id: <20240523201922.28007-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523201922.28007-1-farosas@suse.de>
References: <20240523201922.28007-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
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

The current migration-tests are almost entirely focused on catching
bugs on the migration code itself, not on the device migration
infrastructure (vmstate). That means we miss catching some low hanging
fruits that would show up immediately if only we had the device in
question present in the VM.

Add a list of devices to include by default in the migration-tests,
starting with one that recently had issues, virtio-gpu. Also add an
environment variable QTEST_DEVICE_OPTS to allow test users to
experiment with different devices or device options.

Do not run every migration test with the devices because that would
increase the complexity of the command lines and, as mentioned, the
migration-tests are mostly used to test the core migration code, not
the device migration. Add a special value QTEST_DEVICE_OPTS=all that
enables testing with devices.

Notes on usage:

For this new testing mode, it's not useful to run all the migration
tests, a single test would probably suffice to catch any issues, so
provide the -p option to migration-test and the test of your choice.

Like with the cross-version compatibility tests in CI and the recently
introduced vmstate-static-checker test, to be of any use, a test with
devices needs to be run against a different QEMU version, like so:

$ cd build
$ QTEST_DEVICE_OPTS=all \
 QTEST_QEMU_BINARY=./qemu-system-x86_64 \
 QTEST_QEMU_BINARY_DST=../build-previous/qemu-system-x86_64 \
 ./tests/qtest/migration-test -p /x86_64/migration/precopy/tcp/plain

$ cd build
$ QTEST_DEVICE_OPTS='-device virtio-net' \
 QTEST_QEMU_BINARY=./qemu-system-x86_64 \
 QTEST_QEMU_BINARY_DST=../build-previous/qemu-system-x86_64 \
 ./tests/qtest/migration-test -p /x86_64/migration/precopy/tcp/plain

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 2253e0fc5b..35bb224d18 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -71,6 +71,13 @@ static QTestMigrationState dst_state;
 #define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
 #define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
 
+/*
+ * The tests using DEFAULT_DEVICES need a special invocation and
+ * cannot be reached from make check, so don't bother with the
+ * --without-default-devices build.
+ */
+#define DEFAULT_DEVICES "-device virtio-gpu"
+
 #if defined(__linux__)
 #include <sys/syscall.h>
 #include <sys/vfs.h>
@@ -701,6 +708,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     const char *memory_size;
     const char *machine_alias, *machine_opts = "";
     g_autofree char *machine = NULL;
+    g_autofree gchar *device_opts = NULL;
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -793,12 +801,17 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
     g_test_message("Using machine type: %s", machine);
 
+    device_opts = g_strdup(getenv("QTEST_DEVICE_OPTS"));
+    if (g_str_equal(device_opts, "all")) {
+        device_opts = g_strdup(DEFAULT_DEVICES);
+    }
+
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name source,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/src_serial "
-                                 "%s %s %s %s %s",
+                                 "%s %s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
                                  memory_size, tmpfs,
@@ -806,6 +819,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  arch_source ? arch_source : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_source ? args->opts_source : "",
+                                 device_opts ? device_opts : "",
                                  ignore_stderr);
     if (!args->only_target) {
         *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
@@ -820,7 +834,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "-m %s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
-                                 "%s %s %s %s %s",
+                                 "%s %s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
                                  memory_size, tmpfs, uri,
@@ -828,6 +842,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  arch_target ? arch_target : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
+                                 device_opts ? device_opts : "",
                                  ignore_stderr);
     *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
     qtest_qmp_set_event_callback(*to,
-- 
2.35.3


