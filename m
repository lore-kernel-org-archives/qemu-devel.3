Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60ECAC982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cKF-0005gp-9k; Mon, 21 Sep 2026 07:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cK1-0005bj-KL
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cJz-0007vK-2q
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:33 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAfZ2d3341647; Mon, 21 Sep 2026 04:36:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Z/258CTrl38xxO6BrDNQ6tWXc/y2P41vxCCleUHoF
 k8=; b=jYReRkXh0dK8ZpjmzF6OSj6TKqELXkaeo+uGkNq3fjlI0+Vj0IK5fy0n7
 J407VH1aJoe2XW5tYXal7YEM423NEx+V8+pjgLk0Wvbz+ZpyDqvnA7h/5d9W2XGd
 Pv6d1L+17afIoy0JBcvls5ZDIT+urMFEfhQXSgG95BW7yOlWXBT3+YSr6R0uG7yh
 2oqmoz7iN02EZ5dS6qkX6mYmLQdS5M//k2xbfFUzd9o0nJXqWv6jNTMj74rUcgsO
 5cuGGEYAoMSKXB8yU7Wq8iepSwMQo2sE6hvJiCeWSJo5fXppMgLhUNoyl39uhd+o
 W5eCdJ5oclsEgACgSwpjIWxlgUfsA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022088.outbound.protection.outlook.com
 [40.93.195.88])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gssqa2v20-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 04:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdmV6hcDhVKalmBpzRD/yKpFCbqdqiiRw6CwxxzqxiEz2BjA+5EI3TN4jaT61PC5mIUKQxt0v5ykX8lKuN24HXnFt8A5wLM3QmjbOC9/b1J30me6MezuJihs0ImybIKgD95XMh6o4wRp4biLy33Qs9RYC6YFX9n98QOMzUzpoHJGauXT/HN/c3Rf2NqgZ5sZ2rCf/QA2xGcsizCySl3qywGLT7a8QwMzlfcUvHljt2Oj5aHuA2GbjaJo8rU32oNUqBxnyYiFu8qiFiBGjbm/VE0+1MpULngWq9gIkJetkUGtiNVAUcvu6gi9Gsw8MFA/N4NN5WGhsCPfTehC+0iDNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/258CTrl38xxO6BrDNQ6tWXc/y2P41vxCCleUHoFk8=;
 b=F8vrH7sa8EjLMo7EVIBXTlDCEFPLB+MIg0rW0kDaSdjtPM3sSDyzRuS1fTBDMSH1s/LyzSu6mXCAI7F3ESRLTntlweXfU2toAYMJKq47rkiZuELygGTTMvJJnKYBcehx9rb9nU2L04GXlk3upuhq3cl0uT+DXOgYG7gsSmoVb4dCxniAY8SFFqK1qgWjSJMifsz8kOnNlaxbFgooqpc6cFvmoTQXm10P1o/cUBrvIl3v1fmEJrsT8ydAm3T/uIMSm6l/oklnKg0vyNjYCtMtqbTRa2kV4KkzEwko1BZI1O0d2AkKirGmWtsqytgJYCgSgaloZEvhUiKQWKyQJ4QFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/258CTrl38xxO6BrDNQ6tWXc/y2P41vxCCleUHoFk8=;
 b=ZXZ72ShToy1KtZYPllRBCVNjbA5cr0+skFHuyE4K2xY7o/4Fx1kDxqUfm73YhQuS69zmkR/CFxW0QA0buT0L0A2jVXfS4KD4/4nKnJcd+lmExVKHreEijL7a6+0NlaKtzzbgwZFRmMoeT9tO4od9u+aGQvzF0RDyCtxJJ7k/SODlUwLvoDkrAi0CI1sQ2EnaMGw79cJJElWGHXzkvZwOR7rLyktLaidzroVy8uMFWm+IQJdftfzXC141ocRwcUQUcZA/kL2B1DMncjHCaX7l8WupV7iTZzCwpBjNamwfEf1+ImveUnboqtqLv3T7op54nAjh6T9jWN9bRco+6/KnKg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9416.namprd02.prod.outlook.com (2603:10b6:a03:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:36:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:36:21 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 5/9] hw/i386/pc.c: convert pcspk-audiodev object prop to a
 class prop
