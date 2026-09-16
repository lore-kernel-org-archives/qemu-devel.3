Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B5AC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pwn-0008Md-HF; Wed, 16 Sep 2026 09:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6pwj-0008JU-Sv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:45:10 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6pwg-0006cF-KE
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:45:09 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GCZBu72534049; Wed, 16 Sep 2026 06:45:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kBqXYrYahx0R+n1phbloqZfpmqwXo14yziW5+Nwgv
 h0=; b=EL+BZ1s3nNNtPCRqM7BMlD3m3m0P6bgjFhWwi6ZUJ1v++f7eX96rQFwYQ
 V+2sdlya+pekHgTjuEDIQVCtGrqAF1XT2PQ/An6Ua0GldAvA83cMlJx2g0Tz5XTO
 htPy74QhBIJAih2czNnwJn7f6dtLUC9FO0HC1YMpB6x5GGKQnsIJC+oVKw30fdFu
 DANUgkayAOlT5ODl5r+NcxjaGKgs+128yBFzk1gA4+sLqLHaQyHNsu/DYGgiJWmW
 0rNaHNpsBhI/Aif9fru4Oqvn59i2u9m0EILTV3PtbtMLEAPRHCeV4amvAwfjmbRs
 Z3ndR3+1fuXNRnHTzcM9D8VAaC0Tg==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023078.outbound.protection.outlook.com
 [40.107.201.78])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqbtbadsk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 06:45:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loHLHTQ7tGqsq74fp2L2xMGF9/BjT1GkjU2zyjvMDr/eYBDWa5gmkHpNjF0Kqi50pHmPPyYwqckdmTq9YEuloIGYh712Ua7uayMKSvifm/zRxjuuvWfd4ooLDyDHDvVziXszO+YEmQvkF6uIq0eTVf1XRn1+9ORJk7cI6gi0txmTzu2Az/Msu+UGSsqrcr+54TAtgatFG1NBkWDsdvFFxNQPGFrDiojZ6zXcBTq8M7TLeLc/e67YrJZ5/JCvgZYXsT3OzxE3woqTDXLZy5SpdzqXdqtJZVisXGzusZxB0lfxzQ0YIZQbDf3wadDnAWo1ynCXGXrt626J95b6ywTCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBqXYrYahx0R+n1phbloqZfpmqwXo14yziW5+Nwgvh0=;
 b=zB2sXfaZXH6xaa5yInasBH60BFWBxudnHU23sNL2qGBaXP45fPvaJ4ts/Dxr2p2LaXP7k4Iu1XuUkIyPQlwEYjqKaHTX7NyaU1TB/7T7U6KPE+UZW+oeA74x6j4wY4Ap2r1jz3Bmh96trqmpPPfcYPl6LATnbq5V+0wkXcpBugGP8kXhxkbWkt/c7nPgzRbOgF2Ycps7JlqtMbPCZ5IHtBZgpqZ9eQ3aIXJz/wGdR61BatMfyelQLPf2BDvO3j4aBwxtBRbPRisKByCuIC1ncsDhZ21DGijXpi3T7du5EXoZbppd7cKaoSIIiGzT00OCe8EbvR3WgJSRG8+snBe65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBqXYrYahx0R+n1phbloqZfpmqwXo14yziW5+Nwgvh0=;
 b=ic80qFQItZnCkKOzferl/tZMWvRJ3zVFogVeF/86CdM3EvFe7RcPDK6c7R0QIuSCCCs7qFE6JENqLbPA4gMh/BF7cYtou9GZLaITyHebQG71vZfCkZ3+HTAKqguUSFJ7AGfxSHGr4G39OW1rtQM6TQi+TSH9Oa7o638lR7Zu2uebzcduAvoQo1MGdIP5sa7ZoMqE5qqSP7LLsQFdbMmWIarufcZetgwabDxxOKgKMn2Lw3K/zAdnq23uudLwcwZeDc4CoinXpIx2SN4w8mtlgLo5tNXAoitTi/Rd8fzvB/DEsAFG/P14ku4qIJQN1eYruhwte6tGEv0rMq2zVeFbxQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SN4PR0201MB8790.namprd02.prod.outlook.com (2603:10b6:806:201::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 13:45:01 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 13:44:58 +0000
Message-ID: <118488f8-98b6-4fc3-9c85-a8a9df2d9f1b@nutanix.com>
Date: Wed, 16 Sep 2026 14:44:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/isapc.c: reject modern x86 CPU models
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 qemu-devel@nongnu.org
References: <20260824111054.575149-1-mark.caveayland@nutanix.com>
Content-Language: en-US
In-Reply-To: <20260824111054.575149-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SN4PR0201MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: befd3559-c012-4df3-6c98-08df13f8b305
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: E5b+7P2fK1n54HzyVM9y4IcsqD+Ks50eZSuZPLzfwnxPclpwYfLB4Zi0abanD2hy5W3+qDouoABo0XVjxeYsGTm3B42uH1rkvkFJ1TR45tK/RK8Z/z8HQnpIcd1GZEPH/UZWXe/kYanOv3of1YuKOoMcyDPcrt2A27jtv2qVlmNnlFJGPqvmXp0oAAO0PrHzFOenHQC1SzWIdb0APiBrOYUbaZ80zAEZ9cPgPHksqkYciPpbmcezwRoHopnPRN84uJhE4s/WyBFVFNyJb4u2ccMXUDJyJkoFXJ+QEIMBTTS0f1O3CRq5NPIpHDbjy8MXbbJZkYPD8mIkcm+qbAzWdmKDEOb7jtk1/Bpf8eo+PmVcHEavPMWmo9KT5kdfDubrXVEy0ZUZ9+RnsnBdGQ10xg9Rw+V3G1SD8AAFAmtikIj0gzFg9g/bKAQ4gORf9CtwgV62I6jbB3pUTgm6hYHYCrwC/hFkL/ArZstouD+oi1unZ/KGkdG8dV0oco1XMjEn8f2EWrbYxXI68MzwMvecF7xG3GH9N2NgqADfRk6OaF2g/VFhsEaf0H+7LRu7uCoekI0eYAZEi/W1GpN7b14WI1pix2YxhM5Srx78Yy5DAetYbKQkyWVi4u25W1J3Pd6yfeMslxI3Ml47x1fP3YI1FtVqcdPQO88RqWHMS/qX+I0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cytsYWRBQXUyQ2lLcW54dEZicVpHQTZoSTVXNkx6NUxuM3h4dTQrMmo0WjdE?=
 =?utf-8?B?QythRjNTNVV0SDRQRGt0V3QrOXlJNXEvcGxxbm12TE9jWGFVUlh3b2Q1djBS?=
 =?utf-8?B?Z1V0bUhWcCtUUFRxeXdaYWNTcUxmOXFjL0pSWFc5VHdOOElrQ3ovRis0Wld6?=
 =?utf-8?B?UlQ4SGhnb1Rwd00zaTNwbHozME03b0lPUWtPd0t4MlJtejBwNXJINm9hOGVv?=
 =?utf-8?B?M0FoeHZwUzdvMUhzUDZ1MTRBWUVMZHpWRlh4VGdHaDIrVmJXS1l2aHFpK3J0?=
 =?utf-8?B?UzljbGV0b0o4MmpQcWNzY2kxWFdhS0JCbkFBMFZ1UW9WN2JlNTd1U0hCTjhl?=
 =?utf-8?B?U3dZclQ4eFRXVE1rejA0S1UvNVM4dno5MWhwYkdRNXBCeGpZbzBjOUxsVHd1?=
 =?utf-8?B?RUFEMmYxc3kvVFh3REMvblplbjh1aDBBa3RFbmd3V1ZtbHErK1VIWlMyRXNH?=
 =?utf-8?B?NEF4NWNFS3B0cFA0MXcwNTE5TENRTi8rV0grTzZEVXZaVmU1dkNJQVNTamlq?=
 =?utf-8?B?NEV3bWkrN1dDR3VGOXp1N3EwZTQ2N01KdU1zS1Myems0Ti8vL3ZEeGNJVE1K?=
 =?utf-8?B?T3hYNEZGNzNxdjlLMXAzeGJjcThoUFZaT3ZrR0JldEpKK3h4TlJXWURJS3pk?=
 =?utf-8?B?QzVCWEhmMlNUMitjZmFTRzZNdmg1cE5NQ1Znbkc5ZEJBQ0lNVWJ1bS81SVph?=
 =?utf-8?B?WUJsYXVQYWozdHFJOUhSV0hhVjlUVDYzbWN1VHorb2xOQkp1S2ZVN1pXSHQw?=
 =?utf-8?B?Vk5oZStMalBmek9jWnBReXBBSGFyUjAzdnlQMEdWQUQ0VnFrUEVySTlGY0xr?=
 =?utf-8?B?djhvM05URmFJVzAya29QWk1WcTIyWnRSdTFsQjJ6UmxtN2NvY0FVcCtBZGUv?=
 =?utf-8?B?L2dYZzhxd0NpcjhNVHcxaXdaa2ZESFRlNVRadVFjNVg3V05wR2FJTW52cjQx?=
 =?utf-8?B?SE5qMngxQi82bk4zTTV2S2xEZXJxV2s2WTNSY29tTXVvbjVLYVg0QStzNVN1?=
 =?utf-8?B?eEw4S202emoyaCtYVGdoM01aRy91R3VrNXZxT0FqTHo4cm5HWVE0SnZVZkxm?=
 =?utf-8?B?NWdVT2NSNkh5OWNSeGFrbVpsekNWWkZwaEZSeG8wRzJiMkt1cWxLd1NydklC?=
 =?utf-8?B?cnV0UVRDNGdKVTBybzFLR3AxZFhUZk1lSmxMUHFIUWdxL2RORXBJdzduNXQ3?=
 =?utf-8?B?R2ZrN01pd1Q2ZWxnK0FnOW5wSnFoUnBkM0NOUHBMMzNneFpEc0d1bEdKTktP?=
 =?utf-8?B?ci8yTkZVUnZMYk43azRLL1RWTXlHVUVyK1JoZGlaZ3pXdjY3MU04L3Y1d3dm?=
 =?utf-8?B?MUFWbmFURXVyQTRZWjc5YjJBWWVpVll0cTBkQThqRVNaRWloQjN2NzUxWVlx?=
 =?utf-8?B?T3dlTkpqdEdOd21WSUppaDlvbUtZbmxXRE5jdGw4SmE1VFdpaGNmcGg0cno4?=
 =?utf-8?B?UTh6SXVFWVBoQXM1Ylg1eWQ1UDR4dHllc1NGaERyQTJubUR0SXREcGNuRFFF?=
 =?utf-8?B?SHhjb25JdTRaTGpnYk9wdHY5Rm5RWXBNQ29wQjVSM01Dc0dMT25lTDhTeFNm?=
 =?utf-8?B?emhZTEV3UnkyZTFlM0c1ajArY1pMclRESVREWVkvQUNKcS9MTjI1dE9Cdzls?=
 =?utf-8?B?bEl5Q2doWEd1eWt4UVhaeGtYVmZMVktLV2ZXQnV5ZnNBSGtLMzI3SUFqRkd5?=
 =?utf-8?B?K3FqNHRvOFkvRXpWWGdJbUExUStTQnNibi9rWVRTSStOOWRRUHVqQkMvN3Z3?=
 =?utf-8?B?dDJ2UmU1ZHRQd2cyOVZ6NEdlWis0eEFzbm1HbG1NdTBiR243MHZYMFBUeWhZ?=
 =?utf-8?B?RjZrVEovbE9BV0hudzdzblFxemJLYmoyMFlSZUVZU2FoRlZpNys0dFdXaktJ?=
 =?utf-8?B?N3FTeHN2QzgwdDFkaVhpUFZodXhuYmlQRlJoMHFNYlZPQ2VVZEtFdzJXYVNs?=
 =?utf-8?B?ckRiZG1XU1NFckl6Smd5ODVsbnptNmx3TVZRQ0JXb0VNNTRySHE5QVpGRkJH?=
 =?utf-8?B?RHY4OXl3NnVqSDF1Wjc2ZnR2RytGYTVvRVp2YWF6b1JnN2NzZlJSYXNCd0kv?=
 =?utf-8?B?N0p5WWMvS080enhzOEROMEREcmJmbXl1aFN4c2VYVytBWlJWM1gyelRocjJq?=
 =?utf-8?B?cXhOeWEyUjVEL24yRm1xbTg3T29DeW5LSFA1S3cyUTlndkN3bGFndG1BUklZ?=
 =?utf-8?B?Kzk3RDJpcjliTEVDRWl0NU8rRmwwQjRjLzJYVUtISzRvRUsvdVNiakdaaWFq?=
 =?utf-8?B?RzRnVEZ3VHptSHJqQTRmbjZiMUp0VUtJSVdxTDVGNHRmYnNmMmZTeXZxeENT?=
 =?utf-8?B?cFJQK3IrUzZ1TUl3L3pUTE1WZ0V6K2ovdXFML2xCT0tod1YzMndCbFFjNlpT?=
 =?utf-8?Q?0Fn5VJBNwy/0OsGE=3D?=
X-Exchange-RoutingPolicyChecked: DShLtrPQ7HugHVjzt6m4pAaDqyHig3k0LlScBH/tVGRHB4FYTPFurxJ01HclJB1yXmWqksRt8BvAPN6n5j2XO8Sa/AW8GdRXSrM4xYH6fkPe5t60xNR+XkRxHkvZ93zRIbjwVZ6mj2SI8Azxa3/e9qFxu3z356K87R8eHcMIijCuWI8UL5qA1x/CuKooRZkzDstQeR1gfSM9dugxhAhrHk+Tua9UbvIdbTkStzCc5KYpUVpk4yZhjsLwUccgCARCrqyRWKgoMJpESTxmqHnGeGlgjrcSZbQCcC9k8hg86YxnRoLsKlGx1FiVLTTyK/QiQYhteboNu4EWxAbTqOFNjw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: befd3559-c012-4df3-6c98-08df13f8b305
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 13:44:58.8273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJRLWDvouZkRFMYgkK6ZjE2DdeukYavnYuxQwS9ryi2jGxvyIm4F717hzjBT8tz+Yd9WVKOhhbRBIeX5XvBVTzKuYcROUiwydeUdXkLTrIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8790
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE4NCBTYWx0ZWRfX1D4YQdH36JCT
 kj34bFR/30cd3qTH+TWCQuSAnradypwS6kk93Qjj1VQ8voG0N1O8WXNCQdzuF5teTeazvd4s/07
 SrGEnrS4zJZgh9bayTe535WPTSeIFLM=
X-Proofpoint-ORIG-GUID: JSQO-lqHj8KiKJc1Vh0uC_2aYgkEk66Y
X-Proofpoint-GUID: JSQO-lqHj8KiKJc1Vh0uC_2aYgkEk66Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE4NCBTYWx0ZWRfX4r6OwJLs2NRJ
 RiiiKE89JMYJebSAo9xE3T9ap+VdCrxTg68bOkaBzCzakQKSqeiYxfpXEEHNUucV/rfiye4fQIS
 GKJJ7GkH3XYp1Inp5Z2BdcG8pFUFGfpbV51C64VnslZpk+Uqfh9bWsN31C7gy0Nn6GPnip7V/kZ
 dpkp+IvRGMas18vfhPosZjMQeXdqiO2cIjUWSZ1jd29rqLnkyyTVJlyRszIGDZHhPykm2MrwzlP
 wHOyf0XtOjcsqYMAfo3/9KAsN6+La8+BUDJ0l9XTKpO7FK2LFRMPusOV759KhcSCYCM39xnL5T7
 4ysKKGnOpOnewSDFmOiRqNblnR+fO0PPE3n9szwr1O6ukBAyTUV66sXnlj9v+6++nGQcClLDGmJ
 E94LwfJGQEY5LstEEsWB6/sJlUttAvUzVc8QLgBhY1OX8V7MsmV15AtPCaGas9668a5jhW+l1P4
 B9yAa8MlWYaEocxp7Hg==
X-Authority-Analysis: v=2.4 cv=QYvzLcbv c=1 sm=1 tr=0 ts=6aaa9d5f cx=c_pps
 a=vZ2NHEoT5gtGO0BECTCC2A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=YnaxzDx-UrxtcNlAWfwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 24/08/2026 12:10, Mark Cave-Ayland wrote:

> It was originally intended as part of the work to split out the isapc machine
> from the pc machine to restrict the isapc machine to using only 32-bit CPUs.
> Before the 10.2 release it was decided in commit 329e36af94 ("hw/i386/isapc.c:
> warn rather than reject modern x86 CPU models") to follow the official
> deprecation process due to concerns this would have an adverse effect on users.
> 
> Now that the deprecation period has expired and there have been no reported
> problems, update the isapc machine to reject modern x86 CPUs by reverting
> commit 329e36af94 ("hw/i386/isapc.c: warn rather than reject modern x86 CPU
> models").
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/isapc.c | 53 +++++++++++++++++++++++++++++--------------------
>   1 file changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
> index 1ba9ae22cc..44f4a44672 100644
> --- a/hw/i386/isapc.c
> +++ b/hw/i386/isapc.c
> @@ -41,31 +41,29 @@ static void pc_init_isa(MachineState *machine)
>       DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>       int i;
>   
> -    bool valid_cpu_type = false;
> -    static const char * const valid_cpu_types[] = {
> -        X86_CPU_TYPE_NAME("486"),
> -        X86_CPU_TYPE_NAME("athlon"),
> -        X86_CPU_TYPE_NAME("kvm32"),
> -        X86_CPU_TYPE_NAME("pentium"),
> -        X86_CPU_TYPE_NAME("pentium2"),
> -        X86_CPU_TYPE_NAME("pentium3"),
> -        X86_CPU_TYPE_NAME("qemu32"),
> -    };
> -
>       /*
> -     * The isapc machine is supposed to represent a legacy ISA-only PC with a
> -     * 32-bit processor. For historical reasons the machine can still accept
> -     * almost any valid processor, but this is now deprecated in 10.2. Emit
> -     * a warning if anyone tries to use a deprecated CPU.
> +     * There is a small chance that someone unintentionally passes "-cpu max"
> +     * for the isapc machine, which will provide a much more modern 32-bit
> +     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
> +     * been specified, choose the "best" 32-bit cpu possible which we consider
> +     * be the pentium3 (deliberately choosing an Intel CPU given that the
> +     * default 486 CPU for the isapc machine is also an Intel CPU).
>        */
> -    for (i = 0; i < ARRAY_SIZE(valid_cpu_types); i++) {
> -        if (!strcmp(machine->cpu_type, valid_cpu_types[i])) {
> -            valid_cpu_type = true;
> -        }
> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
> +        warn_report("-cpu max is invalid for isapc machine, using pentium3");
>       }
>   
> -    if (!valid_cpu_type) {
> -        warn_report("cpu type %s is deprecated for isapc machine", machine->cpu_type);
> +    /*
> +     * Similarly if someone unintentionally passes "-cpu host" for the isapc
> +     * machine then display a warning and also switch to the "best" 32-bit
> +     * cpu possible which we consider to be the pentium3. This is because any
> +     * host CPU will already be modern than this, but it also ensures any
> +     * newer CPU flags/features are filtered out for older guests.
> +     */
> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
> +        warn_report("-cpu host is invalid for isapc machine, using pentium3");
>       }
>   
>       if (machine->ram_size > 3.5 * GiB) {
> @@ -156,6 +154,18 @@ static void pc_init_isa(MachineState *machine)
>   
>   static void isapc_machine_options(MachineClass *m)
>   {
> +    static const char * const valid_cpu_types[] = {
> +        X86_CPU_TYPE_NAME("486"),
> +        X86_CPU_TYPE_NAME("athlon"),
> +        X86_CPU_TYPE_NAME("kvm32"),
> +        X86_CPU_TYPE_NAME("pentium"),
> +        X86_CPU_TYPE_NAME("pentium2"),
> +        X86_CPU_TYPE_NAME("pentium3"),
> +        X86_CPU_TYPE_NAME("qemu32"),
> +        X86_CPU_TYPE_NAME("max"),
> +        X86_CPU_TYPE_NAME("host"),
> +        NULL
> +    };
>       PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
>   
>       m->desc = "ISA-only PC";
> @@ -170,6 +180,7 @@ static void isapc_machine_options(MachineClass *m)
>       pcmc->has_reserved_memory = false;
>       m->default_nic = "ne2k_isa";
>       m->default_cpu_type = X86_CPU_TYPE_NAME("486");
> +    m->valid_cpu_types = valid_cpu_types;
>       m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
>       m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
>   }

Ping?


ATB,

Mark.


