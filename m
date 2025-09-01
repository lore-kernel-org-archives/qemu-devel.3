Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E34ACA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4Ym-0002Dm-I3; Mon, 01 Sep 2025 09:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ut4Yh-0002BB-2w
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:26:56 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ut4Ye-0001Pu-Bf
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:26:54 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58190Ae02875710; Mon, 1 Sep 2025 06:26:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=Hn5Y3kFVH9hJY
 YLQIk4L3vu5RcfjQx4P/CzFPjyWW5s=; b=JgX0IhLchY/6mnIs2M7DdCJOHD9Uz
 0FxMmnfCNuMtmv//pgjVbBev4t8d9xJLv1M50lwloVChxNCj1UBf3QUYnPb4CPC9
 YitvVhfTMsRPUf7/qBaN9LGgp5KJb1R0DKN9rR7+zDzHpXQNTkKg8raCbn54DQG4
 8ceDETKREoFTdrNiXLpaGiztN3gvm6O4MsH0SSSblODScdemITzvZjKLKvnZBKOT
 pEv1tb6UjOq4huTa7r3aQlf4cn22+kaXfIQ8P1Cy4e87biD3Xggd4CL8+UfnqEKl
 B1+L7QKXf/7OhGXMpZWbZzjDT9DpqWxAWcpsxe9OSEZxMYHR/2RHikQrQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2132.outbound.protection.outlook.com [40.107.93.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48v0cfb9ca-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 01 Sep 2025 06:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jjf6i+YiIc0oEGvpnu4vegCTuFOc6ilIwDIBpBVzX8tqIy/U7jIYJcS+RlmZ5fUbJxz7Rm4q7+ct9LvOQ2NyDGlJBoF7dliF776IhWzJlsRBK0vTtrLSVDl4D28a0TFR41COzVqSLjiUxBtjTbOwIGxx4MclOk0djrqli6vEVvvknL7jPh6GftTrWTqWtdpbUKNGzDP0Uq/mYSLlctyOzdPCh2dsWvokVOlRvPQ2m5Z5DQqNcjpFPPTrHpY8GWHNVMt60UmNYpfPMO/sEAh7ms2cIEOnlBE97bET75pdxXnsMr9+J5HO7zYuNelGaIdwf6N4JILvlCW8tRJ/3xn+1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn5Y3kFVH9hJYYLQIk4L3vu5RcfjQx4P/CzFPjyWW5s=;
 b=hhyTnOr8TDmPpuZwu47jbmke5oRivcPuALhhGq0cNXlAYacHTzRfsAU59/A3VJKR4A8AXHa10QUNOyF/ya9vW1fjDNidYbD4wI5LbsLHsXsteMHo26+0COMd7uW/OZ+JeS4+KFoTxbRMuksNZbHCTt9ui0F6HZFjCJZTtPaNb8VW0A4JFFlguc2f5zxBAwBVfkprFqO3vFtlfeVIU3LPbfsiZXpVwxct569n2Fdc8WJLtm4H1FhRwFfcN1pdTUch4UM8V531emJ/QfAmA29kdGX+4tlArBnanSU/Zy3Vwxi5q2iZ+VdBH4nUqq66bdJgymQIlqaEMwLUOZMHrqs7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn5Y3kFVH9hJYYLQIk4L3vu5RcfjQx4P/CzFPjyWW5s=;
 b=N5qG4f+JoJNs1u6csv8n5FOLl/UlxBrf/GCe+7Hfr3lCp/DP830IfMkmQwqmLlPyisyWEticbmTBDmfxKlpLUGOlyGUGaihzt6x6kbCmkA2yUyEypTk1kAK6N4NqXxwbcJ7CpYEWgTNzNyv8TOwmdb9cvqIkMzi/lkcWy1x8A6bxTI1iIDAHSsqN1t4v+9l/6JCdQP4eKtgzxDW8SYpMILEfdGSsQN8zJ7/dbjuL3MP3ve8hC81j1XsodRuS+MoH6/jAKU6SrKbVbuv82v6R3P5XwO01ypeFwwlCdCA/AjLTUMo5h+dSG+3R0yOSQJuSODrCfKFo/MAd6d+MeiYIug==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by LV8PR02MB10166.namprd02.prod.outlook.com (2603:10b6:408:186::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 13:26:42 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%4]) with mapi id 15.20.9052.025; Mon, 1 Sep 2025
 13:26:42 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/i386/pc_piix.c: remove unnecessary if() from pc_init1()
