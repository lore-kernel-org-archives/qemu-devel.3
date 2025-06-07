Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9C9C5AD49
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNh9u-000332-OO; Fri, 06 Jun 2025 20:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9s-00032S-1j
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uNh9p-0006QS-Gq
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 20:11:35 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556Kwc12019117;
 Fri, 6 Jun 2025 17:11:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=FzuK4DjHNkzel/Y1hX5O+J/iIuxZYuPD3fBEnqEQG
 VE=; b=m37PnhJ17y9PM06Jo4Dahk2xUG1jDxth9gdFU0rcZvMD78bUH3fGY+XWe
 t2bEqtDZsKK9isYQ3lN8dmWm7iP2rIegkPHv3oVEuR+f1qtqLfwpT2Zh7BV9aPQw
 YrdZxLRR1bJUPf7aoG1zeqydSm7RCQ7FNcnQaJseVww6Cv3OfWh2snbluFzZzZXi
 QtdOf3WqxebZoNohILTXr0kyy7mkUsGutjjtTp1XUJDYOYovbr0nyQGY09KpdEDM
 cHP72W62UFgMPVRz325LxN0qBZxm3urSBm/y5XecqUGaSSKTjODlE3ZtXrLkFFna
 1REwxSaqLb0pTS/lPFwUWAU26Cpvg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2096.outbound.protection.outlook.com [40.107.237.96])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4747u3r8fn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 17:11:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzCUW/rMFmYJDpNPDe4L7atKHpCu1I9EzSPpP3aUjD4itqysnzqhp1OzcHfmlfHNtKNj8/vGWkh6of8qkpM/d2E0fjN62EYHMuVRPPxntucdxfcSdFFEgXBnvJtLcgC7JKIjjV345B99YOqqzi6ssCcksxcItSoJw2bIkK+BtiInd7HNY/l8/taxZl9nzOmk6raBwx7EqdTr2bXZIw8X+YIuEE7uA/A2aIpIWsdd1bd6/a63oxLGDGSkWXLMVZEDRxrWC46CyamBtkSGmAuc9bkwYi2kZbo3w1b9ND9F4olYl71722mFigJJVjt9Mss17GetmYL7bxS1QCH1l6ogRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzuK4DjHNkzel/Y1hX5O+J/iIuxZYuPD3fBEnqEQGVE=;
 b=XYKJYVIMhEHXkNqi9Unx++F0SjYffDDp7vdLN+XL4ZamIL1eulO0SZ4qNTgX0E2UTqVzACHA87pI+7G6PbdxXgMlmlvp7722RhMODLicqDoYTvIrjQcB9uFXZQGEJ5w1unc1WV2pjZmCfT+FAkrdXJg73x2U5BIVoEAFxQLYqAGP3kpqVzmbSwIx7iOWzb5MdpEQonElfm6ug+c5glXETZO/8OF1qJVNyiFK2ASCThRDFtyDP+zhdKPymFGiEeHGm8hx6Zh1aoc+CU8ajuoG0j3xs/jbVyb6ZIngoZzlS811DU5r1U2SZRU9tVsitD3R3fgpNHuZpjoOUnDqCDyCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzuK4DjHNkzel/Y1hX5O+J/iIuxZYuPD3fBEnqEQGVE=;
 b=lk673riy11F5sTkql80uFNy2jy1/OJdTXzizrom73OMhqn3u2Yl9DYZ4/ofBfxiNFsQCM66EZYdSVnPRaHoAJHpEAMkkIn8uO9Konz4Qd/ajyS4oQU9+h9D28TLT3rD1YZ4nq2l7mGu0H7ZGLzqAV5c5hsaQ1Z+LKVK/pLytkxqvzMAaZx5GrRuznuekRNbR1tXa1Bqi0FVE/WoQ3e0h9iqul2wMiVuvhinwGkV5XFIrsnZjOm9e5r2otXA3MOKMmRgP1sBychYQEZTmgFNaokL3V1w7Tnvqs66xhCZHO32GBSYItEj8SYbZYNoh6fdYdzR/i15C3ZE7/wZSSlqt/A==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8715.namprd02.prod.outlook.com (2603:10b6:510:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Sat, 7 Jun
 2025 00:11:20 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.016; Sat, 7 Jun 2025
 00:11:20 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v3 15/23] vfio-user: forward MSI-X PBA BAR accesses to server
