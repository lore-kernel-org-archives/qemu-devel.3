Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0EBC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysZS-0008QT-CE; Tue, 25 Aug 2026 10:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysZR-0008QJ-3z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:56:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysZO-0001wF-H4
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 10:56:12 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEbWVa538024; Tue, 25 Aug 2026 07:56:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=1mo/e/0Lk5SElqeLDO6Jr3+0QBBx5fjGeWMXPIQ3h
 BA=; b=gsvykkG2S8iO1mQoU8kBIkNxnHSIi6nvxltCbR6udiyjLqm0bjaiw0nRQ
 H6TkCeORpWkjIaG8Q673VZ+09OmvfzYYXP379My/TUA+7wyuawAfckn43eXG3hi9
 XqsYt2XsJ+gQvi27RYcKlkIonWX9OJ58f0VfujzJw+8jhe/203v30qM7jTdc5s4P
 no5Qk6siS0O22GtL1cchj7dpZld7iaCSElYemMFZXjb6kuT5IwMIvPAAnVrou0As
 wSvYOmqk+Y+ehE/t2N6SMPmesf+GRaQ2kN3bbfzxsTrQj8rBG8BHuyoDAIPcVW6M
 HMRz3I41BG0mckm8x/XtYc0RmC7YA==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021095.outbound.protection.outlook.com [52.101.62.95])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g97as0yaj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 07:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVVozKW9B0sS+qREQISL1bfOUO94kDVglD1DiGU51WfSI5WFFVRRQ5g/Lp8DKYhLIYNoP8MnbnGijYdsSn9LlHU/hN/tFqRT84Wk96KvqPwFGDPYpCJRKUY1X/RlqKP3fBrb0cY5k8QSb10z17lmscNAF1Z+rwu9CBa9rg0IAX1xFSI1ZAXYjLVKy3XdYPPqiD1X7OP3rAZQ/JfR0IQ76rs+m+p3KozlX4JrszYUyqi8xclObKIbZFtiyurPVCvRoivQ8TT8Z/rUUhpZW22gJFDDj/9ZIkX6UOiW1u47oDWbL/fV3SK6L9LFMqE+BdE72Ss/k5jIwFwfQPk1hQOIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mo/e/0Lk5SElqeLDO6Jr3+0QBBx5fjGeWMXPIQ3hBA=;
 b=W9YG9SdtHDE0rUb8YvMUJN6ls3ylayvs5QojwXECvi0ov5qV0O379rG2OzzPpw+VS2V384WGmZW3lqVJgrqXNFyj9ut+FmCk5zZ5xCxkfD+mgdJcdCRaqkjksJCg5s6+EgoniN1G9EVbMHFAlB0CnBsWjcUEFMRSk8BgwqONXgMpvuqvYsHp+PgiqPsPC2AiBDT0vrU4c2msVsL809eCWPyZF28rrBYRrCIa8BlxzkzUaNCNZAxCp5lP5MITa7QpJ9n8D4wK2w9OPBq53ycK//S6hKVjzdUeVg1LLDhvKHN8I66XYw7WFx0Xa/0AF7AEBMYPEcl60/gd8GwCPVdc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mo/e/0Lk5SElqeLDO6Jr3+0QBBx5fjGeWMXPIQ3hBA=;
 b=icb/rQHCdeQpkRhQ/6GONL1+FIcp6Z5YxwwxqTR71hwrKNeNEWE9qVVDKbbA0KvxQC2UIwmd6VnRjXk7VvOSdhuD+5U5MrumNITs6e2T6ampHuKnjDPWboFY1/ARgXEZCqNfGIDxdILyzCJsm0BgdqsEzrU278LPiksb3Xn/QyNLNxuLCxBQOpMUTqz54D0xDYh3p/sYNuq2Ba63+4Kf8arTmGkLo2BY43j6wk+FuJvdL2iuqQECQMp/3K0zR7abqE6x6olNdgvntXSerGoWa7efUsp8j31SNOz9djr1ouBdpPTkF2XQ23wipz5X8q5/gZR6abQqgTZduvoG7GDB1w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7541.namprd02.prod.outlook.com (2603:10b6:510:58::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 14:55:56 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 14:55:56 +0000
Message-ID: <4a10c40f-7949-46d5-9457-e38a0e18ae40@nutanix.com>
Date: Tue, 25 Aug 2026 15:55:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/74] qom: add object_{class_}property_add_qapi
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-11-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-11-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:806:28::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff258d8-6f19-442a-c31c-08df02b8f776
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: u0tExS451FJ+PXYOzzEKV9bgGE8CSNy2pLjFkJnx6kRHuTOUnm0eBEvsZW/haj9LHJL5Z+qSjqZOHbbz/I4zHRNC6V2ACy3JbfDwUuGzJHpj7ccbSX8GxBOpf2oiJj41bU0/4L+RrwtV+1hd0+zzC30zfG0ocBCwvlnOFxb0+YCZJSsEpkGkiFx3roKFe7TqALgSDG45GKXjPcw8Jb1SpBb6rVn0+kjcz74Wx/Z1Dl1bd2+0skDlPUtUikWcWlHbFW5HJptHmR2jySfDZ1r9JwAEifd9hRrZPttQ0BAusQ9ifo81YBKbj29sdQqoZMAFPD6ph97EqP3pgKBame9DS8JYMo4fgQbHsfJ+I81WoC0E4nANE1D0NS7QtpoQ51v5Y0k/6S/6OEuImOaQcH+4lLBgO4opVVgUOFWpcTZNH1HueAuwIaksnuvQxydoww/iiTJnW/qWERJWpKQam+WzaFnNRTouOBh1Fa0mXC1y8qXYFkMFGE9hQvPLouigcLliVXjiPdmGPzSIFQUuh1i/JIbtvu/bPOlSSx2ijbshhfv/g+eJizS5UE+NzEjAPeQCyM48XyQgrnsZc3O0/mnkcoE3b/uvIpgyCBKM0FhT21syhZo8AOsEI/+bcnQNId24zrJX/cmltUVFG/MxSxRDvWEGFR/5B58VFOxj5uaCVQQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFlwbnZ2dzF0Z29wTTZHQmh0M2EyZHI4b2lDaUpPZGROMkROZXFRbjFvSFgx?=
 =?utf-8?B?dW56KzBZYzluOHdjV1RwaHVqcUIzMjVoQWhxOVdGVFAyR1RVUHN0UXVld3FM?=
 =?utf-8?B?amxvaVBKNUZiOERobEVYMTg4NjJBMXU1dXdvU09wN0VjNGNjczZSZDVKN1hM?=
 =?utf-8?B?dmsyR0xGUW1PT0NkUFVNc3EvbzZ6K2FvRDhUakplREIwZzNXQy9LazJLT1VJ?=
 =?utf-8?B?eU83SFhJdmo4STdUQzZ6NjZxRTNtSkNZMGdpL1JBV3phSXdOZXpySjdpUGtG?=
 =?utf-8?B?czNva1kxT0tYN29sZWZMUllqSnUyRnhaenhlYjQxUkFGd0FsdEk4ZXVPZjEr?=
 =?utf-8?B?WDlsSHoveW5DZmZYWWtweHd1R1FDSmsrencyUFZyZlBSWko1bWdOdU9JNkNm?=
 =?utf-8?B?OTB1NDdncDE4ZndWMkpoNzJTSSt0OVcxMXNHTTdUU3JlalJ5T0w3UzBnQXNI?=
 =?utf-8?B?bE0yQklCUzZ3NlNoUU03RXEwRWdzNHpobFBRVXRZdmRXTUdBalNsOUEyMGpt?=
 =?utf-8?B?Z2R6M1FwQWZpWGZaTy9ZOWFhT21nRVpjUnlhSkxPUHNPWGxsUzBEOG1WcHpw?=
 =?utf-8?B?b2NtUHZ6bCtrV29FWUdIekUvdnFEM3pDS0I2T3ZLYWJTTzNiQ2F5YVBwUzFZ?=
 =?utf-8?B?alVVQVhJUU5NTk91b29QcmpmTVptMFNmRFdlNHBFN2xuQWhIY3dkek5oZG1p?=
 =?utf-8?B?NENlb1hzNFE1MUJFQXNaZDNybzV5djFGYkhPKzdTZk5ob1g0Tm03NmEwYUJI?=
 =?utf-8?B?V3IrZlFoUlcxekRaeG9aeWZmajUxVld0UlVLSmx0cExSeWtYOUJYMXNneWZh?=
 =?utf-8?B?aE5qeTZ5SUk4T2hHUWRWRnhIRGwzSWdLV2pQRE5nbXZDNHNhajR1cjVsNUxr?=
 =?utf-8?B?RlRsMzJmSWpJc1VOdXhwNmtSU3Q5c0R3YlVoNnJ6b25pWlhQeWUvVHFjRjFO?=
 =?utf-8?B?WDFrODN0UkJ4eW1qYk5CNTJ4UEpNQ0JUeEptakdPaVhQOGJnUGlJUms2U0FJ?=
 =?utf-8?B?UzNaSk1TRG1DMjJtN3Yyb1lLbG1vYWZuMTA5SHF2SnhrbHNidVo0b0dFMmMx?=
 =?utf-8?B?UWJ3aGp4aE9rZUxsY0F3MEhqdVJYZTB6OGJPcDJSeUE5V05meGMxMThWWjMv?=
 =?utf-8?B?bmZFRytKcmN6d2l4V3RETW8xREFuOXJVR0o2VUlHSVZ0d2Z6OVdTbWk2WUdT?=
 =?utf-8?B?SWZnSUNVTitBZElBMFQ2emFUSFJXc2FvQndpNVl1VndoL1J2cWR6MzhpWFBX?=
 =?utf-8?B?RnVGalhaVWhBZGY2WFpXRjh6TC9jT25KM1lYUGtIRVI3U3BBa1FSZkJQU2Za?=
 =?utf-8?B?TjNFbUJZVkt2Vjl6T2RXQkprSUw5dTBEbEdlNUU4TnJhTjI1K2VKQTFIQ2hO?=
 =?utf-8?B?ZVJvcTZ1eUZlSGY0Vy9nMzJqQXoxZm1ub1d1RjY4UGJaRTg1VDBnMEdyTnRh?=
 =?utf-8?B?NGdISUxjWnFvWnJXT3ZwbFlZeVdPUFpmNUxJUGgzM0c2R21URTcvRlU3aUNs?=
 =?utf-8?B?NFBuZEZHeTZZYmI5UTRrTnNrdWQveGdXUkRkS0hkUHhDUXpraHQ4WDFsOXZh?=
 =?utf-8?B?c2ZXYmxwWmRjSUpnMXVGcU5tQXJUS1JWeVNLZWZPdGR1MTN4aEFIWE5lNEE0?=
 =?utf-8?B?NjJRRDB2MUFJcFkwVmtycXBuVnFTc2hZbnczdzc0c2ZnNEx0RlBnOFQreEtF?=
 =?utf-8?B?QU1SbDhxZjI4YUNWdTVtT2RFQ2tOZW9Yd3NxLzB4RXVMcHFDZ0I5UG1abWhs?=
 =?utf-8?B?enhFQ0NIL3ZDRWVFMk10Rk1BMWlJemtxT1MzNVZubEhoSW9kWFN2Yll3RFhv?=
 =?utf-8?B?azNrbzFSWFlPVE9wNlFMdlVkMFdqWFZqWFhUM0hyVldKWDRVUFdabldRU1R2?=
 =?utf-8?B?Z0t3RjNjOS9rNCtaa0N4TWtQU2YzeHlLZVZNQUpGMzhHeDM1Y1lGZHc0TWhv?=
 =?utf-8?B?ZlRNemJGTWlScDNEMStzNnRWamZZa3JhN0xaNVV5d3FXNDhFN2QwRVhjeEpz?=
 =?utf-8?B?a0FuTzk0ZitxallqSVBkZnMxOCtuWENEcGwzcUY4M1pBMHBmdGJVMXNydnJa?=
 =?utf-8?B?YnRXOE56b1A1UGFiWXdhMlI2VUxiMmdjTUVnalZpcXJxalQ1TlZmd3ltSUE5?=
 =?utf-8?B?ZURDdGtVQ0xzQmU1WmRmZWNZMkNXNTJhWXdGNC9EbnNWRWdPcXQwWmpyVkJ0?=
 =?utf-8?B?aG51STMzVWlCdkZyc3hnUHhoRHdBQWJrR2djbkN4QnZIOGFXSnVZZ2RUaVl2?=
 =?utf-8?B?M1ZZbWdFWjZkTXM2eU0rcjZZcDF6U01zLzB2Slh2TFRJb2MyaFkyNW1mdmFz?=
 =?utf-8?B?MU92OSt2ZXJtVzI3ZVV1U2J6T1h2d2FvN3YzUGUydUZ5em91NmViY1dVbEhy?=
 =?utf-8?Q?WqSN1mVp3Ru1Dies=3D?=
