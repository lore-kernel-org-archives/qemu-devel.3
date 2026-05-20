Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFEECD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYw-0001Hj-9p; Wed, 20 May 2026 17:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYu-0001H9-I8
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYs-0007KF-F1
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0x3Ay0P3vXrHy1/36SANeDG2Z3InXKa4XI7f+qoQ2A=;
 b=VdBDXX+S3Ocm6gwzuigi0HzIBsNLbVAYBsHKYLeS034PpIVzvkXkgaw55S/MHaMLBxJmJf
 gfGojwoaG8/CWHB7B/SoiW2P5Ac82UBwOp6nLf06iFfRUOuZ5xrWdm5Ln91KjYs4cYg13b
 KHlWJl7Ms8z0ezGC769/Dq6jTqrxzaI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-QpDUrLE8OnKtbrX53Oi6Sg-1; Wed, 20 May 2026 17:34:40 -0400
X-MC-Unique: QpDUrLE8OnKtbrX53Oi6Sg-1
X-Mimecast-MFC-AGG-ID: QpDUrLE8OnKtbrX53Oi6Sg_1779312880
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b7a1ea06bfso167951036d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312879; x=1779917679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0x3Ay0P3vXrHy1/36SANeDG2Z3InXKa4XI7f+qoQ2A=;
 b=C9jMd3Gpjn7tIIn0Q1HCdNcA4bEcx5Ase/G4MRjwCXqUFzwwrTiJsfc4jYvzHCgcPu
 M5O8s3yTVKFeMsqpXjH94Oun6FBiDraitQLy3YwYFGRWJELC4o3OMsU2odr1Yi2CNOJu
 BBH9QPUFG9rm+F7aUXyg8dZFx1oOBO2wuzP+/0OZE2uPyhph1/469L1wZRN5o1ijRFP/
 wzc0y/1D+1BztZ9/C6B/aQ1QVVJdPg/qusuEOu+ythDI5dRfOjKQBdsBtg2HS5v0nkQP
 MvgpYWfCVlClRttprHOaB7KZRaXObK06RqsvpzJ+OdOw0ZdZj4+SIFdfv/2vbA5o/uNI
 7sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312879; x=1779917679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u0x3Ay0P3vXrHy1/36SANeDG2Z3InXKa4XI7f+qoQ2A=;
 b=dBy9rvDi8nNf4rJ/yc0VlSEignjTkocxSPIIPFO8F4N9bO6t1vj0Fvp+Ronkx1CyTp
 HiwBy5psgYTfLQrha7W+aATPZZ9REacfASZEaaB4WVKITC8fve5Wy5JDDXhAH6CN+tXH
 tO+ZPHP5p+MeB629sULxlqpryLfPvS2LLtXfXMvoR99ClHZrrqcTXEKcy3V5F53UgzeB
 obk0L6cJKoMhI+vfl2aZyH8TTAe4hfUg7b79DNV0O6jnAIx4buyXjNULYSGSM8NGlxxA
 bluL/+Mps5iEHSi1H6aoA/FRpYwQbG9DkeHSz8nh9tYr1/Gy8fxerGX5bdVxluI1gIQZ
 aNRg==
X-Gm-Message-State: AOJu0YzhbABDPDfpFiWS181uHSdEi7ivoFoSvXQusEndqYbmn6xSDFbV
 x6DqF3og0ku00LPIcyBR05F/yBOlMQBxC9A6k90IjtmRU9Oh1dr+W5zEM5HHKeUev+qQOS57SFl
 Ho5rX2qyWGLyQD9+me8o6PO50Sdo72MvOY9n88QYpEJrbnxkgq0djYPZhq8tZUDpfxh1TSugsgE
 XCbQPBuabmXM/7TmvDO2B9Nk4HK8+L4jABCVihPQ==
X-Gm-Gg: Acq92OGV7oH43u1mMZjxCSW15mVpX9T9eVxyHD6MdoUf5zQBzSS3PN9r1fRsKhP5rrl
 BI2ELE99MRuy9hFc/N2Ru0D3oS3usw87RO7sbsDcf+4ly87c039wXWEXbQOOjXf2qwLEhVQmsTN
 oSqygNEsYQOc5d5tTYHTQY+LshHIjswf/hN7KEruOungd1NF5FwGRoNlH3ojUBw/ie6aa73plIZ
 0iT9Fk8+nIwbx2wbIN5T3q76PTasd/Kmdz+ot9oILdxmi9yFYH71UbBJOvDcg8IoRjME7vriDp9
 lCzmR3zjJY9L0vqKoie2JhWUPbe1jGqlRGJX9pfY3LPDKvCLPzDaasqgfdgtEJqCwGczKW51s5c
 nNr7gbMs9lCBkKo2Hg62W6cxggwEQWJxbvh8lmDXzcPgI
