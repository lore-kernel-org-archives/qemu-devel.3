Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E927DCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waYm1-0000ki-8T; Fri, 19 Jun 2026 08:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1waYlv-0000hj-Rm
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 08:56:36 -0400
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1waYlq-0007qx-UA
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 08:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=FW
 fwgt/RYORWfGGcHg0oUzXsMLElsn2RU2CA0zXmwfQ=; b=DS3ykD5TYdms9ZJ++7
 L7nqiNsSalc8WIGqtvrhGQfSjdX9IVL4NzjJbuMw7RTMgvJ1ONwM5knKLx6tA3U2
 XwqgCp2dDm+vqPljcckPV7/1egBZ+9GvnZD/Vfix4Damn3upwOUdDUJqgm9qOqb4
 2ULb815wksypjmqeEDJQ5DDRA=
Received: from alano.. (unknown [])
 by gzsmtp3 (Coremail) with SMTP id PigvCgDnKbllPDVqD4oSDQ--.50474S2;
 Fri, 19 Jun 2026 20:56:06 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, pbonzini@redhat.com, zhao1.liu@intel.com,
 Alano Song <AlanoSong@163.com>
Subject: [PATCH v2] target/i386/monitor: Refine `info tlb` command
Date: Fri, 19 Jun 2026 20:56:02 +0800
Message-ID: <20260619125602.17077-1-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PigvCgDnKbllPDVqD4oSDQ--.50474S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JryUCr1rKFW7tw45CrWDtwb_yoW3WFy5p3
 y3ZrnYgan5tr13XwsxCrnFgr15ArsY9398XF9xCFyFk3WfXF9Fva4Dtw4jkwsxX34xWw43
 Zr4qkw4UGw43XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi9YFkUUUUU=
X-Originating-IP: [59.173.202.243]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC1AYQJGo1PGYglwAA3U
Received-SPF: pass client-ip=220.197.31.3; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

When booting an i386 target, the `info tlb` command
may walk the entire page table hierarchy and emit
an enormous amount of output.
It will take dozens of minutes to print all the info,
because each monitor print function will holds 'mon_lock'.
This effectively hangs the qemu monitor.

It may be better to add warning note in help message,
and add a address range by argument to help user control
the number of output items.

Signed-off-by: Alano Song <AlanoSong@163.com>
---
 hmp-commands-info.hx  | 12 ++++---
 target/i386/monitor.c | 82 +++++++++++++++++++++++++++++--------------
 2 files changed, 64 insertions(+), 30 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 82134eb6c2..3189e20de3 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -188,17 +188,21 @@ ERST
 
     {
         .name       = "tlb",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show virtual to physical memory mappings",
+        .args_type  = "start:l?,end:l?",
+        .params     = "[start [end]]",
+        .help       = "show virtual to physical memory mappings. "
+                      "output can be extremely large for i386 target. "
+                      "use 'info tlb [start] [end]' to show a range of entries.",
         .cmd        = hmp_info_tlb,
         .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPARC \
                         | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M68K,
     },
 
 SRST
-  ``info tlb``
+  ``info tlb`` [*start* [*end*]]
     Show virtual to physical memory mappings.
+    The output can be extremely large for i386 target.
+    Use *start* and *end* to print entries located in address range [start, end].
 ERST
 
     {
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index a536712c75..c0e0c3e405 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -48,11 +48,9 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
     return addr;
 }
 
-static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
-                      hwaddr pte, hwaddr mask)
+static void do_print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
+                         hwaddr pte, hwaddr mask)
 {
-    addr = addr_canonical(env, addr);
-
     monitor_printf(mon, HWADDR_FMT_plx ": " HWADDR_FMT_plx
                    " %c%c%c%c%c%c%c%c%c\n",
                    addr,
@@ -68,7 +66,20 @@ static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
                    pte & PG_RW_MASK ? 'W' : '-');
 }
 
-static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
+static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
+                      hwaddr pte, hwaddr mask,
+                      hwaddr start, hwaddr end)
+{
+    addr = addr_canonical(env, addr);
+    if (addr < start || addr > end) {
+        return;
+    }
+
+    do_print_pte(mon, env, addr, pte, mask);
+}
+
+static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as,
+                        hwaddr start, hwaddr end)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     unsigned int l1, l2;
@@ -80,15 +91,15 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
         if (pde & PG_PRESENT_MASK) {
             if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
                 /* 4M pages */
-                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
+                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1),
+                          start, end);
             } else {
                 for(l2 = 0; l2 < 1024; l2++) {
                     pte = address_space_ldl_le(as, (pde & ~0xfff) + l2 * 4,
                                                attrs, NULL);
                     if (pte & PG_PRESENT_MASK) {
                         print_pte(mon, env, (l1 << 22) + (l2 << 12),
-                                  pte & ~PG_PSE_MASK,
-                                  ~0xfff);
+                                  pte & ~PG_PSE_MASK, ~0xfff, start, end);
                     }
                 }
             }
@@ -96,7 +107,8 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
     }
 }
 
-static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
+static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as,
+                           hwaddr start, hwaddr end)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     unsigned int l1, l2, l3;
@@ -114,17 +126,19 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
                     if (pde & PG_PSE_MASK) {
                         /* 2M pages with PAE, CR4.PSE is ignored */
                         print_pte(mon, env, (l1 << 30) + (l2 << 21), pde,
-                                  ~((hwaddr)(1 << 20) - 1));
+                                  ~((hwaddr)(1 << 20) - 1),
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
+                                          ~(hwaddr)0xfff,
+                                          start, end);
                             }
                         }
                     }
@@ -136,7 +150,8 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
 
 #ifdef TARGET_X86_64
 static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
-        uint64_t l0, uint64_t pml4_addr)
+                          uint64_t l0, uint64_t pml4_addr, hwaddr start,
+                          hwaddr end)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     uint64_t l1, l2, l3, l4;
@@ -159,7 +174,7 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
             if (pdpe & PG_PSE_MASK) {
                 /* 1G pages, CR4.PSE is ignored */
                 print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30),
-                        pdpe, 0x3ffffc0000000ULL);
+                          pdpe, 0x3ffffc0000000ULL, start, end);
                 continue;
             }
 
@@ -172,8 +187,9 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
 
                 if (pde & PG_PSE_MASK) {
                     /* 2M pages, CR4.PSE is ignored */
-                    print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30) +
-                            (l3 << 21), pde, 0x3ffffffe00000ULL);
+                    print_pte(mon, env,
+                              (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 << 21),
+                              pde, 0x3ffffffe00000ULL, start, end);
                     continue;
                 }
 
@@ -182,9 +198,11 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
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
+                                  0x3fffffffff000ULL, start, end);
                     }
                 }
             }
@@ -192,7 +210,8 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
     }
 }
 
-static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
+static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as,
+                           hwaddr start, hwaddr end)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     uint64_t l0;
@@ -203,7 +222,8 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
     for (l0 = 0; l0 < 512; l0++) {
         pml5e = address_space_ldq_le(as, pml5_addr + l0 * 8, attrs, NULL);
         if (pml5e & PG_PRESENT_MASK) {
-            tlb_info_la48(mon, env, as, l0, pml5e & 0x3fffffffff000ULL);
+            tlb_info_la48(mon, env, as, l0, pml5e & 0x3fffffffff000ULL,
+                          start, end);
         }
     }
 }
@@ -213,6 +233,14 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
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
 
     env = mon_get_cpu_env(mon);
     if (!env) {
@@ -229,17 +257,19 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
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
 
-- 
2.43.0


