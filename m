Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E25BCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 13:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvc7D-0000Tz-Jp; Mon, 08 Sep 2025 09:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1uvc76-0000RT-VP; Mon, 08 Sep 2025 09:40:57 -0400
Received: from mail-bn8nam11on2060e.outbound.protection.outlook.com
 ([2a01:111:f403:2414::60e]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1uvc6v-0003dZ-KC; Mon, 08 Sep 2025 09:40:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/N+Bzeh2Z4tgmdBWe8YW4K9A4NS4hEGR1VdOhkc3pSF6LCLJAzECltYy2dugUSNJCth3Jefr4ZGZkv/XX7k33T73wOyLq0SMDnPCr8P2ji7DotjHfSpsera4RkA4PbAV4sqLBOJtZuKRt4nlHDWU0x1mVKrygJQutiHAkq0Bi9axf1Gh1MMqntynNEvTlYA2CcWdmAeNKo2FsbEjHwMOrsxBy15VP0dKSp+280SQ+x9gfE3YJ6lNng6jOwWH8upelGBXILRfAx//yl8GVNEKGNyBOpkDpxcuHzljGwwICfId59XvFtIgtVnYStRRg+789V8LbwzmDvMknQgkhXsDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yq8/dyx1iuQF2EdrQJGWLixG10qmHlPnDhMS5RcFu60=;
 b=GixnFC6BQKn/0cPyXkk/E7+ziMPdjmZ3bUNTfbs7wczVejIlq/LmnbPvFBoGCJDfKRJkMFoqJb54yUiSM5rgJEUoVU7BefnwlXLDAcClLrQ38n4umefUMaKYv6Yo2P/S6oy588/H2LZiPmKHxMkmR7Xs2J59H+5OJpWKZ8huslver05bEHCCvBzTzdLc2HgIi/TBMMjTt2J8wu0uiKRjB3CzMB2bnTqTXr8MY45enIj0DmCFo4f4XX+bag/L1VnSXjQwV0fsFMCfPacD1LiQMIKxObIkRnoow8t8DZeFkqr17Jg1bGeSXOm9q//OSQxsU+dK+6SN+ptclJnssptKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yq8/dyx1iuQF2EdrQJGWLixG10qmHlPnDhMS5RcFu60=;
 b=QtYhYr+frALCuOhmupJx/qztMJdZkNqopq27oVGZtCjE26IeFfWZEiYb4ZzjAQY4j8ESJEjhrgzs/ejR4N4bd6GVe9oNWf8dXM9qRQEmFioilb6kv/las2blT8T24SgCeMO5HkoLQs6kFcT4Y0MBtHOYKZjTnlx3cHwKyObZ7g9KTQnohS6AVpDZXnhcHBltu80HX8xbRkngFHu0UTlEBr56hPntVogZ8kJkjR2AvBq6sP8adId72lIHNLqe+eiCXTFj0MTi/GGsbPTTnlZWoTEWAPmqG2kwpC6p2YmMk40+H5GsZSpLdCXvx5NqJE8aGbF1s9Nw2F58vEQm7rohjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 13:40:33 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.017; Mon, 8 Sep 2025
 13:40:32 +0000
Date: Mon, 8 Sep 2025 10:40:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 07/15] hw/arm/smmuv3: Implement get_viommu_cap()
 callback
Message-ID: <20250908134030.GG616306@nvidia.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-8-shameerali.kolothum.thodi@huawei.com>
 <b13d3596-1498-462d-ab2c-1a626f050dbe@redhat.com>
 <CH3PR12MB75482B0418C01770FAEFF56CAB0CA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB75482B0418C01770FAEFF56CAB0CA@CH3PR12MB7548.namprd12.prod.outlook.com>
