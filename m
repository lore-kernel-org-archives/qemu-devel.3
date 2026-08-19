Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98896C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVp-00017g-1Y; Wed, 19 Aug 2026 09:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVn-000155-HG; Wed, 19 Aug 2026 09:39:23 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVl-0000nH-C5; Wed, 19 Aug 2026 09:39:23 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCp5iJ487892; Wed, 19 Aug 2026 06:39:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=SiDpM4QTJglC0h7XiSfXqgdhoPYdCYYfSo828oVc9
 GM=; b=xCE3lcREV+S+P6HO7k4GA1dT1kMgmmSnvqtmI02ox9i9jazSEJnXwQ4rF
 z8UH/4r93jBeIDal1v005Zc5RI2TJyy18x773Bu0ej1CWTWn56xMc+5zY4aHdjuj
 5N1tk9a8XBfX4fbjf0aT7gaPiquaE1quoDTWQhimx3wm6Wh871Qc/sddfrpZexI9
 koAdzPAEPJEW+2N5ui6P8RG8QEIA6G3+V/YP3rYubI64TZXNZUEBMuWrdVnltQpt
 4tdLaoPX9Xj9+OV3+eEcfq4DQAkSFTsrXi//j2xvqNMfIgpDu7Q6aFbYx8fmVU2o
 QIpfePoJeLdGWr/TpUAu3qLCKmxTA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020094.outbound.protection.outlook.com [52.101.85.94])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4vnf2jsk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcwaNGk+c/n6drzs8O2M1bcibhDFoKVwkWIfH7/TnPDob/1M1ygtukSIXsq5MafQxSwngGPPz/o7nVZeBNhfOWy/sDSdYQb9+ZHwgxLQjHxD2vd2mkqhW7hQsl7Mn6W4fMipTI9cQDvxyJimVF3lPk5EbEW4yLcwHfhIbJNct1dgVhJV9lR/ni3IGTiRMGumJCCJCRHO4PAXeOyyUGhhqQ16eRSak/BmkD/sjaSd/ZhQ70r5K1SfmCJzp0fpc54rhZxxtbz45tiJkhdP1UxOM38KxRj6CU7uRh0l5240ewi5lWqj88YbCc3PuCt2oVsZW3S+5h2/zjMDPrK+8RYmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiDpM4QTJglC0h7XiSfXqgdhoPYdCYYfSo828oVc9GM=;
 b=UBUBZEiaFuN694FcyWhuiJF1xh6xafqmxrQNP4vIFpMLRymHaaEfqqnIxmWHXM4iajdPYpEvnKrVYq9ix2qp0HwiWMzqQpFRB/DS09cDY3wqMbZdwALw9zlG2eGzwIgmTcCqt/rsnSNJ9NSWW38Cimee6Ia92nCymO2Qc38myrgBUPwfVpIvIiW847uLrQYL1v43VzQrKrVUyPROCQ+UzpOoGGpQFIgYQ6PHE7L1GuPWG8OApLPIkSy/oauS2SkCMYaQO8xhou/VbzVu1zFEw4dZ/xlzpdpJ5Xd0YPkBTd8UNK7W5e0Gv5kLE63HRzunuJymktG2xOKGSUMnxxa5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiDpM4QTJglC0h7XiSfXqgdhoPYdCYYfSo828oVc9GM=;
 b=kMwF/sUJUI8Q0oGxAUHxaylEWsrNQwmms7eFjI7tqlSWuHeKGHErDmiczhIVjmwruutosXgZGJs/9abGZfbryaKU6turggcOF7gJPoZqrOZD0MgTv/PG03A1cw3jyn0pVBjcqnrZh8FH7/a+M5NSZKgSOTr6aiNdAOC91r2SokJbpxCoqSqgOQ845LARx/9l+zEQ0+8e6xUY68+4fC8C9hdY0YvUQojR8gPmMxGXCqnwq82PMW7BZc7CF+x2TqwBqsAhlXLYxfn3kMlpwR+ee1bj4P1Cqg7FnHHiHlBcl4Q7aTQr7FTMOuMkBugWwmAPtnykOTQYtTbZSos3MSmXbQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7336.namprd02.prod.outlook.com (2603:10b6:510:d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:39:07 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:39:07 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 13/15] hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL from
 object prop to class prop
