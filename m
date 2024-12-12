Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67790E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkpm-0004FP-Jm; Thu, 12 Dec 2024 10:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpd-00044a-G2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:25 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpX-0003EB-PH
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9912E2110B;
 Thu, 12 Dec 2024 15:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5gqIniYeN/dw2jy76W6QZ1n04EdqaTre0DLXVAy9Kzs=;
 b=pKFz7fqrZItJ1cdTgo9v3aO6zYII6En12m54SgfQMHbghy8PwJ+HfQJmiJ7Jyo+4Z5VcPp
 B3xo7ri+BelU2ITk4HTjkth0pXKuGzP1+LNDxZaJKM44gr/aRGxuHEWnm/f6veqqzz6gow
 pRHFIze8xor5h6yKPHULS9XYglYzQds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016217;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5gqIniYeN/dw2jy76W6QZ1n04EdqaTre0DLXVAy9Kzs=;
 b=ypk0Y9xPTBfbBWHmMJgi8EPlOn6BFavY6E7dcDa0YhrVQywhizXxF7HXyB1XgSGEv9eJ98
 jnmVfUsNXOwedYCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pKFz7fqr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ypk0Y9xP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5gqIniYeN/dw2jy76W6QZ1n04EdqaTre0DLXVAy9Kzs=;
 b=pKFz7fqrZItJ1cdTgo9v3aO6zYII6En12m54SgfQMHbghy8PwJ+HfQJmiJ7Jyo+4Z5VcPp
 B3xo7ri+BelU2ITk4HTjkth0pXKuGzP1+LNDxZaJKM44gr/aRGxuHEWnm/f6veqqzz6gow
 pRHFIze8xor5h6yKPHULS9XYglYzQds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016217;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5gqIniYeN/dw2jy76W6QZ1n04EdqaTre0DLXVAy9Kzs=;
 b=ypk0Y9xPTBfbBWHmMJgi8EPlOn6BFavY6E7dcDa0YhrVQywhizXxF7HXyB1XgSGEv9eJ98
 jnmVfUsNXOwedYCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 679A413508;
 Thu, 12 Dec 2024 15:10:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mJx+C9j8WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:10:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 15/22] tests/qtest/migration: Split TLS tests from
 migration-test.c
Date: Thu, 12 Dec 2024 12:09:42 -0300
Message-Id: <20241212150949.16806-16-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9912E2110B
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

The migration-test.c file has become unwieldy large. It's quite
confusing to navigate with all the test definitions mixed with hook
definitions. The TLS tests make this worse with ifdef'ery.

Since we're planning on having a smaller set of tests to run as smoke
testing on all architectures, I'm taking the time to split some tests
into their own file.

Move the TLS tests into a file of their own.

Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build           |   8 +-
 tests/qtest/migration-test.c      | 788 +----------------------------
 tests/qtest/migration/framework.h |   6 +
 tests/qtest/migration/tls-tests.c | 791 ++++++++++++++++++++++++++++++
 4 files changed, 804 insertions(+), 789 deletions(-)
 create mode 100644 tests/qtest/migration/tls-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c5cc09fbf2..6dc4ba9d40 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -339,11 +339,13 @@ migration_files = [files(
   'migration/migration-util.c',
 )]
 
+migration_tls_files = []
 if gnutls.found()
-  migration_files += [files('../unit/crypto-tls-psk-helpers.c'), gnutls]
+  migration_tls_files = [files('migration/tls-tests.c',
+                               '../unit/crypto-tls-psk-helpers.c'), gnutls]
 
   if tasn1.found()
-    migration_files += [files('../unit/crypto-tls-x509-helpers.c'), tasn1]
+    migration_tls_files += [files('../unit/crypto-tls-x509-helpers.c'), tasn1]
   endif
 endif
 
@@ -354,7 +356,7 @@ qtests = {
                              'migration/migration-util.c') + dbus_vmstate1,
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
-  'migration-test': migration_files,
+  'migration-test': migration_files + migration_tls_files,
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c'),
   'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index a60150483e..7395403f50 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -26,12 +26,6 @@
 #include "migration/framework.h"
 #include "migration/migration-qmp.h"
 #include "migration/migration-util.h"