X-Exchange-RoutingPolicyChecked: HfHoTCrKx9Yj4OnIbTskJ6VUA0OdPhv1pgeAw/78f7vURiNAQNsiLS/muWUge4Gp0F3qld8N5snf3YK70B5CMzDt+zj9LT66Le91xdZ0k49SB6xqGP9KGo8VOAaNaapnT9WmcUV0P4N10fJgruQ5jJKelyDs8+PV+FJK03QO2Rv3OC6/sVVZQcQIf8mxsJWWKPb8/CwSHmYPWxdgCqqg4JEO+bWjzUH+w/npjc24saLuhDOTHCCP80Xm4Mhc4wyYXSL0kqOZs3nTbjea2VrYWdy6R8Jf7GhdGk4z0L3lFPhYuadmkYX8tVX7OIOaaYyAe3B9vrqBFvp/EaTlVgLFTg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff258d8-6f19-442a-c31c-08df02b8f776
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:55:56.0275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0+2AtiH4sKcsVWWgIiiBP+woW4jH3mQL0jTWZcA2JKFAsvHygehLOcoXnHNHRtbkgnxhaERLwMDdL3g3ElmC76U2TmVqAgwzLyLRunjhbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7541
X-Authority-Analysis: v=2.4 cv=DJu/JSNb c=1 sm=1 tr=0 ts=6a8dad02 cx=c_pps
 a=XQ5R8ZYH27Ke1DXIRfoPQQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=20KFwNOVAAAA:8 a=gPxtVo5xcf_-xAjG0LQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyNiBTYWx0ZWRfXwvmWzRrK2u/v
 F1B84X133DZAf+sgTyOW9LJxj8bCVn7Nke81xenLREVs+Hq4juy78h6azuO2TV3fvqlV9uoMVaJ
 +tQjE6aAG7j+iwwKAc5d1g+Z2BBDEZU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyNiBTYWx0ZWRfX24yi8P2+fytf
 fJe0v/FtChk7YJ/ttcBzjJ+UZF309fpqpOYjag67qYlAtFXPSydYFKzh5YyfkUpRHE3/R3MfxDF
 i8EAS2jADZpWco4U4g4PzusYuOiCjwYERR8WFSDXI8orD3D+UF38qWZ95TASevaoFTOyHnFKpkm
 A7fQl3TbFuOTMVLRLnvkrCF6w1ce6AhwcCnIWdKUBfSdfa7TyCNOsCZvHFeldWP8zc6qAEX1dmu
 LOpGr4pm8Q0GsmuiyYGkT/x1IZQYI+pfAk9UhToT9Jims/LtdkDjmj0L6fBSpmDei7ErNmjCgqp
 41N0ekcntiRQ+k9Qkax88XesqZB3TH2ThrIWv0gflz6mqY1kXVyI/G9JkLbTWjBiTlIxxAaZCsB
 SDarTgBI37MsA/E4Ru8DbVQv31h8a4P2O2iXUbkVJUmF62lD7HweQVuOFkvvZ+75Mo1mydTtZsR
 OqiwBOER2UI4KfxhUhg==
