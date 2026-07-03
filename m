Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773CFC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeNP-0002d5-JD; Fri, 03 Jul 2026 09:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeNF-0002ZP-Bb; Fri, 03 Jul 2026 09:56:09 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeNC-0006dh-Un; Fri, 03 Jul 2026 09:56:08 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635qxWD1963617; Fri, 3 Jul 2026 06:55:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Zawavq4E+SOa+bhfMV0zh9fX86nuio2YWr4ZBnZLv
 KY=; b=r2lNefgw7P2J87i+DkHxigY5XfrquEfHG3axGkP/+Jp46UnPUl3WZB1kr
 ZbdYMJ03j8qHC8BDwFUF/xIdPof6tx6YwL3xqjaXo96imgMqDATHH4ZMUPu4+SNg
 E3y4DSKmnNzW1rrHNKy4Z8WvqqEA2nx/1J/gANNcaRDfS/eZIQuQhicjDWmd94C4
 FgNzlsj1aqq/z3C5DfmlXRIdoq4bKMw0T/qND8i7QEveTxGqUDOIjcXvGVJdG46K
 ow0lzMElWVTucNQiHjWLMgkryZkfypJ3MdNKDUCCw3CKvKcTp9qFd7ojDL3q2wje
 WsQw9SIn1RQghX/juPZy/MDCtEeLg==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020087.outbound.protection.outlook.com [52.101.61.87])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f6080spxq-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ut64d54MFgrK4f+vHCMM6Hl3sb7IZ7Ni/97oGeWBXlOllK1etRE1ZFZ+7yoCp0Jm3pCyzl60B1N1a+dig98Y+mMMh3a7XYv+piHw2/UDEHStJYINKMD/0wicm0trHku9UBsLtLddWOP6jubLwLhfjDy/1suAYe3MJ37k4tm1aGaX9sM/4tM+9SMZ1M+JCb7UmLn+ea8BtTYZnlED3+9F4y9c2WJWgX03od+OR458agJ4+nSUx3P0n3i+dUWNCADF/BW5SrnO8030FkEqLt0kRA3wbWq8gzGVOCUsbcyZqi57WSf4pLVIYHgysZDiCDSg5XVHvuYVCZUy9Z8o/xUajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zawavq4E+SOa+bhfMV0zh9fX86nuio2YWr4ZBnZLvKY=;
 b=sQzrnpU/Q8JW63+11PPaFfCVwdtV00ORUuFwBvpGntlieRGJNeOPN56kZf6jWbNf7O7zZiNq5DtZLpqKcn901L/WoAHnrDHKQqOFeCFokL4z+M/KRepB3eyqZg9TJUmEWZdBq0fxZ5V6kRR6h/pepf3s+nVKd1YijMhRc5jEXtAvRei6PnF1VPQGHb0jpE2hAvoXkjkgMw3mK1aGRrTUY3kzrXCJr03Y/OtOq98Bi372ktAk8bbOTVQsClobPsKC43dgu7ChRCA1Mw40Ku0k3pOQHt+xMO+eMyq/GcUTY+saZfVM/s50AWAombTtBgvmk7hZzQnbs8qkBEzyLHU0gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zawavq4E+SOa+bhfMV0zh9fX86nuio2YWr4ZBnZLvKY=;
 b=iLZlmrw0eRTFiks9vVmhW3PDrVnFXT6zhrf7CTAZYKzUEjpMk6YE9W3wMK9b0B9SQeLjLk9w37IEVKURwnhJJzRRQE/dNq2APed/vk8abL9sPR1+GLO5aMNRQcUsFEFk1zdZHO+LHiHxLr5f4Fh0hh4qpTbOwryQs7YR1lEtu5/W1ZLmJgdsAH5xIYfoCALRPRxrBtgozu1Em8g8r79/DlAONkbMdc4IIS6IFIcxw43jS0UHeH6FMb3j1JUgT752q8Tq9RGeX0U9YWFEa2tZGsDpIDMhEo0rgZ8S0Nuj0GKNomJEhaw8utEAtWUYfJ7chomCbyVOQPzIsKaRAUtUqg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY5PR02MB9016.namprd02.prod.outlook.com (2603:10b6:930:34::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 3 Jul
 2026 13:55:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 13:55:53 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 09/12] hw/acpi/ich9.c: convert object props in
 ICH9_LPC_DEVICE to class props
