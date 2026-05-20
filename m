Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54173CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoZA-0001vF-5R; Wed, 20 May 2026 17:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZ8-0001qJ-Nm
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZ6-0007MJ-8Y
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=83YP1CTDB1l8nweWCTL+KtTHSWasfSnrTDsQIEgOH2E=;
 b=RH0to2asx9n3+R4rvBvW0Lodr7ppn+R54wNJ8zaCTXw1UMPJMmzQJkVl3PZW1deDJmL3g+
 U5m73rDshrpRF/+4ns+W8zll1J9gqkeRx73VU2BIaI8sizhIP1oGF1LH5VgoPRQrONi7mB
 8CSjakqEF4BisJHThApCtrGBeZN+fh4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-LdO-kpz1PF6JICxKW-S2Bw-1; Wed, 20 May 2026 17:34:52 -0400
X-MC-Unique: LdO-kpz1PF6JICxKW-S2Bw-1
X-Mimecast-MFC-AGG-ID: LdO-kpz1PF6JICxKW-S2Bw_1779312892
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b1f39c5827so130284866d6.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312891; x=1779917691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=83YP1CTDB1l8nweWCTL+KtTHSWasfSnrTDsQIEgOH2E=;
 b=YhYe9Mit4TTbfMN/Ioc98mc9yeBvVcMzuFdCQBDFm30Y1syonZ0Anq8vh3fgITQnFL
 I2PeCv0lZVlvt1rEZjv3+zIm79uLbCOYcdCA27JvywogLk4Yva7vfeLndyUNAsjJr8pu
 wM+0GKdprg2uykxj59gm9eCTTQZmVu2TMa2CPsseM4kqbY0T3ex8UWFfSjh91HaA72LX
 +mK0t/Ozvf8z/bi0kv8MOJUzymYKN9xzrfw7Uaw5TKoMNZc34+1Gm7CnjenLMFcLzMps
 2TAE7G4pEFDk7K3Po9imH/0AnxF94525loaokS3I50gA91ynaGftYCaxtXA8dYDI7HV6
 +K0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312891; x=1779917691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=83YP1CTDB1l8nweWCTL+KtTHSWasfSnrTDsQIEgOH2E=;
 b=k+A577qwzGNlWn675ZvvGpg5gyl3H1aWZEMydLKEuvIBTJbH+4/yZ+cZWEgeOFC4pV
 8nf74BOvdrz45+BlaDuzIHW/ZZt8ujpk0rsn3DuI6RJE2E/OuZbm95blBZ2mg5gHs/HL
 XmhWIENR1ZbLzBX0zpcGlGipKvwcZrI3m8IHXQQvGzgduI1BpmaREt47swVYg7W7UqJ4
 4K3uYU6xwjTi3++SDuHnLaQFB2kTTbVd6zFmwc5t9dRaEk0jV/t+Ut6r6RDCnJ3FucDN
 rnAR3VR3oKj13i3QseMmVxwckZjbeAUG7jE3OzTT1Y/Xhd3P8B1yXP9mazwhosKgt6BO
 G/cw==
X-Gm-Message-State: AOJu0Yx/1cMszpvj2kpHY9bd6Hem4Dt3Icc+XvDjGFYwF5hnHXgy2y+D
 38lRrYtZa6+mrBugrsyR6t0xYxOsHm3o4bt5xddiIZuijiG6KFAYz6bSFZm/dEcT/cYNr1HdDk8
 dL4qlQEj1dqSmpj4ytsY6tw36YlTYTNsrKJUcN/vACJmhWuuqYKzOaEYL1AeNYaIphPPZqrZj2v
 s/I4Z/cKVTb2rM0PvWSUpJWTaPWohfpzIsr6m8ZQ==
X-Gm-Gg: Acq92OEnn1DDJPXtuNkOUFG+MqYU8lIxoXqkYYruXu8ArS0KMR6eH7YGbsLnQXAXIa3
 5PrRgRiB3cw7SDtitSZ8BKITwurFUK/wyywxlYhz9Q0iidERNSZTlBxEbipjHZ2dVm6IjkThW8u
 xwL93UGbZJ++6wvAq3ngx4XAkv2WiFXzaYo9h50gDZ2hrT9pqROXIgN/B/PMe36kl9xLayMShB8
 8K4F62uJr8hnUk8qRCJaLGYwexfwA+0+gV7WP0xOn2lIYI7EoQuM1oVZwC48/+bdpF/PwwYDKqF
 Fje7T8PIkVwxdMTQWPN8zF9Mxy8T9yDZKynoHJvKGoSQO0fPC1/ABa2rlHcqRMowwXOVIufNS/4
 5cXROlISFjnnUw8PfEDBm9BFUxygCDEzF2Pk4+aWjWrsQ
