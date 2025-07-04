Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3469EC83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjDs-00087N-J8; Fri, 04 Jul 2025 12:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDq-00086H-0l
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:10 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjDo-0005s2-3M
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:09 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso620463f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646305; x=1752251105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/2btOuqcn6Xe57qmXPDc5kx7Q5nom+ioP+Bpq02iGrQ=;
 b=xDZ+HFa63I12Gb8MHs3yC9l16B2eGJCY+ZSZndKyqqtaEJ/ynyWnOPFSBdgq76R0FV
 und5qW9Dz+VwODSalJosW0zvwLvFjnQ7ka/bhGvwYufDNxpJywmL/6kQoyVGVD4NHceb
 0o/wwo2A8USWL7TOJSFm18ZxC/85SOiuzMNhS9CxBskNGfmrktnuB/uA9oqbAIqvR9/j
 ELNW5TW4IRAzZAqv4Rx5otd6/4N9TOTnyPL03AfNO1M4YW3W4BxJeULeYfNI+zH2Z2b3
 KKYK7unkZcQo8xQ42hkfcI9WG67QRngzUdg9FtBZjn27AcefJBSoTMC6Gnj2Jq09gGRR
 CRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646305; x=1752251105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2btOuqcn6Xe57qmXPDc5kx7Q5nom+ioP+Bpq02iGrQ=;
 b=ZZQAoZUBzp6eEgsLD1VEuq7p4WS1+cqg3fGE0m3N7P7qljUaKx8DH6j/0oJ4Ac7Ges
 5kgkv0dkke7qx/IYQODB+PTu7ntXSLCyDHq8R/08A46GuYRHzWD3qExkFJe2MfNa+cCA
 K8rw4ouLvPQAtdcumLd8nxQLaK2UP3NUONloPPQ/w4wetVhhyrRJ0/mQEjVTmUvXS9r5
 FwJPEk11Swsw2L9Qe89hrQbAtj9Z87DtxhhSld3vxlgeTDRFgwNH5ahqnwM5ObmZylU9
 GYPCUhHeFRpZUxRgMvAcGVaiG0Tsm24BOCrHwm/7q8iyh/fpGNotXOUKNNj8686XH/O0
 acfg==
X-Gm-Message-State: AOJu0YzCCYleNsOcjOnHCvVJNKBCXKDgpcOQNQXRh0THdC1dGIC6cg5Y
 B/4T7jnso/aq7jhyj+c+cQjTAfdeGrxAibVi9c0rf6vlDSix2y02kP4X+Y8HRdXSfxkkuFnfsvY
 k1xx+
X-Gm-Gg: ASbGnctjZaH2Om5/ciRF/4qBjBnHtrEGVlBYxIVZrYWP7ga22iI0s2553YixfmkzsZN
 wsvGtlk7u+uEnfM/3bVb9R329nFehUPgL0qbOPdkG7RcB45V6xM64THkhnO185MswoyoyCrhsVo
 Pooe4bK3C62E0RGQBYkmt/GtbiCUmCNn3v2zQ6G4p9GSXVustHuxHPmyLINMGfjgWg/l5fL0uQL
 3Ti/yzDS4q6F7RH08PYthJk/yt80tGRabukQUXBfM2+unAbFjSbtSmKLkue1dWLFkcynpRXy7iV
 LoVhAL3OnSUpcMhaU3PnBvXbe32LcUrDgCMRwNDVa7yPSG91XnzCb8b2hrUtzoU66P+r
X-Google-Smtp-Source: AGHT+IFAIq254uDjtYhKdAJwPXJZF29XCpMFCPqByjsJDWuZVaQlXWL+Piy1MExqph81cwrU1B/FQA==
X-Received: by 2002:a5d:64cd:0:b0:3a5:39bb:3d61 with SMTP id
 ffacd0b85a97d-3b4964f1dfcmr2811134f8f.27.1751646305277; 
 Fri, 04 Jul 2025 09:25:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 002/119] target/arm: Bring VLSTM/VLLDM helper store/load closer
 to the ARM pseudocode
Date: Fri,  4 Jul 2025 17:23:02 +0100
Message-ID: <20250704162501.249138-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: William Kosasih <kosasihwilliam4@gmail.com>

