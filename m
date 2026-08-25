Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680C9C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrRe-0003jQ-Ca; Tue, 25 Aug 2026 09:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRN-0003eb-Vf; Tue, 25 Aug 2026 09:43:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRL-0002SD-Nd; Tue, 25 Aug 2026 09:43:49 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PB1B6G1846124; Tue, 25 Aug 2026 06:43:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qBt1kZeE/sozUzTiS3kDvRtzjt5WMT1Zb4QOAMMI5
 Po=; b=f09CtgK+SjxoI8Io3vjgDcDZyuLInWWSvBBT2IlxqvYRoRVvOn/oTbX7U
 pOLxzcnUjOxg73DJG3H9rupaHkjicINNmrbEDd6awkzTOe/URkaCI+W8xuQMP3k8
 6q4lSEWialZjfvEpTlzZgCaFMF6hxsKonAw4SzQNgXOgvuANtnWsqOm5PSRJqB8U
 jqSBSCW7kH/kZYgCHKo1T89BqhJ4V+7Jazp2OScdcjSfA/XDZH5HPIenWJ7FoBa6
 9qVfYseB2MI0HV7DmOW/3JCNoM6vU4EMqc3PwRzT+FPl2/vDRrTyheuuno8aZoRh
 gly8cYkDR9TTmuC08vnHlUE37SyMA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020093.outbound.protection.outlook.com
 [40.93.198.93])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g7baved7j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkuSsi2v/3YE/sd0shFuz6lIl4QJVlDMVzNNkelPnDI2j4hyiq4PsUB9M2ph9/SYO7mQBx3nGjRfJSb4mB/fCdhIn1X4CnYN+IJK3Ap10/Gt0NBwEffyYLDMp8hUmKGvb3TgqOwmdOnBQiStHX+0rDk8h0c3Q3Y5o1blwi9VTW/cicalEwNPZMct7+U3g7xYZssV/NNf5EmSP467POQfygG6BfvZxEvbiHmSZT8V1z6AT9vTdJ2EfHxmiqqDROpN21M2V9e1gzvRQtQe3AImkkW3lsnfi4KhTbYo2lZfRqcdIR4kwul8DUUAcUVN7CW1sUUxgbRhElEy/b5CIPoE0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBt1kZeE/sozUzTiS3kDvRtzjt5WMT1Zb4QOAMMI5Po=;
 b=bQUUBFTCnK93y+3INatjPiw8lzmfIK6rMAhGv45YzVU4v9aAI2UNuBLDgPbl7bCzrzfaTOFeUvspKbqHDvAW8WjXpLCAHedwRcl0XWVUwOgR9HWt0/r4ZyPVFCeT3lciRSc5nwpr6xu/qcMtMeMO5ro6sIi61bfJEbD/q4aZG4JXFHUB2zLZX3xsj9AZEfQlzu0jNteVaPHd8D1VB6Sdl/D12C3osqYFZgzuWnE1JaqB0lq1tCgLzlTwCGfvfbi9P0zpRZlEjom+1gzDWduULkMdCc/2v1G8Yd5Jz6+JujhOVe2O/IVpbMfyGtTujE7ruJjc4fZByC9zP2bvj5eSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBt1kZeE/sozUzTiS3kDvRtzjt5WMT1Zb4QOAMMI5Po=;
 b=wTBOb271+2LW5+16lHVb2Mivh47Yj5KONp6EtFPZcAIaIu2ZDm6mITEdrpi8xZutLCRi0FrdkzlUp1ghLIn1E90LEnw06axDz8+dhTnJLBYk/fito6KeBHwKOwTWY50q0aEsyr7gi7MsuJ89ISjF6nb+q2Ei3MsxV7utz7nQSZYcbVm95Jzvu939bRWYuPiDqRoIbCLfxIB1sGQqGBAlOtZEE7kwRqcZzO5Q4msJRXcFGuEN2gEHnMrr5aRz64JysyaZutMDTWav2YiG6mSS82zkzZFZY0PdBDK+vkm1Je47Ixh3JXoJDnh9lAJI12dbfDEPjwRwOeepsCf/BbV6YQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7557.namprd02.prod.outlook.com (2603:10b6:510:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 13:43:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:43:29 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 02/16] qom/object.c: introduce
 OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type) macro
