Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C2FEDF172
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vquXe-00010T-C4; Fri, 13 Feb 2026 09:53:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vquXX-000100-L2
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:53:03 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vquXT-0001i2-E5
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:53:03 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61DALY1B3534709; Fri, 13 Feb 2026 06:52:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wyWqEdR1nBxl7AAcuGFYYZ0Cab32C2XCpilwE8CCP
 4M=; b=jG5Y3H9CKaMRBQP1J0BzI/NxhPtVMD0CIrBgyEblahLbIsLX7Ukm0sZiw
 6a3EoA0j/Hmxq7251gKjlbszgL/HdG4fo0k1vQaebxVd5sNNvUlfjFm8eSiXkHSS
 rsW7zsOmCmbzBfSUcX2AhnkGQWrhxN5PGUeDYdAHIT4AwfX4tt8eP4y3EECw4dm+
 LN1r1yFXCjBvddIyp6KNHLNC5MocM78c5ulank93CfWM5P1FDNuhkMn/f7mi+GgH
 ckJn9a2sNON8eXmzYqV83TwwerhC72wtpfcJ4LUAJsRXqiEHfdeWD/eOeaZu0ZJP
 ZJfyJbnBSu12ECxpNf7eC8loMAVOw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022129.outbound.protection.outlook.com [52.101.43.129])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8q4d7mfa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 06:52:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlT0CWGVlUq1S19yucUbFY8BRjV9M9fy3iKHUa4fFtB533wUD69u09xUePojLHDe/MRQAfkvOZd36g4TqZi10QHUQrW2Z9VMDOJ4ac24OtLBuUSs5Uyplb2peXy0rYqOCX7ap7LTlMnaNxsEgoIJVQcTT5Ha6zN/xyR/xe9eABA+s0l2xI3mpUTUZpTAHfesMgRTfTn0j8DX6V5k6XzlIlXIjrVEx+JCYcf5EnlpGI13vtAF0Qb8/HG8z8rz8x0si/uXM08SxiUg/t4tfr+j/Cdnr+CS17ekxOBPp8JjgAjmIkaVzNyEZAnjZccT5HraxuthPDGVsGUhRD9QFPtSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyWqEdR1nBxl7AAcuGFYYZ0Cab32C2XCpilwE8CCP4M=;
 b=n0kfUbQdbbGELjFyD7NqUxHK7CmIvda8rrBr+rie9XwQ3WjDVy4XvfHlt1MDXZNCT19JKptG5v3N+At6zr+MMwOHru5zOcxBTrKZ29+iLS99gmEfa3h0rBcbfZrtwbh4Qr2aeJGVJrJPK+lu69NPNo8wjc/Kj66IQTGywwP97h4AzjueoQM0Krq++ebHN6vmUGudzY31zOI9ACZfJ3j88EbleNDGgdmG7eDCzqbB4bGVseOsJz8SPX82iBFj3J2m7So2+uAa4T+4LhlDw90cTmQ1hDV15x8wUY4wmk4Tn1K7IxioezcYXAqktWKbRafhfmc7D132rLnIwXLzlRhFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyWqEdR1nBxl7AAcuGFYYZ0Cab32C2XCpilwE8CCP4M=;
 b=tdLgA/iNvvxuxaczn19y4NGkX/Vrre+nUkBm5Zsctr926uIS09+RbRdzaPdJMe3EZPyDkQ3DX0uyoGTXrcXzX955ELvkl1XXHlD0/ZLYp1dAwQmW/OTslTslmbKpAIaV1vaVDtSwpzDGGsRSXSv10IQx6nJAK4ab+5D0fQaTIIuKbCNMVCWMbB106utzsghhxUzjGSuVZ8Aldr7dxMc9px1QZhoAdgSkU36JJ8RMo5tQvuKzNJSk41utEIbR6nqGJ/CqJ2ApxR16x6zbLv1mGX4bYN8BBJwdV3kBGwYMpV0LKH21Zhn/Q5JllY3hpiYF5dKGSDbkJiq7YRUZAfWa+g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB10983.namprd02.prod.outlook.com (2603:10b6:208:5b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 14:52:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 14:52:53 +0000
Message-ID: <b385a1ff-d14f-4e89-bf5c-de2107f46af0@nutanix.com>
Date: Fri, 13 Feb 2026 14:52:49 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/43] audio/oss: replace custom logging with report &
 trace
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-25-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-25-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB10983:EE_
X-MS-Office365-Filtering-Correlation-Id: b057d869-c017-4190-3c75-08de6b0f90bf
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3JncEhUQ052a0FKaitTREZLdlM5U0hOUzNhblBuUG5aVnFOekpUTHVBRk1S?=
 =?utf-8?B?M3RBMFNxaW5OR0lEcXJhc21leFpYb2dGcS9rZEFlM3hlSmlwRGREUlg5cldo?=
 =?utf-8?B?S0ZFOWVoZm9ocVJvOGNoYVJBVjJsNnp2bEJGanVPbDFDRktxeWVwYkIzWXZk?=
 =?utf-8?B?b1hzc1pjZkxTUW9hL3RCaXBIbWcyamxSd1UvZUgwQ2tDZ2hpSHlrMmEzMEhl?=
 =?utf-8?B?YlExRytUbkJ4MDIySURkRTlkYkhESElIWlZ3TVI5eDI3YUUrdlorQXZIWWdZ?=
 =?utf-8?B?UnRUd3Fxb0xQd3FYODFSZDEvbXlBZU1zOEJZWmY5bURCUk1UNVFzeE1WUk9D?=
 =?utf-8?B?dXJBNE8wc0RzN0Y0bktqTFpleGRWWjhxNjJnK2NiNHNvYk9LeTBVSEdqMitW?=
 =?utf-8?B?M0hQVUZURzVkd0FyRU1mTGpUMEhPd244ZVM4Q1gzVmIwdVh0K3BQdW5MZkYz?=
 =?utf-8?B?YXRJaHNGd242anZyYVJzdUtkclBnRWd4c0wvbWdRSXN6MFRrakNCS2pMTUor?=
 =?utf-8?B?WFJVakpJbU1mbDJpR2EwcmNqWDgxMi9wUzdhQnN4ZHVNRldlaXl3K3dNdGdN?=
 =?utf-8?B?bUhpT0I5ckNoOUxpOVJid05aaHg3ZFdXVTJHakRBY1lJNk1mcFZqd2w2UFJm?=
 =?utf-8?B?S1hNN2kyWTRjK3lvUlF4VXJRaGxOMllVUEV6UWNPYlBwZjZTbmJaa1FSeEdW?=
 =?utf-8?B?NDJqNDhjMUhXMzNSUlVqK1Vaa2tTMS9tUkJvU0pTWGFqYXgwbDE2cFB2UjZU?=
 =?utf-8?B?dkd6b2Nvb3Btam9OTGxmbTR6ODZVcFZjbjdseS84a09jOFBLTWluV3hPZ0tw?=
 =?utf-8?B?RDNJNWEwbStjZk9Nd3JKWHUvNnoveXNSMFdHb1lLMHRKcFB0Vk5XOG5ueU1I?=
 =?utf-8?B?bVNCMTFkVHB0SlZHQWE1bWtJMlJJTC83cFAzWXJVMEcrOXgwNXpQU1RBWDdK?=
 =?utf-8?B?VHBqWTJ5N1MvNVVCQXVHY0F5WWtyK2RHazU4ZEFML24zMVdaYXhxa3dFYzNB?=
 =?utf-8?B?UDBZM2IvSVNQQ1JNRlFKU0MwZ0wrM0NGL3huMHc2bnAwVkhsNDhENDVJOEhD?=
 =?utf-8?B?d0hVUDIrK3lWOGpIWGpRTjNMNGtZNzY1MU43MmMxS1dXRUREZGNSYTBPUzRR?=
 =?utf-8?B?M1J0UHY3NzNIcWh6cjd4aWREcHRFNzJnS2tTOFQ4a0V0ZjJ0Z0xzVC9waGRB?=
 =?utf-8?B?U0NkOVFZOHBPYWFrQ0NGbURMR2dnWDJPbkJGNVBvWXNIWkI4V050TmRoQUly?=
 =?utf-8?B?eGZGZWFUdFY1TlpTUDhDeENvdjNMZ2lDejgxeUg5STFCYzdmZHM4Q2NSTlpB?=
 =?utf-8?B?WWNlaHYxZFR6dWZCWTBQaWRwK0hpVjlUbzFMNG15M3BTMHlndXhvWmpvaVkx?=
 =?utf-8?B?V0xiUkg1L3NOUzEyNDhvZFBiMnd1YjZwSytCSmlQMURnMW92dUNYaTQ1Y3ZN?=
 =?utf-8?B?WFkwc2RWZGRVTGNZZXdCT1FpMHZLSlVaYUYwUTd4S24yZDlOT3lYa2M1Z2hl?=
 =?utf-8?B?ZitjRzhucWxpTDRLbHdIR28rVmhQdGNnWlF2dzArNjJGcmRVR1FwMmhaZ3ph?=
 =?utf-8?B?Y1h5N21WTE5Pa2wzbjc0cE5CdUZoNW1WdnZRa3oxVGZpdEsyeURoUm11Y3lz?=
 =?utf-8?B?R3BncGI1c1crRk1hdHI0TjNjWUNXcjlCS2x1TzNzNE5EMmg3YUVVbTEreFg4?=
 =?utf-8?B?eDBaSlRkLy9MeXdXY3F2T0Fua1Q5emIwcXpVMmtVQnBWR1d0WWkwb2VwZkpp?=
 =?utf-8?B?VzlOUDFZaVRtdTNwdDZhTVMvdFlCc0JuTWVLUFk2L1Ria2FHOFhiUU5kZFdn?=
 =?utf-8?B?N0phRDNKVXhuL2E3ZWNpZmxpOHhoY003YlJ5NjNxdDh4anVtcjRCUmZYeC9s?=
 =?utf-8?B?NTkxVUVDTHFMNUNLc2tNQUlabW5mejBrL1VMaE1ERmFkNG5uS2VhK0lLYzM1?=
 =?utf-8?B?UzNjMkdhMzBtZXExY3pRREpuZEEyeWNLWjY2R0NRTHkxYXp6eVF0K2ZJRFJz?=
 =?utf-8?B?cWF5SkZlQlBQMTFsQ2J0RnROenlScThYb2VOaFFFWit4eEpsa29taUhHeU4v?=
 =?utf-8?B?TUZlZ2Z5NU44UDlyVGFjSGtvSm1MY093U0J5TGUrVExmQjVOWGNsMGRHOWZ3?=
 =?utf-8?Q?R/pw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0R5cnlWbE1ML3RHRCt5aDFCRVYzSnVSTThndlYvOW9mZ2ZsMlkyL1lLRTd5?=
 =?utf-8?B?dkpvVkhPcE90UExGNTFqcDdzd1FyTncxeGtsZ3p2SlRtMk9mT0tSV1JNaE82?=
 =?utf-8?B?YXF6MEZtWHZXdlhTaFBvNjZaQVpqWk1zWUhEWDhHcysreUVvSUVhNzJMT240?=
 =?utf-8?B?ZVJkUi9BTTZWMFNRWGVwWjBWdTc1Q2NkSy9ka0RrbVgxenk5YkxBTW5LZnFn?=
 =?utf-8?B?Z3V3cWRBNWdPMVJWSEJFL09CdUplNUFPQ3BBN2U5TTJKNnVPeHFwVk1RdGo2?=
 =?utf-8?B?WVk0cTIxOHlWM3Rxc3lDelgwUXczS3ZSSnhvMjVqMXk3SEkzNGMyK0NsNDlE?=
 =?utf-8?B?TzZVYU9qaXNrT09CSzE2Rng3bDVTZDlka0lveHlLZjQ4ODFkSWlabXA4MUlE?=
 =?utf-8?B?WjlTVDREL1NMWmRiWXdSQU9NMXU2MXZybXJxcWhYQlVQY1FvVUJLN1FuZTFE?=
 =?utf-8?B?bGIyd1RMNXE2THVOaHN0bmVpWjZVcG5Vc0lvWGtmMldBSkRXbHRFUVdOb0Np?=
 =?utf-8?B?TUE0d1pFNVZra3FSUDBJbkdWc2EvRkNpN1BxQTJjZitZcXRzNFlwV1kvM3lU?=
 =?utf-8?B?a3JLQlo0Z1JBOWQ5dVo1bnVsYnRVTGpQTlJOMTk3d3haZ3NJTmxVMUJOT3N4?=
 =?utf-8?B?ckVtYklOV2U5SE1DQnhlbVRsaW5yeVJuZTdxK1hXZjUzdkJ3T0Z6OWpOcDZP?=
 =?utf-8?B?VjVnbjZrWVQ4NUNOK0M2ZGVHNHp0TVJZOFl5U2lodVc0ZjJzblN1bVFaNmtw?=
 =?utf-8?B?S2pyeUhucTlLelgvNzVTQVlUaEQ5RDRHREdsTURTS0FoRGZoeWhId0V1c1ox?=
 =?utf-8?B?cVpMZnkzZG5FTmlRVk9PaENQeGZLTXJSZHYzMnlOcUd5MGxhUnVpK1hZYW1E?=
 =?utf-8?B?OGFmZG5IdTJDNDZGNXoybzc1ZG9FSEI3ck5KWGgvd2JqRE1MSjRmdHBBcGVk?=
 =?utf-8?B?NXZ0L01nZ0c3b0wvSDRYcDg1RFBxVHdNbVd0Qno1UmIzdEExeWtkQWNmVTY5?=
 =?utf-8?B?ZlMvQnJTYSsyTGdGVUV5WExURzJZbWtVc0lMU21SUll2MlkvdW1IeXpDVHhr?=
 =?utf-8?B?dkNiUTNJWTVMSHZaMHpTSHRuTjlzRWxsLytzVUg1dko3YTBMUkJISkJ5ME1y?=
 =?utf-8?B?MUdHRzN2VDU0bGVKOVE4Q3pTTjQvcXpWR1d4OWNlWHZwajBWQVMzK1lRZkhJ?=
 =?utf-8?B?WnNYSUFPVG1jR1hhMXplVWxFRi9WNzVadFJwN1NPSmRMQXBkTTFNVU80Mmxp?=
 =?utf-8?B?RW8wVmpmczcwbW8rVHlhZnhYZDFEaVlwU3E4SjdQUGIyQzBuYnpJcThUV0Uy?=
 =?utf-8?B?djlzUXJua0RwT0tzTVlFdW4xODNwdXI1R3JaU25hdU5JUUxjdFBma2g5Rjk3?=
 =?utf-8?B?Z09FV1c5ZFRDaDlOT2hpV3VsRko0VzNNSUNGSGE2Qjk2Wjl6U0N3UmF0NzQ4?=
 =?utf-8?B?U0JPUDlZUHFha0ZKVXgydDV0MU1rMkFVSXoyZmxNbDlLT05oSGFqeHcra0FQ?=
 =?utf-8?B?LzF2Z2RxRWVhUTk2WnQ4ZURWZVVFV0RLYWNZWkZVekgwNURObEhUeVZydFpo?=
 =?utf-8?B?K2t0MXF2WjZBTHRkRCtGcFA2Qnc4VXdVRmQ2aHJ6alU5RE1wRFdNaHB6SEhZ?=
 =?utf-8?B?Ynd5U25QK1ZwdXVOT2wrNXBVUWwzd2ZabWtueE0yR1oxeTdYbnQrdkNRMGY5?=
 =?utf-8?B?VDVxM2xYVlQycktOdkQ4UHBIK0c5dU1xZStzVWgrQlJCZWZJSWVqUC8rKzhX?=
 =?utf-8?B?TEN1U3QwSmg3N2M0Nk9XQkhmTlh4ZFdhcUs5ZzBlSjZtaHZMQzhFQ2R6bUd5?=
 =?utf-8?B?cHhuU3VaZUNCNEs0NERzbzNnL0RrTjFQUDRSTzhKQkF6YUZTS0o1akZUOXJS?=
 =?utf-8?B?bHc2YWgzN0wxazh5ZUxwcy9UL2hEK0xJWnZJQXRta25JeDg5SzZwMmNpUThV?=
 =?utf-8?B?NE1FZ29ydzljSUkrL2JQWDdCSVR5MzlJbVJuMXdxcDlZT29OZDY1amtqbk5V?=
 =?utf-8?B?WlZwZWhDTzRXeWFLVkhibE9FQnRudjJFb1hQaTJteW9hc3pXUUF5M3AzSko5?=
 =?utf-8?B?Rk4wUmlyQmxaUzdKbE04dnVsTEN5ejZidDMwS1lPeS9iRVlPcm04OTErNFgy?=
 =?utf-8?B?QWgwcE1BNlpVNFJGd3YrU0hrM1lMUHFndm8vZmtJOHJmSnpyT0VFNDBLaStN?=
 =?utf-8?B?Q0VXT2tlVkUvZEt5OHpPT3pQUldVRVVHU1JYRUFVbGFTdzE3KzQwdTJ3SUxT?=
 =?utf-8?B?QmlFTXdGdzJBblF4MGxzRXNmdnA3OFVPTEhqV2thK0IzVU5VK2VaaWllRm0y?=
 =?utf-8?B?Y21XeXJpbFVyTVVCZU1iNmpnemFNbVljYmhVQmMxVDhCdFJUbzJJRFlqSFY2?=
 =?utf-8?Q?RG9eWijcoxz8WRh0=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b057d869-c017-4190-3c75-08de6b0f90bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 14:52:53.1967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHhhXZeEc2HY7WH1IdSZ3JWNil9fO5SasXoQTSXWpoEOSJ0BLUEmnIMUcUcun/TB32K6FuoYVW0Q3QRF19QUQvly8nj32OQ1jJBPgS59l/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB10983
