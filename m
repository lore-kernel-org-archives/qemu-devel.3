Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64EE4CAC5AC
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 02:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Ev6-0002z7-AJ; Tue, 23 Sep 2025 22:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ev2-0002xD-Ro
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 22:07:44 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Euz-0002bs-PF
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 22:07:44 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b54a588ad96so420907a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 19:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758679660; x=1759284460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jABygsIZug9i9bIaQapu8hPs02ozJyRszjhHECbv97E=;
 b=Y1/mNrTSGODFRPq5b/eZ6YH6rrBkT7ZZvQ/YAEnhLJaZff2L3y/sn8Rq2GfVHOdESk
 ANlnBzkWkax63/yixl7qZMtIMzi1y91PzUFhmfL3PhskyVGevLBCglC/Ah2h018xOAkD
 WRbhqkL5RW2DbJQnjJDkNno45qOEWEdXT7DkKH5XEhNXHfpLUKdaaeuHN9b/uby1z0u8
 9DcFJcmpCSjhNKjqjGLhdpdb/1vC05i1OM3q7pLm0DPKqjLeAcMcLniSwoI5boaWEtZP
 4hgilNLHYrcjin1KjTGs+6VPT0NeSPgq5C/klPKvB91w2c5rKknRIG2Zp8Sfr7oIENSE
 bR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758679660; x=1759284460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jABygsIZug9i9bIaQapu8hPs02ozJyRszjhHECbv97E=;
 b=syYCLovtVcvpSvwPGm1/I9H6SF5u8W6kQuN1/UzsdDIcQp/D8UT2yTSlsxx0PMpe54
 PCoDDuIJqtz8N4j2zTsSNKaKPew7iDDcuxGUR/7ba9FzenjBrCT43rLjl72UW42F/Ub6
 SgmCjFJAfvmE9GTi6ouckEJHgKJcG7eVmDEQ7GhCG/2+HiENsuBPxTb+PobV6rEoLhGA
 frQjxwu9Pyk7rBfYzfHRuGMTrKTERDc2R2Ic74YeuOz77QO/hphRSHkQjEJdJYnNFpJX
 vEI+IPgIx5nWUSnHaUXnFJD6f7DwJu/CqDdW4LUuyX/ESrAWqWetZPwvbdxBqlOhnc7J
 j77g==
X-Gm-Message-State: AOJu0YwRvslf4TnPNmX4WSuzg1V4tDy7HfNls7tKr1QEj+GrMNw5Zyh8
 zF/LfkCpwZdI3kgUbBUTrzR3x+JZ10XsDYBFRjfulgO6f9gCMrDRdxK9zPzM2TzSE0jK+s+vxLV
 OJiAg
X-Gm-Gg: ASbGncuf+Mdd4wb8wm+K0I7Z6zGpgOo0zgdBHqJVxQZA0pJluakeq+LNCBkux7W0cCb
 PRscaSDjjuyYFsY0a94NhTgeoSbyQnnYsdRd1a9gb0PRlWQlZxvm2pcKHfOlNWOOSQ8JEkG3U3v
 7rU7dvgtcY+JuQHaQeCcUq65HcVdAJbAf80fO7RuvxRVJ+aR6Ka5+Lyn59lL2hMzdinZGNZ8f+2
 qWLdvHBsrTdoudKwjVtsi3wrgSMltEI3Vm8HpsyH4P0ZOwPRK1aFX2cD9fzujeea4va74+k+uxt
 FpoDhDC0JEQi+ANOxxgCAYCT/i4qlzdMeU7qWt8g1cThkxYEzMu+3VF6fcEEoljWPDqWD6En/c9
 G22UqWPGM69Kv+I0oGg26ZG6dS/Jj
X-Google-Smtp-Source: AGHT+IFarHjhrS56Y7evxaPRuu84KUimJqkH0J1E44x1FSqWSyOMALnA/BEoSmjiZNv+w6TZATnVjA==
X-Received: by 2002:a17:902:f645:b0:276:54f3:e6b with SMTP id
 d9443c01a7336-27ec13af4cbmr6672095ad.27.1758679659440; 
 Tue, 23 Sep 2025 19:07:39 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3341bcd9afbsm565664a91.0.2025.09.23.19.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 19:07:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jonwilson030981@googlemail.com
Subject: [PATCH 1/2] accel/tcg: Add clear_flags argument to page_set_flags
Date: Tue, 23 Sep 2025 19:07:33 -0700
Message-ID: <20250924020735.3909216-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924020735.3909216-1-richard.henderson@linaro.org>
References: <20250924020735.3909216-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Expand the interface of page_set_flags to separate the
set of flags to be set and the set of flags to be cleared.

