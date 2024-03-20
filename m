Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2534DC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmy3T-0005W5-9X; Wed, 20 Mar 2024 11:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1rmy3R-0005SL-9W; Wed, 20 Mar 2024 11:40:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mburton@qti.qualcomm.com>)
 id 1rmy3P-00057O-HR; Wed, 20 Mar 2024 11:40:36 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42KEjVEl023071; Wed, 20 Mar 2024 15:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=qcppdkim1; bh=WNs/GXD2G2gNPejYhmw/9L9jjVSlTpuHzTh5KecV6m4=; b=
 cnj97e5NQkjb6SSMBwL1c9I3QWQdeouZI51LInE9C7gwkVIWt5Bpna41nqgmWkn0
 5ZM2ULJ4SUMQhwKm4ey6uIz8aDbXurMhXpLOotPVT6gWYP8VA08QVh29tuicdqOo
 NXGOs+oX8qUoZ2lzoq/IPKz2lqiLsNaJw9qiLLM5BAz2ilZzzZqAfEeOWk+ElfNl
 /Wkz4wQ9cxJezMDiQRDQW6WvEkaD7t2+XGfr62tjn6i1Lbn94J/xZIQq8I3hGK6Z
 atwM04QoYbv46e4XCFY3W0sO/56AnaMi+0My6cbWLhNCQmz8Bfyd0T1NFTLO0aF2
 8pN04BYvLlyT73KTNwS54w==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyy76gja1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Mar 2024 15:40:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFfUD2vZPMHoDwIJ6DauidAw3jPRBTOe8iA0xRhTrLyJtJ9vEd669sX6MSPbWR0gRdQlP/nkeT1EQFFJlrkTv6CMeER3AI0tEhSnukkTlhG2eSGqnXgPYGIqr7u4Z4b9hOBBLInmu9RNmfMtbmaWqL/4Gd9GNbZEYM687MB5cn62Pz5fl5htkhuIQY4z5Tzv5z3XOd4QgSNFat4lmKE+QD5gc9jc9+rTn9D560aSKrs8VvzmhgIMS6nFwz3R5ok8hz/CgjwPLE1XrbTMvGjef8/SdMaEGLh0KZFtd/ApjsnPzOUb97HOH6zY4r4QkywjHH344hnD3vpEJrEcy95wJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNs/GXD2G2gNPejYhmw/9L9jjVSlTpuHzTh5KecV6m4=;
 b=RbFD16nHSfFoBEmt5T1kSzCMFx00n609+MFxGdVYS9nPZSrYP0tVDhtAEk4l+SDJMbWND7QnKecQscM4/v+s5HohiK6REwDmiAGsxcHG1nSZxfnW5SZrQqdaYXppJ+aXLWoUxITWhlSLgvH0J+1Iu4DnHRCjtD9Um7UmfUKullgawe6HxKgJFtAB3ohdxGf0zcQC/6GgRKt+bkkcOTVJqJRTCrLJu9a+KyN3EuUAv+55U8jnhxEdDmBYDKplUo14XmLKHuNB/0k3YpvYRwwmjL3HA5tTL0s63YEu5DtKj1D8ZHP8+9Plwdk99S53bKL4lK7c0WBtt1stVZ/sBKS3Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ2PR02MB9884.namprd02.prod.outlook.com (2603:10b6:a03:53a::21)
 by DM8PR02MB8296.namprd02.prod.outlook.com (2603:10b6:8:7::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.34; Wed, 20 Mar 2024 15:40:27 +0000
Received: from SJ2PR02MB9884.namprd02.prod.outlook.com
 ([fe80::f655:6bb8:2692:cb0f]) by SJ2PR02MB9884.namprd02.prod.outlook.com
 ([fe80::f655:6bb8:2692:cb0f%3]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 15:40:27 +0000
From: Mark Burton <mburton@qti.qualcomm.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Thomas
 Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "qemu-s390x@nongnu.org"
 <qemu-s390x@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
Thread-Topic: [PATCH 0/4] hw/nmi: Remove @cpu_index argument
Thread-Index: AQHaerh97y9neLDZOEe71DBZx3RqVrFAhvkAgAAIqYCAABd6gIAAA/qAgAAOOgCAAAsPgA==
Date: Wed, 20 Mar 2024 15:40:27 +0000
Message-ID: <7B18B8A2-B72A-42D5-AF97-1EA621F43DCA@qti.qualcomm.com>
References: <20240220150833.13674-1-philmd@linaro.org>
 <f4a6492b-cff4-439d-8f34-cdf04cb747ee@redhat.com>
 <cc132404-dcd5-4aed-a481-b46d6e3115b0@linaro.org>
 <CAFEAcA_0qUFW0MewHC+v+pSOisE-kQDt9Wv4F3RafEkyQ0DGJA@mail.gmail.com>
 <59C20F1A-FCFE-4E26-B511-A6C0E1EF6F61@qti.qualcomm.com>
 <CAFEAcA8MVbKqv-TgaO7Vv95f0p164Gao+LT-CM5+92cXjkpmTw@mail.gmail.com>
 <23BCD870-16A1-4AF9-9308-2788178F511B@qti.qualcomm.com>
 <CAFEAcA8=H=xD75T-e6JFnz9RtT2kG2nM5HbqE0AsTiWFe+0a-w@mail.gmail.com>
In-Reply-To: <CAFEAcA8=H=xD75T-e6JFnz9RtT2kG2nM5HbqE0AsTiWFe+0a-w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR02MB9884:EE_|DM8PR02MB8296:EE_
x-ms-office365-filtering-correlation-id: c5f794fc-e227-44f1-80e4-08dc48f41118
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KOfGuaqqDseWb1CPuwyKKE1N5rdRt52jakEO4YYhmwBDt6zNj5kjDO69Dw0zntEQEv7WVimN45qnD/b6yLsxGYBHQeqfk13YaeLodJQzY8RdIkZbDH5vSvZ3QDNdi3QV4m81s0YENBXZYK4E7BpM+cxkWfc8RpSkZgRgOC6pN/JUZPCKkT5oMepVCXrZ4d8WteMXaoOmDZj4I1H3tBLtQ+n88ajWFTmjihHlSOgpNQcmUbGE/vfJ4hpd5dwtPh1yg2uGYhVOLPrD3rxjX9fkS6H98Z2m9UAYNPSNdPqtKVXohPLvLiC8AfpEbNYq7SsyvSMJR1M1JKF7fjp4IqYe1J3sGazeKkEnPiI2vEYRaijPDULolNKNUyiQjEUPjco8KTw5t6+hNJYyFel0Gcd4TIZi0EtoPxtno5QIm5ls25ALJx9XD2w8aev5Alh7Jq5grVVvReVqHdRhLE9GxQGRuc3joK9iaIHOtuEzhadOiMzFffI+Md8qRW8FvwLEfid9zvABxHqhdYNPszr1RuWW7CNdpyfrO+uM/HGuqvLxUPIaXXd0gh4fDTsqo3kC/b7SM+YQiTL+9hEQ80t0mhuIzUxvlJwWXKfXeVGdi9haQouJhaHCr9ApMRr36pw4JdTwFQB12Z2QJorBoIbR5AogwJYNLyNZ+eH3KjowcEOY2V4l3udnLerLdKiWrMdU7GhtaPrue5N248ql6ZCzfYgWFTLuTtiXwg9eVF157Z/AEDM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9884.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFI3aWRDdkVWZDRvRnl0UXBhYTZkTm43bmNPSzg4ZGlCWUo5dUZJTWt1RkVm?=
 =?utf-8?B?OFVpSW5hc09maXYvOE5vVmFyczRTYVBnK3pLaEg2UUtpVy8yY2tRMTlMb3Yv?=
 =?utf-8?B?SXBUWTlsbUhJdFJuWlZnMW5KZUZrS3VITlFtTVpwRGJXR2RSeExraUxhVmpp?=
 =?utf-8?B?NjZmWEhTeERvUkNkT05id2oyTXQ2NElUWXAxZ1VtMGN5M1dQaVIzSjV5SUFN?=
 =?utf-8?B?Vjc2L0swSGZOcFNxS3B1bG9VVmEvWlRGQm9abXN6cEpxSDU3NVdSVERUYkkw?=
 =?utf-8?B?eDBlMnRURmVlN1Z6Mk5zamRhQkFNdTFXWEtQSW9PMlh0Uy9CUm04TWJ5ci9C?=
 =?utf-8?B?WHZOYTlEMXgrYUtiRTRVdjJYdzFLUkQ5RzRSdXRmb2p3aHlaSTMwVmFDWFNH?=
 =?utf-8?B?UHFYUHkrbW1EK1ZjUUdEKzdUQnhxZU13WVQwOXZxN1BUeVVqVTd5TnZwVVdp?=
 =?utf-8?B?YnVQaEkrYU1qQ3hZb3QwSDRKKzhqRVJKNkxhMmtaM0NaeCtjL3NQamtyUGg0?=
 =?utf-8?B?OXhkSDJ4Z0NWNFA0Yi9TUzhtUHlIL1FuSUxQaklvWm1waUR3ang2QVNLVUVs?=
 =?utf-8?B?MHd3UkpJVWI3R0NmUXcySHIwbGdwNGJKNy9jeUIySnNhUUgxdjY2QVlObitI?=
 =?utf-8?B?Q3o0c3BqT0t1VS95b0hoaGFPaTQ2aE43NE8yeFZmTGhwMDNKWnBZSVNlN0dU?=
 =?utf-8?B?MUMxYkc5TmFDYnF0MXUzVTJVM2dGR1V5VDFqenFIbVZkNndjeGw5SFdISk5D?=
 =?utf-8?B?YTdsTks5dHg1amFLeElBUFFVRnV5d0UyY09BakQ1SWVtNWd0eWQvQ0Z6aG5o?=
 =?utf-8?B?dkN4c1N3Y0hYOHRVU2dUamg5TXVNOHduM1Q3SjJlSG5lRm82ZHFQWGJRUjlH?=
 =?utf-8?B?clJaYVlhbVlCcy8xTllEQzRxRHdVOFBRREtURXJ1SGdOekN0R3lHS2VtTVkw?=
 =?utf-8?B?cXAzaU1LYklZWEhhekFTT3lmc3IyV3F6dS8yNmdmZTJjWTRJbDc1OWV2K2lO?=
 =?utf-8?B?MTVxR2p0b1pzZFBUakNtbktyaXBLSG9xcG0xVFk1SGx3Wmx5S01QSWxSMCtl?=
 =?utf-8?B?a05rZUZyQkpoQkNWYWVNekVPOHdVQkFOTzBjYmwvcGV1Q0N2a2FMbkpSOUl1?=
 =?utf-8?B?N0ZPNkh2RHNIbHhSVjZMbDVoMFpXcGdHeXo1cmtnVHFranY5OG1Kb1lJbkdt?=
 =?utf-8?B?bHlwY1BET2tUdS9SZkFMdTRLbkxTa3JsVlhMS0VEdTJsUG5EUlh3amF1Y0xM?=
 =?utf-8?B?V3dPemV2NjRoWGdtKzNoNEcvSG40R05TQUpyRC9GYU9velFKek40dHhJZzZn?=
 =?utf-8?B?eWNYRzlGdjFnY29mL2lPRm1pZXcvbjkxMkRQcjBrWDdUMTdubFdQZU5pL3Jj?=
 =?utf-8?B?azlmTmI0UVhCb3YxWUlteXNBVjlRODZwWjFBRCt1MnNnWDlKZ2RpSDRZUUoz?=
 =?utf-8?B?R0dqY0dmRlJZSGw1WVNKc2VsellnclM0bUdDV0lyZHh4N3VJTlQ2K0owNlJj?=
 =?utf-8?B?OHY1b1FvUlgxME0vTmh4WVNXQWI0d3hoS2FZWW1PNlNrSGlOQTF4UGYwSGlu?=
 =?utf-8?B?WTdiMStua0Uwc0RYMG9ZeVNtSUJWNml0Y3lIMmVJb2tUZ3FVekc1NW1PMWly?=
 =?utf-8?B?VzZBMG0vQjNrUENQRXdSSGZ0TE56R0k2UUlPVzlDUjVMZHlsUDlvMUEvNFJC?=
 =?utf-8?B?ZGM4QXRBRVB0dEFNaVFHa2xpQU04NU95eFlaNXdQcWhQZHl3eEFmWHNKTzRM?=
 =?utf-8?B?MHRtQTVpejVwWU5sMCs5K20zMWxBODB4WG9ERlJMdnN0YVkvT1NlZXQ2dlU3?=
 =?utf-8?B?K1ZpRHEyeDNMNWg3UlU2cTV1SHkvZU5kbXU3UWI3N3VvaHdlWHlHOG93Y21L?=
 =?utf-8?B?Uzc5WGdycHFIOHMwaUkyUzBTdXh3Yko0RGFPdGpaNC9jcjBTaFQrS2JaRmNJ?=
 =?utf-8?B?RlBZWmQwR1NEb1JPUFpaMUdsY1F5SHJxajRjOGZOdW9ZZmhmMkpRRnE4Qkd5?=
 =?utf-8?B?dmZRQVRVZ2N2TGI5QUMzc2FRM3dsTTV3ZllSaFhPZjVmTnltMkExLzFiK256?=
 =?utf-8?B?STFXdUVMdDVhZzZKYlduMEJmcVFtMENOY3RlU2E3M3BlRTN1a0dETGE0MlM1?=
 =?utf-8?B?bktUbE5PcTcrSlA5eUFLdFdZOUJhL1IzZmx0djd1MWp6MWp5R0lqa3RNVHVl?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6649A5B499324447931BE28AD1EB871F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T+kTVhDdef2EGgXlgttfuZCTaP4WE7TQTslIxwe8+agcfWebp0iAHQyOKlxD7maZv6h83zonPpUegrzeNYZxXCUmoG5gbnyKgjssH1H/sxcNMtMO2XqRUAs8JqxtFwA6H+PqpHJjY+ETJ+/uxIWhq12n+yxPU97Vvnq9XxBOxsTwbbM4rUCscVc3ffhRI/+pJAhA+T7tphWJ7nuL2NEPepP8AuXbDt8x4+yMrSrUhx6lcE9fzNr8MrcTuM+WzUx6YSGDrBGCwCDG87e8N1RaklKQ/UuP+EWdu/TahPRleahVBwdALudChkCDBL0Xh7yzD89+HQWFUUbHOMqZzHoW81I2w8O8jv4y9JIyt0Ntw2EtCGiBziaQ9toJmG5DBjNdLR/BVfcaM6dSjybAoRfLqXC0N+G0a6UIhaHZETAkI0V+tpA33xDD59T5g1zUFYSK/9Wk19Uxzwsc6tPCQPJAUlBxV/zfvkXjcojMKlekrPUv45+DXdiLPgpc7J2NoNrBh/evYEHvHpe08le7PhksUX8cp0MKKdW7rRibgOgtdGgRYVDL9pARkUcfdf8F7ebDG1tqICIp27J8fu20cb57yesHoJZZwW/GCy+IwYuT54VjpNONSJFbFuHO/hC9nrL6
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9884.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f794fc-e227-44f1-80e4-08dc48f41118
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 15:40:27.5548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kGop9JEtlwQkpHwO9jfeqcMX4aZ5efLenvOuw9AoSUzs0xIvfpa6fyrNxdebN72UoO9vsM0HqGXUsEGNW5iXjzUAMqEfNE96g3Zu8qs+tT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8296
X-Proofpoint-GUID: gQTRWF97N2rZeQEbIQFCx7jbnAjVpLbY
X-Proofpoint-ORIG-GUID: gQTRWF97N2rZeQEbIQFCx7jbnAjVpLbY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_10,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200125
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=mburton@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4gT24gMjAgTWFyIDIwMjQsIGF0IDE2OjAwLCBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc+IHdyb3RlOg0KPiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5h
dGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdhcnkgb2YgYW55IGxpbmtz
IG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBPbiBXZWQs
IDIwIE1hciAyMDI0IGF0IDE0OjEwLCBNYXJrIEJ1cnRvbiA8bWJ1cnRvbkBxdGkucXVhbGNvbW0u
Y29tPiB3cm90ZToNCj4+IEnigJlkIGJyb2FkZW4gdGhpcyB0byBhbGwg4oCZc2lnbmFsc+KAmSAo
SVJRLCBSZXNldCBldGMpIC0gYW5kIEkgZ3Vlc3MNCj4+IHNpbWlsYXIgc3RhdGVtZW50cyBhcHBs
eSwgd2l0aCB0aGUg4oCcYnJpZGdl4oCdIGJldHdlZW4gdGhlIGZ1bmN0aW9uDQo+PiBhbmQgdGhl
IEdQSU8gbWVjaGFuaXNtIG1vdmVkIGNsb3NlciBvciBmdXJ0aGVyIGZyb20gdGhlIG9yaWdpbmF0
b3IocykNCj4+IG9mIHRoZSBhY3Rpdml0eS4NCj4+IA0KPj4gVGhlIGlzc3VlIGlzbuKAmXQgbXkg
4oCcbWFjaGluZeKAnSBtb2RlbCwgcmF0aGVyIHRoZSBjb21wb3NlLWFiaWxpdHkgb2YNCj4+IChh
bnkpIHN1Y2ggbWFjaGluZS4gIEEtcHJpb3JpLCBhIG1vZGVsIHdyaXRlciBkb2VzbuKAmXQga25v
dyBpZiB0aGV5DQo+PiBzaG91bGQgcmVzcG9uZCBkaXJlY3RseSB0byBhbiBOTUkgb3Igbm90IC0g
SGVuY2UgdGhleSBkb250IGtub3cgaWYNCj4+IHRoZXkgc2hvdWxkIGltcGxlbWVudCB0aGUgVFlQ
RV9OTUkgb3Igbm90LiBUaGF04oCZcyBhIGRlY2lzaW9uIG9ubHkNCj4+IHRoZSBtYWNoaW5lIGNv
bXBvc2VyIGtub3dzLg0KPj4gTXkgc3VnZ2VzdGlvbiB3b3VsZCBiZSB0byB1c2UgYSBHUElPIGlu
dGVyZmFjZSB0byBtb2RlbHMsIHdoaWNoIGNhbg0KPj4gdGhlbiBiZSBhcHByb3ByaWF0ZWx5IHdp
cmVkLiAoQW5kLCBoZW5jZSwgdG8gaGF2ZSBhIHNpbmdsZSBwbGFjZQ0KPj4gdGhhdCBpbXBsZW1l
bnRzIHRoZSBUWVBFX05NSSBpbnRlcmZhY2UgYW5kIHByb3ZpZGVzIHRoZSBHUElPIHdpcmUNCj4+
IHJlYWR5IGZvciB3aXJpbmcgdG8gYXBwcm9wcmlhdGUgZGV2aWNlcykuDQo+IA0KPiBJIGZlZWwg
bGlrZSB0aGF0J3MgYSBsb25nIHdheSBpbiB0aGUgZnV0dXJlLCBidXQgbXkgYmFjay1vZi10aGUt
ZW52ZWxvcGUNCj4gZGVzaWduIHNrZXRjaCBvZiB0aGF0IGlzIHRoYXQgdGhlIFRZUEVfTUFDSElO
RSBjbGFzcyB0aGF0J3MgaW1wbGVtZW50aW5nDQo+IHRoZSAiSSBhbSBqdXN0IGEgY29udGFpbmVy
IGZvciBhbGwgdGhlIGRldmljZXMgdGhhdCB0aGUgdXNlciBoYXMNCj4gc3BlY2lmaWVkIGFuZCB3
aXJlZCB0b2dldGhlciIgbWFjaGluZSB3b3VsZCBpdHNlbGYgaW1wbGVtZW50IFRZUEVfTk1JIGFu
ZA0KPiB3aGVuIGFuIE5NSSBjYW1lIGluIGl0IHdvdWxkIGFzc2VydCBhIEdQSU8gbGluZSB0aGF0
IHRoZSB1c2VyIGNvdWxkDQo+IHdpcmUgdXAsIG9yIG5vdCB3aXJlIHVwLCBhcyB0aGV5IGNob3Nl
Lg0KPiANCg0KWWVhaCAtIG1ha2VzIHNlbnNlLg0KQ2hlZXJzDQpNYXJrLg0KDQoNCg0KPiBSaWdo
dCBub3cgd2UgY2FuJ3QgZG8gdGhhdCB0aG91Z2gsIGJlY2F1c2UsIGFtb25nIG90aGVyIHJlYXNv
bnMsDQo+IFRZUEVfTUFDSElORSBpc24ndCBhIFRZUEVfREVWSUNFLiAoSSBkbyB3YW50IHRvIGZp
eCB0aGF0LCB0aG91Z2g6DQo+IEknbSBob3BpbmcgaXQgd29uJ3QgYmUgdG9vIGRpZmZpY3VsdC4p
DQo+IA0KPiB0aGFua3MNCj4gLS0gUE1NDQoNCg==

