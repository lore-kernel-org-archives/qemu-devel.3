Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9726BC35FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 05:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tulyW-0007Yt-LV; Wed, 19 Mar 2025 01:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tulyN-0007Wc-CD; Wed, 19 Mar 2025 01:28:11 -0400
Received: from mail-bn7nam10on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2009::609]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1tulyH-0006io-Li; Wed, 19 Mar 2025 01:28:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xY5GC4ZhPqeLBbissqL72KjGuYpm52FDg925g792phbTym9k2Y8goV8SSJ5st1EBj2qeLY40x1pdZZT+wldGwPygjTeVtBGNSAmbAmv/tdZ54Rp7FYMDfPfA/bsp7Os6oftV9Uwa12KXMZM2tdiVh8nfgfr5HaJTObpq6LNOLDuG+vvVMfwZ8jmbh+KcX+Oj/s69YnBsQheMJdRY7nBLvJ4SoRput/DijnFqe6luEwpPGqw0Qv3mMb1cyTBH17tZYiMVzqAOXyGF94OZF7Ztcq1AW6XbuGUSMw+XtzbYsHsWkA14nH4ymTImhnBCKARzgQS5E0rFCAdA4UqTfKmfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhe/ELCiIGavjTO0QEgtlgzGsjV8+J2S6JI5rHdMmIQ=;
 b=A0hMeMlnHLF6mwh+MPPhEarqGdDjGCooW6Aa7KUSLfpKoXvvAAISv0yqzgkePoHMX2Eake6ttCoiABEFu2jndT1zxZXTwRYgymmuOlpxfaGvQazoi8k7gERZRIH/sPotjAb6SnE2CKZhNusnVv6q7OnB+D+Wd6Ru+F0N8A2etwpndZDCtjH1QXgzJP6kVCgNBF37qf76XtFjaoLRZbDeAIXp/1Z1z6FkP35mz1jl9Dd57cGcMA9xYFXGhb2R0C1nThp4Oq1+JaNC0F9PESjPtjCjvu2Y7ZKgK92CBIqpu7sVqty1CKhstIl9hCwyjPKNJg8t3HSJe1L+EBs9JVMd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhe/ELCiIGavjTO0QEgtlgzGsjV8+J2S6JI5rHdMmIQ=;
 b=ekvWJ5UpePYWWwafnjYc/d0OZL3cGFUhoe6l8cZcb0rvm/3TadXylttame/PSjCFbLTnzk7snK31Xk6g+aszhmiBGEeSfVHYvX1HytvO1kYIhV6Vxc3IPoswKYHegWHRjAoB9hJXoaJz2cTRUto5RXTvXyLBkyeq5/2tOPefilfz6fQSR9Ibdv8p/er1oMQDVL2rBJpcLsdv+wIRTtO2svZAN9YyAMwkVmzstKo8H0Fr9Qliso9WMRLiK0FghyKTEEDWHvpYrxT2proHg8MaHFdFe9mtnmMtk+oiH2dcRu6BtBgIdxPfZp59FYdr5qbqMoQwh2PL8OlDeiz5fF4Jhg==
