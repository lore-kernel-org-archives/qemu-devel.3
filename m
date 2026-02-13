Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966FFEDF152
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqXP-0005Ac-Ao; Fri, 13 Feb 2026 05:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqXN-00059m-Et
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:36:37 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqqXK-00026C-O5
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 05:36:37 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D9r7Fs3534857; Fri, 13 Feb 2026 02:36:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kKKJd8MASm+xzOHajIZKQGbjYAWzvhhiM04xvZ8TT
 x8=; b=xwtSRMHDNcG6djlJ4fKYv4U4K649BE9IMy4P8+CzqlHP/lz/Gz4rkOwrQ
 Lj+h/eizO8dIHYFFnEln7tqmrIcMm0ufnHCuWfmR0+9Ek7dYpVebYhOWssWEFX6e
 LLzRlsANrDkqM0UfyuoH/UpS39p4qYOJtUG0aBnKyu28qU81K2HIWdNkQt37WFU9
 O34+NOwVmuRuBomf0dl6EIost3V3qS60x4EtyXogr8ZSuHhmxKDIcSGO4H1IOjDi
 Sy38vd1Le7xHgr3ZRa6oah1JaF1HPCsMsbhsfQp7sRJaqo3Og4yrnU3ax5XM2D6H
 lfwJOYHgdK9Wve9QafkpcMqddvWTA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020086.outbound.protection.outlook.com
 [52.101.193.86])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8q4d71sb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 02:36:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9YrhBieXvVjgdFFcIrNYJDzap/+J2XZNHQYFkma/rZY8jn7+Y7gs4zX0aXwpTNq8/M4RufIhhx2amh7aU4I/5Sk3PsUVCocbm9nMQjY3XabyqQhkHGSjCcxCqj9bsOjdk2hIgpcAady1NQvo7slTUU66T/iy5qYSS/RvRUW9yOhDubVTmRyne04WtI0HJn9tSwfWCODS2+IlzSEWvdwevoC5LdmJjioRRKLw9XTFJFR+H8UWVN1e7ZtktFrdqDMiYf6drrnZoTD0ZDXIgoannQXmNbwPejhAcVX9O/+mtmXhQfvzl2OVTpryZi2SVfJIi5wNa27xRNBEYOr0JlsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKKJd8MASm+xzOHajIZKQGbjYAWzvhhiM04xvZ8TTx8=;
 b=pSh1OTHs29DgbTwvUSd1MGr4LgjoT+c7op/Wwgidtvsqd5wKKbxv/bkfjy++S5Td8iudF7XDRGRUtIbo9UuReBEbk2GcssGa6iRVHemuo3w6NvUoqgiOylBlB+FhO/4hfXDZvUEMC+DyRZ7jmlnMFv3H7Cfr0I9erZXgrmbe7ZJ2sL9GDh3uedDfP4Akan0hDy5EJPmR3RcNqmH9qQvd0JHv2PXo5bISCYFh1GeMFYI6l7fxUtzILcdWZzS7cirMd2IdOp7OxVTtM5bIXpTBfyKzLWQLj55876qZxvuR5XqTZTqXD3Cv07U72vI6qNJf5W4o6nz6JAxvG7awAK7HIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKKJd8MASm+xzOHajIZKQGbjYAWzvhhiM04xvZ8TTx8=;
 b=k6Mh5CuFPzGsKIj8feuPyvFzQdwOWjUUIM0beiYADH4agECjX1PC6FTQJ88CU9TnmnltShBkbnypZlwHL0pPe5iCY9kCRJxMC2hOd2JTJf1ZBMDhL0HNu8tpASrbxkxOiYcX+KyrRFeLcPIoNk5gBQCj/LgN6f+E1uOUSLDgM2apF+UkoKg8qsnAxsj8KPGpUAm6Z6TleMK3hNlj6E6kWEr92/0eumBaL53h0KTihHu4CdQUAOjiXLBhNXk1hfYHzkZ7+MJCMERGaa9YEHilJZgmVdmh2/l63OsuFVGWZ2QRi8X49jqlVwrYFLL2dOTHIBVaeoqspqp63qAUe8UfEQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8618.namprd02.prod.outlook.com (2603:10b6:303:15d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 10:36:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 10:36:23 +0000
Message-ID: <d262a3c3-050c-4743-8c42-4c205e2b31b0@nutanix.com>
Date: Fri, 13 Feb 2026 10:36:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/43] audio: remove audio_driver init/fini/next
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-15-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-15-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0272.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8618:EE_
X-MS-Office365-Filtering-Correlation-Id: 02fb347b-c3d9-46a3-40ae-08de6aebbb91
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzJHSnRsTXBPMTNoRnZmUE56UXQ1bkF5anhXQ3pWQ0J1d1FBOEd2czI4R2N2?=
 =?utf-8?B?WkRSZlFxdG12YW5ZNEJ5T0NBVzlkbHNYQm9ETFRyRjRORXpuL0Uzd0JCT2dC?=
 =?utf-8?B?M0M4ZlMvcUJZNWthRjhaNnlaOGtqNXFybHFwNEg1VTJvWXJrK0E4dDFiNlA5?=
 =?utf-8?B?dlhlYXZuMXJ4ejU1dERRNHZnRUZFVUdidEJXQlhnV2lXODFtd1JqZEt1ZHZI?=
 =?utf-8?B?RVhJbDd4QWt3cFVrVy9QYnlLZEI1Vml0aFQ1MzFCdVBiYUdZOEV0QUMzTDkr?=
 =?utf-8?B?ZFFUTFc4RkFpYSs5SWhjVFZqb1VGN0gxYXlWVGZkSkxXdkkzYUY5bFhVUW9x?=
 =?utf-8?B?TXRXZ28wbmp2cTdqcnpDakZzZFBlU2F6Y2JYWkhNSDcvamhiN3hBcitsWTgz?=
 =?utf-8?B?RkFoRUFpQ3hGTk1vKzBrbGd4VmR1MEc5eEJ4UkNlK0Mxb2NXaGNHL01ma05S?=
 =?utf-8?B?VFhBa0FEUjQ5MFVIazV0SFZlNFdQMVlYZTM1U05oU05UT2pKQmwzUVJMUnNR?=
 =?utf-8?B?MHZkbEVpNXRMZkthM05nRm0wVmE0M0pMcGFjWGtMYUszTVRxM1Vkcm4ydDJH?=
 =?utf-8?B?TytmeG1HZWdvNTZ2Nmd0enNLWVo4aVZDR01BSkNDRHUvMUNkN2hUalF5WElK?=
 =?utf-8?B?bS91Vkh1Q2REWnZKTFVHSXZuVW5DUk5JODN3cFlEQWNsZzF3UlZXUVZXVEUz?=
 =?utf-8?B?U2hkdndlM0QvM1ZHL09JbmdhTGswSXRyL1czWUJCaVN3R0dsNUF0OU9EVmp0?=
 =?utf-8?B?MzdoUGRTcW8xaWM1MDFKUEJaTVdFOGFlNEh3RmhyVEJtTGVPdXhzT0xacXM4?=
 =?utf-8?B?MGQyQ3ROVlU5NUdIczQzMko3RlE3Y1IvZnNUSkthWGViZ2JkaStEanE4S3lX?=
 =?utf-8?B?L3ZYRDJ1OVc3d09TMmtBS3V6UklEVnlkYTdONHpzZ3ByWG1DUmVuOWlQcW91?=
 =?utf-8?B?QnFRNUUrV2w1bEY1VHNoZ2dNUkZVSzFJZGVubGZYaUpuUmtKNUwyMDNLZk93?=
 =?utf-8?B?NS9kbkVMam5IYzEvYkpCakNFTXVWOVJheGZiLzFTa0FqUjZtVXlreUtOZ1pE?=
 =?utf-8?B?Sko2dWJueGNTSTBGZm9hR0hZdEt4bG81T1RzODk4d3IreDRmWDdXWmR4Qmxv?=
 =?utf-8?B?ZjFPZGJVRXNqUkw3dUV0eDFzQ2FaOFc3amg5a1pjSlp2NFJFb0VOZllHY0kw?=
 =?utf-8?B?Z0pMNWlVc1VoK2pmZmdENVlKMWpSK3RwN3pkeFZrR2xSaGZHL3pHblAxZTZy?=
 =?utf-8?B?MUczdXkzU0lXanpKZUhpRWNaU0Vic2lBN0pnayt1V0lSUlRwcDNIYUdJRlNH?=
 =?utf-8?B?cHNrMlh5NE1KbmMyNGdnSTRpR1E5Y21YYTdNb2pLNDBlVkNSV0I0bytGMmhq?=
 =?utf-8?B?dVc0aE1WWHBDalJkZlNCZi91MldSREhaa1hKN0tsRGVVUWdJRXBaU1hEK21Q?=
 =?utf-8?B?c2RuazYrRWRTS1JXU1BrbWJVQWFLblc1Rzk4NE1IOWZKMEpuUEJGd1h2UGFQ?=
 =?utf-8?B?cXZmTUZSZDhlRytlNzZ2bEJBQWVnejFteTVpbzFCYWdjeEc2Si8wQzhXOHlO?=
 =?utf-8?B?elJzU09qOWxtVUROdW91ZmxhdEx3VDJVMmh3YnNRcG12M1BBaWZDaGNvbmhQ?=
 =?utf-8?B?cWluNS9qa1g0MkQxcWJwOWZFYkJnS0tJUTYrN3dWaG5QWnpTNWdCOGVRcnF2?=
 =?utf-8?B?Z1ZobExXaVV2T1ZTNzBNTDFURG9LU0NtcCtLYXRGdUg1ZW5NV0xhRjVkRjlP?=
 =?utf-8?B?K2d6Umd2TzQ3TWgxenRlRGpaYVRCbHJUdWZzVWdBcTFIbDN5bE9Wdk9WNkxn?=
 =?utf-8?B?YVhweHhYWFJvUkFYdGVUemltZDUwMUZtUWxFUzZMamdTQ2xLTXYrV0dLRTM3?=
 =?utf-8?B?QVNDRlN1TktGa2o2UHhRY1BUV0xUT0JkL3psUGlIQmlhdVdGYUtKS0xhREZ5?=
 =?utf-8?B?QXNlOGZGUkdXZHVpVUtCa3Ywc3Q1TDJSZHlOQy90TkVWTlFxMlNCYUtQVXc4?=
 =?utf-8?B?Wi8yOU9LckRjbDFVZzcwMi9UUXUraXVBdW92cUl1R0RFMkxWcisrMFNrQjUy?=
 =?utf-8?B?RkxNZVMzTmpGdkczYWwybFRwYXg5L0hVMEcvM05KeUw2QUQ5WnF1MHlPZlpY?=
 =?utf-8?Q?SDfc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGwrOTR3ZlhPdlUxRUhZNXNqUlNGdWdzN2hBV0ZWaEdjWDhMZXNUVlBTWkxo?=
 =?utf-8?B?SGJLNXlHNkJQdWVsVlR0ZnJzMWtsWWlrNktIbWxoTENxTHVkTVk3Q2Ewa011?=
 =?utf-8?B?a0Q1K1ZSTmY1SW5lKzBvcytqYXlBRFpZcmhJYkpvMTEyRitRcmVnMjVLOEMz?=
 =?utf-8?B?cjFIWmxWN3g1U250RWdFb1c2cXU2ODB2RktFd0pNYlp6UlgwS0FVSjl4b2g3?=
 =?utf-8?B?bFJvYnJndXRLSjdvcHQzVzRINnVTNDBqc01tNG9xbWpGNTk0N2M1ekp0Mjcw?=
 =?utf-8?B?ZzdPUjgzQVlwRmFNNnFNd2R5aU9TM25Ha2NkUkZ4emlQSlhFaTh6cXFuSjNE?=
 =?utf-8?B?UHBWb2Rzb2ZSQUFwQU5Pek5LazBhdVl4SXlnd2wzVE5lYS9vV0xmVHBWTk93?=
 =?utf-8?B?dlpGeXZSSHoxZmJCWEFrNjBWMStsZUl5ZTFVaDRlZnZXQVlQOG8vUFQxTXg3?=
 =?utf-8?B?cHhIOW5hOVE5YnZOU3NMak1XWFdJdHhhdzZSYzBrOHVzZ1MwaUNwempFWlR1?=
 =?utf-8?B?VHM0S2d4R05xNVRRZllEc0tTdkZnSkJ0cE84QmdCVk12L0dVeW56VXNCT3g1?=
 =?utf-8?B?b3h0TDhza3hHSzI2dktaRmVNbVR5cyszTHVZbGg4cjBPeU1MWGVPTERWbk9F?=
 =?utf-8?B?WGlFSUN4c2lYYVliT0lzUDR5NEJRVTM1bEU1SWhMenRjTjdKRlNiTkliOG1Q?=
 =?utf-8?B?VzhsZEZpYlYwcithK2N3ZGJBK3JienluYk9KV1p3ZzZ1d0c1Y3dVL0xRZzJh?=
 =?utf-8?B?R2ZYK0Y2ZDdKS3NlNXNWNnlNWUdFQWJSL2xNS000d0xPRy9FdC9IUkhhUlQ4?=
 =?utf-8?B?czJLU1FheUdxZEZWK0tzTWxnbERVWHJMZ3k1ZlNNTEpndTVIdFhRSnBhZlFh?=
 =?utf-8?B?NDdvRHdCbUpFWUhJWHQyL2ZCMkpYY1U3dnhlRGkxVWVnMUNFUnJJbS80UllU?=
 =?utf-8?B?M1pSRXFZRzVqSlJQSVFwM3ZUWVJjRUdUdDJVVVNyOG53clVGNFRiL3QrRm84?=
 =?utf-8?B?WlljelFLQ3UrdExuaXFqT0RmYVJwU1liY0RBLzlleUkxdk9LSm96aDVkcFFS?=
 =?utf-8?B?UFdUaGkwN2x4VDdrODdMUElPSU96Z2hoMDUveDhQcW1jVzJnT2k4cFRFWG5M?=
 =?utf-8?B?NmdFZ01uSlZYUm9YVjhJblF6RWtROWFWUlYzNWdYWk40TjJxbzd5dzRhRG1n?=
 =?utf-8?B?QkQwY1FDZnZjZFlOZVZmcGhSMXF2MlFJb2c0blE2ZjlWb3g4ZDRONzFrRHVW?=
 =?utf-8?B?a3NEWFBMRUpNQnJVSWhKbnFpYm1FTkhKQTlQcjM5WElzeUNWVkJpK1B1RnlG?=
 =?utf-8?B?S2NjbWtZUTdkdHF6dnZtc3A2TzRmWFhFazRyeWFpVHJqVHgxNmNGSmxNUG5Y?=
 =?utf-8?B?QkF1WW5rMy8xRlJHazlFVVF2L0Y1aVNsdjZ2blNuWmQvVmtVR3hkeUl5dUlQ?=
 =?utf-8?B?N1FEOGl5YkhGTU9mcWdQd0dmYXh5UnU0RE5FM1gveVJZZUNsSTl0bElRWWZa?=
 =?utf-8?B?L1hRWTlwbUgzNjN5Zmc1ZW1VczVCVE5aQWkwQmtZNXlxa2lpWXd3UmxtTXhW?=
 =?utf-8?B?RE9OWnhGMjA4djVhVU9CdXlPOGFHaEFpUW51U3l1TnM1VzhvT1k0VFlua3No?=
 =?utf-8?B?QjIzdUE2MTVMU08waHRlRGZLNVlTWWF1dU9ma1hUQTB1aUpvQTNSbitOYXFR?=
 =?utf-8?B?LzMrb0t5WC9vNGx2UWFnK2FEMWVqUkY2K21QaFFZQTFzRWorRFVTbEV4VXNY?=
 =?utf-8?B?Qm8zMlBBR3dJUEQrZDRvc2J6NS9QT2lpcDV3dWtLSW5TUjg5UG9LZ0lZZFdS?=
 =?utf-8?B?d3ZjbHI5QVNNWXY3bnpnY3dnMjB1bTlJaytSallTSnA2RjM2N0g1WVhaWU5B?=
 =?utf-8?B?T2EwM0tUUHUwaTIrNzdSckIzQUo3NVRvSVZ6U1FJSFJKbUtOd3NpNk1KTHV5?=
 =?utf-8?B?UWdYUjBoQVQrRDFFSjQzdTBsZllYd1FwNDZsM0VIOVFBL0hDN3FTVXZSTUk4?=
 =?utf-8?B?ZDFseTUvK3orWTE0MFZXaFJ3WVM5Yy9DdjZkUUJBUjRrQllZMEpIS1lUdWlM?=
 =?utf-8?B?dktZR0wzVmFzVmJWUnVvNE15REc0OC9tcmI5Z3B1by8raU5xNDI2VHJHaEJv?=
 =?utf-8?B?eHlRanduajhWNUFFOVZsN3V4b1ZZbndWeXJUdEdOQ0oyZXFFSUkxWVpPK25R?=
 =?utf-8?B?dFF1NUthc0IveGtVajMxZHJsdC9DanFBaXF3bktibkhhOTMxWmZFUHBYN0do?=
 =?utf-8?B?KzlKekVraGhvbzBvN01BZWZqMmZMVnc1ekQvWHdkckdSNEpkbm56WlIxRU9W?=
 =?utf-8?B?cXg1UFlQQ3ZIbHJFZEE2SE0zVWZpNk9ZUURYcGQ2eG9ZdHFFeEZOTUZSMXhl?=
 =?utf-8?Q?gyAliNRWbZQZj5yY=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fb347b-c3d9-46a3-40ae-08de6aebbb91
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:36:23.0946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0J7p7dxUub/3xpXdDyA61X1LL4ODI1tGWGyuJhffMM7dYbuAb0ETFEd2JgMN2GAZzwalOe5HH0r4prJEeNo3NGiW4KVWJz3ApjemB3ZO4Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8618
X-Proofpoint-ORIG-GUID: 85cIaQa65x3Ilo7wY0TJlvXN7c_dwohX
X-Proofpoint-GUID: 85cIaQa65x3Ilo7wY0TJlvXN7c_dwohX
X-Authority-Analysis: v=2.4 cv=PaLyRyhd c=1 sm=1 tr=0 ts=698efea9 cx=c_pps
 a=Ju9Zey7g8YyQpP5MZaDBLg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=wQQV_E-IoR4cumysXjQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4MSBTYWx0ZWRfX18bYm46oUkua
 JxbkKjI1OdVM5Yvli1QelKu3w6+pEvQ8TputZV0fN3kuJ58iIkoB404zI4F6UYdNQi1KYKBhbmI
 7aR1JqTs8L8GdkqsX4jirjymOecfJxztrC3smDsLUt1QqHrWgl4vS6rgg6yRWFQgdSgYMAar2xN
 wNevp7jJM79fIAU2P59QT/8N2XeANHMtMebPOCI1NplGsJIA3xpBuv8dca3/BUkElxKB7avUW5O
 GQmCb3O5GUbCr0TPOop159DVUyCvHve6+qze/kWqtvnV1o2Eefp9De5tytKwvlaXNAq0EgZQXgt
 UDBwqajZUGblsFzQGm13+LnIMATW3Eh8D/pF1Md2EyndmbAMurZBqyTJbn07XL+HMmQQMmpu/Op
 ph+NvBitiAw04M2bmA/eGC3hbiPCGfeh4wP0naZ8R4LK/VyxVQFIUSQpEJUKrODmElTUIONhkUB
 O4/KcBTTRAOO1tGv2pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
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
> They are no longer used after conversion to QOM.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

