Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BDED37E4F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 15:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg2we-00081z-CQ; Wed, 14 Jan 2026 10:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2wb-0007zk-Dl
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:38:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg2wZ-00040x-Qs
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 10:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768405079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/OvN6EvEI+T0e1I+5UuqhYEX8l5aw1fMH3Awv4ciqFI=;
 b=hzbp5mTyn+kQSBUml9gb0u1VnMmZulhiF54+vn9wOPD474WSre4Bn+Dm5WxOSPLMH/K8QQ
 pWyol3F/XFt/n4QlZgSOj8V8xQ6bwbI38P4M6NgL0/rN2D36psivLDFoel5O4HP9DFnCJC
 fMYp+kKjqxbovbLPDGoDMaKGPcUtOzU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-e4sNl8CvN-y3aKUnE_nQag-1; Wed, 14 Jan 2026 10:37:57 -0500
X-MC-Unique: e4sNl8CvN-y3aKUnE_nQag-1
X-Mimecast-MFC-AGG-ID: e4sNl8CvN-y3aKUnE_nQag_1768405077
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2dbd36752so2202600385a.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 07:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768405077; x=1769009877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/OvN6EvEI+T0e1I+5UuqhYEX8l5aw1fMH3Awv4ciqFI=;
 b=qXd1dX6hAMxuzybLsd7xjrpHXW5my/P3OBTq3HwppqImnKSuzFIyGbeeaer7Tb7PJs
 07E/NfCejOZwThWFpNzoVdX1lH5ovnMjc7LPjFTHONK0e6VrYEfX/g1JnsK+dD7rBmWW
 8iOrGASUH5Rihoku5UUxwkKd1WqqPlY3LrjsNd6R1930zrAOuQLfEJCOv1BtXencsNBD
 VeTUDDoeB29xecKpEcSpLaqvqfDQ0l4BuD2ALbQnxCecmF88YLQh4+wgCKjaAQD802Vn
 aww0ALYD8c/b0S9aOlrIvKjNDCyF5yd4chreMPCzk0zoQ2fex0KrijLAg47XmoAfctaX
 7MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768405077; x=1769009877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/OvN6EvEI+T0e1I+5UuqhYEX8l5aw1fMH3Awv4ciqFI=;
 b=Qh84RLaclqB4WEQXpxWDZ5Nij7YlFXjaE7n7+OZwfzh9l4CbAxTEsgKfbVG8PDL29r
 kr7wdK5Dh8TgPTTN4dpw2E9Wia//PfLRjhnYESUjB5EqZ6UXm9Ud9ZLEuCCwKiSib/Rm
 KK/j52ELPnr4okfliXi6GHGu82l/S8z28CCx9HzOO8NneH/yW69MvrxhgEfkn2Zntgwx
 518DeGOdN6nWfE6nc00z6esnA+eQk0BOBs7SR9dESV3JPBTWLmjc0mEVyElLpszYzrWp
 5DkcGNlXxGyS4stxuRa3WkNxPpbprO6e8hy2Y4HrwKvJRzt7aVYc0MeKnHCxSApkMVf4
 6FzQ==
X-Gm-Message-State: AOJu0YznB4ufvtWmIOrJHxUP+cA/ezZyl4QAO42u8on1g6tXFtWLbJFM
 STJl5LBNToMPywZEFsAgo6uyRXvyO3bVmJuHz4b1F0ac7LqTonHZVILXwHwMDiusQ5TIk0QyiUK
 fdbnvk1GxGfCUNLybJGVDgTIo9JziuDGPvdrPdLlR0/e75+s1u8pazBoj6AWQFX2286qReCiPUz
 S8qBGr7rWmbNmoIGT5E63i4JRHs287lm0dCgjrYQ==
X-Gm-Gg: AY/fxX7AoUQ5m1yD674WzJrmmabBiOJ3S19uvR6KQiywshhXRvLxW7fzbA6c3z9mBuW
 qH9WZ1EPPSFEyhxTCXn+2p0cmg2ab0LEPGtgb6yNBI1XLul+IvIVLjdw6c6jkT5/v3z7U2eG82w
 V82dIGFwBHlVqcparkgSqJSYSv1RnDg3dISY3W4J9Jh7Ea1W0Tf+wzuKKyswkdVk7gs0mDGfiak
 xu+h3OYEhMKAh/pTB1L7WGm15+qntlIM9E5v8qyOR6HkhBWxvCK6TMZKxsR+kzMjDk3RJQPml6Q
 cltC3/l0MoUp4js8V8eMOaprboTgfQWd910WeL0x/VwaEZsZWlZBTPV2cLUee31cGHBvN7nah1j
 p
