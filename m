Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B859C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redwz-0003DO-QG; Mon, 26 Feb 2024 11:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1redwu-0003D0-7U; Mon, 26 Feb 2024 11:35:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1redwa-0003ed-S3; Mon, 26 Feb 2024 11:35:27 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk5hL3BNrz6K6Zs;
 Tue, 27 Feb 2024 00:30:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 78704140A35;
 Tue, 27 Feb 2024 00:35:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 16:35:00 +0000
Date: Mon, 26 Feb 2024 16:34:59 +0000
To: <ankita@nvidia.com>
CC: <jgg@nvidia.com>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>, <ani@anisinha.ca>,
 <berrange@redhat.com>, <eduardo@habkost.net>, <imammedo@redhat.com>,
 <mst@redhat.com>, <eblake@redhat.com>, <armbru@redhat.com>,
 <david@redhat.com>, <gshan@redhat.com>, <zhiw@nvidia.com>,
 <mochs@nvidia.com>, <pbonzini@redhat.com>, <aniketa@nvidia.com>,
 <cjia@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <vsethi@nvidia.com>, <acurrid@nvidia.com>, <dnigam@nvidia.com>,
 <udhoke@nvidia.com>, <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Message-ID: <20240226163459.00002211@Huawei.com>
In-Reply-To: <20240223124223.800078-3-ankita@nvidia.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 23 Feb 2024 12:42:23 +0000
<ankita@nvidia.com> wrote:

> From: Ankit Agrawal <ankita@nvidia.com>
>=20
> ACPI spec provides a scheme to associate "Generic Initiators" [1]
> (e.g. heterogeneous processors and accelerators, GPUs, and I/O devices wi=
th
> integrated compute or DMA engines GPUs) with Proximity Domains. This is
> achieved using Generic Initiator Affinity Structure in SRAT. During bootu=
p,
> Linux kernel parse the ACPI SRAT to determine the PXM ids and create a NU=
MA
> node for each unique PXM ID encountered. Qemu currently do not implement
> these structures while building SRAT.
>=20
> Add GI structures while building VM ACPI SRAT. The association between
> device and node are stored using acpi-generic-initiator object. Lookup
> presence of all such objects and use them to build these structures.
>=20
> The structure needs a PCI device handle [2] that consists of the device B=
DF.
> The vfio-pci device corresponding to the acpi-generic-initiator object is
> located to determine the BDF.
>=20
> [1] ACPI Spec 6.3, Section 5.2.16.6
> [2] ACPI Spec 6.3, Table 5.80
>=20
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
Hi Ankit,

As the code stands the use of a list seems overkill.

Otherwise looks good to me.  I need Generic Ports support for CXL
stuff so will copy your approach for that as it's ended up nice
and simple.

Jonathan

> ---
>  hw/acpi/acpi-generic-initiator.c         | 84 ++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c                 |  3 +
>  include/hw/acpi/acpi-generic-initiator.h | 26 ++++++++
>  3 files changed, 113 insertions(+)
>=20
> diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-init=
iator.c
> index 1ade2f723f..d78382bc63 100644
> --- a/hw/acpi/acpi-generic-initiator.c
> +++ b/hw/acpi/acpi-generic-initiator.c
> @@ -68,3 +68,87 @@ static void acpi_generic_initiator_class_init(ObjectCl=
ass *oc, void *data)
>      object_class_property_add(oc, "node", "int", NULL,
>          acpi_generic_initiator_set_node, NULL, NULL);
>  }
> +
> +static int acpi_generic_initiator_list(Object *obj, void *opaque)
> +{
> +    GSList **list =3D opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
> +        *list =3D g_slist_append(*list, ACPI_GENERIC_INITIATOR(obj));
> +    }
> +
> +    object_child_foreach(obj, acpi_generic_initiator_list, opaque);

See below.  There is a recursive helper that avoids need for this.