-#ifdef CONFIG_GNUTLS
-# include "tests/unit/crypto-tls-psk-helpers.h"
-# ifdef CONFIG_TASN1
-#  include "tests/unit/crypto-tls-x509-helpers.h"
-# endif /* CONFIG_TASN1 */
-#endif /* CONFIG_GNUTLS */
 
 /*
  * Dirtylimit stop working if dirty page rate error
@@ -49,345 +43,6 @@
 
 static char *tmpfs;
 
-#ifdef CONFIG_GNUTLS
-struct TestMigrateTLSPSKData {
-    char *workdir;
-    char *workdiralt;
-    char *pskfile;
-    char *pskfilealt;
-};
-
-static void *
-migrate_hook_start_tls_psk_common(QTestState *from,
-                                  QTestState *to,
-                                  bool mismatch)
-{
-    struct TestMigrateTLSPSKData *data =
-        g_new0(struct TestMigrateTLSPSKData, 1);
-
-    data->workdir = g_strdup_printf("%s/tlscredspsk0", tmpfs);
-    data->pskfile = g_strdup_printf("%s/%s", data->workdir,
-                                    QCRYPTO_TLS_CREDS_PSKFILE);
-    g_mkdir_with_parents(data->workdir, 0700);
-    test_tls_psk_init(data->pskfile);
-
-    if (mismatch) {
-        data->workdiralt = g_strdup_printf("%s/tlscredspskalt0", tmpfs);
-        data->pskfilealt = g_strdup_printf("%s/%s", data->workdiralt,
-                                           QCRYPTO_TLS_CREDS_PSKFILE);
-        g_mkdir_with_parents(data->workdiralt, 0700);
-        test_tls_psk_init_alt(data->pskfilealt);
-    }
-
-    qtest_qmp_assert_success(from,
-                             "{ 'execute': 'object-add',"
-                             "  'arguments': { 'qom-type': 'tls-creds-psk',"
-                             "                 'id': 'tlscredspsk0',"
-                             "                 'endpoint': 'client',"
-                             "                 'dir': %s,"
-                             "                 'username': 'qemu'} }",
-                             data->workdir);
-
-    qtest_qmp_assert_success(to,
-                             "{ 'execute': 'object-add',"
-                             "  'arguments': { 'qom-type': 'tls-creds-psk',"
-                             "                 'id': 'tlscredspsk0',"
-                             "                 'endpoint': 'server',"
-                             "                 'dir': %s } }",
-                             mismatch ? data->workdiralt : data->workdir);
-
-    migrate_set_parameter_str(from, "tls-creds", "tlscredspsk0");
-    migrate_set_parameter_str(to, "tls-creds", "tlscredspsk0");
-
-    return data;
-}
-
-static void *
-migrate_hook_start_tls_psk_match(QTestState *from,
-                                 QTestState *to)
-{
-    return migrate_hook_start_tls_psk_common(from, to, false);
-}
-
-static void *
-migrate_hook_start_tls_psk_mismatch(QTestState *from,
-                                    QTestState *to)
-{
-    return migrate_hook_start_tls_psk_common(from, to, true);
-}
-
-static void
-migrate_hook_end_tls_psk(QTestState *from,
-                         QTestState *to,
-                         void *opaque)
-{
-    struct TestMigrateTLSPSKData *data = opaque;
-
-    test_tls_psk_cleanup(data->pskfile);
-    if (data->pskfilealt) {
-        test_tls_psk_cleanup(data->pskfilealt);
-    }
-    rmdir(data->workdir);
-    if (data->workdiralt) {
-        rmdir(data->workdiralt);
-    }
-
-    g_free(data->workdiralt);
-    g_free(data->pskfilealt);
-    g_free(data->workdir);
-    g_free(data->pskfile);
-    g_free(data);
-}
-
-#ifdef CONFIG_TASN1
-typedef struct {
-    char *workdir;
-    char *keyfile;
-    char *cacert;
-    char *servercert;
-    char *serverkey;
-    char *clientcert;
-    char *clientkey;
-} TestMigrateTLSX509Data;
-
-typedef struct {
-    bool verifyclient;
-    bool clientcert;
-    bool hostileclient;
-    bool authzclient;
-    const char *certhostname;
-    const char *certipaddr;
-} TestMigrateTLSX509;
-
-static void *
-migrate_hook_start_tls_x509_common(QTestState *from,
-                                   QTestState *to,
-                                   TestMigrateTLSX509 *args)
-{
-    TestMigrateTLSX509Data *data = g_new0(TestMigrateTLSX509Data, 1);
-
-    data->workdir = g_strdup_printf("%s/tlscredsx5090", tmpfs);
-    data->keyfile = g_strdup_printf("%s/key.pem", data->workdir);
-
-    data->cacert = g_strdup_printf("%s/ca-cert.pem", data->workdir);
-    data->serverkey = g_strdup_printf("%s/server-key.pem", data->workdir);
-    data->servercert = g_strdup_printf("%s/server-cert.pem", data->workdir);
-    if (args->clientcert) {
-        data->clientkey = g_strdup_printf("%s/client-key.pem", data->workdir);
-        data->clientcert = g_strdup_printf("%s/client-cert.pem", data->workdir);
-    }
-
-    g_mkdir_with_parents(data->workdir, 0700);
-
-    test_tls_init(data->keyfile);
-#ifndef _WIN32
-    g_assert(link(data->keyfile, data->serverkey) == 0);
-#else
-    g_assert(CreateHardLink(data->serverkey, data->keyfile, NULL) != 0);
-#endif
-    if (args->clientcert) {
-#ifndef _WIN32
-        g_assert(link(data->keyfile, data->clientkey) == 0);
-#else
-        g_assert(CreateHardLink(data->clientkey, data->keyfile, NULL) != 0);
-#endif
-    }
-
-    TLS_ROOT_REQ_SIMPLE(cacertreq, data->cacert);
-    if (args->clientcert) {
-        TLS_CERT_REQ_SIMPLE_CLIENT(servercertreq, cacertreq,
-                                   args->hostileclient ?
-                                   QCRYPTO_TLS_TEST_CLIENT_HOSTILE_NAME :
-                                   QCRYPTO_TLS_TEST_CLIENT_NAME,
-                                   data->clientcert);
-        test_tls_deinit_cert(&servercertreq);
-    }
-
-    TLS_CERT_REQ_SIMPLE_SERVER(clientcertreq, cacertreq,
-                               data->servercert,
-                               args->certhostname,
-                               args->certipaddr);
-    test_tls_deinit_cert(&clientcertreq);
-    test_tls_deinit_cert(&cacertreq);
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
-}
-
-/*
- * The normal case: match server's cert hostname against
- * whatever host we were telling QEMU to connect to (if any)
- */
-static void *
-migrate_hook_start_tls_x509_default_host(QTestState *from,
-                                         QTestState *to)
-{
-    TestMigrateTLSX509 args = {
-        .verifyclient = true,
-        .clientcert = true,
-        .certipaddr = "127.0.0.1"
-    };
-    return migrate_hook_start_tls_x509_common(from, to, &args);
-}
-
-/*
- * The unusual case: the server's cert is different from
- * the address we're telling QEMU to connect to (if any),
- * so we must give QEMU an explicit hostname to validate
- */
-static void *
-migrate_hook_start_tls_x509_override_host(QTestState *from,
-                                          QTestState *to)
-{
-    TestMigrateTLSX509 args = {
-        .verifyclient = true,
-        .clientcert = true,
-        .certhostname = "qemu.org",
-    };
-    return migrate_hook_start_tls_x509_common(from, to, &args);
-}
-
-/*
- * The unusual case: the server's cert is different from
- * the address we're telling QEMU to connect to, and so we
- * expect the client to reject the server
- */
-static void *
-migrate_hook_start_tls_x509_mismatch_host(QTestState *from,
-                                          QTestState *to)
-{
-    TestMigrateTLSX509 args = {
-        .verifyclient = true,
-        .clientcert = true,
-        .certipaddr = "10.0.0.1",
-    };
-    return migrate_hook_start_tls_x509_common(from, to, &args);
-}
-
-static void *
-migrate_hook_start_tls_x509_friendly_client(QTestState *from,
-                                            QTestState *to)
-{
-    TestMigrateTLSX509 args = {
-        .verifyclient = true,
-        .clientcert = true,
-        .authzclient = true,
-        .certipaddr = "127.0.0.1",
-    };
-    return migrate_hook_start_tls_x509_common(from, to, &args);
-}
-
-static void *
-migrate_hook_start_tls_x509_hostile_client(QTestState *from,
-                                           QTestState *to)
-{
-    TestMigrateTLSX509 args = {
-        .verifyclient = true,
-        .clientcert = true,
-        .hostileclient = true,
-        .authzclient = true,
-        .certipaddr = "127.0.0.1",
-    };
-    return migrate_hook_start_tls_x509_common(from, to, &args);
-}
-
-/*
- * The case with no client certificate presented,
- * and no server verification
- */
-static void *
-migrate_hook_start_tls_x509_allow_anon_client(QTestState *from,
-                                              QTestState *to)
-{
-    TestMigrateTLSX509 args = {
-        .certipaddr = "127.0.0.1",
-    };
-    return migrate_hook_start_tls_x509_common(from, to, &args);
-}
-
-/*
- * The case with no client certificate presented,
- * and server verification rejecting
- */
-static void *
-migrate_hook_start_tls_x509_reject_anon_client(QTestState *from,
-                                               QTestState *to)
-{
-    TestMigrateTLSX509 args = {
-        .verifyclient = true,
-        .certipaddr = "127.0.0.1",
-    };
-    return migrate_hook_start_tls_x509_common(from, to, &args);
-}
-
-static void
-migrate_hook_end_tls_x509(QTestState *from,
-                          QTestState *to,
-                          void *opaque)
-{
-    TestMigrateTLSX509Data *data = opaque;
-
-    test_tls_cleanup(data->keyfile);
-    g_free(data->keyfile);
-
-    unlink(data->cacert);
-    g_free(data->cacert);
-    unlink(data->servercert);
-    g_free(data->servercert);
-    unlink(data->serverkey);
-    g_free(data->serverkey);
-
-    if (data->clientcert) {
-        unlink(data->clientcert);
-        g_free(data->clientcert);
-    }
-    if (data->clientkey) {
-        unlink(data->clientkey);
-        g_free(data->clientkey);
-    }
-
-    rmdir(data->workdir);
-    g_free(data->workdir);
-
-    g_free(data);
-}
-#endif /* CONFIG_TASN1 */
-#endif /* CONFIG_GNUTLS */
-
 static void test_postcopy(void)
 {
     MigrateCommon args = { };
@@ -413,29 +68,6 @@ static void test_postcopy_preempt(void)
     test_postcopy_common(&args);
 }
 
