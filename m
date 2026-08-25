Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05C6C61DC4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrRj-0003nN-KU; Tue, 25 Aug 2026 09:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRh-0003lj-8p; Tue, 25 Aug 2026 09:44:09 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRf-0002WE-Cv; Tue, 25 Aug 2026 09:44:08 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PB1AlR1846113; Tue, 25 Aug 2026 06:43:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MM9UDKsVnqzKEDzeUWmgyorK1obeEKvFI8sHTw/LS
 iI=; b=Ptq1lhVABqxXsTI+ZKJ4rv010eA7zqdu6uZPLnvzL8qz+RvX0KiQ38eBe
 GhSU2vsTgkarpFXXTcSaLDHr1httP+336jKkBFaibOMK6pVohWV/PnFoq7uFIJtE
 LqFgXs2/xUjzxtrTZm9XE0ZsP0Z3EG5Y4srzPcnqGMzmZwWHB7pP7aZcMMxZzCpA
 S5zJ9WyjCv5SJLhXLgdA9J2IyDGwoaywIrTjm0edl2O0SgqZMbTY85CxvgnFaQ1I
 PaVeNaII5j2RNpnWNC3ySayyOSsItS6+zSUa0q+CHz64ZPAPJxtQ+HKORvBosN5x
 Yn6ZVCgCMlr/sONzt4k3frpQQfcYw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022135.outbound.protection.outlook.com
 [40.93.195.135])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g7baved8p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4xmvdBK//x/osR9Y2yaG1kHaOdyQ/He9nApKic3IY7CCPmdz4LD9dg2ULjttLsglQmb+stuLY2leGnT8GtEs/lf5fatkm92rfyiwLaG+8pJeXpo+Y5mdk7tSqoxZivL0ZCy1TVlzgkvHn8DGVYLb30jHDKfPbnCdkdlIC9VwjgV+nGUrwArzE5EWOaAMIsxpRq1tkBSe8kAIJhG+6hQTNqiJcc7iiodVU5giJisLj/T/GI/KYlLuk6lNssFXCrIPU+G4JjjGQuSYzcuvDPtlAfla58qNj9mF11FEtV//q4tFIef2jLudS66Pka3ByKzToTvWvWcS6jM9YF1uN7YVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MM9UDKsVnqzKEDzeUWmgyorK1obeEKvFI8sHTw/LSiI=;
 b=mb7ECQ0pUdTEGsunjxDawJGsOap25M/Hze17GzH63ZyNYM7goAwiSIegEMAwdwj6q2D3DHljbE5SlYvTQI3yrefsIK6t0lPbdtJX8F7uSihwNlI6qM4BfxwahYEEGmqiiPu+3/5O6Lh4PiN0VnYXI2hClP2jjvc9ni9xvgk8g2XI0NX1pcWGoeRtrqRP+cQhziEeMys8qWEoOCr9YA49CWfVsM64jlzlTuROjQzq1yzqLyDMkRUD2YqHY0oGmIxtN+4DiuSTSdgm3S8ttYdgwH887Lm/33pficFMZSWQKsMATWoa+76Pkt9vWpmmFWVyBtpI9xkIesw6RMoT2ahGlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MM9UDKsVnqzKEDzeUWmgyorK1obeEKvFI8sHTw/LSiI=;
 b=DQRrJ3DTyocsuY+C1z0Q8W4XoJc+nes37t8pBv7VzQFQTHUH7S7oTmPRGmV3Mye03vZHx+u2y3vkOowZR+fSfi/empRuZddJnbQHczrN8YvTexdHOUyUJLyXWHMNUHnEV4i3granMSjpK5e+FlRHLPNxr3l6r0IkmSY3PJD4828Aou4S8NvEWmJxPfzYr0CrfVkUYTYJ5KQOBMCf4zY58DrsWL3KSBjAZSS3e2Vjndqkrf26dqqqoV3cY8BpV+kf29ukjsYi3UCmaRpHHVj9tkpNzbTT6ocsmuH0VY0qvof29j6djruruC7aw3HBB9CqPoBRpdHj+lPsqrq+rv3Znw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7681.namprd02.prod.outlook.com (2603:10b6:303:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 13:43:51 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:43:51 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 09/16] hw/acpi/ich9.c: convert ACPI_PM_PROP_GPE0_BLK_LEN to
 a static class property
