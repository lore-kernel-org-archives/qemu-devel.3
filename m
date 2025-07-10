Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488BEC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 21:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZyY7-0000ez-Hl; Thu, 10 Jul 2025 17:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZyXr-0000XH-DF
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 17:11:10 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZyXp-0006e0-LN
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 17:11:07 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-235e1d710d8so19661055ad.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 14:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752181864; x=1752786664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24pxxDuWEZzb6wGY252RDxtIpjDwPD+IPgiDjqz1YEk=;
 b=X1Z9YOEVJfzdFQuge4oO9eNx4hl8I7Juj7Uqr2wF1jKzo3+EOxBDoYf3Pp9ZpX3UyJ
 hhhP9LbKpKR92HGRqg0787l7uuFpUfObPGxrT2sy0VN+SNBwVV6QeyXOxswveNrEky1C
 3SI4kLy1/wkc9b7SdAp3FVWiyuu4+lW5uye3CpXMZ36ROfU1L3xabCmvkKT9glqf72Rv
 Gt0QMzAsd7T7JOkQ2dlOGUldKqTM/9KI0hNtQZkf+wNIqW/TRfwoAtZ5lm6R/F+E1HYJ
 ksZysUlEhqW+8s9QvwhYiDEgx2YrhKodmddYOwPQ9Ji0uIZpbNCSWsy03KwfDNYKegbu
 UyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752181864; x=1752786664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=24pxxDuWEZzb6wGY252RDxtIpjDwPD+IPgiDjqz1YEk=;
 b=IW8Oc/Q5jmhEDHyLksd8/9C121o/FQpeHVkq6RmpoFZS/Ux9uVbR2FfbLVgGP+E2SM
 bxZe/Y0xluQZJfVJXiCJdpooHQz34g5eFhrwC37mwCjeq8MHuAH1fA37AfKW3fsLgoHM
 XeOoQ04kxn0Pd072YF+v0wtYX8h5FoaS/PA59R3llax3YGkyTIt1zCujGFMJGu5YruDR
 qBeDmtZO1+lwUOC6yKUyXMWDOKZMt0LJG4mpBv/siuWBX0Itj83oYzhKAiwBLGDN03wb
 uUIKtqHpxxg33vCXksDjTvK2KqBtoh1H1pN4wxK9nyaK3lB+17Uk0JLfeqE/8hRcu/V7
 fVCw==
X-Gm-Message-State: AOJu0YzQEeAIMPBGGKGrtZifnIvy3SmieWShcnBZz8vCvKwyXhJy0Muf
 rTProUukA1tRjGmyjwrBkUOXbH1uHVGE2fZ9lPlktv8VA0fb7rT/WMtDW7wdfbm/xCc=
X-Gm-Gg: ASbGnctPa7hErXx+MywBEYedPQ38kR7x84ZZHcOjq8nS8ogkys0rifyn4KNhrD9KKkl
 wk94DU+raBZZ5LeFpZjj6K0tDTDdYtJvMzb4lkR+BRCWRmzSZx9cMeHSDURVtZcPhhb6vIEL/Qk
 rn+aezc0Kovobep557gzencs2ExRRdDyX04kaHPO9e3+NdIfHd9ZJj+bBPEHqK0gYxeoPPhIknb
 gRwSPTt7HryyFH5MeElxyfhsZrac5stMpRHd4wiFp9ycBbwkhhd5yfuh9X3YyiY0IUIosiKMZFB
 MtKoaL/OOK1ZRtKPG1N2rzBGNQVeJwm2r16HeCBaPA0yTA2tlJYWtwWY5GtHrFBrTNPmwAMLBOs
 us18l2bO9IWBe8DXS/67C9uT41z5UghFo/2IwBXA59BQxxhQQFrx4ut6fyg==
X-Google-Smtp-Source: AGHT+IHmpIsk/2hGSYFiR/Bc3drCbCerDeMpmxZJw04YjfLwK1jehup3Cu6ee9OVmiYhlEZfx/6Tlg==
X-Received: by 2002:a17:903:1b63:b0:235:caa8:1a72 with SMTP id
 d9443c01a7336-23dede81dc8mr9636535ad.30.1752181863928; 
 Thu, 10 Jul 2025 14:11:03 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de434d6b0sm30447775ad.203.2025.07.10.14.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 14:11:03 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 5/6] target/arm: Implement FEAT_MEC cache instructions
Date: Thu, 10 Jul 2025 21:09:40 +0000
Message-Id: <20250710210941.1098088-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710210941.1098088-1-gustavo.romero@linaro.org>
References: <20250710210941.1098088-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62e.google.com
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

This commit implements the two cache maintenance instructions introduced
by FEAT_MEC, DC CIPAE and DC CIGDPAE.

Because QEMU does not model the cache topology, all cache maintenance
instructions are implemented as NOPs, hence these new instructions are
implemented as NOPs too.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ecfd53cc5a..c030f0a0da 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6856,6 +6856,18 @@ static void mecid_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static CPAccessResult cipae_access(CPUARMState *env, const ARMCPRegInfo *ri,
+                                   bool isread)
+{
+    switch (arm_security_space(env)) {
+    case ARMSS_Root:  /* EL3 */
+    case ARMSS_Realm: /* Realm EL2 */
+        return CP_ACCESS_OK;
+    default:
+        return CP_ACCESS_UNDEFINED;
+    }
+}
+
 static const ARMCPRegInfo mec_reginfo[] = {
     { .name = "MECIDR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .opc2 = 7, .crn = 10, .crm = 8,
@@ -6895,6 +6907,15 @@ static const ARMCPRegInfo mec_reginfo[] = {
       .access = PL2_RW, .accessfn = mecid_access,
       .writefn = mecid_write,
       .fieldoffset = offsetof(CPUARMState, cp15.vmecid_a_el2) },
+    { .name = "DC_CIPAE", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 14, .opc2 = 0,
+      .access = PL2_W, .accessfn = cipae_access, .type = ARM_CP_NOP },
+};
+
+static const ARMCPRegInfo mec_mte_reginfo[] = {
+    { .name = "DC_CIGDPAE", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 4, .crn = 7, .crm = 14, .opc2 = 7,
+      .access = PL2_W, .accessfn = cipae_access, .type = ARM_CP_NOP },
 };
 
 static void define_pmu_regs(ARMCPU *cpu)
@@ -9216,6 +9237,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 
     if (cpu_isar_feature(aa64_mec, cpu)) {
         define_arm_cp_regs(cpu, mec_reginfo);
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            define_arm_cp_regs(cpu, mec_mte_reginfo);
+        }
     }
 
     if (cpu_isar_feature(aa64_sctlr2, cpu)) {
-- 
2.34.1


