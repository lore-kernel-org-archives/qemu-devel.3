Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294E9C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 10:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPJ0C-0003OI-T7; Wed, 11 Jun 2025 06:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uPJ03-0003Gs-0k
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:48:07 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uPJ00-0002I2-3d
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:48:06 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B8c6kr003715;
 Wed, 11 Jun 2025 03:48:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=vbR5h2PEXr/mO
 3zNH2wabvbj1niJC+0eDEhTvdgQfYI=; b=e0KYosdPV7u1AArQdif7gXAqfBLUp
 6M7q1cP/AhdZFUtOoclD0cEt3vOZGZUiUQGvbO9PmQq2aIx3XLSCzhNiESrPCydH
 PkI81+xn2uPJ0Ewl9AcpOTJ2AC6jHeS9rZsVCZn98eOH3EZlqptoFaXSh3bQ1r/w
 CIGs8ouHlnxe7TejNNgPw4yxR6RMmG3Hd1Upb/2ZRXMNXrWlBDGLThyRN4LMJ39K
 qh7SMpdygLahR0q5DF11Sn08BPWKgTiQ/5K4H4OtTDYmT9yL48zHFn9XH/srECYA
 FoAzYJ5RCKFsYO2oUrkKX2/g/WP9ZUh/byfe6c1QVj+8JLzX++vX9Y3Hw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2138.outbound.protection.outlook.com [40.107.236.138])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 476e1sufkk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 03:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JH/Yz7AONA1DZxUDZkQR4sfisPLxDCgUs5LoqSb2uQ+mFAxNbehVAUCTzJYd0m+WSK8UlyeZ02CWlhLsyaRqhllq5tHrQ7/YdkBGBwEFHI46b6CZW31TiwjzQlchIiUWJBWvrk+l1MLFeqNbF+bFNkwtyzwWqdhkbHzPyWAbOp3YIJclIaAOLFGq5o+bUYo4k0IGXWKcVuVZZgse3gIQaKy6KQT6TYkAYkdKYZLdp8OKvY3ha6QxM07tIujcyDbXc2AjHPa8MmOzlh62tU/dxB/ZxN6m5a9q/KNro2hBg7sKkwjIWYTfbNTgk5sURjRQfZIhkaHeBcmIy3//Kv902A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbR5h2PEXr/mO3zNH2wabvbj1niJC+0eDEhTvdgQfYI=;
 b=CvqM7JI1xT7JCHqZqExoss3vf5J0DZcmsmulyWP8ot5HD1+G/jaId4BI15gRrT5UdTRZ8Dv/qZT9c40lYpA1FAz7LaXCHOx6HQheErNj0QznqfuX6QurNpd8Lcn7TO7b0+UOs9wfe9xcnpz53inxI7Yb01hW2RbQMJ9TLU25UsZfXOVNDKTs5eX35bywdUV+g4jF67zLR3o6nafXkekBFYqIE0o3qvrKIN2bofiDeGW3+F8iWq/H/6/comnOrGzWsTq8MOwv1xcQDYNxcnjciUwl090eyFOjSpmIRm6RYgUmzIqfsymw8nDrgr75td3qkb58uH1YGnsWQu8jD9olyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbR5h2PEXr/mO3zNH2wabvbj1niJC+0eDEhTvdgQfYI=;
 b=Xj606r15pE5uEEKbr3fBhr/TApicOVmn30b5U1bPoNW1HzHV7k2fGlsOPcqxY59K3lkuxiZXDvNOz2C3+cwV1m0Xzxnu5dDvozNvviDQocbX+cUB5CBODHZH344I+3XdK/yrFNiKQVG4u9+Qo9pqu6gmt3stDZQb1IdC1lYabZxasNlF6Bv0Y2nx3EyrqxK2mw+GvZA1b7PsJhvgRTC7u0Pj6PmncUaPkBk1KiMtaK0oeTKHWY7NBDS+8+gu7/T4+V5cg5IcHzOC4sefOY5K/wNaZ1ZfLGVY9tjRK8wysnQ0WBsdioR4PZYYieh0leqfwqybbGdagMxkIBJty0u7lQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CO1PR02MB8475.namprd02.prod.outlook.com (2603:10b6:303:15a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.19; Wed, 11 Jun
 2025 10:47:57 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:47:56 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH] vfio: improve VFIODeviceIOOps docs
