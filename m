Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D0FCAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1oTO-00026O-3X; Thu, 25 Sep 2025 12:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1oTH-00024s-Je
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:05:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1oT1-0008Jz-D4
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:05:27 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58P8WVjw157181; Thu, 25 Sep 2025 09:05:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=Yj99QF1lsVm77
 Pip9XmUqB7dfGGz1tM1Zm9H891uOgw=; b=PRxAbHUIOgU41yZTa5CVgIPCtAm/U
 9fy7CbYitwuTK5g/8WxhaqEz/nasWMC2HGth8+QbHOuDS4c6hWtO7EtvbliJlXJF
 My3gMInPaAR7G6CY4fiqTAQPgMXOiZkKe6LHxQa7a9iCFkKVKRm1+VJF0A00rISr
 CPGaKPHXq+Cnmz7muXCF+5gwB+DoZEvUyDg28SXxO9dzxAESd845DhWbI0ydAqJV
 8YC7GzQQFcikMyO7voPjZHRwCvskcxVb0eXOj3RbRtZqi2emPFa2Cv4Yu5OmMZfA
 n2Jwm2qLmZDevmHjp8QleT+ITNG7QSf+w99+2ZrjuKypYuRZk+f9GIP8A==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021109.outbound.protection.outlook.com [40.107.208.109])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49d2aps305-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 09:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQ3XyxhhT8ezng9Rb/yQ+gcmGXWfPWtlQUjkUbXE4IBz4+HOIwzGIG/Sardn2o6WgkQJCurYqggkZNb7HKz4akVZbP5mw5pjCPKmaPCX2GY1tKN9cEF+D7BI++axYSGC24H6eUNIAt2baXH5C9i03rx7JpAKcxwHGUlI97PjE9CXnW+od4ekMx4yKrEUfWXAjsbhRuu1tLppcuRK9Lo42/NRycaTtKRcycDRJy4erXtQcyNW2jBzu9N7whUweiH4G3CNe3AhHTk0rIK9rrItEw4gDKuE6YYEtLLJqMMhdacQpMrNcUckcW5p5//vlCW9bft+dtIniM0H63fjL5hpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yj99QF1lsVm77Pip9XmUqB7dfGGz1tM1Zm9H891uOgw=;
 b=zTBJIwRmCbd8hmI/03QYjxeDb/zxiIZrfNtruUQYLIq2eroEEScz2j7G22j5Yg/eAE4cb0ixgTfr/UAbrNx5fGDg87lyFMH9y3mK3vijBAzF62XNaDpsYzLp8Rh2ITeOUp2IPxPTjfqK1pUEN2bMZwKav8AhB+hEy7QTQ3yqrwHVsGCvAH7mu+0EfW3qZHc2KTFTzt35GrYxr55fez9mjMJI1TKtyMJ7XMmrao8g9RduDxd6bEO0FA3G+921f+/KITKb68NMk9/q3H6iAZ3pg+6/nK2xE4HKdca6FS9mZj2mBi5q5thboBc0AkRw4xwRxMrCJxviXCHhiccxcMaBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yj99QF1lsVm77Pip9XmUqB7dfGGz1tM1Zm9H891uOgw=;
 b=gYxLR6RFIppLoKeOZQc3ZEwALM0DAy2gBzPciLKU/lGzX+Ws3BbYy1zxtTrUKyVZZrVtsqVPhmFt6qqvwkNKpojxBuNcY4XmtH928JJklpHQdxAwPSibQQBKyHo3NCqAew6urTha2eFIx0/dPFfpxTQKwZKC5335ncobQs9Rw8BAxTQ+8npr2BH13Hwa9df7LrOJfXQOlwTf0BV2zl4o7Xad5wFe3mwsAdNhSerfbG7oxqhYGBLSVSneELGuuzuAblZcdMbyBSt48NP4ZaVXrjr0lyFfdG6BLY+HlC1uIOlOyrvvFGuiSWrToxTKqSAvPWX71l3ZPU9vgHQcJnT4Ag==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW4PR02MB7283.namprd02.prod.outlook.com (2603:10b6:303:67::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 16:04:56 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 16:04:56 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: imammedo@redhat.com, philmd@linaro.org, berrange@redhat.com,
 jdenemar@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] isapc: remove support for -cpu host and -cpu max
