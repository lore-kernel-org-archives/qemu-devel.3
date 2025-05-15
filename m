Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21436C54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFam3-0006hP-1u; Thu, 15 May 2025 11:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFalI-00062g-Tl
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uFal6-0006BT-Vk
 for qemu-devel@nongnu.org; Thu, 15 May 2025 11:44:43 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F9OJCJ000592;
 Thu, 15 May 2025 08:44:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ShLLJRom4lu9AovEB3oC6SSI+1VSXPqrxiewohtV3
 ag=; b=F4HJQeSZcokGQNeFzeFCzE7sahGIQOdbxXCyIx33PY/7leKpd9pAHnpGp
 hsCruAXurF8wZfDxSB99eCdaNZZbk0O4ObuXhqt2CpNUF3yJ1dYlYfpUJF4kR8Ss
 FwLF7OqfMoscS5rvO4vRkbW/HDbWzLBe4ShzlNDYsM2wHWEsMOGmriAu1a7ilro8
 87DosuQZd/AZGHgKV3h6U0JziSF6cWU36YhIPOCEIxAzBFMZSmFx6eQqhF9su6Pe
 vpIjGK/qgVBwa3SpH72OatXEVfrvJUVs5PkTUPTTVOwP1ZTyWIWgPVBRqPjCmlEs
 9gOLWtKopZmeK60cNBz1bUQORe45Q==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17010002.outbound.protection.outlook.com [40.93.11.2])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46mbcsdhs5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 08:44:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uC9B9C6RWOqb9G1aUQWriF5BGCnUqwTcjU0EvRqSQzWgzd/BYnTlGyKzmiPTaO+KymkStQgW+tUkTtoazUWdVPVpE30D1UkpWxhhsxwRc8DuKdkuzfbb4O/Ofy8ANelrfztodxdzPQutMB+yikf5yV4JulTuCEpXVpmi1Ps1+HEZ+V7ZoqHP/8wU0o+k8+ydOjzkPluVCIxy5C7AaircjsrRc/k9nmV36TDa+4NXVCsjFtxGhTlTGXO0pda/ArhibooWNdhbV5Uj6/dOXK/5J9N59mlOGv7b8q3OvuoiI40ctVROyK50RntPNvglfpcq0KSMj9tBSgLpDo9n3ODL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShLLJRom4lu9AovEB3oC6SSI+1VSXPqrxiewohtV3ag=;
 b=ZI4icDX8aWFkcVAoSDxNBvazlX/Q5iamTuxLe2ptn6QlvE5XPIiwfOJHf+Bm0mKXy8b7kapyhfyvwxx1A+LEThb6Rurk/IE3mCqOEPsANi/qhMHVX7zfbqaf/ymWcFpIpiA6pylIaxODwM5VftxI0dhSBnM9QglOynh8wgAP3mstwM2N5yfvGZQ/fvc95c1jOSuOyj//ABxQGWG17tQniKffTbfciOujcl+65S9rnEv0+X7hnHLmm2SoPs6qOMche7CzV/mVAs0Vlv64mf2XkfALGGY0eTxarIHMEsjTWGN4CP/UHMqxEiYIspumNaRYEynC+mHAwMKTKlmPmatTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShLLJRom4lu9AovEB3oC6SSI+1VSXPqrxiewohtV3ag=;
 b=hIEdMmvfErqzXl/PHMBq353h2f0Rmxxx6vumjLm924nZKw5Hgcdk+qanyHaN5wXNKr4H07lrOf6og+vg0g2v1cTaJhMP+8X0COHqI8eIJVRXiI3qWkfmq8Q8AXVv87MFPmI4bbQT0uSdeGtZnC3nFgVymzFQXv6SiG0VvG1inZnYqXV6/APU3caqEe/bfbi/DnQ+oAJbwt5f4hfTBcsN4DNMI708mpPDwuqMSuUrBGjAobWHkKXRImNYnRsub+vjVweGPxTIpk451RmA7yezjXJsmlSWXNij7bXLSYRVwgIGL6X6gJ1yoqoM3mYGukgpQjkB/Q4MQHV4xk92pRLPRw==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8470.namprd02.prod.outlook.com (2603:10b6:510:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.17; Thu, 15 May
 2025 15:44:22 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8722.024; Thu, 15 May 2025
 15:44:22 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH 01/27] vfio: return mr from vfio_get_xlat_addr
