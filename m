Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D42C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmWC-0006Ke-6P; Fri, 02 May 2025 05:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmW8-0006KK-F6
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:17:14 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmW6-00020B-7J
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:17:12 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5427SNT6031883;
 Fri, 2 May 2025 02:16:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=evxx+6WAfI/eO6E997IhNU4g6LMor4Dio8yhyB0CJ
 MM=; b=2AOstTPleJjBGip1cFSm7NcG7RriqtYLTfMY+i4Iy60dwkbur3+zTZ0FK
 0mbD8/v4c14m+UvlK3NaXLeSbZElFh9st9ZF9tAwFKgaNoDhASBopgOFoInG7c65
 ir0765otq70k/jroEYkpLHz9V129DCYvcYtfKw73Q6o58bRyW2+8i13Im/i0Ipci
 1re5xQGCLl0+JwdjIV6RAN9niH7CaIOR5xD9urD80pcoFDsUmRjlupljYW4bDzFV
 QWP1iBJrZpgCVDm7Ro60yGHwhjqGG7rO84z3alV6QZRUUuVDWxx2UzMYnSVS2Bm7
 RV3hROPLv1erNxgCBo6s4SzD398Jw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468utudedy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 02:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZTo4VkAad+vJpAtRLxgekeLAbVT/WoSnp0tdrWr5cGhsH9JDD/412rPLNnkhft6pG1QLxbzv3Dt0DFDpvZPfBtIwtN2itm9eXRdxfLHsVC0UC+qnSl8K7lkQedGviVlldxLE5ira2xfPtsGaMkwdQnqDEBq5L89SlRMxeKi1TI1gyPX+JqOhngRxxZM2IJgzvqEj0N1hRiHSdxRSNQqWLQfP7j1+zVs8zc8COoBq9RDUIft06XOcWW5MyEMVZk3/E3Mcts9EFZYFRiPTApWDl65AMzElcH4VWPnJdxZmhWJ4Ouc/794FETMq9I7WXez4QUrquqi2DgK94xV/s5Anw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evxx+6WAfI/eO6E997IhNU4g6LMor4Dio8yhyB0CJMM=;
 b=gv898sZ4414iM5vNo/QWjz+tvCexI/umvdd5uezbcAP8DsV8gdEU8AW3LQBzDuC45lr4MGHOwlb3uRFGOFzDViWpZACWQSGdUx7fmn5ifHkVo2y2kQqzQjL9BkeFlHeSt4+Z3JT6iVWzeKam01FZZNXM52k6XzJS6Se4bN2NKlaAZotj54Y+/UE22NjzPfTm8omB4B2W8n1BA0vIOjOw7EJioH7YnDq7qyBm9M4nk/l7yALvd+Vbv1CjvuwqFsh+i2J4g4v7fLwA2eXSUwO7H1epF9ssqjkERMFeaexULdB+Rc0zwrlB0gBqfWM6CAj7dRqbsVhm0VpXn4FSFom8Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evxx+6WAfI/eO6E997IhNU4g6LMor4Dio8yhyB0CJMM=;
 b=SI8VU2D61FQ4gOSSspGM4V0uEhZjNjI/6WcM8aqPetrJfICZGmzS9ew0CxlZGpqTXu4xPFd+s0VZeL1Qf10ubwtvcYlPJHhYb8mB97ztPxbme2JhgmtAQv2o9xo1Pshe7FQzvUe/LopleHkTEHXngVomuHoXfNBXgO3VkCVLMdeptjIrlAV3BsxWczc82JUAnFHb17J76S70VqhlQllFjU/v38h9SZW9ksrKkLfGEaLUvIlsoRtK4xwETIcBk5hOCknKOzjDYmQuI6+8/hEhA3aRKAQhy1zKKgZVzp4UtpykXjRgcOSPsngLkZUiDg2Swx8yWiyOKiwrZXKS/k8zHw==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 CY5PR02MB8893.namprd02.prod.outlook.com (2603:10b6:930:3f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.22; Fri, 2 May 2025 09:16:52 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:16:52 +0000
Message-ID: <d15d3506-a8c0-4675-a2ce-b433c3dc9fdb@nutanix.com>
Date: Fri, 2 May 2025 10:16:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/16] hw/core/machine: Remove hw_compat_2_6[] array
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-7-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0054.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::18) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|CY5PR02MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6caf28-21b2-494c-a552-08dd895a139a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWN5Sm9GM1VaVGtaYytWRlFiRVloZmVXMTdRQng5dHJuMGtoNFlncy9lN1JI?=
 =?utf-8?B?RERCTnZUZlpwYU5tWnRWOURFT2d0NlhBRFpqYVArM0Zna3lNekFDbEU1Wkh3?=
 =?utf-8?B?UjdSaHhSTU9yU0FhVHRaUGhaZ2hrSkFPWGw4R0xsc3hqUSs1UWwxeGlNRERH?=
 =?utf-8?B?aXdnRmFtcHEydi9PekZuZDNTT2FjNmlGNzg4WHRTTXRqSnhlbjRtNmt2ZE9S?=
 =?utf-8?B?a2xBZzVBMEk0cDMwcGlSd1lOekRLU3JEdi9nbHlTNHZyVjFndi9zWWdxekln?=
 =?utf-8?B?aTlUdGVSTlFva25GNVpodHcza2RQV1d3SGNOdUljRTlRNUgxRFlyYmh1anJk?=
 =?utf-8?B?c2t3eDZxKzFDVHhCM1VpSDkzbG90NDM4UWU1Yk9rSHdUL2JiY0hZbkljbFZY?=
 =?utf-8?B?U1BOUFA5NzFUTUsxWW12em1kdndaTFJlM3JEamkvbVZPY0oxY0dqTFIwZWxm?=
 =?utf-8?B?S05HOThwSmNVR0IxQmltN2tnUllqV2hFTWM5clA5cU80dkpJUDB5NGJ6T2Qv?=
 =?utf-8?B?N25YT2NnU0ZTczlseFJaTVNLVEJTN2hyZWRuWVZCS0syV0RLelF3c1NPQnhh?=
 =?utf-8?B?RVgvNDg5aERxQk5kSmlQamtvbmxMdys0V0FBbytEZGxNMkpDVzluS2w5Q2NN?=
 =?utf-8?B?OXdLTEY2dFlscW42bXRteTZ3RzRQeDVEZ2ZQYUhhVkppTmFwVnU5TExlYVp2?=
 =?utf-8?B?K0kzR1ZjbEVnR1BHQWJDcDd2ejNDSUh3b1hvUDJ6OEFQRnFwNUtIOEhPSkNh?=
 =?utf-8?B?RTdqcC8xSGx3VFlpTFBOeEJtT0xudmFYendUbTgvcy8za0E5Z3gvbm1OODQv?=
 =?utf-8?B?ZFpSZkVhNUJiZHlsTWF3NkZ3Q3JadFMzeEJqM002RVd4RHVoVllTVHVKNTBi?=
 =?utf-8?B?SnZNVm9jWUc5eWJHSXNES056blk4M2NLQzBXNzU4YU5KVHQvK3JvZXBvOHBG?=
 =?utf-8?B?Q2o0eElEYndraHFBSjBldjRaZGVxUWgzN1hqbUd5TzNCcTBZYmRXaWd4T1BN?=
 =?utf-8?B?TE85RG9YOEtrU0hPZVQ5YlpKL0VoL0hYZmgrYnJEOWsxMHZZRVppMmpQSU5Z?=
 =?utf-8?B?UnA2NFQvYzRWeU1lTTdZdGVGN3BEdnFicTZjNDlxbjJaRkYyemp3eEJOS3lj?=
 =?utf-8?B?MllvM0VBTjlLOWxiMWxiejdQMGNEYjk2UzNsWWxaL2wwbk9ZZ3QrWW1ublBq?=
 =?utf-8?B?TGNQaDBnNHhMMXpJbHd4YjJVMHZ5RE5DSjl3Z0hkUVFRMGUvdEZtSGZ1b0sv?=
 =?utf-8?B?Z25pMWI2Z0YvNDFTeG1RbVRPRmlIYVZ0QTBoVGJrTkNPTlhyMEFlSU5rWmZn?=
 =?utf-8?B?b1ZnTjZhc0hNTzloQnFCMGRrSFRXOEhaUGRweVQxTnF2TlpWVVE1ZE54Qnc4?=
 =?utf-8?B?dkJzWXFXOE1iL2FNc2tldTBreXJaN1VwNzF4WVpVQS9tSTM3YzhyNFdhU2Mv?=
 =?utf-8?B?TTIyYnFwTEZYM2tKc3N0UVpJMi9VL0wrTllEZWxFSkJiTzhZL2tCU3ZiSXkr?=
 =?utf-8?B?Nk9kaGR4ckxrNXlXVmUzSGY1RVlObEtSaldjNXd1cEJ0S1FIQm5nemliTktW?=
 =?utf-8?B?L1JBWVJaSDZoT2tQaklDYVg5dkR2UWdWZTJMekFlZms4MHE4NE43bC9lZWhI?=
 =?utf-8?B?NWdmbVphTGs2VVg5V0dDczJ4U3U5clNYc1F1TGdxS0sySFk1bEFJNzkyRSt3?=
 =?utf-8?B?Z01kTmw4SUwzN05odkdNUmU1eGR5ZkdTaTZEajZFb0ZMNCt6QzVsalBwNS8y?=
 =?utf-8?B?MmVPZFIreG9aWnZiR3QxRU5DTXU2ZjhudUQwYmo1bEhOa05DL1JxYzBKMElt?=
 =?utf-8?B?MXh6cXhyT3YxdnBYa3F0NUpYUnVkZkNldmVqTFc3TXpNdW1wNkFHUm0rbm1F?=
 =?utf-8?B?R3JpaDA2L2VBT3Q0alBvMndWTmhFR205Q2ZBeG9oMEoyN3VscjF3OWxTN2hZ?=
 =?utf-8?Q?cmAmxNxPdh8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXJTdGNZdGFtRDJtTndncy80NDBrRGJ0d2V3R1lMS2RPaGhjVEtWaDJvMWQz?=
 =?utf-8?B?L1JYQlk3dEoweGxNU2I2Tmw5SlJ3ZFZsQXpaNUQ4S1V1c1NPR09KWitiMWdn?=
 =?utf-8?B?NUFNL2xINDVDVVdJMFdFOS8xMXF3YjZOSzJ1dUcxcUNnQkpvZ3owa091ZUVj?=
 =?utf-8?B?dFBYLytsSUk1MStoSmZRT0NESENUd1FNM3YxSDJ0WE5xR2ZtbHR4Qm1ta0Ez?=
 =?utf-8?B?V3kxdFdsTnpRd1ovdzEvdFhBSXFIR3N0Ykp6RlVzU01qL284dU8vY1V0UVJ0?=
 =?utf-8?B?M29JbHUxWENJZHFOSnVJWFU2M0FPUTdiTDJDelR5TllCVHNsM0tjU2hwdFNY?=
 =?utf-8?B?N2tsMnExUnlMUEZRbzBCWUhxTkM3eW14R3BySDVwMlRoa2JhV0kxTnBCUFNO?=
 =?utf-8?B?T3B2WkhPc1JJOFc4RHVUOVk4QzFkQVVTM3M2ZDJBS2JhcDdzOS9HWUwzWlRQ?=
 =?utf-8?B?WUpOSUdkUDRnRmd4dmFHNTh3amtJdHgzZ3l0eEZOUFRYV2lhbTlEcFBLT1lO?=
 =?utf-8?B?eTRodTZ6aDl6eDZsK3NLRmxMekFGVVFqYkE4UW5QOWVMVXhoVlJyVEdhQWZK?=
 =?utf-8?B?Y1M4Vkd6U3hSZ0pxTVJRV1h4SjhVVHUxbm02ZFVrZ1EzNnVJY1VEWU9LNjZI?=
 =?utf-8?B?bjdGeHlrWTlDZVRHcG9RYmIzWFdDYk1TckcrbmVHVlpka1d6TDVBQ3ViazZB?=
 =?utf-8?B?NTVzVzkybmdSazRlL0x1NFdKOEJHUjgvUVJHb2NQY3J6U0dFbTZSakhlMTI1?=
 =?utf-8?B?TEhmbW9TbUs5Rk5FU1h1UkJvK1NncWdxcHFSejlneXpzZE5oVCtiSm1mNzZ0?=
 =?utf-8?B?MWRpNG55RFBTOEg5b1hCWTZzQ3ZuRUR2TEpuaVFqZlRtYTR0bVltMmNMTmIr?=
 =?utf-8?B?M3lQbmxjNEJScC9xaEFLeHh5SjNhL3dnY2tiRFZOYytsTkowWm9DSU1WUGhl?=
 =?utf-8?B?VWQxajJrR2V6bllvYWhHeW9raFNrRjZQSlVWYm1yK0NPejl5NkllYTZ4Vy9Q?=
 =?utf-8?B?dHBjbi9LTUlGR2p6cGFxdWZEWG5ET2c3emx5YzcrL3kzQ0ZnWXgra0FIV1Q0?=
 =?utf-8?B?cktrRmR0RVZhVm5oR2daVWp6SlJQTHRsV1ZzRkM0b2ZNRGlqSVV3TENmZmV4?=
 =?utf-8?B?MXlxMDhBN0xKbkVLdThzcklPbDNiZGhQUkhreEF3RU5CVTlBbnlFUnNIeGpO?=
 =?utf-8?B?dStOVGlwVVU2Tkl0OEV6cWVVMmdNaHZORS9wbWJFQjluSTYyTlVlclI2MVZQ?=
 =?utf-8?B?c0tGY2JXbE0wcEM4N3pVa2ZJTUYvT3QwWG5sNjB3WUVxMnF1ZlRzTmFBb1BM?=
 =?utf-8?B?WHhmdWUrNzVpQnpkNzNERmFOM092a1kwL09oNW5CaSt2MExPdUZvaFhERm9h?=
 =?utf-8?B?OWM1UE9IWEdKMUxPQnR5THcyRFU0b1dUeTdNZVJqMlBXb0kwZ0lMYmhnUHFH?=
 =?utf-8?B?aDNIS0VPOG56M0hZRHBPZGFMT3I0Q0dDUVhWYzA0ZWlJRFBGbzVXalJ5d0ZM?=
 =?utf-8?B?bkxISUJQR2lEbHdKcnBvd1lXRkY3bmM2MldRbHpWSmdSWWRPZ3lkOXRpOEw5?=
 =?utf-8?B?ZVVlZnBFZlA0UlRkR2JRNWh5NndyQWZ4Z3RnSWZmazY0M29GNm11RzRGcGhI?=
 =?utf-8?B?YkpnY2xQeGxlWXJBU1hFbXp5cG1Ka3VZdDR2bkQ5TFV2UVJvdTRieUxaZ2JR?=
 =?utf-8?B?REFjNnJCZExqVUVOeW9xc1k4Wk1GeFJhU3B2akZRUUh3M3pWZEI0NVc1emlo?=
 =?utf-8?B?Vzl3RlRIck9pcnVwQlcrSitvN0IyUzJCMjVuOVk0VGdrTTBtUFkrSHNSVVF2?=
 =?utf-8?B?YmFOYURhekRPMDlUd2c5NFBZQ0xNeC9CZ1UvdDA0R1J3V2NPU2xzWlUwdmZ0?=
 =?utf-8?B?RGV3dGJpblBBenVGcTd1WnlRemlaS2ZKWm1reTM0VE9hOUxyZ3dFcDIwOE1z?=
 =?utf-8?B?cWtoMWx2NGNJMzllanhYanZtUW1uamRnbTZ1UDBpQ0RrRXhyLzhrbnlhTzhD?=
 =?utf-8?B?SkJuWjVObG9qbzk3L1RreFprOHROd1RPVzJJWGxoT3ZVblpNL2F1UTgvaTJ3?=
 =?utf-8?B?S3d6QnppQTBVOXcrTUE4bHhUQVNqMEwzK2x3UFZUL0d6M2VKbWlUbE1VVHNL?=
 =?utf-8?B?NERxSjhNYm0zazBxeHVvWVhUamlFNy9OTlA5UTBtZUtMQ01SSmdsTXRJWHRh?=
 =?utf-8?B?WWNxY2lKVXZ4WVJNaWNKdXRlRHRwNjhTdDRvWkxncHk0bnlWb09ld0ZrVG9n?=
 =?utf-8?B?cWtSTk52ajViRU1lZ2tZd0t5K25BPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6caf28-21b2-494c-a552-08dd895a139a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:16:52.7629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXkek1bNJQMebYf2aEAriFW8Ka5pS4nRz8uDdc8w1Eaq/SfYCk7c4HOMdPR/bcuVuO578H5CYs2sDnhb1I9KbPI1Qa5wxIcQ9vt2BytiI2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8893
