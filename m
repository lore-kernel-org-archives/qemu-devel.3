Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CA4C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSw-000223-SA; Fri, 02 Feb 2024 00:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSr-0001jM-P0
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:49 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSl-0001y9-I0
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:49 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bd4e6a7cb0so1051201b6e.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853098; x=1707457898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KU7EStZth3E9tctrbtwNvpcpJNElX8vZOQySN4oq7zk=;
 b=mLz0s/zHn7NggBD1j/fcpnmiaxWqeikMoTaQb8Sw0aS0+ABrd30DURMwY4HZ2jE8C2
 dluXpHMUHmBrTU0PlwYusfaHUOR7+2GRNg6OprEPe0cf0f5z96yD+O+vE2xUuXhKZyax
 i+MRc1+fKXyAVX83z0OXfghxe4WubaXMtWNztu5iqb2n5uxH1l84P2QiXQADqltG0M/l
 DtceC5cpOBQuVnF0NNKNqUIEmwlPJUABwY8RgwSECwdN3H9S8bTzcnP8KyOmmaJ1nsxB
 kQ00I3e3Nh16scJ3e8qdFVR/Pz6+UtvXJxGd6P862TG/xODgQnsuJY5mqpKRrNVLsYWj
 U5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853098; x=1707457898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KU7EStZth3E9tctrbtwNvpcpJNElX8vZOQySN4oq7zk=;
 b=C4rj58U/A9cdyCAd69KDVQdtlkl2r1mqO77BjjqsrIizww8Wuapt+oAYh5NsXnPjZl
 le/K4gMneQhXchiKN332csLcuBUs0vQ23RuVp0jKNY+kPSrJQ5FOrAd9ss3jxTSd9pm2
 0GVKM2M0kri9nDA3JtvnGDos77n/H/cjm4Kv+4agSuK0uW7eunplk3YyBBZYXW507ET/
 OyC55GknN0M+q/xfrRdZcz4awzcjnN6ZofyGmrnYcyEQSS4idEgNzZ0PurfLwQsNH4+h
 Hi2dtAaKJiwJ8UsVEnufb1/C/mCkAmL0V6ych7CT1p0iUhZD6456lSVMoWC9OuusuiC4
 JP+g==
X-Gm-Message-State: AOJu0YwHbm6yBN5jXaofj86jtw9xJ9Jv3b/vdFTkgcuErXpawNrGo6+J
 3M5ZXCOMgISAg4vGCN6t1FxmBqQWPIV6QRTeHPo/bYS4h5MOIrPM0ycy7Q/SJhCp8tUCucn1yos
 YEq8=
X-Google-Smtp-Source: AGHT+IEi/U/kbG0qTOHZ65kSItJb12lQaAk8Ng50u6qotqKenrxQYzN6e5upmMel9TtnE8KzKeUrKQ==
X-Received: by 2002:a05:6808:30a5:b0:3bf:c0e7:6a29 with SMTP id
 bl37-20020a05680830a500b003bfc0e76a29mr462346oib.0.1706853097882; 
 Thu, 01 Feb 2024 21:51:37 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/57] target/s390x: Split out s390x_env_mmu_index
Date: Fri,  2 Feb 2024 15:50:05 +1000
Message-Id: <20240202055036.684176-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