Date: Thu, 15 May 2025 16:43:46 +0100
Message-ID: <20250515154413.210315-2-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515154413.210315-1-john.levon@nutanix.com>
References: <20250515154413.210315-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8470:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f3916b-ccf3-4164-d8c6-08dd93c75cbe
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nithqPKWbFp+ZXrNw2EloaKpQVSV/czQLziV4Ac1ZDCluXxiWbkj45e7YEe+?=
 =?us-ascii?Q?VNpVdGacDk4lPjWNW7MiYKCxVFeyrULZgVXrBmOlQUx4gp18PUeKF1OgPBHk?=
 =?us-ascii?Q?n2vaQYylHiSnyoCi0FrYduNbXdCINn6rmLIOcF8LWqLf43xU65QAItgZCi/L?=
 =?us-ascii?Q?flulKClGpFREit+bD+9Ry3NWqPJkTl+tzdcBrzeY6VdxPDhco7NtmOVss8Xm?=
 =?us-ascii?Q?8upKnaXt74OKiJyDcrH758CrZ3pGoC2cqJz4ml5hmfbh38eOt391FV6syi+s?=
 =?us-ascii?Q?axMNbI8Ohi98H7qdKbpqUlXTcq+U+TkyhWM+Fi9OlFnVU9R9Eu0UogSeY4hF?=
 =?us-ascii?Q?zInTOK3pvsw4dLB+Z25jcPQp5uh/TgcmO95qPrH1WGTVHZ44KT4Dca0TQQs1?=
 =?us-ascii?Q?SeDTY6mdqFgzP/OymS4RHyiNbGFhFxxja1v+LbHu3AY6DRhM/cU7PVLrG7gE?=
 =?us-ascii?Q?3/xbLkXPRQl3iK2XglU/etIM7dERPp4MclsbTJoKjeOI4TMEJgwh02MTLWF0?=
 =?us-ascii?Q?sWdXiSh4Iq+P0gzUEVWwk0XA7D7ybAfK73mQQED/hauiDuPjjAQJxePX/i6B?=
 =?us-ascii?Q?Xyt6VFj904GJGUweYz6EEKgtcAUnA37OOJ6JFGcrRsUoXA/LwDFlHl+Qd6WX?=
 =?us-ascii?Q?WWhePp3uk8PiK8EsPXWpm3a3fVnucElZtGSm96tynd/mmpTmbJbIKQb4XWdo?=
 =?us-ascii?Q?FkRt6jOSs2TjrKN1NTH6CLPJI/Igip8j0clwMzAFPmQIDqsd7kXey6WhGLR8?=
 =?us-ascii?Q?EonxtGwqioJ/6ZGTG/ub+coMG8UC3tWeIvoTxwVNgiArECYqsIuIRhsABsq7?=
 =?us-ascii?Q?E9Jij+kp9smNjdP9vE/jAToVF+pIHhqVL0FnhLVNTkvvh7t4AxD/mx4XaZkT?=
 =?us-ascii?Q?CfTJiwZL5cvqMI10dui1iXQgFGSAUANeIDUo0R2RDYCaKgXeg7GhYsIVqsOQ?=
 =?us-ascii?Q?pSdhx2N/wuHpId+KrjwV7MHQvgpuRBNggMU0jbcq2M8KBZx6mkIc1f/E4yHE?=
 =?us-ascii?Q?OIluyM9DtRWVFKv/zVDvEC0l5eMAGI0sCbLf5zHWv1Uy+CJ6+qncgAKomGSn?=
 =?us-ascii?Q?xP+22w1nWHf0b+V0G2vP8QmREpsv7kocCe0DuT7LtXIdMFoXtmWmaqVmfo6F?=
 =?us-ascii?Q?uQ7XaWmauj/rVP0lg2x+1aSZJZJ2UcmklI2550gyhWAQ+UvY52soU1IO04Xk?=
 =?us-ascii?Q?uKwDMTedebQ7YVr/7ZsIqs8AWYxnoEOzxj9WK3K5najttWoamCzJIA+EiuMA?=
 =?us-ascii?Q?S02ecfd5E0nyPfPZ+QZq1FYeS8/3TAM79Q1ieW/JUlw3RQUKf499rjUf5C2K?=
 =?us-ascii?Q?Wbyw99j5bqeEjgaardX8rqxC+s+dBLa5kGc3ouRZ2DBj5gTwykiwC+I9zILI?=
 =?us-ascii?Q?8VQ8LzdDQ6IuMVMUD38xHknd9pqV2JOnS9fnH/JYisETyFp4HHL9qRTZQpxQ?=
 =?us-ascii?Q?L+tMXO5Dj6U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TdmVBO/seHJPg+L1JesB62n8laDaUo/AmA0/EsW94xEySkif3GrtiXaUXGd4?=
 =?us-ascii?Q?EDwL63ZEAUnshE4QHQD3BqJigk78EUIDknOolE3ePOzPHdlA/G9ul8AemBaA?=
 =?us-ascii?Q?eBjOThbJWO8gbTF5sIydRlriaYLL+ZEuYLNxPNCbP1WP0d30iyKjPshsSzaw?=
 =?us-ascii?Q?43cE6SocCi1Fnhx6nWCwCxneSfFPNS+pqj96CVK7UvEl7CS7aLUiqOB8tun7?=
 =?us-ascii?Q?/67xBZDONTjgvYB3ZDnsafgCaME7mwlbdlvPOC6PNWTsI5pht/JNL1jpEz/a?=
 =?us-ascii?Q?L5q8dF8u8AcM+WWcXn+ZSMVf92D4HeqYTjgnUf102BfxogSuAYVYZK+7cxVG?=
 =?us-ascii?Q?bJ881Ku9UMoYvLVfq/sp4PSmrfOFsMn17/28Fk08zVANNk9D/4huIcqROWRh?=
 =?us-ascii?Q?PBX9yDWd7fCK66o4Ios17vZJ7axYtA7w0jiQeJ/PpQk0/4Y9fAyYLXMdrG8x?=
 =?us-ascii?Q?qvWxNJjQMoIPvDoLUtZsCaJkkS06FXBh9Ct9PIM6HaRBvd9NxKWTzqesnrb6?=
 =?us-ascii?Q?ez6PfOK9T1NnP8afxSAuup4dfy8EYKdFHVuI4ZrplYZ2pA15A541eJHu35xO?=
 =?us-ascii?Q?BQ0z9lslhd/OYhDl6vWqI57XgkPD1DQvT7PpYuJ5yQcflNmLRo1PrbQmS2m1?=
 =?us-ascii?Q?/Dzrr+XQRbsLUpN1cSClF+W4AD1lLKjjujhKlJ8Badr9R/KIrU96dkDaA0SG?=
 =?us-ascii?Q?wpgTohYCkdzo8UCvaw4R+g7mNDdfCTIUk30AeuIcNgpUQ4dhDSA1a5qhfocv?=
 =?us-ascii?Q?PVT/mPAiuIpCGgFly3/kFlQ6h6Onlns1e0aopl17yn+NnZvZDmhAPUyxWNG7?=
 =?us-ascii?Q?nHLvAWOLU68RTjf3aHX2FWnLOFdjV3UL+gHEJLw7nG0wdjXvXMCI+8I+s4ue?=
 =?us-ascii?Q?4YUoi7NczER04HJZkUQdHFr1SrG1uVjjr5iQ8Tm+Pm4OfP3UKpgqR+Kx81DJ?=
 =?us-ascii?Q?HbiUF5BV+RRUdY5Ky8C024ienXrRVRyMs3cB4tkSwCUzDY6DiN/Y6HMjcxFj?=
 =?us-ascii?Q?jqcljHc9djXu76Xmb3yLtvExeo3Z2QbA4fLzD8NvExpRCXuCEJji8y7e1bbG?=
 =?us-ascii?Q?8qUekHcZeXk+8MGuS959beidDPz34uGpJLi1Vkw0zZ4rKmxF7xxfCW9R2kVq?=
 =?us-ascii?Q?S+XnWsQEZRMQOfvpKABHB7S4w45JW6506Hni+LEH3FYBZKQ4BkRkG8CdkhR6?=
 =?us-ascii?Q?bAVgFJ1/y6eW/dA0hTuxYz8+udoPfcutiSizqJIXqyCL6aLfYr1ve9FVlkYD?=
 =?us-ascii?Q?hATzAJFhjEKMb/clXsBFKIY6nO5pFSxSpOaCfTfeXt6RBg4ejgvZ2oqBDDWA?=
 =?us-ascii?Q?W6K7T626HnmpPk85/0ltW3nCiZNTbGA77k/o+fX366dZOSwtHCWgf91qDQ8+?=
 =?us-ascii?Q?eIrktmSzNo+TntejmBEbkNQGf3IPy4NViAdknvUHuvl2yuTXK2kEGcJILgwd?=
 =?us-ascii?Q?VZoj98MfGVd7gyc3JbwwOtJUpHVMzwxRhs8URw7fZ2n7/sBVNVCLm3x71rls?=
 =?us-ascii?Q?i1shkYYSjpmkFGG2Xz6/kQUsM2cDFL2WUxaMEN/KizFOs7usR8Q+yWra9B6a?=
 =?us-ascii?Q?JRImwhsmvv1jSX6DGD2noRFaZLJww4uVk+D8C2LY?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f3916b-ccf3-4164-d8c6-08dd93c75cbe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 15:44:22.1766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4RkVoXZ9WzvSHmgOurCJMDC475yLfqAVqXZrk4PVwjPbfGiCXCrdinmP5v3LXB3sKhrQh556pkpcKoi8u8sMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8470
