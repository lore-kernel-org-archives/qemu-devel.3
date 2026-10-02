Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB43CA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCb3O-0001W0-Kk; Fri, 02 Oct 2026 07:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xCb3N-0001VO-2B
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:03:49 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xCb3L-0008Ud-4e
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:03:48 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffed768deso22460595e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 04:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790939025; x=1791543825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wZ5fd90wMmGhR18V4PeDCCYB/ele6ujHSK6hnH2+u28=;
 b=rvOE2RIDlispbUKfewn2/OIoBoSemaDO1Fq+WFk0Xfd43t6EDEpCqYdJ68EijqhSnd
 0LIa3xsSzn873gdMnbzADfdXccexMqt6z4vtckaVxufbN7+LcCqn0cOEaC42bWJgCsB3
 P2fiyOYZu+qcsYJ8mv2tkPB+NeGQ/rXPRTrRgdnQbN6pER6wzgeVGGbDU8TyM6XswJo5
 Uzjj3fZF86fa0WkKqi7hTxuFfe2G1Sgeed/eHg69Tb0xnfz73w4lKtpmyqY3c3kW/yD1
 7h5bmvKyCgCqmW0dXVMOf0+64MmrRp4iCEWax/dmEeJB8QuZLnENMkOYbbC4fF2OTTyi
 REzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790939025; x=1791543825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wZ5fd90wMmGhR18V4PeDCCYB/ele6ujHSK6hnH2+u28=;
 b=yQmNcPTqu43AkkxIZZhxk6Ycr9BEU5HgIQTIMxy2TVc56DvOdKJEHmC8BAAkdaKEvz
 meCF5+43Kjv71/20cdAgpYwMatjb5yx3c2Tz50xLa4BWuizFWKFrXRp6H6L34nB4ZNr9
 uK73rrRZmSgCuLxSV9nMddaPTpR8zts0vxrUoNv3/Bxkjj2ZdBWRnyNXuRv05ifKtIbJ
 0KCsv5sAW5w6Dm9N+nAZnlR5vfBxbJGPkKTfYA8rjSUM+1PhUKM0K7oHsP2l1LTE60IC
 /luRqDlyTOvKXqNE//FFqzxCnRKPrSy49EYbdCdLWHEcgf4Lp0JDwGrTR91F/gKh4pu/
 kLhA==
X-Gm-Message-State: AFuF++kgjt6WcCsZVPv/APXImaj1039zjPXU60jL4pRgtwyz7/0tpShh
 wZ5OpWx+msUQiHleEObTH8GGunzwV1BQHKulEcXcY0RRcC+EcV3sixpXjp/eWtQD0Kh3wrOqkde
 jRXav
X-Gm-Gg: AYBFou3gBnVqkxFBu9o98FhcWlVE829oTuEzdW6QxG8VZ5rcXfnqz8Rbe4gQfrBUsFv
 fa7GpZuEnsNubGrixwY8AQOVvlVhVkD1+2WRCJSYPWmozwR8OKyV29bEyAI3ZKBimoM6PwLEuRs
 0W1xu1NW7u3oj7/1GTUFIpRIfwZRWooyRDLoUDPczdkXIxHlq+ZCaoDrd7rn2RSQKiXv7ekH4hh
 1Ps7X5aTnuSB1HQlgooVdaKrjzYbwiY+hbH7t9p6Ue6jqaiwKinE1ysa1v0AIm64rHbyYSwY0xz
 QLtgpSrjJFtxEj/U55GHJrchOFfjN+LWV77F62BZ+2ZVushDAhn22keeLE+9gZ4h9MSDS5u8wzv
 0BcG7oJjOqGaHh/D9p8FlZ1fpq5iP7Sur0w9kqiImFlvkOqBn1Q8BaKWbUKQQk3T0cD+JzZ9/th
 504pspDkTR/YAEHdWBN5KDWShp9GjOej3PWLbunneulOimJMVbKXum6SJjfVrN3WVwPpQ=
X-Received: by 2002:a05:600c:4fc1:b0:4a0:34a:588c with SMTP id
 5b1f17b1804b1-4a0275649cbmr42097435e9.14.1790939025637; 
 Fri, 02 Oct 2026 04:03:45 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9f21:a362:21c8:d9a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03ff3cab2sm24533785e9.2.2026.10.02.04.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 04:03:44 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 3/4] tests/qtest/migration: check the destination run state in
 postcopy tests
Date: Fri,  2 Oct 2026 13:02:57 +0200
Message-ID: <20261002110258.1835979-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002110258.1835979-1-den@openvz.org>
References: <20261002110258.1835979-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
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

From: Denis V. Lunev <den@openvz.org>

