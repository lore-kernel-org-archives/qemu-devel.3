Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69507D3C91A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTLWW-0007GP-2R; Wed, 10 Dec 2025 09:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vTLWF-0007DU-Mu
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:50:22 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vTLWD-0003Cc-23
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:50:18 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so90711585e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765378213; x=1765983013; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x5J6irympALxO9zFBVJN5fXnibixGLu4B+VHKb8EIcA=;
 b=BI071+g0bCApAFuwqvPL0KuDouYvXgDyXhcYvIk2gyqCbSbELxvAWaar+58NdpBbYz
 PruVbbEh0cqF62CE3kVbzbvygC1GYyv4R9bVvN8uVcPD6+ss2/XqdRJ1fA2yDxt6Dj4j
 8UHD0NemQtRs10gD0TRJS+MEguWWW3CePncKPYSOwW99ojmhLkXkL6mAz/Ta8mOeMfB/
 hZBNkLvICo5/SmdizCLV2a2el7mSZQGzW8K++oZmRAox6MtjVE8sD7YxU+v0DKjjYQdT
 XR7l6e2xb1WoQVLLg8R/6g8xCeJenCapUOBHFhDdTReCjasfeWJ32q9DmsaJNogfn3R7
 2ezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765378213; x=1765983013;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x5J6irympALxO9zFBVJN5fXnibixGLu4B+VHKb8EIcA=;
 b=ISIe0WTYlabkOjNVxidcMy55oQdXqjh6ym2yc8F839SI/EnuswwaqGcseO7DyeMT/3
 wDz+mtabMXK30GNU3KDzjpTRxm4hldFc0ysWqf+O15u3JX2JcnurGAhr0y6Ri8eVCQRf
 ZWu9AvoEJ/6ImQ9ejZwjTXH8jCQq7+nAWn8RHoq6q0nzpbxVmp99111MJNM5SaStTtn0
 hdpRXGF6prX+MncPcP5flv/810t7i4FmF7wLiB7KvpA89Qzo39F9/o/fIyIWjwQMly9p
 8CGIZeJdlEOlEvyua7jDpaOfTg5QyOG+MUadFEGRC4vG27vMKgWFk1BEGdXE6ZTRjuba
 GKQQ==
X-Gm-Message-State: AOJu0YyL+PRS3bzFVd6Ou5N+t30EqZcoy6557GVhPetXxXK0fR6Sg235
 cxvhQWcSnxgwlz/jPnf+P0+7PGpOLeKtB8qAxtQMgKwzeKB54YzUXeiUzXCseoJT0NPnKSvh5yq
 xAgNEDRk=
X-Gm-Gg: ASbGncuQucZAsiD84yokpUut04DnBcVGgrrR1mdygPdHIBtzHPB889SjUiA4/Tt1U4R
 iLkoz001EN74qz9KNW3ATy0q974YZf49C6EnDqebIH5itlnW7VOY7kNI3DKLiddPJ9VLpPYK885
 ETMInubN4dzLx+qrGvGSNtFvFU8+G5viDPtaz8kh3Vdv4cyxReKIfEqK6uU3adFbeUdlBmqCOph
 nguMZh56U6xdha8+PqOjMMDm5CDUt7P2RukoSbji79s6i2pTK6i7c5kp3To+BTOIlWoFa45qpwI
 cu7jiEW8xy8LKxiUeLpLRUQhYChG8F8qvmouM0rtZr1zKWRkY648zR+EB6A8E5jbIrh2P06hjFu
 j4/R3XjTS9VAo2zv4Yi1e7dsD++CTD6Sm8ZiOXnSo5iTtsi0wm/mXuF4McO0ZrVJd1xWeo34E0Z
 QGqYFmkc24KaU0Ug==
X-Google-Smtp-Source: AGHT+IGeqoDcVYpC0KYM3jG6Gvmo5Fg8nlss0aJIIklrSfoGyHVDBYQ5mE2c2CZmulLzF089MiRJnA==
X-Received: by 2002:a05:600c:3484:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-47a837fd285mr30295755e9.8.1765378213509; 
 Wed, 10 Dec 2025 06:50:13 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:62e8:705f:f7a:c7b0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d7f778sm56595235e9.11.2025.12.10.06.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:50:13 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Wed, 10 Dec 2025 14:50:12 +0000