X-Proofpoint-ORIG-GUID: 5w1XpSX8zn_qbgosCcFg2zfUJKEH4952
X-Proofpoint-GUID: 5w1XpSX8zn_qbgosCcFg2zfUJKEH4952
X-Authority-Analysis: v=2.4 cv=PaLyRyhd c=1 sm=1 tr=0 ts=698f3ac6 cx=c_pps
 a=PUkDgjY5UzxrOFLFu0zltw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=m0yvbvx9hJbQ1JKojzoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNSBTYWx0ZWRfXweI0nnO7fSFM
 TLkVnj3gPXrANd8R3nzYQi+nqNcrnqqhAsL88y6uWrouMTIXF9RYlXFWw4hq/EH3F2n3aVV8EDc
 Gaq689LZ7jb3nA3NgQdkYwIZ+sEPZuiT7FyD1nFyn6BYeKbr8m5UL24MCR48GXiJsj6cSHOoERI
 t1vnYcV1WTeCxR6m1tI4ddRttODxYZB5DJ6zELanl5oSlHk/nR75P2XrzfsXYRQGBnxmAcbb2MD
 6mIz4ngT/kaM/1kj60KxQnHhQsai84/IVodjUjKKu/C1H53+g71ShW+2LHc0egjoSQXoGPfi5Ce
 sK1Su8EofSC2yHHs9YprOEu+j6Jd1WLQMr/K461l8FTPijLmnl+V2xq3vZB8ajFwOrwuK6aDvrb
 survOr2ctiolaONf4dnGBCwfJb92W3Rs3MXkTwCOZZVFVEX7VvUy/pcIcS6K02kc4had+eFkXzN
 Sx8e0lRuqCLV4PZszNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Replace the custom audio logging infrastructure with standard QEMU
