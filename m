Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D6BCA101F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 07:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy3Vh-0002Ki-LS; Mon, 15 Sep 2025 03:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uy3Ve-0002Jv-HN
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 03:20:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uy3VH-0000KR-OG
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 03:20:22 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxHvATvsdo7mwKAA--.22343S3;
 Mon, 15 Sep 2025 15:19:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJAxVOQSvsdoXteWAA--.24724S3;
 Mon, 15 Sep 2025 15:19:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/8] target/loongarch: Add phys_bits in CPULoongArchState
Date: Mon, 15 Sep 2025 15:19:39 +0800
Message-Id: <20250915071946.315171-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250915071946.315171-1-maobibo@loongson.cn>
References: <20250915071946.315171-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxVOQSvsdoXteWAA--.24724S3
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

Add field phys_bits in structure CPULoongArchState, to record max
supported physical address bits.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 13 +++++++------
 target/loongarch/cpu.h |  2 ++
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 55ee317bf2..f36a716282 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -517,7 +517,7 @@ static void loongarch_la464_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
     CPULoongArchState *env = &cpu->env;
-    uint32_t data = 0, field;
+    uint32_t data = 0;
     int i;
 
     for (i = 0; i < 21; i++) {
@@ -531,12 +531,12 @@ static void loongarch_la464_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG1, PGMMU, 1);
     data = FIELD_DP32(data, CPUCFG1, IOCSR, 1);
     if (kvm_enabled()) {
-        /* GPA address width of VM is 47, field value is 47 - 1 */
-        field = 0x2e;
+        /* GPA address width of VM is 47 */
+        env->phys_bits = 47;
     } else {
-        field = 0x2f; /* 48 bit - 1 */
+        env->phys_bits = 48;
     }
-    data = FIELD_DP32(data, CPUCFG1, PALEN, field);
+    data = FIELD_DP32(data, CPUCFG1, PALEN, env->phys_bits - 1);
     data = FIELD_DP32(data, CPUCFG1, VALEN, 0x2f);
     data = FIELD_DP32(data, CPUCFG1, UAL, 1);
     data = FIELD_DP32(data, CPUCFG1, RI, 1);
@@ -632,10 +632,11 @@ static void loongarch_la132_initfn(Object *obj)
     cpu->dtb_compatible = "loongarch,Loongson-1C103";
     env->cpucfg[0] = 0x148042;  /* PRID */
 
+    env->phys_bits = 32;
     data = FIELD_DP32(data, CPUCFG1, ARCH, 1); /* LA32 */
     data = FIELD_DP32(data, CPUCFG1, PGMMU, 1);
     data = FIELD_DP32(data, CPUCFG1, IOCSR, 1);
-    data = FIELD_DP32(data, CPUCFG1, PALEN, 0x1f); /* 32 bits */
+    data = FIELD_DP32(data, CPUCFG1, PALEN, env->phys_bits - 1); /* 32 bits */
     data = FIELD_DP32(data, CPUCFG1, VALEN, 0x1f); /* 32 bits */
     data = FIELD_DP32(data, CPUCFG1, UAL, 1);
     data = FIELD_DP32(data, CPUCFG1, RI, 0);
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 7731f6acdc..03433eb0de 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -390,6 +390,8 @@ typedef struct CPUArchState {
     bool load_elf;
     uint64_t elf_address;
     uint32_t mp_state;
+    /* Number of physical address bits supported */
+    uint32_t phys_bits;
 
     struct loongarch_boot_info *boot_info;
 #endif
-- 
2.39.3


