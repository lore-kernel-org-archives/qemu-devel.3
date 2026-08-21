Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F125C5DF91
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNET-0006eu-6G; Fri, 21 Aug 2026 07:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNER-0006dT-6j; Fri, 21 Aug 2026 07:16:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEO-0002Bb-T4; Fri, 21 Aug 2026 07:16:18 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9MkZc1901568; Fri, 21 Aug 2026 04:15:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=QV/wpnZvvpkUeNITUMY/+azaXZ9saQXxf80xO41Vg
 Rc=; b=GMLMrIrjUVcjpQR8kkvS6lTrUsD3iUTbaAEjPAGEqoWfc3dODQ6wR0niU
 ZwdIcSIx2SwIQUPPOWY+Z57+xUjPa3ZuoWm12TsAA86mpVtG15Z3fplXQzoNirAb
 8LUbStF+JViwTR+8a3P9ltT9SiYbHtRPDm5l8/G/3BTmv95qVxZd2qUWWr3ABzxS
 pcS5HC5Od3Vzb3TlwDUXWWjyko7T6qidvss8MkuImMR54zIPOvJCUlEGiVqAh39m
 KFxAV/pnsH72Tha7vBk9A8guvKrPfkP6I1ip+bclthQ9gsmc0DEbPkPmEr1t45sF
 eND8FbZ9HxysUEQ5G0yhlQ7c4xaLQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020106.outbound.protection.outlook.com [52.101.85.106])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g6cm1s0sg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/ajvD+3P2uHC4rwC2AdDH8tVkr3aYksV1N+TFGcZ9gh/SwLrPAyMYvCokArodTak1HH0Bahaah52AA40898mVRsv/2ACC3R7wx2vyjMI9EZLKA221qkRPP8d1gW5uxtHYWcShn1tI82o2CeSiRAj+eb9HIoCi8bB69Jgv2foYPKnd7mQgxmd98o5/OA4Ghong6dd5RNkaXucd/z5TI+NsJKcW0IMmIVp+Jv/nT8RlmUPLFWYmVmSwgS4gi1p6LyMmdbG4KI5S5mLVIoyJMPlI/UfTEiaFssFs4qOa4wBnFyaN0sgfCNMdvbg7LCQfH0VDbCVgEjI7KYPnufWwzgww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QV/wpnZvvpkUeNITUMY/+azaXZ9saQXxf80xO41VgRc=;
 b=eqtdxhoGNff2FgMLCiR9xYlJMbf7VTHbQgYZ8kugBPdESQfjfr1aiKj605OlYp7rdEJV9R1FOZg/tHjimlkCRTtiRQAayvN7/rFC99Ra2/C3MArvIsSET5m2O/z7tBACovmOQjA5Ms57bOn0MbOLoi8u8zxk3OHfc0up96W7G+r7Fo8sQcjIaQzdH7Z8D4Bpr1tX3I5YXoigEAOS/fIZLxu2EN5G3EjtSU6rgupGtWYnKROnb0HVowLPlLF5p81zIzUNatTzbxjWlQt0jouTNQu6mqfoNj3E+IpNW8W0cKSd49S3QVrFtxkyIIRsIsn3/COxWpaw1RHseZmz6mcjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QV/wpnZvvpkUeNITUMY/+azaXZ9saQXxf80xO41VgRc=;
 b=wTlzGcp8l6Ux59azqas5wILieNqz1fuHhnlGIBBQOkwBh/0zk/zmZ5yLtclrEXvUkiv7pPZ02p1JEhoxfPHzUa/8oFH6dKXKQVhuMpqlTdwsNhxJCbQKWxcv4GbnlQAF2/3lYTCVEj/lKtmX3AXdB69jetmu8J1UctUYJgcjjksv7umjOWU+BPMnmA2yUHm9QjxgMppgbXJaVnSdNxElEneO8oXL327O8kteWBs8KeyGKhs44P9kIL2qO7DTFQae3UvIOLnfZr7kVlt8Bi9bAp6CHBChnFMvkaIQxmtyzIbYeEVyORRq/mB3lZngp9/OVRoxHHN1qAm9BrAY7h5i0w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:15:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:15:56 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 01/16] qom/object.c: introduce
 OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) macro
