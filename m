Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CA1C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 10:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAWa-0005S5-Qk; Fri, 11 Jul 2025 05:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWZ-0005P8-Cc
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uaAWU-0004kv-7M
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:58:35 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7Msip016817;
 Fri, 11 Jul 2025 02:58:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=8keZdesCieKMbzxNEOnjRTMZa8j163SPwSUtUHBnW
 QE=; b=bYXU63rmNxlyKGkw9ZeqMozo8TWy4TAbna8E8kho68VyIQ5Y/6trxFe/j
 WgPacwARx1GjnOgY2Og89Sw4f7DURCvVaTXlSOlKoFvuxfaHtjsTeWgCAssGBIRU
 89AvYXXlYsdZYwoBYR7Id9nqQnLUHIDTjaf9hKWRJZVUVxDkV6lFIo7iBq5I6X51
 WruemTxSlEeeU3pOj38fHAyZQRiypYnIDtMkUN7AhnWvCTGFYOj1KKFWjPWxRPvj
 /CeR5sdBxw3hfT1qpxEEQe/4dCPAY1JLkfVDL0SdShZ3JglJOvRPw94vVwZgrqnk
 bDcPI9vamw3F38sus9AJSLjuOOw/A==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021142.outbound.protection.outlook.com [52.101.57.142])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47ta49k6ce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Jul 2025 02:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVgucecwI2Eg+mVSm4NFsHWY582l5h7e7+swWts2V7F0hKVZ+CjGu1C+dRhfCqtkqm8qLyRY5FS50ZxL0/04eQUzRe7dTy+QEiC0HV3TTAa24vzHisIPoi3Yub4iaAFsAxiIHP5CM4OR8JYguys0nQWLmqJ3RmxMhhJqJE0dUO2E/BcTNPYNIffSYcKo9e/Jkj6Dv0lTJ9b1Lshf21lK4X3itLW16AOF8XZSBqYtx+B7X5qZ0kNAToL6tgl7gdQhD5v9/K127vy6y7inxt5nwllKTHlCx251o1RWmpvlcVviQHvZzks9jxU3xaJBv9aD6pNcv8gcFEAVZGjw63S0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8keZdesCieKMbzxNEOnjRTMZa8j163SPwSUtUHBnWQE=;
 b=vEUn6hPnLUSV3rae/2MII4YZO6dhobTJiE5cTmoowIXLqIFnEsaYIbEcT7W8aDkOdYgbxno6uJ5LWj6dBw3H/z6O2vaUdTq6k2smuZXmYRVGMASi9wkF5CSjVVVdZtXMFzb3iAvSxKdGhNZ1NgCChHynOyJFV4Mt1cW9X6U9o1PjkquNSqoj8r3XAFZMSBhvcqP/1z18vMLiaqxeod/E3mi88L53Ea3FK/TZY7qf3OrNrZA5FoqOYmh2qe4JX0AG6AWK/SGCU+Eh76Ezgv976mvwM8Hn6RYMXrD43n5f90ArthWneZ2rpdDAQU812s8ENi3oWYy3t/ximsf8sXV1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8keZdesCieKMbzxNEOnjRTMZa8j163SPwSUtUHBnWQE=;
 b=ohug8+FAliwg9Sc5o5zyzel7JJIE5fTtsMcJj1zHVruRPEI/+f0MoBkhtkkqp2t41Mr3LXAVb58Fcjcpowc1+RqeACgMRHEUxCiceIpUGRipRbgTNjz1bajKKqFVq8o4e0hZZrDTLLwAahe/xxba7ycx2FBGtc8TStyN1JKMtr7Ul/Ox5qbv4dG+AmmE/jdcmFVaXHufEG0VNRrN8vg9DrzwQSqemb2Uh4eBfqfeHXC7ac39WK2upWXcSpQIQ3V/2lloGrVNz5XHbkVN21E8xljWmbPCMJzdfjASFWv+o84ud0e4StbsGviAGD+dPvXgL5Eb3+ZdpSX1QShnk6TpIQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH4PR02MB10681.namprd02.prod.outlook.com (2603:10b6:610:246::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 11 Jul
 2025 09:58:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 09:58:26 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 03/19] hw/i386/pc_piix.c: inline pc_xen_hvm_init_pci() into
 pc_xen_hvm_init()
