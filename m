Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3287ACAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13UQ-00082W-GC; Tue, 23 Sep 2025 09:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Tx-0006ab-Ar; Tue, 23 Sep 2025 09:55:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Tv-00043m-9j; Tue, 23 Sep 2025 09:55:00 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N5a3dS3995717; Tue, 23 Sep 2025 06:54:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=LNrYqOnmSKSqge36mAEIR56sWg5tSwCjRrRDrtJUZ
 pU=; b=N+xnFrR+Y2NasefDJMLlZVv2beG5tOkAsm9RtufnzPsSA22qHFiiyMx8g
 zzvRgACbaPE3kkZ2HkWS2GmD8y1Uu3+BIjAypKOXHenzj4mbNBVugl2S+r0VCNuM
 ChwW+08qmg8jouO9oalqoR9f1AdUbltlxsj80mvbUNoxBvW6J7pcTYTxXijBCYrr
 IMxrHnN46Jw7bbVw9CA4kCVALIhmGMQhIU5v6TmK8jERAraKUVfZj4hFMteBRL2g
 tM3Ahf18RpxdpB+DdbBdZ8r0i0hM69XC4RyepO1p5/5xjNpI24eJeBRIv5HqY6nd
 rCCAeCNqv2r/viEFjeN/qPiiPOH4A==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023098.outbound.protection.outlook.com
 [40.93.196.98])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49b9pjjfby-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNfXaa8WvBdFEsl8GjART1cnC6+JczGlEmA2gRNMOgJAUjIRaTadbJZbaGuFcwO7cPZQQR7UHAAq3MOJdfavq/HSAbEJSbO+rKBASfx3EyMldWTm2C23c8H7FQ2+1lkRffr/7eBBRAVAntmlDiwpey8a/zfephipQGdiIghmWO0/8r8BG0yoQHQPjwGffQFwnyKgd04LW7vSxNoPjRRDqk2qEoXST3yn2HtlM0iHwx48QE1YRNEuFXvAE9pR1qK4d/XaAknfAPlCgR3xH/kdgsPvRgdRJtanQtT4M7UyF8dq/wnAzAEWtEvgOgXXjbiSe+vqgd7dWxp96AdZVcpFuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNrYqOnmSKSqge36mAEIR56sWg5tSwCjRrRDrtJUZpU=;
 b=vuRV6Pw66Te9kiT2ZyKMdbZAEqx5fEBVZLquuLdxy+8WNbFSpL8s/ZiHEwnyeJuVMFKKO6PeDp5WYGgaQh4pXxRQvgjCvP7iipM9eFhM0MbVFAO8Gxi2my4/QNtSnZ0HgHvsha69h3U/MGPLJ7TWkxJMcV2pOSPBFxH5ZeW2/ZsAPsGBxcqwhDYcSyWdDBxuMdjbgqOIDf3QLPRbBnZ9VjfIdV4pToO+R7hlAzO4CqaV+/6InB+G3PxbPSIeXDoPRaZftnI29po9yrrbVJNcX5a0Y/4RZxuZ4WbHfAaPJSzbyT97VglL7d7JH40A/F9bBNSijv2hfv3gYFaKWSIotA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNrYqOnmSKSqge36mAEIR56sWg5tSwCjRrRDrtJUZpU=;
 b=OJfSJYb9NDyt2R2DSNOfgsS4EneOnEZimOP8FNOZyhuC8VG/+sMGK2HOdoCsjnHjoviFq8nv0Y/hbhNftoF1QMEidJcHLaxsIhWmEI5CxmlICb/O2JlHm6wMmUBwnFrUUBfpjz85g04rD9tqksT3m7ToNdubTv8KJGnSrmlSCGG+CUkBR1dj9wwxktw31UAm6pHahGD43nDkzZc44XD991mlkRtbqvrghdRRN707NuBCBdQIuatBT0hNSeWYE+CNJn8FTNrK03Z1uLPYDnd0QVuA93PCX3WOrlP83zLriQXwv+U4VC0hYgT55i0q2sj6Xfuk/vGmDJvlatKSa4RtgQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:54:51 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:51 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 15/27] vfio/pci.c: rename vfio_pci_dev_info to vfio_pci_info
