Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0D2C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVj-00011p-6U; Wed, 19 Aug 2026 09:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVh-00010h-7b; Wed, 19 Aug 2026 09:39:17 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVf-0000mQ-IF; Wed, 19 Aug 2026 09:39:16 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCmNn3511185; Wed, 19 Aug 2026 06:39:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PFLgcqblYE34mky/9+xEnBlNwaij+/XFvFpo6PBuV
 2k=; b=RDlHIaa24aGFz9YSxixFeQdZxbqP4PTvsoTxHAEi5GJjrwOuyJtGGi6JR
 xtywymMZqM1OVw/K/a2/HofRuCXyWCsr9lu4vHfucMm1zuZPRzOEqIbCG1wgY1dx
 beejbuCMvO8monEC55VZAA+i/hkq/Wd6Zw5iLfMelW4/s9C3dpu3IgVK31n+nbpQ
 5X8WVD3r7RMflAtYh6HxKAVsOI0XZcjZbzz6eLSjcd/Yhds8npCacH34RuIhusfX
 GpD6ZcCoUI/s8uGIvBlAfXRKfn4BgR7tT+hOJ5xEYQ1yyMTnk7TTlC9RdEb3OP9/
 q6iOVk0pK0uphJGuosYV+M+MxwI9w==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020098.outbound.protection.outlook.com [52.101.56.98])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4wgrtc93-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QurbYSWI9067FB79wTUzxecfaNumFQTm92ZDNxo9uYb/mOxqlUL5jEflEXW0VbJ7OR4AlZm03qnLY2oOQ3xUIWP2GHx57mdwsjZbgsXbylddOyltuVCx6Jka/lsDQsOKVa0kQqBUM+nyu7udVo3gdMQEUqKOtVMkGjhcM3170Q4qxjtbh2T/us66j5JLPVXFIS4MmFzMrGAoCicH68P6shE/6pAIJ8alPUexsKDwK7iOEj0/sTKHJTuSiFOlm2XmZB/lAmwpmnPX7tvXeyA6Ekqttz+gseZ2hisFdy65lBlPk+wYVSK7Ie5MoMcLAC487xX9PxmpxxQC2iKTZbWL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFLgcqblYE34mky/9+xEnBlNwaij+/XFvFpo6PBuV2k=;
 b=b+SKwoFhQBs9n4KByYfKYmcYWcxIqckQi4qz8IOiGigWrD5gizVEngDoZ/N9/T8FIyIhWP+xGT5Uv2Oc1NbyM6U8uuEo2XaiH6FvW5eJK2sbem3SQCW/971bnNSSPaoI/4E2dwknJ2ss+00NwmXoitTZj6LOMD64FTxsv0+rOK1nFhaZOucRlqD81ias+kQ9jg2zO0wlNW96vxs1JbLscuj3/Y4QnR772/CN7BpChDeS4ANA90iikgI8UdC2P1uWo2WolatsSR8dUrwju81Yj461VAnRHbF6HSxZ4zJ70i+8hxCbScgE+ZX8mAjPE/bFTCdK9jQoTufv3V5BEH6uvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFLgcqblYE34mky/9+xEnBlNwaij+/XFvFpo6PBuV2k=;
 b=tDLWl99fel9lGvh9kvjwMSFb9xJP9GAaS25xU70iv3bEYB41qrFWaNWbJMINmagVzwNGpBj1mMg+wsnglui0ap1mlWFTwRMzrSn42C+k6gEwnjat97ulZIPtwCxXWxF1KYvJL0vqlIEtg3/gxm1hnjRVch0GnuiiovbLLTNkKpOT0J3HdzNZuofDYMwFS9ZohdCzaE12QvxxvADSH0SBEiXFqnxafNtBMOU5DaupWehfE4Y6K8qlYyE4uCTayDSJyaUg9H/Zu7VwVRQ9Ch8RK3B8hSD10t1Bl2m5gWq7HN43MZZOeRXwP24mudYc2KYwUaRg3QX9onLvPer+/wDS/w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:39:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:39:04 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 12/15] hw/acpi/pcihp.c: convert ACPI_PCIHP_IO_BASE_PROP and
 ACPI_PCIHP_IO_BASE_PROP to class props
