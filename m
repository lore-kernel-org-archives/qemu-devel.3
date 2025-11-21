Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99905CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 01:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMchj-0007hO-Rd; Fri, 21 Nov 2025 20:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMbLV-0001jN-1W; Fri, 21 Nov 2025 19:19:25 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMbJQ-0000ZM-A4; Fri, 21 Nov 2025 19:19:15 -0500
Received: from LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.13; Fri, 21 Nov
 2025 22:11:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlrcOTbWRxsxicXz2HVH/YgaC7HqL4u+QbLmvTZUBQY7I52rFd2OAzsD/N7x6h2DBbgeySOKRohkbTjjF3IualDV4/ZbDEUUS8Osr5URHGlGPyPWB6kMDVOhxhX5sSQ+PH8+kDjv5iGCGprApoWmYYu+vmuvQ7GUz41rcicPK+uLWLQPmk6LTwEN9cFr8Ju8QfgXRv/v58FszJNy7XyCi1ImIxg9QMx9JYGxIkzJAcui4626IAXgHgU06AGJy+hcA1FZqaaMbDAY/TVSvKAYgQFsD62JPvpc6fqAQGbSWAwPGsQGp2EJa7FPtAZJfk5w/KD5K+JyKffrZcbsq+piuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9abRolksorFAzPzumDL4cf1sRonMLuYRQ2wjUw4CBV8=;
 b=dtgFqKL0S3Iofij6tB2FCJq20GikMWxAJLr3anPmXnK/OzpG3dvjV3xs90cBSaOzCkGPmXXCgreS/AG16GooVxPDsztZON2RJ4Z7mMR9am9wTZl1j6xojPcd+PCdFJvxkPRWBLAo8Lacuz8MzfzmSatBK5fk3vFwDlzs/xh2DkcEpZHo2opwFZg7ooey052U0zcnb9rlPsVH3Mx+PgzgC16OglIJI2ONQI8d+Ce2uN3y/2/pBaNjAYlftFmC0B1xnjbmpw43yNLtKuVLbHBf0pBQa84Ayxch/HTnXsYvlJvAvg0Yj9138V0rZyAqZZpllydLXf4+ZcJdY2lbqL9+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9abRolksorFAzPzumDL4cf1sRonMLuYRQ2wjUw4CBV8=;
 b=I3DfLsUBh+zNJ01ZyyZ5jSKLgiUsl6UOuPT4BrB5yfk07wMRiQ0oUxKXJR5iLhieYGCbMCsZzpbDYKIbd2Vsg7ax1tU7XVuHfspVecuM+Xa23v5Nu0RYzHkckmzAdXfxOlNdZSh+vv8L5QLazMNwgHG68/Tnx2rcXBAubqToeHZlUNcHhtVL1r5vbraOa2z/eSZNDnAbZQj7LoxwLxSEV+thrX4P1YNnITtZibCOc9BnmzbwWIJz4AbwSCXakoyyHVwmDeD0aJU0LLgOoehKh03Bp0U+8BqiNlxiJhyUJ6YFO/F9VnpEFOAxTx+EdceyiZbNapUB2vSVtUfFmw2jyQ==
