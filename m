Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98094C3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2q-0002yy-5H; Sun, 06 Apr 2025 03:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2T-0002tz-Q5
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2Q-00020Q-9Q
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vPu8rMZ8EArwTORC79SUO7YJi+km0+HD1JzD6Eeo0WE=;
 b=W2Wb3Rw2218AwLHcqjEbSxFpoQ4DnpC8wIkmtwPt6+ID6eeSlofM5swQTkUfoxhjLrwALh
 Eo8FsBgI+8kuCcrxM7NxMY+RpwQGQR82VBGuOctX7emf/LbkmYY074Wo4yDlTlszLhdYV+
 fgmmwe1mQL7AKU65tKksaRtGG/jdVHo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-X2SgHqHxPbKx_izw2ojeCw-1; Sun, 06 Apr 2025 03:03:22 -0400
X-MC-Unique: X2SgHqHxPbKx_izw2ojeCw-1
X-Mimecast-MFC-AGG-ID: X2SgHqHxPbKx_izw2ojeCw_1743923001
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912539665cso2246427f8f.1
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923000; x=1744527800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vPu8rMZ8EArwTORC79SUO7YJi+km0+HD1JzD6Eeo0WE=;
 b=MysMTwkuXKt4ToyPovTFMrZAETXRDdasUe5Y267oCKWgwaEh38JBuYkM0N+X4jppY9
 5qHZEOLLLGz8qztcyR3nynfnjhPslIGvwSqkQ4ZdvVn0AaMncEui8rQsZzSH9cAsFRQ+
 S3RpeyQlmh3CSS4dF/E1On7XbhRwKr3fCU7vNOhPJrG0m/Y/FqI6xWC49p6x93WWqtTJ
 VEguJRT/Cr+BrGoU3R+kGVzEqalH9emEcn0xQUH7xygsvO1tYLB0Ldoo8NdHBPUXzkzI
 0WTg2wkfkaVefes6FXDWmbKjHfNwnE0vM3icvOjvnyJ4yvLsHGn8K6odEAjIpoGkCB+Y
 92Dg==
X-Gm-Message-State: AOJu0YzUHn/rIw3GjTO9qfksC4KTxPlUDvqzJkeIWq8d+pgt1ALXBbTD
 zYOQz4YiC5WfwbR/SrlL+0/7vFyuqHqJPX8d9xP0rugIMsl0bBWLRAdumNyOMFXXzULmTsvXBoU
 Koi+GLzKCKqjaQErzZhD0uoTnOQKh19ohLVpsECjhUDwDEicsjfAXhHr0RvOpkR2BhxOABOYp02
 7AItV+QR7X13pyyxh5BDlckz+sErONG9c/Nffe
X-Gm-Gg: ASbGnctissFMmagZxYXqYv7RyQ3nnUk+PTnpvJ/8YD+uL3mFswYKn9VMBWiCqNQHsJf
 iq+7SgMFjlU1/Xs9SJx89arbw4mRKxpyCZ7Tm6ZBkeo8XhWHOK3VcSdiGlBjeNmUnW4EVF20gGN
 sbns/38s5D0zq9Bfgms0K/a79nZaFT7wvGHC1p7PQp8x/5vqpcLXOigsKuVXvcDu7yL8kNZcIhB
 kF9iIMO3cA2X4YZuQoLQTzgjAbJKlwk3+Zyl7GrJLCRxtuvr/gmS6PoczTWsPhW4Ggh2rpTIRaC
 fqFJ5o/AwajzRXF6Bg==
X-Received: by 2002:a05:600c:3c89:b0:43d:b33:679c with SMTP id
 5b1f17b1804b1-43ed6f4d524mr56823855e9.14.1743923000077; 
 Sun, 06 Apr 2025 00:03:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCVCQzAocZsLXWW4XZAm7AyFmVWImHjCsixzWhcQoOjteg9rS8Y6FY8hcIqZYn5W9u+KiinA==
X-Received: by 2002:a05:600c:3c89:b0:43d:b33:679c with SMTP id
 5b1f17b1804b1-43ed6f4d524mr56823435e9.14.1743922999564; 
 Sun, 06 Apr 2025 00:03:19 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342be6asm95050935e9.5.2025.04.06.00.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 08/27] target/riscv: store RISCVCPUDef struct directly in the
 class
Date: Sun,  6 Apr 2025 09:02:35 +0200
Message-ID: <20250406070254.274797-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prepare for adding more fields to RISCVCPUDef and reading them in
riscv_cpu_init: instead of storing the misa_mxl_max field in
RISCVCPUClass, ensure that there's always a valid RISCVCPUDef struct
and go through it.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h         |  2 +-
 hw/riscv/boot.c            |  2 +-
 target/riscv/cpu.c         | 23 ++++++++++++++++++-----
 target/riscv/gdbstub.c     |  6 +++---
 target/riscv/kvm/kvm-cpu.c | 21 +++++++++------------
 target/riscv/machine.c     |  2 +-
 target/riscv/tcg/tcg-cpu.c | 10 +++++-----
 target/riscv/translate.c   |  2 +-
 8 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 65c8d6855ec..9bbfdcf6758 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -557,7 +557,7 @@ struct RISCVCPUClass {
 
     DeviceRealize parent_realize;
     ResettablePhases parent_phases;
-    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+    RISCVCPUDef *def;
 };
 
 static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 765b9e2b1ab..828a867be39 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -37,7 +37,7 @@
 bool riscv_is_32bit(RISCVHartArrayState *harts)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(&harts->harts[0]);
