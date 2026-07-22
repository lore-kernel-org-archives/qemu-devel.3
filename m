Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5096C44536
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWUx-00041u-SH; Wed, 22 Jul 2026 08:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWT6-0006pN-Nf; Wed, 22 Jul 2026 08:54:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWT4-00032O-Rt; Wed, 22 Jul 2026 08:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724575; bh=JxYJdtXOprOlKBzHL2xII75YrJMrqLIeIwLbInuIXoE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iipHO7drAtsuaQ5gVmIMjM9AxoGp9+z+gLKPFcR7GK5ytIwV8kNj2nYeK5pYWbeGt
 lEhBVJ4URFpwNlo/aOW8+T2aFDt0WJe3ZgfRGyVuw37UJszSjXKMDvsMevlckhCrBJ
 tW5vio8D9OX/gg9l4qhr6n0SoFyxMBpe952LymxyZucVIiYm4ZDDACSrRS3KOWipG0
 QPpLUsBuAf/F5f01pFQG5WVktsvnvfWNKQ2JAAYELFJIIbhkWKKeQkKZjGMstn4o+2
 k97mzQD2LH3CLQ/iJbpf3e/rdfbe3VUSDPyIPRfzfyEfjQ2DW6FAUgrA+rZ3wfVzON
 SyUCTu14N/XZg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2FB401C3B4E;
 Wed, 22 Jul 2026 15:49:35 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7873B3F379E;
 Wed, 22 Jul 2026 15:49:52 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DDD5317F71; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 113/127] accel/tcg: move jit thread manipulation
 into do_tb_phys_invalidate
Date: Wed, 22 Jul 2026 15:48:38 +0300
Message-ID: <20260722124859.32371-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Alex Bennée <alex.bennee@linaro.org>

To invalidate a TB on MacOS we need to enable write access to the JIT
buffer. We were doing this for tb_phys_invalidate__locked but that is
not the only path into do_tb_phys_invalidate. Move the manipulation
into the shared function that does the work.

As a result we can drop the tb_phys_invalidate__locked function and
update the calls directly.

This enables watchpoints to work in MacOS TCG guests.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3444
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260526110243.470002-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
(cherry picked from commit 78420b59f0fe227605bd67e1e232df9dc1ec539b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index cd7c32361bb..0c7ac5a72c0 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -925,6 +925,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     uint32_t orig_cflags = tb_cflags(tb);
 
     assert_memory_lock();
+    qemu_thread_jit_write();
 
     /* make sure no further incoming jumps will be chained to this TB */
     qemu_spin_lock(&tb->jmp_lock);
@@ -935,33 +936,27 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     phys_pc = tb_page_addr0(tb);
     h = tb_hash_func(phys_pc, (orig_cflags & CF_PCREL ? 0 : tb->pc),
                      tb->flags, tb->cs_base, orig_cflags);
-    if (!qht_remove(&tb_ctx.htable, tb, h)) {
-        return;
-    }
+    if (qht_remove(&tb_ctx.htable, tb, h)) {
 
-    /* remove the TB from the page list */
-    if (rm_from_page_list) {
-        tb_remove(tb);
-    }
+        /* remove the TB from the page list */
+        if (rm_from_page_list) {
+            tb_remove(tb);
+        }
 
-    /* remove the TB from the hash list */
-    tb_jmp_cache_inval_tb(tb);
+        /* remove the TB from the hash list */
+        tb_jmp_cache_inval_tb(tb);
 
-    /* suppress this TB from the two jump lists */
-    tb_remove_from_jmp_list(tb, 0);
-    tb_remove_from_jmp_list(tb, 1);
+        /* suppress this TB from the two jump lists */
+        tb_remove_from_jmp_list(tb, 0);
+        tb_remove_from_jmp_list(tb, 1);
 
-    /* suppress any remaining jumps to this TB */
-    tb_jmp_unlink(tb);
+        /* suppress any remaining jumps to this TB */
+        tb_jmp_unlink(tb);
 
-    qatomic_set(&tb_ctx.tb_phys_invalidate_count,
-                tb_ctx.tb_phys_invalidate_count + 1);
-}
+        qatomic_set(&tb_ctx.tb_phys_invalidate_count,
+                    tb_ctx.tb_phys_invalidate_count + 1);
+    }
 
-static void tb_phys_invalidate__locked(TranslationBlock *tb)
-{
-    qemu_thread_jit_write();
-    do_tb_phys_invalidate(tb, true);
     qemu_thread_jit_execute();
 }
 
@@ -1030,7 +1025,7 @@ void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
     assert_memory_lock();
 
     PAGE_FOR_EACH_TB(start, last, unused, tb, n) {
-        tb_phys_invalidate__locked(tb);
+        do_tb_phys_invalidate(tb, true);
     }
 }
 
@@ -1091,7 +1086,7 @@ bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
             current_tb_modified = true;
             cpu_restore_state_from_tb(cpu, current_tb, pc);
         }
-        tb_phys_invalidate__locked(tb);
+        do_tb_phys_invalidate(tb, true);
     }
 
     if (current_tb_modified) {
@@ -1156,7 +1151,7 @@ tb_invalidate_phys_page_range__locked(CPUState *cpu,
                 current_tb_modified = true;
                 cpu_restore_state_from_tb(cpu, current_tb, retaddr);
             }
-            tb_phys_invalidate__locked(tb);
+            do_tb_phys_invalidate(tb, true);
         }
     }
 
-- 
2.47.3


