Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F33EDF142
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqq0S-0007OA-B4; Fri, 13 Feb 2026 05:02:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqq0P-0007Nv-K4
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:02:33 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqq0K-0001xt-9M
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:02:33 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D9PfHS754250; Fri, 13 Feb 2026 02:02:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=VIpn9sqDdKZw4qHsxMb4RM/t/9e/8NRm03dLYKB8L
 Iw=; b=LkrIkljW9kZlQQ860DPsYFyjuffGnVO236IlxuJk3er3ABRsfAXI8eH2k
 HRztsUu4oPGG+skdC+b8ZIN7jjhaZNirvgA/9nVpTUcvYARQRzn+Yw4SygEr25vg
 heD32Mm1ST9k0/nStTibgggnU8Absv4mHGhUBK9TMc07QzY2c3wl6vcNfRwC8AZc
 PqSUBWACYPyLnhHX3/rR1wNx+1umVIhgezrVd+oF8wDs7NdZErk/+QAc5MtiZx+8
 XIRuIk7b5/knZavnyyI9KGiFj/CnEuCDFc67ct/iRR3VKzhpxGlJxJzhhSOLpIt+
 2ry54hdUVWf36UDp7M5Gy5e+wZMSg==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11022105.outbound.protection.outlook.com [40.107.209.105])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8ctc8k47-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 02:02:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgQ7b8ndnoS+YbQUunsGvnWGdBt72WqttDcWXmlTvmdi1BtH7fyaxemr7s0g8tSVdjrXU5dlrSAcVryZAIbQi4sbdu5OYb8kutQWjYGSan3BY/gZcsijaNHIRGHsxRoUN006yWT8xueO8uzBfZmHYMZRI9Gb3ZEQ0rl9F0peQlIaNXXzSLCRtRDq7sahzlu8+gihfEdVv0sdhsaFpnwr0HxOma1lr9cmDxAzK7aeHL042e7A7ZSVmuJnRx4TSmRBlXksKSXVbiJcTqIJlLyPs2/ql7swba54M9o1vORO2VZYt37NTLZ6tLgYHP+AiVpdyPD3lX229fRE0koiLQ8dBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIpn9sqDdKZw4qHsxMb4RM/t/9e/8NRm03dLYKB8LIw=;
 b=VDAsott2+WUjUEKCFBEMZemi1T1gMviVRGdYCjRembj6zFTojIBrVb1tzGr4ZasRml+oUo443v8/DVqBEwRV3cKyMUGnzKtxLfSvodFyX6/6sX4NzlxH3YH4BmskCKIUTjsv+BoaEu4C5bEP11Nw43sb95upJkjM3mxk2nM5yPfrKXphiovaaRGDK9eq2nF3xN5I1+S13VKR2qqvV+JvCK4h28wrOhK5qU4GViJx6+mjBqxDGUf4KEXEeXhNsPxyoZfL2OTi8J7XT8Wan0svpGXrbDifyfQEVxbltVMsRHnRRIB3/pgpcQX1TXBFYHNoCizjdv+OWSdKcokOUsQ+fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIpn9sqDdKZw4qHsxMb4RM/t/9e/8NRm03dLYKB8LIw=;
 b=edHZOErkZH1fZ7aPM/ss2slyTl5C4RRuoOtoBnjauqa/oJ3Gy4ABPBWLNzJzhh8ePo9MPRvyZHmgLHVi46VZ5CDq5cgNtN8t7jCyrV7x3nYToLG6suqMqpArAnQzYTb9Qu85jAu05gul/zvmB9u0PUVCQjH0/d8XfXB7rs7CtzGPUQbOJYMF0pj9pBkukER6/HhkOzkaCVCRrdbQ3RfEwsLp20E1++FMUEm+z1VvIEQz5J9SGd2odtuB1BFMu0SfHOrCkoytST+flCefK11JkXAZWHZNCi8gaNrhcqwgWAIkuUn69iGc2cKzlCsQctIB7Sqr1BReJM3YYuJGgawInQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6848.namprd02.prod.outlook.com (2603:10b6:208:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 10:02:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:02:23 +0000
Message-ID: <0d777b9b-779e-4566-8651-fc6eecc5babc@nutanix.com>
Date: Fri, 13 Feb 2026 10:02:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/43] audio/sdl: convert to QOM lifecycle methods
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-9-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-9-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0415.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: e99e779d-ef1a-47fc-6a1f-08de6ae6fbef
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEJhZzFraS96L0FJTm5BS2ZTdUNzNmJ6eWFHWE9VSkdZaE51RWZYYTZ0emVr?=
 =?utf-8?B?MkdyZk9IZzIzRU9EaFd0VkhxSDJIU3hqVnRta0s2bm5YVTU3a0ZGU1VoUFU2?=
 =?utf-8?B?QnpiZitNa1JCT210elZuWGhROExxcHVrUmZFSi9NK0o4ckR0TnVlYnRvQUtH?=
 =?utf-8?B?OXJoRFU0WDEzTC83VVJoRS9tdDB2KzlXdFVVb21QQ1g5UG92cWtwd3dUalh3?=
 =?utf-8?B?em9kMWJQT1NKSFpsT0JyeSsyUTlrVCtaamxiVlpZT1lPekxTMXo0R2ZWcnpV?=
 =?utf-8?B?eWlrSm53djliMHJoZk9xQUtQRjdyNXQ1S2dYd2M1ZFhYOGk4Y1VYbmJSalZn?=
 =?utf-8?B?REd6bXNsQnJrVERCMng0RG1JWVMrZUhsaEN4NnIvMVNuOXk2NUZoY08ydWx6?=
 =?utf-8?B?UE1ZMkd1em8zUFlrMVhnRWpaMkorQ0RJNXBGRjBkWk1UbzlTeXlUOERTZ2xU?=
 =?utf-8?B?WFp6OFkxWnRIN2JEUlQ1WVhEYUYvNGpNaWF3UTJtdnpsQ1dRV1FhQ2JRQkdj?=
 =?utf-8?B?N3lZbVA0YmwzUXZXeWsrSlhlVzc5NEE0b2JQd1VOaFpUSnJnbVVYaStYUnBS?=
 =?utf-8?B?L1VReUhzTyticnBJNUVNSmFaSHV0anBXSkpQbm1ML1JHS2ppdVVId3lrRkJr?=
 =?utf-8?B?NGQ3aVZTbTI4YXMzVEhaRmtIYjhUVHBFcnIxYVN2Rmc0U0xYay92NVBHZ1ps?=
 =?utf-8?B?UVBhNmRLMVViQzYrT3owTVkxb2JhUlNLTGJ2S2xQSEhGWW94QTRUdHBwR1k2?=
 =?utf-8?B?NHRXMEtCMW1jRE5KbjRCWUFCMzh0by9EYlR3SGducmNXT0FsclAvWFFpTEN2?=
 =?utf-8?B?akxwRlVPRHZnb1VxSWlMSVYrWWk1OEE3N0N5Vm1McDluSlJPQzhwcUkyMFZJ?=
 =?utf-8?B?ejZUVWhFSFEwT2xFSjdKSGZqNEN5b2lwdXQxQWpqM2xXQm9lMUxDSnd2Q2Vm?=
 =?utf-8?B?Z1BVZDZxc1dzZXgvVGNiSStvK3dhM2dsQlZEaEJwM3ZPTFVDa2U1Y3d2K2Zl?=
 =?utf-8?B?MUhBeUhSUmYxSDFYN2hGWDhyNWt6bmZ3WmFIeWdUNys4dFFlWlhLY0RVMytT?=
 =?utf-8?B?Y2FhSDB3bFc2d05vWWIzMmg0Um1ySkVZWURhaE5MUnJQY2N4Uk5adFRnVmNU?=
 =?utf-8?B?WUZSZ3JxVjZnbVEvTjZRTTZ4cUtyZVBmU1FxbTlNOWpURnJHc0dtVkg5Tjhw?=
 =?utf-8?B?QWpaZG5PbWIxU1B3bUVoQzhTM2dxdWZvaDErd256Z0tJYkQ1dlBKR0tncHRt?=
 =?utf-8?B?WGdPWXNHSktRZzJVLzhza0RuUEExdlZWTmFuUytFY1JWZytpbVlPek9mMzlo?=
 =?utf-8?B?eHIrOHBzcFlaTEJldGxrdFJhVjlXNi9mRmlCbjhuYUdpaHYwUTNNTEg2SnRt?=
 =?utf-8?B?QzJ2d3VxaHQxdHo5U0JhVGJZRi9xdENsVzlCeUNGcXc3M2duTERhN2s3aEdK?=
 =?utf-8?B?ZkFobTR3cWowcU9CeE1wOW9iMmYxTnBxV1B4ZFJDVndJcWN2REFmWHltME5H?=
 =?utf-8?B?ZTBJZ3AzRDhvanVhd1pUTUhmMnpUa2JQaExCbWRFWmpNVkI5cXFwbzRHbUVG?=
 =?utf-8?B?ZVlRSjF0WHlSTGUzVUJ2ZGUvUk9jcVV5dEF4c0RLS21pdVp5ZkwvMHdwalVC?=
 =?utf-8?B?dE90NThVbmYrTFZVNEJLR0FISzFvWE9COWpFWk5ZV1NVQUhvZDk2UXRaNWFI?=
 =?utf-8?B?TjJiRllLNGVkdkhubGhMVmhiME0vT0pEeGxka0k1T3l1M0xLdG02YURmY01O?=
 =?utf-8?B?QlN2SXpzcGw0SXkvVWFuQ3hmaEZOQVN5V3UzQmJaQ0JidGI0UjFLQU12YjVU?=
 =?utf-8?B?WEJ1N0dmRUdvdDF3WGtoVHY2eWhNMlVOa2w5TlZnNW0vbU85dmVmMzVsekd4?=
 =?utf-8?B?MVFWNHBzMHMzczl1ZHNWZzhnV3JNNi9SZThMY3VoQXFtNEhpa2RDWENJLy9U?=
 =?utf-8?B?amFobFRZQktqRHFZYVRML215TjJQayt0ekw0YzRGTngrclAzQUs4Vi9GRkl2?=
 =?utf-8?B?WW1aazZwMEhTOHd6QWJDdk9ZUlA4S0E3ckhIb3lOangrNDlaeFNybHJnUDdD?=
 =?utf-8?B?RUN5M0RzYWNUNUpYMXJ6bUo4R0pteWZQSmZ1Vlc5ZjZLRDkwdlhyWVZsRnhl?=
 =?utf-8?Q?w2BE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlY1ODVPaVNHVzhUa3Fsb21hUDhVaGU0bFVoWjU0U0cxeEFaTTduQUtuS08y?=
 =?utf-8?B?RXY1c05IOXVyQnc0U1FyM1RoTjlnSVk0NUVoWWVnSUdUdzhucFd1bkl0RnVu?=
 =?utf-8?B?VC84WUNYcWZwcERRekg3cFo0NWc3WmtvRmdXYmJQQXdLK2ZhZU5PWVBzYWM3?=
 =?utf-8?B?c01hZjNXSEZ0eWROUWpydkttd3dlNXpmVHQwV2Y2bzRKbmRNdjNJbXlXMGhK?=
 =?utf-8?B?NGlMcFBxK2NDa2FsT0YrcTE2Sm5VK3F2VUhZV0tzaXpPdXlhaUNOL0lPYUpX?=
 =?utf-8?B?dG5uQjFEVER2bzV0bjUrelYwWS9nVUMxWjhFc21lNXBCb0hOeGpGS0FGRGcw?=
 =?utf-8?B?MFV4ZVJzQWxTSlIvMjNzSWVQS0MwcGc4YTVOdm5QR2lBVnpIbDZwOTc3S3JQ?=
 =?utf-8?B?bWN5bEwzTW04b0lQN1Q2TE9IT1lnck40Z3hoVHF3d0pSYStKZTZtcG5zWnNs?=
 =?utf-8?B?dDJmbVp2eXZMdW11RUl3cVpiK1R4K2RCSFBqRmZwWFk0WVFKT1JnMGpKODFO?=
 =?utf-8?B?NUV0cHF2SHVVVG9RZFRLS2pxSlFGeStwcXRESitQUkZkRlpYOVpwV05tZ01z?=
 =?utf-8?B?Umlxd2l1SWxOcEJyT3B4Z1ZFcmxhTVpkVTgvSGUwa21JRS92RnhWTU9XOUdJ?=
 =?utf-8?B?ZmhjNGQ0c0JDb1FuT3dOUHI3cFJSN3dKQWNmUlFFZTdNbWhqSnB2elpCaW45?=
 =?utf-8?B?U0N4d0h5Zm1VZnlNZEMxTHFZSG8ySlkrS2ltTTRvY2ZIY1BDVWhZOThNY3ND?=
 =?utf-8?B?aW5yZ1grYzVEbk10SDBPb0lLZzhHS2pHNnN4Q2VwdmtuT2wyQ2tGcFJ6eEph?=
 =?utf-8?B?dWR5TSszakszbWZkRm5SRjNaZUxJcGZ6Z25zTnI0dk9uRDNZdkFKRjRLMm4x?=
 =?utf-8?B?NGRtb2dWZHZoajY5amR0YytjVEFnSytaNTNVS0oydWcwb1JoZjFHaGxyNGJp?=
 =?utf-8?B?QXhVL2tWYWxsOGxpa2pSSGtQaHdzNk9YTTgzdkFNOEI1R3plejdJaDRCNGxz?=
 =?utf-8?B?aGJaQSthWWpEc2RvdHdDNHo1Z3hveVljbDd2NEhORVoyY0ZORjhoeFI3VzdR?=
 =?utf-8?B?RWFYYjRmUHFaeVE5WmRxckZlQmwrQ3VONG5lbnVIQzVMdkxnOW1nbkJIZndJ?=
 =?utf-8?B?T2p0WGRYR0FlbDUvbmZXdUJyTTJPOWZjL29hSm5oM0dUTHBSaEV3b3o3R1Rv?=
 =?utf-8?B?alhTYVdiMXVZSkY2N0QyZWI0anFESk8rZ01OaWdxWjlpa3g0MHZqZlY1ZWV0?=
 =?utf-8?B?SHJzK1NreHFwOGNwR2ZHcVJ1T0cvVmJSZHd4dzVNVTV0MXdwNXFwcHRJUEVn?=
 =?utf-8?B?cHZIVEZhVWw2VkYxQ2lqWFVEVUMyMmxZRk1BT1dkRC9kSHV3ZEJGQmNPbzhV?=
 =?utf-8?B?ZkdsQUg2MUNoK2lkTDhPOUJ1L1Y1S2pHenVHNVA2QytyYU5nZEVRYW83NE1I?=
 =?utf-8?B?RW1KVjR2aG9hSWIyU1E4cGlxYzV1R0JOcnRsOG5hMjhFS1d5SWtyaktocUNl?=
 =?utf-8?B?S255K0RWS0Y2eDE4d09SVFM3amkyVFQvNXdqeGJDd3hwaDJSRUZqaEFjcFEz?=
 =?utf-8?B?V3lPL3pMRzhtUEpGemp2UHVVdm10YzhLQ0ZHUUk4NVczSEJlRzEyTDA3TGEr?=
 =?utf-8?B?NjdicER1WXBMUnVYVTFMd1lUTmRXemlEWGhET3AvT0RyakhqOFMzYmplNzhV?=
 =?utf-8?B?bXNlYlZXd253Y21uQVMyUC8reEQ2VlBVcEI1ZmE5bDJ5WnpuRmk0ZWsxUVlz?=
 =?utf-8?B?S3BKdVd2ZGtFTkFyRXVTWmUyMjFNYWtObllCSkhsRndCSE5ZZCs2ZzFUeEta?=
 =?utf-8?B?K1lsZnlWRzNDMWNtb1FJeit0SGVHNVVGemxuaG42NDJ2U05ZRGM2ZnR3UWpw?=
 =?utf-8?B?T05UYXprWUw5TjdNWDg0SVR1MFM3cDBRUFNTNUdhRWxwaUFtRVdjNFoxZWJ3?=
 =?utf-8?B?MVJURDY1RnJJcXBZRXpid2FFZllZOGhKTk1KWFZzMThvajU5SHF0dU5BcU1o?=
 =?utf-8?B?eEV2N0VJMG1jeDBwalZ1MW0yV1lEb0RndHY2VUE2dDNYY25SWWhSMm9uMVlC?=
 =?utf-8?B?dnRKT2lKQUF2Uk1CTjVTRkNJby83b1FLZWlSeG84TEdUNjhXWnh1SHNiUHNE?=
 =?utf-8?B?SDBFRHNkS3hFWU1mbnVDYjYrVnlaSWN4KzU3MEZ1Wml1b1Z5UWdRZm40bEVa?=
 =?utf-8?B?Zi9rMnU5a05sZzlLWTVHU0pmaTJOblRmbSs5UDdXaGpnb2xOTlYrcXlqS1VC?=
 =?utf-8?B?SHhoYjdiT25yNE5QQUUzTG43Y0oxcjNkaFRWTnRIK3JLVGpLeER2bmR5Vnd3?=
 =?utf-8?B?QXlKWE9EZjdvWk50YlNQZmtId045VFFoZDJGa0diRmlpRjRmRWExNlFKalZp?=
 =?utf-8?Q?9OjZ8ajmvzUrGKO4=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99e779d-ef1a-47fc-6a1f-08de6ae6fbef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:02:23.6018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZ3j0QD8PP4ekrKn2gH4Ht9jdZ6gzhgTSijOzauthAzXR6rgHLpRBIqh5v6ngCF1TmdTq/o5SavYTW3QNj1DZcGLCX5dzzwOEAcEP3wQA1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6848