Date: Fri,  6 Jun 2025 17:10:47 -0700
Message-ID: <20250607001056.335310-16-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607001056.335310-1-john.levon@nutanix.com>
References: <20250607001056.335310-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0004.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::19) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f0bf15-132a-48df-e96c-08dda557d484
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qeZ/k3yQ2VJCHYV0FY1NgFqYB3OvYUqtdtVZ1zc5k605Nxg8CEM3uv++1YkJ?=
 =?us-ascii?Q?Sha6bGHOBmgQj5wp/Ccy5cn+UOUrJ9Ln0w3in487JsTGX+PiLrZRLI5VTIE4?=
 =?us-ascii?Q?ubFWAJXvsmlNcfUtvhT9Ovzx+ddC8BAk8LbOxhEz7Ki+qzNtub+PENF7kuvq?=
 =?us-ascii?Q?eMJCF6IOZlXvwDRdvh7M/qcH3iNWDq42ypOaiqCsKK+elOffQB+0aceDTnSm?=
 =?us-ascii?Q?kmx5KUId2DLcKeKbUkbcPkAoO9Ztu8iBK1/meXm8WTDyCktm0kgK7dZL9AS6?=
 =?us-ascii?Q?q0MjD+iCUdsIMEZWDgpJ12qIsDq8VP1/OHgATIqVQrJZMoNuBUCzutwtlxp5?=
 =?us-ascii?Q?TJcBj218kFkQllB2FAr8gXu29cMO02h+beE36n5H1rR0SMTR93ZDDZUZgfOD?=
 =?us-ascii?Q?UdkLYXC39sieC+kKROOOgr09JlRADgy2aqEY6MAVMpmy0jsTxCTzZRaZIOMP?=
 =?us-ascii?Q?k5WA7cKu9lGRIIgzp1GOoYmeV6WrsDrXkVHMaqc+WpYDOBQPSFg9IkUdjQ4x?=
 =?us-ascii?Q?MOPxof+8nBTOJQhY05iwV62sssfhS6qrKryNtD/Yowu0O7u1XwoFFQfxMs29?=
 =?us-ascii?Q?VLPT0mZ4jcM9n1Z5ifcd9ilFD0KvRI/4AlDcJMk1C1pH29mOXNp1aqWJUWF9?=
 =?us-ascii?Q?30Pvwro9Zic0VGhBpDQ0K4u5WuiRRCKuuAAZsQehaLXobagTEWpUHq7MZiy6?=
 =?us-ascii?Q?Oxidxj2L4gpYQD/sJWrifSfxEfpazu6uoeqGBA+xlnfviM5TeAL4Xy0iea3c?=
 =?us-ascii?Q?Osc057OohIZogxSs7khyMpm3rRK86OtXKxH1ev/bcRVQRxWsC9Op1NAkhFyA?=
 =?us-ascii?Q?KweYwJdvZfi6DtlYGgP68IiiZWRpzcr1DkyCVOzup+Rn8P7Bac3uRakTvvYh?=
 =?us-ascii?Q?7iymLv2zO7/d7aWYD+VTIzHo3DqaSW5tiX2YGkY4DRVSKPL6uCvcxNFyok/N?=
 =?us-ascii?Q?pXkFTnkUKHteQlPWmHZCrfv5A7jrP/6gubnbMrxIJxJ7r99BXCvx3qbc1Fgs?=
 =?us-ascii?Q?b/Jv/S9RG4gs7rIcbPV1N1gFcBGUMtDcF7jZYeVDXuZDvhuxVr8oEjfJfTLM?=
 =?us-ascii?Q?XYBK3ArmWafGWfRUa9NDjihGFzIa+tZA+1I01JbWIufaV9e5kA/ckK1JzSah?=
 =?us-ascii?Q?ypYRhQsP4u5HF0GK9hTJMT5iqgLA20M7+Lp/+GUl5NoUwPYIxF/a/IfcgcpM?=
 =?us-ascii?Q?5S/Q3ex3jo2zrg9YQEBDMhs7VchPCTMlYvy9KFxaFlS5QRCk57jx2WYqmxZy?=
 =?us-ascii?Q?X9W8ng0d+qre7VHTJsZ9hBdsTRQ3gsOqhUGY+IJux2TyS6G0pu8ZabUjm1kK?=
 =?us-ascii?Q?fC5jysSZsQmLMn3xMOuW5qABOVIpcuv32UpF8uXq3T1F/6eSJ/bByH4B5KBv?=
 =?us-ascii?Q?aGgHknvwFEax7Sb9JYm2pW0DrE/Gln0xNA4RdH8eGsvN22cU2bArmz1naVtp?=
 =?us-ascii?Q?mSC2xQj0xy0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JslIefZOxPzokjaAHDGozDT3cw41M9xQXoVDk2ECm4wRY7tC4AdA7yqP6dZa?=
 =?us-ascii?Q?Kh/y+tsEoSM77KIqyl5+1jQNQ2wDRaOm9NICXlu62Omy6h3wGKrZPmaz7uPd?=
 =?us-ascii?Q?codgfMwHS6HgddOAnuXeEuK4yoBFD2od1MKh5RfVlEHroL7AViHbeXQ4i/Js?=
 =?us-ascii?Q?j0TITnuRbfwJFl2EaSPppmECMROUAKnUm/n/JVf2SpG84OhcfWEG+zzlj4IM?=
 =?us-ascii?Q?eq9K8VtcoP10ITH6n+W6gkF7Yg6ngXWIIPL/7Q6ZyfLuqutBfnwGeiRCrEQW?=
 =?us-ascii?Q?59S/hrJWb6D8ucUS856ahQSHLn/mEX3gTEPjF5GVEAtbtGOFTw9pqLYlpYqA?=
 =?us-ascii?Q?ipTYdzw37ES+/VMsK67KSi6MmjgtjjK5r1G2W8oQ+j77uhwO473QxiECXFp2?=
 =?us-ascii?Q?5Qt6AgtyptMV4x5W/VLnKewQDUOTW/xkjqPSt1P9SxijaFgIbM03htnApWqN?=
 =?us-ascii?Q?AClS9Iq89KyCA++fF91YvuVWeJCce1JIcwFVE3qUxggWX7F3TJMC14aH5rUt?=
 =?us-ascii?Q?PqRS8UnwWR7qSFKvAunvYSycxHMDyL10B1rPDci4ILr5KRNaRmoafkMXy345?=
 =?us-ascii?Q?fHWKnxevJtb8cH8sQXoRSSVtinaJtf2zbtdqakUN6AbmBvUGwhG1FJfQEgaT?=
 =?us-ascii?Q?zCUcHTgtsK1BOjSlSBLFaxzXaeQNNaCyvE12T1wugSSsN9NrR0khcZ17NYed?=
 =?us-ascii?Q?ysKQKhRIY2Oi/Nv1f0stMD11IqritcZm/x0rCQs8w95lUQue5/YmB2AyGdGy?=
 =?us-ascii?Q?RAGoRD8eWp5hSV82ZnkL5+79KnW3ibNGo2aF+S44j4wPwX8hBbN49adMipF6?=
 =?us-ascii?Q?4K4bSCqxSFZt7iIMWco4Gufqg/4xx/0/6pENMuiQphtfBrTe+pnt7Ielfsmq?=
 =?us-ascii?Q?gW87F0mRnDflKiS6CqifsDXuIlPtn1n3tF9NsFKOTR5OvxgojAhibYdJVnLl?=
 =?us-ascii?Q?KjhYKq3r8i/y0IrHxLzjYGIknvsbLW+NRfasMqpcXcA2v7Y10JsS0i2QzfKQ?=
 =?us-ascii?Q?1ZGN3SJDDXcPlN2M4eY5bwgvUqOqcb3ddAXLigZsdWeFi+QccGgF6rruEJNX?=
 =?us-ascii?Q?po+hxR7kx4o4nIgfcg3mfE6VtcCdAAhgJbrM3/C8SrNoZA72US0Fk58xm0lg?=
 =?us-ascii?Q?xb2W3CmcnQkeU+UJXXnoSr6RMc/+WXYH+9q0aywOKsPKLjKuVG1ktrj+GDWl?=
 =?us-ascii?Q?mE2a/XV6SMULO7IHwLW0ZH4/9z5JI1tGkh6QLdvkzpBr0gZXnj+cFfeduWfV?=
 =?us-ascii?Q?iUljZecyXt1bRTP2XJi/tBL2QTNQ/sXl+MIBDBPCbmzrLeSvXVOmH8NfglaX?=
 =?us-ascii?Q?vy6XVAujWu6CCFKCx/vpMr9ZlVPj3TVxEfqgRHLvkcyXa5Hnhjo/cdf4A2XD?=
 =?us-ascii?Q?zVIo1B1ch7WE/BhsxMnFe/xQzakgWFLeyB50mNDG104erHDjURwl/LwC7HZg?=
 =?us-ascii?Q?XUiQ++bw68OmS2nLoNfYLugHdJQK8bLQGKiD7iWcduGeEo0XLX9k0oUwYsvt?=
 =?us-ascii?Q?MlAeewGo4UceB3SMHVh5ZKDvgBcqsfZ8L3QkLb9F6orI3LMAlf+XWKDr7pIR?=
 =?us-ascii?Q?VlwxIOU9e/iG4cdxBB+668F1UHKm4kfw+L74MgCZ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f0bf15-132a-48df-e96c-08dda557d484
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 00:11:20.4040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpjumog2H1SH4+5OMMkl50qgMel98oiKaXmOGfRNkGocwN9qlX3x30KACuzmqm64QRVARdVJ/ILyb7eaCHMv7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8715
X-Authority-Analysis: v=2.4 cv=cpSbk04i c=1 sm=1 tr=0 ts=684383aa cx=c_pps
 a=XYC6++eb3LU7Tn/YozfASw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=P96-NN1LHiVJMZ2xip4A:9
