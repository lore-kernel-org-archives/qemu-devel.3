Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF728C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 14:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVKC-0005kL-NJ; Thu, 01 May 2025 10:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJz-0005hG-VY
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:31 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVJx-0005W8-UR
 for qemu-devel@nongnu.org; Thu, 01 May 2025 10:55:31 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2279915e06eso11716665ad.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746111328; x=1746716128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=K93yqXiT68gefwedjtdMyWq1+8RZcqNvsUBZSLOQy7s=;
 b=tV3z/Cxo0QraFqqC6MCbopKi1AxuoGsesNjyQggEs/55Q2sHn6oW661WwJPqLs25UU
 F9KTnT1C7PIsVS6N5SKXE8KakZf7OoWrg9FQexDRhz1n0H1MZmqfHpo0/eyObKhvrvVk
 LU3zqzcl8+6KvKpHuMYzT/1fCeVq/xooeSwQiMtkizaRTmvcfQRPbmq4Ef2I6Z0Zr1du
 1WVXMNiSxxuIxlQtwa8pKFkiCCbq5BmuU7a/Qv07QOfXEzY3vNYBuN65jiHkLVCb4YA5
 l2pmpv9KaEGnRZEIIETV+UhsEBfrfJV8VdDLlUpWzJk/wVPAsdy48z8FIkAFJ7w5z9sR
 gyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111328; x=1746716128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K93yqXiT68gefwedjtdMyWq1+8RZcqNvsUBZSLOQy7s=;
 b=nlrsf1H8md96T+qRanueVnKftMutsRk66DxSgp+hMu4X1ox1LBvFkAoEWm8KApmj+u
 27LTVVU/5K+rCj1weVCD4cUdLRCnBNVG3sdY81XmD3/ekSz8dXelgsfpCKTGbGcLj9R/
 Q0CUPeSgEAFxoypnEmyf5NILGYW/wFqODFbsSAVqeG0AVS+BFm9PCBffGQ4VtCXrOKuU
 Lav/lkQdUBk2PM+jVlNNYnoljJ4UCi4VycnZ40D+btrVosUbnJ5ZZ3wq0quyxbwcu+6O
 Bpw9qriCdRBDdLgA54LteFY1gM0muw1oO5Ecg+4c3jcoNuX3tae9MndCqvsXD20t1gJy
 5x8g==
X-Gm-Message-State: AOJu0YzWXGzYP1NUetstq4Gnd2qK3/WjvUtdVYAto2j/OFiPs4nZYH6e
 kLB4FyZwubwCIIBb4CHHwMHKHhX92Be3LjywYuL+9gnpZzTCCidiplAh15DwIHp+ONY9uzW7+fp
 t
X-Gm-Gg: ASbGncvEf0yzdjuVAV5C67q2wLfYh59C2tqnmo1AeA3FSOH4+Tz/3Hlfm0x0SM0siA1
 nBKfV6teqmC/U7xRTd61GeLaSA1iQpwhPEc/dMxi7BGBVqD45cgXZN+SwqV0Y2YlP4eKvrUoaHR
 UnFxZwgt2cTUvZH6XiT7B3xP8kEV5pNzSwQv3BTfZYbgOd5ZlZ5mUqpNN2KAWsN05RTkym4JftH
 qTKQQYXbX5U9RXZDM0mEl1z3pzMUuH2kOq4bSh/MYq+4M4EyBMF9MzZR95M6nk+pKOi9s83bpuJ
 19EvknzCq5/PC/T5Q+wdAJ9Klu7P9zg20XNF3zlZbE2wSPBWam2jml2csQBFrSnMigpnQmrpsNp
 EqibSoI1rlw==
X-Google-Smtp-Source: AGHT+IEPtFaQdYEKO0sb5zTzRR+efeCWapldh5RlIDBphIbC38TZ4txuMGgr1ORfJn2BTQ//yIKmFQ==
X-Received: by 2002:a17:902:ce82:b0:223:5241:f5ca with SMTP id
 d9443c01a7336-22e040bf431mr44250755ad.20.1746111327667; 
 Thu, 01 May 2025 07:55:27 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e0bb0e770sm7644415ad.92.2025.05.01.07.55.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:55:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/11] accel/tcg: Remove TARGET_PAGE_DATA_SIZE
Date: Thu,  1 May 2025 07:55:17 -0700
Message-ID: <20250501145520.2695073-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501145520.2695073-1-richard.henderson@linaro.org>
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

This macro is used by only one target, and even then under
unusual conditions -- AArch64 with mmap's PROT_MTE flag.

Since page size for aarch64-linux-user is variable, the
per-page data size is also variable.
Since page_reset_target_data via target_munmap does not
have ready access to CPUState, simply pass in the size
from the first allocation and remember that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/user/page-protection.h |  8 +++++---
 target/arm/cpu.h               |  4 ----
 accel/tcg/user-exec.c          | 26 ++++++++++++++++----------
 target/arm/tcg/mte_helper.c    |  4 ++--
 4 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index 86143212fd..4bde664e4a 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -73,18 +73,20 @@ bool page_check_range_empty(vaddr start, vaddr last);
 vaddr page_find_range_empty(vaddr min, vaddr max, vaddr len, vaddr align);
 
 /**
- * page_get_target_data(address)
+ * page_get_target_data
  * @address: guest virtual address
+ * @size: per-page size
  *
- * Return TARGET_PAGE_DATA_SIZE bytes of out-of-band data to associate
+ * Return @size bytes of out-of-band data to associate
  * with the guest page at @address, allocating it if necessary.  The
  * caller should already have verified that the address is valid.
+ * The value of @size must be the same for every call.
  *
  * The memory will be freed when the guest page is deallocated,
  * e.g. with the munmap system call.
  */
 __attribute__((returns_nonnull))
