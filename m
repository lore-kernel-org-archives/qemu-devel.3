Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54167CEFD01
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 20:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdDkS-00089Q-MH; Tue, 06 Jan 2026 15:33:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdDkI-00084j-Hn
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 15:33:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdDkG-0006oB-NP
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 15:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767731616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+bbNT2SHlvLODHqdtEMfBZv1WYjcGKdKT9Qdi22zKg=;
 b=Ev4Te8hozsqm8C6WZp49O5UQOyvZhLxVEL+XSSR9vZQgl8zIXcCdCHEqANqOClGrN++qhx
 1PEt9Q3dtl5O4TWVnvIXzSQj9n4ohsyj0TqR9PyhOm2uNax6soeVTqg2PSch+KHd38ucXJ
 XlgVtN/9ywsr8xpvlu3Nt+sWIil8sxk=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-qn44PJ7DOPS2oaYviz45sA-1; Tue, 06 Jan 2026 15:33:33 -0500
X-MC-Unique: qn44PJ7DOPS2oaYviz45sA-1
X-Mimecast-MFC-AGG-ID: qn44PJ7DOPS2oaYviz45sA_1767731613
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ae6ef97ac5so1785964eec.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 12:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767731612; x=1768336412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B+bbNT2SHlvLODHqdtEMfBZv1WYjcGKdKT9Qdi22zKg=;
 b=hiQ06PCMoqhJRrQevkKrzj0m8RJaJ+uIUv7KFpUhFTQDJUC8SrPKoZirxOjIe9mIOm
 kSr3XvAj2QTDzVJlNkNj45ecOyE3G4SRI/yWjbLP8RBURrrGNCHYAY4l8QtAE7ZO8jjy
 RgOoGw7hViMJcer5sj/1a8pL1Y802G+YD/nL2mxl9O/xlV6p1QOfI4X4WzlpBEdMm3pp
 T/PIjIISg6/hGiABkCFtxDkfGQv1iW/rS12rUiRfJmzbLOc4PzL6UB6QOBtw8pC8bc8t
 VHVFO1Z8mBkUyxxc9ugb8tx2lz/qDv6rZhdzgPGgVoEAGz8BipfPefPCysLwhk9OgJyt
 l91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767731612; x=1768336412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B+bbNT2SHlvLODHqdtEMfBZv1WYjcGKdKT9Qdi22zKg=;
 b=MlyOo/TtG5oRhojMO+afDQYsfWXdVWXBwfJvavuTUAkKBITbZBaGUH01gjUy1sjrR+
 DDv4SYhB0aYC630MLD1nypLzyTzG9DCKUUmWbfYMC0zZJZZOW5o0tYYYm5ciE9DVjLj6
 6SHDb0LIBgZK7G/LShiRXTlWxFLffjEUg3K8qmO0o/OLP2zlJP9DjWe3Xbm4d182belj
 WEYgTMlxYyFQDjxfOd7YbAfjtKEDZurgV2w1Jiuz/qZO9d2MR6d3HcGP3mvgnmtsY5Ce
 MZzT9Fr4skPkQHcWNjgog77Z8eBMFmyMtQp24WQpwrTmcUhoRVtGQ+VIyOl9Ni5lBVYh
 WiHQ==
X-Gm-Message-State: AOJu0YxEu7KyaQYBLyLnBAFuxIuAxzZMTCIb+sFP+TqKN1ngRMtAnVg2
 lhxjBN1UjFbLdswlmvs1p+XVYAbSVbzYSgumlR9oU6Mwbe/JGn8bBgkNfEmuHo25iUGn725Z6io
 sUTgjXCUaG/aBiniHCIVeWn+xlP5jLAWQoAzZB7Bm/uEzsAdqz8JV7yh+cPsXA9Eynht3Cu9Srv
 OwT1EXwXfXGjVvkyzyUOXAC8ZZ5Rd4qQ6tLvbspw==
X-Gm-Gg: AY/fxX7xJZ6aSNb5+tj5XxTC+9e0DFojD6DFg7BhN7at2tb1W4f7i1iAYULI5G9Pslr
 yfGPR5Bkolldzuf03nWpcG+YzwFRW2ZMcwuVyYn99ZjRSkUMVouPHoCyYYIaajKKZE3EEppYXTa
 wptp1Y936xuQCeeTTNoXsFKZ4D6pRfgXnU+2AGlepoFf5W0Iex4JUxBD6JxvrCwXRoCZDSKvzJm
 ZnRQXEY8DUc4qY8kc6vmgt26C0dKMyv6xiHTFQNTFyvm0MW1JRUsvbPdMIbgXxYSeQZAfUGZ1rf
 2QuQBt26VlMIHwKINQp/ear/d00d21c2B8F4EgJSzzLTDKCZUkqjsSYhlf09A7QcwZBT8teBeKr
 L
X-Received: by 2002:a05:693c:8391:20b0:2ac:21bf:e937 with SMTP id
 5a478bee46e88-2b17d0ca4c4mr152253eec.0.1767731612310; 
 Tue, 06 Jan 2026 12:33:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgSpV6dnm5T4IzlBiPVkNezpU0qWso8Wm5FOQAxw1QL1FWdyGIFreSKrR5ItRt2yy3w9X6Qw==
