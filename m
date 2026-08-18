Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA430C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJsT-0002vP-9s; Tue, 18 Aug 2026 09:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1wwJsR-0002uy-L7
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:29:15 -0400
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1wwJsM-00080o-Im
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=wx
 CIOboDKJXWE3HDHf0eZa/DjLj3h8IKdqUKSIaxTNA=; b=dUpOFgqDpPf3aHTEgF
 fx0j7Tm8VcD8QYo7wefEHGuzy3bxfPhn1yr9UWAPbeeANs4bDf0nV2okIsMIbrd1
 JdkqUihky74hb+9EiHidinHN+PyVaBYM4aL+p8jMNe6emTM2TtvtcU8gHUB0q6z+
 xuTWxs8g8Oqp3W7CKBroRY5lk=
Received: from alano.. (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wDX48dBXYRqcY8tQg--.39284S2; 
 Tue, 18 Aug 2026 21:25:21 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, laurent@vivier.eu, zhao1.liu@intel.com,
 atar4qemu@gmail.com, Alano Song <AlanoSong@163.com>
Subject: [PATCH v3] monitor: Refine 'info tlb' command
Date: Tue, 18 Aug 2026 21:25:19 +0800
Message-ID: <20260818132519.186010-1-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDX48dBXYRqcY8tQg--.39284S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3urWDCr18XrW8uw15Zw13urg_yoW8Cw1xKo
 Z2vF13Ww4kGw15ZrWvkr1jy34UXF10kayS9wsI9F15Wa9rZrn0yFWDtw4kAwsFvrWrCrW7
 Za47ta4xtr48CF93n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRZqXmDUUUU
X-Originating-IP: [240e:36f:15cf:e270:7d3c:1101:691e:f7df]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC0wEjN2qEXUHZ5gAA3L
Received-SPF: pass client-ip=117.135.210.5; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

When booting an i386 target, the 'info tlb' command
may walk the entire page table hierarchy and emit
an enormous amount of output. It will take dozens of
minutes to print all the info, and
The same situation also occurred on sparc32 and
m68k targets.

So this change do the following:
1) Add a address range argument to help user control
   the number of output items.
2) Add warning note in help message that such address
   range argument only supported on target i386,
   sparc32 and m68k.
3) Print ignore warning when user add such address
   range argument on other targets (sh4, sparc64,
   ppc and xtensa). Those targets only print limited
   tlb info.

Signed-off-by: Alano Song <AlanoSong@163.com>
---
 hmp-commands-info.hx      | 17 ++++++--
 target/i386/monitor.c     | 92 ++++++++++++++++++++++++++++-----------
 target/m68k/cpu.h         |  2 +-
 target/m68k/helper.c      | 55 +++++++++++++++--------
 target/m68k/monitor.c     | 15 ++++++-
 target/ppc/monitor.c      |  6 +++
 target/sh4/monitor.c      |  5 +++
 target/sparc/cpu.h        |  3 ++
 target/sparc/mmu_helper.c | 40 +++++++++++++----
 target/sparc/monitor.c    | 23 ++++++++++
 target/xtensa/monitor.c   |  6 +++
 11 files changed, 206 insertions(+), 58 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 82134eb6c2..f907edf273 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -188,17 +188,26 @@ ERST
 
     {
         .name       = "tlb",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show virtual to physical memory mappings",
+        .args_type  = "start:l?,end:l?",
+        .params     = "[start [end]]",
+        .help       = "show virtual to physical memory mappings. "
+                      "output can be extremely large for i386, sparc32 "
+                      "and m68k targets. use 'info tlb [start [end]]' "
+                      "to show a range of entries. Note that the range "
+                      "argument is only supported on i386, sparc32 and "
+                      "m68k targets.",
         .cmd        = hmp_info_tlb,
         .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPARC \
                         | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M68K,
     },
 
 SRST
-  ``info tlb``
+  ``info tlb`` [*start* [*end*]]
     Show virtual to physical memory mappings.
+    The output can be extremely large for i386, sparc32 and m68k targets.
+    Use *start* and *end* to print entries located in virtual address
+    range [start, end] (end is optional). Note that the range argument is
+    only supported on i386, sparc32 and m68k targets.
 ERST
 
     {
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index a536712c75..8db9ab0576 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -48,11 +48,9 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
     return addr;
 }
 
