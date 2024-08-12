Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5071C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 14:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdVyX-0004Xo-0z; Mon, 12 Aug 2024 10:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sdVyU-0004X9-JI
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 10:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sdVyQ-0006sR-Ge
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 10:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723472675;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=K+DyPM375l9fLLJ8HmdkzMKiy3UwlRwCWi1WGNQtEAo=;
 b=EGArTzLJDSS9sY3OBBQgaECwnAlO3ynqw1lHF8qlVtT7aif0T6a+5gpLY2w4q1pCWHMYfJ
 lQDbgVh17mWkLOELe3CZaj8VL73iejb7Ua2ShuGBXLmUkyvYFFeOCTke/zBA72LDqvEBFI
 UnM9DsOQ/Off164UZJde5so+U+wazvU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-mWj_Xq15Pi-Cw-q4DGNuUw-1; Mon,
 12 Aug 2024 10:24:31 -0400
X-MC-Unique: mWj_Xq15Pi-Cw-q4DGNuUw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACC9E1944EB3; Mon, 12 Aug 2024 14:24:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.211])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FD5219560AE; Mon, 12 Aug 2024 14:24:23 +0000 (UTC)
Date: Mon, 12 Aug 2024 15:24:20 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, agraf@csgraf.de,
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Subject: Re: [PATCH v3 2/5] machine/nitro-enclave: Add vhost-user-vsock device
Message-ID: <ZrobFFVV4tN6dueh@redhat.com>
References: <20240810164502.19693-1-dorjoychy111@gmail.com>
 <20240810164502.19693-3-dorjoychy111@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240810164502.19693-3-dorjoychy111@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sat, Aug 10, 2024 at 10:44:59PM +0600, Dorjoy Chowdhury wrote:
> AWS Nitro Enclaves have built-in vhost-vsock device support which
> enables applications in enclave VMs to communicate with the parent
> EC2 VM over vsock. The enclave VMs have dynamic CID while the parent
> always has CID 3. In QEMU, the vsock emulation for nitro enclave is
> added using vhost-user-vsock as opposed to vhost-vsock. vhost-vsock
> doesn't support sibling VM communication which is needed for nitro
> enclaves.
> 
> In QEMU's nitro-enclave emulation, for the vsock communication to CID
> 3 to work, another process that does the vsock emulation in  userspace
> must be run, for example, vhost-device-vsock[1] from rust-vmm, with
> necessary vsock communication support in another guest VM with CID 3.
> A new mandatory nitro-enclave machine option 'vsock' has been added.
> The value for this option should be the chardev id from the '-chardev'
> option for the vhost-user-vsock device to work.
> 
> Using vhost-user-vsock also enables the possibility to implement some
> proxying support in the vhost-user-vsock daemon that will forward all
> the packets to the host machine instead of CID 3 so that users of
> nitro-enclave can run the necessary applications in their host machine
> instead of running another whole VM with CID 3.
> 
> [1] https://github.com/rust-vmm/vhost-device/tree/main/vhost-device-vsock
> 
> Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> ---
>  backends/hostmem-memfd.c        |   2 -
>  hw/core/machine.c               |  71 +++++++++---------
>  hw/i386/Kconfig                 |   1 +
>  hw/i386/nitro_enclave.c         | 123 ++++++++++++++++++++++++++++++++
>  include/hw/boards.h             |   2 +
>  include/hw/i386/nitro_enclave.h |   8 +++
>  include/sysemu/hostmem.h        |   2 +
>  7 files changed, 174 insertions(+), 35 deletions(-)
> 

> diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
> index 98690c6373..280ab4cc9b 100644
> --- a/hw/i386/nitro_enclave.c
> +++ b/hw/i386/nitro_enclave.c
> @@ -11,11 +11,81 @@
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "qom/object_interfaces.h"
>  
> +#include "chardev/char.h"
> +#include "hw/sysbus.h"
>  #include "hw/core/eif.h"
>  #include "hw/i386/x86.h"
>  #include "hw/i386/microvm.h"
>  #include "hw/i386/nitro_enclave.h"
> +#include "hw/virtio/virtio-mmio.h"
> +#include "hw/virtio/vhost-user-vsock.h"
> +#include "sysemu/hostmem.h"
> +
> +static BusState *find_free_virtio_mmio_bus(void)
> +{
> +    BusChild *kid;
> +    BusState *bus = sysbus_get_default();
> +
> +    QTAILQ_FOREACH(kid, &bus->children, sibling) {
> +        DeviceState *dev = kid->child;
> +        if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MMIO)) {
> +            VirtIOMMIOProxy *mmio = VIRTIO_MMIO(OBJECT(dev));
> +            VirtioBusState *mmio_virtio_bus = &mmio->bus;
> +            BusState *mmio_bus = &mmio_virtio_bus->parent_obj;
> +            if (QTAILQ_EMPTY(&mmio_bus->children)) {
> +                return mmio_bus;
> +            }
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +static void vhost_user_vsock_init(NitroEnclaveMachineState *nems)
> +{
> +    DeviceState *dev = qdev_new(TYPE_VHOST_USER_VSOCK);
> +    VHostUserVSock *vsock = VHOST_USER_VSOCK(dev);
> +    BusState *bus;
> +
> +    if (!nems->vsock) {
> +        error_report("A valid chardev id for vhost-user-vsock device must be "
> +                     "provided using the 'vsock' machine option");
> +        exit(1);
> +    }
> +
> +    bus = find_free_virtio_mmio_bus();
> +    if (!bus) {
> +        error_report("Failed to find bus for vhost-user-vsock device");
> +        exit(1);
> +    }
> +
> +    Chardev *chardev = qemu_chr_find(nems->vsock);
> +    if (!chardev) {
> +        error_report("Failed to find chardev with id %s", nems->vsock);
> +        exit(1);
> +    }
> +
> +    vsock->conf.chardev.chr = chardev;
> +
> +    qdev_realize_and_unref(dev, bus, &error_fatal);
> +}

Why does this machine need to create the vhost-user-vsock device itself ?
Doing it this way prevents the mgmt app from changing any of the other
vsock device settings beyond 'chardev'. The entity creating QEMU can use
-device to create the vsock device.


> +
> +static void nitro_enclave_devices_init(NitroEnclaveMachineState *nems)
> +{
> +    vhost_user_vsock_init(nems);
> +}
> +
> +static void nitro_enclave_machine_state_init(MachineState *machine)
> +{
> +    NitroEnclaveMachineClass *ne_class =
> +        NITRO_ENCLAVE_MACHINE_GET_CLASS(machine);
> +    NitroEnclaveMachineState *ne_state = NITRO_ENCLAVE_MACHINE(machine);
> +
> +    ne_class->parent_init(machine);
> +    nitro_enclave_devices_init(ne_state);
> +}
>  
>  static void nitro_enclave_machine_initfn(Object *obj)
>  {
> @@ -66,15 +136,68 @@ static void x86_load_eif(X86MachineState *x86ms, FWCfgState *fw_cfg,
>      return;
>  }
>  
> +static bool create_memfd_backend(MachineState *ms, const char *path,
> +                                 Error **errp)
> +{
> +    Object *obj;
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    bool r = false;
> +
> +    obj = object_new(TYPE_MEMORY_BACKEND_MEMFD);
> +    if (!object_property_set_int(obj, "size", ms->ram_size, errp)) {
> +        goto out;
> +    }
> +    object_property_add_child(object_get_objects_root(), mc->default_ram_id,
> +                              obj);
> +
> +    if (!user_creatable_complete(USER_CREATABLE(obj), errp)) {
> +        goto out;
> +    }
> +    r = object_property_set_link(OBJECT(ms), "memory-backend", obj, errp);
> +
> +out:
> +    object_unref(obj);
> +    return r;
> +}
> +
> +static char *nitro_enclave_get_vsock_chardev_id(Object *obj, Error **errp)
> +{
> +    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
> +
> +    return g_strdup(nems->vsock);
> +}
> +
> +static void nitro_enclave_set_vsock_chardev_id(Object *obj, const char *value,
> +                                               Error **errp)
> +{
> +    NitroEnclaveMachineState *nems = NITRO_ENCLAVE_MACHINE(obj);
> +
> +    g_free(nems->vsock);
> +    nems->vsock = g_strdup(value);
> +}
> +
>  static void nitro_enclave_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
>      MicrovmMachineClass *mmc = MICROVM_MACHINE_CLASS(oc);
> +    NitroEnclaveMachineClass *nemc = NITRO_ENCLAVE_MACHINE_CLASS(oc);
>  
>      mmc->x86_load_linux = x86_load_eif;
>  
>      mc->family = "nitro_enclave_i386";
>      mc->desc = "AWS Nitro Enclave";
> +
> +    nemc->parent_init = mc->init;
> +    mc->init = nitro_enclave_machine_state_init;
> +
> +    mc->create_default_memdev = create_memfd_backend;
> +
> +    object_class_property_add_str(oc, NITRO_ENCLAVE_VSOCK_CHARDEV_ID,
> +                                  nitro_enclave_get_vsock_chardev_id,
> +                                  nitro_enclave_set_vsock_chardev_id);
> +    object_class_property_set_description(oc, NITRO_ENCLAVE_VSOCK_CHARDEV_ID,
> +                                          "Set chardev id for vhost-user-vsock "
> +                                          "device");
>  }
>  
>  static const TypeInfo nitro_enclave_machine_info = {
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 48ff6d8b93..c268e7f005 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -308,6 +308,8 @@ struct MachineClass {
>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
>      ram_addr_t (*fixup_ram_size)(ram_addr_t size);
>      uint64_t smbios_memory_device_size;
> +    bool (*create_default_memdev)(MachineState *ms, const char *path,
> +                                  Error **errp);
>  };
>  
>  /**
> diff --git a/include/hw/i386/nitro_enclave.h b/include/hw/i386/nitro_enclave.h
> index a1dada9371..3e302de851 100644
> --- a/include/hw/i386/nitro_enclave.h
> +++ b/include/hw/i386/nitro_enclave.h
> @@ -14,12 +14,20 @@
>  #include "hw/i386/microvm.h"
>  #include "qom/object.h"
>  
> +/* Machine type options */
> +#define NITRO_ENCLAVE_VSOCK_CHARDEV_ID "vsock"
> +
>  struct NitroEnclaveMachineClass {
>      MicrovmMachineClass parent;
> +
> +    void (*parent_init)(MachineState *state);
>  };
>  
>  struct NitroEnclaveMachineState {
>      MicrovmMachineState parent;
> +
> +    /* Machine type options */
> +    char *vsock;
>  };
>  
>  #define TYPE_NITRO_ENCLAVE_MACHINE MACHINE_TYPE_NAME("nitro-enclave")
> diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
> index de47ae59e4..67f45abe39 100644
> --- a/include/sysemu/hostmem.h
> +++ b/include/sysemu/hostmem.h
> @@ -39,6 +39,8 @@ OBJECT_DECLARE_TYPE(HostMemoryBackend, HostMemoryBackendClass,
>   */
>  #define TYPE_MEMORY_BACKEND_FILE "memory-backend-file"
>  
> +#define TYPE_MEMORY_BACKEND_MEMFD "memory-backend-memfd"
> +
>  
>  /**
>   * HostMemoryBackendClass:
> -- 
> 2.39.2
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


