Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0141CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13Um-0008U6-Vk; Tue, 23 Sep 2025 09:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Uc-0008L4-KY; Tue, 23 Sep 2025 09:55:47 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13UZ-0004G4-H7; Tue, 23 Sep 2025 09:55:41 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N861b11769412; Tue, 23 Sep 2025 06:55:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+yiHy97dGQvhuHInhSCoyHUhkfEkznqmzVStGdVjN
 j4=; b=qGeJNKbAQagEjui+PjMjUFWYUxSWogWUYQtavnGOsX7DEfjADW4cLOPqM
 a7ntGrr9661kvDAZtuXdUaTndabR4XvEz+nLkIzO/74PEvx1lS0lWczbLALP1w3q
 /l+rj5xzCJ63cgGNHZvFa0UigDljKUs8XFeNn+1nTBkZVfyub8q7/64ibxtJVDGO
 JBrra/GQCd6oyerLiuzaH0g4uw5Ncg07RQ5KZwMiZVR8S+ErR4APhzHkDNKyXHiz
 a0rUINB+rM/tvStT3mLw+uwCDC99FnMJEpqlpEtdt3RIntQod/td79h4aCJlOQvW
 1Sm3sDR03DQIHfeh8vLsowplfgIFw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020119.outbound.protection.outlook.com [52.101.85.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 499rkrp5x4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woLcx5GFT+/GJoONaa0Wfu/TAtCxnt0qnI6ICuuppsYyTQKsSs9JtVNPV/dfSDCOdiD1oWKtFsYDyYCklJbyVZKeG9nCZRgz1vyOGtpyW2mQOSsKden95zDmzqLmRZoW3zivqvqJeN1Acd4b3830E8OyX9xR0pSONTiBMCzKZI2gwqDMJfbj7NfXchJDTWjo/KP2ffXemNNlpZUYNDfgH1qp5816w2NngZ52Q9Jz7htl02zqd6Ai1lE/gsVSUgFHlwp/oWsmPcfBCL6heE6vlg3wAd1CVQdBjkGvMjGIINB2eNIcCaOTtVSNablhGU9pbuSOMlYzNhrgRkovVKPfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yiHy97dGQvhuHInhSCoyHUhkfEkznqmzVStGdVjNj4=;
 b=thYAtUiP/NekKVdVauNbvymQ/DsbnCoF5dF4PIyKh926HnLHHNuAjFM6QSvhyu08NesBOcLTa9aRI15sIBGQAdW+4pESCtLq19KskRkQ/QGOO+QP4RBXDaZP7yL9bvelyCPikgcdqTDKy9idkgBTe82QZjf/XYps9acJqRcjL/wWYSCNzFcNrPyMJNMgk3ZsUDluZgKHfSwq+VEg/CTSZtL1tjZmfVbdpCCI6L04b5RVkE0n9hQc+rbLtSb35GPaDDZX+MoNFIbkAorVkoAgHTWS/RnoPWVJ8Ux0KyAlJUGKtBKTdBDitICtjQyHnVf+v8EOayzwIb7CkfT9l31ibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yiHy97dGQvhuHInhSCoyHUhkfEkznqmzVStGdVjNj4=;
 b=bqWwehUD+J+8LuIdyGLtQGwhQzqtmNzDxic+nk8W65w7vOBbTWszdcJGpHJZJCRwbWQBY2qjaw/UdvZ9nixHo5vBqSLGNQrUedrngd8Dk48gTWo/GZdqb9XH4xzrdfkX21tjHPYr+FY3vtcPvid1Pqhixkir3qqERkMGNT8M0WC3Q7N1ZVRqfIQCgrp9oODNFJ9+eFFUU98gcDGA0uX6C6ULrMhnlp/5v9DYVtXO7xKzs1rgMzt9VMksiWCUhqCx2TiAWc2UlrjegobJxTALrjocssRL2WPZWTjSYmAuBIgAnQG6UABAtJeWv4K7BFSYC2WvybGjw1KcLEGmVzvhGg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:55:02 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:55:02 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 18/27] vfio/pci.c: rename vfio_pci_base_dev_info to
 vfio_pci_device_info
