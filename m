Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE6FC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEew-0001j6-P5; Tue, 08 Jul 2025 16:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZDYE-0006O6-VR; Tue, 08 Jul 2025 15:00:35 -0400
Received: from mail-dm6nam10on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2413::614]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1uZDXq-0002L2-VA; Tue, 08 Jul 2025 15:00:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mv3jABKNBscmzidfu4FEeWcsukGNI44QciQP2tFiN4FM2fvhAbutdyC8zrY8O8rUabTS6u1QlEd/EZZNyutbYxFUWwDeltxG6AMkL80NV7owrsyhu1PgsTJe9f+wE7zeTil9XNrMcQyZ/to/tSJ+zeZO1SdveaR0CoBYtA/aX26AWAQSvnQ5t7djmjNkBY7mhoe50JwsDMbqVBzBSq+ZsNxfeceoaK34pIIZNAdF47LTTlwXibbruDXorgWwpjoEY5qwmJfRTsIoOzimQpDxGANId0aWttq5aIBgPmEvUIb1KQ15Dyjsez6ulJpZ6CVbkvNu77YqNArNUHJuJwX0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVKn1ohe/NAQiif3A2aqvirPGBrtwDFBoVIUSiBuPQE=;
 b=dP5G0Z6oRrCrBPxvoRAR5PThAaJZqcZoOhQD/NirRia7W99P/XxhDmcwxjGWjKyH+xgM2MUNXq1fQBqmcgmYrB9l+rQS3no2bw+mQItbMJCj2ZBp6C7jy5UfkK2zdvIZb7Bq8/eQp9PwKEK3PTpdmeOV8e8klv9eM7uQYcCdiBgMxR1W6e/62FJuNJb1PgH5rIRPndfiEnd+JukekPm9vJsWCGhXVauNQEAnLZqVW3m2h9OU79b1vAGdAWIryT5FPhKjoVV12Rm69z09U/9C+MD5iDXxhikUgotyApvh5RO6H3LnZqWCRxzu8e3HgbmE/YeDnygdiyTN4JAVcDhMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVKn1ohe/NAQiif3A2aqvirPGBrtwDFBoVIUSiBuPQE=;
 b=FRAhg69YnqU+1i6P13LKLRenI3wtIXQsZRodHBNcvueJ4uhxRQz3ToDVllm40V99BcT4V3xAvLjG0KAfFeEVAR73javZPuOuk0w2TTGdWcbVSWLNrbm6A3hskaOlESljs30JjMsUHoNpVhozgsLzs1VTOKY/KmdPZWVanFknDgDnU/0xv+qZf857mHFS7yfgQVPclpZtiNHQmAyP9eU+UuCYxOacUbnaQMERpo5BVmQ/rrZGVW9ZWL+wVnryl5ozWjZ3mwli7lkmXL8+wojFZ8p8trXPRHgVxiFr7gxuTSqkcDDokgIvsRAnGnDEnwRZQvP2+UL5K/dgt1B5+rGm9Q==
Received: from DM6PR12CA0010.namprd12.prod.outlook.com (2603:10b6:5:1c0::23)
 by LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 07:58:07 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::26) by DM6PR12CA0010.outlook.office365.com
 (2603:10b6:5:1c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 07:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 07:58:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 00:57:55 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 00:57:55 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 00:57:54 -0700
Date: Tue, 8 Jul 2025 00:57:53 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <imammedo@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <gustavo.romero@linaro.org>,
 <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v6 00/12] hw/arm/virt: Add support for user creatable
 SMMUv3 device
