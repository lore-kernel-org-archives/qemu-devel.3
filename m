Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA451125875
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 20:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PjK-0008N1-Ow; Wed, 11 Mar 2026 16:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1w0PjG-0008MU-LL; Wed, 11 Mar 2026 16:00:26 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1w0PjE-0002Q9-9U; Wed, 11 Mar 2026 16:00:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzFZtNFoLmLeoIfGzG+cP1ooMYdf6Iu2/y4dGGZPd7nQ3A0UZjC2j/dX6Rzj09bqCJ8SJhP14OeQ85BSl0lXnc7LpOj40irHpMAhST2G+VEvapF9VSPpjK922QDV7dJMANW5pLTz6/Ere1MO288lKmXpfUpwci10NDk7tw4ODnrJmQt+zhBoShUNZSQDMgCNgKRixesdMCXZJ0MKtYY2i0jEZX2utKXVROxgnsuh+17mdH2HwUOfsmyetA5eCebVJlM831Yt8Pego4JmnbItcc3dAIuKpL0k8wyUokiW3JdL7c7FZk14hB+BXBxWESxDvOk2d+dNmzMKOE1HMAWL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJUI05rVsLggELwbeM1wVitf9ewmS0msCbNsIp19Wvk=;
 b=Qm/yKSIwvywCmnaKzIUTF3Ikq7XRhbQNRhAfUToKp+1yffejkW7IUf2x8dHP4JQGdQ2GW51MqoUEnTJTyhdR0ivkZNc26OnZIEtnIOZU26R54La72ExCbm5Pieffcf3I00I7Bsaw4I7cZxtYem18QN7H1yY89mLsZZcx3urAR34Mxw4jCefsPWayyNnwMOJQwiYFgMCOgxL5e5aKIVvW22Q09lZbYZUNk/HIdIfmQqBxDRZ52pa80DphkFdO8eMmvvNkUtdv8v6yLyTmyv9Dyhyx1daFhWbI5T+rPCyHgQ2t+qhjDkZGlIxFJlHXRt6/XfQSXm1QqSAKqT/scQXsgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJUI05rVsLggELwbeM1wVitf9ewmS0msCbNsIp19Wvk=;
 b=XZEPgOHid20NdF0EiRoxEhS+Wgv89kIl1bfBd//mt5zZRjZunIGm3GrcEJz9b8pJP3e0nsIVpT7eKKeUvWeR8fpQsupbXQcfBsYZCTmkjX6wuUwVU8QCjLUV9Zx3YOK/TY4X0tyNO6L9buU0cEsX0/QkJHdkWNV8bLIWPNN96iZJ65RfEf4I08T0tkA3LhL+Qieoc5dxm+zwNpY1YDtnJtmfm0iqkqfNVAOxb5z+5ciwE9PK2pxrDoZ0pXUywXAyo2SJH2LLIKcItuz2Y36uivkTKEpM6TrtS0hLsxdTO+Y+5rn72twLAj9bvrr/jLV302F4rm/IuITLfLoBPaUokg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9665.namprd12.prod.outlook.com (2603:10b6:408:297::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.3; Wed, 11 Mar
 2026 20:00:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Wed, 11 Mar 2026
 20:00:11 +0000
Date: Wed, 11 Mar 2026 17:00:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Jiandi An <jan@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>,
 "phrdina@redhat.com" <phrdina@redhat.com>
Subject: Re: [PATCH v3 00/32] hw/arm/virt: Introduce Tegra241 CMDQV support
 for accelerated SMMUv3
