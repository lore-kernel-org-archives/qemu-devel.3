Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB7BC79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Y8F-0002Yw-Sc; Mon, 07 Sep 2026 08:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x3Y89-0002YU-Qq
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:07:22 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x3Y86-0006NA-O8
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 08:07:21 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AmdND2351157; Mon, 7 Sep 2026 05:07:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CpHp+fmR7fdAR2gXafaamKm9mmO8/T0KeoesqD+yb
 Qw=; b=AMd/kwsqKPBrDNcsTc/CNSd5BSKzZG0G+0nZB9DSJ70JRD5H8vWQAD9vY
 jpYQLBh3V7zxoEBcRt5jHFFmAafn8YaMF1kKfcHLyvKzWTuaF2/KKGRaSzLAn2E/
 +TPxtlfOgkhqGIHsaRF6xXaxyzJw8SB7uxiPNu0UX2BQHQ4mTiFs1gCwCcdv989p
 E6B9yIUKWHf850Tmw2sg9xwirA5/FA1wAzr6Hnb+lffWwYH1Tz/1fedK7aN74MHs
 gXd2+eQqQFaQvbutXyZqOQwAaiZvhWq8L2n2114dvoGjLtxfJnJ9BHQAF7d+zOdN
 QnmDKaQj49rKNVi4fvdsQOT+Jla8g==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021114.outbound.protection.outlook.com [52.101.62.114])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ggjddb2uu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 05:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzhlH+BSmkWFVG5kwWD2icQjZkLMkdb+5ertHdbmDYumM75tZOZdcHFZkIU5F5L94pY1UNZf+TQMq2wL/4di+ZpEIQiXlCe3EbEHYXa2ZuYFSdWn2NMmZR9f1/UsHcIVVL9bGzAzC2Y4q7uNXuwhPip2Y3Te74/BhDK9Iuc/EfezHsjllsS0kesEHxx8T/7PA/jj2KfZhk3Jx5nc6ODDF71hs3EznT3TTtorh7Ol1BQ/PQMd1noBGnBAO6HSYnpSHVav0UbqifxLF07vbihAFo8wzNL9N8vaiGCRgSgCxytvyDFtD+oOQvY+D180vPLhH0zCFekUQAAIAKbsgyecKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpHp+fmR7fdAR2gXafaamKm9mmO8/T0KeoesqD+ybQw=;
 b=wDSxH96G022R0me3dcdotIipA6YkYlVM8ImBGAXIq9bfPF0c58C7TIMUpCDoAzcnJDcy5nd8Xwo2mU0AnF4+qesdSF0zJye45bLiYeHxbe8q3pMVmDUdn8xc4Bw9/xR07modFUhRmSZfeQ8/Wh+OxNCjt++z6L6r8Pp4somBWFdEjYwCTox37/3NyZBWYRJzM/BMCtl06mPOGPzT/CKvigNfKTIALA8CAcrba7dJYxu6nYfCRvSxdZjSBQ2rGPL7Z/evefxVechjnNsm6xXyb0midhGW83M0koUIB2iOdHgE4NA/eaP+3c1QwXxV7GLeSTOv/RhjvdpIAwh1ahXgNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpHp+fmR7fdAR2gXafaamKm9mmO8/T0KeoesqD+ybQw=;
 b=CYqpiFBG0C8APOGt4ts/ZtqcFpO1O2/3pe3B7/wIVGWkEbgpPtQUfDY7jxd1RK9dy1ZI9EwAai6YgG+5vh4LZGbsQmuqoW864CLA8nA+shXnOxMsha5+FwFtpupvcBydaB8CQzr+Go3vQznt1YKHh7TlG8x6xqnXX2ShqoAeIghswSQuakVc4VYM3gMbmprXg0cwVu/OUPSJ+gpL/E15UmrWS2wvTdkC12pR4GZvms6Bj8eaNCXak6iGPv0BG/QkryNW+rHEyP9Fa6Shs+siRAL83GdNbvRPOAanLULdW7llatKy3eymySAeb1bxp1aRP0L0SIW2V7d90WPBlTDJuA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BY5PR02MB6963.namprd02.prod.outlook.com (2603:10b6:a03:236::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 12:07:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 12:07:10 +0000
Message-ID: <4d2d0c34-121f-4439-abf4-4b2da3fbf6f3@nutanix.com>
Date: Mon, 7 Sep 2026 13:07:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 14/16] sphinx: require sphinx 7.2.6
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20260902193551.582660-1-jsnow@redhat.com>
 <20260902193551.582660-15-jsnow@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
