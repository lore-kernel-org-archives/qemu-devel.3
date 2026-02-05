Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E30DECD986
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo2Ce-0005hB-Uu; Thu, 05 Feb 2026 11:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vo2Cb-0005fl-6t
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:27:33 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vo2CY-0005jz-C4
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:27:32 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 615BudXA035949; Thu, 5 Feb 2026 08:27:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=OkwYtEUu3N8hKncutl1VouY14yUlePUiC5y5SirPL
 Gk=; b=dP/+bVjspG+XVwek0LNxerRGM246iiLLmAa6RVtdIWjfGOSCdnJToFYfd
 mZMbNxamSeXADrKNG9SCidqOl2YyaiNHU37hLPpnvdnNxHuJkBSIoDRR5+DuAkfR
 gqpx1oaN3LSsHs/txyWdcZk4MP5GmH6CrMx3McPfV/GYHxSl7PjJe6LSkCYl2dBY
 EYHzyBLhVgtrzo3Ca5eH9ItjwkZHiqeCSOKgcdkEUULqLu4IFb2NUuHDRgr9TyOH
 CzCatky63HaspYWbxqpQB4T5whnV5acPdcKPPcePkJgwa57v/rKppYDWWCFzuDJs
 oGmAL9aJNyxSNpRyAe9NlA1u75wgg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021140.outbound.protection.outlook.com [52.101.52.140])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c4emb26q6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 08:27:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhf63LwhTooVFLHkhPF5hWScCJlDHcY9KtiPy8RHf+lX4jWlntEs4VHHoXUVYVraKV2RCzaG+WqFHnZv4r9KsyrGitZF9y12GhOg4V56Iu+YZ06OJz8cprRKjrQhGnn2z6hYt9mzDDmECOZYNRPEV8AlCZYyPFd9sOLBUv89ru9bvdgezTnX4tR6fsoNj7VcSGUst+ohrrrGXabg+fY5w6lPrJLcvQIIj7K1ADpMQctiTn9aGYVCXOk3P/KPu/v2c/tSi3JtKGNiHkEGswLeHPSHMfAF7PpIUdH8a7buyt3TAsqkZ6jMft/ZPyztgvmheLIgSNJckdUqXQiO8+BbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkwYtEUu3N8hKncutl1VouY14yUlePUiC5y5SirPLGk=;
 b=AcTvP5LJc2mddkh5kWqgud6wW26735pUbKgqb09jH1EHzXON26apG7qxQM9glQY8iaCoEtZt1sKm5UAdLtKS2qKEDzAT9KpB03FbGBNwxtEipUVvetGX1oQwN03Ig8gsWMoxbO0fPFYYLY8yp/Am+7eDNk0hsQAi4X4ylZPRGxI/lFEnP/L3yJID9Y+S70Y7+J7h5ej0X2vximnjYHMlCtLw1+3PjDtUrihUSpqT+Z1wOsQsppXj2SISgz0nJYpHVNZF6b54KDoSGobCKy2fVBdhLUwaG9eFSqoOuHpLXHqtYh0ShUfqpbACGB50Y1YPPDMSBYeBtWqr/vybZHr7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkwYtEUu3N8hKncutl1VouY14yUlePUiC5y5SirPLGk=;
 b=gEcsq5Nws1DInut9xXNR/a/s/qDZ6Z4PRZRLhiLu0Amn9JGtzbpwzj7z8VzBgQTnR4nR4qZyRMmF+GnSXZkpwJzUceox0fVV0TFHVC8a4bMhd2N8jkd/cwP++ZjKm6uUT8tM4/K+c4t422sNY0rE7plg3l1qC51gMP5WtJ5HyZbxJeYW3jsxYDBor6qiSCqB6tztGA9xea/FsA5SuLCPgDvH87OoaL2OS+j/KYfrsYScTFvJIDN2CZ4tFyFA9o8IlRSTIS4AKX3UFJr66TEIAUAaHhukGkC2gqcb3hLiAqwS0qTq6yDfyGSKZCz7LWT9Bu0s446SMZuLkVsH3FE7Nw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB9114.namprd02.prod.outlook.com (2603:10b6:610:149::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 16:27:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 16:27:26 +0000
Message-ID: <4825b39b-6a44-47f1-b75c-a9965fb3bdca@nutanix.com>
Date: Thu, 5 Feb 2026 16:27:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/37] audio: lookup "audio-" object types, and realize
 them
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-24-marcandre.lureau@redhat.com>
 <c77444a3-8bfb-44d0-8b6b-b72d59ed4e63@nutanix.com>
 <CAMxuvazrTrL1mW6XDDgQTw+RpQn0NnMGLGirLzgxnXqpqTO_Ag@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAMxuvazrTrL1mW6XDDgQTw+RpQn0NnMGLGirLzgxnXqpqTO_Ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0222.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d26b2db-9ed8-4a31-599e-08de64d372e5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MURnUFJ5aWw1Vm00ZFRXVks5UWJPdFlaK3ZsSnZIcWRocnlZdnlrK2xDUWs2?=
 =?utf-8?B?TlNyeFlzWjZ1MysrbDBUZjE4Sm1JUkxURS9EUGRyWStvblFLS3ZnRXZCK2Zq?=
 =?utf-8?B?MzNISDlyaVp4NGlFTS9saC9WS0RucTAyUmNyQnVUWCt2WGVwTVZuOGI4NCta?=
 =?utf-8?B?em9wWnRJV1U5NEg5VDBGUStEa2d3Y3FpZ1B3a24xMUZUaTJhbkVaNHM4cU9F?=
 =?utf-8?B?T0thNGY0UE1xbkwvU3RMN01XQjRWM0tFY3gxa2hOSjU0RTZnRGFvSzVDRHlp?=
 =?utf-8?B?UVlyclljOTdvOGttTFVpMU04bjVEd3Y2Q00zV3dER2xXK2JWMXBWT2hLTzF3?=
 =?utf-8?B?ZUYrN0FCcnl4dTczazBGRDVoTExjWi9rc3N2d1R1YWtUTnY1NTUxTnMxMTJL?=
 =?utf-8?B?UEVUdFlqRkhUNUQzK0NvcGxNV2MwR1NoRmxISEp4S0R6aDA5cmtGNlZRK3py?=
 =?utf-8?B?U1RaN1p6OTVjZFRFdjFSVjlmTUFjWnk5MkFHOW9vMEJ3RVptM3JsYWZ4WlFn?=
 =?utf-8?B?b1dxTXVIUlVXOWFwYUM2elpheWdnalZDbjdEbm1oU1BteFlYeVE2T0k4QUZU?=
 =?utf-8?B?dnJINStBZEtPZ1RuS083VGk3c3Z1MlVVczdFSzBXNEdiaFVBbHVSbXBNSzJS?=
 =?utf-8?B?N2ZSVkNTOFBLcEoxakZXWkhrcncyeDM4aHFiV2twazN4VVpmdmVydXcxM0ts?=
 =?utf-8?B?L1RxU0hUMDUxTXFTWEE2QnJOM2tnSmtsVTFHWGlRbGVIQThlTFVIcVF2STFJ?=
 =?utf-8?B?S2F4OU01N2pTdTBIZXA0RUpVMXJnWW12Q1RXMVltb0FYajM3MlVOVTNDZi9T?=
 =?utf-8?B?cS96eGJZMXAwdUp0Y2FGbm54aE1tWkF6TG1XUnl0b0ZrbE1Sdzg0eElvMGtH?=
 =?utf-8?B?ZWJoZTNwRG9BMFZXdEEwSS90aGo1cEpDSHJ6UGo5cnVzNFV1d2lIQ0FyNjR5?=
 =?utf-8?B?U2lwT0Y3QXhqekVOSEI0aGIrTGx1OC9ZY1JmTHNhQXN5VEpyT2R3NkRkUHJl?=
 =?utf-8?B?SWdzalN1dDdqdVdjYVg1YkZRUS93YXRCNzJEODRuUmRmWVNXTjZoRkJCSjhZ?=
 =?utf-8?B?bW13S1hsRFcvZUNEME1hSjZBamp3QzdnQlA2d0FoWGxad2k2eU1aellRNElU?=
 =?utf-8?B?bmhnTFQ4VHcrL0RHMDRTajFHREhndHRPNE1QNzh4a0U2WU16Nm15SWozdFZC?=
 =?utf-8?B?VGRnUGlkWWZreE4zVWxQOWI5V2dBUEFhZno3ZmRUNENBQVduaSttQXY4a3o2?=
 =?utf-8?B?b0VhN0Y0SXRwY29wQWcyMGt5S0ZBN3NGekRUOWlLb3VVR051bWNjSXltSkdv?=
 =?utf-8?B?SjBoWFhLdWtXVDZ1Y0RjYXNXVjhjcjVydGp5aDZTdTdENk50VitzVlpBeFUy?=
 =?utf-8?B?ZTZTdFBJb2RsOGk1SlQrMmNtajkrR0xxOVF1U0tyeEtPK2d1YkRVVWRVOTBW?=
 =?utf-8?B?dFpSbmV6M1dZK0ZZNUlGWkgwV0hJWjA1VTFHMWU3VHQ3dFFma2NPWEVkbFBF?=
 =?utf-8?B?Nmc3QjZ4WmdLcWlDcE42RzB5NUtZVjh0NzBVblMyUE9PcWR1dE9SNngySzBx?=
 =?utf-8?B?ZnU4TTBGbE9hYlpUTm5ZNHQxMjVjSDBzbitUMThkSVV1dlA3a0JXa0ZIVnhi?=
 =?utf-8?B?RWowc2VtVldWdkVxRUl0MnZaWk8yOEJucUpHcC9uVlY0QzFIdytiVVIyM3Zl?=
 =?utf-8?B?OUpYRTR5QUg2L3RqVlZpSUNRZTFIdENkWjdxVFVhTlJGakJFempWd21QRVNw?=
 =?utf-8?B?cGg1dWZVYkhRYlFDUHZJYkVtU0ZtbWZPUnYycFV1Zmd1OVVHdkxLZnlrMU1s?=
 =?utf-8?B?aG43bm1aSHZ3SUtVMnZaRHJ1ZkpzOWE4RTNLWll2bUxJemh5eHZpR3dTTDhX?=
 =?utf-8?B?YVgraW5wZGFTRTJBMUo5NXBSUHB4S1o2bjZ0SFJQaU15em1adVhzNTU1TlUv?=
 =?utf-8?B?cEhrZFIwTk9QS2I3OVU2bklaeTlRZWV5bmU3ZVhNOE5mVm9IUmkydGpHclhF?=
 =?utf-8?B?SmpWSEEvamdpczY4cnFMclZCSTRGNlEvZW1kQXUyaVpHT1lKdWV0NnRJU2FI?=
 =?utf-8?B?VzNpeXBNRWUwZ2JsdEx3MWtQM1VGTXlQd3FZcXdxMHdCcW5iZzdlTFlVclIx?=
 =?utf-8?Q?JyBE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGVNVUpPS0k1OEhYWk14QTdDa1hpME93bDN2M01qQXphbXBZOUx5d29NVWRq?=
 =?utf-8?B?OUQ5MWFOTVVWdVBBYjNqSHR0NTRFL1A2c0FYcmlMbUh4ek80amdNZDZ5T20x?=
 =?utf-8?B?bFdGVUZ5ajBZQ3laVDFJcEpyYkFMYXdOZTNJUWlBWEdUcFg5dEZ5UlEwUDF3?=
 =?utf-8?B?Rm5YMGNtV0lnWG1oU1o5eHlEZXZIcUdVMTIydDR1M3BFWlJCaXIrWkJJZ0Qz?=
 =?utf-8?B?Tk5tTHdXeitwZUtCR2p5clpncFBUZmllNldLVnpuMkt0TFRrVlEyeFRZWTlG?=
 =?utf-8?B?R1Qvc1N5VThjVVl5NHBJMHYrWkRFakt5akJaWVYvUGJmZ045QWhiUHpYREF3?=
 =?utf-8?B?Q0d1K25GMEE3ZHVqTG9TNHhMNFpvbk9nK3JEYS96TUdEaGhRaEtSMktpNG14?=
 =?utf-8?B?KzBQdDZyeEZQWkZuRWE5QXFNY2RFREc3bW1zOVU2S25Nb004SnpUczVzNkYw?=
 =?utf-8?B?QjNsNVNGUWNiNi83TlAvaWhRd2lNL2RCaU9kK3RaTkJ1S1RhR29KeVRUSVNk?=
 =?utf-8?B?R3VaNkFLQm1XTFhsckJGQWlEWGJBSVNWZDRrMUFPTFJXbjVZUHZXMHlaTnB1?=
 =?utf-8?B?WGU4QmJ1dEt0MUQrUEtaVW5WZjBvT0NZcFdOQXNZbW43elU0N1BmWmZCQml6?=
 =?utf-8?B?R3ZvTWFRODZGQ0hiVkRMVFoxOXo0bUFyeXlXQXp5L0hNTEZ6ckdIdkhEdHdq?=
 =?utf-8?B?ajBHcm5XUmdiMlRWZVJUVzNOTTRUTlRZUisyL1QxMTJ0MlFtU29ZV2thM1M2?=
 =?utf-8?B?NXBmVVYyZ2drSFRMMU5sMFhYNjY3dTBkeGYvRDc1K05YaWo2SGNQSTBManVU?=
 =?utf-8?B?Mk9IRFVuZVRKd1RTWFpWQUgwZkZRNkZFcmtDWjhqbGpMeGNKWll1b0VQZWRr?=
 =?utf-8?B?ZThUaldCMGFqT2NYdTZtRDFkLzBFVDVJTTVHK1pJWFhMRXAyN2QycmpZSGZX?=
 =?utf-8?B?OWxKTU45YjJ1MUJlL2dsVWhUeHZXYmlTcXFaN085NHRJaHlHMUdKN0hDNWpk?=
 =?utf-8?B?K2xreW5LRFBBSmxzVGJRbkMzNEZ4U2xRQXRwQldoREg3OXdSQmdNYjAwM0xH?=
 =?utf-8?B?OUM5cGNwY0JSUGhtUWhXaG1HZC84MC9YY0tmTUhZK1V1ZnAwckZKQjlLaWIz?=
 =?utf-8?B?UFRJd0EzSENwb2FqZVJJdklIaVllYzNZZVA4SmpQeVRkMllpd2JQS0xwVGFV?=
 =?utf-8?B?R1h1VjZHbWxqNmxseDQ3UzliWUFYYnZaRXBPL1J6eVlGcWRDWUVydm9qMW1J?=
 =?utf-8?B?UHA5UWNyeWR3WTlNVVFWYnpsblhobThvT1FVMzVEOXNIaEp6K1FTRXNCcUlP?=
 =?utf-8?B?V2FBUFhyeVROUERpcHYvaVRaOEZyc1NIbG9TWTRmTzJmTnloVDZRNVcrbm5z?=
 =?utf-8?B?WVQ1d3pnOERaWDl1RkFJdkQ2RlFxOWxZcThvZXhoMjFjVlVDNkx6WGtEY1NZ?=
 =?utf-8?B?b1JRcHFlWExpdHpYL2FXeXR0YnMrZmsrc0dqSEUreWt0MVhaWGlpeGN0UU9p?=
 =?utf-8?B?eGVMYXF4NzhCR3dkN0tmbTFEKzl2amhZSGJ1WVBjdjlDN1dNZU9TZW41QVNZ?=
 =?utf-8?B?cVBVSlRYSUREbHRwSmFsQmFhS0xWak5zaGF5MnNubXV4a0QyckwyVlBPeGh0?=
 =?utf-8?B?My9mcXVBTXN5NC9VWGdmOWlITmhBTVNGa0tWQ01yL0IwYVIrVDdjYjdyTHp2?=
 =?utf-8?B?aGJZbFp2SGtWOEdvZGFTWFlwSXdQRk9EVkFhMFRLVm5HRDJSckx3UlI2QmZo?=
 =?utf-8?B?TWRVS00zRlJ3MGZpV2FFRlVubkwzUWlBVlB1ckxDYTNIRkx3Q2NRNkxoVFdT?=
 =?utf-8?B?Z3QwWVRMd01WZ1lUVFRpYTNZWDRKNG55NUJzK3RFVXhuYmxON2ZsOEtRbkZp?=
 =?utf-8?B?K0R6RHRLUmI2NldMc1c4cmU2d0p4SVJxeTBMS0RZWU40NWdHTFFoRXZpSTl3?=
 =?utf-8?B?ZExjTjJReEJEWm9PcHZSdTI4YVBreHpVV2pqL3BCK1RxNm1mMFFSK3Qrd3Nw?=
 =?utf-8?B?SngwVHZ6VjhRelFCLzY2WFluSmNSd0F6dGwyeU5jUWJXV1lubDVmc1AyeUsz?=
 =?utf-8?B?Nmg0NzA4VnNRbEtmaW9BaFlEbXh3TThIakxyTHRiYlhXaFBCNTVOZUE2OEwx?=
 =?utf-8?B?MVJZdW9UTFB5LzhTbW01cTVHZzhCTGZHT0w5Qi9VWTJ5SFNGM1p0Q0V3cEh0?=
 =?utf-8?B?K2tnc2dTWWNxNEZwNmMwakE4M3pVNktIRENHYVo1OVpEL3lZWHV4aTJsRzZ5?=
 =?utf-8?B?cFhCM2VnYXB5UEVsVXdlbVVMWHFhMTR1Ukhod2ltZmFXMERSUDhnUWVEbVM3?=
 =?utf-8?B?QXI0UVFYYi9kUm9ENzlmcXl2RG9UVGNoSlcvTUFJRXlyR1hoMmd6MzNrWjla?=
 =?utf-8?Q?971ltm75tbLHf2Ko=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d26b2db-9ed8-4a31-599e-08de64d372e5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:27:26.4263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16uXW/fuE9fgTKCcm2QsGyu9mdpBv6H2jVwmZGIOPj8eEEBdF4GSMkWVEOb8TFtFgXQTfPnK5QO0KEZ66Vb6MlL5FQf+6ise+SqmC56DWto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9114
