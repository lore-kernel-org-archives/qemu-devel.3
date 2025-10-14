Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B87CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ghm-0007K2-Ue; Tue, 14 Oct 2025 11:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v8ghi-0007HW-FT; Tue, 14 Oct 2025 11:12:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1v8ghf-0005nf-Pa; Tue, 14 Oct 2025 11:12:46 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59EE0RjY2274532; Tue, 14 Oct 2025 08:12:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=5lP3WoJmkA25ocEzttURM4P+6bMA2EhRjhIYgnkCC
 mQ=; b=ZcALphQ3Gjtzb1gDexcXKujDH9P/6edGhhqy/iddmlC05JnB5gc3uvZmD
 JN9LZ5yaDcHDs3Vc82IXJBsO7YQbrPFNF5Zd0RvXLYXfxJROV2TXubjzlXMJH8XP
 aPhg2EJiSW5oPx45vdIQUs16Brx/ask1NYK5FiKk+1N+E1R44RJwBqI6Do4DBiAO
 Jom1SGqHW7HtacsQuhbrecZ7lVnAvhBYKkJb7kdWZ5DtH5KrP1wQINeA05a3hfQU
 yrZgx66+4H5fQQCMY825zpZcNGDU3RPVmr6WyKpXh2ZpQp6vFI0sI/cTEgZcWztH
 5O7sniaDKroC62VwBQaD5O5IL5oRw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022132.outbound.protection.outlook.com [52.101.48.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49s4y8jpsu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 08:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3H+Wy4YA4pgmwTLr8xdFNVj5KYyig6dh6Eu994eVW/OCwI6l8//pnFxi7RPlVRrgc9CQDR23JiO+sLhCWRVCKsTXDtrXwQPdYyMXZOA217JXg6zhr3s66iXauPDzipoweUUhJbdui2MCVNaW2IrHomJ7KzLLzMhyC+EAsDR0z+TrDHjv3+Vf11bSB/BPtL6oq+RMtOVWnihvw2fDZX706FKHXwIPpBIwwcmp3BC3l3xm6JBCax8SIZv+mrRobgWi3tw/99EDl+Qkc39e6MbXiYv2CJaYH2u0h8WQymMjqo0XOy62bDEUfG3/tdDBqJlharCQEr4Nxu2szoBjuYgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lP3WoJmkA25ocEzttURM4P+6bMA2EhRjhIYgnkCCmQ=;
 b=QMD/lz2HcfYv0H1VqnQ0TaUB0abgaYexUou2colrolN5XHyYrw9vUgQMQEgb8QvNoTSEoh3A4h1EnUYPvjX1kD1osQ0ElSbjPbywlF1WdjQwUtlNiQD1HJVbXACrkgBZI4vJWRz9xHMZi53ENEwzgfpCuLn1iUA4lTkjIDqumKoVTu+jrFk/Mq2lpja+kfRskZCJuWIAiH5zMmo2vrpfSJL4il/G/MaecnVhCh1zXSVP0VADxZDs+1yCxNC+n2XeSxInX9zBcDO4evTTq5zHZ8/CuyPyGWsOlzWVomY1VkUydl5aO5oXQk6PCa4fyfFshQgWQQeRra5BY75ZEuvRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lP3WoJmkA25ocEzttURM4P+6bMA2EhRjhIYgnkCCmQ=;
 b=upO/4sSUvr4fDbVkg/CmPCEbTufTzl9ounzSrpP+VfKQKxrzOlHqqdbJezlPQwnb2LpyNYxAqC9nLHX5Buqi6qF7innIIDOz42XxoKTLyviH2eiQ7bBfTSGZo+vcEJZVFAB/fQv9UogplD1Xtcmu+cnKdbyKHZ3a7RoNOiuBkmvcMWw+fJCqtqVKJuoOSdmuDOAduS0B6x1lWjt0zLf1JXI07s+uquadUOn46Vb0Mf/o5X6Ns3NtxWZOI1EWxjfarsEmisKsZ0WizytKiM095bw/+pxc3JCU3p4dmvM17C0orwktclWXpXgxgI6DWtwolDzoCLQ/VXywQ203Bv/n9Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA0PR02MB7371.namprd02.prod.outlook.com (2603:10b6:806:e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Tue, 14 Oct
 2025 15:12:34 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 15:12:34 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-stable@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 2/2] vfio: only check region info cache for initial regions
Date: Tue, 14 Oct 2025 17:12:27 +0200
Message-ID: <20251014151227.2298892-3-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014151227.2298892-1-john.levon@nutanix.com>
References: <20251014151227.2298892-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0197.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::22) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA0PR02MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: b15fc068-c4f8-4e45-b021-08de0b341aa2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b+t1p42XYOWaJa19kZvFJwRlB0A2eOtXcKU4FlrfEy5Mw2jCz+LRKHuvvCyT?=
 =?us-ascii?Q?1CyH+a0PFmwKFdv30x2Xh3pOFEEIVmRmpJNiYcMnkM+0HJyMWBrJIzoEgDOH?=
 =?us-ascii?Q?Y3iTUfidk/6ZbuSRqwLqwpcIMO7Wcdrkcd6QFhAhTAwpR2A5185n+Q1iok4P?=
 =?us-ascii?Q?JTFsY9wfrQ63KaXqKcc7aJdSgq8e8a9GXAxNje4n8lN4xkOtq1fa8b5XEaCN?=
 =?us-ascii?Q?DbXHwekr4SYADfLTFirW/hKqfN0H8kMIZRcB3ZB5y/zi59IFSpTOUb6sWjDA?=
 =?us-ascii?Q?aapTVrKEkgesmZzvLEl4m/tQ5j10YYr5M8CU8aTYlZAcS3YWe0QOXq5sSAxP?=
 =?us-ascii?Q?bC0Q749YJJrwCNl9QzmNtzCzssEUmrgVJFj+7NfjX4mseupAYdhU6ev5n5z6?=
 =?us-ascii?Q?rVnQucDvhW64LdNskndskbgLpRza8EcnJtRvZ85Giqx4dfbh1pn6ovY3ZsQn?=
 =?us-ascii?Q?M96LfAWZoQag9MZTcByVvH6+zLccJZAoBNZvJFrq5YN7QP5hISPEY/aw41hM?=
 =?us-ascii?Q?TAvLedq3i+4v0sJuIoxtDlAM6Bfwdl09jQP6x80FZt2UVRUo6tbRXZJll+Kh?=
 =?us-ascii?Q?9kMXGMjy4hJ9xAfAGn0WFM2kw4X2ALhO5v5kq/nD8fWfYQQN1KnsSu/VUS09?=
 =?us-ascii?Q?2dIde6fLIZHxjhCmJM8mwysUHuursZ4S3SBNHtCneDYERCOmDp98iaiR5bnL?=
 =?us-ascii?Q?BnzZfbX8wyHla9nhi33Zrgr6nsCVfmxZjk/nTxWuJ3FE2PZBnPlndKXNfyt8?=
 =?us-ascii?Q?ieRFToUJB/CWiLUpnlUflQLLfEgXLt2Z8WEIXzQBKL0XaGFiLxElkPbFe9Ot?=
 =?us-ascii?Q?PgsqygzYFpjlxN19kIYH7hWu34hiYzXe8c15aZRPOhP2MfAbqZ6Zi3wTc1gb?=
 =?us-ascii?Q?zrYhGPYvVF9r4sgifDJ370ZOcZ2CPyKTjG9LnNVQP6N67NIQITbXQWbcB1tV?=
 =?us-ascii?Q?HusVC4mrBMpQJued0+oLDOxB5P9IZn7f/TUDX4Gne93Mmr0urxqqgiftII2j?=
 =?us-ascii?Q?xzoxFMY4QZM5oTO6GEWpVoRqiWhlOhpF/oEPpLq3Qe7P5of73wQESmwxQRx3?=
 =?us-ascii?Q?aF3PlP94mNYK00n+nWnfWncRU32CpxncCF5pCGsOgai6zqP1vFEOxc+3Ul63?=
 =?us-ascii?Q?TtXBRKyJz0J6N9GniaFAeGpJVG0NO0sK8rCCbPbW5u8tlJLwbjnM938EbtdV?=
 =?us-ascii?Q?eZnPQSdVu9h//kK4NKc1l5L70tZYpTS8Vutmakmo3iXBfwxHGhuQnLHQuOrp?=
 =?us-ascii?Q?EMbKP7Cg7sNgX7AyA3MKOZCa6pCsVGe/VNWwnWlGj3xEridhh6xID5IOZi0p?=
 =?us-ascii?Q?uzmTAupf1RpL0FGXiCv1MpXobPRRkSPwUbjxlrtYW8VVu+9oWtu3iyJwVzYi?=
 =?us-ascii?Q?KcGnKqE8jJ27muszZwiKXM6LzhG58adtZuc2aUTwrxAzSfrBZkchBLBDpbVL?=
 =?us-ascii?Q?HxILovyHl6eVEsYjnW/DD8ngTs6nzHMJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lXlji6zpT5PecV6HJG4sG9dYhsA/60vhlnGUddsKrjuzZdm+VsxAxGwEBgVa?=
 =?us-ascii?Q?DA7t0DXfLXfnsjLqpdYiRy9pI5prdYRDSezyHt+u71bJJNbOLQkoUFMkj3WV?=
 =?us-ascii?Q?3mZnMzLztAsXMOXbSlqPLnQNYkGcHJSUVBVFUltDpOIpWugT+3VWsT0DO6K4?=
 =?us-ascii?Q?PUDXpx6ei+1FQRIC5m3R38uRlr/gi2WK04pUGHg147MwqTp9pouI3CSZi6UN?=
 =?us-ascii?Q?c7dTL3p7icOZu5JgZe/+L7MROOzhxuEZbOXTdJBet+nqatZCe23Y3j2pC8Hz?=
 =?us-ascii?Q?owiAWSS5AhTOuzbg8UQpGcg5AEN5g1nJ5gohBz8/sYIr+b+W08aHedOb56cM?=
 =?us-ascii?Q?jBvPER3ZLZqhzsV5+dpoBh5zdUTCzwS3LevEqbs/Udt4hqAh0S2MEpWVMVRT?=
 =?us-ascii?Q?I1hdB25SKtk6GgUb635/p4G7TNl/2CasclAMSqguY5DJB+sqzKjSP1yVrKES?=
 =?us-ascii?Q?xKzKL9ZtF9Lm/HmkWpfed9lL9lNzMCxuHiMmijJhBya9D86RrkCKYfLhRgCW?=
 =?us-ascii?Q?7Y0rAfeyhYJQmKaFq7XfMJWO7RwLKGZ3ecpiWRAmYdIZlNgJxYbtzDPB9rYm?=
 =?us-ascii?Q?X1NQjRPQl8UrF8B7fRyyqDUERXoPXAYhnQmPrV2WWqTTAvXtUF9SUC3xO9hR?=
 =?us-ascii?Q?x0EClry7GMxSh9rUJD3aycUVT8dZ4UKNUQaU7IIdVf2+rw0AqK/5e2QU6n6K?=
 =?us-ascii?Q?Dn0EHjpA0Eqa+hWybQLNNkOl63mWVmkyx9ch1DcOtxEXN51m2WyrF4mCaeD0?=
 =?us-ascii?Q?STWnz4wbDcXLnP2KvJnHrzA+4jrG/aoWU6KnaCnpxqfdBHnwVAlhztYhenSE?=
 =?us-ascii?Q?9yCJcKBpfK2hlnATfBe1+UNqrNjABGn2j9p2YL6pyWmYec0oG2SHMdZyqG3k?=
 =?us-ascii?Q?t3LHr0PfE0l+2Pe0zSsc61NFUcNsIfSeogmckhrfoOAt6GVq0mk9wKWjTZr4?=
 =?us-ascii?Q?H0rpIlk0eoOERsICjcoNhNHsQrY1og26YGnigURtdud9GNgHlO+b+TF5LgYw?=
 =?us-ascii?Q?YCOcQo3bJ5pD3wJjOHIh876LpF3fF88rhV9Lf0Q58nXtC0p0xbqGHScSEu34?=
 =?us-ascii?Q?pES2xQE7lt6S3RO36Y6z7bCPOZdM41etQC6fCXBF0TU8NR+dsuhPda6CCFNj?=
 =?us-ascii?Q?WLnWxKqDYc+k6htaqEj1xYNuBHH+eZpXy3NY4chuW+EZnl8tBaNbGxZNMuxh?=
 =?us-ascii?Q?dNEO41SvDXO+kfBlzGZK+apTczRXOpkz2hImzc1FDKmO7+hQ/aQc+fLNOogv?=
 =?us-ascii?Q?NvQgRiASUN6oETelMlr/gEnYy30bE+zJw29AXHIaARHLvH6XbFKdeLoLlDwa?=
 =?us-ascii?Q?69PjEfQt5gl+ZWjfKcz5yDZaHQUsoJgvIn3dVoCMhmlNIfVTmEBNViJ8/Uij?=
 =?us-ascii?Q?fNSBszmGDXKILjQilzeD/tEIw8AKmKjDZ1xQkZkWZz4OzCxVv0S0wEa4M0aB?=
 =?us-ascii?Q?X7D75Zk+XI4sTkUtImYxN8mWcjYayQIjz76WRNYQYqGur5Ve5lz6krcVJA6z?=
 =?us-ascii?Q?+CL7ifPq/v0l22ny7zVk+KaIchRhyo1ENJVYSEozDHFXyEw/BIrFG2FtrFob?=
 =?us-ascii?Q?9wvBoXEEr3FUiTwcLiRADPjcya+EtmY3UugsyiOO?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15fc068-c4f8-4e45-b021-08de0b341aa2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 15:12:34.8366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJFDQu5F/UtnxtyvPVt1HV7U0ZGbhmpi9iIoyZitN+P4+1b9xdTnQ7xtNooThje9ba3hRX5bVV7OhW+Rv/JOXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7371
