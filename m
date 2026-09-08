Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E481C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3x2Z-0002lb-Cq; Tue, 08 Sep 2026 10:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1x3x2X-0002l5-FT; Tue, 08 Sep 2026 10:43:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1x3x2V-0004DS-Rf; Tue, 08 Sep 2026 10:43:13 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688EgdCn1744008; Tue, 8 Sep 2026 07:43:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=/pu8OhMm4k9Yy25
 GSoyaEHv4kv2Zwg8TnUR+I/4kSUo=; b=0Y1jbKtlmxh/IliQsflNuZ3ILEb0oH+
 cIbzckr9ovTb6mSh5cBxLRkpJ1WpBfZ/fy4GsLo8eLuDI9JsYHWslykoCf4ohYZp
 yZif5vayzZYU3c0rIQTzsDblh9g/ZEj35bpk5cvSBvvl8UeaR38mpQeK/Q+LXSUp
 ZS7DahGsovEZPLsIZdc80AsLcg8PP3xAOskExQgTL8du+EIYCDYkc1Ndve5vm6gL
 LDcUyKE9Izdd2GsUgAjFE1wLOgn77ikDdeAIyDKhznZkeA626XwJg5xmKt4uS4nx
 eabfX83lRkuT9b9q4PcpVfnYt1BEGLTavrF8wnYit2RapAKrflOvZYA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020141.outbound.protection.outlook.com [52.101.46.141])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gjhcf8fpq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 07:43:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCTnsYBZ1DZTB/yv6OSw8f5mIu67TRNtJQH5KOTHYdlARdDWtW7vYm/orTJfcSzfefOh4sYpRGbtnp4Xtb7K2bfnG4KS4N20O3lrV8eygwNHAMwHnPJeL1WYQboxNNBuSgnITgpb0EUPBilNjFYVrCNytlu0VxJVfE2bHN44oOKLuxBn1Wd5YXRH89/Whelaoo2ape1JHMROe0hA4iYsOSSlVGRw+ieZspjUGMldql1//MjzTH6GrsiLTykOP8+Lugx+y9crBO23Y6lh1MTyG/UR/fl1zyQC0K8VVGsVZYag8xL1WIzqfJGm/9ms7ky9j81ec2a1OR8soHYTdntKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pu8OhMm4k9Yy25GSoyaEHv4kv2Zwg8TnUR+I/4kSUo=;
 b=isBFLH9j0wXxpaR5ErSfF8vWg21jDXC9bahVL0dn3y1D4Yxqe674MA6EDo5+X7gKukmLygzrP6azNfYAprst6YpxfxyQTE/zxCBT65lQX63XgGEwPvnqZj+C9K/pahVxDH6an0Jtg4/OUYgZ0dNvXPtuX2ly/ijqGzsgDtJDoprI4DFqPP3pHTaBZCfjkmdKmBhlM9L2n8cFdKdKgIlDKVZTt5NvNrCyG4Vu/kztoWNnuHrC+bGjYkWKAhQyBtqW23U8KKYmuYf0TcgRp2MZVbw6Dp1jSvFCwWVrzGJ+afrDg5/iX2v8wFphiLSRYDBtkh8D8wyAGnubOXzYKlfsFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pu8OhMm4k9Yy25GSoyaEHv4kv2Zwg8TnUR+I/4kSUo=;
 b=mrR8h4U6i7ffSIhep9XB2ugOeiqxX6gkNTYphRwtUYWjus+q0175UagBeeJKyxFNNwbbnZ1oyuOZUSs/O0Td6XJBBE35K1IHxhDGFGhuFetN3GGjdNOQIL0dZ4uP3JS5+Ls9qLNxzRn2eDli4YCRQOcKsmp7ae//JXhG6pxgO28c8DVeJjsRHAsn29wsbbYWYKJ4qOWMocIMJci6GJw1SdkS5iNgl/EhV+A9r/Cr0CoDfNLQE5cr8fi2JHUajMkiwcCqBKS0L6jEI+VBP/hQhxjSHFNNUV2QK/lQXzi8aveaRnJrxBs/uI6JNWBWMx1vhSaum1BADfEx/bdoRGTKzQ==
