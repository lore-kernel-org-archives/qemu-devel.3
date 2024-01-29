Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFF1C48286
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6I-0005w6-HO; Mon, 29 Jan 2024 18:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6H-0005uh-2B
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:37 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6F-000576-6L
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:36 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d748d43186so16536145ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571094; x=1707175894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvOQFTMkY9QB65SS7g0QhXugn3UR4E0seouTHChD6V0=;
 b=xcnb47P7ZQ+PbKxstvhd7l6+AQmAV+mwf8l0IAKUvvqxfQg737ZnzmRuCMCUQzXIA1
 FXSoabViFJsv5SkaufDHoIp+sHCd2PUr8dIe53VIYvVUGnn+0XBXs024WOLIlKiJIkAi
 GrLT5RY2ilwZ6pAcX0pH+HKkVCXY80JpTgOO/0RgScfoylX9vv0p7NoAcyiObaO+Cjnf
 mbe/HsTW8neJRpQgS/d3QDoi1d1akTRGNe8A+2s+NUKEvR05R8ZDXfI1nNmZoRwhsy3l
 VBbbYEzffQ/8SFe//h51cGrEQX7CoFEjY9ZLCtWuPHGgXNRiQMD+ss5hh/BEYoMl2JAt
 bynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571094; x=1707175894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvOQFTMkY9QB65SS7g0QhXugn3UR4E0seouTHChD6V0=;
 b=pjP5Z5JJNQgedQljjYb+EXGoFkRCAoPzN2/1D3NBljgaVhFHYLbRpHREGbxgkQ9BkB
 gepPL7VUtA6NNdkU3DjrFITmO8DJgeuLkIT5CkfTU1nL3bUBlyVNFjQ6jQVtCyrAsrDd
 zkHQEFllMSsaAIPfX2flkveLXELRh4vGGu75obV0PXPsHBxI4efJ5zhVFYLnpvFJBCqN
 gqbnMdRc3DSZOOwOp5khpyhWn5ZOZoUdkoaRd/ygPSjsjlzN5uXQxm/VuhCh5RDsI9rj
 gHUoNeLcGeL7C4WVx56ybjzdKQChJOKUm2VxDU0/4yy+J4/euIf7V/jB0fMUtKuGzxsu
 mrCw==
X-Gm-Message-State: AOJu0Yzi3bKNPbR52ilK+AMGgKOID/QPsA5EhV/7VoveEGvjEH0O9yVv
 iQ2+gENOx8cTopBP0maCrc5ucgjXxbMb33lJT6lVrhO+BFE6TpocRnyDc3BviBK2/THJW389HG1
 9ICs=
X-Google-Smtp-Source: AGHT+IG50MstLU27ikFd4QI5rtAAXNbFwajMh283Zodk7zzWqGd/zHoBdrjnlO0leHPwC1gTTXKiEA==
X-Received: by 2002:a17:902:8d94:b0:1d8:da2c:1008 with SMTP id
 v20-20020a1709028d9400b001d8da2c1008mr2010811plo.28.1706571093905; 
 Mon, 29 Jan 2024 15:31:33 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 20/33] target/ppc: Split out ppc_env_mmu_index
