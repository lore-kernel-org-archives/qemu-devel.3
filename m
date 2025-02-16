Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBAFC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnw0-0002Sh-9k; Sun, 16 Feb 2025 18:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tjnvp-00021q-UT
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:15 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1tjnvm-0006C8-8r
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:13 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GA38lK032501;
 Sun, 16 Feb 2025 15:19:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ieSSVlWw5ulD5MTk+vSMsFz/0yaHO9RjHND19BpIa
 og=; b=sINKZhVrp6xqMb/sh+0EiuNU+FkX7TJTTd1pQ25ojURGJDwFH/ufkTwQ3
 2puFZ7DPQUvjdhxBMpXMT0bp/ipQx/Zlel4VUO33YuQiZxQ3seiGmMAL0FRC961U
 bkbM1IAO1VJHGeiOng0xr5qpuPxxJB3GY6I/vnmgxaUqseldg6itACOfT4r9V8VO
 LfKkMSC0l/uOvEEYhCZqRlmO/KfRnjcwVln5McOo1FiV7DK4Xs77pFDTKzWBDIIK
 RycV588bOYNmzAvopMN09k/GoLRmFE3Zglv1DLkRoG6V+H3uBwupZu3sLpckETc0
 B1rdqXvellrWH/5/yYWs0Oi7Dx3TQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazlp17012039.outbound.protection.outlook.com [40.93.1.39])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44tuc2t57q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Feb 2025 15:19:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQGl4NcCMDmEGEFLQyrpFslBtYR6Vx2UvJbm6aaxA4VYwi6zZQK7XiUjxb9Ae5IKtLXjgZuKjBQv1EXbi+80s/vfVluJmLXI2yKsEI59EKn1GbBPCTfVK0TEWizELaOF4EeSqDbAezd9xAGgH04sZwZkPCLG/sJeIAeR6i2Vr2UZnVKUSGwxQtD9c+iw4lmwnXhCiKyXVKG3dBpFqJtzWgEPFgxM5uDZsvSbZyCN3KdQIRsta2abOK7jHO7YXxURIW45TBcCTPGmNkanVVjrgw7M8UjrFSxsmDXKQWO5ZKqYmiOqKFToVdnW5X0dhX+gjU5QkHGTSzo7aW3L0G3afw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0gLoBN8rumCTVAYAibdU9iG+QbF2XahTgB+ZnQ2i/Q=;
 b=fBXyAW3A7ndCe2S5T4NFbN2rzJF6pZWL9dThAxh6tWy2t475qkFxHc4Xs4IL1g3CugBO6/xo64dvui3T+Jpa9MvY/e9dd+kMxC7vIZmndqqE6xdev3nCxPRLTQrijhaaCWFEZo9DODDu4zoO04aR9FztzdAbsO6lMpBY1Y+/ngIjicxoHULpQryo/7pZqy9gL5LIPqzRDZlLTgKNNN9ueM0X0wBQsDX2XmnHcOGQYjk5RJkAFdHC3qeIoXCqaZoobJdoPE2zDZ2ZqR4U+bNfORox7n53iaJwNc9S6pLLXIcFfmIhQiuEmFFBEp1koOTVHplZLTg0E/ZPWXRcW4ZJfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0gLoBN8rumCTVAYAibdU9iG+QbF2XahTgB+ZnQ2i/Q=;
 b=KiCwnh/Xp6Wbqe97cgv6LnrSFpxqaMrGUOFrcnftWSn4pzapWciWyANdeXYrlql6HbsOvWeTXBaRlra3UGQEmBp6Zz7WXGr6Zo57OCrlsecc+X4MCUhwlU5z5q95quhwRz+LJ8UXmfot1BHe94EZJG6wVGUTJ2TZiRb0NEE2GBMGh906Sn99k2FI1kPDfZveYCHpb0Lwki1waRMJFY9inIrHI5KrQvMK8JnQD45Zm22Qo5gsBdcW907Eo0IHf1vCaPolziy5SEx16Xv6cG/bcngIvMwQJEnUgU8DIZM88DjkwsW6+Hfc3un9N8H1DkqdXIAoUa8JCopK2VSUbeUahg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by BY5PR02MB6580.namprd02.prod.outlook.com (2603:10b6:a03:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Sun, 16 Feb
 2025 23:19:57 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8445.016; Sun, 16 Feb 2025
 23:19:57 +0000
Date: Mon, 17 Feb 2025 00:19:48 +0100
From: John Levon <john.levon@nutanix.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V1 16/26] vfio: return mr from vfio_get_xlat_addr
Message-ID: <Z7JylKfoY8aRuWpf@lent>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-17-git-send-email-steven.sistare@oracle.com>
 <e8e6eb45-a308-479a-bd14-ad9bf4cc509f@redhat.com>
 <e961804d-33a9-4243-8ef4-28f717a0d397@oracle.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e961804d-33a9-4243-8ef4-28f717a0d397@oracle.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:208:1::46) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|BY5PR02MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 817b4ec4-cd9c-4d77-b73c-08dd4ee06cfa
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?rh91i/MtzMdzKYFVMJMU4xSCOnWABbkPKOOmgXa1lOsjuibOxnbfs9PtfA?=
 =?iso-8859-1?Q?THPXrb8I+oVK8dHnYcxoFsqcvD/UNi9EBwnNNLvzJ+BbdgNCUUOdtz26z2?=
 =?iso-8859-1?Q?aq4BUEMLrOuIXLMBdhTbet1b/RNNu5IV7nHXDjnTD/dHtouN/JzjogPEyy?=
 =?iso-8859-1?Q?baWPwwCTcDrKKHFxUqmK8SkGOBk/7Wa9lUjOAafPvX4PC7PJd9h95wlTp/?=
 =?iso-8859-1?Q?oNsavtmKf80BLV91IyiziyyZKGZsfSOPblfTgT7Hk0cNgpJmd1oUFt0w7A?=
 =?iso-8859-1?Q?nwkDQnjU7qYJFIyguRoaZYD7d/HmpWUT3nkwQ+mIS3F9zj6XV8hle5iCqy?=
 =?iso-8859-1?Q?DZ+oAgOCceLUzqFR+RHohkRUNe3g5dj8Y6Py1Ykh1bzdQIw1Avyn532y5D?=
 =?iso-8859-1?Q?VHijjAbIBalwRb0EnSgjxY+J2deKJP3m2AE6d73DujEd+oKCn1VVsfchlh?=
 =?iso-8859-1?Q?s1acHOUM5ePsSTmWPRqZar1H3N+ouquJCue610ENFdGwuufecmW8F+W/Vn?=
 =?iso-8859-1?Q?S1jkD12Mw2kMpOA9uHSmxgJpYXfYnA3FDlc+gib1TqIC1t3MLYfxphvNPi?=
 =?iso-8859-1?Q?D3LD0TtSLDVlq+0GyxEEv77O1x55uMjCO8pYX7nQM2NDh8Wv4Qo6ZKjxb/?=
 =?iso-8859-1?Q?C8+RoXxj1U574T1HKlmXXxq1qVrMFDML59B0LfmC4TQYJbPnKN7CJlXDJm?=
 =?iso-8859-1?Q?GEIr5bFDUTf1bvZqUrFNd/rAQ08TOFp3x6z+R7qoq5QrZR9PlD24iJSKtX?=
 =?iso-8859-1?Q?h2CVCERuyAj8cIdOEnOcaHrc1t0RScaqdzA1mhmbAiMqLQ8Cxop2ady38r?=
 =?iso-8859-1?Q?1JY3IcD3pYlQPgQNfgMzwanTLU+SItkq+5JDj1F/xFYmP5L+KLdAgQqfFB?=
 =?iso-8859-1?Q?o6WmxzhBOIAwyo6qGxOwayKIfFQh5W1Ct+q5EiYcmd4n4DVONbeRTMKNap?=
 =?iso-8859-1?Q?QCnUac9ZBhVpliQiDghshJU4TSl7gwRXEt9DikHcY4LF6A7tDstUFd1Phk?=
 =?iso-8859-1?Q?Q3IuGg3xzTUQrwVVgvwbqnsJHs4lKdTT3UkbATOFqUvlgJDQYP+sWnOUaM?=
 =?iso-8859-1?Q?pXwJNibhQV04H49LDNrsifH/mZ+gzQzwW+fLodnKF61SqDrb1XVoLBIyea?=
 =?iso-8859-1?Q?M+tGzaNnRo0q3GZf3fV/77pdknI+jY13dxiSl/8ncrjaMJjrpp7zCUY9w4?=
 =?iso-8859-1?Q?kjEcCixJqlF/aPgcqd0ESP6Is78ob6quxGFIKCvvIbPX52bvbFFfhNKUvE?=
 =?iso-8859-1?Q?PaPn5gbNJSCFBPB5oHAr3QCkb4o5ybpui6O3r1EoKQfUGGBlyvu7YhdX6T?=
 =?iso-8859-1?Q?6AET2FA2W8oPTurHuTk4g1XhUBflgJX4mJ25RCTLpH/JF8Qpedsbs358sz?=
 =?iso-8859-1?Q?z/Awxa/cpnGeXYPJ4rssk+lC3856ckkJ5q2Hgi2YVFs3bUH/zl314c/MGK?=
 =?iso-8859-1?Q?4wDAsFaAKTgEceYm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?yTScyzXCQtoShe4fSWl4UL1DwBHIlZ5DJaSoW2UdnZLC3uyFQ0BitRqrLA?=
 =?iso-8859-1?Q?TpkButRxe/payJrC6/okVWgZocgzLr3dsGLxO4FZG0ygHoFsLvLFka1d+o?=
 =?iso-8859-1?Q?74veHqCYAVI50PIJml1F4av2UH/mjJP1CN52h6rWkfE6Drq/QWOYUKguOD?=
 =?iso-8859-1?Q?EB1jRg2l/51ELnZTVb5Dprde/2z4WJXuSJtCUIVHgVql8LOvScQXsUX1gz?=
 =?iso-8859-1?Q?+HPLEaxbeSjXX7zRMUzMVYe+ZtZ6ruRVt8KKdOCPbq/dLsZfJ6ix18J3AO?=
 =?iso-8859-1?Q?fwEsfIMWfB5xHAkR7ad0q9ULbTi6hh+vbcnmCKX0T0boxRpYkNrD3w5u/D?=
 =?iso-8859-1?Q?xN89rnVr/P5410yI19GrzKybuh+TUwAjTGq4Lqiby8K24DX/js9yaPm0/2?=
 =?iso-8859-1?Q?vw537l1Wbywjk02qMmnCtUkKSBSoEgzFvOscHG4CVOU2U7gPdlTzAregPn?=
 =?iso-8859-1?Q?NmR7ZrHK3Xxa0PBFLQet+wgfUpc9/r6Z9eu5lNcTGPpTI7R3J3uVYbzDt2?=
 =?iso-8859-1?Q?ohpPSnCOrtu4BxRrtOJSzM/7cYAJJmpa4EMMw4V/b9mme8j74UNdPohnWT?=
 =?iso-8859-1?Q?IdW2BCWfWEOKnL2N1Be9/gC4VZtiDHX7PMy9pncoGVY5uoqp6icGVeavKS?=
 =?iso-8859-1?Q?XkTYC1jN5Y19vaX7W8bvmwTe1fSVCAmBt61P2NC4rsPWe1+jINFzeSFNGU?=
 =?iso-8859-1?Q?3mcr5UeHuNmLl4U4x/KBEK62avyL95nyoiD8mHrP8H1tExz2+Crbjv8w6o?=
 =?iso-8859-1?Q?JxjNZ3irN5DlAqqcahixDH9evmrTC3Xlnb90K84Vcil8TRXu40c0XL0vVD?=
 =?iso-8859-1?Q?iYXdW0gl6IYxne3CtBomTntROXl13k7Hz0v3sA3fIMuODFRxd5P+0IlgnK?=
 =?iso-8859-1?Q?eCtUb7CKmU3XBWmP9kSMfvvaknsiqa7KFtMs61sAYlnawDI1hUi05k0GAd?=
 =?iso-8859-1?Q?kEJ6YEHQauvfdQk41nK0rQBPCszqgIrs1tibLLM4TGC3BqatX1r6wkyMPq?=
 =?iso-8859-1?Q?aNGVmQLVq2AtTFNTxd+M5BpSD89Gky8rlCD1r/R/kIHN7ijMAokkw5LDml?=
 =?iso-8859-1?Q?TY5jI5Sj1R6sQhjrQgA4q9mIk+38fyRwgg+it/cUSDRLU3cTdrrBV46Jti?=
 =?iso-8859-1?Q?36BNhGFkljfdZ2fs/oYn6SxZ+plSeixrf6mFte5hPRe1cCVlGH08g+64Xf?=
 =?iso-8859-1?Q?ajjgjOpBUpwgOftviwkZbJ84GQwbx8Qw3xI9MROuPTqGU/bpWOTR3y71Kp?=
 =?iso-8859-1?Q?uLGFTBA6DrWProbdrT2GmlXO/ISXnnFoKjnNke7R95z3e9pNDA6mavod4T?=
 =?iso-8859-1?Q?iHUYAGhytPKL6RqxeJflIX1V1wUQDRN3wjKDQ5lS05G/7KPK6GpvQhxg1o?=
 =?iso-8859-1?Q?zdcBzdCvYSQ3iZv+KCy8VledNf4I+0bjNkaQj8kXfH8cyEIqMZZ0DdGwqf?=
 =?iso-8859-1?Q?XYHzFEDelwOr9dOR0ezMuUxKr5M3PVu8xDJtNrkzGb4TMG1WlJdNsolWUO?=
 =?iso-8859-1?Q?cQgzWvhrA+fg/iAv6B8Xz11UBGIm6z/koRupqYTpUnm6v1GCwktK5oz46K?=
 =?iso-8859-1?Q?CwGNjgjuzqGrKkqnTHEDGXucqmyJJXuRhthuNJzKDf6Qp13VJufxhpu1Kj?=
 =?iso-8859-1?Q?KBrb3+SnR1swmBz0h+Ag27jK1CqYVoIhbi?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817b4ec4-cd9c-4d77-b73c-08dd4ee06cfa
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 23:19:56.9852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqhwzYC+fOPhBVA4g+bXy/DpHtDnI3hesDSoYHOZ/7IP6gRFeAeCEhpXRQQI4w7s2MRms4rZpc+OvBmMTs/YUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6580
X-Authority-Analysis: v=2.4 cv=G4rmE8k5 c=1 sm=1 tr=0 ts=67b2729f cx=c_pps
 a=1DU6XXJf+V2sdG0edZkYmw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=T2h4t0Lz3GQA:10 a=0034W8JfsZAA:10
 a=0kUYKlekyDsA:10 a=hPcnYN1zVxM66eKCG5sA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: 6rbbnVa3waFbkOkWkOfUs_0So_2XAX2t
