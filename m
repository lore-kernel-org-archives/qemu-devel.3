Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CF2C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 08:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbTb-0007E7-N8; Tue, 15 Jul 2025 04:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubbTC-00075I-S7
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:57:04 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubbT9-0000hR-AY
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 04:57:02 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F2P7Hc015164;
 Tue, 15 Jul 2025 01:56:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=3NIRgj2tl9f17Y55uEwLNd0xdtnfSMkFJoPP8k07C
 1g=; b=PQLu0vLoDGYoLpnt0Iz2Ow9LOvbBl/itvLiAjS+vwEY14MitG5ESQfOgs
 uAf2k0c+Ndzol3x8ZDVfzAJhgeFHbmCyJWR5cWNf0qoGvzD/xw3qKMSp5sJ9kk6c
 sjw8CcPqBOZkT2P590Znq4yBaZVIPE1s+Rc98G3X3NhqI0H5EjHQn9e5Z4SmLqHm
 U0jgfUQSOEH5RIcOLcNo83Sb9N9MQ1wIbL5CkUTlY2cIpPNt1Cviy+TR7xbcgIeA
 oEV/YmyTJZQEI6FgQBJa6fWsLYW2yFtFvbEQfoKhk3E7NB40ogJiCBxtQM54At+R
 WZWWoVfGkWpm2ur8OUzAz/T45ytzg==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2138.outbound.protection.outlook.com [40.107.220.138])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47uq81drk9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 01:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPV1AlmIHBcghbHElouGWLqtOvxWRdo/3ioozQLnrd8ZSl2sZmLvREg7OQNal/NFfd90OIDknTwUfWI1+fNjn+ROtFTX3ZMcR5d1Rn8G83LI1YvypvB9txq/mpas9IzPYxbeu3G8KpCMmojSUzE00yoO0C7y49DUyccOnA0bGvoGpSPBnAH5xIFS7tWcGTw+Mvv5J30qtOSO2SNU9nCBjIcOaSnGjtBvo1fp+cqtvzlGdtRdijOF+aLUfeKyULeVgXCo9wFmaG6pc2rDtIv2WEq2PgrR6pOp2gvmkEQPov+zCuzAjTYsa5l20kznKEm0TDXDs1NbG+S+r9H/tCVSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NIRgj2tl9f17Y55uEwLNd0xdtnfSMkFJoPP8k07C1g=;
 b=Be2xnlmpMFnceaAD4309rWIWI70THU5qc7BhWCS0luyd0l8WOx+VsqM6xWmSJvPs1jAEDCfRBg4bFfJSaMDz3wsBGtJvvhWDXl+kFAnVFgEmBGz63uGGo9+xJvoFaQlx0CL98qCn2R61wAx98CcSLROyg2xuopUalPZehhdzmWi2gqRjPftQdd8eKeye+Magq0SeM+6OmLwb+tC/O0dLtciRYjkFAfhizp/0S8FHhq8T0B/Sah3hpGB/qJPht4nnttM7OmzYZw1nLKj6o3CBecPWW6h4Q2+7o+PrOzeWxwOupWnWaYn0IpiMM81wJPbEvvmRPZz/TskBjc89Ep15vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NIRgj2tl9f17Y55uEwLNd0xdtnfSMkFJoPP8k07C1g=;
 b=qJXGCpj/Egvq2ZTyAxGQpUAx+jYQn45/W9Igl6dcC+0wEe6RbfCt1TySH1MkbS4JojxWT3CWNMSn+Mm4r35sf+yBMVMUbKt1V74AtM9S50gj2RrjnmLUtGYOa6zNIs+ZB6/bpgtPWIFcyUKRtSFVmUnlpKidn1dOumPy8V/ymKZPQ0ihKc4bggzzyvePg31DjyHItd08fG4G9VCjyXWgNl57Ux364LBPCjB4E+ykNUiWGMriji7p7Zdl4JjTO8eeWXqU6LVkf17WPh93o3cAxWzZwoRK8s0XqCw2PV9b/OBKQX6ZPjpxO/JJNwFvkhB2MjkfN2XaB5JKuR8CWV8T4w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB10246.namprd02.prod.outlook.com (2603:10b6:610:1c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.38; Tue, 15 Jul
 2025 08:56:49 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 08:56:49 +0000
Message-ID: <fcb72644-123f-4cd4-afb4-98ac2ad72d9b@nutanix.com>
Date: Tue, 15 Jul 2025 09:56:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio-user: wait for proxy close correctly
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>
References: <20250710154731.1266732-1-john.levon@nutanix.com>
 <cdf4931c-cf7b-4849-8aff-0f73fc3d1189@nutanix.com>
 <cc3be6c4-82c5-4152-8206-f475e8762616@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <cc3be6c4-82c5-4152-8206-f475e8762616@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0166.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::35) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB10246:EE_
