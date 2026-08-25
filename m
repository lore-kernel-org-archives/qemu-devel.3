Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C41C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysks-0005qS-Dt; Tue, 25 Aug 2026 11:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyskm-0005q2-0s
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:07:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyskk-0005iU-Ik
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:07:55 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEbpjB2191564; Tue, 25 Aug 2026 08:07:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TUzzGBKmaDeJXsBB2dP9I4t/Z7n6moy62klTitZX9
 /8=; b=p3A2WlvVqk0Of5m7hwQXYLf55oYY6+gYKEZSgBKQ4rO1S2qczm1l92wV/
 tEZvTE/pQ+ga7doGPFO7ff8TSoRm511y0tpc+axbhzYmsTqnYuSIzrfrb5LpvdgV
 EnaWhsSqhVKzkPQRloC1RMJGWAaIpPiQirnYfmfkHWEor89FZxfZl/8vXDM7ZNhf
 VI7N0oddE6oLhb5cJ0cknXbUulIAm8Du4TmhT7DUR14xr1M07bjjql7L9ZcxrDP/
 O5el+NdBfYMdDoMVxVx47ufgFVB1jYP+MPjoKeIh10jBzfRNvxNICXaXbcXtPFV4
 cgMc/G8sbIcnx6AxAwGM2xEOhbWAw==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022096.outbound.protection.outlook.com [52.101.53.96])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g7b9y6kx8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:07:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Riaw4CNLcIniBkpKD1JD8d/a+Rg0cX7LFfH7GmLFrc48oC4MRqi6ntOej0gFpLGktg9oD+LOuPja/lBe7mSZlpL5k2gp6UupqaU535XZtkK9j7jeMzPmVh1DreIdFCIUXJhozwvuEXwA9/5Ywaqpwu6HDZl1LgYgJ3m6rhwndhzREqxWMFtvPpTfB6Gk6Ua7YaROgCHOH0LgaN/Td+Z4rW8ZleqUhDkWBJSCmE2uE0H/lJ8TqztXRnA+NyaG0LIpZE4NQ7ZgBM7HnLm0N+ywHlIlF/rBpD6KC1vqwBUELVDHmaaGn5Z27RltgJZPFv2zKSA3nvgITVy9E7F5YWuMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUzzGBKmaDeJXsBB2dP9I4t/Z7n6moy62klTitZX9/8=;
 b=e1BVNjSEmtslFvtIRKBF4SFMwRpkbj/nvr0Cc7B/Eu7ZvIiXQB9GkukYcMa5pR40GMkJZfBU4vfqpQ2LDDjmPon0yFbe3QfYMHixJ2EbuAyQ2XzEADqye+OHUAFJN5YJgXra+cHeaOz4b7Hc2HtIyvhnjGYYTYT8m5ZApyflHuHh7tMwPbKgT3Ic3A9xPXyHvIqoSpMgSReY/P7k1UZJn/spqLcB6xnAvv8LGj3SIv+nZ+9xp5+uoygQ+mhv8sS+IAFiV3i9aDUnkd/dJUwxe+mqeFGgeKdPo0C8zEswkChoXYLnEXgyazCH+9oEKNHl2vvo6H1SJDsoMRRv9kTcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUzzGBKmaDeJXsBB2dP9I4t/Z7n6moy62klTitZX9/8=;
 b=kzc7EVIa+QXCxhR2XGdsCCXd+FlFCYPdCh4BYaUv9dIQIy/Omdz1HrKBxVhgNiC9xI4LE8D0U/JRWkLCui4B24JK/YdyZe8HyemIjoEFvbbNK2nkRFT5mKCvcuPtWQhMqjLa3FjdXS6nCV9MibIXCCLkfl1vbMD6BqEW6BORY0sY3wWh1wRabgcbG3mH7cAXDBU7yOQ/+SxRiPICWcOvrbcqfvSP41u0IdG7h0jeYQM9WSc0kElZ4BTJKOx/9TDtmTQ1hfHo+fzI4VZuRLEOgo4KaOUFnI9XPnNDpz/Vw/Dcz9tp4xTrmWMWPEpPWC4IrJYUDVIKErwTULT0uIQOfw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8855.namprd02.prod.outlook.com (2603:10b6:303:158::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 15:07:45 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 15:07:45 +0000
Message-ID: <4e0edf67-a39b-47d8-980d-353e138b331e@nutanix.com>
Date: Tue, 25 Aug 2026 16:07:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 33/74] accel/tcg: fix "tb-size" property typename
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-33-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-33-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 1945121a-7def-41db-66ed-08df02ba9e62
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FZVIbfXUzRmlgcJudaB73RiusJwonrFVLncX3YRZyNAE3G25oVinq51IVHRibVGzziidbNU5syDM5YHUp0u8OFqU6k0iOt9qLGN1+Ha8FiPasTtL1XA5b1m2O6xrwLSIf8Kj51sCjpxGZUrYrfJSFV/V5zU5cwof31Zmzas020uRVxQyw6hlmBeApTJNxMFCKuBzMeEFb8NFOZRhv/UX6+HDiGdO8xyR6eh9cYG0cEVvDgvLr7Rym2preXSq22h9P+1AQIH9wJTZ223G5F2kQflfRNLLXPhMPBnnIdacazYRwWnt1KZ3QkARFGt6G2gvMfOQE9yn2j6mheu849fXAqlaz5IG3pKS/5mu+cRSty2QLJU2LcaYVWMvTICOnJJvTiVIK1BZDLhvr1TL6Qs0DwFxR1Ns5UbEIgORd4bCya9vOFeW52vVYj4Nlx2lE7iSkVRlTgB6i80hm3J2MAzzqXGSELtehqZmcW09kJo0UxzVquyEfatJqm8kJEO7ZseopG43yzl60Fb+/it+eoGwf0uBhiyikIkF5eS3h9cAj/q5Efu6hflhfk4C/h9y3tY0vOjEj/oQbWoUvYw4iot3csafnFV2fjH43mh6BFiuf1ADtPCv3DQc4BPIQWnfBWcAdMcR599eHXn0i8nKsBr2bOEyTcRhgb8Rn4sDKxMNMVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3dyQ2xHY1MzVyt2d1hGQzBUT0lYRlpPUzB3N3U1enRHOHhHMzlQTk9kTVJn?=
 =?utf-8?B?N1RIZWVheGJGa2QvN293elJGWXRpUVp5bG9GWkxucDVCRFFrcjdwakxFNCsw?=
 =?utf-8?B?OXMxazd2VFlrY2E5cGFkQTBydUU1ckJYS3BIY2huSEs1S3dlVlJVcDIrdklO?=
 =?utf-8?B?OXNEbS92RFFqWm11akk4bmc0aHJXVzJsZ2Nxd3czQzhWZnE1Vm1sM3JVdmkz?=
 =?utf-8?B?dDYvR0E1RWliZlA4NTQ2ZXYrenlIdU4xaHVXK1dWdUplemhHVTloY01nT1lP?=
 =?utf-8?B?VVVCcGsreGo5R01BMkJiNCsrV2M1bThZKzBlTEhLNUZxU1g0K1lpK25udGR5?=
 =?utf-8?B?K1lsNTMxeS9GWkZiTDduL0dCRDVsSTFybHg0ZEhkZHl4NTJBeS81VkszRkNK?=
 =?utf-8?B?cVRuRnY1bFppTy9aVEEzMkdNR2w5NW0wWERWUGFUOEdsb1lqUzFqZm5ORGNY?=
 =?utf-8?B?cHNSUWMybjIyVlZ3K01zY2dHaEl6MW1CT3N5L1FTTGZSdVFMOFVSS05rTEo2?=
 =?utf-8?B?dG1MOTZkTUR1Y3Zvck5QZU1EcVpndHg4bUJuN0JnWTY5WStCSC9xY3VOazli?=
 =?utf-8?B?N1A5TXBTa0VVS0dlNWdHTVM1c2Y4dGhLa0xvTFQxeTlWWUJaaVF6R29PeC81?=
 =?utf-8?B?MVkrYnVWaHliRnlnZG04U2JLT05zOVhqY3ZrRlhBa3NuL1ZRdHNUQXY2SWxm?=
 =?utf-8?B?b3Y0SFFxbE5CcTE3YlBobEJwVWZERWlRTjZWN2N4WTdyU2xGOFg5aElPN2VN?=
 =?utf-8?B?V2h0bVB5VzI0NHVwV0VkZThiQnFXckp5ZHR2cVNOVVBsWDBaUjByWW9YSWww?=
 =?utf-8?B?UlVlc3JwTDk2bVRaNWhKa296MTY1MnZLWGlPMm9BOUFFL2ZuTmczRFB6U3Ja?=
 =?utf-8?B?Wko3SlMzK3crTVpYTGRPRHB4TFd2LzlGS2QybDlMREVDZlBxQzNITlNXQlYz?=
 =?utf-8?B?TDlaaEtqQXljc1VEeGk4S2RYRU4xK0RpYUROaUVrelFiKzdOMEoxU1c2N1Nj?=
 =?utf-8?B?d2U4a29lUnEreDkvTXVPbGMyTXJhcnRSa2gzV2M1VWJ3Z1BReVFuKzBrYTRz?=
 =?utf-8?B?eHlNVjdsSHBxdWp6Z2IwbmN0QVZRQ0NEeG5KNGc4WGdjS2lqK1VUdklFQ2Fk?=
 =?utf-8?B?Z2lVVWt5RTRUbDJhMm5NWnh0UC9iN0NrM2Z0NGNvUXhoRCtpdnlicU01NVdo?=
 =?utf-8?B?VkFDVGRWRXpxYjlheFVad3JBWFg5SXVNdkVia3laNGdVbHIxeXR4eFZsa3dN?=
 =?utf-8?B?MGw2SWtLcERrSGhGeUprUXlZdDVHRnZrVXg2YUtFMnBDdFBtbU1CNnJSK3hp?=
 =?utf-8?B?aUxnQ2pxSE5qYUhaLy9RUjJJSE5IM29rWmJOYklWNmFXZlZaejBHOXFuZE82?=
 =?utf-8?B?VFk0dmdKSDBaSVlYd1dFcmlqblJpcU1tTjhRTWh0UHovNGVjWnNJdXZvY05K?=
 =?utf-8?B?d2tKRkdXTEhaUHdadU9JK3hZczJKUmFLcDJSamE5SEplb2J5M3krcVVQZlRx?=
 =?utf-8?B?NUo3enNvVGtXSnZVVmUzY3dGVi9nVSt1cElzc2tzc044TU9jeFlzMTlMdGhs?=
 =?utf-8?B?WU5YQzhqcE9sZWR4WHpvL2VhdTdtMEUrRHh4am1ySFczN0w0bytPM1FkdU1X?=
 =?utf-8?B?Ym5GQ0tCUllFN0REaEh5MjhQU1dpdzdTenNMeGdtV3lOWGplZkZRT1plUSsy?=
 =?utf-8?B?RWN6bnRkdDJKRVhSY1pBVXp4dHVhWGdHSnJwZUE5M0pwQm1IYmpUR2M4R0NT?=
 =?utf-8?B?OEtGdXB1TVBvN1NGVTVPOWJEa1BIZzJTQWlQbjE0aG1WbFBmSjJQS3FGbUxN?=
 =?utf-8?B?UkFDaFJHTFpySFNUbkI1UndZZmZIK1Bia3R2VllGbG1qV05GRnB6ZDhuR2dY?=
 =?utf-8?B?UGJQcGwrc0RZUEY0dXU1NUpNZG5iTkJpdVRRdWxqdmJ6dFJTamJDcTdlWWMy?=
 =?utf-8?B?MUFleVcycDJNR1JUaUZ2dVRRc21RdGNMNk0yWFhDUjVoYU0rWkVuRU1pWlFZ?=
 =?utf-8?B?a3FScUN4bUVQQ25BL2N1SnphR0g3SWdSU1VPRmp2ZCtPall5ZXZ1MmUwcC9Y?=
 =?utf-8?B?SWNoV2RoVkl6WnJRa1RUd0p5TzIydFByQ0RLR0c3MnFTQi9YM0xVbHAvQ04w?=
 =?utf-8?B?amxKSmJ5K2VJRWJTN3RHbjZPdldaKzhNWGVtTjJ1VU05OUtVTytHWmZCbWNJ?=
 =?utf-8?B?SnpqUTl0MzhsQ3Q0UllQWUdkY2pOVkNiNUV3azJFK2VlTUhIdnBmcFdOZzd6?=
 =?utf-8?B?aENmNDVtK3hmTE1nT1VBcGdXb3V2bzFsbW1jektncDVmbUxwOFlFS2JCNzgr?=
 =?utf-8?B?T3FWVTV2V0pqL09VeUZPNW5XRzg1dGNjOHg1c0lqbEVLcGxSWDJENWVQWmhy?=
 =?utf-8?Q?LILTwO8sWcZ6vpx0=3D?=
