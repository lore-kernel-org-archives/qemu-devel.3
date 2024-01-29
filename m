Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5060C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb74-00074q-KU; Mon, 29 Jan 2024 18:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6V-0005z1-5e
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:53 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6S-0005AD-Pm
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:50 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d72f71f222so15759925ad.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571107; x=1707175907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jR/oo/A0As45gwF9os4Db/TKdBueduPDROlzWdMxfpg=;
 b=OuHfqSDQbwsey1YRliUSP74xVHjz9qfbWE/lm3Hck07BNcbqBBZ1EbOOjP5z/mn5M+
 eFNbVKSNeSz3PX1Fa9oQxWF5B2grG9XGWnCCt/L4uJNlTpQq3I9MVa3kC5KHKmh6/m12
 U65E7M0+T0Y8ghTosbna15fa33BpCvbZd+HM9v1N5y2MWHHcFnSNpSieVN0wtcG/pznl
 IJ/Ri9LcaldQFyp0dGgXfDpCzMAdgFcgVgcoZh83x9tiOhxeB320Awu8GKIsUVT8sklG
 2UqKB3dcp4gvAxcIwTpjwN+8zOHCFWlz3UI675P4YNgjZvr+VHgSXqND31APwZ88blZI
 Ziww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571107; x=1707175907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jR/oo/A0As45gwF9os4Db/TKdBueduPDROlzWdMxfpg=;
 b=rCvASZ21EXE1J1kRkWc0cYbxv5sX3pn8cRTteao9g+aOlrVUjpdrA5WIhzD2OMXK1t
 WvDDdD6v8miLRZ1M37X2G0lHMn/Dnz+otHFYpAHlYbX8rNysgGE3sqlVO50opQYjnXFz
 eu42oancq3pZkbCR9sOvNgMH6OBRcxk8wv3LtUbGIpdANW13VW/POXXAIpJoLQ1Z+ib8
 /zdlQFY6LyyiwjtQ9whWIwSbqoL1HqMww0+NXf420CfFgG+aVBTQZd1SiWq5VbljQY1t
 odPPyFs8K5Nk9jhjwc3axebv0NNOWwXJrN5k/+lYjPhsnJUtHGINEeMKolVCaiSjhWAd
 CziQ==
X-Gm-Message-State: AOJu0Yxle+etfJ8ybcHesQWLVXFLn8a+EhQExhAnA5WXCJrwghqzzEZY
 O2DZCz4Qzapc0m3VZBShQA3AH+E38aOw+BloFqFTD39hHR9cxXF//8VPtik31jpATSiVRvcqG1Z
 cjlI=
X-Google-Smtp-Source: AGHT+IENUS8VPQtYLctmhtMmh+6g4SXCKdSCIpZCfl+cxbYxkU1orl33ziIXpcMi9JZ64uKPYWCmSA==
X-Received: by 2002:a17:902:e805:b0:1d8:f98b:616b with SMTP id
 u5-20020a170902e80500b001d8f98b616bmr1908682plg.44.1706571107530; 
 Mon, 29 Jan 2024 15:31:47 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 26/33] target/s390x: Split out s390x_env_mmu_index
Date: Tue, 30 Jan 2024 09:30:36 +1000
Message-Id: <20240129233043.34558-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.h            |  4 +++-
 target/s390x/tcg/mem_helper.c | 34 ++++++++++++++++++----------------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index fa3aac4f97..f0fed5d6ad 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -381,7 +381,7 @@ extern const VMStateDescription vmstate_s390_cpu;
 #define MMU_HOME_IDX            2
 #define MMU_REAL_IDX            3
 
-static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
+static inline int s390x_env_mmu_index(CPUS390XState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return MMU_USER_IDX;
@@ -412,6 +412,8 @@ static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
 #endif
 }
 
+#define cpu_mmu_index s390x_env_mmu_index
+
 #ifdef CONFIG_TCG
 
 #include "tcg/tcg_s390x.h"
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 84103251b9..557831def4 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -358,7 +358,7 @@ static int mmu_idx_from_as(uint8_t as)
 static uint32_t do_helper_nc(CPUS390XState *env, uint32_t l, uint64_t dest,
                              uint64_t src, uintptr_t ra)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = s390x_env_mmu_index(env, false);
     S390Access srca1, srca2, desta;
     uint32_t i;
     uint8_t c = 0;
