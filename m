Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5409BD43352
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 20:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTnNs-0006dE-7Q; Thu, 11 Dec 2025 15:35:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1vTnNq-0006ch-6j
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 15:35:30 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1vTnNo-0007jr-Eo
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 15:35:29 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BBEPZBV1430990
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 20:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=pF0KqlQWtRT4+G37HvMyN9AKsXKFsA3j0u3MZvIXzLQ=; b=R2
 3wY7CxshRidIUsecdTuKyjnGU2oaXljZLnymJadqXMUsnYC7M7uAKuc8GRnlWPIZ
 ZwkFOfxydxlkfvt0HZOw/RLM5zq5Hqi40c4s6FJiCjojf0MK/2HexqMAR5RbrXG9
 8+BtpI969+OmHW9T/hjdjQgwRFTE7MTVoE53bJtrZ0iFt++LBJlQyPHSbqvog8/3
 CSYT0PlUAzAITFk4BsvNUYPQML210lvVXMZQyBCmLT3g//q8r5p3GARYJ+Z67Us8
 9vi+nquHYDjQNj/NQ75C0QgCeyzN1+gYvZj52ZvB6GZm+To17Xsy9D3VtVct/lj4
 PqqnGgzunO3y8UtlKS7Q==
Received: from sn1pr07cu001.outbound.protection.outlook.com
 (mail-sn1pr07cu00106.outbound.protection.outlook.com [40.93.14.102])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aym583b64-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 20:35:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erfLIfmeoGP8h7aPO7RHtLUW/O7s8NhZ3kE8TX5IVuqInfLoEjEMUFsaJl1BOL2YjeyUl7wa4P70CKoZwvQkUiqXSJAU8pdFskimK32mhTOGsFNpE4rZT2MHLBc4amKvOc+1RGmMzTXCZLwt54X8OcJPfzrJfLqJWlwPLdf5B2UNzsO1LVqsHAL6EVIjZ91RgGuSmnqQBOCJyTw+l7DA919MB9+q0l/PWVeRPLwH7J+AusrQOhG5cEL4QrD9I+3kpqeG0QyWtYTR674yXhoif1ZXOp3UojfSKzgkLfCutCttxoB3V5/SPiOxYdCiyBKLKsxSESkXRMWOYE10cdMOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pF0KqlQWtRT4+G37HvMyN9AKsXKFsA3j0u3MZvIXzLQ=;
 b=jKzi0g2vt9Faib5UgqVzHhndnPX+tTdo7zicD7BqmklCTGNOg9ab6NVuEmT4cekqMb4MVZoDbn8PlEZbyzWDNzQh4T5DUMGrKYOEgk2n8SXK+40gj6L1+RIyi8bvOyWzXslT4XYypHXRDOu4KMzD5Zgm2jqCdCBu/JIk280OXwWJmC8pZmDvBqfnxjbuW7lg5m/Qutns7nWYP+p6u39wGLM2DEyoSBbJgOBXZUqOwimZdDtfGKLKIuH5uByWQzVqG5gPk+bh2Y23rs+xrPc1W+L0aG6bVAng+GaS5pEn+Iz4AcySqIAb3TTMsTp0dvE0yABr8XYx8RthxufGtkEqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from CO1PR02MB8617.namprd02.prod.outlook.com (2603:10b6:303:15c::20)
 by CH4PR02MB10755.namprd02.prod.outlook.com (2603:10b6:610:247::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Thu, 11 Dec
 2025 20:35:23 +0000
Received: from CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf]) by CO1PR02MB8617.namprd02.prod.outlook.com
 ([fe80::5a28:4da0:a734:9bcf%6]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 20:35:22 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>, Matheus Bernardino <mathbern@qti.qualcomm.com>,
 Sid Manning <sidneym@quicinc.com>, Brian Cain <bcain@quicinc.com>, QEMU
 Developers <qemu-devel@nongnu.org>
Subject: Re: Record AS in full tlb
Thread-Topic: Record AS in full tlb
Thread-Index: AQHcaPk/84BXpnny1U2sGuplCRM7l7UcjP8AgAA+u4CAAAntAIAABuCAgAAHD4CAAAXDAA==
Date: Thu, 11 Dec 2025 20:35:22 +0000
Message-ID: <E8B42BFC-864C-459A-AD72-A8515CA988F6@qti.qualcomm.com>
References: <A5D46F85-9B92-477C-B964-1DCE2A1CCF19@qti.qualcomm.com>
 <0d3b4338-2c31-4e42-8a8e-319f3ad4029f@linaro.org>
 <2A86D9C4-7EA7-4275-943F-D75801B5539C@qti.qualcomm.com>
 <081b44f3-48aa-4af3-a0d1-c8e5915d95e3@linaro.org>
 <1400AC45-E6F1-4031-A95E-3F51B79D71DA@qti.qualcomm.com>
 <de93ce41-6797-4b0e-95cd-ffeaf16b5c89@linaro.org>
In-Reply-To: <de93ce41-6797-4b0e-95cd-ffeaf16b5c89@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR02MB8617:EE_|CH4PR02MB10755:EE_
x-ms-office365-filtering-correlation-id: 441858c2-09fe-415d-ec2a-08de38f4cef7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OUVyWFlYaUpwQjBTR2IrZ2pQSW5GN1dGU3ZtY1l6dTQwWW9QUGNNblYxa0Zs?=
 =?utf-8?B?L09TTFM1VjBURSs3SEZJNnVUcUFBSE5VaUh0NXcxV0F2L3lFT0xaWEVsMDZi?=
 =?utf-8?B?TWNRZlZnYmRKZkxSN1lRTHBScmNiTzNTdStpWEtDUzVWby9qck5Kb1BjZzRV?=
 =?utf-8?B?WW1BS2VRSm9xbUp5SjNKNEEvR25tRzdRTlhkVXBKWWdmZVpXbTl5MnpZVndQ?=
 =?utf-8?B?WGZSNlNOY2dXREdzMlBjaGdDZEl0dU9TQ0l3M3lreVM1azl6ZmdtUzZuNVFn?=
 =?utf-8?B?aU9oY05lWmdmSUNVRVhLM1NBcWpBQWJUbVN4N2xlWEl5WUxDRlQ3eHRJcEtE?=
 =?utf-8?B?ZHVaWXd4SmhFQmxXSVFDRlFuRHRQTjJnekNVbXdrbGNJbkZscXV4US8waGlK?=
 =?utf-8?B?MDVsVVU0b25WYnliai9xdUxTODlzcUtmU2VEOENkajlWZmFOaHM1Z1BZUnRa?=
 =?utf-8?B?WllMK3pndjhiL3gxMHJpTUN5dS9rVXFsZ0ZJK2pMd0kyZ1NGSFg3MnQ5Y1lV?=
 =?utf-8?B?RElSYW9zVUpFSHRhejdpaTVibVcvbHVHOFNkOHJLci92M0QzbHFtZ25URVJu?=
 =?utf-8?B?bHVDajBwajBoTWowOWJlaWU4Wk04OVU2aFk4dWdkeHlNcjViSURlekkrbzRw?=
 =?utf-8?B?Wnptdmh1WlRkdkRhT25Ja1E2WTl4aUtRVkFRNGVzejF0WWNjY29GMHo5bWJp?=
 =?utf-8?B?U2xscy9WMWlLYzNIN3pEeDYzcks2SUZTY2c4SDBrTnY3VEV3b2tXaUtnalFW?=
 =?utf-8?B?R09FUysvb3p6dVdiMU9WVU1BTVYzbVRjbGhTeWN0QnJyRERrTXFJRDFCTWZL?=
 =?utf-8?B?OU1iOFJSV3dkMmJkc0U3NWM5cHJKc0RpdklJZkRZZVorNlU0b0twNzRiWE5m?=
 =?utf-8?B?Q1hpaTJnR0RTeW9ETnkzdVBkK2xML3JiZ2FhV2gvZVBESjFTQWhnWnBESXAy?=
 =?utf-8?B?dlRKUlN4US9FR3VPZFZoRXBRMWJOSGdKb3dmYTkxYi9XZzZHYXlYSHZiUmk4?=
 =?utf-8?B?dEV6ZEh3RGZZZmFDOCtMTW5mR2tTdWNacmttSkMrRGhJbHB3UER3QUF3ZTNw?=
 =?utf-8?B?Y2xiTkc2c091L0x3eFRna3JYbXF4S0pOMWZRK3YyWURTWFlrSXZaZUdJWUg3?=
 =?utf-8?B?Y250SlpSdW5scG9UMC9xOHZxeTRyMGswSytkZnFBUlNmQkRiWnFHT0djb2dY?=
 =?utf-8?B?dE96WUFoRUk1dGZlUm9oME8xcUVKQ0c5U3l5YjRHSXg2Uk5WcUdOVUJicWhF?=
 =?utf-8?B?WTYxMjlBTDBYK29IZnNrNjA0aFlkZHJ6a2Vadk1DZklCRDZPYS91TUl1NzBD?=
 =?utf-8?B?aHhVQXQxMkJITlRmTFpYVjNpUW5ORzVRZGNMM3htVHFudzdyZGJwOTNxRWgx?=
 =?utf-8?B?M2lBYVFDZzltZjRCNUx0ZWdPT2dkTDZScTh2TmtQb0xudENoL2NiKzJZMG1S?=
 =?utf-8?B?L2Y1SllvS3dScmY2QUtncCt2UGVSMXFCcEtnNUp1NitidmhseUZ4WGJpaHNy?=
 =?utf-8?B?U2hNbDFEcHMzcGVvaFZDMEIrMlgxZ2NlbDJlcjhQLzQyWnhHQWM4Z1ArQ3po?=
 =?utf-8?B?dXFxYzZqQTRpQm5jUTVpbS93ZjJacTBJTW9Qd1lKYStIYTNyRldhZmdtOHU5?=
 =?utf-8?B?S2ZrZHE0VlhicmdIc3N0cmxvTXhTRyttNGx0N01ZMzJqc1RPV05waEdPcmFM?=
 =?utf-8?B?RTB0aUVxSE5iS01vNnYvT1J2c2YxQVYvd2pWMUdDaHFNR0hDK3Buc3d0Tzkw?=
 =?utf-8?B?RTR1bjlNejFveS9XK0RSMXNxamM5OGJHWWV4NGxNNFNsY0xYYmNybG5ZZ2U0?=
 =?utf-8?B?ZkowSUFMeGRKRUkzOHFhY1VSNXkvZkZnbE9PZnhKc2huU1d1M1FvbGpYQmZZ?=
 =?utf-8?B?Q3phZ2YxYU82T2ViMkFjYzNwenByTDlLeXRSWmpOVzVEQXllZVFSSHFWS3Vo?=
 =?utf-8?B?ODluRzVpWEt6YlJoK1Z1NnY4cU9vcW5oVjBHYkRKTVhMQkhDQTVJL0RxSW8r?=
 =?utf-8?B?V2kyRkFYTlRsT0xDNW5aMTNLb2FxTlNOeTJvNDlwZzQ1blpJd2ZjSHZVMlEv?=
 =?utf-8?Q?AvutU2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR02MB8617.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEV4YlRneG1YdHRiSFFjblh5NDdrRmY5ckhqeFprYTNSOGZUOCtTQ1BaN3V3?=
 =?utf-8?B?ZTBuU0lvYnMwTW1WUnAwWFc2YU5HazBadGxhNkpMcE5TcTdBUjByc0VGUFJN?=
 =?utf-8?B?aWdhMmJBaUxWWHlDT0Rsc1daWURRTHRudnVEZFVVVENnZVRvcDh5RkYvSnUx?=
 =?utf-8?B?YXZBZWFTb29XV3lzeEs5R3VsRzFhMU5rYUpKQjlVT21YNjJjZW9rQncwRDFS?=
 =?utf-8?B?Uzllc1NxcU5ha3JPcDN3SWhLNVRPWmFLdjZLWTVZb3JRSy9IUmprZzRreWtX?=
 =?utf-8?B?TGRMSlBpMWlnbUcxT1JVZ2ErV0dDeUNRbW5tWHZSMWIwRlVoU25vY0Zjczh0?=
 =?utf-8?B?VkhUdmFzamZKMHFFTytKMFBSc2UzZ1QwYzlwUWpIY1dHcjBsdUxmbituYWpP?=
 =?utf-8?B?Q0crdG9rZ2JpTS9yWk9CenVERjlvbG43ZDZvZ0FicFo3OGxZNjBvMFpSeEJu?=
 =?utf-8?B?TDJRNGp5WG1XMnRKRGlud0l2a1RQQ0xxZ2dkWUdtK1UvZjAyQW4yamN6bEJM?=
 =?utf-8?B?L0R0MTI3WStFcVIzMzhuUGJ4UzBFSnZyVllXWlBINy8yN0p6UFhYR0VrRFpB?=
 =?utf-8?B?UUZmVlZ3K0htbXlQdnRQcFJPeGVpTmFFc1JaSEFwVWZBUFRjcU9iTmpRZ1c2?=
 =?utf-8?B?Qm95MkQxeVdDUkN0VGlaNWVMTmk4UWY3b1h2T2lESDFNV1BualNndTYzek43?=
 =?utf-8?B?dVM1OGVXMDBCd0lqdllkbHNoNTVHYXdVQ2l1ZHY4cTUrcExNQmZKeFR3a21u?=
 =?utf-8?B?cVZQMXp0SW1NWkJhbnZQSG5vM1VFU2NxdnRtYzFlRTN5WDJoSUluQlJqM1M0?=
 =?utf-8?B?U0I1L3U3U3pMeThTTDA3T0g4V1AybWdPbDQzMFVTb1VNRzZPZll4YzRNN1M5?=
 =?utf-8?B?eG1BdGNSMXlTRWwrV0xLVjgwNUZxL3p5Tlp6NThkVDdxY01BSHc0Q1o5Nk0r?=
 =?utf-8?B?Uks1UFBrcVNyQzhsWDFNNC9IT2pSazlKRGNBcGJBSE5RcVJDdE0xYVVrRExm?=
 =?utf-8?B?b1d5UytJaVJGRGtybS83dmJ6dEJaaHNkVU1vVE5iY1p3ZDMzZEJkU0JrSml6?=
 =?utf-8?B?Ym1YcHNDaFRyaUxvemhyWndXdG9TeDEyS0tJQyttTkx0LzJXQ0VDUGwyMklM?=
 =?utf-8?B?eFgzV29CbS80ZWJTRm9NYldpaU1aOE9SZEJUTzlrVmpJTmsxMjYzU0UrbXFx?=
 =?utf-8?B?dFZNTjhwZWo4Mys2UGdJd24vTXA2VjI1d2IwN2E4WTFzSGhpVEkwOFB6Mzdi?=
 =?utf-8?B?cjZnTHArcmh4aStJVnhuVm1lMjZSSWlvUTI5NndrVmRvKzBCc3dvdFJpTkRK?=
 =?utf-8?B?VnA1UXNsTk1RV3Vyb3o2c0tjU3JCYzRRaWljdS9ENEhPemhDWURXZjJncTlz?=
 =?utf-8?B?VGI5aTVndzdYWnQ0bms4U2N1VVRsNCtjRWE4T3pMSUo5czllR0RtU1VmNzNY?=
 =?utf-8?B?WVlEdDZTdi9sSWZIZkRVNjR6Nm8xY1FFRE5hZzBuR2ZhQ2huWjdwQ3plOS9n?=
 =?utf-8?B?dE5KL2xxdlFLY1pkSHMwNVFHMnVkVjhKVVJMT3dKT3JuWHFPM2VTWmo3eHVJ?=
 =?utf-8?B?c3RFRWlDZHhMUXF5M2psQUQrZFVWSWJOSHRVSmlGNHBSVmdCUk1tb3dXRXp0?=
 =?utf-8?B?d3hmdkpmcjRneDZueVl3aHNsbUhKQTVDMEU1aXJhbUd2WWg0bW55RUhISXQy?=
 =?utf-8?B?TVRnYVVyc3N4ZXRMd3lyQ1lHc0NHL0gxTENTSmptYWMybGRrRUxBRTlDcjhn?=
 =?utf-8?B?dDZqQ0gxSTF5YXFoYldQa3IwMVJ0cG1McjF3TzcyWEVQL0NaRmpTdDhpQkIz?=
 =?utf-8?B?ZVN3S2hTZ24vM1RjaTdZaWRUZlVySzlld3NvL3A1R2Vycy9TUmcyQzZzcmJ4?=
 =?utf-8?B?TUFTSjZVWGlMR0Z2ZjRqcFZNSms1VzNhbnQ3c2Npb0MxaXdhTkNvM1NoOTRE?=
 =?utf-8?B?UUF6TmRrK1dkS1V2TFVtb2gvbEtycDNXZGZ0elRUaGE5bGZsUjFZWENNTEx1?=
 =?utf-8?B?TmJrekp1RHlkUGJZczVLazVQK1NTZ0phR3NQbGRZYUFUL1NDMUNjbHlVMGxn?=
 =?utf-8?B?NUZZTlFuUWZKSzlnbWc2blF4Y0N2dWJ4dk9GU2xhOTBuNlpTUXA0eVRHZjdI?=
 =?utf-8?B?bHR2MXBTSGg0MURqeFZXZGRybVZsRTVnRnVNaXFSZ2VqeG9walgzWC9LWjYr?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CAE146B8A766B47955EDAAFB216AA34@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MLMU6SmtTyCNys6Q14RE5apu/IBmzitdGNHGk8TAtp/IoEmCTzCcUEzBXCSBolBWuPYNrGHQ03EmbjgGPJ7cZ2NUHClxxVtAuDfLJ0/SyOL09PsOV1bieIxPdWqkCgiJU1PenGH5RD9/+Mod2nBqHW9Ywg2jcnDOU1/EsLypSasfI5i3xE4V+twz0kot47dEkvF5J97a4dgp5iuWtdFeSwchrGaCRFOpn/8fUqv9LromZoTr5zjeDiGhGzl+Dx1PGq5i+Pk3J+lM94ZL1vKSJREtobKJtUFC9Zgyceyiu/iIkrUFRubdgwP8KTERK8DQCieiY2xWIWdpGcPYN7qtdMHofX7mESM+xDcGzgJu3HOJGrQlN9kjByQ1KQh5PwdBF3i7NNGaOa4nKPxOjj48qimrWikS9SHz5LgqFxT6HW7oipTArE1kPz9HPgAq5RaOGpI410S+HdV7RMCPUkYJCednh5zcvWHOjR5Ucitg2K53TUbVBX14Q+HmNUyI91mlL+W9aLHKoS45W6cnkY7/N5/pWZL03eOa42f7dUzzcx1WczC0y4lzzWTKWft7fLKmjVARPKFi96VdT+pdXME7gf5YCpAgn9/BSDp9Dl+Fsq2WXtBL5AzBckH3ZI+8AOVX
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8617.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441858c2-09fe-415d-ec2a-08de38f4cef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 20:35:22.8204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipSJxs6wK2xmp5eqCEa/FZusOndxZSATG1Gg5QTTZYCVxvpGy8BJuL5SOprL1e1rQGLWbRZtIJbNW0U1Ol5l2XQMt1ByLQjxIdCQsL2zwVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR02MB10755
X-Proofpoint-GUID: rSWrU2gmHHbMjYggBlR5zrCQklhBwHrt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDE2NSBTYWx0ZWRfXyICSIE9nVb1q
 654gy3fTzyGRiKAf6zh+NR4uMdQsvblXglHnBX09rE/mV1a9O+04YAW3n2UNGr13GFUXhDwIvXP
 PTp0DeU6thzSuRZstka/wyr6v5RU74UlLczQIJET6uuGmXW3+VRLwL4tRULglA0of3AVbSDSp9A
 Q4fIR0sLAKgHaEMZpaw/0YXXWO0JH8trliGfYI1bbAQpeTOZPM59x22R1+lmFxGpi0asIj7ibJQ
 F5pcGgz+IY2XuDAyY/hyeDJ8epUY/m7FGDovE6SMgZhYVXB7Pxm8/ccIc6QCOm33Ky6qeEDeELh
 Wh5im9fORTqTEcO7NJ4gSCFUJEN/wLTOJq3C0MyEW0YTq8YSf5jQtpxvxKNZmP/C5RctG1vgA9T
 Gq9ujXU+/jEDqrxRovO+Tq9a9vYi7A==
X-Authority-Analysis: v=2.4 cv=FYU6BZ+6 c=1 sm=1 tr=0 ts=693b2b0e cx=c_pps
 a=CI+6eH69xnfBVKYFOOy2Nw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=0RXyzBBhxCVfQeTndLQA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: rSWrU2gmHHbMjYggBlR5zrCQklhBwHrt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-11_03,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512110165
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SSBhbHNvIHRoaW5rIEkgYmVnaW4gdG8gc2VlIHNvbWUgbGlnaHQgdG9vIC0gSSBuZWVkIHRvIGRp
ZyBtb3JlIHRvIHVuZGVyc3RhbmQsIGJ1dCB5b3Ugb3BlbmVkIG15IGV5ZeKAmXMgdG8gc29tZXRo
aW5nIEkgZGlkbuKAmXQgY2hlY2sgZm9yIC0gdGhlIG1lbW9yeSBsaXN0ZW5lcnMuIEFuZCB0aGF0
IGNvdWxkIGV4cGxhaW4gd2h5IHdl4oCZcmUgZmFpbGluZyAtIHRoZXJlIGlzIGFuIGltcG9ydGFu
dCBkZXRhaWwgSSBkaWRu4oCZdCBtZW50aW9uIChJIGRpZG7igJl0IHRoaW5rIGl0IHdhcyBpbXBv
cnRhbnQgOy0pICkgLSBhcyBhIHJlc3VsdCBvZiB0aGUgSU9UTEIgdHJhbnNsYXRpb24sIGluIHRo
YXQgdHJhbnNsYXRpb24gY2FsbGJhY2ssIHdlIGFyZSBhZGRpbmcgbWVtb3J5IHJlZ2lvbnMuIEkg
c3VzcGVjdCB0aGUgcmVzdWx0IGlzIGEgc29tZXdoYXQg4oCZc3RhbGXigJkgYWRkcmVzcyBtYXAg
LSBhcyB5b3Ugc2F5IOKAnGZsdXNoIG1pZ2h0IGhlbHDigJ3igKYuIEkgbmVlZCB0byBjaGVjayBv
biB0aGF0Lg0KDQpBbnl3YXkgLSBUSEFOS1MgIQ0KDQooRldJVywgaWYgSSBjYW4gaGVscCBhdCBh
bGwgd2l0aCB0aGUgcmUtZmFjdG9yaW5nIG9mIHRoZSBtZW1vcnkgc3lzdGVtLCBJ4oCZZCBsb3Zl
IHRvLiBXaGlsZSBJIHRoaW5rIHRoZSB3YXkgU3lzdGVtQyBkb2VzIGl0IGlzIGJhZCwgSSB0aGlu
ayBzdGFuZGluZyBiYWNrIGFuZCByZWNvZ25pc2luZyB0aGUgbGVzc29ucyB3ZSd2ZSBsZWFybmVk
IGZyb20gUUVNVSwgU3lzdGVtQyBhbmQgaW5kZWVkIG90aGVyIHN5c3RlbXMgY291bGQgaGVscCBn
dWlkZSB1cyB0byBhIG1vcmUgdXRvcGlhbiBzZXR1cCAtIHBlcmhhcHMgLSBPbiBteSBzaWRlLCBt
eSBpbnRlbnRpb24gaXMgdG8gbG9vayBhdCB0aGUgbWVtb3J5IGludGVyZmFjZSBpbiBhIGxhbmd1
YWdlIGFuZCBzaW11bGF0b3IgYWdub3N0aWMgZmFzaGlvbiBhbmQgdHJ5IGFuZCBjb21lIHVwIHdp
dGggYW4gaW50ZXJmYWNlIHRoYXQgY291bGQgYmUgdXNlZCBhY3Jvc3Mgc2ltdWxhdG9ycyBhbmQg
bGFuZ3VhZ2VzIChlLmcuIFJ1c3QpLiBUaGlzIGlzIG5vIGxvbmdlciBxdWl0ZSDigJxwaWUgaW4g
dGhlIHNreeKAnSwgdGhlcmUgaXMgbm93IGEgcHJvcG9zYWwgKHdoaWNoIG5lZWRzIG1vcmUgd29y
ayksIGJ1dCB3ZeKAmXJlIG1ha2luZyBzdGVwcyBmb3J3YXJkLiBCdXQgdGhpcyBpc27igJl0IHJl
YWxseSByZWxldmFudCB0byBRRU1VICh5ZXQpKS4NCg0KQ2hlZXJzDQpNYXJrLg0KDQoNCj4gT24g
MTEgRGVjIDIwMjUsIGF0IDIxOjE0LCBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJz
b25AbGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0
ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZiBhbnkgbGlua3Mg
b3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IE9uIDEyLzEx
LzI1IDEzOjQ5LCBNYXJrIEJ1cnRvbiB3cm90ZToNCj4+IEkgYW0gYWJzb2x1dGVseSBwcmVwYXJl
ZCB0byBiZWxpZXZlIEnigJltIGhhbmRsaW5nIHRoZSBJT01NVSBpbmNvcnJlY3RseQ0KPj4gDQo+
PiBUaGUgc2V0dXAgSeKAmW0gdXNpbmcgaXMgQ1BVLT5TTU1VKFRCVSktPkFkZHJlc3NTcGFjZSAo
dG90YWxseSB1bmNvbm5lY3RlZCBmcm9tIHRoZSBDUFUpLg0KPj4gDQo+PiBXaGF0IEkgc2VlIGlu
IHRoZSBjb2RlIGlzIHRoYXQgdGhlIElPTU1VIGlzIHBlcm1pdHRlZCB0byByZXR1cm4gYW4gYWRk
cmVzcyBzcGFjZSAtIHRoYXQgYWRkcmVzcyBzcGFjZSwgaW4gdGhlIGNhc2VzIEkgaGF2ZSwgaXMg
dG90YWxseSB1bnJlbGF0ZWQgdG8gdGhlIENQVSBjb25jZXJuZWQuIFRoZSBDUFUga25vd3MgKHRp
bGwgbm93KSwgbm90aGluZyBhYm91dCB0aGF0IGFkZHJlc3Mgc3BhY2UuIFRoZSBhZGRyZXNzIHNw
YWNlIGJlaW5nIHJldHVybmVkIGZyb20gdGhlIElPTU1VIHRyYW5zbGF0ZSBkb2VzbuKAmXQgc2Vl
bSB0byBiZSB1c2VkIC0gc28gSeKAmW0gbm90IG92ZXJseSBzdXJwcmlzZWQgdGhhdCB3ZSBlbmQg
dXAgaW4gdGhlIHdyb25nIHBsYWNlLiBQZXJoYXBzIHdoYXQgeW914oCZcmUgc2F5aW5nIGlzIHRo
YXQgc29tZWhvdyB3ZSBzaG91bGQgYmUg4oCYcmVnaXN0ZXJpbmfigJkgdGhpcyBhZGRyZXNzIHNw
YWNlIHdpdGggKGFueT8pIENQVSB0aGF0IGNvdWxkIHBvdGVudGlhbGx5IGdldCB0byBpdC4uLg0K
Pj4gDQo+PiBXaGF0IEkgc2VlIGlzIHRoYXQgaW9fcHJlcGFyZSBjYWxscyBkb3duIGFuZCBnZXRz
IHRoZSB0YXJnZXRfYXMgZnJvbSB0aGUgSU9NTVUgdHJhbnNsYXRlIGNiLCBidXQgaXQgb25seSBy
ZXR1cm5zIE1lbXJveVJlZ2lvblNlY3Rpb24sIG5vdCB0aGUgdGFyZ2V0X2FzLCBhbmQgdGhlbiBl
LmcuIGludF9zdF9tbWlvX2xlTiBzZWVtcyB0byB1c2UgY3B1LT5hcyBhbmQgaW5kZXjigJlzIGZy
b20gdGhhdCDigKYuLiAgSSBkb27igJl0IHNlZSB3aGF0IEkgY2FuIGJlIG1pc3Npbmc/DQo+IA0K
PiBZb3UncmUgcmlnaHQgdGhhdCB0aGVyZSdzIGEgZGlzY29ubmVjdC4NCj4gDQo+IFRoZXJlJ3Mg
YW4gaW5pdGlhbCB0cmFuc2xhdGlvbiBpbiBhZGRyZXNzX3NwYWNlX3RyYW5zbGF0ZV9mb3JfaW90
bGIoKSB3aGljaCByZWNvcmRzIGENCj4gTWVtb3J5UmVnaW9uU2VjdGlvbi4gIExhdGVyLCBkdXJp
bmcgZXhlY3V0aW9uLCBpb3RsYl90b19zZWN0aW9uIHN0YXJ0cyBvdmVyIGZyb20gdGhlIGNwdQ0K
PiBhZGRyZXNzIHNwYWNlIGFuZCB0cmllcyB0byBmaW5kIHRoZSBzYW1lIE1lbW9yeVJlZ2lvblNl
Y3Rpb24sIGJ1dCB0cmFuc2xhdGlvbiBpcyBub3QgaW52b2x2ZWQuDQo+IA0KPiBJIHN1c3BlY3Qg
d2UgbmVlZCB0byByZXZpc2l0IENQVVRMQkVudHJ5RnVsbC54bGF0X3NlY3Rpb24sICJpbmRleGlu
ZyIgb2YNCj4gTWVtb3J5UmVnaW9uU2VjdGlvbiwgZXRjLg0KPiANCj4gSSd2ZSBoYWQgaW4gdGhl
IGJhY2sgb2YgbXkgbWluZCBhIHJlb3JnIG9mIHRoZSBlbnRpcmUgcGh5c2ljYWwgbWVtb3J5IHN1
YnN5c3RlbSwgd2l0aCBhbg0KPiBleWUgdG93YXJkIGVsaW1pbmF0aW5nIFRBUkdFVF9QQUdFX1NJ
WkUgZW50aXJlbHkuICBUaGUgaW5kZXhpbmcgbm9uc2Vuc2Ugd291bGQgbXVzdCBuZWVkcw0KPiBj
aGFuZ2UgaW4gdGhhdCBzY2VuYXJpby4gIEFsbCB2ZXJ5IGhhbmQgd2F2ZXkgYXQgdGhpcyBwb2lu
dC4uLg0KPiANCj4gDQo+IHJ+DQoNCg==