X-Authority-Analysis: v=2.4 cv=Yd+wJgRf c=1 sm=1 tr=0 ts=698ef6b1 cx=c_pps
 a=5fNYnt3/gC+uMcP5UkWVcQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=BfMGIashPQeTL7_EzHoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: utU62OOgaTjoI4J6bpBat3XeXUoKS7on
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3NiBTYWx0ZWRfX3sjau8dWUnJ1
 RwanPiZIU+N+iVqnV2DmOgKvveFmH0hq6pctSwarHtfJFDMm2AsWaS/+qb4zh8fZ6RhGanLUKfN
 +5panLSNIHlD/jDKPkuFl7L6ETUG9r1foAPnRFinUahqLydUXYDgU2JdjtsV00aYK+m8jaUbMN/
 aDls8VJvr1W/lODw1KDxQnyeeYC8lUiHZJyn/o3KTQy/TcvtXDfPZAQMuSvshKsfnQld3Cpp8xS
 4CnqG6WfFYqUOMS40qOK0N59Zf1hVzUgZLn5yKwh8Q6sX139rxxrIMFqEykcttXod5j47oexUw/
 BfGkdfPzwfvrY6ECZlouh8BqRYt82ZIr/i74+oRuSDOMlNXXl2KEPdXafhDzBd+FcRanMj3/n5u
 ft+6QXD+pLf19/y0OmlUpLxfs5bh3Ziu0a39CXD0aXLahQi/mpPRmbjDodKeulUQkdsoF3OOf/S
 ttJ2K7Lt5bABdsF9MbA==
