Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65532D5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:04:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGf1-00085j-B1; Mon, 15 Dec 2025 17:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGey-0007bP-B6
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:16 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGev-00033D-QA
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:15 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BF53A337E0;
 Mon, 15 Dec 2025 22:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FC6CX/jIGiLjvjNiNf8/2fb3OjzGYN4dvdc9R4+lUZc=;
 b=zlFSqhVbiMObo5xr7qpW0LsLrzWfoymysU7APhKctikY1RAQW+T/kOCSBKBJcRqiDfsklw
 kZlRP5aoTu6v4iU10atKdyvQn6UhcUjmfggThZoLddbk2WlIo/NJNy2nuNHy67D01Lj0wu
 Qj0Dmue/5cJ6U1jsS2+sHjEGoYzaanc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836148;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FC6CX/jIGiLjvjNiNf8/2fb3OjzGYN4dvdc9R4+lUZc=;
 b=jIs8fzThYZNVTejZnUXbv5u7RFHttvVdEAgrv50BwiYu2LTqvGzUtbJjXfsBk2yBhHEHsG
 6qUBplJY0wSxxWAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FC6CX/jIGiLjvjNiNf8/2fb3OjzGYN4dvdc9R4+lUZc=;
 b=zlFSqhVbiMObo5xr7qpW0LsLrzWfoymysU7APhKctikY1RAQW+T/kOCSBKBJcRqiDfsklw
 kZlRP5aoTu6v4iU10atKdyvQn6UhcUjmfggThZoLddbk2WlIo/NJNy2nuNHy67D01Lj0wu
 Qj0Dmue/5cJ6U1jsS2+sHjEGoYzaanc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836148;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FC6CX/jIGiLjvjNiNf8/2fb3OjzGYN4dvdc9R4+lUZc=;
 b=jIs8fzThYZNVTejZnUXbv5u7RFHttvVdEAgrv50BwiYu2LTqvGzUtbJjXfsBk2yBhHEHsG
 6qUBplJY0wSxxWAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAA013EA63;
 Mon, 15 Dec 2025 22:02:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iDR/HnKFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 39/51] tests/qtest/migration: TLS x509: Add init/cleanup
 routines
Date: Mon, 15 Dec 2025 19:00:25 -0300
Message-ID: <20251215220041.12657-40-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.992];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 R_RATELIMIT(0.00)[to_ip_from(RLjrdmmf3juheryardexw6jb95)];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
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

Split the TLS x509 hooks by moving out of them any code that doesn't
need to access the QTestState.

Aside from making the code harder to follow for no practical reason,
having extra code in the hooks will soon get in the way of converting
the tests to use a new API that, unlike
migrate_set_parameters|capabilities, doesn't require the QEMU instance
to be already live.

Move the QTestState-independent code into a normal function and leave
the hooks only for operations that need the guest machine.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/tls-tests.c | 155 +++++++++++++++---------------
 1 file changed, 75 insertions(+), 80 deletions(-)

diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 8da95dc92a..6a858b766f 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -210,15 +210,57 @@ migrate_hook_start_tls_x509_common(QTestState *from,
                                    void *opaque)
 {
     TestMigrateTLSX509 *args = opaque;
-    TestMigrateTLSX509Data *data = g_new0(TestMigrateTLSX509Data, 1);
+    const char *workdir = g_strdup_printf("%s/tlscredsx5090", tmpfs);
 
+    qtest_qmp_assert_success(from,
+                             "{ 'execute': 'object-add',"
+                             "  'arguments': { 'qom-type': 'tls-creds-x509',"
+                             "                 'id': 'tlscredsx509client0',"
+                             "                 'endpoint': 'client',"
+                             "                 'dir': %s,"
+                             "                 'sanity-check': true,"
+                             "                 'verify-peer': true} }",
+                             workdir);
+    migrate_set_parameter_str(from, "tls-creds", "tlscredsx509client0");
+    if (args->certhostname) {
+        migrate_set_parameter_str(from, "tls-hostname", args->certhostname);
+    }
+
+    qtest_qmp_assert_success(to,
+                             "{ 'execute': 'object-add',"
+                             "  'arguments': { 'qom-type': 'tls-creds-x509',"
+                             "                 'id': 'tlscredsx509server0',"
+                             "                 'endpoint': 'server',"
+                             "                 'dir': %s,"
+                             "                 'sanity-check': true,"
+                             "                 'verify-peer': %i} }",
+                             workdir, args->verifyclient);
+    migrate_set_parameter_str(to, "tls-creds", "tlscredsx509server0");
+
+    if (args->authzclient) {
+        qtest_qmp_assert_success(to,
+                                 "{ 'execute': 'object-add',"
+                                 "  'arguments': { 'qom-type': 'authz-simple',"
+                                 "                 'id': 'tlsauthz0',"
+                                 "                 'identity': %s} }",
+                                 "CN=" QCRYPTO_TLS_TEST_CLIENT_NAME);
+        migrate_set_parameter_str(to, "tls-authz", "tlsauthz0");
+    }
+
+    return NULL;
+}
+
+static void migrate_tls_x509_init(MigrateCommon *args,
+                                  TestMigrateTLSX509 *test_args,
+                                  TestMigrateTLSX509Data *data)
+{
     data->workdir = g_strdup_printf("%s/tlscredsx5090", tmpfs);
     data->keyfile = g_strdup_printf("%s/key.pem", data->workdir);
 
     data->cacert = g_strdup_printf("%s/ca-cert.pem", data->workdir);
     data->serverkey = g_strdup_printf("%s/server-key.pem", data->workdir);
     data->servercert = g_strdup_printf("%s/server-cert.pem", data->workdir);
-    if (args->clientcert) {
+    if (test_args->clientcert) {
         data->clientkey = g_strdup_printf("%s/client-key.pem", data->workdir);
         data->clientcert = g_strdup_printf("%s/client-cert.pem", data->workdir);
     }
@@ -231,7 +273,7 @@ migrate_hook_start_tls_x509_common(QTestState *from,
 #else
     g_assert(CreateHardLink(data->serverkey, data->keyfile, NULL) != 0);
 #endif
-    if (args->clientcert) {
+    if (test_args->clientcert) {
 #ifndef _WIN32
         g_assert(link(data->keyfile, data->clientkey) == 0);
 #else
@@ -240,9 +282,9 @@ migrate_hook_start_tls_x509_common(QTestState *from,
     }
 
     TLS_ROOT_REQ_SIMPLE(cacertreq, data->cacert);
-    if (args->clientcert) {
+    if (test_args->clientcert) {
         TLS_CERT_REQ_SIMPLE_CLIENT(servercertreq, cacertreq,
-                                   args->hostileclient ?
+                                   test_args->hostileclient ?
                                    QCRYPTO_TLS_TEST_CLIENT_HOSTILE_NAME :
                                    QCRYPTO_TLS_TEST_CLIENT_NAME,
                                    data->clientcert);
@@ -251,56 +293,14 @@ migrate_hook_start_tls_x509_common(QTestState *from,
 
     TLS_CERT_REQ_SIMPLE_SERVER(clientcertreq, cacertreq,
                                data->servercert,
-                               args->certhostname,
-                               args->certipaddr);
+                               test_args->certhostname,
+                               test_args->certipaddr);
     test_tls_deinit_cert(&clientcertreq);
     test_tls_deinit_cert(&cacertreq);
-
-    qtest_qmp_assert_success(from,
-                             "{ 'execute': 'object-add',"
-                             "  'arguments': { 'qom-type': 'tls-creds-x509',"
-                             "                 'id': 'tlscredsx509client0',"
-                             "                 'endpoint': 'client',"
-                             "                 'dir': %s,"
-                             "                 'sanity-check': true,"
-                             "                 'verify-peer': true} }",
-                             data->workdir);
-    migrate_set_parameter_str(from, "tls-creds", "tlscredsx509client0");
-    if (args->certhostname) {
-        migrate_set_parameter_str(from, "tls-hostname", args->certhostname);
-    }
-
-    qtest_qmp_assert_success(to,
-                             "{ 'execute': 'object-add',"
-                             "  'arguments': { 'qom-type': 'tls-creds-x509',"
-                             "                 'id': 'tlscredsx509server0',"
-                             "                 'endpoint': 'server',"
-                             "                 'dir': %s,"
-                             "                 'sanity-check': true,"
-                             "                 'verify-peer': %i} }",
-                             data->workdir, args->verifyclient);
-    migrate_set_parameter_str(to, "tls-creds", "tlscredsx509server0");
-
-    if (args->authzclient) {
-        qtest_qmp_assert_success(to,
-                                 "{ 'execute': 'object-add',"
-                                 "  'arguments': { 'qom-type': 'authz-simple',"
-                                 "                 'id': 'tlsauthz0',"
-                                 "                 'identity': %s} }",
-                                 "CN=" QCRYPTO_TLS_TEST_CLIENT_NAME);
-        migrate_set_parameter_str(to, "tls-authz", "tlsauthz0");
-    }
-
-    return data;
 }
 
-static void
-migrate_hook_end_tls_x509(QTestState *from,
-                          QTestState *to,
-                          void *opaque)
+static void migrate_tls_x509_cleanup(TestMigrateTLSX509Data *data)
 {
-    TestMigrateTLSX509Data *data = opaque;
-
     test_tls_cleanup(data->keyfile);
     g_free(data->keyfile);
 
@@ -325,6 +325,16 @@ migrate_hook_end_tls_x509(QTestState *from,
 
     g_free(data);
 }
+
+static void test_precopy_tls_x509_common(MigrateCommon *args,
+                                         TestMigrateTLSX509 *test_args)
+{
+    TestMigrateTLSX509Data *data = g_new0(TestMigrateTLSX509Data, 1);
+
+    migrate_tls_x509_init(args, test_args, data);
+    test_precopy_common(args);
+    migrate_tls_x509_cleanup(data);
+}
 #endif /* CONFIG_TASN1 */
 
 static void test_postcopy_tls_psk(char *name, MigrateCommon *args)
@@ -409,12 +419,11 @@ static void test_precopy_unix_tls_x509_default_host(char *name,
     args->listen_uri = uri;
     args->start_hook_full = migrate_hook_start_tls_x509_common;
     args->start_hook_data = &tls_x509_default_host;
-    args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
 
     args->start.hide_stderr = true;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &tls_x509_default_host);
 }
 
 static void test_precopy_unix_tls_x509_override_host(char *name,
@@ -426,9 +435,8 @@ static void test_precopy_unix_tls_x509_override_host(char *name,
     args->listen_uri = uri;
     args->start_hook_full = migrate_hook_start_tls_x509_common;
     args->start_hook_data = &tls_x509_override_host;
-    args->end_hook = migrate_hook_end_tls_x509;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &tls_x509_override_host);
 }
 #endif /* CONFIG_TASN1 */
 
@@ -488,12 +496,11 @@ static void test_precopy_tcp_tls_no_hostname(char *name, MigrateCommon *args)
 {
     args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_no_host;
-    args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
 
     args->start.hide_stderr = true;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &tls_x509_no_host);
 }
 
 #ifdef CONFIG_TASN1
@@ -503,9 +510,8 @@ static void test_precopy_tcp_tls_x509_default_host(char *name,
     args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook_full = migrate_hook_start_tls_x509_common;
     args->start_hook_data = &tls_x509_default_host;
-    args->end_hook = migrate_hook_end_tls_x509;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &tls_x509_default_host);
 }
 
 static void test_precopy_tcp_tls_x509_override_host(char *name,
@@ -514,9 +520,8 @@ static void test_precopy_tcp_tls_x509_override_host(char *name,
     args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook_full = migrate_hook_start_tls_x509_common;
     args->start_hook_data = &tls_x509_override_host;
-    args->end_hook = migrate_hook_end_tls_x509;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &tls_x509_override_host);
 }
 
 static void test_precopy_tcp_tls_x509_mismatch_host(char *name,
@@ -525,12 +530,11 @@ static void test_precopy_tcp_tls_x509_mismatch_host(char *name,
     args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook_full = migrate_hook_start_tls_x509_common;
     args->start_hook_data = &tls_x509_mismatch_host;
-    args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
 
     args->start.hide_stderr = true;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &tls_x509_mismatch_host);
 }
 
 static void test_precopy_tcp_tls_x509_friendly_client(char *name,
@@ -539,9 +543,8 @@ static void test_precopy_tcp_tls_x509_friendly_client(char *name,
     args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook_full = migrate_hook_start_tls_x509_common;
     args->start_hook_data = &x509_friendly_client;
-    args->end_hook = migrate_hook_end_tls_x509;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &x509_friendly_client);
 }
 
 static void test_precopy_tcp_tls_x509_hostile_client(char *name,
@@ -550,12 +553,11 @@ static void test_precopy_tcp_tls_x509_hostile_client(char *name,
     args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook_full = migrate_hook_start_tls_x509_common;
     args->start_hook_data = &tls_x509_hostile_client;
-    args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
 
     args->start.hide_stderr = true;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &tls_x509_hostile_client);
 }
 
 static void test_precopy_tcp_tls_x509_allow_anon_client(char *name,
@@ -564,9 +566,8 @@ static void test_precopy_tcp_tls_x509_allow_anon_client(char *name,
     args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook_full = migrate_hook_start_tls_x509_common;
     args->start_hook_data = &tls_x509_allow_anon_client;
-    args->end_hook = migrate_hook_end_tls_x509;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &tls_x509_allow_anon_client);
 }
 
 static void test_precopy_tcp_tls_x509_reject_anon_client(char *name,
@@ -575,12 +576,11 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(char *name,
     args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook_full = migrate_hook_start_tls_x509_common;
     args->start_hook_data = &tls_x509_reject_anon_client;
-    args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
 
     args->start.hide_stderr = true;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &tls_x509_reject_anon_client);
 }
 #endif /* CONFIG_TASN1 */
 
@@ -691,26 +691,24 @@ static void test_multifd_tcp_tls_x509_default_host(char *name,
                                                    MigrateCommon *args)
 {
     args->start_hook = migrate_hook_start_multifd_tls_x509_default_host;
-    args->end_hook = migrate_hook_end_tls_x509;
     args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &tls_x509_default_host);
 }
 
 static void test_multifd_tcp_tls_x509_override_host(char *name,
                                                     MigrateCommon *args)
 {
     args->start_hook = migrate_hook_start_multifd_tls_x509_override_host;
-    args->end_hook = migrate_hook_end_tls_x509;
     args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &tls_x509_override_host);
 }
 
 static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
@@ -730,7 +728,6 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
      * without exiting.
      */
     args->start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host;
-    args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
     args->listen_uri = "tcp:127.0.0.1:0";
 
@@ -738,27 +735,25 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
     args->start.hide_stderr = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &tls_x509_mismatch_host);
 }
 
 static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
                                                         MigrateCommon *args)
 {
     args->start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client;
-    args->end_hook = migrate_hook_end_tls_x509;
     args->listen_uri = "tcp:127.0.0.1:0";
 
     args->start.incoming_defer = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &tls_x509_allow_anon_client);
 }
 
 static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
                                                          MigrateCommon *args)
 {
     args->start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client;
-    args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
     args->listen_uri = "tcp:127.0.0.1:0";
 
@@ -766,7 +761,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
     args->start.hide_stderr = true;
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-    test_precopy_common(args);
+    test_precopy_tls_x509_common(args, &tls_x509_reject_anon_client);
 }
 #endif /* CONFIG_TASN1 */
 
-- 
2.51.0


