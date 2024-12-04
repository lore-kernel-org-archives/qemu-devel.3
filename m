Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D76E7716A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 01:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIeOQ-0007I7-MK; Tue, 03 Dec 2024 20:41:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.mackay@oracle.com>)
 id 1tIdhJ-0002Xd-0O
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:56:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.mackay@oracle.com>)
 id 1tIdhG-0007EE-W8
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:56:56 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3M3NYP002096;
 Wed, 4 Dec 2024 00:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=corp-2023-11-20; bh=BbUio/aXlGAkSb+L
 lzdGLbShBwYQNCHb+sj0QdYt02w=; b=eBTB5D5B3NDhxFmSP3KQjlhFLbWYZKvb
 Y/aGQtZPiFW6vY3Gt4/n6nFBXUV5l2hdsQF3cRnbFQ0BrrmoKi2oy27TkCxKrdrF
 /sC8SCxqtZAXid3C7GsJgCk0jU8zZcpdVTwuAyjPcmNleKcAWzyYkktIKM/JCj+U
 WqhxU7nQSLkiz0jAF3NnIkuWg8RMb/kQP9kaq+cKzciqW543WwXO0HexuGaw5hC4
 HpFfuu3v0t9aTKwEO0j4tkrgsvYPjpv0dO6NQKplXDEQXTlPw9rTrJHyu33rWD7V
 6jpowIQg+ePr8eZdwVTWy2+M0jiGveEO2V0RRRXi/p8lhk5vmDS7iQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437tk8y6ch-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Dec 2024 00:56:49 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B3NcFkm030948; Wed, 4 Dec 2024 00:56:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 437wjd9thh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 04 Dec 2024 00:56:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgyAvX2MNNfubrhhuU35WQn59ZzqPtz0lSycGeaSDom0nw/DPcN5iW912nDIgu1qzAl/7q2f+c6o3E2UnN6p+fY5UslFKgZZxvMl+w07NKsxJLcKVNLpe/xV9d96qt6wZbGJKfxFbVRRQ5r/HlnMSm9kRXNIWuwjf+HSv2TgIcESJS9uJLFczWSLQeghhV8PbiKqadpmpfNgizoIUQ4062leVc7I7LREKwb7LylJIHf6aMDgagPQtDeE5ApWJeBPB3KB2ad7FfFKIszjKtyXlYBUDQEe+0fRJJbXzhm5QdomdgxITu3+IBkXe7KirBtqfZp34YSAiCNyVOg+wRFSRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbUio/aXlGAkSb+LlzdGLbShBwYQNCHb+sj0QdYt02w=;
 b=uJjJyDt+5wDShajzyqY+0+Im0wn/3m0TJDZtLW3KrLRYaGl2SrHAWq44b1RIGlexxqhfhUDyz6R/RxtAUCdQWzw82UUF+LDkjT++bnL8kmS7AKgX2+WHDpZ6NsL1/YDSuM0Qowusyo5ys4nx/dsw9kQr0rCopkaNN/s5WyDRP969/81kIpz+8c3yHToMgKs4Gz0UEVq1FpyA2q0BVtbe9WCadNUc7ge1q2XUIKOyC6NUu81elyKuk9P4UQWlKHGTVKfYdkPoiIjxtGLK5baWxfjWIBjwWoTFre3+opRIL6zNdrn6/q7ILU2ky82v7KAuA1TVNW/jovNlVQS5aeyoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbUio/aXlGAkSb+LlzdGLbShBwYQNCHb+sj0QdYt02w=;
 b=ZAg8JwDbQee48bmomGuG3yNKn2qI7NevrccORDao8HQvgwUwVuc0mpykQuV17WcfoDixp3dSj84gooZ1ivT+ziOI5JAB9fkyJTmPwWtWAIx2bZHODQdwVYcgObGtolXleX4OWAGeCJdoE/IS4Ke2NTpyrNXgE1aJkaDYFGADCMU=