In-Reply-To: <20260902193551.582660-15-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0049.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BY5PR02MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 25fa8104-61cc-4be1-9bd8-08df0cd88b95
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|3023799007|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IvMwI7NIRqJwiwARhwQlQUVI/iY73WlQwLaGjbLf8Y6PcLEAqShTk9vRyLriu4/ONvGnKxddZn2egPIDDTQTY+69tZ2EwQGGqokzE7QUojkBQbQ4yEsUtZp1ZLiIda3CqqAugBHsOrcbnWbpDN/iQImWpccQg9aNxdLZrULMADIDOMBSxMLNOmc4lLFwBSd5yqiP7E6jpnpqyvbLJ+fnIZUdejtmUavF7nFXU5Im2jOYG/WfBxRlQSdRNQtVeR0PBqBGxRc6R3TqL0nnLq5kYuDZf/59pMl34zxMqMICieAqDlS0EeaOYpyilTtt7iRDFZL8RD3fS6MAJ9A2IUujB4V3sa6rYDwb2gD2XfkhLzct8XE0bRmLbM8amoFKK1F4Fy0Pz3PJHgUntGYgVHtiQc3TGUpr51MHgpE6Ij4a2IBXLPMnX9MrEW9wQ2jRJWxA2Sh2ijtHNUHd0A0h1miHe6b7rUXvywAyGgxnwyaHIWDbE2VWvl8rCZkCWjGLj0MHfj/6i2AfJkMpXWhFMkWv1tqTJz0nt1tiDMGCVGEKV4iBs0W2EZnPXGXMKIjiQAZpl1YV0pg78Kb755TuffAi/n/Uu3tGmplcuylvz7b4dm4NhEQEj+EA6W8eVvMrofFJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(3023799007)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RllGYitFbVJvRlIxZytvVjR1OE5qYWFkTEk1NjZyZEpIY1FRd1NzSThZOFhQ?=
 =?utf-8?B?VVpuNHEzRWVXY2c1L3htdnZtL01KMDQwaElpZE10WDVwZEgrVVhxWjJaVSs1?=
 =?utf-8?B?NmEzeWs0WDc0RXFJbnErYUtjSlZXS1I4ck55VW5zL0hwVG5LSVpGRVVzeGt1?=
 =?utf-8?B?cEN0YzhaNVlWTTZlR1FSWjk4SFo5MWZ6NElyckN3cThtUUJIelRxaXo1TytN?=
 =?utf-8?B?eWRXTTlTV0dlQlh5MWdjYmgvcXMySk8rUkx6RTV6c3lIWUEvMHRNWlRzKy95?=
 =?utf-8?B?NnNJelIvV0ZiVWNEK05kdWtzd2cyQzU5aktUNjRzTExQMHVJL1BvVCs0M0pp?=
 =?utf-8?B?N0l0dGpxMFFnbk96dmpyaXRNZVZHS1FiM1V3b1p0TEZTWnA0eXN5ajJoNUw3?=
 =?utf-8?B?MHFidlN2cXpQbG0ydVYyYlZ3bFB3RUg5NnJ3KzBQQXl5MGM4QkZkMGhZME1w?=
 =?utf-8?B?NVBxSnNuYW1JdmY1ZGFIVHRvT3VFaTFyMU5FYlBsanp0OGpjWTIxWnd3UVEx?=
 =?utf-8?B?NEVVeWh4cjF4blZ1N3pRQmNEZVVvSGE4d2JvaGdna1IzWGc2TThHZ2dkSFRY?=
 =?utf-8?B?SVJ1VDFzMHNvajFVQm5DWGxZSllKTjBNeWhWTjYyNmw2SWVGS0xsQ21qL2Jy?=
 =?utf-8?B?bERXTmJxWjBqVzBPSnBWdEhJR1lsYWl4REFNY1ZSaEVaUE5VR0Q5Slh2N1cy?=
 =?utf-8?B?bG5KL09WUzdIbkt5dmNoUUtUY1pIZjRaczlod0h2UVp6UXdRMGZxOGlxTzB3?=
 =?utf-8?B?VnFwUkZ3TUFHN2xoVVJ5Q2FlZ1c4dXFLQUZoSXlFY2hUOTl3ZjRLTC9FSGFm?=
 =?utf-8?B?M0RUb0V5a3pFcVozSEJPa0V2VHhlakNTbmVxWXlXVjZ5ZkErY0dURVA1OGFL?=
 =?utf-8?B?Y29lOUhvMGNsaWdqcDhLZk13dUNHYmY1WHYxdVh6Um5Wd2tzK2JMTml6Z1dQ?=
 =?utf-8?B?U0k4WDRMdU5UT1ZxOUpxSThITTJRMnRNeDVYanZmVzYzZW0zbTVnM3FUOFZS?=
 =?utf-8?B?OUZPKzB1cVkweU1sWlRudW5VUkhvZVdRL1hCLzlDclZKUzllSjVDYjJqbExZ?=
 =?utf-8?B?R09XNUhwNVVzUjRTbWpjVkRYYzNLVlo1aDVScUxCbC9vM2RxMElHRWEvYlNh?=
 =?utf-8?B?Ty9Mc1ptenJPNVdZRDhra3NXNEd3cnI2RkZkdmh5VCs0bDU4N0hHRDJFdi94?=
 =?utf-8?B?R2ZCaENqYWRyYk1YV2ZnSDFuckZ0T1dlOFMvYzlRbE1ZbzcxV3lWVTd2NFNH?=
 =?utf-8?B?ZjREeVZwb29URGtvYzloRmZ4RElGVUt6OEtWQ0NIN2VWa1NmaW14OUtTVkZR?=
 =?utf-8?B?OFc1ckJ5bU9qYlAxNThiUER3L0lxOGdrc1VjTzJvRGxCbzR3L28wVDVPaFBi?=
 =?utf-8?B?YzRPa2thN3VDV2ZyMFFMdHhKQjB2cUdLRzdCb3crTjNxMXA5K3pXVnFoVEVv?=
 =?utf-8?B?aGtSS3NabkRWWnpsRElidjVaclg1L2tUejhvRVdOd3RmWFpjK21xcXVqZHhC?=
 =?utf-8?B?RFFJb05zZkVDVTVScitFMlBpS01VeVBSSjJTNXd6UmxUYXZjRm40MlVuMHR5?=
 =?utf-8?B?eUNhbllKS3JQTlBPRmYyTGlkVy9VZzczRHJEM3JlUDFMaVdpbWsydjZldGsv?=
 =?utf-8?B?Zkl6dmgrYkJmekJzK2xDT2NqOFYrQmtaRFE2Yk5HVjcyOHEydTBKQ0p3OXFY?=
 =?utf-8?B?bUxTKytxYzdPMEFyYXdBZ0F0U2JwblZpRVdIK09lTjExTlFPQ2sxOXdXR3BX?=
 =?utf-8?B?clljSTljNEkxVC84VFk5L0YyUzVTTnhMNG0ydy9KejRUeTF3eDhPNGFzeWI1?=
 =?utf-8?B?SmpqemhDZk9Cd0dSNVJwRTRxdndEUmZxV0dqSU80TlhCWG1DbHVXc2oxUTNV?=
 =?utf-8?B?NEpUL3hyaUpIN21nR2dCaWlFNkcvSlFnYk9vVGZySUl6TWJTa2VYMnI0RlNW?=
 =?utf-8?B?Z01EK1lhRHRId2R6bThnWmdDMGIwZ0haUUFhZ3VoQnVyK1o3U2kzWEhOaWlw?=
 =?utf-8?B?VkVZc3ZsdWl2KzNjVzZuSkJiK3lLeUs3QTg2ME1vbXA3NFJ5S0xlcG04Z0hM?=
 =?utf-8?B?T3N0Y2F3NktoREx6ZkVBOWdkdFFheVFWSUk2Z0FHNG1MZmY4Sndub1hBMCtk?=
 =?utf-8?B?RUZZV2RLazlmU2JlRXBNbmo2ZGU2clcwTmxJT3ZqeW53MkhLYVZYSXprYmlH?=
 =?utf-8?B?T3hKenQzTHlKdVFQK0RPdVZlS3UwOVZnWXJRaEhCSnhFL2d2N2FsYzBGZ3lW?=
 =?utf-8?B?bVozL3RJY3RnOGJIeTJuWkE2MW9CTmtwSDJPSkxUV1hpVFduK3ZpQzdOQ2sy?=
 =?utf-8?B?b21TY3c1dFVrUWhKK2JPbjdxQXZkTmp3NDhzUzhqVGhrb2NoeUw3WXZ2UkpX?=
 =?utf-8?Q?/GWvShqonGbprtbQ=3D?=
