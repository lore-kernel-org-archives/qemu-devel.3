Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D41CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v299v-0000lS-4S; Fri, 26 Sep 2025 10:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v299N-00006m-Ak
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298a-0005lp-Du
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:14 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so19549465e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895763; x=1759500563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DjT9lISCaQBeI88j1b+YFCNbfn0WTQJFDq4zyRv2P5w=;
 b=FwbDh5K1Wz0D7adnonCY4IAaLq7JiHa7nTdFYEqstCMIF5Xt7L0MTXHdHNCy52TYxF
 Gyv/cpo4NhYRzvItHXZV4KK7Osb4HJSo8e6ME7iZvQyheHgRpCo2WAE7qdyDlJZvPS7M
 GEm4FgGBJhNFm2cTcmplaU5wyObqfPNVpt+foiFxuXWQ/E43gUlbGuE6PDR66DaArijv
 dTurCG1GTVh2A1NnxTjoo75DJ2wgy34U7gxkCQXJtS2dGky1okHKNcy6acDRg3ZHV+Qu
 oFzE4a2TfiFbqPrd5woHi/Z558Bqh+GnZ3mK+nV/Dkwg5MwwS/TVEFxwMTE2ZkraBR/m
 n4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895763; x=1759500563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DjT9lISCaQBeI88j1b+YFCNbfn0WTQJFDq4zyRv2P5w=;
 b=qAxJnkI9EQHTSFo6wKN92Nhl7fvuGUBP8TyM+Bex3OGzd/KRNHRNZof5HSk/lqg9JC
 EzwjrlFD2CRcw0XK+75L1me2eWEDT8JCgYGnlwh3vHmi1FjGE3rOjWb2omAUVn7RrCMR
 8rKXmxsYfjgJmScSa1w5qKUQIOwnbe8hL9ckKj3DvZjHQ9HUoA8/xEL1BqDCnoUdiEbx
 9ZE7v8It/tE3zhLJ7nDcKGeXxazoqTTZWqmcDNFaE8dV+EcH5sjzlw4PG2Kk4Rg0SWRw
 bLQ7Q2y2/v1fjCDiWKMlqPXg/G7GKbYvtLyVpcK2bdWSmVAkzuSmcSDxpD7bu8F2W34z
 BjUA==
X-Gm-Message-State: AOJu0Yx81qHJRpJnIIh5VgxbDBMJyfPAkqXbu4WHZUziFTRdFGAvtGlC
 /SqHm9hwGY25njNuoYx05Stl+fWtKskNJtHDmHsOLQiMRD6cfmiXR745xBNhTOLNI0ovz+DfGUc
 xMvpw
X-Gm-Gg: ASbGncvH44EvAwIK1k/n4OXBjhgq6stma3j6CRu3y9yi8v3+CtieW15A/1xpbhkbtcH
 J1gsjRkdsRcUyH3JV45k1MUKPddc8AyJRW22Bb6QotLFrEx+XuMvBUjTCKwRzChfGo1XEZBclSz
 T+XE6MMUlRtQ8qxs8icBoXogMtj0XoTde0/drCUabLQbOXQ+TUGwevc4AZBOCfbZjZftEFdSWaK
 RyJPyEvyaP2zUMPbNOF/fqqJa5yrF/LZ1lBq3M86yPwJIzsCxlsMGX77PzRpZt4ZhU17wFKMB3m
 YHI23bD+IzuAg7HBH9SDN8b1PAMy+LnyJz2J3vifXPRVu9N67YK1paTCTD9FJGiqcXwitSxpG9H
 xqtZHxAZrOCvdpkaC20rk0pBt3iZL
X-Google-Smtp-Source: AGHT+IF5lUB+EfsAs4tq3mMz42eeK/x13Zl52IO0BYNbIwPcaY2CiRztFPNt6MSbe01eEtJVbNWJDg==
X-Received: by 2002:a05:6000:40dc:b0:3ee:13b1:d70e with SMTP id
 ffacd0b85a97d-40e47ee1da9mr7433145f8f.40.1758895762863; 
 Fri, 26 Sep 2025 07:09:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/44] target/arm: Redirect VHE FOO_EL12 to FOO_EL1 during
 translation
Date: Fri, 26 Sep 2025 15:08:36 +0100
Message-ID: <20250926140844.1493020-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMM: expanded a comment slightly]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h            | 22 ++++---------
 target/arm/gdbstub.c           |  2 ++
 target/arm/helper.c            | 57 +++-------------------------------
 target/arm/tcg/translate-a64.c | 12 +++++++
 4 files changed, 25 insertions(+), 68 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index eac0cb9ebf1..8ab5892acce 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -942,8 +942,12 @@ struct ARMCPRegInfo {
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
@@ -1011,20 +1015,6 @@ struct ARMCPRegInfo {
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
index 87d40d4366b..8d2229f5192 100644
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
index 87a32e363e9..3840ca62a69 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4417,42 +4417,6 @@ static CPAccessResult access_el1nvvct(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -4541,9 +4505,6 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
         g_assert(strcmp(src_reg->name, a->src_name) == 0);
         g_assert(strcmp(dst_reg->name, a->dst_name) == 0);
 
-        /* None of the core system registers use opaque; we will.  */
-        g_assert(src_reg->opaque == NULL);
-
         /* Create alias before redirection so we dup the right data. */
         new_reg = g_memdup(src_reg, sizeof(ARMCPRegInfo));
 
@@ -4562,19 +4523,11 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
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
index 3ef24fb0c3d..a0e3300231f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2580,6 +2580,18 @@ static void handle_sys(DisasContext *s, bool isread,
          */
         key = ri->vhe_redir_to_el2;
         ri = redirect_cpreg(s, key, isread);
+    } else if (ri->vhe_redir_to_el01 && s->current_el >= 2) {
+        /*
+         * This is one of the FOO_EL12 or FOO_EL02 registers.
+         * With !E2H, they all UNDEF.
+         * With E2H, from EL2 or EL3, they redirect to FOO_EL1/FOO_EL0.
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


