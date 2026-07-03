Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADC1C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZtP-0001Us-Eg; Fri, 03 Jul 2026 05:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZtN-0001UW-BL
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:09:01 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZtL-00088z-Mr
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:09:01 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635tUuT1991949; Fri, 3 Jul 2026 02:08:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=pAUe4bl1WSVZ5vjtL1dB6IpJhyqjIbaTxAkGv1a3P
 YU=; b=YR3wYWgGdwisjJenarPoA1skFvIme3BlmvaIODEkHvDxyOtd5X7Zv1kzd
 RIj0Uhm2mdrqCDcZqqCXRqTgR7lUhr+fftDDB6KfhDJJ6ihBWny70o9LrWPYcY/M
 2gZgtGZctS2uj56QUPcDUaDs8z1tV23kO+pw/RW7lXSwP82lPDsTpZoP8vP92oRz
 U1SkEuS0AVh7OdMO6Vb6ObduR+22fM7qWgWX6CXlJ216mZ51tGuVYX0CexGCryir
 ZPeqvavw7vwhyRY+Wdbu7Q5KzV9ql7vH2q/aA9iBQ6FK6tE52Xo7drwHDUg9u5B5
 5aHsbjyqPwwic6gj+j9hGN4QfWMQg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021088.outbound.protection.outlook.com
 [40.93.194.88])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4f5d5hc3gb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSqGCC1xJLHUg2FTg0SiDS3Aetl9YngjrvQbadN/3EzFtGiLJMMVmEMphgzOVbMVQH7on7zYqwiEWjYuWss7b+CZhuquehYgTDAUBtQ5ntMJ0Z5k0s6uCFL61VMnBR+73P1rFzzkbRVYqD4mh237v/4f9hVhBqQSFlVlVi6YiI3Dac22huMmsR2idLtu43c99t5W0NiLMEKdpnnNF1A4kmSOnoFmw+j6i9m2pMNbEKuPi9s2MNj5ZNZxGSsRA3ComNZl8X5RoQiRoprZSJrPI/kVIVLvVECDoLIie+cKGAJk/GYq8FLqxgR0nMJ+9DFZjC4OeJcNIgT1reiZwiJYAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAUe4bl1WSVZ5vjtL1dB6IpJhyqjIbaTxAkGv1a3PYU=;
 b=K6Ksiuypy69ysmx0Q3U2hqeayPo+8b/kdHg91syqQPqpKu6S5UkMTOw/Jo8ycZ9W0dgxgD8yP7srP3HTTf+ewZAVk/fuvT7W76nzsm+44UzFJjxtPpRkTzj6fClEQ5Yg/FUM5j/KbzJlLChD6wMNczhm4RhiO5/vic1ZamKuh/89A6S3w2wpBtcqPZ0W/Q1zyONni62O5eIuPjGDIBO/ZLt46ibDGx+5KvODVIwXxD0EwTVYWUUyCGyPSI5iUbjB2WJOjUNzKlioSozeY9hz2q7GJYfkdgh0Z9kIpUVRjpIvTxpRYoRsX/x/4HQWx0L5KFpPm080VQxJjRQhSThGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAUe4bl1WSVZ5vjtL1dB6IpJhyqjIbaTxAkGv1a3PYU=;
 b=YYVYz9xrl27+iHrpMjV71mj6udAypphBAksOsJv4OlbIg3dyKv7ZM9jMI0cZVph/w4Dq/DV5cigTcTth45xF6XdJv2piUSmmClXp8K/s1AmSnXAfovISMjz/cG6Yq6QXbfe9gfbfwWdjJtIGb5Z/A+0PNg8bJ96I9QPnyeo4bu5bc3GF695f0bS7JC3RJ9OYxtbm1D3X+F452hJVa8l+v8VzWMEdHGgYa4V2XbFscrxcvE2ArDTwcVvtrnAwTB9G6+3C6lYuspnuc55/IqVDKAKAhtg28h14F9/7Kgme/IxaPmy3D/2pYSZIIHb7y+P+2R2//plqH8zau9dIgmmPTw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB9420.namprd02.prod.outlook.com (2603:10b6:208:3f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 09:08:55 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 09:08:55 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 9/9] hw/i386/sgx-epc.c: convert SGX_EPC_SIZE_PROP object prop
 to class prop
