Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73087C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 13:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfeNP-0002dF-K2; Fri, 03 Jul 2026 09:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeNH-0002Zc-EH; Fri, 03 Jul 2026 09:56:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfeNE-0006dz-1B; Fri, 03 Jul 2026 09:56:10 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6635qxWC1963617; Fri, 3 Jul 2026 06:55:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=8IeTnYu8rXZJ7ishxjf2udAN+ikb7eE9xhtyF8G7w
 bM=; b=g6TYUwI4BW9Muk3NXx1EvCLa4bur2KvaE3F8TGW3QnMWxvLAEqSwY760e
 8X/2c0l9TwcXa1zTYmODxvkk6FFCOEP7SWR8pwqVVkvEhJETERmx+AiZh2ARK88V
 jEGKBWh4AkRYtYfqtP6AWjeR3D4kJrqLyGOtrM/9acJz6weCNVF3Tm5VUhMMkjQM
 z64PO8hMyaU42T7401PfDRGj9p5d4c+Gk4jMeRH6oVNL/m+aMIzs/m2tkG7x470X
 cMmsKgc3QKrq4t8nMiDAKr4XHV2KMvwz+nttEh47pZzlNIOgxXmeSTzas+1e99X0
 k7Mt/ryVXEJwD5B3afohMOZB3xBdA==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020087.outbound.protection.outlook.com [52.101.61.87])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f6080spxq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 06:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqVYqCJO2nxzGu0rF9nfSF1HGYLouy3xq9UWcDYg60QqHvgsWgt7wcEfrtrFUP+gM4jt7TCrzijU0Q2Te83FfA1cuO9lwbK2A2lzLFe0UcnCvU+NPyY3uJLUW1fqSuK7X6UjmP1KBaDlpBDQ8OG5k+oz/l13k9qRdNC8dYEwHbleJw135j8rbEFxWkogvV87qR+ovBBQonLwOY0nADpnyAHlSPgEg0lPJNL7ngSjZPnhwhXEBqlVw6BlB1h6z0cUImGIXiI0AO6W9oT/qKl4avukbRsyYauqcjjdz+L+JJUxGse++yp9GXPeuHXA1WxhJeRWeZuzPUyL3T0U1TbefQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IeTnYu8rXZJ7ishxjf2udAN+ikb7eE9xhtyF8G7wbM=;
 b=f5I+Z74k/YQuKK75QsGzl2YWC29oIR1g/17LSMW39cAxzlzQx81IeOp8UjiVRfU3dWQGhcBDSO9u2f3VjffeDJa3MU0fL9sBqFWhZgo5uzz/Lv9PJongpV0mLMoN0Jg6pz14EtkOxT7sRq5AboKfSrwap72+K622NdfuGzDxYuJ5YL8qj9eZWQVNiy8R+gqQwWSxrLrDxyBcDd3LnNBKH/GBvBg2C91hYWSm3TGDqiNTQCw6NoL4/Jj8hZCZv24IvK9Ga8eLPUAPZi64z3uzv81jzHACR+MGLpRAaPDonV84gP8dYzzx0VtYJ8IpswqlgGQ1Yxr26FqwnlKUgBr7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IeTnYu8rXZJ7ishxjf2udAN+ikb7eE9xhtyF8G7wbM=;
 b=v5gfDmewxSrbnw7isut8RzTBRf91nxWN0BtxNHNaPJb38dNfSbC8NgXzc8Imm4p+1XCeskq09kraJRCstVNe8d2Ku95dakrCDgVyDcdXpuTWNv4waf+1UR5tzNuqt4Gmowcitc3zmFl76DcgwyRQl97fQoivBWJlfFeqVeAymF6AV2HFcqVVLQJ4xfrnPPB/Thmm1QP0I98/TKddn9H4cAyAqQoUv1Q7EmWM7+Bo06JzuiJVPR9cKQ8X/WSB7/NqoOg5Mig0Nxa5S3d8UHJHCL6PFfolOpU+iHi8QbNnJZkgyzJ9yi//NMkKJlBAGoN5io6UT5HBwzwJYeCknrC1qA==
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
Subject: [PATCH v2 08/12] hw/acpi/ich9.c: don't pass ICH9LPCPMRegs via opaque
 for ACPI_PM_PROP_GPE0_BLK prop
