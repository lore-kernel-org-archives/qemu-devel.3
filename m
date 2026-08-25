Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF8AC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrRd-0003ig-OE; Tue, 25 Aug 2026 09:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRP-0003ej-ER; Tue, 25 Aug 2026 09:43:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRN-0002Sg-C4; Tue, 25 Aug 2026 09:43:51 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PB0pUb1670641; Tue, 25 Aug 2026 06:43:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jrkwWPPjn4WAsZxs2G9OXSoVtqk1QvaLcyi2GhqmJ
 dQ=; b=ISnWBFVtAWMC8cVEs/Fy4RmVCVvhQPZPM9ZCaCv0lxtYGKcVcMeD81LHc
 uG3YmjlYilbiWaFAYrzWBkVv8vmVHKZ5jo11N7TZkx36DaTrkb6bbv7dhmkArqsv
 +YAF/GhFhzxDKk3EDunpRhkW8eRwtZqor48DLFagOAoQ28IsLJTAvTwJp+nDo/Im
 zgS3e+lJusTgvtWTk4X6A0odk5A80ACpF3G+ntTMUmxR9a5siSVhC9jyCnJceCMP
 pZLOM62ye2OtcMCkOA4+2+I2FaxXq0ZWBSK+ejmBDFMWj8bcQnhO6IpB4rgDDYDi
 c4hdEurqXgsQ2rs3efpdLUnheTXyg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022128.outbound.protection.outlook.com [52.101.43.128])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g8sya2fvy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgCKvxjI7S818WsCW18LNrsK5kA+hXmVsHVEZ9uwn4z0RVWI86J4aIt7FYSkO7CaUb3l4ZvpJai/MhXqtJkN7ydbSScdMVANs2dB2OazTuaMkubzHpSLB19V2O45jSoVN+BH/g6QvauEB9HLWjEdOTflcT2vkcvPbQ3y1VOHbgCRCSsep4v300uPVDkpYJ8OfKcwG5i4KqRd7xyaeO0nMREFWOzs1gXvGhfWbMVuWIr3I4G5n/8Qp7idxZNYc1h2MXCV0zOQBxwVIrHZtA8g8gf0eXnW3ErF3ypuyEUvLlb1sVSusty5sVzXd5+juzPmhVonq+tCkyeYBRK0LeIeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrkwWPPjn4WAsZxs2G9OXSoVtqk1QvaLcyi2GhqmJdQ=;
 b=xLWPWazx9g+OinDaaZ/351WR8fuFlLW3Om/LeGIypIR4HUTKnNPAMP55S3lNiKPdoy2URROI+gonjmGwckxYaRgzLbcdth5O8f5jNYExJABKfdfCIO8ZknJSPNMzq3MK1EFXyXTxpssSVsGebvZQ4OKlRCrzaJb15ZyGCK3eCpEKUpBmc5yX4JEyJ+9OQW2Uj6ixCLSeJQOFDPPnKpLEgAZ91cWU77wdeh8CJ5ocqM0ZCw+dezm/1txtxnuqH/HfSH6qH6BAtT6vwHazpDsAwEO4AEr9p9YmU53edUz+Hk9vn4QNbYoGU5VVb4ugO95XrM4fsmP6VVkgWvfOD3g02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrkwWPPjn4WAsZxs2G9OXSoVtqk1QvaLcyi2GhqmJdQ=;
 b=wqp9lwDPhVp7YlmVTsJcjEKLWBtBJStN81Mg/l1sgfFbeHogZpQU8ccjxPdXAVtaUO4WKewQx2k7Y++sS+LxwcIeBqRUo4H6bbvhoM52zd92kA/IJvmE48aYUHC2IuVMsoaQvTInz8mLLuK6Q2HOy2gxDiI1ORf+1z5sknLVCncDzp3M+8UgIscD6qh7woVK1ymnGmhqgK3ZzkYKaR2mj/M6sMOULHiVt3iWpgOJCHFrZKoCKYQOHqI4TXemzIHUX+V433Zh8cA3jSUnQVIGAZBATe6vO9zQVuFd13WJbtTi+4thrMbaY5hkZaUqL47BgW4ZwAWnbX4mfxH7BtNoew==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7681.namprd02.prod.outlook.com (2603:10b6:303:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 13:43:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:43:35 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 04/16] qom/object.c: add
 object_class_property_add_uint8_ptr()
