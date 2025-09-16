Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC18CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWcw-0000hU-W7; Tue, 16 Sep 2025 10:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWan-0006BR-Aj
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:37 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaU-0008Lu-SH
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:32 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b49c1c130c9so3703839a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032577; x=1758637377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzhiPXajZJRszhCyhe8mLWWa9FpDgmyenFp0rRBwLqQ=;
 b=mwNUyMLzMpJCFOJX4T2uqSQ6Dgkw371+U4aezzqI2+EmUb8aqwQYaYiws9+Sg3k146
 3HuVg47P3NibGYjEPqXW+sBu0Qq5i9zKI6ncoqACTdm0L6M76qLpCMNaMk4QEiecSvkS
 wJJ0Jasd+xRNU8RXm6W4oOtU9iiZYRfL0BgVigOG6RhmzBZzQjLkzKGyuCq128bDWc5E
 eDM92U896fNtNclJZAypXppLwX0uq34k4fd0UaNbvJbE/k3Of+fMII+k/RWCup+9hzYZ
 oyGsPfhbjc3QAq2DaBOQcefzw6gMkJPpveiGHZqgiUxQaqhF9+66qxKWP8N35Yelw0ZE
 TEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032577; x=1758637377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bzhiPXajZJRszhCyhe8mLWWa9FpDgmyenFp0rRBwLqQ=;
 b=t6rdnSZIGEGOJq7qAtS6hkgAAxTAN/y2twoVSH/opk5p5MmnhlVPYr7L+X/MHn/Dn6
 OcpGyj8PAjgovMBbG/ZHj7pB9wGnUfLoqMLfWV4BzPZegblhDG4KjCorHShevz65e3ik
 /dDco4u7wdUM/JXnd9fAXkuZEUIX3XVb3vHsYGY2zPEcQfWEIk2WSMwI6O0vHA1f1Oti
 sbBqE5itTYWwQvjhFgC2tdCHFwcSKbSpwW7iwic11LsNVtZnStVUWYn6rxWiPi3LKx/D
 SpEoJEGSOJ222Ew90/vF0SBwqtg+QNaS8FqxUi+OzQPVTlgSCL25scZY/+Hyx+H4360B
 Pysg==
X-Gm-Message-State: AOJu0YyyJIgaUvN1YZi8rpjtTyEUZ23FTvSTvtAB5BHDUQrZyyTrbCCx
 6HksoLx3QobnayZ5laFygMWiZtkJndMgGUq4/BrNhsf6tuzXF38KiSO20paUBKi2uGE0iHdiItS
 A5xF8
X-Gm-Gg: ASbGnctrHDj6eZazgxey0LJ4s7rTA9E7Tofav4mTTIRUbCVLohVWJpaNUD96x7eh49Q
 BXi+hQ3njwewNka3fdAnO7a1CeqIPG2BBUo8CfAwqOWrRos4nR5GhHRthuzYQdzboTCfQw6wm//
 TWbV+pdi112kQfQWaXlsMBpkVUR6UNZQ3on9KkGgTnE/KbMv9qhwgJZ3hK/gd8jLzLZNzTsJqB1
 VbupNldrl4aoCY/JDSbL2CGvopn2MRuM3wbWsKpGcevVsC3ss8CD9fIPxH6ocuZf4JOzPFz5+is
 u2P5DQ7m0NIzY2bewBV5Jd5kPAFeMhuATU+sajIsFdeO3d+tOQA7nPa+ROMs4UjaiJhXVxZwIOS
 KIiyz9nwAUATAB1C91STl21VID10c
X-Google-Smtp-Source: AGHT+IENfarK0YxcFSJU0siJSUN3UzZfT2Zm22mSlnTTj8nQUyl171MTi5rWdHR6/FDp6Zd0BFiHxA==
X-Received: by 2002:a17:902:cf09:b0:260:b4c7:986d with SMTP id
 d9443c01a7336-260b4c799f1mr149063525ad.36.1758032576764; 
 Tue, 16 Sep 2025 07:22:56 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 22/36] target/arm: Move cp processing to
 define_one_arm_cp_reg
Date: Tue, 16 Sep 2025 07:22:23 -0700
Message-ID: <20250916142238.664316-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

Processing of cp was split between add_cpreg_to_hashtable and
define_one_arm_cp_reg.  Unify it all to the top-level function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 53 +++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8a805695e7..0eedbacc2b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7423,7 +7423,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
  */
 static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
                                    CPState state, CPSecureState secstate,