X-Proofpoint-ORIG-GUID: zrZWizYO-IG6EJ2LSY9_xW-uorgvejQb
X-Proofpoint-GUID: zrZWizYO-IG6EJ2LSY9_xW-uorgvejQb
X-Authority-Analysis: v=2.4 cv=U6+fzOru c=1 sm=1 tr=0 ts=68ee6866 cx=c_pps
 a=D7hViFZnkHkNtnby+5Sw9A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=aFQknEwPUWRS5Sz8q1sA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDExNSBTYWx0ZWRfX8fhf2YXpz8XB
 NuxfDb4+6ak0TOyajMyLlztasvCPoXC0URWCxuk6LYz/tArtDx9E370CLHqOt4hE9kIYVFmZLaM
 6uvizZYly/fvB1VvpvYnp/CWq+kCEZXmwFh1/g8H1lX0z9m1M3tc73REMKYUMor768r3vdpHk1F
 Y8YwsRuW1n55RR2Sd5+zou8s8dwrDBBPX1FiTd5JKuI7PE3PqtFYer/gMyyK419fwa1ax0gMHry
 sT0I2XZRjfxPU7Tl0S3yormaOOkJk2VMgoIV6hySG8eOLOM57OCsm6SjsB9IL58O0CyujyR+Vge
 z5aQV+8znITZR8Svbf3P+1S7b2JwMEk/aog06dCNKrDjc6NXQNSua4TjkOgE6OVat7siB1uVqDU
 3o2kLkKgnm0zublnUPhOktKaRD/B5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It is semantically valid for a VFIO device to increase the number of
