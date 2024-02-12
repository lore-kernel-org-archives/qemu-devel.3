Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B156C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 16:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZZF7-0000nd-Q9; Mon, 12 Feb 2024 11:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1rZZF4-0000nF-46
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:33:14 -0500
Received: from mail-mw2nam04on2045.outbound.protection.outlook.com
 ([40.107.101.45] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1rZZF1-00055i-IJ
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:33:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwOAVgMU4yBW8ksKWgKw490DvDyJQNdILyv0CsipUjvxxoQN+m7jDsrjU6KoS07DxyrHqMlurnbpTGkFM8FPgVgwdDzMPU3U16UJg0h5Xk0oG6TN7BKtKulMMAcmeQvsB+V4y7NclpobCAlq/gJ7rrWuFVvbUarTYV/4DLnOqZjPywdOryzXwzKCorkRjr4zOvCdBtmtvDivM8bps2I3eIgJGMHN+gScvNrw0SsaPWtJBL0cui4B4Kvr6ZQOYsbsJXw+OWHtMYa8VfTb3paxkeDuO6TQdn6+0RrR0+2LYOx0lsxbDLXUmd/wsJ7sUI50KR2t0fshCwFeYzAJ1eOjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ox04QgjB9xy35wCXg6AjYmuoezbO7dVGoFS59TbKbio=;
 b=LupooKc6a1fQYi8scAGR4ytu4NMW2Re0Hc2AjURXPe/CbCKH6t6AZDpt2WrxNaQi+hihp/5n6fX74/NNcALurbCGXQclEioNFSLTghYtP8b5x8ALZJ5EQQV8L7E9nnEhMr+rJTqrkgAremK5IJkkc6XCzCnIVyfkG4nIQ+8533pYug6laRVytPRi2CTQFcybgOW/HDYMjA0mN3yuVsBFJToJn/XeHatT/C2g/ZtKhejS8IAAz6bRd2zFcxwuVOxylCdeAuFgnkujYD9hBfh3GhZT2CjWY1rqtrcQnY1Y+BVX2NTSJ2t3En92mu2hbVB+QsBdNa1csLKkdfO0L6Wx0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox04QgjB9xy35wCXg6AjYmuoezbO7dVGoFS59TbKbio=;
 b=TS7FbZK2oz59tfzlwQJjfcKF8mhRuLDz9jdSzVYciVjpAj0p8UOIp8HEIi+S2Ekwjmgx4iBM8yKJP1JX06BqzpoJx79hHf4R73RBH3xqx2bEvR7QVNqnj/YQZyLmcmi1/Ulx+3jYLl5NtOgqJvUX/Xl2gbjG+xOJQQ24DtASwbOLkSQuPJmV+3tqFlYXE5I767eXZqcZQ0EWUBKnqYgYdIXguN6tmVjsniCVfiVOfypvAXfTrrab70Ii+/trTwGipGK4hO25HVD6PbxHFigyjyzwEDA4IJi17C/0E91XDGd/vEJ1MBWKBA4eTEgSoC1QmVJ3cYJ24L8A1PG/6R1pZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Mon, 12 Feb
 2024 16:27:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 16:27:59 +0000
Date: Mon, 12 Feb 2024 12:27:57 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH RFCv2 2/8] vfio/iommufd: Introduce auto domain creation
Message-ID: <20240212162757.GC4048826@nvidia.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-3-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212135643.5858-3-joao.m.martins@oracle.com>
X-ClientProxiedBy: SA1P222CA0188.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 006e68b4-7d04-4c3e-abc4-08dc2be7933b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVV0DCDxHCeDjEM7pgo+eGEUhrTBNqPV7v5QwUycyDD5o9F9QXYtXKnvIyV9Iak+lQpMoyOQDLHYJ3mscl8Hhvxa0tPlxeCb8rDpXrHNBa1h7ogxPi65AyOaTHubm3gd3XEh157MAf7+Y+wk4zJYRTXcxz13z8+IF2vGzV7KdYwf+u+5LpyhOJOS6EVbG8DdbyvCAw8G1JXZglOGDlcddriVIns0ODtBe+OkS057OkEXtT/qxVWgxRUbH3te5DOgU34g3wk78bYiaRzVcS7+mnTRw60gpAvY6JKNE69z83VnPsceKsl91k2YsAhxZveZvh/wzUW3Z77L/z5m+DKOwys4/BlmAQ0bEnGwcL3gnFIqAwmUwsp2RCGgga7c16XrinP+AcQ+TrfkzO13ZkCW/zCkOc1qipj5wrODAGwnXT7GCqO/S59dRiSI/vFKDlA8jevORoC4IXX8GfM0CFlLYgzAZLJb+gU+z6PBvzzdEnMoARylT77gbkeYYx6lCcEUjTtq5N+AEoo9bEzkpS7rhkUBLOZqTt+Gk3dv6hx2Cd0izfKLewTvF7/wwix5SYGb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(478600001)(6486002)(41300700001)(8676002)(8936002)(4326008)(2906002)(5660300002)(7416002)(6506007)(6916009)(54906003)(66476007)(66556008)(66946007)(316002)(107886003)(2616005)(83380400001)(86362001)(1076003)(26005)(38100700002)(36756003)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TZqRRjnJu9urUgy0c1bAwo8QcCRvUEte0wYf2Y4kVS0zXu6WhMm2LDdxGcby?=
 =?us-ascii?Q?V3cN+A2l4EvXv4ZDLLZT+3Po7u0IeF6WNahYjpvABaLvEOHZKS33+HYCS1nR?=
 =?us-ascii?Q?YVQqpVp4BKMyjyZ1rtx10kH8/hpb91dTQcCIc+4GI33l5KKUEBM0nAA/gLLO?=
 =?us-ascii?Q?0kQQ46y001J2p1y5BMYIpFrOJFUL1pGvOFU4zQ5tXZ/OjMTkoeJyfoINJtUh?=
 =?us-ascii?Q?sy14i33ptTIHTmtguATbwJa+6PSwLyS5AVlBg+ahgd3T3NbfQ67jYsLwoFXZ?=
 =?us-ascii?Q?uSBHM3/cvD+Vs2qjkf0fWGz90qYQhzYoHpAJ2EPGGU9Nttkaiwgcfa1LG5RQ?=
 =?us-ascii?Q?1dhbP+Iofk1JSz1VDMJY7+TJlb+TriFRvZx4N0JXXoRw+3tkGOzonJexmjAc?=
 =?us-ascii?Q?WrYAh4lC2+/GRh1399vNRSI3XMoOnMwMNMMNjNWlK1ny44zG944wCAFL7ucl?=
 =?us-ascii?Q?i12YHXsIkyeN34PCt44ejwNNC7zIZozc5T8sUhqDh25M94nw54Ph/MEkJ2eU?=
 =?us-ascii?Q?eAPPhFWX/zL/oXhwfh0YWc9EUJ1UDcAGQ3fcpTU2vmsMLDuuxEpMXutlR3v/?=
 =?us-ascii?Q?CWHNkG6dNjR0JV49KtzmvZmBXaTdWAIe+YFiVRspsD3Lk/pg2VkT21PUYP+d?=
 =?us-ascii?Q?BCkfYp+fzSpt1WUzyk5H0j8b7nMh9m7amx7rXT8+IcRg7BccwEbjFJ57wHk7?=
 =?us-ascii?Q?Uez+QK1D7BfQrxiD0/6LzuhQWAgkWrECIlswDQ+x6Sn0QsXfGkjWwMfGNlvk?=
 =?us-ascii?Q?Ut1Ngndb0C9ZWJiD4GLKno2LIQiKqALGML36Zl1VKbmXmFP5ObfX0OvB4rej?=
 =?us-ascii?Q?2bkB7ahD2qbab3H/2PZjE6VLuEcJ9N6xpzhTcYlPHWrG1Y8EtwJ/xqWap5wA?=
 =?us-ascii?Q?ksK+IJONPwZpB67D795911iH+ej7Sv/vEDfZoJQz+8J2fzHl1bYFSMnb/FCc?=
 =?us-ascii?Q?B4pWu7CUYf/k77rvRJAspFP/5iIOPzyvzhyNYg7nVYHSyTDCPVNninrg/xWM?=
 =?us-ascii?Q?4F1EV6MMYBy3JuWHIgi2Nf6CQoI9BLl0IhuOVEKWL5PkNsSYE7lFmn9GgtCf?=
 =?us-ascii?Q?neJ0wHrMVhH3RZQ+QHyJCJTo9dm8fIjACCwCI/rS1qkrREl0TrFPePWoH49N?=
 =?us-ascii?Q?c+3FYcdYpvL79H6g1Q+d0RpLyPv560t9Reb5J8l9z+LeacC8LeKDvwCPf59c?=
 =?us-ascii?Q?RytMBkJZy0Q4TpPSTYs6FukZz72DJglP4+jEdXhoKFyge+Fpo/+z3YfIyIg2?=
 =?us-ascii?Q?w3efXD00ZA72EpCh1QcfVglnA32d5K4MZuGfwYyIyn7RNpSeyfe6zqHyTWIH?=
 =?us-ascii?Q?I+Jb7TLInijuI6su7Zq+rBxGPn36Q7xz0gD2ZT8GQmd6AIN4NDNrUhU6YPDN?=
 =?us-ascii?Q?uop4SG8gPT1L0L/mMlg37o6O865zLQHtp8Xh7Oz7tP8SEnjMEszDken2VtxX?=
 =?us-ascii?Q?DtXfbTUz0kkrp8QmonyUOSRNwuFUfz0pBR33hDQg2djf2p5oubCDp0/LmDM6?=
 =?us-ascii?Q?UheA2IgVll2uOgwof19DqaetB3Uv2LH5yHbG/aey91r2uijjEWIvLcYrbvMI?=
 =?us-ascii?Q?m3s6i+fzIR8loIZKBpI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006e68b4-7d04-4c3e-abc4-08dc2be7933b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 16:27:58.8796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVUGM47XrnMQ93hmw8PaVBQE2nOZ9ZMg3L22XAKPEOGrtd68jScTvpB2KQrF+Gey
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
Received-SPF: softfail client-ip=40.107.101.45; envelope-from=jgg@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Feb 12, 2024 at 01:56:37PM +0000, Joao Martins wrote:
> There's generally two modes of operation for IOMMUFD:
> 
> * The simple user API which intends to perform relatively simple things
> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
> and mainly performs IOAS_MAP and UNMAP.
> 
> * The native IOMMUFD API where you have fine grained control of the
> IOMMU domain and model it accordingly. This is where most new feature
> are being steered to.
> 
> For dirty tracking 2) is required, as it needs to ensure that
> the stage-2/parent IOMMU domain will only attach devices
> that support dirty tracking (so far it is all homogeneous in x86, likely
> not the case for smmuv3). Such invariant on dirty tracking provides a
> useful guarantee to VMMs that will refuse incompatible device
> attachments for IOMMU domains.
> 
> For dirty tracking such property is enabled/enforced via HWPT_ALLOC,
> which is responsible for creating an IOMMU domain. This is contrast to
> the 'simple API' where the IOMMU domain is created by IOMMUFD
> automatically when it attaches to VFIO (usually referred as autodomains)
> 
> To support dirty tracking with the advanced IOMMUFD API, it needs
> similar logic, where IOMMU domains are created and devices attached to
> compatible domains. Essentially mimmicing kernel
> iommufd_device_auto_get_domain(). If this fails (i.e. mdevs) it falls back
> to IOAS attach.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
> Right now the only alternative to a userspace autodomains implementation
> is to mimmicing all the flags being added to HWPT_ALLOC but into VFIO
> IOAS attach.

