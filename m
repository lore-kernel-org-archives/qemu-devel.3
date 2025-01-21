Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D20CC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCRD-0002SI-Hd; Tue, 21 Jan 2025 06:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taCRA-0002S5-Lt
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:28:52 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taCR6-00015U-01
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737458928; x=1768994928;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qMhehAUOPAqa5X7J6dq6GW6QEAdV5p3S6NmI3tFCAxM=;
 b=lkMvXTIYbyJitHcrlZY2khDh+Zqnl5mKERnWt8v/qmCzgj3nLrdAEKTn
 2Ukp2cV2TMedONjC9aoy1lDdQODMxQtlR87aq+u8Vq+e3IHVkdaJ2eZV0
 +hnjU39daHKRefjBesYP9PoG+dU81jQu4IOzmtzn3zNgIaXOgeXKPiw3g
 BxN5LLMRNKPhAlwuy6HGAxV6abSpf1S0kwgP5a2BUUEXJTy4E0qisGHZC
 qZD/Vu4O5tJ5LTmWCZNV1dKpWYH/Ho6iUEuTRM92oslLHImw5f+dTmKyI
 N4aow//UDV24ReyiBxN7R8w3Rq2kpGqsRXL6IEubamfnoAc8HTck3SVFq w==;
X-CSE-ConnectionGUID: FozE5icuRV+IrjImBtWrZA==
X-CSE-MsgGUID: CuddopwNS5WshFTq2FwD0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="37564141"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; d="scan'208";a="37564141"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 03:28:43 -0800
X-CSE-ConnectionGUID: X/Yevj0VQ8KUO9ShoOtb2A==
X-CSE-MsgGUID: XZ+14qdCScmyNhPMstuaNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="107680168"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 21 Jan 2025 03:28:41 -0800
Date: Tue, 21 Jan 2025 19:48:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, imammedo@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3] hw/i386/cpu: remove default_cpu_version and simplify
Message-ID: <Z4+Jct1P0Tj4tobY@intel.com>
References: <20250116033418.226051-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116033418.226051-1-anisinha@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Sorry for late reply.

On Thu, Jan 16, 2025 at 09:04:18AM +0530, Ani Sinha wrote:
> Date: Thu, 16 Jan 2025 09:04:18 +0530
> From: Ani Sinha <anisinha@redhat.com>
> Subject: [PATCH v3] hw/i386/cpu: remove default_cpu_version and simplify
> X-Mailer: git-send-email 2.45.2
> 
> commit 0788a56bd1ae3 ("i386: Make unversioned CPU models be aliases")
> introduced 'default_cpu_version' for PCMachineClass. This created three
> categories of CPU models:
>  - Most unversioned CPU models would use version 1 by default.
>  - For machines 4.0.1 and older that do not support cpu model aliases, a
>    special default_cpu_version value of CPU_VERSION_LEGACY is used.
>  - It was thought that future machines would use the latest value of cpu
>    versions corresponding to default_cpu_version value of
>    CPU_VERSION_LATEST [1].
> 
> All pc machines still use the default cpu version of 1 for
> unversioned cpu models. CPU_VERSION_LATEST is a moving target and
> changes with time. Therefore, if machines use CPU_VERSION_LATEST, it would
> mean that over a period of time, for the same machine type, the cpu version
> would be different depending on what is latest at that time. This would
> break guests even when they use a constant machine type. Therefore, for
> pc machines, use of CPU_VERSION_LATEST is not possible. Currently, only
> microvms use CPU_VERSION_LATEST.
> 
> This change cleans up the complicated logic around default_cpu_version
> including getting rid of default_cpu_version property itself. A couple of new
> flags are introduced, one for the legacy model for machines 4.0.1 and older
> and other for microvms. For older machines, a new pc machine property is
> introduced that separates pc machine versions 4.0.1 and older from the newer
> machines. 4.0.1 and older machines are scheduled to be deleted towards
> end of 2025 since they would be 6 years old by then. At that time, we can
> remove all logic around legacy cpus. Microvms are the only machines that
> continue to use the latest cpu version. If this changes later, we can
> remove all logic around x86_cpu_model_last_version(). Default cpu version
> for unversioned cpu models is hardcoded to the value 1 and applies
> unconditionally for all pc machine types of version 4.1 and above.
> 
> This change also removes all complications around CPU_VERSION_AUTO
> including removal of the value itself.

I like the idea to remove CPU_VERSION_AUTO. Though this patch introduces
2 more new static variables ("use_legacy_cpu" and "use_last_cpu_version"),
as you said, once 4.0.1 and older machines are removed, it's easy to
clean up "use_legacy_cpu".

> 1) See commit dcafd1ef0af227 ("i386: Register versioned CPU models")
> 
> CC: imammedo@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---

[snip]

> -void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
> +void x86_legacy_cpus_init(X86MachineState *x86ms)
> +{
> +    machine_uses_legacy_cpu();
> +    x86_cpus_init(x86ms);
> +}
> +
> +void x86_cpus_init_with_latest_cpu_version(X86MachineState *x86ms)
> +{
> +    x86_cpu_uses_lastest_version();
> +    x86_cpus_init(x86ms);
> +}

Could we simplify it even further, i.e., omit these two new helpers and
just add x86_cpu_uses_lastest_version() and machine_uses_legacy_cpu() to
the initialization of the PC & microvm, e.g.,

--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -458,7 +458,8 @@ static void microvm_machine_state_init(MachineState *machine)

     microvm_memory_init(mms);

-    x86_cpus_init_with_latest_cpu_version(x86ms);
+    x86_cpu_uses_lastest_version();
+    x86_cpus_init(x86ms);

     microvm_devices_init(mms);
 }

