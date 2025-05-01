Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A869C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLp-00011g-6Z; Thu, 01 May 2025 17:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLW-0000mP-5i
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:31 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLT-0001TG-9T
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:29 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso1549704a91.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134485; x=1746739285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=entENXAMz1Bx+vUYaykE2T9Ny+7ZC4E3qmeTwzVtgpg=;
 b=io3RK1WZ0DG9qLe2Y3qCM+mD8IDZh/eZJ/gJ5mL91hM2bGjWtLgklBVRZZge39rT0W
 /V+tqw2STvvAfU/C6ZlvcSWrlXElTE8gB93gUOLYuLEUjRv3UUTAUtol/oMoEKE/m4mW
 2lRV44IwUID8mAnmseONU5J26VpoPrRHko6Bb/GRmXRzmDe24sxqFs4FyRzr5nbtPVCS
 qhtJqjG2QNgBtJ+juRHdbusHb5hp5t+T2RfyKxBY3ZPzS3RuoYK7oaMyu9j44FwvG2Hx
 Jgh/o7yzrW1379066GHLYMPFcC+59j/KnV6pjSvEbZ5/92NnGait81QxbnbcutlXm+I/
 V+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134485; x=1746739285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=entENXAMz1Bx+vUYaykE2T9Ny+7ZC4E3qmeTwzVtgpg=;
 b=hlruEHmTAe6kvPULy7NWqqANqqx1l39BGigW5a6IniM5v0yRdYA6ouas6m8dni21lT
 abLg/hUAJvV0QtSElmJiWjDE9/UhKJlp/N9EqOH6D4bkuvyZ1wYTLc+f2qzUByzOomZb
 ChUJkqkO6O2gHl25Nmj0xlYtc1xkzsJJ1s8Tm/wnuTYfmGBdPEIBLjHIHoXym/ptTuDv
 CjRWC0vTXkvRWKIlmhFLcusrON4oRLnsAdJi6nN/8lc+g2XD57K5SzsLYZVq+BOabjA4
 zS40evzVPCvC+X71driH+C3Pj/RNR/+rdVHtYb0a/7cH6l6jx+2sjkKpu/6NKERFLQF6
 b0Kg==
X-Gm-Message-State: AOJu0Yxqz1Y+UgnoqaqEZNsvPk8sUae771wvoMoKApGlIcwsmLO1XjAG
 VmdQYXwkaHkDufruKOfmpex8NxiS+SsNq5CaHATRgp0zZ6E2LSY6OpuLJNfgq5dV0S07e7jvkle
 w
X-Gm-Gg: ASbGncv+DcEZNRndYc50AhnshfBpoDQp94izvBCzBOEENrNj3kVlS2S/6YCQLxnypPs
 wBA/5cwL5xZH+6A2a42/up4DoWEQNK/6VvAQoqWVLMwNSoWwSCUELNgynEjFjqZYA+j25DZvWjr
 uQFKgEUaPnu8pZ4hoO0kh0d0SVGl2FpPPmNQw+TMGep+HZJnlts91DB6BlJIp2Z7CWb1rgiUbhw
 HnMN6KBLqMdIAjGiopL1jS1Jg5Yf3vlCWBT+khmjt5eMRcceGBTMtO00DfGoweAHFQRmfTuWkat
 nONGcw+laj4NPsbojtVGJzmxSElDlpOtp9poaWOfz44DMMyDepG8JFpXKXBzwGK/9McL8VldMrU
 =
X-Google-Smtp-Source: AGHT+IG6pDk7y141meAgXBOXqpPkGsP394BkRfh8mzLQQqKMyvLK4nfKC+zH4WgQ2nmkwcj0oV0fsQ==
X-Received: by 2002:a17:90b:3a10:b0:2f2:a664:df1a with SMTP id
 98e67ed59e1d1-30a4e578b51mr963025a91.2.1746134485568; 
 Thu, 01 May 2025 14:21:25 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/59] accel/tcg: Use vaddr in user/page-protection.h
Date: Thu,  1 May 2025 14:20:27 -0700
Message-ID: <20250501212113.2961531-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/page-protection.h | 17 +++++-------
 accel/tcg/user-exec.c          | 51 ++++++++++++++++------------------
 2 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index 8f0b769b13..86143212fd 100644
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
index 25d86567e7..43d005e24e 100644
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
2.43.0