X-Proofpoint-GUID: 2SQYagKykVQDaIHORCsnddEgrspCOX7E
X-Proofpoint-ORIG-GUID: 2SQYagKykVQDaIHORCsnddEgrspCOX7E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NiBTYWx0ZWRfX8DjKjcYaaf+L
 0p/rLLsCTVeVdjgxtPGsbtU7rvlQE70ZH972pKCgXuPujYR99CYPmLyqFx7vBhBJ8eme1uXtAFN
 dn6if2RFG5sG9d60zKGeXx507k91wGmTPOXl5FSYEAQqcRP1oTErbqorUz66i8TczOXWFDFVRP5
 fI19LChDoK5KCJR+e9DrbLXuGd1AJRLH0PVgHLrcc0VPHxXXLkVFZd90TayPGEnQ6u1fBRe+Zk1
 DUezNUk3b078pZx0q1/qAJNtTpIqoiIu2W2iTaHz+xXA/4L3NsePXCK2+emPFNDsihBDSqsBD0D
 zaEOt65yybeX7WFoqDl3jWH3VFgJmgVz5fnab2gRaAlkpIxg+PNdynnD2RJHGoeZLcuIdk38e5G
 FDwsRO9xtwtq3GKl81CQeQpCzAj2OuLBP64nMBIBmhb+KrCMepjVGZIkpEQ98MpiRMq1ZCve
