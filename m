Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3571CAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v299n-0000Mb-8j; Fri, 26 Sep 2025 10:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298t-0007w3-Nr
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:48 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298U-0005ix-0p
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:46 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e317bc647so15092255e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895752; x=1759500552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rpIrhuYE6q9Jr9VMOg9Sf2KgkjnAL/weTQU2KUeBzTI=;
 b=UqbOlHqciwRxaTqDU3vEIA3n92i8O/O1ExG2Fam6piPnRaMPLoLtmLLRpxuo5aF4pz
 SD6dbqmbf9cThmkR2Ut1A2BG8TaSz5RBB9/kTaL9ooBwwTJ6C6XBa9wtL6pEmPX+/jxn
 yb4FKBPWjzhb8Vz1X5YkxgTJz5msQK3ycweV/jJQjOiXmzA5elwn/IMfEaI6bE80IYEV
 p8Zf1e48rkJJHUoRBvMlMeT83RPkRkHXZscwVeaoYpM50XzkiecR+MywfB+19N6uVCpR
 6nmo8jrSzA1TZugp/5zRMAX4/8BgWdDMQfVMgznZUTM57SX5zjs8ex+4H5g6/gFBfgjY
 YT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895752; x=1759500552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpIrhuYE6q9Jr9VMOg9Sf2KgkjnAL/weTQU2KUeBzTI=;
 b=gALwq9E5urB4Vt1jiSAb1sVka5BTdXleR2VJZOvi01wAa+G5gxXkMjnHWOLzf1nVY5
 RPhkx/W6lTnbzHjQiJZe5ml0/N0asyY2ay+uQ6kL5IhRRGVhAQEASpf1PlINwqtmwVJG
 z8QBTimNY2/l1XZIuxSS5AW6KF1g52e4ep8IzN2mRgV3nprsGLKuJhthxxARElIKlrJg
 tbkLcJ7r//lUdrq+kVPWQpLc83Kmm5eJHkbSP5DS/HU5ozx7jSQUm5CEc1Gk/0dwMP+z
 +HIg047N05+b01TDBqRRbX4VE0iXCTApAEyei9JiK+6pHFS925PLXfgj2Kk3zpYIKqwI
 27zg==
X-Gm-Message-State: AOJu0YwayjBNfBL50fr9pdduRjij+INawihJZ5e7dIc//01oosYPCgG1
 QoM3bpdsRX6zLGPAuRMx8Afdm+3B5oRK/eH+1hRNJQWjkWmHzIQiUM269uv2i3PPVpAAjQAt5bM
 EBq94
X-Gm-Gg: ASbGncuh8M4vW3BJkdbonNJbb+250aWrxRsm1DMqT1lWVVpkkBidtP2Urirh4q3mHbU
 4ywemmtnvV2j9BBa8erSX1yMhnK13iUXpZtIyk7MLGRy7m+VXG126Wf2fEI4QOe6XYXql8geKkC
 5pWBnICute5D6b21oZwHv1KhGGFlNovNA9TQPlXvZExN1AYu+8gKSzs5RKXsHAU1ZDKtuHXIik/
 S8VI1A9leBm+VpMbBz341Qdbwo9ehdg1PpLj9RCNQXuENbtH0fdu6mJ2GoPM57689GlKmHjaLBG
 lYeJfNtqBz9ExW8nSdac0KE9E9Wy3C/vQVVnYzH5nIcqlBD1ePXaCSmhbLxAbl0vwABkzcUy0xv
 /8TO7PGl/ob7f0/qu97upar+nxagjJbmt1cdEBXY=
X-Google-Smtp-Source: AGHT+IGMuKIrvVIeq9n+bXmy/l7Zi+XLMHBDDFAoEro8ms/iliQUlblbHdasXbg+9/MZ5QUt3hco7Q==
X-Received: by 2002:a5d:5888:0:b0:3ec:dd16:fc16 with SMTP id
 ffacd0b85a97d-40e4bd186aamr6986613f8f.43.1758895752497; 
 Fri, 26 Sep 2025 07:09:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/44] target/arm: Move cpreg elimination to
 define_one_arm_cp_reg
Date: Fri, 26 Sep 2025 15:08:25 +0100
Message-ID: <20250926140844.1493020-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Eliminate unused registers earlier, so that by the time we
arrive in add_cpreg_to_hashtable we never skip.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 123 +++++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 59 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f0e423e623b..ade16138e75 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7377,7 +7377,6 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     bool is64 = r->type & ARM_CP_64BIT;
     bool ns = secstate & ARM_CP_SECSTATE_NS;
     size_t name_len;
-    bool make_const;
 
     switch (state) {
     case ARM_CP_STATE_AA32:
@@ -7398,32 +7397,6 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
         }
     }
 
-    /*
-     * Eliminate registers that are not present because the EL is missing.
-     * Doing this here makes it easier to put all registers for a given
-     * feature into the same ARMCPRegInfo array and define them all at once.
-     */
-    make_const = false;
-    if (arm_feature(env, ARM_FEATURE_EL3)) {
-        /*
-         * An EL2 register without EL2 but with EL3 is (usually) RES0.
-         * See rule RJFFP in section D1.1.3 of DDI0487H.a.
-         */
-        int min_el = ctz32(r->access) / 2;
-        if (min_el == 2 && !arm_feature(env, ARM_FEATURE_EL2)) {
-            if (r->type & ARM_CP_EL3_NO_EL2_UNDEF) {
-                return;
-            }
-            make_const = !(r->type & ARM_CP_EL3_NO_EL2_KEEP);
-        }
-    } else {
-        CPAccessRights max_el = (arm_feature(env, ARM_FEATURE_EL2)
-                                 ? PL2_RW : PL1_RW);
-        if ((r->access & max_el) == 0) {
-            return;
-        }
-    }
-
     /* Combine cpreg and name into one allocation. */
     name_len = strlen(name) + 1;
     r2 = g_malloc(sizeof(*r2) + name_len);
