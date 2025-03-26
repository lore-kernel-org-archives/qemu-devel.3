Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280E7C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 18:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txVqY-0007P5-KC; Wed, 26 Mar 2025 14:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1txVqU-0007OM-Do; Wed, 26 Mar 2025 14:51:22 -0400
Received: from mail-mw2nam12on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:200a::62a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1txVqR-00069m-Lh; Wed, 26 Mar 2025 14:51:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oRFSxNHNz5TM3gOrmXzoXCcjIFBZbkOw16FeJZX1npFTu2wb0nJbaDmh+PBKxRCg8Q0SIbjnh65JrzMiWF4zBVxxlutohT43BykHMSWVtKUD0kAJ3/TRbt+RZGLazolsWX9uA8TV+uF+gAiWgTwoNivEIg3S2KkoRoQeZatJ+o65M/4if6K5OIMmko2/vVDX2EWtkSASo8dVdAps/Xq64ucQStA5bvH5Kx5qSHLC1P6wiH2gOeeGPJ2QSr/kamaEWC0yqXipWwfnShhhpJC/WADXXyx07laOO3kQNrehdkZa4IvWOuCMweE4y1pSFitO3RdHNgXiD8g0K8kaHjnvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ0VQfpRuxiR8TWXx/sO/+fxucs4nB3NIPkte6HYJF8=;
 b=mtVbnDGfPw4koZlWXON2QKBXxEKnCihCX1TvakpDrXeErNEpjGE3wtgiqZxPHY9uAsiuRzF8bV4Rng9VaOLE21PD7FakrYIjlSUX8GffskRvMxQQeYvEh5d3eOEdDCNNKEQU1zOGIz6Tu41Yh5wGxqJHy6SQi1Ut4zU/jswai1/ZGX45DuJTLGN7y6+T4OpWcRJAGl8tGuDfVwG+HvBRN3QvZP5m7+T5Vgs1jLw+CR4D8bmp8yz9dTz0g5nMxAdI/iH2bViPyWHF2aQon58SiWvJozSodV1JX/7Xb4g0ptFiExTSqf+uKDBwmHkcf0gxl2OAVF7CpmeLNUcQgRZuYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ0VQfpRuxiR8TWXx/sO/+fxucs4nB3NIPkte6HYJF8=;
 b=L+6GCxfq69j3wLFL4fZbCkfPTBwUuoqHF3HUl0wFNDUrm9VH1TjAwq6F1IgDBLcL45kZaqb3Z35r7LqlDXhbzEuHRofOEDUTeL/EhpcqxsAj4GNn/HKKz4xxlbpAAjxTfzWuw+Sg5ioUvLWzHbDKP8vrfrRgp6CnmLhfkNBT2IZEb13tXvawvLCEawSBRIE7YT3MvEPCLylekkzlhDiBQSLyogHHirLKvd8/dHTCyBUsO0H511S0ddAQdaY3iCrwJRXEvQHntsPmhNTN2w0mLz1G6tY5gSjVEu64lDfR+304jAEYSIJJSCHtniXoJENemboULC14oUTXVxdJmnRRVw==
Received: from BN8PR04CA0038.namprd04.prod.outlook.com (2603:10b6:408:d4::12)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 18:51:07 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::cc) by BN8PR04CA0038.outlook.office365.com
 (2603:10b6:408:d4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 18:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 18:51:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Mar
 2025 11:50:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 11:50:48 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Mar 2025 11:50:46 -0700
Date: Wed, 26 Mar 2025 11:50:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <jgg@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 19/20] hw/arm/virt-acpi-build: Update IORT with
 multiple smmuv3-accel nodes