Date: Tue, 23 Sep 2025 14:53:21 +0100
Message-ID: <20250923135352.1157250-16-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:205::32)
 To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: d11db84b-a045-40f4-8067-08ddfaa8c433
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/LN/4o9KCVEQ8oMb2E2YAhx7ALApiIBJdC1ZPOTuFzMSq2aqpN2JOyWkow4c?=
 =?us-ascii?Q?DEXUFW7GsefILzEq928qAYH+WgNHT725KsxqoEBZi6zxVsv8oP0hc51Y2ABl?=
 =?us-ascii?Q?ItY7LQ05+fz8dKdju6N46tLhumpHjeWjyVOOb1SPqWx3gtAMVQVPIXg4x7ds?=
 =?us-ascii?Q?3WR40t82VdLTuE0muLD4Dby1G68FcX3/2bd979OcfE+J8Fxg4JUSvDfKFZJn?=
 =?us-ascii?Q?A1NEkMhV+qVbUSZUxlV1zOHOTpWfRab4AmaLzUpg4/zQ2gDY3QDkDO7qQSJK?=
 =?us-ascii?Q?Idv07/MdaXtJVD6O+mJ287Y4Bx+sWbmFS2j4dMUMXneb4LKH7OnS6T1LeL1D?=
 =?us-ascii?Q?R7eSFWOf0/FtdF2dv71Lx5BouWj0kZMp+BwhVCFyKIBer8CWqMNeUkJU5/53?=
 =?us-ascii?Q?vcBuogFQLObFqdyLMK5x+AO18v0xH9329fsvZ+wHTCNuPs/dejGo/459YbpC?=
 =?us-ascii?Q?IQ166BeabUBahHlrvWMiG3+gkneezXQ+qyXGejWwBTcj7FU41qxI6V2eAc0o?=
 =?us-ascii?Q?moxlr6EElGCzwEEXrg0MdGTu7dUcfuBKTOp6oRDb9SSLnzcKqG3m1tuf21dM?=
 =?us-ascii?Q?8J5SU4OOH/kQK4z3nzcTtyixFgf0Gjh7C1wQwu8/KzHgPC9ulXlmDXu6Zuty?=
 =?us-ascii?Q?nAqFhyWhcYSNqXGpmKSRz9hYJ4smvUJyFr7S4zOIapuiYLpWHk/t8+uXt/o1?=
 =?us-ascii?Q?YArUfIJjDdCUiXzZFmI+lwKRIw9GXVM17dZr+YAEseYXuKq6psJ9A5UZwtWA?=
 =?us-ascii?Q?aCIfFRgYs81qvXTdouaNAwu4cGoeIDYlIWLcUlbtbR6M0FwZe9sCc3jCHznK?=
 =?us-ascii?Q?W9kaUs0YhloEQ/UpGAuZwmVTwrzbxXDL6tP32icjc6hwFm3A8e+d0fes6lV0?=
 =?us-ascii?Q?+5Qv+M1VAUDhc+QW3iPFA5tJLtW9XdpQv79PnjT+QbxmU8vnpqhlUUTj4zCd?=
 =?us-ascii?Q?/YMtvicg5+puAS1yx5WIi3DXOVS+uOI7r9VLJz07xKXwJaf19K9Uikt+hvnW?=
 =?us-ascii?Q?lg/plnP9tHJSv//BhNc/wCx3gf09UCxBeeUL4ciqpBTTMq1dlx/qLm0Rnbo+?=
 =?us-ascii?Q?uCNmoxPZufi5tpVxM0WdvT7UPWo4LLYC67WlVOoOhq4fOhQM6rbU2XHeBOl1?=
 =?us-ascii?Q?KYXfgDRpORB3RyVV33w/rRFAixw3/eT+TwotQfocSeranRoykRRSq1oVVjRE?=
 =?us-ascii?Q?GlxW446A5EbW9jZFw2uvZ/pPR5iJLl5LvKD93btcYURFJiKWeZsEab+IgPcp?=
 =?us-ascii?Q?NAErP/frPwoOftnjqBEXhBRqH0gmE32FtdwEH4qO1hcWGB8ifAL9mCYx6ofF?=
 =?us-ascii?Q?0U0S35yPufm866+rIS7ojCqXnH/MWh1orCafRX36AeAN2qz4WGLgmVx0TAKe?=
 =?us-ascii?Q?uE5OmyUUoDaCXrij0uZ1612g7DSAOIqZQCx+a1XZcI26ym6OVdi9N3glQDMn?=
 =?us-ascii?Q?6G2jcBomBeA/ub0lgUuySP3FaUN0QbwnuSgAg2bYyoeUVkQiozNKHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VrKyG2SUR60VEEcB4DFiSQ5WerkRTGO+WFSO25bls0/KtwzfZWi00k2c4YMc?=
 =?us-ascii?Q?G6IVvykEEu5DKK2zN5MHsGmadIIc0xprR53kj2bS6b9EU1RI84EPwynXFeZP?=
 =?us-ascii?Q?wMk13B/UxSvYFu42SxfstmuMxueUSAuSbXckaXg9mQWJemyUq/Kl4c7xmrmq?=
 =?us-ascii?Q?aa0i3Ip1+/4Ag6pSi15I00KWxWbh61hJqgR0EwGNvJ0INqG3AcUxr3YoaTsX?=
 =?us-ascii?Q?nc+WLcWI/j4adj55oE6L5qQdPJRmwFPIkN0e0/jKOWM6enFAhShrj30ajgC4?=
 =?us-ascii?Q?v+vrZROamI/BRdPadLFPARxoHM+MMFC3nkLs8lO6xN22w6Al57ZS1PzG6GOU?=
 =?us-ascii?Q?apuXeMFp4oKCk1FwQzGzLLVRZh3PbIqgxEutgqBEn5bRGNyi+wKsL4tskkS3?=
 =?us-ascii?Q?7y5lU0XUSU4NnC/tsMdcb4wU2/itHSoMS7/agzIrphwrIRZsSopXwswlORMj?=
 =?us-ascii?Q?18KmmHdWe/BfPt6bmJJ+0698tKQRLTGgSROTI9WkBO2Kbe1EEHSdbmElrHYh?=
 =?us-ascii?Q?uy7DHsmJ6oaI7vKTHFRzZDpS/I6BFPF9KUlvqMW058BoVVPKlrmtnkF5nj3Q?=
 =?us-ascii?Q?C/OwsF4oAikolJkZ0RHOoyc9HreJkgfufipXbW711giJint16YESYVUz4uBv?=
 =?us-ascii?Q?nuAE1iZlKhCRywyFnLZ2SLv5JGOfK+d6muTiPfVvMqpNdKKWTEHIEmFSj5sI?=
 =?us-ascii?Q?7xMBisBwb/6ZXNVOQEcI+JMQAunHox67vQYZ5E+RusiOX+ySkRgke7KMXOgb?=
 =?us-ascii?Q?q+s8eVO1v7GDHU2PbzlapYF8YwxRfU3t2uaDbbd5E9TR+uPY0+s4anvznPtb?=
 =?us-ascii?Q?KT4bnPtia1un2yJW/5nLYm9lC2QvVHkyO58vlhgG7epRzIhoKL8XhhcOY0dY?=
 =?us-ascii?Q?Sssm/2nLEi2FTMBPP7LVCqiGJOxZQSVhaM0BbSyTvWmS4L0BYI0DPqvKy42Q?=
 =?us-ascii?Q?ANn/Ju052LxP69gWYmEyfg6VKdlo5O6W5rpFkA+LWYff2tJV4bAl/Ig+ESQH?=
 =?us-ascii?Q?9FVP6v8P4T98OoyZ+CcySerxEs4LH37LaJe2ZLPCmZiEyHPkzpCRHJTQRK2L?=
 =?us-ascii?Q?3ZbRImH5TEQJSxAwcxt6gDQ8JDb0FBhlGD4SHJ1lyGDyZJNeyugfGnb9VDBT?=
 =?us-ascii?Q?u/mz+OLuINdYhcMaxyjJUYXWOVzjeXneKizopc8niiWbP/73oZlSqGdJVcrD?=
 =?us-ascii?Q?sDCiBVkTfkjpf8bPNrw1IcqumNeAOtTSM9lOHoFus+jgMvAwTDuhh2h0mtLn?=
 =?us-ascii?Q?LCYSR9vxUu6ckJeCUOtHJhXZFqy+DtpKw4S4UY+hOU1fqTUv0Xx7iaxgrguK?=
 =?us-ascii?Q?twXiDHNZFOm/1Au2eg+vkqvPhr7Qrualcp2552rp9PQDk8hO19mUVAhxqNEH?=
 =?us-ascii?Q?IPROYu60l3X6bgpRcg/CoIxqM1LbG6aPEL0v/gFZ/MN6cTt0NWVNpZWpqryZ?=
 =?us-ascii?Q?G3cOG60p4rev8PlILOAtphNVMBHvSpGZc0FmJvEFDAh4fMW8yrbzcF4dt/Tm?=
 =?us-ascii?Q?ll6r2k5XSDBbnjMUjJZ6I1O1Duh5OTBeN5Qh+cJXy1UMqgC/QVrlDKPxpv7m?=
 =?us-ascii?Q?4kKbnyf2aRj98zdDQfcZiFdhD2RoNdD8Oj8NB8U8EEw7E52pvzI6dpBI74XL?=
 =?us-ascii?Q?lZGUNr3Nj3Vy/9WNSUfeGM1RGykpzi/1v3TYsTOObDbfIpHg36F3bJdbQ6Yv?=
 =?us-ascii?Q?eyZWHw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11db84b-a045-40f4-8067-08ddfaa8c433
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:51.0388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZgMXv4oNAoSdfXp5/w3FK1i/OYYmHoepO+wtFPlHmVRp7ZtR5i890d2LBmGXG20yGXfqq31wo/yFEC+FlytyZICkZI8LB7EsW6dHcHqWqNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX3h0wg8aXp6Y0
 SsLAxdEGxsyCXEXmi3pCxSYiGwwa80ZYV87O4FvH5l28sshHGfFNXbT8B/HMR5FAJ8at0+ZpcNL
 cMQnrVa/G4O/B8v9pzEonks86rofvkzrPmNf+d0hvXHibw+3pWaq4rGCCV0rnLZP9SUD2wOfkzm
 niTYjCJD16WSS17SqmX0CRxpZ1tk+/K1tm3UHDbx5w7jrUJOUHnWzPOPOs+2p2sie0J021eATqn
 CU5OVtq5YzyC0v1YE2yo/yRtSRdybdg+m4D1Wod+WwkiGzVjc2QejP3sP/hVpRc8UZHB7eDNDKT
 1fHKJ1akyUsXFWEjNsL0I2BT1CVWnM4KbO/NVZizXeEwIuvqDGamhe3CImkpQk=
