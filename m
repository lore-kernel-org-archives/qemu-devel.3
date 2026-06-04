Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CC1CD6E57
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4H2-00087j-Nx; Thu, 04 Jun 2026 05:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wV4H0-00087N-JD
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:21:58 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wV4Gy-0007iq-7l
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 05:21:58 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65496lIs2634846; Thu, 4 Jun 2026 02:21:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=2kIxREvWC7VxVvxrZJ2wfndP3aG2y8ZLsWSk/XGw8
 LM=; b=KZHkeurpKD1IvIfutVJCMM6WZ3du936Bg6Bzgr47Efu5a5PJ14tOpfk5T
 aGd7OO+7uYgktRoqM6kpACBxK3/VCY78ngg4PliM42RlCh77ql8xgbgho4S4iCVd
 AwuE4bhOqrwdncHzsa9ZNkj+a09PJMPXFdTDxqUskwd/5rbbJsskmy6UnCRs+EG1
 hHdyoFd6E8MRtQ8MioZNsndxdrn4FVbe0+mslr/V+Oy6LwrErEDSrcZpa2o5qMQN
 k3jTiuCuSPaYRRs4jzFybogdzYc0muwMMdQtSeRIXuMD4/Hg95dyX7rknHgMqOzO
 IldOZzpThAK6APffldbBaewG666tQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023083.outbound.protection.outlook.com
 [40.93.196.83])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ejuup9d0x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2026 02:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Afn5bLGeLLcoTcWKX+6N7wQo2AkIqSfltwkfghUNfTIDAhNuXHEyj9E66OZopyiWlTiuebfCA9hcLxkBEODjUPOexVVVzBqGAnoNciMxP3K+9MnaLRnEgw5bo7a7Zlbtp2lafZmQKGnvlsQveqcqUT8WEXp+vTtvzoI7SAe6CHKZpUOQjNeyW/yvJ56PT9AnUkul+lpYpEgcntlWm0Gth5yH2eAyGoAeOBRF8YX5y5gJ671aJxpc+gASnbtJOASHHW3V7R1CWetCHAEIxg10yYQlm6bCMsI0vRlbv2YvH+1Jb/WF6QUAlSUWENz5KxGy+J7FO/1CGc7Zi+Z9a/hBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kIxREvWC7VxVvxrZJ2wfndP3aG2y8ZLsWSk/XGw8LM=;
 b=ZxDHuubBR8YEN5c/WLAbQJ6jVHIApSmjQLeLpwhRJF9yxVB87qgFZh5O8/3W+GM40aeW+rjzxtVBmgo57S1vW4LAGjSIynVZYuwYEHcPbeSt67jQFLPqFbVh4QVLO/++JQB96OVTkOMAyrs03iRYSjCbj8XVphYsS2vMXs8ia5y9JNah7lnHFXPyhPAmwxgeZJpAaXthX1apKn2Z5PUdzxtFUESP8mOtIHk9sjz1bJFx3p6mnn4shemyZFmGXBrMo4QaWaI9dsTGCWgrHZIXCDreRChn8nXFusy7vRxSjtMWtl+ZylQmYXihW6L8rsHcw3ceRIxsqzV24j9yhgFyAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kIxREvWC7VxVvxrZJ2wfndP3aG2y8ZLsWSk/XGw8LM=;
 b=NZFkodxjRfn9GRW8gLmcNJ7m9m92lRCECMiaI1HD+t4ylUbPzv08gWQUzncxaXJtkOczwcTUDMo+0k9dHLhAa0+w1+7gOrJ576r/OQjPp1rzimjRy1DlhhkwCaGm7caRyYbnaO89skmKDxmfxQ8NsDAMsj8aONzM9s0s2AO1Jr5IMmM8fmXgZAAyy/d19zwGuALUxLcWujWehw3nYRnRl1Mm85BU8V4jthi7PxSanUFLL7stpjvwOHxjrNgXc123uWf8fiwCcBzhTSeCFiTo4epj8WvTuIWC/zfPShWkoJfaLmIuJtHUOmPgrknzdHUMPPOIc7+fUapWAopCpwCYNg==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by IA0PR02MB9752.namprd02.prod.outlook.com (2603:10b6:208:487::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 09:21:51 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 09:21:51 +0000
Message-ID: <0ec66128-d2f0-49e8-b1e7-5602b3cd662f@nutanix.com>
Date: Thu, 4 Jun 2026 10:21:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] migration/vl: Allow set parameters with -incoming
 config:*
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260528212947.368132-1-peterx@redhat.com>
 <20260528212947.368132-2-peterx@redhat.com> <87pl2ftc12.fsf@suse.de>
 <ahmrcVkOWW5iwozk@x1.local> <87cxyetbc4.fsf@suse.de>
 <ah36ZhBP2TweYhg0@x1.local> <87zf1d6p24.fsf@suse.de>
 <12cf9760-831a-410c-b8dd-a9bc6befbae3@nutanix.com>
 <aiBOg66Txxwv6w3I@x1.local>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <aiBOg66Txxwv6w3I@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0012.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::17) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|IA0PR02MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a08883-e337-4617-5c98-08dec21ab5da
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|3023799007|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WP6DqIsWuelUQzniXPdvbjtmg7fi1e5Ss/MX9iQZXZX7STJYWjvBMLc2IripQnsLP22eD5euulHMnM3E0aBM9F2Dbp/etdpQaH+LPJMVK1TWRK2RyJdJbJNi6ttlq90/rwkXMts4mOFJoiWtrHWc1ecuZOkxgLT6pyeh8kndZMjW8wTzVax5pgTm3Q9Jn5odebZMVJYbQnktJ6ao9UYivTlN7DrJuNgM+c2wLd2EX1uvPfckXLlPt0sIJ8ed5Fz7TmwMBfkTaJOdtoLs6Ga/lCW+xGOqx5sZZfELVfZ/BxSE8zWGi2cspyUsuewDm0iRxoVOg2nWwrjTH8+1eB/SmXfkJuX9FAERrGYQlmGvGF1g7MqaFVSYucLrwvSX72BuavXmXCZxl2NjEpewmFxA8a0dab+F/ceIh84byoNJrHVFRl7jVXhAgeGK60PYYNxHi5HGYLRABCnGqV8fBs5a4OumjboiuiNa13Y5/X6e8uiOe6OrSxNAkgFMGZsTOE4ILK5ibDaoJyoK1eOEgZas8ZsnOEuynsYJwsDJDcR/GSxLron3gAnd6ZNjli8rAZYX+02yzZvPdR91RkTJ2zbBfPpafRt5HisZ2Maw7zS+tHBA3JYb2JppvpNQFr53NgW6Ab+UsrYRp0ug3VudA/bUZhdkNvm74ygx2WmFJWVFBE62WdUxlcEC43fF/j8T/28b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(3023799007)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWFBbmpRU1h0bjY4S3dlc25IM0JvVi9IQ2EwWFk0bFo0RlFSTnRhdVF5Nzgx?=
 =?utf-8?B?c3czN2JoYmFZRkFWbkdvN1pnKzFDTHE5RVdtNkVuclMrZjF0dWRGbDQraHJP?=
 =?utf-8?B?M2s2WVZybTNYT3dtbngvN2hvMHJGTXVxaHBFY29hK2FIaXFvV1U2ZkNpYzhs?=
 =?utf-8?B?N0lZSzA5OHVnV3RzSTM5SHg1Q3JsK0RyZVpzQys1UGt3QVo4a0M1M2JLcmlr?=
 =?utf-8?B?bjlMN0l3dVM2akNMWExyT3lKRkRvRS82Z0RIZE5SdndjNEg5eWZWMm5uQ0Fk?=
 =?utf-8?B?ZWNobTFrMFJ4TERpWEtZOG05TzhCUFpzT2pnUWlKMnpPRldtZHRnejJES0o4?=
 =?utf-8?B?RnR2ZGNWYnZPU0lCaTFTRk5uS0tJMDlnK2V6R2pML0UwMEFEUE1rZkdoU1RV?=
 =?utf-8?B?M0hCbXJ1VEJUOEwzWW9nT1RSV2wrcktIWEtVUW9CSGlMWDVMZ0NmQ0FLdHkw?=
 =?utf-8?B?STk5YUFQbXhaUUhHWEQ2dVJWdUNTOStBZGZvOHdlZ1IvWGVyTWFlckJPbGR4?=
 =?utf-8?B?OGxnU3JrUmZvMzFTTm9IeWNGZkQ2emE2QW5MK1h4UllzWktwWTdIWlNUMmJT?=
 =?utf-8?B?VGRQdjJXS2ZFRGhBcDNHa041ZFVzRVdyQUgvTWQxaENGTWNjRXZFZlRHbFlo?=
 =?utf-8?B?d3F0bjAyb2cvZGw0RGRUcXY4L0ZodDE3ZHI5aEx4TDBzNHdGZHRoQTRycTlp?=
 =?utf-8?B?QUpXQkprK1ZBNW1wYmpDeFBVVWduOXNCMXZVaWlIaHVRblRob0Fvenp2bHNI?=
 =?utf-8?B?M3ZGYXBwSmhIWCtINWRqRHFrdnVOVWlsdjNGbHF4bHVLeVIzMUErZHloVDFQ?=
 =?utf-8?B?NXhOY081WXhPQ3pIaFJoOG1RS0JpV2t3dVlNdGlSUk9FczhzZGpSUDJ4MVhJ?=
 =?utf-8?B?cXpaRjhJbDB2Rm1GRkZLYlVDMnZxNzVBTVJOMSs5akJmNndhR3Y3UWZzYXJE?=
 =?utf-8?B?K1I1SDVSMWMvRHFVYzYySGx0Z0pFazkvWHIxdTkyZDdtTnRESHFWbGd1OVRr?=
 =?utf-8?B?K1d0eHZvY09pYVlOd1UwRng1U2R3MVV2TDdqekU1WG1POUhvSGltMFJOczNs?=
 =?utf-8?B?ckU1dnMvaWxiZFhoSjd4NktWdXlFVGpSSHZyeWFCOC9jTEprV3NxUDIyaks2?=
 =?utf-8?B?MHNvTmMwc3dtQmFwaGZGbkhjT3dyQm9mR2RYZ0dZNXFFSWxVUUMwNndtMWs4?=
 =?utf-8?B?Yzl4aWYrTjJDWXJhMXpKVXdMQ2tsUlF4cFhmN0d1MFBuUk5KWTlXZXQ5MnBV?=
 =?utf-8?B?dk11QzI0dVdxVTJDdTRCQUFrL3FmYjlBOG1PNFMrYUhJSzZ4endtVm9OWVZJ?=
 =?utf-8?B?MTJUK1JHR0gxV2M1RllSajdVTDlEbDUxSktsd0tWWFZxRDdpZURFUGFScnFD?=
 =?utf-8?B?SVgrbHp1cG9ubjZRKysybVlma0dRN0hVMzhWZ2l2QjUwSkdLVVlmR0xNSklY?=
 =?utf-8?B?UXE5dTNIWkhGd2dCVkFPdnpHbnp2eUVEb05pV3dWMlFSTnNlVTc4WlVYOG15?=
 =?utf-8?B?T0xFSXQraTZvRW9Ca0YwZGZGVVBzNEEwUlowTWtYTURPNHVLTDZ6aTBWb1dC?=
 =?utf-8?B?M3Q4NW5OWWlpR1VsNVp2S3hYN0MyUFc2MVlzaTh0MEMxQmh5YkY2VWJLVG9R?=
 =?utf-8?B?YmRnQzlKMTErU0FITXNGQkRBUWJiT0tkRlNqSEdYZ1VieHJXcDk1OUZtMjhM?=
 =?utf-8?B?ZjR4M2F3Y1IxZ0N6YjhGbU5MVG5vajh4ZGd1R3JBcC9KWmFZbU42QTcrNHJG?=
 =?utf-8?B?blF3TTlGdk5ZbVdJZDc3T1JUOEVJWGZTWkZvYWh0UkdMVjVsWjhPeENrR3Zo?=
 =?utf-8?B?cnN1SHpOL3kwajRGUVQ5M3F3V011YldWZ0FHcFhrekJXU1NZNTMxVkZGdy9O?=
 =?utf-8?B?SDdJdUR5L09renJ3c0JGUjU5bDNGU05jbjgxdWh1S3I5UWhIaEdIUGZoZXEw?=
 =?utf-8?B?MndPZ0wwWWF2UExCS3NwZzlWVnU5bDdOMGZHMG9tZy9XTFpuOGJwcHhxaHc4?=
 =?utf-8?B?TnpZK1MyTHdiemlNcjNVaytrYkJOejZyKzRtY0t3ZHhGc0g4SnRGdHFFa1VP?=
 =?utf-8?B?NGU1elVTaWIzOCtIVFdZREJYTkNOeVl6K3Y4dG5JdlBsWHEzQW9Yd3VwNW5J?=
 =?utf-8?B?V3pSSW5mNHo2bWYzUE1uMnpuaHUwVkFPODNjOHQ5akVZcldNMXhHNGtjZUY4?=
 =?utf-8?B?Umc1SmlKZjByUTcrTHNyMnl6eTZPd3Yrd3RPQ20wZ0lsQ2F5Z011R0paTzRs?=
 =?utf-8?B?d2FLcGxWOUdKQzkrS2dLSTNTQkNtczJsdVh0MW9CVHF5cGJtaEh2YU5tZHhj?=
 =?utf-8?B?aUo5anBOY3l5R3ozQXgvWWJyVW5XRGlMM01uc0FPK0x2VVpLT3RDOFdiZ2VJ?=
 =?utf-8?Q?pXIwF0/FX9P6FruM=3D?=
