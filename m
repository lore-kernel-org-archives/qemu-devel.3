Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9E2CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8OQ-0000Ml-Py; Thu, 07 May 2026 19:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OO-0000KX-JB
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:32 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8OM-00013s-RX
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:32 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7de4e6c5a30so1478281a34.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197470; x=1778802270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRXH/5Yzg5qUxVagyQUdgQKhabXT5R+OCJBCFUe7dI4=;
 b=SVTROKRTDCYu/T8SBp2JU7BiskDMPOjhu3AHE/sHihyJ+RTiZvcJWypFDRyZqa9Pb/
 G4TdVol9sfyTrhE9nBPlfj77F/N5UKvqtAlNfl5SkCS/oy8RZ7N6PLyRRpQkzwP7M2Bw
 DTFcHmJeI8BIEz8QCsZoEuOv6x4ZRtSjt9SbZ7tR5A4+qIAUksc5CUMs6BiTThjov4so
 S/vuummjUv5NFPr8NJ1PAIFyCO8Ncq3OAEpag+FEy/ck8dshyA2ZDuA2lyDl6HUSBUfv
 A7wKYug7BWyYjmKmfkyFO2xrdnxKVF5xJEpGbTh/1KQxC3WL2pRozPdVQNyctaDvorl/
 FYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197470; x=1778802270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SRXH/5Yzg5qUxVagyQUdgQKhabXT5R+OCJBCFUe7dI4=;
 b=Y2WD9a3HjXE5LE/PCLDexZAJCLydEPWxFZEwPQ/JdFc9KWX/Y7hkHiwZF4/Lytd1xj
 FaeIEZ+b5hdESL5CyaAzbgMWwLerDdNoT4uSnkvmw+7GzvSlNTE17qGLsgNLL2JHh8/y
 RTZ3frDXtswDkkGbHsxuDaXrwltnHaFXBEwUVT7cD7mMgkZorGa3ONfcl1grRcaKhoir
 VwQOUrUBtQA0VSsUuIRpazPvg3BinZtkFi4c8ABTpU4wL7F0ZLpdzl5VyXCstwE7csKA
 RyFsR11Yp1sSc2cTMgdxdCpWqO2HIuXWMTBx05vlblGREKz7ws93CrIbsA0DtoKUZgkp
 GxEA==
X-Gm-Message-State: AOJu0YxG0TvpzzuAGM4WFjyel2QO1/es4uRqPyVuiyH9tUf8iSVp0T7M
 eP+psCYvhK+zTY+SVfu1AghHz4ZnIFiAkfw/Q1ZHsxL7N0eM/Be3FRJ6wgwwkksbHi1LAnRFNd3
 8P4hn
X-Gm-Gg: AeBDiet+mq6Fd0qfJg5BchfAPkjI2iINnLoYDLuIi2LuFIBUvMIGKg0ZZ37QhaSAo1A
 5FWP3BjUNtyW0VWF2pXG9CA0cc10DZGkbvDPl/qqI6u+0i1fltUYa/EGo37yJzcw4it5l/1PFGs
 Fr2Ug/sExaAsS78qI6KbxOMihBzz0PjiOhAJcACUntlqoRU63jUx69JcosVaXZIZU/EKOPAdF20
 HKbMdIZTYETmpF0/TZYQ7JZt4lRNyrALavnTWVFJe2A7b6jHqlPD8x9iIVqEW1VHXc67uq5LqOg
 zYf/8AHDdVWaVGXwIXLS7R0Fr37wJMBqa8vJr1YKTFBME4BcqOC/D7QbE5Duq/M8NUF966Srxgm
 iO42cwKktEOzsNFwwvqmydVq5SLnsgGfMv53F0Q+C10QmDBPex9Z4PSMUfI8Bnfa3apKOmJpwgF
 /L8F66V+E9BnifVitziK7Tl8Qw+ujal5a0jXq6wATa/zPFpw==
