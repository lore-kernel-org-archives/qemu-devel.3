Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBE2C54E58
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 13:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnIaZ-0006us-JI; Thu, 21 Mar 2024 09:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rnIaX-0006uf-JV
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 09:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rnIaQ-0000OL-69
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 09:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711028161;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=DuuvOqMoIj6aLwMFioFzyM6n9R+SINMWCYlqQREzeMw=;
 b=fxG+EV+yc7CkW6Hg/Tes+e5R8xA5jCYy5gGX7R8XEVzf1M+hB0zEaQaO6vfYP5z7HqC5vv
 p++drofvwWnzknOqO30wYqBRhuzVK5QhHcgyePZyXkL7zmGazJJL4nLyQvnn5z8YNfVEqb
 TIU9jVuXLyMr9f44AqM9UI45T7ZS8Hc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-qgtq_Z7lMBmi-YE3oUWTjA-1; Thu, 21 Mar 2024 09:35:58 -0400
X-MC-Unique: qgtq_Z7lMBmi-YE3oUWTjA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C84E8007A3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 13:35:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 558122166B33;
 Thu, 21 Mar 2024 13:35:57 +0000 (UTC)
Date: Thu, 21 Mar 2024 13:35:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com, rjarry@redhat.com
Subject: Re: [PATCH v4 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <Zfw3teeWGAGiUKq7@redhat.com>
References: <20240318151216.32833-1-aharivel@redhat.com>
 <20240318151216.32833-4-aharivel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240318151216.32833-4-aharivel@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
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

On Mon, Mar 18, 2024 at 04:12:16PM +0100, Anthony Harivel wrote:
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
>  docs/specs/rapl-msr.rst       | 155 +++++++++++++
>  include/sysemu/kvm.h          |   2 +
>  include/sysemu/kvm_int.h      |  30 +++
>  target/i386/cpu.h             |   8 +
>  target/i386/kvm/kvm-cpu.c     |   7 +
>  target/i386/kvm/kvm.c         | 420 ++++++++++++++++++++++++++++++++++
>  target/i386/kvm/meson.build   |   1 +
>  target/i386/kvm/vmsr_energy.c | 381 ++++++++++++++++++++++++++++++
>  target/i386/kvm/vmsr_energy.h |  97 ++++++++
>  11 files changed, 1129 insertions(+)
>  create mode 100644 docs/specs/rapl-msr.rst
>  create mode 100644 target/i386/kvm/vmsr_energy.c
>  create mode 100644 target/i386/kvm/vmsr_energy.h
> 


> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 882e37e12c5b..ea4587b53eb1 100644
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
> @@ -48,6 +50,33 @@ typedef struct KVMMemoryListener {
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
> +    QemuThread msr_thr;
> +    unsigned int vcpus;
> +    unsigned int vsockets;
> +    X86CPUTopoInfo topo_info;
> +    KVMHostTopoInfo host_topo;
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
> @@ -114,6 +143,7 @@ struct KVMState
>      bool kvm_dirty_ring_with_bitmap;
>      uint64_t kvm_eager_split_size;  /* Eager Page Splitting chunk size */
>      struct KVMDirtyRingReaper reaper;
> +    struct KVMMsrEnergy msr_energy;
>      NotifyVmexitOption notify_vmexit;
>      uint32_t notify_window;
>      uint32_t xen_version;
> diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> index 9c791b7b0520..246de2bac2f1 100644
> --- a/target/i386/kvm/kvm-cpu.c
> +++ b/target/i386/kvm/kvm-cpu.c
> @@ -50,6 +50,13 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
>                                                     MSR_IA32_UCODE_REV);
>          }
>      }
> +    if (kvm_is_rapl_feat_enable(cs)) {
> +        if (IS_INTEL_CPU(env)) {

You need to invert this check  if (!IS_INTEL_CPU(...)) {

> +            error_setg(errp, "RAPL feature is enable and CPU is not INTEL CPU");

Tweak the message

    "The RAPL feature can only be enabled with Intel CPU models"

> +            return false;
> +        };
> +    };

No semi-colon after }

> +
>      return host_cpu_realizefn(cs, errp);
>  }
>  

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
> +        error_report("error: Host CPU is not INTEL cpu");
> +        ret = 1;
> +        goto out;
> +    }

Don't need to include 'error:' in the message, as error_report will
already print that.

Suggest

    "The RAPL feature can only be enabled on hosts with Intel CPU models"

