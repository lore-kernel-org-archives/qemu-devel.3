Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD42CF885D
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 20:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMBdL-0001gJ-Ol; Thu, 20 Nov 2025 15:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMBdJ-0001ff-88; Thu, 20 Nov 2025 15:52:01 -0500
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1vMBdH-0001IJ-OH; Thu, 20 Nov 2025 15:52:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oE6JFwKsllQSCH87dbaonwo1DO/U5zsB6Ng2wf0jhoY9jZUjxP3jgUh4Mb8u6ib9tPFNGuX7zgYt3oj3yl7h6ZqTTjnAXm47sHFzrSmCxIyIz5ILZB5mVDOvEZzGz9a/Ge88syMOAC9Jdvm8LDpWre+FsPub5FUKwewmYaW+6vWajP1pMPECl+nAsfALhCR7yWGB3hwYPu1n1Bp1lbDoZ0su6ObXm4LlUn1bXwml+SoDkhVybfLQ5Q4W6H724IcUx2FhogWgXndlfGgF3dpv9lXxFBxlVcQaeu8B+AoMao7puNB3CAJu6sgROllgJA+jAd1r7FmUpivCBs0G5F3Daw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rO2p8IUUdLpdJIRhx7fVc1Gwx+JuNEYtMwXCa+VZ3kk=;
 b=lhqbMWkBqxeS6eEj3N9kHVNjrsNXoMmmWOhe60K+sa9YhshdNghSk6QcyUMRwlwReZS2tPp7eMGTIoErhbhyJas7ycMrMYP+Wp16SudX5OqGjo2gPgs5N1hbVfKUyZeARRfBuDZOZPjexqTn5ycN0k/dMTt7c2MbhTLK23Caa90c0c0GvQ2NkwflxeKH7Y8FuIpZaEcDbVg/wbmbyaDTzvpwabcsscDPZsccgEfYp82s5kz92lirT2eB1pturk8osv2oWVsCIW24/FY3W4kxsCwpdPXh0vQVZyDlOvvrXJrmYCRGWC2VV08Zim9qzRTSM5jtypTtD57dhfdgyhSGIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO2p8IUUdLpdJIRhx7fVc1Gwx+JuNEYtMwXCa+VZ3kk=;
 b=kLgB8ElWa0JEmVf4o4E2xqEQqe80J7zymRNzYULBSvw7VPDwxHZIsM6zmFVumjRgNTV8Ja/I4h651lgvh9tn2Nm9XXopbDsQKIA2cniWmCyT74yl/92qjYwzGsPXbtJCvfEin6VbppVGGMMc+fkbi5SNWQKt0a4ZiJ8nDVjkHtXALPOIWYL4UhhT4tTuP4YBOy9LdkJedO7NpZlAzFetDCzBHjBT2PWvqHO/gtqldhdgdeaP9uKwJ+oeaLo7l9CjF41b0glkEr/KZrvL6K0nVETrxE8YjdOQysIb7xx68ll99dZsnNAcC8VWApZP0RA+YFnKlmVWKiFUFJmA9ebQug==
Received: from DM6PR04CA0030.namprd04.prod.outlook.com (2603:10b6:5:334::35)
 by IA0PR12MB8896.namprd12.prod.outlook.com (2603:10b6:208:493::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 20:51:46 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::6f) by DM6PR04CA0030.outlook.office365.com
 (2603:10b6:5:334::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 20:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 20:51:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 12:51:23 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 12:51:23 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 20 Nov 2025 12:51:21 -0800
Date: Thu, 20 Nov 2025 12:51:20 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v6 08/33] hw/pci/pci: Add optional
 supports_address_space() callback
