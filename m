Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34DACAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v299Q-0000FN-6T; Fri, 26 Sep 2025 10:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298r-0007s9-F0
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:47 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298N-0005hu-TE
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-414f48bd785so582490f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895750; x=1759500550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0POmbfKZjptMI68V/Yj5GRhXEz6mNx19mWcRvcJN0yE=;
 b=GqfasopWOYbC/iCHV8Yp3molCkz4aCxl4Cv0NpUU5Nokey8CiWEoprgL5cZsjlZfwn
 q8rc7+jy8yf4WJclff9kPsb4FfLtVVWEdyhBShneyVz7bXhDvzmeqwOzyUkLA7A7uCzt
 kGXT7+Ib22IJoVEa8rDUh8r1d1pk05vvCWYdWjTAYLp1kq/r42Y+XizW89G3SkuO3EyJ
 ahpplL4Knnwm32CYs3OsB+G0SGmDsz348psQ+XLROOwba5G+2WtXnRiOHdFA7MfMSPVA
 Z6f8pPUEE/LrkpaJGYujgdIaizVQQf76onLDPIvyGwEtvY1DINVVXCh3DFkiTn3IGTtb
 mfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895750; x=1759500550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0POmbfKZjptMI68V/Yj5GRhXEz6mNx19mWcRvcJN0yE=;
 b=WeJ20tZUKHW7UrAOkRnCT7i+FEFDWz6B1yw2125cRJd/bXt/2asVzOAX6zranVgAK7
 ygAM0Va3qtEMfrXSFHLlgLDCUxyGwu9px0OVnaMzJ7e79o91JKdDzvlbGPR/VJjoTU/F
 N5ROca5FWi1EpQIUY82uAJ62sr5IsLMQocw1cNME1bf+yoZ8jsqyKBrbPK7n1VFkG0Wo
 TMwwSWsrd8h88sx1ket7Fnx1qMIKGztKExCHW0zCkQEv8ZXCEqsu77iivQgWTWTH4M9c
 JsgiHKD9IZqJ0YXijI/y0udttGU7alA9C2k7VDKoochp5W8kJ5xWZ6g78wFAha8Z1Pii
 rJwg==
X-Gm-Message-State: AOJu0YxZ2vD2RWGavEVRLFIZfxR7tqJg/Y3XxsbIDujsnGcrWttvu4eq
 QlD359eHacSQJnm2GtXuRat/MeSOzsPZEPL8OHEahNhhnCZ6rebTAPCIKUwbgtZLLmvfkTReAb2
 CFDdr
X-Gm-Gg: ASbGncu2xW296aOgPwdzKJ1LSMvo+OVm8fSpux6BS/XfoeZtWUeryrx3LvN6Xfh7eWe
 fUQIJjA5p880uBH4KK9pmVf+jA8jJrABm5fijpxwRDBRU0M2Yw1OKee86TmaKmA4TIpZu0VnAGL
 JYYjMo31ljiMrjUtsitFoqkFESMODXVCBSaGekqj8h3f1Nj17ZsMECIUp41T9L2KPzA7yHRMcpz
 XwMYkJNqNp50ANGLAPWcxX3PfsUHCgQo89CGuym+QxGij0kpfH9v6A8BrQR3GhvcGeUZYfHtXbX
 1pHefgBoDCFO6K1UvpKu32Yspy3IeCDy0OwbMn+H0vqrNYv8ZwBqxmCOcRAVrYA4xkp6VEBoHiZ
 TjB6O0nIkKzC7MR+6KHsPLVSrR/RV
X-Google-Smtp-Source: AGHT+IEG0RM4FOEW5MUIuY5ePxL91RklwnwqxofMc8VKLAgbbqOx5FKXZkVBPl7wL2vT6fh6eEiBDA==
X-Received: by 2002:a05:6000:18a7:b0:3e9:d0a5:e436 with SMTP id
 ffacd0b85a97d-40e437371acmr7918055f8f.23.1758895749631; 
 Fri, 26 Sep 2025 07:09:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/44] target/arm: Split out add_cpreg_to_hashtable_aa{32, 64}
