Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1F3ECD985
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo2HF-0007DA-Pt; Thu, 05 Feb 2026 11:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vo2HC-0007Ct-6L
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:32:18 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vo2H8-0006pT-7p
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:32:17 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 615Bka903436159; Thu, 5 Feb 2026 08:32:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=RfBebIqiMAS2Kvk9AnFKNU9xoPm4++Rx85UcLbk7o
 6o=; b=UHv3U7ZXw9D88E7vSbjz+psl4Dmk+l0yDSXO3l5PgcwVUn2kElL4oLJG6
 UctaWF1HleqQfKzTuSZ4m7G1l78D293Vj1Nz4wAtADlQxLcfG7bm28w/ZOqkY7fp
 7HPNrtSgTQIVcNxJRlNnWu+HgWUrCO/hPEA8OjzIdZb3z0ga6BVJ+TO5KBJtj75k
 fDcewBzSVFKL5PbQT4F8IYcauYlzHsQCU8NOex0U7dItkh4scJMqiKMTqJBVy1kD
 I/Z7ebaBaawAZH4ksIAqLiqfssnvFGCL648vL/mnCY/cBbOaOMk1YO+DBJa6XOol
 7ZTA+e1OYcaD+fdm4aEb5ptg4awQA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022094.outbound.protection.outlook.com
 [40.93.195.94])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c4dhu2ckq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 08:32:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QP5nBAbdgoqXHx89Xvc93y8zt9KGVxGAUwzzBE5r0bn1tfDyBR87vYY538HCjtihff1pu8qxdSpq5iDF0i5ocAiH7wxg3WlwAww2ruDQdFUb6bXuESPMYsuRPICJkRtIReo1iirPXxhyNgl0q74eH2FsiRLmC1X6e/MJ9kOaziByt8/Qs27dXZA2TgvEg1N0NTbEszTGDWwuaeSQJ7L+E2WJfUfremJx4sGCwj8sAQcekaDFxRTL0BWuZfVnqnx7EH5P7TC+aMIrmIFNxywp6gWv74Uwrx/SLFCma5RHDJyPrQ+05NrCYnp2i7uNvAeQ0xCTJPWRphAhDd0V9MnkpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfBebIqiMAS2Kvk9AnFKNU9xoPm4++Rx85UcLbk7o6o=;
 b=GOf4zdtirbs8O2/cW7QXChPJ+FS7Te7r8g676SNruVrjzvUmH+YVKhz3ZM50cXmrE5t2mOs5h4JuVdG/XQEbDSCVGtoE9f62pReEJdFVHrjFgG+dwJ5mA7rytECvchsfrKsOFB0MoqNlPUnriR+T9M0rRsatst3uzWImRwFqsZZl+85J7gFjE777UvMkchQrbl+OgzHgzTX2WYZLVpAtTcwhushWLSf9Apq86DArVF+v5t8AGucrDzesO7DcQy+Ml1gmsfD60Stun5lSr2asza88PvIDPfqszc7vpoiA135xGJASxIHzaAdde9Gmtt7ZgOS5JNZRqK+eSoG7MHBxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfBebIqiMAS2Kvk9AnFKNU9xoPm4++Rx85UcLbk7o6o=;
 b=lSYs0tfvwp4Vjuy4rkh42cpntmutOS6+nZ/F3X7Fv2UOXP3oKIGWRxm01XUpziQDnMAqDhNn3n/F4o0x4a2zp/7MdrJosKYApbT05lxbnRJkI+S6qqazGeCoLd+Q5RiD03SkkXWf4IXEw9x9vs8v7+IQuRO+4dcfyNH+7olUIDAa/KKudz4cXvZAepOFDy3qKi1cYxpeY4frVMywkM5799gWQl5GAMl6R/KN7KCCSME12Tq6n/ig6zpxnl8RcQhapDD/AKauyxTM/m/ba3o5cKD4oLkjcTR9OZaJW0yccaKQLFTTFQyQOCvg9oUc4ZUhGboPUSHvZHPFEfmpkFNtiw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8204.namprd02.prod.outlook.com (2603:10b6:208:33b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 16:32:08 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 16:32:07 +0000
Message-ID: <f03ae1b5-4082-46be-94cb-bd225b4a883f@nutanix.com>
Date: Thu, 5 Feb 2026 16:32:02 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] audio: cleanups & add a manual test
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c323388-079f-40bb-dfc5-08de64d419a2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkNqcHpsVzM1eHUzL0UxWWxUZysxVk1PSkQxbW5wUXQzVEszMFNldjZMNlJH?=
 =?utf-8?B?Qlp4VFc3SFdyU0wvUGw4VWM4ckxSTU9uUEs4bHh3WEtySVB5NEt1cXE3aURj?=
 =?utf-8?B?cUZQSE9PVTdwYUNGclM2OTdRY0NMWVZ2aEJxbmV6d1RqQlpzS3krWmFia3NF?=
 =?utf-8?B?T1BaMU9Uc3RrTHZjNmNIaE0yTU1FU0dPblpicUlKdGdoV05LcndHQ1pJQWZE?=
 =?utf-8?B?MVQvNnJqR3Q1RjVZYTB2TDBhMDU5Y2MyeTczZFFYdnRZUW91dGtHK2M5SkZF?=
 =?utf-8?B?RjN3RmNhZElMQTNEWVoyZk9Ia1RCYkRJSEtqNURhMklZaU5yZjBlVDUwUmNo?=
 =?utf-8?B?Z1MzcEtRa1ZRYWZBTmlncEhuZEh6bll6TXdlbGVwSkd3Q2FDZmNtbFV4cFRH?=
 =?utf-8?B?NHlBMVVxYkV3VjlDRFBHdUFJWWZEbE8wYW4vTHptNjdRd3k5YWYxRlVnZlg4?=
 =?utf-8?B?aUdhRGY0aWxuVmhDSXlnUkk0SFBBSUsxakJyaERlUFNFT3JlR29Xek02RHhq?=
 =?utf-8?B?SGhhYUMxcDhxMGc5RjdoUUVSbER3TDZmOHMzdzJ2OHl0S3ZleE9FRXlxbTcy?=
 =?utf-8?B?bVNldHJnZ0tZd1F4MW5tQVF4TDVLV042ekIvbVo3d2I5YkwvNGluKzlaU2J1?=
 =?utf-8?B?N0RxK1JiMWQ1ZEtpR2dWVXhYMXl0ZTdsUjZOdllKT0h3ZGlybzJZS29oTzNP?=
 =?utf-8?B?cHFQbVpLUEFHTnI2WnNqWjV5NkxiK01XV3U2eTEvV28yYzkxRFpiMW1lZGtU?=
 =?utf-8?B?aVFsL3hhaStvQ3RnOXRGdUhpRkpLcy9NMlpYOSs2TDBEZ2ZLMC9WUVorM2hN?=
 =?utf-8?B?OWxESFZnZWdselpNY1ZKcENqV2FOWmNraEp6ZnFXeVNNbU8xNlYzN3NSNzFU?=
 =?utf-8?B?QU5hWG15K2pmTUV3ZHFjMEh5UFR2d0hzYWJKVHBlcDVLNnZJSFg1VjJZRUNB?=
 =?utf-8?B?Mk5JZU43WDNDeHI4emV5STh0VURGdW5iVjBWdThlMTZncHRiNXVjYXAxRVdL?=
 =?utf-8?B?UklWa05nRFA2cnhVSHpRUm56blR1NXRzTHB4ajJGbnA4TU0yRit5UTR6UzE1?=
 =?utf-8?B?Y2NFQXB6OEg0bFJOOExrNTJZSEZmS3lyZTV5ZUpSM3pkN3VyQ1BlWHBuRStw?=
 =?utf-8?B?R1VZb0tIQnNRYlVUMVUwWFlNWHIyWUNQNThVc2FIUWIxcC93L05wMDJtandF?=
 =?utf-8?B?bzZEajRaSERJU1hmc0E5MHg5WitzUkNJc2F0VlFKdVl3Q09Nb05KaWpxVFly?=
 =?utf-8?B?UCtGR29xK3ppVlFQK3BuVStlZkxmSC8zb3hpbFZ2endzYlhuSEtDeVdvSWtJ?=
 =?utf-8?B?b1pWZk54d0RjcGxUZmhvdHh1T2FPRDMyajYrWEtWNHVtZzhXMms5VHdkZnBr?=
 =?utf-8?B?a2REY0dGeVFNK0tveDhxMXVZQ1dqNDg4Y1FZZldxdUFPbC93bVhWVVNLaXRJ?=
 =?utf-8?B?dU5EN1QrTzhXYTFZaFBab3RnRWdtMit3ZXRpNnF6ekxTM2Z1YjgzSW5FVUJX?=
 =?utf-8?B?WHhPMmU0anR0QkdpTDFGYU5hY20xcU5ta0NpOWJhMHlqcnE1dTBlQTNEZ05i?=
 =?utf-8?B?cHN2bnpXSjJnU0RTblgxT0QxakJHMnlIcG0rSkpDTm90TUV5aXFORnFWWStk?=
 =?utf-8?B?OExpNjE3d1QvRktGQXIvdGxvM21BTSt4RExsWEhZaHkzN0UyODk2eGQzRTdO?=
 =?utf-8?B?ZzBXaW5VNGdoLzdJOEJpT1krRWluVFlHdFRGemVpU2hzYzlnK3BlaVFydC9y?=
 =?utf-8?B?NnphY1luWVQrd3UrYnVsb09wc3dIU1Q5K1l1dHR2ZExXRkpSNXZ2RzJOWHNi?=
 =?utf-8?B?c01nVlhrd1oxMytxNXB0ZHNqVUFhZEpPOTFkbjNvcGQzdXRNUk5JdEpBYzRx?=
 =?utf-8?B?Mm9XdUVDbjAwZmdhUUROZHVJRnR2bStPYTdxTDJWMjhwRGY0cGE4d2crOVlV?=
 =?utf-8?B?Y0lYMHZVTnNhd3BpRi9xeVByL24xWkgydnpxMWpJdG9YR1pHRFBiUnVxczQy?=
 =?utf-8?B?QXBLSEpxRnRETXBQYjVFaHExOU1uWVlLVnd0RDJUTG5SL00xZFM2QURaS01N?=
 =?utf-8?B?YllQQ3BreVFUbEg0T3JObjE4Wm9TN3d2dk5SL1RTL2dXZ1dTYk9pbHpCSFBr?=
 =?utf-8?Q?HNU0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1pLbTNCMm9TK0tWVEpNTGNSOCtaZnd5Q09xOGhMdERxak1yK3ZWRVA5NzBt?=
 =?utf-8?B?dUNYV09zeGE3N0Y0akxaWkt4TVk2cVFPZnJUV0M2WWlRbkNYUnpMdFpzM0pk?=
 =?utf-8?B?UnpmT1hMRktlNlFZR05DV2FCV0FlVDM1M1pWL285U04wOFF1MDF0aFVuQk5F?=
 =?utf-8?B?SDlpRTdaQ2UvOFVGT3Z2YlpyeWg2U3d3YXdtWm1qcDNBL2twSkhld3FCRlZw?=
 =?utf-8?B?KzhIMllac1RYSEdZNjNVSGsvYVFKelNqN0xENTh4MUtLS0RrUGtLbzJjUEVk?=
 =?utf-8?B?bVlzK2xwSVMwc1NLWHRWWWV1Q0JScm5waFkxUWVMNHhXMFY5K0ZJU0QvdjBt?=
 =?utf-8?B?NTM1V2t3ZVM0cU1uUnNwcDZpaHNiMFZZUWJLbmppa1VYaHRwcVY0SCtueGU3?=
 =?utf-8?B?eUpOTm9GWFBRUGtyV2RpSHFWeDBVNmdWVmhjU2NjNzlIdFpQN0NqZnNvUmZw?=
 =?utf-8?B?M2JIZytYcGJXYVdQYjU1ZGFML3JrNXZLaFE4OGRmVWdkMFVaaEovSGZ2VlFZ?=
 =?utf-8?B?Ym8zY0VmUEIrZjd1OFJ6UDhpQjg4TUQ4WDRuT0NoVXlPY3dDc29Gb2pORy9V?=
 =?utf-8?B?MDNzcHJlUWZoSDJyVHhQNVVFOEQrWW1scnlaT294VERmSWJjT3hlbGVRUEhP?=
 =?utf-8?B?aXJFaDFXRGlOTzAzbXRUaFpIQXZCenFRaHhaVGRORGc2ai9xN05Ud253Ym1Y?=
 =?utf-8?B?WVkwTnBTRm5NcjBCemRDbnVzUWxCeHRMZzl0TVpaYk92MGlyN2hGWWhGWVZp?=
 =?utf-8?B?S3AyK0FhM2ducm5CKzJCbGtGeUhCaDVXdWFXT0tscXVhemdiQUk0MzZnZS9j?=
 =?utf-8?B?eFByWnlPbG1hZ2Z2S1lwK1JTLzhxMS8zSWdXRjVlOU50R0ZOWHJ3Y1ZhMlk0?=
 =?utf-8?B?MW5ZTHR1bnZwUGRESjRlQUJpbjFJV01ybUxORTJOaHBVL3FTSGVGVEF2NWZP?=
 =?utf-8?B?REVEeTEzWHpmQmJkMmc1OTBZRlpVcFdHdklnSzJKR2NhQnZCZm9qMHc0b2Rp?=
 =?utf-8?B?MDQ5UVAzR0hhRHh2SnFVMHNJckRWSHF5VGtybE9rUGEvYmRuTlFNVEN1bStm?=
 =?utf-8?B?YVhvN2xMbll4NVVzeFEzN1FMbUFWd2h5OU9SNTlNd3BrMVFCSFVObnd4SUF5?=
 =?utf-8?B?N2FzSklGSTIrZzRNSlFJR1R6czFIRGt1UFNRajF6RnlEV1NJY0dDTHliWnJu?=
 =?utf-8?B?emJ4eW5yZUMydnQvaHRsQXlpVGptQ2hOcC9pQmVvT3pBZHNJQVFDRzN0MjZi?=
 =?utf-8?B?dFdwOHZXTFAwVkRMbmUvaWdRcU1jUUlPTTd4cE9hNnBEaFgzenAya09DVXFv?=
 =?utf-8?B?QytpbWJ1MmtJK0hkY3JJREFMWWdCaXMvVkpnUTNIK1FQQ1RQMnJ1MFhTVWpI?=
 =?utf-8?B?dFliN0ZMSzRRZm50R1hXK2YrZFozcmdPb1NRdlNNSGRpeG9PM1NtNWxUU2JZ?=
 =?utf-8?B?UU43Y0Uvczg3bUxpd0JRd0ZwTXh4M0ZnNmE5cjlvNFVuUjV4TE1rY2p2cXdY?=
 =?utf-8?B?RG9RT1BpQnhEcEVOcTUxYUR0ZnBQVFdodVh0cWNtdFBMZGovVWRPVWxTOUNh?=
 =?utf-8?B?SDZDdnQ3SDdUeExTa3RDbzNTazJ5KzJ5M25pVklyQnVaUStMdXpWWnJrZ25y?=
 =?utf-8?B?VWQ3MXdWc1hjejdzRmJQeUp1bzJMVlVMa294TEtFKzY3YmtJVktpNGVtNjJD?=
 =?utf-8?B?WGdzZEtsbWdHSmNHRitVRkNyRVltVUNBZFFxbW9lR2ZZT213bloyQ1JtWHNi?=
 =?utf-8?B?b2I3QnZ1anVEYi9IZDQ1dVRFTGJoUUlpNlV3dXl2dUFMU1N6SjdRdDlkUnhm?=
 =?utf-8?B?NlA0ZVdHZktSUStXQnBRcUZhalI5QVpYaXA2ZEdQZjJuOENaelZlVThTbUJv?=
 =?utf-8?B?U1BBd2ppdXRxUnllVFhQYitUUW1leWp2c0xhNXpST3dOSXBTTUJwcnpta3BE?=
 =?utf-8?B?OWUwY0s2bnkxRVhNUDZGajdYZEZ5aTVaYURsLzlCN2ozeG50RlVDNDMvU1VJ?=
 =?utf-8?B?ZFczT3lYMGV4dU5ZV1c1VmVXdGZDTzRhNGoxenJsMGJ3Q3ZNeVV5aHUrZDZa?=
 =?utf-8?B?ZUE0SDN2dVo4U1ZQQTlaZ0ZxZ3pUMndiajQyc3pPUVVjbUpkeitCL2h5TlRZ?=
 =?utf-8?B?YmVIWVh2QVFveE5XSzhlcTNhaGZIOTBlMFMrRUdaR0plNjlnanBicjk4d2Vi?=
 =?utf-8?B?d2NRZUxURmxKQWoyN0Y1cGphSTRjTm0wd0dhU3VJNlZjZzl3TllRd1JTeGxO?=
 =?utf-8?B?TGwzbkRTdlVaYnRJRlJ6MUFiQTRPUlpvNjROMnBqZGlmTlZQeUVBMDBMd3hy?=
 =?utf-8?B?VmZUNldXWmN3MnhXSTkyZXlab29qcjFBeWVrRitGTVphSDlFZDBqaE05djNo?=
 =?utf-8?Q?6rya/7KrGDGmBmcA=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c323388-079f-40bb-dfc5-08de64d419a2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:32:07.0312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsaUpoahWE58+khD5zVU+WzVpu0Siut6YC42AbGs2OBl5qk9v5iGee0Q5yDY83HVKqmCnYPYuHKknjqrYkBBWeZqnAKrHp+0cGPBu7Zyz8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8204
