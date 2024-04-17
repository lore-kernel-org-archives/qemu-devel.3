Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C2DC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 09:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx1ya-0003wZ-H9; Wed, 17 Apr 2024 05:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rx1yW-0003wG-P5
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 05:53:10 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rx1yT-0006bv-Me
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 05:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713347585; x=1744883585;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Gmiv8CJvAfsyeWL890oM0jANwqJ7IahMpJswBixOBTI=;
 b=clDw7BVqdccAOfHAfB97yDbiiixfl/BTZKu+k++8LL6018uMtL+oJRmH
 ZoRHwQph2f8V/zsXL2F/AGFKVbgxduGwmVvcHr4HnXj39DerUKbA99EMZ
 dLuSjXAr7AsrAOFgfN6LZM2oCaXy+ubgRz+JT6vqhw63e1Yn0IjF+cqUQ
 1gEf+b/HIht7fXv/YYKWYDSbbn4xBldFONj5sSWHGlsj0bHYylQTFXRuz
 Fh0BuH2syWsQo1jB6aofmMuKu+XkVyuZ04Tl9Ugal5n/LO40+JdpJy1pO
 tmlDa3+jmTdkO9kaUkdRhJ32gKPwf5dueGMyzvWwTvmHHqntTPLQuKC50 w==;
X-CSE-ConnectionGUID: LXDdg7rESJmkdC0k2iqa7g==
X-CSE-MsgGUID: EZlXO1h8RqK7Y3957UFT2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="34215618"
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; d="scan'208";a="34215618"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2024 02:53:01 -0700
X-CSE-ConnectionGUID: jkQv68NbTdWldSCFn9gYNA==
X-CSE-MsgGUID: egQfIvcNSjqw1H4CIkS1Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,208,1708416000"; d="scan'208";a="27213075"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 17 Apr 2024 02:52:59 -0700
Date: Wed, 17 Apr 2024 18:07:02 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, berrange@redhat.com,
 qemu-devel@nongnu.org, vchundur@redhat.com, rjarry@redhat.com
Subject: Re: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <Zh+fRliUJ8sPcOpD@intel.com>
References: <20240411121434.253353-1-aharivel@redhat.com>
 <20240411121434.253353-4-aharivel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411121434.253353-4-aharivel@redhat.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Anthony,

May I ask what your usage scenario is? Is it to measure Guest's energy
consumption and to charged per watt consumed? ;-)

On Thu, Apr 11, 2024 at 02:14:34PM +0200, Anthony Harivel wrote:
> Date: Thu, 11 Apr 2024 14:14:34 +0200
> From: Anthony Harivel <aharivel@redhat.com>
> Subject: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
> 
> Starting with the "Sandy Bridge" generation, Intel CPUs provide a RAPL
> interface (Running Average Power Limit) for advertising the accumulated
> energy consumption of various power domains (e.g. CPU packages, DRAM,
> etc.).
>
> The consumption is reported via MSRs (model specific registers) like
> MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are
> 64 bits registers that represent the accumulated energy consumption in
> micro Joules. They are updated by microcode every ~1ms.

What is your current target platform?

On future Xeon platforms (EMR and beyond) RAPL will support TPMI (an MMIO
interface) and the TPMI based RAPL will be preferred in the future as
well:
* TPMI doc: https://github.com/intel/tpmi_power_management
* TPMI based RAPL driver: drivers/powercap/intel_rapl_tpmi.c

So do you have the plan to support RAPL-TPMI?
 
> For now, KVM always returns 0 when the guest requests the value of
> these MSRs. Use the KVM MSR filtering mechanism to allow QEMU handle
> these MSRs dynamically in userspace.
> 
> To limit the amount of system calls for every MSR call, create a new
> thread in QEMU that updates the "virtual" MSR values asynchronously.
> 
> Each vCPU has its own vMSR to reflect the independence of vCPUs. The
> thread updates the vMSR values with the ratio of energy consumed of
> the whole physical CPU package the vCPU thread runs on and the
> thread's utime and stime values.
> 
> All other non-vCPU threads are also taken into account. Their energy
> consumption is evenly distributed among all vCPUs threads running on
> the same physical CPU package.

The package energy consumption includes core part and uncore part, where
uncore part consumption may not be able to be scaled based on vCPU
runtime ratio.

When the uncore part consumption is small, the error in this part is
small, but if it is large, then the error generated by scaling by vCPU
runtime will be large.

May I ask what your usage scenario is? Is there significant uncore
consumption (e.g. GPU)?

Also, I think of a generic question is whether the error in this
calculation is measurable? Like comparing the RAPL status of the same
workload on Guest and bare metal to check the error.

