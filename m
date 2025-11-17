Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C0ACEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 22:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL7ss-00056Z-F0; Mon, 17 Nov 2025 17:39:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL7si-00053r-IH
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 17:39:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vL7sd-0003Vo-RU
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 17:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763419160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lbVrUGXUqQmpNGqTPi1M30LVldLmmTTajrOXDGbLJb8=;
 b=EJtJy/J1lxk0+LOvpTrThAo6WGc6uTyANyvyOELVMWr+EwNgryk4hDmOvVhYs60gtGdzto
 bYJLZpBZfGOmRHJPeCAhZu/sBo4lAyXGfIwFFihiUzRDTtG9Az3GhV7tTQC/y78lnU7Tk6
 gYUMGlI51zfFE43dHA/Zt4LmArXUCVA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-nlpPd8T-NBmKmR5lNQCgpQ-1; Mon, 17 Nov 2025 17:39:18 -0500
X-MC-Unique: nlpPd8T-NBmKmR5lNQCgpQ-1
X-Mimecast-MFC-AGG-ID: nlpPd8T-NBmKmR5lNQCgpQ_1763419158
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b1d8f56e24so1337030585a.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 14:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763419157; x=1764023957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbVrUGXUqQmpNGqTPi1M30LVldLmmTTajrOXDGbLJb8=;
 b=euvXgFuUiRyoaOPMyqYu3HYeCULZP5X9ttzGGITLV8ZaDJuPsAz529HN340N3pJVfR
 EGl0CIrR0Tdvdyy9FWctO9VejW5JqrnvPAuk2nkAhIik8hGAKjnl8i7mAkaX5s5v9dCz
 x8RNe30GIrTl/xcesp/mRWlgbow68wFpC2RJ3jfqFv5cxzURSbowsxJqKIXxnH9x7u/1
 HLm+9m5yWALFpQfw+EA3oZtWHfeF0faR9IYCnKwi0otqhCmRoPbFt8+N3gnxDUosFs1b
 Oe3nE/eV3bqulYmQFvMClSTB+Sc7MtzAr576JFJc/4vrvO1o0oSPZ3p5XFQI/bXI10or
 ouqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763419157; x=1764023957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lbVrUGXUqQmpNGqTPi1M30LVldLmmTTajrOXDGbLJb8=;
 b=f46EFPewwPcSHmFOTQEe5891cq9CcdIRuXUASLXX/1trSdWSTI4gRHHu2ydMXqiQKs
 SZ30ZCKaFBOY9qRlRw7tP2r61zFdDvHuuAjRqiRV+nOKICP7azjK7ZupKixPIoD6n/G1
 /JkZwD0HbtMK0GFFwVXl7f19Lqz/rMnEXHP9oE0tzI8PABVw9FSDLeUF3MVMlPgd0JxK
 I4PYMwqUsBwUnJctVlG0lmuBEAvjQTy/ROCUxVZi2FuAefxg74sNQplihBEnz3ptwJUG
 HLr2vCQXHTLlneMKAjM2Z7q9BE9AkXnHT2YHBmcLLZXR0yU0pnykWe3DuFhXOZnDaqRP
 HGcw==
X-Gm-Message-State: AOJu0Yz9yfWtVqWYVfCZZ19hlTLccuLGhjF0EyievucHZu2PaBzVUcvp
 ZHUUMJpcca7Hi7ehtiuXJVdigW36/954q2BPClZ3q0Ki68rZILT6CQXb62qOcLHVyg75ioL7GNk
 ab+lp7cx9IVY3m3qR967nPfTPSuzvBEZROVQnsdkXkDO+oCtSYOWgY+HtDtNZ/Uq7Xw1gSUEGZb
 WjUnZBSj8q9Ex+qG5zJWXhOKr2OgYTU65ZnE6B3Q==
X-Gm-Gg: ASbGnct28ERK4gJuHMHMtbJf684jjm5UWxWqMFuyoP01RJQoF0t6xOCTh3bEgFHKGm3
 As9+WBv9e0K2oYOE/zOZ9C1WRWbG6TZN2z7yM3VQHyUrcG9T7ahhV7O7Gkd6ZHCidlVLdDy3kGx
 L9sz6RWjmBqY93PJSSvD/lbIP4dMU4I8PG8+6C5VuMQGoE5O+S+h7BiqiAZ3r4LIniBaNxHZqFw
 AsvlPmw4ZnMn69+DBbdFAB1xe+caZYCkla7KKT+wEWkL3rIJCfL4P0ruwoG3ICFevgeOJH1R/6L
 JX2ZaQN7EVXroOQ16W8re5NMFcP3yxHT6KVxL0XGWdrM4o8d2IxtAffK0B7b4gZMXOUFQFrDAcg
 =
X-Received: by 2002:a05:620a:7007:b0:8b2:f29e:3af8 with SMTP id
 af79cd13be357-8b2f29e3f93mr597467785a.59.1763419157350; 
 Mon, 17 Nov 2025 14:39:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+pFypgMeYFWPkxsWTxKu4u+2AiQaTUj0Odc4c0vuOta/Cs9rAC9XmTNg3PL9L8t0St4GvVw==
X-Received: by 2002:a05:620a:7007:b0:8b2:f29e:3af8 with SMTP id
 af79cd13be357-8b2f29e3f93mr597464185a.59.1763419156864; 
 Mon, 17 Nov 2025 14:39:16 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee1c21ea34sm37693521cf.30.2025.11.17.14.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 14:39:15 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 2/4] tests/migration-test: Merge shmem_opts into memory_backend
Date: Mon, 17 Nov 2025 17:39:06 -0500
Message-ID: <20251117223908.415965-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251117223908.415965-1-peterx@redhat.com>
References: <20251117223908.415965-1-peterx@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.c | 41 ++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 8fa39999a1..6df0e56c2a 100644
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
+    case MEM_TYPE_ANON:
+        backend = g_strdup("-object memory-backend-ram");
+        share = false;
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