Date: Fri, 11 Jul 2025 10:57:05 +0100
Message-ID: <20250711095812.543857-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711095812.543857-1-mark.caveayland@nutanix.com>
References: <20250711095812.543857-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0041.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH4PR02MB10681:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cb2271-75da-446f-5b00-08ddc0617aec
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bRlxH4pIUtzaa0+noJ065DR7UrZl0i6WnieRHYwABF7HzKiskspG0jVZtC0y?=
 =?us-ascii?Q?Bln0s77/Y/MZS4Ckhs23wFcw3q6r0ZccGbsGv9wwPtcmGXukGTaXi8n+FMfN?=
 =?us-ascii?Q?EjrJ7VoUD2wtjykYK9Awrvt4xUdQwsjMjedNmkzk2+QIy2D2SJwwajpHw5lp?=
 =?us-ascii?Q?cKPK6ComzseojZp0C8wOsZ+ro90HRpkeCC2w4WdTjOsC0qZGT7gUckb0XIUo?=
 =?us-ascii?Q?Kth/ThrmZVKq82INJj30yONUVkiM3Puw2s595CtY6Q/k7dkOrsNoOAyh6pCS?=
 =?us-ascii?Q?0Jt79YgT238CNmFAImOuFklAm5HcubhFjzkt9FtESJK04lmqu+W12lTH3E+X?=
 =?us-ascii?Q?gzMdiQfgriUOHSOET2nJQ3V5fFiBdd4BbUDpSR0hATdYt871Mmlc8uBZo7rr?=
 =?us-ascii?Q?q56ntDM5FiIbTGC2/n75HjFesQP8/8fnfL7pk7woenVQd6ozeSNw/FVcZC4Y?=
 =?us-ascii?Q?JoCOAWyd3379Ad/3TzXiJ6ETA2R3zkVxy1LEcdnFiodxmhAh6Xiri0d5ukDZ?=
 =?us-ascii?Q?aAhmbGSKpocVVnQvtWoVz61rVbp5vzEYFYpJ2L4xR51Kvx5ErtNqoR+7xX1s?=
 =?us-ascii?Q?T8fwrfHSSfg19WiatgdcKpSxFJPRKu3w5TKmxClscC5pGQRga9pGluNk9WQy?=
 =?us-ascii?Q?me9Ug3Nwz0xNmQOCUe4HRrRfWVqra26Z/tV5qbMbPNI7Rvna+3V+7NlViTtm?=
 =?us-ascii?Q?X9Bc/eD6x4VMvdOyKPNu/eYkUWTa5FPeCXflyrpfEOYUbpOOHyJd4xx+QyFa?=
 =?us-ascii?Q?bE6KhFmuHVGtenNJ11C15N7ffffUXXZDxcQjWnepQIBUFPjSBQjbysS71mNu?=
 =?us-ascii?Q?1+Mva2ENmB/dKZkU5WLkqBQhTfNEmZPw2CJXbOhBikWwUjPOqx49d/DPw3No?=
 =?us-ascii?Q?mTCtQwZ+NJZ70QmDz/fiYuiIGqwDbTy7Z6ne8tJaRSGFMN2X62HW4VwGJV5D?=
 =?us-ascii?Q?NyTSHEVEC8z/ikeypmLtgpLVgOvMMheoAqpzXexaMhLFbkomkk5voQRcfmEH?=
 =?us-ascii?Q?rHGv66S85pvQeVhkNU9JdEWPwjlaSkXDCrG9zdV1PHmCBwuczBoArve3WwVn?=
 =?us-ascii?Q?6j9iHIfZTd5QGYgXqnAWhXWDUgMV0UARX/O6S0cXdY37JQXNmgqObm9YLkoU?=
 =?us-ascii?Q?c5ZyIAsxhfJAttgYu9ItgTfTl/BIJCTIJgA1fp6DKEEbUp+TnK1p1OuHU5Q3?=
 =?us-ascii?Q?E+YoGSgKS3qZxmk7GcbdFLrQbcjFHBfC0KAyLVxChPP+VA2AFvR/Zb64lBsS?=
 =?us-ascii?Q?JYgd+DrstLU1+lfrUJFTlEzvDyvBnue7bALQmcr3baNrzeDwxl2ApoP1x4pY?=
 =?us-ascii?Q?p8bqSAqD+kfaebQATbnutouuaV5klSXTGVFU2mxIrJHGjVHr6D7XuHczRS4t?=
 =?us-ascii?Q?W65k9fXoTIUIyFNJJrQhyPzAXM5FQrLrQGhUrJND21Z+w+iQSwbvO4oNJIK7?=
 =?us-ascii?Q?5qUh+BdNvAg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PmPPj9C3sCj8SMvAh3GdH9HT6CxpHAX/SZ6vxKzWTfPm3TsSpfqTUu/zk7K1?=
 =?us-ascii?Q?CXnsU6FZbA2nZYZ4OieP4VIDI5e3QANEQX+M9E3nbr1hdTOENGU+b571p4XY?=
 =?us-ascii?Q?KhUcprcACgazDbFQDhP+ybdHv5gymncJpD5YsggayFf73oFrICz97lKDs9FB?=
 =?us-ascii?Q?FJSFOpQSG88K7F0Ut8Yd73LxGp5MVbjIwjGOhg+cd0S7xdgjO+0n+g+s/3Wj?=
 =?us-ascii?Q?AuoK+doJABQ4lR239mgZyfZ5yCpb0WdY2P5W8JTg+BrH6Q+3MoZ8v3Oa9EFX?=
 =?us-ascii?Q?t89Wj+RxYxAZpekHRxV2bAPn1mGcx5zY6uKq+q/N+PfR8uMC4ly5f7AIL8Vx?=
 =?us-ascii?Q?olnyyX7lfN0fgIDyZdMzlqZNOHkEhIQzJR7i6saXXVhKR4x4YzSMSn3eRFz7?=
 =?us-ascii?Q?WhmX07mQ/Fb7PuVMbtiMK4RKWR0+0hjEnj/zfW+++HKxgnQrYZk5jwFJeHPI?=
 =?us-ascii?Q?kN723pnPXQE6Z1+KPMIdxznvG0p9SX08wundVZ2oPVNQIDkInerh0setvJvS?=
 =?us-ascii?Q?z5RQz3GNVJJuAs56+gk0kJNdX2ce0I2u4NTcWPrqPvWZ/6hw1Nhv/rlXAEBp?=
 =?us-ascii?Q?x7He5pTcl7plO4w4x4/o+7N9ogUrCXtCU7uBrJeKWmBHd0FLtXV43VsgPDNw?=
 =?us-ascii?Q?Fg8BLBca9V88uPYIqrJ1xnO+6bdBJpFWUwy7ULDvvmWUNaVPQBQuz1iQyRvn?=
 =?us-ascii?Q?ug9+MC8t1MEMce9yJ+iATnaofs9JzIZ8rzgkFqPqcnv+G/00sh29057Asxeo?=
 =?us-ascii?Q?tZYKMAE+EjnJS8gSXLgXGmq/Z7ky+RmfF7+fRLZ5It7JVM2OGBh5h4JkLZi3?=
 =?us-ascii?Q?LdPV72PYcHTN5XgzQIixGKZfSn+/pZa8GRfLkxauT3f7WBl0yARGCydkVPIw?=
 =?us-ascii?Q?BrYgq7wmMmQC/+NpPXpmz1EiKFygFUCYqNrQvQKXLuNGqbIu4uJUrzEEOaQa?=
 =?us-ascii?Q?1HMoQ6Fgq4ebt3T6s7kfXp/fkcz7UrbDdvMlqJtKnSXyW/KON5C8kmt4Qprt?=
 =?us-ascii?Q?/bPVfre46lb2uiYiqlluL8iMa/8xf655x47XlIb0LpZsRSI6PR67+L7nbJ24?=
 =?us-ascii?Q?+9aSIqgJaFkj1M4IV4lpaDn5lfV8TgvUF/Gg3msnm5iSXMP41Bwu+gJ0t6gV?=
 =?us-ascii?Q?Zz7kygAxmx3FtG/Mr9OPEFYvAyYz0Iip3nCQY0ztI8v1QgWx/uaBGWfKOcHl?=
 =?us-ascii?Q?bpJ4wJ1WaultlmhDXeL3MUCX7jhKRoS6FprsDKMl9KdsQBRXfymZjwiRi+Bg?=
 =?us-ascii?Q?t3T1FnjDGsuAQ/p5kxNur9NryaXqQ7YgaRHndgfPjDS24WAkLgnacHFyanVN?=
 =?us-ascii?Q?I9WZlVEcp2W4KEJqeg02TueenL/BJIDGrcmZmgO37E4ZJCgHZ9JrXQ9tiCTu?=
 =?us-ascii?Q?Rss08HV6kGiq8edHMVj6TB5NjbNlQ//pt2JKp+yZ2tuZg0AGTATaSdmUwFhL?=
 =?us-ascii?Q?kQ4OHj98MOWeWZ5n62GillVNfYPkPk/8eBovw/BQiobtGIV/+NpR1wx71F8f?=
 =?us-ascii?Q?NVmcwKcAdFV0o+SGKXFukVnvmqZNwo9MW/q9ZqEgBdBc8VtYuJRH/7FAxVVw?=
 =?us-ascii?Q?S3l4QE+r27KN680zPZKZGCTB+5cLo/P2SRc/3RlRpo/jm/TatDYKN9lceO1/?=
 =?us-ascii?Q?0FNdcMvrfqofWDB4QLdhSMzgogajmlzDojAH/RBerBuNi63qwvSRCTQlWuwo?=
 =?us-ascii?Q?dMRNvA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cb2271-75da-446f-5b00-08ddc0617aec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:58:26.3824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZd23qZl/SEZmfFz2b0UsvYTwEg5xeCJOBTNqWCv5UbHTvOSnjujWatOlKr4gD0x2P9oay9h/pu/PMTscAU3LbEA8LPNtl7noJ75tAjBYqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10681