-#ifdef CONFIG_GNUTLS
-static void test_postcopy_tls_psk(void)
-{
-    MigrateCommon args = {
-        .start_hook = migrate_hook_start_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-    };
-
-    test_postcopy_common(&args);
-}
-
-static void test_postcopy_preempt_tls_psk(void)
-{
-    MigrateCommon args = {
-        .postcopy_preempt = true,
-        .start_hook = migrate_hook_start_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-    };
-
-    test_postcopy_common(&args);
-}
-#endif
-
 static void test_postcopy_recovery(void)
 {
     MigrateCommon args = { };
@@ -461,18 +93,6 @@ static void test_postcopy_recovery_fail_reconnect(void)
     test_postcopy_recovery_common(&args);
 }
 
-#ifdef CONFIG_GNUTLS
-static void test_postcopy_recovery_tls_psk(void)
-{
-    MigrateCommon args = {
-        .start_hook = migrate_hook_start_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-    };
-
-    test_postcopy_recovery_common(&args);
-}
-#endif
-
 static void test_postcopy_preempt_recovery(void)
 {
     MigrateCommon args = {
@@ -482,21 +102,6 @@ static void test_postcopy_preempt_recovery(void)
     test_postcopy_recovery_common(&args);
 }
 
-#ifdef CONFIG_GNUTLS
-/* This contains preempt+recovery+tls test altogether */
-static void test_postcopy_preempt_all(void)
-{
-    MigrateCommon args = {
-        .postcopy_preempt = true,
-        .start_hook = migrate_hook_start_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-    };
-
-    test_postcopy_recovery_common(&args);
-}
-
-#endif
-
 static void test_baddest(void)
 {
     MigrateStart args = {
@@ -631,53 +236,6 @@ static void test_precopy_unix_dirty_ring(void)
     test_precopy_common(&args);
 }
 
-#ifdef CONFIG_GNUTLS
-static void test_precopy_unix_tls_psk(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = uri,
-        .start_hook = migrate_hook_start_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-    };
-
-    test_precopy_common(&args);
-}
-
-#ifdef CONFIG_TASN1
-static void test_precopy_unix_tls_x509_default_host(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .connect_uri = uri,
-        .listen_uri = uri,
-        .start_hook = migrate_hook_start_tls_x509_default_host,
-        .end_hook = migrate_hook_end_tls_x509,
-        .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
-    };
-
-    test_precopy_common(&args);
-}
-
-static void test_precopy_unix_tls_x509_override_host(void)
-{
-    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
-    MigrateCommon args = {
-        .connect_uri = uri,
-        .listen_uri = uri,
-        .start_hook = migrate_hook_start_tls_x509_override_host,
-        .end_hook = migrate_hook_end_tls_x509,
-    };
-
-    test_precopy_common(&args);
-}
-#endif /* CONFIG_TASN1 */
-#endif /* CONFIG_GNUTLS */
-
 #if 0
 /* Currently upset on aarch64 TCG */
 static void test_ignore_shared(void)
@@ -1086,125 +644,6 @@ static void test_precopy_tcp_switchover_ack(void)
     test_precopy_common(&args);
 }
 
