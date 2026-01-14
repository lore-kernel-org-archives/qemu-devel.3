Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2756D37E4F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 15:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg2wd-000816-MM; Wed, 14 Jan 2026 10:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2wb-00080E-V3
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:38:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2wa-000411-7H
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768405079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2cTCE74I1jPtrc4NfTcCULcOjF2BScqMVYRyLtvEFyM=;
 b=RGrtiRwKBZy+NvRzE7CMLrZrD5SC0iLSvL33Lag+nGMOEyDb+tZD+xGgunWMtU8qf5oPAc
 vRehbcme6I4jP7bBQEd3XvSmyQOChU8Ob/PCJoj78XnVmHj7/0T7DeeUcEJdlKJ2TXQ9LX
 893BKGHkFmzxUbLTwKCpDQFA0ZLcZLM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-Ech_W5khNzGecB3Yrtqcrw-1; Wed, 14 Jan 2026 10:37:58 -0500
X-MC-Unique: Ech_W5khNzGecB3Yrtqcrw-1
X-Mimecast-MFC-AGG-ID: Ech_W5khNzGecB3Yrtqcrw_1768405078
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c52fd4cca2so249974485a.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 07:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768405077; x=1769009877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cTCE74I1jPtrc4NfTcCULcOjF2BScqMVYRyLtvEFyM=;
 b=DZUOyNJiiZkJKUyJRzNVE6eE/wyUaXXh3jOU+F6rtI9xTc5tYrOqsjQh/aUQmkZtvx
 Eg5SvK9e6lkgCZL6+kWq1pUFrh303n7/MFm6xeGy0fcIReoksW/19nrHaxWuNqZiOuyn
 hi1h8bqntThNfxQHB60SlZ2exaETIbkNxYYsFy8fcjatPFvT4/ZQ9Eioo8e3F3n6grL5
 VJmmcXRwOABCzpFjOOTVohkke0yXLAEkzDHJjVKjqkpdS20+48yWmp1ekQa6exsC2X4P
 vO3LFbiJoW5yM55p+RAd2PCFr0REHF0LEhEUNfVSEFo2H4XV3FCXRLH1EvxF5updzb1S
 18Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768405077; x=1769009877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2cTCE74I1jPtrc4NfTcCULcOjF2BScqMVYRyLtvEFyM=;
 b=vIUN0v+jF3Yc4I/xrLxxHhzYfAuKRuo6CNIcIdjRpDo+X7nJmCxhqSrWViNQdM2AE0
 wWX2Mjd46kho4W8ZcmHdML11a7icH+tKGnhqRC0sRYclHbQf6i5H0Ar9Prpd6RNikSrM
 eLHODnz2x9ySJWATBqyCRUI1yTyzjJTeHDEEshvXLBrlxtqBtdAsGVv+HpQHV0ZhKL4Z
 A6niVvsbFGNOnlebFNroy9fT8WIpxoNdPNZhiYQJSJN7m8bX+1ZUx8PZ8t8deZmAtJGY
 Td/SgaivDmruPAm374nrH8/YqhRwnMIILa/MNcKnfUQuxKo0ny6SJyA6kN8HIZtwc+aL
 J/6A==
X-Gm-Message-State: AOJu0YxGVDQix6+tFqqKkfeIjeDeHAkzjy/SjA4FZup2xDzHtaagAC3f
 D+7aP5ZuvSW/C2/PWz0xFEI8RiXmG+u5DYgFuuPk0U4YKBCzEsBvi+qqMRJPoac3mKHL5w+fKtv
 c5HDubIcvoLFCdZyZN5mzPtKcEOm7Gl/D0pzZ/mQ3NG0Se9s4g9BnjAJ8fvGUasNXt5l4AeRbFv
 D42W/O2I9mInmgcON1znJpHaXjUc0vPzvRCKm7VQ==
X-Gm-Gg: AY/fxX7nhV02LuknjiuQz+A4Z3DjpT2P7E4xo4hMU/Pw/C7FZR6ZCL4YCOhs/EIqY9W
 t3kWAZVeyayJrQik2ctLVZksYyYApAOQ0XYKFQTs0r6fUsbtlZmQxYLo0Nu/FBdDb7Prp41xUy0
 SGu4iTmL1LCN3G0iCesBYCDpaMeQu3wzjcuPamDhi67xcWJi2LumaCRSGYPnUQEkeY+EGdrEN63
 x7jFJow2gd+1e1QE2zta+M0O0i0vSjeGYc59uQLUdRTEKLt1haZTeSm1fJZcc5speKTGMe71+d1
 MG+T/Nz3HrTkKjKwj+dTY3922lp1IHRH7lgD1trQRQQwUwEKrj/KCXxzg+uuU4YMVYB3dhrWUMp
 0
X-Received: by 2002:a05:620a:25d0:b0:8b2:f182:6941 with SMTP id
 af79cd13be357-8c52fbcf01emr363669385a.57.1768405077458; 
 Wed, 14 Jan 2026 07:37:57 -0800 (PST)
X-Received: by 2002:a05:620a:25d0:b0:8b2:f182:6941 with SMTP id
 af79cd13be357-8c52fbcf01emr363665085a.57.1768405076938; 
 Wed, 14 Jan 2026 07:37:56 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c530aab8f1sm184047185a.23.2026.01.14.07.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 07:37:56 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 2/2] tests/migration-test: Remove
 postcopy_recovery_fail_stage from MigrateCommon
Date: Wed, 14 Jan 2026 10:37:51 -0500
Message-ID: <20260114153751.2427172-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114153751.2427172-1-peterx@redhat.com>
References: <20260114153751.2427172-1-peterx@redhat.com>
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

The parameter can be instead passed into the function to avoid polluting
the global address space of MigrateCommon.

Reviewed-by: Prasad Pandit <ppandit@redhat.com>
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


