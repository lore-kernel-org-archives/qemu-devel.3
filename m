Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209DDC5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwKHp-0002Bl-Qc; Tue, 18 Aug 2026 09:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwKHo-0002BG-96
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:55:28 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwKHm-0004Jt-20
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:55:28 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IDRTAN4052205; Tue, 18 Aug 2026 06:55:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=togNZwFN5Nf/emoHlilGB1PJmpqLmsbZfBr1D52gV
 Tg=; b=IFi+guKYt3ShlaFd6gNHjwAGTPnvtw2TUOmkd+A/nVYdb3A9Q++4MMlzX
 iH1VBPOiGD2WLk9lpjKNyvjp09UDSKBYnxJ8nvCQgTnuFGifCqZI/xl9Iv7Zf79u
 3uF8DAAdHj3Gz2+7apD2jyMhFyYh6wu/T9XTpr37CVr9ObOL9m0prV1hIOv7FqlV
 FEr1n9qzhaFHABnVJN1DncsnOmtTB1oyofXyfLqPwHvIa2kRnY/pbtSHdiZzqF3N
 MKoGu9Oibz9ZF9ShrqZpS/L1Dy+fp4Ggkvk7O9zq+lb4bp4tAsBgZFpGH414n4Ad
 HirTVmshXWcabBh+aWBtWzWPp56eA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023129.outbound.protection.outlook.com
 [40.107.201.129])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g2qe9epme-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 06:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvOa3w5he0m9UZa93qbKvmA6mDXfN4CvXGVT3rJpUGja82ACHIQE3QVYLlovdQ5koatGqjUOnWCR7pastCbnrOtyGUqQlh5jjriBU6qu287ze9iZSPgS731fdpGC9smfwNYgdfZcad9VcZQNYP8DD/mEzXDFJ/mbraZeWx5fxHgjyiHoZRn3ypvvCiR7GFqrwPXIv9z+WRYnQV42amtM4/pD7LGfup2Egz7vJVsPcAQvEOFlijJslGtFAO2/oQOajmr98vizA2HAoSrxdp+PsKtYmUk1nS0iegVMKiVK/opmcfMxVTjubpsHHheeWORj7gyhnMGTGsyXjH/OK4GtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=togNZwFN5Nf/emoHlilGB1PJmpqLmsbZfBr1D52gVTg=;
 b=KslG4q0XVQCLzBgeODwQyjvUt7RluGmz0ijwnJNbf1ooT65ef+sbobp1YU0O/7Bu+mJnHjsUtjxLF7WELHCVEs0cCrgOl9TR+aagMKYibJowGIoGMQVkcvntZ8KIwSFA+VMZVmH8FgTYlXTxOdzPR1zUvLLaPWyUR+JsuXGCbyM04R6v6+03MnV+KvEA5iak8k3xzU6eB5LXZxlrd8XSBZyL6K4JN4aJ5S4ApgQrZcCUfgUhVQW8wc6gs2PaoRmvQghmKEp0hS5vpVgig5XC0qw8/BMjqsOtM/FbXr0yA+Ug7HEVL+t1NvZSZtCuP78bEcPJWZXEw5KtcK957zHl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=togNZwFN5Nf/emoHlilGB1PJmpqLmsbZfBr1D52gVTg=;
 b=gzl+sPLm7qbh+dchgQnf0nIkG7yP5BqdjwoVcVFKcXtxqXyBZiXqfHISuc56G4hJUVm1hlfXu+12JntWv4RcTo9T3WppMgRWDvGaJ/q54vRTItRJj/wLh0WEt1bnSB37ApIfOTS9otSs+xYkRuK7sXc7e5RQ0Y+tTB1JH8NzqOSqfTq2AnEqU2TbRdiDryV3q4LYXBz0obePWlohb2DVY6JGmDmrpBUMYiOGGvvSUR5hO0F+aI0iPZsn7L8jKtaautXw3DG50qQj2f8SWWlLKbWlYmfV10+kVpwurApvn6lfjOWtE6+4hSkZvca5HdU7a5vF+q/6sjyMT3w29OO5yw==
