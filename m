Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B071C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbBZ-0007zH-FA; Thu, 27 Aug 2026 10:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBX-0007vM-5I
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:31 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBV-0001zu-Be
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:30 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE8mJg4152300
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TyolR4RKYz6+M4C3IEzO6gQ1cJPjN9UZspuNnymBn
 fA=; b=pzvuClLA1x5hsAQd50sFtS80LrYNnu6/HnlZTp1UfoTIU9VPlxVxp4glc
 aW+OGlMXCwMvwxHhs4XW0NUtbgAHK23ymJ8NdU/Es75OMrA1pbf11gR/inxPJjP6
 PLXDlbXm5y6mfkEZNLuC6fQtEkAb2CyVJqU4k+5xig2pNdsPlpzUZ6vB8wrufuiv
 UeX0mi0Anv5RnJ66RlwCFDGYVH4Z2BvaPTaa+nJaQETcdmbk1VWIQXn6QxWFqkM8
 x6rmurN/GuHAHLs+cfOIb/sp5ZQikhQoIIboLmAjGpEEDtMH9Ehyua61BcyNe98l
 ebCPYvOJs0fTUr3gSCtYiismIX8xw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023114.outbound.protection.outlook.com
 [40.93.196.114])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g9e1udwe8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XX8cl56oRVfO7NFB56qojHmiNVeJDORf1Dz3tcuZET2+vyDkR42e7Bgx7BMI4hKU5MZqfm7K6d8WM5SiH17rDxBtidAb+zgBAZlJxso4jSYLDYcdMclkMPtvo6Fjjlis83jANM4CVf8blYtoYVY8sb9iaEWiW8GNAewH3H7tM7JGGWalopFaQbQNcfuRrCwarPBtQqng6EpZoufQ4HxicFIS5bRbd9Y4bpsYjWaOZ+OtcM+ohZcQdTdAHMLp6zUENB45k+ByKvw2rN3MT9UTUBRS3A23ct57XkMgAhl2BSAyl0qiKHTBJsGLyWNic6o4LdUrjF3FYWwzlE/ahwQIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyolR4RKYz6+M4C3IEzO6gQ1cJPjN9UZspuNnymBnfA=;
 b=ZJPb03c3GYwhpm76F2tkjAn1WlGbV9EyDRv4zYotSTCx14ZT1Q1uUt5o4qELSXpIsInhLqhQpgqqP91ZJZMdu2JOCvVCBTiTr5iPX0TzuXOm7g9NMUSekjjNOxKISVsrbXczd/qePtQrDn8UbdMVcb7dnBAWAKcre5/Ffz679WopBj4YRB8taSJBFQBJ73eMZInGJ83inzsMbec3MVeMRIU49OqmoeA92Becb37NdXo+GADF+HnzADNii9ZKYqzFgt96v9CUwcYP2j48ZfeluKvw+d9wkW3cEkTLSc1uNLTWwFoKTVnyrciSDrVOUvW2C2hvk6PKGRKlv0F59rcWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyolR4RKYz6+M4C3IEzO6gQ1cJPjN9UZspuNnymBnfA=;
 b=Q/rZILEJEr1t63SzjD/jHjzMDE5NIFLGQSFalDkSb45HzzaUHXXcYCp07A4ng0VH7BYUpn0KOscIIcvh1rC/HagjocEhybe2z3XBE6SLuI4CyWu9n0qMJYs/YxQ+NyyjNODpG6DVkAKHF6qHAn56xyRFxhXyemIdY7jvyfl9CHERK2745jbCWytBZKSDjeQ0C/7ZPW26UwON0NBuR3z3HNfO/TjNPsZgXhuoEElY7mzNHzcLZ8fZzhlor+n0HtAnFj0xWbDbC7M2YfDwbiXrMEy0juj4ONPlj3eHvj7uiUQTpENvAxKh9ukePjE8dh7X/kEe4YSpb9d7rrAoCeB9Lg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8114.namprd02.prod.outlook.com (2603:10b6:208:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:34:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:26 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/16] hw/isa/lpc_ich9.c: convert ich9_lpc_initfn() object
 props to class props