Received: from CH2PR18CA0053.namprd18.prod.outlook.com (2603:10b6:610:55::33)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 05:27:56 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::82) by CH2PR18CA0053.outlook.office365.com
 (2603:10b6:610:55::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 05:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 05:27:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 22:27:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 22:27:42 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Mar 2025 22:27:41 -0700
Date: Tue, 18 Mar 2025 22:27:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Eric Auger <eric.auger@redhat.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Message-ID: <Z9pVzF+kOSbd9reD@Asurada-Nvidia>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia>
 <20250317192453.GR9311@nvidia.com>
 <Z9iDxSvZVsgtasGj@Asurada-Nvidia>
 <6cb391a4-d150-4692-b62e-a509448a1034@redhat.com>
 <20250319003135.GH9311@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250319003135.GH9311@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: bd433334-65c5-480c-0b9f-08dd66a6cde8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y5WqT8ApVdjqukRxSzOCqS2tnsvPl054u3nsqY2By8XKtdb6Bglt2cPlIFH9?=
 =?us-ascii?Q?dMesfSm8jIoH5uwBbTYuNjtBkCHJ/7KG/Z2Eqbh8CiHrrGccGNB67tabfrol?=
 =?us-ascii?Q?8NDyfcTMN15YTNc2AerI2vhPmKHitWLUFChCpLS3LdO1X6EtLxUON7lOfZFV?=
 =?us-ascii?Q?tgSIAiW/5rhEVJ4upkIyctfSOVRz8fZ+4cOXmkqQq/8ond2Qlq8+DP5GnZ6j?=
 =?us-ascii?Q?mk9tEQ853VZsNxo4qr0XG+T4Si9vQsaAfVxsRPTNUVX+IO3ToGCM2NPXH8Gm?=
 =?us-ascii?Q?kOIuJ7sIG3vB/cMRgEWdRE+HQS+sdASPEgjzWvSedq51jIM8cnhIQkL1w4Ci?=
 =?us-ascii?Q?KYWG4mfl0+1YUPcAihmHvvrkvXECX9uw5JJogCJWsyt3oXUmC0HjhdyMrZCZ?=
 =?us-ascii?Q?raVOBnXMc+NDv4s1ykVNh2VoqCOhL4O2zevg03rQrwkZwjB8Kfq0pHJOaIvS?=
 =?us-ascii?Q?SIA3SRyASu0C77d2XfgDu5Fy1o7aKE87w9OYCu8v9/ldYJ//Akn0BMLaPpUf?=
 =?us-ascii?Q?5Hl12vOK8skHaDam/vbitXLQvX5x2U1RW0hWXfYLrxB/fPP1A7aMaZ7/RVCk?=
 =?us-ascii?Q?qiaGw1yTyhg2W0nB5y/NrqcAWfD5OqF8iayGP2X+EP+Qj3qiLTY+Ngb7PBDN?=
 =?us-ascii?Q?4jTYznld+8dSGictv43250e3fcaQ+Eg+zvM5YCFcSmld8fPClP2c5KjCs7bd?=
 =?us-ascii?Q?GIr4EUdPUd0QvnG8rjrrHu7VHaf6zYrE1G2Jc9hxywYLz3I+X+kJ0fjrNKSf?=
 =?us-ascii?Q?UM5EVhhEgeR8lXNvt1LWS2cZ0qwX42CkMX+4vUCQhGUzYFCcy0tkNxpX4uh6?=
 =?us-ascii?Q?sHlKFQolruEwejGmsYxYbVdLosZpXtpDokl8geCCLMd7YdkjP7+W6bnZv//A?=
 =?us-ascii?Q?ocKFzlbwCLZT7efvgoVe5iLmnYhZOKZokO2GAbQQLUiJ6wlj2SpHk/oYQ16E?=
 =?us-ascii?Q?T4h5sXqAjnuVr1kzaJd7VYVgTd7CU8FKUXznYU0QYyo8aJWaaUAVmmg++ulR?=
 =?us-ascii?Q?n1SIx8gAERg5/yV6nnhCPR2zv7/d+AxblBleTNwHaE0RCiA/uy4CdxGSodn0?=
 =?us-ascii?Q?r2H7ypr9tKOu5Dt/8ZJ4lqAg9xng46acjhZ6PINvpebhPA0ukVAbkP9l04Tv?=
 =?us-ascii?Q?tSm/KhRv+7hHGU3OcRSJLlzuW+2kH0alfBGxahpLZCbXIbDbxzZGZO69z/Uz?=
 =?us-ascii?Q?Gtl1OgStsyvFhAP7BejMsrD4Lvm41tWokWF0GlW72by2phSoSRtl0q+CEwKP?=
 =?us-ascii?Q?dctKr71S3rH7g8av+EB+XMtKpYPcGdYF7k9NM7PVGJcUUakiq0T1Bg9LQN9M?=
 =?us-ascii?Q?1U+rpJ3eQGewekkjp5KNmWdOZTNsJiClGMkWjlyZx12TAJQVPr/JjkcDHIpm?=
 =?us-ascii?Q?maEGqZTuHBgZkTCQhzjUoNJlfiz54enT/r58s4K4pzq9swRuJFKKqkFGeNPf?=
 =?us-ascii?Q?lNb8cTgKfRDtecyHgw+UgxiegU8bdZVjCQ9B4mhfelYvPwDu9OyJLD1GuECW?=
 =?us-ascii?Q?WpPhUQBR+2PgvHg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 05:27:56.0056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd433334-65c5-480c-0b9f-08dd66a6cde8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
Received-SPF: permerror client-ip=2a01:111:f403:2009::609;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

On Tue, Mar 18, 2025 at 09:31:35PM -0300, Jason Gunthorpe wrote:
> On Tue, Mar 18, 2025 at 07:31:36PM +0100, Eric Auger wrote:
> > Nevertheless I don't think anything prevents the acceleration granted
> > device from also working with virtio/vhost devices for instance unless
> > you unplug the existing infra.
> 
> If the accel mode is using something like vcmdq then it is not
> possible to work since the invalidations won't even be trapped.

Yea, I totally forgot that.. All the invalidation commands that
belong to emulated devices would be issued to VCMDQ (HW), while
those vSIDs wouldn't be supported by the HW for CFGI_CD/ATC_INV,
which will trigger errors/timeouts.

Thanks
Nicolin