X-Proofpoint-ORIG-GUID: ysfLDn_WGXP4Vh698zuz2CUlTDQCpQBs
X-Proofpoint-GUID: ysfLDn_WGXP4Vh698zuz2CUlTDQCpQBs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDE5OSBTYWx0ZWRfX2A7fm+JIpXty
 L7b9eO+lG4dIv6vmJbNOFHkypz8P18nvQDGsjYSqmDx+p3wEk/W/a4irUVjWS8TOdgPBMdVJJ4n
 H1uofTe8Ce+/WRf2OHMUm6cLT0WyKIToyh6bewfRw0F1/At8CKcttht+BJS0u6X2KliP2BdPmEA
 8VnEeD+eBJwM3ncl239V2PH9YRMNx8RfR03Pc+D5Jo4LJEnj3pm+ivRAwjIEqgzOu4uDIcRDTUn
 uBMzY2oqT4TuhCSCzz3a19HGJJHV6bDzl6nruKYtqUwXROIZpHPInKU30I2I9wokdDTK4LaPF74
 SSiWtcfa24/nR6CwxmWKjMoiMHmVUlw5uZeCrXMMfNe0duHjvzwLRV7KQEM/i8/Gpj/T/ZkG+M0
 9+bVOTOueEQ/QoqrSV/2F3eYDHSu0QwhyrvC3Rs6W2fPW3JEBdxRJ1Et4uhlFXCoaf6qAPJ+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_09,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

