Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25582C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmSf-0001Nh-AL; Fri, 02 Feb 2024 00:51:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSQ-0001Fq-0q
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:22 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmSL-0001mw-Va
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:51:20 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6de28744a46so1327741b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853076; x=1707457876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XatY8fnmW3a/bWiIkdzT21/U2K0JQklTZ8UirY2XMgg=;
 b=TVrFwDb2s7u8//jGf0L6WxxnRjM+WkUmOvEukaKVkZvfurjOFH/qigj/AA8u099iiP
 cduCQ01b+Iv1nxp6s+sIg/Z+1Hcg76zqhTZi5rKRILgSGZLM/3OgLX62XU/dECxx0VlT
 9ON/aXBsImOyrLTQ206yHMLTGETLo2KorkuN76OQHboUtKSlwpvzP1hKgdgcZBqkZkTZ
 efRrnh0O51FuL9O0ZhzZ0oYgNjX7+38LO9W+pxqcwq6HAtbiaWMzKE2NGdTIRn10SyVD
 lZvXNFyXHFlhduzb9/OS/MlcGQJRwUiCojig2T8yr5OdPuKoZlrLWN/soVLI6hzITWnz
 TUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853076; x=1707457876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XatY8fnmW3a/bWiIkdzT21/U2K0JQklTZ8UirY2XMgg=;
 b=em6sAER4XACDArv5Yy+YwFvGNnBqjwFYRAznAEHCFAkuXjsL3UKqEpyclqDFSZoRkA
 Voyo0MsnuHqdzPsk5q9QQ4wJ5enGEwuftwloMhfXd1N/wPMxu7GJVNtEF8LO+8h15JDI
 v5WyX/AdKSWZ9tkDF9FZSv9kJymEVYImCKhIAGV6P6kivZwExzeiqswNjlEQHh0PQe5M
 OkZSxjbScgiw3zwR0J08dTwnpepmvyiJTwQYunFPN7Lz8mwZPa68oD4CWUIQFY53e/DH
 7DtOnrqwiig+1RS6CkNb9nzVd3UY5FSPD2SH7aYxl6fwkzBZ7ITugvmbCJYxV9A50Hhw
 8c5g==
X-Gm-Message-State: AOJu0YxUXwEnbLony1wNVvhe4LZyjiH3dE7JUPXqFCjtiH64Qa/jvMSq
 bcbCYd7nFn/dTC5oVhUQ7M/z0Xfjrg8k2S8kxxWcrjbaifvUmHehPH5kAtTD64qSufr1ZVVghVv
 AAmE=
X-Google-Smtp-Source: AGHT+IEYxQnmsreIuS8BRMcrrRKVKyuhIx5a9jLs6neXBc1/rTYUxEw4QsFVsI1jUzCgnW+YzGU/CQ==
X-Received: by 2002:a05:6a00:451a:b0:6df:c424:7949 with SMTP id
 cw26-20020a056a00451a00b006dfc4247949mr9822810pfb.26.1706853076079; 
 Thu, 01 Feb 2024 21:51:16 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 h2-20020aa79f42000000b006dab0d72cd0sm715111pfr.214.2024.02.01.21.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:51:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/57] target/mips: Split out mips_env_mmu_index
Date: Fri,  2 Feb 2024 15:49:55 +1000
Message-Id: <20240202055036.684176-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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


