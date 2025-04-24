Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E32BC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7lH7-0006Og-28; Wed, 23 Apr 2025 21:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFQ-0002hX-T7
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:29 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7lFM-000792-BR
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:19:28 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so411847b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745457563; x=1746062363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yfxlS/j/l5o/48KW68uDDwVYspo4hJz8obcvv8QliPk=;
 b=hFVCN5jCbk51C1c2nTDsIgKCAT3rNt4RJNQisBF2XLb98wQLo9U+m7MywjY2MwGZBm
 RHpka7dtaMxk+BxPI8RhTDBNXsFLRC+NiJNXnSdU3/GbYRUcqBFjtitGi4A42dQVh4cL
 tnp2EFuPLHSdeTcWREQqOP0zZDWiHNsQb1NOUqSl9asjQwOFym8Gy+iKl946e/5hH3cK
 XZYqH3meX7SmHnDAHmqxXHDbgWhECVCKQE9CQCZumVome3sIMHR8ClWYzeziHCiLrFZ1
 tSBwShTZZTTgb8u3g9dAFsHfSrLaRvPbn2t/fsYfnO8717h/ezCisHa73x3JxNhVNa9b
 0tBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745457563; x=1746062363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yfxlS/j/l5o/48KW68uDDwVYspo4hJz8obcvv8QliPk=;
 b=T09pIjhJbubkY2Vncu5WIFxRC3wgdkxSEIHdXOQzn0BNONWV11h6ATn/yT5iFEl2Tf
 Gxt5ZjJflyBS2d0lGnqr4pSsjdO3mKTZZblbA2dqdOXePZi7vGhIjPBbsyERLVY3berZ
 FtLzfNPlKFC/4YWz8koq1N4RaKAP+j6gEHPWyE0EBfDVT+tgK3IXFEEOAhM/aymq+Pgk
 x/S6hNr53DwZ3OK58yz9jhh6hPhY/X4Uch7xaMt2hZrqQADRubHAYnFwzUwa9PLwsoar
 CyUIjLmV4FRk14reejw25dQnDkfqEwtNwCE9StmagBmf2o6K8RTAAEDtPAbllHfp7zhJ
 YOvA==
X-Gm-Message-State: AOJu0YyuTRFipf2V5yTIlxxQNYom17kJuafiL0ztT7bm+42prna/e7Ox
 21nEOlZSEIKyLh0vrh29pB1G2cpVYzW16H9HFLYtJhmvbqlaTR+WstDJXCYD4pcn8nJY1cqe34c
 j
X-Gm-Gg: ASbGncv5e2amybHlRSToNxE2/iRP5KunvrOtZUxpyrnIId5fiP8mL8ZdQX8vB4ZcRiG
 kKNqjgp/76d4dGB/HQqtCI3EgV8X4kPl4l3tNomzIpOE690woR7pvQen4IgxNyftwlW9Hz8iyxL
 wi2/KpZtwkg4t9l2ZG0Rw0/hxzyxnXhGKknaZH49ZXYadofHx9KbF+j15MEZMSLLMaMXtMTZRo5
 8dcuIsF/tOkdwjQZhi0rKkXJFZQdms2O/9X8DCAXetLEIgdy3yvsvxwOLKT8N0PA92319srQlqg
 /c3yZnP/zzQKg+7m/Lnrz2XY39eHFHFU2wSiJJo8gmjP+9v8oD57jx1/KbsiWgVV97cXe6UbzVs
 =
X-Google-Smtp-Source: AGHT+IHyeRtodk9EHC9rV/l66b0TnDhcE7t9nIbjiP9bplzWVqgkkeCwdvn9r9uVmUGHsJTEDqFdPg==
X-Received: by 2002:a05:6a00:aa0b:b0:736:47a5:e268 with SMTP id
 d2e1a72fcca58-73e245cc687mr1163600b3a.1.1745457562801; 
 Wed, 23 Apr 2025 18:19:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912ef0sm244079b3a.10.2025.04.23.18.19.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:19:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/15] accel/tcg: Add CPUState arg to tb_invalidate_phys_range