Received: from BN8PR04CA0057.namprd04.prod.outlook.com (2603:10b6:408:d4::31)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 18:36:43 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:d4:cafe::d8) by BN8PR04CA0057.outlook.office365.com
 (2603:10b6:408:d4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.14 via Frontend Transport; Fri,
 21 Nov 2025 18:36:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 18:36:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 10:36:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 21 Nov 2025 10:36:26 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 21 Nov 2025 10:36:26 -0800
Date: Fri, 21 Nov 2025 10:36:24 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v6 33/33] hw/arm/smmuv3-accel: Add support for PASID enable
Message-ID: <aSCxKPBfmhdY0eGj@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-34-skolothumtho@nvidia.com>
 <aR+RngqP3HTLZIlH@Asurada-Nvidia>
 <CH3PR12MB75485354E16E462D66567416ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aSCmeoFtzRBEGE8I@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aSCmeoFtzRBEGE8I@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|LV2PR12MB5896:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: ff715bd4-8014-4e94-ebcd-08de292ceb45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|7416014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bUwwiNDHKJdxqMwCaa461ngW+CU/47lit/f96dktxJiAQoEmvF56u/QBu+zQ?=
 =?us-ascii?Q?Dt2OaCapJfkAXakhhS3Tmy4Dj2Ho/mSi3po/8zrAAjWfXoFADNtlHX6/f9zo?=
 =?us-ascii?Q?8OPEmLVp+s1GspCDHDn89dsbgjQ/fS3H+BxPa3baEoz4XL64JPZ1pebwmgA+?=
 =?us-ascii?Q?qEuoxHraYUI+/R3fhfAfviCTlQVUPNoUg4oj+rOXJ7d8jm85HGGZXJ0FDJrv?=
 =?us-ascii?Q?5RB7mSyXAkj5ycKOUnv116saaB29eOAyPv+3LVk8K33c3DazCFtqVFw5nlzE?=
 =?us-ascii?Q?0K3u5mtp81ah+B3IRakmm9UDk3woCqlWsBZU9re9Djkx/KjzrkHT7M5xNt7q?=
 =?us-ascii?Q?zV6eiZcKZMUr8j3qFSTNntggNGGoL3Q0ryc8KLYFQTjTWI3UsKwBCnA1kSxX?=
 =?us-ascii?Q?k4T8ZSSog2M66hFuq12CKBZkOqHfsdl3v0X82AoUihhdEylK2z0SeFRjp7Lq?=
 =?us-ascii?Q?gJHe5yQbAoNw4MJG5ELvbpkMjqCQO3V3XWptYkG+sdKAsYljge/8+OMFoH13?=
 =?us-ascii?Q?zn4EvYMiz+aJ5bGOIo26G0mDaTBsxiRZD+iZy/56GYfVwnGtL/U3NsmUwZI5?=
 =?us-ascii?Q?QFYj6w1F/SHppiKAwXeUfNqNxoy1lL5vow0ojJcH/E1fEA0tMmvICOeDQuut?=
 =?us-ascii?Q?X7eTkR5usLtcw2e/Cut/WO3H1kb2ZgqSQ/rnb29He1HDKhrENTtHxTtsQA5I?=
 =?us-ascii?Q?id4QWzYKB2HkwUDd6f4p3wJASWbI5vSazSJMpoPVGJ9A+b2S37zlNzE8dWLS?=
 =?us-ascii?Q?REItt1vZ/iuY6fbkBpyRSTjXQcI7mLPWh2nLo3SWY5RDtFhtpTa8+i31eGxa?=
 =?us-ascii?Q?8cUjCXYFpE+ePSEx7geVwbg2QoySkAin84GW+yz46SthXtqaupIy7+bdNk7o?=
 =?us-ascii?Q?irzscThm+/m1mIq61cjL/rWw/sdP8ravPtyoVerOmYjxepV9h0oov14+GAdZ?=
 =?us-ascii?Q?NUghdwRZt5qlFHwJbo57Q3Zn1cerscNJRTfsl88cBVYfrCbW/vwPMGLYdDRj?=
 =?us-ascii?Q?jWnq1HjAJSAen5By6CqolxIXvjQTWKE5d5wt8IBYsmtT1ra7fBb0XmH6udxl?=
 =?us-ascii?Q?w/o45xSjCEUxjmO6DvLjO9jzHs3S8yT6VkynY3X5xLYqTpgBRtRq9ktW2kYD?=
 =?us-ascii?Q?IxYs2vDbpR7bogieO3tZwtc2RhD1l9u1zLUyDz0oAJSECbQhfVY3SNZe9WTb?=
 =?us-ascii?Q?JiW8Ngybq8zt7q7sMdQjTizs9p8YT9aQ58u5aY+LaNSqdn0snY9E9vjLTE0+?=
 =?us-ascii?Q?NzvpF/YYwuJY7yrjrA2aARvTHiFVj0EDpDCKw6y7XkVFKEAN1F/xoK1sVdZi?=
 =?us-ascii?Q?KWXAzof3m4SYsMboxX9RDACHkPFDvAjsi2Fp7zcSd4qH1RSagpcwZL6HEK3S?=
 =?us-ascii?Q?BcSxVmOWtuvcMQeF/0IpjcU0vDP2vbSqkiwCBSlH2Ge2hOXfLLJF8h6ZCNXI?=
 =?us-ascii?Q?aXPzpdwX6mphsdDsovP7LO7OQeWHZte/qubOBxBa+BfWXaSaUXo7bB48wVsW?=
 =?us-ascii?Q?W8d6iwRyBWwmjx9K0v8bH5qsKuC+B+a/Rrb19Cv3HAC3wTU76H1d1KdqjNiE?=
 =?us-ascii?Q?Cc6V5in8aOXvnlMyjls=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 18:36:43.3925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff715bd4-8014-4e94-ebcd-08de292ceb45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
X-OriginatorOrg: Nvidia.com
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=nicolinc@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

On Fri, Nov 21, 2025 at 09:50:53AM -0800, Nicolin Chen wrote:
> So, I think it's nicer to define "uint32 ssidsize" in the first

Correction: "u8 ssidsize".