Date: Fri,  3 Jul 2026 10:08:02 +0100
Message-ID: <20260703090814.2993188-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0248.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB9420:EE_
X-MS-Office365-Filtering-Correlation-Id: a4895552-7bc9-4c40-47ed-08ded8e2b578
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: fHCRYbF+yNETa85VFmO3G03Dzeaz7EFR2IrhrcVNHQnKCNmqvm31UBRIsJbP7aMo0aBh3i+qUXlpa464SJqLcZFAGVIVeJHgXrWFUNGFUddC9ZivbCfDehWr95QDJVEdKzPtfF+c/vKoN3igcu2gHjm2M5w3pVnuSii+gIdmZq3dFYv48zFQyM6qLFcc8SZgFCluN0+adn2HlbK0r4jGPIJ7ePxWy4+HITP9RvK9rZ3HOVrlQxvD0j/g1ktd7Knu8PZkPWF7fUhpofzKes6lyEaQr2sWs8vHD6ioyUnVvueigotomYb25ao6K69otDltKKNAv+aasnns5AUkbTq/ohoYWB6FRnmJvhC2755HDGFVjYs+m96PtTRxpKNaDNrc1WlJeczvZtvVTD/HWA+tDxV5G+5zpaEfBt6DD60savqBAxVsToABYt2fFr9c0ybonnvg/d1FjKAG0vCLGtA5F9gUOCpBKGiHi4au7IevHUM9ZZYZ+t0LJW5hvuYivbAetwlSuVjlHarSNdB77maJB7DkmhSq9Xcb9mpGfZl7XQQOCkwpBasvdi4haDyla4xs69Kqay4ucbnUBI4EDlFvEHilsF3lV/RpAe9zUckTHYLyPwdAxE0GtgZe/7BlpbqLch37gP2dNIyrr3iOhQAhqcSRwQ5g2OYnAC0gsMK8xds=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iIUDk345ZpCmse7Ib/gvG25AunIe97DZ6dl9uNAKiHSHChqVjN/b8T3+scW3?=
 =?us-ascii?Q?rUmvZI1rxUpnSqXWaf1NIE0j2azf1uVo24Uy/eu268F2vFNehE/B7yS4xzga?=
 =?us-ascii?Q?hn2Hk1XGAaK7vL+HIFVbsK8O7R20H0l9g9KuGHiiFkloHDZoqUpAF2RMp1oO?=
 =?us-ascii?Q?8Ec+nNX8McZQoTrc6T2Sh/0Vj0XpgUkbXomgh5sa3h4VhVl4oz4SIRjFpWXf?=
 =?us-ascii?Q?5w43x/NO+ll9dJvlVUGhlacbPEJrGiSShVIb8ucLmDnms8/H/HAIUivSvfEi?=
 =?us-ascii?Q?04QvBjtmGl1v+shzZKDcLnvXczxIk0bE+MDnA5AguOV92gvJditj+XG80oM9?=
 =?us-ascii?Q?WC83Xx7CXUlAquWTKLNZd9zMLZKh24S8jx5qtxlymPU87VZz2FRP44CB/6Sy?=
 =?us-ascii?Q?SD1LpEe8lxXsDX5gchxlBUOFiQUc6nHy11XFDicomV+PRdGidKs6ZRttGMQ5?=
 =?us-ascii?Q?kL9RZW7XMeSp8dd3qDRDES47u8xE4FbMFaLI8TKcJ+NlOoI4kIem9uB6BApU?=
 =?us-ascii?Q?X2LOyX46dmseqZXSdIvjWHT0EY0OmeLN+k3Q924sL39GWqe1M7nyOe3gDVdO?=
 =?us-ascii?Q?84uwH2/xx7ObVfPdjXHLNnvmEPDgFnCiU4kAfzCmY1hdw8di3yUy6+9P47RJ?=
 =?us-ascii?Q?Ya3aNHJ2t9zohefV66YMlq9ouLgBkBZXNsnraRUpbgn2Q3k+KbqpmpewdZi0?=
 =?us-ascii?Q?dKCR9QQr835oxHwDZ1Eam/Wg0CIsdL7rH19+MaEF+5lMYIJFoXvnBONQlGSz?=
 =?us-ascii?Q?O7GoMT8LkyZlqj3IbQG73wxmnUcISvZ0Lc63m6DIJN/kQq40CgUq7FWmK+Ow?=
 =?us-ascii?Q?JR1Mz57oz1Ue0KdBAjkVl61S3i0Gp8zC61x8/rQMrRAwi8vRZaQqnadzLzbU?=
 =?us-ascii?Q?FBpxEYvJROQ3kd0vSUvKtJxJfwXUB4pcRnreUTe7uYkC7Hz1i5loDi41orbQ?=
 =?us-ascii?Q?ARQ16uj8a0EHVWPQ0NDEh2fOejYk4JmnJcxJrh1c/VonHy1FaYKMcms6xRiB?=
 =?us-ascii?Q?06SxFBED17aOo+zSybWWaVlQETkDbMcJqi6rKVJw15k+MnpqXmRUKtb/zBkH?=
 =?us-ascii?Q?1kcuqGMlcOdgX58g55MpVsdU/47ox+DjJy+yWE6w1geQwI4eawHItUTc0pAc?=
 =?us-ascii?Q?Sc9YxtATAdi4dxPoKf+ZCXzaqQ9tPSXRDZHjADgSA1JtjOD81Fd/J4S/+MDy?=
 =?us-ascii?Q?pQBAAIf1wNmP2HP5cHhHfUGt1GmoUcAfyhp9YQxf3nZ9gLjV9NxMMmhLF5rn?=
 =?us-ascii?Q?j0ZbI1hGoOwRajjPwPA/T6SP1z3L3ujzWuNqAsaS9Z632d2SZH0s0QC0MBCv?=
 =?us-ascii?Q?p10oUnXhqAGNEuLS4fcQ8gGPnv1+IyWyfGfuJQFuqW1Vemq9xWmVzLgNYM+m?=
 =?us-ascii?Q?SqlHdRWHF7medF5WZy/tUyHLvpNpk+HVhRzBeoXmIH2ykaXekhVsTEALy4ZO?=
 =?us-ascii?Q?qES1plXyozREGyUdSOjPBVDcV6girlZ5mycdWjd6m+YsGI/XFm+NzCtz9Pz/?=
 =?us-ascii?Q?rFe42QEZm5HKiKlP41umpz9ur5PYY0sp/nM+68OTXDDucvR7vQVB71MxLXyw?=
 =?us-ascii?Q?y1uuY87XM1VwXTjb/lU/KqXIvAPYJ4B1W1qNKB5peaaQsFEOy9f4N5J6XUMy?=
 =?us-ascii?Q?OLI/6L3/ujrZ7dGuj+tmP12lX+vHn5FOxyfhRpDd33DSff51NN5jysNeX93x?=
 =?us-ascii?Q?3VtILY4CYHMYFAD6t2FHY02V3dTWhpXa/brzQhu+uGkAXCSs3OdTvoV7RAe7?=
 =?us-ascii?Q?4B+0u/hcoaa3sA6hsBsCbc7gS+Ws1x4=3D?=