Message-ID: <Z+RMg92cjxZkNyWJ@nvidia.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-20-shameerali.kolothum.thodi@huawei.com>
 <1b03e73c-f50b-4be6-b5a5-58f3e80f9161@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1b03e73c-f50b-4be6-b5a5-58f3e80f9161@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|SA0PR12MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: cf798d60-f14e-426d-4ebc-08dd6c972ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vWrkw1hDAQPuWh7K9A3HUZPvllhbAvC9+JXiqhidkrwQZp7eYNRvGxr26exK?=
 =?us-ascii?Q?jJCnEiqWTFPj+NJYvH1no7RkPS5+nmX+w1nalR7OIOi3NcUlF1Q1QjXAuUe1?=
 =?us-ascii?Q?Z4CSDWlvxoVj5/zMzL75JXB8iOhYDXtXDSUOLipY8tZrGUOr9bT65hyW8y1H?=
 =?us-ascii?Q?aOMbwdvnc8q+u0UEDQ0QNd08JpYTrp9dUJNFMoYqHEu9bDU+O8W+dL7kaHKi?=
 =?us-ascii?Q?9RBEYQlpCN44lV0xWmzt5c6TpBn8wLYbbPO0p58/96GsrApske9Q+He8jTWG?=
 =?us-ascii?Q?sE8/Sxe59k97OD9XYbqLvIgH4eYEtNCccwB0Mr1yP8xSYx4wMo9xg3OIqh/p?=
 =?us-ascii?Q?HGHIOmk9giYp98L8oYcMbqJmB/9kKikGfcWfbTb5hHIi4TPQKYbUdSurOXQF?=
 =?us-ascii?Q?tq+20bFgM3fMEgdFXxKtvMFxDsHBUwPtYgkQ8PWCOtAjCstynHM/jLv7/Iv9?=
 =?us-ascii?Q?Zfl538AYVdT0p22V1q45rgCJrZEXpx6E0oQciv6mc2Ms/zlSL0pcrIwM10DX?=
 =?us-ascii?Q?5wob1YCvsDKZc3Fn8U0gTd43da7WkLniNE9XaDf/vnQe+lIK2ovvuM99PzMj?=
 =?us-ascii?Q?lUzDpKeKCq7L6z8siRnOlruP7wxNkb0TgMXt7jpyhndKJS071ey+UIvNC0w5?=
 =?us-ascii?Q?YnjhNseYwDubbwLorb1Byt2a4zY9+TB+y/dQvFLPgwgQOmUoOfjdglOpSRE0?=
 =?us-ascii?Q?Hp9p91Hnbplk/eT29VkibMkboqiMYEBbePKQkwdKR3N15BFe7GiEboDLIZJg?=
 =?us-ascii?Q?hSjz4Hx34MiySv6jZ19K625ZJ5O158/Gdob4fG5D4LiNen4alFns9SoLsHe2?=
 =?us-ascii?Q?tZSTepsmmtsYAJyXZMGTGxAy4T5KhliIx3PcIIZa5zJlz7SF51Dm9LLLyJmt?=
 =?us-ascii?Q?4t6kBWKG3eW0KYUkFshRVj0qfFIAppb/yokYEk/qoLVWgwMFlyg2x/s/rE7B?=
 =?us-ascii?Q?5+ylM65+6YXs9qs5AjAOJgvPYs49F7OpOqiwIPnu1FwiNyJturU20bm6p322?=
 =?us-ascii?Q?/NdZgSuQ7sWBbwRRdrNw2bWSMrzYXgYu95H3foH2J7Y4Bw55iBjyj4LyYc32?=
 =?us-ascii?Q?90FwqqfmZbfiyLqGDgWlmHSXJfCuzLrlelYNW9Nv5uWBn5SZWh7senGRvEnN?=
 =?us-ascii?Q?aKUagknx5ADBTQ3aHDZ846zxJIsNUQdC1sn94UVxl9ReHOnGZbIavYihlA1U?=
 =?us-ascii?Q?AZU+P/62R2Hs7StDkSf4kgu7oO0QNwS8MGpX8nfrvNfYi2Vr4akllZ8Yg7LN?=
 =?us-ascii?Q?EcYfnuLk78LvWLeyTOZSo/A86//ETgNNF/SH30VK5HV7s9mTP6Hdvdv+0rpl?=
 =?us-ascii?Q?SHie+fKSft2Drv/9IfsrV2uF5CWo+jmfvX9EFXglHDeGGyuQjmn5cJEP1CEL?=
 =?us-ascii?Q?W9P6QhACZgNyYAJZcG3mQm4iaxzO+3+RqJlXsVtfACpj0nHP6w1uv0oMS3Wq?=
 =?us-ascii?Q?HgDOH/smO1pE6/n0qb7d3RyrLamcc47DmTFtCYAkRoActYw6iaL8lYnOihyb?=
 =?us-ascii?Q?cWX0K95dmB1VLoM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 18:51:07.0095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf798d60-f14e-426d-4ebc-08dd6c972ae2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478
