Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F62CD1299
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQlO-0004n1-FI; Wed, 10 Apr 2024 01:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQlM-0004lZ-6h; Wed, 10 Apr 2024 01:44:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQl7-0001BF-6b; Wed, 10 Apr 2024 01:44:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BBF545D4DB;
 Wed, 10 Apr 2024 08:46:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7FE15B0142;
 Wed, 10 Apr 2024 08:44:16 +0300 (MSK)
Received: (nullmailer pid 4182009 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhuojia Shen <chaosdefinition@hotmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 03/41] target/arm: align exposed ID registers with
 Linux
Date: Wed, 10 Apr 2024 08:43:24 +0300
Message-Id: <20240410054416.4181891-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
References: <qemu-stable-7.2.11-20240410084037@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: Zhuojia Shen <chaosdefinition@hotmail.com>

In CPUID registers exposed to userspace, some registers were missing
and some fields were not exposed.  This patch aligns exposed ID
registers and their fields with what the upstream kernel currently
exposes.

Specifically, the following new ID registers/fields are exposed to
userspace:

ID_AA64PFR1_EL1.BT:       bits 3-0
ID_AA64PFR1_EL1.MTE:      bits 11-8
ID_AA64PFR1_EL1.SME:      bits 27-24

ID_AA64ZFR0_EL1.SVEver:   bits 3-0
ID_AA64ZFR0_EL1.AES:      bits 7-4
ID_AA64ZFR0_EL1.BitPerm:  bits 19-16
ID_AA64ZFR0_EL1.BF16:     bits 23-20
ID_AA64ZFR0_EL1.SHA3:     bits 35-32
ID_AA64ZFR0_EL1.SM4:      bits 43-40
ID_AA64ZFR0_EL1.I8MM:     bits 47-44
ID_AA64ZFR0_EL1.F32MM:    bits 55-52
ID_AA64ZFR0_EL1.F64MM:    bits 59-56

ID_AA64SMFR0_EL1.F32F32:  bit 32
ID_AA64SMFR0_EL1.B16F32:  bit 34
ID_AA64SMFR0_EL1.F16F32:  bit 35
ID_AA64SMFR0_EL1.I8I32:   bits 39-36
ID_AA64SMFR0_EL1.F64F64:  bit 48
ID_AA64SMFR0_EL1.I16I64:  bits 55-52
ID_AA64SMFR0_EL1.FA64:    bit 63

ID_AA64MMFR0_EL1.ECV:     bits 63-60

ID_AA64MMFR1_EL1.AFP:     bits 47-44

ID_AA64MMFR2_EL1.AT:      bits 35-32

ID_AA64ISAR0_EL1.RNDR:    bits 63-60

ID_AA64ISAR1_EL1.FRINTTS: bits 35-32
ID_AA64ISAR1_EL1.BF16:    bits 47-44
ID_AA64ISAR1_EL1.DGH:     bits 51-48
ID_AA64ISAR1_EL1.I8MM:    bits 55-52

ID_AA64ISAR2_EL1.WFxT:    bits 3-0
ID_AA64ISAR2_EL1.RPRES:   bits 7-4
ID_AA64ISAR2_EL1.GPA3:    bits 11-8
ID_AA64ISAR2_EL1.APA3:    bits 15-12

The code is also refactored to use symbolic names for ID register fields
for better readability and maintainability.