Received: from DM4SPRMB0047.namprd02.prod.outlook.com (2603:10b6:8:6f::16) by
 PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 14:43:01 +0000
Received: from DM4SPRMB0047.namprd02.prod.outlook.com
 ([fe80::8790:d3e7:341d:9a73]) by DM4SPRMB0047.namprd02.prod.outlook.com
 ([fe80::8790:d3e7:341d:9a73%3]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 14:43:01 +0000
Date: Tue, 8 Sep 2026 15:42:56 +0100
From: John Levon <john.levon@nutanix.com>
To: Hugo Komatsu <hugo.komatsu@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Rafael Castillo <rafael@trfs.me>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH 2/8] docs/vfio-user: clarify data_fd and DMA logging
 behaviors
Message-ID: <aqAe8IrLETVjC_OA@lent>
References: <20260903130833.1437632-1-hugo.komatsu@nutanix.com>
 <20260903130833.1437632-3-hugo.komatsu@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903130833.1437632-3-hugo.komatsu@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0623.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::18) To DM4SPRMB0047.namprd02.prod.outlook.com
 (2603:10b6:8:6f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4SPRMB0047:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: d39e07c4-13d8-4e6c-c3b1-08df0db77b82
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|7416014|1800799024|18002099003|22082099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: I82d/g2RUNhwd1Rc03HEa/+++ShQhutOlLtGSH8jV/2nJVMuBtr4sf6SDhc8tD7Xju4ZXAMX4zbdovA2aP2qlkvaui1CeUk4z1a0SDFVNJCBOdubrWhONNR8y/JSW7yYt+RZsYV6du+F7MkpgWaM5tMw1FbDa5fdepqegAJ/70M2u5+8yxevTvbNdNjg8KYSrGLCyIQo+sEzUKy3OsQgiRZgS3Bn4lXhl4pDzZjTsI8KZ+nC3YT34kOif+RTTGvdJHNuqoY668CqEjzPCAnBXIdDUWaw3aFENwQ0IWPOQwllhSxcSDm+s310zZr116SLYGOtQYgcr1omSkkFgo5mpr3dpXsf3m51AFKRbekK6CA8LLMjmqS0wfoAdkr2GgiZUzlLRTSGSfSJhuY5Hf9isV8Ky7KnppdO7+rJ6FWWeNY3YCa6NmVGa0C0ZJVzSOXp1Eluii44KzVTknvMhVq/vrAtLz7E0gTmW3KjOMvxdzf0XsXTFw2evAd07dc2WDW9mmpDCHNBC6IeWUM40nI39AqwPXGLsXe9wk43Nwu0eW+cQ0l2siAbdbf6wayQj5+vIKbcnvruWEKr+UJvWcZkZAoPvK43pRcScSng7WeJhjKG1QAxxAoE1ufi/Q/dqB7rhe92quCuLfOS+ZQbBPVqZmIt1H3m9ampEabm4hBteLA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4SPRMB0047.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x8/vuki+lUjXsOAS+RtJaf/AuihePl9PvauZUCk8Xt0lzQ6q3GtzbNuxbiEs?=
 =?us-ascii?Q?THmiz2Om+a3G2YvSV1JO0TdKjHo88Vq5GBA/81MG4RPEEeHCnqSZ50wPbUi6?=
 =?us-ascii?Q?3lFLEP8QDhG4/l2yKggmyamqM9Ci/wEO1jUebJDEr7RL7aCoYF1MiW+AqXC3?=
 =?us-ascii?Q?XLihmupI/n8KlkuZOL8ry9uTr+4EmZeqFdz747D+/0/w3TIZatxDAtCg5M4I?=
 =?us-ascii?Q?RpFZSymQ0rItIqtj+adscTgUFnXbD9g5hd/AvcrEgCVQcIxyu7gAnbeBi2A0?=
 =?us-ascii?Q?qAmj5A4t8NDM95lnvah0J9x69rxJ3+658h5ZHIwgqJ3kpnn9l6fJdzp4mTUI?=
 =?us-ascii?Q?sy0UAXCyqCxlVvaDcXFEaKdKIATAKoobcQlr8Y1Vkp288QVHseRQUoCGK2ED?=
 =?us-ascii?Q?2hvVV30STXOI8Z6nw/VJqcP3/2l/y25CK323Ue7fANsrH+Pb6J7HbtSLPr+E?=
 =?us-ascii?Q?YGWFYrZNuo3wogAQDM5OYzhdJarpey8Sl7LhCSOAppecwyr7dntFQZROvfCh?=
 =?us-ascii?Q?5l+V/IRQa4BDwlYEL6/twwyGmkjt0E+0NGzSd4QgPr5ugwmm6sQtfAvIweey?=
 =?us-ascii?Q?dMiPvKAuu9fottXd7tcq+N62yi6QfSM2N0vT2QrO4O8ggvOGOVycedirvqk8?=
 =?us-ascii?Q?xg4A+ECEh4CZIxmmdhOFyDoX3eqNJMZpRch1gCwnvQwWxd5hTnhNok35gDVV?=
 =?us-ascii?Q?8RkU5jUxrMpWO6wkf0NGTGveGaGQkXbEzLiSC54IN63eXaUM00ktEQgki+Mj?=
 =?us-ascii?Q?8ZgLFWRH3+tbDc07C85FBlaChq9DDRMpDKAW95m61vKaYlgOubAMaflGUr7i?=
 =?us-ascii?Q?uxrDYRSjNmqt/btp/X9gGFZNluY9Afth3mQzSexiNzVZKPtNstyUuFK6ZEdp?=
 =?us-ascii?Q?rU1xg17ZnkcZ/sQsQE/eWM6vbcXu7nqN+1lW7GHbhEyxeR4NeajCZFjxg0pp?=
 =?us-ascii?Q?QEpN8ot5o+AFSmMscheNyT+O436ou6eCrodIh+1ffR2X3nYQEShJSa//IKIJ?=
 =?us-ascii?Q?DpoFRPTc7Ai5336DjFCWEn7RSFvuLMiV4vias9OJ7sjtrmy6UlbA+8kn6JVq?=
 =?us-ascii?Q?UW7unw4/xu0OdO6x/LV+NGKuriSfzf13EI4gzpNr7O9tQq+DMEcWzdQCTF+q?=
 =?us-ascii?Q?20Vn6r+e9Q2wPBEXZTKdf5dMvjhv3CxA/MFgHXD1F2REuXWFe06iJ+MJ39Ik?=
 =?us-ascii?Q?yU70Bxwi1UbD5jcpjFLs7nnQ1Nbi3NIAQQFKm4Hqz632LeyVGyEnVy/ZA77f?=
 =?us-ascii?Q?PVf79SJQ1k9jPnHBXGB4DmaAszPmN78YtlxSHKjLCsLn5k45ewSUa4dkUOKb?=
 =?us-ascii?Q?se35n0usO3XomyceG6Yom4u4tbBPqWJI5xNIv8FgEEv2qEtuMsNr5Iyhnum3?=
 =?us-ascii?Q?rS3TgYCwP1rc1iwTzm8iUuCmkE/FWtN9MoIy8IsGzlBLrgwtFURdfZmWxchG?=
 =?us-ascii?Q?x/3VERRhlIfN5wcQkdtXZBco3qxNmhA+4rkt3xycNx0VAqPqsJzNxqwWLIHv?=
 =?us-ascii?Q?OQjgIAaDkSowOold2qFgbeJZ9urCMcpZegLlEZ9y1nWsZaTo5w4P4NnS0qE3?=
 =?us-ascii?Q?NNtMr3CSrDtI334pIH7r5R5CoTvMvhoTUx+BZaSwFpdtkUnX++Zuxo3k4Xwq?=
 =?us-ascii?Q?+hEoG0BrcFSDf/5V6wYY5D7H6MLxzcwnFBTdOLzF+grrlps+jvVIN4oIY/DP?=
 =?us-ascii?Q?VeqTNYkwHHZWA9s24g4cEvGSYWGO19Gpnh9YjfpxGbyynRvrd2wBlGJtr+6Y?=
 =?us-ascii?Q?uzFWUcH+2w=3D=3D?=
X-Exchange-RoutingPolicyChecked: kx5xIDXagzPaLX6OnWut/WXLu5VMRFqm95cv9dwZ6G2xa7Up5Et+4wj81OA/25JLG33i2EeuooATlBTcXzLqDt4jOCBgA3F6ndl+Nqz4Kecf9PA00c2fqHkWZ3i9QTRIyCg4HMsjs26MUcGkzzJ7CPflS8KVf0UiHnAQ6QB/k3aFDQpVU+NJImHNhX0hL05XGnWxH5QHQNWUKYFhQREXldttQy1sXfXaAuon6O0fIbJKl6GrrqY+41zIO25W1CEzvVoBdnbgWbzR2FLFUoJdkdraMFViY/pYo2dnAq8TRWZIGnCyBkCB7HPJmjwWGqhCAWJAsEcLHVxyQQ62vBdMzA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39e07c4-13d8-4e6c-c3b1-08df0db77b82
X-MS-Exchange-CrossTenant-AuthSource: DM4SPRMB0047.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 14:43:01.3355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wc+N1rzi2dn7dj9D6orH8fWV8nYuj9W5eAiFHnf3NyZWNWd0Bw27IbarBCzOjaFS0YhVacsHZESwKA/s4O00JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Authority-Analysis: v=2.4 cv=FfYHAp+6 c=1 sm=1 tr=0 ts=6aa01ef7 cx=c_pps
 a=VxO0TNiV1+gBiOWqST4D9Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=YW_7lzu2boGsn7bCcngA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE1OCBTYWx0ZWRfX+qXqaO+F8ulF
 THctR6NBN5aOPRKkFPj8YoVXD89EXge7Ht604Qp3J1O9sZdeu0rjthcwBFQktSvuFGoLZSuKfeY
 LMM8W1aeuNMUzwd2FfJtL6CxUNLGGXxAp0DyAmdXTax4PVMLGasv1K9tiQSuYsOF1elmk3NuDOX
 9gISPsdpRtc7+nLeOy9llu2hTgKYwdIo9mCiIRoq71Szt8uyrLyJKRWGzURWk8Pd755hYlrs2JX
 +HNBSJLDK74LHFNyxrd2zUk/PJKDfXzhrYxLoF+GhesM3iciVUKymDEtXS2OG+n3LoCNUidmFtb
 NiNUIEUXDZLhUvbWAfxUp7iT/ImoYDUONxR5JSMdp9KIjMyhASVMFptHl888KRNO1f8zl954FQ2
 kYak3/TqntfB9dBqZQn5FyLcoO6eJD6XlhMw8cSp6GoNvC/RZDLQS4glEUPjukoyEzgfgCcasmK
 dnqf/23wzmPXgivZYfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE1OCBTYWx0ZWRfX+1AVDuhDggue
 QIhX5+9ezBIKFQ9loghjQblQLxp8/1jMaSc6EsGhGx5lY3Fn6G/Ov60D6HNICy/XQv+H9q98uU2
 R6B89vf3Bo7KWHcjfFydFyH9+X1epo8=
X-Proofpoint-ORIG-GUID: 51lgILpUYb5AE1kFroy65Sci-M4yNOmo
X-Proofpoint-GUID: 51lgILpUYb5AE1kFroy65Sci-M4yNOmo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On Thu, Sep 03, 2026 at 02:08:42PM +0100, Hugo Komatsu wrote:

> Specify that the data_fd field must be explicitly set to -1 by the
> server, rather than relying on client-side fixups.
> 
> Clarify that the server must return an empty bitmap rather than
> an error when reporting dirty pages for unmapped or message-based
> DMA regions, as the client tracks these natively.
> 
> Signed-off-by: Hugo Komatsu <hugo.komatsu@nutanix.com>

Reviewed-by: John Levon <john.levon@nutanix.com>