Date: Fri, 26 Sep 2025 15:08:22 +0100
Message-ID: <20250926140844.1493020-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

The nesting level for the inner loop of define_one_arm_cp_reg
was overly deep.  Split out that code into two functions, for
the AArch32 and AArch64 paths separately.  Simplify the innermost
loop to a switch statement over r->state.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 147 +++++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 71 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 965941f04e5..39f5297a1a7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7557,6 +7557,66 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     g_hash_table_insert(cpu->cp_regs, (gpointer)(uintptr_t)key, r2);
 }
 
+static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
+                                        int crm, int opc1, int opc2)
+{
+    /*
+     * Under AArch32 CP registers can be common
+     * (same for secure and non-secure world) or banked.
+     */
+    char *name;
+
+    assert(!(r->type & ARM_CP_ADD_TLBI_NXS)); /* aa64 only */
+
+    switch (r->secure) {
+    case ARM_CP_SECSTATE_S:
+    case ARM_CP_SECSTATE_NS:
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
+                               r->secure, crm, opc1, opc2, r->name);
+        break;
+    case ARM_CP_SECSTATE_BOTH:
+        name = g_strdup_printf("%s_S", r->name);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
+                               ARM_CP_SECSTATE_S, crm, opc1, opc2, name);
+        g_free(name);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
+                               ARM_CP_SECSTATE_NS, crm, opc1, opc2, r->name);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
+                                        int crm, int opc1, int opc2)
+{
+    if ((r->type & ARM_CP_ADD_TLBI_NXS) &&
+        cpu_isar_feature(aa64_xs, cpu)) {
+        /*
+         * This is a TLBI insn which has an NXS variant. The
+         * NXS variant is at the same encoding except that
+         * crn is +1, and has the same behaviour except for
+         * fine-grained trapping. Add the NXS insn here and
+         * then fall through to add the normal register.
+         * add_cpreg_to_hashtable() copies the cpreg struct
+         * and name that it is passed, so it's OK to use
+         * a local struct here.
+         */
+        ARMCPRegInfo nxs_ri = *r;
+        g_autofree char *name = g_strdup_printf("%sNXS", r->name);
+
+        assert(nxs_ri.crn < 0xf);
+        nxs_ri.crn++;
+        if (nxs_ri.fgt) {
+            nxs_ri.fgt |= R_FGT_NXS_MASK;
+        }
+        add_cpreg_to_hashtable(cpu, &nxs_ri, ARM_CP_STATE_AA64,
+                               ARM_CP_SECSTATE_NS, crm, opc1, opc2, name);
+    }
+
+    add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64, ARM_CP_SECSTATE_NS,
+                           crm, opc1, opc2, r->name);
+}
 
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
 {
@@ -7584,14 +7644,12 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
      * bits; the ARM_CP_64BIT* flag applies only to the AArch32 view of
      * the register, if any.
      */
-    int crm, opc1, opc2;
     int crmmin = (r->crm == CP_ANY) ? 0 : r->crm;
     int crmmax = (r->crm == CP_ANY) ? 15 : r->crm;
     int opc1min = (r->opc1 == CP_ANY) ? 0 : r->opc1;
     int opc1max = (r->opc1 == CP_ANY) ? 7 : r->opc1;
     int opc2min = (r->opc2 == CP_ANY) ? 0 : r->opc2;
     int opc2max = (r->opc2 == CP_ANY) ? 7 : r->opc2;
-    CPState state;
 
     /* 64 bit registers have only CRm and Opc1 fields */
     assert(!((r->type & ARM_CP_64BIT) && (r->opc2 || r->crn)));
@@ -7688,75 +7746,22 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
         }
     }
 
