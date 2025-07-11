Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D853C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 22:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaMbk-0002zg-5T; Fri, 11 Jul 2025 18:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYu-0007cq-H9
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:53 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaMYa-0008UI-A7
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 18:49:31 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-73d0152369fso352497a34.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 15:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752274166; x=1752878966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=STWIYU9G50oq6+fT8dxvuAWf3Y81wJSGWcY0ZHxvSjQ=;
 b=aKV+u656HDtopq5iVFZtkl3lAlJ7YMiVjeE22rS25H/qbF9qfmYX29cbUx9P6fAlJp
 SrNB+BUM8L5ijRBD/9+Y/VKtx3+gsxjz+uEfRC26ed03JuZctyXMtC8y1g9evG6rNXUY
 9oSOYFQxvx0pJceIZWlqwJ7KB29rMy4t+OFor6M5hl7G5gU6m/R0FFecsAX9Qsl8BtFM
 UMpTH5UiSj8WIyhjKxrh2Nll4Or+gFUiFxhbjUoiUyECmRX5RvHMScs8GlKla3W6geSw
 txoIiAswUI0e+iAdMFAT1BJcqvJTDPAcPJ+IUuZbAo/wLIMqH3gjSPLJVrB2HhvaDE8C
 2tYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752274166; x=1752878966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=STWIYU9G50oq6+fT8dxvuAWf3Y81wJSGWcY0ZHxvSjQ=;
 b=JrPYcbWRfny1UfH2rC6uRGSRWUnBv4oX1m1/Hfi8Ec5WYo49TTwOan7rmBdjcdnrAV
 2RNaqJuFcE1+EldINEpGlxTPEm4R6DFiTcZVr6e6HDGCnMUgzAMsAkQTUcSdFjHWzKfg
 /WxbUPX0iN8HlXnk+R/WIJEJTrpOouFJoKDwSe9xar11d2muP2R14DHL1Ai4jlRhJ9B9
 gzbE4+J9TmYAar4OmS/Z3OGkeEGFHCxYjuhQJ72kfsokWOmoIcMWJdAExtV1r9ZlgojX
 bJhsyPlHkLDSjU4CQflqDgorNwXnpSNSwsZxHYUsamE2h9Fda29RuTcfXfIAm3yG3IZD
 P42w==
X-Gm-Message-State: AOJu0YxZJMCTvUnQKt1+g8xGpfgqrr/pR2eSphuZvAPrvkk0tOyK+9BD
 dgrzIDmRIriKZW5523VihDoXOz1F5GcZmbqmg4+0Ns+wk38gDQ3iiJhQ1Oo09+fcz4cSXECyOi3
 cm81+kVE=
X-Gm-Gg: ASbGncvGIrf52X8KxGgJZOGm+eO0NHJQ12iZF8+8CcOmLPnEe0ozi1c3NCY57kHIA91
 IAG7M357TgPjnIK3Pc6JWflebPNRiiApvqUmQhb1aruUjKkJ3eNnkF+2SXdzWBX3pjf37X1zWnv
 tR0DqnyMs0Oh9yEkwA5Da0+bs9U/YW/roR8a2d8WXoM4UdkNFTzrJdG15bmkG3XTS/u+HvVi3xA
 qQzSLnm2R8UaLZ4loTf+qzu+3THhp2DIoSOqoC6auMAFgh0leXKgclHZ3NFD3HLJBNZKQI3LngC
 yzSmA0NA8SU5j9Oap1kj5+MANhSgyLAueYA4u+A0QJrC4jBwGP23R7QFBCnzsGaWfa/3dpZLJFy
 pOx1lEdv2K1vpr6ywXuGSMhcW1gF5Zyp6s/fWflU755PM/aCakYyOAEg+JihYbS9LSXIZa/COYR
 NEwsVILose
X-Google-Smtp-Source: AGHT+IFA/EbfPu3L3gqXnUBGS8nca6pNF7wXeEcL84IIr+gAZ/L4j4NBXNGlSg61p6S5lP6+eBWYSg==
X-Received: by 2002:a05:6808:6c8e:b0:40a:526e:5e7a with SMTP id
 5614622812f47-415396c4933mr3617316b6e.23.1752274165635; 
 Fri, 11 Jul 2025 15:49:25 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-414197c6064sm696638b6e.20.2025.07.11.15.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 15:49:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 6/9] target/arm: Convert do_ats_write to access_perm
Date: Fri, 11 Jul 2025 16:49:12 -0600
Message-ID: <20250711224915.62369-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711224915.62369-1-richard.henderson@linaro.org>
References: <20250711224915.62369-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpregs-at.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index 2ff0b3e76f..bebf168997 100644
--- a/target/arm/tcg/cpregs-at.c
+++ b/target/arm/tcg/cpregs-at.c
@@ -24,14 +24,14 @@ static int par_el1_shareability(GetPhysAddrResult *res)
 }
 
 static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
-                             MMUAccessType access_type, ARMMMUIdx mmu_idx,
+                             unsigned prot_check, ARMMMUIdx mmu_idx,
                              ARMSecuritySpace ss)
 {
     uint64_t par64;
     bool format64 = false;
     ARMMMUFaultInfo fi = {};
     GetPhysAddrResult res = {};
-    bool ret = get_phys_addr_for_at(env, value, 1 << access_type,
+    bool ret = get_phys_addr_for_at(env, value, prot_check,
                                     mmu_idx, ss, &res, &fi);
 
     /*
@@ -191,7 +191,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
 
 static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
-    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    unsigned access_perm = ri->opc2 & 1 ? PAGE_WRITE : PAGE_READ;
     uint64_t par64;
     ARMMMUIdx mmu_idx;
     int el = arm_current_el(env);
@@ -253,7 +253,7 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         g_assert_not_reached();
     }
 
-    par64 = do_ats_write(env, value, access_type, mmu_idx, ss);
+    par64 = do_ats_write(env, value, access_perm, mmu_idx, ss);
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
 }
@@ -261,11 +261,11 @@ static void ats_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 static void ats1h_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    unsigned access_perm = ri->opc2 & 1 ? PAGE_WRITE : PAGE_READ;
     uint64_t par64;
 
     /* There is no SecureEL2 for AArch32. */
-    par64 = do_ats_write(env, value, access_type, ARMMMUIdx_E2,
+    par64 = do_ats_write(env, value, access_perm, ARMMMUIdx_E2,
                          ARMSS_NonSecure);
 
     A32_BANKED_CURRENT_REG_SET(env, par, par64);
@@ -309,7 +309,7 @@ static CPAccessResult at_s1e01_access(CPUARMState *env, const ARMCPRegInfo *ri,
 static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
-    MMUAccessType access_type = ri->opc2 & 1 ? MMU_DATA_STORE : MMU_DATA_LOAD;
+    unsigned access_perm = ri->opc2 & 1 ? PAGE_WRITE : PAGE_READ;
     ARMMMUIdx mmu_idx;
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
     bool regime_e20 = (hcr_el2 & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE);
@@ -352,7 +352,7 @@ static void ats_write64(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 
     ss = for_el3 ? arm_security_space(env) : arm_security_space_below_el3(env);
-    env->cp15.par_el[1] = do_ats_write(env, value, access_type, mmu_idx, ss);
+    env->cp15.par_el[1] = do_ats_write(env, value, access_perm, mmu_idx, ss);
 }
 
 static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.43.0


