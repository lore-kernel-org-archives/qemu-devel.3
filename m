Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EB7C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 08:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tasXz-0000NG-Qy; Thu, 23 Jan 2025 03:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tasXx-0000N3-QD
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:26:41 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tasXv-0003Zd-5J
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 03:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737620799; x=1769156799;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=KiibzZJk5o48F2wdBGveXrH//P5lpwlf0zP4EZGT5pU=;
 b=f9KqRu/SxCkPEAMMwfUmjy9/fQVwRjbEwb7qrgKJ30AvaZFToL0m4Mty
 vnHOm1I8m3Js8YYvP+b7Q+CcmhpvHhup3+PED9yp7rnu9idMzIthlRpz8
 u15/mBGHqKl6fLhGVQ9L7LkHM2qZVLJ3G0z7l8FNksCSW+wXiamV18Id+
 p3LfuwpY5GpCsg483d/fotH7B6Otfgq0RAnDbXYCiVIDMXuc5YWF5qR0c
 gvDj07oOCcyQdAKAoenQM2TcXWwEoNptVMyMbdTgjpH0MJTC0HX8gjebU
 t2yeM5Y6QGHqC1yTBl4/OrIvPI7UQVTbc9ogbbBlURuhLknDJK6ErTEYU g==;
X-CSE-ConnectionGUID: cWUCtZS1RCWrQmxAoN5D/g==
X-CSE-MsgGUID: cDU9QbhKSYGHDO5tnBVU7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="49502930"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; d="scan'208";a="49502930"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2025 00:26:36 -0800
X-CSE-ConnectionGUID: gYVSLXFLTKerNBihMF37BA==
X-CSE-MsgGUID: ovWOK4jhRw+CNIIo2XZdfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; d="scan'208";a="107208314"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 23 Jan 2025 00:26:33 -0800
Date: Thu, 23 Jan 2025 16:45:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, imammedo@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v4] hw/i386/cpu: remove default_cpu_version and simplify
Message-ID: <Z5IBxLeIBPvnJpaQ@intel.com>
References: <20250122120117.1154596-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122120117.1154596-1-anisinha@redhat.com>
Received-SPF: pass client-ip=198.175.65.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Ani,

[snip]

> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -114,7 +114,10 @@ void init_topo_info(X86CPUTopoInfo *topo_info, const X86MachineState *x86ms);
>  uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>                                      unsigned int cpu_index);
>  
> -void x86_cpus_init(X86MachineState *pcms, int default_cpu_version);
> +void x86_cpus_init(X86MachineState *pcms);
> +#ifndef I386_CPU_H
> +void x86_cpu_set_legacy_version(void);
> +#endif
>  void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
>  void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
>                        DeviceState *dev, Error **errp);

[snip]

> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h

...

> +#ifndef HW_I386_X86_H
> +void x86_cpu_set_legacy_version(void);
> +#endif
>  #ifndef CONFIG_USER_ONLY
>  
>  void do_cpu_sipi(X86CPU *cpu);

I see your problem: Due to the complex reference relationships, you have
to check the header files and make declarations twice.

What about the following solution?

 * Declare pc_init_cpus() in pc.h and define it in pc.c (including cpu.h
   in pc.c).
 * Only declare x86_cpu_set_legacy_version() in cpu.h.

An example would be like:

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b46975c8a4db..9e8b5fa33596 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -61,6 +61,7 @@
 #include "hw/i386/kvm/xen_xenstore.h"
 #include "hw/mem/memory-device.h"
 #include "e820_memory_layout.h"
+#include "target/i386/cpu.h"
 #include "trace.h"
 #include "sev.h"
 #include CONFIG_DEVICES
@@ -615,6 +616,19 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
     }
 }

+void pc_init_cpus(MachineState *ms)
+{
+    X86MachineState *x86ms = X86_MACHINE(ms);
+    PCMachineState *pcms = PC_MACHINE(ms);
+    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+
+    if (pcmc->no_versioned_cpu_model) {
+        /* use legacy cpu as it does not support versions */
+        x86_cpu_set_legacy_version();
+    }
+    x86_cpus_init(x86ms);
+}
+
 static
 void pc_machine_done(Notifier *notifier, void *data)
 {
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 34106bb52db8..dc0ca5bcb2a5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -130,19 +130,6 @@ struct PCMachineClass {
 #define TYPE_PC_MACHINE "generic-pc-machine"
 OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, PC_MACHINE)

-static inline void pc_init_cpus(MachineState *ms)
-{
-    X86MachineState *x86ms = X86_MACHINE(ms);
-    PCMachineState *pcms = PC_MACHINE(ms);
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
-
-    if (pcmc->no_versioned_cpu_model) {
-        /* use legacy cpu as it does not support versions */
-        x86_cpu_set_legacy_version();
-    }
-    x86_cpus_init(x86ms);
-}
-
 /* ioapic.c */

 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
@@ -150,6 +137,7 @@ GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
 /* pc.c */

 void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
+void pc_init_cpus(MachineState *ms);

 #define PCI_HOST_PROP_RAM_MEM          "ram-mem"
 #define PCI_HOST_PROP_PCI_MEM          "pci-mem"
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 41236d2a8081..2d2b987fa135 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -115,9 +115,6 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
                                     unsigned int cpu_index);

 void x86_cpus_init(X86MachineState *pcms);
-#ifndef I386_CPU_H
-void x86_cpu_set_legacy_version(void);
-#endif
 void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
 void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
                       DeviceState *dev, Error **errp);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9c0ce2adafe7..bdbe54b26f60 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2686,10 +2686,8 @@ typedef int X86CPUVersion;
  * Currently, this is only used by microvm.
  */
 void x86_cpu_uses_lastest_version(void);
-
-#ifndef HW_I386_X86_H
 void x86_cpu_set_legacy_version(void);
-#endif
+
 #ifndef CONFIG_USER_ONLY

 void do_cpu_sipi(X86CPU *cpu);

---

The change can be applied on this patch I think. If you like this
approach, you can try if the pipeline is happy with it.

Regards,
Zhao



