Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EEAC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKow-00035C-Ne; Tue, 20 May 2025 07:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKo8-0001of-JB
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKo6-0003Pj-Ni
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86GzllK77ggRgu/hqIKqxi4f9yCDxALtvTLocr/OfJg=;
 b=W/eLKjPxrDatCvfYP+ZRche5lxvX38udw0pdcFKs50nNRxsAVp5wk09/g0jaVa5oPxAJp/
 JSfArTY3T37RXu38wkCbIQhzpybPT3quc1FaOHdMUEhDlVMsv26KaqNyMvvSWTdGZsRhkY
 0crIF8n8nL8iTQU0uJzDLsJch4hqqNY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-tJMlNWY-NcWP35PyX2WZpg-1; Tue, 20 May 2025 07:06:48 -0400
X-MC-Unique: tJMlNWY-NcWP35PyX2WZpg-1
X-Mimecast-MFC-AGG-ID: tJMlNWY-NcWP35PyX2WZpg_1747739208
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acbbb00099eso467896466b.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739207; x=1748344007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86GzllK77ggRgu/hqIKqxi4f9yCDxALtvTLocr/OfJg=;
 b=mmOuWdJdGhL125UDfpv/tjdvQ00hx92g67lfBb9oQMLptSM77kXlxkHOkxTpZvt2FN
 9c7eKNVdy2TGLL9zU1xarGaSjISjCuKA4vXaEwaot6ayEXjShOBfrg/deEUUIaa1O8dN
 Y5ujP4g8Q042AZtUs2oJ72vLjdmlbRUaTJJFpMkVGSPve7gRvmn24SZsTmBWYiRK72DA
 s9kRT9m9jC3wZz3Pyv0Qv+lEfpX9lhOO4jSIgQuc1/6FUUpaOolfbDy4EUTtaitL5HBU
 bZPZPJwT4gq5d1mYXs5/Lp8Y1iXUTe1jSF4BvNMVGkfKh4G5iXSaAif3LMA2hKpXfAxt
 AWGQ==
X-Gm-Message-State: AOJu0Yy4dUmMAyAomMmVUpDTAzuHIzmPhxazO7aivIfzCSeHL+4VAt1h
 Dmrg4iZkZTJ7ox6FMGyVcPNFOikGylgyVfYlq/k89lm0wGpVDw6pnpTMknIpSQPwUjZD0/RSYRl
 g/lkENbWCg7jG1QmNgpdOV75WEsBR1gBcav35x6bI2I+FX5kZV20+CRBeQP242/5BPzdh2GeY0S
 QLtQM0W9mAoCtVYrDY7JqOpzEu/GDJ4aKJMEkIhr2u
X-Gm-Gg: ASbGncsyLtptwehijJ/9WBSIi0GsH4wbcQQ3grxGZCITj1SQr60oKPogE5+FuKcaJXO
 wsFGX7XIxIrcURgAJpzTEcCN3Pl4pS9hT96jBUtQXxNJu2O+VuKLzYuZDkY+HW2EtxwoH8ZOI0z
 rdhSEC5SMNn4CBPSZZ4E+dYvdrjR4Y/3yRrvpbRDLyjRaDeF5MYhEhUQxbMF5Xs1cqPyX0I4dpF
 c6GRbgpQYXrDA2F1/9FJE9U7Ey4P2LESh9tjMJJy0rL5PJ1jG09BGaxlE2PinZsXuodtppkpl9N
 sZUb4X6uNYXudA==
X-Received: by 2002:a17:907:97ca:b0:ace:cc7f:8abe with SMTP id
 a640c23a62f3a-ad536c22d77mr1336596166b.31.1747739206805; 
 Tue, 20 May 2025 04:06:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1yUqbQz+r/6z3qSI+nKsfiCcfYUHUv7zfLlUzhGsE0MxTyoemU9/Qsywv3kLmDv0Z3tkITQ==
X-Received: by 2002:a17:907:97ca:b0:ace:cc7f:8abe with SMTP id
 a640c23a62f3a-ad536c22d77mr1336593366b.31.1747739206334; 
 Tue, 20 May 2025 04:06:46 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4cc5e9sm719921966b.173.2025.05.20.04.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/35] target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
Date: Tue, 20 May 2025 13:05:28 +0200
Message-ID: <20250520110530.366202-34-pbonzini@redhat.com>
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 80 +++++++++++++---------------------------------
 1 file changed, 23 insertions(+), 57 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 000fcc6a1d6..640aa958fd4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -440,16 +440,6 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
     g_assert_not_reached();
 }
 
-static void __attribute__((unused))
-set_satp_mode_max_supported(RISCVCPU *cpu, int satp_mode)
-{
-    bool rv32 = riscv_cpu_mxl(&cpu->env) == MXL_RV32;
-    const bool *valid_vm = rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
-
-    assert(valid_vm[satp_mode]);
-    cpu->cfg.max_satp_mode = satp_mode;
-}
-
 static bool get_satp_mode_supported(RISCVCPU *cpu, uint16_t *supported)
 {
     bool rv32 = riscv_cpu_is_32bit(cpu);
@@ -498,38 +488,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
 }
 #endif
 
-#if defined(TARGET_RISCV64)
-
-static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVG | RVC | RVB | RVS | RVU);
-    env->priv_ver = PRIV_VERSION_1_12_0;
-
-    /* Enable ISA extensions */
-    cpu->cfg.ext_zbc = true;
-    cpu->cfg.ext_zbkb = true;
-    cpu->cfg.ext_zbkc = true;
-    cpu->cfg.ext_zbkx = true;
-    cpu->cfg.ext_zknd = true;
-    cpu->cfg.ext_zkne = true;
-    cpu->cfg.ext_zknh = true;
-    cpu->cfg.ext_zksed = true;
-    cpu->cfg.ext_zksh = true;
-    cpu->cfg.ext_svinval = true;
-
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_SV39);
-#endif
-}
-
-#endif /* !TARGET_RISCV64 */
-
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -2891,19 +2849,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_VENDOR_CPU,                    \
-        .instance_init = (initfn),                          \
-        .class_data = &(const RISCVCPUDef) {                \
-             .misa_mxl_max = (misa_mxl_max_),               \
-             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .cfg.max_satp_mode = -1,                       \
-        },                                                  \
-    }
-
 #define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
     {                                                       \
         .name = (type_name),                                \
@@ -3203,8 +3148,29 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV48,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
-                                                 MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU, TYPE_RISCV_VENDOR_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVG | RVC | RVB | RVS | RVU,
+        .priv_spec = PRIV_VERSION_1_12_0,
+
+        /* ISA extensions */
+        .cfg.ext_zbc = true,
+        .cfg.ext_zbkb = true,
+        .cfg.ext_zbkc = true,
+        .cfg.ext_zbkx = true,
+        .cfg.ext_zknd = true,
+        .cfg.ext_zkne = true,
+        .cfg.ext_zknh = true,
+        .cfg.ext_zksed = true,
+        .cfg.ext_zksh = true,
+        .cfg.ext_svinval = true,
+
+        .cfg.mmu = true,
+        .cfg.pmp = true,
+
+        .cfg.max_satp_mode = VM_1_10_SV39,
+    ),
+
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.49.0


