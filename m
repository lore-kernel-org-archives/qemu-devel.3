Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799E2CCA471
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lEy-0005DQ-9w; Tue, 30 Sep 2025 21:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEu-0005Ch-96
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:02:40 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEe-0007ye-Iv
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:02:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e34bd8eb2so21360645e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280541; x=1759885341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8XfMldxxVCrNmv0kqbSVtv1GLDt+68S/R+Hgz9Z4xw=;
 b=GZPkvM/T37vSapIx7l9E8hJRAlAV+RLMzovz7/tXOHZPNU/Z3yqheRp+9xlADBjI1L
 9PTzXwFvSFUXS/wi/E0ZOGfisMECCvgQh1AnMCAP6OyvN7BEGlQEC4x3+98Cr+OUG3//
 vIQH9UQFJluJUat1M6dMEzxGcV7r1pxv1ESqZaXsRnwhH7hPeAKyGljFNlSn3LaDaCq7
 E9xlwwhEkVzJ3xBKlF6zseR2hH+2LFt1huzUHkadt5L7gyH9ul3fhIBvPZ4x1O6T9E0c
 5i07KJQUcSMyIqSQKBW/ZKE6hFKAhJXUpJr4xOMvsMzgYtukyeiZ677tCYKIA4Z5bM03
 LBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280541; x=1759885341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8XfMldxxVCrNmv0kqbSVtv1GLDt+68S/R+Hgz9Z4xw=;
 b=XEIZyxB4VJm2grbLzQy8j+w2XZJDwjcYwhzUyfudpJ5O+RzbWKBYDks8Sa6mF0srQG
 l3R7gG7DjVVVP+2tTJFrQ1yO9T/JvBV7Nn7SQXlPIqNjQEC1fVrJiGlRocufIG6zDUyr
 u2LEZV8A+l8Te3JZZo/fFkv/fPBcUMiYXDdG/bZiBuFYU1GtKbV4l4z9HP7MB6rSKbey
 opoxXyR/n07AsT0fQr5LMpM5ERjNhKHY2QsEDZdgGtyPkWVGJbBmBJ4xL9tNAIkNFlBI
 6VohFnfQhX4+ct6n+/OMVGA5t8eU6Y4XF97ePOSawn5x3CPyniksgcX8t1+zf/nRlAu0
 XB3Q==
X-Gm-Message-State: AOJu0YyI0l3MclaxZ7ntfWcNZf8EWOE6ITIjQzz3VeObcuOXzeiC2HJ3
 WFaGoY2YvczDTEUxk5QtqXxHHJjx6w3SII8mguRDuokwNpqhC4BUjHsi6Ec7B8hs132O1Epqmy+
 GCWIoN7IpfQ==
X-Gm-Gg: ASbGncvhl0dgFW7koJYOkGqWf2V5TDn92hRsPkxaJIWjD1/bwq1+PQ9sDwOCxuyJRrW
 tBldm/PLEayBFyDk1/hdl8f8uKNmXywkkLYs0R0r2bkOet+qrmr2E+dEni/L1/VkA9uEoRMDwJG
 hvl5sVsjLi54Rwxq9P2yemNbvm79J+ff7LEv4czzPh1w3JL1HTXkmxGT0GV+gHr7aSeF42I73L8
 i02oM7uiCMSDMW7a1rpZhWCqX9kcX2Vk8t86HS2ZTrYDqiKbNgZmKN+ATT1V1NqlUWvB49hlWBh
 lAHFoWMloykXh5KWIksvx96XducwaLxojiuttlod21mjerQ22MOKpiTOP5I7G1JrDg1x0dxvxmB
 ZJFXeAxfWYwLjWuLAD9mC3yFPYshB6yIqR+r/Dq8BT4200+8plsGxjoN3FQWMtMtdc5UGx/f/ov
 Jj1vDP1Y7VuW+tupnNnoNoxVG9GEmetLdi5msknHeMKeg=