The test case in tests/tcg/aarch64/sysregs.c is also updated to match
the intended behavior.

Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
Message-id: DS7PR12MB6309FB585E10772928F14271ACE79@DS7PR12MB6309.namprd12.prod.outlook.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: use Sn_n_Cn_Cn_n syntax to work with older assemblers
that don't recognize id_aa64isar2_el1 and id_aa64mmfr2_el1]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit bc6bd20ee3538347afb750c4bd06edca4a922897)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: pick this for v8.0.0-2361-g1f51573f79
 "target/arm: Fix SME full tile indexing")

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2e284e048c..acc0470e86 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7852,31 +7852,89 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 #ifdef CONFIG_USER_ONLY
         static const ARMCPRegUserSpaceInfo v8_user_idregs[] = {
             { .name = "ID_AA64PFR0_EL1",
-              .exported_bits = 0x000f000f00ff0000,
-              .fixed_bits    = 0x0000000000000011 },
+              .exported_bits = R_ID_AA64PFR0_FP_MASK |
+                               R_ID_AA64PFR0_ADVSIMD_MASK |
+                               R_ID_AA64PFR0_SVE_MASK |
+                               R_ID_AA64PFR0_DIT_MASK,
+              .fixed_bits = (0x1u << R_ID_AA64PFR0_EL0_SHIFT) |
+                            (0x1u << R_ID_AA64PFR0_EL1_SHIFT) },
             { .name = "ID_AA64PFR1_EL1",
-              .exported_bits = 0x00000000000000f0 },
+              .exported_bits = R_ID_AA64PFR1_BT_MASK |
+                               R_ID_AA64PFR1_SSBS_MASK |
+                               R_ID_AA64PFR1_MTE_MASK |
+                               R_ID_AA64PFR1_SME_MASK },
             { .name = "ID_AA64PFR*_EL1_RESERVED",
-              .is_glob = true                     },
-            { .name = "ID_AA64ZFR0_EL1"           },
+              .is_glob = true },
+            { .name = "ID_AA64ZFR0_EL1",
+              .exported_bits = R_ID_AA64ZFR0_SVEVER_MASK |
+                               R_ID_AA64ZFR0_AES_MASK |
+                               R_ID_AA64ZFR0_BITPERM_MASK |
+                               R_ID_AA64ZFR0_BFLOAT16_MASK |
+                               R_ID_AA64ZFR0_SHA3_MASK |
+                               R_ID_AA64ZFR0_SM4_MASK |
+                               R_ID_AA64ZFR0_I8MM_MASK |
+                               R_ID_AA64ZFR0_F32MM_MASK |
+                               R_ID_AA64ZFR0_F64MM_MASK },
+            { .name = "ID_AA64SMFR0_EL1",
+              .exported_bits = R_ID_AA64SMFR0_F32F32_MASK |
+                               R_ID_AA64SMFR0_B16F32_MASK |
+                               R_ID_AA64SMFR0_F16F32_MASK |
+                               R_ID_AA64SMFR0_I8I32_MASK |
+                               R_ID_AA64SMFR0_F64F64_MASK |
+                               R_ID_AA64SMFR0_I16I64_MASK |
+                               R_ID_AA64SMFR0_FA64_MASK },
             { .name = "ID_AA64MMFR0_EL1",
-              .fixed_bits    = 0x00000000ff000000 },
-            { .name = "ID_AA64MMFR1_EL1"          },
+              .exported_bits = R_ID_AA64MMFR0_ECV_MASK,
+              .fixed_bits = (0xfu << R_ID_AA64MMFR0_TGRAN64_SHIFT) |
+                            (0xfu << R_ID_AA64MMFR0_TGRAN4_SHIFT) },
+            { .name = "ID_AA64MMFR1_EL1",
+              .exported_bits = R_ID_AA64MMFR1_AFP_MASK },
+            { .name = "ID_AA64MMFR2_EL1",
+              .exported_bits = R_ID_AA64MMFR2_AT_MASK },
             { .name = "ID_AA64MMFR*_EL1_RESERVED",
-              .is_glob = true                     },
+              .is_glob = true },
             { .name = "ID_AA64DFR0_EL1",
-              .fixed_bits    = 0x0000000000000006 },
-            { .name = "ID_AA64DFR1_EL1"           },
+              .fixed_bits = (0x6u << R_ID_AA64DFR0_DEBUGVER_SHIFT) },
+            { .name = "ID_AA64DFR1_EL1" },
             { .name = "ID_AA64DFR*_EL1_RESERVED",
-              .is_glob = true                     },
+              .is_glob = true },
             { .name = "ID_AA64AFR*",
-              .is_glob = true                     },
+              .is_glob = true },
             { .name = "ID_AA64ISAR0_EL1",
-              .exported_bits = 0x00fffffff0fffff0 },
+              .exported_bits = R_ID_AA64ISAR0_AES_MASK |
+                               R_ID_AA64ISAR0_SHA1_MASK |
+                               R_ID_AA64ISAR0_SHA2_MASK |
+                               R_ID_AA64ISAR0_CRC32_MASK |
+                               R_ID_AA64ISAR0_ATOMIC_MASK |
+                               R_ID_AA64ISAR0_RDM_MASK |
+                               R_ID_AA64ISAR0_SHA3_MASK |
+                               R_ID_AA64ISAR0_SM3_MASK |
+                               R_ID_AA64ISAR0_SM4_MASK |
+                               R_ID_AA64ISAR0_DP_MASK |
+                               R_ID_AA64ISAR0_FHM_MASK |
+                               R_ID_AA64ISAR0_TS_MASK |
+                               R_ID_AA64ISAR0_RNDR_MASK },
             { .name = "ID_AA64ISAR1_EL1",
-              .exported_bits = 0x000000f0ffffffff },
+              .exported_bits = R_ID_AA64ISAR1_DPB_MASK |
+                               R_ID_AA64ISAR1_APA_MASK |
+                               R_ID_AA64ISAR1_API_MASK |
+                               R_ID_AA64ISAR1_JSCVT_MASK |
+                               R_ID_AA64ISAR1_FCMA_MASK |
+                               R_ID_AA64ISAR1_LRCPC_MASK |
+                               R_ID_AA64ISAR1_GPA_MASK |
+                               R_ID_AA64ISAR1_GPI_MASK |
+                               R_ID_AA64ISAR1_FRINTTS_MASK |
+                               R_ID_AA64ISAR1_SB_MASK |
+                               R_ID_AA64ISAR1_BF16_MASK |
+                               R_ID_AA64ISAR1_DGH_MASK |
+                               R_ID_AA64ISAR1_I8MM_MASK },
+            { .name = "ID_AA64ISAR2_EL1",
+              .exported_bits = R_ID_AA64ISAR2_WFXT_MASK |
+                               R_ID_AA64ISAR2_RPRES_MASK |
+                               R_ID_AA64ISAR2_GPA3_MASK |
+                               R_ID_AA64ISAR2_APA3_MASK },
             { .name = "ID_AA64ISAR*_EL1_RESERVED",
-              .is_glob = true                     },
+              .is_glob = true },
         };
         modify_arm_cp_regs(v8_idregs, v8_user_idregs);
 #endif
