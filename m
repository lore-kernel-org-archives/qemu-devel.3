Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D50CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13UI-0007Xi-VC; Tue, 23 Sep 2025 09:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Ti-0006Uz-69; Tue, 23 Sep 2025 09:54:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Tg-00041i-6B; Tue, 23 Sep 2025 09:54:45 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N7ocTm1544425; Tue, 23 Sep 2025 06:54:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=grHGpS33AubpkHk8HDI1vGAlfYVbEughoy/R1z4mu
 7E=; b=XM3pZIeaJlHHzMgMsXefapoe3MhHeNmlJEZA88I/q4nNbyhciSM5jVLJW
 xazaBZIhHmMEUTRbPhDs7jSiZTU8BgN5RN/cBzYTP7jYiuJucoOqTyr9qStk6Nc6
 CuSTb8CpkNBqFGiUDt7Nis2dOWuGbOirwHZcql+sw8xkFRlCrDKvGk7AwMbuAbIo
 SuesTrrI6u8gYW+JOV/UhoVwQ/+ShEL6b+Ht54TYD7/JXwAuJWieiqIyQ+WpMiwa
 3uimk9eLSsf08/iBvQfzqi3sIGKhv4QYBkeQQ0vVjNh9MrP+eMFTudCaNX9j0gfG
 R8fAscTn5gYOjpyD+jCoBor0q5HDQ==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020089.outbound.protection.outlook.com [52.101.46.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 499rkrp5wg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUi4aFfbrbl89vGZSTn3el0dHCdQ1S96OjSZH9wlZcftL26QnLwyCE8/+k7WiX3r7xuS5Ba8S0XqKHAUvz9LWsBSrM+f7xLbMFw7iV8iuamKXfGhmcRofIgwoERW+JHTxBVV1XTItGGz231E/d5jfSDJUcFa+jT9c7fsvPPPf3xpFiQmAhxN62fTuCtZCjiKqcK53lEHYHg3u9tEMCGubEVJul6I1R007sAKRiLz9EpTjH+wwfLmkVhbn+gkMzaKGmTsACFyhg1HDArBYuwegumKZnFcQkj3uMUDr7ybGH6OpDOduk4XYt4GYmuig3FHlZDclo5VHN3XGNEIKkLreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grHGpS33AubpkHk8HDI1vGAlfYVbEughoy/R1z4mu7E=;
 b=Xrd5zQuGp4h1uoF7eMfnD2VAKzSYDwoiNVwfZU3858mNSCi8GX9bI+qiG0dvy4A3sOt5Tp2/uurp5SHq12+RO198bK2OtnHl2Rgp7GCYP2QajeXeIT59VbflPh0VQCAHtne8wikfofUYtg7UTEsABwAb46Gg6h5+RG4EGLCj5hRZQ+n6dgEFaXaX+sCccQsOftiZ4UWebr5lfYYCDVuyW3lGGzYnXGJJfsRyM+IAD50gU+l0KQRnHo/X2LRRvjlagXcZ2MCMb1qNpXz99gMCUGuCcQ10JUtqRBcb84ph8BTJet3imDGck5w/t62rwIeK8CEvb2Yxd6EMTNSb8NSrZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grHGpS33AubpkHk8HDI1vGAlfYVbEughoy/R1z4mu7E=;
 b=k3ZyFYz8ug3u3bIj2TbQm8zw9Y+BslZl9ksQuQVR6I4obFdf7Ek4qU2/DWIET4MGbAVXWZtm4nF4sBL2aT9o4d3PhI6y8M7XX5qyyFPiYR/SzOxiraYSoe4uxCZMsCobMRQivOHvK5Dzt2JIgkKgIk2Rq9flwQ6dZ+EegX6YdQCEQrh99GhKOsyCoA5geLNSg3LXSIB78GqIlxM1E/yTMj3ggF5d5LWOvFCrSukljFCZtzy8af0bN2augWCvIAmXwPtkesSDnheh+uin6jSKSep5JgPHD27FCbA1pk8TAxwiCgvucNrp6dPRHt0BWRKRu/pBvl1XuQP4RaVfnp9sVw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:54:37 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:37 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 11/27] vfio/spapr.c: rename VFIOContainer bcontainer field to
 parent_obj
