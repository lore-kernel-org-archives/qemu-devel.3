Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D36CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWbW-0006l2-7z; Tue, 16 Sep 2025 10:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaZ-0005wx-LF
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:23 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaT-0008M5-O2
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:23 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-267f0fe72a1so2622805ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032577; x=1758637377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=izULxd/xPJJeJxDcsNdLsFI/0M1j8/7oFIq6UaqJp58=;
 b=xE3c/8hVc0znAzW5TNDIZmEE5udrBoMeXcoLsOyeR0ksqoXe3FV4ET/46MLYJO2VX3
 pKbkYhRxHx07MBQjmtWFALQl+mgMn6CX5pz1LCkQPMxvFaeFaG0MgIzbak5y/f3hmLpf
 4dmlJ8xl3vO3QtJKy4dgFWd82qyopvNxH/e6k8045KFmNVy5IrcEP/I4cOqyfvIft1ja
 +N4krz7g4MYTdWwBFCe1b36VbiKFpScD1YtijIHS8lC2ykTqcqyN68y6rcZDJd5W2k7p
 b8JZ81ZZ7RE+f6SV5eoN+7MxyHddrsHiB/VoRIgwByIHVoBi1OeW8N/1e/Cge/vjj8TB
 3Puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032577; x=1758637377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=izULxd/xPJJeJxDcsNdLsFI/0M1j8/7oFIq6UaqJp58=;
 b=sUOaYac34QzA/sZeAFg+nTiAQBuyTGWY9xKzOKZKXMmBEvkxmfSlEUAV2wlj9EgxSp
 w59lK3bFBH79B49SiDKLK9y7F7TPRtKBPrjkeJZuCfvxNIQ2/EkRYrD49iA1KyxBeWws
 abY/GsH/iHcd5Mg1ucCnGhor56hu3ngL4RwUv4h/908/xmIBzGHisNF9XdCcXxWBwnw0
 We2oasOzhA6IjiSeQ3PMB6CmND1PG/ii8KA2BMgLtIdl76xhDW7vugEhtPqXBuD1OvIg
 1pNJrJon/wgqjBEWQZHTwfdBbui15ZP6kwzA5sNaQ+adbzomZhGZ3EYP2hKCmzmWmL8v
 MC3g==
X-Gm-Message-State: AOJu0Yyk+oPIetQ+dtNwSWuRKniW0mJqqKc+IduKHObg8UUz5va6f/4l
 tyTeiBNVR0Lh1x58UzvyvMeF1V2YwQfGN6DL4JREa2zmbPA1Kj/WZSDrUuCvW4UgN9dsQ9u/Y+L
 ANHi2
X-Gm-Gg: ASbGncs6fkPYnUjz9oBZd+AHY0jJMEgp3QqJDQPEFP+PjjhpBUsQajx22E6zUCDGsYb
 V3afZoPiykvbIouskVav4084v9I6l33u0QmM80iYHiVhu1FY9D6tjfbTDsQcdXHQOaeRm5YFPSi
 eWk8ghzXJ4bWL5rlFYxW6I0hzcpdC/FBOymP8LbHR2JM5ZsgyJANeAJUG6T2ZCxxji9IjPwEKGA
 LahIVCb4/jmL01ad5BNe88VJYgbpW0h8D6ncT9NXomZ0bSL+nTMVhh8SniDVebui2wgRZTnmmXu
 EAW9/FXKy2DXvmIl2EbchPhmjFgrFw+kr8ioXXu7CNxgWnalBXNzrERncsjNAD8hHSlSD8qmR2r
 mR4auI+NLlluH3uVXNm279GkP1LgK
X-Google-Smtp-Source: AGHT+IFiZ0et+wGkypTtaLHsvfFfy4cXl0yQB4YrPuEz2PqUthSF2q8whtiF+RGsrr+SYyCw9PN5Qg==
X-Received: by 2002:a17:903:32ca:b0:267:f4e4:e4df with SMTP id
 d9443c01a7336-267f4e4e671mr10240255ad.57.1758032577380; 
 Tue, 16 Sep 2025 07:22:57 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 23/36] target/arm: Move cpreg elimination to
 define_one_arm_cp_reg
Date: Tue, 16 Sep 2025 07:22:24 -0700
Message-ID: <20250916142238.664316-24-richard.henderson@linaro.org>
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

Eliminate unused registers earlier, so that by the time we
arrive in add_cpreg_to_hashtable we never skip.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 123 +++++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 59 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0eedbacc2b..4a109a113d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7432,7 +7432,6 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     bool is64 = r->type & ARM_CP_64BIT;
     bool ns = secstate & ARM_CP_SECSTATE_NS;
     size_t name_len;
-    bool make_const;
 
     switch (state) {
     case ARM_CP_STATE_AA32:
@@ -7453,32 +7452,6 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
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
@@ -7496,38 +7469,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
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
@@ -7692,6 +7634,8 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
     int opc2min = (r->opc2 == CP_ANY) ? 0 : r->opc2;
     int opc2max = (r->opc2 == CP_ANY) ? 7 : r->opc2;
     int cp = r->cp;
+    ARMCPRegInfo r_const;
+    CPUARMState *env = &cpu->env;
 
     /*
      * AArch64 regs are all 64 bit so ARM_CP_64BIT is meaningless.
@@ -7797,6 +7741,67 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
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


