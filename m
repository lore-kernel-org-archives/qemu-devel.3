Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27DCC5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVF-0000pA-0d; Wed, 19 Aug 2026 09:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVB-0000md-Eh; Wed, 19 Aug 2026 09:38:45 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgV9-0000hP-DP; Wed, 19 Aug 2026 09:38:45 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCorvo329150; Wed, 19 Aug 2026 06:38:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=/xASCT7YX8mTW1hlJVXD4EmKhA6tAeAQHdXdc7vxE
 OE=; b=JminNIFPjgWNmTY7PQr/26vdNOO6tITN/k+lrcWpkci+u0DudP1uqVrOo
 fLAm490eIudE1KQJHK57Q3PWQjNnsWVxvjjVdMEjDiHwvVM9J3QvMopIyIvgnHT1
 Ie6o3b0QTI0eF9cKHw0dFe7WdeqFuHAiT8cxutH0/u2pIS3JnstfOB3iiCpFRl8F
 Zpz23Y3Y9xXJYkUlhHVzF1CmxksAJU7JS4jbA+10/UAxjyS5n9rP7pyAHjvcgdGa
 IwkGi6rcyhxi7O0AhIL1CrmiLKJHDlY2sabY339EKeGQgVDyb25qJK5WbyXPZIEh
 cW5gnT36I9j5IdunSg/CbG/n5c9rA==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021073.outbound.protection.outlook.com [52.101.62.73])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g54kf1dx1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdDqV+Y0Ps6Ht0dv2J5Ag5Et3bXcGOxRmxmU1pE0kDvl2l86FRajAlu+Nyq9+8EfNv+48n1ZrYG3+aqcP92Z4tOlMmDU88RUiUlYYHU3hkyUmtiW+vncoKOny1Gr+MCwO8gStONBdscSy25L0J8PWEymieRqBMqdngBSfu6Ajtah7ZUwR1aDPjG5yRIb2kr7DTEfdvuPhShPVSV/d7zC4O/aEnQU58MTkdeWkPZsPpeJD8ko3WFaE72Zh57IWF6wu15rRiAe/LNemqKz5gJ+HqYBg1XvC0qnTn1IyXMv3+Km1CP0sCfJ0YjOfwDT6oi1TyYjgjaccTlyo66/vl5EVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xASCT7YX8mTW1hlJVXD4EmKhA6tAeAQHdXdc7vxEOE=;
 b=JduHEgrXfynqlxd5EoUS5eas7pcaApnOp5kMGAFFloz8lUvBPfqsZOkS+ptQKIZy/PkTXbuunLyFqFj/Zk3S2BEwBSOYJUmhbIhulOYciHO83MeTaNzgDhgs/aH1wLuMSVtYIdAcIRJZukxVN5SpOZ72q2wbpjOsWE/GPeNqRgdAghp7woD9YG63GjQ2b73NZZJ2B4yEkkXOMVIT3yXvzb8FpPHgXzKHp8Wc++5UtsR5exgZcE5r0p96Lsz7l+lP5IfK1Pnua+/viZg5SF4evI89DLrLrzkFLuw7CiQ4Shw5EuHcMWPHSe8U5qTkN6yC5Mq5sxVVJOs91tHimBL2pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xASCT7YX8mTW1hlJVXD4EmKhA6tAeAQHdXdc7vxEOE=;
 b=Dxb0a3YN7xV5iaXxiOhP10yyWm/xLEZNto4t6B0HieCmBjt0FPlI2coiz19KFY7lPAwu6I8ldBvrXnCWLZxX3WpLncnbgRCnfC/UfUr9g6NP/Kxx3upvRO4pZK+3T+uPyPf0wjSBFcJLF2jh3Wuaj9JlzfuWZLzvz/1GAv4OrTMTRHyfrZ8DRt/UjZ8Hj0S74s6u5qYLoUfbmJKwtwODssg9yY2QhYkPvDSSzJvoD9GBxrmTbx+hW0yITmjeOOGJpxXl1rMzNKFwxKiK8iylq/vj1S5W1LTlsnsSvfykOXlBvb7wx8GdOqQ+f/763G4a295HMB+F1jZsQJajvXkH0Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:38:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:38:26 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 02/15] qom/object.c: introduce
 OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type) macro
