Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94149C5CFDB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 00:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuJev-0000fx-R4; Wed, 12 Aug 2026 20:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuJeZ-0000dD-PG
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 20:50:39 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuJeW-00040O-RF
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 20:50:39 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso15779035ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 17:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786582235; x=1787187035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DG5KrInoOA5BiWClGx6mfaAAm5PtanUYXY9qfC53y7k=;
 b=Uy2lsfpPYKfcTb15ioNxhJinHhO2jluqv48hpyUmHEf4MvJ+BLTQl46UjH1TJvjtFI
 KojZYHOLZ/z+vBvnWixpwiNJWrLkOZLVRxh5tV3+9WUZ+Thy/b8V10St3Q02+jFzqN9Y
 pugSdYVRuEV8La3jzyWOTfOyQwDS3eJqi1ylwJLnkR/KEQ8qinMaOkhau4L5dpXsW0a+
 aQshIn8qMgy169dr0tkA9wspTe9cLw+UbFD8Uz4GMVo6qRR6Y0PRNNYFB48h6LyMjojp
 rMzjLIPBXe14UbMR2sUQ9WwC92IhY1mJjs1iZchK3diVxW+bqK54IVekFc2b5jP6Z/tb
 Nakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786582235; x=1787187035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DG5KrInoOA5BiWClGx6mfaAAm5PtanUYXY9qfC53y7k=;
 b=qVMZ1FARUkmtovyu5bZUML6UKc0wEisnj4avidQNDJAe3cLF4ZLair4kaTVbhnbxv/
 jLdOhz1CmuVqdshtc6TQF0ZGbLvBxVuvIfNyXjJk+GGxMSVe40YjFEeaCKrmuZTa/dB3
 qsx4I8xiBp2lpvTmuc0pkwTuhaW8/UKRi+FzhOcE730boJ5AT1b/b/xJ8DT+MhoH709c
 DTjfBLhj0nOkXxgbGw7RTqCvUeRd5wj11UWLpqN5Xu1L9VPzEcOqdcdOwaT9f8zxZUdb
 y+Rw+1Af/jx/tDuGDpV9EnjkQwfe68CNmAR+0+uPW9Udvsnyx7VYDzKDDZJgXNXQVYd7
 M3CA==
X-Gm-Message-State: AOJu0Yz5ZC8zPca/3KP2DZL3XJw/F+1K5RnoXwdL63L6UYhEPIRnZR+4
 UhIbj+aX+hds8b3TeKn2aFCkoUBKJ+hbMY8n/vAmsEE85yNMNIEa4720fQ+VG7/M5KptK86ak8w
 xNPeT
X-Gm-Gg: AR+sD114SPP8TfkqXUBw/SRTbHKSO865WwOE0jAwC8PNmmTbdf8CgKpr+2VjAJZx5sV
 hc9KT8wPeWz7T4ZMr+/e5Wr9h4+h+h3G/6fzCEKdyloA47f2KzkWiBO6ZF7vLqDELKNCVsQ/XId
 3AlPMeTEVBUItuat0gLWFL0Z6nIXow5XILI5safCPlbnbzGzu9A1ORWabdSJDbzb7drmO2YgIbV
 w+xlX3EaLMxS1iaB/WavF2X+0Dqa2NTIw6Sn89zXSbKQDRM/NJY0ixMicqxAgL42QNOQoS09g++
 1d82kDKI+KCfPbvkSGavqi9/LWj7VBIMxgxgF69Vss9zgCKjOmNDaOjnxFn5fJ5T89+cIsL8q5C
 XATXpbwD475ZrOHeekqUiTgk5vb0tdwh5J/nr0dEQUEg/cA0M54is88lZHyvzbIWAk4KBKv2f/K
 YGAT3wYMl8UvR1iE8fWaHYhw8ASAMQ6hlH+AQpvVEVKJKCzje9UoX2Y27N8PK8nGtuu+eHnbG2V
 jkLu2YmRXTMcCKQ/x0X
X-Received: by 2002:a17:90b:5444:b0:38f:efed:5445 with SMTP id
 98e67ed59e1d1-3931e02a45emr2673776a91.4.1786582235226; 
 Wed, 12 Aug 2026 17:50:35 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931ca612e7sm1259918a91.0.2026.08.12.17.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 17:50:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: yvyas1991@gmail.com, qemu-ppc@nongnu.org, rathc@linux.ibm.com,
 anushree.mathur@linux.ibm.com, npiggin@gmail.com, harshpb@linux.ibm.com
