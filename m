Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99442C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nBw-0003aN-RC; Wed, 16 Sep 2026 06:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n9G-0001ZP-5F
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:55 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n9E-00034x-56
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:53 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G7x6qJ579616; Wed, 16 Sep 2026 03:45:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ihH5Aan2jq7PxNKIjpNTz0jnjtfH5nsB0nWZwEzS8
 lg=; b=1YeS32lDh8hcTt5dCJ8oVmIFs5Tu/x7A0UY04UBvg+DkEn5DqoynMYIop
 ReS/ezvRAsWvbTJgx/6d3ECfLPt4s7v6xWY5TGPa/ko1wXwZ2WNbqr0QSamy80J4
 Dtx2Wb7ksF7nlL6YnQEQMK+B4xTqd69kac3vfUhSxof3PUIYnuU5Rv80BNESKfxT
 hayl9GlOwjyvYY2Ke2dHm02tApNF+bQddkS6jdDTKw4dgFTs6h7qAsuaxGCE0m2m
 TEJtf1gPSCcx2nL2tfYR+vnGtOF8/Rk4F3KxdBP8rdgA4AFSy9WxrTBUw97cOSiP
 TJgDvPO4ifAEpqlXA7jy7NxmWCAjw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023123.outbound.protection.outlook.com
 [40.107.201.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqbtb9yck-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jt/EI7Y9DwmWeJSvcY1YjCRt0w451VAXPxUgFdl51ADaGZgtvfevWfu7AyJWtGJ2gs0U8mqyJ37XbXT+EgjnkTSNks29zqtRPyu/K6v27STQ+DX2W0j0uUfgxVhOncfk+1KwH2WEENZYCMpXB09gZv53x2QNxNVw8UoaeIEcpeKgmfJenm3TZaEZvaNQM688tr4gXfGcqL45Nm/FzTbaMOuEiVjQMX9EIUlh8X+n8avr8Doiqrp/Xfki/r5TVe0dj514LAuPfk3EO3o6iNtNtDSTqtNXI1GZOablG8IEACtE48mJLvJmj8Dl236YvedJAMa5OrRNZAoBkm21qRci2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihH5Aan2jq7PxNKIjpNTz0jnjtfH5nsB0nWZwEzS8lg=;
 b=SZsFYpUCL8U5qZZDoO36+PUL5Bh0A3oAGfjhx5NbCVRfKQhLj15cw+1DElwRXeTeyXgGU9xjj52vs0Npc/QFMG8uMmYhp9r0IDvkYGRwxoyfh1Ex2BzBawh/jBtEZ8t9rmZeLSa3CBiUtDiPHuRMniowUAsMcxXeftwqtQCJELG2MDe2diYoW42Ap+MC6PtMSAGBoYxL14pGRpcAi1GZqeGPCpjMguihu0NsXGVTTxJRe6pSMfuGS2A0bKuYN40vrRD14Mj7QM9c3Vmpq3NOx0b8NVx0CfOZRX7dZQ/bPLimuAAl55Vb97fDBMc4g+SR5VDuP2Tup9qzqAT36VWWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihH5Aan2jq7PxNKIjpNTz0jnjtfH5nsB0nWZwEzS8lg=;
 b=Bmfnie5TNuQgXOTidqZwziJ9rKQtB1ob7sZRHcWwI5rqjaq0RY5qp9wGzhHsSHi2EInoKqT7Id8pDl2BQMNbpg6iXAV20LyCx190rHr025ENPajtJmgs5QkfSedOkFKXW/qyafDZhAZwm/DXQugKrFEH9fIa9il8mPA9YWeu6pweWiPWOv3E3HpOerwFYlZDoXYFpuYvxa9VoATrsE0RQjU1kccYagNdgANCqi3IS8oVOcknBVDTdktg+zCUVm00s1XNNIALBgwPvoH/X00PUisEiqgSEkzEZu+hORN/A/EGgA0O9vHUNu/yubHw+Tt3+H70SajmwJopQ55++kjzZQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PHXPR02MB11343.namprd02.prod.outlook.com (2603:10b6:510:3cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:45:45 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:45:45 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 19/22] i8259: move InterruptStatsProviderClass
 get_statistics() from i8259 to PIC
Date: Wed, 16 Sep 2026 11:43:47 +0100
Message-ID: <20260916104435.600211-20-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0045.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PHXPR02MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: 7926d65c-4b18-41af-c2b7-08df13dfa95a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|3023799007|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: wEh6tNVM7FI3/NfB/qPABNPHhAZsIXSrbB80pq/L/t3CNLcmp//SwB7cajpTeL/A/9kVBMD7ylprE6DGFtn43QlFDXoo+ZvMW9/x0EzaO5+EcCkxO37J6is6Bu3wo7GVKeVDnGvtr0E+1rB1pK/5us5Ut4cJdLs314PGvqxtkJpGy3jWkChRZ9vRjAyUR29aky3Jqesd7pGhXdfrK1B8MJByFyygSgIKpUQewfgWWcRDKzG3SbF6n7V0p5L3eIt07Hta7j2jetvwQRK4zhHoDzIb3iiTnxfX+xIpC8NFoEYdZnBf/4GhXwTtPjf6/K+vyHLG6t5Ejtuf8TgZxRBxYl8EnjESCCQwKr1XBkcWZVxwhCK6c/h7QEq10iD/ZymRiHijgWHYRirmTvIep93+bj0pwepFmKwsqlUA6UjwkwAJsMObx/ee5Lm4SmFDiL4HlMccQoR/SuL2wV7pj9/FtfJ0DcR9z8e1IzmxxmKoEzSjyZ4G+VVmchoU2CFyq25aLb29tOEmZKOZyTKFv8ZQHpMcVfWyVdUsx66LQREiWmPQiPKYV30JdgAV8m1/aUkSHmgVl/3ZIxjqbLItPcIj/FJ2I4MNrY6iLAvh/1OSzBflwe/3pyHbGGF5fh7Btb/ZxsRj+6BgzO9sCLT1/JBmVs/lhrrCnrEO+ht5MWG1UUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(3023799007)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8pYZ6YWt+VdzaJmG54dG6HJIov/9Y2LN9/NnDkIJls7DHsK2y6UWyi5ANtms?=
 =?us-ascii?Q?pacqGMaiyD4nxwW3fFxdpdb9gbS3MMASmzF+weV79PT+mxDioLF2G/DDg11R?=
 =?us-ascii?Q?PJ1lxS6ZUVY8bAPvggvKqzBXZ1FUdjQl5hSnNA1puT9OzTQGaJz8rmmT/GQD?=
 =?us-ascii?Q?YsVZdwYs8Cgf9xmjJZdPZNLGvGA9XrZCFtLjdw0NzSAAH7W52DF2roHtDNBX?=
 =?us-ascii?Q?v3uNRg8BSxpNGDbyNF5fNzCGzmKYr3xujG0qHL5AbpMvDhkojJd9g9vWyTge?=
 =?us-ascii?Q?B7heebURlSPc51ca/ulQ4Z4kC+eRNQE+nSz0VDlKfRpbR/njM+67JqQeC8Nf?=
 =?us-ascii?Q?0xbjbVmZhWzibD0P1Lm8C9wiOtxIH1l7DAwLiCm/g56UZnP9sjCeT0dmMC+m?=
 =?us-ascii?Q?wSQ6AQVGRsQC2woUJLvBSVozACtObbSnryA/uE9FBBIxhhBBEsDj6YF7TzkO?=
 =?us-ascii?Q?lcQ6sdEB9UnPc3S2UL1/z01UKSZXlMCICk1+B2X4f/ixRdGWkmu8smO7cBD2?=
 =?us-ascii?Q?R4tSLb2oEpMAuXM351UDshywQ+7OZu4XsVbaFvAkRFEqAgdHBcDvCAvxQJdz?=
 =?us-ascii?Q?IEMHGIprbzMCY2UNYnqd+m8WDiYBFnY8+1Rmw8BJjN+6CvdEjrSWlWmaIfKn?=
 =?us-ascii?Q?T2G5Nlsw05h41vORybYH69jttzxjvOT0CPwnXYwrciXuIBPpjVg3LT/H8RXq?=
 =?us-ascii?Q?95Tk0JF3B18vgKSJJvOfNQLhd/P7MakTBGm0S9vfr56AU78PGp2R9gaSsJfe?=
 =?us-ascii?Q?NTwJk5aUBd/tu6jRoH0n8zOuOk5ojIZpNQug9HpDBxz5n6Zwn9Ueb35m99ka?=
 =?us-ascii?Q?7aaAMz9jO7WURZrHUhTncu+QJHQ5C6RmOarYyziVwXxsTELwYjrKyBUgTu/3?=
 =?us-ascii?Q?e9j/nkMDh15Uan/jgnqYQO1ITNOO4m+tMeFFUzYq2BniEk7C3a2jYASGG8Ln?=
 =?us-ascii?Q?qhqnGUsaI3J7M0H86orXTMCejd1fBItM36wtomvGEz7Z+V7Zw6D13/E1y5oh?=
 =?us-ascii?Q?xTDLvIb8yNhtN9I0Fo98bVsjb5hqFSqlo+qA7Y91TF8k0KtiE2kfK0Km9cJq?=
 =?us-ascii?Q?V3WiWFZA3LJ+taunV+N4Y761tmgpd3Fge7PuhCdqqUzCh2AE1/PfzaN85vKZ?=
 =?us-ascii?Q?eZCWpdCxY7NdNU6/R7FyCPwcZyJbC/2OASnujffVqfy1rkWEGFgPcIzYfF/p?=
 =?us-ascii?Q?njW+yz/iBvMzY2XqtI8KUyW/JFtElKk7CizJeHA6bKnTH1h/FuR2cbg4ghIT?=
 =?us-ascii?Q?jaWzJIfeqX+uuEfTbJ/uR4dVDwWOFChTBqm//rzNCGrjahBtsvWPwXgxBBBL?=
 =?us-ascii?Q?f8/VRHaFHQ41thA19r26a1sL0YusRhFqKK4GVOvBM2rthTUTWK7JzGNW4tDo?=
 =?us-ascii?Q?lx5BpO7c6K3oNwzc+ad40tdN0qpk14ufIVLcxmAE1oEHJ4TsWrE/FjOpPxQS?=
 =?us-ascii?Q?rr2wY9JtdP37/RCVaMnsSfRCOdasoH1HicmUrZNwNIlTJoEera/j21r3wJ8l?=
 =?us-ascii?Q?8jwSBD1FAdTun9uCrdqIZpAWKXCyuUN0kmniYZffBMSWmk80wDM2IOyNn0Sn?=
 =?us-ascii?Q?J3hYsplfavzezWwIGyatO0NKKpJeieYy4ILQhX0oDiHj6woh9DpI43nDEwIr?=
 =?us-ascii?Q?l+TOBMtpHE4zHYMY1zvHMtYKbB+ZV6uP4n41FQYJCXC91CrAQo4NLNeEp3F5?=
 =?us-ascii?Q?VYBRTAOEDTA8u/8YK0A1Rx5yO+T1okzbV3qZBt1ML8lmckpC21eahVr5f9jW?=
 =?us-ascii?Q?SPvM1cwZULZebBW1tZpHFp/RvvYDcIY=3D?=
X-Exchange-RoutingPolicyChecked: g5ZdVuxOFxp4XWe3LvyjZkpOC5AeJku9Tq4meGIVWpjSwJL7DmvXpB/hU1AhZUtE408jMlhHcORgps19G05onx9/U395oTPQyxI/N4xUz13LGtRmdRaCFXxC5hzU5N/w8t4cK2bo9MOnhT1NRfqD0E2CFeLH7iPu/RhMzCRlMciNZwhhPqZhB7/ea3hak87Za9i7Torw4/thky00gCQ94DcOs/+un1u7/6s2JoJp2DaGDa4+YRaSoa3fHZGw83HhXe/Lq2SGggfdiFBTjuROZNOz1z/mDXp1SHV7R9vwiDIEs0JAoG9SaWjBKA4rxqXp/cKZ3XBicYJavs7c7rrr3A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7926d65c-4b18-41af-c2b7-08df13dfa95a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:45:45.2496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Dh3ho+PdJTLKkHJi5fgX37f3Msrntc8M7f24zGxqV1xm94I/niydO3LJ5fXywqR6itw+CPa1kKK2WUoktWpFmnUSPYL4nD6vXgk4FbvsoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11343
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX6LKqaZsss3Ig
 sX7YtgeUxUX0Ng/AurLgXLFmcY0ZHzUasLF4zKNEyPUiDtcQ9PBlR0rdmqmmtXmcpSfsJiWXJza
 96YkL9p/MENJZMB/2RvY7qx92gu/iYk=
X-Proofpoint-ORIG-GUID: kpVvWs6dz-q-2TTU3FAlEzs_6_aNAjUr
X-Proofpoint-GUID: kpVvWs6dz-q-2TTU3FAlEzs_6_aNAjUr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX+fbmi7BTHGOA
 +gpdqGxbeC5/BQanNIgTrH4GzUxxPbbGzk/e+ks+dm+eIqLQII//uCDFc1zWxDpBQGE1pW1t3Eb
 mgpJUKRCcjMkrV5QmMP52h6//MR+pGMSNsEFntF3MOiQIB8PhJhHLQCZ3KstLkOMglGuZAeAv7m
 u/b79uHLpiwZI8mHmR4aZyXIosGaEbpqtHUkHOcENJOmRnJ2A0/cxy7SMr2/IebYMYj9BWFoh7/
 ATJM7nsIczoeY2adBGbinjcrviNluVWqWEnd/Y71eJOnODel3tT42E+EddAqUy1tz3ZXBSbcw8C
 jVTNytQmHc0IzA9VSOK2LbuVctes1LRyhe9IeRHB9vOOi01FZDvkQouiKabUZOf+gpef8ynqgi3
 mIZX3KFphVMHd1JhZomhG3Jqde4vIWx00S5Bz7JSF3O3YGCHONL8BQe+YczpjRJ1vHuTK2NVBSO
 4IWWFkxjZ58V/5T0EQg==
X-Authority-Analysis: v=2.4 cv=QYvzLcbv c=1 sm=1 tr=0 ts=6aaa735a cx=c_pps
 a=MuaoZ+x0jvd2FUwkjOjmXQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=A7cMN0_0mIGH7w_oRUwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

The internal i8259 implementation has workaround logic for storing interrupt
statistics since these are currently recorded at the PIC level (i.e. for all
16 interrupt lines) whilst being stored in the master i8259 device which only
has 8 physical interrupt lines.

Move the get_statistics() implementation from the individual i8259 device to
the containing PIC device in preparation for removing this hack. Note that
this has a visible change to the "info pic" HMP monitor output since the named
device displayed by "info irq" is now the PIC and not the individual i8259:

Before (TCG):

(qemu) info irq
IRQ statistics for ioapic:
 0: 68
 4: 1
IRQ statistics for isa-i8259:
 0: 68
 4: 1

After (TCG):

(qemu) info irq
IRQ statistics for ioapic:
 0: 47
 4: 1
IRQ statistics for isa-i8259-pic:
 0: 47
 4: 1

Before (KVM):

(qemu) info irq
IRQ statistics for kvm-ioapic:
 4: 1
IRQ statistics for kvm-i8259:
 4: 1

After (KVM):

(qemu) info irq
IRQ statistics for kvm-ioapic:
 1: 3
 4: 1
IRQ statistics for kvm-i8259-pic:
 1: 3
 4: 1

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/intc/i8259.h         |  6 ++++++
 include/hw/isa/i8259_internal.h |  1 -
 hw/i386/kvm/i8259.c             |  7 +++++++
 hw/intc/i8259.c                 |  7 +++++++
 hw/intc/i8259_common.c          | 27 ++++++++++++++++++---------
 5 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/include/hw/intc/i8259.h b/include/hw/intc/i8259.h
index 1921a30371..24237a4ed5 100644
--- a/include/hw/intc/i8259.h
+++ b/include/hw/intc/i8259.h
@@ -1,6 +1,8 @@
 #ifndef HW_I8259_H
 #define HW_I8259_H
 
+#include "hw/intc/intc.h"
+
 /* i8259.c */
 
 typedef struct I8259CommonState I8259CommonState;
@@ -18,5 +20,9 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq_in);
 qemu_irq *kvm_i8259_init(ISABus *bus);
 int pic_get_output(I8259CommonState *s);
 int pic_read_irq(I8259CommonState *s);
+bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
+                              uint64_t **irq_counts,
+                              unsigned int *nb_irqs);
+void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf);
 
 #endif
diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 390a373511..53751b045b 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -26,7 +26,6 @@
 #define QEMU_I8259_INTERNAL_H
 
 #include "hw/isa/isa.h"
-#include "hw/intc/intc.h"
 #include "hw/intc/i8259.h"
 #include "qom/object.h"
 
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 0ae5caa655..421c9279cd 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -206,9 +206,12 @@ static const Property kvm_i8259_pic_properties[] = {
 static void kvm_i8259_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
     dc->realize = kvm_i8259_pic_realize;
     device_class_set_props(dc, kvm_i8259_pic_properties);
+    ic->get_statistics = i8259_pic_get_statistics;
+    ic->print_info = i8259_pic_print_info;
     /*
      * Reason: must be wired to the ISA bus via the "bus" property
      */
@@ -227,6 +230,10 @@ static const TypeInfo kvm_i8259_type_infos[] = {
         .class_init = kvm_i8259_pic_class_init,
         .instance_init = kvm_i8259_pic_init,
         .instance_size = sizeof(KVMI8259PICState),
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { }
+        },
     },
 };
 
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 964ceb04b2..ffd09f6c61 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -517,9 +517,12 @@ static const Property i8259_pic_properties[] = {
 static void i8259_pic_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
     dc->realize = i8259_pic_realize;
     device_class_set_props(dc, i8259_pic_properties);
+    ic->get_statistics = i8259_pic_get_statistics;
+    ic->print_info = i8259_pic_print_info;
     /*
      * Reason: must be wired to the ISA bus via the "bus" property
      */
@@ -538,6 +541,10 @@ static const TypeInfo i8259_type_infos[] = {
         .class_init    = i8259_pic_class_init,
         .instance_init = i8259_pic_init,
         .instance_size = sizeof(I8259PICState),
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_INTERRUPT_STATS_PROVIDER },
+            { }
+        },
     },
 };
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index b3f2600523..7980f86f1f 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -99,19 +99,28 @@ void i8259_stat_update_irq(int irq, int level)
     }
 }
 
+bool i8259_pic_get_statistics(InterruptStatsProvider *obj,
+                              uint64_t **irq_counts,
+                              unsigned int *nb_irqs)
+{
+    *irq_counts = irq_count;
+    *nb_irqs = ARRAY_SIZE(irq_count);
+
+    return true;
+}
+
+void i8259_pic_print_info(InterruptStatsProvider *obj, GString *buf)
+{
+    /* No information for i8259-based PICs */
+    return;
+}
+
 static bool i8259_common_get_statistics(InterruptStatsProvider *obj,
                                         uint64_t **irq_counts,
                                         unsigned int *nb_irqs)
 {
-    I8259CommonState *s = I8259_COMMON(obj);
-
-    if (s->master) {
-        *irq_counts = irq_count;
-        *nb_irqs = ARRAY_SIZE(irq_count);
-    } else {
-        *irq_counts = NULL;
-        *nb_irqs = 0;
-    }
+    /* No statistics for individual i8259s */
+    *nb_irqs = 0;
 
     return true;
 }
-- 
2.43.0


