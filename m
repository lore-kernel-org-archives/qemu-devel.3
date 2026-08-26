Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2855C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBDZ-0002iL-BP; Wed, 26 Aug 2026 06:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzBDX-0002i4-7h
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:50:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzBDU-0002av-LV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:50:50 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QAFpF63074950; Wed, 26 Aug 2026 03:50:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=SI7EGyq3WVNu9PQoD9pMkJpoEQX2JroWfqFt8TYPA
 Rg=; b=1kdbMq4ixbS5Nj0NEfv7nMXqp35Edckukf34lRfWKGCQxwNBXrjTzvcUS
 qyFDGBGFZPHJ+cnK2Wf0sETYAQXVxFl9hNeYHaXbqbPY1m04VTRPtyF00OkyoSDB
 KYDL/+LUvr/dzqBMW3m65AawQTkiPZsSV1+80yCRV/o6Q/55cAkkzHR0C6dQ3sBW
 rRO6JAR/Ma6dx0oCYxOcYGiieUPxjlSLJt0thjUstH5ND9iMJT4nVVhZXbrRLSDV
 t0z+M3AYNdLaq4pvNLlETQQus0Of+cq0INrjFu6QUO+INYbNVVhOrLMnejEVksC5
 gJk1P7g46/5rKd45dHCDhahAXwvDA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020122.outbound.protection.outlook.com [52.101.46.122])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g97as3k0n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 03:50:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdRuTUrH6UWWOugKsnk1VjIPtwlueIPy5WG8Jw4zv8snY+mEHJWqkiAedOXtoreTjvWGUq++bdXb10kgo8N2Mid/uWEmy7GRWLbCV4DoHoJ6kauditapprVWHEUylQEFdwQAtH402fRgHZJ6DJkkuDV05KrbKpEM80RJNqLTHsGHdmAFETn4AvK+05Ou6mFHJ9tFYcToH1N0YA1BS3xd6AmQg7SGO+8M9UNqVLiGC5cpaf0gyWisHOLIve6rt67lSthAHuXDjI4LZPf+bxgNPvm5nFftYA44RWKXkAgDrr4lh2nJ9zMAo+q0cOKoXQTRGTPGyIZV+l+QSp5i//xQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI7EGyq3WVNu9PQoD9pMkJpoEQX2JroWfqFt8TYPARg=;
 b=CmzVEguMzE8XlqPS6ae13hHDH/rX7qhJIGvDgBmKiqa6LKQfyLIOhYYjn04dTyekLpugWfxwE4ZrsTlGXAJbqUdxo0oVPK0v9fCtMjuOL/D+u1TyWjn5nt2vWCDfN7TN8WoB4dVGUc/f7cI0+c3i143ayUPpVwmHJnl1/G47AGkp4CQ1UzFNgR9Ba5tLG1NCZgpUx0vE1ChKKPH4qaMrwsqBD5xCvKUjQd3WLBbZwi41NackD2Q87hhYNlmlqyzabqBwQlgzSoZbAHTg2D4Cfyhczisydh4Wat909m1gjXc0LsRz0KNenlnT6c282UXd0ngEiVMlnUm1Htb4iFkZ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI7EGyq3WVNu9PQoD9pMkJpoEQX2JroWfqFt8TYPARg=;
 b=XHZKYGMO9Vm0BZtcHFn7BuCFzok57X6c+n8WAxFqoi6c5jJrAUbMV2/YXE4D/aCyTeLk1mIBvXPImXj0V903X7Q7VIiMUGy46/Z4Z9MGoV57TnGohwMgYiSZYLFX7N5dxmRtC8fjX3fouq6PHgT855heVC1J+Z53kzmY9I1fDIjDktlkHkB9zYeL1UzQqHMq51s35RN81csck3rkkCOlhiYgHyYIu7ckAWK+SrkO9DKZU0k4DhANKh/x6BHwtssZTWk8k9oVA2J80z19IE2UV2qQnNTZI5DeIXa8ywHc9ZiBsi3l5IAKjSHXncNS3HCiZIx8GI/78eKmB5XdFrDpOA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM4PR02MB9094.namprd02.prod.outlook.com (2603:10b6:8:112::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 10:50:40 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 10:50:40 +0000
Message-ID: <607c79c9-79b1-441f-90f2-90d58fae2bc4@nutanix.com>
Date: Wed, 26 Aug 2026 11:50:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/74] qom/qdev: associate properties with QAPI schema
 types
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <ff0c0539-c24f-4c5f-91bb-38168d62a36b@nutanix.com>
 <CAMxuvayg=mv4q3bYn72J5RZ3YpJQRsj2=_Gh+NkO9kMOJW7Vpg@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAMxuvayg=mv4q3bYn72J5RZ3YpJQRsj2=_Gh+NkO9kMOJW7Vpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0131.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM4PR02MB9094:EE_
