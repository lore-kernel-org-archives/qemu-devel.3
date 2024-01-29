Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14955C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6C-0005pc-R1; Mon, 29 Jan 2024 18:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb68-0005jJ-Mm
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:28 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb66-00055D-Os
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:28 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5ceb3fe708eso1906425a12.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571085; x=1707175885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+TWhdTukAWg6C2H3nrXhuQpGBPdO1u3jsZKcAzF+cD4=;
 b=QJ+O/poacsRfDYf8fT7RXvbXdOhHztWcx1NXeM5YaSGizck6v/hpCHY5UlTj2npnuh
 yGK0XoBUzDrO/z7UhUQFIBMQvDdgbHBCxtlitHHbDlPxy8dlEthgXctfMu5lKBLNnHwu
 Dy2ISI4iGoYbCJd5ZgystpKn4RfZS2THj62wi3FDGYO25a3Lf0ZUqVNP7tcSrk+3nLF6
 jyJhMIOoDOPW/gxodJY9KYv3dAoddi8m9X50hu8NwW/G09cjC31vMdBJ4yj4gGUDatQt
 UpHEHNDEOzP1gl5BtOTFZMLCIa0e6eMnHvfzrwDrNBN74US+hz+rlp2YpmxiFaUwVxBP
 BTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571085; x=1707175885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+TWhdTukAWg6C2H3nrXhuQpGBPdO1u3jsZKcAzF+cD4=;
 b=f3xwOmkp2f2EX2STor9fUTo3PnF4hqQ+Z5LDJFTQ5jJYU6aHv5lZGSFfjSABuFnpza
 9whdkQ4EX23C7hHri1Wi/+Wk6a8+JJHjRAVZwUmQ8DyNBLM9XlSth/iR6xY+7SBLJFMu
 U8ZeTPhTXBCiPLFIAC5wocxm/sMJapuj4yNWojuShGKxAWi9wuG82KOma8xjQaN+arO9
 0ZjpBWjfDPlvnBON8Ir6DPzfc24tPH+RXWrzsxzQh0JNK/rHVLYtf8btnpQWUu6x5L7u
 4S6qqMyr1ROVzGtHWYFJtfdfehBI3j9wvYjgt4JBp+uX1wT8g39DhwPS6sTSMUsV/zI+
 xgfg==
X-Gm-Message-State: AOJu0YzY+KEUKZ+RBScfOU/KRNUuVU0XpmWLzahYvMLwmPpCK8GSOliV
 p0BZ1woS75/WqjDxLKMkXFMztTseB13gJeZUPCZ7fZGog4axQ46cigfHh7bGGleA9P1J2BGJjoD
 ItSg=
X-Google-Smtp-Source: AGHT+IFfVhhMCqOA+z7KfZD8IPF/IFpqnp0gcKPoy6eNbvJ09lSqP6ZkCBUswAwXds1aCPvq74vEOg==
X-Received: by 2002:a17:902:6942:b0:1d5:f36c:8737 with SMTP id
 k2-20020a170902694200b001d5f36c8737mr4323268plt.68.1706571084821; 
 Mon, 29 Jan 2024 15:31:24 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 16/33] target/mips: Split out mips_env_mmu_index
Date: Tue, 30 Jan 2024 09:30:26 +1000
Message-Id: <20240129233043.34558-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
 target/mips/cpu.h                       |  7 ++++++-
 target/mips/sysemu/physaddr.c           |  2 +-
 target/mips/tcg/msa_helper.c            | 10 +++++-----
 target/mips/tcg/sysemu/cp0_helper.c     |  2 +-
 target/mips/tcg/sysemu/special_helper.c |  2 +-
 target/mips/tcg/sysemu/tlb_helper.c     |  2 +-
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3ba8dccd2d..4c15e76781 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1255,11 +1255,16 @@ static inline int hflags_mmu_index(uint32_t hflags)
     }
 }
 
-static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
+static inline int mips_env_mmu_index(CPUMIPSState *env)
 {
     return hflags_mmu_index(env->hflags);
 }
 
