Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B05C36005
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgus-0008AR-1c; Fri, 21 Mar 2025 14:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvguq-0008AI-SL
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:20 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvguo-0000nN-Hj
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:20 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so1942559f8f.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580977; x=1743185777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JOCpET3EdD3I12B9WLSxV6AoEDFAj5uepUX92kpSCz4=;
 b=l2GEYY7F8AYhetnBCzMZNQsgjB6cQ+aUHupYBPKgJmWkEGNHttSyBxgGpRyYwDBhLw
 sA2L7FUOzZreb9ew6VOUN9922c1tpd+st9s5+yb6qOFwB4n84NCfFvc0M/s2HGbJ7JFP
 h55IrRBw4kLdJlVqSMF39T3bsVhIdYbYo2CJGvsbec6nr1obkOT7mN8XwLzaCDEUF1JB
 523YMm7kdEGiliDLRZcjvsP6AdR7ggTfIDuZCVq2t2vfKDFrbeW8t6EtLju7BJg4GE4i
 6DFywKJ4scBEGaZydAzAph4Qlr4QW8Y7TuxsIpeWIeX4IhU07vKXly+p45RLV63+ME/O
 8lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580977; x=1743185777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JOCpET3EdD3I12B9WLSxV6AoEDFAj5uepUX92kpSCz4=;
 b=rwcShTjNgoppBQrCldUO8OYpTMQuAvCdXWB/GNs+7pOwM/QhkMV84LrJ2wPjSQFUbt
 cOMzWID2OB3I+F8Mvms68y8uFzjQL+WFoTBu2T8+evxHtFLFBUOjecfMTdpWNk7jvASo
 GEo6vqgtqKudB70b+kfaYCwaAi94W9NCNFkNBn84DppRQau/MWek/N1BA/r7aNoEL6PS
 ky20VvK8VlMcQR5qFewgxeSCi4x1RUbO5/rwsxPHhQ6Ayv5VNE6fitxsn2PkFAah0E1G
 fVy+UwBl8/bj1UbURYvV6tYyLX4NHjrWD1fTWM+JNg6jLzngujpqp8km5fbUu4h5wE8C
 QB0A==
X-Gm-Message-State: AOJu0YyAW9fWzqdT57lVS+2LKwRx1ZA6zCeewajRCdXkxzdfqIwJsI/J
 blZHppNfW1Ajvj/g1Dl0ywgOkKKYbnNOa8EV3k642ojNb4ATINE5r49vpn3AvpMGY2kO/+wzTME
 s
X-Gm-Gg: ASbGncu7QK85lhXTF82mBMLegYQfhn0VFkHixNNgJo/8N+kJ0I5ZYDoFSwFTF+oO/mF
 qvpswsxr77hFzWkrOyBI8TKkRAw6AMzAbheKHUSyFxs6+hYnZOsdykOND70QvmvOyOIr4s6bLoW
 L5AJuUMKuFfxtWGdadfXoTZWREX/Vx6nyg/vYR//pKGW1R3JJjuCJdGuQhsL6VfavsDrfb7CT+v
 6Sg5T1t7qL9Ln/ciwrc7Zq9JWbzLvYVdphbAr7h8NkkmWZ89rEZ+uGV9DD/6ZfOOPZL7KEJEWz1
 Vyvj7x5abwezzF4bpKk+393VJz4sK/efPkJlaYzPc78SxOcaFglMy0QMapZaZeXfxmg57DtcoK+
 UK/qZYkwLH8jbsWdaeRk=
X-Google-Smtp-Source: AGHT+IGXUKUy7FOnzDFtwHOvPokcEjY9gUA/07C+0fs8Y1LazF886mUln5h/wl5ZTR7SbHxy7yswHA==
X-Received: by 2002:a05:6000:21c2:b0:399:6d53:68d9 with SMTP id
 ffacd0b85a97d-3997f939949mr3205803f8f.38.1742580976682; 
 Fri, 21 Mar 2025 11:16:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b5b8dsm3042786f8f.59.2025.03.21.11.16.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 11:16:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-10.1 v2 5/7] tcg: Propagate CPUState argument to
 cpu_req_mo()
Date: Fri, 21 Mar 2025 19:15:47 +0100
Message-ID: <20250321181549.3331-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321181549.3331-1-philmd@linaro.org>
References: <20250321181549.3331-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

In preparation of having tcg_req_mo() access CPUState in
the next commit, pass it to cpu_req_mo(), its single caller.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-target.h |  3 ++-
 accel/tcg/cputlb.c          | 20 ++++++++++----------
 accel/tcg/user-exec.c       | 20 ++++++++++----------
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 1cb35dba99e..992362be7e6 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -57,12 +57,13 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 
 /**
  * cpu_req_mo:
+ * @cpu: CPUState
  * @type: TCGBar
  *
  * If tcg_req_mo indicates a barrier for @type is required
  * for the guest memory model, issue a host memory barrier.
  */
