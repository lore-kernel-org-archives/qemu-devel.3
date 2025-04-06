Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5084AC3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:07:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K37-0003Mp-WA; Sun, 06 Apr 2025 03:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K35-0003I9-B8
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K33-000252-ES
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RVoHZNDkiI0jo7wPzXe3i3eKHV/v0F9Cb7ETU023M4A=;
 b=YimLRIYj9q9Tn/T5+YiCxjdXRQyOv1cYBgnUpC1GA6BXXWinlmQWleVuZkLcZpBg7W9AFN
 ZRpzmRKNrungjbsP+yCkFp8su7oeVKRi2NaPcUgcBc77cfqtAIRgdjVv/pbSS7RGJWAp59
 1Pp9RbvoHeRl/9FxsyqeU1Ifh02cXVk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-f2oeWYLcMS-95ximPGe9WA-1; Sun, 06 Apr 2025 03:04:03 -0400
X-MC-Unique: f2oeWYLcMS-95ximPGe9WA-1
X-Mimecast-MFC-AGG-ID: f2oeWYLcMS-95ximPGe9WA_1743923042
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso1268759f8f.3
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:04:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923041; x=1744527841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RVoHZNDkiI0jo7wPzXe3i3eKHV/v0F9Cb7ETU023M4A=;
 b=rtSyzr7nEDcPRqVnetIFGoLJWRIkcXyt9+snysjmNL0gNv/HMP+9cfbYcfpCsyWK+r
 LEBFnOKJ5gcm4VWz+6iAEIx+VFy5eCwvIP7j+SJMYb5JVYrw4nOsRHs+iac9r5GnIiZc
 0vDsgflB2tTlfgOgUfwkLCcFcfvlm+lEPOmSCKHWkmcYpRUz1Ppy/qteEzaAQda4Ndoh
 uqc8cyy35zHOLvv9Cp9pDp3XZsKUWt5IewyKSxs0F2c01zBnCD34XO+7xImKuhuD9L9r
 UYJFJJPXXaAxFii86BvZCyHgsYmLVIFqYFdEvIRWMVB3c7JSePCzBiF+ZujRzn6iEbYn
 Mrvw==
X-Gm-Message-State: AOJu0YzllrDA/vY/m+GOJg4RaMnQPXSS4bMW2xcLP2y1mL/6qE0Cl0Yw
 7SM5Db7JHpN7o2LF4662YOoMjIlNHCsrWiyDQC6MckQ6JGagsS4MkPZO/yq4/lmlqzl0POphZQ1
 EH7ZlwLTOrbZFYl2amHSfwjyM6Mhck0pNG80YA1p/c/1/aJKJ0D9sdFLfYMXn4Mx/aZIt8Dfp0B
 dhjJo9SvfkS3iiBZLYPK68g4qWyERZwqxJHqPq
X-Gm-Gg: ASbGnctxdQmHf9HexKnDI6yOvBW8oDzomAF2z43cpHiH+spV3ElcxAILp7VBETxFixx
 QyjQTJA1UPAm3Q3eSIbrh0i9mY/C0nCaP0es/GjBjBkgoa/3al9Q3Aeza6UFYJsszN77zpM/IU/
 vz7WKdgUuLZlzdbaz0j5gZ5UXQvH4/Zpqq8zB1Fz+E0oErQP4EWHDg1Vak71zogxWCsvhfwK80/
 /D2lPstQZNHMPm+kEMEONxzEmavsceJTX2UfTh4rK6bJVjn/o+Py8KEaF+19FSD+cvjE99E48xN
 okuL/y1jHZ8GH9AHtA==
X-Received: by 2002:adf:b60c:0:b0:39c:1257:febb with SMTP id
 ffacd0b85a97d-39cba9868camr4846470f8f.59.1743923040726; 
 Sun, 06 Apr 2025 00:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfGUfyMbyn82tuzCwHhLEZKbcIzVB40DrZjEmj5OaEa9ZW6RI22aAJE4npQ9zxeH3KOVecag==
X-Received: by 2002:adf:b60c:0:b0:39c:1257:febb with SMTP id
 ffacd0b85a97d-39cba9868camr4846453f8f.59.1743923040320; 
 Sun, 06 Apr 2025 00:04:00 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d6b1sm8775231f8f.62.2025.04.06.00.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com
Subject: [PATCH 26/27] target/riscv: convert Xiangshan Nanhu to RISCVCPUDef
Date: Sun,  6 Apr 2025 09:02:53 +0200
Message-ID: <20250406070254.274797-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 80 +++++++++++++---------------------------------
 1 file changed, 23 insertions(+), 57 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4e4d8ddf5a2..0a3a0343087 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -441,16 +441,6 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit)
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
@@ -499,38 +489,6 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
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
@@ -2895,19 +2853,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_VENDOR_CPU,                    \
-        .instance_init = (initfn),                          \
-        .class_data = (void*) &((const RISCVCPUDef) {       \
-             .misa_mxl_max = (misa_mxl_max_),               \
-             .priv_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .vext_spec = RISCV_PROFILE_ATTR_UNUSED,        \
-             .cfg.max_satp_mode = -1,                       \
-        }),                                                 \
-    }
-
 #define DEFINE_ABSTRACT_RISCV_CPU(type_name, parent_type_name, ...) \
     {                                                       \
         .name = (type_name),                                \
@@ -3207,8 +3152,29 @@ static const TypeInfo riscv_cpu_type_infos[] = {
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
 #ifdef CONFIG_TCG
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
         .cfg.max_satp_mode = VM_1_10_SV57,
-- 
2.49.0