Date: Wed, 19 Aug 2026 14:35:51 +0100
Message-ID: <20260819133816.3497033-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:806:20::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb15e68-77c9-451a-f94d-08defdf73c05
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6nhPtFxbA6hUbKBhvbJk1IvuL8kZfrGlyFG4aFYaEyyrYzAlOBIZlMLQQHmW8FWpKVJwp8EG9MwvWTclpLAry/r3tN0iHKpXPsgjPWN/frjRZeg0UZj1B5ZNc0SWY7gip+EuPho3brsjTl+ZoC0jUyaFHG4XODa1wP4TC6W/ZPPcuYakRGqpBStOMTTm7W2PBNSXGJKDAXPk42k4Gm7dY8eO9+KYuzOO1nwOactiJLWTrK4Q1MdH7x6Zra07vWSl4KRt4I5X5xKiF2XV4z0iy6PfOOA6M0uoPVlL8j4Z7zTzQjilmdDIrU3iTpNgjEr9z9qdfkBgjv9TlILlmPCpJW4fCk+I+UGF8IOYW1IQLqNl8JL7hdcJtfFQjhJPVtBshRuT8leOJ/dssdBKO/+EQ5LVpEk9CREwg2Lin6Op1nBtmbVGwgO9VXFgj+bGB44S+lCDncIjdl+At6z3OxSUZOuqmghNJ9FGwe6/wV9W/RJR0bF9eEgGTlz1WMVn+eC9y+Mh9iF6RJoEqz3cBPQHLiSr9tO/ZfPh+xEKNudkcSZYNTpwBiJ4JS7YFV7e2q381ETnmCbuXfd9POhI5WBCLaa93PgxSwh9UqWtQ2GDB5QxM6So/Vi56cuU3NFZPskrnCRwekR8zda4al3RNCwnMFllFVmEcsVMQHbok7bPE4fNhlpWzNgryY7lJuMqfQmqvAuC3Mov/UI3/CdDDyWm+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7fWaClBZHmz/BjR9jmHeSVvSizeue7OMJNcZ2SHpdTDRPSaEGaDd6mjO/zrl?=
 =?us-ascii?Q?U0S/9DB2ifBbrzBprrYUGB0CR+vW5KzxOF4FiCHcSHvRrICnUmHRwPpiIuLF?=
 =?us-ascii?Q?AKBL6n0M328rP3KcohpkMBWby0A04q3STBVeMA4ZtiiULjVEJCLnZXax5f9g?=
 =?us-ascii?Q?7YWdcXwn87BBRhQf33FOzSopIb8/ssJpGhNeWJpQkCQBSjGTSavaVEwaWQSM?=
 =?us-ascii?Q?kk7Xd0TlEeEYuea84nqqcxfBvk4Jl6Mmk2zDjMqhGtGZcpxe1hPFTjE2xOQz?=
 =?us-ascii?Q?5DQ5VPCA4dXDFzSdWyZXNBaZPWdOFfK37GCXttkyYg8Yf3OF0ijri1sZdx/X?=
 =?us-ascii?Q?b9uJNjplHoA5K5CvtAWYU7h2ZjgsP8yoByRk0iMvhClJPVY09U5qzlqVHW33?=
 =?us-ascii?Q?XDdyPm5YBNiDWBlOYhysINMU6MQrpF2Ec9vuc4Z6A/vZhm4A9orJcmQn3uU4?=
 =?us-ascii?Q?/CiaYkQBG2VUud/NAbId+1fwdkK4urx8uDSjXNy1WzHYgaMZc+g/Sjm/Gyqx?=
 =?us-ascii?Q?yk7sqVtgrRDzJJbsNWXJS9qwmTwUtbJxB4A/HiKDebM/6n2MeGs4fLGqJ+L3?=
 =?us-ascii?Q?lX1IYt+vJUuPqnC9AnpIgf0mnAI/2XIgZZBUATMYtp8hsinjd0k/6t7s2NO7?=
 =?us-ascii?Q?S8T217M5pqPexVdLhAsvWN7GEYQq33aozsW/izuMJTfhnPqHDhDnw5cKq+3s?=
 =?us-ascii?Q?wa10CtNwu57drlBBZWeqYA8SEeEuOkI6j/zHJir82xJtBCOBCwvf1A75Wfk0?=
 =?us-ascii?Q?8nKs58jiUrWIfguXDPa0ToIFzWaK/HmL6RO9x77C4aXywVri0oQyXKZEsHmm?=
 =?us-ascii?Q?YXNfPgbQ2juk6jJu2Z90UxHytY0K4qkd2zGd0FHxTs7CEfyEEOLk81g8Yojr?=
 =?us-ascii?Q?LHLQzKSw8Tx4L9Bjqox/RgJL6uBw+nNuXgHo0E3vKIkMB7xvg7y+7bVf75T6?=
 =?us-ascii?Q?pPg/PNF/Wam3qMQNMNmzGeV2IZyABtljLl1keUi/7Xy5rBnaC9GMvQCFUZ1x?=
 =?us-ascii?Q?wnAztM1Go177+VJzUVszoIi8paHBWc2lpRuxiCScyt+UffLQ5NwX4CdqEsir?=
 =?us-ascii?Q?a2/wwtvByllVDOAOT7BMn71v92NoQ8Hs+TihDpeTQ3LovNdD/zMweupVnU/l?=
 =?us-ascii?Q?PMrfNGXavaetydpFKPsKVh+1wEMNUXK9QWx1WR4g/c/ec8fF6moCPfEkhwxC?=
 =?us-ascii?Q?wnUh4U83u9ov7edN5eudxPoMqbuBFWqlbUDxD9PVkuWmjQ5MFEkrYXrknhpw?=
 =?us-ascii?Q?gvqII/IgJFXLAUeZRGj5cUt0t2FN0zZoltn1QTcKxKMmsQGbpegPzF6a07z0?=
 =?us-ascii?Q?hZX7knHZXl5eiR0FjyB0X4i6IXOYlAvPuf4EWTZUyqhvXsTWubamRLAg2gzi?=
 =?us-ascii?Q?ty6HzHco2UKdlaHyoozjfxrsVSxUFoQfS8XsOTRXwbS9qRllfiXfh7Yx2+w1?=
 =?us-ascii?Q?n7Ch0CgC5dYDEtjgFk6bTdvDC/dzygdrq3OXwKBruPXN/0km7kqi+zkp1/CJ?=
 =?us-ascii?Q?iF/xWlFdGtCoHrgdsN1NiAQju0fJ7l9trlZxY2HDZKAZ8ejk0lHHF2cIr3uk?=
 =?us-ascii?Q?Z6uwDArHO8Ue6pi9V88NQ4OTi6x0qeulXgvvkChuIcgzYouxAdfCwUHvtchd?=
 =?us-ascii?Q?cftTtO+4qVUHAKBeOhgiJdKGmdFob5Ep/GKk1Yt/cs2x7EEAkJ3p7vvfYHbq?=
 =?us-ascii?Q?b0KzDGhUfmP5xU2WCfDgkh2ymeNY3C3wm+Kz+dpMt0r32dUNL0Wa7/5ojxwt?=
 =?us-ascii?Q?SInpsACw2UQcsb+HsKKZ5Tr3RR+RbEE=3D?=