Date: Tue, 25 Aug 2026 14:41:30 +0100
Message-ID: <20260825134320.1039012-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0171.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d9e01d-b0b0-4415-9147-08df02aee5ed
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|921020|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: iJEqIhoMxlpQsGoKTHLH1FOzCHmw51IhOYhtYC+xBSq8yB/AzT/n+cLE/xJi0ZFf9xBt/GHxOg/rkkqRaiVZHjk/nt0l7Sq8JCUUQQ9La9Zk6flapM8wrZpG3kQ0lALNJgDr8FVcpDzVveE72E4BVm0x7kU+t482qnaWj+NeHObRAJ/Q7XbTcdywDjFrI/XgahMKUBbScy3kdOSuHD7bkPhEVElvCJJECDH7tWegiWwff1CI9vTNDoeEJ2JtmIO3+efjjaZzR4VQGmC/Q47P/O7PG7d8fwSWQ/9XTcG7CFYGXYGBWO4gPklcC25rJfAVb+weA+azfYlKVWOCAx71O73ggGMQVCKg203Uu5WSOc7qMBh45D9gE9qLZPjJjYGtMW2y78VLFkghpaxPvNcmqFtFA2Sevo0uT4lvoMK4ZHpJbTIaU0SQtUz3+cIsTuzUb4DCLTR/LXBF/ONj32vwPiGwW+7Ft/xPZcHolDeA4gPsthRu+iVbq33Jn9TE778YvRPWEIirMM4UYAaqmDZjC6hyr+KQ56J9hhq7odFZ61Q/JRbEuyRXJZt7lIT8rMDzvgXc2ZXoBnl3ZCo2sAlge8/Ei40KZfnUFvPZOeCiPUGEixqxkJqDw3hUVJvEz2PsxJAcdX4Gfn++/5UHtKpDohzeoro1Lk2TBVihCcqA7WpFOOIelsz3FDHoy4YmGNnOfFBJ+x6XtlgMj/j3rKVYCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(921020)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2Z3Ri91Y0Y4dlBjZ25pMGlWNmt0SUpzSGpCNE9XZTVvQVNYc29IVGZJYldx?=
 =?utf-8?B?M1A5Y003Sk1aWkxrbElMT2luSXkvcUI3MVRESVpTcE5jSnN1OVpZRlZKeCta?=
 =?utf-8?B?eWc2TnpFNXRqL3NLaGYyMXhCK0ovQ2JwditVdlpkS0FYT3VRTjYxZUNGU1pQ?=
 =?utf-8?B?NkFYMG9seDdvamhuR0pVZTJpVE4wdm1KR2gwZWRGb3diZTBvaEgrUnp3SHlV?=
 =?utf-8?B?ZFJGdUxaN3o3UHBmVFFHdXExTEFjVm1BdzVPWXZDVWtDcUZ6dEcybTFxd25m?=
 =?utf-8?B?YzRuUHZqMi9oMlNsU0dXMkJZYWhHejE0T1ZOMGlyTitSSDI1R3RCYTlIelYr?=
 =?utf-8?B?YmZrMXRMbzJTRGRpVVpoQ1ZnbUJndER4cVBvdWllTW5najdZVVh5bmg1Z0ht?=
 =?utf-8?B?eWVmN2hRWnBKMis3bHU2bXJQRHJzUXc2OWF6WWxySTBMNEpkNXNSSVlrMzZG?=
 =?utf-8?B?S2QwdXY2NUZGYkpmdUkvYnFaMGZnM1VtTnNTZXBYWW0zVEw0WDNCUytJSjBt?=
 =?utf-8?B?YllaRDRtYWdTak1wWXo5Qk00WG5YOTlKYzFEMHR2dEVwblRjOUcrQVZ3a3pC?=
 =?utf-8?B?Y0loMmZMUlhiNGlqTzZ1RVA3WXhsN3JjTE9wdXVwU0xVRlp1QktJdTAxaGc5?=
 =?utf-8?B?NERBY2oyaU1Ib3NkY0JaNjh0REVaWEFjUm45eVNaWFNuK05qWGlPV3g4dlN1?=
 =?utf-8?B?TGVubXpab2ZZRVVMWDBvOGFMSDNDeXVYbHUyd2c1ZGt4REdxdEhYMTZhVHN4?=
 =?utf-8?B?Yk5zQlBXMVo5RUc2ZDk3eEF2Rkp1MlhwVTVSenhMc0lVUkl0Q205VlV5WWYz?=
 =?utf-8?B?QzFMaFB0NjRBNEJaMTlVbXY3dWx2ZllYMGdHOWxBS0pDRmFIRmQ0dklTS3lC?=
 =?utf-8?B?cStlME9EOU14ZzhQa2dTQktRdC9udkdod08rQWhyOVprTTFveFBvUFJMQ3lj?=
 =?utf-8?B?Q0Y1NXNibzNNVFVINnpIbEExQzFNOVY1NVAwakZ0cmRQd05GWFViUjh0eFAz?=
 =?utf-8?B?UHE2cWszZFZ1S20vb05uR3B3SDNES1hHSy8yZFQ2azVSNWlIcWFscWpOendR?=
 =?utf-8?B?TVpCR2pPYjd5b05FUkdhUHVnSGZxbE9MYzBURlhrdVFBT1FtRUhwMHVYOWZE?=
 =?utf-8?B?Y0lrZzRQOTJEZVVob0xSaUJCOUg2QmhlTC9kK0tQVzZ1N2U1NEs4VGdCWFcv?=
 =?utf-8?B?L2FoUUs2cGRnVVRmMzh6Ulp6OTFTTWxOZkZoRldtSFZrVk9WeUg5ZkxjMmpT?=
 =?utf-8?B?QzM4dDh0SkZqUnM0YmtVUFRydWMvaEtmL1g1N1JvWUNCaFlVZ0MxekdoSDYz?=
 =?utf-8?B?RE5FOEdsaHJsYWxzaFFBUXIzVGQ4UTg4dGxrQ243NGc5d09JcGcyVWJQWUI5?=
 =?utf-8?B?YmVXZklqSHVpbFRzUEZmTGJwUmtkOE1wT0x3bVEwcHFlSXVyVDNnVUtoNzJJ?=
 =?utf-8?B?b2xsc21HVUYrclpOMC96WE9zMlMremZLMHFxQll3Vm40TWNtOWZCcFhsanJq?=
 =?utf-8?B?NE5pV0F0b0RqU09WS0kxVHN3Sjk0WnFNM213cTNVQWM4VnVCQ29LZzRTQzFZ?=
 =?utf-8?B?bWNPeU9ONVJaWEtaYVJpd3hPQlRMRE90RTEzaGp3RWtSRFN4dzBGZWI0VFFS?=
 =?utf-8?B?ak8yM0pFbFF1VndlVjVxYUg4aUNpZ1JwYWNUbExGa0x1V252VXVOKzZ3dlcw?=
 =?utf-8?B?RjAvcEJ2bndzMmNVZGRjN1BSWHhCU3cwK2RhOUVEU3czYUFDaFJuUjBISDdE?=
 =?utf-8?B?TkpKK0hJSGRBN3dDWldlZXU4NjdIOStDdzk2Zy9CSmlwamNvdXQxT3ZudDA1?=
 =?utf-8?B?Y1dLZFJDME04N2U4MVZyem5sQk85SnNoSGorZG5OZFNORGNweDNnQktSOEUy?=
 =?utf-8?B?OGhIT3dQclc0Y0NqcC9WelZQZTdwK2RZRENBVDRIODFQMFN5WllObG8wbXRG?=
 =?utf-8?B?ZGdXWmg1U1czTnYzMzRMck1NR3JBSkh6N2E3ZVVoTTdWaEhDSXNwUjNjS2N4?=
 =?utf-8?B?RUtJaEZLVGFKQ0xHNVVvcDlta0NZZythR2poNzVVK2R1ak9pVUlZQ1NXMXFC?=
 =?utf-8?B?eGxDVjF6YXpjekNwN1dzdHhSekRmVndNSkNldld3cEZqT3JWaXBHbWVXVnUr?=
 =?utf-8?B?RVY3NHpjaURpRVg3Y3FUR3NHbE9VcDQ3b1M5bEhqV0FrZXEzeU9ONnoxTmh2?=
 =?utf-8?B?bDlScm1lREpUTVFmdWNKK0FucytXenAxQVdUZU5ja3NBcytMa2xDUzB4U3hX?=
 =?utf-8?B?c1NKVThSYjZlRnJ6RXlodk5WcGNDd3ZCWllGbWFFcXhuNUVhZ05KMFA2ZWdE?=
 =?utf-8?B?VUpkZFBIZ3JzQ3VBSklpNGRoNE9ORkdxcjlZcGYyT1pvNitqaTVEd0trMFFm?=
 =?utf-8?Q?m4BknzuO35pSgMBI=3D?=
