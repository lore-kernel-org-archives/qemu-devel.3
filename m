Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352EAC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 17:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sREOl-0008CY-Tv; Tue, 09 Jul 2024 13:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sREOT-0008BB-Eq; Tue, 09 Jul 2024 13:12:46 -0400
Received: from mail-bn1nam02on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2407::619]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sREOK-0000kk-Bk; Tue, 09 Jul 2024 13:12:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Azdgczcbm15nahgNeeRDRf2I1aKa55PPPbzYgDchxF+J5oBMo9um+h6fEaae0DOAKq87QSkB18jSoZZzXIjd1lsO9WiPCja75C69PEvKn8OW0cAenFpnbF3NEgPsPgv9kV9ML09LNqxUB/LqvxVvuMx7f0h3nihDWn4EU6p4/D042TYZTg+KbLr//8XCyBZCBNCrThBf69cu/L0Hu6t5+lKsptd4hWQwSHurSkfZlH+mXlJVjG4p7pVZoer4fgCm19Xd/W03HdSA2QC56XSxzl2NOOrKTJ0Ftz2liwtoMGMoBieSljHs6Z287LoPZHigGU7gnhrv+br05FBRF3tXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAB8a7UycWYWgV9D4xDe01Y4KZBbFrRI+NsBXxRBCVs=;
 b=gWwybXPQFYPxcuI5pt9BardzllID03+R1/N4BYTKRNhSmQuPS4Wyy/h4HSJ2sKp5CkNsuslMdDzVwZjhzRUYhkQ7iPXVKVFaTjDs3he3MMn9x1OOx7chyJRz2B90KOsHpjtBIm4qizajhRdn2RFv6/wgNZ+gM7lv9PiDnQTufNWD+UbUVXGenlbCWjmmiPyMIf8ECbgD4PhVsxRdUYxuECnMDukISFUJDAxYrruDTQ2nBna3glPfkQmVDT53o9TJvPGqnAYdQgunMjpTJ8QnBCSCfLuiaHCakCH+1PSc1QPBvrqQncCSPsgwR0Jkolb+Ir4rsAHCjbBcGE6Yo3hh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAB8a7UycWYWgV9D4xDe01Y4KZBbFrRI+NsBXxRBCVs=;
 b=qlaNvZC3GORH1ZH62hSX79no5mic9OBp18NF2/Mip6aS9JpypVSQzYiYscXTSUpyblbaLy2QP3J9GnORoRcYW/+MAfnCZHu+KmhFVpnE8EyWfp5F67QEGyIqM3DooFNHyZ3u/jIWKgRTcMFx/YVSyq4UZMX6LwbR3kOKnrxxWhqF+MHdtE5R5W327fMu0WyChnT+mqfAWD1+wlP38yJg/G2lIXMwX6aziQnTBSTV9jKZjpvoQycoKcoALzcywDCwb2uGNCH5+3xuaB1frRN5LaZ9kTWzWk5erPqiLmwI4kMeSkvVgbB64k+6z54FIYjZAVqaJLEUOiXH0YT9qZEOlA==
