Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195EAFB44A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Bm-0005lC-BT; Fri, 24 Apr 2026 00:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Be-0005g6-Qh
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:30:48 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8BU-0002Vx-Vk
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:30:36 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-42fc6923f38so1356068fac.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005030; x=1777609830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xapIpLETptineJX0lgqdbGa1HlQeIgwkY2ZGyDukvI=;
 b=Z3d84YEPyiVgnEt2zwSztCldzyHMHnTcW6dNt/iOYk3Zi/zFLOpU8alKpJp8gh5QK9
 rHvKjz8X77kHS/jiW8GcijX4apHe1bYR3hsgxFgjn8wiDQwFmJvKlsDNQG+e9pyqTDgy
 RgyDMfUP0RvVcQPodtsJCG6IJl8sbZBOtcSsTGk8Q8TzGhNzBguQ9fNWB3oAwygP4SEe
 2lLJAmvS6gfbCWAlnHn5oTnXdMZgZej5L/qWbKGLt9qCdi7oCCi9dAsWCozKQwF3SJOu
 LmWinaM818eOx2p5sE5mtx077uAUGhoMLDInZ27Gmbl3oOpV7ODw5ZeQM9lkPB9cVG5Q
 x8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005030; x=1777609830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/xapIpLETptineJX0lgqdbGa1HlQeIgwkY2ZGyDukvI=;
 b=VqrWeAXuM3h/74iCDk7Sh81q+MSPVFEFaAq7PdeVyvzshpUeQRw7VDNTiMwAAUjNkt
 F8ZZcntB2lKZ395nlAVthKUXwnf4cFsfcED6N6EgL1rnKaokSKsaYYVJxDoMLn0sI5fu
 uvT/xsyNoRQiA/tlkHf9azhOcZucDVYkU/Sjd4E7Df2peZarihxDk9ITCaZxGDsDknHA
 upIJAlShkEPuZgatGv/8q9XG8OsPhzudyee8Fe+FC65mutAdHRPGfxBHOCO4ODb00TqU
 a4bWKHzsU8f7hxMwhWgCuqsLdShJyM/ub9WW2L8ALyJ+/Rw+6mdoOYD9vkFrSs60gXBg
 VwSA==
X-Gm-Message-State: AOJu0Ywn88MatVlzhoRYYe/34Amec+jqUzZbDiZzHsP7GzayBDayrG3X
 KRgGN09OgnjrgpJYG8CdXzC2MZMNGZO9Y0DC+mZ3uWpjdFot8+LoEI0dVc1QCfOFeTkuIr4kgCz
 Via9HcpQ=
X-Gm-Gg: AeBDieuUY6IxFjIh+AIxThwPIm2O4xHB6cZStycRZ98ZXIbvOQiyS2NT/hXzd3liiw3
 TAFJSt1o4nuQ1SMGvrvA54IDP2i2QLXF2pm+hq0hXRHf3HVj4a7he0acO3bXFat4CQwUhwQZnCS
 l9RtJZWsEnEL9VDqoi3F5D2yRfch3zku5S91R0S6nfsuidctEU+fcYpws4IeWVs6QDFYo63V1Ed
 vR3uokvRzC+ZJ83rCgtvbyC/6lFoN7Rq1H3AIBK7zqKk0jOJtFqig3cYGHAE6adsCr0DVuo4d6t
 Y3tDE0aRqMK5QiGPErTnTsQ1uUtgxoRiqKVPE6wNphCycEKJGRodwU+0xQDMgOYzSzfviBfWm2o
 Fl0CRDT12Ysn040Y3mdW8WF4Rr56VLrk0Uu5spyVDeoHBfADgYZXyhrph7zb2RpM4xLadiUvFvf
 KjO5P1W/DLReo6X4ApvaTk4joOnbpyJUkeVlBf1mFU9c8tOEnjrkVO42y3kuTZCRZ6J9+RTUsw
X-Received: by 2002:a05:6870:b50e:b0:423:4260:2e0d with SMTP id
 586e51a60fabf-42a9986c2fcmr15017337fac.8.1777005030067; 
 Thu, 23 Apr 2026 21:30:30 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:30:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 01/40] target/arm: Implement ID_AA64ISAR3
Date: Fri, 24 Apr 2026 14:29:35 +1000
Message-ID: <20260424043014.46305-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index b683c9551a..b165fe0b1a 100644
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
index 7389f2988c..08285b69a7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6552,11 +6552,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
@@ -6785,6 +6785,10 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