X-Proofpoint-GUID: NiTGQ8xnu97EXFfQdqfOcKvIR6Lm4RYZ
X-Proofpoint-ORIG-GUID: NiTGQ8xnu97EXFfQdqfOcKvIR6Lm4RYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On 18/08/2026 12:10, Marc-André Lureau wrote:

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/qom/object.h | 36 ++++++++++++++++++++++++++++++++++++
>   qom/object.c         | 32 ++++++++++++++++++++++++++++++++
>   2 files changed, 68 insertions(+)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 271d736956da..9684db935d23 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1990,6 +1990,42 @@ ObjectProperty *object_class_property_add_enum(ObjectClass *klass,
>                                       int (*get)(Object *, Error **),
>                                       void (*set)(Object *, int, Error **));
>   
> +/**
> + * object_property_add_qapi:
> + * @obj: the object to add a property to
> + * @name: the name of the property
> + * @qapi_type: QAPI type info descriptor
> + * @get: The getter to be called to read a property.  If this is NULL, then
> + *   the property cannot be read.
> + * @set: the setter to be called to write a property.  If this is NULL,
> + *   then the property cannot be written.
> + * @release: called when the property is removed from the object.  This is
> + *   meant to allow a property to free its opaque upon object
> + *   destruction.  This may be NULL.
> + * @opaque: an opaque pointer to pass to the callbacks for the property
> + *
> + * Add a property with a QAPI type association. The property type name
> + * is derived from @qapi_type->name.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *
> +object_property_add_qapi(Object *obj, const char *name,
> +                         const QAPITypeInfo *qapi_type,
> +                         ObjectPropertyAccessor *get,
> +                         ObjectPropertyAccessor *set,
> +                         ObjectPropertyRelease *release,
> +                         void *opaque);

Don't forget to duplicate the same doc comments for 
object_class_property_add_qapi() below, otherwise 
object_class_property_add_qapi() doesn't get included in our 
auto-generated documentation (see commit 478542dd83 ("qom/object.h: add 
missing documentation for object_class_* property functions").

> +ObjectProperty *
> +object_class_property_add_qapi(ObjectClass *klass,
> +                               const char *name,
> +                               const QAPITypeInfo *qapi_type,
> +                               ObjectPropertyAccessor *get,
> +                               ObjectPropertyAccessor *set,
> +                               ObjectPropertyRelease *release,
> +                               void *opaque);
> +
>   /**
>    * object_property_add_tm:
>    * @obj: the object to add a property to
> diff --git a/qom/object.c b/qom/object.c
> index 93d44a9444ca..1bfb6b933339 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2595,6 +2595,38 @@ object_class_property_add_enum(ObjectClass *klass, const char *name,
>                                        prop);
>   }
>   
> +ObjectProperty *
> +object_property_add_qapi(Object *obj, const char *name,
> +                         const QAPITypeInfo *qapi_type,
> +                         ObjectPropertyAccessor *get,
> +                         ObjectPropertyAccessor *set,
> +                         ObjectPropertyRelease *release,
> +                         void *opaque)
> +{
> +    ObjectProperty *prop;
> +
> +    prop = object_property_add(obj, name, qapi_type->name,
> +                               get, set, release, opaque);
> +    prop->qapi_type = qapi_type;
> +    return prop;
> +}
> +
> +ObjectProperty *
> +object_class_property_add_qapi(ObjectClass *klass, const char *name,
> +                               const QAPITypeInfo *qapi_type,
> +                               ObjectPropertyAccessor *get,
> +                               ObjectPropertyAccessor *set,
> +                               ObjectPropertyRelease *release,
> +                               void *opaque)
> +{
> +    ObjectProperty *prop;
> +
> +    prop = object_class_property_add(klass, name, qapi_type->name,
> +                                     get, set, release, opaque);
> +    prop->qapi_type = qapi_type;
> +    return prop;
> +}
> +
>   typedef struct TMProperty {
>       void (*get)(Object *, struct tm *, Error **);
>   } TMProperty;
> 


ATB,

Mark.


