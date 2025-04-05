Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE9BC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u169q-0000f1-IV; Sat, 05 Apr 2025 12:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169o-0000dV-72
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:08 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169m-0005GK-3R
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:07 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so18749495e9.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869644; x=1744474444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rcpj2tcbvjBZshPtyS3/CSwa5AEapPfd25KE2HwFvNA=;
 b=BK4NVrKOqDtZrwDyb0tzZEKfn/SPg+heKRpvR3W25qbtkdevP0j9J5OAoM73y5+6DU
 beWjCJuGpnTkvyBY+MStlsp4D6CIBNgNd/rodhu+QI9SVxn9kefo0C5WXlmXdG5fDHhW
 WjUamFu9DPw1zCzEt1WIpESeRJzDF2zMeT80OQIVaB3eXxAG2NNOH6jQU42617VGZhKm
 ZQcID/zCXCGBWQx960VeQzLXKRBYZtnj62OOUsdQwCargYDdpijazzBsxoHGTyAUgSl7
 DPOkysjL8Lpeq5eebLW4iu4Miom8myvP1OTawcW4TNdIf9hyVBx+pBEHWwkkx4hIRRcr
 xSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869644; x=1744474444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rcpj2tcbvjBZshPtyS3/CSwa5AEapPfd25KE2HwFvNA=;
 b=XDOBRj3fr2f2u7VcYP8QQzY2fAS7qsOnQPpqILrsYxT98Up+phBqjlyfkek3tgO3L3
 nFhL/qIIPHkxy954Xqv24msJxROY5hyegrolHFCv36SeV4fCENte5UbqTlHmufvmcCjU
 2RTWkejCZ4g2+XJBJQE/gu18d6MrSAlgJ40PFwkcgsTlZIJjTxyqwK55KSYvI8k9Potw
 a8/mcYx4GEp2V1pyIJ6HQ+7eIkSdfsYE3VBrCkbcP/krCP+5BQM2Ck3hJNRZNq+z0MqS
 iUcZ4sxvJzZsHcwd7IgQp4DWT3l6GV/rz0SqzTnBw78uKPi554zvQaGhoPlP3nwjAExq
 z+5g==
X-Gm-Message-State: AOJu0YxBbVqyig0v0zMkw91977dKe5v70vEYhU7mASXsSTECAqJ+EJUS
 g6hlkp8kRlfYwqv38mvCzweA9Hx7GOuwBrs9ldg6zmK0TZFYJ/yGDoyTIH7RbMejBbToQLlKfpz
 G
X-Gm-Gg: ASbGncv4hxgrgaqXvP/6I/7byW7ZgclCpJhPFrebcYzAPDrD09hzgKkWq3EvWWHovBI
 imDU3Xq15v1XSzqcJzodGr4x+asluwtj8eX15ILipIIWa/lysCO49j7cZB4V5F3pWOXj6AJUCzw
 sjf5lgu0nho4X+BTm43Wg3/o7GN0qlbaGPmE+00NNppPQXTDXPGdmmuQuueS8PcXvWwBcAn+Z6o
 +sg/mofHhF/dq1FPQka5bajLtpU7UsalMLOgmXoK1nAVj1dkhNLSW9R6tLPCbdmelYMwKFMpl0J
 wOpWWBjUxQuFASVs4IVFb35TeVPuOZf2e3XqXix29M0t5Flt7LI+d0pwBJeU32ws0ntO5bcsQW2
 vnyYNZbJek0CJhBKMvicxZA7O
X-Google-Smtp-Source: AGHT+IH3lv5OAeYSgdqWi4iRDKK0NUPUg0dNcE4eK7rKdDILO2dd7BQYtxerzNYEtR0ednneeLZy7A==
X-Received: by 2002:a05:600c:1d8e:b0:43d:fa5f:7d30 with SMTP id
 5b1f17b1804b1-43ecef0230cmr65034035e9.16.1743869643651; 
 Sat, 05 Apr 2025 09:14:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea97904b7sm92433845e9.1.2025.04.05.09.14.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:14:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 09/16] tcg: Propagate CPUState argument to
 cpu_req_mo()
Date: Sat,  5 Apr 2025 18:13:13 +0200
Message-ID: <20250405161320.76854-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250405161320.76854-1-philmd@linaro.org>
References: <20250405161320.76854-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-target.h |  3 ++-
 accel/tcg/cputlb.c          | 20 ++++++++++----------
 accel/tcg/user-exec.c       | 20 ++++++++++----------
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 1a46a7c87dc..23aac39b572 100644
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
index 2cafd38d2af..35b1ff03a51 100644
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
index 1b878ead7a7..3f4d6824460 100644
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
2.47.1