Message-ID: <aR9/SMia+iganQ2r@Asurada-Nvidia>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-9-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251120132213.56581-9-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|IA0PR12MB8896:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7a32c7-2d5b-4e04-3ec1-08de28769e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yX/++SzPZOa4wpBCiGOw8ij0AVBm3F1qhTrKuqJya+1XFE8a93iUJSamggMU?=
 =?us-ascii?Q?Ynp5DNRHEAwu5M+KBgB/12Mw5ivMJlzLzQ2mRYM7Tgs582BM5LMV0CxXTIg2?=
 =?us-ascii?Q?pRGZlrBz2ZtzYFlQMlhoXXQ5V6gREfgwcfV8awbN89ZnUjmptBNzsOUxoIwy?=
 =?us-ascii?Q?UPwvID188zKR2KWZAlrKe24RPkS3cdGICIlQaqba+03SYx2bwC/gjUZkGlfd?=
 =?us-ascii?Q?PIJ/ovK2khVM8Vxgp4UKqeo00UedBsla9BUv7J5P3hnG1pybfxtDJGeJntEr?=
 =?us-ascii?Q?kvpMjekxc9walv2+Uj2XCo6Il6ujy9rih+6l7oJqbNYatOEJtuDI7Yd69voN?=
 =?us-ascii?Q?WBWZBzIeFkiHd1+x8oy5ftyvG/hUxx336kBZwNDttozcNKB2r4RE+sjfhs1n?=
 =?us-ascii?Q?upk7FN+fuNxpHgcumAcNv7BR0EfECIQOoQoEBaUrG2p4EsPQgbxVd+ZBu0w7?=
 =?us-ascii?Q?InwvboqsWAkaxEeygpWyQx8TMjK5/1cV9O85CFPf8OcMJJ3UxthjDhu/YcwP?=
 =?us-ascii?Q?oXs4h+2D2gZFYghy8X+PdFU/PqVdrJGpEFXdy0EAOgwN114uhFB0F64mxfln?=
 =?us-ascii?Q?GEUKdNCfVXXKEQiU1JV5edCXbDA+HNG/gCniSi5+03WfBZ+y11vSC7hMTmRq?=
 =?us-ascii?Q?jBvKnEI5bClwuMp73f9Mmt2Iowy1vIsVbj+Pz4hSREmjgcpnKCpduRV71IQy?=
 =?us-ascii?Q?C+LbF95cjdCEeETTtK5BVR3cR1/tUq1VQvrwUH1vISygrHo93a9QvIjROyvf?=
 =?us-ascii?Q?haZVSOuIxX4C5+mUbYuYRi8GH6+tz77qY8poGQQGSdq1v2P8KceSF8Jw9Zr5?=
 =?us-ascii?Q?5kUVdATLxL166V7MTm3cXjptHE0pUeFZmoo9FGfPgX1YGrLfVjMBxXC0150y?=
 =?us-ascii?Q?Pp+CFWcWF//51VK313b0kfF0faownXG9LZu08w2YQ9yhqcM6iGtr+hFuCmsC?=
 =?us-ascii?Q?4amnsZ5yGigPfjzHhS4pNZRyFc3SNk/UK/U/CfefYjPpbMBu9GuSStby7Y3T?=
 =?us-ascii?Q?Hyf5ajdHnBwIBVENNNdQ9e0xu3Oxoxj3KEs3fg11ghXq2kRA5YY2fTBch8TP?=
 =?us-ascii?Q?Q0rzM9TgXV9CP9GXpg5yKG1QRAA5i9/3/T30cUyB5LxgPovSql1Mc0P03IcF?=
 =?us-ascii?Q?QVZRa4KJy9uggKkCPHqN1jh7d0dVEO7Mg9U/46ocKeEM2l0KXypzEQJfwtkq?=
 =?us-ascii?Q?1Z9EZ1ZNS5wL8iT448vYebkQOmu2Lo4YjzHB78RqB5MevFadVrOl259jEI5s?=
 =?us-ascii?Q?ipGj0SdymN8C+Y1SQoPmmeqqi66SWK3X8x3oZ1U0aQAlu5Rw+zXmDqaGSGnf?=
 =?us-ascii?Q?LXGIXCx9HIwW9NUJfI5aL3TQT47NfDSJGpkbcqm0u5J3nVcQqhYCzoOYsDcA?=
 =?us-ascii?Q?kaMo9eMo/jehECx3+OGp1ZkCYC1NLrAKJwvvzot7wic1FAefEdrjpr6KRCj6?=
 =?us-ascii?Q?6ixki67YGrwqZ4LUgpDVTnKiffVrgouysvIapuwmq9lbLNapbyFu4KJ173Yg?=
 =?us-ascii?Q?o0GRNR7FYCp0u32BKa1e4QZX0fink1dl7LgNhg8C/UzHr6WttcNAXbPCQ9i9?=
 =?us-ascii?Q?HBQlFTZUlCUyhMnBj9k=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 20:51:45.6461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7a32c7-2d5b-4e04-3ec1-08de28769e2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8896
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=nicolinc@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Thu, Nov 20, 2025 at 01:21:48PM +0000, Shameer Kolothum wrote:
> Introduce an optional supports_address_space() callback in PCIIOMMUOps to

"supports_address_space" sounds a bit to wide to me than its
indication to supporting an IOMMU address space specifically,
since the "system address space" being used in this series is
a legit address space as well.

With that being said, I think we are fine for now, given the
API docs has clarified it. If someone shares the same concern,
we can rename it later.

> allow a vIOMMU implementation to reject devices that should not be attached
> to it.
> 
> Currently, get_address_space() is the first and mandatory callback into the
> vIOMMU layer, which always returns an address space. For certain setups, such
> as hardware accelerated vIOMMUs (e.g. ARM SMMUv3 with accel=on), attaching
> emulated endpoint devices is undesirable as it may impact the behavior or
> performance of VFIO passthrough devices, for example, by triggering
> unnecessary invalidations on the host IOMMU.
> 
> The new callback allows a vIOMMU to check and reject unsupported devices
> early during PCI device registration.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