Received: from BL0PR02MB3827.namprd02.prod.outlook.com (2603:10b6:207:42::26)
 by DS0PR02MB9103.namprd02.prod.outlook.com (2603:10b6:8:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 13:55:22 +0000
Received: from BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd]) by BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 13:55:22 +0000
Message-ID: <43d32e1c-ae73-4863-87a5-98c2f6ee5fe0@nutanix.com>
Date: Tue, 18 Aug 2026 15:55:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ui/vnc: notify client of clipboard peer status
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260818121413.2660786-1-lucas.kornicki@nutanix.com>
 <20260818121413.2660786-5-lucas.kornicki@nutanix.com>
 <CAJ+F1CKuDAzTz2iC+acOKf2j1vW3iFE6jinTKL=AwWCu3-1KGg@mail.gmail.com>
Content-Language: en-US
From: Lucas Kornicki <lucas.kornicki@nutanix.com>
Cc: qemu-devel@nongnu.org
In-Reply-To: <CAJ+F1CKuDAzTz2iC+acOKf2j1vW3iFE6jinTKL=AwWCu3-1KGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::17) To BL0PR02MB3827.namprd02.prod.outlook.com
 (2603:10b6:207:42::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR02MB3827:EE_|DS0PR02MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 62540eac-aaea-4d42-d0bd-08defd305875
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|3023799007|18002099003|22082099003|56012099006|4143699003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: 7ShN8rDVCCOjlBaK6KJjufGYJ+tIH4cXJm8ilxzZAUPLmdyxqwaLBiwBEoE8f5gXN/SJt9CC7f3Vq4JzIHjLTUp15aT3/MYmpfR97fDhclFMdxcYaEBVuNrANeXPYkyRWcPoecyptXmvDfdG2R2+BOtuVhse0B6zIRgzQt+gB1T6B9c81xr6t4sDfJpfea8sc1Z8aShKvSfgo/QrH++jYHx2UqgIf5ylk72qS9jg/Mw0zfKltmHGxYU9mTsDYtEcESq/rNwkUl/vArdBPh50dgalALyG6meEXFrdjCqRxUn2D75XFvVPhQADtyGKXtwD+u38NAgxkAFNIfVvBCqYt+pqrRqfyBbbTougK2/uRH4h2+UIWAbOaN2VXVKhOcjaK3YG7bHoBIk1e2wDEhFSKzyKNCp2hBKCqmkrVcjil5E61V6DncaX9mcgNAqgA0xaxzQ6NKK/a9dEvB4VrTn84b3dBXO88ihSRCvLfkLNkcxD61XboaL3gnKnJcHz1YiSB0041EbZj/CLPsD8vWMyC3Z3xyEtiil4DicLdAuDI0XMe50+W1lYuIbDxVdDrdOAFSQSAG1KjepHlv0z5kPLiiixFtCSGUh/FgsuX6NQfXUz5hvfZ4XS+MgGKJ1ebQC29DhKt9L/2tvv6sHQpuO8dv0qhMYcxlKY9+pPT7ezudU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB3827.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(3023799007)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjhhb1pPU2ZjSnA4cmtJcW5NOXJkVUROTmxrSFE3TldPRFZFWkdlUzFTNHB3?=
 =?utf-8?B?R2RKWkZ6THhvdHMybzNyOWp2RHE3QktOdm8rUzU2T2RNdzZUY2xiaGc4NVBq?=
 =?utf-8?B?V3BSUlRTSDJ6M0NKNjRKblVvTVZQdlppZzhyUU8wS1NjcFhLd2dPOGlLS01T?=
 =?utf-8?B?ZnpkWGFPMHQ1MTE4bE5PVlo0NzlUQ1hqNXhhVERYN2M2MTJDMnJJUFAvZ3Ux?=
 =?utf-8?B?TG1lTW42WUloQktXandIdWJTak94cmQxZU03QjFTajV3UTk5K3g2eGh2eWhy?=
 =?utf-8?B?VTV3UmJjL1F0LzZ0S0xvSnNWTlhrSW1mZ0U4MnZVMHJsNkF3QzlneENGWVVz?=
 =?utf-8?B?K29UOWFoZG9yS0N6K0hLMEZnSE9NNE1ScG1tSnpMYWJUZ3FUd216QjQzUGc2?=
 =?utf-8?B?TEpwbDlqMkJKVndiQXRwU0VRQ1NWRjBZejU3dVQrczJFRThGemtWaUhpaDRj?=
 =?utf-8?B?UzNWaVViS2tWSDNzbjkwb2xSQ0Fsb2lKeUwwaDB6RGlQcDhOWGxLYXE2c2Ix?=
 =?utf-8?B?eUNFdkFBQnBxRFV4OUxsWnpmeFVmYUE3b0VBcG5VRyt2ODZrSkM1cFJBUzZE?=
 =?utf-8?B?dGZrM2RSS3FIM3JNcStNaTRLbmRkR0ZEQ25rTnJZOS81bktXclU1clFrQ0Vx?=
 =?utf-8?B?U1JqRkhQc2FKNVkwN04xK2lHeFBQTVdZdURRTnVYbjJYUC9ndTE0eHFtazJO?=
 =?utf-8?B?WU9obHNGeDk5ZkQ1R09CR0FJNFRydkdqZmxaZWRabmZ5UGxCYWRsZGNTYU4z?=
 =?utf-8?B?cnlvRXVCeEN3WW9IR0paK0VFcTJZWlhoOUk0WExhTVZ6Z3F5bzJ5Y0tNcE5s?=
 =?utf-8?B?K0lEYmFVN0QxSTRDRU9HS1VESDdYSWtUZHZEK3l6dUdYTi9rU1FDQ3JBTnZi?=
 =?utf-8?B?M2ZFOVBzS2RrcGZrbTlITG9oRVE2YUYwSXdHMUZ2VE9rbFhFSGlVNCtEV1hT?=
 =?utf-8?B?R3pseVdSSG1MbnovQWpZM1hYVGdOd29GYkZNTFozZ1ZTY0ZOWnh3UUlzYWo4?=
 =?utf-8?B?V2tsckRQUm1vMkVwZTBxdUJja09SL1NKSTdQTzlkQjQzZ0tDWXlmUWxKb28z?=
 =?utf-8?B?cXNKdVF6NUJkWmJZM3lIR0ZkeFR1ZWY2eUpTNnJwOENQSVFpbDhyWFh4TnNH?=
 =?utf-8?B?Wlh2ZGcvdUt1Z092TmN4aHdqT3JhVVlNWjl5UnNOK3RXa0ZSOVduRmZmZkVp?=
 =?utf-8?B?ZDcydUJMM2x3VnBEMFQrajlzSlpXMzllWURUV2tqZGRHYVVZNzNXbTN1eFlP?=
 =?utf-8?B?T1RJR3lKakxYT1FaVGZOc2xwV1A2NVNnY0lKaDFLVWliZ2JGM0NLaHRNczNn?=
 =?utf-8?B?amZZRmJvK1psbU9EQ016eUJCY1hzZ0c0SnRXYWpmSTU3TVRWYkxoa0lPMDFC?=
 =?utf-8?B?a0k3MFhSa0w0em9jNG82cW03allsWWM5MWYwWUJzNWJCV2JXWVBoZytINTZC?=
 =?utf-8?B?Tkowb1FTT2xsREpsaitSUmRqbVdzNXl5N0JWZllINkxPV294QnJ3OXhzTWhh?=
 =?utf-8?B?YlJEQWdCRlZMVVJXM3JmVnNOeHFkcU8yRVFVNjR4WnB1MlVVR1F0Y0FJNHk1?=
 =?utf-8?B?cG1CSld1R3VDRFVla1lGampGb0U3M01YVGEzQUs3QWZUY0VHYUFSZXh1Yy82?=
 =?utf-8?B?b2ZKeVhiVHlyZm9kUGZtV2F6dlovT1A5ZlpsY2E3T0VmcHBwY0lGU25Bcndm?=
 =?utf-8?B?a3lZODlCLzh0ZzhMcHVJWEl6eVNYdkVLaTQ1ZUErdVg1SHFtNC9ObWM1NlRt?=
 =?utf-8?B?Z0I5ajN2L2FvVk5rendveE10bnZxazExbklXMEV2cHVqTi9PTTZxUTU1djh4?=
 =?utf-8?B?cU5KTjlWTlo3ZFNvZi9hb0kzMUxHK3ZlakVYQ2pDdWIwdE1IODA0SWFoU0E5?=
 =?utf-8?B?b016MlUrTUIvYzcxRTZ2bXlUaE1oWGFHbis5cUN1NjJYTHF5VnJsTkdTeWMv?=
 =?utf-8?B?WDZITzNLRHl4b2ZJMFhMYWVsWjBKMVFDMjU4QzNKbkprekpnQzNEM1BPVjB2?=
 =?utf-8?B?NzRVZ0lsQ3V3ei9jQzVKVkFLRVBsd3lJVWVQcHdaVmRaWDdqZXRHRi9jZmp6?=
 =?utf-8?B?S2c5dUJvcDEyM2JwT2lBSmF1bm1sL0ozMW5iUk15aVJxeEdvVmpUOTRteWlx?=
 =?utf-8?B?THF5UE5EWVZOUzBYUTRpWWczWk15aHYxVjA1enZqL3RQZUoxd2RMTzZJVU45?=
 =?utf-8?B?ZnFnVHg2ZjJkcXB0ZGVDSEZVN3Fmc0tsYUNVeVhKY1U0ZTMyZkp4MDhmRnhj?=
 =?utf-8?B?eklYUC9GRmprZGJ0K0xXY2E0MWQ3QmJWY0U3UlFIZDRYLzQ1akNuQklxeGdx?=
 =?utf-8?B?bWlCUHZsejNRenZHdTNxcDhiK3gwanZsdlJlSG1VY3VEczRBWXd3QT09?=
X-Exchange-RoutingPolicyChecked: WE45NHcXwiwLXKueWrjvhkWNY2NExT83aDUpeg3okKW2nRAr3dRdNfuHM6Swgj9IM6o/YzwLRrW1irz8/gYrfAGQ+7BLgnn24AEFubaPCMmQBWVUvNLRMUwpactNDE6pkupHRHz0ncvaJhPtNnB8jgRVVymc6MeWDHD3FCOvvOC5WByGnF/USOhk/jwHYdv/0CauJZoTlsx0q3K6Z71uY+Mo7Rtqumh/QL2Y8FygsE8F7Eyjye5tjf+RdCgCB3zR3jwbBN4dcyLkC6DEQ8/tDElGl20vdaGawOAx2rtP1Rv1+YHwzr9pj5vbxYEPIxVp36WLPQzqzEHkegMaEX1Uaw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62540eac-aaea-4d42-d0bd-08defd305875
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB3827.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 13:55:21.9522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5EdxzG/GzUKN+TaimBfNesSUNAY0HEZz0m3DsbwZwdIZ7BjToHNrR1Sec4ATzWGnzJeF6zStQq32uJImeiIUd+mccRGkw4F+xXnFiKIiTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9103
X-Proofpoint-ORIG-GUID: N9YSfHLT_N1TVz7w-1bFSafNJV2Z5qfM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwMiBTYWx0ZWRfXzkqg/0B+xbUT
 +qst3ZUc06DvgSdcb76doylKkB3UA/eHiR0CTlPjD3GGxdJoeuQ/Fk9hycbbdhLCP4RWxbmo9th
 LZSLzhZNNwO0l37DaVACqcPdftntuXU=
X-Authority-Analysis: v=2.4 cv=MP9QXsZl c=1 sm=1 tr=0 ts=6a84644b cx=c_pps
 a=roYWoV4TocsuA6t8t8h9Ow==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=UwPz85GXjUrQaOB45p4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: N9YSfHLT_N1TVz7w-1bFSafNJV2Z5qfM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwMiBTYWx0ZWRfX1j8sG2J4T7az
 jLGTEuNtUge8qP+KTd4s/74h/K6em33S026SNsPtoFSiadMT+Z2m/WN5oiuetl/1tizSRn6IehG
 I5RzUFANf7mVLJAgAZbRPjbli5IF9nyjLKsuVRMcY8hXfDKYzKcnC9nci9pGKjtxXpT2pi59jRb
 fKAOrXMcz84ti2ukuNiVJ9b2vFgBZj52Wh7yd46iYsnSMl55trngY8NOzGIgS3GhJWMWRLwA8Xl
 CEXG4KmJUKSJpCXBEFuHcuMmwJb3Uh9UgBOrpE88tyzqhN9KAygK1vJjev2EwiQfCkEW0hjvAcl
 HpONFggN63Fx+z9CwdghJVv8K7gVDKmsP+XpnU2vHxEPrThx3G1bpFEkRAw7x1odnqQm9WQpTJm
 //hcMnCf/CjeO5Chk8lM4+Pe6uvtHHDWRqR+F2a2atfuo59gETx836zYL5tFGzygn/W/XwlrWgN
 sgph212ZHmaBq7BNxMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Hi Marc-Andre

I quickly became aware of the shortcomings of my v1 series and I've 
already drafted a v2 where the cover is a bit more detailed and the 
commits were fixed to remove the Change-IDs.

On 8/18/26 15:33, Marc-André Lureau wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> Hi Lukasz
>
> On Tue, Aug 18, 2026 at 4:15 PM Lukasz Kornicki
> <lucas.kornicki@nutanix.com> wrote:
>> Introduce a new vnc message (VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS) and
>> the corresponding feature/encoding.
>>
>> When a client requests this feature, the server will inform the client
>> whether a guest clipboard peer is present. The server will repeat the
>> notification each time availability of a guest clipboard peer changes.
>>
>> This change enables the VNC client to determine if a guest side
>> clipboard peer is available for clipboard exchange and react to
>> changes of its availability.
>>
>> Until now the VNC clipboard peer was only registered when
>> VNC_FEATURE_CLIPBOARD_EXT was enabled. With this change the VNC peer
>> can be registered just for the purpose of receiving peer status
>> updates. This requires introducing a VNC_FEATURE_CLIPBOARD_EXT guard
>> before the QEMU_CLIPBOARD_UPDATE_INFO handler which previously only ran
>> if VNC_FEATURE_CLIPBOARD_EXT was enabled.
>>
> The series looks good, but this extension is not documented afaict.
> Can you make a PR for it?

Sure. I've found this repo before but was not aware that it functions in 
any official capacity.

>> Change-Id: Id0897a24fae103288c399f73e808ed6c07018359
> What is this? Is it a gerrit thing?
Yes, I forgot to remove the commit-msg hook and they got regenerated 
right after I removed them :)
>> Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
>> ---
>>   ui/trace-events    |  1 +
>>   ui/vnc-clipboard.c | 31 ++++++++++++++++++++++++++++++-
>>   ui/vnc.c           |  6 ++++++
>>   ui/vnc.h           |  8 ++++++++
>>   4 files changed, 45 insertions(+), 1 deletion(-)
>>
>> diff --git a/ui/trace-events b/ui/trace-events
>> index 917d116d90..d2fe153b7d 100644
>> --- a/ui/trace-events
>> +++ b/ui/trace-events
>> @@ -48,6 +48,7 @@ vnc_msg_server_ext_desktop_resize(void *state, void *ioc, int width, int height,
>>   vnc_msg_client_audio_enable(void *state, void *ioc) "VNC client msg audio enable state=%p ioc=%p"
>>   vnc_msg_client_audio_disable(void *state, void *ioc) "VNC client msg audio disable state=%p ioc=%p"
>>   vnc_msg_client_audio_format(void *state, void *ioc, int fmt, int channels, int freq) "VNC client msg audio format state=%p ioc=%p fmt=%d channels=%d freq=%d"
>> +vnc_clipboard_peer_status_send(void *state, bool present) "VNC server clipboard peer status state=%p present=%d"
>>   vnc_msg_client_cut_text(void *state, void *ioc, int len) "VNC client msg cut text state=%p ioc=%p len=%u"
>>   vnc_msg_client_cut_text_ext(void *state, void *ioc, int len, int flags) "VNC client msg cut text state=%p ioc=%p len=%u flags=%u"
>>   vnc_msg_client_ext_key_event(void *state, void *ioc, int down, int sym, int keycode) "VNC client msg ext key event state=%p ioc=%p down=%u sym=%u keycode=%u"
>> diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
>> index 67f710f6ed..4ecc4489e4 100644
>> --- a/ui/vnc-clipboard.c
>> +++ b/ui/vnc-clipboard.c
>> @@ -26,6 +26,7 @@
>>   #include "qemu/error-report.h"
>>   #include "vnc.h"
>>   #include "vnc-jobs.h"
>> +#include "trace.h"
>>
>>   static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_len, uint32_t *size)
>>   {
>> @@ -224,6 +225,23 @@ static void vnc_clipboard_update_info(VncState *vs, QemuClipboardInfo *info)
>>       }
>>   }
>>
>> +void vnc_clipboard_peer_status_send(VncState *vs, bool present)
>> +{
>> +    if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_STATUS)) {
>> +        return;
>> +    }
>> +
>> +    trace_vnc_clipboard_peer_status_send(vs, present);
>> +
>> +    vnc_lock_output(vs);
>> +    vnc_write_u8(vs, VNC_MSG_SERVER_QEMU);
>> +    vnc_write_u8(vs, VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS);
>> +    vnc_write_u16(vs, present ? VNC_CLIPBOARD_PEER_PRESENT
>> +                              : VNC_CLIPBOARD_PEER_ABSENT);
>> +    vnc_unlock_output(vs);
>> +    vnc_flush(vs);
>> +}
>> +
>>   static void vnc_clipboard_notify(Notifier *notifier, void *data)
>>   {
>>       VncState *vs = container_of(notifier, VncState, cbpeer.notifier);
>> @@ -231,13 +249,24 @@ static void vnc_clipboard_notify(Notifier *notifier, void *data)
>>
>>       switch (notify->type) {
>>       case QEMU_CLIPBOARD_UPDATE_INFO:
>> +        /* ignore the update if client does not want ext messages */
>> +        if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_EXT)) {
>> +            return;
>> +        }
>> +
>>           vnc_clipboard_update_info(vs, notify->info);
>>           return;
>>       case QEMU_CLIPBOARD_RESET_SERIAL:
>>           /* ignore */
>>           return;
>>       case QEMU_CLIPBOARD_PEER_UPDATE:
>> -        /* ignore */
>> +        /* only guest side peers affect the status we relay to the client */
>> +        if (!notify->peer_update.peer->guest) {
>> +            return;
>> +        }
>> +
>> +        vnc_clipboard_peer_status_send(vs,
>> +            qemu_clipboard_guest_peer_present());
>>           return;
>>       }
>>   }
>> diff --git a/ui/vnc.c b/ui/vnc.c
>> index 656768f9c9..9e44a20311 100644
>> --- a/ui/vnc.c
>> +++ b/ui/vnc.c
>> @@ -2191,6 +2191,12 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
>>               vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_EXT);
>>               vnc_server_cut_text_caps(vs);
>>               break;
>> +        case VNC_ENCODING_CLIPBOARD_STATUS:
>> +            vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_STATUS);
>> +            vnc_clipboard_peer_register(vs);
>> +            vnc_clipboard_peer_status_send(vs,
>> +                qemu_clipboard_guest_peer_present());
>> +            break;
>>           case VNC_ENCODING_COMPRESSLEVEL0 ... VNC_ENCODING_COMPRESSLEVEL0 + 9:
>>               vc->worker.tight.compression = (enc & 0x0F);
>>               break;
>> diff --git a/ui/vnc.h b/ui/vnc.h
>> index d8b0070396..6e8fa66e9c 100644
>> --- a/ui/vnc.h
>> +++ b/ui/vnc.h
>> @@ -422,6 +422,7 @@ enum {
>>   #define VNC_ENCODING_DESKTOP_RESIZE_EXT   0XFFFFFECC /* -308 */
>>   #define VNC_ENCODING_XVP                  0XFFFFFECB /* -309 */
>>   #define VNC_ENCODING_ALPHA_CURSOR         0XFFFFFEC6 /* -314 */
>> +#define VNC_ENCODING_CLIPBOARD_STATUS     0XFFFFFEC5 /* -315 */
>>   #define VNC_ENCODING_WMVi                 0x574D5669
>>   #define VNC_ENCODING_CLIPBOARD_EXT        0xc0a1e5ce
>>
>> @@ -466,6 +467,7 @@ enum VncFeatures {
>>       VNC_FEATURE_LED_STATE,
>>       VNC_FEATURE_XVP,
>>       VNC_FEATURE_CLIPBOARD_EXT,
>> +    VNC_FEATURE_CLIPBOARD_STATUS,
>>       VNC_FEATURE_AUDIO,
>>   };
>>
>> @@ -507,6 +509,7 @@ enum VncFeatures {
>>
>>   /* QEMU server -> client message IDs */
>>   #define VNC_MSG_SERVER_QEMU_AUDIO                 1
>> +#define VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS      2
>>
>>
>>
>> @@ -541,6 +544,10 @@ enum VncFeatures {
>>   #define VNC_CLIPBOARD_NOTIFY   (1 << 27)
>>   #define VNC_CLIPBOARD_PROVIDE  (1 << 28)
>>
>> +/* guest side clipboard peer status */
>> +#define VNC_CLIPBOARD_PEER_ABSENT  0
>> +#define VNC_CLIPBOARD_PEER_PRESENT 1
>> +
>>   VncDisplay *vnc_display_new(const char *id, Error **errp);
>>   void vnc_display_free(VncDisplay *vd);
>>
>> @@ -637,6 +644,7 @@ void vnc_zrle_clear(VncWorker *worker);
>>
>>   /* vnc-clipboard.c */
>>   void vnc_clipboard_peer_register(VncState *vs);
>> +void vnc_clipboard_peer_status_send(VncState *vs, bool present);
>>   void vnc_server_cut_text_caps(VncState *vs);
>>   void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
>>   void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t flags, uint8_t *data);
>> --
>> 2.43.0
>>
>>

