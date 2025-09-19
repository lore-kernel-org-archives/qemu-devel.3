Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4C6CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 18:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzfzI-0002h8-Sd; Fri, 19 Sep 2025 14:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uzfz7-0002gg-7N; Fri, 19 Sep 2025 14:37:31 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uzfz0-000198-8x; Fri, 19 Sep 2025 14:37:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9cNTHMf8XgudM021MrTzpAp3tigGbHeKkl1q0AUm6EJ49iqJGjvOyyisrhFnV/+V7TwOH5YfPVdvzQS0Da82hgILSyDYwMnXuuRoK0li3arbVlZfmx3M1gMKN12Zc/qq7cll4aqn+gtS+kIgqrVk1EdROSjT9V6kNK4xqZyIgxoFpfmiL0Mn4rvhTh/ZxFyJs8n8uyoWGnSDsk0GGVRPE1x4hRZr37rW9xooVIiOyFg7hsoYX6tLgvBcCiI6EpmpS1ycjseIiynarsJXtDl0oG98gyKhVMTod5FXyGDavjo19IVtUkCjqTf/ABpCcpC7oAVtg36HOs+4IwL0jcpQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0uuRKMhclGx8WWshs5L9Qvwc/RSa+G/fdRfoMb3Hqk=;
 b=eqrbKWddKxAcSFOioc5EVplSwAxukh4jSOOwIt8xVFnTTGdj8M6r0rHx+2QU7/svQFkmnnKUm5mkJm6jHcdoAclsalhcFEpYq2PPBSyBKFYQoRD24zl3SBpSN36E27ysb2bXHL7HBzAsa6LUoH5KbG15facZ1LXNCWQzjkULryAfdpIyNQWY/UU4coMFss3COVKTx0JtNWEs8FYRXuVnbwMOT2RS/Wnb8RdHmkWZJJtBNpeZHsIID0iKtQqr/6glznc49FKpjFo8PULMPkl28bx3G3SjvA1ftObW5C52Ub6IyUcghYlftFVYeVwoQ5zg3528eNRmTucPGSYudPIN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0uuRKMhclGx8WWshs5L9Qvwc/RSa+G/fdRfoMb3Hqk=;
 b=tJub0SV0KBsr2wQfBAqZSFDKACJzPBdVADYfhJgZUDRnjsQLweGGKt+bQT+NmMT/N291DYlg5+A6fCXo4Bc7beBiNQLIIuijL+Iox57Fbl0uqE+5SLzCk9HlTpCOF2jJ8c5W6nvNp5/cFRYNH2wL0Mg8gvv6zDzXNrxQPfkR8PpQxSxAwUSVS3/QPwOipA0flKfeq9gFTspaQXuMDoF/gjW2VQzWCSRvl372f2MCV5WXfKR82BbmulPwlkkLhcF3x4xOYoM6PG9VvlUs9CrP3dHNkGqUnVebx05UAMcTbogvxhBPCUBcmdZ8cAgin6qTIol2+nkv3UMyp+9wOj1iBA==