Date: Mon, 21 Sep 2026 12:35:11 +0100
Message-ID: <20260921113559.1299740-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
References: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: b4526a27-88b8-4cc7-b70e-08df17d48ee8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: saU7pCSSf1kEgzoWjNpJ4u/1/FxOB+yEiB9gPFfQcDsfx+uk7bKsLVgvUsrMJ25kQWPBabMIMhwnrkVw+eoLH8iqnhpKhr7UnhI3Dvcn/fj552RKi95QMqebYUh9pT0h/fC1qVR0dXTVR7vsgd1mOp66Y+zFonTDLq7794c3hNafvqXPHmIDEcx4zj1ILo1e6WVP7hV7hS3cJlfjNFLMsb8bgOjtP+5YEmqd6p/92L3j/fZIiCFgiEs75Q41q0cp+eCmDZTGU3cwYZ9L72HY2TNi4RTbKWCZMTA9S0VtXSCK4Qdn7FNdPzBS1frB2tji3ltalAcvggyl6e+cknVLck5UHq2yxKudMg/lOFbK4UnHJ5Qg8vK67uggQm23+sqKfqDDhsLpsFAmIo/kwuXfkJeM6LUMoz7tbb+4XmwfJFudrVRh01haJcn0XivNvpq4Yh8WWz/W2rJ7UEpZNFfeit7+s6dLfov81Y/7GGsro7mGQFTAfGh/XeVZ23dgeJWGNkFKLz6qpFVGXuhR6hgnzqwfJZm2s2SKJaMgBJWPGvJuqHTBJy1CmtVb3Nrgeq5/Q86jZG4g//9IWSi12o+z7hj2NcErmCmOOw22PHexDKeANFKyTXL0oG3sPYl25jHascgsiGlt5Lb4mzAA+lBm0la86uUhNv1S7Q6ZdJBvYVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVBkSEpkMnVkR1FzdmZhSmpocDF3SVoyejUyQkVjc2N3Zm1nVE5ibFJacTNv?=
 =?utf-8?B?S2ZJU0E4UVlFNnVtSlhscFhQOHFiTVNpZGMvZ2x6TTZWT0p6TmZMTVJOOEVW?=
 =?utf-8?B?VWgyUHdHQ29QSGRJb0xXVEd6alNTM1dyRVFWamFWRzZhM0NLUk5hZ2tiSytj?=
 =?utf-8?B?T3RQcXRTS3JLSnlWd0ZYS1lvc1JJUWRwNmFDTHg5UlJUWFA2YnZEN25udHRk?=
 =?utf-8?B?TmEvcmlyTUV2bDFoeVJ4V2xMclR6SWxkOGFPejAvTlVDdEk5a2dVbHNTM3Nm?=
 =?utf-8?B?WkEzaTI2L3cwakVJM1ZUcVpWdXM2bThrZWJkZDJqUitZNGxtYXNZc2lYN253?=
 =?utf-8?B?Z2s5NHFMT2w4MGhldzdORU40QlBLcHZEa205YlJJM2E3U0huQU9LcWsvY25y?=
 =?utf-8?B?eEthTkRWMkM2WElZUWV2aGlQaENBbjVpcDVCVU5FbFNxYWtnby9nOVlaUGx5?=
 =?utf-8?B?N01odXhveTZJQnllUGo5S1FqTTdKUkx3MkVwRjMxRFUwSjhyUC9ldEJjWUIy?=
 =?utf-8?B?UHhuclJ0SmtkQlB2ZkFSLzVpZUpub0RDUE50cHViOWdoenVnaW1uN2dCUGZP?=
 =?utf-8?B?WG9idzhmRTgzVzI1b05PdmNzMkllWC9UcU5DazFpWnJFdys5Z011NEY4bUVt?=
 =?utf-8?B?VXNsZ25sTlRFTFdTVVpZUys1eHBHbHUwek41Y3RtTlZVTTAwSERlb3pnd05o?=
 =?utf-8?B?eUdUVTQ0WUg4bW96Z0RDaWp2K0s1c0hJT1FOSXVtdzB5akFzSDNtWGIyY2Qv?=
 =?utf-8?B?dkxrQm1WK1daZjgzRTFPSG5zRXA0VjZQRXdla283TWNiSmlyaW85b1M2bzNP?=
 =?utf-8?B?QkozQW1NeE9HL0lsUkhYQmRaVWZKdzZmc0tFREVMNW5oUFU2ZkxVdzNob25n?=
 =?utf-8?B?elBPbWJ1WHRoakpBTzhUVUdaakZ2bXBjZU9oR1JVcTlDTG5zSFVha0JGYlVX?=
 =?utf-8?B?S1ZWb28xWXVvQ0ZVWUtVbnkyVHFUcFZ1L3pKT0NpQk1HZzcyTW1mLyt4K2R1?=
 =?utf-8?B?RXZLcDAyQWVMbDhtTDRLbm81d3MrQ1hKLzZFL2R4VU0rcjdBMmRBR2VvYXIw?=
 =?utf-8?B?a0wwaDVVZUhralVKNC8zbGpQdWthUzFES2RHaWYvSzJoL2hJaW1vbUIxZjhu?=
 =?utf-8?B?cTZ4aFMwRzVURk9FR1FEZEN6SlRCNERJODVDd0s5M3poZHh5UVNEMDFDUkVz?=
 =?utf-8?B?bG5pNVJaZk56Ym9wSzhUTkE5Q3NXeWpaMEh1V3BnaStOdnJjUCtkVE5vRjdi?=
 =?utf-8?B?ZmpsYlZmSzR6TnMvVDF5cmt5andoT1JBZVRlaDA2clFFUWFXczlxUURpbVEy?=
 =?utf-8?B?Q1EraG1oL3J5TEpZTDIxMm13VUE0S0pBSExLS3lFYTBvZ2lwM25EY3dHRlJt?=
 =?utf-8?B?SlZBaG8vV3VpTW01cE90WDNxdDh0Um5CTkx4YXZoNUF1QVlLd1pjbnBrcFJW?=
 =?utf-8?B?LzFTclYwNm8vYlRVb1JkNGxhU2NVOERzR1lTU2d4RTdVU3R0Rk5nWWtKVFlZ?=
 =?utf-8?B?aVd5c3E3NmJ2Z200QVNwWDZrM3VWSDFzMTNCL0w3WEthQ3lwNE5zNnRuOU96?=
 =?utf-8?B?U2ZKTEhRaDZFdGgvUXNuTjR4WUt5SkR3STRud254SGh4N3NmNUZVSW5UVDFN?=
 =?utf-8?B?OVBpclV6cE05OCtEb3h4ODFUNnBQbXZiTmxqaEVHUVFHUFpsbCt1V3RNcW1n?=
 =?utf-8?B?VkNuQlVPc2dabEMxcEs4NWlrUHJrZ1VSQjJhd2xQc1Z3TGd1U1Y3SEtULzNu?=
 =?utf-8?B?amVZdnppNGJZdjZkckx6cGhDUDVOQktzaWF1Ymw2UGhJcmt5dzlUd3pNTitC?=
 =?utf-8?B?YzBkN0YvZmpGRDNPZk85akxLUmR0eHRuWEFFM0hvZ0tGYnVPWGxlMmtmK2Rz?=
 =?utf-8?B?SFRpcG1Yc1Y3dW1HbmpzQ3ZNbDV4UlRyVkJhbnNLOWx5OXNSRUhIY0lzYVFj?=
 =?utf-8?B?NDJFRE1ZZElCSXF5Smx1eWEyNnVOSW5hZE9kSlZLK1ZtVUk2YVpHb1RwbmF6?=
 =?utf-8?B?QzZPclpJbVlCR1YyUTBRNGhNYnZ6djdpVkM1Sm45MHFlTHdlUk0zRTZFWEtX?=
 =?utf-8?B?L2liSFI1SmR0SjdFS3VSYkhXSDBoSTVjdk5nNW43ZXdxM0VJQ2F4VS8ycEFh?=
 =?utf-8?B?aFd2N2tZUWZ0M1dZTHE1RGZXeThhU0xLRktFemJINTlqcGpMVkJzY1o4VE9n?=
 =?utf-8?B?cFhKTWNCVE15R283QkI0N0N4WXpMUldqalZQcnJHQVZQSXFqaHpUMGg1UmNl?=
 =?utf-8?B?bmYxeTM3TytTRURuV1VzMDJyTm45aXk3YjlyR0RXVTNsVmNvdWtvQXE2SW9V?=
 =?utf-8?B?T2h6ODlsRUFTSFhWb0IwUW0xcURVSXE1Um45cFlFNmpPdGdaK0lEcHlpT2xh?=
 =?utf-8?Q?6+DyBWhJ87/7lBZY=3D?=
