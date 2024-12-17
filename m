Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FD6E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 17:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNbEs-0007xw-Gc; Tue, 17 Dec 2024 12:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEq-0007x6-RA
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:05 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNbEf-0006BT-OT
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 12:20:04 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43635796b48so22927005e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 09:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734455988; x=1735060788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xF0sOxJFHtjA3NYMq21N6K3jmjQXICidMHaId+8egGs=;
 b=BabktNGSo7n8rNKZVJ0YujODZi/FZhX6Zx0Thk52McoVX5X7nDnWvSt2OP7ipJQNrW
 DBfFIORJsysOqpr3BOafUIZvbGgqqGurUPyH8StgOE9Nb1s+o0A9FzPLtq0eSLWmEqBB
 FlFHfGm9t24ySnyDYlj2qfNE+I2kp0v7L5IqF/6QJIUr4kFBW7F3yKuyeHxgDvU9XQht
 DCO6ww/sPQ7tNFeRD1/fBzURyUkAJf8TLDcqCMViKQkIPYxOrB93E0gdbGqPktGnqzRH
 8NL0gnyK051SOZ81jr0ERQqgAzBaldJ5S275yHabL5azkXRr3rtAjPZQpVzqOnR4Ri6Z
 2ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734455988; x=1735060788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xF0sOxJFHtjA3NYMq21N6K3jmjQXICidMHaId+8egGs=;
 b=DwLx5dEy1ZUqWaf7Qkbx3jATQD3+ED9VGc5lOr9pX8lEPiV/AqZcBycnWViw4567EJ
 Qjz3NaYAXapt2PbbrWQ7jVQMLT6myrhL5muVNZlyznnYdCe+EiY5FkcjKSM+6hH3jqir
 FKVS+VJJu5rndFpsbvWl2/E4bHuEf8PTeJxPcJp5gyLI3SKgSgmumr66fUi7dZ4xc3w+
 wwcBByA/8nejiLToK0d9ETnAQjPkCzqRU3IQ3RgxcyfA0GqXqDt8QyC5kaU9l3uyQcrY
 xoMcp192tsy7HNHcXmYSobhxpYBPafJbPOVHi44jCUTS8w0EIdlMCdoad/GXzqw00eEC
 vcSA==
X-Gm-Message-State: AOJu0Yx7f41fKc/IUMvf1aP/clTlaSNJYIK2HCoH57teuHqgHIijRBz8
 AStQBFUwxAZVByVDvFlPyI2mlweRak4IZ9FKXeUWObfQ07zxP5yworh/+g+hjb4pd+4HTz3Lng4
 B
X-Gm-Gg: ASbGncszoRaG3N92mQmLK23Ugc9jGNz+dbywauWWSvlKI91bLCulD7l5YthzdDeLHkm
 daxxgpvbyK1nZj6X0Wlqxi/r/mzjQWpR3fc4I20SIKrjzeP2pGrFU8S0UX7wglv/N5Mvlde6teg
 trKSpH5ajeBEwGy+Yyk8Ft4nR42w83hBi1hvsWvDWFPz6AQHo7ZRu7QIOkspfF9b5KjDigH6H5o
 NbccHrteYro+Hzysd4GfNo86SszYcvgGdNG/Ik/ydvOu3s72qxU04HZJhbYbqU=
X-Google-Smtp-Source: AGHT+IFbBMuZoyKyCGjUjedRG+UVVH2OsudYyuuh0HXUhMIa83bFNZMtRc0AM7rMAjW1OHvxUJJfsQ==
X-Received: by 2002:a05:600c:3b22:b0:434:fa73:a906 with SMTP id
 5b1f17b1804b1-4364814eefdmr34512335e9.4.1734455988294; 
 Tue, 17 Dec 2024 09:19:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016389sm11569728f8f.32.2024.12.17.09.19.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 09:19:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/19] target/arm: Convert vec_helper.c to use env alias
