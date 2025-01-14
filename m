Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CCAC02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 19:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXm9z-0008To-6h; Tue, 14 Jan 2025 14:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXm9R-0006XZ-PM
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 14:00:35 -0500
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXm9O-00037S-RK
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 14:00:32 -0500
Received: by mail-oo1-xc41.google.com with SMTP id
 006d021491bc7-5f32f5b0631so3831534eaf.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 11:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736881229; x=1737486029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKCFz+uu23qiBxrqSpXC9+MkA/Y8BAUjLzzQw3XWciY=;
 b=QTu0sXhcQaCO3xQZ6owVnAtGkSef23+JMtELIUjdcnByFhglbSrA+CD4cx7Yqg43kD
 2ki3JMy5W9dEnIT3Wi3nAe+SW4SM6BX6VgkKQDRKc3VI46mg0yLdnN4vVY5oToOWYinX
 yf4dMfFlT5bVAMXGlhC6jgrQa8QKEOQx+l9o+GK0I8XW5CFHTexsbBiB0psmlq09nFNn
 8nDVHYzz0FjyolHHmarUF9+RR1FGyUVqEErRnkgAzgKILDBo0F1SvGpFD7wtoaJ1qI2/
 oI5M3XJ1bdf59BLNvhY51/cNG+srn0Vbf+6qPeKOY+duTJwkiQ9IF7IIWlAwXtju/4x2
 snAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736881229; x=1737486029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKCFz+uu23qiBxrqSpXC9+MkA/Y8BAUjLzzQw3XWciY=;
 b=GGMhhrdJoDabnmB4t5j5I0i7tOWxWpXfbeGejB7hu72yvCOMI8lLt1TkC5lb0PeHof
 B5y8X+cJIKhxY8zJuLflUJR3RKH6KP7DT+qoUux4BqmXFAqXJk4SOBb1ZKHkhMD1PDPP
 AVS3b1U+bRR3+gqUoqGlqRqvxPioyiN5zr6oXhFaRIrghM8S7UXbbo7J+Awi6UK8OONd
 HN/CITqAVAkszp77B2EXsSKRAITk2BaGfPKDvQab0I7l8kv+/Oh6TynstS6FKD8sHFzi
 u9TkD+qiuf9ZuVVPArSIyVN/RE7tuFWUWC3Qy3SKWBS107BjgJOCkpBeWek5PsjaXV4z
 6pjg==
X-Gm-Message-State: AOJu0YxybP9gSuH4Jw0MgLFIc4a1KfjcFMKtbtgXoXPV4LddEnjxlvoh
 Anppib9b3AcwKB0II/83VVXbmiMpDQVpxzyByUzgXHbTRVdhe7fkKuJf5qcasntY8T6gUN09sgf
 AtrWr9A==
X-Gm-Gg: ASbGncsCNEIm3+0ejQ9vQnlHr9B73C+6uf4hnch7SZxD2fjWXyNZ2vnYQiWPXB0NdK4
 mYNI20plXcT/0NU4qQfrRUZ09V9E6sD9hxl9cEaUs1icimvIbMYj0RxcTFAfYa2x1lTuzD4j6+d
 ZTwXOKy59FLjYvB/62Y4itA+IUkN1EJ/L0YwySHcyM5wHNdT4Bc56M3gs7T5SJ4YjE8S7pi9tz4
 JZqBHjkMK/UKz6hrd/uMXgN8ZYvBQBaljmb8lzMDhtRNKQGFeMMGCKh287zO3VVlwKCGBvgHISM
 5/VA8b7BnA==
X-Google-Smtp-Source: AGHT+IG7Am4duzLF6oXhYE2Tn8zsH/ZtR5a5KwTTtDJuF1aC4WTnHtK8KSfglKZE3Eed78rfYu9p5w==
X-Received: by 2002:a05:6820:c8e:b0:5f6:6547:8a0f with SMTP id
 006d021491bc7-5f730929358mr19844057eaf.6.1736881227641; 
 Tue, 14 Jan 2025 11:00:27 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7231855ee1esm4875647a34.32.2025.01.14.11.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 11:00:27 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 4/4] target/riscv: add RVA23S64 profile