Message-ID: <aGzPgZEhORuRyIdl@Asurada-Nvidia>
References: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|LV8PR12MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4ab9f8-de04-48ce-1cf1-08ddbdf52b87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iXDRplloZTFD1elPJWyKasBr0bPe+znhkZUo9snveLPYP4xLyi1hzhDS0UIv?=
 =?us-ascii?Q?EXcfov2nMyRi3kFU8gamT4A1NwRfv9rrikuTbyQllseytaVV9NY4PpaKnuFZ?=
 =?us-ascii?Q?ch5Rj89gAvBrKh5YBJWH/nxUp01F2znpuEmI5ECQddkOW8Pf/g7TfItBbQlq?=
 =?us-ascii?Q?N/tVqdTsy7Z18mkEC6ngAkjsZACX1QS/E23n0nNv4oEHoc6LF2k03QjXpBCT?=
 =?us-ascii?Q?WCDqwux4Rpfuvn5V1HwCUbJOlVJwoYAXeDQWoKuEkavcFiezSJZb+QXawLww?=
 =?us-ascii?Q?gOCciUQfdGeb+GxZsqXFXzUDgahe6sdyn+hA4ssloSItkAul3KJxCynu6Dr1?=
 =?us-ascii?Q?vcUUot2VSVeNoq2+JP/yAfpfWZnS1s4IBONnPZJHV2oS/Dq6JEGIvg2ysyel?=
 =?us-ascii?Q?2U7UMN2gYHq8L3pE7Eg/9v1HAgjfx5eHEFSnYqcr8ym6jJnQ3hStR1EHX4Ok?=
 =?us-ascii?Q?oaMXhq8Eso5Gh9NuC/cqVHG9gr9mX6sZ/vladrJaVR3JMVnjux/7YDDPl5LH?=
 =?us-ascii?Q?IvZ+dCYeDKHpxw9vZDYj9QbEGy83+5fm75JnJBq7XPgRD+0FNihh59KUzBfY?=
 =?us-ascii?Q?AdpNVb7JDHRCbkhE7U5KMe+Olmlv8l12xj3nIK50mpCYKHduL7XEl3FoIPDd?=
 =?us-ascii?Q?/U4Ps7+caOOpgAu/9GdrQIrwf1hHKKACm1GiY9x4cxmkhSAXEGvmslDflnXq?=
 =?us-ascii?Q?4SGeybMQRzaocg/6GgTvWn+gKJbDpD3iwvY7q/g/YUe6gMayfnYjTQAUf6Ao?=
 =?us-ascii?Q?gT49wELiQd5KLA7G2+yHLyE9d40+SjXTtXW4EliQDBQJcOJGvhVk8Tw3n4Te?=
 =?us-ascii?Q?ZhKuk7i9psN8kukK6oqfKShrXBt88z1Bl6/NbMnQFUDuCoJeeoRkYrAlfhLk?=
 =?us-ascii?Q?BCEnfIn4S7L2m5dlYYPIGMWy1G1nYuOVK94A5p0bqsn9wZtdlmi/E1N4vKj7?=
 =?us-ascii?Q?Nfb5BGxEiM6+S1kN06oSj9UT8Pi2CsTRogkMDd0n33nk09Ll7mhpFNniJzSd?=
 =?us-ascii?Q?Q4/SO3LuMYzEs2Ug5R+a0414f4BQOUUkf5wguci1sB2aOcjk/r47TfCQkw8u?=
 =?us-ascii?Q?XN2XFvQY77sHZc3Nm6YkcrWUk/JxKCongjTcvy/Me8CqB8fc6oG+CSIGRzwb?=
 =?us-ascii?Q?dKPVPhnu8gzrfDivV5odni/I2zdj/MzOriHtfSQPrMwM8L3SumLh6aYaPE2Q?=
 =?us-ascii?Q?jHADbaEkgYdO4dmEEnm0ThLRkNDm3lCqpGeOk8cVLfsIkjXTX5UiOBdotonr?=
 =?us-ascii?Q?AfnvNza17lbGmqsPpQIgF4eukQncrUtZ3UE7W9GpGT/ZTtOWtJVHulHZhbJb?=
 =?us-ascii?Q?AYUMYaEwhifHJfl+qGJ8IHHxFqIbpKvuyHYvote6U9sU0KO5Y7OM7IzRSith?=
 =?us-ascii?Q?vJJ9BCNKpRyZzcguWBGGEwivxG1qCIICKCxNuL5uhYlG69d+4RHYCFiD7Vsj?=
 =?us-ascii?Q?sdjeSTCIASPv7BPGrAzOsteeEHskJzE06suwLJf3bQQC1uFikd7P5EhEoAAz?=
 =?us-ascii?Q?ypU/Csbwf5KJ8qvnJsW3JVzx4W6cRPKgsKsV?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 07:58:05.0046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4ab9f8-de04-48ce-1cf1-08ddbdf52b87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9134
Received-SPF: permerror client-ip=2a01:111:f403:2413::614;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

On Thu, Jul 03, 2025 at 09:46:31AM +0100, Shameer Kolothum wrote:
> 1. Rebased to target-arm.next and resolved conflicts with the series 
>    [PATCH-for-10.1 v6 0/9] hw/arm: GIC 'its=off'.
> 2. While at it, noticed an issue with RC id mappings creation
>    and patch #1 is a fix for that.
> 3. Patches 3 and 4 have changes because of the conflict resolution with the
>    above series. I have retained the R-by tags, but encourage all to take
>    another look in case I missed anything.
> 4. Collected R-by and T-by tags. Thanks!.

Hi Shameer,

Thank you for the effort and the work here.

A separate topic: do you have any preparation for the vIOMMU uAPI
patches (iommufd backends) in QEMU?

I think it should be the next step after this series, so I wonder
if you have done some worked already to test this series.

And maybe I can start that review process in parallel, or we will
have to wait for the vSMMU code.

Thanks
Nicolin

