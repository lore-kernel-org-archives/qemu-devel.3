Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 167F8C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyswY-0002cf-0Q; Tue, 25 Aug 2026 11:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyswW-0002XE-3F; Tue, 25 Aug 2026 11:20:04 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyswU-0008Fz-3Q; Tue, 25 Aug 2026 11:20:03 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEbbMF2345549; Tue, 25 Aug 2026 08:19:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wYNCrqZAc57JDhCfOpeJDxPkJUCM+Y2IEzytES2WU
 gM=; b=L+xUvYoKfarZ1BaduznhXhGncsH5CoWafo2LjeMF2XUl75616OIdPkAtZ
 YI5g7StvWCZEuMLW6xEkDHNkVc73Akf6DnYGXVThePyGXSkqsR1UTDw7tzjEkjFl
 5ypemocPs21AflnA0r6/D/sK70ajLPGXRLExQJuAEVkSimYva0YJYQDIA7Chdm8c
 DreSgMG0F2Du3n5h2+OmE85sXXBTxspjl3hitKYThnLf1ne4YdvsHFTcYZCbM2x0
 GQGcFJhpzpMjQ+K7YyigAM3FvAPuZPBaczv0XIRPqD3WmNTfD5IuNVJ8SIEy0Tz7
 PYcUJatgq/Fc3RVYUVocHG+qHiaKw==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022103.outbound.protection.outlook.com [52.101.43.103])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g8sy1tsed-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ge25hJ0tmJ1DxdWtxD3+a3OAWB5lN4sees45ftVn+Ky0jjg+EdhHREpvwcDOgdM+oG4SsCbBuIJQz8WbkzynwKuS/gAyeQ+I1s9Ks7Ceg2CLj8lRvG+S/P9OaXN189NLPnV5DbdevOeyTQt5FTA+hsXwwnQAaSqgOWBbbjUyLw2jIHWeE+qnzBy7FYOcmE15Gbz5BO7vgZEDq6At2bKjdN+UNC3ubqWDcExJnKiFjrY5YS5RaTYNIIOCY6nhdAMtDQHHkYeZYCGk6J6RDypGfC6OMX109kua2yQtLPfnjQKl90OVKVWsZk2nkOpBYjzlf1+x+FJEiPiCv/bZzOplbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYNCrqZAc57JDhCfOpeJDxPkJUCM+Y2IEzytES2WUgM=;
 b=ibkrx6hlIvxcsDEn9O98rVnxlbXPWoR2r175jcZHGa2yn0BHxplANfBb1/9PYFd39qpRdMyxFZ9hrctOjOn4JTMWoGG9BnhICW1j0r7ZQb/BB9FcP3Y9FVyPa/28hBf1+qJt4T4mKOM0quMmP6+RE4CdbHXiuFLRMi7P5iXoD6/FumslSYSIdaSNQF1y+m3tRWULhIna+3+5lCS2AMMOV0HL+eFoKypM83gT2ustQcQyHqZhnP9lsU78UhCFd5Ys76ikNedkrOaLftf3F03O3vdDJ/b8DiY2QLkwHY/R6kMwWOZcViX163HBR3gFdEWcJVfn7WXa8KqMr4zkGuaYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYNCrqZAc57JDhCfOpeJDxPkJUCM+Y2IEzytES2WUgM=;
 b=JO6753f6iMvzZJnyb3rO+CUXsLodgY9anHzsS3ttNL7p3H5fUp+Q6H15RpU30Q1L3Ky0ya++5XEGurEgVncRpEDiI8IXrVlgLPbWTyd5aX7e00i2CJoVhaqqKZr3cfJH0AxHkWJnjgVGfqfw3MqDOc9oXQ34FYn1wUeDw/xXIJYWnJkuy1lkp9eMOWrXF3ZZjcmRknHdK2mI+cbNzUxcuqa1GQ03809y+Q7BQy1UGZTL/ASN7t0FH/tQGyP/AHMSBeERAzXbbPxGyskre5QUPcaW9KtWgVnDx2hT3cTf2o02JoG4sHwXihRFrDxDhBLVooSuXtncudvDn9MkbpLyGw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB8562.namprd02.prod.outlook.com (2603:10b6:a03:3f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 15:19:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 15:19:44 +0000
Message-ID: <16ada8e4-0c07-4ecd-9a3e-e8a84132e480@nutanix.com>
Date: Tue, 25 Aug 2026 16:19:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 39/74] ppc/pnv: fix phb-id and chip-id properties
 typename
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-39-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-39-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:806:a7::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 9147fd64-7cf4-4289-eef9-08df02bc4b14
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|366016|1800799024|376014|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: AO2uXO4BFKxmfGl3sXTxQB4q9B5GDujjrxYdDbr3evkUCvbUElOT8rJ4QziwDV2FV0O4ZfGiZTT0TAEUNhMKJVCRgborb0i8fhqTnUWr4T1lsVLpm9KDQXFoEu6EltgG5bSyf2rocR5JtrMY8B67TXhoyC9zbO1Sbq+ZjPLh1SVdR7Sk5cNcur6p7FBeME1wH8AmVUWaMP6MHfzjrcdZ9R7mjYga6AnCZ4QpiIljNZiYYnfvkX8KvWsQDHGAuCvEIR8QdjtT77AP5PdD3O3cbrDoh32kY5s755cKfP5KuzqHvY8QHq41RN//xKk1jyebtxl/yK6GFlP+0Np+/2li4xusD1TxB7Pj911/pN6kGJon6gC6c8UVMkVae2DUsMjdJHpae8+buvg8KPEDgC7jVaklEnZYqvdtM26YI+n0nEa4eOhqegmYwmRADX90/YqnLq1aEPeE7h94tdUQ323Y1TgUe9kuhjKfUWh61D1XGPyuZ3iZIbV5Z35tuzOphTpugi/QOCYpnz6NwuojpaMVqrR74zJlQP6BUvB/fMvELof1ZYcUBzQSz5Pyu8ihfzvgLkwZq8ocEMvX54LwxZX3tQhVv/tizY23wadRlRdhbqo/171d2Y3AHufWCGb6DGJZBpn8WYYMwR38IxqJtwTu3tHrMEiE9V45Yud9HasyBOI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTZMVC96RHlJUXljeVV3ZHlzUFREOFpCaUVNVWJidFRLTFNxdEpMYW5ZeEJC?=
 =?utf-8?B?V1hTWjBrU2dLOWt5NUJ5OVNhelFFQ0JmYWN1VlFIR3lnSkZoaXlKWlE3MVpD?=
 =?utf-8?B?aittQ0ViQmxDMUp2cHU4QUd3ZU9JOWxNMytHZ1Rha2dHNEVtYmZYNFY1Vnk2?=
 =?utf-8?B?dUVXQjI2Ky9MS1hpbHd2bmZRejVzbW9KdFg0Z3hDV2NZTk5jN0NqcFFBMDk1?=
 =?utf-8?B?SFFoMDVYZjdTdWUzUjdiU3UxT3dQNUJFSjVnTUlSTXJ3NFl2QktleWIvcGhi?=
 =?utf-8?B?eGV4VzIvTXEzZnl5V1lpRmE3Q1hkdHR4Vk5CcWRMWHRCUFZOenhCMC9zWGh3?=
 =?utf-8?B?c20xTTJidVRsdjFpUHZ0TGd2S0hGODlDMFlZRHJDLytRRkVadG9HZEEzam13?=
 =?utf-8?B?Z2F2UmdWOVdpZ2xhL05mZDdTQVl3QXFKOHRvejdTaUZrOVRsN1NkMDByZU1J?=
 =?utf-8?B?OEc5aUZVUCt4dmU3azVOR2FDYmtDaHNPNFVrWm55UnhSZGlFSlJ1Z2IySklt?=
 =?utf-8?B?NkxubmVZVWNkeUVjRTFRd3h6THJzVm45dFBJKzlSdCtOcDBNU054L2FkUmw5?=
 =?utf-8?B?bUkrOEtqSlJQcm1IQ2o3V0p1QUtNZEc4YUpRSWtLb0VHTmpGazdoSEtJSG5k?=
 =?utf-8?B?N3llbWdoWVBFbUZmd1NyMXoxZ1d0NVltMHZUZFRsUXNueDRYT1VmLzZmN1Q0?=
 =?utf-8?B?Y2YvTlZXeHVDc1hobzN5WmJ1ZHNxbUoyZ1hpK0xRMjJoaW5ET3FLY2s1Mjlv?=
 =?utf-8?B?WnFTci9qQ3hXNFAvMVVmS1ZVYkQrWnptMEtSOGRmQVcveTB0Tm5taG9oNXZW?=
 =?utf-8?B?Z2hySVJ2cUtYMmx2S2x3MFJKWDNyU0grRmhhTUhuSVRMaFB1MEVaaXNhQ2ZK?=
 =?utf-8?B?RTdESi85WGV5MDRIdERyMi9maHdXMFhzWU9YbFFNWEpBeUpTRHFpWTNqZEVW?=
 =?utf-8?B?SDVTSEI4L0NhMjg3cDZ6VWpJaytKNnVzVHNPdEZqRXVoYTUrcFhhSEJTWnVj?=
 =?utf-8?B?M2JOTnlTSERzUVBQSXBXTnMxOFRNYmE2UUdHb0F3M2ptTGN2OEJadFNzWGt3?=
 =?utf-8?B?cWwvVVZMZWkySUpud29rYVNnUXJwUHpFd2VucmZzUnppOVEvRjJlT1NRRUh1?=
 =?utf-8?B?MVZrRlVEMjlEMk1VOTgyQlk4VlQzay9rQzlaSDJTUC9GNVBxOStzS1VhdVpn?=
 =?utf-8?B?aVZoRGU5VFBhT3hEcjlLV1d1UUhQUUtCZ0J4dmYwRzViUFlSZGRVd1R0NkFj?=
 =?utf-8?B?VUQvYVU2VjF1Qk9OK0U1Z0N2alRRTUZURkFrS0RoaEU4SFYxL3lCZGw4OVNE?=
 =?utf-8?B?cXljaDljczFRM0V6c1JjaER4TmphU2tyWVIzVFl5emkzRnRDanFoUS9QKzJ4?=
 =?utf-8?B?TTRoZUQyZXV1ZlpqRExNNEJkeHU0WjhJUmt0bUhGc3QrS1RzSmFvR25hbVVR?=
 =?utf-8?B?bXJYclMvbHc2VHF4cmdwZC9XcTZvRnN4dzBDMU1GTDlwTExmWGJqSkNPcmpS?=
 =?utf-8?B?ZTBsWEhkWW1HRThhVjJUT0pYT0dmNnV5QzRnSHl1RkZETWNJSzIrWkNESWlP?=
 =?utf-8?B?dk1LZllpQ1djMGF6WnFONDBUV0FKaS9SQ2xBWGtuWDNMT3ZXTzFSL3BvWG1K?=
 =?utf-8?B?VS9MYnFuRzhWcDU0NlMveWdEdm9Md1hONVM5QVF4eHFsblNwTVZhQnVGalJF?=
 =?utf-8?B?dzEyR0J6TmxlWnVJeDhReFZjS214Q1ZVMU1wNU5WOWUvNGtQeEhZT2J2emc2?=
 =?utf-8?B?OW1ubzB0SUgzbzFkM2hCaW5WMUQvSzMrNC9VSXV5SXpNdk9FdmRUcWhZa2g2?=
 =?utf-8?B?em1sUTFjWEFqZElyNWpGOXBzSkVyaDNpT3QxUkI1Z2FZY2ZDM1k0L0xMY3FW?=
 =?utf-8?B?T3BoL3M3RkMrbEZmUHpCQy9rSHlVaHNpZFhWOFZWWFhPaVU5V1F2SUtnM00r?=
 =?utf-8?B?b1hTMnpZOXQ2dEVBODJ4aWg2S1plT0VXQkdtdGNuamVvMWttYmNZRy9hVXNQ?=
 =?utf-8?B?RXQwSHBrTGFpQktMZG9UZnZpNnd4bTAwaG5YOCs4WGc4MW5sb0VKUVRqcnRO?=
 =?utf-8?B?Y3BNcU8ySk1MdGpJTjh6Y3BNVHUxVXhtTHJVL2R2VlRHYnliSXRQTFBvMFFM?=
 =?utf-8?B?bTROTGlWc0VDVGlJRDFpS3FvL1llclptVE9PZ2tFcnhqSzJjUHNwQXFsVlg5?=
 =?utf-8?B?UzB4WFRQMENOTy9Na3NqQ0NFMllPUWdEQjBtaHJINEFMMDk2MmovTzZpR2gv?=
 =?utf-8?B?QUZXdlozQWdlTlp5YTk5d0FBaGpNZmJhZ1VTUHBjSkoxY29jOWt5TktETTRy?=
 =?utf-8?B?aHdlaFA2K1BZR1lPVVVwZnZtTm1uRk81bi9HT1VhSmg2V2s0UFV5Mm5qb1FI?=
 =?utf-8?Q?3qDyrfqWqkNNKGxY=3D?=