Received-SPF: permerror client-ip=2a01:111:f403:200a::62a;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 26, 2025 at 07:14:31PM +0100, Eric Auger wrote:
> 
> 
> On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> > Now that we can have multiple user-creatable smmuv3-accel devices,
> > each associated with different pci buses, update IORT ID mappings
> > accordingly.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  hw/arm/virt-acpi-build.c | 113 +++++++++++++++++++++++++++++++++------
> >  1 file changed, 97 insertions(+), 16 deletions(-)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index 3ac8f8e178..c232850e36 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -43,6 +43,7 @@
> >  #include "hw/acpi/generic_event_device.h"
> >  #include "hw/acpi/tpm.h"
> >  #include "hw/acpi/hmat.h"
> > +#include "hw/arm/smmuv3-accel.h"
> >  #include "hw/pci/pcie_host.h"
> >  #include "hw/pci/pci.h"
> >  #include "hw/pci/pci_bus.h"
> > @@ -233,6 +234,51 @@ struct AcpiIortIdMapping {
> >  };
> >  typedef struct AcpiIortIdMapping AcpiIortIdMapping;
> >  
> > +struct SMMUv3Accel {
> > +    int irq;
> > +    hwaddr base;
> > +    AcpiIortIdMapping smmu_idmap;
> > +};
> > +typedef struct SMMUv3Accel SMMUv3Accel;
> > +
> > +static int smmuv3_accel_idmap_compare(gconstpointer a, gconstpointer b)
> > +{
> > +    SMMUv3Accel *accel_a = (SMMUv3Accel *)a;
> > +    SMMUv3Accel *accel_b = (SMMUv3Accel *)b;
> > +
> > +    return accel_a->smmu_idmap.input_base - accel_b->smmu_idmap.input_base;
> > +}
> > +
> > +static int get_smmuv3_accel(Object *obj, void *opaque)
> > +{
> > +    GArray *s_accel_blob = opaque;
> > +
> > +    if (object_dynamic_cast(obj, TYPE_ARM_SMMUV3_ACCEL)) {
> > +        PCIBus *bus = (PCIBus *) object_property_get_link(obj, "primary-bus",
> > +                                                          &error_abort);
> > +        if (bus && !pci_bus_bypass_iommu(bus)) {
> > +            SMMUv3Accel accel;
> > +            int min_bus, max_bus;
> > +            VirtMachineState *v = VIRT_MACHINE(qdev_get_machine());
> > +            PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(v->platform_bus_dev);
> > +            SysBusDevice *sbdev = SYS_BUS_DEVICE(obj);
> > +            hwaddr base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> > +            int irq = platform_bus_get_irqn(pbus, sbdev, 0);
> > +
> > +            base += v->memmap[VIRT_PLATFORM_BUS].base;
> > +            irq += v->irqmap[VIRT_PLATFORM_BUS];
> > +
> > +            pci_bus_range(bus, &min_bus, &max_bus);
> > +            accel.smmu_idmap.input_base = min_bus << 8;
> > +            accel.smmu_idmap.id_count = (max_bus - min_bus + 1) << 8;
> > +            accel.base = base;
> > +            accel.irq = irq + ARM_SPI_BASE;
> > +            g_array_append_val(s_accel_blob, accel);
> > +        }
> > +    }
> > +    return 0;
> > +}
> > +
> >  /* Build the iort ID mapping to SMMUv3 for a given PCI host bridge */
> >  static int
> >  iort_host_bridges(Object *obj, void *opaque)
> > @@ -275,30 +321,51 @@ static void
> >  build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >  {
> >      int i, nb_nodes, rc_mapping_count;
> > -    size_t node_size, smmu_offset = 0;
> > +    size_t node_size, *smmu_offset = NULL;
> >      AcpiIortIdMapping *idmap;
> > +    SMMUv3Accel *accel;
> > +    int num_smmus = 0;
> >      uint32_t id = 0;
> >      GArray *smmu_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> >      GArray *its_idmaps = g_array_new(false, true, sizeof(AcpiIortIdMapping));
> > +    GArray *smmuv3_accel = g_array_new(false, true, sizeof(SMMUv3Accel));
> >  
> >      AcpiTable table = { .sig = "IORT", .rev = 3, .oem_id = vms->oem_id,
> >                          .oem_table_id = vms->oem_table_id };
> >      /* Table 2 The IORT */
> >      acpi_table_begin(&table, table_data);
> >  
> > -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> > -        AcpiIortIdMapping next_range = {0};
> > -
> > +    nb_nodes = 2; /* RC, ITS */
> > +    if (vms->iommu == VIRT_IOMMU_SMMUV3_ACCEL) {
> > +        object_child_foreach_recursive(object_get_root(),
> > +                                       get_smmuv3_accel, smmuv3_accel);
> > +        /* Sort the smmuv3-accel by smmu idmap input_base */
> > +        g_array_sort(smmuv3_accel, smmuv3_accel_idmap_compare);
> > +
> > +        /*  Fill smmu idmap from sorted accel array */
> > +        for (i = 0; i < smmuv3_accel->len; i++) {
> > +            accel = &g_array_index(smmuv3_accel, SMMUv3Accel, i);
> > +            g_array_append_val(smmu_idmaps, accel->smmu_idmap);
> > +        }
> > +        num_smmus = smmuv3_accel->len;
> > +    } else if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> >          object_child_foreach_recursive(object_get_root(),
> >                                         iort_host_bridges, smmu_idmaps);
> >  
> >          /* Sort the smmu idmap by input_base */
> >          g_array_sort(smmu_idmaps, iort_idmap_compare);
> > +        num_smmus = 1;
> > +    }
> >  
> > -        /*
> > -         * Split the whole RIDs by mapping from RC to SMMU,
> > -         * build the ID mapping from RC to ITS directly.
> > -         */
> > +    /*
> > +     * Split the whole RIDs by mapping from RC to SMMU,
> > +     * build the ID mapping from RC to ITS directly.
> > +     */
> > +    if (num_smmus) {
> > +        AcpiIortIdMapping next_range = {0};
> > +
> > +        smmu_offset = g_new0(size_t, num_smmus);
> > +        nb_nodes += num_smmus;
> >          for (i = 0; i < smmu_idmaps->len; i++) {
> >              idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> >  
> > @@ -316,10 +383,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >              g_array_append_val(its_idmaps, next_range);
> >          }
> >  
> > -        nb_nodes = 3; /* RC, ITS, SMMUv3 */
> >          rc_mapping_count = smmu_idmaps->len + its_idmaps->len;
> >      } else {
> > -        nb_nodes = 2; /* RC, ITS */
> >          rc_mapping_count = 1;
> >      }
> >      /* Number of IORT Nodes */
> > @@ -341,10 +406,19 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >      /* GIC ITS Identifier Array */
> >      build_append_int_noprefix(table_data, 0 /* MADT translation_id */, 4);
> >  
> > -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> > -        int irq =  vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> > +    for (i = 0; i < num_smmus; i++) {
> > +        hwaddr base;
> > +        int irq;
> > +        if (vms->iommu == VIRT_IOMMU_SMMUV3_ACCEL) {
> > +            accel = &g_array_index(smmuv3_accel, SMMUv3Accel, i);
> > +            base = accel->base;
> > +            irq = accel->irq;
> > +        } else {
> > +            base = vms->memmap[VIRT_SMMU].base;
> > +            irq = vms->irqmap[VIRT_SMMU] + ARM_SPI_BASE;
> > +        }
> >  
> > -        smmu_offset = table_data->len - table.table_offset;
> > +        smmu_offset[i] = table_data->len - table.table_offset;
> >          /* Table 9 SMMUv3 Format */
> >          build_append_int_noprefix(table_data, 4 /* SMMUv3 */, 1); /* Type */
> >          node_size =  SMMU_V3_ENTRY_SIZE + ID_MAPPING_ENTRY_SIZE;
> > @@ -355,7 +429,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >          /* Reference to ID Array */
> >          build_append_int_noprefix(table_data, SMMU_V3_ENTRY_SIZE, 4);
> >          /* Base address */
> > -        build_append_int_noprefix(table_data, vms->memmap[VIRT_SMMU].base, 8);
> > +        build_append_int_noprefix(table_data, base, 8);
> >          /* Flags */
> >          build_append_int_noprefix(table_data, 1 /* COHACC Override */, 4);
> >          build_append_int_noprefix(table_data, 0, 4); /* Reserved */
> > @@ -404,15 +478,22 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> >      build_append_int_noprefix(table_data, 0, 3); /* Reserved */
> >  
> >      /* Output Reference */
> > -    if (vms->iommu == VIRT_IOMMU_SMMUV3) {
> > +    if (num_smmus) {
> >          AcpiIortIdMapping *range;
> > +        size_t offset;
> >  
> >          /* translated RIDs connect to SMMUv3 node: RC -> SMMUv3 -> ITS */
> >          for (i = 0; i < smmu_idmaps->len; i++) {
> > +            if (vms->iommu == VIRT_IOMMU_SMMUV3_ACCEL) {
> > +                offset = smmu_offset[i];
> > +            } else {
> > +                offset = smmu_offset[0];

> maybe we can also use smmu_offset array for non accel mode and get rid
> of this.

I recall that my previous version does combine two modes, i.e.
non-accel mode only uses smmu_offset[0]. Perhaps Shameer found
some mismatch between smmu_idmaps->len and num_smmus?

Nicolin

