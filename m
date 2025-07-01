Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353A6C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSQ-0005W6-MT; Tue, 01 Jul 2025 13:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSG-0005RU-KR
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:39 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSB-0003MJ-3u
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453608ed113so36262415e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389648; x=1751994448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=evTzhWc2yTDACm+Ua9M6BMEplb8PtFO2i8waym+wjlY=;
 b=PBFAvn410sFJlhRzyJq4c/soxPuz9vRAgAev8EW618S/0NavDg+4xzpKcLs7f4yOJw
 V7jLAgRRvpsTwGdcH5oyfFE66oLKPgxYgGyH+fDRHe4IJbnP4xoZtqbVlvwDVBkLUtSn
 6TENR819FyflhjVuYQCl3advWS71yjHy0nfNabAdSkduq9j0XWCYYmq1bTUXbrrAUCC5
 7UAi3VpDemfuuQ60F/dk/dEERgllFOBhgJ3aLXm4BLW6swTh3Q2RoQPlXTdxQ14Xib4o
 PrOU0Fud+plG+XUjmjonQJ2Ipi06lzEIueTZmiGCy4l97J6qdLbRszzh85E8b0TBWfDR
 F70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389648; x=1751994448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=evTzhWc2yTDACm+Ua9M6BMEplb8PtFO2i8waym+wjlY=;
 b=hSH3/hG36Z8aHmXTbsET5guB/TbxrfUiQt/MH+BJhDx+6LkN5/7yoVxrv2Q+aECqEp
 nDX6yu08ZSnkkNb3fLJ6gseJukXEIo0nd4BpJxQkOmnGkdSaoWqKzl2j2i4rKUfu4P3U
 vPyPZUS7OSRQiPPFOWlL1CUtjmpVDXjS5L4VOHpanGDC5YVGdOgThuu4PrkcB5U7HAGf
 lmjIDUVnkK4GxhW6mRcvU0KUhXdke8Rami2Pqoztwv2Qde208vqmAkbhrXr4EzrLjA9c
 hJLgTU03pyVn4LXjOnIqgPPENNH700lyOKHW5ERO2ZekCNlGf9kQZE/3JuBjRAt6G0LR
 s7dg==
X-Gm-Message-State: AOJu0Yw2umxEjx3LXdFvi4YjfoODWxvitPscZ8J55S+iHyv6eapx0vZO
 TizgprbwHUuuWdmEfCopLvf9h9KbFw7zg/m7jEQbCrLeCe8Ke3QHefZVR9Pi6wJuaqvS05dNzmf
 wPEfJ
X-Gm-Gg: ASbGncvWejlD4uR8cwVM59PpVWfsIK9l3FP2PWDpYOkwwF0GmebylXhH+mo56HW8NbF
 0jB3RXKTVglZd/aE0P/ULrUVUqF8L4a5TdAEMy4kPwQEHN6iPB22Jxv2NM5MilitE2PcbiGC7gI
 yecN1Iu0V/wOh6N9jMuQi25y7PeMP7cgSVsAUv11+XrQLAv/Lz0T8IY4yBvexBkKIBkv9TzuZfN
 34VNwJ4z1GYQujrD5gu13+3qDsYXuDwNrxlZh1oR3BoXfwsxJHvAGjf7YXTOlNM/xGjDHdRemRb
 NDzucz7X/UnlovPWLwv3QEWnih+XoWGNQpup29jwhS/2Lg91zZOXwQ4jQmFVYtK9eZar
X-Google-Smtp-Source: AGHT+IFhDsZFFsWS35V+h/qxqPjMhTqY+dg0m/badwO8KWd8+G6CPmEVWdP19U4OKpFfoDYMmkKTmA==
X-Received: by 2002:a05:600c:a087:b0:453:a88:d509 with SMTP id
 5b1f17b1804b1-4538ee42c26mr243486055e9.10.1751389647532; 
 Tue, 01 Jul 2025 10:07:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/43] arm/cpu: Store aa64isar1/2 into the idregs array
Date: Tue,  1 Jul 2025 18:06:41 +0100
Message-ID: <20250701170720.4072660-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-id: 20250617153931.1330449-4-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 44 +++++++++++++++++++--------------------
 target/arm/cpu.h          |  2 --
 target/arm/cpu.c          | 13 ++++--------
 target/arm/cpu64.c        |  9 ++++----
 target/arm/helper.c       |  4 ++--
 target/arm/hvf/hvf.c      |  2 +-
 target/arm/kvm.c          |  6 ++----
 target/arm/tcg/cpu64.c    | 24 ++++++++++-----------
 8 files changed, 48 insertions(+), 56 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 6a47f1a6d22..43c9695be0d 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -468,17 +468,17 @@ static inline bool isar_feature_aa64_tlbios(const ARMISARegisters *id)
 
 static inline bool isar_feature_aa64_jscvt(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, JSCVT) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, JSCVT) != 0;
 }
 
 static inline bool isar_feature_aa64_fcma(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FCMA) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, FCMA) != 0;
 }
 
 static inline bool isar_feature_aa64_xs(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, XS) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, XS) != 0;
 }
 
 /*
@@ -502,9 +502,9 @@ isar_feature_pauth_feature(const ARMISARegisters *id)
      * Architecturally, only one of {APA,API,APA3} may be active (non-zero)
      * and the other two must be zero.  Thus we may avoid conditionals.
      */
