Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C95AC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tib-0006K1-52; Thu, 24 Apr 2025 06:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7ti8-0006EI-AO
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:21:43 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7ti4-0006Ny-Ea
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:21:38 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O93Ii8018607;
 Thu, 24 Apr 2025 03:21:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ox4lDvuMb202Rro3IAWof53F0jUiHgJB6uHYpzZaf
 B4=; b=nGXCh1Hp7u3qYLTJdavpEDsnj3dmaLJ5DuvqNmTPCjgOx0xNjM6CAt0QY
 e58VLOtkro1JGyFCiCj1/OzqCIF5EGYPrxpdOj0FTN3Bzwnp502sD5MuEB7xPYaH
 5QizlHCql7UBDNJiIbrcPNJEBxm3nrD+68TdJRjJxTEGyjC7XyMoCSmQFWHFkCcd
 q86t7Ng7R8rYjlzV05r4uic5U9wUSk9BP5XHBjSH95zpfikp22Y+FAkFlT+uCask
 ljBrC88M8smRg/V0gAm29far8q7+yb9/nthD6TLEQ1VCgOeB3P4IWjEvxfGUzW5Q
 YCyFIAfmySIiaasohpv1mILkgxTkQ==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 466jhw45ak-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 03:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqQq8TCrLSLwY9nGgepSspUkLKEbv+wFAMwVl0a6dyEp+Sp4QdJfJf8Kbr6KJNvAcjnTt9JWDLCaJPT9SCsDqH5VVYUR5lnuTm3EKvJG7ney+7GUrKBKVT5V4T/p+sVpuab9TjjmHbd+tpw3ToXdmdt0ZiFsno0E1Eljd2MMPdcnS8DJjwsrwA4EHUh5lijfCJwdYZznV49REiQhPOnUJfZoEcgzvrV+XMb2MlvJMIawVt44+wJR7+Mj7W8/hbRb5HuDgyAipomvvfKMeN+NaZrI2RGWzaa6WNfvydepGVwprbVxZenFgN4mWtp7cDmccGvvqXdnihsGdpSaT5feaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ox4lDvuMb202Rro3IAWof53F0jUiHgJB6uHYpzZafB4=;
 b=yCcNrdi2vUaFRFDMg9I4+PT5hwAiE+TcBX9wpdnlRLYIJ+ofXYPJUAqqsooJSnB3pOSPSIUcCZXa5dm8ajev8ejdD87xuBjRuj9b6fWxTX2TxXl95WxvlJNUByOo6bKRH9+4zYJkhI5Z4rbmcvyMPSjw7AUH5QCdrlDKzcahYTfFvW2TC1f0zB74Yvn5URlC1aB4tBxRh5cTb1ruH70pxfpJy4I2RcbshqP2iYxCYzWSTvtXP/AeDoZZnfauB3405wsYptAhqxJj/5/QWi/ITU52BJvb4fUN5vO922guH3Q9no357sqG+cvPxM/bVodyQ+UGWikJnKp/0/vbXLhF0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ox4lDvuMb202Rro3IAWof53F0jUiHgJB6uHYpzZafB4=;
 b=PwJF3Ca4VqG0X2xWa/fDoebLbWm6lSMbQympDJpmcLcHoNNa528HKi7EFNTMFEwRDCjUesScPVQtuUx84z7JCmj3F1FN10AwTaaj5npZ1g0lawd0TmvavFVEeoadh/gBZ1PgHo824GkYOgh8F009h8wwbL7ZDEta935mPGqGMYPOFzE1v1VfD0YRXrapjpHLxwI3IXbS6pRZ6xsIhll9/UMsU06FHaFSnS5AdJmDSN8KNWJM5d9Ejh7Ma1DupmsQmCe6wfzJ0bg1lfQ+8xcnZ+uQNeiCYXFvgSzs8tEXnyrXBNjQc3cx7dcY2keBDtax6M/eDY/Wul1k8fTbFHQopA==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 DS0PR02MB9175.namprd02.prod.outlook.com (2603:10b6:8:13f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.9; Thu, 24 Apr 2025 10:21:25 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Thu, 24 Apr 2025
 10:21:25 +0000
Message-ID: <d05a791e-c520-44c7-8bd6-c1159a759710@nutanix.com>
Date: Thu, 24 Apr 2025 11:21:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] accel/tcg: Include 'accel/tcg/getpc.h' in
 'exec/helper-proto'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-10-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250424094653.35932-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0063.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::16) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|DS0PR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 4335dbb2-65b2-43e0-462e-08dd8319c45c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUtXWE5NYmRTTVVPVUlOT0IxcVVGNjlqUWRLN1JweVFNOG94b3VxZGR5bGlZ?=
 =?utf-8?B?d2dUNkh0Rk51eEdMWjBGNEg3L05aUlpWVG5HYk16SENSSUtJd3luNmgrKzNr?=
 =?utf-8?B?MWJBVXJiMExFbGlwNjZZN2pISXVmM25sVks5cytZZEk3UnRyR0NhQ21SaVU5?=
 =?utf-8?B?QVo4K1FwZ0VsUTc5OWNRZTRKMUxyUlcwTm9IQ0JOYS9FVUd2cmM1L3pBRTdE?=
 =?utf-8?B?MDc3QW41MFc2U0NqM1dmWDluNldHTnIzZ0FMbGtIN0FOWVBvY3ZrWmRNUllN?=
 =?utf-8?B?dXRROHpyOVRaYVZ6U2t4Q2JYbG9HUmZCdWZCN1lnQ3d4TmZ2WFRlNWMyNSt0?=
 =?utf-8?B?LzFXODl4QndIUjZacGMzOWpQVTF6UTdKNkZSUHJ5SG1VYmEvUDVDNStEdTZt?=
 =?utf-8?B?VWdXMUNkUUxQOWpDVmFKd25OVVdyWjFsSFgxVHFVYkdWTUhrMXNkR2NDNWo5?=
 =?utf-8?B?SkcwL1dwMHJlb1hOdlhac0dDLzM1dk5uazlIZml5YlFqNCtlU0VyZnFGUGdn?=
 =?utf-8?B?cTVsUnVjNDRHd1ArSUN5SmRFVDk3ajJZczF4WDN0NnVPK2YyRG85TG94ZFIw?=
 =?utf-8?B?SGNIU01ZbVZaL1h4V3ljU3BUZU43d1RMMnNhb2FRT3YzT3lVZ1J1TldDQ1ZH?=
 =?utf-8?B?VVJZa3B3OTl2b1AreHJjZVJxS216OGFDdjQ5S2krUFV5dnYzTWhvWmlUTlNN?=
 =?utf-8?B?a20yODZLb1pjSThDN2lJdUR0NEhWRlF0OFNaUnBvOG1PWkcvbUZ2VWtxRUtS?=
 =?utf-8?B?NUFLeUcrUXp6NWQvSG5ZeHVMZndpTlpBQXoyWGJrc1N5TEFxTFFMWnB4d0to?=
 =?utf-8?B?Q2Y2anFOSkVrSW9BU204TFFSS2I5VEQ2N3lCUnhNdk9lUnBDMlZsNE1lUFhk?=
 =?utf-8?B?ZWtvOW1XSExhUEFZZDJnMjI0ZzlxRXh5bzIvZmlNRnJUNHVVNnhta2JyNUlF?=
 =?utf-8?B?cTlaVnpvNHNXT1VHclU5SVNCbXFOMkVHWTB6UGVNQ0svTXRaaFN3M0FMamxp?=
 =?utf-8?B?L3pramVmcjd5WnpzVzRGRG8xdEowNnl2NjQ0SHVjMmN3Zy96YVh4eTQ0dFZt?=
 =?utf-8?B?TWJVV3MvSGtYT0NQZlE4aENDS084Z0tvWHRZQys2MVBsOWFmUDVrcXJTY3BD?=
 =?utf-8?B?L01ZL0RyamoyNWp5UnZtMVpLZVBWeHhBbCtZcDU2NTF0cnJaOW1UT0FBWkxR?=
 =?utf-8?B?NnJIYmpVYSs4WTBlamY5RnhuMUxiQzh2RHQ3ZGVOTFBacERjRnZoekY3U2pz?=
 =?utf-8?B?MEtrTnRucG5Zb1B0UkJXbzYrMTQ4K1pmRlFCSUhmL2ZSaGpicWxmOUVzK0lI?=
 =?utf-8?B?TUdoSnAwRnQvYTVlV3FSUU54T3VmTm9XU2FZT0hYOXFaYXJsWWZGYmwyYy9y?=
 =?utf-8?B?UzRyQUtCS1d1Y0RnZ20zdmE1NzhLVEVkSVY3QkpacTBhZW94OFB5R0VPRG1B?=
 =?utf-8?B?dlg1ZFdtaDRJSkRGNDZ1M0g0dFhIUHpVV2U2ZUZwNVBZSTNxemVEQTNheVd3?=
 =?utf-8?B?bkRBRWNJSWxLb0ZyaFpxK3QrcFZzZWJlSE5vb2NFaUhwY1JDa1RYU0VSc2pt?=
 =?utf-8?B?TFN3cE5PR0lHZEl1TmpINVZ3SStmeVZsRXdkOElONmdtYk9XWWtFSlZRZlZB?=
 =?utf-8?B?bllwZXlOYmVWYmluNCtzSUNvSXNzZkZpMHhsbHFyL1p5ZGNoS3BGdzJxZmZO?=
 =?utf-8?B?dWMzdHppb1BIbm9FaFJPNytSSkpaak5QVjQremdEWnB1VUVSNFFwZFZqVEVq?=
 =?utf-8?B?Z1pZM1piRHVqRjVQUC8zeDFuTzZJR3ZGM1hsSzBsalVBVzlwMmh0N3J3dFMx?=
 =?utf-8?B?b2s2Rm0yWDVnWXVabEliOUZ3VVp3a1NnT1hpOHBSZUJLeVBuZjAwaXVCUXk5?=
 =?utf-8?B?OC9yWlcvSUpVSkczd2J2TjFTUmx4M2FoTUl4OVJ4Z3ZaeHgvcU56U2xRd3FP?=
 =?utf-8?Q?HqyRqpyG/Ek=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGd1em16ZUFSSnQ0UWtEVTBtWHRDMnNKRUpRV1NHaGd2SjRZakNkQzZyM0dr?=
 =?utf-8?B?WE1UaVJmM04xdUwrMkNrTm1xOUVRbmxTNkFSeGJDRVNNWWIyclJEMHM5cWxy?=
 =?utf-8?B?V21LWGdqZUtmaVQ2WUh5Ujg5a1B1ZnlQMGRQdEN5d3RnZExhdlVubTNXanJU?=
 =?utf-8?B?VG05U1dpcitScklUd2VZeUplT1ZVUlJIdm5ia3F3NzE5cmxiV0QvUGpURFZh?=
 =?utf-8?B?bmFiakZzOG9KSFRDZjc2MS9LUHZvZ0xWRmkxOHVHa1Zkc0lkbDlZSDR1MUNm?=
 =?utf-8?B?d0wxVksrTlROK21UbllYTm9zeTlvM29NdU14RjZhZzY2eVRkZDlTUHUvUWtD?=
 =?utf-8?B?ZzFBblF4ZE1XUHE3WjBBSmZsUzh0V1I3MGEwL2hKb2crbEpuWTNFa2lTNXZt?=
 =?utf-8?B?VWcrTTMzdXlHWkpVdG0xMjl0MmZYTUlTL1M1NG1CK2o0UTdsM3JFakwrVkQr?=
 =?utf-8?B?U2NVOEVlSVRyVTU1SlU5Q09DRnVjOWtuTGFzeVN5KzluUzBIbmVUQkdoazM1?=
 =?utf-8?B?OGRUTXVPeFVtZ1ozMGEydVJWcDdRU0o2aFUxczFONm1IMm5QZWVhMm03a1Fr?=
 =?utf-8?B?NzlxVkhoOFpJNksyTU5xOGdaeWV1ZWlBNXlrQWx5RzdaU3F1eUVKNEwyd1Bp?=
 =?utf-8?B?Z01qTmNEQWhoQ0FUdFZ2ay9YaGY4Z2V2bGpJaklDVTVvVGVYQTcwZWpySzI5?=
 =?utf-8?B?WTlsM0l0WnRvR1pVR29rT1IwTnhxa1JnK3lUcmRrMXUvNi9yUmJjSXkxRVZL?=
 =?utf-8?B?clh2YnJnaFVWcXVNZEU3V0VBTitIVFBteERpUU15akpDRGhQNk44NGI3aGZk?=
 =?utf-8?B?UUJGQ05qY0U1UnpEaHJJTm8zNGdXVFFrWisrZDB6RlpvcjhKVWhxQjNUK1dY?=
 =?utf-8?B?eWp2Z2c3WDRqbTQvNGtHQVhUTzVpM0RoaWZ1amZScEFCdlBscElxL0pLVHg1?=
 =?utf-8?B?R1djT0xDZFJYLzhXc3lkc3dvNUc0TmZqUzBhTnF2VytZeklURDVEOXhaQ3pG?=
 =?utf-8?B?OUhMa0ZlckJrdjF5a3dGTUtIVlp3R1J0Wkk0bkloakh2OXRjakMvbXZsVnVt?=
 =?utf-8?B?WmtOd29rWFVaalducUVFNVBnd3BMUURsVEVBdlZ6Q1FRSlpTakVoNVRlSjh0?=
 =?utf-8?B?OFJ3TFg2Uk9sWHJjWlZqRnBkYTZxVWZlODlYb1I1MFoyd08zdVVTdkxYb1Jr?=
 =?utf-8?B?T3JYZXp2dlR3cXMza051NllyNDNNMys1dmMwNE4zSTFVcUVCcng2a1c2Q2hj?=
 =?utf-8?B?emRyRkhDZjIyZVJzd1k1MGtRdWlnLzZjZ0xrWEF3OTVrS3lLVGxSdDJVU1Jt?=
 =?utf-8?B?eDNwajBOZnpCTy9JamwyUHRPUUNYbnlqN0RrVEtjcEFoUE80UlpOZUtKOSt6?=
 =?utf-8?B?d21LRWRGQ28wLzBmNGprY05ybmNQZzltRjFTVWU0SGJTb01hZWpSRlo0bTVI?=
 =?utf-8?B?YU8zMVVoTVBNa09ZejRURUZMTmJ2TS9YMkFsSVpaVllvYyttaUZrNWNBS2t4?=
 =?utf-8?B?MXFTZkpyQzYra2ZqQS9aRElDL1B3bzZZVHU3M2lDQS93Ly9VUzF0eW5Pbktt?=
 =?utf-8?B?bE90UmNSUUs1QnRqeFU0OUJ5ekkyUmRqMFJpRGpMWTRFSktjTGJIaEg0QW5N?=
 =?utf-8?B?RnNTRktyNFFwR1NwSEJNVU5IbFhDN25mUThhQlBaT3paWkJuR2RkT0NOd2Zp?=
 =?utf-8?B?ODJpWXMvNm83UC9MWTd4eG43QUtScjhYZzR3N0M3Q1BGVHNvcFh1YTM3VzRV?=
 =?utf-8?B?dUc2R01reU1qNEZsVGRDQ2pLZE5QSjBtaHA5bVU2cUdpdDlpa2daYWNXc2Jk?=
 =?utf-8?B?aEJOZUJWRklQMmxNeFR0L2xIaGtuczlSNk40azJ4aGMxa2JlRjVhdm9LRUNr?=
 =?utf-8?B?UzlJOS9Ia0NwZUdrTGtSb1ZEcjloVWQyRlBWWnRuSWszK0huaitLNHczYTZB?=
 =?utf-8?B?QTE4Mk5NaGo0cUFSbEVpQzlVMEFNLy82THo4VTl3RFdrM21VbzZHdGFSTXAx?=
 =?utf-8?B?ckwzQTR3R09hdGhxK2hIVHhsRERJaW02Z0NYMGNLM2Y0cE52MU8xQi9uZ1FL?=
 =?utf-8?B?VkRtWGU3UTQ5VGRCdSs4Ulk1R3pBc2tDVUJQc0N5UDFKbWdXdXJhdmZ1VlpW?=
 =?utf-8?B?YnZtVmQxMHRSNzRqaHJ3R2JkbHlVaFlRbFBRT0QyZVBheGF6QmpQcExNZlpw?=
 =?utf-8?B?ZFp4cGxxbWhwanpoMGNZMGhvcmNTNk1QbS8wSUc5RFJ2MERtVDh1R0ZpK1VE?=
 =?utf-8?B?Mm5XOFJoTXVSZ2lUZ0lRK01NY1F3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4335dbb2-65b2-43e0-462e-08dd8319c45c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 10:21:25.0341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkjuehZZ/XRTf2kz/5N+BaOARGGmevmdr+S3LsB+R1GJ8lBHfag/IBYtbOFfmllzSdWJ8rah56w+SOTBw1LjkdoxLX8RnWJvzU36xWq/t4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9175
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2OCBTYWx0ZWRfX9BXspijuw92Y
 b6iT0l9s4Slwj+XS2tRRbrZr1DNxe8mseWQhl7T1S9VPR9UEZfBg85fu4cuvHUr4/UFbR2khJ6J
 BvL3K6MNS5bcnkXVWkmxZ3PGQzN1OYtD9oUoTUZGw/XlqIoF8SmX853y9xTtALL9YQmtsILQmv4
 po2IyaFhh2mhNmM23Uj8f2p30Rnwy0AOA3L+Bqm7WZu0ET6dYQM6q+Z9l5941VDyI3L4OOYR/GW
 VN58tOr+EHPPyPL0Cb6BXkWAMlEQffXybfTBEqPdMxd0YbVwriEASt8D+YUlEjll5Qm5R5Ni8H0
 Y8XsfeB4gN1sCRwISh11mjydBb49HX4jzo2tIzw0FDAS7ykF9sLbW7PvCIoeEVIoJJqGv0eKvMe
 U+Twyl75pyzEvf7tvdn5Cv1K8+TrqeNC+DroO3tdrLNcIbycibq8BvhEEDHWHcvrl8l7/GIq
