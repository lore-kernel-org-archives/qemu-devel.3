Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A9AC47DDF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 09:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUkaN-0002uR-4U; Tue, 30 Jan 2024 04:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUkaK-0002uI-1m
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:39:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUkaG-00079Q-PO
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706607549;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tA9Of5Sa/Og1+gCuyu7b5Rx1q+qf5Gy0ffsfO4cYnoM=;
 b=Me2flSLNbswF7/bIrN84xkcLpc39ogy1FsMqPGhUxTOhPLgW3TOYoHfn16IwNd9ol5vyvj
 eOMyCr4mKy0drhzvKOwPzUzJxZkCDMwOSfJgp5Fth+DRfKe92tD44f0g/0bl5ccB2hc5QM
 Kamu4+u/pp2OXy9DvcOUvcpFo+eAcJo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-ciJh6RQfMzK_H8vf2sR0lw-1; Tue, 30 Jan 2024 04:39:07 -0500
X-MC-Unique: ciJh6RQfMzK_H8vf2sR0lw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B03CF8493E8
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 09:39:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCE3A494;
 Tue, 30 Jan 2024 09:39:05 +0000 (UTC)
Date: Tue, 30 Jan 2024 09:39:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <ZbjDtytv-_-Bz4-S@redhat.com>
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125072214.318382-4-aharivel@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 25, 2024 at 08:22:14AM +0100, Anthony Harivel wrote:
> Starting with the "Sandy Bridge" generation, Intel CPUs provide a RAPL
> interface (Running Average Power Limit) for advertising the accumulated
> energy consumption of various power domains (e.g. CPU packages, DRAM,
> etc.).
> 
> The consumption is reported via MSRs (model specific registers) like
> MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are
> 64 bits registers that represent the accumulated energy consumption in
> micro Joules. They are updated by microcode every ~1ms.
> 
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
> 
> To overcome the problem that reading the RAPL MSR requires priviliged
> access, a socket communication between QEMU and the qemu-vmsr-helper is
> mandatory. You can specified the socket path in the parameter.
> 
> This feature is activated with -accel kvm,rapl=true,path=/path/sock.sock
> 
> Actual limitation:
> - Works only on Intel host CPU because AMD CPUs are using different MSR
>   adresses.
> 
> - Only the Package Power-Plane (MSR_PKG_ENERGY_STATUS) is reported at
>   the moment.
> 
> Signed-off-by: Anthony Harivel <aharivel@redhat.com>
> ---
>  accel/kvm/kvm-all.c           |  27 +++
>  docs/specs/index.rst          |   1 +
>  docs/specs/rapl-msr.rst       | 133 +++++++++++++
>  include/sysemu/kvm_int.h      |  17 ++
>  target/i386/cpu.h             |   8 +
>  target/i386/kvm/kvm.c         | 348 ++++++++++++++++++++++++++++++++++
>  target/i386/kvm/meson.build   |   1 +
>  target/i386/kvm/vmsr_energy.c | 295 ++++++++++++++++++++++++++++
>  target/i386/kvm/vmsr_energy.h |  87 +++++++++
>  9 files changed, 917 insertions(+)
>  create mode 100644 docs/specs/rapl-msr.rst
>  create mode 100644 target/i386/kvm/vmsr_energy.c
>  create mode 100644 target/i386/kvm/vmsr_energy.h
> 

