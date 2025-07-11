Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C20C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDv7-0007En-EQ; Fri, 11 Jul 2025 09:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDty-0004Ui-3C
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:59 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtw-00037U-8M
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-454df871875so6293355e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240894; x=1752845694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3RKupyWJCQDDIhOP+u0cTCBpDLfFp7iJSn/Hu9Aqtmc=;
 b=oPy6mtOTPKk+gc8s2ThS2fJyFF1q5QR700o+nrc/0yiV0hfGX98Z1x37dDOw2VhQDx
 RRew3mRjR35gGfgbvSGaeuwhQ79NidrcSPwsuXlBpTk8NgTRAyn6Np719Xi894BFroLY
 hEzBoKEB4wiViEItcqFyT8kqdXcOYcWDWWuondOcvcCD7q4fYhUW0rdrl5VCnMD0V/TB
 /1GRjyVh3EFJYtM2u3R8MP+iTeN1pRYv/7izIRgtdAnYqSqu69A3LXfB1kT3lIjpT3PH
 HLba82rSrBbtpIpPMVs9fYF0gqRRQO1LAV6FXW7LVSJh3AVIl6pZjvFmM5JEsAFm4noZ
 aPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240894; x=1752845694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3RKupyWJCQDDIhOP+u0cTCBpDLfFp7iJSn/Hu9Aqtmc=;
 b=Kguri3ZOpYlRyzOopzQrSwWASEAvmJsZbClJ9EpjQ6iowgAaiLO01+eCrMy9fCWOob
 0xkY0mlqWEhjkBjdEI03Mmg/ytp3smrbj+PAoB+s1YnGrBzkj8sFm1GwxSoqtlIaCXFG
 8c01FvxuyaECx8f3nd2UVqlia8zX9Pr2ddTu4dGfOscYkyZOTLNJQq6GuKvC1ai0M92e
 CUL+8ZU5GaX7IYDU6ReVPBUk8ATW58m0Y1UHJlGsL6YPohAK2pNGPqK92otYHwYXgrtw
 WJeqyUeP0yfdP6v1bJjYbq68FXfDlLvPdUGpSnamkSrpORw8FE9CM99WZc7hu8VXLqSa
 xXCw==
X-Gm-Message-State: AOJu0YxKSZjsr4RDL5G5jR/dkTS1ZJtVy0mDK3WsHS14UxzWhcVHvwc0
 mNoD5m/AOqYfyu348/BjRiaS+1Y2vRy9WeM+1pj+rpMV+3CQ7x6j7UCS31gcNrpNVUycovuRrva
 DR9tL
X-Gm-Gg: ASbGncvFeMDJizwabr1GOd9Y/yZyIkiTc/6BsAfHkAsnQO7P3pylnY86kq752htvvAU
 pJGoDQnmbEaRjc63Bf16Ohgdu1cLa5OQCdAeSP+BVQnBNgIWeOvnBgT/xQ26BJFzfSjzfni73Jo
 Ftrcf6rsVtHVHdziGq1Ng2N5qhDW2FJt98oDfBLMUxyXairVntVuyzRejcDSBtUVWPOkXrwERQK
 3mEzu7TrnhkJVuNcpNpn8i2uJ2HFcQUqZ86XpUozflTt1CxQtdbqaPB1+5+bfrNvk74PqveTbZk
 eir0ztc16PcrqGG/yn9NfdIWFhQ5jkvLFc+X4cvVcY4HKnCG1Zjw8Ym27zxduvmM4gPD938No2R
 AGaorvOtLXaUL1droiuMpCokxeKxt3+oGCng8cwA=
X-Google-Smtp-Source: AGHT+IHrZBBK9jSnP0CSqbt2lXJjpcFhAxVYfC6d4YNAC/Fo8ODbs6TsXAao6jIJjRdY6YHZM6YOAw==
X-Received: by 2002:a05:600c:1d8b:b0:455:ed48:144f with SMTP id
 5b1f17b1804b1-455ed4815f8mr20753175e9.14.1752240894434; 
 Fri, 11 Jul 2025 06:34:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/36] target/arm: Drop stub for define_tlb_insn_regs
Date: Fri, 11 Jul 2025 14:34:15 +0100
Message-ID: <20250711133429.1423030-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Allow the call to be compiled out by protecting it
with tcg_enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250707151547.196393-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c    | 4 +++-
 target/arm/tcg-stubs.c | 5 -----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3ea9958ea7a..c1b684e3d1c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7771,7 +7771,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
 
 #ifndef CONFIG_USER_ONLY
-    define_tlb_insn_regs(cpu);
+    if (tcg_enabled()) {
+        define_tlb_insn_regs(cpu);
+    }
 #endif
 
     if (arm_feature(env, ARM_FEATURE_V6)) {
diff --git a/target/arm/tcg-stubs.c b/target/arm/tcg-stubs.c
index 5e5166c0490..aac99b2672a 100644
--- a/target/arm/tcg-stubs.c
+++ b/target/arm/tcg-stubs.c
@@ -22,11 +22,6 @@ void raise_exception_ra(CPUARMState *env, uint32_t excp, uint32_t syndrome,
     g_assert_not_reached();
 }
 
-/* TLBI insns are only used by TCG, so we don't need to do anything for KVM */
-void define_tlb_insn_regs(ARMCPU *cpu)
-{
-}
-
 /* With KVM, we never use float_status, so these can be no-ops */
 void arm_set_default_fp_behaviours(float_status *s)
 {
-- 
2.43.0


