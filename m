Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5993CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQjU-0006o9-Vi; Tue, 16 Jun 2026 06:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjT-0006kE-Bw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:23 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjQ-0003rI-H7
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:22 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c8584e80d59so1706961a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604559; x=1782209359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4uJFCvbOydXUAuweKD6FNennFCxp3AJxi62BKOYAl0=;
 b=FN1DJW1rFZ5H/wkwy1GmncLJ+SAdw848JysJykqTnr7fihjLx6leN/HJAf4qGCXQGS
 jrXotzHumWgCXSIK5WtsvsZpqNZraKhvOkhgUJQu94tF9d1Shia1Zn7xZ0fYRfpDGeFa
 sHUQxueMlfxRK0ATsYDEdXjmjn3ae+kP3FfUZ7sLKt2T5IhO50eXjQ55R55bzeMDpHte
 IaxygLoHlCI5fPzO3d5kIBthdNHilkZMApv/demgISeEYF+EVdzm6TWP2WeZ6/xF3tbd
 BAmnyfwjIcSN4VGBr5BeG/v586FkgKzdmtnjYhJD/x745W5wsyaK1nOTbON0aoywAK/1
 AHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604559; x=1782209359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X4uJFCvbOydXUAuweKD6FNennFCxp3AJxi62BKOYAl0=;
 b=fRISr7vMXTqAZE4WFUdvdM8mWtp/zBFv2CTUWT7i4Jjg3tSuIhpXBKU8X7n4yJT5rQ
 dgSM4vRAgfxoKbyifJGdmqDaJXNvh/UdY/sdXg+p91PashbFVlPQ9iZxiKOkBA0mn3cj
 1MOzl6p0rU+0uE0LNFGcV8wXsZowVbI5thhUlXWVpbB2Zlp2BtDVfnTFwZbSe2Po0Uf9
 x/Mi/ISdCUQinDC5E0YM7DzqcmaYk5cXeYBRn2e8t0VrVg7bKZ+tO5ZNYOYpiwRAC8Ns
 LAm04L5Tm4WqU0FU3ISaEViYA0uB11hST8plxknP/IWtXQ4XL5+ERWFW86cEMNSzPWr3
 MUkw==
X-Gm-Message-State: AOJu0YyrCxdsX7USU8pTchQbxnIr3yPfINBcDtjcjD8H/4TGvfAEq4JB
 oPuiKwUOW6fS3HIzJ5M59iOfCaaTmc4w/Zzd+iJp+3fMpJ/3oNBpFJBkeWJ7MQQl
X-Gm-Gg: Acq92OGA1MFaxISbglZgz6FS2PjGU9HKLm+5v97oxCkEUEb9NDHma2Ms7Uw6bKF3WrE
 P2sPNbf77sKtc/4vN0n3qgObDYCMm3cQFlYWN3+KaBtGPqebOrHwdpiFV4YDU6uKa6sfalIZjCq
 1dbZTn99k5rBT/Lr965F0RbqVU6ZQxu61fmwTyaV0K3jWX0sKN1n57iuj3K930/PleNhZ+PK/Fi
 UtMZuhpD47XWc2bvaHFgy6qXwFKqMu0fuxOc8pL6lVJmEFAYtb/FysFX4gTedFLihex2cHA1Iad
 uw2q9kt8+si1mIUSazke5MRe5WodOEmoCjgseHAFCK0c2o5Qr8Bey2sL/1pRfeh+TadqZf4NTUU
 IpNduOhGolFfZeSn+SytrAkvU+5eYkj+Frm53Zv/7Dir0RWRGkAEwjQhSsfOuSfEw/hrQ7y3xMw
 1iyy4f25dBxcq7lT3W1cvEdzGKLq2hDTmy0LHsr9pvCwrw/LugT04=