X-MS-Office365-Filtering-Correlation-Id: 05be38c9-681c-4a6e-cc2f-08df035fdec8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|4143699003|56012099006|6133799003|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 091LWNq1Xl8yMkke1NPmSZsoSeaxc5aabyD5en+26KMv3wUv+o2PCtZ4CBGtWJ/RyIL7jpPmAtwJvg+BmuZ89t5NHYcBxSTCEqFc1Jp5lLbU8XtZ5+XktI5QmVqOTSGMKMubFOswqwHgt1I8ep6wMn4oRQowiwxEeRIsVnGNjF9flul0hQth2Y5ZuNccKfizxKuqJ6wZb87Y+C+R/tGBwbQKZ/0AHuBAxDdL+cLma4JpjoHbFCDZv5Cqa5NC2ruHFoYDUDn0TkxmdpMjtcyqHIqzo8/+kyCS7ppMclB8QkBcxgXTr6d+m/9KSISsgJpUp/aQ00vygvaZhF+AfYYHNslAxkcN8hh9SfsIrIPEsbJbSFbDh5/x4vAt6KwTaRNRQXBesn2T/Z13opZ02qSPmrNSlh2VXDB3kcfXBvLU6NZRyTtL7LEPwsLRZ4j6eYRBE7dPCmQy2N8Q7h8l+/CGRsPPVcKDKAQkjJnlpuQNbU2qDrBWsqK3e5yfZSHF8q5Nxe5o3RGeYvMu0tVqiT9V5XOydrWhEwKw8qS2KyxPLnZs0h7mkKhRQMuSn5h7UsMsRwSQW8q81LSR4rzTstwvoX5okjXF4nMsATKUMO06CW98mOQASVFZtYFmwHSuQ6QEpGMQIVyBUvrTZmggmSAaOwqUkGLyO/H/cGjpw8sfvUo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(4143699003)(56012099006)(6133799003)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkFtOEhBRkxxQkhWc05LSk9LTDd0ZGxJd1JFZlUxZUtSenNMcDFBd2g2WXl4?=
 =?utf-8?B?VlY2UWF0MlpnKzZFM0g5WjBNRkRvUlMvOXNOZ1pNY212aDJiSXY3Vk8wY0gx?=
 =?utf-8?B?WlZYbVRYWG9vL0djOVF2aUc1RGY3NVhvMTcrOUtXYlRuMW4rbnB3UkptZ3du?=
 =?utf-8?B?MUM4MStIbEhQRmlDQVhQVWZiOTUwK1JwaVFxRWJBNHNDSWtWSnFHdzY2NjJs?=
 =?utf-8?B?UkY5U1ltQldvalgxZmYyd29Pd20wWTFYbm1TMUpJSzc4MWsyMnVBOVZ2TXpJ?=
 =?utf-8?B?U1Q3NFJTa00rRU9kV2ZHaXJaSFpjQ3F3dUdwYXphMGhpYUptb0hyUENJMm9H?=
 =?utf-8?B?SGsxaXFOWG9pV3duRmMweVpOUVRUV3lWTEFHUUpQMWJXaXd6dTVzTlZXN0Ru?=
 =?utf-8?B?KzJZcFlEYzhBRTlXK0hSSjVYUitYODJNWTVGdUdNdDFwUjArbWw3SDBLNHRF?=
 =?utf-8?B?OXZTRnJEbHFVaDJ4RExKSTR5MmF2a080cTczTk9ZV0o4YW5ZdHJXQU9ZQ3Mw?=
 =?utf-8?B?OUFmcnFPcEJzcGxHa1UwOXpiOCtNVlVNdklMQzBadXNGcFRWbEczZEM1UjNk?=
 =?utf-8?B?enl4Z1hDSnhINTdZUnpVQUJKcmcwcVFQc0ZCTFFtRWdGZnBiRkszakVMZUls?=
 =?utf-8?B?TWU4RUVUVkFidUxtcmZRM2Z5MGlNdit3SndIaGc4aUp5dENVeVgvUk5KMk9s?=
 =?utf-8?B?aWZ2bmdQeTJkYjg1b0szVzg2VXBHbXBGazJ0T3hhcmxJMHZWeitFUzdMSnQ3?=
 =?utf-8?B?YVlQaTVWZldkQ0tBOHFQS1R6bE5ibnREbk5FeEFIRW91Z0pFNE5WakpOS0F6?=
 =?utf-8?B?NHl5ZFl2OVlmUlFpeGFTS3ROc2pJTnNlOTRIcUFvNWZubUZaMjBtbDRWYVo2?=
 =?utf-8?B?M2ttbzVDaWJTdkx0ZWxCeExaRE5Zc3lkTTZQS0R4bHloRnZFYWszRU1ETWE4?=
 =?utf-8?B?S2ZUU0pONEhNZlpScUVBMzA2SjRaeWJzTlJLRlp5ZDg4VVRnUmIvajVWaGts?=
 =?utf-8?B?UTI0Sll1aXN0V0Joa1hDdy93LzU2MUs5akkwbTIyeFQrcjl1TXkycGM1SUxC?=
 =?utf-8?B?cGltNy9GUmJrS3dBNE5tRExBL0toM3JHWVpqVFdrZy91ZVdtZU5peFpXZC8x?=
 =?utf-8?B?cGlGZXorTzJJeGthUjFwbTRvRXRveG85QkFrbGs5dXhHN1VIeXo5VlFyMG10?=
 =?utf-8?B?dHcwd1ZkUWQ3UVh5U210NW9wVHk5cyt6SHliZmp5OVFOY2NHaWRQQ01tdnlN?=
 =?utf-8?B?Tks0Z3ZZY1VRbHF6NWk5bmJ6c2llamVja0h4b0xSa3BGQzRUaUVJR2VOaUNq?=
 =?utf-8?B?N0VuOGltN2NSWmNScy90SDdFQklkVFRKUW1YUW4vSHF2WXVWQy9DT0VwV1l6?=
 =?utf-8?B?UWR3bXpkUHc5TE9KdCt4QlVsQ2dWa205Y1RmT0RvYUpZSXFvQnZyb3lBK3I2?=
 =?utf-8?B?dHhVWTNzejJuWngyYU10UERaMXZyak04TFNJVS9hYUJjdTRkUWZ3T3ozaXZU?=
 =?utf-8?B?YkdtU0lnc3c2VUtVVGdIcUZCTVByQkt3VkpvL2RBNCtBdVJVaEg5Ynd5eHRm?=
 =?utf-8?B?Z05kd3prS2o4S2ZmL09QbTl3aXdabzdQTjRuQTRhZEswandDQzhoS1MzNUMv?=
 =?utf-8?B?amJ5UklLNG1XYmoxNmFNM2N0RnF3d0t0NGFoLzdzaHJZMk16ajdVamR5UVgw?=
 =?utf-8?B?NHpualhFdGREYnJRK2YyYW9CSVJSM3lVZlZBZUNrMVB6MENrRDQ5a2JSWmdB?=
 =?utf-8?B?STJaaXRWUzl5MzJjb25KbVp2WkFIdnZIaERDOWxubHBlNmtjbUZ4UGZWZ3Uy?=
 =?utf-8?B?RUova3JOZDV3RGRRaFFNRyt3eG9JNUNyaEpVc1VTT2x2dStCMi9pWEhud3hx?=
 =?utf-8?B?L1hPKzFpT0wyeFBTN1U4cFNjR3dHaGxWaWprZHZ6TnB6eWprWFg3bFp3ZGNB?=
 =?utf-8?B?YjVjeVFjU3M3NVgzZC9lRkN1RGlRYkRSMzh6cDB0dlE0a1JNWVVUNnhJOWVP?=
 =?utf-8?B?bDVVVHR3ckVwazl3VHhCSHFsYk0yOGNOdkdOZlBoTjNzRTFyYjAyVS92dmJt?=
 =?utf-8?B?NVFVdTFvZ3Y4SXZFWCsxZm5QT3R0UjExUjN0ampsQmhvTmtBWko2TjQxVXk5?=
 =?utf-8?B?bjYzR3Y5Vm5KSGhTOEdqYm5talh0bGlhWEFRZC91Rks0YTJXSWlmWVNMUDBh?=
 =?utf-8?B?TlJYSVRKWkRGZ1dnZTRETS9KMUw5US82TWliemVSRUM0UmFMSzE1WVVPdXU0?=
 =?utf-8?B?dUYvSG9KYUJaSmFFTzZIRjlGM2N3QmJib2oxUmN4UE9XdFZmUDZ6Mldtck9R?=
 =?utf-8?B?MjVoYlFtRHNtR2ZtSlV4ZzV0bGVnNHVzS2lpYU85TzEzcmF1enJVeE42eTFh?=
 =?utf-8?Q?VZcuVTtCJHYCdcJc=3D?=