Subject: [PATCH v2 3/3] tcg: Defer tb_flush when initial thread region alloc
 fails
Date: Wed, 12 Aug 2026 17:50:31 -0700
Message-ID: <20260813005031.518387-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813005031.518387-1-richard.henderson@linaro.org>
References: <20260813005031.518387-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

A vCPU hotplug may happen at any time.  When the new thread is
started, the region pool may be exhausted.  Do not abort.

Rename tcg_region_thread_initial_alloc to differentiate it
from tcg_region_initial_alloc__locked.  The renamed function
now uses tcg_region_alloc__locked and is prepared for failure.

In tcg_tb_alloc, allow code_gen_ptr to be NULL.  Treat that as
any other region exhaustion.  Reorg with while instead of goto.

Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2984
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h |  2 +-
 tcg/region.c       | 24 ++++++++++++++++++++++--
 tcg/tcg.c          | 22 ++++++++++++++--------
 3 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index c0997ab224..e35440dc8c 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -42,7 +42,7 @@ extern unsigned int tcg_max_ctxs;
 
 void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads);
 bool tcg_region_alloc(TCGContext *s);
-void tcg_region_initial_alloc(TCGContext *s);
+void tcg_region_thread_initial_alloc(TCGContext *s);
 void tcg_region_prologue_set(TCGContext *s);
 
 static inline void *tcg_call_func(TCGOp *op)
diff --git a/tcg/region.c b/tcg/region.c
index 8ee8c39c43..8bd378b212 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -396,11 +396,31 @@ static void tcg_region_initial_alloc__locked(TCGContext *s)
     g_assert(ok);
 }
 
-void tcg_region_initial_alloc(TCGContext *s)
+void tcg_region_thread_initial_alloc(TCGContext *s)
 {
+    bool ok;
+
     qemu_mutex_lock(&region.lock);
-    tcg_region_initial_alloc__locked(s);
+    ok = tcg_region_alloc__locked(s);
     qemu_mutex_unlock(&region.lock);
+
+    /*
+     * A vCPU hotplug may happen at any time.  When the new thread is
+     * started, the region pool may be exhausted.  At this point in
+     * the new thread call stack, we are not in a position to fix this.
+     * Leave code_gen_ptr NULL, so that this thread's first call to
+     * tcg_tb_alloc() returns NULL, so that the translator performs
+     * a tb_flush() and retry.
+     *
+     * During the tb_flush(), tcg_region_reset_all() will assign a
+     * new region to all contexts, including this one.
+     */
+    if (!ok) {
+        s->code_gen_buffer = NULL;
+        s->code_gen_ptr = NULL;
+        s->code_gen_buffer_size = 0;
+        s->code_gen_highwater = NULL;
+    }
 }
 
 /* Call from a safe-work context */
diff --git a/tcg/tcg.c b/tcg/tcg.c
index af15c3d63e..db43589fa2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1279,7 +1279,7 @@ void tcg_register_thread(void)
     qatomic_set(&tcg_ctxs[n], s);
 
     if (n > 0) {
-        tcg_region_initial_alloc(s);
+        tcg_region_thread_initial_alloc(s);
     }
 
     tcg_ctx = s;
@@ -1830,18 +1830,24 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
     TranslationBlock *tb;
     void *next;
 
- retry:
-    tb = (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, align);
-    next = (void *)ROUND_UP((uintptr_t)(tb + 1), align);
+    while (1) {
+        tb = (void *)ROUND_UP((uintptr_t)s->code_gen_ptr, align);
 
-    if (unlikely(next > s->code_gen_highwater)) {
+        /*
+         * Note that code_gen_ptr can be NULL after vCPU hotplug.
+         * See tcg_region_thread_initial_alloc.
+         */
+        if (tb) {
+            next = (void *)ROUND_UP((uintptr_t)(tb + 1), align);
+            if (next <= s->code_gen_highwater) {
+                qatomic_set(&s->code_gen_ptr, next);
+                return tb;
+            }
+        }
         if (!tcg_region_alloc(s)) {
             return NULL;
         }
-        goto retry;
     }
-    qatomic_set(&s->code_gen_ptr, next);
-    return tb;
 }
 
 void tcg_prologue_init(void)
-- 
2.43.0