X-Exchange-RoutingPolicyChecked: ZF33UacWUZpcf82ykVB6dygz4Y1Ux9wr2yccoWQ2bgMEssyDg6jBBbXykx3Resx0V2xSF3lOsiIsFAsluXRbTNhxwHu5qhUDkCda0PGJStTM7sA7pGxi+TkJ6QKd/oOgHml7/2Lt3j3+MDANJTb4MHA1aY06IJ79/JRaELi335t8TKTkQtcE9DsuUhOY77qqVBVYlBtuuvUxWeiYpTnnPiO8QthQ74CB91eGA59XCoTsUbc2m4Oh/nfzmtF+iEH6eDb09oPKUHOvgBaDnNzsQdTY3M6w3BiAKbnGA5SWEldGVtc5GBNiTfz5y5HAkgIi78LwcvFtIyzs0l8GIQWXsA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fa8104-61cc-4be1-9bd8-08df0cd88b95
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 12:07:10.5368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftBLCmho/7Ps6rMZyksJEc+/9ZZVKt2aVXnR2UgUlrfuYB38u+QL+zWhYtxbRPuPyd+rxYuhB8BZnOHiJ1ESw46cFkdPYP57PJg+U5PBF5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6963
X-Proofpoint-ORIG-GUID: LvRDaJN0pqRiqONzNjZKC0GCVkeWwbcE
X-Authority-Analysis: v=2.4 cv=OdWoyBTY c=1 sm=1 tr=0 ts=6a9ea8f2 cx=c_pps
 a=dLe9bA1IkfUV2ft16lzHdA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=dXvAoEkxAAAA:8 a=20KFwNOVAAAA:8 a=bl8DKJq5AmuJocqa2v4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iJ39DRKJB4kz2P1Iyp3E:22