The destination must not report postcopy-active or completed while it
is still in RUN_STATE_INMIGRATE. The destination autostarts in these
tests, so the run state change emits RESUME and the order is visible in
the event stream: record a MIGRATION postcopy-active or completed event
seen before RESUME and fail the postcopy tests on it once the
destination has completed.

migrate_postcopy_start() waited for the destination's RESUME with
qtest_qmp_eventwait(), which reads events past the event callback and
drops the ones it does not want. Poll query-status instead, so every
destination event reaches the callback.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Juraj Marcin <jmarcin@redhat.com>
---
 tests/qtest/migration/framework.c      |  6 ++++--
 tests/qtest/migration/migration-qmp.c  | 10 ++++++++--
 tests/qtest/migration/migration-qmp.h  |  3 ++-
 tests/qtest/migration/migration-util.c |  8 ++++++++
 tests/qtest/migration/migration-util.h |  2 ++
 5 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index b7aef6b21c..1cf18233f7 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -667,6 +667,8 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
     MigrationTestEnv *env = migration_get_env();
 
     wait_for_migration_complete(from);
+    wait_for_migration_complete(to);
+    g_assert(!dst_state.migrated_before_resume);
 
     if (args->start.suspend_me) {
         /* wakeup succeeds only if guest is suspended */
@@ -695,7 +697,7 @@ void test_postcopy_common(MigrateCommon *args)
     if (migrate_postcopy_prepare(&from, &to, &hook_data, args)) {
         return;
     }
-    migrate_postcopy_start(from, to, &src_state);
+    migrate_postcopy_start(from, to, &src_state, &dst_state);
     migrate_postcopy_complete(from, to, hook_data, args);
 }
 
@@ -842,7 +844,7 @@ void test_postcopy_recovery_common(MigrateCommon *args,
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 4096);
 
     /* Now we start the postcopy */
-    migrate_postcopy_start(from, to, &src_state);
+    migrate_postcopy_start(from, to, &src_state, &dst_state);
 
     /*
      * Wait until postcopy is really started; we can only run the
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 437b5eaeff..77befe1027 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -549,10 +549,16 @@ void migrate_cancel(QTestState *who)
 }
 
 void migrate_postcopy_start(QTestState *from, QTestState *to,
-                            QTestMigrationState *src_state)
+                            QTestMigrationState *src_state,
+                            QTestMigrationState *dst_state)
 {
     qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
 
     wait_for_stop(from, src_state);
-    qtest_qmp_eventwait(to, "RESUME");
+
+    /* Poll so that every destination event passes the event callback */
+    while (!dst_state->resume_seen) {
+        qtest_qmp_assert_success(to, "{ 'execute': 'query-status' }");
+        g_usleep(1000);
+    }
 }
diff --git a/tests/qtest/migration/migration-qmp.h b/tests/qtest/migration/migration-qmp.h
index 940ffd5950..f275cd7692 100644
--- a/tests/qtest/migration/migration-qmp.h
+++ b/tests/qtest/migration/migration-qmp.h
@@ -46,6 +46,7 @@ void migrate_continue(QTestState *who, const char *state);
 void migrate_recover(QTestState *who, const char *uri);
 void migrate_cancel(QTestState *who);
 void migrate_postcopy_start(QTestState *from, QTestState *to,
-                            QTestMigrationState *src_state);
+                            QTestMigrationState *src_state,
+                            QTestMigrationState *dst_state);
 
 #endif /* MIGRATION_QMP_H */
diff --git a/tests/qtest/migration/migration-util.c b/tests/qtest/migration/migration-util.c
index db66d8b24f..4b5663c5a6 100644
--- a/tests/qtest/migration/migration-util.c
+++ b/tests/qtest/migration/migration-util.c
@@ -178,6 +178,14 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
     } else if (g_str_equal(name, "RESUME")) {
         state->resume_seen = true;
         return true;
+    } else if (g_str_equal(name, "MIGRATION") && !state->resume_seen) {
+        const char *status = qdict_get_str(qdict_get_qdict(event, "data"),
+                                           "status");
+
+        if (g_str_equal(status, "postcopy-active") ||
+            g_str_equal(status, "completed")) {
+            state->migrated_before_resume = true;
+        }
     }
 
     return false;
diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
index 694773e594..f195aeea48 100644
--- a/tests/qtest/migration/migration-util.h
+++ b/tests/qtest/migration/migration-util.h
@@ -22,6 +22,8 @@ typedef struct QTestMigrationState {
     bool resume_seen;
     bool suspend_seen;
     bool suspend_me;
+    /* postcopy-active or completed reported before RESUME */
+    bool migrated_before_resume;
 } QTestMigrationState;
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
-- 
2.53.0