X-Exchange-RoutingPolicyChecked: VQbPkaZrCdMrYbDiKWCKaSLksCxfkSgTMWeVQNseKkftJD6ar9799gy5iJtoB6sToNK46Oj5nhQTXCcECxFHDSngkg+YxAfgOr5NPuv3NnCR7uSy7X4p3wY4xzllURtL9P5Ju6uFzEZkG0DP40f8r9QwNO0uGkLCZc9fjMA5GSb4WyNpzF+L5ViT5pOhneLP29uFdFj9qGKVbIzxZ7DjeL00jbZuD7i6BZIdmQ04Sl4KIHnPOvkw+eJV3CvYOXogAK0zosjl3xTdGn1DjKMLlByd9GBQp0GJotmFQbZ7JTt3nDzUWGYX2nVusWgVZ+L0mqFxI8vlQG3K5M3auXfVCg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05be38c9-681c-4a6e-cc2f-08df035fdec8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 10:50:40.6261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxryjkcqpFUr/eCC24hQxL77arpvzEc/UWyrvd6BjggTiog9lJS/Xz7jfPyigWFh2A5kH3mEWidMvI9DEaeZQXcRJFRH/B+lxJ1iXvb/fQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB9094
X-Authority-Analysis: v=2.4 cv=DJu/JSNb c=1 sm=1 tr=0 ts=6a8ec502 cx=c_pps
 a=Ov5XJGn/dQMl/+TwTE/lXw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=uaihUYACk55_rOfZFloA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5MCBTYWx0ZWRfXzK2TxLX4mA1F
 j5pNaHE7PXKQY6CvbDRdWPAWMtQH3azcIW7ZXdBHZSa9Y3iBKplMj4z7gRhDTYpB9coTiN3rDfS
 +rqsn8G4VA/u6s237wm6IbGV8llDV9k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5MCBTYWx0ZWRfX8J/7/s9cmDmB
 n9LqF998CrK4OLFzYNUx8+BRgdsEzT62Tft6AiIc8ShZzi4vreEIqe6I2DL46nSXeexbU3vAgzm
 hqU1x7aVb5iiZdwmFgNeaLy4B3L8nT84AYk35X24xd+lXlcMZker3UxH7bFL/BXzFy1sohC5Q9Z
 NDkMyJWCDNVt+XrCb9zCplIZquiD5tvvlvDiiCyKkbo0DowVRFXdAMjv7Efa2LslQmEVj8DZRwn
 lvQvmJuLe9YNf1CtZYZNDWqX0JLBdF6xXk51hIKHHbvsMGIKO7LMyqVlk6Z+O5wyTHXKXs0xDtC
 6xG1S2dusWSspp1rYIsrOzfx5w1yZDl7j8LqWuA2V5+2ZEGnfu5vOBkkuwc8JNZRIjlwDp+r2dL
 QT0VmZJ91S5/j6tsNfKmfN0VL2xETKOZfJM7grqcPn1huiM7Vf89emNbl8yIXA+qlgsmv94ZVFM
 fr3xoyCsPRdPuK/mHOA==
