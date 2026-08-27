Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F90C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbBN-0007p9-TB; Thu, 27 Aug 2026 10:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBM-0007nE-2G
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:20 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBJ-0001xP-QV
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:19 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE7tUa2504237
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=mEieh4lfEpwO7
 f2v2SNUu9KMrGENnuB08CU4xygwAE4=; b=PP0/QeMJWsbUKQ1ZLLSSv9DJftQ4D
 +EL1OcepRT7KgPUmsyC7S7xqJD9EjWys22Q8eWklP28xO4RTFe/Nywfh0oKL24Kn
 g79g/gt9N7X/97jfDEx0/HKKgsNwvOdU1CQ338Kn9Hxp/03ZOWGEH0orELgr3lSV
 94Y0azTaanrnTn58gmvnN9YmrQ7xvEU949sSVcqbyo4quAG9EZMsCN2EDMcBav61
 u6oNC8GRrrlVjG7JwEQohGisgGU6TgzyU0WATRS2Bq3CdpnLEZJM4/ggaczMt8Qe
 cuPrphx8mf/R3OLdwwsoIDxLSL6A/dOhhnVt0u+XeSt1x7TyxvmWGaiZg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020127.outbound.protection.outlook.com [52.101.56.127])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g97as73eh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SS2X5vf9JDDXSZThcxPTCtlpmUGMOjdvV/v1EgUzboUvQM1Xk5MGvQozSk1cOt+FM9mhlSpKx8zCsAooxdGyD8WetsSoPYVRt5CdeAuB+E9bvVwPsY8ojxW+V+4Q0+W1Gce7iCSbhGOZVwO1rr62FGC7I7SuzAvSwnmjXzhFHj1mID5FHOXjndrRrF6lksNVwF7mZqtDh4VnqPoAoFSE6tBWcV75jRIaxWSH7F29nz1DEavl2riwiBSofHWfoJnADK1GgLqz9r8V8OgGmLeioDJkc/YtIUGOhCTUR67WU+tYztlUJOWNz0uA/3s+fwYz7m1aLXqAfR1dQdljzsaY6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEieh4lfEpwO7f2v2SNUu9KMrGENnuB08CU4xygwAE4=;
 b=Jhmf0NEqtnunSjCQg9gkc8/Kq7xrHS32zxe62ItznTNApIjcIBO5twEKudYI3Ze/kT3iuZc0Df6LlQvUzambkUXwtEEyup+RvPE1OJcJW6RHs75JrWsIMSoKMDvICQRdOY0ZlRY3AoG0IcDgEWYnuxFZEg6hCyC74Uezqzpexww7DGv48npOtaXgzvdgkkDY4Ml4c/raxZLTGIeM+ZE2miti7iA9JO30SkXhnWRs2+a6poTwPRwVOL9M3wMPNkzeD/AT3ccOZAP91Z6rjstVlZ4RZEo/JFMs0FEeeUK+JGgXUl7XABww/8ouGXQrByjpTz62LBv5AgdJquQquxIibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEieh4lfEpwO7f2v2SNUu9KMrGENnuB08CU4xygwAE4=;
 b=yQzszOetagjTsXVFCKkTxuar8IteB30GTeUh7qJLPzC+GvhG84jXK0oEHSnptdLkdzrgWv5TdNjP02PY0qUYxsRhIUgB9wifk4WAomjbVXrn2HfTO4lrEaqC0ct0eXP3UMu/lkdif8Xo9q27tPWQ63GDCw5UN+XPMWwr0bNClsBQcoSp95hp5UomKWWwdvyS+7gg4VpddLez8TJ40PIQOgRuQXxW4xVTl5LuTmH3jXGdImhZOAOB7UVo7FjadW/qhyRakSDEWiUqTw1bLyAr2HO+nmWP1rr4YoRxLDmyuJBMpkDkMoztzMzY8SXyqOJHUs1Ub0EeV2rUuOP9Pn+SEw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA3PR02MB12061.namprd02.prod.outlook.com (2603:10b6:208:629::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:34:07 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:07 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] qom-qdev queue 20260827