Date: Tue, 25 Aug 2026 14:41:23 +0100
Message-ID: <20260825134320.1039012-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0118.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e5d52b-9a49-4459-6399-08df02aed881
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: asnHwCxFp652GAuyZsUoaNoGku1uCfBhxiCMpOKu/0jdjlLb1cRIOm987ITjaXzqxLywAgOxgnFGinmGOhF+1gE7UMwPcUsMqhrznO6ClzAmRpL1aevkgZZUz3Kvrgim3ssCNB6w5w1fRxgWtcrU8OWc9toSv1HUnmcWXLNYL0aJlQEP3hJQRkviqIvooF2kPhspwhIlI4zNAriKVOc52MvHAPoajlSGWhSyLoRskMmwFtv89hiObRkXRs4WjCf4JRwTpjdKfO6VtZQkk4ABRxDVye5oLQqjCF+8Sz5zLvX2PLick+XAB4IxYpdkCgbwaXSi0sbfZdMvgIyiwfybLQjUaQ3/qkwbvSLDtMhHhSLfnQOBSp0KnwV9YhawYsChy6OAbU36zB1Z1y+gpWXqRkbU08pBcOldiwtOHA3V8+wzg014wZkb9/pgtLz+ZdrqdRNp3FX/9XGVrBACOgakjwe3HfTNBDNLBF9+0xtPx61qdyer4HiYH2aXzTUr9ahA4pFsjaDU6XONU7HyzihmYJCDEQgvgVOygj+yIUSSgvXHrHSPdYekU/qHvLhuhzEK/trTBtI1uCY6IGUD7U2XT6myqot03im2IKNn1NhpVtSHcNFQgxHLj7atxaTdhPdhBI7JoQJsdvLBCnFSEv/WAvZnpvqImnsGEnHBnoixx1V5W8PhxeZFtiLT92DMX/EYTet3umJhQVBPiDmL8rqzFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDlIMTdNRkd4OHpmNUdpZVRndG5nVDV0QmEyRjhYcDRuZzNYZVNRRGVha2hG?=
 =?utf-8?B?MWgzblRBVVFOR0dPQS9wUGk5OHBSenR3UEZCVzBlb2NPdjYrNEFjNEN5YUZW?=
 =?utf-8?B?VEhUdVpIajJ1dGR0bks4d0dpckQzVndieUEvd3FJV2R6SjFNNFM0MWVHNUdY?=
 =?utf-8?B?MjFTdzNScVYyeUNwUzdVUlArczBhcS9Pbmt6eHRrWnhoeDArYUlRanJMVUtC?=
 =?utf-8?B?ek5obUk5OHhWQ2h3Skc5QzZrdkZ5MTZob3dFdHF1TFU5NTJyeU1JOWxUMHhj?=
 =?utf-8?B?UGlRK0l1Yk5DUHgrU2VEVS9HcGVXV2ZJNUVLcEdRN2hOL2JEMjJuUVhPbUQz?=
 =?utf-8?B?TFVJOWxBQ1ZKMm1naTF0Qm52Z09FazRXcnV2bTg4b2xURXpQL2JiRXZVem1R?=
 =?utf-8?B?ak5PL0Y0OW1ZTzBLSUo0QjdPYlJPWkMvN014ZTFqTEZTQ3IxWWhsNnE3c1lL?=
 =?utf-8?B?L3BpcENRMzY5RnlqKzRtZGNYMWlLcVJLYkx3ejZqOEJOTFFQRkhiZllpTlhT?=
 =?utf-8?B?VkxNa0lScis3V0xOMjE5WCt2NUhJQ0tuTml1Q1ZoUHhHTFVNWXk5REh1ZDBH?=
 =?utf-8?B?ZDFoZzRFTEdPWm5sQUp1dWhSazRudDBPK1FwSnpwNUJOUXlmRUxBZmNEM2Rt?=
 =?utf-8?B?QkgyN0k3aWhNNWx2b00xTnZiSDlGQzdMN25BcFNzVnRxd25GTEtZMDR6SDBH?=
 =?utf-8?B?M044aFI3TmZCQkJlUDhlcC9mbnVGU3BRd0JpeE83Qkl4VXpYN1AraTFFS3h1?=
 =?utf-8?B?R0t4SXRGYndHTUVDbHZ2eTVoVjBXeGdvVm9PU1l5NUhkc1Q0dHorV3BjQ1Na?=
 =?utf-8?B?YlQ2NTB3YU11WFFNQkZiNVFLcHBlUzdib0dEalNFc2VpT0JPcWNsaS80ZkZm?=
 =?utf-8?B?KzVxMkRJNnlKejJEQjAzQXVzc3JYMVVQcys2bDA2RzU3NFZRbHJiMG5qNkNG?=
 =?utf-8?B?c3lTN2FsUlpLcWxSZzVZcXU5RlZUNUdlM1RLUG9TS2Z2L2hoMlVnYXlHRnh5?=
 =?utf-8?B?SHg1Ukw2d0lsaGZhTlNMbXpQTHBpUnF6a2FKQ0RqdWRYa09tcEo2cVg5YldE?=
 =?utf-8?B?LzB3WnR4UmRta21xYmF3UzNwVW02SkE3ZXdIUkIxd0x1Y1BMZnlTZ0FYTTZE?=
 =?utf-8?B?UURnQklsNkJJYzJUaWdGd3I4bzVmc3UveXRQUzVzTVJ0aVJudEhxbnRhQkVP?=
 =?utf-8?B?a1hVbWF6aVNDeUtHVUJJQ0VVV2g4K2xVK1hwaGsrTDYwSmlQOWRlbWhSZU9u?=
 =?utf-8?B?eW93OGRGbXRDSmdZdWJJWlNCSVRNM2J2SFNTR3pJZThCZnRKTFBRVnplSjYr?=
 =?utf-8?B?cVJKMXpQR2s3SXJodm1KRldBOVN5d1lpZVd6UzVGOG81YjFqRmRNOStjMTJq?=
 =?utf-8?B?VkV6MlRHRmxzb05ndkJMcThxSDlXSEd2VlNWc21uY2F6dHVjRXF4YlpZNHFO?=
 =?utf-8?B?T2pKb1hEYWJxUWkrM1IyT0hIQWxoKzZ0MnU4ckxhdnRkdlBDQzErSTR6QlZK?=
 =?utf-8?B?SlB1YjNET0dDdnRQSkx3eE5EcnhTZW51R2xsblJ3ZFgycVZuL3hXY0xBcmIr?=
 =?utf-8?B?MndaRFl6ekdVOXhScmNqUkZmTUZyZ2lNMnk3ZkRTNXdPckV3WnRYMDh3ZU9B?=
 =?utf-8?B?TGFUSFNaaFU4cVRNV3JzaEtKQjZRWVR6Uzh6czhmcENibk9VbURoMzhZZmZQ?=
 =?utf-8?B?STJlQWJsZkdUck5jOHhBMjkraFh4SzRFVTRVYm9ybnJQSlFjSmhmYmVJZnAy?=
 =?utf-8?B?TFZPcytsUXE5TTdGWUdkeFhqMnZsNlM0S05jdTBrMWdsZlErdThWZXYxQTJw?=
 =?utf-8?B?TU13MkJYMHkxSjZ0Um9ISEhCODFhd2E5ZDVkWDZWNjhmVGFsT2tLUDJqOW5w?=
 =?utf-8?B?T29Gbk5TTjhyZ09uWVcxaTZBQkdjRjVrbWlweDJkbm12cUxUZm53d3Z4cFZK?=
 =?utf-8?B?NTA3dXFuRmNJMmxlb1huWlkrQm9ScnRtczFXaXVSejhqc2tLVDdyVVZTZHho?=
 =?utf-8?B?d0xndC9wdDd1WHkrM3puN2h2anhpdTBsVVp5Qk5VK1RYSHh6MVIxOEM2Tk1y?=
 =?utf-8?B?K3hWVUpPS1UrN3JSUVh1cExoUXJVcDZwRzM2VHNBbG9SSUZZRzJDNUczdEUy?=
 =?utf-8?B?cnpZRTc5UC95MzNxd0Vpdm5ndkxuNW1SWGlZRVFQc1FPREowQlEvd0x4RGdW?=
 =?utf-8?B?VXV0K0R5TVNHTFVudTV5N3hxakl2TlZoZ2RlSnJJTHc4cTlhbzhlWUhUeC9h?=
 =?utf-8?B?NFlBeHZxalZzMDI1c3BGU0MvcjBlUzJ3aDRsNHBkYWRNK1I2ekdBTUFGdk5i?=
 =?utf-8?B?UXAvQVdua0RXMmRmV3VlSVRwaGhSci9ZMFpVOVFWQXBqbTdiS1VXZGdjRGcw?=
 =?utf-8?Q?HCot85HjlsXO1UC4=3D?=