Date: Wed, 19 Aug 2026 14:35:41 +0100
Message-ID: <20260819133816.3497033-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:806:21::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: c25c55e2-6214-4bfa-1192-08defdf725bb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UCDc64k/OE5yaUq41nQN47MCnSmw7rZ2IfOk2qf7CMuiPVK69mbSnRI2ghDRsARVHQ5onsotjiDfKWzH0HRD8Vmk8DMeF0VQnltAZnPdIEAXqOyEZVLCRX26deJ3LWc1AYn/HFJEbPY87s6a5ENeDioF48NqlvWONp+IB6szZVQLYDQWIz8oKY/dthfj3RVkIqppiOfSIx9fk6LwBvc3lofAv98xoyZ8dYAenSvItPIvfB0pZ3Gf6ri54suKadAIjLeRW9wm+hiIUCK5PANnlrq1iZwQigL0baTlUkmuOP4cs9tTsI5jyLyzVlCO0ZHqeOM6BPEntrMugCOoKYO1Uk3rjFYwKHl+xzfGpn3c4fMEvEkm8IA/Vxo8ckZ5svwa2T4PnjtgTRfdqc+gykegPmTtKEjoDkUIvTNX2DjKd/0r6H5wJSTcs5k/dnAMLQXkoQSY9oNEYEYb0dV+3tFKl9kJTxBZNi79YtcAX0tM5GloD7HvqubXb4oKngno1l88dUkefglaeS0oV+hIdh0zHwz4gDtOaAMBbEMQi8BwnewsbPpfF6oWGGIRIZjrZ717ycFT89/kIGUGTfl5Nc+x6nWX3hcj8Zli9qtTS+8OX2ouwVax2Vk7SiNWCnZfem0y8LMpIvXKrOj3ch5clMQRokSJYw373+3N4TJ9Im5eP6aT/fISvJweXlW7E4gHIIbCJuC72I4OJyAVV1x2gDxHYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QnxmNIRCtNRULj7v6tMVP80fYOCAlZqZk3pGAgbZ/oODxq4F2lcHA9kWrZ+U?=
 =?us-ascii?Q?KwqPnvxy3qp9SIriTswphuTQul70ZoLMY52RIyAw72zkvLDbfWlC62oVr/L2?=
 =?us-ascii?Q?vwy9uyUwIH2yitGyxOOKk58TpqEO2ULcK/5/7GBo9p1YOrpR/6FDBFEf0Lcn?=
 =?us-ascii?Q?xNR4OW7mW869zvs7v5noTtvsLbPkZmPVidrpqDFHH6M7Ii6hf0NQcA+jWJHZ?=
 =?us-ascii?Q?DSzQmpUxHOodspu+qJx842RtYCR/2HiYVVjf5K+F24w4kAA0me+ISr4279Mh?=
 =?us-ascii?Q?VgTf+tyuSSNoQkzU3TX8OjZC359KY29DLOGx9cOGBW+vD+U6PZmOKDxjt+WZ?=
 =?us-ascii?Q?vQ/HYk+ZhGZkfaWv0/4WZeNVdmsEltNY2AjYpCdv2qXj1oxh3O8MIboYLWtO?=
 =?us-ascii?Q?aNqArh2R+OynI5Ed+2BSjpwxhWGdRcdEBsZo3IYIsxVtQWnVNONaLdCNRSKp?=
 =?us-ascii?Q?p82TODKCxfNp3a8Rg3DqfWaYi4cTgUQJ9wpOpC5dOi4W4toxVHWbXV2ogAC1?=
 =?us-ascii?Q?73bagQ2OpXU+81GiH5x6Kc4dJuu+dByUmLTA5EqAIDp4FB9dsF93E8WwpJPQ?=
 =?us-ascii?Q?OLghTTBxIieKMUcIvvjmoIf7qpvtMTs5CFggLhoSS/mFRmosW4JgVkOn4H1E?=
 =?us-ascii?Q?hbsJX4ZisdqdHBO2DyF0LH5yiu/pcbAS6bUO0x6/43HDg+KGDQeSG56atEzh?=
 =?us-ascii?Q?RAJAxh87uu2jO3OxIp/uDuMIH89ZVyPIZppK6r+EvAG0saRIGx1o4oyyIiTj?=
 =?us-ascii?Q?2oC2czDXCvZznDC27kQ+OZ/Q648EP1V17sc7jNSrMfgbz0jX8by5jAcbDa0c?=
 =?us-ascii?Q?/uY7XxUMd9Sp9ISl6KLTIPlEsN8ZPEj1ximESIjdcB5xJ1Kz+YUK+JdK6hHx?=
 =?us-ascii?Q?k8AWmWH6hl4nsrWLPzsIKQtk7eSKe+kQUaX8W3HxTrfLuswa98BkViF0r/rc?=
 =?us-ascii?Q?7qbY+YA8Y0k0z6vjkBo0Nzb4nNfAw6U5yGrOdVbGW+60UHD5IwE567JaHAB1?=
 =?us-ascii?Q?UXY8Z8vyNs7c4wtNa4qclfD3CC9hJeG6rGb8Go0+fNlYMLBvYLG5JHr18zJw?=
 =?us-ascii?Q?sFR7OwT4VmdwXtOI1bJdjeOoQDd2jCbhFoxDswNjdlpFaXRE5xAZ3k1DOesY?=
 =?us-ascii?Q?O2QgEmUrZ9vCtFKzYd6uU8UMpjZgjGYISSEJK/zYKbQAMZRYQY6X82n3kQg/?=
 =?us-ascii?Q?2QNfW53Y5VUiEp9XE3BeUNZua5EpfxWLCDOmz4gaFacENaCHTrdWbspPoTVo?=
 =?us-ascii?Q?RK2HAvB9msPfJZVsF5dkYhQO6oF601GbUhQXsM1BQDa73VsyKQ2enfx1uqxH?=
 =?us-ascii?Q?BbgcFpkclmT4peEUYMzmZrFLq3AHRNJEwzE5eobbDmUdoEd43y7KHDZvQsSr?=
 =?us-ascii?Q?STVBMfyjYTQuR3Q4ZyMCLhQV2N9efBenhDz3+AM8AE58i7eLlbICfXnhw+ar?=
 =?us-ascii?Q?27Tes1QMjHnxq45C3/lE91+uDwUv0qKSPPsRNzlXOuMGe/nbWi+MbloHRqkG?=
 =?us-ascii?Q?UMwffhuOub0kNLzgssrXNNC8Au6L0MeOEM4NGiPMGzkgGyKTEm7hwwkJTe7M?=
 =?us-ascii?Q?KXgfgrWGJKq7jQJAnrndKf3ixq+XpVYKolTlimA7fdO3iGzW4Zi4E93zeuYR?=
 =?us-ascii?Q?1Sl/yv2nt6Ng4m/a9esYS475CCmhA2b0jd7j8F8RgEJNPyf43oYNbxbp+QF7?=
 =?us-ascii?Q?mwb4qZ4g0FJ4RErox2BmWz4YxslKjr/n7dhOAXJx+krowjbFeaf1Jj7ttc8D?=
 =?us-ascii?Q?eqIFe7hSW/LYmsFf0wDGWcdPVBQN2WU=3D?=