X-Exchange-RoutingPolicyChecked: cEiIRDr1w7xXQGlQ/b5rcWg7SVpssSDlYkce1fc1PA/CTSxjVqLs6/D91q7Q2ltwEYsa2EreWl5G4PYTAdWnEXAySSOb57SLqq8LrBO7o5xmjwG2m7xkH/tRzZqDMYYeO0Rt9GZYwF/B0c20eBpfBkwZ1MfnZeRoCdmZ5M0FXnkw2V8feo5XrKvBA7FkNIaARqpb92BTBO/mWbORSO/RtPVZguu/3iGTY257IvZ+TLptX/5zQex5bep2nQaSppJvwAkGPEPe9vdvpQRN6WeGLm6q8Midd6nhjiwk4SUsP/j1H3DSQMWNY5qSk5Q2tJfBIDudYInPbMBxvRu5ju8MjA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4895552-7bc9-4c40-47ed-08ded8e2b578
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:08:55.6451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8caRB2LxwkLhJuwDZrNMyZTyPt3e0bzjc4TzVkxWfao6dqvIY4gRB8FbQGTeKLRBtKRvKg08QGHso2pvEri6pjDh3C44abgf+T88GOzU6nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9420
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfX5O57fWxWKPOg
 6MjvO9ryqxo6F3GaQTq1R9aIbOkGsKzbnwpHSF+ScFgl2QK4dWOgrKn6qVcUMc7wK7q7bQ6BX+8
 x1fYgCE9IAMucqFtL3opzZr93eAuYO3xaTAeLlNc53gZ5lqxEUCUkynfV/7OXcIaA0J6CFhT4HP
 MUDxeF8FQMeeq941b+1nVt3/9ThtYjs1GIgyHYucwjJybAld6SvsZwkI+RXhRbaoNnIh716/7Mt
 HCQzV8h1N6tRkoQz/Q/kkVGpIuVTcJVAi7WO/0vTGhx3x5ON563W8wwpn3CIOoJxDzWmi4ibPnA
 rng+jXz4S5cMhdl43P58HLOFeXtrebO8Y5pMWfrdFkXRai1MlSF08tR955pzD9FHpXwrOtj9PBX
 I5ub4VsTzH3id/pCaRiJzexKVeda2JkhbuRX/FP7OH9pquwQrXyJZR57Hekiad1AlpcHbKCA9yO
 eILTUekRPv8AKajQOzw==
