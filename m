Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82136C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZt2-0001QD-CH; Fri, 03 Jul 2026 05:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZsx-0001Ph-Ni
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZsv-00081h-On
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:35 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635ut7Q1961896; Fri, 3 Jul 2026 02:08:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=St+7SrFJ0+9LtZvJGgeO1n+M9aPeernogRx/8RFlW
 BU=; b=YuDqjhQRFoONPqpjVhq0xV24KPvzrIyhCCAN5zwCbGzfkoXyWovaEqqbH
 Q2I/QHMhdHc111KRsLAB4QYoFHm7Mpy0svDc9zdcG60Eb9tLSxaKyLSlSI5R0wc6
 d+8yTpnV9gv0Qjq6iTuQx3bv9S1Q0PpvT4KrLmOq+8sHawiQdOdiFZ3V2d4o2XzU
 /bYiVDJxga+uyb2HXKeWPvjVGbczOFM8F13Flvpge/Ia7MV4XQzU1eiBYwJeIWor
 nLxoFC/MB095yBVcIT+TzmEoKEgPzApylZkPixcJFyenjJqYgLAER8JEDuj2Mm+L
 ygZBF37uk/yaOl6AGRDFp3drkKzMw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023080.outbound.protection.outlook.com
 [40.107.201.80])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f57ebd75x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOD1n4G7TfT+74/KYm38kgWSa2Qe/Ke67eKkSLEbEICx4FwqMX/CXcMoVSPab9Sr5Dy4VrXiBszzo8oTvkeOfQaWy6tqv8KVmLXpYM5D7Uq4vCZsIffNk7km/EI9GKOloe1LZbYrO/4I0f47IcWXmLNVXkTeppZbJZnaU/s6x2OJkfJQAL+LnsnT9kreg/KBZTsiPWlgZpmc3h5GCrtgS/Izz3wY9oYkxPv5/7h4nj4q2zbZj8ULNqv3kVDRfwIyfivT2gOWIl0I9GdMQ5t8FsS5r2shYTk6Vh+c/Q+L0fgYWGBWst6kDDrJjG33yp3dYrjfUQYzIZtINRjOP/2gFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=St+7SrFJ0+9LtZvJGgeO1n+M9aPeernogRx/8RFlWBU=;
 b=n4d/M3yTepRLCKzIho2QjyIRgddddYEYcWjwaymqbAe12/onywS+jbjbmEEc+TQgDYoCP+9YdoZUVws4HDA8astN/gUv+MT6OC8Ta+rvpRWeJEyyV0pBsEzM/YgRaoIsQv2OrlHIQh+Q5RMixkb91QX0JNeGcM0QMnk8QEy+DZ73syHb/6TzJS+RFG82O8Si533PltEhCLwy7si43zREqzQVEbOUIsL0gLj00EVCqPNDEsR17EA02EzoIz5Ah5RqIZzX4wRhw4mDes8K0sL2B9VVA4hBNF3uYIeJPOgdYvP2YHAOIhgkOAeP+mnxV6ozRzU+gpPPWP7jmBYNDXZrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=St+7SrFJ0+9LtZvJGgeO1n+M9aPeernogRx/8RFlWBU=;
 b=E4IvR9/4k5+hZC9zft8g1yyDt8hq7FMR8yrVGQXGq1CqiOxyGk2m84SvqGX8GgkRBN8NdX21o/ZZyF67cn74rkr2sHRaDWLA4MsHgWibOaYHvI+ZGKr/GKbTw1DQs/rTLUQNB4cggzxei7E9topMQp3v2iQlaupmq/ooNPHlh+0OVewJGOgwAJAyBi8dnN0zJZQbuRLYcHE7HpY+d7P1qlKZgzQCfdhrKRNen+fnuZ46htGjJsM9jsK0IKNcOggIp5ACH4KyF9DVUB6aWe7gyMY9EnpA12qUmcbR9r+zM7EQaQGXAtkPA2wdFVSHUonyXHJskHZpsAqyz+3x/wStMw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SN4PR0201MB8838.namprd02.prod.outlook.com (2603:10b6:806:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:08:28 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 09:08:28 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 3/9] qom/object.c: introduce object_property_set_alias()
 function
