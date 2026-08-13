Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A680DC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXIe-0004jg-BU; Thu, 13 Aug 2026 11:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuXIb-0004jC-BT
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 11:24:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wuXIZ-0003xu-Bh
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 11:24:53 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DCK5UF2989487; Thu, 13 Aug 2026 08:24:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=GQo8swi8s47TXlmlcYzlEkg7Pw+tyKIIhAzP9w3jt
 P0=; b=XOhCPfNOje3PevnXWAFY+5RYrxmTjoyzXL0yt+09hNSZlezbYpNPHSaEn
 aQBEw76s7MgImjNmKGhPPnuI+8fy7HEU2/B5bjweHHqdMyJCw+WVeh+ZzAIebgBK
 yEj96aKnPKZ6QMA6tuBhjh5n+CJy+5dw8oPGFU0TqCfDm9XNEENmHvlwOBEU/Hpo
 GioIKCOm33gAiS7Az4KsOYI8Mfq+Z3bWgFlKla3MgjTr7WEm8wqSgW7yMXq25ezh
 QsvywE7tyYjqPimS/Xpd4txwpxd2M1dGcqm6CFggL8aiJa5qXsm9fmtxmp9S17p9
 CjxQMmQXshN99LMYNq4g3UxE/5fKQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020105.outbound.protection.outlook.com [52.101.85.105])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g08h95nxg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 13 Aug 2026 08:24:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLA6EJZrlosRoG2bCCfJXkZdZSADxjrynyeIBGBZIeWkLx/3NjIADF8Z9NpD+dfaq+K1ES67rVqYO85WlqstM5+F32WpPiui+MLBlDOmA9bCpk2uI7aozKI+pFyVPcWmcUilIPV7+1cGSVFbFspdLyG5OgT360mJiFilu5Z5Ra4RQY5IGxh7dHIDrKPgecwkyv/BYc1kKRnGfJ8qKhp/9tq94i62H7KoFxJpXeZ3KQZO+zBsE0kIs/FAf24m+us3qyX9Cyz8CZiwagRqYpjipqfJjiY/YFnceba25akuBW/T/e/jYHVV7VOhdffUs75DJzy8Bhn+6YuUIfbU9enrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQo8swi8s47TXlmlcYzlEkg7Pw+tyKIIhAzP9w3jtP0=;
 b=OnVCamV1MQv9AJMxwa/xQ+k8RjPk26z1egelUqOvxJeEAiDPLY8tVOvezeuOd8PVeaxXQeHit5d0hVaZfINsb+i6JL6PsKwqXmShpq3JeegtnJKfgg+n09sTsR+Ax02xzWC+p74gGDlRo7ErgxmO0JNgG8hYpMoFRv+8Q0ANTAzTAjefHgU3OMFyXLujEnIGaIOuqdEmJypM1SDpV4aSHCBEl48+W/f919qsTaeuofrPcCXv86nnXs9FH6YdncWmdh+HpdGHWnJ+YbcOOVufTvYYsSL5ziHH8+9qrA4wWNT/hVt7gyP/i3AFUbZUNu8F6cXB4esMF9nfs97ATQwMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQo8swi8s47TXlmlcYzlEkg7Pw+tyKIIhAzP9w3jtP0=;
 b=h8wQ5ATHEh+n1dkn/vGcewWlCGdccZ1t81QxZp/Zh5kqA4eRbnprLiDcAvlhA4bod+7/EderFYSeJPPv+ffzsHBi7jzhmY1wPGK6HL3WMU1/DEEz8mDY7f6Xd3WRv3uJ8heF2nkEenpOGn0KbM8x1x69M6aqZQsAXeSSym/kqCZRXzdL0bzJPwfhD4kfLY/VKdr/xxV4y4uzplXdTmDBjZbuJ/jEWVM3atxcwu0dVVMUm1VruEIad2aotUEewqqqZYxR2bTiyhi22pJce3Do8RI4yIELT6imJtcKpV8DAZZiA56sbcWsgDtHnORUbb0wSUeVmbu7/HQJyVQ21EA3PQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7714.namprd02.prod.outlook.com (2603:10b6:303:ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 15:24:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 15:24:34 +0000
Message-ID: <528995d0-06f9-4491-ba9b-5e382b260879@nutanix.com>
Date: Thu, 13 Aug 2026 16:24:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/21] hw/intc/ioapic: deprecate version property
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zide Chen <zide.chen@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, khushit.shah@nutanix.com
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <20260210032348.987549-18-zhao1.liu@intel.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260210032348.987549-18-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:806:6e::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 13dadedc-dfa8-46e6-4981-08def94efa9a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|3023799007|56012099006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UmIrrlL6wzRPU/o/shRdpW4ohZtpUQlqAV/9gUO6nCpiTR0/cgMgeku54T9arpj8qxxEQFVbxvoGejmky2xkkEOWwYcXFApWSshaobiaPqCOhU2yrjlcDdeoUWEgR9PGh5rJJn/j2HwJgCPZgYBFn0PW7s6AD2w3jI1bpc3eWlC6/j+8lGj916YFdWTRX+Q3LDKW+ndOtaXa2dzh9Lv+o83qXxcy9q28BTkVZG0SGcJuGbAdmvcLKx174wQniEeEVQp21HvrsDPOVM+/hrnSrU+87czL1LddxP2sp3xScSB8EEozYShraXhfq2kDaLUr21heLO8pRXBFyJDpm/RZzn+cUL9bTyY5sj83tIneQlCDZxOOLXWHJxvMtvA7BYYtKvm3Ek1xbPBed5+EW5vqvEnqe++5TUiPMNASWiXUbtFAl5qUbVBQRELUDUkILH1vLovMGIF6aPi3IFdEhEREZnCazyDLBqzTNoidpZs/3SZhMB2nmFnMHe2OWrNDRrrAeQUy6mZtqWVIVtR4tqY2CHKGmhfVMlWslAnCBxDBTzKD7mp2Q1BG5FU1FWH8eVD9CKofBPizzL5xze98mLyWz2bg/IDYkc6x1KoDJHMdOJ56KjYcKAtRd7D9ceLj0JfzPnIFqXGZdmacOhXXMLKrb2YpOIXER1uro6nqnerMyhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(3023799007)(56012099006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cld3anM0b05VQ2trTzJiZGx5VW5NZW1DU1N2L0kvUnh4NlhzQmdhb3diUDJN?=
 =?utf-8?B?TDR2anZLeSsrN2lYRVhpQzNEZUFraDFUa2lITmdHelZ0MUxCWEdVcEhFUlB6?=
 =?utf-8?B?US9hNHJBMy9ud0JFOEhPc1BoNklGZ1BEdFMvVGtRclIzVTdsTWhhSVpra1pZ?=
 =?utf-8?B?NHN1cDc4eUdBTVhYMFRpSjErQWIyNUdIYlBGYTZFSU84cXRHU0NmL0hZL3ZC?=
 =?utf-8?B?cEhjQnMveGZYUWhDWVI3Q1o2Mm9EVXNTZkhNcGVyNVN5LzFSRTN0YVlQZkhk?=
 =?utf-8?B?T2tJL3dFMHMvbFdPa0JCSTZ0dDVMTUFUaDVyY2puSmlEaHkxOEVBVUc3cG9I?=
 =?utf-8?B?dklvS2JaZWVRM1ZCRmN5VGJ0SGRkWlUzeDRvOGdidmJHNzBQTzVUdnA2RE90?=
 =?utf-8?B?UGxjeUlvd2FzeTdadHJZc0pDeU9XNk5tNGxSb09VUW94bXl3ZVNCWFpoVGpK?=
 =?utf-8?B?VFBURXNvbjBKZ3FnMFdQb0VaZU0yLzJiK3E4dHZoVTVCZURqK2NFYWNRQk4z?=
 =?utf-8?B?WFpSUUt6ZFNtdGdCZDliQlNTVlJ5Z0VmcVRWQXRqUkM3OUpkSEN2Q1k4cmcy?=
 =?utf-8?B?ZjZoSEpqdGRvNkxDMWVsaDRnL1hKK2gvS3ZDUzM4VkZoNzl3K1ljTFdmU0tT?=
 =?utf-8?B?cm5VYmkwZjRFU2ptc2QxTWNQYzVQU0xBWFZjRW1oYkdYQzNIcWJWME5YVUl5?=
 =?utf-8?B?QmVUWklNRFFYN1hUZVJQUGsyUGNvRVNaYkU2Q21zZHFmN25ESFprZE84UW8z?=
 =?utf-8?B?OFloTVlEQk5PcExvSVh0YnRpUjFRQW93UEQ4R1dscXk4Ykc5d1dBTTJQcjNS?=
 =?utf-8?B?S0Y1bU5ySUtITEZJcCtaNTI4REhPYXlRcFVUS3BaTEZVenhVZkZHRXJXbG93?=
 =?utf-8?B?MkRuVXhYb2RySG8rdVplQUhnZFoza2JscU02UElXSnlVZEdibGZZSEJPMU1w?=
 =?utf-8?B?aUZZNHNVdkFrblVLeGdzZFJ6TlUwUXZTQzBZNGFRaG9yME8zM0g1WWpwNHBq?=
 =?utf-8?B?VzFucmpuTVdKdG9sTUJFcXdoazlWSnM5WFpFVWRLdmxKRVpvNG52STErb2Fa?=
 =?utf-8?B?L2ZMejVoUFQ2aEZHckZZenk4dTgvNnJlc2JGL3FSRE81eGYySHQ0LzhvNk90?=
 =?utf-8?B?SUtJMWk2ODZIUU8wTVl6dHhWOGU1WGl6Q3gxSXBpVFhlZUxJR3RqK21WbGxl?=
 =?utf-8?B?Njc4UFJ5VnJhMUJRSTlOUlE3YzBsR05XbFozVE5jNUVtSUlnRFlwamsyZ1Fn?=
 =?utf-8?B?L2xHM0t4QnBBNHlyNHhKU29hNXJ6ektCVVpJRm43TFAxOHpiQWd1QklaUC91?=
 =?utf-8?B?TmJGWVBkOU5Ob1RCT0RLcFErNzYydW53R2pNbmtmTFVJR1JBWkgydU13elhp?=
 =?utf-8?B?MEVoUm1wUi96Q2lJdmxHQjdBZXp2TW8xQ0MxdFZ3NjYzd3cwd0NZeEhQWDNX?=
 =?utf-8?B?NGZKNlNILy9LRVBVWVNFSThRQnpmRXZsTU1UNjdBS0RIRXJLNy9XZWNXVTBk?=
 =?utf-8?B?VEZ1WEg5aTlJaVVQUVJZaGVTT2hnc1dXWjhPUXVEMlJNTDJ2c0ZraHRoMVlG?=
 =?utf-8?B?a0pYc3kwNlR2L3JtcXVsOFYwZlI2RFB3dlZLWHYxQWxGZkkyNzJMSzZlVW41?=
 =?utf-8?B?Y1lEUVFrc3Ywc1piekRvcEs1WjFnTGVMMExsWms4SE81NWNraW43My9JRXJ6?=
 =?utf-8?B?QUp1YkREVzNUaE9TMHZvaFpZcGFSU0c1WEhBbW00ckI5TjlkSG83amwxYmxa?=
 =?utf-8?B?WThSanJsdWE4QWR1dFFScVZXU1kyd2E1dGI4eWZ4alk1Y3B6STNIYi9QMGZT?=
 =?utf-8?B?L1p6QytZRFdwclZkdWx0Y1pNcTlnVnpQL2RTTHMxTWVhakpZRlZ2aDlTVFFi?=
 =?utf-8?B?RHVSNlUrNCtIblJkTGRFeFFSaCtlS3c1TVVTb3hOUDJCekxycHcyNS9hdUcv?=
 =?utf-8?B?dUJHOU8wSjBzS3l3SnlzZUZBenphdVY2ekU4VSs3Q0l5bUJBNGNvS05vaXdO?=
 =?utf-8?B?RnQwMmxaY2V2czNFT0VVK1VUNHlaTm1Qc050ZlVId2pIVjJQMGFOaVI1TVdi?=
 =?utf-8?B?cGJma21naGR2TTJjMWhjc3lXL2RWZHc1SFNTNDFEUWtDTndWWU1xU252Q2l4?=
 =?utf-8?B?VFM1Ty8vVXpMdmk2YkNNT1cvZEYrTUtQUUZNeUdiaTZaaktYcytDY2RGSXM5?=
 =?utf-8?B?dGtsUm1aK1BJb2pvdDZMK1Q0SEk2TGthRXBxWi9pZGlZVWNmb1h3R0JZR0pr?=
 =?utf-8?B?RC9sVFd3YW4zbHBUOVFHVit1c3pkRDR3dHRicitaZVRoSmt2aWFKTi82Rlh5?=
 =?utf-8?B?RVFIRVRwdUJQV2JLOWpyZUlrOERIU3hxNHRoZkJlOWxOU1lYdVU0bWs2RS8v?=
 =?utf-8?Q?QtjUKN2EnVnidBL4=3D?=
X-Exchange-RoutingPolicyChecked: L8yOx76meXsSanqgt7Z8WwhR4GrUHoksRxa93jmqjSKEw5xB2S2VHDu71Ygx3NI6ZVvhrVTG/7j4QFVg2BeDDg8iA0ycYwejaxV0kKgFsEyLm6RWCGFkFvN2mNhwpf/q3qM5z/LvwNOZyMpHxP/AQCP7WnJYDuRyARG4DULvMS6HcNwWU4K6T9rPCnnJdDUboNWJClULKduU3EIy4/TFiNvttHs5LLIsFWVFaQw1bzCQPVngiFhMkLbRRuVhwLLzQwmhVhmTHK5jGKU21Io0et5j7BiLVDd8KqmCA1WwfZXbPZGQjTlC84Lw0ZabXAiCTJnV5vOyVbbmEgtPv2tsAQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13dadedc-dfa8-46e6-4981-08def94efa9a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 15:24:34.1640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tt23fK+QOO2ZxNuKDxV9dil7v+1kWrON51dUVpR8HBHSU6t+dCacK0xEZnzQJROnOn0W7bZSgpqELpgvSXOV1GlJCgi744Dv4zY0ka3TA5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7714
X-Authority-Analysis: v=2.4 cv=Xb25Co55 c=1 sm=1 tr=0 ts=6a7de1b3 cx=c_pps
 a=KI7s4FTSNOfRXFB7i9gQ4A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=QyXUC8HyAAAA:8 a=bRIC3KliQn3px9ZU5MQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hC_myO4fO1EkAbgOqv7CEIfE4yxXNHaT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExMCBTYWx0ZWRfX5Rw7n++u4iWU
 A+/WFf1fLpbBjNHHXRUZ/ZTEJ7FKdUAYBKjKE/luD4meFnK/nUQQmMaGWuiRsEacQoW+NcdCixE
 i08CUBsX6G8hbyWIv+auGY+1A23orBY=
X-Proofpoint-ORIG-GUID: hC_myO4fO1EkAbgOqv7CEIfE4yxXNHaT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExMCBTYWx0ZWRfXzSDI/QSnN8Z+
 zCP1cui4iuQYHDMMW5WDRRFX9AvHQEO8DQtawIX3apEdG33j/R6t1SSvn8hA2IHRaJUQW3HMrYk
 CM0KDE6uacLzx4NQHSSkXf29UwgUPztoCi6MxJPVMElvo0CkNpUB6QSo44riXWpXdCx086A4KuE
 n0VPHyiZQr+7tur2y7ZXvHVCCmZgfHp9j+tgocBhMMlxdeowp6wkzKhVUqVIPpXQch0t3CJ3ECD
 7p4GFUhYzgwuyMwccd/9J+E6VO7U9EoBqaNAAYxVzHVS1mQ9DcYcp8PX+J24YBZKDio/dCSfXiQ
 Cc4cP2S120AkbXucSFMkJgozXjdPSFdqkhSOL/e200dBE5pf2q88vqKmNtdk0y49ILziKNRsgs2
 MNo0z1NPk/GVnQIe9hbfLnNZCUaYrwv6x7bKlPSceVZk0VMWAJvy4jOJ/NT2QDiRJ4f++kL3S0p
 dWXUrKVbAYmZJwLh7NA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
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

On 10/02/2026 03:23, Zhao Liu wrote:

> "version" was previously set to "0x11" for v2.7 x86 machines, but v2.7
> machines have been deprecated and will be removed.
> 
> And since v2.8, all x86 machines are using IOAPIC with "0x20" version.
> So it should be not needed to configure the version back to "0x11"
> again.
> 
> Considerring it may have external use, so deprecate it before removal.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   docs/about/deprecated.rst | 13 +++++++++++++
>   hw/intc/ioapic.c          |  3 ++-
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index fed939b7f042..dac1940636a6 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -483,6 +483,19 @@ It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
>   only with ``-cpu max`` (which does not guarantee migration compatibility
>   across versions).
>   
> +
> +Global options
> +--------------
> +
> +``-global ioapic.version=version_id`` (since 11.0)
> +''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``version`` configures IOAPIC version for x86 machines. It was previously
> +set to ``0x11`` for v2.7 machines, and since v2.8, the default version is
> +bumped up to ``0x20``. The v2.7 machines have been removed, and ``0x11``
> +version should be not needed. Deprecate this property to stop external use.
> +
> +
>   Backwards compatibility
>   -----------------------
>   
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 98de6ca8108f..3bf21f421a71 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -483,7 +483,8 @@ static void ioapic_unrealize(DeviceState *dev)
>   }
>   
>   static const Property ioapic_properties[] = {
> -    DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF),
> +    DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF,
> +                      .flags = OBJ_PROP_FLAG_DEPRECATED),
>   };
>   
>   static void ioapic_class_init(ObjectClass *klass, const void *data)

Hi Zhao,

I noticed in the context of our recent KVM SEOIB behavior patch that 
despite this series, we never ended up deprecating the IOAPIC version 
property. Are there any plans to resurrect the deprecation process here?


ATB,

Mark.


