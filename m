Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D162C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 13:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTMDU-0001Mh-C0; Mon, 15 Jul 2024 09:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sTMDR-0001EG-FJ; Mon, 15 Jul 2024 09:58:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1sTMDP-0003xu-63; Mon, 15 Jul 2024 09:58:09 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WN3d330Csz6K9Wg;
 Mon, 15 Jul 2024 21:55:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id C5ACD140B39;
 Mon, 15 Jul 2024 21:58:02 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 14:57:59 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Mon, 15 Jul 2024 14:57:59 +0100
To: Igor Mammedov <imammedo@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "will@kernel.org" <will@kernel.org>, "gshan@redhat.com"
 <gshan@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "darren@os.amperecomputing.com"
 <darren@os.amperecomputing.com>, "ilkka@os.amperecomputing.com"
 <ilkka@os.amperecomputing.com>, "vishnu@os.amperecomputing.com"
 <vishnu@os.amperecomputing.com>, "karl.heubaum@oracle.com"
 <karl.heubaum@oracle.com>, "miguel.luis@oracle.com" <miguel.luis@oracle.com>, 
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>, zhukeqian
 <zhukeqian1@huawei.com>, "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>, "jiakernel2@gmail.com"
 <jiakernel2@gmail.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 Linuxarm <linuxarm@huawei.com>, Shaoqin Huang <shahuang@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>
Subject: RE: [PATCH V15 1/7] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Topic: [PATCH V15 1/7] accel/kvm: Extract common KVM vCPU
 {creation,parking} code
Thread-Index: AQHa1VIj3Jw6kX4U1UOYudvO7DaVDbH3r3CAgAAK4ICAABiUUA==
Date: Mon, 15 Jul 2024 13:57:59 +0000
Message-ID: <cdb53ce71c4548b096651e9eac78a240@huawei.com>
References: <20240713182516.1457-1-salil.mehta@huawei.com>
 <20240713182516.1457-2-salil.mehta@huawei.com>
 <20240715144925.20d1cd2c@imammedo.users.ipa.redhat.com>
 <20240715152821.7b8153e3@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240715152821.7b8153e3@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.170.92]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

