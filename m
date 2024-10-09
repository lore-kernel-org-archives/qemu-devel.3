Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9B5CF043B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 03:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syNMj-0002Vm-FI; Tue, 08 Oct 2024 23:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNMe-0002OI-Dn; Tue, 08 Oct 2024 23:27:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1syNMa-00052K-FY; Tue, 08 Oct 2024 23:27:50 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XNdbB21wDz6K6G2;
 Wed,  9 Oct 2024 11:26:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id B215A140114;
 Wed,  9 Oct 2024 11:27:46 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.126.173.89) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 05:27:27 +0200
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <gshan@redhat.com>, <rafael@kernel.org>, <borntraeger@linux.ibm.com>,
 <alex.bennee@linaro.org>, <npiggin@gmail.com>, <harshpb@linux.ibm.com>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH RFC V4 25/33] target/arm/cpu: Check if hotplugged ARM vCPU's
 FEAT match existing
Date: Wed, 9 Oct 2024 04:18:07 +0100
Message-ID: <20241009031815.250096-26-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009031815.250096-1-salil.mehta@huawei.com>
References: <20241009031815.250096-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.173.89]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The ARM extensions configuration *must* match the existing vCPUs already
initialized in KVM at VM initialization. ARM does not allow any per-vCPU
features to be changed once the system has fully initialized. This is an
immutable constraint of the ARM CPU architecture.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 target/arm/cpu.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3de0cb346b..14fcabc2c9 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1912,6 +1912,49 @@ static void arm_cpu_finalizefn(Object *obj)
 #endif
 }
 
+static void arm_cpu_check_features_change(ARMCPU *cpu, Error **errp)
+{
+#if defined(TARGET_AARCH64) && !defined(CONFIG_USER_ONLY)
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    ARMCPU *firstcpu = ARM_CPU(first_cpu);
+    DeviceState *dev = DEVICE(cpu);
+
+    if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+        return;
+    }
+
+    /* For now, features of hotplugged CPU MUST match earlier booted CPUs */
+    if (!dev->hotplugged || !mc->has_hotpluggable_cpus) {
+        return;
+    }
+
+    if (cpu_isar_feature(aa64_sve, cpu) &&
+        (cpu->sve_max_vq != firstcpu->sve_max_vq ||
+         cpu->sve_vq.map != firstcpu->sve_vq.map)) {
+        error_setg(errp,
+                   "CPU %d: 'SVE' feature didn't match with existing CPUs",
+                   CPU(cpu)->cpu_index);
+        return;
+    }
+
+    if (cpu_isar_feature(aa64_sme, cpu) &&
+        (cpu->sme_vq.map != firstcpu->sme_vq.map)) {
+        error_setg(errp,
+                   "CPU %d: 'SME' feature didn't match with exisitng CPUs",
+                   CPU(cpu)->cpu_index);
+        return;
+    }
+
+    if (cpu_isar_feature(aa64_pauth, cpu) &&
+        (cpu->prop_pauth != firstcpu->prop_pauth)) {
+        error_setg(errp,
+                   "CPU %d: 'PAuth' feature didn't match with exisitng CPUs",
+                   CPU(cpu)->cpu_index);
+        return;
+    }
+#endif
+}
+
 void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
 {
     Error *local_err = NULL;
@@ -1961,6 +2004,13 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
     }
+
+    /*
+     * As of now, we do not support heterogeneous computing, hence, features of
+     * all cpus should match. Hotplugged vCPUs are not allowed to have
+     * different features than the existing cold-plugged vCPUs
+     */
+    arm_cpu_check_features_change(cpu, &local_err);
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.34.1