regions after initialization. In this case, we'd attempt to check for
cached region info past the size of the ->reginfo array. Check for the
region index and skip the cache in these cases.

This also works around some VGPU use cases which appear to be a bug,
where VFIO_DEVICE_QUERY_GFX_PLANE returns a region index beyond the
reported ->num_regions.

Fixes: 95cdb024 ("vfio: add region info cache")
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio/device.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 52079f4cf5..8b63e765ac 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -205,10 +205,19 @@ int vfio_device_get_region_info(VFIODevice *vbasedev, int index,
     int fd = -1;
     int ret;
 
-    /* check cache */
-    if (vbasedev->reginfo[index] != NULL) {
-        *info = vbasedev->reginfo[index];
-        return 0;
+    /*
+     * We only set up the region info cache for the initial number of regions.
+     *
+     * Since a VFIO device may later increase the number of regions then use
+     * such regions with an index past ->num_initial_regions, don't attempt to
+     * use the info cache in those cases.
+     */
+    if (index < vbasedev->num_initial_regions) {
+        /* check cache */
+        if (vbasedev->reginfo[index] != NULL) {
+            *info = vbasedev->reginfo[index];
+            return 0;
+        }
     }
 
     *info = g_malloc0(argsz);
@@ -236,10 +245,12 @@ retry:
         goto retry;
     }
 
-    /* fill cache */
-    vbasedev->reginfo[index] = *info;
-    if (vbasedev->region_fds != NULL) {
-        vbasedev->region_fds[index] = fd;
+    if (index < vbasedev->num_initial_regions) {
+        /* fill cache */
+        vbasedev->reginfo[index] = *info;
+        if (vbasedev->region_fds != NULL) {
+            vbasedev->region_fds[index] = fd;
+        }
     }
 
     return 0;
-- 
2.43.0


