Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E40FC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 04:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s75ub-0000bf-2C; Wed, 15 May 2024 00:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s75uM-0000ao-QX
 for qemu-devel@nongnu.org; Wed, 15 May 2024 00:06:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s75uJ-0003ha-6B
 for qemu-devel@nongnu.org; Wed, 15 May 2024 00:06:26 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxV+m0NERmZ+oMAA--.18743S3;
 Wed, 15 May 2024 12:06:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxc1azNERm_nMfAA--.38878S2; 
 Wed, 15 May 2024 12:06:12 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, zhaotianrui@loongson.cn,
 richard.henderson@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
Subject: [RFC PATCH v2] target/loongarch/kvm: Add pmu support
Date: Wed, 15 May 2024 12:06:11 +0800
Message-Id: <20240515040611.998507-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxc1azNERm_nMfAA--.38878S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch adds PMU support, We just sets some cpucfg6 default value
to PMU config on kvm mode, and then check the PMU config with kvm ioctl
KVM_GET_DEVICE_ATTR.
  e.g
    '...  -cpu max,pmu=on' (enable PMU)'
    '...  -cpu max,pmu=off' (disable PMU)'

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
v2:
 - Drop the property 'pmnum'.
 - Link to v1: https://patchew.org/QEMU/20240514094630.988617-1-gaosong@loongson.cn/

This patch adds the 'RFC' heading because it requires
the kernel to merge into patch[1] first

[1]: https://lore.kernel.org/all/20240507120140.3119714-1-gaosong@loongson.cn/

 target/loongarch/cpu.c                | 27 ++++++++++++++
 target/loongarch/kvm/kvm.c            | 53 ++++++++++++++++++++++++++-
 target/loongarch/loongarch-qmp-cmds.c |  2 +-
 3 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index a0cad53676..fde0d2a816 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -421,6 +421,14 @@ static void loongarch_la464_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG5, CC_DIV, 1);
     env->cpucfg[5] = data;
 
+    if (kvm_enabled()) {
+        data = 0;
+        data = FIELD_DP32(data, CPUCFG6, PMP, 1);
+        data = FIELD_DP32(data, CPUCFG6, PMNUM, 3);
+        data = FIELD_DP32(data, CPUCFG6, PMBITS, 63);
+        env->cpucfg[6] = data;
+    }
+
     data = 0;
     data = FIELD_DP32(data, CPUCFG16, L1_IUPRE, 1);
     data = FIELD_DP32(data, CPUCFG16, L1_DPRE, 1);
@@ -643,6 +651,20 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
     }
 }
 
+static bool loongarch_get_pmu(Object *obj, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    return  !!(FIELD_EX32(cpu->env.cpucfg[6], CPUCFG6, PMP));
+}
+
+static void loongarch_set_pmu(Object *obj, bool value,  Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    cpu->env.cpucfg[6] = FIELD_DP32(cpu->env.cpucfg[6], CPUCFG6, PMP, value);
+}
+
 void loongarch_cpu_post_init(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
@@ -655,6 +677,11 @@ void loongarch_cpu_post_init(Object *obj)
         object_property_add_bool(obj, "lasx", loongarch_get_lasx,
                                  loongarch_set_lasx);
     }
+
+    if (kvm_enabled()) {
+        object_property_add_bool(obj, "pmu", loongarch_get_pmu,
+                                 loongarch_set_pmu);
+    }
 }
 
 static void loongarch_cpu_init(Object *obj)
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index bc75552d0f..3e46203b15 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -556,6 +556,51 @@ static int kvm_check_cpucfg2(CPUState *cs)
     return ret;
 }
 
+static int kvm_check_cpucfg6(CPUState *cs)
+{
+    int ret;
+    uint64_t val;
+    struct kvm_device_attr attr = {
+        .group = KVM_LOONGARCH_VCPU_CPUCFG,
+        .attr = 6,
+        .addr = (uint64_t)&val,
+    };
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+
+    ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
+    if (!ret) {
+        kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
+
+        if (FIELD_EX32(env->cpucfg[6], CPUCFG6, PMP)) {
+             /* Check PMP */
+             if (!FIELD_EX32(val, CPUCFG6, PMP)) {
+                 error_report("'pmu' feature not supported by KVM on this host"
+                              " Please disable 'pmu' with "
+                              "'... -cpu XXX,pmu=off ...'\n");
+                 exit(EXIT_FAILURE);
+             }
+             /* Check PMNUM */
+             int guest_pmnum = FIELD_EX32(env->cpucfg[6], CPUCFG6, PMNUM);
+             int host_pmnum = FIELD_EX32(val, CPUCFG6, PMNUM);
+             if (guest_pmnum > host_pmnum){
+                 error_report("The guest pmnum %d larger than KVM support %d\n",
+                              guest_pmnum, host_pmnum);
+                 exit(EXIT_FAILURE);
+             }
+             /* Check PMBITS */
+             int guest_pmbits = FIELD_EX32(env->cpucfg[6], CPUCFG6, PMBITS);
+             int host_pmbits = FIELD_EX32(val, CPUCFG6, PMBITS);
+             if (guest_pmbits != host_pmbits) {
+                 exit_report("The host not support PMBITS %d\n", guest_pmbits);
+                 exit(EXIT_FAILURE);
+             }
+        }
+    }
+
+    return ret;
+}
+
 static int kvm_loongarch_put_cpucfg(CPUState *cs)
 {
     int i, ret = 0;
@@ -568,7 +613,13 @@ static int kvm_loongarch_put_cpucfg(CPUState *cs)
             if (ret) {
                 return ret;
             }
-	}
+        }
+        if (i == 6) {
+            ret = kvm_check_cpucfg6(cs);
+            if (ret) {
+                return ret;
+            }
+        }
         val = env->cpucfg[i];
         ret = kvm_set_one_reg(cs, KVM_IOC_CPUCFG(i), &val);
         if (ret < 0) {
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 8721a5eb13..7e1a6fd734 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -40,7 +40,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 }
 
 static const char *cpu_model_advertised_features[] = {
-    "lsx", "lasx", NULL
+    "lsx", "lasx", "pmu", NULL
 };
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-- 
2.25.1


