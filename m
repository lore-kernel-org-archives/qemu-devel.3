Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498A5CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtUR-0004yW-LJ; Thu, 23 Oct 2025 07:28:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1vBtUF-0004uu-FA
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:28:08 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1vBtU8-0007ku-UP
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:28:07 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59N6UZhU1669660; Thu, 23 Oct 2025 04:27:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=ZRO2WOqBUwUwe
 xNaXEYUUtRLIKt3GgjDzkS6rIV99bo=; b=pHiyHKi6il4UxjZyV1nlMK4MW080H
 sBe+QStkGy2PMeqUqvcBb91K/PH+hZHRRhk0Nr8rIytH8nHs2cBWoKmbIBf7CELn
 Q3AuEt/kOKU4y2pjYwByMg2ayU6hZBYwMU34tjMeHtbQ4lkheyZOl3Vl7Sz9yeSg
 XkNg0WziolOUtNTMxG1ZMIS5sv5qV5VbwZ8KIyOTxrgzK+/trJ8+uuGqfeLBE4Sm
 oCYSqR70qczB16a/xxDqoL+zbft/r6sTLblBrI9DLgzPOXhLeCRF/h18zbQuYAEx
 pZkX83WRObC76BZCp9h41Lv+k3i6iJernUOJznlQb/KIUm6Yy/6qZZyGw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021090.outbound.protection.outlook.com [52.101.62.90])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49xsc0bpgd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 04:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1VurxP7AZOvjHnPV1jUFlQKllKgfmhYDyHDS+yDswovw2LRNRPR+wwTUcijEjuT87g6WbiMiuXIhC/bkMceZutmRPuUB1wZcr66rQxPDXkln7zP97s213OXeuyuIPRYx077q1nYhKhZsQ7pkMLjh88ZjRLLbMFc0Ngz4lrZFJwo3iApEAy0AokV1/CRKmmIJnuWoBptkQLn02WiW14WKDYIvgePC+1ooxt+VH0pz/7Jur2Ae6o49rKAJLiyb5WgPqJGq1WBherqN04ocT7slIkYAmCKR5VsoPb1t/m+2KqTGK8RtMZrOArfQWB91jrBpdm6zGJDLVGCBe+9y+2fTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRO2WOqBUwUwexNaXEYUUtRLIKt3GgjDzkS6rIV99bo=;
 b=gIpFHdcglZQ8FWYHajqHIr0aA+eM3rAMBwx63AOKzj+mmB9WZKfZzNtSGLEFsCue/o4krBmLwhh6q6iDgIEm+3meaH63l9uYIkMVb2U0rfWblUuU6ZnLJX7iCuLsS2qVn/P1W3KS/nS2mBKkZzPe/vdAJsNjZ3uChh6+HUVYMXqdvS9iTBcV1V9NzOvcInWYn8eBjLAfTHlmE7giemDz++f5vE/A4pDPoTtsmO9SoAB7hvJHFEpnb9jItepqOz9mHO/wL2qytQWPOr1S0i+yJHnLv5FgxZyt3W7jUJOIoM80Ka4iIuSl9AlsiMLqN/huZH9Qwgc6UbXTveXQnFE2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRO2WOqBUwUwexNaXEYUUtRLIKt3GgjDzkS6rIV99bo=;
 b=waAuulToo80DyecLtXAkZzM89rO18uUYt5Hq9AMUWQ/nSXn54EnZ788saIuiCIVFPTTXB+AIfOcgSsBgqkHgQEFacb+xaPdZEwvaCqpvXlox6ilOyM1FkUeoMyhutXCORTClj37Dsi3e5p4ZO3Ky/5F8AROp7lI45+3LpchIyJtJg7ICFWFOVNWETS3eH/1u315ofQveGph5p8rlsw3Wo0LB7hjO0StuTU265jluZHNKxkMG3HrqL7xqRgMRjoamAdzlmb2Qspetj6NjnGqVyAfGCI+uFkqmfjjyBNqfKXvvgp8rHku5EC9wMhj7GMmopl3c5z8SWrJ/Hs92aJvGnQ==