+static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
+{
+    return mips_env_mmu_index(env);
+}
+
 #include "exec/cpu-all.h"
 
 /* Exceptions */
diff --git a/target/mips/sysemu/physaddr.c b/target/mips/sysemu/physaddr.c
index 05990aa5bb..13c8bc8f47 100644
--- a/target/mips/sysemu/physaddr.c
+++ b/target/mips/sysemu/physaddr.c
@@ -236,7 +236,7 @@ hwaddr mips_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot;
 
     if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
-                             cpu_mmu_index(env, false)) != 0) {
+                             mips_env_mmu_index(env)) != 0) {
         return -1;
     }
     return phys_addr;
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 7a8dbada5d..d2181763e7 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8214,7 +8214,7 @@ void helper_msa_ffint_u_df(CPUMIPSState *env, uint32_t df, uint32_t wd,
 #if !defined(CONFIG_USER_ONLY)
 #define MEMOP_IDX(DF)                                                   \
     MemOpIdx oi = make_memop_idx(MO_TE | DF | MO_UNALN,                 \
-                                 cpu_mmu_index(env, false));
+                                 mips_env_mmu_index(env));
 #else
 #define MEMOP_IDX(DF)
 #endif
@@ -8323,7 +8323,7 @@ void helper_msa_st_b(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = mips_env_mmu_index(env);
     uintptr_t ra = GETPC();
 
     ensure_writable_pages(env, addr, mmu_idx, ra);
@@ -8337,7 +8337,7 @@ void helper_msa_st_h(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = mips_env_mmu_index(env);
     uintptr_t ra = GETPC();
     uint64_t d0, d1;
 
@@ -8358,7 +8358,7 @@ void helper_msa_st_w(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = mips_env_mmu_index(env);
     uintptr_t ra = GETPC();
     uint64_t d0, d1;
 
@@ -8379,7 +8379,7 @@ void helper_msa_st_d(CPUMIPSState *env, uint32_t wd,
                      target_ulong addr)
 {
     wr_t *pwd = &(env->active_fpu.fpr[wd].wr);
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = mips_env_mmu_index(env);
     uintptr_t ra = GETPC();
 
     ensure_writable_pages(env, addr, mmu_idx, GETPC());
diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu/cp0_helper.c
index cc545aed9c..62f6fb4bf6 100644
--- a/target/mips/tcg/sysemu/cp0_helper.c
+++ b/target/mips/tcg/sysemu/cp0_helper.c
@@ -1202,7 +1202,7 @@ void helper_mtc0_status(CPUMIPSState *env, target_ulong arg1)
                 old, old & env->CP0_Cause & CP0Ca_IP_mask,
                 val, val & env->CP0_Cause & CP0Ca_IP_mask,
                 env->CP0_Cause);
-        switch (cpu_mmu_index(env, false)) {
+        switch (mips_env_mmu_index(env)) {
         case 3:
             qemu_log(", ERL\n");
             break;
diff --git a/target/mips/tcg/sysemu/special_helper.c b/target/mips/tcg/sysemu/special_helper.c
index 93276f789d..518d3fbc34 100644
--- a/target/mips/tcg/sysemu/special_helper.c
+++ b/target/mips/tcg/sysemu/special_helper.c
@@ -68,7 +68,7 @@ static void debug_post_eret(CPUMIPSState *env)
         if (env->hflags & MIPS_HFLAG_DM) {
             qemu_log(" DEPC " TARGET_FMT_lx, env->CP0_DEPC);
         }
-        switch (cpu_mmu_index(env, false)) {
+        switch (mips_env_mmu_index(env)) {
         case 3:
             qemu_log(", ERL\n");
             break;
diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index b715449114..cdae42ffdd 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -973,7 +973,7 @@ hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong address,
 
     /* data access */
     ret = get_physical_address(env, &physical, &prot, address, access_type,
-                               cpu_mmu_index(env, false));
+                               mips_env_mmu_index(env));
     if (ret == TLBRET_MATCH) {
         return physical;
     }
-- 
2.34.1


