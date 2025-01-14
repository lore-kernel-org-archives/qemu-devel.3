Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64383C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 13:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXgqY-0008PN-PQ; Tue, 14 Jan 2025 08:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXgqX-0008Oy-C5
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:20:41 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tXgqV-0003w9-8I
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 08:20:40 -0500
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-3ebbec36900so2868848b6e.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736860836; x=1737465636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aTyPIerGUIEfsS1Bk4TYFsywTIjidQ+fbn9jtfE2APQ=;
 b=I6LdVTGCtkg7MpfvXu9K2E2TD5N9FTlAoqxbGS+RnVo6m8p24KF/AOC/3bEcAlVm7O
 ek1Njo1KGkW/g/0MEPF2JjokQzGA158LuRU80MgSSe9YjTQdvbS2Ihszzhx5XYPxNM/B
 LqpEFPJVOxgLg6tkSLyl91ui0I0ueIaCh9GHgTPPshlkMGtIHFIh1QvYmjQZLCLWNrTT
 VpWP42PdsNlw41AGIF81Dl3p9Qx1DdnoKJ+cVrls5QsAfTtsGqd6ANxReyaTsAbZFR8I
 BRjrC+Amz6/FZQ6NhQrI5O+j1PtsomIq/ak1AogXax41CCkn/xeaWO/Ga51MRdybYcHs
 vXig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736860836; x=1737465636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTyPIerGUIEfsS1Bk4TYFsywTIjidQ+fbn9jtfE2APQ=;
 b=mWOyuyGo1eVXE8jbumbw4zNBN7YKq8gRNtaTmXLYKJcgDGms1JAF1OTbYNYGmspyvV
 34yyySym+5Z4vT/U4pMjePtb91th7e0RL3qNAtBNdthU6Hu5KyewP0oGkxQXFmgprufJ
 +KOSGEQl/69uyW1tcGSoIwjOnSIHTnLmb/dHmjvP+P1LtBdRIdhoXySlyDuP8jT5y9rb
 c82TwugSpMqJJ+Svpbh4oKlLSteGma/41yxDizyh4quYOUnspU6RAU/kOLkx1dvPsKIa
 EkiIZ41ElYW/fR42uNTx65EabCU0IZo1d9bNPaR1adpW4Qml6Lkxzk5hz8RiTcMWOQOK
 z4HQ==
X-Gm-Message-State: AOJu0Yyf3hmBUigS0muhQWhMC5hyTHdzuJnRg3+90cSxzbWTx1vN7t2x
 lmKoo1bXMrpi8FNsckcFcbpVBSaOaHfJCycltjPlH1/UjWXHZwOGhu96CZJuD8XClfCEKTkoXmd
 dqxKl4A==
X-Gm-Gg: ASbGncsMTaKJ336z1+29G/gnNPMP8GGAHzRRGLGJfz0GJyholmwDuR44b+L4f72J4w8
 BWY5dJ5rjQoI8kpMSkS1HrjCTL97q3eJ2l68NSBi02acpRwPr3NAHcU3kdV6UeuTGnMai0/cWPu
 +GSqYu4Sno72izBJ9tHG5nd81wvPc46Bgu5AG7DBSxL31AVPzRmbfvvX8QQkIdqvgm+NBZv+eIK
 0ikJzC5a+nKBerRki90PCxGd/Gmk75PHnrsX01/Zr1WM6rqZ+oNhb8RZv7h8eAaeEs2+wfzOEVA
 ThbrPhRdgQ==
X-Google-Smtp-Source: AGHT+IED66TTs3EzlGgM4Xe2jAN5WtfwfiZxkyUanhRxparGyiqo1UD0l7+4ag4pbaKRPwdpyjnIsQ==
X-Received: by 2002:a05:6870:718d:b0:29e:8068:e089 with SMTP id
 586e51a60fabf-2aa0670be27mr15035250fac.19.1736860835153; 
 Tue, 14 Jan 2025 05:20:35 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([189.110.107.205])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ad809b10e4sm5052411fac.35.2025.01.14.05.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 05:20:33 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 4/4] target/riscv: add RVA23S64 profile
Date: Tue, 14 Jan 2025 10:20:12 -0300
Message-ID: <20250114132012.1224941-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114132012.1224941-1-dbarboza@ventanamicro.com>
References: <20250114132012.1224941-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x244.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
ziccrse_zicond_zicntr_zicsr_zihintntl_zihintpause_zihpm_zimop_zmmul_
za64rs_zaamo_zalrsc_zawrs_zfa_zfhmin_zca_zcb_zcd_zcmop_zba_zbb_zbs_zkt_
zvbb_zve32f_zve32x_zve64f_zve64d_zve64x_zvfhmin_zvkb_zvkt_shcounterenw_
sha_shgatpa_shtvala_shvsatpa_shvstvala_shvstvecd_smnpm_smstateen_ssccptr_
sscofpmf_sscounterenw_ssnpm_ssstateen_sstc_sstvala_sstvecd_ssu64xl_
supm_svade_svinval_svnapot_svpbmt

[1] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 43 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

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
index e10ecc4ece..14af141349 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2419,10 +2419,45 @@ static RISCVCPUProfile RVA23U64 = {
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
+        CPU_CFG_OFFSET(ext_svade), CPU_CFG_OFFSET(ext_svpbmt),
+        CPU_CFG_OFFSET(ext_svinval),
+
+        /* New in RVA23S64 */
+        CPU_CFG_OFFSET(ext_svnapot), CPU_CFG_OFFSET(ext_sstc),
+        CPU_CFG_OFFSET(ext_sscofpmf),
+
+        /* Named features: Sha, ssu64xl, ssnpm */
+        CPU_CFG_OFFSET(ext_sha),
+        CPU_CFG_OFFSET(ext_ssnpm),
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
 
@@ -2916,6 +2951,13 @@ static void rva23u64_profile_cpu_init(Object *obj)
 
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
@@ -3196,6 +3238,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  MXL_RV64,  rva23s64_profile_cpu_init),
 #endif /* TARGET_RISCV64 */
 };
 
-- 
2.47.1