X-Proofpoint-GUID: l1jU7I1VeEg1fo6Q20Uf-BTG8WKl6_M7
X-Proofpoint-ORIG-GUID: l1jU7I1VeEg1fo6Q20Uf-BTG8WKl6_M7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
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

On 26/08/2026 11:40, Marc-André Lureau wrote:

> Hi
> 
> On Tue, Aug 25, 2026 at 7:33 PM Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> On 18/08/2026 12:10, Marc-André Lureau wrote:
>>
>>> Hi,
>>>
>>> This series connects QOM and qdev properties to the QAPI type system, so
>>> that management tools can discover the QAPI schema type of each object
>>> property.
>>>
>>> Today, QOM properties carry a free-form "type" string ("bool", "uint32",
>>> "OnOffAuto", ..) that has no formal link to the QAPI schema exposed by
>>> query-qmp-schema. Management tools must maintain ad-hoc mappings or rely
>>> on naming conventions to figure out how to interpret property values.
>>>
>>> This series adds:
>>>     - A new QAPITypeInfo struct that pairs a property with its QAPI schema
>>>       type name, enum lookup table, and list-element type.
>>>
>>>     - A QAPI code generator (qapi-type-infos) that emits a QAPITypeInfo
>>>       instance for every schema-defined type, including the mapping
>>>       between internal C names and the schema name visible to clients.
>>>
>>>     - A "qapi-type" field in the ObjectPropertyInfo and
>>>       ObjectPropertyValue QMP structs, populated from the QAPITypeInfo
>>>       when present giving clients a cross-reference into query-qmp-schema
>>>       output.
>>>
>>>     - Conversion of all PropertyInfo definitions from the old
>>>       .type/.enum_table strings to the new .qapi_type pointer.
>>>
>>>     - Replacement of the generic qdev_prop_array with typed per-element
>>>       array PropertyInfos, removing the arrayinfo/arrayfieldsize
>>>       indirection from struct Property.
>>>
>>>     - Removal of the deprecated PropertyInfo.type and .enum_table fields,
>>>       and of the old object_property_add_enum/add_tm APIs.
>>>
>>> Along the way, a few pre-existing type mismatches in property
>>> definitions are fixed, the "struct tm" RTC property is replaced with a
>>> proper QAPI StructTm type etc. Introducing more specific types or a
>>> "typedef" to QAPI could help provide better associated type informations
>>> than plain "str" in many cases, for example.
>>>
>>> Comments welcome!
>>
>> Thanks for quite a substantial piece work: there is quite a lot to pick
>> through in this series which makes review tricky. If you post a new
>> version, it might be worth showing an example of the before/after JSON
>> to help give some context around the changes: however it feels this is
> 
> Well, the most significant change is that the query-qmp-schema grew of
> about 10% to include types that are not referenced by QMP directly.
> 
> And qom-list, qom-list-get, device-list-properties, and
> qom-list-properties now return an additional optional "qapi-type"
> field to reference the schema types.

Ack. I had a play with query-qmp-schema which probably isn't the most 
sensible way to look at the changes...
>> going in the right direction, since it works towards the goal of
>> allowing a QMP client to introspect everything it needs to know about
>> the QAPI type underlying a property.
>>
>> I've started working through this with a few comments and reviews for
>> the patches fixing up types: I wonder if the type fixups could be merged
>> separately to help reduce the size of the series?
> 
> Sure, we can cherry-pick the fixes and reduce the new version.

I think it will definitely help since those fixes are easy to review by 
themselves and it will help reduce the overall size.

>> Question: is the eventual aim to deprecate the use of all the non-qapi
>> object functions? Are there many instances left after this series at all?
> 
> QOM itself uses non-qapi functions, but outside of that, none should be left.
I thought that might be the case, but I wasn't sure just from reading 
the cover letter. Does it make sense to go all-in and move the non-QAPI 
functions to a separate, QOM internal-only header at the end of the series?


ATB,

Mark.