Subject: [PATCH v6 2/4] target/arm: Allow writes to FNG1, FNG0, A2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-jmac-asid2-v6-2-d3b3acab98c7@linaro.org>
References: <20251210-jmac-asid2-v6-0-d3b3acab98c7@linaro.org>
In-Reply-To: <20251210-jmac-asid2-v6-0-d3b3acab98c7@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x334.google.com
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

This just allows read/write of three feature bits. ASID is still
ignored. Any writes to TTBR0_EL0 and TTBR1_EL0, including changing
the ASID, will still cause a complete flush of the TLB.

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-features.h |  7 +++++++
 target/arm/helper.c       | 28 ++++++++++++++++++++++------
 target/arm/internals.h    |  5 +++++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 579fa8f8f4..d56bda9ce0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -346,6 +346,8 @@ FIELD(ID_AA64MMFR3, SDERR, 52, 4)
 FIELD(ID_AA64MMFR3, ADERR, 56, 4)
 FIELD(ID_AA64MMFR3, SPEC_FPACC, 60, 4)
 
+FIELD(ID_AA64MMFR4, ASID2, 8, 4)
+
 FIELD(ID_AA64DFR0, DEBUGVER, 0, 4)
 FIELD(ID_AA64DFR0, TRACEVER, 4, 4)
 FIELD(ID_AA64DFR0, PMUVER, 8, 4)
@@ -1369,6 +1371,11 @@ static inline bool isar_feature_aa64_aie(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, AIE) != 0;
 }
 
+static inline bool isar_feature_aa64_asid2(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR4, ASID2) != 0;
+}
+
 static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c20334fa65..534c783be9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -428,6 +428,15 @@ int alle1_tlbmask(CPUARMState *env)
             ARMMMUIdxBit_Stage2_S);
 }
 
+int alle2_tlbmask(void)
+{
+    return (ARMMMUIdxBit_E20_2 |
+            ARMMMUIdxBit_E20_2_PAN |
+            ARMMMUIdxBit_E20_2_GCS |
+            ARMMMUIdxBit_E20_0 |
+            ARMMMUIdxBit_E20_0_GCS);
+}
+
 static const ARMCPRegInfo cp_reginfo[] = {
     /*
      * Define the secure and non-secure FCSE identifier CP registers
@@ -2802,12 +2811,7 @@ static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     if (extract64(raw_read(env, ri) ^ value, 48, 16) &&
         (arm_hcr_el2_eff(env) & HCR_E2H)) {
-        uint16_t mask = ARMMMUIdxBit_E20_2 |
-                        ARMMMUIdxBit_E20_2_PAN |
-                        ARMMMUIdxBit_E20_2_GCS |
-                        ARMMMUIdxBit_E20_0 |
-                        ARMMMUIdxBit_E20_0_GCS;
-        tlb_flush_by_mmuidx(env_cpu(env), mask);
+        tlb_flush_by_mmuidx(env_cpu(env), alle2_tlbmask());
     }
     raw_write(env, ri, value);
 }
@@ -6102,6 +6106,12 @@ static void tcr2_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_aie, cpu)) {
         valid_mask |= TCR2_AIE;
     }
+    if (cpu_isar_feature(aa64_asid2, cpu)) {
+        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
+        if (((raw_read(env, ri) ^ value) & TCR2_A2) != 0) {
+            tlb_flush_by_mmuidx(CPU(cpu), alle1_tlbmask(env));
+        }
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
@@ -6121,6 +6131,12 @@ static void tcr2_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_mec, cpu)) {
         valid_mask |= TCR2_AMEC0 | TCR2_AMEC1;
     }
+    if (cpu_isar_feature(aa64_asid2, cpu)) {
+        valid_mask |= TCR2_FNG1 | TCR2_FNG0 | TCR2_A2;
+        if (((raw_read(env, ri) ^ value) & TCR2_A2) != 0) {
+            tlb_flush_by_mmuidx(CPU(cpu), alle2_tlbmask());
+        }
+    }
     value &= valid_mask;
     raw_write(env, ri, value);
 }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 75677945af..db9cc1fd73 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1891,6 +1891,11 @@ uint64_t gt_direct_access_timer_offset(CPUARMState *env, int timeridx);
  * all EL1" scope; this covers stage 1 and stage 2.
  */
 int alle1_tlbmask(CPUARMState *env);
+/*
+ * Return mask of ARMMMUIdxBit values corresponding to an "invalidate
+ * all EL2&0" scope.
+ */
+int alle2_tlbmask(void);
 
 /* Set the float_status behaviour to match the Arm defaults */
 void arm_set_default_fp_behaviours(float_status *s);

-- 
2.43.0


