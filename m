Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE72CA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4jZ-0005XY-Rm; Tue, 26 Aug 2025 21:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4iD-000205-Lt
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:12:31 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hx-0000M1-Pq
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:12:29 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-771fa8e4190so841733b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257132; x=1756861932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrlBl1QBMO3S/7uPi59WTvH95lxI7KoNo8aFmqKoqOs=;
 b=Loj6+6yiIT4OojEgx98pGBZt9+lf2xMPa3QisEPj9l/8W+0uxaJlPNWL7Ls00mXY1L
 ZugzmYe1CIKINxVuYC06lzp2RWd/MYEvgM4cm09oVjDOd8maEzUin6+rOVL0HXujReaZ
 heZy9BspGBK2xUK2HmzIZvfETT7gJlbghwUKAoxd5BPX164nNLSRXRVF+Or9m18VlNnZ
 CqzuN4LfHgBBdM3WECaHnv5LWf9bI8voycrRTB/blrDhRnahm2qkcHlYmd8D9tc0s/NR
 rY2tk71AaPek+Ri5OwUHYZkVkHEHIjq/R1sF5isYc6aRvYG2nxsxL7ldbLBazH+GvFre
 ZwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257132; x=1756861932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrlBl1QBMO3S/7uPi59WTvH95lxI7KoNo8aFmqKoqOs=;
 b=oAPXwKqOzfrv4OcRiyHF+eahuYKOoAKEjsrUpj+CZCiGE//kp+IJH34nlOpfOdNplJ
 duXU/I0eurwbVQ1UozxgX7aKIa+U+AWIIDKdidRePQgp3u5hkzUbNKhwOtqwq68KkLRl
 k0aX2VQfqKaqvsM29ghDpXQV9ih0LPXvRz/vMba/9+s4Hel6ZvovE1eNTM27YHi8GH4S
 3p8ywafHDqpiN45LFKqTFpN8lchkWe2kvkaKKwlB6oXljoa27KGafWKYgum3PAMANZN5
 JAuc9UkKhcxj61+0hbX5/H0MmUw9Yg48TIGb1Q5oiJDjEeBI75ijqHnFjSdGglyJJ6wc
 hbpg==
X-Gm-Message-State: AOJu0YwfEysCqdv/++2343bxmvXF6A2OuOkf2wtPqyb9uwMBPUQGlQ6h
 baAht3hX+9qLTFw13eS/zHAQiMBOR1Iem7bA8J5hv3tSdairp3QVy6dRss+OwqsCBngdQqn6S8e
 CYJYhF9E=
X-Gm-Gg: ASbGnct+yts4sinCamKguNtMk5U+Dl8npOfaU5btguSKdL+3g7g7mEZ+K+dOGVmtCmq
 IPKvMdEXGcnivB9uFP2LHHCquBZLlyO7kMASTPIhsreQAc+oQ4duLHtIK2nE5TlPQuvhJrdA+C4
 Ye6YU5ptoTDMpZcsrcXkQIkkLbzrEBr/E/YrO5VKS6zWGi5Bs3x/aAPvQtmRPc4F12Rty5ZDjG3
 t7uoVvHuj/jtDClk7EldGf9OxEvvQAhRFW/GwrWgJJAs9HbJ5ovA9bUSRA8UqIAvXP54UhfDiUi
 F5j/b2t2GojzOtDspnx+aNpw3gM0TSD58WaRepa6SeKBN0JHxplMywACCDP7HH6u66vcSy6QuvK
 xM7UDvG5sUh+tklAypLTCvfYbxg==
X-Google-Smtp-Source: AGHT+IGpIU6bqi9tHLKSnlbnPgoHBYYUhqL5PacYSKCcPFhYTjcgmh1Qh08pquNKGc7RHpH/UywLeg==
X-Received: by 2002:a05:6a20:6a11:b0:243:971d:cda8 with SMTP id
 adf61e73a8af0-243971dd0cfmr3530410637.25.1756257131639; 
 Tue, 26 Aug 2025 18:12:11 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:12:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 61/61] target/arm: Extend TTBR system registers to 128-bit
Date: Wed, 27 Aug 2025 11:04:52 +1000
Message-ID: <20250827010453.4059782-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