I think it's worth a mention that you're also removing the drv_opaque 
from a few of the pcm_ops methods too - possibly might be worth a 
separate patch, however I don't feel too strongly about it.

> ---
>   audio/audio_int.h       |  8 ++------
>   audio/audio_template.h  |  2 +-
>   audio/dsound_template.h |  6 ++----
>   audio/alsaaudio.c       |  5 ++---
>   audio/audio-mixeng-be.c | 15 +--------------
>   audio/dbusaudio.c       |  4 ++--
>   audio/jackaudio.c       |  6 ++----
>   audio/noaudio.c         |  4 ++--
>   audio/ossaudio.c        |  5 ++---
>   audio/paaudio.c         |  5 ++---
>   audio/pwaudio.c         |  4 ++--
>   audio/sdlaudio.c        |  5 ++---
>   audio/sndioaudio.c      |  4 ++--
>   audio/spiceaudio.c      |  5 ++---
>   audio/wavaudio.c        |  3 +--
>   audio/coreaudio.m       |  3 +--
>   16 files changed, 28 insertions(+), 56 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 6ecd75c4fbf..fb5a9dd871e 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -139,18 +139,15 @@ struct SWVoiceIn {
>   typedef struct audio_driver audio_driver;
>   struct audio_driver {
>       const char *name;
> -    void *(*init) (Audiodev *, Error **);
> -    void (*fini) (void *);
>       struct audio_pcm_ops *pcm_ops;
>       int max_voices_out;
>       int max_voices_in;
>       size_t voice_size_out;
>       size_t voice_size_in;
> -    QLIST_ENTRY(audio_driver) next;
>   };
>   
>   struct audio_pcm_ops {
> -    int    (*init_out)(HWVoiceOut *hw, audsettings *as, void *drv_opaque);
> +    int    (*init_out)(HWVoiceOut *hw, audsettings *as);
>       void   (*fini_out)(HWVoiceOut *hw);
>       size_t (*write)   (HWVoiceOut *hw, void *buf, size_t size);
>       void   (*run_buffer_out)(HWVoiceOut *hw);
> @@ -173,7 +170,7 @@ struct audio_pcm_ops {
>       void   (*enable_out)(HWVoiceOut *hw, bool enable);
>       void   (*volume_out)(HWVoiceOut *hw, Volume *vol);
>   
> -    int    (*init_in) (HWVoiceIn *hw, audsettings *as, void *drv_opaque);
> +    int    (*init_in) (HWVoiceIn *hw, audsettings *as);
>       void   (*fini_in) (HWVoiceIn *hw);
>       size_t (*read)    (HWVoiceIn *hw, void *buf, size_t size);
>       void   (*run_buffer_in)(HWVoiceIn *hw);
> @@ -240,7 +237,6 @@ struct AudioMixengBackend {
>   
>       struct audio_driver *drv;
>       Audiodev *dev;
> -    void *drv_opaque;
>   
>       QEMUTimer *ts;
>       QLIST_HEAD (hw_in_listhead, HWVoiceIn) hw_head_in;
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 77a70d6e56a..6c2d2ad5dca 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -295,7 +295,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>   #ifdef DAC
>       QLIST_INIT (&hw->cap_head);
>   #endif
> -    if (glue (hw->pcm_ops->init_, TYPE) (hw, as, s->drv_opaque)) {
> +    if (glue (hw->pcm_ops->init_, TYPE) (hw, as)) {
>           goto err0;
>       }
>   
> diff --git a/audio/dsound_template.h b/audio/dsound_template.h
> index 7979773eb86..022a7307c99 100644
> --- a/audio/dsound_template.h
> +++ b/audio/dsound_template.h
> @@ -157,11 +157,9 @@ static void dsound_fini_out (HWVoiceOut *hw)
>   }
>   
>   #ifdef DSBTYPE_IN
> -static int dsound_init_in(HWVoiceIn *hw, struct audsettings *as,
> -                          void *drv_opaque)
> +static int dsound_init_in(HWVoiceIn *hw, struct audsettings *as)
>   #else
> -static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as,
> -                           void *drv_opaque)
> +static int dsound_init_out(HWVoiceOut *hw, struct audsettings *as)
>   #endif
>   {
>       int err;
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index 42bfea2515d..0bb2ab5c462 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -692,8 +692,7 @@ static void alsa_fini_out (HWVoiceOut *hw)
>       alsa_anal_close (&alsa->handle, &alsa->pollhlp);
>   }
>   
> -static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
> -                         void *drv_opaque)
> +static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as)
>   {
>       ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
>       struct alsa_params_req req;
> @@ -779,7 +778,7 @@ static void alsa_enable_out(HWVoiceOut *hw, bool enable)
>       }
>   }
>   
> -static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
> +static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as)
>   {
>       ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
>       struct alsa_params_req req;
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index c814a178f94..8024ca6bf9f 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -1521,13 +1521,6 @@ static bool audio_mixeng_backend_realize(AudioBackend *abe,
>       audio_driver *drv = AUDIO_MIXENG_BACKEND_GET_CLASS(be)->driver;
>   
>       be->dev = dev;
> -    if (drv->init != NULL) {
> -        be->drv_opaque = drv->init(be->dev, errp);
> -        if (!be->drv_opaque) {
> -            return false;
> -        }
> -    }
> -
>       if (!drv->pcm_ops->get_buffer_in) {
>           drv->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
>           drv->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
> @@ -1665,13 +1658,7 @@ static void audio_mixeng_backend_finalize(Object *obj)
>           QLIST_REMOVE(hwi, entries);
>       }
>   
> -    if (s->drv) {
> -        if (s->drv->fini) {
> -            s->drv->fini (s->drv_opaque);
> -        }
> -        s->drv = NULL;
> -    }
> -
> +    s->drv = NULL;
>       if (s->dev) {
>           qapi_free_Audiodev(s->dev);
>           s->dev = NULL;
> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
> index b31bfd88d81..a69baad4aec 100644
> --- a/audio/dbusaudio.c
> +++ b/audio/dbusaudio.c
> @@ -173,7 +173,7 @@ dbus_audio_get_nsamples(AudioDbus *da)
>   }
>   
>   static int
> -dbus_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
> +dbus_init_out(HWVoiceOut *hw, struct audsettings *as)
>   {
>       AudioDbus *da = AUDIO_DBUS(hw->s);
>       DBusVoiceOut *vo = container_of(hw, DBusVoiceOut, hw);
> @@ -287,7 +287,7 @@ dbus_init_in_listener(QemuDBusDisplay1AudioInListener *listener, HWVoiceIn *hw)
>   }
>   
>   static int
> -dbus_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
> +dbus_init_in(HWVoiceIn *hw, struct audsettings *as)
>   {
>       AudioDbus *da = AUDIO_DBUS(hw->s);
>       DBusVoiceIn *vo = container_of(hw, DBusVoiceIn, hw);
> diff --git a/audio/jackaudio.c b/audio/jackaudio.c
> index 7fbc37ef4f2..650ec230846 100644
> --- a/audio/jackaudio.c
> +++ b/audio/jackaudio.c
> @@ -507,8 +507,7 @@ static int qjack_client_init(QJackClient *c)
>       return 0;
>   }
>   
> -static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as,
> -    void *drv_opaque)
> +static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as)
>   {
>       QJackOut *jo  = (QJackOut *)hw;
>       Audiodev *dev = hw->s->dev;
> @@ -544,8 +543,7 @@ static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as,
>       return 0;
>   }
>   
> -static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as,
> -    void *drv_opaque)
> +static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as)
>   {
>       QJackIn  *ji  = (QJackIn *)hw;
>       Audiodev *dev = hw->s->dev;
> diff --git a/audio/noaudio.c b/audio/noaudio.c
> index fd032ee6e09..5c721ed69d0 100644
> --- a/audio/noaudio.c
> +++ b/audio/noaudio.c
> @@ -62,7 +62,7 @@ static size_t no_write(HWVoiceOut *hw, void *buf, size_t len)
>       return audio_rate_get_bytes(&no->rate, &hw->info, len);
>   }
>   
> -static int no_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
> +static int no_init_out(HWVoiceOut *hw, struct audsettings *as)
>   {
>       NoVoiceOut *no = (NoVoiceOut *) hw;
>   
> @@ -86,7 +86,7 @@ static void no_enable_out(HWVoiceOut *hw, bool enable)
>       }
>   }
>   
> -static int no_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
> +static int no_init_in(HWVoiceIn *hw, struct audsettings *as)
>   {
>       NoVoiceIn *no = (NoVoiceIn *) hw;
>   
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index e745149ca39..a4ee6ee3327 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -493,8 +493,7 @@ static void oss_fini_out (HWVoiceOut *hw)
>       }
>   }
>   
> -static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
> -                        void *drv_opaque)
> +static int oss_init_out(HWVoiceOut *hw, struct audsettings *as)
>   {
>       OSSVoiceOut *oss = (OSSVoiceOut *) hw;
>       struct oss_params req, obt;
> @@ -625,7 +624,7 @@ static void oss_enable_out(HWVoiceOut *hw, bool enable)
>       }
>   }
>   
> -static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
> +static int oss_init_in(HWVoiceIn *hw, struct audsettings *as)
>   {
>       OSSVoiceIn *oss = (OSSVoiceIn *) hw;
>       struct oss_params req, obt;
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index 8191b54468e..4d77f341b5f 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -518,8 +518,7 @@ fail:
>       return NULL;
>   }
>   
> -static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
> -                        void *drv_opaque)
> +static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as)
>   {
>       AudioMixengBackend *amb = hw->s;
>       AudioPa *apa = AUDIO_PA(amb);
> @@ -570,7 +569,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
>       return -1;
>   }
>   
> -static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
> +static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as)
>   {
>       AudioMixengBackend *amb = hw->s;
>       AudioPa *apa = AUDIO_PA(amb);
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index ddf5f2c70f7..c1cc945e659 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -524,7 +524,7 @@ qpw_set_position(uint32_t channels, uint32_t position[SPA_AUDIO_MAX_CHANNELS])
>   }
>   
>   static int
> -qpw_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
> +qpw_init_out(HWVoiceOut *hw, struct audsettings *as)
>   {
>       AudioPw *c = AUDIO_PW(hw->s);
>       PWVoiceOut *pw = (PWVoiceOut *) hw;
> @@ -571,7 +571,7 @@ qpw_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
>   }
>   
>   static int
> -qpw_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
> +qpw_init_in(HWVoiceIn *hw, struct audsettings *as)
>   {
>       AudioPw *c = AUDIO_PW(hw->s);
>       PWVoiceIn *pw = (PWVoiceIn *) hw;
> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> index aa3c0922199..2e9bc255a41 100644
> --- a/audio/sdlaudio.c
> +++ b/audio/sdlaudio.c
> @@ -345,8 +345,7 @@ static void sdl_fini_out(HWVoiceOut *hw)
>       sdl_close_out(sdl);
>   }
>   
> -static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as,
> -                        void *drv_opaque)
> +static int sdl_init_out(HWVoiceOut *hw, struct audsettings *as)
>   {
>       SDLVoiceOut *sdl = (SDLVoiceOut *)hw;
>       SDL_AudioSpec req, obt;
> @@ -402,7 +401,7 @@ static void sdl_fini_in(HWVoiceIn *hw)
>       sdl_close_in(sdl);
>   }
>   
> -static int sdl_init_in(HWVoiceIn *hw, audsettings *as, void *drv_opaque)
> +static int sdl_init_in(HWVoiceIn *hw, audsettings *as)
>   {
>       SDLVoiceIn *sdl = (SDLVoiceIn *)hw;
>       SDL_AudioSpec req, obt;
> diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
> index 4c2acbcbb4b..de2ee44fa0d 100644
> --- a/audio/sndioaudio.c
> +++ b/audio/sndioaudio.c
> @@ -495,7 +495,7 @@ static void sndio_enable_in(HWVoiceIn *hw, bool enable)
>       sndio_enable(self, enable);
>   }
>   
> -static int sndio_init_out(HWVoiceOut *hw, struct audsettings *as, void *opaque)
> +static int sndio_init_out(HWVoiceOut *hw, struct audsettings *as)
>   {
>       SndioVoice *self = (SndioVoice *) hw;
>   
> @@ -508,7 +508,7 @@ static int sndio_init_out(HWVoiceOut *hw, struct audsettings *as, void *opaque)
>       return 0;
>   }
>   
> -static int sndio_init_in(HWVoiceIn *hw, struct audsettings *as, void *opaque)
> +static int sndio_init_in(HWVoiceIn *hw, struct audsettings *as)
>   {
>       SndioVoice *self = (SndioVoice *) hw;
>   
> diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
> index b72424055c0..248249cef61 100644
> --- a/audio/spiceaudio.c
> +++ b/audio/spiceaudio.c
> @@ -108,8 +108,7 @@ static const SpiceRecordInterface record_sif = {
>   
>   /* playback */
>   
> -static int line_out_init(HWVoiceOut *hw, struct audsettings *as,
> -                         void *drv_opaque)
> +static int line_out_init(HWVoiceOut *hw, struct audsettings *as)
>   {
>       SpiceVoiceOut *out = container_of (hw, SpiceVoiceOut, hw);
>       struct audsettings settings;
> @@ -225,7 +224,7 @@ static void line_out_volume(HWVoiceOut *hw, Volume *vol)
>   
>   /* record */
>   
> -static int line_in_init(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
> +static int line_in_init(HWVoiceIn *hw, struct audsettings *as)
>   {
>       SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
>       struct audsettings settings;
> diff --git a/audio/wavaudio.c b/audio/wavaudio.c
> index 2a7703831f3..56b3122938f 100644
> --- a/audio/wavaudio.c
> +++ b/audio/wavaudio.c
> @@ -78,8 +78,7 @@ static void le_store (uint8_t *buf, uint32_t val, int len)
>       }
>   }
>   
> -static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
> -                        void *drv_opaque)
> +static int wav_init_out(HWVoiceOut *hw, struct audsettings *as)
>   {
>       WAVVoiceOut *wav = (WAVVoiceOut *) hw;
>       int bits16 = 0, stereo = 0;
> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
> index 4ab2abfc6f7..925c68e8da4 100644
> --- a/audio/coreaudio.m
> +++ b/audio/coreaudio.m
> @@ -573,8 +573,7 @@ static OSStatus handle_voice_change(
>       return 0;
>   }
>   
> -static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
> -                              void *drv_opaque)
> +static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as)
>   {
>       OSStatus status;
>       coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;

Getting there!

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