Date: Fri, 21 Aug 2026 12:14:13 +0100
Message-ID: <20260821111550.276011-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:806:d3::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 5348494a-fedf-4bf9-5a70-08deff759268
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: dCvbrc88ytDJD1vq4ncJS0klT8wRYJq8jMdCl/R7f0M41NRRt5KkSHPzuLFklZ9rVsVLRq6BsdlZZjCdOPW3podGQXW/hHGZDM3SHGbyTBqEUhzgG3eCnk4bUk4/QK29TQEuESJwnaoaaNp2m4+CiI5m/cmC2D6qNeoM98YSF+YJdOeCka51gI00XFq5OACZL3godLOLmLpBMR2S2j2bAECNBB3q8BHRJtzQ51wBl5VOqCKvIYhK/+SmHKqTUiPOwsWNa8X53eVhSFd72uvHs65Zwb/GJP7n7oVJRnSKhsXWdyxMkIp/PShdq52S0GNL9ESx1tzyr7q5aJPWQWJ4BYM0FAMTsebzJ1dzsGjR/HUAaz91hKFLrM08e6ehM7kmTT14tQ0wB981JEz/+8+vnMMlUzMfTr4278+kyuQGW0XfHk8C4xdrYjz0GXRDFvFYCz0l+l/Nwt6bzVabJXeHvJ3DmBsKGqBHNawb9b+JeAuOdCDgFNBYi0l6XmIQJAI6igGkN2Gs/6lVmnwMgb9Fdtj6z5hDy8aDnUtFxeiLl/O9V7B4td2pnjHqK78KREA57WKytnFZpgkpA2W3hk+rN4uJd88Qic93d64RVyHzZZF5qUdSZBLag/KCFoySV1LMVEtxieEnXiVZmnKSzUgipY6MFqtd6dPj6MML3zEC+lqfpJjM6kJM76OK81fhNm0uJuSbC5ljyV03HTNXHQLy3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHRraDZ5alkwdmVYZUVRQWZXdVZ4ajNkZ2xBS28xd3hKbUNvTjJyNDlSOHJM?=
 =?utf-8?B?VmZwTXVJY0dHTzNZOVVSdmpQaG0rTnIzSUFKZitGRWRLVkxsS24wQ1NENVFp?=
 =?utf-8?B?c0w4QS9NZUtmVnVJWjdkYkp1QzdGS08wRjF4YW0wVThGQ0Jkd3NYemlTMitB?=
 =?utf-8?B?YlNYVW1wTXpLSDdPWUpuNXovaGJWdEtYRHl1VUo4VDQrenJBRWE3eEdabjdv?=
 =?utf-8?B?OXFwWFRiUGQzd1JhcEpYcjNEMVR2dVo3VmlLSFo0WlJhQ25XUXZnNndndk5y?=
 =?utf-8?B?MDBqL04xbzdnZUw2T2IxcXVLV3M5VU1zMHZndWJSUktIaStMTHk5WHF3K3cz?=
 =?utf-8?B?Y3Fxa3p1c2JodHBnU3RtUHZHZmVVVGFRa01FbmNOSEZyWjVjWS92cUdQY0lz?=
 =?utf-8?B?aVpQUkJuaHJ3WlRDOWVPK3hjdU05ZFlWNXo4WDZNVmRYV1k5bHk1UGFoODU0?=
 =?utf-8?B?V0xyWjJYT09wczFzdHo3YXR0YUNwSFlhUy9YaCtTZy9sUnZyU1pQQkJUSW5Y?=
 =?utf-8?B?MmVqMStFaEpISVByTXhTeDdRTDNkMG5Sd0YxbE9PU3UrdDd4NFpMNytha1gr?=
 =?utf-8?B?ZUIzdEhLaTE1VlpGaDVnMlJkZVRUbkgyZ2JRK3hHMWJpcHRURVNPeXBabi90?=
 =?utf-8?B?bUhPQ3RsYTdoRm5pWXFacHdlTGtJQklNaVZpV0dxYjE2ZzYxc0dZQk9rZy9C?=
 =?utf-8?B?OU1DL2JmOXhGdnNrNHJPWkdoR2RZZFZDQlVHdFBTUTk3U1RqcjNXSkE3dFZi?=
 =?utf-8?B?N3hrY1Bsc3lDK2pUdHp0VFlLQnRSTnRwN1VrbHpUUUFBRUp4OWlKWUczdkd5?=
 =?utf-8?B?TERCOWQxMGpDNlRBT2dFWVU4bDJVekpvT3RiS01naHlNNGRacER6OEI5SXR1?=
 =?utf-8?B?Y1VCbVN4elJFbFcwbHNrQmlXWExoNVA2NU1BNmMvTWJ3U2ZMcVU2enFqT1J4?=
 =?utf-8?B?NVc0TVR4amRCZGVDcTFPclg2OG1qc3JVdVc3R3ROc2NWb0dxbkhETTR6ejYy?=
 =?utf-8?B?ZEp5YVFhTE9hRUtlVjJFclJLdXdOa2NlU29qTkdvWStFdjR3NnVycnRuMlk0?=
 =?utf-8?B?Q0hhUlBXWXc5YS9adHhMaCtZdzV4ekhOcG9oVWQ3dXV0YzUxMGtkYkZvWEZB?=
 =?utf-8?B?ZzZjWVFDUVdwQTJ6VnBSSm13b0JxVDBYSE13SE9xZHZ1QkNDQzIzU0s1Tjd4?=
 =?utf-8?B?bzk2TXRrTzcwZUphbmRqQjJMbXMyL1ZialQzbXpMRmF1MW95VGcyTWF0TWRh?=
 =?utf-8?B?OER0MHR5K3I3OThkdnhER2svODRBUWhXY0ZFdjl0U3ZBZDlXSU4yNktXYy91?=
 =?utf-8?B?WFVwSit0b2Nlb1JUYmlNaldGSTZtZnZnQ0RhS2NtSDVLekVseEhVOEw0ZVM5?=
 =?utf-8?B?U09LVmpYYkNJNVo0TmY3aUQxU3NXZ2dRcXZERlBBSUV3Y2dac1p0SUNRSEVr?=
 =?utf-8?B?dUUzREdqQ1NMOGowRXVISHB3RkZmVDFtNVpLT3BQR2NoWGV2TmordHNpb25M?=
 =?utf-8?B?SW9wRGlMRmVBRXRsS0JSSmRxTUhvdjJVcm84TVBlRVNiQmxhanVMcytBT1BO?=
 =?utf-8?B?RXhIaWJZSndFRTNrRk5PcTljYllSTDViY0VlOG50UG44OUF5UVVXa3UvQVJ3?=
 =?utf-8?B?cWhqM1ZqdVZlcjc1MVFrblRleGVvcndsbGNva1kzOWNZUGRNOG9DUnVBUXpY?=
 =?utf-8?B?MzNITW14NzNlY1A2bjFBZGtkRlZkQ2hXQ21zTmJPYzFOWVd0YzJFb0wrNzRn?=
 =?utf-8?B?ajl4R3ZSemxsR25maVVzVzhUdS9WL21MTFhiNjRpYjlaR1lLYUNtbFQ4V2ox?=
 =?utf-8?B?bWUxN1YyTjQ4NEQwWkpXOTNpb2w2ODgzUDZLQUI5TEtHS21XdDUxMGhEVExQ?=
 =?utf-8?B?NmZ5TnJueGhnSFQrdnlyczcvMXhwY0d1RndiZ3ViWTEzbXZ1WTE1YjBpcVBP?=
 =?utf-8?B?cVptbWxmcUFtQityZEdKWm1RQ28vMWZ5RVQyK25CNGUvdUFFTUFrR3RrQ25t?=
 =?utf-8?B?UTdsWkZYdXZZcDBkYXo1T20rQ1h3VjJMVVJoWEZiS2RHMTJnL2p5N09iUG0r?=
 =?utf-8?B?VCtNY1A2Nzkwb2JhRjJrYUxFL1cwS1NZNzg4Sk5EM0JEY2ZSMWNlY3VHT3dD?=
 =?utf-8?B?L2JCNzludTF0TjJ6UlhtUEFZNVI4b1NLSEF3d3RJTGRVdW1ib3J1M0cwcW1s?=
 =?utf-8?B?bVlOWDRhYXI2S0w1amJPZFV2RkFBazJ1NUh4MFFHcENQMmMwMElLc2NjK3oy?=
 =?utf-8?B?d1dsb0svWVovUXJ4SFF4OExYcDJvYmxOSEVrS2pZSitNRHRHRkZyMGU1WkFC?=
 =?utf-8?B?R2pmVkdCcEVMVFFCS2QxQlZwdDlFUnBFSEM1c2ZqQlpSTkJYUGJvb2l0aGJv?=
 =?utf-8?Q?ZKPGiPR85hkbOKkE=3D?=
