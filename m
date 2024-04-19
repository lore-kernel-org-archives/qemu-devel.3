Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE82C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 18:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxsr9-0000VU-Ir; Fri, 19 Apr 2024 14:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1rxsr7-0000VA-NC
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:21:01 -0400
Received: from mail-bn8nam04on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2408::701]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gregory.price@memverge.com>)
 id 1rxsr6-0005Tm-18
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 14:21:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuduFeb8rtYBxpwZh/OXAWV2tvAf/TmntjprXObzjJ56Lh0VpNRqV9REGdADlnPixISn8xIsGI81Pl5MsC4aQ7G4VGgJmjQ0rQTxvAhnskWTxxLw627wJbVsYNnCIZijoTUSQXXTtxAT3hq30gb2SLwvMLJdMMSC/SqMHuF3+A6RYlT6XAcT2dbxWGoraiQEmZ7qILch9k4tv3K9+NuUqlWERd4RGv+ol6099cPYytvMy+SIuluX4H2VYtr4CB8LFeM7pfb9Sw38+1QKkXDVmewXHaCj13fs1n38x4y5ufIrIw8OEbJ4u8iZNokjTDIJYiAOdS/p8yyAJJ4bzp1LSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCs0r/2/uhqxBkplN0ifnY7O4GtejURJUkLlP/Ny7gc=;
 b=ExhQcOSA+1fWICUyMf7bDneDTeOGEldizJRA3viabj35WMHf4Gw6Mw4iylM9rdNf9tD9TY0W54UqZfSRFvurrFl4+r2W/E36PvQPpBIuYklzx8mgPhNu2OK9E4gtuVW6arD6w9QuPR8Hh9EBGvuuuszNFPxNk5FDpAxvaMPgk6vdlM6cFrUOMEZAjeMZjtnT+mXpYd5TBLvBdi9xQc2POSv/2UotAFWrVaguW9m1yLSLDQ1iRFtRyJbGpBVYXo0qVGpAnWM3FhVAznpwS+79hFnNi9/Rpz52ttrp3wC5s4bz4/uZjKzcwyjr4rLXG459MoLGuXrI5I8O3KI+QB6CFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCs0r/2/uhqxBkplN0ifnY7O4GtejURJUkLlP/Ny7gc=;
 b=aBvr9ywOK7Ad46jD3lPWeqV7xjL2ousnWr9zkGrkmFAZIAAoYm/8RK8OAPRK72kqgV8uqwEmjOIvZgTvxLlN5wpJNziVgcrtGRiW/FAgkv90LLkdFidQx4ZSQTVsD9x990iL2qOs4znpvgoksyl1zTXh/wJpLZcfhu+tfZvFqao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA1PR17MB5569.namprd17.prod.outlook.com (2603:10b6:806:1c8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 18:20:56 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 18:20:56 +0000
Date: Fri, 19 Apr 2024 14:20:53 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, ira.weiny@intel.com,
 dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 12/12] hw/mem/cxl_type3: Allow to release extent
 superset in QMP interface
