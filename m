Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4761C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnd-0008Bo-Nb; Tue, 20 May 2025 07:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnX-0007lD-Oq
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnV-00039s-9Y
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBN1wh4YzzbsobsYn66L3HN47kUSmOzF97Y6lN+HLpw=;
 b=X5LMt7I2Yebt2xk0lM+Fj15WfEPp1g2N102WThHpvA36FZASaOa8PswTJKp5GprlFhf+mK
 1zNHuFoZkkYr1SleSS2pTncUbzKf7v9ECV6LL2dDXnjBIPwF2FQOFPyibBnRddqdnGNCwS
 VP3xxkbps8+KFVOU2zlXy8YFvbIzswE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-KAkPHDxiNt-eLv8LN-xr-w-1; Tue, 20 May 2025 07:06:11 -0400
X-MC-Unique: KAkPHDxiNt-eLv8LN-xr-w-1
X-Mimecast-MFC-AGG-ID: KAkPHDxiNt-eLv8LN-xr-w_1747739170
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad55e6f09efso218859066b.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739169; x=1748343969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBN1wh4YzzbsobsYn66L3HN47kUSmOzF97Y6lN+HLpw=;
 b=nBKyl69gye8QquhOgFjvXl46PDd9v/l/VeA9j7SnOKfWFeiKWfClKDJAfvoUcoseGJ
 j6GTjOpfywG6+kntSU6X7j9XjcsOAqxvzSsEUZzPCzEgFsY/BAgnMJpoIR8789k7YimC
 aZ8u5xqkeqnBudikHlnwsj7bvyVzRGyIbpK6aV4ekUzej4YaLcyPc4bjbA8H4POSy7Mg
 ffOmYPvmXEFp8BZj3i/4GmhLB0CCF774majiFOGg9UERQmRjZaMq3VTKut6Wns9SVh/k
 6wLvt73ZqyEbsAy6x4QlUB1RtPbgAxFqsLFuMTK9zgMftrSLWJqcugaNwrUcNPnzBIIS
 JUbg==
X-Gm-Message-State: AOJu0YwqPpocc63PYrE/wQyEKnPeyCReflCXucT1dzuZOfrXRNrTnH5y
 3p6jW6SQEQhWLipo8GHCgBaAu2ZpL6yAIC1P//ARQj+Cp2+QHnevW9o9G8pcWlRaaplDDOcZbQi
 InX+aUDfU1m5ktG4UkNJL4fdva+wk8QkaV3rr7jzfe5edKg7WqtM6iHuKZNLEdpFNwM7FbkWKZI
 6VzmoBKijaml631l99bFIMaVLu0oGdrLa7Uw/Tc2Im
X-Gm-Gg: ASbGncs/IMaubT9NwQUyq6oRguaQdAb14v9s7wH7njU7ta4WcaJW554jnviP0kOW+Li
 QL2TA8GpYz1oCAiiMpXluIugMrUa/bF9lGd6+/EGKHy41GdcdIE0c/xljqyCRqiyqoVjatizoE5
 iSSKWLEpJC5FynlPsz10pmk093WfkCgBHTh3eB13UCwlp1IxYOCtwBurXB24HkbSFtGqttljONb
 wDMU/QkeygQy4Z5U2OUUdvVDpIFcBR2Qzh1xCigAbGmo53UTu//uouRIZO+nhm6Dv+uX7WSEc3U
 ttPAeBzBFJWojg==
X-Received: by 2002:a05:6402:3508:b0:5fc:954e:bd4f with SMTP id
 4fb4d7f45d1cf-60114099a55mr14035052a12.8.1747739169081; 
 Tue, 20 May 2025 04:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ8rGiHodLH989Tiu+ToTeHxvEiv49XDtXu2fOf0yjn0Z44RjGnyXNcskDA8TldoJLb3XS4w==
X-Received: by 2002:a05:6402:3508:b0:5fc:954e:bd4f with SMTP id
 4fb4d7f45d1cf-60114099a55mr14035018a12.8.1747739168592; 
 Tue, 20 May 2025 04:06:08 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6004d50364dsm7006487a12.32.2025.05.20.04.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/35] target/riscv: store RISCVCPUDef struct directly in the
 class
Date: Tue, 20 May 2025 13:05:11 +0200
Message-ID: <20250520110530.366202-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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
index 9de3f716ea6..d2d4db95c17 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -554,7 +554,7 @@ struct RISCVCPUClass {
 
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
index 6e92fbb9928..22e3a2211ed 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -356,7 +356,7 @@ void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
 
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc)
 {
-    return 16 << mcc->misa_mxl_max;
+    return 16 << mcc->def->misa_mxl_max;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -1047,7 +1047,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         mcc->parent_phases.hold(obj, type);
     }
 #ifndef CONFIG_USER_ONLY
-    env->misa_mxl = mcc->misa_mxl_max;
+    env->misa_mxl = mcc->def->misa_mxl_max;
     env->priv = PRV_M;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     if (env->misa_mxl > MXL_RV32) {
@@ -1449,7 +1449,7 @@ static void riscv_cpu_init(Object *obj)
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
 
-    env->misa_mxl = mcc->misa_mxl_max;
+    env->misa_mxl = mcc->def->misa_mxl_max;
 
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
@@ -1543,7 +1543,7 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
     CPUClass *cc = CPU_CLASS(mcc);
 
     /* Validate that MISA_MXL is set properly. */
-    switch (mcc->misa_mxl_max) {
+    switch (mcc->def->misa_mxl_max) {
 #ifdef TARGET_RISCV64
     case MXL_RV64:
     case MXL_RV128:
@@ -3070,12 +3070,24 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
+static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
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
 static void riscv_cpu_class_init(ObjectClass *c, const void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
     const RISCVCPUDef *def = data;
 
-    mcc->misa_mxl_max = def->misa_mxl_max;
+    mcc->def->misa_mxl_max = def->misa_mxl_max;
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
@@ -3226,6 +3238,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
index 82f97286360..e77f612af35 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -2086,22 +2086,19 @@ static void kvm_cpu_accel_register_types(void)
 }
 type_init(kvm_cpu_accel_register_types);
 
-static void riscv_host_cpu_class_init(ObjectClass *c, const void *data)
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
+        .class_data = &(const RISCVCPUDef) {
+            .misa_mxl_max = MXL_RV32,
+        },
+#elif defined(TARGET_RISCV64)
+        .class_data = &(const RISCVCPUDef) {
+            .misa_mxl_max = MXL_RV64,
+        },
+#endif
     }
 };
 
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index a1f70cc9556..c97e9ce9df1 100644
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
index ab8659f3044..305912b8dd3 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -691,7 +691,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (mcc->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
+    if (mcc->def->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
         error_setg(errp, "Zcf extension is only relevant to RV32");
         return;
     }
@@ -788,7 +788,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (mcc->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
+    if (mcc->def->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
         error_setg(errp, "svukte is not supported for RV32");
         return;
     }
@@ -1026,7 +1026,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
 
-        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
+        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max == MXL_RV32) {
             cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
     }
@@ -1035,7 +1035,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
     if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
 
-        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
+        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max == MXL_RV32) {
             cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
 
@@ -1161,7 +1161,7 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 #ifndef CONFIG_USER_ONLY
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
 
-    if (mcc->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
+    if (mcc->def->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
         /* Missing 128-bit aligned atomics */
         error_setg(errp,
                    "128-bit RISC-V currently does not work with Multi "
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 0d4f7d601c9..d7a6de02df5 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1276,7 +1276,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
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


