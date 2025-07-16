Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EABFC83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 18:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc75r-0003mp-ET; Wed, 16 Jul 2025 14:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1uc75h-0003fN-CR; Wed, 16 Jul 2025 14:42:57 -0400
Received: from mail-mw2nam10on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2412::625]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1uc75b-0004Fr-Rq; Wed, 16 Jul 2025 14:42:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEsqtJ5GbRzCyhZ9x8oe2N0RQZELjolNfJN5sAwEqdUghBJrD/+v6mSiucoI36WKVLVmiNdy54A2P7OPiR6SNK7NgCD8yJ1nFhW8K2QBwdcc2p2WpuAN8L86dzHEl7fTd46ldyppkQtSPB88d9jLDE4jqZt5BLEDWDWd58WmFHTr7Wuhdzyqf/d8HLvh/kg5qRnQ0nwFciGM4GWzm/GHa0YUMfnVt7imMiJ4jWAEzOJjH3DPbNMDR7Nzdlq4hkhWBJr8z7SsUdyXyyNakj8lUUHaLkYnSvFQnS4WjCEBrqWy1BCfXWl5NykyU5uCMAIBe6rVxbZyW7uQzhQFQ0NYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoD5TesSRdyB2DP9SBX5uNJXaaHXAu65Z6Qp3LZeZEY=;
 b=Ydae52ZdA3hCou28JBVPTUevM88nsYSlS78LT3OUxP4W+h6XTz99eMfllaiD9A6nCHW7rjJ01WowzNoBEV04XwLwPDeBX1SxRqpANlipaDLSaW+2pUWB6IfBXQdsbyv/QYVfTBRpRMDQTWfti3OmfOI9pG26ta7dTMXiuk7dwkfG6BMB5Qhv6wAdoMteofdy4OvJH9QdN5QNkNjybQeweeCfNFWAKalajwSRmSXd4ShSOivLdU6qWR+E8Yde+x4+cY+7u37tZlA1D5JXWWJ9acuIIp/wInkgPLap+8mYWUymwrnHt6qKab4iu83D5fTIRbgYpPOuSB1JGZFBxyXmbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoD5TesSRdyB2DP9SBX5uNJXaaHXAu65Z6Qp3LZeZEY=;
 b=FMO1+A0Zw1vgbv+h5YI3GmU4JnnwjXNVPv/qXJTinPml5YIKHsO+izAl0VHm+TfroI1H/nftv/LNzaMTAC0zVtjtWkQwOpgMqyrrLhFaoOMCY3c9piNouw2D0kpxOPhTfoH/c8xBEF7BOe1fQX/iOHtrZqDODvAoHd0JqB+z/zeUAcvMrlZXvJfMcZpRI//oD+kvbxXOVUo8DMq8MHglyDCiC8I6NhoQMdn5NYNZEOru4SFhdAsNloa/ZZjr/tjxkSPEvLi73KLhM7+1t+QtVpgUPizPg8PmwlICeMVMiOGOs7VLGjDXX30lYMb6SJhs71UdWqLHpDvqpx8zcH6z5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 18:42:40 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 18:42:40 +0000
Date: Wed, 16 Jul 2025 15:42:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 peter.maydell@linaro.org, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com,
 shameerkolothum@gmail.com
