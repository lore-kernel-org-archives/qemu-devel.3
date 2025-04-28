Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8CAC369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1d-0006Mj-P9; Mon, 28 Apr 2025 03:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1Z-0006KU-S8
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1Y-0001EC-4C
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0PVE/VGPlqsBgwvYY9EnmSoqwfUI086grbQ4jzJngwk=;
 b=PWivULfoIzjLHNr7P/O4DEqOhJ8GBMRbZuC6sUckoIpV898SNzZhjEg/DlpYLyYJPCQbbU
 E2WLI1Eu74enWxptIWVsq0l92OlGzyqvB9qHJcQZVbT7/mLY57/CkLBjVPFNkEKfzTFdFB
 j91yKZm3lyPAMerVUAmo0C0o/CuG0q4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-CcQse__mOiysurnlr74-cg-1; Mon, 28 Apr 2025 03:35:26 -0400
X-MC-Unique: CcQse__mOiysurnlr74-cg-1
X-Mimecast-MFC-AGG-ID: CcQse__mOiysurnlr74-cg_1745825725
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43f251dc364so23548815e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825724; x=1746430524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0PVE/VGPlqsBgwvYY9EnmSoqwfUI086grbQ4jzJngwk=;
 b=lUS8uy0PXMkIFQCrcNWZpCPxEHoIth484AeV+ML+lynM937PJjFPefZsR73PtLqPtv
 eKo6uT0/vGtQu1bTkzF2/Uu076RJoLYHcSgEfpcoG/NEzfPKQ+613YZ7V4bQBOD5T5U4
 X247/lxpy1sWlgA0+qKkbtqRA3nGN7R+o2ZR3fmrF3xHVgAl8b6Q1BQWqw0PSLvZLpyM
 ajER3/yIK2YeQMhh7IzbcqUHGWkfuyHF/wYYLpwcXhkq6cB+JT56NHPm6cvuj1HjQ8yg
 W4dIvDgszD8fAxtbb3dUH4jmlHqc/pPyih2n3gJ4M6EYEmqtPuw7F97zggzgl5F1CE/l
 8/eQ==
X-Gm-Message-State: AOJu0YxyYh3O6rcZhhyRNP3Mc+X3gqu2i2qdCEv+NNGHxPRrQZVeH054
 cvBRk8d5BN5ENUOgAMakl/B+wqqVApFtMZPB1YVjq+T8fKZ424NjkARmPJXSiyoLJgShNUFECXX
 mL5Uwwc0DJ+nPWQ/7Qp+zqnLDd/5g0fNwRIQa7lvR5qw6am61Rb/SOfS72J7ffEscROfbbhKcF7
 yFBbW2un6SI+6NtGPnFt7pwJ08r7heIEO3jUqm
X-Gm-Gg: ASbGncuIEo8CchCJJWw7cw3FSXT9VP0RDfJGmNO7+MyAhRgYY5c7kRINcq0pFwzph1P
 An2H0KdQj4HquRuhIsu33z7Lb3VM2hNAuZXYwqMmg35EeedCY2AUfAu2Gq4Is7p86003KaRX4c8
 GoJ8jDbg4Kh210EofgZGPNRNgZxy32h4ds7IPDEBjPExwt8P7RI0vK1d/11GaHnEv8p1LFETuBI
 JxJgEB8a61ziTFNDQCRJQDX/YgfJX6KlHeF1aN9ho+VHEifTeggFf0VAPtl4RLrZLcahAx4Wx0a
 lWETH/MZRQ/6AHg=
X-Received: by 2002:a05:600c:3491:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-440a66b6fb1mr91609935e9.29.1745825724105; 
 Mon, 28 Apr 2025 00:35:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkbthaPRmmOB6pCCHVToLZow06r0CXv8UFFusoXXqE6WpIeBZnV2KsvUqq8/iQiVoEgnwhzw==
X-Received: by 2002:a05:600c:3491:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-440a66b6fb1mr91609695e9.29.1745825723707; 
 Mon, 28 Apr 2025 00:35:23 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2e0241sm147580265e9.37.2025.04.28.00.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 15/26] target/riscv: convert bare CPU models to RISCVCPUDef
Date: Mon, 28 Apr 2025 09:34:30 +0200
Message-ID: <20250428073442.315770-16-pbonzini@redhat.com>
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 58 ++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 41 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c07ce5ddb9b..93992be6c4d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -733,18 +733,6 @@ static void rv128_base_cpu_init(Object *obj)
 }
 #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
 
-static void rv64i_bare_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    riscv_cpu_set_misa_ext(env, RVI);
-}
-
-static void rv64e_bare_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    riscv_cpu_set_misa_ext(env, RVE);
-}
-
 #endif /* !TARGET_RISCV64 */
 
 #if defined(TARGET_RISCV32) || \
@@ -837,18 +825,6 @@ static void rv32_imafcu_nommu_cpu_init(Object *obj)
     cpu->cfg.ext_zicsr = true;
     cpu->cfg.pmp = true;
 }
-
-static void rv32i_bare_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    riscv_cpu_set_misa_ext(env, RVI);
-}
-
-static void rv32e_bare_cpu_init(Object *obj)
-{
-    CPURISCVState *env = &RISCV_CPU(obj)->env;
-    riscv_cpu_set_misa_ext(env, RVE);
-}
 #endif
 
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
@@ -3217,19 +3193,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         }),                                                 \
     }
 
-#define DEFINE_BARE_CPU(type_name, misa_mxl_max_, initfn)   \
-    {                                                       \
-        .name = (type_name),                                \
-        .parent = TYPE_RISCV_BARE_CPU,                      \
-        .instance_init = (initfn),                          \
-        .class_data = &((const RISCVCPUDef) {               \
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
@@ -3314,8 +3277,15 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E31, MXL_RV32,  rv32_sifive_e_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_E34, MXL_RV32,  rv32_imafcu_nommu_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_SIFIVE_U34, MXL_RV32,  rv32_sifive_u_cpu_init),
-    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32I,        MXL_RV32,  rv32i_bare_cpu_init),
-    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV32E,        MXL_RV32,  rv32e_bare_cpu_init),
+
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32I, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVI
+    ),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV32E, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV32,
+        .misa_ext = RVE
+    ),
 #endif
 
 #if (defined(TARGET_RISCV64) && !defined(CONFIG_USER_ONLY))
@@ -3335,8 +3305,14 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
 #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
-    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64I,        MXL_RV64,  rv64i_bare_cpu_init),
-    DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64I, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVI
+    ),
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RV64E, TYPE_RISCV_BARE_CPU,
+        .misa_mxl_max = MXL_RV64,
+        .misa_ext = RVE
+    ),
 
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  TYPE_RISCV_CPU_RV64I,  RVA22U64),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  TYPE_RISCV_CPU_RV64I,  RVA22S64),
-- 
2.49.0