X-Exchange-RoutingPolicyChecked: a+3O5rHk7EJe13K/lDl0+W7dD8LCG7b+q98hI0E/vY1rBCapt4FLS2yEsmy6GU1PHPAyUzco9REbpZbZsbsiY4vWYmoMiRX1vx3ldol53Nc3WT4aL1w3N47LzZmp18cXcaH9eYA7mRY1cuIuIIflw/n1LPK0KXUY6/VqQ9XnzQN0JmktdM2fqriFwbJvLaNMJSvGni0UgD5JvyamBvuHkNgMyi+Y70Ttoq3VW58ZG+giTLWyNI2LQoUCioYAZ9hi78QQtbhoLBr2msKwc6D25yMafG2tReko+/tuYOZMh+vyUMfNuQqEevZwU8BjLjf4alhlLTa0PUfM7tIM6qyJXw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1945121a-7def-41db-66ed-08df02ba9e62
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:07:45.7097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1td3/+2F65qP1rmgoBUf/qY2Edi2J851+3aDfZc1rPkso+IluSTxpKpVwIbKfTtOQuIgB21yXM55mG7LjPWzcnnvX6m/qDklkHy29ciO7Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8855
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyOSBTYWx0ZWRfX2Fd2RKICNP4P
 3Ee2LXxHW4fZVgMJzLAYoY+fzDLCbtO7sD7SWcMZlQAxqbdJ7Om8Yg5bCtv3hhK9DW+idxbZWoL
 v0ruHLQuNkCcZ4PR/9c5x18CgCdEuDNt3oxRLuZ1Sn7sMrb1Xq3fDwFKTISEGZrgOskZ4bbqFPx
 r7gJzh1gqtl1fLJuFJ8T8wHqtVf2BtwkGy6/EO1lqF5lCKWUlA9rL94YGWDEJfEiKYEKv+WNIjs
 4lHjjeUR/0HmVCWs9upFxNxZ8qV8gUrW5s/g0C3YqG2NajN01nQ0YoFXG/GAcHDoiQdW7TA4aST
 9Ppc1vpKVNANaESy4AzFcSD9wVEsCiVtzzcrCnbT73JQc04Hb8osr0rpgCqSuoAltSjNkm4an4N
 SxDDnABC99ICkKBr12r30MV2zN3+xjZOiGdoKcDuvSdHl0Vq3Egd0n036lLkOo+vQq8+/SYny+l
 69Z87cCbg2sYpuCGjXg==
