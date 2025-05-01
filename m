Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF8EC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLh-0000sr-6N; Thu, 01 May 2025 17:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLO-0000kv-F4
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:23 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLM-0001R5-An
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:22 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2240b4de12bso23211015ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134478; x=1746739278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWktBFOiwzYz1m9m1VKfbXX4KkdhBRM9kN+RtMXQVTs=;
 b=c8N5tkLgoONZVBhnZ3XvGKc+Utm6ZCjmUwXTZM68BcuBGcb8pDhtDo7C6kvCNhWUw0
 8fYDlxpfg7If1dxundVbYWGrIMbSAyJmt8rloI2lhZAMB59I+1Z/wmBRcyt1KNZcI5ME
 qrBzAiYZXHXovD5gjhRX3yGKS8pRPeeZ/EeRl53rT0o6WB06u6AvjZZyfMBcaAa8l/bg
 Xlh4wdb+DnvPBocDMCfnEFRaipRrjCzD0wsEt8uHwPnRkN2WtoIo4Ud7oP+zwvDvhGy8
 dl65LK8GTQA6cwPa2S4AY4E8mI1z98bio/IzBFZVaHdCIPrvYKJrVQNiLJdhoC4fGwHk
 gBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134478; x=1746739278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWktBFOiwzYz1m9m1VKfbXX4KkdhBRM9kN+RtMXQVTs=;
 b=dT9HoVPvRLWkEV/bGFDPIzz+bpyUxL7jR0zbHzHJ2fWAqedWjtfzg+IZ3dTXLxBlrr
 jC3MtDdA93uSizAR54AXZpJhW4JsavrWTKY7bEr0CYCbdN2usiCLnKBrMb385wJomYwz
 UBozVozdGlVR7WF82u9e3ML6aSJyuOuUiMqdHn2vdZfi02/hNPZ6zqUpD2DUub/bwraq
 cXPH7ZfIqkdiC80vrXpySYFVYOHukJMpZa3BiCly9kYxURoMCliF97ceAzEmO1CjzeaH
 HWuD5/U8+FBzuELV2hTkr8v0ry8TJAZ1tprXtWAjnAvmA0UhiVh4cKWpqQthCcDHzMr8
 QrGA==
X-Gm-Message-State: AOJu0Yznfsq0CnamjU0ThOSIua5iJCG8oicFEE32MHlh707BbbZ+xH6Y
 hWqnchEO59YfQR+5QFR4C6t3ib4725l9kBz7qmOmE9wV05XI07jhqumISdxEVVU52NXNeHsUzaw
 g
X-Gm-Gg: ASbGncuo2cRFbPrJNz8EPTteeUr+PE3qZE09gBEzQKYBA8Ks8anPeDyN26gV3bjd3C9
 b+bNhxQoMOQeTGDJ6i8StvfxfFYf1lvO2DCwyexCMGEuQoCFcwhITJJQmc9WCRVWroKlnZb2QKO
 11SGqk5lUbM1DvYKLKuuPnoVcxq/1OEmnRasAmw31+UGfGHitLAtsrS3m6J23dWb8e5xuyZrQA3
 v6S8+w2GWEb/to/n0+8qYEJQi7ak3KyTglNdNUaUJt9vu1xUNdq9MvazkWaVEmi2FYi25yaggZQ
 G2GnWRqmFoMPPQKOzcjtXXoRa08hk4WSDiIGSqpp9gtUucKAiu6FToTdOaCrdCXq/zgYI5B2Rcc
 =
X-Google-Smtp-Source: AGHT+IF6VYjGHK9MhUbWt/y/WVqMOEzj044Kv4Xe2Dz/v7YJDX7+0jlq42aZ77Ay5oQ7nhu7h/Um4w==
X-Received: by 2002:a17:90a:d648:b0:2ff:53a4:74f0 with SMTP id
 98e67ed59e1d1-30a4e6aa8d7mr852882a91.29.1746134478451; 
 Thu, 01 May 2025 14:21:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 05/59] accel/tcg: Add CPUState arg to tb_invalidate_phys_range
Date: Thu,  1 May 2025 14:20:19 -0700
Message-ID: <20250501212113.2961531-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index c893ea3073..c7600fc6ac 100644
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


