Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8521C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 21:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvkEP-0002E7-2l; Fri, 21 Mar 2025 17:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tvkEM-0002CX-M0
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 17:48:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tvkEK-0001Bi-PE
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 17:48:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATL2n001207;
 Fri, 21 Mar 2025 21:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IAvLC8TOZgC5Brph2A1lES5QT0WiW3+zZEKu8zSugh4=; b=Ue+5e73zFYLctHjW
 kjYQP/GRlZzk178GBTHdumKO3REXh9gfEnV7G3O23L7Vu2DsGSVjBdFlb+64XBNy
 wV4Xb3OAbrrz7XooKOobKP2o3QcRj/hg+8Sc+BxMBmrBZUlGpjwqdRL7DuVu9meL
 PNMqIJ8BL7ij1BeANE5bvxjjcW30qhIgm8M26OWs91qvtXEfYy2DxwxEykkJKZYk
 H2/RYiN80z6pIn3RIqYusWsJlgFPexQsxmaIcDrruX4a5SMkenS52d8YHZa3vyz7
 8yTHJ2ATjxSX//MzKNR3BZmF8ayKVQ2RGK95xuZ1D95lE8m75F6Xt0Jl7rNrYSyJ
 fh+Hzw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45h4u9swc6-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Mar 2025 21:48:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RArFC/WDpn44vUc233TxJxx29MMhwH2tpq7IOoqT6t5bD5+C/tCCUp4zjeYufuWagDZ6xKAfyoyYlkhSaDcZGLX3NnZMXEckTyAL7NW0ZvdOhUEy+vlqW8utYt9ntQn40+qTi5DiUWW5nwGHaweI3jLp3eKIIktss8cLUlU0rgg94O5rQvGM6C9EenSr4uaXTYtObz6CdHrvaM/aUZ1w0v3RES1R5cYH+FgTYgIfQw8aPb4LisLlJXw1DTW22AxajtLtaZurKcZ46b4Iuofpn5TrNYkyy7JkkA97N9htCWCZNVMVzkSDUdr3hRUNVzZVTFwW1zeUN6MQm3MuRQ0DIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAvLC8TOZgC5Brph2A1lES5QT0WiW3+zZEKu8zSugh4=;
 b=rDiGPK6iiRVCFRLcPlcIvKP1xENGmoCRon8uCF6C5kgAuQN/SUxqkHwkAYJGK20CykhubUWE1VTDPZaFXKfUO/As5gUzeuDyncgO6oQtOoiMDvKnMZN4/Bi1S0oftfm2yJmlzGzBZ0Xxv1f98edaI8mOn/P/bfrgU7t3EWOJuy5VXvo+QKkiFVyg6gEUEXB7/HW2aVn5Y6kcME+Y/u9RAlvxJj2r39CCSBW5nQo70F6tDUIJ42FYmPHwNXVTvmoq7FpKXk6fQhCbch7iSXxkVL6NLpL6YCMz1+evVm67RKfYnQb5ug/xRl1zC8AxX/EZ9YHimnJQBejfI/XJoQ5Fpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from IA0PR02MB9486.namprd02.prod.outlook.com (2603:10b6:208:403::18)
 by PH0PR02MB7143.namprd02.prod.outlook.com (2603:10b6:510:1f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Fri, 21 Mar
 2025 21:48:28 +0000
Received: from IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891]) by IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891%5]) with mapi id 15.20.8534.036; Fri, 21 Mar 2025
 21:48:27 +0000
From: Sid Manning <sidneym@quicinc.com>
To: "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>, 'Brian Cain'
 <brian.cain@oss.qualcomm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "Matheus Bernardino (QUIC)"
 <quic_mathbern@quicinc.com>, "ale@rev.ng" <ale@rev.ng>, "anjo@rev.ng"
 <anjo@rev.ng>, "Marco Liebel (QUIC)" <quic_mliebel@quicinc.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "Mark Burton (QUIC)"
 <quic_mburton@quicinc.com>, Brian Cain <bcain@quicinc.com>