So far, just extend the data type and check access; do not yet
consume the 128-bit table format.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 31 +++++++++-------
 target/arm/helper.c | 86 ++++++++++++++++++++++++++++++++++++---------
 target/arm/ptw.c    | 14 +++++---
 3 files changed, 96 insertions(+), 35 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 57e298363c..4c929de5ab 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -343,25 +343,30 @@ typedef struct CPUArchState {
         uint32_t c1_xscaleauxcr; /* XScale auxiliary control register.  */
         uint64_t sder; /* Secure debug enable register. */
         uint32_t nsacr; /* Non-secure access control register. */
-        union { /* MMU translation table base 0. */
+        /* MMU translation table bases. */
+        union {
             struct {
-                uint64_t _unused_ttbr0_0;
-                uint64_t ttbr0_ns;
-                uint64_t _unused_ttbr0_1;
-                uint64_t ttbr0_s;
+                uint64_t HOST_ENDIAN_FIELDS(ttbr0_ns, _unused_ttbr0_0);
+                uint64_t HOST_ENDIAN_FIELDS(ttbr1_ns, _unused_ttbr1_0);
             };
-            uint64_t ttbr0_el[4];
+            Int128 ttbr_el1[2];
         };
-        union { /* MMU translation table base 1. */
+        union {
             struct {
-                uint64_t _unused_ttbr1_0;
-                uint64_t ttbr1_ns;
-                uint64_t _unused_ttbr1_1;
-                uint64_t ttbr1_s;
+                uint64_t HOST_ENDIAN_FIELDS(httbr, _unused_httbr_0);
             };
-            uint64_t ttbr1_el[4];
+            Int128 ttbr_el2[2];
+        };
+        union {
+            uint64_t ttbr0_el3;
+            uint64_t ttbr_s[2];
+        };
+        union {
+            struct {
+                uint64_t HOST_ENDIAN_FIELDS(vttbr, _unused_vttbr_0);
+            };
+            Int128 vttbr_el2;
         };
-        uint64_t vttbr_el2; /* Virtualization Translation Table Base.  */
         uint64_t vsttbr_el2; /* Secure Virtualization Translation Table. */
         /* MMU translation table base control. */
         uint64_t tcr_el[4];
diff --git a/target/arm/helper.c b/target/arm/helper.c
index e8442731d4..ebe59a5765 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -512,6 +512,16 @@ static CPAccessResult access_d128(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static CPAccessResult access_tvm_trvm_d128(CPUARMState *env,
+                                           const ARMCPRegInfo *ri, bool isread)
+{
+    CPAccessResult ret = access_tvm_trvm(env, ri, isread);
+    if (ret == CP_ACCESS_OK) {
+        ret = access_d128(env, ri, isread);
+    }
+    return ret;
+}
+
 static void dacr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
 {
     ARMCPU *cpu = env_archcpu(env);
@@ -2923,6 +2933,17 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void vmsa_ttbr_write128(CPUARMState *env, const ARMCPRegInfo *ri,
+                               Int128 value)
+{
+    flush_if_asid_change(env, int128_getlo(raw_read128(env, ri)),
+                         int128_getlo(value),
+                         ARMMMUIdxBit_E10_1 |
+                         ARMMMUIdxBit_E10_1_PAN |
+                         ARMMMUIdxBit_E10_0);
+    raw_write128(env, ri, value);
+}
+
 static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
@@ -2941,6 +2962,19 @@ static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void vmsa_tcr_ttbr_el2_write128(CPUARMState *env, const ARMCPRegInfo *ri,
+                                       Int128 value)
+{
+    if (arm_hcr_el2_eff(env) & HCR_E2H) {
+        flush_if_asid_change(env, int128_getlo(raw_read128(env, ri)),
+                             int128_getlo(value),
+                             ARMMMUIdxBit_E20_2 |
+                             ARMMMUIdxBit_E20_2_PAN |
+                             ARMMMUIdxBit_E20_0);
+    }
+    raw_write128(env, ri, value);
+}
+
 static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                         uint64_t value)
 {
@@ -2952,6 +2986,14 @@ static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void vttbr_write128(CPUARMState *env, const ARMCPRegInfo *ri,
+                           Int128 value)
+{
+    flush_if_asid_change(env, int128_getlo(raw_read128(env, ri)),
+                         int128_getlo(value), alle1_tlbmask(env));
+    raw_write128(env, ri, value);
+}
+
 static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] = {
     { .name = "DFSR", .cp = 15, .crn = 5, .crm = 0, .opc1 = 0, .opc2 = 0,
       .access = PL1_RW, .accessfn = access_tvm_trvm, .type = ARM_CP_ALIAS,
@@ -3327,30 +3369,36 @@ static void define_ttbr_registers(ARMCPU *cpu)
         { .name = "TTBR0_EL1", .state = ARM_CP_STATE_AA64,
           .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
           .access = PL1_RW, .accessfn = access_tvm_trvm,
-          .fgt = FGT_TTBR0_EL1,
+          .access128fn = access_tvm_trvm_d128,
+          .fgt = FGT_TTBR0_EL1, .type = ARM_CP_128BIT,
           .nv2_redirect_offset = 0x200 | NV2_REDIR_NV1,
           .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 0, 0),
           .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 0, 0),
           .writefn = vmsa_ttbr_write, .raw_writefn = raw_write,
-          .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[1]) },
+          .write128fn = vmsa_ttbr_write128, .raw_write128fn = raw_write128,
+          .fieldoffset = offsetof(CPUARMState, cp15.ttbr_el1[0]) },
         { .name = "TTBR1_EL1", .state = ARM_CP_STATE_AA64,
           .opc0 = 3, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
           .access = PL1_RW, .accessfn = access_tvm_trvm,
-          .fgt = FGT_TTBR1_EL1,
+          .access128fn = access_tvm_trvm_d128,
+          .fgt = FGT_TTBR1_EL1, .type = ARM_CP_128BIT,
           .nv2_redirect_offset = 0x210 | NV2_REDIR_NV1,
           .vhe_redir_to_el2 = ENCODE_AA64_CP_REG(3, 4, 2, 0, 1),
           .vhe_redir_to_el01 = ENCODE_AA64_CP_REG(3, 5, 2, 0, 1),
           .writefn = vmsa_ttbr_write, .raw_writefn = raw_write,
-          .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[1]) },
+          .write128fn = vmsa_ttbr_write128, .raw_write128fn = raw_write128,
+          .fieldoffset = offsetof(CPUARMState, cp15.ttbr_el1[1]) },
         { .name = "TTBR0_EL2", .state = ARM_CP_STATE_AA64,
           .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 0,
-          .access = PL2_RW, .resetvalue = 0,
+          .access = PL2_RW, .access128fn = access_d128, .type = ARM_CP_128BIT,
           .writefn = vmsa_tcr_ttbr_el2_write, .raw_writefn = raw_write,
-          .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2]) },
+          .write128fn = vmsa_tcr_ttbr_el2_write128,
+          .raw_write128fn = raw_write128,
+          .fieldoffset = offsetof(CPUARMState, cp15.ttbr_el2[0]) },
         { .name = "TTBR0_EL3", .state = ARM_CP_STATE_AA64,
           .opc0 = 3, .opc1 = 6, .crn = 2, .crm = 0, .opc2 = 0,
           .access = PL3_RW, .resetvalue = 0,
-          .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[3]) },
+          .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el3) },
     };
 
     static ARMCPRegInfo ttbr64_reginfo[] = {
@@ -3365,7 +3413,7 @@ static void define_ttbr_registers(ARMCPU *cpu)
         [0].fieldoffset = offsetof(CPUARMState, cp15.ttbr0_ns),
         [1].name = "TTBR0_S",
         [1].secure = ARM_CP_SECSTATE_S,
-        [1].fieldoffset = offsetof(CPUARMState, cp15.ttbr0_s),
+        [1].fieldoffset = offsetof(CPUARMState, cp15.ttbr_s[0]),
 
         [2 ... 3].opc1 = 1,
         [2].name = "TTBR1",
@@ -3373,12 +3421,12 @@ static void define_ttbr_registers(ARMCPU *cpu)
         [2].fieldoffset = offsetof(CPUARMState, cp15.ttbr1_ns),
         [3].name = "TTBR1_S",
         [3].secure = ARM_CP_SECSTATE_S,
-        [3].fieldoffset = offsetof(CPUARMState, cp15.ttbr1_s),
+        [3].fieldoffset = offsetof(CPUARMState, cp15.ttbr_s[1]),
 
         [4] = {
             .name = "HTTBR", .cp = 15, .crm = 2, .opc1 = 4,
             .access = PL2_RW, .type = ARM_CP_64BIT,
-            .fieldoffset = offsetof(CPUARMState, cp15.ttbr0_el[2])
+            .fieldoffset = offsetof(CPUARMState, cp15.httbr)
         },
     };
 