-#ifdef CONFIG_GNUTLS
-static void test_precopy_tcp_tls_psk_match(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-    };
-
-    test_precopy_common(&args);
-}
-
-static void test_precopy_tcp_tls_psk_mismatch(void)
-{
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_psk_mismatch,
-        .end_hook = migrate_hook_end_tls_psk,
-        .result = MIG_TEST_FAIL,
-    };
-
-    test_precopy_common(&args);
-}
-
-#ifdef CONFIG_TASN1
-static void test_precopy_tcp_tls_x509_default_host(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_default_host,
-        .end_hook = migrate_hook_end_tls_x509,
-    };
-
-    test_precopy_common(&args);
-}
-
-static void test_precopy_tcp_tls_x509_override_host(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_override_host,
-        .end_hook = migrate_hook_end_tls_x509,
-    };
-
-    test_precopy_common(&args);
-}
-
-static void test_precopy_tcp_tls_x509_mismatch_host(void)
-{
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_mismatch_host,
-        .end_hook = migrate_hook_end_tls_x509,
-        .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
-    };
-
-    test_precopy_common(&args);
-}
-
-static void test_precopy_tcp_tls_x509_friendly_client(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_friendly_client,
-        .end_hook = migrate_hook_end_tls_x509,
-    };
-
-    test_precopy_common(&args);
-}
-
-static void test_precopy_tcp_tls_x509_hostile_client(void)
-{
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_hostile_client,
-        .end_hook = migrate_hook_end_tls_x509,
-        .result = MIG_TEST_FAIL,
-    };
-
-    test_precopy_common(&args);
-}
-
-static void test_precopy_tcp_tls_x509_allow_anon_client(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_allow_anon_client,
-        .end_hook = migrate_hook_end_tls_x509,
-    };
-
-    test_precopy_common(&args);
-}
-
-static void test_precopy_tcp_tls_x509_reject_anon_client(void)
-{
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = migrate_hook_start_tls_x509_reject_anon_client,
-        .end_hook = migrate_hook_end_tls_x509,
-        .result = MIG_TEST_FAIL,
-    };
-
-    test_precopy_common(&args);
-}
-#endif /* CONFIG_TASN1 */
-#endif /* CONFIG_GNUTLS */
-
 #ifndef _WIN32
 static void *migrate_hook_start_fd(QTestState *from,
                                    QTestState *to)
@@ -1745,163 +1184,6 @@ static void test_multifd_tcp_uadk(void)
 }
 #endif
 
-#ifdef CONFIG_GNUTLS
-static void *
-migrate_hook_start_multifd_tcp_tls_psk_match(QTestState *from,
-                                             QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_psk_match(from, to);
-}
-
-static void *
-migrate_hook_start_multifd_tcp_tls_psk_mismatch(QTestState *from,
-                                                QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_psk_mismatch(from, to);
-}
-
-#ifdef CONFIG_TASN1
-static void *
-migrate_hook_start_multifd_tls_x509_default_host(QTestState *from,
-                                                 QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_default_host(from, to);
-}
-
-static void *
-migrate_hook_start_multifd_tls_x509_override_host(QTestState *from,
-                                                  QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_override_host(from, to);
-}
-
-static void *
-migrate_hook_start_multifd_tls_x509_mismatch_host(QTestState *from,
-                                                  QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_mismatch_host(from, to);
-}
-
-static void *
-migrate_hook_start_multifd_tls_x509_allow_anon_client(QTestState *from,
-                                                      QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_allow_anon_client(from, to);
-}
-
-static void *
-migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
-                                                       QTestState *to)
-{
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-    return migrate_hook_start_tls_x509_reject_anon_client(from, to);
-}
-#endif /* CONFIG_TASN1 */
-
-static void test_multifd_tcp_tls_psk_match(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
-        .end_hook = migrate_hook_end_tls_psk,
-    };
-    test_precopy_common(&args);
-}
-
-static void test_multifd_tcp_tls_psk_mismatch(void)
-{
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch,
-        .end_hook = migrate_hook_end_tls_psk,
-        .result = MIG_TEST_FAIL,
-    };
-    test_precopy_common(&args);
-}
-
-#ifdef CONFIG_TASN1
-static void test_multifd_tcp_tls_x509_default_host(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tls_x509_default_host,
-        .end_hook = migrate_hook_end_tls_x509,
-    };
-    test_precopy_common(&args);
-}
-
-static void test_multifd_tcp_tls_x509_override_host(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tls_x509_override_host,
-        .end_hook = migrate_hook_end_tls_x509,
-    };
-    test_precopy_common(&args);
-}
-
-static void test_multifd_tcp_tls_x509_mismatch_host(void)
-{
-    /*
-     * This has different behaviour to the non-multifd case.
-     *
-     * In non-multifd case when client aborts due to mismatched
-     * cert host, the server has already started trying to load
-     * migration state, and so it exits with I/O failure.
-     *
-     * In multifd case when client aborts due to mismatched
-     * cert host, the server is still waiting for the other
-     * multifd connections to arrive so hasn't started trying
-     * to load migration state, and thus just aborts the migration
-     * without exiting.
-     */
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host,
-        .end_hook = migrate_hook_end_tls_x509,
-        .result = MIG_TEST_FAIL,
-    };
-    test_precopy_common(&args);
-}
-
-static void test_multifd_tcp_tls_x509_allow_anon_client(void)
-{
-    MigrateCommon args = {
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client,
-        .end_hook = migrate_hook_end_tls_x509,
-    };
-    test_precopy_common(&args);
-}
-
-static void test_multifd_tcp_tls_x509_reject_anon_client(void)
-{
-    MigrateCommon args = {
-        .start = {
-            .hide_stderr = true,
-        },
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client,
-        .end_hook = migrate_hook_end_tls_x509,
-        .result = MIG_TEST_FAIL,
-    };
-    test_precopy_common(&args);
-}
-#endif /* CONFIG_TASN1 */
-#endif /* CONFIG_GNUTLS */
-
 /*
  * This test does:
  *  source               target
@@ -2412,6 +1694,8 @@ int main(int argc, char **argv)
 
     tmpfs = env->tmpfs;
 
+    migration_test_add_tls(env);
+
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
     migration_test_add("/migration/analyze-script", test_analyze_script);
@@ -2487,61 +1771,11 @@ int main(int argc, char **argv)
                        test_multifd_file_mapped_ram_fdset_dio);
 #endif
 
-#ifdef CONFIG_GNUTLS
-    migration_test_add("/migration/precopy/unix/tls/psk",
-                       test_precopy_unix_tls_psk);
-
-    if (env->has_uffd) {
-        /*
-         * NOTE: psk test is enough for postcopy, as other types of TLS
-         * channels are tested under precopy.  Here what we want to test is the
-         * general postcopy path that has TLS channel enabled.
-         */
-        migration_test_add("/migration/postcopy/tls/psk",
-                           test_postcopy_tls_psk);
-        migration_test_add("/migration/postcopy/recovery/tls/psk",
-                           test_postcopy_recovery_tls_psk);
-        migration_test_add("/migration/postcopy/preempt/tls/psk",
-                           test_postcopy_preempt_tls_psk);
-        migration_test_add("/migration/postcopy/preempt/recovery/tls/psk",
-                           test_postcopy_preempt_all);
-    }
-#ifdef CONFIG_TASN1
-    migration_test_add("/migration/precopy/unix/tls/x509/default-host",
-                       test_precopy_unix_tls_x509_default_host);
-    migration_test_add("/migration/precopy/unix/tls/x509/override-host",
-                       test_precopy_unix_tls_x509_override_host);
-#endif /* CONFIG_TASN1 */
-#endif /* CONFIG_GNUTLS */
-
     migration_test_add("/migration/precopy/tcp/plain", test_precopy_tcp_plain);
 
     migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
                        test_precopy_tcp_switchover_ack);
 