X-Received: by 2002:a05:6a21:7d04:b0:3b4:7d99:a23f with SMTP id
 adf61e73a8af0-3b7840a75a0mr20950510637.45.1781604559070; 
 Tue, 16 Jun 2026 03:09:19 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 64/83] target/riscv: rvv: Set mstatus.FS dirty when vector FP
 raises exceptions
Date: Tue, 16 Jun 2026 20:05:07 +1000
Message-ID: <20260616100527.1939565-65-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Max Chou <max.chou@sifive.com>

According to the RISC-V privileged spec 3.1.6, any instruction that
modifies FP extension state (FP CSRs including fflags, or f registers)
must set mstatus.FS to Dirty.  Raising fflags bits is modifying fcsr
(an FP CSR).

When a vector FP instruction raises a floating-point exception, it
modifies fflags (an FP CSR), but current implementation was not marking
mstatus.FS dirty in this case.

Fix the issue by snapshot fflags before the element loop and OR
MSTATUS_FS into env->mstatus if any new exception bits are set
afterwards.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260611105037.157773-3-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 241 +++++++++++++++++++----------------
 1 file changed, 128 insertions(+), 113 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 89012fccb3..e321ca2616 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3172,34 +3172,36 @@ static void do_##NAME(void *vd, void *vs1, void *vs2, int i,   \
     *((TD *)vd + HD(i)) = OP(s2, s1, &env->fp_status);         \
 }
 
-#define GEN_VEXT_VV_ENV(NAME, ESZ)                        \
-void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
-                  void *vs2, CPURISCVState *env,          \
-                  uint32_t desc)                          \
-{                                                         \
-    uint32_t vm = vext_vm(desc);                          \
-    uint32_t vl = env->vl;                                \
-    uint32_t total_elems =                                \
-        vext_get_total_elems(env, desc, ESZ);             \
-    uint32_t vta = vext_vta(desc);                        \
-    uint32_t vma = vext_vma(desc);                        \
-    uint32_t i;                                           \
-                                                          \
-    VSTART_CHECK_EARLY_EXIT(env, vl);                     \
-                                                          \
-    for (i = env->vstart; i < vl; i++) {                  \
-        if (!vm && !vext_elem_mask(v0, i)) {              \
-            /* set masked-off elements to 1s */           \
-            vext_set_elems_1s(vd, vma, i * ESZ,           \
-                              (i + 1) * ESZ);             \
-            continue;                                     \
-        }                                                 \
-        do_##NAME(vd, vs1, vs2, i, env);                  \
-    }                                                     \
-    env->vstart = 0;                                      \
-    /* set tail elements to 1s */                         \
-    vext_set_elems_1s(vd, vta, vl * ESZ,                  \
-                      total_elems * ESZ);                 \
+#define GEN_VEXT_VV_ENV(NAME, ESZ)                           \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,  \
+                  CPURISCVState *env, uint32_t desc)         \
+{                                                            \
+    uint32_t vm = vext_vm(desc);                             \
+    uint32_t vl = env->vl;                                   \
+    uint32_t total_elems =                                   \
+        vext_get_total_elems(env, desc, ESZ);                \
+    uint32_t vta = vext_vta(desc);                           \
+    uint32_t vma = vext_vma(desc);                           \
+    uint32_t i;                                              \
+    FloatExceptionFlags pre_fflag =                          \
+        get_float_exception_flags(&env->fp_status);          \
+                                                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                        \
+                                                             \
+    for (i = env->vstart; i < vl; i++) {                     \
+        if (!vm && !vext_elem_mask(v0, i)) {                 \
+            /* set masked-off elements to 1s */              \
+            vext_set_elems_1s(vd, vma, i * ESZ,              \
+                              (i + 1) * ESZ);                \
+            continue;                                        \
+        }                                                    \
+        do_##NAME(vd, vs1, vs2, i, env);                     \
+    }                                                        \
+    env->vstart = 0;                                         \
+    /* set tail elements to 1s */                            \
+    vext_set_elems_1s(vd, vta, vl * ESZ,                     \
+                      total_elems * ESZ);                    \
+    riscv_cpu_check_fflags(env, pre_fflag);                  \
 }
 
 RVVCALL(OPFVV2, vfadd_vv_h_bf16, OP_UUU_H, H2, H2, H2, bfloat16_add)