X-Proofpoint-GUID: HZW0DXz-kikSeu8bMS40KSKp3LAgruHm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNCBTYWx0ZWRfX5TgwWpUO2TBc
 CPPZOdWHShy+3S9xkZnLyUVu4KW6k8dOGR+4klKCykwGJRKDkQ32lGHiN2OCeMf+ouIoXcQZDVK
 W6508h9kLGuO+DiygaXNoa+g1jzaFDshdrFvAprKujivWEecGeMS7DIxSxxb+c28HmneUxTCSfu
 n21lAuH3/FshdmJbHyJFA+AOjt2OVhyVCdYYGF5vgIT11K9+M6+dB9hsASPhchYh5sPBAaKeDgK
 YRWLKu0mwlJmtGzUolygMY4QZJSFVRlhQsZrLllhw+KVBn4Ls7ugznh1t3yTBoYBBkIuKW1p8d6
 C0wOYYI3ZX6oMMjTAweOY+j1AmrLSBeKYHTOJI+rHSns8S1LLC7/aPRlhIeisGW/vt07Ig8aRVu
 Lhiv6OcMtVgmM1C7mw2HeOABc9sax9KNhFqXjaAIkzzq/Bpdeltimq/LJVI2DUNIYye7VHOdLIG
 8jKq/c9nkDhwUItoetw==
