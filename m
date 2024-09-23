Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E23CF9C71
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 17:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssmx6-0001jp-2U; Mon, 23 Sep 2024 13:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@de.ibm.com>)
 id 1ssm1b-0007Bd-Q4; Mon, 23 Sep 2024 12:35:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@de.ibm.com>)
 id 1ssm1Y-0001xz-3L; Mon, 23 Sep 2024 12:34:58 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N97TTa004499;
 Mon, 23 Sep 2024 16:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:subject:date:message-id:references:in-reply-to:content-type
 :content-id:content-transfer-encoding:mime-version; s=pp1; bh=i1
 InaiFJbI26D2j4bVMIPguYaKotbpeMhCkoBqCduSE=; b=tB7f9mXiRBOMBIxAuD
 aqit4UZlIJH3Voe63OCTt/Trnac8p4ph9TH+r2z/YwMRje9dl9rG3THH1xkEw5TX
 2TJtVojZKDoqZlNjti03krxXismglaapK/JAxuXsqJaeY/BG+Xzt9GYwJJ5orI4a
 +2ab+hPY1rxiKPJzHdN06mBd343pvyjf8HbC9XI5iivY9eCvEAzdV7EnqhFbDLUF
 R0ZBxzxtCI/7KNgntT0gkx2KTRMhQguYbxmxX6KTRbzr0+hx2I6Ww8o/IGEB5hMn
 bfO+vBRvtVJKrMRKvdMzxLx5eAxFOvktBB1KbIAxhrH754Eaz4nEW8IiuQUqUL+P
 e8Tg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snna5ark-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:34:23 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48NGVSnp031727;
 Mon, 23 Sep 2024 16:34:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snna5arf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Sep 2024 16:34:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qf/Ov4yAeyuRQ/CeZ757p+8KJS6RfZrvcepPqvR+M2nJGcCDgDoG7NgpLsWzp0Ps6PMMRY79P7+LRGAdpJoTXWO6ZV608TxvaZq64iZzJB57Gyl6RnlZRGv+d6VIOY+Bqger2NFldI+ElIdZfXXDaGsXJEWg8uMzrYZIj5fC1dQwBCLBakht+fKc0lAZ2unjHqKQCDJSlQxRMFSXb5jVLbwtGPSGAzRuBq3GSCoHTDJ3tyXljW6ebL0MOB6zX2a/JHCibVzBhCV9xh8ZsE3Puvyfq7tHMUqtfvi/sebIy9feZAXM9pjsaGChSneQaHH2A7ndd+hJhlqQG82W9GUzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1InaiFJbI26D2j4bVMIPguYaKotbpeMhCkoBqCduSE=;
 b=CLMKQBIZtKHzBEPYUffz9F0q+IuzQLn8K0XRJsQOtICHOg5Lt4BNTuDqgYqo4qkeESh9wSmrsVoLH7FrUpNKFE+iQuMrSG50KEh6Ju8IDqKEMS563Plzz83qGdJGEH0ctmq+Mpg09QfhD6ZBhB72uyGcDpMk1y0xKnYPk+hPDnoxPL3yT0910ivkAANNSMaLz0tuO3dLoBokbhjwlwHfyh1QMrRc0uGDhDo3HYTl7x0P3ycrRB2JnBkN847tGTFxkf5wTjZAVCQ8PT31Z0lly5vpMqoeRcZKitYdr2CS/SMrWu+/7HTkxEylALHsV2mRKMQAKRCenoRrwvce/CGYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.ibm.com; dmarc=pass action=none header.from=de.ibm.com;
 dkim=pass header.d=de.ibm.com; arc=none
