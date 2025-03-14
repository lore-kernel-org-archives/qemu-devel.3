Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BD2C282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4uE-00059j-M6; Fri, 14 Mar 2025 09:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uA-00058R-Vc
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:52 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4u9-00014p-1g
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:50 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39130ee05b0so2065690f8f.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958207; x=1742563007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PZV6zHs1ewUsWH9J0fMbzt0q9IpjkvsTqTb1g7WYdZ4=;
 b=OseBi+af6+49gxTf5zNPNbVKeuI943OLvqt5xyfHVINwEMMnNB+LxnE76flqLfvWa+
 u05wWcVGk75GPk6BCuoBxZGav0FPBlklSlaxIKVHXAjps6zAfi2RIhowdNvcYmCuH3R/
 jB3jQEOgkEzOA6bNa1PJzq38UaPtRnlf17gw7rAgHS3wL4FMwEQPb+DZwTo/5+0X5vNm
 vn8Oo9fgn66kVVgg2Zfaju3EE1FSO3rHhzda/EPRFlqELQ6WL2c+FAVw1iohhwZekbF4
 ChVxQ0GJxZM1n+e5YJsW/ZnPtyQSNwcx0vPqL6od3FFp0RlMeKMi+dX4GNsCEf47cme3
 Og0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958207; x=1742563007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZV6zHs1ewUsWH9J0fMbzt0q9IpjkvsTqTb1g7WYdZ4=;
 b=Rvwf+38agfmrKhgpKVVeLdTtWHqIQgaNFJeNe+Mll3w1Yjpc/XiBwS3kCCEF4yeKaJ
 FILnmHFEB7HO4l6gydB7hIPG3LjriLoqD3/t2gUPJnQUJ/WRjNz7CMnfd1fblxgY//Mj
 eAeLQnzg0ZnVHprGJtCTPlP9GYa1z4xbSsCD/Q6c1NRk1ef4SFkxZsV9+88NYQeixeol
 nymlaL7Sz6Il5G9Zl78/TnBHRExbfbWnDR12Jns2ZKZk61h+wRTtsWXYjx7UBQyEOKvF
 Y5sqZ6rp/UMPghb2I5Hmqy+guTFvF6VY3fUzvOFLQHeXd/1oQF4nNDMAIMwV4V5LBCEj
 H2ew==
X-Gm-Message-State: AOJu0YzGLAQTZFkhh8z1mwAv53XBdYADk/oQ0voVIpGBP52qijEBVXco
 4CzgyOMp4MCpec+At2y/F4BSCse+2Ud1AxmustDq/ypTmVu4up+bLLHcrEJ6XTLIQV8mhSd2Gvt
 O
X-Gm-Gg: ASbGncvugcedUOKl3wPF50dmNc7Ns8Xtn1Vei2VO6wMvPFs5ysX2KcW0wtNH3foFXti
 nKffad+/Vp02BUFny8Ft07oacAVtaa9FMlBl3o/t1lVqTyntk34EthW9dZIblf9YYfsp5mT2HLz
 hPKKqYOP/1nyazUo3ZALQA83HYn+hdXr/5a+Y+4AWgvqMcBf0SsKkeZBB+az0fcj8sYpMLmPCtP
 afhGEMgQgcRCabXKzWHnbT6LPPvSomjzTySmyJFDhqak7BXnnQQCQPRjaj8q116Qgy41U/NA5PX
 AhtRa1KlvySsMscXnv56m2axc9ftFlNa59U+GPGELHr/ubUwrLw=
X-Google-Smtp-Source: AGHT+IHcUtunci5Ethb6u/VAbBv6+KToy1Y+WWoaNvPmkwyON9kWeStFhbGNTuIOMmmN407tw+GcQg==
X-Received: by 2002:adf:a31b:0:b0:390:eb50:37c3 with SMTP id
 ffacd0b85a97d-3971e0bfa2emr2754143f8f.27.1741958206808; 
 Fri, 14 Mar 2025 06:16:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/17] target/arm: SCR_EL3.RW should be treated as 1 if EL2
 doesn't support AArch32
