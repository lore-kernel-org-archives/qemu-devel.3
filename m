Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA9BCD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 13:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNA4x-0004qO-TV; Wed, 13 May 2026 09:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wNA4w-0004qG-Dr
 for qemu-devel@nongnu.org; Wed, 13 May 2026 09:56:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wNA4s-00078X-QU
 for qemu-devel@nongnu.org; Wed, 13 May 2026 09:56:50 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DAqBnr2908555; Wed, 13 May 2026 06:56:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=sEedsTun3BDzw
 FXFiVUbzvHTP32t6K5U+DuCwGVQCjY=; b=O+DZhTjBLKnZ2R33YbADjml5rMtST
 InCiiICiGGmWjvT/r7RstHTV3gL5O2ch/oXF+pbLpTSMMC5YKUqoCHGl8e7Vyyfu
 gSy0PAfSah5eZmnid8DJD6bxLAKNIWQuFSicbBNSALHDU2BMwF4EhbDzaP5zL7qc
 nxGlib7kemmsjK9uoa23389O5oPaEq36NLiJM4Mqsvho9ftn/Xv6HHDNLYT9DvNz
 E+Fqf0uHE0elMxHBBmA9sr26UUCg1Y3jL9rxm0i152HiGrYNFCCZmIrITJd4fUSt
 kp4tH78gHTSTzqp/xEp7FpCoebhrQjWxWPXHXsrcoM6YHkvumUtGtDTpw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023088.outbound.protection.outlook.com
 [40.93.196.88])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4e3nvc5s4j-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 13 May 2026 06:56:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfypPgwqGiCo3TM3r9x329OuRsN21VKX1SO/w3A6oEsBdZ2ca798AwZOOxnOFfZv8D70BNm9L/SAzpqM1yrdjcF4lnYRoTa1mfMB+tBhRpNadN7KDm2k6LUEEzeAFYoZjYzU3/fHR+NVq566wFUMNkUwP9jh+uPQJInq72N5781El3UuRGxba8/Jhor2c+NNjqLC3bLdUV2FujMa0eMoXYPAyoKvfZ9n5dfM/OURIdVJMwH6hsux9CxLQg/7BIsA0g9xpMRcIeG/gIlJ0c7u8Qg3qJAAYY/sYWSZTu5NmaHvyWIbQzyENpKhPk2g/BmXwznpVg+ZalHTx1LK8Y9epQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEedsTun3BDzwFXFiVUbzvHTP32t6K5U+DuCwGVQCjY=;
 b=W3su34pVm0Chjw6EZrBLm51iLZ4DaTgASmFec1SGzL7B+Ebi9s/tYvIweyp6fbOc0gatAzZRK32jG8z27pzWqwhj3d/1V92l0m+aUN628jHEDnYJfIYpqQzCBit5qvR2TBoeImOuAfaRZfS8VSb2gL5zWM8kcMfYHjTLUAMMGp3Mv5MkYITomDOe3+7s9iY0yU8xHzx7S1YBQ/v3T/0ttly4+tugI5ds3a/KcyGm93lVCwCjxY2Sx+iCSghIvQayutxeY0SWMLJBNZPGEiA/ZByV+puiZX/KNXc0sBI/Uy0L52oL31/XGDKTNyeTNzMzSmO72Dq70H0RqyY3dbXbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEedsTun3BDzwFXFiVUbzvHTP32t6K5U+DuCwGVQCjY=;
 b=ApE9Zi2uIk7m58objwayMMdgREArCn+onN5rFIbWt5rLQB7DzgT+LrWdxtwnfkM4xO3Za7LMqyiC0U0SBK4ODkb9CLdCfFAOuqjL+iAOBwKXr9UExAikcNq2WtEHUTFGjbn4cZ2/wAxneCGa6Yew4CCUBEnpxgdynb1ppES7Xq0flA2OrBzKRUakZzMqPq9+azjbFLabHmAmqAa4bCTZr528b628NR5Td6f+tien+HuXRAakdScPLtq5jd5zGogwF/p2fVyRLqipKTKyKYA5CzFbUt1Qv7dLqeSmmW+tkkFysn/6C/X43UVMnbBGnGbqK79R9hdxLQcBrcfV9LNGjg==
Received: from CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25)
 by CH3PR02MB9562.namprd02.prod.outlook.com (2603:10b6:610:129::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Wed, 13 May
 2026 13:56:40 +0000
Received: from CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab]) by CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab%4]) with mapi id 15.21.0025.012; Wed, 13 May 2026
 13:56:40 +0000
