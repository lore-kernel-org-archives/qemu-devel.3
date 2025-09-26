Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA79CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v299M-0008VN-Kf; Fri, 26 Sep 2025 10:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298b-0007Va-DC
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298J-0005hF-UX
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:28 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ef166e625aso1770496f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895748; x=1759500548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ac+vPHnmSmWn/IxoBIfyBDlq78Nxe9jC0NcbXHPpJtQ=;
 b=zYwu8vRIVyBoJHCJ+3NOXswLHSvW//AwiLT6qHz97+p+y2pEs4EMlCiWgUPDRkCQv0
 j4uzDvmRPSoioYS8gjJKSXRxEHXBEEMbNh1Mh3eOm4SM3l+RH2UovT/yTTIhNXAJz+PF
 s8sF0z1/TC6TroPpLIlHQ4fyfynoXiwq160t5YlSioH8Hdf/9uc5pSGg6AqDokNETZ1x
 f0p9ncVNf/ULAdodFYedkrAYh942OMWQkCspuUOtmcs0b2x5obzqEE6iRJHDbIjImhmf
 qWJlaurkrrB6TWW01Ty73Szfw3DDhJIBHXWSci/EHfHkYdWHeJk9JsLavY8kyrx0RbiT
 wHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895748; x=1759500548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ac+vPHnmSmWn/IxoBIfyBDlq78Nxe9jC0NcbXHPpJtQ=;
 b=jrIccUTvtSP2UYR6FAg75c1sYeMT2oQ32vxDP0f43ahH6Rxci5yds6y/kDU9UTfZY1
 it0lLm/PNAe3K1A2sDz4ZfZNoGPvV9Rm9hjyFKwJfpmlX4W8wNJXCAg4KYCPBmmW9M1D
 AJORnLRhvWMEz4QlkxL6m3qgXeoILhlTkamaOmRUvUnduwNI4M9FupQFeSgm0EgRF5BS
 fSpGIkuX8cJC5QonGllsxe2jd7qAXE8j36w3sDXbocsluNhKLtUw08DRx0E0dYNPbF0L
 Esd7/01czGJvHUAKX6JYeebGtAZ2RWO3Jc1rYYWxmv0JR30WgERJwJFLaH99vsMmBH3b
 ygRw==
X-Gm-Message-State: AOJu0YzExNzPSj3mXqi4r6/leRL3KAYe0rOkWJLI8wVNCVLFR3GuVLBM
 GjDQRx4+5MVllGMqO8oat7NNmV3czb2kgaoSUtZkPqogc1tHwQEl4Tbu7opxQXKzL03bOKtJm0I
 UugUC
X-Gm-Gg: ASbGncsvYokKFaPzocja1dd2oFqK0gAOq3GeAYHTp5E7/zdHfCNHWwJMIfhimJI2AtW
 Lh09l/38PEA9ZP+KUpt8q61d/bkb5YH4OyEqZf3bPp9FvUSOeldq1EJxJljIyclxQ67TyDwbwJ6
 aGmVEeBKITtHaUKZlXDSPPSesHqHkk/OZwUsugrLD3pxBxNklcTEcc5d+0EzbQo/heyXTc0Wm9M
 Ph5889k/9IDe9xRkwQQvHgP8/LX02jm2y9xgP4q1I9Kr5JVMcuN0DsuohCc3W3vFaj/QmFeBLDW
 LL00/m2ns6b6XfdWS2fj67m8VMVIYLrrLwwoCNKv+PKPr72aEJ/ij/DaMH7oWq9P7ipXNulbPf5
 Sg6c2+ZHlrtMTnFz0HqJVgBUu5MwOlaU5ZQRGXLk=
X-Google-Smtp-Source: AGHT+IHaOlixirQlGQlkTisFlOoNa69774RNkNBSrMr64y4HFAg+T9zxZ58fM3RjGMxWUhkopHsELg==
X-Received: by 2002:a5d:5d0b:0:b0:3ec:db87:fff7 with SMTP id
 ffacd0b85a97d-40e4a9ee4aemr6563121f8f.26.1758895747606; 
 Fri, 26 Sep 2025 07:09:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/44] target/arm: Remove cp argument to ENCODE_AA64_CP_REG
Date: Fri, 26 Sep 2025 15:08:20 +0100
Message-ID: <20250926140844.1493020-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