> error reporting and tracing.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/ossaudio.c   | 176 ++++++++++++++++++++-------------------------
>   audio/trace-events |   5 ++
>   2 files changed, 81 insertions(+), 100 deletions(-)
> 
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index 95b7963ed0c..8388f81343b 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -31,11 +31,10 @@
>   #include "qemu/host-utils.h"
>   #include "qapi/error.h"
>   #include "qemu/audio.h"
> +#include "qemu/error-report.h"
>   #include "qom/object.h"
> -#include "trace.h"
> -
> -#define AUDIO_CAP "oss"
>   #include "audio_int.h"
> +#include "trace.h"
>   
>   #define TYPE_AUDIO_OSS "audio-oss"
>   OBJECT_DECLARE_SIMPLE_TYPE(AudioOss, AUDIO_OSS)
> @@ -76,43 +75,40 @@ struct oss_params {
>       int fragsize;
>   };
>   
> -static void G_GNUC_PRINTF (2, 3) oss_logerr (int err, const char *fmt, ...)
> +static void G_GNUC_PRINTF(2, 3) oss_logerr(int err, const char *fmt, ...)
>   {
>       va_list ap;
>   
> -    va_start (ap, fmt);
> -    AUD_vlog (AUDIO_CAP, fmt, ap);
> -    va_end (ap);
> +    error_printf("oss: ");
> +    va_start(ap, fmt);
> +    error_vprintf(fmt, ap);
> +    va_end(ap);
>   
> -    AUD_log (AUDIO_CAP, "Reason: %s\n", strerror (err));
> +    error_printf(" Reason: %s\n", strerror(err));
>   }
>   
> -static void G_GNUC_PRINTF (3, 4) oss_logerr2 (
> -    int err,
> -    const char *typ,
> -    const char *fmt,
> -    ...
> -    )
> +static void G_GNUC_PRINTF(3, 4) oss_logerr2(int err, const char *typ,
> +                                            const char *fmt, ...)
>   {
>       va_list ap;
>   
> -    AUD_log (AUDIO_CAP, "Could not initialize %s\n", typ);
> +    error_printf("oss: Could not initialize %s: ", typ);
>   
> -    va_start (ap, fmt);
> -    AUD_vlog (AUDIO_CAP, fmt, ap);
> -    va_end (ap);
> +    va_start(ap, fmt);
> +    error_vprintf(fmt, ap);
> +    va_end(ap);
>   
> -    AUD_log (AUDIO_CAP, "Reason: %s\n", strerror (err));
> +    error_printf(" Reason: %s\n", strerror(err));
>   }
>   
> -static void oss_anal_close (int *fdp)
> +static void oss_anal_close(int *fdp)
>   {
>       int err;
>   
> -    qemu_set_fd_handler (*fdp, NULL, NULL, NULL);
> -    err = close (*fdp);
> +    qemu_set_fd_handler(*fdp, NULL, NULL, NULL);
> +    err = close(*fdp);
>       if (err) {
> -        oss_logerr (errno, "Failed to close file(fd=%d)\n", *fdp);
> +        oss_logerr(errno, "Failed to close file(fd=%d)", *fdp);
>       }
>       *fdp = -1;
>   }
> @@ -159,10 +155,7 @@ static int aud_to_ossfmt(AudioFormat fmt, bool big_endian)
>           return big_endian ? AFMT_U16_BE : AFMT_U16_LE;
>   
>       default:
> -        dolog ("Internal logic error: Bad audio format %d\n", fmt);
> -#ifdef DEBUG_AUDIO
> -        abort ();
> -#endif
> +        error_report("oss: Internal logic error: Bad audio format %d", fmt);
>           return AFMT_U8;
>       }
>   }
> @@ -201,27 +194,13 @@ static int oss_to_audfmt (int ossfmt, AudioFormat *fmt, int *endianness)
>           break;
>   
>       default:
> -        dolog ("Unrecognized audio format %d\n", ossfmt);
> +        error_report("oss: Unrecognized audio format %d", ossfmt);
>           return -1;
>       }
>   
>       return 0;
>   }
>   
> -#if defined DEBUG_MISMATCHES || defined DEBUG
> -static void oss_dump_info (struct oss_params *req, struct oss_params *obt)
> -{
> -    dolog ("parameter | requested value | obtained value\n");
> -    dolog ("format    |      %10d |     %10d\n", req->fmt, obt->fmt);
> -    dolog ("channels  |      %10d |     %10d\n",
> -           req->nchannels, obt->nchannels);
> -    dolog ("frequency |      %10d |     %10d\n", req->freq, obt->freq);
> -    dolog ("nfrags    |      %10d |     %10d\n", req->nfrags, obt->nfrags);
> -    dolog ("fragsize  |      %10d |     %10d\n",
> -           req->fragsize, obt->fragsize);
> -}
> -#endif
> -
>   #ifdef USE_DSP_POLICY
>   static int oss_get_version (int fd, int *version, const char *typ)
>   {
> @@ -240,7 +219,7 @@ static int oss_get_version (int fd, int *version, const char *typ)
>               return 0;
>           }
>   #endif
> -        oss_logerr2 (errno, typ, "Failed to get OSS version\n");
> +        oss_logerr2(errno, typ, "Failed to get OSS version");
>           return -1;
>       }
>       return 0;
> @@ -269,7 +248,7 @@ static int oss_open(int in, struct oss_params *req, audsettings *as,
>   
>       fd = open (dspname, oflags | O_NONBLOCK);
>       if (-1 == fd) {
> -        oss_logerr2 (errno, typ, "Failed to open `%s'\n", dspname);
> +        oss_logerr2(errno, typ, "Failed to open '%s'", dspname);
>           return -1;
>       }
>   
> @@ -281,23 +260,23 @@ static int oss_open(int in, struct oss_params *req, audsettings *as,
>           qapi_AudiodevOssPerDirectionOptions_base(opdo), as, 23220);
>   
>       if (ioctl (fd, SNDCTL_DSP_SAMPLESIZE, &fmt)) {
> -        oss_logerr2 (errno, typ, "Failed to set sample size %d\n", req->fmt);
> +        oss_logerr2(errno, typ, "Failed to set sample size %d", req->fmt);
>           goto err;
>       }
>   
>       if (ioctl (fd, SNDCTL_DSP_CHANNELS, &nchannels)) {
> -        oss_logerr2 (errno, typ, "Failed to set number of channels %d\n",
> -                     req->nchannels);
> +        oss_logerr2(errno, typ, "Failed to set number of channels %d",
> +                    req->nchannels);
>           goto err;
>       }
>   
>       if (ioctl (fd, SNDCTL_DSP_SPEED, &freq)) {
> -        oss_logerr2 (errno, typ, "Failed to set frequency %d\n", req->freq);
> +        oss_logerr2(errno, typ, "Failed to set frequency %d", req->freq);
>           goto err;
>       }
>   
>       if (ioctl (fd, SNDCTL_DSP_NONBLOCK, NULL)) {
> -        oss_logerr2 (errno, typ, "Failed to set non-blocking mode\n");
> +        oss_logerr2(errno, typ, "Failed to set non-blocking mode");
>           goto err;
>       }
>   
> @@ -311,9 +290,9 @@ static int oss_open(int in, struct oss_params *req, audsettings *as,
>               if (version >= 0x040000) {
>                   int policy2 = policy;
>                   if (ioctl(fd, SNDCTL_DSP_POLICY, &policy2)) {
> -                    oss_logerr2 (errno, typ,
> -                                 "Failed to set timing policy to %d\n",
> -                                 policy);
> +                    oss_logerr2(errno, typ,
> +                                "Failed to set timing policy to %d",
> +                                policy);
>                       goto err;
>                   }
>                   setfragment = 0;
> @@ -325,20 +304,20 @@ static int oss_open(int in, struct oss_params *req, audsettings *as,
>       if (setfragment) {
>           int mmmmssss = (req->nfrags << 16) | ctz32 (req->fragsize);
>           if (ioctl (fd, SNDCTL_DSP_SETFRAGMENT, &mmmmssss)) {
> -            oss_logerr2 (errno, typ, "Failed to set buffer length (%d, %d)\n",
> -                         req->nfrags, req->fragsize);
> +            oss_logerr2(errno, typ, "Failed to set buffer length (%d, %d)",
> +                        req->nfrags, req->fragsize);
>               goto err;
>           }
>       }
>   
>       if (ioctl (fd, in ? SNDCTL_DSP_GETISPACE : SNDCTL_DSP_GETOSPACE, &abinfo)) {
> -        oss_logerr2 (errno, typ, "Failed to get buffer length\n");
> +        oss_logerr2(errno, typ, "Failed to get buffer length");
>           goto err;
>       }
>   
>       if (!abinfo.fragstotal || !abinfo.fragsize) {
> -        AUD_log (AUDIO_CAP, "Returned bogus buffer information(%d, %d) for %s\n",
> -                 abinfo.fragstotal, abinfo.fragsize, typ);
> +        error_report("oss: Returned bogus buffer information(%d, %d) for %s",
> +                     abinfo.fragstotal, abinfo.fragsize, typ);
>           goto err;
>       }
>   
> @@ -349,20 +328,13 @@ static int oss_open(int in, struct oss_params *req, audsettings *as,
>       obt->fragsize = abinfo.fragsize;
>       *pfd = fd;
>   
> -#ifdef DEBUG_MISMATCHES
> -    if ((req->fmt != obt->fmt) ||
> -        (req->nchannels != obt->nchannels) ||
> -        (req->freq != obt->freq) ||
> -        (req->fragsize != obt->fragsize) ||
> -        (req->nfrags != obt->nfrags)) {
> -        dolog ("Audio parameters mismatch\n");
> -        oss_dump_info (req, obt);
> -    }
> -#endif

It looks like we're dropping the mismatch detection here: do we care 
enough about explicitly flagging mismatches, or is the standard 
trace-event below good enough? For the latter, a note in the commit 
message would be sufficient.

> +    trace_oss_out_params(
> +        req->fmt, obt->fmt,
> +        req->nchannels, obt->nchannels,
> +        req->freq, obt->freq,
> +        req->nfrags, obt->nfrags,
> +        req->fragsize, obt->fragsize);
>   
> -#ifdef DEBUG
> -    oss_dump_info (req, obt);
> -#endif
>       return 0;
>   
>    err:
> @@ -378,7 +350,7 @@ static size_t oss_get_available_bytes(OSSVoiceOut *oss)
>   
>       err = ioctl(oss->fd, SNDCTL_DSP_GETOPTR, &cntinfo);
>       if (err < 0) {
> -        oss_logerr(errno, "SNDCTL_DSP_GETOPTR failed\n");
> +        oss_logerr(errno, "SNDCTL_DSP_GETOPTR failed");
>           return 0;
>       }
>   
> @@ -459,8 +431,7 @@ static size_t oss_write(HWVoiceOut *hw, void *buf, size_t len)
>           bytes_written = write(oss->fd, pcm, len);
>           if (bytes_written < 0) {
>               if (errno != EAGAIN) {
> -                oss_logerr(errno, "failed to write %zu bytes\n",
> -                           len);
> +                oss_logerr(errno, "failed to write %zu bytes", len);
>               }
>               return pos;
>           }
> @@ -474,18 +445,18 @@ static size_t oss_write(HWVoiceOut *hw, void *buf, size_t len)
>       return pos;
>   }
>   
> -static void oss_fini_out (HWVoiceOut *hw)
> +static void oss_fini_out(HWVoiceOut *hw)
>   {
>       int err;
> -    OSSVoiceOut *oss = (OSSVoiceOut *) hw;
> +    OSSVoiceOut *oss = (OSSVoiceOut *)hw;
>   
> -    ldebug ("oss_fini\n");
> -    oss_anal_close (&oss->fd);
> +    trace_oss_fini_out();
> +    oss_anal_close(&oss->fd);
>   
>       if (oss->mmapped && hw->buf_emul) {
>           err = munmap(hw->buf_emul, hw->size_emul);
>           if (err) {
> -            oss_logerr(errno, "Failed to unmap buffer %p, size %zu\n",
> +            oss_logerr(errno, "Failed to unmap buffer %p, size %zu",
>                          hw->buf_emul, hw->size_emul);
>           }
>           hw->buf_emul = NULL;
> @@ -526,8 +497,8 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as)
>       oss->fragsize = obt.fragsize;
>   
>       if (obt.nfrags * obt.fragsize % hw->info.bytes_per_frame) {
> -        dolog ("warning: Misaligned DAC buffer, size %d, alignment %d\n",
> -               obt.nfrags * obt.fragsize, hw->info.bytes_per_frame);
> +        warn_report("oss: Misaligned DAC buffer, size %d, alignment %d",
> +                    obt.nfrags * obt.fragsize, hw->info.bytes_per_frame);
>       }
>   
>       hw->samples = (obt.nfrags * obt.fragsize) / hw->info.bytes_per_frame;
> @@ -544,20 +515,16 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as)
>               0
>               );
>           if (hw->buf_emul == MAP_FAILED) {
> -            oss_logerr(errno, "Failed to map %zu bytes of DAC\n",
> -                       hw->size_emul);
> +            oss_logerr(errno, "Failed to map %zu bytes of DAC", hw->size_emul);
>               hw->buf_emul = NULL;
>           } else {
>               int trig = 0;
>               if (ioctl (fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
> -                oss_logerr (errno, "SNDCTL_DSP_SETTRIGGER 0 failed\n");
> +                oss_logerr(errno, "SNDCTL_DSP_SETTRIGGER 0 failed");
>               } else {
>                   trig = PCM_ENABLE_OUTPUT;
> -                if (ioctl (fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
> -                    oss_logerr (
> -                        errno,
> -                        "SNDCTL_DSP_SETTRIGGER PCM_ENABLE_OUTPUT failed\n"
> -                        );
> +                if (ioctl(fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
> +                    oss_logerr(errno, "SNDCTL_DSP_SETTRIGGER PCM_ENABLE_OUTPUT failed");
>                   } else {
>                       oss->mmapped = 1;
>                   }
> @@ -566,7 +533,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as)
>               if (!oss->mmapped) {
>                   err = munmap(hw->buf_emul, hw->size_emul);
>                   if (err) {
> -                    oss_logerr(errno, "Failed to unmap buffer %p size %zu\n",
> +                    oss_logerr(errno, "Failed to unmap buffer %p size %zu",
>                                  hw->buf_emul, hw->size_emul);
>                   }
>                   hw->buf_emul = NULL;
> @@ -582,13 +549,14 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as)
>   static void oss_enable_out(HWVoiceOut *hw, bool enable)
>   {
>       int trig;
> -    OSSVoiceOut *oss = (OSSVoiceOut *) hw;
> +    OSSVoiceOut *oss = (OSSVoiceOut *)hw;
>       AudiodevOssPerDirectionOptions *opdo = oss->dev->u.oss.out;
>   
> +    trace_oss_enable_out(enable);
> +
>       if (enable) {
>           hw->poll_mode = opdo->try_poll;
>   
> -        ldebug("enabling voice\n");
>           if (hw->poll_mode) {
>               oss_poll_out(hw);
>           }
> @@ -601,12 +569,12 @@ static void oss_enable_out(HWVoiceOut *hw, bool enable)
>           trig = PCM_ENABLE_OUTPUT;
>           if (ioctl(oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
>               oss_logerr(errno,
> -                       "SNDCTL_DSP_SETTRIGGER PCM_ENABLE_OUTPUT failed\n");
> +                       "SNDCTL_DSP_SETTRIGGER PCM_ENABLE_OUTPUT failed");
>               return;
>           }
>       } else {
>           if (hw->poll_mode) {
> -            qemu_set_fd_handler (oss->fd, NULL, NULL, NULL);
> +            qemu_set_fd_handler(oss->fd, NULL, NULL, NULL);
>               hw->poll_mode = 0;
>           }
>   
> @@ -614,10 +582,9 @@ static void oss_enable_out(HWVoiceOut *hw, bool enable)
>               return;
>           }
>   
> -        ldebug ("disabling voice\n");
>           trig = 0;
> -        if (ioctl (oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
> -            oss_logerr (errno, "SNDCTL_DSP_SETTRIGGER 0 failed\n");
> +        if (ioctl(oss->fd, SNDCTL_DSP_SETTRIGGER, &trig) < 0) {
> +            oss_logerr(errno, "SNDCTL_DSP_SETTRIGGER 0 failed");
>               return;
>           }
>       }
> @@ -654,9 +621,16 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as)
>       oss->nfrags = obt.nfrags;
>       oss->fragsize = obt.fragsize;
>   
> +    trace_oss_in_params(
> +        req.fmt, obt.fmt,
> +        req.nchannels, obt.nchannels,
> +        req.freq, obt.freq,
> +        req.nfrags, obt.nfrags,
> +        req.fragsize, obt.fragsize);
> +
>       if (obt.nfrags * obt.fragsize % hw->info.bytes_per_frame) {
> -        dolog ("warning: Misaligned ADC buffer, size %d, alignment %d\n",
> -               obt.nfrags * obt.fragsize, hw->info.bytes_per_frame);
> +        warn_report("oss: Misaligned ADC buffer, size %d, alignment %d",
> +                    obt.nfrags * obt.fragsize, hw->info.bytes_per_frame);
>       }
>   
>       hw->samples = (obt.nfrags * obt.fragsize) / hw->info.bytes_per_frame;
> @@ -690,7 +664,7 @@ static size_t oss_read(HWVoiceIn *hw, void *buf, size_t len)
>               case EAGAIN:
>                   break;
>               default:
> -                oss_logerr(errno, "Failed to read %zu bytes of audio (to %p)\n",
> +                oss_logerr(errno, "Failed to read %zu bytes of audio (to %p)",
>                              len, dst);
>                   break;
>               }
> @@ -706,9 +680,11 @@ static size_t oss_read(HWVoiceIn *hw, void *buf, size_t len)
>   
>   static void oss_enable_in(HWVoiceIn *hw, bool enable)
>   {
> -    OSSVoiceIn *oss = (OSSVoiceIn *) hw;
> +    OSSVoiceIn *oss = (OSSVoiceIn *)hw;
>       AudiodevOssPerDirectionOptions *opdo = oss->dev->u.oss.out;
>   
> +    trace_oss_enable_in(enable);
> +
>       if (enable) {
>           hw->poll_mode = opdo->try_poll;
>   
> diff --git a/audio/trace-events b/audio/trace-events
> index 79744456cec..f33be2dd8e3 100644
> --- a/audio/trace-events
> +++ b/audio/trace-events
> @@ -17,6 +17,11 @@ alsa_enable_in(bool enable) "enable=%d"
>   
>   # ossaudio.c
>   oss_version(int version) "OSS version = 0x%x"
> +oss_out_params(int req_fmt, int obt_fmt, int req_channels, int obt_channels, int req_freq, int obt_freq, int req_nfrags, int obt_nfrags, int req_fragsize, int obt_fragsize) "fmt=%d->%d, channels %d->%d, freq=%d->%d, nfrags=%d->%d, fragsize=%d->%d"
> +oss_in_params(int req_fmt, int obt_fmt, int req_channels, int obt_channels, int req_freq, int obt_freq, int req_nfrags, int obt_nfrags, int req_fragsize, int obt_fragsize) "fmt=%d->%d, channels %d->%d, freq=%d->%d, nfrags=%d->%d, fragsize=%d->%d"
> +oss_fini_out(void) ""
> +oss_enable_out(bool enable) "enable=%d"
> +oss_enable_in(bool enable) "enable=%d"
>   
>   # dbusaudio.c
>   dbus_audio_register(const char *s, const char *dir) "sender = %s, dir = %s"

Otherwise:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


