Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C00BD10C11
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 12:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5PK5-00086Q-RO; Mon, 28 Oct 2024 08:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t5PK0-00086F-KH
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 08:58:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t5PJy-0007te-A0
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 08:58:12 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxyuBWih9nUhQZAA--.51666S3;
 Mon, 28 Oct 2024 20:57:58 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAx7uBVih9nkcIiAA--.59793S2;
 Mon, 28 Oct 2024 20:57:58 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2] hw/intc/loongarch_ipi: Add safer check about cpu
Date: Mon, 28 Oct 2024 20:57:47 +0800
Message-Id: <20241028125747.2094026-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx7uBVih9nkcIiAA--.59793S2
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

If cpu hotplug is enabled, all possible_cpus is initialized with
arch_id set. For ipi interrupt controller, cpu is searched from
possible_cpus with specified arch_id. However it is possible that
cpu object is not created for offlined cpu.

Here safer check is added. If cpu object is not created, archid->cpu
will be NULL.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
v1 ... v2:
  1. since physical cpuid is the same with cpu_index when cpu_index
     is set again as index of possible_cpus. Remove phy_id set about
     CSR_CPUID in function loongarch_cpu_reset_hold()
---
 hw/intc/loongarch_ipi.c           | 3 ++-
 target/loongarch/tcg/csr_helper.c | 4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 2ae1a42c46..78b6fce81b 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -42,7 +42,8 @@ static CPUState *loongarch_cpu_by_arch_id(int64_t arch_id)
     CPUArchId *archid;
 
     archid = find_cpu_by_archid(machine, arch_id);
-    if (archid) {
+    /* For offlined cpus, archid->cpu may be NULL */
+    if (archid && archid->cpu) {
         return CPU(archid->cpu);
     }
 
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 15f94caefa..2aeca2343d 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -37,10 +37,6 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
 
 target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
 {
-    LoongArchCPU *lac = env_archcpu(env);
-
-    env->CSR_CPUID = CPU(lac)->cpu_index;
-
     return env->CSR_CPUID;
 }
 

base-commit: cea8ac78545a83e1f01c94d89d6f5a3f6b5c05d2
-- 
2.39.3