@@ -3386,12 +3434,12 @@ static void define_ttbr_registers(ARMCPU *cpu)
         { .name = "TTBR0", .cp = 15, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 0,
           .access = PL1_RW, .accessfn = access_tvm_trvm,
           .writefn = vmsa_ttbr_write, .raw_writefn = raw_write,
-          .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr0_s),
+          .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr_s[0]),
                                  offsetof(CPUARMState, cp15.ttbr0_ns) } },
         { .name = "TTBR1", .cp = 15, .opc1 = 0, .crn = 2, .crm = 0, .opc2 = 1,
           .access = PL1_RW, .accessfn = access_tvm_trvm,
           .writefn = vmsa_ttbr_write, .raw_writefn = raw_write,
-          .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr1_s),
+          .bank_fieldoffsets = { offsetof(CPUARMState, cp15.ttbr_s[1]),
                                  offsetof(CPUARMState, cp15.ttbr1_ns) } },
     };
 
@@ -4460,11 +4508,14 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .cp = 15, .opc1 = 6, .crm = 2,
       .type = ARM_CP_64BIT | ARM_CP_ALIAS,
       .access = PL2_RW, .accessfn = access_el3_aa32ns,
-      .fieldoffset = offsetof(CPUARMState, cp15.vttbr_el2),
+      .fieldoffset = offsetof(CPUARMState, cp15.vttbr),
       .writefn = vttbr_write, .raw_writefn = raw_write },
     { .name = "VTTBR_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 0,
-      .access = PL2_RW, .writefn = vttbr_write, .raw_writefn = raw_write,
+      .type = ARM_CP_128BIT,
+      .access = PL2_RW, .access128fn = access_d128,
+      .writefn = vttbr_write, .raw_writefn = raw_write,
+      .write128fn = vttbr_write128, .raw_write128fn = raw_write128,
       .nv2_redirect_offset = 0x20,
       .fieldoffset = offsetof(CPUARMState, cp15.vttbr_el2) },
     { .name = "SCTLR_EL2", .state = ARM_CP_STATE_BOTH,
@@ -6016,9 +6067,10 @@ static const ARMCPRegInfo contextidr_el2 = {
 static const ARMCPRegInfo vhe_reginfo[] = {
     { .name = "TTBR1_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 0, .opc2 = 1,
-      .access = PL2_RW, .writefn = vmsa_tcr_ttbr_el2_write,
-      .raw_writefn = raw_write,
-      .fieldoffset = offsetof(CPUARMState, cp15.ttbr1_el[2]) },
+      .access = PL2_RW, .access128fn = access_d128, .type = ARM_CP_128BIT,
+      .writefn = vmsa_tcr_ttbr_el2_write, .raw_writefn = raw_write,
+      .write128fn = vmsa_tcr_ttbr_el2_write128, .raw_write128fn = raw_write128,
+      .fieldoffset = offsetof(CPUARMState, cp15.ttbr_el2[1]) },
 #ifndef CONFIG_USER_ONLY
     { .name = "CNTHV_CVAL_EL2", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 4, .crn = 14, .crm = 3, .opc2 = 2,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 561bf2678e..105c2cb07b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -208,7 +208,7 @@ static bool regime_translation_big_endian(CPUARMState *env, ARMMMUIdx mmu_idx)
     return (regime_sctlr(env, mmu_idx) & SCTLR_EE) != 0;
 }
 
-/* Return the TTBR associated with this translation regime */
+/* Return the 64-bit TTBR associated with this translation regime */
 static uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx, int ttbrn)
 {
     if (mmu_idx == ARMMMUIdx_Stage2) {
@@ -217,11 +217,15 @@ static uint64_t regime_ttbr(CPUARMState *env, ARMMMUIdx mmu_idx, int ttbrn)
     if (mmu_idx == ARMMMUIdx_Stage2_S) {
         return env->cp15.vsttbr_el2;
     }
-    if (ttbrn == 0) {
-        return env->cp15.ttbr0_el[regime_el(env, mmu_idx)];
-    } else {
-        return env->cp15.ttbr1_el[regime_el(env, mmu_idx)];
+    switch (regime_el(env, mmu_idx)) {
+    case 1:
+        return int128_getlo(env->cp15.ttbr_el1[ttbrn]);
+    case 2:
+        return int128_getlo(env->cp15.ttbr_el2[ttbrn]);
+    case 3:
+        return env->cp15.ttbr_s[ttbrn];
     }
+    g_assert_not_reached();
 }
 
 /* Return true if the specified stage of address translation is disabled */
-- 
2.43.0


