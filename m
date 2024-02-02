Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 968CEC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSe-0001Mg-3k; Fri, 02 Feb 2024 00:51:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSV-0001H8-JY
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:27 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmST-0001py-Ti
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:27 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso1526164a12.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853084; x=1707457884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HgdbWgNLg8LLScF7lhaba0ocAypckeHfyh0foJfM/Y8=;
 b=bJ3sqXgCTlhIb7qBQWo0yOacagKLRXFfEA/lOOnqOyJEpu1cItSgza003KVw4HPc4m
 vV/XaPTLirRGjf5yzzkUZ/kgt8xsbmlcYy/gnx4reiSooyy4FnjmNDSGx5vKTICtXqTD
 TqRROrCHTD3Krd+9YzQAc7gd2hlnJ3AIId1aec7A08Cowl14aDaOWy4xU2tCZjsAJ9Yu
 3bSfr0OMGGz1PiU1pBs4fRX97mATIkbuU44ndNp1UfaNh3g9K56RS0w7cwd6RWl35MVI
 X7PkiXX53pDygh72ZC7SLPwM4LuIhuQ0bSkv7ZeY49+bJNhkaW2YFVw3CBQR2Ib846HB
 bwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853084; x=1707457884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HgdbWgNLg8LLScF7lhaba0ocAypckeHfyh0foJfM/Y8=;
 b=RJmrEFiMVN1tbNxeZXiMe+c4E8xQH+WnYM71P22GSe2kTAwBH8mr2sX08ndT/0wO/p
 j74OKdMfQzE08lC3nBh7XwhpitwGRGnOZoA3Qgid99wrYmfV6n/tJBwK/HSuCBk1Mfc9
 rfFkCy9JsDvNiHmZnWe1V2swwLC25Zon56oORhycQkC6cjcp5ME7U5aq3d45Nm6t1rP0
 alJfpe4a4/qJ6CeufTKfbQAiw3B7xQhxbLreY/SlLoBXAea6191Zovqeas3IbtWYbnAd
 A7KpBEzX6UrqmrdymO/wgJk4DRDObQ1gtz0sgF/dy3Kzede123rF3oUx0rNhuVaJFGSS
 GxBQ==
X-Gm-Message-State: AOJu0YzCVoNG6P2+4F4p/3nPY37wm2lVrYfZy+TnCWgQD4sd3UROLtHW
 Z0fCkq4t9w4Kv5dWRxp2AUJt+yACa+sDirw6bvO5mfIzsTtK0sjs2tXz0wtZKXxejfyAKnewfBI
 EHhU=
X-Google-Smtp-Source: AGHT+IG0nfkvEQ3FA5/SqZbT+5m7J3JkA60OB7OifnwMi+aSnE8ZyxbyeHU6ahveu0B9s+nNyEwifw==
X-Received: by 2002:a05:6a20:ce48:b0:19e:4e80:27f0 with SMTP id
 id8-20020a056a20ce4800b0019e4e8027f0mr685001pzb.37.1706853084256; 
 Thu, 01 Feb 2024 21:51:24 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/57] target/ppc: Split out ppc_env_mmu_index
Date: Fri,  2 Feb 2024 15:49:59 +1000
Message-Id: <20240202055036.684176-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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


