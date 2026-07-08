Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0D8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOmJ-0005XX-4W; Wed, 08 Jul 2026 05:41:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1whOmF-0005X4-QJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 05:41:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1whOmB-0005tP-I2
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 05:41:11 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668880oe760547; Wed, 8 Jul 2026 02:41:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=R4exf2b3Pz0aUUf7QPigUXs5XDcKZct+/rYzQGCwM
 Io=; b=zi0OKeAbrGi/XoOQzwRT77wqtsz86bW++Zs4hfnn6Yv6mwGjBVMUb6CrQ
 RBnhMuf/2SSOuhRVuPWkNpO1V8EfmWyWAHjGnznnmJftomgKh2lNKQx+nXulJFVP
 Xg2uX7CqIbvu1u7o5+adKAzcLD+dOA0AwNInID0KG3G6D3SBrOdbnKj4EJtTYZV+
 o995EUHXrrEW6KqobS3f5QI0QEVumHGJwnP0Wh/4hDFgZFV7gI5leIWzhW+ro00v
 CGD+foMhQwL2BphV92xCxuHCKdeeOxY4yF1d0qSafwmHyTZoTGmxLmFnVyjFbO65
 iTggX9THusacH7E0nEWzkPO1QOzEA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020131.outbound.protection.outlook.com
 [40.93.198.131])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f990p9mcu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 02:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jv89a9rlUT4eFEsi3aixCaXk3Xz34axx5PwDUwKeGgMMt6ksSkqaTA2JNfsQ6rnZjg116XLmHxJZPK0JBUo/pAiKyazRzJpnY/003CDv2ROdzpstGDc8yPozsVHLWxkAAxwBXNzvGBOzlJcLjNkRtQG99pmz/F8h421DGigP1eiJ9QCDoJhqCScB41VKqKA37NrROJzQhdkSFp5vLyp69F0bvdJN55vsnOdpz2AG6kMlDylt9qvlkrgLK+XOF674Mt7XdAjIEiB6CpBDKhzIYy4CrgmElMsdo6MmzdEyVukBgLzMtmhRX39Vz6+KVMtfMA/ejQqjuT3X8xd4ZYwSJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4exf2b3Pz0aUUf7QPigUXs5XDcKZct+/rYzQGCwMIo=;
 b=EUWVhuz3GSjJgmWHG7kogdV3zASlZKkeJ6YKaYGVk6T4g8jGcnupA8K3M1n69fyoV0LLPnuIpi1ScXrpitxWX/S8ejT4hzfCBCzh7BbO8Htc7QXgeBRvwL9G23KuxkwDYJIdWRtEVVLuoPPFXOaSiIqzRa609zl/XwQkNEZBO+guyFKMJUDPwu6aDRBllVF7ky7mUupnHF2mdUdZ1rTt/XtC+pFflFmActBKcN/T94enaoRlZVVvHfPSp38Zrj6ddSj9MlFMxITS29ggtJ3RX8NIp6A3kZDSzSF+KmNF5GAQsqLYpjk6tQrhN/K9kgTIRBCPRd6MrEF1ZaSHLpO/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4exf2b3Pz0aUUf7QPigUXs5XDcKZct+/rYzQGCwMIo=;
 b=HkAweUU35SMATery9i6GzyAgUXTX2LhIjQ5PKCx0cX602latg+TxYef8uIm+9moSupM9ihtD+wjyU6foi4jeyAe0inKS+2bQMlSQ3lORHJKESznqJ3lu+1N19qygXGPiVAAsyXpWwEATC6WRlWHB1O3Wkoo9IC2PP1FKWD0Tx0N1i4vu86aApVf69FPd3HoWXzUlCmXxVyYePxVDJ44FZ02qVlbHFD5uHnwhRDz7Ck7ghrjckOrcHQYEbMiEfGKL5Ea5RzKjgKk7n4PjSW/IEPi1WbXC3ZA5PMWq/lqjtBQdPVpgkXsJON9t8xS5hsG6ul+zkHqlVN3Cc50EE9lmFg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7829.namprd02.prod.outlook.com (2603:10b6:510:56::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Wed, 8 Jul
 2026 09:40:59 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 09:40:59 +0000
Message-ID: <ebbec6f0-0866-414a-a31d-cf0f0e5d5924@nutanix.com>
Date: Wed, 8 Jul 2026 10:40:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] hw/i386/pc_sysfw.c: convert pflash0 and pflash1
 object props to class props
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
 <20260703090814.2993188-9-mark.caveayland@nutanix.com>
 <ak0wHkWQpXX5H45e@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <ak0wHkWQpXX5H45e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0075.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cc::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be0fd52-fb92-44d2-4697-08dedcd50455
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nzJJ1RvUjhzsoG9k0M+W8QGZp0I4BnngIF6WRyYbzgZ49Bj5LEKBxMWnLkil47A/bxEldyOFX0TMC2wfMjuyGkqh1veDVag697548rc2efUkbs+/WPIEMfHIAPgSPhqxqMCVwzZUE1gHcc8Ek4mz46OjUEY59VXyxO3r9F+QMNCtyL+9jnG4FQsBn3ZI8HxTWmuyAzTcrsiJ61Qzm5syyt3lWHBaIOutiC+1VmBWyEgzNSV1PvY/rt33jGUYo3STb+892FT96ZwotjBCusvJdetg/RHHjZslFvn05/gRNmpqh434kmIy+Xn01ohqEnOOIGppPgTxYMMEVY9JxfUN41VUn4MR4PJQN/gkAXQOQEWGXA+rsmaffcVseVdoQLg5EQwksg+BEN9J9Kev3qXwBytsZ6QXxNNH2xwTAM/BGWzWRochi9OX8i5CCq7M53GkDYMpcgrXVL3ATZqelUMOAZ0j23ttWtXUmlLUXGNwd3MV/LI2D2ZllTopMC3+c54bjOGZ5RSKrCrUilNf7zmm3KK3DWGwuSAZDxIeLqB1FZrnl3cunjGTFpGIA/HjmG3uftKpOEA7GDQnmvkGtqSov3tpTJ8Uf2Qv0OHQaTSVg7AgXnhv0oR5MHz1cA5dV3f4qw2+I0E467upHFmjlwWuxnazYvEuLv5SK4DXPvC22dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0xNTCtSbHBPdElUQ1E4anVoRzhVQ04xSVB3djVyMng4cFRZdmJUMFdBWisy?=
 =?utf-8?B?dmFWalo0UDNGS1VIWkMrNFRtbG1uM0wwVmNuOHVKdDRNdk9PMFFhODVnazVj?=
 =?utf-8?B?eVpJOVpYd1VZbjNsaTdFUEQvVnBhS0dBT1pveXJVRDFrSnRPZldJQlVVcDFt?=
 =?utf-8?B?c0x1WDZhYlB5S3pIYk9KbzlLMkN2TEJpVWpObC9jcnV6Q2J2MXMxc2U0QzFz?=
 =?utf-8?B?NEMvSWdCQlc1bFFhWFdrVm1wbkpXLzI2RGQrbFI5SmJZMWlqMEdETlpSNWJQ?=
 =?utf-8?B?OVhueUU2d0RBN1VGMzk4bTRpQ1dsN3Q3TFBoUDJsakVaRWJ2d0E1YTgwMTFY?=
 =?utf-8?B?LzNnb3ZUcWNsZGdnNk1PWEZZTi8xeUZkSTNpYlhlOEEyelpxcmRIYnRJb0tH?=
 =?utf-8?B?NkFDWTIvUDJZOUtjVmU5OFR5MW9JcVNpWDJ2MkUrbjFrRzN3djlUbGY1NlhE?=
 =?utf-8?B?RU5QVENtNlYyTlRFS09VeU9CS3hFa2ZwNjlPRHYzcTh2VE12azFIcDhmTnZX?=
 =?utf-8?B?SjZvOUFCUkpkeVVJVTNoTjhWbHNHczJ5Unp5UERTd1RGT1ZCL1dkK1VCbkFT?=
 =?utf-8?B?WktTTjhTWCtBdUV5cmdiRWRJTDIzV1g0akJsWXVXRklPRnNZSXNCZnBjK3lx?=
 =?utf-8?B?RHJIT3JEa2Q5M1N3WDRaMUd1dG8xaDJkY3ExRTlGZkhidGh5RkYzdy85MU5Z?=
 =?utf-8?B?Q0ZBZGRMZ052cWtFZUdURWpSU1I4RERtVDlYMDdMTjgrLytrY3NBVnZHN0RQ?=
 =?utf-8?B?VUZOTWFaOGxJYVorTWp2U3NhRm1GRDIxMUJ2YlVTNGRmakU4UEQvYnIrUnky?=
 =?utf-8?B?S3JMY0g1MTZ5bXpRZDREUXcwbFZsdzAxK0tLeUcwOFNuRlNkYWE0dGNjbXN1?=
 =?utf-8?B?SC9IV3B5L3U0aVExZzBkZkM5cFVSUTQ5Sm1MS1Ryekt5Nzh1S2ZrWXNBcjAz?=
 =?utf-8?B?UUgwcmIwbSswdWpmM2d1M3RxUmhVbU9ZbkdTZEJkWTZjWlRxUCtNY3JMY1VV?=
 =?utf-8?B?eHdjUGhwUndEbm43KzR4N1hBdmtQL1JsWFZOcXhiT3p1RDlUTUxndTEvWFh4?=
 =?utf-8?B?dm1JWW5zdXVIWXlTdTRCSlVyRVdVSlNHN0dUaUpjUk16TUpJRVYrSVI4MlRo?=
 =?utf-8?B?V1YxWHdvQlorbVNvNnloTW5QNnBaQi9jUm1BSEpGZm5oNmdzTkJZQ29EMXBy?=
 =?utf-8?B?OWhEYk9CaXJJcnhRSDdobjFsNXZhZ1BCQVpBNTlZUUFhaS9wV3NaRUhTeDhH?=
 =?utf-8?B?VWltQ0IrNWZpVVIzdXY5WTJZYkQvdFR0c3NZdkVKZGZjVW40YzJPSHdTcGgw?=
 =?utf-8?B?cE1FWkJmeUxpMDJiYmpwZVZGTzNNUjlYSDdyUjlsalMzdTVrYmZlanhDZU5m?=
 =?utf-8?B?cm1pZTVOMGt4WGZxaFV4Znl2S0txTHBxQ0lQeVVKUFRoUHZ2eVZyaEFvWWl3?=
 =?utf-8?B?UXRXN0N6dGFaYUhTWnFQVkE3aDY0eTV5eWxPclpjMzQxYlVJamhGQ1ZudWFG?=
 =?utf-8?B?UVhHWVpqS3ZKaHpKVnRlTGhJRzluVnd2Z0F2blovRURnR0kzK2VtMXBBbXFl?=
 =?utf-8?B?RXNVOU5pRlNRT051MThpdVBvbnNGK2VhOFVDVGk2QUxKZS9vOUd6ZHBjaTA4?=
 =?utf-8?B?ZkNxdVd3a1hGUU9hWUdKZ3ZHRDZvZHFSN3Q0MnE4eXlRWEFQbjczRTRoYkti?=
 =?utf-8?B?dDgyYURCSEg1a0dQU29RNWx2WHVoL2NIa05QN3NSSUZ3NTEwUG1xY3llTnJJ?=
 =?utf-8?B?cXVUOHFmSlFoZHNlRFFUUlJaK25UREpzM2FCclc2QXlpYnJJaEhaSEVPbTVU?=
 =?utf-8?B?RXViRHJqT2k2YWNZeTlNR09qN3VsRU0xTG9wUUROWEtNK0p1RmQrSWEzU0pz?=
 =?utf-8?B?elpTcFJBM21pTlk1K3lLeEkwTUNsakh3bmpVN3dOTU9aRkxacG1WWnY5N013?=
 =?utf-8?B?Z1B2ditBVWtuemNEd3hsMFpacnZqOTRtMjFReW5DU3FsakR3TEFmMzQvTERE?=
 =?utf-8?B?MFZDd0t5bk5aL1gzVDVDRkRGZzJFRjNKdW9VdHc1V1laZXNHVTRrN3RMQ05k?=
 =?utf-8?B?dVJsTjZuQkdCeVg4ZjNQQWFuT204Y3RvNlJkOHdxVk9mU1UvRkVXTHl1TFBm?=
 =?utf-8?B?UFMrS3gzUUFySkorODdNMUk1N0xwWjFYV1hXcUt6SS9DOVBnNUFFcmlFMlZJ?=
 =?utf-8?B?dytiZ3huSC94ekpPVFRSaDYrMENnb0tVd25aSURSREVtWWhaMXdGZHlxUXFn?=
 =?utf-8?B?VTI1SlZ2SlVseVc3OWpDVGJRYThXWUpoTVkvWjVFVGFUMjc1eE85WERMb2Mx?=
 =?utf-8?B?SURoSUNSaVlYQWk4YkdzdGIzSElSV2ZhSWNPREVDY1laNnh0dHdtKzhyVURN?=
 =?utf-8?Q?9dnHNsQtDWE+x4WY=3D?=
