Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE71C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 15:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZtQa-0008Mf-Ae; Thu, 10 Jul 2025 11:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZtJ1-00035u-MP
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:35:44 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZtIx-0005nW-7n
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:35:26 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A839sF025532;
 Thu, 10 Jul 2025 08:35:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=hbskrnF35GGpJ2Bf/MuW4PGiYjHPB5Hr4jr4SUtAv
 +k=; b=LzW/1edN+8jegr2ijH/fIJ7Y+RSFFW00ZsakXtiOUI3WlSbzHaaVYZomA
 kGTqvwsSbAkeudc145tVaA8zhmg0iYtxOLMlHMUt99OjqlxRQK1/adpin+prG6g0
 ZgeuKIR87GTZTLqdXHB09XDU0O+EllpkKsOzGhJt7ZiabVtl6tM5nlXZBmKjuWaY
 uNoHP4NylNqaWZc9BSLR3MNDycX6iTt4vIINCK73y8LM8x0qJD1hsStovFvUo3n9
 m8/lY5K99yhEEkmkfCr3bAKUBEn8ncp1b9cvUunvY1BsfdmaCeUjQsCwn+P5QMt2
 /n3ULL766qwRilUFIeIyOJDMpDGNQ==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2091.outbound.protection.outlook.com [40.107.212.91])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3m15xps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 08:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxnm5sbyIdnyA1FU1zTo7wpkjMV+vdy8n7oxm2d0YEo8GHRB0XwNp55INlwClLNDP7RcVfev3y6aqXB3aNEzka6jAwYiGOlKHHfEaTWF8G7xgjv0mN8URQvOCyWGFbXfgciTEMulMVvuxj+NTtL2nQEgPjQSD8pDN2LqdMDhdB1b8cVgmJtt9DvrtC6CJ/hzzMa0x3kyKMI492SKNcrVk6E7P0nILrHFpdJEKU8gCSO9FI11QIp95M+LmE8RPqUPqqeXLpbenSURPHM4n+QyTxpMSHV07niwpxSyP6AZdMM7VksjGmr6m78n62DilFs7IKyvvqLeH9eGIA3fUervVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbskrnF35GGpJ2Bf/MuW4PGiYjHPB5Hr4jr4SUtAv+k=;
 b=sjJuvnQlhkXXJBDc5B+G0plnMJQaCUNX0GeXHBF2kmOrt6blwUpV8w1MxqrhOM9iflQJ9JOoBkToP9GKU31D1TMffC+urfZlCkC7rCY9j+LFgccCGx6Q5PMZ9WuazIpXxuX0I9GQMAjwxCQpDFam5/SnkbcuvsjFxDLilmBahyOH8dSP9l/ZLo//xOSS+7kNyeWHwEij+MPgHmi4KlTU/Wd/mLW5Qyit3qia2xTr4Yh+Jzp8GYvW/c3uopVGbEu9cKNt39/tORSnd1fQoMSXMP4/Xk7AKHY9HTZbgbfVJVv0fEf/9UYSt39WL2qBZmsqzwK94DPaiN7xdmlFEbbKLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbskrnF35GGpJ2Bf/MuW4PGiYjHPB5Hr4jr4SUtAv+k=;
 b=Dv2D3oUrFkZyvS+WUCC1ce7DKoqSkiAHAj6QgjXzx2nV94kgcMw60YPED9wQnCkXbmnt1VFrxXdLpbvAhFy4/MGTj8Uer6dmx+ARhqGK4EHYYgqn3ODFw+6y5UZKrF7h7ACTIJXZCHpUYHiOvazK5GtGynB3ozrvXbNqn0I+aTaPHfDwV2FJUlx65FzXtCKdAVXOOKF5FSg/A8VcU2fNNzvd8Lm+A14blDU4Nuiry1OH5kcZcpVmzhAQDWC2ecf691QVnWaB2mDuz3NB5UQjoC+W0m9GaM+1ejvJCqgymixc3IGhEZlOUTx0rzCVHWBvEiwLb4kHVMItiFcX89ypOQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB8664.namprd02.prod.outlook.com (2603:10b6:510:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 15:35:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 15:35:11 +0000
Message-ID: <6e04c7fc-f390-4245-be27-f5f37924943e@nutanix.com>
Date: Thu, 10 Jul 2025 16:35:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/18] hw/i386/isapc.c: replace rom_memory with
 system_memory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
 <20250710085308.420774-19-mark.caveayland@nutanix.com>
 <8e9e90f3-eb41-47db-8286-9d96a97c9cac@linaro.org>
 <695cf9b8-3e5e-4560-9847-688917796648@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <695cf9b8-3e5e-4560-9847-688917796648@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0035.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c0eae8-e7b7-4cae-b850-08ddbfc75b4e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUUyNlNPWU1TdmR2Wi82MndBZ3dZV3pJOWltWVQ5OWViMzI3eTc4ZS8zWWJa?=
 =?utf-8?B?a1B1ak8weE1XYVhCRGwzZThZNVRCQ0V0S1ZWMnora0lXMFVpK0V6cjYxb1c2?=
 =?utf-8?B?NGs3UlJMQTFrZ1ZDaHU5MmhOM3g5cE5qbzc3VVIwTU1zRUFOVzNnd1BGcXlk?=
 =?utf-8?B?ak5JdGpWS1ltbmR5QkRscWtkYW9YOWtRWWI2K1FjWHlIQnRuYnVBZ1kzbWcz?=
 =?utf-8?B?K0t1OVFQc0ordEVTclhMTTduUjhOaXYrMzFNWUlTUEtvdmtzRk45RjNPNUlE?=
 =?utf-8?B?bTVOc1BDL3p3NVVNbk10QmNCa1JJR2ZCTUc3TFd5TzVzWTEzOUJqODJFdGIw?=
 =?utf-8?B?WGpEdFY1UUxSQVY4TUE2am1EdFV5T3o1K0VOS2drOEJFcXpZNXJLM1NmMjlT?=
 =?utf-8?B?bHVPRmtiVzE2MGtjMVhaME9MSURiY1VlRXhqVUVRdE5jeU82dDFjUFhFbyt1?=
 =?utf-8?B?NU1qTjNpRWZCeXVtUVJWLzcvVHRmS2hzSmlnTVBkNmtFb2NTNHpMamhOb3Fa?=
 =?utf-8?B?MFRtdlZhN3d5L1E2SW1ydFVkWDQxeWdPRXpiR2dXRzY0UE1sL0JReHBNK1lo?=
 =?utf-8?B?Y2dDNmZpOVNWRERoYWZyZThiQnpveGQrK2ZFSjNPalhjODQ4YzZrS1JvNlBS?=
 =?utf-8?B?RVVvZ29tV2hTd2l0WHhvUTM5b3ZDRDhCUGI5TnppYnM3emRTYWNob2pFOXB1?=
 =?utf-8?B?VlFTZXU3eUhFQVhBMlpObGlBcGQzYVhrRDdrN2M1T05UYkxWMnRUY3FKTmxP?=
 =?utf-8?B?S0ZnUTBwYXJSMVQwSXVwVk5zaG11RUJyeXNpV0k1NVVGeFhoWDJZWVJGdWtX?=
 =?utf-8?B?VlZVbkdVQkxUcjF3UUluYjE4QVNYWXZ6Zm92MitpMHlRWHkvY1JiNGYrWWc4?=
 =?utf-8?B?a2VKK2R6d1BKYm1IY0lKaGh0YTNtWFg2NHpKOGdSRWF1NDNKVVJUaFVxdFZk?=
 =?utf-8?B?VWVyRnlvRUhrTU94TDIrbllzZk5uaGxEUHoza3JSREg2eTJicUZndVZWWStM?=
 =?utf-8?B?bktrclJ1bEU4TVErK2M0N0Y1eHlnNGsvYXZlUjNTTXYxQ1ExSTVGQzl2WHpS?=
 =?utf-8?B?dkV1RDJlYXdyV1BvbnQxeHdaa3A3ak9iU1d5Wll5dENyTDZLSnlzYm5LY2ls?=
 =?utf-8?B?bzgxbU1HK0VBZVRnWFJhY09NZmxXNGs4VDE4dnQ2azhkWnRiTVdYUmJ6TW5B?=
 =?utf-8?B?V1kvSkk2azE1ZmtlWkxKU2xWSmNXdWZsUm54MEJuWVNWRkNBckI5ZUF3Ukpx?=
 =?utf-8?B?RysrMk5aQVduZnUvdGZ5eXo3bkpIdUN5RS8za1kyeFZtMmJXUFNTenRPVUwr?=
 =?utf-8?B?bTh3VnkrOUh0bG9JKzZaaVptMzFtUDArYVVndU1QaFB0V2VFbFFneE82dklk?=
 =?utf-8?B?ZExDbnEwbUEyYit3TXlIV0ZmL2c1Z1FrMnRZNTZSTjcxM2JTblJvMS9NMW9R?=
 =?utf-8?B?c2Y2UjRVeGJ5NlFhV3l0eXZ0YW85V0d0aFVSNk1OaUtWLytNYi9qQU4xcGdU?=
 =?utf-8?B?UTR0U0R1THNuRUFOQllaMkx2Um9mUFlLcVVqZC9WWVRqU3I3VU5nUlBjcWpx?=
 =?utf-8?B?RGdXRHljZ3BrVkZDOERVSkFzK1YxRjBzcVdocFF0SE1EczVBbGlwZnNMRnV1?=
 =?utf-8?B?SkZGaGoybUZueHMxVWtLcWtmNjVvZkhpUEVMRTBud1VVdkV4aERNR201NWZD?=
 =?utf-8?B?TjRlTTdUSmM2bWZkNE9BeG5zRHdrMXNnS2RMN1JPcUJDQXptbUlMR0piZk43?=
 =?utf-8?B?VldEQktQN3VDcnFEZE81VE1kdjhDRSs4eWxvM1hXUFlsV042NnZidm4wa1pJ?=
 =?utf-8?B?Vy9Xczk1d0NZQy8waU5ydk1wN1ozdzJXYXAyOHJuSWtQcHBieCtmSFFFaEhi?=
 =?utf-8?B?Z0FhVWlOQW5rUnBhOVdvVnpRT0ZFaEpzQ2dNTjVmNHVUMXNETzlQZ2hEeFg0?=
 =?utf-8?Q?sHYvJ37liIQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1Z0M2Y0UkdPMVl0dXlRd3pnR01Kb203WE5TajZhYjRNaGpPRkdDUUVwc3N0?=
 =?utf-8?B?Qjc1Q25xM2hQNlhYVjg5R0xMRDExeUE5eTR4TjBWRlRYZDJPanFXZmFHaER4?=
 =?utf-8?B?RjVHbjJDUVc0ZGZzZzhjUW1vdEo0ZXBGYmdESTdnQVZNMGg5aGg3d3hnakls?=
 =?utf-8?B?OFVWRjZaVEcrQXFLRmFPcmNzMENFdUE5NFd3bXNsTDBTL2RMeDNDem95NTRO?=
 =?utf-8?B?bndxcW9KOUVmZnNFeWFIMVZwSzE5UmhJL2l5NG9zUk1HdUdEZjZHRGo2Q2V5?=
 =?utf-8?B?K2pUendNc0ZrRGI4SHRhSG1YQ0dHZ21YOFhuelAwcWRlSHdVVGFKblZVWHQ2?=
 =?utf-8?B?bWR4TmNkSkJGOG8ycjA3cG5aZFNhQVpXZ0dLZFZ5OGNEMkY5K28wdVhRVzZx?=
 =?utf-8?B?dzhCL0lBeG81U3VJSEZxaVd4WUdocGdrdVFzc2tiTUVNaUdKWHR5MXZqYlNx?=
 =?utf-8?B?eUhDK29WRXlRNXlDTmRwaTQ5djBodi83Ry9xTndyOW5wRnFKMncvRXJyRGsx?=
 =?utf-8?B?enNwRnVQYTdmTENXOGF1blhTazdRanlGaVcycC9MUHpsVnB5RlBhdnRWaXZx?=
 =?utf-8?B?YlZVVXpwTkdzU3NqMHdERkd1ZkF2c3dBVVEwMVk5U1dEWlJSSVVRZmhGeWJC?=
 =?utf-8?B?RTJOVm4yWnBIY2ZvQkdJRFVVRmZpV2s5a0tHZUNVWWpXY0RWUjhxU3VtdDhH?=
 =?utf-8?B?U1pmejh4aFNkWUZMQkhhRXd0ZkFBZ0lWdjJJN0s2d0NJNHJhVWJxMVJ0aHM0?=
 =?utf-8?B?T2dUQVcxNVhReUV3V29vNXpwSVBCQThsblpocnZncG90SjZTRzFZaFhsVDd0?=
 =?utf-8?B?NVR6QVBoTDVKOVRQVU1za3N0ckduRTFqWW5od2pFNEQ3VUg4ZU5WZWc4SFhN?=
 =?utf-8?B?cXdKTFRUaTlaTm5DeFVJVlFOM1RKekh2ZU5GTUVwZVhFa1FubzlYMDVNSTVy?=
 =?utf-8?B?ZHJBQ244S0NYc1gzZ0dKaTlXRStFNk9GdUFVWnpsdjNIYkRPSGxkVStXUmpr?=
 =?utf-8?B?UFo4OVllVTE2Wm5wTGVvM0RoMVJGZTlzUFZJTXVPVnJCYjJBUjFoSTBwa2t0?=
 =?utf-8?B?YXdJVllmT2FQS1FWSjJ4WWU4bXhxTkprSkJDSkZqbUErZllLWkYyUzZVRkxo?=
 =?utf-8?B?VzVpdm5KdnZCYi85NDBUcUJHRGdHa1VzTTZ4NlVCaXZkaTVrUTlZd0ZNUFRi?=
 =?utf-8?B?TnphQncwd1ZGVzVZS0QwNkoyb1gyTjZOYS9OalRXNzd6UHlNeTJOenhxNkU4?=
 =?utf-8?B?b01wUDlyZUY4RnNqVEMvRjZkeXJhd0llR2hNbkd5emF2Wk45Yi9MZzVlQ0Yx?=
 =?utf-8?B?bmNINXJFY3QrelRwekdUUllLcldCUC9Fdnlrd1JCRy9XNFFHZXZwVTlzS3hS?=
 =?utf-8?B?bU0xTEM5MUZ5ZFI5bCs1N1Boa2FHSENPQjFOWW1ibkppWkJxYXl6L1puaHRP?=
 =?utf-8?B?NVNqMjZqVXcwc3hrOTM2dXFQNERDS2FVZWZGeFlIb0NZRzQrbWtpekxaVTRl?=
 =?utf-8?B?c1Z6OFVZZ1Bua2ZvSmtUSElTZVZmRlNuK1ZYaXNhbjE3QVIxYm1qOFVNYnZH?=
 =?utf-8?B?WWpVWmFxTWJuZ29OaFY1VGhKSk5TL1NXdlE2RTBmdU5GUlByM2pQZUpNR3FL?=
 =?utf-8?B?TkVhMmZSV2RJWUtZTzlsamVQeFVWb29sVi95dDRhcTZoaDU3YytWM2M0aVVy?=
 =?utf-8?B?SlRkYnltd0JUZ0pVaFZXR1czZVdzNC9yY3FxOUZRVFYxOXVyNEFVZzVWeWx4?=
 =?utf-8?B?NExNN0hUaVUxWDFxY1lITEZkK1dzYmpuY3hFbmIvcWRpQmlJS05NM0M1ZDNZ?=
 =?utf-8?B?RE1GUGoyTGdmc25Ma1E4eXVvQ2pCcGJSeUlPRkdUR2dFZjJqWldWblNSUXF3?=
 =?utf-8?B?b1dWQ3JwcWJIU3k3ZXI5Yng5Q1J5SFFtZHVuZGkzMEVpZWtuREpaY3BxOWsy?=
 =?utf-8?B?VjhZd0NMR2srL1dGSWVyRkh0anVPNVNUdEI4WVBrOTJad1o4bVdqWlI2U3hs?=
 =?utf-8?B?YnN4V1NUckNCSDFLUE5pUTBxakZLd2hWMyt6Y2luazVab01aaDlla3c4azNz?=
 =?utf-8?B?WmNQckg3aHoyNytya0F4S0VCTWJzVFo4MDJYNU8wdnArTW5kU1BQN3dtUWVv?=
 =?utf-8?B?UVRBRG5NLyswQWRaeHFZOHRKYkpBdVpRRlVNMXRVeU5teWw5Y0JzOFlnT09v?=
 =?utf-8?B?MGd4Y3RFWEJXYWxmZlNDQUVaUkx5TzgzL0RZRjhsV2JZMEY4K3B3dDM1VmxO?=
 =?utf-8?B?aGhIYTUyMkQ3dzZ3WTVkaHB2Slh3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c0eae8-e7b7-4cae-b850-08ddbfc75b4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:35:11.0178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueVrypbSE3kxqy3/QK2ObLjv87p+HLs497xFh304DHAI/l20h9QOKx6h7kM+9+jTUkRpMzX0utROkTIeS2pXr2zFvaU6g1LaDIAEUi2WFbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8664
