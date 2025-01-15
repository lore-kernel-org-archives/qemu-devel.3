Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CF8C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 13:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY3n6-00065c-BH; Wed, 15 Jan 2025 08:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY3n2-00063w-L6
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:37 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY3n0-0007tS-Tz
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 08:50:36 -0500
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-3eba5848ee4so1784214b6e.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 05:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736949033; x=1737553833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNweTshZFgKWk8rKIiPuDmmq9oD0ful1jcMYNBMGKvA=;
 b=U1+SCdPzN92ZvuOC8ASMvAg7jkUP5vK0sB2dsZMvijUz0HP7FNvCBn3pu9cAilYSGc
 7F4Zk7jfzZaSSXCdh4OpYPB4HqpYiqL1LUDHkbhG9wkPD3pHWiZg7IIuxAmDE0ynezkT
 aPyJNgRx5czk/TKtyhfovEDXUJNI4S9w1g4olfzbIz1Q8OcwkC55Lslb6VhX4Oq2U0gB
 xXVLf0T65E3CF8F/SCb44IpF8F2UBRv92BCJEEb00aXiqJFJdjgywThzfEsmD6Jwq1Bv
 7Ypq5YlyusST9NkmjYRzgRcIF5OWEAqOpPcXJf9uillUYh/PTNQv5Cg5Xs2io2P+VZyD
 XBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736949033; x=1737553833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNweTshZFgKWk8rKIiPuDmmq9oD0ful1jcMYNBMGKvA=;
 b=HYbv0+HYYf2+HArDGe+2JB5JfH7gyD45S9F4IdugQUXbQICKX0OrIRwxu/icoDNOCx
 rWkdQuioHpbwHhSFY+toOcARvGzlguLTXlRf1dbiJCMjQgCKUj3H5wwbQ9WEkQurdpsX
 bMe7LqqdTHIDwpGOe1W732OPvDdDn6tN0HWfUcrjB26hRiY+v52h1cgq3tDNRL9HJ158
 wU7ZucX6Ble68RjGVMSxBf236QzAxeWxoucXlo5aZPWPXzVH1cro6kLRkwQ9tgcEXlQc
 ocrT2I842HjbrpV1bayPw0CyzHLxDe7QpYI7KG8RrbVkuraQO1cBVfX1ErQNlbgz0+kb
 hHMw==
X-Gm-Message-State: AOJu0Ywx7kd02JkVMr/6vdsuxq7VfNd+qczHWd71eePI+2MtunSl/0Be
 SM0d5FGABqQouRoVoz9BXwR+vuJJVxZfZ/M+2/Kq8ZNwtgucrplL7nZAfRdL10I4oo0LGyRgGT5
 ABOpD7w==
X-Gm-Gg: ASbGncs4Th/YK5VOed7BYc8ExEcyCyti5+nDIO+CL5AEpOVhTqgItN3aKDEG8a6DQR7
 IljeATnfioHVHAuZ1sOSGdsnXbdQ7R78o3u/ZfNxLDJhCaD2JaEaunqSNAmNZW1DHtGwJCS0m9Z
 HxDwRch3VaA3TdykcFafWiu1TbviUWDXU+9CkD6IeumGaVzOSRobQHMa+6foYf4id/Mzikq8Myo
 cBn3kNnlaKB+IftDOO2Tt9ISek87tLB12d1aY+7p53bh1XXt2mcg6nHpns=
X-Google-Smtp-Source: AGHT+IHy+H/gPhjCG043RtLz2g8d3phatJF0cSNze7FpoZXnlrbZ7N4SHWX9jPw70dl0ZIL21GGttw==
X-Received: by 2002:a05:6808:1808:b0:3eb:5160:f859 with SMTP id
 5614622812f47-3ef2ebb9771mr20358012b6e.9.1736949033535; 
 Wed, 15 Jan 2025 05:50:33 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f0379eff69sm4952177b6e.41.2025.01.15.05.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:50:32 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 6/6] target/riscv: add RVA23S64 profile
Date: Wed, 15 Jan 2025 10:49:57 -0300
Message-ID: <20250115134957.2179085-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115134957.2179085-1-dbarboza@ventanamicro.com>
References: <20250115134957.2179085-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x242.google.com
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
index 761da41e53..50e65932f6 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2421,10 +2421,41 @@ static RISCVCPUProfile RVA23U64 = {
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
 
@@ -2918,6 +2949,13 @@ static void rva23u64_profile_cpu_init(Object *obj)
 
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
@@ -3198,6 +3236,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23U64,  MXL_RV64,  rva23u64_profile_cpu_init),
+    DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA23S64,  MXL_RV64,  rva23s64_profile_cpu_init),
 #endif /* TARGET_RISCV64 */
 };
 
-- 
2.47.1


