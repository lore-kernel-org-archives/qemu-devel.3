Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F40CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWar-0006Lp-AK; Tue, 16 Sep 2025 10:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaX-0005v3-Aj
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:21 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaT-0008MI-Aw
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:20 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b54acc8c96eso3821362a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032578; x=1758637378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aYtAYFlCCwkQWVKst4EMyP1kPI4iTxoV2MGMTex6t8A=;
 b=OCJli5m6ZJpnvIB20IaJoar56913aQ3arlkjGOU2YjgQg5WYxTX7sN0k2eNXxe2zeO
 fpAvrI1KRn31mVOavrVb1VpZUMR8sBaLeMKHTODxHVQBGXGq0ULFNOMPXjjLosSJa+F5
 cHsTFID6yDUWS3TgUjZcZXxy70thDGAB/iwlpFgOFps7Rdep/9DsfoOWBoHOa8hRQAZc
 rfDnYXsjhbP8sGlflFRp0YSiVNKArqKD6hFSCegQIqKo+d8IASHhTIfUShYZrrz3B01c
 k6fVg+H0lY2CiLzCa7+dxxee5C3kMAkuebW6PPrIiWYZrGWoBFQeFtK3YDJVPjaeCiW3
 gS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032578; x=1758637378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aYtAYFlCCwkQWVKst4EMyP1kPI4iTxoV2MGMTex6t8A=;
 b=t5E2AH+oucTr5jF434gAuK5/S0sYWK4xhwy49lPFuWAcyqkVDK/TVrdd0+fubPyXPU
 bSYhIhy4PDQt5E0CMp6BokG/fLSVrScShc0iN+bo22QWsDUCIGxHdouXopCOW+qV4Eob
 xXBnFAM+eUd9boz19hJK/hEj7WJ7nKA5Z4kpmdY/QtPgzO/EaC2OvTJwIhI+0Axdj5zT
 AGjyf6AvzvKehrdJSJ4RGXdG9NOVSQTgPbeWYJHUM0Gd2vrwPnMXU5lA5bf7ggVCz9gZ
 hzgo8MLRjWT8dAYYMg+CKbpS5xhGm3FvTwag3zdJOX+QHezqeRBwT9CV77vzKC4LfhWd
 duhg==
X-Gm-Message-State: AOJu0YzSDZll26gwLYMwOpdOt0jke3dhR9/bzBKrRLZAEgjbMtXtSwXl
 wCZjcaUIFvnq2KCc5eX4CYRZStNLSqsDVkAOVhcxSuEjBxGIrWusO4iTc5AFdNUWhWpqi7Dpk5v
 fTskk
X-Gm-Gg: ASbGncuIykFabjWcPZFFUcpm6lXSR/OCrq9nsbiS1eE0uHMnkqYzhu8YrGb79x2mJx4
 Q/s3XaqM7j6zXbejoRYsrtjkoMGPyuifUiBwLZDoASHDkNmmzMKebM7VDcRzbWVqztNf1zjbGE8
 /YQYRe7joUNE7IK7ra8YOG62aJCFa3aVkvQQo064wKAw1vv6Yt2+Qfd3WdSdmmLNXqBAjoZoyqY
 jNzgtgP6ZvcU92ljzQDX7CWXyPm0ecYgyuJs8SaXbfKykW/5rg77uKxq9w9cEZL4ADiJMcMMBKf
 9feRi0MwitghaChhFxpa+MUABh2dBl3DpyGiYPGW9mGrG36dkkdkurpHYGnOwXtBjEZNJDwJ/9m
 RlOuZ+MtkiKpu4Krrt0iLQozTCBv0
X-Google-Smtp-Source: AGHT+IEe8VFXmDlrf0Bdw8LTQ6PJcAQOvBC1c9hgeyEvWIIicLDlzk8jSEXAjRxHu1ng6X/z3TbURA==
X-Received: by 2002:a17:903:1904:b0:246:4077:455b with SMTP id
 d9443c01a7336-25d2675f896mr186980815ad.36.1758032578111; 
 Tue, 16 Sep 2025 07:22:58 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:22:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 24/36] target/arm: Add key parameter to
 add_cpreg_to_hashtable
Date: Tue, 16 Sep 2025 07:22:25 -0700
Message-ID: <20250916142238.664316-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Hoist the computation of key into the caller, where
state is a known constant.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4a109a113d..a5195e296d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7424,26 +7424,13 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
@@ -7548,22 +7535,28 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
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
@@ -7573,6 +7566,8 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
 static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
                                         int crm, int opc1, int opc2)
 {
+    uint32_t key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
+
     if ((r->type & ARM_CP_ADD_TLBI_NXS) &&
         cpu_isar_feature(aa64_xs, cpu)) {
         /*
@@ -7587,18 +7582,22 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
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