X-Exchange-RoutingPolicyChecked: LJopIgduAovbrMbxHgXPWvf7+x5wJQ23EQnLxxDXClBuby+n/Fim20uUM7BznZrmaHTEcRrcJbowNvxAs3Q+ka/6A9XYuA997bYfs/OtZTtgy86wM2efKbVyxe925nP5mISkEoErUm9jvP7xEYSQRHdYGtscuV9SQNH8n1bk+qxYkebNy2Cs5W9iC3ns8BFwQQ3ciRcf8iFC3c+LV63LqwMYJrMUDxJaYR8mIxF1x4tET29D+54ObCFu0Ozz37LgnEBgQtBC9+NVMgU+Z5fXzYQLAt3qUV5kLQ7ifEWweWG5qhx09SdTQ3L0ehK/iLOgYKI/W/NwIr92DiO0i71Ijw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be0fd52-fb92-44d2-4697-08dedcd50455
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 09:40:59.5154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ko8o9UBKtr2Ij5r1khZKoqPfq2IFOGGicQ2zbitidmrZeBZINKewUSUEYYH+PkPLqEve5Ond8fPOomk89XtyaUu4Xrgs771oRqGLoEPNHuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7829
X-Proofpoint-GUID: r3YqVLEJw1hIU7x0APHCokZTVjAHpRRz
X-Proofpoint-ORIG-GUID: r3YqVLEJw1hIU7x0APHCokZTVjAHpRRz
X-Authority-Analysis: v=2.4 cv=VNftWdPX c=1 sm=1 tr=0 ts=6a4e1b2d cx=c_pps
 a=wLjL7U/RDB/pQmeqDiFFmw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=5EUSSp1AtVhLGfZbPOsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA5MiBTYWx0ZWRfX7wLC0GUUvDVO
 6o9jfXxen91SKVoL3n9aQ4PG1psgm1AtdxwO2ZYs3/F6pRdvJzMf34qk8kb2JgUFXzo94EEm5ou
 /Y1LJx21a6gMjNacb5muBYOdwnDk8HE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA5MiBTYWx0ZWRfX3peejYwm09e2
 uvruK3Dd0kdY04a9LpQ9+SEIEYKL8A5I+9XXvlKSHbhl3EKpOHTOqi+QHf/6zPi7lUWb7AaoJSP
 bSAYdbQq9vbKDMEvR+oSVpHWREDiHNlt9gxammml0xP8ymOIVbZYutaSE+X4M0BRYX5WXgH9dzG
 AzlxrWtM2p1OV1CmfKw/5wGeIaZhn94hd4E0nokI+u9R4DAsEP+H3wCJNVenRFcQq/N4Dc49oCH
 OyrqV4SehujemFVR2uhXBG85QxTl94HtFG1Nj/jyQap0TCZ22Eq4GRX/i5jDDFU02Bc9tsHYO1c
 xS4sVajJdn63dHR8KMguqk5H43nn8a9BvRoHqjRVkMVwlDLmfANPxpGzqIXpuL0UEcONIsaeoXp
 UIBP/tj2tu6OX/2jMcAMP4dpCONY20F/KYHKg/0I5hmKIzV49xtA+xHGzrk41eYtZeVWoHG5tKK
 10U/vQHMf9DmB9unMlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
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

