Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA8BCFC516
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 01:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMckc-0001BD-H5; Fri, 21 Nov 2025 20:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTT-0006eV-Sz
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTJ-0003fu-Ip
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkmroyYCTEEZf3ECgpF/Q+QP6WnX41hH0GBpOgZMfpk=;
 b=LUWrG0eW/y960hRITViuys67Ze2+fiTrNTE8BIamyjuIMiYFgBRra0abEsAZ2RdF1gbMoe
 3vOX5K+aK0okP8044g4k2JlDxV0/53maMa6+vnohYobzFJu7ZXXbC0IMzfQrCrk3jlna8r
 +kJVHWpkdfc6JoRLhGrrqprAwEFBpZs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-6PfPID-CM_2uaN3W3aGJZQ-1; Fri, 21 Nov 2025 19:27:09 -0500
X-MC-Unique: 6PfPID-CM_2uaN3W3aGJZQ-1
X-Mimecast-MFC-AGG-ID: 6PfPID-CM_2uaN3W3aGJZQ_1763771229
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-882381f2092so101681606d6.1
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763771229; x=1764376029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkmroyYCTEEZf3ECgpF/Q+QP6WnX41hH0GBpOgZMfpk=;
 b=TthdNVOMSA/X3DNBcmPVvsR1wJkjCScOqx5rtOjawIBmiJNUHExBazockUixXt/ogE
 0Y+T7T7OxVzzW3UY+zu+Ofz6ud8y+Vr7uQGteYk8aGkj/L8QG3iU7XKIKF2RrXM9+R88
 NxGF3Imv9Mi7/+lMWNUHRZN/U1/WsiD8d2m/hpi3jdUFFvz7GlsNqj/33bcjA7vo+RQo
 RzB0dLmmXs3hex9TXctqnmhyCyj83Eg1eIWJ3JmkWVdoJbO1/HgFqdIn7J+Tox8MY0r8
 9Oaj/K5192FbxU4ctH/oakbOOznNNm28b/k6vrN8mLDGqPW9s5ecbLobqUNNJsycqycs
 2lTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763771229; x=1764376029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XkmroyYCTEEZf3ECgpF/Q+QP6WnX41hH0GBpOgZMfpk=;
 b=MMZJZJBuYJSWBy4tYkvDwrDXYXXD9VE/WJhhvjEYa3xQ8C/qQDA+qav74jk/+VxCEg
 VTQAEyqyUXQfSfMXwJuMryXO+x9kzi2BSzBDSZmUXGrX3SaSt08TX+ZQ5S6Fvh47Fbi0
 WLu8KP7Nk0USpQ67l18N2TgCh6URoFXnji8gadfFIwRgpz4AYnWKnOQBAuv8n+3kcixa
 6Kl1gC8D9CW9mrzHLfnc+uQl+xgVDFlxdsvp8UBaW9IbPnBg1FFm4Qt/2zgyGfoQje+w
 c3ldHUV3tKdz49Kuslyy9zA8tw6BmUSaW+vccsVv/wNXik9vymXguGyKNd+5tkKOnCUy
 KLVQ==
X-Gm-Message-State: AOJu0YwF6VOu+Px2Wp52tGL1cSsiuTg+EBmzQUKKMRG+boB4NDGn6tcn
 QElv5aIADYIC4YV6//u4y1+DfBf2on6SnFAeuzukOtIyM2HP43Jue/S9IF0XdiIvt/fkGNYyHWg
 XD+EgwARDrBecjyrh6wFgt0F0zqvUQaEFXUYb3absoCKx8S+hThP2Q+2tPsKV+cWj5RFZu7UGz4
 qqzYXPcWvH9hTFXdYtXNg72sRlydzbyKeBKaUE/A==
X-Gm-Gg: ASbGncvoyHZAG5T5SO7yehyTxlqmhKdNUuoWQTyp0VQDq6j1UuQlA7Sa5JYiFf9Bf3m
 vn7rOb1Ne6uFGBzQ6GxmxrJLjx5FwEstVN/C3X0l2b76iIlolROk+mvpI0T2vvQpXQTCcIneBza
 yJpCJ50sXHtonhySXXHJe9rR/vczq3FOtxQWTw47nIgd8chxW6wTT7ssvqCUnmDoZ+FH+ilmFyh
 6QURkcUY8BVSn2aC/1MnhM2MHjIkHBV+tocySPJY9bRAiFxKzG4jycV9v0D9jM2gpUMRE37NbzL
 /P7dc6Z1MG64lNCeTqpVN6xV9YY3gfC2d2bX2IxxbeYw09S+Kg3bY7lMvLBL01flrXIJyDQ6RXI
 0
