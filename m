Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F92CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 01:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMciK-0008Ka-Th; Fri, 21 Nov 2025 20:47:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMbPx-0004Zw-KN; Fri, 21 Nov 2025 19:24:01 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMbPj-0002dm-9l; Fri, 21 Nov 2025 19:23:51 -0500
Received: from LV0PR12MB999092.namprd12.prod.outlook.com
 (2603:10b6:408:32e::22) by SA0PR12MB7092.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 22:50:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjtkyGTQp3gJUsjwhP3FTl+HMfzelZPZqgLVZNCVE/MKmXqsTJHeFEHhTsCuAKVFSgxxFlMZF166QtG3Nn6LDnd2BKzhRd7xc6GE3qRYGAo9WdGz9uXxZvwZU5p4AvAU7g1ueo4mbV46cX+rFFQhHjD9y+BjqyM/qJU1ugZyIfo1g1kvpdKsdnwjORWDGCtVVq+jAQ5CFSr9Y5Cu7hwsH56sCC6lgUdBfcY5WTCdPTDb/bzOweHloJF6eGtGfbjVhisbVGVN40KmvsIgDbSpKfbc6Mm07xFA7rS8cNaw0W/wrmGz7KkdGc70tEEtaW6WiOLVTEmyAPAVg9Zwenc1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQNfUffxwn4nk3br6jOuGa/4UmumTiNgJnRPAhghtPg=;
 b=NWj6/Fb8UHBaUTfXHHOUOPpMAlzzqezh8hC7e+0oy7BMNm/IPWoeWrRsVA9+2u9AKpdobaZuXprKXIAWwazMU/hPGys6oGIrk8cIEMyAPRrV3dfhGkCYiqUOw7JVI61hCB9nN7phf0pLhjMvVP5ZcqHkgf5aG8G4evHnPTzRnoniJma8cb3gDT3uYhYptyPadgRKWWtbuoCdPcAze2tohTo1GNciTX/Yqf3QfF8iZ8i2mwFgFeojZopfeK6RLdP9I3ROH7O0vZ68smxFAPADEzeSnNI/JouaFpkN/bbY7F8KR3EyHBQSybg0kGGtj8XbHp5igzTM1AeQ07bSA5UuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQNfUffxwn4nk3br6jOuGa/4UmumTiNgJnRPAhghtPg=;
 b=Q3hBDElqF+w6H0BIou1fgD4JBj6uEYVRx0r86fEGqkkf1Xg9ygBP+Sxd8JRGc7xDpv8mKNzQQO/gdZmNa3X3UaDarQ76rxAGJHj8y84wiwKCrRxfqwZAkRA/R7DEUyx/QOwuDZTkJzOh+ypKZhzjSaZb+0NBwpIGXNQKfJU5ahCgyMAlJbJYcwMt5VNSKr8VkllbMXDkAIR6VsyWZQR+p6nukQW2geopezFA5PrFr1RWvSPwHSGflGsrxIqiBzeBOlVLD3GC8Qp/FaTbibolPZ3BoqxriqCf7ubGA0gBUmxFkXhMdBwOCla+yKmHThKB1KVJimHrN3nTLFPSeZ1Lbg==
Received: from BN9PR03CA0277.namprd03.prod.outlook.com (2603:10b6:408:f5::12)
 by LV0PR12MB999092.namprd12.prod.outlook.com (2603:10b6:408:32e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 17:28:29 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::c1) by BN9PR03CA0277.outlook.office365.com
 (2603:10b6:408:f5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Fri,
 21 Nov 2025 17:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Fri, 21 Nov 2025 17:28:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 09:28:13 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Nov
 2025 09:28:12 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 21 Nov 2025 09:28:11 -0800
Date: Fri, 21 Nov 2025 09:28:09 -0800
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
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>, "Michael S .
 Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 08/33] hw/pci/pci: Add optional
 supports_address_space() callback
