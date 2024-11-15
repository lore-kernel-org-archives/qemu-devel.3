Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27641D68BCE
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC04y-0004Kg-LR; Fri, 15 Nov 2024 12:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04m-0004CK-SG
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC04j-0001Wz-QS
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731691541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cCMxcEMzK+ORsvpYHHKKb5uHv0ldXCf9Z/VSowzif5A=;
 b=P+CVVDKu4MKaMIabl7IVrC6DnbVNL2HFDdAVTXKdovrjwg/sDgHXwtcMOw9I5GDtaEe6lo
 GkiXnr9tgDfS4F+iF7pctOgUNvYIWMnLQN9PO7vc0S+TRBhqAX1Zq8DD3Eep6zTwFkcP8K
 3XyrZ0TPb9t6X1fXcvyGkk6mTAYwj0k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-6SDcBpvVM-qenZQMLsakHQ-1; Fri,
 15 Nov 2024 12:25:38 -0500
X-MC-Unique: 6SDcBpvVM-qenZQMLsakHQ-1
X-Mimecast-MFC-AGG-ID: 6SDcBpvVM-qenZQMLsakHQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5E581955D62
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 17:25:37 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C59593003B71; Fri, 15 Nov 2024 17:25:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 5/9] convert code to object_new_dynamic() where appropriate
Date: Fri, 15 Nov 2024 17:25:17 +0000
Message-ID: <20241115172521.504102-6-berrange@redhat.com>
In-Reply-To: <20241115172521.504102-1-berrange@redhat.com>
References: <20241115172521.504102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In cases where object_new() is not being passed a static, const
string, the caller cannot be sure what type they are instantiating.
There is a risk that instantiation could fail, if it is an abstract
type.

Convert such cases over to use object_new_dynamic() such that they
are forced to expect failure. In some cases failure can be easily
propagated, but in others using &error_abort or &error_fatal will
maintain existnig behaviour.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char.c                        |  6 +++++-
 hw/arm/aspeed.c                       |  4 ++--
 hw/arm/exynos4210.c                   |  3 ++-
 hw/arm/highbank.c                     |  2 +-
 hw/arm/integratorcp.c                 |  2 +-
 hw/arm/mps3r.c                        |  3 ++-
 hw/arm/realview.c                     |  3 ++-
 hw/arm/sbsa-ref.c                     |  3 ++-
 hw/arm/versatilepb.c                  |  2 +-
 hw/arm/vexpress.c                     |  2 +-
 hw/arm/virt.c                         |  6 ++++--
 hw/arm/xilinx_zynq.c                  |  3 ++-
 hw/core/bus.c                         |  2 +-
 hw/core/cpu-common.c                  |  2 +-
 hw/core/qdev.c                        |  2 +-
 hw/i386/x86-common.c                  |  5 ++++-
 hw/i386/xen/xen-pvh.c                 |  2 +-
 hw/intc/xics.c                        |  5 ++++-
 hw/mips/cps.c                         |  3 ++-
 hw/pci-host/pnv_phb.c                 |  5 ++++-
 hw/ppc/e500.c                         |  2 +-
 hw/ppc/pnv.c                          |  4 ++--
 hw/ppc/pnv_core.c                     |  5 ++++-
 hw/ppc/spapr.c                        |  2 +-
 hw/ppc/spapr_cpu_core.c               |  5 ++++-
 hw/ppc/spapr_drc.c                    |  2 +-
 hw/s390x/s390-virtio-ccw.c            |  8 +++++++-
 hw/sparc/leon3.c                      |  2 +-
 hw/sparc/sun4m.c                      |  2 +-
 hw/sparc64/sparc64.c                  |  2 +-
 hw/vfio/common.c                      |  6 +++++-
 hw/vfio/container.c                   |  7 ++++++-
 qom/qom-qmp-cmds.c                    |  5 ++++-
 target/arm/arm-qmp-cmds.c             |  5 ++++-
 target/loongarch/loongarch-qmp-cmds.c |  5 ++++-
 target/mips/cpu.c                     |  2 +-
 target/riscv/riscv-qmp-cmds.c         |  5 ++++-
 target/xtensa/cpu.c                   |  2 +-
 tests/unit/check-qom-interface.c      |  3 ++-
 tests/unit/test-smp-parse.c           | 20 ++++++++++----------
 40 files changed, 107 insertions(+), 52 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index a1722aa076..5951b8bef5 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -996,7 +996,11 @@ static Chardev *chardev_new(const char *id, const char *typename,
     assert(g_str_has_prefix(typename, "chardev-"));
     assert(id);
 
-    obj = object_new(typename);
+    obj = object_new_dynamic(typename, errp);
+    if (!obj) {
+        return NULL;
+    }
+
     chr = CHARDEV(obj);
     chr->handover_yank_instance = handover_yank_instance;
     chr->label = g_strdup(id);
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6ca145362c..71196b0a4b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -385,7 +385,7 @@ static void aspeed_machine_init(MachineState *machine)
     DriveInfo *emmc0 = NULL;
     bool boot_emmc;
 
-    bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
+    bmc->soc = ASPEED_SOC(object_new_dynamic(amc->soc_name, &error_fatal));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));
     object_unref(OBJECT(bmc->soc));
     sc = ASPEED_SOC_GET_CLASS(bmc->soc);
