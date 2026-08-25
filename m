Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546D1C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 10:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyooA-0001Tp-Ax; Tue, 25 Aug 2026 06:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyoo8-0001QO-I0
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:55:08 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyoo6-0006zR-9U
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 06:55:08 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67P8AOio1112185; Tue, 25 Aug 2026 03:55:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=E6HCIXKsskoMEwwmceSggB504FjMWXD2ifxeG/Zvo
 y8=; b=2XdqczjMkWRCyGvYoloifXOhj7/DqRrjY9AGr/NRg5KK8uA0SBBQ5NX0z
 1i4BH7q+JJtVcE02ZPEEthY0vx6A95+xbpQhxTrBe+HuLzV7ZWF1Ju7lZbQksN4B
 3ppMilU9/6f3RZp2Z9BC/dzXCbWzQMeAf0FOmHGGLRFZQOdH3Yyn24C1au7GfN56
 BFolRNCaPGSM0OvoHP8MxVHPND3PxQr99L/VJ0Ujqh5vJmkNKv9HudZaYFM+fSjO
 ghgcKrAz9PRzF2azQ323s/rRQfrAJ2EXaJfXNWbLTLZRgNIXNl16txyiDw0cnFEq
 m1kgB9EUDXpSka0vG+7jOoTCswBlw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020121.outbound.protection.outlook.com
 [40.93.198.121])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g783qx5hr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 03:55:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRPtWQ5k18NrTWN2pBxqW73bW2b78dQpl7fCHI4zR/qKiBreV/wJmPM/pka+sN13Gs1NGWnlIvlsal46q5bE4S4QRjOYgkTZ/Ztzm0bmh7GqFGvDNNn/0875A1zq/lXb1jehTE6Zf9J4S1G0a2hkVJEOuy5NtMYvL9fOJcIbJcIbOaNXjFUL+hdfSfpbL3Ycu5Bk1FY0QDgrFhbvyQ1rcSUudY9eomexoY6B8armoYCMxRZymxilMW6HoROqOkIUOpNHYb074MNEtTXjLXy9V9m2cAmnZS+i7BgnogPmJMQfl0z8g6EjJCxJfZApdP+DvFBt7VwtIySOZaNviTYNig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6HCIXKsskoMEwwmceSggB504FjMWXD2ifxeG/Zvoy8=;
 b=pkhKtff9mv5TKav0LS75WlctC/dKgbZu4uEb4pqCTmgtf+Xa6U2B3tDUxWB91YaH6dfwRWkAA5HRN0kOMlP7+B+5kwXhi13J/315wkasDI4mAiZRPDQx/1F7/w8QNErqZWE9tIv3iwxh8eMG1+xRsoy3E2uwxzvvTHch1Q2UsI5p70ohLPNqba3dLBL3D57oRquZMSyaQqn/Mo4S4EQo/UmJFex2eL5jkm3J4ZNs9oW+Sx/wtY1icmXDJeaFuxkvLfQAatdva9ShXqcetOquoDCoY7/yuO6br9RX/kMvP+EfDlIDXGoGyADHFZc3Wy69nTVRI/jLnkdK73KVe9lQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6HCIXKsskoMEwwmceSggB504FjMWXD2ifxeG/Zvoy8=;
 b=l0tuFZ6atfR4Uv7rLlJO6QePLa9/UcYyGbgRZowK+299hdR38inypWl8pw+DniGVS1fid4S2ImGGcxUPKjZR2EZJUdfUNtNgOcXbOPSilik811pZaJK8D6X/pd+ZyDn4LW64VWiZK+VEj3QE1JkvbFGWIYXYV8n5DeN/i4mASl3Np6bK8bXkk7Y1x/HufCCNqjPAikeLbQx7Kv1ZharTpZ1pPRhCB1N85CdVXp25idX/4bpxl/VceLLxiST573Zl8tbIwlg2uCzclbbIdGwul1ln1u0oTTtHL+JMEpZD9NroXrA8HvlA7owkayfylFhQDUa4qu0L1SC4EaZ0V6LIjA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV4PR02MB10932.namprd02.prod.outlook.com (2603:10b6:408:2d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 10:54:59 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 10:54:59 +0000
Message-ID: <69d07179-388e-4285-902b-36788b2b3da1@nutanix.com>
Date: Tue, 25 Aug 2026 11:54:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] accel/tcg: Make halt-to-exec transition explicit
 and remove cpu_exec_halt
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <b5b003cf-0997-48c2-adce-3632bba01f12@nutanix.com>
 <bbd002b8-c4b3-40aa-b25a-87a101293dc2@oss.qualcomm.com>
 <86112e29-c60b-43be-98a7-db2030640323@oss.qualcomm.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <86112e29-c60b-43be-98a7-db2030640323@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:806:130::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV4PR02MB10932:EE_
