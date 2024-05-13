Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A3AC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 07:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6QRA-0006CF-1p; Mon, 13 May 2024 03:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPY-00031I-RE
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s6QPW-0001SZ-K0
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:47:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41fd5dc04e2so23281425e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 00:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715586468; x=1716191268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+T+i0JeoH/+z/Q00QyoJ5KqjEw3NPpVieDyHAHvdI0=;
 b=RJ5JCPR1LD1NKCet6+/HkbaJySVGbThdVXkHYhldLdGkpa72paRg3drQk/Ity0CxBX
 zbCjvUlxgzXvVGRcGfpm1UmlQbkkIH/8WpOtnofFcvnGc2RGtoJl/UegHsWVzfq04D6Q
 Yfh198rlroBR5eoIrtcaMRmnKDOTT1CHBvHuTn9qPG+vPKP3qYXcLZn2fgWne7RwRQOt
 lHbr1B0MJKB7xQSCwVeZ8AdQysYK8I+7NLNbi079trNClYsznL1gxmROKNmQLghappOk
 oa/G1GUXIlimp116JLfmUv6t4o/A6yGhNV6mdTco5Ri53X8FY0ri/7ipvxIBHVEDgKjv
 shMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715586468; x=1716191268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+T+i0JeoH/+z/Q00QyoJ5KqjEw3NPpVieDyHAHvdI0=;
 b=hdLjPAuyLjZEhYiBPzwCx3fI1ue1BZZxNhbzAbO/mOF/FC7ugcscKNDkyHoix3Kq0Y
 zvruHjRj511cE9KRUufxuVED1mGdjrefyzeFweZSJsjnNCqQfBWMxBJVAPI627LCL3hp
 rZVPDR9Dw90ZPRstNMsdW4IfnlEliy8U5zgSAmhp+qc+9v4qmxazd3MRF7SUxuQOtkfz
 GqefMscCuoyK3LNsBum+Xbvc6A912RIQZnXNWcRUkE02Vx5r20Yxpyb58INc202Poiep
 Y/9c20pVKYBETI3wJnNvTQ/HfgU3G6V1oSN2uxoOgaYyHe5txWxihzi+IG1e/he/8R7F
 lW1g==
X-Gm-Message-State: AOJu0YzIlxagkZLV7zdfDayBJPaUOd3H8KPg3pd7kLoq7neyM8KNz/HY
 2TBtB5EBrVOR24/tRa+X+j6xxcePKX7OlG611frBqegrYURK9I0ivi9oZupSClMS3ySXGAMsfrm
 kE2k=
X-Google-Smtp-Source: AGHT+IGjl9THWT+EE7rQ66JDEB7ft8LVAd3kP2LM3OZPZQfmTT4SiY9xTResQ/NFutrRc1FeFGhJGg==
X-Received: by 2002:a05:600c:3caa:b0:41b:55b1:6cfc with SMTP id
 5b1f17b1804b1-41feaa2f3a3mr59783265e9.1.1715586468213; 
 Mon, 13 May 2024 00:47:48 -0700 (PDT)
Received: from stoup.. (12.red-213-97-13.staticip.rima-tde.net. [213.97.13.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9318sm148204765e9.30.2024.05.13.00.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 00:47:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 39/45] target/hppa: Drop tlb_entry return from
 hppa_get_physical_address
Date: Mon, 13 May 2024 09:47:11 +0200
Message-Id: <20240513074717.130949-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513074717.130949-1-richard.henderson@linaro.org>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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
index f247ad56d7..78ab0adcd0 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -371,8 +371,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
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
index ca7bbe0a7c..2929226874 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -197,18 +197,13 @@ static int match_prot_id64(CPUHPPAState *env, uint32_t access_id)
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
@@ -238,10 +233,6 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         goto egress;
     }
 
-    if (tlb_entry) {
-        *tlb_entry = ent;
-    }
-
     /* We now know the physical address.  */
     phys = ent->pa + (addr - ent->itree.start);
 
@@ -350,7 +341,7 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
                cpu->env.psw & PSW_W ? MMU_ABS_W_IDX : MMU_ABS_IDX);
 
     excp = hppa_get_physical_address(&cpu->env, addr, mmu_idx, 0,
-                                     &phys, &prot, NULL);
+                                     &phys, &prot);
 
     /* Since we're translating for debugging, the only error that is a
        hard error is no translation at all.  Otherwise, while a real cpu
@@ -432,7 +423,6 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
-    HPPATLBEntry *ent;
     int prot, excp, a_prot;
     hwaddr phys;
 
@@ -448,8 +438,7 @@ bool hppa_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
         break;
     }
 
-    excp = hppa_get_physical_address(env, addr, mmu_idx,
-                                     a_prot, &phys, &prot, &ent);
+    excp = hppa_get_physical_address(env, addr, mmu_idx, a_prot, &phys, &prot);
     if (unlikely(excp >= 0)) {
         if (probe) {
             return false;
@@ -690,7 +679,7 @@ target_ulong HELPER(lpa)(CPUHPPAState *env, target_ulong addr)
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


