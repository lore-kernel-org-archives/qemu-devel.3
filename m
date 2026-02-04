Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E191EE9538A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnb7w-0003xb-VM; Wed, 04 Feb 2026 06:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnb7u-0003wt-QV
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:32:55 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnb7s-0001z3-Rm
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:32:54 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6145v7833065163; Wed, 4 Feb 2026 03:32:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=G2FmTdosoNlgzdM2qskRIOi+r0VmsULAiws2Mbh9n
 dk=; b=qv4S8Cr4BGf21lpJqdD7843FYZ9bEV8DQLXCgj3dwPIsauRYfNRjDiODg
 UEyx3p4BfDE9ruvfc8aSBeMi9muMEKGIgRUpaxxc7JaPxIyXcTzKpNtYCWIFZRti
 nln/Egiy/3MtMMXRncW+feBxcOUwnK2a19rj0PP3qoO7KP1R2pdPzfBJU/na0VEA
 TN+avY5PG1mGXVbv9DjEJxEGcmMZBI0PMvgOAOCl0DpJyRje8DKzKHZMczuGHhnw
 hXQ1Lk/T9lGaqDB/lSe/Owv/f3F7yp2jQdmSDdkKo/AQ88sBi8s2198HmdtHuozK
 qixZDh3+kTXUl2GV2VWEVXZ9BnU8w==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022087.outbound.protection.outlook.com [52.101.43.87])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3aydkvw3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:32:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1Fm8wwL/+0IK9vmM1THvQYLaa3/lYZVqIFXrvHHaaXEf8fMyX04fG/SKrd8+HdkFRJgOTVtcHdNhgx4cm7tLx6dRZlWxNTX7xk3s/zY0Cq+HmbW+Dd/sr3dMQIN83opKgjasKJYacukQijWX1Ul8GzM6qaCFNJ/ak5uhc9npS/5zqye/t5M3LI9C5NYGdKsU/we2eW5YuIh52LXJhUdCsUIzTzSlydPn04VEZxr9flOZrK7LOyaQiY7wX2MbGqDcvx5bOTNd/We5lgn3oatlEcQe5u3riI5LsLoFAyIZu7cxd+ZQmuK/iuVNw4506FZ3NpFZAG4oEm7Bf/zRRcz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2FmTdosoNlgzdM2qskRIOi+r0VmsULAiws2Mbh9ndk=;
 b=Ihvu00e5949vz1hkQpdzwG1BOptd2PXFjQFMRxBun0oxvMuERGROyX4kqHfM4Vuax4fo4bs55MIz/Ce8PBviRFXDbyaMBF1q6UncgPSGL/3HYd7bS9EqJxuIoDnnYYXK75qD+GAp4+gXDzeOFqMzUBJLccXG3yQrskfy2jRULfRKytQMk5bKJb9anNcMB6YlAlTVZqEKpMs0cGQWtCE0xSb0/4EbWppkrEMlfkc+kt7QRSoZynhix5C+GwwvPZzLppPt3zRiei9nEcVqv5W4tFzxXeF7DdOdxwY+drNEnuUnP8OHkJWKifY3hpF1SEfft69sXuqtMnjp2TgJy1ahJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2FmTdosoNlgzdM2qskRIOi+r0VmsULAiws2Mbh9ndk=;
 b=jTifRxTHA+eCsrmW5uuwdWNIK6qGX71Uy2f/fno0WvrgXVJMF8tUB1+ACtk6xOxSbROwqHrFwgSGyw84XbiNwgNf6FNWWBwDn1z31RqNPKPHOWv998kaXMFws+zA5oNeWcCM9AKDIcBVpGHVHdTsvR+bPOAK7kjTdf5bPZIjmII4OKgJmUQZknvHiy1zatX+UY+/Fxn2/YYG/6k9Grr5vGRgPT0Brm4WLBraAqG7B1NgRRwU54HogaYY4sCOnQOznyUK2XahnHzbmKYblYVRUMX3Ii9aVyp2+rvpjlvxu3JmHzVyCNpAhETJuUiRbGKM26IIP3ewhp0JUTd5Nuyk8Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB7007.namprd02.prod.outlook.com (2603:10b6:208:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 11:32:48 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:32:48 +0000
Message-ID: <c77444a3-8bfb-44d0-8b6b-b72d59ed4e63@nutanix.com>
Date: Wed, 4 Feb 2026 11:32:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/37] audio: lookup "audio-" object types, and realize
 them
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-24-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-24-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 4801954b-3546-42a6-c07b-08de63e11fb5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVhZaVRsajV0a3RDQTlmRFJySUdGK3VHdytIMUVxZC82ZEI4WVNXcUhvK2d2?=
 =?utf-8?B?MHBXMVQ5Z3pORWZjVDV5aU4yeXg5b1NLY05vMXdVeUh6dzVCcTJad3VtUnls?=
 =?utf-8?B?NWVoV0huUlJsQ3kwNDJJeGc4RnBvNnU2TU02Zjd0QjFrUTRDVElSOXRveUJK?=
 =?utf-8?B?UmhjNDdSNjUyUXlFRmxhRHBNWWRKemhSVE5nVUh6RFFKSnlJalFxTXJCb2da?=
 =?utf-8?B?WWpBeDQ0dnYyZzQwTHJmcTJHdXFxYUV3aTh3VEtHbWtkNDFMSUZEWENEeHdY?=
 =?utf-8?B?bHVHaWxIV3FCalNORnhRWlFRT3MzREk3SExLeElpYmZ5UlJJS3lkenFnYVlH?=
 =?utf-8?B?SXVPTk1jUk9sZU5EZFB5MCtudVdhdk5vOXFiV3c5aUxGNFlKM3J5UFAyZkJh?=
 =?utf-8?B?ZUsyTzhkQnR0UW9WSTRmTjRGeUVraVo0T24zUkE2aVBEbmpONFd0RTlKVGNO?=
 =?utf-8?B?YnQrei92OGwydVFMWnorSzdEWFlzeVJqZGVkK01qVWJtbGRjbWliYlV0ZjY1?=
 =?utf-8?B?bFg1U24vWk1mMXFGZWZuVy90UDA4TEtpQWtIVmxPUDIzOTRqTDYveEx3RFg1?=
 =?utf-8?B?amVpdGlmNGtjKzQrZE5YTXZ6Z3dvdmExVlVJYmRqNmI5VVpCbno1TEFvb1c0?=
 =?utf-8?B?RGdpbldYM05ZUTBBVDk4aXNnTE4zNTJ3Z3NjTCtLbnc1TjZFZlR3Y3pYOTd0?=
 =?utf-8?B?bEpXeHZnSWFoQlh5R2UwanRMQlNkQ2pnQUFhK2JualpnWU9ubENNZjU3OTZM?=
 =?utf-8?B?enlyR0p1M2thRHJlWjlmRHh6YS92R2l1NE9rdWZTcjdZck5GZWZEKy9ncXly?=
 =?utf-8?B?bFFSbDBVK2pWcnoxT2cyRFRDWFhIMjhiVkhSeEhRZnhpdTVLempKTE5qSkRs?=
 =?utf-8?B?KzZPT3htRjVWQmRKaWpINmFKbTNPTlNCVXBwR2lwdGJKMTk1SFpsd1ZmL3Ji?=
 =?utf-8?B?K0NIRkd0cjIvdmp2VEt2QXE2SmdyYVg2azRId2p5dTBNaWRhelFVcGZlOVVL?=
 =?utf-8?B?aVdZVVc0czNkZFFTcm9tbVBPcVdKMExQUVljcGxqUG8xMWNQeFNFRW5OcGRR?=
 =?utf-8?B?eWpSR0YwcGFQL1NsSlJaT3gxV1BGSlZ0SjB0N0JISTNVNDFsa29memVPYkZM?=
 =?utf-8?B?K3dqcmZBeVI5MHdOM21ubHp6V3BpZmlCZHR1MmlVSGZFbE9SY2xlTWlaa3FT?=
 =?utf-8?B?c3ZqdldHcWJWT29LdGFENnMvdHU3UW9jSVhmNU9BcHloeU9JV1Z0amxRYWNr?=
 =?utf-8?B?ZEVVclIwcWRTQVJUMWdRVkIwY1dMU1ZoZWhOVzg1bG5qL3NwK3J4Zi8wbDFY?=
 =?utf-8?B?eGZxWmNna2JmRCsycnoyTHVmMEZ6TjkyL1RrRnBWb0VDUzJBcDBxRUlxdVR6?=
 =?utf-8?B?VURBbEtmV2Y5MzhXRUtkZjROSzgrOUVwdnlJdW1hRGRHSmx0eWE1Q3RCSnds?=
 =?utf-8?B?V25uNkVjZVkvQUdFTS94dXl1eGNmZWNmSVByUU83SDV3QTZHNTJ4TEkyR0lp?=
 =?utf-8?B?dVU5V3RuSEt1QmlGaVZIMks4ZTF6djFxWkx1QzZVUFMydHBVdEE5ZWhXMTVC?=
 =?utf-8?B?ZGlZT0NjNW9JaXF2czhDaGRCSnNnRm5pZHluWlI1WW56cmY4V2VLOXpwaXY4?=
 =?utf-8?B?RFpDaHJlbVQ1KzQxRkpydXV0ODNQYzlud0s2QXorUlFwdkdlTG4wQkFMTXpj?=
 =?utf-8?B?UkYwSFEzRDZpUENxVGFtOUFyanBnYWZKOHJWZWNtMWtuUUZZa1F2MVNsUjIz?=
 =?utf-8?B?Tlc5b1dvNkZ3enlRblZnR3lOYkVnK2trUlpGNGh6Y09LdWs4U2pBMkJFNDUw?=
 =?utf-8?B?SzRRV2p5RUJCYVd3YnZIK2VvTDEwYWxoOGxERTJTWnk5VEVGLy9Nb1pkZlhD?=
 =?utf-8?B?cnIrN0xMSFZxVDZDSmpYNlQrb3M4djkrWThrcmplTklmSFVyejA4aldwRTJk?=
 =?utf-8?B?V3lFcGRZcTZkN3R3OU4ydmZBaS9sd0QrWVdCbGt5NFdRaEpYSEpFYXJ5SFZZ?=
 =?utf-8?B?aVFCLzA5M0JPVVFnODYrYVBVZ25uNDhrQnE3UkkxRWZvVE1yc09MWmd0UWN6?=
 =?utf-8?B?ZHRzMEQ4eG9jd1o5RFp5a05ySjlVUjVYVjVxQUp5bHhnbnVhY095NmpYQnRL?=
 =?utf-8?Q?QuyE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2NLUEhIeFRVRmFQRkcva1lETWhhMmloK1g3QzhvemRNMzFCWmgrK1ByOWox?=
 =?utf-8?B?S2NGSlZjSEJGcUhsV1h1MnE0ZmZwZElqNEdWYmxPWmhmU25Ebk5yMXMxYmNl?=
 =?utf-8?B?Z1dETmFkcEphWjlCeWhpQk9QUmFhREJFczVDcjVmK05obFRxK2puZnVCRm5B?=
 =?utf-8?B?R29Sa2dWTnNJMWxYWFhPZndNeVlqQ1U0bW9iOXZXTWZwazZocFE2Y1dkYTEz?=
 =?utf-8?B?YmZ5c3UrN3BKY3JUUzZyd3JqbURGT0dLL3ZQNDB4TWovTVp3M1VabXc5enc3?=
 =?utf-8?B?VnNNZzNVZTdwVlFVenFZQW9XS0RadzJjVkdZaUJRTlJRSTJ4Vkw0SlpZMnpP?=
 =?utf-8?B?TzB6Nzl0QnNsRnFwY2hWbHZrcSsyNVB2N2NTV2VFQlhkcFhrZVdaOVNBNjU0?=
 =?utf-8?B?cE95WDlwd0lJMWh1eis3dmpobXdoKzN1K09HcmpQR3hqTmQ5R3UxSTlNUEZi?=
 =?utf-8?B?OEJGaVlWcmtWUld3UjVwcmRERUhjTVBqaTNzUXpHbC80VW5hTzcwQmR4VFZM?=
 =?utf-8?B?ZDFKS0R4Vkw2d29HWTYxM0pNNGVnSUthNFh6dTZLZGdhQ2VqRy9rNmNUcWRu?=
 =?utf-8?B?MFQxczRWUURJc2tCYmVjRlZKQ0ZJc0g1NUZKWWRsNXdpWDhVVnEyNVZMajNT?=
 =?utf-8?B?KzNKM1lLODE2SFYwZ3JHK1B5dmh5SHNGbXJreVBZNi83NUhndXEzVnZoU2Z5?=
 =?utf-8?B?dmNzMUtqaEtpajFiU0wwM0wwckE2TFZIS0pEU3I2Y29kSDkzUCtabXRhWkYx?=
 =?utf-8?B?ditIUWsxUTR4cXFIaUEyc1UvTGN3Y2REZUVEbngrTDFSOXEwKzVSS1Nod0l3?=
 =?utf-8?B?V0c3YXE0L29TdjVQdWtnVUhVc2xZRWNOeWxwUlI5ZGtJTFh4WGU3ZmNqTFll?=
 =?utf-8?B?aEJTZmswSEplcHoraUtIK2k3cnpWL2p4VzJMK3IyM1pVVlpKM2ZScEU4djhq?=
 =?utf-8?B?VDFoQ2JHUW9oWXpNWGU1UDZkY1cxU2d0RVRaTldYV1lWajZUS0lvalRzS1ZN?=
 =?utf-8?B?QVQ3VGMxdDQ1a0lmMHA4TmwxT21Qb3VhOThqVjVFd3FBTXJwdXhKSXFQUlRv?=
 =?utf-8?B?QkFBM2J2WCt1MkNaNE5vdnFMYnBBNFgwbml4d1V1d1JweUJodSt1c0lVUzRR?=
 =?utf-8?B?ZXA3bWRXemJIRFYyQlR6MmMrYi9RWVRLTTN1bVVvS01hOGw5aUxHNHlzeW1v?=
 =?utf-8?B?V0FIV1d0TWo0UGJpY2IwTnA3VzBkdWJmNnZGbHFkenVDcU14RUl6T2xGSGp6?=
 =?utf-8?B?dmZHVUg0OHVZOEIwdDg1VktLWjZacHBSakVNNHRjSnBYVUhORmpWZjVPRWR4?=
 =?utf-8?B?cEplbldiYUpCYzlKY3RSNVFMVWM0YzVadDlhRGV1elhhL3FuSExuSnQ4MmNj?=
 =?utf-8?B?TTlNSXkrOSt1RDZuejJGM2hjVkpHVTJKRXI2ZkZVeEJnYTlQbktuNzF0eENr?=
 =?utf-8?B?cWxON2xrem1MQTFLYXFicVJORjdycDJaUWp1UWJNaWY3WEZBak8zUlpsQ0xJ?=
 =?utf-8?B?bHdwdWhGbHlSTzVacGJYazllT1dzOHdQeGI5WkwvUytlN2RSc0pTVHJheU5m?=
 =?utf-8?B?V3pic0F0Nm1ZMGNWalEybmdOMXEwUWxxMHU2MS9MbHhIbEdaQVVtMGNlV2s2?=
 =?utf-8?B?UVgySXByRWVMOSs3aDlaRjlueE9vM3VvMzdQK3UySnd4a20wS1UyUTlQeEla?=
 =?utf-8?B?L3NxMG9jSzN1MUxWVUltajdsL1EwZExmNHJUVjF0WThySE5FcERLSSs5L1Y0?=
 =?utf-8?B?Z0UvY043c29CQTUxL1IvbjRoZWdiZ3V0ZUlNYlhZWFYzdnFwR2dlUUV6UXQ3?=
 =?utf-8?B?UEZYaGpsdUZITTd2V1Z3clFaYmNxUEx1MmdhUGlYb2QyMDhPc3JYdWl5eCti?=
 =?utf-8?B?emMzbjZaUE1TN09XV0U0TTVKUDZ3dUMzRzRHdm4xRU44Q215VitDNURVUXZD?=
 =?utf-8?B?dFZYb3Y3amdRSXJMY1Q5a2NHY3lrVk1zN2RVODhiOUphYUwyaU9pVExxUVE2?=
 =?utf-8?B?MUVGNXA0SUtETE1XSjJqTjVUTndvdUF0VmdRcDBqcnNRY1FjVU5HSitsQzFO?=
 =?utf-8?B?WE1IOTF6V2Y0a3dYMElweVNZdmozUmhMSFVUMHpQdVUzWGJkbDVZblpRMXpo?=
 =?utf-8?B?MkVLUXRDMzdydmZSb1ZremI5M25mYjVWL0FLMTlFcjFjMlF6a1NEd3U3NU5j?=
 =?utf-8?B?RFpDYWM3Y0p3aFhvYk4yRloyMnJGOTZjNTQwSWxuajNoelFucldqeWd5VkNF?=
 =?utf-8?B?QUtRYVpjMUFqeWNPckdTUnhMZEFXOTRISnExdXZwQUZqUW55L0JtbWVmOWZW?=
 =?utf-8?B?ZHlwZkc2YzZsVE43VlN0WFpoWm9NZTRDbHpSQXpOcjdlT21DOFJ3aHhmazJj?=
 =?utf-8?Q?xgU7A3qBD8ltspHs=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4801954b-3546-42a6-c07b-08de63e11fb5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:32:48.4704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWULQDYp400qNFf78DJiDhgB2zQeBSoqEq5LDWrZDe52HMC56NN7ppoGcJdHj+cuahLFJ/JME0QCufPxPqcvxjRCzdtGnK4JSdvhYshr20w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7007
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4NyBTYWx0ZWRfX1blUQt8FD04E
 hVnDQbOa9blyczLBIIPC3MZEcmewrLVrFGCYR3n33DLP2oZXifKg8wV4xwc34OYTAi2O4rCmBI1
 atymPvxtP4DCNDQBdSAq3uVKQZps6RmvC+ta4n4kfhbRRaGA7Y96qhN2o35jXD9Xr+7pbGUKHkt
 y1Va5xLeaIWnqCIoB2S5lkbZb55mES/d0YKA5aTcb26s0OL22P1c4xS9Jm+cpu4zt4TvLRwwjEo
 /da31EB8YnJ7vLCUR4fYKXnjD6SPl4ZOtwV9YlN9W7YOknRTnOo0ZQJ4jkBwOOU1DuCrCVc2OnZ
 4cMVCg1Kg+HTjk3m/5dv4AAZ5qM6wyvnjG1jnreFf/NfDXZ8PgmqOEQo9UVq7anMdbkrgM+Zn/x
 RXxp3v3cWfuIDXGkBatF15IlrxZmzgIbubn4IJ4Y7iYTZU4v9CM6N6U5JaVo/bEpHeZXRE1zvel
 gzq3Nj+XIwJkJ4q3Bfw==