-    return mcc->misa_mxl_max == MXL_RV32;
+    return mcc->def->misa_mxl_max == MXL_RV32;
 }
 
 /*
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3bd2bff1328..25132e57380 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -357,7 +357,7 @@ void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
 
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc)
 {
-    return 16 << mcc->misa_mxl_max;
+    return 16 << mcc->def->misa_mxl_max;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -1055,7 +1055,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         mcc->parent_phases.hold(obj, type);
     }
 #ifndef CONFIG_USER_ONLY
-    env->misa_mxl = mcc->misa_mxl_max;
+    env->misa_mxl = mcc->def->misa_mxl_max;
     env->priv = PRV_M;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     if (env->misa_mxl > MXL_RV32) {
@@ -1457,7 +1457,7 @@ static void riscv_cpu_init(Object *obj)
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
 
-    env->misa_mxl = mcc->misa_mxl_max;
+    env->misa_mxl = mcc->def->misa_mxl_max;
 
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
@@ -1554,7 +1554,7 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
     CPUClass *cc = CPU_CLASS(mcc);
 
     /* Validate that MISA_MXL is set properly. */
-    switch (mcc->misa_mxl_max) {
+    switch (mcc->def->misa_mxl_max) {
 #ifdef TARGET_RISCV64
     case MXL_RV64:
     case MXL_RV128:
@@ -3079,12 +3079,24 @@ static void riscv_cpu_common_class_init(ObjectClass *c, void *data)
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
+static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
+{
+    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
+    RISCVCPUClass *pcc = RISCV_CPU_CLASS(object_class_get_parent(c));
+
+    if (pcc->def) {
+        mcc->def = g_memdup2(pcc->def, sizeof(*pcc->def));
+    } else {
+        mcc->def = g_new0(RISCVCPUDef, 1);
+    }
+}
+
 static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
     const RISCVCPUDef *def = data;
 
-    mcc->misa_mxl_max = def->misa_mxl_max;
+    mcc->def->misa_mxl_max = def->misa_mxl_max;
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
@@ -3235,6 +3247,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .abstract = true,
         .class_size = sizeof(RISCVCPUClass),
         .class_init = riscv_cpu_common_class_init,
+        .class_base_init = riscv_cpu_class_base_init,
     },
     {
         .name = TYPE_RISCV_DYNAMIC_CPU,
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 18e88f416af..1934f919c01 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -62,7 +62,7 @@ int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         return 0;
     }
 
-    switch (mcc->misa_mxl_max) {
+    switch (mcc->def->misa_mxl_max) {
     case MXL_RV32:
         return gdb_get_reg32(mem_buf, tmp);
     case MXL_RV64:
@@ -82,7 +82,7 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     int length = 0;
     target_ulong tmp;
 
-    switch (mcc->misa_mxl_max) {
+    switch (mcc->def->misa_mxl_max) {
     case MXL_RV32:
         tmp = (int32_t)ldl_p(mem_buf);
         length = 4;
@@ -359,7 +359,7 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
                                  ricsv_gen_dynamic_vector_feature(cs, cs->gdb_num_regs),
                                  0);
     }
-    switch (mcc->misa_mxl_max) {
+    switch (mcc->def->misa_mxl_max) {
     case MXL_RV32:
         gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
                                  riscv_gdb_set_virtual,
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 0f4997a9186..d7e6970a670 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1997,22 +1997,19 @@ static void kvm_cpu_accel_register_types(void)
 }
 type_init(kvm_cpu_accel_register_types);
 
-static void riscv_host_cpu_class_init(ObjectClass *c, void *data)
-{
-    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
-
-#if defined(TARGET_RISCV32)
-    mcc->misa_mxl_max = MXL_RV32;
-#elif defined(TARGET_RISCV64)
-    mcc->misa_mxl_max = MXL_RV64;
-#endif
-}
-
 static const TypeInfo riscv_kvm_cpu_type_infos[] = {
     {
         .name = TYPE_RISCV_CPU_HOST,
         .parent = TYPE_RISCV_CPU,
-        .class_init = riscv_host_cpu_class_init,
+#if defined(TARGET_RISCV32)
+        .class_data = &((const RISCVCPUDef) {
+            .misa_mxl_max = MXL_RV32,
+        },
+#elif defined(TARGET_RISCV64)
+        .class_data = &((const RISCVCPUDef) {
+            .misa_mxl_max = MXL_RV64,
+        },
+#endif
     }
 };
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 889e2b65701..df2d5bad8d6 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -170,7 +170,7 @@ static bool rv128_needed(void *opaque)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(opaque);
 
-    return mcc->misa_mxl_max == MXL_RV128;
+    return mcc->def->misa_mxl_max == MXL_RV128;
 }
 
 static const VMStateDescription vmstate_rv128 = {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 2f93e2dd285..b43bd3d35b7 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -581,7 +581,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (mcc->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
+    if (mcc->def->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
         error_setg(errp, "Zcf extension is only relevant to RV32");
         return;
     }
@@ -678,7 +678,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (mcc->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
+    if (mcc->def->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
         error_setg(errp, "svukte is not supported for RV32");
         return;
     }
@@ -916,7 +916,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
 
-        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
+        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max == MXL_RV32) {
             cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
     }
@@ -925,7 +925,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
     if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
 
-        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
+        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max == MXL_RV32) {
             cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
 
@@ -1049,7 +1049,7 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-    if (mcc->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
+    if (mcc->def->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
         /* Missing 128-bit aligned atomics */
         error_setg(errp,
                    "128-bit RISC-V currently does not work with Multi "
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d6651f244f6..e22ecd11565 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1282,7 +1282,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
     ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
-    ctx->misa_mxl_max = mcc->misa_mxl_max;
+    ctx->misa_mxl_max = mcc->def->misa_mxl_max;
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
-- 
2.49.0


