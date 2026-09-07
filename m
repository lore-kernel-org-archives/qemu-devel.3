Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61497C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3atT-0005ds-NL; Mon, 07 Sep 2026 11:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@gmail.com>)
 id 1x3ZbG-00079S-TU
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:41:30 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alanosong@gmail.com>)
 id 1x3ZbD-0001ou-RJ
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 09:41:30 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747eefae4so490525ad.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 06:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788788486; x=1789393286; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gw2IAWg7cnkmtDO14D8Y0ssMYuMJTymbe+a5y1lkn4E=;
 b=eagoD+Ost+syhmSn+A2T1DUgNKD/yi1mM1KUh4bzWKiidm4HckRrCQLV3hvdDVX8kf
 jM2LQk/5uNhueEGi6QNlkFezfFjO9Z7yXRMLXN/69i+DID2sTSQ86rl97x7upiNrYdT1
 txafWZc4rXXNprdw1BiJ7ivZD8NwhEwLXg8kIsRV6iP6BUzjSHmGEfo8F8eaISINtGn7
 tybbJ/hCSPacFhM3oesWb0MD9I4vJOZ76vbwoJMKuvKDI4MjD2Pkgb1UslPanMdQfM6A
 mNNBvM13zkrIZNe8W08snEoGONuDOhDDJGKpPi+TodTGwx8wxy4IpiwsAM6PDKli//xn
 5p/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788788486; x=1789393286;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Gw2IAWg7cnkmtDO14D8Y0ssMYuMJTymbe+a5y1lkn4E=;
 b=ssZLn8Iw6AOSREqq7Xhgxm1Ewem0lnkEOBjoXlCkuzi44YPnr7YbWE+wJ6gid1912R
 3tQ36mwHP+7GFRFdHAE9DA3GfR7ReocVmu8r0waZJ45/9WZU2gBNKC8iuFhwCaAm24vm
 8OWmkgVwL3fZa/RgTQLUOGRT1xePSuRNPxxZmAdqY7kEc6jFq8lgtb0VwJIptpozerLs
 r+3imYB5e9OaKKNJHbyIUExkruaA+7clBvoxg3riHi7qXdh5P2FWn7cCS3YSXP2Q/HoK
 EISZT2zWidGLZZKSd7cvZYGbIpx3wwhXnTn6rdOMxQiguIsuV69hvIQg9o1ahvGHVnPW
 qLQw==
X-Gm-Message-State: AFuF++lVzEm2gN5afHIiPXatdhmdWZps2/hbzOE7FDvBZ1D4tLOBe+2Q
 7RxpfFR/KZ+2sqI9Hur6Ojlvh7Aj79pT3zQsn8g9u2vcD3Q/QXea1AlvhhxsE8il6dDBteebfh0
 =
X-Gm-Gg: AYBFou0p+Qg2aslnDdLvUshBNU1buAnWRunAFP7kDLbiwdsn4zeLrUgb5qJwv15L6qH
 BFNL3Ct4eI2/heXiWQzxKQNjc3DD+Dwp8h7PgM7a+pnCOqKdFvPSd+yIyxHBZ8EL1gYURAqBmMz
 9mxXYuQeVFfXbm3K8HrzaveNfHKk6cM1SHA9KBpH6LnCBEyyR7DhwjMkstYZQ23xplaC9u5wasb
 R9b8oe6ItJolITM5NIMErQwHcvWPhIeP7WImbf0Gk6S1Jst62lCXCJju7VSNWyN90e+mVjfAAmp
 hSwzHY+dQ6nzn/I/DYEUEJWF1HBc1Z4y0ij2AboW5jrnoU/i84oSyDjAyYBdAS1vIEM8rDDjuTH
 uaA/72in2akesxanRlGMeuocr9FBuiwzhKmyN8FF9gsnsWZzCe3AaInC8+FFgdlf+B+CpCo3QhP
 U3lyP56Uk3gJ/BawwDiYOnLSVwyIhx04oJ3mrEwGQh1g==
