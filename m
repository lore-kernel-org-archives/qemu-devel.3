Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58DC8C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 09:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uElXg-0007Kw-Uz; Tue, 13 May 2025 05:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uElXe-0007KJ-OQ
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:03:14 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uElXZ-0000iC-Ru
 for qemu-devel@nongnu.org; Tue, 13 May 2025 05:03:14 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D7WPr2005259;
 Tue, 13 May 2025 02:03:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wIWd4VISc6QojyC7ZjLhyfYxRCYyJ/5julmytQxsu
 rM=; b=yOArc6X6Cm2E/Oi2SXxUGbprNTU9vdy+FCtJxUHdivp5sG4bYRxSZbD5b
 pE4UiXrsILXLSyhKFl73sgHlApR/juPHj7dimO0aPrB0KKcAXLG/OeyEW70Bxa7e
 Vd65J6UErB3dG4s6RUrrn3iN2sFhztVWg3RJuqQ76PIF4NTgODhs4vDShx+i3ck3
 pc47tOB6hDRFPhl8GEb6b2vq1Zv3dGXWHbAgtDeq762wFVna5AC6jAJ5gCBGnggJ
 M8TwNneyvfQr/N17+t4dTD3US9h7vsSiIC+nMb5ZC8fpq782eRL7Qfy+ebtdPlou
 h5+9RZrFA4qFnhcb2MXOSvGi8GhxQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazlp17012038.outbound.protection.outlook.com [40.93.1.38])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46j2q8depe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 02:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kRe0PqGq7b8iN0ft9zOGWhH8K9YeaxZM2lg7PseL3tBbsU0Z5yiaOO006bJ5lgxfIhZJvXzcssV8LfSnKl4L+0+54Zcyy9JbJiYgyuxlIjGKrzkM5n77M+nNMM4uqoFD0Qr6opuZL43A5pTOLdHqp5jV97ujwfE6K3g47gZ81ej/IC3CKEGwLOgEmkbJ5EMms8WLbapJnSAwBC7imgjnnK372Jt1Er+yKoR4lbUIqp5uLtfodEjURlSVhwYg/8nMX8+h+6z5la61jdQhah2uTuLw2SOXmNd1FiTg3wNYuIXqmsY1I7h3t3fSVmEuyvepDgsg+RB1l9Jw6wl4yxs0jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIWd4VISc6QojyC7ZjLhyfYxRCYyJ/5julmytQxsurM=;
 b=JdIBId0s/hjgy1W5B7/NybmqYO2rLpsDr7i2MVzFoyVBbTMJ99K2KvKA4TvIPpvWlXY3rZ22o88rcewQq28t6dqE5xHR8/SRw706/5sqSad02Yf7E3OTsA38vk20D/D9S4j+zij7+jWk+kSgDjWt0qIbX/HtV+mxsPYx8ltFMDfJRlZkdLlDCuBdjdipMUHP39TcPwXDhTReLotpC/N0kDPH0yg7r2qQhLonfCH8izhMGMcCChU0t9r6IMBsWatqevFjgf2APFhI89OUxEVUQo25ksKJ9ks4pAJUoLs3wpJbwqCvNXsa0KyrvG6C07EticAwhaRVBPk9ioi8vjCwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIWd4VISc6QojyC7ZjLhyfYxRCYyJ/5julmytQxsurM=;
 b=jnGJrBaRDTUIbq+hzH88oGg38LOjda0mzD6bgQZPMs1Td6BcrY1QTx3SlcOLFLCFZsGkIYVaVjWdSGqz/O6WXK+ijMZYRb7LXWyMwy1GqRXGdVeQ4FzSJ8HqD1ghcMVVET0kzb1jA9z3Ka+kjCS2r4iR7U8oZXWbzwgcBHw4pa8MM2H8+gHqwJL4KGIs5e3Aear2uGWSk5HIutP1PCb1JcxnjIQuwO69p5oaxTieQPiv6M/1DKg3ozEfAuULFghAjhfNArFmXxHOf/todE3T7K0x4l/WAKnUFFDbzejX6alV0NSexehSCyO6QKxYvThxds2NqL/T3D54YKtFfGNxrw==