Date: Tue, 23 Sep 2025 14:53:17 +0100
Message-ID: <20250923135352.1157250-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e60091-ae07-4043-4f8d-08ddfaa8bc50
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T+p1Lq0R7pFisGWMC1eqJ6GypSNvtSYTh/Ce6+S81TGyqJhQO+x5r6GLWiaP?=
 =?us-ascii?Q?16S6mhl5XvLHgd+mQLl8VbNYxopnqcGZtO5hn26M4mgZsIFKTyV3NvIORlCT?=
 =?us-ascii?Q?bxjdKuDMTI2MJHvknLj8svQxAZ3JrC8h/atgpolbohPfMxx/4md36HrqqYd+?=
 =?us-ascii?Q?QecaKR9LAwBiWx2wiwjRMuzvG5uBFeoKIFPnJmLeSmzanyGYRIWZKfAHl07A?=
 =?us-ascii?Q?nzubX6uDd8niB5kKY/Ztgh4Nnjq6to3nwyfUgkFJk3bivo/zCF92qldnlQ7e?=
 =?us-ascii?Q?EfvslZhrnXhl/d9S4WQvvlsyncjtEqBljADcA5rxsLj9H0P0pp3N6opk3DR8?=
 =?us-ascii?Q?LSqTpYfaIFBE7HflS/QxV8m55cisYtZhUfc0smoZNxpLgDbJAwZNAUJ2I5nT?=
 =?us-ascii?Q?cGNjTN2/56VgLn9VFAGNc06SmgP1ENSt5HGi8f/x4HoW0LTCOJMGZuCEkMq4?=
 =?us-ascii?Q?n+2da10yMD0CxU7IzK3UkmJMdN2KrpTALFOtns37Msrn97U7AJ0IWVShhTCJ?=
 =?us-ascii?Q?AIG3i3d0LCMC4IbF72oO62nsNJ6eCP8h90huSZsYl0j7SipP7NbVJxgfcUzw?=
 =?us-ascii?Q?KMRec6cFggdq/3pLAIrZFtJa5LlbhGFihuQ9S2Us1HViH2GW/6pUwSGsWEz7?=
 =?us-ascii?Q?B0YrW4O7RgNRxEI7vze7TLbf7wDA2yoSM4dIUo0aR7tvoM+tqIUatJ9QFSKZ?=
 =?us-ascii?Q?0I6CqOr1UWe7ntEubfxvrzJ7crgSCBLd0DnUScr2daVaCwgRAY78epkWclFV?=
 =?us-ascii?Q?QIiWijxdzSMQiJtvwgFelCo+N6gFOxp4pP5wSBJ5HjklXdI4oaTsWt4qlaTe?=
 =?us-ascii?Q?Ku2P1LeRDD1ts8SALO5oX5FFKtIXxFyPOQD8GvlpWZa9JCgMpyqCrOzFtA3X?=
 =?us-ascii?Q?+imip+4/nbkdPQV1nqg/b7G3MUziC9swdTdHXWUUOki/x4A6zk4LtGMuc5GG?=
 =?us-ascii?Q?9U3XYavi9qnahLAESpZvRF7bNnCL03dqRg1rADYgRWo+f+Fa/mQPqGIiMKAv?=
 =?us-ascii?Q?QPEzZouBvuHlocqBRX/F3QXhZzU6MJLSbXBDLWqQ/aOGRazvav2LZcTMPScS?=
 =?us-ascii?Q?F/hDzmJfL+MbuDJsN4cAaYAerrzTSe+vOBwu5nKnHxcnCnJDkgxoY8vSi+Eh?=
 =?us-ascii?Q?kiQ7NNgnl6f0SP4TDRn3MEkrilQJIne2H2u9TZuRTBCIjgdw+L6hfPl+Eq+X?=
 =?us-ascii?Q?5bKFHEZXlKbGOycPkGD2LiUrZ43oyHxyZjgYc4zJWxzpgAPTteJDY4skGIxG?=
 =?us-ascii?Q?b8+ismqChv2qn+kDrjpMQetLF2//Tvt81xhJg422HhJy6h0O6XVEyBxFOV0T?=
 =?us-ascii?Q?gJJJ6fSJXW2hzDQGMgRuFQ272yot7EOFixsmJwKiZOELcRSmMlmy/wEL9zqf?=
 =?us-ascii?Q?0K0dKHLPBf6NWrCED9AJjO9vWaRJ1LI7bq85OHGh3Xp+PtiOfMCbO47bt97b?=
 =?us-ascii?Q?QUMgk3TYBaDV/tL5dazn/wLqYcN9ECSKYvKn3D+HTdAXlRjUxPpyTQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xwCJF5deixS2mX3q5jqRFPs2+IQyhOtsi7qnf5kvEelSuA/JNTt50tbVBckk?=
 =?us-ascii?Q?bhrtjSRKp+1tpRhZ2JpiGUJb40aaMeYrwAdT2zfKENCkCZDVoor0Vh1YGevi?=
 =?us-ascii?Q?+jGjnH1HnrVgyHjlWz0R+lhdrAgNy38VyKHZArwWQeEmI2V7h9AO2heajdgo?=
 =?us-ascii?Q?6Eapan87VBukcUaezxojBHNiiyxqpvJdZqa2/sPOZFJlpkzyDsFgePAxvuBJ?=
 =?us-ascii?Q?pazYNYFdLNCDomYuxYDCW6WBzB/wHK6IVuHq4kf+PD0KL4VUpYXdt9rUF5Jt?=
 =?us-ascii?Q?0Bhrx98yy+HEK+OXFopfG268mJMI35roTUUhGP+vEcVRXVWTiz6uuQyi+T0e?=
 =?us-ascii?Q?WG90s73hM+wVm2vjNNLCZohN2aYPPw5wEOofcJX+4WA9gaSFQQthIkv8/ipy?=
 =?us-ascii?Q?xWbaggVPZrm6UoVOsI/Zq3xzYu1xoi79T8zIAqpQHZ9msmFL8gEdi3NrEdDG?=
 =?us-ascii?Q?tiHFTiXpNJb/mCx/RlnSgajhhhdlcH0TrRZzUbe4XBzgcivqmXRWJbAZabfW?=
 =?us-ascii?Q?H0heKIUlfxHINz8uwl22iMxSxInPADaZPD172hen29Zzn5Z/XpmXeQvHUzI/?=
 =?us-ascii?Q?L25zl22KQPUclLuCwdjKgxoXNikz1L1v/ZlK7VjdEam3JKVBnb2mNXQHVqZa?=
 =?us-ascii?Q?fkxIxcr+DXv0NLwMNyvRtswa60uEiyN18zRIdp4eUOxK+T6O/zUvpwq/M79S?=
 =?us-ascii?Q?cSo8ggu+H9OmpQEWqPC1BQWoqhOjfEscw3TecvfQrjLvUQLPjoIJKYzSrAb2?=
 =?us-ascii?Q?pbNc2Gf8IsyLZjDNEWXbKkUWfEsWDxgwR7yWfpawauatbKeXiYCRo1Ckxxyl?=
 =?us-ascii?Q?vLFm0S1l/AIz8OaxI3JtYDMuBaON7db8++snry9FGTPowEQ8ISq9Z7a+n8vr?=
 =?us-ascii?Q?hJtCVMD6o0NXSyC6RbeikBKVTTf94J5Kq9V7NbQowLHNT8SN/bqKQhvcanfb?=
 =?us-ascii?Q?tVn9iXTTKbRb3cauGRfdq2zV1BZEicHgqzx2iGfhEEZqruXn1OEEHodOVgvr?=
 =?us-ascii?Q?vHjQWBgu4NmcHUV4hErpDtYVOrKBbI8K8GiXRZ7sflbE6+Bux8S3F8Irg5Nz?=
 =?us-ascii?Q?lNoueGQQSAVjkldQxYPLGCrGglbXwDo3DQ4QMT+cMRo51NRHZXOSLtMsKVPq?=
 =?us-ascii?Q?2+eJDgDO+Mwx8FcENQGlWqUDeiN38FIFrtjBBjeCZuTwAiHwH8HKsOkrf5bk?=
 =?us-ascii?Q?rQgiBJbqVQwXOuQdNwrZ8gr0TRBcf8U+mLhvHzjpDtWYDaRCBbxc0vITKFBH?=
 =?us-ascii?Q?hA2RyRy4XnCtNvjgDy191q4buGhPlMvOZ7aJ/zttuKj0Jr3h5D4o1+3eG2ec?=
 =?us-ascii?Q?FewL8XUA70KKn4P1BYuEb1NgUIrR5/kG2ikFzBUqv+GzPSDSHDwK88rM+46M?=
 =?us-ascii?Q?zHCw3qZl7yI5aLBcmDUqK0LT639eJ312zgZK+d858TJUjyNfmdLLgp7Hek7X?=
 =?us-ascii?Q?QMO0vIZ2iFysyuoVoiTtqr6HBtPtKe2OzrCzv+Sxqa/fxQIqGokWzVmbNILQ?=
 =?us-ascii?Q?evqAOW/oCq5UE0TRIqkwEr6kAbjhTB3UaOPF1lsExbrmN/xJtKoxge8kTZ5y?=
 =?us-ascii?Q?Piu3PAMDxZR5wRob1WfUMLbnuN49J0aPVb1Nt/mfik1eVL3hx8gbqL1e8VmH?=
 =?us-ascii?Q?6iw4CgMhC53Crm7/H6aRtqmYQlANM3nHtX4m/Kb+CVVoXayg5eOl1H+TYsZC?=
 =?us-ascii?Q?V1V6TA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e60091-ae07-4043-4f8d-08ddfaa8bc50
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:37.8535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFIz13N3Dl1E9hr0Xvtj+gcRdbZ5OSdEbQi77SEA3NRMlP4JcLPRG+Jsq5bh3/uh9CWXYdLiweqxAlKM1y+OGfd5TAbbLXFVRETAAHAz6bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX8PLuYBToeDCr
 Eyv4uA63klxkUAyZOsw3ZKlguH+0QRbshgKl+llutBKeDaIo8AhtJia8wslfP69/sCX+D+N6k3v
 UyCWBSEHOxxeHvKGXFf2mYgWxr8e8eiFvdCFfti2pNUaskXFbVcxHhMK/Ut7sbwkEGNnfnNv1iH
 0Kr1ueOvuxPwwSI4a0+srMl94Avb0CpSVVZ6IQBMH0+tmVPKcWrjv4D3VzEACh2BkLHz9RWJOEc
 nhMFNBD/g7fpkVOR29Xdq+CWds9d6ad1X4VYyQTZr1OnihZwR5b/I9GBmakK2iF59kN5LXRWEHP
 /gbTCD3NnRGWAHqI2s5IwG0+vP2zSx01CAJDpusQqjDBP/EdsYOdIGVzf0t8mE=
