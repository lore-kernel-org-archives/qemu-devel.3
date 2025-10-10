Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0EFCAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 10:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7AJG-0007DF-1x; Fri, 10 Oct 2025 06:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v7AJD-0007Ci-FD
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 06:25:11 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v7AJ7-0000QE-HI
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 06:25:10 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59A7LTwq484404; Fri, 10 Oct 2025 03:25:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=Jq2hrvPepYCXN
 6RsYmN148MtPwaVBUxAwGABNh2Nfek=; b=AVE9qA+lDUFf6AwKHBD7sqQXbkh0w
 MJRt5sdvoeHZvbk/OvWXpBVNeswWZ/9+C5H7cNGePuMCASg3ojj2F5whKqA6lMB8
 t+N3YauKJUeyFZcrj6/3nhD3NarhyQMtDtWavWsYWoUJDDFpjKZob2xf+O67eV9p
 QyHWYjg9TL3GNtNsjX5QmTWGSN5TXMQcciC01BB8GShUbltNLQwhmCAPpTk5wZh5
 Wead1jWRuHAFA3doH0zjrbQ50e7Ism5ztwE7MPIdKxcq5FnTmMPaxzPnl+L8Qgfz
 qTQSJTuHskiGiDvGmbu3gyJArU1IuJ4pO05mDYB09bRy46vAPbh7YTQxw==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020117.outbound.protection.outlook.com
 [52.101.193.117])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49nx1umhh8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 03:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVMFbVtIEkc/DPvnSVsXDb9Gp49CidTAmWXqWc6Zp3/1j1CU8pxEyWXg2LSOOWV/lpcAf6T+XeJE6xc8bDnA0yOU4awUYDhQaOwKaJrso+qluaMUwo57uSz1JT/zFYgCa+axJyyAEYCXecdbcJ01+PVHqRhb+wWXRKP/ONqwio5lbjv6gI7ASkjDQUWsb4G0ZatdJWdjrA5SL0rlyjHlp9WVb/ckxl/X8f/sRUbXAVrNCijaK7r8wZjKUli1OLkakEz+DlKsWZOX2il1D3CN5aPAUu1iXkC1MMmQDfmbYWjwYL3kmVsAWs3Qth6/Ubbe08nl214/wFyLu99EuzyqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jq2hrvPepYCXN6RsYmN148MtPwaVBUxAwGABNh2Nfek=;
 b=AyB0sK8UHuPjwDkexwfvNnN4viAhEyxBFq8UFKVSGev7L9LUZzLYsjxkLJPq2nnGiL+40bD4FoEpo8OpcNwy9DZWLSCdBxHdqzxNukIHXyUpIp93LBDfejI3vBpYVB3CkyY8AxPLzzheSsMk0aCreKZkuLo5MXAQ2vegVbLQwFTA0aCCBG7guV30HEAFwrSjufa6M4N1LFrp/GvLqiT2t2iz/D9ht3cWEe9wReWISX0bHRnLoReP+FXxisAvJI6NlgMVWCsipWdbxL8r5OTpkepLUX0PA3PtQ+VgmQpHWvL1GDog42hoyvFsRLFhewx/HcLxiz9rkxHlguYknPAU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jq2hrvPepYCXN6RsYmN148MtPwaVBUxAwGABNh2Nfek=;
 b=sDLxCXyhUj72mYYhF6BodwIyKI4N9T+0Ui3M+d3QjimkrP1ZaCTLSa9PCjSubR/GX41KT0Cv6T3fu8jaCoBOLe5p2STXcb06QqpP9N020m9glXKI6inwcPLV9YCfMvt0aj0ku82bzIxlAnnbfxpmIetJ0wBdcMCkx00QFNRwGLJagzOCTxF0jpKIspktUlQSjpBDB4jadgADeaALctxZh8am8uDz2Tw0J7MR8TwqNeWnfBgzZxmJTqZhneKjaC5cJVVKISEgs3C/5+9XuMf4y0wRk6EdReo5IKGpB0uneBHPhYxhI4LmJdetGkiN5dx1wfIZMSSYeVRuqwDF1KqTHg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by DS0PR02MB10687.namprd02.prod.outlook.com (2603:10b6:8:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 10:24:57 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 10:24:57 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH] docs/interop/vfio-user: update protocol specification
