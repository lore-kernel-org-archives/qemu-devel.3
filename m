Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6C4C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 10:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPre-0008PI-3J; Mon, 12 May 2025 05:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPra-0008Dl-7j
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPrY-0000kh-AT
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQP6ywiPJMUFc5z5DEsy2ld8/0ObbZvfP80MT/Vqhuk=;
 b=dkpUAuv7/pAqrGuo0Uju3Bu8zlYzFJlz3g5RNhRJNW2DeolDxw6x1uSd0LGTsxIeTYaNJj
 ENzGw+lF7xstoSI+Lf1w+xN0wuKBDV4r7RH6MzK0oBjEOjlezZEUXtk1HAlbilsk0IGdBz
 9jFvmVVCWZYA7Tzu4Ta62RaITpwEwgs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-mBYymNVGMaGyocs7ziWSxA-1; Mon, 12 May 2025 05:54:18 -0400
X-MC-Unique: mBYymNVGMaGyocs7ziWSxA-1
X-Mimecast-MFC-AGG-ID: mBYymNVGMaGyocs7ziWSxA_1747043657
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-acf16746a74so459285566b.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043656; x=1747648456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQP6ywiPJMUFc5z5DEsy2ld8/0ObbZvfP80MT/Vqhuk=;
 b=K5eehQ+Zt7u+WPwSGJgM4PoZP6OsmEdgQ3UsC19aVM+cEv4PcE3ECyH+BvDrmPk/OO
 Gl2RlgjcB9UzFEpm8OhSRIwV2eGMC2tPqBBMEjtWcFFEJUEOm3CaDNZpSEPjyw+nP48t
 PfKBRXs+6rd+X75etMQa658DXeSSNvFHOlN/lE4zYS8Yg3el6zhgctPzF2hiZSjQ7iMY
 73GMxfDTkmG+kN3jy0rjXNlOq9bPutiAqUv1shne3MX/A5CxRAbmX1LIVpj1qVc747RS
 5dTlP267sm/c5jM2u0QmMhsNZ5vyWsE9dXx6lFYdn6dAWYRPhuS/1/GHsHVJE/rp7M0D
 E4fw==
X-Gm-Message-State: AOJu0YzkCVLN6kbfQ7LmduhdjPrNmTkPG7Y+NO1Uh84IafbBDQdW1t8u
 Tmt2O3N9WA4/dLkBVqhHQCNbSW+FeEuHdbjubtTazHUSFjxcoMlv4jLY1SHk+yZ31Fzsgv1x/OG
 +S1+AYMkOfuuJAR/MU5OfA9d07Kd+IZCrPXv9nvk3Ec9m+5lJMIIkQUa8/+puKtA1Dw5tayH1b3
 6qxNUs8WdkxNJQksL5wrR1sfU1NSWxYHsZdwk+
X-Gm-Gg: ASbGncsWqZbHKZNM0ABpDtLVVhHH4j49O5LdQ00W8HbqtHJVOKAsMvkuy1B/bmNW8My
 WwNO7u/VF784gHtINa9gUvzorlU16ZLORU2YYzjVV9/EYSHL1GEF9RYKb2dNpbxF9oBM0S+meFH
 EHZOqJsRidGkZ5fbMZjgWGnqfmo2FJlHvk3zOSGdH5Kff8wM/dWsbS5ru0gABbLoTAW3471xBHZ
 Pgbk5h0wVfRpifobwkmoYuAtNbQWqH1OXJuRp1aaTTX98iaptYtvCFMmn+oP34gSmHaKDqFmoCP
 ChmlWKbkztlv8TJEPVkvXf3FaXMhKdlSizT0ia1DM6WXUlM=
X-Received: by 2002:a17:906:c10d:b0:ad2:4e96:ee11 with SMTP id
 a640c23a62f3a-ad24e970894mr337504466b.8.1747043656360; 
 Mon, 12 May 2025 02:54:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMYrWFjcqMXEP4KADy8fCTwJLE6vqUJDYjwBCPTsxTMr3vg+wKYzgOkQxgAu+V+RMxMu6uag==
X-Received: by 2002:a17:906:c10d:b0:ad2:4e96:ee11 with SMTP id
 a640c23a62f3a-ad24e970894mr337503066b.8.1747043655889; 
 Mon, 12 May 2025 02:54:15 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8608sm591102866b.26.2025.05.12.02.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:54:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org
Subject: [PATCH 20/26] target/riscv: generalize custom CSR functionality
Date: Mon, 12 May 2025 11:52:20 +0200
Message-ID: <20250512095226.93621-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

