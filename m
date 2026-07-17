Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315BFC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkgcX-0002dW-EZ; Fri, 17 Jul 2026 07:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkgcU-0002d9-HB; Fri, 17 Jul 2026 07:20:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkgcQ-00089n-EC; Fri, 17 Jul 2026 07:20:41 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HARvVS3623501; Fri, 17 Jul 2026 04:20:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=apErGfvPpfNAH
 k2X7LSMlZc5EEEixf8hWkgUHOc1Yw8=; b=z1huWBHgqbeUbrihtQi+TyyZ7mbBf
 d9d6cJCPgLychwCZHc0gI79aMS3kilQDtRqTktzYXOokjkKIyVKYHBwNWvmnIaR8
 TUuCeaiLGe6vuSAfOc1xhDL90XsbIFknkhUUER2VjjMGrD7K62WC/EG+iU7vt6zb
 6s8Mg4fNJ2BAA3LzMHYeOun6D8sBUyXpRYO2QehK8LZLgR/sFh3uO9ZNUJ4xKVLs
 o5Qxk7qb8atqr8jR17PvHvRwbVqj0K5VYewZ6Gyl8KhDWCZ0Hsa8TJwLdwPk8ZnQ
 LTp52AlXw9sUyjZHCGgdUAufDWjtplTWsV61O7OP/285i/SI7qZ7m67zw==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023113.outbound.protection.outlook.com
 [40.93.201.113])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ff7ks1e7a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 04:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtZG3GbX37sqdBzX3KEim5oo53XLWzBdOMXGuhdK5ImmcqGrujXOd4xF9px+FpLNrNQYIqvO26NjWfDqC4PDAfoA0YaZ30i2aaxgtIS6Z4iXYLg6pF2SE9pbwbix0YK868/QVRC8k19uW/+AzypMZclcIv6L/sTnzj1Hvu2QHQXDJjyv+2Vx1o9swBj5/xK1e8EMc8BBErBkcXORAIOlBLTqI1I/IcZvq5Jk1fVgfccK2TDOLZES3XhgrFap4pDD4CDRKSAZyq1Muc+1wpYMhFn4JLjSfY/0iTUzxvgm/ZQnN1+8W3qaNJoYp1cn5CSgv9oZrFGdrDxjdBFJGR9TWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apErGfvPpfNAHk2X7LSMlZc5EEEixf8hWkgUHOc1Yw8=;
 b=yAQoxsPWrOQLgSx8aKTziEBTn2/T0HEHG3w+95Ijd6/4TlGo4PYPfDamu0jGVCTJoHZruovfonnkt+nFrvXbXFNV5yDrU3SqF8rXuA/SwdQ6UW0hdz4yJ61YigkNGgECMk6UNO2lYRVkrs1dXiklYws1DNHwssHHRAO2b2AnCICQkM8SaH4lLF3MADw4FosAgTPgawqyw8X1osdwkcE+4exNW0rnxyuvOyp0/i9Ii+BZF7WPJ9N6NgZiDTOZFaAnSZXW4p6qy62bycJtzzj3yNM0VuwdDNktnv0bJaNkGi3VFtTm25TBttXdNLaBelUNyAfE1tdMgpxuzjIU0PRCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apErGfvPpfNAHk2X7LSMlZc5EEEixf8hWkgUHOc1Yw8=;
 b=L3CylrRamooJxy0S0yvIvLzRcbwbiVYit1VjjiqpmUgXzbyUJXbNf2rXYdMGmzMB3zLZq+Y1Dxw1UZBNzLA+1l2DJsmmknbUYZZKy4nV/VDxMvQ4piUDQp+DqlOxK+KeGdIhmb+KjSLKJEal5R11CG9040e23zXZnk5VypTVant+2MDyAqKErUXio6s64Rv4UIigTI5gLOQeEIfn68gT8yUHsZm/aahi8sNP53vqtAt7Af7l0IzzgRyByARORfHZoBCmZfFo8b6FCgCzUFBG+IumTnVoI1cHi7wd8sNZlj/hS4KaxaGP28rTyAnfvxGO8SNQ5ufU8CZ5CHFusVllbw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7503.namprd02.prod.outlook.com (2603:10b6:a03:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 11:20:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 11:20:25 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, pbonzini@redhat.com, berrange@redhat.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 0/5] qom: tidy-ups and preparation for class property
 conversion
