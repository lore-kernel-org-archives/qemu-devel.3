Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DDBC79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4GEC-0005IV-78; Wed, 09 Sep 2026 07:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x4GE4-00055h-6F; Wed, 09 Sep 2026 07:12:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x4GE0-0006oi-3a; Wed, 09 Sep 2026 07:12:23 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689AmMDT1790647; Wed, 9 Sep 2026 04:12:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+4vLs9iKOCY9v2oWQHauB58+fqbPTJ+/f/hv2KyUa
 /Q=; b=rh408lynWpfo03aJGhXyRrb4PCtgKgCzpD43bbT+/HCG22SSu60fUM3et
 kvFJpWvkbveChDP/ISQaE6qnFwoU2ZIUqTmscJuVhIpQCkZK2gOGPk1F2n1dZ9Q1
 YDcHCe6AfAGxVErdC4ErPhG/jV1zr5PYFaXRrHCYrW1PXDYTG1ZB9vQSrzTkWH8l
 7JgB6pCu1ocbFxVZWZbfjaqFhz1Lwc4D2HpfV45LIVFpSdA28/4/hCf38WPdgCem
 c7UtsbY3EoG7e7X6ZNU2gV55i51uQoz1pfwEZH6vMgaVXmTKky3PBJ3dU8vUhKWe
 2EXhk1zRG6Cnfb9+zlwXTgjHawCDw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021131.outbound.protection.outlook.com
 [40.93.194.131])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gjp7ma7w7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 04:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9uyg1X/btU5SqPTeZBiQ48pmlIRLpq3rcV+nwvsjr+ajJKjoUyQElbUZ9rIa4N5tPNDDRqSwLOVYYvBf6vJeL+Vr6trvYv+4JnWAOjZhrD/NBwllIuX8MBcu6MIC80+OWgVrWhwcY3OyQRe0HWJRuCxR8zoFYqCeOmYVQQ8fAKJAdq1g/OTbJmffYDwUlosV3Zfu9SKTvZwB4qYUt/Zw/LdDMdxdgGeXMLbZKd0N1urefKjwYVPWbqhU9eI/FOLq32hrL8sf0Ex1Q4g8uxEb09fGaSvnypO7gs9gXjXUYV6ao4EJs40H73YePOrhFXCaw/2BHgNl28ETHebFwQ2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4vLs9iKOCY9v2oWQHauB58+fqbPTJ+/f/hv2KyUa/Q=;
 b=U51gv33R0lL3Yteg5hEa0vhA01TjNcGAMfYfutSSwvU4wqiNT0VT62S8RCYPZgaimDU5JOzD3NEAKoNU0ChoW57AuQ3ub8MH/NV1hbXCo/Lmv3TNdJ+XUAbd0961dToH/WGNPz8exSHy14wfz2tYZV5d/ow28Kohb7ZdEISaIRX/jWxIWm6eLxsbJkwrmW3rtyjSghGNr1Yz4JfNRaQfB7atEz/HxGH/GYHZ47C9bGexLMhomynhD25bxJ+wLINif/Pz+DyPUTemvXFiTUCjIgmQRHdDrcFaUdXMmaVKNYOC/3lhCNTfO0urBWEjXPwQBD9vKmXY6xD6CngLfWHfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4vLs9iKOCY9v2oWQHauB58+fqbPTJ+/f/hv2KyUa/Q=;
 b=UquxtDBreK4G8QyjujaTDqTy4lEFE0w7LoTlcp78bgYpahcaOU57MTF0jFJD/mlPJo7YV0KjJZWwBEHJwqoYrZUKck1MJBbUn1aQx7HkzsWbH8K7VMb3BXl7AagaGqhOZrqTC2JLT1OTswtxPd/0COErxIlXZW4NRAkWqJUZcIuX7aMBgzkU8USxHCazwYG1BWbkoC79Bbr813C2ZdHb91IG7RNnCoicv8zgGzHr62YtUKWhI7JT7KDlJ3zEfJEsIPqYcaGgb8bizryX1Z2QziYdWPAwi2rioobrOR2uYuTqfAKQXlhWl3sGN0TBGwxM0vmNQ//0zKQ65t798exPBA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH4PPF89970358F.namprd02.prod.outlook.com (2603:10b6:518:1::651) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 11:12:09 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 11:12:09 +0000