Date: Thu, 27 Aug 2026 15:33:27 +0100
Message-ID: <20260827143404.1393166-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0192.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::13) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef928b2-019c-40dc-218d-08df04484b9a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: u9/R3wANwc9CMGf11SGTrdnyvrw/4b4dzo2sb6vcTOFqafa1Ey85sMQNBcoCVcw31m1fbigm+yhgnf1D+AJgYYT8yzX1pOs3QOVbDpbHv1f+D0uSEpwTRdh5eMd+HgsfUuMqtDOn9QilnH1p5XDhFfaKzLID4KHlLeAjTzX+/olVtvqmkyj1fcOpaZMlZ+IBI0zYytSrsKqTL0NRFngc5CmLHi+ozffVie0Xe9OhP8d8qE29hy5HuBmQum3g9GBHA0FHttkiwJQzxpBhLe0FQupQBsAJAf7hme+NBVSlbRqWNgUUCzo5jgCwSO1CVqQb0cSSSUAn1wmwkBD8mHxgGHKrVQvA6GKN0ltR/iIPwBZlzaoChmTAlt68n1GR98h5FWlR8kTH3nBuFvDZY78eIAf7M5eDhIBZ0cmE+dJ8+PDIFPO3hZ9BmcM59PZJa/mTxaf3qh1x5lYuDIAE9SV+NRvo6KgSVLvw+ujrbz1VL5QkSCrbR4mlo1XBxSCuH6ts9sRD++SuCIQUWhNy/1Rmf+f8KJ+pAlK7i4tIZNHgc7HvbYRqjxHOh2qy/3MXOl3z2Bdv9X+wfEGtaquvjDj6VX5igGVqtYKzOD2sc8n7ay7TmrNS6SZpB0sPuyNLjxPO+DOqNH6dQNP2KOz8I89BdvThLdFt89go9wubk6wWXDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2xXSk1IdDd1ajRDOVg3Rk0ySDd2Q0Rzc2MxUmlPY29jcTUzcjFiNG4vazNv?=
 =?utf-8?B?OWlJVWREOFp3UFNkTjBQNVBQS3N6d2VpVHRzKzBsbVdNdUN4Z3U4dUJReDJP?=
 =?utf-8?B?WlpGZUNsaHhha2dnQ1VyelB0MzdkR0xNZ21iakNReXR2QWRqQytLbHRiUzVB?=
 =?utf-8?B?ZFNzOUJGYktPcDNpQmlad1ZPTGxXazRaLzVhQTJtT09CYnQ2dDBTblVNUjlq?=
 =?utf-8?B?aXpaL3ZNWGJwczlPc3IvWFd0VTJuRkJTU2VTY1lITktsS2Q4TGJ2a0p1ZjNj?=
 =?utf-8?B?RFg1QTVXSFhhcjJyMmY2TWZLSFZKZjZTWFlaVUFEQTl2YUVwYkphY2NIWk1q?=
 =?utf-8?B?dVRQYzFaMUpRbVI0ejZIanVIRXJEaytQUEFsaUhIVlFFYStKdE4wYmsxeXln?=
 =?utf-8?B?SDFQRjhxeFpHZFR2MjJmZS83bE8rVHpvc3hNc1Z0MFYzVEZkUWpibjMrSmJN?=
 =?utf-8?B?Z3pJQ2JSTXdMVmhVSHlqMjQ5WXVaNUx3WlZDR3lxQTZFSm1jVUIvc0RvV2pa?=
 =?utf-8?B?dWxHbHhMTm0yRDdrbk1GTXdlL2JEMHBDa3I0eGN5MlVuZmpRRjNIQlBzbDdY?=
 =?utf-8?B?WkxVMndZc255NzNBeGlDZWcrTWM0ODJUVUFZSmZKYjRaVEl2NkcxVW9tTG4y?=
 =?utf-8?B?djl6eU1NNk9DeHlSVWVxODVSRzYwa1FGUVYrRGFaUG5TVUc1RTZ4aVg1amlq?=
 =?utf-8?B?djliK2F3MXhZVENvTHVMY2thTUI4VS9WaldZbHhSYm9VYkM0WUJqbEl4RXk2?=
 =?utf-8?B?Z2JEOU5aTyt6WTlSQTNieGVmTkRUVTFQenl2UWhIMWwzZmlXZlRrOGZIRXZ6?=
 =?utf-8?B?UHdHNEVWNDRWcHByejcrdXQxbXV2dUd4cnR6N3hPR0h3azJueHVnVWlNSUpQ?=
 =?utf-8?B?WGM5K29KUTd1bkY4cUIzSFhPMXpKQk1IYlNNV0JESHZ3THJvTTlJQ244Q0VD?=
 =?utf-8?B?UFVUalV5WUJsQktKWlVCUGlIdDh0ZjE2b0QxZ1VpbGZIc2lERkhJUXRVSXRH?=
 =?utf-8?B?ZWlHbjVvYm8yTlJFZUg4NlRhOG02bWRLcFYvTkZGSFZPc1lpUVNRY21XR043?=
 =?utf-8?B?ME4waitONFJ3aFFOZjQrM1R0NjMrU2xqSnpOVTBxMDk3ZjB0dzVlRGxQemVO?=
 =?utf-8?B?T3JtdHo4RVpjM28yc001QWRFbnlDRVFBVUp1TTRrdkJSY01Ga2Ewc1RWc0pD?=
 =?utf-8?B?cE00UDRWSU1XQ0tVemIwSm9STDFZR2VqSWtpekdpbE41eDg5T0MyM044b2dC?=
 =?utf-8?B?YlY2aXhrSDZDRVg2QWtXVENreWhxa3Uzdk1kdDZHUm1jRmlISnExS2RXbUlN?=
 =?utf-8?B?WEllbFdndU9qWEMzejVzbGVmaE1sMkMraEt5R0VsREN3ejRWVFpTT3czUUhX?=
 =?utf-8?B?ZGZZRTlKWk43eUZIb0NXejFmUUlPUUlyalBXQ0xncjQwMkthOE9jYmcyRzRu?=
 =?utf-8?B?MDYxaTZUak85T01GYTFHWXE0TFh6ZkEyQVdNek12N2YwSjR4djhDemh2UStQ?=
 =?utf-8?B?MFlsblU5bkJlZ1dYR3R1SmhRN1pPd29PeVlMWTNjekd3T25FUkxubUsvOVBM?=
 =?utf-8?B?WXpxK1U0Q08wNVlWa29OZHUzUE11TTRxWi96ZDhSbnRFc1VUaWxtSGlUMDVE?=
 =?utf-8?B?akVkOWlwYzU0dWxVcFdJSEJJVHJ2OURjZG9OVEg4cGlWbnE3VzJoY0tMOWM1?=
 =?utf-8?B?WWQ4cmcrR3lMK3dLQjRDRTA0L1A1U2NZNjZWVWpFbWlHcDVKd2lyaVYvTmti?=
 =?utf-8?B?cU4ya0g2OE1QeFZVaVRuMEV0eDBvNlg0NitxbDl0S3VpaFBtbGFmeGdML0NL?=
 =?utf-8?B?cXV0MFE4TFlRRWJzYzdYUjhudVV6K21sZjVsdUNMQnNya3diVDZqd2tYbUM0?=
 =?utf-8?B?REhoQ3VrajEybGpJMysvRmt3aC85NytmOVBIR2JMK1ZDMHY4SmpsZ1RtN2o3?=
 =?utf-8?B?UUNianRRWEVyYW04Y3ZtWm5SVTFJL1NockM4VjNrbXhIRnByT0NYWVhZOWJU?=
 =?utf-8?B?YmN3enpHSEh0V2M0bXBJWUF3THQ1bmdLVTdqZlRNVmhscjRZTk44YWlvTlJs?=
 =?utf-8?B?QlRTL0UwY1FFclU4Q2ZHaHgyNHFrZW9qVFRDclJhVmQ5ZWlrWkM0QVNERTVD?=
 =?utf-8?B?NG9NVTFudk0yVUlBd3ZObXlUdm43NjdzOU9MOWRQOTVPYml0RHNNVlVvanZh?=
 =?utf-8?B?UUEzVU9sQ1FVaWJXSmVkQ2ZQc0FYZ0hXYmR5VUR3RERJdWFGK29tbXlMOWl3?=
 =?utf-8?B?Ymhpa0RuMGt6T2p6MlFMSUVaU1RoYWszVHBLMGZoa2NCeklZMTlBcWtydU9K?=
 =?utf-8?B?TDFtY2dnMjRwMStvN1dtVG53b2FRTVg2OFIydW1oN3lxSll0YnBuSmVHaG9z?=
 =?utf-8?Q?UF1YAqo/WLQlNk1k=3D?=
