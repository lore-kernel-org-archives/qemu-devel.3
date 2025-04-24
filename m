Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621D6C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tYr-0001ay-BV; Thu, 24 Apr 2025 06:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tYp-0001ab-K7
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:12:03 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tYn-000573-EQ
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:12:03 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8nJmb030330;
 Thu, 24 Apr 2025 03:11:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=BkoLiNcHUQz4dLjLJCrkHfmETXg1LaDfckIbmqCW5
 eM=; b=0KXf6wT7Yu+1XlVn4E6bpgzNGZPGeuf2RBtgwii5WVLW6WzJEuFnyWwCY
 qAxHf1dYFcJDcaBWtEUT3fcnQjWFV6vhbeZQwBIRk6HuT/dtjbbZ6iBHKTmuIANQ
 5VNz316LCExgxgP51Vsq5sJHjd6gUN6JcllqYPWkj7y66/q0rJ4JsiikpTRKG64E
 EQ+wdkYMnYhuvnfnNLJ29TJct45r+nW5vkKw2pFZFPDJd8VPZpXWQ9Pc1v0EEb3o
 w4fli4rI0S03F3rX/DVddGwHyVbj3uoCg9JMQ7Vn5J5ivK+5r6om/72rdukHWfFZ
 QL5fTLivbgibKxGXPRQTNYwAVxlGw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17011030.outbound.protection.outlook.com [40.93.12.30])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 466jj0v4pf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 03:11:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1LNn00jFqtexzoxFhXz5CnQokFrKRi8mQJcaHRp5G8MxSPfmZRL6kNBv8Ac8fdSxUKDx/VuHUnSC5KZ717JHesfds3fgV3SSCw9VO3u5+M9Wwq01p9E8IJyQqb7aZmcUnuxkp6KCf+9l8ArJw2FaI031t3J//wS2eyvY+ozcFi26aTF54a7NwciqwjQKyPFFHMTrnKuLAUyguetpZkyDoKjUfqBm+za4QA2oeBoIttVKi3z1dUxo9Ljne+wgKpWdmj2rFcmn0rScrdtbjoBpH56BXy7DCnexvgfz55FI4zY2+gvXLBoh+xrgbmU6huBYX9a2X95mtjYO6Y0VepAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkoLiNcHUQz4dLjLJCrkHfmETXg1LaDfckIbmqCW5eM=;
 b=qkpTl1oN8M2e1WIcxlVw/Qj9x4Z/ZaqRpL2DpxgG0LsBQBxaxRHulq5bnGZPsUb1ru2S9ktc4sTvTuSVlLlGWUkW8AOskUepiLzzVfVgeQnJpaVHyorHCBHsNwtF9Nqx3bTYUWh/YIAM9YB+/Jbn27hpmNIbrtdF+Y+fsPU+GYZwfttbL3kt83DDKFhpr8h6wNkJOiutCTH/7wUTKWXkQsr2R+gAeb7BNMrvgFzSgYpra0MSdxmq1mea3XSRxykUqIOAJToYOtJr1BCF6B3yBRaF3b6fpBHdJhFGcTwdt7I3F2BzbkOh9sVkFYDccD/Zn/ws2KuvclsdVeNJvO6vYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkoLiNcHUQz4dLjLJCrkHfmETXg1LaDfckIbmqCW5eM=;
 b=x5rBv1TgioxbKeCFPNjv7mZBdUbOqv1eCWpWE5h1PrZRNI4/UaGR59XAWZnT/LQusw0/8CrSXwPiIjVAfbPvP2ysDXGmLM2iDBGZsYG3xs3E0pgMLYmpRLxQwl4ZHO7ja3Q7l/1HDEi0Lh839/Y3J0suUVllL3LSJ1z/QC+OlAfCnxDSCjyVYWFgzmYrRiQdHvP6fyTwoe7b+5gXZ7btG0vyBIydmztaCC95AuAY52nC2Pqi3huG2YVBRkDyo3HjmrVE9XckkCa72ZIqqZ8KdsdboM8vHfym24Po4HGdFyAWPufY1E5KaI9FAlSxM58tlSdGkT8n5Oijpyw2ZGiNow==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 SA2PR02MB7707.namprd02.prod.outlook.com (2603:10b6:806:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.8; Thu, 24 Apr
 2025 10:11:54 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Thu, 24 Apr 2025
 10:11:54 +0000
Message-ID: <08b58be8-5b9b-4180-8de8-cc7c282a4513@nutanix.com>
Date: Thu, 24 Apr 2025 11:11:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] include/exec: Include missing headers in
 exec-all.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-5-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250424094653.35932-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::18) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|SA2PR02MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ecdb65d-bd98-4cbd-dec7-08dd8318704b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THdFc1FJQVhCMlhxenF6ZG1Sem5RR1RlaW0zSG5memtFWThoRDRlckdNalZP?=
 =?utf-8?B?YW14TFJYM3JIOUxUaVRZRnBCb3BEa1lyTWxDRi9XdVZOVlZDc2x3K3gyMDZM?=
 =?utf-8?B?T0V0azFXZWVIT1B0Z3BFQ0FKamlIUERCcjBzK0F4bmZORzN0Q3BkbHphSW1t?=
 =?utf-8?B?S1FPUm5mSTBGM05JdE5NczdGOEg2YytGQVNxOFo2REJsZ2llNFhYUXlHNUNk?=
 =?utf-8?B?cEd2bmVJTmM4b3NDZ0pWQis0VUV4R1ZzcDNpbzA1UDlpR0xTQXovU29HSHli?=
 =?utf-8?B?VUtMQVdwaTUvTHVsbjZ1ZGo3dkprSWtaV1N3WmhTcUNCU2F5WVJ6YUhOajNF?=
 =?utf-8?B?VW55VTZwWGZVTk90TC9pVUJwb1RVZ0RrdjZMN1VqS2dLaURhS0diYzlLWWVS?=
 =?utf-8?B?SndscWE3eWlJb1ZibnF6Qm9vZWhDSTg3V2tudWNsMURZb0xDY042U1RiV3Br?=
 =?utf-8?B?TnFBRWRBa2RJV0hObXFPZTAzMGQ0YWtsc1IvZ2xLMS9NUTcySFB2dVJwa1BO?=
 =?utf-8?B?cXMzU1JIRDFCUG0vblZtbGl2L3JyYXMweEo2d3dDTkM2Ly9SNHBqd2NRK2pr?=
 =?utf-8?B?cEFZTzlpUHgyeHpiNHFiK0o3SHptaVd0OForTVVqa25paTA3R2kwdlNtaGpl?=
 =?utf-8?B?RmpyOW1ibGo4cWdJaFljMFQrK1ZIRUd5dXhrVWJLSzAxUFZsRkY3S05pRWh6?=
 =?utf-8?B?Nmg4R244aGZEWW03Yk0wTGtvM01JcEdJUmN2azRuSVJydWN3WCtPQ1A1UWN2?=
 =?utf-8?B?QlJ4eEFZTCtCVm1xaWt5RlpBazU0LzhTWlA5ejdxS0RhZHVlTHZETGdweW1K?=
 =?utf-8?B?eEFoV1NwS1lBNWtMMXF5TnJSbUx1R0ZETDVHNTh4NUNZL25mYzFoYXZtZFQ0?=
 =?utf-8?B?aStleS90QTVwNVdLY293MEVWUEhyVm01ZzZEb09mRk5TTmZhZHplUnJHMnBG?=
 =?utf-8?B?Mk9oSStVV0gzN3VMWnpBOHYvUGxBRit1WkVRT2FiNVFOVUd0WGpJbGkxVWsr?=
 =?utf-8?B?QkFwRzhZNDZGSk5nMDc2ZHlwcVMxYk1QZnJDRDRvTFgveHpxWGo4dDRYRkdZ?=
 =?utf-8?B?WUo1bldWUFpORlZOalFMNis0TFhRZ0dGVGYwb3RBa25SNjM5cFdXcjlmcEpJ?=
 =?utf-8?B?a3ZCQTVyR2JvdzZoNzFxTTNLaHE5VXBaaGI3NlhTUm5WQ2p1VWxuR3lHc3ov?=
 =?utf-8?B?TzlsajRXMmZtVlZlWXl5bFdldytGSlpaa0xLTzR6RDE5ZlVCTDBRdlNEL1p6?=
 =?utf-8?B?ekwza3BXQXJ3WE5hWnQ0L1FZRlNMdmNRMmtiaXlTZ0VmYW5lVXlEZkRGblBw?=
 =?utf-8?B?UmFseHU1MWNZemZnRHlldjJUUnVYU3lqVlBzVXdhRi96d1UrcGF2bXJrMk5a?=
 =?utf-8?B?dXVRaVRkcC9vRzR4dFhpS2FxNGUzYzd2ZEZtSkhWUEdwd0NQbG5LZU9HcFVV?=
 =?utf-8?B?QUhGNW5UUHpNV2ZMZmJRNnl0RTdNTFM3aDQ2UEUwSDdHcldqNXh2Y05tRENH?=
 =?utf-8?B?T09yTUtIRTV6VGxlaWNjWXR0WUh3RE5UNE93RzBiRGpaQW5xRVV5ek9wRi9t?=
 =?utf-8?B?VFJ2ZjhtTHc1ZE1FVTYvaG5zUE5Dai95OXBOY2pnd01qVG9ldmQ0TUs5Ukxv?=
 =?utf-8?B?YVFBbUtzT2c4Z0twdC9YanVXcmZGcE9FVXpqblRaSHZvekhLNmhRa0M5NlFv?=
 =?utf-8?B?Z1ZuY1I3ZytqZnd4RkxFTzk1elZtRFpoaGIxNnZzVzBnbDM5NUxLN3FYaXgw?=
 =?utf-8?B?VWNRVWRqSnIzRzRSL2w2ZkN0WEduR2c5Q3dFcnlyT1BsM0RGYkNxZW53eHNB?=
 =?utf-8?B?NXJqang2S1BpbytrWkQwdWxwbDJadElrK3d5d1lmQ1ZPdFgvU2VLMU5JTlNv?=
 =?utf-8?B?U25HV1FUVVZFL1NWUEVNcE1hU2ZJSk9aUnlHOEFITkF2TGxQbXNFcktPUWtr?=
 =?utf-8?Q?EnjFk/la24E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTVkUHNRbExIMXpQeTdqR0xEUllISFIzMzMzQXdOWTBBVE9nSkZNczF5VHhF?=
 =?utf-8?B?cTVKdTNNREJ2OHo0YWtnNzZGWUt1S0lRZlkyaVM3M1ViYVM5MUs4VjJ4TDFx?=
 =?utf-8?B?Y3ZWalFEeDJOZU01TlBKZWlycWh1VERMTG9PUHRDdVJQd2NoeDhwbEJPRll5?=
 =?utf-8?B?VldXckpnWXB3WHNLSTlkYXA0MkVHNW1WUE9BRHFHUjBSVmtGZDFIdWQxNkk0?=
 =?utf-8?B?VmtvTXJvVGgzazhBWG1GdHUzRnJhb2N1YlVaOVpVckNlRFQ3K0xtUnVzeDky?=
 =?utf-8?B?WXh0M0VvSDllU0JCVDdZQkVOQVUrUDN5RFYyM0xYbkxnQ0QyUFQ0dml1d3dv?=
 =?utf-8?B?Y2NwYTNRUGZvTVowK1RGM1lDeUlCL3JqNlUvaEJJNlhnN3lHTmtCaDBxUkc1?=
 =?utf-8?B?djU1YytuOEFxWlVYdDRmQjlSNEpwbzlPd3dCbTc1N25QamFxcFhqNDZUQjJF?=
 =?utf-8?B?bkxoRnNwMUY1dm5zYmF4eCtiSnA3WFY0M0c2Z0t3YWdSQy8zWmV6RytYWkJh?=
 =?utf-8?B?NnpRUUpPUklxOEhnWTJGV2laNTZpUGRzcW9LWkJtcnAvMVdoelpNUGQzL21V?=
 =?utf-8?B?a3JxVmxOOWRlMi8rKzIva0x6SDdicUc4T2oxQUFXV1NSbWtBaElYdnJCRnpC?=
 =?utf-8?B?UnBocFJydk05Z25IYWdTaWFXL1hmdHdjUmoyWEFORXlqT3BjdmdoQjNBUkpj?=
 =?utf-8?B?cis0eVRqRVpHSG05endHWG1VNEJXYUQ4UkVyNkt2clA1UVNNdHhIVTVVU2hU?=
 =?utf-8?B?STl5Zis1OUk1dTV0M002cWprZ2ZMcDJTbFpRYS9ndDlsZXBFWTZzNnIwcGZO?=
 =?utf-8?B?VnNOVnZHOFRhV1M5OXBLNnBzeTdxVFNSZDVma1k1K2ZvWU5Oa2RNV0QxcnJ3?=
 =?utf-8?B?NXB6SW96eTJVZGk0ZUpxMDV0T2x0ZHFsUCtRNG1Ya015cWEvRGkxQjgvWXNn?=
 =?utf-8?B?L2VqejRrTzljVjZjWFlwU2Q3QWZwRE5lS291VUdWa1lGZCt1SVdPeVN0L3J1?=
 =?utf-8?B?WHI2QmlBUFY1ZDdYSzFFL0dSRXdIMlA1alpZUzVkWjczUklqZ0l6Vm0wRTVW?=
 =?utf-8?B?MkFiVHJKVXVZcDhoU09GaHdFbGtYMVlLVXNNRlBtUkRBSlg0TlBxakE3MGNi?=
 =?utf-8?B?RGdvSnJ1aGNpWlFlcEJsZWlISHVnejBHa3N2VUJmRklyUGpPRXc1emhDQWpG?=
 =?utf-8?B?SmkwOWdVeTFZOXFVS3NHUlV6U09URW5DeXpwR0lrcndsa3ZiQ2hsbFh2d1pj?=
 =?utf-8?B?MVFpL21QTm81WWwyRnJLYWpxTkVROWtlY2F3SkhOZDAwN0ttcnhrNk5kaEM2?=
 =?utf-8?B?NlovZGo2ZzNVMEMrL1J1UVNDMUovNEhxcGJuZkVnV2tNNTIxcXl4R3pMVWVq?=
 =?utf-8?B?aVNQQytpQ0xzOXVwZzlEWlJkQ3RERW85L2d0RWFSM284MmxBWmw2SlhVcDhm?=
 =?utf-8?B?VXJ6M0xyWGZDbUtyRTd5YWFmREsxSFhITkRrMnRYcHZpUFJaNGQ0MHVZaDNF?=
 =?utf-8?B?bmd6YncreGZVUUNURHRNcHBpeUp5Y2NTbUVBQURnRFFaQ0hxNTBwN1ovK1ZX?=
 =?utf-8?B?Z2EwM1NoS056dFJBU0RKVUhoTTZyYkxQWTFqSVhyd2hkZFpmZ0dpSkhtbFF3?=
 =?utf-8?B?WWxNRmYwL3pJalBoKzdaNHl3YkFEZjEvSU43clh4Rm1oRDYwSll0Q1hHU3JM?=
 =?utf-8?B?R01lM2xRRHBPN09BNmN0WXRFSGp2NEZHL2lHWFVkRi9LRGxhV0lXSXcvQkh4?=
 =?utf-8?B?TnV0OTdhRjMwSU9RRWFWMlpqbW1qbWx5M0RTalRldlBnMlZKMk9HNU9TU2JB?=
 =?utf-8?B?aFpDaVU5TFJzWmlyV3FPbHJpTG1ZaXd4aTladm82ZU5OMW9XQVNSYnN2MEJx?=
 =?utf-8?B?R0NIR2Y1UDV4OGp6OVppdzV5UTM4QmxGR2RSeFIyNlZhNysvaHBFL1ZYVDY4?=
 =?utf-8?B?MG1KWkdDQmNiS21WZ2krdEI2SVRTMVNSc2pOdExnL2VZOEE0SkhuaEVObkZi?=
 =?utf-8?B?MDZ2bTZJNXgzeDBQWk51S252R21UWjNWM25jN1YwczB2SDZrby9admpyaFUz?=
 =?utf-8?B?S2dkNzhhRERaUzA0Q3ZKeDFzckRMV3VFeDlQejlUM0YrenhlcjFIdm5PbVRM?=
 =?utf-8?B?OGVSUmJ2emh6N2pPQUJTZG53SDR6QnlnZ09YQTlFNEh3bEtzVExNNGxMQVM5?=
 =?utf-8?B?MHVSS05Wa3pKRXA5K3Zvc21pOFVXdnQ2emlOY2hCbVc1cnQycXA0U0NJU1Z4?=
 =?utf-8?B?TVgzcE50RjJ3RGtCVUdLYzdmb3RRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecdb65d-bd98-4cbd-dec7-08dd8318704b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 10:11:54.5195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5YqQz6eevpp8BVseSprMT68pTS2gGkEH/AX7wULpLycuGSp/EwvTJNocuVn7Eg/ZBY4ug9f50o5pkyUMpH8Vy/bRQM8G4jAGQKBBVgcUgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7707