X-Exchange-RoutingPolicyChecked: ffm09ULEnCApNenTgvIOKhebpGu6wAopdmOejtT6lzI76Y/r/oAQ8fIpgRegHxeZFWXVQNmbVUpC//Gao/SHpOgnPgKPy+jmMqOixdFCXLNMU220CDcH4640NOwfq3mWYDRObtTQlya+OMreZcdt53s10I0MmMB9kU1DTorvfSZ4H747F6qD9uJjwtjZkv67iEjlJbodwWHEjcIcVrYOnOtwbry/ego6ub8lY4u6dCIRleOuDiwxmGC80DbumLo5MS8wf/rVZFAfy7yuBVXAkm01D3boEFa5mr+CWOCcX9ZHaIzj9vN8Pca3EIHkutot4bN5PhDjmvtR7Lxn3v94fg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d9e01d-b0b0-4415-9147-08df02aee5ed
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:43:51.6785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ebgseoSMtPWDng30KANFilVg/gCjVxFqjX9cbcmZgKNaOCwdx5brwc9NXX1DBn6OuDNinyrlpHdpLsiNcuY6UiYRgm9c+OtXRgI1iNyPd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7681
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX9ux2x/tQzvSV
 0qholB75ANWvWZuiYv/u+Ef6zzoT9t4UxJqR+Q60Tj+QqLxt/ikse+vGKfQZ78XB3kkjFLc6Owm
 pGt+p+ich5kWEWMH9jwdGajWPmiToFE=
