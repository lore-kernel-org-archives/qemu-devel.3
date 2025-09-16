Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D740ECAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWbl-00071y-Pt; Tue, 16 Sep 2025 10:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWam-0006BF-VT
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:37 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaU-0008NX-R2
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:31 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b4c1fc383eeso3710086a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032583; x=1758637383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTfmC+EHekiKULjrHnOchac3Nz1KC9/zPXCI44LaJl4=;
 b=NyBM7xnzjlWYrZyN8EtPAWgSfXIfFFw9jPegaC+tFCyLJslIXOCFeD59/5pyeh/aTq
 sxfhpaaUf4Dtb0S6FQzbK794IxVhdZWG2Z7JWsDWdq6YCBmzcnE+yeHGHMra8sVsLzL9
 W4fUD7AJ03SsC6kS6/1Mugmo1GMvHGFThih79aje5mKGzUd0maU7FwR3/SJImtzGXzhl
 44Ti7U1ouYDZdBqZoIiPDQ/xH8O9k7NHF84TFuJH7NQpVnDKSU2D6MvW3WmxDzhYFbS0
 vrudnC8yz4OpZ4nwK9dARZceexVnLBSTAmHTcBB3reEgesKJPb6IboyUHY9bUEp90eUl
 Z4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032583; x=1758637383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QTfmC+EHekiKULjrHnOchac3Nz1KC9/zPXCI44LaJl4=;
 b=J7FLazMia4uBJul7ZisR1FWQHProFPB4EAYM/A+f39YBZ6kbdjiKCoTX+nUgp9na7b
 melkPkBZKAFgy72YhwhqD5wkI0Zp0im5rAIDbOavCev8WAkH+sctspx0BzX/GvTEOemp
 nAotm6eRpuCQJIdU55YWVuHrh/OTVddT/cDiXpDiV7qGUDp4ugJ1tEudnHykhNDXOTWB
 glXCaV6riUobfmnpVtZoJzBaa6tcOyDkixMlci5zQ2yTESJuuvN31vxDT9Lu3tQl9p9x
 xdCummPdVZ99xoLOJeE0HPAnAmd7cLuxqcnRQWc7zPXyjG9cMVX3gtBlyXvH6Z78aw85
 K/0Q==
X-Gm-Message-State: AOJu0YygrdbDJjowveJY9ieel0+de56RLopyJUTpvd7whThWNASJt5Da
 38qKLbh5gW+3Ek6wun6bOsLDTvgg76IbBgNSFWhO90m60fmh2ixgnGfiaNHuwn4CV5Wz0M6m0ou
 saWod
X-Gm-Gg: ASbGnct3N/5WedOSdlwLTHwyJzPTqBD5WodvU+vjvDJ5Xaw7eKQbo5qciCcTxq5ZXsa
 PKpmoah7x3Ko5GeFnf6+teis3xdOpcK8/2pLUe1hUuI8aW+mSneoUfPDyE+/xJAa104wZsKSwDJ
 rwhi9Z5UY2tgai+dBoeFk9OSf8LYTZ/LTtNtK8qROVTAeM0nnziSfrWBGx9fyP7ucLZVHCTQB5J
 1ImMb30iUI7m0P9ZTM0qWAvaBNKRWn6vPkCHngoQVvSzANQhQ2Lhbb8tyhkrn2dZ8rNN41jQjlH
 1ZCcQ3HSUL+3kzaekDDjAxQD8XcfRnTy8zlL0Kpcd4lvebiJPf1htWME4KrrRFsjQ7cauFBkdL8
 no0/ErmYakk82MNJVEIAylMgPc/dG
X-Google-Smtp-Source: AGHT+IFoERqKLyR1iYNDsGk5975Zt3MbltqsNVAb58sthGhtAxJnbGzlFE9tryDQKZdTPbXnl4H4hw==
X-Received: by 2002:a17:903:3c30:b0:24d:7314:fe64 with SMTP id
 d9443c01a7336-25d27828f01mr229384205ad.57.1758032582606; 
 Tue, 16 Sep 2025 07:23:02 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:23:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 29/36] target/arm: Move writeback of CP_ANY fields
Date: Tue, 16 Sep 2025 07:22:30 -0700
Message-ID: <20250916142238.664316-30-richard.henderson@linaro.org>
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

Move the writeback of cp, crm, opc1, opc2 to define_one_arm_cp_reg,
which means we don't have to pass all those parameters down
to subroutines.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 52 ++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9156cc72ae..7828268c7f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7445,7 +7445,6 @@ static ARMCPRegInfo *alloc_cpreg(const ARMCPRegInfo *in, const char *suffix)
  */
 static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
                                    CPState state, CPSecureState secstate,