X-Proofpoint-GUID: AZ-xmGrnL5CQrR_i78GZJPcLLmYKi1eX
X-Proofpoint-ORIG-GUID: AZ-xmGrnL5CQrR_i78GZJPcLLmYKi1eX
X-Authority-Analysis: v=2.4 cv=AeC83nXG c=1 sm=1 tr=0 ts=69832e62 cx=c_pps
 a=LzkVVAj3Rd1zMMBobGGGjw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=Cv0I7twWD_uS13YnXiAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Now "audio_driver" is a detail implementation of AudioMixengBackend and
> not required to implement an AudioBackend.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/qemu/audio.h |  1 +
>   audio/audio.c        | 40 ++++++++++++++++++++++++++--------------
>   2 files changed, 27 insertions(+), 14 deletions(-)
> 
> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index 474d761f0be..1eeead2a722 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -51,6 +51,7 @@ typedef struct AudioBackend {
>   typedef struct AudioBackendClass {
>       ObjectClass parent_class;
>   
> +    bool (*realize)(AudioBackend *be, Audiodev *dev, Error **errp);
>       const char *(*get_id)(AudioBackend *be);
>   #ifdef CONFIG_GIO
>       bool (*set_dbus_server)(AudioBackend *be,
> diff --git a/audio/audio.c b/audio/audio.c
> index 7e23a63d401..f6896229cfb 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1561,24 +1561,16 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
>       return total;
>   }
>   
> -static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
> +static bool audio_mixeng_backend_realize(AudioBackend *abe,
> +                                         Audiodev *dev, Error **errp)
>   {
> -    const char *drvname = AudiodevDriver_str(dev->driver);
> -    struct audio_driver *drv = audio_driver_lookup(drvname);
> +    AudioMixengBackend *be = AUDIO_MIXENG_BACKEND(abe);
> +    audio_driver *drv = AUDIO_MIXENG_BACKEND_GET_CLASS(be)->driver;
>   
> -    if (!drv) {
> -        error_setg(errp, "Unknown audio driver `%s'", drvname);
> -        qapi_free_Audiodev(dev);
> -        return NULL;
> -    }
> -
> -    AudioMixengBackend *be = AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
>       be->dev = dev;
> -
>       be->drv_opaque = drv->init(be->dev, errp);
>       if (!be->drv_opaque) {
> -        object_unref(OBJECT(be));
> -        return NULL;
> +        return false;
>       }
>   
>       if (!drv->pcm_ops->get_buffer_in) {
> @@ -1600,7 +1592,26 @@ static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
>           be->period_ticks = be->dev->timer_period * (int64_t)SCALE_US;
>       }
>   
> -    return AUDIO_BACKEND(be);
> +    return true;
> +}
> +
> +static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
> +{
> +    const char *drvname = AudiodevDriver_str(dev->driver);
> +    g_autofree char *type = g_strconcat("audio-", drvname, NULL);
> +    AudioBackend *be = AUDIO_BACKEND(object_new(type));
> +
> +    if (!be) {
> +        error_setg(errp, "Unknown audio driver `%s'", drvname);
> +        return NULL;
> +    }
> +
> +    if (!AUDIO_BACKEND_GET_CLASS(be)->realize(be, dev, errp)) {
> +        object_unref(OBJECT(be));
> +        return NULL;
> +    }
> +
> +    return be;
>   }
>   
>   static void audio_vm_change_state_handler (void *opaque, bool running,
> @@ -1643,6 +1654,7 @@ static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data
>   {
>       AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
>   
> +    be->realize = audio_mixeng_backend_realize;
>       be->get_id = audio_mixeng_backend_get_id;
>   }

I'm wondering if an AudioBackendClass realize() method is the right way 
to handle this, and if instead an object_property_set() function could 
be used to set a "driver" property?


ATB,

Mark.