For vfio-user, the server holds the pending IRQ state; set up an I/O
region for the MSI-X PBA so we can ask the server for this state on a
PBA read.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/pci.h      |  1 +
 hw/vfio-user/pci.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index e3a7d7bdca..47cf50a4bc 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -116,6 +116,7 @@ typedef struct VFIOMSIXInfo {
     uint32_t pba_offset;
     unsigned long *pending;
     bool noresize;
+    MemoryRegion *pba_region;
 } VFIOMSIXInfo;
 
 /*
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 5ac3fb087f..e055d5ffec 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -26,6 +26,62 @@ struct VFIOUserPCIDevice {
     bool send_queued;   /* all sends are queued */
 };
 
+/*
+ * The server maintains the device's pending interrupts,
+ * via its MSIX table and PBA, so we treat these accesses
+ * like PCI config space and forward them.
+ */
+static uint64_t vfio_user_pba_read(void *opaque, hwaddr addr,
+                                   unsigned size)
+{
+    VFIOPCIDevice *vdev = opaque;
+    VFIORegion *region = &vdev->bars[vdev->msix->pba_bar].region;
+    uint64_t data;
+
+    /* server copy is what matters */
+    data = vfio_region_read(region, addr + vdev->msix->pba_offset, size);
+    return data;
+}
+
+static void vfio_user_pba_write(void *opaque, hwaddr addr,
+                                  uint64_t data, unsigned size)
+{
+    /* dropped */
+}
+
+static const MemoryRegionOps vfio_user_pba_ops = {
+    .read = vfio_user_pba_read,
+    .write = vfio_user_pba_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void vfio_user_msix_setup(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *vfio_reg, *msix_reg, *pba_reg;
+
+    pba_reg = g_new0(MemoryRegion, 1);
+    vdev->msix->pba_region = pba_reg;
+
+    vfio_reg = vdev->bars[vdev->msix->pba_bar].mr;
+    msix_reg = &vdev->pdev.msix_pba_mmio;
+    memory_region_init_io(pba_reg, OBJECT(vdev), &vfio_user_pba_ops, vdev,
+                          "VFIO MSIX PBA", int128_get64(msix_reg->size));
+    memory_region_add_subregion_overlap(vfio_reg, vdev->msix->pba_offset,
+                                        pba_reg, 1);
+}
+
+static void vfio_user_msix_teardown(VFIOPCIDevice *vdev)
+{
+    MemoryRegion *mr, *sub;
+
+    mr = vdev->bars[vdev->msix->pba_bar].mr;
+    sub = vdev->msix->pba_region;
+    memory_region_del_subregion(mr, sub);
+
+    g_free(vdev->msix->pba_region);
+    vdev->msix->pba_region = NULL;
+}
+
 /*
  * Incoming request message callback.
  *
@@ -142,6 +198,10 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto out_teardown;
     }
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_setup(vdev);
+    }
+
     if (!vfio_pci_interrupt_setup(vdev, errp)) {
         goto out_teardown;
     }
@@ -190,6 +250,10 @@ static void vfio_user_instance_finalize(Object *obj)
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(obj);
     VFIODevice *vbasedev = &vdev->vbasedev;
 
+    if (vdev->msix != NULL) {
+        vfio_user_msix_teardown(vdev);
+    }
+
     vfio_pci_put_device(vdev);
 
     if (vbasedev->proxy != NULL) {
-- 
2.43.0


