Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BACC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysn9-0007Dp-TO; Tue, 25 Aug 2026 11:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysn8-0007DZ-8c
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:10:22 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysn6-0006DP-CU
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:10:22 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEcEMc2321403; Tue, 25 Aug 2026 08:10:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4oM1xOjmz21t+yAutOxTE+487VwxsJHUxi5Hcc2Tr
 nQ=; b=a2FWk/Iu2RSACFVfW/YPqiKlVAkUY/7zxHgVShsfOJ44amUJt1m/m1Ltx
 BPLCBVRExMd6/p3oRIuWjp5RIcWX+A5ByNn6muKLkHvwCpKZmQ64jHEnUX/RYpwr
 /kJPOg5humVk09H9dSg/yhjjm735o5B8S/wd9J2I6+7XoIeEpTagt9rROVuaZ0QV
 TgPlt5zTQEb5C61pECk4GlFvYAdoQz5yNcJlaFxuqIWLesJTVh1uJ9XXSGpFL1So
 cg+wqDxgwQIkPVI734wfKps1QeiYj6I7dE8Zi69ZMMp4El2dyVmxP67wKQ1LTuG/
 Wnroel2otU7OHcAiFMViJCoMgfItQ==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021131.outbound.protection.outlook.com
 [40.93.194.131])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g7baven92-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:10:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqhvIEff02syWF5AuLxFslOpPZMQZZr714UtwINt+/pPLm2lNE3Fmk9qZr0adK5zniN8RbLwuPnsp23+e2HiC6UtVjmk2evN26fpU9d81k2mrJsaYYsMNNGABNQGTi2x0ilpGw/WG1cXTi86HolXHKPNNHZAFnUMNzBlBGU/5pTdyF0hsqYdya75yQK+GxAnNvQfyq4mQs0LaA2wBQqoHRqf0gCqiW5/RSrSgqoa41GtuaTa0koZ6jIGgEbr1rbAlfz3tjWm95zSA1wYxti5A6gVeEpMLKQFt8rOvUn6m1Rv1Gb+BUm15gBWfBS1VHwlCebNXA9ONW3Tpr/N4bfBuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oM1xOjmz21t+yAutOxTE+487VwxsJHUxi5Hcc2TrnQ=;
 b=mnCwuIPcS8EU4oVB1mwUNv9rpdalQkgOpq9yASJ/iQtKyNq23T1BoSqfxag6gwxeozwBlgaA6VhIn2+zOxM/tF8BKsQOHNoJlFURILfkBwpB/ET9qVA1/Jhmh0qN2KujPHaBoPZD79Bh/GD0pCrB+2vVgONipJQ5b70jKtk8rwffLc2Uk2c8bArIQEJ7lxDUR0zNoKpuWt6GDurFFw851rTTNJhg0lV9CP+xALdDzp43t2uwzNNTSq089ojp9rm6LY8lfUuNnCT9zTG7Dsj7x0tuARj3SppwBzfQ1MdFUqQtXrmmRu3ooxAvNzvR8XDTVwq0DuSgCk8NDwii25KSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oM1xOjmz21t+yAutOxTE+487VwxsJHUxi5Hcc2TrnQ=;
 b=OlwNB/1TODwqvRLFzmBAZ+KCU9YntA3/xU+Bd+uBZPr/+gdlX1/0SQFBF3QFRJFcvUBCbpGe6Rj6rmIf6ddncluCLt3nxTOMMYas19MZd1VnzcY6lDJkaUTwaKLIEEBFj5w+7yyGBFtNCSRPqDdioJbBKxLvQb+8otEtyXqRRAIRVhhJvsD63GgCp4NXbfFQOfqNPY8HqGlmAhc4CQSkH1Kd96NvChx7vwFyBnbSnu3Jxp3YRVD/3rldJZcI8yDo+GRoeUPQHJQYZOPCCC9CuB29p5ixF+UqRyfN39bc7I+usU+wMq6e6cAIlLUfrYpxr4ZmHw7HlrRJlCCwUpnGjA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8855.namprd02.prod.outlook.com (2603:10b6:303:158::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 15:10:07 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 15:10:07 +0000
Message-ID: <9be423c1-2e54-4783-8b4f-c1676508a058@nutanix.com>
Date: Tue, 25 Aug 2026 16:10:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 35/74] event-loop-base: fix property typenames
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-35-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-35-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0077.namprd11.prod.outlook.com
 (2603:10b6:806:d2::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8855:EE_
X-MS-Office365-Filtering-Correlation-Id: 92034d9f-dc98-460f-70b2-08df02baf331
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: O2/50WmoQzlnJJsxaK9gSLZGUc/ezqH3VSok/qmdKcRd9JH8pf+dbK5tRN+P/npI7ZAT7dJHJHVuuN6AvrozzvZwgGwQz+8gjWtNIvyFXNRafBjGlinlZTlNqBxgVVxhzysjVQYZ9ZuNKV1gmCRctU4IFUX/ZHhvkVgn5HWAbieVzZvop1C7dctufvYeCfpZ6EDEF3i8LGSqXCWc0FfC9Mqkg5bw62RJVIyPXfof0v8KA2fEB2VoWBRC+gdkDbR1CCpmnQC4i3vcL43yCIt2DVHVd+zwH6v3c+vILZ6JHod6VVDJmTSXVsOfjE2D2WHS9gGEzJpl/I4tFcQktsoJQAjsGvtydjPqVvUYfVLnchdInooSK6634xOBciZECcQPClc3KqRS/V+J4zqImrbLkPf9wk2t8XvPKRv/DB7YBewlNWrHPor+lODQ0t+UPZLHw682JRu8ka7Ql04qV7NUIQft8SK4G5LriUq/WKVLKvxg3oXc2TmJNLWgksiuc8uj2LzWHTSAIOcFB2kXHPTGa0rYksgI8NrXrrTjZw1nexysRZ0zPuqC6opImlkpR7kbYF6+x4p2fcnND/zwP88XurcwK45WhiDCNT4jLN0FCZtam5IZ0auSUXOEkSXEgp8dixAMtzS1if4LefwPW2YBW5hr9foAyHunjRkQ3DZpUuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGRhYWYrKzIyTDdiUjBZSXRUY2pMQm11VElaK0FqUjk5a1Vnb0cydWEzUlNi?=
 =?utf-8?B?WTJCaXlQUGJ5Smozd3lyQU00bWl2ZVdMU0IrYjU2Nnc3aGE4YnN2emVOV0FL?=
 =?utf-8?B?Mkt4YnNOZWQ4emI1Z2dTK2dybHVQc2dkSUpLeENKNjMza1puYlUwRFRmVmxC?=
 =?utf-8?B?UWRxcWlXT0ZaTFhoNE5Sa2s3SWV6YTJyNmVzYjI3VUVLalM3M056QkhXZXFN?=
 =?utf-8?B?MXpGYU13akhyTGlRcXVvdTB6MHVYeDRxNWZYdWxlWHVqOXQzZ0pXNCtiL3FM?=
 =?utf-8?B?Vm55ZEhodWU4Njh1ZmlhVnJ1aGd6MjZIUmVkK0FaU3gwRGdLT0o2d2R2WnFn?=
 =?utf-8?B?a09RMi9vQ1doMGhidDk1eDEwd3g1N203NVJwTkFWYnVYUW1NYVhSZ0o0QmVP?=
 =?utf-8?B?VHVDc2dlcE1tZ0UwWDBJMTNtcXdNWjVxN2xURmFlR1hMeElsdFRyUW9kZUt4?=
 =?utf-8?B?SmlnVnpadzh5dEszbVBYdXZPNWRZdHYwaTU4cHlka0V1dGJyOUtsekZSUGVE?=
 =?utf-8?B?ZEpuNkQvMjNsdWFxQk9wT25PNFFZNXRTaU14OFIzV0dqUzFPQXNDUzlLOS9B?=
 =?utf-8?B?alR3bVowTFdOTXhzL1duREplQjNxbk1uTEREM1NJQ1ZrY3hDS3NPamxBYmRS?=
 =?utf-8?B?M0RzV0xVZjFrWXRZSmRTTTd1R25hdTBCNUptSzRUTjlkZFJqOXFOdzkrVXJj?=
 =?utf-8?B?d3FTWE93N1Z0LzVTZWVPc1Z1alJETk9MQ1o2L01zUlF4TmJnQmhrVEV6MndJ?=
 =?utf-8?B?c0pXeVZjREhCaERzOE1ZbWxjR01xSFRRajY0MCtDb05mUTJHdTJiMHJGdE4w?=
 =?utf-8?B?THp0Qy9IelVWdnhJdnkwS3pQNlVxZEFxbTIvWUhUNmFQWllqVktqZlJITGdi?=
 =?utf-8?B?eGRoNTYrRTQzWklWM3FPTDZMbk1WRjYyREhzS0FVTXBtMjQzcEVleGFwS0hX?=
 =?utf-8?B?QlVLaHBIaTM0WnZyYjl2UDFZTnlwKzk3aC8xMC83SCtUMlZKcnZvckhVMVpT?=
 =?utf-8?B?NXM5NWxhODUrMVNab25rVTFwaTcrSlFsREU1UmN3amZwRjBCVkFEem1PektW?=
 =?utf-8?B?Q3Q0MlBuQWN2YmlPV1AvSE5yellBT0RzMWMvbFJJVmpKQWYzeUtHU1J4ajVu?=
 =?utf-8?B?MThNTm9JeGw2L2ZFNDRUK1o1Z2JnbndmRytWdTNOK2dVQTJpTUN3WlJtTmtv?=
 =?utf-8?B?ajBvaE91b3F1azVqNklSUmtUa1ZYd1NRRFlrQnluWlptVy90RVNlYUx2MTZV?=
 =?utf-8?B?MkQyL3YrWFVDblVmMFdWRjIrQWdsRURYcTN1N0s5TTU2eCtHMEJManJVUFo1?=
 =?utf-8?B?WWRwMi9oQTdvbXA5K3BvSWplUngzK1RNVFdIVkV3NmJrenNaa3VXQVUrTlFQ?=
 =?utf-8?B?THU5K3o1RU0xNlpKb0NIWjQvMTM4aVZzR1pKbG1QejgzTjZxMzUzRmJtNTRC?=
 =?utf-8?B?bzRKMmF6TDgwVkdyRUR4b0VWRUxWQ01mVjFkam5taW4zNW9velJMOEg2cXFl?=
 =?utf-8?B?NzRUenhVcmZsMjNpNnBwMW9MUktKTFY0SnhIcmdXczBZWEtzL3RhYURJRE1x?=
 =?utf-8?B?T1cra0VyeTJ2RHVYdVM2ejZRc2p4dlNkZDJMOHlHa3diZiszVWduN2JIQlJU?=
 =?utf-8?B?VUtCY2l6WHFTRFFZY2pZQ2wrOFp2MVMwd1krQytxK3hEZ3dCb2ZOdjZEbUg2?=
 =?utf-8?B?UXFyRlpOdm92anUzK2J6dzFIOVV4eFlaTnJialV4YSt4L2VyTXhSSmxLRmNp?=
 =?utf-8?B?TDZpY3FaWnNBMTlPZTB5SUN1UkJVWlVudzVGMzJuOWp5UjRjU2dHNVRzM0x3?=
 =?utf-8?B?d1ppejFlOTcwanc2bDJXRldxM21tTCtHeU5GQW90RjhxVkt3VVFuOHF6MXM2?=
 =?utf-8?B?SHQ3R1NpMUVIbVFxSGl5UzFQaTBBbW9kY1JDNHE2YWtGWVIybVk5UGs0emNi?=
 =?utf-8?B?bzd6YXJDSkhQMEhHOXNSa2tNN3paVmpaTjZsckpZeE9TUUN6Z2Vxb1ZaOFVi?=
 =?utf-8?B?L2VXNEg3MDJHVVppKzFoOG1HU1VhU2hvL3l3bWZOQ3YzN3pyakNSOUZOS0VT?=
 =?utf-8?B?UXhPWnl3L0NaYXR1bHBrd0FLOXgzUkQyMGRrNjQ1bXhxb1pxUkVjOHpjcmpU?=
 =?utf-8?B?YUFNWEVaL2ZkUnRPNVFDZTlJbE5Pd2RTS1phUzFveDNiYjVMWTJRRnZoYWVJ?=
 =?utf-8?B?aTdNdTBObUNtc2g4UVdoTkVCNGxWSzA3Q2RBUExKSkJ5eWNsVm4reE9RVU9C?=
 =?utf-8?B?dmd5SXdxOUgyUFdPekF3SFNaa2lTWFlTckU5bWxuVGg5TmxEY1NMbFpzb0NU?=
 =?utf-8?B?Yzk5TVNybVpnaGRBRWYySFBqK1ZteVFXQTlhMHJHZWU2YTVyRHkzOFVuNmRt?=
 =?utf-8?Q?cOJsqzLZiWz+HV+k=3D?=
X-Exchange-RoutingPolicyChecked: W9fXs00OqXrqVcbGWzDacKGsyYv2lFZPtr9Up0MYr+iGBm9hY8simgpFpCANEYUqV1LtYoIcdo/UFLqsiI+LaPgCeDWKpkJsPU2/wzUIogfZglRQhAmogHwJCcHbyXEueeptlN7H0ZRbmZEXUVbLQO+MU2bvupCFsSh/8ItDodgCCEt8mq2pO+2FjGUISq6kKdhKtI/KKgF7kEnSjSvVU52ff5SA0YeR6k9v/J4RoL6FFwKnU6224iFV+1yb4BkRL8x4ACIbpX3UuOsgeS/uSamjJPRkbLf5EMLOC018+NMIjjcirWCC5Br2UMoSWMHwDAz7yY2SgZSaZGVtUvi5Fw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92034d9f-dc98-460f-70b2-08df02baf331
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:10:07.8572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JK23G6lkLjsIwPHJ1vb1+r7cPjTNxMzgRIvji/PC1vpJAxs1mKF39hIHxSLk1m2Cxj7bi5jWDaRdUYMyQbLNc4kTPd/MN1KOZYdCW8gjGJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8855
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyOSBTYWx0ZWRfX+zPDWFAWSavs
 FYFDxMuuBWR+8kW5g5zcrX3d5SgbYSudyJQketWhlQ6Y9PjSAEnVZsqvsX9fYWVm66kPH6jSkvw
 cjo90OzQrdrrQ6CVT8jEW2epVqV6rWo=
X-Authority-Analysis: v=2.4 cv=aJvAb79m c=1 sm=1 tr=0 ts=6a8db054 cx=c_pps
 a=p09nrIMaU8oQorgrX9pGYA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=_BW-VI6-JU7XRo9WEPIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XR2N6msHxBg3v-Jw9SIzj9oJNcmkpYqc
X-Proofpoint-ORIG-GUID: XR2N6msHxBg3v-Jw9SIzj9oJNcmkpYqc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyOSBTYWx0ZWRfX51cMbK8FpbFe
 BlCo4G1ECBwKbt5tHZ82DkoFrD97MLYyox5vStifVps77RYEqe9B3ZF2pRcOAPaJfCbLjNIeLph
 phSd5gRsQdJWkHVhVfT7WnntLCVFYGCHGWf8YB1BOJDuulMdWpauXvm7c80t8EVcvPDwTS8rWRK
 1V+qn+S83m9Ocg3PwCc/8/GsoPPAOsUwzfo0sZO3MXNnomYb/u0h5TZT+MpCaKiYs9kwLCm3QKB
 DLybe+VrY6FPrpC6eWK+DRWtn8q04M3KNFAMyOIa19tWvAVJA1aPaEMef0NtisTtH2cf+RxPxlN
 hc2ywAWHrferhCS7VH2EDk49wzDWINB+2/bQJfplB+zYxSFtGnc58w0ytNlo/D7f4iHGMV2cCZ4
 vdmh9PqiC87yTOE3BVwnj2lNDRUVnU4jGlgjuqRYwSnruPsl5bsVJg/GAtk+Ovd0r5FKuSitDdM
 uU0rfC5tyxWG0BHOylQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 18/08/2026 12:11, Marc-André Lureau wrote:

> The getter and setter use visit_type_int64, not visit_type_int.
> 
> Fixes: 7d5983e3c8c4 ("Introduce event-loop-base abstract class")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   event-loop-base.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/event-loop-base.c b/event-loop-base.c
> index ee5987ddbf64..23f554d92ce8 100644
> --- a/event-loop-base.c
> +++ b/event-loop-base.c
> @@ -104,15 +104,15 @@ static void event_loop_base_class_init(ObjectClass *klass,
>       ucc->complete = event_loop_base_complete;
>       ucc->prepare_delete = event_loop_base_prepare_delete;
>   
> -    object_class_property_add(klass, "aio-max-batch", "int",
> +    object_class_property_add(klass, "aio-max-batch", "int64",
>                                 event_loop_base_get_param,
>                                 event_loop_base_set_param,
>                                 NULL, &aio_max_batch_info);
> -    object_class_property_add(klass, "thread-pool-min", "int",
> +    object_class_property_add(klass, "thread-pool-min", "int64",
>                                 event_loop_base_get_param,
>                                 event_loop_base_set_param,
>                                 NULL, &thread_pool_min_info);
> -    object_class_property_add(klass, "thread-pool-max", "int",
> +    object_class_property_add(klass, "thread-pool-max", "int64",
>                                 event_loop_base_get_param,
>                                 event_loop_base_set_param,
>                                 NULL, &thread_pool_max_info);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


