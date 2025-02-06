Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C6BC02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg75c-0006GV-On; Thu, 06 Feb 2025 13:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tg75a-0006Fi-WB; Thu, 06 Feb 2025 13:59:03 -0500
Received: from mail-mw2nam12on20614.outbound.protection.outlook.com
 ([2a01:111:f403:200a::614]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tg75Y-00023U-V3; Thu, 06 Feb 2025 13:59:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTldQc/uF72DojydcSTczvW8qWgILcW/2EJ6Jn1lLDuckgGbDTQV5tdYozNPlfhVRy9sxUUyMW4JerAWYQLyLgaaXKdDw3shesUP5jjTSbSZtNMYWR/IgOXsIVcBbWikAA/PC50sAqTnhPzCZ9QAPDwiielJAmm8d9i0isfiGLZ8FijYgQqZ4k5or8jfHlVhE4nireNC4oIfMiFVpD48StCqrUeIn8a8pcFOYpHCwHF2h3N3kOO+i5GcT7FQX9Y49DnI9Fo72ymBdOku1EnxVlDBM4EldHJ5JsS08cXZeuJkOHSDAn6cMWGB/Ukz8k4XupdKQRKBj0UE+azNBtbdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+HFqi/73bnRM9MGkwHZZoCVHEL4OcnXE7ci3tmndE0=;
 b=MgdkJJgficq9zlZS78o8vhpMNAt/FYptSGAlvOhXdWUZ9d55Lw/j9aWWeOFNc9UxIrLwmyoHxgbT6QogR+Xv33aGCcClH1E8du3rq0KvXaGxi3Ng0yYt1n8MJKRHZDNEjLP6XCFlaJKwzq0yVXdjI58Rob+R/UKPrhVluoSgFYKOj088tDuLpY6t2/Nf/BTfyp7sa+hssxQvRcbVjxiLKf+xcgT5cvBHl+wKj4GRsNkzP9Nz8FbMDhGohbumUjN9iLOc8kU/VlAVVcxEQqi1pE0MeQM1VY9fOgXMNpBj/rk3HBLRlCuKeKwjXjnbmTBOV0vLRrPxj8o5C3mPtiaDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+HFqi/73bnRM9MGkwHZZoCVHEL4OcnXE7ci3tmndE0=;
 b=lpyQ4W892UG/njyez8/R1NN6cKayzrgu+5oE7nnSAfzmE95kOLupMVJ/lc3aF256f8XTZCtasCtRMbtCg0qLaZ+q+v9+u7IYLL/QBHRmSRmS0MbjyN79wW2yj+u19/lLBBlAQF3tY2bGGNUI1Nv1iC3YhaOpYgNpX1IbgK4FZHMx75zUCnjDO104Nw+IOGbo1TIffNEePjj05M3XKVR9Bmp1pY9pVDT8Gc1qI2dnGyHmnKIY41hqT2VGFkDcgz+oTHviBCWudUgLbPY3+RhI2UtnWIpm4hvrVm5CeaaG3Kq+inzKyuria9P4jJocBN9iOHj2ub0AnIoFyBx02ZnmbA==
Received: from SA0PR12CA0020.namprd12.prod.outlook.com (2603:10b6:806:6f::25)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 18:58:45 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::c) by SA0PR12CA0020.outlook.office365.com
 (2603:10b6:806:6f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Thu,
 6 Feb 2025 18:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 18:58:43 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Feb 2025
 10:58:30 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 6 Feb
 2025 10:58:30 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 6 Feb 2025 10:58:29 -0800
Date: Thu, 6 Feb 2025 10:58:28 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
CC: Eric Auger <eric.auger@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?=
 <berrange@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <Z6UGVP3olKvakHUh@Asurada-Nvidia>
References: <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <f4e64a3a-5c1d-49f2-ac72-b84ecd353c9d@redhat.com>
 <Z6EQENkHJy7TrkYy@Asurada-Nvidia>
 <77f736f6-9ef9-462b-916e-c8cfff279044@redhat.com>
 <Z6KsAE9wnjWU0xMs@Asurada-Nvidia>
 <8224c38797344d1a9c0f453774925db3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8224c38797344d1a9c0f453774925db3@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 8daf9523-f7a0-4256-ab6c-08dd46e0471f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sAckDMSoPjrdQfseadpFBv3OYj46uvsvWjFuvlrOe+SpRBS9sHbkYmQ6YIZ1?=
 =?us-ascii?Q?AJgzQ+Yp6ousVuMyiqVR8a7tCQcjthNGMNEJz/CJuAq5+ebi+tFFcdKzmCPO?=
 =?us-ascii?Q?RicSPDC+DXInslgbf9hLRZUafM9oDgg18RD9IyRjhuJpipItfU9c9lNrBKBh?=
 =?us-ascii?Q?p4524wiqOM85CtfLtAJtWrqpRzSJKKYk6Wx4LtKkdsXuZhMFrQAA5/bRC8cS?=
 =?us-ascii?Q?9vGu8lnVoa/FK/+nLB0UD0SarraY2wCey0XT3gGt8NxG7ZvNBeHfX09JrDnq?=
 =?us-ascii?Q?wX8crxPuTWu19X+mgHiijjxa3lyY2xXZ3xCBxx7u15Z3qpxBfYgQf4ukJon/?=
 =?us-ascii?Q?IteM6TjqcnO4Qs0fWgJHq+7ODwOlgJI/u4BlrdKMXpdapmPUtqVntYEHrBjo?=
 =?us-ascii?Q?cSZ5RYPP05xU0wL04V0S4CZBTwtDNkmNYu4F7wMwWd3PPVr4monP6f1upqeC?=
 =?us-ascii?Q?yNEcO5azI7koEoq7jZPFWivd6EMat/pCAqPbupM3G/FvQkCCYSiXE14orxY7?=
 =?us-ascii?Q?SX+zHVT9echahCCYSdT+NJcPH5820ICCUgvW3U62Gbo5BYfL1oM1k6SuQYYr?=
 =?us-ascii?Q?MV85giERg5Vgd360bFpmC2tZnUAIpkmtMsEp7Rit7isZ+krsF2oOMF45pX4q?=
 =?us-ascii?Q?8R2p1jocGyd/J7KnjaG3UuNI/q65IDrTza5CceT/m8QafonQEbmItcVLKUJ4?=
 =?us-ascii?Q?hQJGZEEG9kzhP0CuX0iDZJFv3mJhkeXOnQXN5DPqAvxtHPKjy/L1GhOSSt2c?=
 =?us-ascii?Q?o2iy1U3X1SrsyHA9B+Zh1/yolIEXJ0SFvDA80IyWgD7DCWKjnvWk/ohEPw+F?=
 =?us-ascii?Q?mBHyRgH4q0s/kc0OV1zLnFdLDj+XBs8pZWaOiAPN5iQBhDSv1Qvk7D3lrEGj?=
 =?us-ascii?Q?p2E37fE9UbP4VLvnmFw64npjaBzqdOJmbxXJjFnksjHIl5dpzki3Ztjrid/q?=
 =?us-ascii?Q?XSOJ7Nxa13ZfQ7Cy1m5c40F7+/2TVRvwltlEPh8t3gvbqOdIeYW0wtfY0pIS?=
 =?us-ascii?Q?LZG4Bt5c905VYiaCYxPHYFHBFBXtpKlRDNDLSnfFhf5BbTEnVPsk8E5fY2lV?=
 =?us-ascii?Q?RA6W6OUp64pwVj0N0wlI2voo9Rla5NQTnRw82tGxSgUxzCLcJD28AFciwRZ2?=
 =?us-ascii?Q?Uiz+IoSthG/spY+w3zs29Gt7pN4+15KaanQ9R1g+CUyf58b7R9vWX29vGkzW?=
 =?us-ascii?Q?kFj3WAO6W7kbPn+HZ0ds6gOsSsy5CnQ3D/Xq9Os703pcc15jZmI/aemal25r?=
 =?us-ascii?Q?P9lmfC1+DLHxSQ8+6qAZ9zXFLEskHP845XrIWdn4vU11c9uQcuGB2T4FTegA?=
 =?us-ascii?Q?bPzIDnrB267nzT2OQz5vzktGkDboLI4bzk0uznWBl5CteU5+mGB228t2lScm?=
 =?us-ascii?Q?YV0n4ibrPXy4qny0l+lPmL7lhCqB/EyiIZgxAiQCPS1pZjQfGIe9b5fKDXHC?=
 =?us-ascii?Q?6WHrVZfbFrC13SYDi78l2TmltCfAUFrs8cfKGnVWaSlmDZC/UOjNUQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 18:58:43.4792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8daf9523-f7a0-4256-ab6c-08dd46e0471f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191
Received-SPF: softfail client-ip=2a01:111:f403:200a::614;
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

On Thu, Feb 06, 2025 at 10:34:15AM +0000, Shameerali Kolothum Thodi wrote:
> > -----Original Message-----
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > On Tue, Feb 04, 2025 at 06:49:15PM +0100, Eric Auger wrote:
> > > However in
> > >
> > > Shameer suggested he may include it in his SMMU multi instance series.
> > > What do you both prefer?
> > 
> > Sure, I think it's good to include those patches, 
> 
> One of the feedback I received on my series was to rename "arm-smmuv3-nested"
> to "arm-smmuv3-accel" and possibly rename function names to include "accel' as well
> and move those functions to a separate "smmuv3-accel.c" file. I suppose that applies to 
> the " Add HW accelerated nesting support for arm SMMUv3" series as well. 
> 
> Is that fine with you?

Oh, no problem. If you want to rename the whole thing, please feel
free. I do see the naming conflict between the "nested" stage and
the "nested" HW feature, which are both supported by the vSMMU now.

Thanks
Nicolin