@@ -8194,8 +8252,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 #ifdef CONFIG_USER_ONLY
         static const ARMCPRegUserSpaceInfo id_v8_user_midr_cp_reginfo[] = {
             { .name = "MIDR_EL1",
-              .exported_bits = 0x00000000ffffffff },
-            { .name = "REVIDR_EL1"                },
+              .exported_bits = R_MIDR_EL1_REVISION_MASK |
+                               R_MIDR_EL1_PARTNUM_MASK |
+                               R_MIDR_EL1_ARCHITECTURE_MASK |
+                               R_MIDR_EL1_VARIANT_MASK |
+                               R_MIDR_EL1_IMPLEMENTER_MASK },
+            { .name = "REVIDR_EL1" },
         };
         modify_arm_cp_regs(id_v8_midr_cp_reginfo, id_v8_user_midr_cp_reginfo);
 #endif
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index a72578fccb..fc6d5d824d 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -23,7 +23,8 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=armv8.1-a+sve2,         CROSS_CC_HAS_SVE2); \
 	    $(call cc-option,-march=armv8.3-a,              CROSS_CC_HAS_ARMV8_3); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
-	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE)) 3> config-cc.mak
+	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
+	    $(call cc-option,-march=armv9-a+sme,            CROSS_CC_HAS_ARMV9_SME)) 3> config-cc.mak
 -include config-cc.mak
 
 # Pauth Tests