X-Exchange-RoutingPolicyChecked: Fp+Pl4SpG0OiRJ++n24pKRgfUsh9vxg/WH/RhzVG3lqyxJBkXm3LVlf+BxpdzCMgZkdxrw1tgpsYn4cOq5p6gNuLA3ljj+LMOwH4AQSnrKKkvaGkpuCrFNAFlhMIRvj6Rp0IPb+K9jACl1rAJ4aYEQSAn+w2SVO9rBZQiAsQVGoUxF8tv3WVEG72W5l7774B2wWTSI3Wn97UgE20s3lTiPfzk+Muh8s6g75r0iHDRcL/bQSFsNOQJzdHSAeSKNSd1FeM5F6hqVOv0GSYA1Ov1wLEZXS5CLZquhmaus6l461c/qgv7H/t4df9WdBxjqJhnL7zlvpJk3cwQaKUw1dUZA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb15e68-77c9-451a-f94d-08defdf73c05
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:39:04.1577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sk9d6ZQYqcNFSndx5YTc4oyKQy1irMmAIDtxboi8OhGdGFU+as9WA/O1gPNA6cERZwyf6vmVZkq07FWxNp+sqZWMWb9QS4l9sdBBCTfps4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7336
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX5uk0NHZLhTim
 u4CN4jmNChL5hoxCtBDC51hubMPiXDEird5YLUN/X5+UyuIcynBVQSBkUrARa/dzYes9DJwJrzp
 2XETWPGFBFb8nU/llIKID2ev1sl8A92qqZPIESxFQAL5b2EEDeJHmUqE5j+uHTM8ry/E9f8ExOg
 5PNP/5++8cEuJgGh4259PIaXW8BLiPtfD6Y1ONCbkPKNhtQpMaYcj88rJDytSPuthXkNCOfAuCq
 74Spy2hSjv/cs9/m5s0EVWcPh47nnXSVuOCFQqPcc6Dj/OASRufWwGNXe/KIrcrhN9i0ntNf0sA
 PEj0Yexeghp6DS59oKT/7PoJM8W1rVjVTAgtgWHvCDNsqMaxrRxq8Z6nyCZUPk8lkqWlK+vmjFA
 kiMPXv3cUtzsZLO2i81rr/F47jjiZJFQMccFi6zPS5aAkIJm/5G0O/jLiI+T31iaV243aXI6pUg
 LxCmnwWOXbIdst8pZ0Q==
