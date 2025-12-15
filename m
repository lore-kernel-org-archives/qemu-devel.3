Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3473D5B872
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGfU-0002LP-Cc; Mon, 15 Dec 2025 17:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGfK-0001Vh-Jj
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:42 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGfG-0003Bv-GF
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:37 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B58633742;
 Mon, 15 Dec 2025 22:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DMP/q2btvgcXeqHj+XzP+a3Z6jT5Co32VSxUCUeL+M=;
 b=oz4DzvEt8AeJ1zhVq1G0AS4OnmPtPArluLoAwYxHtQIciBeAJlMqVMyLP5D0OLYnjoMKQW
 RgpfNWxXGKzbWmJ0LregU6Pd4ik+vTv/alQRccwKmut2553KUth3vDCBcbzVCPAOkApV+B
 tq9yDTJs3hpBnvjU4Z4L7G7eLKOgDxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DMP/q2btvgcXeqHj+XzP+a3Z6jT5Co32VSxUCUeL+M=;
 b=QA4S/Ogfgt2BqdsjTJE537cxlwJULGBqgjtDzZnaL1gvWH6Ssa1T39zRyqAWlRvlK/UYvY
 7oQB0nSm7LARDdAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oz4DzvEt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="QA4S/Ogf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DMP/q2btvgcXeqHj+XzP+a3Z6jT5Co32VSxUCUeL+M=;
 b=oz4DzvEt8AeJ1zhVq1G0AS4OnmPtPArluLoAwYxHtQIciBeAJlMqVMyLP5D0OLYnjoMKQW
 RgpfNWxXGKzbWmJ0LregU6Pd4ik+vTv/alQRccwKmut2553KUth3vDCBcbzVCPAOkApV+B
 tq9yDTJs3hpBnvjU4Z4L7G7eLKOgDxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5DMP/q2btvgcXeqHj+XzP+a3Z6jT5Co32VSxUCUeL+M=;
 b=QA4S/Ogfgt2BqdsjTJE537cxlwJULGBqgjtDzZnaL1gvWH6Ssa1T39zRyqAWlRvlK/UYvY
 7oQB0nSm7LARDdAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D1AC3EA65;
 Mon, 15 Dec 2025 22:02:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oAw/AIKFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 45/51] tests/qtest/migration: Convert TLS x509 tests to use
 config
Date: Mon, 15 Dec 2025 19:00:31 -0300
Message-ID: <20251215220041.12657-46-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B58633742
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; FROM_EQ_ENVFROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLi3368pnyb3ujpcs6u1hud8b3)];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Convert the TLS x509 tests to start passing the config object to the
migration commands. Replace the usage of migrate_set_parameters and
args->caps with the config QDict.

Note that the TLS credentials id is different among the two migration
machines so it cannot follow the standard practice of setting the same
value for both QTestState instances (i.e. from/to). This is a issue
specific to the test code because it uses the same config object for
both QEMU instances. Since this is a one-off, add a workaround
specific for that situation.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c      |  11 +-
 tests/qtest/migration/migration-util.c |  44 ++++++++
 tests/qtest/migration/migration-util.h |   1 +
 tests/qtest/migration/tls-tests.c      | 139 +++++++------------------
 4 files changed, 92 insertions(+), 103 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 8f179ea2fa..44ef80cf0c 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -429,8 +429,10 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
      */
     events = args->defer_target_connect ? "-global migration.x-events=on" : "";
 
-    if (args->config) {
-        GString *json = qobject_to_json(QOBJECT(args->config));
+    if (!args->incoming_defer && args->config) {
+        QDict *conf = fixup_tls_creds(args->config);
+        GString *json = qobject_to_json(QOBJECT(conf));
+
         config_opts = g_strdup_printf("-incoming '%s'", json->str);
     }
 
@@ -883,12 +885,15 @@ int test_precopy_common(MigrateCommon *args)
     }
 
     if (args->start.incoming_defer && !args->start.defer_target_connect) {
+        QDict *incoming_conf = fixup_tls_creds(args->start.config);
+
         if (args->connect_channels) {
             in_channels = qobject_from_json(args->connect_channels,
                                             &error_abort);
         }
+
         migrate_incoming_qmp(to, args->listen_uri, in_channels,
-                             args->start.config, "{}");
+                             incoming_conf, "{}");
     }
 
     /* Wait for the first serial output from the source */
diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index e702f00896..efe1ae25de 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -395,3 +395,47 @@ bool kvm_dirty_ring_supported(void)
     return false;
 #endif
 }