Date: Fri,  3 Jul 2026 10:07:56 +0100
Message-ID: <20260703090814.2993188-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0049.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cb::16) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SN4PR0201MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 30218b09-bf54-428c-1ebb-08ded8e2a574
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: tTxG/hXWEL+B3XBJXShEar/2J6pg4g38wGgnF1IvsSfCAmESYQXWxbIJpRq+DjKb42dFwdiZUgcYXqDA8ilKRYHbF+/oTzCGhZ6c8CD5ws5AtAUuLlWHk+dRo5Jj+1Z62hVDfN1PkKF9BA8HvBRcORDBCCoB/IQMkwhumE6SardUv+GVVYOjlvV9H2zN2mYzUV/2B8Rv3IYMmvyeikGgnHbizRpw4ikZ0Oqd30p16aNy+/aFhJm+OevB6Fz9FPujhWuS/tpf/OlJHPDgnHxLnjD0AgVdEf8r//dEwJwdGxqWJJy4QQVohCU2lUZaP2SBE8oi+Y7UJaLlmH8DBsVwF+JfuwaycayRgRfKOsdouUdtaggQCulFVEDkcQNUjzDz9Oki3VpzafeZWiJ2TxlJPQlFyiZrfn0Lk/hwjn+DNAkWdwbQUmljwwqDAvJBYQdstJZxnxVMsDz6PgzomSPBSpOP9X3EV+DhK76xIO0/8MQPedcB5wagRI8qlnscE3fDCzGXvbOaBtJDpSTIPQDNKvbIM16Rt36DG1MmOmJ8zT+vZjUQBxTe+PFxtmdYoho87KYCyY59Km6asuWN59qL1b7XG4HFAh+hmTd1iUb+oJhz++zpdE2/yzAjK8HqDNSuyZetWis2MspKB1OOJP2qLsYWAD9Q0tVR6udxk0XKPPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O0q3BpKe1ampCoYdt0dY29oyj7rPg0s/L06UWl4FVcs7qvnAmVeAncCgAd2m?=
 =?us-ascii?Q?8SnX6HXxn8a4qGnaqT7WDOdb0wArbQ7ZzPeBBAp3/fSeUjjV5FZvDfu0kLrr?=
 =?us-ascii?Q?Neab9Zx03dinvIW49XU30P2oqZnSyINMr6w84SNJJC4GwV7hOi6HKzAiR21Z?=
 =?us-ascii?Q?OU3psw8O/XvZ10VRL5+BUBu67T5sMmTEZkLIFJJ7uQ9JJ54Ic8iPFODWxUGe?=
 =?us-ascii?Q?0DV6xzoM+flTJR/J5vwhbK3+Xh4E8O6bw6BTVC/iYddZ+bFyTb5ltmJzZGeD?=
 =?us-ascii?Q?eIM4/Avyh+Voz79YFitxkg/AS74GsoM7SavJZCDf8ZKzdnWvsLEbrsBjLWNw?=
 =?us-ascii?Q?2STWKE6U2oNQDXl9M2x0OC4MOQgZ6m2nFoLNmU/hUVQTH5RvmciaFKa8fkA6?=
 =?us-ascii?Q?hxdlQ4b9irhH1Um/OEZYIEOKBmvJYG5R0RHMoUZGdefB0HGtX6d7mnrH+lrH?=
 =?us-ascii?Q?i9YVX/u1jp6wym51xkCPAcuTz02kd8tCw7n7KkUYGl8Mu2GrC8+0CXLT18xD?=
 =?us-ascii?Q?zK95YZtalTWg7J+mI5UW0aQcXn2IY357WLqoGqVMuk0uwWOlfG7D/WGLVLQ9?=
 =?us-ascii?Q?mS91c0Wacl1yOBP4C8IZI54rfUT2Zy4RJaMSOEKr4Q+Y0tpdhJimWR0l/5LH?=
 =?us-ascii?Q?foDXzKZ6vxM7MWxF4xbg4v5HG7OgaOs0cXHbK8CONJ//v8pufJeET/55cGLF?=
 =?us-ascii?Q?sfMNlNSjjoRRd2Dv9NvyeCskIcbWkrVYJQ5uOkEUO052XH+EeI5yVmYZjpjY?=
 =?us-ascii?Q?gaiFr/vQ7LqHLf0VakgVqrRQAg3+GAcptPOHECjG1VwsmiWtxLqxZjhPBDuM?=
 =?us-ascii?Q?Kx/A6+jzF7F9K3Mjp4Y4DOoMYyA9crbX3Cvb9KVxcJCO0+orjnc0yjMiB5yB?=
 =?us-ascii?Q?aoBkKgoO0myZREya1nLJQJQ8OYt6Ho/1Jk06dCbFBKZbeCau4vqly7Pae+4T?=
 =?us-ascii?Q?hj1sXtN/0I+btKIIlszmhN5iwqVjuB80A8AaUJBqRY7y8gFcGesAc620F021?=
 =?us-ascii?Q?0QHmlqkW7AkbF1MtkpcyGdD08Ojgequna09Go9JKxaATKlM9MyK0KQJckUHx?=
 =?us-ascii?Q?etK1CSITtZ8ac6U73Z+fbLB+k633+th+Q3vugNBHBNwH4c7neS1zWU4PP1Rp?=
 =?us-ascii?Q?ZK+IsjVUjUuSzdwFdv9jbW8JIHORAhY/A4rbD7pzmaxU2rpA0U3KKKC7WXrm?=
 =?us-ascii?Q?5A2kRklH8J/Gz51hItIXH4PUCZUkoFFyTtfm4Uc5+TnTEVusvTjQU83KHWAm?=
 =?us-ascii?Q?y06NKQCDvnXs0EUHC83sTQKk4FmzDnEWBF7hBHQHNoipUkyv2zEOZxCuvEJK?=
 =?us-ascii?Q?8u6Zrk7VGEnbpr4+lhzp+U9bfrkxUwseuOG424aECqWM4c0vg/OFLgIG2zzS?=
 =?us-ascii?Q?B/7GV5t5wwYb7Sbn+RUv/B2iOHT3hWdsnB+hLydsjmNN14qAQfCFWg4w4EMy?=
 =?us-ascii?Q?zjCvKPdIljVEn2NcAm5Do6rxgcHCXjo6XGcW/URwpB2qsCVAjPwobqKjlrhb?=
 =?us-ascii?Q?Z7DfnyPYaYoIyA+jkxt2rGYjS58aimTIxgg5a7XLFzrVAy9FvU9W07F5bZ1I?=
 =?us-ascii?Q?GD/TKbbaWG5nJkZlR1dOcTKaCLppNXxULlpXkvtVp9iLLcejStLGxEfztihk?=
 =?us-ascii?Q?sqLsS/dItbAjZBq/nmR627RzAZYT47BWobYESRrzJ6DXi29vMqXinksVolts?=
 =?us-ascii?Q?2EmGm8WZ1Xm3lQnV3oMJ2dDCvw/bSf4d096RIb3eJB/ZfSGevkjM9C4i5PQJ?=
 =?us-ascii?Q?tDYHdGCMedl4ukoi5u1tGq+rrLta+2c=3D?=
