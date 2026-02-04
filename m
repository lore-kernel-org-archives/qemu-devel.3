Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD928E83EE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY5g-0008Ck-1Z; Wed, 04 Feb 2026 03:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vnY5a-0008Bt-Ni
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:18:19 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vnY5W-00031E-Tx
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:18:18 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxWcLAAINpu60PAA--.50767S3;
 Wed, 04 Feb 2026 16:18:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAx38K8AINpop0_AA--.52833S5;
 Wed, 04 Feb 2026 16:18:08 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 3/5] target/loongarch: Add generic CPU model information
Date: Wed,  4 Feb 2026 16:18:01 +0800
Message-Id: <20260204081803.1414452-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260204081803.1414452-1-maobibo@loongson.cn>
References: <20260204081803.1414452-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx38K8AINpop0_AA--.52833S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On LoongArch system, CPU model name comes from IOCSR register
LOONGARCH_IOCSR_VENDOR and LOONGARCH_IOCSR_CPUNAME. Its value
can be initialized when CPU is created.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c    | 6 ++++--
 target/loongarch/cpu.c | 4 ++++
 target/loongarch/cpu.h | 6 ++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index a75968e4c9..0ae049eaa4 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -776,7 +776,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(opaque);
     uint64_t ret = 0;
     int features;
+    CPULoongArchState *env;
 
+    env = &LOONGARCH_CPU(first_cpu)->env;
     switch (addr) {
     case VERSION_REG:
         ret = 0x11ULL;
@@ -791,10 +793,10 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
         }
         break;
     case VENDOR_REG:
-        ret = 0x6e6f73676e6f6f4cULL; /* "Loongson" */
+        ret = env->vendor_id;
         break;
     case CPUNAME_REG:
-        ret = 0x303030354133ULL;     /* "3A5000" */
+        ret = env->cpu_id;
         break;
     case MISC_FUNC_REG:
         if (kvm_irqchip_in_kernel()) {
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index c6787901e2..4ddefae2de 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -287,6 +287,8 @@ static void loongarch_la464_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG0, SERID, PRID_SERIES_LA464);
     data = FIELD_DP32(data, CPUCFG0, VENID, PRID_VENDOR_LOONGSON);
     env->cpucfg[0] = data;
+    memccpy((void *)&env->vendor_id, CPU_VENDOR_LOONGSON, 0, 8);
+    memccpy((void *)&env->cpu_id, CPU_MODEL_3A5000, 0, 8);
 
     data = 0;
     data = FIELD_DP32(data, CPUCFG1, ARCH, 2);
@@ -413,6 +415,8 @@ static void loongarch_la132_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG0, SERID, PRID_SERIES_LA132);
     data = FIELD_DP32(data, CPUCFG0, VENID, PRID_VENDOR_LOONGSON);
     env->cpucfg[0] = data;
+    memccpy((void *)&env->vendor_id, CPU_VENDOR_LOONGSON, 0, 8);
+    memccpy((void *)&env->cpu_id, CPU_MODEL_1C101, 0, 8);
 
     data = 0;
     data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 92122cf101..21dc7ecc44 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -302,6 +302,10 @@ typedef struct  LoongArchBT {
     uint32_t ftop;
 } lbt_t;
 
+#define CPU_VENDOR_LOONGSON   "Loongson"
+#define CPU_MODEL_3A5000      "3A5000"
+#define CPU_MODEL_1C101       "1C101"
+
 typedef struct CPUArchState {
     uint64_t gpr[32];
     uint64_t pc;
@@ -313,6 +317,8 @@ typedef struct CPUArchState {
 
     uint32_t cpucfg[21];
     uint32_t pv_features;
+    uint64_t vendor_id;
+    uint64_t cpu_id;
 
     /* LoongArch CSRs */
     uint64_t CSR_CRMD;
-- 
2.39.3