+
+QDict *fixup_tls_creds(QDict *config)
+{
+    QDict *new;
+
+    if (!config) {
+        return NULL;
+    }
+
+    /*
+     * The tests expect the tls-creds to have different values for
+     * client and server, but there's only one config object. The
+     * tls-tests have passed the values in the two temporary keys
+     * below.
+     */
+    const char *server = qdict_get_try_str(config, "tmp-tls-server");
+    const char *client = qdict_get_try_str(config, "tmp-tls-client");
+
+    if (server && client) {
+        new = qdict_clone_shallow(config);
+
+        /*
+         * Set the proper value for the incoming side and discard the
+         * temporaries. Note that removing the temporaries cannot
+         * happen before cloning because the qdict code frees the
+         * strings.
+         */
+        qdict_put_str(new, "tls-creds", server);
+        qdict_del(new, "tmp-tls-client");
+        qdict_del(new, "tmp-tls-server");
+
+        /*
+         * Set the value for the outgoing side for further usage
+         * outside this function.
+         */
+        qdict_put_str(config, "tls-creds", client);
+        qdict_del(config, "tmp-tls-client");
+        qdict_del(config, "tmp-tls-server");
+
+        return new;
+    }
+
+    return config;
+}
diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
index 3c3b5a8777..ec58868197 100644
--- a/tests/qtest/migration/migration-util.h
+++ b/tests/qtest/migration/migration-util.h
@@ -59,6 +59,7 @@ void migration_test_add_suffix(const char *path, const char *suffix,
                                void (*fn)(char *name, MigrateCommon *args));
 char *migrate_get_connect_uri(QTestState *who);
 void migrate_set_ports(QTestState *to, QList *channel_list);
+QDict *fixup_tls_creds(QDict *config);
 
 /*
  * Scaffolding to allow the framework _common functions and _qmp
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 68304a7af3..b6d436389a 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -259,10 +259,6 @@ migrate_hook_start_tls_x509_common(QTestState *from,
                              "                 'sanity-check': true,"
                              "                 'verify-peer': true} }",
                              workdir);
-    migrate_set_parameter_str(from, "tls-creds", "tlscredsx509client0");
-    if (args->certhostname) {
-        migrate_set_parameter_str(from, "tls-hostname", args->certhostname);
-    }
 
     qtest_qmp_assert_success(to,
                              "{ 'execute': 'object-add',"
@@ -273,7 +269,6 @@ migrate_hook_start_tls_x509_common(QTestState *from,
                              "                 'sanity-check': true,"
                              "                 'verify-peer': %i} }",
                              workdir, args->verifyclient);
-    migrate_set_parameter_str(to, "tls-creds", "tlscredsx509server0");
 
     if (args->authzclient) {
         qtest_qmp_assert_success(to,
@@ -282,7 +277,6 @@ migrate_hook_start_tls_x509_common(QTestState *from,
                                  "                 'id': 'tlsauthz0',"
                                  "                 'identity': %s} }",
                                  "CN=" QCRYPTO_TLS_TEST_CLIENT_NAME);
-        migrate_set_parameter_str(to, "tls-authz", "tlsauthz0");
     }
 
     return NULL;
@@ -335,6 +329,28 @@ static void migrate_tls_x509_init(MigrateCommon *args,
                                test_args->certipaddr);
     test_tls_deinit_cert(&clientcertreq);
     test_tls_deinit_cert(&cacertreq);
+
+    /*
+     * These keys are not actual parameters, we need them for the test
+     * code because it uses the same config object for both QEMUs.
+     */
+    qdict_put_str(args->start.config, "tmp-tls-client", "tlscredsx509client0");
+    qdict_put_str(args->start.config, "tmp-tls-server", "tlscredsx509server0");
+
+    if (test_args->certhostname) {
+        qdict_put_str(args->start.config, "tls-hostname",
+                      test_args->certhostname);
+    } else {
+        qdict_put_null(args->start.config, "tls-hostname");
+    }
+
+    if (test_args->authzclient) {
+        qdict_put_str(args->start.config, "tls-authz", "tlsauthz0");
+    }
+
+    if (qdict_get_try_bool(args->start.config, "multifd", false)) {
+        qdict_put_str(args->start.config, "multifd-compression", "none");
+    }
 }
 
 static void migrate_tls_x509_cleanup(TestMigrateTLSX509Data *data)