> +
> +    if (!is_rapl_enabled()) {
> +        error_report("error: RAPL driver not enable on Host");

This method is already calling error_report, so reporting it
again is redundant.

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
> +    if (r->host_topo.maxcpus <= 0) {
> +        error_report("error: host max cpus <= 0");

Another redundant 'error: ' in strings, and more below

> +        ret = 1;
> +        goto out;
> +    }
> +
> +    /* Max number of packages on the host */
> +    r->host_topo.maxpkgs = vmsr_get_max_physical_package(r->host_topo.maxcpus);
> +    if (r->host_topo.maxpkgs <= 0) {
> +        error_report("error: host max pkgs <= 0");
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
> +        if (r->host_topo.pkg_cpu_count[i] <= 0) {
> +            error_report("error: cpu per packages <= 0 on package_%d", i);

Checking '<=' is inappropriate this 'pkg_cpu_count' is
an unsigned field. IOW, use ' == 0' not ' <= 0'.

> +            ret = 1;
> +            goto out;
> +        }
> +    }
> +
> +    /* Get QEMU PID*/
> +    r->pid = getpid();
> +
> +    /* Those MSR values should not change */
> +    r->msr_unit  = vmsr_read_msr(MSR_RAPL_POWER_UNIT, 0, r->pid,
> +                                    s->msr_energy.socket_path);
> +    r->msr_limit = vmsr_read_msr(MSR_PKG_POWER_LIMIT, 0, r->pid,
> +                                    s->msr_energy.socket_path);
> +    r->msr_info  = vmsr_read_msr(MSR_PKG_POWER_INFO, 0, r->pid,
> +                                    s->msr_energy.socket_path);
> +    if (r->msr_unit == 0 || r->msr_limit == 0 || r->msr_info == 0) {
> +        error_report("error: can't read any virtual msr");
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
> @@ -2715,6 +3092,49 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>                           strerror(-ret));
>              exit(1);
>          }
> +
> +        if (s->msr_energy.enable == true) {
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
> +            }
> +            r = kvm_msr_energy_thread_init(s, ms);
> +            if (r) {
> +                error_report("kvm : error RAPL feature requirement not meet");
> +                exit(1);
> +            }
> +
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
> index 000000000000..20ac50c3f0b6
> --- /dev/null
> +++ b/target/i386/kvm/vmsr_energy.c
> @@ -0,0 +1,381 @@
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
> +static char *compute_default_paths(void)
> +{
> +    g_autofree char *state = qemu_get_local_state_dir();
> +
> +    return g_build_filename(state, "run", "qemu-vmsr-helper.sock", NULL);
> +}
> +
> +bool is_host_cpu_intel(void)
> +{
> +    int family, model, stepping;
> +    char vendor[CPUID_VENDOR_SZ + 1];
> +
> +    host_cpu_vendor_fms(vendor, &family, &model, &stepping);
> +
> +    return strcmp(vendor, CPUID_VENDOR_INTEL);
> +}
> +
> +int is_rapl_enabled(void)
> +{
> +    const char *path = "/sys/class/powercap/intel-rapl/enabled";
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
> +
> +static int vmsr_helper_socket_write(QIOChannel *ioc,
> +                                   int fd,

In the previous version I said to remove this parameter since you're
not using it....

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

Calling unref() here is unsafe - the caller will also unref resulting
in ref count underflow and crash

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

Again, tthis whole method can be removed in favour of calling
qio_channel_write_all()

> +
> +static int vmsr_helper_socket_read(QIOChannel *ioc,
> +                                  void *buf, int sz, Error **errp)
> +{
> +    ssize_t r = qio_channel_read_all(ioc, buf, sz, errp);
> +
> +    if (r < 0) {
> +        object_unref(OBJECT(ioc));
> +        ioc = NULL;

This is unsafe as the caller unrefs already.

> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}

This whole method should be removed - just call qio_channel_read_all
directly below.

> +
> +uint64_t vmsr_read_msr(uint32_t reg, unsigned int cpu_id, uint32_t tid,
> +                       const char *path)
> +{
> +    uint64_t data = 0;
> +    char *socket_path = NULL;
> +    char buffer[3];
> +
> +    if (path == NULL) {
> +        socket_path = compute_default_paths();
> +    } else {
> +        socket_path = g_strdup(path);
> +    }

Re-computing the socket path every time vmsr_read_msr is
called is pretty mad - compute it once at startup and
store the value.

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

In the previous posting I suggested that connectiong to the
helper again & again for every individual MSR read is a
high overhead. Connect once, and then just keep the socket
open forever.

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
> +
> +    r = vmsr_helper_socket_write(QIO_CHANNEL(sioc),
> +                                 -1,
> +                                 &buffer, sizeof(buffer),
> +                                 &local_err);
> +   if (r < 0) {
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
> +/* Retrieve the max number of physical package */
> +unsigned int vmsr_get_max_physical_package(unsigned int max_cpus)
> +{
> +    const char *dir = "/sys/devices/system/cpu/";
> +    const char *topo_path = "topology/physical_package_id";
> +    g_autofree int *uniquePackages = 0;

NULL, not 0 for pointers but....

> +    unsigned int packageCount = 0;
> +    FILE *file = NULL;
> +
> +    uniquePackages = g_new0(int, max_cpus);

just initialize this at the same time as declaring it.

> +
> +    for (int i = 0; i < max_cpus; i++) {
> +        g_autofree char *filePath = NULL;
> +        g_autofree char *cpuid = g_strdup_printf("cpu%d", i);
> +
> +        filePath = g_build_filename(dir, cpuid, topo_path, NULL);
> +
> +        file = fopen(filePath, "r");
> +
> +        if (file == NULL) {
> +            error_report("Error opening physical_package_id file");
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
> +    return (packageCount == 0) ? 1 : packageCount;
> +}
> +
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
> +
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
> +
> +void vmsr_delta_ticks(thread_stat *thd_stat, int i)
> +{
> +    thd_stat[i].delta_ticks = (thd_stat[i].utime[1] + thd_stat[i].stime[1])
> +                            - (thd_stat[i].utime[0] + thd_stat[i].stime[0]);
> +}
> +
> +double vmsr_get_ratio(uint64_t e_delta,
> +                      unsigned long long delta_ticks,
> +                      unsigned int maxticks)
> +{
> +    return (e_delta / 100.0) * ((100.0 / maxticks) * delta_ticks);
> +}
> +
> +void vmsr_init_topo_info(X86CPUTopoInfo *topo_info,
> +                           const MachineState *ms)
> +{
> +    topo_info->dies_per_pkg = ms->smp.dies;
> +    topo_info->cores_per_die = ms->smp.cores;
> +    topo_info->threads_per_core = ms->smp.threads;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