Date: Mon,  1 Sep 2025 14:24:30 +0100
Message-ID: <20250901132639.1123726-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0091.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::32) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|LV8PR02MB10166:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3e34de-54db-4ed1-149a-08dde95b305f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y/YgA8LHWeHiI2JzSGNIojrRqqP4VjRC03Q9nbW4cN4r4tJ8NkYE03R3ZQ5W?=
 =?us-ascii?Q?gXkFU+NiKdnwoOmAhLvJ6+kt8dfwt90WQaOyhhZ8f09rBIoXlRuKT6a3gLyX?=
 =?us-ascii?Q?vqRr4YsGNH8UFQ2pJeObXHfln25QT1dPCmOMgNJZXlZPsJyW6peRU9o7Fitc?=
 =?us-ascii?Q?3pbI8tQ60WNcSN08IH5YptZ9VvNfJvqO9jYZS65jxapMASxmKwqNMtgmTvzr?=
 =?us-ascii?Q?1SKr8hdHUSRwBlUWaD09xKUd+pnmzFqcFfk3uqkX0HjaEtIZK1pX4SiAaiZ1?=
 =?us-ascii?Q?h1UGV3l016O//yotEzMEIcXAHrJwYw0sQ8W+K4CRPXLo0oZ5jFneWtSswd12?=
 =?us-ascii?Q?+LWOWo+QdjVhVpoJ/Ber5q61a5HzlN/yb1CtNSXVeDq19n1xTiv21knERKeW?=
 =?us-ascii?Q?nJ95kQFtZpcwgvjDAcGuHlXivYt0McGeUnwuGY9w9Thkm9mrOjEsNWssP3s4?=
 =?us-ascii?Q?/4N6hafOo7X84Xn16q5Gc0e0Tha6HF/MCaQkHulHdM21hnfCdWnLid7YLwDQ?=
 =?us-ascii?Q?CBs9YLCNGebBc65LN9jp7QtkcDclp502Ke7XXaTbTa7ZCIJs8LnkfsVxLyuV?=
 =?us-ascii?Q?cgwKWsN9quCeBPK1pqqmLlFFuccrbtabrSy3OR6h0aM+jHwn6fk9aLdBHqHx?=
 =?us-ascii?Q?pejl/ST360YSgWeG0EabogVwc9+vB62XJ1/raB72+pZWt6zhHajKl9dh2exR?=
 =?us-ascii?Q?h3nsLZRFQEJvXvT/y1vpIEkGe+LqBcTvUYPzPmt6CW1nGv5zZi95qQeF7iWv?=
 =?us-ascii?Q?1fGeG3TNsxSyiivFITSCSPTNhZR8auIwH+aho1hKOVLIxadVXHwl0oo1OAoe?=
 =?us-ascii?Q?QG7S74H8M+ac5Uo/QMeKx0bx4CUWL5FwBXWOIZImvkFF1o0BFee5Kt6Cmtr8?=
 =?us-ascii?Q?1MxAmGHZz84vy2iqUtFIbssSm6XwPL9iY4flszrqOkxsEKlo8T9D1Z5pKnuB?=
 =?us-ascii?Q?CbaCA/cAWwgaFyzewl5iE+guJRviOryX47XydKwCTGcUdJIgPAAK+fCNi0ia?=
 =?us-ascii?Q?yD58cnGR/svaLbCS+IH7+Z7NFWhrsFEGfZYRzYw3aK8VKsxSKpeNF0FOCZ6j?=
 =?us-ascii?Q?zegIN+okdHMglvfgLTldMYwVeBwQkcooTIjO/BsJvOXA4mauQD2vL9D4AXFn?=
 =?us-ascii?Q?Bz4dRIY121B54yBQdjyV3t48o+WIoKhvlJg6AIKlgUqSZH0SwZKFLJJFaKsu?=
 =?us-ascii?Q?dwmwIuqaIwmdHNdg4nCUB6Gu+jYO5FItsUUM6iOuDGYlr6CCVacLXv8d1dQn?=
 =?us-ascii?Q?iLQ0DcPwiPXKWzkWdk2MQuXzX0dVHD8NXTWqkNVnGWegTo/Ine4LNjn9YYzc?=
 =?us-ascii?Q?VvxW7Bzl5zHpdB9DqAD04IqZjs7MB1MfzhwHatBzn7mNU/hbHaXT58Tf1uiy?=
 =?us-ascii?Q?455sQpEtNtxsZLfK/urTuKC97f6hyhS9vnuBxOsqFEhGv8YModglGBTSdpJU?=
 =?us-ascii?Q?jeG21UrJkxI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y+Tyro8crHOkAQM4rXwTVN1rsUmEx7dxukNx5qUCq6mlA+70jGjN9E9zG8P2?=
 =?us-ascii?Q?VHjOphA/egSk4+yLybaIvXFHiKZOvtXGGDnHxD32xLFIbhtRtTbxfConnt5e?=
 =?us-ascii?Q?fqM17yOeAsb8wkzP1NbhkVVl9UJ8zEyeCxaKeZ/vuBwLPyhncc1qMVIFU8L/?=
 =?us-ascii?Q?wF+EMGlIm/Pij/rLaKb8AWn8bWUbNX82FnOyWj+RmaOcKZajfikrwXaK6lIR?=
 =?us-ascii?Q?eJfpLma1Wi1qpJ5t/6rp5KQhdnAYOjeufrqMAi+FD2+OnxKuyXpclqrMPaAC?=
 =?us-ascii?Q?5kSglkmkepeZjVFWAGn/PG/Cd+wYNAThjVDPFysZITvY3BaCV9QhkKNDXfAT?=
 =?us-ascii?Q?/eFC2nQIsgpEjRTLekYlXFmHfrS96/3m+ZuQxWbhtdX9rgQv+sBYDqRVC/M/?=
 =?us-ascii?Q?wEVhqCxH1LGLpOGC8fne1k9wv6gspWdLzxxpTVRkmsZcallVOqkkyKgMOD6z?=
 =?us-ascii?Q?RKaJahUdPp8zb86pcRzpKrbzSSNj5g/NgcLgBf5preBj/lhQJ1EY5cNE31ge?=
 =?us-ascii?Q?mf5iwtcr16T0Ff6PQa8NXk/Ca1gonDDmGJfZuDCQz62i7dMtF7SY4An1JIeH?=
 =?us-ascii?Q?T27vJFJ9b0cRDZIkimb/o2qOQfwYNI2b3ZfU1nfvLehEJf6stA9dFy1JQapt?=
 =?us-ascii?Q?I64j58C0GacuMAHtPG9870QA24FN6VpO12qqgZS0cdr6aD51AXmQwLK+pvRZ?=
 =?us-ascii?Q?azrEzHyJQlFkjO4TmyHwf1Ve0JecJi60efI04T9Ba8X9w0D8xuZnrD6bJgcO?=
 =?us-ascii?Q?IuTcuETQOsY5tLjkDeQNggZek52kwNZQIXBqulqEOY216H+JuTReoFpdeh1m?=
 =?us-ascii?Q?9clM05o5MpvzHXGynPE+GvClvXE4v3bBK8YRFzH+BfAIPfPuUJsPRUJwjuUM?=
 =?us-ascii?Q?8SUYbTFO7JlOBzBpAbxVibkwpa9WtOxAxVvhU7OJIxtEjzkoNLhNwjsWh/Ok?=
 =?us-ascii?Q?5RIkK6bUGcJzruLoQQxXxi9SqJ78IFoub0fqsOK/LBf8PoK8fFzHlB2pqwZE?=
 =?us-ascii?Q?0+HXV2rUrg9CviuIu0IIAWrouQur2C2HwFIkK6R3DBullIyC+PdcEBiDx0vs?=
 =?us-ascii?Q?ZY2FMGiigWhSMnSZzLrw0Jg7AMLJfXSJwFJGuUE9r6mtxMyG8aphLrge5fZ7?=
 =?us-ascii?Q?MmqiQS7LzM3js82gFRHvCDXKa+skg9v+jDJhtED3xa1APA/AuVfIfMfyQxWY?=
 =?us-ascii?Q?AwnpJHz2ty/CesIRpg1l1rEdCoXYhkqkC4dg9mIBfeA+L7PWXi9M3ixqGisL?=
 =?us-ascii?Q?vRhGABTop0ZZZptsKy+cA044J2uOOHlbLFpw3xzXxIUMLySLokwMjxZPQJdO?=
 =?us-ascii?Q?FMrFt21UV68YMUVXZgxw0+BawUmMQ1sGiwPtAxnsLLzhlUQkfmkLbfb/jdAI?=
 =?us-ascii?Q?kNJtHzn+9hDqB0nRaHO7ZLWQwC4oUXUMe4UH86Dr+p51udnC+pDayhQad0P3?=
 =?us-ascii?Q?/lJLkH2g6Rn/tuja8Iysw9uS0AZ5d/icipq5/GQ8afaJHYIS7Ce7GVsipMf5?=
 =?us-ascii?Q?3eKONNmrDah1x8zYCqIs/z6HEo2L4xuLsXClCRRS6gCEIn2ciy/yofdX4vbj?=
 =?us-ascii?Q?rlyiXg5ntx5jMjPbaOKoEfZMqLiVzqbO63DsLuDMlYIl9Msps/12QPRuW7Ff?=
 =?us-ascii?Q?pN0t6PObIvNdXUONNRQnFuqlqoJ6ertqZ31F+ZKmsYL+QCzp68pD4f7zF5Lu?=
 =?us-ascii?Q?v+MLIg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3e34de-54db-4ed1-149a-08dde95b305f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 13:26:42.0075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1+dw8g3Xx5ghw8sDOBmxBTYd9HgfiDDfc5pI0jL/3KiEjZ1T/0fBTSVkk+s0n0p+S4f8K2W1zelGGQNUFxUfZa3AITT7/hucg5CtnvwprE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10166
