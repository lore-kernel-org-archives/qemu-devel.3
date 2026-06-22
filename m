Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2B6CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbclz-0004RS-Sm; Mon, 22 Jun 2026 07:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbcll-0004JE-0N; Mon, 22 Jun 2026 07:24:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wbclZ-0001RM-Uz; Mon, 22 Jun 2026 07:24:48 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MAoUOJ012736; Mon, 22 Jun 2026 04:24:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=8IeTnYu8rXZJ7ishxjf2udAN+ikb7eE9xhtyF8G7w
 bM=; b=jbcNFga5CgjWkD9C+t+EIWC1RCZ4yeb8rj1VB4gWfrMgexhZvRAk5FGSD
 JmBOSIoDl8c+YJQJTt/sI8zq+u7MdZzZ20u/i2ikI9R7/uQqfJagimOL67Z4EF7C
 GDf3Csl3nh2KwQc9f4KvvvBB1stn3qMPMC1Y5wI1PdPPfkh0TCmM3kGeEK4tHuzO
 ZX5o+CsXP09hH83WzozVJh9zydB/i0JL2j+jJtSjRkMEp9r+OZ5ROzONO2lvdcV6
 ok4hxYhGHNj1HBRDcJWGj0wwuDh/ZFqb1FECM8YY5xZ3cNtLAO83owS0UE1zigE5
 5TjDy8gZXkXXoFEbNb5HghZAAaxxg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020104.outbound.protection.outlook.com
 [40.93.198.104])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ewryh3hm6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 04:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=auls8eMCH1/DobxcSiANkjPzSRp6kUEkG9gL89Pqaj77c+PqkEva3qAsyLV8IHwDVzS0lSLBL3Ty7CU9XEa9C7fcCgLA0wXMwN5QbRtN9QPogx5aP/kATfvy45jyyfzuULfMtUG8k4oRBZFiI9wGUlePGmGqTA+eIoHl+umhSz3+yjhd8l1+Qi2KjK8Bc5ZW1yyOiYI+9vKo26QojZBJMCFczCfCN0Viy/8Kna3PNzGRvX0iN1UB3Pl9cSeH7S6rQVOCl071mjLI8RH1xoUj+gEaKgphrFxlIehoCDuQCFN6f1eCH7lAhToHHyzCKfwpa9/RDpxbzTQnpT88LbhKuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IeTnYu8rXZJ7ishxjf2udAN+ikb7eE9xhtyF8G7wbM=;
 b=LjgKfAyOzApwSnJDs6qZDE37TFb1pLzyDxgM9XbiWY0N9MexOr2gaNpRCZDzlhp0oCdjKbhU8cOYhIaThb08hvdmxgt3ZNE87MBYSUGyVvJtoqKZm3gRbKwKK17dUOXwmMEXCuZREHudKPaETxTFJikefEh9XqTFcsX077mn6StIffkvwD4yiE3nCKpytV5Ca+Hbt0ouEOOACWv+HZzRRPx0FW8c/AqQ2eB//W7XlUJReEodd3o97Zzq28YT1STsONi3njK2dikAiWmXNY3Dzml3MxEioI/FhmmKDhPwyA+lnG/Gftc8lN56iS2d8sh7PTnhhEDXkFe1j13RRKa3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IeTnYu8rXZJ7ishxjf2udAN+ikb7eE9xhtyF8G7wbM=;
 b=lcgQJjgQYgHr0TdBLsz68SWteFvxpWvOVcNtqNR0J4WVTAFXw+3j+0hy3huppCouJdgJ84zBCvmrXh/XwnKMlUV6Z9K7B0BJSSoJgINhwC4y11Zpl1jkGjuhpUt7MNOh/MTWlpRr/DLL142I+GD4G9+1BaFtBP4hF+spbSahDZN36czQOHYE5Xu4HnYC09tf1BCFw4nlfmawME4/JFldUniKb4/Ag4Za5hIHgON6tM/WiuzE3QEkJStNgzyoNxXx6YGBZe66P3jiZUVjyZnTi8oPxd0DdkbOW5xGfMBJeEwW8UmEF0Fg+4qILlY0ogpgfry7It3k/6sxbs/0zpldbQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10661.namprd02.prod.outlook.com (2603:10b6:8:1f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 11:24:18 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 11:24:18 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 3/7] hw/acpi/ich9.c: don't pass ICH9LPCPMRegs via opaque for
 ACPI_PM_PROP_GPE0_BLK prop