Subject: RE: [PATCH 06/39] target/hexagon: Implement {g,s}etimask helpers
Thread-Topic: [PATCH 06/39] target/hexagon: Implement {g,s}etimask helpers
Thread-Index: AQHbimrZHt6mKivE9EGTtk7t2TU3ZLN3s5IAgAZmyEA=
Date: Fri, 21 Mar 2025 21:48:27 +0000
Message-ID: <IA0PR02MB94869B8845A4B698519DDFF9BEDB2@IA0PR02MB9486.namprd02.prod.outlook.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-7-brian.cain@oss.qualcomm.com>
 <017301db9764$35236f00$9f6a4d00$@gmail.com>
In-Reply-To: <017301db9764$35236f00$9f6a4d00$@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9486:EE_|PH0PR02MB7143:EE_
x-ms-office365-filtering-correlation-id: 91d2b967-6fa0-4150-fc82-08dd68c21d24
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?bFNoWk1CR1NhUHo3M2NmeVFvekNZbU1XRXdqdDd6TURYQ2liOE4vc3E1M2xD?=
 =?utf-8?B?R0dLOE9Va0w1UCt3RnFqcm9laThtcmN6dHRLeTRaZU9iSk9PZ2FhcUhHMzRE?=
 =?utf-8?B?eVdyUjdnWE5HbmtiVkhqejVHZnZyZyt1NGxySmRhUUExNDZPOCtjVmszdG9u?=
 =?utf-8?B?UWFvaEwyV0NUMFk1c2JHeXlvbnE5QWpTNkE3S05vcnZFZXN4N3VGVDAwaFNX?=
 =?utf-8?B?SERXYWJQcFowaTRjc3ZTSE5sZEt0MDJEUVRsSXBxZTZldjFzbjF4WE9sbWJO?=
 =?utf-8?B?Q1o3OXM5YTJtVUt1azBLSEhDbmtYUVlZM3BQclNmd1dYa2VCV21zbU52RkUx?=
 =?utf-8?B?Q053a3BwVmNOYlNsaU1Dako4bVl6WUlZZVVjNGRWTjlRTmh3NEp5dWNXNVFT?=
 =?utf-8?B?S1o3Q3VCQzg2U1ZZV2g5WWVEWnZUMXlGV2UvdEFNdGEyamtPdURjOGVGWmtH?=
 =?utf-8?B?TmhOWGE5SndiTmNoTk9QVGh2aExOYmNpbUNFOUdBWXJLQ1dzTUE0Z29UYVp2?=
 =?utf-8?B?RVNqa09iTFQrOXovR1AzMzhrbXJDejdEYTIxdXlPUW5wSmRsWVNvY1BUcTRB?=
 =?utf-8?B?Mm5GSFFBQzAwalg3WG1HcnRMV2F2RktSV1dReVhpdUVIUUd3MWJOcEYxZ0lH?=
 =?utf-8?B?Z2lTRnVXRW13YUNmakF0bnN5SVNtNWY2R1RreG4xRVNnYTIzQTgrVUpudXZo?=
 =?utf-8?B?dng4Q3pRY1M5cXNkbnlFWjZzVGhqR2gzaUdxYzhyUmJtRU1Td0hET3hvVHFP?=
 =?utf-8?B?MkNHQUQ2Wld6c0hvUTZFZk9LZXhrdEN1QkxjcWRBTXBXWUdRY1dmRVlmZXBa?=
 =?utf-8?B?NDM3ZWtkdUM3d0pNK1dzZXl2U3hiNUphWmtXQktnNFVtWDFVVklycmthL3BY?=
 =?utf-8?B?RFo4V0dBUVpTcnJjdldjM1UveTNqd3JDVVNneTVpT0tVYTcvSVN1S1JQb3lW?=
 =?utf-8?B?RTBUa0NxZG1kVFBuZmR1dG5pVU1yZGNSajFwL3VLeDZOWVdWcUdocGFaQ1hY?=
 =?utf-8?B?UjhiTEFtL25WbW1jZENKaS84eHlUd0kxdkhhamlPUGwvTVRMV2N6RDlMR3hk?=
 =?utf-8?B?eFNYTVN3WmpMMXA4ZFZPdzBlcWx5TUpOT1ppMXhrMlExTW9WelhpeGt6TFZi?=
 =?utf-8?B?N1RuRXhSL2h2QitycHd3bkRZMUw1bHNxc2c3V3dhUXU5Q3BjRHllUzBvSDJQ?=
 =?utf-8?B?eUxvTjl2ZEJQL29TZVd2SHdvVUNqUm40SDl3Si9tYVhHTXAreDBHRkZYdmhx?=
 =?utf-8?B?SlB4M2hHSUs2V2JRRmhnSyt0aS81bDhmMDZYdUtYY1N1VlhITlVoMDFTdWVj?=
 =?utf-8?B?UkRhSDJXc2NNQlpJbnNOdVdnL3oycXJKcURlQ2MzVmtzc2YxVTJPTGFCRzlt?=
 =?utf-8?B?cng0bi9xWnBPVitwTDlwY25va1EwclpTZTlack1MZ2ovbkk3K1hmR08vTkdL?=
 =?utf-8?B?dVVXYjVkZjlkdFF3QWFZWXEzTmk1bXRPSGNScG9sc25vUFZDMUxIMDBQOW5G?=
 =?utf-8?B?WkRnd3lBeExRT2xTK014T24zMGxTZGZ4UkVpN1AyM1lhNU1ySW4zVERveXd5?=
 =?utf-8?B?M1QrdGRrby9DRUlTL2FsWW1NKysrWUdpd1IwYWR4TjdaOUp2M25lRCtXV3Jk?=
 =?utf-8?B?YkFZZEU2T2tzNnQvMjRzbXZrcXZrMjBON1d2NlhET2lPa3ZIVFU4Z2lKd2Q4?=
 =?utf-8?B?ZWdYUXVXQm5IWXBGaFE0dG1pL3VuVjdmbUQwcE45SlA3NDEwK1JTRUtNZXl2?=
 =?utf-8?B?bWtoMlZuakwvTHgxM2x2QjNmL1lpVS96emIyZVFkSGhwNjh1NWs5Y210NSt3?=
 =?utf-8?B?MGdGMmZVNm5pKzZucHNaQlh6MHJONXpDdnJCWjVYY0J2c1QzeGdsY0lkODBm?=
 =?utf-8?B?NkFkTGIrOHUweVlyVzhHRkoxTXNiSDBRNEZ5blBpMC9nWklxcVBtR0lyYkg0?=
 =?utf-8?Q?UsDu8jI/U0mdFNramLQhwiLREJSLW8aj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9486.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkJEdmYwOXV2S3Z0M0pFSHpyMWN5dGhEdWVuQlVMRitVT3I0UFFIbVJoUDlu?=
 =?utf-8?B?OEdKeTRUa0FFT08xR3Q5bG1EWkxZRVEvMEY0UkRxZ3pPTHJITk5FbnhpR0VI?=
 =?utf-8?B?RU5veG9Md1dqRkYrUTJDNGJ4SGdlMytQaFNrc2JkdHVnQnNZMmo2ZzBTekNS?=
 =?utf-8?B?NTNMNmFHVGRoRHQxOTFMbTNaNkhOWUZVWVdGOE5hbEgyMmU5V0JxeG1YWXBm?=
 =?utf-8?B?VCtYVUlON2pEejVSMEVpUXBEQnJrdGZHRnplYkswNzZaa3BIbytKeDBmbzJ6?=
 =?utf-8?B?STJ1V1hhdTVaNmR1NHlPNnVMQi9yQXZNRE1YZ3BkTHNSR0UyQXpaK2lwMUU0?=
 =?utf-8?B?cEdoVm56K1dldlV6eHU2RitIUm5WYVNxMG1BemcxaDhHaEszNGdDeDhBSVky?=
 =?utf-8?B?dWxZK0lweUJRc0xGYXR6Y050Tmd4aW83eWZ5YzQvZ2puMHJoZ0VNaXZZd0dK?=
 =?utf-8?B?R1laN2ZVWCtBcllZb3o0LysyN1pZT1hvWDFjWG8zdFJTVTljNVFtR052UTd2?=
 =?utf-8?B?ekxyVmNRVTlhVVVZcDQ2cWJxaElYT2dYYWZJQXBrdHhOcVZ6aHZJZ3BrQTNo?=
 =?utf-8?B?WjJDbWlQYXJoaGRSc3NzZldPaVAybXdGOVU4K2Y1eGxqcVRGTjM1ZjZ3UUpR?=
 =?utf-8?B?ekZJanBpRkhHSUtHQ0FPVmIySXUwRUdibkRNTks3VFU5TmR3Z2NWazlhQml5?=
 =?utf-8?B?eEVZdHVlQlFrUnBOOFMxWGNZQ0FsZE9ZZWFHaXJ4N2cyK2ZxeCs4YmVaNnVL?=
 =?utf-8?B?clBva0ZiZW42bGhPYUZKWld5NlZRMy9lRVFRNmJBQzdzU1NSRkJYa3NhV3g4?=
 =?utf-8?B?SlJ6bFlmRTZPVERPWXB6R3BtTDBwYWladGRxaytPRHpScGIwczFuOWJkY1N4?=
 =?utf-8?B?d1RWODI3QjBoYjg4WnJXQkw1cXlXWHMyT29Gb3Eva2xCdWxTS3Q3c2l4Yzgx?=
 =?utf-8?B?eGpSbDI1SWtFRGVYck5OUTNMaDhkTThVWGlHNHlGYXRHVDArTW1jczdCV2pW?=
 =?utf-8?B?bkVYWTRNNjJZUzdpdDNuNDljQVVmY2tlQ3ZOeUVVMnNvWGg5d2tEcHBxVUkx?=
 =?utf-8?B?OHJnVmtiRVRBbkF4T2J4eUlxWDdjRnJZaStKSWJ1QlJwVUViR2UyNVdvNnRn?=
 =?utf-8?B?aDgwVkczR1VBcDFJaDJ1YlltVnk5L2ZXQUZXbDljcmoyQ0M2dHpJZ014bml6?=
 =?utf-8?B?d3JzVzJUekdxN3JOeURhQ2ZMSkxHbDg4c2duenFSVytYN3RhTzhaRW9qVmtB?=
 =?utf-8?B?Q3JqcUNSVEdiK3NjT3B1L0hWcTFBUVdUSC9nVzdRU2hUbXIxN1piaVdUVWlW?=
 =?utf-8?B?NGt5L3dieEpjbW5TbXNScXdCWWtLelhxeEZ6ZkQySWRsaVlWcnBXa0xWKzJv?=
 =?utf-8?B?dFNZUXVMZmJDN3pUT3RzVmp3SnVBTS9lREs3SXBXLy9BaWJScUhaWGcyaW5J?=
 =?utf-8?B?ai91T2ErUGZIRjVveHFOR0Y0TVNSK0NJOGh5MXROcnFxeXVPUjZhUTFrSHJB?=
 =?utf-8?B?MkRQSi9CbmNlc2I3Q2ZabGN5aU50Um1UdzlRdE5HY3hjOFBmdWs1U0hGYkt1?=
 =?utf-8?B?MGRGU1lCa0pxZmRDalNNUnVEakJjeU1oUHBRRytEQ1hPNFMwMDJrVGxyV3Jj?=
 =?utf-8?B?ZGp4cEF3VzFYK0RrM3VJMGhySU92di9uWnFBT2NSa2lmblRxTXVxaW9Ob1Bm?=
 =?utf-8?B?Z2VyUm5EQlcyUlhZR2tpYU9vNGhtWk9jcWtzblFvOHBNVklNbXBYSHd4Nm5J?=
 =?utf-8?B?YzdNcVpCbk8zcStWUSt2elF1SGNYTnlkZ0hJSWNTZ2ttSU1PSWc1aVgvNmUr?=
 =?utf-8?B?emVOVWl5aHJkVVNsZzZ1cVEzb0RqU1ViVHBGYmtIVTNMN21IRFFZNENPTzd6?=
 =?utf-8?B?eFlqZU9EL0oxbHNiWkI4RmprYWdnNDZWYnRLZ09BWkVCblJaRS9HRHdITDRH?=
 =?utf-8?B?MXpjZkRpbytaQ3dGWDVYQTk4WW45Wm0veE15NHI5SUR2Z2tYRnBldldTUVFW?=
 =?utf-8?B?Vko0UnN5NjdnSWFwbG41amJldDhTSkN5TmhxK0RWUjZxRWJ4ZURvcldPM3Yy?=
 =?utf-8?B?S3czNGRxazg2MmJ5QU5RNU5YZXFZZHZpa0ZkYlNTam1nQW1UNUUrM295Lyta?=
 =?utf-8?Q?oz0AQeG6zOhI694Diz2e29XRt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /exc8HY+zDSQ3xnbtvgB5s1IQeUBRWjFJkZA0W0htQjf0d1izM8h2YrS1l2QdI2LoEy+UyMaq0DnsWKhdm6MC5FAVViNOKhfrjhGtH3cl7FjgC6q7Lb/wrFafZcbK+tbAB9FOC+6MxpmBrs5/pZf9jD/FAmfZTnrei5QwVCG2XEflLA0P3or72EMxnflIlxRzXihRuHjoyGhsHjD67gGGfxSIr92PAMqmQfWtxtdCG6qTnvORJR1YUt9kuY6a98Rz494u3ZkiD6TjKMwTDkMz/9rPGP1M3U2S4Dy3Pjg7K/3zvCRk2llJMdIRrqzASkr/7ek77nK+GmRR8IAeMHKhqXW4DV7nPvW+h4Km8EtcFR9HeQrGF6tEb9JVMIqcfKAamqAtaowSPeB38QANo8lM6m6pPN4u+Fw+uLdaZKYKMLOowoTO8cKCdPqzmRZ19q11VBa6jTqQI1edNdJiKunfHy97tvqe/hGd+eQxuahN0m3dJJk2lzEbbsnfZlDfjl68kdbCm/QwxzoLvriF7oSL8bkJkphcIhZ3Jjsl30wJvWSsAjFXjb/Bq75I+xhxta0ZyyJgFpIWvLcE8ivtMfaIYT85R3TNTBGHESKQTrsyU9fbvji5j2VFqqIPnx8E7ol
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9486.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d2b967-6fa0-4150-fc82-08dd68c21d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 21:48:27.8141 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YphOXREgH40e+jKzagWirdwzZ8UH7FTcuOFuwL6qJtW0/O9PE2mk/zwCKpxvDCCirHzvg0lL6bW7A/MzOkqiNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7143
X-Proofpoint-ORIG-GUID: l9ArH1FY18FSjlRJr_ji3nqttQMMTlfh
X-Authority-Analysis: v=2.4 cv=FYE3xI+6 c=1 sm=1 tr=0 ts=67dddeb3 cx=c_pps
 a=ynuEE1Gfdg78pLiovR0MAg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=at0bhs02LLflEQY2P9UA:9
 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: l9ArH1FY18FSjlRJr_ji3nqttQMMTlfh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 impostorscore=0 mlxlogscore=739 mlxscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210159