@@ -3219,34 +3221,36 @@ static void do_##NAME(void *vd, uint64_t s1, void *vs2, int i, \
     *((TD *)vd + HD(i)) = OP(s2, (TX1)(T1)s1, &env->fp_status);\
 }
 
-#define GEN_VEXT_VF(NAME, ESZ)                            \
-void HELPER(NAME)(void *vd, void *v0, uint64_t s1,        \
-                  void *vs2, CPURISCVState *env,          \
-                  uint32_t desc)                          \
-{                                                         \
-    uint32_t vm = vext_vm(desc);                          \
-    uint32_t vl = env->vl;                                \
-    uint32_t total_elems =                                \
-        vext_get_total_elems(env, desc, ESZ);             \
-    uint32_t vta = vext_vta(desc);                        \
-    uint32_t vma = vext_vma(desc);                        \
-    uint32_t i;                                           \
-                                                          \
-    VSTART_CHECK_EARLY_EXIT(env, vl);                     \
-                                                          \
-    for (i = env->vstart; i < vl; i++) {                  \
-        if (!vm && !vext_elem_mask(v0, i)) {              \
-            /* set masked-off elements to 1s */           \
-            vext_set_elems_1s(vd, vma, i * ESZ,           \
-                              (i + 1) * ESZ);             \
-            continue;                                     \
-        }                                                 \
-        do_##NAME(vd, s1, vs2, i, env);                   \
-    }                                                     \
-    env->vstart = 0;                                      \
-    /* set tail elements to 1s */                         \
-    vext_set_elems_1s(vd, vta, vl * ESZ,                  \
-                      total_elems * ESZ);                 \
+#define GEN_VEXT_VF(NAME, ESZ)                                   \
+void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,    \
+                  CPURISCVState *env, uint32_t desc)             \
+{                                                                \
+    uint32_t vm = vext_vm(desc);                                 \
+    uint32_t vl = env->vl;                                       \
+    uint32_t total_elems =                                       \
+        vext_get_total_elems(env, desc, ESZ);                    \
+    uint32_t vta = vext_vta(desc);                               \
+    uint32_t vma = vext_vma(desc);                               \
+    uint32_t i;                                                  \
+    FloatExceptionFlags pre_fflag =                              \
+        get_float_exception_flags(&env->fp_status);              \
+                                                                 \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                            \
+                                                                 \
+    for (i = env->vstart; i < vl; i++) {                         \
+        if (!vm && !vext_elem_mask(v0, i)) {                     \
+            /* set masked-off elements to 1s */                  \
+            vext_set_elems_1s(vd, vma, i * ESZ,                  \
+                              (i + 1) * ESZ);                    \
+            continue;                                            \
+        }                                                        \
+        do_##NAME(vd, s1, vs2, i, env);                          \
+    }                                                            \
+    env->vstart = 0;                                             \
+    /* set tail elements to 1s */                                \
+    vext_set_elems_1s(vd, vta, vl * ESZ,                         \
+                      total_elems * ESZ);                        \
+    riscv_cpu_check_fflags(env, pre_fflag);                      \
 }
 
 RVVCALL(OPFVF2, vfadd_vf_h_bf16, OP_UUU_H, H2, H2, bfloat16_add)
@@ -3993,35 +3997,38 @@ static void do_##NAME(void *vd, void *vs2, int i,      \
     *((TD *)vd + HD(i)) = OP(s2, &env->fp_status);     \
 }
 
