Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57395C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 20:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfQf4-0005Uz-Rc; Wed, 28 Feb 2024 15:36:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfQeo-00059B-1i; Wed, 28 Feb 2024 15:36:04 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rfQek-0001JY-MP; Wed, 28 Feb 2024 15:36:01 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id ADB1151775;
 Wed, 28 Feb 2024 23:35:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4C8588BA7D;
 Wed, 28 Feb 2024 23:35:22 +0300 (MSK)
Received: (nullmailer pid 267638 invoked by uid 1000);
 Wed, 28 Feb 2024 20:35:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Brown <mcb30@ipxe.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 43/47] target/i386: Fix physical address truncation
Date: Wed, 28 Feb 2024 23:35:11 +0300
Message-Id: <20240228203521.267565-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240228233111@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240228233111@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

The address translation logic in get_physical_address() will currently
truncate physical addresses to 32 bits unless long mode is enabled.
This is incorrect when using physical address extensions (PAE) outside
of long mode, with the result that a 32-bit operating system using PAE
to access memory above 4G will experience undefined behaviour.

The truncation code was originally introduced in commit 33dfdb5 ("x86:
only allow real mode to access 32bit without LMA"), where it applied
only to translations performed while paging is disabled (and so cannot
affect guests using PAE).

Commit 9828198 ("target/i386: Add MMU_PHYS_IDX and MMU_NESTED_IDX")
rearranged the code such that the truncation also applied to the use
of MMU_PHYS_IDX and MMU_NESTED_IDX.  Commit 4a1e9d4 ("target/i386: Use
atomic operations for pte updates") brought this truncation into scope
for page table entry accesses, and is the first commit for which a
Windows 10 32-bit guest will reliably fail to boot if memory above 4G
is present.

The truncation code however is not completely redundant.  Even though the
maximum address size for any executed instruction is 32 bits, helpers for
operations such as BOUND, FSAVE or XSAVE may ask get_physical_address()
to translate an address outside of the 32-bit range, if invoked with an
argument that is close to the 4G boundary.  Likewise for processor
accesses, for example TSS or IDT accesses, when EFER.LMA==0.

So, move the address truncation in get_physical_address() so that it
applies to 32-bit MMU indexes, but not to MMU_PHYS_IDX and MMU_NESTED_IDX.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2040
Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
Cc: qemu-stable@nongnu.org
Co-developed-by: Michael Brown <mcb30@ipxe.org>
Signed-off-by: Michael Brown <mcb30@ipxe.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit b1661801c184119a10ad6cbc3b80330fc22e7b2c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: drop unrelated change in target/i386/cpu.c)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index f67cee477a..7be047ce33 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2195,6 +2195,12 @@ static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
         ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
 }
 
+static inline bool is_mmu_index_32(int mmu_index)
+{
+    assert(mmu_index < MMU_PHYS_IDX);
+    return mmu_index & 1;
+}
+
 static inline int cpu_mmu_index_kernel(CPUX86State *env)
 {
     return !(env->hflags & HF_SMAP_MASK) ? MMU_KNOSMAP_IDX :
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index c253226b3c..389a0d6912 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -556,6 +556,10 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
         break;
 
     default:
+        if (is_mmu_index_32(mmu_idx)) {
+            addr = (uint32_t)addr;
+        }
+
         if (likely(env->cr[0] & CR0_PG_MASK)) {
             in.cr3 = env->cr[3];
             in.mmu_idx = mmu_idx;
@@ -579,14 +583,8 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
         break;
     }
 
-    /* Translation disabled. */
+    /* No translation needed. */
     out->paddr = addr & x86_get_a20_mask(env);
-#ifdef TARGET_X86_64
-    if (!(env->hflags & HF_LMA_MASK)) {
-        /* Without long mode we can only address 32bits in real mode */
-        out->paddr = (uint32_t)out->paddr;
-    }
-#endif
     out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
     out->page_size = TARGET_PAGE_SIZE;
     return true;
-- 
2.39.2