-    for (crm = crmmin; crm <= crmmax; crm++) {
-        for (opc1 = opc1min; opc1 <= opc1max; opc1++) {
-            for (opc2 = opc2min; opc2 <= opc2max; opc2++) {
-                for (state = ARM_CP_STATE_AA32;
-                     state <= ARM_CP_STATE_AA64; state++) {
-                    if (r->state != state && r->state != ARM_CP_STATE_BOTH) {
-                        continue;
-                    }
-                    if ((r->type & ARM_CP_ADD_TLBI_NXS) &&
-                        cpu_isar_feature(aa64_xs, cpu)) {
-                        /*
-                         * This is a TLBI insn which has an NXS variant. The
-                         * NXS variant is at the same encoding except that
-                         * crn is +1, and has the same behaviour except for
-                         * fine-grained trapping. Add the NXS insn here and
-                         * then fall through to add the normal register.
-                         * add_cpreg_to_hashtable() copies the cpreg struct
-                         * and name that it is passed, so it's OK to use
-                         * a local struct here.
-                         */
-                        ARMCPRegInfo nxs_ri = *r;
-                        g_autofree char *name = g_strdup_printf("%sNXS", r->name);
-
-                        assert(state == ARM_CP_STATE_AA64);
-                        assert(nxs_ri.crn < 0xf);
-                        nxs_ri.crn++;
-                        if (nxs_ri.fgt) {
-                            nxs_ri.fgt |= R_FGT_NXS_MASK;
-                        }
-                        add_cpreg_to_hashtable(cpu, &nxs_ri, state,
-                                               ARM_CP_SECSTATE_NS,
-                                               crm, opc1, opc2, name);
-                    }
-                    if (state == ARM_CP_STATE_AA32) {
-                        /*
-                         * Under AArch32 CP registers can be common
-                         * (same for secure and non-secure world) or banked.
-                         */
-                        char *name;
-
-                        switch (r->secure) {
-                        case ARM_CP_SECSTATE_S:
-                        case ARM_CP_SECSTATE_NS:
-                            add_cpreg_to_hashtable(cpu, r, state,
-                                                   r->secure, crm, opc1, opc2,
-                                                   r->name);
-                            break;
-                        case ARM_CP_SECSTATE_BOTH:
-                            name = g_strdup_printf("%s_S", r->name);
-                            add_cpreg_to_hashtable(cpu, r, state,
-                                                   ARM_CP_SECSTATE_S,
-                                                   crm, opc1, opc2, name);
-                            g_free(name);
-                            add_cpreg_to_hashtable(cpu, r, state,
-                                                   ARM_CP_SECSTATE_NS,
-                                                   crm, opc1, opc2, r->name);
-                            break;
-                        default:
-                            g_assert_not_reached();
-                        }
-                    } else {
-                        /*
-                         * AArch64 registers get mapped to non-secure instance
-                         * of AArch32
-                         */
-                        add_cpreg_to_hashtable(cpu, r, state,
-                                               ARM_CP_SECSTATE_NS,
-                                               crm, opc1, opc2, r->name);
-                    }
+    for (int crm = crmmin; crm <= crmmax; crm++) {
+        for (int opc1 = opc1min; opc1 <= opc1max; opc1++) {
+            for (int opc2 = opc2min; opc2 <= opc2max; opc2++) {
+                switch (r->state) {
+                case ARM_CP_STATE_AA32:
+                    add_cpreg_to_hashtable_aa32(cpu, r, crm, opc1, opc2);
+                    break;
+                case ARM_CP_STATE_AA64:
+                    add_cpreg_to_hashtable_aa64(cpu, r, crm, opc1, opc2);
+                    break;
+                case ARM_CP_STATE_BOTH:
+                    add_cpreg_to_hashtable_aa32(cpu, r, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa64(cpu, r, crm, opc1, opc2);
+                    break;
+                default:
+                    g_assert_not_reached();
                 }
             }
         }
-- 
2.43.0


