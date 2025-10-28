Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C53CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlI5-0001yJ-Vt; Tue, 28 Oct 2025 11:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vDlHy-0001tq-62; Tue, 28 Oct 2025 11:07:11 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vDlHo-0007Xe-2A; Tue, 28 Oct 2025 11:07:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ai2B//ijR0XxOQJW64UwH07nO7GsoImpCh52bBoHpgvWwScQvdTsYTF0iwvImhl5qe0unNlUD/efm9iaVM49AjAc5ueKuau5TsNbosWgBhemEMo/8A5go2IFcn+viR5+wHAS4VuIxFREdI1YAGSH51SwE8XfcYWGC8AL15wGh4y+8ISppCd6vdwVCIo2zhJ/loUk4C6/8NY3+xF1K9gLl20WnJs+svmtuUDEywQGG1nsGdjeK7SiXcQHzistuXo4drqnlZnz3Lvt7jF2FJM7AwiCte2M5WoYF1f/xGrLGHP9umRs9zzCfzFVoYvLwG8peeDLpU8LeFIvj5CqXoxhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiunK9Bz35I27vWmG36DVYE5587vq/A3cbN/6y7gmZk=;
 b=WWcfC9QhH3tM8GQW0bhgAvjMiB+424QUwhdl7sP21W7P/fLBMgjVfbBZBIq+T/q9DtiXASSH1SSQ92lgX64rRmm4kU1+GNGX8jTxSScWMmylhQTowb6m6nhvWNJfge6eKMp4AauMfk+Jka067Urxe1sSLUDnJwTWKxcx/VkaX1L5HzjTOOn5GwYhSy3fIpFALcOKAUTc20u94nzcClfhzFOCsAh4WsXHu7um0qbom9RMRx3AWHSrHdegHEVjE/5DA89gn32/goP8xsBOdgbcVO9Epbcu0N0VJsXGNA2Q/eRprZuDK5KQiIN/dplne1M5fmRGyxAp9YFXUHCbV8eY0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiunK9Bz35I27vWmG36DVYE5587vq/A3cbN/6y7gmZk=;
 b=ucGbbPbQV1sqjUqYT/YAd0bFyb08NwgazEG0bHftZnIkwlHucLJ9o0hYZiUl2IZ01U04aXEp/yaII8CbdUeTX6MkccASv089tkcweMqWrthpPZhMdKxyva4gSv4JZjgRNdXsZbkPWXpRTKaZ7ZPAnxKaB0+M45lE1cj/BZcnqlvw4dif4UsD/3gaXgwhxN/4GfDtRDk1DuJcg9h288hohUZPXYkbeY/SUeikcEV8l6T1co0p3JRAwnLsHWhHUIbTGFTNQnq+Jjbm9FDkFsYniLipaBRO0dPls0iQhrtAqtJmu2uJC8eHpNZnHpGjii/YFy1r/qKA9IEIvXXZv0vmZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CY8PR12MB7586.namprd12.prod.outlook.com (2603:10b6:930:99::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:06:37 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 15:06:37 +0000
Date: Tue, 28 Oct 2025 12:06:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, ddutile@redhat.com,
 berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com,
 yi.l.liu@intel.com, shameerkolothum@gmail.com
Subject: Re: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Message-ID: <20251028150635.GL1018328@nvidia.com>
References: <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
 <aP+oRLu/BYNaAPHG@Asurada-Nvidia>
 <25d22f06-69e2-4954-9bd9-f73f899fc114@redhat.com>
 <aP+xhmLCRu6y0eQm@Asurada-Nvidia>
 <20251028121625.GF1018328@nvidia.com>
 <9748e922-057b-4e7c-ad6b-b83f5591290a@redhat.com>
 <20251028134148.GH1018328@nvidia.com>
 <15e0d683-e524-44ed-b253-c6221585d9bd@redhat.com>
 <20251028140340.GI1018328@nvidia.com>
 <30630f4c-0d77-42da-8df9-97e737c5c515@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30630f4c-0d77-42da-8df9-97e737c5c515@redhat.com>
X-ClientProxiedBy: YT4PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::27) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CY8PR12MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: a365f4cd-e482-4b7c-69f0-08de1633973d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?juQ1JBIeWIqGSMi7HQn8FFnZPmVpUDY6D2ZAnCPkfx5R0QF/BVlzDKBlHFG2?=
 =?us-ascii?Q?88mrX8r2QDkvj6ilGkPYHJNiluG6dFG4V7xPjZz2VRQpdPJEUFBa/TC5XMhu?=
 =?us-ascii?Q?lfjasvuKLlORsCW+j5TCQmxPd0DYjDLcZTe0fCnK/08y8wyaSeOvKK0AaPHD?=
 =?us-ascii?Q?N/viD7v+h4eI3jC478+ktM6b3oBpahlnDydTNrybnDhXbv/1UxJ37WMHPJ9m?=
 =?us-ascii?Q?Q18iuO/W9AiiHVQ54BjP02e5eDHB9FE9yU7biI4g9VqaP5JvhThlWTuDtvR4?=
 =?us-ascii?Q?yrtkTCsPSlhXVf3qdxnVpn8Kos+iaO3BMd37RoGvbb2xn5yV4Q5w9LPqjg5g?=
 =?us-ascii?Q?NYvcwqny3ALSso8u65EWCiq538HN6IYwgD5ZIIG5wEKGFbeH1xQUEd9Zbwy5?=
 =?us-ascii?Q?5qAfZ5JV+IQB4QPjUKsFc6EOcToK8juc7Jn0qaP/egCZS8A8fvV5aSqPwdnT?=
 =?us-ascii?Q?nwF+BpvuPRaGTJFGLqoNL0H1k7UuEO7fl971IbWiMNZcvCUd1VwCuJdpiSZK?=
 =?us-ascii?Q?GNYmTnRzualUT45bzEMwWeOCpIqj2ChCKkSl43ZxqxZCVS4CNmeo/2cLkk+j?=
 =?us-ascii?Q?mX9WZjcaZv00OyBzNHHlwSZaE553nKwofBC5Bb4ebtUNJGtFYml9l9k3ebAJ?=
 =?us-ascii?Q?B5lYjxE+a7ImkUx+VK4Yi1qseQsOvC40XB80mMfabtrjTREl5BIXXRucb5Ay?=
 =?us-ascii?Q?ecWU9NzmicvjrOjxFWkXGi7X4dGN5OCiisp4zwMRLWDF102fR8Lb8Q3DO5RF?=
 =?us-ascii?Q?9Pr3D05MqaizMwrFLyrWP6YePqGL2o73dFzhxBjU88ISElQaA4zq/Z7nL3Cz?=
 =?us-ascii?Q?xhCyK4PypWDKC9htZGDS5W6TufWyqzmxGOxeIZquQJyqaDL/KTNPDKshAMMw?=
 =?us-ascii?Q?lRlKGDfIUTOQq9ZRyn9rYkAcd0l7uBjARm1T0TjrPH7SUhi6nmzKJrIdAzSN?=
 =?us-ascii?Q?7Tp2hRKJRtv4+1mgYghqHf5xGtju3fpVzULYrOoCoc/WF3pgD5VVjnJHx2Ax?=
 =?us-ascii?Q?b+VVa6VUwrsr2AASzqox3+1tgfSkPZWgZz/i64hil03JNUcFd+rr/Wgekg+I?=
 =?us-ascii?Q?njFggs3C7YSXcoGn8TTgvC2oGCEwXNHLGRgxBpvE1u7tA0sU0x7Aq+cRvs2J?=
 =?us-ascii?Q?TMzVrepzXOLGJuDyTlXhQGHWSZiQrJvLSnkfIX1dOxPkuiD7veTxXhFNdEiw?=
 =?us-ascii?Q?P9V5/LgZHiW7fxIJ5GP38McPL83EeVyxMPkNHfF6t+f7lP5UaPE4wDtUnRo2?=
 =?us-ascii?Q?PNTnQtWORmzdgIxxAgStlPWNFtUkanRCbJj4ZdMZCStgl57tcFpu9Zgz5/7m?=
 =?us-ascii?Q?vuNONQnj0r1nLs3QpAQ9rT66NbLBxCimsAgfv1OoHUWCtqBiOvELNdXizulP?=
 =?us-ascii?Q?liRclHICKJNVq1EM+jp9zQxLo6c6VEplqhRXIzlGV0ibNOvb/7JBA7COUGab?=
 =?us-ascii?Q?ZiAA/C+et16jonTbh9k6FntIrjFz57qF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l4fVlQX+NvwJ4KuMcmujcjgBOxrNah3AaFux6Wjt5wP2H/dHYDcxOFw5EML2?=
 =?us-ascii?Q?DlbFfJde8JP7z1n/zdDDuUpy64MUbgGByDNAAME0zkVDIJ0wh584FhwmpmJP?=
 =?us-ascii?Q?aNNQPKRT2xzn6krUaX014W8c3yPOODfkRwqMe36+z2CJemGEv5Vmxij2+2GA?=
 =?us-ascii?Q?6dn8/4g//N4gjKBeW3hRivar1yx2vRpvCAVEF65ryMtJLW+5Spni/+ZF/Y0U?=
 =?us-ascii?Q?dYAx3oa0OzS1O2mJB/Knw3uYGLENt5L8K2xCLKEeTFs92/9KQKKpPzJilAC5?=
 =?us-ascii?Q?nQO6fFnmMqHg9HfLT6CUd2m4Invmd3HO6cc7LUWViabH21uRJOcxu3x+mxrn?=
 =?us-ascii?Q?mpHSzJ5J37BXC3zqYoSiuK9LDumfd1Nb1A/FEUeKw+rSvi3ikail3KgRJbe1?=
 =?us-ascii?Q?dz08Fksbvzy0ltwYd0C3kGInkN7M5zMLJVkxg148d7hE7bUdRqZhxsD66ud7?=
 =?us-ascii?Q?8YQfEk0hy4LXXH1yw5XKDmt9+u9hDqM+X/ofYdoV6hXq8dK4wk3v99+q11tn?=
 =?us-ascii?Q?EaUhKqXd1Xi3/9Q8HifyO/WvplEOPoWsaZFIHggZ8uhgAbnmv7l8pvH7MxLF?=
 =?us-ascii?Q?6XghqrzUmx+ekoIah77H9m5TA0XI2/N341jTorgaveflWoceNRAByzwsG/D7?=
 =?us-ascii?Q?f/NipljaeE4GgpXS3YfzjluPXP/Aee3hl76ROi3ah4NDrPOCeVmKd5tqQ9la?=
 =?us-ascii?Q?GgO5V61U0pHPmRXU7HanqNcacJVZuNhTHqyd25Lo+tE7SSW3DrpjIWX2Biyg?=
 =?us-ascii?Q?gAnwk8s/2t4SXs9Hmw21c3lhSYsMCdDJJUB98AJysy6DUXEOL7X6AyeL2tjV?=
 =?us-ascii?Q?fpDq5yyo9xSMqhmgBqXkY91FfJ1a5+A1EARgI2yRz0kDNJRCM7QCngOapEfK?=
 =?us-ascii?Q?8sMcbG4QWajlifzXkuf0QlkHJv+dOzUn8RtM8u0haIuF6Epl6Cnm6Hkzs+uo?=
 =?us-ascii?Q?L1D9vXaPuhCfTusRw+7FpQQb7QkcsWNcUjcjgDy6cEL/oPS3ECAOUSYl+WW0?=
 =?us-ascii?Q?+7N54ZcrBqgyFui6aWGHglGJOPo11uj8wpYQWO+yMTG+C4uAWQjYXa0LBdB/?=
 =?us-ascii?Q?ltoDnZ5h15/itAHVRRBfpnbeMCS6OEka3zWSWOG2VwKHzDizQC1rrAZRpu4H?=
 =?us-ascii?Q?CFJ6jnIVOIPSvah9Qs/aWNd7pzLyUipEYF9VUm+U+kXm68WS4BzR7ZnjHV0C?=
 =?us-ascii?Q?cCCqbdwCmDgHL6gmPg7pOU6HlV9g5PhneDh3gXSwhXzlbcCqFL3edFMJKuoq?=
 =?us-ascii?Q?aL+PDQO8hhXEcmBmBTXsYlC6SFd3+9NzcXNuncDEAgG02yzHAsGKR0sPxDrr?=
 =?us-ascii?Q?f+LPNh3k19LLQmYFDeI/P35F+7aifiDEMJg2aXt/r6Mj02Boda5Nw//hOyuN?=
 =?us-ascii?Q?QjEHYTu685y/s4OK06iQYf7h1mRUz9PpKODaFRE4O2Xi5yEBvbFTWH3fV3NO?=
 =?us-ascii?Q?Z3OoZMEJwIkR3uk0bD/1/ExXQIVcT5rSCrv3M/Ckij6RX+89y60pgx03xLIF?=
 =?us-ascii?Q?boVHpGsx7kJDqRuqMZYKEx/eS0JQZOISrt/EJGXP2N4pUl8hZS4zHfA1rJLy?=
 =?us-ascii?Q?ZEtG3jduYY6LxQHfDS0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a365f4cd-e482-4b7c-69f0-08de1633973d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:06:37.1191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaMR1oD4XozKQQn3BVjSkCd0CeYrZFloFGq9tL1HYxEFEAZ8Vl5g5wgf2eoby+bV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7586
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=jgg@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 28, 2025 at 03:59:02PM +0100, Eric Auger wrote:
> For the record, there is some form of ATS support in virtio-pci devices.
> They have an ats property. See hw/virtio/virtio-pci.c and
> virtio_pci_ats_ctrl_trigger/pcie_ats_config_write

That seems overkill to me :(

It is fine to cache some of the IOTLB in the kernel, just drive the
kernel invalidations against the main IOTLB instead of muddling ATS
into this.

Jason

