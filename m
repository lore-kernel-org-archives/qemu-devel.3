Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E71C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 01:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf7Xw-0008Vz-T5; Thu, 24 Jul 2025 21:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uf7Xj-0008Ok-5i
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:48:16 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uf7Xg-0005Cb-3w
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 21:48:14 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so1391951b3a.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 18:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753408090; x=1754012890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WG/Kul4H8+j0Y0ibAl3jfG5UIT+TCusCzNUpV85n7WM=;
 b=FjOGEBnsZ281PDi16TUZKW4n8xrYwQrNmvdU+I0CNcieJie9RU58Iu+IS2PycAFpsB
 EgUGXbYKp3ok2HFdVLEkrx6ndstXHroWjfXLGf+5ahygc0H13+Uld12SA3lvDqvjGVUi
 SVHhCJNplGt2RRjOLUPRC9k+263WolMkMj0414spHmX4uEhsH0E37yoBWVeCiL8BD0Vo
 VmuCjKyhYnL5PBq+7TLTmUOJLvHvSt5iezl6DijJxGvix8djPN8p54b4oM+qvzkJmoby
 8rLthjK89dhR9Kk/cf0qXJQTqK1O1XZLEiRHIfcv+0axeQBk0sl8xkwY0HeOIJHEeBxP
 B6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753408090; x=1754012890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WG/Kul4H8+j0Y0ibAl3jfG5UIT+TCusCzNUpV85n7WM=;
 b=Df2JK80YMpm7aC+CpXbdLqLvNbzAu2RTNcwqxTDkKxJMkHBU1h+Ln55hVrFmL23SUE
 blTe25SV6lFOsLncAn+1XkseMwBZHzH73g4PWo/N98VTxWRNRBxES2xozjsotUBZbIG9
 iFubLNKeuEX5I7+NQ+Y43wTnXxaREVttaj2e6VfilXbBVK7w41eYZqXgstbCFdrNAMvW
 h0yO4YzNj6fRMaaG99ULCgR/S/h/G79PXJ6SC3ZCqfvxV+ua3UqKhrEz7boTESLPWFie
 l9ubnQVG5hJqavSuvVpLxLTijXQsFmhWqTTmehIIcfqT+zrJt1xUC+HrLnXGSrnDsWtp
 b4Gg==
X-Gm-Message-State: AOJu0YzAH9LDnSpWd3nEfdZtwW+awPPcYs2toXevRjjUZlkefJwUlJMN
 iOO5kN/tIl0a1+Mx0A1wu4xymxHASY8cU3rlpFlIvMLi2pVH35SHfhqiuNElha7NMkiS9AmgRJT
 /JUWfd6I=
X-Gm-Gg: ASbGncvYhzEhXRLC5ZfIPlbAJJ2fgzkZbOPlcKNqM5J52eZ74XLkBy/wrIxCpLi1V0P
 Qcf5/wYcag171W8WrCZqj455E3Gt/gNfoD1wWtyAxYHPMwYTAP0iELA28IyAPDSyKJMBsDVfTj1
 P6sxwkVOARyD55SKuAmL5ma/MMs9uPL/Yxv18zILEjYKwUR37m9YMt5oNf8Qtj2mf5ZJuoSo6zZ
 EF09ocbgAnRt+SGideVwCfNROX1Ic5ciUNdV754rbKWVAImTNhKsz5F6is1Z7nkY5Aoemjywv+e
 gcAAGAwTR/nXhOYRQ6DetFea91uqOKDEUAxtgbVPjl4nq2cKQHZHjDA1lNA/8KaNeNSGobfz03e
 3Dq4rofKwJux/p3cRdrw0S1Gx/2E=
X-Google-Smtp-Source: AGHT+IECvzIqbZ66dt6nCn2Nm4AX8tesdbb4NnUurVBZ3Ok2u9ScUefHytt0bsK5JEVxJs5ycooEoQ==
X-Received: by 2002:a05:6a00:464f:b0:749:112:c172 with SMTP id
 d2e1a72fcca58-763345cd65amr386538b3a.16.1753408089802; 
 Thu, 24 Jul 2025 18:48:09 -0700 (PDT)
Received: from gromero0.. ([187.75.37.236]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-761adc70799sm2662258b3a.12.2025.07.24.18.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 18:48:09 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org,
	alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH] target/arm: Clean up of register field definitions
Date: Fri, 25 Jul 2025 01:47:55 +0000
Message-Id: <20250725014755.2122579-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42c.google.com
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

Clean up the definitions of NSW and NSA fields in the VTCR register.
These two fields are already defined properly using FIELD() so they are
actually duplications. Also, define the NSW and NSA fields in the
VSTCR register using FIELD() and remove their definitions based on VTCR
fields.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 target/arm/internals.h | 8 +++-----
 target/arm/ptw.c       | 8 ++++----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index c4765e4489..052f7b641c 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -113,11 +113,6 @@ FIELD(DBGWCR, WT, 20, 1)
 FIELD(DBGWCR, MASK, 24, 5)
 FIELD(DBGWCR, SSCE, 29, 1)
 
-#define VTCR_NSW (1u << 29)
-#define VTCR_NSA (1u << 30)
-#define VSTCR_SW VTCR_NSW
-#define VSTCR_SA VTCR_NSA
-
 /* Bit definitions for CPACR (AArch32 only) */
 FIELD(CPACR, CP10, 20, 2)
 FIELD(CPACR, CP11, 22, 2)
@@ -220,6 +215,9 @@ FIELD(VTCR, NSA, 30, 1)
 FIELD(VTCR, DS, 32, 1)
 FIELD(VTCR, SL2, 33, 1)
 
+FIELD(VSTCR, SW, 29, 1)
+FIELD(VSTCR, SA, 30, 1)
+
 #define HCRX_ENAS0    (1ULL << 0)
 #define HCRX_ENALS    (1ULL << 1)
 #define HCRX_ENASR    (1ULL << 2)
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 561bf2678e..ed5c728eab 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -193,9 +193,9 @@ static ARMMMUIdx ptw_idx_for_stage_2(CPUARMState *env, ARMMMUIdx stage2idx)
         return ARMMMUIdx_Phys_Realm;
     case ARMSS_Secure:
         if (stage2idx == ARMMMUIdx_Stage2_S) {
-            s2walk_secure = !(env->cp15.vstcr_el2 & VSTCR_SW);
+            s2walk_secure = !(env->cp15.vstcr_el2 & R_VSTCR_SW_MASK);
         } else {
-            s2walk_secure = !(env->cp15.vtcr_el2 & VTCR_NSW);
+            s2walk_secure = !(env->cp15.vtcr_el2 & R_VTCR_NSW_MASK);
         }
         return s2walk_secure ? ARMMMUIdx_Phys_S : ARMMMUIdx_Phys_NS;
     default:
@@ -3372,9 +3372,9 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
      */
     if (in_space == ARMSS_Secure) {
         result->f.attrs.secure =
-            !(env->cp15.vstcr_el2 & (VSTCR_SA | VSTCR_SW))
+            !(env->cp15.vstcr_el2 & (R_VSTCR_SA_MASK | R_VSTCR_SW_MASK))
             && (ipa_secure
-                || !(env->cp15.vtcr_el2 & (VTCR_NSA | VTCR_NSW)));
+                || !(env->cp15.vtcr_el2 & (R_VTCR_NSA_MASK | R_VTCR_NSW_MASK)));
         result->f.attrs.space = arm_secure_to_space(result->f.attrs.secure);
     }
 
-- 
2.34.1