X-Exchange-RoutingPolicyChecked: g+s+XqaMnphmZQLovNJohJgL0D2D+6LVvZZD89WCa5CqsDdzWRhLr/7lEC5+G9Tw6SdPp8REuVdGvbZnBdEQqzWdSYegvoi6Z8qvdM5GW7vLsaWhN8HIxvT0HEKG/J2MM895qTuq1QfmXWNC87b0E1YlIsio952SUIQbdMSiwWm/Xu3eo2in5qfCm0NtETbnerPz4d4oEflgaTt+Im9DLYWqAr1GeTOcBZJZfWqy8r5/IohBeGc0Bcd/vrLc2bWBartqFFVtYdLZFwk2rwABf5hggD0Fr/xqP9QEugIBjlk6xxnqanRSjCDILJ93mRdp0b+OHO5YUwU0prXodxcEjA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5348494a-fedf-4bf9-5a70-08deff759268
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:15:56.8890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ny2o2YZoDX8VpZN0vLiOVov6wrskr7gjYBiMWJfFf/Gfsz0MNW6KpXYlD3pDRNV5ze7awNosgsR+/8pjb0RHIcXxakjqWbnKEXGX4MJJ0MU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Proofpoint-GUID: p4zR800M-6r7ULm5Rx5bq4UjM_ZFw9EM
X-Authority-Analysis: v=2.4 cv=J/qaKgnS c=1 sm=1 tr=0 ts=6a88336f cx=c_pps
 a=cFfp9J6W/iLkiH+l/RQb5w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=sXIxgEWn3KJhRak5j5kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: p4zR800M-6r7ULm5Rx5bq4UjM_ZFw9EM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX9U+Ah1MmkEim
 Z2zdmv5J9E4OD+rqZnyk9F/zMoggcaCJJuPU+U1NKZLaMlUwhToP1DyFRHbtax+jbczUp9VUEdH
 jqmHojtpH8oy5q4vqbrLZE+TTCx/cYC93xb7AUdW8y5mBcovBOWbGvvEPDv4Ga5TzaIWQJEqMP0
 v8IygeBtgmf7k0pblXcaz0d+HJYTQQhSWsC/9qtW/tjG5aUwXqVKPBH1hSh4BdHccmkFfqAoIbP
 NQhvCCy0qnN0IH+gyKA2TYKzQRN3PnTJdIeYVn1e7kN17jJKSgsInFFwxtE4CFpXVanJUTEniqv
 p3o03bTPsvT9BOdLcY9kA8mfvaBGkd8QCoEOrREy1ZHAP8tqcoVgMEi+OtILAq7LBkjUl5LAJkA
 AX1fwIdVPXyqJJpzizgy5x1sZwz28y122fmkB8hXIWXb5dz0bb2YgogBcklfQgr11v8DSb/iVMv
 3C6e2kWYTZ1Ev6qJ35w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX5J3gzDlWkeVq
 lYQy8oEzQKJqTP6lNXWXmuI0AWQlV1gs5CvQ9sdZEyRtUJDGh/PPEXyygq8G/oKhpxZlPKvAjmy
 AHA5NgoXm+R5+5+sqQ8H6AYJpSKX9og=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

This macro will be used to generate the boilerplate property_class_get_type_ptr()
QOM get function for the specified scalar type.

Note that since the macro is currently unused, the object_class_prop_ptr() helper
function is temporarily marked as __attribute__((unused)) to allow compilation to
succeed.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index 47977b1f44..e32ae30bd5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2703,6 +2703,28 @@ DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint64)
 #undef DEFINE_OBJECT_PROPERTY_SCALAR_METHODS
 
 
+__attribute__((unused))
+static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
+{
+    void *ptr = obj;
+    ptr += offset;
+
+    return ptr;
+}
+
+#define OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) \
+    static void property_class_get_##type##_ptr(Object *obj, Visitor *v, \
+                                                const char *name, \
+                                                void *opaque, Error **errp) \
+    { \
+        type##_t value = *(type##_t *)object_class_prop_ptr(obj, \
+                                                        (ptrdiff_t)opaque); \
+        visit_type_##type(v, name, &value, errp); \
+    }
+
+#undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
+
+
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
-- 
2.43.0