X-Exchange-RoutingPolicyChecked: KQSgTu1lxVAzSSvhA07Jwui8dRpdUfnZJoYA4YIS6NkRmGOaShZoiIJAM0JcNW3jEwxn5p+vmTJEZYLISzW6jnMZRdYOiQ8qxlOOMdBYz6ysfA0vNiBrgLcQnwgu/wILht/Mu+zcf0/J1d6ObkqeRVLqAFNXPk+AlGU6d3zZUBEivHY317pFdsORgDYPaKEZ814foNj+5nISTiZ70NQ7Kc0/V0JA2SOCnIf0ryRMsauqOnIKBvRPZFF7S0zJDVrQ8eXMFO5ZlNC2XFy5Mfs5jca8EVtPpsiQFWRC2vrZOJfrTmIrBQMdAIaRLCu+eHeuVBWYGN1xjQlnA9AHZ6hnUQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a08883-e337-4617-5c98-08dec21ab5da
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 09:21:51.3288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Te/1QhZT48yoH0kU2bkGwZDbgrE2TwK+rEiXHo+tnn1VLzzTkSDSGNBBIdQBpz7cc2Cb9JxGMbtor9cBK2wj1MlQwz/0tYnTewZtCMeIR5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9752
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MCBTYWx0ZWRfX2ye7tH8IfLOk
 nipYMFkWG5na3ietCO9K4pEAuqq17pL/TyqMRpS9mo2Ux05VmJ134nxTZDZPwmWlQB0+pYj1wZB
 DP/WYwKeB0YiYaurDYvNnCWDDwQoTmhTFsE9+Nasod/gTR9i0AXhWK2IWaaOWJbCJR/Y/7YMgtD
 xJ9NYvjfYfD9fjsAAZfGbmEchQGzAojd9cvWZuLDLh2fvhH0w3V+7MUveK4TkjEvX/TlMA0EFTQ
 jZFfQLHZptj95v7Fmorgn1EZejC7mryDosCdPPfEtVNSPwnEWiWCAv+uKcMQRQEUF9qQMh7SSUE
 sYJbc9B2Ig1osloQqNgYc1VHTPtsqtqIa0k8mdtGrFYpIhvYrfqzxcVGMTScCVOZk7Gjp9I/MfR
 hf60JNS/neU6LGpiYuYkl1XIB3NQnrcl2ynfwgUqJCujdAfG9RzNDjm/soXdwwK0QzdAAtAJuRn
 itXhKNG/sBTsqGIIXHw==
