Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD3AC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXJu-0004Tn-GV; Mon, 29 Jan 2024 14:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUXJp-0004Gx-6b
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:29:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUXJm-0003Yu-6r
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706556556;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=JycBLo7Kk7MUf2tuVN1zCmJxgyzqiChKgGD5y0hN6Do=;
 b=BdTOaTDBnSpqgQWt46Fd6pNJ4/8cWSMumiRC9JPntJOXDjWhXf89Ud4x0d1VjjQUCaB7Xc
 IfxtC+lN4VoBkFvIoY2kooTmoicq/HkJaigkOOl8/kFMCKAaAV+8f40j4WQudiDDnNTTxK
 kpHnDXQTrG79Ma7g/FnfKRcv8D3IPNk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-e3MuZTP0MDayN7igun2-LA-1; Mon, 29 Jan 2024 14:29:14 -0500
X-MC-Unique: e3MuZTP0MDayN7igun2-LA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0EA28353E1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 19:29:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB080AD1;
 Mon, 29 Jan 2024 19:29:12 +0000 (UTC)
Date: Mon, 29 Jan 2024 19:29:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <Zbf8hradcHeeEXae@redhat.com>
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
> diff --git a/docs/specs/rapl-msr.rst b/docs/specs/rapl-msr.rst
> new file mode 100644
> index 000000000000..04d27c198fc0
> --- /dev/null
> +++ b/docs/specs/rapl-msr.rst
> @@ -0,0 +1,133 @@
> +================
> +RAPL MSR support
> +================

> +
> +Current Limitations
> +-------------------
> +
> +- Works only on Intel host CPUs because AMD CPUs are using different MSR
> +  addresses.

The privileged helper program is validating an allow list of MSRs.

If those MSRs are only correct on Intel hosts, then the validation
is incomplete, and it could be allowing unprivileged processes on
AMD hosts to access forbidden MSRS whose address happen to clash
with the Intel RAPL MSRs.

IOW, the privileged helper needs to call cpuid() and validate that
the current host vendor is Intel.

I suspect we also need a feature check of some kind to validate
that the intel processor supports this features, since old ones
definitely didn't, and we shouldn't assume all future ones will
either.

> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 882e37e12c5b..ee2fe8817833 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 76a66246eb72..e6cb315c0a90 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -16,16 +16,22 @@
>  #include "qapi/qapi-events-run-state.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> +#include <math.h>
> +#include <stdint.h>

stdint.h always gets included via osdep.h	

>  #include <sys/ioctl.h>
>  #include <sys/utsname.h>
>  #include <sys/syscall.h>
> +#include <sys/resource.h>
> +#include <sys/time.h>
>  
>  #include <linux/kvm.h>
> +#include <unistd.h>

unistd.h also always gets included via osdep.h

>  #include "standard-headers/asm-x86/kvm_para.h"
>  #include "hw/xen/interface/arch-x86/cpuid.h"
>  
>  #include "cpu.h"
>  #include "host-cpu.h"
> +#include "vmsr_energy.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/hw_accel.h"
>  #include "sysemu/kvm_int.h"

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
> +
> +    /* Those MSR values should not change as well */
> +    vmsr->msr_unit  = vmsr_read_msr(MSR_RAPL_POWER_UNIT, 0, pid,
> +                                    s->msr_energy.socket_path);
> +    vmsr->msr_limit = vmsr_read_msr(MSR_PKG_POWER_LIMIT, 0, pid,
> +                                    s->msr_energy.socket_path);
> +    vmsr->msr_info  = vmsr_read_msr(MSR_PKG_POWER_INFO, 0, pid,
> +                                    s->msr_energy.socket_path);
> +
> +    /* Allocate memory for each package energy status */
> +    pkg_stat = (package_energy_stat *)
> +        g_new0(package_energy_stat, maxpkgs);

Return value of g_new0 shouldn't need casting.

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

This says we're using a thread ID

> +                if (thd_stat[j].numa_node_id == i) {
> +                    pkg_stat[i].e_start =
> +                    vmsr_read_msr(MSR_PKG_ENERGY_STATUS, i, pid,

but here we're using a pid ID, which is the thread ID of the initial
thread.

> +                                  s->msr_energy.socket_path);
> +                    break;
> +                }
> +            }
> +        }