Date: Fri, 10 Oct 2025 12:24:53 +0200
Message-ID: <20251010102453.711072-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|DS0PR02MB10687:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a11a93-4654-4e9c-7de2-08de07e74287
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EXQgAbn4pRdRgVTnIyGO+QKrYgBr0kmNY31wl7cSPwn0pclfcqSbMY+/1eNZ?=
 =?us-ascii?Q?dnz5BYSmR5xjoVNeEQAS+zxv4Xv4Wc+SiOpV7BkTgjKoaeIZzDXF9npc5DxV?=
 =?us-ascii?Q?wmFE91DXuyaReF4rD9an69q57bPVCmi8eE6KLSuYUwok/v+JFv1eJfsxYWXd?=
 =?us-ascii?Q?x3M5jjLGN854y8q2S13Zxd6tIxBpMWrKLZ4ThabVQmhf9jp51/cEDaZUUXOu?=
 =?us-ascii?Q?eCX8sf8v6bl3YWbQM+Lvc1SBbt2QTXcDL8PQ16JZoqYwjc0Rvm6rI40TDI16?=
 =?us-ascii?Q?B0MjvbuHY8mpFTGalPAfEZA6dPfdcUgBpdjbKxkFIcax7dxuV/OqL59TSR6r?=
 =?us-ascii?Q?/MJ6VUKwqL3BIkE3XjMxTnEMLKZZ9uUzOh4iYQuKitpDV97WOJ38zmfm/ujZ?=
 =?us-ascii?Q?clblD8OXuECrNLR+ekOFgt8MR5Z6rTxQ7nhRHL2zkJFdrrNcP9fI5AxJcPHt?=
 =?us-ascii?Q?unP6L4W2P4M7aeS6axSqFMBCeMTVcJ3VdKEqpdq5BGCnqlMgjax12/6JM/KM?=
 =?us-ascii?Q?FddIecBR298c4SjxNfI2JVfbYNc/MiF+9H1dd6l09/3vErBT9Rqfa2rWhLYz?=
 =?us-ascii?Q?8Y+sCsptDETk2R7IlnHRsu5+YNWhB25dzLDpMJtE+Kxx4qzUDgK3CjBc0Zsn?=
 =?us-ascii?Q?6ngercTMjgbaAagzlTBKS7BUd+DC8spArR3wSP0R3JhHfcsCODdXpX/ow8NV?=
 =?us-ascii?Q?30Qd9A7xUl0qwx68xnKA1kKQzjgzoGjA3jwTyctTUKZvKI33CEBFKFIvDXxu?=
 =?us-ascii?Q?2Xe3aB6Xsz3VMS2B9IHdOBijjLgJyBCG7yayWcqy6seVah9L6PPzbrPHjTV+?=
 =?us-ascii?Q?sFS2I9urwi44JstAV4ESkk3YvepbglD0nWjHsDK+5IuGsaDCT1LbiHPhuq2O?=
 =?us-ascii?Q?S14wREldTDzjlOKc/XtoTy3o3W9UoLFA5dBhzLHBVwFnSNwiZupi6lFiLCpQ?=
 =?us-ascii?Q?nv+lZ5MSzAxWD8U5DQa9vcDtPCf/LfnuTUViE1F5TOub5bdCaT+sfL4BpTm7?=
 =?us-ascii?Q?m30iuuwVn+3a+3VY1tdyfzvW4sGoHWpnoJvkq3mg/buML+N2SCdfYB/hzX30?=
 =?us-ascii?Q?AzEHx36BspqO/BMne2g2EhSovaO0kYbstYNC2pg189kLRHWC7iLg5EAjM7ii?=
 =?us-ascii?Q?7GMWTy0bdmlv+a8GyqbfLl9CP60Q7CRFVoBC7ylgDJT33Q1ufveeCxRoiNeo?=
 =?us-ascii?Q?aFAUW3cVtxMrNNEsnUsB8NZ/Vi9W7L3Kdmzf/U7cCuRPHJdq2AGnnpl7pMfv?=
 =?us-ascii?Q?giuF0CXnR8mhI47SeF/5LOWVCOgjULtQOTHEGOoC0YgJk8ql5mRp2C3eM4cY?=
 =?us-ascii?Q?6ShBBx+AJXVAcjnrQrncsZsqSx3pHgzfpxTyw9p5Oj4+C8qOhE4DSk2aFvmq?=
 =?us-ascii?Q?KQ2HJuuGsgowJVRUCwAChBZ0oU7vuafTYwJDmMXXgdA+tRLdG/KiaiO8BuWA?=
 =?us-ascii?Q?Dg8xAKYOvvAkZOwUSqSN8AQ2X1DKm8Ql?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jGwfz7uSs28PZ6ML7bf/6La9eq+RjBo6ONuIWe5Lkqcsl2niuzDeRJ4StTRV?=
 =?us-ascii?Q?a4CilupwxnZFhc81QpG77GFE3aPp5v2jx6rgfbYGHUfZDOcqEboGnufmEpea?=
 =?us-ascii?Q?EcLBV/xQO7x+yg0t1M6rjIYP5scikZ6ny9NXRU2unGfYuTHEoqNT9u+f247p?=
 =?us-ascii?Q?X5asVwgnvEKovFL/Ad+a74syjPzgPyAU4eJkF3XTKmBYONeUns0F4CGbKCBs?=
 =?us-ascii?Q?EA6y3HuuW2XIgsVB12LXG3JzLPBaNT1yNsbO4K6zwBsi+7lNBdlzpBeCn+4W?=
 =?us-ascii?Q?qYYPXu//o0BNJLyoMNlJ2gA53zQ1JkbquetTP85cZ0wiVoualNZ/1i+pw8t4?=
 =?us-ascii?Q?YDWJ6NXgHkhz5kE8laGxFx8tf5F16H2bBwvpD8nbdka0DcRNOROXtmCfuBkA?=
 =?us-ascii?Q?sZN51zKrpjdoLSjtcax+ygX+Y/I/N7XVpC83lROLgJreHOSSqCoJMtbY6W2r?=
 =?us-ascii?Q?4VbD2jvP//L15f80cCbfIGhvix7QvvMg9ctPlQ8XDJTjZoLwuM5j9ZP889gp?=
 =?us-ascii?Q?E701rIMu6558kIredWP2q7iaGOLYUPbQjt5a7oc4HtG9IQJcWfR0u24+ZgPx?=
 =?us-ascii?Q?wvaKBo9OKfxe8ZwuBaLt2q6RVedTJ16IDNpkTwTSF68GqzxX1794HXNT/Ucm?=
 =?us-ascii?Q?qJ+Wy/Upzeea6JwSh6srbKMAQ1gkA7CJOk3c9iYNOuK94AuAgYr+yXjdLsjb?=
 =?us-ascii?Q?5f9+Eh6oVREcZ0AIn1a8XcOv5bs2EO6OHs5iPkimr/96WEhJv7R0Uj7BrPxQ?=
 =?us-ascii?Q?81XsJGAS9xWSiD7rTZjsNsuiBt3xdSpfZ5XFDHpdQ9dFvuwecBzGIcGlXfOr?=
 =?us-ascii?Q?t8d9v/gsC1FaYLjeinTfvjFN+8XnyyRbQhoqdgpXdlhaggjsn9rJrE6QCbhM?=
 =?us-ascii?Q?i+edpY5I6fkbwPD1/XnuVWf8+IN0r5xNjJihSiTBIGgPk+28fAdN46igX6RQ?=
 =?us-ascii?Q?HhkBEZwfAwBaOLTdavz+xY/LbYPlVQHhtyrn6AWQBSx1TxkMogJ+VpdYZSo2?=
 =?us-ascii?Q?jSEY5Pru2OuupAmDvKKYWVlwsby4J5acEyqvLDCbGEOyPxEEuwjygapZhyVC?=
 =?us-ascii?Q?D/MT24GOIRjPiSCj6OyszR2V/eIpmwvEvOp+fRN3Yr+fgN1h7EUtEBKGf6RI?=
 =?us-ascii?Q?Atro7oa3GghxNyKRL5v0v0gwJsw2dkP85cauf4LKzIj6sfr2hlL2SoJkt1sO?=
 =?us-ascii?Q?tJ5fU/qbtcUm7fGRdVcTWdShLHsVrkRMsxdWe7Oxns/q3JIfCN1h29OGg04E?=
 =?us-ascii?Q?e2wB6V06qB2PF84qKgVcIUcBSSnuDjHO/zXQSYjuN5tMORUHeD19K6JaHlBr?=
 =?us-ascii?Q?4+79B89oOEhwdLhF5QehIP1JdOTUsbC0z4RV3jgGZ3yDpcwBYwceNhFJvoJF?=
 =?us-ascii?Q?SDeHaq5GjC0ORUzJGuBWiJuyqt0bxnT2YlPLfvwFuO5MvXbqRFKJtrx/Q20f?=
 =?us-ascii?Q?MekH+QHksWKfAJtqacxmWM0xewG1vc6cWJYU4HCYSD8TKaUamcb61P83KKRa?=
 =?us-ascii?Q?7fFzvbdE3fesoaWVt2+0677h6Vn03j/JKdswmJ6ebxiCOkn5C2OUFrSqIVy7?=
 =?us-ascii?Q?IBTD+3jBmJFWo3PS1ujvuRfSr0TItLYHc0hEb1i9?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a11a93-4654-4e9c-7de2-08de07e74287
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 10:24:57.1262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Y4qldj/ofYvLKseYuyPm+UOYHvU8EUOus60TS1KK3c8pQQ2w7r0Q8b/tI/J5OxPeBldUOMjyHYfNKZb2zRUwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10687
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDA2MCBTYWx0ZWRfX8ofwQLfAMpee
 GPNeaykKyctw8ENxxLbFMK2XI1JCmHrfBIDs3X2Mv+hG3fmhqNozjoToUadKA3AsUbTJPOqDPH1
 Am6+HKJCGgSVUVjfQ2a5ZRJQ6fLNrx52nZKnLqbGMNDrYKUGTjqzRakFEnAnH/y7GtUQ4ngmhLs
 E30aMpzUTMurx+zjHWQMPtb5f4VRUOablyPI21xRUZsUmywfBUfMdr2g9oq8VM95+rblhqYbKRk
 yKNGX0FodJWc5LZQMEmSU9ewQmwjEeVseC7HI602WF+LopUnVuB6UIsO7ypNJS2NnRyYNgDGSiK
 9zFJ2KA/SiH1Cnmu3p5hGF4uJ4UNpMCk/T44fiPiWa82TJ3k08MUBdrisWxOwl9ZSzhRIZe4eAo
 518REznVPbojKIL5f4cQ7zYgcwHVRA==