-void *page_get_target_data(vaddr address);
+void *page_get_target_data(vaddr address, size_t size);
 
 typedef int (*walk_memory_regions_fn)(void *, vaddr, vaddr, int);
 int walk_memory_regions(void *, walk_memory_regions_fn);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 23720b2b17..6ed6409cb7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3213,8 +3213,4 @@ extern const uint64_t pred_esz_masks[5];
 #define LOG2_TAG_GRANULE 4
 #define TAG_GRANULE      (1 << LOG2_TAG_GRANULE)
 
-#ifdef CONFIG_USER_ONLY
-#define TARGET_PAGE_DATA_SIZE (TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1))
-#endif /* CONFIG_USER_ONLY */
-
 #endif
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f674fd875e..46b1e97c30 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -870,7 +870,6 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
     return addr;
 }
 
-#ifdef TARGET_PAGE_DATA_SIZE
 /*
  * Allocate chunks of target data together.  For the only current user,
  * if we allocate one hunk per page, we have overhead of 40/128 or 40%.
@@ -886,10 +885,16 @@ typedef struct TargetPageDataNode {
 } TargetPageDataNode;
 
 static IntervalTreeRoot targetdata_root;
+static size_t target_page_data_size;
 
 void page_reset_target_data(vaddr start, vaddr last)
 {
     IntervalTreeNode *n, *next;
+    size_t size = target_page_data_size;
+
+    if (likely(size == 0)) {
+        return;
+    }
 
     assert_memory_lock();
 
@@ -920,17 +925,22 @@ void page_reset_target_data(vaddr start, vaddr last)
         n_last = MIN(last, n->last);
         p_len = (n_last + 1 - n_start) >> TARGET_PAGE_BITS;
 
-        memset(t->data + p_ofs * TARGET_PAGE_DATA_SIZE, 0,
-               p_len * TARGET_PAGE_DATA_SIZE);
+        memset(t->data + p_ofs * size, 0, p_len * size);
     }
 }
 
-void *page_get_target_data(vaddr address)
+void *page_get_target_data(vaddr address, size_t size)
 {
     IntervalTreeNode *n;
     TargetPageDataNode *t;
     vaddr page, region, p_ofs;
 
+    /* Remember the size from the first call, and it should be constant. */
+    if (unlikely(target_page_data_size != size)) {
+        assert(target_page_data_size == 0);
+        target_page_data_size = size;
+    }
+
     page = address & TARGET_PAGE_MASK;
     region = address & TBD_MASK;
 
@@ -945,8 +955,7 @@ void *page_get_target_data(vaddr address)
         mmap_lock();
         n = interval_tree_iter_first(&targetdata_root, page, page);
         if (!n) {
-            t = g_malloc0(sizeof(TargetPageDataNode)
-                          + TPD_PAGES * TARGET_PAGE_DATA_SIZE);
+            t = g_malloc0(sizeof(TargetPageDataNode) + TPD_PAGES * size);
             n = &t->itree;
             n->start = region;
             n->last = region | ~TBD_MASK;
@@ -957,11 +966,8 @@ void *page_get_target_data(vaddr address)
 
     t = container_of(n, TargetPageDataNode, itree);
     p_ofs = (page - region) >> TARGET_PAGE_BITS;
-    return t->data + p_ofs * TARGET_PAGE_DATA_SIZE;
+    return t->data + p_ofs * size;
 }
-#else
-void page_reset_target_data(vaddr start, vaddr last) { }
-#endif /* TARGET_PAGE_DATA_SIZE */
 
 /* The system-mode versions of these helpers are in cputlb.c.  */
 
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 13d7ac0097..0efc18a181 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -37,7 +37,6 @@
 #include "qemu/guest-random.h"
 #include "mte_helper.h"
 
-
 static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
 {
     if (exclude == 0xffff) {
@@ -63,6 +62,7 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
                                   bool probe, uintptr_t ra)
 {
 #ifdef CONFIG_USER_ONLY
+    const size_t page_data_size = TARGET_PAGE_SIZE >> (LOG2_TAG_GRANULE + 1);
     uint64_t clean_ptr = useronly_clean_ptr(ptr);
     int flags = page_get_flags(clean_ptr);
     uint8_t *tags;
@@ -83,7 +83,7 @@ uint8_t *allocation_tag_mem_probe(CPUARMState *env, int ptr_mmu_idx,
         return NULL;
     }
 
-    tags = page_get_target_data(clean_ptr);
+    tags = page_get_target_data(clean_ptr, page_data_size);
 
     index = extract32(ptr, LOG2_TAG_GRANULE + 1,
                       TARGET_PAGE_BITS - LOG2_TAG_GRANULE - 1);
-- 
2.43.0