X-Proofpoint-GUID: ePUk-pLDiyw3Bpx8K78jou15YdJlxYZL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfXxsnv046lnhTI
 9tRElhdCqVBS0Njqau5xuzko9ds87EKCdm5Uk7cxJkZlovNlJJwSbDV8hmhd08xuLQmVUrAPsH9
 JsZk0I6M5+vjVoKBg2+4Eod2OvhrTrw=
X-Proofpoint-ORIG-GUID: ePUk-pLDiyw3Bpx8K78jou15YdJlxYZL
X-Authority-Analysis: v=2.4 cv=CcY4Irrl c=1 sm=1 tr=0 ts=6a85b1f9 cx=c_pps
 a=+sLJoloK99bVPEAi26XZpw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=pnBmNuUOYQARQnUSyu0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

Since the objects referenced by acpi_pcihp_init() do not inherit from a common
class, add ACPI_PCIHP_IO_BASE_PROP and ACPI_PCIHP_IO_BASE_PROP class properties
to each referenced object and remove the object properties manually added in
acpi_pcihp_init().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/acpi/generic_event_device.c | 10 ++++++++++
 hw/acpi/ich9.c                 | 10 ++++++++++
 hw/acpi/pcihp.c                |  5 -----
 hw/acpi/piix4.c                |  9 +++++++++
 4 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 9e9416d406..67c9e9b3e8 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/acpi/cpu.h"
@@ -608,6 +609,15 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
 
     adevc->ospm_status = acpi_ged_ospm_status;
     adevc->send_event = acpi_ged_send_event;
+
+    object_class_property_add_uint16_ptr(class, ACPI_PCIHP_IO_BASE_PROP,
+                                         offsetof(AcpiGedState,
+                                                  pcihp_state.io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(class, ACPI_PCIHP_IO_LEN_PROP,
+                                         offsetof(AcpiGedState,
+                                                  pcihp_state.io_len),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static const TypeInfo acpi_ged_info = {
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 4aa8d36f54..e3d526ce57 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -409,6 +409,16 @@ void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset)
                                        offsetof(ICH9LPCPMRegs,
                                                 keep_pci_slot_hpc),
                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_uint16_ptr(oc, ACPI_PCIHP_IO_BASE_PROP,
+                               pm_offset +
+                               offsetof(ICH9LPCPMRegs,
+                                   acpi_pci_hotplug.io_base),
+                               OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(oc, ACPI_PCIHP_IO_LEN_PROP,
+                               pm_offset +
+                               offsetof(ICH9LPCPMRegs,
+                                   acpi_pci_hotplug.io_len),
+                               OBJ_PROP_FLAG_READ);
 }
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 87162ff2c0..a91f523c93 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -502,11 +502,6 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s,
     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
                           "acpi-pci-hotplug", s->io_len);
     memory_region_add_subregion(io, s->io_base, &s->io);
-
-    object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_BASE_PROP, &s->io_base,
-                                   OBJ_PROP_FLAG_READ);
-    object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_LEN_PROP, &s->io_len,
-                                   OBJ_PROP_FLAG_READ);
 }
 
 void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar)
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 9b7f50c7af..1d209ac96d 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -607,6 +607,15 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
     hc->is_hotpluggable_bus = piix4_is_hotpluggable_bus;
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
+
+    object_class_property_add_uint16_ptr(klass, ACPI_PCIHP_IO_BASE_PROP,
+                                         offsetof(PIIX4PMState,
+                                                  acpi_pci_hotplug.io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(klass, ACPI_PCIHP_IO_LEN_PROP,
+                                         offsetof(PIIX4PMState,
+                                                  acpi_pci_hotplug.io_len),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static const TypeInfo piix4_pm_info = {
-- 
2.43.0