> +    return 0;
> +}
> +
> +/*
> + * Identify Generic Initiator objects and link them into the list which =
is
> + * returned to the caller.
> + *
> + * Note: it is the caller's responsibility to free the list to avoid
> + * memory leak.
> + */
> +static GSList *acpi_generic_initiator_get_list(void)
> +{
> +    GSList *list =3D NULL;
> +
> +    object_child_foreach(object_get_root(),
> +                         acpi_generic_initiator_list, &list);

I think you can use object_child_foreach_recursive() and skip the manual
calling above?

> +    return list;
> +}
> +
> +/*
> + * ACPI 6.3:
> + * Table 5-78 Generic Initiator Affinity Structure
> + */
> +static void
> +build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
> +                                          PCIDeviceHandle *handle)
> +{
> +    uint8_t index;
> +
> +    build_append_int_noprefix(table_data, 5, 1);  /* Type */
> +    build_append_int_noprefix(table_data, 32, 1); /* Length */
> +    build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
> +    build_append_int_noprefix(table_data, 1, 1);  /* Device Handle Type:=
 PCI */
> +    build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain=
 */
> +
> +    /* Device Handle - PCI */
> +    build_append_int_noprefix(table_data, handle->segment, 2);
> +    build_append_int_noprefix(table_data, handle->bdf, 2);
> +    for (index =3D 0; index < 12; index++) {
> +        build_append_int_noprefix(table_data, 0, 1);
> +    }
> +
> +    build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* F=
lags */
> +    build_append_int_noprefix(table_data, 0, 4);     /* Reserved */
> +}
> +
> +void build_srat_generic_pci_initiator(GArray *table_data)
> +{
> +    GSList *gi_list, *list =3D acpi_generic_initiator_get_list();


Did you consider just have the functional called in the scan do this?
Not sure you need anything as a parameter beyond the GArray *table_data

Something like...

static int acpi_generic_initiator_list(Object *obj, void *opaque)
{
    uint8_t index;
    AcpiGenericInitiator *gi;
    GArray *table_data =3D opaque;
    PCIDeviceHandle dev_handle;
    PCIDevice *pci_dev;
    Object *o;

    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
        return 0;
    }

    gi =3D ACPI_GENERIC_INITIATOR(obj);
    o =3D object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NULL);
    if (!o) {
	error_setg(&error_abort, "GI: Specified device must be a PCI device.\n")
	return 1;
    }
    pci_dev =3D PCI_DEVICE(o);

    dev_handle.segment =3D 0;
    dev_handle.bdf =3D PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
                                               pci_dev->devfn);
    build_srat_generic_pci_initiator_affinity(table_data,
                                              gi->node, &dev_handle);
}

+ a call to.
    object_child_foreach_recursive(object_get_root(),
                                   acpi_generic_srat, table_data);=09

> +    AcpiGenericInitiator *gi;
> +
> +    for (gi_list =3D list; gi_list; gi_list =3D gi_list->next) {
> +        PCIDeviceHandle dev_handle;
> +        PCIDevice *pci_dev;
> +        Object *o;
> +
> +        gi =3D gi_list->data;
> +
> +        o =3D object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NUL=
L);
> +        if (!o) {
> +            error_printf("Specified device must be a PCI device.\n");
as above, use an errp rather than exit(1);
> +            exit(1);
> +        }
> +        pci_dev =3D PCI_DEVICE(o);
> +
> +        dev_handle.segment =3D 0;
> +        dev_handle.bdf =3D PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev=
)),
> +                                                   pci_dev->devfn);
> +        build_srat_generic_pci_initiator_affinity(table_data,
> +                                                  gi->node, &dev_handle);
Should we check for consistency of gi->node and
-numa node,id=3DX entries?

Maybe just check less than numa_state->num_nodes as that's the variable
used to walk the other structures when building srat.

> +    }
> +
> +    g_slist_free(list);
> +}
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 8bc35a483c..00d77327e0 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -58,6 +58,7 @@
>  #include "migration/vmstate.h"
>  #include "hw/acpi/ghes.h"
>  #include "hw/acpi/viot.h"
> +#include "hw/acpi/acpi-generic-initiator.h"
> =20
>  #define ARM_SPI_BASE 32
> =20
> @@ -558,6 +559,8 @@ build_srat(GArray *table_data, BIOSLinker *linker, Vi=
rtMachineState *vms)
>          }
>      }
> =20
> +    build_srat_generic_pci_initiator(table_data);
Perhaps passing in a suitable Error ** would be sensible.

> +
>      if (ms->nvdimms_state->is_enabled) {
>          nvdimm_build_srat(table_data);
>      }
> diff --git a/include/hw/acpi/acpi-generic-initiator.h b/include/hw/acpi/a=
cpi-generic-initiator.h
> index 2f183b029a..213545e614 100644
> --- a/include/hw/acpi/acpi-generic-initiator.h
> +++ b/include/hw/acpi/acpi-generic-initiator.h
> @@ -29,4 +29,30 @@ typedef struct AcpiGenericInitiatorClass {
>          ObjectClass parent_class;
>  } AcpiGenericInitiatorClass;
> =20
> +/*
> + * ACPI 6.3:
> + * Table 5-81 Flags =E2=80=93 Generic Initiator Affinity Structure
> + */
> +typedef enum {
> +    GEN_AFFINITY_ENABLED =3D (1 << 0), /*
> +                                      * If clear, the OSPM ignores the c=
ontents
> +                                      * of the Generic Initiator/Port Af=
finity
> +                                      * Structure. This allows system fi=
rmware
> +                                      * to populate the SRAT with a stat=
ic
> +                                      * number of structures, but only e=
nable
> +                                      * them as necessary.
> +                                      */
I'd put the comment above the definition to avoid wrapping so much!
> +} GenericAffinityFlags;
> +
> +/*
> + * ACPI 6.3:
> + * Table 5-80 Device Handle - PCI
> + */
> +typedef struct PCIDeviceHandle {
> +    uint16_t segment;
> +    uint16_t bdf;
> +} PCIDeviceHandle;
> +
> +void build_srat_generic_pci_initiator(GArray *table_data);
> +
>  #endif


