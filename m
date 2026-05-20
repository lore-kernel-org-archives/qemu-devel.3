Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8C1CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYh-00014o-04; Wed, 20 May 2026 17:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYf-00014a-L4
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYd-0007EO-Pd
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YWmF5fN1VlC2+bo+SJfWP6rjbL3xgW5S3LDV2GwmYOQ=;
 b=PLNfxeWmIrC2Id+OFNI3zu68gt3yc8618A8vqRLb2p9ucyv9BpN0RF8PfnRJA+HDtYAqqY
 NxWg8pyaHoGO1jfBhZOd9devshQOKwtNpsct+2TBLJ3DBHQveCdlnd84fXfy5F7NZhkQQM
 qOhLqK2j3A4jLSlZ0oSj0qjQ/W8o/SU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-lvVp7QZfOamN_MWcu8OZbw-1; Wed, 20 May 2026 17:34:25 -0400
X-MC-Unique: lvVp7QZfOamN_MWcu8OZbw-1
X-Mimecast-MFC-AGG-ID: lvVp7QZfOamN_MWcu8OZbw_1779312865
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-910b2b92741so1018988785a.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312865; x=1779917665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWmF5fN1VlC2+bo+SJfWP6rjbL3xgW5S3LDV2GwmYOQ=;
 b=U28UG2nHU6LtcM1juxiYkbF946FCRg2fvljkH7M8sZA7OOkLsy93umJvpD1KNrskug
 Tu9DLHVP2XU5rgXayTsJgfonDUo8/fIGNVnC/y6xEcdj7DkkPaoYGijmrpomUaCVClPa
 ExbSDQ0qdGUbeqSdlvwSTizsx7Nze/IpEdxbrD5DlodDyvtBxvhRFmffsxZ07KjE7Qjc
 axohsjIfcA9Lq3c7VI4pqHyaef2oEfbAVNqB6mU5ARvwkyWBgeHH7OxGnBrmvrEFvPYl
 hE0r3/t7vtcd9Yq+0ocsWfWxpQgtvzx+tJVyhheLNc+XIjNaXHVAn1bBlk39M3nfLLh6
 rJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312865; x=1779917665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YWmF5fN1VlC2+bo+SJfWP6rjbL3xgW5S3LDV2GwmYOQ=;
 b=VMKwnXGjPKnjGpUGYqUMo9l1w+V/wuMstBw/xX/qw2tqv8L4o9cd90YZiIJG6nR//c
 t2Vl3LJ90rJ/ICZrD1w7rysC6C4mt/it+TdVGI+6fs+Q4sJklZ7lZh2p0SxngxcTZA0r
 TDSQYo2oeZMbenZ/levGuS5f8Lgp4Mr7g55bIBtpCGCO4wXae3u2bvGKVrJww9CYUI9r
 Cwr4XkCqLTXgXunYAh86dWrMWsCLQws2SWAsKyVkpXomS690O1ahr8xbzjGFxfyCHBFc
 2zWTKail7VsBNFeqDK3kGAldKtrtBmWblkXP17d95ZPrV2IC5yOZNW7T7FVqPirzFHZ8
 bliw==
X-Gm-Message-State: AOJu0YyZhtBKrQLD2qlB4jiPaD8tnePZCr8vxunHdZA7/RrCPpB9oTCg
 OY2N73G0L/JsqmqO0XsK4tq6hYzku4wwC6ynXlJ2d+cGPS2o/hvgzF/lzyV52soZ6d5+323ppvL
 gbSFmERXzJlZk8iXHZWHRiz0xsWJQ7S13nVc5+ZDpm/u3V+qwHOaTYdBfdAAOZ8rzy7VIM9GdXB
 PpZhtn+Tlzi5zgLR0rQ2OoGu/7ecwGgN1zzIncjw==