-static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
-                      hwaddr pte, hwaddr mask)
+static void do_print_pte(Monitor *mon, hwaddr addr,
+                         hwaddr pte, hwaddr mask)
 {
-    addr = addr_canonical(env, addr);
-
     monitor_printf(mon, HWADDR_FMT_plx ": " HWADDR_FMT_plx
                    " %c%c%c%c%c%c%c%c%c\n",
                    addr,
@@ -68,7 +66,25 @@ static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
                    pte & PG_RW_MASK ? 'W' : '-');
 }
 
-static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
+static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
+                      hwaddr pte, hwaddr mask, hwaddr size,
+                      hwaddr start, hwaddr end)
+{
+    hwaddr addr_start = addr_canonical(env, addr);
+    hwaddr addr_end = addr_canonical(env, addr + size - 1);
+    /*
+     * Print current page [addr_start, addr_end] only if it overlaps the
+     * requested virtual address range [start, end].
+     */
+    if (addr_start > end || addr_end < start) {
+        return;
+    }
+
+    do_print_pte(mon, addr_start, pte, mask);
+}
+
+static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as,
+                        hwaddr start, hwaddr end)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     unsigned int l1, l2;
@@ -80,15 +96,16 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
         if (pde & PG_PRESENT_MASK) {
             if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
                 /* 4M pages */
-                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
+                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1),
+                          0x400000, start, end);
             } else {
                 for(l2 = 0; l2 < 1024; l2++) {
                     pte = address_space_ldl_le(as, (pde & ~0xfff) + l2 * 4,
                                                attrs, NULL);
                     if (pte & PG_PRESENT_MASK) {
                         print_pte(mon, env, (l1 << 22) + (l2 << 12),
-                                  pte & ~PG_PSE_MASK,
-                                  ~0xfff);
+                                  pte & ~PG_PSE_MASK, ~0xfff, 0x1000,
+                                  start, end);
                     }
                 }
             }
@@ -96,7 +113,8 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
     }
 }
 
-static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
+static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as,
+                           hwaddr start, hwaddr end)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     unsigned int l1, l2, l3;
@@ -114,17 +132,19 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
                     if (pde & PG_PSE_MASK) {
                         /* 2M pages with PAE, CR4.PSE is ignored */
                         print_pte(mon, env, (l1 << 30) + (l2 << 21), pde,
-                                  ~((hwaddr)(1 << 20) - 1));
+                                  ~((hwaddr)(1 << 20) - 1), 0x200000,
+                                  start, end);
                     } else {
                         pt_addr = pde & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
                             pte = address_space_ldq_le(as, pt_addr + l3 * 8,
                                                        attrs, NULL);
                             if (pte & PG_PRESENT_MASK) {
-                                print_pte(mon, env, (l1 << 30) + (l2 << 21)
-                                          + (l3 << 12),
+                                print_pte(mon, env,
+                                          (l1 << 30) + (l2 << 21) + (l3 << 12),
                                           pte & ~PG_PSE_MASK,
-                                          ~(hwaddr)0xfff);
+                                          ~(hwaddr)0xfff, 0x1000,
+                                          start, end);
                             }
                         }
                     }
@@ -136,7 +156,8 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
 
 #ifdef TARGET_X86_64
 static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
-        uint64_t l0, uint64_t pml4_addr)
+                          uint64_t l0, uint64_t pml4_addr, hwaddr start,
+                          hwaddr end)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     uint64_t l1, l2, l3, l4;
@@ -159,7 +180,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
             if (pdpe & PG_PSE_MASK) {
                 /* 1G pages, CR4.PSE is ignored */
                 print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30),
-                        pdpe, 0x3ffffc0000000ULL);
+                          pdpe, 0x3ffffc0000000ULL, 0x40000000, start, end);
                 continue;
             }
 
@@ -172,8 +193,9 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
 
                 if (pde & PG_PSE_MASK) {
                     /* 2M pages, CR4.PSE is ignored */
-                    print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30) +
-                            (l3 << 21), pde, 0x3ffffffe00000ULL);
+                    print_pte(mon, env,
+                              (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 << 21),
+                              pde, 0x3ffffffe00000ULL, 0x200000, start, end);
                     continue;
                 }
 