X-MS-Office365-Filtering-Correlation-Id: d4368f21-626c-4aaf-02da-08df02974e6a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: 65WFNmVc4FTh3WSO9qsBNk/IOxO3iemE0f3Q07N6QHmicjVoiFTdgC8bKb/d+6TLdOC2tjuOZsuJnqgbHTOJ992ywkTH2Kgauu2O5qAConxUuK2ScfQwzaAPlCNBLQINGmAUcwf2Yz6qfTzCqZJGk+jqMIydXoCChlCqeqTbWyxtbo8F3L6uwJzY4nyj5i81yzcloDIljVcxOOAZgI19MSy+j8D076Fq9SPgOdXgZrH2oQN+ghb5L6msWYU8YO0UHZwrh8mw7CJwQfd0jSHWr1jPvINun3rqkmw63ZkSWbqdl1ky1CkSQkNk2zfyNoBcZlNioFeyZ/pq31fAdQ9+SU3/goI8XOCHdIsXW2uj3noKzlIjUiH5u2bKcTThfeP+KD/ma5qEuzTFcgGHbTkImVIWV/OFZaoaq6jGwNZ0aCyAq53/c3PtldFciKFjrfsOGgVAjBwglzQJ6/gNET16ICUDgIfuP3dVY4Lp+BQZS8PTisMVa/cpsLEFWHlE1ruuKlCP6MaDV+IJXsBPm5KXI+hSHtERJlxJKJqEIzLhuwO255bn8cW3j5c4jr1bpz+Vpj50L5iZXWdx4hrHxEE7KkwopydBnwBhrTZibhyPzZR2KzFXS9SRbPDkxJZVCjACRXaBUXzc39NCe3rFC9PrDvvykkQRGuKv2+OQKOIC0t4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVFMVXFJd0QxazN2V1VIc1JuZDNjMXRoY2UrK3pNQ3RjVm51YWN1OWRSWEF1?=
 =?utf-8?B?dTA2YmhqUmpmbHFvV1I3MWtGTEtnRWFka0t1aGZobFlBTXBLRjNNTGVaQWZx?=
 =?utf-8?B?ZElWc0VkVTJJVmtEMWV2a3FBY01SV01YWEVka2xyV0NlRVJnalJQNU9Kb1Ni?=
 =?utf-8?B?eWJ2L09BT2VwQjljNFRualRNQkRHdS9qa0xydnNsMytXUmRycXN5L20wV1lp?=
 =?utf-8?B?VDdFbUl6VFNuZTdCZ1luUlk4d214SnN4dHJIeUtYdktLdS9CRW9LOWZNNXRy?=
 =?utf-8?B?cEk4NlB1Ym5WNm9EZkREZGxFNTNFdVAzbzh2dWV5R0ZReGRWZkpTeDBHTXpL?=
 =?utf-8?B?NFVjbTc2dTlkeUdtUUFkWFVUZkpmd05wOHJ1VkNrU0ViVFZERHZ4ZXdyeXI2?=
 =?utf-8?B?aFA4T0pZdS9DdWt2TGkyMmY3Sld5cnM0ankyd3FoUjA3TGhVTzl3NHJTay9w?=
 =?utf-8?B?YXIvSGtwVDVWcnZJdDNUVWJhMHdlcFdSSDBla1lKa2JBYTFJaUVyZ3hlbDRK?=
 =?utf-8?B?NjloSG5RY0dIWWNmSjFiL0Z3NFQ2YmhaMEw3NVFMWlhlYXJpMVkrSk1zTG9Y?=
 =?utf-8?B?OVIrR0l1RE8xVWV4ck9MKzFLazI0YklSOGhlY3R3Q2I5UkU5UnY2ak5QVEln?=
 =?utf-8?B?U0NvcmU1SHVSMDk2ZGJUYjdianRkaWQycXFNR285a1phSGd2bHZIcTRiK2tw?=
 =?utf-8?B?Q3ZySWdCQVNqZWFvTDlFUEJka1dPdEswYlo1TlVZQVFwL0YyVWY2S0tkd1Bs?=
 =?utf-8?B?QXpOSVA0eHBCYjdkK2NkM01nc3doY2RocUdkUk5zcm1pc0J3NWI1aU1HVTAx?=
 =?utf-8?B?SElrSlNjVEtyb3hqL3NHQlNISjZORW1kL3UxeHBsbVhUVllCeHNUdEpCbjcz?=
 =?utf-8?B?R0RWM2hCNjhRY2c5SGFWdHJaTXdnYW16M1JzTzBvd1E0N1RtZ041UjBXZWxY?=
 =?utf-8?B?U212ZU0rdUhkdHlIM1JNeU5MelBDeTgwQXZxRnM5M2YwUFVvSkdEdkVVZnBK?=
 =?utf-8?B?WmdTNFU0YnZxTEQ3ZmZUZHN2cjB1bXFzcWNCb2IyUTh6NVM2cC9VVTI1R2ZB?=
 =?utf-8?B?Znl1aUxManlFUDdHNTIrUE4wR3AvMGN1SitGT2NOdDhndXRkT0VqWitsTXI0?=
 =?utf-8?B?ODRkR2hpWVl2Mk93SDcyR0RMWmRuOGgydHdsTjBwaWdpaUgyRy85TEpWK2pl?=
 =?utf-8?B?aVB0R0ZMempSelh5K1V1WUZwdUN2MS91TkJoTmlYcmkyZjRlUFFLeW9VOEpN?=
 =?utf-8?B?RlRnM2s0TlZoOTFqajZRUFEza054OUpLY2JKczZ0VzVwR0VBdktJYXNHelRp?=
 =?utf-8?B?MDFwWUorci9rdjN4TUdkNk5hMXorYXdtM3l3ZTgwZ25NU0p4RXJEOHpXZXBj?=
 =?utf-8?B?bHNvR0J2VnlzTnBGRkdLRVpQTHduc2REbUhWa0M1dXl0STBjU1o2d2JRQkJ0?=
 =?utf-8?B?V1c4bE4wNkJGT1ZBeEliRmpjclVTRG1tUWEzRDVDbU5UUXZ4aUUzN2UwaWl2?=
 =?utf-8?B?MWs5SnB5MEt2Z1lBOU9MVjMxV0FVclpoUHl6Rk9rQVRlc3R5OTE0K1VMRGx6?=
 =?utf-8?B?Y1JrMkFjT29KTittUng3RXZJb1NxYmRxdVM4UzYyMXpqbXNQQUV1Q3dvOElv?=
 =?utf-8?B?YXpCeFJBK0M2aFBWOStXRjVmL3VPVElvMEg5K1dtYUN4K0VXZW9BVTduQm9B?=
 =?utf-8?B?cEtJeXVzVHBXQjdvUHYwdjdTUGcvS0xMSDR5eVp2K0Z2aXZsdjdXcGJUek1u?=
 =?utf-8?B?b3pMMm41S2NnQkwrQWN1Q1RlMDNybDFFWmh3dTNsWVJiY0JWNTZ5eUdjT3E4?=
 =?utf-8?B?K0lyL2I5cUFJWmlQa2NuTzFvWTRPamJuci9JSlhzWEdieWVyN0RQRU9UdWVX?=
 =?utf-8?B?UDNZUEFONkJkS3AwcXpydUZHc2JzQUFLOFN0LzdDVDBmTzA1RDlkeTY3Y0Y1?=
 =?utf-8?B?S1grM1ZrSnJZQnB4WnloNS9BbDNueFZQY0J5akNURmpGdk9Md2N0TjRUNWlX?=
 =?utf-8?B?UFlaa0dJelVHeDV4MkVQeWJBRnpYbEtzMWhlazEybDI5dUNKVklhclY5aFMz?=
 =?utf-8?B?SDVJOCt2Q04vaUNxS0NOUTdic0hlMXVqZmVnRGlCMnhXYVFtNVhhR09FMlJ4?=
 =?utf-8?B?bVcrSDBoOXE4Y1BFdmNEK1lLWW1jcERKTXRmSzgraE8wWHU3d0hlOGluR203?=
 =?utf-8?B?S0ZaQUFRYit0NlErMUYwWUYvenc3dlN4WnlnaUNtM0R4a1E1NWdrM29mc2tB?=
 =?utf-8?B?RzRSWnZOaGR4THBiY0ZyRzhDNUFpdGE2aEUvMGhoTCtlQzJlUHlibDlWUndk?=
 =?utf-8?B?aURkRFh0WER5aVhZT2tjWnBsenhTMVJBZFpSNzE4cU13QVA2RHUwcWg3d0ds?=
 =?utf-8?Q?Rbgehj4Pn3lbLgMk=3D?=
