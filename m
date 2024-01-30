Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C60EC47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 09:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUkBf-0004yi-GL; Tue, 30 Jan 2024 04:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUkBd-0004yW-DC
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:13:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUkBa-0002yZ-LY
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 04:13:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706606020;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MeiNZrlBeHrioeyvY8MCLe0LjB51hI5B1pBEOLgd/C4=;
 b=bl45VtZ/gZtN8fI5g0sqOz/Hfp9ql4tXJzpiv0BIE4pZJxq4ccuL6TOcSenPvVEwLmU1Hg
 Mw3YCd7GjW0MeXU5Xw5nzjc6sEwNgpo/LlQdugUqlcqSjhDcimUPaOBBLaf1+lmOV/ajS8
 D+g5dhrRVb84TpTCI/w06f6wuN1ZK7k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-VljiyWlTOvuX_YYV99h_Kw-1; Tue,
 30 Jan 2024 04:13:38 -0500
X-MC-Unique: VljiyWlTOvuX_YYV99h_Kw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F1C4386914A
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 09:13:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 204B72166B31;
 Tue, 30 Jan 2024 09:13:36 +0000 (UTC)
Date: Tue, 30 Jan 2024 09:13:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <Zbi9vjPCsia58LG4@redhat.com>
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125072214.318382-4-aharivel@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 882e37e12c5b..ee2fe8817833 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -14,6 +14,8 @@
>  #include "qemu/accel.h"
>  #include "qemu/queue.h"
>  #include "sysemu/kvm.h"
> +#include "hw/boards.h"
> +#include "hw/i386/topology.h"
>  
>  typedef struct KVMSlot
>  {
> @@ -48,6 +50,20 @@ typedef struct KVMMemoryListener {
>  
>  #define KVM_MSI_HASHTAB_SIZE    256
>  
> +struct KVMMsrEnergy {
> +    bool enable;
> +    char *socket_path;
> +    QemuThread msr_thr;
> +    unsigned int cpus;
> +    unsigned int sockets;
> +    X86CPUTopoInfo topo_info;
> +    const CPUArchIdList *cpu_list;
> +    uint64_t *msr_value;
> +    uint64_t msr_unit;
> +    uint64_t msr_limit;
> +    uint64_t msr_info;
> +};
> +
>  enum KVMDirtyRingReaperState {
>      KVM_DIRTY_RING_REAPER_NONE = 0,
>      /* The reaper is sleeping */
> @@ -114,6 +130,7 @@ struct KVMState
>      bool kvm_dirty_ring_with_bitmap;
>      uint64_t kvm_eager_split_size;  /* Eager Page Splitting chunk size */
>      struct KVMDirtyRingReaper reaper;
> +    struct KVMMsrEnergy msr_energy;
>      NotifyVmexitOption notify_vmexit;
>      uint32_t notify_window;
>      uint32_t xen_version;

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

This is allolcating thread_ids

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

This loop is allocating memory for utime & stime..

> +
> +        /* Zero out the memory */
> +        for (int i = 0; i < num_threads; i++) {
> +            memset(thd_stat[i].utime, 0, 2 * sizeof(unsigned long long));
> +            memset(thd_stat[i].stime, 0, 2 * sizeof(unsigned long long));
> +        }
> +        memset(thd_stat, 0, num_threads * sizeof(thread_stat));

..and here we're just wiping the thd_stat pointer, so this is surey a
memory leak of the stime & utime fields.


> +        memset(thread_ids, 0, sizeof(pid_t));

Nothing is free'ing thread_ids which was allocated earlier in the
loop.

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

This looks to be where we need to check that both the host CPU
vendor is intel, and the guest CPU vendor is intel, and that
the host CPU has the RAPL feature we're using.

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


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


