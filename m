Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE1DC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 19:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txWt8-0003SQ-6t; Wed, 26 Mar 2025 15:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1txWt5-0003Rb-Uu; Wed, 26 Mar 2025 15:58:07 -0400
Received: from mail-dm6nam12on20607.outbound.protection.outlook.com
 ([2a01:111:f403:2417::607]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1txWt3-0008Gv-RD; Wed, 26 Mar 2025 15:58:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqJ8jigw4roRhWZULlmQVGO3T9XSgl9KH/TQOAkG4c3FwjzmOqfFW3+AzpmrZCoftHtOWZSQp0aDYFg6erDuiOQLcPpWJvrpOQG+mEew7AiiQubiXV7G6wYzqdZyQCglnBKJsghUMK87eGtahWwfUm8crfmq5f9c8FPk83DwidLZF0t446dAQz/miBg+0wzhr/k0BnbT6h+FPh8ETDnVRZztYmJak6T1fA/DbCMpGHzApcNKQ1kK+4637Rq/7qxXDPMekmUuhZ5nXF5kAK4HoZlb/K8AHWLp2C5MmgLYCuJEDSePX5rPR8Xlt1KVpgF6HCMPXxAAQGR9a++DckHIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTjxFRhawfHN1vOzK00eN43L0bUN1hECPslruB0kcs0=;
 b=FhGJsKmXMvn3ijvfayQKeyHQc3pPUUtClrNaXu5+MWsVMOJR+iBEfw1qXwJ3UKTCRU4v+h3KOryD5q60ewf3A9qysBfnKxtP9PEJ7D+f/oMMCNxSkwvaFItrm6dIbSVaTZfYrnRan+bqV0OVwihzN/0j2qK83N0JQ/gNTwkRuGHcPnQYfRTWynPuPYjzzUCYC3kdpscVx6PqMd5BrcodzXt0hxmftdAXQM43gjb2swJXKlnqB0T+x+fPYQQLHKrngjC+Z0PMIGaZV3dztWeOk+LNbv9aBAMcZveXtRu244NZYTfzkjLc45LpGr88zV7TYqlhQmHMvd6JOhOQAFkbyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTjxFRhawfHN1vOzK00eN43L0bUN1hECPslruB0kcs0=;
 b=hNbu6MycdNABCVkMI/d1fDVaevTQDmbhNl4VJU6X8qTjgsQXcvVGBwK6vhyhsYGdpAAozT8xnIn1FlNYV6GDQK6sjSeTsyHuVW7CMOysO+YVi9d9eKvgmq/2GTuZdO05Y//jyrn9L3sVeHS3iMmFiV1U4rzaxR+1zhXHeIspGVi7cdW4rga+67Ul+XcMHJwXD7/UqObk3v0Db2s9YkdEzJJqw6PocZUgGu4GMITmGuXp3uxCgyDFlfDMU5NhSUDAwFbLXEDe7gIfL5k8+/4TekjvazoFDicwvT3I25jfiiA8Uj9G0JeOaNQfUigouWwH9b9evlQNDasnUmEQpXeOhA==
Received: from MW3PR06CA0013.namprd06.prod.outlook.com (2603:10b6:303:2a::18)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:57:59 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::1b) by MW3PR06CA0013.outlook.office365.com
 (2603:10b6:303:2a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 19:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:57:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Mar
 2025 12:57:41 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Mar
 2025 12:57:41 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Mar 2025 12:57:38 -0700
Date: Wed, 26 Mar 2025 12:57:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <jgg@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 18/20] hw/arm/smmu-common: Bypass emulated IOTLB
 for a accel SMMUv3
