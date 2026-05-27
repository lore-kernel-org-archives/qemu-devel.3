Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B02CD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBmV-0000Ba-H2; Wed, 27 May 2026 06:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wSBmT-0000BM-95
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:46:33 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wSBmO-0006bn-OX
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:46:32 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64R8oihH2157771; Wed, 27 May 2026 03:46:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=yYgi/zfSufa3PlFERCSUiZPtg+5Ta9A/wPdSSISzT
 4g=; b=Z1H5PQRDnytaNeKHtDuTXhUCjU69VOu/tGymA1dckpY4ccca7kBppBA3d
 yo+HzPbxnLetDhmFZz3fHT81KEZ36McqiuvfAFB+KBf7wopdY/+CmjG5b9aHD4rx
 iJWFBuq+Jd6tsa1hgP/3eq06autUmafZ2GiZ3vNALAo0rEABb+P+MLs446l/Lxkz
 Z6JmFauE3ofHimQcpa9LT8r1e/YzSIo+N8QBTkRrmg9FivdCUl71QVetwIQ2/AF4
 rGhaA6+FtTc8nPiEDeFInDqF5Tm678LfR4JatclGtUhEyQJQuwQQSwyzivlL4Xa1
 Vbetl9vBWp28o37MezoKHSyz7Glig==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022087.outbound.protection.outlook.com [52.101.53.87])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4edg2a212v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 03:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIzBoFO7dC41BEMUfxmwaNVOXO5jyV9cPrL8bK3AwjfA0cs4ueU7t5abMpZn2XLJfzdtZjVvKAwVQlbemiuzAnVWsfKf2nrV/g0N3tlXz105QV2LaydN1AsrDo5fStuLYSEYIfHix7Ne+CtNNc/kQDz8Ny4IyGnouHwqTfpJPQ9e4lK9hH8L3A6C/+E0OjCy5dN8HKo9cPBB6SCLXFob9zi8cqslqLsIF1lao0b689Mewf9wjuTBNAi27KOwqiKmusvtE5rdRFyExx1YBvstkJOH+TqFbqRnZKHUb1nOX2MOxFs5Ws4xWf4m9OiF+k20FbF7tHBwkwAN/6Oas20zEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYgi/zfSufa3PlFERCSUiZPtg+5Ta9A/wPdSSISzT4g=;
 b=H72TZ+oIizFRIhs0xfkbYOm9CUsuqYQj0Zx8AQ9Y7Fi+oaYcKbsb/rI5b6eHbT4FeZvk/DIMzMI2bOInttzE19Hvzgu+HqIX7KQSEyqBlxBpSK5SL5m5gnKLqCBau/haUwv0Wa0TkKtOf3pr2V23UDeQhjNlMFA4v1eG/PN8Diq2cVZqYv14FzwNiOdLsJxplako3mBZ0LNZe1ZqZnE0W/kh6v8ZG0nHckrhEpJfar1Hu3Ta27y+/L/YBYbADQkOf4qBrjPoLbUom3mZhVxau09X9TDyLgwO56vRu9ITZiF0msOk+GNp3ZVb0JLPjZ32qdjt4O+P7PC72HNec9ClKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYgi/zfSufa3PlFERCSUiZPtg+5Ta9A/wPdSSISzT4g=;
 b=smJPGm1MFZdnaubD/i8ta+yJtY7oeIXjayjtMLSn7ZD/VLKPa9UnPh7sPH/tYKvFU66reBPF9vlAq/4r2tAQPFi3LrrIa3rLVGBWuePqWtiqXI2mnYXZb7AK6d4I6p2gY63tFOmQwBXiDlSQqXrjX9KwpRuz2S0DGKigJR57mj8WhTtDCJjRymklCc2UT/z4VO+BFnUxB3yxeePy54QRuh0OMvpTms25hTVy6fbLhNs8RHddn0XPdN1QLnNPG7ScGvhMS/ua3YcTSodZa8NdA9r0PcAgI0iJcw2+RaeAP4YntGsVsLQwW/ll6YvAfrLezON0LehPfVFGuEDrE4eGhw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA3PR02MB9394.namprd02.prod.outlook.com (2603:10b6:806:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 10:46:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 10:46:19 +0000
Message-ID: <a9bd3a80-400d-4984-aef3-5e49107f3379@nutanix.com>
Date: Wed, 27 May 2026 11:46:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/8] virtio-net: live-TAP local migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com, mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru
References: <20260522120534.77653-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260522120534.77653-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0111.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA3PR02MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: bf33bad1-cdf0-46ba-0acd-08debbdd2f79
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|22082099003|18002099003|6133799003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 4E1/tRBYTihoegwhnR6vmrdZLZVxr2LkVKu4r2bKVHbxRxIgBAlmfJQtsjAySK4MrxXQ80Yazal6Kb/cCNR4Vd/e1x+XeW8YUzG+sv6GoPxFENk6oDGocMrBE15K+r8a5Vxt03N9YBb6uhBO4XsLGsk0iPZrWUka4fzo4zIHBqSZAxCOBjS8DKulMdflWse6I2BpWEg2zo/L7Fn+oUI/2DYdfyADCzgSsN8QgfP5Ai9CvQKCyv5Qwca5sAOh+SuOSkUb915ymcWDEtPKtYWr6OlSwb9pPjQQm72mcaQb99zamLVvC8p3Gar/ZRJj2G9mKoB2fMyp381XcmVFVuM87HmLSlRaOwD4w52hqBW4Km2jKyFYTVabjIYyWqCQ00BFNsutFoVWsiM1ovtxbD/ir79PvKffvN5l4RXNBHwEX6ou7/ed5QBPfbBPQPki+Yq46WAR4Vikwny23JHqYgSXvlTrSUhOldE7Tgd4y02WWQZfxa5juJPJGYpOg7ms9leQsq3rKIzBLWWHruzYJ9xuVRuX3728V7Nfg6ay/tEbeS4coFWZzNbzI25JQy4bEnf0yVs5UZvnSTlICTMt6NKEdteIpS/M4CyRbBZMkroGac9OGC9P7K2tpPzzWXD/5rf3MT7UsFbq3nQoK4Dy6Rh6kK2tTeFJZ/5CHyasixMPJWIgMuKOneFtsSWAwikcqhiD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(6133799003)(5023799004)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c24vV0ZSZk4zQjlpWFdGNjdwNjVjNWpXc2c5eDJ3S2w1MVdXUTNSRk1KbnRD?=
 =?utf-8?B?MTBYOFZETHJCS1plSzZSa2hJNkREMXI5ZWhxcVdvcjRCZ2cyRG5EOEZkZnI0?=
 =?utf-8?B?ZFZOTTh2aFJHNUtRTUxEbU40NXVsSUJtcnlyazVoMGpsK0p5aWFRbWdHeHls?=
 =?utf-8?B?R0dSSEgybTBVUk9pb0dKNDNBajk1MEk2aTJhMkhYbFlTamFxbjVLNWJJdnVL?=
 =?utf-8?B?U1pvMzU2VUZtcERQQnAxT1pBTFo4bFpWamdBTy9CbWh2QWxaLzBMZnRVYXNO?=
 =?utf-8?B?RU15T1AxWTVGRUpUS054WkUrdW9KeGRBNkpKZVNHRlAydm1jTUhoYTBLZ0Vk?=
 =?utf-8?B?aWI1cytMekRJenJVUjd2MzUxc1Q2YmVqZjFjREYxOEZKNTRFbXI5STZtQURG?=
 =?utf-8?B?Z2VVZE5zZzNubXpQMFdzMVE3TjJQNmIxUFRrK2VySmY0R0c4MDFHa3VtRldx?=
 =?utf-8?B?YTdTd3ZkcGZGcHI2R2tXUnNoZjFTcUFEcmVsWkFoM0lRa2M2ekxCSk83ZVlX?=
 =?utf-8?B?c0t2czUvcE9YaFl1NE4rNGJsQTVpa1NJK2ZzNzUyKzVvZTdwNlZnWTlsNjBv?=
 =?utf-8?B?RmdhdFZXUnljNTBQdEtjbERUSFNWd2tLTTNUUUo1N1IwK2NSYjF5bFZDUk5T?=
 =?utf-8?B?WXJrMURTdlNtaFl5NkQ2U2xLeWg5K2hoRFhJUTZrbWRkbm5vcnRManJ1NVZ3?=
 =?utf-8?B?bjV5YXFkZGdoTG1OQm9wZGIxOUxpVHk4ZTJmRWwyTGxjNi9lR0JqL1pTTXFu?=
 =?utf-8?B?RTR3T2t2TnAvem5kTmFGZFBWYjB0OHNXcHYrNEhJQUpKcTRHb1V0UVZOSlcw?=
 =?utf-8?B?aWNHWEhvVTdkcFkwQUdVU2FCejlMblk0S2dFc3pCWDllNUlxODFpQ09JMGFF?=
 =?utf-8?B?eGNCV0pGT2VJUVBuRVAxd3lvQk90WE5WR3FSUGtSODZla3A2Y00vdUlPcExD?=
 =?utf-8?B?bGU0bENEa2NYa3loa3pVb0kySUFiL05ucVJKbVRzekZjMFRZWGpYUlovSGtj?=
 =?utf-8?B?V1FEeTlIY3VCVzV3WkwxRU90bGs3SnJnczFkOHM4UFAwdEZsSUJzZE5ud28x?=
 =?utf-8?B?L1VFeDJiU3NYNXU5ZzBLSXp3ekJWUURwOXF2RzNSRnl1T1o2c3V0RTdNRURH?=
 =?utf-8?B?Wlo3UkJBMTc2Q1hlcVFEK1BVd3JVSFVoQm5XUVdiQ09FRHdQVGVxYXdMWHdn?=
 =?utf-8?B?eU80SGlXbU15NkVITWV0RnpabjdZU3lTZzVKb25tK2U5YWVyK2dEd2xOakdY?=
 =?utf-8?B?QzhvWEVJUlRmZjBvSExSK3k5NS9LdTAyTm00UUppQW9FUHJ5dEZzMHBZc1NG?=
 =?utf-8?B?U2xQY1RULzJxWEIxc2NIZjEzTzZCMkcvWVJBaEhPUGo5d3RaZWxXKzVzMGdu?=
 =?utf-8?B?eXBBeTFuTlNqMHdTZ09HQ09LZ2JGTGdFMkpjeGk5YnRkblVYcG9USVJKaUZw?=
 =?utf-8?B?Y0dHS0I4dnhuL2o5a1MzR3RNVGFoVnc5WlgwUkRGem1mZGJhNkZCM29PaExV?=
 =?utf-8?B?Wm9DVGw3Z3VRZ3ZndVVxOFZTajE3aTZCaEJzQ3lkYkxJRDFEb3pyTEJVMzdW?=
 =?utf-8?B?MzBGTlFldGM4T1h3bUxtenhkNTBYSmloamdSUHRUMEpVRHhqVmhCcWMxTjR4?=
 =?utf-8?B?cy9jNmVRTzl0WGlWUDkyS08wMVRzaG90bjBWd1ZIcUswM0s4T0RkQzBmakZM?=
 =?utf-8?B?cXpySFZKNmkvNWlqa2x4ckg3alBobkdKNnpxNVlaUG9RNHVmdFdXcUxZNzZM?=
 =?utf-8?B?MFlydmw3OU92eVA4di9ITklLWDYxRmFZd0w2SFQxRVRKSlp4N1FKSDFLaitN?=
 =?utf-8?B?UUdhR3BGZERZRlJaVmViM0ZGaGR6bmN4U2pUd2pwY1h2QmlZdE0xY3Y5T1pU?=
 =?utf-8?B?a241MSsyUUNhYkdKcWVja2lPcGNTOVd2UkpXN04zMnhpdXV3SVhOZVZYOW9S?=
 =?utf-8?B?cUNOM21MZjI3VGVOS0tuVUdqUU8zelB5RGpCd0NRZWtrSUZXWC9ZSE8rSjFP?=
 =?utf-8?B?aC9sNHJPZUxKYjNtajFSOE1YczdOaEhkNWJWL2tJUi9VTnhxb3dZWTNDeDJ4?=
 =?utf-8?B?NW9GYnloLzBEYk0yVm9NUGtJZ3hGM29Rbys3RGxnbFZzMWVZcWdBNWFlUzJB?=
 =?utf-8?B?Q25IcFFHQnBoTFpUMUMyWi9jNWFzVXFHaXdiU0FnbXBqbnB4Zkw0RndpUUt3?=
 =?utf-8?B?RXdORndOck9XK21WMC8zeGxNRWVGZDI2a3hIRXVDVG5WZ0JIb1l0Rmk1c3NB?=
 =?utf-8?B?azZhbnFKeUtkVWxSMFRHNWUrcy9yVW03SlZwV0ZuSS90TEQ4dUFFZnVKMUVW?=
 =?utf-8?B?bllHWjF2Qm9GT3lxZWVkb1JEOTM4YkIwZ1FubmFURm1Sd1F1MWdjNFZXMTBU?=
 =?utf-8?Q?vfycyUoyDOvgdiFc=3D?=