Message-ID: <8411ce33-12f1-4359-8724-f92480e5e558@nutanix.com>
Date: Wed, 9 Sep 2026 12:12:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/12] hw/arm: Add Axiado SoC AX3005
To: Kuan-Jui Chiu <kchiu@axiado.com>, philmd@oss.qualcomm.com,
 163wangjack@gmail.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 qemu-arm@nongnu.org
References: <20260909105543.1478008-1-kchiu@axiado.com>
 <20260909105543.1478008-10-kchiu@axiado.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260909105543.1478008-10-kchiu@axiado.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0172.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH4PPF89970358F:EE_
X-MS-Office365-Filtering-Correlation-Id: f8397983-83f6-4846-5b2a-08df0e6330b2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|4143699003|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: /8BbtbKuYaa7duszvnH9Ku7hJzzPpB/BMA+1JA+swJ2FAbablnDCwtuIdMBPhQK91UkgCRWYWhgamfAlV5kimo5Zo6GC1GMXJ/yL836amu9QZISPwqFOdrFWQ9NdM4RufPHyqDRGDHz+VLBiW4WiX1YHauhb+gw9J9A5b6veNl/X/mcgb+r9HerxGEgPDl+g6aKqi9dr+ZETZR84sbiJnXkVcIhDrRI7Box1GwTRhOv+tny9SbfSanzetlt4eYuhhvi55Ex/7/0j5M8dt8LFcN+uQFq58K6nPSFSrjmoNp4xMdmcTVK0fznFDw0xAnDmlzMQi0Mvxt3cLhQQ6SH8vUGanBVVIzW8/6XIrl14NAUFVu3aRRNpwKriPvuQU3AKwdRZR2gYjNZaqpHkWDxOtW7j5AQrb4EvgI/26hASzOoB0hIc5swV3DNnqqXeX2PjLx0YL7yg2labFFCiE/kawfGA7qgu0s8WipnJoGpeddcgDXkzmIfn8kjWt2Rh/cgzuIVqe9CjcjENas9Hu2sWRoYR73QF9o8p1Jo2Evvrdc4f1PLHMRG54wIUIlPCvPRHZnLTATsBjrro3jHI7qgWNZF0leqqFjfF2juRAnjGhFWAHavCi6ZT6y/S+VA2Ju/bTM3RrcpmLfpN2k6nXEj8aPyJXT8siKD53q5ory8Y7V0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(4143699003)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(5023799004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVREQXk1U1Q2eitsZnBmdjJGVEVFSlU2amtPOCt4TkNJKzNWWU41bFBvUk10?=
 =?utf-8?B?cUticUpUbEZQYmh3SU5VRTltem5jYTR6RG80bENZYWdtRVVYYzJjaEdKWnl6?=
 =?utf-8?B?UXpaMksveHJxSkVmdFhER2NlYlNYK3ZMOXh1Qy9SbnE2UU9nVHpWd1hvaTBi?=
 =?utf-8?B?enBSUGNsMWVkUnV4Rmc4Ly9OSWI3MHpzcWlsejNsT3ZXWVUxd3lFcGp0ckpH?=
 =?utf-8?B?ZTRPWGtUMkpVZXMvbXJYdlEyaEwwdTVYemd0Mm1QWDBvSlpGUU1WaStYRlIv?=
 =?utf-8?B?YkNNNUx5aTJDR290OVl6VW1zYXdKZFNjbDFFVEFCWHZUOU4vWnRLbm43T2hX?=
 =?utf-8?B?akV5ZkhkTDB0UW92UTE4akVibTJjUnpPaGxMVHNkNDhiSUpGNDRlMEl4Rzlk?=
 =?utf-8?B?dUsxSDFXQUQ0ZjJCSG1zZ2VoUVlDS0NVRzV4UnJJbmVoOGtJOFhnLzFXc1l6?=
 =?utf-8?B?WTYxalM1MTBHQTlTczFmdmYrUUViQjFWNW55dFlTb3QwY2QrNTRXOGlPL052?=
 =?utf-8?B?SW9ackYza0s5Y21DQlNlSlNLUHdOcmNEQ3ZaZ25UOFNUbzN2M3p2bGtRY1dq?=
 =?utf-8?B?aFZlVHlzeWo3ZnRkTXV0MTFxbkZrMVVPcU1hallIVnc5SGFDR052TkJKVGN4?=
 =?utf-8?B?bk9iZnZDNENiWnhuWXBPa3NwZ3RKSkRvZUpVTHRtbTdXYUZUaEt5U0FNWlpL?=
 =?utf-8?B?SGFjOTZtVEpaMTd1cVNqODN6QXlRRHFSSTBNaEhNRzFhUElJM1ZrcUs2dGxh?=
 =?utf-8?B?VFIyMWhWRWRvSzMzWUhWWFkvVkdMNi9mVEw4YldFRS9HengyVXdtdXd5djVW?=
 =?utf-8?B?OVIyRGtraG1TZndxSjJvdjBsRm4zdVo4aVUrQXh1aFE1ZFpudHhtY3NiY3I1?=
 =?utf-8?B?TTgxTWlkSkxmOFZqcGxMUzdLNTZ0RXZOWmlHMUdGT3lDQ203cmU5c0l5QlpB?=
 =?utf-8?B?Qm43ZGh0RFlULzRoYks1bnBuRGh6MkFqYWhHR0xZbTRBZ0cxaXF1cDRVNXJl?=
 =?utf-8?B?dm13MHlwOGN5SVU2NWxaeFEzTHFCZVRhSHZFSTdLVnFJckpUeG9mZzNUanlZ?=
 =?utf-8?B?WjdDL2M0NzU5b0hFS3N3bUk0dTNpbHhMZ2h2RTVyelh2SVdYdWR5Q1pNMFJY?=
 =?utf-8?B?WWllUU92NFRVdFFkNnJvV0czR0dlSXJmYXJBanNLbkJjZ1g2bDlZcFFSVkox?=
 =?utf-8?B?ZWZiYTZkYXRQSHR6cGdTOWxlbUhxZXliaXJMTVNiSEVaSUgzTDZBTGZGZzRq?=
 =?utf-8?B?VmxMZU5mVEJhN3B2YTNoQUc3YWZoTFV1dGgxTDgvUmsydnpML2J1RTZHQkoy?=
 =?utf-8?B?Nk83eWdhN0RKWlFMdmFOSmoyVkxFRHFSUkdNLzFiQkpWbkFOcTY4UFZpZzE5?=
 =?utf-8?B?cTRiZW56cnJkRnNJbnR0OFNGSGlSN1NpTkxuSVZsOG9tSGVjcStqZnU0RDlw?=
 =?utf-8?B?RXp3ZmRQZjdLbmlMbkpFQ3ZVRnphbXdxS21sQ0RwZ1FmZXdBNFN5dGlIN1dK?=
 =?utf-8?B?N1l1aXZEVzZBVDZCL1VjWFdzd1hUbnhiR3ZJQTE3M1VSYUljTWJac0tLd3FZ?=
 =?utf-8?B?WVkwc1l1SUc0c0RrVGZGSUUzUUlkNGJIU0VsL2Y1VS9acXJUWWFjUmUzV0Jz?=
 =?utf-8?B?MUJkQXd6RVVBdGc2MXZZaUNSOHArR2pQS3V0U0RPMHJMcGg4L2x6YXZuQlBB?=
 =?utf-8?B?RElmbEtlUDhpcFpvNVBhR3hLRk5GMldJaXlBRGFTTytvM3FVMXlJOHJQcURj?=
 =?utf-8?B?SllXbFdKaTdremtjSDIrc0NOYk1rY0czeXdabXltYWlDTzZRaURNNS9Jdmk2?=
 =?utf-8?B?cGZqS3Y5RkZGVlVxb0U4b1ZDUDJ5cUhFMmNwbEcxaENsUGZxWFAxdmJqRG8z?=
 =?utf-8?B?bWViczhOc0ZMeWNMK1dpeXJRR3pBRTIxdi9FMDUxTXV0ZE44ZkZyamtab2dJ?=
 =?utf-8?B?Wm1saVdqNWt0T0VsR1d3ZU5JY3RIbEYxbW45djNCZTdlREsyNUFLdThyS2xN?=
 =?utf-8?B?TG8zbmc3dHpGS2kwTkdmMzBmL0pSVUFpbkFVSGxLZWVGb1puMzNQamVoSElT?=
 =?utf-8?B?WENKQkd1MWdzdDM3U2w3amVkZHVRWUc1ZWZucFNKdVYvVUY3VXJ6Z2VYUkhz?=
 =?utf-8?B?emVWNklMS0IvcWFpVStMdWhtOHlWcmZWNDlpZUhJbllEYjlPeEVKZ0p4akxo?=
 =?utf-8?B?S1hTd3pyaTZCenByM283a3EzT1dZSk9zSzZyeFRzeVNnNTIySnlvOVhVNXI3?=
 =?utf-8?B?cVRCZVE2MnpnOUEvMnRqbEZoRWZ2eng4a1ZuZU5KeDhGWTlVMVMyaFB2a2gw?=
 =?utf-8?B?WmgrQ1VZRy94Z0UxS0dVQVZYbGNxdzlmNVZSS3FSWjVlZW1FTjJNS3dEbHFO?=
 =?utf-8?Q?71txqS+3ezRa7Ptw=3D?=
X-Exchange-RoutingPolicyChecked: Er5TZ8LoRNzoViYPhzDMp547t4pC7gfSaDtsU/pa9wrF8IeItDqjht0sBN5i+47U6r4twD16UCcl0vno4YnSxr9k8wkwghqieNryJ9M3OQNGxyoysCUeoJGUcx5x48UVjTZtkt6fTBFx+dHKEW/nXPuCV08L4DQGR2OlXYpp9EJBCGCGB3cBkUAS+v2OFlJaPI9DmIC3CcgnmiNgpgkNiqVnoFZv/Oz6z7FHIxjGBYkmd/SUqoNBW6qak294SxBwJLHf4Xm6CxGB5KHnEWC4uJ0KhAYVZC/K8g+MNVzjvMetoB73qMP1L9Y8EkmSGpHjXUAk/9C0Aa6ahSPI6Z+6mQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8397983-83f6-4846-5b2a-08df0e6330b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 11:12:09.2107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNuSw2j4i0ya8bij/KEb+gHZwtB6D05WEtGIYDwoIJ5co2KdWJOgCq5kIg2Q0yw+RW0/ZnXNPDPdGEgiIIPnhqGDBxNyE3g1afcdaHxyhsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH4PPF89970358F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEyNSBTYWx0ZWRfX3YH0lTdk6Ikd
 CUzRgPtftkl020kkLXmm38TnOKS/3+zkH9wnCj0ozHMawMEcWOfrJgntPSAO5wZ/cW1PEo+tNoZ
 8uvO5y6Lcz4FcKcgcAW67cnzzmp+A71+mBTK+GFbyd73B3GW4A1mTCsdilngTDY43tzMa3t+p2h
 5DYtIBbpgu0o0oTIMhqVnf9rkwI0MOi1EVguHaW1I08dk0E2zL0xzQUO6iesol9U6t8jhL+IsSw
 MYNJ2YxSl2+HkMSQ/5IMLoT0ZacsMWG1g+DhVqmFtzSwyNr8whiLmadKZxo3QyNJ3838cXSlKBf
 gIXw0gExJdQXNGf1IvDTvja6+TYBT/E/LMUsjciZ0ON3UFWx7chnzKhR6at1CcjDc6Ra8gF1whk
 U74RTU7UNlmot8/VzJo40MxgpJ89JbmS2ZIFWXuh3zptH2pGrKEJDuTQ9A2TFISZtjMreq9Nelw
 bht5pBL8M/SNgu/n/mw==
X-Authority-Analysis: v=2.4 cv=d7fFDxjE c=1 sm=1 tr=0 ts=6aa13f0a cx=c_pps
 a=p09nrIMaU8oQorgrX9pGYA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=440cDlBIAAAA:8 a=69wJf7TsAAAA:8 a=p1vXxqlgy6Ndh4yo7IwA:9 a=QEXdDO2ut3YA:10
 a=d9D1X1bx8dWolqnE4HNT:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: d7oqpkm66fy-wCLif9RhHsQaPy2_O6gv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEyNSBTYWx0ZWRfX+w09NWFqRG8z
 fEiAbi/McDwjrUqGXuEPvLNCx7hsKBRg3EZ9j7/bR0IaPYKWXNa6wRr2+8MbS5CtixnKSqcdzsV
 G9PMmYM+CYWKFfBus35Oyp540ZUz41k=
X-Proofpoint-GUID: d7oqpkm66fy-wCLif9RhHsQaPy2_O6gv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
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

On 09/09/2026 11:55, Kuan-Jui Chiu wrote:

> This patch adds new model for Axiado SoC AX3005 which supports
>      4 Cortex-A53 ARM64 CPUs
>      Arm Generic Interrupt Controller v3
>      9 Cadence UARTs
>      1 SDHCI controller with PHY
>      8 Cadence GPIOs
> 
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> ---
>   MAINTAINERS                 |   2 +
>   hw/arm/ax3005-soc.c         | 226 ++++++++++++++++++++++++++++++++++++
>   hw/arm/meson.build          |   3 +-
>   include/hw/arm/ax3005-soc.h | 102 ++++++++++++++++
>   4 files changed, 332 insertions(+), 1 deletion(-)
>   create mode 100644 hw/arm/ax3005-soc.c
>   create mode 100644 include/hw/arm/ax3005-soc.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7183babd6a..deddcc4eed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1305,8 +1305,10 @@ M: Kuan-Jui Chiu <kchiu@axiado.com>
>   L: qemu-arm@nongnu.org
>   S: Maintained
>   F: hw/arm/ax3000*.c
> +F: hw/arm/ax3005*.c
>   F: hw/*/axiado*.c
>   F: include/hw/arm/ax3000*.h
> +F: include/hw/arm/ax3005*.h
>   F: include/hw/*/axiado*.h
>   
>   AVR Machines
> diff --git a/hw/arm/ax3005-soc.c b/hw/arm/ax3005-soc.c
> new file mode 100644
> index 0000000000..e555b156f4
> --- /dev/null
> +++ b/hw/arm/ax3005-soc.c
> @@ -0,0 +1,226 @@
> +/*
> + * Axiado SoC AX3005
> + *
> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "system/address-spaces.h"
> +#include "hw/arm/bsa.h"
> +#include "hw/arm/ax3005-soc.h"
> +#include "hw/misc/unimp.h"
> +#include "system/system.h"
> +#include "qobject/qlist.h"
> +#include "qom/object.h"
> +#include "hw/core/boards.h"
> +
> +static void ax3005_init(Object *obj)
> +{
> +    Ax3005SoCState *s = AX3005_SOC(obj);
> +    Ax3005SoCClass *sc = AX3005_SOC_GET_CLASS(s);
> +
> +    for (int i = 0; i < sc->num_cpus; i++) {
> +        g_autofree char *name = g_strdup_printf("cpu%d", i);
> +        object_initialize_child(obj, name, &s->cpu[i],
> +                                ARM_CPU_TYPE_NAME("cortex-a53"));
> +    }
> +
> +    object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
> +
> +    for (int i = 0; i < AX3005_NUM_UARTS; i++) {
> +        g_autofree char *name = g_strdup_printf("uart%d", i);
> +        object_initialize_child(obj, name, &s->uart[i], TYPE_CADENCE_UART);
> +    }
> +
> +    object_initialize_child(obj, "sdhci0", &s->sdhci0, TYPE_AXIADO_SDHCI);
> +
> +    for (int i = 0; i < AX3005_NUM_GPIOS; i++) {
> +        g_autofree char *name = g_strdup_printf("gpio%d", i);
> +        object_initialize_child(obj, name, &s->gpio[i], TYPE_CADENCE_GPIO);
> +    }
> +}
> +
> +static void ax3005_realize(DeviceState *dev, Error **errp)
> +{
> +    Ax3005SoCState *s = AX3005_SOC(dev);
> +    Ax3005SoCClass *sc = AX3005_SOC_GET_CLASS(s);
> +    SysBusDevice *gic_sbd = SYS_BUS_DEVICE(&s->gic);
> +    DeviceState *gic_dev = DEVICE(&s->gic);
> +    QList *redist_region_count;
> +    SysBusDevice *sdhci0_sbd;
> +    DeviceState *card;
> +    DriveInfo *dinfo;
> +
> +    /* CPUs */
> +    for (int i = 0; i < sc->num_cpus; i++) {
> +        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 1000000000,
> +                                &error_abort);
> +
> +        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
> +            return;
> +        }
> +    }
> +
> +    /* GIC */
> +    qdev_prop_set_uint32(gic_dev, "num-cpu", sc->num_cpus);
> +    qdev_prop_set_uint32(gic_dev, "num-irq",
> +                         AX3005_NUM_IRQS + GIC_INTERNAL);
> +
> +    redist_region_count = qlist_new();
> +    qlist_append_int(redist_region_count, sc->num_cpus);
> +    qdev_prop_set_array(gic_dev, "redist-region-count", redist_region_count);
> +
> +    if (!sysbus_realize(gic_sbd, errp)) {
> +        return;
> +    }
> +
> +    sysbus_mmio_map(gic_sbd, 0, AX3005_GIC_DIST_BASE);
> +    sysbus_mmio_map(gic_sbd, 1, AX3005_GIC_REDIST_BASE);
> +
> +    /*
> +     * Mapping from the output timer irq lines from the CPU to the
> +     * GIC PPI inputs.
> +     */
> +    const int timer_irqs[] = {
> +        [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
> +        [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
> +        [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
> +        [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ
> +    };
> +
> +    /*
> +     * Wire the outputs from each CPU's generic timer and the GICv3
> +     * maintenance interrupt signal to the appropriate GIC PPI inputs, and
> +     * the GIC's IRQ/FIQ interrupt outputs to the CPU's inputs.
> +     */
> +    for (int i = 0; i < sc->num_cpus; i++) {
> +        DeviceState *cpu_dev = DEVICE(&s->cpu[i]);
> +        int intidbase = AX3005_NUM_IRQS + i * GIC_INTERNAL;
> +        qemu_irq irq;
> +
> +        for (int j = 0; j < ARRAY_SIZE(timer_irqs); j++) {
> +            irq = qdev_get_gpio_in(gic_dev, intidbase + timer_irqs[j]);
> +            qdev_connect_gpio_out(cpu_dev, j, irq);
> +        }
> +
> +        irq = qdev_get_gpio_in(gic_dev, intidbase + ARCH_GIC_MAINT_IRQ);
> +        qdev_connect_gpio_out_named(cpu_dev, "gicv3-maintenance-interrupt",
> +                                        0, irq);
> +
> +        sysbus_connect_irq(gic_sbd, i,
> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_IRQ));
> +        sysbus_connect_irq(gic_sbd, i + sc->num_cpus,
> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_FIQ));
> +        sysbus_connect_irq(gic_sbd, i + 2 * sc->num_cpus,
> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_VIRQ));
> +        sysbus_connect_irq(gic_sbd, i + 3 * sc->num_cpus,
> +                           qdev_get_gpio_in(cpu_dev, ARM_CPU_VFIQ));
> +    }
> +
> +    /* DRAM */
> +    memory_region_init_ram(&s->dram, OBJECT(s), "dram", AX3005_DRAM_SIZE,
> +                           &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), AX3005_DRAM_BASE,
> +                                &s->dram);
> +
> +    /* UARTs */
> +    const struct {
> +        hwaddr addr;
> +        unsigned int irq;
> +    } serial_table[] = {
> +        { AX3005_UART0_BASE, AX3005_UART0_IRQ },
> +        { AX3005_UART1_BASE, AX3005_UART1_IRQ },
> +        { AX3005_UART2_BASE, AX3005_UART2_IRQ },
> +        { AX3005_UART3_BASE, AX3005_UART3_IRQ },
> +        { AX3005_UART4_BASE, AX3005_UART4_IRQ },
> +        { AX3005_UART5_BASE, AX3005_UART5_IRQ },
> +        { AX3005_UART6_BASE, AX3005_UART6_IRQ },
> +        { AX3005_UART7_BASE, AX3005_UART7_IRQ },
> +        { AX3005_UART8_BASE, AX3005_UART8_IRQ }
> +    };
> +
> +    for (int i = 0; i < AX3005_NUM_UARTS; i++) {
> +        qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", serial_hd(i));
> +        qdev_prop_set_bit(DEVICE(&s->uart[i]), "brk-support", true);
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
> +            return;
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->uart[i]), 0, serial_table[i].addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart[i]), 0,
> +                           qdev_get_gpio_in(gic_dev, serial_table[i].irq));
> +    }
> +
> +    /* Timer control */
> +    create_unimplemented_device("ax3005.timerctrl", AX3005_TIMER_CTRL, 32);
> +
> +    /* SDHCI */
> +    sdhci0_sbd = SYS_BUS_DEVICE(&s->sdhci0);
> +    if (!sysbus_realize(sdhci0_sbd, errp)) {
> +        return;
> +    }
> +
> +    sysbus_mmio_map(sdhci0_sbd, 0, AX3005_SDHCI0_BASE);
> +    sysbus_mmio_map(sdhci0_sbd, 1, AX3005_EMMC_PHY_BASE);
> +    sysbus_connect_irq(sdhci0_sbd, 0,
> +                       qdev_get_gpio_in(gic_dev, AX3005_SDHCI0_IRQ));
> +
> +    dinfo = drive_get(IF_SD, 0, 0);
> +    if (dinfo) {
> +        card = qdev_new(TYPE_SD_CARD);
> +        qdev_prop_set_drive_err(card, "drive",
> +                                blk_by_legacy_dinfo(dinfo),
> +                                &error_fatal);
> +        qdev_realize_and_unref(card, s->sdhci0.sd_bus, &error_fatal);
> +    }
> +
> +    /* GPIOs */
> +    const struct {
> +        hwaddr addr;
> +        unsigned int irq;
> +    } gpio_table[] = {
> +        { AX3005_GPIO0_BASE, AX3005_GPIO0_IRQ },
> +        { AX3005_GPIO1_BASE, AX3005_GPIO1_IRQ },
> +        { AX3005_GPIO2_BASE, AX3005_GPIO2_IRQ },
> +        { AX3005_GPIO3_BASE, AX3005_GPIO3_IRQ },
> +        { AX3005_GPIO4_BASE, AX3005_GPIO4_IRQ },
> +        { AX3005_GPIO5_BASE, AX3005_GPIO5_IRQ },
> +        { AX3005_GPIO6_BASE, AX3005_GPIO6_IRQ },
> +        { AX3005_GPIO7_BASE, AX3005_GPIO7_IRQ }
> +    };
> +
> +    for (int i = 0; i < AX3005_NUM_GPIOS; i++) {
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
> +            return;
> +        }
> +
> +        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio[i]), 0, gpio_table[i].addr);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio[i]), 0,
> +                           qdev_get_gpio_in(gic_dev, gpio_table[i].irq));
> +    }
> +}
> +
> +static void ax3005_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    Ax3005SoCClass *sc = AX3005_SOC_CLASS(oc);
> +
> +    dc->desc = "Axiado SoC AX3005";
> +    dc->realize = ax3005_realize;
> +    sc->num_cpus = AX3005_NUM_CPUS;
> +}
> +
> +static const TypeInfo ax3005_soc_types[] = {
> +    {
> +        .name           = TYPE_AX3005_SOC,
> +        .parent         = TYPE_SYS_BUS_DEVICE,
> +        .instance_size  = sizeof(Ax3005SoCState),
> +        .instance_init  = ax3005_init,
> +        .class_size     = sizeof(Ax3005SoCClass),
> +        .class_init     = ax3005_class_init,
> +    }
> +};
> +
> +DEFINE_TYPES(ax3005_soc_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index bcc068de04..b6a036c953 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -111,7 +111,8 @@ arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
>   arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
>   
>   arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
> -  'ax3000-soc.c'))
> +  'ax3000-soc.c',
> +  'ax3005-soc.c'))
>   arm_common_ss.add(when: ['CONFIG_AXIADO_EVK', 'TARGET_AARCH64'], if_true: files(
>     'ax3000-boards.c',
>     'ax3000-evk.c'))
> diff --git a/include/hw/arm/ax3005-soc.h b/include/hw/arm/ax3005-soc.h
> new file mode 100644
> index 0000000000..2a383a8084
> --- /dev/null
> +++ b/include/hw/arm/ax3005-soc.h
> @@ -0,0 +1,102 @@
> +/*
> + * Axiado SoC AX3005
> + *
> + * Author: Kuan-Jui Chiu <kchiu@axiado.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef AXIADO_AX3005_H
> +#define AXIADO_AX3005_H
> +
> +#include "cpu.h"
> +#include "hw/intc/arm_gicv3_common.h"
> +#include "hw/char/cadence_uart.h"
> +#include "hw/gpio/cadence_gpio.h"
> +#include "hw/sd/axiado_sdhci.h"
> +#include "hw/core/sysbus.h"
> +#include "qemu/units.h"
> +
> +#define TYPE_AX3005_SOC "ax3005"
> +OBJECT_DECLARE_TYPE(Ax3005SoCState, Ax3005SoCClass, AX3005_SOC)
> +
> +#define AX3005_DRAM_BASE        0x80000000
> +#define AX3005_DRAM_SIZE        (2 * GiB)
> +
> +#define AX3005_GIC_DIST_BASE    0x40400000
> +#define AX3005_GIC_DIST_SIZE    (64 * KiB)
> +#define AX3005_GIC_REDIST_BASE  0x40500000
> +#define AX3005_GIC_REDIST_SIZE  (768 * KiB)
> +
> +#define AX3005_UART0_BASE       0x33020000
> +#define AX3005_UART1_BASE       0x330A0000
> +#define AX3005_UART2_BASE       0x33120000
> +#define AX3005_UART3_BASE       0x33020800
> +#define AX3005_UART4_BASE       0x331A0400
> +#define AX3005_UART5_BASE       0x33381D00
> +#define AX3005_UART6_BASE       0x33381E00
> +#define AX3005_UART7_BASE       0x33381F00
> +#define AX3005_UART8_BASE       0x330C0000
> +
> +#define AX3005_SDHCI0_BASE      0x46000000
> +#define AX3005_EMMC_PHY_BASE    0x33301C00
> +
> +#define AX3005_GPIO0_BASE       0x33000000
> +#define AX3005_GPIO1_BASE       0x33080000
> +#define AX3005_GPIO2_BASE       0x33100000
> +#define AX3005_GPIO3_BASE       0x33180000
> +#define AX3005_GPIO4_BASE       0x33200000
> +#define AX3005_GPIO5_BASE       0x33280000
> +#define AX3005_GPIO6_BASE       0x33300000
> +#define AX3005_GPIO7_BASE       0x33380000
> +
> +#define AX3005_TIMER_CTRL       0x48016000
> +
> +enum Ax3005Configuration {
> +    AX3005_NUM_CPUS     = 4,
> +    AX3005_NUM_IRQS     = 224,
> +    AX3005_NUM_UARTS    = 9,
> +    AX3005_NUM_GPIOS    = 8,
> +};
> +
> +typedef struct Ax3005SoCState {

The explicit typedef is not needed here since the QOM helper macros add 
it automatically.

> +    SysBusDevice        parent;

As per our documented naming conventions at 
file:///home/mca/src/upstream/qemu/build/docs/manual/devel/style.html#qemu-specific-idioms 
this should be parent_obj.

> +    ARMCPU              cpu[AX3005_NUM_CPUS];
> +    GICv3State          gic;
> +    MemoryRegion        dram;
> +    CadenceUARTState    uart[AX3005_NUM_UARTS];
> +    CadenceGPIOState    gpio[AX3005_NUM_GPIOS];
> +    AxiadoSDHCIState    sdhci0;
> +} Ax3005SoCState;
> +
> +typedef struct Ax3005SoCClass {

No typedef required here either.

> +    SysBusDeviceClass   parent;

This should be parent_class.

> +    uint32_t            num_cpus;
> +} Ax3005SoCClass;
> +
> +enum Ax3005Irqs {
> +    AX3005_UART0_IRQ    = 112,
> +    AX3005_UART1_IRQ    = 113,
> +    AX3005_UART2_IRQ    = 114,
> +    AX3005_UART3_IRQ    = 170,
> +    AX3005_UART4_IRQ    = 208,
> +    AX3005_UART5_IRQ    = 209,
> +    AX3005_UART6_IRQ    = 210,
> +    AX3005_UART7_IRQ    = 211,
> +    AX3005_UART8_IRQ    = 212,
> +
> +    AX3005_SDHCI0_IRQ   = 123,
> +
> +    AX3005_GPIO0_IRQ    = 183,
> +    AX3005_GPIO1_IRQ    = 184,
> +    AX3005_GPIO2_IRQ    = 185,
> +    AX3005_GPIO3_IRQ    = 186,
> +    AX3005_GPIO4_IRQ    = 187,
> +    AX3005_GPIO5_IRQ    = 188,
> +    AX3005_GPIO6_IRQ    = 189,
> +    AX3005_GPIO7_IRQ    = 190,
> +};
> +
> +#endif /* AXIADO_AX3005_H */



ATB,

Mark.


