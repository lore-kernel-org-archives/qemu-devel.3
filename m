Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EB9CAC59B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWcj-000841-TK; Tue, 16 Sep 2025 10:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWan-0006BJ-00
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:37 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaT-0008Kt-T9
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:30 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-266914a33e5so19070905ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032574; x=1758637374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+cDd0rpWkjqN5+UU6HiV2AKYtyY8iLBJsZP1HDZm9w=;
 b=YfU+UZG6xWFH4wGtrvTdi+KRjewofUM8/0gDHZdXOC1d+tN6cN+9cW25ap44B8K7MH
 /6HGk6v2/okveLlgv+P6yd7K/czD1RYqjebVAvrVSlSJ4S5WAzD/gTuSih7Jnhcu5nWX
 jVUfhnrPucIqP4tuF2sVH4TwmrAIoIkhH3rRJt4METiiDEsxn3bvyutn7p2PrSSYwgmY
 25JCqDHFYJq5niKsWvouKs3cfyIUG+CjBHmbvf1ILRSYkYset6PzfHKyoAO6VRM0WU3A
 r5N2AbP0T5Q9m3r62Y56ydFTMmWq+XuuM55NR030csF8kAv9yzyuHd9nU/Gs0ArrVJOe
 n6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032574; x=1758637374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+cDd0rpWkjqN5+UU6HiV2AKYtyY8iLBJsZP1HDZm9w=;
 b=qL5tv+KFEMqoIvF5STquShG6fF5Ry7aEVwgvaokaOPm0/quGi8pCvwaFWCWYSXi6JO
 P3OT0SNM3kDxOatBhXtoxXYimI9CDbBWSkSP7RFl23Tr7n2/VzlQoJiPr6w7Wg3wWHbU
 NYoa58md6lPGT3lAi4/L4Pun9EWzEdOxAayChwnUD4gXUmwRAxW4ry2s2EhagwsbtnSW
 5Bt1Sw4FsCYay7gjEGqGt/pzAeAQQA7LJzaQiE5M+s227Vb/sz6+C6zO6rm2UtQq6bP8
 ftofQ6B1Sh7VJd0PYUiNCFtq3jrTVYkDmDjC29e8QrD8d3DTmKaxXqSVqPfztXy7GdFb
 zNqg==
X-Gm-Message-State: AOJu0YymUK4Jz+0RU9Kjf+tIsU1G3M4NHddWsq0QmOE8Q+MJRO4XOAkC
 L4ffJwgAEoHlCrDKJueivA4P2yoKH48Kbvfb26V5lPYR8k7b+gVPswHBNbxspXT+Tzmjdz9pwLq
 mTdAO
X-Gm-Gg: ASbGncuZFQhv18aEZC1vCgtmOvBK3zZVbcxMj56HL7W5UWnP1FJTb3YmdISfG5VGjMP
 AgVj/mu4iocZ6p/tU0yK36uVKMkZBINTmbkgWnHyNJ0rS5363HhCSE/fg/BSFt6lge0Dzb0P1EP
 6gfGAvobEHa7etrx+xmRkgZ/cpMnXGJpphNNiFj9WqJAGBkyJDVQQka6Z5bQ0SbEtauyTDq8jKl
 9wox9FsPYcGFlGoPng1ORziYfluu6GNi1YNP68S6rP+lQVbgIbwyGYvO7tOPMpsuONZBTvSsZfD
 5EyVgxgOutvbsIvqpkq9I95lVRDN02EaHAxeBtBgQpW4qIBJ59DheL2Ypp7sMP8eE3OJVyZjYmi
 CJ3lm/jp5cfTM3rZnD84knfJs2A1+mciZMYNuPZs=
X-Google-Smtp-Source: AGHT+IHg4ng8qcN21owDztk6+LO+SGv6zByq5GflZQZ7mFGZmmXA4d8rnjUG1pYqQR745Il+1bDvUQ==
X-Received: by 2002:a17:903:1b46:b0:250:1c22:e7b with SMTP id
 d9443c01a7336-25d27c21e98mr204870405ad.43.1758032573987; 
 Tue, 16 Sep 2025 07:22:53 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 18/36] target/arm: Remove cp argument to ENCODE_AA64_CP_REG
Date: Tue, 16 Sep 2025 07:22:19 -0700
Message-ID: <20250916142238.664316-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

All invocations were required to pass the same value,
CP_REG_ARM64_SYSREG_CP.  Bake that in to the result directly.
Remove CP_REG_ARM64_SYSREG_CP as unused.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  5 ++---
 target/arm/kvm-consts.h        |  3 ---
 target/arm/helper.c            | 11 +++++------
 target/arm/hvf/hvf.c           |  3 +--
 target/arm/tcg/translate-a64.c |  6 ++----
 5 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 7ebe404163..95b0b9c78e 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -187,9 +187,8 @@ enum {
      ((is64) << CP_REG_AA32_64BIT_SHIFT) |                  \
      ((cp) << 16) | ((crn) << 11) | ((crm) << 7) | ((opc1) << 3) | (opc2))
 