Message-ID: <Z+RcL7qcRHRqT8CI@nvidia.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-19-shameerali.kolothum.thodi@huawei.com>
 <4a6103cd-a007-4cb2-bd3b-1bc39c0ecd9e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4a6103cd-a007-4cb2-bd3b-1bc39c0ecd9e@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 88951504-3eef-4bb5-07be-08dd6ca080e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bO2st4tmTkTbPSnN8C9NX5w5qCBHgTBjMf8M06F3qxC9xMwSdocaRaZwTKWe?=
 =?us-ascii?Q?VGoDxtRwghdQDS9Os8Du8Wpzk48rP9gv29ufzFjgFmxv7Zxe0FTDXY8s+7bV?=
 =?us-ascii?Q?N4M2mG5Pfgh8JsmVjZWisfH/vwFrpUAW+h9ASzWFURpjaUortKXzM4j4TqxR?=
 =?us-ascii?Q?TD5lu2Wudxs5zRUDnL9r7o5J9DtuZIMYikmGSf2kIOpCDc7HrJj5mBHy/E40?=
 =?us-ascii?Q?dwjmzKDiduAQTlcZzPxHXM8gEvHcDQBdpzORIpBA5+Dg4Z+rrtyYa0HKfuyq?=
 =?us-ascii?Q?YJ03mm7hHVzmvu+B6RzlX3PthHNwGVafS8mn08cbzAsvIANY4/k897+8IVv2?=
 =?us-ascii?Q?X+ComSvyQdWBFaOkFtaeXaNFh8xX47iqBFr88k6M7LJYC7QuQo/ZZMnf6bSg?=
 =?us-ascii?Q?8PxJahJkaPKPRQq/lpHefJAP4a0VpJjNyUaIgDmrG7kLukNVaS7Gxkl5hVze?=
 =?us-ascii?Q?KgogG3NbUtYOf0sXe44eq7WqbJRF4a37HeRBv0ZjfS5gvEFlbBYyet9SEQEj?=
 =?us-ascii?Q?ruuP4wSNgj/CW1rN0sjdordqhQAUNjyhFd9aQOIKmKJ+KO/SP572zdsjRThT?=
 =?us-ascii?Q?N9UGuI9npQ22o0/BNJu75MmUf77GqRBJBr9Um7J8WOZBa3f6mEHG4Nw9GxMv?=
 =?us-ascii?Q?vk8I76oSlZixQWDEwoS615dEoANr9Le8K/zvPNa6wLTl0OHWOhMlThZ8gY6i?=
 =?us-ascii?Q?NP/zRdKqo7E8mCHFZYm4msYar83iZC3yWp4RjXJyPM8FtxgnebU0dkRdw/eX?=
 =?us-ascii?Q?lNntj6YnnL5Tr6gLTR1fRbT6goJK5zCVwveCqEJ3FTbxhQgDr5wMN3nFK4It?=
 =?us-ascii?Q?DvWiNwu7OoORLix9l5JjZK+Nq1TLwgnunSR/24RxuJVWdwHnWiX+xS1LIQYE?=
 =?us-ascii?Q?GVC1A52LnAbNjKu5bLAve6bLMkWxilh57mtF+V4Cd+aYIKSKM2o/GDQcwMSK?=
 =?us-ascii?Q?+T+/8+5HrKd/vbcpqGaPkHIh8HhnOnO7vj5wehetSs3lPR1HSNQwSMD7R4E9?=
 =?us-ascii?Q?cIrrCsREbFqWBg95iD6JkGao/RNtpbjAj+NcBC6XY4irWMU8pQjHmdKZ5g7v?=
 =?us-ascii?Q?bfk3h7/hf+6QOTgigbYWfg8BFunyBuieKyPk+NDAamcTSzJDI+XwH/d7zg6Z?=
 =?us-ascii?Q?Lrlc2mYhikLrszsbMXaOJAUpyJZB1xWnv/gpf1TOVcCTqb+wC6dE3O6Zj1Ej?=
 =?us-ascii?Q?1YhBvF+3DiZalt96RCqi2ZCf2mo5TvoBceqld3kVqCiwE8wkrU0+8lLcvwpK?=
 =?us-ascii?Q?mC5BNaXYCxubfJCeLoln8gpKPnAaBZ+Rl3bgymEfrVCO60GxOQnwyilCs0NJ?=
 =?us-ascii?Q?FFwtD68iflbXz2JrmUlRCAKMirjRDQ7wLDlgIANIF+sIwy1f1+7iC0ZENcJL?=
 =?us-ascii?Q?2vsU/ay0CgUgaZcOxq2/oxtjMlse6wcMTm5QNVSgglHHk26q9TOAIZNjtmZZ?=
 =?us-ascii?Q?xpFKUWO428NON4EUXb0y47/K7r6flUpcUvBIK42HJZbIgRMEdS4/F8djwklS?=
 =?us-ascii?Q?TJ/iuePTiIShqvg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:57:56.8001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88951504-3eef-4bb5-07be-08dd6ca080e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351
Received-SPF: permerror client-ip=2a01:111:f403:2417::607;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

On Wed, Mar 26, 2025 at 06:40:10PM +0100, Eric Auger wrote:
> On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> >
> > If a vSMMU is configured as a accelerated one, HW IOTLB will be used
> > and all cache invalidation should be done to the HW IOTLB too, v.s.
> > the emulated iotlb. In this case, an iommu notifier isn't registered,
> > as the devices behind a SMMUv3-accel would stay in the system address
> > space for stage-2 mappings.
> >
> > However, the KVM code still requests an iommu address space to translate
> > an MSI doorbell gIOVA via get_msi_address_space() and translate().
> In case we you flat MSI mapping, can't we get rid about that problematic?
> 
> Sorry but I don't really understand the problematic here. Please can
> elaborate?

With RMR, the HW is doing flat mapping for stage-1, but the guest
isn't doing a 1:1 mapping.

The guest maps a gIOVA to the IPA of vITS page (IIRC, 0x8090000),
meanwhile the PCI HW is programmed with the RMR IOVA (0x8000000).

The translation part works well with the flat mapping alone, while
the vIRQ injection part (done by KVM) has to update the vITS page.

The details are in kvm_arch_fixup_msi_route() that uses the iommu
address space to translate the gIOVA (being programmed to the guest
level PCI) to the IPA of the vITS page.

Thanks
Nicolin