X-Google-Smtp-Source: AGHT+IHq/D/wM1ROCaoz7TPSt/zRIizaBtVxINQT1Wi3V79bOXPFSKj0yC6hHR65I5ACPNuCq/g28Q==
X-Received: by 2002:a05:600c:474b:b0:46e:477a:16cc with SMTP id
 5b1f17b1804b1-46e612bdb1dmr14093585e9.24.1759280540352; 
 Tue, 30 Sep 2025 18:02:20 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:19 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 03/24] hw/arm/virt: Clamp 'maxcpus' as-per machine's
 vCPU deferred online-capability
Date: Wed,  1 Oct 2025 01:01:06 +0000
Message-Id: <20251001010127.3092631-4-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Salil Mehta <salil.mehta@huawei.com>

To support a vCPU hot-add–like model on ARM, the virt machine may be setup with
more CPUs than are active at boot. These additional CPUs are fully realized in
KVM and listed in ACPI tables from the start, but begin in a disabled state.
They can later be brought online or taken offline under host or platform policy
control. The CPU topology is fixed at VM creation time and cannot change
dynamically on ARM. Therefore, we must determine precisely the 'maxcpus' value
that applies for the full lifetime of the VM.

On ARM, this deferred online-capable model is only valid if:
  - The GIC version is 3 or higher, and
  - Each non-boot CPU’s GIC CPU Interface is marked “online-capable” in its
    ACPI GICC structure (UEFI ACPI Specification 6.5, §5.2.12.14, Table 5.37
    “GICC CPU Interface Flags”), and
  - The chosen accelerator supports safe deferred CPU online:
      * TCG with multi-threaded TCG (MTTCG) enabled
      * KVM (on supported hosts)
      * Not HVF or QTest

This patch sizes the machine’s max-possible CPUs during VM init:
  - If all conditions are satisfied, retain the full set of CPUs corresponding
    to (`-smp cpus` + `-smp disabledcpus`), allowing the additional (initially
    disabled) CPUs to participate in later policy-driven online.
  - Otherwise, clamp the max-possible CPUs to the boot-enabled count
    (`-smp disabledcpus=0` equivalent) to avoid advertising CPUs the guest can
    never use.

A new MachineClass flag, `has_online_capable_cpus`, records whether the machine
supports deferred vCPU online. This is usable by other machine types as well.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c       | 84 ++++++++++++++++++++++++++++++---------------
 include/hw/boards.h |  1 +
 2 files changed, 57 insertions(+), 28 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ef6be3660f..76f21bd56a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2168,8 +2168,7 @@ static void machvirt_init(MachineState *machine)
     bool has_ged = !vmc->no_ged;
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
-
-    possible_cpus = mc->possible_cpu_arch_ids(machine);
+    DeviceClass *dc;
 
     /*
      * In accelerated mode, the memory map is computed earlier in kvm_type()
@@ -2186,7 +2185,7 @@ static void machvirt_init(MachineState *machine)
          * we are about to deal with. Once this is done, get rid of
          * the object.
          */
-        cpuobj = object_new(possible_cpus->cpus[0].type);
+        cpuobj = object_new(machine->cpu_type);
         armcpu = ARM_CPU(cpuobj);
 
         pa_bits = arm_pamax(armcpu);
@@ -2201,6 +2200,57 @@ static void machvirt_init(MachineState *machine)
      */
     finalize_gic_version(vms);
 
