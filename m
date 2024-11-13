Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B20AD637AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 19:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJKt-0006xw-5W; Wed, 13 Nov 2024 14:47:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKq-0006o1-BT
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:28 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKo-0003DA-IU
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:47:28 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 434A121109;
 Wed, 13 Nov 2024 19:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9wkFLa7eKx1hbkd0zud/vM2BmY/sqc9Oj0oHoBtLTw=;
 b=sLCcXdou6vsvsbi2fPrnFThxTTBBrUSRjDtxJ5d3loNpN/2lwR++lOrUx+oc0/irX7tiIT
 qJMWIg//yLaP2o81/fkdaCvpfVb4oKtFX1oWDSNs0xgVJbGBjk5bgeqlGpayCdz5uanMsN
 5OVugPckR8BG2d1MOLZ9pF2xPFn2Cg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9wkFLa7eKx1hbkd0zud/vM2BmY/sqc9Oj0oHoBtLTw=;
 b=lO3EzSd1VU7x61kRPNev8Zf12eRLZYNVdQP7ejFivgAGGNT7arxQgptDSA10vqzuHakD9H
 iv0yeImB8uZFKAAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sLCcXdou;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lO3EzSd1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9wkFLa7eKx1hbkd0zud/vM2BmY/sqc9Oj0oHoBtLTw=;
 b=sLCcXdou6vsvsbi2fPrnFThxTTBBrUSRjDtxJ5d3loNpN/2lwR++lOrUx+oc0/irX7tiIT
 qJMWIg//yLaP2o81/fkdaCvpfVb4oKtFX1oWDSNs0xgVJbGBjk5bgeqlGpayCdz5uanMsN
 5OVugPckR8BG2d1MOLZ9pF2xPFn2Cg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9wkFLa7eKx1hbkd0zud/vM2BmY/sqc9Oj0oHoBtLTw=;
 b=lO3EzSd1VU7x61kRPNev8Zf12eRLZYNVdQP7ejFivgAGGNT7arxQgptDSA10vqzuHakD9H
 iv0yeImB8uZFKAAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2745F13301;
 Wed, 13 Nov 2024 19:47:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kBtjN0oCNWfLcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 19:47:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 20/22] tests/qtest/migration: Pick smoke tests
Date: Wed, 13 Nov 2024 16:46:28 -0300
Message-Id: <20241113194630.3385-21-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241113194630.3385-1-farosas@suse.de>
References: <20241113194630.3385-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 434A121109
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
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RL6tyf6sue6knz55rs3us8rsc3)];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Choose a few tests per group and move them from the full set to the
smoke set.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/compression-tests.c |  7 +++----
 tests/qtest/migration/cpr-tests.c         |  3 ++-
 tests/qtest/migration/misc-tests.c        | 11 +++++------
 tests/qtest/migration/postcopy-tests.c    | 15 ++++++++-------
 tests/qtest/migration/precopy-tests.c     | 19 +++++++++----------
 tests/qtest/migration/tls-tests.c         |  7 ++++---
 6 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index b48dc87239..353b7ccbdd 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -208,7 +208,9 @@ static void test_multifd_tcp_zlib(void)
 void migration_test_add_compression_smoke(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
-    /* TODO: add smoke tests */
+
+    migration_test_add("/migration/multifd/tcp/plain/zlib",
+                       test_multifd_tcp_zlib);
 }
 
 void migration_test_add_compression(MigrationTestEnv *env)
@@ -239,7 +241,4 @@ void migration_test_add_compression(MigrationTestEnv *env)
         migration_test_add("/migration/precopy/unix/xbzrle",
                            test_precopy_unix_xbzrle);
     }
-
-    migration_test_add("/migration/multifd/tcp/plain/zlib",
-                       test_multifd_tcp_zlib);
 }
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 4fe6eefe86..c5cad2a20c 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -47,7 +47,8 @@ static void test_mode_reboot(void)
 void migration_test_add_cpr_smoke(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
-    /* TODO: add smoke tests */
+
+    /* none for now */
 }
 
 void migration_test_add_cpr(MigrationTestEnv *env)
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 480fbda1c9..ee737c3942 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -253,12 +253,6 @@ static void test_validate_uri_channels_none_set(void)
 void migration_test_add_misc_smoke(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
-    /* TODO: add smoke tests */
-}
-
-void migration_test_add_misc(MigrationTestEnv *env)
-{
-    migration_test_add_misc_smoke(env);
 
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
@@ -279,3 +273,8 @@ void migration_test_add_misc(MigrationTestEnv *env)
     migration_test_add("/migration/validate_uri/channels/none_set",
                        test_validate_uri_channels_none_set);
 }
