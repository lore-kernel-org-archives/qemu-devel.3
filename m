Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF1EC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 10:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPIhk-00055l-JQ; Wed, 11 Jun 2025 06:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uPIhf-00052B-Ru
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:29:07 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uPIhd-0008WI-4n
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 06:29:07 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9ataX030290;
 Wed, 11 Jun 2025 03:28:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=HSAhWlMB7tQpJZY
 d3+q8cS0K2Q9P7pLiScCQGko7Xv4=; b=Yuu/S+9fECGNxghmKZJZksMxWBnkZ/k
 vGNsY0PAx8JxYmswEps4k8PjhDKFo3vyK0r3muL+O8trSSSYqaAu2C4iI0SCh2Za
 Ni42zS89J7NR9tgGCiDj9JhYTtcouqOrW6Ng7r/z34TiUiavgNf/rVcQUXTsbfua
 aMczQDJcl5WVnas2lSjYPlskMHFXzM/GcODl7JXqAnxeoHg+RGr8VaXbEevo6nD9
 VnS/H+OWhgCEUqo5yr8Ny3HlCfzCVOqx6Qh1RiLaARr4lRObv8C1P9vd/ZC/EJjE
 6+qUlbwqpdPYtL4qOVV3U57kixxZHCE4f/mm3Qzn9/u+GR93jTsar3w==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2103.outbound.protection.outlook.com [40.107.237.103])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 476mpx3084-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Jun 2025 03:28:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLzr69wNUtYxWsFQjfaCVgtvEXyJNnArS4wlmFGXueHY+bfwKNbXAlsDQiwB1m6zWqHnf8eBT3UOHmnZCT4KgQn/T7a5jr2H3AEAYJzR+RJrTpjUzjnUMKx8P2ss0a/WqmJxzSxPhwSWxMnD5sHICtetqb05mpek2ODnOZrIoN6eaELWQasoEIKDPst13NJWpLGphskB2O/UPfzB1vrA4+/iZEPCbq5BWNWdDb3ZWfYuKDGX8xgO8bsyaJsVsj+3Xz89LMZ2VZvy7e6KNxvL/WMn1ZaP/MmNpqIX6xxhzx7kP0LKCZzxTrTDUtZXhGGw6eS1rI9GS5h9VxHrdeRM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSAhWlMB7tQpJZYd3+q8cS0K2Q9P7pLiScCQGko7Xv4=;
 b=VXtTDzzMAK5ge+woZDb567y97m8if6f9KA97xVnWPNCW8BscW0AYcothjIZ5FIaD5wUgq0QDJsJcAnWbf69qlW4l3AkWRcp6QWsF9pk2WOIF1Xq9dIQujgYgnZPzxdmO3wW8GtgqQpaoCRSDH0k5GVe2oOf83G9vcKQRa8VgON0PxHQBZF4/B28gh4Sdb+/+uHvX42iwbnJ2gACyOdaZoxlXwkeKUTy0Es8J/9GxVXjfrtPiWKrlRuV21Z0um4tw/m2zJDaOpCp23j4421Lqj97cggLOP2MbK5g511Yu72h4XJ/hAeU3eQspJ/iF69K0qUjKY7if0drgXrjV5K4E/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSAhWlMB7tQpJZYd3+q8cS0K2Q9P7pLiScCQGko7Xv4=;
 b=AsXcKoElsbsCDg9BESgKPMceqbMN+MS9F76xq1VCh20OKEt9cUYnMaeVBWTVOwSVtFUOiInKikqsW5pNcabuNqmRA+U7QlMljWn34r2fE8ijytUNN3eomQBWguQaWFR0d7v6Qp2WMUf8kdWwvGGOsr4jkZlEZ/nzW3xVvnJMAHQSeG05985p4+iJQzM2364q2yXgk2wr+5KiVyopiL+T2B/tcQJp5bs9AqHv1B8uWesHedPoOrJXPNveVPJ0K0gR3PBcWEJSdwU9FsngBp7gukqqOVKnasefINNI/BUe1hMYZ78Kekmc0FhKpUwM3Rcl4vzrcen4WRFoP2u5Z2qIZA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by CO1PR02MB8505.namprd02.prod.outlook.com (2603:10b6:303:158::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Wed, 11 Jun
 2025 10:28:57 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:28:51 +0000
Date: Wed, 11 Jun 2025 03:28:47 -0700
From: John Levon <john.levon@nutanix.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, chao.p.peng@intel.com,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH] vfio/pci: Fix instance_size of VFIO_PCI_BASE
Message-ID: <aElaX2XZr7wUVfng@lent>
References: <20250611024228.423666-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611024228.423666-1-zhenzhong.duan@intel.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM9P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::28) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|CO1PR02MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ab59a1-c99c-48ea-8b6e-08dda8d2c1fe
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bqwa4wp1iIH37i4TmymxMXQn3o2GLekG5yHtytUqlBtrvW/AEW/bLpBCnsbK?=
 =?us-ascii?Q?47R767zSMDftPqQT4kSPcMQTZRw0+JnvEd0L7C1Kmjhk6ZDOaixcKZaZ+Nih?=
 =?us-ascii?Q?DJC+Tc2E3CAue44+jve+5gYQllxX5syhhhAmzT5zA/uU8Ydq2GTKM0o26gcY?=
 =?us-ascii?Q?Djr4D2mwTLixe1NvGnXORnrLJd6HRXt1sfTuvwX8PuJch7pClNFPkiNFenWM?=
 =?us-ascii?Q?pQ11wworOtoaiX9htsUc9CYITX/Otn2XyC1JMgGHRaHhbgag5l2ADHHXmC4r?=
 =?us-ascii?Q?DbidBaWdb4ZyJFxN3cZyBNjifVVPNjID7wUM7jV1ND6y3bTjpW9OoE42H9yT?=
 =?us-ascii?Q?58pyOgALRYXtbLq86kLlvqkgafINPR0J4KHRTs1BoglsMPGI+XxDDhMvqIiH?=
 =?us-ascii?Q?ceBN4XkBpwSExg77kcI+UDYpOzl1sQxuNk7ct0ifvlxYTp6KtpNc9xxyqPb/?=
 =?us-ascii?Q?on4aq3ds8/nWkKNDwKqLGCaCAf4UHMhKf4KscyuoMaQsJ/MQ4NYAfJv1kPOW?=
 =?us-ascii?Q?P3Y9I4vBVSQyoGzld88q0JztXDTUtugBpFjJi9X0d+LPovRrZ5HVsgQXrROQ?=
 =?us-ascii?Q?PkDZRNAtiKJXnQpycOPMlCh3GtA8+HPo/GUkDD9PfcAxyDA4sNJTSepzr4SS?=
 =?us-ascii?Q?Q5VU5NKmS97f+uQchShBOi5iKNNxonckmixWPWEtUGLZyzkeWK7vctat4vBF?=
 =?us-ascii?Q?lPugn3ol3sveGpt/EYlPMrXgNouPM5IGD/yzi5dBASaEdRyC0BP2NpctqM2N?=
 =?us-ascii?Q?ThzGM6iRSGpIGpdRwPNR6kJYmW44IsRBEYlptz8HVo3gMDQUfuPa/XVU2wRm?=
 =?us-ascii?Q?3/KVP4YvSeZO3aueSOh8AVmT4TgTwFBFmCWH+mYMc/omWc9oEG01QHhBN0cp?=
 =?us-ascii?Q?pZviEjVk4monT2aWdWw0o6Dh3WskJXnOGJNToDkXHZJKeg0f2gjBac28DVid?=
 =?us-ascii?Q?MrNwFzBZhK4SdKh00KpdTbbKjbw9QQZkcV0spWQQw9M0Mvo21ib2ph7vFe9R?=
 =?us-ascii?Q?GLN2xWcsA6XAOhlk+YV9PhSj0ftXFHolgUg5rVX+jJ0VT4blmFfF+Ge3kfGv?=
 =?us-ascii?Q?2MbQb43osKK9F5XQXFV/c6/YgGRGnV+7TGthq8j2xTAmp2/n/kktfj6A9M/F?=
 =?us-ascii?Q?YUC417QzMDJj2V0ybAXf06Sy3YzFTSx8acUHG74xDmEZszfyZQPuEah+cXeT?=
 =?us-ascii?Q?rw3wBLP95OB0kTScvAl/OX78dj9TH6ijy0+k1pyaEUzN8n85UfSeMOetBVgL?=
 =?us-ascii?Q?CslE7yYaU8HwER+FwYA/0OTuHlWcp/hRHBtmIa0cDWBzmXxXpxs5YjtQAtKX?=
 =?us-ascii?Q?c9dyN8gdPYbuAt0lTOGRKFouCl0JG6LOgBX1E2NnpKmWeE0wRwDYtwXT714m?=
 =?us-ascii?Q?EfWeqGZKZCWg8beb3QmhMVdgw6K6qOf3HaCDK7tOXDa7UwKV7j2b9J7Lwq8F?=
 =?us-ascii?Q?6dPIzI1HbPo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kO+3EppaGbL3KT7ktc/Lb8iIXh6vfIUXN7/IFLQQ1INrn7eP6F1aTbnDdHM2?=
 =?us-ascii?Q?zkuJerBNEOVC7Fo5kPIwxC8ttEJmxUEAJe1kYoBDKIhLoflKTBbwQ3WaL3b/?=
 =?us-ascii?Q?TZY7AcTjCFyFLOdMLS6U+gaY7NshlfwnRnvbjwROM5AfvSdVRv0aOFisOmsc?=
 =?us-ascii?Q?Yv8n6nU/IzF4wKbFiIVBp0lkeH2+b2yiGDsng5uO8O8UgccJl3m0Gr/jx66F?=
 =?us-ascii?Q?6z0Zm5lGxETvgoOXuk2spp+/wWoURlJ/SPADxhiWDCK+OdBOZGUGMOqJE/D+?=
 =?us-ascii?Q?9VBwxqU5j5e8byvRygUXO/fi8gk53Ls0kpTICUynnfmkF+2q8XpJhQimxUwo?=
 =?us-ascii?Q?eNfDPjvP0XnwIBXKtPK2RDjBKj/zSnJCFvs36A/ig8LriJRKL6nCoPnyvJyP?=
 =?us-ascii?Q?F4wJrHxsp/YoM8WhAyV51+qJVKRUi4brE5yt2O5i+ytYKKh+p7CWiCaTOk0c?=
 =?us-ascii?Q?CKmlE2baJfJt/c8w9hzIyMlmmmjxWnoaYy2UYWDfxMPQeswDi0aX09jImVjU?=
 =?us-ascii?Q?QtuWHvkWDG7xoXiyWqAXLfP6J/eHSmadL/OuBNPSsBxYNXY/k5raFJ0p7wtU?=
 =?us-ascii?Q?wca2cbN6q4DI7L8n4c33crmWB4qfbgW3XZYX23AXw++UBZ0gQfIdK1dAz90U?=
 =?us-ascii?Q?JGAJ0moiPKmrzap6iR5JYhOvepi+4hikm20MEO743fgxAlUHjskchkHljRlI?=
 =?us-ascii?Q?w5Z3RlYjo2EKncBK+DZFO30mTKwbzNOHkzxnR/2xC5kJ8rQRJBZM3zSjha9T?=
 =?us-ascii?Q?xhcpBjzQK1/qB7ynm7MBXerI94GRZaeuKa5GEPvr0HQc+t12l33TG4yPmN2h?=
 =?us-ascii?Q?Z//p/r02wcZKBsCDFKnLCWsUYssUkZYVYXEDosdUkTtwVK781Luj/0S03gUC?=
 =?us-ascii?Q?oqoZ1eiFJQXilkMMv0ha+aR8AJ+aDHQAhruLVxY/tHjns+T9UgxOheqi+YeF?=
 =?us-ascii?Q?7XPAh4BLeqARN5eK6Xz7hdnGxKX54sJ9wk16+Fa6/4iIzUEWXP+N0vOXZEc/?=
 =?us-ascii?Q?ENGhEnLU/tn+qYfx5VP0Vmj8Gild96BBNFhbFuLWjHh1f69XjQpVXMaZHjKl?=
 =?us-ascii?Q?Jr4VUGNqXArZ2LAcv0+3HRozXXx90S2X+5TDqJTScaTMQivR9OyjpRDh5Hfk?=
 =?us-ascii?Q?YxRZkc9vfcvbzRud1xMJ5c1kNzZ7z1eQtyF+UAwXNoYUbxHdx70ai8FFRmyU?=
 =?us-ascii?Q?dWDadE9x3FJdiDsmxanET1cBHtG1juz0A/vUC+lrknY/BxEgs6MDUK6Fq8Qy?=
 =?us-ascii?Q?pr3WwZ2HMdRJbJNfcH8hguASTHG9vygUHwWTeepetnlJeXopa8Mcckt3pt2Y?=
 =?us-ascii?Q?PREJDykI5HIzkHB/32LUrd8Y09OeZp4JTP/pbI6xDbQJLPM2UMPKPXU18+XN?=
 =?us-ascii?Q?EC6KiK0T4wT+7Dg0ugOawix9BsuhW+xB5BFBoCNEfj0JTqS866coYbKjsnLp?=
 =?us-ascii?Q?XpDdDQL6yChzIngyPJlVPTJA0QcEL98/3ie1tuG70mhm7g/yCphSHpLNe/hT?=
 =?us-ascii?Q?tTrrw/KGLqfE0w4aTbCSNAAXI6DB4/ijhBlY6RGYPEbiXoNPoT4NVl0oijEJ?=
 =?us-ascii?Q?S6hui6Mb7m4mB0SKDSC8C3qi/pjxpqUkl4af1jMa?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ab59a1-c99c-48ea-8b6e-08dda8d2c1fe
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:28:50.9348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/1a/ZbVtHAfZ5HgsB0Y8Yf6oexnZnoTNm4Azo8ibeWHokdMYuuv5JkYn0HJjVIlD1Lbs3TS1oY2LWyRE+NiHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8505
X-Proofpoint-GUID: 26NI9Bn852OdsaNd597cxOyNAOFfjlz7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDA4OSBTYWx0ZWRfX9gP8u5aQZj4O
 Zh0RWL07c0QGiSTnutOGXrzCI7Disc6L42NvQzJwMLcwLggz7Asm7budPFB0iOpRcLosjTYc2Sx
 T5YstlWila0FcFszARd4ElWXzns0hn2DQ7q4ddYCDxpwQKII4dPMFBuAq4Er/4Pv3ZVdqFttmMF
 Oiie1y95HJjDoIP+uI9uZGkCUhJkd4Pj6NHEPcGRQcZm4slgomrBS38K+DVeED94TnqHkwOmKNY
 n8p9QXei0C9KtCjstaQXsJHvN/IoKp13kRqpAbwdpz0PkZKfyIYsQaPwXn0lBNDwYN5poyZXOlR
 ZuiVlilIILX+vkad7rG9p/mITc7vAqAKtyEQpRQJKyocH4hC3oWIQ615sLcb1yFUkZ28mPNCjw0
 VQga/TP82mYKHWsRvg7sk11cOQfRv9Z37/5OTPgFBgwWzHz3jC2ed/bXTp7jZGAHHVmrrvTM
X-Proofpoint-ORIG-GUID: 26NI9Bn852OdsaNd597cxOyNAOFfjlz7
X-Authority-Analysis: v=2.4 cv=ENgG00ZC c=1 sm=1 tr=0 ts=68495a6b cx=c_pps
 a=HZ4+9tmhg+SN8rRlD7QAYg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10
 a=QyXUC8HyAAAA:8 a=64Cc0HZtAAAA:8 a=UTiWbH08j0EM8yJUdE8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_04,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jun 11, 2025 at 10:42:28AM +0800, Zhenzhong Duan wrote:

> Currently the final instance_size of VFIO_PCI_BASE is sizeof(PCIDevice).
> It should be sizeof(VFIOPCIDevice), VFIO_PCI uses same structure as
> base class VFIO_PCI_BASE, so no need to set its instance_size explicitly.
> 
> This isn't catastrophic only because VFIO_PCI_BASE is an abstract class.
> 
> Fixes: d4e392d0a99b ("vfio: add vfio-pci-base class")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks! I had a similar patch after IRC discussion.

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

