Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59400CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYt-0001Gx-FC; Wed, 20 May 2026 17:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYs-0001GE-1z
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYp-0007HO-Ej
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOHplUY4YxSEbwAdUtwP8OIXWY9Sz4byjeqRgy2OfZQ=;
 b=TKP9X5k81Dl/Phfze5JugMaSAQGUp/ZaqGi99UTa13Q6jm/++tHxb8hFviPDSML1bAH35P
 Oqo3b1CWtbBVxTc3HiPngjso0R+hb5D0dAmJrkPpocr8FOa1/+C/9G9MH9MASRUO0FfAYT
 /gEV9Vah+akp7kO/yivGrfaahDrVehI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-T_0iM7kEOau7i0kwCDQsgA-1; Wed, 20 May 2026 17:34:37 -0400
X-MC-Unique: T_0iM7kEOau7i0kwCDQsgA-1
X-Mimecast-MFC-AGG-ID: T_0iM7kEOau7i0kwCDQsgA_1779312877
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8cc0e037fe5so24588636d6.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312876; x=1779917676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dOHplUY4YxSEbwAdUtwP8OIXWY9Sz4byjeqRgy2OfZQ=;
 b=MMI3DDBkIBaFFzF6Rz7uT7M4eWPG5eQHVg9BLJ7KT9dhn3o0q8dIEu9mKSDJzo2nxX
 z4iomk8T15fx/bTLVDDUXAeRFXbYsUm2Zi9IFcGusHxuBDESfzNj3s7Vy4a6xZHJ78dN
 XzAp5fBXDWTfFny93uuG47QaxWUVOg2YGMwfPZ+al9qnSgbmm3pWW/QiQecvdwSwlGbt
 Tp8nLmuDLOv48lA8uS3E7Ng/QuaoSUoyWv5duojdO+pf3poxB1Ynb3OIEVPL4mzJEAub
 /GEjPWGy1veq8W4KPKwjhpXPGDQIV0LrSAvP+nh9eUxf6s8aFzi+pQn9GEM25trNjWBm
 +kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312876; x=1779917676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dOHplUY4YxSEbwAdUtwP8OIXWY9Sz4byjeqRgy2OfZQ=;
 b=K3sdMZRgPW0rfIfzIP0Mt5KIRRxmHaSy1ClE8tLSkOPO6a6nkmm6Y1PhDfh8NWMBZx
 EhkEVfAdxLp4sNEtZk45+gWmtduVr7vanGmmZtGRj/mi4ev6+I3b0HfvoP5vk9HPlf67
 Yc6bzBS5LAcIpgJl26XBLkC/nnOTWnzbx80LgcUTl4p+kmImEaUg9hsMkyRpVMtt+fhs
 EJk0JJ+/IygMVxqviI5cHJq7Hu9mds84SLBXrzOPq99EBj7LQe6nuf15CkFqOs9ayjHI
 /VzAAuPTpYRvYzn83P4MTuwJ4Y1pscenVQrmMcNhoz0ysTRQPmKdj0TI6dPFA0tHpjRk
 2UBw==
X-Gm-Message-State: AOJu0YyPaZgeyNqplEuPWYJCCkmaeHF4ChGatTBKib5B/zbKt1U/Puyy
 a0ISR+0DvgvckxJCeH8EMQU59k7AvyFALhGXMrmBw8DwJdgQUixvXsuRiOmOKlZ9zcAamGgoIpy
 J4PI7yNuuDh37gtQfAGSDL49WbDtVoWmXzTBrPTmqjwzy+UmUqFi3JVYXksa5+7zmUWVajQAxGX
 l9x4I2l3h0hcFDd/5aSObZqaSNE0vQ+KMXMANszA==
X-Gm-Gg: Acq92OG9C4P3j0wkwrYMh4mgOrjesdtJDrOVCCAhGzXe7WISb3lbKIhHCf7/833gNqu
 GEmwPTtOyF8ew9fKb0OAJl0ZeBphJD9+T8zHTAd5h/rDxDZKjaUtfaIPGSbxFx91ZLaIaUFeqFT
 3Eaad2ZuU0NGstrsUdhukCwOjWty1Uif92rIy62hFD8lkar8z8tRaEVI95PmYpjS+ZWDDrGp7/p
 YE23bgRXDRjBxYTyUHd4YkaJcK6JxuqIisWba0TlWSf9XAWVXn84uk4fx1UkrAJw1B05G+9zd0p
 HA+7RoVBzxgmXX0WtdvSDAaavGp2QZvFWk1K/xvM0oTiqmUVtSNA3f9YYS9NgT9LcJUuhei9W/y
 sbrHH/lo86/q8zhR9nbt3HL/iHhC/xyp+lpB743scbTqHJAUMjiJUPAw=