Received: from BYAPR02MB4838.namprd02.prod.outlook.com (2603:10b6:a03:48::29)
 by IA0PR02MB9488.namprd02.prod.outlook.com (2603:10b6:208:409::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 11:27:52 +0000
Received: from BYAPR02MB4838.namprd02.prod.outlook.com
 ([fe80::4292:5b12:892c:5222]) by BYAPR02MB4838.namprd02.prod.outlook.com
 ([fe80::4292:5b12:892c:5222%6]) with mapi id 15.20.9228.015; Thu, 23 Oct 2025
 11:27:52 +0000
Message-ID: <56a2ea44-7633-4858-8b04-def663322af0@nutanix.com>
Date: Thu, 23 Oct 2025 13:27:47 +0200
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org
Content-Language: en-US
From: Lucas Kornicki <lucas.kornicki@nutanix.com>
Subject: The impact of vdagent migration support patches on windows SPICE agent
Cc: marcandre.lureau@redhat.com
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::16) To BYAPR02MB4838.namprd02.prod.outlook.com
 (2603:10b6:a03:48::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4838:EE_|IA0PR02MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed21c17-1c25-48ce-3bac-08de12273438
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ky9ZYTZsRTJFYnlHODF1MXU0MFYzeURyWTM4ZkJ2R01MNDE2YjlweXh2Y09y?=
 =?utf-8?B?djRTclJ0UWtveDk1OS94a04rSEprZGtZelpqNElINTJJK0wwaG92T09Hck4y?=
 =?utf-8?B?T0k4MFlncjJmYmRMMis2bnRTNTlLempJZ1pDRitLNjBZQnpndFJYeitTYm5R?=
 =?utf-8?B?bHlRczNxbFF6UVRTOHhabTM5bEtsOTB1blVmbURibnk4TDUxLzdSYWpxR3Nr?=
 =?utf-8?B?eDVQMVlaYncxT0RuaTNyQ0xDaXQrM0RBSGZZeE1aVUR2QmZ6SndCaTFWeWtM?=
 =?utf-8?B?cEQrN3BiZHY0VkdxQzlwSzkxaGo2YUxGVjg5Z1AxcHV0dmZ5SlFqb3JtYW9n?=
 =?utf-8?B?VnlsTHF0YjVTUFA1VWxING44Y0RoZjJZSi8vR0JKelpyMnZ0eXFwSkZUZzk2?=
 =?utf-8?B?NjNaQWlXRVBqMDNDQ0Noc2ErVFBabktBdlU4dGl0WmYxRC9DRlhzSmlKcTMz?=
 =?utf-8?B?c2xPeFZpNXZjUWVMN2RvNHFCN2NJcVFMdHlNUzhMamJjZXNQd0NXNVhvZXBN?=
 =?utf-8?B?OUZ6bnhrM2tQaEtiekVMWnZkMCs4TWFGcmtrdGdQTnFlNjVHbVZxdGRPcGNj?=
 =?utf-8?B?MVRoZ2RGWmdqV2pMV2xVY1BzV0VkWFVsV1IxS2xFZmxhUFkvMkFXbGJUNnFx?=
 =?utf-8?B?dm9xeHFkdCtXMm1wYXBQNU5yNXpwZ2VpaFBUSnRZczVmMzFRL25XRUdSeEpU?=
 =?utf-8?B?dnZ5ei9tamN3K0xCcVpBRmRvVVAvNi9yUlBjUHFnU3RuV2ZlQnlmOFlXdDV2?=
 =?utf-8?B?aTVVL0dvdnRJTDJGM0pmY2VWelZzcC9UT1c5SVVCM1ZYendUQzhIeERaaWRR?=
 =?utf-8?B?OTY2M0JBbzN0YmZrTW80NVc2YURzTk1FM09adnVhOXg3NzVERHhhZ3ZnQXVw?=
 =?utf-8?B?QUR6U1REckNod3N4Qk5sbWF1ektjZFM2YytUdnZ0KzdacnU2amhCMGF6M1RQ?=
 =?utf-8?B?Wm4xYjdCOTZZWGozTytMMi9XMVJnZ3hLRU1jUVBTN0hoLzU5eEpVMGNZT1Vo?=
 =?utf-8?B?eFRBQ2J2M0hZU3hieUNNN3R2WFZKSFVyRm9NQjFoMWJQNEZxb3orVEErTmpZ?=
 =?utf-8?B?RTlTZXlVTUpoSEJtNEsydk1hZ2JndEV4UnlQOHBhbHR5aTJCWElLbURBeVlR?=
 =?utf-8?B?RUlwUG84V0trKzlvYWRPZTFBZFVZQ3JKVTZYNjUrZDBhYjNpaExXZTJIdlhG?=
 =?utf-8?B?NTU1b0hQZ1E3Z254TU5sYzZiMW5US0pzTzJsaUVWeSt5S0MvaU43b0gwY2N3?=
 =?utf-8?B?Y0xrVTgzYnVNaUxLT0pNSVQvSmxiWkZXWFBYVzFSLzR1Y1R4ZEJKeVNSZHRB?=
 =?utf-8?B?MHZsWWY5OUQycHhwSEpJbGFkOThrQVdORE1qRnRkYUwxSVZiVVpobURFTzM0?=
 =?utf-8?B?Z3MwK0I5NnZhUWdwdW92Wnl4dU9HUmtjTTlwa0FqcU9PWXBPeW1qZmNiRnds?=
 =?utf-8?B?aFMrMklMZDY4NzV1blJST1Y0VElOWkdVU3pEcjFUQ1dROUhpWFliaUg3M2wx?=
 =?utf-8?B?S2V2Yk16Y3NWU01DSHJsTmtaYnc4eGE2U0Z1Q0lGRlN5ZjU4L3RaVmwrbkt1?=
 =?utf-8?B?ckE5bGRPNTNnbHpsTEhPcCtVbGtQZllySExKRFBOR0RvbVJWdFRtRmttSFVJ?=
 =?utf-8?B?YThJZE93a3RCVDRzNU50dHluOGJJMkJuMkd1UzhTOFRqMk5KVDNXendVQjN4?=
 =?utf-8?B?RUpOc3NQRWJXQjc0cmo3cXdGQjVzeTRRcTQxRUpsN0x4dVpzRDlDWFFhcm90?=
 =?utf-8?B?VWZnQUhLR3ZORkpWZzR0cXZ0cEZjemM5ditUODNZOTVHMVhreEFBV202Y2lK?=
 =?utf-8?B?Mkl0aDhRQWZPUmlBQ0FEZ05MMlo1WFJSdWVDbzlaUVJYQTBhSmY3ZGFmQzlq?=
 =?utf-8?B?SWdJSGFLdElheWJRdkh4bTBVWDRiKzJwc2NvVGxKVjN4M0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4838.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3o3bWhDWXlvbGFuV0hwTnpFZWx6VTk1Q3lPall3RUo4aHBvbjhLQzBWM3Yw?=
 =?utf-8?B?b2cwOHVDMVlndEdadTVpVjNRYnh5eXNoWi83RXNKazl5RFo5dnJYVnAyMUxh?=
 =?utf-8?B?cFdXNmpGbEFleGRTLzBBQ1FTbDlYQ2NsRWM5MGdDN0poZDQzcHlnK1VGSUxC?=
 =?utf-8?B?TjJpZFpUSXhDMEZYTkhPcjVXdnVCVWEvU09WamJwcGRickcwYnllV3N2TTdN?=
 =?utf-8?B?Wm4vSGFRdndnL0NBMU8wWjJRN3htaEpYRnVOUGtyd201R3BhV3laN0xrNkxa?=
 =?utf-8?B?enlLaXRtclhTZU9TdndqV1RleERxOHMrTjN4UWxQL2FOcWdCblJpaXpjeVg3?=
 =?utf-8?B?V256YnpHS3hCaGpqL1RaNXgvajk4SE93U05La0FkMENTWnV2dW9DVk5tNkNQ?=
 =?utf-8?B?UXk1MzlaQ0x4VG50NVZGZkJJaTV0NnF4bzhyLzVlanROU3ZCZk5vUU8welB3?=
 =?utf-8?B?YlZ2Vk1vRmtlT1J1T1ExTExOZVdqSmFkM0YrcncrYWJxNVROaVUydDhQRGlE?=
 =?utf-8?B?K2ZWakwySmNvbGdqQ3pvMVZTQjJCcG9uZDUwb3dibUM5OFhBUWtaMFJOaU5m?=
 =?utf-8?B?QVZRejM0RGtwOS90bVpjVnBweWgxVngrWWx2b3FvVU1SMjAvR21JdzJFeWtq?=
 =?utf-8?B?NWhIeWxwR3NUdGdERVoyZkk3TFU5THliUmZpZnNvSkxPR2VqYUl4K05YS3p6?=
 =?utf-8?B?SDNDZ3FnT3JpZlRQZXk2VGw3bFZxN0FralhQL3h1MTU4SSthc0drRnBqbTdT?=
 =?utf-8?B?Smk1aC8zL3pOUzNFNUFWbkIxekdkbVk5SWova3ZLYW9OSDJIUjBBRGF1NlpC?=
 =?utf-8?B?TXRlKzdJTk5rd3QyWEFSVkhXZTZpNGlZOWNBdXJXZnFxRnJPdzZsUEVvNkts?=
 =?utf-8?B?TnRPSFVLSFArUzE0TmNhYlZjM1NVLzZKSVBHTUZqc1pHcnN5WlB5dGN0WDQ2?=
 =?utf-8?B?Zkt4My9lTlltOVgxL2p1a3VUeXJKNVhnUndMeW5PVnhjYVJQOXBsMzFlNkNi?=
 =?utf-8?B?WWV3K3F4VXFPSXFaN2VBcnlJNjIvSURRYlcwSjFMTExxVzNsWUF4cnV0THAw?=
 =?utf-8?B?SG95R3g3dDhuT0tiTXdTWWRZRzlRV0lBQ1JWVzBJbElOQkUyOXduWjlrd1Bn?=
 =?utf-8?B?R0JhT1NrdVJOWFJuc1h6TEp4SjFod0N3TmRqbTltS0tnRkREU1BNYnQ0WE9p?=
 =?utf-8?B?NXJUNCtoaVc5UEpGZ1FVUHRiSkZYKzRaTi9VUTZOb3R4d1k3OWQ0dllhWjlT?=
 =?utf-8?B?RGE4NTRHV09PcFNmaVlFa3lLK0RkN2hoT1dIaVVkWW8wUkRVeGd2RkNzVnpl?=
 =?utf-8?B?WlhWOFNwUHpGSGk1SHVzb0U3TkJpancxVnVybUMwNEVpbzZUeEpTcCtzdStY?=
 =?utf-8?B?QWpSRnZkNFd6ekdLaHlBbDVSMndyaHN3WHhYaDhaS1lwWlQwbXhyUTAya0FP?=
 =?utf-8?B?ZkZOcnhtMSswOGQ4b1drTStSbVVLZFhlditPUFdjUkNjN1hrQXdJV05Qa0t1?=
 =?utf-8?B?TU91eU9DU1MxRUliVHB1V2Z3K2dJckZPVUY3eHBkbDA2R0JqZlVUWkNqRmdh?=
 =?utf-8?B?UmVGNVNzSGNqeVVxcmJZSFhqQXg1VkhDSnQ1V2tFZldoTk1WVE1IcXhQZmo4?=
 =?utf-8?B?bm5HQVdMRENFOEQxbUtzWk9ISytkZWFrWHlVSjJ2TlF2Z3kwOWpyNmdIS0Qw?=
 =?utf-8?B?djdmYkd6azhLNExtRVhkOGlXU241eXd1b1hsSC9tWW8rRnpnT2NYWllWSTZK?=
 =?utf-8?B?WE9FdVM3RTRGcENucDlzaXpHSm9PMHY3RGh0cW95SnkwWjlZcHdZQWpTSkRE?=
 =?utf-8?B?RVluOEhsL0VuTms3bjdwUEpRVEd1bjVPZ3A5VU9TODQ2YjVVQ2R0UWVaRWtY?=
 =?utf-8?B?b0hNMFgxR2FkNkUyQ0NKR0kyOW5nUWNVTUxsallRR0I0U3N3YkVWcEx6Y2I5?=
 =?utf-8?B?SnhCQU9wc080SWtQcGM2aU4zTUNHeDJXdEE2YVNyTGFldzVoSE5GNkNYZlBU?=
 =?utf-8?B?cmtaNlVQWDkvS1hxakIwN1F4Zi84RWo3VGVLdXlDYmtMU1Mxb2JuRWNUdndS?=
 =?utf-8?B?TGNsdURPRDZTUnI4d2hMdjFTVFZWTGdMb3Rna3R6RkNaSGljNW5MOTRhdmNy?=
 =?utf-8?B?ZmVyQWovbzNOeW16MjRwTUc5SWxQcEswWlVCQnp4TUZlYXk3N1NjZlhEOStB?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed21c17-1c25-48ce-3bac-08de12273438
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4838.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 11:27:52.4871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNkKAdLxJOaisEQfbM2tjiAMM5AhNFkcoM/0qXe5oDMmMMWFk3xT2gWMtZ5dQoVFxbBWcMNU36u+NNzIouTmIJYwL4ecI4lPDv7O+I6falg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9488
X-Proofpoint-ORIG-GUID: TUSoYgrZUDM4s-XiN_dx1PDJk-0MwjhD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEwNCBTYWx0ZWRfX0qELjTyY1Fjw
 f90C4Nlvk6P9il+ttQK1iKA6SbZouyWh2acx0tlRqp6iylKpiys1/YbGN3hFRsnuK8rk/Y5znpY
 1OWOmBAE1Fm/HqjcCC2pVCl14ZHOuiwkIsofaEiLPdAslC9uIRU//Np4OAqJL9L+gmKu+CUobKM
 YRcXoL1YFjcJEolwdqCmHSn5USyKMOI6qmXZ7RnapX2PnRPQs5ltXrYzAD/deapvs5pOBMZt1Ru
 FYyeFvBqnMHd03UOa+jJJHTl3bYX5q2lCUbZhRJkp7pKckfi9Zo/MAO3ack1wIx2G63SOZK58ep
 HdZn+rzTkFHui1+DalsquyP7vKfDJG2MwSW7dGMSSHBI6RpaZBl36WgT7c9vBrbrvWJSd1bEU9H
 ghPTXRpvO33T3Ijz+kMraBw0nb99Dw==
X-Authority-Analysis: v=2.4 cv=TqPrRTXh c=1 sm=1 tr=0 ts=68fa113a cx=c_pps
 a=pMj1vk9pV3S8wB1vsTRRtw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=5Cr4ynSLBi9NDF5EDL0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Vxmtnl_E_bksehYqCbjh:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: TUSoYgrZUDM4s-XiN_dx1PDJk-0MwjhD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Hello,

I've found that using -chardev qemu-vdagent with a windows 11 guest 
and win32/vd_agent 
(https://gitlab.freedesktop.org/spice/win32/vd_agent), results in 
non-functioning copy paste.

Further investigation reveals that messages such as clipboard-grab are 
being sent from qemu, but they do not reach the guest agent because the 
VirtIOSerialPort has been closed from the host side 
(host_connected=false). This is likely a result of the CHR_EVENT_CLOSED 
event call done by vdagent_clipboard_reset_serial, which appears to be a 
deliberate measure to force a guest reconnect (?).

This has only become a problem with the introduction of commit 
f626116f9897b95f68e5514a08098d590349c22e (factor out clipboard peer 
registration), as it has changed the execution flow by moving the notify 
== NULL, check inside the peer registration function

-    if (have_clipboard(vd) && vd->cbpeer.notifier.notify == NULL) {
+    if (have_clipboard(vd)) {
          qemu_clipboard_reset_serial();
-
-        vd->cbpeer.name = "vdagent";
-        vd->cbpeer.notifier.notify = vdagent_clipboard_notify;
-        vd->cbpeer.request = vdagent_clipboard_request;
-        qemu_clipboard_peer_register(&vd->cbpeer);
+        vdagent_clipboard_peer_register(vd);
      }

This change has created a new execution path that makes it possible for 
vdagent to "self invoke" the vdagent_clipboard_reset_serial if it 
receives caps from guest twice, which wasn't possible previously due to 
the notify == NULL check. It just so happens that win32/vd_agent doesn't 
handle the disconnect too well, while also enacting this exact scenario 
by first sending a CAPS request of it's own, and then replying to the 
CAPS request of qemu, leading to device closure.

Was it the original intention of commit 
f626116f9897b95f68e5514a08098d590349c22e to enable such behavior?


