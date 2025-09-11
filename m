Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97E0CA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 07:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwbPv-0004Hn-49; Thu, 11 Sep 2025 03:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uwbPs-0004HP-MX; Thu, 11 Sep 2025 03:08:24 -0400
Received: from mail-mw2nam04on20605.outbound.protection.outlook.com
 ([2a01:111:f403:240a::605]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uwbPq-0007Iy-47; Thu, 11 Sep 2025 03:08:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0JD1pnH4osgeg8Cawcu2E+lDsraYCUxXMDVjoN6nQ5+zf7+00NUabD85+sX3TwKws3aQeuF1GBG0/xd+O9C83Zsk1Kmkqi+shpsbwD/1fqZk84DTaESdD38YcVpd1FQfQRLQXJNt2zBnwCzsO/b2i9YFgM+TY3rn++rv0YlqhgMBjxyeBYtS3cY17u6K1byxhOwhzcYlNGmORXr246p1ZInKFT6p5U/Q4BnkzNyeXbbqRCw5+RmXejdwwuAeWZjYfjSkFAwZ3RiRkCIANk5uBIVtfuvAXSdSXCvyM9yuYJkEgC75q3/yDdhwX8PGyjqDVk+5O4o8bci/bMtNNJBEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpBc5GIHlCQw7Wty6YKEtgqQELk13edHSD/xLJyTuP8=;
 b=eLyRvPV8mUTLP5/rNnfQR/nWdTaUubvmXfkARwKCT91fUckRA0uyAKelbAtzy1TuxxKV3XwIM30U2jLK7XKIyo6Xn1uFgMvXVhNxk9++aLOdqCUCx0rZByJWBfWzjDorSc/lv8/jEMG/cmv2FNQO5+H6HCPzubGaR7OpHXll/Dr9cV7iur0cAqJJLJMhEilHp1mYeOo+/90piiXFkNRi+lkdSaOiyLYMSlcGqLlexRwm/pGUpFszYeOboMtCm+aWZAxfcRCaksS4OKlJQQQJLKBPw8N20ndj6c2OiaMD0wRlYYoNw/OkFZ0xUNc5G4gWrmL8rthfRtvpHHogllVhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpBc5GIHlCQw7Wty6YKEtgqQELk13edHSD/xLJyTuP8=;
 b=GBt4ovKtRRNoAgMAiY09wweX2D7AdkpVU2lKYRR7hdjtNswGj5ik6m2hf++PCBKkDdikzkuAz8o9GdwyY48BwxXq+2gaFbf/giOMXhw5pN6QALiS2nlnVnlVn/ytrUBfS96PuhKI0IBry87BnDDlBJqQIurRx2nyKTtsOEWQFB0=
Received: from SJ0PR05CA0085.namprd05.prod.outlook.com (2603:10b6:a03:332::30)
 by IA0PR12MB8893.namprd12.prod.outlook.com (2603:10b6:208:484::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 07:08:15 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::c5) by SJ0PR05CA0085.outlook.office365.com
 (2603:10b6:a03:332::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.6 via Frontend Transport; Thu,
 11 Sep 2025 07:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 07:08:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 00:08:13 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 00:08:13 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Sep 2025 00:08:11 -0700
Date: Thu, 11 Sep 2025 09:08:10 +0200
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Francisco Iglesias
 <francisco.iglesias@amd.com>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v4 00/47] AMD Versal Gen 2 support
Message-ID: <aMJ1WpiNOuLR62t9@XFR-LUMICHEL-L2.amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|IA0PR12MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 207c7940-a802-47a7-bd6c-08ddf101f9b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aTDIEvsfA/n3WuZyksNfT+VvAi3KcakqzaWoDJCV/wIYsEMx5t87XxDIReA8?=
 =?us-ascii?Q?cYSy89mt9hY4wBy91lRC5hC9BM5LS/kExCICpyKC4LHvK3V+ZK4uZNd9iQ5J?=
 =?us-ascii?Q?SjrmNvJm7RlZZylfMPmXVxoYYI9ohtjfhb3MpZB4hYEztQUnIsQnnYcSMbWc?=
 =?us-ascii?Q?GPvTuy/eFxQmtGeds7sp4epTnJoWUWqw3WDV4djL3ZOXtGcQ2aBsINeLpy4V?=
 =?us-ascii?Q?ycE1bGRnfmJ2O66+tmztjhQ3u/3CZO9ETWSsq01q5CEKULuE2DmgGk/UvA+L?=
 =?us-ascii?Q?8vjhnPhhvQUrNbJQBCHMW/uZ8SB/YLiKyeQZuaKWAZZQubfeT6KubHZWm18s?=
 =?us-ascii?Q?jr4D4s5nIVH++6JlFqv37YbO/ALyxK2mGzgpVYaQeoeahgF35hJdsLpSRpwU?=
 =?us-ascii?Q?hZ2+yEGvtq58E0+u7+Qe+1KY3W549FHhP8Qvg/8nBS5SR65gBX2l18tX8RZ0?=
 =?us-ascii?Q?q1TFJRxVawhEV2EKjCsWvr89iDS5m4Cx/RCKEjd58zQ/K8wzICAOvdjm3m5r?=
 =?us-ascii?Q?pX0vRCRfIoMr453U25IldX7ZiK3V3ncUxp4jQJoZ/8Eby9ieGlrFB4OMBiH7?=
 =?us-ascii?Q?03yveR1TGd4lsYtodYJh89It+PXVQluQmgLgaZwXLQuo6V0eBmZq1sxmwpUY?=
 =?us-ascii?Q?tefIU//7ycZ9UQRfUg1Qg11xCABePnZEJUKfxUR/zvq9kTHYsRK0HHdrw5wL?=
 =?us-ascii?Q?pjr1i8vZRLQYKWoWGS1GBLC03INqOJTlTgORzELsN9gGIKM4ej79FnoUjnTy?=
 =?us-ascii?Q?y44pwfz7P63pNHT49Itr0aDCXB9ZBJs+mnKUGfwbMbMq2QgRNcUY/hD9Wcil?=
 =?us-ascii?Q?uiffyDU3y3RYSN3+ntTI/VKyXUUJld5qXtYS+VNqrzLcJ0BAQGmvXJB2+7mY?=
 =?us-ascii?Q?pmsQguQqTLRBfnfIUOcEK8wpttbQfuOrzHlAh8u095qWFyHVwaQPLhV8YBVc?=
 =?us-ascii?Q?Cu/MGL5qzYcpyjOvT/LET6Co64H/NeQF2n8QzWidhrkWCN+sz7Lp756JJA0j?=
 =?us-ascii?Q?CDsg5pUypcVnu11Jh3f09GJgK1+msGiEVvy4fHNP97I79H9+VeCBu302n0Hb?=
 =?us-ascii?Q?Rof/DmrtEtY8HI7wZk1DWtVlw5fJB+wcfxrX73ZwwbVGNhWB6WfrtMZjAPIs?=
 =?us-ascii?Q?BT/+nx+DpbdUrvJd+Rn4lKElHpAhUD7j/s4gmppJu4wCYOFzVIcA+eTqNn7L?=
 =?us-ascii?Q?JmcsX7lopS4/fJXs22rJz5v7x8UbLHYn8lynqVla2K3QZAf9rktC8qj+d66X?=
 =?us-ascii?Q?hDwLV4ozhATyqegBaCRkAq7LzKVeHy8FaOADSKnEHoNT16vKIUwOgQH3CTge?=
 =?us-ascii?Q?4om04AnaS6VBbc+o6WhpABn9OCFNQz7wgd+QhW1XTFcJhn2zti4cHXpagsGW?=
 =?us-ascii?Q?jiK/qWnqYZE0GtmJ8a1rpVZaTP4Eyr/9D4kytCR4Dxa69jJhP3bYavhj+g7s?=
 =?us-ascii?Q?B+vtC/3LJH+QfXGWuyfRSpzr0kSHVNdzESQKBHZJJcHXzFt5fcCqYail6QQ1?=
 =?us-ascii?Q?1zmQfAa8WKkFTZpgEZSujlFfwBsVmlgDqDS2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 07:08:14.2100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 207c7940-a802-47a7-bd6c-08ddf101f9b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8893
Received-SPF: permerror client-ip=2a01:111:f403:240a::605;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

Gentle ping. Only patches 23 and 39 need review.

Thanks

-- 
Luc

On 17:15 Fri 22 Aug     , Luc Michel wrote:
> v4:
>   - Fixed compilation issues and runtime crashes in 3 intermediate
>     patches. [Edgar]
>   - Introduced a small hack to keep the GEM FDT node order as it was
>     before. This is to avoid kernel iface name swapping (eth0 <-> eth1)
>     in Versal. [Edgar]
> 
> v3:
>   - Dropped qemu_get_cpu() usage in the machine code. Added an getter on
>     the SoC interface to retrieve the boot CPU instead. [Phil]
>   - Cleaned the mp_affinity logic. Drop the mask attribute and assume
>     it's always 0xff (the Affx fields in MPIDR are 8 bits long). Use the
>     ARM_AFFx_SHIFT constant instead of hardcoded values in .mp_affinity
>     description. [Phil]
>   - Avocado test renaming in patch 41 instead of 47. [Phil]
>   - Documentation tweak. [Phil]
> 
> v2:
>   - Addressed formatting/typo issues [Francisco]
>   - Patch 23: GICv3 first-cpu-idx: addressed the KVM case by bailing
>     out if not 0 at realize. I chose this path as I don't have a clear
>     view of what it means to implement that for KVM. It seems to make
>     sense anyway as this property is meant to be used for modeling of
>     non-SMP systems. [Peter]
>   - Patch 39: added a comment to clarify cortex-a78ae != cortex-a78 [Peter]
> 
> Hello,
> 
> This series brings support for the AMD Versal Gen 2 (versal2) SoC in
> QEMU. This SoC is the next iteration of the existing Versal SoC.
> 
> It is organized as follows:
>   - The first and biggest part of the series performs refactoring of the
>     existing versal SoC implementation. This consists in:
>        - splitting existing device types into base/concrete classes,
>        - moving from an in-place to dynamic device creation approach in
>          the SoC code for flexibility,
>        - describing the SoC using a new structure called VersalMap,
>        - moving the DTB creation logic in the SoC code itself alongside
>          device creation.
>     Patches are split such that each device is individually converted to
>     use this new approach. Behaviour changes are minimal and are
>     emphasised in the commit messages. This gets the SoC code ready for
>     versal2 addition and leverage the fact that Versal family SoCs are
>     quite similar in term of architecture.
> 
>   - versal2 SoC support is then added by adding the corresponding
>     VersalMap description. This allows to reuse the existing code
>     without duplication and almost no special case.
> 
>   - The amd-versal2-virt machine is finally added, following the same
>     idea as amd-versal-virt. The documentation and tests are updated
>     accordingly.
> 
> Note that the xlnx-versal-virt machine is renamed amd-versal-virt to
> follow current branding guidelines and stay coherent with the new
> amd-versal2-virt machine. The xlnx-versal-virt name is kept as an alias
> to amd-versal-virt for command line backward compatibility.
> 
> Thanks
> 
> Luc
> 
> Francisco Iglesias (1):
>   hw/intc/arm_gicv3: Introduce a 'first-cpu-index' property
> 
> Luc Michel (46):
>   hw/arm/xlnx-versal: split the xlnx-versal type
>   hw/arm/xlnx-versal: prepare for FDT creation
>   hw/arm/xlnx-versal: uart: refactor creation
>   hw/arm/xlnx-versal: canfd: refactor creation
>   hw/arm/xlnx-versal: sdhci: refactor creation
>   hw/arm/xlnx-versal: gem: refactor creation
>   hw/arm/xlnx-versal: adma: refactor creation
>   hw/arm/xlnx-versal: xram: refactor creation
>   hw/arm/xlnx-versal: usb: refactor creation
>   hw/arm/xlnx-versal: efuse: refactor creation
>   hw/arm/xlnx-versal: ospi: refactor creation
>   hw/arm/xlnx-versal: VersalMap: add support for OR'ed IRQs
>   hw/arm/xlnx-versal: PMC IOU SCLR: refactor creation
>   hw/arm/xlnx-versal: bbram: refactor creation
>   hw/arm/xlnx-versal: trng: refactor creation
>   hw/arm/xlnx-versal: rtc: refactor creation
>   hw/arm/xlnx-versal: cfu: refactor creation
>   hw/arm/xlnx-versal: crl: refactor creation
>   hw/arm/xlnx-versal-virt: virtio: refactor creation
>   hw/arm/xlnx-versal: refactor CPU cluster creation
>   hw/arm/xlnx-versal: add the mp_affinity property to the CPU mapping
>   hw/arm/xlnx-versal: instantiate the GIC ITS in the APU
>   hw/arm/xlnx-versal: add support for multiple GICs
>   hw/arm/xlnx-versal: add support for GICv2
>   hw/arm/xlnx-versal: rpu: refactor creation
>   hw/arm/xlnx-versal: ocm: refactor creation
>   hw/arm/xlnx-versal: ddr: refactor creation
>   hw/arm/xlnx-versal: add the versal_get_num_cpu accessor
>   hw/misc/xlnx-versal-crl: remove unnecessary include directives
>   hw/misc/xlnx-versal-crl: split into base/concrete classes
>   hw/misc/xlnx-versal-crl: refactor device reset logic
>   hw/arm/xlnx-versal: reconnect the CRL to the other devices
>   hw/arm/xlnx-versal: use hw/arm/bsa.h for timer IRQ indices
>   hw/arm/xlnx-versal: tidy up
>   hw/misc/xlnx-versal-crl: add the versal2 version
>   hw/arm/xlnx-versal: add a per_cluster_gic switch to
>     VersalCpuClusterMap
>   hw/arm/xlnx-versal: add the target field in IRQ descriptor
>   target/arm/tcg/cpu64: add the cortex-a78ae CPU
>   hw/arm/xlnx-versal: add versal2 SoC
>   hw/arm/xlnx-versal-virt: rename the machine to amd-versal-virt
>   hw/arm/xlnx-versal-virt: split into base/concrete classes
>   hw/arm/xlnx-versal-virt: tidy up
>   docs/system/arm/xlnx-versal-virt: update supported devices
>   docs/system/arm/xlnx-versal-virt: add a note about dumpdtb
>   hw/arm/xlnx-versal-virt: add the xlnx-versal2-virt machine
>   tests/functional/test_aarch64_xlnx_versal: test the versal2 machine
> 
>  docs/system/arm/xlnx-versal-virt.rst         |   80 +-
>  include/hw/arm/xlnx-versal-version.h         |   16 +
>  include/hw/arm/xlnx-versal.h                 |  342 +--
>  include/hw/intc/arm_gicv3_common.h           |    1 +
>  include/hw/misc/xlnx-versal-crl.h            |  378 ++-
>  hw/arm/xlnx-versal-virt.c                    |  741 ++----
>  hw/arm/xlnx-versal.c                         | 2465 +++++++++++++-----
>  hw/intc/arm_gicv3_common.c                   |    3 +-
>  hw/intc/arm_gicv3_cpuif.c                    |    2 +-
>  hw/intc/arm_gicv3_kvm.c                      |    6 +
>  hw/misc/xlnx-versal-crl.c                    |  602 ++++-
>  target/arm/tcg/cpu64.c                       |   79 +
>  tests/functional/test_aarch64_xlnx_versal.py |   12 +-
>  13 files changed, 3067 insertions(+), 1660 deletions(-)
>  create mode 100644 include/hw/arm/xlnx-versal-version.h
> 
> -- 
> 2.50.1
> 

-- 

