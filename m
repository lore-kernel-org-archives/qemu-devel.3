Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81235D374A0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1RYC-0005QK-B2; Thu, 17 Oct 2024 10:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1RY9-0005Nw-RU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:32:25 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1RY7-0003tC-CN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:32:25 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E196E21D8B;
 Thu, 17 Oct 2024 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729175542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BqzdKfAFeutz4QGQaOzHSpfxNGfoWlqPyFUzIiF3vD0=;
 b=pTefrODdzZyF59ar4/YxiHcmmSKempb4mkX+rZri2+u8tnXi/b67PeL6OJvLxoFaklyMvo
 Lpo+7QaE+K2adu2/AWevRrYqHNaPM/0LxhdWBGiZxqLLuXaxzYeSo+AJYW1Nrpxf1wxOkU
 Y6W7SLbu1PRazwQd9ZqRaFGQpueUlkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729175542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BqzdKfAFeutz4QGQaOzHSpfxNGfoWlqPyFUzIiF3vD0=;
 b=Mbc3i7ncp+NgdLHRuBmWSQsKfNNK313exupLeYkxDHFBF5ttElYifrFjzmjYe/M7SQ7j98
 FLwNXlj1NS6cvrBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Oq296ZZu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Nz7XyTo0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729175541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BqzdKfAFeutz4QGQaOzHSpfxNGfoWlqPyFUzIiF3vD0=;
 b=Oq296ZZu1hgO6ya7zZOo1qUERR+3X6eFGOu2ex6etikwmqBgin1ULJ/3qVQpd8r7axYRxs
 y955TEPMvdZF2nWI8YYcJCY1ICXw7XYjJdNHqeLgbUdV+7DiycbY8IC0wdWi1gaIN11Njy
 PrIksbhTbFJYLisi1rrZajEBRRuXDZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729175541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BqzdKfAFeutz4QGQaOzHSpfxNGfoWlqPyFUzIiF3vD0=;
 b=Nz7XyTo04I53jiCCr5KrBBVwOno4Hrietiqgx3X5l3OgNgh05kRUewqEKkBWGxek75Wdu9
 Rc0OF0pSajKYCeCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB21D13A42;
 Thu, 17 Oct 2024 14:32:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AAgPIPQfEWcDKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Oct 2024 14:32:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 3/4] tests/qtest/migration: Move tests into g_test_slow()
Date: Thu, 17 Oct 2024 11:32:10 -0300
Message-Id: <20241017143211.17771-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241017143211.17771-1-farosas@suse.de>
References: <20241017143211.17771-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E196E21D8B
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

Move most of the tests under g_test_slow() and add a
migration_test_add_quick() helper to mark a test as "quick".

quick - runs with:
  make check
  make check-migration-quick
  make check-migration
  make SPEED=slow check

slow - runs with:
  make check-migration
  make SPEED=slow check

Also add some words on the rationale, which is to keep the bulk of the
migration-test out of make check.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c |  9 +++++
 tests/qtest/migration-helpers.h | 16 ++++++++
 tests/qtest/migration-test.c    | 67 ++++++++++++++++-----------------
 3 files changed, 58 insertions(+), 34 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 0025933883..b3a873630f 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -456,6 +456,15 @@ static void migration_test_wrapper(const void *data)
 }
 
 void migration_test_add(const char *path, void (*fn)(void))
+{
+    if (!g_test_slow()) {
+        return;
+    }
+
+    migration_test_add_quick(path, fn);
+}
+
+void migration_test_add_quick(const char *path, void (*fn)(void))
 {
     MigrationTest *test = g_new0(MigrationTest, 1);
 
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 72dba369fb..59daf5ea62 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -62,7 +62,23 @@ static inline bool probe_o_direct_support(const char *tmpfs)
     return false;
 }
 #endif
+
+/*
+ * Tests that would only break due to core migration changes should be
+ * added with migration_test_add(). Those are considered 'slow' by
+ * default and run during make check-migration, or when '-m slow' is
+ * added on the cmdline.
+ *
+ * Tests that are quick and simple, as well as those that are
+ * succeptible to changes outside of migration/ (e.g. depend on TLS,
+ * qio_channel, etc), should be added with
+ * migration_test_add_quick(). Those are considered 'quick' and run as
+ * part of make check (i.e. execute in CI and with every developer's
+ * invocation of make check). Avoid adding too much time to those.
+ */
 void migration_test_add(const char *path, void (*fn)(void));
+void migration_test_add_quick(const char *path, void (*fn)(void));
+
 void migration_event_wait(QTestState *s, const char *target);
 
 #endif /* MIGRATION_HELPERS_H */
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 95e45b5029..4b021984c4 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -43,6 +43,7 @@ static bool uffd_feature_thread_id;
 static QTestMigrationState src_state;
 static QTestMigrationState dst_state;
 