X-Authority-Analysis: v=2.4 cv=Nffm13D4 c=1 sm=1 tr=0 ts=686fddb1 cx=c_pps
 a=z7p4S6pgv8Z5IXOpG6YCbA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=9Ci6k4XJi2b27AtT8sAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZD3Xl5iFwrdwEBl1hBZU9skdSRkbnhyv
X-Proofpoint-ORIG-GUID: ZD3Xl5iFwrdwEBl1hBZU9skdSRkbnhyv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzMyBTYWx0ZWRfX4ljui5UCnOtz
 R6S8IYroEKyu4zaQjRhYlw+wnPV8INYP2oYmGEsJoRw14JYU7jqKiOqxnfGDYoT22v0ix/0iuwr
 oivH9vCGGOlzL1fusYVrCfw2d7VA4xi63ay0DMt3cpyFEZ6u48DBR2hxtL/0Dl21PfyzSgxAn+z
 pvvGxhZFUJqBdgbFBnEKQEgAcGmrlneH2R7vWLa7g1/8pdxSfqdu34D/OexK12qYSZlDurdjDc2
 XdxSbH3qZY7wAAbEpCS3PTCP0Qvwb+3zKki72f3807A66qB542TAHHioXmlk+wOg3+e/o/vM/xW
 6qTmx3VuM9Uj9TRYG0vnclpamZeMjDGVRMU8uTrSfUsqO79tq0qiyMizesDFxmmqKZ70tmlgkEc
 7jbZ+mHN17PH+WEq8A3c2p4D/tRgqJAnNrh/e6513hHOphu32/lqAFRqOopIKB0I/s1m73SY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/07/2025 12:05, Philippe Mathieu-Daudé wrote:

> On 10/7/25 12:53, Philippe Mathieu-Daudé wrote:
>> On 10/7/25 10:52, Mark Cave-Ayland wrote:
>>> Now that we can guarantee the isapc machine will never have a PCI 
>>> bus, any
>>> instances of rom_memory can be replaced by system_memory and rom_memory
>>> removed completely.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>> ---
>>>   hw/i386/isapc.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
>>> index bb22083821..27c075b5f3 100644
>>> --- a/hw/i386/isapc.c
>>> +++ b/hw/i386/isapc.c
>>> @@ -35,7 +35,6 @@ static void pc_init_isa(MachineState *machine)
>>>       ISABus *isa_bus;
>>>       GSIState *gsi_state;
>>>       MemoryRegion *ram_memory;
>>> -    MemoryRegion *rom_memory = system_memory;
>>>       DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>>>       uint32_t irq;
>>>       int i;
>>> @@ -73,7 +72,7 @@ static void pc_init_isa(MachineState *machine)
>>>       /* allocate ram and load rom/bios */
>>>       if (!xen_enabled()) {
>>> -        pc_memory_init(pcms, system_memory, rom_memory, 0);
>>> +        pc_memory_init(pcms, system_memory, system_memory, 0);
>>
>> I'd prefer just call here:
>>
>>    x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
>>
>> and in pc_system_firmware_init(): assert(pcmc->pci_enabled).
>>
>> WDYT?
> 
> What I have in mind (untested):
> 
> -- >8 --
> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
> index 27c075b5f32..a7c2146916c 100644
> --- a/hw/i386/isapc.c
> +++ b/hw/i386/isapc.c
> @@ -74,3 +74,4 @@ static void pc_init_isa(MachineState *machine)
>       if (!xen_enabled()) {
> -        pc_memory_init(pcms, system_memory, system_memory, 0);
> +        pc_memory_init(pcms, system_memory, NULL, 0);
> +        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", system_memory, 
> true);
>       } else {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index b2116335752..2952d3ee4ff 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -811,3 +811,3 @@ void pc_memory_init(PCMachineState *pcms,
>                       MemoryRegion *system_memory,
> -                    MemoryRegion *rom_memory,
> +                    MemoryRegion *pci_memory,
>                       uint64_t pci_hole64_size)
> @@ -826,2 +826,3 @@ void pc_memory_init(PCMachineState *pcms,
> 
> +    assert(pcmc->pci_enabled ^ !!pci_memory);
>       assert(machine->ram_size == x86ms->below_4g_mem_size +
> @@ -955,3 +956,5 @@ void pc_memory_init(PCMachineState *pcms,
>       /* Initialize PC system firmware */
> -    pc_system_firmware_init(pcms, rom_memory);
> +    if (pcmc->pci_enabled) {
> +        pc_system_firmware_init(pcms, pci_memory);
> +    }
> 
> @@ -969,3 +972,3 @@ void pc_memory_init(PCMachineState *pcms,
>           }
> -        memory_region_add_subregion_overlap(rom_memory,
> +        memory_region_add_subregion_overlap(pci_memory,
>                                               PC_ROM_MIN_VGA,
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 821396c16e9..0c29e4188fc 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -221,6 +221,3 @@ void pc_system_firmware_init(PCMachineState *pcms,
> 
> -    if (!pcmc->pci_enabled) {
> -        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, 
> true);
> -        return;
> -    }
> +    assert(pcmc->pci_enabled);

I think that's a good idea, however the original aim of this series was 
just to do the basic split and tidy-up work (hopefully in time for 10.1).

There is certainly more tidy-up that is possible w.r.t. pc.c, but I 
didn't want to start unraveling that thread right now for fear of this 
series getting too large :/


ATB,

Mark.


