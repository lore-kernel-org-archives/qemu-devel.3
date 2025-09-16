Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEEACAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWau-0006PJ-BE; Tue, 16 Sep 2025 10:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWab-0005yr-Nh
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:25 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaT-0008LZ-Pz
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:25 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b49b56a3f27so3256633a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032575; x=1758637375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3ZI3DSvuSnKVozoGKOUzCAQ9C1UttOP4zYBt0a8luk=;
 b=Hfkk6nz7AEi+6meQ1pCJcKsOZhfM203qM1V9Z9M3IIzXYcRzP6St6j1swXBTWvpIhb
 wDo7/+5Qfrss+LHNJJzXk2U+6dE9/wArYY/4+JANu0K693z4HGwxzJUF9gk2qJeHHV/g
 rhYXoEko9sEAkTMO/UlS3uUmdADtyerogt0b9qfmFsFF60vPu4qoAiEwe+MaKoWrsnfk
 x8uql2P9oKRoak0DMgCAhvR1P7fUsI8iAb8CD3W8RNGUYtO4/oQcikqUzMh9afOkU+jX
 wky76JI865nbFvPvlwvfrfkZSW+VkyU0Occ4ZPFt3Ys4IRdjWxdiAuESpYhiwV0QYVUq
 ejsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032575; x=1758637375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O3ZI3DSvuSnKVozoGKOUzCAQ9C1UttOP4zYBt0a8luk=;
 b=lZDMLIik+/5mLdi2IH2rJqEBNqxBJkmAHMdx9cn/IJCAvoSbCvjC8HVRroZpftGw8f
 CQACtK81V6jIwnRdwIvcMKBzKtm3penMpdHwijM4zUV45ROqoxT4ptwyr25ELYF3VaoX
 feqWbB0ks+OhGX+BRxE3n0rXHX+l7mVuGAQl6mEzeMXgdSCJQgaA9NxJdOfjBcw8nZlU
 OwhCxYK42jLXX+UUC2OppLdHJA/zQ0BzDTlfPN7bj4M+iyKKJsGqdxgU0CESCA2rKHcE
 YulU/MmOPg5olLrR88yqQYyoDCpuBzaJANnbkAKVY45rMnkU6UPElrWYDMImwV63drzN
 m1mQ==
X-Gm-Message-State: AOJu0Yy87LuW0nqTWAQL17zhVLj/s3mdl71r6IFeSbS2ws5hmf6MJGas
 E8YkHxiFm2KJYHM8t6g9WUhCdKrJHLeOuPGelLV7bNCHsdjGyyqSQuSD69Gg1UeUbj+pwc8q9WK
 beha9
X-Gm-Gg: ASbGncuNeZVSNPHUplBAop6CH51/cXxT/NmwuEpUmsqskcAXTLy3no1EPSBDSjMTBTK
 4O3WEZzOiDO7X0epittHq+I1JmT73A3gd8YRiEe827ZHbLFRCbqsCJ02vdJNm8IyY0e4xk00IaR
 +v0LdB6DHVpJOSVasfDfdQadxtU8i/DaIrmyrr3xcP2QaRi8Q9QIZm3XUBNoGSziGu/9SLeuUhp
 vMt99sK0juQg6xQTn6QAR7AYaJz7nk8zCyVQAgEGB2kb/aOWeUCVzM5dH9CiVjaZbnmyZ4z7dU/
 l7DSC5gwx5Ir5rlbgN58j489bhrmuxjAwXB7/AUVdYuxyb5ZHnNzKXlT3UOWogEu2m05WIS7qTV
 b0NZDXpooiFIexLTd3rrgfxUUiWmsrUi2HafzfDE=
X-Google-Smtp-Source: AGHT+IEliu+Ux8ncYvtfLYROnFdzKeiFM8UHKSBUqvd3juzX+RrflFEdZz1RIIhhHxfDG7KCpF0jzA==
X-Received: by 2002:a17:903:230d:b0:263:671e:397b with SMTP id
 d9443c01a7336-263671e3beemr122575215ad.7.1758032575412; 
 Tue, 16 Sep 2025 07:22:55 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 20/36] target/arm: Split out add_cpreg_to_hashtable_aa{32,
 64}
Date: Tue, 16 Sep 2025 07:22:21 -0700
Message-ID: <20250916142238.664316-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

The nesting level for the inner loop of define_one_arm_cp_reg
was overly deep.  Split out that code into two functions, for
the AArch32 and AArch64 paths separately.  Simplify the innermost
loop to a switch statement over r->state.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 147 +++++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 71 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8b63eacb91..ec78c8f08f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7612,6 +7612,66 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
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
@@ -7639,14 +7699,12 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
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
@@ -7743,75 +7801,22 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
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