@@ -7441,38 +7414,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     r2->state = state;
     r2->secure = secstate;
 
-    if (make_const) {
-        /* This should not have been a very special register to begin. */
-        int old_special = r2->type & ARM_CP_SPECIAL_MASK;
-        assert(old_special == 0 || old_special == ARM_CP_NOP);
-        /*
-         * Set the special function to CONST, retaining the other flags.
-         * This is important for e.g. ARM_CP_SVE so that we still
-         * take the SVE trap if CPTR_EL3.EZ == 0.
-         */
-        r2->type = (r2->type & ~ARM_CP_SPECIAL_MASK) | ARM_CP_CONST;
-        /*
-         * Usually, these registers become RES0, but there are a few
-         * special cases like VPIDR_EL2 which have a constant non-zero
-         * value with writes ignored.
-         */
-        if (!(r->type & ARM_CP_EL3_NO_EL2_C_NZ)) {
-            r2->resetvalue = 0;
-        }
-        /*
-         * ARM_CP_CONST has precedence, so removing the callbacks and
-         * offsets are not strictly necessary, but it is potentially
-         * less confusing to debug later.
-         */
-        r2->readfn = NULL;
-        r2->writefn = NULL;
-        r2->raw_readfn = NULL;
-        r2->raw_writefn = NULL;
-        r2->resetfn = NULL;
-        r2->fieldoffset = 0;
-        r2->bank_fieldoffsets[0] = 0;
-        r2->bank_fieldoffsets[1] = 0;
-    } else {
+    {
         bool isbanked = r->bank_fieldoffsets[0] && r->bank_fieldoffsets[1];
 
         if (isbanked) {
@@ -7637,6 +7579,8 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
     int opc2min = (r->opc2 == CP_ANY) ? 0 : r->opc2;
     int opc2max = (r->opc2 == CP_ANY) ? 7 : r->opc2;
     int cp = r->cp;
+    ARMCPRegInfo r_const;
+    CPUARMState *env = &cpu->env;
 
     /*
      * AArch64 regs are all 64 bit so ARM_CP_64BIT is meaningless.
@@ -7742,6 +7686,67 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
         }
     }
 
+    /*
+     * Eliminate registers that are not present because the EL is missing.
+     * Doing this here makes it easier to put all registers for a given
+     * feature into the same ARMCPRegInfo array and define them all at once.
+     */
+    if (arm_feature(env, ARM_FEATURE_EL3)) {
+        /*
+         * An EL2 register without EL2 but with EL3 is (usually) RES0.
+         * See rule RJFFP in section D1.1.3 of DDI0487H.a.
+         */
+        int min_el = ctz32(r->access) / 2;
+        if (min_el == 2 && !arm_feature(env, ARM_FEATURE_EL2)) {
+            if (r->type & ARM_CP_EL3_NO_EL2_UNDEF) {
+                return;
+            }
+            if (!(r->type & ARM_CP_EL3_NO_EL2_KEEP)) {
+                /* This should not have been a very special register. */
+                int old_special = r->type & ARM_CP_SPECIAL_MASK;
+                assert(old_special == 0 || old_special == ARM_CP_NOP);
+
+                r_const = *r;
+
+                /*
+                 * Set the special function to CONST, retaining the other flags.
+                 * This is important for e.g. ARM_CP_SVE so that we still
+                 * take the SVE trap if CPTR_EL3.EZ == 0.
+                 */
+                r_const.type = (r->type & ~ARM_CP_SPECIAL_MASK) | ARM_CP_CONST;
+                /*
+                 * Usually, these registers become RES0, but there are a few
+                 * special cases like VPIDR_EL2 which have a constant non-zero
+                 * value with writes ignored.
+                 */
+                if (!(r->type & ARM_CP_EL3_NO_EL2_C_NZ)) {
+                    r_const.resetvalue = 0;
+                }
+                /*
+                 * ARM_CP_CONST has precedence, so removing the callbacks and
+                 * offsets are not strictly necessary, but it is potentially
+                 * less confusing to debug later.
+                 */
+                r_const.readfn = NULL;
+                r_const.writefn = NULL;
+                r_const.raw_readfn = NULL;
+                r_const.raw_writefn = NULL;
+                r_const.resetfn = NULL;
+                r_const.fieldoffset = 0;
+                r_const.bank_fieldoffsets[0] = 0;
+                r_const.bank_fieldoffsets[1] = 0;
+
+                r = &r_const;
+            }
+        }
+    } else {
+        CPAccessRights max_el = (arm_feature(env, ARM_FEATURE_EL2)
+                                 ? PL2_RW : PL1_RW);
+        if ((r->access & max_el) == 0) {
+            return;
+        }
+    }
+
     for (int crm = crmmin; crm <= crmmax; crm++) {
         for (int opc1 = opc1min; opc1 <= opc1max; opc1++) {
             for (int opc2 = opc2min; opc2 <= opc2max; opc2++) {
-- 
2.43.0