-#define GEN_VEXT_V_ENV(NAME, ESZ)                      \
-void HELPER(NAME)(void *vd, void *v0, void *vs2,       \
-                  CPURISCVState *env, uint32_t desc)   \
-{                                                      \
-    uint32_t vm = vext_vm(desc);                       \
-    uint32_t vl = env->vl;                             \
-    uint32_t total_elems =                             \
-        vext_get_total_elems(env, desc, ESZ);          \
-    uint32_t vta = vext_vta(desc);                     \
-    uint32_t vma = vext_vma(desc);                     \
-    uint32_t i;                                        \
-                                                       \
-    VSTART_CHECK_EARLY_EXIT(env, vl);                  \
-                                                       \
-    if (vl == 0) {                                     \
-        return;                                        \
-    }                                                  \
-    for (i = env->vstart; i < vl; i++) {               \
-        if (!vm && !vext_elem_mask(v0, i)) {           \
-            /* set masked-off elements to 1s */        \
-            vext_set_elems_1s(vd, vma, i * ESZ,        \
-                              (i + 1) * ESZ);          \
-            continue;                                  \
-        }                                              \
-        do_##NAME(vd, vs2, i, env);                    \
-    }                                                  \
-    env->vstart = 0;                                   \
-    vext_set_elems_1s(vd, vta, vl * ESZ,               \
-                      total_elems * ESZ);              \
+#define GEN_VEXT_V_ENV(NAME, ESZ)                            \
+void HELPER(NAME)(void *vd, void *v0, void *vs2,             \
+                  CPURISCVState *env, uint32_t desc)         \
+{                                                            \
+    uint32_t vm = vext_vm(desc);                             \
+    uint32_t vl = env->vl;                                   \
+    uint32_t total_elems =                                   \
+        vext_get_total_elems(env, desc, ESZ);                \
+    uint32_t vta = vext_vta(desc);                           \
+    uint32_t vma = vext_vma(desc);                           \
+    uint32_t i;                                              \
+    FloatExceptionFlags pre_fflag =                          \
+        get_float_exception_flags(&env->fp_status);          \
+                                                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                        \
+                                                             \
+    if (vl == 0) {                                           \
+        return;                                              \
+    }                                                        \
+    for (i = env->vstart; i < vl; i++) {                     \
+        if (!vm && !vext_elem_mask(v0, i)) {                 \
+            /* set masked-off elements to 1s */              \
+            vext_set_elems_1s(vd, vma, i * ESZ,              \
+                              (i + 1) * ESZ);                \
+            continue;                                        \
+        }                                                    \
+        do_##NAME(vd, vs2, i, env);                          \
+    }                                                        \
+    env->vstart = 0;                                         \
+    vext_set_elems_1s(vd, vta, vl * ESZ,                     \
+                      total_elems * ESZ);                    \
+    riscv_cpu_check_fflags(env, pre_fflag);                  \
 }
 
 RVVCALL(OPFVV1, vfsqrt_v_h, OP_UU_H, H2, H2, float16_sqrt)
@@ -4610,6 +4617,8 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);              \
     uint32_t vma = vext_vma(desc);                            \
     uint32_t i;                                               \
+    FloatExceptionFlags pre_fflag =                           \
+        get_float_exception_flags(&env->fp_status);           \
                                                               \
     VSTART_CHECK_EARLY_EXIT(env, vl);                         \
                                                               \
@@ -4636,6 +4645,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
             vext_set_elem_mask(vd, i, 1);                     \
         }                                                     \
     }                                                         \
+    riscv_cpu_check_fflags(env, pre_fflag);                   \
 }
 
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_h_bf16, uint16_t, H2, bfloat16_eq_quiet)
@@ -4653,6 +4663,8 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
     uint32_t vta_all_1s = vext_vta_all_1s(desc);                    \
     uint32_t vma = vext_vma(desc);                                  \
     uint32_t i;                                                     \
+    FloatExceptionFlags pre_fflag =                                 \
+        get_float_exception_flags(&env->fp_status);                 \
                                                                     \
     VSTART_CHECK_EARLY_EXIT(env, vl);                               \
                                                                     \
