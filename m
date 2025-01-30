Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2BBC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCX-00043g-3g; Thu, 30 Jan 2025 13:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCS-0003yZ-JG
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:36 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZCI-0000YC-DG
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:36 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so676214f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261405; x=1738866205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fT9psFAWJPNLFoqhflxpXdULv7n4FREA8vp9m2an3Sc=;
 b=ZVUW4awYt74Dr8dFQVE7VeDOXjgw8AJDP2P6432betuLUQUJ9ongNAJouUAYyRjOag
 8SZaGVctMK+L1nS4901IcxnWSo347gmYPATjy3z6s1ePCC8OEIjGeyazwfDVj0aUPkq8
 L4xXmgWyRvzZZo8oDfuMZaBbc4zmzXjAzDC+RP/1n9/QPJB6JCnxS7gdFuUmXK/Fwmdw
 urLB4R+Z3rRWIGEf+sfucAjEfX3Xse5mnQVa7H2vDEI9gqkBaVNz4sBMRsvwW0R1hm40
 zpr3q0rneOdEs3q6u6s9czj12uXN3K6wBBmbk65/3LTGjuQFTRnKm5aLTlS2FwxdtSjo
 Gekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261405; x=1738866205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fT9psFAWJPNLFoqhflxpXdULv7n4FREA8vp9m2an3Sc=;
 b=vqdIZHU+cVjp49bcqX4o3l82sWoMPbqXnCB/lJtmcYG+Z4hJ8YggAgJBaZa5aGW6bq
 6anBLAzIHdif8gvwDspumuoC/g6fbL+IAARwQJpSMOkHLTIB2xiXcCm5hLy/ZNsW0CIT
 fpDpfRCe2GyDEP+7ju593c7AOccjy5dIb8w1uLNCRrgSK3/Ame9EgZm3dJeSHBY55jkA
 Vsr5djXv+eQ4+oFY3AyEjFg93znWLMkTtlHApTQQ9DNLI/bVORcQMe9QgJtLOWLUXm8h
 Y4/61+krxah5ZBFLLdr3STNK8MHtW01obr9am9+cOtKGO5AZZU1SCgrPAh5nOwB2y87s
 b5Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh5atGkl8YpbVf/42dfYbpMj6l2Vvqxc9pB4KSS33hVdWtganEtiB8iYN5/lu3hI6cjYNsqCqbYrKV@nongnu.org
X-Gm-Message-State: AOJu0YwbciKA8NFuw5Syh87dAx5VDIFKJn7BYIcbD8bCZXyWrO1RSP6a
 zja1LLgZE1vzgnb3hp0p8WGktEeNjhFUUoJRKmz9fOpSklHsaVpEonjhmD5Egnk=
X-Gm-Gg: ASbGncvdqLmpAOnArFoOJo00Sj6uwdNFTckvDVK8IRBYrth8BxV9McJApodWuTY2XaC
 jd35hugxTz1dV2octjSvLTdBJMn4ymJXthTlanw+/qr/o8TjP3Lcq4L3ULAN12W8zSOCQHdcRcR
 eLU0wTKcChCDb7XR/DdSxuMeUQKgHe24z4LoCa9K8VwKB4mQiXl6Q0l5zm1T7Xjk5wN3EKg3tw9
 ZVZWd1eLEislt+5vM6WzEL7gyYmt/ktfk+DFzS+f0Z0beZp+TTOGfX0qKk7yg8fxNJp5veBYh8j
 igR1kSmqofQTeM8u7hz7MQ==
X-Google-Smtp-Source: AGHT+IHJ9OXse4dtVnUIniM47I4sjE8neBgEI/7d89xl0XSPiLCpUvOtYoeHha5fARQbxodmuAolDA==
X-Received: by 2002:a5d:4348:0:b0:386:3e3c:ef1 with SMTP id
 ffacd0b85a97d-38c51e91b5emr7031841f8f.35.1738261404931; 
 Thu, 30 Jan 2025 10:23:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:24 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 13/14] target/arm: Rename CP_ACCESS_TRAP_UNCATEGORIZED to
 CP_ACCESS_UNDEFINED