@@ -182,9 +204,11 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
                     pte = address_space_ldq_le(as, pt_addr + l4 * 8,
                                                attrs, NULL);
                     if (pte & PG_PRESENT_MASK) {
-                        print_pte(mon, env, (l0 << 48) + (l1 << 39) +
-                                (l2 << 30) + (l3 << 21) + (l4 << 12),
-                                pte & ~PG_PSE_MASK, 0x3fffffffff000ULL);
+                        print_pte(mon, env,
+                                  (l0 << 48) + (l1 << 39) + (l2 << 30) +
+                                  (l3 << 21) + (l4 << 12),
+                                  pte & ~PG_PSE_MASK,
+                                  0x3fffffffff000ULL, 0x1000, start, end);
                     }
                 }
             }
@@ -192,7 +216,8 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
     }
 }
 
-static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
+static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as,
+                          hwaddr start, hwaddr end)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     uint64_t l0;
@@ -203,7 +228,8 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
     for (l0 = 0; l0 < 512; l0++) {
         pml5e = address_space_ldq_le(as, pml5_addr + l0 * 8, attrs, NULL);
         if (pml5e & PG_PRESENT_MASK) {
-            tlb_info_la48(mon, env, as, l0, pml5e & 0x3fffffffff000ULL);
+            tlb_info_la48(mon, env, as, l0, pml5e & 0x3fffffffff000ULL,
+                          start, end);
         }
     }
 }
@@ -213,6 +239,18 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env;
     AddressSpace *as;
+    hwaddr start = 0, end = HWADDR_MAX;
+
+    if (qdict_haskey(qdict, "start")) {
+        start = (hwaddr)qdict_get_int(qdict, "start");
+    }
+    if (qdict_haskey(qdict, "end")) {
+        end = (hwaddr)qdict_get_int(qdict, "end");
+    }
+    if (start > end) {
+        monitor_printf(mon, "Invalid address range: start > end.\n");
+        return;
+    }
 
     env = mon_get_cpu_env(mon);
     if (!env) {
@@ -229,17 +267,19 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 #ifdef TARGET_X86_64
         if (env->hflags & HF_LMA_MASK) {
             if (env->cr[4] & CR4_LA57_MASK) {
-                tlb_info_la57(mon, env, as);
+                tlb_info_la57(mon, env, as, start, end);
             } else {
-                tlb_info_la48(mon, env, as, 0, env->cr[3] & 0x3fffffffff000ULL);
+                tlb_info_la48(mon, env, as, 0,
+                              env->cr[3] & 0x3fffffffff000ULL,
+                              start, end);
             }
         } else
 #endif
         {
-            tlb_info_pae32(mon, env, as);
+            tlb_info_pae32(mon, env, as, start, end);
         }
     } else {
-        tlb_info_32(mon, env, as);
+        tlb_info_32(mon, env, as, start, end);
     }
 }
 
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7cf3791108..b129cb150f 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -606,6 +606,6 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
 #define TB_FLAGS_TRACE          16
 #define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
 
-void dump_mmu(CPUM68KState *env);
+void dump_mmu(CPUM68KState *env, hwaddr start, hwaddr end);
 
 #endif
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 5f91d206f5..1b854c912b 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -461,27 +461,46 @@ void m68k_switch_sp(CPUM68KState *env)
 /* MMU: 68040 only */
 
 static void print_address_zone(uint32_t logical, uint32_t physical,
-                               uint32_t size, int attr)
+                               uint32_t size, int attr,
+                               hwaddr start, hwaddr end)
 {
+    uint64_t zone_start = logical;
+    uint64_t zone_end = zone_start + size - 1;
+    uint64_t zone_len;
+
+    /*
+     * Print current zone [zone_start, zone_end] only if it overlaps the
+     * requested virtual address range [start, end].
+     */
+    if (zone_end < start || zone_start > end) {
+        return;
+    }
+
+    physical += (uint32_t)(start > zone_start ? start - zone_start : 0);
+    zone_start = zone_start > start ? zone_start : start;
+    zone_end = zone_end < end ? zone_end : end;
+    zone_len = zone_end - zone_start + 1;
+
     qemu_printf("%08x - %08x -> %08x - %08x %c ",
-                logical, logical + size - 1,
-                physical, physical + size - 1,
+                (uint32_t)zone_start, (uint32_t)zone_end,
+                physical, physical + (uint32_t)(zone_len - 1),
                 attr & 4 ? 'W' : '-');
-    size >>= 10;
-    if (size < 1024) {
-        qemu_printf("(%d KiB)\n", size);
+    zone_len >>= 10;
+    if (zone_len < 1024) {
+        qemu_printf("(%d KiB)\n", (int)zone_len);
     } else {
-        size >>= 10;
-        if (size < 1024) {
-            qemu_printf("(%d MiB)\n", size);
+        zone_len >>= 10;
+        if (zone_len < 1024) {
+            qemu_printf("(%d MiB)\n", (int)zone_len);
         } else {
-            size >>= 10;
-            qemu_printf("(%d GiB)\n", size);
+            zone_len >>= 10;
+            qemu_printf("(%d GiB)\n", (int)zone_len);
         }
     }
 }
 
-static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
+static void dump_address_map(CPUM68KState *env, uint32_t root_pointer,
+                             hwaddr start, hwaddr end)
 {
     int tic_size, tic_shift;
     uint32_t tib_mask;
@@ -550,7 +569,8 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
                         size = last_logical + (1 << tic_shift) -
                                first_logical;
                         print_address_zone(first_logical,
-                                           first_physical, size, last_attr);
+                                           first_physical, size, last_attr,
+                                           start, end);
                     }
                     first_logical = logical;
                     first_physical = physical;
@@ -560,7 +580,8 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
     }
     if (first_logical != logical || (attr & 4) != (last_attr & 4)) {
         size = logical + (1 << tic_shift) - first_logical;
-        print_address_zone(first_logical, first_physical, size, last_attr);
+        print_address_zone(first_logical, first_physical, size, last_attr,
+                           start, end);
     }
 }
 
