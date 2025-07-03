Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AB9C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFk4-0002Qg-1p; Thu, 03 Jul 2025 04:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFk2-0002Pr-OE; Thu, 03 Jul 2025 04:56:26 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uXFjz-0007vZ-MM; Thu, 03 Jul 2025 04:56:25 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so8294382b3a.0; 
 Thu, 03 Jul 2025 01:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751532977; x=1752137777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ue+TRUQ4zOoNWn0fMMKkbL+MC+6NF+Rulh2d0yliDEM=;
 b=jpMp1D/Wig4EyvWL6yRCrUJtN3wlInjAEHR8LlR04TV835qDlKFtA+0xiFhFZBvjjl
 WIstFs+KjpGlE3Ri8CkZ46towjw3ZTKp+B9AfHTlVr1P9jFQOfKBMwADHCtJmhsGKUL6
 T5RpSlte5SKwWgkfFnQRpS5Nlq0i1SUCHnwrVuGr6/nVg9EEvPpP4zllCSeISKWOvqz/
 jHLyeqvqAQ3DSzCvO92A4OcD2dCaVpzhd7KBleZiY17hnxBJIdv/g+noxeSibsffYg7/
 gi5WRH9e0evnyYoBY2KIK1X43C1GbZSY4SkN+v2IsmFAvNb3kpblUXAedhE8qEIFWx5c
 zX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751532977; x=1752137777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ue+TRUQ4zOoNWn0fMMKkbL+MC+6NF+Rulh2d0yliDEM=;
 b=NrxlHOmnO+RViRlr69lG3hhNduO/q4/8bayhefQL8eVLpBAESoL8WMrOgl3ezFyj0Y
 T7Zqfbx6ECz82Wwrjw4FErrHqvZJFUcuC5Vgvs9/AFm7Bl9yn5HbbhFtw8fzj3pOqow8
 OPo8aoBJTODKcrgD5/sSBda38rcUgE+pY4SFMsGg6cpCl48SYsg/UiX4VxgLLqTjnYZ1
 vZrGdCp7T9GOdgXRHRqcLOztfsF+986T4cyNN2pHeFcl92ya7mVkbT/fR2QfxUgLEJRk
 rjx10nOEEDi15Wb+d8rta34BYQbGoEz6KPWED68GxSdSYZcPg7SsOB+lCPh818YOvXb9
 WFXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqjMquyVXm+sSVKxht5vw3AOaVyf4AFhH1/oXBF7MJEu4EuGIc905RkL11uggPlMKqBzbfugVZsA==@nongnu.org
X-Gm-Message-State: AOJu0YwRQuZm/F2OhvzZKa26T1U/NokKn3LK0HGnZRlE+HtWWDv+KaXA
 csu487kbVMW43meENrfyTqHhCrZFKrS360RCc+Uw7dckSVxK6fJ8jNCnhdeTOPh0E7I=
X-Gm-Gg: ASbGncvW1YyRWGEfy5dxmptUaWuaNcCcFpB4n/b40pdJFp8rK7rW7TcNBih8ChleRx9
 nYW70AccRojawAoAJm2Oio2MuesN8kmd0+W6aupOAaUT//J8/cKUMgqBU02U2ZWHGD9BV43A3P/
 Kl33UXlPYRI6ueeL5JF5OJGL0tKWnZg8CiLonuePt368RTNwglH2QeIxMLSTRoQ7O1XzfqS+egC
 j+nDpMGcvVdLFrZ4kMtlLzTzpX0z4bEigkfmMCVDUVFIB7lS/xzHuMGWsCh5H/lGuIntswEiMzM
 v60ApLrsuCZe+jVdzkJVrzBjOb2wlCtL5z1taTTD5K2r3UuLrJxCaRhjBK7XweoKcGvaF4f/A9y
 SSYmPioBWqFwdjtgINcEw4Mv/7byrCCcPAzLW0AuM5OI=
X-Google-Smtp-Source: AGHT+IGxmGehSByD6+KCQPrmX1GUgbnZQPJXWMID+loawjcZBI7PJhntn5KOq7bdgxnNXIEDfE6/IA==
X-Received: by 2002:aa7:8881:0:b0:748:2fa4:14c0 with SMTP id
 d2e1a72fcca58-74b50c84cb2mr8726323b3a.0.1751532977206; 
 Thu, 03 Jul 2025 01:56:17 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-74af557b3bcsm16409931b3a.101.2025.07.03.01.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 01:56:16 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v4 01/11] target/arm: Bring VLSTM/VLLDM helper store/load
 closer to the ARM pseudocode
Date: Thu,  3 Jul 2025 18:25:54 +0930
Message-ID: <20250703085604.154449-2-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
References: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
---
 target/arm/tcg/m_helper.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 6614719832..251e12edf9 100644
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
2.48.1


