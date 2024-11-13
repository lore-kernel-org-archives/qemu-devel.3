Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB9CD637AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 19:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJK9-0006IR-Gi; Wed, 13 Nov 2024 14:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJK6-0006Hn-Pp
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:46:42 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJK4-00037f-Nt
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:46:42 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E42E221111;
 Wed, 13 Nov 2024 19:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oiFueBwtx8xfByRoHRu0R+4l4L3oGwJCvL6rNus857w=;
 b=avHvESS+Tpy6DKJkAIFJtNcVG9iMOaTr9U6B50Hfo2Q9gr3fvt32xR1CqmzygxcmKmjSHo
 xVj6XT/2lNlKSg83LvXKN/Kvg5MkJs0Rra0zji+CTt/Jl9sxFhL/GVz7WY7HuLyvx64kEA
 werHZKog90vssL+A96zr6xqxlAoZsiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527197;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oiFueBwtx8xfByRoHRu0R+4l4L3oGwJCvL6rNus857w=;
 b=xfqGGGSDvyAobhTRccZhladxvGW6NnoJUGfvXbgMyL1p1j//SnAKzkHJPxA+0pgpxpfcB2
 Ggdrt0qXezTeIMBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MHnML9Ns;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ZiZMM/qx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oiFueBwtx8xfByRoHRu0R+4l4L3oGwJCvL6rNus857w=;
 b=MHnML9NsJPcSdqTYXQtFi6pN9alBlOKT2NjNeBanLQS9vVNhMDHcWQjtq5eCZ2nCIymEdi
 DjzvgMYBxTBUkS6XNyNT/MVpllmRtA/s32Sv3pCsEJIHruzbfyUWQ5W5f7uHqFcbd48jFI
 ydRWL3YPNsnBqb6fE6xxrC9eFFKpDdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527196;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oiFueBwtx8xfByRoHRu0R+4l4L3oGwJCvL6rNus857w=;
 b=ZiZMM/qxWhu1BW/WefypEzTMmRzuueeBSb1N2l++ufsYnNnm0RxQcG/a4FA2MB+3voqMPK
 Znf1Al5EBGQppMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B3B813301;
 Wed, 13 Nov 2024 19:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KFGfABsCNWfLcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 19:46:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 01/22] tests/qtest/migration: Fix indentations
Date: Wed, 13 Nov 2024 16:46:09 -0300
Message-Id: <20241113194630.3385-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241113194630.3385-1-farosas@suse.de>
References: <20241113194630.3385-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E42E221111
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Select all the code and hit tab. I'll be moving functions around quite
a lot in the next patches, so make sure all indentation is correct
now.

Add parentheses around some expressions to preserve readability.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c |  4 +--
 tests/qtest/migration-test.c    | 59 ++++++++++++++++++---------------
 2 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 0025933883..3f8ba7fa8e 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -140,8 +140,8 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
         if (qdict_haskey(addrdict, "port") &&
             qdict_haskey(addr, "port") &&
             (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
-                addr_port = qdict_get_str(addr, "port");
-                qdict_put_str(addrdict, "port", addr_port);
+            addr_port = qdict_get_str(addr, "port");
+            qdict_put_str(addrdict, "port", addr_port);
         }
     }
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e6a2803e71..74d3000198 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -113,8 +113,8 @@ static bool ufd_version_check(void)
     }
     uffd_feature_thread_id = api_struct.features & UFFD_FEATURE_THREAD_ID;
 