Received: from BL0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:208:91::33)
 by CH3PR12MB9145.namprd12.prod.outlook.com (2603:10b6:610:19b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 18:37:11 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::ed) by BL0PR05CA0023.outlook.office365.com
 (2603:10b6:208:91::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.16 via Frontend Transport; Fri,
 19 Sep 2025 18:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025 18:37:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 19 Sep
 2025 11:36:52 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 19 Sep 2025 11:36:51 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 19 Sep 2025 11:36:51 -0700
Date: Fri, 19 Sep 2025 11:36:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: Shameer Kolothum <shameerkolothum@gmail.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>
Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Message-ID: <aM2iwSbs9X8Vx/Lo@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <aJKn650gOGQh2whD@Asurada-Nvidia>
 <CAHy=t28z=wrXbXOJjD4sFw0RxJR3fccqF-EdaQDB_s_F6RC4FQ@mail.gmail.com>
 <aMsBvSSEzsgeMHkK@Asurada-Nvidia>
 <CH3PR12MB7548347E93651468E70B2470AB17A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <CH3PR12MB7548B6A98B640192579078EBAB16A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aMyA4AHf7pqnOzSV@Asurada-Nvidia>
 <CH3PR12MB7548BB774BB375D5056C062CAB11A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548BB774BB375D5056C062CAB11A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CH3PR12MB9145:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b0e6d37-5eb5-4ef3-0e24-08ddf7ab8a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EIKXlwoHaPsZZU3MZNboM9ypR4vK5m/+9gRqA1rGW2fbW8C88P2uxYeoBTBE?=
 =?us-ascii?Q?mvet6rQ3ItzIgyQpyDnvUwXGU51TxzUCrM4TW6tVLhXKDaB+NwWip398IVkA?=
 =?us-ascii?Q?FnaSKpssfpbODKPmykG6x8xIQmKbN4autxH1AC6WwDhpFcq1zr6eoOLwEweg?=
 =?us-ascii?Q?9cNne7rZZklAUfit7PqLhcKcxaRukzR4w0UO1lunFlFdn2D8cw3164k0+6sD?=
 =?us-ascii?Q?nnXiAbyPpbXMeAuUd6uqlDqEMrpvW3nqyixliZZFDWy6qVG+cmG0GVxBA/xP?=
 =?us-ascii?Q?3es21i+Spb+OdJuEf+4bLIFKc9/tJimZu12/LWJC58FxMo2QdwGyJ2mbfs15?=
 =?us-ascii?Q?mMVvYXF7m3aqKrXW6Qcxh+5UyW32YCplIxJEj5LEwzqJKmTRnabSPuCKFFwx?=
 =?us-ascii?Q?Ha/vqnDEzcEJKbC/8Za8LK1gSUFPPv159qmQKpIaK8TRNW3VvggK6nLpKUwS?=
 =?us-ascii?Q?MyqvGyrCaCIEGzcdSCe38EjxopfVc1aJZ6iwb0MVgPXjSrePlFYShStLgOTl?=
 =?us-ascii?Q?LSlBiktzOD3EtuWc3DZvptqrr5lc3+26UliZ7A75/lUPfM4oOXrpZYyHIPZz?=
 =?us-ascii?Q?poA2Km6HIDb0Ir9AOsH1lZA6bMOVUdq1P7gjhVYML6u8ARuPpp3ejB7lpJjx?=
 =?us-ascii?Q?62v67bH6bFX294S3A/YxCNu/KxqeLNNmnGgP6+fMmL2ZCUZKSGfy4H3sAkLb?=
 =?us-ascii?Q?KtNm/NUUqDqYtEORaDqnp8X3VxzbLzF3peD3o3pSMkA+nKIWBnb78/cjHGS4?=
 =?us-ascii?Q?+dVHssFZL+r+4vg4gx1Dbg1ktuuQmRQPAl7M1psXU8dCDh9YuCNjrqM+hUys?=
 =?us-ascii?Q?Yx5looc9kNIatlH9Bsl1QBCkGpsftc22GflWigUIMEyjlJJpJ2jb3n06LP4B?=
 =?us-ascii?Q?vRBrd6/JcWyaR6xV8bEkJarfWr3rOldXidvvYl4TpECDMnghi0Z7mai8vbJM?=
 =?us-ascii?Q?9oexd7HiWRKHTy421dXYT/nh8xcv0M83ALEdiBXCHxE/OdbF96v4uLwGGhHE?=
 =?us-ascii?Q?X0IirQWq/ngmBMiI2sPHKSzIwqgGlxJrC4frC3qvLiHCrIeBmxoJyR6P3k/6?=
 =?us-ascii?Q?+CgcsDQKP4J9i7lREAOm+Ka9EmU5QTyGAUF60E9wTTmNzbs2z6Hprtdms3iq?=
 =?us-ascii?Q?YyoCb0WKEjicPi91d8mlEVOTdOogtAZhqHQk5ifbQ8lRzoL7GopdJAKDbCjT?=
 =?us-ascii?Q?lOJQ5nSzn07/R0jduW5Eeak+kDh4/OvKAhToQN4n7DKY3ybjvnIvDJc3VnFB?=
 =?us-ascii?Q?4IlkDaAt9RV+oOwEcdzBjP5jAvmbh2ajCJwN3M5O3R3YJIseKuK3+j+/Odde?=
 =?us-ascii?Q?U7jHHG02dgmuoaZHGtuAMLrv8ao18RMVjm0+85k7S7nWTWmkN68sKmeI6TXa?=
 =?us-ascii?Q?7yteHgWq4fN/5eusdPBkarNVy06v/jpbNgZF5khZn3/ANLUOvOHl+mlXn+Yc?=
 =?us-ascii?Q?C2WuPfARQYL4Ecvqo9gOBJ9kbpbpN4UewPAd7FXlEsTY5x5aAo+qJ8ZmBONz?=
 =?us-ascii?Q?UisUQIiyu7TaN3cXd2qYNUQsHy65kYlT0qeD?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 18:37:08.8017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0e6d37-5eb5-4ef3-0e24-08ddf7ab8a5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9145
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=nicolinc@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
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

On Fri, Sep 19, 2025 at 12:38:45AM -0700, Shameer Kolothum wrote:
> My suggestion was...
> 
> static AddressSpace *smmuv3_accel_find_add_as(..)
> {
> ...
>     if (vfio_pci) {
>         return &address_space_memory;
>     } else {
>         return &sdev->as;
>     }
> }
> 
> ie, use the global to system memory address space instead of creating an
> alias to the system memory and a different address space. This will provide
> the same pointer to VFIO/iommufd and  it can then reuse the ioas_id.
> I can see that QEMU uses "&address_space_memory" directly in many places
> (pci_device_iommu_address_space(), etc). I think the idea behind a separate 
> address space is to have private ownership and lifetime management probably.
> Not sure there are any other concerns here. Please let me know if there are
> any.

Oh, I misunderstood.

Yea, given that address_space_memory comes from the system_memory:

system/physmem.c:2824:    address_space_init(&address_space_memory, system_memory, "memory");

I suppose it should work. That way will be cleaner.

Thanks
Nicolin

