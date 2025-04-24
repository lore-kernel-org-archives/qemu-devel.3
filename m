Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F6BC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tsl-0006N9-Qz; Thu, 24 Apr 2025 06:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tsf-0006M9-Tq
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:32:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tsa-0007Ur-0y
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:32:33 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8NXlK006285;
 Thu, 24 Apr 2025 03:32:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=oXSFP6guVj2f0v0rVyhyG8RpbdujE19hYLb0pWsf8
 +E=; b=wwc8+lRF4/Dij6mSBN9SdAMis2z1EIaUuDDO+Um832VuSdg5+mIFqUchy
 isp7hHVSpwB6UXsoLaAtJA2gUXDanrigQVEI3rS44jQZ47ikTj3jK6GPcLeO3IlI
 7jQF/P/bsuZjRn1HX2t6OWFZJz1dPlikf0xCk8rVTQ+PJHgi7YytsNK35858QDD1
 WNkJE6nahOqBIHOnRKfmIUIPNqgqBs2X4AY4LyI3QpHITESl8zIsQLKSTN4MwTob
 o/nxP15J34GOqMKwxB1UoYBSnLQ3oXI0xKzlhy6NsqOKlOLrl0iBrA8Op8awJ7iZ
 0TiX7KoM9FBO2/nvFeZmZIpVS3JoA==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazlp17011024.outbound.protection.outlook.com [40.93.13.24])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 466jhq4cp5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 03:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsatX4k15xmbRAX2L1TC/ySYfSCAgzNEKmi0Q9PXDRqWEvnuzYARDGIgq8zf00//y2knDl9/88ntm2Q5DPRRt2eg2ZQAUw8a4pbQDvqDDHrOP+5MMzfub550g16YQtMkEvnz9PFrwogEoaXTB6kTWOx2XK2R5d3ql2CmgcT+LdktygaC++hTgl2DPodwkS0XrQkFnkoC7LWes25FBkB975ZEsDmw/UUuX6TRUSp0TnLhZm0I2Vd3Sr1R6rjqp8wRYJSEFx1BQD//L0G41OGkZj6PQBZq9F2Y2epl+5pjaTs/3vHRAJ2zh8wl/AwcrcYGh9HJ21glOv1LMNWwoimMJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXSFP6guVj2f0v0rVyhyG8RpbdujE19hYLb0pWsf8+E=;
 b=TNGLbTIhQMzxR2WPImYefDMoraIV9Vo0xFR1wt6litEuWVVaz4ue5i2JEKXfGE7r/y38JO89z0oj1Qy/L8KPiJpzqyEQ91ovcEUtTsCDCMoXzvb11ZUTmIVC5/SUJMLt+KgTCBeSkqeUgveW89VIftVbBK6Qq65XITE4Far8ZLXhNyp34zUJoMkR6DBN4I2tAC6UjDZFA37UNWdQR3KRQVpiIC6Gl0EQcWqNNc7X16iLuQLnU29CdNgiJMYtNAqoJM+79Zg72NdIsbtovHlg3BQaKAkRcj0OUon9DaNn/6ZlK967r1Rd9tHoIdYKWwtupFPNIfxU8h2O8t2tZxAIug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXSFP6guVj2f0v0rVyhyG8RpbdujE19hYLb0pWsf8+E=;
 b=apXLi07wPypMI243et4TW6TfRDJAMq8WfbW67nZ8Z4AcSB6iix+R8iNehdoJ+VsjENYCwgCOhblXIl/1RwYEkoyEeutTAhXtyOLCa0HcoiUjEH8aGmUQBFWhW5FsB2CZtcmYvkWkkZBLYfE4rH2a1Iq5MwNPnFr4EEzEwzgPt5h/MgW0zIsHHJsU4O7z5SyQKEkH95sxeRyVGBAbI2H8uj3oh9qDZOHs7oa60RPZnp+HQWeknPFBBpTOrnUd270VMau2ct5n3aMvdmYmdlhecZT2aMGDamF2xRrDkAw+wPDMhmjgte9pWt160BxRkirn17raR8p3XjGDcAwPnJJmmA==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 SA1PR02MB8366.namprd02.prod.outlook.com (2603:10b6:806:1f1::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.8; Thu, 24 Apr 2025 10:32:23 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Thu, 24 Apr 2025
 10:32:22 +0000
Message-ID: <918dd3e0-4366-4747-846c-aa3696f7a8a1@nutanix.com>
Date: Thu, 24 Apr 2025 11:32:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] include: Remove 'exec/exec-all.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-14-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250424094653.35932-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0087.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::28) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|SA1PR02MB8366:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ed6d32-fc0f-4c39-5583-08dd831b4c5c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|7053199007|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUtWQkNFUU83Tm0veXRJTTdBelZ1NXAzN0dsU3dvazVOeEFMdXc0bzRBdkdX?=
 =?utf-8?B?MFlkcjY2SndkazdDOHphb0JibVR2Q3d6VVdIWWh5ckkrNFpSeEdFRFhQa1d6?=
 =?utf-8?B?ZWxmTjU3bWVPMXpVcUhJLzdoWjVua0MwbHRwOStJQllObDFzbWVZaHhvTmtV?=
 =?utf-8?B?NmhUeVAwOTF4K0VnT0dLV09GQjJWbEk2M25lQWNuOVdFL0VZMjNxZVpkWWZF?=
 =?utf-8?B?ci8yTGJwMC96OEI4MDhKS3d4Q1pDYnJxdjdWbVpDazFyV09MZXc1djNqMDQ3?=
 =?utf-8?B?VG03dE9YaEZJKzNZc0ZmdWZYOUVOU0E1Y1p4U1p5WUErVGlacHVMRjdYRmVu?=
 =?utf-8?B?U0lyWWZCNC9WcFlRUk1vYzE2NGU4L1JWSGVMY1dHSk1vajFPU2hwUWhyUDVC?=
 =?utf-8?B?M0dvLzFwcjJqOTY3OGJsS3g1SnlZV21BRFJPZFZDN2hmKzlnc3FJNzJZU0kz?=
 =?utf-8?B?c3lWMGlSSUxxKzVTaEdhdjVjK3Raa1lUSlE2UHd5cmxwRE1vWk1kS3IyV3Fq?=
 =?utf-8?B?VmVOMytaVEpTZ2dZcjI2cVh5amF1VUxHVkJPTWVMaHArN0l5SFZMai9IUTJ0?=
 =?utf-8?B?ZTNDMlBFNSt0a0Q4MDJNWHJYL1p6K3NQaXVVczlMdWRhTFpnbGtHeDFwd3hL?=
 =?utf-8?B?WXcrRk0rUFlGeE5wNEpwZHVzbU55L1daYXRDdHN0RFpaVW5XdjVTWThWYmRT?=
 =?utf-8?B?STVaRC9xOWhWaXhsUjZEZElXRi9TRkgwK1ZIMVVRRUtQNVJ1NU1oR0EyRFRj?=
 =?utf-8?B?ZXpmM2YwTmdTc0lTdDIxTDJUb1hRZjBUcE5jWVA1YXlQNG5kS2FzNldUdUdC?=
 =?utf-8?B?RUIvZldKbHBtMWFoZ1R2SnRFZCs3VXlUREJyQWpsZVFJK3lhM3FDWXpCbDBI?=
 =?utf-8?B?M0NZbVdMU0pva3VEazExSnZ5K2tLSW56cWtBOWVuZU5hK2Z3dnN1VHlpbGV0?=
 =?utf-8?B?aWl0cWtuM1IrVWRRMGw4NllIdHBZMURGcjRhbnMrRkovUmRBbk5aYmh6dzJ2?=
 =?utf-8?B?NU5uMDVhNWVWTEE5eDNjZEJONlllY3dQWGxPVThLa09rRXdQODVBZTNnR3JL?=
 =?utf-8?B?TS9qRkJqTEhQQm9scDVJbFBMWHVrMW1uR0RoT3NOSDVuN3NKdXhwMmROMWRQ?=
 =?utf-8?B?U1RsNEI5MU0rckhpaHNJL1RFekNheGxCcVU0VVNxNGNsZzJQWXR4VzVyVzNX?=
 =?utf-8?B?bEIyUjBxUzVLeUhReVZ6MkhsT0hGREZTN0RqYXZHTGRtT20ySnY0NnNNbFg3?=
 =?utf-8?B?Qlh1SnEwbTVQb29zWUkwWDl5eks1dlZ1WThqZUlEUGM0bUVWb0RqSkQ4aG1T?=
 =?utf-8?B?MUxXamtuc1V6cTc4K1RKWEYxdTRSWmhwNGQ2U1d5R1RSSUs5UnZCTC9MTyt6?=
 =?utf-8?B?eWY1Qk1RNUFRL1VKb3FzUEl5U2o0QTI0aTBzQkppNW9uYUhwUVhKR3BhMDRk?=
 =?utf-8?B?K1ZLOVo2S0dzck1SYWQzT2lpVmlNeHlkRWNSVUJBMjlyVi9HTHNFdU1kNnBJ?=
 =?utf-8?B?S1pTME9ISFhuQ0NiZVhMWE4zSW5FR3U4UXd2U014ZGFPKzlJYWRRSm90U3Fp?=
 =?utf-8?B?Y1lVSlViRE5KR0IwdXJwWjRNeTRQVzdEZ0ZadXBLNXc4enNZNHYvejh4bUp6?=
 =?utf-8?B?WWRPcVduNHlTaEdDbTUxVkRGQXltOTYzSVQyRXlzVnk4QTVHdlNTRXRDQVhO?=
 =?utf-8?B?YVBEc3RPZjJ1UHgwVjRQYXBsb2FZY3QrMHQyaWppeFZuSUxNeW9HR00yL3c2?=
 =?utf-8?B?UkRzYWZBZC9wbzhuTmJiUnFTMm9pR3paZ08xVGZ4UW9vLzBDaXlRVVJLZDVO?=
 =?utf-8?B?QUJxVXlDTXpJYlVKdGcvYzVoQm43QjBzdXVENkhORW1FWkJ5ZTBCNVA2N3Fj?=
 =?utf-8?B?elNUQy91QWhJU1Q5UTJlaWJXNDc2NWZkUmlvSFh0S0trcEZLdlc4WjhkcGJ0?=
 =?utf-8?Q?VfhGaD3Eb1I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVk0UXJyUUIrL1BHcHdnZkVtdGhKRXdNZGlCbzAyam5RSW9yLzl0dVlGMHJM?=
 =?utf-8?B?OUs2NkV1VnkySzFFWXhXWG41ckJKLzY2WVcvWVh1Z2NmbXFSUFJyNnRrbmdD?=
 =?utf-8?B?VjdGUmRRUkhSakhJL0JScitvdnpSRUthVEtISzI4WDNPcWVoZzJuYzQzbEMw?=
 =?utf-8?B?RUVkWUFXNGxLT2dRc3hYN0xYWFVMVzVQK3Z6SUptaEJ2QWNNVU54QkJjVEVh?=
 =?utf-8?B?OUFIeHZrVmJJaUdUb0wwY1daSG9NTEx5QlRMTWVBRGlIdHQxcy9uZFJ4RjFW?=
 =?utf-8?B?WlkvSjZCQjFTSStrOEV3VnFqelhjaVZJbDhETEwzaWdvaCthVVNaRzBjMDlD?=
 =?utf-8?B?aHg0SVZ3R3RpSHpyTmgrYlhnZWxHa3VzZVZoK1NyM1JIRXRxTTNQZ2xibU9W?=
 =?utf-8?B?djVGdWlpR3NSUEpqQy9sQmZHRi9lRjhzemlWOHRBNHhHSDZHMVkrNnV5RDdu?=
 =?utf-8?B?Q3RUaWIyWmRabDJwRUR2S3pYNmJKYkpQSGcvZjVncUJDdEYxTk5mL1cwYi9F?=
 =?utf-8?B?d1JSTVlxUSt6c0p4WkkySnlCbkdxSitnaFVRWUJBaFBDdS9ZNzdlWWpYSDJx?=
 =?utf-8?B?N3BHNTFiSlQrQktOeWJvSWU4MVZDVGNSbkNJRlZId2RZU1N6dkhBY045STNu?=
 =?utf-8?B?Ymw5YmRrQ1Exb1RNeC9ZK0ZpaEJETHUvMzlSbGJBU0RUUjN5bGs5RHFjcERV?=
 =?utf-8?B?SzNHTWtTM3JLUFdaUHB6ajlUM3dtYS84T3Q1bGJuSllVTlZqcnk2REVUOUdv?=
 =?utf-8?B?TzUyQk03RzMyMXRJVFZvK2xTQjFZTzk4aEFSNWMwejREMCtGUHczTUtmTmNS?=
 =?utf-8?B?ZmlBZldNODlKSGsvYTBYUDRhTms3eGdNcHF4cG9DeTNMY09SZjZneXFhVmFC?=
 =?utf-8?B?d3ZjMXg4eUxTTi9iQ3RDYWt4Mlk4dHJESWVBWVcyWkowWmlldUtrWkZjS2tx?=
 =?utf-8?B?MFQwcmRxRkJPcDNmY1QwR3oyVlFkb21zQkpHeG5SdmwyT1JVRDE2NzEwMzk3?=
 =?utf-8?B?UTlFYXZSUjdNZHlvcXJndEFqV3NTeGJiWTFVamo1ZVdRcjdkQ0VNdmEvNkdy?=
 =?utf-8?B?am00OWhLajE1K3c1Z1VOR3kxeTdKSXJ1WjVteDROcVNvT2JnMTNkSkFJSmxY?=
 =?utf-8?B?cm84bnFIdVFkTSttM0lVZ0phLzRrbFFwODR2MUVKa1VkSDNscEdrZWJhVG5q?=
 =?utf-8?B?cmZ0T1c0L2JpdUxmL1M3K1Q4SUlodTVqdlFFTGFXVDZaT21wNDQ2UTFneFd0?=
 =?utf-8?B?cWFmc05ZcnVVWHJLYkFaWWFjVDFUa1lUY1hHWWZnRldZUTBYd29ZNWVFTFJW?=
 =?utf-8?B?cE03dDJkUTllQ2d0Z0xlZkxOVWFpcFJiYVF6Slo1UzdpS25lMU5uV2NGMmZE?=
 =?utf-8?B?YlllOUthL3dWVUZMakkvWk8xTkRuTWIxalVDSHRVbUpRUVRDakFxQlZBRkRH?=
 =?utf-8?B?RzRTZ2YreklReG1vV2E1K3AzUVpGekx1ajRTeDdFdkR0bXlpWXFRQVl1TTVl?=
 =?utf-8?B?cW01Ymc3OW4vcktIcS9NbGgxK01FY1Irc1NjaEpnWGI1L0FtYWd2eHpKY3Fu?=
 =?utf-8?B?d1VzbWZ0aklkRE5tSXVTSWkwVndEVmtQZ1MwUHNRNGFGRFdGSnpDeFI5YytO?=
 =?utf-8?B?SFFZbE9NU01ZbVJiWlMrYVpRd1FJaWRDTEJtSFoxYzRYSElkdzJmZVhxM2tP?=
 =?utf-8?B?UGRzeERpTkV2eXZ3RXpuV3NWc1orTW1PTDF3elNUbE0yRkNuWm95c3NMWXZj?=
 =?utf-8?B?R3A4eERRbkJTUUJFczIxWHZuMy9oYm0vU0VJVXJxZkdhMkx0S2k0SjZlYlBh?=
 =?utf-8?B?V0pRNjBEUEs2eXpSRTVWenlJUERNT0ZKK09LcFJ2S1pnNWhpZ3RQdmZQTFVK?=
 =?utf-8?B?aHh2ZnNhS0xsTHlSck5NdVhWODVoUTFHbHAzQTdtMFZIZFFXLzlqK0RBMTZi?=
 =?utf-8?B?WWllSVVJQy9FVjB3ampJTzJocnozY0VSejd0KzZVUXhITVFTTjhnVzd5bkFz?=
 =?utf-8?B?TE1TTGhWK2dmdGk2dW9FVUJyV2xWeFJZQWNHNWMxQmR0T2hHSSs1RVE4bnZV?=
 =?utf-8?B?QVE4bng4aEZHd3ErbkdxSnM2dzFnWTV1bXlQaXhSWjl0dGZ5M2dCNnV2cTYr?=
 =?utf-8?B?UGhKNk4yZ1FNem9rak81TGc1YkYzRWpUd3FHZVpEM2J2R1AwTEpkYVVSRUhH?=
 =?utf-8?B?YXNOUEdVa21DM2JMK3dDTUhXQUpWQlhBQmJWdjZoc1BnNkZVUXNnekZUSEU5?=
 =?utf-8?B?ODZrbnd6NFBnQ0w1ZkhwTVM2TjdRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ed6d32-fc0f-4c39-5583-08dd831b4c5c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 10:32:22.8794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +chw6D6h9ihR9NiBZ1ZPfltcP2khnZasUbfckMfaKxurKdAlJuGdu69eZoO5GCIgIt3CYwmGLIisfzqfaVgspuc2iV2RQ9D3TgyBf7kPlyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8366
