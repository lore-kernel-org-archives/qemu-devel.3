Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C44CFC518
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 01:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcfA-0005zp-IZ; Fri, 21 Nov 2025 20:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vMbKN-0000zG-VI
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:18:18 -0500
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1vMbIV-0000PO-EX
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:16:38 -0500
Received: from AS8PR10MB6698.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::11)
 by PAWPR10MB7224.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 19:00:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE4ZsXPGmkwRXm5/uoWDcZ9KiIMbBUGS2xXlr4RWGYnMkG4p7MKvRoCBl2KfsL5KmLGJoQrQV6zElxc3i7j1+Bq6ZZLG+HAotKXSVJj1Ybo5OUnPk5R9cemw+IAQacUNUNbA05JovF2t52hPj+r8AHcNMLPlJA/+VTkiX4BavsPRSN/r5MpmGONKzEShm5ozakpNbYApw07x1NuGimlyHpxPZdoA7IFWty3CvKM1DsJzfsG4l0ckd8soRsrcCDytUtUPsmIFfVBGPW+vNB37linNhojnw7qfJMUwLJTc03iVyJWkOCxE+snWRHKbLcF9H8GIrT8N0+Dfw8JmF/9hrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Q9TrKy6+rhMrxDqVUaqR9KwIxMDn19PFDlDB61c9OA=;
 b=so0DhYcFyjDLWZ+N5lKd2e441hAGFlbI68vpurBJFib0+hR3iDkfl0SrgGoVuGbWcqdP0ZRHx8xLSfYDJnZuWp1x5mjSLOEhC0FXjruBTNd8um8Voo73rZm99PyJ6AZVEJKffVldCetGgOmSCQUQqt5ox69b/zlJvbiM8++Co9soM8trwpxI/aqnHidHy1ynfLTYT3a4T4CIAbouZ98Z6/iEa5xLOwXUmkNrvukxKDyeaOQ/koUFbPKy0ELcR/bnOygVFk0bJN6+gjxuLrMlSL83KqH4bxXCEaqhciriQhn6gO1vMLBGqbjwq1X79tRIGCLHxZg//fq5UhzcttKWDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q9TrKy6+rhMrxDqVUaqR9KwIxMDn19PFDlDB61c9OA=;
 b=gXwXR7QHHUcztlz4mfvxg8/CI+Wd2DVxl2xcIvD5KG86zrT06rcY09rXxFvq4hauAuXYi3WB9RkQYxl57iSSdS+mePvb6Gh76zxcvv+LayRnwL+95W+f6konDTwTpGpEIlUsOm+8lXRr4xoF0OsfykSNPQjLBCwIXqOjC0NtwHi60pnobOgLTxtqzrQEWGpDxhaP8zidVzyn/FgyjcdfPT82WZx1GTRO4Ma2KkAHYKalARD6ZY8k4YYBzDfvw5bUwglLThGLWBWMUlodw3coQsHJWG6+mAXZZ5vrc1SQ23pm43RnUUgdxR4qwzAntDjARp2nDVjR9kdpxObFpdvFaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6698.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 14:10:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 14:10:55 +0000
Message-ID: <36baba26-5443-4d38-af7f-cea24e00a202@siemens.com>
Date: Fri, 21 Nov 2025 15:10:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] scripts: Changed potential O(n) file size calculation
 to O(1)
To: "Schwarz, Konrad (FT RPD CED OES-DE)" <konrad.schwarz@siemens.com>,
 "konrad.schwarz@gmail.com" <konrad.schwarz@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "philmd@linaro.org" <philmd@linaro.org>