X-Proofpoint-ORIG-GUID: IfxPsR6FMiZaF7bAOztxFr26czMTn2GF
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a8dafc4 cx=c_pps
 a=6BO/oEg3A5udCF6k6mmjlA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=_BW-VI6-JU7XRo9WEPIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: IfxPsR6FMiZaF7bAOztxFr26czMTn2GF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyOSBTYWx0ZWRfX6mAqN/niLAQm
 yhXMyKNLeW9x8C9nPgUkCfbzliN1qTK5MNhq5ojGOyVm7pthh1C167Pay1vH4au6tzUEmft7XbP
 IRaqBRac9kIgILYSDNLGPh1gRrz8ng8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
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

On 18/08/2026 12:11, Marc-André Lureau wrote:

> The getter and setter use visit_type_uint32, not visit_type_int.
> 
> Fixes: fe174132478b ("tcg: add "-accel tcg,tb-size" and deprecate "-tb-size"")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   accel/tcg/tcg-all.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 7186c10cf022..767e8805552f 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -270,7 +270,7 @@ static void tcg_accel_class_init(ObjectClass *oc, const void *data)
>                                     tcg_get_thread,
>                                     tcg_set_thread);
>   
> -    object_class_property_add(oc, "tb-size", "int",
> +    object_class_property_add(oc, "tb-size", "uint32",
>           tcg_get_tb_size, tcg_set_tb_size,
>           NULL, NULL);
>       object_class_property_set_description(oc, "tb-size",

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


