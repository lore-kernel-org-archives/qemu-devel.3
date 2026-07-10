Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E117C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 00:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whzSB-0000Ag-Hp; Thu, 09 Jul 2026 20:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whzS9-0000A3-TB
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 20:50:53 -0400
Received: from out-186.mta0.migadu.com ([2001:41d0:1004:224b::ba])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whzS8-0005e8-2d
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 20:50:53 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783644650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17veAsOjpBHNJ3+WJW+uxRGp+1ftuI3Nv8suHg2yNBs=;
 b=FLKMagPVQ/2l3oZFqjLA2oJ5ETi458E1NC8KIfIwm0d70tXBdMwWTzBG+IP/nwiiB6rYIV
 +qgUAF3LmCSvZlV5Lc45nx+SqMQoD17Vn0/cGD+sQ0Vm04v9jLYGVfCHuoeuN5ydJyl8mx
 z4qFjtKeTkg2v1Fg++z5ZcqAupMN6hI=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v2 3/3] target/loongarch: add no_pv_feature compat flag
Date: Fri, 10 Jul 2026 08:50:29 +0800
Message-ID: <20260710005029.345378-4-cui.tao@linux.dev>
In-Reply-To: <20260710005029.345378-1-cui.tao@linux.dev>
References: <20260710005029.345378-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::ba;
 envelope-from=cui.tao@linux.dev; helo=out-186.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Tao Cui <cuitao@kylinos.cn>

Advertising pv features to the guest affects the migration stream. Add a
no_pv_feature compat flag so the behavior can be gated per machine version:
LoongArchCPU gets a bool field, and the virt machine gains a
LoongArchVirtMachineClass field that defaults the CPU flag per version.

kvm_cpu_check_pv_features() skips populating pv features when the flag is
set. The 11.1 machine type keeps pv advertisement off (no_pv_feature is
true, preserving the previous behavior); from the new 11.2 machine type it
is on by default.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 hw/loongarch/virt.c         | 14 +++++++++++++-
 include/hw/loongarch/virt.h |  9 ++++++++-
 target/loongarch/cpu.h      |  1 +
 target/loongarch/kvm/kvm.c  |  5 +++++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 6693dea647..53c84c8def 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -955,6 +955,8 @@ static void virt_init(MachineState *machine)
                          machine->cpu_type);
             exit(EXIT_FAILURE);
         }
+        LOONGARCH_CPU(cpuobj)->no_pv_feature =
+            LOONGARCH_VIRT_MACHINE_GET_CLASS(lvms)->no_pv_feature;
         qdev_realize_and_unref(DEVICE(cpuobj), NULL, &error_fatal);
     }
     virt_check_dmsi(machine);
@@ -1584,6 +1586,7 @@ static const TypeInfo virt_machine_info = {
     .parent         = TYPE_MACHINE,
     .abstract       = true,
     .instance_size  = sizeof(LoongArchVirtMachineState),
+    .class_size     = sizeof(LoongArchVirtMachineClass),
     .class_init     = virt_class_init,
     .instance_init  = virt_initfn,
     .instance_finalize = virt_instance_finalize,
@@ -1601,6 +1604,15 @@ static void machvirt_machine_init(void)
 type_init(machvirt_machine_init);
 
 static void virt_machine_11_1_options(MachineClass *mc)
+{
+    LoongArchVirtMachineClass *vmc = LOONGARCH_VIRT_MACHINE_CLASS(mc);
+
+    /* pv feature advertisement is enabled from 11.2; keep 11.1 unchanged */
+    vmc->no_pv_feature = true;
+}
+DEFINE_VIRT_MACHINE(11, 1)
+
+static void virt_machine_11_2_options(MachineClass *mc)
 {
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 2)
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index d39a9bbf5d..cf8d9e1fd2 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -130,8 +130,15 @@ struct LoongArchVirtMachineState {
     bool highmem_mmio;
 };
 
+struct LoongArchVirtMachineClass {
+    MachineClass parent_obj;
+
+    bool no_pv_feature;   /* compat: 11.1 and older do not advertise pv features */
+};
+
 #define TYPE_LOONGARCH_VIRT_MACHINE  MACHINE_TYPE_NAME("virt")
-OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, LOONGARCH_VIRT_MACHINE)
+OBJECT_DECLARE_TYPE(LoongArchVirtMachineState, LoongArchVirtMachineClass,
+                    LOONGARCH_VIRT_MACHINE)
 void virt_acpi_setup(LoongArchVirtMachineState *lvms);
 void virt_fdt_setup(LoongArchVirtMachineState *lvms);
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index ad30c73167..11bbb5f36e 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -447,6 +447,7 @@ struct ArchCPU {
     OnOffAuto msgint;
     OnOffAuto kvm_pv_ipi;
     OnOffAuto kvm_steal_time;
+    bool no_pv_feature;   /* compat: do not advertise KVM pv features */
     int32_t socket_id;  /* socket-id of this CPU */
     int32_t core_id;    /* core-id of this CPU */
     int32_t thread_id;  /* thread-id of this CPU */
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index c557ee3c3d..878914928b 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -1119,6 +1119,11 @@ static int kvm_cpu_check_pv_features(CPUState *cs, Error **errp)
     CPULoongArchState *env = cpu_env(cs);
     bool kvm_supported;
 
+    /* compat: older machine types do not advertise pv features to the guest */
+    if (cpu->no_pv_feature) {
+        return 0;
+    }
+
     kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PV_IPI);
     if (cpu->kvm_pv_ipi == ON_OFF_AUTO_ON) {
         if (!kvm_supported) {
-- 
2.43.0


