Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30ECD69105
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 12:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGe13-00013P-6W; Thu, 28 Nov 2024 07:53:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tGe10-00010t-Mi; Thu, 28 Nov 2024 07:53:02 -0500
Received: from mail-mw2nam10on20605.outbound.protection.outlook.com
 ([2a01:111:f403:2412::605]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tGe0y-0005tJ-Rp; Thu, 28 Nov 2024 07:53:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5vKwD8rnMmPhtv/CKeiPfU0TJnevnpLJht1n5HFjqMzEZAL/sXrok5nh9GpZz3m3JLAceiwaP6Sp/etNCmpmacxeJJ10NLFkvoNWRclBJOvIRfM4+lo+qpU3L0oQOhrSDSkcxR/sYLqGlOEP0yj4+R98h9SUn9sfkvUAz1Kf/ZchJeDKgbaom1uF4BwZyiXevlIeel2EsOs3YMp6VbbolM4lS5tunOs9tPIMnrV8+/Gdog6D7LO5afi7FapUjwyJlRTL9v45NlqLflyJaDuRAIE6uNP7bn+TLuoQaPyMdGzh+MSpKt8YR9+YNaEXRrIThhCULsBqW77icsVQNJCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AU3rGpGrII9irmb4sTPEImdcS67SbEwn+ubv+b+ekZk=;
 b=xRzyx1A3o22pWncMI37VD6Mep21q4K1Ta69P1bvGsXIjarwoiHHayrr4rtaOzAty44h3jETGCQT9oxYSLBMSOLpNbSg6/yTAWxkSu1xmNwetW8K/6Vo3uuCOESNNI1ZzRYndkr2xtbA0ms+f6031fWo39NF4buJRz6UYksyf8ubhHhn8SGKUb//J39gEdCDal0MAY2i8WLI/tgisOEGcgX/7MYx9PAMuvZNkobVcP+WcmlwZ/q/mNfDE6HZhw/OEs8dVExyHTWBRQpIPOe3ckEr2h3AsG/qdFXhrThwFRhdT0P7og4+hdugYj5fEKbtXhieHP5B+KK/Gm0kyEGXCKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AU3rGpGrII9irmb4sTPEImdcS67SbEwn+ubv+b+ekZk=;
 b=n8cM8CN77DUDgXGRIweF1lin7ou3dGIQ5CsDC1T14eDyel+aZ6UP2FjuKBatOo2s4sWD9/e3UsIvuNTDY3qCR54zXyOaRLOgHZxh5rg082TGOuRFtO2fOPRcrx9SW1H1NM7EUR27SXzsoA7ff3k0ScwkawfiPDalRTXwZUKn0EmLHS95enS79oWdkInbFScxc/Zo0ENCtVnLNFXZwi0B4PFeXUPGmVjLdlshZReHchqxlMksRl8HRbEXcO1rF79YsCoI8tLasSuNodlWef5l+BTxxPyXYUjf/NOM027Y4CtAiQHsUQz/yr5oKIfpjBKr1l1oIULiUGfUlDaJh/Ew0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.23; Thu, 28 Nov
 2024 12:52:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 12:52:55 +0000
Date: Thu, 28 Nov 2024 08:52:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Donald Dutile <ddutile@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [RFC PATCH 2/5] hw/arm/smmuv3: Add initial support for SMMUv3
 Nested device
Message-ID: <20241128125254.GC1253388@nvidia.com>
References: <20241108125242.60136-3-shameerali.kolothum.thodi@huawei.com>
 <00e8a5d6-c926-44bb-8d11-dab4ddc4820d@redhat.com>
 <ZzTqXCFKV9s++C2N@Asurada-Nvidia>
 <cfe8864c-f830-4b39-b4d5-f219f5a42eea@redhat.com>
 <d8fbaa677771425dac985438b4b1db59@huawei.com>
 <20241127160031.GA1253388@nvidia.com>
 <bd4c4665-148c-427b-8717-457c584fb233@redhat.com>
 <CABQgh9ErT6BmvbrUr_aNiLFws2Kx-=NzGJJCo+vV7AV_U6Pk9g@mail.gmail.com>
 <05470fe6-4336-455a-8b30-e05fb273aa25@redhat.com>
 <3fa6f093ff9a4749bcd25d0dfa60b1d7@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa6f093ff9a4749bcd25d0dfa60b1d7@huawei.com>
X-ClientProxiedBy: BN1PR12CA0002.namprd12.prod.outlook.com
 (2603:10b6:408:e1::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: b71cb061-3b44-4406-4645-08dd0fab9407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QzZNtqe9kkDPLrDmRmd9JFEwhguwkNNeYz/QuS3cSoN40G6qKfx9mEEoQJQU?=
 =?us-ascii?Q?ZoKfNXNLgDpkRlF4q8DUwuTjMJd3HCdFdGqXaCcnY4HGSb+FP3n4t25CCNTN?=
 =?us-ascii?Q?qQvjq325oN62VVQKqgzpBiVFXaQ+UmkqyNELvvXRq5UjdJIz+bQf6YOtBeH7?=
 =?us-ascii?Q?+gebCo1KPKZbi+GlP4fa6wlgvF7LWJTGZvHoc1YCjuBNNaTleHIYJAzmNV8M?=
 =?us-ascii?Q?y/xTiDio+1Y0X4/ADsgQtIU0BDz/d3mlgLjsorv+vBBZS17psgAXsSjyUT4s?=
 =?us-ascii?Q?qfLAUb3NbrrW72BC2/zSxRbhg440F4cJR7cGsC275D1KIVUZT5utuBPHBhIN?=
 =?us-ascii?Q?bMFQfYd+1gifo02DHQFIwgGhrPsu+Are/77f8L0nIzzOqcJrplCcYzdvzODj?=
 =?us-ascii?Q?FR7Uc9iwmxNsTqC9p3yl9pDDTg2E2arnChvaZ0dr51ARTDQX5/HZXQ2V1+ZQ?=
 =?us-ascii?Q?7x/zgQlKkWZ1XtiOACdwSSGGOWTgqgmofNH+/hQCfo5Bz9bi+y8ern74lNpb?=
 =?us-ascii?Q?mJEkMr6wPeN0kyNbV/b8fCEEGEXAgC3ciAKb7F63kIMUIGgFXaLQKUwcMakc?=
 =?us-ascii?Q?DG4XIuyHlf8Q7Ir2a9Iou2h3mPU50yCUB/6SFT+M+5m0byZtRMVE8yc1If+0?=
 =?us-ascii?Q?AFSUD0ClhDIZ8Mrvv5J6qOVkfh/2hSF/8/S5JF5pDTw3npVoiu1n5+h5xfMf?=
 =?us-ascii?Q?5uL4r4L+PIphOQOi49ya5BQ9jg/uDhs5OvzZNXWoMZ3+mqQc6NwIaEA6l5gd?=
 =?us-ascii?Q?ygsg8pHf04xC1k7DCnxIPP2KD8jcR250+h5Qup5PVTe83iylZj5i6vZQNRnf?=
 =?us-ascii?Q?BzpTubKoZ73v3DgVVApOfenAu865kE362zoNxeA2GLIATBjK6c8ytRcv0iOc?=
 =?us-ascii?Q?LklXRRH2HL1Q2ZklRYwO0euCfNsHiXea92icAQ6Q2XwTSSoMjOFnNs4h3sjq?=
 =?us-ascii?Q?CrsyyD7FpLqdZfTGwmcA8WmGIJ7IyTc9CHzUZ5egsYsqVmGasiVzDy419zPG?=
 =?us-ascii?Q?8vYFgqiigCHSWFIBO/XrW0P44/M+gbxO4WxZaGZvbmihEVfFHxwyIIsKJpOh?=
 =?us-ascii?Q?4hZkH2ZF7l3nurZElz0WUPxV9gC4IQ+DeoxvjLvxr/04Qy8qYxSdzkHil/uR?=
 =?us-ascii?Q?7xw3ew4BW1vt2jkMWyj4e5OPhaw4iIhMVU59hacuZM0GzMfIUBLvD7zV4Bss?=
 =?us-ascii?Q?P2VkuZZRKsC2KQ0OUXXaf0KmPLyYmfYJ+yD/S+/MWRFi6hqasE/QYUFBYbOj?=
 =?us-ascii?Q?v71v8UTOYKOz+KooeE4bt0M+66floBIkaogf8QXfYs2Fc/otLm7RwrX2UcUi?=
 =?us-ascii?Q?w3EEJLHYWjldP6RtJsWs+HwJ8imao5wibUXy1lQ2ZEIIcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xA1FfZz9g9ZncWEOIfxtxmoks+khC9llcKGvdYGPcLW86zuO/EYXGcBO0r2t?=
 =?us-ascii?Q?llF0c+fMiObh8DST1eR9mWijff/lsvdpWuNDQvP2ll8HAQVL5MVbJBCoivy/?=
 =?us-ascii?Q?54aVA9PMbtKgauMMR7l+sKbdiPRrv/67ZVTYB0e65AcpS3NctphfBJtklN1m?=
 =?us-ascii?Q?hhMyMkZ0rTg33k7LqpUuChXWDB6o/OA2mBf9Xt9KcID4Kekd7XyteiLLsQ77?=
 =?us-ascii?Q?0Ps2/MbSEANl0P14+pODMo9JGfLZIawZ6BQnm7FyqVisa26U8DvcnYLXg244?=
 =?us-ascii?Q?BcU5Z+8HeJRqxReZRHcHubJt/WYHEoERnuGaXpl4U9HMu4g9o5WA+gkdMoeI?=
 =?us-ascii?Q?I5D2KNwonwOp5xXwl2Jjvn2l81yX/dX3oRST+sZ+3oCj9v70DdRhH5Ut20q1?=
 =?us-ascii?Q?Q/Q+mhuMC5rVzxjHkdKyHxMq/Ofp0ZisvY7FSlcfLSDsGpdj1r58kPzutydX?=
 =?us-ascii?Q?6Ye9je+2PwNLM0YRcGLdBm+CT4e654jvSk8iDLbOBiwfNTiiJ7VT89iNyCOq?=
 =?us-ascii?Q?faj+2UKGf9rUFZ9ruSjC3xbnBK/uwUeA4gTx9maHB+0J073U8+FW9NQNto3h?=
 =?us-ascii?Q?lclNKa9NN6n1DvknjC44F/T9kbPXFnoWfTvs5ETDNbzitC70kXNVVFlx+bpz?=
 =?us-ascii?Q?aKWFERoWbg/gZX0HbfGbYtGMhSld19Mu08kKkZRNW/VEj/asryO5l0QyF+e+?=
 =?us-ascii?Q?DY2Zrg3505Ik0P0w8UJFvNMYIc+uqat6M6IvY/8I90y5D+ULVgwGeR0ieHtM?=
 =?us-ascii?Q?aEOn4o3VRAJLU4qY5UHdEZO9VyB8Yr0cyE20LwhyJUB0OsQABhgJ+GNe3O1S?=
 =?us-ascii?Q?K45C/7zIGGysUR5cQ95kg8xxSr1RotBqRRbPrr2ippXml8HSS3Mg7/1Snx2a?=
 =?us-ascii?Q?b6mxt3VKGewWZcvSQM3SgX0oMa/17fgU0tbm8OHgqniDLXrZ1i5WYA/UCBrV?=
 =?us-ascii?Q?m8CfAVGqgk0BpnpBQXUAhaCPhvmiSc8bcsOuJaK0lhocCckB/mi0kd9JvK/b?=
 =?us-ascii?Q?BYaQqkDxPKv8Uwdq4tocPzjPKkJhzpzxjC+RfSfukujtkqIP5MVNlFTBmZbG?=
 =?us-ascii?Q?1UV/tPoWhkJSySroOnqUlhpMRBbH3daQrFhtP+0+Xuvsd6PCX33/j/i5LRoW?=
 =?us-ascii?Q?wfgUljnEnVQONDbRKkJf6flYCi8pT3uuSGHExGc7rGvj3WW/kuumbxJOe4dL?=
 =?us-ascii?Q?yF/GSCq8Ilpp1q6YtqeG4M+++hYymPxIyrTmA9DohutY57lTgz9188SLRfP0?=
 =?us-ascii?Q?JkzluX0Q1Tb19soY0yTxcrzP5nVfuuS5lyfU6DyPB675ZM3mleaO65Lw5sUF?=
 =?us-ascii?Q?SubOUytyrr8G4Ls031yhHLkfCPI0zePlr8EjPms8+pd43/B3oNbaAR8qzDa2?=
 =?us-ascii?Q?hgHJsyBshQRPqiQZ17TSIOxUB7Kd8y9f1+aLa2Jn5sgLwU5pdMYkwRWUoBmo?=
 =?us-ascii?Q?vS/sfztaP0M/UFnEZFWlKUB8EpnMlTl9ZdztK9qSIqlRWvEIl/Rmzg1bhFRn?=
 =?us-ascii?Q?blo1gO4pI+ZnRMPb0gVNdaRZFXcoNi5XRjqRZGzVWuJe7jNxK292Q8s7mGGl?=
 =?us-ascii?Q?t6AbBCbcP+QwpKEtAPqGHAdYS+7GS5yB9WID2Npd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71cb061-3b44-4406-4645-08dd0fab9407
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 12:52:55.5323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zma1uut0MhtzgOpi8hAKE6+Y28khoNaCobnHKeqZl9lENk+kG5hpWdVc+bLVjaIi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
Received-SPF: softfail client-ip=2a01:111:f403:2412::605;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

On Thu, Nov 28, 2024 at 08:28:15AM +0000, Shameerali Kolothum Thodi wrote:

> I think if I am right Zhangfei was testing with vfio-pci device assigned on his vSVA
> branch. But migration with vfio device is currently explicitly blocked if vIOMMU is
> present. 
> 
> I think Joao is working on it here[1].

Right, this is what I was thinking of. What use is smmu migration
support if VFIO side blocks any useful configuration?

Jason