X-Proofpoint-GUID: d-3FlbZfKXcGQFKpw882YVKxkYbrnBNF
X-Authority-Analysis: v=2.4 cv=fNo53Yae c=1 sm=1 tr=0 ts=680a1339 cx=c_pps
 a=pibkrh05mLzxjy7FsoIMmA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=mDV3o1hIAAAA:8 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=bXJMdId2tRviYgKhwesA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: d-3FlbZfKXcGQFKpw882YVKxkYbrnBNF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA3MCBTYWx0ZWRfXzLXecjehd7dW
 MvSf+sygK5Yjm2sSMgnoXE1bOlWb/A0FPKCUvswmrff9/cmKTQkTtCShr5FeWbSWQO2PZkdlUin
 dU+SYn2kgoieX9ZCkKYmrztYae0mxs851g1mgAISuCEvw6u6PE5e39sTLxBdvO892j2suYEadDt
 beItLmw24e2b+KGK8tI1O1ASE1Mrw1C82zwqrku80kqXisVr+gD86VlqsjAvflMt4cHa4ydT3wH
 9MK1hh03Ie/lvHPoQT1AqvBsYP5SXczrMsqoU2zUj7MAWySINWC6ZbgOG2ut/1h0RL32Uvz1a/c
 Gay7f7j1UhsTSxWJBAYpOe0gcmaphkM1u3wZgNR0/T1eRIRY5/pE6kc1RDwdzrUfbg6KX7ADuD4
 5wgQZoGCf7PDChL8UdD9z8JqMv9e5nEar41y3XcRZX4mSnmS3TplhtTY6LIh7lI9hxxP4G0J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

