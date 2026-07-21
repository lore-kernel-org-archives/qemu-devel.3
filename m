Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9DCC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm5rm-0005HQ-Rg; Tue, 21 Jul 2026 04:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wm5rk-0005Do-JH; Tue, 21 Jul 2026 04:30:16 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wm5rh-0003mY-S1; Tue, 21 Jul 2026 04:30:16 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KNCv5i1800871; Tue, 21 Jul 2026 01:30:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=HuxLre4doiPUplaSSyrhOQviF28oYubhT8VMvrK1d
 Ow=; b=CvN654xihSRIYfdC6SP6MR92ApGcQHrz36nKTPjL4Keo1d59QhW+/UXph
 CLNo7OcA7+tvDvKKnTZG0Clg83Cf4cIlMz4gVqUk3taUpzgvR3IuwBvDUyIXAQet
 s4nHRLcy/MZcbuTxRvM9rf6ksiJdopWrenU0q6akTIhBzFVbIuEh9aIWwlyps9lm
 JiUup3m92mieXy9I43OQcMOt0LLCJrWYR0OK3mdLy5vbpUk6RJT1suHc00cbMMaY
 pFOch83kAaNf/6iUHKbTMqMgrVnPtFC8SzXIC3cGez/0bMecDThAc+hoMbGGwyPw
 JohRGGFWZDTPyEUwjFPSrKCnqIalQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020143.outbound.protection.outlook.com [52.101.56.143])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8tbnt68-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 01:30:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epvA3KzHHLMyZzFCb1exMQ/HaPuzJ+cFj/CLYYPfofxNLsLTzkeF8U6OgB0MIXIN8yzloWKT1paYqJ5pMByrCxAIWH6cYi2t3VXfZi675xjosvjea8BCeaPv/APhsKX88kfHnouYDvMTbEcigoC4wdwjnSMsKT7ZyF0RTFhDIou5LWyPYDuhyBx4rO6CmyJjczu2SDUFkgtb6P8v+P30V2zpNIfsSDlrXNnFQdk6AYVwgnRQxSxISmq4GPS5WMPuvQxgOFcVMDjUIkeIgthzCTZtO9kWJK94twGD002aW0K4m9GuvHVE/5BPalXa13dou97G41ztKlEMjhTVSvrSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuxLre4doiPUplaSSyrhOQviF28oYubhT8VMvrK1dOw=;
 b=obo/7JWLPGyaSLImCYSAQlHsvi0sIg+/pYGcQcOk8OzW+jg8TISY9cINoTVy8j1tTrSQPeHO4SiN995Y7EEIvTpY+hmMwvo6OqfvH+Ks4p5KmYVQsZ4/Xe5eoc0DXZqwpHsVzfiifxsRY84kkujOBdK6RhA/QP9b08TEfPfwXxDRvRZbM45ESiZOyRN+DQusOvPudRobiJ3mzWT5qE7jp9hSDzL4crBWPTGJPaUgrRWJa4CiEEeJgPX9LiZxt60uJBqQZajJ2JG0w3tf07YiYPXA5thNRb+ToKWBSDffyJLtAFtW9Fxa+HjdkZLf80cDC0wbLomXd5lwHpAHgMSKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuxLre4doiPUplaSSyrhOQviF28oYubhT8VMvrK1dOw=;
 b=YmP7kqI5SfM02jCkXDQllL559m/U0Z8LYICQczNYLdryi76B+bjSUQmUXkgkJcBY+aXX4tFy4YTdb1yDDpITXJalisYy4Uof3hmI2roHWrIVUU1DDF4UBSjlDMBO0JD983+FejtqhgXHCLRTZDwPRO0hwAg2Vnx+/BiHdb2rANGd/QdyxgeUuFSAR/JJyGYCtsQRm7eIfpopN2p4ZQ7jLlUGrODrGaAgAaKx/xilCdJsZy7nRLm/jvlfnZ8E6r/Pz/JlBvPyKkMzL9UCP8lV/e7hRzwfV4bvRHoJoy+MSEB7RhMyZ7WCw50ZJsyfq79ctH8UQzc6SyW5/8GMWrMz5Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB9102.namprd02.prod.outlook.com (2603:10b6:8:132::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 08:30:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 08:30:03 +0000
Message-ID: <3f8027d5-f7db-4fb5-8386-1d5f93974a10@nutanix.com>
Date: Tue, 21 Jul 2026 09:29:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ide/core: Fix possible crash via NULL pointer in
 ide_cancel_dma_sync()
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, qemu-trivial@nongnu.org
References: <20260721070216.82984-1-thuth@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260721070216.82984-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0039.namprd15.prod.outlook.com
 (2603:10b6:930:1b::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 134839a4-fc60-49b5-8e15-08dee7024334
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|6133799003|56012099006|10067099003|4133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zkSz9E3+TWu0fr7P0x8oHomoErp+VgCpEHIp06yRAk60fi9rUDwaW4Cn2b5CrXNzb0WlD8v6mqRUrWBvKmnGVXgY64IZ5TcUYj6hh+NoqLyTZ5Y7qv9TWI0d3ZW+V4FnwvQFG2IsJwZHMc8vsNHXCJ1v+6JTSIgUK9Skw6wYB184BvFXOV/amIecV/Y/T1KzBI8167IN0RkBzQUmbHaidvfn9sB3YstWE34AA39uqWvCebnz91hYVprto+I1c7KItO/r5C3HjX+7HLSwa6vy4AqbnI8dSWMQgxpHSCsAC6zM7XS9uwdmG0S5zZy11T3UR/cli4ClXRgpgCYYRdbJOHNHuL8+L+lqqYesgasHmOy9JYAIMqV3lnKWiONn8bQUR0a/YFJochaqOWn11CvumHF5Lz0UsKV6SHlNKCq/MjlGhdvaPma3n7kAoTJdX8WmSx+vCTRZQt+lxgevJuPri+9YMY0JwfOvAFheqW/LEqg7YTufXiZTDHkEYAAly2Lp2s82EOGDKZYcwSzLsPZNMkSGZqvqJTUcLwNy8Aj/u5ABp/CC5TT3DEuS7fNVsqhe1OA4gpwTHrywI/bOoMhold/Zs22XlJescSBgFNMgLephyiEQDIC7fji0h1Pqy8MPqQEK4pdfoE+zTU7gTOj7rx56jzdKLZ5HNRJj2lmJi8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(4133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGtmK0RjTWVpUHYvU2pYd3QzU0t3c1JWeitFZXdUanFyTmVhSCsrU09FN1p5?=
 =?utf-8?B?RUd5R3FRZWg4UnpwN3JHS2ExQ0gyMzhoRTVmUkxnWjREV2E0aCtQUWMvK3c3?=
 =?utf-8?B?bHJzWmY0Nm5PZys1aFJPTEE0QTArSlZmL1FyUkZhQllwa1FNcVNzVW5Ub1dE?=
 =?utf-8?B?K1VXZmFVTE1ZVUQ3RkNYR25rTWUyRFl2K1JrdzFZRENHcU5CaHczZkFwOWdF?=
 =?utf-8?B?UVJZMGtWSDVRY3hEMnQwTGtkYVhVWnVQNmJXRWZPeUs5MjdaM2ZnVHEwVVpP?=
 =?utf-8?B?SkFibEhYR1JBQWpvVnZmdnUvUlZxZUMzK0xDWFBNMVV5SzhHOUtXaTdFbSt3?=
 =?utf-8?B?V1RtWTU1V3ZDSURIYXRYRlk3dzF4MnVNMGxPQkd0MlNhTUdyK1B4MzBSTktG?=
 =?utf-8?B?QUdxL1B1MTBkdHBGc1NHYTJhUjB4Y3BibzQxd0tmUGMzOHlrVVpKcFk4Wnd0?=
 =?utf-8?B?cndnMHljd2NidElRRVRCbUZKZlEwclI1QWdXZzRWWUJEMVhybk4xRmV5UTRH?=
 =?utf-8?B?ckJGNWxCaGRhcFRJLzNlUUtzcEI4a25zNmFLZjd5U2VJVGxBOWxhUktWNG1F?=
 =?utf-8?B?dU5adHBkdURnbVFlejBlelNEU1NSeTdRbldManhpa1A3cW5aUi85cDV3SkVk?=
 =?utf-8?B?QmNrYVRUTzB0VFBtQitLK0t1RjhoZGZnYmh1QzgwVjEvMXo5c2psa1k0T2Vv?=
 =?utf-8?B?L0xCbHlTNTlCMlpuRmpEdys1RGR0a1d3R2VBNkZHTVNHYUdjNS9oYmt0a3lL?=
 =?utf-8?B?ck5YUFp0aDJTaWVTV0d2cXc5QXFFMW82cld5YklleDJoYjBUd2RXOFNZVVVj?=
 =?utf-8?B?QTJua2ZYdEo4VThjcTVBaWowbWd2SU4yR29WQlArYklWWUFML2t5YXNOZ2hX?=
 =?utf-8?B?bTRTVXBYS2ZHQjhOQlpnbE5keHJWVUZKQ3ZHZ1RoR2dCV28vYUQ3eUR4Vk91?=
 =?utf-8?B?eWZ1aW1lNUU4RHhJeTJNUTlWazZYL1JYUUsrUE0rQ3c4ejhYdGU3TjRQWk1U?=
 =?utf-8?B?R1hHUkxDQjlrbHZIeHpsMzd2eWhWT0IwaDlzcXUrQ213RWl4SXVSTGgvbHNV?=
 =?utf-8?B?Vlg5MlAvZVRmaVN1T0x5Z09Yb1dLTGZrSUM1aUIvQ3IvTVJOUWloWnA3RHA5?=
 =?utf-8?B?QnlqRlExTm1UcjFZc2VCSFE4ejdwcUIxUDlDS3BUTHM1YkVUUHZHWHJFYS9m?=
 =?utf-8?B?ckRMY3ArZ2hUVFVKQXhrUXUrMStNb1ZYOVk0NzRZaUxJaHFEdGVjbDFVelk3?=
 =?utf-8?B?YWdzU25malVTaHFxa0RobExabFIvc0gvT0ZKT1o3ZnRJeW0yb2RaV0kvbGh2?=
 =?utf-8?B?TzNXc0pZRVNsZjltVG53cEJuRG82RjZxNEJwSU1ncDAvaWRsYnA4b1duOHYy?=
 =?utf-8?B?bTdDbGUzU3pBVDBtVytkWk5GcWxwaWlnWUJLMTJmRUVENkZVSFJSa2FpeXVH?=
 =?utf-8?B?SytYdTdxUnNCVUhIR2J4VURUVVc5SGFNK2t2d3J4cnp6V1ZFN1ZPdjkvbm9Z?=
 =?utf-8?B?QjVxR1dqdTNwOXNhbndoL0RkaU5Va0l5aG0vaEhHVS9Gb21icGFrTWNnMy9K?=
 =?utf-8?B?VDF4YU04VkhHTEE2MXJ0V0x6YmFURVR4OWhOWTdLbmpzbVcyZWJmN3p3TmFT?=
 =?utf-8?B?eVZpbklLVWVTWG5sUGxzL3JGVG04bzRRSURYRncxRlBTWGwxZUR0K3pOckxG?=
 =?utf-8?B?T2t1TSszNmVscVBHQWJNNEVnSzJvYk1rK0pqUjRiQ1BwNml0d1dIalFNTmZn?=
 =?utf-8?B?cG95VEs3VFd2VEo3Y3U0MW94SUFpejVuK0Z0cjJNbHAzQlBPRHViM3Y1RGFo?=
 =?utf-8?B?ZjQ1aWtkTEkxR1NjOE5FdEhRb0svTExRdWJqaEJxZDE3ZFFOZjMxL1UvbXBo?=
 =?utf-8?B?Zyt3QkhGRnZQUFVZd05lSGVmQ1VzdVl6Y0grVVJzUWRhbjFHWm92cXd0Z0dt?=
 =?utf-8?B?Z0ZqZDk2UmFIUWhzQ2ZSalNEVHQrVVJQdWFreTZETnQwWU5RdGd5dzZyZnl5?=
 =?utf-8?B?d3ZhckU1aTdJMTdFWkhDU0NhTk43VkNYSUhGekVlQ0hEVm1HREYvQm9vV0VJ?=
 =?utf-8?B?eGYzaldONGN2NDR6ZFFDdnZhbVVRai9QUzN4RDlBZldVYStmYlQ1eEhYaTJQ?=
 =?utf-8?B?WUhYTTJTK0svdDR4NUJBRHNPNExPOUc4WElDL3FLd0lGMGR6d25wVGMzM1ZI?=
 =?utf-8?B?SW5FTmJ2TzNBUE44SWN2YjAzYjFsQjB1RVFhSjZ5T0x5dWxrOUpMM3BUelpj?=
 =?utf-8?B?d3Y4WUJpcXB1SkZydVo3Ym9NdFlBVVVoUkpLUFZFOXJlcE0wMXoyMGNCWVdr?=
 =?utf-8?B?dEUwdW5EOGdYQW9NL2lIZkEwS2lTQ0Z0dnlacVNBamM0UWZqUVZLZGs1WlhV?=
 =?utf-8?Q?Rt3qYN3J6NRIBg3E=3D?=
X-Exchange-RoutingPolicyChecked: EjnDIJSM4xJbQ3k7v8sF89DzAAlKKj6fmAnB6s/BYyQ7KjMCF9MiniKrDozjdGUoggGR20/z2DtVSnI+my8ipnNt+BFJWZXKaOKJuzGx+OwiV9FNOcbPEQVCp7eCheKzLaawPz9lQ/nH7uH3YmnJW+Q8G1rWZiKHUuQ/iBvwBAOt0MoD25AEW5S7BWKeoPWibWMONakWVPRciwUEIHOOD56a2VCs1fZH8S9sHmYxEDLaq5JxIOt504M2ScJu+tBgzJbWlS+fYAASz//2lhZG5wCpzirpm/Dzz8Tra/NtK87XuVR60h8CvvIbbEzixu5ReJCef8vMysCUPOFtOpRp2Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134839a4-fc60-49b5-8e15-08dee7024334
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 08:30:03.8219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aR2HtDpsJmGcBSWLFDErdfWflKr5z2mR2HvPzVDUVq7NrDxR6L52l94qLv4gUSbnRhkcmh+JRq6kbuFhCkM9+iVj47UsQ95vXqDujR9AFHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4OCBTYWx0ZWRfXzn/ZiL/4QqdZ
 FPczEuxInKbHWRzc7e4Yxlu9HVLUvItXNPdMBpc7qJIwEYJlnuHklI5GAK6KC/aNn3rN+mSogFf
 4WvFpXWTetWrE1xhvbbCIHT/gnOpz2W0p7ajNhfDmg69Qb73YarUii9MPTr7ab2bWq8+ds1tcdt
 ZJDqIme3XkIcL/3OdMv/8aKhxFr9KAqWp9xTiURCKOKehLOhQknIbCtzOTtoZgggNtV3nIr+mwE
 /TEygV2gXWrxAwxzE+q2Ng6eQt7mIE1me1jZ0OZfiOe/ld+dY9LZXmmXIeK9FGAfO8S8mxjbwcE
 kswSyrBa3SK6pzrvsz/bHFdfDxuQIQsObhtfDTHnxXcvCJUv/uAeqvXIU1WFed881vWi3LukWbb
 xKX+xpIHEDrgSq7Py8fEFmjMiOtAaqWOvPaLsekUghK4z1tUjrcezmse3bHs8dMf33889nioS2O
 pT07dPca72r4bVpWcSw==
X-Proofpoint-ORIG-GUID: aYRXuEa8yDdRwYunnRlYPN0tUYh_btPd
X-Proofpoint-GUID: aYRXuEa8yDdRwYunnRlYPN0tUYh_btPd
X-Authority-Analysis: v=2.4 cv=ZJ3nX37b c=1 sm=1 tr=0 ts=6a5f2e0f cx=c_pps
 a=9wgRWqjVWX0WYWV/j6UgmQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=M3TV-_b8KnQ0B_pPhtwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4OCBTYWx0ZWRfX9r82oHU7+t49
 Nr4VFTGWED9I2Drnt9MZsywJPuiSUVfKcbpUFCHSEkLufUzXRZfLfB8f1O86BRFO1J51yFw5sNb
 ieGkLREUc16YUFA2NT/uZpaREfvlIPs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
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

On 21/07/2026 08:02, Thomas Huth wrote:

> From: Thomas Huth <thuth@redhat.com>
> 
> ide_cancel_dma_sync() is called with a "IDEState *s" for one of the
> two IDE drives on a bus (primary or secondary drive) to cancel all
> pending DMA transfers on the drive. The code then checks
> s->bus->dma->aiocb to see whether there is any IO in flight on the
> *bus* and then calls blk_drain(s->blk) to wait for its completion.
> However, s->bus->dma->aiocb might belong to the other drive on the
> bus, and if there is no disk attached to the current drive, s->blk
> is NULL. Since blk_drain() does not check its parameter for a NULL
> pointer, QEMU can crash in such a case.
> 
> To fix the problem, we have to check that "blk" is not NULL before
> calling blk_drain(). And we have to call blk_drain() for both drives,
> otherwise the assert(s->bus->dma->aiocb == NULL) statement after
> the blk_drain() might trigger if the IO in flight belongs to the
> the other drive.
> 
> Resolves: https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_qemu-2Dproject_qemu_-2D_work-5Fitems_905&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=BbZFP82dEZMyWzN5GnJ9XaxwmyrmYGbqWbEBNSUM_afB5JRRF3InIaZAr5UpUUh2&s=rCgSz13wVfk11Z-Uw5WTQViAQKkSvwpQqf_dJX1tiro&e=
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Resolves: https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_qemu-2Dproject_qemu_-2D_work-5Fitems_4052&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=BbZFP82dEZMyWzN5GnJ9XaxwmyrmYGbqWbEBNSUM_afB5JRRF3InIaZAr5UpUUh2&s=B-AkqMAsQwA0LzU5ptwPJ3ZIBAA8ncf5ZbQg8GTwaME&e=
> Reported-by: dong ling
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Drain both drives
> 
>   hw/ide/core.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index f78b00220b8..f43ab95b07b 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -741,10 +741,17 @@ void ide_cancel_dma_sync(IDEState *s)
>        * In the future we'll be able to safely cancel the I/O if the
>        * whole DMA operation will be submitted to disk with a single
>        * aio operation with preadv/pwritev.
> +     *
> +     * Note: s->bus->dma->aiocb might belong to the adjacent IDEState,
> +     * so we have to drain both drives to get it cleared.
>        */
>       if (s->bus->dma->aiocb) {
>           trace_ide_cancel_dma_sync_remaining();
> -        blk_drain(s->blk);
> +        for (int i = 0; i < 2; i++) {
> +            if (s->bus->ifs[i].blk) {
> +                blk_drain(s->bus->ifs[i].blk);
> +            }
> +        }
>           assert(s->bus->dma->aiocb == NULL);
>       }
>   }

Doesn't ide_bus_active_if() do the right thing here for in-flight 
requests? I'd expect to be able to do something like:

   if (s->bus->dma->aiocb) {
       trace_ide_cancel_dma_sync_remaining();
       blk_drain(ide_bus_active_if(s->bus)->blk);
   }


ATB,

Mark.