-    ioctl_mask = 1ULL << _UFFDIO_REGISTER |
-                 1ULL << _UFFDIO_UNREGISTER;
+    ioctl_mask = (1ULL << _UFFDIO_REGISTER |
+                  1ULL << _UFFDIO_UNREGISTER);
     if ((api_struct.ioctls & ioctl_mask) != ioctl_mask) {
         g_test_message("Skipping test: Missing userfault feature");
         return false;
@@ -423,7 +423,7 @@ static void migrate_set_parameter_str(QTestState *who, const char *parameter,
 }
 
 static long long migrate_get_parameter_bool(QTestState *who,
-                                           const char *parameter)
+                                            const char *parameter)
 {
     QDict *rsp;
     int result;
@@ -436,7 +436,7 @@ static long long migrate_get_parameter_bool(QTestState *who,
 }
 
 static void migrate_check_parameter_bool(QTestState *who, const char *parameter,
-                                        int value)
+                                         int value)
 {
     int result;
 
@@ -445,7 +445,7 @@ static void migrate_check_parameter_bool(QTestState *who, const char *parameter,
 }
 
 static void migrate_set_parameter_bool(QTestState *who, const char *parameter,
-                                      int value)
+                                       int value)
 {
     qtest_qmp_assert_success(who,
                              "{ 'execute': 'migrate-set-parameters',"
@@ -1384,8 +1384,10 @@ static void test_postcopy_preempt_tls_psk(void)
 static void wait_for_postcopy_status(QTestState *one, const char *status)
 {
     wait_for_migration_status(one, status,
-                              (const char * []) { "failed", "active",
-                                                  "completed", NULL });
+                              (const char * []) {
+                                  "failed", "active",
+                                  "completed", NULL
+                              });
 }
 
 static void postcopy_recover_fail(QTestState *from, QTestState *to,
@@ -2575,15 +2577,17 @@ static void test_migrate_fd_finish_hook(QTestState *from,
     /* Test closing fds */
     /* We assume, that QEMU removes named fd from its list,
      * so this should fail */
-    rsp = qtest_qmp(from, "{ 'execute': 'closefd',"
-                          "  'arguments': { 'fdname': 'fd-mig' }}");
+    rsp = qtest_qmp(from,
+                    "{ 'execute': 'closefd',"
+                    "  'arguments': { 'fdname': 'fd-mig' }}");
     g_assert_true(qdict_haskey(rsp, "error"));
     error_desc = qdict_get_str(qdict_get_qdict(rsp, "error"), "desc");
     g_assert_cmpstr(error_desc, ==, "File descriptor named 'fd-mig' not found");
     qobject_unref(rsp);
 
-    rsp = qtest_qmp(to, "{ 'execute': 'closefd',"
-                        "  'arguments': { 'fdname': 'fd-mig' }}");
+    rsp = qtest_qmp(to,
+                    "{ 'execute': 'closefd',"
+                    "  'arguments': { 'fdname': 'fd-mig' }}");
     g_assert_true(qdict_haskey(rsp, "error"));
     error_desc = qdict_get_str(qdict_get_qdict(rsp, "error"), "desc");
     g_assert_cmpstr(error_desc, ==, "File descriptor named 'fd-mig' not found");
@@ -2741,11 +2745,11 @@ static void test_validate_uri_channels_both_set(void)
         },
         .listen_uri = "defer",
         .connect_uri = "tcp:127.0.0.1:0",
-        .connect_channels = "[ { 'channel-type': 'main',"
-                            "    'addr': { 'transport': 'socket',"
-                            "              'type': 'inet',"
-                            "              'host': '127.0.0.1',"
-                            "              'port': '0' } } ]",
+        .connect_channels = ("[ { ""'channel-type': 'main',"
+                             "    'addr': { 'transport': 'socket',"
+                             "              'type': 'inet',"
+                             "              'host': '127.0.0.1',"
+                             "              'port': '0' } } ]"),
     };
 
     do_test_validate_uri_channel(&args);
@@ -2967,7 +2971,7 @@ test_migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
 #ifdef CONFIG_QPL
 static void *
 test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
-                                            QTestState *to)
+                                           QTestState *to)
 {
     return test_migrate_precopy_tcp_multifd_start_common(from, to, "qpl");
 }
@@ -3032,11 +3036,11 @@ static void test_multifd_tcp_channels_none(void)
         .listen_uri = "defer",
         .start_hook = test_migrate_precopy_tcp_multifd_start,
         .live = true,
-        .connect_channels = "[ { 'channel-type': 'main',"
-                            "    'addr': { 'transport': 'socket',"
-                            "              'type': 'inet',"
-                            "              'host': '127.0.0.1',"
-                            "              'port': '0' } } ]",
+        .connect_channels = ("[ { 'channel-type': 'main',"
+                             "    'addr': { 'transport': 'socket',"
+                             "              'type': 'inet',"
+                             "              'host': '127.0.0.1',"
+                             "              'port': '0' } } ]"),
     };
     test_precopy_common(&args);
 }
@@ -3668,7 +3672,8 @@ static void test_migrate_dirty_limit(void)
     throttle_us_per_full = 0;
     while (throttle_us_per_full == 0) {
         throttle_us_per_full =
-        read_migrate_property_int(from, "dirty-limit-throttle-time-per-round");
+            read_migrate_property_int(from,
+                                      "dirty-limit-throttle-time-per-round");
         usleep(100);
         g_assert_false(src_state.stop_seen);
     }
@@ -3680,7 +3685,8 @@ static void test_migrate_dirty_limit(void)
     /* Check if dirty limit throttle switched off, set timeout 1ms */
     do {
         throttle_us_per_full =
-        read_migrate_property_int(from, "dirty-limit-throttle-time-per-round");
+            read_migrate_property_int(from,
+                                      "dirty-limit-throttle-time-per-round");
         usleep(100);
         g_assert_false(src_state.stop_seen);
     } while (throttle_us_per_full != 0 && --max_try_count);
@@ -3709,7 +3715,8 @@ static void test_migrate_dirty_limit(void)
     throttle_us_per_full = 0;
     while (throttle_us_per_full == 0) {
         throttle_us_per_full =
-        read_migrate_property_int(from, "dirty-limit-throttle-time-per-round");
+            read_migrate_property_int(from,
+                                      "dirty-limit-throttle-time-per-round");
         usleep(100);
         g_assert_false(src_state.stop_seen);
     }
@@ -3989,7 +3996,7 @@ int main(int argc, char **argv)
 #endif
 #ifdef CONFIG_QATZIP
     migration_test_add("/migration/multifd/tcp/plain/qatzip",
-                test_multifd_tcp_qatzip);
+                       test_multifd_tcp_qatzip);
 #endif
 #ifdef CONFIG_QPL
     migration_test_add("/migration/multifd/tcp/plain/qpl",
-- 
2.35.3