X-Received: by 2002:a05:6214:590f:b0:8c7:76cf:5088 with SMTP id
 6a1803df08f44-8cc6e205d13mr6190846d6.0.1779312891174; 
 Wed, 20 May 2026 14:34:51 -0700 (PDT)
X-Received: by 2002:a05:6214:590f:b0:8c7:76cf:5088 with SMTP id
 6a1803df08f44-8cc6e205d13mr6190166d6.0.1779312890419; 
 Wed, 20 May 2026 14:34:50 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 20/29] tests/qtest/migration: Stop passing URI into
 migrate_start
Date: Wed, 20 May 2026 17:33:48 -0400
Message-ID: <20260520213357.40646-21-peterx@redhat.com>
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

Don't allow changing the default -incoming URI via migrate_start. The
default is now -incoming defer. If a test really needs to alter this
(such as with CPR), the target_opts variable is still available to
change the command line.

(aside from the larger goal of using defer, this change is a step
towards allowing migrate_start() to be invoked only once for all
tests)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260505160915.25558-15-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.h     |  5 ++---
 tests/qtest/migration/colo-tests.c    |  2 +-
 tests/qtest/migration/cpr-tests.c     |  6 +++---
 tests/qtest/migration/file-tests.c    |  3 +--
 tests/qtest/migration/framework.c     | 17 ++++++++---------
 tests/qtest/migration/misc-tests.c    | 10 +++++-----
 tests/qtest/migration/precopy-tests.c | 12 ++++++------
 7 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 8d5331a860..d7e5db2cfe 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -231,9 +231,8 @@ void wait_for_serial(const char *side);
 void migrate_prepare_for_dirty_mem(QTestState *from);
 void migrate_wait_for_dirty_mem(QTestState *from, QTestState *to);
 
-int migrate_args(char **from, char **to, const char *uri, MigrateStart *args);
-int migrate_start(QTestState **from, QTestState **to, const char *uri,
-                  MigrateStart *args);
+int migrate_args(char **from, char **to, MigrateStart *args);
+int migrate_start(QTestState **from, QTestState **to, MigrateStart *args);
 void migrate_end(QTestState *from, QTestState *to, bool test_dest);
 
 void test_postcopy_common(MigrateCommon *args);
diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/colo-tests.c
index 4add4a014b..a3d27e7bf6 100644
--- a/tests/qtest/migration/colo-tests.c
+++ b/tests/qtest/migration/colo-tests.c
@@ -45,7 +45,7 @@ static int test_colo_common(MigrateCommon *args,
     args->start.caps[MIGRATION_CAPABILITY_RETURN_PATH] = true;
     args->start.caps[MIGRATION_CAPABILITY_X_COLO] = true;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return -1;
     }
 
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 9091a84213..fc09dad9c0 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -60,7 +60,7 @@ static int test_transfer(MigrateCommon *args, const char *cpr_channel,
     obj = migrate_str_to_channel(cpr_channel);
     qlist_append(channels_list, obj);
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return -1;
     }
 
@@ -179,7 +179,7 @@ static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
      */
     g_assert(args->start.hide_stderr == false);
 
-    ret = migrate_args(&from_args, &to_args, args->listen_uri, &args->start);
+    ret = migrate_args(&from_args, &to_args, &args->start);
     g_assert(!ret);
     qtest_from_args = qtest_qemu_args(from_args);
 
@@ -230,7 +230,7 @@ static void test_cpr_exec(MigrateCommon *args)
     g_autofree char *filename = g_strdup_printf("%s/%s", tmpfs,
                                                 FILE_TEST_FILENAME);
 
-    if (migrate_start(&from, NULL, "defer", &args->start)) {
+    if (migrate_start(&from, NULL, &args->start)) {
         return;
     }
 
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 4b6a2eeb7b..36109d30ba 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -47,8 +47,7 @@ static void test_file_connect_outgoing_fd_leak(char *name, MigrateCommon *args)
         return;
     }
 
