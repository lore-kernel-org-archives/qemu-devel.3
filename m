Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD5AC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 11:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaC7m-0003Z9-QM; Fri, 11 Jul 2025 07:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaC7j-0003YT-1m
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:41:03 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaC7d-0003v4-J3
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 07:41:02 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7Hc2d024648;
 Fri, 11 Jul 2025 04:40:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=O/2flsPBk9J8mBgSGbMQIKYOQS+czkfJOm+FcS1s9
 WA=; b=g8baGuAPSA6wm4JiXcuBy27YB6DNIoHo/L9/C1N+LVBe3gwsMBtO6CUSm
 ls02qNrm7bNGsJdnvuqFnqkFnao15kbAQ8BltpPDSCgEQOimuI90YiQjQhgVe1eB
 PZD5/bT4/uatQwZCtVAEfFwFc3BuGSWGwsoL4MnKz1JF2+/gnjEzc9n9IyEpmqFK
 5nE60VfUFdCuhGIDOqowZqM+s+JzRt8f81yB/aI7M41c4TjMJi3M+SMyCrkmbWS7
 IR/G8SczWbmGnDnyC6AerlEUhZEWnlhZBW+hDfIWIHB0JtkbSvW++Me5NS2lHieM
 fVBgzzPSnZZAt/gSKg5ObRqqIDMFw==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2115.outbound.protection.outlook.com [40.107.95.115])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3cf1907-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 04:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFZQPJdznJ7cYm11arCgfpc2l9mwbYw4F47jeo0PhwbFXPdTGrguAItdbL5BxuiP+FQiTrKTvgo1e/EtItUJHbjYbxVitP1sjquJ4rRFrKbabEIYx5eqTcYxnnGSCr9x2VlvhBozTzyr7/wwfgYmbXWanxNteHFX9eqUsQtNcXeFX0VuWLOLIne5ddRfXcyxldkQb9956Mzj60UpKUr8pCB4QTT9ovjFiec6635ej2h1zIIV4tti42A61Zvwjn6BjyfyX+590DcxWG/GowJlzVa9ebuGRAdGaOFvBXPWP/A+X//rlmrqloXksVCUvqlSWGCx8x2pGOxvrydelGmBzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/2flsPBk9J8mBgSGbMQIKYOQS+czkfJOm+FcS1s9WA=;
 b=dpHlcnZ/CgXGC04BntwCO2Qdft6B0aZGEHI8gIW3lLLfUXaAkid3V8ks/0zx8gFRMKkT3b7THKT1VWZJKl1pfOaYq8CMp195Y1bMJlfp0JzD0htF2xCKgztCnTUiKEhezmk+N0oBmABiay39cFJ0Kx6L15ke8wH6K0PdwTc6L0EQtJYVgs4LHL2YFpVYdy6PCExKEGjnbT1WzeMujJX104dyoTkNAnKdyRPq1FkI5vKZh6F6V7OZJzfmvhiKMqzdAdSv1GX3FaiAW0CALshBhkSLsgmpHPwsIInakIs8ulOAmYZJp92NdLRnlu+jEcwdLjmEHGBwg0CDSy7951GjQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/2flsPBk9J8mBgSGbMQIKYOQS+czkfJOm+FcS1s9WA=;
 b=u+v0HdgmczMMcV9KHYyg5C+qLUd7kwIl3G0HVKuhqhg0eNxN7ayqthPpwMdGXmgVssfxVpcF3kn3/ny7PZXDpHDI50qfaiczXeFYlyVhuM69QFrhSVLeFZT6U+PM5Z6/Q69RTf5PGeM/Jw3FV22mOuhQ23HvkASn8uZINIfLHxZC/NOIRS1jXZGno0EUqXZGCLkgr7QPLU68KWZOwFgjnheFUuv2QjEGKpmTprS0EYGBfyRp+YGIE258h/PBeDp+sFs8ZUUV/I8Hzgfdo2WSi1nbte07yaKVyKOEjO9PrunFnTAKxg9QqT82GhaWY/z32ZswoPRrVtiP2CAFdiAvMw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB7876.namprd02.prod.outlook.com (2603:10b6:208:33f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 11:40:52 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 11:40:52 +0000
Message-ID: <085436e9-54a2-4e40-b906-7643948dd1f2@nutanix.com>
Date: Fri, 11 Jul 2025 12:40:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio: fix region fd initialization
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250710154842.1267253-1-john.levon@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250710154842.1267253-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff9fecd-8e17-4b86-86a2-08ddc06fca22
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDRad3ZqcDdvTG9vNG53ZzhZamR4Q0ZRRkZUbkR3dkI5NzNDdU9YYTBodmVx?=
 =?utf-8?B?NTExRnR2QlFpdVFjUnN1QytBL1RIS1UvUklkcCttcmNXZEJ0S3BZV1pPZ3JL?=
 =?utf-8?B?TDBONGdDSFpSNEJlbGRKelJrQ3AxN1N1MSs1TEJaN3JWcXNULzNRREtucHNZ?=
 =?utf-8?B?TzBQSUxnNXRHbUpyc3M5QlNLTWlFMVIyTTdVTXd5djVHek1nYlBXNnNYcFVv?=
 =?utf-8?B?Vit0cFl6LytuQ0c2UUZzT2ZTSSt1OWlkTWNvb2k5Zko1VWZCeG1qRS9EaHoz?=
 =?utf-8?B?L3RJbXA1M3lHd1d3RitFclQzZUdVbGNwNHE3ZVIxbUJOdm44SjQ4OWhoU1Z2?=
 =?utf-8?B?OWdYUE1iVy9WaXZZU0JoWnB6T3Q0dFB5enBRVG8ya0xwSzREV1d2bURZRlcy?=
 =?utf-8?B?YkF5MlBqbkNGcUlaWE9WTk02N2JXSHFrZ0txdXZWOFJTemRuWWM3bTdQVkxh?=
 =?utf-8?B?YVp6NURoVk9lY0MzVWI5NDR6K1NBa1QxdHJheUNyL2pEb2d0akdRTWhHQVpD?=
 =?utf-8?B?YmQ3SVRlWjNsQVBiRlI4WVlWemE1L1kvKzJUa0ZKa1RCSXRjSW83RGxneGVU?=
 =?utf-8?B?SFc4Wk9LQWRhS3R2ZTM2VFU1VHJqWnpzV01xS3puVksxNENiSWFVdDcydEFp?=
 =?utf-8?B?Z3NsT0FObXFDWHhjNm1Kb1ExN3JTSk9FbnhNV1NDVXA0dlFjTVlCTVkvcHJY?=
 =?utf-8?B?TEpqZGpDMTVRUWppQzh3QzdOT1hzb2dRUkp1bTE2dkYzS1FoenZQNGsyS1ps?=
 =?utf-8?B?SFRIdy9JSGRxa2JPQm15QjhqYVFjdjA0WWhzNndPM2FmdkRoS0ZkNXZ0UVAx?=
 =?utf-8?B?NHBGTTg4WWFhZUdtMkxjazZZSWFEbUtBbWhmUzRjbVhkdSs1NEJkOVhwZ2hZ?=
 =?utf-8?B?dFIzTE5XcmJLc2xzWDNzTnNTN0k0TlhycnNGQVlXK2tPL3ROSkhWbUFyTWcy?=
 =?utf-8?B?dlBBMERGelA0RTQ3U3ZFdEs4ZWpBQm1NZFFuTjBNWTBOdS85ejFheUx4VURI?=
 =?utf-8?B?bCtyY2wxRFlkMzc5RlAzZ2ZVeWowSGJObnJjRVFtTVNkTEZRYUgycGJWbHF1?=
 =?utf-8?B?NkcwMGhjc0FoNFFSd3JlSDVoNlVtYW8zdFVGSkFKTE1iNmpNcS9xU3R2d1Vw?=
 =?utf-8?B?NEJiOW1rUngzTzdSd3VHNGxSWVlkTlRLNWh5VGNsdUFBTHRQMnhmZ3diVTZl?=
 =?utf-8?B?SjVmODVNbEFCWVhwMEYyKzhDbWFJSENlM3pYV0lrdVZJdEkwMEE5TGZxWTZL?=
 =?utf-8?B?UlllY2RDVklkTEYweDZ1Q0dVNldvTzEzRkg1RkZKUUhVNjdLeitvNmpSZkFD?=
 =?utf-8?B?bVJsMU52cXdSNThkNXpxNzhyU1Y4bzJLcTh4RDhKM05HN0w5SHpUWHpCSXdh?=
 =?utf-8?B?Mmp0Yk1VamRlc0hueVhDYk5NRkFxRmdQZ01vRm5NRVVFZmZaSHNmN1M1V3o3?=
 =?utf-8?B?bHZ4NmVaSDJyUWt6cGpYSVFQTllobG1NRlVGOTB2ZS9qMno2Z2doZU90akF2?=
 =?utf-8?B?T29QTjRQMlZ6SGZjL0Z1bGZrc1JmWm1XdkRCM2ZWZnRTUXhjbEpNM2UxUDkz?=
 =?utf-8?B?MDMrVGcrbWdOWUo1MlBVY2Q5bDUwNDlwRDJlUmVNK3Y3bGNkOXRZTUZSSEl4?=
 =?utf-8?B?QjR3ZHJnRkFzWHpUeDVDVlRTN1Z2OWZ6MEtVWEtCWktEUTQvakF6SHVvblVH?=
 =?utf-8?B?RzVMREZvdTQzNXBpYjJ0ejhxeDYxVWc5dHJqcVlmZU93QjRrSXNoSlhqTWRl?=
 =?utf-8?B?emlaYlpOOUdXMUV1MjJ5SC83NFZaclV5ajBpR0p6QTlUdFpjWkt5V0I0TEJ0?=
 =?utf-8?B?R3k3RVBtQ21yeDQ2ajF6cXBMZmU5VDE0VUVsOStwZWtPZzgxdDFCUno2QUJY?=
 =?utf-8?B?cDY2WmxWREF4bndEZ1BKZ3pPNmN2K1VzckkwR3VkR3dxWFVqdVM0MDNkbVA1?=
 =?utf-8?Q?CHtZNJSetkI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wi9CdGJGRG95R1Z4SWUrUzdnakpuRkcwVnZWMHhjWUJqYWNqT2ZNYUp2aENT?=
 =?utf-8?B?SVZsUmJTWVEvTWtKRjhYL3EzMWJadGlIQ0V6VmdyWDl3clpSakJKaFIzZGw1?=
 =?utf-8?B?a3lFZnFFSjZCY1pEVXlYSGg1YllpVkVmdDkvcjBuMkMzVU9LMVpvd2k3dEtL?=
 =?utf-8?B?S29zWDJqVExwdy8vd1VxVjZLL1BVZkNFUlFVdE05VmJPNjlodTJyY0RaUFg0?=
 =?utf-8?B?Z0duSU4zNm9ISjVMVWhMam5wRDBlSzBHMzRFMzB4U2pWRjZacEpyZGgrN2lZ?=
 =?utf-8?B?bUhoMGJUN09KcGlMOHgyeWZLZ3IyVm9ONzc4Q3JsdVRXTzZDVTFKWWFsbm83?=
 =?utf-8?B?WFc4SEpmRU5PYUVCS0VldlQ3d3RqYUVyRmFueVVtY1FiRS9WemVMWk5HSENZ?=
 =?utf-8?B?RmdaR01USXBqRytTb3Q0RnBnaUJMVkhRRVpndDQwM3cyUDN4Q3NPcldOalBR?=
 =?utf-8?B?Um5SRGpQRHBjMUhHM0V3L25zT21seHZLb1RJK1VHRlM0K1pIejE4eGg0MGpE?=
 =?utf-8?B?VVlPaC9jMDZ0ZDNhVUh5SnBkdStTU3FtdmVwM0pQMlltVFNVdVNHTXB4VlpG?=
 =?utf-8?B?L2E0Wm51eno1NFZiMVJjWVNVZ3JqUGxGZ1hCcXFyc2tCWVZFR1hFWVU4RlJO?=
 =?utf-8?B?Ny8rWFgyekVJWmthSngyVExyY2krNzRZd2NSRHBrNkxXRGpYblZoNlh6VzIw?=
 =?utf-8?B?YlJpbngyWFVmRVJoellSRWx2Ui9aYldmaDVxVit0bTFOUFI1TGRBN05BWkFJ?=
 =?utf-8?B?K1dkVlM2djVNNm53TkZDbTlJYkQ0Rm53L2cvTDA3eFJaNUk2QWRaVGtSMk9V?=
 =?utf-8?B?YU96RlhEU3ZCRHJta0o3Ui9ZcWtNbVcrWEd6ZytyQjZRYXlicDFVVlRSVDdB?=
 =?utf-8?B?VFp5d3R0TTJLZ1ZyL1VPVGlzaUFZVHEzOEtibWlTeXJPQUVPZ0FQYVU4MWNU?=
 =?utf-8?B?UGpXMzNGazEyWW55dU9FdENwa2lkZWEzMlE4ai9oZ1c5V2tlSWdLV3JMek5K?=
 =?utf-8?B?Y2ljVU5GR3JjdGpXZXlHTEk4RTI0Z1c4WE56Nms4UGY4UFJBOFFMVFJQTUI5?=
 =?utf-8?B?TWZTMDU0TFFHcVZjalhKZExIREtqRTVIZE4yTjkyNmZqVVIxak1PUWtLMUdM?=
 =?utf-8?B?NWJ5cjd4c3MzVmF2NUMrbnZqT0ZtOHU3MjNXdHRFdTBZdGQ4aXZFM1N5OXNi?=
 =?utf-8?B?MHRQMG5OcnFuSi81ZEVEUXRZM3JKa0lkVW5kaHkrc0JpeUVJRWpLdjhnMGhB?=
 =?utf-8?B?dWR3cFY0eXloZWJGbnA5NmpZY0dXbm9xMEFZUGFvYWpEWnRTK0RDRnVuWk40?=
 =?utf-8?B?L0RXeFUwSi85MEVXTmZKUHM3N0p6RDNZTXBKNW9jWkU0Zm9rTzF4ZUpTRGlt?=
 =?utf-8?B?b1d5U2J1Qk5sMVJqcHNTcC94SjBEL1ZHYTIvUGJvcFZFckpob0htMjdKSzlP?=
 =?utf-8?B?dTdsclo2WHJQR2dacE8rUzBUM1k4SytjbW1DeWI2NTQ2QjkyWElvWDRyOERN?=
 =?utf-8?B?bW9VRjJ2QmFtRGlXRWFRUlBYaEhnTlVyb2FaTXZHaGxKc21BZWFFUEtZSnh2?=
 =?utf-8?B?ZzA0Q3NwelRQS3grTEdRVnozcjZQaDZxVGl4aU9RcHJLTlo0R1RKRExqUmlW?=
 =?utf-8?B?WXNrdFFXbjl2dHJ1dHpYUzNucTIzNDVBYzRNL2ZGY1BCL2YzWSsvMmxJakJL?=
 =?utf-8?B?aTlKUS9WZHU3S1Q4eHUwUi9lQ1h0STRhQmdzQ2dHZ01iQXZKVWZ3WWQ5R1lP?=
 =?utf-8?B?Uy9MQWQxdWgzaHkzeGl6T1VENktNbE5QTi9GakdLdzBGV2ZjUzhHdTg5Qklw?=
 =?utf-8?B?cWNwcTlya1lSUHNwSWpJdlJFOGJmdVNKaURaWDhtMzF1eDd5cGptd2k1eEdJ?=
 =?utf-8?B?dnpSQWd6VVZhaUhrZWNtTFIxNmhxUE95bVpOUXRGT1plMVl6Zk1XUlBIRTU0?=
 =?utf-8?B?VmpWZnM1OWM5Z0lXWTAvWjNzV1N3UlBvR1BuR3N2cGI3K3pUdkw5S3E4UWkw?=
 =?utf-8?B?dlpsYko4ZFdra0tHdjE0WGg4SDZnQjgvN3hGM1BPNmtFQW5KV2lMZ3BjK0xh?=
 =?utf-8?B?bzR6R3NJOGdFTW5qWFU2SGdMTlB6UmdJRTM0dFNYWWsyeTEwZkVndmd2c0FP?=
 =?utf-8?B?MFNCVkxIZHNFV1U4cnlEQnE4OFgrdjYzdjArUkZ0VUI1MHlma2V2cUNzS2RH?=
 =?utf-8?B?ems0WlhJOGx3b2FpbW5YNzd5cnR0eUxQZ2lLTStlb25IZnB6THdidE1Gb1Nr?=
 =?utf-8?B?WCtTTVIvNzNaR1hRZm5yR3F1MzR3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff9fecd-8e17-4b86-86a2-08ddc06fca22
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:40:52.4008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNYM0kOk5+61Xd0mNavwY48XOrN2tPKC0vcHA5nPfutd/7OGiBoCl/TgtOX05mgsSrcDcWrYLJOyySnHgO1EGIYrW5L/bOjAQ/UI7PlEdEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7876
X-Authority-Analysis: v=2.4 cv=U9SSDfru c=1 sm=1 tr=0 ts=6870f846 cx=c_pps
 a=cnt9m0a41j3Cx0A/6ET4og==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=QWqITENuK4ibzA0zzzUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ox0DmOdBcoUI5YOJMr3mRcsurLTrtNcX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfX2FVsoKQWieIc
 wsBh0rA0ubyCUIHkfYf8ha9QtVupf4/fOWEhs/KMh7AOVrgKCK3fop2iTR+lJPYHyOaafZv6Utt
 sX7d3ESXjf+nfUfqDZFfA3OTgyvU0dmHIxlSQWtYBamQJ8/SJCA/HJJ3RkqPdhkEM9Bv2EvbZJ4
 RO7MDVYb1O80q4/5MH+q3vIRtGHe3R5vMJgHAg5Z0mxXtKItT9Bf6uYs8zJ+GDqmLwIvKldDa+8
 ZO4s4jIoOA/tp+4xUIP/EtDhLoCwk0Yz6m0uAN4uXOyGJXt+GO2yTuLo+MXG0U7jPKVmooXP1JM
 wrKiYGeApDiQSl26rRACYQY9oFwGIwZqK+dzZFi7hNp1UZZvUfyBW2PLMkYVRQkJKJPfUctxQEJ
 X3O5Gow0QubZIQUMkOYYdc1Q94ALcoZplwVSUySkv+kLOF3NDUBVtDDQJJBz9GAHK2W7CS/j
X-Proofpoint-GUID: ox0DmOdBcoUI5YOJMr3mRcsurLTrtNcX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/07/2025 16:48, John Levon wrote:

> We were not initializing the region fd array to -1, so we would
> accidentally try to close(0) on cleanup for any region that is not
> referenced.
> 
> Fixes: 95cdb024 ("vfio: add region info cache")
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio/device.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 96cf21462c..52a1996dc4 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -463,6 +463,8 @@ void vfio_device_detach(VFIODevice *vbasedev)
>   void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>                            struct vfio_device_info *info)
>   {
> +    int i;
> +
>       vbasedev->num_irqs = info->num_irqs;
>       vbasedev->num_regions = info->num_regions;
>       vbasedev->flags = info->flags;
> @@ -477,6 +479,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>                                  vbasedev->num_regions);
>       if (vbasedev->use_region_fds) {
>           vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
> +        for (i = 0; i < vbasedev->num_regions; i++) {
> +            vbasedev->region_fds[i] = -1;
> +        }
>       }
>   }
>   
> @@ -489,7 +494,6 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>           if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
>               close(vbasedev->region_fds[i]);
>           }
> -
>       }
>   
>       g_clear_pointer(&vbasedev->reginfo, g_free);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


