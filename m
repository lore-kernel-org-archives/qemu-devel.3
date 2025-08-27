Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18E8CA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4do-0000J9-KC; Tue, 26 Aug 2025 21:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dX-0007Sp-Qt
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:43 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dQ-0007Yq-1Q
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:39 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-32597b88f0dso2563436a91.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256848; x=1756861648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0m53HPKD6Du3PeyFjN/hMU96ykTHL6/3IH+CJFSfXbY=;
 b=NzRwaF0OhR2SnatAesC5zsuJb7cIFdbx9O1ybyIor44R3i9YktDOQOL2wcku3zU/8b
 mSJVOl9Yur5E8z6S1WomRBT34DELyddYLyeHpqsN7VbwEyjT4s4ewyxIKvJaKOm9U+ED
 h3BWhr61xM3MddeDM98QxE8HltPYPj4FfA9W/fCrwYkrlGepJ149XubXM2hCHTJvnihN
 C+E7IUZ2TCCw/jyLNqETygnhgrpcq975UlJDOGB983KQnEcs5/wQ8AWRi1OIU2DyHH0h
 dRJAVKN1+27dpvWkV+LAjQIFHp2npsGR+39UgBuWMZSo40Ufso8zWe+mLLz4n4WPucZt
 k9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256848; x=1756861648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0m53HPKD6Du3PeyFjN/hMU96ykTHL6/3IH+CJFSfXbY=;
 b=j8slGPBuapfFedzrdW6pGGn+PkUbM4zrUZM4+KXKpC9LVY1UINlo2ghceRBTeu2mQL
 CRTiPLk6FpQdFO7AMsZnX43ZhAjWcHhlAf1n7v6XhLFk0UEjShe45RUzyMU7W9o2mPWf
 DKwbDJIcHuJwSRif8lLy0lTcI+MvWkEGv1lUDBTLYzfCk+ZCxQqr2W4EsVKidrbfYlFk
 d2mn9ULWkz+pMaXsZTNftOjBXfu2rlUtSfttmm10dg4qaWTy6jnvtJFftRq0rtvc5X9L
 gEyOWYzKniBA4IUdpN16AUvNshHrdCO2p5B7WnVVckdm7yGVTyO1oVnXhB4pgY0MHI5X
 e2sw==
X-Gm-Message-State: AOJu0YwYFusKW6TIpBhVtNFVUrRp4NunkSzRs9v6VdbtusRngDUN8zIR
 VAsl2adCnbAOE8akQwwO+6ceEvxlfjkBW8uiMIZwrerKZubfrl71EGW6r1TmpjgK+lwOygNtUXJ
 NYVqGkXo=
X-Gm-Gg: ASbGnculaCTO9vH3BQc875cS0BQVcrS54V0No1sLv2LKRW3aOW1u2GYOcsO64DKo7z1
 H9iuvPZKswK/fmFUX+HWoqXpiNh33Qw7LJLZ5MYjwKonARv3Uw3irrDuvq27E0CjXJ07I8daUEm
 a6zemmgvsA+Pe/TPsMUOXOlxV9+QhNU3DxAPFvhV5guD6h8LIRmnvFGfp+snAmazwd6Opb0I5F+
 LVt8b50EH3ZwhfGBfxGBXXhGovdQkHz8LROFI90YAONUxusY/Qff/QRMrUQbyL8beIp2f29ZOZZ
 FDKqWBR6NFHtM9GUbLUfzvHfMla3JGYHGCU3bbjg86lE+5Y6ShFu0RwPEDaYsyZYqrKdXqB8s6y
 tSL+9RyKfF0AAAknhkCIXCtyogQ==
X-Google-Smtp-Source: AGHT+IH0OFkMttbU+X7btvbDDLaBqLBq7hos/HyPoN7kSFGx0aCLM0R/kTGRuiOrs8FA+8GgOarKYg==
X-Received: by 2002:a17:90b:3d89:b0:31e:f397:b5b4 with SMTP id
 98e67ed59e1d1-3251744bd7amr21249738a91.22.1756256848166; 
 Tue, 26 Aug 2025 18:07:28 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:07:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 26/61] target/arm: Hoist the allocation of ARMCPRegInfo
Date: Wed, 27 Aug 2025 11:04:17 +1000
Message-ID: <20250827010453.4059782-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Pass in a newly allocated structure, rather than having to
dance around allocation of the name and the structure.

Since we no longer have two copies of the structure handy
within add_cpreg_to_hashtable, delay the writeback of concrete
values over wildcards until we're done querying the wildcards.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 97 ++++++++++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 49 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0e4be14606..d9ac6a20a7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7289,13 +7289,12 @@ static ARMCPRegInfo *alloc_cpreg(const ARMCPRegInfo *in,
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
@@ -7306,19 +7305,6 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
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
 
@@ -7328,7 +7314,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
              * Overwriting fieldoffset as the array is only used to define
              * banked registers but later only fieldoffset is used.
              */
-            r2->fieldoffset = r->bank_fieldoffsets[ns];
+            r->fieldoffset = r->bank_fieldoffsets[ns];
         }
         if (state == ARM_CP_STATE_AA32) {
             if (isbanked) {
@@ -7345,19 +7331,19 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
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
@@ -7369,35 +7355,46 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
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
 
@@ -7409,24 +7406,23 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
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
@@ -7443,24 +7439,23 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
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
@@ -7667,16 +7662,20 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
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


