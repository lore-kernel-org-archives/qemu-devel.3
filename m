Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714E4C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxU-0002Hh-Ad; Tue, 04 Mar 2025 20:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxS-0002C3-3j
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:02 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxQ-0008R4-85
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:01 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2238d965199so61658345ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139638; x=1741744438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S3RPKYD/bhhgWxhDcoNiZL6fbw8dpzm/Vt1b7Obkvv0=;
 b=bKHvtPomEdEyHsERNfm6gbIG5GwcIPB8ZMR60XeJ0prmC6qwBJVXkPi2s3jcKrJMJv
 l2tvab1EVlcHhC1mxydaKz8xAau+upFOAcSIEgx7nfRbpze/lugtubVAVs+BaOOBEsPU
 3mK2D+Px1fMvaqKIMCqoUF0KOs7KJ5XqQaeOVZgfVZeb1yE/4CG9u4/GATNVUTWkMINA
 Q+Y+o+Ny944JtRLC/uKdBySC7ecZGOAbuCHkOx1e2/gjqukBlQYveg/RBIrThoxl50Sg
 eHUhR+gA96rDYYZIs8Yy3ozAUTjKAOYUJg5CG4hjF/qMYpb1ro80Kcvt7a6+cHhBae7Z
 bYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139638; x=1741744438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3RPKYD/bhhgWxhDcoNiZL6fbw8dpzm/Vt1b7Obkvv0=;
 b=Sj6lsNjLopWgKYmGWECMWo6qc2Ah9YZ5a8Ck9pTHwV1uHy5xBA+XawKsa28+edR5Ow
 OS71lvSLOPOuVBEvjmwMjweGVIvPmSiNmEQ3dzWKfplIGMPZ4y3kxXVsTTxy3D0BPyPn
 GHPZoARAeT2CEgHZqnswQlzW3pQAs/AOMLJts/l9pe3Nc6dYZ7wwBZlO1X0txgt3BAQa
 +BL4KDgIAzYTRqReoFI/xLOXBBsfxYIzJxaFHptHGJlmJz6qvHw8c/IGhnQ8L4fYpQsP
 XyMtPUYEiyQEUALLKnU8+2c4Q/XtzkvXgs5t+pOynyqy9wczSo09ogpCNOsldhW2bLdO
 uKJA==
X-Gm-Message-State: AOJu0Ywuv7lhtKpVA5eZmqE+NdNZNTtweN8dIpoQRxT5YmkzDJDRrgJz
 JCDFvu6W2/ooiL0aS+v9Cb8bXS8R8tLB0obW/cIXI9eK2pqdOsmo72gCbW1qaoc=
X-Gm-Gg: ASbGncuKRp49oNp6G2AKIvgiDInFCk/pl3rUkwc77KlmabYXTKjMKI31iuJ6oyu5oPe
 blo1yopRHeH/2LL8ftS5XmxvPEkm3aQ5sOTiPQ69/cz2KGNCMQf1HCgYX8MGN5pO2j3EjGXuXGt
 Y81n8UtUJjpoPG0ENubH8JKfVEBvoT1sFEwJ7RDEtY0n9b0ASbbo8GTsxqikL8Mwhx6Pr1oCpg2
 rzQWZ8zO1PUTuyNd9j0bRChIRxAgd/XQ7KKvezkgb+qZdfKIw+Ur91fPmNEc38d8JM6U9QNqXw7
 dhiZB+c+J22SMPUm1Z7qBsyHBntW+1NMnToAdnbrUQIVb1mP5Jo16/7vWVoZPT3rJKJy9ws/rqg
 BuMDWarN/+f/PkVzX15YMy15M8DOvU0feWxvMqFfTRuifneAqNlY=
X-Google-Smtp-Source: AGHT+IHKLoM6GGtDAx1ojq6dEoqAJikdzBbs4s+XjsvO2h97ktXR6mYBka9wXaGfmDoQXgxnfL1Uzg==
X-Received: by 2002:a17:903:244d:b0:223:67e1:401f with SMTP id
 d9443c01a7336-223f1d34f8amr22625705ad.48.1741139638374; 
 Tue, 04 Mar 2025 17:53:58 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:57 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 15/59] target/riscv: add RVA23U64 profile
Date: Wed,  5 Mar 2025 11:52:23 +1000
Message-ID: <20250305015307.1463560-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Add RVA23U64 as described in [1]. Add it as a child of RVA22U64 since
all RVA22U64 mandatory extensions are also present in RVA23U64. What's
left then is to list the mandatory extensions that are RVA23 only.

A new "rva23u64" CPU is also added.

[1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250115184316.2344583-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index d56b067bf2..53ead481a9 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -40,6 +40,7 @@
 #define TYPE_RISCV_CPU_RV64E            RISCV_CPU_TYPE_NAME("rv64e")
 #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
+#define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7b708bd010..511ed1df0e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2391,9 +2391,34 @@ static RISCVCPUProfile RVA22S64 = {
     }
 };
 
+/*
+ * All mandatory extensions from RVA22U64 are present
+ * in RVA23U64 so set RVA22 as a parent. We need to
+ * declare just the newly added mandatory extensions.
+ */
+static RISCVCPUProfile RVA23U64 = {
+    .u_parent = &RVA22U64,
+    .s_parent = NULL,
+    .name = "rva23u64",
+    .misa_ext = RVV,
+    .priv_spec = RISCV_PROFILE_ATTR_UNUSED,
+    .satp_mode = RISCV_PROFILE_ATTR_UNUSED,
+    .ext_offsets = {
+        CPU_CFG_OFFSET(ext_zvfhmin), CPU_CFG_OFFSET(ext_zvbb),
+        CPU_CFG_OFFSET(ext_zvkt), CPU_CFG_OFFSET(ext_zihintntl),
+        CPU_CFG_OFFSET(ext_zicond), CPU_CFG_OFFSET(ext_zimop),
+        CPU_CFG_OFFSET(ext_zcmop), CPU_CFG_OFFSET(ext_zcb),
+        CPU_CFG_OFFSET(ext_zfa), CPU_CFG_OFFSET(ext_zawrs),
+        CPU_CFG_OFFSET(ext_supm),
+
+        RISCV_PROFILE_EXT_LIST_END
+    }
+};
+
 RISCVCPUProfile *riscv_profiles[] = {
     &RVA22U64,
     &RVA22S64,
+    &RVA23U64,
     NULL,
 };
 
@@ -2880,6 +2905,13 @@ static void rva22s64_profile_cpu_init(Object *obj)
 
     RVA22S64.enabled = true;
 }
+
+static void rva23u64_profile_cpu_init(Object *obj)
+{
+    rv64i_bare_cpu_init(obj);
+
+    RVA23U64.enabled = true;
+}
 #endif
 
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
@@ -3150,6 +3182,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
 #endif /* TARGET_RISCV64 */
 };
 
-- 
2.48.1