Date: Fri,  3 Jul 2026 14:53:11 +0100
Message-ID: <20260703135512.3213964-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:208:23d::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY5PR02MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 457cbdfb-4cc7-4c68-5a94-08ded90ac81a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: WWzMyDnvrLX6wmZZCcREBZcDHXxbcAVRkr+7LIyFv7SeUAfBkE7i7s2u0NDq3dr1iPEfnwGLTilrNqt1DTZycqAskdbHk/o0iNIZDzcZINlL4A2qWG7KzJ9ylfGwTtOYHrEsQorR8RfKWar8FFU+pJAmABtMJJ6kdImvjVBbwWStt6sZlaDm7jy1YZNwA802sm8SRQo6Ul+Cb66d3CdKqHZLT9aRVM3nOa/zjDLel4VTMQrjcFaE3rb7VuAA0KPiRNKY7rZSazPs4RGeBiT0DU8nsD0YzvXHo5zk8JNJK94a6aumJm15EW7j2j9ihz55eYSRF/WDben28RgrzrIzbD1/llZ3hDWXbHkgu5p9g+56E2ztSE94Q9AZpA+kN2uTMbaBWry6TU9fjfGqysYxXDWSnGiPNtzS8Q+gUtrdUfthu6XfmmYAUQrzquphT4BpPtGtxRZplvXs4oBJlv7D3HEgWrDxF+cNUR3pgFa//um6zi9sj/IcaQYhojleqFmEJVc0CtmDVnBwqsAyLElsHC8MRm6IkqmDW2Tg0wo9VdEJOIXhEaJ6jaqaW7gefLkKRV4ByvOF6w980RWTK4RbnpHZ5z8TjX39XUFBFCO3U0AK8cLpRiEaRccmHm+08drHZNfSGljLyCi1ZNqfktM271fBmRHuf3FEPIIzAt/ZeAtg3iDoKM9nOSzK9kMFnbdrFq53fbzDsjfitkr6ybxMJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JOl/wdGsVonI+XK3MZlbhAV2To1ged2bYEz19+fz3FvAoX/LPpVUgf3yp1dy?=
 =?us-ascii?Q?+H9sQ1XQkcC7bKomeB+qnmxeNI+fsyBntDblD/CnYx6Htj+LoL/1WJ5zlxvx?=
 =?us-ascii?Q?0GCeApzw+Og/PYrDAZCyAWt3YcceRMSeiIrjXXDHblyNPlHTbw9DwCD2qR0L?=
 =?us-ascii?Q?AxHFA0yqyCwOrhlwUjvbwZ7Wo3MtxWhxZ9RFKelG5ZmB6nuhZlcgdTrkP98u?=
 =?us-ascii?Q?GGb51wVxBTMHXSFDMnvC8c31gYoGwtFq3HVE0Ap/LaV1P6qMaXdbkoBZg6UV?=
 =?us-ascii?Q?47pEtF2Ob2eGieWKfCunMbxi7vTEnWwtcFXl4gkXOZ0RUW2MPVbaLGwYKOmb?=
 =?us-ascii?Q?1zeBVVIXzgiwNJX3H1qkT7DHHi1gTdE93YByzSBUsbwSGCnZqPW2twIeWATA?=
 =?us-ascii?Q?qCeadg3DkXRG4PtmJlAT/nRO2RWG6QWwPAJk4XnayxLCoFplcX/8ymlCahIR?=
 =?us-ascii?Q?TyPZ519leSJFDVdpZ5B+zA95Z4gYOO8UOEZIIjKMSVrsq28swGw2FE87UP7j?=
 =?us-ascii?Q?ulfM89sxQy82Ud6rgsSM+TFu2jhr0LE0Xlw9o4df8uE0gyXsYfXoc8j24RC+?=
 =?us-ascii?Q?0Hpx2+5Sf9DDxMZcfcR1TpSj7vm1MJPrb1D4V9Gs9sFLUTxDNYF95HKBtKEO?=
 =?us-ascii?Q?xh2BOcxp0pnkemZRVhTouuTdNLusxGQMjuu7aph6LFtBxJEUqG/2QDyaB9jE?=
 =?us-ascii?Q?Vr6D/zcCWdBXOESP2lCSZJ5SNW8CIeXLBbxsz6LLfJW2DdHL5ogwVF/Wqq0q?=
 =?us-ascii?Q?D7aKISFZfcse13PfFdKycqn69dOpdwcMcTTE3YrsyMfuJudSfmMojFieURgD?=
 =?us-ascii?Q?xii4hjy53s+AgmcyJ/DBdpo500iTip5pYBCaP5nPiEaXK9dwq2iD81MhAQFJ?=
 =?us-ascii?Q?ZnXotJeFXbOAIJtZjX9uDfodldR1NRTkx0w80ygDQVFedDRdkc6+NfdpIply?=
 =?us-ascii?Q?348w7+u6VGi6v/gl3xLi5AOhr2OTgkIy9LjPCz2kN7465wjlj4hloLOM+Q4i?=
 =?us-ascii?Q?D5rcysfXy6iSfNvKmoZ/024deQUAUsGIWjtNo+rVWZuSLWRcxLadyqSWpyn2?=
 =?us-ascii?Q?AIt0VteiRFfzS/V5FC3sYnsXW7fwGRrMWEArWloux/cZ48xcnYTSHiuh5RmF?=
 =?us-ascii?Q?GLqLBUXeD/DL8ByY2lMVaM+nmDudgNrcAFXEhR0/uVcCqVZ6pw2o+2NjCyEe?=
 =?us-ascii?Q?v2Qc0EnMMIto1C6sbXW7JA0HjsikVctv6vSeg4KaO8nDVtL4PQNn+aPb0+4K?=
 =?us-ascii?Q?FOjmoGxFpTB9kWLM5aQdS6/Y+TLkHejjxMF7gVgioqA1KsUsM2FTk7/8stlT?=
 =?us-ascii?Q?yVpuRgSnuOD2gUr36ujUI1al3I8TXS7/ucmA2qKThXNyroZ18b6J6CxGKTib?=
 =?us-ascii?Q?XxcmIGo2yFuvpbL73Z+bn+sUF2X/I5kOXgh21+Xljj8h4PxUzJ6khYrswV1c?=
 =?us-ascii?Q?D+47Wpn1waiZtbRNmtlnEqNPp1rY4oAWcw4ST7/PITqtBLRZ5P0PvCibeFHD?=
 =?us-ascii?Q?uT28y5eubN1YUHRdnYd4aKkSE2WGKsAdHoAkTh3sDKy6TVJIuyG/nZzOaWiN?=
 =?us-ascii?Q?P+IqvEcthodci8gYGPMr/sVzm+2n/+RiNmKCaXyItNgmj/VHF7uJfwLiG9DU?=
 =?us-ascii?Q?Z/z+BiPlKguvrsUPTEGElQZJzDDTzFWFiN5D9ItCKwzObgkl5YgLiF6n7VsB?=
 =?us-ascii?Q?Hlsy1GMw+Gw+49ZuyLbCJxX44Ov7rnxOwH+0GaFuBDaWx+LTgPza1xL5r+US?=
 =?us-ascii?Q?S0wdIWPn3hJ9Gn2A3CqLhwW7a0ij4Po=3D?=
