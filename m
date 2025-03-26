Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0121C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 19:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txWQH-00088D-4G; Wed, 26 Mar 2025 15:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1txWQC-00087G-46; Wed, 26 Mar 2025 15:28:17 -0400
Received: from mail-sn1nam02on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:2406::60d]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1txWQ7-0003e8-F5; Wed, 26 Mar 2025 15:28:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y95YGrSLQ9P9E9kh52e+Fo3a4+G/GhjJhr+OHp7xepVgNsnPf128HeqjcYU3BSlo+c/c/+7VzkN0VdrWFu/cPieHGSZwvhAbzWuIoPmhU9JJarhnK3zRgaA1GCA1R/cABnNoPF1goP9+buoZj6Qy2ttB12uZm3lI6yR68CB4jAOM2gpaqL33cQNGQlBp8E4kf01EESJCuzewg00yN20RzvFzRQ0KFVO3b5vzSSzYsDkvh+reNcRPfk/duszeezG+UvcGE29HVMCG1vMQc9NKmGBFWuuI6F1gjKuhLjb6bL1YPgUW/QnJC6JUnut+VM0ST7zTIXYGttehQpRKoN8xzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRrvf20+mRjhc1O65XdzHFxlY0Tsh9aWhuLHkJftEbM=;
 b=kzRIjnjhXL7xQ/6cAbjWQHilNjlEDSF4OlghSmoQUEzKzFQl5dLBXuOCdoISDdhdvteZfp+ei6peuYNKfki3KA3tsiry3YU3qtnlK8Sidytuygbfrm9bgH2iRNIW9hLxjFUfBXK8K6Aa2wYzomnPxFbltTZY8Oz7rUZX6s5zDWz6JqpwgD4qsDos5vFolBXniP8/FadduAGqMv9ooPsNqtaqNruCEuoQLYu1zfhiix6LAvY+HjeMNGQQhsfnSX5DWJzUkC91B8PvCgWMJ66viaTv6htNwM9Jw1NvTKBbp9ar55xvZrQT4MU4Z4GVrbraLs0yfpKw4oqyGGsVvEjLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRrvf20+mRjhc1O65XdzHFxlY0Tsh9aWhuLHkJftEbM=;
 b=op5CMP/78onRq1pGLwS/pw3RP68BpJiCPK/jo/5r1btJkreZvknADcklmlo17M71g8sBV5PhIGrGdmH9b77FAaw4oHdyqvbN1rqZ+VbWJoO8vLIYhDy6+Xx0rCgMfmYKlkuWlYdGj34Iq0P+3ca2XTRU42CVpzVZWUM/gYcl2iZ8A30NC/WRjxyVK/smY9sYBpP/nS+DUAxL7hqqEajdXuTrdYcz4RIrFoHzIJhlZPFlgoKEnoCCEFRRgenJU8gVmKHPUMCUc5zIJO1p3+npOUKCANtsF+Dew8H1yS43TjZwRUrWwnUoOvqYpBO+d7teB1C+10H1lLxNfzbYyehwNg==
Received: from BYAPR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:c0::34)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 19:28:01 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::2b) by BYAPR05CA0021.outlook.office365.com
 (2603:10b6:a03:c0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Wed,
 26 Mar 2025 19:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:28:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Mar
 2025 12:27:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 12:27:53 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Mar 2025 12:27:50 -0700
Date: Wed, 26 Mar 2025 12:27:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <jgg@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 15/20] hw/arm/smmuv3: Forward invalidation
 commands to hw
