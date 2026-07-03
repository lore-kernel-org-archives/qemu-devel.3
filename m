Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB52C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZtC-0001SF-I3; Fri, 03 Jul 2026 05:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZtB-0001Ry-05
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZt9-000857-BP
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:48 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635tUuS1991949; Fri, 3 Jul 2026 02:08:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=l6Hq4OjrNlLq4sHf4tAk7gQAc9TbirLwsGPk0BFwB
 uQ=; b=u2Amwt9De2kLKNPjMmwgVGtGNqIwgX29GB/RsQp44udnwTEGYgLq6TD30
 mNB+yKR5Bm7A8QvS0pkVRP05nR/BeiTudc4OjEcFIlpeAmqhNCjQVWoHMOwvioVf
 RFDeDCorVdfrlAVzRr/5nBORgDwbPZAD6wpdHUMoWMpR1NB4xTFgdb8ilkf3u3Lo
 4nzIbDHaCe0RijzgUkbqoY2TT6c7k3dfuQJhVfJU3AqetbG95ecyxdDaNR5Rx4q4
 oYlh80fx6Gmbdc11CVLOE9mGlTeXy+8G8sTXL7oJMGZ5nNkcoOBZFq9x/bThSPXK
 iz7O5LY+kWHWLRod0LBqkiZojtTiA==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020138.outbound.protection.outlook.com [52.101.56.138])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f5d5hc3fy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhLQBaVi9/DKn84HrWgbgSizoisyekYJRRfBuWfthC13LdPc0/k8VLsYqxXUti9sNzRk1HNuUCiAUPj0b0XBAID+WCMitubRNAKmfLPJjDwwBfHIIckn5vajHAm1XaaWH1UeJknKRX73QKkC0dlmR+dLW7IOWy84pGNvKD4tPTrteDnyiLTWo4D3uW34XATAoFv9ne+zeCN/AxVlOEvvEgMedvh41J0nIFHLsJpnJRVRh1Y8oANcIcvA75pLRyIDue5Atg3+KkN4FrDei0WJ5YFEEl5+bZGz5hkCLKCsOvkAb8VWNCLHK17U4B54yqPk9NdzL6Av3W3BCAyXCtHOBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6Hq4OjrNlLq4sHf4tAk7gQAc9TbirLwsGPk0BFwBuQ=;
 b=teHJTYTJ4orJ1ZI6cKB17yJFG15wSzk1onmOIfBUKEdGq3+/oYxx0eMdJLAiy/lATonxAWvfkw2FIB8DIeQAX1g1RkMluDR7Ec6t+ezFq+F+WBlv8a7P4wJqvavrMp5ZJW3vf4zCUVY9ZiBsbXLTLFwb5KFxMr+wVCpCF5pzGKe/1qJj/bNBXzX8CBfGy3+2CKeLDTSVdafy6LBxwUirWCYAtb8GjB+EQ0dCeL4K+QIAajAbbHZO+ml4SR3CHgudD8gU3yxXDHajIqAsZSv+7zKiEuMqMacRd6LdlDjt0biUIHIcp4nWcI0sXUKgShltGt2mbXDSlmsvMb2U/7oQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6Hq4OjrNlLq4sHf4tAk7gQAc9TbirLwsGPk0BFwBuQ=;
 b=dBVg6K0KhtxewXsknP8eURJ5Hen8heFVN6TS1WVaUBxJ9SZ0dBBA1XkkdceYBgtMQir2ViG+PXqst7LEQscvMBtrat2PjxsP1HgSmaQ1YHN8eIHij0rlPPIp3yN6mcwsPBm+MY15q6qyeAuKlYHdGix9Y0csZc/uOVFOJo76t1jlRRIXW1EsTDuXw7QNQi2iWxgHRWvxCCrM905mIwvX55XFjxs+R9ajIBEmhd8V3alImgAPXXPttM4r9tBP8lDHzRpS6O62MrYcoX/u+Xr0BoEH2/khfg+rZZ87Op/DcIKERV1QAOyNezH9wjWk2BjjC9oyrIFia+53SnQI6/y1zg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SN4PR0201MB8838.namprd02.prod.outlook.com (2603:10b6:806:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:08:42 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 09:08:40 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 5/9] hw/rtc/mc146818rtc.c: convert date from object prop to
 class prop
