Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B591C02192
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 14:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdrwb-0007gq-CW; Fri, 31 Jan 2025 09:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tdrwL-0007em-6u; Fri, 31 Jan 2025 09:24:13 -0500
Received: from mail-dm6nam10on20611.outbound.protection.outlook.com
 ([2a01:111:f403:2413::611]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tdrwJ-0005rV-Cj; Fri, 31 Jan 2025 09:24:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwsHgUN8twjF5XzOemCO2PHP7JuVw2NRAFONhJlCVnzxd0hmLrUilddWP9/psa+bSYBPrpk/nkHtpY3VLt+DcOh25lefJnPunuV/oFUplNJ0ZsptbjluR9gF2F1OzBqT99vfM4TQuOOm7xV+isj5ashdnD0O2O5b0vgRUXTcaMHVZLWXWZDZ1vInrnAqYgujYQAxRBBtIdIDklziLKDAAmfggqKWmD07/V5Gx99EkIj91r4zwqsDgJKoLJnWBn/GN6+y+xn14mpDe6/T9Ck9ztGhg6Yevuxvi95YQAKLBrdmTE3AO9Musy+vzPlgxNCsORgBY2s7NIDUvIPbiEcbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3t7RLb7yWthYOoo+l2zhibXtVo3PeW87CUNfkJgMBU=;
 b=nVmq9XCuR1ardwCPP2hjog7zRmj6pSgn+LwjtGbCnGSN69wSG3cMffcYdjNwn4k1aBWsbQWUL/sFUH367/uxhB0FxeDA5KzaCu7LhQqB+iO0SN2zbZALIprd69lmE546GXwKTJUn6HEGWLOXVyRoSteo+VdofuMLVZFsB0cD1umc+yYxLD7cWUeatMQelexhMLFkqMaIzKxMJd3NElSz0tNtNgshtcUcjgreFF3phafpsJJiaygdURHok+zN/YVB3bzLGnfNuHzenuoe6lFpxUpdT5KfumQaNxnjQHXDfJn5Qh8FkptdfDHTZV1YCXM8SBrJT0tqQoPo9g+VMXqN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3t7RLb7yWthYOoo+l2zhibXtVo3PeW87CUNfkJgMBU=;
 b=QxxH0kY+5IPiE4Ur1kjBRmTwXkXL5qSVBrZ6//8FHRCHzIQ9YH2H+2d6peRcyg1gqkkQZZ3ww0DUGGzcQCbojm8GWDyxnvodpTRZD3hgi8NuDY8hb/VDs3NS4RhHnjQRbVrrZI3T2qowjxW9j6ymKcEQhxvkxybmBgburN6ScDRECxoQ4ENNrhFOdug2UkdG/fDiPeT3nm0nJIZzbQ74NwLXeNYcYfcmDdJ+v2VUXwGmzHkpyNdHk9m3oQBE6cqBbdhKDzmmO588hZPreXlz1JEbskrXmn8OS6y/smXyfDlmurqi7iJYX9S8sJRHhZq/v2Y5f2pA5XOIApMajSzHxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Fri, 31 Jan
 2025 14:24:05 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.018; Fri, 31 Jan 2025
 14:24:05 +0000
Date: Fri, 31 Jan 2025 10:24:04 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Nathan Chen <nathanc@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <20250131142404.GP5556@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z5uiGnAxUf4jXTEI@redhat.com>
 <7ecabe74e0514367baf28d67675e5db8@huawei.com>
 <fc91e1a798324390b2a556fae5d40f46@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc91e1a798324390b2a556fae5d40f46@huawei.com>
X-ClientProxiedBy: BN9PR03CA0527.namprd03.prod.outlook.com
 (2603:10b6:408:131::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: 44713bf9-8c85-450b-74d7-08dd4202eaa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HHV2HcyMhAuKKOnMVvd98dNrN1GNA7+d0nOSrB8iIJ2mTn1rjVZWXJcB/TUs?=
 =?us-ascii?Q?ngLkLfWhYxsZTQn2bcXoZryo0REXkorrWPAdYBBEEGNqEFAm6DUeQTeWFZCk?=
 =?us-ascii?Q?EQussUhFExiBeGAvueCc3iU/ktiezMp2IfhJUOk/iV597VoOyEnUvRuSrjOg?=
 =?us-ascii?Q?ILXgqDTa1OS1YcsqQ94ihg0ynPOfHybkoxIOmBWPBLFIAGNeT6to70VpfUir?=
 =?us-ascii?Q?WD3G4KO9rDQeskzV36NBhxWMBvyk6c0stxE4Ehdfg9HoSoCdvdnloRtpZMzi?=
 =?us-ascii?Q?HlKR4YEzNgkcOxYWDRnbg98yvOYsfYHHFd6n1Yv/Xq5aoNNBIWeBT5FcBLPy?=
 =?us-ascii?Q?QHUCSR/KMy0r1FP+FsrRUUP9zMPNQnRSjNuLd3PMHY/M7mixbOuQhzOgmIUn?=
 =?us-ascii?Q?hzWot+RGjVTzOVCrQ7t4qkzwtGQfswT1okgH4Hux53/A+MbgRHnbUlpOewao?=
 =?us-ascii?Q?Nd6IXUtJcUjiqoQtxu/KCTW8TiCkDZP3qO5l3dfCn1sgYiNl/6USsRChRcAx?=
 =?us-ascii?Q?N176BHWgmp3oUxEVRd3REQhTb4PRra7rhdEmNkL/woIiSdQ70WEbB+gH2PNk?=
 =?us-ascii?Q?KGBGZi9Q4M+xMX4BFD/aKrwkU8PQiJm//uAUPEydv636lTAtAV3EWW6aj4Nu?=
 =?us-ascii?Q?zZggq9aB6rmM0HskirabMqqlXV3E/G5v7YBuFsYGwdl1yCIMZ0l/aUSpJluB?=
 =?us-ascii?Q?6hTgvdjy+wJBZAGFnHU8OtL4fqZ0O7pKzJomSXMrbnQWCJNBgl6JDllvY/uJ?=
 =?us-ascii?Q?S0+7hHh1h3OzFuXXEunc6ZqyBfHQObAxkNiIvqdI/Kad83D53VnUe3fakChm?=
 =?us-ascii?Q?WAsr8SgfUj1OKn7Gqa5YD4wtpOxG4VpNHCADewaIAVUt0h4pXHDXkA+W5A09?=
 =?us-ascii?Q?tRzktxkF/lGWJZrqAcjQNR9y9n6AtgIcWXpwjoM30PE3Q0EuG5AiVJlyAw0c?=
 =?us-ascii?Q?5c6Tq20NIp9avWURUoMjUcSkaa2iTCD/xWofEzjgyoRp33naZ62WUa9nZNKX?=
 =?us-ascii?Q?/GhbDbp5HlcI8m3URFMqKNB/AzMKTDpAy5mRRDa9uDNU4AcR4uocGckVqOU/?=
 =?us-ascii?Q?1E1F/q4C3s94P3w1l2bLtMu6iKMLsAJkv+9SO9kZU8AuAkBf0YUpbbQ5WI2t?=
 =?us-ascii?Q?ZEZv0NhosxDi86jw8Z2yx9QPTHEGR4zqKgveJw9hWwj7GuQMQzE/oQZPxwbn?=
 =?us-ascii?Q?50JuIAov6056wZD35JJjfecU8xSzMuW1x9wmVbsgR9P2dSTEwRApCpkeVyJE?=
 =?us-ascii?Q?Twef1kTILEBECj4YF0lEehJpHt9MJsCrnyvhW/0CQkq0CsSZ81FMITxaspP0?=
 =?us-ascii?Q?IJGYNcBTYSw3huRzQgDEpDTjo6d3VMvziM80488sxGy7MPaFVvzStUcgFEPL?=
 =?us-ascii?Q?ojIRYGKk6K3w+GUrthf4fEz2XzYn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AzNMDRxB/AUWCTjZdtBe/I1k/ZYREPz7YGiMKVRRespyOYLvb2ocns+Rbc31?=
 =?us-ascii?Q?ADzQ570sOn23gRz2IWtQzVWsEJ9MPrFdzs0ALmQpZbH9cZahOiCVKX+ufO6E?=
 =?us-ascii?Q?KJ7Q/LR9+Ovgnn1PWyH5mol4S4JlfTjuOLwsBcsQOzs+qalIqzZHRktRzdS8?=
 =?us-ascii?Q?HVqMFKCwwhcHHvxI0HTuFm2liva3tdKzseEKJ7N+Rdvxz+wClG86xhiLrvw5?=
 =?us-ascii?Q?yO9dunOvfmUW5E1lfUpnBbIfp4nRF7RO4Zuusl7YWG/aKIWw51fPN4lbOypG?=
 =?us-ascii?Q?WaQroHCWzoG4O8N4bAOtWvm/mFH4DuPBSqha/1IC4tXpjYXInsDCWCPPX2VC?=
 =?us-ascii?Q?ePsO0y7yGEuzez+jAn4gGY/aMvRBF+fjaofOq6bAUpX2/LXSyS4A1gFCB94z?=
 =?us-ascii?Q?xPJgIZzhvSvhMVqRnb47W3Xu8JA/9i1yZEAT/yg4yPC6aGblDNd+/M/sbOIo?=
 =?us-ascii?Q?QmHlC50Uiq4+C5o0YSOd29mMSvkRnHOm24Tq9ZLSnYXHjgi6lwOZd7KqJII0?=
 =?us-ascii?Q?Ag2HEGRhr37QviXjEqwqgSOv61o/dh0z1uqJdRoDgoL5WMrdjt2IWBEAjGXf?=
 =?us-ascii?Q?XuC+rjxiuz5WwYwrEw3+XSF+fOHXf4P/BHnJAWmUfeNajZW6pC7w6Ts5a+QF?=
 =?us-ascii?Q?GzPTxVbkw8MS+2T+IVIj4MLBNm6AyWwCt/xPG3xGrOYDKoSqYVRb4tltrBrB?=
 =?us-ascii?Q?bCKtt7u3nfCMmvPO1kzlRQbreOEb5NZ3OSKRHT06jriocCowlbEGFm/WkPxq?=
 =?us-ascii?Q?0H+6OLgNVUSLwasFfE4Xs9SMhUnhJB+ScfdcuN9eU+tW96NrdRY/rHkdu4k9?=
 =?us-ascii?Q?AejShzXAyHoeYGPcjt2z7Al+TCzbp5OHF0KuEqMqF/mmScuYpsLEpYFqSljP?=
 =?us-ascii?Q?vY6Ne6XXAyI+zP+WExt8jk74ohnR9HI3jtCkl8HiIu6798G/kVR3C9hvTkK2?=
 =?us-ascii?Q?ktCXMHuWz2sYZY1h/5jXlVO/MwldtZnaS2egXlQLW2lJK03RzUvEVgKeoNKE?=
 =?us-ascii?Q?fmtSUmdrG++vm8hlJtNFJZ8jwiyDRTVRKWzDqSsi9K4OJuUdUNOArgUljLgM?=
 =?us-ascii?Q?M6AskBwxKSuPaTyIr8xW8i1DVac6TjGxLgIa3g+ZEb21O0mtYdu7raPc0O7j?=
 =?us-ascii?Q?r7nECaS7o5IPuYLwydY3Oqpy2qRCsRcYlpxc1Tx6uyXBcXpGWk8Jt0sUO1ID?=
 =?us-ascii?Q?EAN29IjXlZBWtamKJL+ToxnMVwJds3X36C0yjOOYi/Q3tGHNqb6BG7/6FFuU?=
 =?us-ascii?Q?+FdY9GXR0XV8N91xxmBmjnTwzwEigY7XNuq8Zq3msZDRUAhAJlALHkmpCxM7?=
 =?us-ascii?Q?xG08roj/w4GpYF9TqH1HSfqDQ5OZNdzpc/kEnc3cm+fcHQb4pd/a4WqEHNeP?=
 =?us-ascii?Q?OiCtNMcjCt8oGMaS2w59qHob/TBNAlr4ObHi/0KxvOBa0/lF2P7zoq1aob6U?=
 =?us-ascii?Q?i6TiGVQUQ3Y6l6JbyszmzWw9yW25g+Q3bPCOeh5p6xwyo96ZYxWPFOBZwsgh?=
 =?us-ascii?Q?MV1018lb+YF6RVvqT+HtcAV8yIEMMB7+VvXPDVOf3vyj8KhdYNhStsIJBQ/Q?=
 =?us-ascii?Q?N2O5hYwKW039EBa4FVqdF/CTeNMw0wfTkIzR4jZk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44713bf9-8c85-450b-74d7-08dd4202eaa1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 14:24:05.2395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbIlP7ggBwUd0xn1i9mWlYe+wsfRE7waYs23oycQQnc5UTTqQddMHMVBTFr8ISKg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
Received-SPF: softfail client-ip=2a01:111:f403:2413::611;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

On Fri, Jan 31, 2025 at 09:33:16AM +0000, Shameerali Kolothum Thodi wrote:

> And Qemu does some checking to make sure that the device is indeed associated
> with the specified phys-smmuv3.  This can be done going through the sysfs path checking
> which is what I guess libvirt is currently doing to populate the topology. So basically
> Qemu is just replicating that to validate again.

I would prefer that iommufd users not have to go out to sysfs..
 
> Or another option is extending the IOMMU_GET_HW_INFO IOCTL to return the phys
> smmuv3 base address which can avoid going through the sysfs.

It also doesn't seem great to expose a physical address. But we could
have an 'iommu instance id' that was a unique small integer?

Jason

