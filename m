Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BC5ECD997
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 21:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo6Ut-00056l-2O; Thu, 05 Feb 2026 16:02:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vo6Uq-00053X-Qm
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 16:02:40 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vo6Up-000601-4O
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 16:02:40 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b872f1c31f1so170504966b.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 13:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770325357; x=1770930157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sJMjrsjX50/IvKMVHiTfQNftWHBbwucOtBJ29lzZdd0=;
 b=Z7BTWOVFVXQKtyNgXLhI2mPIAbVyXMzXZS7uZyHyt42NZcero+mqw09JQjzkDOFxoL
 zIXUjwEjuN6613+zLBqzErOvgcBBTuVnnHSEHMrfYh+s8dY2Do+io6PPyuaHFvMFUTDw
 si+pePRSn6Niu4IODtsV5HUd1GglR/Z3aLyfrc+zUh62YQcrdV77zkOADhuCV9KPikdn
 IIaFxxm3YC45abRgubj/lmkYQSmQIRnJy1Eme48IGctUrJAuYFWfgWDZXOMblu/GAkkB
 CWXQYtvgC6I4rwdn2C3dNEdl5Jb09cnIJee+pdHdpwc/EHqff0Pm7c2D/YOnLDY6bhQS
 wZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770325357; x=1770930157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sJMjrsjX50/IvKMVHiTfQNftWHBbwucOtBJ29lzZdd0=;
 b=ExVeciqvhk+NJBn/jbaje/8s72PvJg8nT0A2alfhlPaU2/z5wP+UFt8ncS8ZTwdl1E
 yP8Vo0N/c+23Lkfo0vjfn38LsN96pDaC/34U8i/VotKIJb15zK0r7vMwPlL0jS8tV0P0
 c1dpR3TgoB+Sa3eZ4taKoWM0VpdZUyBrd20CdVntafkrJVFcA3gHcET9413Ksz590gSV
 XQzXNP0UcTs98LjdGfJK0PyHJjpwRLP/7/gLu963z+d90+gYi/XJ0F5dVeQPrZanjCH9
 OnW3ALO4SGQjkn2bKGc74kw7wPOT71p0SwFuMEnQNrFgtJ7tFR/s6G7EJoDNvvxC/+Ek
 beiA==
X-Gm-Message-State: AOJu0YzQnBKBfcw23KnvNU7kl5UQOjjilRT+YPDSxwQ1voMUVc9NSAwV
 sa6S4gROuDKPjdWBLY2HmOrVdAZTg1SID9YinZswkYBgJHxe9JGSrNE2rW24YQhLoGg=
X-Gm-Gg: AZuq6aKTWdlS/yXaR633g2eDv2wVAUR0BAwQ7IRYG8h3tzntdjrxjXezAEDNON59OnY
 Rz1zPy309XJgkVWGudhU2Dr6FTTbCo3qdAx1GV1ADptf0NdCGR5PUq/6gm9IWDbCxfjapZ7ylFF
 EIaDDG4Qgn6xSDK4rVAg8Rxp3V/RegI8H0orcvAv91xqKL3yjWw8pc+3z28bfRQDUtuISNEkMkK
 /ceGX+liBL5OOHau6b91a92rZ2620ox4sHm2OYGz4QecVldpelO5wiWJcY1KPJHkWp2LrpnOpi4
 gS756McoWoiHtPqj5QBWo2kBk32LJC+b8Klgsgq1DvzG5wwHEZzgmILgVya3z2usEWQE5NkHAPt
 9OCJWAV+Au+56JCypg9BSTaXM4pkXOpbezfYfd5J6Vo+W2VgcW2JKXnz6pIGQLij+VwXwmW6ZuD
 wU3+hPvOaHkV0=
X-Received: by 2002:a17:907:9723:b0:b88:4102:8932 with SMTP id
 a640c23a62f3a-b8edf384485mr18822966b.44.1770325357070; 
 Thu, 05 Feb 2026 13:02:37 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8edacf10b8sm17897966b.50.2026.02.05.13.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 13:02:36 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8473D5F8BF;
 Thu, 05 Feb 2026 21:02:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PATCH v3] target/arm: implement FEAT_E2H0
Date: Thu,  5 Feb 2026 21:02:31 +0000
Message-ID: <20260205210231.888199-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