This allows us to replace PAGE_RESET with the PAGE_VALID
bit within clear_flags.

Replace PAGE_TARGET_STICKY with TARGET_PAGE_NOTSTICKY;
aarch64-linux-user is the only user.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.h             |   7 +-
 include/exec/page-protection.h |  13 ++--
 include/user/page-protection.h |   9 ++-
 target/arm/cpu.h               |   1 -
 accel/tcg/user-exec.c          | 114 +++++++++------------------------
 bsd-user/mmap.c                |   6 +-
 linux-user/arm/elfload.c       |   2 +-
 linux-user/hppa/elfload.c      |   2 +-
 linux-user/mmap.c              |  32 +++++----
 linux-user/x86_64/elfload.c    |   2 +-
 10 files changed, 71 insertions(+), 117 deletions(-)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 1be906c591..416d0f8c23 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -390,8 +390,9 @@ static inline abi_long do_bsd_shmat(int shmid, abi_ulong shmaddr, int shmflg)
         raddr = h2g(host_raddr);
 
         page_set_flags(raddr, raddr + shm_info.shm_segsz - 1,
-                       PAGE_VALID | PAGE_RESET | PAGE_READ |
-                       (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE));
+                       PAGE_VALID | PAGE_READ |
+                       (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE),
+                       PAGE_VALID);
 
         for (int i = 0; i < N_BSD_SHM_REGIONS; i++) {
             if (bsd_shm_regions[i].start == 0) {
@@ -428,7 +429,7 @@ static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)
             abi_ulong size = bsd_shm_regions[i].size;
 
             bsd_shm_regions[i].start = 0;
-            page_set_flags(shmaddr, shmaddr + size - 1, 0);
+            page_set_flags(shmaddr, shmaddr + size - 1, 0, PAGE_VALID);
             mmap_reserve(shmaddr, size);
         }
     }
diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
index c43231af8b..5a18f98a3a 100644
--- a/include/exec/page-protection.h
+++ b/include/exec/page-protection.h
@@ -23,8 +23,11 @@
  * Low-Address-Protection. Used with PAGE_WRITE in tlb_set_page_with_attrs()
  */
 #define PAGE_WRITE_INV 0x0020
-/* For use with page_set_flags: page is being replaced; target_data cleared. */
-#define PAGE_RESET     0x0040
+/*
+ * For linux-user, indicates that the page is mapped with the same semantics
+ * in both guest and host.
+ */
+#define PAGE_PASSTHROUGH 0x40
 /* For linux-user, indicates that the page is MAP_ANON. */
 #define PAGE_ANON      0x0080
 
@@ -32,10 +35,4 @@
 #define PAGE_TARGET_1  0x0200
 #define PAGE_TARGET_2  0x0400
 
-/*
- * For linux-user, indicates that the page is mapped with the same semantics
- * in both guest and host.
- */
-#define PAGE_PASSTHROUGH 0x0800
-
 #endif
diff --git a/include/user/page-protection.h b/include/user/page-protection.h
index 4bde664e4a..41b23e72fc 100644
--- a/include/user/page-protection.h
+++ b/include/user/page-protection.h
@@ -23,14 +23,19 @@ int page_get_flags(vaddr address);
  * page_set_flags:
  * @start: first byte of range
  * @last: last byte of range
- * @flags: flags to set
+ * @set_flags: flags to set
+ * @clr_flags: flags to clear
  * Context: holding mmap lock
  *
  * Modify the flags of a page and invalidate the code if necessary.
  * The flag PAGE_WRITE_ORG is positioned automatically depending
  * on PAGE_WRITE.  The mmap_lock should already be held.
+ *
+ * For each page, flags = (flags & ~clr_flags) | set_flags.
+ * If clr_flags includes PAGE_VALID, this indicates a new mapping
+ * and page_reset_target_data will be called as well.
  */
-void page_set_flags(vaddr start, vaddr last, int flags);
+void page_set_flags(vaddr start, vaddr last, int set_flags, int clr_flags);
 
 void page_reset_target_data(vaddr start, vaddr last);
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1c0deb723d..6bd6d879ef 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3224,7 +3224,6 @@ extern const uint64_t pred_esz_masks[5];
  */
 #define PAGE_BTI            PAGE_TARGET_1
 #define PAGE_MTE            PAGE_TARGET_2
