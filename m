Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C8CC54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHsGV-0008Rg-Gc; Wed, 21 May 2025 18:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uHsGN-0008R1-5g
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:50:15 -0400
Received: from mail-mw2nam10on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2412::604]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uHsGI-00080z-LP
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:50:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGZUqI/4kA+5JWyPYI4+WsBEKoluPnSFcH7VXACsAqcwmoOCUIGIUv6Tn34i8d8dxTj6ChGfm5n+IM5YnIn/+jkaJ8q1OIRmJ3CfyKZQq12+UFHwkKwsCUUVtGn6q0Y4IEvgVo1rPDMnpdfLHQ/Ip15LclCdgD+FTux23oNU8MNQBMWJjwFkBdFj3gxVgSUBkSiGoqFovSgPo2l1XcONpIokB+tUPwz73a5I8O5tsK9NydreHaNNBdhictsUUviyOgZHg6sdZ6w2Frq8nQJoVDAqVm6X3JLTg4nVC+GbVHMrcO2pCPEUC9kqGguoe0mX0qvYD9QrP3nx9m0nP8eRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M5zLoXBCsBMk7yWFPL3F9XTi/Z5TWIOEBY+lKpA/Dw=;
 b=AlgPbLLSCN+LOhvQNlnCO8I5jxXeZwJriweHANzHnmNSO/ZjWrhtgOj++XkCU4p+5BstrOas2Pv121V+TOB2dXJ66MNl/z+rxbgdKKXZ9R7Co+01574JVKSeDNyw4vfaQGvWXfunOFNWMJWwjtXXm4sMH6pdvkQ2l+TMN5FEew6boXklRYx+iS3bMg3nz0WJXj1WG/Rae3dXW9ag1tSvotwhEbsn07OdstN/hScSSQITkZzpSmvXFvHRn1Q6f+zsqJ62N440aTBKXBduh5NOQ9CK+nBwXytSHLDrbuKItw299lbj/j2+iGP9K2qHkRK3Jtap8sbeAlAJZiDUBbFWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1M5zLoXBCsBMk7yWFPL3F9XTi/Z5TWIOEBY+lKpA/Dw=;
 b=SfPEvTP/tc9tOY+QALxDNI+vpiEMNxVvy6KqCmmnechTJon4Pc91uwDR+gnjzdAAWKmPxMq2OWpUELkv+Gx4ezYZAZJg+DU1jmdNJtagIfm6C02UxknYhr9euuH5dl8JxNYVQO2/AkgVM48a+OIAn/+hKwMWM0VoytuRSwu98ZZwE6wcomBtqQpH4RwXeICzFQI6sqJSSzNlkN0Yz38go/KMt2zx9gPh+k1sNtjOYBrRK1L4+fXy1PiVBaEbS+sH08gxrX1K4wGoVUCBiLTnasuWqBVdBnq7UIMpqEqXLYmci9cGxkYog1pWG5zCovggxq2cNKSgXVSCWRoJKaExUA==