FEAT_E2H0 is a formalisation of the existing behaviour of HCR_EL2.E2H
being programmable to switch between EL2 host mode and the
"traditional" nVHE EL2 mode. This implies at some point we might want
to model CPUs without FEAT_E2H0 which will always have EL2 host mode
enabled.

There are two values to represent no E2H0 systems of which 0b1110 will
make HCR_EL2.NV1 RES0 for FEAT_NV systems. For FEAT_NV2 the NV1 bit is
always valid.

Message-ID: <20260130181648.628364-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

---
v3
  - treat E2H0 as a signed field
  - don't duplicate FEAT_NV check
  - fold HCR_E2H into wider FEAT_AARCH64 check along with HCR_RW
  - don't force writable NV1 for FEAT_NV2
v2
  - new helper and properly handling NV1
---
 docs/system/arm/emulation.rst |  1 +
 target/arm/cpu-features.h     | 15 +++++++++++++++
 target/arm/helper.c           | 21 +++++++++++++++------
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index e0d5f9886e1..7787691853e 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -54,6 +54,7 @@ the following architecture extensions:
 - FEAT_DotProd (Advanced SIMD dot product instructions)
 - FEAT_DoubleFault (Double Fault Extension)
 - FEAT_E0PD (Preventing EL0 access to halves of address maps)
+- FEAT_E2H0 (Programming of HCR_EL2.E2H)
 - FEAT_EBF16 (AArch64 Extended BFloat16 instructions)
 - FEAT_ECV (Enhanced Counter Virtualization)
 - FEAT_EL0 (Support for execution at EL0)
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b29e20eeb68..b683c9551a0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -347,6 +347,7 @@ FIELD(ID_AA64MMFR3, ADERR, 56, 4)
 FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
 
 FIELD(ID_AA64MMFR4, ASID2, 8, 4)
+FIELD(ID_AA64MMFR4, E2H0, 24, 4)
 
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
@@ -1378,6 +1379,20 @@ static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
 }
 
+/*
+ * Note the E2H0 ID fields is signed, increasingly negative as more
+ * isn't implemented.
+ */
+static inline bool isar_feature_aa64_e2h0(const ARMISARegisters *id)
+{
+    return FIELD_SEX64_IDREG(id, ID_AA64MMFR4, E2H0) >= 0;
+}
+
+static inline bool isar_feature_aa64_nv1_res0(const ARMISARegisters *id)
+{
+    return FIELD_SEX64_IDREG(id, ID_AA64MMFR4, E2H0) <= -2;
+}
+
 static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 390ea32c218..e12b2455d3f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3776,7 +3776,8 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
     }
 
     if (arm_feature(env, ARM_FEATURE_AARCH64)) {
-        if (cpu_isar_feature(aa64_vh, cpu)) {
+        if (cpu_isar_feature(aa64_vh, cpu) &&
+            cpu_isar_feature(aa64_e2h0, cpu)) {
             valid_mask |= HCR_E2H;
         }
         if (cpu_isar_feature(aa64_ras, cpu)) {
@@ -3801,7 +3802,10 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
             valid_mask |= HCR_GPF;
         }
         if (cpu_isar_feature(aa64_nv, cpu)) {
-            valid_mask |= HCR_NV | HCR_NV1 | HCR_AT;
+            valid_mask |= HCR_NV | HCR_AT;
+            if (!cpu_isar_feature(aa64_nv1_res0, cpu)) {
+                valid_mask |= HCR_NV1;
+            }
         }
         if (cpu_isar_feature(aa64_nv2, cpu)) {
             valid_mask |= HCR_NV2;
@@ -3817,10 +3821,15 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
     /* Clear RES0 bits.  */
     value &= valid_mask;
 
-    /* RW is RAO/WI if EL1 is AArch64 only */
-    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
-        !cpu_isar_feature(aa64_aa32_el1, cpu)) {
-        value |= HCR_RW;
+    if (arm_feature(env, ARM_FEATURE_AARCH64)) {
+        /* RW is RAO/WI if EL1 is AArch64 only */
+        if (!cpu_isar_feature(aa64_aa32_el1, cpu)) {
+            value |= HCR_RW;
+        }
+        /* Strictly E2H is RES1 unless FEAT_E2H0 relaxes the requirement */
+        if (!cpu_isar_feature(aa64_e2h0, cpu)) {
+            value |= HCR_E2H;
+        }
     }
 
     /*
-- 
2.47.3


