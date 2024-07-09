Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E11C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 17:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRECC-0002eV-8g; Tue, 09 Jul 2024 13:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sREC3-0002Xx-3l; Tue, 09 Jul 2024 12:59:56 -0400
Received: from mail-co1nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2416::600]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sREBx-0006tl-Nv; Tue, 09 Jul 2024 12:59:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4Yhqd9h6GNGtjVzouu9iFO6M4ve/FgGT7DU+dyi1M9tbJK48NsUiNJhtZ62Yu8MsVgglhgtvlv4DU837zYZOFtFLgdAwTydpyf1kpf63un9iTmrojKxnzpmf639HEVHecmRy38vm37UQCMXUwRQj1VS9NVIVs+9dqtRHVOtcgPAIm/sQ3WDaK0WpOdS/ui+9SAuXXRmGTGyA7nEDDl2TMynl8Bz6929zpsxu4V4J6NhR6uyYmJPs86ULMDyRKD50xXgJODSWnksXpfcJpHZuk2284tCkLoOtzYpd+ZpkITLRno8vLizvHnLMtFw5A/rxYxNcvYGM9KLUFmkS3NLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYJCuuGLoYgVHB8qF1wbG9I7ORD/rcj3789g9lZA2rc=;
 b=XicW8oMQGfKWOGrkibfdezoniEOp7naPaU9FnQNxQ+KGmzq7vnuWVrmgCKq9+UCNF9ai0RO45X71NRlWIHv45IOr95dQYaal57ANGFaNsfpwZ9jQ23edvyMWMQZjH0p1pkp1vTryll3k+trVjheylK+PaSaQtA9SP9/t/lPQOcjzhDCXY/gfsFP8BNL7LhI4f3WfboqB4njMyZsFLKApVNzVp8N9WuCiHaWHJooPpep22jIAMg9sn2ZsgDCR4sk8z7Kw8O+bj5yI8gzJw11ayWS7rZ7ewMt3B9oh3M2MBvy00gzI8WEDoh0kcBSiNpG0HlPak3tQfieuahT4LYftPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYJCuuGLoYgVHB8qF1wbG9I7ORD/rcj3789g9lZA2rc=;
 b=uYa9tGitcxc6Zr3ate+KbaDZMvHQHzCtDBy5ycu94v0Hhg8R01O+hpfQfys7h6Zy/rLTvtXrbPlQfDtNCC7fpFmzbLZkZZlWxKw+IdTW+h9M6bx9Q/Np+CZB2KzVvDdJq6vhYrL5DY/Zq/WxHvxb1Z6piMIglR9CYxeGDZu6hd3ktu3l/I/uo0OJGxpjNtjjIB7K66W/W3959coTVCEXz6VoUIKTB1wJ4ZQ2ZnVLMf1/rJPUWW4nLa9w3zcLc8+SR2nfGxiaDlMfSMsrly/s16cjbVUj3K/JDWcq05EMki+EuhBnevbat4FKIhXO5+/GNcJjqopullAyYcO5jb76ng==