X-Received: by 2002:a05:620a:390d:b0:8be:94e6:3e6c with SMTP id
 af79cd13be357-8c52fb2f214mr436997885a.39.1768405076605; 
 Wed, 14 Jan 2026 07:37:56 -0800 (PST)
X-Received: by 2002:a05:620a:390d:b0:8be:94e6:3e6c with SMTP id
 af79cd13be357-8c52fb2f214mr436991485a.39.1768405075860; 
 Wed, 14 Jan 2026 07:37:55 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c530aab8f1sm184047185a.23.2026.01.14.07.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 07:37:54 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 1/2] tests/migration-test: Remove postcopy_data from
 MigrateCommon
Date: Wed, 14 Jan 2026 10:37:50 -0500
Message-ID: <20260114153751.2427172-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114153751.2427172-1-peterx@redhat.com>
References: <20260114153751.2427172-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now postcopy is not the only user of start_hook / end_hook that will pass
in a opaque pointer.  It doesn't need to be defined in MigrateCommon as
part of the framework, as all other hook users can pass hook_data around.
Do it too for postcopy.

Reviewed-by: Prasad Pandit <ppandit@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.h |  1 -
 tests/qtest/migration/framework.c | 18 ++++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index ed85ed502d..0d39bb0d3c 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -230,7 +230,6 @@ typedef struct {
     bool live;
 
     /* Postcopy specific fields */
-    void *postcopy_data;
     PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
 } MigrateCommon;
 
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index e35839c95f..4f46cf8629 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -541,6 +541,7 @@ void migrate_end(QTestState *from, QTestState *to, bool test_dest)
 
 static int migrate_postcopy_prepare(QTestState **from_ptr,
                                     QTestState **to_ptr,
+                                    void **hook_data,
                                     MigrateCommon *args)
 {
     QTestState *from, *to;
@@ -554,7 +555,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     }
 
     if (args->start_hook) {
-        args->postcopy_data = args->start_hook(from, to);
+        *hook_data = args->start_hook(from, to);
     }
 
     migrate_ensure_non_converge(from);
@@ -582,7 +583,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 }
 
 static void migrate_postcopy_complete(QTestState *from, QTestState *to,
-                                      MigrateCommon *args)
+                                      void *hook_data, MigrateCommon *args)
 {
     MigrationTestEnv *env = migration_get_env();
 
@@ -601,8 +602,7 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
     }
 
     if (args->end_hook) {
-        args->end_hook(from, to, args->postcopy_data);
-        args->postcopy_data = NULL;
+        args->end_hook(from, to, hook_data);
     }
 
     migrate_end(from, to, true);
@@ -610,13 +610,14 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
 
 void test_postcopy_common(MigrateCommon *args)
 {
+    void *hook_data = NULL;
     QTestState *from, *to;
 
-    if (migrate_postcopy_prepare(&from, &to, args)) {
+    if (migrate_postcopy_prepare(&from, &to, &hook_data, args)) {
         return;
     }
     migrate_postcopy_start(from, to, &src_state);
-    migrate_postcopy_complete(from, to, args);
+    migrate_postcopy_complete(from, to, hook_data, args);
 }
 
 static void wait_for_postcopy_status(QTestState *one, const char *status)
@@ -742,6 +743,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
 {
     QTestState *from, *to;
     g_autofree char *uri = NULL;
+    void *hook_data = NULL;
 
     /*
      * Always enable OOB QMP capability for recovery tests, migrate-recover is
@@ -752,7 +754,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
     /* Always hide errors for postcopy recover tests since they're expected */
     args->start.hide_stderr = true;
 
-    if (migrate_postcopy_prepare(&from, &to, args)) {
+    if (migrate_postcopy_prepare(&from, &to, &hook_data, args)) {
         return;
     }
 
@@ -808,7 +810,7 @@ void test_postcopy_recovery_common(MigrateCommon *args)
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
 
-    migrate_postcopy_complete(from, to, args);
+    migrate_postcopy_complete(from, to, hook_data, args);
 }
 
 int test_precopy_common(MigrateCommon *args)
-- 
2.50.1