X-Proofpoint-ORIG-GUID: 0vcrBA4RnKBWbvWxJ8Q39H7X8TMHFJh5
X-Proofpoint-GUID: 0vcrBA4RnKBWbvWxJ8Q39H7X8TMHFJh5
X-Authority-Analysis: v=2.4 cv=eaM9f6EH c=1 sm=1 tr=0 ts=68d2a69f cx=c_pps
 a=IMEwmUWWSCLuwm+xmU4zLA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=8L7MK6Kl4ER3plC8pQ0A:9
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

Now that nothing accesses the bcontainer field directly, rename bcontainer to
parent_obj as per our current coding guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/spapr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index c883ba6da9..8d9d68da4e 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -30,12 +30,13 @@ typedef struct VFIOHostDMAWindow {
     QLIST_ENTRY(VFIOHostDMAWindow) hostwin_next;
 } VFIOHostDMAWindow;
 
-typedef struct VFIOSpaprContainer {
-    VFIOLegacyContainer container;
+struct VFIOSpaprContainer {
+    VFIOLegacyContainer parent_obj;
+
     MemoryListener prereg_listener;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     unsigned int levels;
-} VFIOSpaprContainer;
+};
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOSpaprContainer, VFIO_IOMMU_SPAPR);
 
-- 
2.43.0


