Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13666E83EED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 08:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnY5n-0008EA-J1; Wed, 04 Feb 2026 03:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vnY5a-0008Bs-NN
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:18:19 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vnY5W-00031O-Q9
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 03:18:18 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxVcHBAINpwa0PAA--.3660S3;
 Wed, 04 Feb 2026 16:18:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAx38K8AINpop0_AA--.52833S7;
 Wed, 04 Feb 2026 16:18:09 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 5/5] target/loongarch: Add some CPUCFG bits with host CPU
 model
Date: Wed,  4 Feb 2026 16:18:03 +0800
Message-Id: <20260204081803.1414452-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260204081803.1414452-1-maobibo@loongson.cn>
References: <20260204081803.1414452-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx38K8AINpop0_AA--.52833S7
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

Some CPUCFG capability bits depend on KVM host hypervsior and they
are detected on QEMU. However some CPUCFG bits are irrelative with
hypervsior, here these bits are checked from host machine and set
for VM with host CPU model.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 36 +++++++++++++++++++++++++++++++++++-
 target/loongarch/cpu.h | 13 +++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 48fdb63902..9f481da7d1 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -523,7 +523,7 @@ static uint32_t get_host_cpucfg(int number)
 
 static void loongarch_host_initfn(Object *obj)
 {
-    uint32_t data;
+    uint32_t data, cpucfg, field;
     uint64_t cpuid;
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
 
@@ -533,6 +533,40 @@ static void loongarch_host_initfn(Object *obj)
         cpu->env.cpucfg[0] = data;
     }
 
+   /*
+    * There is no exception in KVM hypervisor when these intructions are
+    * executed if HW support, KVM hypervisor cannot control this.
+    *
+    * Set cpucfg bits which cannot be controlled by KVM hypervisor.
+    */
+    data = get_host_cpucfg(2);
+    cpucfg = cpu->env.cpucfg[2];
+    field = FIELD_EX32(data, CPUCFG2, FRECIPE);
+    cpucfg = FIELD_DP32(cpucfg, CPUCFG2, FRECIPE, field);
+    field = FIELD_EX32(data, CPUCFG2, DIV32);
+    cpucfg = FIELD_DP32(cpucfg, CPUCFG2, DIV32, field);
+    field = FIELD_EX32(data, CPUCFG2, LAM_BH);
+    cpucfg = FIELD_DP32(cpucfg, CPUCFG2, LAM_BH, field);
+    field = FIELD_EX32(data, CPUCFG2, LAMCAS);
+    cpucfg = FIELD_DP32(cpucfg, CPUCFG2, LAMCAS, field);
+    field = FIELD_EX32(data, CPUCFG2, LLACQ_SCREL);
+    cpucfg = FIELD_DP32(cpucfg, CPUCFG2, LLACQ_SCREL, field);
+    field = FIELD_EX32(data, CPUCFG2, SCQ);
+    cpucfg = FIELD_DP32(cpucfg, CPUCFG2, SCQ, field);
+    cpu->env.cpucfg[2] = cpucfg;
+
+    data = get_host_cpucfg(3);
+    cpucfg = cpu->env.cpucfg[3];
+    field = FIELD_EX32(data, CPUCFG3, DBAR_HINTS);
+    cpucfg = FIELD_DP32(cpucfg, CPUCFG3, DBAR_HINTS, field);
+    field = FIELD_EX32(data, CPUCFG3, ALDORDER_STA);
+    cpucfg = FIELD_DP32(cpucfg, CPUCFG3, ALDORDER_STA, field);
+    field = FIELD_EX32(data, CPUCFG3, ASTORDER_STA);
+    cpucfg = FIELD_DP32(cpucfg, CPUCFG3, ASTORDER_STA, field);
+    field = FIELD_EX32(data, CPUCFG3, SLDORDER_STA);
+    cpucfg = FIELD_DP32(cpucfg, CPUCFG3, SLDORDER_STA, field);
+    cpu->env.cpucfg[3] = cpucfg;
+
     cpuid = get_host_cpu_model();
     if (cpuid) {
         cpu->env.cpu_id = cpuid;
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 21dc7ecc44..52b9dd0256 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -146,6 +146,12 @@ FIELD(CPUCFG2, LBT_ALL, 18, 3)
 FIELD(CPUCFG2, LSPW, 21, 1)
 FIELD(CPUCFG2, LAM, 22, 1)
 FIELD(CPUCFG2, HPTW, 24, 1)
+FIELD(CPUCFG2, FRECIPE, 25, 1)
+FIELD(CPUCFG2, DIV32, 26, 1)
+FIELD(CPUCFG2, LAM_BH, 27, 1)
+FIELD(CPUCFG2, LAMCAS, 28, 1)
+FIELD(CPUCFG2, LLACQ_SCREL, 29, 1)
+FIELD(CPUCFG2, SCQ, 30, 1)
 
 /* cpucfg[3] bits */
 FIELD(CPUCFG3, CCDMA, 0, 1)
@@ -160,6 +166,13 @@ FIELD(CPUCFG3, SPW_LVL, 8, 3)
 FIELD(CPUCFG3, SPW_HP_HF, 11, 1)
 FIELD(CPUCFG3, RVA, 12, 1)
 FIELD(CPUCFG3, RVAMAX, 13, 4)
+FIELD(CPUCFG3, DBAR_HINTS, 17, 1)
+FIELD(CPUCFG3, ALDORDER_CAP, 18, 1)
+FIELD(CPUCFG3, ASTORDER_CAP, 19, 1)
+FIELD(CPUCFG3, ALDORDER_STA, 20, 1)
+FIELD(CPUCFG3, ASTORDER_STA, 21, 1)
+FIELD(CPUCFG3, SLDORDER_CAP, 22, 1)
+FIELD(CPUCFG3, SLDORDER_STA, 23, 1)
 
 /* cpucfg[4] bits */
 FIELD(CPUCFG4, CC_FREQ, 0, 32)
-- 
2.39.3