Date: Thu, 27 Aug 2026 15:33:21 +0100
Message-ID: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:806:21::32) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA3PR02MB12061:EE_
X-MS-Office365-Filtering-Correlation-Id: 00cce438-f38d-4e81-3bd8-08df0448401f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: inhjeccHW3wxLewsXeqsm6stJveJBrqeW7811CjIqhB/JQLLWUCzUC13DXQxBtirzd0/+8E0MO6OopgVD7Qx3TDl287sncpMYynDEqETSeNiJPSHSofg0tET61lSCqq6p92Q42ePl18um+O7wWmbZoEogBNinNh18tJnYNgzu+TXaRjULPCm8a6NN+AQtvazq1NrpJSaEVh61TBR/sfOsohHHy6F1Bn+qIoS3mYj1nwt0oDoMcFzpK2mtpFiABbvSEHIX4wey4F2uA5sABR55PjdVK/YRxWuM4BQWi8uB4O8lvQLFWVLHQGDXJ+PuWXm4BgHLFr4Qnbn2KHFkS/4nxAqXF3tt1SP6+NnRAu1wJH3c8lnEX37NfC9cfTD3XMIuQMyt7KsLlF+yi1O05lixNXjZY3ITB4HbdTbFDRFL2JoEMLmoGsfEF8J8VepROSEALjfucuxU/3UUjaJeufM8ig3dUSKqoQq4t/433o8ILvzAT+QjjhrvF1RAzJjGhcsh1jWFkBudl2yjhBMPi7vg2h7sOIdDRYM9Gcd4IXvdQSa8cC0iSmUKC4wrEcrIzBW0BQdg4YswSlE6ezpnS3Afz7c+T45PU+troFb4mrQLa5g4ZYuMxf31WNKp5xFWKG0MgVgRUOEYaUq6U9xHMlUgjY1/WzGCse73HqyuVhivrU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K043aFZEV1dUVU03d0puY0tYU2NEejdITXErb3JHZm1LS3hEUGlGWEIxYlBK?=
 =?utf-8?B?TnZjYnQya29VMEw4bFNMdXFLcHpJVFZvTENOamphNStyakNIY1RyNGN1Zll6?=
 =?utf-8?B?N1FPS3FuMjhDYWFld1k3RU1KRktsak9yenpxZnF6YU56VnE1MzhscXdWdzRR?=
 =?utf-8?B?blkyRXU0MElGb1hxS0J0b2Ivd0JGR3c2aTcwSXVYQzNBMEliQ2M1Wk9CV0pI?=
 =?utf-8?B?MmtoT0ZLUitqUHFnVGFtSHlCc0xLWDNaUkxsaTRiSUJLQmQrWUJRVmNnVkQ3?=
 =?utf-8?B?U2xRNkRESzhZRkZDbXJBaHNKUlFTanFnamwrSUxkeHFKZDhpM2hNYmxGbmhE?=
 =?utf-8?B?c054TnRrR3RsTnEvNTNWQUxpWjREOTNxd2pDYll2aTFrK2s3YmwxUEVpdVdT?=
 =?utf-8?B?UnFpUEtzUkpUOTF4K3Y3NStqcDBSWFE4ZlRoOXhmN3ZDQ0hvQlZjS2k4aEJp?=
 =?utf-8?B?TUJhNUgwMTdKZUhQVVVrZ0QyRmh1NXdFSGsraHBBSWxzeG9iRGV5U2NIMW9t?=
 =?utf-8?B?N1AyMXdCZm1wdERNdkZyaTJoV1BLYWxMT2pSU3doZ2hVM1l1dlRGSmxoRjRR?=
 =?utf-8?B?RUY5TGpZZ0t0QUV4bkVsWlJ3SDhLMlRhOFhiQkxEL1VYcFFhWmE5ZEo2SFh3?=
 =?utf-8?B?NkowTlNpY09QOTlEcFBDL2QzN3YwMnRvWGdSSmFtbm9Ma1ZRSEN2bFlZQ0h0?=
 =?utf-8?B?M3FCazZvbEJIMFNyWlRtZ2N4cjRMeHBFVkVKM2RwYTRqNVE5OVVZcC9TM0cy?=
 =?utf-8?B?Y1JFYkJKWmoyVUY1TytEMlkwQ2ZzNCt6dFFUM3Nha21tODhOQXJYdThaaWla?=
 =?utf-8?B?bllNWHdOMEZLT0tERmNSd1V2clREYUlOdDc1bExQWmtEWkZkaTlLOEFRaU51?=
 =?utf-8?B?OHF4aFRxYjNCUm5ZeWZzZmRNc0NWWFl2VWpoekwwN2ZsZFk4eUpMK0FpVnZR?=
 =?utf-8?B?ZjF5cC9sRWMxZVNKcXdOOWF4YkNJQ1l3cnFRYmlhcHpjKzlmbzY0b2tZL2NM?=
 =?utf-8?B?RUVSazhyVHovVXd5bmZCc2ZqZFY0b3dVa1MrL2VGVTEyWlhJVmxRS0xCZ21a?=
 =?utf-8?B?QndyeXFrcXAwbkFjV2pZSGkxeUxvOGRvblY0N3JIZ0RYZVR0L3IzM1BxYzY3?=
 =?utf-8?B?QWxKeTZvZVc5aUZ0alB4MWFhWVFMcTZvdzVONmoyNEVYelcrUVRWV00rWkJJ?=
 =?utf-8?B?VXZYSmp1MThvZWZRcjVwYVlEN2w5djVLL0YvZ0Q5cmcwSDU2dlhSbVBVTmdN?=
 =?utf-8?B?Y1lncmJpVStiTFpJODhuZTFsbXlPTnB3OGNySnNteGtkZURrS25iTGFXRzRO?=
 =?utf-8?B?UnE4Yk5JeFdMcGRiazZNT1RWV0lqLzhRUWJQeGl0MEpVYlZGZkVKWmhsZlp1?=
 =?utf-8?B?L2VZOEZOMnR6VkdSUUZRS3JOaTBjUnh5ZGNodm5FR0l0eTNFSnBKUEN5dWJn?=
 =?utf-8?B?ZU9BR1lRYnhlaDZETjBhWFgxQklxeGpYY1Uxa3Z5akFJbGhKR3JPNGFCTWdG?=
 =?utf-8?B?Z3Q5VnNObW81NWRXTnR0MkVHSjJCNUFVdmx5SzNWYWl3aVAwQjBSL1lZWnVG?=
 =?utf-8?B?VzJpVmpjVTZwcFlXTll2THBCNWZsdHZ2b1VJSkhFSE1HY2VhSUN1aXhtYUdI?=
 =?utf-8?B?YmNzZ0ltUGowWXdvcmtGWC9zN3lUdjF5ZDE5OVpuYVVUM0lqMnhTOVNHWjY3?=
 =?utf-8?B?eEUyTGZRZG84RDBwTElsb3laS0hlL1o3Q3A1VWx6WVFGQVU4NVJsRUNLZmlO?=
 =?utf-8?B?RlhheVFiZmFXYTJmbll2NlkvMzFDZFNOU3QrYU9wNEdqRVNrclR4ekhPSjV2?=
 =?utf-8?B?U0NEcEp6enB4S2dNUW9WbFpnOVlMMVQ3K21vSGFBMWUzUFVhM2JaRGl0aWQv?=
 =?utf-8?B?T01Nbnd1S2g2ZHRQOUovSExpOXZEUDgyWUM2SmF5YUZXbU84TmsyQnl2Rmtn?=
 =?utf-8?B?NStWM2lGbmhFTi9XY2Z0SkJJR0FuYU1GU2tobnNSbnpJbHlqT01Idys5c0h6?=
 =?utf-8?B?MnNiYlRGa2dSeDN6ZERYbVFIU0hZd3A0dFZxMW1WNVhBVmVOZUo4TWFqL0px?=
 =?utf-8?B?akQ0STIxN2R1cVdwbzEzMXZPSGdtUW1zcng3NTlHVWo0bTdtSE03RHhCcjBx?=
 =?utf-8?B?S1FIVWFuNVhpVjZDaStwZHNYSEEyVnJXdTZqeDFFTVM4Zy9jTStzQjRralMz?=
 =?utf-8?B?bDJKa3lhYjRWUEgrcWgxS0ZnZVluUy9aMEdNQzdQOTdCbGxHQlVteXpCejc4?=
 =?utf-8?B?U3Jaeis1STE5Q0Z1TW5pL2RiMS9PM3ViYm5tMzlKVkhkai9SOFYweXBqUW1z?=
 =?utf-8?B?ZXd3T1pveEpMWmIwSlRHcWFTU3dCS3NtYXRmRllacmVUZ3dYTXYrREhKaW5Z?=
 =?utf-8?Q?goiaoAC664FNM2CY=3D?=
