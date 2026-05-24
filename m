Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91F7CD5BB1
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 12:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR8Ch-0006WT-LT; Sun, 24 May 2026 08:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1wR8Cf-0006Vb-14
 for qemu-devel@nongnu.org; Sun, 24 May 2026 08:45:13 -0400
Received: from m16.mail.163.com ([117.135.210.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1wR8CZ-0008F5-0C
 for qemu-devel@nongnu.org; Sun, 24 May 2026 08:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=zz
 h60lKDY0sAa6r+JwG+P449lmNK2iJfGw1zjmk1AKo=; b=Qki9OrUavCZRoMFQ5n
 0uB/xzbu8WwQg7DcL7J/LbJV3fwcFamHgF4ngBPD1uNuEdF2Mt2mpnTccaGYCgwc
 zcy6pZVLNKfQUnbByg9sZ20fs/4QJE247gfAB+rnEJ1X3qbZ4aPzkXR99M8phjbM
 ybvMml5v536ghIelqPJGWr+LM=
Received: from alano.. (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wD3VwT78RJq4FHgDA--.19428S2; 
 Sun, 24 May 2026 20:41:32 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, pbonzini@redhat.com, zhao1.liu@intel.com,
 Alano Song <AlanoSong@163.com>
Subject: [PATCH] target/i386/monitor: Refine `info tlb` command logic
Date: Sun, 24 May 2026 20:41:29 +0800
Message-ID: <20260524124129.174254-1-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3VwT78RJq4FHgDA--.19428S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Aw1fJw1xur1kWw13tw45trb_yoWkuF15pa
 1ayr9Iqrs7tF13X34fAwnrtr13ArWru3yYgFnI9r10k3Z8Wwnru3s7tw43tr9xWFW8Xw4f
 uw1qka1UWF43XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi9qXfUUUUU=
X-Originating-IP: [59.173.201.222]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC0xza7moS8fw4qwAA3d
Received-SPF: pass client-ip=117.135.210.5; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When booting an i386 guest, the `info tlb` command
may walk the entire page table hierarchy and emit
an enormous amount of output (as many as 800+ million
entries under my test).
It will take dozens of minutes to print all the info,
because each monitor print function will holds 'mon_lock'.
This effectively hangs the qemu monitor, and even leading
to program exit due to timeout.

So it may be better to show only the first 32 entries
and the last entry by default.

And if full output is required, the user can redirect
the output to a file by specifying a file name, e.g.:
`info tlb xxx.txt`.

Signed-off-by: Alano Song <AlanoSong@163.com>
---
 hmp-commands-info.hx  |  10 +-
 target/i386/monitor.c | 230 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 195 insertions(+), 45 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 82134eb6c2..33b4604d11 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -188,17 +188,19 @@ ERST
 
     {
         .name       = "tlb",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show virtual to physical memory mappings",
+        .args_type  = "file:s?",
+        .params     = "[file]",
+        .help       = "show virtual to physical memory mappings (optionally save to file)",
         .cmd        = hmp_info_tlb,
         .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPARC \
                         | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M68K,
     },
 
 SRST
-  ``info tlb``
+  ``info tlb`` [*file*]
     Show virtual to physical memory mappings.
+    If *file* is specified, the output is saved to the given file
+    instead of being printed to the monitor.
 ERST
 
     {
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index a536712c75..9b8be71cab 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "qemu/qemu-print.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 #include "qobject/qdict.h"
@@ -48,31 +49,48 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
     return addr;
 }
 
-static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
+static void G_GNUC_PRINTF(3, 4)
+do_print_pte(Monitor *mon, FILE *fp, const char *fmt, ...)
+{
+    va_list ap;
+
+    va_start(ap, fmt);
+    if (fp) {
+        qemu_vfprintf(fp, fmt, ap);
+    } else {
+        monitor_vprintf(mon, fmt, ap);
+    }
+    va_end(ap);
+}
+
+static void print_pte(Monitor *mon, FILE *fp, CPUArchState *env, hwaddr addr,
                       hwaddr pte, hwaddr mask)
 {
     addr = addr_canonical(env, addr);
 
-    monitor_printf(mon, HWADDR_FMT_plx ": " HWADDR_FMT_plx
-                   " %c%c%c%c%c%c%c%c%c\n",
-                   addr,
-                   pte & mask,
-                   pte & PG_NX_MASK ? 'X' : '-',
-                   pte & PG_GLOBAL_MASK ? 'G' : '-',
-                   pte & PG_PSE_MASK ? 'P' : '-',
-                   pte & PG_DIRTY_MASK ? 'D' : '-',
-                   pte & PG_ACCESSED_MASK ? 'A' : '-',
-                   pte & PG_PCD_MASK ? 'C' : '-',
-                   pte & PG_PWT_MASK ? 'T' : '-',
-                   pte & PG_USER_MASK ? 'U' : '-',
-                   pte & PG_RW_MASK ? 'W' : '-');
+    do_print_pte(mon, fp, HWADDR_FMT_plx ": " HWADDR_FMT_plx
+                 " %c%c%c%c%c%c%c%c%c\n",
+                 addr,
+                 pte & mask,
+                 pte & PG_NX_MASK ? 'X' : '-',
+                 pte & PG_GLOBAL_MASK ? 'G' : '-',
+                 pte & PG_PSE_MASK ? 'P' : '-',
+                 pte & PG_DIRTY_MASK ? 'D' : '-',
+                 pte & PG_ACCESSED_MASK ? 'A' : '-',
+                 pte & PG_PCD_MASK ? 'C' : '-',
+                 pte & PG_PWT_MASK ? 'T' : '-',
+                 pte & PG_USER_MASK ? 'U' : '-',
+                 pte & PG_RW_MASK ? 'W' : '-');
 }
 
-static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
+static void tlb_info_32(Monitor *mon, FILE *fp, CPUArchState *env,
+                        AddressSpace *as)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     unsigned int l1, l2;
     uint32_t pgd, pde, pte;
+    uint64_t count = 0;
+    hwaddr tmp_addr = (hwaddr)-1, tmp_pte = (hwaddr)-1, tmp_mask = 0;
 
     pgd = env->cr[3] & ~0xfff;
     for(l1 = 0; l1 < 1024; l1++) {
@@ -80,28 +98,53 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env, AddressSpace *as)
         if (pde & PG_PRESENT_MASK) {
             if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
                 /* 4M pages */
-                print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
+                tmp_addr = (l1 << 22);
+                tmp_pte = pde;
+                tmp_mask = ~((1 << 21) - 1);
+                if (fp || count++ < 32) {
+                    print_pte(mon, fp, env, tmp_addr, tmp_pte, tmp_mask);
+                }
             } else {
                 for(l2 = 0; l2 < 1024; l2++) {
                     pte = address_space_ldl_le(as, (pde & ~0xfff) + l2 * 4,
                                                attrs, NULL);
                     if (pte & PG_PRESENT_MASK) {
-                        print_pte(mon, env, (l1 << 22) + (l2 << 12),
-                                  pte & ~PG_PSE_MASK,
-                                  ~0xfff);
+                        tmp_addr = (l1 << 22) + (l2 << 12);
+                        tmp_pte = pte & ~PG_PSE_MASK;
+                        tmp_mask = ~0xfff;
+                        if (fp || count++ < 32) {
+                            print_pte(mon, fp, env, tmp_addr, tmp_pte,
+                                      tmp_mask);
+                        }
                     }
                 }
             }
         }
     }
+
+    /*
+     * No need to print the last entry:
+     * 1) we already print all the entries into file.
+     * 2) entries number <= 32, and have been printed above.
+     */
+    if (!fp && count > 32) {
+        if (count > 33) {
+            do_print_pte(mon, fp, "... (%lu entries skipped) ...\n",
+                         (count - 33));
+        }
+        print_pte(mon, fp, env, tmp_addr, tmp_pte, tmp_mask);
+    }
 }
 
