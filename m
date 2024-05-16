Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F9C6C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 15:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7cf4-00011X-9p; Thu, 16 May 2024 11:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7cey-00011B-Sk
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s7cew-00089b-Gd
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715871881;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qrQkV1p0QTpVS/kfYXtWZWbb3QILJbvMnewfbyJI0ug=;
 b=gkhFuWndeFuKdIPI52MM6j+HKgGwcskQTJuk7jV/PGJsE50rJ6QoyzV82ek28GKiLDsaYc
 sOY2ciUptPwlxWEdDUaNxKT9Z6cdz+WWn/IokVMBFHDn2SIaUamWIepiZpDtz2ObOP/kzK
 XuOXldO7FWHUuzgsOF6woo+mXH+vU8U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-XrUbFtUyMtiX7ogs4LJzZg-1; Thu,
 16 May 2024 11:04:37 -0400
X-MC-Unique: XrUbFtUyMtiX7ogs4LJzZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B16BC3800096;
 Thu, 16 May 2024 15:04:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B923B200B4D2;
 Thu, 16 May 2024 15:04:28 +0000 (UTC)
Date: Thu, 16 May 2024 16:04:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Cc: peter.maydell@linaro.org, philmd@linaro.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, quic_tsoni@quicinc.com,
 quic_pheragu@quicinc.com, quic_eberman@quicinc.com,
 quic_yvasi@quicinc.com, quic_cvanscha@quicinc.com,
 quic_mnalajal@quicinc.com
Subject: Re: [RFC/PATCH v2 03/12] hw/arm/virt: confidential guest support
Message-ID: <ZkYgeGSPxD_yt5oa@redhat.com>
References: <20240516143356.1739402-1-quic_svaddagi@quicinc.com>
 <20240516143356.1739402-4-quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240516143356.1739402-4-quic_svaddagi@quicinc.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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

On Thu, May 16, 2024 at 02:33:47PM +0000, Srivatsa Vaddagiri wrote:
> This adds support to launch hypervisor-assisted confidential guests,
> where guest's memory is protected from a potentially untrusted host.
> Hypervisor can setup host's page-tables so that it loses access to guest
> memory.
> 
> Since some guest drivers may need to communicate data with their host
> counterparts via shared memory, optionally allow setting aside some part
> of the confidential guest's memory as "shared". The size of this shared
> memory is specified via the optional "swiotlb-size" parameter.
> 
> -machine virt,confidential-guest-support=prot0 \
> 	-object arm-confidential-guest,id=prot0,swiotlb-size=16777216
> 
> The size of this shared memory is indicated to the guest in size/reg
> property of device-tree node "/reserved-memory/restricted_dma_reserved".
> A memory-region property is added to device-tree node representing
> virtio-pcie hub, so that all DMA allocations requested by guest's virtio-pcie
> device drivers are satisfied from the shared swiotlb region.

For reference, there is another series proposing confidential guest
support for the 'virt' machine on AArch64 with KVM

 https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg02742.html

I've no idea how closely your impl matches the KVM proposed impl. ie
whether we need 2 distinct "ConfidentialGuest" subclasses for KVM vs
Gunyah, or whether 1 can cope with both.  If we do need 2 distinct
subclasses for each hypervisor, then calling this Gunyah targetted
object 'arm-confidential-guest' is too broad of an name.