X-Exchange-RoutingPolicyChecked: 4gWFvv5WUBCPJzGJMECQLDlrBKpr7b88wIBbxjcA0g2QbS5IPhQrZppc2AenIx/f289Sv9FqyMv9vNDCyLVF5vfGk4pZ6IHQZpnjgE8pxTHL+jSqhlFfzIzIjf/hrBPvOcjW57k5AstRydA+UiHqLixWYTdusVc3y5IrelPlguOknHsOYsQGu9GITSxXYQFrCjYE1GoCkvatQL12e0rWMORfIpLAGpwgA2mwaR+tq2e2ksmZON2VupErXOwly4xhkDNoCo6AZMVngwVwm3Dxmn6U7A/hTlGvhM1dVyQLQfWenRPs0C1bb9ObpaHWiZZHDNTnEqurnIVSWMX4AJLrEQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cce438-f38d-4e81-3bd8-08df0448401f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:07.0384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLomLIp4xrwug98EVN+Vg6x5bUo2wYz8MUpRu5E+tHtLws4L54xDw1VntoDrtAMzM47LVqzYug9/T3weT5a97pmqTdx5VcoQ35dYrglhcbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB12061
X-Authority-Analysis: v=2.4 cv=DJu/JSNb c=1 sm=1 tr=0 ts=6a904ae0 cx=c_pps
 a=I+QdrI45u/umTjhn/cS8vg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=p0WdMEafAAAA:8 a=ym14fivtzCstvOBMTzcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX0khAjoHUy34e
 eJz/qhNJGMmnweHtD7Ps2oJgJnhnhIrxMbvHY2TXhQ5uuwMsDqeJPfP224yIzWxxg8wgqFqWjnP
 /S9EU24GeJnuPCY/Skm0rFJfLILds1g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX/FQYqdp761Hl
 7iwxjf2YyLojelMw9B9NU5nnVIviLVWAS/f0NkIwrm3SzbW9hN2azIySpLrSlS4ne59E3NNS34y
 tCSNTb61IbtBzh9p2Yml60/d98urDqdcMvXIN2NBXG7tpv49stkbQhf0ihwGTPiqp/PoDvFZ5wC
 3YvEak7cd2NxPpSRrbMn/nGJ20PgXk/BjcmgwbC9RGO0NzKeBmdPc9X0s/vMERNpASxTUxLe9Yp
 pOkAyEZM6lMWAzfXOlBmLRmrzuHsvHFKU6YOlx3o4n65Qrf3nmm2arWS+xCKY4odIkN9gIdF26T
 ZnlN9fiuTyHO0J+/hU4x0bZZjVw9HCzu2x+VRqmcXSrrnR6U8Wa877LfV337powo5/x0sq05dJc
 NF4cv6XDvkOcVDhg3NsbtCTWynaTrZkUuwgPjeJxE230yv31PQMO4J6V+Bg/eHaIai4REohvvxk
 YksOUdHWspc+ekHdJtQ==
