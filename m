Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2139C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 16:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdAW7-0003lx-Cq; Wed, 29 Jan 2025 11:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVo-0003Mr-DH
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:58 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tdAVm-0005L2-EQ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 11:01:56 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E4471F383;
 Wed, 29 Jan 2025 16:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=McYK2J/nz/qtltiBlFNR03FkR5FHGzqDpjF1ZiY5OgE=;
 b=sLWnHSmnbRbF0SC/K366I2brOpkJbcB5KyPtWmW2QcMgoNHfzwNiwdW6D8B5d7YDsHyTJH
 k50rd0JtjStptLJx8y3qs9xD6YcZzxHyEQIlKB1Lsi6J3dAAjF5ZodrGVjj3EYVFsSxYHi
 eO8LNd5pmyCutZwZGmP+KBDnV5DaIa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=McYK2J/nz/qtltiBlFNR03FkR5FHGzqDpjF1ZiY5OgE=;
 b=AywUyIy+d4okx81kgcRhIRsILPCcbq4atesgtLanEqsW2xUZ4M7QujD+9+fxYRRveZymy0
 +KhPtxVcs+T+9zBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738166513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=McYK2J/nz/qtltiBlFNR03FkR5FHGzqDpjF1ZiY5OgE=;
 b=sLWnHSmnbRbF0SC/K366I2brOpkJbcB5KyPtWmW2QcMgoNHfzwNiwdW6D8B5d7YDsHyTJH
 k50rd0JtjStptLJx8y3qs9xD6YcZzxHyEQIlKB1Lsi6J3dAAjF5ZodrGVjj3EYVFsSxYHi
 eO8LNd5pmyCutZwZGmP+KBDnV5DaIa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738166513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=McYK2J/nz/qtltiBlFNR03FkR5FHGzqDpjF1ZiY5OgE=;
 b=AywUyIy+d4okx81kgcRhIRsILPCcbq4atesgtLanEqsW2xUZ4M7QujD+9+fxYRRveZymy0
 +KhPtxVcs+T+9zBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08E00137DB;
 Wed, 29 Jan 2025 16:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SPXKLu9QmmffPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Jan 2025 16:01:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 24/42] migration-test: cpr-transfer
Date: Wed, 29 Jan 2025 13:00:41 -0300
Message-Id: <20250129160059.6987-25-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250129160059.6987-1-farosas@suse.de>
References: <20250129160059.6987-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,oracle.com:email];
 RCVD_TLS_ALL(0.00)[]
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

From: Steve Sistare <steven.sistare@oracle.com>

Add a migration test for cpr-transfer mode.  Defer the connection to the
target monitor, else the test hangs because in cpr-transfer mode QEMU does
not listen for monitor connections until we send the migrate command to
source QEMU.

To test -incoming defer, send a migrate incoming command to the target,
after sending the migrate command to the source, as required by
cpr-transfer mode.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1736967650-129648-24-git-send-email-steven.sistare@oracle.com
[only allocate in_channels when needed]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/cpr-tests.c | 62 +++++++++++++++++++++++++++++++
 tests/qtest/migration/framework.c | 23 ++++++++++++
 tests/qtest/migration/framework.h |  3 ++
 3 files changed, 88 insertions(+)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 44ce89aa5b..215b0df8c0 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -44,6 +44,62 @@ static void test_mode_reboot(void)
     test_file_common(&args, true);
 }
 
+static void *test_mode_transfer_start(QTestState *from, QTestState *to)
+{
+    migrate_set_parameter_str(from, "mode", "cpr-transfer");
+    return NULL;
+}
+
+/*
+ * cpr-transfer mode cannot use the target monitor prior to starting the
+ * migration, and cannot connect synchronously to the monitor, so defer
+ * the target connection.
+ */
+static void test_mode_transfer_common(bool incoming_defer)
+{
+    g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
+    g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
+    g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
+
+    const char *opts = "-machine aux-ram-share=on -nodefaults";
+    g_autofree const char *cpr_channel = g_strdup_printf(
+        "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
+        cpr_path);
+    g_autofree char *opts_target = g_strdup_printf("-incoming %s %s",
+                                                   cpr_channel, opts);
+
+    g_autofree char *connect_channels = g_strdup_printf(
+        "[ { 'channel-type': 'main',"
+        "    'addr': { 'transport': 'socket',"
+        "              'type': 'unix',"
+        "              'path': '%s' } } ]",
+        mig_path);
+
+    MigrateCommon args = {
+        .start.opts_source = opts,
+        .start.opts_target = opts_target,
+        .start.defer_target_connect = true,
+        .start.memory_backend = "-object memory-backend-memfd,id=pc.ram,size=%s"
+                                " -machine memory-backend=pc.ram",
+        .listen_uri = incoming_defer ? "defer" : uri,
+        .connect_channels = connect_channels,
+        .cpr_channel = cpr_channel,
+        .start_hook = test_mode_transfer_start,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_mode_transfer(void)
+{
+    test_mode_transfer_common(NULL);
+}
+
+static void test_mode_transfer_defer(void)
+{
+    test_mode_transfer_common(true);
+}
+
 void migration_test_add_cpr(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
@@ -55,4 +111,10 @@ void migration_test_add_cpr(MigrationTestEnv *env)
     if (getenv("QEMU_TEST_FLAKY_TESTS")) {
         migration_test_add("/migration/mode/reboot", test_mode_reboot);
     }
+
+    if (env->has_kvm) {
+        migration_test_add("/migration/mode/transfer", test_mode_transfer);
+        migration_test_add("/migration/mode/transfer/defer",
+                           test_mode_transfer_defer);
+    }
 }
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 1228bd5bca..de65bfe40d 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -420,6 +420,7 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest)
     qtest_quit(to);
 
     cleanup("migsocket");
+    cleanup("cpr.sock");
     cleanup("src_serial");
     cleanup("dest_serial");
     cleanup(FILE_TEST_FILENAME);
@@ -707,8 +708,11 @@ void test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
+    QObject *in_channels = NULL;
     QObject *out_channels = NULL;
 
+    g_assert(!args->cpr_channel || args->connect_channels);
+
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
     }
@@ -740,8 +744,24 @@ void test_precopy_common(MigrateCommon *args)
         }
     }
 
+    /*
+     * The cpr channel must be included in outgoing channels, but not in
+     * migrate-incoming channels.
+     */
     if (args->connect_channels) {
+        if (args->start.defer_target_connect &&
+            !strcmp(args->listen_uri, "defer")) {
+            in_channels = qobject_from_json(args->connect_channels,
+                                            &error_abort);
+        }
         out_channels = qobject_from_json(args->connect_channels, &error_abort);
+
+        if (args->cpr_channel) {
+            QList *channels_list = qobject_to(QList, out_channels);
+            QObject *obj = migrate_str_to_channel(args->cpr_channel);
+
+            qlist_append(channels_list, obj);
+        }
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
@@ -754,6 +774,9 @@ void test_precopy_common(MigrateCommon *args)
     if (args->start.defer_target_connect) {
         qtest_connect(to);
         qtest_qmp_handshake(to, NULL);
+        if (!strcmp(args->listen_uri, "defer")) {
+            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
+        }
     }
 
     if (args->result != MIG_TEST_SUCCEED) {
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 32f3a93632..cb4a984700 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -154,6 +154,9 @@ typedef struct {
      */
     const char *connect_channels;
 
+    /* Optional: the cpr migration channel, in JSON or dotted keys format */
+    const char *cpr_channel;
+
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
-- 
2.35.3