-    args->listen_uri = "defer";
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index b1bf8ea8ae..b92e6b7df1 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -308,7 +308,7 @@ static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
     return opts;
 }
 
-int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
+int migrate_args(char **from, char **to, MigrateStart *args)
 {
     /* options for source and target */
     g_autofree gchar *arch_opts = NULL;
@@ -423,11 +423,11 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
                                  "-name target,debug-threads=on "
                                  "%s "
                                  "-serial file:%s/dest_serial "
-                                 "-incoming %s "
+                                 "-incoming defer "
                                  "%s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
-                                 memory_backend, tmpfs, uri,
+                                 memory_backend, tmpfs,
                                  events,
                                  arch_opts ? arch_opts : "",
                                  args->opts_target ? args->opts_target : "",
@@ -474,8 +474,7 @@ static void migrate_mem_type_cleanup(MemType type)
     }
 }
 
-int migrate_start(QTestState **from, QTestState **to, const char *uri,
-                  MigrateStart *args)
+int migrate_start(QTestState **from, QTestState **to, MigrateStart *args)
 {
     g_autofree gchar *cmd_source = NULL;
     g_autofree gchar *cmd_target = NULL;
@@ -490,7 +489,7 @@ int migrate_start(QTestState **from, QTestState **to, const char *uri,
     bootfile_create(qtest_get_arch(), tmpfs, args->suspend_me);
     src_state.suspend_me = args->suspend_me;
 
-    if (migrate_args(&cmd_source, &cmd_target, uri, args)) {
+    if (migrate_args(&cmd_source, &cmd_target, args)) {
         return -1;
     }
 
@@ -563,7 +562,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_BLOCKTIME] = true;
     args->start.caps[MIGRATION_CAPABILITY_POSTCOPY_RAM] = true;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return -1;
     }
 
@@ -842,7 +841,7 @@ int test_precopy_common(MigrateCommon *args)
         args->listen_uri = "tcp:127.0.0.1:0";
     }
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return -1;
     }
 
@@ -991,7 +990,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
     bool check_offset = false;
     g_autofree char *uri = NULL;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
index 8216b5d79d..e5d5fc4959 100644
--- a/tests/qtest/migration/misc-tests.c
+++ b/tests/qtest/migration/misc-tests.c
@@ -28,7 +28,7 @@ static void test_baddest(char *name, MigrateCommon *args)
 
     args->start.hide_stderr = true;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
@@ -54,7 +54,7 @@ static void test_analyze_script(char *name, MigrateCommon *args)
         return;
     }
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
@@ -115,7 +115,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    if (migrate_start(&from, &to, "defer", args)) {
+    if (migrate_start(&from, &to, args)) {
         return;
     }
 
@@ -180,7 +180,7 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     QTestState *from, *to;
     QObject *channels;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
@@ -234,7 +234,7 @@ static void test_validate_caps_pair(char *test_path, MigrateCommon *args)
     args->start.hide_stderr = true;
     args->start.only_source = true;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index e915b21712..3161e5f247 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -268,7 +268,7 @@ static void test_auto_converge(char *name, MigrateCommon *args)
     int64_t percentage;
     const int64_t init_pct = 5, inc_pct = 25, max_pct = 95;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
@@ -414,7 +414,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
 
     args->start.hide_stderr = true;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
@@ -460,7 +460,7 @@ static void test_multifd_tcp_cancel(MigrateCommon *args, bool postcopy_ram)
 
     args->start.only_target = true;
 
-    if (migrate_start(&from, &to2, "defer", &args->start)) {
+    if (migrate_start(&from, &to2, &args->start)) {
         return;
     }
 
@@ -634,7 +634,7 @@ static void test_cancel_src_after_status(char *test_path, MigrateCommon *args)
 
     args->start.hide_stderr = true;
 
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
@@ -973,7 +973,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     args->connect_uri = uri;
 
     /* Start src, dst vm */
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
@@ -1021,7 +1021,7 @@ static void test_dirty_limit(char *name, MigrateCommon *args)
     args->start.use_dirty_ring = true;
 
     /* Restart dst vm, src vm already show up so we needn't wait anymore */
-    if (migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, &args->start)) {
         return;
     }
 
-- 
2.53.0