This patch brings the VLSTM and VLLDM helper functions closer to the ARM
pseudocode by adding MO_ALIGN to the MemOpIdx of the associated store
(`cpu_stl_mmu`) operations and load (`cpu_ldl_mmu`) operations.

Note that this is not a bug fix: an 8-byte alignment check already exists
and remains in place, enforcing stricter alignment than the 4 bytes
requirement in the individual loads and stores. This change merely makes the
helper implementations closer to the ARM pseudocode.

That said, as a side effect, the MMU index is now resolved once instead of
on every `cpu_*_data_ra` call, reducing redundant lookups

Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250703085604.154449-2-kosasihwilliam4@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/m_helper.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 6614719832e..251e12edf9c 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -1048,6 +1048,9 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
     bool s = env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_S_MASK;
     bool lspact = env->v7m.fpccr[s] & R_V7M_FPCCR_LSPACT_MASK;
     uintptr_t ra = GETPC();
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
+                                 arm_to_core_mmu_idx(mmu_idx));
 
     assert(env->v7m.secure);
 
@@ -1073,7 +1076,7 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
      * Note that we do not use v7m_stack_write() here, because the
      * accesses should not set the FSR bits for stacking errors if they
      * fail. (In pseudocode terms, they are AccType_NORMAL, not AccType_STACK
-     * or AccType_LAZYFP). Faults in cpu_stl_data_ra() will throw exceptions
+     * or AccType_LAZYFP). Faults in cpu_stl_mmu() will throw exceptions
      * and longjmp out.
      */
     if (!(env->v7m.fpccr[M_REG_S] & R_V7M_FPCCR_LSPEN_MASK)) {
@@ -1089,12 +1092,12 @@ void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
             if (i >= 16) {
                 faddr += 8; /* skip the slot for the FPSCR */
             }
-            cpu_stl_data_ra(env, faddr, slo, ra);
-            cpu_stl_data_ra(env, faddr + 4, shi, ra);
+            cpu_stl_mmu(env, faddr, slo, oi, ra);
+            cpu_stl_mmu(env, faddr + 4, shi, oi, ra);
         }
-        cpu_stl_data_ra(env, fptr + 0x40, vfp_get_fpscr(env), ra);
+        cpu_stl_mmu(env, fptr + 0x40, vfp_get_fpscr(env), oi, ra);
         if (cpu_isar_feature(aa32_mve, cpu)) {
-            cpu_stl_data_ra(env, fptr + 0x44, env->v7m.vpr, ra);
+            cpu_stl_mmu(env, fptr + 0x44, env->v7m.vpr, oi, ra);
         }
 
         /*
@@ -1121,6 +1124,9 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
 {
     ARMCPU *cpu = env_archcpu(env);
     uintptr_t ra = GETPC();
+    ARMMMUIdx mmu_idx = arm_mmu_idx(env);
+    MemOpIdx oi = make_memop_idx(MO_TEUL | MO_ALIGN,
+                                 arm_to_core_mmu_idx(mmu_idx));
 
     /* fptr is the value of Rn, the frame pointer we load the FP regs from */
     assert(env->v7m.secure);
@@ -1155,16 +1161,16 @@ void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
                 faddr += 8; /* skip the slot for the FPSCR and VPR */
             }
 
-            slo = cpu_ldl_data_ra(env, faddr, ra);
-            shi = cpu_ldl_data_ra(env, faddr + 4, ra);
+            slo = cpu_ldl_mmu(env, faddr, oi, ra);
+            shi = cpu_ldl_mmu(env, faddr + 4, oi, ra);
 
             dn = (uint64_t) shi << 32 | slo;
             *aa32_vfp_dreg(env, i / 2) = dn;
         }
-        fpscr = cpu_ldl_data_ra(env, fptr + 0x40, ra);
+        fpscr = cpu_ldl_mmu(env, fptr + 0x40, oi, ra);
         vfp_set_fpscr(env, fpscr);
         if (cpu_isar_feature(aa32_mve, cpu)) {
-            env->v7m.vpr = cpu_ldl_data_ra(env, fptr + 0x44, ra);
+            env->v7m.vpr = cpu_ldl_mmu(env, fptr + 0x44, oi, ra);
         }
     }
 
-- 
2.43.0


