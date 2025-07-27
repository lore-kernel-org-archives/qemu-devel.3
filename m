Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94498C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwLv-0005O6-Nx; Sun, 27 Jul 2025 04:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLc-00053l-TV
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:09 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLa-000425-Cc
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-23fd04416f3so5932055ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603385; x=1754208185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vhk3SKdWV5kBlg0P0w9+ddrIGjowa1smEMmdzbTEdqI=;
 b=ZyelX6RMi+Z7k6s/pzMI4m0XO/5ez/WSiHBhhqVb/XmdHgFoLyPtBwKGhHEqzZaCL4
 QWCAqokm9aVyoCc4YKPIl8UNTxjjDkE58U/mVMZayg5gGSMH0ECqys+q6krUaEmlxbcE
 2Db6FHb+UV0HLVsZZe5ratpL6JtFHxWRDtQbbErCd6LgBuoa8eNMyv+nfOHzaYZktb43
 RA8hsIz8wZtiIu7ImoiScevtIKIjbnp/3YJoKy0WD+O2BS74Na+p+t26SSaHLwIrOGU4
 Bihc6OkGUDyfDDGDW6p+PnixSE8Nur/iNRfgag8VoLaQt7a4JU0gJzrP9sAoDJ+INA+c
 srVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603385; x=1754208185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vhk3SKdWV5kBlg0P0w9+ddrIGjowa1smEMmdzbTEdqI=;
 b=IsYhXdhKEaRlMElc6zn+XicIH7/13LdFfEEwNc4cl7Zo4l94iGE8bPh/x20aJ1nvrN
 sdHe6lQMDaQ74oDzMYOCOTGHpSqA2pUE5k3kxoGACJu9ik2E/XOIHpiA8mRNl1T/EzPA
 rElITuD4Dc61EtoXlbvkhwHRs0QjwpC/W1rYMtByewDQQswYrBKlv4Jv+86SqQ6t4CoI
 +s1Tvv2n1vgUtsTvhvHimdHBWo6qlV0BPiJucFO+77QMnH7MoQhnkNBGhRLJzS+5Y9hL
 snZt8TVuW108ySKBFS1MEsbNI6Cq6vNXL938w8whx+kKOs0s7Leums5iSCOW8xjldkvX
 y+Gg==
X-Gm-Message-State: AOJu0YxVDoY6iKCIedveqZ6NxYDIOMNk1I3fZtpvszOw69D6pUYrRByh
 PUS+TjnLrfhYww7pDb5dbt15WSJgLL8l2g7vLNyZT98Z9897Vxah5+wMHMpf2LAhJ7KAK9lyU6Y
 L7CpY
X-Gm-Gg: ASbGncuwtImdEdP67Ms7XjQnsihO/RaaAepq9ydQQTfXc3wjsG7o3SHdMnmE9lhJYJI
 FafmZUHifkCj5nNeGORw3aSQgYaBA3f/z1I4rcuoyGuK28OhtmkW74ieM5DXNnezqCpDQX+/PXb
 50MAr5HIbwTyCrqdTHvsJaLqUFUA2Wf2S2umFd70qS60JFOzTWhq3jK6gjnt7CnEAdDfezQQr/w
 t2c4QGVysGEUP9ke8CBxFwuPtQ1GELbz3HUrHeXEAfm9eXmVvIhoDXdjjscLNqytibOvbcNeZ+c
 FkMbyMNHjmN5POCw2y6hZ+RZ1tTJyO9oMp+OToy1D/sZMEiRu5ZzQ7pjRiq70rmk2wL+zg12gWw
 JWTTvVzUZ0PnfcoOcrBgRI5k5aSxuBS1hDckrKpr+RVm0kYjMYhKGIDoalk+32NP3KBq+3+e6j4
 8z9T65Ie5Npg==
X-Google-Smtp-Source: AGHT+IEW/dI9vmkRP6/O8G4nox8m73DPhhLJw/wlK7STLwx8XdBXNfPiJNtEGDDSSXawLdQxFStjuw==
X-Received: by 2002:a17:902:d486:b0:232:59b:5923 with SMTP id
 d9443c01a7336-23fb2bc7d33mr125700505ad.23.1753603385066; 
 Sun, 27 Jul 2025 01:03:05 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 06/82] target/arm: Add prot_check parameter to do_ats_write
Date: Sat, 26 Jul 2025 22:01:38 -1000
Message-ID: <20250727080254.83840-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Separate protection check from access type, in preparation
for skipping the protection check altogether.

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