X-Authority-Analysis: v=2.4 cv=J8enLQnS c=1 sm=1 tr=0 ts=68e8defc cx=c_pps
 a=AhzfF/YxCie0pcxRiAEGiw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=KYIQ0q2wdc77InzN4jcA:9
X-Proofpoint-GUID: GBjAfKGjPevuUKT7ltbJScayK_PqQ2A6
X-Proofpoint-ORIG-GUID: GBjAfKGjPevuUKT7ltbJScayK_PqQ2A6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Refresh the protocol specification to the latest version implemented by
libvfio-user. All changes are backward compatible.

Note that QEMU client itself does not yet implement these extensions,
but as this is now the canonical specification, it needs to be kept up
to date.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 docs/interop/vfio-user.rst | 554 +++++++++++++++++++++++++++++++++----
 1 file changed, 506 insertions(+), 48 deletions(-)

diff --git a/docs/interop/vfio-user.rst b/docs/interop/vfio-user.rst
index 0b06f026b0..303fc13d6e 100644
--- a/docs/interop/vfio-user.rst
+++ b/docs/interop/vfio-user.rst
@@ -76,7 +76,7 @@ structures used in the ``ioctl()`` implementation. Messages derived from the
 ``ioctl()`` will have a name derived from the ``ioctl()`` command name.  E.g., the
 ``VFIO_DEVICE_GET_INFO`` ``ioctl()`` command becomes a
 ``VFIO_USER_DEVICE_GET_INFO`` message.  The purpose of this reuse is to share as