@@ -4678,6 +4690,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
             vext_set_elem_mask(vd, i, 1);                           \
         }                                                           \
     }                                                               \
+    riscv_cpu_check_fflags(env, pre_fflag);                         \
 }
 
 GEN_VEXT_CMP_VF(vmfeq_vf_h_bf16, uint16_t, H2, bfloat16_eq_quiet)
@@ -5151,34 +5164,36 @@ GEN_VEXT_RED(vwredsumu_vs_h, uint32_t, uint16_t, H4, H2, DO_ADD)
 GEN_VEXT_RED(vwredsumu_vs_w, uint64_t, uint32_t, H8, H4, DO_ADD)
 
 /* Vector Single-Width Floating-Point Reduction Instructions */
-#define GEN_VEXT_FRED(NAME, TD, TS2, HD, HS2, OP)          \
-void HELPER(NAME)(void *vd, void *v0, void *vs1,           \
-                  void *vs2, CPURISCVState *env,           \
-                  uint32_t desc)                           \
-{                                                          \
-    uint32_t vm = vext_vm(desc);                           \
-    uint32_t vl = env->vl;                                 \
-    uint32_t esz = sizeof(TD);                             \
-    uint32_t vlenb = simd_maxsz(desc);                     \
-    uint32_t vta = vext_vta(desc);                         \
-    uint32_t i;                                            \
-    TD s1 =  *((TD *)vs1 + HD(0));                         \
-                                                           \
-    VSTART_CHECK_EARLY_EXIT(env, vl);                      \
-                                                           \
-    for (i = env->vstart; i < vl; i++) {                   \
-        TS2 s2 = *((TS2 *)vs2 + HS2(i));                   \
-        if (!vm && !vext_elem_mask(v0, i)) {               \
-            continue;                                      \
-        }                                                  \
-        s1 = OP(s1, (TD)s2, &env->fp_status);              \
-    }                                                      \
-    if (vl > 0) {                                          \
-        *((TD *)vd + HD(0)) = s1;                          \
-    }                                                      \
-    env->vstart = 0;                                       \
-    /* set tail elements to 1s */                          \
-    vext_set_elems_1s(vd, vta, esz, vlenb);                \
+#define GEN_VEXT_FRED(NAME, TD, TS2, HD, HS2, OP)            \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,  \
+                  CPURISCVState *env, uint32_t desc)         \
+{                                                            \
+    uint32_t vm = vext_vm(desc);                             \
+    uint32_t vl = env->vl;                                   \
+    uint32_t esz = sizeof(TD);                               \
+    uint32_t vlenb = simd_maxsz(desc);                       \
+    uint32_t vta = vext_vta(desc);                           \
+    uint32_t i;                                              \
+    FloatExceptionFlags pre_fflag =                          \
+        get_float_exception_flags(&env->fp_status);          \
+    TD s1 =  *((TD *)vs1 + HD(0));                           \
+                                                             \
+    VSTART_CHECK_EARLY_EXIT(env, vl);                        \
+                                                             \
+    for (i = env->vstart; i < vl; i++) {                     \
+        TS2 s2 = *((TS2 *)vs2 + HS2(i));                     \
+        if (!vm && !vext_elem_mask(v0, i)) {                 \
+            continue;                                        \
+        }                                                    \
+        s1 = OP(s1, (TD)s2, &env->fp_status);                \
+    }                                                        \
+    if (vl > 0) {                                            \
+        *((TD *)vd + HD(0)) = s1;                            \
+    }                                                        \
+    env->vstart = 0;                                         \
+    /* set tail elements to 1s */                            \
+    vext_set_elems_1s(vd, vta, esz, vlenb);                  \
+    riscv_cpu_check_fflags(env, pre_fflag);                  \
 }
 
 /* Unordered sum */
-- 
2.54.0