X-Proofpoint-GUID: aPxMvIuHBAp3rcgDJkYta6ZFTurtBtyb
X-Proofpoint-ORIG-GUID: aPxMvIuHBAp3rcgDJkYta6ZFTurtBtyb
X-Authority-Analysis: v=2.4 cv=FpYF/3rq c=1 sm=1 tr=0 ts=680a10aa cx=c_pps
 a=WCFCujto17ieNoiWBJjljg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=liMe0uEA847B5nD3zAEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On 24/04/2025 10:46, Philippe Mathieu-Daudé wrote:

> Most files including "exec/helper-proto.h" call GETPC().
> Include it there (in the common part) instead of the
> unspecific "exec/exec-all.h" header.

Aha!

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/exec-all.h            | 1 -
>   include/exec/helper-proto-common.h | 2 ++
>   accel/tcg/translate-all.c          | 1 +
>   3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 4c5ad98c6a9..816274bf905 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -26,7 +26,6 @@
>   #include "exec/vaddr.h"
>   
>   #if defined(CONFIG_TCG)
> -#include "accel/tcg/getpc.h"
>   
>   /**
>    * probe_access:
> diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
> index 16782ef46c8..76e6c25becb 100644
> --- a/include/exec/helper-proto-common.h
> +++ b/include/exec/helper-proto-common.h
> @@ -13,4 +13,6 @@
>   #include "exec/helper-proto.h.inc"
>   #undef  HELPER_H
>   
> +#include "accel/tcg/getpc.h"
> +
>   #endif /* HELPER_PROTO_COMMON_H */
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 38819a507b2..0408e2522a8 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -61,6 +61,7 @@
>   #include "system/tcg.h"
>   #include "qapi/error.h"
>   #include "accel/tcg/cpu-ops.h"
> +#include "accel/tcg/getpc.h"
>   #include "tb-jmp-cache.h"
>   #include "tb-hash.h"
>   #include "tb-context.h"

Moving accel/tcg/getpc.h to a more commonly used TCG header seems like 
the right idea, but then shouldn't that mean the direct includes from 
targets added in the previous commits can now be removed?


ATB,

Mark.