Date: Tue, 30 Jan 2024 09:30:30 +1000
Message-Id: <20240129233043.34558-21-richard.henderson@linaro.org>
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
 target/ppc/cpu.h        |  7 ++++++-
 target/ppc/cpu_init.c   |  2 +-
 target/ppc/mem_helper.c | 10 +++++-----
 target/ppc/mmu_common.c |  4 ++--
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f8101ffa29..5f4f52aec5 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1624,7 +1624,7 @@ int ppc_dcr_write(ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 
 /* MMU modes definitions */
 #define MMU_USER_IDX 0
-static inline int cpu_mmu_index(CPUPPCState *env, bool ifetch)
+static inline int ppc_env_mmu_index(CPUPPCState *env, bool ifetch)
 {
 #ifdef CONFIG_USER_ONLY
     return MMU_USER_IDX;
@@ -1633,6 +1633,11 @@ static inline int cpu_mmu_index(CPUPPCState *env, bool ifetch)
 #endif
 }
 
+static inline int cpu_mmu_index(CPUPPCState *env, bool ifetch)
+{
+    return ppc_env_mmu_index(env, ifetch);
+}
+
 /* Compatibility modes */
 #if defined(TARGET_PPC64)
 bool ppc_check_compat(PowerPCCPU *cpu, uint32_t compat_pvr,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 23eb5522b6..86c8031765 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7457,7 +7457,7 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "MSR " TARGET_FMT_lx " HID0 " TARGET_FMT_lx "  HF "
                  "%08x iidx %d didx %d\n",
                  env->msr, env->spr[SPR_HID0], env->hflags,
-                 cpu_mmu_index(env, true), cpu_mmu_index(env, false));
+                 ppc_env_mmu_index(env, true), ppc_env_mmu_index(env, false));
 #if !defined(CONFIG_USER_ONLY)
     if (env->tb_env) {
         qemu_fprintf(f, "TB %08" PRIu32 " %08" PRIu64
diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
index c7535481d6..ea7e8443a8 100644
--- a/target/ppc/mem_helper.c
+++ b/target/ppc/mem_helper.c
@@ -83,7 +83,7 @@ static void *probe_contiguous(CPUPPCState *env, target_ulong addr, uint32_t nb,
 void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
 {
     uintptr_t raddr = GETPC();
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = ppc_env_mmu_index(env, false);
     void *host = probe_contiguous(env, addr, (32 - reg) * 4,
                                   MMU_DATA_LOAD, mmu_idx, raddr);
 
@@ -105,7 +105,7 @@ void helper_lmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
 void helper_stmw(CPUPPCState *env, target_ulong addr, uint32_t reg)
 {
     uintptr_t raddr = GETPC();
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = ppc_env_mmu_index(env, false);
     void *host = probe_contiguous(env, addr, (32 - reg) * 4,
                                   MMU_DATA_STORE, mmu_idx, raddr);
 
@@ -135,7 +135,7 @@ static void do_lsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
         return;
     }
 
-    mmu_idx = cpu_mmu_index(env, false);
+    mmu_idx = ppc_env_mmu_index(env, false);
     host = probe_contiguous(env, addr, nb, MMU_DATA_LOAD, mmu_idx, raddr);
 
     if (likely(host)) {
@@ -224,7 +224,7 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
         return;
     }
 
-    mmu_idx = cpu_mmu_index(env, false);
+    mmu_idx = ppc_env_mmu_index(env, false);
     host = probe_contiguous(env, addr, nb, MMU_DATA_STORE, mmu_idx, raddr);
 
     if (likely(host)) {
@@ -276,7 +276,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
     target_ulong mask, dcbz_size = env->dcache_line_size;
     uint32_t i;
     void *haddr;
-    int mmu_idx = epid ? PPC_TLB_EPID_STORE : cpu_mmu_index(env, false);
+    int mmu_idx = epid ? PPC_TLB_EPID_STORE : ppc_env_mmu_index(env, false);
 
 #if defined(TARGET_PPC64)
     /* Check for dcbz vs dcbzl on 970 */
diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 6ca5d12207..751403f1c8 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1561,9 +1561,9 @@ hwaddr ppc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
      * mapped by code TLBs, so we also try a MMU_INST_FETCH.
      */
     if (ppc_xlate(cpu, addr, MMU_DATA_LOAD, &raddr, &s, &p,
-                  cpu_mmu_index(&cpu->env, false), false) ||
+                  ppc_env_mmu_index(&cpu->env, false), false) ||
         ppc_xlate(cpu, addr, MMU_INST_FETCH, &raddr, &s, &p,
-                  cpu_mmu_index(&cpu->env, true), false)) {
+                  ppc_env_mmu_index(&cpu->env, true), false)) {
         return raddr & TARGET_PAGE_MASK;
     }
     return -1;
-- 
2.34.1