X-Proofpoint-GUID: rWsOXcLxZ9BIEDUen7Weaa6OALcS1QYf
X-Authority-Analysis: v=2.4 cv=GcIXnRXL c=1 sm=1 tr=0 ts=68148d87 cx=c_pps
 a=VLWBoSTBoww685Dj7+Q0uQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=UAXzGZX6NWqAfFX32GoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3MSBTYWx0ZWRfX7KuePXcaDDtD
 hJxdtWzFGpNi5o9M1g8D3MwJmzJ0iDbdZHXfZ8YGxWASfFT3wwZ6gb8KCmVFXH/FScpVRSAsjE8
 0eu8If5a5UrLYZWDrn3FKquLIwMNcXJvy3iErwn4Q5WLBU6CkLxmlNwq3YUSFNwGQEUtLo+sHx9
 0A2VNczP6ki1xpxhawG/B7utPuDfbl7SIVP7ulyKNkkCSYqFWw9V2tu2n6WUypI+YdbdWkw+Yj0
 Ae4B4nMyNs3vBYzbPaiJBdUfLGm6VFIJqtHLHNhKz2SpRlC3mOzLTKpG1BBnvyvMNwWieepLNyj
 gOMEwHd872R/rVY7qwreH4M9CYIz+R0NbY8KYIKtD2IpMOLiwaLG7fJNWX9iQE7Btsvv3jq+19f
 W0o2oGXHQqBh1H0bUADv8ke/fruT3X3RP5X/XexaP3cE8eR9Ph0sa2EjuYzweNwmdKZUTHIw