X-Exchange-RoutingPolicyChecked: BczMB9DKBM48wcgmyi9bX/bHOvxs6MnYR7aZcJSYtMWwDQ44G5zji2rkxQr+ARz0TBzI7N8A55EB1gQTtMuVml3jbMteqFiltXbglRNa0En/Z1wF1YvBeIvUmT73A5pARjhyOu8IUi5JGzuwGXc+PBZTbZJXKglttaYs9kwR3rfIHF2OKGo8YRdV4MQKgXTYzb1xfth0kcuByDuOmzGXv259k+9Q07u2/cyFtyZul5cP+1WDG7D0OA1ZEtlO5pXnoLE+cFC/9jOKkywA+d/Az/UMa8KQCN4ptF64BBCgK9sD4/x0EFLRFwiLHc6IyQNB4ss8iM8Tv06+pe8+VQeLKg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 457cbdfb-4cc7-4c68-5a94-08ded90ac81a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:55:46.4946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RRmSPQUUKu5Rchqi3HyfmC5ZssUaTY+CRuuTrjJc4LZzRXA/tUa2/QtdAMNakwaspO0C4nvgql4ZYa9DsbbueSHC157T9YbjhU67JSaej8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB9016
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX+ywvRSTw1Nz+
 pNeHmbYOlFMftahteFE5QpHVu7GTTu7u3mzu9mq5ZwAYInmDaWNjoXgTOCI1wO/xiZmmPaKqXKO
 MA16q/kUMtVV2g6TYIExsTRExFXTijI=
