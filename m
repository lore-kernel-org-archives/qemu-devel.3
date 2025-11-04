Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946BACCFA0C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIiN-0004r3-Ev; Tue, 04 Nov 2025 10:12:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGIiG-0004om-7V; Tue, 04 Nov 2025 10:12:48 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGIiE-0000yd-OG; Tue, 04 Nov 2025 10:12:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ecyuo7qXqLgC5NCpe8MlTy2CEgCY4UI1w2HZXZOdFK0zcZEBdGo6TDqX2PO5uXnfeb8sy5slmwmmSO8I6p2TiD7bo8ak5thn8YIammOCBwTvZGvgobBN+N+MwPOm43q2xJ6GYAevnX8u634R9PokfhLqv7gB9C003Uf6qO5fzILMxRVU8RICrcskrtkBVbV6CkstMal7FtVpdX8lPYq0ttwORkP0iNTIwHZmDrJ1tyFvhshcAijbPO83o8noSei9AZZPn1+Wrf6L1C9dAE4J4sPmFEbHRH2fMWjj12Mwb3+4XnhLdUNQTMvA8PU9mVmWmH2IAgKWQVaMGqwGKGC9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUWS7j/AvHBWCHW0W4suV09Lq52gs/8Xx2JUPzojjsQ=;
 b=ZCWUVzGxavOBf/6bMSWaRt6OzjaEAA04TckUOl/rcNuMLIA8dvNwGDq1uMvv9Dh5Cd9o0D9ACRWiGVxR/boJZax6IkVVZtimNMhnO+xoelzIXGFIkKSt3rFv6RUYx9tComYPa2n2Ucy4YtKohSOacM9MqdMVWbWyPCUeLutQSMPbzvori9R8M7Shz08s5BxDYG22556Vqw87yiVKhgTn022EXzVecaKKRNVu+8IjQWICUPvkr4i5lJWyboeex8nu57WCauZ6TK3OO9fw4SXPSCRVQRcWrP64Mh+m8usGHRm3k94ADJJ+q2r8HPlain8N9RieJs9NxoOuPEX8zCOGIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUWS7j/AvHBWCHW0W4suV09Lq52gs/8Xx2JUPzojjsQ=;
 b=WskEtwy5zlVI/MfuQ685M5Jq+HiLG7kCXFQAMUoGWX84L3yheKxMHoUml6LkeT4bfTH3gFW6ECai+BrR7nCL/p021rhd9xmbeinbQUNWdx+btUUopnNJJdFuzpdbiy3FFGJVShj0z/0NKvuCnWZRDceMq/RmTOgX4I/VSrGC00r/excENfX1Um73+MYOjSCoufnjml4hbwbpcq8xUJX8FfIOuYSm9egraOAysSEKDha4jDnpCvYOsc3mnBOb6bQeIZPq8fBTgKPvJNiUIYLg8huNH8baSw4+rBWti7fgdw/PHW8orHouGH44cH2lQbybGavE6iUAzaURWLy0WlvP9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 15:12:35 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 15:12:35 +0000
