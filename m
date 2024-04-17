Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9D9C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 17:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx9W4-00061c-Dh; Wed, 17 Apr 2024 13:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx9W2-00061L-I3
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 13:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rx9Vz-00029k-1h
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 13:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713376570;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bxwD7QMddCNLHcakXBr03PE75R076m3/m4RyOKsK7A4=;
 b=NIVujQbB6YT0J5a3S9mAKkEc5T8pLh+UpGDcixAT71/y8vzd/cR6b7z+JlE4znHYa1yRJh
 GQoZ8XolqYJ/iTi4tRbS6FezefGZy96khVf3yP9W0bWzXoNzTOlNIU9xPQhnpoJtJP+BO+
 iLfL1LQGDgjGSUH2WgJ0oSgValYTwEc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-YgvLsJ2UPdCac8Lwiwu0SQ-1; Wed, 17 Apr 2024 13:56:06 -0400
X-MC-Unique: YgvLsJ2UPdCac8Lwiwu0SQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57E8480591B
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 17:56:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0592D20BBF16;
 Wed, 17 Apr 2024 17:56:04 +0000 (UTC)
Date: Wed, 17 Apr 2024 18:55:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com, rjarry@redhat.com
Subject: Re: [PATCH v5 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <ZiANL6KkfZy3APJa@redhat.com>
References: <20240411121434.253353-1-aharivel@redhat.com>
 <20240411121434.253353-4-aharivel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240411121434.253353-4-aharivel@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 11, 2024 at 02:14:34PM +0200, Anthony Harivel wrote:


> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index fad9a7e8ff30..37f68c496807 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -544,4 +544,6 @@ uint32_t kvm_dirty_ring_size(void);
>   * reported for the VM.
>   */
>  bool kvm_hwpoisoned_mem(void);
> +
> +bool kvm_is_rapl_feat_enable(CPUState *cs);
>  #endif
> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 882e37e12c5b..8dbeda473c6c 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -14,6 +14,9 @@
>  #include "qemu/accel.h"
>  #include "qemu/queue.h"
>  #include "sysemu/kvm.h"
> +#include "hw/boards.h"
> +#include "hw/i386/topology.h"
> +#include "io/channel-socket.h"
>  
>  typedef struct KVMSlot
>  {
> @@ -48,6 +51,34 @@ typedef struct KVMMemoryListener {
>  
>  #define KVM_MSI_HASHTAB_SIZE    256
>  
> +typedef struct KVMHostTopoInfo {
> +    /* Number of package on the Host */
> +    unsigned int maxpkgs;
> +    /* Number of cpus on the Host */
> +    unsigned int maxcpus;
> +    /* Number of cpus on each different package */
> +    unsigned int *pkg_cpu_count;
> +    /* Each package can have different maxticks */
> +    unsigned int *maxticks;
> +} KVMHostTopoInfo;
> +
> +struct KVMMsrEnergy {
> +    pid_t pid;
> +    bool enable;
> +    char *socket_path;
> +    QIOChannelSocket *sioc;
> +    QemuThread msr_thr;
> +    unsigned int vcpus;
> +    unsigned int vsockets;

Add 'guest_' prefix on to these two, to make it clearer

> +    X86CPUTopoInfo topo_info;

Lets call this 'guest_topo' too, to make it more explicitly
distinguished from the next 'host_topo' field.

> +    KVMHostTopoInfo host_topo;
> +    const CPUArchIdList *cpu_list;

This name choice has an unfortunate side effect.

cpu.h has a '#define cpu_list x86_cpu_list' for the purposes
of selecting the target specific  cpu_list function.

Unfortunately that macro affects your field name here, which
is why the code is wierdly able to set an 'x86_cpu_list' field
despite you having declared it 'cpu_list'.

I'd suggest perhaps calling this field 'guest_cpus' to avoid
this confusing side-effect, and again also making clear that
this is tracking guest, not host, CPUs.

> +    uint64_t *msr_value;
> +    uint64_t msr_unit;
> +    uint64_t msr_limit;
> +    uint64_t msr_info;
> +};
> +
>  enum KVMDirtyRingReaperState {
>      KVM_DIRTY_RING_REAPER_NONE = 0,
>      /* The reaper is sleeping */
> @@ -114,6 +145,7 @@ struct KVMState
>      bool kvm_dirty_ring_with_bitmap;
>      uint64_t kvm_eager_split_size;  /* Eager Page Splitting chunk size */
>      struct KVMDirtyRingReaper reaper;
> +    struct KVMMsrEnergy msr_energy;
>      NotifyVmexitOption notify_vmexit;
>      uint32_t notify_window;
>      uint32_t xen_version;

> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index e68cbe929302..3de69caa229e 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c

> @@ -2513,6 +2565,339 @@ static void register_smram_listener(Notifier *n, void *unused)
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
> +    g_autofree unsigned int *vpkgs_energy_stat = NULL;
> +    unsigned int num_threads = 0;
> +    unsigned int tmp_num_threads = 0;
> +
> +    X86CPUTopoIDs topo_ids;
> +
> +    rcu_register_thread();
> +
> +    /* Allocate memory for each package energy status */
> +    pkg_stat = g_new0(package_energy_stat, vmsr->host_topo.maxpkgs);
> +
> +    /* Allocate memory for thread stats */
> +    thd_stat = g_new0(thread_stat, 1);
> +
> +    /* Allocate memory for holding virtual package energy counter */
> +    vpkgs_energy_stat = g_new0(unsigned int, vmsr->vsockets);
> +
> +    /* Populate the max tick of each packages */
> +    for (int i = 0; i <= vmsr->host_topo.maxpkgs; i++) {

The 'maxticks' array is allocated as 'maxpkgs' in size, so this
limit condition needs to be '<' not '<=', to avoid an out of
bounds write.

> +        /*
> +         * Max numbers of ticks per package
> +         * Time in second * Number of ticks/second * Number of cores/package
> +         * ex: 100 ticks/second/CPU, 12 CPUs per Package gives 1200 ticks max
> +         */
> +        vmsr->host_topo.maxticks[i] = (MSR_ENERGY_THREAD_SLEEP_US / 1000000)
> +                        * sysconf(_SC_CLK_TCK)
> +                        * vmsr->host_topo.pkg_cpu_count[i];
> +    }
> +
> +    while (true) {
> +        /* Get all qemu threads id */
> +        thread_ids = vmsr_get_thread_ids(vmsr->pid, &num_threads);

Since you're re-allocating thread_ids on each loop iteration, you
need to free it, not overwrite the pointer. This is easily achieved
by moving the earlier declaration inside the loop body. ie 


   g_autofree pid_t *thread_ids =
        thread_ids = vmsr_get_thread_ids(vmsr->pid, &num_threads);

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

You could eliminate 'tmp_num_threads' and just unconditionally
call g_renew on each loop iteration. It'll effectively be a
no-op if the size hasn't changed since the last iteration,
and won't hurt performance in any measurable way.

> +
> +        /* Populate all the thread stats */
> +        for (int i = 0; i < num_threads; i++) {
> +            thd_stat[i].utime = g_new0(unsigned long long, 2);
> +            thd_stat[i].stime = g_new0(unsigned long long, 2);
> +            thd_stat[i].thread_id = thread_ids[i];
> +            vmsr_read_thread_stat(vmsr->pid,
> +                                  thd_stat[i].thread_id,
> +                                  thd_stat[i].utime,
> +                                  thd_stat[i].stime,
> +                                  &thd_stat[i].cpu_id);
> +            thd_stat[i].pkg_id =
> +                vmsr_get_physical_package_id(thd_stat[i].cpu_id);
> +        }
> +
> +        /* Retrieve all packages power plane energy counter */
> +        for (int i = 0; i < vmsr->host_topo.maxpkgs; i++) {
> +            for (int j = 0; j < num_threads; j++) {
> +                /*
> +                 * Use the first thread we found that ran on the CPU
> +                 * of the package to read the packages energy counter
> +                 */
> +                if (thd_stat[j].pkg_id == i) {
> +                    pkg_stat[i].e_start =
> +                    vmsr_read_msr(MSR_PKG_ENERGY_STATUS,
> +                                  thd_stat[j].cpu_id,
> +                                  thd_stat[j].thread_id,
> +                                  s->msr_energy.sioc);
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
> +        for (int i = 0; i < vmsr->host_topo.maxpkgs; i++) {
> +            for (int j = 0; j < num_threads; j++) {
> +                /*
> +                 * Use the first thread we found that ran on the CPU
> +                 * of the package to read the packages energy counter
> +                 */
> +                if (thd_stat[j].pkg_id == i) {
> +                    pkg_stat[i].e_end =
> +                    vmsr_read_msr(MSR_PKG_ENERGY_STATUS,
> +                                  thd_stat[j].cpu_id,
> +                                  thd_stat[j].thread_id,
> +                                  s->msr_energy.sioc);
> +                    /*
> +                     * Prevent the case we have migrate the VM
> +                     * during the sleep period or any other cases
> +                     * were energy counter might be lower after
> +                     * the sleep period.
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
> +            vmsr_read_thread_stat(vmsr->pid,
> +                                  thd_stat[i].thread_id,
> +                                  thd_stat[i].utime,
> +                                  thd_stat[i].stime,
> +                                  &thd_stat[i].cpu_id);
> +
> +            if (vmsr->pid < 0) {
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
> +         * Identify the vcpu threads
> +         * Calculate the number of vcpu per package
> +         */
> +        CPU_FOREACH(cpu) {
> +            for (int i = 0; i < num_threads; i++) {
> +                if (cpu->thread_id == thd_stat[i].thread_id) {
> +                    thd_stat[i].is_vcpu = true;
> +                    thd_stat[i].vcpu_id = cpu->cpu_index;
> +                    pkg_stat[thd_stat[i].pkg_id].nb_vcpu++;
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
> +                    thd_stat[j].vpkg_id = topo_ids.pkg_id;
> +                }
> +            }
> +        }
> +
> +        /* Calculate the total energy of all non-vCPU thread */
> +        for (int i = 0; i < num_threads; i++) {
> +            double temp;

Move this inside the 'if', and assign to it at time of declaration.

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
> +        /* Calculate the ratio per non-vCPU thread of each package */
> +        for (int i = 0; i < vmsr->host_topo.maxpkgs; i++) {
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

Aain can move inside the 'if'

> +
> +            if ((thd_stat[i].is_vcpu == true) && \
> +                    (thd_stat[i].delta_ticks > 0)) {
> +                temp = vmsr_get_ratio(pkg_stat[thd_stat[i].pkg_id].e_delta,
> +                    thd_stat[i].delta_ticks,
> +                    vmsr->host_topo.maxticks[thd_stat[i].pkg_id]);
> +                vpkgs_energy_stat[thd_stat[i].vpkg_id] +=
> +                    (uint64_t)lround(temp);
> +                vpkgs_energy_stat[thd_stat[i].vpkg_id] +=
> +                    pkg_stat[thd_stat[i].pkg_id].e_ratio;
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
> +                                        vpkgs_energy_stat[thd_stat[i].vpkg_id];
> +          }
> +        }
> +
> +        /* Freeing memory before zeroing the pointer */
> +        for (int i = 0; i < num_threads; i++) {
> +            g_free(thd_stat[i].utime);
> +            g_free(thd_stat[i].stime);
> +        }
> +        /* Zeroing the reused memory with g_renew */
> +        memset(thd_stat, 0, num_threads * sizeof(thread_stat));

This memset() should be done immediately after the 'g_renew'
call, since if g_renew enlarged the array, it won't have
zero'd the newly added elements.

> +        memset(thread_ids, 0, sizeof(pid_t));

We need to be free'ing thread_ids, not zero'ing it. This
memset can just be removed entirely if you follow my
earlier suggestion to rely on g_autofree and declare
thread_ids inside the loop body.

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
> +    int ret = 0;
> +
> +    /*
> +     * Sanity check
> +     * 1. Host cpu must be Intel cpu
> +     * 2. RAPL must be enabled on the Host
> +     */
> +    if (is_host_cpu_intel()) {
> +        error_report("The RAPL feature can only be enabled on hosts\
> +                      with Intel CPU models");
> +        ret = 1;
> +        goto out;
> +    }
> +
> +    if (!is_rapl_enabled()) {
> +        ret = 1;
> +        goto out;
> +    }
> +
> +    /* Retrieve the virtual topology */
> +    vmsr_init_topo_info(&r->topo_info, ms);
> +
> +    /* Retrieve the number of vcpu */
> +    r->vcpus = ms->smp.cpus;
> +
> +    /* Retrieve the number of virtual sockets */
> +    r->vsockets = ms->smp.sockets;
> +
> +    /* Allocate register memory (MSR_PKG_STATUS) for each vcpu */
> +    r->msr_value = g_new0(uint64_t, r->vcpus);
> +
> +    /* Retrieve the CPUArchIDlist */
> +    r->x86_cpu_list = x86_possible_cpu_arch_ids(ms);
> +
> +    /* Max number of cpus on the Host */
> +    r->host_topo.maxcpus = vmsr_get_maxcpus();
> +    if (r->host_topo.maxcpus == 0) {
> +        error_report("host max cpus = 0");
> +        ret = 1;
> +        goto out;
> +    }
> +
> +    /* Max number of packages on the host */
> +    r->host_topo.maxpkgs = vmsr_get_max_physical_package(r->host_topo.maxcpus);
> +    if (r->host_topo.maxpkgs == 0) {
> +        error_report("host max pkgs = 0");
> +        ret = 1;
> +        goto out;
> +    }
> +
> +    /* Allocate memory for each package on the host */
> +    r->host_topo.pkg_cpu_count = g_new0(unsigned int, r->host_topo.maxpkgs);
> +    r->host_topo.maxticks = g_new0(unsigned int, r->host_topo.maxpkgs);
> +
> +    vmsr_count_cpus_per_package(r->host_topo.pkg_cpu_count,
> +                                r->host_topo.maxpkgs);
> +    for (int i = 0; i < r->host_topo.maxpkgs; i++) {
> +        if (r->host_topo.pkg_cpu_count[i] == 0) {
> +            error_report("cpu per packages = 0 on package_%d", i);
> +            ret = 1;
> +            goto out;
> +        }
> +    }
> +
> +    /* Get QEMU PID*/
> +    r->pid = getpid();
> +
> +    /* Compute the socket path if necessary */
> +    if (s->msr_energy.socket_path == NULL) {
> +        s->msr_energy.socket_path = vmsr_compute_default_paths();
> +    }
> +
> +    /* Open socket with vmsr helper */
> +    s->msr_energy.sioc = vmsr_open_socket(s->msr_energy.socket_path);

Need to detect & report error if opening the socket failed.

> +
> +    /* Those MSR values should not change */
> +    r->msr_unit  = vmsr_read_msr(MSR_RAPL_POWER_UNIT, 0, r->pid,
> +                                    s->msr_energy.sioc);
> +    r->msr_limit = vmsr_read_msr(MSR_PKG_POWER_LIMIT, 0, r->pid,
> +                                    s->msr_energy.sioc);
> +    r->msr_info  = vmsr_read_msr(MSR_PKG_POWER_INFO, 0, r->pid,
> +                                    s->msr_energy.sioc);
> +    if (r->msr_unit == 0 || r->msr_limit == 0 || r->msr_info == 0) {
> +        error_report("can't read any virtual msr");
> +        ret = 1;
> +        goto out;
> +    }
> +
> +    qemu_thread_create(&r->msr_thr, "kvm-msr",
> +                       kvm_msr_energy_thread,
> +                       s, QEMU_THREAD_JOINABLE);
> +out:
> +    return ret;
> +}
> +
>  int kvm_arch_get_default_type(MachineState *ms)
>  {
>      return 0;

> diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
> new file mode 100644
> index 000000000000..934d14c4305f
> --- /dev/null
> +++ b/target/i386/kvm/vmsr_energy.c
> @@ -0,0 +1,335 @@
> +/*
> + * QEMU KVM support -- x86 virtual RAPL msr
> + *
> + * Copyright 2024 Red Hat, Inc. 2024
> + *
> + *  Author:
> + *      Anthony Harivel <aharivel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "vmsr_energy.h"
> +#include "io/channel.h"
> +#include "io/channel-socket.h"
> +#include "hw/boards.h"
> +#include "cpu.h"
> +#include "host-cpu.h"

> +
> +QIOChannelSocket *vmsr_open_socket(const char *path)
> +{
> +    g_autofree char *socket_path = NULL;
> +
> +    socket_path = g_strdup(path);

Assign this at time of declaring socket_path

> +
> +    SocketAddress saddr = {
> +        .type = SOCKET_ADDRESS_TYPE_UNIX,
> +        .u.q_unix.path = socket_path
> +    };
> +
> +    QIOChannelSocket *sioc = qio_channel_socket_new();
> +    Error *local_err = NULL;
> +
> +    qio_channel_set_name(QIO_CHANNEL(sioc), "vmsr-helper");
> +    qio_channel_socket_connect_sync(sioc,
> +                                    &saddr,
> +                                    &local_err);
> +    if (local_err) {
> +        /* Close socket. */
> +        qio_channel_close(QIO_CHANNEL(sioc), NULL);
> +        object_unref(OBJECT(sioc));

You need a 'return NULL' here, otherwise we're returning
a free'd pointer to the caller. Aso we need to report the
error.

> +    }
> +
> + return sioc;

Indent misaligned.

> +}
> +
> +uint64_t vmsr_read_msr(uint32_t reg, uint32_t cpu_id, uint32_t tid,
> +                       QIOChannelSocket *sioc)
> +{
> +    uint64_t data = 0;
> +    int r = 0;
> +    Error *local_err = NULL;
> +    g_autofree uint32_t buffer[3];

g_autofree is wrong for a stack allocated array, just
remove it.

> +    /*
> +     * Send the required arguments:
> +     * 1. RAPL MSR register to read
> +     * 2. On which CPU ID
> +     * 3. From which vCPU (Thread ID)
> +     */
> +    buffer[0] = reg;
> +    buffer[1] = cpu_id;
> +    buffer[2] = tid;
> +
> +    r = qio_channel_write_all(QIO_CHANNEL(sioc),
> +                              (char *)buffer, sizeof(buffer),
> +                              &local_err);
> +    if (r < 0) {
> +        goto out_close;
> +    }
> +
> +    r = qio_channel_read_all(QIO_CHANNEL(sioc),
> +                             (char *)data, sizeof(data),
> +                             &local_err);
> +    if (r < 0) {
> +        data = 0;
> +        goto out_close;
> +    }
> +
> +out_close:
> +   return data;
> +}

> +/* Retrieve the max number of physical cpu on the host */
> +unsigned int vmsr_get_maxcpus(void)
> +{
> +    GDir *dir;
> +    const gchar *entry_name;
> +    unsigned int cpu_count = 0;
> +    const char *path = "/sys/devices/system/cpu/";
> +
> +    dir = g_dir_open(path, 0, NULL);
> +    if (dir == NULL) {
> +        error_report("Unable to open cpu directory");

Slightly more friendly to include the path in the error
message, and also the error that glib reports.eg

   g_autoptr(GError) gerr = NULL;
   GDir *dir = g_dir_open(path, 0, &gerr);
   if (dir == NULL) {
       error_report("Unable to open cpu directory %s: %s", path, err->message);

> +        return -1;
> +    }
> +
> +    while ((entry_name = g_dir_read_name(dir)) != NULL) {
> +        if (g_ascii_strncasecmp(entry_name, "cpu", 3) == 0 &&
> +            isdigit(entry_name[3])) {
> +            cpu_count++;
> +        }
> +    }
> +
> +    g_dir_close(dir);
> +
> +    return cpu_count;
> +}
> +
> +/* Count the number of physical cpu on each packages */
> +unsigned int vmsr_count_cpus_per_package(unsigned int *package_count,
> +                                         unsigned int max_pkgs)
> +{
> +    g_autofree char *file_contents = NULL;
> +    g_autofree char *path = NULL;
> +    gsize length;
> +
> +    /* Iterate over cpus and count cpus in each package */
> +    for (int cpu_id = 0; ; cpu_id++) {
> +        path = g_build_filename(
> +                g_strdup_printf("/sys/devices/system/cpu/cpu%d/"
> +                    "topology/physical_package_id", cpu_id), NULL);

The result of 'g_strdup_printf' needs assigning to a variable
marked with 'g_autofree', before being passed to g_build_filename
to avoid a mem leak.

> +
> +        if (!g_file_get_contents(path, &file_contents, &length, NULL)) {
> +            break; /* No more cpus */
> +        }
> +
> +        /* Get the physical package ID for this CPU */
> +        int package_id = atoi(file_contents);
> +
> +        /* Check if the package ID is within the known number of packages */
> +        if (package_id >= 0 && package_id < max_pkgs) {
> +            /* If yes, count the cpu for this package*/
> +            package_count[package_id]++;
> +        }
> +    }
> +
> +    return 0;
> +}

> +/* Read the scheduled time for a given thread of a give pid */
> +void vmsr_read_thread_stat(pid_t pid,
> +                      unsigned int thread_id,
> +                      unsigned long long *utime,
> +                      unsigned long long *stime,
> +                      unsigned int *cpu_id)
> +{
> +    g_autofree char *path = NULL;
> +
> +    path = g_build_filename(g_strdup_printf("/proc/%u/task/%d/stat", pid, \
> +            thread_id), NULL);

Again need to assign g_strdup_printf result to a g_autofree
marked variable to avoid memleak.

> +
> +    FILE *file = fopen(path, "r");
> +    if (file == NULL) {
> +        pid = -1;
> +        return;
> +    }
> +
> +    if (fscanf(file, "%*d (%*[^)]) %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u"
> +        " %llu %llu %*d %*d %*d %*d %*d %*d %*u %*u %*d %*u %*u"
> +        " %*u %*u %*u %*u %*u %*u %*u %*u %*u %*d %*u %*u %u",
> +           utime, stime, cpu_id) != 3)
> +    {
> +        pid = -1;
> +        return;
> +    }
> +
> +    fclose(file);
> +    return;
> +}
> +
> +/* Read QEMU stat task folder to retrieve all QEMU threads ID */
> +pid_t *vmsr_get_thread_ids(pid_t pid, unsigned int *num_threads)
> +{
> +    g_autofree char *path = g_build_filename("/proc",
> +        g_strdup_printf("%d/task", pid), NULL);

Another memleak of g_strdup_printf()result

> +
> +    DIR *dir = opendir(path);
> +    if (dir == NULL) {
> +        error_report("Error opening /proc/qemu/task");
> +        return NULL;
> +    }
> +
> +    pid_t *thread_ids = NULL;
> +    unsigned int thread_count = 0;
> +
> +    g_autofree struct dirent *ent = NULL;
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
> +    return thread_ids;
> +}

> diff --git a/target/i386/kvm/vmsr_energy.h b/target/i386/kvm/vmsr_energy.h
> new file mode 100644
> index 000000000000..a04114179346
> --- /dev/null
> +++ b/target/i386/kvm/vmsr_energy.h
> @@ -0,0 +1,99 @@
> +/*
> + * QEMU KVM support -- x86 virtual energy-related MSR.
> + *
> + * Copyright 2024 Red Hat, Inc. 2024
> + *
> + *  Author:
> + *      Anthony Harivel <aharivel@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef VMSR_ENERGY_H
> +#define VMSR_ENERGY_H
> +
> +#include <stdint.h>
> +#include "qemu/osdep.h"
> +#include "io/channel-socket.h"
> +#include "hw/i386/topology.h"
> +
> +/*
> + * Define the interval time in micro seconds between 2 samples of
> + * energy related MSRs
> + */
> +#define MSR_ENERGY_THREAD_SLEEP_US 1000000.0
> +
> +/*
> + * Thread statistic
> + * @ thread_id: TID (thread ID)
> + * @ is_vcpu: true if TID is vCPU thread
> + * @ cpu_id: CPU number last executed on
> + * @ pkg_id: package number of the CPU
> + * @ vcpu_id: vCPU ID
> + * @ vpkg: virtual package number
> + * @ acpi_id: APIC id of the vCPU
> + * @ utime: amount of clock ticks the thread
> + *          has been scheduled in User mode
> + * @ stime: amount of clock ticks the thread
> + *          has been scheduled in System mode
> + * @ delta_ticks: delta of utime+stime between
> + *          the two samples (before/after sleep)
> + */
> +struct thread_stat {

Suggest 'vmsr_thread_stat' to better namespace 

> +    unsigned int thread_id;
> +    bool is_vcpu;
> +    unsigned int cpu_id;
> +    unsigned int pkg_id;
> +    unsigned int vpkg_id;
> +    unsigned int vcpu_id;
> +    unsigned long acpi_id;
> +    unsigned long long *utime;
> +    unsigned long long *stime;
> +    unsigned long long delta_ticks;
> +};
> +
> +/*
> + * Package statistic
> + * @ e_start: package energy counter before the sleep
> + * @ e_end: package energy counter after the sleep
> + * @ e_delta: delta of package energy counter
> + * @ e_ratio: store the energy ratio of non-vCPU thread
> + * @ nb_vcpu: number of vCPU running on this package
> + */
> +struct package_energy_stat {

And 'vmsr_package_energy_stat' too


> +    uint64_t e_start;
> +    uint64_t e_end;
> +    uint64_t e_delta;
> +    uint64_t e_ratio;
> +    unsigned int nb_vcpu;
> +};
> +
> +typedef struct thread_stat thread_stat;
> +typedef struct package_energy_stat package_energy_stat;
> +
> +char *vmsr_compute_default_paths(void);
> +void vmsr_read_thread_stat(pid_t pid,
> +                      unsigned int thread_id,
> +                      unsigned long long *utime,
> +                      unsigned long long *stime,
> +                      unsigned int *cpu_id);
> +
> +QIOChannelSocket *vmsr_open_socket(const char *path);
> +uint64_t vmsr_read_msr(uint32_t reg, uint32_t cpu_id,
> +                       uint32_t tid, QIOChannelSocket *sioc);
> +void vmsr_delta_ticks(thread_stat *thd_stat, int i);
> +unsigned int vmsr_get_maxcpus(void);
> +unsigned int vmsr_get_max_physical_package(unsigned int max_cpus);
> +unsigned int vmsr_count_cpus_per_package(unsigned int *package_count,
> +                                         unsigned int max_pkgs);
> +int vmsr_get_physical_package_id(int cpu_id);
> +pid_t *vmsr_get_thread_ids(pid_t pid, unsigned int *num_threads);
> +double vmsr_get_ratio(uint64_t e_delta,
> +                      unsigned long long delta_ticks,
> +                      unsigned int maxticks);
> +void vmsr_init_topo_info(X86CPUTopoInfo *topo_info, const MachineState *ms);
> +bool is_host_cpu_intel(void);
> +int is_rapl_enabled(void);
> +#endif /* VMSR_ENERGY_H */

Bearing in mind the other feedback from Intel about future CPUs
not using MSRs for this interface, I wonder if a rename is worth
doing.

eg call the file 'rapl.h', and the APIs / structs all have a
'rapl_' name prefix, instead of 'vmsr'.

Then use 'rapl_vmsr_' as a name prefix on the ones that are
specifically tied to the MSR based impl. In future we can
have 'rapl_tpmi' as the prefix for the new interface.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


