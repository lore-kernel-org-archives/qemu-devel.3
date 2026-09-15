Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BD9C88E7B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6R6G-0004vd-J5; Tue, 15 Sep 2026 07:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1x6R6E-0004vF-RN; Tue, 15 Sep 2026 07:13:18 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1x6R6B-0007Tp-H3; Tue, 15 Sep 2026 07:13:17 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F9emRW3214795; Tue, 15 Sep 2026 04:13:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=BK1VSY1tR+wa1Er
 YeEexi8XxcKW0ySX92Tj5dc1Xnoc=; b=NBf/lIahJO9EhI+rrHAJJ/XSdveRUKO
 +Ei7eeChwH5TxrXZlPsSTpPMDG7/AijRIv/XawVy+3l4iyqZgf6F4jFOU3xN5seM
 wz1O016ZhRfL6N5cApdXqikxXthF1qq5S2uHsMrI9JWN+YzgICbzVmuqfgnPaLQH
 6lXZtRME7T6+3o5B6Egj02PmdEXmRC7mhL1jIX03lZ5RVKEnqgNdPIwToZWYLKJJ
 yrCzsSyjPGcZ283AZB/+m89TR+MgBxw8ffe/lvp+ntPNvjB9pMLjWuOS2qIddz51
 LFrc2GW5+Q+RNnQL3i5xOGgtRjMbbmpLFIVQQv8idu8TJ8kZd48/BMA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020091.outbound.protection.outlook.com
 [40.93.198.91])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gn68xdrk9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 04:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjeJedgXiXvtQ+t6UFWvznNTOYc9se2tqojBEEGScvErAeFZuuacWGNDx/mP4nURhXt6NL1Ob3SvGdYqwIe3DTZU0djCD0BNufGD5tADwYrFKLsQZXqyCZr+QmGfqb/o38LRc0UBLX1Nod+2ogstQom0Rn6Rg3YSAYw+iQePyoauhQUe2eDKWmINlNCqQKZa+pL83+AsaIgpPRctFcNkaVK93yGAnIbj2+2r/vq0a64Hl4X/sZHKwKZt7Wi5jCePJ7s2+5vTuGZEMW6rOQNxl1sqFO+W72QKeIDKMcMijS7W2j33WGOKgIm1EcfMdmOIxd8wBbr5PuYEt47xrXyUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK1VSY1tR+wa1ErYeEexi8XxcKW0ySX92Tj5dc1Xnoc=;
 b=LOdHmbko0psyl+BFCZXAPYRQ+A5OzCqc70EYp1OPSB3oQxVKTu5RIY2+mESQuzdKc+u9UNYT0Rp1EVeb9/fpwI69yC99Z7yirvGFtGetv+NMUtM9PQqU0M4trZDMdmesCqIfHjWYyu1H1Tc/DVq17ExHSrvuvh0qXAGYeb4vQo0tWKKWyaCm21SQs55MWCE1AuMVzIeAQOk2dKE/gbJ5mof/04FvaV5olu6sxkHeIpdHonlfWiQYioTQ3dc/RNgHvLxDIo0TTvvEZHoR+mhG8nl3GCQrSWSLC1QkkR3CHC+0kIixojo2j8F0dhkHtr7C3KP4gMGBRGEGI1MYfsV/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK1VSY1tR+wa1ErYeEexi8XxcKW0ySX92Tj5dc1Xnoc=;
 b=KDSJKUfCr78omJdiKmCizLVIOlIww0SsxyPN0AhJ+laXr2sFpjw+lc4DzJ7KPWya31FDmAYbYZaeVZyKvo/GlUtbE+c9LgfH0l6ZhMByjNddO+7Tf5U8zujRYM4fAeGSFJ7XXt9qwHgFExH/3TJIhvAaM3YlWfwOFUbjhryu3SSevztuMJma8kwX8w7xaqhvdsrBrrfjl295gt+8j2dOn0//rx6IWm/XgVy/nT77TQWJapI3GxPBRw4qOZd+f1Lnl4xjVREnBhyJdVfjRuOdPdydBgbtHMLtQUhOVBGmHiachjdlfcKnomr+HrXGX6/J+eZbdxeoYMgLU3nAtXZc7w==
