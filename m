Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B809F557F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 09:26:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEktH-0003M0-M4; Mon, 20 Apr 2026 05:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wEktF-0003Lp-Ew
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 05:26:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wEktD-0007zt-Di
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 05:26:01 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63JMHR3C3805187; Mon, 20 Apr 2026 02:25:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=EyAmcyXk9BKMp9XtQF+qoHYrziGb5qONUyz2HKy5G
 No=; b=p7NqaaS//ilcjAqVhguHCJQsVMQUv6O/C0LA/4z5xh4FV3mrghfdF1fnm
 waiw3DW5TARbHfzKxur1m0K1t14IobS34Sa1eacaZRzcqjpB8juNdz+g/tghQs/t
 hpGxr7WIXR/tK97pdqNpngkmCTr0TgVWWYUt/Ij1CC1cHPCbN4sUb0+n497zzvJu
 KIaU0BXb1GQFwPbuJd6Po+hp9hpOVw/UynyktMRoe/YnW4uktYg9DgpS54KyM78Z
 hM99RTnq21st278ISb2B7InGQVyWli/2FymqBQLr0dvJMy/srysJDEnP2d4ztZaL
 vewek+1ZyM/i5VQfhak5kEzRjWFJQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021109.outbound.protection.outlook.com [52.101.52.109])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4dm7g7apky-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Apr 2026 02:25:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmNeqK/YIkq+Ad7OjO/RntRLiNrmBGqhotMk5QHlOW0SuVlDsDl4nhK579Kwc2cHXR8J1HEpWRBa1IJKeZLmLXye+JIbzN5DwXfs85jfFDcqAl7ruhyKMnOmVgmU1ImlLWEeWGHzzzWKiIOiq5BoBjPKEHHzGojNEzrZOnP0qXZO2ZJEtI8MbDewHhTcUjyaG8TjYnY/drCqbThee+jgBa3o8IpqicsQFrWpG6opVzLhAeOUffbGAo5TkSwyCek4HjP0Xy2BaLByfErmd/nSLDiOw0XhxUNIN0zye7dvUu8FTLhKnNvdqcC7sOxVtQbgyOegkmUjqdCZNqlXhltq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyAmcyXk9BKMp9XtQF+qoHYrziGb5qONUyz2HKy5GNo=;
 b=HN87By9spYzl+q3P+UJjoVwwfBnt7e+f8k4xFO6AKY1HSkh4zr5MsTiS9uHt6IcP0//dD0Dt1r7WDRjrsihWRNg/K+kgfXtY6Q02k3aDve0sq34+XB6vN3TsLiYi+2PCfZnWy0AbzzQ9cTYM7yRUVe/kWdEga/BEtJ3G2QFJorwhBkizuKeU73fNUDSBblipuehSjFQu9dnPwsfxfw8Rfb1v94+X8XjGMTAoGYfY60pJIvQin8FpumUWEevoMJvCA57e0PP1lynwmS5FSPSzJnxP7Ob8tv2f4KOf/vFQ6CFDoe0elPwX1DKlT1ChoJVlUcDfrzkl5x+76LNEO6Ok7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyAmcyXk9BKMp9XtQF+qoHYrziGb5qONUyz2HKy5GNo=;
 b=UZqLTM9aRoj+0RTXoQ8Xor58AV+f+l/pi44fPkHKOjcSqJTiodN82xuI/vzKeU7ao43nDVcwPfhoJTtuyIISmPSmcqPQLinLLJBC2ZtWPE8YkLFUrnY0zAPbV9g/aKTJMf+y0R/6ecoWwyYSRTgXREPp4r9w+Yyw7p33pzeOA8c2/a8tyU1oullrjYxcC4fqh3SpJRuh29srCYRntIkBU94jejZMRsU5Rr8ub4gt+eAjx05QkeV0PfwokU4Kjjvjv/mOgsAAcHhUzRAciBbhJU5f3IhKLxKOZZ+165nu2nr7OKZDea/Gnn/HG8BBCm+1G8T6bBShjoOnqJmDhp+Qew==