-                                   int cp, int crm, int opc1, int opc2,
                                    uint32_t key)
 {
     CPUARMState *env = &cpu->env;
@@ -7512,12 +7511,8 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
 
     /*
      * Update fields to match the instantiation, overwiting wildcards
-     * such as CP_ANY, ARM_CP_STATE_BOTH, or ARM_CP_SECSTATE_BOTH.
+     * such as ARM_CP_STATE_BOTH or ARM_CP_SECSTATE_BOTH.
      */
-    r->cp = cp;
-    r->crm = crm;
-    r->opc1 = opc1;
-    r->opc2 = opc2;
     r->state = state;
     r->secure = secstate;
 
@@ -7533,8 +7528,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
     g_hash_table_insert(cpu->cp_regs, (gpointer)(uintptr_t)key, r);
 }
 
-static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r,
-                                        int cp, int crm, int opc1, int opc2)
+static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r)
 {
     /*
      * Under AArch32 CP registers can be common
@@ -7542,7 +7536,8 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r,
      */
     ARMCPRegInfo *r_s;
     bool is64 = r->type & ARM_CP_64BIT;
-    uint32_t key = ENCODE_CP_REG(cp, is64, 0, r->crn, crm, opc1, opc2);
+    uint32_t key = ENCODE_CP_REG(r->cp, is64, 0, r->crn,
+                                 r->crm, r->opc1, r->opc2);
 
     assert(!(r->type & ARM_CP_ADD_TLBI_NXS)); /* aa64 only */
 
@@ -7551,27 +7546,26 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, ARMCPRegInfo *r,
         key |= CP_REG_AA32_NS_MASK;
         /* fall through */
     case ARM_CP_SECSTATE_S:
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, r->secure,
-                               cp, crm, opc1, opc2, key);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, r->secure, key);
         break;
     case ARM_CP_SECSTATE_BOTH:
         r_s = alloc_cpreg(r, "_S");
-        add_cpreg_to_hashtable(cpu, r_s, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
-                               cp, crm, opc1, opc2, key);
+        add_cpreg_to_hashtable(cpu, r_s, ARM_CP_STATE_AA32,
+                               ARM_CP_SECSTATE_S, key);
 
         key |= CP_REG_AA32_NS_MASK;
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_NS,
-                               cp, crm, opc1, opc2, key);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
+                               ARM_CP_SECSTATE_NS, key);
         break;
     default:
         g_assert_not_reached();
     }
 }
 
-static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r,
-                                        int crm, int opc1, int opc2)
+static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r)
 {
-    uint32_t key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
+    uint32_t key = ENCODE_AA64_CP_REG(r->opc0, r->opc1,
+                                      r->crn, r->crm, r->opc2);
 
     if ((r->type & ARM_CP_ADD_TLBI_NXS) &&
         cpu_isar_feature(aa64_xs, cpu)) {
@@ -7596,12 +7590,11 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, ARMCPRegInfo *r,
         }
 
         add_cpreg_to_hashtable(cpu, nxs_ri, ARM_CP_STATE_AA64,
-                               ARM_CP_SECSTATE_NS, 0, crm, opc1, opc2,
-                               nxs_key);
+                               ARM_CP_SECSTATE_NS, nxs_key);
     }
 
-    add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64, ARM_CP_SECSTATE_NS,
-                           0, crm, opc1, opc2, key);
+    add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64,
+                           ARM_CP_SECSTATE_NS, key);
 }
 
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
@@ -7821,17 +7814,24 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
                     r2->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
                 }
 
+                /* Overwrite CP_ANY with the instantiation. */
+                r2->crm = crm;
+                r2->opc1 = opc1;
+                r2->opc2 = opc2;
+
                 switch (r->state) {
                 case ARM_CP_STATE_AA32:
-                    add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa32(cpu, r2);
                     break;
                 case ARM_CP_STATE_AA64:
-                    add_cpreg_to_hashtable_aa64(cpu, r2, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa64(cpu, r2);
                     break;
                 case ARM_CP_STATE_BOTH:
                     r3 = alloc_cpreg(r2, NULL);
-                    add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
-                    add_cpreg_to_hashtable_aa64(cpu, r3, crm, opc1, opc2);
+                    r2->cp = cp;
+                    add_cpreg_to_hashtable_aa32(cpu, r2);
+                    r3->cp = 0;
+                    add_cpreg_to_hashtable_aa64(cpu, r3);
                     break;
                 default:
                     g_assert_not_reached();
-- 
2.43.0


