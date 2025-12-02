Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E8ECFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 11:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQOLI-0006J0-GP; Tue, 02 Dec 2025 06:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vQOLH-0006Il-8F
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 06:14:47 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vQOLF-0005xH-FF
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 06:14:47 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B244Qf51715416; Tue, 2 Dec 2025 03:14:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=3oW0XLGv4k3js+XId5Fxu4pKq5ovroMhMGSEy+U8X
 DM=; b=24JRM3HBIV7AxDeLGD3ztUWFW0KziwjrtFW2QdeitcNtuywDPMcyaaD6O
 3xdQeHNIAOrzTOULlswvq8T9QuKHy9V66JxizgnI+kc0+3yIKtFvOZQlwoPRVkyt
 NgaHWKk53N7XjYHPbeiMDfoz9ZE3Vr/kOjdGorC0sJz8gR82J91hGN0gkcnD0fwo
 Wi6n43CAS3Dje5ugaNXyAUq8RU1H2eVQwAmMk9E/0KZICMUbYmvh1dVjf85+gEkw
 QDPOsfGks1EUkPo+M50f4BB8zdQr+jGZ3kYzzTKKQsJv9K4YCr9aNwc6CV1ZW2GS
 4qdEKKfsc9hVjwFgVCw0wty3To8DQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023096.outbound.protection.outlook.com
 [40.93.196.96])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4asrrxrtwa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Dec 2025 03:14:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQqSFZaxQZ+tzMQ1/jLQo3QSFbhB1emwTzSlXP1y17cQJtLEoioXzd36y3oLZHcbYBylPRDJ6wd7lUrkPcjP7xIc1bgm41Ggd+3Wn4pd+dQ2/9gPURHPkLukuuIFDgEt7DsmTdIty/ZGYk/ZVGWG22UrTN5MsgPYyxFwk2CUij7OvVAGbKfGu6RAKrZP/kBMt4zEoQkSKuvlHl+C8FLMgjQ1RFpvbZqpNyEOTngIUBy/WEwVpshUsetBOc1L6Cfj0A+iusT60y8UtlRH7LRNH/JJvJQ2YlYsXMinH8hQ+lhf+YQ184e/w2S+iGzbOw2aGvIXZn3YasxeYhtRoB3X7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oW0XLGv4k3js+XId5Fxu4pKq5ovroMhMGSEy+U8XDM=;
 b=L+f/1nWrytgY97OPe1AjiANYNjnwZyj5ncvHZ+Bv0AkNKDwKUddHNErh43a4Elo7JgXjVthUlIkKIb9ra4RbF4hkfIyJkZcmCR6SybJVU7ghuPZ+vRfUcY+zXoAGVWH2YOviZt4ZVN7b4aF0GDeD3VZc2hV8PrADcVAUIWIXMyHoFGLGU/g5iSSGNZ/LgnX4GM6a6YDaCCGr7vw5BbifqI3+qdyEQRKTSQVmfmKvtnSpMDtHICg134xGd9wu9UsTAzIIljYugBYH3WgL/qo8Trl4j3Bl7hp+VaqixkceS2ewo0On4FZfnIFLZyIYAUflTjiIGIvkoc7B0ZM+hSEkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oW0XLGv4k3js+XId5Fxu4pKq5ovroMhMGSEy+U8XDM=;
 b=eV39OfFDFK1B0xETtqGDOaSCR4jnMAdpisCZhuYxkHCFIstsH6sSTIki5q1COuTlYJl55Dft5WltFy2qOUPH/CYRCXtOvbGti+PKT7QT4PMj0QPktf7MV5QU5OxyeVVJZWT3d8rshxCTjCSv+gZUtcpaMBujIAtaQuJ7G4Fl5r2qtcEITawquhhGoNW5qelSnxdly5A+IBSJIEEgJh0EuWT40Y0j+ZayZZ0Ozpqcoy5Xhu5fKNgxkZIsCicbKmXwOL4Y4y5WRkMAA+OL8XSYhmEQODsDu9lE3cJl9Wz7G07JrzPPvd/v7N+3TIA0va/4Wzex86I7+/8N1eebxjsp1g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB6617.namprd02.prod.outlook.com (2603:10b6:5:221::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 11:14:42 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 11:14:41 +0000
Message-ID: <865e73ba-ecc6-4b3a-a4b3-ea17860cd3a9@nutanix.com>
Date: Tue, 2 Dec 2025 11:14:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] vfio-user: recycle msg on failure
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20251201095621.2786318-1-john.levon@nutanix.com>
 <20251201095621.2786318-6-john.levon@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20251201095621.2786318-6-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0340.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: dcdcd0e2-a83c-438f-6622-08de3193fd84
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEE2Vy9VZUpYVHhMWW5ZcnBxTEJwWE1SQTRNSVlTSzFZMmpFT1pKdGRublk5?=
 =?utf-8?B?MW1oa1F6c3d2bm1zK0xZeVVsK1dOSWZkYlMyR29Sd2gyUXlObWR6R2lhVmtz?=
 =?utf-8?B?Z2RTbHBDblJMMkRIb1UxT3dTeHE1RFlVdlNVVFVKZGRtblh2WnRrUjZrQ20v?=
 =?utf-8?B?NzNJZ3h5MldJUEhoanZNTjJLSTg5ZUlseUhnYUh0RUx4bkIrNWMxU3YxYktI?=
 =?utf-8?B?RUhjdkJuM1JjUnVWSVFXYUZXL3F4OXl1ZTl6c2tJN1Qvc2JIYVlhdHJmUlJj?=
 =?utf-8?B?UXFFVDdXcjR0cnNQTTVyNFVIRmlyL2pzQjZ0a0lqYmtSd3haREhQd2IramJj?=
 =?utf-8?B?WktUbnQza2xGVFZqYUZ6REtkSW9pYnM1akpvUHFBSG1pY21UL1RMSURrN3lV?=
 =?utf-8?B?WGI3Rkl1OHdxQ3BLT0JzcHN4Yk90UTk2UGk1NXk2TnBOcGxHNVQ2c1h3cTFp?=
 =?utf-8?B?Q0VLOXpEN1liY1lDQmk5dFZ6anBQMDc5SkNGNTg0U2hzSHdaTGlJYnRqVEZQ?=
 =?utf-8?B?Z2hiZmZIQkJibzlsYnZPZm5Lei8xaHA3czFwMkZoSUZpRTNuWlJjMUJoNVV2?=
 =?utf-8?B?YjlsVnR6T3ZGY2JNK2JMUUlTUk9McHBFTUl1UWh3M0s3YS9IcTVSOWFCaUxa?=
 =?utf-8?B?bVlCdS9zak5BL09wMVg3Z1d3a2NMa05DRWZsTjQ3ZjcrSCtGQjI0UGhWaXhs?=
 =?utf-8?B?anV2K2gxOFA1WkV0dE8zQ0VCQXc5T09nUWIzbEhLUm9oeExRQ3V4SjBMbnZW?=
 =?utf-8?B?WENTWmRmVVI2enlNaDBsWm9xM0h5VTA4dnZwdUh0NWxlSTRqWHUwUFR3cjRm?=
 =?utf-8?B?L0Q4MFBqTWQyZG9LSzR2dnI3Q1huNXBVaUFlZis2cjhsV0NhblNKVkVTQ1g3?=
 =?utf-8?B?ZC9Zc2N3MGUrMlNGcFl2T3YyWTQzakdCR1pHMjROMndBSDFuNjIxajExc1ZJ?=
 =?utf-8?B?ZFErNHp3NHRvRlZBOS8zYVNNYm1PMFdTWWJ2MWpYRGJGWUhpeU1BemtyWjJM?=
 =?utf-8?B?enZ1cnJZVlZ6SGRFVlI2NU02SGRXSXhSVS9mZ0tRcEpJODZtZElvUXQxaXZH?=
 =?utf-8?B?NVlCQnFSdW1wSExlSzhZbmc1VTNuT0tXc3BsaXpRVjFnWHRZY1lWcFhJS2k1?=
 =?utf-8?B?bU9Bd0UzaWVXVVc4VVZKdU5PNXUxbFZsVmFCa2xzM3FsNDE3SHM2Z3h6bVdt?=
 =?utf-8?B?MW5ITmJYODJKR2xxRm5YYUJNeFJOR25Fc3YwL0xQNlRvUlN2SlU2NnZkREIy?=
 =?utf-8?B?ZzUvV3Zpam9wVGFoN01JMWtHbGhHdGhreWZUSmpScGVmQnprNUd3WmlxZlV6?=
 =?utf-8?B?NGxWQzduSmcrOEVFQXFSZ0F2bVlGeUEvYUxjTWJ1Z1lIUGJCZE83a3RxWUYv?=
 =?utf-8?B?ak5yTlRGdU90ME9hRGczNXM5bEhEK29oc2tnWXpZZ0pPUW9Ob3J2cThiTUpS?=
 =?utf-8?B?NXJ5RVQ5UFFkdmR1L0VSeTNuOXY2RjQxZkROd2t5WlMrRk1aUmdDTFkzRkFG?=
 =?utf-8?B?R0hqOGNPeHZGQjBxSm9TNGhzSzFKRDg5Rm14Mzdaby9yQ0ZrYVhvcXpzSmd5?=
 =?utf-8?B?NGErWnVGRUpHKzU5Y29FVEpnN3E2bEVVTlRUanV4YmMyQ1U0Nk9WT0dWckwz?=
 =?utf-8?B?SHlnMDgvWXhiWE56d1ZJWkVwekRDQXM5NTArbmdSeGF0R0c1MlVaeXlFN1ls?=
 =?utf-8?B?Q1FRU0dMV0piZFkyZ0Z3R1VTSldRK25pRWUyVnQzRjgza3pjODZqZ3FSU0VB?=
 =?utf-8?B?RHlqRWJOcHNOUUtWWU90cFVkUXE1NHNwSXVFcHhJVkxqazZBVEhOVkhBSEE3?=
 =?utf-8?B?L0ZiVVZ5K0c2dGpmSGJ5VjhITVg0NnZod1FjM0JJdkpHNUh1Sk9VLzNqZzhQ?=
 =?utf-8?B?Q0dlUFh4Y3hDa09KUWR1SWQxdVZ1VDUxOVMrZUVFWnAyZDQ3b2ZyY2RETFha?=
 =?utf-8?Q?P6+e1HjdDkDc0DKZ/r/pTafJsnkjcyVe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG02N05sdjRTWVFpOEgyWThza0VLRlM5TEx3SUhwYnIzRnVOWFdYejZaTFd1?=
 =?utf-8?B?UDdrMnU5U24rWlRNU3J3ZzJoZTRBdUlQL0ZpYllKVHpQczgrNEtyUFNENWVR?=
 =?utf-8?B?d0UxU1BFTTVPc29TenUreG1aYytzRXJDQTVwMzJhbW1vSHRKWWdtVTNOaFh2?=
 =?utf-8?B?eXhpSjZia2QzZTdGNEx3SWh3QW0wRWpSNE9xVDJmL1pRMGhKSmlDN2F0NEs0?=
 =?utf-8?B?aTluM24vMjR4bU51RTE2YVRFTEdMU2pac2c2YjlWTmN2bE5rbGZkUjhxdVpI?=
 =?utf-8?B?VGFGV3hzVlJ1ZGJMSnp4Vng1T1hRV3IxUlE0TFBkalNvZXgraHN5OEY2NUlT?=
 =?utf-8?B?VE4vd283THpOYnYxRGFEZml5UHZRYU5QWVJCSlRrZEhBOXRzSUV1b1c1R1B3?=
 =?utf-8?B?NGpHMGxBMzBjcDdPMnQ4TURxL0c4TytOSWZJNUNoYTNqU3lYaUhacytick1T?=
 =?utf-8?B?REZBVS9VZnlyZEtDMWk3cXkxbGtNaHRBUS9Fa2kvMm03UXlPTWN1TE5JbWlC?=
 =?utf-8?B?WGtwcmUwUXhkVEVqWUpLVXJNcDJCaGJWVE5lTnVHL09Uck1qdkFYSnEzSkR1?=
 =?utf-8?B?enVCZXFPdGlmYXRRZEJ0REcwNjJDSUVndm1SMEc3blJsNnpHTUVrMndnYVR3?=
 =?utf-8?B?R21qUnlmdGcraUdQL0Fhbkt2WHNoQy9YUEVLRCtZRytoRU1EYStqQUdMVDU2?=
 =?utf-8?B?cTE3S2xBdGtjTnhOMTdZU21PemZpSnVZMHAwMmNzc1NZbzR2RkZPaHpyYUtX?=
 =?utf-8?B?NkJCVy81dEpMa25xTWtOL0JXMnZDalE2aEhXcjRXQldSa1phL1NYTXZra1JY?=
 =?utf-8?B?M0gzMlhNU1JyL1k1aFVzRkZabFRlaXExWXFLYXpleWt6T0FIZU43VHo1VlNJ?=
 =?utf-8?B?SmRwbGVON2RWRHFwaGVWOGVSV0QzUDBRRnBPd2t6M2ZTclBoOWdaRHYzaDRC?=
 =?utf-8?B?WmZvQUVFcy81SEpHeWtRdWRNR3dDS25uM0loaHZIamJyUTZEVkU5bm1PeXZq?=
 =?utf-8?B?ZjlGNUVUY28rSXN6Nkg2cElPR1RvQVQ3NitiL0lUSnRJQ0tEWE04YVBkUlI2?=
 =?utf-8?B?ai9uVlR5eHE4djJ4UGY0ZVpXQng4SnlHYWJoWDhTU2tydjRzQXFsaXUzL0xN?=
 =?utf-8?B?UXZtQ1N3Vm1yNEloTHFMaFZSY0UvcG4wSjZkbWhVbWlSdlVCOWcyNVltWFRw?=
 =?utf-8?B?VDVveWp5UkttZUF2d0ZkWFBMd3lNNy9pb2JzcFBOUjl3c3VwWjZCT25PRzNU?=
 =?utf-8?B?WVgrbkNFUHZDRDlMeUZabTh5TUQxa25jVG1peGZWMG9RNjMrKzJ3UElTQ0JH?=
 =?utf-8?B?Q2d4VjZoM0R6QURqREcrRVJBNHV3THNOWVV4cjQ4Z0pURm1iQmh1VHZ5anJM?=
 =?utf-8?B?dnNUNGVFZ0lieFNtQjUwVU82WExrRitLVzJNK3pncGJYWmRqb1JnSzdLNVhT?=
 =?utf-8?B?ZFJOMElqVm0yYk9tTmd2UXNFVFhLR2J6MmtJcjRpS3pCUTFsenVOM3BWR3ZD?=
 =?utf-8?B?S0h2ajhLaXJseStmcFZsTzVicGpWTWxCZTdiR3NpWk5URFFEeW5xRlM0cXQ1?=
 =?utf-8?B?cFEwYTZGUzNxcTBxSkVaMzlsbHlOQVRBMEFyQ0dFSDBSL1o4OGtmRlh4S20y?=
 =?utf-8?B?YVErS3VobHVCOGovaXpJRUN5ZDJhRTg2WVAvaVhJUk9xZ2dzb0NDckZ2RHdw?=
 =?utf-8?B?Vm1ZTkhUUm1WSDVTakVBQzIwanRHVzgxUStPOXN3WG9URHozOXo0VVdrZWNN?=
 =?utf-8?B?YmpIVW5YOHIwNEZOYUhrM1dVc1hFWUtCaURIeW5EbHpraFY4WjF2azBPaWg1?=
 =?utf-8?B?ckVsUEpuWTdGMEJRYjBiY1pSbGdPWXR2S2l6SlJ4N2hSb3RDT0ZDQWxMamRG?=
 =?utf-8?B?a2dUTmVlWWlQVzRFL2V6b0dYNStpTmt3MjdrcUxNRGlGc2p1aUlJNUxOY2xF?=
 =?utf-8?B?OUFwQmhrV1Boa254cVpWc0pJZUxlWnA2UVUxY25OL0s5emZtcDQ1RkJBTlBZ?=
 =?utf-8?B?SGlzSEFEMFVnQitpUjJtWUtwdHZHWU55Vkw4Z08wdThqUk82MnAyNmptRG9S?=
 =?utf-8?B?a0l5aVhObjZYUVpMNnFBc2lVZWVBbFRGckZPeXhLSURoRW5SNjk5WUt2Q2I0?=
 =?utf-8?B?OWNscEltakcvekE0b0dBL1AyaloybU4zanRaVmRQZzVJT0dkNG1ZQlM0Mis4?=
 =?utf-8?B?K3czbUlULzZaQjNuNkFIZ29hR21mcWhLenRUdXBwMk1Zb1lUcWp3V3BiclZq?=
 =?utf-8?B?T1ZXL09Yd0dsUFBFVWhZWEIxdzJ3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcdcd0e2-a83c-438f-6622-08de3193fd84
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 11:14:41.8948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kf5nl6YQrkv7tHIF961tzUvf1K4XD5IlxxLSAzGvaykOTF8cmKnkT6GonAwXzWYWuVpr79dqfkKBALJwbDdxsP8tuWkys+wusIKQfubt3Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6617
X-Proofpoint-ORIG-GUID: fJygKYLBrOHMDVG62PrFENoPw2JNpV0V
X-Authority-Analysis: v=2.4 cv=HboZjyE8 c=1 sm=1 tr=0 ts=692eca23 cx=c_pps
 a=cck1Y2tAR+80KxojUOV8qg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=vxLnJfySGY_F9sbnCPUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDA5MCBTYWx0ZWRfX1IaF1aLdMbJb
 xzwcAKYswQUI4rc+sq/IfKhra8ohSzstISccEi2PbiGvgXEf543WSRm0BhNOGfwVqoFIHfxIQ24
 H6k3Z5It0tynCib/9JDK2zJpD+KYMhIbLFf6Ib6dGDUavraqvR+ew3mRBs6YznbNs/VrC0V+Mgf
 89ZWI+4plK/r931KgRBXMfcG9leDnnM3RYOFuJVOrecIS9LdRaLrJVohMNWXzzvAedJ7WHQuC0k
 QRckTOSPs3OvpjjE9xems9jKFkdE8KtYJIvCSfOf2bCQkPTecTNz5iMT2WBwgzMQrSMupacu7gy
 TLyVQmkU5UAyJp1RAZWTFz09/9pGGhqKQ8XyWKk/ogqgW7SDNJZ0lxe1lUWYjv+KQrU15y8ILUi
 bEUbB/za6jecVkhqwwMsenWZQ0d+IQ==
