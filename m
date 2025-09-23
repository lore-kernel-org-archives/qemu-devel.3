Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D99CAC5AC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 13:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v13UK-0007ib-W7; Tue, 23 Sep 2025 09:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Tg-0006Ub-IU; Tue, 23 Sep 2025 09:54:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v13Te-00041U-Cm; Tue, 23 Sep 2025 09:54:44 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58N9oe662985795; Tue, 23 Sep 2025 06:54:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sgV+a3DN9YHwK/+dUXXO+inocQRhybszIM/HYtUdj
 m8=; b=i+DcnEBvfu6tfRM6GjwU2HmksM9D/c0krUm+zgYW7ipoQsqEyf2uBH3xf
 Rwdy4itVRHMqU9YdFvY6j0v137UcEBJxVumXvOinAywTocYBoHCXMnLYZ72uGRQ8
 Qm8sdsP/894KhNeFLRoW0geehf9dqjm4RoDxUDRMhRrnzaVessuACLlWSGqpO66r
 0mnbBhllnSsQ3GcEUKeJuiv/Cebuo5yT/+ie6hizCtJPsUCTIgHjCysgmPDXaJsS
 92ILTxI53Mgk1jz+4qFNc6YjdcvyrVYjLK1pt+SjN64M+cGnFC1OcaNdY7xaSmK9
 6i0SRa6ibF4ZsA92e95VG/7scDZQQ==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020083.outbound.protection.outlook.com [52.101.46.83])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49b6tju02c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 06:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suEf+OttV5Vm4rIY3BWBuPS/RTEBhktlwV3MT86+W4m9kLmTW4TNe1OovXp+ZxwPWO3qrpHrv3FnWexgBQGqewsiunDi9GaEjn3L0aMm14AarOGflunf7IW7VRo68QfYkBIv15AMy8ZDsMyuEqxJiTI08TGnZirJSpD8zD5eHlTArFM/zYsIgLQSeR0ubnZX6O/vRhjSrYinNKvGOzJgEWLtedGJffzDJsgDjOQ1CdhQDgJBUgcwU3MJVgmI/sh5imiOcZoSxrcPb2kqkmYbBVN/AqfOJS5nmbgE4SUcRjgdMqxUy71gVOcXBjTJaSoZ+v2yo522DwNnkQW1fDMC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgV+a3DN9YHwK/+dUXXO+inocQRhybszIM/HYtUdjm8=;
 b=ITAawmYfjte6tlcIy6KfqI7rYVYPV2pC4By008pdn8BVpYjNBs4pNM8qZu9N+gbjHeUhjbhEaCdeXFE2famM/JEL3Zn6cgdyj2NTxUnQN8nkPEqXllBho3svqYbhC2H4bKi2LxXhzSrRcrdWtTn4GcqIIHFUab8KLnve7ed0O97VEGztJo4k/RB+UqYCCcQEolklvmLLz9Op6vUDBRjxbEsad6RSkEJZwLps6jeKq0utcwk1mAIJUAqQjUaVJC09AXk9njmORPk4iiG+QIW+PWGeQlsk8D5t/81BpZ1JydryHh1k4cavnQAudOoes1xU3yJn9JLiJ7jyMco4It0i7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgV+a3DN9YHwK/+dUXXO+inocQRhybszIM/HYtUdjm8=;
 b=hm9p2KKWJ/WF7RqDcevCACFrNc7uKxDV3GA2lFf+D6jA55D//RTYHZeQdg+ryJ6Eh/ywzHtulCtaCJgXTS47zx8kGGS4DyJS6sWYsZg726kSj00xlAULEgOo+SVPYJLZV3JcDmeBjHJwgFBfd+W9Csyg6moTDPgfTwfaGK/npMTleSa0rFO8BeIf6fSLK0v2i1VTvmyY2wDVhbn2Rd85kYdvtBR/gO5gJFTMsUN/KK1DS+3Y2PRj7haNcYmMmnqrrIWW5tLD1DSZT3isHgWghxS1SazjoPbH7VSqJg3+RlbFwt9wo+1HmrMQ6bNeRGkpP5YtGKRcBLxi368RF6Bgmw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 13:54:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 13:54:34 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 10/27] vfio/spapr.c: use QOM casts where appropriate