It was my expectation that VMM userspace would implement direct hwpt
support. This is needed in all kinds of cases going forward because
hwpt allocation is not uniform across iommu instances and managing
this in the kernel is only feasible for simpler cases. Dirty tracking
would be one of them.

> +int iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id,
> +                               uint32_t pt_id, uint32_t flags,
> +                               uint32_t data_type, uint32_t data_len,
> +                               void *data_ptr, uint32_t *out_hwpt)
> +{
> +    int ret;
> +    struct iommu_hwpt_alloc alloc_hwpt = {
> +        .size = sizeof(struct iommu_hwpt_alloc),
> +        .flags = flags,
> +        .dev_id = dev_id,
> +        .pt_id = pt_id,
> +        .data_type = data_type,
> +        .data_len = data_len,
> +        .data_uptr = (uint64_t)data_ptr,
> +        .__reserved = 0,

Unless the coding style requirs this it is not necessary to zero in
the __reserved within a bracketed in initializer..

> +static int iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
> +                                        VFIOIOMMUFDContainer *container,
> +                                        Error **errp)
> +{
> +    int iommufd = vbasedev->iommufd_dev.iommufd->fd;
> +    VFIOIOASHwpt *hwpt;
> +    Error *err = NULL;
> +    int ret = -EINVAL;
> +    uint32_t hwpt_id;
> +
> +    /* Try to find a domain */
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, &err);
> +        if (ret) {
> +            /* -EINVAL means the domain is incompatible with the device. */
> +            if (ret == -EINVAL) {

Please send a kernel kdoc patch to document this..

The approach looks good to me

The nesting patches surely need this too?

Jason