Date: Tue, 4 Nov 2025 11:12:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <20251104151234.GG1537560@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <20251104142052.GD1537560@nvidia.com>
 <CH3PR12MB7548E5E1A2DFE297C4C65E0AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104145157.GF1537560@nvidia.com>
 <CH3PR12MB7548379E64E7A12904B5BF7AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB7548379E64E7A12904B5BF7AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::27) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 29244b01-b273-4b56-2d01-08de1bb495a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?75dV23Xd90el/5vDAvbdqXQM5aJBIQMeK7lZQh3K4Tav/zYQQ8A0V5ngD33V?=
 =?us-ascii?Q?c5+QfhdXok75YKRSwMrRS7ZiUW4TurOdtcXJ6MP64FIs1ijyM/md0Te5hAUm?=
 =?us-ascii?Q?XlbrqWvek4mvOXp4/faTcJqX0cHMjq1yNviWmCHVzfm8mk10tTIhVoXGxXBV?=
 =?us-ascii?Q?U3jNJDa13aY6cYNrkbHMHHYv5Giu1CnVgnU8VEaWoBiIPT1EXTaYwRIl9TQS?=
 =?us-ascii?Q?CIB0RwS+MjnrPjLk/FLS1oNi7xbSgwq+ZgHDphwfZH01jQjsOjsxmC2IVZsG?=
 =?us-ascii?Q?vAvFodCcjwdzJiNcoZsHNZ6qj9jujrGhxtSPuWxga+GZZcFi/gsjhqiC+xgX?=
 =?us-ascii?Q?lmnVns7Ap5daixplaxz2gRH1my41bHfJgznJy8DT74XDABtVuJNYA8Oc1ve6?=
 =?us-ascii?Q?H/rtp5gqQPq6dHwCF/2/gV0VfdTnM6SXEEJAx6Z1mJ7G2wC8YOcaiwf4QbqX?=
 =?us-ascii?Q?ZzFDF3hmzdfN6tKjP7IUQaF4YckUE+V1tEZX17KVeHDLOs/2zDc3oTdXUgQQ?=
 =?us-ascii?Q?spTUnDM4Rq4a9ME4lyxJPhKyNmgFMYv8TFLZDuUCMMyqjTAaWkSEdPhmnEsL?=
 =?us-ascii?Q?RPH6G2zBWi3topkeSmXVPjvz+PaJwtr8OcbI5u5thiGC5EFDd1zfyJrjXVPl?=
 =?us-ascii?Q?+4xtnwVvIyzxxHeQ+a4+t4jjRXU6Diu84j8m5ytFiBMPg2v4R6LKyUdkNmDJ?=
 =?us-ascii?Q?nV0PPFLmyG2BwyATP0dxn6rfUIJbNvRFiSFE4m1JGBXNBgmIACwfjzYCcQn+?=
 =?us-ascii?Q?eOy+4COwy44TiM5+uOp4zhnMcWH3DMA++Cwu6HxdKYNm1xgNnwRQ+YEIt5w+?=
 =?us-ascii?Q?ZC2xRF+PAIqCfKv5yfyd/CvWexoijFf2JlpRbgkGCk74xkDIq24E1TEX9ojH?=
 =?us-ascii?Q?qyhV0kmt01O35gqu28wkDf6iQmIUCEdw8Yv5y5w4ywcQA+PMqVKhP04GYSMW?=
 =?us-ascii?Q?U+VkIdsQCUT1Bv0XSBpFEktXGqj5zS+5UVFCHusLeKQP0kZkNnl+HKHMb9EW?=
 =?us-ascii?Q?oBhYHI40MOVwBRM7Wicvedobr5XsWOYiKRQwugBB6k+XQYs1sReBLkUSQm2A?=
 =?us-ascii?Q?USLcfBBhDw/e9bXr/t3kuLebXCM/DFn9G0Mr656hLG/bGfRPuh1oQ1N6cosT?=
 =?us-ascii?Q?kzxOHtZ5dKOuBSas0TCxap+iZCyL0GSogKyzu+58yEF7BQvcM2k1nx3N2mQL?=
 =?us-ascii?Q?UcSmP1SSpe0STj9gTc1df3wewek6gk+6LwkP88HHvCSOKwATxiXK9OFMry3u?=
 =?us-ascii?Q?/AeWNGFTL+7kOlV7MNcAufYZEKIZ6JYxZhmhCB1Cl3+rohdrzqnlL4LY6dSJ?=
 =?us-ascii?Q?fZ15seFGDZjZmK86+8wBTq9cQNWmi/UIIJSHHTC2LExnUxke1aAr1HWs+bEz?=
 =?us-ascii?Q?/BfdL9SiGYjGSKyX8IssiYBl37ptXngiFWJ4ne2dX3IUYwR25I717o6CfGnX?=
 =?us-ascii?Q?SXfD+9uRyy7feK0aahPfqY8hc0gd6+ae?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5BQJttuIUJ1xmDcDOw12TXssK6eI9T/vDMDi6XOBOZCFqNdFg58drHmBk1lR?=
 =?us-ascii?Q?leN8nF/pJgC47vkbqNsril/vE8FxYvLQ4cazmxGgOQbmU8jZRwZW/58/UIje?=
 =?us-ascii?Q?7LpG1q/bHMPkqgyyS4eZj9RSeOrhSkoTJxx/jKQP+mlcDBKwoboSNYQW1pbj?=
 =?us-ascii?Q?Q923TBXsElap4y52bmKoz3VInnnnzNsv7Dui16MAvZLDhJEJ0oGHe717dGWf?=
 =?us-ascii?Q?1V4qongkTJOJQSc03JXcQ0o+IEublx4Hl+OzxKpkUA+M5U9bKeZxWYLl6sbG?=
 =?us-ascii?Q?QJLqUfaFLfZt/rCVaxSbycWBT0FKNoU3LLiGNlE6Pg2REHpjboypXPfXzAR+?=
 =?us-ascii?Q?EE/DpaeNffVSE2BUqr29y8J6bb0R14y+KTd/mVWNYxrGPxs3u7Pki4yUovXx?=
 =?us-ascii?Q?0Lf01VGoYqOBSp8rhnkoL4kp4csfwcM5l3RkB/sYGV3QFemMOT7t7lXo2LUE?=
 =?us-ascii?Q?WanXNlsbv0N/ZRxEhW6RbeLl3uofR6t5fapOEdfs0drcAwuUziknqdRQr+Ky?=
 =?us-ascii?Q?dJKIGJaMk+wCBtFE8zKyq71zTswXFq8MzxnVdJpKQzxU35c7iHTjpyy84mXj?=
 =?us-ascii?Q?3XZE5B09O8smB41m3uZOf9olTSFkt1X24kNn0V0YuuuqDUH0O9B4cj8rCRhi?=
 =?us-ascii?Q?q1NEAa0fbZDxrvaaGbklonL2L7uUaM7N2hrDOhmXHdG3gyO+XF+unCOUia/m?=
 =?us-ascii?Q?j+orzVEvFCcXodq1t9zYVAMpzT2EHSUNVCB6RQowTubAtjvp1fIs2bMfwx34?=
 =?us-ascii?Q?n7x8H7AuRbcTXoyIS/tGnUzytUV4zZXYxyd3/jIcSWeYWFcRKj9gPbp4YkX8?=
 =?us-ascii?Q?liDjQTBi1NMeebd9Zz8CvkizvLyGE1vWOaUG4fPhTbq/ImJEBhkovV6jdx+o?=
 =?us-ascii?Q?JmsHfVs633SsrQRkc43fCamvbyF8KhLfJyNTIgbCDpmXFLWPkuRBBcao/Dtz?=
 =?us-ascii?Q?B5r11R/BXM5GM2FdOsySOGC4ne1irgDruXRNNgTJDoXerInuOgxiUzmxrDgm?=
 =?us-ascii?Q?/coJ0gwFjSbzfJC8+wKS+uzk2wyQV+n/6Z3OSOP8EMUdNih0g1Ds4HgJ0JDJ?=
 =?us-ascii?Q?YQMWubUPSCutfg+dZCtjqnzJl3Za8Xh/S6+ZCfVUn/Bxl3BqFsNA9n/JJgDc?=
 =?us-ascii?Q?d3ck7GLlaBjCtF3mfcznSo25+y6Mq3jgq4QQDWoFSqThqSBwGJpasbBJsv+B?=
 =?us-ascii?Q?UN4rmwNGr4GTHwBlk9amyju6dbaQbDlXggrmRw/d1oWYpeAqFEpHo9wMV0tH?=
 =?us-ascii?Q?fQei5DOhhWT29x7xunAGIfyglH+XqOIY9z8DE4IMhoJE8BqJ0N8vsW0G586o?=
 =?us-ascii?Q?q+hvdYAZ1ZPbKEiDr1T+kqv8lo0tB5kz8QVDC7GlfOx3JbatpmIr6gJcFhLv?=
 =?us-ascii?Q?wdl1o//D+3zoYO2r3zDjwyU4tdInT7pkVmnf9YLcq8SUchHQLE2UoIvtaxMb?=
 =?us-ascii?Q?PZ7tAFh/UKIjTneOfJeH3ken33mPPv8pbfJHPcjhiVqP55+hKxroqUm5nmha?=
 =?us-ascii?Q?oGzJBplpJmHuZtnRIR3J1Kk1JxNO0dc57b7vu7vSLKuS57655bKm1UPNVJs+?=
 =?us-ascii?Q?1dfapZ9/lXt7DAYmJrY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29244b01-b273-4b56-2d01-08de1bb495a9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:12:35.5158 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iPECcGKYrXbF+cqCtP400RSGQS+LTukgNzqifeFvJzwFAn+YgfESqwvyvKWttzA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=jgg@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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

On Tue, Nov 04, 2025 at 02:58:44PM +0000, Shameer Kolothum wrote:
> > Sure it is trapped, but nothing should be looking at the MSI address
> > from the guest, it is meaningless and wrong information. Just ignore
> > it.
> 
> Hmm.. we need to setup the doorbell address correctly. 

> If we don't do the translation here, it will use the Guest IOVA
> address. Remember, we are using the IORT RMR identity mapping to get
> MSI working.

Either you use the RMR value, which is forced by the kernel into the
physical MSI through iommufd and kernel ignores anything qemu
does. So fully ignore the guest's vMSI address.

Eventually qemu should transfer the unchanged guest vMSI address
directly to the kernel, but we haven't figured that out yet.

Jason