Received: from CH5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:1f4::9)
 by SA1PR12MB8144.namprd12.prod.outlook.com (2603:10b6:806:337::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 17:12:25 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::43) by CH5PR04CA0024.outlook.office365.com
 (2603:10b6:610:1f4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Tue, 9 Jul 2024 17:12:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Tue, 9 Jul 2024 17:12:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Jul 2024
 10:11:58 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Jul 2024
 10:11:58 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 9 Jul 2024 10:11:57 -0700
Date: Tue, 9 Jul 2024 10:11:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <mst@redhat.com>, 
 <imammedo@redhat.com>, <anisinha@redhat.com>, <peterx@redhat.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <jasowang@redhat.com>
Subject: Re: [PATCH RFCv1 03/10] hw/arm/virt: Get the number of host-level
 SMMUv3 instances
Message-ID: <Zo1vW5dwHqBM5zFN@Asurada-Nvidia>
References: <cover.1719361174.git.nicolinc@nvidia.com>
 <886883c4cb43117ef26e6c9434247b75cd827f31.1719361174.git.nicolinc@nvidia.com>
 <3d151591-4cc6-4de4-8055-27d6fb7200df@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3d151591-4cc6-4de4-8055-27d6fb7200df@redhat.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|SA1PR12MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d8183a8-b73a-4ee6-b7b2-08dca03a4b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AgViRgk2TORBblnUz2v4ary3kIjZ5yLOyV90ziIw0ck1XDYaApJKOkQs3GjI?=
 =?us-ascii?Q?sp/BTowOJcQsTRMooiRtoN4TfdM+sFLM5v6tuJdcIF3UKIxxyg1q/Rko/y0U?=
 =?us-ascii?Q?qkxvRRHyv1EASGsNvQnXy8mjS34DA+OWIX6zauBYRiuLS+62IlrVJRlftZ/+?=
 =?us-ascii?Q?eGzwgTNWNXzk5q/irnbmQfI76MXdJhLdnX1WFdZvxj+2+WDTLxQDwmkbyvis?=
 =?us-ascii?Q?KdUhetfhW5MVzj7y4fyaZaLb20xqg8aTwZn3UPDJI7HOkbzeh/gGZIFtjW5W?=
 =?us-ascii?Q?fhP2u4OdUlePM0BX9pU47dekGTB2tooD08DB5nCzCYtqwEBIq3TG+9k0hI3t?=
 =?us-ascii?Q?/6GVdm+eNMdZJ1zJQMNNaDfzHRuOWyjXd9Tjkhk6xYsQkd8bhKcPJZHZSoz1?=
 =?us-ascii?Q?R/zuUlWFe3mSY6ilhk48aOTMj6Q/0x7xQdBYShOjgaAEIZ5D/DJb6ZSCIOOl?=
 =?us-ascii?Q?q1PTk8Af8lQIsB6GnD84aRWOTig/b19Hj2afRjCMRFHLTVh+k9YgKn555JFd?=
 =?us-ascii?Q?oAanT/l03vcytyIg0bsNKkJ7mxqDsH7LugYv4er8OGuhelPLFVk153pOiTDq?=
 =?us-ascii?Q?Fur0O14j5blzI14MzcIpST/RX1acj9/xR2dTR3p++55RPByBRVjtkxu8+FVx?=
 =?us-ascii?Q?pIxjhd15n/Wvj6ktrIzanE6eR4vwkVNiXHHffQjwOdEsXR9LZQK7SVatLtOk?=
 =?us-ascii?Q?lbvDfbr/sKGrmgHzaw2jXB2rKSeQaUkqWHtUlaKhCHvmYT5Huvnof6W6j1Vb?=
 =?us-ascii?Q?SFF7E7D3nX+pCCalFF2ofK3BKr6mMP+hAPwqq6JY++Oo0nLg8ZFFCdpzJ9k3?=
 =?us-ascii?Q?28P6P1rBFTYfc5Tgr9WKU+0l/wHs+7YgFqdXIydPEnV9UbF18qyMm7T7xRNB?=
 =?us-ascii?Q?R2XhZpHocU/M8MTLzDLSG7Fw26ei1kD/DssD+Me2VdUEuLusMxse4hJ8qc7M?=
 =?us-ascii?Q?26HJLYVTV9Uzb2KbbBJ+BDRd+K8z2Xxl5TH5uNcZRJZlY0LzerDS8Cof97V9?=
 =?us-ascii?Q?kyqDcqoKIgvldiAWb9L6qeUGLrTlqDI6/G4T1pHP9TOa8i8ZDcBVXb2H+oyG?=
 =?us-ascii?Q?kpwO2Yjfi3ctiaQ3wyqUQlN00RtPADTwpO+EDEdlHsubDjyKDkeonev5xbNl?=
 =?us-ascii?Q?l8kRs7CwfFNdM+IoiO4xsaoCe9NaceQXB0eqq4hmMK6b+wqtA7jsStEh/Nnx?=
 =?us-ascii?Q?WR3oF1m5lQAsSju7bUe57uEcQqpK3CbeUjVU34i4zNP7LtaTr1t+6XEAFwiw?=
 =?us-ascii?Q?WVsMkTQpEcW13rT0CgSdtykBPlkzlUUbtcfODwM35gEVtrwA8AtLXPjvvL7G?=
 =?us-ascii?Q?N067PFGwnOnG630sPM3tF5GvsPfbQblLOsypAaeuwMCM3AirM5YLEGaI3YI/?=
 =?us-ascii?Q?f+NecbiYefPHxWQBKIqvK6XvTsqn4KuG9ePdSkFiVNoTVBaEbSf58xFb67VT?=
 =?us-ascii?Q?03ii7ta9sT398gbaXV+uY1kgh92zLC/e?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 17:12:20.6270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8183a8-b73a-4ee6-b7b2-08dca03a4b12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8144
Received-SPF: softfail client-ip=2a01:111:f403:2407::619;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Tue, Jul 09, 2024 at 11:20:16AM +0200, Eric Auger wrote:
> On 6/26/24 02:28, Nicolin Chen wrote:
> > Nested SMMUv3 feature requires the support/presence of host-level SMMUv3
> > instance(s). Add a helper to read the sysfs for the number of instances.
> > Log them in a vms list using a new struct VirtNestedSmmu.
> >
> > This will be used by a following patch to assign a passthrough device to
> > corresponding nested SMMUv3 instance.

> Laterly the HostIOMMUDevice has been introduced to allow, among other
> things, to pass information related to the physical IOMMU to the virtual
> IOMMU.
> I guess it would be well fitted to associate the viommu with its
> underlying piommu.

Wow, I missed that part -- backends/host_iommu_device. I will
see how I can fit these well with that.

> I don't think we have such kind of host introspection in machine type.
> Generally in can happen in the very device or in libvirt.

I think the biggest reason for having such an introspection in
the virt code is because of hotplug, (though it's not properly
implemented yet), as we don't know what new devices requiring
for nested translation would be joining later. So somebody has
to hold a full list.

Would you mind elaborating how the "device" or "libvirt" can
handle that?

Thanks!
Nicolin