X-Exchange-RoutingPolicyChecked: VpDfdB+UiWRymMU6heYBZLC0KXzzFikzs2LVL6oAOloL4FVYhlCIt6YIFGjBFy3oreHBeiFAYfK1im1riU5viD1cRQbx/hP8iZ5rHpjV3/JULmLTaq8w7t63ANMWFstWbqqH6pnBwI0n9DOd9+KjUIT0RAIzjm6/YMLSguDtDBBtRqg1eZuATxX6wJrldnYqMmjK+syDg/CIYKth2QfRenD+ovrydvtU/Y3oXleaejWoeOVwx1QYvXv6ugMupfWs7nBovvtnsN/md3ilTfCwrZ4p9g+z7OKF+UmmoCCmiK2qEa0gffgGsKbA/nK2Dr4+0+ey5rRJt3P/R0ot2roMdQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9147fd64-7cf4-4289-eef9-08df02bc4b14
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:19:44.7826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4cZfOBwmAsjuFOT4h65N/IYfDVCBmcMQ9rvAcidiTiZ2aIz3rI4rHPsp4oEpNz1eB0LQlB0AHojRgSUSQeSnzoNYwO3sU3uzudtV6F9XDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8562
X-Authority-Analysis: v=2.4 cv=La0MLDfi c=1 sm=1 tr=0 ts=6a8db293 cx=c_pps
 a=poLntA6gJg8PyknBlaXY5w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=ORMRJvYdrPmOGjTE4-IA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hcOLu-IScz3MYpriAqVnC3ddab_K47Iq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEzMCBTYWx0ZWRfX5Hb1AaZ0AVeM
 sw7EcEfG4mpavD4zYSvSKP8e+0bypJe4Vw6s0V/SFNpXGlOrtI0D7LeQ3eIfRWIg7ZSe7jY4YVJ
 zphpE4y4PHYsTLMB41V8/mk3ch7fZYE=