X-Exchange-RoutingPolicyChecked: 3z5daTNpB8eEKkU19Mr+IMRH5knHJLwoRTwjGUdQDz/5wpg0m1gptusb/2nX2PFsFCrkHefi52NSv7YwHN9mFvcXUMTOvxDDzQD75IUMJ5HSSnPn8lBfWvkxoOMYGbrw21iP5IJTZQReSuyIhIGWW2Pc3AVegEOdUlN+407qXhQEXN0l+iLqLz3druu5F4rTM0hzgLI/QPWdcw8OaFKVdDgM69RBcXcF9FhIihtH4M00RP6ERnkwN61xXOA+fodjcQSpZHbXDDY1XXerzhmU75XPKEHnrj0ll0CBnbCTiFepxeZKalUt6daYRDp1HsahvLJot9MzY0cVYadBgrqEYg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef928b2-019c-40dc-218d-08df04484b9a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:26.4845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNZ5ihOcaxB7ygOw5Sx8vH2Rnr8pT1YTIbNvXRt2/xSlyeUfC8WQt+bAT8zsb3jQPdSTaj46J9Auft7YfPagWE8MuOUVF4Yn+P2wVhiwuek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8114
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfXwp7vMVBS2cXg
 BPVPZkvXYQn6N2qo+QSKjCH2gExCkVY+ZuYIxEV/nDWoFZAsbzAX/aBj5oSrcd/oT4I+PKheAIp
 UJHD55LkZe+3atJ3f53RPx02kt3Zsn8=