Date: Tue, 17 Dec 2024 17:19:26 +0000
Message-Id: <20241217171937.3899947-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217171937.3899947-1-peter.maydell@linaro.org>
References: <20241217171937.3899947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Allow the helpers to receive CPUARMState* directly
instead of via void*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241206031224.78525-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h         | 12 ++++++------
 target/arm/tcg/helper-a64.h |  2 +-
 target/arm/tcg/vec_helper.c | 21 +++++++--------------
 3 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 9a1b6d1b6d7..bb241df8260 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -859,13 +859,13 @@ DEF_HELPER_FLAGS_5(gvec_suqadd_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmlal_a32, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fmlal_a64, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a32, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fmlal_idx_a64, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_2(frint32_s, TCG_CALL_NO_RWG, f32, f32, fpst)
 DEF_HELPER_FLAGS_2(frint64_s, TCG_CALL_NO_RWG, f32, f32, fpst)
@@ -1036,9 +1036,9 @@ DEF_HELPER_FLAGS_4(sve2_sqrdmulh_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_6(sve2_fmlal_zzzw_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(sve2_fmlal_zzxw_s, TCG_CALL_NO_RWG,
-                   void, ptr, ptr, ptr, ptr, ptr, i32)
+                   void, ptr, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(gvec_xar_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 4d704939145..26e327af3a2 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -29,7 +29,7 @@ DEF_HELPER_3(vfp_cmps_a64, i64, f32, f32, fpst)
 DEF_HELPER_3(vfp_cmpes_a64, i64, f32, f32, fpst)
 DEF_HELPER_3(vfp_cmpd_a64, i64, f64, f64, fpst)
 DEF_HELPER_3(vfp_cmped_a64, i64, f64, f64, fpst)
-DEF_HELPER_FLAGS_4(simd_tblx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(simd_tblx, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_3(vfp_mulxs, TCG_CALL_NO_RWG, f32, f32, f32, fpst)
 DEF_HELPER_FLAGS_3(vfp_mulxd, TCG_CALL_NO_RWG, f64, f64, f64, fpst)
 DEF_HELPER_FLAGS_3(neon_ceq_f64, TCG_CALL_NO_RWG, i64, i64, i64, fpst)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index d2d9d5e8295..e3083c6e84e 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2057,28 +2057,25 @@ static void do_fmlal(float32 *d, void *vn, void *vm, float_status *fpst,
 }
 
 void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
-                            void *venv, uint32_t desc)
+                            CPUARMState *env, uint32_t desc)
 {
-    CPUARMState *env = venv;
     do_fmlal(vd, vn, vm, &env->vfp.standard_fp_status, desc,
              get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
 }
 
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
-                            void *venv, uint32_t desc)
+                            CPUARMState *env, uint32_t desc)
 {
-    CPUARMState *env = venv;
     do_fmlal(vd, vn, vm, &env->vfp.fp_status, desc,
              get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
 }
 
 void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
-                               void *venv, uint32_t desc)
+                               CPUARMState *env, uint32_t desc)
 {
     intptr_t i, oprsz = simd_oprsz(desc);
     uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
-    CPUARMState *env = venv;
     float_status *status = &env->vfp.fp_status;
     bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16);
 
@@ -2122,29 +2119,26 @@ static void do_fmlal_idx(float32 *d, void *vn, void *vm, float_status *fpst,
 }
 
 void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
-                                void *venv, uint32_t desc)
+                                CPUARMState *env, uint32_t desc)
 {
-    CPUARMState *env = venv;
     do_fmlal_idx(vd, vn, vm, &env->vfp.standard_fp_status, desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
 }
 
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
-                                void *venv, uint32_t desc)
+                                CPUARMState *env, uint32_t desc)
 {
-    CPUARMState *env = venv;
     do_fmlal_idx(vd, vn, vm, &env->vfp.fp_status, desc,
                  get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
 }
 
 void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
-                               void *venv, uint32_t desc)
+                               CPUARMState *env, uint32_t desc)
 {
     intptr_t i, j, oprsz = simd_oprsz(desc);
     uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
-    CPUARMState *env = venv;
     float_status *status = &env->vfp.fp_status;
     bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status_f16);
 
@@ -2562,10 +2556,9 @@ DO_VRINT_RMODE(gvec_vrint_rm_s, helper_rints, uint32_t)
 #undef DO_VRINT_RMODE
 
 #ifdef TARGET_AARCH64
-void HELPER(simd_tblx)(void *vd, void *vm, void *venv, uint32_t desc)
+void HELPER(simd_tblx)(void *vd, void *vm, CPUARMState *env, uint32_t desc)
 {
     const uint8_t *indices = vm;
-    CPUARMState *env = venv;
     size_t oprsz = simd_oprsz(desc);
     uint32_t rn = extract32(desc, SIMD_DATA_SHIFT, 5);
     bool is_tbx = extract32(desc, SIMD_DATA_SHIFT + 5, 1);
-- 
2.34.1