X-Received: by 2002:a05:6214:20a1:b0:8ac:abc5:8754 with SMTP id
 6a1803df08f44-8cc6e36241emr4370366d6.30.1779312878786; 
 Wed, 20 May 2026 14:34:38 -0700 (PDT)
X-Received: by 2002:a05:6214:20a1:b0:8ac:abc5:8754 with SMTP id
 6a1803df08f44-8cc6e36241emr4369636d6.30.1779312878110; 
 Wed, 20 May 2026 14:34:38 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 15/29] tests/qtest/migration: Remove multifd compression hook
Date: Wed, 20 May 2026 17:33:43 -0400
Message-ID: <20260520213357.40646-16-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Take advantage of the default compression method for multifd being
"none" and remove the common compression hook.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260505160915.25558-10-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.h     |  3 --
 tests/qtest/migration/framework.c     |  9 ----
 tests/qtest/migration/precopy-tests.c | 11 ----
 tests/qtest/migration/tls-tests.c     | 74 +++------------------------
 4 files changed, 8 insertions(+), 89 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 825209ee74..8d5331a860 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -242,9 +242,6 @@ void test_postcopy_recovery_common(MigrateCommon *args,
 int test_precopy_common(MigrateCommon *args);
 void test_precopy_unix_common(MigrateCommon *args);
 void test_file_common(MigrateCommon *args, bool stop_src);
-void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
-                                                    QTestState *to,
-                                                    const char *method);
 
 typedef struct QTestMigrationState QTestMigrationState;
 QTestMigrationState *get_src(void);
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 5da39eac76..b1bf8ea8ae 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -1063,15 +1063,6 @@ finish:
     migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
 }
 
-void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
-                                                    QTestState *to,
-                                                    const char *method)
-{
-    migrate_set_parameter_str(from, "multifd-compression", method);
-    migrate_set_parameter_str(to, "multifd-compression", method);
-    return NULL;
-}
-
 QTestMigrationState *get_src(void)
 {
     return &src_state;
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index b73b73a807..246f9fd555 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -322,18 +322,10 @@ static void test_auto_converge(char *name, MigrateCommon *args)
     migrate_end(from, to, true);
 }
 
-static void *
-migrate_hook_start_precopy_tcp_multifd(QTestState *from,
-                                       QTestState *to)
-{
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-}
-
 static void *
 migrate_hook_start_precopy_tcp_multifd_zero_page_legacy(QTestState *from,
                                                         QTestState *to)
 {
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
     migrate_set_parameter_str(from, "zero-page-detection", "legacy");
     return NULL;
 }
@@ -342,14 +334,12 @@ static void *
 migrate_hook_start_precopy_tcp_multifd_no_zero_page(QTestState *from,
                                                     QTestState *to)
 {
-    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
     migrate_set_parameter_str(from, "zero-page-detection", "none");
     return NULL;
 }
 
 static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_precopy_tcp_multifd;
     /*
      * Multifd is more complicated than most of the features, it
      * directly takes guest page buffers when sending, make sure
@@ -394,7 +384,6 @@ static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_channels_none(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_precopy_tcp_multifd;
     args->live = true;
     args->connect_channels = ("[ { 'channel-type': 'main',"
                              "    'addr': { 'transport': 'socket',"
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 275d0b84d4..f45f4c4b0c 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -593,67 +593,9 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(char *name,
 }
 #endif /* CONFIG_TASN1 */
 
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
 static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
+    args->start_hook = migrate_hook_start_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -663,7 +605,7 @@ static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
+    args->start_hook = migrate_hook_start_tls_psk_mismatch;
     args->end_hook = migrate_hook_end_tls_psk;
     args->result = MIG_TEST_FAIL;
 
@@ -676,7 +618,7 @@ static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
                                                     MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
+    args->start_hook = migrate_hook_start_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -689,7 +631,7 @@ static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
 static void test_multifd_tcp_tls_x509_default_host(char *name,
                                                    MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tls_x509_default_host;
+    args->start_hook = migrate_hook_start_tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -700,7 +642,7 @@ static void test_multifd_tcp_tls_x509_default_host(char *name,
 static void test_multifd_tcp_tls_x509_override_host(char *name,
                                                     MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tls_x509_override_host;
+    args->start_hook = migrate_hook_start_tls_x509_override_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -724,7 +666,7 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
      * to load migration state, and thus just aborts the migration
      * without exiting.
      */
-    args->start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host;
+    args->start_hook = migrate_hook_start_tls_x509_mismatch_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
 
@@ -737,7 +679,7 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
 static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
                                                         MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client;
+    args->start_hook = migrate_hook_start_tls_x509_allow_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -748,7 +690,7 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
 static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
                                                          MigrateCommon *args)
 {
-    args->start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client;
+    args->start_hook = migrate_hook_start_tls_x509_reject_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
 
-- 
2.53.0