+
 /*
  * An initial 3 MB offset is used as that corresponds
  * to ~1 sec of data transfer with our bandwidth setting.
@@ -3785,20 +3786,20 @@ int main(int argc, char **argv)
 #endif
 
     if (is_x86) {
-        migration_test_add("/migration/precopy/unix/suspend/live",
-                           test_precopy_unix_suspend_live);
-        migration_test_add("/migration/precopy/unix/suspend/notlive",
-                           test_precopy_unix_suspend_notlive);
+        migration_test_add_quick("/migration/precopy/unix/suspend/live",
+                                 test_precopy_unix_suspend_live);
+        migration_test_add_quick("/migration/precopy/unix/suspend/notlive",
+                                 test_precopy_unix_suspend_notlive);
     }
 
     if (has_uffd) {
-        migration_test_add("/migration/postcopy/plain", test_postcopy);
+        migration_test_add_quick("/migration/postcopy/plain", test_postcopy);
         migration_test_add("/migration/postcopy/recovery/plain",
                            test_postcopy_recovery);
-        migration_test_add("/migration/postcopy/preempt/plain",
-                           test_postcopy_preempt);
-        migration_test_add("/migration/postcopy/preempt/recovery/plain",
-                           test_postcopy_preempt_recovery);
+        migration_test_add_quick("/migration/postcopy/preempt/plain",
+                                 test_postcopy_preempt);
+        migration_test_add_quick("/migration/postcopy/preempt/recovery/plain",
+                                 test_postcopy_preempt_recovery);
         migration_test_add("/migration/postcopy/recovery/double-failures/handshake",
                            test_postcopy_recovery_fail_handshake);
         migration_test_add("/migration/postcopy/recovery/double-failures/reconnect",
@@ -3809,12 +3810,12 @@ int main(int argc, char **argv)
         }
     }
 
-    migration_test_add("/migration/precopy/unix/plain",
-                       test_precopy_unix_plain);
-    if (g_test_slow()) {
-        migration_test_add("/migration/precopy/unix/xbzrle",
-                           test_precopy_unix_xbzrle);
-    }
+    migration_test_add_quick("/migration/precopy/unix/plain",
+                             test_precopy_unix_plain);
+
+    migration_test_add("/migration/precopy/unix/xbzrle",
+                       test_precopy_unix_xbzrle);
+
     migration_test_add("/migration/precopy/file",
                        test_precopy_file);
     migration_test_add("/migration/precopy/file/offset",
@@ -3881,14 +3882,14 @@ int main(int argc, char **argv)
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-    migration_test_add("/migration/precopy/tcp/plain", test_precopy_tcp_plain);
+    migration_test_add_quick("/migration/precopy/tcp/plain", test_precopy_tcp_plain);
 
     migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
                        test_precopy_tcp_switchover_ack);
 
 #ifdef CONFIG_GNUTLS
-    migration_test_add("/migration/precopy/tcp/tls/psk/match",
-                       test_precopy_tcp_tls_psk_match);
+    migration_test_add_quick("/migration/precopy/tcp/tls/psk/match",
+                             test_precopy_tcp_tls_psk_match);
     migration_test_add("/migration/precopy/tcp/tls/psk/mismatch",
                        test_precopy_tcp_tls_psk_mismatch);
 #ifdef CONFIG_TASN1
@@ -3930,25 +3931,23 @@ int main(int argc, char **argv)
     /*
      * See explanation why this test is slow on function definition
      */
-    if (g_test_slow()) {
-        migration_test_add("/migration/auto_converge",
-                           test_migrate_auto_converge);
-        if (g_str_equal(arch, "x86_64") &&
-            has_kvm && kvm_dirty_ring_supported()) {
-            migration_test_add("/migration/dirty_limit",
-                               test_migrate_dirty_limit);
-        }
+    migration_test_add("/migration/auto_converge",
+                       test_migrate_auto_converge);
+    if (g_str_equal(arch, "x86_64") &&
+        has_kvm && kvm_dirty_ring_supported()) {
+        migration_test_add("/migration/dirty_limit",
+                           test_migrate_dirty_limit);
     }
-    migration_test_add("/migration/multifd/tcp/uri/plain/none",
-                       test_multifd_tcp_uri_none);
+    migration_test_add_quick("/migration/multifd/tcp/uri/plain/none",
+                             test_multifd_tcp_uri_none);
     migration_test_add("/migration/multifd/tcp/channels/plain/none",
                        test_multifd_tcp_channels_none);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/legacy",
                        test_multifd_tcp_zero_page_legacy);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
                        test_multifd_tcp_no_zero_page);
-    migration_test_add("/migration/multifd/tcp/plain/cancel",
-                       test_multifd_tcp_cancel);
+    migration_test_add_quick("/migration/multifd/tcp/plain/cancel",
+                             test_multifd_tcp_cancel);
     migration_test_add("/migration/multifd/tcp/plain/zlib",
                        test_multifd_tcp_zlib);
 #ifdef CONFIG_ZSTD
@@ -3957,7 +3956,7 @@ int main(int argc, char **argv)
 #endif
 #ifdef CONFIG_QATZIP
     migration_test_add("/migration/multifd/tcp/plain/qatzip",
-                test_multifd_tcp_qatzip);
+                       test_multifd_tcp_qatzip);
 #endif
 #ifdef CONFIG_QPL
     migration_test_add("/migration/multifd/tcp/plain/qpl",
@@ -3987,9 +3986,9 @@ int main(int argc, char **argv)
 #endif /* CONFIG_GNUTLS */
 
     if (g_str_equal(arch, "x86_64") && has_kvm && kvm_dirty_ring_supported()) {
-        migration_test_add("/migration/dirty_ring",
-                           test_precopy_unix_dirty_ring);
-        if (qtest_has_machine("pc") && g_test_slow()) {
+        migration_test_add_quick("/migration/dirty_ring",
+                                 test_precopy_unix_dirty_ring);
+        if (qtest_has_machine("pc")) {
             migration_test_add("/migration/vcpu_dirty_limit",
                                test_vcpu_dirty_limit);
         }
-- 
2.35.3