Date: Thu, 25 Sep 2025 17:03:18 +0100
Message-ID: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0514.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW4PR02MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 50653cc8-1ec6-41c2-9397-08ddfc4d456a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aBK0xhyz98IbSbvjHcyTx0W2bD6BeOIhwGdFY3VvEfRwOs6sNCQqklAvUi2A?=
 =?us-ascii?Q?V1OCnL5Wdpz4vHGQq4asEMkWpQhCw4r0Bm7wI1Apz4h+SyaykgivlFjW90gL?=
 =?us-ascii?Q?r2rmSwvhuW4rARmATIziTQFblN7zBUbirfcM5ceTT+nOJQuFfm4FXaQlQW1r?=
 =?us-ascii?Q?e38DbkAxKYHNTjkqX/joKila9c78Cmvc9vbaCSS6ciuxHSVQBMUGSbTCHRrN?=
 =?us-ascii?Q?+13LyVDm1RGudrqFNSQhet+A+JEakT/Wny/7FTrV6EWyc9HuGrDq4v3TS+cs?=
 =?us-ascii?Q?fL9B74QwlJMgnuuqAQvTODptfJ2/+7f0MYM1cQf3b/lNS8ShStprcKAZw9wa?=
 =?us-ascii?Q?HZ1ga6/CQBpTXeuVqt4nDDXF+mFwDBDpPQFeW+fI+4ftFdUo/GL5qqBK/LPn?=
 =?us-ascii?Q?ZiTu8E6bgYwoHZ4WIELmgHu+IBNJwCFuhg+c2KTs7hPmbRy+RRxbBOo2uNPX?=
 =?us-ascii?Q?4G5Ir4Q57FGi3kyGcOkijJIB6uW0a5GvMq9L6U3JvuFaAOdB0Fqlqu1sipzq?=
 =?us-ascii?Q?IHLTuuNjem+gqVYmRaV91UtJ9x/TBa3z3E4elnz5hIM+j1gGE57tccZxlITj?=
 =?us-ascii?Q?7uc71nZ2AcemGZqMiSkjzd/2oG9sUC7fRz9D4gyzrXC1icMWAVRwEbHizsrV?=
 =?us-ascii?Q?eoATrBdiVd0+KbqygqGpcfETLITwPJGkMpwZrh5rNdulU6XoY8MMMT7NDMNh?=
 =?us-ascii?Q?qUm84b3wPshp4BPmbxSF+MonAd4Jx8dufvapk2oh4EX46M5ht92GFHuOT3j5?=
 =?us-ascii?Q?TfLB+I+cgsO9V5FjluW3mtJu7sRqdnR4Mj1FomnsifTTeRs4I++Tyjxe8r/m?=
 =?us-ascii?Q?brR0GU1KcHnJ7BJn2EQ6P/8U5QndHaPzUpEXP5eaxAdpNQvmfs5kRzJVo5Gg?=
 =?us-ascii?Q?QQxOHYSYxh95S4H+CoNFA1Juu/280ITDGUACsyccZgW8YmlQ7qQLs0dPXszD?=
 =?us-ascii?Q?W21o1qCU5lVfBqrrPZVRTf84IxOxRvlFBJKVdGwnN/UzOxmYt3nXhh+gfjhw?=
 =?us-ascii?Q?c3htpYli8yQoZH4RQ09p39Cj0lDubPBI6tFHBMJRBPMOpUF+A1Muu+709qsV?=
 =?us-ascii?Q?CH2csanSLhEeJZsa8M+GpxSkmq25ykum+hFiKdDoY/RBN982KTtbolXvFvqQ?=
 =?us-ascii?Q?CmXWemFaAv8uaMUbV+2zKJuW+2mCprhqzL4nIQWyMbunuwL5WA+1rtTka1EI?=
 =?us-ascii?Q?02u4KJDGRbNGIYqKa9722+5boCIr1E5LLj94RPmRuNPM2FDhuLf7v5MqsAsv?=
 =?us-ascii?Q?8vSf2TcaGF3hC7X8vZcWztVkIwgeTWy7T6EHCN4pkOvdCkaK0nlIM3WiVDCV?=
 =?us-ascii?Q?EZDHxEoNI+ECuveoO723UUjex2IWrCzbpwVC1I+dUmDf0SL0MWO2vV96g5S7?=
 =?us-ascii?Q?aFfRbe+PdzAIb4Iv8pIQJVZxPNX4DyfVKbxalRg5HI7JG8Ub/fnv13xZZECV?=
 =?us-ascii?Q?E2KyMHHSdB8pzlmv20pemCQ2dQwfxDipI0yi9XBMVwNrRm6Dz7sQp6ai3j9F?=
 =?us-ascii?Q?Wip78hDio0vr7fA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jfKTJAzJaOH2NPYC1oT3qoPHvtvkIRgd2EC5q3mdB42YjA42ukKVNxMKUbWy?=
 =?us-ascii?Q?of9+ioR6rKxVSG9fzEe+qPPui2DTg/FTg7/7A1j30uu/YB9O/cQa0Xp7xA9e?=
 =?us-ascii?Q?OqZSNTob0BIKIYDlhHNY2KA4TcYlNSblNkQwis4YAt+yMlvKUJoffaNtiR+q?=
 =?us-ascii?Q?2OrsFQifR3dsOZ7KfDOS/kdRhBV3apqS8ct6/QKPiZJb1Bl1d6L/kMcAxB1f?=
 =?us-ascii?Q?srp+F7/xfd2n2kkZeluMU6tW4jkmAbKWVyt8mOeJShtKAfdxTdKEx4LHSY6d?=
 =?us-ascii?Q?VhI/ny+at6d+fM0UYqlLDJLKTsMHhZL7aAsfSabHap6q4ZshZIRkbUmUZRrr?=
 =?us-ascii?Q?shxiFqaC/YB2xsedOnvj/PJev7qE4/pxRbeLX51CSIRn1pY/W/9f63Wzt6rR?=
 =?us-ascii?Q?seWJO94P8JWc75iwfjZlFrGMzIXh+uwZk4eyKIisfTSy14BWKhKpFDQ/R8Ps?=
 =?us-ascii?Q?oEjk0597umwHpYYuEEk33LZLHTHZ9cMqZJ6wEm3+zfn8C4iLytMsznPp8ERR?=
 =?us-ascii?Q?Mi/cd6QNp7oaPrsHkL8TFhTMByu8TTnYI1N2yDmTA2nDMdHcONTHkmsnugBi?=
 =?us-ascii?Q?B9EILRuytIX3jaF4WxXAb3iNeo1V9ZSituULkHx6kzMicTKquRgke7UqeVIk?=
 =?us-ascii?Q?4vkCVkf+aBoN7fKAlNoeW5iUfBMPmDVaicC5Gg7MIPBA01Wom3mQ75Mfeb3S?=
 =?us-ascii?Q?sTtl8WCitMs10qgx7m1rT4mLjyWL0N3+9LwXA++1m64a9HVM73Qwr7sQjmRd?=
 =?us-ascii?Q?FKo3zxpjR05QHGqVW9a0mZKXYdVRrywYNSPe4X4x4lucDrazkpleRiqUuj1T?=
 =?us-ascii?Q?GPH3agdfAXM2RPW3QewZRx6mjujt98FtLUCmV1IPCfnFASZPlxX/tYN4AOQq?=
 =?us-ascii?Q?eSkWTdLZYegXI+542UZxiZkKqKNLfrmNPDfPGDiyv4Aj1KGu/d8E14LIVfgH?=
 =?us-ascii?Q?i6bdhh6Emqrdm5tyZsevDXbtrF6cPuMbv+ky23nW8bmL0uODQmDwJtTnvlOy?=
 =?us-ascii?Q?7ldP6sPGAu8BDoaGfsH9QQWwfutihK7j8bObz7PXlomTPMmqi8hVgktdFJsH?=
 =?us-ascii?Q?M5HLap8P3SibLkueCWNe/X/RhEZeiCmnnVaCh+gO6vXww3i/cQC6QM08W813?=
 =?us-ascii?Q?hfNuHv3NziRx1ypPSs5FMaZJzktG6CajlG/60dgpKmjljRW189ZF1vJUUq4d?=
 =?us-ascii?Q?cln881Wfv9N8V4IAAxvuZeakYugmTMFE/AJsTuAeY3QHy/wUIwfhl9ea8b1/?=
 =?us-ascii?Q?flitgOcg40Fz8G98a4w2w78fUiv9r8Itrvm4vG2A69WYtR30OqX8k7N4H1du?=
 =?us-ascii?Q?YZijFA5zlGNfRDmrUCrVEVpmpgKCOqnf8H4TP8PsIMsCZ/ajGLk72svhesxq?=
 =?us-ascii?Q?hlsoP8/irkZTHcfV+7gtKB+nqU2nKmA977ZS1E5AmIO4g5ddQimr5D/Ib3+4?=
 =?us-ascii?Q?a3t1daQ9SthvBtnXsraKWOpUwDolK4lUc718XCuS+Ar/gXKlQBwR0e6LKpYi?=
 =?us-ascii?Q?NFIoc7yRH9icniNcXkkF0GPeCkikxQ57PfPBdZPvUy5pwQF9W58gjB6HYRig?=
 =?us-ascii?Q?MM/acGE90WwLZxb/xZ0Juam+3Y5m66MSc+4yIobnm0yqs6Jp/IVXKTt4fhjn?=
 =?us-ascii?Q?xepiUUgPQkpcNwKXUh91ltCt0kR6HWvyRjjuHTx6srw9076ZAmNPVdar0Kyf?=
 =?us-ascii?Q?4f9JhA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50653cc8-1ec6-41c2-9397-08ddfc4d456a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:04:56.4576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHaHlH44uxl8hEO9hEOo4n2RYhDtAUfaw+zILzWjQzUWOw5VoOGX0418R0VTu7b5W1gr4X1v0ySc/h73xeisXTCMUfEBXL8mtmQUo95uvFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7283
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE1MCBTYWx0ZWRfX9XSca1Xge+2X
 xTt/i7sUG+CQJ5MKvi2vsy2eEQqz5LT4I2y27Gm5z2pffd6FadkbFNrRewyyJQocXMqyag1FzAY
 rmV47fd2yS7dndZ5UI3hcE6ruD2E/IKkpnC3fisWzinP7Gx+K5x9ZbZRCNkyszYnQbwwOAhrFEm
 B4PHdBaXVxEjnyS0VSpz7t2gmtn6uu9o3AZlg56Nf5Nftq9UWSChemZ0aF+Da3DITf5uR97aIT7
 S1kaEzfzn6Axuwh/+tL2EERBTNX5gV0vWx33gCN91pVNNpumhxDK5dEfWMSgHlej2visMOfkWfo
 TQeEpXXr20+0P2FVzRJDjlUS11bkyJq6C0Ej2uPfi3uGXyVPurs6MUqWzuPY/M=
X-Proofpoint-ORIG-GUID: i9I7CV9fslFO0yAh4jo3oeIxelOtXYht
X-Authority-Analysis: v=2.4 cv=eJ4TjGp1 c=1 sm=1 tr=0 ts=68d5682c cx=c_pps
 a=0hJHWFAiWqvHUFm5j3G3Dg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=DpBJ9i9F6Wt1dfh_lKYA:9
X-Proofpoint-GUID: i9I7CV9fslFO0yAh4jo3oeIxelOtXYht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
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

This series removes support for -cpu host and -cpu max from the isapc
machine as suggested by Igor, and then updates the "Backwards compatibility"
section of the documentation to reflect both this and the recently
introduced 32-bit x86 CPU restriction.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

v2:
- Add documentation change suggested by Markus


Mark Cave-Ayland (2):
  hw/i386/isapc.c: remove support for -cpu host and -cpu max
  docs/about/deprecated.rst: document new restrictions for isapc CPU
    models

 docs/about/deprecated.rst | 13 +++++++++++++
 hw/i386/isapc.c           | 27 ---------------------------
 2 files changed, 13 insertions(+), 27 deletions(-)

-- 
2.43.0


