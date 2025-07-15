Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6F3C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 17:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubjUH-0000ft-J8; Tue, 15 Jul 2025 13:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubj2h-0002h4-Qc; Tue, 15 Jul 2025 13:02:12 -0400
Received: from mail-dm6nam11on2060e.outbound.protection.outlook.com
 ([2a01:111:f403:2415::60e]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1ubj2f-00023u-9j; Tue, 15 Jul 2025 13:02:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpjZ+a7nhlt06Pj4tqDRBQYV4O7InVnd7spm1cKHuThmvSSpeYg1t3VZAupPFzJG8tDgEZ2KVPSU/sc50BBVk/tJZSaTywc+P+Xtci+Eb2huwAgNsRs4J3MaSSDYQsS9O6FVUVEbEzh9tPqMn2NPnXmV0EHl8GjLNyj86E8eVh0mVAgc5XKPkO8JHFJjLsmCMH4yUsh047u4RLy8WGlJ2mXoDUtm2uwJSseE+1QnocRYpNKwRXmD36SISFrCb2NeIm2gRLfqSNBu7uOvo7XlmjASjJTQ1TqQVs8DWL9hc2a3R8Ck5QJsQ20axrX8D+dv5Xb03p1UQi8b7X7GvVEepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+wVllfVw60kWbWqH5560CMURW2iAUBC5bXSQx3pOYg=;
 b=YVQgEAHcIPn0ozkif43czoPiUObbwLP9ElkKahhqRPKc8mX+Er8YiPf35HGriB3iRJsGN8rkhpm0Kz/TWLl4LVZm8EIp8KOm9464//5MyoB3zXCaxmwwuZFDdivpUjVJuf3GLLTCW2/tV2ZXmIDBcdby/T3TxkfKnsZKGiTu6r3m144PSRpU0qo3CMbTEc8lJzP1V7gqRjYtP5U6yhM2sw1omdNowbSZwLuhACuxJ3/3Z3NopDovzhnt80WZz0YF36Nzl7gnkTFbM5FIKmWgRccb96ysO0sNrZuyCU4zfkb4+AlJR1fAcmEEmvRT+EI9jHaMBnt5ZNjFtYh+TEAGdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+wVllfVw60kWbWqH5560CMURW2iAUBC5bXSQx3pOYg=;
 b=NLAmH4LNc77cINwPIJhYnxPE0P47uxD6Gedg+1O66LHqai/AVc6rWsa2gVAaXt302YvfoddbclsCf+q6/RZ8YncT6YBKU00wz0SOn4T9Bg9ZExVrgvz7foyHRXvM5WfXqe0KuKlO4nwoJvGodYTkvxFhMeoK9ineL4o1bYuTCgfm2yDvw6a+bb4aR2/LEe2EEjRBGQNnutDaYolFLmVuPrRMWAirPhqYY6+/yEHsbLINwQNKk8TLLdx+nxmeVEjsPrHSY1ik13uFSeR9kKnjuu0oa3xKtDFgWo5cFUWihdm35N8Ih/S1ErzhpgIBTxkpDqmwJdw+Xh1inmjEshnk+w==
Received: from SJ0PR05CA0171.namprd05.prod.outlook.com (2603:10b6:a03:339::26)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 17:02:00 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::b2) by SJ0PR05CA0171.outlook.office365.com
 (2603:10b6:a03:339::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.16 via Frontend Transport; Tue,
 15 Jul 2025 17:02:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 17:01:59 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Jul
 2025 10:01:24 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Jul
 2025 10:01:24 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Jul 2025 10:01:22 -0700
Date: Tue, 15 Jul 2025 10:01:21 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linuxarm@huawei.com>, <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>,
 <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 08/15] hw/arm/smmuv3-accel: Add
 set/unset_iommu_device callback