Date: Wed, 11 Jun 2025 03:47:53 -0700
Message-ID: <20250611104753.1199796-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0121.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::38) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CO1PR02MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 59bbf744-4edf-4991-0d0a-08dda8d56cfd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bzSLGLZ399/X59Jttx+QACUCb4b+nhazU6cjYmYz2ERA9P3Ver6HuiQQIdPx?=
 =?us-ascii?Q?s0ATar5CD+LFeL2qkNltm5yT6ij0fpzEfHkng0a4zwlRhFoJIBNTsk3XX4eD?=
 =?us-ascii?Q?1+Bim1zFcGATcQXrqtYB8z4Js10BfXKY+Q9HqLleRQo2m9IEnfrB8MhBk8+o?=
 =?us-ascii?Q?f+VQtWNsyNnGcP3YNp3P264y54Y53+XS28ty7qoIdXlawPTvS/N1TsKc6Ni9?=
 =?us-ascii?Q?FC7bZjf8xQA1wSwysQZg/k+7sHRujXZy1H0yc5g/3OVcKiNsSFUUSSulSYHD?=
 =?us-ascii?Q?vQ49EgYuS5XPkMPOINXmrJv9zlA98DfRx0qkPegI3j3myKdMlnOGu7pn5iBG?=
 =?us-ascii?Q?c5RLA2N6WNWOB35NWzEJ5s4HOEyRG5bKOJFa0xBzH4jlafN0gSKf3tjSHj1D?=
 =?us-ascii?Q?WdkFR60q/GFjdORLT/MejX26XfG4f7xDm2tmShGlfO17XO7NXIbg8kIiQ57u?=
 =?us-ascii?Q?9NT6EG/rQa4VR1MvNWk3dwHuJZsrdXqXLBITdX/KoQm/TNMhSa72Hz20XEux?=
 =?us-ascii?Q?9CvsNsNC0msrFgHObk8BIQNcwNwZmUqwFztUtVKgwvIFp10sTXLQDX4Md9wd?=
 =?us-ascii?Q?yPGy589oAnhh+P2rMIlvtBWjHt4G0m/n7w0egqJgnGpVvmE9zGuS3mW7iWQ2?=
 =?us-ascii?Q?ZwLcet3qkvI5Y51MIlRHDiJpEbQy5VoJV+ki7zElYakqL0p4roSRg/wVzeTS?=
 =?us-ascii?Q?KFsoV1xOikwefIgSw1f094JPB9oE9xDsm3bOLhpiJkL9JT700c38braIra/V?=
 =?us-ascii?Q?eU+xC6e7M0nnESQxZzI0e/6XPZXXPkh9oyuajTBtWGhzTJjyeH5S7AFxle/B?=
 =?us-ascii?Q?5MgjZrXTW0AyIJfltDiTSTJab5xyG+Fcv7iEI2ndqt4EDgp3xuGU+zQKqjFI?=
 =?us-ascii?Q?9D4m0nAOdIauOfHVs74EZrmkfBbd0Zm1ly4XBMO22dvQsQonOKZ6+TOHBmF1?=
 =?us-ascii?Q?ljluHmhkQl5oT7kQGE1zlsNFk2uJNROM+m2ELp6RYFn6j0vhX6tnk1XD1aqt?=
 =?us-ascii?Q?phZ+ZfuJwnl5MboP+5Jh/NKlg3owBpX/gMVuuRjEPfgo03nKJJMZbl55NnJa?=
 =?us-ascii?Q?4oB9zpjnLV99snjEToj2xwsrdQyOXgbZ+11n8RIEwq4Q79wrhziyqH882tNH?=
 =?us-ascii?Q?G5i/0IgtT68fkUCf/H4TU3gI4w0lkKuF2hIKdTtE9LOX3maRBxnV+ax0kPzI?=
 =?us-ascii?Q?OesQdET43J19ploiWIcxY8cZNYPweC99a2JlOMsQaU+tZoM6eKMV0McvDm1o?=
 =?us-ascii?Q?glH70dx9hr7/ht0hkt6/0jjkNg6QbkSNVRE5Go6qLLuRp1GmT64DY8NwkWPy?=
 =?us-ascii?Q?MRap6F42IHFH9XPG17Vp0Bfs75XuEV+XMH5xz1xfSiI/g/CgdLvLD6ZZfE1V?=
 =?us-ascii?Q?7hGFkHgx+gnNvX5f5RfpctVHK37f++BOO4boU+ranhIMP81HIgHMI+USCcZN?=
 =?us-ascii?Q?TMAuYoS18EU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dbaiuSxR9ZbhAoxiJY9Myuwr/alFo5k58kCCO87ANBLwSkUY8qsrZgRN6Eys?=
 =?us-ascii?Q?dma1FxZvC7qtXlp2KGA1XPF43Jdz5a4nL2ely3MXc6pIVUgwTn7D6MgBO9Lj?=
 =?us-ascii?Q?Q1w3YAVy5iY+YrvnLsY/0xczwGwuBQStMTVskKEmAgWxm1twR9xSXw6mkYmo?=
 =?us-ascii?Q?/9UApDKU7G2pdLbPcdVF5WJvx40qe/ilzSpddDehTAGElewL94HKb3K4Rg6k?=
 =?us-ascii?Q?WnT8jasawk/yzCPkwt4+6077nFoAh4Cmdlo2qB19wcy1ZAO+YOWgQxCVG99X?=
 =?us-ascii?Q?poH7+ToPa8eZ+rWPmSc4BauP/mksJiGVmuNogGqNNM8nU6rLxWivsQMxGXEE?=
 =?us-ascii?Q?o0BCJTh18a0Xs0kA8g8XX/0BZGcBQbOAeEsCpePnKMZzIrxX/Do3CXpGKtoL?=
 =?us-ascii?Q?+tv13H2Y3ONyuX+OS1fTUHAiDgKQmeK75wqvoPoJcDXCqUFwpLMuqVQJ1bDR?=
 =?us-ascii?Q?80E12+aPCnsfdHhH8zbHeemDoYTO1JQ6Z+WqNe7m/gAo+8SeNtOew6yrNXX6?=
 =?us-ascii?Q?PZBrUgF0qXNrxa2MjZX/hnOGa+r4O5amyDNM5HCdbRRbEQzRq3mFVgczPzyX?=
 =?us-ascii?Q?JcqMUdQX0JXk3FqfTWoBzxihhq9bKW1NqI79iwccNuMNI/nWPM+PCY/1DcKa?=
 =?us-ascii?Q?hCiL1VeWODFgWiXzJon7VGO6cw7S9ETM8pt3d33BsrPh6PbyGEC6S8+iKVf3?=
 =?us-ascii?Q?nVwJq2OJXXAweGH1PrI16pJH7nHbj8apl7OQ+SbY7eFvqK4yEY6GPNZzclR/?=
 =?us-ascii?Q?DMEgMy2K5ZsQobmqz5sXpt+18bmPkiEOwOOMcsR8IvJMIzwF2wZBc4tEo+JM?=
 =?us-ascii?Q?3xLwTM7ZgJ/Um09zX0bG2sYVbIbnNjRwMZ+qUZViVQQK6Hb15H4Ky3csKxHf?=
 =?us-ascii?Q?Qm9BaKUmVjPFqlLhzOkpxCHx/OjpU//Tk01yof2E6VbOyEgdZxOdekG9s7lZ?=
 =?us-ascii?Q?lHppuLucPyhWpJwBGbDTK76CLz+gZOwVWXNLFxsKO6ANIy4VWohfgaqGCChg?=
 =?us-ascii?Q?PqlEt1lsd6B+03pSwN5wz7S4zIGxK7avyomKtVbBsyCMvhA9skINsyc6/NLa?=
 =?us-ascii?Q?7ZwSr2ulwxfujPdLO0gv+6dhbSVuBbAUYWfj/jDuBmifgaYmHhY8AJLBS0Nw?=
 =?us-ascii?Q?Q4Z4wAlDiSzpK5+JN0pVwMalv1N3pbdlEK0hg7OrFF0S83CbDXmYHaWnvLW/?=
 =?us-ascii?Q?8whey/4/nmap8GdelMOyXvdC1fx+R9if/970bUzfPAL3a+ok0VCKUyYCSWWZ?=
 =?us-ascii?Q?R+j/3a+u1nHK2utfTO2MBtQDL+wAcjdKQjZjEVGqAfNpNwwGGXG0Md4Zn6M1?=
 =?us-ascii?Q?2qeTTS6PrElc6Pk3HQxFQ4JKCKlCTP7iNlsWlTV7TKsayJC86+mIFC37QxH3?=
 =?us-ascii?Q?7NRnsSDIF5LPfgpXvYXsGfADpud3p6WEZ3l5Dr7zJLKd1Hp5xH8bYxgYpl+D?=
 =?us-ascii?Q?5Oe6Z+vlRBW5W4wUXZxjAmtdFKk0TErdg3lWhWZprC/+kBdNAk+EFmyZU50Y?=
 =?us-ascii?Q?02LDFhJ9KFXAmZVrfBPf6+evo977KPD18uhVnqKxZWPxOkLIWRDMczrZG0io?=
 =?us-ascii?Q?Id5EfDPs/E53f2HzHfmtQ5FgLEYnV07fmNW8NhRU?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bbf744-4edf-4991-0d0a-08dda8d56cfd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:47:56.8280 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0NNSsc/peKovs1jvsFK+3CDp+PdxW6fE73uipWzFRpqMaUDZ5UgAa4fZOG+ZKkEY1yOyZtwhLOUb+zRRmDVdjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8475