X-Received: by 2002:a05:6214:568e:b0:8be:3c37:5e6a with SMTP id
 6a1803df08f44-8cc6e327f92mr5364996d6.21.1779312876030; 
 Wed, 20 May 2026 14:34:36 -0700 (PDT)
X-Received: by 2002:a05:6214:568e:b0:8be:3c37:5e6a with SMTP id
 6a1803df08f44-8cc6e327f92mr5363966d6.21.1779312875327; 
 Wed, 20 May 2026 14:34:35 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:33 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 13/29] tests/qtest/migration: Defer by default in precopy_common
Date: Wed, 20 May 2026 17:33:41 -0400
Message-ID: <20260520213357.40646-14-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As a design direction, we're restricting the usage of the command line
option -incoming <URI>. The alternative -incoming defer should be used
instead.

Make all precopy_common tests defer by default.

Using the defer option means that QEMU will not start the incoming
migration automatically. Add the incoming QMP command. With the added
command, the invocation at the multifd_common hook becomes redundant,
so remove it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Link: https://lore.kernel.org/r/20260505160915.25558-8-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/colo-tests.c        | 12 ++++--------
 tests/qtest/migration/compression-tests.c |  6 ------
 tests/qtest/migration/framework.c         | 15 ++++++++-------
 tests/qtest/migration/precopy-tests.c     | 11 +----------
 tests/qtest/migration/tls-tests.c         | 15 +--------------
 5 files changed, 14 insertions(+), 45 deletions(-)

diff --git a/tests/qtest/migration/colo-tests.c b/tests/qtest/migration/colo-tests.c
index ef880f5114..4add4a014b 100644
--- a/tests/qtest/migration/colo-tests.c
+++ b/tests/qtest/migration/colo-tests.c
@@ -45,7 +45,7 @@ static int test_colo_common(MigrateCommon *args,
     args->start.caps[MIGRATION_CAPABILITY_RETURN_PATH] = true;
     args->start.caps[MIGRATION_CAPABILITY_X_COLO] = true;
 
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return -1;
     }
 
@@ -55,6 +55,8 @@ static int test_colo_common(MigrateCommon *args,
         data_hook = args->start_hook(from, to);
     }
 
+    migrate_incoming_qmp(to, args->listen_uri, NULL, "{}");
+
     migrate_ensure_converge(from);
     wait_for_serial("src_serial");
 
@@ -107,17 +109,11 @@ static void test_colo_plain_common(MigrateCommon *args,
     test_colo_common(args, failover_during_checkpoint, primary_failover);
 }
 
-static void *hook_start_multifd(QTestState *from, QTestState *to)
-{
-    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
-}
-
 static void test_colo_multifd_common(MigrateCommon *args,
                                      bool failover_during_checkpoint,
                                      bool primary_failover)
 {
-    args->listen_uri = "defer";
-    args->start_hook = hook_start_multifd;
+    args->listen_uri = "tcp:127.0.0.1:0";
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     test_colo_common(args, failover_during_checkpoint, primary_failover);
 }