>  From: Igor Mammedov <imammedo@redhat.com>
>  Sent: Monday, July 15, 2024 2:28 PM
>  To: Salil Mehta <salil.mehta@huawei.com>
> =20
>  On Mon, 15 Jul 2024 14:49:25 +0200
>  Igor Mammedov <imammedo@redhat.com> wrote:
> =20
>  > On Sat, 13 Jul 2024 19:25:10 +0100
>  > Salil Mehta <salil.mehta@huawei.com> wrote:
>  >
>  > > KVM vCPU creation is done once during the vCPU realization when Qemu
>  > > vCPU thread is spawned. This is common to all the architectures as o=
f  now.
>  > >
>  > > Hot-unplug of vCPU results in destruction of the vCPU object in QOM
>  > > but the corresponding KVM vCPU object in the Host KVM is not
>  > > destroyed as KVM doesn't support vCPU removal. Therefore, its
>  > > representative KVM vCPU object/context in Qemu is parked.
>  > >
>  > > Refactor architecture common logic so that some APIs could be reused
>  > > by vCPU Hotplug code of some architectures likes ARM, Loongson etc.
>  > > Update new/old APIs with trace events. New APIs
>  > > qemu_{create,park,unpark}_vcpu() can be externally called. No
>  functional change is intended here.
>  > >
>  > > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>  > > Reviewed-by: Gavin Shan <gshan@redhat.com>
>  > > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>  > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>  > > Tested-by: Xianglai Li <lixianglai@loongson.cn>
>  > > Tested-by: Miguel Luis <miguel.luis@oracle.com>
>  > > Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>  > > Reviewed-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>  > > Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>  > > Tested-by: Zhao Liu <zhao1.liu@intel.com>
>  > > Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>  > > Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  >
>  > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> =20
>  this needs fixing, to make checkpatch happy
> =20
>  Checking 0001-accel-kvm-Extract-common-KVM-vCPU-creation-parking-
>  c.patch...
>  WARNING: line over 80 characters
>  #120: FILE: accel/kvm/kvm-all.c:368:
>  +    trace_kvm_unpark_vcpu(vcpu_id, kvm_fd > 0 ? "unparked" : "not found
>  + parked");


Thanks. I will fix this as well.


> =20
>  total: 0 errors, 1 warnings, 183 lines checked
> =20
>  >
>  > > ---
>  > >  accel/kvm/kvm-all.c    | 95 ++++++++++++++++++++++++++++----------
>  ----
>  > >  accel/kvm/kvm-cpus.h   |  1 -
>  > >  accel/kvm/trace-events |  5 ++-
>  > >  include/sysemu/kvm.h   | 25 +++++++++++
>  > >  4 files changed, 92 insertions(+), 34 deletions(-)
>  > >
>  > > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
>  > > 2b4ab89679..e446d18944 100644
>  > > --- a/accel/kvm/kvm-all.c
>  > > +++ b/accel/kvm/kvm-all.c
>  > > @@ -340,14 +340,71 @@ err:
>  > >      return ret;
>  > >  }
>  > >
>  > > +void kvm_park_vcpu(CPUState *cpu)
>  > > +{
>  > > +    struct KVMParkedVcpu *vcpu;
>  > > +
>  > > +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>  > > +
>  > > +    vcpu =3D g_malloc0(sizeof(*vcpu));
>  > > +    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
>  > > +    vcpu->kvm_fd =3D cpu->kvm_fd;
>  > > +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu,
>  node); }
>  > > +
>  > > +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id) {
>  > > +    struct KVMParkedVcpu *cpu;
>  > > +    int kvm_fd =3D -ENOENT;
>  > > +
>  > > +    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
>  > > +        if (cpu->vcpu_id =3D=3D vcpu_id) {
>  > > +            QLIST_REMOVE(cpu, node);
>  > > +            kvm_fd =3D cpu->kvm_fd;
>  > > +            g_free(cpu);
>  > > +        }
>  > > +    }
>  > > +
>  > > +    trace_kvm_unpark_vcpu(vcpu_id, kvm_fd > 0 ? "unparked" : "not
>  > > + found parked");
>  > > +
>  > > +    return kvm_fd;
>  > > +}
>  > > +
>  > > +int kvm_create_vcpu(CPUState *cpu)
>  > > +{
>  > > +    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cpu);
>  > > +    KVMState *s =3D kvm_state;
>  > > +    int kvm_fd;
>  > > +
>  > > +    /* check if the KVM vCPU already exist but is parked */
>  > > +    kvm_fd =3D kvm_unpark_vcpu(s, vcpu_id);
>  > > +    if (kvm_fd < 0) {
>  > > +        /* vCPU not parked: create a new KVM vCPU */
>  > > +        kvm_fd =3D kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
>  > > +        if (kvm_fd < 0) {
>  > > +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu=
",
>  vcpu_id);
>  > > +            return kvm_fd;
>  > > +        }
>  > > +    }
>  > > +
>  > > +    cpu->kvm_fd =3D kvm_fd;
>  > > +    cpu->kvm_state =3D s;
>  > > +    cpu->vcpu_dirty =3D true;
>  > > +    cpu->dirty_pages =3D 0;
>  > > +    cpu->throttle_us_per_full =3D 0;
>  > > +
>  > > +    trace_kvm_create_vcpu(cpu->cpu_index, vcpu_id, kvm_fd);
>  > > +
>  > > +    return 0;
>  > > +}
>  > > +
>  > >  static int do_kvm_destroy_vcpu(CPUState *cpu)  {
>  > >      KVMState *s =3D kvm_state;
>  > >      long mmap_size;
>  > > -    struct KVMParkedVcpu *vcpu =3D NULL;
>  > >      int ret =3D 0;
>  > >
>  > > -    trace_kvm_destroy_vcpu();
>  > > +    trace_kvm_destroy_vcpu(cpu->cpu_index,
>  kvm_arch_vcpu_id(cpu));
>  > >
>  > >      ret =3D kvm_arch_destroy_vcpu(cpu);
>  > >      if (ret < 0) {
>  > > @@ -373,10 +430,7 @@ static int do_kvm_destroy_vcpu(CPUState
>  *cpu)
>  > >          }
>  > >      }
>  > >
>  > > -    vcpu =3D g_malloc0(sizeof(*vcpu));
>  > > -    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
>  > > -    vcpu->kvm_fd =3D cpu->kvm_fd;
>  > > -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
>  > > +    kvm_park_vcpu(cpu);
>  > >  err:
>  > >      return ret;
>  > >  }
>  > > @@ -389,24 +443,6 @@ void kvm_destroy_vcpu(CPUState *cpu)
>  > >      }
>  > >  }
>  > >
>  > > -static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id) -{
>  > > -    struct KVMParkedVcpu *cpu;
>  > > -
>  > > -    QLIST_FOREACH(cpu, &s->kvm_parked_vcpus, node) {
>  > > -        if (cpu->vcpu_id =3D=3D vcpu_id) {
>  > > -            int kvm_fd;
>  > > -
>  > > -            QLIST_REMOVE(cpu, node);
>  > > -            kvm_fd =3D cpu->kvm_fd;
>  > > -            g_free(cpu);
>  > > -            return kvm_fd;
>  > > -        }
>  > > -    }
>  > > -
>  > > -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
>  > > -}
>  > > -
>  > >  int kvm_init_vcpu(CPUState *cpu, Error **errp)  {
>  > >      KVMState *s =3D kvm_state;
>  > > @@ -415,19 +451,14 @@ int kvm_init_vcpu(CPUState *cpu, Error
>  **errp)
>  > >
>  > >      trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>  > >
>  > > -    ret =3D kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
>  > > +    ret =3D kvm_create_vcpu(cpu);
>  > >      if (ret < 0) {
>  > > -        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu f=
ailed
>  (%lu)",
>  > > +        error_setg_errno(errp, -ret,
>  > > +                         "kvm_init_vcpu: kvm_create_vcpu failed
>  > > + (%lu)",
>  > >                           kvm_arch_vcpu_id(cpu));
>  > >          goto err;
>  > >      }
>  > >
>  > > -    cpu->kvm_fd =3D ret;
>  > > -    cpu->kvm_state =3D s;
>  > > -    cpu->vcpu_dirty =3D true;
>  > > -    cpu->dirty_pages =3D 0;
>  > > -    cpu->throttle_us_per_full =3D 0;
>  > > -
>  > >      mmap_size =3D kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>  > >      if (mmap_size < 0) {
>  > >          ret =3D mmap_size;
>  > > diff --git a/accel/kvm/kvm-cpus.h b/accel/kvm/kvm-cpus.h index
>  > > ca40add32c..171b22fd29 100644
>  > > --- a/accel/kvm/kvm-cpus.h
>  > > +++ b/accel/kvm/kvm-cpus.h
>  > > @@ -22,5 +22,4 @@ bool kvm_supports_guest_debug(void);  int
>  > > kvm_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr
>  > > len);  int kvm_remove_breakpoint(CPUState *cpu, int type, vaddr
>  > > addr, vaddr len);  void kvm_remove_all_breakpoints(CPUState *cpu);
>  > > -
>  > >  #endif /* KVM_CPUS_H */
>  > > diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events index
>  > > 681ccb667d..37626c1ac5 100644
>  > > --- a/accel/kvm/trace-events
>  > > +++ b/accel/kvm/trace-events
>  > > @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev =
fd
>  %d, type 0x%x, arg %p"
>  > >  kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable t=
o
>  retrieve ONEREG %" PRIu64 " from KVM: %s"
>  > >  kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable t=
o
>  set ONEREG %" PRIu64 " to KVM: %s"
>  > >  kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d
>  id: %lu"
>  > > +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id, int
>  kvm_fd) "index: %d, id: %lu, kvm fd: %d"
>  > > +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index:
>  %d id: %lu"
>  > > +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d
>  id: %lu"
>  > > +kvm_unpark_vcpu(unsigned long arch_cpu_id, const char *msg) "id:
>  %lu %s"
>  > >  kvm_irqchip_commit_routes(void) ""
>  > >  kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s
>  vector %d virq %d"
>  > >  kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=3D%=
d"
>  > > @@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) "%s"
>  > >  kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64"
>  pages (took %"PRIi64" us)"
>  > >  kvm_dirty_ring_reaper_kick(const char *reason) "%s"
>  > >  kvm_dirty_ring_flush(int finished) "%d"
>  > > -kvm_destroy_vcpu(void) ""
>  > >  kvm_failed_get_vcpu_mmap_size(void) ""
>  > >  kvm_cpu_exec(void) ""
>  > >  kvm_interrupt_exit_request(void) ""
>  > > diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h index
>  > > c31d9c7356..c4a914b3d8 100644
>  > > --- a/include/sysemu/kvm.h
>  > > +++ b/include/sysemu/kvm.h
>  > > @@ -313,6 +313,31 @@ int kvm_create_device(KVMState *s, uint64_t
>  type, bool test);
>  > >   */
>  > >  bool kvm_device_supported(int vmfd, uint64_t type);
>  > >
>  > > +/**
>  > > + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
>  > > + * @cpu: QOM CPUState object for which KVM vCPU has to be
>  fetched/created.
>  > > + *
>  > > + * @returns: 0 when success, errno (<0) when failed.
>  > > + */
>  > > +int kvm_create_vcpu(CPUState *cpu);
>  > > +
>  > > +/**
>  > > + * kvm_park_vcpu - Park QEMU KVM vCPU context
>  > > + * @cpu: QOM CPUState object for which QEMU KVM vCPU context
>  has to be parked.
>  > > + *
>  > > + * @returns: none
>  > > + */
>  > > +void kvm_park_vcpu(CPUState *cpu);
>  > > +
>  > > +/**
>  > > + * kvm_unpark_vcpu - unpark QEMU KVM vCPU context
>  > > + * @s: KVM State
>  > > + * @vcpu_id: Architecture vCPU ID of the parked vCPU
>  > > + *
>  > > + * @returns: KVM fd
>  > > + */
>  > > +int kvm_unpark_vcpu(KVMState *s, unsigned long vcpu_id);
>  > > +
>  > >  /* Arch specific hooks */
>  > >
>  > >  extern const KVMCapabilityInfo kvm_arch_required_capabilities[];
>  >
> =20