X-MS-Office365-Filtering-Correlation-Id: 706c412c-522d-4195-6b69-08ddc37d88e9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d09LWUhHb2FJcjV6MWpCVVVlR0FNTlg4bzVCWU9DM0htd0x1YncxcEtaSjkz?=
 =?utf-8?B?R2gzbEI3WkFZVktIeWJWeTA4amxJOXV6UVIwaWtHalNOaG93U3hzdkM0TThF?=
 =?utf-8?B?eEltb3VtRWNJc0Iwb0xnanFPNjB5cE1jbWdDeTEyVjhJQ29wdWpBWDRPdVls?=
 =?utf-8?B?aGtIcFFPcjRpdUlDTk9DKzZUcFBIN3A4alRnMGNwamhNNnAzZ1cvWGdOWkND?=
 =?utf-8?B?bmJ0TFRRMTJoQ3laOUI3S1ZEeXJBdE8zcDYwMnpzZ1lJSWk3R280NnR2Y1Vn?=
 =?utf-8?B?SHJRVG1pQ0dBTWxvcXRLTEFnNDI2N0Z0T2Mya0o3NmUzR1UxZHRmUUh6bVBQ?=
 =?utf-8?B?ekM0ckNUWkM5bHZtQTB3N2lqbHZoeUhPOWFpbEEyMEhDbm1VNktaUFdxLzFy?=
 =?utf-8?B?cjBZZkJkZGhXU1IvUGt1WnhRL3ZzRmhSemM4eU1XOWFZRWRmcWwycWdiVlZJ?=
 =?utf-8?B?TVpKbmtwZEllRUt1cGhIRVpTeTJITFlnRnJJcUJ4TWJQMHlCMis4VWYwNlpl?=
 =?utf-8?B?aHlBdjRsUkl1czd5MXlqV24yWDEyYjl2TVd3cUhPTDJYU2VwMHNUVWFnT0hY?=
 =?utf-8?B?VUl3Mks5U3dicUVHR1JFalB4TnB1Nmc5Y1E3QjhFc3czT0poTXNOZEEvNFRY?=
 =?utf-8?B?RnhFRlVvNFdrdThlcHhlS3FZemdOb1BuVENIQXlHQXM2QW85MUNmRWpVRGJG?=
 =?utf-8?B?djlUaGIrUGJBcVljZVVPbVRIbE5GTmE4UXhaY3d0RG96Vm5LK1AvMmRmdThF?=
 =?utf-8?B?Q3RjQ3E1NTM3YzRQMWtkR1JNZ1NiY1VCdFVoaEc1Q2cybkR0OTVFU28zYjJL?=
 =?utf-8?B?azRFTnB6QXorZVltL2RyejJiWUl0bUZjZ0NKdEd0azhiOENydDREZUJ0QVZy?=
 =?utf-8?B?WVUvSUNUR0djZ2pveXRMUXIwak9pYnZyYVI3SXV4ZnU1dzB0aEJvL0NhTmM2?=
 =?utf-8?B?UG40T2QweHlxSzcyOFF5K0REY0lwNFRTRk5ubnZ0Zmo0V1pLcVp4aFpjdjVQ?=
 =?utf-8?B?Y2tNaFNkY2E3cTkydFgxS1JCbkEzV3FwN21JVWZOcU1iTHVPS2NNb0pDRHla?=
 =?utf-8?B?ODc2V1dBejlhWkYrZkFtcENWZGErd2MzcEdaMXR1NFcxRTFFU2FaaG1Gb2hz?=
 =?utf-8?B?YXZzNTF3S3VyNGlNUDhMMjVJZHMrSVhKZ3V6T2h5WEpEaFM0TjZkNUsrRjlo?=
 =?utf-8?B?M0YwNFV2Y1dZczgrMTVGWmozTnduUmZaVUZkVUplZlpQbXgwVUpXM0t1cCtZ?=
 =?utf-8?B?SWI4dGNWUEdZSmxtRUdURHVZWWZ4YUsyRjU3YzJnakNBNWtMWWJsTTFXKzRN?=
 =?utf-8?B?eXExL2tTRWMvejZOOGVTc21WL29SdkFVSFR5bGFSb2I2bmU3bVVlQlRtOGJs?=
 =?utf-8?B?QmJ6OUE0NVRsSXV4NUsrb21PK0VUQ01uNUlVR0dDVDBoSU1EaDd1d09wUGhE?=
 =?utf-8?B?bHRySVM1V0FaaFBpVFNWMkxxaUNBN3Ryb2J4U1crRGtkNFk2NGJ3RWRnUTJy?=
 =?utf-8?B?b2xlT2xRaHJyUTY5UVdQb2hJTW9NT1pOSXpjMlNYMGFnc0NxVk9IZWpha0dO?=
 =?utf-8?B?UXRVQzhlUnREWnVzc0hLRjNROE9FZUZheFlkTG14VDhmUjFuVWhyTDNJR29N?=
 =?utf-8?B?TWlpZlFDUXlRRnlIZFVBcXhqNEVxUW9XV3AwNEV5dzRIR1hXaGtTNFdYZTVP?=
 =?utf-8?B?K2NNM3pLZ2pjaXhiY3JtSWkveHpjZXUvMGN6RmYybmhlLzh6czJtZE5zcmVJ?=
 =?utf-8?B?SWEwK2hDK2ZyQURmWWcvbkhEaUt2dHVxbWxmN2ZtNEpEYy9hNWdaVWxja3JK?=
 =?utf-8?B?QithZGlRQmRrK05MMlhkSFpQUnVoeHR0cDR6THNOQXhyNjc1b3huZFEzNWFF?=
 =?utf-8?B?NUFka3dBUVlIUGNxeW5HbXZxaW5TU0pYNmtHcHk4MndjOGgwNE5BeHN3N29O?=
 =?utf-8?Q?pXKjxFlsRGw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVplTGFwTGVLWWVEdXFHcVVpYWFHRmhnOUdkc1lBUkU3THNuRHNOdTlheDlS?=
 =?utf-8?B?ckI2NHpvRDk5WGZPZW12cjUyUzA4UExqcFNQdHZLK1VmdFIxOWp4OWU1a0t5?=
 =?utf-8?B?SnJ1RWZ0U2IyL2ZERTBhejdWbUtKVE1YRm1aQzVJYnRGV3RDYWhsTUFDQnY4?=
 =?utf-8?B?aGhYaVoyZjhma2x1NGZ4MGMzQnNxb1FjQXRQL0FhRmhsZHpWdmFqWXY0akEz?=
 =?utf-8?B?M0xUNVh6WkJhN01wU3N4dTRqVS9TWW94RzJlYStkTWNIR3AvSG84RXFZeVVw?=
 =?utf-8?B?blRyUlM5Szk4VGJBb1N1ekh0MnZKdmpidTVOcHNJV2pKL3FKeXhERTA5R1h0?=
 =?utf-8?B?bUJ3ODFqM2RKYnZvZlJhUGtMVUtIS0h6R1V0QlVVQWplUGMwUnZ1amRyQzBN?=
 =?utf-8?B?WXhSMEJrMHJEbUxMN3BUVjNzT3d1aFFEL2tXUUNjQVpQdEVJMXNycjVqVXFL?=
 =?utf-8?B?SFVTN2F6QklNMVNJT3hJVlZ2emovVjJScksvc2RqWDRMdWlqb1dDbXkycnpD?=
 =?utf-8?B?WHo1YSthN1J3SmlNbUE0YTlZaUxIeHdnZHZKV2dHdURoOXFLRnd6U05ucHVY?=
 =?utf-8?B?Yk96cW1tUTBnL0x3bmVEU0RKYjI1aVB5Sm42bTFubTBveCsyUzkxdDJVRkRy?=
 =?utf-8?B?dTJmTisrRGFJc3pXTkVaeUUvbEhLNHAxcnJraEo0Q3JKY0lQSldkNU1icUM4?=
 =?utf-8?B?YXMwSHNWSENnMVdjRmNsVTA5VVlIbXQ5eHloR0ozMm1iN2JydVdpb1JON3N3?=
 =?utf-8?B?VXFJeDRLNG5oWFhXR1A4bTE0WGNzYVN0aWQyVm9HZDFpdWUzWEU3TVFKdTRn?=
 =?utf-8?B?aWFUak0xSUdJWkp0dUF2Kzlxa2ZoazIxQU5ReS9udmx5K0NoMUtIcVZyaU5X?=
 =?utf-8?B?c05UV0lsWThSdlFaVjl6ZEgxczcydy96bUtlTWFLNTR0dTdUTDY1NkNwVEJV?=
 =?utf-8?B?STVzQVBrQzJpZmRRbXJZcktuRERsRTZPd21NL3hOMk1MbG41ZitJMFJqdlk2?=
 =?utf-8?B?akZydUVQR1RDb0NBZmRVcEMzWGhIcHhqSmVhUHhpVDZPNTIxWENhSEp1OGxa?=
 =?utf-8?B?OEc2SjNnTTFpdEhjbkg0Yi9DT0J5SWd6S2pkeTVWQkNtQzVGQU9kWTlnU0Ur?=
 =?utf-8?B?emlTY2F5NnJQUFlvNXJ3TG9mUU5lTXdaM09DaFcza3JqNzB6V2RWemdVdGtU?=
 =?utf-8?B?UFdJaFp2dllJRmgvSzMxbUFtejMxSVpSS01WcjFSdzdaYW40b0tBRzlycjNq?=
 =?utf-8?B?MEFQRXAzZU9pWFJ1OTJueEF2YWFkVE51eHlIWVdac3Vya0djR2ZQYXk2OFlT?=
 =?utf-8?B?MW1Jb3Q5L2xGRFdjTU9hT2gyTXA5b1BkR0hYeG9udXZjMC9DRkRZUEVaZGl3?=
 =?utf-8?B?Rmc4dVhxZDltb0J3RGlTQ3M5eWVaMEhCTWoyd29qVUhZbEc5RC9vSVV3QkVE?=
 =?utf-8?B?UCtvWUlnTU12ZE15VmluWHlkRGpLbkErdTJmS054akowSkpKcm1oUGpyRkNr?=
 =?utf-8?B?aHU5OFZ1TFI3M2g3bit2TlBreTlYVWJWS3dPYVF5b0c3Q1M0RzViRHVmYUti?=
 =?utf-8?B?ZjFUZS8zWTFjVXBZQnB3WXJPVUlkYzVSZzI5cGdNbFFZUU1STm1hZ1NveFV6?=
 =?utf-8?B?RFRyLzlNRTAyNDQ5K3NOT3JrdXhUc1NPOWtvUGY3elFXaWJxN2RkVnhWU3Jl?=
 =?utf-8?B?bS9HT2hYK2lhUi9KZ3pXY01xSzYzMTFhSHFXWStURWtuMlB3bk5KWHNVVDN3?=
 =?utf-8?B?Tk5vRGljK0RPSzdqbVNOSk9GNTlRNWRJT1NrajNNOEZlQVlheTJ3SkFtNHRl?=
 =?utf-8?B?RlR4UnlzaTAwRDFGeXB2TVgyNTFNelRvT0ZKWTJ1RWFCMG9tSk9RM1dCUG9n?=
 =?utf-8?B?RG1KR2RYbEVHVVdMckUxZzFlMkFmSDliRDJsRXBzWjYrS2svdHVmTGNseGNX?=
 =?utf-8?B?dnQ2TXRibUFWZ051YnFTL2ZNcWZuQzY4KytDZmxwKzduUk80Mkx6aDlhK0t5?=
 =?utf-8?B?U2dsUDZobWMxWTZ4cHliYXI0N21QZWRJOGxJT085aGp3Z0RydVFZbFhyRWlw?=
 =?utf-8?B?OExlQVZXWkEyYnN0c01LYVg3eEVJdTVscjlob28zWFJKSUZsSVVrR3FnUFZN?=
 =?utf-8?B?TWVvazZKNkZlU1BEM2p4VFRESFVJTXRPL2lweWNKUDVjb2luOWVia3hBK3dM?=
 =?utf-8?B?VmowejRZTDJYWjhvLysvSFNjMks3a0d0NENVNjYzd3lWN2M3SEs0SE5teGt2?=
 =?utf-8?B?dWMzdnZoVm5iTWIwc1pZS3owblJ3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706c412c-522d-4195-6b69-08ddc37d88e9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 08:56:49.7565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxCH+TchZWAQ4rV6ryltuWRPjPyoxmlKxa0QbOPA9K5lxGsQeQKXjtQWQF5jSebTkRR1SKoF3E0ATIobnVthj2BJFOfeYnNg1fClqOHSLW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10246