-#define cpu_req_mo(type)          \
+#define cpu_req_mo(cpu, type)     \
     do {                          \
         if (tcg_req_mo(type)) {   \
             smp_mb();             \
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fb22048876e..b6713efdb81 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2321,7 +2321,7 @@ static uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     MMULookupLocals l;
     bool crosspage;
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     tcg_debug_assert(!crosspage);
 
@@ -2336,7 +2336,7 @@ static uint16_t do_ld2_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     uint16_t ret;
     uint8_t a, b;
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
         return do_ld_2(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
@@ -2360,7 +2360,7 @@ static uint32_t do_ld4_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     bool crosspage;
     uint32_t ret;
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
         return do_ld_4(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
@@ -2381,7 +2381,7 @@ static uint64_t do_ld8_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     bool crosspage;
     uint64_t ret;
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
         return do_ld_8(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
@@ -2404,7 +2404,7 @@ static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
     Int128 ret;
     int first;
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_LOAD, &l);
     if (likely(!crosspage)) {
         if (unlikely(l.page[0].flags & TLB_MMIO)) {
@@ -2732,7 +2732,7 @@ static void do_st1_mmu(CPUState *cpu, vaddr addr, uint8_t val,
     MMULookupLocals l;
     bool crosspage;
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     tcg_debug_assert(!crosspage);
 
@@ -2746,7 +2746,7 @@ static void do_st2_mmu(CPUState *cpu, vaddr addr, uint16_t val,
     bool crosspage;
     uint8_t a, b;
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         do_st_2(cpu, &l.page[0], val, l.mmu_idx, l.memop, ra);
@@ -2768,7 +2768,7 @@ static void do_st4_mmu(CPUState *cpu, vaddr addr, uint32_t val,
     MMULookupLocals l;
     bool crosspage;
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         do_st_4(cpu, &l.page[0], val, l.mmu_idx, l.memop, ra);
@@ -2789,7 +2789,7 @@ static void do_st8_mmu(CPUState *cpu, vaddr addr, uint64_t val,
     MMULookupLocals l;
     bool crosspage;
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         do_st_8(cpu, &l.page[0], val, l.mmu_idx, l.memop, ra);
@@ -2812,7 +2812,7 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
     uint64_t a, b;
     int first;
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         if (unlikely(l.page[0].flags & TLB_MMIO)) {
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 2322181b151..5bda8fb5514 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1059,7 +1059,7 @@ static uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     void *haddr;
     uint8_t ret;
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(cpu, addr, get_memop(oi), ra, access_type);
     ret = ldub_p(haddr);
     clear_helper_retaddr();
@@ -1073,7 +1073,7 @@ static uint16_t do_ld2_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     uint16_t ret;
     MemOp mop = get_memop(oi);
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, access_type);
     ret = load_atom_2(cpu, ra, haddr, mop);
     clear_helper_retaddr();
@@ -1091,7 +1091,7 @@ static uint32_t do_ld4_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     uint32_t ret;
     MemOp mop = get_memop(oi);
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, access_type);
     ret = load_atom_4(cpu, ra, haddr, mop);
     clear_helper_retaddr();
@@ -1109,7 +1109,7 @@ static uint64_t do_ld8_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     uint64_t ret;
     MemOp mop = get_memop(oi);
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, access_type);
     ret = load_atom_8(cpu, ra, haddr, mop);
     clear_helper_retaddr();
@@ -1128,7 +1128,7 @@ static Int128 do_ld16_mmu(CPUState *cpu, abi_ptr addr,
     MemOp mop = get_memop(oi);
 
     tcg_debug_assert((mop & MO_SIZE) == MO_128);
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_LOAD);
     ret = load_atom_16(cpu, ra, haddr, mop);
     clear_helper_retaddr();
@@ -1144,7 +1144,7 @@ static void do_st1_mmu(CPUState *cpu, vaddr addr, uint8_t val,
 {
     void *haddr;
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(cpu, addr, get_memop(oi), ra, MMU_DATA_STORE);
     stb_p(haddr, val);
     clear_helper_retaddr();
@@ -1156,7 +1156,7 @@ static void do_st2_mmu(CPUState *cpu, vaddr addr, uint16_t val,
     void *haddr;
     MemOp mop = get_memop(oi);
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
@@ -1172,7 +1172,7 @@ static void do_st4_mmu(CPUState *cpu, vaddr addr, uint32_t val,
     void *haddr;
     MemOp mop = get_memop(oi);
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
@@ -1188,7 +1188,7 @@ static void do_st8_mmu(CPUState *cpu, vaddr addr, uint64_t val,
     void *haddr;
     MemOp mop = get_memop(oi);
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
@@ -1204,7 +1204,7 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
     void *haddr;
     MemOpIdx mop = get_memop(oi);
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
-- 
2.47.1