X-Proofpoint-ORIG-GUID: prJckh8sGTFCs1WH_QcnKic1pD6jAzAj
X-Proofpoint-GUID: prJckh8sGTFCs1WH_QcnKic1pD6jAzAj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MCBTYWx0ZWRfX3AZTgRUmoDWc
 LALh8PTVvmhRztQT+yBFUxbxSvmgLqJHtll4ytT+ICwo7tFHHM4zBSXktXB2Chfpp43Aq+YvsHu
 voG1EHlVKi47TvU58N+Cdr5O5PX9JtFUepKR3teLAUMCRsSiTq2xkfMkE3DXkwjmC0LV2iB9RnI
 lt2T86s65kyF9k7oH8KfbGrlw2K0CL8nzuX3UnwnjHNXx9rSftnfsFJZxMUmSYt71VMns1vD7xz
 TA5dlyQvcEdvZ0lJYjDHxtZAe6bPtnnIMrb6BFlRlpfiJ1tvG8GtKgo1KDtGZft1FKv8+9JMNm2
 HC7qRYMN19LifE/xxqGjYY0TeRnWvBcWFBcQmwrJ+MCYk6hXyt7cJhf3FGkuZPDwgaBhVxCmdeu
 K4Pq9AO7iDFsjKW479fumwIwNo5EcSqr/oVJrzjTp/9s1cFJ9ExU0EUhek6e2KmoWMzT4M7m
