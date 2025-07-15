Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95140C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 05:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYbQ-0004Ut-KZ; Tue, 15 Jul 2025 01:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubYbM-0004S7-7Q
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:53:17 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ubYbE-0005jG-Rq
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:53:12 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ELHIpG026861;
 Mon, 14 Jul 2025 22:53:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=T48Lq52rhF3kK6Uzr5oeBbua9z9aspJWHAZc2YQF2
 SQ=; b=DbT+jTnH6+y4+a2DyookYMuJiPewZ2QPQ5Yyqcl6LmAbxcjY35EEXkw5R
 AejjAX5O/RekkLftzSoEexStv/L8Wzqz/lYpQubGy1nYjMUBX1kNAbYuLVXrNkb0
 I7ci9bxTY8c0KR9zcctNUe7P+g4xdmXJEm4SpsYymagKDb/5Gq+ZJKFt2HuZEJ10
 cetZlu7ZIuSoPtZs9mTisPBMn4T4vg6gq9HPd/s/uByIdIQ3dJE/1efLC6OhDUaj
 1W4zmgnaAhLe+SnZD/3uw3F/fmNfo/4cCyt/2UMktLJaibcuYNfJdnGveNzsXyba
 aWg2GjGD7FLjrP4khhHnqON3/LtEQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2096.outbound.protection.outlook.com [40.107.220.96])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47uq81d9qh-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jul 2025 22:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3tcMMMiiIopx0FWT4aAgt9FZQ1MTmUuuKZNVYkY9A0b9XLU/6bsE25BV1nJvjZ2X0UJZ4tl6E082zj/DaTo1VTx/DdmRz3BuTLwoNcFgf5M7SRQLN/C1aIFv8xHlXhWVj7riwUhPmS4iFUFLTzVwQLxN9NnhzUEYhjUGOW0MqFDNhGsdSvTjJiiWqQMTWs1OdsHrDFF6Hx3++qhEmW7EQwqvp6gkfWlFgju1zi9/I2KaDCcyBVaKZJrXSn334I68QBOSsqmxoGNVLbZorI2eArl8h127Z9gye9iE3faiMcJpIlCU7WnNLvBSRCFd5o9xPHoA2MCNXKkp87Bf4PJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T48Lq52rhF3kK6Uzr5oeBbua9z9aspJWHAZc2YQF2SQ=;
 b=K82hR5QKxU5fWdR9SrJiOCnA447RrD5uYfiU7QWEpwhmLX+qE6RYBE+j2VI8tnwxBrPCvthPUtI7NJAea0zz8hV1HLZ3qSZbQ6c0/OFQiCWhD/1mPzTuQjEVu6aMVFPFCnchINjTFK5N+AKg6k4X/XJEWanlhUuK6LTxSlJLXzp3REeFFqqyBZUD91T+ScblS/+2fLLM1++dx14Q4xC7N2yT+1LJgdiPA1dzinfxHWgDmTQJIC3UOF43PbVrrgHRFFeREDYaL/QDMSR/DrvstiSDTOzB395HMFiS+DDuKs570hhA0q3+InNtovEGySPX38C814cYYoALhlQim0N5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T48Lq52rhF3kK6Uzr5oeBbua9z9aspJWHAZc2YQF2SQ=;
 b=wBoWrKFF2B2gUD3Ho0HTfQ5To0r0TaPy7zO/1TM7BpYek6LfrWK9vF9S1yU803SfG1lu6ksamK32DPUNHuYvTCvg84uFcy3Q086Xm76xxftl0jl9YuuwfgzatkRCwCRO0YsPA5DHf2Cgs6IQ+0v91aWBOTu/ZeqLvV7ZOh3tojwObA7zVsq1hOBUrnGOXCguPk42LKZThznAtyGKOUFfBVpEXKHWT1BJ2DSkwSCnLiB4Gh61o6/CcAZZBh6kgnxpv4vwY6dJsUfPN5FddqFy8R7FBuvoLme+RHTjxVTMdf7NXLGKm+dAD+7KtJTOEgyzRTQhcgIyR360J4e1SXVltA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8841.namprd02.prod.outlook.com (2603:10b6:510:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 05:53:02 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 05:53:02 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>
Subject: [PATCH v2 3/4] hw/vfio-user: wait for proxy close correctly
Date: Tue, 15 Jul 2025 07:52:45 +0200
Message-ID: <20250715055246.422834-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715055246.422834-1-john.levon@nutanix.com>
References: <20250715055246.422834-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 668b3e6f-00b9-474c-ad65-08ddc363dc2f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OJHPVWL6dnP+gELAfVYq1seIIm+X8vKJR5b6ZTmaxVWMPIHzef7e3F7Xzf3j?=
 =?us-ascii?Q?s1RyDY8oafnbRtX5S6a8JHUQIH/EtdV6wwqzrDkt7gdbsdRs+vpTLubUtMZw?=
 =?us-ascii?Q?B4SuyeuXJNLs3JaAzJ015+25pdENT21hJdFWK97rJ+Zs/mmUwDlhyfdqlVDT?=
 =?us-ascii?Q?C+yGLrSK9oratZ+IwA1LYvipV5LQ50Rqev1/Y8cU6kW4PVdW3WzzL8ABbef2?=
 =?us-ascii?Q?UY9lXUcpW3myUmnZErrNKlvXjmCVo0giOyn+j1h/A0T4BQB7xQ72cFI9qdkY?=
 =?us-ascii?Q?gqKV4vyoti85HLtVfh8nS4/a0EugWaxenDo48dHEi3sDtNKTq5Y1tZZ6QjZD?=
 =?us-ascii?Q?ERHWf5nwCa6YYELAV91UUs8gf9jaZ26dc5DiPX+s/CYkbLBqg9mgdM3O0OjD?=
 =?us-ascii?Q?BINay4nWyW03k/8FX/rVrtuPF0zVpVRr1GeHKJzdHOk1HuP3k7BsX/8kNWgo?=
 =?us-ascii?Q?HzCYFsGgrgkqUGY9MJUEvwLJ7KmgtPEjWfwaBtmwwyjXq7JOrGEAGM7RHXc/?=
 =?us-ascii?Q?bzq6NqXVw160b8ARNvkg38y1ve9H8ZHAxssa794NIaQyE0BWZxDFIm7ZUQrU?=
 =?us-ascii?Q?1e4n5NocabFjdK54DQ6hWnUPWlDaATZT63qrMX8PU/kvbTKcfuujGKNZx0Bc?=
 =?us-ascii?Q?wjClLT53arJe1sLO9fiKSARpuSK62XLPWLDpYXTiKUGb0Jgs6lnTVrm4bgQ2?=
 =?us-ascii?Q?x2cuI81GYZGP5bVj6PGw69+CeC9mzfwXuJFcti/aKogadv6mB+MGLAp6aog4?=
 =?us-ascii?Q?3IaGP9DzFKXUY6EZb8n+tPTzxB5Z/r+rs2w4DAhsass80jClveaHW4vp8Ny+?=
 =?us-ascii?Q?vMQ83O3ev7449wpjwQxjM5FBxsyCOaD67OfJAFzcDPTMUolP1DCz1yKTWxJ2?=
 =?us-ascii?Q?Dc4F3yIaY5pOi7AKwQjmkaszWQSgn4m/jr6QMVP19pYHKydS3NkogI8SpQuB?=
 =?us-ascii?Q?yrbs1DpV0SVdSJtOy4eDhB5u2wkSzag8iaw5evSnFnmdL2v3ghVtbnIinb53?=
 =?us-ascii?Q?i/SH8JVLm6CwRyLNWzqwIEXkujOAmquHYqEXua1qCxHl6IEjmn+QOM2vwlXW?=
 =?us-ascii?Q?n0qIXWNrFRkpV1r5mpFuqLaE6h2eW1oTrYA+mszj59Os0P6ZPMLwWx9OKJXG?=
 =?us-ascii?Q?W8R4qV3fBdlQMY1l4SZDFITRQh5EDTdoCYL4iC7/hpqjkjnoDTC200edWhpj?=
 =?us-ascii?Q?se/ALcZhQc+RCXcyb9WObSXlN8JXj9/xFM0CYTsRzXYZJbXkbkb9jGZOpJ/q?=
 =?us-ascii?Q?U7y+Y+42+5CUrRZ8pormMfFhZICMqoZwFHdTUqty7H/CKclxgHc8bZN/azge?=
 =?us-ascii?Q?2awGskhrA8zhZH12aETHzMVQbsZuXiEum0xFODPy6P33Ovkfs3hPw8MmZg8G?=
 =?us-ascii?Q?bRMMSj9eszZiyaCbtp2q79wit3YW7DYpE+YT+59HE5lUvQXJVSTRH5RTZe++?=
 =?us-ascii?Q?+GZgDmqwwGk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p6ZltlXSOhkltkR1nDDZEv0yXck/LqlgXQMn+rDlFtOMQBC/74P9lwrkksR/?=
 =?us-ascii?Q?wKErzflRCWc9jBEYKrmw4G7a4zlT+Rqm5rCjRgTyyAxSZpvv8brUMzTy4Adm?=
 =?us-ascii?Q?KBBqRPvIdjR6NbCpYBNVqnjPnT79LfRlr1RuTIA2EunJJU5TMyO2Q2HmOCF1?=
 =?us-ascii?Q?UZ/yAKunJ+GUAJX9RBNjJ49j6sRqdm0MucH/2fUZ0+ZErK4MFyXEuz2XQ0wF?=
 =?us-ascii?Q?hmX0gOSoYecwrHx5YsM8lsnYS2RUJ0cvDlsMMJJ6M2a8tDU1FWuNnolpJ/ho?=
 =?us-ascii?Q?5LvaQvfD9K10dSMkt5FCkb/cSgNhowfNbDXKmG3oYsbpfnlw+5AGg2M1+ixe?=
 =?us-ascii?Q?sx8uwn5/Qp+C6084xVgw5oPMARVd0nB1aT8FNFykf1u6ppS57I0vbkzNzdsd?=
 =?us-ascii?Q?9XWObe+nKykXnkdwcsxd6CLDnmoLttNqJnFtebpsXeAW3IZqkci579VDDdM2?=
 =?us-ascii?Q?1odyhHSM4o70Y6pP6oO8JyLPVDAasONG+Gmne4lPv6dhLhC4D53MRl4Ukp7B?=
 =?us-ascii?Q?JovGHxTfUm1MrZZFmcXnDYCGMQR27PyaLR7LNdT1c78rbl/T/aVinn0TpKW1?=
 =?us-ascii?Q?G2CzFNQjq+Bil4CxsPRVQ8WqtDGmVtrSwqCEd3paUG2a3i/NEUOSruOA81+I?=
 =?us-ascii?Q?Hnrmrb6utnrWE2AmCN/oDSgz7fxisPawS3C6CV6wVAYB5QhctipsWCmcFaGU?=
 =?us-ascii?Q?KN29tKjTGIDMRMZhIqtca6xZ3r5z1R/tQeizO/hzIcb//ocfeCYB1oDoymb5?=
 =?us-ascii?Q?2Ss1mfE8mfk3DCAhKQMrat3u4DeVJzcIcVqooJXVqAA/eIgKXlmS94FB5gql?=
 =?us-ascii?Q?tSV3hCiajjGCnuuDX/PzL7if5491W7eK3OoBgy/90KQwXpgI2S+qAgaOom+s?=
 =?us-ascii?Q?DQBAar/i0JDXVlg4so0IvY9EYS4TmcHrSxJepHedG/EHSDMynwbhPj5qGV36?=
 =?us-ascii?Q?oPEoq+aOKQcg5b/1XScF/fkDO3NVq0jkjADK1s6LWYKeHiuc12YGkW1EfCsi?=
 =?us-ascii?Q?8PlZA3ZtP5RHhr/BcRdoHgWN3Z0bdbHpdU9H1yRgTtaj2okiwKRQZetkzGfc?=
 =?us-ascii?Q?Nvg1hdMNSCSleNht4wTG2Q4r9OTcJSOlrv5ShKe5jtknAHrC8dHNDKCuGAh8?=
 =?us-ascii?Q?ZawIIoEZdoLQk4lHt6qzHJ6QpwSwIkzK+Fqcj2RqL7L4fCTL3wFdcGp4Z14F?=
 =?us-ascii?Q?YbOW1Wo1O4XZGwjeMg2KHIYlv/v2GoMAOXiIdHl5Yv7vKRRD1gdxpvx8KHXU?=
 =?us-ascii?Q?vPjvvEZTUxSaGbirI/v0E4W4vtNceaftjd4NAX9BXS0p/8sS6kZdyALbiKs8?=
 =?us-ascii?Q?IAbk8D/nJxYVc+d+IS9QmJ3xpkVg+T6u3PnHM9fZ+/d1GkQT19Hr+XRrfQSn?=
 =?us-ascii?Q?cPucDrSiLIlh03lY7P0CHJ5uLhJj72yT0PFabG3yuy+5VTtoJ3IUQfgMIptu?=
 =?us-ascii?Q?vCPawGEH4itPSNki+NmP4f7FhxslH12Rqe4DR1Q0cToA4xHYXECeicZPwA0u?=
 =?us-ascii?Q?dufrxU60EFgkUthF7CwnDmuz1PhbfhawwxwrkgrS23Gs9bfcQeHIaE7mhfvx?=
 =?us-ascii?Q?hlHYFszLqOSYMkYmtnjgSovEErxbuBO1TxeExv2bOiVYoyKcoYof9tEuaOnM?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668b3e6f-00b9-474c-ad65-08ddc363dc2f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:53:02.1441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cT+bGv/YqkSljwBhvcyzzVgjlzfBbgHCuPxKc62Tr9FUmxlBRH/R6Lu2r5bU35fwrBTGYnYsFECd3EDYuvyrjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8841
X-Authority-Analysis: v=2.4 cv=bL0WIO+Z c=1 sm=1 tr=0 ts=6875ecbf cx=c_pps
 a=+jfnsvNtYUVjUhI0lc2tVQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=6aF94XPOkflKZwprq4EA:9
X-Proofpoint-ORIG-GUID: 5z9D91KFcdL747fq-ks0Kqbcemlz6r6H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA1MiBTYWx0ZWRfX37q35c2pSvwC
 smnq403o5ZDNGB1F7DK7hHbX9o0lx5Ht5pqdUphy1RPK5weMSqOwlpKWDEHTEPmeB0KH4SMYm0W
 TjYZdIykkhczU+vSCmFTPUiAzPxCkAfn4iN/iET/HQ6pexgAIDPPuHRk52N2sH789BYnbIk3DBN
 elSLeH0fURkjJ8RJg+Lcp/4OiHjYM62ZJqQmiMFWwa26UfSswGmeUwVf0rwMDNf9dgzce5D5LY8
 vHFArY5ROe3LLrGdIDMmTiOo1uT5bqRTN7agzIOP1usrEx/NVmiqXVaTVwAOAR4CV/CBaDp2v4z
 fWFjzcfHHpTV5j9fQMvrQ278Mdjo3bv69MyaV4YY1KycFDN5dw3MAB3RIt45YsdV3pjo/KRHZuz
 43M2YOE+2x7Awiyxt2wfzmolJwzgrUUccKVQPgwNJeA7rL1KFAKaJoJfmIkcCrq4p8JDy6qw
X-Proofpoint-GUID: 5z9D91KFcdL747fq-ks0Kqbcemlz6r6H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Coverity reported:

CID 1611806: Concurrent data access violations (BAD_CHECK_OF_WAIT_COND)

A wait is performed without a loop. If there is a spurious wakeup, the
condition may not be satisfied.

Fix this by checking ->state for VFIO_PROXY_CLOSED in a loop.

Resolves: Coverity CID 1611806
Fixes: 0b3d881a ("vfio-user: implement message receive infrastructure")
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/proxy.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index c418954440..2275d3fe39 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -32,7 +32,6 @@ static void vfio_user_recycle(VFIOUserProxy *proxy, VFIOUserMsg *msg);
 
 static void vfio_user_recv(void *opaque);
 static void vfio_user_send(void *opaque);
-static void vfio_user_cb(void *opaque);
 
 static void vfio_user_request(void *opaque);
 
@@ -492,7 +491,7 @@ static void vfio_user_send(void *opaque)
     }
 }
 
-static void vfio_user_cb(void *opaque)
+static void vfio_user_close_cb(void *opaque)
 {
     VFIOUserProxy *proxy = opaque;
 
@@ -984,8 +983,11 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
      * handler to run after the proxy fd handlers were
      * deleted above.
      */
-    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_cb, proxy);
-    qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+    aio_bh_schedule_oneshot(proxy->ctx, vfio_user_close_cb, proxy);
+
+    while (proxy->state != VFIO_PROXY_CLOSED) {
+        qemu_cond_wait(&proxy->close_cv, &proxy->lock);
+    }
 
     /* we now hold the only ref to proxy */
     qemu_mutex_unlock(&proxy->lock);
-- 
2.43.0


