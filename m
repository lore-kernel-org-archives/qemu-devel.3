Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDAED5B86F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 22:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVGet-00073e-Rw; Mon, 15 Dec 2025 17:03:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGer-0006lJ-Bv
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:09 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vVGeo-00031K-2A
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 17:03:08 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8314F5BDC4;
 Mon, 15 Dec 2025 22:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5svvfSVfKlhQUUzj4Zr2+mOzyTqlhMOmC/BTiB93Qb0=;
 b=zQC+zcmmMCcK409q4u28jOFYszj4bHYJBu93/MqcgvUb8mJw37vOhF+iSRgOMWEoSUXPMo
 Toi3evAey8/id0X8Qgw3AzxGwyJf8EsHPd2GMsl3DY3bpCY4cCXLFPmyggnFDzyk7cpqYd
 wr77l0OPMNfd4GYGGi/oU3FLLvRlc4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836156;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5svvfSVfKlhQUUzj4Zr2+mOzyTqlhMOmC/BTiB93Qb0=;
 b=g8tROh46rMfNPwLhiZz24lb3ziD9e+FA5F429LOORDWwWYSRL4faqJ0zjQj7s12A4llFzp
 n0aWiPbixMkuosAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zQC+zcmm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g8tROh46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765836156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5svvfSVfKlhQUUzj4Zr2+mOzyTqlhMOmC/BTiB93Qb0=;
 b=zQC+zcmmMCcK409q4u28jOFYszj4bHYJBu93/MqcgvUb8mJw37vOhF+iSRgOMWEoSUXPMo
 Toi3evAey8/id0X8Qgw3AzxGwyJf8EsHPd2GMsl3DY3bpCY4cCXLFPmyggnFDzyk7cpqYd
 wr77l0OPMNfd4GYGGi/oU3FLLvRlc4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765836156;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5svvfSVfKlhQUUzj4Zr2+mOzyTqlhMOmC/BTiB93Qb0=;
 b=g8tROh46rMfNPwLhiZz24lb3ziD9e+FA5F429LOORDWwWYSRL4faqJ0zjQj7s12A4llFzp
 n0aWiPbixMkuosAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80FA33EA63;
 Mon, 15 Dec 2025 22:02:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GEHNEHqFQGlrMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 15 Dec 2025 22:02:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 42/51] tests/qtest/migration: Remove multifd compression
 hook
Date: Mon, 15 Dec 2025 19:00:28 -0300
Message-ID: <20251215220041.12657-43-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215220041.12657-1-farosas@suse.de>
References: <20251215220041.12657-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLi3368pnyb3ujpcs6u1hud8b3)];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8314F5BDC4
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

Remove the migrate_hook_start_precopy_tcp_multifd_common hook and open
code its contents in the callers. This will simplify moving the
migrate_set_parameters calls in the following patches.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/compression-tests.c | 25 ++++++++++++++++----
 tests/qtest/migration/framework.c         | 10 --------
 tests/qtest/migration/framework.h         |  4 ----
 tests/qtest/migration/precopy-tests.c     |  9 +++++---
 tests/qtest/migration/tls-tests.c         | 28 +++++++++++++++++------
 5 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index bed39dece0..be60981f66 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -28,7 +28,10 @@ migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
     migrate_set_parameter_int(from, "multifd-zstd-level", 2);
     migrate_set_parameter_int(to, "multifd-zstd-level", 2);
 
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zstd");
+    migrate_set_parameter_str(from, "multifd-compression", "zstd");
+    migrate_set_parameter_str(to, "multifd-compression", "zstd");
+
+    return NULL;
 }
 
 static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
@@ -63,7 +66,10 @@ migrate_hook_start_precopy_tcp_multifd_qatzip(QTestState *from,
     migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
     migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
 
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "qatzip");
+    migrate_set_parameter_str(from, "multifd-compression", "qatzip");
+    migrate_set_parameter_str(to, "multifd-compression", "qatzip");
+
+    return NULL;
 }
 
 static void test_multifd_tcp_qatzip(char *name, MigrateCommon *args)
@@ -83,7 +89,10 @@ static void *
 migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *from,
                                            QTestState *to)
 {
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "qpl");
+    migrate_set_parameter_str(from, "multifd-compression", "qpl");
+    migrate_set_parameter_str(to, "multifd-compression", "qpl");
+
+    return NULL;
 }
 
 static void test_multifd_tcp_qpl(char *name, MigrateCommon *args)
@@ -103,7 +112,10 @@ static void *
 migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
                                             QTestState *to)
 {
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "uadk");
+    migrate_set_parameter_str(from, "multifd-compression", "uadk");
+    migrate_set_parameter_str(to, "multifd-compression", "uadk");
+
+    return NULL;
 }
 
 static void test_multifd_tcp_uadk(char *name, MigrateCommon *args)
@@ -156,7 +168,10 @@ migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
     migrate_set_parameter_int(from, "multifd-zlib-level", 2);
     migrate_set_parameter_int(to, "multifd-zlib-level", 2);
 
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zlib");
+    migrate_set_parameter_str(from, "multifd-compression", "zlib");
+    migrate_set_parameter_str(to, "multifd-compression", "zlib");
+
+    return NULL;
 }
 
 static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index b9bbdca6a9..ecfeee570e 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -1115,16 +1115,6 @@ finish:
     migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
 }
 