Date: Fri,  3 Jul 2026 10:07:58 +0100
Message-ID: <20260703090814.2993188-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0225.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SN4PR0201MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: fba0c6be-c380-425e-5d41-08ded8e2ac69
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: S46nAbR3P5U+X3fwcFK90++CENLBs+R9yGbujUj5xjQKnz8TKVyV8lpveycXZD3GCfSLL0HjoFEjpmc0HO2ZDiFTZdOfvnf+BZidF+fks/qF70w7AKeBGNhm5xjjz0tn+/GaVR2J4FLAAnWktgyZz2cfKknVuDW2fZbTR/tWFYsP03hD/smKIkhcDZ7TlrmffOSYr3FwDH+rf1y9kQkWboaEcuK1o886dw6jXmI94EWqhx9unlaOh213ISgeZPdaQxwKt/8WGWoPqNJpScfGuSvafVT7W+xhGzYiPoONZtOhj1DK4fSBqaYR5NfiRr8mWNKjI+x5l36I5NGnTiFuyi6NU4FUP1CRyCYCwOApuYdetstVjWx1ZOCyUTRYuZxzW/MU3v4LK2qHgeUWh3Lo9HDaD8GkOTuIAl/dc7ifaAci/I1ON+58CWIvhmmFZmZWltVw+MdyyzWoSKcMfO4qqIHq7wsQZR9zWTaHgQkk1SGcKBWl4xaOTdGeO21nM6dX5PTOJY2rvikAelL4nELOJT3vmaPEwrlU4lWpIrU5ERuxxJKQVp7XZUOXplh3ok45sY+DrNYqKWNEL7rvPOQ4jlxH9/5KmMEewNZsADiXUBsEu8MExCWqi5gJQQ0+suImEFuxe2raYhIUvZIMHAT22K7m+UldpdGD3FPXZDxcriM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xAEOp5vifzJZTKJdaIWgTd3X2ClS6N4GAx48/OdwdHBmTKRV2rUeN7iEo+gb?=
 =?us-ascii?Q?rWw8soKnp7fCEKDAkNqHGXqI6n8GMN6FoYNWj3LAUYxu0lSY7mb1DfHfg4X6?=
 =?us-ascii?Q?aYzp1QBxYylZ7pM3CIM5GPaZXSok7NEYws+tv9gcm2GsLdft7YGbH3qnfJyG?=
 =?us-ascii?Q?OrzOost7MZ2d6pSd7GEpBnJbQzRmTi6wbW0exf47NQnnBN+4C/f9FEAvJbcd?=
 =?us-ascii?Q?v8ZLa/i+rp69+fqEew7dFk7VSG+teiOuYFPyXukorCzkv3qXAfGbbYnuvc1O?=
 =?us-ascii?Q?M4yNyDxBGaN7eDn87wghIaSOJSllWYTMvWzSwZaImowb6bLaP4be68Iv8CUg?=
 =?us-ascii?Q?y7NHz9/NsaA6NnsXF7Lsv91BLNfjnpGYXVtrRQXcEf7Rhsjh2qPvl5EEynSF?=
 =?us-ascii?Q?w48b0FEFDfMU84Vp3F0AFbbFBHmfBExzsZo5ykoRnbitqtbmiHpZOa42GUKg?=
 =?us-ascii?Q?alQXx+Ld7N3jTVe1199joKiNNIN4w+0igat5sDYcLN9Y+H+bhDrmUiXhmrMC?=
 =?us-ascii?Q?Mrz1upjo3td78zaGX7+Xaxs1rCgXcXRxSPiXKO6UrDnM1BdU7TPCZ8mH2pVg?=
 =?us-ascii?Q?OatqUpkp0WKrR/DzXA0occ6ibCXV7MreoeN09PMgOJIxNSq2Hvrau8E/9s85?=
 =?us-ascii?Q?nQW/sWt0TYylinahBtAK4jIsJ50//cXwPpF1toygHIKc4U2cAbGgb/zoLH0X?=
 =?us-ascii?Q?34NlERy6Bj7Q9e8BTBOVyOWpJNEnxXkwC52P7FguyXbdDoezTC5EPILNy9m9?=
 =?us-ascii?Q?GB8uzXIRFbDa87sOZTlTzmpfQ3DkwvmIJI17ndjXo7s4HE+4yko5s5AuIYEQ?=
 =?us-ascii?Q?nKQe9HB8+RK5RRHa7H2XGf9vAhf2HhI1v0Q8V/OJElAm83oAzmWKeGirTDJ+?=
 =?us-ascii?Q?QppC3Y7TrSmnnPwfABHTi+TDzAKDtV4ANcIipBZhalN/YFQIIWOqjUKGHTvM?=
 =?us-ascii?Q?SAqCu4xWHoIqqH6xTyU7fT27QNpr+CNUDsF5myaXhWSIh5k7XeRJnRNIoGRF?=
 =?us-ascii?Q?ZmPQCtDVjCIyU6kHL2bYhjrAhT1d9adgcVNxrlm2dubrUAALGlU2rTd/e1DV?=
 =?us-ascii?Q?vr+mWh9i/pQkvKwZTScKzW36qrbJVKxPDzmHBml/JC7t1f/fOEcEmEsJXYvZ?=
 =?us-ascii?Q?Gs7SnL1utLXMK0oc7+O4weJPUl63ESNjScusSuv3L8orJmb9+Djhz7c9g2E4?=
 =?us-ascii?Q?4AXK1u/lSt+Gj6azkQI2PR+botbibPxlvgQ0Fd9eGi73+Bx3iJcnZs4ljzei?=
 =?us-ascii?Q?lSlWgwoK2LnDSOK4CkABIMNK99L79z31suNEcB4+CgMyISXmU3Us4jsMJXx9?=
 =?us-ascii?Q?5++nRxuigMuRMXoabqu6RGKRjGl8TaBLiDoqfZqPhZGgnlx0zppaCZgotJTB?=
 =?us-ascii?Q?RSH4VYvq1EBYAoWVmyM1giv+p7xuSTt5qtLutiR1EXq27qj3P/wgXbU/VEt4?=
 =?us-ascii?Q?aGRjZxnZXcjotJIazt2L30WRUJQMMMYkGWy8RYHENQf05yHP7+Fi0070QXKz?=
 =?us-ascii?Q?NnXINdeFNCl81DxXzZxl8+EhwGp/KjIkA1B6TkDHLhVqYHBsNgwZVCCYfkPI?=
 =?us-ascii?Q?tMXH3QaqMtaZJkCyILhGFv41b5uTrWQKEDR31f8CNqIkjXp9euu9ypgUkkRH?=
 =?us-ascii?Q?PiMI43YO3Jw7Cd7pFh6pPmGcUYrbCC/z945Hlp8BZGx6XzwrKkz3WqXaVGSx?=
 =?us-ascii?Q?oAIjt3vH61pWl+vs7yEl6fDpYsiwcbblW3AcrACplrpEPOYCpL+jXtBuvwWK?=
 =?us-ascii?Q?BnJ44SOqMq3/7K41ntnjcHBYajGRyqE=3D?=
