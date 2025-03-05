Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BEDC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpi0D-0000qi-OI; Wed, 05 Mar 2025 01:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tpi0B-0000pa-LS
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:13:07 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tpi05-0004Gy-Sc
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:13:07 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Cxqmpr68dnzN+KAA--.41221S3;
 Wed, 05 Mar 2025 14:12:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBx3MRi68dnfRQ3AA--.5679S11;
 Wed, 05 Mar 2025 14:12:59 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PULL 09/15] hw/loongarch/virt: Add topo properties on CPU object
Date: Wed,  5 Mar 2025 14:12:44 +0800
Message-Id: <20250305061250.1908444-10-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250305061250.1908444-1-maobibo@loongson.cn>
References: <20250305061250.1908444-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx3MRi68dnfRQ3AA--.5679S11
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

Add some properties such as socket_id, core_id, thread_id and node_id
on LoongArch CPU object.

Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 9 +++++++++
 target/loongarch/cpu.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 3788f895c1..df76ab66d5 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -14,6 +14,7 @@
 #include "system/tcg.h"
 #include "system/kvm.h"
 #include "kvm/kvm_loongarch.h"
+#include "hw/qdev-properties.h"
 #include "exec/exec-all.h"
 #include "exec/translation-block.h"
 #include "cpu.h"
@@ -879,6 +880,13 @@ static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
 }
 #endif
 
+static const Property loongarch_cpu_properties[] = {
+    DEFINE_PROP_INT32("socket-id", LoongArchCPU, socket_id, 0),
+    DEFINE_PROP_INT32("core-id", LoongArchCPU, core_id, 0),
+    DEFINE_PROP_INT32("thread-id", LoongArchCPU, thread_id, 0),
+    DEFINE_PROP_INT32("node-id", LoongArchCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
+};
+
 static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 {
     LoongArchCPUClass *lacc = LOONGARCH_CPU_CLASS(c);
@@ -886,6 +894,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     DeviceClass *dc = DEVICE_CLASS(c);
     ResettableClass *rc = RESETTABLE_CLASS(c);
 
+    device_class_set_props(dc, loongarch_cpu_properties);
     device_class_set_parent_realize(dc, loongarch_cpu_realizefn,
                                     &lacc->parent_realize);
     resettable_class_set_parent_phases(rc, NULL, loongarch_cpu_reset_hold, NULL,
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 9dc71fa7f1..677100bd42 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -417,6 +417,10 @@ struct ArchCPU {
     OnOffAuto lasx;
     OnOffAuto kvm_pv_ipi;
     OnOffAuto kvm_steal_time;
+    int32_t socket_id;  /* socket-id of this CPU */
+    int32_t core_id;    /* core-id of this CPU */
+    int32_t thread_id;  /* thread-id of this CPU */
+    int32_t node_id;    /* NUMA node of this CPU */
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
-- 
2.43.5