X-Proofpoint-GUID: fJygKYLBrOHMDVG62PrFENoPw2JNpV0V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On 01/12/2025 09:56, John Levon wrote:

> If we fail to read an incoming request, recycle the message.
> 
> Resolves: Coverity CID 1611807
> Resolves: Coverity CID 1611808
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/proxy.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index d1d63816b3..d06978a74f 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -412,11 +412,22 @@ err:
>       for (i = 0; i < numfds; i++) {
>           close(fdp[i]);
>       }
> -    if (isreply && msg != NULL) {
> -        /* force an error to keep sending thread from hanging */
> -        vfio_user_set_error(msg->hdr, EINVAL);
> -        msg->complete = true;
> -        qemu_cond_signal(&msg->cv);
> +    if (msg != NULL) {
> +        if (msg->type == VFIO_MSG_REQ) {
> +            /*
> +             * Clean up the request message on failure. Change type back to
> +             * NOWAIT to free.
> +             */
> +            msg->type = VFIO_MSG_NOWAIT;
> +            vfio_user_recycle(proxy, msg);
> +        } else {
> +            /*
> +             * Report an error back to the sender. Sender will recycle msg.
> +             */
> +            vfio_user_set_error(msg->hdr, EINVAL);
> +            msg->complete = true;
> +            qemu_cond_signal(&msg->cv);
> +        }
>       }
>       return -1;
>   }

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