Date: Mon, 22 Jun 2026 12:22:35 +0100
Message-ID: <20260622112403.928954-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622112403.928954-1-mark.caveayland@nutanix.com>
References: <20260622112403.928954-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR22CA0005.namprd22.prod.outlook.com
 (2603:10b6:930:45::9) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: 980bcd1d-2597-4cd4-9a54-08ded050ccc0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: oj9VU+UYxgedJEX1oGGFwYXM2ftjpbt++dyQuQhDyVD5f6Ou/OdIjEfGa+3r1l/aQtkf0ixfq5LgEDElDAsTj6gTr5uviZPul9I/rPcQ6WUeM6RJ5gmbHmpmCC2XefkvszdrEKFSiKa3gMDZWt1UT1Z7BppFPudjDs2HJwk8KSqWW6saMGAUVJ1BY20p0U/KYMSgPjNRrOzz+dhC1x5lzUfK7LzdONrTL6k4fjRUY7OpKCBHENBx1x+ioPteSPzPAyBLZ3g+rR4y7nergEkjlLIXmFwP/1+e3daEwFC1BiqFkfSifajs8C4NdOgnWh17e9zv8LblYJsv4zRHZROnBitPXQ/xkB7Th0VqqFH6aG+FtznRjwrcd5WS0Y59LkJVirXaIfgKa9WDTC2mMFgUyRGxjNzg3uTqvoB4qc4IIRprrU3OTpAyyaCtjKBgsk26LsuN+4Z7IlUXpHA+mh51jQxXmFgIHTQ9eoxJHHLq2Mc1MJpud/VehiSkLn6wijZsKuZjxemJycQR1pnn+5wZUXV51z6Ud1/zgAY8esEFg8mSq9bWu0KSMNeEdaCFMXAdH7SYJ1NQcyarR/rVcbOHKQ7qnkmrvnGHqlyHa8hIoCJEq2sLU67zQjVSI7VGOIwRtG0DS0ufveeqnM0bxp9XOYSRXLVlZPTRhiH5TOKbMioTbSeUveNYCU01rzJpvwrc4GIyyp5l9E/y+ONrsPgSog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T0Ut484NwSK0kp8m7/HBTfzrZShFwHCC2GJxyUKk4FTcoIw4dvOQflgtf0Jy?=
 =?us-ascii?Q?o/In9eiZqzj3r7AHrfOsydujAi6jA5aL5Skz06ptsTPk7IFoVktXEywALsUf?=
 =?us-ascii?Q?f2EKDTgVtWUcuqDrCBK0PGgchvghLbCePOAzMfSUmp61IUc7LV9QGnvJqW2p?=
 =?us-ascii?Q?OiK3VVCR3bBmdODmdDiXMOTRzKfXVD3A1BC/6sr3eC++c+5HTkrrVpcXFGtS?=
 =?us-ascii?Q?Kt1nDPllZHJHFK2zQQaA+jWVEltmAf2AVtRQqUSUQIhFAZb6VA5siQjwhU3y?=
 =?us-ascii?Q?LY1hQP0lYO4nbyJLvHldXEz/2dX38NLwBUZBYhgmndFqwCOEYGqiF0mM04h4?=
 =?us-ascii?Q?dLW8TbwjDgCrR8idwjgXymIE7/+jI3/yxXLD/UZfhV/aUhAMA9V+xLEZw60K?=
 =?us-ascii?Q?iEkeb/vQt3+9FF1XspgSYwUiFacdOMWvsfAFPKzOh93EM21HxMar9pmfnEuE?=
 =?us-ascii?Q?o5oGr3Y5pdnKYa1JZpuRXo/PyFk/9S7l2GGKR2bAESU5Kh5SlmuDpz/1n+vX?=
 =?us-ascii?Q?Wbrc/pSGmkr8+XjspQSxCLyhqIB4VGL/ZJ5Iqglf40N4YzVmf+LEQCeGxF5B?=
 =?us-ascii?Q?RZi9nAVViu7SnfBR7WUlL7CRwhhjKCvK3KKSIcKvZA3moiyWTYjxKC34tBAt?=
 =?us-ascii?Q?twg5N81I4talXG5F0Dj3V/ThYqEzmOJWODal4fd0rrfL8F0FV93wkJbKqTJT?=
 =?us-ascii?Q?lL9rHyeyd1bddHCgL4+GxMKTDbFnltsCnsMj87OUBfWBGg4vSsyGwM0sGmnr?=
 =?us-ascii?Q?zDCDHyJA1r2xcCOMTPv0vzLxKni+IF98mgC9XHDp1/JGpMjmy7/kmGYeeFYS?=
 =?us-ascii?Q?L5n6TYjLobV2hMY9gFxS8qeiHrypM9uzH0XmzRy5JiK+AG/yfnx4F85ztUYu?=
 =?us-ascii?Q?IJPXll8elfWIQjfzAXf2uQufqP8gA6OQdOtWXL3dHIB/Iz5ZK2NNs7FW3hLQ?=
 =?us-ascii?Q?+nqn9nev0BYMA4BfScKpeOPNGCre0lT5Ja3iLuiA7bXz9JfOnT/0MdX/IIL9?=
 =?us-ascii?Q?aUAQfTKe7SLk+X0lpq4/Gb0UkRviigTcAZQ1t9NesXMN/M/egPlZj/yH2jKf?=
 =?us-ascii?Q?xjoJBORHr3UehDitzdt4oZcJP/nE3/SQo2fmHWBqlbF7W2kXMdJblDr874fa?=
 =?us-ascii?Q?vlmVDxsYjaE9O47D6kC63PV1iokrfxFAsHkJVnUSIoO1bHcwH/MWrfZdOq3k?=
 =?us-ascii?Q?8ZC4p4yq9M3OvQF0rUO3JHpQxH/SGc2A9dosq8dOOMRyGfnuNePIPlqHb7N2?=
 =?us-ascii?Q?3hUwrR2KKK5bGatoUpKXvfLFg3kQffNKYq1Fl7kgQ3yf5UalGh9oGX4K/cLu?=
 =?us-ascii?Q?0JGv/G0FaVXCthoACRuQxQQVkqKc6ArkMXR+KZxqPbnKYS5CAVxbB7CUF83T?=
 =?us-ascii?Q?ZyJgbt8pshQpI3AEjmAwptnTT5PfUzDkqfKHub/w/OE0Grs49BlAyUVF+dYl?=
 =?us-ascii?Q?eKN2HWrPP2et1LcUywQK+Sdpv9Z/FwnB0KUaG18oeY1rAgIZsymZDZgeZaQe?=
 =?us-ascii?Q?m+QmNPoz5z+u0ZCIIH5ijKDFr103QOaXM5BI7VngKFUzufqQYQ2cFpO8HmeC?=
 =?us-ascii?Q?9noDVbXlNZwq1E8/Bet8sdEatODuC1rPDLtmHZIYbYZHIiIzwOi07zCs7hsr?=
 =?us-ascii?Q?R27uDYzzkMIxSen8fDYx1YfsIVatnXECLHB/DNQjgQPxRAtSvkHVR7jSvk0I?=
 =?us-ascii?Q?4i2CtXQY9ymEUpK4X9ZuIztxCyNLaynxawqHsN7bbma6b/goh5coCtgO/kgO?=
 =?us-ascii?Q?2HTL/83Yvh06u3H1LEGhS8rNWqffMUI=3D?=
