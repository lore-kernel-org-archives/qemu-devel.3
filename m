Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58223EDF173
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 14:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqucA-0002aK-Aq; Fri, 13 Feb 2026 09:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vquc9-0002aC-7v
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:57:49 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vquc7-0002qe-0P
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 09:57:48 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D9DN3o3534674; Fri, 13 Feb 2026 06:57:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=h3IxkbK6LqQqU7b3zy40kAxOeqOs3/Kqa9NkcKxnY
 wg=; b=aLyAw0FZppsotEyA+ILR1TNtk+mziZWvHJtMREcFYMirpxNWCvAwvYCj4
 2//j7fkNjSWfRF7yVuEOmwZ3nTv0GAWWU6L0xhZZgpEk1SOSX5I2Vt3NBRaE2KA+
 wm4G6I2U9rRMK9zv8bnygmwKMoPOahMY/WM+JIh8CrYEZeTHD6xVAEjeyPiWnGcq
 YGfdkbO73EMDy+oLnazPK+eqq5CIfMl63JPPmWvLCOCRloSJ5wfU/rj9y/gwVXzw
 N1LakNUR79yvfQWIVwYwW7i76MyVBXAF6n3ZuP9EyWgtoaIcn2P3pZSR+P/WchHd
 6N4teaTxFngg9Cx4WMnRzSZw3OcFQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021119.outbound.protection.outlook.com
 [40.93.194.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8q4d7msa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 06:57:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3zZ6yK9fIkEMObkUWAhNoRbv5FZnN8jTuGUY2yeQJkaysG2gb9BdRQKaMd85dvDgEDXXIXfpJ2OJjOYN5wvo7b9OMo8d/UINI4S+ZRITZLtVGkhH44SpENBb9BYZU2wi6Nyq+RspTVrpmVAs2hjXMf70rNnwcClIKLQ1+eCGz7K4Z8x6uWsOf2ncEGQLCMBMf83RaZsP40WbP3L4EZ7LoEgHYiztu0ppBd+Q9FsOEpNFy27c0GOWjozDOkWazKMDgVOFfWh/T8ajMCnZZRkcQ5rIe79BQxx3FWbna0+VSD1qtWW8XaBlgXSSEbQ6+eHn4+MUcGmyJt5AVcb4sl1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3IxkbK6LqQqU7b3zy40kAxOeqOs3/Kqa9NkcKxnYwg=;
 b=HitnViAx9hmmXhFtY0dFEyR1Mvm/lRRomCZIUsPOq6tLjV4PD2ZuZCRG2+MKGbN3Batqklj5QzrZH017e4/J/XrHix5mO/PwzPNNF8K6nhPkmz5waEMcjSzChIH0y4wdTTKq+EVP5HG/INqnqmhd13qAD21KHvZ/rinQr0IPG2k1hv5M1dplCdj5cReqeie9QD0TbnKZE5NO7iPlU7L694bztF3L77HfrsHilKMe/NOFEX8xOyMeZtNYrVlbP2yCUVvRm+pp2sT1PQK00rrtcjyeHDtMPPlOF/ZPu4vEu9ZwZAMbEgeBzxtPUij+DH4wVdY7d3NLnbpVQIAJxr9ttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3IxkbK6LqQqU7b3zy40kAxOeqOs3/Kqa9NkcKxnYwg=;
 b=b0IfkceGQFo6B+THr5S1gJNfEdyjHA90Rg5rci2LcGLHvEEojpD/pda1nZDdMV/PE7kcbKQy1wcUhq8veCmerZnyHjhVgpK7XUVthy+6NjU82QoEYxBi92kHqiwOl9sr4RB5gwG5AH5Sewp5uczREXkGw3RE36y2VuMolJjqjhe0OcgDay97Y0DzmVEE4fkF6UqOBdp6BS0ga2GMZdb2Gla1rYyZf0JM3r0QCjgsMKVzsxy0rRGcU/HcNTbFoElSNcxltIyhmtMM8SgbyOcAxH/Cqxta8GBsaRhKc3V2ek11BcrrtlPuKRd8budeZfAZzkHy5PgGvjXliFeFkD1i8g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH7PR02MB9340.namprd02.prod.outlook.com (2603:10b6:510:271::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 14:57:41 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 14:57:41 +0000
Message-ID: <3fe6bb02-096e-405f-9a84-c42ffafd9927@nutanix.com>
Date: Fri, 13 Feb 2026 14:57:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/43] audio/sdl: replace custom logging with error_report
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-28-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-28-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH3P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH7PR02MB9340:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b5239b-1690-4f97-7664-08de6b103cd1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0pZL0czK21JaXBuSWl6NzVBSnZFSUdHRzloa1RZbXNRc0pDQjRtR1ltdFg4?=
 =?utf-8?B?VjZQakpzanhDNlplbjZkR0MyMGwyZVBUc1UyZjNRYWZjR0lNRzFWbFJNRUpG?=
 =?utf-8?B?R1VrekRBcHY5dzJpWjZCb3B0UUR4UXpPWTRWRS9QdGRiS1A0a055NmhuYkFK?=
 =?utf-8?B?Zk95WFpuQm1sdWhPREl5bGorZWRpQVdzQlgrNVlCTmN0RThFN25RTkdFVUU5?=
 =?utf-8?B?Vk9KK05oTFk3bEVFVlcyWldVclA1UnNodXJRa2pCK3dpK0dUY1FlUi8xYkNt?=
 =?utf-8?B?a0tNY3NHTldublQvRzkvUTl2WTRBSnZxT0kwS243VVBwUWNreVRsSllLV2hT?=
 =?utf-8?B?Ykt6MzR1ZVljelk2Rk5YYmg4a2t6aU1xRlNRK3NVMmV0b05CaG9hcXZlTUs1?=
 =?utf-8?B?Nm1JU0tqc3ZKSnh1ejE0VHY1emtYY1hKL1FQTUNXTjNVQU14RGNXOTg3MlNN?=
 =?utf-8?B?S3BROVhLZkt5VFdub3JhWndhZEd6dXRwOTZKQTYxVDhlSFNPYW00cjlSc2dh?=
 =?utf-8?B?ZTVoOW9DUSttQnhxTnJQTFA5bTkzWktFNGJ6eVB2SWYvWDhxSHNncTNBeHRz?=
 =?utf-8?B?Zkg2OUpCNFZ4OStjVU9PSG5QbEUxMnJhVDJkTmtEaUIyS1ovL3hBMjFPWlN2?=
 =?utf-8?B?UXFLNFlUd0ZTYnJCYklmK0JCNW1TcDJ4a1c2TkIvcUxMSm9QVVQzejByTmlJ?=
 =?utf-8?B?NWphc3NWYXVXd1F3bWJSQURtc1NObm83VkxCeW1LRmZMNkIvR3Q2ajkyS3dv?=
 =?utf-8?B?WXVyTDNGY2hQU09aVUdpOE5uZDRFU3huZjFvOU16RGV2S3JYWHFTQklGWGFh?=
 =?utf-8?B?Z2xpZnFzbnpYNktOVmlHZUUzdHorbmVHVitQbG9ybHVPVGFJTmtvZ2xPUENh?=
 =?utf-8?B?Nm93NkJpMnkwZzlOUElqeGtHY1MzRkQxL2FuKysxUURpcW9mK2M5ZDdULzdy?=
 =?utf-8?B?eUppVVVhSVZkV2xrblkrQ2FFS3BrVWJKWU5QQWN1eGJDWEUvRWlQOTE5TWFX?=
 =?utf-8?B?YzRlckN0MGhQdEtManFXNlVHWXRGeXlLMUJCbWdtbjR2ang4aWtRM3VaM2lI?=
 =?utf-8?B?WUdzdHc0SmpyWHRWRXRNQkM2WUNtMUMyRyswZ2Y4V09mVVl2bnRaZmNaVlY5?=
 =?utf-8?B?ZTFTN2FLaTZwcmhSSS9TbzNaVGd1bGlYTm5MenBqVVVSdUNGRmYvVFFndU1O?=
 =?utf-8?B?b3hRdW10dGdCT2pHKzd0Z2plMUQ3OUtpdXBlV1FVNzh0dHppd25ocEpaQWdX?=
 =?utf-8?B?Ym1YUFdFSkdoTTZuUFlIOXhBSUFvbVY4ZXVBaHhLVjRKWlBJUnJWc0NBS0Ji?=
 =?utf-8?B?ZTdQMzZMcEhqdldveFJyaXRnbjVsNmJTdXFPMFFGRGlEbGpnTWE1S3NSK29L?=
 =?utf-8?B?OS9sbjlyUlR5Vjh0MUZET2htdzFwdVY4ZmZLeTFscVZlcTg4YlA0bURRdWRR?=
 =?utf-8?B?cWpXRDZ0RWVyOXJtbzJmT0pUWVhWSUtWb2JWVE8ycXpETFhLNENvWHNyR0Za?=
 =?utf-8?B?VjdRY3NLbmxCcFhrRUQyRFMwcDFDbXA3Q3VzSzZwbG03dy9RK1U5OUFPUERv?=
 =?utf-8?B?SE9HSG9nSjA5cmowUmJId1JFQUdLNk8xRlFCQ1U4LzhvZGFKL3lPeVNiK3VM?=
 =?utf-8?B?OTNmVVlZQ0VYeitiUTJhRGVQMndPWStsRVRVeTJRVHJkaWVxcytwVS80UTV1?=
 =?utf-8?B?SWZleCtsWUhNc0lzQlN2TDJ4ZGRpSlJrbmU4UU9jU0FtRm1QeWtxTkxzdzJU?=
 =?utf-8?B?bThTZDZpbThxRzNxVGN4K2FUeFVjbmprVjFSaW84eGNnZU93YVo2cnVMU3Bm?=
 =?utf-8?B?SWhQK2UvU0tlTFAxeXUzYUhtT0tWUGxTdTVqR0Z4VllWaDBqZTc3MUpxQ2k4?=
 =?utf-8?B?QVJYRkIxSy9BUVBFQi9YUEdVSks1YXBWZis0bmFHcjZMRlMydlAwUW5xOHJy?=
 =?utf-8?B?OElZSmJEK2ZNKzZ5VHF3dVgwWEFrOWY1Yyt0dnJBWFIrWW5TM1piajZYT2l4?=
 =?utf-8?B?dGE0UmlJN04vS0JGR1Zjd1RVTXRRZmtHcm1VWmpOcmJRNlBsRHhWYkRhRHpr?=
 =?utf-8?B?Snp3UWNORW5IWVVXZWszQzVYbHRmWnF4NXRlQ1p3WU1NbkxqVzlIaFU0S1lo?=
 =?utf-8?Q?DmNo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXRHekJmcWNxdmxOcER3b3R3U292WnNxVlZ2L3hTZW9oKzRKTkFUZDdnTU9K?=
 =?utf-8?B?dEZXOUxDaFhaQklTV29QVE0vMWxKdFlpejJSdXlkaGhsN2ZZdTRmRWRFdXll?=
 =?utf-8?B?SDB1RUJ1a1RzM2JpZTEzZUdVL3FBNTR4aEhtRkpLZk5teU9KemU5ZHNFTG52?=
 =?utf-8?B?aGl4YkFZSnc2M1REZmhoL29Tb081UHhJSlJZUXRrbGRySERpLytxaUJiMk1m?=
 =?utf-8?B?NHFUZUNLSGZSS2FmUmJva0huMzN0Z2VBSGVoUm5JUGlXbFUxRklLVVRtTXNu?=
 =?utf-8?B?d3BwSFkyZDVmMjdQRllkL2FHaXk4Y3VZVW1uRTU1cVg5QzN0Y1IxK0VCTEhZ?=
 =?utf-8?B?RVZxWXlFb1ZsYnJLNlNPSnRKbGViNlFyNCtJM1o4TnhoRnZEeXFQdkJVNVJX?=
 =?utf-8?B?YlpJOFhsamMyc2FDUE5VblBDNEJvbm1IRmhoSWlyUWZ4bkE3M21maWpFS3Jm?=
 =?utf-8?B?ZmRJZkZ2aGFuTW1IRlZMbFNFZzVBK3IyU2V2WkVVT09XVlhMdi9iQjFXODRH?=
 =?utf-8?B?ZzRxdzZYbWRBdVg2TllwaE9HdDlMR2ZLOWQzT2w3NFlEcXo5RXlUcmtLZ21J?=
 =?utf-8?B?OEpCV0ttb203T3Z6K2FDSUdDd1FXYjVvZDVZU1RJcmg0ZUI3OEFvcUtCR2RV?=
 =?utf-8?B?SDQvN3VoK0hqbHlpeXNjQzBRUStqNGozaWpJeXMxdnNIQlF5WGRXRHBRVmpz?=
 =?utf-8?B?S09TSjVZMXNGREgxdmhyRHdHNmRXN3JqZTlRRDh0TVBja2VxSEIvZGpMQ3E4?=
 =?utf-8?B?Q3VINkg3eG01bi9qMTM1azIrRWpUS3V4aEZjaUVZMzdWTjBmOGxZNzFrNHow?=
 =?utf-8?B?c0xXLy9UMTU5V05HWFhzRFFqMytmNDN5YjE2cXhrMFExMytLMFVObUNLNHUw?=
 =?utf-8?B?ejgwTUErT1VjdTBVUWFEZXJKTTZaZ1QxekhibEkvZzkydlZDaFpTZXhreHA5?=
 =?utf-8?B?cUNScVJHQVVFRzFTY20yOVo3M29naGRJb3ZSMjVUeUg4cmpEMzg4NU1RbkQv?=
 =?utf-8?B?eVp6VFZEeTczaHh2cXoxdUhwSDZ6bTgxa3FhREQyU0lvdnlxaURrQXprb2RX?=
 =?utf-8?B?cVFWOEIycDRDMWdmV040eEhOY25qcmtHUkR3OTR1Tm16RGp6aVNlaWN6eEt6?=
 =?utf-8?B?MmVpUGpYb0l2NTU4WlFmb0lLUm00SEkxRWZLbUg3VkZTMytjZ1E3VVpZcjFu?=
 =?utf-8?B?RGpib09FZi90WlRJNTdGQS9NRWk1ZnBBeDhabGNpcFlyc1phTVp5RU10SEtV?=
 =?utf-8?B?bVBpQ0lLeFowUkZQYXJzcmdmeVdoYkM1NksrRER3V29SeTJyRjlpa1ROa0J5?=
 =?utf-8?B?S1JJVzdjQmNhcUgxTTA2c2J4cUpKdE8ySExvMGw2VnorZXlQOXpJWDdRMjFM?=
 =?utf-8?B?azIxTGl3RXo4aE1UaG5WdzNlQmlXaTBDRnB0eElTY0pseWh4V2F2ek9WS1BD?=
 =?utf-8?B?bGZFRUZ1c2RweE1GYzlXdVpPOS8vWEZBR2RPRzlEOFpoNXlQSXRRemJaa2FG?=
 =?utf-8?B?WDg1elREZkFsbHd5MHUveHJaVEJHNlUzYnZEQTM4VkxIbU1VcThITDhmOVJI?=
 =?utf-8?B?WjZ1SkFkOWgxUGs0cUk3QmZENFZjUjNaSExRcytzcXVlS3VxbzMyNGk2Q1ZY?=
 =?utf-8?B?ZFFhMU92a0U2SnRRV1RHWWR3Tko1L1JwNnZvWGQxbEExTG8wZlU4MFNleVFY?=
 =?utf-8?B?cVg2OUJkMkVFWXF3TVJ1M3JwYUNsYlBQWDY5MW9lVXg0L2JWdmRpbWlnTU5G?=
 =?utf-8?B?UDZmWTZNenhvbGhneVBxdEFJL0M3SEI3SWtVNkxVbzVoUy9iSG1QSVN1emtj?=
 =?utf-8?B?UEJaKy9iV3BXTUdmcldjdVNURytXVVJmYkl5amRQWFpVSDFna1pzb2p3Z2Mx?=
 =?utf-8?B?a3d2U2lNeHFVYitZSjVKMjlsUHZZYm1KWjdDMHBMMWVIKzFWMkp3K0lTY3ZK?=
 =?utf-8?B?bWdFSTI5VmhnaW40NFowa3BpUGlnNEFmOExTZzFvN0JWb21xb2FEMmQyall5?=
 =?utf-8?B?SDh3di9GdjFMZFlzempCOU5uZmluMlo1ZHc3NzBWVjFhWjRLY2JDM2gzOHFr?=
 =?utf-8?B?V0puOTJseWVQamVsWkhEWGgxR2UyQzFYck5sNFpUWmdFeFBjbVRpYVo2eHgw?=
 =?utf-8?B?WUsrVjVQSVFXNklQejdjcDFmZnJVYnk4Rmk2and6L281MG56Y3FmRzhKUW8r?=
 =?utf-8?B?T0d4UXIwZ0VyUmprM3hpb3p1U0lrUDhvbWMxQUJVbENCTWZLKzBEeC9rYVYr?=
 =?utf-8?B?c3ZqbDRnbEd2VFZOQXBCd3VXYk1qaDE2WlJQKzkzdEI1U09MSVpacnZ3aWpl?=
 =?utf-8?B?cFdYNjQ2aktidENDT2RZU2JlY3dLdEdsSUVpVHQzeXJ0bWd5UGNGK25icHhH?=
 =?utf-8?Q?sE4O++OgrlsIaDbA=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b5239b-1690-4f97-7664-08de6b103cd1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 14:57:41.8759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mj+VnrVsUKmMiubnopmcllPRRUO8cSaNXXjQXwAZN3xfLD7cWrodXkMi6y3fORJKMejXzooGRKuVf/2GJscbzhiOYt5VlVNj/a2jpETYEhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9340
X-Proofpoint-ORIG-GUID: amY5HwKwD0V3mwGHI2AFVFmyx8_U8VB0
X-Proofpoint-GUID: amY5HwKwD0V3mwGHI2AFVFmyx8_U8VB0
X-Authority-Analysis: v=2.4 cv=PaLyRyhd c=1 sm=1 tr=0 ts=698f3be7 cx=c_pps
 a=GdOSod5Hi6qnJTGfnwF89g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=A8CFoUSrsMxYrmQZrYUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNSBTYWx0ZWRfX7CMKgh3PdCjs
 3FRf1pNSL7tKm6yfKUZkDdyazJYHQzAHRnMePr0TXyeHPWjnVMuHFQgwjm33Ff/f41whWl/mTBR
 4MF5HidSRIfwU3C8OstE6IOPyaPb7NjD76DiNvNXxuhOjRrRTI4ETcUvW47tb24cX1vSjj8WUmh
 OnBVt9aP/ZeCLKgve48HAbGNAlLkRRQivFo5On4nLYxGUXEfbjsNV1GupciZEAMZK7tPLblKSq5
 G/3E5wG63S8utgxQXJYOu5TFFc4Dup/oRtQT5wzE3IkisklulORd6cpkYF0CZ2OQrQWlUSJYvuY
 F7IffJ4bd6ud8/L8vPZ/OGMwG26BY5AYLVDYv8srWWDc/Y0ZIrZeSHvLMeSKP5yoAWgYvDP8I+9
 RcrIjUD7wyKjIM6qoIohdRx5HkLHVieoto3e6gUuiCH5MzhBkotnUAWejCAYTj/FR2AC0U0Ahhk
 XqqJXddXdZ5FoWIAqHw==
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
> Replace the custom audio logging infrastructure (dolog macro and
> AUD_log/AUD_vlog) with standard QEMU error reporting (error_report,
> error_printf, error_vprintf).
> 
> Note that we also dropped the abort() call in DEBUG_AUDIO, as it is not
> usually compiled with, doesn't help much, and can easily be added back
> when doing development as needed.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/sdlaudio.c | 31 ++++++++++++-------------------
>   1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> index 4fb9abd66c3..bb667ef9525 100644
> --- a/audio/sdlaudio.c
> +++ b/audio/sdlaudio.c
> @@ -26,6 +26,7 @@
>   #include <SDL.h>
>   #include <SDL_thread.h>
>   #include "qemu/module.h"
> +#include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "qemu/audio.h"
>   #include "qom/object.h"
> @@ -38,7 +39,6 @@
>   #endif
>   #endif
>   
> -#define AUDIO_CAP "sdl"
>   #include "audio_int.h"
>   
>   #define TYPE_AUDIO_SDL "audio-sdl"
> @@ -67,15 +67,15 @@ typedef struct SDLVoiceIn {
>       SDL_AudioDeviceID devid;
>   } SDLVoiceIn;
>   
> -static void G_GNUC_PRINTF (1, 2) sdl_logerr (const char *fmt, ...)
> +static void G_GNUC_PRINTF (1, 2) sdl_logerr(const char *fmt, ...)
>   {
>       va_list ap;
>   
> -    va_start (ap, fmt);
> -    AUD_vlog (AUDIO_CAP, fmt, ap);
> -    va_end (ap);
> +    va_start(ap, fmt);
> +    error_vprintf(fmt, ap);
> +    va_end(ap);
>   
> -    AUD_log (AUDIO_CAP, "Reason: %s\n", SDL_GetError ());
> +    error_printf("Reason: %s\n", SDL_GetError());
>   }
>   
>   static int aud_to_sdlfmt (AudioFormat fmt)
> @@ -102,10 +102,7 @@ static int aud_to_sdlfmt (AudioFormat fmt)
>           return AUDIO_F32LSB;
>   
>       default:
> -        dolog ("Internal logic error: Bad audio format %d\n", fmt);
> -#ifdef DEBUG_AUDIO
> -        abort ();
> -#endif
> +        error_report("sdl: internal logic error: bad audio format %d", fmt);
>           return AUDIO_U8;
>       }
>   }
> @@ -164,7 +161,7 @@ static int sdl_to_audfmt(int sdlfmt, AudioFormat *fmt, int *endianness)
>           break;
>   
>       default:
> -        dolog ("Unrecognized SDL audio format %d\n", sdlfmt);
> +        error_report("sdl: unrecognized audio format %d", sdlfmt);
>           return -1;
>       }
>   
> @@ -182,12 +179,12 @@ static SDL_AudioDeviceID sdl_open(SDL_AudioSpec *req, SDL_AudioSpec *obt,
>       /* Make sure potential threads created by SDL don't hog signals.  */
>       err = sigfillset (&new);
>       if (err) {
> -        dolog ("sdl_open: sigfillset failed: %s\n", strerror (errno));
> +        error_report("sdl: sigfillset failed: %s", strerror (errno));
>           return 0;
>       }
>       err = pthread_sigmask (SIG_BLOCK, &new, &old);
>       if (err) {
> -        dolog ("sdl_open: pthread_sigmask failed: %s\n", strerror (err));
> +        error_report("sdl: pthread_sigmask failed: %s", strerror (err));
>           return 0;
>       }
>   #endif
> @@ -201,8 +198,8 @@ static SDL_AudioDeviceID sdl_open(SDL_AudioSpec *req, SDL_AudioSpec *obt,
>   #ifndef _WIN32
>       err = pthread_sigmask (SIG_SETMASK, &old, NULL);
>       if (err) {
> -        dolog ("sdl_open: pthread_sigmask (restore) failed: %s\n",
> -               strerror (errno));
> +        error_report("sdl: pthread_sigmask (restore) failed: %s",
> +                     strerror (errno));
>           /* We have failed to restore original signal mask, all bets are off,
>              so exit the process */
>           exit (EXIT_FAILURE);
> @@ -233,8 +230,6 @@ static void sdl_callback_out(void *opaque, Uint8 *buf, int len)
>   
>       if (!sdl->exit) {
>   
> -        /* dolog("callback_out: len=%d avail=%zu\n", len, hw->pending_emul); */
> -
>           while (hw->pending_emul && len) {
>               size_t write_len, start;
>   
> @@ -283,8 +278,6 @@ static void sdl_callback_in(void *opaque, Uint8 *buf, int len)
>           return;
>       }
>   
> -    /* dolog("callback_in: len=%d pending=%zu\n", len, hw->pending_emul); */
> -
>       while (hw->pending_emul < hw->size_emul && len) {
>           size_t read_len = MIN(len, MIN(hw->size_emul - hw->pos_emul,
>                                          hw->size_emul - hw->pending_emul));

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


