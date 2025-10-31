Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DDFCCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 23:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEz0N-00016Z-Gv; Fri, 31 Oct 2025 19:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vEz0L-00016M-Q0; Fri, 31 Oct 2025 19:58:01 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vEz0I-00018x-Jv; Fri, 31 Oct 2025 19:58:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xp45f7RQ9TQZwaUzNDopDYyfr/jY8lVG1EiLWqhU14nYnu4++0JlHPAOp3u3y35RUOVnzejMNJduPN+5yxVinsWf06jmGLdz865KC9UI5hwmWYbNad0bYcW4M7QWkb5iFBCdvCp5lytUtsxKrLzxiVNMu82LEO0OcGzp8VT89p7/jAuSp7zEf0ZB6jAqdP0osHjzg+Cq9SSM6/vgEocz411kXSI3ZFP+dZQAa++pwQzo/dB/p67EqL42rWo5kAseWwvFHwVTCfa95or7k+hDjM5MdxjVBa2870fKI6Lxi5td9VVi5ne5V+wXTyFFlSdnDLXNXnr9kb3Rb3JKoCwM8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjk//b9+qPzzyB+0dgVuFGV+aOOdvO4Bqj/xQ5876NE=;
 b=Iq2w9vlLwLp6cuQ0URVQ6F3HWGBSuBirvR1B5nwAiJtvhNBWYXs7AzcBTyYMg4QPVsJ0ZjxAIfsy1QgmvcRt88BZ+Ue02W9mLdQZOm32sLzRVkfeNgjYdkjPIjp2id6d+uW62u1Qot+IQF27/SCUBzCciagSsy8g76s64xBxnyc2Q9H5vJOrAFVjlPWX3t9dvMb+CCF5qismqvw8lNNaCn3fDgGj0PKC5CBj7Nh7UM2RRbmTTg6ZjAimmON1fh9ewwxV4Vh1z+SsuKNTm+TacsnBZ4+eXpcAVYqRoCNjcEAJMEuVzGba1vgCsU5d69q3fLPxpUCUD4FHNGOGFY2mRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjk//b9+qPzzyB+0dgVuFGV+aOOdvO4Bqj/xQ5876NE=;
 b=L64gwzoHAfjCKO4dmcVlWiRbxWYGXDBr3s9QTaAlFecDxpKtFM3WFn+GjDHfmBljT4YqR6ZTT3ooTiHKstiCMnE9vMXNuBPtc/Y7uZK8qtyUxVJy6ievs8r509z+/5ij8V6cVhK/jIUd/OpBWckxZvxqReseXY9Llv1700bTTK2nHwXPScVLr10hqkaJ5b+QTgakNPVmz++VM42I1Pvk17P2YjSA1E93CjrlTvFUNq8uIvBimF37VgfTbyQlp41dqQIqIuEqdHYiANX0yjq7vnErAGGk7EsTx8FssXMih7GGiduIMGMQwpinZpKT1a0D2gEVMJolc4ivXqS5J+QXpw==
Received: from BN0PR03CA0044.namprd03.prod.outlook.com (2603:10b6:408:e7::19)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 23:57:49 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::5b) by BN0PR03CA0044.outlook.office365.com
 (2603:10b6:408:e7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 23:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 23:57:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 31 Oct
 2025 16:57:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 16:57:36 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 16:57:35 -0700
Date: Fri, 31 Oct 2025 16:57:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 16/32] hw/arm/smmuv3-accel: Make use of
 get_msi_address_space() callback
