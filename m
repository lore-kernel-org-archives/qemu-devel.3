Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796CEC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:09:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSm-0005E6-SA; Tue, 22 Apr 2025 15:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSK-0004Fd-Mj
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:39:00 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSH-0007Mc-0d
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:55 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227b828de00so60308705ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350731; x=1745955531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MNvSRDi98aye64ClUWawrfGEwwTpHlnQYD/vV4dHwA=;
 b=UL0E99AOTBIQSbyS9uumOeHz53xKqqVCCn7fjTVcvG5Rb0fK8yBqZNFvD839x1exWE
 7Qa2ZAC7cXJ1RoNmYU1dGT/p+B7RB5MVzje/+JuEshpvO0UkcJutQycDTEl5Vha8BCn6
 nMid/Z8DQfWdDjosHffVFWdyZkx2jTKk+EARrbgoST9K8jC9FQ+186mQh0z2HCTvdpFQ
 nBwFErcsE54BZVJ4wZQ4M0y+jRpw+JHxs57bHuUNWCFCux2mX6uxLz+m5KYnFR0u1swn
 N7V7l4Sd4acdWftn7v6khOn2SLoI12rx0iYs1TXRMBrceCP5hac+oDmi4a4jD8khKLwT
 UM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350731; x=1745955531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9MNvSRDi98aye64ClUWawrfGEwwTpHlnQYD/vV4dHwA=;
 b=SMt+EZSEI9CBFq4CD70mgw2v2QViibLQsf99sdxQElokLwF50dcG5DqBETUSXIAstd
 8kd0WKg+zwatN77xmBMhoUa9ZyUlaA9wAv7F4U+I3yzBxWqy/+OYJD5WG/O2s+kJGdTi
 6xvbMxnzNrprhKPunI5tao3Lxs9cMFpgt7iy6SacwDGK60lABGZLgECHfc0Yv8mFQUZJ
 39sIwzKoDq2DORdLwL1ttfWl6H74kpOFGxV/0fyOxpic0Gnm9ofYxL1ItcvQeib/UlVG
 1CaCju59FXMqrngg9CAhLIP9tJXuUM4rPk7TM14vPbLbzxvCT/6bP7j8oWIpm86UuJVC
 PZ0w==
X-Gm-Message-State: AOJu0Yw2VFIeRZoTcOyYj3PoaEy2/B0L6W2EGweMw5QssrZhOTgFvSA+
 1mkV10vcZ5uCrrf6W3u1EB96QE/VkHBMDxJJzSYZ3sh9Ux4dPbebaoSTGQXCBxMjfgx0i2RRSgk
 N
X-Gm-Gg: ASbGncv56tGpkFfFbIJ7GDd80h8Kswwusx/N+3H9Hx3sSpO+TMaUKfjcgCbV4MFszIS
 VzNU6WYnzdmI48ideB1R81H9qcmbMdBpJV2zo+H5pdUArAbeU3M65GloWn/Uz5vdQRuiR4Zfjlj
 G0hohzquz71pqG2JvPUOdV+pezq80qgNZz6I0h8qXX30kgBNM9Uvh2usXkxsagaShNEWtkaU7TV
 gnfWAvMJKvgX3FTpJQgnuAdoSidcyPEz7FzhkYA02f8VLMNx9rKbpEaKeve6QB0MmhK6QpPCN0L
 41VagJAhO4uMMAYjWJUqw4ddFYpFENriNRziZuTLbmEhSvDn6rVlZV+L30N50d68fH55/KJ2cL0
 =
X-Google-Smtp-Source: AGHT+IErJu7SGnmpD7GLFGIqIRzbRLeft68oogKohVNfZWMtMikpMhxPEU90TrSOJcCr07TGE4x0Hw==
X-Received: by 2002:a17:902:e54b:b0:22c:33e4:fa5a with SMTP id
 d9443c01a7336-22c5356841cmr222772075ad.9.1745350730839; 
 Tue, 22 Apr 2025 12:38:50 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 136/147] tcg: Propagate CPUState argument to cpu_req_mo()
Date: Tue, 22 Apr 2025 12:28:05 -0700
Message-ID: <20250422192819.302784-137-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In preparation of having tcg_req_mo() access CPUState in
the next commit, pass it to cpu_req_mo(), its single caller.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-target.h |  3 ++-
 accel/tcg/cputlb.c          | 20 ++++++++++----------
 accel/tcg/user-exec.c       | 20 ++++++++++----------
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 1a46a7c87d..23aac39b57 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -59,12 +59,13 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 
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
index 2cafd38d2a..35b1ff03a5 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2324,7 +2324,7 @@ static uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     MMULookupLocals l;
     bool crosspage;
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     tcg_debug_assert(!crosspage);
 