X-Proofpoint-GUID: 6rbbnVa3waFbkOkWkOfUs_0So_2XAX2t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-16_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
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

On Tue, Feb 04, 2025 at 12:42:20PM -0500, Steven Sistare wrote:

> !-------------------------------------------------------------------|
>  CAUTION: External Email
> 
> |-------------------------------------------------------------------!
> 
> On 2/4/2025 10:47 AM, Cédric Le Goater wrote:
> > + John (for vfio-user)
> > 
> > On 1/29/25 15:43, Steve Sistare wrote:
> > > Return the memory region that the translated address is found in, for
> > > use in a subsequent patch.  No functional change.
> > 
> > Keeping a reference on this memory region could be risky. What for ?
> 
> The returned mr is briefly used here in later patches:
> 
> vfio_iommu_map_notify()
>   vfio_get_xlat_addr(&mr)
>     vfio_container_dma_map(mr->ram_block)   ******
>       if ram_block is right
>         vioc->dma_map_file()
>       else
>         vioc->dma_map()

The need for ->ram_block in dma map/unmap is exactly the case for vfio-user too.

Cédric:

> > There is a risk that the life cycle of the returned MemoryRegion
> > doesn't match VFIO expectations.

Can you perhaps explain in a bit more detail your concerns? Are you talking
about current code, or possible future uses?

Is there an alternative approach you could suggest?

regards
john