X-Exchange-RoutingPolicyChecked: MvICLBxjt418gjgxxEZ7GKyXE0UtmA2ebs0+w9mXlvU/JQFn8slDAQzfGAyE5DUjX0xRf9BybkF7o7cTgylLnOa3KU9Qfws7LoKYYS3Y2N+VACiL0J6IhAC07gp4YiigEiblnJjUJhT1TrQUfhxkFmdpU2dub8ewXGVGkjMffQpx2CeBrAFaYCXI8QnPwzck/oygsFKbexijhHX3W7Ln4cqSwgBC5NQOR8DUmnIxN6HAzKIbw7Ou3OgTEQZ7HrcBUbVeK1cWJj4NIPmplfuAGlTJbjR3R7jKJXcnaESNAmi0Su9z+g3/EdHlm4O/uB3sz2qGMgiXQX3OMc8zl+8rxQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf33bad1-cdf0-46ba-0acd-08debbdd2f79
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 10:46:19.4241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+S9HlrYcFgQmux9oV9wJNFk+ipntZDtep6xkEK6kq0opVm3K9mYX861YNm8v31iPlb2UQjtWbSbVxltkKZL21HEBJqA3FDTNP6DvjFJbsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9394
X-Proofpoint-ORIG-GUID: IxHr3IVk8DQv5lBj5RTEuhE17ePS32HP
X-Authority-Analysis: v=2.4 cv=fr7sol4f c=1 sm=1 tr=0 ts=6a16cb7e cx=c_pps
 a=w/xsMB98MdRKPpKwYm4Ziw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=6R7veym_AAAA:8 a=gHyj-mOlIS55BAtS5HkA:9 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEwNCBTYWx0ZWRfX2yoErtRglUR0
 rvG0fw85+ULXmtWRvRQmk+JIrSxHBg2nV8vPXsdyBBrucSm7ZMWRDwqUmdsDmyTtX6Wc3xos7we
 iyN+KDrTHeDt+O1DwpNHVpIJHGp3MvI0Ihk7LF5+FLCbZGN2DMjOYIP5TsNz1axVOxveKLmyfO7
 w1fQ0ziSQ6Q3eRbOlPkJmCTQM/wco0XQJ4KqzH5vwSAV95GRBENBL4qVJzJZcz0lI5njFgmE3NB
 HeL2ADmRTNi/9GmPqsnd/6RcKeTMJPj2FwYkn8rHXaKrdCQAQKxyAFLwuyQRjgCkl+CLHUx9plv
 Y8REH1VPfQiBkb6ibL5INHVmdx7xo7xNRAxukXj6y8qWByraecb6FxhMd3D1h0ebm6EOyeWtzN0
 RZ2UU+GfApFXO7kHuuEVChLY5iC/dfGAktFHGP3O3Oq0zWrZIGQLKERh6Z+5wzTabqKAf798jAA
 mYH+zwjd+RnaACaRrPw==