> "exec/exec-all.h" is now fully empty, let's remove it.
> 
> Mechanical change running:
> 
>    $ sed -i '/exec\/exec-all.h/d' $(git grep -wl exec/exec-all.h)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                             |  1 -
>   bsd-user/qemu.h                         |  1 -
>   include/exec/exec-all.h                 | 23 -----------------------
>   include/system/ram_addr.h               |  1 -
>   linux-user/user-internals.h             |  1 -
>   target/arm/tcg/translate.h              |  1 -
>   target/i386/tcg/helper-tcg.h            |  1 -
>   accel/hvf/hvf-accel-ops.c               |  1 -
>   accel/tcg/cputlb.c                      |  1 -
>   accel/tcg/translate-all.c               |  1 -
>   accel/tcg/user-exec.c                   |  1 -
>   bsd-user/main.c                         |  1 -
>   hw/ppc/spapr_nested.c                   |  1 -
>   hw/riscv/riscv-iommu-sys.c              |  1 -
>   hw/sh4/sh7750.c                         |  1 -
>   linux-user/main.c                       |  1 -
>   semihosting/uaccess.c                   |  1 -
>   system/physmem.c                        |  1 -
>   target/alpha/cpu.c                      |  1 -
>   target/alpha/fpu_helper.c               |  1 -
>   target/alpha/int_helper.c               |  1 -
>   target/alpha/mem_helper.c               |  1 -
>   target/alpha/translate.c                |  1 -
>   target/alpha/vax_helper.c               |  1 -
>   target/arm/cpu.c                        |  1 -
>   target/arm/debug_helper.c               |  1 -
>   target/arm/helper.c                     |  1 -
>   target/arm/ptw.c                        |  1 -
>   target/arm/tcg/helper-a64.c             |  1 -
>   target/arm/tcg/m_helper.c               |  1 -
>   target/arm/tcg/mte_helper.c             |  1 -
>   target/arm/tcg/mve_helper.c             |  1 -
>   target/arm/tcg/op_helper.c              |  1 -
>   target/arm/tcg/pauth_helper.c           |  1 -
>   target/arm/tcg/sme_helper.c             |  1 -
>   target/arm/tcg/sve_helper.c             |  1 -
>   target/arm/tcg/tlb_helper.c             |  1 -
>   target/arm/tcg/translate-a64.c          |  1 -
>   target/avr/cpu.c                        |  1 -
>   target/avr/translate.c                  |  1 -
>   target/hexagon/cpu.c                    |  1 -
>   target/hexagon/op_helper.c              |  1 -
>   target/hppa/cpu.c                       |  1 -
>   target/hppa/fpu_helper.c                |  1 -
>   target/hppa/helper.c                    |  1 -
>   target/hppa/mem_helper.c                |  1 -
>   target/hppa/op_helper.c                 |  1 -
>   target/hppa/sys_helper.c                |  1 -
>   target/hppa/translate.c                 |  1 -
>   target/i386/tcg/access.c                |  1 -
>   target/i386/tcg/excp_helper.c           |  1 -
>   target/i386/tcg/int_helper.c            |  1 -
>   target/i386/tcg/mem_helper.c            |  1 -
>   target/i386/tcg/mpx_helper.c            |  1 -
>   target/i386/tcg/seg_helper.c            |  1 -
>   target/i386/tcg/system/bpt_helper.c     |  1 -
>   target/i386/tcg/translate.c             |  1 -
>   target/i386/tcg/user/excp_helper.c      |  1 -
>   target/i386/tcg/user/seg_helper.c       |  1 -
>   target/loongarch/cpu.c                  |  1 -
>   target/loongarch/tcg/fpu_helper.c       |  1 -
>   target/loongarch/tcg/iocsr_helper.c     |  1 -
>   target/loongarch/tcg/op_helper.c        |  1 -
>   target/loongarch/tcg/tlb_helper.c       |  1 -
>   target/loongarch/tcg/vec_helper.c       |  1 -
>   target/m68k/fpu_helper.c                |  1 -
>   target/m68k/helper.c                    |  1 -
>   target/m68k/op_helper.c                 |  1 -
>   target/m68k/translate.c                 |  1 -
>   target/microblaze/cpu.c                 |  1 -
>   target/microblaze/op_helper.c           |  1 -
>   target/microblaze/translate.c           |  1 -
>   target/mips/cpu.c                       |  1 -
>   target/mips/system/physaddr.c           |  1 -
>   target/mips/tcg/exception.c             |  1 -
>   target/mips/tcg/fpu_helper.c            |  1 -
>   target/mips/tcg/ldst_helper.c           |  1 -
>   target/mips/tcg/msa_helper.c            |  1 -
>   target/mips/tcg/op_helper.c             |  1 -
>   target/mips/tcg/system/special_helper.c |  1 -
>   target/mips/tcg/system/tlb_helper.c     |  1 -
>   target/openrisc/cpu.c                   |  1 -
>   target/openrisc/exception.c             |  1 -
>   target/openrisc/exception_helper.c      |  1 -
>   target/openrisc/fpu_helper.c            |  1 -
>   target/openrisc/interrupt.c             |  1 -
>   target/openrisc/interrupt_helper.c      |  1 -
>   target/openrisc/sys_helper.c            |  1 -
>   target/openrisc/translate.c             |  1 -
>   target/ppc/excp_helper.c                |  1 -
>   target/ppc/fpu_helper.c                 |  1 -
>   target/ppc/machine.c                    |  1 -
>   target/ppc/mem_helper.c                 |  1 -
>   target/ppc/misc_helper.c                |  1 -
>   target/ppc/mmu-hash32.c                 |  1 -
>   target/ppc/mmu-hash64.c                 |  1 -
>   target/ppc/mmu-radix64.c                |  1 -
>   target/ppc/mmu_common.c                 |  1 -
>   target/ppc/mmu_helper.c                 |  1 -
>   target/ppc/power8-pmu.c                 |  1 -
>   target/ppc/tcg-excp_helper.c            |  1 -
>   target/ppc/timebase_helper.c            |  1 -
>   target/ppc/translate.c                  |  1 -
>   target/ppc/user_only_helper.c           |  1 -
>   target/riscv/cpu.c                      |  1 -
>   target/riscv/cpu_helper.c               |  1 -
>   target/riscv/crypto_helper.c            |  1 -
>   target/riscv/csr.c                      |  1 -
>   target/riscv/debug.c                    |  1 -
>   target/riscv/fpu_helper.c               |  1 -
>   target/riscv/m128_helper.c              |  1 -
>   target/riscv/op_helper.c                |  1 -
>   target/riscv/tcg/tcg-cpu.c              |  1 -
>   target/riscv/translate.c                |  1 -
>   target/riscv/vcrypto_helper.c           |  1 -
>   target/riscv/vector_helper.c            |  1 -
>   target/riscv/zce_helper.c               |  1 -
>   target/rx/op_helper.c                   |  1 -
>   target/rx/translate.c                   |  1 -
>   target/s390x/interrupt.c                |  1 -
>   target/s390x/mmu_helper.c               |  1 -
>   target/s390x/sigp.c                     |  1 -
>   target/s390x/tcg/cc_helper.c            |  1 -
>   target/s390x/tcg/crypto_helper.c        |  1 -
>   target/s390x/tcg/excp_helper.c          |  1 -
>   target/s390x/tcg/fpu_helper.c           |  1 -
>   target/s390x/tcg/int_helper.c           |  1 -
>   target/s390x/tcg/mem_helper.c           |  1 -
>   target/s390x/tcg/misc_helper.c          |  1 -
>   target/s390x/tcg/translate.c            |  1 -
>   target/s390x/tcg/vec_fpu_helper.c       |  1 -
>   target/s390x/tcg/vec_helper.c           |  1 -
>   target/sh4/cpu.c                        |  1 -
>   target/sh4/helper.c                     |  1 -
>   target/sh4/op_helper.c                  |  1 -
>   target/sh4/translate.c                  |  1 -
>   target/sparc/cpu.c                      |  1 -
>   target/sparc/fop_helper.c               |  1 -
>   target/sparc/helper.c                   |  1 -
>   target/sparc/ldst_helper.c              |  1 -
>   target/sparc/machine.c                  |  1 -
>   target/sparc/translate.c                |  1 -
>   target/sparc/win_helper.c               |  1 -
>   target/tricore/cpu.c                    |  1 -
>   target/tricore/op_helper.c              |  1 -
>   target/tricore/translate.c              |  1 -
>   target/xtensa/dbg_helper.c              |  1 -
>   target/xtensa/exc_helper.c              |  1 -
>   target/xtensa/fpu_helper.c              |  1 -
>   target/xtensa/mmu_helper.c              |  1 -
>   target/xtensa/op_helper.c               |  1 -
>   target/xtensa/translate.c               |  1 -
>   target/xtensa/win_helper.c              |  1 -
>   153 files changed, 175 deletions(-)
>   delete mode 100644 include/exec/exec-all.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a37cc73af7..9e677a26c52 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -493,7 +493,6 @@ M: Richard Henderson <richard.henderson@linaro.org>
>   R: Paolo Bonzini <pbonzini@redhat.com>
>   S: Maintained
>   F: include/exec/cpu*.h
> -F: include/exec/exec-all.h
>   F: include/exec/target_long.h
>   F: include/qemu/accel.h
>   F: include/system/accel-*.h
> diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
> index 244670dd24d..93388e7c34e 100644
> --- a/bsd-user/qemu.h
> +++ b/bsd-user/qemu.h
> @@ -23,7 +23,6 @@
>   #include "cpu.h"
>   #include "qemu/units.h"
>   #include "accel/tcg/cpu-ldst.h"
> -#include "exec/exec-all.h"
>   
>   #include "user/abitypes.h"
>   #include "user/cpu_loop.h"
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> deleted file mode 100644
> index 9ef7569a0b8..00000000000
> --- a/include/exec/exec-all.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/*
> - * internal execution defines for qemu
> - *
> - *  Copyright (c) 2003 Fabrice Bellard
> - *
> - * This library is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU Lesser General Public
> - * License as published by the Free Software Foundation; either
> - * version 2.1 of the License, or (at your option) any later version.
> - *
> - * This library is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * Lesser General Public License for more details.
> - *
> - * You should have received a copy of the GNU Lesser General Public
> - * License along with this library; if not, see <https://urldefense.proofpoint.com/v2/url?u=http-3A__www.gnu.org_licenses_&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=6TMJT5zrxee-SJABzNzFk9_DN2gyL-f9_rTfrp-rmtxiukqsFHeXs9RDSnAvUFFQ&s=cYte9ccJ0C-9Ymfthc9Rc2lOYJLLjDZX2zdrYNH_Yns&e= >.
> - */
> -
> -#ifndef EXEC_ALL_H
> -#define EXEC_ALL_H
> -
> -#endif
> diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
> index b4e4425acbb..15a1b1a4fa2 100644
> --- a/include/system/ram_addr.h
> +++ b/include/system/ram_addr.h
> @@ -24,7 +24,6 @@
>   #include "exec/cputlb.h"
>   #include "exec/ramlist.h"
>   #include "system/ramblock.h"
> -#include "exec/exec-all.h"
>   #include "system/memory.h"
>   #include "exec/target_page.h"
>   #include "qemu/rcu.h"
> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index 4aa253b5663..691b9a1775f 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -19,7 +19,6 @@
>   #define LINUX_USER_USER_INTERNALS_H
>   
>   #include "user/thunk.h"
> -#include "exec/exec-all.h"
>   #include "qemu/log.h"
>   
>   extern char *exec_path;
> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
> index 53e485d28ac..1bfdb0fb9bb 100644
> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -4,7 +4,6 @@
>   #include "cpu.h"
>   #include "tcg/tcg-op.h"
>   #include "tcg/tcg-op-gvec.h"
> -#include "exec/exec-all.h"
>   #include "exec/translator.h"
>   #include "exec/translation-block.h"
>   #include "exec/helper-gen.h"
> diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
> index 54d845379cd..6b3f19855f1 100644
> --- a/target/i386/tcg/helper-tcg.h
> +++ b/target/i386/tcg/helper-tcg.h
> @@ -20,7 +20,6 @@
>   #ifndef I386_HELPER_TCG_H
>   #define I386_HELPER_TCG_H
>   
> -#include "exec/exec-all.h"
>   #include "qemu/host-utils.h"
>   
>   /* Maximum instruction code size */
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index 601c3bc0ac6..bbd774dbc94 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -51,7 +51,6 @@
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
>   #include "system/address-spaces.h"
> -#include "exec/exec-all.h"
>   #include "gdbstub/enums.h"
>   #include "hw/boards.h"
>   #include "system/accel-ops.h"
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index b346af942a0..5b6d6f79751 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -22,7 +22,6 @@
>   #include "accel/tcg/cpu-ops.h"
>   #include "accel/tcg/iommu.h"
>   #include "accel/tcg/probe.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "system/memory.h"
>   #include "accel/tcg/cpu-ldst.h"
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 0408e2522a8..31c7f9927f2 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -21,7 +21,6 @@
>   
>   #include "trace.h"
>   #include "disas/disas.h"
> -#include "exec/exec-all.h"
>   #include "tcg/tcg.h"
>   #if defined(CONFIG_USER_ONLY)
>   #include "qemu.h"
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 697fdf18241..70feee8df99 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -21,7 +21,6 @@
>   #include "disas/disas.h"
>   #include "cpu.h"
>   #include "exec/vaddr.h"
> -#include "exec/exec-all.h"
>   #include "exec/tlb-flags.h"
>   #include "tcg/tcg.h"
>   #include "qemu/bitops.h"
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index fdb160bed0f..fa7645a56ea 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -36,7 +36,6 @@
>   #include "qemu/help_option.h"
>   #include "qemu/module.h"
>   #include "qemu/plugin.h"
> -#include "exec/exec-all.h"
>   #include "user/guest-base.h"
>   #include "user/page-protection.h"
>   #include "tcg/startup.h"
> diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> index a79e398c132..9cc6083feee 100644
> --- a/hw/ppc/spapr_nested.c
> +++ b/hw/ppc/spapr_nested.c
> @@ -1,6 +1,5 @@
>   #include "qemu/osdep.h"
>   #include "qemu/cutils.h"
> -#include "exec/exec-all.h"
>   #include "exec/cputlb.h"
>   #include "exec/target_long.h"
>   #include "helper_regs.h"
> diff --git a/hw/riscv/riscv-iommu-sys.c b/hw/riscv/riscv-iommu-sys.c
> index 65b24fb07de..bbe839ed241 100644
> --- a/hw/riscv/riscv-iommu-sys.c
> +++ b/hw/riscv/riscv-iommu-sys.c
> @@ -26,7 +26,6 @@
>   #include "qemu/host-utils.h"
>   #include "qemu/module.h"
>   #include "qom/object.h"
> -#include "exec/exec-all.h"
>   #include "trace.h"
>   
>   #include "riscv-iommu.h"
> diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
> index 41306fb6008..300eabc595d 100644
> --- a/hw/sh4/sh7750.c
> +++ b/hw/sh4/sh7750.c
> @@ -36,7 +36,6 @@
>   #include "sh7750_regnames.h"
>   #include "hw/sh4/sh_intc.h"
>   #include "hw/timer/tmu012.h"
> -#include "exec/exec-all.h"
>   #include "exec/cputlb.h"
>   #include "trace.h"
>   
> diff --git a/linux-user/main.c b/linux-user/main.c
> index e2ec5970bed..4af7f49f383 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -40,7 +40,6 @@
>   #include "qemu/plugin.h"
>   #include "user/guest-base.h"
>   #include "user/page-protection.h"
> -#include "exec/exec-all.h"
>   #include "exec/gdbstub.h"
>   #include "gdbstub/user.h"
>   #include "tcg/startup.h"
> diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
> index ebbb300f86a..4554844e15b 100644
> --- a/semihosting/uaccess.c
> +++ b/semihosting/uaccess.c
> @@ -10,7 +10,6 @@
>   #include "qemu/osdep.h"
>   #include "accel/tcg/cpu-mmu-index.h"
>   #include "accel/tcg/probe.h"
> -#include "exec/exec-all.h"
>   #include "exec/target_page.h"
>   #include "exec/tlb-flags.h"
>   #include "semihosting/uaccess.h"
> diff --git a/system/physmem.c b/system/physmem.c
> index f1ec0902c78..3f4fd69d9a5 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -32,7 +32,6 @@
>   #include "accel/tcg/iommu.h"
>   #endif /* CONFIG_TCG */
>   
> -#include "exec/exec-all.h"
>   #include "exec/cputlb.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index 35fb145d27f..cb3f382dc64 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -23,7 +23,6 @@
>   #include "qapi/error.h"
>   #include "qemu/qemu-print.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "exec/target_page.h"
>   #include "fpu/softfloat.h"
> diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
> index 6aefb9b851a..30f3c7fd185 100644
> --- a/target/alpha/fpu_helper.c
> +++ b/target/alpha/fpu_helper.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "fpu/softfloat.h"
>   
> diff --git a/target/alpha/int_helper.c b/target/alpha/int_helper.c
> index 5672696f6f1..6bfe63500e0 100644
> --- a/target/alpha/int_helper.c
> +++ b/target/alpha/int_helper.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "qemu/host-utils.h"
>   
> diff --git a/target/alpha/mem_helper.c b/target/alpha/mem_helper.c
> index a4d5adb40c6..2113fe33ae2 100644
> --- a/target/alpha/mem_helper.c
> +++ b/target/alpha/mem_helper.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   
>   static void do_unaligned_access(CPUAlphaState *env, vaddr addr, uintptr_t retaddr)
> diff --git a/target/alpha/translate.c b/target/alpha/translate.c
> index 7f3195a5dcc..cebab0318cf 100644
> --- a/target/alpha/translate.c
> +++ b/target/alpha/translate.c
> @@ -21,7 +21,6 @@
>   #include "cpu.h"
>   #include "system/cpus.h"
>   #include "qemu/host-utils.h"
> -#include "exec/exec-all.h"
>   #include "tcg/tcg-op.h"
>   #include "exec/helper-proto.h"
>   #include "exec/helper-gen.h"
> diff --git a/target/alpha/vax_helper.c b/target/alpha/vax_helper.c
> index f94fb519dbd..c1d201e7b4d 100644
> --- a/target/alpha/vax_helper.c
> +++ b/target/alpha/vax_helper.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "fpu/softfloat.h"
>   
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 377791c84dd..e149a462505 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -33,7 +33,6 @@
>   #endif /* CONFIG_TCG */
>   #include "internals.h"
>   #include "cpu-features.h"
> -#include "exec/exec-all.h"
>   #include "exec/target_page.h"
>   #include "hw/qdev-properties.h"
>   #if !defined(CONFIG_USER_ONLY)
> diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
> index 473ee2af38e..de7999f6a94 100644
> --- a/target/arm/debug_helper.c
> +++ b/target/arm/debug_helper.c
> @@ -11,7 +11,6 @@
>   #include "internals.h"
>   #include "cpu-features.h"
>   #include "cpregs.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "exec/watchpoint.h"
>   #include "system/tcg.h"
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2f039b2db33..8de4eb2c1fa 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -20,7 +20,6 @@
>   #include "qemu/bitops.h"
>   #include "qemu/qemu-print.h"
>   #include "exec/cputlb.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "hw/irq.h"
>   #include "system/cpu-timers.h"
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 58f1cd0b34c..894120c9aea 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -10,7 +10,6 @@
>   #include "qemu/log.h"
>   #include "qemu/range.h"
>   #include "qemu/main-loop.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
>   #include "exec/tlb-flags.h"
> diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
> index ac86629432a..590717ecd8c 100644
> --- a/target/arm/tcg/helper-a64.c
> +++ b/target/arm/tcg/helper-a64.c
> @@ -29,7 +29,6 @@
>   #include "internals.h"
>   #include "qemu/crc32c.h"
>   #include "exec/cpu-common.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "accel/tcg/probe.h"
>   #include "exec/target_page.h"
> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
> index 37dc98dc35c..6614719832e 100644
> --- a/target/arm/tcg/m_helper.c
> +++ b/target/arm/tcg/m_helper.c
> @@ -15,7 +15,6 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/bitops.h"
>   #include "qemu/log.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #ifdef CONFIG_TCG
>   #include "accel/tcg/cpu-ldst.h"
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index 8fbdcc8fb95..13d7ac00972 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -21,7 +21,6 @@
>   #include "qemu/log.h"
>   #include "cpu.h"
>   #include "internals.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #ifdef CONFIG_USER_ONLY
>   #include "user/cpu_loop.h"
> diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
> index f9f67d1f88e..506d1c34757 100644
> --- a/target/arm/tcg/mve_helper.c
> +++ b/target/arm/tcg/mve_helper.c
> @@ -23,7 +23,6 @@
>   #include "vec_internal.h"
>   #include "exec/helper-proto.h"
>   #include "accel/tcg/cpu-ldst.h"
> -#include "exec/exec-all.h"
>   #include "tcg/tcg.h"
>   #include "fpu/softfloat.h"
>   #include "crypto/clmul.h"
> diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
> index d50b8720ad6..dc3f83c37dc 100644
> --- a/target/arm/tcg/op_helper.c
> +++ b/target/arm/tcg/op_helper.c
> @@ -23,7 +23,6 @@
>   #include "exec/target_page.h"
>   #include "internals.h"
>   #include "cpu-features.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "accel/tcg/probe.h"
>   #include "cpregs.h"
> diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
> index 59bf27541dc..c591c3052c3 100644
> --- a/target/arm/tcg/pauth_helper.c
> +++ b/target/arm/tcg/pauth_helper.c
> @@ -21,7 +21,6 @@
>   #include "cpu.h"
>   #include "internals.h"
>   #include "cpu-features.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "exec/helper-proto.h"
>   #include "tcg/tcg-gvec-desc.h"
> diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
> index 96b84c37a2d..3226895cae3 100644
> --- a/target/arm/tcg/sme_helper.c
> +++ b/target/arm/tcg/sme_helper.c
> @@ -23,7 +23,6 @@
>   #include "tcg/tcg-gvec-desc.h"
>   #include "exec/helper-proto.h"
>   #include "accel/tcg/cpu-ldst.h"
> -#include "exec/exec-all.h"
>   #include "qemu/int128.h"
>   #include "fpu/softfloat.h"
>   #include "vec_internal.h"
> diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
> index 50aca54eaa3..9f20ecb51d3 100644
> --- a/target/arm/tcg/sve_helper.c
> +++ b/target/arm/tcg/sve_helper.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "internals.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "exec/helper-proto.h"
>   #include "exec/target_page.h"
> diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
> index 8841f039bc6..5ea4d6590f2 100644
> --- a/target/arm/tcg/tlb_helper.c
> +++ b/target/arm/tcg/tlb_helper.c
> @@ -9,7 +9,6 @@
>   #include "cpu.h"
>   #include "internals.h"
>   #include "cpu-features.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   
>   
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 43408c71bbd..11053f083a0 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -17,7 +17,6 @@
>    * License along with this library; if not, see <https://urldefense.proofpoint.com/v2/url?u=http-3A__www.gnu.org_licenses_&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=6TMJT5zrxee-SJABzNzFk9_DN2gyL-f9_rTfrp-rmtxiukqsFHeXs9RDSnAvUFFQ&s=cYte9ccJ0C-9Ymfthc9Rc2lOYJLLjDZX2zdrYNH_Yns&e= >.
>    */
>   #include "qemu/osdep.h"
> -#include "exec/exec-all.h"
>   #include "exec/target_page.h"
>   #include "translate.h"
>   #include "translate-a64.h"
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index 84f3b839c9b..86e53ef9f65 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -21,7 +21,6 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "qemu/qemu-print.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "system/address-spaces.h"
>   #include "cpu.h"
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> index b9c592c899a..804b0b21dbd 100644
> --- a/target/avr/translate.c
> +++ b/target/avr/translate.c
> @@ -22,7 +22,6 @@
>   #include "qemu/qemu-print.h"
>   #include "tcg/tcg.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "tcg/tcg-op.h"
>   #include "exec/helper-proto.h"
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 3c5191282ea..9f93c170092 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -19,7 +19,6 @@
>   #include "qemu/qemu-print.h"
>   #include "cpu.h"
>   #include "internal.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "qapi/error.h"
>   #include "hw/qdev-properties.h"
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index dd726b43187..444799d3ade 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -17,7 +17,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "accel/tcg/probe.h"
>   #include "exec/helper-proto.h"
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 10e18c945ef..6acbf3de27a 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -24,7 +24,6 @@
>   #include "qemu/timer.h"
>   #include "cpu.h"
>   #include "qemu/module.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "exec/target_page.h"
>   #include "fpu/softfloat.h"
> diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
> index a62d9d30831..ddd0a343d63 100644
> --- a/target/hppa/fpu_helper.c
> +++ b/target/hppa/fpu_helper.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "fpu/softfloat.h"
>   
> diff --git a/target/hppa/helper.c b/target/hppa/helper.c
> index ac7f58f0afe..d7f8495d982 100644
> --- a/target/hppa/helper.c
> +++ b/target/hppa/helper.c
> @@ -21,7 +21,6 @@
>   #include "qemu/log.h"
>   #include "cpu.h"
>   #include "fpu/softfloat.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "qemu/qemu-print.h"
>   #include "hw/hppa/hppa_hardware.h"
> diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
> index a5f73aedf82..9bdd0a6f23d 100644
> --- a/target/hppa/mem_helper.c
> +++ b/target/hppa/mem_helper.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/cputlb.h"
>   #include "accel/tcg/cpu-mmu-index.h"
>   #include "accel/tcg/probe.h"
> diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
> index 32207c1a4c8..0458378abb2 100644
> --- a/target/hppa/op_helper.c
> +++ b/target/hppa/op_helper.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "accel/tcg/probe.h"
> diff --git a/target/hppa/sys_helper.c b/target/hppa/sys_helper.c
> index 052a6a88a27..6e65fadcc7b 100644
> --- a/target/hppa/sys_helper.c
> +++ b/target/hppa/sys_helper.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "qemu/timer.h"
>   #include "system/runstate.h"
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 14f38333222..156c3dedd18 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "qemu/host-utils.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "tcg/tcg-op.h"
>   #include "tcg/tcg-op-gvec.h"
> diff --git a/target/i386/tcg/access.c b/target/i386/tcg/access.c
> index ee5b4514597..97e3f0e7568 100644
> --- a/target/i386/tcg/access.c
> +++ b/target/i386/tcg/access.c
> @@ -5,7 +5,6 @@
>   #include "cpu.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "accel/tcg/probe.h"
> -#include "exec/exec-all.h"
>   #include "exec/target_page.h"
>   #include "access.h"
>   
> diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
> index de71e68f986..6fb8036d988 100644
> --- a/target/i386/tcg/excp_helper.c
> +++ b/target/i386/tcg/excp_helper.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "qemu/log.h"
>   #include "system/runstate.h"
>   #include "exec/helper-proto.h"
> diff --git a/target/i386/tcg/int_helper.c b/target/i386/tcg/int_helper.c
> index 1a02e9d8434..46741d9f68a 100644
> --- a/target/i386/tcg/int_helper.c
> +++ b/target/i386/tcg/int_helper.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "qemu/host-utils.h"
>   #include "exec/helper-proto.h"
>   #include "qapi/error.h"
> diff --git a/target/i386/tcg/mem_helper.c b/target/i386/tcg/mem_helper.c
> index 84a08152171..9e7c2d80293 100644
> --- a/target/i386/tcg/mem_helper.c
> +++ b/target/i386/tcg/mem_helper.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "qemu/int128.h"
>   #include "qemu/atomic128.h"
> diff --git a/target/i386/tcg/mpx_helper.c b/target/i386/tcg/mpx_helper.c
> index a0f816dfae0..fa8abcc4820 100644
> --- a/target/i386/tcg/mpx_helper.c
> +++ b/target/i386/tcg/mpx_helper.c
> @@ -21,7 +21,6 @@
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
>   #include "accel/tcg/cpu-ldst.h"
> -#include "exec/exec-all.h"
>   #include "exec/target_page.h"
>   #include "helper-tcg.h"
>   
> diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
> index e45d71fa1ad..0ca081b286d 100644
> --- a/target/i386/tcg/seg_helper.c
> +++ b/target/i386/tcg/seg_helper.c
> @@ -22,7 +22,6 @@
>   #include "cpu.h"
>   #include "qemu/log.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "accel/tcg/probe.h"
>   #include "exec/log.h"
> diff --git a/target/i386/tcg/system/bpt_helper.c b/target/i386/tcg/system/bpt_helper.c
> index 08ccd3f5e69..aebb5caac37 100644
> --- a/target/i386/tcg/system/bpt_helper.c
> +++ b/target/i386/tcg/system/bpt_helper.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "exec/watchpoint.h"
>   #include "tcg/helper-tcg.h"
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 1dcc35f5dfa..6eaa0457314 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -21,7 +21,6 @@
>   #include "qemu/host-utils.h"
>   #include "cpu.h"
>   #include "accel/tcg/cpu-mmu-index.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "tcg/tcg-op.h"
>   #include "tcg/tcg-op-gvec.h"
> diff --git a/target/i386/tcg/user/excp_helper.c b/target/i386/tcg/user/excp_helper.c
> index b3bdb7831a7..98fab4cbc3f 100644
> --- a/target/i386/tcg/user/excp_helper.c
> +++ b/target/i386/tcg/user/excp_helper.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "tcg/helper-tcg.h"
>   
>   void x86_cpu_record_sigsegv(CPUState *cs, vaddr addr,
> diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
> index 5692dd51953..263f59937fe 100644
> --- a/target/i386/tcg/user/seg_helper.c
> +++ b/target/i386/tcg/user/seg_helper.c
> @@ -21,7 +21,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "tcg/helper-tcg.h"
>   #include "tcg/seg_helper.h"
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index fe9462b3b7e..b6f89f0f392 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -15,7 +15,6 @@
>   #include "system/kvm.h"
>   #include "kvm/kvm_loongarch.h"
>   #include "hw/qdev-properties.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "cpu.h"
>   #include "internals.h"
> diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
> index fc3fd0561e3..fc9c64c20a8 100644
> --- a/target/loongarch/tcg/fpu_helper.c
> +++ b/target/loongarch/tcg/fpu_helper.c
> @@ -8,7 +8,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "fpu/softfloat.h"
>   #include "internals.h"
> diff --git a/target/loongarch/tcg/iocsr_helper.c b/target/loongarch/tcg/iocsr_helper.c
> index e62170de3ce..c155f48564d 100644
> --- a/target/loongarch/tcg/iocsr_helper.c
> +++ b/target/loongarch/tcg/iocsr_helper.c
> @@ -9,7 +9,6 @@
>   #include "cpu.h"
>   #include "qemu/host-utils.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   
>   #define GET_MEMTXATTRS(cas) \
> diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
> index 94e3b28016a..16ac0d43bc9 100644
> --- a/target/loongarch/tcg/op_helper.c
> +++ b/target/loongarch/tcg/op_helper.c
> @@ -10,7 +10,6 @@
>   #include "cpu.h"
>   #include "qemu/host-utils.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "internals.h"
>   #include "qemu/crc32c.h"
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 9a76a2a205f..1d5ba567b97 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -13,7 +13,6 @@
>   #include "internals.h"
>   #include "exec/helper-proto.h"
>   #include "exec/cputlb.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
>   #include "accel/tcg/cpu-ldst.h"
> diff --git a/target/loongarch/tcg/vec_helper.c b/target/loongarch/tcg/vec_helper.c
> index 3faf52cbc46..a270998e638 100644
> --- a/target/loongarch/tcg/vec_helper.c
> +++ b/target/loongarch/tcg/vec_helper.c
> @@ -7,7 +7,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "fpu/softfloat.h"
>   #include "internals.h"
> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
> index ac4a0d85be5..56012863c85 100644
> --- a/target/m68k/fpu_helper.c
> +++ b/target/m68k/fpu_helper.c
> @@ -21,7 +21,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "softfloat.h"
>   
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index f73e0def234..5479acc5b99 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -21,7 +21,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "exec/cputlb.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
>   #include "exec/gdbstub.h"
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index 242aecccbbc..f29ae12af84 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -20,7 +20,6 @@
>   #include "qemu/log.h"
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "semihosting/semihost.h"
>   
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index b1266a7875b..97afceb1297 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -20,7 +20,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "exec/target_page.h"
>   #include "tcg/tcg-op.h"
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index edfb05758b3..658d3cb3d7b 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -27,7 +27,6 @@
>   #include "cpu.h"
>   #include "qemu/module.h"
>   #include "hw/qdev-properties.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "exec/gdbstub.h"
>   #include "exec/translation-block.h"
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index 4624ce5b672..9e838dfa153 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -23,7 +23,6 @@
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
>   #include "qemu/host-utils.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "fpu/softfloat.h"
>   
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 7dcad6cf0d7..ad4a85407d0 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -20,7 +20,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "tcg/tcg-op.h"
>   #include "exec/helper-proto.h"
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 473cecdebca..26f4f038cde 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -29,7 +29,6 @@
>   #include "qemu/module.h"
>   #include "system/kvm.h"
>   #include "system/qtest.h"
> -#include "exec/exec-all.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-clock.h"
>   #include "fpu_helper.h"
> diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
> index 505781d84c1..b8e1a5ac98e 100644
> --- a/target/mips/system/physaddr.c
> +++ b/target/mips/system/physaddr.c
> @@ -18,7 +18,6 @@
>    */
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "../internal.h"
>   
> diff --git a/target/mips/tcg/exception.c b/target/mips/tcg/exception.c
> index 1a8902ea1bc..d32bcebf469 100644
> --- a/target/mips/tcg/exception.c
> +++ b/target/mips/tcg/exception.c
> @@ -23,7 +23,6 @@
>   #include "cpu.h"
>   #include "internal.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   
>   target_ulong exception_resume_pc(CPUMIPSState *env)
> diff --git a/target/mips/tcg/fpu_helper.c b/target/mips/tcg/fpu_helper.c
> index 45d593de489..36af9808025 100644
> --- a/target/mips/tcg/fpu_helper.c
> +++ b/target/mips/tcg/fpu_helper.c
> @@ -24,7 +24,6 @@
>   #include "cpu.h"
>   #include "internal.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "fpu/softfloat.h"
>   #include "fpu_helper.h"
>   
> diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
> index 2fb879fcbcc..10319bf03a6 100644
> --- a/target/mips/tcg/ldst_helper.c
> +++ b/target/mips/tcg/ldst_helper.c
> @@ -23,7 +23,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "exec/memop.h"
>   #include "internal.h"
> diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
> index 4d9a4468e53..fe4cd1c7b5f 100644
> --- a/target/mips/tcg/msa_helper.c
> +++ b/target/mips/tcg/msa_helper.c
> @@ -21,7 +21,6 @@
>   #include "cpu.h"
>   #include "internal.h"
>   #include "tcg/tcg.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "accel/tcg/probe.h"
>   #include "exec/helper-proto.h"
> diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
> index 65403f1a87b..b906d10204b 100644
> --- a/target/mips/tcg/op_helper.c
> +++ b/target/mips/tcg/op_helper.c
> @@ -22,7 +22,6 @@
>   #include "cpu.h"
>   #include "internal.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "exec/memop.h"
>   #include "fpu_helper.h"
>   
> diff --git a/target/mips/tcg/system/special_helper.c b/target/mips/tcg/system/special_helper.c
> index 3ce3ae1e124..b54cbe88a38 100644
> --- a/target/mips/tcg/system/special_helper.c
> +++ b/target/mips/tcg/system/special_helper.c
> @@ -22,7 +22,6 @@
>   #include "qemu/log.h"
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "internal.h"
>   
> diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
> index e477ef812ae..eccaf3624cb 100644
> --- a/target/mips/tcg/system/tlb_helper.c
> +++ b/target/mips/tcg/system/tlb_helper.c
> @@ -22,7 +22,6 @@
>   #include "cpu.h"
>   #include "internal.h"
>   #include "exec/cputlb.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
>   #include "accel/tcg/cpu-ldst.h"
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index 6601e0c0666..d3c366dd86a 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -21,7 +21,6 @@
>   #include "qapi/error.h"
>   #include "qemu/qemu-print.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "fpu/softfloat-helpers.h"
>   #include "tcg/tcg.h"
> diff --git a/target/openrisc/exception.c b/target/openrisc/exception.c
> index 8699c3dcea4..e213be36b6b 100644
> --- a/target/openrisc/exception.c
> +++ b/target/openrisc/exception.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exception.h"
>   
>   G_NORETURN void raise_exception(OpenRISCCPU *cpu, uint32_t excp)
> diff --git a/target/openrisc/exception_helper.c b/target/openrisc/exception_helper.c
> index 1f5be4bed90..c2c9d136528 100644
> --- a/target/openrisc/exception_helper.c
> +++ b/target/openrisc/exception_helper.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "exception.h"
>   
> diff --git a/target/openrisc/fpu_helper.c b/target/openrisc/fpu_helper.c
> index 8b81d2f62f7..dba997255c6 100644
> --- a/target/openrisc/fpu_helper.c
> +++ b/target/openrisc/fpu_helper.c
> @@ -20,7 +20,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "fpu/softfloat.h"
>   
> diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
> index b3b5b405779..486823094c8 100644
> --- a/target/openrisc/interrupt.c
> +++ b/target/openrisc/interrupt.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "gdbstub/helpers.h"
>   #include "qemu/host-utils.h"
>   #ifndef CONFIG_USER_ONLY
> diff --git a/target/openrisc/interrupt_helper.c b/target/openrisc/interrupt_helper.c
> index ab4ea88b692..1553ebc71b0 100644
> --- a/target/openrisc/interrupt_helper.c
> +++ b/target/openrisc/interrupt_helper.c
> @@ -20,7 +20,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   
>   void HELPER(rfe)(CPUOpenRISCState *env)
> diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> index 92badf017f7..951f8e247a7 100644
> --- a/target/openrisc/sys_helper.c
> +++ b/target/openrisc/sys_helper.c
> @@ -20,7 +20,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/cputlb.h"
>   #include "exec/target_page.h"
>   #include "exec/helper-proto.h"
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index d4ce60188bd..3b6843768b0 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -21,7 +21,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "accel/tcg/cpu-mmu-index.h"
> -#include "exec/exec-all.h"
>   #include "tcg/tcg-op.h"
>   #include "qemu/log.h"
>   #include "qemu/bitops.h"
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index da8b525a41b..1efdc4066eb 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -24,7 +24,6 @@
>   #include "system/system.h"
>   #include "system/runstate.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "internal.h"
>   #include "helper_regs.h"
>   #include "hw/ppc/ppc.h"
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index d93cfed17b4..07b782f971b 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -19,7 +19,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "internal.h"
>   #include "fpu/softfloat.h"
>   
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 98df5b4a3a2..d72e5ecb94b 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -1,6 +1,5 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "system/kvm.h"
>   #include "system/tcg.h"
>   #include "helper_regs.h"
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 50f05a915ed..aa1af44d22a 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/target_page.h"
>   #include "qemu/host-utils.h"
>   #include "exec/helper-proto.h"
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index 46ae454afd3..e7d94625185 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/log.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/cputlb.h"
>   #include "exec/helper-proto.h"
>   #include "qemu/error-report.h"
> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
> index 5bd3efe70e8..8b980a5aa90 100644
> --- a/target/ppc/mmu-hash32.c
> +++ b/target/ppc/mmu-hash32.c
> @@ -20,7 +20,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
>   #include "system/kvm.h"
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 3ba4810497e..dd337558aa6 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/units.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "qemu/error-report.h"
>   #include "qemu/qemu-print.h"
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 4ab5f3bb920..33ac3412901 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "qemu/error-report.h"
>   #include "system/kvm.h"
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 394a0c9bb60..52d48615ac2 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -24,7 +24,6 @@
>   #include "kvm_ppc.h"
>   #include "mmu-hash64.h"
>   #include "mmu-hash32.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
>   #include "exec/log.h"
> diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
> index 2138666122b..ac607054027 100644
> --- a/target/ppc/mmu_helper.c
> +++ b/target/ppc/mmu_helper.c
> @@ -25,7 +25,6 @@
>   #include "mmu-hash64.h"
>   #include "mmu-hash32.h"
>   #include "exec/cputlb.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
>   #include "exec/log.h"
> diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
> index db9ee8e96b0..2a7a5b493af 100644
> --- a/target/ppc/power8-pmu.c
> +++ b/target/ppc/power8-pmu.c
> @@ -13,7 +13,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "helper_regs.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "qemu/error-report.h"
>   #include "qemu/timer.h"
> diff --git a/target/ppc/tcg-excp_helper.c b/target/ppc/tcg-excp_helper.c
> index 2b15e5f2f07..f835be51563 100644
> --- a/target/ppc/tcg-excp_helper.c
> +++ b/target/ppc/tcg-excp_helper.c
> @@ -21,7 +21,6 @@
>   #include "qemu/log.h"
>   #include "target/ppc/cpu.h"
>   #include "accel/tcg/cpu-ldst.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "system/runstate.h"
>   
> diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
> index 73120323b4e..7209b418fb6 100644
> --- a/target/ppc/timebase_helper.c
> +++ b/target/ppc/timebase_helper.c
> @@ -20,7 +20,6 @@
>   #include "cpu.h"
>   #include "hw/ppc/ppc.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "qemu/log.h"
>   #include "qemu/main-loop.h"
>   
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 399107d319a..f2cd3308f80 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -21,7 +21,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "internal.h"
> -#include "exec/exec-all.h"
>   #include "exec/target_page.h"
>   #include "tcg/tcg-op.h"
>   #include "tcg/tcg-op-gvec.h"
> diff --git a/target/ppc/user_only_helper.c b/target/ppc/user_only_helper.c
> index a4d07a0d0dd..ae210eb8474 100644
> --- a/target/ppc/user_only_helper.c
> +++ b/target/ppc/user_only_helper.c
> @@ -20,7 +20,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "internal.h"
>   
>   void ppc_cpu_record_sigsegv(CPUState *cs, vaddr address,
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2b830b33178..1b2a42141f0 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -24,7 +24,6 @@
>   #include "cpu.h"
>   #include "cpu_vendorid.h"
>   #include "internals.h"
> -#include "exec/exec-all.h"
>   #include "qapi/error.h"
>   #include "qapi/visitor.h"
>   #include "qemu/error-report.h"
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 619c76cc001..f2e90a9889f 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -24,7 +24,6 @@
>   #include "internals.h"
>   #include "pmu.h"
>   #include "exec/cputlb.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
>   #include "system/memory.h"
> diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
> index bb084e00efe..a0fb54bc50c 100644
> --- a/target/riscv/crypto_helper.c
> +++ b/target/riscv/crypto_helper.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "crypto/aes.h"
>   #include "crypto/aes-round.h"
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 13086438552..a32e1455c91 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -24,7 +24,6 @@
>   #include "tcg/tcg-cpu.h"
>   #include "pmu.h"
>   #include "time_helper.h"
> -#include "exec/exec-all.h"
>   #include "exec/cputlb.h"
>   #include "exec/tb-flush.h"
>   #include "exec/icount.h"
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 7fc9e121e11..94f06b25737 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -28,7 +28,6 @@
>   #include "qapi/error.h"
>   #include "cpu.h"
>   #include "trace.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "exec/watchpoint.h"
>   #include "system/cpu-timers.h"
> diff --git a/target/riscv/fpu_helper.c b/target/riscv/fpu_helper.c
> index 91b1a56d10a..706bdfa61d5 100644
> --- a/target/riscv/fpu_helper.c
> +++ b/target/riscv/fpu_helper.c
> @@ -19,7 +19,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "qemu/host-utils.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "fpu/softfloat.h"
>   #include "internals.h"
> diff --git a/target/riscv/m128_helper.c b/target/riscv/m128_helper.c
> index ec14aaa901a..7d9b83b1b2c 100644
> --- a/target/riscv/m128_helper.c
> +++ b/target/riscv/m128_helper.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   
>   target_ulong HELPER(divu_i128)(CPURISCVState *env,
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index abb1d284dce..05316f2088c 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -21,7 +21,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "internals.h"
> -#include "exec/exec-all.h"
>   #include "exec/cputlb.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "accel/tcg/probe.h"
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 426145c3b9f..916fd6fb43a 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -18,7 +18,6 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "tcg-cpu.h"
>   #include "cpu.h"
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index cef61b5b290..85128f997b7 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -20,7 +20,6 @@
>   #include "qemu/log.h"
>   #include "cpu.h"
>   #include "tcg/tcg-op.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "exec/helper-gen.h"
>   #include "exec/target_page.h"
> diff --git a/target/riscv/vcrypto_helper.c b/target/riscv/vcrypto_helper.c
> index 1526de96f53..9a0d9b4f536 100644
> --- a/target/riscv/vcrypto_helper.c
> +++ b/target/riscv/vcrypto_helper.c
> @@ -26,7 +26,6 @@
>   #include "crypto/aes-round.h"
>   #include "crypto/sm4.h"
>   #include "exec/memop.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "internals.h"
>   #include "vector_internals.h"
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 5ccb294e319..8eea3e6df03 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -21,7 +21,6 @@
>   #include "qemu/bitops.h"
>   #include "cpu.h"
>   #include "exec/memop.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "accel/tcg/probe.h"
>   #include "exec/page-protection.h"
> diff --git a/target/riscv/zce_helper.c b/target/riscv/zce_helper.c
> index 50d65f386c7..55221f5f375 100644
> --- a/target/riscv/zce_helper.c
> +++ b/target/riscv/zce_helper.c
> @@ -18,7 +18,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "accel/tcg/cpu-ldst.h"
>   
> diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
> index a2f1f3824d9..2b190a4b2cf 100644
> --- a/target/rx/op_helper.c
> +++ b/target/rx/op_helper.c
> @@ -19,7 +19,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/bitops.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "fpu/softfloat.h"
> diff --git a/target/rx/translate.c b/target/rx/translate.c
> index bbda703be86..19a9584a829 100644
> --- a/target/rx/translate.c
> +++ b/target/rx/translate.c
> @@ -20,7 +20,6 @@
>   #include "qemu/bswap.h"
>   #include "qemu/qemu-print.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "tcg/tcg-op.h"
>   #include "exec/helper-proto.h"
>   #include "exec/helper-gen.h"
> diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
> index 4ae6e2ddeaa..1dca835c5d8 100644
> --- a/target/s390x/interrupt.c
> +++ b/target/s390x/interrupt.c
> @@ -11,7 +11,6 @@
>   #include "cpu.h"
>   #include "kvm/kvm_s390x.h"
>   #include "s390x-internal.h"
> -#include "exec/exec-all.h"
>   #include "system/kvm.h"
>   #include "system/tcg.h"
>   #include "hw/s390x/ioinst.h"
> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
> index 0e133cb9a53..00946e9c0fe 100644
> --- a/target/s390x/mmu_helper.c
> +++ b/target/s390x/mmu_helper.c
> @@ -23,7 +23,6 @@
>   #include "kvm/kvm_s390x.h"
>   #include "system/kvm.h"
>   #include "system/tcg.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
>   #include "hw/hw.h"
> diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
> index a3347f12362..5e95c4978f9 100644
> --- a/target/s390x/sigp.c
> +++ b/target/s390x/sigp.c
> @@ -16,7 +16,6 @@
>   #include "system/runstate.h"
>   #include "system/address-spaces.h"
>   #include "exec/cputlb.h"
> -#include "exec/exec-all.h"
>   #include "system/tcg.h"
>   #include "trace.h"
>   #include "qapi/qapi-types-machine.h"
> diff --git a/target/s390x/tcg/cc_helper.c b/target/s390x/tcg/cc_helper.c
> index b36f8cdc8b9..6595ac763c3 100644
> --- a/target/s390x/tcg/cc_helper.c
> +++ b/target/s390x/tcg/cc_helper.c
> @@ -22,7 +22,6 @@
>   #include "cpu.h"
>   #include "s390x-internal.h"
>   #include "tcg_s390x.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "qemu/host-utils.h"
>   
> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
> index 642c1b18c4c..4447bb66eee 100644
> --- a/target/s390x/tcg/crypto_helper.c
> +++ b/target/s390x/tcg/crypto_helper.c
> @@ -17,7 +17,6 @@
>   #include "s390x-internal.h"
>   #include "tcg_s390x.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   
>   static uint64_t R(uint64_t x, int c)
> diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
> index 6cd813e1abf..e4c75d0ce01 100644
> --- a/target/s390x/tcg/excp_helper.c
> +++ b/target/s390x/tcg/excp_helper.c
> @@ -23,7 +23,6 @@
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
>   #include "exec/cputlb.h"
> -#include "exec/exec-all.h"
>   #include "exec/target_page.h"
>   #include "exec/watchpoint.h"
>   #include "s390x-internal.h"
> diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
> index 5041c139627..1ba43715ac1 100644
> --- a/target/s390x/tcg/fpu_helper.c
> +++ b/target/s390x/tcg/fpu_helper.c
> @@ -22,7 +22,6 @@
>   #include "cpu.h"
>   #include "s390x-internal.h"
>   #include "tcg_s390x.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "fpu/softfloat.h"
>   
> diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
> index 253c0364157..fbda396f5b4 100644
> --- a/target/s390x/tcg/int_helper.c
> +++ b/target/s390x/tcg/int_helper.c
> @@ -22,7 +22,6 @@
>   #include "cpu.h"
>   #include "s390x-internal.h"
>   #include "tcg_s390x.h"
> -#include "exec/exec-all.h"
>   #include "qemu/host-utils.h"
>   #include "exec/helper-proto.h"
>   #include "accel/tcg/cpu-ldst.h"
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
> index 9e77cde81bd..857005b1202 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -25,7 +25,6 @@
>   #include "tcg_s390x.h"
>   #include "exec/helper-proto.h"
>   #include "exec/cpu-common.h"
> -#include "exec/exec-all.h"
>   #include "exec/cputlb.h"
>   #include "exec/page-protection.h"
>   #include "accel/tcg/cpu-ldst.h"
> diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
> index d5088493ead..f7101be5745 100644
> --- a/target/s390x/tcg/misc_helper.c
> +++ b/target/s390x/tcg/misc_helper.c
> @@ -26,7 +26,6 @@
>   #include "qemu/host-utils.h"
>   #include "exec/helper-proto.h"
>   #include "qemu/timer.h"
> -#include "exec/exec-all.h"
>   #include "exec/cputlb.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "exec/target_page.h"
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 00073c5560e..4fdb79f1747 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -31,7 +31,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "s390x-internal.h"
> -#include "exec/exec-all.h"
>   #include "tcg/tcg-op.h"
>   #include "tcg/tcg-op-gvec.h"
>   #include "qemu/log.h"
> diff --git a/target/s390x/tcg/vec_fpu_helper.c b/target/s390x/tcg/vec_fpu_helper.c
> index 1bbaa82fe8a..744f800fb6c 100644
> --- a/target/s390x/tcg/vec_fpu_helper.c
> +++ b/target/s390x/tcg/vec_fpu_helper.c
> @@ -15,7 +15,6 @@
>   #include "vec.h"
>   #include "tcg_s390x.h"
>   #include "tcg/tcg-gvec-desc.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "fpu/softfloat.h"
>   
> diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/vec_helper.c
> index 781ccc565bd..46ec4a947dd 100644
> --- a/target/s390x/tcg/vec_helper.c
> +++ b/target/s390x/tcg/vec_helper.c
> @@ -17,7 +17,6 @@
>   #include "tcg/tcg-gvec-desc.h"
>   #include "exec/helper-proto.h"
>   #include "accel/tcg/cpu-ldst.h"
> -#include "exec/exec-all.h"
>   
>   void HELPER(gvec_vbperm)(void *v1, const void *v2, const void *v3,
>                            uint32_t desc)
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 861fdd47f76..0a04f149d70 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -24,7 +24,6 @@
>   #include "qemu/qemu-print.h"
>   #include "cpu.h"
>   #include "migration/vmstate.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "fpu/softfloat-helpers.h"
>   #include "tcg/tcg.h"
> diff --git a/target/sh4/helper.c b/target/sh4/helper.c
> index b41d14d5d7c..fb7642bda1b 100644
> --- a/target/sh4/helper.c
> +++ b/target/sh4/helper.c
> @@ -21,7 +21,6 @@
>   
>   #include "cpu.h"
>   #include "exec/cputlb.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
>   #include "exec/log.h"
> diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
> index e7fcad3c1b7..557b1bf4972 100644
> --- a/target/sh4/op_helper.c
> +++ b/target/sh4/op_helper.c
> @@ -19,7 +19,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "fpu/softfloat.h"
>   
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 5ce477d0add..f2877157b1c 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "tcg/tcg-op.h"
>   #include "exec/helper-proto.h"
>   #include "exec/helper-gen.h"
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index f7d231c6f8b..c864217175b 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -23,7 +23,6 @@
>   #include "qemu/module.h"
>   #include "qemu/qemu-print.h"
>   #include "accel/tcg/cpu-mmu-index.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "hw/qdev-properties.h"
>   #include "qapi/visitor.h"
> diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
> index c25097d07f5..a49334150d3 100644
> --- a/target/sparc/fop_helper.c
> +++ b/target/sparc/fop_helper.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "fpu/softfloat.h"
>   
> diff --git a/target/sparc/helper.c b/target/sparc/helper.c
> index 7846ddd6f62..9163b9d46ad 100644
> --- a/target/sparc/helper.c
> +++ b/target/sparc/helper.c
> @@ -19,7 +19,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "qemu/timer.h"
>   #include "qemu/host-utils.h"
>   #include "exec/helper-proto.h"
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index 4c5dba19d11..2c63eb9e036 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -23,7 +23,6 @@
>   #include "cpu.h"
>   #include "tcg/tcg.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "exec/cputlb.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
> diff --git a/target/sparc/machine.c b/target/sparc/machine.c
> index 222e5709c55..4dd75aff74a 100644
> --- a/target/sparc/machine.c
> +++ b/target/sparc/machine.c
> @@ -1,6 +1,5 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "qemu/timer.h"
>   
>   #include "migration/cpu.h"
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index adebddf27b2..241378889c3 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -22,7 +22,6 @@
>   
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "exec/target_page.h"
>   #include "tcg/tcg-op.h"
>   #include "tcg/tcg-op-gvec.h"
> diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
> index 0c4b09f2c14..9ad9d01e8b9 100644
> --- a/target/sparc/win_helper.c
> +++ b/target/sparc/win_helper.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "qemu/main-loop.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/helper-proto.h"
>   #include "trace.h"
>   
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index a4f93e7d910..bdbcaf0dfcc 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -20,7 +20,6 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "exec/translation-block.h"
>   #include "qemu/error-report.h"
>   #include "tcg/debug-assert.h"
> diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
> index ae559b69220..9910c13f4b5 100644
> --- a/target/tricore/op_helper.c
> +++ b/target/tricore/op_helper.c
> @@ -18,7 +18,6 @@
>   #include "cpu.h"
>   #include "qemu/host-utils.h"
>   #include "exec/helper-proto.h"
> -#include "exec/exec-all.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include <zlib.h> /* for crc32 */
>   
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index 7cd26d8eaba..11496654e4b 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -20,7 +20,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "tcg/tcg-op.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "qemu/qemu-print.h"
> diff --git a/target/xtensa/dbg_helper.c b/target/xtensa/dbg_helper.c
> index c4f4298a50c..3b91f7c38ac 100644
> --- a/target/xtensa/dbg_helper.c
> +++ b/target/xtensa/dbg_helper.c
> @@ -30,7 +30,6 @@
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
>   #include "qemu/host-utils.h"
> -#include "exec/exec-all.h"
>   #include "exec/watchpoint.h"
>   #include "system/address-spaces.h"
>   
> diff --git a/target/xtensa/exc_helper.c b/target/xtensa/exc_helper.c
> index ca629f071d1..b611c9bf97c 100644
> --- a/target/xtensa/exc_helper.c
> +++ b/target/xtensa/exc_helper.c
> @@ -32,7 +32,6 @@
>   #include "exec/helper-proto.h"
>   #include "qemu/host-utils.h"
>   #include "qemu/atomic.h"
> -#include "exec/exec-all.h"
>   
>   void HELPER(exception)(CPUXtensaState *env, uint32_t excp)
>   {
> diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
> index 53fc7cfd2af..5358060c50a 100644
> --- a/target/xtensa/fpu_helper.c
> +++ b/target/xtensa/fpu_helper.c
> @@ -30,7 +30,6 @@
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
>   #include "qemu/host-utils.h"
> -#include "exec/exec-all.h"
>   #include "fpu/softfloat.h"
>   
>   enum {
> diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
> index 182c6e35c17..71330fc84b9 100644
> --- a/target/xtensa/mmu_helper.c
> +++ b/target/xtensa/mmu_helper.c
> @@ -35,7 +35,6 @@
>   #include "exec/cputlb.h"
>   #include "accel/tcg/cpu-mmu-index.h"
>   #include "accel/tcg/probe.h"
> -#include "exec/exec-all.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
>   #include "system/memory.h"
> diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
> index c125fa49464..fc47ebaaf50 100644
> --- a/target/xtensa/op_helper.c
> +++ b/target/xtensa/op_helper.c
> @@ -30,7 +30,6 @@
>   #include "exec/helper-proto.h"
>   #include "exec/page-protection.h"
>   #include "qemu/host-utils.h"
> -#include "exec/exec-all.h"
>   #include "system/memory.h"
>   #include "qemu/atomic.h"
>   #include "qemu/timer.h"
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index 5ebd4a512c9..2ba4b1ae66d 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -31,7 +31,6 @@
>   #include "qemu/osdep.h"
>   
>   #include "cpu.h"
> -#include "exec/exec-all.h"
>   #include "tcg/tcg-op.h"
>   #include "qemu/log.h"
>   #include "qemu/qemu-print.h"
> diff --git a/target/xtensa/win_helper.c b/target/xtensa/win_helper.c
> index ec9ff44db05..4b25f8f4de7 100644
> --- a/target/xtensa/win_helper.c
> +++ b/target/xtensa/win_helper.c
> @@ -30,7 +30,6 @@
>   #include "cpu.h"
>   #include "exec/helper-proto.h"
>   #include "qemu/host-utils.h"
> -#include "exec/exec-all.h"
>   
>   static void copy_window_from_phys(CPUXtensaState *env,
>                                     uint32_t window, uint32_t phys, uint32_t n)

Nice!

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


