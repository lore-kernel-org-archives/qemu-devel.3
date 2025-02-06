Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE59C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6bU-0001k1-6i; Thu, 06 Feb 2025 13:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bS-0001hU-77
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bQ-0001GU-GP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3tTPLiwfh9LGGq/8MlcVHCC5GAi1lzXby/r6Gg7rX0=;
 b=GOiF8zW+rSJ5Sne9boPshA3z8HAxQkxigweFVLOmMLLy/ag2WtbFPFy0OeQVu29DxeMTiY
 IoL4zT8PCGFgDluyx/6D5CLJX8daqiPRfni6O7Ej1YDGfyf7Etoh/ak+9SJ8Uy/bji1oVQ
 lNOBx89JOEftHhUS5FW0e/ZcgRRQJcg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-GWVzAE6gP5miuEw48FN1cw-1; Thu, 06 Feb 2025 13:27:50 -0500
X-MC-Unique: GWVzAE6gP5miuEw48FN1cw-1
X-Mimecast-MFC-AGG-ID: GWVzAE6gP5miuEw48FN1cw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43625ceae52so7561815e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866468; x=1739471268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3tTPLiwfh9LGGq/8MlcVHCC5GAi1lzXby/r6Gg7rX0=;
 b=kob6gD1V4GrvWmsOF7yf7HE7sMPiLnKtRRbEW7Q6bvy9Iqo3EJ3AwpWcvp++jEEgRp
 iXFRiKACS3fzNrCK1okuRJUdS8GaSZqqlfvMVwr9aik7r46IPeSAmPtQfarvfig3BbP7
 5ujAdvGoR7Wx3zJ6g7omzn9zQQopdUVXAdhkuXH2YGo8yw+p0hSQa1mizGViTdVb4mZU
 FP0jC2l1JOd1ov2Z9I+KY7XwL5cXyk1jr6MyJmINz/buGzjXPBmpAltkcrS2Xa+D/8Nk
 SdCGufKr6gc2LroQCRiUNCzn8dQf7P8vO74q0AhwFEdY3uxP2a1dY2tBPVf95ruWyHgR
 DGaA==
X-Gm-Message-State: AOJu0YxTGCQnX3E9nl+0XXZ4MaenlwTeEVFB7UP0F4yF2g6rgX7Jr/Kp
 o62GrOxJyr1GM8osCgDYXNGgDW3B4JNA4AwdwHIcu7Drm9UPqycQcuy6qhv3vBOLsMmFKkDy36l
 U3DAyXMJEbWO4oMGRQsDVxf/s+Ww1Jd2914Xs/pkW32lAPEyiqemypu9CUAkbQCGmugnQTnXMTJ
 hxMA4gSjuVmGKVHvlV4wUVp5NwzY3x0W7jq9SfBqw=
X-Gm-Gg: ASbGncvNwfCvWcbSWpM5VnbvT8tZEN0WaQMRBG+NV44tLDtEarRvmK+5iFWreiuiqnZ
 2feFI74bp4AbanmWw5XnaSveV1sEgdNozZEszatJXZK1ZwrVPOV1KV3iUz4BL1D4a2IlMPanOQT
 r1j2eaO3DxwnfZwSxaACqlZLy7be0AwZeWhHB0pNyCkjuSdiUG1eAHEDoOP1I38UywwXJqrInBA
 EWpbMo1h3DEBzPhxtnrZ5plCc9B4vaddd35iuY4X/ilCmEL5f5PTzswK1N0z4k1LakNJSzNI9Yz
 LV+krQQ=
X-Received: by 2002:a05:600c:524c:b0:434:a59c:43c6 with SMTP id
 5b1f17b1804b1-439249c03d0mr3141975e9.26.1738866468516; 
 Thu, 06 Feb 2025 10:27:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEz72ERuOBVebdjdS+rWt0cw7xdItuS0WxgX+9mvY+5Tre5mZiLMPC2jNuNOXhWnDVvTkGoEw==
X-Received: by 2002:a05:600c:524c:b0:434:a59c:43c6 with SMTP id
 5b1f17b1804b1-439249c03d0mr3141825e9.26.1738866468158; 
 Thu, 06 Feb 2025 10:27:48 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d93374csm65416215e9.8.2025.02.06.10.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 16/22] target/riscv: generalize custom CSR functionality
Date: Thu,  6 Feb 2025 19:27:04 +0100
Message-ID: <20250206182711.2420505-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182711.2420505-1-pbonzini@redhat.com>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h    | 13 +++++++++++--
 target/riscv/cpu.c    | 23 ++++++++++++++++++++++-
 target/riscv/th_csr.c | 21 +++------------------
 3 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 66ce72f7d41..00ec475fbba 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -517,6 +517,8 @@ struct ArchCPU {
     const GPtrArray *decoders;
 };
 
+typedef struct RISCVCSR RISCVCSR;
+
 typedef struct RISCVCPUDef {
     RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
     RISCVCPUProfile *profile;
@@ -527,6 +529,7 @@ typedef struct RISCVCPUDef {
     int satp_mode64;
     RISCVCPUConfig cfg;
     bool bare;
+    RISCVCSR *custom_csrs;
 } RISCVCPUDef;
 
 /**
@@ -862,6 +865,12 @@ typedef struct {
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
@@ -926,8 +935,8 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
 uint8_t satp_mode_max_from_map(uint32_t map);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
-/* Implemented in th_csr.c */
-void th_register_custom_csrs(RISCVCPU *cpu);
+/* In th_csr.c */
+extern RISCVCSR th_csr_list[];
 
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 18c59633d76..6c898cef625 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -471,6 +471,19 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 }
 #endif
 
+#ifndef CONFIG_USER_ONLY
+static void riscv_register_custom_csrs(RISCVCPU *cpu, RISCVCSR *csr_list)
+{
+    for (size_t i = 0; csr_list[i].csr_ops.name; i++) {
+        int csrno = csr_list[i].csrno;
+        riscv_csr_operations *csr_ops = &csr_list[i].csr_ops;
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
@@ -497,7 +510,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
     cpu->cfg.mvendorid = THEAD_VENDOR_ID;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(cpu, VM_1_10_SV39);
-    th_register_custom_csrs(cpu);
+    riscv_register_custom_csrs(cpu, th_csr_list);
 #endif
 
     /* inherited from parent obj via riscv_cpu_init() */
@@ -1301,6 +1314,9 @@ static void riscv_cpu_init(Object *obj)
     if (riscv_cpu_mxl(env) >= MXL_RV64 && mcc->def->satp_mode64 != RISCV_PROFILE_ATTR_UNUSED) {
         set_satp_mode_max_supported(RISCV_CPU(obj), mcc->def->satp_mode64);
     }
+    if (mcc->def->custom_csrs) {
+        riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
+    }
 #endif
 }
 
@@ -2791,6 +2807,11 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
         mcc->def->misa_ext |= def->misa_ext;
 
         riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
+
+        if (def->custom_csrs) {
+            assert(!mcc->def->custom_csrs);
+            mcc->def->custom_csrs = def->custom_csrs;
+        }
     }
 
     if (!object_class_is_abstract(c)) {
diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 990453e080e..b648004dbc6 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -27,12 +27,6 @@
 #define TH_SXSTATUS_MAEE        BIT(21)
 #define TH_SXSTATUS_THEADISAEE  BIT(22)
 
-typedef struct {
-    int csrno;
-    int (*insertion_test)(RISCVCPU *cpu);
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
+RISCVCSR th_csr_list[] = {
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