-much code as feasible with the ``ioctl()`` implementation``.
+much code as feasible with the ``ioctl()`` implementation.
 
 Connection Initiation
 ^^^^^^^^^^^^^^^^^^^^^
@@ -201,12 +201,32 @@ A server can serve:
 1) one or more clients, and/or
 2) one or more virtual devices, belonging to one or more clients.
 
-The current protocol specification requires a dedicated socket per
-client/server connection. It is a server-side implementation detail whether a
-single server handles multiple virtual devices from the same or multiple
-clients. The location of the socket is implementation-specific. Multiplexing
-clients, devices, and servers over the same socket is not supported in this
-version of the protocol.
+The current protocol specification requires dedicated sockets per
+client/server connection. Commands in the client-to-server direction are
+handled on the main communication socket which the client connects to, and
+replies to these commands are passed on the same socket. Commands sent in the
+other direction from the server to the client as well as their corresponding
+replies can optionally be passed across a separate socket, which is set up
+during negotiation (AF_UNIX servers just pass the file descriptor).
+
+Using separate sockets for each command channel avoids introducing an
+artificial point of synchronization between the channels. This simplifies
+implementations since it obviates the need to demultiplex incoming messages
+into commands and replies and interleave command handling and reply processing.
+Note that it is still illegal for implementations to stall command or reply
+processing indefinitely while waiting for replies on the other channel, as this
+may lead to deadlocks. However, since incoming commands and requests arrive on
+different sockets, it's possible to meet this requirement e.g. by running two
+independent request processing threads that can internally operate
+synchronously. It is expected that this is simpler to implement than fully
+asynchronous message handling code. Implementations may still choose a fully
+asynchronous, event-based design for other reasons, and the protocol fully
+supports it.
+
+It is a server-side implementation detail whether a single server handles
+multiple virtual devices from the same or multiple clients. The location of the
+socket is implementation-specific. Multiplexing clients, devices, and servers
+over the same socket is not supported in this version of the protocol.
 
 Authentication
 --------------
@@ -364,6 +384,9 @@ Name                                    Command    Request Direction
 ``VFIO_USER_DMA_WRITE``                 12         server -> client
 ``VFIO_USER_DEVICE_RESET``              13         client -> server
 ``VFIO_USER_REGION_WRITE_MULTI``        15         client -> server
+``VFIO_USER_DEVICE_FEATURE``            16         client -> server
+``VFIO_USER_MIG_DATA_READ``             17         client -> server
+``VFIO_USER_MIG_DATA_WRITE``            18         client -> server
 ======================================  =========  =================
 
 Header
@@ -486,45 +509,48 @@ format:
 
 Capabilities:
 
