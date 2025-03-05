Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7A0C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxW-0002RA-Jk; Tue, 04 Mar 2025 20:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxU-0002JA-NA
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:04 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxS-0008Ri-UN
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:04 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22382657540so72560605ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139641; x=1741744441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3gwT/mHctmBjF+WNI/x5iyqj1CcCUESDeIppQlEyHlo=;
 b=BYkejdQKYEXOd/RkYb1VlVNSsjS0MOQUdZbI4LOe3dces3phgvtqqyHtBnW1YoSLXG
 2WoqZqO7O+aNvrWYND2detg6P2k29MLJJ+4DL6NvBOodZJdeAMN8arifsA/kLVt1PGKr
 74NhOLwRQhGBcU+ESNIdG8oV/oqmBb4ws90+gPsqYNtfCDwhDV7gwvpXrqZ9Aq1rmGx9
 q1nH+VwFeDHvDekV6MbvoPNfEeWVpfEP9s2TMBw9TsdkFnCYfyrCZviDZy3E5/uG/INI
 idNX2S7OH/4uhxtO+bhJs1jBhqZf+R7qd3ECmAkxP64ubbDmZ3FvA+omsmiaf/KNTlKN
 Q19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139641; x=1741744441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gwT/mHctmBjF+WNI/x5iyqj1CcCUESDeIppQlEyHlo=;
 b=KeIqT0kaqgubZOQqfQ1eRni6z/4ZmB/ov6JzMlZnKivI9OvTFko2GCTE9IucuTFKUl
 vcXfO4Eu2revgW1rmizWtT5rJ1ryaVtWn4b4+mW2DS+dtAOqyeKmFjV7zjzBLzIxi2bP
 kN1cwwF2V8nWJFP4qrV3oG4C9P/S8iRoNZChH0H5zrP6BIiQW47e+unM8nKylSKlKRoB
 GUA2f4dNZjNfnAB39hJmxcb6XOd/UGa5GucFxCaxFVzxHQzwAR+gtFTmu+GcEyccaow9
 rFlWeVO1dK/uOWz1r1UgGvIGXYrnFY2VRh7wc0i4DZfK10bC7EICvKjga9eTl43W1+X4
 hb6g==
X-Gm-Message-State: AOJu0YxRc474lC5kXH+wRdCtbIZIfv9Ht23KWo18wpC7yAGuELUgIe5V
 cJtDEaz3Rgfkr4iejeaAWA4A//3ycSGHUR6n6xMdWdYm7Zq+IJUMCf+orYJVSLU=
X-Gm-Gg: ASbGncv84lxVvua5Q4Hrb1LukjUfq4a65xk+NDn7S14ruhwPajyENOsSk+buk9A2igk
 MvOzXGzBpEB/HcfZGLRTpmCqWgxlDqehF84Tp6hF8ZpyPzb/8q0e59Unu/T/bVOPjZDAOzIShLN
 XLxHNTPNpeWj1P+hw6Hc9KFKniobyyuTcrw1BbK5LpXY1bSrl1ahnOApwTFxX37qMfh3HqNFpZF
 jPSFU1ipmBh6xOBZm39HcZNfbGImmVGt1d9YdQO8oxav+30kcz3mPowXVys0qrf2J7YOYO7/X3n
 su7jVq2aOAgxMvqpuxhzc6nViO+ae6/nOS1RfEDZ0qJvAVbpAxd62xDFZXxBBAX2+y7T/kJ2rsV
 6XoGvBz6DYSLJtT5h7m1me0M2o4rmzWe7vMyHcy8YoKKctkaYuBk=
X-Google-Smtp-Source: AGHT+IEnol7siEUTSQki6ybi0P6NZ4StvYPYYiQTCXiiG44Hiqv4NM0qDZAOffNbQ66TbSsHAEsXuw==
X-Received: by 2002:a17:902:da88:b0:220:d532:834e with SMTP id
 d9443c01a7336-223f1c829ffmr17552245ad.19.1741139641375; 
 Tue, 04 Mar 2025 17:54:01 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:00 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 16/59] target/riscv: add RVA23S64 profile
Date: Wed,  5 Mar 2025 11:52:24 +1000
Message-ID: <20250305015307.1463560-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

Add RVA23S64 as described in [1]. This profile inherits all mandatory
extensions of RVA23U64 and RVA22S64, making it a child of both profiles.

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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250115184316.2344583-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

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
index 511ed1df0e..3624ffb6d9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2415,10 +2415,41 @@ static RISCVCPUProfile RVA23U64 = {
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
+ * The remaining features/extensions comes from RVA23S64.
+ */
+static RISCVCPUProfile RVA23S64 = {
+    .u_parent = &RVA23U64,
+    .s_parent = &RVA22S64,
+    .name = "rva23s64",
+    .misa_ext = RVS,
+    .priv_spec = PRIV_VERSION_1_13_0,
+    .satp_mode = VM_1_10_SV39,
+    .ext_offsets = {
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
 
@@ -2912,6 +2943,13 @@ static void rva23u64_profile_cpu_init(Object *obj)
 
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
@@ -3183,6 +3221,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  MXL_RV64,  rva23s64_profile_cpu_init),
 #endif /* TARGET_RISCV64 */
 };
 
-- 
2.48.1