X-Proofpoint-GUID: LvRDaJN0pqRiqONzNjZKC0GCVkeWwbcE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzMyBTYWx0ZWRfX2/RGsXYd0nb7
 JxJNNHKjgXVbmPFK0rTQJu7benS1lAFOaEeXUIKoBjxXI4nNoaWjnRAAvE5JR2Kj8X34MEMxw5X
 ua+EyZzC6KdKCgV8CBRKk8PHp+cEeAMsw2aR3nPkjp2BaQbleLd7ZxAupwpaER6+yKS0AVsHk/6
 XxW8G1hExnCvo+Add7cH18SVcp6FArdyGH6LzGKbs2uojRWz794ZyDeh03dglQL/OLzBW7ttzjU
 1jC5ghjHWpMgBM+xTJ40FanVT7l1zmzl5rzqRgXJGakFljVN81OEAf9aI6l1fKmSA+o1sjhQPUb
 +nDgSzSjuBrKVgfXxD6AmUpkbFh/D+jUmkdiFW0mtAMYZWQCIyrZjFQlU/TA4rl1jJdPxycXfiT
 zuVPMXIZOUbx5iankgnZ3QKnYs0TpYz9H1SE0Fu4bA1vklC+z4WAELw5Co7PQ64hrwXz8LTdF5F
 dkNC+rDRWjlEH9mDpCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzMyBTYWx0ZWRfX5+EgacDzmnBY
 kaGeu8nkZ86Zdaq12c6BYrkIkkyH9PEM9D9CH0h0a0cdCH3MeThXq1xvfXBxwF8LsHAEEet+e0g
 N3T/PAu4KNI9iA+m5Oe5dYm6jVKaM0c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
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