Date: Wed, 23 Apr 2025 18:19:08 -0700
Message-ID: <20250424011918.599958-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424011918.599958-1-richard.henderson@linaro.org>
References: <20250424011918.599958-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h   |  3 ++-
 accel/tcg/tb-maint.c      | 10 ++++++----
 accel/tcg/translate-all.c |  2 +-
 accel/tcg/user-exec.c     |  4 ++--
 system/physmem.c          |  2 +-
 target/arm/helper.c       |  2 +-
 6 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 944b579d91..bee3416e7e 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -122,7 +122,8 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 
 /* TranslationBlock invalidate API */
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
-void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last);
+void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
+                              tb_page_addr_t last);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 67a2570b4c..df31322cc4 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1012,7 +1012,8 @@ TranslationBlock *tb_link_page(TranslationBlock *tb)
  * Called with mmap_lock held for user-mode emulation.
  * NOTE: this function must not be called while a TB is running.
  */
-void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last)
+void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
+                              tb_page_addr_t last)
 {
     TranslationBlock *tb;
     PageForEachNext n;
@@ -1035,7 +1036,7 @@ static void tb_invalidate_phys_page(tb_page_addr_t addr)
 
     start = addr & TARGET_PAGE_MASK;
     last = addr | ~TARGET_PAGE_MASK;
-    tb_invalidate_phys_range(start, last);
+    tb_invalidate_phys_range(NULL, start, last);
 }
 
 /*
@@ -1178,7 +1179,8 @@ tb_invalidate_phys_page_range__locked(CPUState *cpu,
  * access: the virtual CPU will exit the current TB if code is modified inside
  * this TB.
  */
-void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last)
+void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
+                              tb_page_addr_t last)
 {
     struct page_collection *pages;
     tb_page_addr_t index, index_last;
@@ -1197,7 +1199,7 @@ void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last)
         page_start = index << TARGET_PAGE_BITS;
         page_last = page_start | ~TARGET_PAGE_MASK;
         page_last = MIN(page_last, last);
-        tb_invalidate_phys_page_range__locked(NULL, pages, pd,
+        tb_invalidate_phys_page_range__locked(cpu, pages, pd,
                                               page_start, page_last, 0);
     }
     page_collection_unlock(pages);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c007b9a190..9bf8728064 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -599,7 +599,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
         cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
         addr = get_page_addr_code(env, pc);
         if (addr != -1) {
-            tb_invalidate_phys_range(addr, addr);
+            tb_invalidate_phys_range(cpu, addr, addr);
         }
     }
 }
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 39b76d9654..2b12c077e9 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -529,7 +529,7 @@ void page_set_flags(target_ulong start, target_ulong last, int flags)
                                         ~(reset ? 0 : PAGE_STICKY));
     }
     if (inval_tb) {
-        tb_invalidate_phys_range(start, last);
+        tb_invalidate_phys_range(NULL, start, last);
     }
 }
 
@@ -1020,7 +1020,7 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
                  * be under mmap_lock() in order to prevent the creation of
                  * another TranslationBlock in between.
                  */
-                tb_invalidate_phys_range(addr, addr + l - 1);
+                tb_invalidate_phys_range(NULL, addr, addr + l - 1);
                 written = pwrite(fd, buf, l,
                                  (off_t)(uintptr_t)g2h_untagged(addr));
                 if (written != l) {
diff --git a/system/physmem.c b/system/physmem.c
index 16cf557d1a..637f2d8532 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2830,7 +2830,7 @@ static void invalidate_and_set_dirty(MemoryRegion *mr, hwaddr addr,
     }
     if (dirty_log_mask & (1 << DIRTY_MEMORY_CODE)) {
         assert(tcg_enabled());
-        tb_invalidate_phys_range(addr, addr + length - 1);
+        tb_invalidate_phys_range(NULL, addr, addr + length - 1);
         dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
     }
     cpu_physical_memory_set_dirty_range(addr, length, dirty_log_mask);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7fb6e88630..c6fd290012 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4987,7 +4987,7 @@ static void ic_ivau_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     mmap_lock();
 
-    tb_invalidate_phys_range(start_address, end_address);
+    tb_invalidate_phys_range(env_cpu(env), start_address, end_address);
 
     mmap_unlock();
 }
-- 
2.43.0


