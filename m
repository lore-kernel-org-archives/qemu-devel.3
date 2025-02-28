Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA2AC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxcL-0004Qz-Hx; Fri, 28 Feb 2025 05:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbe-0002b1-PM
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbc-00031u-JJ
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CphjNFljmQDZyE9r3LcI0JsZ55JnaokB6rEQUPAWiWs=;
 b=XqnBO0Zng5/5nyn0+oAv8N8bq90dpzBfHWrL4xjOxJ9u+7tPQRW9VUKPZn7xYY2YL5adon
 vv8+Lovm3KN8NvYWtGIz5BMsI4fzRMCYhoBnaTbNR0YHkmilN8bRynFElYRxLIBWIbIYZR
 RUYZUhL/JAIJ7/fcTPuyoRNO3VkcTNQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-3fHvXYT3Mq-RoB1hw2twcw-1; Fri, 28 Feb 2025 05:28:29 -0500
X-MC-Unique: 3fHvXYT3Mq-RoB1hw2twcw-1
X-Mimecast-MFC-AGG-ID: 3fHvXYT3Mq-RoB1hw2twcw_1740738508
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f4c0c1738so1640452f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738507; x=1741343307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CphjNFljmQDZyE9r3LcI0JsZ55JnaokB6rEQUPAWiWs=;
 b=Uolc/JsXCwR/oW2voG9+YO68vHjwNVnJAVxmMGOdlh6LJjfttzVvKxndP09scLPvjO
 TojGJN+IaoHmtDo9zHn5dbfBKbOqzjFZGC7eZc7kKppjwnwTXuu7DY8WI97Xw+hUi6KH
 ZZcde3W0R5kowGMZJYVRltuXuwb2Vp+PiBmogPy/7+bP07yag/DXgBjioLlx5R7lbNpi
 hSnBFpJMpiRpwXpIw4KzHVS3MLzZaNrHYmAaCkaYMp1Alz5qTZHebUWej2NAwhxBrPzX
 ux/XqJchEGIdNYJT1i7ts5J8Iblycd0B7q+rFQ8EnGRc2NDP8NAXffmxBjrXII2erhup
 1UuQ==
X-Gm-Message-State: AOJu0YylAbjAcDDd8BwvmRDgzgPkoxyCfWtml0fPA2A6b1I+t58F0wlk
 BdCuLJwOCGpYgosHlAwvutUuiHNEa+NfQaNUtI7qi9pG+GJCRdjjHvAcCejfVXuRmaevyXbKn+5
 IgJwLLu9GrUi8oxwva7JzOni4+iy9aExFHaHKQohMRxrfAEwyIgxUVqrgTd71fao2QxJWx3KZnJ
 wVawmeeMHAxDtBD+8mPsDgV8KezD7B7kz2pN36Yaw=
X-Gm-Gg: ASbGncvJpPq9G+xvAxOj1VZLsxM17zKgvFmLTlK/y/AvRIJkmfjdwc7h98sTVso7v4v
 UyqzQxtQK4jIgh5QOQomdybumkiarsdJ624YH6ERoraQB7cuHl2qS68HfOT95pSvdj5X3WrvlOi
 DFHQCSlC6JV1y7cBOZ4Q5BkJlY+ewjd/XmlsE4KQbPCmS4OdEaIow3anxW7rphuz2v3i4B1lCSy
 EDkjoLsnKM0gx5kiYyUTWDscC4nmEyZ4f3dHDSuGwjr4rW8Lz2jnc+w2BEwc/mfu+e0P4WzvmUa
 mYXhtKNSNrsNECLDHZBp
X-Received: by 2002:a05:6000:1543:b0:390:efc3:1eac with SMTP id
 ffacd0b85a97d-390efc320d4mr1501337f8f.39.1740738507379; 
 Fri, 28 Feb 2025 02:28:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfkZM3Zdu/hBMAr1QFwv0GZBbjZ7GCbEeNYfjVDmr7pdmUPbD1Ew7YoiUdVrcZ7u1mC7weBA==
X-Received: by 2002:a05:6000:1543:b0:390:efc3:1eac with SMTP id
 ffacd0b85a97d-390efc320d4mr1501313f8f.39.1740738506886; 
 Fri, 28 Feb 2025 02:28:26 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485ddd1sm4807686f8f.94.2025.02.28.02.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:28:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 17/22] target/riscv: generalize custom CSR functionality
Date: Fri, 28 Feb 2025 11:27:41 +0100
Message-ID: <20250228102747.867770-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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
index f00089bd733..a8268599f23 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -531,6 +531,8 @@ struct ArchCPU {
     const GPtrArray *decoders;
 };
 
+typedef struct RISCVCSR RISCVCSR;
+
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
     RISCVCPUProfile *profile;
@@ -539,6 +541,7 @@ typedef struct RISCVCPUDef {
     int32_t vext_spec;
     RISCVCPUConfig cfg;
     bool bare;
+    const RISCVCSR *custom_csrs;
 } RISCVCPUDef;
 
 /**
@@ -874,6 +877,12 @@ typedef struct {
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
@@ -928,7 +937,7 @@ extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
 extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
-void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
+void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
@@ -937,8 +946,8 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
 
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
-/* Implemented in th_csr.c */
-void th_register_custom_csrs(RISCVCPU *cpu);
+/* In th_csr.c */
+extern const RISCVCSR th_csr_list[];
 
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e05fb5d07e0..4d6756a97ce 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -483,6 +483,19 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
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
@@ -509,7 +522,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     cpu->cfg.mvendorid = THEAD_VENDOR_ID;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_SV39);
-    th_register_custom_csrs(cpu);
+    riscv_register_custom_csrs(cpu, th_csr_list);
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
@@ -1300,6 +1313,11 @@ static void riscv_cpu_init(Object *obj)
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
@@ -2792,6 +2810,11 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
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
index 78db9aeda57..7842c525149 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -37,7 +37,7 @@ void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
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
2.48.1


