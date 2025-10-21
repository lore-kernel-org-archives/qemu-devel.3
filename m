Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2431CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 07:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB7BX-00030E-39; Tue, 21 Oct 2025 03:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhruv.choudhary@nutanix.com>)
 id 1vB7BU-000301-OH
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 03:53:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhruv.choudhary@nutanix.com>)
 id 1vB7BR-0002oD-EE
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 03:53:32 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59KL1Wlv174894; Tue, 21 Oct 2025 00:53:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=bysjUPv+FWPWP
 AOcErYgnUZRv27R9o8yCk2sCtp63e4=; b=oEyo741Lpv1q56sPsqgK8b6LcrkjS
 j7yDXyRn78vzRQwhtaoHyy5mNEGYBb4N2sSg5XSRQCCzFUQc8hCNqtA35Yb74y5r
 XgRXCjAKkHhpNICrZJinaIAVFCnPDjid53DAsZOEJcu7AKd1a/3wxRSbEJTmBEtE
 hKBvRz5CB6ZXBtqQRiarCK+S1jKPKnIVxeLyxmU/7Me1EbouD/WBgqQdDuZOV1sh
 FqugOF5wxRmWi7J9fyZSM2ZicjnJtzwryD3U+3zCglGZxQDyMAEsTgEtCPCehnux
 YHGl4U4TA9vX3hn2toYs0eWLx5x2wfdUonMmXQByUBQZmsrhlzlN04RzQ==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020103.outbound.protection.outlook.com [52.101.46.103])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49wvmsrw3u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 00:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYpMWycmQrDni6xwPBs12NfFoxjJztIU7HDFN2josXf2BkFMsUnGWxBBU+rSb2GGRXyg2kaju/ezONJCIwNv6M55ATA7RjMscpUpFetzPytXLxKpyiv2f3vwrw4StJ4+o4a7X0aRz1qIcxeyqiATEYYz8FaQuUk+AcfHWuXE7yeXfh3hNQTQPK14tcfaqnYnNPI4fTq2hdq5+j8T92xK6f6hlYWZlgPRrV/Y5gPel2OVCuOBIINze8CynCjUbnXRmVWioTsxiAMlFX3norD/xodSv/oybU+l//hZ4FbAPRQC+L3K/41p9WN4zfBGczXtvdYG1cxKqNUPQOEbT51DCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bysjUPv+FWPWPAOcErYgnUZRv27R9o8yCk2sCtp63e4=;
 b=x8vV5/sbfy1k8UVR5oocfjW342PwlpxNTIzyc5Ef6FEorLM5r3cX9eTC5pHYXbnjqHRq1vOn6DvZ1PXTfles6nVAKxsdlV+kjYkczbIASjCcZKsETQ764RIxJM6sf6HJEI/120kBeaY9Rg+3Nwp2Ht7IeZWiUtA02oj8HbMWW/xvwfdk09feOJGm17HVAqpwb2GIlV/DECfNUwTbr9b5kDbpnypU3sOl4S04WVNLuZKpeLzXruspHujUQ4Yzx1xLeqPbnMZOnY4uCj32VJvBQRpA3XMl8hd1tSVGUY9WkNN1WEiMIY4h8Aje95Lkys8o3uuDMIJbsxN9VZX00lbkiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bysjUPv+FWPWPAOcErYgnUZRv27R9o8yCk2sCtp63e4=;
 b=QitPcQ6Mt1FoiTd3C7S0Jz7ACFFdjOMBr/m8TI78qeiVGxhP4TBhOQmJB7w0XaISwTsDJpCbyjcf/FkxVM+0LVZpNmFfCRGV5DWaJQIckszxZGwTctdRg3s23mh6A0F2CSGxJmQVpndWJ4bqoJ5hDCNf3aakoyB+pCM3psUalVAbYAyvs580U5zkeXcQ8K8AvkeJmeYQzISAw6BOog4gzu+2nmOhGVX2soWFLIhuv+A99g02X18ausbZexe2i40t5wxO9om5zec6UQzrdJaIGm7FhyvTHtNssWbSYCLvzKOJwZ3aXLQ6y5R9nUg+DrEbyA66JQxmIR1v3NA1TqT5oA==