Date: Tue, 25 Aug 2026 14:41:25 +0100
Message-ID: <20260825134320.1039012-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0061.namprd11.prod.outlook.com
 (2603:10b6:806:d2::6) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f0e085-5e8f-412f-3eb3-08df02aedc17
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|921020|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8yrr+sWgS1zKVu0FTsswL11CoSMb5WoySOSH6CKuUsnAhuNb6281hOPZCxffZmkRKgTLoSsdZCmCDvvlawEOKWWNPmsDw+GmaJ3RXIgGsS8kmqn7BouRf44Q0R4e/QiN8nthHCbW6XkiFH1Yi79iKZhvFRGVE2jGcN3/Th01q8DjozYAIixztmN8nhjeuooAjryRXPoG1Qg1LRtsU6DopytjhtJ5+5N45NUgsfYbjW9XrJtqVdb9dCem1920tH7qZMsDhkcfrAPZTRxBK2moyJ0ZHGIz+wESSemHXNgXrVMfcmwkcM37Yn3Ymv4SFm7swpLyegP2us9aXzkP6mpSGunx1p5HLNpe+YhPbmHNr4TN3wkNWBHjHQ1CQs+DLkSSGUPA2iSU4j4XFbH+Fkpl74vh0Lbo5fU+cOV1N56rh/nl/RZ8Xe5wQRN/PPgW3L6RwDamisXXl2t6tP8pZSzTpHt+7wNqIUkv7J9GPIwcL7MaKSpY96JOq2WNgunva4ikIR7+gH58sAzLvbiDJ259cyi7fPg4Bf9WAVhKxduS24bs3npDNlBqHb9+jyIwS5/ZYtUd6VeccT4BH8Cj63oPZFgJf2nfT/lIVVaCftA3B3HzYhW4b8B4gAdfPTODMFDDaKmBVAMvumDxW2u5lcbfRI0kv9MII9LBfgvlN6sYrBQOgtd5hFKc5wTjcKjfitJKVhlUWjidjIo4IrEVSQnR0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(921020)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3NVdkxnb0E3SVJXMjh6bWtZUVRReFdDVHdxU2FtcXNzaUFMM1lCS3UxU1E2?=
 =?utf-8?B?OWlDMnFnMTEvWG5BVWUvT2lwZ3FnNkpjNVBpRld2TENSdms5Yk96YUZGaHVE?=
 =?utf-8?B?NHpqb0pXYmo5dzVaRk1RTC9aRHNYL1RDZDAyYTFOdmRWYXBVWG1nblY0SVNv?=
 =?utf-8?B?bDloU002YVZlVlQwTG9rdk1VYlhPWUZieU1LRXU2ajJqa2liZG9GZ0xCMGc4?=
 =?utf-8?B?a2pUR1F4dTNreDVlbE56TGdkQnR0Z2xlcFpiU0FVK0NDMHVZVmlpc3B0UFdE?=
 =?utf-8?B?YlJOQUNmbHpGaVNKS0JjbVFLK0E1SHJnRDlROVNUTzRRaXFyMGoyak0yNkZN?=
 =?utf-8?B?dnNpTUo0YWZyNXR2VTRVUlIrVUxrQnJCNHk1TmVoZ2ZzZDViQzJDbUd6Vm91?=
 =?utf-8?B?eEJqMjNkemxUcVRXRmZwWjI4eWRDUDRsS001dG9ZbFU4UWlteWpUeGJGT29F?=
 =?utf-8?B?a005SmVoUG8vcFZlQVlZSFVocnJ1VTFROWYyQ0t1NGNWTmIvblJ5VlJHQ2pv?=
 =?utf-8?B?Z3RQOHlMUnYvWDBzODhkYnFscWZBTTc2WitDQ1dITW4xVE9NNm03c2VFL0h3?=
 =?utf-8?B?S0lwZC9iYU1TRGtPWjF0djR3WENFWXNpZzMvNGFoVnRmQ2FtS01pWElqaEU4?=
 =?utf-8?B?aXhqdjVmTStQekhGU2UxdHlFL2tBV1U4ZmRSaytMeGVkNDVkTXBNRDRnUnFH?=
 =?utf-8?B?SEpGcVNtMy85YVA2b2pnS3VTa0lMdGRORVhnSG54NmJROVpIN2ppdnBjZThv?=
 =?utf-8?B?Q05XQkxwVkVpdDI4ckRLaU5Ldm1sVVU1ZnMxcm85cC9ZVjQ2YzRPWXhOaEZ1?=
 =?utf-8?B?TVh3MTY5ZHVzUkNjMGFWelY3UnlaOWcwdFJ4U3VlMzF3QTIwMmphdCs5Umpl?=
 =?utf-8?B?YnprR2RoN3RUTHZQcHpyNmdlbHpsUzJmM3AzQjN3RGNxZTZMRFdiWmtEOWFy?=
 =?utf-8?B?MnF5ODVnSWhVNFd2dFlMSmkzN01BOWdCRENHMVdKYjhqa1c2eFM2VjZHRkkv?=
 =?utf-8?B?YTlEblhvd2RtUEZmV2FycnRKUkYwNkRBeVU5czliYWNqUEp6QjhreVNKQjdC?=
 =?utf-8?B?Q1VXUUFhbDNxa2NYYkhQUkNBNHJnQVZKY1JyOFV6bXJoVWZWMm1kTGJia0hi?=
 =?utf-8?B?Tkt2dC9KU3JBVkRRenMrSElhWmFvcnNTc2QydlBHdEFKZElPUFdXUVIrU0Ra?=
 =?utf-8?B?VEtCbUJaR3ZIRzlPcE1HWG82c3ExcC82alVORy9xWWlaNXRXNTllTWRteEpr?=
 =?utf-8?B?N1dYM21rWjY0N1o1ek5uenBxb3c5R29GQ0NOZUR1NzA0UVNmK08rLzRuSGRF?=
 =?utf-8?B?cXlDVm9sM1ZZWVFHYTVtVnE4aUdFcXdRS1ZHNFFWaCtqQSs3b2JNWU9aNi9z?=
 =?utf-8?B?enY5NHJ6U0hteE1SUnJZSThhODFuTlJia3FvNkhsckdHN2ZvbTdvellKRWVJ?=
 =?utf-8?B?QXlUZ29PMGpRSTNOODl2QXFXQkx1eG1RNTdVNU85S3liTnJ4MVdtWTliVXBU?=
 =?utf-8?B?a25VOE50VmJvZHNmUnYvUnJUVXI0Mmd5MVRDbTRaRFN5ZlA5SzVZQUQ5aEVF?=
 =?utf-8?B?MEVwb1JLMHBqaTFKVi9CQnJWbklqWUx4eGp6VHk5NUZ6cXI4KzE0aUIwOEJq?=
 =?utf-8?B?RnMvbXZNNHYvcWxpMWdIRWlURWlSbzl0bjhzV3BrOENPNnJCaFpDU2NCWmF3?=
 =?utf-8?B?VlJrVGpmNENOamhFN1I4ZHFtbjNRdTFVekVESVZDbU53UU5LMkNWY1VESk5w?=
 =?utf-8?B?WjQ3N2RsUDBzVHdkV25IemZaMXc3T1FDZC9ic0V1Y1d5aml3M2RZcjBESXJx?=
 =?utf-8?B?djlLdGFaRTUxdWJTVXo0RXM1WTI4cTdKK21TT25LS1lIcVluQjJ6R2ljYys1?=
 =?utf-8?B?Z3ZDNkFNMDdsWWp3QVhIVURydFF4dDlsSWNtZ3dybWZXY1VKa3drWmxQd2Rn?=
 =?utf-8?B?R09RdDYzWTM5TmgvMXpOcVZLUy9FSzlaSU1Rd1NUcFU1VTJtT0hiZkNTOEJC?=
 =?utf-8?B?WFBwc1E1NEY3Y3NmK1d2eVkyZit4c3ZieEVNa3VZS3FrdGozVWJKazFFa0Rr?=
 =?utf-8?B?NXVabFR5ZFVSUzdqdVFldzU3Q1NoNitXRTkzcDRMbElka3R3aVNlMit3VE52?=
 =?utf-8?B?KzBGeUFKcUorbXp6dXRGeHIxOEdLc2hKRUV5Szd1aHU1Rk1haGxiU2NrTUNC?=
 =?utf-8?B?MUR2eTJBSnN4UUNEZTNoOXJpN2toNUdiQ2NObDVJakJkWXd5TzhPUXpScG5H?=
 =?utf-8?B?d3pDc1pEUnQwaW5vSEVXWGZiTnVWUzYyMFZpZTBIM3FJamRjU0dRWjJyMS9o?=
 =?utf-8?B?TWsvdmt5WE1HRGpBaklwMHZXblFVWm9qWjhjVk5tL040MGIzR3BpcTRydzlw?=
 =?utf-8?Q?Ub6jGy6UnyEdoHUs=3D?=