X-Exchange-RoutingPolicyChecked: sfAqfqqPNBaLrvqVUjsl77YkqXfbil9opM4A3iKQy99HQ86YliG22BJl0pcLD3KIjPaq/wTqYy2I8QOZw9TyZtxe8O7kZgKyiGUqeqVoWPfB4mWwksFeec+wTJ1ErbakgdkS0tHOpvQZWLPeV/6spDiBN/RYyxXlesQtbwW6q1nUwAaQq/+vTFT1SW4luB053TrnBDcS00FV743QjBBS1aJUP21abpRNii1k8wAuWG8Pf2QaD6qI5zbdzuXkMHmf1OyXg89h0xFxz/uSthUtKyOemrznhtvglnzCRONu8fufSccw6AZUGxvAanrmfE2e4JhPGs5f07KmM4ts2nU1AA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25c55e2-6214-4bfa-1192-08defdf725bb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:38:26.5534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LG3TreOA1g0Z3Y25iTZAPRQXnFEP0q/40PIOhJnxvN5Q2qBmiX7e0rfSWwg1WgLlXPzvhtuN0O8Mdq6QxEQrNdItaX1jw38iXxqGRqysAxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7336
X-Proofpoint-GUID: nF3KCKXuiFRnUH1YZizNJSrANzDdvWfN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX/t0lXLRLb7z9
 R4a9ab2IpJSGKKDv/PuYrLATaNdbyK08OhtmPdPiF+FQKesldN/C7ZNEJfxkV2z8L+rDBL5VIy9
 t+wtkQJANhEicWhcVUDrzfs2tEJarr8=