Message-ID: <aSChKQtpSs/zYqh1@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-9-skolothumtho@nvidia.com>
 <aR9/SMia+iganQ2r@Asurada-Nvidia>
 <CH3PR12MB754864DAE416B1EE5C1DFFC7ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CH3PR12MB754864DAE416B1EE5C1DFFC7ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|LV0PR12MB999092:EE_|SA0PR12MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 4171b98e-75a5-472b-f1c7-08de292362e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7OfCPFWgxC2YQQnTv/BR/POdM9c9PCHEyuxdl9RTu2XEDHZY2SST8aq/W+zX?=
 =?us-ascii?Q?RrYXO11riqQI2JfH/sbkjjF/OhvtbBzv69lQGN6Y55R1xC34XMg2TkPSq1M/?=
 =?us-ascii?Q?FD1hAM8FfbMQ1AoQ2fhnBYlV31QTAFJviH+0tLUhNwiUBDL0P5ELaIK1IrmE?=
 =?us-ascii?Q?Ze+VXChvxBmbhByRMWd1Ro1n6F6VVeGSEbgFdR6I7WhiLd8g11rGG0YF13ZI?=
 =?us-ascii?Q?Tkmtc5Qyg+dPQUDOJR+xVuwhJvUwJ/x/Jth183mJ3LL9vYJ8ny9iKstq25Xe?=
 =?us-ascii?Q?Hi2b7itnfGRc9lbSZqex6Y1TRjbpvEL379O+up26FCekZW8rUjXZ0eAZ2DR+?=
 =?us-ascii?Q?ZDQFCQ3nrOCvyrEHQ49DqVSjZWW04Klj4hvuknuQG/v1w6ykZ3W4W7FVq5Le?=
 =?us-ascii?Q?mgiEpebn51vnYVBSAO7OJzcHdL9wa+HWmdD1gtESlOSKmA8mn2NiN8pT7ODi?=
 =?us-ascii?Q?bgOIFRgg97DB/ylFyi+AKictMPifBCeHtrtFU6ARzYvUQuBGhUHVdcLBzQgT?=
 =?us-ascii?Q?UHsO8BCdZPKX1w10Ah8ahyr5DGZMSYaYplRo8qWyYN++ZOHoqYpSS5GRK197?=
 =?us-ascii?Q?ZnR3nRtObOmDAmiSCm6k0Zk0dwI8qh3OeeKvBIFcVKZimit7KEMChzKaxzVO?=
 =?us-ascii?Q?6yssZ0x3dROlvLsczODIsv2v9dxC3IAJP3KaWzNhv2hKzIfhvbiyLB9SAuPX?=
 =?us-ascii?Q?VSAdJah3FmVneUSbM57NBMwDgDJYhKZimwgDJKg9FNspTBxkopLM2WzHWA8W?=
 =?us-ascii?Q?3eANNOKEQ0MFRJPrWNmKa5+fBe9cp98luzzoue9aubIPTxQaFwBYer7ollJV?=
 =?us-ascii?Q?XrVesY1ju1eroDimEyKHHQ9DSwrT+6a7CzTvGA7CgrJTCJ1N2XYxR03SKmKa?=
 =?us-ascii?Q?7DycV4ZeUdKCZEHIQRdhYAEura+MtAalwo9GfEypukcQN7GucLmPz2ck5u7L?=
 =?us-ascii?Q?KPUQ/szkexCdP3WZqki/ge+5tPv/iHqdwLJFpUFlbi2XzQqItR0JKXm9sGfM?=
 =?us-ascii?Q?qNzJV1RSG5fvrEqAhoDttNbUXnuKPOjAHIlHj7ghVZjxMafynXzcA/cTjPAP?=
 =?us-ascii?Q?UxjtG9Kg4nZ0Pd5/fLwyBgX9m2JCzePnVam2jRxsEqKp9HDnYN/eRtYR53X9?=
 =?us-ascii?Q?JPHExtkNoIs6uj+YD2QENg+k5U/N7eOB1prdmfqDZ9L8ELDRIG4v2PWBnPET?=
 =?us-ascii?Q?y28w9OuX8SphLjH9eVYkHzfUW3I+mo0YS0RcOFCkxOX+jnG5iFoMzfsFkhQE?=
 =?us-ascii?Q?DDTEjEoheR4mp5nq0Wut+/dewt2LJfgYRvwr2b9oNdANlpM75iWtM/qmzHnJ?=
 =?us-ascii?Q?8PeMtw8R7M5ckJyLg4loVoLxFqDx27e91ZGxZOYArlE//fA/nxQhlpyUJC//?=
 =?us-ascii?Q?aOPbBDiEwPoBGDa2VBT4S4fqPXZMZM8mTD28Ydj9cJ6Sqrq3/ridqvrAw/dq?=
 =?us-ascii?Q?TeNZwgI2B1rdhzgh9Mj8VAKF3rl/ZbBqJEaF+fLyVbtbLLi2F9XhoMHmk63n?=
 =?us-ascii?Q?PjSRC4sPZHsEp2MLZOxAv/zWKDIpX42u3f4MDyEe5YVBMQQ9Gfb9pzcYzWcG?=
 =?us-ascii?Q?lEjTwbHx2MRM/TRsFyc=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 17:28:29.1329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4171b98e-75a5-472b-f1c7-08de292362e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999092
X-OriginatorOrg: Nvidia.com
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=nicolinc@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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

On Fri, Nov 21, 2025 at 02:38:06AM -0800, Shameer Kolothum wrote:
> > -----Original Message-----
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: 20 November 2025 20:51
> > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> > <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> > Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> > smostafa@google.com; wangzhou1@hisilicon.com;
> > jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> > zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> > Krishnakant Jaju <kjaju@nvidia.com>; Michael S . Tsirkin <mst@redhat.com>
> > Subject: Re: [PATCH v6 08/33] hw/pci/pci: Add optional
> > supports_address_space() callback
> > 
> > On Thu, Nov 20, 2025 at 01:21:48PM +0000, Shameer Kolothum wrote:
> > > Introduce an optional supports_address_space() callback in PCIIOMMUOps
> > to
> > 
> > "supports_address_space" sounds a bit to wide to me than its
> > indication to supporting an IOMMU address space specifically,
> > since the "system address space" being used in this series is
> > a legit address space as well.
> > 
> > With that being said, I think we are fine for now, given the
> > API docs has clarified it. If someone shares the same concern,
> > we can rename it later.
> 
> The intent here is just to let the vIOMMU decide whether a device should
> be associated with its address_space before we call get_address_space().
> If the check passes, the vIOMMU must provide the actual address_space
> through get_address_space() callback.

The naming makes sense now. Yet, the API doc is a bit confusing..

Why it says "device can have an IOMMU address space"? If a device
only has a system address space (i.e. it doesn't support an IOMMU
address space), it still returns true, right?

Nicolin