On 07/07/2026 17:58, Daniel P. Berrangé wrote:

> On Fri, Jul 03, 2026 at 10:08:01AM +0100, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   include/hw/i386/pc.h | 2 ++
>>   hw/i386/pc.c         | 8 ++++++++
>>   hw/i386/pc_sysfw.c   | 7 +------
>>   3 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 309de2eda1..16cb0ec01f 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -40,6 +40,8 @@ typedef struct PCMachineState {
>>   
>>       Object *alias_pcspk;
>>       Object *alias_rtc_time;
>> +    Object *alias_pflash0;
>> +    Object *alias_pflash1;
>>   
>>       /* Configuration options: */
>>       uint64_t max_ram_below_4g;
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 13c9c1bfc8..11eef176f4 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1762,6 +1762,14 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
>>                                      offsetof(X86MachineState, acpi_dev),
>>                                      object_property_allow_set_link,
>>                                      OBJ_PROP_LINK_STRONG);
>> +    object_class_property_add_alias(oc, "pflash0",
>> +                                    offsetof(PCMachineState, alias_pflash0),
>> +                                    TYPE_PFLASH_CFI01,
>> +                                    "drive");
>> +    object_class_property_add_alias(oc, "pflash1",
>> +                                    offsetof(PCMachineState, alias_pflash1),
>> +                                    TYPE_PFLASH_CFI01,
>> +                                    "drive");
>>   }
>>   
>>   static const TypeInfo pc_machine_info = {
>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>> index 1a41a5972b..441e777191 100644
>> --- a/hw/i386/pc_sysfw.c
>> +++ b/hw/i386/pc_sysfw.c
>> @@ -85,8 +85,7 @@ static PFlashCFI01 *pc_pflash_create(PCMachineState *pcms,
>>       qdev_prop_set_uint8(dev, "width", 1);
>>       qdev_prop_set_string(dev, "name", name);
>>       object_property_add_child(OBJECT(pcms), name, OBJECT(dev));
>> -    object_property_add_alias(OBJECT(pcms), alias_prop_name,
>> -                              OBJECT(dev), "drive");
>> +    object_property_set_alias(OBJECT(pcms), alias_prop_name, OBJECT(dev));
>>       /*
>>        * The returned reference is tied to the child property and
>>        * will be removed with object_unparent.
>> @@ -109,16 +108,12 @@ void pc_system_flash_create(PCMachineState *pcms)
>>   
>>   void pc_system_flash_cleanup_unused(PCMachineState *pcms)
>>   {
>> -    char *prop_name;
>>       int i;
>>   
>>       assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled);
>>   
>>       for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
>>           if (!qdev_is_realized(DEVICE(pcms->flash[i]))) {
>> -            prop_name = g_strdup_printf("pflash%d", i);
>> -            object_property_del(OBJECT(pcms), prop_name);
>> -            g_free(prop_name);
>>               object_unparent(OBJECT(pcms->flash[i]));
>>               pcms->flash[i] = NULL;
>>           }
> 
> Does this externally change visible behaviour ?
> 
> The pc_system_flash_cleanup_unused method is run in the instance
> init method, and will purge the 'pflash0' and 'pflash1' properties
> if they were never set.
> 
> IIUC with the new code pflash0 and pflash1 will always be visible,
> but would be unset, as object_property_set_alias would not have
> been called.
> 
> THe new behaviour is arguably better - IMHO properties should
> always be present, and use "unset" as an explicit state.

Yes, it does change the behaviour to reflect the fact that the pflash0 
and pflash1 properties always exist:

Before this series:

$ ./build/qemu-system-x86_64 -M q35 -monitor stdio
QEMU 11.0.50 monitor - type 'help' for more information
(qemu) qom-get /machine pflash0
Error: Property 'pc-q35-11.1-machine.pflash0' not found

After this series:

$ ./build/qemu-system-x86_64 -M q35 -monitor stdio
QEMU 11.0.50 monitor - type 'help' for more information
(qemu) qom-get /machine pflash0
""


ATB,

Mark.