-    return (FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) |
-            FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, API) |
-            FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3));
+    return (FIELD_EX64_IDREG(id, ID_AA64ISAR1, APA) |
+            FIELD_EX64_IDREG(id, ID_AA64ISAR1, API) |
+            FIELD_EX64_IDREG(id, ID_AA64ISAR2, APA3));
 }
 
 static inline bool isar_feature_aa64_pauth(const ARMISARegisters *id)
@@ -522,7 +522,7 @@ static inline bool isar_feature_aa64_pauth_qarma5(const ARMISARegisters *id)
      * Return true if pauth is enabled with the architected QARMA5 algorithm.
      * QEMU will always enable or disable both APA and GPA.
      */
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, APA) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, APA) != 0;
 }
 
 static inline bool isar_feature_aa64_pauth_qarma3(const ARMISARegisters *id)
@@ -531,77 +531,77 @@ static inline bool isar_feature_aa64_pauth_qarma3(const ARMISARegisters *id)
      * Return true if pauth is enabled with the architected QARMA3 algorithm.
      * QEMU will always enable or disable both APA3 and GPA3.
      */
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, APA3) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, APA3) != 0;
 }
 
 static inline bool isar_feature_aa64_sb(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SB) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, SB) != 0;
 }
 
 static inline bool isar_feature_aa64_predinv(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, SPECRES) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, SPECRES) != 0;
 }
 
 static inline bool isar_feature_aa64_frint(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, FRINTTS) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, FRINTTS) != 0;
 }
 
 static inline bool isar_feature_aa64_dcpop(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, DPB) != 0;
 }
 
 static inline bool isar_feature_aa64_dcpodp(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, DPB) >= 2;
 }
 
 static inline bool isar_feature_aa64_bf16(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, BF16) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, BF16) != 0;
 }
 
 static inline bool isar_feature_aa64_ebf16(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, BF16) > 1;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, BF16) > 1;
 }
 
 static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, LRCPC) != 0;
 }
 
 static inline bool isar_feature_aa64_rcpc_8_4(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, LRCPC) >= 2;
 }
 
 static inline bool isar_feature_aa64_i8mm(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, I8MM) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR1, I8MM) != 0;
 }
 
 static inline bool isar_feature_aa64_wfxt(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, WFXT) >= 2;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, WFXT) >= 2;
 }
 
 static inline bool isar_feature_aa64_hbc(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, BC) != 0;
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, BC) != 0;
 }
 
 static inline bool isar_feature_aa64_mops(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, MOPS);
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, MOPS);
 }
 
 static inline bool isar_feature_aa64_rpres(const ARMISARegisters *id)
 {
-    return FIELD_EX64(id->id_aa64isar2, ID_AA64ISAR2, RPRES);
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR2, RPRES);
 }
 
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7b5c7a4abc7..b81bc46966f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1074,8 +1074,6 @@ struct ArchCPU {
         uint32_t dbgdidr;
         uint32_t dbgdevid;
         uint32_t dbgdevid1;
-        uint64_t id_aa64isar1;
-        uint64_t id_aa64isar2;
         uint64_t id_aa64pfr0;
         uint64_t id_aa64pfr1;
         uint64_t id_aa64mmfr0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f033411b5da..2777de72944 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2123,9 +2123,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         uint64_t t;
         uint32_t u;
 
-        t = cpu->isar.id_aa64isar1;
-        t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 0);
-        cpu->isar.id_aa64isar1 = t;
+        FIELD_DP64_IDREG(isar, ID_AA64ISAR1, JSCVT, 0);
 
         t = cpu->isar.id_aa64pfr0;
         t = FIELD_DP64(t, ID_AA64PFR0, FP, 0xf);
@@ -2178,11 +2176,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         t = FIELD_DP64(t, ID_AA64ISAR0, DP, 0);
         SET_IDREG(isar, ID_AA64ISAR0, t);
 
-        t = cpu->isar.id_aa64isar1;
+        t = GET_IDREG(isar, ID_AA64ISAR1);
         t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 0);
         t = FIELD_DP64(t, ID_AA64ISAR1, BF16, 0);
         t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 0);
-        cpu->isar.id_aa64isar1 = t;
+        SET_IDREG(isar, ID_AA64ISAR1, t);
 
         t = cpu->isar.id_aa64pfr0;
         t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 0xf);
