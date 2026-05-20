Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DFCCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYj-00015H-O7; Wed, 20 May 2026 17:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYi-000156-DW
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYg-0007Es-Mz
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBZX6Cd4M/StAr5hUusYmsPDgqcbX8TIuXk4ahCxk/s=;
 b=ebBnstzyy8GL+CKOVEAlB2IA4x+LBI4Egihdln1ltOdH4yPHqtuS7xSm8fN/vU6NS0JPQF
 1PsCqncyOIU3GaGwmPAjkoXBbl8eNho0GwXfj/PJ5zGcRcaZ/9/MwePl+O3CNmvuuMQBU5
 rEwO3t5hPNXLM30U72VbMve5ca6ulWM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-E_sJRhY4P_OhLlkdIi4vGQ-1; Wed, 20 May 2026 17:34:28 -0400
X-MC-Unique: E_sJRhY4P_OhLlkdIi4vGQ-1
X-Mimecast-MFC-AGG-ID: E_sJRhY4P_OhLlkdIi4vGQ_1779312867
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d8e8c47a3so18584681cf.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312867; x=1779917667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBZX6Cd4M/StAr5hUusYmsPDgqcbX8TIuXk4ahCxk/s=;
 b=rNBJMXfSaEptv+7PCgV0YPVaQT8gJbRWxDC92dE8fUcESFMq+TelFYYmTlVZxKA2fL
 aRR+QioJNFPfgXDvxdgTSAZhY/OQUB40OUb8FKfrDbLbNLl0CUaVvk5prjb15nTZifP9
 Oa39R/sRJVuUICfElL1NNOPSFzidAH8S8Y03e6Bhp2+ZEHFk4tWcb49mgSe4Gv9iL2M6
 mBrcZPF8i+HiOX4x9bh7BF+It3wqKrg1pK2oVktK+suop2Tqr+lJyc7w0GdLNM2p/UQn
 dU32PJ9oC91/jMnY6Ugjdp2XUYk5bcOVtJdznFxKgL1wXTE264qGzcKID7BQ4ak5G6Xn
 DT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312867; x=1779917667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wBZX6Cd4M/StAr5hUusYmsPDgqcbX8TIuXk4ahCxk/s=;
 b=Xj0+S9DPuq++tsgGWiNKOx5yw28gFwHLIuCxKlsk/SdxKLGLXbPVuuhwG5wwyOswsO
 5LFp+OH8RhvKdV2wGfmI4Vl8QPQLo6CpErh9AocIunIFsiSekFtCAZ7yYb2Q8VbowRzd
 B1W7MGV1mzF9ySSw5KNCIoHHvfjhzZ0ecg41M/a24hogsMru+CCBfucV/r3SAKtGJz4h
 YkBJrbo6e56tZ7xEfEk/O4YciVyXMfWxzmV27x+SW+XKZqxn25sgZAfspJvpqEBou05f
 LMQns0U98TabgLGeosri3gZFyyOOvgD/iFM1yD8g4cQPkTPe4lMZ5Lhzl/8BCano3zui
 74bg==
X-Gm-Message-State: AOJu0YxAJa426SyZASf8bLrLJRjLchn8FPICvX2BBS+HUQ5pixUi4uH1
 t6uIEaGD9zxz0UJb5BsP+/loECBlpNYJf6LaVrIvNGoRggOw5mAS9Mxr8eoglqJqL5Q27GLk4zr
 LfvnHJ7+LJRDn9ilCpOpQhTGOY34OUw9ktnXWO/jydmriC9xVGHWuZ48fjxH6sn7dGjXXO7AdqA
 SY5ijg2XOFB7Qhk9Unkmp+8r+1aQW0Tp7QIvTFng==
X-Gm-Gg: Acq92OGoHX8F/ed/AQdbHcCE30lYTqLfzYkhpCW055EspNEyfis1DtUPEJwdkwQCvSY
 ufUSLVTyMEoreh4N34KduOfd03EumGmraFxCsxTk9S/dVzxjHvlMeihRWOQ+6JSf0Fkykjl8134
 O0xm7NQYPlwQTP3cZyC+vXc2gVAM2llZFRADA5i61tl/R7HNzrPxaIUWEvRpYfOCeVOjN9RjQS7
 bvs24kM3iv0cBQ/hSsDUJm8KYrkVySTtyeg+8AXTgwNquS6V5PnJ7oKrOeJvT7r+0oX8+CDfhrW
 GdYb7bVRJ5cnK8G/clccqiVUURoLAV3W1sbGAhtU+WHsqoB5dKLCder7Gbmft7XZ5QwOYj+OGuz
 AcJYwLPUoxIT46OBW54tBxB7mL02VsOTeTJYG8rxU9Ctd