X-Exchange-RoutingPolicyChecked: GKv4ts+M3TgonUY4M2mM0b/nTr9wnIXmzEPWUgi62/yDj4linx6/l0OZngZhrxq34tvkxrHU715/GnWUHR/3enHKLgQEYjS5hu7X79TnffwPXAGkul60Zr9jri09BvF9URcnGrLgz+RGEYV4djQvTB2O/GQ7NmsTAaKM1Fwq7rx+tB77Spi0sLuNU2+5aZPdjRDU6g/e7S5URE172xCbUHOYHToGxDYTY1nQYifB70i0NSQ9poR25OxN9QIME/oyfJu1R7O5BrZVfbg5ISypWNElh4ngBKTQ2W7bhiTdgceY63tv9MYFmlHAZ0EdgBicG6/Jn5XvFSCVOV4T5CrlPQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30218b09-bf54-428c-1ebb-08ded8e2a574
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:08:28.5592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiKe4RbOv/0uVdO/1fF2EzMIeO2cswki6D9iu6KNF+Gdhr0JV4AzPqsJG8LuJcrfSMSobQZQimt3k0quKz0OY6KLfs1Z+9CxDvHSk4+yoSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8838
X-Proofpoint-GUID: TSFZTPSSIcpa9TXPRzQNVCIabFqmgKDp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfXwrLCdd3++eD5
 Z+il15ZZeLEXyBd76xWkYMHSsNMgBWhrygFMUBQtu4FutiD8I/pTRqt5wjbDBlF6CfpTI7SpR5x
 GNWE+RMuu2WDPsY5Gu1vzfzMZPCp3mgF+CBPEt6MNzdUbLwnves2lj8AQJMPRvgY4hYOtPuYQqV
 3Gr9+kX3OU2m6S0l6FnvnOTqrw9PGPnrHszGJ+1mdCTQDXFpcVthXdLM+jYmSNg4muNAo6Ten6q
 ScFsncySaYdHnOCIL0vdmcAt8ZkasOQ7/rZ9J0Dz4gNbggU8uyMcO5sBSO4K4XUMwIrSUqGPysS
 2KprdubuLKNfniqPgHKkJnjUKjZhqbpTgZjwMZyozGvoBCt95c28qqWbM+UFsDKyxKuHPoqVn/h
 DiJRgUBoPw2/D5Z+gBhO5jf0aHP9IM2NLeqAmMqT7D26tnZQrThJx2gptmQxDnktx5Jf8cVLWpd
 Sy2OVibLixofanmGHBQ==
