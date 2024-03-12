Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CF3C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2ZO-0002Mt-DJ; Tue, 12 Mar 2024 09:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rk2ZH-0002MI-5S; Tue, 12 Mar 2024 09:53:24 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rk2ZE-0005jq-DC; Tue, 12 Mar 2024 09:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710251600; x=1741787600;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B7hUgrydAGNXirDIBSrhE+PD6xB63EP+VorsUIei5Yk=;
 b=MyUzAbwu35srSZCNygNebjPy/LWvMSJoO7sUWAwDlC681X91AYLzvezO
 6vNQX2IKlUJaWshChoAS5old2ahbKSvvmCFTbnIZH3Xt2dFUmHCu0YL7U
 7VwWCn2te7lt7jYOQsXukRWZBX9Y/Jg8fYZgLxYcF/FJG+Ozi69mxyTp+
 iQbwJLO4C5xwt23rHoG0o921eyJkCcakZivHmwYkaAoRXRETRoqsRO+AS
 u4UvKj2LytyEdGo8zGj7ENjcP9avnJOGtUMxNSejuGoAekszSqc+Oegl1
 fSQ0dqyYl7kOk/0xt6A++2hNNVXKe0GvfGc3uGdW66y+95pbsXad6lbZ7 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4887940"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4887940"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2024 06:53:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; d="scan'208";a="16148592"
Received: from wufei-optiplex-7090.sh.intel.com ([10.239.158.51])
 by fmviesa004.fm.intel.com with ESMTP; 12 Mar 2024 06:53:12 -0700
From: Fei Wu <fei2.wu@intel.com>
To: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com, ved@rivosinc.com,
 sunilvl@ventanamicro.com, haibo1.xu@intel.com, evan.chai@intel.com,
 yin.wang@intel.com, tech-server-platform@lists.riscv.org,
 tech-server-soc@lists.riscv.org, atishp@rivosinc.com,
 ajones@ventanamicro.com, conor@kernel.org,
 heinrich.schuchardt@canonical.com, marcin.juszkiewicz@linaro.org
Cc: Fei Wu <fei2.wu@intel.com>
Subject: [RFC v2 1/2] target/riscv: Add server platform reference cpu
Date: Tue, 12 Mar 2024 21:52:20 +0800
Message-Id: <20240312135222.3187945-2-fei2.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312135222.3187945-1-fei2.wu@intel.com>
References: <20240312135222.3187945-1-fei2.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=fei2.wu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The harts requirements of RISC-V server platform [1] require RVA23 ISA
profile support, plus Sv48, Svadu, H, Sscofmpf etc. This patch provides
a virt CPU type (rvsp-ref) as compliant as possible.

[1] https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_platform_requirements.adoc

Signed-off-by: Fei Wu <fei2.wu@intel.com>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 61 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 3670cfe6d9..adb934d19e 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -49,6 +49,7 @@
 #define TYPE_RISCV_CPU_SIFIVE_U54       RISCV_CPU_TYPE_NAME("sifive-u54")
 #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906")
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
+#define TYPE_RISCV_CPU_RVSP_REF         RISCV_CPU_TYPE_NAME("rvsp-ref")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a48d30828..6685fe0c01 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2312,6 +2312,66 @@ static void rva22s64_profile_cpu_init(Object *obj)
 
     RVA22S64.enabled = true;
 }
+
+static void rv64_rvsp_ref_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+
+    riscv_cpu_set_misa_ext(env, RVG | RVC | RVS | RVU | RVH | RVV);
+
+    /* FIXME: change to 1.13 */
+    env->priv_ver = PRIV_VERSION_1_12_0;
+
+    /* RVA22S64 */
+    cpu->cfg.mmu = true;
+    cpu->cfg.ext_zifencei = true;
+    cpu->cfg.ext_zicsr = true;
+    cpu->cfg.ext_zicntr = true;
+    cpu->cfg.ext_zihpm = true;
+    cpu->cfg.ext_zihintpause = true;
+    cpu->cfg.ext_zba = true;
+    cpu->cfg.ext_zbb = true;
+    cpu->cfg.ext_zbs = true;
+    cpu->cfg.ext_zic64b = true;
+    cpu->cfg.ext_zicbom = true;
+    cpu->cfg.ext_zicbop = true;
+    cpu->cfg.ext_zicboz = true;
+    cpu->cfg.cbom_blocksize = 64;
+    cpu->cfg.cbop_blocksize = 64;
+    cpu->cfg.cboz_blocksize = 64;
+    cpu->cfg.ext_zfhmin = true;
+    cpu->cfg.ext_zkt = true;
+    cpu->cfg.ext_svade = true;
+    cpu->cfg.ext_svpbmt = true;
+    cpu->cfg.ext_svinval = true;
+
+    /* RVA23U64 */
+    cpu->cfg.ext_zvfhmin = true;
+    cpu->cfg.ext_zvbb = true;
+    cpu->cfg.ext_zvkt = true;
+    cpu->cfg.ext_zihintntl = true;
+    cpu->cfg.ext_zicond = true;
+    cpu->cfg.ext_zcb = true;
+    cpu->cfg.ext_zfa = true;
+    cpu->cfg.ext_zawrs = true;
+
+    /* RVA23S64 */
+    cpu->cfg.ext_svnapot = true;
+    cpu->cfg.ext_sstc = true;
+    cpu->cfg.ext_sscofpmf = true;
+    cpu->cfg.ext_smstateen = true;
+
+    cpu->cfg.ext_smaia = true;
+    cpu->cfg.ext_ssaia = true;
+
+    /* Server Platform */
+#ifndef CONFIG_USER_ONLY
+    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
+#endif
+    cpu->cfg.ext_svadu = true;
+    cpu->cfg.ext_zkr = true;
+}
 #endif
 
 static const gchar *riscv_gdb_arch_name(CPUState *cs)
@@ -2577,6 +2637,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_RVSP_REF,   MXL_RV64,  rv64_rvsp_ref_cpu_init),
 #endif
 };
 
-- 
2.34.1


