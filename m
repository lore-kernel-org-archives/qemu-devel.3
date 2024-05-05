Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F74FC4345F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2024 12:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3ahL-00018z-Tv; Sun, 05 May 2024 08:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s3ahE-00018Q-7G; Sun, 05 May 2024 08:10:24 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s3ah9-0002Wt-FD; Sun, 05 May 2024 08:10:23 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 38ED54E600F;
 Sun, 05 May 2024 14:10:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id HebXpnnfEH_c; Sun,  5 May 2024 14:10:08 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 44A0D4E602D; Sun, 05 May 2024 14:10:08 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] include/exec/cpu-common.h: Rename PAGE_BITS macro to PAGE_RWX
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240505121008.44A0D4E602D@zero.eik.bme.hu>
Date: Sun, 05 May 2024 14:10:08 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

This macro can be used to abbreviate PAGE_READ | PAGE_WRITE | PAGE_EXEC
for which PAGE_RWX is a better name and renaming it also shows it is
not related to TARGET_PAGE_BITS.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 accel/tcg/user-exec.c      | 2 +-
 bsd-user/mmap.c            | 6 +++---
 include/exec/cpu-common.h  | 2 +-
 linux-user/elfload.c       | 2 +-
 linux-user/mmap.c          | 2 +-
 target/cris/mmu.c          | 4 ++--
 target/microblaze/helper.c | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 1c621477ad..a81e3cc920 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -765,7 +765,7 @@ int page_unprotect(target_ulong address, uintptr_t pc)
         if (prot & PAGE_EXEC) {
             prot = (prot & ~PAGE_EXEC) | PAGE_READ;
         }
-        mprotect((void *)g2h_untagged(start), len, prot & PAGE_BITS);
+        mprotect((void *)g2h_untagged(start), len, prot & PAGE_RWX);
     }
     mmap_unlock();
 
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 3ef11b2807..c785615392 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -96,7 +96,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
             end = host_end;
         }
         ret = mprotect(g2h_untagged(host_start),
-                       qemu_host_page_size, prot1 & PAGE_BITS);
+                       qemu_host_page_size, prot1 & PAGE_RWX);
         if (ret != 0)
             goto error;
         host_start += qemu_host_page_size;
@@ -107,7 +107,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
             prot1 |= page_get_flags(addr);
         }
         ret = mprotect(g2h_untagged(host_end - qemu_host_page_size),
-                       qemu_host_page_size, prot1 & PAGE_BITS);
+                       qemu_host_page_size, prot1 & PAGE_RWX);
         if (ret != 0)
             goto error;
         host_end -= qemu_host_page_size;
@@ -174,7 +174,7 @@ static int mmap_frag(abi_ulong real_start,
             return -1;
         prot1 = prot;
     }
-    prot1 &= PAGE_BITS;
+    prot1 &= PAGE_RWX;
 
     prot_new = prot | prot1;
     if (fd != -1) {
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 8812ba744d..a4bb4e6680 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -212,7 +212,7 @@ G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 #define PAGE_READ      0x0001
 #define PAGE_WRITE     0x0002
 #define PAGE_EXEC      0x0004
-#define PAGE_BITS      (PAGE_READ | PAGE_WRITE | PAGE_EXEC)
+#define PAGE_RWX       (PAGE_READ | PAGE_WRITE | PAGE_EXEC)
 #define PAGE_VALID     0x0008
 /*
  * Original state of the write flag (used when tracking self-modifying code)
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f9461d2844..41fae2b520 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2361,7 +2361,7 @@ static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss,
     if (start_bss < align_bss) {
         int flags = page_get_flags(start_bss);
 
-        if (!(flags & PAGE_BITS)) {
+        if (!(flags & PAGE_RWX)) {
             /*
              * The whole address space of the executable was reserved
              * at the start, therefore all pages will be VALID.
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index be3b9a68eb..66a1631094 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -117,7 +117,7 @@ static void shm_region_rm_complete(abi_ptr start, abi_ptr last)
 static int validate_prot_to_pageflags(int prot)
 {
     int valid = PROT_READ | PROT_WRITE | PROT_EXEC | TARGET_PROT_SEM;
-    int page_flags = (prot & PAGE_BITS) | PAGE_VALID;
+    int page_flags = (prot & PAGE_RWX) | PAGE_VALID;
 
 #ifdef TARGET_AARCH64
     {
diff --git a/target/cris/mmu.c b/target/cris/mmu.c
index b574ec6e5b..c25c31c9f8 100644
--- a/target/cris/mmu.c
+++ b/target/cris/mmu.c
@@ -333,7 +333,7 @@ int cris_mmu_translate(struct cris_mmu_result *res,
 
     if (!cris_mmu_enabled(env->sregs[SFR_RW_GC_CFG])) {
         res->phy = vaddr;
-        res->prot = PAGE_BITS;
+        res->prot = PAGE_RWX;
         goto done;
     }
 
@@ -344,7 +344,7 @@ int cris_mmu_translate(struct cris_mmu_result *res,
         miss = 0;
         base = cris_mmu_translate_seg(env, seg);
         res->phy = base | (0x0fffffff & vaddr);
-        res->prot = PAGE_BITS;
+        res->prot = PAGE_RWX;
     } else {
         miss = cris_mmu_translate_page(res, env, vaddr, access_type,
                                        is_user, debug);
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index d25c9eb4d3..ff5f86ddc2 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -51,7 +51,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (mmu_idx == MMU_NOMMU_IDX) {
         /* MMU disabled or not available.  */
         address &= TARGET_PAGE_MASK;
-        prot = PAGE_BITS;
+        prot = PAGE_RWX;
         tlb_set_page_with_attrs(cs, address, address, attrs, prot, mmu_idx,
                                 TARGET_PAGE_SIZE);
         return true;
-- 
2.30.9