-static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
+static void tlb_info_pae32(Monitor *mon, FILE *fp, CPUArchState *env,
+                           AddressSpace *as)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     unsigned int l1, l2, l3;
     uint64_t pdpe, pde, pte;
     uint64_t pdp_addr, pd_addr, pt_addr;
+    uint64_t count = 0;
+    hwaddr tmp_addr = (hwaddr)-1, tmp_pte = (hwaddr)-1, tmp_mask = 0;
 
     pdp_addr = env->cr[3] & ~0x1f;
     for (l1 = 0; l1 < 4; l1++) {
@@ -113,18 +156,27 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
                 if (pde & PG_PRESENT_MASK) {
                     if (pde & PG_PSE_MASK) {
                         /* 2M pages with PAE, CR4.PSE is ignored */
-                        print_pte(mon, env, (l1 << 30) + (l2 << 21), pde,
-                                  ~((hwaddr)(1 << 20) - 1));
+                        tmp_addr = (l1 << 30) + (l2 << 21);
+                        tmp_pte = pde;
+                        tmp_mask = ~((hwaddr)(1 << 20) - 1);
+                        if (fp || count++ < 32) {
+                            print_pte(mon, fp, env, tmp_addr, tmp_pte,
+                                      tmp_mask);
+                        }
                     } else {
                         pt_addr = pde & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
                             pte = address_space_ldq_le(as, pt_addr + l3 * 8,
                                                        attrs, NULL);
                             if (pte & PG_PRESENT_MASK) {
-                                print_pte(mon, env, (l1 << 30) + (l2 << 21)
-                                          + (l3 << 12),
-                                          pte & ~PG_PSE_MASK,
-                                          ~(hwaddr)0xfff);
+                                tmp_addr = (l1 << 30) + (l2 << 21) +
+                                           (l3 << 12);
+                                tmp_pte = pte & ~PG_PSE_MASK;
+                                tmp_mask = ~(hwaddr)0xfff;
+                                if (fp || count++ < 32) {
+                                    print_pte(mon, fp, env, tmp_addr, tmp_pte,
+                                              tmp_mask);
+                                }
                             }
                         }
                     }
@@ -132,16 +184,37 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env, AddressSpace *as)
             }
         }
     }