@@ -610,7 +631,7 @@ static void dump_ttr(uint32_t ttr)
                                M68K_DESC_USERATTR_SHIFT);
 }
 
-void dump_mmu(CPUM68KState *env)
+void dump_mmu(CPUM68KState *env, hwaddr start, hwaddr end)
 {
     if ((env->mmu.tcr & M68K_TCR_ENABLED) == 0) {
         qemu_printf("Translation disabled\n");
@@ -675,10 +696,10 @@ void dump_mmu(CPUM68KState *env)
     dump_ttr(env->mmu.ttr[M68K_DTTR1]);
 
     qemu_printf("SRP: 0x%08x\n", env->mmu.srp);
-    dump_address_map(env, env->mmu.srp);
+    dump_address_map(env, env->mmu.srp, start, end);
 
     qemu_printf("URP: 0x%08x\n", env->mmu.urp);
-    dump_address_map(env, env->mmu.urp);
+    dump_address_map(env, env->mmu.urp, start, end);
 }
 
 static int check_TTR(uint32_t ttr, int *prot, target_ulong addr,
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 3e0df40a6b..bcb528d8e3 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -9,15 +9,28 @@
 #include "cpu.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
+#include "qobject/qdict.h"
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env1 = mon_get_cpu_env(mon);
+    hwaddr start = 0, end = HWADDR_MAX;
 
     if (!env1) {
         monitor_printf(mon, "No CPU available\n");
         return;
     }
 
-    dump_mmu(env1);
+    if (qdict_haskey(qdict, "start")) {
+        start = (hwaddr)qdict_get_int(qdict, "start");
+    }
+    if (qdict_haskey(qdict, "end")) {
+        end = (hwaddr)qdict_get_int(qdict, "end");
+    }
+    if (start > end) {
+        monitor_printf(mon, "Invalid address range: start > end.\n");
+        return;
+    }
+
+    dump_mmu(env1, start, end);
 }
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 7c88e0e2bd..753ed6b93d 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -10,6 +10,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 #include "cpu.h"
+#include "qobject/qdict.h"
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
@@ -19,5 +20,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
+
+    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
+        monitor_printf(mon, "The range arguments will be ignored.\n");
+    }
+
     dump_mmu(env1);
 }
diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
index 50324d3600..c804824bab 100644
--- a/target/sh4/monitor.c
+++ b/target/sh4/monitor.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "qobject/qdict.h"
 
 static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
 {
@@ -48,6 +49,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         return;
     }
 
+    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
+        monitor_printf(mon, "The range arguments will be ignored.\n");
+    }
+
     monitor_printf (mon, "ITLB:\n");
     for (i = 0 ; i < ITLB_SIZE ; i++)
         print_tlb (mon, i, &env->itlb[i]);
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 5f583ed9de..11f94b6bd8 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -601,6 +601,9 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         bool probe, uintptr_t retaddr);
 target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev);
 void dump_mmu(CPUSPARCState *env);
