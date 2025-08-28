Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24CAC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraXX-0008Eu-2M; Thu, 28 Aug 2025 07:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXU-0008Ce-RS
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraXT-00059t-5Q
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:11:32 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S8Ouf81758401; Thu, 28 Aug 2025 04:11:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=JkAP3cMirRl48ga9I7leI0o1jCthDMzhQx2D4lpW4
 bA=; b=ODeC6TVYdct2EX82Mx9pRovg5pzXu1eaiOX55bEki67YeUr8shSqb1I63
 nnbj6bDoOIAMP+w3X3N+6/nP3MyZRBic6l4rRQmMIqmij89rbu6aUTS2Z3ZoScZB
 Rd63HyiuVsmYEjHwNpMaL7r3z8d31B0Sf0uonJ81z3ob33hbq2aAN9AJSIWLBLwE
 xM+9ranp0/B1/dEPwYLAz/HODaF0y5fOWLT1ZiV9aLEw0HpqDuWmMfMQ9w7RZKT6
 pwhJsp8jPw9USZNgX46u6R/tL/dGO/lIWGFLn92DVQxryMw8S4v36OvVw/noQi0Q
 XqFXiOjDUxf4q+KqhgWt22DWdnLaA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022080.outbound.protection.outlook.com [52.101.43.80])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48t00vjx23-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:11:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzHzWi4djPI9kExLlQHfv52jup4/OphEW+FuCc9eh/O+taiNMr+MESGIChPBZ5iBiQgHER18+/6MQPxZ1mSWAqg/mci/gu25GHND4EfuM5Ivz/Q2KNlFw2ZLJyLRWZz7L7StG+rDsoQh38S2iTrRXysZifHIKbSDvPV0ZoWAxFDcTEjtWcZ5LdhKxVLKNt5bMdxLss8A93vNBHhwssQ/Y+NCnPeBCWDmzkg2iJujuSAB47C0eIFxV9mPENCrOfeFXbXRMJSEYL60YwecuOu1Ic4PJXuB2WnO8Q1eL19KsDIbkLrhWOimKbGrm3o95HCQyhUpFgengHsQQI6cX7627g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkAP3cMirRl48ga9I7leI0o1jCthDMzhQx2D4lpW4bA=;
 b=cHzXV+NAzMM4L8+0fzjUVH3aPm8/HloVNIk7rc5cx+ufjJPApnl4/ED/bXwWOCmmlFFFXEoeFgtKZYHQPNIC8PEEd4gQGX6S60wclkN6ikJyC3Q4CCa/BzPEy4pJwIduviy8Lq1mNGoN21hso3fhkadLgeVJ3GhRmzHh7r7m8xJ5SGfBr+Pp/5PKTn5dpzwLXHLX3Fr5rfak2tYcNCof5+Rqv2HOyfbT6ISKAJMQNU8HlalrvZTGRt0iaXlQI72+7HfW/EJhAfPZQL6NOaCuyGusWuuw9fyflOCplMME787Dj9WPJmynVMuas+Sd3jMMN5PusRwJlgnVdIZAlsmFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkAP3cMirRl48ga9I7leI0o1jCthDMzhQx2D4lpW4bA=;
 b=T4LAcfacBVP5YAGx3LqRbCDwI0fVD1tPr60hhft7mkgpyvYcnErPkDfVhscLROGvG3/wPS2zUjHIXE73qDYm8uelWLpMf4uc7wCdawOY5EP2uuCPnSGrnkE8CX9eHgzIwxbtSeQdZYg+c+8Tpbm9tcU6/VPKLExoaPhTqAExcKYV06R0KCXRGId3g133qToh/Gw/RspQYSYfPZcxUozUhVATBo3FXiRKCSkdMDhxJetJ6HQhrc4kKW6rRcJ28m9XeiW1ahJFYkf+CzoKfvu1UobtaNJNnKBrcCdvDQWep9MkEC32ujykFPb/B2V1iP+MTEHv7+mg3Qoal9MwsIrv3A==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:27 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:27 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 08/19] hw/i386/pc_piix.c: remove SMI and piix4_pm
 initialisation from pc_init_isa()