X-Exchange-RoutingPolicyChecked: bzlEVTD8AFcYz5ooV3T+AI9mujLrm1pe9HjQo8Fs4Xtni+Omzqts7Mq+f9h9Y2rjB1kkZSz2LWc3ru3RqZe8nObvz4oqHZRFXZyS/co18c4BFIihp1/8juLv3lK0IDvuA6Gu+9X6RzWZyg/28vgvWoHzPKM50ktM6OwiYBHQoejXAkuSlkh/jM1CkzNaN/qa15tdHMoZo9MelHRrbPz6ufDg6y3S51OB4rqwuIsI3YiKF9heiY2lN4EgvFiV/lpItxSfQKriLd7gwUNFlO0x1YYLKxCDpdt6IVJScCFIff5SRRE5mb5EGoyLdt3wqp/E2y2aHohBzwx6qGqRxbA4Hw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fba0c6be-c380-425e-5d41-08ded8e2ac69
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:08:40.5140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7g+Css1Q2movbIojCbS9aZjE5l3hK2FgH2OFA+IS5QlB5MQZtETPhbOUm1RjtlhvBGi3wwevM3nz2WrM4rJguzfuEROT1d+cTHbifBMkeXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8838
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfXzBuSA9gCsNQd
 YClNSe9vbsov0LJZaNCMhV89TFRKAPigSravWWK0ctt5QUVVAMrfjNYdn43WGALGG+IqKunZkGY
 M8dWsXZfUq7C4oU2E/UW/wSlxoY4e5NHo68ueTEjynsHgMQy9N3TaHB2X9OXG0/ZpY+Byqh4va6
 xLHB7VC3VJNgyLahvyJq2VRbtnzItB/hWWPgYqYxX1mNrfI2MyBHLYmbRcmBn7NYbodBRKLQCPk
 Kt5ITmb+UBEfw6koZlvQQPKdyVBLVS9t/BNmGK3F13D/VTAk0e5OhIuFB7tjK3cheANQS93YmYc
 VVN44ZVOdg2koR570t5uCluWgwA0JSiFtu1G5kEEcu3uvzHPlQLCqeNCByLHznt2aX6tn3Eii0O
 pcGyXjFLOepP1UG34Lr5+NT8GbtbHkvPz+t62PPohp/iaGA6ZekoyhsMZCNBVWTep6vWUE6uppW
 U5qV7qiPYI16QDBl84Q==
