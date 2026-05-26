Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCDCCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmf-0000fL-BC; Tue, 26 May 2026 10:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmd-0000bq-Cw
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:27 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmb-0001MT-Ld
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:27 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bdb3fd39045so802731766b.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805764; x=1780410564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yL5NRAXpRBtuHCSzVNE194CNIE6tSdV2xGaEmF0h4I0=;
 b=QMnQDeKwrY05mEDYhdUQi99HKrt3jIgQcTQxcq5IfNKv/V/6pC5DZtV44n1rX8iDlj
 wKYneS8/g0UjlPb69LYQKcWyFHYluQmE2NMs5MYgh92hCLxAO4lEmVd4MyUo9grMPAq4
 OMHeRqcNY+QFUZdfWks/BlhMpmRuIgrUhybYZfmQQSY+Y1frW2buY3o11mtjTx6sYeRw
 kOFLk8XHbKOAgPB2qwNEw7isTtlmMWTxrJXJtl4M1n9zi7oVCI4vjCTZfhtwtkhOF496
 /NMTrMDdVpCz+CF/BfUoR77u+CP8I+86Ny/Dxp9dzyBlfm6ybxtwLhu/I/ORNepAi36A
 xP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805764; x=1780410564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yL5NRAXpRBtuHCSzVNE194CNIE6tSdV2xGaEmF0h4I0=;
 b=hUxGqVQJFl/fwQ+g5g63o70iskyxELBkuQlU6tUZ/XcHgw1NPGYuEWw9erUhjj1hez
 74kT+HAvl4KeiLCMw3AW53vs9RVQTkl5QuuaAxsSWeAe8TGsrFcTVTR/CBCoDYOe/1yF
 VGidyNwCb595ayoGI/JNETZoxR1QqSwhv6snVfnH/vikHdoh4VdmlCoF8P6sRSEIN+Ny
 5Fk/t36HREcguaEoCSx8YnUA1ea5lWXtOsncU02lsfwyzvYoeqDpbK3r3TKeQUn4ZaZz
 Wjv7eOrFEyP4HXdAUOFU9iAeWCalMseXkgo9cWNcHClmCBk1e2jnRadlhFzjrMAg3Twj
 p2fA==
X-Gm-Message-State: AOJu0YwcjwCf9xJXkXLMBJ8u/1scJG435O98kRkaSWbfDDex8tuqZeQV
 1Wp/K2Zj+DnfiV2XX+qOuZjtFmpZYhhuwFa8VyrJMQKdjaa7IzgNnmsVWUYHpYxCWek8zxVN3WI
 6yAj3
X-Gm-Gg: Acq92OFBoYqLbalybU2g8xIjWTV/yByA5fGm3/SAE8Kx/sVMm1EZ919r1dcQiw5lJnw
 W2n8L7EdjmoiB4Or/1p3OgnyrNx9hea8kh8jfALbhSDGUscZKJ21MfQQeGys8Qior/3fDUoFkxg
 UlY2epVLUQaAsONbHrT23Alg3nepAg8p2LFeQZTlCxf5RMhn2zx33ZZ6sLVQNvxx7qg80Ip9004
 +2VDy5liGjHlxZr08BemK+ssmJ3j6xZo/yNtEWPkEFNS5ZqjOUwkAbKFrSdbpY2jyaEpfXcKRw0
 7FLaAan+KMGMdaetDZ4VCF5LYxbZfbI3ff1nOkETwtt0Fu+5ShMtez76q0aOYJfxnjwXtzTxoCE
 zyJKaAo12LBHVQ5uWtNv++NZj9IuPD6v6jxOjxXqLMAKWQGvSQOr0L4nG2iNni2p60Y4CZnrY69
 dETpauJwzIklQdS/BZa75E5sVPt8aH3L6Gs6guFYYPHXh3DTZ1xiZmsWZvaE91gukEikKtnxB2G
 CaVtIp1y0JWGVe1qAfUOHex2hAjU5Q=
X-Received: by 2002:a17:907:c317:b0:bda:d08:35ea with SMTP id
 a640c23a62f3a-bdd283a64bdmr1135444766b.48.1779805764080; 
 Tue, 26 May 2026 07:29:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/54] target/arm: Implement ID_AA64ISAR3
Date: Tue, 26 May 2026 15:28:28 +0100
Message-ID: <20260526142850.2326589-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h    | 9 +++++++++
 target/arm/cpu-sysregs.h.inc | 1 +
 target/arm/cpu.c             | 1 +
 target/arm/helper.c          | 8 ++++++--
 4 files changed, 17 insertions(+), 2 deletions(-)

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
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c47b70ac69..e1ea41fdc5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1747,6 +1747,7 @@ static void arm_clear_aarch64_idregs(ARMCPU *cpu)
     SET_IDREG(&cpu->isar, ID_AA64ISAR0, 0);
     SET_IDREG(&cpu->isar, ID_AA64ISAR1, 0);
     SET_IDREG(&cpu->isar, ID_AA64ISAR2, 0);
+    SET_IDREG(&cpu->isar, ID_AA64ISAR3, 0);
     SET_IDREG(&cpu->isar, ID_AA64PFR0, 0);
     SET_IDREG(&cpu->isar, ID_AA64PFR1, 0);
     SET_IDREG(&cpu->isar, ID_AA64PFR2, 0);
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
-- 
2.43.0