X-Received: by 2002:a17:90b:4c10:b0:398:9bd3:d6d1 with SMTP id
 98e67ed59e1d1-39b8bec869amr905027a91.11.1788788486086; 
 Mon, 07 Sep 2026 06:41:26 -0700 (PDT)
Received: from alano.. ([240e:36f:15d2:6470:dbf:43a3:a2e8:d7bd])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08bcd243sm27989326a91.5.2026.09.07.06.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:41:25 -0700 (PDT)
From: Alano Song <alanosong@gmail.com>
X-Google-Original-From: Alano Song <AlanoSong@gmail.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, marcandre.lureau@gmail.com, philmd@oss.qualcomm.com,
 armbru@redhat.com, laurent@vivier.eu, atar4qemu@gmail.com,
 zhao1.liu@intel.com, marcandre.lureau@redhat.com,
 Alano Song <AlanoSong@163.com>
Subject: [PATCH v4 1/1] monitor: Refine 'info tlb' command
Date: Mon,  7 Sep 2026 21:41:15 +0800
Message-ID: <20260907134115.15193-2-AlanoSong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907134115.15193-1-AlanoSong@gmail.com>
References: <20260907134115.15193-1-AlanoSong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=alanosong@gmail.com; helo=mail-pj2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Sep 2026 11:04:19 -0400
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
minutes to print all the info.
And the same situation also occurred on sparc32 and
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
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
index 2695ff04ff..b836a8396e 100644
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
index ce61132e0f..d59e67647a 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -50,11 +50,9 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
     return addr;
 }
 