@@ -392,7 +392,7 @@ uint32_t HELPER(nc)(CPUS390XState *env, uint32_t l, uint64_t dest,
 static uint32_t do_helper_xc(CPUS390XState *env, uint32_t l, uint64_t dest,
                              uint64_t src, uintptr_t ra)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = s390x_env_mmu_index(env, false);
     S390Access srca1, srca2, desta;
     uint32_t i;
     uint8_t c = 0;
@@ -433,7 +433,7 @@ uint32_t HELPER(xc)(CPUS390XState *env, uint32_t l, uint64_t dest,
 static uint32_t do_helper_oc(CPUS390XState *env, uint32_t l, uint64_t dest,
                              uint64_t src, uintptr_t ra)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = s390x_env_mmu_index(env, false);
     S390Access srca1, srca2, desta;
     uint32_t i;
     uint8_t c = 0;
@@ -467,7 +467,7 @@ uint32_t HELPER(oc)(CPUS390XState *env, uint32_t l, uint64_t dest,
 static uint32_t do_helper_mvc(CPUS390XState *env, uint32_t l, uint64_t dest,
                               uint64_t src, uintptr_t ra)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = s390x_env_mmu_index(env, false);
     S390Access srca, desta;
     uint32_t i;
 
@@ -508,7 +508,7 @@ void HELPER(mvc)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
 /* move right to left */
 void HELPER(mvcrl)(CPUS390XState *env, uint64_t l, uint64_t dest, uint64_t src)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = s390x_env_mmu_index(env, false);
     const uint64_t ra = GETPC();
     S390Access srca, desta;
     int32_t i;
@@ -529,7 +529,7 @@ void HELPER(mvcrl)(CPUS390XState *env, uint64_t l, uint64_t dest, uint64_t src)
 /* move inverse  */
 void HELPER(mvcin)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = s390x_env_mmu_index(env, false);
     S390Access srca, desta;
     uintptr_t ra = GETPC();
     int i;
@@ -550,7 +550,7 @@ void HELPER(mvcin)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
 /* move numerics  */
 void HELPER(mvn)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = s390x_env_mmu_index(env, false);
     S390Access srca1, srca2, desta;
     uintptr_t ra = GETPC();
     int i;
@@ -572,7 +572,7 @@ void HELPER(mvn)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
 /* move with offset  */
 void HELPER(mvo)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = s390x_env_mmu_index(env, false);
     /* MVO always processes one more byte than specified - maximum is 16 */
     const int len_dest = (l >> 4) + 1;
     const int len_src = (l & 0xf) + 1;
@@ -606,7 +606,7 @@ void HELPER(mvo)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
 /* move zones  */
 void HELPER(mvz)(CPUS390XState *env, uint32_t l, uint64_t dest, uint64_t src)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = s390x_env_mmu_index(env, false);
     S390Access srca1, srca2, desta;
     uintptr_t ra = GETPC();
     int i;
@@ -669,7 +669,7 @@ uint32_t HELPER(clm)(CPUS390XState *env, uint32_t r1, uint32_t mask,
 
     if (!mask) {
         /* Recognize access exceptions for the first byte */
-        probe_read(env, addr, 1, cpu_mmu_index(env, false), ra);
+        probe_read(env, addr, 1, s390x_env_mmu_index(env, false), ra);
     }
 
     while (mask) {
@@ -893,7 +893,7 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint32_t r1, uint32_t r2)
 {
     const uint64_t src = get_address(env, r2) & TARGET_PAGE_MASK;
     const uint64_t dst = get_address(env, r1) & TARGET_PAGE_MASK;
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = s390x_env_mmu_index(env, false);
     const bool f = extract64(r0, 11, 1);
     const bool s = extract64(r0, 10, 1);
     const bool cco = extract64(r0, 8, 1);
@@ -946,7 +946,7 @@ inject_exc:
 /* string copy */
 uint32_t HELPER(mvst)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = s390x_env_mmu_index(env, false);
     const uint64_t d = get_address(env, r1);
     const uint64_t s = get_address(env, r2);
     const uint8_t c = env->regs[0];
@@ -1027,7 +1027,7 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
                                uint64_t *src, uint64_t *srclen,
                                uint16_t pad, int wordsize, uintptr_t ra)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = s390x_env_mmu_index(env, false);
     int len = MIN(*destlen, -(*dest | TARGET_PAGE_MASK));
     S390Access srca, desta;
     int i, cc;
@@ -1084,7 +1084,7 @@ static inline uint32_t do_mvcl(CPUS390XState *env,
 /* move long */
 uint32_t HELPER(mvcl)(CPUS390XState *env, uint32_t r1, uint32_t r2)
 {
-    const int mmu_idx = cpu_mmu_index(env, false);
+    const int mmu_idx = s390x_env_mmu_index(env, false);
     uintptr_t ra = GETPC();
     uint64_t destlen = env->regs[r1 + 1] & 0xffffff;
     uint64_t dest = get_address(env, r1);
@@ -1742,7 +1742,7 @@ uint32_t HELPER(trXX)(CPUS390XState *env, uint32_t r1, uint32_t r2,
 static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
                         uint64_t a2, bool parallel)
 {
-    uint32_t mem_idx = cpu_mmu_index(env, false);
+    uint32_t mem_idx = s390x_env_mmu_index(env, false);
     MemOpIdx oi16 = make_memop_idx(MO_TE | MO_128, mem_idx);
     MemOpIdx oi8 = make_memop_idx(MO_TE | MO_64, mem_idx);
     MemOpIdx oi4 = make_memop_idx(MO_TE | MO_32, mem_idx);
@@ -2867,12 +2867,14 @@ uint32_t HELPER(cu42)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t m3)
 void probe_write_access(CPUS390XState *env, uint64_t addr, uint64_t len,
                         uintptr_t ra)
 {
+    const int mmu_idx = s390x_env_mmu_index(env, false);
+
     /* test the actual access, not just any access to the page due to LAP */
     while (len) {
         const uint64_t pagelen = -(addr | TARGET_PAGE_MASK);
         const uint64_t curlen = MIN(pagelen, len);
 
-        probe_write(env, addr, curlen, cpu_mmu_index(env, false), ra);
+        probe_write(env, addr, curlen, mmu_idx, ra);
         addr = wrap_address(env, addr + curlen);
         len -= curlen;
     }
-- 
2.34.1