diff --git a/tests/qtest/migration/compression-tests.c b/tests/qtest/migration/compression-tests.c
index 7f2856b7f8..134bf44db6 100644
--- a/tests/qtest/migration/compression-tests.c
+++ b/tests/qtest/migration/compression-tests.c
@@ -33,7 +33,6 @@ migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
 
 static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -43,7 +42,6 @@ static void test_multifd_tcp_zstd(char *name, MigrateCommon *args)
 
 static void test_multifd_postcopy_tcp_zstd(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -66,7 +64,6 @@ migrate_hook_start_precopy_tcp_multifd_qatzip(QTestState *from,
 
 static void test_multifd_tcp_qatzip(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -85,7 +82,6 @@ migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *from,
 
 static void test_multifd_tcp_qpl(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_qpl;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -104,7 +100,6 @@ migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
 
 static void test_multifd_tcp_uadk(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_uadk;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
@@ -152,7 +147,6 @@ migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
 
 static void test_multifd_tcp_zlib(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zlib;
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 566437c17f..5da39eac76 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -834,11 +834,15 @@ int test_precopy_common(MigrateCommon *args)
     void *data_hook = NULL;
     QObject *channels = NULL;
 
-    if (!args->listen_uri) {
+    assert(!args->connect_uri);
+
+    if (args->listen_uri) {
+        args->connect_uri = args->listen_uri;
+    } else {
         args->listen_uri = "tcp:127.0.0.1:0";
     }
 
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return -1;
     }
 
@@ -846,6 +850,8 @@ int test_precopy_common(MigrateCommon *args)
         data_hook = args->start_hook(from, to);
     }
 
+    migrate_incoming_qmp(to, args->listen_uri, NULL, "{}");
+
     /* Wait for the first serial output from the source */
     if (args->result == MIG_TEST_SUCCEED) {
         wait_for_serial("src_serial");
@@ -943,7 +949,6 @@ void test_precopy_unix_common(MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
 
     args->listen_uri = uri;
-    args->connect_uri = uri;
     test_precopy_common(args);
 }
 
@@ -1064,10 +1069,6 @@ void *migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
 {
     migrate_set_parameter_str(from, "multifd-compression", method);
     migrate_set_parameter_str(to, "multifd-compression", method);
-
-    /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
-
     return NULL;
 }
 
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 377597bc29..b73b73a807 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -162,7 +162,6 @@ static void __test_precopy_rdma_plain(MigrateCommon *args, bool ipv6)
     g_autofree char *uri = g_strdup_printf("rdma:%s:29200", buffer);
 
     args->listen_uri = uri;
-    args->connect_uri = uri;
 
     test_precopy_common(args);
 }
@@ -214,9 +213,6 @@ static void *migrate_hook_start_fd(QTestState *from,
                                  "  'arguments': { 'fdname': 'fd-mig' }}");
     close(pair[0]);
 
-    /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "fd:fd-mig", NULL, "{}");
-
     /* Send the 2nd socket to the target */
     qtest_qmp_fds_assert_success(from, &pair[1], 1,
                                  "{ 'execute': 'getfd',"
@@ -257,8 +253,7 @@ static void migrate_hook_end_fd(QTestState *from,
 
 static void test_precopy_fd_socket(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
-    args->connect_uri = "fd:fd-mig";
+    args->listen_uri = "fd:fd-mig";
     args->start_hook = migrate_hook_start_fd;
     args->end_hook = migrate_hook_end_fd;
 
@@ -354,7 +349,6 @@ migrate_hook_start_precopy_tcp_multifd_no_zero_page(QTestState *from,
 
 static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd;
     /*
      * Multifd is more complicated than most of the features, it
@@ -370,7 +364,6 @@ static void test_multifd_tcp_uri_none(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy;
     /*
      * Multifd is more complicated than most of the features, it
@@ -386,7 +379,6 @@ static void test_multifd_tcp_zero_page_legacy(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd_no_zero_page;
     /*
      * Multifd is more complicated than most of the features, it
@@ -402,7 +394,6 @@ static void test_multifd_tcp_no_zero_page(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_channels_none(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_precopy_tcp_multifd;
     args->live = true;
     args->connect_channels = ("[ { 'channel-type': 'main',"
diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 4a3c404349..275d0b84d4 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -436,8 +436,7 @@ static void test_precopy_unix_tls_x509_default_host(char *name,
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
 
-    args->connect_uri = uri;
-    args->listen_uri = "defer";
+    args->listen_uri = uri;
     args->start_hook = migrate_hook_start_tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
@@ -511,8 +510,6 @@ migrate_hook_start_tls_x509_no_host(QTestState *from, QTestState *to)
 
 static void test_precopy_tcp_tls_no_hostname(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
-    args->connect_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_no_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
@@ -544,8 +541,6 @@ static void test_precopy_tcp_tls_x509_override_host(char *name,
 static void test_precopy_tcp_tls_x509_mismatch_host(char *name,
                                                     MigrateCommon *args)
 {
-    args->listen_uri = "defer";
-    args->connect_uri = "tcp:127.0.0.1:0";
     args->start_hook = migrate_hook_start_tls_x509_mismatch_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
@@ -658,7 +653,6 @@ migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
 
 static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
@@ -669,7 +663,6 @@ static void test_multifd_tcp_tls_psk_match(char *name, MigrateCommon *args)
 
 static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch;
     args->end_hook = migrate_hook_end_tls_psk;
     args->result = MIG_TEST_FAIL;
@@ -683,7 +676,6 @@ static void test_multifd_tcp_tls_psk_mismatch(char *name, MigrateCommon *args)
 static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
                                                     MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tcp_tls_psk_match;
     args->end_hook = migrate_hook_end_tls_psk;
 
@@ -697,7 +689,6 @@ static void test_multifd_postcopy_tcp_tls_psk_match(char *name,
 static void test_multifd_tcp_tls_x509_default_host(char *name,
                                                    MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_default_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
@@ -709,7 +700,6 @@ static void test_multifd_tcp_tls_x509_default_host(char *name,
 static void test_multifd_tcp_tls_x509_override_host(char *name,
                                                     MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_override_host;
     args->end_hook = migrate_hook_end_tls_x509;
 
@@ -734,7 +724,6 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
      * to load migration state, and thus just aborts the migration
      * without exiting.
      */
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
@@ -748,7 +737,6 @@ static void test_multifd_tcp_tls_x509_mismatch_host(char *name,
 static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
                                                         MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
 
@@ -760,7 +748,6 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(char *name,
 static void test_multifd_tcp_tls_x509_reject_anon_client(char *name,
                                                          MigrateCommon *args)
 {
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client;
     args->end_hook = migrate_hook_end_tls_x509;
     args->result = MIG_TEST_FAIL;
-- 
2.53.0