Date: Thu, 30 Jan 2025 18:23:08 +0000
Message-Id: <20250130182309.717346-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

CP_ACCESS_TRAP_UNCATEGORIZED is technically an accurate description
of what this return value from a cpreg accessfn does, but it's liable
to confusion because it doesn't match how the Arm ARM pseudocode
indicates this case. What it does is an EXCP_UDEF with a zero
("uncategorized") syndrome value, which is what an UNDEFINED instruction
does. The pseudocode uses "UNDEFINED" to show this; rename our
constant to CP_ACCESS_UNDEFINED to make the parallel clearer.

Commit created with
sed -i -e 's/CP_ACCESS_TRAP_UNCATEGORIZED/CP_ACCESS_UNDEFINED/' $(git grep -l CP_ACCESS_TRAP_UNCATEGORIZED)

plus manual editing of the comment.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h        |  5 +++--
 target/arm/helper.c        | 30 +++++++++++++++---------------
 target/arm/tcg/op_helper.c |  6 +++---
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index fb3b84baa1e..52377c6eb50 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -337,13 +337,14 @@ typedef enum CPAccessResult {
     CP_ACCESS_TRAP_EL3 = CP_ACCESS_TRAP_BIT | 3,
 
     /*
-     * Access fails and results in an exception syndrome 0x0 ("uncategorized").
+     * Access fails with UNDEFINED, i.e. an exception syndrome 0x0
+     * ("uncategorized"), which is what an undefined insn produces.
      * Note that this is not a catch-all case -- the set of cases which may
      * result in this failure is specifically defined by the architecture.
      * This trap is always to the usual target EL, never directly to a
      * specified target EL.
      */
-    CP_ACCESS_TRAP_UNCATEGORIZED = (2 << 2),
+    CP_ACCESS_UNDEFINED = (2 << 2),
 } CPAccessResult;
 
 /* Indexes into fgt_read[] */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d1e26ec9d06..1fee8fae127 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -285,7 +285,7 @@ static CPAccessResult access_el3_aa32ns(CPUARMState *env,
 {
     if (!is_a64(env) && arm_current_el(env) == 3 &&
         arm_is_secure_below_el3(env)) {
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
     return CP_ACCESS_OK;
 }
@@ -310,7 +310,7 @@ static CPAccessResult access_trap_aa32s_el1(CPUARMState *env,
         return CP_ACCESS_TRAP_EL3;
     }
     /* This will be EL1 NS and EL2 NS, which just UNDEF */
-    return CP_ACCESS_TRAP_UNCATEGORIZED;
+    return CP_ACCESS_UNDEFINED;
 }
 
 /*
@@ -2246,7 +2246,7 @@ static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
         if (!isread && ri->state == ARM_CP_STATE_AA32 &&
             arm_is_secure_below_el3(env)) {
             /* Accesses from 32-bit Secure EL1 UNDEF (*not* trap to EL3!) */
-            return CP_ACCESS_TRAP_UNCATEGORIZED;
+            return CP_ACCESS_UNDEFINED;
         }
         break;
     case 2:
@@ -2255,7 +2255,7 @@ static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 
     if (!isread && el < arm_highest_el(env)) {
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
 
     return CP_ACCESS_OK;
@@ -2385,7 +2385,7 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
     switch (arm_current_el(env)) {
     case 1:
         if (!arm_is_secure(env)) {
-            return CP_ACCESS_TRAP_UNCATEGORIZED;
+            return CP_ACCESS_UNDEFINED;
         }
         if (!(env->cp15.scr_el3 & SCR_ST)) {
             return CP_ACCESS_TRAP_EL3;
@@ -2393,7 +2393,7 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
         return CP_ACCESS_OK;
     case 0:
     case 2:
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     case 3:
         return CP_ACCESS_OK;
     default:
@@ -3304,7 +3304,7 @@ static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
                 }
                 return CP_ACCESS_TRAP_EL3;
             }
-            return CP_ACCESS_TRAP_UNCATEGORIZED;
+            return CP_ACCESS_UNDEFINED;
         }
     }
     return CP_ACCESS_OK;