+#ifndef TARGET_SPARC64
+void dump_mmu_range(CPUSPARCState *env, hwaddr start, hwaddr end);
+#endif
 
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
 int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 07ba25dfce..65a30b438b 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -354,7 +354,32 @@ target_ulong mmu_probe(CPUSPARCState *env, target_ulong address, int mmulev)
     return 0;
 }
 
+static void print_tlb_entry(target_ulong va, hwaddr pa, uint32_t pde,
+                            const char *indent, const char *kind,
+                            hwaddr size, hwaddr start, hwaddr end)
+{
+    hwaddr va_hw_start = (hwaddr)va;
+    hwaddr va_hw_end = (hwaddr)(va + size - 1);
+
+    /*
+     * Print current region [va_hw_start, va_hw_end] only if it overlaps the
+     * requested virtual address range [start, end].
+     */
+    if (va_hw_start > end || va_hw_end < start) {
+        return;
+    }
+
+    qemu_printf("%sVA: " TARGET_FMT_lx ", PA: " HWADDR_FMT_plx
+                " %s: " TARGET_FMT_lx "\n",
+                indent, va, pa, kind, pde);
+}
+
 void dump_mmu(CPUSPARCState *env)
+{
+    dump_mmu_range(env, 0, HWADDR_MAX);
+}
+
+void dump_mmu_range(CPUSPARCState *env, hwaddr start, hwaddr end)
 {
     CPUState *cs = env_cpu(env);
     target_ulong va, va1, va2;
@@ -373,8 +398,8 @@ void dump_mmu(CPUSPARCState *env)
             } else {
                 pa = tres.physaddr;
             }
-            qemu_printf("VA: " TARGET_FMT_lx ", PA: " HWADDR_FMT_plx
-                        " PDE: " TARGET_FMT_lx "\n", va, pa, pde);
+            print_tlb_entry(va, pa, pde, "", "PDE", 16 * 1024 * 1024,
+                            start, end);
             for (m = 0, va1 = va; m < 64; m++, va1 += 256 * 1024) {
                 pde = mmu_probe(env, va1, 1);
                 if (pde) {
@@ -383,9 +408,8 @@ void dump_mmu(CPUSPARCState *env)
                     } else {
                         pa = tres.physaddr;
                     }
-                    qemu_printf(" VA: " TARGET_FMT_lx ", PA: "
-                                HWADDR_FMT_plx " PDE: " TARGET_FMT_lx "\n",
-                                va1, pa, pde);
+                    print_tlb_entry(va1, pa, pde, " ", "PDE", 256 * 1024,
+                                    start, end);
                     for (o = 0, va2 = va1; o < 64; o++, va2 += 4 * 1024) {
                         pde = mmu_probe(env, va2, 0);
                         if (pde) {
@@ -394,10 +418,8 @@ void dump_mmu(CPUSPARCState *env)
                             } else {
                                 pa = tres.physaddr;
                             }
-                            qemu_printf("  VA: " TARGET_FMT_lx ", PA: "
-                                        HWADDR_FMT_plx " PTE: "
-                                        TARGET_FMT_lx "\n",
-                                        va2, pa, pde);
+                            print_tlb_entry(va2, pa, pde, "  ", "PTE",
+                                            4 * 1024, start, end);
                         }
                     }
                 }
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 36f3d8d58e..993e411a37 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "qobject/qdict.h"
 
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
@@ -35,5 +36,27 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
+
+#ifdef TARGET_SPARC64
+    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
+        monitor_printf(mon, "The range arguments will be ignored.\n");
+    }
+
     dump_mmu(env1);
+#else
+    hwaddr start = 0, end = HWADDR_MAX;
+
+    if (qdict_haskey(qdict, "start")) {
+        start = (hwaddr)qdict_get_int(qdict, "start");
+    }
+    if (qdict_haskey(qdict, "end")) {
+        end = (hwaddr)qdict_get_int(qdict, "end");
+    }
+    if (start > end) {
+        monitor_printf(mon, "Invalid address range: start > end.\n");
+        return;
+    }
+
+    dump_mmu_range(env1, start, end);
+#endif
 }
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index 2af84934f8..df572cba42 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "qobject/qdict.h"
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
@@ -34,5 +35,10 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "No CPU available\n");
         return;
     }
+
+    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
+        monitor_printf(mon, "The range arguments will be ignored.\n");
+    }
+
     dump_mmu(env1);
 }
-- 
2.43.0