X-Authority-Analysis: v=2.4 cv=aJvAb79m c=1 sm=1 tr=0 ts=6a8d9c1a cx=c_pps
 a=j8jEPmhjjLnYR6B6k97zMQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=_dIhvDIfpQVvNhxktcwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: KKSI7XVRVVAADKn5AZok2ksIGOcTNMgh
X-Proofpoint-ORIG-GUID: KKSI7XVRVVAADKn5AZok2ksIGOcTNMgh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfXxAqVRjFbZLsJ
 km/RTHUyedvHiKm7RhymJEQZucywygOF80dSfv+jkARNC935ds8ly4QIfclVUUEKHei957s3CM4
 f2hoVJo8tAI81wldw5xfeFWGq/XV1gdVYqalIYA6sJxEXB3RPtfjnV7MvTcGOz8AbmFljSLoHat
 Mod+A85C8nL2XmgyTNH1fMDp2bg57hpczVZqMZRBnHpoWQanmdnoh+4AXnwSvSDELCLOLlM7qCI
 JAEGtNKbZlRZO4JY11J/OlLVKuIW9AfWqATKFZOwyWmOQFcwla1pEJga9f3EUtjUeH2UL20OWji
 9z1/x+EgUewN0TX9IWMsSGA+6MynDFnx7EwtZdoBjF6SYkgkMhlFPYO+NnRFRGvsEat0lTz4qaP
 BO00R8FEngsCXxxt8VZnb9oxScJ5HqoAsSV5ioDJbMRwQNDlsVj/xnZTI54ihPLEu0+vuMom0Oa
 kMMFK5IwVYmHjPIfQgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