+
+void migration_test_add_misc(MigrationTestEnv *env)
+{
+    migration_test_add_misc_smoke(env);
+}
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 90d2d0820c..36ef05caa0 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -81,19 +81,20 @@ static void test_postcopy_preempt_recovery(void)
 
 void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
 {
-    /* TODO: add smoke tests */
-}
-
-void migration_test_add_postcopy(MigrationTestEnv *env)
-{
-    migration_test_add_postcopy_smoke(env);
-
     if (env->has_uffd) {
         migration_test_add("/migration/postcopy/plain", test_postcopy);
         migration_test_add("/migration/postcopy/recovery/plain",
                            test_postcopy_recovery);
         migration_test_add("/migration/postcopy/preempt/plain",
                            test_postcopy_preempt);
+    }
+}
+
+void migration_test_add_postcopy(MigrationTestEnv *env)
+{
+    migration_test_add_postcopy_smoke(env);
+
+    if (env->has_uffd) {
         migration_test_add("/migration/postcopy/preempt/recovery/plain",
                            test_postcopy_preempt_recovery);
 
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 393c7e226a..4a5e7f41a9 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -949,12 +949,6 @@ static void test_dirty_limit(void)
 void migration_test_add_precopy_smoke(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
-    /* TODO: add smoke tests */
-}
-
-void migration_test_add_precopy(MigrationTestEnv *env)
-{
-    migration_test_add_precopy_smoke(env);
 
     if (env->is_x86) {
         migration_test_add("/migration/precopy/unix/suspend/live",
@@ -967,6 +961,15 @@ void migration_test_add_precopy(MigrationTestEnv *env)
                        test_precopy_unix_plain);
 
     migration_test_add("/migration/precopy/tcp/plain", test_precopy_tcp_plain);
+    migration_test_add("/migration/multifd/tcp/uri/plain/none",
+                       test_multifd_tcp_uri_none);
+    migration_test_add("/migration/multifd/tcp/plain/cancel",
+                       test_multifd_tcp_cancel);
+}
+
+void migration_test_add_precopy(MigrationTestEnv *env)
+{
+    migration_test_add_precopy_smoke(env);
 
     migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
                        test_precopy_tcp_switchover_ack);
@@ -990,16 +993,12 @@ void migration_test_add_precopy(MigrationTestEnv *env)
                                test_dirty_limit);
         }
     }
-    migration_test_add("/migration/multifd/tcp/uri/plain/none",
-                       test_multifd_tcp_uri_none);
     migration_test_add("/migration/multifd/tcp/channels/plain/none",
                        test_multifd_tcp_channels_none);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/legacy",
                        test_multifd_tcp_zero_page_legacy);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
                        test_multifd_tcp_no_zero_page);
-    migration_test_add("/migration/multifd/tcp/plain/cancel",
-                       test_multifd_tcp_cancel);
     if (g_str_equal(env->arch, "x86_64")
         && env->has_kvm && env->has_dirty_ring) {
 
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 264b54f352..37b5b64692 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -725,12 +725,15 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
 void migration_test_add_tls_smoke(MigrationTestEnv *env)
 {
     tmpfs = env->tmpfs;
-    /* TODO: add smoke tests */
+
+    migration_test_add("/migration/precopy/tcp/tls/psk/match",
+                       test_precopy_tcp_tls_psk_match);
 }
 
 void migration_test_add_tls(MigrationTestEnv *env)
 {
     migration_test_add_tls_smoke(env);
+
     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);
 
@@ -756,8 +759,6 @@ void migration_test_add_tls(MigrationTestEnv *env)
                        test_precopy_unix_tls_x509_override_host);
 #endif /* CONFIG_TASN1 */
 
-    migration_test_add("/migration/precopy/tcp/tls/psk/match",
-                       test_precopy_tcp_tls_psk_match);
     migration_test_add("/migration/precopy/tcp/tls/psk/mismatch",
                        test_precopy_tcp_tls_psk_mismatch);
 #ifdef CONFIG_TASN1
-- 
2.35.3


