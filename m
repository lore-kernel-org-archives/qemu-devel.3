Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E54AC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8i-0000xr-QZ; Wed, 15 May 2024 05:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8P-00076u-Q2
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:18 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8L-0001j2-S7
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34e7a35d5d4so5368804f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766072; x=1716370872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OHSKGAmjZyXyEy3oYnNkxuEn/tIxbChlR7lq6N97lGc=;
 b=nQS6kSogL8GxcT7uim8/nY5nOo88yNxSfSa+d4Hq9Uz4JYZSS+TmEUtKDA5Cf8JEvF
 9V2uIop7NTnhTlivnsnJqV+wbNnvdRh1FStkBbG/4+tPFDVrkQPhTG0H4uATn+TdE9u7
 jvVxDQKLL84jb97DQ74+mfuxdgjCqkGjVO8pZlL5l8/xfuSQKX258S9ZG2nCaHmX6Twn
 HOVmx/xOmGe3HdlXeV6qNfKHMeVEIDmJdI5UrLoinm9XJ/h1TwnlTsz8j2/+N7LeK6/V
 Rwx4QP9bGaDDKKd7IKYJlHE4GbKv2zo77zzX8vIleVt18Rik1szieNyb3A4Q3DPV4BNA
 6yJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766072; x=1716370872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OHSKGAmjZyXyEy3oYnNkxuEn/tIxbChlR7lq6N97lGc=;
 b=DTG8hLGKvYHVUdBSTGLHTNARRTR+PBPmJRu016HoFkGwigcv1/5JTOLZ6s84REdnys
 J5ltzvuhJ4s03yVbaSHFzlITWEKUdwDzBFSqhrArS/AfTiEobC/pd+9NG6TJQ5zFCJQJ
 Wq0ZaRaLOvS3EtRwK1uDa69E7Tn4cZosdw9wJKE8gjUVYkbx0yVWpPNUD/CpD7obX0B7
 XlAVaPWiUx+jvjVIp51dalVwQ96VNpGMq8Y2sBleZUc4NYXewQGRr6LSuLiITu7QtT1P
 zV/+OtGUZ4q4ym5JFQRDkZpGyP12fpA390JmAxqWKw9k5taBaSIY7zklLxx3OdsJbX2D
 K9bA==
X-Gm-Message-State: AOJu0YwedQZrh3IHGgEt2W3ZcRfRn1ZMIY54hfOZVfOzsRA4qEBnocaz
 GJmZeQuX3oWZgf279LjuJRth8X0FB79TVyD6mIiTk09eiiUwlgMN4/6mCj6mt0I89CMU7eG3y0g
 IvbQ=
X-Google-Smtp-Source: AGHT+IGBAw6QCPZ5yQ/Y+d0L82tcpB488gI62ljHsrLI90d+Gp2OLii2e0AsOqwk5F21YDS45D8ePA==
X-Received: by 2002:adf:ff8a:0:b0:34c:9a24:7a40 with SMTP id
 ffacd0b85a97d-3504a95826bmr9184046f8f.56.1715766072473; 
 Wed, 15 May 2024 02:41:12 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/43] target/hppa: Drop tlb_entry return from
 hppa_get_physical_address
Date: Wed, 15 May 2024 11:40:39 +0200
Message-Id: <20240515094043.82850-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