X-Proofpoint-ORIG-GUID: gcCeTbWRBg931rFtECnEFYNa_Frv2FtP
X-Proofpoint-GUID: gcCeTbWRBg931rFtECnEFYNa_Frv2FtP
X-Authority-Analysis: v=2.4 cv=W9U4VQWk c=1 sm=1 tr=0 ts=68495ee0 cx=c_pps
 a=ChX0rhhbfJA9YqgnuHldhQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=EH0mfBLXEgmAgkVQvG0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA5MiBTYWx0ZWRfX6RolzBkzpINK
 uyyPJratXXt7tTr0Ea156FPPPzDOzMJgECfJHP1B0sfF0PRBTlmWIVwGJrYuRCzGXj6G0aTVKNG
 fcLikYWdPdb1f7UfS+rkin3FiF8IRB8AZlsGWeho1wj3XLrWNWN1AsMfZlfyQ7VFmzz3C9juigv
 HUnySg38NdIA92sXOMDY1GvdaTDMAc2aBwtld9CySJH3Ibd3zc/FV09RX5Pf8Zt3vPe0gUHjyj6
 Wozxf47RWcenXGlbVBFIsID9Uh6/ADj+46n8TWB3YkCrftUyYEQ/itjXrroP92HgeBzQSyTRvFi
 Xxffp5runoKRHcvg9iBiTsGn9x9VBy47pOnQJCxRhClmEP44iRr2JpZl/7I0/EP9qu/Xj5OplYM
 LEEQ8yog8ZRHL1sDZsdGMvNhkq6WYmvaJiqadaS6WzsdEIYyl4plCJqJ3PmVfFNEZwy1DWUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Explicitly describe every parameter rather than summarizing.