+
+    /*
+     * No need to print the last entry:
+     * 1) we already print all the entries into file.
+     * 2) entries number <= 32, and have been printed above.
+     */
+    if (!fp && count > 32) {
+        if (count > 33) {
+            monitor_printf(mon, "... (%lu entries skipped) ...\n",
+                           (count - 33));
+        }
+        print_pte(mon, fp, env, tmp_addr, tmp_pte, tmp_mask);
+    }
 }
 
 #ifdef TARGET_X86_64
-static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
-        uint64_t l0, uint64_t pml4_addr)
+static void tlb_info_la48(Monitor *mon, FILE *fp, CPUArchState *env,
+                          AddressSpace *as, uint64_t l0, uint64_t pml4_addr,
+                          uint64_t *init_count, hwaddr *last_addr,
+                          hwaddr *last_pte, hwaddr *last_mask)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     uint64_t l1, l2, l3, l4;
     uint64_t pml4e, pdpe, pde, pte;
     uint64_t pdp_addr, pd_addr, pt_addr;
+    uint64_t count = 0;
+    hwaddr tmp_addr = (hwaddr)-1, tmp_pte=(hwaddr)-1, tmp_mask = 0;
+
+    if (init_count) {
+        count = *init_count;
+    }
 
     for (l1 = 0; l1 < 512; l1++) {
         pml4e = address_space_ldq_le(as, pml4_addr + l1 * 8, attrs, NULL);
@@ -158,8 +231,12 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
 
             if (pdpe & PG_PSE_MASK) {
                 /* 1G pages, CR4.PSE is ignored */
-                print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30),
-                        pdpe, 0x3ffffc0000000ULL);
+                tmp_addr = (l0 << 48) + (l1 << 39) + (l2 << 30);
+                tmp_pte = pdpe;
+                tmp_mask = 0x3ffffc0000000ULL;
+                if (fp || count++ < 32) {
+                    print_pte(mon, fp, env, tmp_addr, tmp_pte, tmp_mask);
+                }
                 continue;
             }
 
@@ -172,8 +249,13 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
 
                 if (pde & PG_PSE_MASK) {
                     /* 2M pages, CR4.PSE is ignored */
-                    print_pte(mon, env, (l0 << 48) + (l1 << 39) + (l2 << 30) +
-                            (l3 << 21), pde, 0x3ffffffe00000ULL);
+                    tmp_addr = (l0 << 48) + (l1 << 39) +
+                               (l2 << 30) + (l3 << 21);
+                    tmp_pte = pde;
+                    tmp_mask = 0x3ffffffe00000ULL;
+                    if (fp || count++ < 32) {
+                        print_pte(mon, fp, env, tmp_addr, tmp_pte, tmp_mask);
+                    }
                     continue;
                 }
 