X-Authority-Analysis: v=2.4 cv=F65XdrhN c=1 sm=1 tr=0 ts=68b59f14 cx=c_pps
 a=Wk9KOrSN04gAdpz1i5mfWw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=E3cgCfyIcZe9lhj4c_IA:9
X-Proofpoint-ORIG-GUID: IMZN42Yy3-OrKgcKdgK8pI5g38r6R82M
X-Proofpoint-GUID: IMZN42Yy3-OrKgcKdgK8pI5g38r6R82M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDE0MiBTYWx0ZWRfXwrt83Mmi1fzk
 OrTEtRXewKAr4/XoY5Nn91lprOy1ouPMbu8s7MJbmz+V4hZEWdFnjb3mSb2Qv/LQz6dGcup7edD
 piCQ4onS0F4o5/vFeY0PJSHe2ERPcGGXP5mAw1XSnjR0wZLc1VnKmjh9JnNXW7Y++ZNdsUkD+4H
 uyqXPSN59spX4gPJ4MYkqACc2FjeW+utHtyTEGF14gqFLx+pyi0Q88QH5sT9qykqrkPT3quv2/B
 4CSlVpaCOuyPvdWRkHSwvDarO2Az3AvAVVKtC71nk9LJRShOrj8DYNKB+QZ+oUl/LoCgx6Ti3QJ
 wMRjZX79+CQp9dPVUpCJoiix6TobRk4LqehTOrzXA9DwEC0uj6pQRZZF5xACHo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Now that the isapc logic has been split out of pc_piix.c, the PCI Host Bridge
(phb) object is now always set in pc_init1().

Since phb is now guaranteed not to be NULL, Coverity reports that the if()
statement surrounding ioapic_init_gsi() is now unnecessary and can be removed
(CID 1620557).

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Fixes: 99d0630a45 ("hw/i386/pc_piix.c: assume pcmc->pci_enabled is always true in pc_init1()")
---
 hw/i386/pc_piix.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7e78b6daa6..b6d0cf411d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -284,9 +284,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (phb) {
-        ioapic_init_gsi(gsi_state, phb);
-    }
+    ioapic_init_gsi(gsi_state, phb);
 
     if (tcg_enabled()) {
         x86_register_ferr_irq(x86ms->gsi[13]);
-- 
2.43.0


