Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721D6CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4dg-00080p-JI; Tue, 26 Aug 2025 21:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dM-00078C-11
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:29 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dE-0007Wh-RX
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:27 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-771ed4a8124so2425922b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256834; x=1756861634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xaHs5WgmJxxI4MWQhNiuezsYVgJ83xCQG2Di2ZBMw8=;
 b=NYMlYiUnCczCp6kRZ3tp5yz+glhWgCfBhSIzT8HieijPJGXEY+IYafBgU5920ezPTg
 d1sQb+0Rsry0G+UyQ/V0704GAT34x2N+3EXTTaxV8KOIaWvPq06WpzO8d9dpDrPQ4/aL
 wXkUQHRa/KiDFRtVBqbKei9Tb4wAr8SHmtSs72wB1eyYE5I3xAwAZ1Pk6ezW6CmJO049
 t98yfbhrGp+byYZRmWnaAH6JjoSBeTzGzs+GSIi3wyGLbEZoDlgqZ84lxQyBMB0s1xNB
 +7+ggZIqrkiiJlRdMts4gfICsiHsRAi+luZVBZymvD3kAJzbjsjHFu2oR19fxltnYY8O
 kCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256834; x=1756861634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xaHs5WgmJxxI4MWQhNiuezsYVgJ83xCQG2Di2ZBMw8=;
 b=iODBTrNtZ55gFGAVnQQ9X6MHjDNVHLMv4PK9im8dk2cAWwx0TRTr4SAsoEe3BWb03z
 bAL3tYCqCc+trfA/fwPSVx1e3x3MhLBKeqkx+CdcHEEkCLWNM8N9J5KjorS1BBw07NaW
 tWPGLa/Uu36cIapJV94DUzF40JWwAwkxskPP25ms/aWnmWPSk6dDI6pcjjKEtWYW1ALh
 s8ElCISHTkr5498hkGdCrTb/RMYwCHRDzzu36fGVPrRaEnQDiisq2/bI0jzQFmblQYUF
 U34mTC+OCf0LPiVzakNZxnNKRqX/DnlJ+dBo64+XbQSJ6+G/lSVPE9CCJExoTghFmgVH
 QLtQ==
X-Gm-Message-State: AOJu0YyU1S+ydaQ3DiLb2la/48jrRagnXCjaaDCgFbcmIznkSVLEgYUS
 MRjmZWNgWLr+VP7IJmNDIfI1GlSpxlTo8Udr/VTKBor25y6z6HX6934hMxIBsVtgr9uqhIpN639
 qb9OuSTU=
X-Gm-Gg: ASbGncsL+swIQksHZbaHkrOb1gRNE7e3nx7A/2ytDM61xKIq/c4o5kVKYAUCRI7f+WL
 P0Qkdke+TAgvtdDEFNQ1V1D2jRCRFhrR9XV+Nvpwn3zQY877o9hSN3VGbXkYSJR6pYvpzUs2g6R
 hWmYEwPZEXLBCkdm3u1Ox+8htVzBiU8xvWuYfnqojOdkChiaZs7KuK09JaS80wg81h5C5LcaxlV
 TOpvXE3fegBD6ozOpyk1aO4eRnHjDIlQCzVnKAXi+heg/136g4WjmHu2m4IrcZVC3w4py3zSvRf
 Tv1eANlNBbLe4U8cP0MOZy6U66ieGuzDlzojZQEsomA5R/A9LpAtS9go2hyMW21UljOgRsJrpYT
 z2MQ7v/LpVwKZTGJmfaqE/xieFw==
X-Google-Smtp-Source: AGHT+IGjSUwsQnXmu/wOWvdn+aZb3tmVirzNs306P2u4zQ8EAKd/x5VFO/7YEXw9DnDsVVS+7B6lNQ==
X-Received: by 2002:a05:6a00:22c8:b0:771:f07e:1bfb with SMTP id
 d2e1a72fcca58-771f07e1ce5mr6920475b3a.30.1756256833970; 
 Tue, 26 Aug 2025 18:07:13 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:07:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 24/61] target/arm: Add key parameter to add_cpreg_to_hashtable
