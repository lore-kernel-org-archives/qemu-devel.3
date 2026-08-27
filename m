Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B6BC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbBU-0007tI-Qs; Thu, 27 Aug 2026 10:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBT-0007t8-Lf
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBR-0001zM-Sr
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:34:27 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE8kaj4152238
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=BsPPhQpuLfdGnCaMrt283BWtkQUvO1ELkb4UtDC06
 l4=; b=YagQvW3YEaS/4kdRqoGft9TD7qpMxqmPfc5IxDZYcv8CibkctbTHmAR9T
 Xc5PeVk4zmE1hRDh2OREl4Hdv8st1bCTVauNsMJ6jHxduEYz4a8kMIe9wH0SyQVw
 yzV54UyWErTQPW/CvLZHEHErkOfVJy17ioh7snq/+suzdW9QVE3Gp50CNQkSj2Yj
 AIfqGFI+5Pp2MIohtMT6t0hIVo+ViVMbvZ+nQqPrnXQFWuyNNg21r3TBI+PRWu/w
 LT0lmwYfd9gVaUvcZajyNctFO/MEsk/VU6QCWSm0I+NY0HRxDEGQ7DjQ2UVpipPN
 4KT8jyIKyZkXX+PkKlPsfeV5ay+nQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020086.outbound.protection.outlook.com
 [40.93.198.86])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g9e1udwe2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yiFfMaQaUy1Ah7jx3o19hC0BtvHcuwUtQ+jQMED4Sgd+0OIPPomBN9y87+npODoet5QBUC1LpZHKT9tKEBOQlIatgnk/SjXnSMH1gb8kB1yuNYJ0Y76D3hQ3lhzvzs4p2/QhzhYmw+dL7BFVKqVxbfL7OVnCKWd22zgyZ7qInr1DotJmLZBOLqIvn2uHVOvIdE0azTveFohPffgBEEDFvc8UHMQMUMkeQM/8WVGdivTd2KnVYC01menG4+gRRaWDHBkdU0kpj/+Ewrm2gr8WEv62/DkiK+09HLp6EpNkT6Nr7h73/mvyI2fIltNjRHEednYScG5UhEy8mNgSxTzDCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsPPhQpuLfdGnCaMrt283BWtkQUvO1ELkb4UtDC06l4=;
 b=Ba7dPu4S5RKGzRpj1c7xHN5QnWsxScVkw8jipXoOrdMAVHF5gsZ6FTG/QurcsEWYWXy2d8xsf3D1eSMsIAvN06lcvmBpu30JAuM6yyrNuP6cb2HhEt/ZjL+jCb45bwmqpCct+U4mKWBTSG3/jYL513YVeT/zSCsjxVgxHO+6BFoRyCxVRCefa5kBw/5pqjknYOaLlB9c2nY8ZUgLqGs9xssNzWdEh2qiAsN4lHX/bv9i3qGAAlSPGGRTGr/etZFwm1Scve5qMxUyaytBI9enlmxFsinmXp3ha3ga9gt4C/u16Y2r6LnTOniB8GceWgi/dXCJ/+NhYEQifyai6yuzRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsPPhQpuLfdGnCaMrt283BWtkQUvO1ELkb4UtDC06l4=;
 b=Z72Fs2B9Nvbm/8WhUFJgbTk1U3/xacXCRM/fEnlmzC/R5xx0tok+t2YPv6exQztOuSl77XkWIJsHWxdT4/KEQgnHxK+Cjo15kKRpbJdVyQEM12qvhVoc7OoEaMkKEHT7CW6ClA5uoZzW4dBuB6Zyc0K73GRsh7l2kJoVS0ShE4WnbTxI2ZnimS99rKceHB2Q9IAoSZrjIaujDq6otcdxs7IeKg4Y5haoLItt/E0ELeSdyVCDQ4tWiP21b6DlmxsXnWlwsRbDlGzlpoxrYC38lUaQbRtRFC7tjZit9gN6Ei18ir4QsYYiuFon4cLA13Ev4zDI1JoZKtm7xspoGj55Ng==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA3PR02MB12061.namprd02.prod.outlook.com (2603:10b6:208:629::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:34:23 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:23 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/16] qom/object.c: add object_class_property_add_uint64_ptr()