On 02/09/2026 20:35, John Snow wrote:

> Make the extraordinary leap from Sphinx 3.4.3 to Sphinx
> 7.2.6. Simplifications and cleanup will follow in subsequent patches.
> 
> Note that CentOS Stream 9 only ships a version of Sphinx that runs on
> Python 3.9, so regardless of the version of Sphinx we require, if we
> require Python 3.10+, CentOS Stream 9 will be unable to build QEMU
> documentation in an isolated offline build environment.
> 
> CentOS Stream 9 continues to be able to build documentation so long as
> PyPI access is permitted during configure, or if the requisite PyPI
> packages are installed prior to configure time.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20260825215851.1780608-15-jsnow@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   docs/conf.py             |  4 ++--
>   docs/requirements.txt    |  2 +-
>   python/setup.cfg         |  2 +-
>   python/tests/minreqs.txt | 29 ++++++++++++++++-------------
>   pythondeps.toml          |  4 ++--
>   5 files changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/docs/conf.py b/docs/conf.py
> index 7e35d2158d3..cded047b539 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -51,9 +51,9 @@
>   
>   # If your documentation needs a minimal Sphinx version, state it here.
>   #
> -# 3.4.3 is the oldest version of Sphinx that ships on a platform we
> +# 7.2.6 is the oldest version of Sphinx that ships on a platform we
>   # pledge build support for.
> -needs_sphinx = '3.4.3'
> +needs_sphinx = '7.2.6'
>   
>   # Add any Sphinx extension module names here, as strings. They can be
>   # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
> diff --git a/docs/requirements.txt b/docs/requirements.txt
> index 87f7afcb2e7..c10c4cf7c91 100644
> --- a/docs/requirements.txt
> +++ b/docs/requirements.txt
> @@ -1,5 +1,5 @@
>   # Used by readthedocs.io
>   # Should be in sync with the "installed" key of pythondeps.toml
>   
> -sphinx==6.2.1
> +sphinx==7.2.6
>   sphinx_rtd_theme==1.2.2
> diff --git a/python/setup.cfg b/python/setup.cfg
> index ebb4230899c..927f72a46f6 100644
> --- a/python/setup.cfg
> +++ b/python/setup.cfg
> @@ -41,7 +41,7 @@ devel =
>       pylint >= 2.17.3
>       pytest >= 6.2.4
>       tox >= 3.18.0
> -    sphinx >= 3.4.3
> +    sphinx >= 7.2.6
>   
>   # Provides qom-fuse functionality
>   fuse =
> diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
> index 85cfa08cf76..7154ad40040 100644
> --- a/python/tests/minreqs.txt
> +++ b/python/tests/minreqs.txt
> @@ -12,7 +12,7 @@
>   # on PyPI that allows the test suite to pass.
>   
>   # Dependencies for qapidoc/qapi_domain et al
> -sphinx==3.4.3
> +sphinx==7.2.6
>   
>   # Dependencies for qemu.machine
>   qemu.qmp==0.0.6
> @@ -48,23 +48,26 @@ platformdirs==2.2.0
>   tomlkit==0.10.1
>   
>   # Transitive sphinx dependencies
> -Jinja2==2.7
> -MarkupSafe==1.1.0
>   alabaster==0.7.1
> -babel==1.3
> -docutils==0.12
> -imagesize==0.5.0
> -packaging==14.0
> -Pygments==2.0
> -pytz==2014.9
> -requests==2.5.0
> -snowballstemmer==1.1
> +babel==2.9
> +certifi==2023.5.7
> +charset-normalizer==2.0.0
> +docutils==0.18.1
> +idna==2.5
> +imagesize==1.3
> +Jinja2==3.0.0
> +MarkupSafe==2.0
> +packaging==21.0
> +Pygments==2.14
> +requests==2.25.0
> +snowballstemmer==2.0
>   sphinxcontrib-applehelp==1.0.0
>   sphinxcontrib-devhelp==1.0.0
> -sphinxcontrib-htmlhelp==1.0.0
> +sphinxcontrib-htmlhelp==2.0.0
>   sphinxcontrib-jsmath==1.0.0
>   sphinxcontrib-qthelp==1.0.0
> -sphinxcontrib-serializinghtml==1.0.0
> +sphinxcontrib-serializinghtml==1.1.9
> +urllib3==1.26
>   
>   # Transitive pytest dependencies
>   attrs==19.2.0
> diff --git a/pythondeps.toml b/pythondeps.toml
> index b1879c1a4da..f0f3af915a1 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -28,8 +28,8 @@ meson = { accepted = ">=1.12.0", installed = "1.12.0", canary = "meson" }
>   
>   [docs]
>   # Please keep the installed versions in sync with docs/requirements.txt
> -sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
> -sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
> +sphinx = { accepted = ">=7.2.6", installed = "7.2.6", canary = "sphinx-build" }
> +sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "1.2.2" }
>   
>   # This test group is for dependencies required to run various tooling
>   # and tests that should always be installed at configure time. It should