Date: Tue, 23 Sep 2025 14:53:24 +0100
Message-ID: <20250923135352.1157250-19-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0037.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::26) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 082d9bd9-d9f1-4cb2-3b40-08ddfaa8ca94
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hk4kAMXoHJiHYr3I+pudxxAtniHQAUTf+IvaD64XMAIV5hDYe0Zptdo5n0cF?=
 =?us-ascii?Q?N0whBXVMbno6+RRV0cGF8aDagfL9MAahuESu84uDihFvBgJf0wY1B9oSm1I7?=
 =?us-ascii?Q?xz1fNyssrQMZLGrfPtBjY4KnSOXMFY3c+FtBPKylwYq0ATfAefyOzB8oXrHi?=
 =?us-ascii?Q?f7q2eaRewsZ38nfV+t7DAlrGWZsWUh3VMiDLNgVNMhoJ5PQ3rvd5yrhsaYA/?=
 =?us-ascii?Q?o9rcytOPSGDRDiCZpR3TadEP+DfVQwJg0LsbBO2C3a9OS5zXuYJ/vR+HOIOA?=
 =?us-ascii?Q?wl5g7bbbt2hkCC6MFJwMqn0Q5g/K4DB1U/wKhQ8rCeVfpsw38e1gmP29dlN6?=
 =?us-ascii?Q?lFApUGfApM8+colPLnWjImYOQW2lPcdoJB5DexOqaWPw9QtJuAdHv1rgGcnI?=
 =?us-ascii?Q?uvQ3iHBFCzUsPK+dPy83KfzP0jvV0z0Cz3DNcNS8vlLyyGYwkrDU8xq/z7Ll?=
 =?us-ascii?Q?/raY+LqACZfGDF9X6mH65ETR8eLyqrUw1KJmfSoerriUvfa7REI57yo463lW?=
 =?us-ascii?Q?KOTMk6YS8O8WsMppI6KY3VKw+Q/znfUMeZAtWqV7KiKB5h5diXaUI19mVp2t?=
 =?us-ascii?Q?5ENhy7n95Ii2fqoJGZU1ahCTp9kffYLJ5rjTmklgoNGwDQ3N+smglJbTbd5u?=
 =?us-ascii?Q?e7UEep3BhHChngbP4KgNwI/kFRb8zzrX1zq8s6469QFqxGowd+bUFNGKvYLj?=
 =?us-ascii?Q?Ft2eeTpbefIB5bMXTuZf5FV0cKZNP1DsKYk1f4mxCfyxlgKYshupoJOYlsP6?=
 =?us-ascii?Q?OVg/9BXckY/xxt3FGFzozlWxZX5Wshl3c+FXWtsLreRDYZWil104HF5NoUXr?=
 =?us-ascii?Q?MXBv/NOCVKMNwLN/wzILEXU6AAMN9Kpu479ZXR8qZwBMb0q9NLpqKxOyTKNK?=
 =?us-ascii?Q?X8WBh/tIdHkcKGeQNFgLqntWkmclHNMM8NZRtw6nqo0E67o1lLSB0ZxM6qNJ?=
 =?us-ascii?Q?YcbJwNRoPbpzDlLayTR807vEDtffbBJOV3C1HWwhv3NAyCoP18F6VE54Nwsb?=
 =?us-ascii?Q?AekV56y1C45pzF2aVK7q9x29E5Yb6NQ7rJGdHOCIHvyLWpli0QgjIr8WcBam?=
 =?us-ascii?Q?/cujZJdpMRKwa1cqAh5RZ+ymupBd7qKBYjyTU9v1lM9iUSPXMQmUZPezdRd1?=
 =?us-ascii?Q?cTn8gOXDLs0HeJzL3pF+NqUgxENBhWzsXOgR9iu7/PGdV1ssvBisuanWjCn2?=
 =?us-ascii?Q?rx8P4pjkLmDHSe0Q13YFrA0HQKku5zRg0ZQSJjxRCjmS4XnCSgway5ufa8wW?=
 =?us-ascii?Q?UbK6LBDoU7qtr3/olz+J8MapKThSMnoGeb87xokmVvmkZ6G1nWw1hUXYu7wP?=
 =?us-ascii?Q?30JlIwQOY9YbxaWZ5lrHjuPAo1UpBG8ov28asQjC+L8TJe6WSGvOmhkDNTCE?=
 =?us-ascii?Q?Rtt2gyp0afsc1dBGzW/6m86W3am8TiF/n+bT3UT4mrta59oZNpuEcelxQUaB?=
 =?us-ascii?Q?WvRd8lWx8TzyrSuNTTQHwlHHed45Z4xHqtOQWWSlTHbNRbWVM1/KRw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xlMyjyTAWnwUiNv9wvcAgOdX+hDTplaCfC9D5AeMyA8JKS/vOvrAuGbMzNCk?=
 =?us-ascii?Q?piwTXJ04oaZFuX6CL1E1BJFKFIB5wkxvEcSrT8cCjDz3MfcHk3QxcZQFKYCR?=
 =?us-ascii?Q?yK2d8Wg0AqXa3XDSQaRGBY8BXroe9jF6NYCOS40Nd4v6usAiKcA8XO5gKSd/?=
 =?us-ascii?Q?O62fZsloQIvq4Bp+EPc5Eld9OLdj4W3/1QEgWQC3UOpPpODrqzhSiyyTGJlp?=
 =?us-ascii?Q?PGLOBUllrNAh9S2yqpwXFjiO3pezPminoeea7xATpMhbTprflo74HKo/dAJR?=
 =?us-ascii?Q?vc9In5g8JwoEZQ6P1wuCEgtPLOevdGI+8eWwPLABm9rEkfy6NQsZR6pYbVDE?=
 =?us-ascii?Q?D5LBvcnxjTa05H68HssVN7SVg77zhqTzSb2xSzgA0mTnWGDwh9t+BJC22bFh?=
 =?us-ascii?Q?dPftFGPdDQR8FqY6P2oH6cNfQKxy9kzBy10VhrbR61LzH5uEMhozYLp4W30H?=
 =?us-ascii?Q?WGulVr/vtP5K+RPa9Zle9TAQR292NHuZT78EQmbqzbgdJRFkLQOkCD+vaFaq?=
 =?us-ascii?Q?nzPLbeq1OwVhOGaFzCrjW8ZhOptqgyYUeQ5J91scAwazzRKCBwC8Z6bRTLqf?=
 =?us-ascii?Q?uF/bcIb3l+UKRJ30LcA+UTBKwU0lGzjfyrm8FdaWoM5CtZC7ofwTfCFuDmjj?=
 =?us-ascii?Q?h6CZxJnN1CZroqEY7FgJCbPoQFlgi4O+H1yEbAetScXEfWjBUDQ/E1vrVE7Z?=
 =?us-ascii?Q?j+nrtzLnGrg4x8DDe9Sdbb5XQl42I8JdLcniGiF5uoRANTVBA1AuKNmWfbe0?=
 =?us-ascii?Q?9B42h9PES4fWRSUx4d56RxP3NkTARHs9/sY95VPaHmBffGy/wrTXNFPyhTb/?=
 =?us-ascii?Q?3MDbFO8pLGzSWZ+TnqpvFPc0XDwZcBzSg+Qq69mkLAN/w1QdWyrfQxKm5Nyb?=
 =?us-ascii?Q?KEOfRmyNikdNhldbVlKgT9JfC2HhtkSsWkBQGlXs+6GoYkPTjp5UjaI3TRbq?=
 =?us-ascii?Q?2oxYPRF0CDFLbyXhzbjQ6oshe0fiDfoGTf0TPdUmapvHbEfwhxrnI2nU0Ln2?=
 =?us-ascii?Q?lTV213f7FeVpqko+CHtwoC1qmtanD4tYCmoBonvBP0XXhjaaz+HBecWQVrq/?=
 =?us-ascii?Q?su0rjOa9LvuzHBrDaNDy/zTHHflLZL9+A4EkBk1zEVuHpVZ1knjuu4HwBAo5?=
 =?us-ascii?Q?56LSFxDib2aKLjZrjV3DzD9VDMNRZlMnxSIrqE7pxTgr6ZRPaf4ml6rdCbLp?=
 =?us-ascii?Q?C9Hi2sipxxS33jDTMeOmDYXhhgtDEoI75DEyBOfLEeBLS1zCpv4gdAGsNQKV?=
 =?us-ascii?Q?3wzEmYve2xH7hzUUrVfHrTq7fDfrB8+jOgT0KanDrycMtmwhAYD1CkPuIn0n?=
 =?us-ascii?Q?+pgN+KaXsTo5A7NsdQmyhgvhhmABMzjCZ435l8EH9aiGVwOqwA0EPSODToqA?=
 =?us-ascii?Q?5TJdt7bOpBee/p0NrPlGmyLVjBZFAARuhBRuPRqQWQAxu46ICTc4dngdoTfC?=
 =?us-ascii?Q?IUKy1Z43n9V3EBpFZz7eT0GlMx+HCKsEQbHDty02QOs1jaSFPjjagoq2YPiH?=
 =?us-ascii?Q?tmPzWTF5aG388LOJQ3eIVKtW8Kiq0//Ofwg/71s0sUU8B8dW5vdK4mj0irQb?=
 =?us-ascii?Q?okduARpb7YZ/VQw8mMhEnWQsjY+SfoS8VDGQna/YsNUACt77tvgcNjK5SQqr?=
 =?us-ascii?Q?pVoCBU6aH2Xxzwc4VdGtSI0sKUx5jqUSv9UIKlCW/8KAAf/divGKMb3x33FO?=
 =?us-ascii?Q?clJ5mQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082d9bd9-d9f1-4cb2-3b40-08ddfaa8ca94
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:55:02.3536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4YnaUTSJ+BTUuG+UEWiNVDKebixHX7yXgdmpd35zsGsKBD2Yv/LPntoaoNhdwuzKtT8yz2ZcCEbqsdT+2xyztnpIvGswUA+TkWGq6yLJyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfXxO4LCEf7gaPG
 QgjrsnBSVoMfZLLYO8ntU9pNWY8B+QXs9sULLUJlWg6my2rdHPT6bpXY8sihlBcww8QJSgHJWZy
 adewyoM1ytT+ATeHDEyhFRPvblicsM7mtMlwSDVE4j+EVeFjMMJgw9Npc3s3PUg6R/QqOCkSlbX
 icWEU5xtmprxCqfzwv6oj6/fgfYJxW+XGXTU575jc2J3Aqa/ZQ4IIvNCsEgGUSTW43ZYjIp6A/f
 dM8uoG+6o9xPSbWML6CLgw7+97d5q0thWnYycZ63BDbwDw3gxZ8tuApOMCdoOprtSje8abfw6YH
 kIT5W4iP+lMgjf3VX9cpz0SQmmvg6IVebBMTz1mR9QD/YHUIS23gfVB3Lz+sMY=
