Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3CFC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tAo-0007aL-Tv; Thu, 24 Apr 2025 05:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tAj-0007Xn-NS
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tAh-0002Yp-8h
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so14635185e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488025; x=1746092825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/lW2jqTg4HxHkTVNBXLnGF3EuDazugPr6Lu2FtcqFU8=;
 b=DwZq6uAJnQP5QYZjBT48eR8EQk2jwTZ1Xn+fJxTJePF+0u7c+nwi875FApNCHfHiO/
 naQWg3mPLlMOhaSQnpIDCXmvyRdhqOmFT3ZXx1k9qQtYM2nNUIJtC8KnI6czYGSW/IZZ
 CGn/3YGTUroubjv4jyZp+SbtJA/Y+H8HvzJY2h8kp538/lRJAbZDFKSgFtoxh8x5W2cT
 w087j4jZLee2EnvRvAAlK3AZwFfV21UuGq3PvsIi4qZnguNgreVMmv3J31KmcM7TjU8N
 KkW0PlJi0nVySQnm1hHY/MIWbITRng88YLCM5cvVDZscxyOhsoAbfxn9bLgYACYjHzLJ
 7jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488025; x=1746092825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/lW2jqTg4HxHkTVNBXLnGF3EuDazugPr6Lu2FtcqFU8=;
 b=gPpZ8AK7zDBGLRYrf3tYDsUv+5yWG0wPKSYClre0LmnyveNF5hBL8GsZ0HOZcac7qC
 mzWKYmeEGed3rnxa9tYDmIUXTaZJtsCGoaDSDYrZypeN7jg+KKrYzb4OYLg0v8vyMB9x
 S5jFW+PXas/Y57x7Vo6/11UM5fmvdh+viNaltjaNFGE+amVboXh8RBiN4ucIgmP4VFJD
 r1FLNIWtTAyvoKoOj8td54rvhn8r9+Q+Lq/SmGuNpwxaR5fLEAUJVMMauCAq6w40s2sl
 rr8+/TI7O4HQztqv960t6hpO1us4+QG3UM7cfqVl3bCAvCqsU0Ulw5zEsKay7JOxS2uC
 coHg==
X-Gm-Message-State: AOJu0YyFLRFWZ2gxSf6mpKSF/XPo/W4tpJoiGIpmXchnQarvDfhypRUp
 CQGbw5U5+Iv4bzGo1MqPDGTd1PM8BhDzSDC4hRrgAJDPW16qQEG6dEcVIB+yOUCBJmLcwtPUpcI
 f
X-Gm-Gg: ASbGncuzxHjJZ1YLVzcniv1vfaHspUThJD+8uOFNK7CV47z7UClKuHyvVh4Ab5ixtMf
 XUcPIqhUNF08bS0veZir5qGMVrmV2gf197Q/A1DOKsj89Vz4IzJ8tH2PlQsGZBMfIx2CDycUxba
 RIyyoMgqJY/r9pGc3t+35xZwAWrkHFBoibGOJHUcfGPp4Cjj0GfI7ADsc6awHyaUXH/pACR/Zh6
 IRmhyBKRV1crR0592gB52qSSvnrGDOdoRr00pi3acidYNFhfRybm6m2GM4rSm7aUyNXGQsBtkqS
 SWsOibZobAjpKduK+R8I3veQvkcGcvGhXgrkqQWf/bCEIEC/4t3wdKRLJTimic1jFLIqRBfvyMf
 yCBUr8hA+DC1oxPbyE4mI
X-Google-Smtp-Source: AGHT+IEPAdTtCElbOdp/k0njQEPheioe6u9ZbVlb4DHzaAdm1AD8KUjUJAegQUNHTrsK7EFFsn93sQ==
X-Received: by 2002:a05:600c:1c23:b0:43c:ec72:3daf with SMTP id
 5b1f17b1804b1-4409c513fa7mr16522265e9.14.1745488025211; 
 Thu, 24 Apr 2025 02:47:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4408d0a7802sm48959455e9.1.2025.04.24.02.47.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 02:47:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/13] accel/tcg: Use vaddr in user/page-protection.h
Date: Thu, 24 Apr 2025 11:46:42 +0200
Message-ID: <20250424094653.35932-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424094653.35932-1-philmd@linaro.org>
References: <20250424094653.35932-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250424011918.599958-14-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/user/page-protection.h | 17 +++++-------
 accel/tcg/user-exec.c          | 51 ++++++++++++++++------------------
 2 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index 8f0b769b134..86143212fdd 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -12,14 +12,12 @@
 #error Cannot include this header from system emulation
 #endif
 
-#include "cpu-param.h"
-#include "exec/target_long.h"
 #include "exec/vaddr.h"
 #include "exec/translation-block.h"
 
 int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc);
 
-int page_get_flags(target_ulong address);
+int page_get_flags(vaddr address);
 
 /**
  * page_set_flags:
@@ -32,9 +30,9 @@ int page_get_flags(target_ulong address);
  * The flag PAGE_WRITE_ORG is positioned automatically depending
  * on PAGE_WRITE.  The mmap_lock should already be held.
  */