From: Florian Schmidt <flosch@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, Florian Schmidt <flosch@nutanix.com>
Subject: [RFC PATCH v2 0/2] Support for Hyper-V's
 HvExtCallGetBootZeroedMemory()
Date: Wed, 13 May 2026 13:56:14 +0000
Message-ID: <20260513135616.3519354-1-flosch@nutanix.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::23) To CH2PR02MB6197.namprd02.prod.outlook.com
 (2603:10b6:610:4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:EE_|CH3PR02MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 4add7f81-9357-48d2-0f40-08deb0f774d2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: tDcCc9LKKGWl6xOXjMdihBzZIO6p889WiMn47h3itZ3qWjHSHL7HCap/pbu/7OuZ0gpPNZC3nWqjNNNA+zBPg7+5oxuZHHd6XfNsHYDEIQ7ENcpagz5XbvsHxFdwJp5xsKtvTr4zUDS+ZnZqVjpdyGIPFXHdXiZDHU6T1skq4XnX/sQYB1dFJHj7N201UmS5INOFCxLAFMlPPMV2lD4v4+9vDwtMiEBwz0OWnAs7H6wnTTqb4dQCTNdlv+ufHWmsfeGnVHpEHl2I6XGJmfm0t8rbI1CsS+ptYPJGjGzRrLPwmumzZfNnJUh5H4HrIrFmMglTHfnFzvNxbH0bWZWuhzBnL6mAajAF71SOLt0RAJuqylw2naqkzkk8xyJxUuEeptYES4HotgEIQZ0aGjiCZD0K/k1JqXWzI+HqWO/3Q37UgC4keMc/mYhlXKMetAmAUYPC1xNvK9UjMJX4T7Mi6llKbfET+STBXgFJxq2RgpCnTFHM8qnBnx0nNqV5DRIMbh/1wocC29DOAS/G2QOF/hktMvyy204c00JIGMH/AhQW9U7OKbEywVwyBPUk2BrDMk8dSFwpKeaTpf3BE6Xoq5vpgyvIvtELNdqdAVU+ey3zL8oU2reAHlyvytRg6vOZ89ZpWSQ0t9W2d4jU7lqOWf0SNBOCgBDw+YMb7ZgwwbXTsY14UIQmryH7WWsE14naGRXLp6dvDWDP9WEgwTIJPubsg8h7s5esx0y454Dbnf5X7keLoaeJ70I5sMrjs8kW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6197.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5X7cM29zdqNfp8QZCioCEGLsLcS2nxf9MgrD4l+lmtXmtskWoIBfSu4nHZ6Z?=
 =?us-ascii?Q?SDnW3tDELLx8ZpCS2T5aP28CEh1tHIF6GTv9ZJk1P+BTtoj/dFEVhy7Ning9?=
 =?us-ascii?Q?WPkM2V/BaPr7AFUbMXOX0O5taXSeF6OX4Uva+b6846XXVwMEFxvtVZS30YZW?=
 =?us-ascii?Q?LwYUOtzvu7p+j26wdvWI+uWKXFUasJwCa+2/Ul20FFNn9RsMbYxtpdTlhocu?=
 =?us-ascii?Q?wCkniLe/h+ZcH3sT0QZZ6J8jQDTQlrgZ7GqthKQxroItWwhhejwl1RDRp1Z0?=
 =?us-ascii?Q?6n7O16Gg4vwbGCg0Bd+oQwlUdnIvxqhHsbAqc16+llmoQgaq/ov/dtfsFnkM?=
 =?us-ascii?Q?9PAv0+F4z1gD7WfHuRCE4bUllBQZNzft19PRE3BnAGvh4y8CeV+0d1M3FUfe?=
 =?us-ascii?Q?cjd0v6AOIdn+0GEwca8TEruBYeIR71ErPEGHLr84UaRiu0UhLhrzB5IsTjv0?=
 =?us-ascii?Q?OYABl3U6J0yg1UmtggB52cb9FElb9y8VDlU8npYKWzmow9lWf+BvdyOIdJHD?=
 =?us-ascii?Q?DYSKnXQfYYoEhlyS3zUmDZLLdaRbGD4/HFuUO2lYYwu25zW/3PjI21gAraFb?=
 =?us-ascii?Q?G7H7BFsaEYT4vcWM3J91uuk7FJTM/8TIPOiyLjquRqCji4rbcf0ZzftxIVRN?=
 =?us-ascii?Q?C/tGzxsMrg+kREmC7EpcihDcLWprCIeELLvzt+X7MJw4BvOjyjRkywEDA0CQ?=
 =?us-ascii?Q?7m4G7WNMME/mgQ8lSfDsQ0atulAi/+Z3GqEhma7fgqcVEdda5/YS8g806B5S?=
 =?us-ascii?Q?1VJCTmXZWJs8wJhK/98cZ+oLcmcOTsgQnHZ6lA3TI/ZfLDBOB69cGmdyIltm?=
 =?us-ascii?Q?QO97Bhhn6YQZD7WxFlrKIExfy5MgeIOaYYDx18QBebgbDalsLDVWJaTlOgeK?=
 =?us-ascii?Q?9KDi4q+Posw3qMc6UpbIm2XeJVyVUHGUKiO6ywav7PrqeILL6TUXJyy361X9?=
 =?us-ascii?Q?GS5wmquVldcRe37AUN6j9kRczieyVGk0SmeQeYMYcPwfMZ1my5qdztW7FD60?=
 =?us-ascii?Q?esrqL1/nSsuLn3NGzj41mW/ekFDZFxKAISVRT+xqGBhji8os6yy+d6pXwoEO?=
 =?us-ascii?Q?ORAHAseRsxqhPZFjoN/TtfoHivS6/FuM92y3sGzgc7ov8rwIJt6TcLimw4sy?=
 =?us-ascii?Q?CypPOxgignZHrm7dPOHgjbQbNQcdgq4JH+jVo0CXOYXH3UqUTkU6ASvq3Pv8?=
 =?us-ascii?Q?1wIgUAaiYxtJJisgnepaMOjStQNA/K7YP5gdQPUBj4zaxfPzqSgVsO7XmyJN?=
 =?us-ascii?Q?mkSrX/3uBmKkoRRdxXQ34t1i+r0OFW6Ydusqs4yiaKMbypvfWGSxEhV0/vdA?=
 =?us-ascii?Q?v7It+o6s/un00HpvnkVRxhGH52xE7TQL2tCzj8EcxAZtw7pDZ1TqeHQcnpq1?=
 =?us-ascii?Q?pUt+QvM9uo4Sr8oUbyHNFUIaABFJ5rpDKTM2z5id4/3o/Zs52kyz++E0wfBE?=
 =?us-ascii?Q?iI+o998efSphcQm8TvLvMVFeIWUzlb4sClLVydfUx5Uwos7M7dhZ/+7XkOz1?=
 =?us-ascii?Q?IJxWh2knMLsPl7lYkkzd0RXpR2LFY0iyILrw/o0H9o1qsotVCAKsf8mBr9Tv?=
 =?us-ascii?Q?rTPULlBpV/K/Lr8fqYkcGVso9nRvlLWrZ9iyfnO0dyNRpXA4dLGlfhDhEf0y?=
 =?us-ascii?Q?Yw9gzJz4wACpExt/MxoYmRjYOAR7riyGdZnjZmJvy9s/dxfEWVVd/vSLEUSu?=
 =?us-ascii?Q?5f2Eg0WwrckgnTczTh8a5OURiKDMEWv8zhzX6vftuIcgjPAnMzmggtUcdVh5?=
 =?us-ascii?Q?7xRRrGsgszrXboUqOptBeB6Jp730cGE=3D?=
X-Exchange-RoutingPolicyChecked: TrXGMbbbOvZdcPAHCw6YSxoqladw3QRL7T4kRP/izh6cVY3JmH7aF5InrSTK8tIzUMd1u/cwPFsZeEqnX2vRh4+cr/NqT3f9H27cA6JJbitpaqDRIK4v/QmeabJmgKrGioveArXrZDlYK4FOWog+nmSKoEjCDEA+vIJKf8KXWnxnQAcP4ueNFnxpI8gR/i72jcouji0W9S99voWu15ZFj/VyQhVBn1910CUuQSoXza5X+yJoXy4DDCFDoWHwl1d4e+2dOybNWVLBYNotpunSEcXpZ7hIDkNs/0dpg6f8TfP9fVKcLBCrrgPKAz9XT47ozXEiyoS8NVPkFiZf71ozlA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4add7f81-9357-48d2-0f40-08deb0f774d2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6197.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:56:39.9376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNK3X/4bbO8RWivmUMAemIdNABB7M/S0VI4GH9ckvW0hqMjJPYxw/fLiGeK7hNbfh3pVkYQEVNxNwzEQBye2/pvJsBMN1hEm1wsEvglgi8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9562
X-Proofpoint-ORIG-GUID: QoJ7ZnYPX9-Flu7MWYcVCcT5j2jOkm5H
X-Authority-Analysis: v=2.4 cv=StWgLvO0 c=1 sm=1 tr=0 ts=6a048319 cx=c_pps
 a=baSawIpcEEtupL8iW46Hvg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=5JQ1SG4Muqd3FDtyLx0A:9
X-Proofpoint-GUID: QoJ7ZnYPX9-Flu7MWYcVCcT5j2jOkm5H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0MyBTYWx0ZWRfX3v9AdH7WsFyl
 QriDPOVBvriQzKYwqve6GDEAgpDtr/9Ix/+vHqup7MaAHz9gHiCKHKUqitcTt5j4yFULSm1p9Vk
 SgL0KhP2qqY1wXBJe8i0X4YNYGmhPqOYa0Hbth4CcBGe8i8QB4M6UfIiUiKuRgKYUIVlkxhyjso
 ApkuTs8Gly3hA2y2EGirMraSBnReyodCMPWvP0Tu5aaytSrFLg4PGjvSnaa6CUCTVYU4JVMeU6y
 oFdrgDrr2vGs1Gf6xjMeS3JDANzDhVue4+T+FLVim3vQ1SRsi+QPdg0hrg89wakDRCk1F8kxqgp
 hCnV4bNAPY9KFhByrcZLSaGtXA3mprJr5pfavKfNs4qA30tN8zuzo6xhAxyDRHR+VRbfYmToTsC
 HyGGf96TkucAuDDTKWiw/JnDX+m88aI27AivuiSY12w3LrWBU0IysJ3nQT4Mxvc8Rb62qsxAprm
 wOoCOZbUk7BxiwAz/og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=flosch@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

This patch series implements two new Hyper-V hypercalls. The primary goal is
to support "zeroed memory" enlightenments via HvExtCallGetBootZeroedMemory().
To do so, we also need to implement HvExtCallQueryCapabilities(). While
HvExtCallQueryCapabilities() uses another bit in EBX on CPUID leaf
0x40000003, it then allows the guest to query for further "extended"
hypercalls via the return value of that call.

HvExtCallGetBootZeroedMemory() allows a Windows guest to enquire which areas
of memory that were provided by the hypervisor are already zeroed out,
meaning that there's no need for the guest to do so again. This has obvious
performance benefits.

To get a rough idea of the performance benefit, looking at a 4-core, 64GB
Windows 11 guest, we can see that an otherwise idle guest takes a bit less
than 90 seconds to finish zeroing and settle down from the time the qemu
process is started. If we look at CPU usage for each vCPU task 90 seconds
after starting, we get:
1559 498
1294 343
1451 314
4015 2729
Conversely, after enabling HvExtCallGetBootZeroedMemory(), CPU usage is
reduced:
1583 458
1441 361
1279 312
1337 264
These are taken from the respective /proc/<pid>/task/<tid>/stat entries,
denoting user and system time per "CPU X/KVM" task, in ticks.
We can clearly see which to which vCPU fell the tasks of zeroing.

It also has the benefit of not touching all pages at boot. This can be useful
if, for example, the VM is started with a balloon target already set to
overcommit memory on the host. In this case, we don't risk memory usage spikes
on the host if the VM touches all memory before the balloon can catch up.

Note that as discussed, a full solution should not only take into account
memory that QEMU touched, but also memory that the guest itself touched. This
will require a new KVM ioctl. This patch series currently does not implement
that part, but it should be relatively straightforward to add that to the
get_boot_zeroed_memory hypercall handler once it exists.

RFC v2
- added hv-ext-query-caps option, tracking hv-boot-zeroed-mem (and
  future extended hypercall options) via kvm_hyperv_properties[]
- added tracking for guest pages touched by QEMU

Florian Schmidt (2):
  Add HvExtCallQueryCapabilities
  Add HvExtCallGetBootZeroedMemory

 docs/system/i386/hyperv.rst      |  14 +++
 hw/hyperv/hyperv.c               | 149 +++++++++++++++++++++++++++++++
 include/hw/hyperv/hyperv-proto.h |  12 +++
 include/hw/hyperv/hyperv.h       |  12 +++
 include/system/physmem.h         |   8 ++
 system/memory.c                  |   7 +-
 system/physmem.c                 |  52 +++++++++++
 target/i386/cpu.c                |   4 +
 target/i386/cpu.h                |   2 +
 target/i386/kvm/hyperv-proto.h   |   6 ++
 target/i386/kvm/hyperv.c         |  14 +++
 target/i386/kvm/kvm.c            |  29 ++++++
 target/i386/kvm/kvm_i386.h       |   2 +
 13 files changed, 309 insertions(+), 2 deletions(-)

-- 
2.47.3