X-Proofpoint-ORIG-GUID: xYlXEfDv3M5E8Pi5qGu8fvwo_74R7dT_
X-Proofpoint-GUID: xYlXEfDv3M5E8Pi5qGu8fvwo_74R7dT_
X-Authority-Analysis: v=2.4 cv=ILAPywvG c=1 sm=1 tr=0 ts=6984c60a cx=c_pps
 a=rF5r1hn1HlY1CZmlW+R7dg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=R_3FxeouoDMaj8naW50A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNCBTYWx0ZWRfX4YXOtPCD7N//
 RF7gaudkNQlWg2v7YPQ8QFYJ7K5hP9zXCxqqyo+r8FSo6pGG0dwzTq6Pf5rz66jIKHvULBf62HT
 8xaoU/frZ+0BEXXPLgGioUbpzVWgfz2x8B/t3RCpktd+ZY6eH8KnhXd5IAOPn1t5eA+yw/7KRe/
 pkvNTlhcS7d2qbNjeLNx61SYCcPKaRTONFgBjBSaEbLxoYPySjuWh39trAA4K537T3FbOD96Sy8
 ebysmp7KX5O/bdTKUvfumPI7JUKhD3v8UAcLarpggc/GrgF3Fwgmp2SjQ2tNP+AB2FrQZYK0zQ7
 lU2ZYlfyl681ig7hfD38ag+yogPoaXIhhL2gQTGKVFTYgz6pWacjgyFT9FP/NRwU6dj/g1+8Mi1
 4UhM+uBS4w7H4RRO/gVRXwwD27ybd1588gD8mZlgmEWvTGsRc4fB6zajRcj8AnEPX6PgHke5PNq
 RUAysChfzIvES5njDEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi
> 
> This patch series is part of an ongoing effort to clean up audio/, initiated in
> QEMU 10.2. Some of the patches were previously posted as part of the "[RFC
> 00/24] audio: add GStreamer backend" series.
> 
> The complete series finalizes the migration to QOM and improves error handling
> and logging.
> 
> Marc-André Lureau (37):
>    audio: remove obsolete/obscure functions
>    adlib: remove dead code
>    audio/adlib: drop ts_helper HWVoice field
>    audio/dbus: make "dbus" the default backend when using -display dbus
>    qemu-options.hx: clarify default audio backend selection
>    audio: replace vm_running with runstate_is_running()
>    audio: list backends as modules
>    build-sys: create a libaudio
>    scripts/modinfo: add type annotations
>    scripts/modinfo: remove trailing ;
>    scripts/modinfo: use in instead of find()
>    scripts/modinfo: use f-strings
>    scripts/modinfo: use argparse
>    scripts/modinfo: make --devices optional
>    scripts/modinfo: add --skip-missing-deps
>    tests: start manual audio backend test
>    audio: constify audsettings argument
>    audio: introduce AudioMixengBackend
>    audio: simplify audio_init()
>    audio: move object creation to audio_driver_init()
>    audio: add QOM module-objects for each backend
>    audio: remove set_dbus_server from audio_driver
>    audio: lookup "audio-" object types, and realize them
>    audio: drop audio driver registration
>    module: remove audio module support
>    audio: keep a strong reference on the backend
>    audio: make list type declaration private
>    audio: make create_pdos() private
>    replay: remove dependency on audio/
>    audio: make all the backend-specific APIs take the be
>    audio: make AudioBackend truly abstract
>    audio: split AudioBackend
>    audio: AUD_ -> audio_be_
>    audio-be: add common pre-conditions
>    audio-be: add some state trace for debugging
>    audio: split AudioMixengBackend code in audio-mixeng-be.c
>    audio: make audio_driver init() & fini() optional
> 
>   meson.build                                   |   25 +-
>   audio/audio_int.h                             |   59 +-
>   audio/audio_template.h                        |   78 +-
>   include/qemu/audio-capture.h                  |   24 +-
>   include/qemu/audio.h                          |  132 +-
>   include/qemu/module.h                         |    3 +-
>   include/system/replay.h                       |   11 +-
>   replay/replay-internal.h                      |    2 +
>   audio/alsaaudio.c                             |   30 +-
>   audio/audio-be.c                              |  276 ++
>   audio/audio-mixeng-be.c                       | 1983 +++++++++++++++
>   audio/audio.c                                 | 2245 ++---------------
>   audio/dbusaudio.c                             |   46 +-
>   audio/dsoundaudio.c                           |   27 +-
>   audio/jackaudio.c                             |   27 +-
>   audio/noaudio.c                               |   27 +-
>   audio/ossaudio.c                              |   31 +-
>   audio/paaudio.c                               |   27 +-
>   audio/pwaudio.c                               |   27 +-
>   audio/sdlaudio.c                              |   27 +-
>   audio/sndioaudio.c                            |   27 +-
>   audio/spiceaudio.c                            |   27 +-
>   audio/wavaudio.c                              |   27 +-
>   audio/wavcapture.c                            |    7 +-
>   hw/audio/ac97.c                               |   42 +-
>   hw/audio/adlib.c                              |   31 +-
>   hw/audio/asc.c                                |   20 +-
>   hw/audio/cs4231a.c                            |   18 +-
>   hw/audio/es1370.c                             |   26 +-
>   hw/audio/gus.c                                |   11 +-
>   hw/audio/hda-codec.c                          |   36 +-
>   hw/audio/lm4549.c                             |   20 +-
>   hw/audio/pcspk.c                              |    8 +-
>   hw/audio/sb16.c                               |   22 +-
>   hw/audio/via-ac97.c                           |   20 +-
>   hw/audio/virtio-snd.c                         |   36 +-
>   hw/audio/wm8750.c                             |   43 +-
>   hw/display/xlnx_dp.c                          |   16 +-
>   hw/usb/dev-audio.c                            |   18 +-
>   replay/replay-audio.c                         |   51 +-
>   replay/replay.c                               |    2 +-
>   replay/stubs-system.c                         |    8 +-
>   tests/audio/audio-stubs.c                     |   53 +
>   tests/audio/test-audio.c                      |  582 +++++
>   ui/dbus.c                                     |   20 +-
>   ui/vnc.c                                      |    4 +-
>   audio/coreaudio.m                             |   27 +-
>   audio/meson.build                             |   10 +-
>   audio/trace-events                            |    4 +
>   qemu-options.hx                               |   22 +-
>   .../codeconverter/test_regexps.py             |    1 -
>   scripts/modinfo-generate.py                   |  146 +-
>   tests/audio/meson.build                       |   18 +
>   tests/meson.build                             |    1 +
>   54 files changed, 3999 insertions(+), 2512 deletions(-)
>   create mode 100644 audio/audio-be.c
>   create mode 100644 audio/audio-mixeng-be.c
>   create mode 100644 tests/audio/audio-stubs.c
>   create mode 100644 tests/audio/test-audio.c
>   create mode 100644 tests/audio/meson.build

Hi Marc-André,

I've just followed up with a few more comments, but in general this 
series looks fairly good to me. It's definitely a huge improvement upon 
what is already there, thanks again for doing this.

I'll have a look at part 2 when I get a chance either tomorrow or at the 
start of next week.


ATB,

Mark.


