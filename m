Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B324BCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v299Q-0000GC-V4; Fri, 26 Sep 2025 10:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298x-00086Q-UT
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298S-0005k4-R3
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:48 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee15505cdeso1851645f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895755; x=1759500555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4KNnz1B08IfySAfOU3KxSHeljJLIDfXWvH3ivvy21G8=;
 b=qztl2Hr6cESixOWiO8TP6ozy/bTFU/BP0h9a8Ixy7CNuGv122aHDNL4RL3hKAx21Gz
 0VgI9jvZc6dX8P83NEUbg8uZYBuG/nzi3TGKX1e4Deq/eF0OVq7bQtXoG8F7iCxO1WwR
 PUbQA5gCjdvOAHH/sGWuuftglbrug0EFiwXfWrLvBMMFbYVZLMtdlVTR+u2+OHIKqGP9
 6KS4GUK9SfQqQk/g6x0rDmOmXtDDMmcOzVvy/djwzj6ydgHpCFIDa5FMIEXKtXQqShX+
 boqbwCohP7tEPtU658F23K5cQO4WD4L+yhYHKwyiI6D4tekqHYHjT3qXmzEvJehddwOT
 XtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895755; x=1759500555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4KNnz1B08IfySAfOU3KxSHeljJLIDfXWvH3ivvy21G8=;
 b=aFtJQ8zAebG05IrGEnG6VJsp8rczJLay4dUhzQXR+mrexAM64ZqXrBC1VWXpJ5kLQv
 EObAC4ksmUeNmE+p5/O8zDlRddUnYyZJpjfTcKv5h9cNmnriD8JOHZ9Oo03VbzGakGu0
 8VDiCRZ+NqKOxS+8xS5EugjAW5diqSRao3+PqU23TxSfQRytriPZO95Pfr41cMl4yz6n
 mhsbHPGMIZG5mItGVZKLuC5nDgzSBWRKvGTHqR5nFGppHtBlkyi+kIUJ++hGK/tB9+V+
 fzKxl4sVg3a3ZGwJNokGyhiBzmtAbuQRkMy73lQutxS6/MeFH20v9+XJNPD1JGElF8Rm
 cESA==
X-Gm-Message-State: AOJu0YzG0xTO0k2zbNlchT1WQp9OSItea/2oZFLht5U2e2K3M2X4iMQI
 fw3CeVAG6oFZx34ar9ipVG02tDLwLqOpcJrqRcgp0AV47mYbn01H+SdB8h0cZvgwjN6Jbc93kdW
 E7rOS
X-Gm-Gg: ASbGncsb0GzM6dlpuGR5gJfeW9P9375wf95y15azRE9/+B93WjpheZheK5Imqp/MLgw
 RFIHTh5jOJ13JdGWpamV2Tsyk+8f0krlGJouGYQikY1UrkiecTydQ8fPBwWLWKcB3gHb1zZCbqT
 JFQJzEap0mF2ax4W0PL0FMIGHnBkFgFljubXHyn2KXsoTQw66J3PJCHUQfhu3PreFfElQw1KhxC
 go6hB6//EFmwnTCOMdpobRBY/nv8tm/9FAGbTVXNId4CupUdzKAQ9tDdjIVov4i8c4LLRo3xZrI
 CuIMnh8xypG7p4+lGGvZHVLa23XujXwlapRaEFeHJt80uwh1xhW5jg5yPWkT7HA5/6SdS+XTXF4
 bvd/nBxFEvdr58aF6/QYFbQ0DygOr1liDbwLSyDg=
X-Google-Smtp-Source: AGHT+IE4F79uO225GwLirnc6pWap0JNIcGeiVKXhrSfI4nMoOV6nTmMMnDeXxhwP41bhqXuWyqGZ7w==
X-Received: by 2002:a05:6000:2184:b0:411:3c14:3ad9 with SMTP id
 ffacd0b85a97d-4113c14418emr4862136f8f.21.1758895755315; 
 Fri, 26 Sep 2025 07:09:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/44] target/arm: Hoist the allocation of ARMCPRegInfo
Date: Fri, 26 Sep 2025 15:08:28 +0100
Message-ID: <20250926140844.1493020-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Pass in a newly allocated structure, rather than having to
dance around allocation of the name and the structure.