Received: from BL1PR13CA0298.namprd13.prod.outlook.com (2603:10b6:208:2bc::33)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 22:50:02 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2bc:cafe::75) by BL1PR13CA0298.outlook.office365.com
 (2603:10b6:208:2bc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.15 via Frontend Transport; Wed,
 21 May 2025 22:50:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 22:50:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 21 May
 2025 15:49:51 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 21 May
 2025 15:49:50 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 21 May 2025 15:49:49 -0700
Date: Wed, 21 May 2025 15:49:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Message-ID: <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250521111452.3316354-16-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: e0bd6ba8-b462-4fd4-ce5d-08dd98b9d298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n8exM1QKadLRXiqOO5rtQtRQL9IqHL4dDXYRV0PvuoEHj5Igp1bh9t7hq0Sx?=
 =?us-ascii?Q?8dH9bH/ZJ6TKVGBIGjFUKjUaMKTriminTg+1YM0byr3Ajz0RVUcLp6S3S6rF?=
 =?us-ascii?Q?jcGzXt1NBY5g5wpL5QUCwMFFflwCn8YqzbSEHBWPANthke4H0t8lpb1y7pW6?=
 =?us-ascii?Q?A5Y4GnGOunzktWUdCkQf5N7d/SXIEs+rrNp0/rX/3UQ6SxRzGWIYqxuqxjUi?=
 =?us-ascii?Q?96Zayb+L6L7EIM/9DN4nl9oMOIk73b/3wcfoFQAKVjr1mU82zuNKhKvNEnWd?=
 =?us-ascii?Q?9FxqHGRBB2vdzEFWePdaVatSDqLHnk7+A7tLXFg2duHTgCOWNhkaGQp2HD4+?=
 =?us-ascii?Q?ckGNT3aVeFNZpwRkT8qaGgydEAZcfL3hYmwkWIqYZMJztUHNhb0CMIXq5awm?=
 =?us-ascii?Q?esmKvI+aRvb7DLTgPlN8oL1I7NilWBT0TmS4yJK+zGEw3muoY466wrSW5/lc?=
 =?us-ascii?Q?YdPmEChl+rfZr9rfEcwHclJz+5h0M/xyWYXAaN1lS+Oqtr9JnVd+r3Zu8Ic8?=
 =?us-ascii?Q?XW5Xeprh5Bi1GdwHyHuO9ZyxScF3DsILv88PHtgapIb5YGhsNudiiXSWVabA?=
 =?us-ascii?Q?341n2Z+p6jTljbJkHpUuZmbpZbQwiy1nLfz0w+GCY31W/6VdCSot19FCuMsL?=
 =?us-ascii?Q?+KM6aolsuX08ZY0DkHWgsT4XTVfQpE9JPCyzRekpxCOI7PxaM4kkSYgQnWjm?=
 =?us-ascii?Q?XpmwOJyqEexTJbon0GPkKQNKsIIj74FU5JempGmix/YNAUaldYwM182OzLy6?=
 =?us-ascii?Q?Od8/NstjTwwPpII9x5QzJL7f5M5CthPbWvt4y5QyVcJ40p+ymzv//eIYz7XJ?=
 =?us-ascii?Q?NwsGhrWDp9rF9gu5GpTTH0ur7vvivZG0PUjGREHIS1p4i1G32CLbAb8aVywY?=
 =?us-ascii?Q?imS3QguvCkZMv4KmMBhfNlZ39cqcQxlYLFq94QeO+hc2xxaXUXwtLMfFzqG6?=
 =?us-ascii?Q?mpA/v4LivpVj+ZP0eZbJebx2M3X6kK0UtVqqfX7X4dZZGCkgIZLDGAPo85Sy?=
 =?us-ascii?Q?9X8V3Bw+FTXfyvA/Y/06FwFFeP36dXeUWBD3gCCaQ06HAT9lIvA6r2kNbtA5?=
 =?us-ascii?Q?qITc6vQQjULSvwXiqtcAqbGBf/X1xrFY0x6iyEp1r4h7nDVjHCv57kbWU9sU?=
 =?us-ascii?Q?F4JE2TV2U42aT1vjxWrlBh4pyQ0b4qRIiyqXIgYJrcPt3fXsovoQt/I51DDA?=
 =?us-ascii?Q?lKP7omGyE5UPp6dEeHPkzQu2Kp7CW6gqo3ntdbikR+P+V2omrYZ7glruds/4?=
 =?us-ascii?Q?6ZI3CFOrB0dt+iofos/O6zNQQqUL3A2Oufma1eNx8LXUttLvdyGXcTABb4sw?=
 =?us-ascii?Q?bo/+JOoqwE8q9C8bUIv5f7iQl4xQJlcv5XdaFpDnvwl8/1bVOBiRFQ7e/Ul4?=
 =?us-ascii?Q?CosOFZcDMyxxd0xA8dd8r1IZ45eynWZgXxZZf12XYG3MJQ/64iBTWjQLbJVk?=
 =?us-ascii?Q?b/qdT5OO/4IDs1k4i0+uNFa40/rqeYar4LdxP2HtTI/9EDzvUQhUNlvClhGa?=
 =?us-ascii?Q?um1cPe1KqeLggwG45C6rE/01uXpvsGkOJB0p?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 22:50:02.4440 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0bd6ba8-b462-4fd4-ce5d-08dd98b9d298
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
Received-SPF: permerror client-ip=2a01:111:f403:2412::604;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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

On Wed, May 21, 2025 at 07:14:45PM +0800, Zhenzhong Duan wrote:
> +static const MemoryListener iommufd_s2domain_memory_listener = {
> +    .name = "iommufd_s2domain",
> +    .priority = 1000,
> +    .region_add = iommufd_listener_region_add_s2domain,
> +    .region_del = iommufd_listener_region_del_s2domain,
> +};

Would you mind elaborating When and how vtd does all S2 mappings?

On ARM, the default vfio_memory_listener could capture the entire
guest RAM and add to the address space. So what we do is basically
reusing the vfio_memory_listener:
https://lore.kernel.org/qemu-devel/20250311141045.66620-13-shameerali.kolothum.thodi@huawei.com/
 
The thing is that when a VFIO device is attached to the container
upon a nesting configuration, the ->get_address_space op should
return the system address space as S1 nested HWPT isn't allocated
yet. Then all the iommu as routines in vfio_listener_region_add()
would be skipped, ending up with mapping the guest RAM in S2 HWPT
correctly. Not until the S1 nested HWPT is allocated by the guest
OS (after guest boots), can the ->get_address_space op return the
iommu address space.

With this address space shift, S2 mappings can be simply captured
and done by vfio_memory_listener. Then, such an s2domain listener
would be largely redundant.

So the second question is:
Does vtd have to own this iommufd_s2domain_memory_listener? IOW,
does vtd_host_dma_iommu() have to return the iommu address space
all the time?

> +static int vtd_create_s1_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                              VTDS2Hwpt *s2_hwpt, VTDHwpt *hwpt,
> +                              VTDPASIDEntry *pe, Error **errp)
> +{
> +    struct iommu_hwpt_vtd_s1 vtd;
> +    uint32_t hwpt_id, s2_hwpt_id = s2_hwpt->hwpt_id;
> +
> +    vtd_init_s1_hwpt_data(&vtd, pe);
> +
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                    s2_hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
> +                                    sizeof(vtd), &vtd, &hwpt_id, errp)) {
> +        return -EINVAL;
> +    }
> +
> +    hwpt->hwpt_id = hwpt_id;
> +
> +    return 0;
> +}
> +
> +static void vtd_destroy_s1_hwpt(HostIOMMUDeviceIOMMUFD *idev, VTDHwpt *hwpt)
> +{
> +    iommufd_backend_free_id(idev->iommufd, hwpt->hwpt_id);
> +}

I think you did some substantial work to isolate the get_hw_info
part inside the iommufd backend code, which looks nice and clean
as the vIOMMU code simply does iodc->get_cap().

However, that then makes these direct raw backend function calls
very awkward :-/

In my view, the way to make sense is either:
* We don't do any isolation, but just call raw backend functions
  in vIOMMU code
* We do every isolation, and never call raw backend functions in
  vIOMMU code
?

Thanks
Nicolin