Date: Wed, 19 Aug 2026 14:35:52 +0100
Message-ID: <20260819133816.3497033-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:806:21::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 3962f496-1a23-45c7-ebaa-08defdf73e09
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|23010399003|921020|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CCGxv7I63z8NvqKGcCpY9iI9EeimVfC6FOVjKOd0hv0x/iMJmYO40DPk2YUouFB57ut3GI8j8f6V5CMdhz3CYqBGMwDvnPJ4u1MAXJnVbjfnJXOQH5lBsXwRjgBeL0EiOpzIiIFL02duOTzvGRp24e0DRRyrbyT7OLOxmsh4F+UTx0oN38DWt1QBrzNTODb0EWHuuM2sdlLpBFlZ284kVMDHx04uV09Rmj8kxVxEpTwvJrlqXm8fBLrj7mfa1v61GGzX7JnZdxs7svYDk737XeYxYhXP2gb9SdnFavzKfYq8ooE9xh1qPs8AchXPQ6tAc8SK+W68BA757qnHigaFeAmoJLrKOy+NyzWT6b3FmdeGxGLCPee0r7hmaUgypoiJCLfsIFdMoVYMBBFThveEoy8/AEf+DBg86UkGfcxZnGljVkp8/K+FiDmFunhcXxRO3mz3bf2H+rnYci047pQDAsdskn+DBXxbZA00pNO9VvUItJYeGfxkbGs+L1+YHV+RouzR86txrhkFICe6MkAbc8W1wsm5wQzuisSSBASCfBEMTFIk3lV68k6Z1ieh8TnHWKNFpvlAOrCGXWmc74kTZlR83Z2hC8W1shAXPdVxZ6/D8M79i1X3cSywdgZzAxOf1bTQunbrc+2Yr56i1rAU7SdjdMYnHIerNfzhVBLop0s21K9E2oDwsB91rhO9PPc0f9/LO9Im0t0Wk2rS03/KIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(23010399003)(921020)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YHD+/s8mEa7Tljp724uVpAIAd6yJD4FwKg7AkoLFxk34PrSKZ6PEr0gFfOUX?=
 =?us-ascii?Q?fm6Uxj0fVSEvR1DejPG49Z/3/YuAUXHTSGkmfj0mb/VQOlPVFYoIjfJfL54j?=
 =?us-ascii?Q?Wi/2lNF/bioubCj2I/hZS4uLEcEqBK0dNmX1AKAzRZCGOW+1Cr0uaj+CRPVd?=
 =?us-ascii?Q?szfgTsfT3ItpnJPgW8jyXSPiRzHsymeyecmtFaY8ihEBB2HRy+NyW24793c1?=
 =?us-ascii?Q?NiBt0DuRf+GNXRu3YJbcalC4F51fejlB7Eoxj0dYCyTI6hJwKZZtmk7Bl+mP?=
 =?us-ascii?Q?EBcX2lERHu9rW51ENqMIo6JLTsMaz6k8d/C+y9gD7LEiTFYOMjMy8k6Cc8Bc?=
 =?us-ascii?Q?Oe8QlUdD0Vtf4i739QeyVYhFTeFEC8aZGKRfLwXFTq0683f39dBiyF1XIjUL?=
 =?us-ascii?Q?YDyJk6FJzmfdZ87GAADAOgzsFIRluF80HGp+qwytp8JOW6Pb7cEN21f7o3YF?=
 =?us-ascii?Q?iaTfQaErIjVSViYh9j0aUXTa3XK++QsLnhR/mi3IpxNh4y0sJsGwX6bY1qa8?=
 =?us-ascii?Q?FLbyJkgHOJVT5pDi0fC299cAVxIWTfaJh1+T5B3LktqdltIcK2detN5HHIOa?=
 =?us-ascii?Q?hwKDCoIvJrLbEITSBy4JdiM/aC+tVhTrU8sjiN/u9tARTWdeDFVyCGQYWk4w?=
 =?us-ascii?Q?SuYAXWurq+lqy7y8lGjfCKo5CiGU37uWVuiZv6irgLtNoCCqs7RneePwKw+7?=
 =?us-ascii?Q?BtJS0FC+nAI0cSKpkF5imvHP+oZs5lVljIXcerKkxgpH/hFxkQIE9ujZSH/v?=
 =?us-ascii?Q?RMbBHmb+Lm+HHQfEF7boiszQZjkMtJI+/1To0uWUVOp+1amdax6JXGe/QrOt?=
 =?us-ascii?Q?GKHVz7PWnCzjw/Z1TRhgujkFJRUQplMigi1p5nA7UgCQE4DrFG+IzmQyeho/?=
 =?us-ascii?Q?eVZXsTvhZppbmgMwEUJL+tUHM+ZaV/dkcmxoZYSka8Es8b2iuuo7LG/LXJY/?=
 =?us-ascii?Q?o/Nd1HKU4AlSU7fmrWWZoRH2KQ7PWtjfFa5SXY8Mtc/J147Kuz56NC4J6CmK?=
 =?us-ascii?Q?ak6Sc7IISK0hCaxY5ZzB/0ZKUmEyg+oHZA8ku2O536dX4Tex7arEGxMv0clh?=
 =?us-ascii?Q?BuL6cyo85FKSHlVpahhOyMABXSwqeVZF4UOl0NNzOIbr8ygOuPMHMzE9pNMt?=
 =?us-ascii?Q?iPuLNcnoLOVD/nyS/bqomtErnkGgGPh5CQw3HECBiyTg4Rb6I/J5DT3LOOoe?=
 =?us-ascii?Q?AUr536r0W8oRjNz2rhUXOXgFJgI4VnDObsGYxSWvY1mcK3NGipJ7Uh3utLKc?=
 =?us-ascii?Q?l7AHplm78e2UEK9rcCTKUyH7ThVR7Qaf2fHi3Qw4prAi+dMxUoGsRWk3Bse7?=
 =?us-ascii?Q?7daU5DDwOazb7BrZW1SRRAQM7u9CmZMFFn3MSVb7cu+e7y/LRpc6Mq+sMcWJ?=
 =?us-ascii?Q?76Lx6RZwL0TchDpjIXUwhE+YdWpHIb4okRuwB6aSQlbcmHh1g564FmoEEZU8?=
 =?us-ascii?Q?1sHWBCQ4DafTXiHLuCg/ryXvwq5SDkiV/7paBplf4xRtwLJkTapF1zcWWDoq?=
 =?us-ascii?Q?r2yafhe47opHco0YttBuuN6qAG8CLCeugws6T9zKMXNG8HjaQgaaaK9NpeKJ?=
 =?us-ascii?Q?MzHhUntbt9wR5XW097dt1YXhAReinCqTALWggd2EbB09Fz3hgSGp0pHFNDFd?=
 =?us-ascii?Q?HFw4lvqYlXh0ohMlQfP8CNYV34M/96OYRRUQipsXJKWCPDEZlsb4Q+q30lvt?=
 =?us-ascii?Q?tf91vDc983TYHEmW+G5aOWaFRvvfJnixvxnjgyQ1qmW9ZP7QeK2xkLEg/muP?=
 =?us-ascii?Q?3ICFkqHEJMe3rHTZ7QmsajjCCyyOji0=3D?=
