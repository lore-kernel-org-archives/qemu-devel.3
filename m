Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28B6CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4d9-0005zo-JV; Tue, 26 Aug 2025 21:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4d0-0005P6-8y
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:07 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cg-0007Rz-1m
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:03 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-77057266cb8so2485739b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256804; x=1756861604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xm+DiQK3QPrsWhspwKpORtvyMvoqamrQ0zoWrs8mIIg=;
 b=UD76AQ8cMaHTg5s1d0d3NXo6BJRRAwlL3TehQuq+fE9+QinvRcjwiJv/g5jtFVDGiO
 CjzKFw89ZSW9PAE6Yx4cypjX/AxSS4Tl25vUgzoyuSY0lRLMwlws5SHzyd1qSKWsuIUw
 jr3xijRBUCSk1D8xBHvgbWnpYtTUax0c57Qm0nZmsR8NFjy5rKFZW04bKNNHihsUDE56
 DKyVZufDAqh731z74C7Vx0k1KrMBwRJl8oUMPa8UvxUpKjnUg+FgmTnzTk4zIIEHCWTI
 MGT5RONEQsCOqsuhgwSD10G9rRcBeUydonJ4rba6FAzbLE6+B/LZZ7sdadJMAst8QAMT
 Z9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256804; x=1756861604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xm+DiQK3QPrsWhspwKpORtvyMvoqamrQ0zoWrs8mIIg=;
 b=Td+lBRr1TSh+efE8o8jGFEFFbXEp6FZnczB0s+E5gNtS8os5PpA9lCXLec1gblLD8a
 7p7ksDn0u/26kWnSWyXu4JEOZtiaf2mrGQchM+q4nDsfkYjhb6My55yXZTcdSeyY43zt
 wbgj1j2RbeIaVQV4V2Z4y0OiqGR3rSXaNCXJgLdE2CIo5d5IgJznSRzeLRsMjEWhHGu/
 yFAtj+yKLRv9u2T6sM5JxjDuFP22Obz5/iUY9f2wVtShr7RFTAl0bYj0vP75opjGuZo7
 HrX2bbcZlyeZYZjmeysgox2UzcYnQ8xlJrei5QrIx8gdQdrEQrkvfdu2QdhAAdxd4hgl
 fwKg==
X-Gm-Message-State: AOJu0YzYrW26zXPqKO3biT1muK9EsNwPeqB30NlY8qfJRbe4mNBoekEg
 NOwdfCvvPqoJCJaZmP7S9USWdDexFY01fb0bmu+Mhuphd3//kw1I3MkKMMBSmeXV+wguZWniZ3Y
 mUYrsCKk=
X-Gm-Gg: ASbGnctjb03JJZ3oAvVAsa6WYfsUtbhkzjf+mlVm0lR66q1kCbKFDuTywzz+mtjicJd
 QPdmioQdj9jrMnNJG3PL0yAfAZLQ7mdPIfDnZOzN8P70PLRaU3nRJcQpWJt7U7vzTawNT5rZsGS
 4l8mSVCal8fq4/qfTMMZM4wo9h4OktUrVARi38Mgl5sX4jRPjDOP08eSikkDsYJTrbSihlA7ySM
 FJsAJ+Dez79zADqHIWiXEJV+nupWUGwCZFfOhY3vWuG2qE4ViyMAtwgpiR/HJnzyjoc22e4cDzz
 kW7sul2WwwnOI5JEnOb3fRYX2By6w9c+plG3kZYC349/CS9pXoqJS+tz0kJdWcVy9RBo9gmWjfq
 GmLIfyjDoT193A62N2PZQcbNWvA==
X-Google-Smtp-Source: AGHT+IFavYLkjFmtmd47RFYLz95wqtF/AITqoCSmalH++VzPT9h05R1tRUpwCLbHP1Ad/lvtP/Hd+g==
X-Received: by 2002:a05:6a00:23d1:b0:771:e1bf:bddc with SMTP id
 d2e1a72fcca58-771e1bfccbfmr13032300b3a.13.1756256804289; 
 Tue, 26 Aug 2025 18:06:44 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:06:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 19/61] target/arm: Reorder ENCODE_AA64_CP_REG arguments
Date: Wed, 27 Aug 2025 11:04:10 +1000
Message-ID: <20250827010453.4059782-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

The order of the parameters in the Arm ARM is

  op0, op1, crn, crm, op2

Reorder the arguments of ENCODE_AA64_CP_REG to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            | 2 +-
 target/arm/helper.c            | 4 ++--
 target/arm/hvf/hvf.c           | 6 +++---
 target/arm/tcg/translate-a64.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 95b0b9c78e..7bdf6cf847 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -187,7 +187,7 @@ enum {
      ((is64) << CP_REG_AA32_64BIT_SHIFT) |                  \
      ((cp) << 16) | ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
 
-#define ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2) \
+#define ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2) \
     (CP_REG_AA64_MASK | CP_REG_ARM64_SYSREG |           \
      ((op0) << CP_REG_ARM64_SYSREG_OP0_SHIFT) |         \
      ((op1) << CP_REG_ARM64_SYSREG_OP1_SHIFT) |         \
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 93cae888e2..b48b669a6a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4527,7 +4527,7 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
     };
 
 #define K(op0, op1, crn, crm, op2) \
-    ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2)
+    ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2)
 
     static const struct E2HAlias aliases[] = {
         { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
@@ -7299,7 +7299,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
          */
         assert(cp == 0 || r->state == ARM_CP_STATE_BOTH);
         cp = 0;
-        key = ENCODE_AA64_CP_REG(r->crn, crm, r->opc0, opc1, opc2);
+        key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
         break;
     default:
         g_assert_not_reached();
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index af03fc7fc1..bda57614ed 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1124,10 +1124,10 @@ static bool is_id_sysreg(uint32_t reg)
 
 static uint32_t hvf_reg2cp_reg(uint32_t reg)
 {
-    return ENCODE_AA64_CP_REG((reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
-                              (reg >> SYSREG_CRM_SHIFT) & SYSREG_CRM_MASK,
-                              (reg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK,
+    return ENCODE_AA64_CP_REG((reg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK,
                               (reg >> SYSREG_OP1_SHIFT) & SYSREG_OP1_MASK,
+                              (reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
+                              (reg >> SYSREG_CRM_SHIFT) & SYSREG_CRM_MASK,
                               (reg >> SYSREG_OP2_SHIFT) & SYSREG_OP2_MASK);
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 743c5a10e1..58303c224f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2466,7 +2466,7 @@ static void handle_sys(DisasContext *s, bool isread,
                        unsigned int op0, unsigned int op1, unsigned int op2,
                        unsigned int crn, unsigned int crm, unsigned int rt)
 {
-    uint32_t key = ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2);
+    uint32_t key = ENCODE_AA64_CP_REG(op0, op1, crn, crm, op2);
     const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
     bool need_exit_tb = false;
     bool nv_trap_to_el2 = false;
@@ -2602,7 +2602,7 @@ static void handle_sys(DisasContext *s, bool isread,
          * We don't use the EL1 register's access function, and
          * fine-grained-traps on EL1 also do not apply here.
          */
-        key = ENCODE_AA64_CP_REG(crn, crm, op0, 0, op2);
+        key = ENCODE_AA64_CP_REG(op0, 0, crn, crm, op2);
         ri = get_arm_cp_reginfo(s->cp_regs, key);
         assert(ri);
         assert(cp_access_ok(s->current_el, ri, isread));
-- 
2.43.0