Date: Fri, 14 Mar 2025 13:16:27 +0000
Message-ID: <20250314131637.371866-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

The definition of SCR_EL3.RW says that its effective value is 1 if:
 - EL2 is implemented and does not support AArch32, and SCR_EL3.NS is 1
 - the effective value of SCR_EL3.{EEL2,NS} is {1,0} (i.e. we are
   Secure and Secure EL2 is disabled)

We implement the second of these in arm_el_is_aa64(), but forgot the
first.

Provide a new function arm_scr_rw_eff() to return the effective
value of SCR_EL3.RW, and use it in arm_el_is_aa64() and the other
places that currently look directly at the bit value.

(scr_write() enforces that the RW bit is RAO/WI if neither EL1 nor
EL2 have AArch32 support, but if EL1 does but EL2 does not then the
bit must still be writeable.)

This will mean that if code at EL3 attempts to perform an exception
return to AArch32 EL2 when EL2 is AArch64-only we will correctly
handle this as an illegal exception return: it will be caught by the
"return to an EL which is configured for a different register width"
check in HELPER(exception_return).

We do already have some CPU types which don't implement AArch32
above EL0, so this is technically a bug; it doesn't seem worth
backporting to stable because no sensible guest code will be
deliberately attempting to set the RW bit to a value corresponding
to an unimplemented execution state and then checking that we
did the right thing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 26 +++++++++++++++++++++++---
 target/arm/helper.c    |  4 ++--
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index d161a3e396b..28585c07555 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -392,6 +392,27 @@ static inline FloatRoundMode arm_rmode_to_sf(ARMFPRounding rmode)
     return arm_rmode_to_sf_map[rmode];
 }
 
+/* Return the effective value of SCR_EL3.RW */
+static inline bool arm_scr_rw_eff(CPUARMState *env)
+{
+    /*
+     * SCR_EL3.RW has an effective value of 1 if:
+     *  - we are NS and EL2 is implemented but doesn't support AArch32
+     *  - we are S and EL2 is enabled (in which case it must be AArch64)
+     */
+    ARMCPU *cpu = env_archcpu(env);
+
+    if (env->cp15.scr_el3 & SCR_RW) {
+        return true;
+    }
+    if (env->cp15.scr_el3 & SCR_NS) {
+        return arm_feature(env, ARM_FEATURE_EL2) &&
+            !cpu_isar_feature(aa64_aa32_el2, cpu);
+    } else {
+        return env->cp15.scr_el3 & SCR_EEL2;
+    }
+}
+
 /* Return true if the specified exception level is running in AArch64 state. */
 static inline bool arm_el_is_aa64(CPUARMState *env, int el)
 {
@@ -411,9 +432,8 @@ static inline bool arm_el_is_aa64(CPUARMState *env, int el)
         return aa64;
     }
 
-    if (arm_feature(env, ARM_FEATURE_EL3) &&
-        ((env->cp15.scr_el3 & SCR_NS) || !(env->cp15.scr_el3 & SCR_EEL2))) {
-        aa64 = aa64 && (env->cp15.scr_el3 & SCR_RW);
+    if (arm_feature(env, ARM_FEATURE_EL3)) {
+        aa64 = aa64 && arm_scr_rw_eff(env);
     }
 
     if (el == 2) {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index f0ead22937b..3df7d5347cb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9818,7 +9818,7 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
     uint64_t hcr_el2;
 
     if (arm_feature(env, ARM_FEATURE_EL3)) {
-        rw = ((env->cp15.scr_el3 & SCR_RW) == SCR_RW);
+        rw = arm_scr_rw_eff(env);
     } else {
         /*
          * Either EL2 is the highest EL (and so the EL2 register width
@@ -10627,7 +10627,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
 
         switch (new_el) {
         case 3:
-            is_aa64 = (env->cp15.scr_el3 & SCR_RW) != 0;
+            is_aa64 = arm_scr_rw_eff(env);
             break;
         case 2:
             hcr = arm_hcr_el2_eff(env);
-- 
2.43.0