The ACPI_PM_PROP_GPE0_BLK_LEN property is assigned to a static variable and so
can be converted to a static class property. Introduce
ich9_pm_add_class_properties() to hold the ACPI_PM_PROP_GPE0_BLK_LEN property
and soon all other class props after they have been converted from object props.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/acpi/ich9.h |  1 +
 hw/acpi/ich9.c         | 14 ++++++++++----
 hw/isa/lpc_ich9.c      |  2 ++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/hw/acpi/ich9.h b/include/hw/acpi/ich9.h
index 30990fcef5..3fb993bb9e 100644
--- a/include/hw/acpi/ich9.h
+++ b/include/hw/acpi/ich9.h
@@ -84,6 +84,7 @@ extern const VMStateDescription vmstate_ich9_pm;
 void ich9_pm_reset_properties(ICH9LPCPMRegs *pm);
 
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm);
+void ich9_pm_add_class_properties(ObjectClass *oc);
 
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp);
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index ac3f452dc3..774b34195f 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -402,8 +402,6 @@ void ich9_pm_reset_properties(ICH9LPCPMRegs *pm)
 
 void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
 {
-    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
-
     object_property_add_uint32_ptr(obj, ACPI_PM_PROP_PM_IO_BASE,
                                    &pm->pm_io_base, OBJ_PROP_FLAG_READ);
     object_property_add_link(obj, "bus", TYPE_PCI_BUS,
@@ -413,8 +411,6 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
     object_property_add(obj, ACPI_PM_PROP_GPE0_BLK, "uint32",
                         ich9_pm_get_gpe0_blk,
                         NULL, NULL, NULL);
-    object_property_add_uint32_ptr(obj, ACPI_PM_PROP_GPE0_BLK_LEN,
-                                   &gpe0_len, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S3_DISABLED,
                                   &pm->disable_s3, OBJ_PROP_FLAG_READWRITE);
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_S4_DISABLED,
@@ -432,6 +428,16 @@ void ich9_pm_add_properties(Object *obj, ICH9LPCPMRegs *pm)
                              ich9_pm_set_keep_pci_slot_hpc);
 }
 
+void ich9_pm_add_class_properties(ObjectClass *oc)
+{
+    static const uint32_t gpe0_len = ICH9_PMIO_GPE0_LEN;
+
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK_LEN,
+                                                &gpe0_len,
+                                                OBJ_PROP_FLAG_READ);
+}
+
 void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                                 Error **errp)
 {
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 07c9509cf4..d3f1358887 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -919,6 +919,8 @@ static void ich9_lpc_class_init(ObjectClass *klass, const void *data)
                                                ACPI_PM_PROP_ACPI_DISABLE_CMD,
                                                &acpi_disable_cmd,
                                                OBJ_PROP_FLAG_READ);
+
+    ich9_pm_add_class_properties(klass);
 }
 
 static const TypeInfo ich9_lpc_info = {
-- 
2.43.0