Received: from MWHPR0201MB3402.namprd02.prod.outlook.com
 (2603:10b6:301:7f::28) by DS0PR02MB9322.namprd02.prod.outlook.com
 (2603:10b6:8:140::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Tue, 21 Oct
 2025 07:53:19 +0000
Received: from MWHPR0201MB3402.namprd02.prod.outlook.com
 ([fe80::9f1a:782d:b770:bf4b]) by MWHPR0201MB3402.namprd02.prod.outlook.com
 ([fe80::9f1a:782d:b770:bf4b%2]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 07:53:19 +0000
From: Dhruv Choudhary <dhruv.choudhary@nutanix.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Dhruv Choudhary <dhruv.choudhary@nutanix.com>
Subject: [PATCH] Improve error propagation via return path
Date: Tue, 21 Oct 2025 07:52:53 +0000
Message-ID: <20251021075254.600961-1-dhruv.choudhary@nutanix.com>
X-Mailer: git-send-email 2.39.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:806:23::28) To MWHPR0201MB3402.namprd02.prod.outlook.com
 (2603:10b6:301:7f::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3402:EE_|DS0PR02MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d42bc1-9de0-4474-5718-08de1076e64e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1LjlxCM+OiG5GQewldIZxsfcAxhbEiQ0SD/D7+97kkoSlSXcr+ko45T2V88A?=
 =?us-ascii?Q?i7Pl/Rpt2bpt1bcWJhuds0l3bRzCuwDO/U/bJ21dnvYr5Ma8YDFGEkxbGT66?=
 =?us-ascii?Q?A8F0hD9pFw7G9JTilsCCnbb7TrilxKKPRTLUxFGYSdHrhwxpp9/IfMx6A2+E?=
 =?us-ascii?Q?YHLpPM6IqdpgdFqh4t/LMOxZ4Vefis1mmjFux/HuRlJVPv8/UA47WQg53U5o?=
 =?us-ascii?Q?sLyhkDkJkQKGrwDNmekqcXkyfGa9T4QCR3mzzFlK6HcRZp9ebll7hzeCZDAP?=
 =?us-ascii?Q?MtL3Hsa9ZaHpNoVSg0uTxaDyfzmFqL6uHy0B75qjuWN/XcMuE/XA7DYyFmOi?=
 =?us-ascii?Q?JkwNwAEJQouwc7l6Ytdh2ygVrX4LRdddL3tLwFZbI1CE29AWsAlD74XTHpam?=
 =?us-ascii?Q?TtZG99dCrIJCPzuGXQF6erpq99ZVZXkxD1D7+5xsOvh4zwserELFSdCYptfD?=
 =?us-ascii?Q?OHkHCiZHKbgcaORtFun7bto1DWjOafvzjCYCIsCULVVuJn4RWfMuL/13Rlke?=
 =?us-ascii?Q?3Cyp0uj6/p+6n3BUfMIAG996XWspUnX8veuBewv01stuev8zcLZgXrTsmHWA?=
 =?us-ascii?Q?RuZb4HQ7BNXktare+nVQJLmgdO3yfU24kaxDODb6ZxcIZxc4IrWkkzf0OG+Y?=
 =?us-ascii?Q?Czttf4E0hMjTUgTx+bPj3/AbB+JH2USxLYsYbSQsv7eWxbT/GKjMndUNCaYq?=
 =?us-ascii?Q?FrIlwqCAS9hE/qqbFGQCTz9IJ4jPf75Z345wR6CLVvYVIxBH81LugZQIXB82?=
 =?us-ascii?Q?e+stjB+cLs7MzCkupuC9y0FpF/b+RWimjU2V4M9AicA+9lXUpqrTP/sF/5DQ?=
 =?us-ascii?Q?yQzdn07gsziGtIEuO1h7PWRMqUQrO9E96se7nklJdzoKyVc7X+x216zTKBih?=
 =?us-ascii?Q?0kDF0KeE0/ithMjsc03G1Ub5rmKqq1WNHixsXStZFS92QBMoRmSSr0BIyon7?=
 =?us-ascii?Q?9BXcv3i90t9k1yUU39f97JeJLRQLp7vy96h6l3zBLp+lVHNBmQYXmq9YX/U8?=
 =?us-ascii?Q?k41Qe+e2rO2VZ5Q12SVs3FQx5+TmTLMXcYUpZnFkBoBlw0pFKBkHFGOttD0c?=
 =?us-ascii?Q?OqC3DggaCvCeLHLSzBNEmJBuQGjEuIHSVcn2mzaNz2r+hy39e0EOFnXSepkB?=
 =?us-ascii?Q?vQd75uHRfpi8TWxqeUA6jSWI5tDWc/jXNnM810Us9fIyGu3Oi8ESdv+04KAn?=
 =?us-ascii?Q?Mh99FAhbToCFKYoI9r1h3wAbIkjjNIl33mbNRd5ZIgOMOoEMwrNQZ8o3zuzd?=
 =?us-ascii?Q?eySjWnF0SNQtFXdwfuMPaax5GghizVEBmEuNWjRBEDHusqLZB6R9Zzt+UcZY?=
 =?us-ascii?Q?cBgv2874akZfCVLK0Qfd4NjhtCJKz1thjqeGBZ+StTgSlq+wtGjZETrcm6Yo?=
 =?us-ascii?Q?dKWH1gSK3tJxCwIS4Dzv3H3Cwie07CC1mRMbVc0WqsrecaP7UBRVOHGTVOeD?=
 =?us-ascii?Q?4mp8Z+b02cPa0OzdlovDppIRwPVHXfOC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR0201MB3402.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B0bVR2fLXhtgUzFM+eEwMzB0kHxu3D1q7mD/T8yIGoDz90sEKOWTGJIIpFCR?=
 =?us-ascii?Q?pJyemFW4qG74OvtearCA2kg9CXpvpzN7YEfPf75RSDduiBKLroitfN+a5UHW?=
 =?us-ascii?Q?mK108Y5KXWMpw+cZ3Yf6GKuDv6YyBQySTpqndzSvsD/mXQDfx+N2eWqZNkCZ?=
 =?us-ascii?Q?I76vEYvlp6ligj0AmQyF21si7y+Nm/1YOUKjStyG1ZOkQY6jkVz9LJEzaO2c?=
 =?us-ascii?Q?nWGsE0NK6bf9DS5asjh+dBqecrR9DvhVW3o/l6yVe9CxLhq/lDF+y16ds4e0?=
 =?us-ascii?Q?fSZYgaPy5kSJ071PEISHSK/5mcTQiIbFZk8TAjyZ27KV+OdlFEMZ9a0AhSb2?=
 =?us-ascii?Q?zsPTD76oRxxYCnX56Gle+tKTzr9yN4+F9mNCwQV6TQNCetq/MMzk4U27ZGXX?=
 =?us-ascii?Q?FMXPOhbVHB2DpULGoqOYWuz7GFouDHwzPhNU39mOiv0XFP05VxiLYMT5ly1N?=
 =?us-ascii?Q?v3f8RcZVaZ1mRwD4N8+euJohpS48n8aszVQR1q+cifaIEoJl4+8Z1asVEe6d?=
 =?us-ascii?Q?azOuf0NrZili9F5c3I0vvKnseeSjO7/WVnX5cp32QQnBPTHXhDPn0KY6vzBA?=
 =?us-ascii?Q?rQUt21ANE21gXU2cVXHF+tvdKPMve9gH1TQqTz+7AXocjjEKuP6mBUKcMHrN?=
 =?us-ascii?Q?eOuIaYKPp1DGHEg+5g3in2bG1PP3vjz22KMWyq7iWcD5OXD0knuwkKiBneSI?=
 =?us-ascii?Q?/b0omRUaJHyAhdsB4R+LDO/WjXYVG37j2Dplmg2Djg6aDmJeNqOgyo1j1Uds?=
 =?us-ascii?Q?HkJkFmrk/whsFBGOCArh/q4rrzTgyFMKfT+NWXv9Yrx2w6P2ymHKkBEs3CK1?=
 =?us-ascii?Q?y03nuiIaw9XNYGj8x2Y4+pIUZxc1/yIXR2R1MWEijEqv5OFQl8Izhl564QHH?=
 =?us-ascii?Q?zAZJtrQTgSF//TEEuFXdxQcb5x3esb3zqNwBxc89NsCU6+rzrn4icZURWa6y?=
 =?us-ascii?Q?7WOpd5HU2xte2I/0iaY6TDzS88w7QP2nU3M20N9N3NL9W/Tuil0FyZmmuhrN?=
 =?us-ascii?Q?RGqjAFPyDa24F8UnKoXztHKk2cENUmxrbuKUPDgIMfPJNE1hgTJuEZey+Cnk?=
 =?us-ascii?Q?klcGCTyPD/xQDPBMYqsbReqbMT0GtoWXs+o4fKXbWywUkmcs+1yRIBXjeIxH?=
 =?us-ascii?Q?Puta78LL8lB5XvTMpXGgeE4saQkB08EUysgkN0SRUi3xvzLbfby536AWeTqx?=
 =?us-ascii?Q?1TKft67UciMZjKmxQ7DjdqcfeGW2GsQ3RrlBRZR13Hg6QZPp3lZHBBcEzvVX?=
 =?us-ascii?Q?AQPc7KfK+B0Ou1DY88nbaNMyTr+GekdYAt0PQvOIqm0OYc2G0npsZmt5gL8/?=
 =?us-ascii?Q?uCPdX3syUGK9pXBwIsYtKMxJ6KkYA3eM65Qob1LOe7brrt1jFLJc4TU3UFBu?=
 =?us-ascii?Q?fOUAa/kZuuslPVA5FhHRqAARHFIFMvx3rRfI5gfJ6gZdniZKr1m0MFHn7Y7Y?=
 =?us-ascii?Q?YyBYgFA6teNNN0TT2ZmO+JXLuJlB8TKc412S+7p4I5kLVL2/yXvJfcMuEZVd?=
 =?us-ascii?Q?KH3b1kHSRVwDsGL3Q9xWt72pTRpAWbvIXy9B5PEfMkkjS3bHx+Q8SXFgkDTd?=
 =?us-ascii?Q?QPwWRgI84aImO+onBvodUyhWYrT49e7tGEoKtKx9jpWNiQCzMh01fG3bXzmn?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d42bc1-9de0-4474-5718-08de1076e64e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0201MB3402.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 07:53:19.1351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlX7VGHAq1piLQJpugaZm34p8oOpjJ4PdH29gBzAiKSo2iLdaPPmAkAG46ZSZHj9Ti+fF3Ze8GSz4pPTbQ242usc9kcwpot8pD9Maaj0VZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9322
X-Proofpoint-ORIG-GUID: sqD_2AIYTA-3e6uF9uYPZXlOC5gTdJGC
X-Proofpoint-GUID: sqD_2AIYTA-3e6uF9uYPZXlOC5gTdJGC
X-Authority-Analysis: v=2.4 cv=HK3O14tv c=1 sm=1 tr=0 ts=68f73bf2 cx=c_pps
 a=85R27yqqIDOPhBwKPsrjTg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=5K0ATu8qAg4PA-M--3sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDA2MSBTYWx0ZWRfXzIbZJ/AvsEH6
 v7ruBf+ae7mUYJqWHAYZqokt7GRSqMnO4AG4Fj4wzYznu2aVlGp+iNbbJAx9vHe9LR3nbemi2+n
 iYbMtZVzjwUze5TQaDRNX2ar0z5ickTn/2VXYs5a8oR6vJVkAX6c7G+4UBxH1ELSWDSPbwyU2Vs
 QB45uTeYTJSfu7ap+0dAUwpGaxsGNZdc072N2G19d52yc0EZjydn/z/AV1br92DXf20TjFAzPAf
 j4r5GEy1GiBBDWGGAe0JJnS9ReRtvcW0zJBzXEQMpy+Zskc1wvtLyCqwrsb+K6+SOhNmx+e2Br9
 n9+Yv76wkbvsLrcfrAt6FuK31nTY6R1BXEePXs27lw0haKXSwJv/hmRQt6egbEKGtE2ntWfoXnl
 gDGEmC6C9iGrOlKjQErI4mwZChBRdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=dhruv.choudhary@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Use the return-path thread to send error details from the
destination to the source on a migration failure. Management
applications can then query the source QEMU for errors, as
the single source of truth, making failures easy to trace.

Signed-off-by: Dhruv Choudhary <dhruv.choudhary@nutanix.com>
---
 migration/migration.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a63b46bbef..123cffb286 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -87,6 +87,7 @@ enum mig_rp_message_type {
     MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
     MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
     MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
+    MIG_RP_MSG_ERROR,        /* propogate error to source */
 
     MIG_RP_MSG_MAX
 };
@@ -608,6 +609,17 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis,
     return migrate_send_rp_message_req_pages(mis, rb, start);
 }
 
+static void migrate_send_rp_error(MigrationIncomingState *mis, Error *errp)
+{
+    const char *rpmsg = error_get_pretty(errp);
+    if (!mis->to_src_file) {
+        mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
+    }
+    migrate_send_rp_message(mis, MIG_RP_MSG_ERROR,
+                            (uint16_t)(strlen(rpmsg) + 1),
+                            (char *)rpmsg);
+}
+
 static bool migration_colo_enabled;
 bool migration_incoming_colo_enabled(void)
 {
@@ -905,8 +917,12 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
-        error_prepend(&local_err, "load of migration failed: %s: ",
-                      strerror(-ret));
+        error_prepend(&local_err, "destination error : load of migration failed:
+                       %s: ", strerror(-ret));
+        /* Check if return path is enabled and then send error to source */
+        if (migrate_postcopy_ram() || migrate_return_path()) {
+            migrate_send_rp_error(mis, local_err);
+        }
         goto fail;
     }
 
@@ -2437,6 +2453,7 @@ static struct rp_cmd_args {
     [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
     [MIG_RP_MSG_RESUME_ACK]     = { .len =  4, .name = "RESUME_ACK" },
     [MIG_RP_MSG_SWITCHOVER_ACK] = { .len =  0, .name = "SWITCHOVER_ACK" },
+    [MIG_RP_MSG_ERROR]          = { .len = -1, .name = "ERROR"},
     [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
 };
 
@@ -2667,6 +2684,10 @@ static void *source_return_path_thread(void *opaque)
             trace_source_return_path_thread_switchover_acked();
             break;
 
+        case MIG_RP_MSG_ERROR:
+            error_setg(&err, "%s", (char *)buf);
+            goto out;
+
         default:
             break;
         }
-- 
2.39.3