-#define PAGE_TARGET_STICKY  PAGE_MTE
 
 /* We associate one allocation tag per 16 bytes, the minimum.  */
 #define LOG2_TAG_GRANULE 4
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 916f18754f..1800dffa63 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -269,48 +269,6 @@ static void pageflags_create(vaddr start, vaddr last, int flags)
     interval_tree_insert(&p->itree, &pageflags_root);
 }
 
-/* A subroutine of page_set_flags: remove everything in [start,last]. */
-static bool pageflags_unset(vaddr start, vaddr last)
-{
-    bool inval_tb = false;
-
-    while (true) {
-        PageFlagsNode *p = pageflags_find(start, last);
-        vaddr p_last;
-
-        if (!p) {
-            break;
-        }
-
-        if (p->flags & PAGE_EXEC) {
-            inval_tb = true;
-        }
-
-        interval_tree_remove(&p->itree, &pageflags_root);
-        p_last = p->itree.last;
-
-        if (p->itree.start < start) {
-            /* Truncate the node from the end, or split out the middle. */
-            p->itree.last = start - 1;
-            interval_tree_insert(&p->itree, &pageflags_root);
-            if (last < p_last) {
-                pageflags_create(last + 1, p_last, p->flags);
-                break;
-            }
-        } else if (p_last <= last) {
-            /* Range completely covers node -- remove it. */
-            g_free_rcu(p, rcu);
-        } else {
-            /* Truncate the node from the start. */
-            p->itree.start = last + 1;
-            interval_tree_insert(&p->itree, &pageflags_root);
-            break;
-        }
-    }
-
-    return inval_tb;
-}
-
 /*
  * A subroutine of page_set_flags: nothing overlaps [start,last],
  * but check adjacent mappings and maybe merge into a single range.
@@ -356,15 +314,6 @@ static void pageflags_create_merge(vaddr start, vaddr last, int flags)
     }
 }
 
-/*
- * Allow the target to decide if PAGE_TARGET_[12] may be reset.
- * By default, they are not kept.
- */
-#ifndef PAGE_TARGET_STICKY
-#define PAGE_TARGET_STICKY  0
-#endif
-#define PAGE_STICKY  (PAGE_ANON | PAGE_PASSTHROUGH | PAGE_TARGET_STICKY)
-
 /* A subroutine of page_set_flags: add flags to [start,last]. */
 static bool pageflags_set_clear(vaddr start, vaddr last,
                                 int set_flags, int clear_flags)