X-Proofpoint-ORIG-GUID: pBkaRbStws7Ft_Ou5SDpC-E_W7mnUarl
X-Authority-Analysis: v=2.4 cv=V6FNF+ni c=1 sm=1 tr=0 ts=6a2143b1 cx=c_pps
 a=/AsmdbFdlFTi7zs8q1N/xg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=cLHp8CDFvLcCkWM3Ou8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pBkaRbStws7Ft_Ou5SDpC-E_W7mnUarl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 03/06/2026 16:55, Peter Xu wrote:

> On Wed, Jun 03, 2026 at 04:36:37PM +0100, Mark Cave-Ayland wrote:
>> Is the longer-term goal here to allow machine-versioned usage of all
>> migration parameters supplied via -incoming via -global?
> 
> Nop.
> 
> Machine compat properties sticks with machines, they'll be applied properly
> to migration objects at some point (needs to happen after machine object is
> initialized).  It'll keep working, no plan to change that.

What are the machine compat properties currently being used for in this 
case? Presumably something that isn't expressed through a capability?

> This series is only about exposing a new API to setup migration parameters
> so that modules (like TAP as backends) can query at very early stage of
> QEMU boot.

So shouldn't we just QOMify MigrationParameters so that our existing 
parser can be used without coming up with a custom solution? I feel I'm 
missing something obvious here since this was Fabiano's suggestion.


ATB,

Mark.