X-Proofpoint-GUID: i1ASs3IqLY3fOtQ098WkpStELYXhBEdL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2NyBTYWx0ZWRfXyasX4Coiy1Ay
 wPSk2tWT9alKErRviL4C6sjyfVU9C7l8ZDO5p5PHY677UG0XJwUfWK1ZQD3OjyB7NsNiby8IE4m
 1SoAmYx/02KbB6/JsxiJA1IP+xZFEklG5H5U1tpi+oGNjTHmjjBa/hWWpSQ7/lJW2zvCDwrJZqR
 TXx72aFuaRMsC2TNhApfl2HqZlwaw0PnoTCuChnjOQIrof8Fo7F9n1uJkrl84sO8Y9NMhKERTPp
 YLtaxfHMwUdbu746k5IxZiHQSIC3i+Hwy14vC8nWjsxwZCrE9gju3EPrg266pGHal/Qyc5WhOi/
 pK1dCyLWGzdyLhtWzz2IpTg01K9GO2t+c41m27FBCX/yzF8WpsY37XgPcEuF25gXZx86YkVerYP
 QSLH8b99QmkfGKE1cldIjAfgbtw+13y81Buu06yaWDUfB0d7D/U1EzsRcjdNxcqHXao9baqq
X-Proofpoint-ORIG-GUID: i1ASs3IqLY3fOtQ098WkpStELYXhBEdL
X-Authority-Analysis: v=2.4 cv=V5B90fni c=1 sm=1 tr=0 ts=680a0e6d cx=c_pps
 a=f1nyBA1UpxJqkn7M4uMBEg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=8MwuGu2ODOXkCGt7IwYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
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

