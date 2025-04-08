Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E11BC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 02:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1ybI-0006if-Vy; Mon, 07 Apr 2025 22:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huangborong@bosc.ac.cn>)
 id 1u1ybF-0006hw-DK; Mon, 07 Apr 2025 22:22:05 -0400
Received: from out28-4.mail.aliyun.com ([115.124.28.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <huangborong@bosc.ac.cn>)
 id 1u1ybB-0006Rc-U7; Mon, 07 Apr 2025 22:22:04 -0400
Received: from DESKTOP-MLVKPO8.(mailfrom:huangborong@bosc.ac.cn
 fp:SMTPD_---.cGQC2OD_1744078906 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 08 Apr 2025 10:21:54 +0800
From: Huang Borong <huangborong@bosc.ac.cn>
To: qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 qemu-devel@nongnu.org, wangran@bosc.ac.cn,
 Huang Borong <huangborong@bosc.ac.cn>
Subject: [PATCH v3 1/2] target/riscv: Add BOSC's Xiangshan Kunminghu CPU
Date: Tue,  8 Apr 2025 10:21:21 +0800
Message-Id: <20250408022121.173531-1-huangborong@bosc.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.4; envelope-from=huangborong@bosc.ac.cn;
 helo=out28-4.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Add a CPU entry for the Xiangshan Kunminghu CPU, an open-source,
high-performance RISC-V processor. More details can be found at:
https://github.com/OpenXiangShan/XiangShan

Note: The ISA extensions supported by the Xiangshan Kunminghu CPU are
categorized based on four RISC-V specifications: Volume I: Unprivileged
Architecture, Volume II: Privileged Architecture, AIA, and RVA23. The
extensions within each category are organized according to the chapter
order in the specifications.

Signed-off-by: Yu Hu <huyu@bosc.ac.cn>
Signed-off-by: Ran Wang <wangran@bosc.ac.cn>
Signed-off-by: Borong Huang <huangborong@bosc.ac.cn>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 72 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 4cfdb74891..f2908939e7 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -53,6 +53,7 @@
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon")
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
+#define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 09ded6829a..a076d9dc0c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -697,6 +697,76 @@ static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
 #endif
 }
 
+static void rv64_xiangshan_kmh_cpu_init(Object *obj)
+{
+    CPURISCVState *env = &RISCV_CPU(obj)->env;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+
+    riscv_cpu_set_misa_ext(env, RVG | RVC | RVB | RVS | RVU | RVH | RVV);
+    env->priv_ver = PRIV_VERSION_1_13_0;
+
+    /* Enable ISA extensions */
+    cpu->cfg.mmu = true;
+    cpu->cfg.pmp = true;
+
+    /*
+     * The RISC-V Instruction Set Manual: Volume I
+     * Unprivileged Architecture
+     */
+    cpu->cfg.ext_zicntr = true;
+    cpu->cfg.ext_zihpm = true;
+    cpu->cfg.ext_zihintntl = true;
+    cpu->cfg.ext_zihintpause = true;
+    cpu->cfg.ext_zimop = true;
+    cpu->cfg.ext_zcmop = true;
+    cpu->cfg.ext_zicond = true;
+    cpu->cfg.ext_zawrs = true;
+    cpu->cfg.ext_zacas = true;
+    cpu->cfg.ext_zfh = true;
+    cpu->cfg.ext_zfa = true;
+    cpu->cfg.ext_zcb = true;
+    cpu->cfg.ext_zbc = true;
+    cpu->cfg.ext_zvfh = true;
+    cpu->cfg.ext_zkn = true;
+    cpu->cfg.ext_zks = true;
+    cpu->cfg.ext_zkt = true;
+    cpu->cfg.ext_zvbb = true;
+    cpu->cfg.ext_zvkt = true;
+
+    /*
+     * The RISC-V Instruction Set Manual: Volume II
+     * Privileged Architecture
+     */
+    cpu->cfg.ext_smstateen = true;
+    cpu->cfg.ext_smcsrind = true;
+    cpu->cfg.ext_sscsrind = true;
+    cpu->cfg.ext_svnapot = true;
+    cpu->cfg.ext_svpbmt = true;
+    cpu->cfg.ext_svinval = true;
+    cpu->cfg.ext_sstc = true;
+    cpu->cfg.ext_sscofpmf = true;
+    cpu->cfg.ext_ssdbltrp = true;
+    cpu->cfg.ext_ssnpm = true;
+    cpu->cfg.ext_smnpm = true;
+    cpu->cfg.ext_smmpm = true;
+    cpu->cfg.ext_sspm = true;
+    cpu->cfg.ext_supm = true;
+
+    /* The RISC-V Advanced Interrupt Architecture */
+    cpu->cfg.ext_smaia = true;
+    cpu->cfg.ext_ssaia = true;
+
+    /* RVA23 Profiles */
+    cpu->cfg.ext_zicbom = true;
+    cpu->cfg.ext_zicbop = true;
+    cpu->cfg.ext_zicboz = true;
+    cpu->cfg.ext_svade = true;
+
+#ifndef CONFIG_USER_ONLY
+    set_satp_mode_max_supported(cpu, VM_1_10_SV48);
+#endif
+}
+
 #ifdef CONFIG_TCG
 static void rv128_base_cpu_init(Object *obj)
 {
@@ -3261,6 +3331,8 @@ static const TypeInfo riscv_cpu_type_infos[] = {
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_v1_cpu_init),
     DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU,
                                                  MXL_RV64, rv64_xiangshan_nanhu_cpu_init),
+    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_KMH,
+                                                 MXL_RV64,  rv64_xiangshan_kmh_cpu_init),
 #ifdef CONFIG_TCG
     DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_cpu_init),
 #endif /* CONFIG_TCG */
-- 
2.34.1