X-Exchange-RoutingPolicyChecked: D4Ws3jwvdwwMFaiL66z1XpJ3xQRgEDpIIjjCLvXWwkSv9KrWqaRAF/0EH+tN25gxEyZwYGvSafxMmlIf/2zN32wMSaPxme4GW3CfmW5RFu2P+pAPyu6GnNiQvbxuPa3V+Q7dQduHV4oRbrFRBXKMLYbWG4cbPrNB33C25EduMgqLhMM8VEudvQLH8wNYV/zBe8b2SQOJooxtch8J31j3CuucQnnnSp6f0sGHKPyEe1oL1Bnq5mLP9Q+p1kij/F3OJElxZgu89mMq8mj4fGfJDTGJQdUjTPR/Se20m2YPlqP6b8kw5kxKu29Dl4sy31ZyRy+nUMVIflV5YfGxern5zA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3962f496-1a23-45c7-ebaa-08defdf73e09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:39:07.5420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTVJ98Nax6HEBBehOEETCKwTXKzUNQM2NUuv24ujrivK089Tmxi/tFsEXil2W2UKzWoYeyBhp+/Jeb559JDuEE/DnbsmEXv7tfA5MDb9SQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7336
X-Proofpoint-ORIG-GUID: exFSzj0mJMWow2SJUkQDG6IkXcGkp2vy
X-Authority-Analysis: v=2.4 cv=OZGoyBTY c=1 sm=1 tr=0 ts=6a85b1fc cx=c_pps
 a=cLYCveKuP4lckQHSrQKrbQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=Yyzug1Ypeymz-iOESlgA:9