IIUC, this calculation is highly affected by native/sibling Guests,
especially in cloud scenarios where there are multiple Guests, the
accuracy of this algorithm needs to be checked.

> To overcome the problem that reading the RAPL MSR requires priviliged
> access, a socket communication between QEMU and the qemu-vmsr-helper is
> mandatory. You can specified the socket path in the parameter.
> 
> This feature is activated with -accel kvm,rapl=true,path=/path/sock.sock

Based on the above comment, I suggest to rename this option as "rapl-msr"
to distinguish it from rapl-tpmi.

In addition, RAPL is basically a CPU feature, I think it would be more
appropriate to make it as a x86 CPU's property.

Your RAPL support actually provides a framework for assisting KVM
emulation in userspace, so this informs other feature support (maybe model
specific, or architectural) in the future. Enabling/disabling CPU features
via -cpu looks more natural.

[snip]

> +High level implementation
> +-------------------------
> +
> +In order to update the value of the virtual MSR, a QEMU thread is created.
> +The thread is basically just an infinity loop that does:
> +
> +1. Snapshot of the time metrics of all QEMU threads (Time spent scheduled in
> +   Userspace and System)
>
> +2. Snapshot of the actual MSR_PKG_ENERGY_STATUS counter of all packages where
> +   the QEMU threads are running on.
> +
> +3. Sleep for 1 second - During this pause the vcpu and other non-vcpu threads
> +   will do what they have to do and so the energy counter will increase.
> +
> +4. Repeat 2. and 3. and calculate the delta of every metrics representing the
> +   time spent scheduled for each QEMU thread *and* the energy spent by the
> +   packages during the pause.
> +
> +5. Filter the vcpu threads and the non-vcpu threads.
> +
> +6. Retrieve the topology of the Virtual Machine. This helps identify which
> +   vCPU is running on which virtual package.
> +
> +7. The total energy spent by the non-vcpu threads is divided by the number
> +   of vcpu threads so that each vcpu thread will get an equal part of the
> +   energy spent by the QEMU workers.
> +
> +8. Calculate the ratio of energy spent per vcpu threads.
> +
> +9. Calculate the energy for each virtual package.
> +
> +10. The virtual MSRs are updated for each virtual package. Each vCPU that
> +    belongs to the same package will return the same value when accessing the
> +    the MSR.
> +
> +11. Loop back to 1.
> +
> +Ratio calculation
> +-----------------
> +
> +In Linux, a process has an execution time associated with it. The scheduler is
> +dividing the time in clock ticks. The number of clock ticks per second can be
> +found by the sysconf system call. A typical value of clock ticks per second is
> +100. So a core can run a process at the maximum of 100 ticks per second. If a
> +package has 4 cores, 400 ticks maximum can be scheduled on all the cores
> +of the package for a period of 1 second.
> +
> +The /proc/[pid]/stat [#b]_ is a sysfs file that can give the executed time of a
> +process with the [pid] as the process ID. It gives the amount of ticks the
> +process has been scheduled in userspace (utime) and kernel space (stime).
> +

I understand tick would ignore frequency changes, e.g., HWP's auto-pilot
or turbo boost. All these CPU frequency change would impact on core energy
consumption.

I think the better way would be to use APERF counter, but unfortunately it
lacks virtualization support (for Intel).

Due to such considerations, it may be more worthwhile to evaluate the
accuracy of this tick-based algorithm.

[snip]

> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index e68cbe929302..3de69caa229e 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c

[snip]

> +static void *kvm_msr_energy_thread(void *data)
> +{
> +    KVMState *s = data;
> +    struct KVMMsrEnergy *vmsr = &s->msr_energy;
> +
> +    g_autofree package_energy_stat *pkg_stat = NULL;
> +    g_autofree thread_stat *thd_stat = NULL;
> +    g_autofree pid_t *thread_ids = NULL;
> +    g_autofree CPUState *cpu = NULL;
> +    g_autofree unsigned int *vpkgs_energy_stat = NULL;
> +    unsigned int num_threads = 0;
> +    unsigned int tmp_num_threads = 0;

[snip]

> +        /* Sleep a short period while the other threads are working */
> +        usleep(MSR_ENERGY_THREAD_SLEEP_US);

Is it possible to passively read the energy status? i.e. access the Host
MSR and calculate the energy consumption for the Guest when the Guest
triggers the relevant exit.

I think this might make the error larger, but not sure the error would
be so large as to be unacceptable.

[snip]

> +        /* Retrieve the virtual package number of each vCPU */
> +        for (int i = 0; i < vmsr->x86_cpu_list->len; i++) {
> +            for (int j = 0; j < num_threads; j++) {
> +                if ((thd_stat[j].acpi_id == vmsr->x86_cpu_list->cpus[i].arch_id)
> +                    && (thd_stat[j].is_vcpu == true)) {
> +                    x86_topo_ids_from_apicid(thd_stat[j].acpi_id,
> +                        &vmsr->topo_info, &topo_ids);
> +                    thd_stat[j].vpkg_id = topo_ids.pkg_id;
> +                }
> +            }
> +        }

We lack package instances as well as MSR topology, so we have to deal
with this pain...

Similarly, my attempt at other package/die level MSRs [1] is to only
allow Guest to set a package/die.

But I think that in the future with QOM-topo [2] (i.e. creating package/
die instances), MSR topology can have an easier implementation, though,
looks there's a long way to go!

[1]: https://lore.kernel.org/qemu-devel/20240203093054.412135-4-zhao1.liu@linux.intel.com/
[2]: https://lore.kernel.org/qemu-devel/20231130144203.2307629-1-zhao1.liu@linux.intel.com/

> +        /* Calculate the total energy of all non-vCPU thread */
> +        for (int i = 0; i < num_threads; i++) {
> +            double temp;
> +            if ((thd_stat[i].is_vcpu != true) &&
> +                (thd_stat[i].delta_ticks > 0)) {
> +                temp = vmsr_get_ratio(pkg_stat[thd_stat[i].pkg_id].e_delta,
> +                    thd_stat[i].delta_ticks,
> +                    vmsr->host_topo.maxticks[thd_stat[i].pkg_id]);
> +                pkg_stat[thd_stat[i].pkg_id].e_ratio
> +                    += (uint64_t)lround(temp);
> +            }
> +        }
> +

[snip]

> +static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
> +{
> +    struct KVMMsrEnergy *r = &s->msr_energy;
> +    int ret = 0;
> +

[snip]

> +    /* Retrieve the number of virtual sockets */
> +    r->vsockets = ms->smp.sockets;

RAPL's package domain is special:
 * When there's no die, it's package-scope.
 * When there's die level, it's die-scope.

In SDM vol.3, char 15.10 PLATFORM SPECIFIC POWER MANAGEMENT SUPPORT, it
said: Package domain is the processor die.

So if a Guest has die level, thers MSRs should be shared in a die. Thus
I guess the energy consumption status should also be distributed based on
the die number.

> +    /* Allocate register memory (MSR_PKG_STATUS) for each vcpu */
> +    r->msr_value = g_new0(uint64_t, r->vcpus);
> +
> +    /* Retrieve the CPUArchIDlist */
> +    r->x86_cpu_list = x86_possible_cpu_arch_ids(ms);
> +

[snip]

> +int is_rapl_enabled(void)
> +{
> +    const char *path = "/sys/class/powercap/intel-rapl/enabled";

This field does not ensure the existence of RAPL MSRs since TPMI would
also enable this field. (See powercap_register_control_type() in
drivers/powercap/intel_rapl_{msr,tpmi}.c)

We can read RAPL MSRs directly. If we get 0 or failure, then there's no
RAPL MSRs on Host.

> +    FILE *file = fopen(path, "r");
> +    int value = 0;
> +
> +    if (file != NULL) {
> +        if (fscanf(file, "%d", &value) != 1) {
> +            error_report("INTEL RAPL not enabled");
> +        }
> +        fclose(file);
> +    } else {
> +        error_report("Error opening %s", path);
> +    }
> +
> +    return value;
> +}

[snip]

> +/* Get the physical package id from a given cpu id */
> +int vmsr_get_physical_package_id(int cpu_id)
> +{
> +    g_autofree char *file_contents = NULL;
> +    g_autofree char *file_path = NULL;
> +    int package_id = -1;
> +    gsize length;
> +
> +    file_path = g_strdup_printf("/sys/devices/system/cpu/cpu%d\
> +        /topology/physical_package_id", cpu_id);

Similarly, based on the topological properties of RAPL, it is more
accurate to also consider the die_id.

Currently, only CLX-AP has multiple dies. So, we either have to put a
limit on the Host's CPU model or consider the topology of the die here
as well. I think the latter is a more general approach.

> +
> +    if (!g_file_get_contents(file_path, &file_contents, &length, NULL)) {
> +        goto out;
> +    }
> +
> +    package_id = atoi(file_contents);
> +
> +out:
> +    return package_id;
> +}
> +

Regards,
Zhao