X-Proofpoint-ORIG-GUID: MQNLBl4-E5mc_4AfmVzxufg_qnF1SS1w
X-Proofpoint-GUID: MQNLBl4-E5mc_4AfmVzxufg_qnF1SS1w
X-Authority-Analysis: v=2.4 cv=RJyD2Yi+ c=1 sm=1 tr=0 ts=6a904af4 cx=c_pps
 a=qyFmUvwBvPvs2aQT5b5jUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=er9oOho3vt83iLenCtgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX88tWsvAdZJus
 L9z7R4cHWNgHXSJiMRxpCxYnAvui0iv2eX1z6D+wI+WWtOKRf6gVGusQSrQmJhy3LqovYNZ2NXr
 pfJDYiU6961mnqzjY6AG+aEVcZPULW8vKDS2dqWZ+yzde+KOkL+j2TINk/4IpnPtCN7jzaLaBrw
 CLFUe+Ym1TAFErDgHQzzQiWcwSU7EUhir6M+XjpM57GEd619KUjkaQ/qKpvvu3afFr5plVNqgFt
 UGduYnW2Ti1EZJTLcKfuSg/VPYZfUNwYNQvhrJzuCGMDAzL41IX85BrdGvJ7mW5UszOVf1pdsjg
 DXIoJ+/mDXVAOWtYKGsut1Nmy1pW5EPyaYocUdrEx305w0X1zo55H6Eapoc7g0fljgQu5LIk7ED
 AB1Tbim3X+SUmgq3w3E+46550PL7rW84rYL8qBXkuNe0Nfg4wj2nQYfQrisChpY3x9xU6XelAAt
 1Ajcm0T+UoKM9F7oqrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
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

ACPI_PM_PROP_SCI_INT can be updated to use object_class_property_add_uint8_ptr()
with OBJ_PROP_FLAG_READ, whilst ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP can be updated
to use object_class_property_add_uint64_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-Id: <20260825134320.1039012-7-mark.caveayland@nutanix.com>
---
 hw/isa/lpc_ich9.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index edf9783ec8..07c9509cf4 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -683,24 +683,11 @@ static void ich9_lpc_initfn(Object *obj)
 {
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(obj);
 
-    static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
-    static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
-
     object_initialize_child(obj, "rtc", &lpc->rtc, TYPE_MC146818_RTC);
 
     qdev_init_gpio_out_named(DEVICE(lpc), lpc->gsi, ICH9_GPIO_GSI,
                              IOAPIC_NUM_PINS);
 
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
-                                  &lpc->sci_gsi, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_DISABLE_CMD,
-                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint64_ptr(obj, ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP,
-                                   &lpc->smi_negotiated_features,
-                                   OBJ_PROP_FLAG_READ);
-
     ich9_pm_reset_properties(&lpc->pm);
     ich9_pm_add_properties(obj, &lpc->pm);
 }
@@ -888,6 +875,9 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
     AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(klass);
     AcpiDevAmlIfClass *amldevc = ACPI_DEV_AML_IF_CLASS(klass);
 
+    static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
+    static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
+
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     device_class_set_legacy_reset(dc, ich9_lpc_reset);
     k->realize = ich9_lpc_realize;
@@ -912,6 +902,23 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
     amldevc->build_dev_aml = build_ich9_isa_aml;
+
+    object_class_property_add_uint8_ptr(klass, ACPI_PM_PROP_SCI_INT,
+                                        offsetof(ICH9LPCState, sci_gsi),
+                                        OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint64_ptr(klass,
+                                         ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP,
+                                         offsetof(ICH9LPCState,
+                                                  smi_negotiated_features),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(klass,
+                                               ACPI_PM_PROP_ACPI_ENABLE_CMD,
+                                               &acpi_enable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(klass,
+                                               ACPI_PM_PROP_ACPI_DISABLE_CMD,
+                                               &acpi_disable_cmd,
+                                               OBJ_PROP_FLAG_READ);
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


