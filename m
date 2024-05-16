Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A98C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 08:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7WVy-0008JZ-6z; Thu, 16 May 2024 04:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s7WVo-0008J0-MH; Thu, 16 May 2024 04:30:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1s7WVk-00012l-IY; Thu, 16 May 2024 04:30:51 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vg39J3xZqz6D8cf;
 Thu, 16 May 2024 16:27:00 +0800 (CST)
Received: from lhrpeml100002.china.huawei.com (unknown [7.191.160.241])
 by mail.maildlp.com (Postfix) with ESMTPS id D486714038F;
 Thu, 16 May 2024 16:30:22 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 16 May 2024 09:30:22 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.039; 
 Thu, 16 May 2024 09:30:22 +0100
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "danielhb413@gmail.com" <danielhb413@gmail.com>, "vaibhav@linux.ibm.com"
 <vaibhav@linux.ibm.com>, "sbhat@linux.ibm.com" <sbhat@linux.ibm.com>
Subject: RE: [PATCH v2 1/4] accel/kvm: Extract common KVM vCPU {creation,
 parking} code
Thread-Topic: [PATCH v2 1/4] accel/kvm: Extract common KVM vCPU {creation,
 parking} code
Thread-Index: AQHap1J3XuFeE+ZUnUegULMwM5sk3bGZg7Uw
Date: Thu, 16 May 2024 08:30:22 +0000
Message-ID: <fc08e87c979a4916aaff649724df9c6b@huawei.com>
References: <20240516053211.145504-1-harshpb@linux.ibm.com>
 <20240516053211.145504-2-harshpb@linux.ibm.com>
In-Reply-To: <20240516053211.145504-2-harshpb@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.158.29]
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

Hi Harsh,

Thanks for your interest in the patch-set but taking away patches like
this from other series without any discussion can disrupt others work
and its acceptance on time. This is because we will have to put lot of
effort in rebasing bigger series and then testing overhead comes along
with it.

The patch-set (from where this  patch has been taken) is part of even
bigger series and there have been many people and companies toiling
to fix the bugs collectively in that series and for years.

I'm about float the V9 version of the Arch agnostic series which this
patch is part of and you can rebase your patch-set from there. I'm
hopeful that it will get accepted in this cycle.


Many thanks
Salil.