-void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
-                                                    QTestState *to,
-                                                    const char *method)
-{
-    migrate_set_parameter_str(from, "multifd-compression", method);
-    migrate_set_parameter_str(to, "multifd-compression", method);
-
-    return NULL;
-}
-
 QTestMigrationState *get_src(void)
 {
     return &src_state;
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 2584599f14..239fc54f82 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -272,10 +272,6 @@ void test_postcopy_common(MigrateCommon *args);
 void test_postcopy_recovery_common(MigrateCommon *args);
 int test_precopy_common(MigrateCommon *args);
 void test_file_common(MigrateCommon *args, bool stop_src);
-void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
-                                                    QTestState *to,
-                                                    const char *method);
-
 typedef struct QTestMigrationState QTestMigrationState;
 QTestMigrationState *get_src(void);
 QTestMigrationState *get_dst(void);
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 0b0f04bf19..01151301ce 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -452,14 +452,17 @@ static void *
 migrate_hook_start_precopy_tcp_multifd(QTestState *from,
                                        QTestState *to)
 {
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    migrate_set_parameter_str(from, "multifd-compression", "none");
+    migrate_set_parameter_str(to, "multifd-compression", "none");
+
+    return NULL;
 }
 
 static void *
 migrate_hook_start_precopy_tcp_multifd_zero_page_legacy(QTestState *from,
                                                         QTestState *to)
 {
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    migrate_hook_start_precopy_tcp_multifd(from, to);
     migrate_set_parameter_str(from, "zero-page-detection", "legacy");
     return NULL;
 }
@@ -468,7 +471,7 @@ static void *
 migrate_hook_start_precopy_tcp_multifd_no_zero_page(QTestState *from,
                                                     QTestState *to)
 {
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    migrate_hook_start_precopy_tcp_multifd(from, to);
     migrate_set_parameter_str(from, "zero-page-detection", "none");
     return NULL;
 }
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index aade57f7de..5f561bc602 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -616,7 +616,9 @@ static void *
 migrate_hook_start_multifd_tcp_tls_psk_match(QTestState *from,
                                              QTestState *to)
 {
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    migrate_set_parameter_str(from, "multifd-compression", "none");
+    migrate_set_parameter_str(to, "multifd-compression", "none");
+
     return migrate_hook_start_tls_psk_common(from, to, &tls_psk_match);
 }
 
@@ -624,7 +626,9 @@ static void *
 migrate_hook_start_multifd_tcp_tls_psk_mismatch(QTestState *from,
                                                 QTestState *to)
 {
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    migrate_set_parameter_str(from, "multifd-compression", "none");
+    migrate_set_parameter_str(to, "multifd-compression", "none");
+
     return migrate_hook_start_tls_psk_common(from, to, &tls_psk_mismatch);
 }
 
@@ -633,7 +637,9 @@ static void *
 migrate_hook_start_multifd_tls_x509_default_host(QTestState *from,
                                                  QTestState *to)
 {
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    migrate_set_parameter_str(from, "multifd-compression", "none");
+    migrate_set_parameter_str(to, "multifd-compression", "none");
+
     return migrate_hook_start_tls_x509_common(from, to, &tls_x509_default_host);
 }
 
@@ -641,7 +647,9 @@ static void *
 migrate_hook_start_multifd_tls_x509_override_host(QTestState *from,
                                                   QTestState *to)
 {
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    migrate_set_parameter_str(from, "multifd-compression", "none");
+    migrate_set_parameter_str(to, "multifd-compression", "none");
+
     return migrate_hook_start_tls_x509_common(from, to,
                                               &tls_x509_override_host);
 }
@@ -650,7 +658,9 @@ static void *
 migrate_hook_start_multifd_tls_x509_mismatch_host(QTestState *from,
                                                   QTestState *to)
 {
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    migrate_set_parameter_str(from, "multifd-compression", "none");
+    migrate_set_parameter_str(to, "multifd-compression", "none");
+
     return migrate_hook_start_tls_x509_common(from, to,
                                               &tls_x509_mismatch_host);
 }
@@ -659,7 +669,9 @@ static void *
 migrate_hook_start_multifd_tls_x509_allow_anon_client(QTestState *from,
                                                       QTestState *to)
 {
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    migrate_set_parameter_str(from, "multifd-compression", "none");
+    migrate_set_parameter_str(to, "multifd-compression", "none");
+
     return migrate_hook_start_tls_x509_common(from, to,
                                               &tls_x509_allow_anon_client);
 }
@@ -668,7 +680,9 @@ static void *
 migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
                                                        QTestState *to)
 {
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    migrate_set_parameter_str(from, "multifd-compression", "none");
+    migrate_set_parameter_str(to, "multifd-compression", "none");
+
     return migrate_hook_start_tls_x509_common(from, to,
                                               &tls_x509_reject_anon_client);
 }
-- 
2.51.0