X-Exchange-RoutingPolicyChecked: vohwRz0oKZ7sLQ6SippAD0wb/uUe9SVn18z/0xHr8X7d7q4QBgq0JVlsG1f0v5K/Qfh4xvSWbGENSpxh99CIkLZKo4mb8S2PninaZqEO+s1UTdUXs8NT/5TuxvpcOEDArmHUil5aiRwCKPVC2SSmk34NuVIbslpUpCf9aDJfEBv/JoSmtqp/lduJSlSOJfByYXcGYbMroGDYNzJ4FSSzuRSDjAaakvciMII9H4sZ1eWngmyNE2z8TDdIssdE17U1ny8SoAsKlsf36y7OoU7CoepsPsKJXR1clwlNCjBtA16kA2blQBFjrRonvzOfFP8I0NCiN/9NuQjool+j7YhQBw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4368f21-626c-4aaf-02da-08df02974e6a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 10:54:59.0801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoEdsDE9xGJRCR3ZVmu//SGLsaHg+EmPlok0vj3wp3tkHAeDVX5u7PL8zx69ukA+CtCoVBtfmSG6kkxb2lUtu256TgOTVzrztBsUunvBgMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR02MB10932
X-Proofpoint-GUID: vfPTG7AQMEkPdr8ByLHLbcqYG7C1ENwi
X-Authority-Analysis: v=2.4 cv=KdfidwYD c=1 sm=1 tr=0 ts=6a8d7485 cx=c_pps
 a=cKBc+2/Vqua3nEp0WttuKg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=JsiqPcCorJgm1ZspVpUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA5MiBTYWx0ZWRfXxJnrjSVhjrPm
 JkkFLRPmX4Y7ObpgLjbO1/XMMkMci8AoWv9juLT2T046ft0lFKsSLxoambfLxVn0Stl5a0+Q4oT
 tI4vDxWkV6MLYPGtDlN1uWBlvBWHq6E=