X-Exchange-RoutingPolicyChecked: a5y3IzpV/5Pq8kWI4P83fc3Bi9TzSRA8nzeRM3JBKAMEi19Y+0pAAW4KGQOkP5/SeLug15WvGyVqv5j9nbGLyXRx4Ngz+xlsIoaIv1UBIeP9zCXCaAOiB3GJu+mazuc3Y4f6Qtht+4AOjt//raGIJBsDHiNALZ2iXf7LH0gAcwreeSw4DtnB28Be38dB104aLvnsr8z1bxqStjEXX+462GDauVipE3Hyy2twcwe5/TpZhrSAUTaK7HkPbY01MktyOS/4x0hIqdIktTgJbUO4XdSEJIuOGvfZqiU3P/co8vnt8HJSnVz4rq2BgN41KN6ColfHxLtkyR3zGLSjjOCGWg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980bcd1d-2597-4cd4-9a54-08ded050ccc0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 11:24:18.5160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHibUtF+jr97xxUY28Q1IyWX745XVOUvOp3eq4QIn79Eq2pWJGFl4EzTLtym1wBkygpbNtlYM0oYumwErQXtlAWhgp45T0r0PsXv6TDbpF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10661
X-Proofpoint-GUID: sfdfXPUbMrzkIVbWFkh9cvz6NND8lYb-
X-Proofpoint-ORIG-GUID: sfdfXPUbMrzkIVbWFkh9cvz6NND8lYb-
X-Authority-Analysis: v=2.4 cv=M6p97Sws c=1 sm=1 tr=0 ts=6a391b64 cx=c_pps
 a=/l2LzaSN5HZ5zNViGO9i2Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=Y-s1kumoAnAeZpE8ypgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfXz59g5TiiotA9
 9ER4i2kNORZpLn3wzi2GN89kIWVSCkNk7InEi62YiFxKPqCAqIXkFW/dMth87V47nPnmk10ZoEc
 B9ngfc0uUpPnBOR/kaeLEDVWPBYTk6k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDExMiBTYWx0ZWRfX72g/oUMOmOET
 wxLojOdUnJGkoQFIpawmLfAjOiD2YdrOhg07oJ2HoppDhEPMxIDETqmdpc7tPRzo6bTJMMGgolK
 0Clzp/QApkpSU+SBSjY5TeyEImp/GbNmOMoMFbz6nVjT6mF1LszUtacQPv6ryBW1Js+CnQ+mxoL
 /qGSQBS4e4bsBTqqBwS5AkCX/GiQcWag7y2VVDpPpqa8LKkOowEdFAa+KAEIhvWIqQ2Za1etnhX
 D/ZxLiW/zTEI4d4uqJ6Q6xVzezD/Ce2scjEnXErC2HvCBXRRuXdA9XWhjVMIAhHs+C8kjQwuGvr
 DNPNpTcl0rcI0unJ7oCwp9KtTeNw/6ICDOoXKT7zD3jb1MHHv5yTFSXypRDvvQqFNcn6zCKYGak
 Fw6w55DHKT4PHM+89rDMW/APPHx39XLIfiTt6i9PO6FdqkIazGwiveTibyv0GSjy6HNFFjBpYBJ
 pGk8v1UPCAR1CXtm5ZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-18_03,2025-10-01_01
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

In order to convert to a class property, the ICH9LPCPMRegs instance must be
resolved by the getter/setter instead of being passed directly as an opaque.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/acpi/ich9.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 5e8f8a7eaf..ac3f452dc3 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -342,7 +342,8 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
 static void ich9_pm_get_gpe0_blk(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
-    ICH9LPCPMRegs *pm = opaque;
+    ICH9LPCState *s = ICH9_LPC_DEVICE(obj);
+    ICH9LPCPMRegs *pm = &s->pm;
     uint32_t value = pm->pm_io_base + ICH9_PMIO_GPE0_STS;
 
     visit_type_uint32(v, name, &value, errp);
@@ -411,7 +412,7 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                              OBJ_PROP_LINK_STRONG);
     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
                         ich9_pm_get_gpe0_blk,
-                        NULL, NULL, pm);
+                        NULL, NULL, NULL);
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
                                    &gpe0_len, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
-- 
2.43.0


