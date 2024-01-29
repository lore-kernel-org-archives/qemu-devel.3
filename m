Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F18EC4828C
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6Q-0005xh-8N; Mon, 29 Jan 2024 18:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6N-0005wy-Tr
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:43 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb6L-00059A-TX
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:43 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29065efa06fso2677526a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571100; x=1707175900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T1A5JMP4c4pUqbkuAUmVb/gWlj2brd508NIa6msXbG4=;
 b=MGzoZ4epBncI5QdoFjTJHMeHiruX7062BSBjEKQfsj2F6Dk232Ckaoa9GXzEMBszce
 OQCB8mBQA5J/cpDgyxGghxSLN+50hgcWD9z0haTXLjKK2pBAn9nod8fpeJ9r9bYnN9nn
 H+3NRc608baQXq9xYeYhB2R94rNqnixcp+Bz+3xFkN4tyhHcRKtE8RTy5ekYkihPitBf
 kBiTrYYnDImlTNhd6xKb2JySK5dKUt6ly49qMHga4RUq4+mbJXcqtD8Abuv8M5gshrXp
 caX0Ip4ICO4S8+MkXeUfxzPieuNkDXlRVEpJ+CW3wrOboyBuHNgV72oznEaqXCtCyG4a
 YtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571100; x=1707175900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T1A5JMP4c4pUqbkuAUmVb/gWlj2brd508NIa6msXbG4=;
 b=sM2gW26v45FHQ/eYTs2rnVk2gf6gzYao3Fv1xXymRXeF/7mfAcKGEYQKe9ncEK2vzR
 ODNOPF3Fa2Ot/7SSXB1HvhWKXlnZz9QrLsBi59CU6bkV83LR4JEwQaM2TFY9w8FE6zLw
 jXxyvNU8zh7+6Kbtcb2UrTtMNKaHTSeXsX+h58Bk0OU4WlEsPYjixpWG9UWNlFd+AWdJ
 uo3/btnBCzfbEBP/mbPLGexLeENqFJRqJlOlUh/Zm2aqr01LrL4FkTtOrmrbiEZZaFMa
 /CHUJWJo8Vjl+NZRt8EGBKJmVgeKNQiTUajn07r9o4zWlAM6eVRBb8GgyFefgyCUrYYC
 jdNA==
X-Gm-Message-State: AOJu0Ywl76DMgOwZJOTaYTkmBWIzLvz5OaSpd10TVo18WrdXTrb6a1hY
 VeFCkzdBnUEXBsMHky0dJfevF1PP7ZcQJmQTi8sOtFrq+nfDcr56pmc9SD38gVAkUHgT+hMVOLI
 WThA=
X-Google-Smtp-Source: AGHT+IG6vM83YY3uPWXAD7JYlKQ8m3WdGStjzEtf7yjU7xeAW5yQi8oOPXva6ouHN0tr7oD3Oa1v1A==
X-Received: by 2002:a17:90a:898e:b0:28e:8692:af8 with SMTP id
 v14-20020a17090a898e00b0028e86920af8mr4363356pjn.26.1706571100740; 
 Mon, 29 Jan 2024 15:31:40 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 23/33] target/riscv: Replace cpu_mmu_index with
 riscv_env_mmu_index
Date: Tue, 30 Jan 2024 09:30:33 +1000
Message-Id: <20240129233043.34558-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Use the target-specific function name in preference
to the generic name.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu_helper.c    | 4 ++--
 target/riscv/op_helper.c     | 4 ++--
 target/riscv/vector_helper.c | 9 +++++----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 15f87ecdb0..b6b23b7d03 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -106,7 +106,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 #else
     flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
 
-    flags |= cpu_mmu_index(env, 0);
+    flags |= riscv_env_mmu_index(env, 0);
     fs = get_field(env->mstatus, MSTATUS_FS);
     vs = get_field(env->mstatus, MSTATUS_VS);
 
@@ -1200,7 +1200,7 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     CPURISCVState *env = &cpu->env;
     hwaddr phys_addr;
     int prot;
-    int mmu_idx = cpu_mmu_index(&cpu->env, false);
+    int mmu_idx = riscv_env_mmu_index(&cpu->env, false);
 
     if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_idx,
                              true, env->virt_enabled, true)) {
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 5355225d56..f414aaebdb 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -157,7 +157,7 @@ void helper_cbo_zero(CPURISCVState *env, target_ulong address)
 {
     RISCVCPU *cpu = env_archcpu(env);
     uint16_t cbozlen = cpu->cfg.cboz_blocksize;
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = riscv_env_mmu_index(env, false);
     uintptr_t ra = GETPC();
     void *mem;
 
@@ -205,7 +205,7 @@ static void check_zicbom_access(CPURISCVState *env,
                                 uintptr_t ra)
 {
     RISCVCPU *cpu = env_archcpu(env);
-    int mmu_idx = cpu_mmu_index(env, false);
+    int mmu_idx = riscv_env_mmu_index(env, false);
     uint16_t cbomlen = cpu->cfg.cbom_blocksize;
     void *phost;
     int ret;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index c1c3a4d1ea..fe0d5d053c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -113,14 +113,15 @@ static void probe_pages(CPURISCVState *env, target_ulong addr,
 {
     target_ulong pagelen = -(addr | TARGET_PAGE_MASK);
     target_ulong curlen = MIN(pagelen, len);
+    int mmu_index = riscv_env_mmu_index(env, false);
 
     probe_access(env, adjust_addr(env, addr), curlen, access_type,
-                 cpu_mmu_index(env, false), ra);
+                 mmu_index, ra);
     if (len > curlen) {
         addr += curlen;
         curlen = len - curlen;
         probe_access(env, adjust_addr(env, addr), curlen, access_type,
-                     cpu_mmu_index(env, false), ra);
+                     mmu_index, ra);
     }
 }
 
@@ -464,6 +465,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
     uint32_t esz = 1 << log2_esz;
     uint32_t vma = vext_vma(desc);
     target_ulong addr, offset, remain;
+    int mmu_index = riscv_env_mmu_index(env, false);
 
     /* probe every access */
     for (i = env->vstart; i < env->vl; i++) {
@@ -478,8 +480,7 @@ vext_ldff(void *vd, void *v0, target_ulong base,
             remain = nf << log2_esz;
             while (remain > 0) {
                 offset = -(addr | TARGET_PAGE_MASK);
-                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD,
-                                         cpu_mmu_index(env, false));
+                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmu_index);
                 if (host) {
 #ifdef CONFIG_USER_ONLY
                     if (!page_check_range(addr, offset, PAGE_READ)) {
-- 
2.34.1