X-Proofpoint-ORIG-GUID: vfPTG7AQMEkPdr8ByLHLbcqYG7C1ENwi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA5MiBTYWx0ZWRfXwatMW7VP0PfH
 jlwdEd9il9KiufTKEBF7MGu/3Hr6sAakP0SCHiHV5sK31eBDa5Xu256tooPQeG/Ku33s3u8gdrd
 fU+xMbUU1gDtWqxd9tDNAO2CBvTP+4GwDrm64ogPTzHaeRlMXjzWNCfMXyYZybXLRNgD16fr0qY
 MaauArmQ7ge1tjiHqDKjW8ASLu7E4R66z2Nhhu+B6Re7Ntj7ZDvRy87Hyugjom6YO3RspVXXv9p
 rUdTRdxASIdEJYMn5QKq/AxoupPywW9n6Dx+P9af1J2SZiAIIYkUvb03CKRN8Ovj0dRw1xt8ID1
 BzXCxYt4nNSNmEyYZrQP6fTTKt4/JaQILMGQFaBG9VK2B65hX6q8/0C93bkvMcigTm3r6elq09G
 GnU2UhfUZ7u5Wyi5ktquG9mjB6zT1stnOcnI6Zzxqxt44AyiHHw3qneCCwIw4fWv1El6J/PRlqU
 H5JPOB6Vtdm4cpyPi5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 24/08/2026 22:31, Philippe Mathieu-Daudé wrote:

> Hey Mark,

Hi Phil,

> On 20/8/26 11:56, Philippe Mathieu-DaudÃ© wrote:
>> Hi Mark,
>>
>> On 2026-08-20 11:26, Mark Cave-Ayland wrote:
>>> On 19/08/2026 15:56, Philippe Mathieu-Daudé wrote:
>>>
>>> Hi Phil,
>>>
>>> No objections to the idea of the patch, however I do have a couple of 
>>> questions:
>>>
>>>> This series was inspired by a previous thread on the list [*].
>>>>
>>>> Refactor the CPU halt-to-execution transition logic in TCG as
>>>> something more explicit and composable.
>>>>
>>>> Core problem: TCGCPUOps::cpu_exec_halt callback mixed concerns,
>>>> it checked for work, processed async events, and handled state
>>>> transitions all in one place.
>>>>
>>>> Solution: introduces two dedicated callbacks:
>>>>
>>>>    * process_async_events(): Process target-specific async events
>>>>      before checking for work. Called early in cpu_exec().
>>>
>>> Can you explain exactly what you mean by async events here in the 
>>> context of TCG? Looking at the thread indicated below suggests this 
>>> is terminology borrowed from KVM with which I am less familiar.
>>
>> "asynchronous interrupts/events that arrive (from timers, other 
>> threads) while a vCPU is halted"?

That helps a bit, but if I were looking to implement this function for a 
CPU then I'd need help with the detail.

For example, can we assume that a CPU kick or timer is just the 
mechanism by which event processing can be forced? In that case is the 
purpose of process_async_events() to respond to the current state of 
cpu_interrupt, respond accordingly, clear the interrupt, and then ensure 
that cpu_has_work() will return an appropriate value afterwards?

>>>
>>>>    * transition_halt_to_exec(): Perform target-specific state updates
>>>>      when transitioning from halt to execution.
>>>
>>> That's quite a name :) Would something like cpu_exec_resume() be more 
>>> descriptive here (as well as keeping the cpu_exec_ prefix used by 
>>> other callbacks)?
>>
>> Naming is hard, I rather something self-explaining when reading the
>> code; we transition the state but do not resume yet. Anyway what about
>> .resume_halted/resume_from_halt/resume_from_sleep/resume_execution
>> instead of .transition_halt_to_exec?
> 
> WDYT?

Can we ever call resume from a non-halted state? If so, 
resume_from_halt() seems clearest to me, otherwise I guess it's just a 
plain resume.

>>>> This separation allows the generic cpu_exec() code to orchestrate
>>>> the flow cleanly (process events, check for work, transition state).

ATB,

Mark.