Date: Thu, 27 Aug 2026 15:33:26 +0100
Message-ID: <20260827143404.1393166-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA3PR02MB12061:EE_
X-MS-Office365-Filtering-Correlation-Id: ef971ea5-490e-42e6-6db2-08df044849c6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5TRhe2lyFGkZTCs+mzzBjHEfd8mHL/bp+ARX72xbsmgnksYgqVhzADQDGSXFpYdeMJn330LdvyeGMr7GFhRNEuWYc0FxgS7nwGKAOrj8AQYIK0xnndbXI1fg20q0y1/8Cc4z6cSp8oJhXzJH7+13v0bgJ66gAXG+lgsYfdi82BLssiqkRO9tAZ+YQlo9iBnZLUY3DM+77XR7qvkArffqasDpHPMQ9WMBoWYt71wDep4jKiIimMKmjqLB/ACCB2TSGmEXnK7mgwHLOwWPYQUZt2770uxDIkN3L8tcormCDVfiBnBB2j0VROz3YEdW7JBvnwCjf1ccWWA0+TibA/shpBBa0cW2z6ex6snARCAVqktoTT5n0tmll+Wbid+UPPw5AcKvL1YpEdMev+EwwQEkPxZDXiDzhj4+j9HiejCH/CYF6b9YXJgFcS04aWv4zgSka8o2seuHnmT6Yrt8EswhwaU01BmV20Thop43qcfz2bGZBThx5H3i6nsmn5WN4gvBfFu8X6hY7ObstQnXvGBOEo4aFoYcIjztqdS91U3/n8fbXe9ujHtT1zlTkt17q3UvjSXL3FzspGhMsk64ZHwM53fT4HXEBAP32tXtjoKao14AA8Y59ReUPttgHkJzeSKW3EVoqjBgBsPoH0w3x7ti8MHxMhHq2tKaVi2c8OFY8Vc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnU2RVpmVy9aRWQ4cG9iUFdJY3hvQlMxNXRiNC9uMnhtby80MFBKZkxYSXJK?=
 =?utf-8?B?WUE4YUJteXViQjR2RDRBRkZSUjVBZWV1ck5RZW9uRWNSbEV6UFRxbjUwQ0xy?=
 =?utf-8?B?TmxHTk41enMvdjdKOG5YTDZLUUJkNHhYRXZaR1diNjdybzdDOUhTRGxpWWZH?=
 =?utf-8?B?WnpYUGNPZUxOdnk0c3d3bEF2K1owRnNVUjV6R05PMUsyc2x2ZkFnaG5wc3Zl?=
 =?utf-8?B?cmtOMDVtQ1k5REVDekY3WlZQem5iV3MvdkdVOXNjSExIOHUyZE9rWnArNEFq?=
 =?utf-8?B?alNLYW9yQU4xU0c0WVFqWnh6S29WcUpid0xCSVhlQjd0V2RvVkhXeDRRci9F?=
 =?utf-8?B?WnByOHBJajhIaktXZWVZa21NcEtKMHBKbmozWWlCdTBNOER6TkUrdzdQNEQ1?=
 =?utf-8?B?czBaemg4bFRBYnRBcUVqTU8xMmtWV0Y4TTZqdkI4MnVUeVNqcVJXK1RMa2RF?=
 =?utf-8?B?azc2a01sVGMwN2pxTURNNWhLRGg3Q3lyWmxWQjhHMDIxczBINWlOSW9sWTdk?=
 =?utf-8?B?SmswdVF4NWFZblJDZWlkRGNYMzlHWngrYjVYUnRIeGxDTk11RFYrZExPeC9G?=
 =?utf-8?B?TnR1Z21SRmZpSU1ublhpdFplREpJeldDYkk4MnJiOFpETi9xQmcwVmhZRmVm?=
 =?utf-8?B?aDVQYTN2Rmx6blJObnV5WXFJZFd0aFc2V0VLL1R2SHR0MWFmbWt4ZVBJREVU?=
 =?utf-8?B?Y3VYYXRDODRLbThvVjIzZUcxVnJoR2hERUZQdUM4bU5ISmY4bmgvR3FKN1NT?=
 =?utf-8?B?OHlkWThwbk5nblY2L2xkamJKOTlEcCtjVTNYY3BqUVQvdWp6OWpuVXdaZS9x?=
 =?utf-8?B?RU1GaHkvc0x2THorMkllUVBoOGRwRi83UkJUejQzcGptS0ZtM0MzTUdGTFc0?=
 =?utf-8?B?TVFRTVZQcTV6eHNDV0NpekVQWnNkeFg5aXM0ellvY1NZQWtuU0RJV3hHeFM0?=
 =?utf-8?B?bXJtcGJqYkNFUnErTjBzTmJlUEIzTzVmSjd4ZUozcGtXTVY0YmdPdjQ1VXZ6?=
 =?utf-8?B?ek02Q0RYcDFuTk96cXNISWFiNUtWcmRUT2JHU3RDeGVvTEZLc1lmaVU4anA0?=
 =?utf-8?B?dk41OWFLQlZ4c2k0VENIbU42ZWxZSE9nNjJ4MWNzdXI2dmVqcW5VOWdlb2U2?=
 =?utf-8?B?d0ZGd25KOFNrL0ZUcXZ1VjliUlJmZHdaSFU3cm9zczJ4YitjY2lEZXlnQTIr?=
 =?utf-8?B?L0pNZG9oMVdwcWpJKzBRVUloMmIrdDJLUVlKYmFwMVNSSGtuUkI3SVl2MlN1?=
 =?utf-8?B?NGNkY213QjRVM2k1eWNwS3ZCb3VaVlFPRThCK01xb0V3c1lOQ3RPZk14ZXJv?=
 =?utf-8?B?NTRmU0UwalpHU0dYN0xSc3RhNnVqREJrT2xCYzhZUEg3K1praDMyNmJoZWdN?=
 =?utf-8?B?VXM2bnk0MHYySGhSeU1GVHFjRFE0L0tlRXdyYWp6eDBuRVpPbHAxVXlkbU9K?=
 =?utf-8?B?Nm1XUG1WOTZ2Ymt4R0dmaklqR090dGxFeW9iOWNTSlJmb2EwYi95SjBUU1Ir?=
 =?utf-8?B?ZlR6QnhKUTQyMTUzQ2VkNjYwZXZIQUMycVVtVTdrck9YdnVoNDdsTVB0OXNI?=
 =?utf-8?B?YTByVHB4aHhKSDJad0FORkh2Z2Q2Umc2SUI4elFhNEErT2NzRUVJTElJbjRC?=
 =?utf-8?B?c2FPUjNXQUtxK2liejNmLzlmUklJVDVIaXRWTm5WWHFuTFNUZkRjcWErSmh3?=
 =?utf-8?B?cnFlaHVxdEpkSC9uM3RCMDJGNmoydVY4MjFmOHBHdWdNNmNwZUpGQmZqTVdm?=
 =?utf-8?B?OGVoTzc0OVJMTTg0blNqUTJRci9pMFYwNFBtRnFYVWJMdEVuOFY5QXFydi9F?=
 =?utf-8?B?WWg0T2FDc29xSDhZQlhNYjBPOVBRd09sOXZOOW5peml4c3hmZ1QvOE5adnht?=
 =?utf-8?B?U0VtSXNGUWlIRlBsb3A1T3NYYjRUeEhENW8xUnE0MStEejhRUWovYWJaR2NG?=
 =?utf-8?B?S0crUW9IOS85dGM0cjdRMlA1M3lIWHhQMEtoOEUrNHVjOFc4S3ZWT0kzbEE3?=
 =?utf-8?B?VkdoK2hsdCs2R1MxZ0pZbE9vTElHVWQ1R2I1RFJ5dHNLdndEdnhZZkw3Qmor?=
 =?utf-8?B?NEc0ZHN3MFV6U1E0dW5OTGlvTy9PUnV2NWtLbGF2WUN3OXNQWEZZV1N2a2hV?=
 =?utf-8?B?bGZuem54SzhYWjNzMDRBK21oWG9kbm9xb2NlL3RuQjFwWFBXWGNYeEdUemlB?=
 =?utf-8?B?QlM1WVFmMG5SNGlNYjQzb0tTdWlVS1dBNTRibi9LV2wxbnplUHh5b3JSRGpl?=
 =?utf-8?B?dmRlN3B4c0RxM1BxRG9qek5PLzdmUitiTUpwYWdscXYxQ1lidWVJRWxRWVlN?=
 =?utf-8?B?SXRJRnJuekNNWUlOek5UZVVNMWxKeDRYa0YwdnpYdUdoeGRObnlNbC9MUWI1?=
 =?utf-8?Q?kKh6sc07UZ8qOjNE=3D?=