X-Exchange-RoutingPolicyChecked: xgfFa8rccNyPluZepPRDtnKLOPmKVWgCN3si6m/wygAZwK0Yz3EJ0cRHW2zQn0vD9HTDHgC4pWePEmYQjRWUbIJf8c6+KeiRXlIzuDyrdves/vA1QYbIrewRy9LfPSnTrZ/9AoAuo5MtDnWsN83+zKe1J6DAQyJeQQLaLXnJdTve3PxV2BxyY9FmSa/ivUxei/FTmd/REiE27krV6Xyw3x76KppbRIo5hhK7GtaBICA6cjw3yem//hqH03TQnBVOFgLToTdpAioUdAfqQYSNaFChoUncTVHUUbl53zgF6L6V1kv8iVE25r7iu2TamxndiQ+0yrncMHwqtljK2KNIfQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f0e085-5e8f-412f-3eb3-08df02aedc17
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:43:35.1784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vu10mhOd3oM+QnyQPVjnuSiJ5Gy1H3i7zfYeJfFWCNjzlHF+1IFb+xQ6NadGvF5H46gcKwB1HHAHsKyfrrCGSKV/albnU85nj2fMD/TpqgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7681
X-Proofpoint-ORIG-GUID: EYVZyyF426x_Xi_Z9y6Cr4IG62CxwjaI
X-Proofpoint-GUID: EYVZyyF426x_Xi_Z9y6Cr4IG62CxwjaI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX4V3Fd11VPPeT
 K8Rems+LdyNjrnxBZzhOxNZ29AYQU4xB/DTHJwCYAxWT3DOPBLwuUdxkC2WbtG7BnFwxQW18mbR
 71CWl3LWjksy+E6xGv0jpECK9OMVTxwnq30kmGyHD1xfPh4pU7t0fuRkmH/lb5Ofd/n8WHAz4LR
 u5KSnNzVr6dDBVwdqw6+CDih/+Hd6DRy9xO4yJebM0Cb8/HeJi/RFe0gN5YEmrKVW3ChvgWqcb6
 gg0eMoY4WnsLqT9lo2HzzjxI6H+TKInobALARsvsbMQY/4/lIGAO4lHpC53hNEXE/doWl44mH3a
 ip++b282o5noJRTj50Y56VNrsGFz4I8tt4BbIwdAu2PRBr6xMtWHXXIhVVnRJcivHjzEsS/yvxJ
 cZ/essIcEj2X1XvGqKQwUAfYxynQJcP7VgWvPBUwHIount+2BQ+EgS4kahHMabSl396m3KcZgBu
 tIgjbq4aNDTeUm6q2gw==