X-Received: by 2002:a05:693c:8391:20b0:2ac:21bf:e937 with SMTP id
 5a478bee46e88-2b17d0ca4c4mr152232eec.0.1767731611774; 
 Tue, 06 Jan 2026 12:33:31 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b17078dd84sm4819273eec.17.2026.01.06.12.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 12:33:31 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Lukas Straub <lukasstraub2@web.de>,
 peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 2/2] tests/migration-test: Remove postcopy_recovery_fail_stage
 from MigrateCommon
Date: Tue,  6 Jan 2026 15:33:20 -0500
Message-ID: <20260106203320.2110372-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260106203320.2110372-1-peterx@redhat.com>
References: <20260106203320.2110372-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The parameter can be instead passed into the function.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.h      |  6 ++----
 tests/qtest/migration/framework.c      |  7 ++++---
 tests/qtest/migration/postcopy-tests.c | 12 ++++--------
 tests/qtest/migration/tls-tests.c      |  8 ++++----
 4 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 0d39bb0d3c..bc6cf6040f 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -228,9 +228,6 @@ typedef struct {
      * refer to existing ones with live=true), or use live=off by default.
      */
     bool live;
-
-    /* Postcopy specific fields */
-    PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
 } MigrateCommon;
 
 void wait_for_serial(const char *side);
@@ -243,7 +240,8 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
 void migrate_end(QTestState *from, QTestState *to, bool test_dest);
 
 void test_postcopy_common(MigrateCommon *args);
-void test_postcopy_recovery_common(MigrateCommon *args);
+void test_postcopy_recovery_common(MigrateCommon *args,
+                                   PostcopyRecoveryFailStage fail_stage);
 int test_precopy_common(MigrateCommon *args);
 void test_file_common(MigrateCommon *args, bool stop_src);
 void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 4f46cf8629..d7a5ae56f9 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -739,7 +739,8 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to,
 #endif
 }
 
-void test_postcopy_recovery_common(MigrateCommon *args)
+void test_postcopy_recovery_common(MigrateCommon *args,
+                                   PostcopyRecoveryFailStage fail_stage)
 {
     QTestState *from, *to;
     g_autofree char *uri = NULL;
@@ -784,12 +785,12 @@ void test_postcopy_recovery_common(MigrateCommon *args)
     wait_for_postcopy_status(to, "postcopy-paused");
     wait_for_postcopy_status(from, "postcopy-paused");
 
-    if (args->postcopy_recovery_fail_stage) {
+    if (fail_stage) {
         /*
          * Test when a wrong socket specified for recover, and then the
          * ability to kick it out, and continue with a correct socket.
          */
-        postcopy_recover_fail(from, to, args->postcopy_recovery_fail_stage);
+        postcopy_recover_fail(from, to, fail_stage);
         /* continue with a good recovery */
     }
 
diff --git a/tests/qtest/migration/postcopy-tests.c b/tests/qtest/migration/postcopy-tests.c
index 7ae4d765d7..13a5759655 100644
--- a/tests/qtest/migration/postcopy-tests.c
+++ b/tests/qtest/migration/postcopy-tests.c
@@ -41,30 +41,26 @@ static void test_postcopy_preempt(char *name, MigrateCommon *args)
 
 static void test_postcopy_recovery(char *name, MigrateCommon *args)
 {
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
 }
 
 static void test_postcopy_recovery_fail_handshake(char *name,
                                                   MigrateCommon *args)
 {
-    args->postcopy_recovery_fail_stage = POSTCOPY_FAIL_RECOVERY;
-
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_RECOVERY);
 }
 
 static void test_postcopy_recovery_fail_reconnect(char *name,
                                                   MigrateCommon *args)
 {
-    args->postcopy_recovery_fail_stage = POSTCOPY_FAIL_CHANNEL_ESTABLISH;
-
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_CHANNEL_ESTABLISH);
 }
 
 static void test_postcopy_preempt_recovery(char *name, MigrateCommon *args)
 {
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
 
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
 }
 
 static void migration_test_add_postcopy_smoke(MigrationTestEnv *env)
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 6a20c65104..bf0bb06a29 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -385,7 +385,7 @@ static void test_postcopy_recovery_tls_psk(char *name, MigrateCommon *args)
     args->start_hook = migrate_hook_start_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
 }
 
 static void test_multifd_postcopy_recovery_tls_psk(char *name,
@@ -396,7 +396,7 @@ static void test_multifd_postcopy_recovery_tls_psk(char *name,
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
 
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
 }
 
 /* This contains preempt+recovery+tls test altogether */
@@ -407,7 +407,7 @@ static void test_postcopy_preempt_all(char *name, MigrateCommon *args)
 
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
 
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
 }
 
 static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
@@ -419,7 +419,7 @@ static void test_multifd_postcopy_preempt_recovery_tls_psk(char *name,
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_PREEMPT] = true;
 
-    test_postcopy_recovery_common(args);
+    test_postcopy_recovery_common(args, POSTCOPY_FAIL_NONE);
 }
 
 static void test_precopy_unix_tls_psk(char *name, MigrateCommon *args)
-- 
2.50.1


