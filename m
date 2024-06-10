Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5627C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 17:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGj7l-000249-SW; Mon, 10 Jun 2024 13:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sGj7k-00023k-IE
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:48:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sGj7h-00087s-2C
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 13:48:03 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VyfKC0PBNz6K5sk;
 Tue, 11 Jun 2024 01:42:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id EC8F81404F5;
 Tue, 11 Jun 2024 01:47:46 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 10 Jun
 2024 18:47:46 +0100
Date: Mon, 10 Jun 2024 18:47:45 +0100
To: Igor Mammedov <imammedo@redhat.com>
CC: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 <qemu-devel@nongnu.org>, <ankita@nvidia.com>, <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, 
 Huang Ying <ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH qemu ] hw/acpi: Fix big endian host creation of Generic
 Port Affinity Structures
Message-ID: <20240610184745.00006683@huawei.com>
In-Reply-To: <20240606184716.00000708@Huawei.com>
References: <20240605180455.18193-1-Jonathan.Cameron@huawei.com>
 <20240606160653.27226def@imammedo.users.ipa.redhat.com>
 <20240606184716.00000708@Huawei.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi Igor,

Some code snippets below to try and see if I'm on the correct track
for what you had in mind.

> >   
> > > diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
> > > index 78b80dcf08..f064753b67 100644
> > > --- a/hw/acpi/acpi_generic_initiator.c
> > > +++ b/hw/acpi/acpi_generic_initiator.c
> > > @@ -151,7 +151,9 @@ build_srat_generic_node_affinity(GArray *table_data, int node,
> > >          build_append_int_noprefix(table_data, 0, 12);
> > >      } else {
> > >          /* Device Handle - ACPI */
> > > -        build_append_int_noprefix(table_data, handle->hid, 8);
> > > +        for (int i = 0; i < sizeof(handle->hid); i++) {
> > > +            build_append_int_noprefix(table_data, handle->hid[i], 1);
> > > +        }
> > >          build_append_int_noprefix(table_data, handle->uid, 4);
> > >          build_append_int_noprefix(table_data, 0, 4);    
> > 
> > instead of open codding structure
> > 
> > it might be better to introduce helper in aml_build.c
> > something like 
> >   /* proper reference to spec as we do for other ACPI primitives */
> >   build_append_srat_acpi_device_handle(GArray *table_data, char* hid, unit32_t uid)
> >       assert(strlen(hid) ...
> >       for() {
> >             build_append_byte()
> >       }          
> >       ...
> > 
> > the same applies to "Device Handle - PCI" structure  
> 
> I'll look at moving that stuff and the affinity structure creation
> code themselves in there. I think they ended up in this file because
> of the other infrastructure needed to create these nodes and it
> will have felt natural to keep this together.
> 
> Putting it in aml_build.c will put it with similar code though
> which makes sense to me.

This all works out fine, though there is less reason to keep a
ACPI_GENERIC_NODE base under GENERIC_PORT and GENERIC_INITIATOR
so I may drop that and just have a small amount of code duplication.

> 
> > 
> > Also get rid of PCI deps in acpi_generic_initiator.c 
> > move build_all_acpi_generic_initiators/build_srat_generic_pci_initiator into
> > hw/acpi/pci.c  
> 
> Today it's used only for PCI devices, but that's partly an artifact
> of how we get to the root complex via the bus below it.
> 
> Spec wise, it's just as applicable to platform devices etc, but maybe
> we can move it to pci.c for now and move it out again if it gains other
> users. Or leave it in acpi_generic_initiator.c but have all the aml
> stuff in aml_build.c as you suggest. 
> 
> > file if it has to access PCI code/structures directly
> > (which I'm not convinced it should, can we get/expose what it needs as QOM properties?)  
> 
> Maybe. I'll see what I can come up with.  This feels involved
> however so I'm more doubtful about this as a precursor.

This is a little messy and tricky to get the right level of generic.
For the bdf, were you thinking something along the lines of the following?

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 324c1302d2..75366491b7 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset_hold(Object *obj, ResetType type);
 static bool pcie_has_upstream_port(PCIDevice *dev);

+static void prop_pci_bdf_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint16_t bdf = pci_get_bdf(PCI_DEVICE(obj));
+
+    visit_type_uint16(v, name, &bdf, errp);
+}
+
+static const PropertyInfo prop_pci_bdf = {
+    .name = "bdf",
+    .get = prop_pci_bdf_get,
+};
+
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
@@ -85,6 +98,7 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    { .name = "bdf", .info = &prop_pci_bdf },
     DEFINE_PROP_END_OF_LIST()
 };


The other case is where I need to get the ACPI UID associate with a
root complex. Now that has to be matched to the appropriate HID and so
far the only one of those is ACPI0016 which is the HID for
TYPE_PXB_CXL_DEV. That happens to the bus number of the
TYPE_PXB_CXL_BUS but that connection should probably not be explicit
outside of the PXB specific code.

I can add a property like: 

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index f5431443b9..1c51f3f5b6 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -92,6 +92,21 @@ static void pxb_bus_class_init(ObjectClass *class, void *data)
     pbc->numa_node = pxb_bus_numa_node;
 }

+static void prop_pxb_cxl_uid_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint32_t uid = pci_bus_num(PCI_BUS(obj));
+
+    visit_type_uint32(v, name, &uid, errp);
+}
+
+static void pxb_cxl_bus_class_init(ObjectClass *class, void *data)
+{
+    pxb_bus_class_init(class, data);
+    object_class_property_add(class, "acpi_uid", "uint32",
+                              prop_pxb_cxl_uid_get, NULL, NULL, NULL);
+}
+
 static const TypeInfo pxb_bus_info = {
     .name          = TYPE_PXB_BUS,
     .parent        = TYPE_PCI_BUS,
@@ -110,7 +125,7 @@ static const TypeInfo pxb_cxl_bus_info = {
     .name          = TYPE_PXB_CXL_BUS,
     .parent        = TYPE_CXL_BUS,
     .instance_size = sizeof(PXBBus),
-    .class_init    = pxb_bus_class_init,
+    .class_init    = pxb_cxl_bus_class_init,
 };

 static const char *pxb_host_root_bus_path(PCIHostState *host_bridge,

and query it when setting up the generic port with

        const char *hid = "ACPI0016";
        uint32_t uid;

        if (gn->node >= ms->numa_state->num_nodes) {
            error_printf("%s: node %d is invalid.\n",
                         TYPE_ACPI_GENERIC_PORT, gn->node);
            exit(1);
        }

        o = object_resolve_path_type(gn->pci_dev, TYPE_PXB_CXL_BUS, NULL);
        if (!o) {
            error_printf("%s: device must be a CXL host bridge.\n",
                         TYPE_ACPI_GENERIC_PORT);
            exit(1);
        }

        uid = object_property_get_uint(o, "acpi_uid", &error_fatal);
        build_srat_acpi_generic_port(table_data, gn->node, hid, uid);

        return 0;

Thanks,

Jonathan

> 
> > 
> > btw:
> > build_all_acpi_generic_initiators() name doesn't match what it's doing.
> > it composes only one initiator entry.  
> 
> I'll look at tidying up all the relevant naming.
> 
> Jonathan
> 
> >   
> > >      }    
> > 
> >   
> 
> 
> 