X-Authority-Analysis: v=2.4 cv=HeokiCE8 c=1 sm=1 tr=0 ts=6a477c0e cx=c_pps
 a=cfv+jupdUrUvkxZLjajzrw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=js4qBuqN0DX5_KR7ZAkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfXz1ArbkdMFHi1
 Yl+BU1M0Jjv3K8cWsMAE7MvLgIeq5UA2SgAmBG5Wg+d5glnh25/B17y6hvofuS4eC0FbgNt9o4X
 oh3gZ1sBZFy6MIg4O9DCSEXbceuVEpw=
X-Proofpoint-ORIG-GUID: TSFZTPSSIcpa9TXPRzQNVCIabFqmgKDp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This will be used to set the class alias property for a specific object. Note
that this function is only required for class properties, and will assert at
runtime if an attempt is made to use it on an object alias property.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h | 13 +++++++++++++
 qom/object.c         | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 659b70651a..80c400e1b6 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2055,6 +2055,19 @@ object_class_property_add_alias(ObjectClass *klass, const char *name,
                                 const char *target_type,
                                 const char *target_name);
 
+/**
+ * object_property_set_alias:
+ * @obj: the object upon which to set the alias property
+ * @name: the name of the alias property
+ * @target_obj: the object to forward property access to
+ *
+ * Set an alias property on an object to point to @target_obj.  This is only
+ * required for class properties, and will assert at runtime if used on an
+ * object property.
+ */
+void object_property_set_alias(Object *obj, const char *name,
+                               Object *target_obj);
+
 /**
  * object_property_add_const_link:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index a1b0ea19a0..7c8849d75a 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -3071,6 +3071,25 @@ object_class_property_add_alias(ObjectClass *klass, const char *name,
     return op;
 }
 
+void object_property_set_alias(Object *obj, const char *name,
+                               Object *target_obj)
+{
+    AliasProperty *prop;
+    ObjectProperty *op;
+    Object **target_objp;
+
+    op = object_property_find_err(obj, name, &error_abort);
+    prop = op->opaque;
+    assert(prop->flags & OBJ_PROP_ALIAS_CLASS);
+
+    target_objp = object_alias_get_targetp(obj, prop);
+    if (*target_objp) {
+        object_unref(*target_objp);
+    }
+    *target_objp = target_obj;
+    object_ref(*target_objp);
+}
+
 void object_property_set_description(Object *obj, const char *name,
                                      const char *description)
 {
-- 
2.43.0