X-Exchange-RoutingPolicyChecked: zqy8fG/+XpxLTQELgyD+AzQ16+zsVl6ljL/QXfzPF+avNqBX6V9Lhf7QNxzKtGRvTsgkRboIbFybfHm3a0SxLvCrSuVSNLY7AhdSrVUdfXi1himYT1Wa3l5OmleLj+ccYifpwN7Fo9MhanUQUj8yE7w4yu2qn/eqNy0bPRWyAiptoA3mWL5X+HaUJ+CraaEE+3CHukX9LjBb5U3KZN1VvqyQFkJhKVGsdF3gh6GhRCdWStFF1KNa0W5zDaxwJ95JBq9HVvH6Ogz45v0dAeTMzvctwicZt3/TY5Ql2NKD9MJDxdoPDCPfChZEFSVkKo49yR4zSm0GUq110HIyV/R4UQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e5d52b-9a49-4459-6399-08df02aed881
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:43:29.1080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gm8YQ0O+PGSkahjXNzdka1szcARU9s16uzaiOqhxd8P7BP0qvQd7osafzXKj+umjT6saJ4K8ceXfhakQ3+8IAjdp3FIQd4k1/QJ8i2V3sBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX2lWPcRBKgBmc
 JeRW6eI580rwgqvPuB1ANYQyUVzz1viDJpP+ACWJhwH/fb2crFhHssDAbFccIxYoTZ5nyW8DH5A
 sPThLJhhHDY4ZtUHObRuvEE6sFeMn+U=