Subject: Re: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Message-ID: <20250716184239.GC2177622@nvidia.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
 <aHcVNYtd9qe+sHAT@Asurada-Nvidia>
 <20250716115123.GW2067380@nvidia.com>
 <aHfi3SS/V6qlx77H@Asurada-Nvidia>
 <20250716174506.GB2177622@nvidia.com>
 <aHfq6ccB44yupGb1@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHfq6ccB44yupGb1@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0294.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::29) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0c1198-995e-482b-afe2-08ddc4988acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nk9tRwADb/RMDug7ozJ7YnI2sg7v656i04HOuZ7IApniSQ6SKZ97G2nzUJDD?=
 =?us-ascii?Q?wB0NNembRbYJTn6DExOa9MhSvMGKVaD2pZgQVpRGkLD5GGrryrMNXvIY1dcG?=
 =?us-ascii?Q?h1FTXdlUad4fn1LrD+wrE2LcQjaxtwmijcf+U8JM7RgSDyb21xM197Jnh0C2?=
 =?us-ascii?Q?YTVGz+vrO0Z5DRDinkeXBvm+HCAF002dZGqUywLrvk9jyTMJnslz+oTBCRjW?=
 =?us-ascii?Q?BjmC5vLCFJNeJYlK7Gq0z8m1g8FwJRVyH5KTKmilotxP4dd5khdPhvh/BkG1?=
 =?us-ascii?Q?Tef57Ll1TDFb04ICjwlBC2Wgx8A66JtJhEzZkC4ppbpo+K6GvlvroOkJn2ay?=
 =?us-ascii?Q?N97ZIKw7psbJ2cp4iwOjf/B3cL/9iQmlvOEVQ7RdanQe4j5X19xcCytX3xpe?=
 =?us-ascii?Q?uiJ4T+74ce+h+3XXfAKiREXYylJO+Ho4EDA6JW7a3/K0Sbp4iLqnsFeUr7Ef?=
 =?us-ascii?Q?fi+2jfrIBa74XdkeFuV4EId2tIPKFE7LGk7M3EwFkw1SHGIjFsr6z8dAgEtK?=
 =?us-ascii?Q?Em1Jksvk7Jrpv1yQScgdfztAcVM64S2dvOhNFRNoQ3ocI30APsVtumoM9LTP?=
 =?us-ascii?Q?9dRds1ltFe9K/XzqsICTogEslzqGkhA33rzxOGIUrT6+7iUVERHuzfONFjU2?=
 =?us-ascii?Q?0cfSiZOGK2Pd4wAg/LOoA83bI23n8u6zg8o+jhtcXBK324t9jiQbWIKFlL//?=
 =?us-ascii?Q?vorCMsdHvd3Cqt4XpfDmKqBKg/ugE53PM1SjhnqBQ60jt7WkYYP5u7cC3yoQ?=
 =?us-ascii?Q?P0qvGCEcSx0ZMbr6i3DqAfPmU2IJyV5N7jj5ZOIcrnS4yWlGMUk91Bw3W2iO?=
 =?us-ascii?Q?63pFbohKqEAE/qZEuslLZqtoz+NFPgD41zCB7kFyb40E5R94LKwZt3qaXm76?=
 =?us-ascii?Q?vZq6PRYeal7rsF8bTtVEuwJcZP3q795sPY5mHOe2xRXSfJUsiElgbLjUw97a?=
 =?us-ascii?Q?EfJ1TwR8UJnt/XTiZi9rS5l5WJT7qb6BNzkV36/xVvHBtuYB3LLWoUcg3dAZ?=
 =?us-ascii?Q?zEGj9PnaowQryiTRAcGJeVlhQ7omEydUOVLsWIUE7wSPbHDF/dgD5U3fcvrY?=
 =?us-ascii?Q?xJ4zEIdAlD4PAs0dI2H1MKKl52q+8h1CPM5N1rrAIHgA5XhtoB7ucj0CFhWB?=
 =?us-ascii?Q?gNAKlOKcctJ/M2kVdOJPV3I/5I6qzJdJmP09nFIrPrq5lK/D6fhBnnE1XVEU?=
 =?us-ascii?Q?y5n1PQYiwj3nDMoSjyoMX86WFtXSNJrsBTgnlWLnXFRNNYu76HA3KjeB6aHO?=
 =?us-ascii?Q?6xdfNhyW003SjBv1oXWLTWdI2QHeo39YiNxwct/rcgY8z+d9pb1kdrUGKJ5O?=
 =?us-ascii?Q?xdAmM/MH78Y1GycTC/Q0Wcnf9LpHzCpPtO/zMxAPBZLusZqJ0Gn5nibYEvO7?=
 =?us-ascii?Q?HdRDfgryHtLX4fo77woDpcH+1odIQqLrF/NV9kxDQq2/0lwsPQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EPwQtb+QPbU9P5tVLG9Mxh2/GgFT46oQgD/3yPvZ5vkGvfyrxSRaCM0ItZw1?=
 =?us-ascii?Q?wjEcnQuxe3Xzi1sTl6k5ukBfOd5FJE0Ft3cGK6cbkzPpo+kEcTtGNxKSD0IC?=
 =?us-ascii?Q?gYRcIN3lYbkS29Y8KpWJL+DfzhU0H9uEDz5ED1/Li/XLe3olsqde7hksIHGn?=
 =?us-ascii?Q?pIkgxycGsSeuYM1jXHzyw5Vk/eOCTx+J1vSnYP0TE8mFXLi9ioVQbZXi1IcL?=
 =?us-ascii?Q?nVY2+1XAb4QUUxl+UvCy9Fx02HWnicgfgY07X6y2O2Yfsj9zI1BlCQMdgNrQ?=
 =?us-ascii?Q?niR++y6lCD8c9yg6N68SRSJUwWMFHzEEwyB+XL996EuKYHU3SI4gFeDYp2rz?=
 =?us-ascii?Q?NHjLFP8/VIseZ6crw9f7kUHSNmOxfzDt2ZrubFzaruDrlo/ASWUKY1F8d8Vm?=
 =?us-ascii?Q?EBl/DSnuKPpMYD+RlCLvE5cCKazCKCaXsO7zUYsJccZf150DhfDSnEmsqClH?=
 =?us-ascii?Q?qX4w8P8HsCur+CWDydxMI36bw4m8bKBhhpV8TDP+YeS04LStXPsDR83wanPF?=
 =?us-ascii?Q?N9x8SZUqtr5yInpsEMVJjYukjLZW/EbaWT4iRNkht6hVAwCaJoyw9sb9HYs6?=
 =?us-ascii?Q?A3bZ3XbzgizOCNGqtwi1HmT6Rt/keODV6BnwqzjPYVKnbNduL7Tmgvp+qKfq?=
 =?us-ascii?Q?gMy59cq/cTcpIgyyyLEq3WLVSn46PlhXlIIsDItjNQPWnuQ2+C2lYPZGMKW9?=
 =?us-ascii?Q?CnW+WHpPPvRh182wyaypQXESzcbAgaAPwDCT/b8yEKbj27+5kCFvjECjLr0b?=
 =?us-ascii?Q?KbIBDEaRTlbbCnInQGe1vqmoNa7zxqGl4K3Nmvz+Ng2voAPNmPPRLunIFrYj?=
 =?us-ascii?Q?27iFvp+H6r9dW2PmxBsLUFp/I2nru6cCFZpPtiMiAy8+sAegnA9OFCKx+8+i?=
 =?us-ascii?Q?vq3zNEhelKNETsGO3r692vtU+glkdLVIPLxbGL4ijmc5Y+qkF+gp9nYUf/vI?=
 =?us-ascii?Q?OVmZ/eXT7GmjMckw0YTEiTItHmyiSNRx6l1ZhlQo3os0vUlgmQY99UvQNJii?=
 =?us-ascii?Q?73agICdLY/lMGIztBlRhadn1pSaMqElxryVRddaBTPpRKu+KYAq6jGl0qmgO?=
 =?us-ascii?Q?jOTQyzQdXLHp18V7MIlE1GuNGbE9gXIDTE9N4BmoBwtoESjNoVKN/KaD24uP?=
 =?us-ascii?Q?S+vh9pZfzEAXAeBb/QstI9KMhP5AC+VxXvr2k1TDisL43IHqc2Fp1yZsjE/v?=
 =?us-ascii?Q?W2dGryPyG9OMmwSCaVTeLV/0EbkIjkcXwDvxqLKzt/8QxanJlzv11fA2uKnF?=
 =?us-ascii?Q?twd5UN1Irn0bKtaA/VVyDduty6QOefmbx1wV3sCTe/YBCJQnDrpDyx9rPycw?=
 =?us-ascii?Q?+vl1XV7ERIYzADwXvrYErBHfx1X2FglTEwlRMm7NBi7lUyJ2/b9x4EIyQsKb?=
 =?us-ascii?Q?5h4bHeMImT7HvH8A6z9tP5IoYS+C8+M4szSQstisp7SSWl1hqLeW3dXQp7FR?=
 =?us-ascii?Q?5SO0NkYNJCqf2RIttXwYXsZL8XyFrHWwlhIZ85bIICDhax0ztlxv9MRfwDuB?=
 =?us-ascii?Q?jaBSN2401R4+guwG+lZ2d1YgBueQFV0+nzzD8fyIyZFHN9B+QbQcIc87cuIe?=
 =?us-ascii?Q?EMAQVf6MpL5q7OQXQotdR1UBURWXco354y269kbz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0c1198-995e-482b-afe2-08ddc4988acb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 18:42:40.2470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fjIznQhzBmfSYUidKOxEY16DrXjT2R6+uq5JvZWe4dr+NwlFhVyBjAItClEoVMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
Received-SPF: permerror client-ip=2a01:111:f403:2412::625;
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

On Wed, Jul 16, 2025 at 11:09:45AM -0700, Nicolin Chen wrote:
> OK. I see your point. That will leads to a very long list of
> parameters.

I would have some useful prebaked ones. Realistically there are not
that many combinations of HW capabilities that are
interesting/exist.

> So, a vSMMU model is defined following the parameters in the
> command line. A device (and its attaching SMMU HW) that's not
> compatibile should just fail the cold-plug at the beginning.

Yes

And if you want to do hotplug the SMMU is already fully defined so you
don't need to discover anything at VM startup time.

Jason