>  From: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  Sent: Thursday, May 16, 2024 6:32 AM
> =20
>  From: Salil Mehta <salil.mehta@huawei.com>
> =20
>  KVM vCPU creation is done once during the vCPU realization when Qemu
>  vCPU thread is spawned. This is common to all the architectures as of no=
w.
> =20
>  Hot-unplug of vCPU results in destruction of the vCPU object in QOM but
>  the corresponding KVM vCPU object in the Host KVM is not destroyed as
>  KVM doesn't support vCPU removal. Therefore, its representative KVM
>  vCPU object/context in Qemu is parked.
> =20
>  Refactor architecture common logic so that some APIs could be reused by
>  vCPU Hotplug code of some architectures likes ARM, Loongson etc. Update
>  new/old APIs with trace events instead of DPRINTF. No functional change =
is
>  intended here.
> =20
>  Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>  Reviewed-by: Gavin Shan <gshan@redhat.com>
>  Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>  Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>  Tested-by: Xianglai Li <lixianglai@loongson.cn>
>  Tested-by: Miguel Luis <miguel.luis@oracle.com>
>  Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
>  [harshpb: fixed rebase failures in include/sysemu/kvm.h]
>  Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  ---
>   include/sysemu/kvm.h   | 15 ++++++++++
>   accel/kvm/kvm-all.c    | 64 ++++++++++++++++++++++++++++++++--------
>  --
>   accel/kvm/trace-events |  5 +++-
>   3 files changed, 68 insertions(+), 16 deletions(-)
> =20
>  diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h index
>  eaf801bc93..fa3ec74442 100644
>  --- a/include/sysemu/kvm.h
>  +++ b/include/sysemu/kvm.h
>  @@ -434,6 +434,21 @@ void kvm_set_sigmask_len(KVMState *s, unsigned
>  int sigmask_len);
> =20
>   int kvm_physical_memory_addr_from_host(KVMState *s, void
>  *ram_addr,
>                                          hwaddr *phys_addr);
>  +/**
>  + * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
>  + * @cpu: QOM CPUState object for which KVM vCPU has to be
>  fetched/created.
>  + *
>  + * @returns: 0 when success, errno (<0) when failed.
>  + */
>  +int kvm_create_vcpu(CPUState *cpu);
>  +
>  +/**
>  + * kvm_park_vcpu - Park QEMU KVM vCPU context
>  + * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to
>  be parked.
>  + *
>  + * @returns: none
>  + */
>  +void kvm_park_vcpu(CPUState *cpu);
> =20
>   #endif /* COMPILING_PER_TARGET */
> =20
>  diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
>  d7281b93f3..30d42847de 100644
>  --- a/accel/kvm/kvm-all.c
>  +++ b/accel/kvm/kvm-all.c
>  @@ -128,6 +128,7 @@ static QemuMutex kml_slots_lock;  #define
>  kvm_slots_unlock()  qemu_mutex_unlock(&kml_slots_lock)
> =20
>   static void kvm_slot_init_dirty_bitmap(KVMSlot *mem);
>  +static int kvm_get_vcpu(KVMState *s, unsigned long vcpu_id);
> =20
>   static inline void kvm_resample_fd_remove(int gsi)  { @@ -340,14 +341,5=
3
>  @@ err:
>       return ret;
>   }
> =20
>  +void kvm_park_vcpu(CPUState *cpu)
>  +{
>  +    struct KVMParkedVcpu *vcpu;
>  +
>  +    trace_kvm_park_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>  +
>  +    vcpu =3D g_malloc0(sizeof(*vcpu));
>  +    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
>  +    vcpu->kvm_fd =3D cpu->kvm_fd;
>  +    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node); }
>  +
>  +int kvm_create_vcpu(CPUState *cpu)
>  +{
>  +    unsigned long vcpu_id =3D kvm_arch_vcpu_id(cpu);
>  +    KVMState *s =3D kvm_state;
>  +    int kvm_fd;
>  +
>  +    trace_kvm_create_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
>  +
>  +    /* check if the KVM vCPU already exist but is parked */
>  +    kvm_fd =3D kvm_get_vcpu(s, vcpu_id);
>  +    if (kvm_fd < 0) {
>  +        /* vCPU not parked: create a new KVM vCPU */
>  +        kvm_fd =3D kvm_vm_ioctl(s, KVM_CREATE_VCPU, vcpu_id);
>  +        if (kvm_fd < 0) {
>  +            error_report("KVM_CREATE_VCPU IOCTL failed for vCPU %lu",
>  vcpu_id);
>  +            return kvm_fd;
>  +        }
>  +    }
>  +
>  +    cpu->kvm_fd =3D kvm_fd;
>  +    cpu->kvm_state =3D s;
>  +    cpu->vcpu_dirty =3D true;
>  +    cpu->dirty_pages =3D 0;
>  +    cpu->throttle_us_per_full =3D 0;
>  +
>  +    return 0;
>  +}
>  +
>   static int do_kvm_destroy_vcpu(CPUState *cpu)  {
>       KVMState *s =3D kvm_state;
>       long mmap_size;
>  -    struct KVMParkedVcpu *vcpu =3D NULL;
>       int ret =3D 0;
> =20
>  -    trace_kvm_destroy_vcpu();
>  +    trace_kvm_destroy_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> =20
>       ret =3D kvm_arch_destroy_vcpu(cpu);
>       if (ret < 0) {
>  @@ -373,10 +413,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>           }
>       }
> =20
>  -    vcpu =3D g_malloc0(sizeof(*vcpu));
>  -    vcpu->vcpu_id =3D kvm_arch_vcpu_id(cpu);
>  -    vcpu->kvm_fd =3D cpu->kvm_fd;
>  -    QLIST_INSERT_HEAD(&kvm_state->kvm_parked_vcpus, vcpu, node);
>  +    kvm_park_vcpu(cpu);
>   err:
>       return ret;
>   }
>  @@ -397,6 +434,8 @@ static int kvm_get_vcpu(KVMState *s, unsigned long
>  vcpu_id)
>           if (cpu->vcpu_id =3D=3D vcpu_id) {
>               int kvm_fd;
> =20
>  +            trace_kvm_get_vcpu(vcpu_id);
>  +
>               QLIST_REMOVE(cpu, node);
>               kvm_fd =3D cpu->kvm_fd;
>               g_free(cpu);
>  @@ -404,7 +443,7 @@ static int kvm_get_vcpu(KVMState *s, unsigned long
>  vcpu_id)
>           }
>       }
> =20
>  -    return kvm_vm_ioctl(s, KVM_CREATE_VCPU, (void *)vcpu_id);
>  +    return -ENOENT;
>   }
> =20
>   int kvm_init_vcpu(CPUState *cpu, Error **errp) @@ -415,19 +454,14 @@
>  int kvm_init_vcpu(CPUState *cpu, Error **errp)
> =20
>       trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
> =20
>  -    ret =3D kvm_get_vcpu(s, kvm_arch_vcpu_id(cpu));
>  +    ret =3D kvm_create_vcpu(cpu);
>       if (ret < 0) {
>  -        error_setg_errno(errp, -ret, "kvm_init_vcpu: kvm_get_vcpu faile=
d
>  (%lu)",
>  +        error_setg_errno(errp, -ret,
>  +                         "kvm_init_vcpu: kvm_create_vcpu failed (%lu)",
>                            kvm_arch_vcpu_id(cpu));
>           goto err;
>       }
> =20
>  -    cpu->kvm_fd =3D ret;
>  -    cpu->kvm_state =3D s;
>  -    cpu->vcpu_dirty =3D true;
>  -    cpu->dirty_pages =3D 0;
>  -    cpu->throttle_us_per_full =3D 0;
>  -
>       mmap_size =3D kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
>       if (mmap_size < 0) {
>           ret =3D mmap_size;
>  diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events index
>  681ccb667d..75c1724e78 100644
>  --- a/accel/kvm/trace-events
>  +++ b/accel/kvm/trace-events
>  @@ -9,6 +9,10 @@ kvm_device_ioctl(int fd, int type, void *arg) "dev fd %=
d,
>  type 0x%x, arg %p"
>   kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to
>  retrieve ONEREG %" PRIu64 " from KVM: %s"
>   kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to se=
t
>  ONEREG %" PRIu64 " to KVM: %s"
>   kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id:
>  %lu"
>  +kvm_create_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d
>  id: %lu"
>  +kvm_get_vcpu(unsigned long arch_cpu_id) "id: %lu"
>  +kvm_destroy_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d
>  id: %lu"
>  +kvm_park_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id:
>  %lu"
>   kvm_irqchip_commit_routes(void) ""
>   kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s
>  vector %d virq %d"
>   kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=3D%d"
>  @@ -25,7 +29,6 @@ kvm_dirty_ring_reaper(const char *s) "%s"
>   kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pages
>  (took %"PRIi64" us)"
>   kvm_dirty_ring_reaper_kick(const char *reason) "%s"
>   kvm_dirty_ring_flush(int finished) "%d"
>  -kvm_destroy_vcpu(void) ""
>   kvm_failed_get_vcpu_mmap_size(void) ""
>   kvm_cpu_exec(void) ""
>   kvm_interrupt_exit_request(void) ""
>  --
>  2.39.3