X-Received: by 2002:a05:622a:182a:b0:50d:3eac:8466 with SMTP id
 d75a77b69052e-516c5512732mr3505161cf.30.1779312867264; 
 Wed, 20 May 2026 14:34:27 -0700 (PDT)
X-Received: by 2002:a05:622a:182a:b0:50d:3eac:8466 with SMTP id
 d75a77b69052e-516c5512732mr3504541cf.30.1779312866638; 
 Wed, 20 May 2026 14:34:26 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 09/29] tests/qtest/migration: Set file URI by default
Date: Wed, 20 May 2026 17:33:37 -0400
Message-ID: <20260520213357.40646-10-peterx@redhat.com>
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

Most file: tests use the same URI. Make it a default in the common
function.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20260505160915.25558-4-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/file-tests.c | 29 -----------------------------
 tests/qtest/migration/framework.c  |  6 ++++++
 2 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/migration/file-tests.c b/tests/qtest/migration/file-tests.c
index 75135447f8..4b6a2eeb7b 100644
--- a/tests/qtest/migration/file-tests.c
+++ b/tests/qtest/migration/file-tests.c
@@ -67,9 +67,6 @@ static void test_file_connect_outgoing_fd_leak(char *name, MigrateCommon *args)
 
 static void test_precopy_file(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    args->connect_uri = uri;
     test_file_common(args, true);
 }
 
@@ -142,11 +139,6 @@ static void test_precopy_file_offset_bad(char *name, MigrateCommon *args)
 
 static void test_precopy_file_mapped_ram_live(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-
-    args->connect_uri = uri;
-
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
     test_file_common(args, false);
@@ -154,11 +146,6 @@ static void test_precopy_file_mapped_ram_live(char *name, MigrateCommon *args)
 
 static void test_precopy_file_mapped_ram(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-
-    args->connect_uri = uri;
-
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
     test_file_common(args, true);
@@ -166,10 +153,6 @@ static void test_precopy_file_mapped_ram(char *name, MigrateCommon *args)
 
 static void test_multifd_file_mapped_ram_live(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    args->connect_uri = uri;
-
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
@@ -178,11 +161,6 @@ static void test_multifd_file_mapped_ram_live(char *name, MigrateCommon *args)
 
 static void test_multifd_file_mapped_ram(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-
-    args->connect_uri = uri;
-
     args->start.caps[MIGRATION_CAPABILITY_MULTIFD] = true;
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
 
@@ -200,9 +178,6 @@ static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
 
 static void test_multifd_file_mapped_ram_dio(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    args->connect_uri = uri;
     args->start_hook = migrate_hook_start_multifd_mapped_ram_dio;
 
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
@@ -316,10 +291,6 @@ static void migration_test_add_file_smoke(MigrationTestEnv *env)
 static void
 test_precopy_file_mapped_ram_ignore_shared(char *name, MigrateCommon *args)
 {
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    args->connect_uri = uri;
-
     args->start.caps[MIGRATION_CAPABILITY_MAPPED_RAM] = true;
     args->start.caps[MIGRATION_CAPABILITY_X_IGNORE_SHARED] = true;
 
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index a0c80c0a61..3802c6f57d 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -971,11 +971,17 @@ void test_file_common(MigrateCommon *args, bool stop_src)
     QTestState *from, *to;
     void *data_hook = NULL;
     bool check_offset = false;
+    g_autofree char *uri = NULL;
 
     if (migrate_start(&from, &to, "defer", &args->start)) {
         return;
     }
 
+    if (!args->connect_uri) {
+        uri = g_strdup_printf("file:%s/%s", tmpfs, FILE_TEST_FILENAME);
+        args->connect_uri = uri;
+    }
+
     /*
      * File migration is never live. We can keep the source VM running
      * during migration, but the destination will not be running
-- 
2.53.0