Received: from BN8PR02MB5745.namprd02.prod.outlook.com (2603:10b6:408:bb::31)
 by CY5PR02MB8941.namprd02.prod.outlook.com (2603:10b6:930:3a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Tue, 13 May
 2025 09:03:00 +0000
Received: from BN8PR02MB5745.namprd02.prod.outlook.com
 ([fe80::13bb:c756:a495:74f1]) by BN8PR02MB5745.namprd02.prod.outlook.com
 ([fe80::13bb:c756:a495:74f1%5]) with mapi id 15.20.8722.024; Tue, 13 May 2025
 09:03:00 +0000
Message-ID: <a656a836-6464-4e0a-810b-e3e95617838e@nutanix.com>
Date: Tue, 13 May 2025 10:02:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc_piix: Fix RTC ISA IRQ wiring of isapc machine
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250512210928.4195-1-shentey@gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250512210928.4195-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0025.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::38) To BN8PR02MB5745.namprd02.prod.outlook.com
 (2603:10b6:408:bb::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR02MB5745:EE_|CY5PR02MB8941:EE_
X-MS-Office365-Filtering-Correlation-Id: fde4e43b-0560-4c4c-ff62-08dd91fcf5e9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWpYN0dXTGR6N2YzVDVaSXBLSEM5citiM2JIRUZDK3dkL3hWbzRVNEZPUGJV?=
 =?utf-8?B?YmZyQkhSTitzV2FRSlE5MkkwVVpGOElvdVZvRFZlSzBrRk81UWtXN2t1ZkN1?=
 =?utf-8?B?N3FjMS95aDBxSmo3ZGFwWXh2UjFBTDZaTEE0TldFVHBkWFN4STF2c0RGeVlo?=
 =?utf-8?B?ZzV2KzdSL01LTE1UQmg0UXFHZ1NKRWdNaWNkVTRPaHpyZFlKdHVyaHdkY0dI?=
 =?utf-8?B?WmcxdS84UjQ4bWVJUnluR3NTaHc5RU03SlBLQXE4V3VzeC93OXgrZkhXWWNu?=
 =?utf-8?B?R29nc0R2eEVsNzZpV3NlZUs0UHl4MmtPR3VKS3QxWHdjZU8vb2xnNkRtUHJE?=
 =?utf-8?B?S0VRWjNjNUoxZXQyN1FPTzUrekdmaHFOV1crdTVhSDZYaW1TZk5RbFBxUnBW?=
 =?utf-8?B?Tkdlb0xZR2hGa0NpYmVXamlVY21DUVBWenZyY3lBeFZMNlFGRmlhZENOS2FJ?=
 =?utf-8?B?ZmdhcGFwOHV4Si9XbFVTVzlNR1Ayd2JwdS8rL2Fpb0dTcDdtZEV0ODBiMVZC?=
 =?utf-8?B?LzhrejUyNmZ5YUltWVR5aWY2SE5mdWZ4WkhlZjl5Y1hlOXMrQ0QzeEZoR2l5?=
 =?utf-8?B?L3FwYjI1SmpDRVJCUFVucHpFWmdCbVpIQU5vSU1HZzduODdQd1ZtanR3WjRk?=
 =?utf-8?B?TURoaWl2MjBNVnFQeHh5aU5ZcFZJV3NYT2NManBQdzFJMWdMOXJXY3F6elBB?=
 =?utf-8?B?eTg4TzRQamlQeFVTU1JlajhWSFhLTXBaQ01HRW1ndDN6SDBzRHdPRmRUblU0?=
 =?utf-8?B?TXFac1czZXRCcENRWmlmUlIya28wdjRwUHI1cVZQQm9rY24wbk5KbXpOeUtV?=
 =?utf-8?B?RGVveWZyYi9QdDBBdG1qMk16eHNIdk5kVmJqbVpXMkFwV2xJWEU5SURxRmpH?=
 =?utf-8?B?TlBOcWNnOW1JOUVLQjlTZ0NCN2ZDSllaSzAzeHNqVmpxOWhOckFSbE1jc1hk?=
 =?utf-8?B?eVc4a3JqUG1CcXdBb3hUZjlEVEpuSzRNeGFFMVRTWWV6UUlxcjZvT3JLblFu?=
 =?utf-8?B?NCtCYXhMakY0c1RiSHVzWm9qbjg4Yk1YTjMvVzlwWUt1MWI2VUdoSW9TYVNy?=
 =?utf-8?B?WW5RanJRUVhPSXViam56N1g2THhDdENlS096T2dCQXkzUGlHVCtDWlkyblVj?=
 =?utf-8?B?Q3VQNmkzcHU2NkVCdzY1N3VGN0J6cUtVeTdZd3o5OVFtZWQ1dTRpVmJna203?=
 =?utf-8?B?NG5ZVzMxcmFYaFRSMW1xSGo2SHlDTWkwM1NvUCtYOG9KSVF4YWFvWGdDdVFJ?=
 =?utf-8?B?OU9DVnNEd3d6NjR0RjJYWFRLWkdXbG90NnZEYWpMMC9UNUkwVmllTWdHRjF1?=
 =?utf-8?B?ZXRvdVZoY3o4RXRLUjFKK1YwbHViaGczekVTSk1EUzl1Q1FadS9rNWt6YWF1?=
 =?utf-8?B?U3VmMlhlTFB1SXNsMlBJS1BlOUJjaThjYjlEV2FpRml4NTlTMnpSaUp4M2Js?=
 =?utf-8?B?VE9hR0tUeTFBSktFUWcycWlMY2ZsUlJwY2t4MHVjVGpCcEF5VDJoUEltWUlO?=
 =?utf-8?B?dnZMVVpIa2FKR2wvUVZFOUg1YWJQTjc3V1NXWkF0dGNzQU54QmdKcm1zak9p?=
 =?utf-8?B?MTFMbVJJR0djbW5FTElma2tkdGFhNVhKYkJKQ29mUnY4OHp1NU9QcUR4Y1I0?=
 =?utf-8?B?Mlk1Z25BYW4wMStzY2tXOXdINmJQbWJXVGpKTVFrSUFYT1dIZ1V1cktlZUYz?=
 =?utf-8?B?Z3N4ekJ3ZU9yaFJNU0FpY2xzUldHNFByOXNtNkdtVGVYeXNHai8zMHAzR1Yr?=
 =?utf-8?B?WjFZODRUd0xTYkRLOVNlOGxQUU50dGp4aFNoaG9pdWoxVzBtc290NytyamQ4?=
 =?utf-8?Q?eToLcEfni2sVnEgZ/7jBUGcTVxnyAaPBmXG6s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR02MB5745.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z29GY25OVThxWjFydWpVU3E0Ykk4MHQvSGliTEcvMGxZdU1hS1RTM3BFL0d5?=
 =?utf-8?B?VkozRDJrRmh3ZGlRdlNRdkFaMXJ0SkNCaDVobUVadkh6aEJSM2FHZWQ3ZjJL?=
 =?utf-8?B?b3NyU0MzeitRaVlJZGNCOEdzYnBOMmNybXNjMGZCT3BZN3l4c2Y4R21ZL1Zw?=
 =?utf-8?B?cTl3ejFuckRiT0Y2L2tOMk1zVE5LTHpzWHdpK1RlNXJ3REhJekxtNDM5K3dv?=
 =?utf-8?B?c3BVaFhrdk1hdDV5Vk9KcHRIeUJKZVJKWG9YcDUyWHBLZjBlY0JJRjM1dk56?=
 =?utf-8?B?clBkNHpOSXJLZ0xyOXFEOVRWcy9QbjQ2YjIxdUpxSzJaTWFqbmNkcnd4aE4r?=
 =?utf-8?B?UFNqenp3Yzl1VnJTNTdsZUF3VU9sSWhZZWNMd3JGL1NQK01BQStTK0RxYmY5?=
 =?utf-8?B?cjNOd3NlMUszRGVKY29ZSXY2ZnBsOVhUNzl2dkU5VXREdmJQckxicUw5VytQ?=
 =?utf-8?B?RkwvSnJFbG5SYzBRRDBVcWVsZHhuanNPYzRpWnRxKzgxOW4yWjdnaHZDSW5y?=
 =?utf-8?B?TW9XK0k1NmZRL3BSS0NaZVE2NW1NNmd1R0JXOVZsVnVTVHFoZU5IV0JpaE0w?=
 =?utf-8?B?L0ZOTFhoK0xWaXJRczV0MzZjZUtYSEhWMjV0SG5nM3REemNiSE54OG90TnZH?=
 =?utf-8?B?QStBbkxiUDFqSHk5Ry84cFBWMW92dFRDc211akZWQWZQSEJRWWIwZnRGT2Y3?=
 =?utf-8?B?Vi8zZk9oczlISU1zOUV1aWZ6OVhrdXUzMzNjYVBnTENyVzU0OUZTeUIrRU5V?=
 =?utf-8?B?ei80dmovOUZvZlF3MHVtUElxdThja3c3c3dBREtJUjlnL3JaQjdoTnJjeTJO?=
 =?utf-8?B?M0dJTGpzN2xnUWZBNC9WSzBvSDlpM3piZkFBZTNiNndNYk1xa0xhNVppd095?=
 =?utf-8?B?T1BhTWI1OEJGUkorSis3bStwaHdSY2tSSXFGMSt1Z3dSeW05SXF2UTV2L1FQ?=
 =?utf-8?B?aDZDR1k4aTk4a1IrRkU5SVVnUHp6aExWSkE2NTNzTU5FNDFOT2RCaXd3Z0k4?=
 =?utf-8?B?ZkcwRFlSaElpT25DcFJxREQ0Z1FIMWh2RWpUT01kbDE2K0YvN0lGL3FjTjl5?=
 =?utf-8?B?WTBUN2xRN05JeVVMV3pkSWtMR3lUeFRQQXFVME9QQXhaaXlFbFByWG1mclht?=
 =?utf-8?B?by9FRVpYMEpLdWh6OFdJZVJUZEF0NHZKbFFVVVo2TkhsSHpzcVUzNFNKTVZa?=
 =?utf-8?B?anZCS1BvOHU3c0xaelZGWGtoRXBUNmdvczFYNG01L3ZHVWRDM25xY3lVc2Fr?=
 =?utf-8?B?VTV0WEtTQVBveG9iT3hNU0VJMTdWWWs1SzI4VWg2MEN0MnJLWTE2dS8wclVr?=
 =?utf-8?B?cHhJaWk3eTdPV2IrSnlhRUhBc2JBemZxdDIrdzBNOGFCa2Z6YkR5eHEvN1c1?=
 =?utf-8?B?S05zeE95eDVKZVFsdXJuekdRM1p2YU1neTA2RVFJR0g4dVFEVW1za2VIWnhv?=
 =?utf-8?B?V3k5Z0R5blFDVUJST1lhM1Z1dUVZU2N1a3pGZ2hiUXZkb0lWWDNyYmtYbFVh?=
 =?utf-8?B?UE0rbHRiYmxaZThvTzVwOTN5bWRPMU52SEltemtWRVBEdDJZeWdzQ2c3bkNv?=
 =?utf-8?B?T2g0RXpaY1oxa2dvY3RIMFY2V1hVTUdGWkJ1MG9oc2djOFZyRkYwWGV4d2N3?=
 =?utf-8?B?NG1veFZFR2hBWW95cUp2eVFPK1pvSWVQZFVGeWI5dkc4NURFZm9CaDdkZ0t3?=
 =?utf-8?B?MFNuUWVtc0J6dG1VN0RJY2FoZm5MNHFYaTJNVVpPSXJzRmRBalNFSlkrbVdH?=
 =?utf-8?B?ZW1hVG9IY3hqdFM5RHlOQkhGL1hGd3A3bHJPQTAvQTlVeUY0eURWQ2NKZEFG?=
 =?utf-8?B?NFVDUytmb1Q0NHJTV09nVlJaSzMyd2VIcjJUaVdLeUdXcjk3TDd3cXhlTDY0?=
 =?utf-8?B?SmR0OC80dVRrU2RkTmVuSkIxSS81ejA0MXVSQlE2OWJXMFBWZ1FvY05qV2dF?=
 =?utf-8?B?ckdLcmdqRllOWXJ0US9vNmlzZGtjaG5pcmFWNHB2U3NUOG9iYnJoZU15emll?=
 =?utf-8?B?eDl6Sm04MUJidVdzS0syTmhUd2p5bW5EV0NTRGw3VkREUzh1N0pkZHNLL3Y4?=
 =?utf-8?B?WFRaRks5WjY5Q2hUcUlxTXZyR2MrSFdMMGQzOERUcFZMVjFQVHQ4eDNkQUMz?=
 =?utf-8?B?ZzdpOE9FMXFEYXhuOFRxVWkwWkRDQjJQeXc0bGR5RkIvZ0hVdUdjaWgyS0tW?=
 =?utf-8?B?ZGI1ZUt2UFNQb2xJRkhzQW9PSDhiblo1WVgzRndENWNnUmJGalFsdk9zcmht?=
 =?utf-8?B?LzN5L3NwYmpzOVRxY1ZlRFFRa05RPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde4e43b-0560-4c4c-ff62-08dd91fcf5e9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR02MB5745.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 09:03:00.1953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eT5M6cZJOoY7DZaQ4OW0up7W/EksobrW1zO7JOGZ9y8BtQpZxIfG8CSkealkho8w5bJ1TPrJVhM0gtMg5pgRekw5FXqnVZVdFApBAVF2PmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8941
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA4NSBTYWx0ZWRfX8XZeqHx4S7HT
 p2tA/1vyXXUUCk14rcG33ntDyRrK0Q2ZCXclGQ/Uh3JsbGUBsOh3CuxjIkU1DyPT9J39XJJHdfl
 GLPPAovC1CzyXJw8rwDlZuliUZYhv6fdX/bLboVMBfYHP7AnaH5AnP9GXF/bmbwAkf6oGqAPViU
 ElBKJyXAj3xMwzSya2SimccSYpe/eVJlzyJS9co8eaI/0OaqryPKEgOr+ZCbwuaBeY0U9MvTjY+
 UKdRm4cdn0YnQAXZCaDGUoBkHrzRUb9D5Viz7L19hxJMp8x1A9472TRCNoeUiNSL3MTbnzmwmpa
 j/iHjrAzNFlZ0zlGcAk36MB/lDUn1rKRI7fp0qu7Ve/Ua5j8jYOHeiVQAOOJqpAMw+h3hSzYqRR
 1Wu3ZHVq8eXo7iJSAjZKKA6XJiE2Ul9CAE9uo/QQtqgD+jcCUEvpV20J5qsJwmY+gQo3ZD2j
X-Proofpoint-ORIG-GUID: Hq1ztSvcFAYa-k_4ZLaSVdc4fPCpW9FF
X-Proofpoint-GUID: Hq1ztSvcFAYa-k_4ZLaSVdc4fPCpW9FF
X-Authority-Analysis: v=2.4 cv=X9JSKHTe c=1 sm=1 tr=0 ts=68230ac6 cx=c_pps
 a=a0mreH8AhMfks3Nq6fhO9Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8
 a=64Cc0HZtAAAA:8 a=CrSjlhFlk1uXWJS5AfoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 12/05/2025 22:09, Bernhard Beschow wrote:

> Commit 56b1f50e3c10 ("hw/i386/pc: Wire RTC ISA IRQs in south bridges")
> attempted to refactor RTC IRQ wiring which was previously done in
> pc_basic_device_init() but forgot about the isapc machine. Fix this by
> wiring in the code section dedicated exclusively to the isapc machine.
> 
> Resolves: https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_qemu-2Dproject_qemu_-2D_issues_2961&d=DwIDAg&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=zy9ANkk1dnktvDbix39oQju-ro1U35C5_dEQr6pECga8-YnCMKMlisUou43EzMJ-&s=0BQaI4PyU_roe0kyQTESxn57VNCBnJV3kEV6F-GpL8I&e=
> Fixes: 56b1f50e3c10 ("hw/i386/pc: Wire RTC ISA IRQs in south bridges")
> cc: qemu-stable
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/pc_piix.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 0dce512f18..4c37f5419a 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -285,6 +285,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>           pcms->idebus[0] = qdev_get_child_bus(dev, "ide.0");
>           pcms->idebus[1] = qdev_get_child_bus(dev, "ide.1");
>       } else {
> +        uint32_t irq;
> +
>           isa_bus = isa_bus_new(NULL, system_memory, system_io,
>                                 &error_abort);
>           isa_bus_register_input_irqs(isa_bus, x86ms->gsi);
> @@ -292,6 +294,9 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>           x86ms->rtc = isa_new(TYPE_MC146818_RTC);
>           qdev_prop_set_int32(DEVICE(x86ms->rtc), "base_year", 2000);
>           isa_realize_and_unref(x86ms->rtc, isa_bus, &error_fatal);
> +        irq = object_property_get_uint(OBJECT(x86ms->rtc), "irq",
> +                                       &error_fatal);
> +        isa_connect_gpio_out(x86ms->rtc, 0, irq);
>   
>           i8257_dma_init(OBJECT(machine), isa_bus, 0);
>           pcms->hpet_enabled = false;

I see in 56b1f50e3c10 that the commit also introduced the ISA_DEVICE() 
QOM cast in isa_connect_gpio_out() as a safety check, so it's probably 
worth adding it here too. Otherwise looks good to me - nice detective work!

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


