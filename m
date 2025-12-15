Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AD6D5B872
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGcu-0002ZO-Pe; Mon, 15 Dec 2025 17:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGct-0002ZB-95
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:07 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGcr-0002YG-Ib
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:01:07 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B0645BDDC;
 Mon, 15 Dec 2025 22:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0K1fu1mNGa4DgwXAabBAcn15v7sFjUTK81CTwi/5MFM=;
 b=CmMl06/mx2qQu12NvGWwH+dx/uzXP5fNeoLvulmV2xZbdqURL05EPeLkr1R25qfQj7Kaq4
 r2XJJiOROh075kdzGWpretV5Q9sbdJkZcH84qZWVnIjtmQLI9sW+ak02DdN4leXEexhpul
 bH99sJULauGh3z7hS6pIx1iYtKdttu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0K1fu1mNGa4DgwXAabBAcn15v7sFjUTK81CTwi/5MFM=;
 b=H8G5BWlyo1ub0KJ5hdTteF5ZDMxWfXWbjGdb9S1mPN4ie6Y/+YCgD5lri+VlI3b4OpVnKi
 6Z+AIkQX3BKxKfBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0K1fu1mNGa4DgwXAabBAcn15v7sFjUTK81CTwi/5MFM=;
 b=CmMl06/mx2qQu12NvGWwH+dx/uzXP5fNeoLvulmV2xZbdqURL05EPeLkr1R25qfQj7Kaq4
 r2XJJiOROh075kdzGWpretV5Q9sbdJkZcH84qZWVnIjtmQLI9sW+ak02DdN4leXEexhpul
 bH99sJULauGh3z7hS6pIx1iYtKdttu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0K1fu1mNGa4DgwXAabBAcn15v7sFjUTK81CTwi/5MFM=;
 b=H8G5BWlyo1ub0KJ5hdTteF5ZDMxWfXWbjGdb9S1mPN4ie6Y/+YCgD5lri+VlI3b4OpVnKi
 6Z+AIkQX3BKxKfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72FB03EA63;
 Mon, 15 Dec 2025 22:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6M03DR2FQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:01:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 04/51] tests/qtest/migration: Add a NULL parameters test
 for TLS
Date: Mon, 15 Dec 2025 18:59:50 -0300
Message-ID: <20251215220041.12657-5-farosas@suse.de>
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
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
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

Make sure the TLS options handling is working correctly with a NULL
parameter. This is relevant due to the usage of StrOrNull for the
tls-creds, tls-authz and tls-hostname options.

With this, all manners of passing TLS options are somehow covered by
the tests, we should not need to do manual testing when touching TLS
options code.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/migration-qmp.c |  9 +++++
 tests/qtest/migration/migration-qmp.h |  1 +
 tests/qtest/migration/tls-tests.c     | 56 +++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index c803fcee9d..5c46ceb3e6 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -458,6 +458,15 @@ void migrate_set_parameter_strv(QTestState *who, const char *parameter,
     qtest_qmp_assert_success(who, command, parameter);
 }
 
+void migrate_set_parameter_null(QTestState *who, const char *parameter)
+{
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-set-parameters',"
+                             "'arguments': { %s: null } }",
+                             parameter);
+    migrate_check_parameter_str(who, parameter, "");
+}
+
 static long long migrate_get_parameter_bool(QTestState *who,
                                             const char *parameter)
 {
diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index 44482d250f..940ffd5950 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -36,6 +36,7 @@ void migrate_set_parameter_str(QTestState *who, const char *parameter,
                                const char *value);
 void migrate_set_parameter_strv(QTestState *who, const char *parameter,
                                 char **strv);
+void migrate_set_parameter_null(QTestState *who, const char *parameter);
 void migrate_set_parameter_bool(QTestState *who, const char *parameter,
                                 int value);
 void migrate_ensure_non_converge(QTestState *who);
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 21e9fec87d..e0e8a7335c 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -507,6 +507,57 @@ static void test_precopy_tcp_tls_psk_mismatch(void)
     test_precopy_common(&args);
 }
 
+static void *migrate_hook_start_no_tls(QTestState *from, QTestState *to)
+{
+    struct TestMigrateTLSPSKData *data =
+        g_new0(struct TestMigrateTLSPSKData, 1);
+
+    migrate_set_parameter_null(from, "tls-creds");
+    migrate_set_parameter_null(to, "tls-creds");
+
+    return data;
+}
+
+static void test_precopy_tcp_no_tls(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = migrate_hook_start_no_tls,
+        .end_hook = migrate_hook_end_tls_psk,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void *
+migrate_hook_start_tls_x509_no_host(QTestState *from, QTestState *to)
+{
+    TestMigrateTLSX509 args = {
+        .verifyclient = true,
+        .clientcert = true,
+        .authzclient = true,
+    };
+    TestMigrateTLSX509Data *data = migrate_hook_start_tls_x509_common(from, to,
+                                                                      &args);
+    migrate_set_parameter_null(from, "tls-hostname");
+    migrate_set_parameter_null(to, "tls-hostname");
+
+    return data;
+}
+
+static void test_precopy_tcp_tls_no_hostname(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = migrate_hook_start_tls_x509_no_host,
+        .end_hook = migrate_hook_end_tls_x509,
+        .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
+        .start.hide_stderr = true,
+    };
+
+    test_precopy_common(&args);
+}
+
 #ifdef CONFIG_TASN1
 static void test_precopy_tcp_tls_x509_default_host(void)
 {
@@ -799,6 +850,11 @@ void migration_test_add_tls(MigrationTestEnv *env)
         return;
     }
 
+    migration_test_add("/migration/precopy/tcp/no-tls",
+                       test_precopy_tcp_no_tls);
+    migration_test_add("/migration/precopy/tcp/tls/no-hostname",
+                       test_precopy_tcp_tls_no_hostname);
+
     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);
 
-- 
2.51.0


