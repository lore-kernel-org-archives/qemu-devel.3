Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8067CC7EE30
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 03:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUzhe-0005GA-QX; Thu, 26 Jun 2025 23:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uUzhc-0005Eq-77
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:24:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uUzhY-00065V-7N
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 23:24:35 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxPuPoDl5opwgeAQ--.31668S3;
 Fri, 27 Jun 2025 11:24:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxn8XiDl5oz10sAQ--.3598S6;
 Fri, 27 Jun 2025 11:24:24 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v3 4/9] target/loongarch: add msg interrupt CSR registers
Date: Fri, 27 Jun 2025 11:01:33 +0800
Message-Id: <20250627030138.2482055-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250627030138.2482055-1-gaosong@loongson.cn>
References: <20250627030138.2482055-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8XiDl5oz10sAQ--.3598S6
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

include CSR_MSGIS0-3, CSR_MSGIR and CSR_MSGIE.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu-csr.h |  3 +++
 target/loongarch/cpu.c     |  7 +++++++
 target/loongarch/cpu.h     | 10 ++++++++++
 target/loongarch/machine.c | 25 +++++++++++++++++++++++--
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 0834e91f30..4792677086 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -186,6 +186,9 @@ FIELD(CSR_MERRCTL, ISMERR, 0, 1)
 
 #define LOONGARCH_CSR_CTAG           0x98 /* TagLo + TagHi */
 
+#define LOONGARCH_CSR_MSGIS(N)       (0xa0 + N)
+#define LOONGARCH_CSR_MSGIR               0xa4
+
 /* Direct map windows CSRs*/
 #define LOONGARCH_CSR_DMW(N)         (0x180 + N)
 FIELD(CSR_DMW, PLV0, 0, 1)
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index abad84c054..bde9f917fc 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -523,6 +523,13 @@ static void loongarch_la464_initfn(Object *obj)
     env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_WAYS, 7);
     env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
 
+    env->CSR_MSGIS[0] = 0;
+    env->CSR_MSGIS[1] = 0;
+    env->CSR_MSGIS[2] = 0;
+    env->CSR_MSGIS[3] = 0;
+    env->CSR_MSGIR = 0;
+    env->CSR_MSGIE = 0;
+
     loongarch_la464_init_csr(obj);
     loongarch_cpu_post_init(obj);
 }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 56fc4a1459..208d3e0cd3 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -233,6 +233,12 @@ FIELD(TLB_MISC, ASID, 1, 10)
 FIELD(TLB_MISC, VPPN, 13, 35)
 FIELD(TLB_MISC, PS, 48, 6)
 
+/*Msg interrupt registers */
+FIELD(CSR_MSGIS, IS, 0, 63)
+FIELD(CSR_MSGIR, INTNUM, 0, 8)
+FIELD(CSR_MSGIR, ACTIVE, 31, 1)
+FIELD(CSR_MSGIE, PT, 0, 8)
+
 #define LSX_LEN    (128)
 #define LASX_LEN   (256)
 
@@ -350,6 +356,10 @@ typedef struct CPUArchState {
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
+    /* Msg interrupt registers */
+    uint64_t CSR_MSGIS[4];
+    uint64_t CSR_MSGIR;
+    uint64_t CSR_MSGIE;
     struct {
         uint64_t guest_addr;
     } stealtime;
diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
index 4e70f5c879..1e276c08ac 100644
--- a/target/loongarch/machine.c
+++ b/target/loongarch/machine.c
@@ -45,6 +45,26 @@ static const VMStateDescription vmstate_fpu = {
     },
 };
 
+static bool msg_needed(void *opaque)
+{
+    LoongArchCPU *cpu = opaque;
+
+    return FIELD_EX64(cpu->env.cpucfg[1], CPUCFG1, MSG_INT);
+}
+
+static const VMStateDescription vmstate_msg = {
+    .name = "cpu/msg",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = msg_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(env.CSR_MSGIS, LoongArchCPU, 4),
+        VMSTATE_UINT64(env.CSR_MSGIR, LoongArchCPU),
+        VMSTATE_UINT64(env.CSR_MSGIE, LoongArchCPU),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_lsxh_reg = {
     .name = "lsxh_reg",
     .version_id = 1,
@@ -168,8 +188,8 @@ static const VMStateDescription vmstate_tlb = {
 /* LoongArch CPU state */
 const VMStateDescription vmstate_loongarch_cpu = {
     .name = "cpu",
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
         VMSTATE_UINTTL(env.pc, LoongArchCPU),
@@ -245,6 +265,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
         &vmstate_tlb,
 #endif
         &vmstate_lbt,
+        &vmstate_msg,
         NULL
     }
 };
-- 
2.34.1