-#define ENCODE_AA64_CP_REG(cp, crn, crm, op0, op1, op2) \
-    (CP_REG_AA64_MASK |                                 \
-     ((cp) << CP_REG_ARM_COPROC_SHIFT) |                \
+#define ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2) \
+    (CP_REG_AA64_MASK | CP_REG_ARM64_SYSREG |           \
      ((op0) << CP_REG_ARM64_SYSREG_OP0_SHIFT) |         \
      ((op1) << CP_REG_ARM64_SYSREG_OP1_SHIFT) |         \
      ((crn) << CP_REG_ARM64_SYSREG_CRN_SHIFT) |         \
diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index fdb305eea1..54ae5da7ce 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -160,9 +160,6 @@ MISMATCH_CHECK(QEMU_KVM_ARM_TARGET_CORTEX_A53, KVM_ARM_TARGET_CORTEX_A53);
 #define CP_REG_ARM64_SYSREG_OP2_MASK   0x0000000000000007
 #define CP_REG_ARM64_SYSREG_OP2_SHIFT  0
 
-/* No kernel define but it's useful to QEMU */
-#define CP_REG_ARM64_SYSREG_CP (CP_REG_ARM64_SYSREG >> CP_REG_ARM_COPROC_SHIFT)
-
 MISMATCH_CHECK(CP_REG_ARM64, KVM_REG_ARM64);
 MISMATCH_CHECK(CP_REG_ARM_COPROC_MASK, KVM_REG_ARM_COPROC_MASK);
 MISMATCH_CHECK(CP_REG_ARM_COPROC_SHIFT, KVM_REG_ARM_COPROC_SHIFT);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index cc924adbc7..7094b63f82 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4542,7 +4542,7 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
     };
 
 #define K(op0, op1, crn, crm, op2) \
-    ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2)
+    ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2)
 
     static const struct E2HAlias aliases[] = {
         { K(3, 0,  1, 0, 0), K(3, 4,  1, 0, 0), K(3, 5, 1, 0, 0),
@@ -7451,10 +7451,9 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
          * in their AArch64 view (the .cp value may be non-zero for the
          * benefit of the AArch32 view).
          */
-        if (cp == 0 || r->state == ARM_CP_STATE_BOTH) {
-            cp = CP_REG_ARM64_SYSREG_CP;
-        }
-        key = ENCODE_AA64_CP_REG(cp, r->crn, crm, r->opc0, opc1, opc2);
+        assert(cp == 0 || r->state == ARM_CP_STATE_BOTH);
+        cp = 0;
+        key = ENCODE_AA64_CP_REG(r->crn, crm, r->opc0, opc1, opc2);
         break;
     default:
         g_assert_not_reached();
@@ -7679,7 +7678,7 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
         }
         break;
     case ARM_CP_STATE_AA64:
-        assert(r->cp == 0 || r->cp == CP_REG_ARM64_SYSREG_CP);
+        assert(r->cp == 0);
         break;
     default:
         g_assert_not_reached();
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 694584cc13..6e67d89163 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1124,8 +1124,7 @@ static bool is_id_sysreg(uint32_t reg)
 
 static uint32_t hvf_reg2cp_reg(uint32_t reg)
 {
-    return ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP,
-                              (reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
+    return ENCODE_AA64_CP_REG((reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
                               (reg >> SYSREG_CRM_SHIFT) & SYSREG_CRM_MASK,
                               (reg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK,
                               (reg >> SYSREG_OP1_SHIFT) & SYSREG_OP1_MASK,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 37bedc3780..a560ef0f42 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2466,8 +2466,7 @@ static void handle_sys(DisasContext *s, bool isread,
                        unsigned int op0, unsigned int op1, unsigned int op2,
                        unsigned int crn, unsigned int crm, unsigned int rt)
 {
-    uint32_t key = ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP,
-                                      crn, crm, op0, op1, op2);
+    uint32_t key = ENCODE_AA64_CP_REG(crn, crm, op0, op1, op2);
     const ARMCPRegInfo *ri = get_arm_cp_reginfo(s->cp_regs, key);
     bool need_exit_tb = false;
     bool nv_trap_to_el2 = false;
@@ -2603,8 +2602,7 @@ static void handle_sys(DisasContext *s, bool isread,
          * We don't use the EL1 register's access function, and
          * fine-grained-traps on EL1 also do not apply here.
          */
-        key = ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP,
-                                 crn, crm, op0, 0, op2);
+        key = ENCODE_AA64_CP_REG(crn, crm, op0, 0, op2);
         ri = get_arm_cp_reginfo(s->cp_regs, key);
         assert(ri);
         assert(cp_access_ok(s->current_el, ri, isread));
-- 
2.43.0


