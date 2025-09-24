Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB86CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UqM-0002Kl-Bb; Wed, 24 Sep 2025 15:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1UmB-00070w-Ma
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:42 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uk8-0007vS-9D
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:35 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-26f0c5455e2so1122565ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740488; x=1759345288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kC+jJzU7oKqcXeHFjuuS9plD7f1CcqeywF5Lpqo3jg4=;
 b=v1ftuBPbN0NNw9/ossfmq/w3NqXBk3rGns7I9esxvieIDJBpn8eeuNYneqpTGhctJG
 OTxHNiGXYXQU6CFLUClASHtDu4mrbwNXqxD2vAfmVTKNXEUFlSIqLZFZ0gLLRgQcSikv
 vEdU5bnxHyKK73647CmhJIpdHGOwU9APQ/fXuWHFota/qU0t5RXEUY8sKfxMyOiEkTaw
 U4uf4nhHNBcLnoQ2ul2TOisNlf7lHrFExjtjHCyiM1qtUWl4oalHSe185u7DOGvOoUpp
 QXvik3GakPHYqzDytPmzsAfKnaZR2DSEByAun7njY/YJv6JObQLk1rq2aKenOQB1tGwh
 lBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740488; x=1759345288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kC+jJzU7oKqcXeHFjuuS9plD7f1CcqeywF5Lpqo3jg4=;
 b=Cz2tDLSyrqML1JYHGZQepBVEY5RHrhpWI6LjkWZ91grjW7gIB2KG0PhNSO5V66Vvll
 u+cOOnNsz+iiCkKC/m7CLYoJqHfWLX4K/vGMIAVE1mhN0UBr38Svxg9VbBr59PW1LVYL
 9YUXhWPKzlPydV/dRS7J4dDNLeVv8p5qqN4SOQtAVxU3a8gmdm1sajUGQSbAFimNfS+s
 9Vc0R2qbbZ7xMbTISi+a/fCtF24Skx8TsuytBGlEJ/RMhjFSHCZOA+EAEcYscKnaXxgc
 Q0DD5dfHhjuDOIfakwZyNZ0Hi2viMLKTu/rYMuXoIqE8KMXyX7nxz16AzcM/Nof8iNTW
 CmJQ==
X-Gm-Message-State: AOJu0YwKRCLrHMoHcOSgVZboCXn3UxMbx50kfWB6Cod/bI9GQMi5n/J+
 V+MM8vbKJ/0iSpeB8TPbhoMa/EYHvVUYBGHMh0MM+N/czjlA0q6JCBP1ryAgY9SMGw7flRaIRqD
 EOHL/
X-Gm-Gg: ASbGncuzledm6fmibUaW4KXBf4PQkw4sO1uLd6QXDaBOOdFkQLiggwzN3zd0hrfz0Nl
 9oUews/80qVOSfvQDeY6zMBun6dpZYblytDs0yxMQDetSemIHqDFl3oizKYovvG8aoGHX7Wp7TM
 DMHLXNnJFsUZfy5tYrIAU6wQd/Y/0OLuQq1/FhveYjxDC8AblokyM6uDu8NbixWNOmv6qY2EQZt
 Pq71VHnOZjP5zZCpfQftfS7iwS33apJDH509zNpoWjFs5cP0qvBFtG22JfMcjaRGrKNbj6zBlYY
 doNUV0276i1A+GRCGbrJHuV95CIyRcc1rYgfjEAlOKoME8FP7JAnEIzUyobDblB4f9ADykuPm3U
 oXsRw34SVPfJu4Hms+0SmSgZzFP3u
X-Google-Smtp-Source: AGHT+IEOztd2LpTu+Gn03FqnNatyjb0YoR6EboYZZNIlzvAvznR4SuqWaKSXD8/TzYNdFljKawrwow==
X-Received: by 2002:a17:903:37c5:b0:246:de71:1839 with SMTP id
 d9443c01a7336-27ed4a6078emr6327135ad.50.1758740488391; 
 Wed, 24 Sep 2025 12:01:28 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/32] linux-user: Split out begin_parallel_context
Date: Wed, 24 Sep 2025 12:01:01 -0700
Message-ID: <20250924190106.7089-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Move the test/flush/set block to a new function.
Use tb_flush__exclusive_or_serial while we're at it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/user-internals.h | 16 ++++++++++++++++
 linux-user/mmap.c           | 13 ++-----------
 linux-user/syscall.c        |  7 +------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 691b9a1775..7099349ec8 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -20,6 +20,8 @@
 
 #include "user/thunk.h"
 #include "qemu/log.h"
+#include "exec/tb-flush.h"
+#include "exec/translation-block.h"
 
 extern char *exec_path;
 void init_task_state(TaskState *ts);
@@ -172,6 +174,20 @@ static inline int regpairs_aligned(CPUArchState *cpu_env, int num) { return 0; }
  */
 void preexit_cleanup(CPUArchState *env, int code);
 
+/**
+ * begin_parallel_context
+ * @cs: the CPU context
+ *
+ * Called when starting the second vcpu, or joining shared memory.
+ */
+static inline void begin_parallel_context(CPUState *cs)
+{
+    if (!tcg_cflags_has(cs, CF_PARALLEL)) {
+        tb_flush__exclusive_or_serial();
+        tcg_cflags_set(cs, CF_PARALLEL);
+    }
+}
+
 /*
  * Include target-specific struct and function definitions;
  * they may need access to the target-independent structures
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 002e1e668e..847092a28a 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -22,8 +22,6 @@
 #include "exec/log.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
-#include "exec/tb-flush.h"
-#include "exec/translation-block.h"
 #include "qemu.h"
 #include "user/page-protection.h"
 #include "user-internals.h"
@@ -1007,11 +1005,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
      * be atomic with respect to an external process.
      */
     if (ret != -1 && (flags & MAP_TYPE) != MAP_PRIVATE) {
-        CPUState *cpu = thread_cpu;
-        if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
-            tcg_cflags_set(cpu, CF_PARALLEL);
-            tb_flush(cpu);
-        }
+        begin_parallel_context(thread_cpu);
     }
 
     return ret;
@@ -1448,10 +1442,7 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
      * supported by the host -- anything that requires EXCP_ATOMIC will not
      * be atomic with respect to an external process.
      */
-    if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
-        tcg_cflags_set(cpu, CF_PARALLEL);
-        tb_flush(cpu);
-    }
+    begin_parallel_context(cpu);
 
     if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
         FILE *f = qemu_log_trylock();
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9098cdb9fa..1a5f2a03f9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -27,8 +27,6 @@
 #include "target_mman.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
-#include "exec/tb-flush.h"
-#include "exec/translation-block.h"
 #include <elf.h>
 #include <endian.h>
 #include <grp.h>
@@ -6667,10 +6665,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
          * generate code for parallel execution and flush old translations.
          * Do this now so that the copy gets CF_PARALLEL too.
          */
-        if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
-            tcg_cflags_set(cpu, CF_PARALLEL);
-            tb_flush(cpu);
-        }
+        begin_parallel_context(cpu);
 
         /* we create a new CPU instance. */
         new_env = cpu_copy(env);
-- 
2.43.0