X-Proofpoint-ORIG-GUID: gjEtd8P-KJ8xMs2G5P3N7VXA7csPkXFN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfX6WTlkYYUZgoO
 a7VyTL6Dmua/IDXJvUW97ntkLDJJSEwgJKJ1aVfnqCt9/1me6kKm+oQnxYFdbnkoMsmkQDYk38b
 Ao5gFCG+zDCD6vCgGcX1KFVQ7yJhnSk=
X-Authority-Analysis: v=2.4 cv=EMM2FVZC c=1 sm=1 tr=0 ts=6a477c1c cx=c_pps
 a=DeTAa6nyoFilAy9LoZdG1w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=jAp_HAs5kC137pZsH9gA:9
X-Proofpoint-GUID: gjEtd8P-KJ8xMs2G5P3N7VXA7csPkXFN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This is to allow it to be the target of a class alias property.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/rtc/mc146818rtc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index bcab018c7c..ba396435d1 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -920,8 +920,6 @@ static void rtc_realizefn(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->io, 0, &s->coalesced_io);
     memory_region_add_coalescing(&s->coalesced_io, 0, 1);
 
-    object_property_add_tm(OBJECT(s), "date", rtc_get_date);
-
     qdev_init_gpio_out(dev, &s->irq, 1);
 }
 
@@ -1020,6 +1018,8 @@ static void rtc_class_initfn(ObjectClass *klass, const void *data)
     adevc->build_dev_aml = rtc_build_aml;
     device_class_set_props(dc, mc146818rtc_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+
+    object_class_property_add_tm(klass, "date", rtc_get_date);
 }
 
 static const TypeInfo mc146818rtc_info = {
-- 
2.43.0


