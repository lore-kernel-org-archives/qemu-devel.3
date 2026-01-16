Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943F2D4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgag6-00051e-R5; Thu, 15 Jan 2026 22:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgafo-0004wT-Qp
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:38:57 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgafl-0008Ey-Ur
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:38:55 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a09a3bd9c5so11449185ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534732; x=1769139532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85REHlkWJDtWsilQDfbxqyO96MGCDiDn4G3cKbUWWrA=;
 b=yBLJ+y7+hSv/RNO0+L4Jk9+NS2bgnSLV8VjDgLnL2YCWxV2Usl/tBrqX/D82FlXH/m
 Th8V5hGeSToDjCnZAU+WLbE88+fiPaJES0VAV2vRDiCtfODmx7RYa26PcNOKjAfAFF7X
 ZB9kOnmVTgSw+uSUxRAeeG7rdewLju34mm3x2/sh92tNosxXw3qfmS1vp5jXYjK3DI78
 qsZfEoO3vc39zS4Iez4Cns/Uwul8wVcKmFr6ultXokHdFcSq38PIn9N19Nnp7LIAvBc/
 LKqMs2ikDM+FvnJLDq2rhfX4DMjwaQpUT3vuQuTTGXeCKyh1vJ3VSU/ZXMrdvBjFGJXG
 EwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534732; x=1769139532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=85REHlkWJDtWsilQDfbxqyO96MGCDiDn4G3cKbUWWrA=;
 b=KZScFrWMaFv5kaKYdBhwO5zmLjHakXN7BDex9l/Ow61w19pXJEhWbe3w2o9KQgc9QC
 Rg686qeJL667x56I901wCzhBfh5PRyl2Q+NyKlBhzRGEUSdajku0FrcSo66b1SX/Q6AV
 DdNqAq8PCX0OP00+9K3aToN+NRQGzfphjPU7D+8BATNiMeJqOsOAPaTb4n1iXlSvN2d7
 gu4Y2XBYO+0kBQEb981B1H4JZE/sajpznEcnK7czoDQoFsZZ8bianfrQK0uVl3ey5iHO
 iLpORt6WGYryw3sv6fdXjYmf2hfSkJOC4I8+fwrY85P153hXTkeyj7UhnVMPe+Jrh5p8
 uRDg==
X-Gm-Message-State: AOJu0YyAI1ccs79R10IEw5qHe32wlDSd86Csz1eYvYcOFUXUUUPzqOi7
 yrgEPbPMAwveXySvPUw9UL9thyrk33ZxbGQWhweshwLpwvpuODN/5/a/cT6Eqw51dvPChLN982c
 ZysQhX+mZLw==
X-Gm-Gg: AY/fxX6paFcXYiyAiCa0cESpLoE00p0fKArQJbdgONrkuPY1Siq2e4vV3QKkjE483HK
 HxdPctfILmhtl97RVmj/e8y8bfVhGxA27k0a3Nsr18ouldXS9I1E6r1otrWU8xCesXe90p1vsjR
 QyTavySS2BBEKchuUVeqOndH7KW4LA+aVK1e/MM41kZEnkG4Yn298PAYPlo2bzjSpDZAg/XNURI
 oRVOXOrZqivqKwyL9hrTa2Iq1Eyej2hant5M766o4eORO+yKL4cVae0DXN3F8odz9frcxAkmfYS
 UJ5miZEb4/B3CJoBPcrrQxhUPe58ZclDNLCfUod93rJXKsC2x3m0YmgIyvu3e61EaFmdVHjs4Xy
 lriQJVLABP/KA88y9kxZf53Ijit14yJL0Rork5IRQ7nMhBmyG149pbhPFkD+7X14nk5E6SdQ4f2
 Hwo58TJEHyHlGQg+Ks+Q==
X-Received: by 2002:a17:903:2443:b0:2a0:c35c:572e with SMTP id
 d9443c01a7336-2a7188f91c2mr17216255ad.30.1768534732404; 
 Thu, 15 Jan 2026 19:38:52 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:38:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 40/58] target/riscv: Drop TCG_TARGET_REG_BITS test
Date: Fri, 16 Jan 2026 14:32:46 +1100
Message-ID: <20260116033305.51162-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 54 ++++++-------------------
 1 file changed, 13 insertions(+), 41 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index caefd38216..4df9a40b44 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1181,60 +1181,32 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
      * Update vstart with the number of processed elements.
      * Use the helper function if either:
      * - vstart is not 0.
-     * - the target has 32 bit registers and we are loading/storing 64 bit long
-     *   elements. This is to ensure that we process every element with a single
-     *   memory instruction.
      */
 
-    bool use_helper_fn = !(s->vstart_eq_zero) ||
-                          (TCG_TARGET_REG_BITS == 32 && log2_esz == 3);
+    bool use_helper_fn = !s->vstart_eq_zero;
 
     if (!use_helper_fn) {
-        TCGv addr = tcg_temp_new();
         uint32_t size = s->cfg_ptr->vlenb * nf;
         TCGv_i64 t8 = tcg_temp_new_i64();
-        TCGv_i32 t4 = tcg_temp_new_i32();
         MemOp atomicity = MO_ATOM_NONE;
         if (log2_esz == 0) {
             atomicity = MO_ATOM_NONE;
         } else {
             atomicity = MO_ATOM_IFALIGN_PAIR;
         }
-        if (TCG_TARGET_REG_BITS == 64) {
-            for (int i = 0; i < size; i += 8) {
-                addr = get_address(s, rs1, i);
-                if (is_load) {
-                    tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx,
-                            MO_LE | MO_64 | atomicity);
-                    tcg_gen_st_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
-                } else {
-                    tcg_gen_ld_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
-                    tcg_gen_qemu_st_i64(t8, addr, s->mem_idx,
-                            MO_LE | MO_64 | atomicity);
-                }
-                if (i == size - 8) {
-                    tcg_gen_movi_tl(cpu_vstart, 0);
-                } else {
-                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 8 >> log2_esz);
-                }
+        for (int i = 0; i < size; i += 8) {
+            TCGv addr = get_address(s, rs1, i);
+            if (is_load) {
+                tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx, MO_LEUQ | atomicity);
+                tcg_gen_st_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
+            } else {
+                tcg_gen_ld_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
+                tcg_gen_qemu_st_i64(t8, addr, s->mem_idx, MO_LEUQ | atomicity);
             }
-        } else {
-            for (int i = 0; i < size; i += 4) {
-                addr = get_address(s, rs1, i);
-                if (is_load) {
-                    tcg_gen_qemu_ld_i32(t4, addr, s->mem_idx,
-                            MO_LE | MO_32 | atomicity);
-                    tcg_gen_st_i32(t4, tcg_env, vreg_ofs(s, vd) + i);
-                } else {
-                    tcg_gen_ld_i32(t4, tcg_env, vreg_ofs(s, vd) + i);
-                    tcg_gen_qemu_st_i32(t4, addr, s->mem_idx,
-                            MO_LE | MO_32 | atomicity);
-                }
-                if (i == size - 4) {
-                    tcg_gen_movi_tl(cpu_vstart, 0);
-                } else {
-                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 4 >> log2_esz);
-                }
+            if (i == size - 8) {
+                tcg_gen_movi_tl(cpu_vstart, 0);
+            } else {
+                tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 8 >> log2_esz);
             }
         }
     } else {
-- 
2.43.0