Date: Fri,  3 Jul 2026 14:53:10 +0100
Message-ID: <20260703135512.3213964-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
References: <20260703135512.3213964-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0034.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY5PR02MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d98772a-a9b3-4696-fd5a-08ded90ac678
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: y5g0DbTy6MVdTKbPUTBV1DY6mMUp+I4a+Kftr76SJr9Vuq1+5vQmBHXFWjQxWooMgQCE0VECJEFZNqT1TNx53z9NIwYZT0lv8axkUuueVUTLMGCLQU+iNvkZIdScKKmWC7uJjLS/yc4rxWyvpUgzaIcH4P2tT8z8nuxHZSdwt0FDIIUMPSdMPN5QVzpzyEFnWZOGgdF6aIWs/c/SyKoRudsdXpH7uZBrlc3ahNaB8fHAQVCNIWv8aaC6WbLE3Aqbg+e2WT8+vYyzOzmkhc1mEJ4K6JDFclGxbfbvBskw4YXHNaaMri/j1KVux4Twr1GTHB0l9LytfCE8H9NPhrqRZXztTt6fUlKhmUW7rxFGhP6R3E0yk+5kF3k+Bw5kTuZFFrUNSIXL9RxX6S/OmWqTAAthMNLSgLwQg0Y3vwWwjfu9cc+99N2NqVdn+0l5a3jSvrCNEa8EkZMLN2M4j3rek4NIKpVEa4DXNRXWcOaNqKJKks0FHP2BCheG5FG8QuPmTAxpa4UYnUt0HaBaep4fQoiA/eNbRKCl8zMjcYjEcoG3PDayQM6xkV841lWHOj38kst7H4NyxrmjZav5verntGltTcvrEoSLVgPeHWEITdm4/fjSXtSx3sHD4mgUgm/Z4YMfzCjDUjMY+ARodq8vdJbgQ2DSj+N0rfx/HVqZ96x8Xq2Rmb7jVQvZenrUe8o1G6/6hsTckE5sNVSy/yqTHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(56012099006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L33ZI2ZlOnz9jolTodQc+Hpds4p5NxKE9R6xqVL+I53gLl48Ky8S74oJuob1?=
 =?us-ascii?Q?FmnwDXVLW63qW2zaXRcKqLHEoGiBMggI+u5Vef2p5zuuBm//0qUjVJYT/8hD?=
 =?us-ascii?Q?cE3SNRlYenirZq36cuZL6QcgxNw8LX7ckdTNNv8dm9jqGtCSDclPJYvQ0Y8d?=
 =?us-ascii?Q?Etiy40J0S53Gsm1aK0Gzc4rV63IDThphvvsvMSnkMsBtok/rLq/XHFCF2ErS?=
 =?us-ascii?Q?yufQmJbEptp3dtVSWX7yStmYTOi1EisNpGTB9OpR/RVj7LoDi3g5hNA7jCFA?=
 =?us-ascii?Q?1/R57rA+poMYwJ8m5Cnlqz8xCSa/6KZGyNlpymcRa4r0VPILKCSqnmUDid87?=
 =?us-ascii?Q?/173fT4MdmtkJjJiP6kDBJcOufAQyOcVbCetp1zhsdtNApPgf1LvUZAgkpJX?=
 =?us-ascii?Q?Ba1H7aNZJBSCw2cgHMHoK6OzhLO8Nw1787Ti1un3yKNhYXVEI873XeBz7+23?=
 =?us-ascii?Q?hj3GRis57FbnFBMf599NEguLucvSXqJF0JTclmEAkW6MOwlW0kIdNvWpCRaA?=
 =?us-ascii?Q?bHQ5+t8A4HS1uuWThHVGncssKvDaB+le+SWde+QRiPjL/ZiR6KTwGdod6oWB?=
 =?us-ascii?Q?QLGN9glcwhCJcBAGeosemnPx5bvNCGC4iLDUmxf3KqElJT5KO+v7RNQrY/N8?=
 =?us-ascii?Q?CX2qkyjrxOfCr7CAnit7uAZiwictR5Rg2CPlOU8V2yLsTZqe/Wbff1tn79TE?=
 =?us-ascii?Q?I0rU+n0iDKYscCMvUSpABrIhtiNe6+KSFe/paouZJSOQmdZZfklDkjzkN++2?=
 =?us-ascii?Q?OhYTVFaHZcmIVUOlLGYkQk7E2LskW5L65oCsWTpBBrvYjhXt4aKuD2IQP7AK?=
 =?us-ascii?Q?UD2jZT5gHwkBEV98IZHQ2MDX9M2nFCcAYiiQJgNAt+AyfT0ILUtLALLbsbE2?=
 =?us-ascii?Q?YrB53SiQ/i2TqSwUOhrtPvxf2/EujoguARpMzC8wrky2sEjTM/McO3rU+0Tp?=
 =?us-ascii?Q?2UCXklAMdaC/PjDJY1405yZI61if4woeTSEUbksWVOG44EhsH3F9NA8Dbcwa?=
 =?us-ascii?Q?U/GMvAwshaog/+qLDKKGtQocupd9tPdqVP/cAT8H5iHLmKAdDRMmk8+WvbMw?=
 =?us-ascii?Q?P/kU+XDuj8SjjuXzx7jXAkt+DNgWTSGZ5qdmOm/ORVqh8/S6+BxEDah4RcEZ?=
 =?us-ascii?Q?lxPnruIxtpvMsx7ukCWljVaiK3XpTot6HVY86W0E8mspNI1qzelqNUU/eBGJ?=
 =?us-ascii?Q?YdV684iaNHeoFFnI7ojKhy0BZu5FCgJEFJt0nU83ljVw2j2FVgLEehUmy7qy?=
 =?us-ascii?Q?dY9xewBl1qgBNsGI/rc5hOKkZCKG69lxU5mpDYwVkkTqvzbVyG71ZY9WJ4d/?=
 =?us-ascii?Q?LT3KYLStQepdZrPb44CWARj6g5C0J4jgs4WGA2M2Fzty6hP46OiRuQTNvOGq?=
 =?us-ascii?Q?nky2QD35pnY7Sqfc4649IqqYcIAu0IyXSXt055GMLwTOtaTu3v2SUGWQ2Y+6?=
 =?us-ascii?Q?d5u98ElgiNvskTR+e0AIEUNGJJcxo9XY3KHfjJdmF3+XIcCPUczCAK9JZVTa?=
 =?us-ascii?Q?0DQW60baLUS7WOzdBJlwEWmLj7ASflxU3KvBkGQbO9PC9dR91kSfWfv4bZ1G?=
 =?us-ascii?Q?hE6bIhduvoIW0mMUapJe1EgP1y97i9vHHIG6uEMGFo5exaTIpt+eOhlLxzJw?=
 =?us-ascii?Q?O9ZKxZA9Fw0kEFzk+nrORvxMPDYSmCyoZyoo+1zZS69wcg3G49ZMHC1u8zKo?=
 =?us-ascii?Q?QsT4mp40Py5fxZt1j6fHsPQKRi+TcvnqZz0t8RFx1f9ttZXMV25ikkF374+a?=
 =?us-ascii?Q?hZ6YAD6SqDg8l4cs41PB9rIylom5fvs=3D?=
X-Exchange-RoutingPolicyChecked: UHenc4WT5KA+rz04+xyzngCTYSwuNd7vJBSgKY+QJcoSy9HMf1ba8GBx6tC/mzSk75GWqSMpnIl5yDjSgKtrsswyOxVxV0iXkHiSPRZ8PQS/p3W0/E4M+wTKXMP42Z4MK8U1rKawbY2XbvTExPQC6gJ8YwvBXGiySqM3tTSfeX8BcFOMil3fcEO/GY8ZHguImEHRGE23ggJPC28cZkX3dFwTXIJu++bgVQXtyAedMjAN0cFUzsyyyeofeJG7AK35tMRY4xfInyZ0HjDfxoF95Tg2+fzF974D0s7pkzYLr4TDUlkCyS6iNBtpcVGnwE/j4K7uX8BAtNNj5nzd+Dh24A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d98772a-a9b3-4696-fd5a-08ded90ac678
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:55:43.6951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKzE44T1iBU7bCIb2SMLvyx+MObi4MyOpSxJITAYOqIiflBK5KVUgdfLW7oq3hwkvU91w+pilD71EVYRjCW5P8i9SB6xfWRMvz+53s3cia0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB9016
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfXwxw6Pg8Bl30O
 Zzf9A3/fMgUzXtaC0gtL41HZlLcP+jCBLnkULvdIS6Ss7O8SuPuzuHTKuYQRm/ywybd3o6G/9WH
 y4SytRigLjrNfx103c1GrFIEO/AAvwU=
X-Proofpoint-ORIG-GUID: hw30g0b-nNcM6fEPmTTLjc1FJgKGL2DI
X-Proofpoint-GUID: hw30g0b-nNcM6fEPmTTLjc1FJgKGL2DI
X-Authority-Analysis: v=2.4 cv=ftLsol4f c=1 sm=1 tr=0 ts=6a47bf6a cx=c_pps
 a=uUOONCeAppmmVOxUvBiRog==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=Y-s1kumoAnAeZpE8ypgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEzNyBTYWx0ZWRfX7pEolOK/Rwwd
 K4aniznkRnshCiGXBIsl53O+j+sME5b/CUgUKHSh8uz8iH/jVkDr0kSB5Ot8+XRTW67uWBPHYtr
 whPlOZZPMACl84/eBbskGSuBX/8p6gNNT1PiUUSrj33JwNekr6xOXi1UWXkV2i3g3gm9cbMt/wr
 6VFfkomGzBbreoQwskhmjB5yH4xTTmWMv4ySagYfdJ2108a3TI6wlqJTatY2zSJHj/RBihqShaI
 jWH69/gpZ93JalvK7N/rDAKsyit3qb49p7lwN8Lgs6nODup1SwPTSG2KWkqkQogvVpsVpFfV0cD
 xX7OwdEjeypEh8ntPkQauLe/+7mXuqwUIqSrTG7EcPZlhlky87tlA4j39Hdim2fW+/u/rjL9V7G
 4Z1cPvUpVHNqDl9US4Ew2Z/AjiaS0r/KeKtapN03lv1QoOcNmchPtBj5l36ufsMKxZ0T6zpRGVy
 h3BJotDwPQs1v+q4uGA==
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