References: <CA+kmUXafV4PPo2t+P23g9QRXHjaH_XBke3DjzbvciqBtw+i-OA@mail.gmail.com>
 <dee22f22-c2e5-4154-99a7-525bfeb965af@siemens.com>
 <AS8PR10MB46806BA652BA28B4BED9884F8AD5A@AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <AS8PR10MB46806BA652BA28B4BED9884F8AD5A@AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6698:EE_|PAWPR10MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: a431a850-be83-4056-ed25-08de2907c980
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1Bwd2NnY2FnR05XNU5zZUhUWlZHQnp5b1lLUVpoa1U5c2xjM3hSenRkYkJt?=
 =?utf-8?B?SVh3NStldmEzR1J6SFUxZC80Vy9yZGpJclVXY3BQNnRvaXYzbnZhOWowdWM4?=
 =?utf-8?B?ZjNMeXhNeGdpL2NiV280RGlTTVIvWFcvVDArejl4YnJtT3JlVTRpUGtkeWdY?=
 =?utf-8?B?NURjSVMrZ0l6Q3ZUN0hOTlkwdFhZQ3RjVVpGZVMyS3NMdTU3UEQzSW4wTHBB?=
 =?utf-8?B?Z3RGNlo3Tjl4VkNkdkc1OWdad0VseU9LMllEbVJwam1oQ3ZJdXlla2JvT0dr?=
 =?utf-8?B?bWp1ZGNqcUR5N29wQ0JjeUwxWVY3RnArVEJUaXB6am1hOGZuY1E5L2c2Wklk?=
 =?utf-8?B?dCsxdlBjOVJ0ZUxZanptY09MU0dZaGl1Tm5wOVg4cHpBTVBUU01Pc2dia3Z3?=
 =?utf-8?B?c0xROVlkUFhaQWlkV2JTdk1sMS9JR2tCb2c1SEI2ZU1kY3JWbXJmNm5SU3NX?=
 =?utf-8?B?alBaL2RwY01kZVJzWWV1SjE2UTIxK1JMRnYwdlRFUHVkUnNIZ2o0U21WdVlh?=
 =?utf-8?B?YlRMcmRRTDN6dDV1cGRSWWttaWt3VjE4bzR2Mzl0SldRNWJJaExpU3g0SDdU?=
 =?utf-8?B?Uyt1SVZWSXdUZXYrMm9IMXlKZ3NwcTNBWm96MkpscmFGTTlrZThPUzRCVUpF?=
 =?utf-8?B?dGF4aFJRUmlzYXY0N1AxdDJQdnN4WlFxclZJbkFoenowR0VVM1dQSE9FN1Nu?=
 =?utf-8?B?WS9HaWpsOU96Y3NyL3MzMkVybGprVUEzZE5iQUVYakliTEdtUWpSajRQNDJH?=
 =?utf-8?B?NXFxaUtwWU0xYklBMjJNMlZibzNNQTdSVmtkSCtuMzNWTGZzMFRYRmxpdWIw?=
 =?utf-8?B?dmNKMFN0b3VncHhxN1dsSmQwTjBQWFVIT3R1YTlaR3BJcmdiR2VtRENkeElt?=
 =?utf-8?B?ZXFhWVphN0VBc1lSTzQxbXZ0Ni9ZV2VoaDRjYTZQNTNObUEyRWZ3VzFHYm4y?=
 =?utf-8?B?UjJOcjljMHZwMXhkNTJxZTVQMlg3WGljbHpTQlFmRXlTZWRON3p2dnA0Ly9r?=
 =?utf-8?B?S3diVUdFa3JwTjlaVEF1SlgwU29haWtkYjE5a3pPV2NYYS9PY2tJRSttVEh1?=
 =?utf-8?B?OVNHYnRQajkyUU5kZFFSK1JPWVB4Y2xqeis3Rk1wWnh6TGhBWit4TFh1Yk8z?=
 =?utf-8?B?NW14a29oblFrWDhqOEFxS3ovVzNDSHkwOU91YnVsRitWOVovdmQwOVJiT2lq?=
 =?utf-8?B?ei9mZThRbTNna1ZFaTBwazBvQ2dObzgxQTJzRWVOZmJ5WGZIcU5rMlFlSHVX?=
 =?utf-8?B?akdET3BKdDFSQ2xWeGYwQk05aXBkMlgwR3M0cTZlVUY1NUdkOVM0a1JhWVRj?=
 =?utf-8?B?NGJjWEc3cGtuMVAwN0FSaEZsK1dCb2VybUtWckhQcy8rSUc2N2VBeThTbVBr?=
 =?utf-8?B?c2g0Y2M5TlpTUTNIMHNRek9QRGFCNUJpejd5Z3B6UTk2VWJRdnQ5cG8rVS9z?=
 =?utf-8?B?bjFoRWdsd2JuemRhTGd0MDM5ZzFhalBVQkRBWk14aGsvTnJJYUplTisxWTh5?=
 =?utf-8?B?RkIwQkxHV3EzMGtxQmgyb2V6N0o1cC9HZEZnOEY5NUpnNzdJcElhNGEyTk5i?=
 =?utf-8?B?RmRpaVk1dmx3YTBTU2cvVkJMZ3VNQ1o4YUZsbGF2ZVZrOUdiQWtwV0k3bkgv?=
 =?utf-8?B?SEZmTXlHSkxLNHpiMEpVT3d1WU8ram4rTDRFTUxCdnBBYW9YZktpbTRxbE85?=
 =?utf-8?B?c0NWNC93Wkp5bWlDNXBxU1ltS3dmTXdsTmd5TkNzQnpydDRXbWxQN1UvRGZr?=
 =?utf-8?B?dmRBZ1Yrb2VGelRtMHcwWUNHa3FWVkM2bkpvRHZKSEc3TElzd1llM0NtdStn?=
 =?utf-8?B?V0FqRk1jOUhvanJhR0hldTN4dUhvR2Y5UGlFNzBHNndOVndKaTB5VzF5RzAy?=
 =?utf-8?B?K1plL0l0VjV2Nk9mS0xoaVZYbVArVGN0d0pMQmJZaHVXcHNqdXZLVmN6NG5w?=
 =?utf-8?Q?88jPxCnSzrbuEFWZogAmApl5Nc4pzeVN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clpoa0lpZHVOTnF5OHl6NmVNUVJ6MmM2alB0aFUyVlh6VDcydDRWMWVqQXdL?=
 =?utf-8?B?dy9pYUV1Q1d2YnZNNEMyRFJtbEozQ05rNDFTN3IxOUw0Tm9TbzhBQ3ltVm04?=
 =?utf-8?B?V2NFWnlvcWJuUW81REJubGFVTFZOYXI5aFhDOHpNRC92NTRTcnZWeTVsNXI5?=
 =?utf-8?B?MmNhd1BYZEY0Sk1TTy9ka0dsMzQzVUNtYkJSZWxNWjJQOEZTaGxQOFZwMXdi?=
 =?utf-8?B?dElWVlczUE42UmxJMjR1RStLT2R0UjhndGRPWWtzQllTVmIrNnlzaTVGaDB5?=
 =?utf-8?B?WVNlYjEwY3l3SGo0QkRlSCtOQ1g5UHdhckN6eTBaMjNRVllZUTJuUHhWSkFr?=
 =?utf-8?B?a1l5SVpEVkd4RkY0eHpQYkdDUzU2WHRGOEUxU1BiRnZHMmpDV0RZTzJ1YTQ4?=
 =?utf-8?B?eTVxSm0wL3FEK3ZTNmh4RzZIMVNOb1IzTHh3T1VtZXFaVTIrK25sL1lkbExE?=
 =?utf-8?B?YThOSEVJZmtHNzNoUXlYY2N2OGtpanBqdkJwUlFwVHQ3NGtpRnNrOTZrSXBG?=
 =?utf-8?B?cnFzTGtpRm5UNjBDQzllelVuRTdQQmV5ajNxdEhXMzFaMXNDOXg4RnVEZ2Ni?=
 =?utf-8?B?aS92SEpMYUk1NE05TkVDZ3RSSGxiT3NTVDZNVm9qdC9ndmRPcTFmNldwSmdp?=
 =?utf-8?B?V242UWVYWFUrdVlqMGx0ZWpkaHNhekhpSEI2N2FKcWp6K2RDSWh0MnQyZ3hQ?=
 =?utf-8?B?akZxOXE5MEtwWldKVE1UTUN6VjUrYjNQd05kdkVEOEoyUXJXa05ZbU5zQU5v?=
 =?utf-8?B?NlUySlhmZ2xkMXZuOE91K1lWaXphY0UrK0NLRnQzYVlmQ3pNWmExQUNEZWdE?=
 =?utf-8?B?R2Y5S0ZNcTVTSkJ6L3FYZDZXblNvU2VlNmlmbEQwekM4Y3M2TWdKK2YzVnV6?=
 =?utf-8?B?ZXNuNWlGYmV4eGlhVkhIaVFyN01ZZzl3V1NVU3pYdjF1ZFZWMjVwUzRhRVY3?=
 =?utf-8?B?ZHhETkUyRi95VjJSWHN4aGNBdXc1YjZPNXo2T3Q2M0tCT0hPZXFjdktLZFFu?=
 =?utf-8?B?ODBpYWI3WEN4eGtiYUdhMmhuZkVLT3ozblJyR2hGN0hsVHNFQ3JDL2h0OStk?=
 =?utf-8?B?Z3VzQjJsUEpOSW9UMS9BaUREemt1Vyt2Z0VKWjMzK2o5T0EvUHkzRmp5MEUx?=
 =?utf-8?B?Wk1odS9oaUJRMDZHOENCRmFFek9oaDVscFI0L0JZL2NjNnBFcUltSUkrOEJz?=
 =?utf-8?B?UTVGQ0pDYnNoOHYrazYyZ0xNQm5wazZuK3c2b0ErRGN2VWJ1aVhIQytrQk40?=
 =?utf-8?B?aVp1cDFzTkhDeitnc1lMdm5oTGIzRVpSRy8wL3J6MDVGRU5PUjZqQlFCYzZ3?=
 =?utf-8?B?NnhjbkgxT3lVcFc1em9IamRJalZBbFBjRGIwaFV0eG5aMW5LakRGUGVYWUFR?=
 =?utf-8?B?S1dvODcrM2xENGVYV0luTVhQc0dIY1lnYmFkZWMxM0UrMkcrV0t3cnRwa0lq?=
 =?utf-8?B?V0JrR21Mb2JHaGtGRzdZUUlJaHFiZzBzM3RKR2xBeEQ0a3VvcEFYYlFtMzVH?=
 =?utf-8?B?RHh4RWtWQ1dSa0UvaWZwOVVzVTN2N2lpM1dwRmZnMDE0bGxYMjBLWU1SeWgv?=
 =?utf-8?B?bHMrVXJtVnFiaVZkMkovT2tEYmpLUVhmb2YwQjdxV0xzVFMrenhsZFY5UUpa?=
 =?utf-8?B?d3gxMFVHZ1RKbStLKzFqck5BN1JtTEc2NjZHVWpCajl3OUJqeFJzcmJwY2ti?=
 =?utf-8?B?eFIybWdoWXFrcmlNMWYrNEZlUVdxcVFjWHluVjgvNXNWblNUZU15QmRhWHZ4?=
 =?utf-8?B?eDhiclFqcmljOXZRV3dkY3hPNWQra2NDTmJDSzk4ZDBsbTZMamxTYlVUNEJ0?=
 =?utf-8?B?QmF0MWVSRlNRNVRsWThnV1JMeDVWbHVNZ1lvWDZidHQ0b3VmV2dZVDVFMHRy?=
 =?utf-8?B?R3RMN2Y4RzduTUV3WFVMT0ZMeXZndGpyZ2VIR2dYWlZ6aElxR3Z1SlZ3WG1y?=
 =?utf-8?B?OXpwMmFYWjJIK3dHNDNPYlM3NW9BSmx0ZWpBRjhHclZkb2x6Y1V6V0pjRkJS?=
 =?utf-8?B?dmw4Kzc0bEF0aFdEMjdQaEt6WkV0T2FHN2hId1dUNG1jTUNyMXlTT3RYbXJU?=
 =?utf-8?B?ckJKeWg2VFE5cVVnQWVGTGN2TVNBYzFUZk05K3FRbmxocVloOGt0TkpwSW0r?=
 =?utf-8?Q?hJmdKu/uGOlm1eHY3a4fmV7Qj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a431a850-be83-4056-ed25-08de2907c980
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 14:10:55.6577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiIi7idVOULhxN/O3NAIosqrsQFWvrv4WHsmZhiXRUk85DcuqpKDNDLafdAoCM2hixeK8rVyj5UkXPl/HGiG8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6698
X-OriginatorOrg: siemens.com
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=jan.kiszka@siemens.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: 6
X-Spam_score: 0.6
X-Spam_bar: /
X-Spam_report: (0.6 / 5.0 requ) DKIM_INVALID=0.1, DKIM_SIGNED=0.1,
 KHOP_HELO_FCRDNS=0.399, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 21.11.25 14:32, Schwarz, Konrad (FT RPD CED OES-DE) wrote:
>> From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
>> Sent: Friday, November 21, 2025 11:16
>> Subject: Re: [PATCH 1/1] scripts: Changed potential O(n) file size calculation to
>> O(1)
>>  
>>>  scripts/mkemmc.sh | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/scripts/mkemmc.sh b/scripts/mkemmc.sh index
>>> 45dc3f08fa..d2c4e84b16 100755
>>> --- a/scripts/mkemmc.sh
>>> +++ b/scripts/mkemmc.sh
>>> @@ -37,13 +37,19 @@ usage() {
>>>      exit "$1"
>>>  }
>>>
>>> +file_size() {
>>> +	ls_line=$(ls -Hdog "$1") || return
>>
>> This will not suppress the error message when a file does not exist or is not
>> accessible, so:
>>
>> ls_line=$(ls -Hdog "$1" 2>/dev/null) || return
> 
> My take on this is:
> 
> `ls' is able to produce informative diagnostic messages as it has
> access to `errno'. The additional information, e.g., whether an 'EACCES',
> an `ENOENT' or an `ENOTDIR' error has occurred, should in the majority
> of cases help the user in fixing the underlying problem. I think it would be
> counter-productive to suppress this.

Even if that was true, you should not fold this change into your O(1)
optimization and argue about that separately.

> 
> (In fact, one could go further and consider using only the error message
> of `ls' and not provide an own error message at all.

I intentionally wanted to handle the error outside of the low-level
function here. The caller should not care how the size is retrieved -
implementation detail.

But the ls approach still has a major issue: It gives a size for a
directory, rather than failing with "not a readable file".

Jan

> In this case, it would be especially easy to return `ls' status back to 
> the script's invoker, by simply invoking `exit' without an argument.)
> 
>>
>>> +	printf %s\\n "$ls_line" | cut -d\  -f3
>>> +	unset ls_line
>>> +}
>>> +
>>>  process_size() {
>>>      name=$1
>>>      image_file=$2
>>>      alignment=$3
>>>      image_arg=$4
>>>      if [ "${image_arg#*:}" = "$image_arg"  ]; then
>>> -        if ! size=$(wc -c < "$image_file" 2>/dev/null); then
>>> +        if ! size=$(file_size "$image_file"); then
>>>              echo "Missing $name image '$image_file'." >&2
>>>              exit 1
>>>          fi
>>> @@ -105,7 +111,7 @@ check_truncation() {
>>>      if [ "$image_file" = "/dev/zero" ]; then
>>>          return
>>>      fi
>>> -    if ! actual_size=$(wc -c < "$image_file" 2>/dev/null); then
>>> +    if ! actual_size=$(file_size "$image_file"); then
>>>          echo "Missing image '$image_file'." >&2
>>>          exit 1
>>>      fi
>>
>> Thanks,
>> Jan
>>
>> --
>> Siemens AG, Foundational Technologies
>> Linux Expert Center

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