-static void print_pte(MonitorHMP *hmp, CPUArchState *env, hwaddr addr,
-                      hwaddr pte, hwaddr mask)
+static void do_print_pte(MonitorHMP *hmp, hwaddr addr,
+                         hwaddr pte, hwaddr mask)
 {
-    addr = addr_canonical(env, addr);
-
     monitor_hmp_printf(hmp, HWADDR_FMT_plx ": " HWADDR_FMT_plx
                        " %c%c%c%c%c%c%c%c%c\n",
                        addr,
@@ -70,7 +68,25 @@ static void print_pte(MonitorHMP *hmp, CPUArchState *env, hwaddr addr,
                        pte & PG_RW_MASK ? 'W' : '-');
 }
 
-static void tlb_info_32(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
+static void print_pte(MonitorHMP *hmp, CPUArchState *env, hwaddr addr,
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
+    do_print_pte(hmp, addr_start, pte, mask);
+}
+
+static void tlb_info_32(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as,
+                        hwaddr start, hwaddr end)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     unsigned int l1, l2;
@@ -82,15 +98,16 @@ static void tlb_info_32(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
         if (pde & PG_PRESENT_MASK) {
             if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
                 /* 4M pages */
-                print_pte(hmp, env, (l1 << 22), pde, ~((1 << 21) - 1));
+                print_pte(hmp, env, (l1 << 22), pde, ~((1 << 21) - 1),
+                          0x400000, start, end);
             } else {
                 for(l2 = 0; l2 < 1024; l2++) {
                     pte = address_space_ldl_le(as, (pde & ~0xfff) + l2 * 4,
                                                attrs, NULL);
                     if (pte & PG_PRESENT_MASK) {
                         print_pte(hmp, env, (l1 << 22) + (l2 << 12),
-                                  pte & ~PG_PSE_MASK,
-                                  ~0xfff);
+                                  pte & ~PG_PSE_MASK, ~0xfff, 0x1000,
+                                  start, end);
                     }
                 }
             }
@@ -98,7 +115,8 @@ static void tlb_info_32(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
     }
 }
 
-static void tlb_info_pae32(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
+static void tlb_info_pae32(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as,
+                           hwaddr start, hwaddr end)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     unsigned int l1, l2, l3;
@@ -116,17 +134,19 @@ static void tlb_info_pae32(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
                     if (pde & PG_PSE_MASK) {
                         /* 2M pages with PAE, CR4.PSE is ignored */
                         print_pte(hmp, env, (l1 << 30) + (l2 << 21), pde,
-                                  ~((hwaddr)(1 << 20) - 1));
+                                  ~((hwaddr)(1 << 20) - 1), 0x200000,
+                                  start, end);
                     } else {
                         pt_addr = pde & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
                             pte = address_space_ldq_le(as, pt_addr + l3 * 8,
                                                        attrs, NULL);
                             if (pte & PG_PRESENT_MASK) {
-                                print_pte(hmp, env, (l1 << 30) + (l2 << 21)
-                                          + (l3 << 12),
+                                print_pte(hmp, env,
+                                          (l1 << 30) + (l2 << 21) + (l3 << 12),
                                           pte & ~PG_PSE_MASK,
-                                          ~(hwaddr)0xfff);
+                                          ~(hwaddr)0xfff, 0x1000,
+                                          start, end);
                             }
                         }
                     }
@@ -138,7 +158,8 @@ static void tlb_info_pae32(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
 
 #ifdef TARGET_X86_64
 static void tlb_info_la48(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as,
-        uint64_t l0, uint64_t pml4_addr)
+                          uint64_t l0, uint64_t pml4_addr, hwaddr start,
+                          hwaddr end)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     uint64_t l1, l2, l3, l4;
@@ -161,7 +182,7 @@ static void tlb_info_la48(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as,
             if (pdpe & PG_PSE_MASK) {
                 /* 1G pages, CR4.PSE is ignored */
                 print_pte(hmp, env, (l0 << 48) + (l1 << 39) + (l2 << 30),
-                        pdpe, 0x3ffffc0000000ULL);
+                          pdpe, 0x3ffffc0000000ULL, 0x40000000, start, end);
                 continue;
             }
 
@@ -174,8 +195,9 @@ static void tlb_info_la48(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as,
 
                 if (pde & PG_PSE_MASK) {
                     /* 2M pages, CR4.PSE is ignored */
-                    print_pte(hmp, env, (l0 << 48) + (l1 << 39) + (l2 << 30) +
-                            (l3 << 21), pde, 0x3ffffffe00000ULL);
+                    print_pte(hmp, env,
+                              (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 << 21),
+                              pde, 0x3ffffffe00000ULL, 0x200000, start, end);
                     continue;
                 }
 
@@ -184,9 +206,11 @@ static void tlb_info_la48(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as,
                     pte = address_space_ldq_le(as, pt_addr + l4 * 8,
                                                attrs, NULL);
                     if (pte & PG_PRESENT_MASK) {
-                        print_pte(hmp, env, (l0 << 48) + (l1 << 39) +
-                                (l2 << 30) + (l3 << 21) + (l4 << 12),
-                                pte & ~PG_PSE_MASK, 0x3fffffffff000ULL);
+                        print_pte(hmp, env,
+                                  (l0 << 48) + (l1 << 39) + (l2 << 30) +
+                                  (l3 << 21) + (l4 << 12),
+                                  pte & ~PG_PSE_MASK,
+                                  0x3fffffffff000ULL, 0x1000, start, end);
                     }
                 }
             }
@@ -194,7 +218,8 @@ static void tlb_info_la48(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as,
     }
 }
 
