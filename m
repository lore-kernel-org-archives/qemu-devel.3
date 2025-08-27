Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CB2CA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4fA-0003bR-0h; Tue, 26 Aug 2025 21:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dz-0001Gr-HO
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:08:08 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dm-0007ed-Lp
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:08:07 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-771ed4a8124so2426284b3a.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256871; x=1756861671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5ghDBN8QlbhbdkALth1ufxnSXLIXRFpEbZ7zrY4wQo=;
 b=gwd3JexAZ0P0GzkdDEKWWeT5Q2hpyibQsahJ1KcWb6CVHBldwRlEkLyPpw2N3hEaSp
 g5AG4nsAZs4hH+/1ibyeuBw2b9YK2SoURB4NFLG6poNgNjLXa4+a+MK3eDuI2bBOUTyY
 UUKSg1qtiMDcUfbdLpC6wytNtLQnHQM8lYfRTof/tB4ESQw4flhTLcrYtbR5UO5E/EH5
 J6Fgq4pgjERDgx51HPj/hT+9ZuCy2b8uU6O4dGghIYFwuTeMrnIF2kMY3Vhmdz+QZPnW
 de1t3OmNzjwk6LPhgfyuNTdTyIvZcJRFGDW6YMD+Bk2alfhmoSXZK0JDGi4JY1ejIYCq
 eePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256871; x=1756861671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5ghDBN8QlbhbdkALth1ufxnSXLIXRFpEbZ7zrY4wQo=;
 b=TCkze3fcd6VXpJHG89LPhWhQDeVjOTr7eRyeGJnFIoGeIaSy3i5H2YBuwSidffRfyb
 87IiVgmqzqu3/+rEL2TBgnk1OLkxVaBxvFpBBZ9wwAzKQ6pbV8gRbkMgCUmgPOO5em4e
 OEOEv6PmVaoA6ASEkL4Yira1H0yQ1/HzWdsQfpq9tHf1PEZqIaqjFVNey8bjdIokrMu+
 EbxTTiJtgCmfYN7HhEsplJ34lO/Fz4sB84Esnh9sUUbx1SGLdznWYA9OagYexdX1TRYn
 gZiJrAnH6cBWxvuzf01rOqN43ZkdGEgxGIfYNu3HNBbpMlK5vAyh3v0HFToqYXSMNvJu
 j0vg==
X-Gm-Message-State: AOJu0YxlhpKB3sA48nHd1dTyheO6lgijskOw1lgS1KzwHMCnRU0/kZDz
 vJKZAvkY3xKYIuumUOUsSBJMVOdeVMOJHduLLkXxn9tXGE7pVlQXvC8zMwuNtEr6qHUYfmD7EFu
 bdf37S34=
X-Gm-Gg: ASbGncu3Rr4YVRM4Hp2d/b+9Mo0GQAv7/CKKwPHZ1TNbfghzmpxzcMkTnmm0qU6M9zl
 Rz9ekxc1ijrS3tHzfoxI7DJt2dJAWr2UQw5IXFnuAWO9N6ZB61ebgQ9sSNQezu4THIVcdKSa2e+
 f3151OgOz4GeygSvDfoQOgmZJjvZ/OW3zVF97Eh44ucdoI6JMtZMfAF8aYZfvYeIomaNsBI9t64
 OYLNoYP/cwjfauo4hCzeHkKaY+ki+N6OyWVW77AuCqXL/QLsWj4yBr1NLE7qIxRfKqQRZMfu8SL
 o56lIw8JabLontL+VsEEjtuIPE0GFzH1h1C5faxgifIsgnPZR6xPxNIC6Ylh2XUryEDbQnQAV5S
 YHacFaScg9cv7W5wHL+r8vdsbvIY/7gsY4qDZ
X-Google-Smtp-Source: AGHT+IHkd0SYEr4KzvoM4W4HNrAX6dw4EFImaUwgu9yAQBGXNpFt5XIL96Dxr0632DMOh7vdyMl82w==
X-Received: by 2002:a05:6a00:2441:b0:771:ead8:dcdb with SMTP id
 d2e1a72fcca58-771ead8f33amr9903414b3a.8.1756256870597; 
 Tue, 26 Aug 2025 18:07:50 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:07:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 34/61] target/arm: Redirect VHE FOO_EL12 to FOO_EL1 during
 translation