Received-SPF: pass client-ip=205.220.168.131; envelope-from=sidneym@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbHRheWxvcnNpbXBzb25A
Z21haWwuY29tIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWFy
Y2ggMTcsIDIwMjUgMTI6NDQgUE0NCj4gVG86ICdCcmlhbiBDYWluJyA8YnJpYW4uY2FpbkBvc3Mu
cXVhbGNvbW0uY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiByaWNoYXJkLmhlbmRl
cnNvbkBsaW5hcm8ub3JnOyBwaGlsbWRAbGluYXJvLm9yZzsgTWF0aGV1cyBCZXJuYXJkaW5vDQo+
IChRVUlDKSA8cXVpY19tYXRoYmVybkBxdWljaW5jLmNvbT47IGFsZUByZXYubmc7IGFuam9AcmV2
Lm5nOyBNYXJjbw0KPiBMaWViZWwgKFFVSUMpIDxxdWljX21saWViZWxAcXVpY2luYy5jb20+OyBh
bGV4LmJlbm5lZUBsaW5hcm8ub3JnOyBNYXJrDQo+IEJ1cnRvbiAoUVVJQykgPHF1aWNfbWJ1cnRv
bkBxdWljaW5jLmNvbT47IFNpZCBNYW5uaW5nDQo+IDxzaWRuZXltQHF1aWNpbmMuY29tPjsgQnJp
YW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMDYvMzld
IHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQge2csc31ldGltYXNrIGhlbHBlcnMNCj4gDQo+IFdB
Uk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBs
ZWFzZSBiZSB3YXJ5DQo+IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBl
bmFibGUgbWFjcm9zLg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZy
b206IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4NCj4gPiBTZW50OiBG
cmlkYXksIEZlYnJ1YXJ5IDI4LCAyMDI1IDExOjI4IFBNDQo+ID4gVG86IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZw0KPiA+IENjOiBicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb207IHJpY2hhcmQuaGVu
ZGVyc29uQGxpbmFyby5vcmc7DQo+ID4gcGhpbG1kQGxpbmFyby5vcmc7IHF1aWNfbWF0aGJlcm5A
cXVpY2luYy5jb207IGFsZUByZXYubmc7DQo+IGFuam9AcmV2Lm5nOw0KPiA+IHF1aWNfbWxpZWJl
bEBxdWljaW5jLmNvbTsgbHRheWxvcnNpbXBzb25AZ21haWwuY29tOw0KPiA+IGFsZXguYmVubmVl
QGxpbmFyby5vcmc7IHF1aWNfbWJ1cnRvbkBxdWljaW5jLmNvbTsNCj4gc2lkbmV5bUBxdWljaW5j
LmNvbTsNCj4gPiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4NCj4gPiBTdWJqZWN0OiBb
UEFUQ0ggMDYvMzldIHRhcmdldC9oZXhhZ29uOiBJbXBsZW1lbnQge2csc31ldGltYXNrIGhlbHBl
cnMNCj4gPg0KPiA+IEZyb206IEJyaWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29t
Pg0KPiA+IC0tLQ0KPiA+ICB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDMxICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYw0KPiA+IGluZGV4IDlm
NzliMWEyMGMuLjgzMDg4Y2ZhYTMgMTAwNjQ0DQo+ID4gLS0tIGEvdGFyZ2V0L2hleGFnb24vb3Bf
aGVscGVyLmMNCj4gPiArKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYw0KPiA+IEBAIC0x
NDY4LDEyICsxNDY4LDM5IEBAIHZvaWQgSEVMUEVSKHJlc3VtZSkoQ1BVSGV4YWdvblN0YXRlICpl
bnYsDQo+ID4gdWludDMyX3QgbWFzaykNCj4gPg0KPiA+ICB1aW50MzJfdCBIRUxQRVIoZ2V0aW1h
c2spKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCB0aWQpICB7DQo+ID4gLSAgICBnX2Fz
c2VydF9ub3RfcmVhY2hlZCgpOw0KPiA+ICsgICAgQ1BVU3RhdGUgKmNzOw0KPiA+ICsgICAgQ1BV
X0ZPUkVBQ0goY3MpIHsNCj4gPiArICAgICAgICBIZXhhZ29uQ1BVICpmb3VuZF9jcHUgPSBIRVhB
R09OX0NQVShjcyk7DQo+ID4gKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICpmb3VuZF9lbnYgPSAm
Zm91bmRfY3B1LT5lbnY7DQo+ID4gKyAgICAgICAgaWYgKGZvdW5kX2Vudi0+dGhyZWFkSWQgPT0g
dGlkKSB7DQo+ID4gKyAgICAgICAgICAgIHRhcmdldF91bG9uZyBpbWFzayA9IGFyY2hfZ2V0X3N5
c3RlbV9yZWcoZm91bmRfZW52LA0KPiA+IEhFWF9TUkVHX0lNQVNLKTsNCj4gPiArICAgICAgICAg
ICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiB0aWQgJWQgaW1hc2sgPSAweCV4XG4i
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBlbnYtPnRocmVhZElk
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICh1bnNpZ25lZClHRVRfRklFTEQoSU1B
U0tfTUFTSywgaW1hc2spKTsNCj4gPiArICAgICAgICAgICAgcmV0dXJuIEdFVF9GSUVMRChJTUFT
S19NQVNLLCBpbWFzayk7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICsgICAgcmV0
dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICB2b2lkIEhFTFBFUihzZXRpbWFzaykoQ1BVSGV4YWdv
blN0YXRlICplbnYsIHVpbnQzMl90IHByZWQsIHVpbnQzMl90DQo+ID4gaW1hc2spICB7DQo+IA0K
PiBUaGUgbmFtZSBwcmVkIHNvdW5kcyBsaWtlIGEgcHJlZGljYXRlIHJlZ2lzdGVyLiAgVXNlIHRp
ZCBpbnN0ZWFkLg0KW1NpZCBNYW5uaW5nXSANCkluIHRoaXMgY2FzZSBwcmVkIGlzIHJlZmVycmlu
ZyB0byB0aGUgcHJlZGljYXRlIHJlZ2lzdGVyLg0KDQpzZXRpbWFzayhQdCxScykNClRoZSBzZXRp
bWFzayBpbnN0cnVjdGlvbiB3cml0ZXMgdGhlIElNQVNLIGZvciB0aGUgdGhyZWFkIGluZGljYXRl
ZCBieSB0aGUgbG93IGJpdHMgb2YNCnByZWRpY2F0ZSBQdC4gUmVnaXN0ZXIgUnMgY29udGFpbnMg
dGhlIDMyLWJpdCBtYXNrIHZhbHVlIHRvIGJlIHdyaXR0ZW4uIEZvciBQdCB2YWx1ZXMgb3V0c2lk
ZSBvZg0KWzAtTlVNX1RIUkVBRFMtMV0sIHRoZSByZXN1bHRzIGFyZSB1bmRlZmluZWQuDQoNCj4g
DQo+ID4gLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KPiA+ICsgICAgQ1BVU3RhdGUgKmNz
Ow0KPiA+ICsNCj4gPiArICAgIEJRTF9MT0NLX0dVQVJEKCk7DQo+ID4gKyAgICBDUFVfRk9SRUFD
SChjcykgew0KPiA+ICsgICAgICAgIEhleGFnb25DUFUgKmZvdW5kX2NwdSA9IEhFWEFHT05fQ1BV
KGNzKTsNCj4gPiArICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKmZvdW5kX2VudiA9ICZmb3VuZF9j
cHUtPmVudjsNCj4gPiArDQo+ID4gKyAgICAgICAgaWYgKHByZWQgPT0gZm91bmRfZW52LT50aHJl
YWRJZCkgew0KPiA+ICsgICAgICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGZvdW5kX2VudiwgSEVY
X1NSRUdfSU1BU0ssIElNQVNLX01BU0ssDQo+ID4gaW1hc2spOw0KPiA+ICsgICAgICAgICAgICBx
ZW11X2xvZ19tYXNrKENQVV9MT0dfSU5ULCAiJXM6IHRpZCAlZCBpbWFzayAweCV4XG4iLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBmb3VuZF9lbnYtPnRocmVhZElk
LCBpbWFzayk7DQo+ID4gKyAgICAgICAgICAgIGhleF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7DQo+
IA0KPiBTaG91bGRuJ3QgdGhpcyBiZSBmb3VuZF9lbnY/DQpbU2lkIE1hbm5pbmddIA0KSXQgY291
bGQgYmUgZWl0aGVyLCBoZXhfaW50ZXJydXB0X3VwZGF0ZSBpcyBqdXN0IHVzaW5nIGVudiB0byBn
ZXQgdGhlIGdsb2JhbCBpcGVuZCByZWdpc3Rlci4NCj4gDQo+ID4gKyAgICAgICAgICAgIHJldHVy
bjsNCj4gPiArICAgICAgICB9DQo+ID4gKyAgICB9DQo+ID4gKyAgICBoZXhfaW50ZXJydXB0X3Vw
ZGF0ZShlbnYpOw0KPiANCj4gRG8geW91IG5lZWQgdG8gdXBkYXRlIGlmIHRoZSB0aHJlYWQgd2Fz
bid0IGZvdW5kPw0KW1NpZCBNYW5uaW5nXSANClRoaXMgbWF5IG5vdCBiZSBzdHJpY3RseSBuZWVk
ZWQgc2luY2UgdGhlIG9ubHkgd2F5IHRvIHJlYWNoIHRoaXMgbGluZSBpcyBmb3Igc2V0aW1hc2sg
dG8gcGFzcyBhIHByZWRpY2F0ZSB0aGF0IGlzIG91dHNpZGUgdGhlIHJhbmdlIG9mIHZhbGlkIGh0
aWRzLiAgV2UgY2FuIHJlbW92ZSB0aGlzIGFuZCBhZGQgYSBndWVzdCBlcnJvci4NCg0KDQo+IA0K
PiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGJvb2wgaGFuZGxlX3BtdV9zcmVnX3dyaXRlKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcsDQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gDQoN
Cg==

