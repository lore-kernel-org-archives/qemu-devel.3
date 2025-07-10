Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DF6C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 15:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZtJX-0003UZ-BL; Thu, 10 Jul 2025 11:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZtCv-0007Ra-0E
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:29:09 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZtCr-00030g-Qh
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 11:29:08 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A8fBKH019076;
 Thu, 10 Jul 2025 08:28:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ibixGdvDCGtgXrijVRkVOsKDA9cgQVdBGRlYO1GhZ
 Ug=; b=pFhgnAsFooNfjEdOt/wZwgR5AsgrtPPLP8Jd+WlHpXlcu54lqzWLMAL1v
 yHMogf6ua7QHB7Ewxk/+K9JhhSunF7I2O6HCyKCYtyQUu5H4Tn+Ml4QVPvONouJr
 Uxv6udMd58NkTkuV5MFVaEG0eG/5Q9XoIu1bII42/vcUIIxeLy9j/+1so4sLEGVU
 tEI/TQtrp2Fircsumo/r6yMXRlyPDX1bh2a/dEMKs4K1vJBSGnEnzlo+61Cyl2CX
 bKLbUyEtkcU0B4paYoaSdosAa17YfVWha37fv5jcfzPFn+kiopICt8qZygK8mdbj
 2BuMOWTYcWEr/tSdGulKGIq+ahiIQ==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2101.outbound.protection.outlook.com [40.107.96.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3k36cgh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jul 2025 08:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDNQcCOiTz++0evWU+fhrir1ORFcUSkcMnBM41nsj9u4ZK3+4DWrQB2iNm1HUThL1ciRVoTnW7Z32sEySP/jEsZl3Lykk/8HfKabj42m5SgXtymlJbrIdLMHLAtgVVVBz1k0+7+LtaCxOCoq36a5O8tzFKj1sruo7P2nuLWluAvb00NdmtGZTt/ZKJkRDNX5MaCCLlfJlRFnX7alhiJUU0TcDcRbeZqRvVErhIE7dzrjCKLBBW2+NyuBMmc3NfCUY1GzVjPa+U2ChLPsu750nSwPAKDSrK+zNPWXRC7ivTa/BaWlTyBWYItE335BJPLFQoFQUOBSPeY4+PsVm00EKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibixGdvDCGtgXrijVRkVOsKDA9cgQVdBGRlYO1GhZUg=;
 b=XdWytTApijkAZ7s0KmJiH7usP68vJq0bGcikG35DqCXTIP6iCoL1jFqZUTAO2SwLTjwVJEvSjzx0925pY7rxoAsuN09Se7LiMAYinbVjaEgpk9OTYoI7zVBtSq/JtaEpxgtV11Hf+Z9dGu/eGEq6qJ12PXg6gpeyW/XgOW10HeqjQc7+LeDhpfYV/GhNSRTHFI69xdhx+hDbsrOWYaQweh8jI9vHwNJnS8Y26zySbSmWqiv2qZX0vEQgdsGESX/+EakdYpDy+uJV7aXaOfV9YJzq7BQN+4SH17WZVH++BhG1k8RmR+BR/D4AKJzKLwyGIRkWP3T1otyjI0Ge5CX6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibixGdvDCGtgXrijVRkVOsKDA9cgQVdBGRlYO1GhZUg=;
 b=CrUlCKdzhnbl4Sjr9X2wTNtDoPm3fTRqdSbPoc7U4XGAB7j95NPJK8WEEQYneOwAgmSeEtldVwBhkBtolf/DCfSVZM+5G5MZquOxfAK9gIlj6LH7ceT0BpQGeoIsv23YOnc1xtnc1ZyFy8m+KXJF7ss8IJWrtEg8/rPEhfbsJ4SN1ajz8PFBU7B3YQ9pfTQE6pTkI7F1kbRWnPgueIcG+Kc2J0Xm+t4K7J4DBVYh2LkdSQd5K5TJqxjsvqSo9ol5BPkPLxAouE9Gy5OjDefcYP+PExNUW0a+1hPRy7Gn9GImECBtkFDvn0lysyH8TN990QV1Iz6PZ94Kk4RUSb+tGw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB8664.namprd02.prod.outlook.com (2603:10b6:510:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 15:28:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 15:28:54 +0000
Message-ID: <e74bc8eb-b34e-412a-b4e4-13380278a7d4@nutanix.com>
Date: Thu, 10 Jul 2025 16:28:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/18] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
 <20250710085308.420774-2-mark.caveayland@nutanix.com>
 <a1bc9aea-4539-400c-ad82-916cf8ff22a7@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <a1bc9aea-4539-400c-ad82-916cf8ff22a7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0097.eurprd04.prod.outlook.com
 (2603:10a6:208:be::38) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: 32309fee-5cef-4a0d-4330-08ddbfc67ad3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekdkdVNmcG5aSEVhN1k4OEFGLzdObHEwVnJwamdpa212VVN6bTZEYWFUa3ZI?=
 =?utf-8?B?MlRsMEg2VUd5REp4TkVXRFFiV01CbHJuVFJ1aUZKSzMxelVJYmc2MEpycG05?=
 =?utf-8?B?aXpmOWhab3U5Y3ZrT0NUamhJbnR0bExzRFpNMHdnOUpJeXdvVnFuZnA5T0tI?=
 =?utf-8?B?Z1RkMXBKMndsVThpWkdNUTd4ZHg4NytqbTZOa3ZreGxVZWJTSHlQWG1LRS9W?=
 =?utf-8?B?WnlUS3dtc2pzNkpKSEpUQ0F6SUhjbkZldmt4ZGZTbS9Sd3FISXU2NlJsNkdO?=
 =?utf-8?B?QzRjNWVJN1V4ZE82NlVSM2lKUmxtdG5FT2R4Q2E3aERteU1XNXhtQlFERkc0?=
 =?utf-8?B?V2kvQWg1YmFEbUMvMUtvYitqSzZSSWJzNnBrR0hjc0lzUS91Ni8wVTFoWU1z?=
 =?utf-8?B?Q3lEcW1YeThGWGNmSlJJNy9aVU5BTCtkYUQyeEtSNDM5SExSdWgvaVVpb1Jn?=
 =?utf-8?B?em5FanFMQjJYMWhMRDJlTzB2dWRVeHhhS0V1Wm1LL1NlNlFLTjNJMWhXaWZk?=
 =?utf-8?B?R2xEM0pUZDRVWitFV1JJQzF1NjRWd1VCWVpzUHlPeW1NQTZLc3dTVVlQKzJv?=
 =?utf-8?B?N3VpZzBjRU0vRGVNUTV3RjhMWmQvTGNpSkZrdW9IdXpUZWtHNDNUWGpRcWdy?=
 =?utf-8?B?TUdKeldBRHBBOTZRdHZqUGUrdkVEdFBzNEMzbGQxbk42STM2UloyMHdvNU1z?=
 =?utf-8?B?T29jQ3dWblQ3Wm95cXl4WkN2ZmNJaklCK1k2QXcybDMyZGFmUWRiQUt3bE1D?=
 =?utf-8?B?bGlhN0J1MVhzWEdRSXh5VndaOFBwSmlUUlMwRVRMVC9mMStXZmpzSE0wd1BP?=
 =?utf-8?B?ZVFHRWt2cnR1QzlvZFpocEw3MGZHT2FZYnVYdVhCMnNWNUhjMlM0Q29VdTd5?=
 =?utf-8?B?VDdQbmRxZlVDeXZuZk9acUlXY2VIUW1vMEVHVy9NcitFcW9zd2RFbU5TSHRB?=
 =?utf-8?B?ZjRZL1c1WUZKcWVXTVh3QzZuSXJiUWEwOVJRZnBRSDFJb3FIUTFMOHhLYkc4?=
 =?utf-8?B?UzdJSW1zcjhqVnhvZHdhVFd5UTltc2tvNnVmUGJkZmhJL0ViclhVQTlJUld2?=
 =?utf-8?B?cHcrL2pyZVNmMmdJRk9HS2tMTkw0eW0xMi80TU5WRXJlQjBpMjE1SEFXMnpT?=
 =?utf-8?B?Vnl0d2xWRGNPa0psUlEvWTZtVTNLMUZQV2FKV3ozcUJYUitZRnNDYzE0VHB2?=
 =?utf-8?B?YnZaV292b0RiSU9SZzFCd3A5Q3FyQlZ3OWxWaVpMNndPdXg0S0dFTHAvREV2?=
 =?utf-8?B?Qkdyc2M2eUNZVWIzVE9Bam5VMmV5Z1JUV1Z2NVUvUmF4YTZsRXZONThKRGky?=
 =?utf-8?B?T1JTNFJFanprc3V4Y3FDY3J4Q3poN09HZzZFMFpUT2pwcURXRi81Q3gyMCtn?=
 =?utf-8?B?Uzc4b0twWk9vaUt4L2Zmalk0T1BRcDFFM0xabDR3VWROWU5KbXFXMGxIblZF?=
 =?utf-8?B?djdWRnozaHFaM3pmWHFYYlM5WDBtYVpoZzNEL1FVTytRSVN3WExxZ2tkbFZP?=
 =?utf-8?B?SGZ6RFdYZ3VaWGRIMEZWZVk3WU1mQmNrSDA1eGY4L1VLUWdDK0JNVmt3SXl1?=
 =?utf-8?B?MnNEYmhmUGkrSlhobXBoeHRzVW8yY2VDdE1zTGNHMXFmVVZoa2pXejk4UmJL?=
 =?utf-8?B?dVZlb3kxRkdXT0l1SXlsMnRZN0FJbTVnMEZsOEUyTmZacUxIcHptMXpvN1M1?=
 =?utf-8?B?bnp3dzM3dVh1R1ZWS3NIb01qU1JYRWVoTjF3OGxFcDZZMEd3cDdjTnVINE9y?=
 =?utf-8?B?T1VoMUVGK2R2N1JCK01PekRIMTBnVU9WZUZITnJqd0N1RldiTE5tdjl5dXp1?=
 =?utf-8?B?YzRQMTVjbmJiNVpIVXRRVFdNNDNwazhqU1QxNlN3aFV4WkpwOVkwR2t2cEdW?=
 =?utf-8?B?NkRxZzkwbDBJMXFaK0s0bTk4Q3pLK1B1b21rK2xHN1M2QklraTZDLzZ6LzRF?=
 =?utf-8?Q?oPs3Z83+fNo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXNnMDZ3TlF4RTR4WFJxbVlsZjF1MDBOZE1zbG8xT1Z6VCswUHU4T2IrbXZo?=
 =?utf-8?B?YXYzNDFLL3RPbmlCV2t2WHNXa0NJUzVaRjhxVko3WUdFWjI2TEg4b2RVdWd1?=
 =?utf-8?B?M21NVnNTOHdVMDJubDh0WDBWRTVYUkR3NmhrOWtxWmJuVUNMZHhBU1Z6d1pY?=
 =?utf-8?B?a2hUenY4U3h1dnpzRmNPaGgzVHZjZ0RTOUllalZuZ0pwNmszUXdWbzFhS2dX?=
 =?utf-8?B?RCsxS1FTWVhBRzdMNzhPRmwwTmVKWnRWdk5aM1Y0cmF4cGZSeURiL1ZXSjR4?=
 =?utf-8?B?OWpQb2gwYW9qNnZzdzB6Ui93RmdHaEZLOFNxSEtIbFRoNnoyM2hiTitucDdu?=
 =?utf-8?B?Q0hJaGNFeXhlcnBmSzI0bVU2WHc1K2FsekRPL0t3Y0Y4VFoxTGJKNDNnbm5i?=
 =?utf-8?B?VUxkT2ZvU0tyaHowU3BLcmI5c3l0djY1Y3d1ZlltVFM5VFpKLzZqN2EzcVEv?=
 =?utf-8?B?bVl0aTlzWGdJWGI3VHNjZ0xBYUljejI3bzhRQWpUMFpPKzVsUlFwQmpnNTNl?=
 =?utf-8?B?SDlyZUFibm83ai8yQTh0aUVXcDQ5WDRSTWdkakxVTnZxT21nT0IrSk1jSnBx?=
 =?utf-8?B?MHNuYS9RSStIaHFMQ05ZNjBTMzFJbmw4SlFic2JvWXFxb2hxQUo0cVFyV2NR?=
 =?utf-8?B?SnpiLzZZVEpEUHhpRWxKUmNHNFQ4YjBrKzVZaHdmVitIb0pmV1hiVDlHZTVk?=
 =?utf-8?B?ekQxSlhVRWVLaW01dWdieVM0VW4vai94eHBQdDl4cENydzh2N2oyeHR6Tm4z?=
 =?utf-8?B?T3A5NFQ2eFZvK2hrZStsdHl5N3dIWTNnSVNXZVl1SGdXYnFEaXFrZUs5L3lp?=
 =?utf-8?B?RjM0THZjNklvc0NEODRaZDdKYXB6czQrTE9IWVZUZ0dkYnkvbXRIcllKTDNF?=
 =?utf-8?B?UFlvN0k0amlCOGYvdGZPTGFlYnBqQ3Y2MG9WT0dpaTFjemxVc29jbFNqb3pC?=
 =?utf-8?B?WENuR1hJTVF1akwxVWV2OGdRK3owUEVUaDNNY2JXei9GZDhjY1NYSGthUGhT?=
 =?utf-8?B?K20zV0E4K01heE1jU0ZaeENIMHpab1F3ZVovSGhYNGtkUVV6YzNXUVc4YUxP?=
 =?utf-8?B?Nk83WFVYQncwclI4U3Y1WGJOeVFCdUJDUEJWd2xlN3NzOVVHeXd0YzQ4ZE1s?=
 =?utf-8?B?amFjZTlNbGkwbGlha1hsUjFkb1cyZjhmNXZDMW9aRkdaamVhVXlSTktCb3cr?=
 =?utf-8?B?bDl3R2pCMVgyODBmcUJ2RzV2N2NSdjE2VVptWXlGK0dnTS9vckxmaUk0YlZ0?=
 =?utf-8?B?ZzV5UmZUYWtNN0w2VnFDR1FGMkhPeWF4clNEUExJamFYNTVKSTdIbytLcmdS?=
 =?utf-8?B?Y1BFYU91UUkyTllUT2N5L3d4T2pBWlZCWnRCdUNtajR6bFpIZTYrMDh4ZGds?=
 =?utf-8?B?VnVwR3VBckFWNkd4a1krejc2M2QyUGdNNkhtQUdOWWNCaEU4YTlLdFNUcFZr?=
 =?utf-8?B?N2hVTEdsUkN1cUhuWVlndHk4WjczNkgwa0pNNVFOSklZL3pmUnF0SHV1dlNN?=
 =?utf-8?B?QVk0TGozaVBwb0NhRm1PVkg4NHFlOTk1dDJlaDAxTHNOSGV3U2lvdFNHRlZL?=
 =?utf-8?B?YVFPTk9vZUcvQnI1Z2VUeVdSUi9pZitpM0FvS0ZSL21UeDNBbDhjY29YbjBP?=
 =?utf-8?B?YTYwVUJKSHB5TUdHK0xDV1c4aXp0VmxZaTBrQkhJenpXK2F4anpHV1ArSXNJ?=
 =?utf-8?B?NGpYZ0lHTVlzVSs1NUcvT3Y3OWlNSDVnR0gyTVhZN3BKdE9NbGpBNXhDUnVy?=
 =?utf-8?B?VCtUcWd4cjZqbGZXRkw1TDh1bXFLTGNDNUFaWnJWb213SktEcTMrUHAza0ll?=
 =?utf-8?B?VlBIRFcrMzEzUVNKeUxIVHhEd3N4dmtiZW1sWHI1TWp3RDFTWkpFWmhaV0V5?=
 =?utf-8?B?eW5oSzNsMTFOQTdmQTRlcHdwVFVScEEySy8ycmRheTF0Skdlem9wVXhtUTVa?=
 =?utf-8?B?RTBwRzJxSklwcHdid3AyZ2p6WTlkQldZRmJoTi9VZWdobzBTV0M0RVZNaXZR?=
 =?utf-8?B?SDVORlRpNDJ2M28vU1Vyb3c5UmJrWWRMa0xBdzdDTjV0VHpoNkY4ZkRuOXZK?=
 =?utf-8?B?a1N4a3RrUDN4YWN0bEl4Q3l3dnFtWnkwSHhvSFpNYjB0SFZkYmp2M3hlb3pE?=
 =?utf-8?B?RnJ3RjlKMjl2RFR5YzI1N2o1K1ZHZzJJUlR3WFFPUTZCektDTXN2TWw3Y2Jo?=
 =?utf-8?B?U2N6eklpckFFUjFOVUw4Q3o1ZFVtNjZNSkxFdVRDNUk2U0hseENnQytjMXAr?=
 =?utf-8?B?OVd4emhxL1UrVjJmNzRHRHIzeDd3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32309fee-5cef-4a0d-4330-08ddbfc67ad3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:28:54.4965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lj5RsImNhNC7ZutzY2bcUW7Uq0arivDYEL3Zf0U5NG0/JjRRfnKqWrwuQC0rPSO7RbeC3AFDFs8zTovnwyGXJ86uMU9DJ6aBoVKIoea5y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8664
X-Authority-Analysis: v=2.4 cv=UNDdHDfy c=1 sm=1 tr=0 ts=686fdc39 cx=c_pps
 a=dFb4M3KDS2dZmMTtcJKr+Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=ajfXTIBNxiPQl-7obB0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: YWYSWvg41NqO20blM3iFcTSmI6uSrkNG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzMyBTYWx0ZWRfX+sAcN9ECN2eI
 WdpeNjemYer4nWpBmnsCJTyyL9l9NNzlRg4XB9A+w+uf2dgMPV+SFV6SombCOpi6R3ooVBqiwkm
 5a7IF4j7COF3rzP+Q01PHVhGGTFWnOKxsvGFVPhe7Ehgpn/AS9CsrjYkINZFm6Uw+u2tmnikFg6
 XGgRIaURwG9NJWnCgvNznFDK7rbmRj8SGCfNd6A97TX5WCZvJOG1jVUhQztYtd9569Dggknb9gz
 6zIot/0gxyHGjvCP4Klw+bvyoRgWB3Whe92uqNkU6oEd4VAkNbygiqm1JRsjOfhPFCtdj0/VVCH
 Jj2axGWVH0isQnU29Ms5oUTDiSmdyYVOUBOWQyyiozfiGdabA7sPRuYNrLk9DrGLxZFlPvMW/1c
 OW0arRmHUya9VdSlqykriDEEd0c+fPNCISnDNkMvS1Rx6u3Ru37iMiZS40BxdMFFq/rxjCbv
X-Proofpoint-GUID: YWYSWvg41NqO20blM3iFcTSmI6uSrkNG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 10/07/2025 11:46, Philippe Mathieu-Daudé wrote:

> On 10/7/25 10:52, Mark Cave-Ayland wrote:
>> The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
>> possible to specify any CPU via -cpu on the command line, it makes no
>> sense to allow modern 64-bit CPUs to be used.
>>
>> Restrict the isapc machine to the available 32-bit CPUs, taking care to
>> handle the case where if a user inadvertently uses -cpu max then the 
>> "best"
>> 32-bit CPU is used (in this case the pentium3).
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   hw/i386/pc_piix.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index ea7572e783..67c52d79b2 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -418,6 +418,18 @@ static void pc_set_south_bridge(Object *obj, int 
>> value, Error **errp)
>>   #ifdef CONFIG_ISAPC
>>   static void pc_init_isa(MachineState *machine)
>>   {
>> +    /*
>> +     * There is a small chance that someone unintentionally passes "- 
>> cpu max"
>> +     * for the isapc machine, which will provide a much more modern 
>> 32-bit
>> +     * CPU than would be expected for an ISA-era PC. If the "max" cpu 
>> type has
>> +     * been specified, choose the "best" 32-bit cpu possible which we 
>> consider
>> +     * be the pentium3 (deliberately choosing an Intel CPU given that 
>> the
>> +     * default 486 CPU for the isapc machine is also an Intel CPU).
>> +     */
>> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
> 
> Please warn() the user, otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> +    }
>> +
>>       pc_init1(machine, NULL);
>>   }

Thanks! That sounds reasonable - I can add that in v5.


ATB,

Mark.