@@ -182,30 +264,77 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env, AddressSpace *as,
                     pte = address_space_ldq_le(as, pt_addr + l4 * 8,
                                                attrs, NULL);
                     if (pte & PG_PRESENT_MASK) {
-                        print_pte(mon, env, (l0 << 48) + (l1 << 39) +
-                                (l2 << 30) + (l3 << 21) + (l4 << 12),
-                                pte & ~PG_PSE_MASK, 0x3fffffffff000ULL);
+                        tmp_addr = (l0 << 48) + (l1 << 39) + (l2 << 30) +
+                                   (l3 << 21) + (l4 << 12);
+                        tmp_pte = pte & ~PG_PSE_MASK;
+                        tmp_mask = 0x3fffffffff000ULL;
+                        if (fp || count++ < 32) {
+                            print_pte(mon, fp, env, tmp_addr, tmp_pte,
+                                      tmp_mask);
+                        }
                     }
                 }
             }
         }
     }
+
+    /*
+     * No need to print the current last entry:
+     * 1) we already print all the entries into file.
+     * 2) other function call this function, and only the caller
+     *    know if reach the end, let caller print the last one.
+     * 3) entries number <= 32, and have been printed above.
+     */
+    if (!fp && !init_count && count > 32) {
+        if (count > 33) {
+            do_print_pte(mon, fp, "... (%lu entries skipped) ...\n",
+                         (count - 33));
+        }
+        print_pte(mon, fp, env, tmp_addr, tmp_pte, tmp_mask);
+    }
+
+    if (init_count) {
+        *init_count = count;
+    }
+
+    if (last_addr && last_pte && last_mask) {
+        *last_addr = tmp_addr;
+        *last_pte = tmp_pte;
+        *last_mask = tmp_mask;
+    }
 }
 
-static void tlb_info_la57(Monitor *mon, CPUArchState *env, AddressSpace *as)
+static void tlb_info_la57(Monitor *mon, FILE *fp, CPUArchState *env,
+                          AddressSpace *as)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     uint64_t l0;
     uint64_t pml5e;
     uint64_t pml5_addr;
+    uint64_t count = 0;
+    hwaddr last_addr = (hwaddr)-1, last_pte=(hwaddr)-1, last_mask = 0;
 
     pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
     for (l0 = 0; l0 < 512; l0++) {
         pml5e = address_space_ldq_le(as, pml5_addr + l0 * 8, attrs, NULL);
         if (pml5e & PG_PRESENT_MASK) {
-            tlb_info_la48(mon, env, as, l0, pml5e & 0x3fffffffff000ULL);
+            tlb_info_la48(mon, fp, env, as, l0, pml5e & 0x3fffffffff000ULL,
+                          &count, &last_addr, &last_pte, &last_mask);
         }
     }
+
+    /*
+     * No need to print the last entry:
+     * 1) we already print all the entries into file.
+     * 2) entries number <= 32, and have been printed above.
+     */
+    if (!fp && count > 32) {
+        if (count > 33) {
+            monitor_printf(mon, "... (%lu entries skipped) ...\n",
+                           (count - 33));
+        }
+        print_pte(mon, fp, env, last_addr, last_pte, last_mask);
+    }
 }
 #endif /* TARGET_X86_64 */
 
@@ -213,6 +342,8 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 {
     CPUArchState *env;
     AddressSpace *as;
+    const char *filename;
+    FILE *fp = NULL;
 
     env = mon_get_cpu_env(mon);
     if (!env) {
@@ -224,22 +355,39 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "PG disabled\n");
         return;
     }
+
+    filename = qdict_get_try_str(qdict, "file");
+    if (filename) {
+        fp = fopen(filename, "w");
+        if (!fp) {
+            monitor_printf(mon, "Cannot open file '%s': %s\n",
+                           filename, strerror(errno));
+            return;
+        }
+    }
+
     as = cpu_get_address_space(env_cpu(env), X86ASIdx_MEM);
     if (env->cr[4] & CR4_PAE_MASK) {
 #ifdef TARGET_X86_64
         if (env->hflags & HF_LMA_MASK) {
             if (env->cr[4] & CR4_LA57_MASK) {
-                tlb_info_la57(mon, env, as);
+                tlb_info_la57(mon, fp, env, as);
             } else {
-                tlb_info_la48(mon, env, as, 0, env->cr[3] & 0x3fffffffff000ULL);
+                tlb_info_la48(mon, fp, env, as, 0,
+                              env->cr[3] & 0x3fffffffff000ULL,
+                              NULL, NULL, NULL, NULL);
             }
         } else
 #endif
         {
-            tlb_info_pae32(mon, env, as);
+            tlb_info_pae32(mon, fp, env, as);
         }
     } else {
-        tlb_info_32(mon, env, as);
+        tlb_info_32(mon, fp, env, as);
+    }
+
+    if (fp) {
+        fclose(fp);
     }
 }
 
-- 
2.43.0