X-Exchange-RoutingPolicyChecked: 14i+dzLhE9SD1JeZmNXyWiZBqDi1NY8BuYXj8x8a+gdH35sYYB6gSoKeNMZZlCdwghQ2za4mapeDNCxBTkSCDofzT+JHJWjJOhhdOldthe+emhOI91LjeKTmIgq4zTW8ZJ9YeTafuVX7jS24uG9sKlXIKjjAPAn+lTpckbXGmaGf3u4v+cgsxZ11ccbmBZ6xyStyMb83tlmglFMXiCDtlX3KyInx0DB/JitAkfhYoJ6oL1BDqu5aTLpDbeCmnzNoFCCJmqAJbklsNMYLWlK8YdLsW4wGopS1Yve696JvQYl2PMELTgd1qPdzvcklOQTWSS6Sg4N9Urzprniv0uqQ5w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef971ea5-490e-42e6-6db2-08df044849c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:23.4361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpgBnEC8y2qf1WOR2z8XG8qKobfWXH0Y47C+wt8izr58+WWQSr25rUNH+JvhIqn+xS3x6uBqMOJoJMEs6pBjyJtSu/wt3wJKBWpByI+eD7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR02MB12061
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX1ZBWDcsBZRso
 tMj4sDdmUgXjmAkGEUbYFdHXAiWf5Zd6MrLTlsR2OJQXHEOq2V4alAaeB2rYtuvB0YYhvRqnu6O
 pcS1f+rIBTLTGHHHzE5KjNvApDogzr8=