-#ifdef CONFIG_GNUTLS
-    migration_test_add("/migration/precopy/tcp/tls/psk/match",
-                       test_precopy_tcp_tls_psk_match);
-    migration_test_add("/migration/precopy/tcp/tls/psk/mismatch",
-                       test_precopy_tcp_tls_psk_mismatch);
-#ifdef CONFIG_TASN1
-    migration_test_add("/migration/precopy/tcp/tls/x509/default-host",
-                       test_precopy_tcp_tls_x509_default_host);
-    migration_test_add("/migration/precopy/tcp/tls/x509/override-host",
-                       test_precopy_tcp_tls_x509_override_host);
-    migration_test_add("/migration/precopy/tcp/tls/x509/mismatch-host",
-                       test_precopy_tcp_tls_x509_mismatch_host);
-    migration_test_add("/migration/precopy/tcp/tls/x509/friendly-client",
-                       test_precopy_tcp_tls_x509_friendly_client);
-    migration_test_add("/migration/precopy/tcp/tls/x509/hostile-client",
-                       test_precopy_tcp_tls_x509_hostile_client);
-    migration_test_add("/migration/precopy/tcp/tls/x509/allow-anon-client",
-                       test_precopy_tcp_tls_x509_allow_anon_client);
-    migration_test_add("/migration/precopy/tcp/tls/x509/reject-anon-client",
-                       test_precopy_tcp_tls_x509_reject_anon_client);
-#endif /* CONFIG_TASN1 */
-#endif /* CONFIG_GNUTLS */
-
     /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
 #ifndef _WIN32
     migration_test_add("/migration/precopy/fd/tcp",
@@ -2600,24 +1834,6 @@ int main(int argc, char **argv)
     migration_test_add("/migration/multifd/tcp/plain/uadk",
                        test_multifd_tcp_uadk);
 #endif
-#ifdef CONFIG_GNUTLS
-    migration_test_add("/migration/multifd/tcp/tls/psk/match",
-                       test_multifd_tcp_tls_psk_match);
-    migration_test_add("/migration/multifd/tcp/tls/psk/mismatch",
-                       test_multifd_tcp_tls_psk_mismatch);
-#ifdef CONFIG_TASN1
-    migration_test_add("/migration/multifd/tcp/tls/x509/default-host",
-                       test_multifd_tcp_tls_x509_default_host);
-    migration_test_add("/migration/multifd/tcp/tls/x509/override-host",
-                       test_multifd_tcp_tls_x509_override_host);
-    migration_test_add("/migration/multifd/tcp/tls/x509/mismatch-host",
-                       test_multifd_tcp_tls_x509_mismatch_host);
-    migration_test_add("/migration/multifd/tcp/tls/x509/allow-anon-client",
-                       test_multifd_tcp_tls_x509_allow_anon_client);
-    migration_test_add("/migration/multifd/tcp/tls/x509/reject-anon-client",
-                       test_multifd_tcp_tls_x509_reject_anon_client);
-#endif /* CONFIG_TASN1 */
-#endif /* CONFIG_GNUTLS */
 
     if (g_str_equal(env->arch, "x86_64") &&
         env->has_kvm && env->has_dirty_ring) {
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 6d5176b056..1aad4da0e0 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -215,4 +215,10 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
 typedef struct QTestMigrationState QTestMigrationState;
 QTestMigrationState *get_src(void);
 
+#ifdef CONFIG_GNUTLS
+void migration_test_add_tls(MigrationTestEnv *env);
+#else
+static inline void migration_test_add_tls(MigrationTestEnv *env) {};
+#endif
+
 #endif /* TEST_FRAMEWORK_H */
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
new file mode 100644
index 0000000000..5704a1f992
--- /dev/null
+++ b/tests/qtest/migration/tls-tests.c
@@ -0,0 +1,791 @@
+/*
+ * QTest testcases for TLS migration
+ *
+ * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "crypto/tlscredspsk.h"
+#include "libqtest.h"
+#include "migration/framework.h"
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+
+#include "tests/unit/crypto-tls-psk-helpers.h"
+#ifdef CONFIG_TASN1
+# include "tests/unit/crypto-tls-x509-helpers.h"
+#endif /* CONFIG_TASN1 */
+
+
+struct TestMigrateTLSPSKData {
+    char *workdir;
+    char *workdiralt;
+    char *pskfile;
+    char *pskfilealt;
+};
+
+static char *tmpfs;
+
+static void *
+migrate_hook_start_tls_psk_common(QTestState *from,
+                                  QTestState *to,
+                                  bool mismatch)
+{
+    struct TestMigrateTLSPSKData *data =
+        g_new0(struct TestMigrateTLSPSKData, 1);
+
+    data->workdir = g_strdup_printf("%s/tlscredspsk0", tmpfs);
+    data->pskfile = g_strdup_printf("%s/%s", data->workdir,
+                                    QCRYPTO_TLS_CREDS_PSKFILE);
+    g_mkdir_with_parents(data->workdir, 0700);
+    test_tls_psk_init(data->pskfile);
+
+    if (mismatch) {
+        data->workdiralt = g_strdup_printf("%s/tlscredspskalt0", tmpfs);
+        data->pskfilealt = g_strdup_printf("%s/%s", data->workdiralt,
+                                           QCRYPTO_TLS_CREDS_PSKFILE);
+        g_mkdir_with_parents(data->workdiralt, 0700);
+        test_tls_psk_init_alt(data->pskfilealt);
+    }
+
+    qtest_qmp_assert_success(from,
+                             "{ 'execute': 'object-add',"
+                             "  'arguments': { 'qom-type': 'tls-creds-psk',"
+                             "                 'id': 'tlscredspsk0',"
+                             "                 'endpoint': 'client',"
+                             "                 'dir': %s,"
+                             "                 'username': 'qemu'} }",
+                             data->workdir);
+
+    qtest_qmp_assert_success(to,
+                             "{ 'execute': 'object-add',"
+                             "  'arguments': { 'qom-type': 'tls-creds-psk',"
+                             "                 'id': 'tlscredspsk0',"
+                             "                 'endpoint': 'server',"
+                             "                 'dir': %s } }",
+                             mismatch ? data->workdiralt : data->workdir);
+
+    migrate_set_parameter_str(from, "tls-creds", "tlscredspsk0");
+    migrate_set_parameter_str(to, "tls-creds", "tlscredspsk0");
+
+    return data;
+}
+
+static void *
+migrate_hook_start_tls_psk_match(QTestState *from,
+                                 QTestState *to)
+{
+    return migrate_hook_start_tls_psk_common(from, to, false);
+}
+
+static void *
+migrate_hook_start_tls_psk_mismatch(QTestState *from,
+                                    QTestState *to)
+{
+    return migrate_hook_start_tls_psk_common(from, to, true);
+}
+
+static void
+migrate_hook_end_tls_psk(QTestState *from,
+                         QTestState *to,
+                         void *opaque)
+{
+    struct TestMigrateTLSPSKData *data = opaque;
+
+    test_tls_psk_cleanup(data->pskfile);
+    if (data->pskfilealt) {
+        test_tls_psk_cleanup(data->pskfilealt);
+    }
+    rmdir(data->workdir);
+    if (data->workdiralt) {
+        rmdir(data->workdiralt);
+    }
+
+    g_free(data->workdiralt);
+    g_free(data->pskfilealt);
+    g_free(data->workdir);
+    g_free(data->pskfile);
+    g_free(data);
+}
+
+#ifdef CONFIG_TASN1
+typedef struct {
+    char *workdir;
+    char *keyfile;
+    char *cacert;
+    char *servercert;
+    char *serverkey;
+    char *clientcert;
+    char *clientkey;
+} TestMigrateTLSX509Data;
+
+typedef struct {
+    bool verifyclient;
+    bool clientcert;
+    bool hostileclient;
+    bool authzclient;
+    const char *certhostname;
+    const char *certipaddr;
+} TestMigrateTLSX509;
+
+static void *
+migrate_hook_start_tls_x509_common(QTestState *from,
+                                   QTestState *to,
+                                   TestMigrateTLSX509 *args)
+{
+    TestMigrateTLSX509Data *data = g_new0(TestMigrateTLSX509Data, 1);
+
+    data->workdir = g_strdup_printf("%s/tlscredsx5090", tmpfs);
+    data->keyfile = g_strdup_printf("%s/key.pem", data->workdir);
+
+    data->cacert = g_strdup_printf("%s/ca-cert.pem", data->workdir);
+    data->serverkey = g_strdup_printf("%s/server-key.pem", data->workdir);
+    data->servercert = g_strdup_printf("%s/server-cert.pem", data->workdir);
+    if (args->clientcert) {
+        data->clientkey = g_strdup_printf("%s/client-key.pem", data->workdir);
+        data->clientcert = g_strdup_printf("%s/client-cert.pem", data->workdir);
+    }
+
+    g_mkdir_with_parents(data->workdir, 0700);
+
+    test_tls_init(data->keyfile);
+#ifndef _WIN32
+    g_assert(link(data->keyfile, data->serverkey) == 0);
+#else
+    g_assert(CreateHardLink(data->serverkey, data->keyfile, NULL) != 0);
+#endif
+    if (args->clientcert) {
+#ifndef _WIN32
+        g_assert(link(data->keyfile, data->clientkey) == 0);
+#else
+        g_assert(CreateHardLink(data->clientkey, data->keyfile, NULL) != 0);
+#endif
+    }
+
+    TLS_ROOT_REQ_SIMPLE(cacertreq, data->cacert);
+    if (args->clientcert) {
+        TLS_CERT_REQ_SIMPLE_CLIENT(servercertreq, cacertreq,
+                                   args->hostileclient ?
+                                   QCRYPTO_TLS_TEST_CLIENT_HOSTILE_NAME :
+                                   QCRYPTO_TLS_TEST_CLIENT_NAME,
+                                   data->clientcert);
+        test_tls_deinit_cert(&servercertreq);
+    }
+
+    TLS_CERT_REQ_SIMPLE_SERVER(clientcertreq, cacertreq,
+                               data->servercert,
+                               args->certhostname,
+                               args->certipaddr);
+    test_tls_deinit_cert(&clientcertreq);
+    test_tls_deinit_cert(&cacertreq);
+
+    qtest_qmp_assert_success(from,
+                             "{ 'execute': 'object-add',"
+                             "  'arguments': { 'qom-type': 'tls-creds-x509',"
+                             "                 'id': 'tlscredsx509client0',"
+                             "                 'endpoint': 'client',"
+                             "                 'dir': %s,"
+                             "                 'sanity-check': true,"
+                             "                 'verify-peer': true} }",
+                             data->workdir);
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
+                             data->workdir, args->verifyclient);
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
+    return data;
+}
+
+/*
+ * The normal case: match server's cert hostname against
+ * whatever host we were telling QEMU to connect to (if any)
+ */
+static void *
+migrate_hook_start_tls_x509_default_host(QTestState *from,
+                                         QTestState *to)
+{
+    TestMigrateTLSX509 args = {
+        .verifyclient = true,
+        .clientcert = true,
+        .certipaddr = "127.0.0.1"
+    };
+    return migrate_hook_start_tls_x509_common(from, to, &args);
+}
+
+/*
+ * The unusual case: the server's cert is different from
+ * the address we're telling QEMU to connect to (if any),
+ * so we must give QEMU an explicit hostname to validate
+ */
+static void *
+migrate_hook_start_tls_x509_override_host(QTestState *from,
+                                          QTestState *to)
+{
+    TestMigrateTLSX509 args = {
+        .verifyclient = true,
+        .clientcert = true,
+        .certhostname = "qemu.org",
+    };
+    return migrate_hook_start_tls_x509_common(from, to, &args);
+}
+
+/*
+ * The unusual case: the server's cert is different from
+ * the address we're telling QEMU to connect to, and so we
+ * expect the client to reject the server
+ */
+static void *
+migrate_hook_start_tls_x509_mismatch_host(QTestState *from,
+                                          QTestState *to)
+{
+    TestMigrateTLSX509 args = {
+        .verifyclient = true,
+        .clientcert = true,
+        .certipaddr = "10.0.0.1",
+    };
+    return migrate_hook_start_tls_x509_common(from, to, &args);
+}
+
+static void *
+migrate_hook_start_tls_x509_friendly_client(QTestState *from,
+                                            QTestState *to)
+{
+    TestMigrateTLSX509 args = {
+        .verifyclient = true,
+        .clientcert = true,
+        .authzclient = true,
+        .certipaddr = "127.0.0.1",
+    };
+    return migrate_hook_start_tls_x509_common(from, to, &args);
+}
+
+static void *
+migrate_hook_start_tls_x509_hostile_client(QTestState *from,
+                                           QTestState *to)
+{
+    TestMigrateTLSX509 args = {
+        .verifyclient = true,
+        .clientcert = true,
+        .hostileclient = true,
+        .authzclient = true,
+        .certipaddr = "127.0.0.1",
+    };
+    return migrate_hook_start_tls_x509_common(from, to, &args);
+}
+
+/*
+ * The case with no client certificate presented,
+ * and no server verification
+ */
+static void *
+migrate_hook_start_tls_x509_allow_anon_client(QTestState *from,
+                                              QTestState *to)
+{
+    TestMigrateTLSX509 args = {
+        .certipaddr = "127.0.0.1",
+    };
+    return migrate_hook_start_tls_x509_common(from, to, &args);
+}
+
+/*
+ * The case with no client certificate presented,
+ * and server verification rejecting
+ */
+static void *
+migrate_hook_start_tls_x509_reject_anon_client(QTestState *from,
+                                               QTestState *to)
+{
+    TestMigrateTLSX509 args = {
+        .verifyclient = true,
+        .certipaddr = "127.0.0.1",
+    };
+    return migrate_hook_start_tls_x509_common(from, to, &args);
+}
+
+static void
+migrate_hook_end_tls_x509(QTestState *from,
+                          QTestState *to,
+                          void *opaque)
+{
+    TestMigrateTLSX509Data *data = opaque;
+
+    test_tls_cleanup(data->keyfile);
+    g_free(data->keyfile);
+
+    unlink(data->cacert);
+    g_free(data->cacert);
+    unlink(data->servercert);
+    g_free(data->servercert);
+    unlink(data->serverkey);
+    g_free(data->serverkey);
+
+    if (data->clientcert) {
+        unlink(data->clientcert);
+        g_free(data->clientcert);
+    }
+    if (data->clientkey) {
+        unlink(data->clientkey);
+        g_free(data->clientkey);
+    }
+
+    rmdir(data->workdir);
+    g_free(data->workdir);
+
+    g_free(data);
+}
+#endif /* CONFIG_TASN1 */
+
+static void test_postcopy_tls_psk(void)
+{
+    MigrateCommon args = {
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+    };
+
+    test_postcopy_common(&args);
+}
+
+static void test_postcopy_preempt_tls_psk(void)
+{
+    MigrateCommon args = {
+        .postcopy_preempt = true,
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+    };
+
+    test_postcopy_common(&args);
+}
+
+static void test_postcopy_recovery_tls_psk(void)
+{
+    MigrateCommon args = {
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
+/* This contains preempt+recovery+tls test altogether */
+static void test_postcopy_preempt_all(void)
+{
+    MigrateCommon args = {
+        .postcopy_preempt = true,
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
+static void test_precopy_unix_tls_psk(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = uri,
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+    };
+
+    test_precopy_common(&args);
+}
+
+#ifdef CONFIG_TASN1
+static void test_precopy_unix_tls_x509_default_host(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .connect_uri = uri,
+        .listen_uri = uri,
+        .start_hook = migrate_hook_start_tls_x509_default_host,
+        .end_hook = migrate_hook_end_tls_x509,
+        .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_precopy_unix_tls_x509_override_host(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = uri,
+        .start_hook = migrate_hook_start_tls_x509_override_host,
+        .end_hook = migrate_hook_end_tls_x509,
+    };
+
+    test_precopy_common(&args);
+}
+#endif /* CONFIG_TASN1 */
+
+static void test_precopy_tcp_tls_psk_match(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_precopy_tcp_tls_psk_mismatch(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = migrate_hook_start_tls_psk_mismatch,
+        .end_hook = migrate_hook_end_tls_psk,
+        .result = MIG_TEST_FAIL,
+    };
+
+    test_precopy_common(&args);
+}
+
+#ifdef CONFIG_TASN1
+static void test_precopy_tcp_tls_x509_default_host(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = migrate_hook_start_tls_x509_default_host,
+        .end_hook = migrate_hook_end_tls_x509,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_precopy_tcp_tls_x509_override_host(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = migrate_hook_start_tls_x509_override_host,
+        .end_hook = migrate_hook_end_tls_x509,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_precopy_tcp_tls_x509_mismatch_host(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = migrate_hook_start_tls_x509_mismatch_host,
+        .end_hook = migrate_hook_end_tls_x509,
+        .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_precopy_tcp_tls_x509_friendly_client(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = migrate_hook_start_tls_x509_friendly_client,
+        .end_hook = migrate_hook_end_tls_x509,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_precopy_tcp_tls_x509_hostile_client(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = migrate_hook_start_tls_x509_hostile_client,
+        .end_hook = migrate_hook_end_tls_x509,
+        .result = MIG_TEST_FAIL,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_precopy_tcp_tls_x509_allow_anon_client(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = migrate_hook_start_tls_x509_allow_anon_client,
+        .end_hook = migrate_hook_end_tls_x509,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_precopy_tcp_tls_x509_reject_anon_client(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "tcp:127.0.0.1:0",
+        .start_hook = migrate_hook_start_tls_x509_reject_anon_client,
+        .end_hook = migrate_hook_end_tls_x509,
+        .result = MIG_TEST_FAIL,
+    };
+
+    test_precopy_common(&args);
+}
+#endif /* CONFIG_TASN1 */
+
+static void *
+migrate_hook_start_multifd_tcp_tls_psk_match(QTestState *from,
+                                             QTestState *to)
+{
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    return migrate_hook_start_tls_psk_match(from, to);
+}
+
+static void *
+migrate_hook_start_multifd_tcp_tls_psk_mismatch(QTestState *from,
+                                                QTestState *to)
+{
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    return migrate_hook_start_tls_psk_mismatch(from, to);
+}
+
+#ifdef CONFIG_TASN1
+static void *
+migrate_hook_start_multifd_tls_x509_default_host(QTestState *from,
+                                                 QTestState *to)
+{
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    return migrate_hook_start_tls_x509_default_host(from, to);
+}
+
+static void *
+migrate_hook_start_multifd_tls_x509_override_host(QTestState *from,
+                                                  QTestState *to)
+{
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    return migrate_hook_start_tls_x509_override_host(from, to);
+}
+
+static void *
+migrate_hook_start_multifd_tls_x509_mismatch_host(QTestState *from,
+                                                  QTestState *to)
+{
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    return migrate_hook_start_tls_x509_mismatch_host(from, to);
+}
+
+static void *
+migrate_hook_start_multifd_tls_x509_allow_anon_client(QTestState *from,
+                                                      QTestState *to)
+{
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    return migrate_hook_start_tls_x509_allow_anon_client(from, to);
+}
+
+static void *
+migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
+                                                       QTestState *to)
+{
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    return migrate_hook_start_tls_x509_reject_anon_client(from, to);
+}
+#endif /* CONFIG_TASN1 */
+
+static void test_multifd_tcp_tls_psk_match(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
+    };
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_tls_psk_mismatch(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch,
+        .end_hook = migrate_hook_end_tls_psk,
+        .result = MIG_TEST_FAIL,
+    };
+    test_precopy_common(&args);
+}
+
+#ifdef CONFIG_TASN1
+static void test_multifd_tcp_tls_x509_default_host(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_multifd_tls_x509_default_host,
+        .end_hook = migrate_hook_end_tls_x509,
+    };
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_tls_x509_override_host(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_multifd_tls_x509_override_host,
+        .end_hook = migrate_hook_end_tls_x509,
+    };
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_tls_x509_mismatch_host(void)
+{
+    /*
+     * This has different behaviour to the non-multifd case.
+     *
+     * In non-multifd case when client aborts due to mismatched
+     * cert host, the server has already started trying to load
+     * migration state, and so it exits with I/O failure.
+     *
+     * In multifd case when client aborts due to mismatched
+     * cert host, the server is still waiting for the other
+     * multifd connections to arrive so hasn't started trying
+     * to load migration state, and thus just aborts the migration
+     * without exiting.
+     */
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host,
+        .end_hook = migrate_hook_end_tls_x509,
+        .result = MIG_TEST_FAIL,
+    };
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_tls_x509_allow_anon_client(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client,
+        .end_hook = migrate_hook_end_tls_x509,
+    };
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_tls_x509_reject_anon_client(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client,
+        .end_hook = migrate_hook_end_tls_x509,
+        .result = MIG_TEST_FAIL,
+    };
+    test_precopy_common(&args);
+}
+#endif /* CONFIG_TASN1 */
+
+void migration_test_add_tls(MigrationTestEnv *env)
+{
+    tmpfs = env->tmpfs;
+
+    migration_test_add("/migration/precopy/unix/tls/psk",
+                       test_precopy_unix_tls_psk);
+
+    if (env->has_uffd) {
+        /*
+         * NOTE: psk test is enough for postcopy, as other types of TLS
+         * channels are tested under precopy.  Here what we want to test is the
+         * general postcopy path that has TLS channel enabled.
+         */
+        migration_test_add("/migration/postcopy/tls/psk",
+                           test_postcopy_tls_psk);
+        migration_test_add("/migration/postcopy/recovery/tls/psk",
+                           test_postcopy_recovery_tls_psk);
+        migration_test_add("/migration/postcopy/preempt/tls/psk",
+                           test_postcopy_preempt_tls_psk);
+        migration_test_add("/migration/postcopy/preempt/recovery/tls/psk",
+                           test_postcopy_preempt_all);
+    }
+#ifdef CONFIG_TASN1
+    migration_test_add("/migration/precopy/unix/tls/x509/default-host",
+                       test_precopy_unix_tls_x509_default_host);
+    migration_test_add("/migration/precopy/unix/tls/x509/override-host",
+                       test_precopy_unix_tls_x509_override_host);
+#endif /* CONFIG_TASN1 */
+
+    migration_test_add("/migration/precopy/tcp/tls/psk/match",
+                       test_precopy_tcp_tls_psk_match);
+    migration_test_add("/migration/precopy/tcp/tls/psk/mismatch",
+                       test_precopy_tcp_tls_psk_mismatch);
+#ifdef CONFIG_TASN1
+    migration_test_add("/migration/precopy/tcp/tls/x509/default-host",
+                       test_precopy_tcp_tls_x509_default_host);
+    migration_test_add("/migration/precopy/tcp/tls/x509/override-host",
+                       test_precopy_tcp_tls_x509_override_host);
+    migration_test_add("/migration/precopy/tcp/tls/x509/mismatch-host",
+                       test_precopy_tcp_tls_x509_mismatch_host);
+    migration_test_add("/migration/precopy/tcp/tls/x509/friendly-client",
+                       test_precopy_tcp_tls_x509_friendly_client);
+    migration_test_add("/migration/precopy/tcp/tls/x509/hostile-client",
+                       test_precopy_tcp_tls_x509_hostile_client);
+    migration_test_add("/migration/precopy/tcp/tls/x509/allow-anon-client",
+                       test_precopy_tcp_tls_x509_allow_anon_client);
+    migration_test_add("/migration/precopy/tcp/tls/x509/reject-anon-client",
+                       test_precopy_tcp_tls_x509_reject_anon_client);
+#endif /* CONFIG_TASN1 */
+
+    migration_test_add("/migration/multifd/tcp/tls/psk/match",
+                       test_multifd_tcp_tls_psk_match);
+    migration_test_add("/migration/multifd/tcp/tls/psk/mismatch",
+                       test_multifd_tcp_tls_psk_mismatch);
+#ifdef CONFIG_TASN1
+    migration_test_add("/migration/multifd/tcp/tls/x509/default-host",
+                       test_multifd_tcp_tls_x509_default_host);
+    migration_test_add("/migration/multifd/tcp/tls/x509/override-host",
+                       test_multifd_tcp_tls_x509_override_host);
+    migration_test_add("/migration/multifd/tcp/tls/x509/mismatch-host",
+                       test_multifd_tcp_tls_x509_mismatch_host);
+    migration_test_add("/migration/multifd/tcp/tls/x509/allow-anon-client",
+                       test_multifd_tcp_tls_x509_allow_anon_client);
+    migration_test_add("/migration/multifd/tcp/tls/x509/reject-anon-client",
+                       test_multifd_tcp_tls_x509_reject_anon_client);
+#endif /* CONFIG_TASN1 */
+}
-- 
2.35.3