Message-ID: <aHaJYfitACLvupZV@Asurada-Nvidia>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-9-shameerali.kolothum.thodi@huawei.com>
 <20250715112941.00005348@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250715112941.00005348@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DM6PR12MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d0d2a0-9d65-4fa2-e1bc-08ddc3c15023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?og8VYiBKAoUl2N8lWZmMyLf3u1gk8H1VhSNFxmvWm1WVNIE1C6YzDOrK6cKk?=
 =?us-ascii?Q?B4O82Y5OeTInkVuAKzVH7Ze5nxOnhR72+pVtU7bXLOsYYXH2aARvq74397g3?=
 =?us-ascii?Q?Sm0Iwgh9A2fryKl2JgbfpXIoS2PBDgij+rAQzWChRrVe2wn+nYw4+Peg+wpI?=
 =?us-ascii?Q?JkeEcdnlXST4xUIEfZLfM/IBAZar60gVgotkXoOkw6azqv8oj8155r6myMO/?=
 =?us-ascii?Q?2EBtcSoc7i1UtpRTsEi3d4zijO/SmOpMpw1DLXXztHH0fDIAZOIPomSNhb38?=
 =?us-ascii?Q?1TxhDnULabDUcYbW+aJK4X/tSuKxqidDwSyjPGWsuCsTJZJgVEU8Ng9/4EhI?=
 =?us-ascii?Q?dp9qI/AI9/+ucreIO9GZNzSTwPqEqSAgwL/nwk+7n9KMbHiKtQerpB0RWUiH?=
 =?us-ascii?Q?AschVq5qN05DnddX4ZtsLjvH0Nw/FCUhrtrcOT8JavgJzlSJSnKvdmvP8EcD?=
 =?us-ascii?Q?cIacYg/ZOV++18PX8vbf4jbwdL9wskPDBWgmXfdUlrU8juqNrZVsVUGnshIR?=
 =?us-ascii?Q?Nnp0OE/F0BLmExtXfPNOtHwBAfF2SbFDx9Ls/x7a/89BoW2iOlmqlOWQ6Fka?=
 =?us-ascii?Q?3Zxu5YaKfo0AsxGzPNm9ThgKb8dkmuLS2bHv1p52fUHr0Am1K5jsIUUcpQo3?=
 =?us-ascii?Q?ZtVxXCkScSD96n6z+tI1v6t2lnpoAFfsUf1rbJDfgkgwWIQffb8vjWp7NLBu?=
 =?us-ascii?Q?mBaPO1dQhEJZ+GqNAJWLXi2K/SmpQ8TCjaWufeyAfJSZYkmduuNE3EEi+BQE?=
 =?us-ascii?Q?TqiB+e1TyDboz27TVeNp9QuRGS//oAX3i1Tq2v6VPEWQRrPGCgASFtsUBIA/?=
 =?us-ascii?Q?Nq9Ei+0RAYtRvrp7PGD+9WIlugloc/NPXCztY6Dvw5djHRpZwVtwRV6qAWBu?=
 =?us-ascii?Q?cl+vo8rbQp2BzlJ9JYHuihezG3K4sEpSj2DhH0Q/57CRnbYejEZ/f2tfwNfg?=
 =?us-ascii?Q?nuuNvh/a9vTW8lfVsYd48SS2dgJtHLVIwLR8r90G5zPeqiOUUSKU86SAIech?=
 =?us-ascii?Q?RAlQdTHzYRCnbUi7j7Hl0Cdcikgfzu81jE7h/N0AP2T78+553kfGU1c2E6sA?=
 =?us-ascii?Q?OZ4s/xHElibVCAXaeG8AZGhCLeSulkAu9YTW5pl/uRpO/H9qxNtV8f8SwqbX?=
 =?us-ascii?Q?2rc5qDiY7g2HhU6rsQWzwoN/vzi+h9DzqtSv4w8uTAd8oKWTGMzj4SHlNW2B?=
 =?us-ascii?Q?WhXyn6fUCYLRrnYL0R5Qd9IVGkcmq1h5w+ZL3LWySxPzHt/fFSxwbMjmwAtI?=
 =?us-ascii?Q?ovf4Mw1cRiqD8X75jDdZvg8RLmGLtnEfujw8LDblctzFfWLF5fqmq+01Oil/?=
 =?us-ascii?Q?L7TuLFcfmS/nJ1EDqJHEzVVjOzGtnteCyQoymMs0A9cPDoL+qEwivlRbwg7y?=
 =?us-ascii?Q?ZdmD3cGi7j2KtBkOcB1LwlPaW/LQWgjrtu+R+yZmtxzwq4G6Ihz9Sfvlyx6M?=
 =?us-ascii?Q?e6hyALdLj44mqmjtBBnvv34ckIxujvT+dgiKf0Cd6ubcn9h3nwPHyT0M2xte?=
 =?us-ascii?Q?9rpP8r60J/dkao+YmDHEk/Yqu2DE7CFinzF4?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 17:01:59.5735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d0d2a0-9d65-4fa2-e1bc-08ddc3c15023
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339
Received-SPF: permerror client-ip=2a01:111:f403:2415::60e;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

On Tue, Jul 15, 2025 at 11:29:41AM +0100, Jonathan Cameron wrote:
> > +    if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
> > +                                      IOMMU_VIOMMU_TYPE_ARM_SMMUV3,
> > +                                      s2_hwpt_id, &viommu_id, errp)) {
> > +        return false;
> > +    }

[...]

> > +free_abort_hwpt:
> > +    iommufd_backend_free_id(idev->iommufd, viommu->abort_hwpt_id);
> > +free_viommu:
> > +    iommufd_backend_free_id(idev->iommufd, viommu->core.viommu_id);
> > +    g_free(viommu);
> 
> No unwinding of iommufd_backened_alloc_viommu?
> Looks like we just leak it until destruction of the fd. 
> 
> Maybe add a comment for those like me who aren't all that familiar with
> this stuff and see an alloc with no matching free.

Those iommufd_backend_free_id calls are the reverts. An iommufd
object is free-ed using its object id, i.e. the "viommu_id" and
"abort_hwpt_id" in the lines.

Adding comments to every single iommufd_backened_free_id() call
isn't optimal, IMHO, as that function would be invoked across
different vIOMMU files and even the vfio/iommufd core files.

Perhaps QEMU should wrap it up with a helper, E.g.

static inline void iommufd_backend_free(int iommufd, int obj_id)
{
	iommufd_backend_free_id(iommufd, obj_id);
}

if it helps readability?

Nicolin

