Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7047C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 16:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfipU-0007Qv-Ol; Thu, 29 Feb 2024 11:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rfipR-0007PD-Mo; Thu, 29 Feb 2024 11:00:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rfipB-0006Cv-1n; Thu, 29 Feb 2024 11:00:13 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TlwmC1gRNz6K6Lg;
 Thu, 29 Feb 2024 23:55:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id A85DB14011D;
 Thu, 29 Feb 2024 23:59:31 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 15:59:11 +0000
Date: Thu, 29 Feb 2024 15:59:10 +0000
To: Jonathan Cameron via <qemu-devel@nongnu.org>
CC: Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 Zhi Wang <zhiw@nvidia.com>, "Matt Ochs" <mochs@nvidia.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Aniket Agashe
 <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, "Kirti Wankhede"
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>, Dheeraj Nigam
 <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
Subject: Re: [PATCH v7 2/2] hw/acpi: Implement the SRAT GI affinity structure
Message-ID: <20240229155910.00005186@huawei.com>
In-Reply-To: <20240227173621.00003694@Huawei.com>
References: <20240223124223.800078-1-ankita@nvidia.com>
 <20240223124223.800078-3-ankita@nvidia.com>
 <20240226164229.00001536@Huawei.com>
 <SA1PR12MB71992ECFBF9FA3EE3C350EA8B0592@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240227171115.00004c7b@Huawei.com>
 <20240227173621.00003694@Huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 27 Feb 2024 17:36:21 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 27 Feb 2024 17:11:15 +0000
> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
>=20
> > On Tue, 27 Feb 2024 08:37:15 +0000
> > Ankit Agrawal <ankita@nvidia.com> wrote:
> >  =20
> > > Thanks Jonathan for reviewing the change.
> > >=20
> > > Comments inline.
> > >    =20
> > > >> The structure needs a PCI device handle [2] that consists of the d=
evice BDF.
> > > >> The vfio-pci device corresponding to the acpi-generic-initiator ob=
ject is
> > > >> located to determine the BDF.
> > > >>
> > > >> [1] ACPI Spec 6.3, Section 5.2.16.6
> > > >> [2] ACPI Spec 6.3, Table 5.80
> > > >>
> > > >> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>     =20
> > > >Hi Ankit,
> > > >
> > > > As the code stands the use of a list seems overkill.     =20
> > >=20
> > > Yeah, I will try out your suggestion.
> > >    =20
> > > > Otherwise looks good to me.=A0 I need Generic Ports support for CXL
> > > > stuff so will copy your approach for that as it's ended up nice
> > > > and simple.
> > > >=20
> > > > Jonathan     =20
> > >=20
> > > Nice, would be good to have uniform implementations.   =20
> >=20
> > I've been messing around with this today.
> >=20
> > They differ only very trivially.
> > 2 Options.
> > 1) Have acpi-generic-port inherit from acpi-generic-initiator.
> >    Works but implies a relationship that isn't really true.
> > 2) Add an abstract base class. I've called it acpi-generic-node
> >    and have bother acpi-generic-initiator and acpi-generic-port
> >    inherit from it.
> >=20
> > The second feels more natural but is a tiny bit more code (a few
> > more empty init / finalize functions.
> >=20
> > If we are going to end up with an abstract base 'object' it
> > will be cleaner to do this all as one series if you don't mind
> > carrying the generic port stuff as well? Or I can smash the
> > two series together and send out an updated version that hopefully
> > meets both our requirements (+ tests etc).
> >=20
> > I'm just running tests against the CXL qos / generic port code
> > but assuming all goes well can share my additional changes
> > in next day or two.
> >=20
> > Jonathan =20
>=20
> One more thing.  Right now we can't use Generic Initiators as
> HMAT initiators.  That also wants fixing given that's their
> normal usecase rather than what you are using them for so it
> should 'work'.

Something along the lines of this will do the job.


diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index 4173ef2afa..825cfe86bc 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -41,6 +41,7 @@ struct NodeInfo {
     struct HostMemoryBackend *node_memdev;
     bool present;
     bool has_cpu;
+    bool has_gi;
     uint8_t lb_info_provided;
     uint16_t initiator;
     uint8_t distance[MAX_NODES];
diff --git a/hw/acpi/acpi-generic-initiator.c b/hw/acpi/acpi-generic-initia=
tor.c
index 9179590a42..8a67300320 100644
--- a/hw/acpi/acpi-generic-initiator.c
+++ b/hw/acpi/acpi-generic-initiator.c
@@ -6,6 +6,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/acpi-generic-initiator.h"
 #include "hw/pci/pci_device.h"
+#include "hw/boards.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/visitor.h"
@@ -58,6 +59,7 @@ static void acpi_generic_node_set_node(Object *obj, Visit=
or *v,
                                        const char *name, void *opaque,
                                        Error **errp)
 {
+    MachineState *ms =3D MACHINE(qdev_get_machine());
     AcpiGenericNode *gn =3D ACPI_GENERIC_NODE(obj);
     uint32_t value;
=20
@@ -72,6 +74,10 @@ static void acpi_generic_node_set_node(Object *obj, Visi=
tor *v,
     }
=20
     gn->node =3D value;
+
+    if (object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
+        ms->numa_state->nodes[gn->node].has_gi =3D true;
+    }
 }
=20
 static void acpi_generic_node_class_init(ObjectClass *oc, void *data)
diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index b933ae3c06..9b1662b6b8 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -225,7 +225,7 @@ static void hmat_build_table_structs(GArray *table_data=
, NumaState *numa_state)
     }
=20
     for (i =3D 0; i < numa_state->num_nodes; i++) {
-        if (numa_state->nodes[i].has_cpu) {
+        if (numa_state->nodes[i].has_cpu || numa_state->nodes[i].has_gi) {
             initiator_list[num_initiator++] =3D i;
         }
     }
diff --git a/hw/core/numa.c b/hw/core/numa.c
index f08956ddb0..58a32f1564 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -229,7 +229,8 @@ void parse_numa_hmat_lb(NumaState *numa_state, NumaHmat=
LBOptions *node,
                    node->target, numa_state->num_nodes);
         return;
     }
-    if (!numa_info[node->initiator].has_cpu) {
+    if (!numa_info[node->initiator].has_cpu &&
+        !numa_info[node->initiator].has_gi) {
         error_setg(errp, "Invalid initiator=3D%d, it isn't an "
                    "initiator proximity domain", node->initiator);
         return;

>=20
> Jonathan
>=20
> >=20
> >=20
> >  =20
>=20