X-Proofpoint-GUID: utU62OOgaTjoI4J6bpBat3XeXUoKS7on
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Migrate the SDL audio backend from the legacy driver init/fini
> callbacks to proper QOM realize and finalize methods.
> 
> The sdl_audio_init() function is replaced with audio_sdl_realize(),
> which initializes the SDL audio subsystem before delegating to the
> parent class realize method. The sdl_audio_fini() is replaced with
> audio_sdl_finalize() to properly clean up the SDL audio subsystem.
> 
> Access to the Audiodev is now through hw->s->dev instead of the
> drv_opaque pointer.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/sdlaudio.c | 40 +++++++++++++++++++++++-----------------
>   1 file changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> index 1a5e3f8a969..aa3c0922199 100644
> --- a/audio/sdlaudio.c
> +++ b/audio/sdlaudio.c
> @@ -44,19 +44,14 @@
>   #define TYPE_AUDIO_SDL "audio-sdl"
>   OBJECT_DECLARE_SIMPLE_TYPE(AudioSdl, AUDIO_SDL)
>   
> +static AudioBackendClass *audio_sdl_parent_class;
> +
>   struct AudioSdl {
>       AudioMixengBackend parent;
>   };
>   
>   static struct audio_driver sdl_audio_driver;
>   
> -static void audio_sdl_class_init(ObjectClass *klass, const void *data)
> -{
> -    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> -
> -    k->driver = &sdl_audio_driver;
> -}
> -
>   typedef struct SDLVoiceOut {
>       HWVoiceOut hw;
>       int exit;
> @@ -356,7 +351,7 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as,
>       SDLVoiceOut *sdl = (SDLVoiceOut *)hw;
>       SDL_AudioSpec req, obt;
>       int err;
> -    Audiodev *dev = drv_opaque;
> +    Audiodev *dev = hw->s->dev;
>       AudiodevSdlPerDirectionOptions *spdo = dev->u.sdl.out;
>       struct audsettings obt_as;
>   
> @@ -412,7 +407,7 @@ static int sdl_init_in(HWVoiceIn *hw, audsettings *as, void *drv_opaque)
>       SDLVoiceIn *sdl = (SDLVoiceIn *)hw;
>       SDL_AudioSpec req, obt;
>       int err;
> -    Audiodev *dev = drv_opaque;
> +    Audiodev *dev = hw->s->dev;
>       AudiodevSdlPerDirectionOptions *spdo = dev->u.sdl.in;
>       struct audsettings obt_as;
>   
> @@ -459,19 +454,20 @@ static void sdl_enable_in(HWVoiceIn *hw, bool enable)
>       SDL_PauseAudioDevice(sdl->devid, !enable);
>   }
>   
> -static void *sdl_audio_init(Audiodev *dev, Error **errp)
> +static bool audio_sdl_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
>   {
> -    if (SDL_InitSubSystem (SDL_INIT_AUDIO)) {
> +    if (SDL_InitSubSystem(SDL_INIT_AUDIO)) {
>           error_setg(errp, "SDL failed to initialize audio subsystem");
> -        return NULL;
> +        qapi_free_Audiodev(dev);
> +        return false;
>       }
>   
> -    return dev;
> +    return audio_sdl_parent_class->realize(abe, dev, errp);
>   }
>   
> -static void sdl_audio_fini (void *opaque)
> +static void audio_sdl_finalize(Object *obj)
>   {
> -    SDL_QuitSubSystem (SDL_INIT_AUDIO);
> +    SDL_QuitSubSystem(SDL_INIT_AUDIO);
>   }
>   
>   static struct audio_pcm_ops sdl_pcm_ops = {
> @@ -499,8 +495,6 @@ static struct audio_pcm_ops sdl_pcm_ops = {
>   
>   static struct audio_driver sdl_audio_driver = {
>       .name           = "sdl",
> -    .init           = sdl_audio_init,
> -    .fini           = sdl_audio_fini,
>       .pcm_ops        = &sdl_pcm_ops,
>       .max_voices_out = INT_MAX,
>       .max_voices_in  = INT_MAX,
> @@ -508,11 +502,23 @@ static struct audio_driver sdl_audio_driver = {
>       .voice_size_in  = sizeof(SDLVoiceIn),
>   };
>   
> +static void audio_sdl_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    audio_sdl_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
> +
> +    b->realize = audio_sdl_realize;
> +    k->driver = &sdl_audio_driver;
> +}
> +
>   static const TypeInfo audio_sdl_info = {
>       .name = TYPE_AUDIO_SDL,
>       .parent = TYPE_AUDIO_MIXENG_BACKEND,
>       .instance_size = sizeof(AudioSdl),
>       .class_init = audio_sdl_class_init,
> +    .instance_finalize = audio_sdl_finalize,
>   };
>   
>   static void register_audio_sdl(void)

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


