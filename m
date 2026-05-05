Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575B9CD343B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 16:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKIMG-0008WS-G6; Tue, 05 May 2026 12:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKILW-00087R-0H
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:10:06 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wKILT-0000Fs-1x
 for qemu-devel@nongnu.org; Tue, 05 May 2026 12:10:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A539D6B765;
 Tue,  5 May 2026 16:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvQCMVyCnjQXWQYttKYnop1DT8sWT0Mzcw0AThqmErA=;
 b=CYO1tLJW+iwUtI0QfY1LU5Jr8mrE0+K1qjksPHJQDJdae4MLXNVq0aaoQ3M4WL2NezOv2z
 PZcteI4LSvD1wgcD6IOXaYBNEGFIS/a9LgsGkoWD4NmP8po6tVVTn3vUIgfb4+4INlTeJM
 FyNxDjeXzspzg4C+eZp69ubfvdWEVr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997372;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvQCMVyCnjQXWQYttKYnop1DT8sWT0Mzcw0AThqmErA=;
 b=MYrHhsBJ24iPcMvuiFs6ORfu2/QBTcAv4tdtIR52VHD5LvNh15ZZSPXa9A1ay58umGx/OM
 +altg7PmgGtu8GCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CYO1tLJW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MYrHhsBJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777997372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvQCMVyCnjQXWQYttKYnop1DT8sWT0Mzcw0AThqmErA=;
 b=CYO1tLJW+iwUtI0QfY1LU5Jr8mrE0+K1qjksPHJQDJdae4MLXNVq0aaoQ3M4WL2NezOv2z
 PZcteI4LSvD1wgcD6IOXaYBNEGFIS/a9LgsGkoWD4NmP8po6tVVTn3vUIgfb4+4INlTeJM
 FyNxDjeXzspzg4C+eZp69ubfvdWEVr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777997372;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RvQCMVyCnjQXWQYttKYnop1DT8sWT0Mzcw0AThqmErA=;
 b=MYrHhsBJ24iPcMvuiFs6ORfu2/QBTcAv4tdtIR52VHD5LvNh15ZZSPXa9A1ay58umGx/OM
 +altg7PmgGtu8GCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 812A2593A3;
 Tue,  5 May 2026 16:09:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MKFRFDsW+mmNcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 May 2026 16:09:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 06/15] tests/qtest/migration: Use a default TCP URI for
 precopy
Date: Tue,  5 May 2026 13:09:05 -0300
Message-ID: <20260505160915.25558-7-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260505160915.25558-1-farosas@suse.de>
References: <20260505160915.25558-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A539D6B765
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Using a localhost TCP URI for testing is quite common. Set it as a
default for precopy tests that don't provide an URI.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/framework.c     | 4 ++++
 tests/qtest/migration/precopy-tests.c | 3 ---
 tests/qtest/migration/tls-tests.c     | 9 ---------
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 73bb015f64..b77889de7f 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -834,6 +834,10 @@ int test_precopy_common(MigrateCommon *args)
     void *data_hook = NULL;
     QObject *channels = NULL;
 
+    if (!args->listen_uri) {
+        args->listen_uri = "tcp:127.0.0.1:0";
+    }
+
     if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return -1;
     }
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 54e45e2a02..0d538bcd1a 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -180,14 +180,11 @@ static void test_precopy_rdma_plain_ipv6(char *name, MigrateCommon *args)
 
 static void test_precopy_tcp_plain(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
-
     test_precopy_common(args);
 }
 
 static void test_precopy_tcp_switchover_ack(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     /*
      * Source VM must be running in order to consider the switchover ACK
      * when deciding to do switchover or not.
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 0677ca661e..4a3c404349 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -459,7 +459,6 @@ static void test_precopy_unix_tls_x509_override_host(char *name,
 
 static void test_precopy_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
@@ -468,7 +467,6 @@ static void test_precopy_tcp_tls_psk_match(char *name, MigrateCommon *args)
 
 static void test_precopy_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_psk_mismatch;
     args->end_hook = migrate_hook_end_tls_psk;
     args->result = MIG_TEST_FAIL;
@@ -488,7 +486,6 @@ static void *migrate_hook_start_no_tls(QTestState *from, QTestState *to)
 
 static void test_precopy_tcp_no_tls(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_no_tls;
     /* the no_tls start hook requires no cleanup actions */
     args->end_hook = NULL;
@@ -529,7 +526,6 @@ static void test_precopy_tcp_tls_no_hostname(char *name, MigrateCommon *args)
 static void test_precopy_tcp_tls_x509_default_host(char *name,
                                                    MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
@@ -539,7 +535,6 @@ static void test_precopy_tcp_tls_x509_default_host(char *name,
 static void test_precopy_tcp_tls_x509_override_host(char *name,
                                                     MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_override_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
@@ -563,7 +558,6 @@ static void test_precopy_tcp_tls_x509_mismatch_host(char *name,
 static void test_precopy_tcp_tls_x509_friendly_client(char *name,
                                                       MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_friendly_client;
     args->end_hook = migrate_hook_end_tls_x509;
 
@@ -573,7 +567,6 @@ static void test_precopy_tcp_tls_x509_friendly_client(char *name,
 static void test_precopy_tcp_tls_x509_hostile_client(char *name,
                                                      MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_hostile_client;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
@@ -586,7 +579,6 @@ static void test_precopy_tcp_tls_x509_hostile_client(char *name,
 static void test_precopy_tcp_tls_x509_allow_anon_client(char *name,
                                                         MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_allow_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
 
@@ -596,7 +588,6 @@ static void test_precopy_tcp_tls_x509_allow_anon_client(char *name,
 static void test_precopy_tcp_tls_x509_reject_anon_client(char *name,
                                                          MigrateCommon *args)
 {
-    args->listen_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_reject_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
-- 
2.51.0