X-Received: by 2002:a05:6830:6b0b:b0:7cf:da97:57d6 with SMTP id
 46e09a7af769-7e1dee81175mr6072343a34.6.1778197469698; 
 Thu, 07 May 2026 16:44:29 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 16/60] target/arm: Implement ID_AA64FPFR0
Date: Thu,  7 May 2026 18:43:29 -0500
Message-ID: <20260507234413.643512-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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
 target/arm/cpu-features.h    |  9 +++++++++
 target/arm/helper.c          | 13 +++++++++++--
 target/arm/cpu-sysregs.h.inc |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 4ab2a51c99..4ba263b225 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -409,6 +409,15 @@ FIELD(ID_AA64SMFR0, I16I64, 52, 4)
 FIELD(ID_AA64SMFR0, SMEVER, 56, 4)
 FIELD(ID_AA64SMFR0, FA64, 63, 1)
 
+FIELD(ID_AA64FPFR0, F8E5M2, 0, 1)
+FIELD(ID_AA64FPFR0, F8E4M3, 1, 1)
+FIELD(ID_AA64FPFR0, F8MM4, 26, 1)
+FIELD(ID_AA64FPFR0, F8MM8, 27, 1)
+FIELD(ID_AA64FPFR0, F8DP2, 28, 1)
+FIELD(ID_AA64FPFR0, F8DP4, 29, 1)
+FIELD(ID_AA64FPFR0, F8FMA, 30, 1)
+FIELD(ID_AA64FPFR0, F8CVT, 31, 1)
+
 FIELD(ID_DFR0, COPDBG, 0, 4)
 FIELD(ID_DFR0, COPSDBG, 4, 4)
 FIELD(ID_DFR0, MMAPDBG, 8, 4)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6263a3cb3b..ec027ed00c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6456,11 +6456,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
               .resetvalue = 0 },
-            { .name = "ID_AA64PFR7_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64FPFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 7,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64FPFR0) },
             { .name = "ID_AA64DFR0_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 5, .opc2 = 0,
               .access = PL1_R, .type = ARM_CP_CONST,
@@ -6691,6 +6691,15 @@ void register_cp_regs_for_features(ARMCPU *cpu)
                                R_ID_AA64SMFR0_I16I64_MASK |
                                R_ID_AA64SMFR0_SMEVER_MASK |
                                R_ID_AA64SMFR0_FA64_MASK },
+            { .name = "ID_AA64FPFR0_EL1",
+              .exported_bits = R_ID_AA64FPFR0_F8E5M2_MASK |
+                               R_ID_AA64FPFR0_F8E4M3_MASK |
+                               R_ID_AA64FPFR0_F8MM4_MASK |
+                               R_ID_AA64FPFR0_F8MM8_MASK |
+                               R_ID_AA64FPFR0_F8DP2_MASK |
+                               R_ID_AA64FPFR0_F8DP4_MASK |
+                               R_ID_AA64FPFR0_F8FMA_MASK |
+                               R_ID_AA64FPFR0_F8CVT_MASK },
             { .name = "ID_AA64MMFR0_EL1",
               .exported_bits = R_ID_AA64MMFR0_ECV_MASK,
               .fixed_bits = (0xfu << R_ID_AA64MMFR0_TGRAN64_SHIFT) |
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index b99579f773..6e8b335b8f 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -3,6 +3,7 @@ DEF(ID_AA64PFR0_EL1, 3, 0, 0, 4, 0)
 DEF(ID_AA64PFR1_EL1, 3, 0, 0, 4, 1)
 DEF(ID_AA64PFR2_EL1, 3, 0, 0, 4, 2)
 DEF(ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
+DEF(ID_AA64FPFR0_EL1, 3, 0, 0, 4, 7)
 DEF(ID_AA64DFR0_EL1, 3, 0, 0, 5, 0)
 DEF(ID_AA64DFR1_EL1, 3, 0, 0, 5, 1)
 DEF(ID_AA64AFR0_EL1, 3, 0, 0, 5, 4)
-- 
2.43.0