@@ -1594,7 +1594,7 @@ static void aspeed_minibmc_machine_init(MachineState *machine)
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
-    bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
+    bmc->soc = ASPEED_SOC(object_new_dynamic(amc->soc_name, &error_fatal));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));
     object_unref(OBJECT(bmc->soc));
     qdev_connect_clock_in(DEVICE(bmc->soc), "sysclk", sysclk);
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index e3f1de2631..b966b0cd06 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -554,7 +554,8 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     int i, n;
 
     for (n = 0; n < EXYNOS4210_NCPUS; n++) {
-        Object *cpuobj = object_new(ARM_CPU_TYPE_NAME("cortex-a9"));
+        Object *cpuobj = object_new_dynamic(ARM_CPU_TYPE_NAME("cortex-a9"),
+                                            &error_fatal);
 
         object_property_add_child(OBJECT(s), "cpu[*]", cpuobj);
         /* By default A9 CPUs have EL3 enabled.  This board does not currently
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index f103921d49..07740eecdb 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -206,7 +206,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         Object *cpuobj;
         ARMCPU *cpu;
 
-        cpuobj = object_new(machine->cpu_type);
+        cpuobj = object_new_dynamic(machine->cpu_type, &error_abort);
         cpu = ARM_CPU(cpuobj);
 
         object_property_add_child(OBJECT(machine), "cpu[*]", cpuobj);
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index feb0dd63df..2d1adfd7f8 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -595,7 +595,7 @@ static void integratorcp_init(MachineState *machine)
     DriveInfo *dinfo;
     int i;
 
-    cpuobj = object_new(machine->cpu_type);
+    cpuobj = object_new_dynamic(machine->cpu_type, &error_fatal);
 
     /* By default ARM1176 CPUs have EL3 enabled.  This board does not
      * currently support EL3 so the CPU EL3 property is disabled before
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 4d55a6564c..60c2138b4a 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -387,7 +387,8 @@ static void mps3r_common_init(MachineState *machine)
         memory_region_add_subregion_overlap(&mms->cpu_sysmem[i], 0,
                                             &mms->sysmem_alias[i], -1);
 
-        mms->cpu[i] = object_new(machine->cpu_type);
+        mms->cpu[i] = object_new_dynamic(machine->cpu_type,
+                                         &error_fatal);
         object_property_set_link(mms->cpu[i], "memory",
                                  OBJECT(&mms->cpu_sysmem[i]), &error_abort);
         object_property_set_int(mms->cpu[i], "reset-cbar",
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index b186f965c6..214c03fb20 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -116,7 +116,8 @@ static void realview_init(MachineState *machine,
     }
 
     for (n = 0; n < smp_cpus; n++) {
-        Object *cpuobj = object_new(machine->cpu_type);
+        Object *cpuobj = object_new_dynamic(machine->cpu_type,
+                                            &error_fatal);
 
         /* By default A9,A15 and ARM1176 CPUs have EL3 enabled.  This board
          * does not currently support EL3 so the CPU EL3 property is disabled
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e3195d5449..a0006c9af0 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -767,7 +767,8 @@ static void sbsa_ref_init(MachineState *machine)
             break;
         }
 
-        cpuobj = object_new(possible_cpus->cpus[n].type);
+        cpuobj = object_new_dynamic(possible_cpus->cpus[n].type,
+                                    &error_fatal);
         object_property_set_int(cpuobj, "mp-affinity",
                                 possible_cpus->cpus[n].arch_id, NULL);
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index d48235453e..eb77dfc593 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -205,7 +205,7 @@ static void versatile_init(MachineState *machine, int board_id)
         exit(1);
     }
 
-    cpuobj = object_new(machine->cpu_type);
+    cpuobj = object_new_dynamic(machine->cpu_type, &error_fatal);
 
     /* By default ARM1176 CPUs have EL3 enabled.  This board does not
      * currently support EL3 so the CPU EL3 property is disabled before
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index de815d84cc..98ad6299a8 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -217,7 +217,7 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
 
     /* Create the actual CPUs */
     for (n = 0; n < smp_cpus; n++) {
-        Object *cpuobj = object_new(cpu_type);
+        Object *cpuobj = object_new_dynamic(cpu_type, &error_abort);
 
         if (!secure) {
             object_property_set_bool(cpuobj, "has_el3", false, NULL);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1a381e9a2b..f80ab50d41 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2125,7 +2125,8 @@ static void machvirt_init(MachineState *machine)
          * we are about to deal with. Once this is done, get rid of
          * the object.
          */
-        cpuobj = object_new(possible_cpus->cpus[0].type);
+        cpuobj = object_new_dynamic(possible_cpus->cpus[0].type,
+                                    &error_fatal);
         armcpu = ARM_CPU(cpuobj);
 
         pa_bits = arm_pamax(armcpu);
@@ -2231,7 +2232,8 @@ static void machvirt_init(MachineState *machine)
             break;
         }
 
-        cpuobj = object_new(possible_cpus->cpus[n].type);
+        cpuobj = object_new_dynamic(possible_cpus->cpus[n].type,
+                                    &error_fatal);
         object_property_set_int(cpuobj, "mp-affinity",
                                 possible_cpus->cpus[n].arch_id, NULL);
 
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index fde4d946b7..40a725782d 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -218,7 +218,8 @@ static void zynq_init(MachineState *machine)
     }
 
     for (n = 0; n < smp_cpus; n++) {
-        Object *cpuobj = object_new(machine->cpu_type);
+        Object *cpuobj = object_new_dynamic(machine->cpu_type,
+                                            &error_fatal);
 
         object_property_set_int(cpuobj, "midr", ZYNQ_BOARD_MIDR,
                                 &error_fatal);
diff --git a/hw/core/bus.c b/hw/core/bus.c
index b9d89495cd..2de714b274 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -163,7 +163,7 @@ BusState *qbus_new(const char *typename, DeviceState *parent, const char *name)
 {
     BusState *bus;
 
-    bus = BUS(object_new(typename));
+    bus = BUS(object_new_dynamic(typename, &error_abort));
     qbus_init_internal(bus, parent, name);
 
     return bus;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 09c7903594..8768ae39ed 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -57,7 +57,7 @@ bool cpu_exists(int64_t id)
 CPUState *cpu_create(const char *typename)
 {
     Error *err = NULL;
-    CPUState *cpu = CPU(object_new(typename));
+    CPUState *cpu = CPU(object_new_dynamic(typename, &error_abort));
     if (!qdev_realize(DEVICE(cpu), NULL, &err)) {
         error_report_err(err);
         object_unref(OBJECT(cpu));
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 960a704a96..7fcbbe431b 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -146,7 +146,7 @@ bool qdev_set_parent_bus(DeviceState *dev, BusState *bus, Error **errp)
 
 DeviceState *qdev_new(const char *name)
 {
-    return DEVICE(object_new(name));
+    return DEVICE(object_new_dynamic(name, &error_abort));
 }
 
 static QTAILQ_HEAD(, DeviceListener) device_listeners
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index bc360a9ea4..df38235eeb 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -55,7 +55,10 @@ static size_t pvh_start_addr;
 
 static void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
 {
-    Object *cpu = object_new(MACHINE(x86ms)->cpu_type);
+    Object *cpu = object_new_dynamic(MACHINE(x86ms)->cpu_type, errp);
+    if (!cpu) {
+        return;
+    }
 
     if (!object_property_set_uint(cpu, "apic-id", apic_id, errp)) {
         goto out;
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index f1f02d3311..9aeb4e430b 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -28,7 +28,7 @@ struct XenPVHx86State {
 static DeviceState *xen_pvh_cpu_new(MachineState *ms,
                                     int64_t apic_id)
 {
-    Object *cpu = object_new(ms->cpu_type);
+    Object *cpu = object_new_dynamic(ms->cpu_type, &error_abort);
 
     object_property_add_child(OBJECT(ms), "cpu[*]", cpu);
     object_property_set_uint(cpu, "apic-id", apic_id, &error_fatal);
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e893363dc9..2f06193bcd 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -377,7 +377,10 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
 {
     Object *obj;
 
-    obj = object_new(type);
+    obj = object_new_dynamic(type, errp);
+    if (!obj) {
+        return NULL;
+    }
     object_property_add_child(cpu, type, obj);
     object_unref(obj);
     object_property_set_link(obj, ICP_PROP_XICS, OBJECT(xi), &error_abort);
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 13046628cd..b8407bb191 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -74,7 +74,8 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     }
 
     for (int i = 0; i < s->num_vp; i++) {
-        MIPSCPU *cpu = MIPS_CPU(object_new(s->cpu_type));
+        MIPSCPU *cpu = MIPS_CPU(object_new_dynamic(s->cpu_type,
+                                                   &error_abort));
         CPUMIPSState *env = &cpu->env;
 
         object_property_set_bool(OBJECT(cpu), "big-endian", s->cpu_is_bigendian,
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index d4c118d443..6e833835d6 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -131,7 +131,10 @@ static void pnv_phb_realize(DeviceState *dev, Error **errp)
         g_assert_not_reached();
     }
 
-    phb->backend = object_new(phb_typename);
+    phb->backend = object_new_dynamic(phb_typename, errp);
+    if (!phb->backend) {
+        return;
+    }
     object_property_add_child(OBJECT(dev), "phb-backend", phb->backend);
 
     /* Passthrough child device properties to the proxy device */
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 46261223f3..8ba34f0972 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -939,7 +939,7 @@ void ppce500_init(MachineState *machine)
         PowerPCCPU *cpu;
         CPUState *cs;
 
-        cpu = POWERPC_CPU(object_new(machine->cpu_type));
+        cpu = POWERPC_CPU(object_new_dynamic(machine->cpu_type, &error_fatal));
         env = &cpu->env;
         cs = CPU(cpu);
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f0f0d7567d..75420c9413 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1459,7 +1459,7 @@ static void pnv_chip_power8_instance_init(Object *obj)
         chip8->num_phbs = pcc->num_phbs;
 
         for (i = 0; i < chip8->num_phbs; i++) {
-            Object *phb = object_new(TYPE_PNV_PHB);
+            Object *phb = object_new_dynamic(TYPE_PNV_PHB, &error_fatal);
 
             /*
              * We need the chip to parent the PHB to allow the DT
@@ -2376,7 +2376,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
             continue;
         }
 
-        pnv_core = PNV_CORE(object_new(typename));
+        pnv_core = PNV_CORE(object_new_dynamic(typename, &error_fatal));
 
         snprintf(core_name, sizeof(core_name), "core[%d]", core_hwid);
         object_property_add_child(OBJECT(chip), core_name, OBJECT(pnv_core));
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index a30693990b..4c62103021 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -361,7 +361,10 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
         PowerPCCPU *cpu;
         PnvCPUState *pnv_cpu;
 
-        obj = object_new(typename);
+        obj = object_new_dynamic(typename, &local_err);
+        if (!obj) {
+            goto err;
+        }
         cpu = POWERPC_CPU(obj);
 
         pc->threads[i] = POWERPC_CPU(obj);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5c02037c56..ca71242fb0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2693,7 +2693,7 @@ static void spapr_init_cpus(SpaprMachineState *spapr)
         }
 
         if (i < boot_cores_nr) {
-            Object *core  = object_new(type);
+            Object *core  = object_new_dynamic(type, &error_fatal);
             int nr_threads = smp_threads;
 
             /* Handle the partially filled core for older machine types */
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ada439e831..aa9704e7ea 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -298,7 +298,10 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
     PowerPCCPU *cpu;
     CPUPPCState *env;
 
-    obj = object_new(scc->cpu_type);
+    obj = object_new_dynamic(scc->cpu_type, errp);
+    if (!obj) {
+        return NULL;
+    }
 
     cs = CPU(obj);
     cpu = POWERPC_CPU(obj);
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 1484e3209d..56835ebf2b 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -554,7 +554,7 @@ static void drc_unrealize(DeviceState *d)
 SpaprDrc *spapr_dr_connector_new(Object *owner, const char *type,
                                          uint32_t id)
 {
-    SpaprDrc *drc = SPAPR_DR_CONNECTOR(object_new(type));
+    SpaprDrc *drc = SPAPR_DR_CONNECTOR(object_new_dynamic(type, &error_fatal));
     g_autofree char *prop_name = NULL;
 
     drc->id = id;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index fe03f716f3..5441dc4c32 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -55,9 +55,15 @@ static Error *pv_mig_blocker;
 static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
                               Error **errp)
 {
-    S390CPU *cpu = S390_CPU(object_new(typename));
+    Object *cpuobj = object_new_dynamic(typename, errp);
+    S390CPU *cpu = NULL;
     S390CPU *ret = NULL;
 
+    if (!cpuobj) {
+        return NULL;
+    }
+
+    cpu = S390_CPU(cpuobj);
     if (!object_property_set_int(OBJECT(cpu), "core-id", core_id, errp)) {
         goto out;
     }
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 6aaa04cb19..519169af1e 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -277,7 +277,7 @@ static void leon3_generic_hw_init(MachineState *machine)
 
     for (i = 0; i < machine->smp.cpus; i++) {
         /* Init CPU */
-        cpu = SPARC_CPU(object_new(machine->cpu_type));
+        cpu = SPARC_CPU(object_new_dynamic(machine->cpu_type, &error_fatal));
         qdev_init_gpio_in_named(DEVICE(cpu), leon3_start_cpu, "start_cpu", 1);
         qdev_init_gpio_in_named(DEVICE(cpu), leon3_set_pil_in, "pil", 1);
         qdev_realize(DEVICE(cpu), NULL, &error_fatal);
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index d52e6a7213..c7e47af1d5 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -802,7 +802,7 @@ static void cpu_devinit(const char *cpu_type, unsigned int id,
     SPARCCPU *cpu;
     CPUSPARCState *env;
 
-    cpu = SPARC_CPU(object_new(cpu_type));
+    cpu = SPARC_CPU(object_new_dynamic(cpu_type, &error_fatal));
     env = &cpu->env;
 
     qemu_register_reset(sun4m_cpu_reset, cpu);
diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
index 3091cde586..9e032e6124 100644
--- a/hw/sparc64/sparc64.c
+++ b/hw/sparc64/sparc64.c
@@ -272,7 +272,7 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr)
     uint32_t  stick_frequency = 100 * 1000000;
     uint32_t hstick_frequency = 100 * 1000000;
 
-    cpu = SPARC_CPU(object_new(cpu_type));
+    cpu = SPARC_CPU(object_new_dynamic(cpu_type, &error_fatal));
     qdev_init_gpio_in_named(DEVICE(cpu), sparc64_cpu_set_ivec_irq,
                             "ivec-irq", IVEC_MAX);
     qdev_realize(DEVICE(cpu), NULL, &error_fatal);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index dcef44fe55..9799fd8627 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1550,7 +1550,11 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 
 
     if (!vbasedev->mdev) {
-        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
+        Object *obj = object_new_dynamic(ops->hiod_typename, errp);
+        if (!obj) {
+            return false;
+        }
+        hiod = HOST_IOMMU_DEVICE(obj);
         vbasedev->hiod = hiod;
     }
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9ccdb639ac..6642d2f79b 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -419,6 +419,7 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
 {
     int iommu_type;
     const char *vioc_name;
+    Object *obj;
     VFIOContainer *container;
 
     iommu_type = vfio_get_iommu_type(fd, errp);
@@ -432,7 +433,11 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
 
     vioc_name = vfio_get_iommu_class_name(iommu_type);
 
-    container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
+    obj = object_new_dynamic(vioc_name, errp);
+    if (!obj) {
+        return NULL;
+    }
+    container = VFIO_IOMMU_LEGACY(obj);
     container->fd = fd;
     container->iommu_type = iommu_type;
     return container;
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 4a8e269fef..a32855659e 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -203,7 +203,10 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
     if (object_class_is_abstract(klass)) {
         object_class_property_iter_init(&iter, klass);
     } else {
-        obj = object_new(typename);
+        obj = object_new_dynamic(typename, errp);
+        if (!obj) {
+            return NULL;
+        }
         object_property_iter_init(&iter, obj);
     }
     while ((prop = object_property_iter_next(&iter))) {
diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
index 3cc8cc738b..61024f480d 100644
--- a/target/arm/arm-qmp-cmds.c
+++ b/target/arm/arm-qmp-cmds.c
@@ -150,7 +150,10 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         }
     }
 
-    obj = object_new(object_class_get_name(oc));
+    obj = object_new_dynamic(object_class_get_name(oc), errp);
+    if (!obj) {
+        return NULL;
+    }
 
     if (model->props) {
         Visitor *visitor;
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 782fd511fd..5f565e2236 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -83,7 +83,10 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         return NULL;
     }
 
-    obj = object_new(object_class_get_name(oc));
+    obj = object_new_dynamic(object_class_get_name(oc), errp);
+    if (!obj) {
+        return NULL;
+    }
 
     expansion_info = g_new0(CpuModelExpansionInfo, 1);
     expansion_info->model = g_malloc0(sizeof(*expansion_info->model));
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d0a43b6d5c..1bf872c3e0 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -648,7 +648,7 @@ MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk,
 {
     DeviceState *cpu;
 
-    cpu = DEVICE(object_new(cpu_type));
+    cpu = DEVICE(object_new_dynamic(cpu_type, &error_abort));
     qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
     object_property_set_bool(OBJECT(cpu), "big-endian", is_big_endian,
                              &error_abort);
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d363dc318d..61f30b6bc6 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -188,7 +188,10 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         return NULL;
     }
 
-    obj = object_new(object_class_get_name(oc));
+    obj = object_new_dynamic(object_class_get_name(oc), errp);
+    if (!obj) {
+        return NULL;
+    }
 
     riscv_check_if_cpu_available(RISCV_CPU(obj), &local_err);
     if (local_err != NULL) {
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 6f9039abae..3e036a1191 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -204,7 +204,7 @@ XtensaCPU *xtensa_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk)
 {
     DeviceState *cpu;
 
-    cpu = DEVICE(object_new(cpu_type));
+    cpu = DEVICE(object_new_dynamic(cpu_type, &error_abort));
     qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
     qdev_realize(cpu, NULL, &error_abort);
 
diff --git a/tests/unit/check-qom-interface.c b/tests/unit/check-qom-interface.c
index c99be97ed8..e4532ae814 100644
--- a/tests/unit/check-qom-interface.c
+++ b/tests/unit/check-qom-interface.c
@@ -13,6 +13,7 @@
 
 #include "qom/object.h"
 #include "qemu/module.h"
+#include "qapi/error.h"
 
 
 #define TYPE_TEST_IF "test-interface"
@@ -67,7 +68,7 @@ static const TypeInfo intermediate_impl_info = {
 
 static void test_interface_impl(const char *type)
 {
-    Object *obj = object_new(type);
+    Object *obj = object_new_dynamic(type, &error_abort);
     TestIf *iobj = TEST_IF(obj);
     TestIfClass *ioc = TEST_IF_GET_CLASS(iobj);
 
diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index f9bccb56ab..f4893d5f24 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -1008,7 +1008,7 @@ static void machine_full_topo_class_init(ObjectClass *oc, void *data)
 static void test_generic_valid(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1027,7 +1027,7 @@ static void test_generic_valid(const void *opaque)
 static void test_generic_invalid(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1046,7 +1046,7 @@ static void test_generic_invalid(const void *opaque)
 static void test_with_modules(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1096,7 +1096,7 @@ static void test_with_modules(const void *opaque)
 static void test_with_dies(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1146,7 +1146,7 @@ static void test_with_dies(const void *opaque)
 static void test_with_modules_dies(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1207,7 +1207,7 @@ static void test_with_modules_dies(const void *opaque)
 static void test_with_clusters(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1257,7 +1257,7 @@ static void test_with_clusters(const void *opaque)
 static void test_with_books(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1307,7 +1307,7 @@ static void test_with_books(const void *opaque)
 static void test_with_drawers(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1357,7 +1357,7 @@ static void test_with_drawers(const void *opaque)
 static void test_with_drawers_books(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
@@ -1418,7 +1418,7 @@ static void test_with_drawers_books(const void *opaque)
 static void test_full_topo(const void *opaque)
 {
     const char *machine_type = opaque;
-    Object *obj = object_new(machine_type);
+    Object *obj = object_new_dynamic(machine_type, &error_abort);
     MachineState *ms = MACHINE(obj);
     MachineClass *mc = MACHINE_GET_CLASS(obj);
     SMPTestData data = {};
-- 
2.46.0


