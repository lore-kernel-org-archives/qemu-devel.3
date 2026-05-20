Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F16CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlYj-0006i1-63; Wed, 20 May 2026 14:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYh-0006fT-QY
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:19 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYe-0000SB-QP
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:19 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3680540a6efso2828288a91.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301335; x=1779906135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjP/qEuf/tycrqFw+mSyrMAF+WG+DYMnwHYOmyGsbr4=;
 b=MXU/7BNMDkb9vVv/pVWRjRfVcwpulyppS6sOsSxL4rWQ9+zKbFOZN7YHWKklIyyO+1
 GMrylH+dZajuY3vYft03TZd+XKziM8elUPV0pyaWReEsaBv3h1FDBRmP3QJEe+Q24W8a
 JuXn7rPXasQeixBWEQJ3GUnoQ6mCR5ZimpywAKOkq7TVoQYvl5Gc7eqqlZm9ytKYStOb
 +p39lN9fzt854yU9wZPI5Rw1jQK/EmCNQDXTaFrUWol0A6t2EG8jmPJIguosla4+FcX5
 12VV8fc49pGj6h67lz3qcyAjG7LZxWE0s6K27sOEtsvkzj8+wg4b1BKJH1GQ3CjiJ184
 w3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301335; x=1779906135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FjP/qEuf/tycrqFw+mSyrMAF+WG+DYMnwHYOmyGsbr4=;
 b=WDwNozI2l1cVWZYHxt18uw1uNfKyDS8oO3Occ3557lj0VrUJ4WTPVlc0Nop4NeE8ue
 r8x1X1SNBq8UGlwJdxSjXyng/AlE+QOSJqEOHwOuw6qgsJYeynrgXz/h3XsgvnLZpsXI
 pasalnc59coiirXCXTIQYgdvJG9vpPXoahdHdte9Ch2zfeZZMTnYucI6MakKjCeVXvtN
 U2/urzu+kA4L6Za4ULUdI3pi36OeGHhBi8UWaw5cg1cs6Oxhm6JfPuuN2ylBU3DJvosN
 c8w9pqUK6ENFU/1xT0dWSWHA45eQt2mqvQk2T0MF9M6I0ULIp+cOOXNetygGRQ7ScAJt
 hKOw==
X-Gm-Message-State: AOJu0Yy1/L9e+fgvqRy59duMpjJDehI8DXSiTYSRfUdKSPIf4Sput7bR
 p7nDPeJXhBbWbFimTk0PuPUS4W6Zewk1UcmdTCg06/2l8erRu8ouMNGiIvX3dAK0QwSpl2WYt5k
 +xaUleic=
X-Gm-Gg: Acq92OGYhHMCZpkH5W8uiBNpbVdjlrt+CA2UcG6y4qSDru9162ADuMSY3FMvJGZwLIh
 LsaZDOq3wUMdKMIv21rgGeQpLfxv2pKvWtZtlY+g11NZREKLepinx7iyOHOM+2/Z7hlMFzppGS2
 QWwHsc0/H0usxmbCGoli6aT0qZrm9+WjUgDrgiO1xlOVIHeRgOe905PmVk6Y4v/SLvnlYNd1Eei
 iIv1nHSIRSdVtJgmaaE3CwooaQckLBxDXSy8IX7e9y3iRLSd84ghlHtZ+HZQRLwLIuUeaa7y0AH
 BzPwn7AfSTT27ENfxDi9zn4q/43qqp0raf7OYHIv3RDj8mByb9vU1cLEw3vCiznjmq4ThoSpR92
 HCs+KbQwDXTAJCZerzaVeYCWRRo2iuYasdVKFvJTmjqUkVv0BebpwqliwtKr85u4t7veVQ6j3/W
 SSh6k9h2X6odeZfmKoz/E9rEok3ipX
X-Received: by 2002:a17:90b:3845:b0:368:763a:17b8 with SMTP id
 98e67ed59e1d1-36951889325mr25413681a91.2.1779301335302; 
 Wed, 20 May 2026 11:22:15 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 01/64] target/arm: Implement ID_AA64ISAR3
Date: Wed, 20 May 2026 11:21:10 -0700
Message-ID: <20260520182213.872945-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h    | 9 +++++++++
 target/arm/helper.c          | 8 ++++++--
 target/arm/cpu-sysregs.h.inc | 1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4e44245a8b..50776347a5 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -244,6 +244,15 @@ FIELD(ID_AA64ISAR2, CSSC, 52, 4)
 FIELD(ID_AA64ISAR2, LUT, 56, 4)
 FIELD(ID_AA64ISAR2, ATS1A, 60, 4)
 
+FIELD(ID_AA64ISAR3, CPA, 0, 4)
+FIELD(ID_AA64ISAR3, FAMINMAX, 4, 4)
+FIELD(ID_AA64ISAR3, TLBIW, 8, 4)
+FIELD(ID_AA64ISAR3, PACM, 12, 4)
+FIELD(ID_AA64ISAR3, LSFE, 16, 4)
+FIELD(ID_AA64ISAR3, OCCMO, 20, 4)
+FIELD(ID_AA64ISAR3, LSUI, 24, 4)
+FIELD(ID_AA64ISAR3, FPRCVT, 28, 4)
+
 FIELD(ID_AA64PFR0, EL0, 0, 4)
 FIELD(ID_AA64PFR0, EL1, 4, 4)
 FIELD(ID_AA64PFR0, EL2, 8, 4)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8240f1b384..6ad01b345f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6519,11 +6519,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64ISAR2)},
-            { .name = "ID_AA64ISAR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64ISAR3_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64ISAR3) },
             { .name = "ID_AA64ISAR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 6, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -6752,6 +6752,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64ISAR2_BC_MASK |
                                R_ID_AA64ISAR2_RPRFM_MASK |
                                R_ID_AA64ISAR2_CSSC_MASK },
+            { .name = "ID_AA64ISAR3_EL1",
+              .exported_bits = R_ID_AA64ISAR3_FAMINMAX_MASK |
+                               R_ID_AA64ISAR3_LSFE_MASK |
+                               R_ID_AA64ISAR3_FPRCVT_MASK },
             { .name = "ID_AA64ISAR*_EL1_RESERVED",
               .is_glob = true },
         };
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 3d1ed40f04..b99579f773 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -10,6 +10,7 @@ DEF(ID_AA64AFR1_EL1, 3, 0, 0, 5, 5)
 DEF(ID_AA64ISAR0_EL1, 3, 0, 0, 6, 0)
 DEF(ID_AA64ISAR1_EL1, 3, 0, 0, 6, 1)
 DEF(ID_AA64ISAR2_EL1, 3, 0, 0, 6, 2)
+DEF(ID_AA64ISAR3_EL1, 3, 0, 0, 6, 3)
 DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
 DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
 DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
-- 
2.43.0


