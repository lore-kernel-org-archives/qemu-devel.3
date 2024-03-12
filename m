Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06A1C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:49:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1VV-0005Kp-Gp; Tue, 12 Mar 2024 08:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1V5-0004Nb-5f
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1V2-0000WV-D0
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3iSAaDIIb1P5g2SBo9zDd7kQqe+DZKNANJ8NYQpZpE=;
 b=VwOH2fgNunfHWdNS4H+MbUgVUzgoFmors5xxIYhfxx3yqfIprL826AEo78CxFAyA/+smhB
 /iGfEW++P4AzrVLZSSXnUOxRVTCmJEf8XOGuooLUaoTwU8fQrxOZt0ATBoXM3v3c6PCZ8m
 HAner5cPOSC2U/fCexS/5dx8GCqoDgg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-zATo4KJCM0KKwVMsX1D2EQ-1; Tue,
 12 Mar 2024 08:44:51 -0400
X-MC-Unique: zATo4KJCM0KKwVMsX1D2EQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20EF91C41A0D;
 Tue, 12 Mar 2024 12:44:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 635E2492BC4;
 Tue, 12 Mar 2024 12:44:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/55] hw/core: Declare CPUArchId::cpu as CPUState instead of
 Object
Date: Tue, 12 Mar 2024 13:43:19 +0100
Message-ID: <20240312124339.761630-36-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Do not accept any Object for CPUArchId::cpu field,
restrict it to CPUState type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240129164514.73104-3-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/boards.h        | 2 +-
 hw/core/machine.c          | 4 ++--
 hw/i386/x86.c              | 2 +-
 hw/loongarch/virt.c        | 2 +-
 hw/ppc/spapr.c             | 5 ++---
 hw/s390x/s390-virtio-ccw.c | 2 +-
 6 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index bcfde8a84d..8b8f6d5c00 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -120,7 +120,7 @@ typedef struct CPUArchId {
     uint64_t arch_id;
     int64_t vcpus_count;
     CpuInstanceProperties props;
-    Object *cpu;
+    CPUState *cpu;
     const char *type;
 } CPUArchId;
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9ac5d5389a..024bf34f54 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -716,7 +716,7 @@ HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
     mc->possible_cpu_arch_ids(machine);
 
     for (i = 0; i < machine->possible_cpus->len; i++) {
-        Object *cpu;
+        CPUState *cpu;
         HotpluggableCPU *cpu_item = g_new0(typeof(*cpu_item), 1);
 
         cpu_item->type = g_strdup(machine->possible_cpus->cpus[i].type);
@@ -726,7 +726,7 @@ HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState *machine)
 
         cpu = machine->possible_cpus->cpus[i].cpu;
         if (cpu) {
-            cpu_item->qom_path = object_get_canonical_path(cpu);
+            cpu_item->qom_path = object_get_canonical_path(OBJECT(cpu));
         }
         QAPI_LIST_PREPEND(head, cpu_item);
     }
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 807e09bcdb..ffbda48917 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -225,7 +225,7 @@ void x86_cpu_plug(HotplugHandler *hotplug_dev,
     }
 
     found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, NULL);
-    found_cpu->cpu = OBJECT(dev);
+    found_cpu->cpu = CPU(dev);
 out:
     error_propagate(errp, local_err);
 }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 1e98d8bda5..efce112310 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -858,7 +858,7 @@ static void loongarch_init(MachineState *machine)
     for (i = 0; i < possible_cpus->len; i++) {
         cpu = cpu_create(machine->cpu_type);
         cpu->cpu_index = i;
-        machine->possible_cpus->cpus[i].cpu = OBJECT(cpu);
+        machine->possible_cpus->cpus[i].cpu = cpu;
         lacpu = LOONGARCH_CPU(cpu);
         lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 55263f0815..f8980b62ec 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3979,7 +3979,6 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
     SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
     SpaprCpuCore *core = SPAPR_CPU_CORE(OBJECT(dev));
     CPUCore *cc = CPU_CORE(dev);
-    CPUState *cs;
     SpaprDrc *drc;
     CPUArchId *core_slot;
     int index;
@@ -4013,7 +4012,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
         }
     }
 
-    core_slot->cpu = OBJECT(dev);
+    core_slot->cpu = CPU(dev);
 
     /*
      * Set compatibility mode to match the boot CPU, which was either set
@@ -4029,7 +4028,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev)
 
     if (smc->pre_2_10_has_unused_icps) {
         for (i = 0; i < cc->nr_threads; i++) {
-            cs = CPU(core->threads[i]);
+            CPUState *cs = CPU(core->threads[i]);
             pre_2_10_vmstate_unregister_dummy_icp(cs->cpu_index);
         }
     }
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4b6aab8eef..b1dcb3857f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -317,7 +317,7 @@ static void s390_cpu_plug(HotplugHandler *hotplug_dev,
     S390CPU *cpu = S390_CPU(dev);
 
     g_assert(!ms->possible_cpus->cpus[cpu->env.core_id].cpu);
-    ms->possible_cpus->cpus[cpu->env.core_id].cpu = OBJECT(dev);
+    ms->possible_cpus->cpus[cpu->env.core_id].cpu = CPU(dev);
 
     if (s390_has_topology()) {
         s390_topology_setup_cpu(ms, cpu, errp);
-- 
2.44.0