X-Proofpoint-ORIG-GUID: nF3KCKXuiFRnUH1YZizNJSrANzDdvWfN
X-Authority-Analysis: v=2.4 cv=AfSB2XXG c=1 sm=1 tr=0 ts=6a85b1d4 cx=c_pps
 a=A7BUKRKBnQHIc+bwMO6jVA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=kmmi_7CStG9fL9SE3QMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX3nh0yDQImnt/
 SCrpHLTvVSOqcq73aWrUg69bcqoqPpug4C4QNc6Wb0oHAoBIsXeiRP2hIYMldhkayF2t7ZbG1s4
 /8bWqd7eewZhgr2Lhyo9knpDOFa2pzCPDy/BRl8b2V3VpW7LaFoF1BX4fy5tQdaqoVTf87ZktlR
 p6wZMSmQAbfK/1jmz7KlgfxXQBaE7k2KsP9D45ak/M2gS8VF5eFkmrqKW2L0LZO0mgTfLaciziv
 F4kHaYd4riwOq9jfA0wLtI1/SdrVFuBO+VB6dzOgYeerlODZhr1GAFIWeVRL3aGtzlUyWZDCv1+
 kleHXcoc1IrUpEU+qOI3TOdO2gndlXcUi7epbkK2TZooF/j8dK5HawpGUQMD0qmxpfMBPzBaqqC
 A49GT3yFtEOMfzJTIePoJWr9jon/114VcXECqcaMx0mP7cCh/or9MWDTPwbXNSh8Ss3o0w0Tw6d
 tBrQ/flsDKwC37JV9Bg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

This macro will be used to generate the boilerplate property_class_set_type_ptr()
QOM set function for the specified scalar type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 qom/object.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index e32ae30bd5..fe4e552928 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2722,7 +2722,24 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
         visit_type_##type(v, name, &value, errp); \
     }
 
+#define OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type) \
+    static void property_class_set_##type##_ptr(Object *obj, Visitor *v, \
+                                                const char *name, \
+                                                void *opaque, Error **errp) \
+    { \
+        type##_t *field = (type##_t *)object_class_prop_ptr(obj, \
+                                                        (ptrdiff_t)opaque); \
+        type##_t value; \
+        \
+        if (!visit_type_##type(v, name, &value, errp)) { \
+            return; \
+        } \
+        \
+        *field = value; \
+    }
+
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
+#undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
 
 
 ObjectProperty *
-- 
2.43.0


