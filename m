Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED04C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6bP-0001SZ-GK; Thu, 06 Feb 2025 13:27:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bN-0001Mf-Oj
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bM-0001EA-4i
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJKfw6fd4TEfoHjZHwoe08S2vp+Xy0Ju/mqgD1gDQwQ=;
 b=N4A19pfyhWozOrmwqGR+/+sszhZWs683lrAuTeOJyTyYLMf32P+Kct7TzAR0SNF3J30BP7
 bb+X+XglAR1AB82wuqVgOARuYJOK4JOvRuqg7pV35XZTTq5vayVuKPfI3DoSZooDAA2vAf
 e+CS4CS8LxpceVgSDZaLG/6akyWwZfY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-Ie8Bc1Q-MzS9KvTxhiU5lA-1; Thu, 06 Feb 2025 13:27:46 -0500
X-MC-Unique: Ie8Bc1Q-MzS9KvTxhiU5lA-1
X-Mimecast-MFC-AGG-ID: Ie8Bc1Q-MzS9KvTxhiU5lA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361b090d23so7193775e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866464; x=1739471264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJKfw6fd4TEfoHjZHwoe08S2vp+Xy0Ju/mqgD1gDQwQ=;
 b=ibog2dfvVLEKxzQF8cQ7uLlqvDGdp78JLK3tBaiTeoEKQFR0h3ZCg+QLWYuzylPU8u
 PBz5PoZGEBSSDtjJcB+NGqhHKBV4OOwGRegEx8Yx3jRWWCdw8wEFq1r0rXZXvrxzAtFb
 IpInsIwz3Wyn+ruy5Dq0UopK+wRc6WPu2+0iLqSYkXH7NduaqpMJ/rX9MyNXb6OfXc7Q
 86BB54tFEy70wPUpg40s+M8BgAG8f21nOjkr/AFHxbNLwpzAXGoFF8ShfnSk2bDXOuCK
 NExk+9TLTZvfsFVmrJKQQKhJbWT+4uUpMUJudondj0qe0198PFgby/rDH7LjXtylMvpH
 A8ZQ==
X-Gm-Message-State: AOJu0YyLeleFMfFtlXhGFrnFbGZJJIPGbJ60+jJrnGbQn4m4krtkZtGC
 N5GbX3ftZnGugZMgMWVdN/5O1H1D+nvFp28AXLGNv0jJe0iAHtj2trKjxC6DaeTi5XVRQ80QnOe
 /gUDv1uzkz4QhUItzEu+Flb29IIxHJ/DyfAmTsPSSVpdWb/9iOGVk47gRDbWsoeNF2avc3xe3DY
 kOzU7Duj3Pd6d6eRg9SE1PCOWHfxZzCUVcWSydQQA=
X-Gm-Gg: ASbGncte3vMHktxgffTzoO81UHvdBpVC7XsLxZho4Yc6uC9EkvTPpuOmFIhy7Xjl+S/
 IeEoZGZ0NStGkEwQsdkw9o9+YZfhnhJnG+GsWOKbibL6uXV3rs7bLTSE8Dgq28lw+o0+KekDU0D
 PG/J1jhSGRfc0Fa1cq/tQZFwGaGGKrnBdBd/n/ABcu7Y+w+pTXqah+XzN90Swd5DvF9X8L/TIrO
 og0aKGOFzgWmHROqjEajBiPiw6GCXjKdhbrc9LapmnOlG4uwke58Sy5zRVj3hdDaflNub2BV6Wk
 iNsqAxs=
X-Received: by 2002:a05:600c:c19:b0:436:fb02:e68 with SMTP id
 5b1f17b1804b1-4392497f9cbmr4102005e9.2.1738866464488; 
 Thu, 06 Feb 2025 10:27:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELX6PJ8fR4xbxmyVyvONwyIDSjNgJ4/qkTLalF5MajmAx0SizdjgSFl3XtTgiW7mPW1akbVA==
X-Received: by 2002:a05:600c:c19:b0:436:fb02:e68 with SMTP id
 5b1f17b1804b1-4392497f9cbmr4101895e9.2.1738866464145; 
 Thu, 06 Feb 2025 10:27:44 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf4438sm64233475e9.25.2025.02.06.10.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 14/22] target/riscv: convert SiFive U models to RISCVCPUDef
Date: Thu,  6 Feb 2025 19:27:02 +0100
Message-ID: <20250206182711.2420505-15-pbonzini@redhat.com>
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
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 65 ++++++++++++++++--------------------------
 2 files changed, 25 insertions(+), 41 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index bfe1455254c..398cb4f583c 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -46,6 +46,7 @@
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
 #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
+#define TYPE_RISCV_CPU_SIFIVE_U         RISCV_CPU_TYPE_NAME("sifive-u")
 #define TYPE_RISCV_CPU_SIFIVE_U34       RISCV_CPU_TYPE_NAME("sifive-u34")
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
 #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a8aaa65f56e..18c59633d76 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -472,23 +472,6 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
 #endif
 
 #if defined(TARGET_RISCV64)
-static void rv64_sifive_u_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV39);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-}
-
 static void rv64_thead_c906_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -657,27 +640,6 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 
 #endif /* !TARGET_RISCV64 */
 
-#if defined(TARGET_RISCV32) || \
-    (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
-
-static void rv32_sifive_u_cpu_init(Object *obj)
-{
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    CPURISCVState *env = &cpu->env;
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.mmu = true;
-    cpu->cfg.pmp = true;
-}
-#endif
-
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -3033,6 +2995,18 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp = true
     ),
 
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U, TYPE_RISCV_VENDOR_CPU,
+        .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
+        .priv_spec = PRIV_VERSION_1_10_0,
+        .satp_mode32 = VM_1_10_SV32,
+        .satp_mode64 = VM_1_10_SV39,
+
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.mmu = true,
+        .cfg.pmp = true
+    ),
+
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
@@ -3065,7 +3039,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_ext = RVF,  /* IMAFCU */
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U34, TYPE_RISCV_CPU_SIFIVE_U,
+        .misa_mxl_max = MXL_RV32
+    ),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
         .misa_mxl_max = MXL_RV32,
@@ -3093,8 +3069,15 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
         .misa_mxl_max = MXL_RV64
     ),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
+
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U54, TYPE_RISCV_CPU_SIFIVE_U,
+        .misa_mxl_max = MXL_RV64
+    ),
+
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SHAKTI_C, TYPE_RISCV_CPU_SIFIVE_U,
+        .misa_mxl_max = MXL_RV64
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_ascalon_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
-- 
2.48.1


