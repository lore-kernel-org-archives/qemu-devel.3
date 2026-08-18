Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0271C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNCV-0007PK-7v; Tue, 18 Aug 2026 13:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCT-0007OJ-AT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwNCR-0004fW-Dr
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:02:09 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84830c774a0so183136b3a.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787072526; x=1787677326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DG5KrInoOA5BiWClGx6mfaAAm5PtanUYXY9qfC53y7k=;
 b=BzdAy6CGmnbBWZa1AtulsTKJs4ysNelR8mnrFIquTOehK2oLy++GMe7b1zawUR6+JC
 QcyAF61W9GsiL9bJSC6AYpjXzQ8dde+8n9k2QinZaU2mXX+jw680bmO8Rbjg6ZpO5dmi
 klleHS0goMHaWxa7mM238RUhG969TAa8QLS4RsufrtqjFB+5kVsrh3FUZlDfK/UqAxe8
 jr5VlBkpSy/ynY4BmaGirPPgn2pT2VE7C2+kWq8+JT7+GeMmAkN3BP2PwfRm7c9hBOYW
 gKkgkc8zMuKI0GIRzQSeXQAPOr42LM3tXCDOqWY47Dok2qGcVkDnZvjGeV0rRHrMbGGl
 9Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072526; x=1787677326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DG5KrInoOA5BiWClGx6mfaAAm5PtanUYXY9qfC53y7k=;
 b=L7LxYZaobw5Vf+5xYVtKi9ixiKn923A6iNkenXlWcpd9PpQuf0eGo8mriJAvis4rUJ
 RAp3YMF/jjDZadfzV2+c8j7cE6M7v1sf1xWh8IV+skA21T5pO04gexuAYAeeuUKHFu2T
 DbldWeNejfB/qLXyGz5UCnCWHR/4Uh/QhdIKNf+IajTBeKTjiDB8ng00Hxda7gaYgj8X
 AhGpHNC7+yriwgrMNyhZXq4WFI1xoTn99ic9gp0Y4ygAfa4pkxSvhZftVtX6nUHTMt0r
 lwOvODxbY0pP5AnLpf9rWxJaUzPni2VbyMyx/pAO8NdDwhdzXoZ0VMPIyY1AbHTAeQq/
 y7bQ==
X-Gm-Message-State: AOJu0Yzo21nLorTntdLM1hEAAZXyyfblbZFBvaZqJZ5hbDK679jb5W6G
 1jR9/Q47hPQ8ouBCn12LSKXztm15MXaSQAxaimElr4U+p3RXnJumEGxrGWF7E5Df6zt1ikvMMtp
 lJ74tcfA=
X-Gm-Gg: AR+sD123K6t2kvKPCDlWlByKyf6S09C/Vxpj1onE+ARi8AVO3w3gFKHO6D7kYv4vV4n
 Q4j9lpE5KX15HC5krChG/hCa6GlZmZQLFdgZ7akg2pYllvh6jNoI/fbdH/b99U0bwQV6ws5QAp/
 KlgQZrRmBMERGiiYSPdjpxm0E4fOEGl8UAlzv21N5Z+orUsFClds+n5H+yUCC+s+7/6iWFEkjU8
 ChRLpdnSwcKcrNAGIBqBQ9yqs3w1f6N6S/0xPUs5wdxfPSBZk0uhRsZj03wWuImMxltybC16Ulu
 HnJKVjL49G5hj2uKEUN3tHJptYGxb82aKWAEurf9qqinQJltRDkKw9AiBX3CTWiLlgbHJFd+rV+
 LHxMDZX/d2lsBW9p/q02q5NuTBrTcUjA2dD3FPp0WXxEe1xNa0TvCrPzEay4Wv9W0py2nRExfnn
 NrpnU/diP9CfOn7GnvTOrexyYPRhDjN6QNyuvIOB9RiiJSEdNX1YPLHPu5jN7T8RmbnYilZ1z6V
 Rmp0SaoWn26kMftAGun4wVSo4WS90hyjts=
X-Received: by 2002:a05:6a00:3cca:b0:84e:2722:5d98 with SMTP id
 d2e1a72fcca58-84fde38d31dmr32872481b3a.19.1787072526021; 
 Tue, 18 Aug 2026 10:02:06 -0700 (PDT)
Received: from stoup.. (c-73-181-156-132.hsd1.wa.comcast.net. [73.181.156.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b401e10bsm2108314b3a.12.2026.08.18.10.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:02:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: [PULL 06/38] tcg: Defer tb_flush when initial thread region alloc
 fails
Date: Tue, 18 Aug 2026 10:01:23 -0700
Message-ID: <20260818170155.1907006-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818170155.1907006-1-richard.henderson@linaro.org>
References: <20260818170155.1907006-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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