Since we no longer have two copies of the structure handy
within add_cpreg_to_hashtable, delay the writeback of concrete
values over wildcards until we're done querying the wildcards.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 97 ++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 49 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index e36598e273b..88b5ec1a5a2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7388,13 +7388,12 @@ static ARMCPRegInfo *alloc_cpreg(const ARMCPRegInfo *in,
  * Private utility function for define_one_arm_cp_reg():
  * add a single reginfo struct to the hash table.
  */
-static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
+static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
                                    CPState state, CPSecureState secstate,
                                    int cp, int crm, int opc1, int opc2,
-                                   const char *name, uint32_t key)
+                                   uint32_t key)
 {
     CPUARMState *env = &cpu->env;
-    ARMCPRegInfo *r2;
     bool ns = secstate & ARM_CP_SECSTATE_NS;
 
     /* Overriding of an existing definition must be explicitly requested. */
@@ -7405,19 +7404,6 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
         }
     }
 
-    r2 = alloc_cpreg(r, name, NULL);
-
-    /*
-     * Update fields to match the instantiation, overwiting wildcards
-     * such as CP_ANY, ARM_CP_STATE_BOTH, or ARM_CP_SECSTATE_BOTH.
-     */
-    r2->cp = cp;
-    r2->crm = crm;
-    r2->opc1 = opc1;
-    r2->opc2 = opc2;
-    r2->state = state;
-    r2->secure = secstate;
-
     {
         bool isbanked = r->bank_fieldoffsets[0] && r->bank_fieldoffsets[1];
 
@@ -7427,7 +7413,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
              * Overwriting fieldoffset as the array is only used to define
              * banked registers but later only fieldoffset is used.
              */
-            r2->fieldoffset = r->bank_fieldoffsets[ns];
+            r->fieldoffset = r->bank_fieldoffsets[ns];
         }
         if (state == ARM_CP_STATE_AA32) {
             if (isbanked) {
@@ -7444,19 +7430,19 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
                  */
                 if ((r->state == ARM_CP_STATE_BOTH && ns) ||
                     (arm_feature(env, ARM_FEATURE_V8) && !ns)) {
-                    r2->type |= ARM_CP_ALIAS;
+                    r->type |= ARM_CP_ALIAS;
                 }
             } else if ((secstate != r->secure) && !ns) {
                 /*
                  * The register is not banked so we only want to allow
                  * migration of the non-secure instance.
                  */
-                r2->type |= ARM_CP_ALIAS;
+                r->type |= ARM_CP_ALIAS;
             }
 
             if (HOST_BIG_ENDIAN &&
-                r->state == ARM_CP_STATE_BOTH && r2->fieldoffset) {
-                r2->fieldoffset += sizeof(uint32_t);
+                r->state == ARM_CP_STATE_BOTH && r->fieldoffset) {
+                r->fieldoffset += sizeof(uint32_t);
             }
         }
     }
@@ -7468,35 +7454,46 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
      * multiple times. Special registers (ie NOP/WFI) are
      * never migratable and not even raw-accessible.
      */
-    if (r2->type & ARM_CP_SPECIAL_MASK) {
-        r2->type |= ARM_CP_NO_RAW;
+    if (r->type & ARM_CP_SPECIAL_MASK) {
+        r->type |= ARM_CP_NO_RAW;
     }
     if (((r->crm == CP_ANY) && crm != 0) ||
         ((r->opc1 == CP_ANY) && opc1 != 0) ||
         ((r->opc2 == CP_ANY) && opc2 != 0)) {
-        r2->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
+        r->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
     }
 
+    /*
+     * Update fields to match the instantiation, overwiting wildcards
+     * such as CP_ANY, ARM_CP_STATE_BOTH, or ARM_CP_SECSTATE_BOTH.
+     */
+    r->cp = cp;
+    r->crm = crm;
+    r->opc1 = opc1;
+    r->opc2 = opc2;
+    r->state = state;
+    r->secure = secstate;
+
     /*
      * Check that raw accesses are either forbidden or handled. Note that
      * we can't assert this earlier because the setup of fieldoffset for
      * banked registers has to be done first.
      */
-    if (!(r2->type & ARM_CP_NO_RAW)) {
-        assert(!raw_accessors_invalid(r2));
+    if (!(r->type & ARM_CP_NO_RAW)) {
+        assert(!raw_accessors_invalid(r));
     }
 
-    g_hash_table_insert(cpu->cp_regs, (gpointer)(uintptr_t)key, r2);
+    g_hash_table_insert(cpu->cp_regs, (gpointer)(uintptr_t)key, r);
 }
 
-static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
+static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r,
                                         int cp, int crm, int opc1, int opc2)
 {
     /*
      * Under AArch32 CP registers can be common
      * (same for secure and non-secure world) or banked.
      */
-    char *name;
+    ARMCPRegInfo *r_s;
     bool is64 = r->type & ARM_CP_64BIT;
     uint32_t key = ENCODE_CP_REG(cp, is64, 0, r->crn, crm, opc1, opc2);
 
@@ -7508,24 +7505,23 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
         /* fall through */
     case ARM_CP_SECSTATE_S:
         add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, r->secure,
-                               cp, crm, opc1, opc2, r->name, key);
+                               cp, crm, opc1, opc2, key);
         break;
     case ARM_CP_SECSTATE_BOTH:
-        name = g_strdup_printf("%s_S", r->name);
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
-                               cp, crm, opc1, opc2, name, key);
-        g_free(name);
+        r_s = alloc_cpreg(r, r->name, "_S");
+        add_cpreg_to_hashtable(cpu, r_s, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
+                               cp, crm, opc1, opc2, key);
 
         key |= CP_REG_AA32_NS_MASK;
         add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_NS,
-                               cp, crm, opc1, opc2, r->name, key);
+                               cp, crm, opc1, opc2, key);
         break;
     default:
         g_assert_not_reached();
     }
 }
 
-static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
+static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r,
                                         int crm, int opc1, int opc2)
 {
     uint32_t key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
@@ -7542,25 +7538,24 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
          * and name that it is passed, so it's OK to use
          * a local struct here.
          */
-        ARMCPRegInfo nxs_ri = *r;
-        g_autofree char *name = g_strdup_printf("%sNXS", r->name);
+        ARMCPRegInfo *nxs_ri = alloc_cpreg(r, r->name, "NXS");
         uint32_t nxs_key;
 
-        assert(nxs_ri.crn < 0xf);
-        nxs_ri.crn++;
+        assert(nxs_ri->crn < 0xf);
+        nxs_ri->crn++;
         /* Also increment the CRN field inside the key value */
         nxs_key = key + (1 << CP_REG_ARM64_SYSREG_CRN_SHIFT);
-        if (nxs_ri.fgt) {
-            nxs_ri.fgt |= R_FGT_NXS_MASK;
+        if (nxs_ri->fgt) {
+            nxs_ri->fgt |= R_FGT_NXS_MASK;
         }
 
-        add_cpreg_to_hashtable(cpu, &nxs_ri, ARM_CP_STATE_AA64,
+        add_cpreg_to_hashtable(cpu, nxs_ri, ARM_CP_STATE_AA64,
                                ARM_CP_SECSTATE_NS, 0, crm, opc1, opc2,
-                               name, nxs_key);
+                               nxs_key);
     }
 
     add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64, ARM_CP_SECSTATE_NS,
-                           0, crm, opc1, opc2, r->name, key);
+                           0, crm, opc1, opc2, key);
 }
 
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
@@ -7767,16 +7762,20 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
     for (int crm = crmmin; crm <= crmmax; crm++) {
         for (int opc1 = opc1min; opc1 <= opc1max; opc1++) {
             for (int opc2 = opc2min; opc2 <= opc2max; opc2++) {
+                ARMCPRegInfo *r2 = alloc_cpreg(r, r->name, NULL);
+                ARMCPRegInfo *r3;
+
                 switch (r->state) {
                 case ARM_CP_STATE_AA32:
-                    add_cpreg_to_hashtable_aa32(cpu, r, cp, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
                     break;
                 case ARM_CP_STATE_AA64:
-                    add_cpreg_to_hashtable_aa64(cpu, r, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa64(cpu, r2, crm, opc1, opc2);
                     break;
                 case ARM_CP_STATE_BOTH:
-                    add_cpreg_to_hashtable_aa32(cpu, r, cp, crm, opc1, opc2);
-                    add_cpreg_to_hashtable_aa64(cpu, r, crm, opc1, opc2);
+                    r3 = alloc_cpreg(r2, r2->name, NULL);
+                    add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa64(cpu, r3, crm, opc1, opc2);
                     break;
                 default:
                     g_assert_not_reached();
-- 
2.43.0