X-Proofpoint-ORIG-GUID: rWsOXcLxZ9BIEDUen7Weaa6OALcS1QYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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

On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:

> The hw_compat_2_6[] array was only used by the pc-q35-2.6 and
> pc-i440fx-2.6 machines, which got removed. Remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/boards.h | 3 ---
>   hw/core/machine.c   | 8 --------
>   2 files changed, 11 deletions(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 5f1a0fb7e28..a881db8e7d6 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -841,7 +841,4 @@ extern const size_t hw_compat_2_8_len;
>   extern GlobalProperty hw_compat_2_7[];
>   extern const size_t hw_compat_2_7_len;
>   
> -extern GlobalProperty hw_compat_2_6[];
> -extern const size_t hw_compat_2_6_len;
> -
>   #endif
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index e7001bf92cd..ce98820f277 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -275,14 +275,6 @@ GlobalProperty hw_compat_2_7[] = {
>   };
>   const size_t hw_compat_2_7_len = G_N_ELEMENTS(hw_compat_2_7);
>   
> -GlobalProperty hw_compat_2_6[] = {
> -    { "virtio-mmio", "format_transport_address", "off" },
> -    /* Optional because not all virtio-pci devices support legacy mode */
> -    { "virtio-pci", "disable-modern", "on",  .optional = true },
> -    { "virtio-pci", "disable-legacy", "off", .optional = true },
> -};
> -const size_t hw_compat_2_6_len = G_N_ELEMENTS(hw_compat_2_6);
> -
>   MachineState *current_machine;
>   
>   static char *machine_get_kernel(Object *obj, Error **errp)

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