X-Authority-Analysis: v=2.4 cv=aJvAb79m c=1 sm=1 tr=0 ts=6a8d9c03 cx=c_pps
 a=bGwgGCu/CPolCU/HHR4Rmg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=R2kG3xqjge_4VQhtPmQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hJdLzcirm5VSreLXsgq0blAWA316TDqy
X-Proofpoint-ORIG-GUID: hJdLzcirm5VSreLXsgq0blAWA316TDqy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX5koVoJdGeL++
 FX/xd8tCghVQ4K7f56eGJtOn1OmDCxfSNozNeKUdWzhInK/ueVJeLXtuufCL8lqk+p/QMFcC8W/
 86ZMk19619qKkJ1UB3ZatxAgjvk3Oh3603MBRMRxAfQ6AXqLm2SwSFNwSzYuJiSgjM8gtCTIL+5
 qJrf+b0nB/9uwreb+qc5zO4yUcU/hLzRNW4DdyBkuGsSKGIZMVMsqaKp3j0KJINwLxQRpU1rAsN
 tZTS1Y3rndcAK9q22xWpVFNHr/0L8AD71c0C9t6PR4gcDwNXMEmlCUQ6ee1YIXRehsKSUtb6nyT
 odtkxmamyT/YfPqvhj5g9d2xbWclUNsa8CnLTuXe6ZbdLlu00qVRlYA+6IQF70NaZqIr4kU8fu1
 j41fRUWmEqfYONtH2FBz7Vu5yOJ9n4P7lio3jVv7DayPEjPn0SJYZx39ti5ul8NyJTjiiCxsGjG
 eV7O7qePLFSQI90oIBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
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

This macro will be used to generate the boilerplate property_class_set_type_ptr()
QOM set function for the specified scalar type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index e32ae30bd5..fe4e552928 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2722,7 +2722,24 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
         visit_type_##type(v, name, &value, errp); \
     }
 
+#define OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type) \
+    static void property_class_set_##type##_ptr(Object *obj, Visitor *v, \
+                                                const char *name, \
+                                                void *opaque, Error **errp) \
+    { \
+        type##_t *field = (type##_t *)object_class_prop_ptr(obj, \
+                                                        (ptrdiff_t)opaque); \
+        type##_t value; \
+        \
+        if (!visit_type_##type(v, name, &value, errp)) { \
+            return; \
+        } \
+        \
+        *field = value; \
+    }
+
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
+#undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
 
 
 ObjectProperty *
-- 
2.43.0