> 
> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> ---
>  qapi/qom.json         |  14 +++++
>  include/hw/arm/virt.h |   1 +
>  hw/arm/virt.c         | 141 +++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 155 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 38dde6d785..9b3cd7ce22 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -874,6 +874,18 @@
>    'base': 'RngProperties',
>    'data': { '*filename': 'str' } }
>  
> +##
> +# @ArmConfidentialGuestProperties:
> +#
> +# Properties for arm-confidential-guest objects.
> +#
> +# @swiotlb-size: swiotlb size
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'ArmConfidentialGuestProperties',
> +  'data': { 'swiotlb-size' : 'uint64' } }
> +
>  ##
>  # @SevGuestProperties:
>  #
> @@ -997,6 +1009,7 @@
>      { 'name': 'secret_keyring',
>        'if': 'CONFIG_SECRET_KEYRING' },
>      'sev-guest',
> +    'arm-confidential-guest',
>      'thread-context',
>      's390-pv-guest',
>      'throttle-group',
> @@ -1067,6 +1080,7 @@
>        'secret_keyring':             { 'type': 'SecretKeyringProperties',
>                                        'if': 'CONFIG_SECRET_KEYRING' },
>        'sev-guest':                  'SevGuestProperties',
> +      'arm-confidential-guest':     'ArmConfidentialGuestProperties',
>        'thread-context':             'ThreadContextProperties',
>        'throttle-group':             'ThrottleGroupProperties',
>        'tls-creds-anon':             'TlsCredsAnonProperties',
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index bb486d36b1..1e23f20972 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -165,6 +165,7 @@ struct VirtMachineState {
>      uint32_t clock_phandle;
>      uint32_t gic_phandle;
>      uint32_t msi_phandle;
> +    uint32_t restricted_dma_phandle;
>      uint32_t iommu_phandle;
>      int psci_conduit;
>      hwaddr highest_gpa;
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 3c93c0c0a6..2a3eb4075d 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -84,6 +84,9 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/char/pl011.h"
>  #include "qemu/guest-random.h"
> +#include "sysemu/cpus.h"
> +#include "exec/confidential-guest-support.h"
> +#include "qom/object_interfaces.h"
>  
>  static GlobalProperty arm_virt_compat[] = {
>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
> @@ -1545,6 +1548,11 @@ static void create_pcie(VirtMachineState *vms)
>                             nr_pcie_buses - 1);
>      qemu_fdt_setprop(ms->fdt, nodename, "dma-coherent", NULL, 0);
>  
> +    if (vms->restricted_dma_phandle) {
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "memory-region",
> +                                vms->restricted_dma_phandle);
> +    }
> +
>      if (vms->msi_phandle) {
>          qemu_fdt_setprop_cells(ms->fdt, nodename, "msi-map",
>                                 0, vms->msi_phandle, 0, 0x10000);
> @@ -2065,6 +2073,129 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
>      }
>  }
>  
> +#define TYPE_ARM_CONFIDENTIAL_GUEST "arm-confidential-guest"
> +OBJECT_DECLARE_SIMPLE_TYPE(ArmConfidentialGuestState, ARM_CONFIDENTIAL_GUEST)
> +
> +struct ArmConfidentialGuestState {
> +    ConfidentialGuestSupport parent_obj;
> +
> +    hwaddr swiotlb_size;
> +};
> +
> +static ArmConfidentialGuestState *acg;
> +
> +static void
> +arm_confidential_guest_instance_init(Object *obj)
> +{
> +    ArmConfidentialGuestState *acg = ARM_CONFIDENTIAL_GUEST(obj);
> +
> +    object_property_add_uint64_ptr(obj, "swiotlb-size", &acg->swiotlb_size,
> +                                   OBJ_PROP_FLAG_READWRITE);
> +}
> +
> +static const TypeInfo confidential_guest_info = {
> +    .parent = TYPE_CONFIDENTIAL_GUEST_SUPPORT,
> +    .name = TYPE_ARM_CONFIDENTIAL_GUEST,
> +    .instance_size = sizeof(ArmConfidentialGuestState),
> +    .instance_init = arm_confidential_guest_instance_init,
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +static void
> +confidential_guest_register_types(void)
> +{
> +    type_register_static(&confidential_guest_info);
> +}
> +type_init(confidential_guest_register_types);
> +
> +static int confidential_guest_init(MachineState *ms)
> +{
> +    ConfidentialGuestSupport *cgs = ms->cgs;
> +    ArmConfidentialGuestState *obj = (ArmConfidentialGuestState *)
> +        object_dynamic_cast(OBJECT(cgs), TYPE_ARM_CONFIDENTIAL_GUEST);
> +    const AccelOpsClass *ops = cpus_get_accel();
> +
> +    if (!obj) {
> +        return 0;
> +    }
> +
> +    if (!ops->check_capability ||
> +            !ops->check_capability(CONFIDENTIAL_GUEST_SUPPORTED)) {
> +        error_report("confidential guests are not supported");
> +        return -1;
> +    }
> +
> +    if (obj->swiotlb_size > ms->ram_size) {
> +        error_report("swiotlb_size exceeds RAM size");
> +        return -1;
> +    }
> +
> +    acg = obj;
> +    cgs->ready = true;
> +
> +    return 0;
> +}
> +
> +static void fdt_add_reserved_memory(VirtMachineState *vms)
> +{
> +    MachineState *ms = MACHINE(vms);
> +    hwaddr membase = vms->memmap[VIRT_MEM].base;
> +    hwaddr memsize = ms->ram_size;
> +    hwaddr resv_start;
> +    const char compat[] = "restricted-dma-pool";
> +    const AccelOpsClass *ops = cpus_get_accel();
> +    char *nodename;
> +
> +    if (!acg || !acg->swiotlb_size) {
> +        return;
> +    }
> +
> +    nodename = g_strdup_printf("/reserved-memory");
> +
> +    qemu_fdt_add_subnode(ms->fdt, nodename);
> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "#address-cells", 2);
> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "#size-cells", 2);
> +    qemu_fdt_setprop(ms->fdt, nodename, "ranges", NULL, 0);
> +    g_free(nodename);
> +
> +    resv_start = membase + memsize - acg->swiotlb_size;
> +    if (ops->check_capability &&
> +            ops->check_capability(CONFIDENTIAL_GUEST_CAN_SHARE_MEM_WITH_HOST)) {
> +        /*
> +         * Indicate only the size of swiotlb buffer needed. Guest will
> +         * determine where in its private memory the buffer will be placed and
> +         * will use appropriate (hypervisor) APIs to share that with host.
> +         */
> +        nodename = g_strdup_printf("/reserved-memory/restricted_dma_reserved");
> +        qemu_fdt_add_subnode(ms->fdt, nodename);
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "size", acg->swiotlb_size);
> +        qemu_fdt_setprop_cell(ms->fdt, nodename, "alignment", 4096);
> +    } else {
> +        /*
> +         * On hypervisors that don't support APIs for guest to share
> +         * its (private) memory with host, indicate to the guest where in its
> +         * address space shared memory can be found. Host should make arrangents
> +         * with hypervisor to assign some memory to guest at the indicated range
> +         * and mark it as shared.
> +         */
> +        nodename = g_strdup_printf("/reserved-memory/restricted_dma_reserved@%"
> +                PRIx64, resv_start);
> +        qemu_fdt_add_subnode(ms->fdt, nodename);
> +        qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg",
> +                                         2, resv_start,
> +                                         2, acg->swiotlb_size);
> +    }
> +
> +    vms->restricted_dma_phandle = qemu_fdt_alloc_phandle(ms->fdt);
> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "phandle",
> +            vms->restricted_dma_phandle);
> +    qemu_fdt_setprop(ms->fdt, nodename, "compatible", compat, sizeof(compat));
> +    g_free(nodename);
> +}
> +
>  static void machvirt_init(MachineState *machine)
>  {
>      VirtMachineState *vms = VIRT_MACHINE(machine);
> @@ -2075,7 +2206,7 @@ static void machvirt_init(MachineState *machine)
>      MemoryRegion *secure_sysmem = NULL;
>      MemoryRegion *tag_sysmem = NULL;
>      MemoryRegion *secure_tag_sysmem = NULL;
> -    int n, virt_max_cpus;
> +    int n, virt_max_cpus, ret;
>      bool firmware_loaded;
>      bool aarch64 = true;
>      bool has_ged = !vmc->no_ged;
> @@ -2084,6 +2215,12 @@ static void machvirt_init(MachineState *machine)
>  
>      possible_cpus = mc->possible_cpu_arch_ids(machine);
>  
> +    ret = confidential_guest_init(machine);
> +    if (ret != 0) {
> +        error_report("Failed to initialize confidential guest");
> +        exit(1);
> +    }
> +
>      /*
>       * In accelerated mode, the memory map is computed earlier in kvm_type()
>       * to create a VM with the right number of IPA bits.
> @@ -2195,6 +2332,8 @@ static void machvirt_init(MachineState *machine)
>  
>      create_fdt(vms);
>  
> +    fdt_add_reserved_memory(vms);
> +
>      assert(possible_cpus->len == max_cpus);
>      for (n = 0; n < possible_cpus->len; n++) {
>          Object *cpuobj;
> -- 
> 2.25.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


