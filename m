Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D06112588E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PLf-0007nL-Ly; Wed, 11 Mar 2026 15:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PLY-0007lY-IJ; Wed, 11 Mar 2026 15:35:56 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PLW-0000C1-Gi; Wed, 11 Mar 2026 15:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257667; bh=bbmqjRM2rDQUjJA1YR13aTuu13pDhP4NF8kBbLuGsTo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Nx5/wgHZSM6LVrz0QBL7R3F41Yeo7lAyR/ZXh/QospPlJDoCFchkHBCtmCJPjO1/L
 1wo/oZ9I1i8ytb0vdv1vmKOTjZ8XEaVAPIrvPwvhtZ2i5Kh+LiMA7Qo7XJhvNF32xh
 oxv9XM+QuO2mcE3TRbjt5FXa8Thegm25WcdSacZFYkObUeqhpMqro2yIwYYHjVu2bk
 smS3yOZaViwkpsDMXrGP2oLFegcGDx4BUsknJbgTRSAMDaA1/HNCh0PJtPBR4CR5jC
 WzXtKi/Ey38RuAQorNCn/XKAnqaE2k2nqYGfgm1P3bdpVq5ZgQbUiceb6JVIFbresM
 4mssXpPTnqmtQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2F1541920F6;
 Wed, 11 Mar 2026 22:34:27 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7028F37C45B;
 Wed, 11 Mar 2026 22:35:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 14/53] target/arm: Don't let 'sme=on' downgrade SME
Date: Wed, 11 Mar 2026 22:34:07 +0300
Message-ID: <20260311193449.1096110-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In our handling of the boolean 'sme' CPU property, we write this 0/1
value directly to ID_AA64PFR1_EL1.SME.  This worked when the only
valid values in that field were 0 (for no SME) and 1 (for SME1).
However, with the addition of SME2 the SME field can now also read 2.
This means that "-cpu max,sme=on" will result in an inconsistent set
of ID registers, where ID_AA64PFR1_EL1.SME claims SME1 but
ID_AA64SMFR0_EL1.SMEver claims SME2p1.  This isn't a valid thing to
report, and confuses Linux into reporting SME2 to userspace but not
actually enabling userspace access for it.

Fix this bug by having arm_cpu_sme_finalize() fix up the
ID_AA64PFR1_EL1.SME field to match ID_AA64SMFR0.SMEver.  This means
the "sme" property's semantics are "off" for "no SME" and "on" for
"enable at whatever the default SME version this CPU provides is".

Update the documentation to clarify what 'sve=on' and 'sme=on' do.
(We don't have the equivalent bug for 'sve=on' because
ID_AA64PFR0_EL1.SVE only has 0 and 1 as valid values, but the
semantics of the property are the same.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-id: 20260202133353.2231685-6-peter.maydell@linaro.org
(cherry picked from commit aeb3c147fc4a1eb9a73f9f10923fc06def088aeb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index 37d5dfd15b..024119449c 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -318,6 +318,11 @@ SVE CPU Property Parsing Semantics
      provided an error will be generated.  To avoid this error, one must
      enable at least one vector length prior to enabling SVE.
 
+  10) Enabling SVE (with ``sve=on`` or by default) enables all the SVE
+      sub-features that the CPU supports (for example, it may also
+      enable SVE2). There are not generally any lower-level controls
+      for disabling specific SVE sub-features.
+
 SVE CPU Property Examples
 -------------------------
 
@@ -430,6 +435,11 @@ and all vector lengths must be powers of 2.  The maximum vector
 length supported by qemu is 2048 bits.  Otherwise, there are no
 additional constraints on the set of vector lengths supported by SME.
 
+As with SVE, ``sme=on`` enables all the SME sub-features the CPU
+supports (for example, it may also enable SME2), and there are
+no lower-level controls for fine-grained disabling of specific
+SME sub-features.
+
 SME User-mode Default Vector Length Property
 --------------------------------------------
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index ae84d8e420..2082672dea 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -363,6 +363,16 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
 
     cpu->sme_vq.map = vq_map;
     cpu->sme_max_vq = 32 - clz32(vq_map);
+
+    /*
+     * The "sme" property setter writes a bool value into ID_AA64PFR1_EL1.SME
+     * (and at this point we know it's not 0). Correct that value to report
+     * the same SME version as ID_AA64SMFR0_EL1.SMEver.
+     */
+    if (FIELD_EX64_IDREG(&cpu->isar, ID_AA64SMFR0, SMEVER) != 0) {
+        /* SME2 or better */
+        FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR1, SME, 2);
+    }
 }
 
 static bool cpu_arm_get_sme(Object *obj, Error **errp)
@@ -375,6 +385,11 @@ static void cpu_arm_set_sme(Object *obj, bool value, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
+    /*
+     * For now, write 0 for "off" and 1 for "on" into the PFR1 field.
+     * We will correct this value to report the right SME
+     * level (SME vs SME2) in arm_cpu_sme_finalize() later.
+     */
     FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR1, SME, value);
 }
 
-- 
2.47.3