-static void tlb_info_la57(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
+static void tlb_info_la57(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as,
+                          hwaddr start, hwaddr end)
 {
     const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
     uint64_t l0;
@@ -205,7 +230,8 @@ static void tlb_info_la57(MonitorHMP *hmp, CPUArchState *env, AddressSpace *as)
     for (l0 = 0; l0 < 512; l0++) {
         pml5e = address_space_ldq_le(as, pml5_addr + l0 * 8, attrs, NULL);
         if (pml5e & PG_PRESENT_MASK) {
-            tlb_info_la48(hmp, env, as, l0, pml5e & 0x3fffffffff000ULL);
+            tlb_info_la48(hmp, env, as, l0, pml5e & 0x3fffffffff000ULL,
+                          start, end);
         }
     }
 }
@@ -215,6 +241,18 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
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
+        monitor_hmp_printf(hmp, "Invalid address range: start > end.\n");
+        return;
+    }
 
     env = monitor_hmp_get_cpu_env(hmp);
     if (!env) {
@@ -231,17 +269,19 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 #ifdef TARGET_X86_64
         if (env->hflags & HF_LMA_MASK) {
             if (env->cr[4] & CR4_LA57_MASK) {
-                tlb_info_la57(hmp, env, as);
+                tlb_info_la57(hmp, env, as, start, end);
             } else {
-                tlb_info_la48(hmp, env, as, 0, env->cr[3] & 0x3fffffffff000ULL);
+                tlb_info_la48(hmp, env, as, 0,
+                              env->cr[3] & 0x3fffffffff000ULL,
+                              start, end);
             }
         } else
 #endif
         {
-            tlb_info_pae32(hmp, env, as);
+            tlb_info_pae32(hmp, env, as, start, end);
         }
     } else {
-        tlb_info_32(hmp, env, as);
+        tlb_info_32(hmp, env, as, start, end);
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
index e8b1b25a43..879a005342 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -9,17 +9,30 @@
 #include "cpu.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
+#include "qobject/qdict.h"
 
 #ifdef CONFIG_HMP
 void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
     CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
+    hwaddr start = 0, end = HWADDR_MAX;
 
     if (!env1) {
         monitor_hmp_printf(hmp, "No CPU available\n");
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
+        monitor_hmp_printf(hmp, "Invalid address range: start > end.\n");
+        return;
+    }
+
+    dump_mmu(env1, start, end);
 }
 #endif
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 5a21c01593..0409e38481 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -10,6 +10,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 #include "cpu.h"
+#include "qobject/qdict.h"
 
 #ifdef CONFIG_HMP
 void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
@@ -20,6 +21,11 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
         monitor_hmp_printf(hmp, "No CPU available\n");
         return;
     }
+
+    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
+        monitor_hmp_printf(hmp, "The range arguments will be ignored.\n");
+    }
+
     dump_mmu(env1);
 }
 #endif
diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
index 14261c0597..78ae6b99c1 100644
--- a/target/sh4/monitor.c
+++ b/target/sh4/monitor.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "qobject/qdict.h"
 
 #ifdef CONFIG_HMP
 static void print_tlb(MonitorHMP *hmp, int idx, tlb_t *tlb)
@@ -49,6 +50,10 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
         return;
     }
 
+    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
+        monitor_hmp_printf(hmp, "The range arguments will be ignored.\n");
+    }
+
     monitor_hmp_printf(hmp, "ITLB:\n");
     for (i = 0 ; i < ITLB_SIZE ; i++)
         print_tlb(hmp, i, &env->itlb[i]);
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 31a16c2af0..05c106028c 100644
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
index ed1e76fe73..3f22e79d5a 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "qobject/qdict.h"
 
 
 #ifdef CONFIG_HMP
@@ -36,6 +37,28 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
         monitor_hmp_printf(hmp, "No CPU available\n");
         return;
     }
+
+#ifdef TARGET_SPARC64
+    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
+        monitor_hmp_printf(hmp, "The range arguments will be ignored.\n");
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
+        monitor_hmp_printf(hmp, "Invalid address range: start > end.\n");
+        return;
+    }
+
+    dump_mmu_range(env1, start, end);
+#endif
 }
 #endif
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index e0fcac8565..6c53ead1cb 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
+#include "qobject/qdict.h"
 
 #ifdef CONFIG_HMP
 void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
@@ -35,6 +36,11 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
         monitor_hmp_printf(hmp, "No CPU available\n");
         return;
     }
+
+    if (qdict_haskey(qdict, "start") || qdict_haskey(qdict, "end")) {
+        monitor_hmp_printf(hmp, "The range arguments will be ignored.\n");
+    }
+
     dump_mmu(env1);
 }
 #endif
-- 
2.43.0