X-Authority-Analysis: v=2.4 cv=fNg53Yae c=1 sm=1 tr=0 ts=6870e044 cx=c_pps
 a=a1KkbayPxhvfYlTdgkZZag==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=MloeMuLfwZpfyPeI5kQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This helps to simplify the initialisation of the Xen hvm machine.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 4b0eeb4497..b33480e203 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -435,14 +435,6 @@ static void pc_init_isa(MachineState *machine)
 #endif
 
 #ifdef CONFIG_XEN
-static void pc_xen_hvm_init_pci(MachineState *machine)
-{
-    const char *pci_type = xen_igd_gfx_pt_enabled() ?
-                TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : TYPE_I440FX_PCI_DEVICE;
-
-    pc_init1(machine, pci_type);
-}
-
 static void pc_xen_hvm_init(MachineState *machine)
 {
     PCMachineState *pcms = PC_MACHINE(machine);
@@ -452,7 +444,10 @@ static void pc_xen_hvm_init(MachineState *machine)
         exit(1);
     }
 
-    pc_xen_hvm_init_pci(machine);
+    pc_init1(machine, xen_igd_gfx_pt_enabled()
+                      ? TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE
+                      : TYPE_I440FX_PCI_DEVICE);
+
     xen_igd_reserve_slot(pcms->pcibus);
     pci_create_simple(pcms->pcibus, -1, "xen-platform");
 }
-- 
2.43.0