X-Proofpoint-ORIG-GUID: KlDp3dRbvAnrsljxVzQ3yM0ECzWh1uj4
X-Proofpoint-GUID: KlDp3dRbvAnrsljxVzQ3yM0ECzWh1uj4
X-Authority-Analysis: v=2.4 cv=ftLsol4f c=1 sm=1 tr=0 ts=6a47bf6a cx=c_pps
 a=uUOONCeAppmmVOxUvBiRog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=3RGfxWCeb2yzifHjyP0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX4z4UAUAqXYmF
 iUnDPdFESeFL+gRo5PBJxCJeeri1H3qI2NqLX371ZFDQ4rqQIAqNSp2LjrM1PV0N4SLizqOxGVt
 1ME4XqRx9s5cO7a3TGJVASzpJn7SnDcvYoHPXuLNmD7IbuO+e0J+9dFeqNvy8vokFuMQ2ysEtbs
 5NqzKB01Z/XQJf0VwWl7hgh8j/6g6qOGJ6cMAH+QlqLITfmF1Utw0Fk2kJJbvQP4XeuXQH0fLSf
 GCqwR2Zl+CXWmabFxDZfqgzLNCF7YKRALa7yuimlGLp9lHsI/KMGM3ZhQHue1sFOTGVgFZjBk7k
 3KjwlO3SuWZhLsW8HJz0W/+gLxRPT4y4stU/63Eq5+8uBWCgcGRmSlWwJ7GKJa/VPNZUa9ni50g
 djNROkupNi2lE5QGbvQdY3oUC0yT3jCnmxSEneq4codVM1u+UorvfX4jBzhFfOkEE0Lqz2x9G45
 mNKhUzXGCaZkNxZFX4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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
 include/hw/acpi/ich9.h |  2 +-
 hw/acpi/ich9.c         | 62 ++++++++++++++++++++++++------------------
 hw/isa/lpc_ich9.c      |  2 +-
 3 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 30990fcef5..3180e98c93 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -83,7 +83,7 @@ extern const VMStateDescription vmstate_ich9_pm;
 
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm);
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm);
+void ich9_pm_add_class_properties(ObjectClass *oc);
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp);
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index ac3f452dc3..cf36dfc3d8 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -400,36 +400,44 @@ void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
     pm->enable_tco = true;
 }
 
-void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
+void ich9_pm_add_class_properties(ObjectClass *oc)
 {
     static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
 
-    object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
-                                   &pm->pm_io_base, OBJ_PROP_FLAG_READ);
-    object_property_add_link(obj, "bus", TYPE_PCI_BUS,
-                             (Object **)&pm->acpi_pci_hotplug.root,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
-    object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
-                        ich9_pm_get_gpe0_blk,
-                        NULL, NULL, NULL);
-    object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
-                                   &gpe0_len, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
-                                  &pm->disable_s3, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
-                                  &pm->disable_s4, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_VAL,
-                                  &pm->s4_val, OBJ_PROP_FLAG_READWRITE);
-    object_property_add_bool(obj, ACPI_PM_PROP_TCO_ENABLED,
-                             ich9_pm_get_enable_tco,
-                             ich9_pm_set_enable_tco);
-    object_property_add_bool(obj, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
-                             ich9_pm_get_acpi_pci_hotplug,
-                             ich9_pm_set_acpi_pci_hotplug);
-    object_property_add_bool(obj, "x-keep-pci-slot-hpc",
-                             ich9_pm_get_keep_pci_slot_hpc,
-                             ich9_pm_set_keep_pci_slot_hpc);
+    object_class_property_add_uint32_ptr(oc, ACPI_PM_PROP_PM_IO_BASE,
+                                         offsetof(ICH9LPCState, pm.pm_io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_link(oc, "bus",
+                                   TYPE_PCI_BUS,
+                                   offsetof(ICH9LPCState,
+                                            pm.acpi_pci_hotplug.root),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_add(oc, ACPI_PM_PROP_GPE0_BLK, "uint32",
+                              ich9_pm_get_gpe0_blk,
+                              NULL, NULL, NULL);
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK_LEN,
+                                                &gpe0_len,
+                                                OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S3_DISABLED,
+                                        offsetof(ICH9LPCState, pm.disable_s3),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S4_DISABLED,
+                                        offsetof(ICH9LPCState, pm.disable_s4),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_uint8_ptr(oc, ACPI_PM_PROP_S4_VAL,
+                                        offsetof(ICH9LPCState, pm.s4_val),
+                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_bool(oc, ACPI_PM_PROP_TCO_ENABLED,
+                                   ich9_pm_get_enable_tco,
+                                   ich9_pm_set_enable_tco);
+    object_class_property_add_bool(oc, ACPI_PM_PROP_ACPI_PCIHP_BRIDGE,
+                                   ich9_pm_get_acpi_pci_hotplug,
+                                   ich9_pm_set_acpi_pci_hotplug);
+    object_class_property_add_bool(oc, "x-keep-pci-slot-hpc",
+                                   ich9_pm_get_keep_pci_slot_hpc,
+                                   ich9_pm_set_keep_pci_slot_hpc);
 }
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index f89fadb032..8e226581be 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -689,7 +689,6 @@ static void ich9_lpc_initfn(Object *obj)
                              IOAPIC_NUM_PINS);
 
     ich9_pm_reset_properties(&lpc->pm);
-    ich9_pm_add_properties(obj, &lpc->pm);
 }
 
 static void ich9_lpc_realize(PCIDevice *d, Error **errp)
@@ -954,6 +953,7 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
                               ich9_lpc_get_smi_negotiated_feat,
                               ich9_lpc_set_smi_negotiated_feat,
                               NULL, NULL);
+    ich9_pm_add_class_properties(klass);
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