X-Proofpoint-GUID: hcOLu-IScz3MYpriAqVnC3ddab_K47Iq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEzMCBTYWx0ZWRfX1RM5L6zGRKDN
 59CAJQkQBukFV3PeS5Syee2f2CuafDoRirTkaY5+7n82vP9JJpqQy0Lx2kV4T6LExzxcv21peZS
 7BMxNiDTDV5lU9onkHBKoctKN4KSLNzsWXXnDYSGnrYhLG1eMPr33WHSPeLg4WRP2cpkVYBSNNJ
 ytn9nRx0mJP5IKqsRnbyEFrs6bxSCGBXrw6Bzj2+x0jQJ7rq2qfVDhU8jF4ULJTZC6PADOv0SII
 PVHVVPM+DH2qzar7nHasjsN+f2YqGcebDTUc6NfKcKaLH2jS9aFMkbcZErRo/QaDJ5RIYB4E4U1
 cG+7Fb68K4WpoRj+yV5DzrDUoOiSVZVwRoi9o11TukRc6Hc/fmsvbf40V0spdGBnBsbPA5uq8qT
 O+uWbek15IImGqIBAjBAwG+Dx6T4Vo5GqUyv6aJTQKrEY8z5kfNJhsdbqdIghv1ffgiNeMlhuB6
 d6tMFct1+rLmQtL4aWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
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