Message-ID: <aQVM7egZ43UaUODf@Asurada-Nvidia>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-17-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251031105005.24618-17-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e8deef-1947-4638-8153-08de18d94bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Se82jWhnMOB1a2sH28PdBDgCwcvjJekq1XRfl/+iSE8crgAkrnlW+my5Exuo?=
 =?us-ascii?Q?8chtTL21CJPQnowGyMcoZ5Mc8la82jiAtDAAGKCoK0YnI194hJyLFkFTI1pQ?=
 =?us-ascii?Q?zuBGPRY99GzodqHUYtIKSu55Rto/iYF9PP3YPyX+UpCEi/fzJOUX58qTsYBJ?=
 =?us-ascii?Q?5yU2FPHlKdEPPTJm7Ax0ZtCfFxGHy4CIryt9ZDe55MOZh6W/gQwGS0J30BQl?=
 =?us-ascii?Q?CIKzO0THK+gMZqqnF2e6SEQkxEm1Kn4rL07YRl0aoqnW/6m898V2+moa541l?=
 =?us-ascii?Q?h1Lq0Y8iK+kw7/tEzdbs2Lp6Lc7VeY9KOqGi1+rrpNP0hCaMuxTBqH2XRNxD?=
 =?us-ascii?Q?INs/VPLK0bqY87Y1gP5XPvqlIgXFstop83xdZPu+V6jYPveFbqRicBXX/1wB?=
 =?us-ascii?Q?KG99NeY/qR90IXHYYf/zhqaZ2mxBpm0bfDKo3lpZCCHm7edfUhZKwBEC45p1?=
 =?us-ascii?Q?g6uAKoZVOd9H3QWLZi+zMX4ZwNWIMq7E1U5J63OfWCfz2YELiui7fjNfnTGK?=
 =?us-ascii?Q?CfMJikgs5vWqZqaD62RbDmfow583cBUukoupOw2di1DkwnDTgGukj7YKOw4c?=
 =?us-ascii?Q?KfVZp07+3jfdFoSEhX13xUfzDOcwklGveYgWBDu3F3cSv+kyIg+v1RL9Vhjh?=
 =?us-ascii?Q?zGL89yiI5fABvxB95UhumIrLc4AJzc5qUXsNynm4elqe+Qd+MEPBxrkheIzy?=
 =?us-ascii?Q?ptMkobSeumjfS6UtO1CejKjc+u0nzil5vaOhMi3lEplRyO3WCdQJdUrHt0qF?=
 =?us-ascii?Q?hJHQdTC0a72j69ksDRgi87wOXALDV/7stMGyZdCXwwC9nZr+R3j5ajocVfjk?=
 =?us-ascii?Q?hwspG0/PUaXPsYYWbzJoB50IDJZwR7I8QqU9aGM49LIt3TAmOl4LnByu2mxF?=
 =?us-ascii?Q?EDrtf9PPtxe032RIgj5Qo86DnlhVA6vGaDpNIsIfqGtet9suEfFToGF0lwS3?=
 =?us-ascii?Q?PQQ/9+t8EkOzhZcKOUNQ+XcJKm1UkqONkKhhEWPxiAEIL9o36ReYhmbK06O4?=
 =?us-ascii?Q?A0lotlUtnfLfd60tEawzXOE4+NIlOmCH/oDP7MMjWVk7BwH8YfIe7uYJ/Cxh?=
 =?us-ascii?Q?2GmjZB+zXT/gwgsKewrGoFXzKrPp5DoTv2LWa4KMcwGW+hM6c8lD+TnCFR9k?=
 =?us-ascii?Q?r9XXmL0j2Ck8Uz9tdd+kmIFk7z4+SniA3ENayxwks+pwnkLh6GGEUu1V/lm5?=
 =?us-ascii?Q?78U/Vr7tySH9uTsDkh3kE8WGlpOM8R3vGBSXIMvDF2K73ylhBeEwTRBDzOQk?=
 =?us-ascii?Q?HdkdBvcPVkD2VnC71otDQLw1LUj6yH4HK6HrK8DfNZyABkF5wtXk29132wCy?=
 =?us-ascii?Q?yaas5xGNHlz8Jh49hgC6prWuDnUOEqui98ERAF3UasFOshBdboNk5gqVS9hY?=
 =?us-ascii?Q?g6INWq7IHdeGMbYZkgEXTZYoqh89OgBT8EgWwDxdYmHjnFFolSZFA+DfcZX9?=
 =?us-ascii?Q?EgoSInnpOukB9mGaSvG5TDznKCT2nSaJsE+twucmQYG9vFu//0o5qchhSKoX?=
 =?us-ascii?Q?s/9kjjwuzY+FKET/G0xrrFI0/DpvD4QZDirKn3oCMplcc0aaNWNG7O6HmFk5?=
 =?us-ascii?Q?jdpM4zzcJnm8LSRDywQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 23:57:49.0601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e8deef-1947-4638-8153-08de18d94bcd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=nicolinc@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 31, 2025 at 10:49:49AM +0000, Shameer Kolothum wrote:
> +static AddressSpace *smmuv3_accel_get_msi_as(PCIBus *bus, void *opaque,
> +                                             int devfn)
> +{
> +    SMMUState *bs = opaque;
> +    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
> +    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
> +    SMMUDevice *sdev = &accel_dev->sdev;
> +
> +    /*
> +     * If the assigned vfio-pci dev has S1 translation enabled by Guest,
> +     * return IOMMU address space for MSI translation. Otherwise, return
> +     * system address space.
> +     */
> +    if (accel_dev->s1_hwpt) {
> +        return &sdev->as;
> +    } else {
> +        return &address_space_memory;

Should we use the global shared_as? Or is this on purpose to align
with the "&address_space_memory" in kvm_arch_fixup_msi_route()?

Nicolin