X-Authority-Analysis: v=2.4 cv=YOqvDxGx c=1 sm=1 tr=0 ts=6a8d9c08 cx=c_pps
 a=1KZAvIgiCpDO1TOdvW9+aQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=4QfE8SPBBHYfMhEiUa4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX1o9Noot03cZY
 lm0mOr5XaMifiW27LU5wXUP0QXxwr3AfZHCoDuvy+5b31Kr6rNkSKUmjYUyL712682JtppMuduS
 rWi/+kyHeKEB+WDhvJUpNm/ZCet5X9s=
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

This adds a class property that references a uint8_t within the object instance
and is intended to be a replacement for object_property_add_uint8_ptr().

This commit also removes the __attribute__((unused)) annotation from
object_class_prop_ptr() which is no longer required now that the previous defined
DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS() is now being used.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qom/object.h | 18 ++++++++++++++++++
 qom/object.c         | 23 ++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11b1c9d2dc..eba675d218 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2033,6 +2033,24 @@ ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
                                               const uint8_t *v,
                                               ObjectPropertyFlags flags);
 
+/**
+ * object_class_property_add_uint8_ptr:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the uint8 value is
+ *   stored
+ * @flags: bitwise-or'd ObjectPropertyFlags
+ *
+ * Add an integer property in memory.  This function will add a
+ * property of type 'uint8'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
+                                         const char *name,
+                                         ptrdiff_t offset,
+                                         ObjectPropertyFlags flags);
+
 /**
  * object_class_static_property_add_uint8_ptr:
  * @klass: the object class to add a static property to
diff --git a/qom/object.c b/qom/object.c
index 9cb2cae4a7..a480fdd400 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2703,7 +2703,6 @@ DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint64)
 #undef DEFINE_OBJECT_PROPERTY_SCALAR_METHODS
 
 
-__attribute__((unused))
 static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
 {
     void *ptr = obj;
@@ -2742,6 +2741,8 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
     OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) \
     OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
 
+DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(uint8)
+
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
 #undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
 #undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
@@ -2767,6 +2768,26 @@ object_property_add_uint8_ptr(Object *obj, const char *name,
                                getter, setter, NULL, (void *)v);
 }
 
+ObjectProperty *
+object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
+                                    ptrdiff_t offset,
+                                    ObjectPropertyFlags flags)
+{
+    ObjectPropertyAccessor *getter = NULL;
+    ObjectPropertyAccessor *setter = NULL;
+
+    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
+        getter = property_class_get_uint8_ptr;
+    }
+
+    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
+        setter = property_class_set_uint8_ptr;
+    }
+
+    return object_class_property_add(klass, name, "uint8",
+                                     getter, setter, NULL, (void *)offset);
+}
+
 ObjectProperty *
 object_class_static_property_add_uint8_ptr(ObjectClass *klass,
                                            const char *name,
-- 
2.43.0


