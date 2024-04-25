Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4C6C10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYM-0008SQ-Fg; Wed, 24 Apr 2024 20:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmY0-0008Jx-33
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:08 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXx-0006KA-L6
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:07 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e3c3aa8938so2854235ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003262; x=1714608062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BchewleEa3z2kopUOxAP4EuB5+hh38PFClM+ZeDHVn8=;
 b=R8khUTNkCeQcvwu7C+LuItdc1QI6WzO7P/dbWJ9/XTDXjEiBXcF1vXQtzgEMhi7X5B
 7Iwqjc3b+KazyEBRLj0cxbX5dhp1NwWnGIFUiLMjNkj5ESN8YOP+sZSEPj9r3g1DMjVe
 JTucQy1nSVbG91nxitbm2nVdIuOO94YCXakJ7RWY4nJhR/QdNoESEa1Tsxne+cb2fGzp
 xTxebT1hQYo8ZrjWR9ybLraLK3oEkJzKHWhIkRKlUeoYhypYOzCSDNf9mOnCCz9FCwYB
 Ufbsq/iEDIy2xQjbHXe3n1NTmf8aeVXx/s5k+Prw+xw4CavcL0caYXBBiRz3Wk4A+mA/
 7oJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003262; x=1714608062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BchewleEa3z2kopUOxAP4EuB5+hh38PFClM+ZeDHVn8=;
 b=CcU/lJkCqRyYCMkubdEbBGP6v/9KqetX1XieIKGVHsySFAC3pdpXEAg1eCI0AevB9l
 3Zv0urnvOrAHN2tGPqrJsu63Vowf+QClMxudhAG3YGwk9g1Qis2gLuNqFqxjKXukyYGN
 BoxYMMQ+rDaxNMENbRvqByPUk9ZNMDwwtqZRcLEWyH17OLXWYO5AFprTDM3fjhjFMdeN
 bgYIg4L0Wge+0KjtaehD4C5i3+4PFhL3NPS5B6uEZvFOu7vEt34VRo0R1Jl2rPiDwOl9
 KpIItsAegIOtg4/wtFxxYYT67SOOA6xkIv+CaOBHCpjRThqLEZJlDrywiELfwgJw3F+o
 Kokw==
X-Gm-Message-State: AOJu0Yx6YK9vtDPchh1yItLeTZPTNs72BTj2IBC+tYFoyPZIlExfMUYG
 DgylgtjwmEVI9Ds+csZudS7bZYiZe+bpOll2M4V3XsukhDj+/ts5a7qKCj7hxFhJit9vBTraNSS
 i
X-Google-Smtp-Source: AGHT+IHF4AC02lAoywWNOagintx/+PjZxRpRGXxkPLyEpoR/8DuasAVUK/gpaHfT+5/0sWJoE27cdQ==
X-Received: by 2002:a17:902:6e02:b0:1e8:ef23:80f6 with SMTP id
 u2-20020a1709026e0200b001e8ef2380f6mr3904337plk.37.1714003262632; 
 Wed, 24 Apr 2024 17:01:02 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.01.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:01:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 39/45] target/hppa: Drop tlb_entry return from
 hppa_get_physical_address
Date: Wed, 24 Apr 2024 17:00:17 -0700
Message-Id: <20240425000023.1002026-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

The return-by-reference is never used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  3 +--
 target/hppa/int_helper.c |  2 +-
 target/hppa/mem_helper.c | 19 ++++---------------
 target/hppa/op_helper.c  |  3 +--
 4 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 629299653d..5f3e99cdc4 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -377,8 +377,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 void hppa_cpu_do_interrupt(CPUState *cpu);
 bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
-                              int type, hwaddr *pphys, int *pprot,
-                              HPPATLBEntry **tlb_entry);
+                              int type, hwaddr *pphys, int *pprot);
 void hppa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                      vaddr addr, unsigned size,
                                      MMUAccessType access_type,
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 97e5f0b9a7..b82f32fd12 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -167,7 +167,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
 
                     vaddr = hppa_form_gva_psw(old_psw, env->iasq_f, vaddr);
                     t = hppa_get_physical_address(env, vaddr, MMU_KERNEL_IDX,
-                                                  0, &paddr, &prot, NULL);
+                                                  0, &paddr, &prot);
                     if (t >= 0) {
                         /* We can't re-load the instruction.  */
                         env->cr[CR_IIR] = 0;
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 5eca5e8a1e..3ef9e80064 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -196,18 +196,13 @@ static int match_prot_id64(CPUHPPAState *env, uint32_t access_id)
 }
 
 int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
-                              int type, hwaddr *pphys, int *pprot,
-                              HPPATLBEntry **tlb_entry)
+                              int type, hwaddr *pphys, int *pprot)
 {
     hwaddr phys;
     int prot, r_prot, w_prot, x_prot, priv;
     HPPATLBEntry *ent;
     int ret = -1;
 
-    if (tlb_entry) {
-        *tlb_entry = NULL;
-    }
-
     /* Virtual translation disabled.  Map absolute to physical.  */
     if (MMU_IDX_MMU_DISABLED(mmu_idx)) {
         switch (mmu_idx) {
@@ -237,10 +232,6 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         goto egress;
     }
 
-    if (tlb_entry) {
-        *tlb_entry = ent;
-    }
-
     /* We now know the physical address.  */
     phys = ent->pa + (addr - ent->itree.start);
 
@@ -349,7 +340,7 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
                cpu->env.psw & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX);
 
     excp = hppa_get_physical_address(&cpu->env, addr, mmu_idx, 0,
-                                     &phys, &prot, NULL);
+                                     &phys, &prot);
 
     /* Since we're translating for debugging, the only error that is a
        hard error is no translation at all.  Otherwise, while a real cpu
@@ -431,7 +422,6 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
-    HPPATLBEntry *ent;
     int prot, excp, a_prot;
     hwaddr phys;
 
@@ -447,8 +437,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
         break;
     }
 
-    excp = hppa_get_physical_address(env, addr, mmu_idx,
-                                     a_prot, &phys, &prot, &ent);
+    excp = hppa_get_physical_address(env, addr, mmu_idx, a_prot, &phys, &prot);
     if (unlikely(excp >= 0)) {
         if (probe) {
             return false;
@@ -689,7 +678,7 @@ target_ulong HELPER(lpa)(CPUHPPAState *env, target_ulong addr)
     int prot, excp;
 
     excp = hppa_get_physical_address(env, addr, MMU_KERNEL_IDX, 0,
-                                     &phys, &prot, NULL);
+                                     &phys, &prot);
     if (excp >= 0) {
         if (excp == EXCP_DTLB_MISS) {
             excp = EXCP_NA_DTLB_MISS;
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index 66cad78a57..7f79196fff 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -334,8 +334,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
     }
 
     mmu_idx = PRIV_P_TO_MMU_IDX(level, env->psw & PSW_P);
-    excp = hppa_get_physical_address(env, addr, mmu_idx, 0, &phys,
-                                     &prot, NULL);
+    excp = hppa_get_physical_address(env, addr, mmu_idx, 0, &phys, &prot);
     if (excp >= 0) {
         cpu_restore_state(env_cpu(env), GETPC());
         hppa_set_ior_and_isr(env, addr, MMU_IDX_MMU_DISABLED(mmu_idx));
-- 
2.34.1