While at it, constify it so that the RISCVCSR array in RISCVCPUDef
can also be const.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h    | 15 ++++++++++++---
 target/riscv/cpu.c    | 25 ++++++++++++++++++++++++-
 target/riscv/csr.c    |  2 +-
 target/riscv/th_csr.c | 21 +++------------------
 4 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 8a8d61f8099..f68af8cb124 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -537,6 +537,8 @@ struct ArchCPU {
     const GPtrArray *decoders;
 };
 
+typedef struct RISCVCSR RISCVCSR;
+
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
     RISCVCPUProfile *profile;
@@ -545,6 +547,7 @@ typedef struct RISCVCPUDef {
     int32_t vext_spec;
     RISCVCPUConfig cfg;
     bool bare;
+    const RISCVCSR *custom_csrs;
 } RISCVCPUDef;
 
 /**
@@ -891,6 +894,12 @@ typedef struct {
     uint32_t min_priv_ver;
 } riscv_csr_operations;
 
+struct RISCVCSR {
+    int csrno;
+    bool (*insertion_test)(RISCVCPU *cpu);
+    riscv_csr_operations csr_ops;
+};
+
 /* CSR function table constants */
 enum {
     CSR_TABLE_SIZE = 0x1000
@@ -945,7 +954,7 @@ extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
 extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
-void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
+void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
@@ -954,8 +963,8 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
 
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
-/* Implemented in th_csr.c */
-void th_register_custom_csrs(RISCVCPU *cpu);
+/* In th_csr.c */
+extern const RISCVCSR th_csr_list[];
 
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 171f27fdd87..bc45815383d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -485,6 +485,19 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 }
 #endif
 
+#ifndef CONFIG_USER_ONLY
+static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *csr_list)
+{
+    for (size_t i = 0; csr_list[i].csr_ops.name; i++) {
+        int csrno = csr_list[i].csrno;
+        const riscv_csr_operations *csr_ops = &csr_list[i].csr_ops;
+        if (!csr_list[i].insertion_test || csr_list[i].insertion_test(cpu)) {
+            riscv_set_csr_ops(csrno, csr_ops);
+        }
+    }
+}
+#endif
+
 #if defined(TARGET_RISCV64)
 static void rv64_thead_c906_cpu_init(Object *obj)
 {
@@ -511,7 +524,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     cpu->cfg.mvendorid = THEAD_VENDOR_ID;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_SV39);
-    th_register_custom_csrs(cpu);
+    riscv_register_custom_csrs(cpu, th_csr_list);
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
@@ -1304,6 +1317,11 @@ static void riscv_cpu_init(Object *obj)
     if (mcc->def->vext_spec != RISCV_PROFILE_ATTR_UNUSED) {
         cpu->env.vext_ver = mcc->def->vext_spec;
     }
+#ifndef CONFIG_USER_ONLY
+    if (mcc->def->custom_csrs) {
+        riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
+    }
+#endif
 }
 
 typedef struct misa_ext_info {
@@ -2906,6 +2924,11 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def->misa_ext |= def->misa_ext;
 
         riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
+
+        if (def->custom_csrs) {
+            assert(!mcc->def->custom_csrs);
+            mcc->def->custom_csrs = def->custom_csrs;
+        }
     }
 
     if (!object_class_is_abstract(c)) {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 74760f98cca..833d06237ae 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -38,7 +38,7 @@ void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
     *ops = csr_ops[csrno & (CSR_TABLE_SIZE - 1)];
 }
 
-void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
+void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops)
 {
     csr_ops[csrno & (CSR_TABLE_SIZE - 1)] = *ops;
 }
diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 969a9fe3c80..49eb7bbab5f 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -27,12 +27,6 @@
 #define TH_SXSTATUS_MAEE        BIT(21)
 #define TH_SXSTATUS_THEADISAEE  BIT(22)
 
-typedef struct {
-    int csrno;
-    bool (*insertion_test)(RISCVCPU *cpu);
-    riscv_csr_operations csr_ops;
-} riscv_csr;
-
 static RISCVException smode(CPURISCVState *env, int csrno)
 {
     if (riscv_has_ext(env, RVS)) {
@@ -55,20 +49,11 @@ static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static riscv_csr th_csr_list[] = {
+const RISCVCSR th_csr_list[] = {
     {
         .csrno = CSR_TH_SXSTATUS,
         .insertion_test = test_thead_mvendorid,
         .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
-    }
+    },
+    { }
 };
-void th_register_custom_csrs(RISCVCPU *cpu)
-{
-    for (size_t i = 0; i < ARRAY_SIZE(th_csr_list); i++) {
-        int csrno = th_csr_list[i].csrno;
-        riscv_csr_operations *csr_ops = &th_csr_list[i].csr_ops;
-        if (!th_csr_list[i].insertion_test || th_csr_list[i].insertion_test(cpu)) {
-            riscv_set_csr_ops(csrno, csr_ops);
-        }
-    }
-}
-- 
2.49.0


