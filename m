Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454F9CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 21:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ay7-0006Kf-5x; Tue, 23 Sep 2025 17:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay4-0006Ji-9r
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:36 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ay2-0003j2-8N
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 17:54:36 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-26a0a694ea8so41627695ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758664473; x=1759269273; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eQTsRUAq4JwFxeRITx6gawdeUeSfrBkGrxQoOoMpUjE=;
 b=iB7670TGB4bTyBcuv+uNPaNI1iEbxJ4dzeIp91e62zVm1XMSlliySnu1Sx5nUNoeK3
 zVB8yM/KIK/q1yO/FEl47EEFIBcUVecNoHkooJm4HJVXLCI9Dr2ld7Ajah8MSrmvpBbj
 cTSzc1JXlNxLw5QzJlwB1UjybN32gR9+IF6Ha18HjsB0Q+0H2wT1CMoukfYjfwcP6J52
 bFyuNxheRCPP5BkJu7+Xie7BY+sn57wAjiXFX8v+dAyDGhhbIIIi5YWXz2thgY7+7xM6
 gXTk5PO/w/dGkdrFYfwl3HpBLI17PYYE5P4+uea/x9UDWxQtH/KfIUUWAP25B2c9BJRG
 Fr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758664473; x=1759269273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eQTsRUAq4JwFxeRITx6gawdeUeSfrBkGrxQoOoMpUjE=;
 b=X7SGZbOCOu5TOR8UM9lCHgzdwxgW32U2yizo3nid9UeF58VBBVhCKa/CAMgjEphCbE
 BuRAyuOcDkAkC+4RyDEjmWpeo2IZtmzRIa4lH0iGbvmCEUMzzLhnm8Hn3QEtsx/Rt13y
 6FwFVnZhvQQNZCnvSsHYp/ZDXM+0OPLGM/trrtwtzdveTTEEr7jR4oGa9F7/acdrgH8C
 fLtNn2mHODnRGsWhw7UqoQY7mCYf6NBTYR931hXQhMnZJGTK6LpwEOQm0+obfilbtfAL
 pUI7h5mwQzuphJuV7P1Ot6AoWyAlHXqpZ/BRno8KyLN9BP0oo2VIMsZ/1IMuJIuxp9xd
 EBfw==
X-Gm-Message-State: AOJu0YyWe3S7jv71rwKaIBXB5Cfs6IoMKRwI2nSS/VTcQaJYuiXeYWty
 KyujAtupnqPY8ZlaI4S2UK7fFkGSyV9++w1BNB2LQ/4Yni0UW7cgE0EC+gQHcZjawb/PjkkcOpv
 6aS4Q
X-Gm-Gg: ASbGncu+fE0wCmca5FLtewiprUFD++QKP9qA7SBEWdVp8ePMhxv7EOHTErW/GJYSbaI
 zR8SyCDvkAImSSngMFDu5jbBc6ysB87BKG7wRJq84yEJzo+kChpx2gwQlRFQvhLPkmS+esVIQcW
 skX9j/GLSRt+jcEbegIC93c7GtyaZPKfh/+rClB8l01NYP2UBbcN5f7LnXSb36JJJmyW6PPBlW7
 RtYCVqeUOgOGba4JovTeO2p3rWSZH7ZrkXYd7zyt3MHYqow4Qeow6V/ci1TvSksjtieO3oKO0ul
 /2xZa8RhfpAqT9yoWReYfmzs7idXwOA8JGPxDNRSwCwzmE3JizgXNcUPYxbyCft2ZNX6nUpDcJ3
 9l6VSd/bu21gZ7eaZtPKnUbgxDmixOAgvk/7OM4c=
X-Google-Smtp-Source: AGHT+IGy1sCykf7uLICFyhn8NSutJ1hRTgj/U9dwxQoLSGMMRgs7sQFQw/BZ+zrJVl6Ro0CrfuvIyg==
X-Received: by 2002:a17:903:1a43:b0:267:ba92:4d19 with SMTP id
 d9443c01a7336-27cbab337f3mr45872725ad.0.1758664472672; 
 Tue, 23 Sep 2025 14:54:32 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-269802e14f1sm168294035ad.71.2025.09.23.14.54.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 14:54:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/10] linux-user: Split out begin_parallel_context
Date: Tue, 23 Sep 2025 14:54:22 -0700
Message-ID: <20250923215425.3685950-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923215425.3685950-1-richard.henderson@linaro.org>
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
index 91360a072c..101dc427a4 100644
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
@@ -6631,10 +6629,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
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


