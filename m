Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB0AC61DB6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyn4i-0006Qm-Jb; Tue, 25 Aug 2026 05:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn4h-0006N4-DG; Tue, 25 Aug 2026 05:04:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn4f-0003G0-DB; Tue, 25 Aug 2026 05:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787648560; bh=/o7/278/xcpcm05kArNsfWr64peOSCE1E0K+8wmfdH8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AMudl6VXkPn224ZDK2XUXYyNW8VFlY25BJqGRJ6Pj9dn4pbU5KpqlmJwm+hVYmgxd
 FZUB1ypSz2tcxSsRzgWyaxbEX8nYnKU4PXUCnKaArCu+iq5jRVITYGyRFfG1UDKlu5
 vqrTl9xPk+39mIASktIRDoUSW7pYveqqkIP/S/OI7moixlEy8CTptZaBBctBf5FxUv
 MEv05IfnI8D5EVAW7A8CVS6NKxePXu6TgTG4CHbiPMlhZSd6NU/Hiaag01KuQ8aWEH
 CnF9v9blSAkw5U6WvClX4uh4MhFog/b0vRMhbegvW+mMKHiHLFEvc3OK2HFAtbSnuo
 BBzFwHGTOkIrg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 738991CE3B9;
 Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5F17E41617B;
 Tue, 25 Aug 2026 12:03:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D042C3255B; Tue, 25 Aug 2026 12:02:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Yogesh Vyas <yvyas1991@gmail.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v3 175/196] tcg: Defer tb_flush when initial thread
 region alloc fails
Date: Tue, 25 Aug 2026 12:01:32 +0300
Message-ID: <20260825090157.471948-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

A vCPU hotplug may happen at any time.  When the new thread is
started, the region pool may be exhausted.  Do not abort.

Rename tcg_region_thread_initial_alloc to differentiate it
from tcg_region_initial_alloc__locked.  The renamed function
now uses tcg_region_alloc__locked and is prepared for failure.

In tcg_tb_alloc, allow code_gen_ptr to be NULL.  Treat that as
any other region exhaustion.  Reorg with while instead of goto.

Tested-by: Yogesh Vyas <yvyas1991@gmail.com>
Reviewed-by: Yogesh Vyas <yvyas1991@gmail.com>
Reported-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2984
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit f5d2d8532f3c3cefb644fe9c1866a21b75f76faf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/region.c b/tcg/region.c
index 57ca7423570..1145f35085c 100644
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
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index c0997ab2243..e35440dc8c0 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -42,7 +42,7 @@ extern unsigned int tcg_max_ctxs;
 
 void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads);
 bool tcg_region_alloc(TCGContext *s);
-void tcg_region_initial_alloc(TCGContext *s);
+void tcg_region_thread_initial_alloc(TCGContext *s);
 void tcg_region_prologue_set(TCGContext *s);
 
 static inline void *tcg_call_func(TCGOp *op)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 64e596c0d4c..855560747ec 100644
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
2.47.3