-                                   int crm, int opc1, int opc2,
+                                   int cp, int crm, int opc1, int opc2,
                                    const char *name)
 {
     CPUARMState *env = &cpu->env;
@@ -7431,28 +7431,14 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     ARMCPRegInfo *r2;
     bool is64 = r->type & ARM_CP_64BIT;
     bool ns = secstate & ARM_CP_SECSTATE_NS;
-    int cp = r->cp;
     size_t name_len;
     bool make_const;
 
     switch (state) {
     case ARM_CP_STATE_AA32:
-        /* We assume it is a cp15 register if the .cp field is left unset. */
-        if (cp == 0 && r->state == ARM_CP_STATE_BOTH) {
-            cp = 15;
-        }
         key = ENCODE_CP_REG(cp, is64, ns, r->crn, crm, opc1, opc2);
         break;
     case ARM_CP_STATE_AA64:
-        /*
-         * To allow abbreviation of ARMCPRegInfo definitions, we treat
-         * cp == 0 as equivalent to the value for "standard guest-visible
-         * sysreg".  STATE_BOTH definitions are also always "standard sysreg"
-         * in their AArch64 view (the .cp value may be non-zero for the
-         * benefit of the AArch32 view).
-         */
-        assert(cp == 0 || r->state == ARM_CP_STATE_BOTH);
-        cp = 0;
         key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
         break;
     default:
@@ -7613,7 +7599,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
 }
 
 static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
-                                        int crm, int opc1, int opc2)
+                                        int cp, int crm, int opc1, int opc2)
 {
     /*
      * Under AArch32 CP registers can be common
@@ -7626,16 +7612,16 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
     switch (r->secure) {
     case ARM_CP_SECSTATE_S:
     case ARM_CP_SECSTATE_NS:
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
-                               r->secure, crm, opc1, opc2, r->name);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, r->secure,
+                               cp, crm, opc1, opc2, r->name);
         break;
     case ARM_CP_SECSTATE_BOTH:
         name = g_strdup_printf("%s_S", r->name);
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
-                               ARM_CP_SECSTATE_S, crm, opc1, opc2, name);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
+                               cp, crm, opc1, opc2, name);
         g_free(name);
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
-                               ARM_CP_SECSTATE_NS, crm, opc1, opc2, r->name);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_NS,
+                               cp, crm, opc1, opc2, r->name);
         break;
     default:
         g_assert_not_reached();
@@ -7666,11 +7652,11 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
             nxs_ri.fgt |= R_FGT_NXS_MASK;
         }
         add_cpreg_to_hashtable(cpu, &nxs_ri, ARM_CP_STATE_AA64,
-                               ARM_CP_SECSTATE_NS, crm, opc1, opc2, name);
+                               ARM_CP_SECSTATE_NS, 0, crm, opc1, opc2, name);
     }
 
     add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64, ARM_CP_SECSTATE_NS,
-                           crm, opc1, opc2, r->name);
+                           0, crm, opc1, opc2, r->name);
 }
 
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
@@ -7705,6 +7691,7 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
     int opc1max = (r->opc1 == CP_ANY) ? 7 : r->opc1;
     int opc2min = (r->opc2 == CP_ANY) ? 0 : r->opc2;
     int opc2max = (r->opc2 == CP_ANY) ? 7 : r->opc2;
+    int cp = r->cp;
 
     /*
      * AArch64 regs are all 64 bit so ARM_CP_64BIT is meaningless.
@@ -7727,21 +7714,25 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
      */
     switch (r->state) {
     case ARM_CP_STATE_BOTH:
-        /* 0 has a special meaning, but otherwise the same rules as AA32. */
-        if (r->cp == 0) {
+        /*
+         * If the cp field is left unset, assume cp15.
+         * Otherwise apply the same rules as AA32.
+         */
+        if (cp == 0) {
+            cp = 15;
             break;
         }
         /* fall through */
     case ARM_CP_STATE_AA32:
         if (arm_feature(&cpu->env, ARM_FEATURE_V8) &&
             !arm_feature(&cpu->env, ARM_FEATURE_M)) {
-            assert(r->cp >= 14 && r->cp <= 15);
+            assert(cp >= 14 && cp <= 15);
         } else {
-            assert(r->cp < 8 || (r->cp >= 14 && r->cp <= 15));
+            assert(cp < 8 || (cp >= 14 && cp <= 15));
         }
         break;
     case ARM_CP_STATE_AA64:
-        assert(r->cp == 0);
+        assert(cp == 0);
         break;
     default:
         g_assert_not_reached();
@@ -7811,13 +7802,13 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
             for (int opc2 = opc2min; opc2 <= opc2max; opc2++) {
                 switch (r->state) {
                 case ARM_CP_STATE_AA32:
-                    add_cpreg_to_hashtable_aa32(cpu, r, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa32(cpu, r, cp, crm, opc1, opc2);
                     break;
                 case ARM_CP_STATE_AA64:
                     add_cpreg_to_hashtable_aa64(cpu, r, crm, opc1, opc2);
                     break;
                 case ARM_CP_STATE_BOTH:
-                    add_cpreg_to_hashtable_aa32(cpu, r, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa32(cpu, r, cp, crm, opc1, opc2);
                     add_cpreg_to_hashtable_aa64(cpu, r, crm, opc1, opc2);
                     break;
                 default:
-- 
2.43.0