Date: Tue, 14 Jan 2025 16:00:01 -0300
Message-ID: <20250114190001.1650942-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
References: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc41.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add RVA23S64 as described in [1]. This profile inherits all mandatory
extensions of RVA23U64, making it a child of the U64 profile.

A new "rva23s64" profile CPU is also added. This is the generated
riscv,isa for it (taken via -M dumpdtb):

rv64imafdcbvh_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_
ziccrse_zicond_zicntr_zicsr_zifencei_zihintntl_zihintpause_zihpm_zimop_
zmmul_za64rs_zaamo_zalrsc_zawrs_zfa_zfhmin_zca_zcb_zcd_zcmop_zba_zbb_zbs_
zkt_zvbb_zve32f_zve32x_zve64f_zve64d_zve64x_zvfhmin_zvkb_zvkt_shcounterenw_
sha_shgatpa_shtvala_shvsatpa_shvstvala_shvstvecd_smnpm_smstateen_ssccptr_
sscofpmf_sscounterenw_ssnpm_ssstateen_sstc_sstvala_sstvecd_ssu64xl_
supm_svade_svinval_svnapot_svpbmt

[1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 53ead481a9..4cfdb74891 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -41,6 +41,7 @@
 #define TYPE_RISCV_CPU_RVA22U64         RISCV_CPU_TYPE_NAME("rva22u64")
 #define TYPE_RISCV_CPU_RVA22S64         RISCV_CPU_TYPE_NAME("rva22s64")
 #define TYPE_RISCV_CPU_RVA23U64         RISCV_CPU_TYPE_NAME("rva23u64")
+#define TYPE_RISCV_CPU_RVA23S64         RISCV_CPU_TYPE_NAME("rva23s64")
 #define TYPE_RISCV_CPU_IBEX             RISCV_CPU_TYPE_NAME("lowrisc-ibex")
 #define TYPE_RISCV_CPU_SHAKTI_C         RISCV_CPU_TYPE_NAME("shakti-c")
 #define TYPE_RISCV_CPU_SIFIVE_E31       RISCV_CPU_TYPE_NAME("sifive-e31")
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 371a7d63fa..9225459bf8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2418,10 +2418,44 @@ static RISCVCPUProfile RVA23U64 = {
     }
 };
 
+/*
+ * As with RVA23U64, RVA23S64 also defines 'named features'.
+ *
+ * Cache related features that we consider enabled since we don't
+ * implement cache: Ssccptr
+ *
+ * Other named features that we already implement: Sstvecd, Sstvala,
+ * Sscounterenw, Ssu64xl
+ *
+ * The remaining features/extensions comes from RVA23U64.
+ */
+static RISCVCPUProfile RVA23S64 = {
+    .parent = &RVA23U64,
+    .name = "rva23s64",
+    .misa_ext = RVS,
+    .priv_spec = PRIV_VERSION_1_13_0,
+    .satp_mode = VM_1_10_SV39,
+    .ext_offsets = {
+        /* These were present in RVA22S64 */
+        CPU_CFG_OFFSET(ext_zifencei), CPU_CFG_OFFSET(ext_svade),
+        CPU_CFG_OFFSET(ext_svpbmt), CPU_CFG_OFFSET(ext_svinval),
+
+        /* New in RVA23S64 */
+        CPU_CFG_OFFSET(ext_svnapot), CPU_CFG_OFFSET(ext_sstc),
+        CPU_CFG_OFFSET(ext_sscofpmf), CPU_CFG_OFFSET(ext_ssnpm),
+
+        /* Named features: Sha */
+        CPU_CFG_OFFSET(ext_sha),
+
+        RISCV_PROFILE_EXT_LIST_END
+    }
+};
+
 RISCVCPUProfile *riscv_profiles[] = {
     &RVA22U64,
     &RVA22S64,
     &RVA23U64,
+    &RVA23S64,
     NULL,
 };
 
@@ -2915,6 +2949,13 @@ static void rva23u64_profile_cpu_init(Object *obj)
 
     RVA23U64.enabled = true;
 }
+
+static void rva23s64_profile_cpu_init(Object *obj)
+{
+    rv64i_bare_cpu_init(obj);
+
+    RVA23S64.enabled = true;
+}
 #endif
 
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
@@ -3195,6 +3236,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  MXL_RV64,  rva23s64_profile_cpu_init),
 #endif /* TARGET_RISCV64 */
 };
 
-- 
2.47.1


