Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2E6C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuhe-0006IQ-HO; Thu, 10 Jul 2025 13:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZuLC-0004GY-Id
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:41:46 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uZuLA-0001AI-RU
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:41:46 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-74ad4533ac5so2033444b3a.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752165703; x=1752770503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EtG2f9WC1Atw8TQNXmdprkNhtZEEPjSXEDq2fJcwOt8=;
 b=GwPLV3Q/rZ9Cbu4lb7Yf8vjhid6+I85E60uT1f8q56ih4skErpCn3N9pIs6IaJHt9v
 HvzUIyZkYvVf+Lwn8hr7oyLQmnmyDimPQY1XyP4XMlteVMls5G9/QDlU6B8H1Ta+Bcsj
 XJmOf1PBAYpBDmyTvH/LF0O2OU652C3m7kDzIRwGmYhuhYIV4a1aSjxMrSQG1AI91LHI
 qSw7qxRo30cIpqGiSwHRmkfVe44njHxk+plfscCvJfBd0xqrMqiKVd91chkfaoanz9ln
 glWDS+afrBk3C+i1RyxsuIMu05u59NwMW7yUoxIN7G/p1Ckuv4XPhP7wzNfp6NVqbY87
 KZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752165703; x=1752770503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EtG2f9WC1Atw8TQNXmdprkNhtZEEPjSXEDq2fJcwOt8=;
 b=V+ES+i6U6wGUkJ6z75ScUGC3ZQUXLhJUqa4/fnrOE+wHTsh3sWTTcd7CHudDbZuJX9
 Ph2Z/aHrom90u+yImdh8cRfVKPWiGXS7Z9JJol9pgKOG7sn4RM4i1WpnzqVuIUr/lKsI
 oUwyhhMadqkXSOWGkS0NHeTSBbkyvCth+Qt8IJE8C/dqaC9BgT1bCHHjndGFqQB08+8z
 h53GM9L9nli8N9zQzQLCmUvnicZtQzFNJ7Hdtse4aN6i4CynasynHOtmMucSHBHRdiLz
 J8mRHh8YVbBrxisInCNSpZqbZIs2V8ErnqnD2/XqJVyNBlqoSI4KVwS2X62JTkEzvNX+
 Qxvw==
X-Gm-Message-State: AOJu0Yy1jEJBEA3y0Nhhr3sod2x/LuYjA4fN4fc917o2Ctj+7PQus4oP
 wVbJ+Fe4H1wo80WOUvuv+3/bqzyujK/U0TgyairC+pCfkXVG9nD+K12P07U5hXCfnVGApWRgH6n
 hgEL1r7E=
X-Gm-Gg: ASbGncuJG94v8IyvyGUoe19ZHzNjNSt2qTztt7DlKuXJJi0eiyFwKxkOCiAlruURQvo
 ncCSViUg9SovaQrP5sfgk1yzF9ZXPPpC+Utldgcv6JOkg0Z62Vju+5Vs5BnsQRxQQCIVKRm3sPa
 ui+25qLnR37xw+D2+MrhAg2nEhLRGBo7CWsOVeTNoGinA0p0gAYuS6GZ2UMyytWk2hNfkKH4F9q
 JTDTRUiD24d4uHXcFy04TyvA00bCydTTE/H4TUvFyk9ilH9denit5Arv/m66MaWTiEJvhrkjNqh
 KbpU/3ns3xN8Wh1tdbO8oGCBGgycvvt2TPgQMbf9zfUd9p4rkcGTuL9BUPyfstPrAy8TPLSAGLG
 ov/xfJ2lblYPF5NdnA4WADA==
X-Google-Smtp-Source: AGHT+IHn1M2Zub3MC32lkJYROXXoTEHubfXaq7lyDHdIYsD9Wee9Wfhu6jFBx47GkXNAiDl+skUzcA==
X-Received: by 2002:a05:6a20:430c:b0:215:e02f:1eb8 with SMTP id
 adf61e73a8af0-22fc38bcf9cmr6743105637.14.1752165703233; 
 Thu, 10 Jul 2025 09:41:43 -0700 (PDT)
Received: from gromero0.. (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f5c7f7sm2919119b3a.142.2025.07.10.09.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 09:41:42 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-arm@nongnu.org, richard.henderson@linaro.org, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 5/6] target/arm: Implement FEAT_MEC cache instructions
Date: Thu, 10 Jul 2025 16:38:58 +0000
Message-Id: <20250710163858.1094780-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250710163858.1094780-1-gustavo.romero@linaro.org>
References: <20250710163858.1094780-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x429.google.com
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
---
 target/arm/helper.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6f678aceeb..5aab9294bc 100644
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
@@ -9212,6 +9233,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 
     if (cpu_isar_feature(aa64_mec, cpu)) {
         define_arm_cp_regs(cpu, mec_reginfo);
+        if (cpu_isar_feature(aa64_mte, cpu)) {
+            define_arm_cp_regs(cpu, mec_mte_reginfo);
+        }
     }
 
     if (cpu_isar_feature(aa64_sctlr2, cpu)) {
-- 
2.34.1