X-ClientProxiedBy: BL0PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:207:3c::15) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e0b499-1477-4500-6bc3-08ddeedd47f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CFMk3MxhKBWSggoz+qt0KX4CvKWXHt5lythQDz6lx6YvvbCwYV9m5pzg1wDZ?=
 =?us-ascii?Q?03jtp+rpzpxHdV9u9nfpmWm4XEGHtC9FpeuFwUbIKDuN/6570MepLOWaKkRx?=
 =?us-ascii?Q?rCaS/jyNUXEjeZo7944tJOCuJZz6x3EdpOewFmrNB9KN3x4loGIK+DAQhayX?=
 =?us-ascii?Q?8QFwQ3ld1sXT2FyZds03BtzZinWhaiqYWLfnu7QJmL1hZzJDqeGJLkfOuB7I?=
 =?us-ascii?Q?SpglhjauQEzo8hf+qtoinw4mXOWdXjhpiLqEV75DwodCrpEWd99weHaBTZP+?=
 =?us-ascii?Q?lnoMe1rjeFOjRNKRYBbL6C1t/KVzFGe2JLlJDQzL+aS0u7HU3vxHxiaspGzK?=
 =?us-ascii?Q?NU+iG/j+azVLlW01Pwn7uiCdyKPc0OMSwZG/znLBbw2FG8udPBiTxTp3K7wp?=
 =?us-ascii?Q?10pfUaNKtiBHFP9xwczLcjU5XtCle0LfREMqKhZzzPpfB+8fQNuzU02ER3pB?=
 =?us-ascii?Q?sPCv4DUEZM8romMmPajySGPUDiV5TYgrD3K6+DH0GFOanwbOr3EyU0SObTQ5?=
 =?us-ascii?Q?RKgH6Lf5IIItK9uFnjtgj971kbnU/j9oInCUthDFt+HbOEwbUFUp1pPvTlZ3?=
 =?us-ascii?Q?0PtstTRiM9EAe7Bo1qXjRf/ByqcOjBovFqEAHv3c9ophhUrIw/qO1Awc8hiO?=
 =?us-ascii?Q?mVfAjhSkJ1Dhmh+45opaDKXfQ+8S7HDe90MfH88XbX6P5MJV4Hb9jvizGW7s?=
 =?us-ascii?Q?uwFpnz+QhQQ+ahhZSrL+ve0UQZANSlY41kfdbdzUkPuiqGuRjdNOT+ZgulS3?=
 =?us-ascii?Q?gxH4Z3v5DuNY8bIGyTL8nfGEzPl7rmeAa/03tv0r7vES0ciUv/pGKUhUGf+e?=
 =?us-ascii?Q?yZbZPfZ4d6vnqW4xZgqw9W+vXb6WQ8O0lgau+yRusawf1MP5olQG5y2nEk22?=
 =?us-ascii?Q?q+UY2VZDffHT0ct2dEM+S5B7wiUNor+cKgZx0wwriQo9qZYkCuoob45NtYJY?=
 =?us-ascii?Q?olZLbNmMbpdbBzFVDxUpMTZAEU2PyoSy0d498JeOVuhmubgPW6hF7E/2QCIf?=
 =?us-ascii?Q?CpT6k/z+a0kaYG/+7BeXwYFb9XPE5r7/Qt2jnUOWhDTYbHLuir5LPl8fAQIR?=
 =?us-ascii?Q?nM0XMTI7t8i0Msg0us3CRPnzGCqWF9kt1bMF1cM6g5bpvaLAmviP3adJ8bGx?=
 =?us-ascii?Q?IsgMKsROL4wUjCcjo2PU0lISKHZQyhcGYKDPhg78WcLUaZyHKflsLfZ6vKZj?=
 =?us-ascii?Q?oqS1XkIABJeM8RGlKuPFCv3Cwko7xvy2leH4ecYSVz1uPMmNrKfbuxhq33Iv?=
 =?us-ascii?Q?ilbGcsdflG4KCOP2VtBZNp5UAWH+TvO1EnkhbTUmlhoGJysgxcyGoGbqeNVi?=
 =?us-ascii?Q?09X11xE6ZWD8yY16dsu0tYOqXQM+mMTxtt45Ju0+1/MwHPB8TpSVlIthdXub?=
 =?us-ascii?Q?+CRBmsDtzy/fQF1f0Db8YUBnlWxUVHy8WiPvXSQMbZaVlRjyfcaMhCalj0xU?=
 =?us-ascii?Q?NnCMFe1/71A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5757.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZsOjKpIJnCY/qL/jOTPRCWq4OJ+YP011oh+poMEOYm7FntSiUaK0PX/MUX/f?=
 =?us-ascii?Q?Pkmi2YNssFulJE1HRIFItdPgLo6QjFEiMu1phntQGo6KvLeSnDR/qNS3j06a?=
 =?us-ascii?Q?FLv19nDwTbfmO135e4GwHw6QKXC2K1y0L7/PaXvVk68IRr8ugNBALt2T33nk?=
 =?us-ascii?Q?CP5QcA6jSbuqCVJn6SDINBgPPfLlAYEkDWXMN6id72BiR6jtwIGckaug9187?=
 =?us-ascii?Q?p8QZ3VpjK3MfpHZ/dMUp9Qx9EMS1FmdouzqWnVTScoZ/mgAVYMo020WfDSyd?=
 =?us-ascii?Q?j2Xje2DYr9ZCQqx7ZXEKoFjKZ9/S0QPuHGA7b/J10mbjGYtWhF2uyKhiMo62?=
 =?us-ascii?Q?scnApDAT8kIu1zC+aw3PHogzqHPfE476EHPysoiGownOf/0AQrd9VpFHhp1h?=
 =?us-ascii?Q?yB/AZFIqq4EJ3XYdRQgbfXqCrcB775urPjepJBYCSD+tbvJ1zxIrJ59eKfPP?=
 =?us-ascii?Q?KexhSYLa1UunEjpKzkSZh+nsCPYDq9lf7kp1g7BsUSO6KWYwTuS3ZoXMwQ1I?=
 =?us-ascii?Q?cw4Ob82nxSno1RPOdLZLqtnNVz/5+6JgSbutvRgjdKkvO549OQTRWoLaSo/V?=
 =?us-ascii?Q?sf3Pae7jb4Q4tf+RkrIq4Ah2xybcQGb7BDSFONK60n3WIsmfSdVZMJp25gWa?=
 =?us-ascii?Q?gSuE4Ild02TTjRBJhXiQdvYazEKmzRIUk2LzF/qnHCoyNw8t6Is0J2UVZKzk?=
 =?us-ascii?Q?bvOb4ozvqX2v9w4cKczVpjE47zDv+PDuhOnldMKp0sEnqxzNYfRmc0dYwn6W?=
 =?us-ascii?Q?VBbpCnd+woVcW/nCPgutDCOtpucmf4wT9k22o2PD+nuZHClRNDm06mYMLF8O?=
 =?us-ascii?Q?OJy8nU97VCGPg7+817Jn3txI3454yqbdD7S5kfmr3Hwm5iPhSLi/NXNWML7a?=
 =?us-ascii?Q?qFeg/EJCeTbY90kh0CLHaPwYnnOlrmN0Y13KPlP5YjuDbRn0OvGfC/1+pEcC?=
 =?us-ascii?Q?gbQV4ufEtTJmhb44eyorXRqyKOh8CHdRrm/uJqhwYDPGz29lwQQPKoRzuRD4?=
 =?us-ascii?Q?gA7l8bZC1PCOVUJaQRHLV5Ab7poiYV2TAy20/fKIhCgq8fOPekCsmjuW1jn+?=
 =?us-ascii?Q?/It47jWw4rI2UJToGUlw7aD5t2Z5CZfpMdybisV1MAbb2pcYQD4dvbChpbAA?=
 =?us-ascii?Q?doMK53kJ8+54/VgNXMir/t272zqAHo72/nO3ZeFlokPbaFO/AM6/a3vmN42n?=
 =?us-ascii?Q?r3ck4+hhhAxoDJ5K+7D9qHuaOZ/9pZx/OekLkzdjtVlJq/zPxyMgUsoOHBd3?=
 =?us-ascii?Q?AKIlXmFfwS9iAfV0uyViwKbnhDhaCXhtaZqApoLOaaJ/KHyTF+L15ytr9D8x?=
 =?us-ascii?Q?oF1ZQVRlf6rNh2oSdxcX2DwE7SMGdqb6J8KGJqfggA96d/DeP3Vd0FTGJXp4?=
 =?us-ascii?Q?JrMY6SGqhRUvsxGcFYgsGXOKWh4ATS0DtHiWwfT7YU/+f/O8d9VJ8NSwBlNK?=
 =?us-ascii?Q?nDymj3LkemoLXIEKnav0oL1Sb8+jWtzegXGu7tc6DvD+Xl+yJfKxiqp6rope?=
 =?us-ascii?Q?9CIEYszA7sy1S/p606ga4m5JnB51CgdMiHk/VSLAnGYDSk2pJCn+y0ja3AUL?=
 =?us-ascii?Q?Efl401lBgNbx6+PfAQk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e0b499-1477-4500-6bc3-08ddeedd47f7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 13:40:32.0625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Oipa6dCdlzAgAiA9S6RrL3czeOAKhq6FSQmUaBWE28cc6C0769I5UuUz3VjKhzZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
Received-SPF: permerror client-ip=2a01:111:f403:2414::60e;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

On Mon, Sep 08, 2025 at 08:22:59AM +0000, Shameer Kolothum wrote:
> > nit: strictly speaking couldn't we have a stage2 being used at guest
> > level implemented by a stage1 at physical level?
> > but it is totally fair to restrict the support.
> 
> Yeah it is possible I guess. But then we have to use the S2TTB to configure
> Host SMMUv3 S1 instead of S1ContextPtr which is used now. 

S1 and S2 have different PTE formats, you cannot take a guest S2 table
with S2 PTEs and have the hypervisor program it to a S1.

The guest must see a SMMU with no S2 support in the IDRs.

Jason