Date: Fri, 17 Jul 2026 12:19:07 +0100
Message-ID: <20260717112022.444367-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR17CA0003.namprd17.prod.outlook.com
 (2603:10b6:930:17::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 438e0c78-354e-4513-eec5-08dee3f5665a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|921020|6133799003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9so1o3WEqOYHHoMXg6b4Yfzn0iXG9T/aV6YPdYYtafdZd/1kOxGnr5vp3LKp5WG8LqpEgR0l3VDZfJC1o+DJrDFlSQTmf5oC2dJnpjshG2jpoonrdymOkk25mM2ZghbDsZpdbq36MLyptHqNwYbID5oNUnDO5ePof8YyUwUWHkF+jrobyZVwLWbNqRf9WOSXNPvfGzuVHF1S/RR9dTaslpRKOpLx17xQ0aNeBc2iuVzaJJtcwhYJRNgAh9Wn2zmiT/DcvTCQJnaT0g7dXxig0upFx9JHzxfTBYjCReO5CRhwsHdiD7LO8mm2AJm/e6eBAgPZtWqZveEy4bJ2vLV75QUnlTdncD3NR6OAL8G/QVq1CIPi2xEV/RM++LsqO5mi4fBR12Qxf8tNm/Y3fCH1xIakHzU9breAlk0qovBAMhs2ACILzC4bDvK4e/cCi9HzdAeXPcSE7Yn0kiSn/dW2d8/nxhRnJD9KBO20xP4VvGOa0OwYFiH2G2IVq+v4WX5t4qo0ySBYd29+QKrB7RsLJZsQBhs5S+GgrBXslnNsb5QXVNa8Py6q6tKxI5BVN3vvPq+PffDj0wlYTudQvtWqapX+Ttv5B+RRqloRnUbYcZMFY1M+QaanWlz9CyEYh1lIXEXSSHa+3k1uSVWNQl0toluJKXutp2HRmgw5sLEJGH5rcBAThvz4x9bIHERDOV0iETJBX1zzSt7siSFwjyMvHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(921020)(6133799003)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+vzHKI5u9FfL2KpkNOaFHpS9kp6S9aQTPWXw4g7Kqyw8oWb9qubIY2sZC373?=
 =?us-ascii?Q?E9ttXqVCBUFvLHRsmukBpXWfvyVR8hKhYFJZpXKPAWoPrjjlzIzTD0hbiCZO?=
 =?us-ascii?Q?ZFAyYcUD+PZTRp2J6IaGorUg90iFJsr+9RoxrhXtJfTGE/lgivzPZbEXg1oq?=
 =?us-ascii?Q?rqeMiarLOmSa9pAS6uUJtMYmUZ/ASnMGJHy93D6j2du2e4FOoXE4dTRsPXMj?=
 =?us-ascii?Q?Le7u490vzbq53+B9y2UY5hl0zrh4XjpuuPePyybSbxHYfVVNMgInLG/6c9Yw?=
 =?us-ascii?Q?3Y21eVrNtxb56JskZZo1JrGGS79mPHtnwj9JQd7vHIXKhB88gsN8VXlfup6j?=
 =?us-ascii?Q?JuFvlwHhaUejZxgr1OrJAke38yZ6GH76RwJO7E6Bmf72Blo91+HbM2c42pIW?=
 =?us-ascii?Q?e6rmg+iKH/zRfCQFFky3C8NZ17QtmI0KresaBcvgWX1ddL3cCepvkMnIDFf+?=
 =?us-ascii?Q?2N6w+hV3l3BWdgyY4TvEQdIrLDh/k2a4xaO/HrssBOUZLI+xRHcB2NLZ8Z+V?=
 =?us-ascii?Q?HuZFguAAE2HJGkhsuRBorlInVwZhfYLNHZPylbTpqqngjkf18W+W0Vf+WHLf?=
 =?us-ascii?Q?UqnZb1ll5iFc77BX1G3rwQ1mNTzM0+tzEJz6LsosdwAZ4zDp0gQ87MQ8Bzjt?=
 =?us-ascii?Q?Bd2BHhUn2aJ0MxBhiTLFBeziu60hQ4JL4/GvdcOgXRq4EUCPCqkRSE42PdFR?=
 =?us-ascii?Q?Lz0EyB6Ekyz/X++8YZlN6HlqjfjGVMKsA9X59DhY6z//aR3pILaTVGV3IAp/?=
 =?us-ascii?Q?15TM3KVXaGU4beCc5WsDyhuyiynbpF585omhbvGtJG2F3yiwrg7ITer93apm?=
 =?us-ascii?Q?WBE4QeZXvx5tT6Su4sRZfHoIf6++LmOt8p2eTCt29eQWJua/8pDcrZ5T0LAx?=
 =?us-ascii?Q?2jyKj91AZMcVocrUIiLuIqhUEAywUNXLynL9t5tP4cjMF1TKrsC6YDnhHMf6?=
 =?us-ascii?Q?3Q+vP1LV0rM36LJArl3PTDCkBBFUUG5eoCni5ykdZ7+gR/n74Ym8el5NJogk?=
 =?us-ascii?Q?MEMT6qWgoY+8WSTw69O8YAmhh7NoAx3d3AO0zz1FxRVJiO9w+gpPjZJTQnc6?=
 =?us-ascii?Q?8u/zIgSg1JPP3v4NuV57MeULzg0KWQkCidHrPPVfKRWmFV9CYIpZ3Z9urXsF?=
 =?us-ascii?Q?5y9Yuj8ALqcr45Alieu5Z5QUiH0AXioC0xbapnkvKyGMdOfJYDBE7pMknAZO?=
 =?us-ascii?Q?Q83Y427Txwq7IVLo2nMc+ePsXD9fBmhthZhcgcpH3+irh8DV3qasCdiU0ADy?=
 =?us-ascii?Q?0iBYkd5TnYqYFbR6MjZ6F2MRmdjymFU57BudGkUL4U0XOi/bhHMLuE49bzin?=
 =?us-ascii?Q?t8WdZbayrGo7muncX5hab9EaNn/2+U4oU4K+jq5JfxFX9tAiO6MGEY/pjygd?=
 =?us-ascii?Q?92TwWRoYsOWfICzfR6hGk3FtSo4ZB/kgtOo/XP3hM/SLxBwCNtcrYUv9N1LF?=
 =?us-ascii?Q?9vA9luP3hCscKBhK+THMsle14lmBZ/o2YvND+k83YDVaptKAoYd8ARIhxlYE?=
 =?us-ascii?Q?Lg3Obqxj8Nv63JxQM9sH/SNXP14LnBBLTmo6/5d7DS9H25Je4+s9Z5m62aJy?=
 =?us-ascii?Q?30yv24KJKWWMd7kjyXimeGCcDNbpiSBOdHz8IBGsMR8b/7msnn7PxbD6ktvP?=
 =?us-ascii?Q?3alWVEGdft22qKq7PzHOe5SUBolvy4WRkaPLjGopppR9X0FzN1AxfFlBFvZk?=
 =?us-ascii?Q?cOZ1ol6bhUGgc2JBraVo0WPQGnynwi6zaChtd7/8g2RS8X5JjFui1QwL9e6j?=
 =?us-ascii?Q?46jU1kgwsj4XXBhSjCWW/OhgSHH3OEc=3D?=
X-Exchange-RoutingPolicyChecked: B603nW+Uiz5DDL74jmoY5NYpbju8saR8BHju10CdwCeSDWrvXzZKpTARMkCrNmIRWu1lPtr7B2oqPxBE+dYN5pQQzQbQLrHcGYvxGvh1H1VbhSeWDmjKZMsDN4NupUelhihswBFTTgeO5zEvO7/H7Aewxt4TNBle4YRGNs5e1KBpU3vQj8fbkQBpis7XrCHLsTsdC7povi0pu8WvrhBcrjwYfpHdMZA5Dd4OmxHZ/IoHkAgQBdHvoS/z9qDjPxEx+90uqtEyFQDrXgRK/UJQTNHR0+PQxZ9SxI/cNyvSeSvFWjcrTeGEcX7gMf8Hi/+VoIfIE5MmYqUKzKSoej3rGg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438e0c78-354e-4513-eec5-08dee3f5665a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 11:20:25.7789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7V8Bm2ppl4g6MbbNxi5Fd3IENtXuasoa+ozZWTwouvgzlEg+Rk5WxWafvxWCLg1f5I1etak2hWbNSiOlTtDzIrh01cgJiLRDKiXSYZIlRRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7503
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExNCBTYWx0ZWRfXzv3uM4Y1FpSd
 YQVqXtTZk+8l6XcczMAnaMn0qaTq6JIc9MFre/cWWAKWnpXI32izqj5gydqJ1A5CBuO47zuhn10
 CjZN1gR49HcC6RAzuYHJ/EOiQ+7apM3S1C98SwnuNLwWnTH9RUvxlKPF/D5MZ3O4loMR/b/7VPO
 Kj6UxgeSMhwYSOVirrfrWmRY5bCikTeXvQ0LLa5IqMnA9sY8TFtbtQYrFwvRAVpQe8BTQLz0L93
 k9i2+SbEKix6jPmGOK9PF5Fr3DUjuYmj6vJ23HxE16Ekx8wj42bLyOgTH+h5zW/9ib7QxzczRH/
 C0UHGNdMwJ1/4vkBGae3Lshv+4bAOtiCIoLNncmroZW1CtX9sSYMu8hV1J+J+PRcIVsYZwyDo1P
 qCUF2swlnbdCy1wSmysCLVyv6yo62DtdoZW0B4EzZNzLntgpEtBZd7SgXxQgza+LzXt8/zOnCF8
 Ld8xEHH2uw5CWtWRPkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExNCBTYWx0ZWRfX6v+n9KTTUZXH
 RieHyJLCqvKmQE37Zo4x6Ax1hRSjGMYonhWe3GVaSdAkdRYYZGGbnPMaKREiTH7fWvfKqhcwE+g
 Z+sZGk3PuFz/mMBiSnNy89kqi4DRniY=
X-Proofpoint-GUID: Bmewh927k387bt3clQDBuQ8dNGSVBEsC
X-Authority-Analysis: v=2.4 cv=BdLoFLt2 c=1 sm=1 tr=0 ts=6a5a0ffc cx=c_pps
 a=zMw3/4lVTLt0/G0IafOnjQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=0IkUZrEFzZdfXiLh1ikA:9
X-Proofpoint-ORIG-GUID: Bmewh927k387bt3clQDBuQ8dNGSVBEsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
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

Based upon feedback from my existing efforts to start converting from object
properties to class properties, here is an initial preparation series which
I hope can be applied soon after 11.1 is released.

Patches 1-3 introduce macros to generate the QOM scalar get/set functions for scalar
memory-based properties as suggested by Daniel. This makes it trivial to add any
additional scalar types as required in future, and a similar pattern will be used
when introducing proper class properties.

Patch 4 adds missing documentation for the current object_class_* property functions
since if we're looking to deprecate object properties, it seems only fair to include
the replacement class property functions in our documentation. Again once class
propeties are added, the new functions will be documented in a similar way.

Finally patch 5 renames the existing object_class_property_uint*_ptr() functions to
object_class_static_property_uint*_ptr() to both confirm that the property is shared
amongst all instances, and also clears the object_class_property_*() prefix ready
for the introduction of class properties in subsequent patch series. This is taken
from one of my existing series to convert object properties to class properties, but
it seems convenient to include it here.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


Mark Cave-Ayland (5):
  qom/object.c: introduce OBJECT_PROPERTY_SCALAR_GETTER(type) macro
  qom/object.c: introduce OBJECT_PROPERTY_SCALAR_SETTER(type) macro
  qom/object.c: introduce DEFINE_OBJECT_PROPERTY_SCALAR_METHODS() macro
  qom/object.h: add missing documentation for object_class_* property
    functions
  qom/object.c: rename object_class_property_uint*_ptr() to
    object_class_static_property_uint*_ptr()

 include/qom/object.h | 148 +++++++++++++++++++++++++++++++++++++++++--
 hw/riscv/spike.c     |   5 +-
 qom/object.c         | 126 ++++++++++++++----------------------
 3 files changed, 193 insertions(+), 86 deletions(-)

-- 
2.43.0


