Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22C8C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J21-0006no-Q0; Mon, 28 Apr 2025 03:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1k-0006UL-Jt
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1h-0001GE-Ij
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vJj+jGmnZ+i31NPU1KlbuPTt63v2KwWQ+6AZPrSdDDM=;
 b=e58ZuC/HJv56mUuP/se6uKscsrWxZBob9PXo6jtmVlpvZkBf//2+0QKsVicz5NGz6QqUsm
 V3Z1sTqmhwQLsDAhQqbS/YreX7LtarE889NvZU3ulY6S19Vezn3oEuPMBM95xOVLGw7afQ
 /erobXfe80vUSG24Gf+GmKi9FjC3d50=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-h-vvstkTN4W-2-qqNGwkuw-1; Mon, 28 Apr 2025 03:35:39 -0400
X-MC-Unique: h-vvstkTN4W-2-qqNGwkuw-1
X-Mimecast-MFC-AGG-ID: h-vvstkTN4W-2-qqNGwkuw_1745825738
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39131851046so1033861f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825737; x=1746430537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJj+jGmnZ+i31NPU1KlbuPTt63v2KwWQ+6AZPrSdDDM=;
 b=OcCVjf1Eb3kynwKxStoCdWwZb9uBCPkxd8DKlOp9keLbMCNGCc1ncNfagRzK8FMmWv
 QU/8KngSCVWUr9owqco4VMN1927E/FTBBJPT39r/x3caukKEVNR76k/BgDjrwFdst4zo
 6dLKgsacaF99IncQj3b27+aK7dFtj+J3JadQgtxEPnRjU2xyNGrLO+l3ydNTbyq4AkDF
 se48DKBvJ+EJepSlk/fdA+luFU7jyCPWs/JVjkoKyrVbts1Vs1RWUEg6HoBwbMpj6sZv
 dm28g/FNrxi3M5VrGZOJ1Aam/lS4BYTwD77gciZ1Qx8xl7m6Z6VopQ9FwDI74fDtFsFz
 mScQ==
X-Gm-Message-State: AOJu0YzQ8OIadG06DrBjnoF3ZEn8btbOG8KLsouZAk07YChEt/8vcP5d
 OULv4U1UgW0Hw2iweRIX/JXkABnw5wHYgIj+S9ZezVasq8iYvxVPG2XLr+kxYEndN15KJDStKup
 hGrAA0FfL05Y3r/CUrCOyuvHmN2/v7cIJIgDob44BD9tQQoywTf58DeRPzlqUyuzapBodEd+C1v
 OfqRX6A+gjW/YcPgTsmECyF1ccqyoGcRKpC5C0
X-Gm-Gg: ASbGncsby3t9E2BFL35Et2BTyCjF8Zq285Xa8R9Eky8+32LPaLXRUeJWthBBLrNg6m2
 AgVTOzwzcsbjD0Qc/vi+NoGCFRfrKChBYBWPwZnQlBhF3y7tDW3LF0OAXznwLcIdrH72QthdIuV
 dSFPqsCTi7cUSrafCBXW/jBNX7lRLGthoaykehkPHP+YjxD5p5cSM7dZ7m4JQATEezbNy6jm4pU
 PAjEM/QHLf/q9rC8WMHM6G5CkO9UXR+ZXNRKxPUbFq7YiY0WisRlkuzp94C3MYlPsZb3Ddo9ZZ4
 jV/a6KJs+iAFr64=
X-Received: by 2002:a05:6000:1889:b0:391:2306:5131 with SMTP id
 ffacd0b85a97d-3a074f15b33mr8756825f8f.45.1745825736973; 
 Mon, 28 Apr 2025 00:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8KHVaGU8qq8x5bSOicpXe4c0oDiAm5QX2TsOuD6r/AhnbJOblxYq1rmSsEBtduRhO0vbFlw==
X-Received: by 2002:a05:6000:1889:b0:391:2306:5131 with SMTP id
 ffacd0b85a97d-3a074f15b33mr8756807f8f.45.1745825736587; 
 Mon, 28 Apr 2025 00:35:36 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5c7d1sm10181027f8f.83.2025.04.28.00.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 21/26] target/riscv: generalize custom CSR functionality
Date: Mon, 28 Apr 2025 09:34:36 +0200
Message-ID: <20250428073442.315770-22-pbonzini@redhat.com>
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

While at it, constify it so that the RISCVCSR array in RISCVCPUDef
can also be const.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h    | 15 ++++++++++++---
 target/riscv/cpu.c    | 25 ++++++++++++++++++++++++-
 target/riscv/csr.c    |  2 +-
 target/riscv/th_csr.c | 21 +++------------------
 4 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 38fd667aba6..238687c635c 100644
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
@@ -894,6 +897,12 @@ typedef struct {
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
@@ -948,7 +957,7 @@ extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
 extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
-void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
+void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
@@ -957,8 +966,8 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
 
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
-/* Implemented in th_csr.c */
-void th_register_custom_csrs(RISCVCPU *cpu);
+/* In th_csr.c */
+extern const RISCVCSR th_csr_list[];
 
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9a28f590c45..5045ebc0b70 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -486,6 +486,19 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
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
@@ -512,7 +525,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     cpu->cfg.mvendorid = THEAD_VENDOR_ID;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_SV39);
-    th_register_custom_csrs(cpu);
+    riscv_register_custom_csrs(cpu, th_csr_list);
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
@@ -1305,6 +1318,11 @@ static void riscv_cpu_init(Object *obj)
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
@@ -2907,6 +2925,11 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
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
index 038be009c82..e85b3aedf6e 100644
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