Received: from BL0PR02CA0128.namprd02.prod.outlook.com (2603:10b6:208:35::33)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 16:59:40 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:35:cafe::ec) by BL0PR02CA0128.outlook.office365.com
 (2603:10b6:208:35::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Tue, 9 Jul 2024 16:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 16:59:39 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Jul 2024
 09:59:29 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Jul 2024 09:59:28 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 9 Jul 2024 09:59:28 -0700
Date: Tue, 9 Jul 2024 09:59:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <peterx@redhat.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: Re: [PATCH RFCv1 02/10] hw/arm/virt: Add iommufd link to virt-machine
Message-ID: <Zo1sblmS9+xlWObT@Asurada-Nvidia>
References: <cover.1719361174.git.nicolinc@nvidia.com>
 <df22fcd43e201fea97da8862b61614a2986ffa5e.1719361174.git.nicolinc@nvidia.com>
 <efec2974-ce96-4cb1-a00c-30fe93c5fa7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <efec2974-ce96-4cb1-a00c-30fe93c5fa7b@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DM3PR12MB9325:EE_
X-MS-Office365-Filtering-Correlation-Id: 1348fbef-5568-4f40-7b7c-08dca038859a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YotztFUDCx1hJ6Q7q2WbRUOe3J520W9fDnr8zAaK7iRpWKDygD4zU/jgEIUt?=
 =?us-ascii?Q?QqJ9uzU1CBrjpOXPMqzj5s9r1v599e+0b0d6/kAuAl01rjU0Ba/69Cd9upRT?=
 =?us-ascii?Q?dtNqwuXaJQIxVeov7+HKqQ0SdOqAolr3+VAb2jS8xuPfcp3vepr3dpFX54gE?=
 =?us-ascii?Q?inlIJ4VQdPFk185ry4/bxCnndrdqbP6gwZB5mI0RAnZrmF68Aj0kDQB4M8ff?=
 =?us-ascii?Q?/FK2cBi9qHcgkMNdIwl5Vzthi7g8+u1VBg49WCAWdjr3XixQ/4ipxD1Pwnbi?=
 =?us-ascii?Q?GiJC6C3454SKspNS2IjnJm/yWBJVoVMNNy71R0i+/zBTvYS05HJQsSHk+UGt?=
 =?us-ascii?Q?7JE6B8gM3RBiomTKCMmAsPIdhY1LrYfYVmf9hWZ9lmytgXkeCPD56l5Ge7Rs?=
 =?us-ascii?Q?7MwUDZDcmrcvpuymKt52iRMWMcGvRFl8EmmzPq0xpncVhFbo4aAXK96Eb+Jj?=
 =?us-ascii?Q?bphj0D/RhRqWfMVf7sXhrYP0PMwcqLdPyI+wxLLNmmbsunhtfarMOqwe4NZs?=
 =?us-ascii?Q?nEJ+Dlsfm74Q7xma228hCJWa3B8bO4ygtxswkoGelTnspe62IYX5xbxsnmk6?=
 =?us-ascii?Q?cpAGzSJQMGiTg7oLoec6XGHuhoQdflWhp0FwSLop1/bLWpjeSxH7kI/cVIa3?=
 =?us-ascii?Q?AzeJ+kiIcLTWF8iXboVX/EsCer5xdPXwmGZV05Dw3mLZxo16z4hNKIuTlryc?=
 =?us-ascii?Q?9zllCWgZkP2KL0k+gl7CyURqxUCfgohRfDwhByANB0b4FUhKka4gPg7LfTRd?=
 =?us-ascii?Q?XOQvp8xVyOKFUDKC5YPQkUZEveEZCP/E/FN8xjK0tJ8dwfn8Uxcy0a5xxZ+E?=
 =?us-ascii?Q?p3T/HnU3JDM9W0XGdaSe4zEwWoYPpevmuWJlByCt52GeEWWiB30dqw69XeDE?=
 =?us-ascii?Q?mU8lkBbgUpuksYgXvUr4MhXmDVHxhh957T//k+rGyBZqTI2TyNwV8eK8krIB?=
 =?us-ascii?Q?r8jDKSbno8KvV3tnFzym8IHzWMT0nDXlQW+NbJaiqvwWgzh4kCFL8vq3vQDx?=
 =?us-ascii?Q?w5gTr8c+psxWMdx5wmNwHngxixNlJE1Z/4VW/ktYztNgkrGlBZTLfsWFylxD?=
 =?us-ascii?Q?+I22Y1A1wULc/SNtI3wb9vsk9JI6yPI15Ga0qOoFbb+dRKfr5w4ejM6CRoyM?=
 =?us-ascii?Q?t7T/K+vM214GJiyLGSQi2x+2RPLtuj0iPdK5Eq46QuYIf6xRIddyVyYtg+pE?=
 =?us-ascii?Q?WlzLMKhKnercDu/PGguWvDY9+k4iVo+9xOzuQDPhOisQXXAefab3ZhM484ls?=
 =?us-ascii?Q?rSPaxMnIG2AEu69Q0z6O3yoZpla7U3zkGonirCBj5U6V1Tbanjfl/cwMyONW?=
 =?us-ascii?Q?ftHcE4EhfegHb6Lg3CQZnR44D5MSirLKw7p3PdspXnxLLL9ypy0NERz5RgUK?=
 =?us-ascii?Q?K18pnfoQsPmhYPfyGINI40uqDFOmj6XjkkuLVjO5WyAqPEw3C1ROH1UvVAnL?=
 =?us-ascii?Q?fjCWVXKwbRxWll4HWn7Shp71ZLz2jIw6?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 16:59:39.8155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1348fbef-5568-4f40-7b7c-08dca038859a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
Received-SPF: softfail client-ip=2a01:111:f403:2416::600;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Eric,

Thanks for the comments!

On Tue, Jul 09, 2024 at 11:11:56AM +0200, Eric Auger wrote:
> On 6/26/24 02:28, Nicolin Chen wrote:
> > A nested SMMU must use iommufd ioctls to communicate with the host-level
> > SMMU instance for 2-stage translation support. Add an iommufd link to the
> > ARM virt-machine, allowing QEMU command to pass in an iommufd object.

> If I am not wrong vfio devices are allowed to use different iommufd's
> (although there is no real benefice). So this command line wouldn't
> match with that option.

I think Jason's remarks highlighted that FD should be one per VM:
https://lore.kernel.org/qemu-devel/20240503141024.GE3341011@nvidia.com/

> Also while reading the commit msg it is not clear with the iommufd is
> needed in the machine whereas the vfio iommufd BE generally calls those
> ioctls.

I think I forgot to revisit it. Both intel_iommu and smmu-common
used to call iommufd_backend_connect() for counting, so there was
a need to pass in the same iommufd handler to the viommu driver.
For SMMU, since it is created in the virt code, we had to pass in
with this patch.

That being said, it looks like intel_iommu had removed that. So,
likely we don't need an extra user counting for SMMU too.

Thank you
Nicolin