@@ -2339,7 +2339,7 @@ static uint16_t do_ld2_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     uint16_t ret;
     uint8_t a, b;
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
         return do_ld_2(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
@@ -2363,7 +2363,7 @@ static uint32_t do_ld4_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     bool crosspage;
     uint32_t ret;
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
         return do_ld_4(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
@@ -2384,7 +2384,7 @@ static uint64_t do_ld8_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     bool crosspage;
     uint64_t ret;
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(cpu, addr, oi, ra, access_type, &l);
     if (likely(!crosspage)) {
         return do_ld_8(cpu, &l.page[0], l.mmu_idx, access_type, l.memop, ra);
@@ -2407,7 +2407,7 @@ static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
     Int128 ret;
     int first;
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_LOAD, &l);
     if (likely(!crosspage)) {
         if (unlikely(l.page[0].flags & TLB_MMIO)) {
@@ -2735,7 +2735,7 @@ static void do_st1_mmu(CPUState *cpu, vaddr addr, uint8_t val,
     MMULookupLocals l;
     bool crosspage;
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     tcg_debug_assert(!crosspage);
 
@@ -2749,7 +2749,7 @@ static void do_st2_mmu(CPUState *cpu, vaddr addr, uint16_t val,
     bool crosspage;
     uint8_t a, b;
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         do_st_2(cpu, &l.page[0], val, l.mmu_idx, l.memop, ra);
@@ -2771,7 +2771,7 @@ static void do_st4_mmu(CPUState *cpu, vaddr addr, uint32_t val,
     MMULookupLocals l;
     bool crosspage;
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         do_st_4(cpu, &l.page[0], val, l.mmu_idx, l.memop, ra);
@@ -2792,7 +2792,7 @@ static void do_st8_mmu(CPUState *cpu, vaddr addr, uint64_t val,
     MMULookupLocals l;
     bool crosspage;
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         do_st_8(cpu, &l.page[0], val, l.mmu_idx, l.memop, ra);
@@ -2815,7 +2815,7 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
     uint64_t a, b;
     int first;
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     crosspage = mmu_lookup(cpu, addr, oi, ra, MMU_DATA_STORE, &l);
     if (likely(!crosspage)) {
         if (unlikely(l.page[0].flags & TLB_MMIO)) {
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 1b878ead7a..3f4d682446 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -1061,7 +1061,7 @@ static uint8_t do_ld1_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     void *haddr;
     uint8_t ret;
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(cpu, addr, get_memop(oi), ra, access_type);
     ret = ldub_p(haddr);
     clear_helper_retaddr();
@@ -1075,7 +1075,7 @@ static uint16_t do_ld2_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     uint16_t ret;
     MemOp mop = get_memop(oi);
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, access_type);
     ret = load_atom_2(cpu, ra, haddr, mop);
     clear_helper_retaddr();
@@ -1093,7 +1093,7 @@ static uint32_t do_ld4_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     uint32_t ret;
     MemOp mop = get_memop(oi);
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, access_type);
     ret = load_atom_4(cpu, ra, haddr, mop);
     clear_helper_retaddr();
@@ -1111,7 +1111,7 @@ static uint64_t do_ld8_mmu(CPUState *cpu, vaddr addr, MemOpIdx oi,
     uint64_t ret;
     MemOp mop = get_memop(oi);
 
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, access_type);
     ret = load_atom_8(cpu, ra, haddr, mop);
     clear_helper_retaddr();
@@ -1130,7 +1130,7 @@ static Int128 do_ld16_mmu(CPUState *cpu, abi_ptr addr,
     MemOp mop = get_memop(oi);
 
     tcg_debug_assert((mop & MO_SIZE) == MO_128);
-    cpu_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
+    cpu_req_mo(cpu, TCG_MO_LD_LD | TCG_MO_ST_LD);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_LOAD);
     ret = load_atom_16(cpu, ra, haddr, mop);
     clear_helper_retaddr();
@@ -1146,7 +1146,7 @@ static void do_st1_mmu(CPUState *cpu, vaddr addr, uint8_t val,
 {
     void *haddr;
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(cpu, addr, get_memop(oi), ra, MMU_DATA_STORE);
     stb_p(haddr, val);
     clear_helper_retaddr();
@@ -1158,7 +1158,7 @@ static void do_st2_mmu(CPUState *cpu, vaddr addr, uint16_t val,
     void *haddr;
     MemOp mop = get_memop(oi);
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
@@ -1174,7 +1174,7 @@ static void do_st4_mmu(CPUState *cpu, vaddr addr, uint32_t val,
     void *haddr;
     MemOp mop = get_memop(oi);
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
@@ -1190,7 +1190,7 @@ static void do_st8_mmu(CPUState *cpu, vaddr addr, uint64_t val,
     void *haddr;
     MemOp mop = get_memop(oi);
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
@@ -1206,7 +1206,7 @@ static void do_st16_mmu(CPUState *cpu, vaddr addr, Int128 val,
     void *haddr;
     MemOpIdx mop = get_memop(oi);
 
-    cpu_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
+    cpu_req_mo(cpu, TCG_MO_LD_ST | TCG_MO_ST_ST);
     haddr = cpu_mmu_lookup(cpu, addr, mop, ra, MMU_DATA_STORE);
 
     if (mop & MO_BSWAP) {
-- 
2.43.0