X-Proofpoint-GUID: exFSzj0mJMWow2SJUkQDG6IkXcGkp2vy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX2GKqTU+Hx6KU
 Uy3wha6/A/fFjqAKr/81D62una7vO2mknm21OtKiyoJB/NmbNxmx7I0ALjQP7q5vdASRB6sNibv
 mClqRqxKRlXAQBO4e8cLi31FhNR15bJh+26dpHy7DEDJpfV5FhnLKoEpYLWDnVo8T4qC61hhEY/
 JC1Ciu47zgR25MPzX+rHGyxubPE7+wAIA146ZGekuMY652MnMWUBTQ2NSPTa1/QSvtpI1we3QTU
 HVmOsMwOv/VQCXxIIvV6pO/GWG3FDI9vVf/KMt3wkx/KqdaKvnUwJrCRJ6SlRmX1gMoL8WMqvXy
 WqShEhF3rdCpW5sby8FdkWM5sQdWSTYbBHfO//CWO75AK68zGzXa0aEmCRtr32VUalIcepLERUf
 8d5o096jCApewFKC3zgXLMP9+M5uJK4AHQmIhzFh+UJRMAMINqzEzjfEiMgxdIq5Cg4UkC/i3Yw
 d0T+jQcczLgUoTfFVCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX6NK0MW+oHHFl
 B4JMA6fkU0LbYEAQgXu7Fqky2X64Rz2mUw+ntwNqxpsdpaJB2PhusXxy0R54r6DGWUwXAxwWtpZ
 +X8NRs2gWlFOwnfukemztMHvZAPYr00=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Move the ACPI_PCIHP_PROP_BSEL property to the PCIBus object and update all
callers accordingly.

Since the existing logic checks for the existence of the ACPI_PCIHP_PROP_BSEL
property to enable the relevant ACPI changes, set the type of the underlying
variable to uint32_t with a default value of UINT32_MAX indicating that the
property has not been set.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/pci/pci_bus.h |  2 ++
 hw/acpi/pci-bridge.c     |  9 ++++++++-
 hw/acpi/pcihp.c          | 30 ++++++++++++++----------------
 hw/arm/virt-acpi-build.c |  7 ++++++-
 hw/i386/acpi-build.c     |  7 ++++++-
 hw/pci/pci.c             |  7 +++++++
 6 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index c738446788..7ecb23d13c 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -56,6 +56,8 @@ struct PCIBus {
     int *irq_count;
 
     Notifier machine_done;
+
+    uint32_t acpi_pcihp_bsel_val;
 };
 
 static inline bool pci_bus_is_cxl(PCIBus *bus)
diff --git a/hw/acpi/pci-bridge.c b/hw/acpi/pci-bridge.c
index 394a919479..1bfc5431f2 100644
--- a/hw/acpi/pci-bridge.c
+++ b/hw/acpi/pci-bridge.c
@@ -23,6 +23,8 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
 
     if (!DEVICE(br)->hotplugged) {
         PCIBus *sec_bus = pci_bridge_get_sec_bus(br);
+        Error *local_err = NULL;
+        uint32_t bsel;
 
         build_append_pci_bus_devices(scope, sec_bus);
 
@@ -30,9 +32,14 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
          * generate hotplug slots descriptors if
          * bridge has ACPI PCI hotplug attached,
          */
-        if (object_property_find(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL)) {
+        bsel = object_property_get_uint(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL,
+                                        &local_err);
+
+        if (local_err == NULL && bsel != UINT32_MAX) {
             build_append_pcihp_slots(scope, sec_bus);
         }
+
+        error_free(local_err);
     }
 }
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index a91f523c93..b26ddf0a26 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -58,7 +58,7 @@ typedef struct AcpiPciHpFind {
 static int acpi_pcihp_get_bsel(PCIBus *bus)
 {
     Error *local_err = NULL;
-    uint64_t bsel = object_property_get_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
+    uint32_t bsel = object_property_get_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
                                              &local_err);
 
     if (local_err || bsel >= ACPI_PCIHP_MAX_HOTPLUG_BUS) {
@@ -78,18 +78,14 @@ typedef struct {
 static void *acpi_set_bsel(PCIBus *bus, void *opaque)
 {
     BSELInfo *info = opaque;
-    unsigned *bus_bsel;
     DeviceState *br = bus->qbus.parent;
     bool is_bridge = IS_PCI_BRIDGE(br);
 
     /* hotplugged bridges can't be described in ACPI ignore them */
     if (qbus_is_hotpluggable(BUS(bus))) {
         if (!is_bridge || (!br->hotplugged && info->has_bridge_hotplug)) {
-            bus_bsel = g_malloc(sizeof *bus_bsel);
-
-            *bus_bsel = info->bsel_alloc++;
-            object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
-                                           bus_bsel, OBJ_PROP_FLAG_READ);
+            object_property_set_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
+                                     info->bsel_alloc++, NULL);
         }
     }
 
@@ -730,14 +726,16 @@ bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus)
     /* If bus supports hotplug select it and notify about local events */
     bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
     if (bsel) {
-        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
-
-        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
-        aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
-                                     aml_int(1))); /* Device Check */
-        aml_append(method, aml_call2("DVNT", aml_name("PCID"),
-                                     aml_int(3))); /* Eject Request */
-        nr_notifiers++;
+        uint32_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
+
+        if (bsel_val != UINT32_MAX) {
+            aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
+            aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
+                                         aml_int(1))); /* Device Check */
+            aml_append(method, aml_call2("DVNT", aml_name("PCID"),
+                                         aml_int(3))); /* Eject Request */
+            nr_notifiers++;
+        }
     }
 
     /* Notify about child bus events in any case */