X-Proofpoint-ORIG-GUID: jmTCmaZbAClaI1DNB5Yz3FdwYlkzZJt7
X-Proofpoint-GUID: jmTCmaZbAClaI1DNB5Yz3FdwYlkzZJt7
X-Authority-Analysis: v=2.4 cv=RJyD2Yi+ c=1 sm=1 tr=0 ts=6a904af0 cx=c_pps
 a=lEAsXE5stpqivpVhnk0CUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX6I7hWv5pwQBU
 ZeVbQ05dpaa2zNgLKmuLAPg81dKQGwhY5sKhxUtJqWlxezdOZrnLZWVuevslng96QU5wcSTNQzj
 rlQnpWkxP70m1D7MFlD8ZBRo/Z+ly0hdeT1dGpB3W2UqjcxBxJ5jWty0KDjIFUMxIR8R6oGfgCi
 OfI+Xl8PgftRGcQlwKtkK3dHdKdDTlmhPwNeotUDn8AUm0UCjm2pb8sD1il1vMB1cIQB0qUtBxr
 FOyxGwZ8SA8ZgtcP1ced1bVKOysDBQGPFAY/ywuTXXoJLjjtCLNJ7p+N4L7wRDZz/0CsKAv+KRd
 42O60WjcoMfvN56dPnDk/bj0UjRzd0FdPCKaHdIJxV3PRUZ6cNdMzmkKC6viY6PE2gVJoYz2vJd
 zEdkAcBTGStQVtLx/ZfIy5iKqm0w1DSCVUOUHNPtsh9XE7Le4QnfcN02NeBCk2wxSm7mPDKGxww
 9OvZsnOy5q5ABEciUig==
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

This adds a class property that references a uint8_t within the object instance
and is intended to be a replacement for object_property_add_uint64_ptr().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20260825134320.1039012-6-mark.caveayland@nutanix.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index eba675d218..67ccd2b08f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2168,6 +2168,24 @@ ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
                                     const uint64_t *v,
                                     ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint64_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the uint64 value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint64'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         ptrdiff_t offset,
+                                         ObjectPropertyFlags flags);
+
 /**
  * object_class_static_property_add_uint64_ptr:
  * @klass: the object class to add a static property to
diff --git a/qom/object.c b/qom/object.c
index a480fdd400..271c2916b7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2742,6 +2742,7 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
     OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
 
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
+DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint64)
 
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
 #undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
@@ -2911,6 +2912,26 @@ object_property_add_uint64_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
+                                     ptrdiff_t offset,
+                                     ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint64_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint64_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint64",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint64_ptr(ObjectClass *klass,
                                             const char *name,
-- 
2.43.0