X-Proofpoint-GUID: IxHr3IVk8DQv5lBj5RTEuhE17ePS32HP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 22/05/2026 13:05, Vladimir Sementsov-Ogievskiy wrote:

> Hi all!
> 
> Here is a new migration parameter "local", which allows to
> enable local migration of TAP virtio-net backend (and maybe other
> devices and backends in future), including its properties and open
> fds.
> 
> With this new option, management software doesn't need to initialize
> new TAP and do a switch to it. Nothing should be done around
> virtio-net in local migration: it just migrates and continues to use
> same TAP device. So we avoid extra logic in management software, extra
> allocations in kernel (for new TAP), and corresponding extra delay in
> migration downtime.
> 
> v16: rebase on master (on top of "[PATCH v4 00/13] net: refactoring and fixes"),
> 01-08: add r-b by Ben
> 06: add a-b by Markus
> 07: small fix, exclude vnet_hdr= and ifname= arguments when
>      incoming-fds is set (they are not allowed actually, and
>      netdev_add fails), keep r-b by Ben.
> 
> Based-on: <20260318113144.15697-1-vsementsov@yandex-team.ru>
>      "[PATCH v4 00/13] net: refactoring and fixes"
> 
> Vladimir Sementsov-Ogievskiy (8):
>    net/tap: move vhost-net open() calls to tap_parse_vhost_fds()
>    net/tap: move vhost initialization to tap_setup_vhost()
>    qapi: add local migration parameter
>    net: introduce vmstate_net_peer_backend
>    virtio-net: support local migration of backend
>    net/tap: support local migration with virtio-net
>    tests/functional: add skipWithoutSudo() decorator
>    tests/functional: add test_tap_migration
> 
>   hw/core/machine.c                             |   1 +
>   hw/i386/pc_q35.c                              |   1 +
>   hw/net/virtio-net.c                           | 137 +++++-
>   include/hw/virtio/virtio-net.h                |   2 +
>   include/migration/misc.h                      |   2 +
>   include/net/net.h                             |   6 +
>   migration/options.c                           |  18 +-
>   net/net.c                                     |  47 ++
>   net/tap.c                                     | 246 ++++++++--
>   qapi/migration.json                           |  12 +-
>   qapi/net.json                                 |  10 +-
>   tests/functional/qemu_test/decorators.py      |  16 +
>   tests/functional/x86_64/meson.build           |   1 +
>   tests/functional/x86_64/test_tap_migration.py | 458 ++++++++++++++++++
>   14 files changed, 906 insertions(+), 51 deletions(-)
>   create mode 100755 tests/functional/x86_64/test_tap_migration.py

I've been looking at this series to try and understand how CPR migration 
works with network devices, so I'd be interested to have a look at this.

Do you have a working example command line and monitor sequence as a 
reference? I've tried a few examples but I appear to be missing some 
context, and there's nothing in the cover letter to help out :)

Also do you have a git branch somewhere with your latest changes?


ATB,

Mark.