All invocations were required to pass the same value,
CP_REG_ARM64_SYSREG_CP.  Bake that in to the result directly.
Remove CP_REG_ARM64_SYSREG_CP as unused.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h            |  5 ++---
 target/arm/kvm-consts.h        |  3 ---
 target/arm/helper.c            | 11 +++++------
 target/arm/hvf/hvf.c           |  3 +--
 target/arm/tcg/translate-a64.c |  6 ++----
 5 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 417d79f7ba6..a10abadb932 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -187,9 +187,8 @@ enum {
      ((is64) << CP_REG_AA32_64BIT_SHIFT) |                  \
      ((cp) << 16) | ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
 
-#define ENCODE_AA64_CP_REG(cp, crn, crm, op0, op1, op2) \
-    (CP_REG_AA64_MASK |                                 \
-     ((cp) << CP_REG_ARM_COPROC_SHIFT) |                \
+#define ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2) \
+    (CP_REG_AA64_MASK | CP_REG_ARM64_SYSREG |           \
      ((op0) << CP_REG_ARM64_SYSREG_OP0_SHIFT) |         \
      ((op1) << CP_REG_ARM64_SYSREG_OP1_SHIFT) |         \
      ((crn) << CP_REG_ARM64_SYSREG_CRN_SHIFT) |         \
diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index fdb305eea1a..54ae5da7ce3 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -160,9 +160,6 @@ MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_CORTEX_A53, KVM_ARM_TARGET_CORTEX_A53);
 #define CP_REG_ARM64_SYSREG_OP2_MASK   0x0000000000000007
 #define CP_REG_ARM64_SYSREG_OP2_SHIFT  0
 
-/* No kernel define but it's useful to QEMU */
-#define CP_REG_ARM64_SYSREG_CP (CP_REG_ARM64_SYSREG >> CP_REG_ARM_COPROC_SHIFT)
-
 MISMATCH_CHECK(CP_REG_ARM64, KVM_REG_ARM64);
 MISMATCH_CHECK(CP_REG_ARM_COPROC_MASK, KVM_REG_ARM_COPROC_MASK);
 MISMATCH_CHECK(CP_REG_ARM_COPROC_SHIFT, KVM_REG_ARM_COPROC_SHIFT);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27d5ab82920..2732112ff21 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4503,7 +4503,7 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
     };
 
 #define K(op0, op1, crn, crm, op2) \
-    ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2)
+    ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2)
 
     static const struct E2HAlias aliases[] = {
         { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
@@ -7396,10 +7396,9 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
          * in their AArch64 view (the .cp value may be non-zero for the
          * benefit of the AArch32 view).
          */
-        if (cp == 0 || r->state == ARM_CP_STATE_BOTH) {
-            cp = CP_REG_ARM64_SYSREG_CP;
-        }
-        key = ENCODE_AA64_CP_REG(cp, r->crn, crm, r->opc0, opc1, opc2);
+        assert(cp == 0 || r->state == ARM_CP_STATE_BOTH);
+        cp = 0;
+        key = ENCODE_AA64_CP_REG(r->crn, crm, r->opc0, opc1, opc2);
         break;
     default:
         g_assert_not_reached();
@@ -7624,7 +7623,7 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
         }
         break;
     case ARM_CP_STATE_AA64:
-        assert(r->cp == 0 || r->cp == CP_REG_ARM64_SYSREG_CP);
+        assert(r->cp == 0);
         break;
     default:
         g_assert_not_reached();
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 694584cc130..6e67d89163f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1124,8 +1124,7 @@ static bool is_id_sysreg(uint32_t reg)
 
 static uint32_t hvf_reg2cp_reg(uint32_t reg)
 {
-    return ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP,
-                              (reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
+    return ENCODE_AA64_CP_REG((reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
                               (reg >> SYSREG_CRM_SHIFT) & SYSREG_CRM_MASK,
                               (reg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK,
                               (reg >> SYSREG_OP1_SHIFT) & SYSREG_OP1_MASK,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 37bedc3780b..a560ef0f42c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2466,8 +2466,7 @@ static void handle_sys(DisasContext *s, bool isread,
                        unsigned int op0, unsigned int op1, unsigned int op2,
                        unsigned int crn, unsigned int crm, unsigned int rt)
 {
-    uint32_t key = ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP,
-                                      crn, crm, op0, op1, op2);
+    uint32_t key = ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2);
     const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
     bool need_exit_tb = false;
     bool nv_trap_to_el2 = false;
@@ -2603,8 +2602,7 @@ static void handle_sys(DisasContext *s, bool isread,
          * We don't use the EL1 register's access function, and
          * fine-grained-traps on EL1 also do not apply here.
          */
-        key = ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP,
-                                 crn, crm, op0, 0, op2);
+        key = ENCODE_AA64_CP_REG(crn, crm, op0, 0, op2);
         ri = get_arm_cp_reginfo(s->cp_regs, key);
         assert(ri);
         assert(cp_access_ok(s->current_el, ri, isread));
-- 
2.43.0


