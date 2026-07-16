Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E510CC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 21:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkToN-0001p3-F1; Thu, 16 Jul 2026 17:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wkToJ-0001iw-8j; Thu, 16 Jul 2026 17:40:03 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wkToD-0005sL-RZ; Thu, 16 Jul 2026 17:40:02 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJrZhl1763910; Thu, 16 Jul 2026 14:39:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=So3apT2orzziGkXImwzwY/f5x9JgyHASh53z4qGaX
 Vs=; b=lDSen1JyO55+NhzxYnfYQ055rjmbdRPIqTOFVvMo3WvMplao8FQBgyhF8
 y1lernMoID6IVz2GBz2wPsiHp/3KVjKaUJj3+xKJqiOS1bS+S9wfTHb3h7lXA1V2
 Ujmw87eZSYEMhwqD1vzc5LBn8ooOPI4koYrVt+WdCOGFCobJx7IXsm8Ia5h/k0iI
 +jX0jgU3hNwMrAnsqr++E0uC8vj/nhvISOKo/Oq2l8p/TvtGHKgDynAOVgg8FxN5
 +ilfP8b3qok8YPajE1ZV2uJ875/ycrsKP8fR8XOl0j00nXHt5RrQtRGn/vhPiDND
 ollebG+oKiMHcpySpiW9JUs+Ubk+w==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020094.outbound.protection.outlook.com [52.101.46.94])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fdstheva0-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 14:39:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM9h0PlulUAc2ZQ9ej8HFNAuNvFZTmHVXQmNBThQh8uwxsBJiTYuxDcoJo6SJeRh+ojqrCUw0kyi8v37xw0SpNnhLNs79GCUmCh6Kw0nfKe8I4BrAVGtSXKAb86yz4UD8zoXQ6MW/9MLbWhiAfLbwFZxIcDJLYUwhmlsK8TQAt0X20xaN2ppxuZUInKcZHhtsDIjdxhLv4kW6KQP/cQvfHfS1jOw/gYkkUEX/nW8r8V6GYTHg2qU/YlE+EkhjKVuWUfux5oeMsRs6KkJ2Ow49ZDgaaVv8HZVfhSKkPpuHo2JrpOLerJmIrsOksW5uncoZBlBLaY6IbcUHslpL3DGcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=So3apT2orzziGkXImwzwY/f5x9JgyHASh53z4qGaXVs=;
 b=RlCTNI4lx73YRvCn1KWFw3x2+05TKdbHX2ZhgBRuoa8ilLq/V196u5ISFSiwhj15djig8YP9xo5bcRXLEqfJahM9bgxU2OJoVjEjsRfUYzq64VoSjx4Ux5spVjN/bKE495ss8GIFZ32himFiAcMxMYwlYrUX1hVjKPVeYHAQG3FMS6bgROIXoYVOPhWUbJ2SnD3OPW3jTOzPDCxm9gLYTRd0DTY+uc338olMtd+c0v+BQ2k4QOd+qNv5hUPBXnXv7TN9Dot97jRzS3IUg45J3S/faxO0CFyfYlxgpbhUIEXY28vF0zSz4nD4xzloFvy9uHvQB5W/tqJwu/QflmhDNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=So3apT2orzziGkXImwzwY/f5x9JgyHASh53z4qGaXVs=;
 b=lIMobeikcbbSaoDifAYJiTeaPEhRdLNhrfCaWgWmt6DKocLcfUWzwHwKUj800rMFqM8sU4RSPlE4OpLar1TCz2SacvS7GFC2ovixgeeI7TJbkZSh54aL3lZSb63pssmZDXdww0vYxndouza6Z4U50f/wWkQM0uXAvVBgH07JmcyKN6C+7w3S9/kQVIfok46OuGASEFCg8mzn/zywJxf4hn84pLW7gXbPV+vQNHS3xvqFA+mR98scOPZGuPPIxW+Q+d6aA16zAgz7IeETxJkcx9J7nFkIrg3bR0KxRDvJve2AT1Uh/cEqpSWSF30PYqBs1tKihqfy5KxGnlCn3QwEBA==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by SA2PR02MB7756.namprd02.prod.outlook.com (2603:10b6:806:14f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 21:39:28 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 21:39:28 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 eric.auger@redhat.com
Cc: cohuck@redhat.com, peter.maydell@linaro.org, richard.henderson@linaro.org, 
 maz@kernel.org, oliver.upton@linux.dev, berrange@redhat.com,
 abologna@redhat.com, jdenemar@redhat.com, gshan@redhat.com,
 skolothumtho@nvidia.com, sebott@redhat.com, armbru@redhat.com,
 philmd@linaro.org, yangjinqian1@huawei.com, shaju.abraham@nutanix.com,
 mark.caveayland@nutanix.com, khushit.shah@nutanix.com,
 prerna.saxena@nutanix.com
Subject: [RFC PATCH v3 02/19] scripts: bug fixes in
 update-aarch64-cpu-sysreg-properties
Date: Thu, 16 Jul 2026 21:38:41 +0000
Message-ID: <20260716213858.609699-3-khushit.shah@nutanix.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260716213858.609699-1-khushit.shah@nutanix.com>
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0071.namprd17.prod.outlook.com
 (2603:10b6:510:325::28) To SA2PR02MB7564.namprd02.prod.outlook.com
 (2603:10b6:806:146::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR02MB7564:EE_|SA2PR02MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: e27d23c6-b2ec-4f8d-0cf8-08dee382b6a3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|6133799003|22082099003|18002099003|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: z0ArUNNS7nnIQG1sI57RjyXWhkloO+eFQ3pj76uNAQBn4cQmXG3AApSPap8hJGEAPviSP5J9XILyFVGHM+6UMwQR1cfNCXjMLco/tgl7A9iSpvwSJG/FfX+NgFkNzZKdR35sXO3nYucosOoCUcLE6ZlUE4rkijc7WLO+y1RhF3R2fNas2Gf354WbFK5nrAFYQmUdpb6099sx27mXvQPx+JKHdv1ImP2Im+VSnEXtrF5QTKeJGMuxT9hWDve+w8aQWL567Vz9dE4Ee/rXuUD47cI+eODR1a5W7CJSHrvRCDZNQiu9cE686VYWn8rjh+cg3my1WSxuips1ecVTmxeRYeqHd/phoKcru+FMJvQRuVhxdLdXk3R4GkaUCWr9Lvca2SpSCo7fxqC5//qNLsHN4d9yctogSI8vyD92TrZDHoK+B6NQPX3kU1bZM2sIQSfXrVI0MNrWVKpNxO417Gd65aEw151lM7YbAjlTvquTgU68mniAxgAczT3ck1+1EzdeHSBw34bjGoUBm6tMvToIXqvZGz5UCN4Le/YQJqxA127F8YPGcj+QNNXNXAp9EMHu9/e/oZ19dlDA+gmSDghCz6HRGdvQdANTjJ536UKJPugWuMdB9TZjVYS/3erZiasHrocScCBRUkqB4g4x/oSO8rcL5Ui6ONyDIV4KCPjFbN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR02MB7564.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WxQ8sZ1vp+iYmhF2XPo03Fsf5cpEYzvee3ZY5hPRVtaus3gyhBkE9D8qOqes?=
 =?us-ascii?Q?lLt7mnplt8d2aX9AbGD1S4UyBMovspGtNTJ7vj4pgNboKd8o5cd5LXZM+dkc?=
 =?us-ascii?Q?8Ra1PJHNeQKMNWk1MYTKVMePxuCdZi7CLn+NHwtr/wdCBjlGpEIXuNa/YHoz?=
 =?us-ascii?Q?LbqK1LiuFbQd2Jy/hMP1DJLLIY/AQFDed5ruVEKMrixkGCIhEPBbRDfjMw3q?=
 =?us-ascii?Q?A/vS87vRwm1W8gQ4JBfwv/DFJHWOUx0828b70GBVf1fbygrKQx5i0p+O1Z0b?=
 =?us-ascii?Q?nX56XI3CYpG4JL+vfIUqi0owjZm5vVpfk/LNJ8J+Jl+U4xD4ebC6xJbDsJC2?=
 =?us-ascii?Q?m2lORr/L2r/hoFIl0HLZn1PJM+/ah0LRzG+Vn9vQR9e6aO427jouSKl9iehT?=
 =?us-ascii?Q?so3uYfO03szRUflJjHa5GTzI0LZoSvC7jgHFcDutqBGVsFs5/IaZkSQ8e7Xo?=
 =?us-ascii?Q?RfMZg6QLbn4fdnfGJhbG4BQnS0tH57vELgdTUrMO3YCL1mCFcYFwmv1bEcOe?=
 =?us-ascii?Q?J0DMYhKbBaEcL+57D4uLV0KbeUp25mDU0OoTxmT/QQmdS3Guv3DtfB4gtpG4?=
 =?us-ascii?Q?UFiNBmQp7L0HYMjYVV4bAwU4MwYebLgq1ne3ac264+kD5Wxn/sOaVbblZUkg?=
 =?us-ascii?Q?94U5bMWe5c0X1eF9adi6c7V/hJ3HzbUJ84JlB33Q7POpJGbdedEzZ9juWoAM?=
 =?us-ascii?Q?/+rVpHJ2DMU11WQLuStvlC7aftatuLesaPtkmYfZm7quFLppk4xvPc2EGbfY?=
 =?us-ascii?Q?O3F6B7jpQJEyjjS47PTwWWZgIn44VdADfiTOd6lHDdd3u5/zRsc1e7UnRkX0?=
 =?us-ascii?Q?dKXY+bLQCoYvA1BMwKGtUJhOLorXgIx7k8E9tIKnE8ZgKjyhNZ5LUmrn7WG7?=
 =?us-ascii?Q?5eV4RQ5D4VpI8HXfBBdcNV3BUZWTXC6R6dCgAq3z6Ht/o9K0TeKebwtqROfv?=
 =?us-ascii?Q?ce0pgflmutcnxUZGcXCeLaMHHBKQcse/05xExS7COKejceufqzGz3Ua3i15L?=
 =?us-ascii?Q?VPWkZnYJTMsk/O5Kx+E12KXemDroljM9ifGq9bZ253pIHpHm+boQ2GnQv9KK?=
 =?us-ascii?Q?rnywSh35a6bv/RXQXKKAzvLfRYHIctMTxx8AmV5AkrOURPcFTx+D/v62zCwo?=
 =?us-ascii?Q?KNqLjiN49gtlYYJBUyq7QH0AtphBoBUOMp2LgOHP8QrrPC2Trb7vC1i4khcI?=
 =?us-ascii?Q?FalLCJAjFSNuuz9hrQTsWIPUS4AfASxWEziddrM3XyHnMiQ7pz8fG4C2IYmP?=
 =?us-ascii?Q?lXDyRf/h5aZACzMB7R+eXzs0XAl6Sq3tWcVt7QQGiPhZ76UbIQDqkfX+8ouy?=
 =?us-ascii?Q?QziMJ4530Dyt7WDXsNezr4VDCUFGZbGNUafHA1JmC6mDNqfi9H7KI5xaytw0?=
 =?us-ascii?Q?iEYlXbVgs8BG6SKIjmswZ7/VoPNmTNk/ImbQ8nvZQJemBUmqAMpAx25KcnS4?=
 =?us-ascii?Q?D8qtrUeeemdAp6oF5AMXDtArxg6DVAxuJX46UcnLF0nCLtLCxKX07ktWq7Ns?=
 =?us-ascii?Q?vrglp/pPUDM0Bl8WPTDYAk218pzpuUnfuUNB20EGjUvHqEk63TdlLqqiwNf5?=
 =?us-ascii?Q?ddjXudbNAuBV5ZLhsZx4PpoTEnISOLQZLipxxpq9nCJgMQaZRaoS2fsZjWSx?=
 =?us-ascii?Q?4nUhHGSJdEH/+IZuoSFJjMQpCUzaMZmE8S0CNEpb/WVAL+NzUFG2aZffxtOh?=
 =?us-ascii?Q?l5eujBvAmWWMNb2CV6ZFvKqReyo15BCIsLzaSP31CBazuhfxlZ4WrZYRt++Y?=
 =?us-ascii?Q?KamhcU5LLnapYTlLtkXAX6D0CikKGxE=3D?=
X-Exchange-RoutingPolicyChecked: kLV975OzXNp/MM18EZBciQFRY5tQnv4x78X2k/5vjlTSGYKck6fniowPJSCyEfOnt0Z3Ycqi3k8fiCqEswMI7y+AbJMhUb3zkExSY+67KNA8GD1rnWxqrVMyCHeHbPdfQVlguYY6QmEP2VUwWljvlwiGNwae1jlEpdr7wx1zHaF4Zwi/wx/TlyA1m0Ge0u3NSfgKTiCFEeEGlT/2C07yqvJRts48J87KynEhNKXwMXDs6XzbmP3Puwuxtn44vIlmP9BLBuNlb+1//gd7Hi30CnBDBRSFAS49u2K1PAwEr4WJMT+v7Vmy9U9V1HRnEul9esu1GEBDKfwztdwH9ie5VQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27d23c6-b2ec-4f8d-0cf8-08dee382b6a3
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 21:39:28.3608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGdLGk+GsyzWa8N9rdmhOx94mmr89BWAHHefFgARArHZdxD3hoRFLikd32Rhu9ZsUis7IiSCFcQqAufxz6RLhIHscNcutNPBa7rrX7KGzYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7756
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIyMCBTYWx0ZWRfX++xn60e8VN20
 PKlPQqrioVF6ZdP2UF6mIZaZ9VcUw3OiRBAdm/DZrFi+f+5mpf+YCEWp4kxZHcH6KGkqinWUxlP
 WZKfo6waHVJwU613CoLCdYaeICCX+xvgBbPinekhJWoSedR6VokQDmmvZh6if3Dk6YRYagKF+pw
 dbsKUVCHukS/YTJ5Dsz/zk11MwdvjMzmMIymwjkfdvMMBsHIEFeCZsmd7sV+hZ5SxyWgXBxBrPd
 2KIgJVx8IgMOvDL2dhHltZqNfwSpDTBeOXHlZ9ZZTzhopVIFbIrEY7pe9CIv3kLJcWvwYm9mjFq
 bR9450/b2plNkjaZVh+HTS+iOgxkz89cWwDu8MwygYhiatHIjImtJTelYXiMuxQamiS/U7iupZP
 Af2KzoSJ5WWV7rdhaARaJI6HOK7WDhu9UR2FPn240eEYH0UwG7Rzpy0VlHa4GXUjfpJCtD8Xcba
 nKYaz5I5g0OVRSTLIvg==
X-Proofpoint-GUID: 9NbnjPziWgG02vOvErF1FZC2Lqkfhj7G
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIyMCBTYWx0ZWRfX8PTgnIfbSFbA
 KG+Q2JVgwumt7vVg+NhUCfFAe2E+jTZUWxHocHKAIiRUuNlJms+Jl8YCn75nWoPy36q3uzum99z
 rR0uw5bUKpeSWJ3pS4DU1fzyben8gU0=
X-Proofpoint-ORIG-GUID: 9NbnjPziWgG02vOvErF1FZC2Lqkfhj7G
X-Authority-Analysis: v=2.4 cv=J8uaKgnS c=1 sm=1 tr=0 ts=6a594f94 cx=c_pps
 a=aWGlcXfvBePkFyJsMZzBEg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=nWYhzk2I-dwAJmrfhdMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=khushit.shah@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

- handle quoted bitstrings  and decimal
- skip Values.ValueRange entries.
- Emit unique RESx_{lsb} names for reserved fields so no two fields in
  a register share a name.
- Emit a dummy 64-bit VAL field for registers with no defined fields,
  such as AIDR_EL1 and REVIDR_EL1.

Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
---
 .../update-aarch64-cpu-sysreg-properties.py   | 67 +++++++++++++------
 1 file changed, 45 insertions(+), 22 deletions(-)
 mode change 100644 => 100755 scripts/update-aarch64-cpu-sysreg-properties.py

diff --git a/scripts/update-aarch64-cpu-sysreg-properties.py b/scripts/update-aarch64-cpu-sysreg-properties.py
old mode 100644
new mode 100755
index 9e829fda2e..ecc35db528
--- a/scripts/update-aarch64-cpu-sysreg-properties.py
+++ b/scripts/update-aarch64-cpu-sysreg-properties.py
@@ -106,6 +106,29 @@ def collect_fields(item, bit_offset=0):
 
     return fields
 
+def parse_value_int(raw_val):
+    if raw_val is None or isinstance(raw_val, bool):
+        return None
+
+    # may already be real number
+    if isinstance(raw_val, int):
+        return raw_val
+
+    raw_str = str(raw_val).strip()
+
+    if "'" in raw_str:
+        # quoted bitstring like "'0100'"
+        bits = raw_str.replace("'", "")
+        try:
+            return int(bits, 2)
+        except ValueError:
+            return None
+
+    # unquoted, try decimal
+    try:
+        return int(raw_str, 0)
+    except ValueError:
+        return None
 
 def extract_field_enums(field):
     enums = []
@@ -124,32 +147,23 @@ def extract_field_enums(field):
     if not isinstance(val_entries, list):
         return enums
 
+    # A Values.ValueRange field specifies start and end value for a range.
+    # Don't enumerate anything for them.
+    for val_entry in val_entries:
+        if isinstance(val_entry, dict) and \
+           val_entry.get("_type") == "Values.ValueRange":
+               return []
+
     for val_entry in val_entries:
         if not isinstance(val_entry, dict):
             continue
-            
+
         if val_entry.get("_type") == "Values.Value":
-            raw_val = val_entry.get("value")
-            if raw_val is None:
+            int_val = parse_value_int(val_entry.get("value"))
+            if int_val is None:
                 continue
-                
-            # some of the values have ' like "'0100'"
-            raw_val_str = str(raw_val).strip().replace("'", "")
-            
-            try:
-                # convert into bin 
-                int_val = int(raw_val_str, 2)
-            except ValueError:
-                try:
-                    # Fallback to dec if not bin
-                    int_val = int(raw_val_str, 0)
-                except ValueError:
-                    continue
-            
-            enums.append({
-                'value': int_val
-            })
-            
+            enums.append({'value': int_val})
+
     return enums
 
 def generate_sysreg_properties_from_registers_json(id_reg_names, raw_json_path):
@@ -210,7 +224,7 @@ def generate_sysreg_properties_from_registers_json(id_reg_names, raw_json_path):
                        msb > current_fieldset_fields[unique_key]['msb']:
                         enums = extract_field_enums(val)
                         current_fieldset_fields[unique_key] = {
-                            'raw_name': name,
+                            'raw_name': unique_key,
                             'lsb': lsb,
                             'msb': msb,
                             'width': width,
@@ -238,6 +252,15 @@ def generate_sysreg_properties_from_registers_json(id_reg_names, raw_json_path):
         # Sort decreasing lsbs
         sorted_fields = sorted(unique_fields.items(),
                                key=lambda x: x[1]['lsb'], reverse=True)
+        if len(sorted_fields) == 0:
+            # cases like REVIDR_EL1 and AIDR_EL1.
+            # augment a dummy fields VAL.
+            sorted_fields.append(('VAL', {
+                'lsb': 0,
+                'msb': 63,
+                'width': 64,
+                'enums': []
+            }))
 
         for unique_key, bits in sorted_fields:
             enums_list = bits.get('enums', [])
-- 
2.52.0