Received: from CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25)
 by BN0PR02MB8143.namprd02.prod.outlook.com (2603:10b6:408:160::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Mon, 20 Apr
 2026 09:25:51 +0000
Received: from CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab]) by CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 09:25:50 +0000
Message-ID: <80e6ecc4-eac6-40ee-aaf8-da60daaf96d4@nutanix.com>
Date: Mon, 20 Apr 2026 10:25:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] Add HvExtCallGetBootZeroedMemory
Content-Language: en-GB
To: Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org
References: <20260112113139.3762156-1-flosch@nutanix.com>
 <20260112113139.3762156-3-flosch@nutanix.com>
 <a28bd807-6e98-4393-a354-b7ed1f7a08ae@redhat.com> <aeHKfOmm2b7cY70i@tpad>
From: Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <aeHKfOmm2b7cY70i@tpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::33) To CH2PR02MB6197.namprd02.prod.outlook.com
 (2603:10b6:610:4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:EE_|BN0PR02MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: 514a53a8-759a-45e8-8bb8-08de9ebed006
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: hzbYH5pCCNfzoLscMDbW53mESZ1UewNeUpTCQlWyi6jhzUyIs0ZHNJTjZAL/dcGi0ljl7BgVPmah8AUKfjKIpaqzwAPp8MKTqrDMXTZpI7p9dcAQDhwZpSXYScpVsVZyEOT2W9xHyq+QGB/q3jqNd7nsi1zU/8BzsQSD0t4LqXJhQKcQjitsbe2uGRb0Xqq+5LPhGbKDR5+GE5TU+FmwLamZvVfy8NZasMj/h3FqF2w41rAnhi/k88HHEbCWLEkA6tNTHVZ3ctqB5vikStWmjw5RiWKXTzh1MOH/laFRAEjaXzd9q4PQjwJCh4KlE1eut4oBkHH/EX6j+yl0r5aqEebkDpcGL6qBktk/F4xQwePp0hJRyCuFDuI7Xavpu/8KWxCMFURUN9+2CXQmR7I9/FxK+vR4rB5LjeLuZRSfQsDspOB8duPn5L1AELuA6o3q4DQO4UbtAT0jYjCLJHDes4tCnwtCHcWDMs1V+cTUg+8Ch2PCq1XzxGvWHFbLz3rH4X78KdLi2my5isqLBQLJD4JI2eEdkS3wj5IXVP2aRyTyM4EvGrClJJnqxoNIK4JpkF5jvvO3nxu+sQJC8SYl259ckfIDDO4h6aRcu8RxTgQCrVmamiteZjeK7xzPdpzwJrF9yK4gkSUpY+HIClH1jqI27JB7EWEWwGNSAUZWBLgK9315LWQ2h5yNOKBgCTVz8aCfIgza0o6NGn2N5we7LeXQeqdVAE8o9MFQxEx0KkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6197.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVlpNWd5VkpQQ0RKZFg5M290V2JyVjRxNzhjcDdDSTdtZWxCcU9ncTlINDRB?=
 =?utf-8?B?MXVCOTQ5c2wwU29FdkZ2KzkrZEdpSkxzbjFPbnhlNjk0Zzc0c0J1Z0ErY1lX?=
 =?utf-8?B?NXhpa01UN2YyYmcyWmI5TWNwOFJZNXlBUVh3Lzd3dnN3YTFNdzl1QzR1NWFY?=
 =?utf-8?B?U3hJRXRvSkhtbXB3aDNhOTFCRk41SzNqcUM1NW4yNi93d252bjIzRmtLN0Nz?=
 =?utf-8?B?RGlsMG9uaDcxMlc1NzczbHlMbW05Y1A5djlsRXUzSDdRVkdYMytEd3V5L0dH?=
 =?utf-8?B?V1AvMVlkZjJ4Z1JLeHdXcEdtbkpuck9GNUVPeXNlejEwSzFBZWpSRHVFV2V6?=
 =?utf-8?B?QTBYSW55aHlSZS9jZTI2azJzcXpFNVFpbHYrbytQWEl5SnAxZlJrNGFBREpn?=
 =?utf-8?B?VjFjUGo0bWdod0htbTMvdE15djB6V09GUzI1cmZya1ZXcjNScHpNRm1XbHh5?=
 =?utf-8?B?c1Q1L0RvcE1EZzZENUNrSmJhWWFKbmczQzVDcy9qVzNsOUlXZkNmQWZ3OHEr?=
 =?utf-8?B?Y1BKTnpXWldHdktqOEk5RW50eWRTS05WdDFPdkc4RlBTWGNsVTZVVE0wMGRQ?=
 =?utf-8?B?d2dhNHpNK0pYRUJ1TnhwUE9yc2gvc2YyNGxFNEVuWVROVzZjLy9BTFJXenpa?=
 =?utf-8?B?eGZyQ0NYalN1TVJQNHNaemJFNHg3WjN2aVNocHlibG5wemNjYWUzazJUVkdP?=
 =?utf-8?B?V1ZIRVlBSTIvQ21mdkplS3QyMjBES1c3elhaaStZQUZsek8yWnY2NkUya0hC?=
 =?utf-8?B?K243L3NDcjJXR0RlRmFJUHVkcnhIVXRQd1pjMlZYRit5VTNKOTJTNkhGY2tM?=
 =?utf-8?B?QmZQM2I0L0ZBczJOeFZGRXlLZWV2MzNXOWVkNVVJNjh5STRwem5aVGJUUWRK?=
 =?utf-8?B?T05SMC9nblZqdm1LYWVKZ0xtUklLamJsTzFRRjRidXZ6Skk0RmFrTUFySUM0?=
 =?utf-8?B?ODdHbXU2N3E5eTVWeEkyM0FvUzFaNzhFN0I3bEl3UVJMaHBYd29lTkcyMUwr?=
 =?utf-8?B?dzFQY0psZDZyYnFRQ1ZPdWY5K3pHdkxDY3V0YlFZa0lyc1d6Rk11ODJZeC9O?=
 =?utf-8?B?Z2tqOG1zemYxRlZFNG1jT1JGODBIOGxXQWQ5dWF5UXBqV1JXZDJFaTVkNVdM?=
 =?utf-8?B?U3J3QnQreUdBRFFGN1AzMXVlbE1hamFrRW05RXY3Z0VDSXhtYnVyQ3o4NXRF?=
 =?utf-8?B?SmQxb0lSOXQ0clVlRGZlS0pMSFFzQ29xcWQraXFhSEFhNzc5U1pDWU91OEdo?=
 =?utf-8?B?b0tVaEYyekhFcmdzUlhzSWlmOStDK1d3UWIxMlAwK3NDMVNFRmgycFZBWDVW?=
 =?utf-8?B?VHg4R2dPK1VtbDhPQUtnck41bUNVUHdNTmEreEhEdy95MXh3bVJUZHNGWjR4?=
 =?utf-8?B?T2dmeDlEMGpOR0FYTE40R0JzdmVyaFVCN2ZBSG9EQUt1Z0ZITE03SzlRUDV0?=
 =?utf-8?B?SnNiV3B6a2FpZGhwaWxWMXRSNForRE5ZeU5nL3FGQXovT2xWOVlHcld6U0xt?=
 =?utf-8?B?QUZxVWczWlRFRDdXam1JeklkNGQ0bklTdUZGZXBjalRya3VoVTV3VmFxV0hX?=
 =?utf-8?B?OFp4cWJBRmxtRmZGNzZjNVZOUE9sM1JPdmJUNEkvY1RGTXNoS3YwN0trNzRM?=
 =?utf-8?B?NjVTL0hSUW5sWGpEUm5yYnR4bjlBeWdsTmZkZVpzMVNhMnRZTEx4QXd6dWUy?=
 =?utf-8?B?R3N5eHQ2NXZOQXQ2NktCRmgrNG9udnpGeWZZUUtRdldBRkNUTm1YNEtEeTJk?=
 =?utf-8?B?dWtwWkNYMzkwMG9HejYwa2h6NEhUQWFjZFBqdGZGcVhXbmQrci9FVXNScU5m?=
 =?utf-8?B?NHZOWHhoNzkwaXJPTTVJcXliNFFVRC90OUE0SitJY2VUVWF2cGVleGVVc3dD?=
 =?utf-8?B?cTRHTTBZOXV0SmRtNS9UY3pudzZTc3g0a2dNdFJjR1FPV1FFWEplZ2xQUDNv?=
 =?utf-8?B?MnVPQXhoZ09QSDB6T09tSnZ6TlUrY3Z0R3F0dFd1MHNjWVFlVnZhWFA4V1ZH?=
 =?utf-8?B?dEppeEVNcGFLSmM5MzhGSmxpdlB0SU8zZjRYK2ZkUWVlaEhuOUFLWkcrRXhN?=
 =?utf-8?B?eTEwSmpQN2VxY1JRS2NLUGdpaW8xdml1MVA0dm91QVl5NlVnOGkrMHQ2NXRZ?=
 =?utf-8?B?ZDVZT2s0N2d0cGl5YUNaTDJtSmVFWDl0SHRiMjBOdXV1cjMyYkMvdk54RG8v?=
 =?utf-8?B?UUJRMmpPRExnLzVUZm9VSEdMayt6LzhDQldUeFNUSlkxZmhaeHJ0a09kZkY4?=
 =?utf-8?B?U1ZIRUE5SmEvQU1iTzZpYzJBZmliMkVWbHMxRnlsOVRvQWF5cXJTZi9CNytl?=
 =?utf-8?B?OXpBbnErRUlnRWsvRkJTYWRMZVdCTXIyb0ZvWFNrelFFakVQVG5YL2NTTlZR?=
 =?utf-8?Q?CYgJl//J+Wf311b8=3D?=
X-Exchange-RoutingPolicyChecked: v5rnUm/aZfR7gekp+oLxnrh5aCGRHsCcLo7kaIE+5rorBtxPpJBLeawZjS1EJj/hYCwlxsSzYd3JOpgKlYs51xcFqR8vSHlxdCnlLSBAmXQYuRxQlBdiv8DHQaaX4rqhywbBiCG65B+UD4cBO7QE6iCWpCT/QXL6zdlRR3B9DGmatTEao9qeavi2v0AulV5qXxJeNSah/PSYUNs2Y/9Z6Kni7khQY31TGte0qaguIBYiqWek4S7Susoc9eQRJGu+So/6EOYjD3C8WB3OYxfl8jBDWGXRasiz89vKktJUc5kodt6ET2sK5sO4gnueHy2m7WA0aF4goCK3WKoWeCH7Hg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514a53a8-759a-45e8-8bb8-08de9ebed006
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6197.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 09:25:50.6612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EoVH/s+oU2Y1hxhR2kXoeFB1qVXbB9IxnoJava/FTWv7+zmx4N2jrKol1SXnMlHqTfhPn9TTmKwEBWesd2jdZKSD9IAumBoIjRFZGm7yl78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8143
X-Authority-Analysis: v=2.4 cv=DZgnbPtW c=1 sm=1 tr=0 ts=69e5f122 cx=c_pps
 a=eErdSk/Sa828lcK029XJ5Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=Wl6TmxA8MIojS5bGRNAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lUKytRDEmiUQwW-fupaAxd0-VnZTRNrz
X-Proofpoint-ORIG-GUID: lUKytRDEmiUQwW-fupaAxd0-VnZTRNrz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4OSBTYWx0ZWRfX8/iCOOk1/xoQ
 PtHofh7N7Dtt7lddG9CA7NqpQ9Oivbh5i7Y6WbAUnlCUtgDaQ/XzLch4p9kP2ugsr028dsvzCaP
 aaLdsYmdVBKBcC0W+GpSvhvZB7sgllaphCo64QWQKJg8ea3i37HopGUQgcfnsU4VfpdiP4A7VF3
 VxhS/q6T7m9nc2/KbrSlQIg/Eawj6AohWNKZKAFRVeoxkf0r8WcGqy+WnGokvaS7W+YhAC9d2Dk
 qXOpZY9zkg5Z/rNSPrgq5aYOjlGnaubOcKZcqNBCFsXBgoFWuGM6D444ecqDa8ZCYut1r0C0n4T
 Sv/u+1H4MVE/om4md+BwDh4AaJm/mXkZ/KmFHLagP8X7IZ/XXTcn+G3t5AI0AXohQvK+2A4u7ky
 rEZpptn5c8u98uVRnI/K0+tRzTsgJI++l9gnYdW+/dsLyFXlXXb9p+QIToOA1mfNcpDdRR5m0sc
 RuLe5mE6izRdNAbFwtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=flosch@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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

Hi Marcelo,

On 2026-04-17 06:51, Marcelo Tosatti wrote:
> Is this to improve boot time of very large guests ?

It depends a bit on how you define "boot time". It won't make a 
difference if you measure the time it takes to create the VM until you 
start the vCPUs. It may even make a huge difference if you measure the 
time until a user can first log in.

What it will do is reduce the time the guest spends on writing memory, 
mostly in the background, to zero out all pages it has gotten from the 
hypervisor. The main advantage (other than saving CPU cycles that are 
effectively wasted on an unneeded operation) is that if you don't 
pre-allocate all the VMs memory, then the VM won't touch all pages after 
boot, keeping the RSS down until the memory is actually used. That's for 
example useful if you overcommit/oversubscribe VM memory.

Cheers,
Florian