@@ -2218,14 +2216,11 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     if (!cpu->has_neon && !cpu->has_vfp) {
-        uint64_t t;
         uint32_t u;
 
         FIELD_DP64_IDREG(isar, ID_AA64ISAR0, FHM, 0);
 
-        t = cpu->isar.id_aa64isar1;
-        t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 0);
-        cpu->isar.id_aa64isar1 = t;
+        FIELD_DP64_IDREG(isar, ID_AA64ISAR1, FRINTTS, 0);
 
         u = cpu->isar.mvfr0;
         u = FIELD_DP32(u, MVFR0, SIMDREG, 0);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c105fcc4ea5..e2b25b00431 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -502,6 +502,7 @@ void aarch64_add_sme_properties(Object *obj)
 void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
 {
     ARMPauthFeature features = cpu_isar_feature(pauth_feature, cpu);
+    ARMISARegisters *isar = &cpu->isar;
     uint64_t isar1, isar2;
 
     /*
@@ -512,13 +513,13 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
      *
      * Begin by disabling all fields.
      */
-    isar1 = cpu->isar.id_aa64isar1;
+    isar1 = GET_IDREG(isar, ID_AA64ISAR1);
     isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, APA, 0);
     isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPA, 0);
     isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, API, 0);
     isar1 = FIELD_DP64(isar1, ID_AA64ISAR1, GPI, 0);
 
-    isar2 = cpu->isar.id_aa64isar2;
+    isar2 = GET_IDREG(isar, ID_AA64ISAR2);
     isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, APA3, 0);
     isar2 = FIELD_DP64(isar2, ID_AA64ISAR2, GPA3, 0);
 
@@ -580,8 +581,8 @@ void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp)
         }
     }
 
-    cpu->isar.id_aa64isar1 = isar1;
-    cpu->isar.id_aa64isar2 = isar2;
+    SET_IDREG(isar, ID_AA64ISAR1, isar1);
+    SET_IDREG(isar, ID_AA64ISAR2, isar2);
 }
 
 static const Property arm_cpu_pauth_property =
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 638550e45ac..fd2a86b6b0e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8008,12 +8008,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 1,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64isar1 },
+              .resetvalue = GET_IDREG(isar, ID_AA64ISAR1)},
             { .name = "ID_AA64ISAR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = cpu->isar.id_aa64isar2 },
+              .resetvalue = GET_IDREG(isar, ID_AA64ISAR2)},
             { .name = "ID_AA64ISAR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5d25260c5c3..7554282410f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -868,7 +868,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         { HV_SYS_REG_ID_AA64DFR0_EL1, &host_isar.id_aa64dfr0 },
         { HV_SYS_REG_ID_AA64DFR1_EL1, &host_isar.id_aa64dfr1 },
         { HV_SYS_REG_ID_AA64ISAR0_EL1, &host_isar.idregs[ID_AA64ISAR0_EL1_IDX] },
-        { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.id_aa64isar1 },
+        { HV_SYS_REG_ID_AA64ISAR1_EL1, &host_isar.idregs[ID_AA64ISAR1_EL1_IDX] },
         /* Add ID_AA64ISAR2_EL1 here when HVF supports it */
         { HV_SYS_REG_ID_AA64MMFR0_EL1, &host_isar.id_aa64mmfr0 },
         { HV_SYS_REG_ID_AA64MMFR1_EL1, &host_isar.id_aa64mmfr1 },
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index bd33b0f656e..6fa5bdff42a 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -323,10 +323,8 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64dfr1,
                               ARM64_SYS_REG(3, 0, 0, 5, 1));
         err |= get_host_cpu_reg(fd, ahcf, ID_AA64ISAR0_EL1_IDX);
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar1,
-                              ARM64_SYS_REG(3, 0, 0, 6, 1));
-        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64isar2,
-                              ARM64_SYS_REG(3, 0, 0, 6, 2));
+        err |= get_host_cpu_reg(fd, ahcf, ID_AA64ISAR1_EL1_IDX);
+        err |= get_host_cpu_reg(fd, ahcf, ID_AA64ISAR2_EL1_IDX);
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr0,
                               ARM64_SYS_REG(3, 0, 0, 7, 0));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ed681ee08b0..91750264724 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -68,7 +68,7 @@ static void aarch64_a35_initfn(Object *obj)
     cpu->isar.id_aa64dfr0 = 0x10305106;
     cpu->isar.id_aa64dfr1 = 0;
     SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
-    cpu->isar.id_aa64isar1 = 0;
+    SET_IDREG(isar, ID_AA64ISAR1, 0);
     cpu->isar.id_aa64mmfr0 = 0x00101122;
     cpu->isar.id_aa64mmfr1 = 0;
     cpu->clidr = 0x0a200023;