and

--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -138,11 +138,10 @@ static inline void pc_init_cpus(MachineState *ms)

     if (pcmc->no_versioned_cpu_model) {
         /* use legacy cpu as it does not support versions */
-        x86_legacy_cpus_init(x86ms);
-    } else {
-        /* use non-legacy cpus */
-        x86_cpus_init(x86ms);
+        machine_uses_legacy_cpu();
     }
+
+    x86_cpus_init(x86ms);
 }

 /* ioapic.c */

[snip]

> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index a558705cb9..ad43a233d8 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -92,9 +92,6 @@ struct PCMachineClass {
>  
>      /* Compat options: */
>  
> -    /* Default CPU model version.  See x86_cpu_set_default_version(). */
> -    int default_cpu_version;
> -
>      /* ACPI compat: */
>      bool has_acpi_build;
>      int pci_root_uid;
> @@ -125,11 +122,29 @@ struct PCMachineClass {
>       * check for memory.
>       */
>      bool broken_32bit_mem_addr_check;
> +
> +    /* whether the machine supports versioned cpu models */
> +    bool no_versioned_cpu_model;
>  };
>  
>  #define TYPE_PC_MACHINE "generic-pc-machine"
>  OBJECT_DECLARE_TYPE(PCMachineState, PCMachineClass, PC_MACHINE)
>  
> +static inline void pc_init_cpus(MachineState *ms)

I think there's no need to declare as `inline`.

> +{
> +    X86MachineState *x86ms = X86_MACHINE(ms);
> +    PCMachineState *pcms = PC_MACHINE(ms);
> +    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
> +
> +    if (pcmc->no_versioned_cpu_model) {
> +        /* use legacy cpu as it does not support versions */
> +        x86_legacy_cpus_init(x86ms);
> +    } else {
> +        /* use non-legacy cpus */
> +        x86_cpus_init(x86ms);
> +    }
> +}
> +
>  /* ioapic.c */

As my comment above, we can just call machine_uses_legacy_cpu()
if pcmc->no_versioned_cpu_model is true.

[snip]

> -/*
> - * We resolve CPU model aliases using -v1 when using "-machine
> - * none", but this is just for compatibility while libvirt isn't
> - * adapted to resolve CPU model versions before creating VMs.
> - * See "Runnability guarantee of CPU models" at
> - * docs/about/deprecated.rst.
> - */
> -X86CPUVersion default_cpu_version = 1;
> +static bool use_legacy_cpu;
> +void machine_uses_legacy_cpu(void)

What about this name, "x86_cpu_set_legacy_version"?

> +{
> +    use_legacy_cpu = true;
> +}
>  
> -void x86_cpu_set_default_version(X86CPUVersion version)
> +static bool use_last_cpu_version;

Maybe "use_lastest_cpu"? Keep it in the same style as "use_legacy_cpu".

> +void x86_cpu_uses_lastest_version(void)

Similarly, What about "x86_cpu_set_latest_version"?

>  {
> -    /* Translating CPU_VERSION_AUTO to CPU_VERSION_AUTO doesn't make sense */
> -    assert(version != CPU_VERSION_AUTO);
> -    default_cpu_version = version;
> +    use_last_cpu_version = true;
>  }
>  
>  static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
> @@ -5376,14 +5375,11 @@ static X86CPUVersion x86_cpu_model_last_version(const X86CPUModel *model)
>  /* Return the actual version being used for a specific CPU model */
>  static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *model)
>  {
> -    X86CPUVersion v = model->version;
> -    if (v == CPU_VERSION_AUTO) {
> -        v = default_cpu_version;
> -    }
> -    if (v == CPU_VERSION_LATEST) {
> +    if (use_last_cpu_version) {
>          return x86_cpu_model_last_version(model);
>      }
> -    return v;
> +
> +    return model->version;
>  }
>  
>  static const Property max_x86_cpu_properties[] = {
> @@ -5987,6 +5983,12 @@ static char *x86_cpu_class_get_alias_of(X86CPUClass *cc)
>      if (!cc->model || !cc->model->is_alias) {
>          return NULL;
>      }
> +
> +    if (use_legacy_cpu) {
> +        /* legacy cpu models do not support cpu aliases */
> +        return NULL;
> +    }
> +
>      version = x86_cpu_model_resolve_version(cc->model);
>      if (version <= 0) {

I understand this non-NULL check is origianl for legacy CPU version.
So it's also necessary to remove it, or convert it to "assert(version)"?

>          return NULL;
> @@ -6004,11 +6006,7 @@ static void x86_cpu_list_entry(gpointer data, gpointer user_data)
>      g_autofree char *model_id = x86_cpu_class_get_model_id(cc);
>  
>      if (!desc && alias_of) {
> -        if (cc->model && cc->model->version == CPU_VERSION_AUTO) {
> -            desc = g_strdup("(alias configured by machine type)");
> -        } else {
>              desc = g_strdup_printf("(alias of %s)", alias_of);
> -        }
>      }
>      if (!desc && cc->model && cc->model->note) {
>          desc = g_strdup_printf("%s [%s]", model_id, cc->model->note);
> @@ -6115,7 +6113,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
>       * Old machine types won't report aliases, so that alias translation
>       * doesn't break compatibility with previous QEMU versions.
>       */
> -    if (default_cpu_version != CPU_VERSION_LEGACY) {
> +    if (!use_legacy_cpu) {
>          info->alias_of = x86_cpu_class_get_alias_of(cc);
>      }

Do we need the check of "!use_legacy_cpu"?

x86_cpu_class_get_alias_of() returns NULL if use_legacy_cpu is true.

Thanks,
Zhao


