Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E00C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7l04-0001wR-OS; Wed, 23 Apr 2025 21:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwu-0005Fb-J3
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:21 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kwr-0005VP-Bj
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:00:20 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so311842b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 18:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456416; x=1746061216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MNvSRDi98aye64ClUWawrfGEwwTpHlnQYD/vV4dHwA=;
 b=khbK+y+qZHd+DpKSvbvQLeu1aRP1+YAVmCZhPnlg9p1hmtFxGQE/3dEXT/azWNHJlv
 fMj7sYqiHU9NKNqL3WbE7uInpfXJoFdFxxTDAysEfSlKIL7BU8dQjhDsN8hdj/V5DWiw
 /5Xgv0UhkqdTSJDQbPkq/C+KsACMo80fmsrBKkU1seoq1doo6RnMP0LcokcShFbL7KQk
 yfV5G2K9+eosKFk6csWLFvPQG8is+xilAaFBQlq2P+8oinka/hV5wsDYt5xykM6lnKJl
 I+7VMdmT2A4KscAhRbQMS86xJA4WLAwzPrNBBjhA0/ASaMn7AZ/E+YvCQI1twxK1fiZb
 0nxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456416; x=1746061216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9MNvSRDi98aye64ClUWawrfGEwwTpHlnQYD/vV4dHwA=;
 b=xSjtcuS8X3lms0nRRPFdO5d/brkC4ryt3RGAAhafp6swgkSJI3dAbZoqDuEjnMGihV
 yGbdw1yrTAvq2VZgY2XJNYnDjOpIdjo1orKFhN1at1CJocaXtYS7gBeMHa9WVuErI4U/
 /WpRLpdezXckHgN42sZc07aTg56uiZLr+EGK1gOm4MSvt1ZBJ49Dq2kq9IRYxEegnIOp
 drk/WwB2d1qM456tw/iCsvQoRRE6F2lrnLGs109/Cdf8x99c/27C/Nn290y2XcQgYtcT
 2iYmfDd5pm73tLMkmHwQ0r4zvDkiV0eFm97PGHBVJjgSkdBRoZeWUQvQ/qCwMM7a9DVi
 wY6A==
X-Gm-Message-State: AOJu0YxjiOY1s4NL86CJwxk+quZusjNYBwyK8zwcNOsV1NDVRq14j6FH
 muAhvBp6lkleht+273g1HUqhWvYH2WmYsf0WVdn0bhy+4Zfx9LX5oo4kbYq1hmFfo2plkLjhEj+
 i
X-Gm-Gg: ASbGncsdW/vPVSE0tC1BIJABCqY2kD3eUtSKnYgukrst8lQjq1rr786lW1dQ9JWsXO3
 7h5Wk4htjfrYF1o8itES+jOEAv2pRnhrh1ptVvQZ0e1ekPV+Dvvg3FIvHFW6ofey5hQDQG7T+n6
 8m3/l5TzWD0Z83kbUKmJ37AKZuinls2JCzEPz0Kk9MeC3oOTyKudJEWT71CGi1R2hpJPVIrW4Eg
 wXRH0ND07dRyNTMJNBfuiil+0VQAqWSzBbr5pyknn1ACMfgA2i+2mypsXxZtv7KfGXIwFnq+S7J
 ry6I2uIU1YvsZ7C0A5AYBtiYH/GWtFM6nLdYof4WdRc2TTl8i8R1tiuqp4MSpFz+B7O4dsfEJ8E
 =
X-Google-Smtp-Source: AGHT+IEufZc5pe3VdLbKXe7a/Atl6hdRv9XUy9qoxGBe8Ii8Kch0EXmgQ5N7wUkMQCM/eK2uMJLt5g==
X-Received: by 2002:a05:6a20:549c:b0:1f5:5807:13c7 with SMTP id
 adf61e73a8af0-20444e9c443mr862966637.17.1745456415731; 
 Wed, 23 Apr 2025 18:00:15 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f45c7sm129259a12.16.2025.04.23.18.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 18:00:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 137/148] tcg: Propagate CPUState argument to cpu_req_mo()
Date: Wed, 23 Apr 2025 17:49:22 -0700
Message-ID: <20250424004934.598783-138-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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


