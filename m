Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D866C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUMT-0002nC-6S; Mon, 24 Aug 2026 09:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyUMS-0002m9-5K
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyUMO-0008Ga-QA
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787576707;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnVF7wxZuMHmSqpdFpRhg1IwyvQ3MrvLJeqIcgbM0xM=;
 b=Y0/4krV5vhs65UENgBgIiB6euGDjuIy3PxO768LAhbfLoqnT3jusmAIQxH1Vxt7DHE+C+S
 vxnLT7Ozrh2eLXqzBnc0Y/TXwMFOvgVZzqDT8Mi1xFI1ErZHfx6eLXIBWDceR29szW58B9
 Nv7dGPGpLpxsdkfnsXiKMjFwMwUy1G0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-KOgvXjJ-OPuAIG9B9xzpbg-1; Mon,
 24 Aug 2026 09:05:04 -0400
X-MC-Unique: KOgvXjJ-OPuAIG9B9xzpbg-1
X-Mimecast-MFC-AGG-ID: KOgvXjJ-OPuAIG9B9xzpbg_1787576701
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A71FD1834506; Mon, 24 Aug 2026 13:05:01 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4768E18005AD; Mon, 24 Aug 2026 13:04:58 +0000 (UTC)
Date: Mon, 24 Aug 2026 14:04:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH v4 14/16] hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL
 from object prop to class prop
Message-ID: <aoxBd0tGArc8rwdf@redhat.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
 <20260821111550.276011-15-mark.caveayland@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821111550.276011-15-mark.caveayland@nutanix.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Fri, Aug 21, 2026 at 12:14:26PM +0100, Mark Cave-Ayland wrote:
> Move the ACPI_PCIHP_PROP_BSEL property to the PCIBus object and update all
> callers accordingly.
> 
> Since the existing logic checks for the existence of the ACPI_PCIHP_PROP_BSEL
> property to enable the relevant ACPI changes, set the type of the underlying
> variable to uint32_t with a default value of UINT32_MAX indicating that the
> property has not been set.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/hw/pci/pci_bus.h |  2 ++
>  hw/acpi/pci-bridge.c     |  9 ++++++++-
>  hw/acpi/pcihp.c          | 30 ++++++++++++++----------------
>  hw/arm/virt-acpi-build.c |  7 ++++++-
>  hw/i386/acpi-build.c     |  7 ++++++-
>  hw/pci/pci.c             |  7 +++++++
>  6 files changed, 43 insertions(+), 19 deletions(-)
> 
> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> index c738446788..7ecb23d13c 100644
> --- a/include/hw/pci/pci_bus.h
> +++ b/include/hw/pci/pci_bus.h
> @@ -56,6 +56,8 @@ struct PCIBus {
>      int *irq_count;
>  
>      Notifier machine_done;
> +
> +    uint32_t acpi_pcihp_bsel_val;
>  };
>  
>  static inline bool pci_bus_is_cxl(PCIBus *bus)
> diff --git a/hw/acpi/pci-bridge.c b/hw/acpi/pci-bridge.c
> index 394a919479..1bfc5431f2 100644
> --- a/hw/acpi/pci-bridge.c
> +++ b/hw/acpi/pci-bridge.c
> @@ -23,6 +23,8 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
>  
>      if (!DEVICE(br)->hotplugged) {
>          PCIBus *sec_bus = pci_bridge_get_sec_bus(br);
> +        Error *local_err = NULL;
> +        uint32_t bsel;
>  
>          build_append_pci_bus_devices(scope, sec_bus);
>  
> @@ -30,9 +32,14 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
>           * generate hotplug slots descriptors if
>           * bridge has ACPI PCI hotplug attached,
>           */
> -        if (object_property_find(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL)) {
> +        bsel = object_property_get_uint(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL,
> +                                        &local_err);
> +
> +        if (local_err == NULL && bsel != UINT32_MAX) {
>              build_append_pcihp_slots(scope, sec_bus);
>          }
> +
> +        error_free(local_err);

IIUC, in this new approach the property should always exist and so I'd
expect object_property_get_uint to always succeed.

IOW, is something stopping us using &error_abort and merely checking

  if (bsel != UINT32_MAX) 

?

>      }
>  }
>  
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index a91f523c93..b26ddf0a26 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -58,7 +58,7 @@ typedef struct AcpiPciHpFind {
>  static int acpi_pcihp_get_bsel(PCIBus *bus)
>  {
>      Error *local_err = NULL;
> -    uint64_t bsel = object_property_get_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
> +    uint32_t bsel = object_property_get_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
>                                               &local_err);
>  
>      if (local_err || bsel >= ACPI_PCIHP_MAX_HOTPLUG_BUS) {
> @@ -78,18 +78,14 @@ typedef struct {
>  static void *acpi_set_bsel(PCIBus *bus, void *opaque)
>  {
>      BSELInfo *info = opaque;
> -    unsigned *bus_bsel;
>      DeviceState *br = bus->qbus.parent;
>      bool is_bridge = IS_PCI_BRIDGE(br);
>  
>      /* hotplugged bridges can't be described in ACPI ignore them */
>      if (qbus_is_hotpluggable(BUS(bus))) {
>          if (!is_bridge || (!br->hotplugged && info->has_bridge_hotplug)) {
> -            bus_bsel = g_malloc(sizeof *bus_bsel);
> -
> -            *bus_bsel = info->bsel_alloc++;
> -            object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
> -                                           bus_bsel, OBJ_PROP_FLAG_READ);
> +            object_property_set_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
> +                                     info->bsel_alloc++, NULL);
>          }
>      }
>  
> @@ -730,14 +726,16 @@ bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus)
>      /* If bus supports hotplug select it and notify about local events */
>      bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
>      if (bsel) {
> -        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> -
> -        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
> -        aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
> -                                     aml_int(1))); /* Device Check */
> -        aml_append(method, aml_call2("DVNT", aml_name("PCID"),
> -                                     aml_int(3))); /* Eject Request */
> -        nr_notifiers++;
> +        uint32_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> +
> +        if (bsel_val != UINT32_MAX) {
> +            aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
> +            aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
> +                                         aml_int(1))); /* Device Check */
> +            aml_append(method, aml_call2("DVNT", aml_name("PCID"),
> +                                         aml_int(3))); /* Eject Request */
> +            nr_notifiers++;
> +        }
>      }
>  
>      /* Notify about child bus events in any case */
> @@ -848,7 +846,7 @@ void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus)
>      Aml *dev, *notify_method = NULL, *method;
>      QObject *bsel = object_property_get_qobject(OBJECT(bus),
>                          ACPI_PCIHP_PROP_BSEL, NULL);
> -    uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
> +    uint32_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
>      qobject_unref(bsel);
>  
>      aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f6386088b6..7ba7b38773 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -1207,6 +1207,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>      AcpiTable table = { .sig = "DSDT", .rev = 2, .oem_id = vms->oem_id,
>                          .oem_table_id = vms->oem_table_id };
>      Aml *pci0_scope;
> +    Error *local_err = NULL;
> +    uint32_t bsel;
>  
>      acpi_table_begin(&table, table_data);
>      dsdt = init_aml_allocator();
> @@ -1269,9 +1271,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>  
>      aml_append(pci0_scope, build_pci_bridge_edsm());
>      build_append_pci_bus_devices(pci0_scope, vms->bus);
> -    if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
> +    bsel = object_property_get_uint(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL,
> +                                    &local_err);
> +    if (local_err == NULL && bsel != UINT32_MAX) {
>          build_append_pcihp_slots(pci0_scope, vms->bus);
>      }
> +    error_free(local_err);
>  
>      if (vms->acpi_dev) {
>          bool acpi_pcihp;
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 8837b69687..cc0b6e5633 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1198,15 +1198,20 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      sb_scope = aml_scope("\\_SB");
>      {
>          Object *pci_host = acpi_get_i386_pci_host();
> +        Error *local_err = NULL;
> +        uint32_t bsel;
>  
>          if (pci_host) {
>              PCIBus *pbus = PCI_HOST_BRIDGE(pci_host)->bus;
>              Aml *ascope = aml_scope("PCI0");
>              /* Scan all PCI buses. Generate tables to support hotplug. */
>              build_append_pci_bus_devices(ascope, pbus);
> -            if (object_property_find(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL)) {
> +            bsel = object_property_get_uint(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL,
> +                                            &local_err);
> +            if (local_err == NULL && bsel != UINT32_MAX) {
>                  build_append_pcihp_slots(ascope, pbus);
>              }
> +            error_free(local_err);
>              aml_append(sb_scope, ascope);
>          }
>      }
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index d3191609e2..e8e8a3b767 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -25,6 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/datadir.h"
>  #include "qemu/units.h"
> +#include "hw/acpi/pcihp.h"
>  #include "hw/core/irq.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/pci_bridge.h"
> @@ -187,6 +188,8 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
>      bus->machine_done.notify = pcibus_machine_done;
>      qemu_add_machine_init_done_notifier(&bus->machine_done);
>  
> +    bus->acpi_pcihp_bsel_val = UINT32_MAX;
> +
>      vmstate_register_any(NULL, &vmstate_pcibus, bus);
>  }
>  
> @@ -302,6 +305,10 @@ static void pci_bus_class_init(ObjectClass *klass, const void *data)
>      pbc->numa_node = pcibus_numa_node;
>  
>      fwgc->get_data = pci_bus_fw_cfg_gen_data;
> +
> +    object_class_property_add_uint32_ptr(klass, ACPI_PCIHP_PROP_BSEL,
> +                                         offsetof(PCIBus, acpi_pcihp_bsel_val),
> +                                         OBJ_PROP_FLAG_READWRITE);
>  }
>  
>  static const TypeInfo pci_bus_info = {
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