X-Proofpoint-ORIG-GUID: ogJ6ZJ_oc5hQJoz4ZfV26lFzmbQI_Urn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfX9lGZOT/t5T26
 zNiS5KvIiYMKPMA9BVi4skuwi3DCRUn7RfV6ssUiDbWG996YZ2GhGF4Gcpk80eFm4P5yL3vU8wI
 fSUTXvmBWQXuNGouNIf+Wf2Q476h55k=
X-Authority-Analysis: v=2.4 cv=EMM2FVZC c=1 sm=1 tr=0 ts=6a477c29 cx=c_pps
 a=msPUCbsZKHGyBhhyaqynTw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=tlSEsSRgIMY7PNDPInsA:9
X-Proofpoint-GUID: ogJ6ZJ_oc5hQJoz4ZfV26lFzmbQI_Urn
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/sgx-epc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/i386/sgx-epc.c b/hw/i386/sgx-epc.c
index d3fe10028c..29cda843c9 100644
--- a/hw/i386/sgx-epc.c
+++ b/hw/i386/sgx-epc.c
@@ -41,12 +41,6 @@ static void sgx_epc_get_size(Object *obj, Visitor *v, const char *name,
     visit_type_uint64(v, name, &value, errp);
 }
 
-static void sgx_epc_init(Object *obj)
-{
-    object_property_add(obj, SGX_EPC_SIZE_PROP, "uint64", sgx_epc_get_size,
-                        NULL, NULL, NULL);
-}
-
 static void sgx_epc_realize(DeviceState *dev, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
@@ -164,13 +158,17 @@ static void sgx_epc_class_init(ObjectClass *oc, const void *data)
     mdc->get_plugged_size = sgx_epc_md_get_plugged_size;
     mdc->get_memory_region = sgx_epc_md_get_memory_region;
     mdc->fill_device_info = sgx_epc_md_fill_device_info;
+
+    object_class_property_add(oc, SGX_EPC_SIZE_PROP, "uint64",
+                              sgx_epc_get_size,
+                              NULL,
+                              NULL, NULL);
 }
 
 static const TypeInfo sgx_epc_info = {
     .name          = TYPE_SGX_EPC,
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(SGXEPCDevice),
-    .instance_init = sgx_epc_init,
     .class_init    = sgx_epc_class_init,
     .class_size    = sizeof(DeviceClass),
     .interfaces = (const InterfaceInfo[]) {
-- 
2.43.0