Message-ID: <20260311200010.GD1448102@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <254dceca-7864-4dbc-b25c-928add5a78e3@redhat.com>
 <CH3PR12MB7548B7D18FA56E6F8EA657C0AB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548B7D18FA56E6F8EA657C0AB47A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::21) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f5e893-b7d3-4f72-b492-08de7fa8cdb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: q3cLOMtWfqk//UGd/2jouETZ0zadkCfuE0E4EHozPHqAMAOg+rDa85oYsuDH+kUoFeU1J68+n5617vKYpiVqpET8TBGnn8cMXqw4hY8htrP5Dgw+64tNmn701NOj9jKBuqT4YWB4dpRcMhLJcu3laQjsdOmOrdsbeOGWE7TIFTGuVX3OThGZARCpONL8J47TfTlxlI9Cq73KTVwALal/2uOrEXeMVd/zRoBF/rc/QsOW8kl9yO0qnFxsRWWKibKU9drk7UDmRq4x/+asvLu+fltnKWP2w1Yr9qfkmyzoSatL9oxJkY2i2txUSdDs3AyH14KW1fSHre54AMlSRXCDXeCmqczqCkQPnU4U2OdBlWHlkAw7R550uuoge42PCRb7k1V4eSoBb0O/gMwQPwnS1H7U5ftEH2oWctE2v+BgAeWYJgemQP/0BCe777zdTmBbZA5+W+cqAAVK/RqLzqMGLSuB3VH/86bSY31SH6kMOEuMZmstUz2BBdkwyHave+ohiEyBBcoImt3+S8o2nJ9cSw8suxDIBQnusHhHKN28pg12sf+20cJJ8w+5x2HPpeBDe0D/tUs2+9oEYIKswgePdwW8LrLw2bHPcCSWUVkFr2f4r6RVOgadR9nCCUqpmR9VNg50LlPuCeI8aZ1TeiH6ZUOlHUqsnkMj0lWtazPdqBRq+wSfTq9yg9y/h23jZOaCq1o5751ds7fxd2KI8C98eobr3I4H7Lk+9ccTCt3kobY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SdThgtgMEl4j/47JITFww55rshTGgoRMwQOZGe1RyNwkMNPSYENsi/KKQ65q?=
 =?us-ascii?Q?jHPHIYootmf8gC9hv5pSZiTeuFcyoXusJRJZQ86ZPfDaoP5aJzDW3FV4HqhU?=
 =?us-ascii?Q?y4iF3YMoyONVmQmKMtyDmtHGFiYpSpe0H9xLc0X9D9CNloOLFpqXBb+h8vkl?=
 =?us-ascii?Q?gNBiEnWiBGRJ+RMoSIwNOjpBb+L+vsIL4YGM2jakoUw4u9cmmVrITCztZvWJ?=
 =?us-ascii?Q?6pZVMvC6ZxZCw53h60+Hmg/xbbS6wWCVnLNhz6/QLGJed97pxRFTVDKkh3Hk?=
 =?us-ascii?Q?PFtR956yTaleG+VfOBf7BIY1PuZbUY4rQ9Or2+/4KKibGuNzi+MO0ciY1sZ5?=
 =?us-ascii?Q?Tza/dtZ7PHE4f9MVH+JY7noN7JnPyVldCbYPsTa+h4b6W8GaTQXZaCIJ3BpS?=
 =?us-ascii?Q?Djkvpk70/riuGGgXKEXdUi19fAV/M9o35KbzhSZoF9h86goVarjq5lWjZR9w?=
 =?us-ascii?Q?dFKjIeGQr3okrsm01rjWzcit0HhUR+7qRHGGJwCLzC3YA/WzHuK5C1o2f/hD?=
 =?us-ascii?Q?rQWPZ8slF6iHttzS6vLn/Tu+t73FLSk2vG35Ki5pPPFaNquZ/9ui356nnavg?=
 =?us-ascii?Q?84mWNSqqjx11yidyl+NGQMINrvMYH1iTC2HIAj3CdNPs1spr8XS3gfEQ0Iag?=
 =?us-ascii?Q?Ugq94UsDIdr/d+6RLxMWO4Xph4wsHYFxFh7HaCkV9pUQdLQPTdEmP7fvufoK?=
 =?us-ascii?Q?lmzVIOmiDQ/nJjCIG/3ik3t0rku+aS3VAzT1eWc/2tmzb+uHUYYHjPl0Mh53?=
 =?us-ascii?Q?2uCpCcErdUxoZhjhhAIpPVMtEtUqnuLyUAk3X6YHF4QA4XLMayLJcJWgqLx+?=
 =?us-ascii?Q?f6w3tK35rYFgCJ2N728yKNZybbOTne32tG14KeTXYOJuOMVZ6v1uPtAfp+/0?=
 =?us-ascii?Q?9NwUXeOM4mhkxODCdqQez1aQBxD6Jzknrbc7qxNYIeLamHcBd6iR6dY0ZL+n?=
 =?us-ascii?Q?F/jomo9NIYxN92VB23Ups1NF4jsxrbVQWbFuCplovJ0G40KHwBdsODCDR3iT?=
 =?us-ascii?Q?kdgsxr/SV+HZnPFCNepqoEDgMWKDgp/DtFqws7YiYyli1WlJUUDXFZW7bKKL?=
 =?us-ascii?Q?hjhz5MLDxfdSEtGpWvt0qStMbAjLvoV0HwaiQBiDDk+woVBqtxsBBn9tRfAv?=
 =?us-ascii?Q?3By1/v/KQv0ZdSMKa9hiTLPV1RLt3tkTXy2AsgkvEGPGVp5a6gaMpO9HOCuV?=
 =?us-ascii?Q?Kn3w0iCPSBVhI6Q3OaSTvDpcIb4jMFhlnZBfpnDiCPXSW6cF2jvUjdnxuLE8?=
 =?us-ascii?Q?UIN6tyDJZa/4MpOvg61G63Zxui64UZdeefseebvgqBJdDKokjgNQODFiUHxw?=
 =?us-ascii?Q?lF3X3fCuHp8/DHniA0yVHFzDZFwpTEzMTFanbpwxVzBA7o16mEaVJr5b5AHd?=
 =?us-ascii?Q?w6j4PL5ECZpWgbCs520tO/R3++Y02EsvDwd5TrXjN3txekW5Dt+TY3sJ8kRF?=
 =?us-ascii?Q?1T/x3XAmKT+gKFXcjwyXEXnkwrmB26P78hCapwH4DaoAdrNJvEfIH/VjiMS/?=
 =?us-ascii?Q?CTZBAUOVN/RMxwB7FgQFEHsHXsbzSoSaqkFQtKHgY4yqqHhXeFoRV7U6Dryw?=
 =?us-ascii?Q?bPzR9mUNHJBz/wJLy6elmcyDRIivcXoSiM8FCWVYY/JuItTKGQioQaeQoGi5?=
 =?us-ascii?Q?85hXIIAKM+mqPYZAo6sPeBBhtwYHiTWqLmQsnD3b+Ojj1syzFNorzWUYF6uJ?=
 =?us-ascii?Q?hl1lIljDET+c59t/pFUIWTFRI4TGDH7RiSFdJzdBySdmnZbWMY5IYZKJ6jKB?=
 =?us-ascii?Q?sl9zo7r5qA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f5e893-b7d3-4f72-b492-08de7fa8cdb4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 20:00:11.7301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQSjiVpkQO2tq+gK+ew3giTccN32MvLoScyK7FVckODFg7hr8rjMAdxoh7eKOpBC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9665
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=jgg@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 11, 2026 at 06:34:38PM +0000, Shameer Kolothum Thodi wrote:
> I do not have a way to suppress that warning currently. It should be
> safe to ignore, similar to the behaviour before the dma-buf support
> series for vfio-pci PCI BAR mappings.

qemu should have the concept of memory regions that are not available
for DMA peer to peer operation - ie are not mapped to the iommu.

Now that the kernel strictly enforces this it is essential qemu itself
keep track if it thinks p2p should work or not.

Jason