+    /*
+     * The maximum number of CPUs depends on the GIC version, or on how
+     * many redistributors we can fit into the memory map (which in turn
+     * depends on whether this is a GICv3 or v4).
+     */
+    if (vms->gic_version == VIRT_GIC_VERSION_2) {
+        virt_max_cpus = GIC_NCPU;
+    } else {
+        virt_max_cpus = virt_redist_capacity(vms, VIRT_GIC_REDIST);
+        if (vms->highmem_redists) {
+            virt_max_cpus += virt_redist_capacity(vms, VIRT_HIGH_GIC_REDIST2);
+        }
+    }
+
+    if ((tcg_enabled() && !qemu_tcg_mttcg_enabled()) || hvf_enabled() ||
+        qtest_enabled() || vms->gic_version == VIRT_GIC_VERSION_2) {
+        max_cpus = machine->smp.max_cpus = smp_cpus;
+        if (mc->has_online_capable_cpus) {
+            if (vms->gic_version == VIRT_GIC_VERSION_2) {
+                warn_report("GICv2 does not support online-capable CPUs");
+            }
+            mc->has_online_capable_cpus = false;
+        }
+    }
+
+    if (mc->has_online_capable_cpus) {
+        max_cpus = smp_cpus + machine->smp.disabledcpus;
+        machine->smp.max_cpus = max_cpus;
+    }
+
+    if (max_cpus > virt_max_cpus) {
+        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
+                     "supported by machine 'mach-virt' (%d)",
+                     max_cpus, virt_max_cpus);
+        if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->highmem_redists) {
+            error_printf("Try 'highmem-redists=on' for more CPUs\n");
+        }
+
+        exit(1);
+    }
+
+    dc = DEVICE_CLASS(object_class_by_name(machine->cpu_type));
+    if (!dc) {
+        error_report("CPU type '%s' not registered", machine->cpu_type);
+        exit(1);
+    }
+    dc->admin_power_state_supported = mc->has_online_capable_cpus;
+
+    /* uses smp.max_cpus to initialize all possible vCPUs */
+    possible_cpus = mc->possible_cpu_arch_ids(machine);
+
     if (vms->secure) {
         /*
          * The Secure view of the world is the same as the NonSecure,
@@ -2235,31 +2285,6 @@ static void machvirt_init(MachineState *machine)
         vms->psci_conduit = QEMU_PSCI_CONDUIT_HVC;
     }
 
-    /*
-     * The maximum number of CPUs depends on the GIC version, or on how
-     * many redistributors we can fit into the memory map (which in turn
-     * depends on whether this is a GICv3 or v4).
-     */
-    if (vms->gic_version == VIRT_GIC_VERSION_2) {
-        virt_max_cpus = GIC_NCPU;
-    } else {
-        virt_max_cpus = virt_redist_capacity(vms, VIRT_GIC_REDIST);
-        if (vms->highmem_redists) {
-            virt_max_cpus += virt_redist_capacity(vms, VIRT_HIGH_GIC_REDIST2);
-        }
-    }
-
-    if (max_cpus > virt_max_cpus) {
-        error_report("Number of SMP CPUs requested (%d) exceeds max CPUs "
-                     "supported by machine 'mach-virt' (%d)",
-                     max_cpus, virt_max_cpus);
-        if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms->highmem_redists) {
-            error_printf("Try 'highmem-redists=on' for more CPUs\n");
-        }
-
-        exit(1);
-    }
-
     if (vms->secure && !tcg_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Security extensions (TrustZone) to the guest CPU",
@@ -3245,6 +3270,9 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     hc->plug = virt_machine_device_plug_cb;
     hc->unplug_request = virt_machine_device_unplug_request_cb;
     hc->unplug = virt_machine_device_unplug_cb;
+
+    mc->has_online_capable_cpus = true;
+
     mc->nvdimm_supported = true;
     mc->smp_props.clusters_supported = true;
     mc->auto_enable_numa_with_memhp = true;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 2b182d7817..b27c2326a2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -302,6 +302,7 @@ struct MachineClass {
     bool rom_file_has_mr;
     int minimum_page_bits;
     bool has_hotpluggable_cpus;
+    bool has_online_capable_cpus;
     bool ignore_memory_transaction_failures;
     int numa_mem_align_shift;
     const char * const *valid_cpu_types;
-- 
2.34.1