Message-ID: <ZiK2BVe5C99gXw46@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-13-fan.ni@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418232902.583744-13-fan.ni@samsung.com>
X-ClientProxiedBy: BYAPR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::25) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA1PR17MB5569:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d430d26-d891-495d-1b26-08dc609d74c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EFlXxr6z3OP2OSZN9nsSQVjjuKzwoxb48V4Tdzf2yC/l3WPVhmHsQ2T0rcZt?=
 =?us-ascii?Q?q2vmd/bgtZLTw0axVOFOFnUq/HjmNc9fNq+3MDNAARM8Ln+Tp0xG+LOYU+rF?=
 =?us-ascii?Q?qI0EmJi/oIjzGZCFZHDeSRm8vLM9Rjwirr+zaM4rPqfnvu5DIwFPldr8qe7n?=
 =?us-ascii?Q?ncaWttvNb6seeSqthNCwCl0MAFQlD5t7u9f/D7/On+QEecIBogLlm4XUp7tj?=
 =?us-ascii?Q?f9vroe03VK7LB3IkcaEs4lDKKGHHDqRM2vEbqGSi+NEkyvhgQDChGqlUt7V5?=
 =?us-ascii?Q?3HaWacUOhW7Ez05P8y3Kuo3Ap5omWmU4B4WYoxqUpAgO6wL81ET/d6XtjNOK?=
 =?us-ascii?Q?YAO8esWsvPcwdK4XlpQp+GPE0MWR70s7w3P7FZW6lY6sre/JGFwLBVYEEvvn?=
 =?us-ascii?Q?tl5Ac77txRNULXO7fBoyNTimCbsq9AvZZOrv/A76aqWJQeSAVAy9eGE4ffX4?=
 =?us-ascii?Q?4Sb3f+AqCpj/NMWBsauAwuHAeQ58gZCr7s7ozmaOzcH+UiysgZITn2L1rCqx?=
 =?us-ascii?Q?9mi7szIsO0FOHyoNgnjTwxauTEIjnFXz71OCZhADIez8o+dftAd3UMb2TrRW?=
 =?us-ascii?Q?v+OmadHlq5MIlwHNjWXKE5TvjC0aWJKp9yfr1Oqdz9tYXZe465ECNfbT8WJm?=
 =?us-ascii?Q?o01gW6ISxf8dKclxhL7xNealHRCgFpwt1UKIQtiWRwVfYR2mlqHzM+mRa5CP?=
 =?us-ascii?Q?mX8qrcKr1YSRB7lYqxbqjgRszpWZQTMc8VHW9quFknFVUyx2vMVMUz1cLkYB?=
 =?us-ascii?Q?cSP9PUlofuiflv2t+J0swnOnJPNQ39tKNL+PLSRX1DimbfWzhSkoKKHMYjcj?=
 =?us-ascii?Q?4Q4RtAj7VZ3m1GcZ34iagYCaaoDU0cEBvlAL9zYhwQj1Mpw+//lonX5H0d7F?=
 =?us-ascii?Q?akoCoSWwMZs1tTq/JBhRV2lc48/Vbzge4WYAo3Nn0r9uGUvQWlZ8nPx9OvP6?=
 =?us-ascii?Q?yFRqD1pYxUjC72rat8hIRqwPsYO6/vnTfvl/lgmUIXZBurkVFSAfo932cC7c?=
 =?us-ascii?Q?vWPuObWil0O3XLqgubAyq1XYdQ7XBq+jyhcwnqRirjqeOLTQdofXXS5CD1IV?=
 =?us-ascii?Q?WvRtktkwObARYZWa1sx9MlRdGA+xM3Vi3Y+L5Yznkml3iOB8o1U3BXvoILxt?=
 =?us-ascii?Q?mGPO04HBNx7IBT5aRKlJMqIGQAtuH4Z1WzZ9ovPteT2CT/ktX12zn5CM3rBV?=
 =?us-ascii?Q?ypLyWm6hEpo0jPN/l7vu0kCjgm6McGxZBfOIL2pf9kYYkpRcfF1Ds+NooEUq?=
 =?us-ascii?Q?kgC3WXdK72C3kgUr7/0jG/tgvGjkM3/sPLQ2QsuPHQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR17MB5512.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pwnjfFvJM1z9cDPxnAlRK+HBCEY5Mc5sGyybhKa8C47ssQ0m1Hd4z0IoO68k?=
 =?us-ascii?Q?aumLJywkc4Zd+YXKn7+3vpEMmfoufecDQxiQTgqJW9wH4LqPK9wJbFidJnV6?=
 =?us-ascii?Q?6wRblxyvVIFUqHN5Zh42xi5nza2K5kfQ5VP30Fofbkq4gccBsaHefcwkijrx?=
 =?us-ascii?Q?xx+1XqGRcTbF5dv0W6dPczzCzlwl2aiL86FDUdTDXUQVlbAd1XVywX2JSfiQ?=
 =?us-ascii?Q?5nqACZ7lsh1IhJvMT6QQhBqzwlmozekRsPB6QVOowL0nEuhscQtcbZLYAOtL?=
 =?us-ascii?Q?V6GpsXArs2jTmmv8vflhCjfJ8xgUT9UVFpbiUj/NHiiLn+pREGL9p/0eCMOO?=
 =?us-ascii?Q?6MzCM8KJaBjySI+ktL0VAryFPF0YaLkBMwsBEEV5dqb4rblCSVVuTYSm1fNe?=
 =?us-ascii?Q?xrr1xjKhQkR1lqysDcq01g8xRbbpOY42BARMja1i/xXhm0WzaXPdcSI5i++a?=
 =?us-ascii?Q?4fXF+TTQx9Yow4vM/WcVISQTWUh9d3myZuyOeMNF0CHuQoSMfJxoI/7QvRFg?=
 =?us-ascii?Q?+7NvIGXodIiA4BYb2fNN1JdK+F7qtWhQG+Ao7HDrPZEManQkbywDKXAh6J/t?=
 =?us-ascii?Q?x4aRFHdJPpZhQwBly7/s6AXo+gs8wp8dW00keHfXnxoDxbi9BG1yVd1gTzzX?=
 =?us-ascii?Q?r4+8ZgbgiYxudexIITrQvVil+vqfN/rLf2oiH2+zyXr7ZHQWRZbfh9f5OV02?=
 =?us-ascii?Q?V5/bR1qEPdvDqc0mCHxOH0z6q6jlygY0cRyPpRwxVehOaO+4r1QhC+u8C5aC?=
 =?us-ascii?Q?KOwaOQY3TKPlUCHIHSfYi9lCGUChuajSexinN2c/RjbrIko/PBdu6G5xy6Wd?=
 =?us-ascii?Q?OpDsEa3jZiet+qGayxnFoQTMyUIvvFmM9rkAjvVur5wV2g99o3D1MXdBOSOK?=
 =?us-ascii?Q?C3e9pjnRhMOt7BAJ3ec6NDODHF4yLzh0ldZ4jaCrTW6b/m0w10R4XgX5TCom?=
 =?us-ascii?Q?+Z1LXSBSVFysGzseubPl1LrDG1I6Vp4w3gXTgMH5SUwS76C5T5X53KowU4+/?=
 =?us-ascii?Q?8iw1eORa6LNpeinRlybpFo1T6Scf0RB7duSpmuFiSwsKDkl4hyY+eQWxYCDH?=
 =?us-ascii?Q?2WvCJmIo9grpvktNNkbbo9A2hguHM5XcwRKe5VvG07t3RmS6QMvBtTAU2OUf?=
 =?us-ascii?Q?sorW1pu3xeGa/f1nmnucGwNXEvx+tMBnVKmO85bA9++K5YZ4U+7YU2qbWD9A?=
 =?us-ascii?Q?0snxyca2JvQYrNfPsCj5/ASH5JDfTikPUhjpgcMWLly92nWQi1jSg0R/kd+P?=
 =?us-ascii?Q?C0RPJ62c9eiVgcj/PSbFVXTza01B7ZWpsbg+6P7Sd0i5Q8yVML3zJxaduUWV?=
 =?us-ascii?Q?6Wnc29LKs7hqbnXzezWcbuEAvgUOcOyn7UCfUUiQfQvwm4s2kNuOTeCWF/4X?=
 =?us-ascii?Q?NVrM6UZInzSV90xkhh2xkRKDvzKQsc3f0YfObIc2PsvpZJpmiwD2bnrOoqLp?=
 =?us-ascii?Q?zY9wjFLLNi5QOtVj0TzvyMCXs5yyr6MNo7eCHm27TmvwAW9URKcxlmQilTQo?=
 =?us-ascii?Q?JI7Mu6MCFfVqmM4tZGuNY2q9qO0XyXl/O1wuJZ3zPhUXpRAvYHRbuZ44iB4B?=
 =?us-ascii?Q?vNa6b1nuTPE61cuO3CLM02pT21qSOKJr61v18mEBOVNYzUrxWl9KwK6uwWHv?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d430d26-d891-495d-1b26-08dc609d74c4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 18:20:56.6614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQLn8zS/S4IO3R/lwsjrskVQMcy3n1P9W1XuFymeSR1nE7a0Pb7v3bnBZWILTwqjLs2kFhv6osZptIiCtXq6uqTee3HPLzqc7UE+FreTGd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5569
Received-SPF: pass client-ip=2a01:111:f403:2408::701;
 envelope-from=gregory.price@memverge.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 18, 2024 at 04:11:03PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Before the change, the QMP interface used for add/release DC extents
> only allows to release an extent whose DPA range is contained by a single
> accepted extent in the device.
> 
> With the change, we relax the constraints.  As long as the DPA range of
> the extent is covered by accepted extents, we allow the release.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/mem/cxl_type3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reveiwed-by: Gregory Price <gregory.price@memverge.com>

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index a3e1a5de25..9e725647f1 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1941,7 +1941,7 @@ static void qmp_cxl_process_dynamic_capacity_prescriptive(const char *path,
>                             "cannot release extent with pending DPA range");
>                  return;
>              }
> -            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents, dpa, len)) {
> +            if (!ct3_test_region_block_backed(dcd, dpa, len)) {
>                  error_setg(errp,
>                             "cannot release extent with non-existing DPA range");
>                  return;
> -- 
> 2.43.0
> 