Date: Wed, 27 Aug 2025 11:04:25 +1000
Message-ID: <20250827010453.4059782-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            | 22 ++++---------
 target/arm/gdbstub.c           |  2 ++
 target/arm/helper.c            | 57 +++-------------------------------
 target/arm/tcg/translate-a64.c | 12 +++++++
 4 files changed, 25 insertions(+), 68 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index d34ed0d40b..f5d6a1c386 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -917,8 +917,12 @@ struct ARMCPRegInfo {
      */
     uint32_t vhe_redir_to_el2;
 
-    /* This is used only by VHE. */
-    void *opaque;
+    /*
+     * With VHE, with E2H, at EL2+, access to this EL02/EL12 reg
+     * redirects to the EL0/EL1 reg with the specified key.
+     */
+    uint32_t vhe_redir_to_el01;
+
     /*
      * Value of this register, if it is ARM_CP_CONST. Otherwise, if
      * fieldoffset is non-zero, the reset value of the register.
@@ -986,20 +990,6 @@ struct ARMCPRegInfo {
      * fieldoffset is 0 then no reset will be done.
      */
     CPResetFn *resetfn;
-
-    /*
-     * "Original" readfn, writefn, accessfn.
-     * For ARMv8.1-VHE register aliases, we overwrite the read/write
-     * accessor functions of various EL1/EL0 to perform the runtime
-     * check for which sysreg should actually be modified, and then
-     * forwards the operation.  Before overwriting the accessors,
-     * the original function is copied here, so that accesses that
-     * really do go to the EL1/EL0 version proceed normally.
-     * (The corresponding EL2 register is linked via opaque.)
-     */
-    CPReadFn *orig_readfn;
-    CPWriteFn *orig_writefn;
-    CPAccessFn *orig_accessfn;
 };
 
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *regs);
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 3727dc01af..269bc6c132 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -253,6 +253,8 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
                 (arm_hcr_el2_eff(env) & HCR_E2H) &&
                 arm_current_el(env) == 2) {
                 ri = get_arm_cp_reginfo(cpu->cp_regs, ri->vhe_redir_to_el2);
+            } else if (ri->vhe_redir_to_el01) {
+                ri = get_arm_cp_reginfo(cpu->cp_regs, ri->vhe_redir_to_el01);
             }
             return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
         case MO_32:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3f69ce6cb5..a19406e136 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4441,42 +4441,6 @@ static CPAccessResult access_el1nvvct(CPUARMState *env, const ARMCPRegInfo *ri,
     return e2h_access(env, ri, isread);
 }
 
-static uint64_t el2_e2h_e12_read(CPUARMState *env, const ARMCPRegInfo *ri)
-{
-    /* Pass the EL1 register accessor its ri, not the EL12 alias ri */
-    return ri->orig_readfn(env, ri->opaque);
-}
-
-static void el2_e2h_e12_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                              uint64_t value)
-{
-    /* Pass the EL1 register accessor its ri, not the EL12 alias ri */
-    return ri->orig_writefn(env, ri->opaque, value);
-}
-
-static CPAccessResult el2_e2h_e12_access(CPUARMState *env,
-                                         const ARMCPRegInfo *ri,
-                                         bool isread)
-{
-    if (arm_current_el(env) == 1) {
-        /*
-         * This must be a FEAT_NV access (will either trap or redirect
-         * to memory). None of the registers with _EL12 aliases want to
-         * apply their trap controls for this kind of access, so don't
-         * call the orig_accessfn or do the "UNDEF when E2H is 0" check.
-         */
-        return CP_ACCESS_OK;
-    }
-    /* FOO_EL12 aliases only exist when E2H is 1; otherwise they UNDEF */
-    if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
-        return CP_ACCESS_UNDEFINED;
-    }
-    if (ri->orig_accessfn) {
-        return ri->orig_accessfn(env, ri->opaque, isread);
-    }
-    return CP_ACCESS_OK;
-}
-
 static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
 {
     struct E2HAlias {
@@ -4566,9 +4530,6 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         g_assert(strcmp(src_reg->name, a->src_name) == 0);
         g_assert(strcmp(dst_reg->name, a->dst_name) == 0);
 
-        /* None of the core system registers use opaque; we will.  */
-        g_assert(src_reg->opaque == NULL);
-
         /* Create alias before redirection so we dup the right data. */
         new_reg = g_memdup(src_reg, sizeof(ARMCPRegInfo));
 
@@ -4587,19 +4548,11 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
             >> CP_REG_ARM64_SYSREG_OP1_SHIFT;
         new_reg->opc2 = (a->new_key & CP_REG_ARM64_SYSREG_OP2_MASK)
             >> CP_REG_ARM64_SYSREG_OP2_SHIFT;
-        new_reg->opaque = src_reg;
-        new_reg->orig_readfn = src_reg->readfn ?: raw_read;
-        new_reg->orig_writefn = src_reg->writefn ?: raw_write;
-        new_reg->orig_accessfn = src_reg->accessfn;
-        if (!new_reg->raw_readfn) {
-            new_reg->raw_readfn = raw_read;
-        }
-        if (!new_reg->raw_writefn) {
-            new_reg->raw_writefn = raw_write;
-        }
-        new_reg->readfn = el2_e2h_e12_read;
-        new_reg->writefn = el2_e2h_e12_write;
-        new_reg->accessfn = el2_e2h_e12_access;
+        new_reg->vhe_redir_to_el01 = a->src_key;
+        new_reg->readfn = NULL;
+        new_reg->writefn = NULL;
+        new_reg->accessfn = NULL;
+        new_reg->fieldoffset = 0;
 
         /*
          * If the _EL1 register is redirected to memory by FEAT_NV2,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8fcc74d151..7de8717056 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2580,6 +2580,18 @@ static void handle_sys(DisasContext *s, bool isread,
          */
         key = ri->vhe_redir_to_el2;
         ri = redirect_cpreg(s, key, isread);
+    } else if (ri->vhe_redir_to_el01 && s->current_el >= 2) {
+        /*
+         * This is one of the FOO_EL12 registers.
+         * With !E2H, they all UNDEF.
+         * With E2H, from EL2 or EL3, they redirect to FOO_EL1.
+         */
+        if (!s->e2h) {
+            gen_sysreg_undef(s, isread, op0, op1, op2, crn, crm, rt);
+            return;
+        }
+        key = ri->vhe_redir_to_el01;
+        ri = redirect_cpreg(s, key, isread);
     }
 
     if (ri->accessfn || (ri->fgt && s->fgt_active)) {
-- 
2.43.0