@@ -3601,7 +3601,7 @@ static CPAccessResult at_e012_access(CPUARMState *env, const ARMCPRegInfo *ri,
      * scr_write() ensures that the NSE bit is not set otherwise.
      */
     if ((env->cp15.scr_el3 & (SCR_NSE | SCR_NS)) == SCR_NSE) {
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
     return CP_ACCESS_OK;
 }
@@ -3611,7 +3611,7 @@ static CPAccessResult at_s1e2_access(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     if (arm_current_el(env) == 3 &&
         !(env->cp15.scr_el3 & (SCR_NS | SCR_EEL2))) {
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
     return at_e012_access(env, ri, isread);
 }
@@ -4684,7 +4684,7 @@ static CPAccessResult sp_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
          * Access to SP_EL0 is undefined if it's being used as
          * the stack pointer.
          */
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
     return CP_ACCESS_OK;
 }
@@ -5674,7 +5674,7 @@ static CPAccessResult sel2_access(CPUARMState *env, const ARMCPRegInfo *ri,
     if (arm_current_el(env) == 3 || arm_is_secure_below_el3(env)) {
         return CP_ACCESS_OK;
     }
-    return CP_ACCESS_TRAP_UNCATEGORIZED;
+    return CP_ACCESS_UNDEFINED;
 }
 
 static const ARMCPRegInfo el2_sec_cp_reginfo[] = {
@@ -5710,7 +5710,7 @@ static CPAccessResult nsacr_access(CPUARMState *env, const ARMCPRegInfo *ri,
     if (isread) {
         return CP_ACCESS_OK;
     }
-    return CP_ACCESS_TRAP_UNCATEGORIZED;
+    return CP_ACCESS_UNDEFINED;
 }
 
 static const ARMCPRegInfo el3_cp_reginfo[] = {
@@ -5798,7 +5798,7 @@ static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
         return CP_ACCESS_OK;
     }
     if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
     return CP_ACCESS_OK;
 }
@@ -5896,7 +5896,7 @@ static CPAccessResult el2_e2h_e12_access(CPUARMState *env,
     }
     /* FOO_EL12 aliases only exist when E2H is 1; otherwise they UNDEF */
     if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
     if (ri->orig_accessfn) {
         return ri->orig_accessfn(env, ri->opaque, isread);
@@ -6751,7 +6751,7 @@ static CPAccessResult access_lor_other(CPUARMState *env,
 {
     if (arm_is_secure_below_el3(env)) {
         /* UNDEF if SCR_EL3.NS == 0 */
-        return CP_ACCESS_TRAP_UNCATEGORIZED;
+        return CP_ACCESS_UNDEFINED;
     }
     return access_lor_ns(env, ri, isread);
 }
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index fcee11e29ad..2230351a8f4 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -764,7 +764,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
 
     if (arm_feature(env, ARM_FEATURE_XSCALE) && ri->cp < 14
         && extract32(env->cp15.c15_cpar, ri->cp, 1) == 0) {
-        res = CP_ACCESS_TRAP_UNCATEGORIZED;
+        res = CP_ACCESS_UNDEFINED;
         goto fail;
     }
 
@@ -869,8 +869,8 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
     case CP_ACCESS_TRAP_EL2:
     case CP_ACCESS_TRAP_EL1:
         break;
-    case CP_ACCESS_TRAP_UNCATEGORIZED:
-        /* CP_ACCESS_TRAP_UNCATEGORIZED is never direct to a specified EL */
+    case CP_ACCESS_UNDEFINED:
+        /* CP_ACCESS_UNDEFINED is never direct to a specified EL */
         if (cpu_isar_feature(aa64_ids, cpu) && isread &&
             arm_cpreg_in_idspace(ri)) {
             /*
-- 
2.34.1