This API design for vmsr_read_msr() is incredibly inefficient.
We're making (maxpkgs * num_threads) calls to vmsr_read_msr(),
and every one of those is opening and closing the socket.

Why isn't QEMU opening the socket once and then sending all
the requests over the same socket ?

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

This is passing the 'cpu_id' field, but in the previous call to
vmsr_read_msr 20 lines earlier, we seemd to pass a value that
was the NUMA node id. 

> +                                     thd_stat[j].thread_id,

This is now passing a thread_id, while previously  we passed the
PID id.

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
> +
> +static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
> +{
> +    struct KVMMsrEnergy *r = &s->msr_energy;
> +
> +    vmsr_init_topo_info(&r->topo_info, ms);
> +
> +    /* Retrieve the number of vCPU */
> +    r->cpus = ms->smp.cpus;
> +
> +    /* Retrieve the number of sockets */
> +    r->sockets = ms->smp.sockets;
> +
> +    /* Allocate register memory (MSR_PKG_STATUS) for each vCPU */
> +    r->msr_value = g_new0(uint64_t, r->cpus);
> +
> +    /* Retrieve the CPUArchIDlist */
> +    r->x86_cpu_list = x86_possible_cpu_arch_ids(ms);
> +
> +    qemu_thread_create(&r->msr_thr, "kvm-msr",
> +                       kvm_msr_energy_thread,
> +                       s, QEMU_THREAD_JOINABLE);
> +
> +    return 0;
> +}
> +
>  int kvm_arch_get_default_type(MachineState *ms)
>  {
>      return 0;
> @@ -2711,6 +3019,46 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>                           strerror(-ret));
>              exit(1);
>          }
> +
> +        if (s->msr_energy.enable == true) {
> +
> +            r = kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
> +                               kvm_rdmsr_rapl_power_unit, NULL);
> +            if (!r) {
> +                error_report("Could not install MSR_RAPL_POWER_UNIT \
> +                                handler: %s",
> +                             strerror(-ret));
> +                exit(1);
> +            }
> +
> +            r = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
> +                               kvm_rdmsr_pkg_power_limit, NULL);
> +            if (!r) {
> +                error_report("Could not install MSR_PKG_POWER_LIMIT \
> +                                handler: %s",
> +                             strerror(-ret));
> +                exit(1);
> +            }
> +
> +            r = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
> +                               kvm_rdmsr_pkg_power_info, NULL);
> +            if (!r) {
> +                error_report("Could not install MSR_PKG_POWER_INFO \
> +                                handler: %s",
> +                             strerror(-ret));
> +                exit(1);
> +            }
> +            r = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
> +                               kvm_rdmsr_pkg_energy_status, NULL);
> +            if (!r) {
> +                error_report("Could not install MSR_PKG_ENERGY_STATUS \
> +                                handler: %s",
> +                             strerror(-ret));
> +                exit(1);
> +            } else {
> +                kvm_msr_energy_thread_init(s, ms);
> +            }
> +        }
>      }
>  
>      return 0;
> diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
> index 84d9143e6029..16010638df69 100644
> --- a/target/i386/kvm/meson.build
> +++ b/target/i386/kvm/meson.build
> @@ -3,6 +3,7 @@ i386_kvm_ss = ss.source_set()
>  i386_kvm_ss.add(files(
>    'kvm.c',
>    'kvm-cpu.c',
> +  'vmsr_energy.c',
>  ))
>  
>  i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
> diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
> new file mode 100644
> index 000000000000..27588630efa4
> --- /dev/null
> +++ b/target/i386/kvm/vmsr_energy.c
> @@ -0,0 +1,295 @@
> +/*
> + * QEMU KVM support -- x86 virtual energy-related MSR.
> + *
> + * Copyright 2023 Red Hat, Inc. 2023
> + *
> + *  Author:
> + *      Anthony Harivel <aharivel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "vmsr_energy.h"
> +#include "qapi/error.h"
> +#include "io/channel.h"
> +#include "io/channel-socket.h"
> +#include "hw/boards.h"
> +
> +#define MAX_PATH_LEN 256
> +#define MAX_LINE_LEN 500
> +
> +static char *compute_default_paths(void)
> +{
> +    g_autofree char *state = qemu_get_local_state_dir();
> +
> +    return g_build_filename(state, "run", "qemu-vmsr-helper.sock", NULL);
> +}
> +
> +static int vmsr_helper_socket_read(QIOChannel *ioc,
> +                                  void *buf, int sz, Error **errp)
> +{
> +    ssize_t r = qio_channel_read_all(ioc, buf, sz, errp);
> +
> +    if (r < 0) {
> +        object_unref(OBJECT(ioc));
> +        ioc = NULL;
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vmsr_helper_socket_write(QIOChannel *ioc,
> +                                   int fd,
> +                                   const void *buf, int sz, Error **errp)
> +{
> +    size_t nfds = (fd != -1);
> +    while (sz > 0) {
> +        struct iovec iov;
> +        ssize_t n_written;
> +
> +        iov.iov_base = (void *)buf;
> +        iov.iov_len = sz;
> +        n_written = qio_channel_writev_full(QIO_CHANNEL(ioc), &iov, 1,
> +                                            nfds ? &fd : NULL, nfds, 0, errp);
> +
> +        if (n_written <= 0) {
> +            assert(n_written != QIO_CHANNEL_ERR_BLOCK);
> +            object_unref(OBJECT(ioc));
> +            ioc = NULL;
> +            return n_written < 0 ? -EINVAL : 0;
> +        }
> +
> +        nfds = 0;
> +        buf += n_written;
> +        sz -= n_written;
> +    }
> +
> +    return 0;
> +}

THis method seems pointless. It is being called with fd == -1.
The caller should just directly call qio_channel_write_all
which will write all data.

> +
> +uint64_t vmsr_read_msr(uint32_t reg, unsigned int cpu_id, uint32_t tid,
> +                       const char *path)
> +{
> +    uint64_t data = 0;
> +    char *socket_path = NULL;
> +    unsigned int buffer[3];
> +
> +    if (path == NULL) {
> +        socket_path = compute_default_paths();
> +    } else {
> +        socket_path = g_strdup(path);
> +    }
> +
> +    SocketAddress saddr = {
> +        .type = SOCKET_ADDRESS_TYPE_UNIX,
> +        .u.q_unix.path = socket_path
> +    };
> +    QIOChannelSocket *sioc = qio_channel_socket_new();
> +    Error *local_err = NULL;
> +
> +    int r;
> +
> +    qio_channel_set_name(QIO_CHANNEL(sioc), "vmsr-helper");
> +    qio_channel_socket_connect_sync(sioc,
> +                                    &saddr,
> +                                    &local_err);
> +    g_free(socket_path);
> +    if (local_err) {
> +        goto out_close;
> +    }
> +
> +    /*
> +     * Send the required arguments:
> +     * 1. RAPL MSR register to read
> +     * 2. On which CPU ID
> +     * 3. From which vCPU (Thread ID)
> +     */
> +    buffer[0] = reg;
> +    buffer[1] = cpu_id;
> +    buffer[2] = tid;