@@ -53,7 +54,11 @@ endif
 ifneq ($(CROSS_CC_HAS_SVE),)
 # System Registers Tests
 AARCH64_TESTS += sysregs
+ifneq ($(CROSS_CC_HAS_ARMV9_SME),)
+sysregs: CFLAGS+=-march=armv9-a+sme -DHAS_ARMV9_SME
+else
 sysregs: CFLAGS+=-march=armv8.1-a+sve
+endif
 
 # SVE ioctl test
 AARCH64_TESTS += sve-ioctls
diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
index 40cf8d2877..46b931f781 100644
--- a/tests/tcg/aarch64/sysregs.c
+++ b/tests/tcg/aarch64/sysregs.c
@@ -22,6 +22,13 @@
 #define HWCAP_CPUID (1 << 11)
 #endif
 
+/*
+ * Older assemblers don't recognize newer system register names,
+ * but we can still access them by the Sn_n_Cn_Cn_n syntax.
+ */
+#define SYS_ID_AA64ISAR2_EL1 S3_0_C0_C6_2
+#define SYS_ID_AA64MMFR2_EL1 S3_0_C0_C7_2
+
 int failed_bit_count;
 
 /* Read and print system register `id' value */
@@ -112,18 +119,23 @@ int main(void)
      * minimum valid fields - for the purposes of this check allowed
      * to have non-zero values.
      */
-    get_cpu_reg_check_mask(id_aa64isar0_el1, _m(00ff,ffff,f0ff,fff0));
-    get_cpu_reg_check_mask(id_aa64isar1_el1, _m(0000,00f0,ffff,ffff));
+    get_cpu_reg_check_mask(id_aa64isar0_el1, _m(f0ff,ffff,f0ff,fff0));
+    get_cpu_reg_check_mask(id_aa64isar1_el1, _m(00ff,f0ff,ffff,ffff));
+    get_cpu_reg_check_mask(SYS_ID_AA64ISAR2_EL1, _m(0000,0000,0000,ffff));
     /* TGran4 & TGran64 as pegged to -1 */
-    get_cpu_reg_check_mask(id_aa64mmfr0_el1, _m(0000,0000,ff00,0000));
-    get_cpu_reg_check_zero(id_aa64mmfr1_el1);
+    get_cpu_reg_check_mask(id_aa64mmfr0_el1, _m(f000,0000,ff00,0000));
+    get_cpu_reg_check_mask(id_aa64mmfr1_el1, _m(0000,f000,0000,0000));
+    get_cpu_reg_check_mask(SYS_ID_AA64MMFR2_EL1, _m(0000,000f,0000,0000));
     /* EL1/EL0 reported as AA64 only */
     get_cpu_reg_check_mask(id_aa64pfr0_el1,  _m(000f,000f,00ff,0011));
-    get_cpu_reg_check_mask(id_aa64pfr1_el1,  _m(0000,0000,0000,00f0));
+    get_cpu_reg_check_mask(id_aa64pfr1_el1,  _m(0000,0000,0f00,0fff));
     /* all hidden, DebugVer fixed to 0x6 (ARMv8 debug architecture) */
     get_cpu_reg_check_mask(id_aa64dfr0_el1,  _m(0000,0000,0000,0006));
     get_cpu_reg_check_zero(id_aa64dfr1_el1);
-    get_cpu_reg_check_zero(id_aa64zfr0_el1);
+    get_cpu_reg_check_mask(id_aa64zfr0_el1,  _m(0ff0,ff0f,00ff,00ff));
+#ifdef HAS_ARMV9_SME
+    get_cpu_reg_check_mask(id_aa64smfr0_el1, _m(80f1,00fd,0000,0000));
+#endif
 
     get_cpu_reg_check_zero(id_aa64afr0_el1);
     get_cpu_reg_check_zero(id_aa64afr1_el1);
-- 
2.39.2