-+--------------------+---------+------------------------------------------------+
-| Name               | Type    | Description                                    |
-+====================+=========+================================================+
-| max_msg_fds        | number  | Maximum number of file descriptors that can be |
-|                    |         | received by the sender in one message.         |
-|                    |         | Optional. If not specified then the receiver   |
-|                    |         | must assume a value of ``1``.                  |
-+--------------------+---------+------------------------------------------------+
-| max_data_xfer_size | number  | Maximum ``count`` for data transfer messages;  |
-|                    |         | see `Read and Write Operations`_. Optional,    |
-|                    |         | with a default value of 1048576 bytes.         |
-+--------------------+---------+------------------------------------------------+
-| pgsizes            | number  | Page sizes supported in DMA map operations     |
-|                    |         | or'ed together. Optional, with a default value |
-|                    |         | of supporting only 4k pages.                   |
-+--------------------+---------+------------------------------------------------+
-| max_dma_maps       | number  | Maximum number DMA map windows that can be     |
-|                    |         | valid simultaneously.  Optional, with a        |
-|                    |         | value of 65535 (64k-1).                        |
-+--------------------+---------+------------------------------------------------+
-| migration          | object  | Migration capability parameters. If missing    |
-|                    |         | then migration is not supported by the sender. |
-+--------------------+---------+------------------------------------------------+
-| write_multiple     | boolean | ``VFIO_USER_REGION_WRITE_MULTI`` messages      |
-|                    |         | are supported if the value is ``true``.        |
-+--------------------+---------+------------------------------------------------+
-
-The migration capability contains the following name/value pairs:
-
-+-----------------+--------+--------------------------------------------------+
-| Name            | Type   | Description                                      |
-+=================+========+==================================================+
-| pgsize          | number | Page size of dirty pages bitmap. The smallest    |
-|                 |        | between the client and the server is used.       |
-+-----------------+--------+--------------------------------------------------+
-| max_bitmap_size | number | Maximum bitmap size in ``VFIO_USER_DIRTY_PAGES`` |
-|                 |        | and ``VFIO_DMA_UNMAP`` messages.  Optional,      |
-|                 |        | with a default value of 256MB.                   |
-+-----------------+--------+--------------------------------------------------+
++--------------------+---------+-----------------------------------------------+
+| Name               | Type    | Description                                   |
++====================+=========+===============================================+
+| max_msg_fds        | number  | Maximum number of file descriptors that can   |
+|                    |         | be received by the sender in one message.     |
+|                    |         | Optional. If not specified then the receiver  |
+|                    |         | must assume a value of ``1``.                 |
++--------------------+---------+-----------------------------------------------+
+| max_data_xfer_size | number  | Maximum ``count`` for data transfer messages; |
+|                    |         | see `Read and Write Operations`_. Optional,   |
+|                    |         | with a default value of 1048576 bytes.        |
++--------------------+---------+-----------------------------------------------+
+| max_dma_maps       | number  | Maximum number DMA map windows that can be    |
+|                    |         | valid simultaneously.  Optional, with a       |
+|                    |         | value of 65535 (64k-1).                       |
++--------------------+---------+-----------------------------------------------+
+| pgsizes            | number  | Page sizes supported in DMA map operations    |
+|                    |         | or'ed together. Optional, with a default      |
+|                    |         | value of supporting only 4k pages.            |
++--------------------+---------+-----------------------------------------------+
+| twin_socket        | object  | Parameters for twin-socket mode, which        |
+|                    |         | handles server-to-client commands and their   |
+|                    |         | replies on a separate socket. Optional.       |
++--------------------+---------+-----------------------------------------------+
+| write_multiple     | boolean | ``VFIO_USER_REGION_WRITE_MULTI`` messages     |
+|                    |         | are supported if the value is ``true``.       |
++--------------------+---------+-----------------------------------------------+
+
+The ``twin_socket`` capability object holds these name/value pairs:
+
++-----------+---------+--------------------------------------------------------+
+| Name      | Type    | Description                                            |
++===========+=========+========================================================+
+| supported | boolean | Indicates whether the sender supports twin-socket      |
+|           |         | mode. Optional, defaults to false.                     |
++-----------+---------+--------------------------------------------------------+
+| fd_index  | number  | Specifies an index in the file descriptor array        |
+|           |         | included with the message. The designated file         |
+|           |         | descriptor is a socket which is to be used for the     |
+|           |         | server-to-client command channel. Optional, only valid |
+|           |         | in the reply message.                                  |
++-----------+---------+--------------------------------------------------------+
 
 Reply
 ^^^^^
@@ -532,6 +558,38 @@ Reply
 The same message format is used in the server's reply with the semantics
 described above.
 
+If and only if the client has indicated support for twin-socket mode by setting
+``twin_socket.supported`` to true in its capabilities, the server may optionally
+set up a separate command channel for server-to-client commands and their
+replies. The server enables twin-socket mode as follows:
+
+* Create a fresh socket pair.
+* Keep the server end of the socket pair and pass the client end in the file
+  descriptor array included with the reply message.
+* Set ``twin_socket.supported`` to true in the reply.
+* Indicate the index in the file descriptor array by the
+  ``twin_socket.fd_index`` capability field in the reply, so the client can
+  identify the correct file descriptor to use.
+
+A client requesting twin-socket mode must examine the ``twin_socket`` capability
+in the reply:
+
+* If ``twin_socket.supported`` is false, the field is missing, or the entire
+  ``twin_socket`` object is absent, the server does not support twin-socket mode
+  or decided not to enable it. The client can choose whether it wants to proceed
+  without twin-socket mode, or close the connection if not.
+* If ``twin_socket.supported`` is true and ``twin_socket.fd_index`` is present
+  and refers to a valid file descriptor, twin-socket mode negotiation has
+  succeeded. The client monitors the provided file descriptor for commands from
+  the server.
+* Otherwise, the reply from the server is inconsistent. The client must abort
+  and close the connection since it is potentially unable to receive commands
+  from the server.
+
+The twin-socket feature is optional, so some servers may not support it.
+However, for server implementations that do send server-to-client commands it is
+strongly recommended to implement twin-socket support.
+
 ``VFIO_USER_DMA_MAP``
 ---------------------
 
@@ -1335,7 +1393,9 @@ Reply
 -----------------------
 
 If the client has not shared mappable memory, the server can use this message to