IMHO it is nicer to declare a packed struct for the fields
being sent, and share its decl between the client and server
code.

> +
> +    r = vmsr_helper_socket_write(QIO_CHANNEL(sioc),
> +                                 -1,
> +                                 &buffer, sizeof(buffer),
> +                                 &local_err);
> +    if (r < 0) {
> +        goto out_close;
> +    }
> +
> +    r = vmsr_helper_socket_read(QIO_CHANNEL(sioc),
> +                                &data, sizeof(data),
> +                                &local_err);
> +    if (r < 0) {
> +        data = 0;
> +        goto out_close;
> +    }
> +
> +out_close:
> +    /* Close socket. */
> +    qio_channel_close(QIO_CHANNEL(sioc), NULL);
> +    object_unref(OBJECT(sioc));
> +    return data;
> +}
> +
> +/* Retrieve the max number of physical CPU on the package */
> +unsigned int vmsr_get_maxcpus(unsigned int package_num)
> +{
> +    int k, ncpus;
> +    unsigned int maxcpus;
> +    struct bitmask *cpus;
> +
> +    cpus = numa_allocate_cpumask();
> +    ncpus = cpus->size;
> +
> +    if (numa_node_to_cpus(package_num, cpus) < 0) {
> +        return 0;
> +    }
> +
> +    maxcpus = 0;
> +    for (k = 0; k < ncpus; k++) {
> +        if (numa_bitmask_isbitset(cpus, k)) {
> +            maxcpus++;
> +        }
> +    }
> +
> +    return maxcpus;
> +}
> +
> +/* Retrieve the maximum number of physical packages */
> +unsigned int vmsr_get_max_physical_package(unsigned int max_cpus)
> +{
> +    unsigned int packageCount = 0;
> +    const char *dir = "/sys/devices/system/cpu/";
> +    int *uniquePackages;

Mark this as g_autofree() to eliminuate the multiple calls
go g_free()in each exit path

> +
> +    char *filePath;
> +    FILE *file;
> +
> +    uniquePackages = g_new0(int, max_cpus);
> +
> +    for (int i = 0; i < max_cpus; i++) {
> +        filePath = g_build_filename(dir, g_strdup_printf("cpu%d", i),
> +                                     "topology/physical_package_id", NULL);

Leaking the g_strdup_printf result.

Also filePath is allocated on every iteration, but only freed
outside the loop, so another leak. Declare filePath inside
the loop and mark it g_autofree

> +
> +        file = fopen(filePath, "r");
> +
> +        if (file == NULL) {
> +            perror("Error opening file");
> +            g_free(filePath);
> +            g_free(uniquePackages);
> +            return 0;
> +        }
> +
> +        char packageId[10];
> +        if (fgets(packageId, sizeof(packageId), file) == NULL) {
> +            packageCount = 0;
> +        }
> +
> +        fclose(file);
> +
> +        int currentPackageId = atoi(packageId);
> +
> +        bool isUnique = true;
> +        for (int j = 0; j < packageCount; j++) {
> +            if (uniquePackages[j] == currentPackageId) {
> +                isUnique = false;
> +                break;
> +            }
> +        }
> +
> +        if (isUnique) {
> +            uniquePackages[packageCount] = currentPackageId;
> +            packageCount++;
> +
> +            if (packageCount >= max_cpus) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    g_free(filePath);
> +    g_free(uniquePackages);
> +    return (packageCount == 0) ? 1 : packageCount;
> +}
> +int vmsr_read_thread_stat(struct thread_stat *thread, int pid, int index)
> +{
> +    char *path;
> +    path = g_new0(char, MAX_PATH_LEN);

This pointer is overwritten on the very next line, so is leaked

> +
> +    path = g_build_filename(g_strdup_printf("/proc/%u/task/%d/stat", pid, \
> +            thread->thread_id), NULL);

This result is never freed, and the intermediate g_strdup_printf() is also
not freed. Using g_build_filename is pointless if you're going to use
g_strdup_printf() to buld the entire filename in one go.

> +
> +    FILE *file = fopen(path, "r");
> +    if (file == NULL) {
> +        return -1;
> +    }
> +
> +    if (fscanf(file, "%*d (%*[^)]) %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u"
> +        " %llu %llu %*d %*d %*d %*d %*d %*d %*u %*u %*d %*u %*u"
> +        " %*u %*u %*u %*u %*u %*u %*u %*u %*u %*d %*u %*u %u",
> +           &thread->utime[index], &thread->stime[index], &thread->cpu_id) != 3)
> +        return -1;
> +
> +    fclose(file);
> +    return 0;
> +}
> +
> +/* Read QEMU stat task folder to retrieve all QEMU threads ID */
> +pid_t *vmsr_get_thread_ids(pid_t pid, unsigned int *num_threads)
> +{
> +    char *path = g_build_filename("/proc", g_strdup_printf("%d/task", pid), NULL);

Leaking the g_strdup_printf result

> +
> +    DIR *dir = opendir(path);
> +    if (dir == NULL) {
> +        perror("opendir");
> +        g_free(path);

Mark 'path' as g_autofree so g_free() isn't needed in every exit-path

> +        return NULL;
> +    }
> +
> +    pid_t *thread_ids = NULL;
> +    unsigned int thread_count = 0;
> +
> +    struct dirent *ent;
> +    while ((ent = readdir(dir)) != NULL) {
> +        if (ent->d_name[0] == '.') {
> +            continue;
> +        }
> +        pid_t tid = atoi(ent->d_name);
> +        if (pid != tid) {
> +            thread_ids = g_renew(pid_t, thread_ids, (thread_count + 1));
> +            thread_ids[thread_count] = tid;
> +            thread_count++;
> +        }
> +    }
> +
> +    closedir(dir);
> +
> +    *num_threads = thread_count;
> +    g_free(path);
> +    return thread_ids;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