-void page_set_flags(target_ulong start, target_ulong last, int flags);
+void page_set_flags(vaddr start, vaddr last, int flags);
 
-void page_reset_target_data(target_ulong start, target_ulong last);
+void page_reset_target_data(vaddr start, vaddr last);
 
 /**
  * page_check_range
@@ -46,7 +44,7 @@ void page_reset_target_data(target_ulong start, target_ulong last);
  * Return false if any page is unmapped.  Thus testing flags == 0 is
  * equivalent to testing for flags == PAGE_VALID.
  */
-bool page_check_range(target_ulong start, target_ulong last, int flags);
+bool page_check_range(vaddr start, vaddr last, int flags);
 
 /**
  * page_check_range_empty:
@@ -58,7 +56,7 @@ bool page_check_range(target_ulong start, target_ulong last, int flags);
  * The memory lock must be held so that the caller will can ensure
  * the result stays true until a new mapping can be installed.
  */
-bool page_check_range_empty(target_ulong start, target_ulong last);
+bool page_check_range_empty(vaddr start, vaddr last);
 
 /**
  * page_find_range_empty
@@ -72,8 +70,7 @@ bool page_check_range_empty(target_ulong start, target_ulong last);
  * The memory lock must be held, as the caller will want to ensure
  * the returned range stays empty until a new mapping can be installed.
  */
-target_ulong page_find_range_empty(target_ulong min, target_ulong max,
-                                   target_ulong len, target_ulong align);
+vaddr page_find_range_empty(vaddr min, vaddr max, vaddr len, vaddr align);
 
 /**
  * page_get_target_data(address)
@@ -87,7 +84,7 @@ target_ulong page_find_range_empty(target_ulong min, target_ulong max,
  * e.g. with the munmap system call.
  */
 __attribute__((returns_nonnull))