X-Authority-Analysis: v=2.4 cv=EKMG00ZC c=1 sm=1 tr=0 ts=68260bdb cx=c_pps
 a=CQ+uznrK75NoT8CVPM1Etw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=LD-bTVk_YcQ43CFCkRcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
region that the translated address is found in.  This will be needed by
CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.

Also return the xlat offset, so we can simplify the interface by removing
the out parameters that can be trivially derived from mr and xlat.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/system/memory.h | 16 +++++++---------
 hw/vfio/listener.c      | 29 +++++++++++++++++++----------
 hw/virtio/vhost-vdpa.c  |  8 ++++++--
 system/memory.c         | 25 ++++---------------------
 4 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index fbbf4cf911..d74321411b 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -738,21 +738,19 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
                                              RamDiscardListener *rdl);
 
 /**
- * memory_get_xlat_addr: Extract addresses from a TLB entry
+ * memory_get_xlat_addr: Extract addresses from a TLB entry.
+ *                       Called with rcu_read_lock held.
  *
  * @iotlb: pointer to an #IOMMUTLBEntry
- * @vaddr: virtual address
- * @ram_addr: RAM address
- * @read_only: indicates if writes are allowed
- * @mr_has_discard_manager: indicates memory is controlled by a
- *                          RamDiscardManager
+ * @mr_p: return the MemoryRegion containing the @iotlb translated addr.
+ *        The MemoryRegion must not be accessed after rcu_read_unlock.
+ * @xlat_p: return the offset of the entry from the start of @mr_p
  * @errp: pointer to Error*, to store an error if it happens.
  *
  * Return: true on success, else false setting @errp with error.
  */
-bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                          ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp);
+bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
+                          hwaddr *xlat_p, Error **errp);
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
 typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index bfacb3d8d9..0da0b2e32a 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -90,16 +90,17 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
            section->offset_within_address_space & (1ULL << 63);
 }
 
-/* Called with rcu_read_lock held.  */
-static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                               ram_addr_t *ram_addr, bool *read_only,
-                               Error **errp)
+/*
+ * Called with rcu_read_lock held.
+ * The returned MemoryRegion must not be accessed after calling rcu_read_unlock.
+ */
+static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
+                               hwaddr *xlat_p, Error **errp)
 {
-    bool ret, mr_has_discard_manager;
+    bool ret;
 
-    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
-                               &mr_has_discard_manager, errp);
-    if (ret && mr_has_discard_manager) {
+    ret = memory_get_xlat_addr(iotlb, mr_p, xlat_p, errp);
+    if (ret && memory_region_has_ram_discard_manager(*mr_p)) {
         /*
          * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
          * pages will remain pinned inside vfio until unmapped, resulting in a
@@ -126,6 +127,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
     VFIOContainerBase *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
+    MemoryRegion *mr;
+    hwaddr xlat;
     void *vaddr;
     int ret;
     Error *local_err = NULL;
@@ -150,10 +153,13 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
+        if (!vfio_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
             error_report_err(local_err);
             goto out;
         }
+        vaddr = memory_region_get_ram_ptr(mr) + xlat;
+        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
+
         /*
          * vaddr is only valid until rcu_read_unlock(). But after
          * vfio_dma_map has set up the mapping the pages will be
@@ -1010,6 +1016,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     ram_addr_t translated_addr;
     Error *local_err = NULL;
     int ret = -EINVAL;
+    MemoryRegion *mr;
+    ram_addr_t xlat;
 
     trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
 
@@ -1021,9 +1029,10 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     }
 
     rcu_read_lock();
-    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
+    if (!vfio_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
         goto out_unlock;
     }
+    translated_addr = memory_region_get_ram_addr(mr) + xlat;
 
     ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
                                 translated_addr, &local_err);
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 1ab2c11fa8..f19136070e 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -209,6 +209,8 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     int ret;
     Int128 llend;
     Error *local_err = NULL;
+    MemoryRegion *mr;
+    hwaddr xlat;
 
     if (iotlb->target_as != &address_space_memory) {
         error_report("Wrong target AS \"%s\", only system memory is allowed",
@@ -228,11 +230,13 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
         bool read_only;
 
-        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
-                                  &local_err)) {
+        if (!memory_get_xlat_addr(iotlb, &mr, &xlat, &local_err)) {
             error_report_err(local_err);
             return;
         }
+        vaddr = memory_region_get_ram_ptr(mr) + xlat;
+        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
+
         ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
                                  iotlb->addr_mask + 1, vaddr, read_only);
         if (ret) {
diff --git a/system/memory.c b/system/memory.c
index 63b983efcd..4894c0d8c1 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -2174,18 +2174,14 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
 }
 
 /* Called with rcu_read_lock held.  */
-bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
-                          ram_addr_t *ram_addr, bool *read_only,
-                          bool *mr_has_discard_manager, Error **errp)
+bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, MemoryRegion **mr_p,
+                          hwaddr *xlat_p, Error **errp)
 {
     MemoryRegion *mr;
     hwaddr xlat;
     hwaddr len = iotlb->addr_mask + 1;
     bool writable = iotlb->perm & IOMMU_WO;
 
-    if (mr_has_discard_manager) {
-        *mr_has_discard_manager = false;
-    }
     /*
      * The IOMMU TLB entry we have just covers translation through
      * this IOMMU to its immediate target.  We need to translate
@@ -2203,9 +2199,6 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
             .offset_within_region = xlat,
             .size = int128_make64(len),
         };
-        if (mr_has_discard_manager) {
-            *mr_has_discard_manager = true;
-        }
         /*
          * Malicious VMs can map memory into the IOMMU, which is expected
          * to remain discarded. vfio will pin all pages, populating memory.
@@ -2229,18 +2222,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
         return false;
     }
 
-    if (vaddr) {
-        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
-    }
-
-    if (ram_addr) {
-        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
-    }
-
-    if (read_only) {
-        *read_only = !writable || mr->readonly;
-    }
-
+    *xlat_p = xlat;
+    *mr_p = mr;
     return true;
 }
 
-- 
2.43.0


