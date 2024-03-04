Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7665C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5XM-0007OH-Ex; Mon, 04 Mar 2024 05:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rh5XK-0007Nq-2r; Mon, 04 Mar 2024 05:27:10 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>)
 id 1rh5XI-00019m-1u; Mon, 04 Mar 2024 05:27:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709548028; x=1741084028;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HRm/6gAF2k5bRyV7fVse6Rcx6kS/3gMofBT6SVdS6/k=;
 b=KtoUkmvL7sHltAczV8fgU91fLmY/riOQEGBmEz2US61Z3e3t4UUgdWXy
 DpWg4kT5Jore7l7kwpw/kSwPXl+84H23QuilpKhkAGSTgIW975jz8EAYY
 FdNL6Ocvx7RRad8X694pdTAMtkwySeTEfubmeFVDD0922Lv7vpswQAeRP
 jyMI8ba0jfwr7IrzosgMFirKH2C2zN+u31Njf9nLRohk+/ajD5oGgvIFR
 9OhQPC/1SWdH1EEQbQ4OD0CFbWxV1YnAPZZUftDiAHEYktKnn1a78KdsO
 2QY5s9Wl5JVJR4jBIDoh9yzfSqsZT7swHs75RYwXgMS24W5+unSpqCbte A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4194914"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4194914"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2024 02:27:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; d="scan'208";a="13509481"
Received: from wufei-optiplex-7090.sh.intel.com ([10.239.158.51])
 by fmviesa004.fm.intel.com with ESMTP; 04 Mar 2024 02:27:02 -0800
From: Fei Wu <fei2.wu@intel.com>
To: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com, ved@rivosinc.com,
 sunilvl@ventanamicro.com, haibo1.xu@intel.com, evan.chai@intel.com,
 yin.wang@intel.com, tech-server-platform@lists.riscv.org,
 tech-server-soc@lists.riscv.org
Cc: Fei Wu <fei2.wu@intel.com>
Subject: [RFC 2/2] target/riscv: Add server platform reference cpu
Date: Mon,  4 Mar 2024 18:25:40 +0800
Message-Id: <20240304102540.2789225-3-fei2.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304102540.2789225-1-fei2.wu@intel.com>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=fei2.wu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 hw/riscv/server_platform_ref.c |  6 +++-
 target/riscv/cpu-qom.h         |  1 +
 target/riscv/cpu.c             | 62 ++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
index ae90c4b27a..52ec607cee 100644
--- a/hw/riscv/server_platform_ref.c
+++ b/hw/riscv/server_platform_ref.c
@@ -1205,11 +1205,15 @@ static void rvsp_ref_machine_class_init(ObjectClass *oc, void *data)
 {
     char str[128];
     MachineClass *mc = MACHINE_CLASS(oc);
+    static const char * const valid_cpu_types[] = {
+        TYPE_RISCV_CPU_RVSP_REF,
+    };
 
     mc->desc = "RISC-V Server SoC Reference board";
     mc->init = rvsp_ref_machine_init;
     mc->max_cpus = RVSP_CPUS_MAX;
-    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpu_type = TYPE_RISCV_CPU_RVSP_REF;
+    mc->valid_cpu_types = valid_cpu_types;
     mc->pci_allow_0_address = true;
     mc->default_nic = "e1000e";
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
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
index 5ff0192c52..bc91be702b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2282,6 +2282,67 @@ static void rva22s64_profile_cpu_init(Object *obj)
 
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
+    /* RVA22U64 */
+    cpu->cfg.mmu = true;
+    cpu->cfg.ext_zifencei = true;
+    cpu->cfg.ext_zicsr = true;
+    cpu->cfg.ext_zicntr = true;
+    cpu->cfg.ext_zihpm = true;
+    cpu->cfg.ext_zihintpause = true;
+    cpu->cfg.ext_zba = true;
+    cpu->cfg.ext_zbb = true;
+    cpu->cfg.ext_zbs = true;
+    cpu->cfg.zic64b = true;
+    cpu->cfg.ext_zicbom = true;
+    cpu->cfg.ext_zicbop = true;
+    cpu->cfg.ext_zicboz = true;
+    cpu->cfg.cbom_blocksize = 64;
+    cpu->cfg.cbop_blocksize = 64;
+    cpu->cfg.cboz_blocksize = 64;
+    cpu->cfg.ext_zfhmin = true;
+    cpu->cfg.ext_zkt = true;
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
+    cpu->cfg.ext_zifencei = true;
+    cpu->cfg.svade = true;
+    cpu->cfg.ext_svpbmt = true;
+    cpu->cfg.ext_svinval = true;
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
@@ -2547,6 +2608,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_BARE_CPU(TYPE_RISCV_CPU_RV64E,        MXL_RV64,  rv64e_bare_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22U64,  MXL_RV64,  rva22u64_profile_cpu_init),
     DEFINE_PROFILE_CPU(TYPE_RISCV_CPU_RVA22S64,  MXL_RV64,  rva22s64_profile_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_RVSP_REF,   MXL_RV64,  rv64_rvsp_ref_cpu_init),
 #endif
 };
 
-- 
2.34.1