X-Proofpoint-GUID: fB3LA91oYCUokeOtYI05Otw8Gu9n3mQ_
X-Proofpoint-ORIG-GUID: fB3LA91oYCUokeOtYI05Otw8Gu9n3mQ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit bbc8fb89fa3478a6f47c0475d2e4952e69a64f45:

  Merge tag 'pull-tcg-20260826' of https://gitlab.com/rth7680/qemu into staging (2026-08-26 21:33:14 -0700)

are available in the Git repository at:

  https://gitlab.com/mcayland-ntx/qemu.git tags/classprop-hw-acpi-upstream-20260827

for you to fetch changes up to 3435f9eed289b362097429d031c75bdaa847446b:

  hw/acpi/piix4.c: convert ACPI_PM_PROP_PM_IO_BASE to a class prop (2026-08-27 15:22:11 +0100)

----------------------------------------------------------------
qom-qdev queue
- Conversion of object properties to class properties (hw/acpi)

----------------------------------------------------------------
Mark Cave-Ayland (16):
      qom/object.c: introduce OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) macro
      qom/object.c: introduce OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type) macro
      qom/object.c: introduce DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS() macro
      qom/object.c: add object_class_property_add_uint8_ptr()
      qom/object.c: add object_class_property_add_uint64_ptr()
      hw/isa/lpc_ich9.c: convert ich9_lpc_initfn() object props to class props
      hw/acpi/ich9.c: don't pass ICH9LPCPMRegs via opaque for ACPI_PM_PROP_GPE0_BLK prop
      qom/object.c: add object_class_property_add_uint32_ptr()
      hw/acpi/ich9.c: convert ACPI_PM_PROP_GPE0_BLK_LEN to a static class property
      qom/object.c: add object_class_property_add_bool_ptr()
      hw/acpi/ich9.c: convert object props in ICH9_LPC_DEVICE to class props
      qom/object.c: add object_class_property_add_uint16_ptr()
      hw/acpi/pcihp.c: convert ACPI_PCIHP_IO_BASE_PROP and ACPI_PCIHP_IO_BASE_PROP to class props
      hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL from object prop to class prop
      hw/acpi/piix4.c: convert static variables to static class properties
      hw/acpi/piix4.c: convert ACPI_PM_PROP_PM_IO_BASE to a class prop

 include/hw/acpi/ich9.h         |   2 +-
 include/hw/pci/pci_bus.h       |   2 +
 include/qom/object.h           |  90 ++++++++++++++++++++++
 hw/acpi/generic_event_device.c |  10 +++
 hw/acpi/ich9.c                 | 115 +++++++++++----------------
 hw/acpi/pci-bridge.c           |   9 ++-
 hw/acpi/pcihp.c                |  35 ++++-----
 hw/acpi/piix4.c                |  51 ++++++++----
 hw/arm/virt-acpi-build.c       |   5 +-
 hw/i386/acpi-build.c           |   5 +-
 hw/isa/lpc_ich9.c              |  36 +++++----
 hw/pci/pci.c                   |   7 ++
 qom/object.c                   | 171 +++++++++++++++++++++++++++++++++++++++++
 13 files changed, 416 insertions(+), 122 deletions(-)