Date: Wed, 27 Aug 2025 11:04:15 +1000
Message-ID: <20250827010453.4059782-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Hoist the computation of key into the caller, where
state is a known constant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 02c155418b..a4cd4cf232 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7270,26 +7270,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
                                    CPState state, CPSecureState secstate,
                                    int cp, int crm, int opc1, int opc2,
-                                   const char *name)
+                                   const char *name, uint32_t key)
 {
     CPUARMState *env = &cpu->env;
-    uint32_t key;
     ARMCPRegInfo *r2;
-    bool is64 = r->type & ARM_CP_64BIT;
     bool ns = secstate & ARM_CP_SECSTATE_NS;
     size_t name_len;
 
-    switch (state) {
-    case ARM_CP_STATE_AA32:
-        key = ENCODE_CP_REG(cp, is64, ns, r->crn, crm, opc1, opc2);
-        break;
-    case ARM_CP_STATE_AA64:
-        key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
     /* Overriding of an existing definition must be explicitly requested. */
     if (!(r->type & ARM_CP_OVERRIDE)) {
         const ARMCPRegInfo *oldreg = get_arm_cp_reginfo(cpu->cp_regs, key);
@@ -7394,22 +7381,28 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
      * (same for secure and non-secure world) or banked.
      */
     char *name;
+    bool is64 = r->type & ARM_CP_64BIT;
+    uint32_t key = ENCODE_CP_REG(cp, is64, 0, r->crn, crm, opc1, opc2);
 
     assert(!(r->type & ARM_CP_ADD_TLBI_NXS)); /* aa64 only */
 
     switch (r->secure) {
-    case ARM_CP_SECSTATE_S:
     case ARM_CP_SECSTATE_NS:
+        key |= CP_REG_AA32_NS_MASK;
+        /* fall through */
+    case ARM_CP_SECSTATE_S:
         add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, r->secure,
-                               cp, crm, opc1, opc2, r->name);
+                               cp, crm, opc1, opc2, r->name, key);
         break;
     case ARM_CP_SECSTATE_BOTH:
         name = g_strdup_printf("%s_S", r->name);
         add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
-                               cp, crm, opc1, opc2, name);
+                               cp, crm, opc1, opc2, name, key);
         g_free(name);
+
+        key |= CP_REG_AA32_NS_MASK;
         add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_NS,
-                               cp, crm, opc1, opc2, r->name);
+                               cp, crm, opc1, opc2, r->name, key);
         break;
     default:
         g_assert_not_reached();
@@ -7419,6 +7412,8 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
 static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
                                         int crm, int opc1, int opc2)
 {
+    uint32_t key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
+
     if ((r->type & ARM_CP_ADD_TLBI_NXS) &&
         cpu_isar_feature(aa64_xs, cpu)) {
         /*
@@ -7433,18 +7428,22 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
          */
         ARMCPRegInfo nxs_ri = *r;
         g_autofree char *name = g_strdup_printf("%sNXS", r->name);
+        uint32_t nxs_key;
 
         assert(nxs_ri.crn < 0xf);
         nxs_ri.crn++;
+        nxs_key = key + (1 << CP_REG_ARM64_SYSREG_CRN_SHIFT);
         if (nxs_ri.fgt) {
             nxs_ri.fgt |= R_FGT_NXS_MASK;
         }
+
         add_cpreg_to_hashtable(cpu, &nxs_ri, ARM_CP_STATE_AA64,
-                               ARM_CP_SECSTATE_NS, 0, crm, opc1, opc2, name);
+                               ARM_CP_SECSTATE_NS, 0, crm, opc1, opc2,
+                               name, nxs_key);
     }
 
     add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64, ARM_CP_SECSTATE_NS,
-                           0, crm, opc1, opc2, r->name);
+                           0, crm, opc1, opc2, r->name, key);
 }
 
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
-- 
2.43.0