-void *page_get_target_data(target_ulong address);
+void *page_get_target_data(vaddr address);
 
 typedef int (*walk_memory_regions_fn)(void *, vaddr, vaddr, int);
 int walk_memory_regions(void *, walk_memory_regions_fn);
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 25d86567e70..43d005e24e4 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -161,7 +161,7 @@ typedef struct PageFlagsNode {
 
 static IntervalTreeRoot pageflags_root;
 
-static PageFlagsNode *pageflags_find(target_ulong start, target_ulong last)
+static PageFlagsNode *pageflags_find(vaddr start, vaddr last)
 {
     IntervalTreeNode *n;
 
@@ -169,8 +169,7 @@ static PageFlagsNode *pageflags_find(target_ulong start, target_ulong last)
     return n ? container_of(n, PageFlagsNode, itree) : NULL;
 }
 
-static PageFlagsNode *pageflags_next(PageFlagsNode *p, target_ulong start,
-                                     target_ulong last)
+static PageFlagsNode *pageflags_next(PageFlagsNode *p, vaddr start, vaddr last)
 {
     IntervalTreeNode *n;
 
@@ -215,14 +214,14 @@ static int dump_region(void *opaque, vaddr start, vaddr end, int prot)
 /* dump memory mappings */
 void page_dump(FILE *f)
 {
-    const int length = sizeof(target_ulong) * 2;
+    const int length = sizeof(abi_ptr) * 2;
 
     fprintf(f, "%-*s %-*s %-*s %s\n",
             length, "start", length, "end", length, "size", "prot");
     walk_memory_regions(f, dump_region);
 }
 
-int page_get_flags(target_ulong address)
+int page_get_flags(vaddr address)
 {
     PageFlagsNode *p = pageflags_find(address, address);
 
@@ -245,7 +244,7 @@ int page_get_flags(target_ulong address)
 }
 
 /* A subroutine of page_set_flags: insert a new node for [start,last]. */
-static void pageflags_create(target_ulong start, target_ulong last, int flags)
+static void pageflags_create(vaddr start, vaddr last, int flags)
 {
     PageFlagsNode *p = g_new(PageFlagsNode, 1);
 
@@ -256,13 +255,13 @@ static void pageflags_create(target_ulong start, target_ulong last, int flags)
 }
 
 /* A subroutine of page_set_flags: remove everything in [start,last]. */
-static bool pageflags_unset(target_ulong start, target_ulong last)
+static bool pageflags_unset(vaddr start, vaddr last)
 {
     bool inval_tb = false;
 
     while (true) {
         PageFlagsNode *p = pageflags_find(start, last);
-        target_ulong p_last;
+        vaddr p_last;
 
         if (!p) {
             break;
@@ -301,8 +300,7 @@ static bool pageflags_unset(target_ulong start, target_ulong last)
  * A subroutine of page_set_flags: nothing overlaps [start,last],
  * but check adjacent mappings and maybe merge into a single range.
  */
-static void pageflags_create_merge(target_ulong start, target_ulong last,
-                                   int flags)
+static void pageflags_create_merge(vaddr start, vaddr last, int flags)
 {
     PageFlagsNode *next = NULL, *prev = NULL;
 
@@ -353,11 +351,11 @@ static void pageflags_create_merge(target_ulong start, target_ulong last,
 #define PAGE_STICKY  (PAGE_ANON | PAGE_PASSTHROUGH | PAGE_TARGET_STICKY)
 
 /* A subroutine of page_set_flags: add flags to [start,last]. */
-static bool pageflags_set_clear(target_ulong start, target_ulong last,
+static bool pageflags_set_clear(vaddr start, vaddr last,
                                 int set_flags, int clear_flags)
 {
     PageFlagsNode *p;
-    target_ulong p_start, p_last;
+    vaddr p_start, p_last;
     int p_flags, merge_flags;
     bool inval_tb = false;
 
@@ -492,7 +490,7 @@ static bool pageflags_set_clear(target_ulong start, target_ulong last,
     return inval_tb;
 }
 
-void page_set_flags(target_ulong start, target_ulong last, int flags)
+void page_set_flags(vaddr start, vaddr last, int flags)
 {
     bool reset = false;
     bool inval_tb = false;
@@ -532,9 +530,9 @@ void page_set_flags(target_ulong start, target_ulong last, int flags)
     }
 }
 
-bool page_check_range(target_ulong start, target_ulong len, int flags)
+bool page_check_range(vaddr start, vaddr len, int flags)
 {
-    target_ulong last;
+    vaddr last;
     int locked;  /* tri-state: =0: unlocked, +1: global, -1: local */
     bool ret;
 
@@ -610,17 +608,16 @@ bool page_check_range(target_ulong start, target_ulong len, int flags)
     return ret;
 }
 
-bool page_check_range_empty(target_ulong start, target_ulong last)
+bool page_check_range_empty(vaddr start, vaddr last)
 {
     assert(last >= start);
     assert_memory_lock();
     return pageflags_find(start, last) == NULL;
 }
 
-target_ulong page_find_range_empty(target_ulong min, target_ulong max,
-                                   target_ulong len, target_ulong align)
+vaddr page_find_range_empty(vaddr min, vaddr max, vaddr len, vaddr align)
 {
-    target_ulong len_m1, align_m1;
+    vaddr len_m1, align_m1;
 
     assert(min <= max);
     assert(max <= GUEST_ADDR_MAX);
@@ -661,7 +658,7 @@ target_ulong page_find_range_empty(target_ulong min, target_ulong max,
 void tb_lock_page0(tb_page_addr_t address)
 {
     PageFlagsNode *p;
-    target_ulong start, last;
+    vaddr start, last;
     int host_page_size = qemu_real_host_page_size();
     int prot;
 
@@ -740,7 +737,7 @@ int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc)
         }
     } else {
         int host_page_size = qemu_real_host_page_size();
-        target_ulong start, len, i;
+        vaddr start, len, i;
         int prot;
 
         if (host_page_size <= TARGET_PAGE_SIZE) {
@@ -756,7 +753,7 @@ int page_unprotect(CPUState *cpu, tb_page_addr_t address, uintptr_t pc)
             prot = 0;
 
             for (i = 0; i < len; i += TARGET_PAGE_SIZE) {
-                target_ulong addr = start + i;
+                vaddr addr = start + i;
 
                 p = pageflags_find(addr, addr);
                 if (p) {
@@ -883,7 +880,7 @@ typedef struct TargetPageDataNode {
 
 static IntervalTreeRoot targetdata_root;
 
-void page_reset_target_data(target_ulong start, target_ulong last)
+void page_reset_target_data(vaddr start, vaddr last)
 {
     IntervalTreeNode *n, *next;
 
@@ -897,7 +894,7 @@ void page_reset_target_data(target_ulong start, target_ulong last)
          n != NULL;
          n = next,
          next = next ? interval_tree_iter_next(n, start, last) : NULL) {
-        target_ulong n_start, n_last, p_ofs, p_len;
+        vaddr n_start, n_last, p_ofs, p_len;
         TargetPageDataNode *t = container_of(n, TargetPageDataNode, itree);
 
         if (n->start >= start && n->last <= last) {
@@ -921,11 +918,11 @@ void page_reset_target_data(target_ulong start, target_ulong last)
     }
 }
 
-void *page_get_target_data(target_ulong address)
+void *page_get_target_data(vaddr address)
 {
     IntervalTreeNode *n;
     TargetPageDataNode *t;
-    target_ulong page, region, p_ofs;
+    vaddr page, region, p_ofs;
 
     page = address & TARGET_PAGE_MASK;
     region = address & TBD_MASK;
@@ -956,7 +953,7 @@ void *page_get_target_data(target_ulong address)
     return t->data + p_ofs * TARGET_PAGE_DATA_SIZE;
 }
 #else
-void page_reset_target_data(target_ulong start, target_ulong last) { }
+void page_reset_target_data(vaddr start, vaddr last) { }
 #endif /* TARGET_PAGE_DATA_SIZE */
 
 /* The system-mode versions of these helpers are in cputlb.c.  */
-- 
2.47.1