X-Exchange-RoutingPolicyChecked: ay8XebelOoIsvP9X+saM/OuehVY5Fdy2EqaLF6iro5a4oFCFfUJnKroeD61r2vtO71uNOQ1/lshPNRSsJUFCFucRuHGhGTQ3qvkvTSLBxG7qwsWslHam6PRoGdr2wgTsjalF8AmbBgLNYW7KZh3ZmOEvTvvWQUBmIFfzVnA9VfGj4tYfblxGwqOmnLXPDCSjsjuldGMvQIMc9QH2vSo3+nxo55kLURRgU/N4s6L/WD7l9EH3AOHBoygFb96E21m6v3WBFN+fgF1d95YlPF8nJ6tTDVZ/oB3XY6i6TdLwuoIgD9BclQ79/lvgvNiIyO0c8vrngtiTt2pGrc9Hlv23hA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4526a27-88b8-4cc7-b70e-08df17d48ee8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:36:20.9988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUy9eoS7k2HvbUVrt6QK04McuvdXk9tX8T3zU57uW9C1CIMCod13kxF1+M19/9S8oOKaK8nv9u5n75gkm1LIuIChh5P9KxCshML+E7jHDe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9416
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX/r1Fk4PKwenA
 NVAHWzMVLjlTNPeIofr9IzVeGo7scZm0aHfn42DwS6kWtwTHmpfraISkoqXotqmctP/Z8zIROjT
 Fe1aMkvD15iWfjoxKTmYpIQxAqmzAF9oHoBiddhfl31RPLM4Wv53aoyWCSGxBiqHy2YmjIjszKe
 DKjfy0DWFbQ9HlqKQmbRbF0SN+1OCw5WbNZ2HA8UmaQTt8LW1b+u55h/WR7pN3Gy+2jI88SNXwk
 dTZ2K9PatNdP0ocvdYE8W2y2b2l2+GhLcMkRP8ehkjp6vgebMfPGIAwYc+oOPhRITOmOklW1S6R
 AZ9vhS/vBhVkcIgB6bOowPFLMpPJ3VxFqkxlLQPr+5Yu9wAb1c/FAdupWUhH2JOa3PU6KGn+t9k
 vhatbOQNKPstbOzoT+1tVOFOWey/eQezQUjRSBHGc8gXHLMMCv1ikxF7KYKB+jYQ+nOha1wSC2J
 6MnrOTl6uCWgFS6R05Q==