Received: from MN2PR10MB4269.namprd10.prod.outlook.com (2603:10b6:208:1d1::8)
 by CY8PR10MB6513.namprd10.prod.outlook.com (2603:10b6:930:5f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 00:56:45 +0000
Received: from MN2PR10MB4269.namprd10.prod.outlook.com
 ([fe80::f430:b41f:d4c4:9f9]) by MN2PR10MB4269.namprd10.prod.outlook.com
 ([fe80::f430:b41f:d4c4:9f9%7]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 00:56:44 +0000
From: Eric Mackay <eric.mackay@oracle.com>
To: qemu-devel@nongnu.org
Cc: boris.ostrovsky@oracle.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com
Subject: [RFC PATCH 0/1] ACPI: Fix missing CPU hotplug/hotunplug events with >
 255 vCPUs
Date: Tue,  3 Dec 2024 16:56:35 -0800
Message-ID: <20241204005636.18705-1-eric.mackay@oracle.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:208:23a::30) To MN2PR10MB4269.namprd10.prod.outlook.com
 (2603:10b6:208:1d1::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4269:EE_|CY8PR10MB6513:EE_
X-MS-Office365-Filtering-Correlation-Id: 1beecf2e-2c1a-4089-eca6-08dd13fe85de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zDcdxFse1q8q9UiiVGBQGX4YlqF1rXJ5KIZ4vKqvIu9lru7nF1achQVg1qF5?=
 =?us-ascii?Q?nuGcUuBTOdCNVYGYOtln/5rmXXRHUooIK5qWA7gWRAwf8xjmXMu8fgRpghnm?=
 =?us-ascii?Q?BisHK9rlep1Vf+QvFTn/TCcrC4Etj/XeOCJPEcuiPdPhJF7NlJMMT7t6XVA3?=
 =?us-ascii?Q?kv/nzQd98OTXhczpQpnXO/yNXmty8h+CwjLj5kikNK9QNLEulQ0GBW+7uCIg?=
 =?us-ascii?Q?IGKBfFRwUWJckItg3kL8eAhnYujuaeHpfmUTSPJCoZetUAX5gPdau2KsfBMZ?=
 =?us-ascii?Q?hIS6cTKlf8g7U+IHzBwGU3p09QC0ClkjY4OPdCrdco8UQ8HX6rGnG5SchDlp?=
 =?us-ascii?Q?IbaqolhtWr3NVVocTA2EYJsmguYBspZ2SK2+E0v0z8urnqkF8ms2mp9+R4Th?=
 =?us-ascii?Q?1slY6E6XN02f9D4yL/sKo/T96ZHXQKiQnVpKFzWEd3lBVmag6+wAqEd9vu6C?=
 =?us-ascii?Q?pe8P7tDyQmFX7BDsJliWE3zwXb+j8Cmc4AsHHCDfi40Ah/zwW2oAmkHRsTQ+?=
 =?us-ascii?Q?xHpSUUhv4UqakVMdGf500K51HTZ8xg3DcsTajUC6q3e6hF54bhtfSxWkX+I+?=
 =?us-ascii?Q?UJ7WmKMAFXY8E9PAR+bbYnOcopk4/zhsPVC9TtCgYHlgTG2VWGt1t1J76cGW?=
 =?us-ascii?Q?gtgsodUQ4oUytLrujo8PB1GKixYrmkjs0FslV2ByvxLUCmtWBZfOJkh6d4xh?=
 =?us-ascii?Q?0WAql/o5tVsVLFR6rr1THCSkq9jCi/FaeegOXlrRoLjQortANSlnP0nZ8+SD?=
 =?us-ascii?Q?8uq4oilcaJO8Z+6eUJO+gtgxFIec/Q/66r9BY9d/e1lPYNZo9Smy0004nD4d?=
 =?us-ascii?Q?EXkapvSVe8y3BOSD/hqCAl6XcxPMiUm6D0tzdiM8Xxj0gup3R9HDC6FuEXsl?=
 =?us-ascii?Q?aWNeEvkhtOXmJ6TOkjk8uWASNWaijFfqnmf+zmNLvO5tE9xj9hh3XYpOxmzQ?=
 =?us-ascii?Q?2pdCRDOy4Kl6Fj9zdTiMTbNr8JLfJHW+4tk5mu49xq4xttjHoCylbcDPQRJF?=
 =?us-ascii?Q?rZz3FPWw6WWQAjX64Hbw9ztkojD5wqKGI4c/fg8hBSbyrpvj0xS3EGUU0m2L?=
 =?us-ascii?Q?d3pehThjwXb5a25xSqUeZclSGfCFgHKSVpaE/1+SIvBVESUcT1VnB4autwW6?=
 =?us-ascii?Q?ALT+zLSlj2tGggSvQ7S3oCEPZniMj2D4zeT9tgs04kUTfQwP9NYn/8TpXoTB?=
 =?us-ascii?Q?Lt5ijVt6WOx9FWrSDSxPvURsqwLxyrLlLHPllWDYVS6Z53yz4OVO32ycTphq?=
 =?us-ascii?Q?2GHwVC753rmppq0mgmhj4rBDJH2S9si/cM2r9bOF8/vF19tJ/wiym6nof/qo?=
 =?us-ascii?Q?+6kaBmotOzuT+y/KqDR9jFw61f+ys9ITwa+7MjJzIlwFMw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR10MB4269.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QBFI7OYLJUeaV9JHiOmTt8AM/A7SCp8AOk62edyyuUQ2JFYr/UMHCy72kKBl?=
 =?us-ascii?Q?7PZsNw6+QBTPuMosTS2ljggQdGTkkUXSyA0iMBrzdScw3XJ8vodp9x0Yfbpi?=
 =?us-ascii?Q?F45Vi73RxO1vddVy/j5CrCkF/o2j7nQoxvO8huj6rUp9XBElP6Dy0qQzyN+y?=
 =?us-ascii?Q?wvGrnaOtslqW8CZjwzwBFA4S5du/Cqh5NrP7PEf1HUDjEacwI8C0T1EuGNxt?=
 =?us-ascii?Q?+O84L9WSL19jqlOsyAzC21WDDMh27Fl5zGo1a1jHYqxj3U2B4nu+IYyfRxHk?=
 =?us-ascii?Q?pygv76f+0s1nRRSi7Gahz8Bla/cY780iEx77I4S359NyyVBtLlwbQ3lv+Buo?=
 =?us-ascii?Q?OQzd6xSTT47vU9QjvZVrkj99kOlOapuUPAC456tBhRmCWp/DfSgmm0DRXx/N?=
 =?us-ascii?Q?9vd9S3gFJP+dT1YL7mb1bnk1RZ4CXfptFRQbO8+dJt1Ykud3eaQb9C/HdMOM?=
 =?us-ascii?Q?IYh7q2ODyOT3qAnu9LFI1Fwnz1haYDhjEufzITk19LBhZxe6yCfgy1k60bsH?=
 =?us-ascii?Q?Ks6b7j+xR1RlqmQXXNeHDZsglYsk7EYI2xW2sO0Eai1wSxMY2J057tGcwGSq?=
 =?us-ascii?Q?HfEGlq8XwVcp4VExleXHHePdWuq6V3Cq+6BX1UgiBj9HeRvlvP0jHI7nBzw/?=
 =?us-ascii?Q?m8lBKpQaJc+m/h4YPbtH1QH/YAfEGigw0E9wz3CkboopppCMsS6zDg1VzGkD?=
 =?us-ascii?Q?+Bp/CxGG/Cm0cdQAtQXQ0qGLrLcWWti5TggeHo8j5Bg7hujC4Vpi8VERT9cN?=
 =?us-ascii?Q?mnIq2HQoysLV9rUe5xNfMlYQO+TcsJhe4UQl0RjbKvMKFZJgnQytHoPH4cIW?=
 =?us-ascii?Q?YQBmIRzxu12MkjP78co4Qeyoyw08+I4MCVpOFkRcovIoN1BT28Jc2EokwRa2?=
 =?us-ascii?Q?x6KvRp8S8SsPRLbFyxKV9LB1bCJKzGGA4KgrIm6JVyOvejRotkL4IEDYJFL1?=
 =?us-ascii?Q?UxX+/OnBFFnJcWn3KYKrCvzZIOp7KJ2E5TpMpDRWPO7jmv62yxOTYzyPpBX/?=
 =?us-ascii?Q?ejuJRslaCPr17eql3g1T9olHlNfXgkIk2tWQp55oUybG9XHLI2t962Kwxd+w?=
 =?us-ascii?Q?sGlcqE6Q1bPSYsNNk5umRzF0uS0cHQLUV1toy9Sgvqi0cLZWsqExdepQtjrb?=
 =?us-ascii?Q?7f/kPgzJipmEiRZ5auLg60SQI6Vi07CpMyiLeukHQrIO/mA4xo5xmCBKBN2y?=
 =?us-ascii?Q?wk7poLpToQQLQJ3qDU0S21HacNJyET+cOncVjfFj2sZHjgHopV6G+xEnulOK?=
 =?us-ascii?Q?LWGZ+1qCCDjNpPCbUAwiHAL+cgZwTFGuc41/c93xeMJDsPKEo6qEEWUNuz0g?=
 =?us-ascii?Q?mUKJ7TTD22HVPMSYwvk1q8M+hL7WMpqHLYRaiXMDF6nGlWvfBzIVoOSax+Vk?=
 =?us-ascii?Q?Jsq5wkZJ0EElyYqL/kTcaXnAvrk0nmLW7tAS0OhfVursBjJJmaHSVQHvjMqa?=
 =?us-ascii?Q?HOavEljF+o3/Nm9KOp9ViDWRIlzpy8IVS8eQQ5L1lNfLknY2Mkx2MEryyUSP?=
 =?us-ascii?Q?6klYnuTAvafnZ9Tm/gf21LfM0e5+sB+mAZFrhFs1BYR6Jo5pabj8haGd0cek?=
 =?us-ascii?Q?g9Fp/z+zZsWND/dkeRp2++pyfdF2W6iFYxzSb65n9N48afupdfH42onv02F4?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rsWRT1z/q0RYVo6OBl07CPDLweTn1nDlYo3FtITHG0tTiwZ+yxlc7zX4n+wrmzP8xXEY6h28Rlq1HdHahXCLI0opWLGO+Z2vIM71iKS35JbusHqa27UD98oG5xvy/BBTzXfF3wnTulKUsBe4IpEmXDyy1ah8A/m3d6rxvebPH7d06Z0l7nAKldJxDL9TVzKQ3L/DpM5O1jQOq7AtiJBrseEJOskwCTgVp2ycn5zrp3TvSfxSnatS8PFd30yqCqtmxUY0A60rP3bMgf+7eH0sJUCBPwsxYqL/lSFoiHYTfp0rn1nhwbL2Cf8hjoyeL7W6dXNZDAhwg5hhNwo2oX3ZzLOXCybMIdy9HaPYmMnrx2WUBVBlceCXOcN9dfwGWcKH6s28Tn9lAnCtqCko0VZ9Yj1y4IHy5//xG01pKVpjPBNNcwHRvET+Iui9Q0HMMIxHI2x6e3SKQkWuTZLF0ztMFm2rWUsPs9P4QaUFhqcYQqqu+Oco5douL7MG/L3kkJI4CJBCA88jGIBGweuyxzpH37RYrFhpNZNPjh9ywgs9qED/otgm1PdviIkz+DBSfYvb4cSH3L1euC6jInvFvFGzSiEKUXSPvrosLnCwFJAlh5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1beecf2e-2c1a-4089-eca6-08dd13fe85de
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4269.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 00:56:44.8829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJKTrARsnfmcB5LyK+FV5EKLngdtJZmHxcYr4HoyQmq0/HLwI5AQuen4zovKEkQWLtrGhaEs0x1vNzTH+ta5MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6513
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-03_12,2024-12-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=834
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412040006
X-Proofpoint-ORIG-GUID: qgccuRzUr3u7B4RtEY_7sd9RXbQf6qPg
X-Proofpoint-GUID: qgccuRzUr3u7B4RtEY_7sd9RXbQf6qPg
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=eric.mackay@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Dec 2024 20:41:29 -0500
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

ACPI hotplug with 255 or less vCPUs can use the legacy CPU hotplug interface, which does
not support hotunplug. If it's available, hotunplug will use the modern CPU hotplug interface.
This creates a situation where hotplug and hotunplug are using different interfaces, but
the end result is still functional. CPUs can be hotplugged and hotunplugged at will.

With > 255 vCPUs, both hotplug and hotunplug will use the modern ACPI interface.
There is no priority or rules of mutual exclusion defined in this interface,
and the behavior in the guest is implementation-defined.

Unfortunately, it is possible to have both a hotplug and hotunplug event pending
for the same vCPU. When the guest processes its pending events, it may see the
hotplug but ignore the hotunplug.

The most recent event is likely to reflect the desired state of the system, so
ignoring the hotunplug event in this scenario is unacceptable.

Repro: This can be seen in practice when a q35 VM is started in qemu, with
maxcpus=260 or something above 255, and a few statically allocated CPUs.
Example smp line: "-smp 4,sockets=2,dies=1,cores=65,threads=2,maxcpus=260"
Then use libvirt to add vCPUs up to the maximum before continuing the VM. After
the guest starts up, delete one of the vCPUs. 'lscpu' in the guest should still
show 260.

The proposed solution is to enforce mutual exclusion between the hotplug and hotunplug
bits in the modern ACPI interface. Setting a new pending event will clear a previously
pending event of the opposite type, thus preserving only the most recently requested
state.

Eric Mackay (1):
  ACPI: Enforce mutual exclusion betwen CPU insertion and removal events

 hw/acpi/cpu.c         | 36 ++++++++++++++++++++++++++++++++----
 include/hw/acpi/cpu.h |  4 ++++
 2 files changed, 36 insertions(+), 4 deletions(-)

-- 
2.43.5