@@ -377,7 +326,7 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
  restart:
     p = pageflags_find(start, last);
     if (!p) {
-        if (set_flags) {
+        if (set_flags & PAGE_VALID) {
             pageflags_create_merge(start, last, set_flags);
         }
         goto done;
@@ -391,11 +340,12 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
 
     /*
      * Need to flush if an overlapping executable region
-     * removes exec, or adds write.
+     * removes exec, adds write, or is a new mapping.
      */
     if ((p_flags & PAGE_EXEC)
         && (!(merge_flags & PAGE_EXEC)
-            || (merge_flags & ~p_flags & PAGE_WRITE))) {
+            || (merge_flags & ~p_flags & PAGE_WRITE)
+            || (clear_flags & PAGE_VALID))) {
         inval_tb = true;
     }
 
@@ -404,7 +354,7 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
      * attempting to merge with adjacent regions.
      */
     if (start == p_start && last == p_last) {
-        if (merge_flags) {
+        if (merge_flags & PAGE_VALID) {
             p->flags = merge_flags;
         } else {
             interval_tree_remove(&p->itree, &pageflags_root);
@@ -424,12 +374,12 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
             interval_tree_insert(&p->itree, &pageflags_root);
 
             if (last < p_last) {
-                if (merge_flags) {
+                if (merge_flags & PAGE_VALID) {
                     pageflags_create(start, last, merge_flags);
                 }
                 pageflags_create(last + 1, p_last, p_flags);
             } else {
-                if (merge_flags) {
+                if (merge_flags & PAGE_VALID) {
                     pageflags_create(start, p_last, merge_flags);
                 }
                 if (p_last < last) {
@@ -438,18 +388,18 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
                 }
             }
         } else {
-            if (start < p_start && set_flags) {
+            if (start < p_start && (set_flags & PAGE_VALID)) {
                 pageflags_create(start, p_start - 1, set_flags);
             }
             if (last < p_last) {
                 interval_tree_remove(&p->itree, &pageflags_root);
                 p->itree.start = last + 1;
                 interval_tree_insert(&p->itree, &pageflags_root);
-                if (merge_flags) {
+                if (merge_flags & PAGE_VALID) {
                     pageflags_create(start, last, merge_flags);
                 }
             } else {
-                if (merge_flags) {
+                if (merge_flags & PAGE_VALID) {
                     p->flags = merge_flags;
                 } else {
                     interval_tree_remove(&p->itree, &pageflags_root);
@@ -497,7 +447,7 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
         g_free_rcu(p, rcu);
         goto restart;
     }
-    if (set_flags) {
+    if (set_flags & PAGE_VALID) {
         pageflags_create(start, last, set_flags);
     }
 
@@ -505,42 +455,36 @@ static bool pageflags_set_clear(vaddr start, vaddr last,
     return inval_tb;
 }
 
-void page_set_flags(vaddr start, vaddr last, int flags)
+void page_set_flags(vaddr start, vaddr last, int set_flags, int clear_flags)
 {
-    bool reset = false;
-    bool inval_tb = false;
-
-    /* This function should never be called with addresses outside the
-       guest address space.  If this assert fires, it probably indicates
-       a missing call to h2g_valid.  */
+    /*
+     * This function should never be called with addresses outside the
+     * guest address space.  If this assert fires, it probably indicates
+     * a missing call to h2g_valid.
+     */
     assert(start <= last);
     assert(last <= guest_addr_max);
-    /* Only set PAGE_ANON with new mappings. */
-    assert(!(flags & PAGE_ANON) || (flags & PAGE_RESET));
     assert_memory_lock();
 
     start &= TARGET_PAGE_MASK;
     last |= ~TARGET_PAGE_MASK;
 
-    if (!(flags & PAGE_VALID)) {
-        flags = 0;
-    } else {
-        reset = flags & PAGE_RESET;
-        flags &= ~PAGE_RESET;
-        if (flags & PAGE_WRITE) {
-            flags |= PAGE_WRITE_ORG;
-        }
+    if (set_flags & PAGE_WRITE) {
+        set_flags |= PAGE_WRITE_ORG;
+    }
+    if (clear_flags & PAGE_WRITE) {
+        clear_flags |= PAGE_WRITE_ORG;
     }
 
-    if (!flags || reset) {
+    if (clear_flags & PAGE_VALID) {
         page_reset_target_data(start, last);
-        inval_tb |= pageflags_unset(start, last);
+        clear_flags = -1;
+    } else {
+        /* Only set PAGE_ANON with new mappings. */
+        assert(!(set_flags & PAGE_ANON));
     }
-    if (flags) {
-        inval_tb |= pageflags_set_clear(start, last, flags,
-                                        ~(reset ? 0 : PAGE_STICKY));
-    }
-    if (inval_tb) {
+
+    if (pageflags_set_clear(start, last, set_flags, clear_flags)) {
         tb_invalidate_phys_range(NULL, start, last);
     }
 }
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 47e317517c..24ba1728eb 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -122,7 +122,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
         if (ret != 0)
             goto error;
     }
-    page_set_flags(start, start + len - 1, prot | PAGE_VALID);
+    page_set_flags(start, start + len - 1, prot, PAGE_RWX);
     mmap_unlock();
     return 0;
 error:
@@ -652,7 +652,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         }
     }
  the_end1:
-    page_set_flags(start, start + len - 1, prot | PAGE_VALID);
+    page_set_flags(start, start + len - 1, prot | PAGE_VALID, PAGE_VALID);
  the_end:
 #ifdef DEBUG_MMAP
     printf("ret=0x" TARGET_ABI_FMT_lx "\n", start);
@@ -763,7 +763,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
     }
 
     if (ret == 0) {
-        page_set_flags(start, start + len - 1, 0);
+        page_set_flags(start, start + len - 1, 0, PAGE_VALID);
     }
     mmap_unlock();
     return ret;
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index b1a4db4466..fef61022a3 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -243,7 +243,7 @@ bool init_guest_commpage(void)
     }
 
     page_set_flags(commpage, commpage | (host_page_size - 1),
-                   PAGE_READ | PAGE_EXEC | PAGE_VALID);
+                   PAGE_READ | PAGE_EXEC | PAGE_VALID, PAGE_VALID);
     return true;
 }
 
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
index 018034f244..4600708702 100644
--- a/linux-user/hppa/elfload.c
+++ b/linux-user/hppa/elfload.c
@@ -42,6 +42,6 @@ bool init_guest_commpage(void)
      * Special case the entry points during translation (see do_page_zero).
      */
     page_set_flags(LO_COMMPAGE, LO_COMMPAGE | ~TARGET_PAGE_MASK,
-                   PAGE_EXEC | PAGE_VALID);
+                   PAGE_EXEC | PAGE_VALID, PAGE_VALID);
     return true;
 }
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 002e1e668e..0b69efe54c 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -167,6 +167,13 @@ static int target_to_host_prot(int prot)
            (prot & PROT_EXEC ? PROT_READ : 0);
 }
 
+/* Target bits to be cleared by mprotect if not present in target_prot. */
+#ifdef TARGET_AARCH64
+#define TARGET_PAGE_NOTSTICKY  PAGE_BTI
+#else
+#define TARGET_PAGE_NOTSTICKY  0
+#endif
+
 /* NOTE: all the constants are the HOST ones, but addresses are target. */
 int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 {
@@ -264,7 +271,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
         }
     }
 
-    page_set_flags(start, last, page_flags);
+    page_set_flags(start, last, page_flags, PAGE_RWX | TARGET_PAGE_NOTSTICKY);
     ret = 0;
 
  error:
@@ -563,17 +570,17 @@ static abi_long mmap_end(abi_ulong start, abi_ulong last,
     if (flags & MAP_ANONYMOUS) {
         page_flags |= PAGE_ANON;
     }
-    page_flags |= PAGE_RESET;
     if (passthrough_start > passthrough_last) {
-        page_set_flags(start, last, page_flags);
+        page_set_flags(start, last, page_flags, PAGE_VALID);
     } else {
         if (start < passthrough_start) {
-            page_set_flags(start, passthrough_start - 1, page_flags);
+            page_set_flags(start, passthrough_start - 1,
+                           page_flags, PAGE_VALID);
         }
         page_set_flags(passthrough_start, passthrough_last,
-                       page_flags | PAGE_PASSTHROUGH);
+                       page_flags | PAGE_PASSTHROUGH, PAGE_VALID);
         if (passthrough_last < last) {
-            page_set_flags(passthrough_last + 1, last, page_flags);
+            page_set_flags(passthrough_last + 1, last, page_flags, PAGE_VALID);
         }
     }
     shm_region_rm_complete(start, last);
@@ -1094,7 +1101,7 @@ int target_munmap(abi_ulong start, abi_ulong len)
     mmap_lock();
     ret = mmap_reserve_or_unmap(start, len);
     if (likely(ret == 0)) {
-        page_set_flags(start, start + len - 1, 0);
+        page_set_flags(start, start + len - 1, 0, PAGE_VALID);
         shm_region_rm_complete(start, start + len - 1);
     }
     mmap_unlock();
@@ -1185,10 +1192,10 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
     } else {
         new_addr = h2g(host_addr);
         prot = page_get_flags(old_addr);
-        page_set_flags(old_addr, old_addr + old_size - 1, 0);
+        page_set_flags(old_addr, old_addr + old_size - 1, 0, PAGE_VALID);
         shm_region_rm_complete(old_addr, old_addr + old_size - 1);
         page_set_flags(new_addr, new_addr + new_size - 1,
-                       prot | PAGE_VALID | PAGE_RESET);
+                       prot | PAGE_VALID, PAGE_VALID);
         shm_region_rm_complete(new_addr, new_addr + new_size - 1);
     }
     mmap_unlock();
@@ -1434,9 +1441,10 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
 
         last = shmaddr + m_len - 1;
         page_set_flags(shmaddr, last,
-                       PAGE_VALID | PAGE_RESET | PAGE_READ |
+                       PAGE_VALID | PAGE_READ |
                        (shmflg & SHM_RDONLY ? 0 : PAGE_WRITE) |
-                       (shmflg & SHM_EXEC ? PAGE_EXEC : 0));
+                       (shmflg & SHM_EXEC ? PAGE_EXEC : 0),
+                       PAGE_VALID);
 
         shm_region_rm_complete(shmaddr, last);
         shm_region_add(shmaddr, last);
@@ -1480,7 +1488,7 @@ abi_long target_shmdt(abi_ulong shmaddr)
         if (rv == 0) {
             abi_ulong size = last - shmaddr + 1;
 
-            page_set_flags(shmaddr, last, 0);
+            page_set_flags(shmaddr, last, 0, PAGE_VALID);
             shm_region_rm_complete(shmaddr, last);
             mmap_reserve_or_unmap(shmaddr, size);
         }
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 1e7000c6bc..5914f76e83 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -37,7 +37,7 @@ bool init_guest_commpage(void)
     }
     page_set_flags(TARGET_VSYSCALL_PAGE,
                    TARGET_VSYSCALL_PAGE | ~TARGET_PAGE_MASK,
-                   PAGE_EXEC | PAGE_VALID);
+                   PAGE_EXEC | PAGE_VALID, PAGE_VALID);
     return true;
 }
 
-- 
2.43.0