-read from guest memory.
+read from guest memory. This message and its reply are passed over the separate
+server-to-client socket if twin-socket mode has been negotiated during
+connection setup.
 
 Request
 ^^^^^^^
@@ -1373,7 +1433,9 @@ Reply
 -----------------------
 
 If the client has not shared mappable memory, the server can use this message to
-write to guest memory.
+write to guest memory. This message and its reply are passed over the separate
+server-to-client socket if twin-socket mode has been negotiated during
+connection setup.
 
 Request
 ^^^^^^^
@@ -1466,6 +1528,402 @@ Reply
 
 * *wr_cnt* is the number of device writes completed.
 
+``VFIO_USER_DEVICE_FEATURE``
+----------------------------
+
+This command is analogous to ``VFIO_DEVICE_FEATURE``. It is used to get, set, or
+probe feature data of the device.
+
+Request
+^^^^^^^
+
+The request payload for this message is a structure of the following format.
+
++-------+--------+--------------------------------+
+| Name  | Offset | Size                           |
++=======+========+================================+
+| argsz | 0      | 4                              |
++-------+--------+--------------------------------+
+| flags | 4      | 4                              |
++-------+--------+--------------------------------+
+|       | +---------+---------------------------+ |
+|       | | Bit     | Definition                | |
+|       | +=========+===========================+ |
+|       | | 0 to 15 | Feature index             | |
+|       | +---------+---------------------------+ |
+|       | | 16      | VFIO_DEVICE_FEATURE_GET   | |
+|       | +---------+---------------------------+ |
+|       | | 17      | VFIO_DEVICE_FEATURE_SET   | |
+|       | +---------+---------------------------+ |
+|       | | 18      | VFIO_DEVICE_FEATURE_PROBE | |
+|       | +---------+---------------------------+ |
++-------+--------+--------------------------------+
+| data  | 8      | variable                       |
++-------+--------+--------------------------------+
+
+* *argsz* is the maximum size of the reply payload.
+
+* *flags* defines the action to be performed by the server and upon which
+  feature:
+
+  * The feature index consists of the least significant 16 bits of the flags
+    field, and can be accessed using the ``VFIO_DEVICE_FEATURE_MASK`` bit mask.
+
+  * ``VFIO_DEVICE_FEATURE_GET`` instructs the server to get the data for the
+    given feature.
+
+  * ``VFIO_DEVICE_FEATURE_SET`` instructs the server to set the feature data to
+    that given in the ``data`` field of the payload.
+
+  * ``VFIO_DEVICE_FEATURE_PROBE`` instructs the server to probe for feature
+    support. If ``VFIO_DEVICE_FEATURE_GET`` and/or ``VFIO_DEVICE_FEATURE_SET``
+    are also set, the probe will only return success if all of the indicated
+    methods are supported.
+
+  ``VFIO_DEVICE_FEATURE_GET`` and ``VFIO_DEVICE_FEATURE_SET`` are mutually
+  exclusive, except for use with ``VFIO_DEVICE_FEATURE_PROBE``.
+
+* *data* is specific to the particular feature. It is not used for probing.
+
+This part of the request is analogous to VFIO's ``struct vfio_device_feature``.
+
+Reply
+^^^^^
+
+The reply payload must be the same as the request payload for setting or
+probing a feature. For getting a feature's data, the data is added in the data
+section and its length is added to ``argsz``.
+
+Device Features
+^^^^^^^^^^^^^^^
+
+The only device features supported by vfio-user are those related to migration,
+although this may change in the future. They are a subset of those supported in
+the VFIO implementation of the Linux kernel.
+
++----------------------------------------+---------------+
+| Name                                   | Feature Index |
++========================================+===============+
+| VFIO_DEVICE_FEATURE_MIGRATION          | 1             |
++----------------------------------------+---------------+
+| VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE   | 2             |
++----------------------------------------+---------------+
+| VFIO_DEVICE_FEATURE_DMA_LOGGING_START  | 6             |
++----------------------------------------+---------------+
+| VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP   | 7             |
++----------------------------------------+---------------+
+| VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT | 8             |
++----------------------------------------+---------------+
+
+``VFIO_DEVICE_FEATURE_MIGRATION``
+"""""""""""""""""""""""""""""""""
+
+This feature indicates that the device can support the migration API through
+``VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE``. If ``GET`` succeeds, the ``RUNNING``
+and ``ERROR`` states are always supported. Support for additional states is
+indicated via the flags field; at least ``VFIO_MIGRATION_STOP_COPY`` must be
+set.
+
+There is no data field of the request message.
+
+The data field of the reply message is structured as follows:
+
++-------+--------+---------------------------+
+| Name  | Offset | Size                      |
++=======+========+===========================+
+| flags | 0      | 8                         |
++-------+--------+---------------------------+
+|       | +-----+--------------------------+ |
+|       | | Bit | Definition               | |
+|       | +=====+==========================+ |
+|       | | 0   | VFIO_MIGRATION_STOP_COPY | |
+|       | +-----+--------------------------+ |
+|       | | 1   | VFIO_MIGRATION_P2P       | |
+|       | +-----+--------------------------+ |
+|       | | 2   | VFIO_MIGRATION_PRE_COPY  | |
+|       | +-----+--------------------------+ |
++-------+--------+---------------------------+
+
+These flags are interpreted in the same way as VFIO.
+
+``VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE``
+""""""""""""""""""""""""""""""""""""""""
+
+Upon ``VFIO_DEVICE_FEATURE_SET``, execute a migration state change on the VFIO
+device. The new state is supplied in ``device_state``. The state transition must
+fully complete before the reply is sent.
+
+The data field of the reply message, as well as the ``SET`` request message, is
+structured as follows:
+
++--------------+--------+------+
+| Name         | Offset | Size |
++==============+========+======+
+| device_state | 0      | 4    |
++--------------+--------+------+
+| data_fd      | 4      | 4    |
++--------------+--------+------+
+
+* *device_state* is the current state of the device (for ``GET``) or the
+  state to transition to (for ``SET``). It is defined by the
+  ``vfio_device_mig_state`` enum as detailed below. These states are the states
+  of the device migration Finite State Machine.
+
++--------------------------------+-------+---------------------------------------------------------------------+
+| Name                           | State | Description                                                         |
++================================+=======+=====================================================================+
+| VFIO_DEVICE_STATE_ERROR        | 0     | The device has failed and must be reset.                            |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_STOP         | 1     | The device does not change the internal or external state.          |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_RUNNING      | 2     | The device is running normally.                                     |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_STOP_COPY    | 3     | The device internal state can be read out.                          |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_RESUMING     | 4     | The device is stopped and is loading a new internal state.          |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_RUNNING_P2P  | 5     | (not used in vfio-user)                                             |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_PRE_COPY     | 6     | The device is running normally but tracking internal state changes. |
++--------------------------------+-------+---------------------------------------------------------------------+
+| VFIO_DEVICE_STATE_PRE_COPY_P2P | 7     | (not used in vfio-user)                                             |
++--------------------------------+-------+---------------------------------------------------------------------+
+
+* *data_fd* is unused in vfio-user, as the ``VFIO_USER_MIG_DATA_READ`` and
+  ``VFIO_USER_MIG_DATA_WRITE`` messages are used instead for migration data
+  transport.
+
+Direct State Transitions
+""""""""""""""""""""""""
+
+The device migration FSM is a Mealy machine, so actions are taken upon the arcs
+between FSM states. The following transitions need to be supported by the
+server, a subset of those defined in ``<linux/vfio.h>``
+(``enum vfio_device_mig_state``).
+
+* ``RUNNING -> STOP``, ``STOP_COPY -> STOP``: Stop the operation of the device.
+  The ``STOP_COPY`` arc terminates the data transfer session.
+
+* ``RESUMING -> STOP``: Terminate the data transfer session. Complete processing
+  of the migration data. Stop the operation of the device. If the delivered data
+  is found to be incomplete, inconsistent, or otherwise invalid, fail the
+  ``SET`` command and optionally transition to the ``ERROR`` state.
+
+* ``PRE_COPY -> RUNNING``: Terminate the data transfer session. The device is
+  now fully operational.
+
+* ``STOP -> RUNNING``: Start the operation of the device.
+
+* ``RUNNING -> PRE_COPY``, ``STOP -> STOP_COPY``: Begin the process of saving
+  the device state. The device operation is unchanged, but data transfer begins.
+  ``PRE_COPY`` and ``STOP_COPY`` are referred to as the "saving group" of
+  states.
+
+* ``PRE_COPY -> STOP_COPY``: Continue to transfer migration data, but stop
+  device operation.
+
+* ``STOP -> RESUMING``: Start the process of restoring the device state. The
+  internal device state may be changed to prepare the device to receive the
+  migration data.
+
+The ``STOP_COPY -> PRE_COPY`` transition is explicitly not allowed and should
+return an error if requested.
+
+``ERROR`` cannot be specified as a device state, but any transition request can
+be failed and then move the state into ``ERROR`` if the server was unable to
+execute the requested arc AND was unable to restore the device into any valid
+state. To recover from ``ERROR``, ``VFIO_USER_DEVICE_RESET`` must be used to
+return back to ``RUNNING``.
+
+If ``PRE_COPY`` is not supported, arcs touching it are removed.
+
+Complex State Transitions
+"""""""""""""""""""""""""
+
+The remaining possible transitions are to be implemented as combinations of the
+above FSM arcs. As there are multiple paths, the path should be selected based
+on the following rules:
+
+* Select the shortest path.
+
+* The path cannot have saving group states as interior arcs, only start/end
+  states.
+
+``VFIO_DEVICE_FEATURE_DMA_LOGGING_START`` / ``VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP``
+""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+
+Upon ``VFIO_DEVICE_FEATURE_SET``, start/stop DMA logging. These features can
+also be probed to determine whether the device supports DMA logging.
+
+When DMA logging is started, a range of IOVAs to monitor is provided and the
+device can optimize its logging to cover only the IOVA range given. Only DMA
+writes are logged.
+
+The data field of the ``SET`` request is structured as follows:
+
++------------+--------+----------+
+| Name       | Offset | Size     |
++============+========+==========+
+| page_size  | 0      | 8        |
++------------+--------+----------+
+| num_ranges | 8      | 4        |
++------------+--------+----------+
+| reserved   | 12     | 4        |
++------------+--------+----------+
+| ranges     | 16     | variable |
++------------+--------+----------+
+
+* *page_size* hints what tracking granularity the device should try to achieve.
+  If the device cannot do the hinted page size then it's the driver's choice
+  which page size to pick based on its support. On output the device will return
+  the page size it selected.
+
+* *num_ranges* is the number of IOVA ranges to monitor. A value of zero
+  indicates that all writes should be logged.
+
+* *ranges* is an array of ``vfio_user_device_feature_dma_logging_range``
+  entries:
+
++--------+--------+------+
+| Name   | Offset | Size |
++========+========+======+
+| iova   | 0      | 8    |
++--------+--------+------+
+| length | 8      | 8    |
++--------+--------+------+
+
+  * *iova* is the base IO virtual address
+  * *length* is the length of the range to log
+
+Upon success, the response data field will be the same as the request, unless
+the page size was changed, in which case this will be reflected in the response.
+
+``VFIO_DEVICE_FEATURE_DMA_LOGGING_REPORT``
+""""""""""""""""""""""""""""""""""""""""""
+
+Upon ``VFIO_DEVICE_FEATURE_GET``, returns the dirty bitmap for a specific IOVA
+range. This operation is only valid if logging of dirty pages has been
+previously started by setting ``VFIO_DEVICE_FEATURE_DMA_LOGGING_START``.
+
+The data field of the request is structured as follows:
+
++-----------+--------+------+
+| Name      | Offset | Size |
++===========+========+======+
+| iova      | 0      | 8    |
++-----------+--------+------+
+| length    | 8      | 8    |
++-----------+--------+------+
+| page_size | 16     | 8    |
++-----------+--------+------+
+
+* *iova* is the base IO virtual address
+
+* *length* is the length of the range
+
+* *page_size* is the unit of granularity of the bitmap, and must be a power of
+  two. It doesn't have to match the value given to
+  ``VFIO_DEVICE_FEATURE_DMA_LOGGING_START`` because the driver will format its
+  internal logging to match the reporting page size possibly by replicating bits
+  if the internal page size is lower than requested
+
+The data field of the response is identical, except with the bitmap added on
+the end at offset 24.
+
+The bitmap is an array of u64s that holds the output bitmap, with 1 bit
+reporting a *page_size* unit of IOVA. The bits outside of the requested range
+must be zero.
+
+The mapping of IOVA to bits is given by:
+
+``bitmap[(addr - iova)/page_size] & (1ULL << (addr % 64))``
+
+``VFIO_USER_MIG_DATA_READ``
+---------------------------
+
+This command is used to read data from the source migration server while it is
+in a saving group state (``PRE_COPY`` or ``STOP_COPY``).
+
+This command, and ``VFIO_USER_MIG_DATA_WRITE``, are used in place of the
+``data_fd`` file descriptor in ``<linux/vfio.h>``
+(``struct vfio_device_feature_mig_state``) to enable all data transport to use
+the single already-established UNIX socket. Hence, the migration data is
+treated like a stream, so the client must continue reading until no more
+migration data remains.
+
+Request
+^^^^^^^
+
+The request payload for this message is a structure of the following format.
+
++-------+--------+------+
+| Name  | Offset | Size |
++=======+========+======+
+| argsz | 0      | 4    |
++-------+--------+------+
+| size  | 4      | 4    |
++-------+--------+------+
+
+* *argsz* is the maximum size of the reply payload.
+
+* *size* is the size of the migration data to read.
+
+Reply
+^^^^^
+
+The reply payload for this message is a structure of the following format.
+
++-------+--------+----------+
+| Name  | Offset | Size     |
++=======+========+==========+
+| argsz | 0      | 4        |
++-------+--------+----------+
+| size  | 4      | 4        |
++-------+--------+----------+
+| data  | 8      | variable |
++-------+--------+----------+
+
+* *argsz* is the size of the above structure, including the size of the data.
+
+* *size* indicates the size of returned migration data. If this is less than the
+  requested size, there is no more migration data to read.
+
+* *data* contains the migration data.
+
+``VFIO_USER_MIG_DATA_WRITE``
+----------------------------
+
+This command is used to write data to the destination migration server while it
+is in the ``RESUMING`` state.
+
+As above, this replaces the ``data_fd`` file descriptor for transport of
+migration data, and as such, the migration data is treated like a stream.
+
+Request
+^^^^^^^
+
+The request payload for this message is a structure of the following format.
+
++-------+--------+----------+
+| Name  | Offset | Size     |
++=======+========+==========+
+| argsz | 0      | 4        |
++-------+--------+----------+
+| size  | 4      | 4        |
++-------+--------+----------+
+| data  | 8      | variable |
++-------+--------+----------+
+
+* *argsz* is the maximum size of the reply payload.
+
+* *size* is the size of the migration data to be written.
+
+* *data* contains the migration data.
+
+Reply
+^^^^^
+
+There is no reply payload for this message.
 
 Appendices
 ==========
-- 
2.43.0


