Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43138CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQlI-0004kE-5j; Wed, 10 Apr 2024 01:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQlG-0004k1-95; Wed, 10 Apr 2024 01:44:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruQl8-0001CV-Jb; Wed, 10 Apr 2024 01:44:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CB0145D4DC;
 Wed, 10 Apr 2024 08:46:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 90C0FB0143;
 Wed, 10 Apr 2024 08:44:16 +0300 (MSK)
Received: (nullmailer pid 4182012 invoked by uid 1000);
 Wed, 10 Apr 2024 05:44:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.11 04/41] tests/tcg/aarch64/sysregs.c: Use S syntax for
 id_aa64zfr0_el1 and id_aa64smfr0_el1
Date: Wed, 10 Apr 2024 08:43:25 +0300
Message-Id: <20240410054416.4181891-4-mjt@tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

Some assemblers will complain about attempts to access
id_aa64zfr0_el1 and id_aa64smfr0_el1 by name if the test
binary isn't built for the right processor type:

 /tmp/ccASXpLo.s:782: Error: selected processor does not support system register name 'id_aa64zfr0_el1'
 /tmp/ccASXpLo.s:829: Error: selected processor does not support system register name 'id_aa64smfr0_el1'

However, these registers are in the ID space and are guaranteed to
read-as-zero on older CPUs, so the access is both safe and sensible.
Switch to using the S syntax, as we already do for ID_AA64ISAR2_EL1
and ID_AA64MMFR2_EL1.  This allows us to drop the HAS_ARMV9_SME check
and the makefile machinery to adjust the CFLAGS for this test, so we
don't rely on having a sufficiently new compiler to be able to check
these registers.

This means we're actually testing the SME ID register: no released
GCC yet recognizes -march=armv9-a+sme, so that was always skipped.
It also avoids a future problem if we try to switch the "do we have
SME support in the toolchain" check from "in the compiler" to "in the
assembler" (at which point we would otherwise run into the above
errors).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 3dc2afeab2964b54848715b913b6c605f36be3e1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: pick this for v8.0.0-2361-g1f51573f79
 "target/arm: Fix SME full tile indexing")

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index fc6d5d824d..118d069073 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -51,15 +51,10 @@ AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7
 mte-%: CFLAGS += -march=armv8.5-a+memtag
 endif
 
-ifneq ($(CROSS_CC_HAS_SVE),)
 # System Registers Tests
 AARCH64_TESTS += sysregs
-ifneq ($(CROSS_CC_HAS_ARMV9_SME),)
-sysregs: CFLAGS+=-march=armv9-a+sme -DHAS_ARMV9_SME
-else
-sysregs: CFLAGS+=-march=armv8.1-a+sve
-endif
 
+ifneq ($(CROSS_CC_HAS_SVE),)
 # SVE ioctl test
 AARCH64_TESTS += sve-ioctls
 sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
index 46b931f781..d8eb06abcf 100644
--- a/tests/tcg/aarch64/sysregs.c
+++ b/tests/tcg/aarch64/sysregs.c
@@ -25,9 +25,14 @@
 /*
  * Older assemblers don't recognize newer system register names,
  * but we can still access them by the Sn_n_Cn_Cn_n syntax.
+ * This also means we don't need to specifically request that the
+ * assembler enables whatever architectural features the ID registers
+ * syntax might be gated behind.
  */
 #define SYS_ID_AA64ISAR2_EL1 S3_0_C0_C6_2
 #define SYS_ID_AA64MMFR2_EL1 S3_0_C0_C7_2
+#define SYS_ID_AA64ZFR0_EL1 S3_0_C0_C4_4
+#define SYS_ID_AA64SMFR0_EL1 S3_0_C0_C4_5
 
 int failed_bit_count;
 
@@ -132,10 +137,8 @@ int main(void)
     /* all hidden, DebugVer fixed to 0x6 (ARMv8 debug architecture) */
     get_cpu_reg_check_mask(id_aa64dfr0_el1,  _m(0000,0000,0000,0006));
     get_cpu_reg_check_zero(id_aa64dfr1_el1);
-    get_cpu_reg_check_mask(id_aa64zfr0_el1,  _m(0ff0,ff0f,00ff,00ff));
-#ifdef HAS_ARMV9_SME
-    get_cpu_reg_check_mask(id_aa64smfr0_el1, _m(80f1,00fd,0000,0000));
-#endif
+    get_cpu_reg_check_mask(SYS_ID_AA64ZFR0_EL1,  _m(0ff0,ff0f,00ff,00ff));
+    get_cpu_reg_check_mask(SYS_ID_AA64SMFR0_EL1, _m(80f1,00fd,0000,0000));
 
     get_cpu_reg_check_zero(id_aa64afr0_el1);
     get_cpu_reg_check_zero(id_aa64afr1_el1);
-- 
2.39.2