Hi John,

This patch appears to break configure with --enable-docs in a fresh 
build/ output directory:

../docs/meson.build:25: WARNING: 
/home/mca/src/upstream/qemu/build/pyvenv/bin/sphinx-build:
Sphinx version error:
This project needs at least Sphinx v7.2.6 and therefore cannot be built 
with this version.


../docs/meson.build:27:6: ERROR: Problem encountered: Install a Python 3 
version of python-sphinx and the readthedoc theme

A full log can be found at 
/home/mca/src/upstream/qemu/build/meson-logs/meson-log.txt

ERROR: meson setup failed

Digging in with a bit more detail we can see that Sphinx 6.2.1 is still 
being installed in the pyvenv:

$ ./build/pyvenv/bin/sphinx-build --version
sphinx-build 6.2.1

And with even more debugging:

$ ./build/pyvenv/bin/python3 -B ./python/scripts/mkvenv.py ensuregroup 
--online ./pythondeps.toml docs
mkvenv: checking for sphinx>=7.2.6
mkvenv: checking for sphinx_rtd_theme>=1.2.2
mkvenv: installing sphinx==7.2.6, sphinx_rtd_theme==1.2.2
ERROR: Cannot install sphinx-rtd-theme==1.2.2 and sphinx==7.2.6 because 
these package versions have conflicting dependencies.
ERROR: ResolutionImpossible: for help visit 
https://pip.pypa.io/en/latest/topics/dependency-resolution/#dealing-with-dependency-conflicts

*** Ouch! ***

Could not provide build dependency 'sphinx==7.2.6':
  • Python package 'sphinx' version '6.2.1' was found, but isn't suitable.
  • A suitable version could not be obtained from PyPI.

If I remove installed = "1.2.2" from pythondeps.toml then that allows 
configure to succeed with sphinx_rtd_theme version 3.1.0 installed, so 
my current workaround is to use the patch below:

diff --git a/pythondeps.toml b/pythondeps.toml
index e4c10d4a9f..84c444ffe8 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -29,7 +29,7 @@ meson = { accepted = ">=1.12.0", installed = "1.12.0", 
canary = "meson" }
  [docs]
  # Please keep the installed versions in sync with docs/requirements.txt
  sphinx = { accepted = ">=7.2.6", installed = "7.2.6", canary = 
"sphinx-build" }
-sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "1.2.2" }
+sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "3.1.0" }

  # This test group is for dependencies required to run various tooling
  # and tests that should always be installed at configure time. It should


ATB,

Mark.