On 18/08/2026 12:11, Marc-André Lureau wrote:

> The getter and setter use visit_type_size, not visit_type_int.
> 
> Fixes: 8ec1e4f1ef97 ("ppc/pnv: add phb-id/chip-id PnvPHB3RootBus properties")
> Fixes: b7c1750dc440 ("ppc/pnv: add phb-id/chip-id PnvPHB4RootBus properties")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/pci-host/pnv_phb3.c | 4 ++--
>   hw/pci-host/pnv_phb4.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
> index 4ffdb4ce31ae..0471b009ec2f 100644
> --- a/hw/pci-host/pnv_phb3.c
> +++ b/hw/pci-host/pnv_phb3.c
> @@ -1164,12 +1164,12 @@ static void pnv_phb3_root_bus_class_init(ObjectClass *klass, const void *data)
>   {
>       BusClass *k = BUS_CLASS(klass);
>   
> -    object_class_property_add(klass, "phb-id", "int",
> +    object_class_property_add(klass, "phb-id", "size",
>                                 pnv_phb3_root_bus_get_prop,
>                                 pnv_phb3_root_bus_set_prop,
>                                 NULL, NULL);
>   
> -    object_class_property_add(klass, "chip-id", "int",
> +    object_class_property_add(klass, "chip-id", "size",
>                                 pnv_phb3_root_bus_get_prop,
>                                 pnv_phb3_root_bus_set_prop,
>                                 NULL, NULL);
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 705a5bcf074f..510edebc40de 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -1761,12 +1761,12 @@ static void pnv_phb4_root_bus_class_init(ObjectClass *klass, const void *data)
>   {
>       BusClass *k = BUS_CLASS(klass);
>   
> -    object_class_property_add(klass, "phb-id", "int",
> +    object_class_property_add(klass, "phb-id", "size",
>                                 pnv_phb4_root_bus_get_prop,
>                                 pnv_phb4_root_bus_set_prop,
>                                 NULL, NULL);
>   
> -    object_class_property_add(klass, "chip-id", "int",
> +    object_class_property_add(klass, "chip-id", "size",
>                                 pnv_phb4_root_bus_get_prop,
>                                 pnv_phb4_root_bus_set_prop,
>                                 NULL, NULL);

Similar comment before that in pnv_phb3_root_bus_get_prop() and 
pnv_phb3_root_bus_set_prop() value is assigned to a uint64_t, but anyhow:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


