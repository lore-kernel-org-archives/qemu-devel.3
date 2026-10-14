Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0D8CC6B27
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGuvE-0005ns-67; Wed, 14 Oct 2026 05:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGuvA-0005nc-AC
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:05:12 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xGuv8-000690-17
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:05:12 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E8GCtf3015158; Wed, 14 Oct 2026 02:05:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MJkJhmk4K2CoO6Q/hdS7xDeYcsLgRXA8TbeEypk0k
 Ks=; b=ZnFkDapCudrX0m39W0F+EklZJAgJ2cEuIlhPFtEZrOzTxoabqDUEJvQRy
 RrCVy+u65nN3LsrI+1yvgxd2Ob6P37dKq+g+SqOBFOS2rPaS4T4vWk4oM9v+ZjJA
 +OSARL8q5yMa02FBP5hs+Khwx8qVnLss5xDWAykauzyGuNNugaCDDDzLI6w+OKCq
 j97Ht5c0KKArrHPmfEkQvs6dues0BVmSzB6QT7TWT+zyJhf44ww+Dc4s1WGrVX+e
 73mFZb8pdo4GLpRrmVA4J3tj3vCXR4oO+Hoh41goolZB1O9r91sgmNxXO96jxoa1
 AiDvXrycY67R/5p2zzzzPHRq9lZFw==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023097.outbound.protection.outlook.com
 [40.93.201.97])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4h9pvvtdr4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 14 Oct 2026 02:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvq0UTSWPGLn31+9mtoa0qRYe0Fpj26BupmvPQL1SF6c92peZKY4r6nj57VO/kNfbWOM/+wYPMbtyDFrxbw5hSrMtbYiIgBby3W4K0UwAb8V+tNy10yXcZ6KuwROHJS3fqLYOiNZY99xz6lYaYZK81iC4+qFrlzk/TWFI8VfprymIqPjk2UFBOYSwWQxv2m0cRjhBCedXoaofvAOBTaCinu4VrLO9pdZvGJPXMQPSbJpx8vKJnExqe3I5/7Icfd3yp7z++9U8o34aBd6WkxU+2o/yxgOa9vDKfTafT/UfwBPoZNsfq8NnAEIuazWjQfr4w8MTfWfw1IaLr4A/CMcbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJkJhmk4K2CoO6Q/hdS7xDeYcsLgRXA8TbeEypk0kKs=;
 b=HjbE/U06v2hfP2D1AbuML/Mek5Hc5WK7ItFKu44AmrTSRrJTOfXzCfHKkKP+MPizCAU37iMWGgGlhDje09MydhkMjvWU7HTE0KQ72bp4uOu2dYteCV2H6igkZVvaraIFuM+Z1FmXd/nl3w8kI4Lg+Gmkt9M89yu1yVHGUq8mSeogrP4+VMTNyZv/Op2QfWcfCUGuuiQg+Z27O52JYamezCcQcfbUa6JswlBpOBjHS0hgzwrE3cb4nKX8Q8FneLNmYI0yGTBy7jGSCvI8HqY3QdXXy4kuAUDT5BVS2RONETLOQjZsZSVxv6cuveW1NaMgWTk/KUdERBnmghQ+K2dkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJkJhmk4K2CoO6Q/hdS7xDeYcsLgRXA8TbeEypk0kKs=;
 b=iVFLx/bH+JJBCDkcvSp4y+c5NzAZ0sBEfKi8Ln9fUcyk2ljp8AEG1POoLI2iGy5GGnkwGLfjaBfzAI0hOnwPSEwlinZZuZbxRpoCz4JYeiW+MJCqHOWbFdrHgpclqT9s9GEpcDnCoO/ngOlmqnfR09iSmDJTaiKkicf6TcicQznJBDb9+Hj3cA2kQ8Pz4+UQmnbzlb2AyBHdA4bWsnleD/0YoFMi3YMSlnkY7pxjku7Ey2g7dc25jxCA0P5fQJKzDqMICaU5NECgU98IGSnsgTVMtS6laoi5pXONOha9DlMDWx3+oRZRXz1eOFmU7jRKBdbcurEr6aFQUACXejvP5A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH2PR02MB6982.namprd02.prod.outlook.com (2603:10b6:610:8a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 09:05:06 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 09:05:06 +0000
Message-ID: <cd31fd3b-5b54-431e-971b-ee9a680a8c40@nutanix.com>
Date: Wed, 14 Oct 2026 10:05:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qom: deprecate use of instance level properties
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20261013120638.855671-1-berrange@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20261013120638.855671-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0279.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH2PR02MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec01b0c-d5bd-4a95-afcc-08df29d23d51
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: j9/UqSUbDbc777YC6RpJQJQFLsxKq5D5CuzxJJV/s8edFqPPmpDCVKQUHyigogW9tmzDijrv9hhbN0RCBWObeLYidN7Q0gGD11QXEmWS0mfmJ470kWGGJvj+BSKmXh/3oBw6tCIjXaBICRbFMXKKO4gPiGqvvhI1wWllyhFdMGJcC3K8KTzuXRYe7KcPN9+RNO4VoC42FwtS1Owfw7867vfRL1ShO0eisQjNduZW7xpZhF18xgI0HlNW9bAhcKPGd1V8xiAhdjBX3o4ECGL+OmXZLf3t4yB96HpI/D1lCAT/+DXsVgYPIpuMWMlU4lHwJ+O0tDEjJ5+B59KKqivsXRvCDIJiheteIPurbA5+WP6tRw6ZlXchKWWS01sB0oimDY+kkT+5L8ZrSbUJ3Oa7fXhmeapOvjXU6EhetTAd/ohg4TKEtNrkFt5EqvLU/8n5uXymyfLF6mpXQDjaHMeOD1QP97GlhkDvWbAb+XxRAyElcUNKqKxzycv1ebUy/lwlMS7Mp7NPALCouZ58hjCu8bJCj+OvXEAPiNdhr9n11sEQRsX2lDKa2diD6KOIKm1ru3LESfN9PJaW5Srm8uoNtNkKdXcazoIchz12sRf+79KK3ZL7wHW6xS47Be6DpK3Wg+iYEQhv1ivx4sHGcXkyFplv5zjhzgAWtQG5DYPWVBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2lMOVltRGwyY1ZzUjVwbklFZHBjSVo4bVRnajBFRURiR1RjZFZubjZRWUtj?=
 =?utf-8?B?dmVDem9QcFY2VlY0OFpYVVJDTmwwaGFHSmpSUGZaWno0a0piRGxzeGg4SGJT?=
 =?utf-8?B?RFordFA4T0dwOFhTRVNhMkUxaExNc1Y4a1VESm9SNzRBWE93N2s2bHZDL0o1?=
 =?utf-8?B?RHZCcldqK2RHL1RUOWt2aFRsZ3M0emExbDEySHdkZUl2YStUYWJyNTZIalRG?=
 =?utf-8?B?aHA0UDFxRytnK1E0S0lOZ1M2NlVGbXNqSk4rV1ltZGpMNEN1VFB3QW85bldn?=
 =?utf-8?B?Nks3TW1pWUMwYitFSUNQb2lFbG40aUorUm5hZlIwWGg3NW5KcURWV3I4N2dv?=
 =?utf-8?B?Sm9wMmNOTW8yaFhFdURReldKZm9rWWlDek1IR1IxQXhXVUpacW9Kb21GSGJD?=
 =?utf-8?B?c1NMeVIxTmRpNGoyREpZN2NDZG11VzU0NGcvSVJ0QVQ5TStHbzdzM2QyeEFm?=
 =?utf-8?B?NkNJU1JaYzZPemVwOWpxbTVNUkR2VFVMVFZiZmE4d3Y4RG44Y2Naa2ZDYStG?=
 =?utf-8?B?MFpib2haVWk0UXNGbEx4Z1dTSFYyWHJMRFk4ODR3YkJObkZYUjZISVJxM3RT?=
 =?utf-8?B?b0VIUFBLa0J6MWVYTUJCaDc0eXEyYlkrSnVxVXlIRExKNHUzYmlpUWRZTDhy?=
 =?utf-8?B?YzFiRWRtNm1XOFByM0RmN3BhL29ucnVla3UzbGlxL1lWMDdnTG92Y05JaVZP?=
 =?utf-8?B?TzdBMmhlSFhzZXR5d0x5eWNOdW1rVGYwM2luSGhyb3pOMStVa292VUZ1YkFQ?=
 =?utf-8?B?MmoyRjBOeGoxMVRCUTVicWRHZlF2ZmJkYk9LbDZ0c0xmVmUzWkRaN0RVUSts?=
 =?utf-8?B?dDdFckNMZHU3QUp3RzRrbzI1VDF0L1dVTnJKeG5DR0krd3J6OFY4VWIrTFFj?=
 =?utf-8?B?UzZ1ZTF3elVIVzFtdXl3UmRHUFBuQUFnUUNyTGduZkszRG9VajdWUkdiTkJ1?=
 =?utf-8?B?UXM5V2xaL2dpSG44UkRIeFVHWkFObG1MNXZYUnRuVEZpMS9GVmFFbEh2a0lW?=
 =?utf-8?B?ZnVvb1VSaGUzcVg2Y1JuNCt2Qm1qeXNTaUNVRkdWbExQYm9JYndhR0pibWhJ?=
 =?utf-8?B?ZCtWdjk5Mks5aEZRS1VOdzdRcjVCRjVsVjdNWVlNWWhKSFZkdUpRQ0lacytF?=
 =?utf-8?B?NzZWZmhVUzRoK3pUL3l1Ylh3NGtzanNKOW1ROTlaQ1NKYmRRUzJuZHhUeFgr?=
 =?utf-8?B?SHBOK1JSa0FqKzRvSlVnTlM3UEdrZHlJN3M1REpaUDc0VElOWExaVjkvV1pv?=
 =?utf-8?B?bzBZSXJ1cjdPU1o1Nk9uUmVNb3ozMUNINmVCNUNMR3ByYUNnUG1YcWx1dmdJ?=
 =?utf-8?B?U3NvN01nUlVBaFpHVEFCUlpXR2ppak44a296YXo3UmpUVCthWHRmZTNwMHo3?=
 =?utf-8?B?dXRxK1hvUnBLcGtOM1o3bjgxa2I5QmozaXNnaTRvcFZ6TlFYME9KNFBwTDlE?=
 =?utf-8?B?dlVJMFNtOXBJUlE2eEtOS0dqcmhRLzh2a2swd1AxSGIrbEpGN09XSGJjbUho?=
 =?utf-8?B?QnlxakVuUytYQkdablI2UDNUZTFxQkpLWnhMMXh5TGtzQVZrMEtZbVFyNmxX?=
 =?utf-8?B?ZlR4RDQ2aEEwV2tNMUNFelVTbG9oV0w5VDhUK1FtYVFURzVvYUVadmorcnpY?=
 =?utf-8?B?TWlDWU9IUEczSUVrVGg2TTZCRUFPamVOUDlQS09GT1Z5UWJ2WStSZ0VjdDdQ?=
 =?utf-8?B?eGN2TnF0WHVoNXVDQWFxQzY3TllleS9GSGFad1o2azFpSHdjVjJKaEk5c1lQ?=
 =?utf-8?B?ZXVpTks2YWJ5WWhSRGZ3WkwrOHBxY3ljU1R0VGR3bjJNTDYrSDJDWFFKN3JV?=
 =?utf-8?B?T0dleVdqblFZZTdObFc0WnZYUThRSGVUUENtVnk3OGc0ZVpOdVNrTlJJOVNK?=
 =?utf-8?B?aXkyL1YzNjJzbTQ0RzNxV280eW1jZGNhSjlvaW5JTmgrZHJWejNYWDd0YUVs?=
 =?utf-8?B?dytqcmZaSGpJcFpQYmlndWloYnI4SFVqd3FJY1JlcGNyQ0VjR1FLckNqWi9w?=
 =?utf-8?B?RlVSSEtDSVZvMUk0U1E2QjBnc3AxL0Z3OWRhVzhuN1VMMkI3QkxYazRYc2JN?=
 =?utf-8?B?ZDU0dW03N09xenlvaG81UmVaYU84bVV5VnpHTTdUN3BJN2lFOE4vaGZMQVN1?=
 =?utf-8?B?QklrRTlXK0VTWjAzcjB1QWV3S1dpRURKSDdrNDFxN1E0ZDgxMERTajR3dzNr?=
 =?utf-8?B?Y0lBZUdZQUVwLzV4NFA3M0ZxelRvYjBZdzhwcXJaN2cvTTNjWDBCaDM5SmRS?=
 =?utf-8?B?SzZLWVJuYlFHemt2U3hqTjd3dUlwRzNIMFNPZGhuOW1neFdwQ2NUUVJXMWU5?=
 =?utf-8?B?c1pCY2RFaVNwYUJrcGZPU3pwb0tEcGdZVVZnT2NmR1VBcmZMaWZJRjF6VjFJ?=
 =?utf-8?Q?GtlLCVDvbNmRjmeU=3D?=
X-Exchange-RoutingPolicyChecked: NV02ZRs3NejjQkNZjjA9kvg7cTiigmCnGKoeNeWLwBbvxaVv7URykz/a9qSim8lKT6+n9MTEy9nluyuqZOU4kaojcADha3uwPTcuRgn3YCFZ/ZCmiISWAGRytA2Sd9EMbcV7C257nhfig4EJQbvusO5pF/rA3sD7a0k5HKp6dEXtAnrz9IjQXs4lD84r1oC7mGacPuInpFo7EzVrGvXJopn0AYUPucr+xwZ39bSKImimnonpbW7XZadZWAX+BW9HfCA9mNEPMUHO2J/Z0413BUNWCh7t1zvbgqfljiFGAncc7qpXg2bl10i6lslS9H8/dFzoSwhdyfgTAWp+kREyNQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec01b0c-d5bd-4a95-afcc-08df29d23d51
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:05:06.3367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7SyZXnOTIY1O8ZUMEgSjgVXwELfhh1rjl5ZQNpY0MyFIHXb5Jq0lrVgdGDOAnhwgLEMOr+twy5nDJND4h5dbI51z8VYedZt/Y5PwBL+2W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6982
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfX9ggmwf/i3Q5r
 PcDKNrefeB/VAXZeO/omW1nroXttWFTqs92JHcnTSFjyxkBMwHjNyA1au/ohNg7QfwOP9ks5WBg
 juQIKctU3H0uIXpQ+L2BmBzPZm/aG7Q=
X-Authority-Analysis: v=2.4 cv=dfgVTnXe c=1 sm=1 tr=0 ts=6acf45c4 cx=c_pps
 a=jWQTj10e1my3T0yDjRtEng==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=zAWtGsxmfUnJxwSWWfkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dRFKadjOibOGKrJwyRX2k2NCAP9CMVQv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfXwMAQbunrSIDW
 oCwAleJIVzLplMKng5weQvA1oJp+5ZGUK1Nud/KKs6YtevRyZjLGqZN0EbuIyvrFbOQYzvVHmAs
 F9YemjbVGaDYmV2an9BPDz+4Q1k8IB2dVTBOMV3Nsq6aQhtkyltoEaa0UmR69Vpd3wHrVi9KwdN
 uNAVuXwlW2T/hkJflmc9xytxkJ0q3aA109pAPLbx2GUqHF4zzfq4C+ab1vA5W3fLhdBWMsRRFRo
 9IUnC+/UjhQbmtxzB57W361CqA6TjmNNCtOIllA4k8ONQeYp6J1V5VqRm7e2+pQ8FTstwMSBOpM
 SIfaOZuhlmVnM0h11kuya7EG04jNoTY/u53D3msbCBBMm1eWh9XaeGHipME558mrRFsSw3qPOQP
 i+UpIf9ViYc4EKUSdoFq1ooNqX4w3jJjsGXHl1WUvZVSDgf7FVC7IxL9aVxyTnPOdhyv5EQTvQE
 3eP+wT1OTRiduX4bWbQ==
X-Proofpoint-GUID: dRFKadjOibOGKrJwyRX2k2NCAP9CMVQv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 13/10/2026 13:06, Daniel P. Berrangé wrote:

> Add API docs to object_property_(add/try_add/del) to recommend
> use of class properties instead.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   include/qom/object.h | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 4c0645817a5..d3fddb449f5 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1171,6 +1171,16 @@ void object_unref(void *obj);
>    * @opaque: an opaque pointer to pass to the callbacks for the property
>    * @errp: pointer to error object
>    *
> + * Further use of this method is deprecated. Properties for an
> + * object should be statically declared against the class, and
> + * not be permitted to vary at runtime. Use the
> + * object_class_property_add() method (and its variants) instead.
> + *
> + * If usage scenarios require differing subsets of properties
> + * to be present, this should be handled by creating further
> + * specialized subclasses instead of dynamically registering
> + * properties against instances.
> + *
>    * Returns: The #ObjectProperty; this can be used to set the @resolve
>    * callback for child and link properties.
>    */
> @@ -1183,9 +1193,6 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
>   
>   /**
>    * object_property_add:
> - * Same as object_property_try_add() with @errp hardcoded to
> - * &error_abort.
> - *
>    * @obj: the object to add a property to
>    * @name: the name of the property.  This can contain any character except for
>    *  a forward slash.  In general, you should use hyphens '-' instead of
> @@ -1202,6 +1209,12 @@ ObjectProperty *object_property_try_add(Object *obj, const char *name,
>    *   meant to allow a property to free its opaque upon object
>    *   destruction.  This may be NULL.
>    * @opaque: an opaque pointer to pass to the callbacks for the property
> + *
> + * Same as object_property_try_add() with @errp hardcoded to
> + * &error_abort.
> + *
> + * Further use of this method is deprecated, see
> + * object_property_try_add() for details.
>    */
>   ObjectProperty *object_property_add(Object *obj, const char *name,
>                                       const char *type,
> @@ -1210,6 +1223,12 @@ ObjectProperty *object_property_add(Object *obj, const char *name,
>                                       ObjectPropertyRelease *release,
>                                       void *opaque);
>   
> +/**
> + * object_property_del:
> + *
> + * Further use of this method is deprecated, see
> + * object_property_try_add() for details.
> + */
>   void object_property_del(Object *obj, const char *name);
>   
>   ObjectProperty *object_class_property_add(ObjectClass *klass, const char *name,

Looks good to me, and at least it means LLMs should pick up the 
recommended usage going forward. Do we also want to update checkpatch.pl 
to emit a warning if someone uses these legacy functions so that it gets 
flagged during local testing/CI too?

Anyhow:
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