X-Proofpoint-ORIG-GUID: CTl8A4xdt-ngDmsAZWeXjXtzml3_5uia
X-Proofpoint-GUID: CTl8A4xdt-ngDmsAZWeXjXtzml3_5uia
X-Authority-Analysis: v=2.4 cv=eaM9f6EH c=1 sm=1 tr=0 ts=68d2a6b7 cx=c_pps
 a=S/VVeZWp6p+cRv86h7uDVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
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
index a511f99a2c..e8d2e36df0 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3672,7 +3672,7 @@ static void vfio_pci_device_class_init(ObjectClass *klass, const void *data)
     pdc->config_write = vfio_pci_write_config;
 }
 
-static const TypeInfo vfio_pci_base_dev_info = {
+static const TypeInfo vfio_pci_device_info = {
     .name = TYPE_VFIO_PCI_DEVICE,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(VFIOPCIDevice),
@@ -3973,7 +3973,7 @@ static void register_vfio_pci_dev_type(void)
     vfio_pci_migration_multifd_transfer_prop = qdev_prop_on_off_auto;
     vfio_pci_migration_multifd_transfer_prop.realized_set_allowed = true;
 
-    type_register_static(&vfio_pci_base_dev_info);
+    type_register_static(&vfio_pci_device_info);
     type_register_static(&vfio_pci_info);
     type_register_static(&vfio_pci_nohotplug_dev_info);
 }
-- 
2.43.0