Date: Thu, 28 Aug 2025 12:09:51 +0100
Message-ID: <20250828111057.468712-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P251CA0026.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::31) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 616af61d-7820-46c5-498d-08dde623a235
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzdkY2tGWU5sTTFsNWZYUjczcmxNUnJyeGkvRG1WU1N6WTNCaHJPV2pXQk1T?=
 =?utf-8?B?OXp4LzBSRy9hUXFtNEcxLys1S3ZROGVPYWpHQy9iWHNsTWptNmM3SHpHT0tE?=
 =?utf-8?B?bWtOcFJVRjMrV3ZRQjJEeTdRUkdwa0twUFZpeVZ5WFFJb2pvMzc3bXM0TTNP?=
 =?utf-8?B?MlVIMjFkdDVWMHhZeEhud2hrSHJMSXFLaFIyaWpvM3V6RDZ0VG8zb1FxZ1ow?=
 =?utf-8?B?UjVWREtXVEhaa3ducU1ZQnRSVnFDaERrWFlaNXNGVFo2aUZvVm52SFkwYjI0?=
 =?utf-8?B?UUZORkRsS0doSHBic2VuYmQrakp0anNMM3dxaHVBYVdjN1plVEw4dFVkOTJQ?=
 =?utf-8?B?Vkh3OW12b1pPU0s2VkpseHZ3VURzK1hLelRVdTFkWStmWG5aSFdWWTlkMzEx?=
 =?utf-8?B?Y3p0SDdwSUFYZEtVckVIc0RZQXJScUtjL2VuUyt5WDNhMTFkN0ZyeWd3d0pB?=
 =?utf-8?B?SFZlZUdoZkhLUk1tTExPTDFqdU4vRm5JQW95YVhGbkFadHRheXY1SnJsaXZG?=
 =?utf-8?B?MkZrd1FQaTVuYkxJK2F6L0krdUg0a2JoS2NJYUl2SGljcmpOWjBjem4xSDlp?=
 =?utf-8?B?cTNDTG01d3hIcEF5L0Y5L2tNdWtMOWN3ZitVallTc3l4MDZLZEVvWFVuQ2Mx?=
 =?utf-8?B?VkxKcVBjUzdINGFkbndHaHhBMTAxemVZVS9GbkZTZk41a2l5b3VtU2FHdjlq?=
 =?utf-8?B?RWFHMEI2OHRVMTNZayt1RlZpUkFmTUMzd2JaRENDNCtKN0ZpWTNqYytVUlAy?=
 =?utf-8?B?RG8xZXpqV21kUXIwOVFZN1lBWklHVStkMHJ2WWs1dzdldlFoWkN2Und3MHJV?=
 =?utf-8?B?UXltWlZIZ0U0ZUNEdGlPL2JzTWk0ejdra3JGenN6VHRmd3RUYkFwYnRWTHBP?=
 =?utf-8?B?dmcrWEdwRk02MjJHN3FGeE1rL1d3NEdWZFBJc044MFJCUUd2bVV3OEVUK1g5?=
 =?utf-8?B?MGVMQnl2dHp1YW9jaHUrTGxzVDNGenRNb1BJbll3emxwTk9UMUxuOEMxYkhU?=
 =?utf-8?B?bnJyOWlHRHlDVlBRTzZTcmVQajVmRmRjT291QjkrOE5HQjRYOTh1TTQrZlVH?=
 =?utf-8?B?YTU2TUpMOHJHYkozcWt0b0lvUEtIT0lsVVI2Q2svdytpVnd5cm9ZUEd6Y3Ni?=
 =?utf-8?B?SGpwWXV4RWx0c3RoVGNQMGU1Rm1nRlkzWVZWaHN4bjVZbVdMckxhTFpLNlBm?=
 =?utf-8?B?TVY1d29yaytIM2hlWllEd2x3UjlHRERCendMbWU4SkxOS2lqRVhKUFVNMzdL?=
 =?utf-8?B?WjNyekoyQms0WnRLNmwvY0xhb0w3ZW43ZVdsVENZdUNyMzQ0cE9tNVh4ZlEr?=
 =?utf-8?B?RW01Yk8vRjlOb0dXRDNUMlFiYWhKQUgrcy9NSnZFdi9XdSt3Uk5ZYWJ4REIr?=
 =?utf-8?B?bkwxSFVod2dkZzFGR2JscnloMitES0pmNm4rN0d0TFVsZFdrVUNnUnVQdmI1?=
 =?utf-8?B?UTRIWFUwSUEzeUhnVG1NTDZMbGNOK01pUER3Nm5BYXlOWUZIL3Z1UHNIYWIv?=
 =?utf-8?B?V2ZiazQwSkNZQXdtSlB1bGprZHVNTUVCM2o4VE8wditrTEM0UnZvWnFKNG5x?=
 =?utf-8?B?TGNoZ3VKL0pFNVd5aWQwSmZreGthd1RPMHhGckZxYUtYM2UrZ0Q2YWd4K2ti?=
 =?utf-8?B?OTdJc0JKVDdRZDZocUpUTXBJWFhIdkR1c0JiRENpaXZEcVpqb2Z3Z0o5S1BG?=
 =?utf-8?B?bnRUSGd5TmVpa0NIaVFGVUg0YkdHak5MN25rTEV0aFpheGdUZnJ6Zll2T2xu?=
 =?utf-8?B?N1pNNStaK24xd2dweGI3cHV2UkJ2K3FCWFZYdnlGMVpncGVvaTdJbWtBOTZ0?=
 =?utf-8?B?U3RiYkZ2MzhORkxXcDJzSTc2ZlZ3VHFPYmRFczl4WFBTaFlhbUhBTVN6ZS94?=
 =?utf-8?B?MmJURkUvT0JCRDV1RFdINE1Da05lb0lTZ25mVUJ0cE9kcjMxTTl2MzFmeXBv?=
 =?utf-8?Q?lQjfKJEAoBo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGw5T0czOHpuTmw4TTNIRU0yZWdidTdPZm03TWJXNUNUMUVNanJIUlQrSjU4?=
 =?utf-8?B?QUxmdExsaTROckNFc25TdnNVS2lYTmxQNUhXYkdjSEhPaWswUDNhNkd6UGJZ?=
 =?utf-8?B?aytHU2NuendxT3EyNFcrcjBhRXNqY2lnLyt5VGhkb2FqOEc1WEkwQUNpVlVw?=
 =?utf-8?B?VTRuZGp0QjlaZnJweGJLcTRHVGRDa0JRVGNLWDRPNTFuK2lBUWZUb0NxYTVs?=
 =?utf-8?B?ZnZES29yVG1KRVlZRnQ3WWhYR0VPYy9INFR6eS93MnMzYjJqZ0pBSjFpbUsz?=
 =?utf-8?B?Q0RGbGs1ckJpRXI0UE9JRkVHZ0w4VHppaExRa1N5ZS9tY25JVkl0d1pSb2NB?=
 =?utf-8?B?djlXVUxNM3lNNVJETlhJUkZCMHpTT0d1OXBqQ2pEc2txTTdWRkxReUVxVDFP?=
 =?utf-8?B?MHQ1RUEydVFJN2pHUlQxL3Z5eUgycXNDMTd2ejFWT0xSa3FKUk9pbkpQRnRn?=
 =?utf-8?B?MWNkRU1FRFNZOXBFdHNZTzlkSStSanorMkJNRTFKalpqUDJvYm9EbzVXUnpr?=
 =?utf-8?B?dGVwV1pNTzRXejdHUXl0cHZPZmJOb2VpV3F6YjhJc3NiWmxYYTR4L1JDbGgy?=
 =?utf-8?B?eGM4SDVHOXl4M0JWOGZZVzhMMzZTeXRUbXRNQlpzbTJ4OGswUFQ2NjluMUF5?=
 =?utf-8?B?dm9HblZnNXJDRGZ6T1ZuSEVJU2xNTnkyY3VVcGI4ZzZ5K2FiaHpTWERvenVh?=
 =?utf-8?B?SzdRZjR0UE1ha1FySHo0cHVoK01mck9pbU53bXo3ZER6TGxLUFp2WjlFa0Jx?=
 =?utf-8?B?My90WGdxUmpnMkhjd3c5MjF0VHpMandHakl2UEZwd1MrTmVPTVljVmt5eUcz?=
 =?utf-8?B?Mnh2dDRidHlWMm9QbVZCUjNZK2Qwdm5kM3R4b2FvQTBEZ3RaT3NUeVYreks5?=
 =?utf-8?B?TElreG5aY084bnNSMHdReG1zWGtBaFhYa0xUTEZUUklGc0dVTWo3S2tGblFm?=
 =?utf-8?B?aVdMUzNpR1c0Y3p5dklzMTY2MTB4dGFacStDS3hYWlJsWXAzV3RnNjZycGFP?=
 =?utf-8?B?bE5iU25vYTRPM0VDR1B6Y1llOWErQitFRkN0NGxnTWM1VUNoZll4VnZBVDV5?=
 =?utf-8?B?ZldaaVFZVWp4LzRsSjFQT1FvbVE1aS9FRHJCeCtBY1Vac3BicVlTRTFIUnBI?=
 =?utf-8?B?bUVWNE5hTEQ3WHBCRzEzdjVaTTV0cDRmVHY3ZSs1djlUMm0wamEzd0prb2lm?=
 =?utf-8?B?Vi9yTnByMzJpUjYyNTdBaytBczhsSHJLdng4Nk93NlorRUNxVTN6YnVBenF0?=
 =?utf-8?B?ZEZTVnBIRm10ZTJLbVFTWDIxRG1PZ0NYRmdSVUdYNmlLOHhzWCtZSW1sdXN5?=
 =?utf-8?B?djZIdjBsZUZ6MVd5T1hPZGZxZTljNjh6YktXS0E1dElmOVdlNEpES21UekRE?=
 =?utf-8?B?bUVFYWRwM0svQzdjYVNUM0xLK1F0K0NiOE5uOW5oNjJCZ0pNb0dScHRIMjVV?=
 =?utf-8?B?bzJsYnhVV29HZW1tNDExc0hVTFpkK1k1aUdXa0F6UmVlcjlKWUM3a1NzOUlz?=
 =?utf-8?B?MEJFdjJZNVlPRDlHKzVmeVdMVFhwa1ZqOTBER3paSmZXMmxueXZVWmZ2dE10?=
 =?utf-8?B?ZWt1dHBvUXJHTnVGTE9NSCt4cVRjSXJlWFBHYytGeDFtZng3enl0eWlXU2dO?=
 =?utf-8?B?R1NYQS9YUWlkNHNoYkwxUTkrNUJacUU4ZTRwRWx4S1VDWVE5WDhaL0FjVFBa?=
 =?utf-8?B?cmkrVVh3YjdJTytRcUNTMkZvaGVVT3dsdUtqdEFNb09hL3VIbThoUTVtUVd6?=
 =?utf-8?B?NjNnaFhoWFZqOEo5VHQ5YmZ3anMydVh2c3h4ODErSGFMYk5DQXFiNlErRDdD?=
 =?utf-8?B?bDR2ZHNnZlA0a1BsUU95dFRpRWJPc2lvY2hWYkIxRW9xMnNTRGc5TS9rdWh6?=
 =?utf-8?B?WTEyeHdkRGl3bFlGcWNBZEI5WkkrcmVwampWdllrRUJrTVM0dS9hdWwrSmJn?=
 =?utf-8?B?S2RFS1RGZC80dG82UUdvRVpEdkVjMW1hSndSVmhkTk5pZ3ZyT1ZZVWU5VFg3?=
 =?utf-8?B?a1EzNVpmeGZHK21UWDRxejZWZHVQRTBMQ01zTGtiejhXY1Fma2lhaHdCb0VL?=
 =?utf-8?B?aUZXZ2E1L2x2NE1idVdkcnJrZXkrc3NDdFphMGdpTjFIaThkZ2dWR212NFhp?=
 =?utf-8?B?ZDhkdHQvU0gxckxqdHp2MTNGVHpHTzd6Uk9uY2t2cWtOeVgvVCtCVkxWZ1Zn?=
 =?utf-8?B?WnNrQkltRi85akdSSGZZcUpyeTZWL3hnY2srNXBRSWtnSkpIMkJhWE0rOENO?=
 =?utf-8?B?R3doMEtQK1cyMGxGVHFJNlcyb2VRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616af61d-7820-46c5-498d-08dde623a235
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:27.6928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pib+GXGGE3c4hRwLyH7hB9isoyc7iLtKH4FPRh5Ka7FGQFbFM+540FAXqHirh2SzJsDbyyj5iTfsDGjj19uiEqeuVSeLSxoc+iBTVzHUqPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-ORIG-GUID: rWncA8Y27KMs9JP5DCuPs9TlGgWkGquV
X-Proofpoint-GUID: rWncA8Y27KMs9JP5DCuPs9TlGgWkGquV
X-Authority-Analysis: v=2.4 cv=C9vpyRP+ c=1 sm=1 tr=0 ts=68b03961 cx=c_pps
 a=hSYwUsMu3dPAZ0NekjkltQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=VVXk-92eaM9LjyQm6BwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX+mu32bhub7Pb
 ZHrd3/2xFNJvtCTARdUG75sLrOaDFNtyyGO4ZpSSyy9qY6vDJXjGAbPw4SdH7NDcr7kjFoyeoFW
 bDXmARaoKc88PepgfrOwtSMaUs8rUxMWVGqx/ReFD+7BdRmS5W+YSPMangqGf/FBiGHWs9xZyQa
 jfKlPWYOb/OOW2UbOTwdiDXqQP/sQEPfKDoD6ggvXyyJOg6wpo1lljB4Q8NROTk5BTGdBv3Qo3M
 vCMVGu34fuBT3WzGKMAKDHmS2phZy4Tc957kCobySG7GjcCabwJbduStTQRcCpBI+e6FXtELJdS
 2c/4O4KO4OhcblGmlW1lNUC8nSDX5/JQOJaPeB9MIFIs87Rv/G/N7NXf0u0HIY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
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

These are based upon the PIIX4 PCI chipset and so can never be used on an isapc machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/pc_piix.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5ae265bd53..57b02da5a8 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -441,8 +441,6 @@ static void pc_init_isa(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
     ISABus *isa_bus;
-    Object *piix4_pm = NULL;
-    qemu_irq smi_irq;
     uint32_t irq;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
@@ -618,23 +616,6 @@ static void pc_init_isa(MachineState *machine)
     }
 #endif
 
-    if (piix4_pm) {
-        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
-
-        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
-        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
-        /* TODO: Populate SPD eeprom data.  */
-        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
-
-        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 TYPE_HOTPLUG_HANDLER,
-                                 (Object **)&x86ms->acpi_dev,
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG);
-        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 piix4_pm, &error_abort);
-    }
-
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
                                x86_nvdimm_acpi_dsmio,
-- 
2.43.0