X-Proofpoint-GUID: ptWYgsvvyCdkUl7_-Us_Pq6GqX6SKXn_
X-Proofpoint-ORIG-GUID: ptWYgsvvyCdkUl7_-Us_Pq6GqX6SKXn_
X-Authority-Analysis: v=2.4 cv=LOBmQIW9 c=1 sm=1 tr=0 ts=68d2a6ac cx=c_pps
 a=RF33hWjtojM2TPqP3ubyaQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=-an67RP_g-7o1LT8KO4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

This changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3c0e678723..6e8b872275 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3916,7 +3916,7 @@ static void vfio_pci_class_init(ObjectClass *klass, const void *data)
                                           "multifd channels");
 }
 
-static const TypeInfo vfio_pci_dev_info = {
+static const TypeInfo vfio_pci_info = {
     .name = TYPE_VFIO_PCI,
     .parent = TYPE_VFIO_PCI_BASE,
     .class_init = vfio_pci_class_init,
@@ -3974,7 +3974,7 @@ static void register_vfio_pci_dev_type(void)
     vfio_pci_migration_multifd_transfer_prop.realized_set_allowed = true;
 
     type_register_static(&vfio_pci_base_dev_info);
-    type_register_static(&vfio_pci_dev_info);
+    type_register_static(&vfio_pci_info);
     type_register_static(&vfio_pci_nohotplug_dev_info);
 }
 
-- 
2.43.0


