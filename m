Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCC7C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1i-0006Pf-IP; Mon, 28 Apr 2025 03:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1b-0006L1-KK
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1Z-0001Ea-36
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20r00/ELRVpohyBVEb1ee4kSN76Tl47q3TsTj2NFArA=;
 b=CqBpkTEDoXfFRQPsWCBKU8hwWJ3cibMojngdepomXHIxUl9KDvF/54aPPeulKlxl4oc0rW
 RaIGow3B+5uQwd4KUqx7EKUTHQNFW9cBav5EsFpd8oMwhUwLeH1CxR10g/mEfVtE57VvWc
 yeC3q2LZGVgjXm0tiMwSNE3ezC4mgW0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-m4R2mt4FMVKXx5ozVnISPw-1; Mon, 28 Apr 2025 03:35:30 -0400
X-MC-Unique: m4R2mt4FMVKXx5ozVnISPw-1
X-Mimecast-MFC-AGG-ID: m4R2mt4FMVKXx5ozVnISPw_1745825729
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so20615925e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825728; x=1746430528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=20r00/ELRVpohyBVEb1ee4kSN76Tl47q3TsTj2NFArA=;
 b=BkSHONh+ZgU108quoaAtq/9e2V5R1XgruGA2YW4Qorc9H/Me+EgQA/4zgUYx2H+iI0
 qua8P5bbtq3nu5KWchcvAU9BQtqwtn8koO1i4gMu8zErKzeNwU978hrO2J/VMUDaCEwu
 McaMNXQEvsK2NU4Smq7+hdch2Hw77XszfTA/5VbC9HD8Gp8+bu5+aqoEX/pLX7T28Hvu
 6DBsplKfLnyLNoGWTMTifg93Wvp8tIPNLR/SGGHHcV1JUWJ0vNYVv6umNzDanFTDMuIt
 A1VzUQ5zHvb/iyLJ7xPI2MEVvIRowsX5gtQ2XB44jUJ3A78nirhTMcWZtAOgiH76rOGy
 1idg==
X-Gm-Message-State: AOJu0Yzq+rxTXScOEv2oQ2+gduxwnUdNXQrZ4dVwDmQwwvAjl9mZx5yo
 vwk6ypR3212z1+4TelKjAEHg9zpinD4YEee1hIR8m0WA5KzJha5lHRxBhFSFgIRecsfhnqQ38wB
 0vzh98p1Rt2yev+zYBC9UNEK8mv4XFnjKj+YFOnml3t7zluwhtL11UTKEnVuz+xyaiBX1gNQ62e
 ACwOPGa2SrjRa+XJIgXE9DfD5aW6WjfXAdYFaf
X-Gm-Gg: ASbGncv4yCFihyW10YSLYTmp6NTG4zRgOE7c64n/oTITDEgbWSGoLmjN50rSP+yEMLU
 +dMnqaKpFpCosYPG2mlqnJS4cUl3fY8Joc9OIPRxmJM9hV5jQlBf4lEEFyhxf8/dWK0WW/7/zKO
 0aWSk+kI5IzgAgASHltLgSDiCM0DaY3ZV+XJwzAQYJPKTUFIf+0TfvxY5adzWiqk8ZAquUAn/Kb
 gpPg+3YyFymGh+geHRUy0wvbxGG43dzd1hnhy2BG9sXP2sfREt81p7CJYt/moDMz5khYhOFynvm
 cUQDXrhcwEJq75Y=
X-Received: by 2002:a5d:5f8f:0:b0:38d:b325:471f with SMTP id
 ffacd0b85a97d-3a074e23241mr7857768f8f.15.1745825728378; 
 Mon, 28 Apr 2025 00:35:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErLykpvcE+rTPzvix421zI3DhygvOnBCz6y1HoZL8j3uBIKK0Kx4kOfmLMla6hf/BJQn/GVA==
X-Received: by 2002:a5d:5f8f:0:b0:38d:b325:471f with SMTP id
 ffacd0b85a97d-3a074e23241mr7857749f8f.15.1745825727937; 
 Mon, 28 Apr 2025 00:35:27 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46a54sm10480977f8f.67.2025.04.28.00.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 17/26] target/riscv: convert SiFive E CPU models to RISCVCPUDef
Date: Mon, 28 Apr 2025 09:34:32 +0200
Message-ID: <20250428073442.315770-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 74 ++++++++++++------------------------------
 2 files changed, 21 insertions(+), 54 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 4cfdb74891e..0f9be15e47b 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -44,6 +44,7 @@
 #define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
+#define TYPE_RISCV_CPU_SIFIVE_E         RISCV_CPU_TYPE_NAME("sifive-e")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
 #define TYPE_RISCV_CPU_SIFIVE_E34       RISCV_CPU_TYPE_NAME("sifive-e34")
 #define TYPE_RISCV_CPU_SIFIVE_E51       RISCV_CPU_TYPE_NAME("sifive-e51")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 56f292a3616..5b4ffc285da 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -504,23 +504,6 @@ static void rv64_sifive_u_cpu_init(Object *obj)
     cpu->cfg.pmp = true;
 }
 
-static void rv64_sifive_e_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVC | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-}
-
 static void rv64_thead_c906_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -709,23 +692,6 @@ static void rv32_sifive_u_cpu_init(Object *obj)
     cpu->cfg.pmp = true;
 }
 
-static void rv32_sifive_e_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVC | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-}
-
 static void rv32_ibex_cpu_init(Object *obj)
 {
     CPURISCVState *env = &RISCV_CPU(obj)->env;
@@ -747,23 +713,6 @@ static void rv32_ibex_cpu_init(Object *obj)
     cpu->cfg.ext_zbc = true;
     cpu->cfg.ext_zbs = true;
 }
-
-static void rv32_imafcu_nommu_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    riscv_cpu_set_misa_ext(env, RVI | RVM | RVA | RVF | RVC | RVU);
-    env->priv_ver = PRIV_VERSION_1_10_0;
-#ifndef CONFIG_USER_ONLY
-    set_satp_mode_max_supported(cpu, VM_1_10_MBARE);
-#endif
-
-    /* inherited from parent obj via riscv_cpu_init() */
-    cpu->cfg.ext_zifencei = true;
-    cpu->cfg.ext_zicsr = true;
-    cpu->cfg.pmp = true;
-}
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -3205,6 +3154,15 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #endif
     ),
 
+    DEFINE_ABSTRACT_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E, TYPE_RISCV_VENDOR_CPU,
+        .misa_ext = RVI | RVM | RVA | RVC | RVU,
+        .priv_spec = PRIV_VERSION_1_10_0,
+        .cfg.max_satp_mode = VM_1_10_MBARE,
+        .cfg.ext_zifencei = true,
+        .cfg.ext_zicsr = true,
+        .cfg.pmp = true
+    ),
+
 #if defined(TARGET_RISCV32) || \
     (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
@@ -3213,8 +3171,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     ),
 
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_IBEX,       MXL_RV32,  rv32_ibex_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_e_cpu_init),
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_nommu_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E31, TYPE_RISCV_CPU_SIFIVE_E,
+        .misa_mxl_max = MXL_RV32
+    ),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E34, TYPE_RISCV_CPU_SIFIVE_E,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVF,  /* IMAFCU */
+    ),
+
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
 
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
@@ -3240,7 +3204,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV64,
     ),
 
-    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E51, MXL_RV64,  rv64_sifive_e_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
+        .misa_mxl_max = MXL_RV64
+    ),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U54, MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SHAKTI_C,   MXL_RV64,  rv64_sifive_u_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c906_cpu_init),
-- 
2.49.0