@@ -224,7 +224,7 @@ static void aarch64_a55_initfn(Object *obj)
     cpu->dcz_blocksize = 4; /* 64 bytes */
     cpu->isar.id_aa64dfr0  = 0x0000000010305408ull;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
-    cpu->isar.id_aa64isar1 = 0x0000000000100001ull;
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
     cpu->isar.id_aa64mmfr0 = 0x0000000000101122ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
@@ -357,7 +357,7 @@ static void aarch64_a76_initfn(Object *obj)
     cpu->dcz_blocksize = 4;
     cpu->isar.id_aa64dfr0  = 0x0000000010305408ull;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
-    cpu->isar.id_aa64isar1 = 0x0000000000100001ull;
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
     cpu->isar.id_aa64mmfr0 = 0x0000000000101122ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
@@ -437,7 +437,7 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->isar.id_aa64mmfr1 = 0x0000000011212100;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000000010211120);
-    cpu->isar.id_aa64isar1 = 0x0000000000010001;
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000010001);
     SET_IDREG(isar, ID_AA64ZFR0, 0x0000000000000000);
     cpu->clidr = 0x0000000080000023;
     /* 64KB L1 dcache */
@@ -605,7 +605,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     cpu->dcz_blocksize = 4;
     cpu->isar.id_aa64dfr0  = 0x0000000110305408ull;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
-    cpu->isar.id_aa64isar1 = 0x0000000000100001ull;
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
     cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
@@ -684,7 +684,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     cpu->isar.id_aa64dfr0  = 0x000001f210305519ull;
     cpu->isar.id_aa64dfr1 = 0x00000000;
     SET_IDREG(isar, ID_AA64ISAR0, 0x1011111110212120ull); /* with FEAT_RNG */
-    cpu->isar.id_aa64isar1 = 0x0011100001211032ull;
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0011000001211032ull);
     cpu->isar.id_aa64mmfr0 = 0x0000000000101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x0220011102101011ull;
@@ -933,7 +933,7 @@ static void aarch64_a710_initfn(Object *obj)
     cpu->id_aa64afr0       = 0;
     cpu->id_aa64afr1       = 0;
     SET_IDREG(isar, ID_AA64ISAR0, 0x0221111110212120ull); /* with Crypto */
-    cpu->isar.id_aa64isar1 = 0x0010111101211052ull;
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0010111101211052ull);
     cpu->isar.id_aa64mmfr0 = 0x0000022200101122ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x1221011110101011ull;
@@ -1035,7 +1035,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     cpu->id_aa64afr0       = 0;
     cpu->id_aa64afr1       = 0;
     SET_IDREG(isar, ID_AA64ISAR0, 0x1221111110212120ull); /* with Crypto and FEAT_RNG */
-    cpu->isar.id_aa64isar1 = 0x0011111101211052ull;
+    SET_IDREG(isar, ID_AA64ISAR1, 0x0011111101211052ull);
     cpu->isar.id_aa64mmfr0 = 0x0000022200101125ull;
     cpu->isar.id_aa64mmfr1 = 0x0000000010212122ull;
     cpu->isar.id_aa64mmfr2 = 0x1221011112101011ull;
@@ -1160,7 +1160,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR0, RNDR, 1);     /* FEAT_RNG */
     SET_IDREG(isar, ID_AA64ISAR0, t);
 
-    t = cpu->isar.id_aa64isar1;
+    t = GET_IDREG(isar, ID_AA64ISAR1);
     t = FIELD_DP64(t, ID_AA64ISAR1, DPB, 2);      /* FEAT_DPB2 */
     t = FIELD_DP64(t, ID_AA64ISAR1, APA, PauthFeat_FPACCOMBINED);
     t = FIELD_DP64(t, ID_AA64ISAR1, API, 1);
@@ -1174,14 +1174,14 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64ISAR1, DGH, 1);      /* FEAT_DGH */
     t = FIELD_DP64(t, ID_AA64ISAR1, I8MM, 1);     /* FEAT_I8MM */
     t = FIELD_DP64(t, ID_AA64ISAR1, XS, 1);       /* FEAT_XS */
-    cpu->isar.id_aa64isar1 = t;
+    SET_IDREG(isar, ID_AA64ISAR1, t);
 
-    t = cpu->isar.id_aa64isar2;
+    t = GET_IDREG(isar, ID_AA64ISAR2);
     t = FIELD_DP64(t, ID_AA64ISAR2, RPRES, 1);    /* FEAT_RPRES */
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
-    cpu->isar.id_aa64isar2 = t;
+    SET_IDREG(isar, ID_AA64ISAR2, t);
 
     t = cpu->isar.id_aa64pfr0;
     t = FIELD_DP64(t, ID_AA64PFR0, FP, 1);        /* FEAT_FP16 */
-- 
2.43.0