> "exec/exec-all.h" declares prototypes such:
> 
>    void *probe_access(CPUArchState *env, vaddr addr, int size,
>                                          ^^^^^
>                       MMUAccessType access_type, int mmu_idx,
>                       uintptr_t retaddr);
>    MemoryRegionSection *iotlb_to_section(CPUState *cpu,
>                                          hwaddr index,
>                                          ^^^^^^
>                                          MemTxAttrs attrs);
>                                          ^^^^^^^^^^
> 
> vaddr is defined in "exec/vaddr.h", hwaddr in "exec/hwaddr.h"
> and MemTxAttrs in "exec/memattrs.h". All these headers are
> indirectly pulled in via "exec/translation-block.h". Since
> we will remove "exec/translation-block.h" in the next commit,
> include the missing ones, otherwise we'd get errors such:
> 
>    include/exec/exec-all.h:51:1: error: unknown type name 'hwaddr'
>       51 | hwaddr memory_region_section_get_iotlb(CPUState *cpu,
>          | ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/exec-all.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 24383b6abad..c46255e66ef 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -20,8 +20,11 @@
>   #ifndef EXEC_ALL_H
>   #define EXEC_ALL_H
>   
> +#include "exec/hwaddr.h"
> +#include "exec/memattrs.h"
>   #include "exec/mmu-access-type.h"
>   #include "exec/translation-block.h"
> +#include "exec/vaddr.h"
>   
>   #if defined(CONFIG_TCG)
>   #include "accel/tcg/getpc.h"

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


