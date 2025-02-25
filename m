Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820C4C021BC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 12:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmtcy-0003w5-Mv; Tue, 25 Feb 2025 07:01:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tmtcP-0003jn-B3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:01:02 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tmtcJ-0006Vy-4D
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 07:00:56 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxTWvwsL1nPxaCAA--.26396S3;
 Tue, 25 Feb 2025 20:00:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxLsfpsL1n2uMnAA--.19507S13;
 Tue, 25 Feb 2025 20:00:47 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 11/11] target/loongarch: Enable virtual extioi feature
Date: Tue, 25 Feb 2025 20:00:41 +0800
Message-Id: <20250225120041.1652869-12-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250225120041.1652869-1-maobibo@loongson.cn>
References: <20250225120041.1652869-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsfpsL1n2uMnAA--.19507S13
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Feature virtual extioi is loongArch virt machine property rather than
vCPU property in qemu side. However it is vCPU property in KVM kernel
side, here add loongArch virt machine property checking and enable virt
extioi feature when vCPU is created.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c         |  8 --------
 include/hw/loongarch/virt.h |  9 +++++++++
 target/loongarch/kvm/kvm.c  | 10 ++++++++++
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index f2aa0a9782..59533b058b 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -45,14 +45,6 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "qemu/error-report.h"
 
-static bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
-{
-    if (lvms->veiointc == ON_OFF_AUTO_OFF) {
-        return false;
-    }
-    return true;
-}
-
 static void virt_get_veiointc(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 661efae61d..2e7cdfaef0 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -68,4 +68,13 @@ struct LoongArchVirtMachineState {
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
 void virt_acpi_setup(LoongArchVirtMachineState *lvms);
 void virt_fdt_setup(LoongArchVirtMachineState *lvms);
+
+static inline bool virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
+{
+    if (lvms->veiointc == ON_OFF_AUTO_OFF) {
+        return false;
+    }
+    return true;
+}
+
 #endif
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 59a5f84161..28735c80be 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -21,6 +21,7 @@
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "hw/irq.h"
+#include "hw/loongarch/virt.h"
 #include "qemu/log.h"
 #include "hw/loader.h"
 #include "system/runstate.h"
@@ -1030,6 +1031,7 @@ static int kvm_cpu_check_pmu(CPUState *cs, Error **errp)
 
 static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
 {
+    MachineState *ms = MACHINE(qdev_get_machine());
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     CPULoongArchState *env = cpu_env(cs);
     bool kvm_supported;
@@ -1062,6 +1064,14 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
         env->pv_features |= BIT(KVM_FEATURE_STEAL_TIME);
     }
 
+    if (object_dynamic_cast(OBJECT(ms), TYPE_LOONGARCH_VIRT_MACHINE)) {
+        LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
+
+        if (virt_is_veiointc_enabled(lvms)) {
+            env->pv_features |= BIT(KVM_FEATURE_VIRT_EXTIOI);
+        }
+    }
+
     return 0;
 }
 
-- 
2.43.5