X-Authority-Analysis: v=2.4 cv=bL0WIO+Z c=1 sm=1 tr=0 ts=687617d6 cx=c_pps
 a=5HixKquiyx8Pok2ot0WeLw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=eQq05ejwIfUwXWYaWyYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hMLR4J4NfomowaKAnJdSs2qqARx4SOct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4MCBTYWx0ZWRfX3xtzKaAR9pvk
 QVQEQdu6iwTHyaCcQGUGBHpVdy8rY6FICW2DuRoQMyS7RWKxkKvWDDHjIp7Ke5cgxCZtEpl5kzO
 9QAfimfp3tB1AS4ecrwqBhgN6vbCgS4de+AX+su4r9ARuBQRna29YonRulDRtL+F23ZtcrCe9Z6
 7hHmP0rW1h6dDp5fbC9zS7/odjqyqGUANiDUAWzaH6rYjjoqH4fS4PfQiRomWApeN/sL/h4LTNy
 ZgNMNfh9w4lrWiVLDlfMjuMRX6s7+zvytJVEeBx2hviCknzZfeCzZqYRjCt05CvFdGYv6EsenSS
 GFA0NQqKOIoRYLEWrVdTIKfSLPM7vIAloPtNNOXl8Jjk98R6Wk3wgVmTiALGwW4JYC9zAy5N4dP
 nAKurdTJN/d7fSR397GBSeU9NB+YCRCO9frVaPCTMEN/pgz95Eib+ZvNuurBrh4NesntiHYW
X-Proofpoint-GUID: hMLR4J4NfomowaKAnJdSs2qqARx4SOct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 15/07/2025 06:49, Cédric Le Goater wrote:

> On 7/11/25 13:38, Mark Cave-Ayland wrote:
>> On 10/07/2025 16:47, John Levon wrote:
>>
>> (added Cedric)
> 
> ah. Thanks Mark.
> 
> This reminds me that we should have maintainers/reviewers
> that can send PRs for the vfio-user component.
> 
> John,
> 
> Could you please send a patch adding me and Mark may be ?

I'm still coming up to speed with the internals of QEMU's vfio 
implementation, so this might be a bit premature. But I'd like to think 
I will get there soon :)

BTW I have a series here that fixes up some of the QOM issues with vfio, 
but I'm guessing it's a little too close to freeze for this?


ATB,

Mark.