X-Received: by 2002:a05:622a:1386:b0:4ed:542:bb38 with SMTP id
 d75a77b69052e-4ee58af89e4mr65813951cf.74.1763771228825; 
 Fri, 21 Nov 2025 16:27:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt7QYNROGUhUhoBJNA89HOwWmlTp+dZDw3Cam6MRLvX0KHsXyxE3Q8KPZJbPMcwcxB8sIbFg==
X-Received: by 2002:a05:622a:1386:b0:4ed:542:bb38 with SMTP id
 d75a77b69052e-4ee58af89e4mr65813681cf.74.1763771228387; 
 Fri, 21 Nov 2025 16:27:08 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48e8df63sm43870291cf.30.2025.11.21.16.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 16:27:07 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 7/9] tests/migration-test: Merge shmem_opts into memory_backend
Date: Fri, 21 Nov 2025 19:26:53 -0500
Message-ID: <20251122002656.687350-8-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251122002656.687350-1-peterx@redhat.com>
References: <20251122002656.687350-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

The two parameters are more or less duplicated in migrate_args().  They all
describe the memory type.  When one is used, the other is not.

mem_type currently uses numa parameter to specify the memory backend, while
memory_backend (the two users of such uses "-machine memory-backend=ID").

This patch merges the use of the two variables so that we always generate a
memory object string and put it into "memory_backend" variable.  Now we can
drop shmem_opts parameter in the function.

Meanwhile we always use a memory-backend-* no matter which mem type is
used.  This brings mem_type to be aligned with memory_backend usage, then
we stick with this as this is flexible enough.

This paves way that we merge mem_type and memory_backend in MigrateStart.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251117223908.415965-3-peterx@redhat.com
[peterx: move MEM_TYPE_ANON case upper, per juraj]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.c | 41 ++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 8fa39999a1..7f325e4753 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -260,23 +260,36 @@ static char *test_shmem_path(void)
     return g_strdup_printf("/dev/shm/qemu-%d", getpid());
 }
 
+#define  MIG_MEM_ID  "mig.mem"
+
 /* NOTE: caller is responsbile to free the string if returned */
 static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
 {
     g_autofree char *shmem_path = NULL;
-    char *backend = NULL;
+    g_autofree char *backend = NULL;
+    bool share = true;
+    char *opts;
 
     switch (type) {
+    case MEM_TYPE_ANON:
+        backend = g_strdup("-object memory-backend-ram");
+        share = false;
+        break;
     case MEM_TYPE_SHMEM:
         shmem_path = test_shmem_path();
-        backend = g_strdup_printf(
-            "-object memory-backend-file,id=mem0,size=%s"
-            ",mem-path=%s,share=on -numa node,memdev=mem0",
-            memory_size, shmem_path);
-        return backend;
+        backend = g_strdup_printf("-object memory-backend-file,mem-path=%s",
+                                  shmem_path);
+        break;
     default:
-        return NULL;
+        g_assert_not_reached();
+        break;
     }
+
+    opts = g_strdup_printf("%s,id=%s,size=%s,share=%s",
+                           backend, MIG_MEM_ID, memory_size,
+                           share ? "on" : "off");
+
+    return opts;
 }
 
 int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
@@ -286,7 +299,7 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
     gchar *cmd_source = NULL;
     gchar *cmd_target = NULL;
     const gchar *ignore_stderr;
-    g_autofree char *shmem_opts = NULL;
+    g_autofree char *mem_object = NULL;
     const char *kvm_opts = NULL;
     const char *arch = qtest_get_arch();
     const char *memory_size;
@@ -350,12 +363,12 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
         ignore_stderr = "";
     }
 
-    shmem_opts = migrate_mem_type_get_opts(args->mem_type, memory_size);
-
     if (args->memory_backend) {
         memory_backend = g_strdup_printf(args->memory_backend, memory_size);
     } else {
-        memory_backend = g_strdup_printf("-m %s ", memory_size);
+        mem_object = migrate_mem_type_get_opts(args->mem_type, memory_size);
+        memory_backend = g_strdup_printf("-machine memory-backend=%s %s",
+                                         MIG_MEM_ID, mem_object);
     }
 
     if (args->use_dirty_ring) {
@@ -378,12 +391,11 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
                                  "-name source,debug-threads=on "
                                  "%s "
                                  "-serial file:%s/src_serial "
-                                 "%s %s %s %s",
+                                 "%s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
                                  memory_backend, tmpfs,
                                  arch_opts ? arch_opts : "",
-                                 shmem_opts ? shmem_opts : "",
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
 
@@ -400,13 +412,12 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
                                  "%s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
-                                 "%s %s %s %s %s",
+                                 "%s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
                                  memory_backend, tmpfs, uri,
                                  events,
                                  arch_opts ? arch_opts : "",
-                                 shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
 
-- 
2.50.1