Signed-off-by: John Levon <john.levon@nutanix.com>
---
 include/hw/vfio/vfio-device.h | 52 +++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index f39259406b..d45e5a68a2 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -168,14 +168,25 @@ struct VFIODeviceIOOps {
      * @device_feature
      *
      * Fill in feature info for the given device.
+     *
+     * @vdev: #VFIODevice to use
+     * @feat: feature information to fill in
+     *
+     * Returns 0 on success or -errno.
      */
-    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *);
+    int (*device_feature)(VFIODevice *vdev, struct vfio_device_feature *feat);
 
     /**
      * @get_region_info
      *
-     * Fill in @info (and optionally @fd) with information on the region given
-     * by @info->index.
+     * Get the information for a given region on the device.
+     *
+     * @vdev: #VFIODevice to use
+     * @info: set @info->index to the region index to look up; the rest of the
+     *        struct will be filled in on success
+     * @fd: pointer to the fd for the region; will be -1 if not found
+     *
+     * Returns 0 on success or -errno.
      */
     int (*get_region_info)(VFIODevice *vdev,
                            struct vfio_region_info *info, int *fd);
@@ -183,22 +194,38 @@ struct VFIODeviceIOOps {
     /**
      * @get_irq_info
      *
-     * Fill in @irq with information on the IRQ given by @info->index.
+     * @vdev: #VFIODevice to use
+     * @irq: set @irq->index to the IRQ index to look up; the rest of the struct
+     *       will be filled in on success
+     *
+     * Returns 0 on success or -errno.
      */
     int (*get_irq_info)(VFIODevice *vdev, struct vfio_irq_info *irq);
 
     /**
      * @set_irqs
      *
-     * Configure IRQs as defined by @irqs.
+     * Configure IRQs.
+     *
+     * @vdev: #VFIODevice to use
+     * @irqs: IRQ configuration as defined by VFIO docs.
+     *
+     * Returns 0 on success or -errno.
      */
     int (*set_irqs)(VFIODevice *vdev, struct vfio_irq_set *irqs);
 
     /**
      * @region_read
      *
-     * Read @size bytes from the region @nr at offset @off into the buffer
-     * @data.
+     * Read part of a region.
+     *
+     * @vdev: #VFIODevice to use
+     * @nr: region index
+     * @off: offset within the region
+     * @size: size in bytes to read
+     * @data: buffer to read into
+     *
+     * Returns number of bytes read on success or -errno.
      */
     int (*region_read)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
                        void *data);
@@ -206,8 +233,15 @@ struct VFIODeviceIOOps {
     /**
      * @region_write
      *
-     * Write @size bytes to the region @nr at offset @off from the buffer
-     * @data; if @post, the write is posted.
+     * Write part of a region.
+     *
+     * @vdev: #VFIODevice to use
+     * @nr: region index
+     * @off: offset within the region
+     * @size: size in bytes to write
+     * @data: buffer to write from
+     *
+     * Returns number of bytes write on success or -errno.
      */
     int (*region_write)(VFIODevice *vdev, uint8_t nr, off_t off, uint32_t size,
                         void *data, bool post);
-- 
2.43.0


