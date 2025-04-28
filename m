Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1581C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1b-0006L0-Dh; Mon, 28 Apr 2025 03:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1H-0005yV-CY
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1F-0001AE-6T
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VohZ9tSEHfLLjsa4Q9MaAf7BtTKwZMXgWx/DALbG3s=;
 b=WBrB5APLA1lIRWUmjhQztfHY4hKWuGh2aDur9ClP8guXBqk0Q+byBtJQNElbqk5Ot3WoW6
 HKOmyocBhkAhfR5MBeeq8zbuhLrHghuycv49jGD16fq6AmNEAZ2854K/XtubjRvNaUtZFq
 /SsQm8gcH21Gl0aDKCQ/J8ZWqy6j15w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-BXKf7MS0NOOs_D2muI914A-1; Mon, 28 Apr 2025 03:35:08 -0400
X-MC-Unique: BXKf7MS0NOOs_D2muI914A-1
X-Mimecast-MFC-AGG-ID: BXKf7MS0NOOs_D2muI914A_1745825707
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so23000765e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825706; x=1746430506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/VohZ9tSEHfLLjsa4Q9MaAf7BtTKwZMXgWx/DALbG3s=;
 b=lyZhL0EapUMJ/eOdTrln0pASXy7ImHTjaPQo6rmxMf+HCZg8yGbCfhVEexKrgxb8UB
 URje0FqUNK8cJHtDZQ0W6/Dqt/T1YoGJfIvhXL6wp13X906h4kU7ZtVwyemR+IDjgbIt
 8VP2BEzH3jfWnBIu7kMsxnXcGw1ii3dy1wFDQkd6CFyOfWcRfxFLetZ/4Puh5x+c5is8
 s65tR3VaWAh4U0itA+QUCtA1a5u+ykHC5KbmiCjUYTGoeRV/hi1z4xFSrmBMFcFpVwYI
 UD0LPk3nYri5NrMSNmydo+vp3DwgFr4Shr9iTkWCdHxNb51DWWEcXHDNg7UMlF9zWeh7
 MZSw==
X-Gm-Message-State: AOJu0YxI0Zd65Xh3ssPNy8Ky/EonlUqIoeX9z2TtCaf3r7CQB5T4fw20
 VFeB6JmBZHqPy3X8/TXRNRDfgI7zAJdIBzpLGlU3dCfoF0zJp99WJGYrNY7Mi3fB15rHPLTySiJ
 Z3wJ+iWcnNBJYaxXBPOnb0aq54h1KA8OhS2oJhTgZwZMS0i7fP1KXihoTj5MabfMZ11dYsEULOf
 yoJTxEKFoOVDEVLLoDTmHBLoEbuHP/1rcrK+no
X-Gm-Gg: ASbGncu4435LrvuKbnSVzqv2uzwp8Ff5784cWr4UaMfwdgQMkj5R/Fv61MlidNc+wca
 HiJf6i83FQTkpBR/l7fVVeguiH3IDhsyN2yBQJfRzlf7KZPYugZJpJlR52bMxIBiDDhgDYETBpd
 krzQzTPCirdw97qD8QVGJKuXuD86VAPfuNCwuz3QgYuh4E0uengZ8/DJ30ZvCOyICRpf8nqOoAT
 XZ9WQL/GJIqVcCByB1Gf1mOA23P9uXqxuhkMhKTAfZ0nvcfGEgbXB+PUge9KH8ZBu8YGg7urQzu
 OiU3nyA3BM4Bi/g=
X-Received: by 2002:a05:600c:1c11:b0:43c:fd72:f039 with SMTP id
 5b1f17b1804b1-440ab79f9c2mr52495285e9.11.1745825706000; 
 Mon, 28 Apr 2025 00:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjXtguiw9AltJkL7Wv036vEv3f0Tx0h7MlSRpeoCEIA8YvVx0mnBrbKcuzZe2VtG3wIajzow==
X-Received: by 2002:a05:600c:1c11:b0:43c:fd72:f039 with SMTP id
 5b1f17b1804b1-440ab79f9c2mr52495045e9.11.1745825705581; 
 Mon, 28 Apr 2025 00:35:05 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a538f4e3sm114469515e9.36.2025.04.28.00.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 08/26] target/riscv: store RISCVCPUDef struct directly in the
 class
Date: Mon, 28 Apr 2025 09:34:23 +0200
Message-ID: <20250428073442.315770-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
index 62e303f0635..842c9d3f194 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -553,7 +553,7 @@ struct RISCVCPUClass {
 
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
index f30cf1b532b..d8c189d596b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -357,7 +357,7 @@ void riscv_cpu_set_misa_ext(CPURISCVState *env, uint32_t ext)
 
 int riscv_cpu_max_xlen(RISCVCPUClass *mcc)
 {
-    return 16 << mcc->misa_mxl_max;
+    return 16 << mcc->def->misa_mxl_max;
 }
 
 #ifndef CONFIG_USER_ONLY
@@ -1048,7 +1048,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         mcc->parent_phases.hold(obj, type);
     }
 #ifndef CONFIG_USER_ONLY
-    env->misa_mxl = mcc->misa_mxl_max;
+    env->misa_mxl = mcc->def->misa_mxl_max;
     env->priv = PRV_M;
     env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
     if (env->misa_mxl > MXL_RV32) {
@@ -1450,7 +1450,7 @@ static void riscv_cpu_init(Object *obj)
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
 
-    env->misa_mxl = mcc->misa_mxl_max;
+    env->misa_mxl = mcc->def->misa_mxl_max;
 
 #ifndef CONFIG_USER_ONLY
     qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
@@ -1544,7 +1544,7 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
     CPUClass *cc = CPU_CLASS(mcc);
 
     /* Validate that MISA_MXL is set properly. */
-    switch (mcc->misa_mxl_max) {
+    switch (mcc->def->misa_mxl_max) {
 #ifdef TARGET_RISCV64
     case MXL_RV64:
     case MXL_RV128:
@@ -3071,12 +3071,24 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
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
 
@@ -3227,6 +3239,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
index 75724b6af4f..41b6f34552a 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1997,22 +1997,19 @@ static void kvm_cpu_accel_register_types(void)
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
index 1192b4e1545..f3ca61103c4 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -592,7 +592,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (mcc->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
+    if (mcc->def->misa_mxl_max != MXL_RV32 && cpu->cfg.ext_zcf) {
         error_setg(errp, "Zcf extension is only relevant to RV32");
         return;
     }
@@ -689,7 +689,7 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    if (mcc->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
+    if (mcc->def->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
         error_setg(errp, "svukte is not supported for RV32");
         return;
     }
@@ -927,7 +927,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmp), true);
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcmt), true);
 
-        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
+        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max == MXL_RV32) {
             cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
     }
@@ -936,7 +936,7 @@ static void cpu_enable_zc_implied_rules(RISCVCPU *cpu)
     if (riscv_has_ext(env, RVC) && env->priv_ver >= PRIV_VERSION_1_12_0) {
         cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zca), true);
 
-        if (riscv_has_ext(env, RVF) && mcc->misa_mxl_max == MXL_RV32) {
+        if (riscv_has_ext(env, RVF) && mcc->def->misa_mxl_max == MXL_RV32) {
             cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zcf), true);
         }
 
@@ -1062,7 +1062,7 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
 #ifndef CONFIG_USER_ONLY
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
 
-    if (mcc->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
+    if (mcc->def->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
         /* Missing 128-bit aligned atomics */
         error_setg(errp,
                    "128-bit RISC-V currently does not work with Multi "
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index cef61b5b290..26ac7cdcaa1 100644
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