Date: Tue, 23 Sep 2025 14:53:16 +0100
Message-ID: <20250923135352.1157250-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:205:1::48) To SJ0PR02MB7168.namprd02.prod.outlook.com
 (2603:10b6:a03:290::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d472a2d-d533-4a1e-10f3-08ddfaa8b9ec
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ssavY2bjry+4jawglAc3irp616G+dM6XA6JzJOhg8m10w4QTm3s3G2x2mu1F?=
 =?us-ascii?Q?wD10o4Uhh2dYULSOdSICBYnS6A02CD1k4CA+fOzhBpEcElgYEOIzGyrk4+rJ?=
 =?us-ascii?Q?9J5tLf1ufHcelXXniViSjs/doOo+MENB+2fO28JAfGHKezIRxsIrF2EilwlP?=
 =?us-ascii?Q?HTNpdl6b6LTuA4AM8phb5+nQKpGVYxLQn/v7leAMF7ZGSzaGTdx6ERBefk73?=
 =?us-ascii?Q?1sFHL4ukgp8H2ZiRe7QQflnRVgJq3WUtCYb+lfnpBs+LlDis07B0hBX8LW5o?=
 =?us-ascii?Q?CBaw9j3uILfLzYI8XpkC3apsZJHJumdHYViHefjTPSQFlU0XJEtbZn2GkT1H?=
 =?us-ascii?Q?KtVtaegPVtBv8FuLcXZNIoitIdTvKDYNoRmjeEdjl1+GP96yoIPFO21HmOtd?=
 =?us-ascii?Q?+x/HhLFvpSBdXpd3W3bcjZPlHrNE4FxkLOh5hBJo6+eCypRpbgNhSRHQYGHR?=
 =?us-ascii?Q?cjMiWAPPypdHc11D9Xg27A8EfjUoTYPgeHITQtt27QGEsW1yNrJLkfnWtACU?=
 =?us-ascii?Q?aUK/on71MrsFGOGYxmXmialruPRPA8oxAKLsU5yZ3L5YmaOcN0wXRJ9aqb2X?=
 =?us-ascii?Q?fz4FkN0JL/KT1yT45ZeC4LpoI6V0/XKtNQRxQYtEROPhaTnmAxOx1jWEzsUS?=
 =?us-ascii?Q?LaO8su+zYihQZc3lO3DqsoQ1EgQQFvdXg1QuZggfU86EE/J41f6gUwXtIqse?=
 =?us-ascii?Q?tR+rHl8JiA8kRU2hnfukyByvzaNtAb8JqrrTJ04lpluUWPXWykvNXP1L9Qb8?=
 =?us-ascii?Q?ZttaZ24hC4MRSaQSCqlW11+tELEK5a3vIP5Y023Gj5dK/Q1spFCFqt2f4FIn?=
 =?us-ascii?Q?O/FqrJ96jyQJx8R0gmbib8cqGTMCnEZ6sKZ/h033II/uUY1aoN0jQGL1RzY/?=
 =?us-ascii?Q?jwR+Yq5vm2kJtSL0FM0EmRajVelk3nGESkBJZPVET2IyIX/QkC1pIavn+NE1?=
 =?us-ascii?Q?x6Lp3pEes5CvJ7TuSF97rZ3zsCOESepVQqzESoygZHLUxvMklZ/p9ffFknbF?=
 =?us-ascii?Q?qq+UyaQ5BLpKCDcF1Jd2J7GaicEgY3X/psV2H2jbnPk+NBGMle+IEN5n7hCd?=
 =?us-ascii?Q?BQqS35qpf0AMfN2VWU7wG8izdWn5X0zyx16aGKuVarOQB3wH3c8ZhLwnCVhd?=
 =?us-ascii?Q?3Ti5IilB/UXK/3pter2F9/xwIMSf50IQz6UIpvNnf9KeMfxKlK/VYmUuvIQE?=
 =?us-ascii?Q?42ijserT83jzfAupZa2n7Md1bY6jrxc/PO1RHO9t5EMCE/J2gFiNEn5IAa1S?=
 =?us-ascii?Q?LBMZSiEZwpBVvmu963u3yCSoV54As9gDcNSq8aVcGJUYkFQiFOH+Ex+841uv?=
 =?us-ascii?Q?GpyzAaQ5MdssFvNtdP+7XWcxslwOew8v2iTFhWSbNurLMpVr8NvqnTwFB6do?=
 =?us-ascii?Q?IdivVW/GVDNpolh/RjNAKl7ZYE2hI2wdKnwqEUbtf3+xa6vWWjCSkfUo5PNN?=
 =?us-ascii?Q?badGH17Uuc4clIbfh3o5/cYdDiuK5sYvBbXd0+435pXRdpHYwvkS7A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gOwvTBejFw+dHgKgHA+70oARKHWmFHmDOQdltchDFwQQdU0D+zMUIxINQ6CK?=
 =?us-ascii?Q?apwDj2fUibtJzsUDSqLyks1nWLMlwar27qfsYxcSgbqnI+njIENI21PFPQpU?=
 =?us-ascii?Q?CZMIcbMA3k5VpyaLDmIie6fisEYK6RkPnliriEtlzhyvznczx/ev+rSJBKww?=
 =?us-ascii?Q?MyyicbvlK1uxy4lk6f2khWCZgOA25H7XLCckGXb3D0LqBxMrlojBq9cnszNs?=
 =?us-ascii?Q?Hq/hgVOuth3JndgcRWSnPeq4kPiwsPhZSCFy8SlX2aLEkiFXO7WcB0NFyKR/?=
 =?us-ascii?Q?pcD5AAYXasJ/ln8PH3iQI/3q12V3gnulP57cNUU3HXaO2NU8ycW7e4jD906Q?=
 =?us-ascii?Q?bUfz9aj2XCxcb/r/gwx3ShFEvyr1P72/Y7xwhOrbC4cKyzu3PziCjrq8Rbgy?=
 =?us-ascii?Q?xXxqOdRONC1hQqROa3OTJ+jwQ5l9hdi6tezHOJLHv4h4+BhU4F5LFEp4BJNO?=
 =?us-ascii?Q?D6mrWq5LTlyaN4pfpBrpdDfDF8Jr3NsPToerqReme9pASc89xjYitqDAm4O6?=
 =?us-ascii?Q?QnBRFUiLMl3WQZOMCl2lTO716V7DNvUIzDmWrvJdUUu0dTpvK+khGsyoP7Jm?=
 =?us-ascii?Q?63Y8cEy/PiJrh4FnmvtNnbNOXrnC/n8HT5BcihJQLYlBzFhDznc01chXY7IF?=
 =?us-ascii?Q?2qySOsyM1EaG309VtPcRggqfNUJO6kLx6uOoc798iX42sVRedBrbI1zVhFzw?=
 =?us-ascii?Q?Mv/h04RQgHTQV99yQhoLj0KzUqshVun1tf4TYu5gf9599nz9v4vu1dLZ+4/H?=
 =?us-ascii?Q?WQCCKqrdQE9OBv+vlfLxoxEeje412qDD++DvkltPxUAG4R4gGpPCOv1+L14T?=
 =?us-ascii?Q?JC0Mm8NtiCSK1rDUVR4QiaTaoS0I7Vmz0SSBud9uX6Sp4gV7L2wrc5BP+0I/?=
 =?us-ascii?Q?bNHjkQGC4Sg86ZqAKSBam8keQHe8Pa2vXO3ZZUn14E/MlLIQqa1pqGbYP33v?=
 =?us-ascii?Q?d71Gz3gF3X2YPMcy80WYg61A2W86mlR2Revn1FXeN1ZMSnqg3r0ZTY1z9LtM?=
 =?us-ascii?Q?vxiezwPcXmgwu9EdfB9Qm0LTwAPJOYmtNeXMgvuv+ZAYWtJbZuNGHAV3s0om?=
 =?us-ascii?Q?IWlifQz40LHaZ+3hVoBafP9K06RAaFI4RJYBiXw5RtwYWTHBe8Qgpb+2pMPg?=
 =?us-ascii?Q?mjIH/GyKiuyITz/9K4urbUlxIvbRXal64QcCHVmlV2KmAaxgLLjblXs5pmeT?=
 =?us-ascii?Q?amadqoGYVbIE/y4UAUmAsWWKXex+umuFC7IjVlCcpp1IpikSXuhpG0p8EYZE?=
 =?us-ascii?Q?VKMIf4NQSKaRym1BJIpzm/EFTQxoH8jp1DdkDJh1q7IPOjr9CUc+bHJYqLMh?=
 =?us-ascii?Q?+nrH+ZuJA2TPStfywBWuV6Dimcv5D8F7zaiQES4Dx34hju6Majs4ubJYjmat?=
 =?us-ascii?Q?eyRxL0tGlieZcF2L5JZM6uVJOIHqzbufI1fJy92GqupR5TBOWdisiWGT1V6o?=
 =?us-ascii?Q?CLWfb49fqWxMh6Gu56NXgFlOUJT+U0hwfxABCwBUnsQnrDznJ8YbHUT2Wy7I?=
 =?us-ascii?Q?GLPXKqW/cF3r6aPo+0i0xC3ujAhJjof9UPcvqOZDweHm+owbY5jXXVu3leRR?=
 =?us-ascii?Q?azv2yiweeWQ8vFW0z9+7ZmHqjbCWW6qyvuC2rlVUpXn2dwTjtxpWEmdtghaG?=
 =?us-ascii?Q?JQt0DeWAImHU1l4EH2pETrL0kKkzQtDvuDhAkDSPZ3Ed40tM8O5z2+CRXDPU?=
 =?us-ascii?Q?ccmvQw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d472a2d-d533-4a1e-10f3-08ddfaa8b9ec
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB7168.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 13:54:34.1167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MRQuSTJHbG4Q1a25PJ7oEakfcFxMNwAHvpKmmW8t+sOv0mMddZ9P47PmomyI1vG0rKrie+DfoMXI4EIZVP1x7iloj9ErBqVcctfDRRakyp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Proofpoint-ORIG-GUID: s8h_jF8pez2Ry5xTlT8NHDYzRR8DKoBK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEyOCBTYWx0ZWRfX0zX5w+etIAE9
 0+Uoq/QF1Zm68bHtgjoPKVm7jlasyWbH5VOOkkTVc8EyHUnKYtXzT4AFk1GRjCAKAyEOrjQLRuu
 5A4+lWcNS8+Ugxxu/On5N0E4A5+lbbsZjLMj9tHS5Vbkrq7A/P+QIgJEZy3ho+b87tq0fMDAPr2
 bORkj9EvF/G3iM/HvRm//Wwy7lZ3rU/ahO+8mKrxfYmCKxUMKySELUBQ3YE3cIRYQ/VFlXpNdvs
 KWBJ2lz8hAzT6OfMM4tDJC1M61g5zx2R56ZxmtAysmBvrfuVGyBwK4kUn7ilXliF/FtBpRElQOP
 GQB9uadrOlnjvLMlH9nBsxRTa+bjEVRG5SmiDiH9ISm9dg9wBwG4WGd6Obj2Jk=
X-Proofpoint-GUID: s8h_jF8pez2Ry5xTlT8NHDYzRR8DKoBK
X-Authority-Analysis: v=2.4 cv=BJSzrEQG c=1 sm=1 tr=0 ts=68d2a69d cx=c_pps
 a=pfgRl+3joWazjPSajX+lRg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=c0CgGTMH7bFtNtui_9cA:9
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

Use QOM casts to convert between VFIOSpaprContainer and VFIOLegacyContainer
instead of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/spapr.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index acaa9c1419..c883ba6da9 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -61,7 +61,7 @@ static void vfio_prereg_listener_region_add(MemoryListener *listener,
 {
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
-    VFIOLegacyContainer *container = &scontainer->container;
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(scontainer);
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
@@ -121,7 +121,7 @@ static void vfio_prereg_listener_region_del(MemoryListener *listener,
 {
     VFIOSpaprContainer *scontainer = container_of(listener, VFIOSpaprContainer,
                                                   prereg_listener);
-    VFIOLegacyContainer *container = &scontainer->container;
+    VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(scontainer);
     const hwaddr gpa = section->offset_within_address_space;
     hwaddr end;
     int ret;
@@ -245,8 +245,7 @@ static bool vfio_spapr_create_window(VFIOLegacyContainer *container,
 {
     int ret = 0;
     VFIOContainer *bcontainer = VFIO_IOMMU(container);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(bcontainer);
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
     uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr), pgmask;
     unsigned entries, bits_total, bits_per_level, max_levels, ddw_levels;
@@ -353,8 +352,7 @@ vfio_spapr_container_add_section_window(VFIOContainer *bcontainer,
                                         Error **errp)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(container);
     VFIOHostDMAWindow *hostwin;
     hwaddr pgsize = 0;
     int ret;
@@ -443,8 +441,7 @@ vfio_spapr_container_del_section_window(VFIOContainer *bcontainer,
                                         MemoryRegionSection *section)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(container);
 
     if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
         return;
@@ -464,8 +461,7 @@ vfio_spapr_container_del_section_window(VFIOContainer *bcontainer,
 static void vfio_spapr_container_release(VFIOContainer *bcontainer)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(container);
     VFIOHostDMAWindow *hostwin, *next;
 
     if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
@@ -482,8 +478,7 @@ static bool vfio_spapr_container_setup(VFIOContainer *bcontainer,
                                        Error **errp)
 {
     VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
-    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
-                                                  container);
+    VFIOSpaprContainer *scontainer = VFIO_IOMMU_SPAPR(container);
     struct vfio_iommu_spapr_tce_info info;
     bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
     int ret, fd = container->fd;
-- 
2.43.0