X-Proofpoint-ORIG-GUID: HZW0DXz-kikSeu8bMS40KSKp3LAgruHm
X-Authority-Analysis: v=2.4 cv=Z7Ph3XRA c=1 sm=1 tr=0 ts=6984c4f0 cx=c_pps
 a=gYwftH0Zntp9Uye4m1fzyA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8
 a=SMHBd62EOTy9xGSA90EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On 04/02/2026 14:39, Marc-André Lureau wrote:

> Hi
> 
> On Wed, Feb 4, 2026 at 3:33 PM Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
>>
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Now "audio_driver" is a detail implementation of AudioMixengBackend and
>>> not required to implement an AudioBackend.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    include/qemu/audio.h |  1 +
>>>    audio/audio.c        | 40 ++++++++++++++++++++++++++--------------
>>>    2 files changed, 27 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
>>> index 474d761f0be..1eeead2a722 100644
>>> --- a/include/qemu/audio.h
>>> +++ b/include/qemu/audio.h
>>> @@ -51,6 +51,7 @@ typedef struct AudioBackend {
>>>    typedef struct AudioBackendClass {
>>>        ObjectClass parent_class;
>>>
>>> +    bool (*realize)(AudioBackend *be, Audiodev *dev, Error **errp);
>>>        const char *(*get_id)(AudioBackend *be);
>>>    #ifdef CONFIG_GIO
>>>        bool (*set_dbus_server)(AudioBackend *be,
>>> diff --git a/audio/audio.c b/audio/audio.c
>>> index 7e23a63d401..f6896229cfb 100644
>>> --- a/audio/audio.c
>>> +++ b/audio/audio.c
>>> @@ -1561,24 +1561,16 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
>>>        return total;
>>>    }
>>>
>>> -static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
>>> +static bool audio_mixeng_backend_realize(AudioBackend *abe,
>>> +                                         Audiodev *dev, Error **errp)
>>>    {
>>> -    const char *drvname = AudiodevDriver_str(dev->driver);
>>> -    struct audio_driver *drv = audio_driver_lookup(drvname);
>>> +    AudioMixengBackend *be = AUDIO_MIXENG_BACKEND(abe);
>>> +    audio_driver *drv = AUDIO_MIXENG_BACKEND_GET_CLASS(be)->driver;
>>>
>>> -    if (!drv) {
>>> -        error_setg(errp, "Unknown audio driver `%s'", drvname);
>>> -        qapi_free_Audiodev(dev);
>>> -        return NULL;
>>> -    }
>>> -
>>> -    AudioMixengBackend *be = AUDIO_MIXENG_BACKEND(object_new(TYPE_AUDIO_MIXENG_BACKEND));
>>>        be->dev = dev;
>>> -
>>>        be->drv_opaque = drv->init(be->dev, errp);
>>>        if (!be->drv_opaque) {
>>> -        object_unref(OBJECT(be));
>>> -        return NULL;
>>> +        return false;
>>>        }
>>>
>>>        if (!drv->pcm_ops->get_buffer_in) {
>>> @@ -1600,7 +1592,26 @@ static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
>>>            be->period_ticks = be->dev->timer_period * (int64_t)SCALE_US;
>>>        }
>>>
>>> -    return AUDIO_BACKEND(be);
>>> +    return true;
>>> +}
>>> +
>>> +static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
>>> +{
>>> +    const char *drvname = AudiodevDriver_str(dev->driver);
>>> +    g_autofree char *type = g_strconcat("audio-", drvname, NULL);
>>> +    AudioBackend *be = AUDIO_BACKEND(object_new(type));
>>> +
>>> +    if (!be) {
>>> +        error_setg(errp, "Unknown audio driver `%s'", drvname);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    if (!AUDIO_BACKEND_GET_CLASS(be)->realize(be, dev, errp)) {
>>> +        object_unref(OBJECT(be));
>>> +        return NULL;
>>> +    }
>>> +
>>> +    return be;
>>>    }
>>>
>>>    static void audio_vm_change_state_handler (void *opaque, bool running,
>>> @@ -1643,6 +1654,7 @@ static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data
>>>    {
>>>        AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
>>>
>>> +    be->realize = audio_mixeng_backend_realize;
>>>        be->get_id = audio_mixeng_backend_get_id;
>>>    }
>>
>> I'm wondering if an AudioBackendClass realize() method is the right way
>> to handle this, and if instead an object_property_set() function could
>> be used to set a "driver" property?
>>
> 
> By the end of the refactoring, "driver" is gone. Effectively, each
> (current) backend will inherit from AudioMixengBe.

(goes and looks)

I see, so this happens in part 2 of the series. If the property were 
exposed directly to callers then I'd prefer to use an object setter to 
bind the Audiodev to the backend. However in this case it's all nicely 
tucked away in audio_be_new() so it doesn't really matter. Hence:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