Message-ID: <Z+RVM8Cr+EcnhDaJ@nvidia.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-16-shameerali.kolothum.thodi@huawei.com>
 <af531bef-4597-4729-bdcc-f6b7e3647266@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <af531bef-4597-4729-bdcc-f6b7e3647266@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: e97a46b7-5582-4a3d-e674-08dd6c9c52b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y+Ewe+uoNIeiLQBOICXdSW/yTvtFiw4t9amgG0qb+u8fN06dWb9xSL0fPFtb?=
 =?us-ascii?Q?PBT6JkTvIKjFQDirpxMVAVhm4kOU0VGimOtPql0+0c85VBVAkot8JuPuVMPm?=
 =?us-ascii?Q?fQZLHsBajyy1HSEO/BxMY2Vrou4bFgrHeMQYAXnQLUQzrRiQ37Q9RgDhRiDP?=
 =?us-ascii?Q?nC7LuPbtv5fHI/zJS9lsR02gw3nJgEyiOHOmdCR5tXHgtrloGtRSftCV3Dk1?=
 =?us-ascii?Q?RgNE8g6AAEo7x4HTaqrkfJy6hQVDkA+8Kf85s6qfqdFjpNd7COeet+sK9Joj?=
 =?us-ascii?Q?TShdf1b5+qL7g9G4o9vmjoZcc1i8X+MBG9aAt9hgRgn0a1/DqxgigUIXyzT9?=
 =?us-ascii?Q?yw8dzjM4wSrSnRGaXEJui2lQVa0pk9MqLeVnb+0t3HF7WO1pIv1vzGYJHCOU?=
 =?us-ascii?Q?NwGfhV04n8Y6q4HQoTcR57IR3yDilbQuUnpfs3pLORUfmxNj+q47yvryXH5x?=
 =?us-ascii?Q?Akej0+4k/yFBagreHABSgI3wXmR6brbzlfwf+QSoFxmsmqVrCL0RPdKtilin?=
 =?us-ascii?Q?RbN+dAJxV5mlis/ChzdrO54H+xsZMYcSC7rZOHyH02E0p6DkLlSSSX9yOOzw?=
 =?us-ascii?Q?r5NS+7+MsxuCi5yHB7RF61zC31kM0qZ/VdX6nrmOckCWWDrcekzJiSzIBDTP?=
 =?us-ascii?Q?z8eR3lqiNDKhVm8VKeGxmWbqEZBpIAyDHYcZS85/QAw/6NA6xcDqd65TQ4oz?=
 =?us-ascii?Q?a07iVbmv8uSJ71ulESDxvS/Rt/u9mrQgYDRWGzEzU/XEZvvMKrZ1SegFdb6S?=
 =?us-ascii?Q?xMejOFumrhmN+decGU9u0sBk9p9Qt8LvPReErm2bADFc9QDk5+ydT+UkvBTP?=
 =?us-ascii?Q?TTXBCknpKapm9nJnLNMBeOu7R4II0wKwRXqCmJ3MViBzDK+nUgYfCMNCsOqD?=
 =?us-ascii?Q?V8AsxPgoOIyCw6nSBZxL9rX2m6le8yf/o8PnRuK0TxGXX0w/s7Ruz4vQEXfY?=
 =?us-ascii?Q?WK9X1CCVcEGkBojZO6m1D+AxnCg8/rlESPkQbAbhgM6h9HDu6Hi53CZk+69A?=
 =?us-ascii?Q?v84yBnILshu67v/U4c+PwDRcOKx7LFIaTOQmWJdhS/ic1SUCHuUoU7+oK7rg?=
 =?us-ascii?Q?jRRJW0JPJkpE3U2rm7NEe0h4El08Fl4riIwTalZ0G1dZVFyClEEQOzRfcqZI?=
 =?us-ascii?Q?DNplxanVvuslsbPPUpLcngpk8UKFJLkLjBKgme1oXNpM/JFAAN70+z0ZTzFv?=
 =?us-ascii?Q?I2DTSX+tJQ9wgIR/ZukwTzo8orLd89ctUfgVfJhMP48EqxpOs8VmyVYWxBHi?=
 =?us-ascii?Q?b48To1G/50Os1JikSdemRjTft3aZVgavbpVhn93nHiBeMAH8yg0HtT+B8pTC?=
 =?us-ascii?Q?27XngMdbgKrqoqs5NlvOCjYzNylEzd0e0o6auyjjQNGCWf9hIUj7aUwLfH4s?=
 =?us-ascii?Q?5GAf7jy9GoDvIJfN1dbpMlPAYpsM1rwE8/7Vkk9N9wrPU1VD/kUNWdF+F+3y?=
 =?us-ascii?Q?fXUE/GrCvAr92xm2SeyUU8hmWg94Y0W1dbh/OxKzQvChZKTnFyPQGG91+e0f?=
 =?us-ascii?Q?ns4EafaUx8lCkdQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:28:01.4385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97a46b7-5582-4a3d-e674-08dd6c9c52b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
Received-SPF: permerror client-ip=2a01:111:f403:2406::60d;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

On Wed, Mar 26, 2025 at 03:16:18PM +0100, Eric Auger wrote:
> > @@ -1395,6 +1403,13 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
> >  
> >              trace_smmuv3_cmdq_cfgi_cd(sid);
> >              smmuv3_flush_config(sdev);
> > +
> > +            if (smmuv3_accel_batch_cmds(sdev->smmu, sdev, &batch, &cmd,
> > +                                        &q->cons, true)) {
> > +                cmd_error = SMMU_CERROR_ILL;
> I understand you collect all batchable commands all together (those
> sharing the same dev_cache prop) and the batch is executed either when
> the cache target changes or at the very end of the queue consumption.
> Since you don't batch all kinds of commands don't you have a risk to
> send commands out of order?

Yes, that could happen. But would it have some real risk?

This practice has an assumption that the guest OS would group
each batch with a proper CMD_SYNC like Linux does. So it could
reduce the amount of ioctls. If we can think of some real risk
when the guest OS doesn't, yes, I think we would have to flush
the batch if any non-accel command appear in-between.

Thanks
Nicolin