X-Authority-Analysis: v=2.4 cv=DfeCOftW c=1 sm=1 tr=0 ts=6ab116b6 cx=c_pps
 a=2kU2da9fspT7tSTAg8jXZw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=8KctYGRJMoPV8DWFUvcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX8OSEHu0eVpSx
 F9xw6M//yPVriYpCHG8XkX2AU6DHEvq7yLBCqz87nBtPN0CZn6H1upnjutbFpB7Gp50b6W595eD
 k73WBVVXH5e5CXESTrKsXl2BAalcoEk=
X-Proofpoint-GUID: IcZz-IwVUmzpUJCFR2RQF5JCLVcezZXK
X-Proofpoint-ORIG-GUID: IcZz-IwVUmzpUJCFR2RQF5JCLVcezZXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/i386/pc.h | 2 ++
 hw/i386/pc.c         | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d5dc79df17..2f1603e104 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -38,6 +38,8 @@ typedef struct PCMachineState {
     DeviceState *iommu;
     BusState *idebus[MAX_IDE_BUS];
 
+    Object *alias_pcspk;
+
     /* Configuration options: */
     uint64_t max_ram_below_4g;
     OnOffAuto vmport;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9006e7c29e..e2ee1bd88d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1643,8 +1643,8 @@ static void pc_machine_initfn(Object *obj)
 
     pc_system_flash_create(pcms);
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
-    object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
-                              OBJECT(pcms->pcspk), "audiodev");
+    object_property_set_alias(OBJECT(pcms), "pcspk-audiodev",
+                              OBJECT(pcms->pcspk));
     if (pcmc->pci_enabled) {
         cxl_machine_init(obj, &pcms->cxl_devices_state);
     }
@@ -1788,7 +1788,10 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                           "Set IGVM configuration");
 #endif
 
-
+    object_class_property_add_alias(oc, "pcspk-audiodev",
+                                    offsetof(PCMachineState, alias_pcspk),
+                                    TYPE_PC_SPEAKER,
+                                    "audiodev");
 }
 
 static const TypeInfo pc_machine_info = {
-- 
2.43.0