Received: from CH3PR15MB6428.namprd15.prod.outlook.com (2603:10b6:610:1af::15)
 by SA1PR15MB6472.namprd15.prod.outlook.com (2603:10b6:806:3b5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 16:34:20 +0000
Received: from CH3PR15MB6428.namprd15.prod.outlook.com
 ([fe80::7377:e053:ff57:1da7]) by CH3PR15MB6428.namprd15.prod.outlook.com
 ([fe80::7377:e053:ff57:1da7%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 16:34:20 +0000
From: Ilya Leoshkevich <iii@de.ibm.com>
To: "gdb@sourceware.org" <gdb@sourceware.org>, "qemu-discuss@nongnu.org"
 <qemu-discuss@nongnu.org>,
 "rj2814288312@gmail.com" <rj2814288312@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Using ubuntu24.4 system qemu-system-aarch64 +gdb-multiarch to
 debug the kernel, setting breakpoints cannot be stopped
Thread-Topic: Using ubuntu24.4 system qemu-system-aarch64 +gdb-multiarch to
 debug the kernel, setting breakpoints cannot be stopped
Thread-Index: AQHbDdZwghVFlXLYMkGnoBEUE5V9uQ==
Date: Mon, 23 Sep 2024 16:34:20 +0000
Message-ID: <c4ee581b0fcff6006ba8613ebc69bd35933bc40a.camel@de.ibm.com>
References: <CAAsTPeaOec5UcWJOApsHxzs+-ZYotHLhiPhaWBXT9bw=Z9zjkg@mail.gmail.com>
In-Reply-To: <CAAsTPeaOec5UcWJOApsHxzs+-ZYotHLhiPhaWBXT9bw=Z9zjkg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR15MB6428:EE_|SA1PR15MB6472:EE_
x-ms-office365-filtering-correlation-id: 232ca884-cc51-4f0b-53b1-08dcdbed931b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NlFsYlk0NEo5WVBmdFp2UEJVcndGQVFJbVdSVWordXZYY3ZsMnNOTEs5dUJZ?=
 =?utf-8?B?dzFaNDNObXU3L2tJOERSaWJ2eHJnUU93dHQ1aTR5T0ppOXM0M3ZjTW1ZUXB0?=
 =?utf-8?B?cWtLd0hJVUpZcXBESEFSRnExd2Z3TU41c3cwVVpHN0NJTkNsQk10SEFXNlpY?=
 =?utf-8?B?UEkwaFA1bllUeWN3Wkl4Ri8wYVNmYlBUNldETnpHQ0xQeExONTFhc1VjbG94?=
 =?utf-8?B?TllPQkFSTnVWL2s1Mjd2VnpLTysrWDVYaVhxVmpURExydG9wdkhEUlNhMWFU?=
 =?utf-8?B?eDFKUitSLzJZc2U2YnYzSlY2K1dDT29DK1pUcDFzTllQYm9kNCszZzFGb1Nl?=
 =?utf-8?B?Tno1UVdXRmRNUk15ZUJJNk1nOElTUFVualdhdmNITm1JWTFFOGdHWVBzNWor?=
 =?utf-8?B?dzZHa1lNTE9NWWlRTVRXTEZualFXeisvQ2FiZnpOQVp5elZ2ZVhRQm9waDR6?=
 =?utf-8?B?c05xMCthcENaT0hPRUc0VzhTV0NyL1BzdDU2SHg1NjlxZGRQRHlad1pzQm1G?=
 =?utf-8?B?WGNUNmFBVDdETnRDVFl1SWMzdXlNemRKNmJOcUFUMXJCZGY2eENQem1xazRt?=
 =?utf-8?B?bHpzbG5IdmgwZm0xMFNKRXJnTnU3d0hZc2ZsRnI1UytURE1kVkNBSEhyZDBT?=
 =?utf-8?B?eVpXUW9pdkkzYmJYTzVhNzdOY09VOEpxSlAwUEU1UUp6QTZmYmVDK3lwN2Va?=
 =?utf-8?B?ZVdIb0t4YUd6OHZBMjR6L2k5aGh5Qmd0cU4xVVVUQlZDa1p6WDFWSmJndGMx?=
 =?utf-8?B?R2RJYUd2WmwrOEI0RVFJS3BTNTJJTU8wVHhYem0wYk1HbzBsNGRiSk10cXZC?=
 =?utf-8?B?SlhkNlE4cGFqMk1ITEVIU3lXMjVmb2dDOUhOM1B6U0pXUnJnY1Z1RzdWYWRE?=
 =?utf-8?B?Q24vaTJ4ZUNaeDc0ZWRZQVAzbnl5cE5Qa05rckJKUm44R29oMkJ3amxmOUsy?=
 =?utf-8?B?RHRKR0g4Z2N2UHFub1ZBWjBnb2xoQnk1Qm40YVo1SGYzUUlkd0trT21VNWdr?=
 =?utf-8?B?bXhRL1c1bFh4WkdEVE9HdmpQRytraGl1NkFTRFZKdjhXZVJBdFVDT2RCQjFU?=
 =?utf-8?B?eXNqYmtMOUNwZVVCNWtrWUc3bCtIOU5IU1IrbkczcXV4bjdIQ3l3S2w3bUtM?=
 =?utf-8?B?SzVYak10WTRPaW5hc2JUdld6RVhrR21LZ29hWGFLM2lvc3lGeVdJdU5FR1Mw?=
 =?utf-8?B?WXZJZWlma1l5Qjl5SFE3ZlUrNE5QcnkrU0l3VVBPUXlZWEFRWWtTaUJONW1U?=
 =?utf-8?B?MjRwdElrcVh4MGNtWDN1Qk1OOVZYenlZZFZLRkdtTmtjRGFzdTNNSmNrQkN3?=
 =?utf-8?B?YTM1VVdQTm1YK2IrZTRaTUlnZTZzZmxkS0xTcW9ZRzA3YkVzbm1kQ0c4a3ZZ?=
 =?utf-8?B?S0hIdHZTNEtUOXJ2NnB3aFBtUXgxNmNMQWRqNVp3dTJxMmpNWHBSNDQ3OGlO?=
 =?utf-8?B?ZmI4Ym5Qam5ndWg2YkU3NThyaXpUVEluM0lmcFhEU09WSTNPb1NRNkFQNU8z?=
 =?utf-8?B?cE5CZG1ZU3NVOXdaQW9KTktXYjc5M2xiRGNZMmhxR0V1N2dpQkxwa3RuUDZ1?=
 =?utf-8?B?U2tjRWEwTS9WU1VMWXYrMzFnRFNkNThsbWU4d1J1UzJoYjJQUmEwdFAzYnk2?=
 =?utf-8?B?QzRHdFFtU29FVTREdTBzcEtyOFZnTjA2b2xLYm11cDdQWFAybDdLeml6RG1U?=
 =?utf-8?B?NHpRbXM3V1ZlZXNUd2NpTEY2ejR3WG1WSlRuTXgxYUxOekRLT3l6SFlzTC81?=
 =?utf-8?B?Ry9zOXYvZFZiYjN1bVFUMUh3QjJPU29ZQTlYa1ZBaldzUXF2RlNrUmp6VmNR?=
 =?utf-8?B?OVAycHBSNmlFblhiNy9nZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR15MB6428.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTZrUjZCTVZldWJmZlo1b01FM3YyZzFIMlNRRWhGNzlOOFp5Qnova3RCZUxp?=
 =?utf-8?B?a3RELzU0aEh2TURQREgrZ284azNoL01FMmNhNjk5U2NLL05pNHdIMTArVnZt?=
 =?utf-8?B?N1gyKzFSam15elEwcVZTTk01OHFibEQzY1VXOVYrQUIzWHRBajNSVSt3c0Vj?=
 =?utf-8?B?bE5GZUswVXJOaHNkMTM4TUJxMTliZnZsNVJwc0duZVpYaWdoTC9USjk2RkJN?=
 =?utf-8?B?WmRZYW9MV2I4WXZKVy9FTDZSKzBwdlZiZGJIdU04OG1tVHRjTDF1V0JML0pV?=
 =?utf-8?B?Nll0RFlrdGYzZE5WdDM4TG41Y1pWN2hxU0dGZTUrcXhDaU4wZkRmaHE5UzJu?=
 =?utf-8?B?NWMxc2dMTUhVVStLY1hBTndqcE1hdlBoTVA4Wno2QXVycU1NbGJlZ1NuTXlB?=
 =?utf-8?B?dnpLdXB2L0tHaStMd3VlMzFwWG9aZHVKV1BZckYveUVTaTV1bVRLNXdlclF4?=
 =?utf-8?B?TnR0d1VRR2xHa1N0QlFzTDZ3LzdoMm1vb2J0NEpzcEpTb0x0VzRsL1FjL3dt?=
 =?utf-8?B?ZzlXTEpyd3Azb1RqSW4waks1Y2t6VnB4VS9aYjZvS2c3d1Fia0pBaWNBOUpM?=
 =?utf-8?B?dW4xbnQ4MXRTMlU5aWVqMGJnVFhRVGMydlIvbEZqajUyc1dnT3ZsYjFJZzFm?=
 =?utf-8?B?QWRHZWxWYVhVL3MwcTlHL2NxcmdLUnVtTHdXak92ejRRU3BISWEzMXZESDlw?=
 =?utf-8?B?MHRvL25vWm9iOENBd21RRVMwN0pSWlpHeXJ5bWF1NnNyQXYyMFhwQ0cxdzFY?=
 =?utf-8?B?eWtZcW9vN1dhQitkSGRPTkdSRjgwaS84Q0NrdHl0VEk3T1NZYkQyN0ZsRXZl?=
 =?utf-8?B?ZXVrRUpZS1JkTUtTcko1eEhmakllMHhGeDR0YWxQUkQxV0Y3dFhCSW03VGw5?=
 =?utf-8?B?VVNWbllmS3BPZE11Z1pPemR3ak85em5XQXRpcnowcXlNSmVtM1hjb29ncita?=
 =?utf-8?B?aFpEbGljanpGNVRxaWt2NzErdktIeW5td3BVbW4zM2VxNFlrVTZUVHhmbEZy?=
 =?utf-8?B?KzF1c01WZi91Z3V1NW9iVS9CVlB5RURrSTloeWhYNE1UZmRqU01KdWJIdFYz?=
 =?utf-8?B?ekNhYzg3ais1cXVVZW5NSmN0WkJrQXNXbnZ2QXlEY0xRT010dG4ra2orM1c2?=
 =?utf-8?B?bGFVK1o4UXIrSy9sVmZZRlJSMXEvRVlvdnBJY0ZHb2pVMEtGaWN6QWFDWmw3?=
 =?utf-8?B?akwxRnM4VHZRdWlqc3JrVHE5eUpkRFJPRlZSSGlMbTJTdVVYeDl3YXhvNGIy?=
 =?utf-8?B?SWN2MlFsUE1Vanl4SWtOWUxXcEhxY09RaUU2c1NKVndCN0d6RmpaVUdVR05G?=
 =?utf-8?B?UkVOdkZsTm5YOHoyLzA1S1ZIR0xMQk1oVzBPenFKYUxYdXBIVC85WGw2QllY?=
 =?utf-8?B?K3dqRXNZNlExdzlrOGd0dmhoUFd4T21QbHpLcWcxU2c2M3VUQXBZb1FQNGxo?=
 =?utf-8?B?YWlBbHdSaWxMYjRtd2JuZHRlQ2xLdmZrRWtCVmp3SlJBQVpyZXZxeGxuR3p5?=
 =?utf-8?B?TTM3UnNnRWVmRWFTUUgySnVIQWFDM05oSWdsenNXclRkYTZ4VWRaZGpBVnlZ?=
 =?utf-8?B?ejN3R2xTUVE4Qzg1bXVBSVdkMEZ6WEpTWUNvaklxdzVVeFNxVWtybHV3elg2?=
 =?utf-8?B?NHNEOVFsUkRDVEUyUDc3VzFHZmU3RDNuK2t3UWh1N2xCSDJNSzhwdE1yM0gr?=
 =?utf-8?B?VytzNW1XaEljV1JTUE5zZTMxZzJiWnh0YzJnVC9VSnhuUHZOZERkQ0hrVW8z?=
 =?utf-8?B?dVRaZVQrbHJHWnRCcHFQWCtYdFN2M01qaEhSbWp1dmpYejdnaGRGWGd4ZWhr?=
 =?utf-8?B?RGgyQk52VG1Pb1Q1VU4wNnFJaGJQY0RaazhlRjdEejNrQTBRa0IzQ0hhNWRo?=
 =?utf-8?B?TTZUVGhtTmp3TXJUYmg0NnNlZkdienR5Z0thdTJCa0ZCMU5KWTE3STZ3c3dm?=
 =?utf-8?B?aDVUdjJtanpHU0Urc2psaFhQMElOeTBTOXdwcVk0NERkd2dwNVQ4UTFIU1Zz?=
 =?utf-8?B?MnRaWFQyWUxWc2tOVkNrT0V3OTBtWFA2K20zN2VLV2hVbXlnZkppRytMaWJr?=
 =?utf-8?B?N3ZoTTRyNTg0a1RyQ0R3ZGU3cHY1Z2t0ZVJHbFpsQ0x6cFM1L1cyNjRUODRs?=
 =?utf-8?Q?I3Zc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8578705EE0FA524394136C158237AB75@namprd15.prod.outlook.com>
X-OriginatorOrg: de.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR15MB6428.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232ca884-cc51-4f0b-53b1-08dcdbed931b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 16:34:20.0962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuO0Fj0SsxBNaIc0JDVSVUPS6zqX4FFpM+fQRpJHt6MtjHegsWCk/fOIhEhctMyJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB6472
X-Proofpoint-GUID: 6CKpX7ync1C4dD74vUKSqAp8splcuYON
X-Proofpoint-ORIG-GUID: fRzM0gLNuuS3AbrDSnHwvv_RWmBhs9TL
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_12,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=944 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409230122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@de.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Sep 2024 13:34:22 -0400
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

T24gTW9uLCAyMDI0LTA5LTIzIGF0IDIyOjM2ICswODAwLCBqaWUgcmVuIHdyb3RlOg0KPiBIaSwg
SSBoYXZlIGEgcXVlc3Rpb24gZm9yIGhlbHANCj4gwqDCoMKgIEkgcmVjZW50bHnCoCBVc2luZyB1
YnVudHUyNC40IHN5c3RlbSBxZW11LXN5c3RlbS1hYXJjaDY0ICtnZGItDQo+IG11bHRpYXJjaCB0
byBkZWJ1ZyB0aGUga2VybmVsLCBzZXR0aW5nIGJyZWFrcG9pbnRzIGNhbm5vdCBiZSBzdG9wcGVk
Lg0KPiDCoMKgIHN5c3RlbSBpbmZvcm1hdGlvbjoNCj4gwqDCoMKgIMKgwqDCoCB1YnVudHUgdmVy
c2lvbjogMjIuMDQNCj4gwqDCoMKgwqDCoMKgwqAgRGVidWcga2VybmVsIHZlcnNpb246wqAgNS4w
LjANCj4gwqDCoMKgwqDCoMKgwqAgcWVtdSB2ZXJzaW9uOsKgIA0KPiDCt8KgcWVtdS1zeXN0ZW0t
YWFyY2g2NCAtLXZlcnNpb24NCj4gwrfCoFFFTVUgZW11bGF0b3IgdmVyc2lvbiA4LjIuMiAoRGVi
aWFuIDE6OC4yLjIrZHMtMHVidW50dTEuMikNCj4gwrfCoENvcHlyaWdodCAoYykgMjAwMy0yMDIz
IEZhYnJpY2UgQmVsbGFyZCBhbmQgdGhlIFFFTVUgUHJvamVjdA0KPiBkZXZlbG9wZXJzDQo+IMKg
DQo+IA0KPiDCoA0KPiBnZGIgdmVyc2lvbjoNCj4gwrfCoGdkYi1tdWx0aWFyY2ggLS12ZXJzaW9u
DQo+IMK3wqBHTlUgZ2RiIChVYnVudHUgMTUuMC41MC4yMDI0MDQwMy0wdWJ1bnR1MSkgMTUuMC41
MC4yMDI0MDQwMy1naXQNCj4gwrfCoENvcHlyaWdodCAoQykgMjAyNCBGcmVlIFNvZnR3YXJlIEZv
dW5kYXRpb24sIEluYy4NCj4gwrfCoExpY2Vuc2UgR1BMdjMrOiBHTlUgR1BMIHZlcnNpb24gMyBv
ciBsYXRlcg0KPiA8aHR0cDovL2dudS5vcmcvbGljZW5zZXMvZ3BsLmh0bWw+DQo+IMK3wqBUaGlz
IGlzIGZyZWUgc29mdHdhcmU6IHlvdSBhcmUgZnJlZSB0byBjaGFuZ2UgYW5kIHJlZGlzdHJpYnV0
ZSBpdC4NCj4gwrfCoFRoZXJlIGlzIE5PIFdBUlJBTlRZLCB0byB0aGUgZXh0ZW50IHBlcm1pdHRl
ZCBieSBsYXcuDQo+IA0KPiBTdGVwcyB0byByZXByb2R1Y2U6DQo+IMKgIMKgIDEuIEJvb3QgdGhl
IHN5c3RlbSB1c2luZyBxZW11OsKgwqAgDQo+IDEuwqBxZW11LXN5c3RlbS1hYXJjaDY0IC1tYWNo
aW5lIHZpcnQgLWNwdSBjb3J0ZXgtYTU3IC1tYWNoaW5lDQo+IHR5cGU9dmlydCAtbSAxMDI0IC1z
bXAgNCAta2VybmVsIGFyY2gvYXJtNjQvYm9vdC9JbWFnZSAtLWFwcGVuZA0KPiAibm9pbml0cmQg
cm9vdD0vZGV2L3ZkYSBydyBjb25zb2xlPXR0eUFNQTAgbG9nbGV2ZWw9OCIgLW5vZ3JhcGhpYyAt
DQo+IGRyaXZlIGlmPW5vbmUsZmlsZT1yb290ZnNfZXh0NC5pbWcsaWQ9aGQwIC1kZXZpY2Ugdmly
dGlvLWJsay0NCj4gZGV2aWNlLGRyaXZlPWhkMCAtLWZzZGV2DQo+IGxvY2FsLGlkPWttb2RfZGV2
LHBhdGg9JFBXRC9rbW9kdWxlcyxzZWN1cml0eV9tb2RlbD1ub25lIC1kZXZpY2UNCj4gdmlydGlv
LTlwLWRldmljZSxmc2Rldj1rbW9kX2Rldixtb3VudF90YWc9a21vZF9tb3VudCAtUyAtcw0KPiDC
oA0KPiANCj4gVXNlIGdkYi1tdWx0aWFyY2ggdG8gY29ubmVjdCBhbmQgZGVidWc6DQo+IA0KPiDC
oA0KPiBnZGItbXVsdGlhcmNoIHZtbGludXgNCj4gKGdkYikgdGFyZ2V0IHJlbW90ZSBsb2NhbGhv
c3Q6MTIzNA0KPiBSZW1vdGUgZGVidWdnaW5nIHVzaW5nIGxvY2FsaG9zdDoxMjM0DQo+IDB4MDAw
MDAwMDA0MDAwMDAwMCBpbiA/PyAoKQ0KPiAoZ2RiKSBiIHN0YXJ0X2tlcm5lbA0KPiBCcmVha3Bv
aW50IDEgYXQgMHhmZmZmMjAwMDEyNjcwNGVjOiBmaWxlIGluaXQvbWFpbi5jLCBsaW5lIDUzOC4N
Cj4gKGdkYikgYw0KPiBDb250aW51aW5nLg0KDQpJIHdvdWxkIHRyeSB1c2luZyB0aGUgIm5va2Fz
bHIiIGtlcm5lbCBvcHRpb246DQoNCiQgcWVtdS1zeXN0ZW0tYWFyY2g2NCAta2VybmVsIC4vSW1h
Z2UuY3VzdG9tIC1NIHZpcnQgLWNwdSBjb3J0ZXgtYTU3IC0NCmFwcGVuZCAiY29uc29sZT10dHlB
TUEwIG5va2FzbHIiIC1zIC1TIC1ub2dyYXBoaWMNCg0KJCBnZGItbXVsdGlhcmNoIC1leCAndGFy
Z2V0IHJlbW90ZSA6MTIzNCcgdm1saW51eA0KDQpSZW1vdGUgZGVidWdnaW5nIHVzaW5nIDoxMjM0
DQoweDAwMDAwMDAwNDAwMDAwMDAgaW4gPz8gKCkNCihnZGIpIGIgc3RhcnRfa2VybmVsDQpCcmVh
a3BvaW50IDEgYXQgMHhmZmZmODAwMDgxMWUwOTY4OiBmaWxlIGluaXQvbWFpbi5jLCBsaW5lIDkw
NS4NCihnZGIpIGMNCkNvbnRpbnVpbmcuDQoNCkJyZWFrcG9pbnQgMSwgc3RhcnRfa2VybmVsICgp
IGF0IGluaXQvbWFpbi5jOjkwNQ0KOTA1ICAgICAgICAgICAgIGNoYXIgKmNvbW1hbmRfbGluZTsN
Cg0K