> @@ -2509,6 +2558,265 @@ static void register_smram_listener(Notifier *n, void *unused)
>                                   &smram_address_space, 1, "kvm-smram");
>  }
>  
> +static void *kvm_msr_energy_thread(void *data)
> +{
> +    KVMState *s = data;
> +    struct KVMMsrEnergy *vmsr = &s->msr_energy;
> +
> +    g_autofree package_energy_stat *pkg_stat = NULL;
> +    g_autofree thread_stat *thd_stat = NULL;
> +    g_autofree pid_t *thread_ids = NULL;
> +    g_autofree CPUState *cpu = NULL;
> +    unsigned int maxpkgs, maxcpus, maxticks;
> +    g_autofree unsigned int *vpkgs_energy_stat = NULL;
> +    unsigned int num_threads = 0;
> +    unsigned int tmp_num_threads = 0;
> +    pid_t pid;
> +
> +    X86CPUTopoIDs topo_ids;
> +
> +
> +    rcu_register_thread();
> +
> +    /* Get QEMU PID*/
> +    pid = getpid();
> +
> +    /* Nb of CPUS per packages */
> +    maxcpus = vmsr_get_maxcpus(0);
> +
> +    /* Nb of Physical Packages on the system */
> +    maxpkgs = vmsr_get_max_physical_package(maxcpus);

This function can fail so this needs to be checked & reported.

> +
> +    /* Those MSR values should not change as well */
> +    vmsr->msr_unit  = vmsr_read_msr(MSR_RAPL_POWER_UNIT, 0, pid,
> +                                    s->msr_energy.socket_path);
> +    vmsr->msr_limit = vmsr_read_msr(MSR_PKG_POWER_LIMIT, 0, pid,
> +                                    s->msr_energy.socket_path);
> +    vmsr->msr_info  = vmsr_read_msr(MSR_PKG_POWER_INFO, 0, pid,
> +                                    s->msr_energy.socket_path);

This function can fail for a variety of reasons, most especially if someone
gave an incorrect socket path, or if the daemon is not running. This is not
getting diagnosed, and even if we try to report it here, we're in a background
thread at this point.

I think we need to connect and report errors before even starting this
thread, so that QEMU startup gets aborted upon configuration error.

> +
> +    /* Allocate memory for each package energy status */
> +    pkg_stat = (package_energy_stat *)
> +        g_new0(package_energy_stat, maxpkgs);
> +
> +    /* Pre-allocate memory for thread stats */
> +    thd_stat = g_new0(thread_stat, 1);
> +
> +    /* Pre-allocate memory for holding Virtual Package Energy counter */
> +    vpkgs_energy_stat = g_new0(unsigned int, vmsr->sockets);
> +
> +    /*
> +     * Max numbers of ticks per package
> +     * time in second * number of ticks/second * Number of cores / package
> +     * ex: for 100 ticks/second/CPU, 12 CPUs per Package gives 1200 ticks max
> +     */
> +    maxticks = (MSR_ENERGY_THREAD_SLEEP_US / 1000000)
> +                    * sysconf(_SC_CLK_TCK) * maxcpus;
> +
> +    while (true) {
> +        /* Get all qemu threads id */
> +        thread_ids = vmsr_get_thread_ids(pid, &num_threads);
> +
> +        if (thread_ids == NULL) {
> +            goto clean;
> +        }
> +
> +        if (tmp_num_threads < num_threads) {
> +            thd_stat = g_renew(thread_stat, thd_stat, num_threads);
> +        }
> +
> +        tmp_num_threads = num_threads;
> +
> +        /* Populate all the thread stats */
> +        for (int i = 0; i < num_threads; i++) {
> +            thd_stat[i].utime = g_new0(unsigned long long, 2);
> +            thd_stat[i].stime = g_new0(unsigned long long, 2);
> +            thd_stat[i].thread_id = thread_ids[i];
> +            vmsr_read_thread_stat(&thd_stat[i], pid, 0);

It is non-obvious that the 3rd parameter here is an index into
the utime & stime array. This function would be saner to review
if called as:

            vmsr_read_thread_stat(pid,
	                          thd_stat[i].thread_id,
	                          &thd_stat[i].utime[0],
	                          &thd_stat[i].stime[0],
	                          &thd_stat[i].cpu_id);

so we see what are input parameters and what are output parameters.

Also this method can fail, eg if the thread has exited already,
so we need to take that into account and stop trying to get info
for that thread in later code. eg by setting 'thread_id' to 0
and then skipping any thread_id == 0 later.


> +            thd_stat[i].numa_node_id = numa_node_of_cpu(thd_stat[i].cpu_id);
> +        }
> +
> +        /* Retrieve all packages power plane energy counter */
> +        for (int i = 0; i <= maxpkgs; i++) {
> +            for (int j = 0; j < num_threads; j++) {
> +                /*
> +                 * Use the first thread we found that ran on the CPU
> +                 * of the package to read the packages energy counter
> +                 */
> +                if (thd_stat[j].numa_node_id == i) {

'i' is a CPU ID value, while 'numa_node_id' is a NUMA node ID value.
I don't think it is semantically valid to compare them for equality.

I'm not sure the NUMA node is even relevant, since IIUC from the docs
earlier, the power values are scoped per package, which would mean per
CPU socket.

> +                    pkg_stat[i].e_start =
> +                    vmsr_read_msr(MSR_PKG_ENERGY_STATUS, i, pid,
> +                                  s->msr_energy.socket_path);

> +                    break;
> +                }
> +            }
> +        }
> +
> +        /* Sleep a short period while the other threads are working */
> +        usleep(MSR_ENERGY_THREAD_SLEEP_US);
> +
> +        /*
> +         * Retrieve all packages power plane energy counter
> +         * Calculate the delta of all packages
> +         */
> +        for (int i = 0; i <= maxpkgs; i++) {
> +            for (int j = 0; j < num_threads; j++) {
> +                /*
> +                 * Use the first thread we found that ran on the CPU
> +                 * of the package to read the packages energy counter
> +                 */
> +                if (thd_stat[j].numa_node_id == i) {
> +                    pkg_stat[i].e_end =
> +                       vmsr_read_msr(MSR_PKG_ENERGY_STATUS,
> +                                     thd_stat[j].cpu_id,
> +                                     thd_stat[j].thread_id,
> +                                     s->msr_energy.socket_path);
> +                    /*
> +                     * Prevent the case we have migrate the VM
> +                     * during the sleep period or any other cases
> +                     * were energy counter might be lower after
> +                     * the sleep.
> +                     */
> +                    if (pkg_stat[i].e_end > pkg_stat[i].e_start) {
> +                        pkg_stat[i].e_delta =
> +                            pkg_stat[i].e_end - pkg_stat[i].e_start;
> +                    } else {
> +                        pkg_stat[i].e_delta = 0;
> +                    }
> +                    break;
> +                }
> +            }
> +        }
> +
> +        /* Delta of ticks spend by each thread between the sample */
> +        for (int i = 0; i < num_threads; i++) {
> +            if (vmsr_read_thread_stat(&thd_stat[i], pid, 1) != 0) {

Here we fetch the thread 'cpu_id' again. What is expected behaviour
if 'cpu_id' has changed since we read it earlier ? The delta ticks
calculation will be OK is cpu_is is still within the same package
as earlier, but if it moved to another package it is not valid.



> +                /*
> +                 * We don't count the dead thread
> +                 * i.e threads that existed before the sleep
> +                 * and not anymore
> +                 */
> +                thd_stat[i].delta_ticks = 0;
> +            } else {
> +                vmsr_delta_ticks(thd_stat, i);
> +            }
> +        }
> +
> +        /*
> +         * Identify the vCPU threads
> +         * Calculate the Number of vCPU per package
> +         */
> +        CPU_FOREACH(cpu) {
> +            for (int i = 0; i < num_threads; i++) {
> +                if (cpu->thread_id == thd_stat[i].thread_id) {
> +                    thd_stat[i].is_vcpu = true;
> +                    thd_stat[i].vcpu_id = cpu->cpu_index;
> +                    pkg_stat[thd_stat[i].numa_node_id].nb_vcpu++;

A numa node isn't a package AFAICT.

> +                    thd_stat[i].acpi_id = kvm_arch_vcpu_id(cpu);
> +                    break;
> +                }
> +            }
> +        }
> +
> +        /* Retrieve the virtual package number of each vCPU */
> +        for (int i = 0; i < vmsr->x86_cpu_list->len; i++) {
> +            for (int j = 0; j < num_threads; j++) {
> +                if ((thd_stat[j].acpi_id == vmsr->x86_cpu_list->cpus[i].arch_id)
> +                    && (thd_stat[j].is_vcpu == true)) {
> +                    x86_topo_ids_from_apicid(thd_stat[j].acpi_id,
> +                        &vmsr->topo_info, &topo_ids);
> +                    thd_stat[j].vpkg = topo_ids.pkg_id;
> +                }
> +            }
> +        }
> +
> +        /* Calculate the total energy of all non-vCPU thread */
> +        for (int i = 0; i < num_threads; i++) {
> +            double temp;
> +            if ((thd_stat[i].is_vcpu != true) &&
> +                (thd_stat[i].delta_ticks > 0)) {
> +                temp = vmsr_get_ratio(pkg_stat, thd_stat, maxticks, i);
> +                pkg_stat[thd_stat[i].numa_node_id].e_ratio
> +                    += (uint64_t)lround(temp);
> +            }
> +        }
> +
> +        /* Calculate the ratio per non-vCPU thread of each package */
> +        for (int i = 0; i <= maxpkgs; i++) {
> +            if (pkg_stat[i].nb_vcpu > 0) {
> +                pkg_stat[i].e_ratio = pkg_stat[i].e_ratio / pkg_stat[i].nb_vcpu;
> +            }
> +        }
> +
> +        /*
> +         * Calculate the energy for each Package:
> +         * Energy Package = sum of each vCPU energy that belongs to the package
> +         */
> +        for (int i = 0; i < num_threads; i++) {
> +            double temp;
> +
> +            if ((thd_stat[i].is_vcpu == true) && \
> +                    (thd_stat[i].delta_ticks > 0)) {
> +                temp = vmsr_get_ratio(pkg_stat, thd_stat, maxticks, i);
> +
> +                vpkgs_energy_stat[thd_stat[i].vpkg] += (uint64_t)lround(temp);
> +                vpkgs_energy_stat[thd_stat[i].vpkg] +=
> +                    pkg_stat[thd_stat[i].numa_node_id].e_ratio;
> +            }
> +        }
> +
> +        /*
> +         * Finally populate the vmsr register of each vCPU with the total
> +         * package value to emulate the real hardware where each CPU return the
> +         * value of the package it belongs.
> +         */
> +        for (int i = 0; i < num_threads; i++) {
> +            if ((thd_stat[i].is_vcpu == true) && \
> +                    (thd_stat[i].delta_ticks > 0)) {
> +                vmsr->msr_value[thd_stat[i].vcpu_id] = \
> +                                            vpkgs_energy_stat[thd_stat[i].vpkg];
> +          }
> +        }
> +
> +        /* Zero out the memory */
> +        for (int i = 0; i < num_threads; i++) {
> +            memset(thd_stat[i].utime, 0, 2 * sizeof(unsigned long long));
> +            memset(thd_stat[i].stime, 0, 2 * sizeof(unsigned long long));
> +        }
> +        memset(thd_stat, 0, num_threads * sizeof(thread_stat));
> +        memset(thread_ids, 0, sizeof(pid_t));
> +    }
> +
> +clean:
> +    rcu_unregister_thread();
> +    return NULL;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