@@ -369,6 +385,9 @@ static void test_precopy_tls_x509_common(MigrateCommon *args,
 {
     TestMigrateTLSX509Data *data = g_new0(TestMigrateTLSX509Data, 1);
 
+    /* temporary */
+    qdict_put_bool(args->start.config, "use-config", true);
+
     migrate_tls_x509_init(args, test_args, data);
     test_precopy_common(args);
     migrate_tls_x509_cleanup(data);
@@ -508,21 +527,11 @@ static void test_precopy_tcp_no_tls(char *name, MigrateCommon *args)
     test_precopy_common(args);
 }
 
-static void *
-migrate_hook_start_tls_x509_no_host(QTestState *from, QTestState *to)
-{
-    TestMigrateTLSX509Data *data = migrate_hook_start_tls_x509_common(
-        from, to, &tls_x509_no_host);
-    migrate_set_parameter_null(from, "tls-hostname");
-    migrate_set_parameter_null(to, "tls-hostname");
-
-    return data;
-}
-
 static void test_precopy_tcp_tls_no_hostname(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
-    args->start_hook = migrate_hook_start_tls_x509_no_host;
+    args->start_hook_full = migrate_hook_start_tls_x509_common;
+    args->start_hook_data = &tls_x509_no_host;
     args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
 
     args->start.hide_stderr = true;
@@ -609,60 +618,6 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(char *name,
 
     test_precopy_tls_x509_common(args, &tls_x509_reject_anon_client);
 }
-
-static void *
-migrate_hook_start_multifd_tls_x509_default_host(QTestState *from,
-                                                 QTestState *to)
-{
-    migrate_set_parameter_str(from, "multifd-compression", "none");
-    migrate_set_parameter_str(to, "multifd-compression", "none");
-
-    return migrate_hook_start_tls_x509_common(from, to, &tls_x509_default_host);
-}
-
-static void *
-migrate_hook_start_multifd_tls_x509_override_host(QTestState *from,
-                                                  QTestState *to)
-{
-    migrate_set_parameter_str(from, "multifd-compression", "none");
-    migrate_set_parameter_str(to, "multifd-compression", "none");
-
-    return migrate_hook_start_tls_x509_common(from, to,
-                                              &tls_x509_override_host);
-}
-
-static void *
-migrate_hook_start_multifd_tls_x509_mismatch_host(QTestState *from,
-                                                  QTestState *to)
-{
-    migrate_set_parameter_str(from, "multifd-compression", "none");
-    migrate_set_parameter_str(to, "multifd-compression", "none");
-
-    return migrate_hook_start_tls_x509_common(from, to,
-                                              &tls_x509_mismatch_host);
-}
-
-static void *
-migrate_hook_start_multifd_tls_x509_allow_anon_client(QTestState *from,
-                                                      QTestState *to)
-{
-    migrate_set_parameter_str(from, "multifd-compression", "none");
-    migrate_set_parameter_str(to, "multifd-compression", "none");
-
-    return migrate_hook_start_tls_x509_common(from, to,
-                                              &tls_x509_allow_anon_client);
-}
-
-static void *
-migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
-                                                       QTestState *to)
-{
-    migrate_set_parameter_str(from, "multifd-compression", "none");
-    migrate_set_parameter_str(to, "multifd-compression", "none");
-
-    return migrate_hook_start_tls_x509_common(from, to,
-                                              &tls_x509_reject_anon_client);
-}
 #endif /* CONFIG_TASN1 */
 
 static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
@@ -701,25 +656,17 @@ static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
 static void test_multifd_tcp_tls_x509_default_host(char *name,
                                                    MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tls_x509_default_host;
-    args->listen_uri = "tcp:127.0.0.1:0";
-
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
-
-    test_precopy_tls_x509_common(args, &tls_x509_default_host);
+    qdict_put_bool(args->start.config, "multifd", true);
+    test_precopy_tcp_tls_x509_default_host(name, args);
 }
 
 static void test_multifd_tcp_tls_x509_override_host(char *name,
                                                     MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tls_x509_override_host;
-    args->listen_uri = "tcp:127.0.0.1:0";
-
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
-
-    test_precopy_tls_x509_common(args, &tls_x509_override_host);
+    qdict_put_bool(args->start.config, "multifd", true);
+    test_precopy_tcp_tls_x509_override_host(name, args);
 }
 
 static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
@@ -738,13 +685,15 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
      * to load migration state, and thus just aborts the migration
      * without exiting.
      */
-    args->start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host;
+    args->start_hook_full = migrate_hook_start_tls_x509_common;
+    args->start_hook_data = &tls_x509_mismatch_host;
     args->result = MIG_TEST_FAIL;
     args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.hide_stderr = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
+
+    qdict_put_bool(args->start.config, "multifd", true);
 
     test_precopy_tls_x509_common(args, &tls_x509_mismatch_host);
 }
@@ -752,27 +701,17 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
 static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
                                                         MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client;
-    args->listen_uri = "tcp:127.0.0.1:0";
-
     args->start.incoming_defer = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
-
-    test_precopy_tls_x509_common(args, &tls_x509_allow_anon_client);
+    qdict_put_bool(args->start.config, "multifd", true);
+    test_precopy_tcp_tls_x509_allow_anon_client(name, args);
 }
 
 static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
                                                          MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client;
-    args->result = MIG_TEST_FAIL;
-    args->listen_uri = "tcp:127.0.0.1:0";
-
     args->start.incoming_defer = true;
-    args->start.hide_stderr = true;
-    args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
-
-    test_precopy_tls_x509_common(args, &tls_x509_reject_anon_client);
+    qdict_put_bool(args->start.config, "multifd", true);
+    test_precopy_tcp_tls_x509_reject_anon_client(name, args);
 }
 #endif /* CONFIG_TASN1 */
 
-- 
2.51.0