@@ -848,7 +846,7 @@ void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus)
     Aml *dev, *notify_method = NULL, *method;
     QObject *bsel = object_property_get_qobject(OBJECT(bus),
                         ACPI_PCIHP_PROP_BSEL, NULL);
-    uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
+    uint32_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
     qobject_unref(bsel);
 
     aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f6386088b6..7ba7b38773 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1207,6 +1207,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiTable table = { .sig = "DSDT", .rev = 2, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     Aml *pci0_scope;
+    Error *local_err = NULL;
+    uint32_t bsel;
 
     acpi_table_begin(&table, table_data);
     dsdt = init_aml_allocator();
@@ -1269,9 +1271,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     aml_append(pci0_scope, build_pci_bridge_edsm());
     build_append_pci_bus_devices(pci0_scope, vms->bus);
-    if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
+    bsel = object_property_get_uint(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL,
+                                    &local_err);
+    if (local_err == NULL && bsel != UINT32_MAX) {
         build_append_pcihp_slots(pci0_scope, vms->bus);
     }
+    error_free(local_err);
 
     if (vms->acpi_dev) {
         bool acpi_pcihp;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 8837b69687..cc0b6e5633 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1198,15 +1198,20 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     sb_scope = aml_scope("\\_SB");
     {
         Object *pci_host = acpi_get_i386_pci_host();
+        Error *local_err = NULL;
+        uint32_t bsel;
 
         if (pci_host) {
             PCIBus *pbus = PCI_HOST_BRIDGE(pci_host)->bus;
             Aml *ascope = aml_scope("PCI0");
             /* Scan all PCI buses. Generate tables to support hotplug. */
             build_append_pci_bus_devices(ascope, pbus);
-            if (object_property_find(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL)) {
+            bsel = object_property_get_uint(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL,
+                                            &local_err);
+            if (local_err == NULL && bsel != UINT32_MAX) {
                 build_append_pcihp_slots(ascope, pbus);
             }
+            error_free(local_err);
             aml_append(sb_scope, ascope);
         }
     }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e2..e8e8a3b767 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "hw/acpi/pcihp.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
@@ -187,6 +188,8 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
     bus->machine_done.notify = pcibus_machine_done;
     qemu_add_machine_init_done_notifier(&bus->machine_done);
 
+    bus->acpi_pcihp_bsel_val = UINT32_MAX;
+
     vmstate_register_any(NULL, &vmstate_pcibus, bus);
 }
 
@@ -302,6 +305,10 @@ static void pci_bus_class_init(ObjectClass *klass, const void *data)
     pbc->numa_node = pcibus_numa_node;
 
     fwgc->get_data = pci_bus_fw_cfg_gen_data;
+
+    object_class_property_add_uint32_ptr(klass, ACPI_PCIHP_PROP_BSEL,
+                                         offsetof(PCIBus, acpi_pcihp_bsel_val),
+                                         OBJ_PROP_FLAG_READWRITE);
 }
 
 static const TypeInfo pci_bus_info = {
-- 
2.43.0