Received: from DM5PR0201MB3461.namprd02.prod.outlook.com (2603:10b6:4:7b::27)
 by BY5PR02MB6946.namprd02.prod.outlook.com (2603:10b6:a03:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 11:13:07 +0000
Received: from DM5PR0201MB3461.namprd02.prod.outlook.com
 ([fe80::c7d1:9bf4:80c0:5e1]) by DM5PR0201MB3461.namprd02.prod.outlook.com
 ([fe80::c7d1:9bf4:80c0:5e1%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 11:13:04 +0000
Date: Tue, 15 Sep 2026 12:13:00 +0100
From: John Levon <john.levon@nutanix.com>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: qemu-devel@nongnu.org, thanos.makatos@nutanix.com, clg@redhat.com,
 qemu-stable@nongnu.org
Subject: Re: [PATCH v1] vfio-user: propagate DMA map/unmap request errors
Message-ID: <aqkoPCsMpC148Gk5@lent>
References: <20260910213526.1472467-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910213526.1472467-1-dbgh9129@gmail.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::16) To DM5PR0201MB3461.namprd02.prod.outlook.com
 (2603:10b6:4:7b::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3461:EE_|BY5PR02MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 901ea919-8d4a-4c81-9e1f-08df131a5023
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XNbHgRJIQjggxhFXL1k3qKruZrZoe9zOnodjZ0rvPAbtO3+0clgBt373d3PsUPtyuB+ytIJMvMev1B+kqRBiQIFnWO2FTexgmp2m8R4VBgE2MWWZn901TC0sQmwSt6g6us1J9wXvX0AWtKfAOgOvCc/loQqoNolbjLALecSlPBAhkLp2lmEWQSLInbyAUUFThSEMfLF9AmiL1idXNwA/npfvP1GAmPdNxDCPyziBHBQn7EpV7/RCeKxbahJAnne2jAKnizQDuEmcIrj9XJl2AVFPShEu8I4/CYk1erUsp+C13bcy53C/q1SuR06OvQXJCe/gRGhW6EHWkiddQ4PbdWbqiuxiaeLVU18S8fUB+cn7xgZCRwRDX8Sd2ofkgNE+T5yjJ1PY/H+edClgW0oUXJAQHSahwvAdgGWpwS52OacIrz2qpivgMtPDWBNFTFqqthRwEwMksvf4+xcIKWBA4V98h6vNdLIPNHDn4q4hDUTnNp9N24KAAjX2VIFbpgtYfJNpF+PlAwpfuR7vefb8kD+1+NFrHM3SV+J2PQfWQZ7nQoPwoOnkTZQxCRZ6S3gdYwOahzOruNY0pVpZyj+VYtfaNlZh2vwI24lZWDTe14lvEy2DWoHCLat0tdEfNNJ2Hh6JzcNfMe/YxDR9tjzbJNmTtn3oMXfM7sza07J7Adw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR0201MB3461.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kV6pSDLhztN7pWdtw8AwI84idVucmU1fzuk/discoqDXIAtCVY7ZaY9m3veM?=
 =?us-ascii?Q?YhRV9IzttLtkyjUxYIAHk54VNSCNtRc5Hf2fWAJGpkclvPphbWoRSs4RTTU8?=
 =?us-ascii?Q?34xnsklYr0eupYkiac5m5fFMqg8gPMcS3LHTHbqsiGowyqu5Um/GM8hKOyjA?=
 =?us-ascii?Q?S2b0qvubX2SbgK6IzLpTjvnXqjPT+Tiu7mxCyCtcpWKMRl6A/zYq+8ADKyhe?=
 =?us-ascii?Q?OFTXzrx6SY8ZZYygxrx0d8CIsDDaseEYdaJJVH//+Uk/U/p26vXJwKWCtB8e?=
 =?us-ascii?Q?kMO7YsoLGs/qWUvTPXhqYfWFXnjfKz7uQ5QxIEDLjsOWWuH95R8UmZstW2Au?=
 =?us-ascii?Q?gGIZDj37USG6sx36QI1LmwpiBnIUWEcytbQ+FMfxvTtvDQtv7sDYliJDGnut?=
 =?us-ascii?Q?aHMdmB9xxvmtp3w/AkPVKQuPyooz3tQDlAUAXhOqbvAud30yJxfPDLO1cAP3?=
 =?us-ascii?Q?SOHA3Of94AzFjp3DPZJ3QmpSEntFRdDEWXnmtrdP8SkPNptWzzwikmqQKrL1?=
 =?us-ascii?Q?gLaoM96UJuQC9FXsN/YoG8gTTu0a1zJwJD+3NJigEvz4kSftzFkNKie/ywOd?=
 =?us-ascii?Q?QFiUrTfvGwQgtk0t2rcUGIcIhGyJ9SWKc1UtM894P/sF9MpAETRVr+y93fRI?=
 =?us-ascii?Q?y8qjTPq6QoL5gRQMx344eszzZ5ZvTPEf66/BMh1jefmopRKdTZtGKHRmtKJD?=
 =?us-ascii?Q?dJvOj2t9La+CoIpk0YntVqT0yDjTo4539zTpRx8cQIexNLFrVvgWFxziMAX9?=
 =?us-ascii?Q?XNwCM8jC5ttn3L1SLnMyZqwnZ3kBfWDxDQx9hQihH7NE7S/68KMLZ/usfyLP?=
 =?us-ascii?Q?elqxfWSbLPw7SoRrSoS+sCXP+zBCBHKXMBp9lrbzzaQSBj0F6Nj7mPXiajhZ?=
 =?us-ascii?Q?MM69GESEhnoxCb7nYyMsI31Dvqi/sfaOfIGDWiCW9Nkp4Aub20qEn1vbtLyQ?=
 =?us-ascii?Q?8ptkOIT+gfV+YlIjpj8HmQwBcail6NgcI4sJEjA+in3xRb1Qqnp58psBwDsv?=
 =?us-ascii?Q?C48ENMhI61a8CByCQI9V7BK9maGZGQ+AForGA3btw3u2K6vMgDHaeUS3Dtn5?=
 =?us-ascii?Q?gs5ifWzo1F6iVeLSjnfm5izBUmmTsav7H1QBlcCYgCE/wwAgpBdhLKwu40oj?=
 =?us-ascii?Q?Ge9/+2YSFoXZMkEqGBQfgl3rBcKm2IK5qO60kzIIyxt339H5cbB04IsUH0q+?=
 =?us-ascii?Q?5b1+BCpQMeyTzWzCbTHVzk6zg+BAteTAN0p5kSs8ASjduUg6Rb8y4vSZ3zaa?=
 =?us-ascii?Q?rVd3apHrD7f+ODGkAlWguYLQCapXsOGJ1f5cIw08pjAOfAZQit/FZRZ+yROd?=
 =?us-ascii?Q?vp+gbtT1QLt9STpZ9dKXCgCV25gBba6HY4F3EzUZ9mGNgwA53JG+D7mNBYDM?=
 =?us-ascii?Q?D+az34oUuc4Ls7g2PuT+ndK+8XanNHcLWXc/uW6yq5+3AClYjuxisaOVCbU1?=
 =?us-ascii?Q?HBQRXvG0c36q3IftuQsfswHA5vFMgHiw2C6Oztc5vsHJIcNxhebbRx+Fd+fa?=
 =?us-ascii?Q?oEwmpvNrbbh6w9Y+eKDAjEGxmN/9jGXnyVjKcSw309XaxqLTMDhP3upLLHi5?=
 =?us-ascii?Q?xbqOFC6rsku2V2JERE6tQQyJWwhPrBUqUqmGCoH8skD4naaDSjr5BXa6yQST?=
 =?us-ascii?Q?5oiRXgOYEHiu7PvxPSHXBOPmjtMScnhZL1+apEXin5NXUILQu4BgdI0wAxPB?=
 =?us-ascii?Q?i1wu9DUoFYS/RLSW5Nk6Hd3MEhR8ZIKkrGNp8y8X6xS6R5f4KNJ4QVLNjmlY?=
 =?us-ascii?Q?Yk8qCyj4Dg=3D=3D?=
X-Exchange-RoutingPolicyChecked: xhWtE7EFXNY5acnZRd4LCT+LGvJhZ6xmUNyDlIlNAKX9Vaf3RDWXPDHio+7JA2hp//8FhAVK1j4+iXw7dQ87JDYH6JtZk/JVywhBER37aZyFE8AGESp7M778QFuCTp+lvNr6sAIenemdV0Idu0Gn4Q6enw+rjyrJBemvr/aVn1YsqyvU8OD1v7iPzaVE3tYsCqGZ5ucSrjc5DtImQSTyqs2kCF0P8/qU7FFp2tE3AL7LpJ6ypiUD6FiPGtEPya35XvtB6Bj5PSy8FyE030sIYlyvXOWPHdS9BampEJPiqutX0taE3q7GLv4g/JNgzZCBEFqhn/O5UzvAYysOrl7HKg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901ea919-8d4a-4c81-9e1f-08df131a5023
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0201MB3461.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 11:13:04.7942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bm6p7rZLNnBuvzFDSsaHgMNZZFTZynQPGJHwKJnsFd4L4owB2tWZIUtvw8UTpOhk1SRXjMj9VfWpiwbofMP24w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6946
X-Authority-Analysis: v=2.4 cv=aL1lOr9m c=1 sm=1 tr=0 ts=6aa92847 cx=c_pps
 a=LgTXwy+OxRus0W5fFstXuQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=D7VQoZj_oTZHhC93o4AA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE2MSBTYWx0ZWRfX3sLSix04Sn/G
 IXenb99EFnhzdMLFfxB58Z8XO8IVFqHeA83UYcan6wm65yJc1XxaY4jUKgIj/n6cQBoKgP8zyCI
 QH1ZtByer2DGu2+Av4dcfIcL6gIeBV22DHc2+HLMw0LyXFImbHfOMlci3d+fgEifAlXmBrY0igi
 SfRh2IuiyAaXi/ZYZXlNzfrlWeLErwbarKWANeGeD+aIfUwnYAowZFXdCocca4dLxLQw8f8RXZX
 pYf5JIqSgrY9I6x5rBzBbTCUP+pTNGNbdgzF1O7p7FZXrgxk5edLls24SYITvcOJBCUKH6rl4+k
 gM1nitXHRoiYHeo0My8DWn7YGciM+g2O65yLhBzM3cveyXATDPk31+Vz+e5exwlIrQ1JRVXZfGD
 KXvmPKbCiE0dSEngaLuFrrScLba+kNGQ5SeuaWcdJ1X/sCd34ah5UB+HUgbRuzysyMrX0/rK3ce
 bhXV0QfqOMDZqyfBrXQ==
X-Proofpoint-ORIG-GUID: LTlR49A_2PKB4AVbsZSqYfm5GgXEVcXo
X-Proofpoint-GUID: LTlR49A_2PKB4AVbsZSqYfm5GgXEVcXo
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE2MSBTYWx0ZWRfXxxzZdmDHVvMH
 YADIH/q8sEbeS+X0jbsaiZa/EwAeymN9Bqp4IJOjbU8JVF+puH2UDUrdd8XUhVirJO7hfJ0Js1c
 lJSFiUgvvhz6jaPzBsL0ra9kck358Q4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On Thu, Sep 10, 2026 at 05:35:26PM -0400, Yuho Choi wrote:

> +    error_prepend(&local_err, "vfio-user DMA mapping transaction failed: ");
> +    if (!bcontainer->initialized) {
> +        if (!bcontainer->error) {
> +            error_propagate(&bcontainer->error, local_err);
> +        } else {
> +            error_free(local_err);
> +        }
> +    } else {
> +        error_report_err(local_err);
> +        hw_error("vfio-user: DMA mapping failed, unable to continue");

Are we sure we want qemu to abort() rather than just exit in the case the
vfio-user server returns an error?

> @@ -426,7 +450,15 @@ err:
>               */
>              vfio_user_set_error(msg->hdr, EINVAL);
>              msg->complete = true;
> -            qemu_cond_signal(&msg->cv);
> +            if (msg->type == VFIO_MSG_NOWAIT) {
> +                vfio_user_record_nowait_reply_error(proxy, msg);
> +                if (proxy->last_nowait == msg) {
> +                    proxy->last_nowait = NULL;
> +                }

I'm not quite getting this change, why are you resetting last_nowait here? And
why as part of this change?

I think at least it's worth a comment.

thanks
john