X-Gm-Gg: Acq92OFW/nxeB0lpeI0WnihGhouZpKR6tycZWhJk4TX1NFJlSGgk3jcyzdgIhlJraf5
 1THGHNMh2Q3lKzS6mUSq93ZE7Jb2qDL2Qj3T79jpThttCew5k6INzaQH9hlCqDKtE0QAJ35+ptz
 wJjnhfPsqsc3BqqtVH1ECPsJXSfNsV0Ng6JJ6VBxMtoaZnjZgx5QY1dkl4+O3OOt518bR4sJwIx
 /0xTMzfHBZUd0UNym2dXgJIuB5o6xTxROTpAjRqtmWuTnAWPF6dbheDvlGynX/BSUnJ9NvZ/79h
 sONd44LsFvlqLpICxfl9iBaTTgvTlUgTq9PZKVkQzaJI/iSTOjS+lt5q1mRhJJ7esV5tkBMAYqo
 9glOkPnXzMIVV1zDYVRiQQ8YVrWt52gxz993CpOAsQswp
X-Received: by 2002:a05:620a:4611:b0:910:2fea:c17c with SMTP id
 af79cd13be357-914a2328724mr34252985a.19.1779312864963; 
 Wed, 20 May 2026 14:34:24 -0700 (PDT)
X-Received: by 2002:a05:620a:4611:b0:910:2fea:c17c with SMTP id
 af79cd13be357-914a2328724mr34248085a.19.1779312864356; 
 Wed, 20 May 2026 14:34:24 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 08/29] tests/qtest/migration: Make file-tests defer by default
Date: Wed, 20 May 2026 17:33:36 -0400
Message-ID: <20260520213357.40646-9-peterx@redhat.com>
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

All file: tests use listen_uri="defer". Make this the default in the
common function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260505160915.25558-3-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/cpr-tests.c  |  1 -
 tests/qtest/migration/file-tests.c | 14 --------------
 tests/qtest/migration/framework.c  |  2 +-
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 48c98f0089..18217f0460 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -36,7 +36,6 @@ static void test_mode_reboot(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_mode_reboot;
 
     args->start.mem_type = MEM_TYPE_SHMEM;
diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index fef172068f..75135447f8 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -70,8 +70,6 @@ static void test_precopy_file(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
-
     test_file_common(args, true);
 }
 
@@ -114,7 +112,6 @@ static void test_precopy_file_offset_fdset(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_file_offset_fdset;
 
     test_file_common(args, false);
@@ -128,8 +125,6 @@ static void test_precopy_file_offset(char *name, MigrateCommon *args)
                                            FILE_TEST_OFFSET);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
-
     test_file_common(args, false);
 }
 
@@ -140,7 +135,6 @@ static void test_precopy_file_offset_bad(char *name, MigrateCommon *args)
                                            tmpfs, FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
     args->result = MIG_TEST_QMP_ERROR;
 
     test_file_common(args, false);
@@ -152,7 +146,6 @@ static void test_precopy_file_mapped_ram_live(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
 
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
@@ -165,7 +158,6 @@ static void test_precopy_file_mapped_ram(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
 
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
@@ -177,7 +169,6 @@ static void test_multifd_file_mapped_ram_live(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
@@ -191,7 +182,6 @@ static void test_multifd_file_mapped_ram(char *name, MigrateCommon *args)
                                            FILE_TEST_FILENAME);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
 
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
@@ -213,7 +203,6 @@ static void test_multifd_file_mapped_ram_dio(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_mapped_ram_dio;
 
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
@@ -285,7 +274,6 @@ static void test_multifd_file_mapped_ram_fdset(char *name, MigrateCommon *args)
                                            FILE_TEST_OFFSET);
 
     args->connect_uri = uri;
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_mapped_ram_fdset;
     args->end_hook = migrate_hook_end_multifd_mapped_ram_fdset;
 
@@ -301,7 +289,6 @@ static void test_multifd_file_mapped_ram_fdset_dio(char *name,
     g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=%d",
                                            FILE_TEST_OFFSET);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
     args->start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio;
     args->end_hook = migrate_hook_end_multifd_mapped_ram_fdset;
 
@@ -332,7 +319,6 @@ test_precopy_file_mapped_ram_ignore_shared(char *name, MigrateCommon *args)
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
     args->connect_uri = uri;
-    args->listen_uri = "defer";
 
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
     args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 4cd07be1d5..a0c80c0a61 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -972,7 +972,7 @@ void test_file_common(MigrateCommon *args, bool stop_src)
     void *data_hook = NULL;
     bool check_offset = false;
 
-    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
 
-- 
2.53.0


