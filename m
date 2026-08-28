Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F16C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvBo-0001lD-1v; Fri, 28 Aug 2026 07:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@qti.qualcomm.com>)
 id 1wzt20-0007Zp-3Y; Fri, 28 Aug 2026 05:37:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@qti.qualcomm.com>)
 id 1wzt1y-0000JK-Hq; Fri, 28 Aug 2026 05:37:51 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S66vPe2515392; Fri, 28 Aug 2026 09:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=ac9eWAsXdgDc6ohg8kLygxNRjeTdefDla+iUBkv9Cxo=; b=Uk
 fwNY7uQN/iGxfdUrLDziAs1yD+QMLaDoak0mJjlKiOP8GVyiG/hgWbp7UBVjdEqS
 xh/UNhKPdP8NZyHsWFh5d8iJxbqdT4bDlfY4YbnEtcf9fKB0bKrxFBmPIjiUxB5s
 Uqt7dfvmSAeLP+YW3pyQLHHjusqQj72pN4qAp3GueR5guXtLHW50sysbbiEkgY0c
 vcpmDGaSmJjjB8L0tHjKiN+CMAkNNgxoRsmop9J6ggrOLzW4IoRFx5SPrD98/8s5
 nWIuDWIF/TE0k7otVGU6FwkZfg2lhjVNS7zmFz2mu11ka5+BuscHE0XhsrWJVy7J
 XaE6quQUmrCJGInUkaFw==
Received: from ph0pr07cu006.outbound.protection.outlook.com
 (mail-ph0pr07cu00605.outbound.protection.outlook.com [40.93.23.93])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb47n0y4h-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 09:37:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZZ6rBsBh8+uqFQmrk7fYfTUopWH9KKG3L0WG1cvuRSp+mEsXfGItxe5iOVffYX1PexrYWXEhPh2zo8B43oXz8T2eoCYT2WzuY+n6/HEYm5t8nBkhnbQ93g6COwxclGj7wdhEIHFdkQ7Jy7Nx6dW144qsmB2ruJ0j3uLpNc3iBCfxYeQBIfjQe+3zIbhNgUeVNi2TSJLq/y7dS7hejxLJ4kuuD+eFB9MZCKh4HFLO1G8odQiTkdRinrPiDwbJZi98S6bhPVNPMsnvgXbQ66kfCC19whyvl18UbeMjWxl9/nEa518Z50IjZu1bGAi7PeKZ4QQWV6zkQHr/GaeFDqbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ac9eWAsXdgDc6ohg8kLygxNRjeTdefDla+iUBkv9Cxo=;
 b=KPxp7lEV+Lc4TDum3r576J30kXjw9Aku6NMZlHH80xgasl5lYQ8nLYbjAtJA7KWOFS5iuA8dSzsU0H67Rhw/DXKmBePLUflhlHF5Pku3dy4T/cl4GoZY/J+gRaRFa+Sh/lfuF83OIcF33RBTdV9DhyRKcGGEB7vc+Z9bhT3td5ZxuLfYoSy/g2yCKbRZ0ibuLnQPuw9+z1e66Ud8tfbpYm0d9ro+hwJybqulMYQn5aRDoBSv/ZyxKflQqFhTTQc5Q7cl2MEFB+gtUcmDvtbU3dSAwFhadrVz0ZllVwvN5vgMR909pyOfkngr78gEhfEf3Rq7YIAcsTkl3Ungc8TySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SN6PR02MB5518.namprd02.prod.outlook.com (2603:10b6:805:eb::23)
 by LV0PR02MB11111.namprd02.prod.outlook.com (2603:10b6:408:334::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Fri, 28 Aug
 2026 09:37:22 +0000
Received: from SN6PR02MB5518.namprd02.prod.outlook.com
 ([fe80::d86c:cb35:1a2f:df35]) by SN6PR02MB5518.namprd02.prod.outlook.com
 ([fe80::d86c:cb35:1a2f:df35%7]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 09:37:22 +0000
From: Philippe Mathieu-Daude <philmd@qti.qualcomm.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "open list:ARM TCG CPUs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: Re: [PATCH v2 0/4] hw/usb: Add ASPEED USB Device Controller (UDC)
Thread-Topic: [PATCH v2 0/4] hw/usb: Add ASPEED USB Device Controller (UDC)
Thread-Index: AQHdNtDTY8M3c46F/Em6ZHNDdNXFIQ==
Date: Fri, 28 Aug 2026 09:37:22 +0000
Message-ID: <015cb48b-0600-4482-99a2-1bf20615df5e@qti.qualcomm.com>
References: <20260828090412.981841-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260828090412.981841-1-jamin_lin@aspeedtech.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB5518:EE_|LV0PR02MB11111:EE_
x-ms-office365-filtering-correlation-id: a610de6f-c913-4e37-9247-08df04e7f615
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|38070700021|921020|10067099003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: /5a3Jg1ITK2gzyM7URvG607loUl+EOJYhCkwQIFEMtdfd1DL9AbEnmYpngNmhWPx1CX1MnfPj8sOqB/uiGLbciGPLdhxIB7ZfdT3N02+G1LuYCFws8CU5aYsfYrzRs4r1Wk9Y1Dwe5x+RO/y72XV1H8AKa8IFzezSpvOoz3lLgeKEIM5Rxp0xDY4pvRtPsrFYj1WgJEU8ES1/hs15Z5WmfNmmZIwNp56e4L7UZvYTbMJ59/NWikP2rbD6KsJev6wLIKugylyHqHQK/RxT+5epk79rdTQb/GWkYWfQrQXVEnA6uOCBYKMMfa87P+KbpGPETtDPWTaVruuCdmHChHfDuem75SiULPgFK2ugxbodPKYYM9tefjC81ehEB+AhQxlxylhTDW/yWMlGKESZ786Kn8u5/GdSyMiQvIs+rjHRtpJ3DrzUjFMGx/Yxz/2aCxxoD/ELH/GZRG5Mdbb9xdtsOzKn4jm8F6UJB9GnGzd/5jsqs4ag9ta7BYT1GHshCY6W3+gUvpptfnXuc+QN8nTVWQ2yIKTT2EEKx6g3eDXtv2hOku8urxeRfrJ+01atM6YuvK63H93LP+Pncw+r87cWkOqf7xTuxOL+3SjeHOKNtY6YHL8UcCx3bBGgtk/N9Iegni8joSM01X5ZkvJYtp3iY4FGFBhINtAhMQDw+dKLFn5aeIQRaSJ59SunRyLQc+fMvrDpdyiKtl2IoKIb97v8VDGoWD9oZu9/wgXnA0222WJHJVEKYotPGzV2CY5Yk5T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB5518.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(38070700021)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWVNMW9zQTdjR0JScitiZjN2VFF5Ui9NSGcrd2NkLzc3cVZVVEVZNTl1RnJw?=
 =?utf-8?B?azUrTDQzTHdBZmM3SUpDa2FQci9ENnFWMG9tR0lVbXdJeURVYVdFdnZnT1p3?=
 =?utf-8?B?ZFNyTlU1bHdpM1Jvb0NjZnJ2a2MvaFRjdnZJZDRDTW9Lam1VV1VsdkxObDFp?=
 =?utf-8?B?clV5ZHVUSERHYVhMVmZodFNSY05IQTFOOFFnNFpZOXI1RkRBOHVqbzI2Ykpu?=
 =?utf-8?B?OExDSXRpRC9jMWhzWUVMWFZIQ2x0QkorYUUrbDRyV01xM1pSajBSOHQ5SDJU?=
 =?utf-8?B?RGVIU2d5ZVlvOURGWGl4UXlwelVna2xwMVBaTFBWWEsvU0NEY0RoR3dUVWZx?=
 =?utf-8?B?cnpoRFJCK0NUT0R4cmhpVWVTSk1oNktIN3Q5S0VDaTdjTkNaZDRKaThQb0dx?=
 =?utf-8?B?Q01tM3dmSFpFSG81cDd1eUF1QXZrb3Q5RmxnTEd4TUxHTzBWQUtyL0thUUdK?=
 =?utf-8?B?dDl1elVHbmlmN2RGVFJyYjl5SDRzZUd3TXlHaUEwbzIxRDZjUjVUdFFjaFpt?=
 =?utf-8?B?dmJIVTZGZFFYTk9sMkpsU0s3M0xsM1UzUU5LOVF0aGdXbENVT3N5eUFoRkh2?=
 =?utf-8?B?STVHN0pVWG1IUW1NbVpIWVEwR0ZyVkpLNUIva3dsSXhsMzB3M3lRaHVsamtF?=
 =?utf-8?B?R2RzU0NLU0Q4L2RSU1BRQW1vZUl5MllhSUVyRnMzMTRlaFc5aHk3Mk94TTFr?=
 =?utf-8?B?czNqWHZrSTdXZUM1czdmS0lnZXp0US9TakhhcWMyTW9DOE5zdkZnRjdnS05G?=
 =?utf-8?B?Ymx6VS9rYnYxSXFrM1hkNnh0QndMZENQNlh6ZmNjc1E4dXNNQ2xSZ21VYk4v?=
 =?utf-8?B?WkhJc1lYN2ZoemVEc1llVDVza3drUXN1VTkzVTRsbWVRSVFUYkQvVGVGOTdj?=
 =?utf-8?B?NlQ4MnVrdkZkYS84UG1iY3hQQlg0elFwWlVJUU96c2lJbkJPQ0pQazl1M3Ru?=
 =?utf-8?B?QldKZitPaFpNMHgxeU1yT1V0cWpvOWhtcGY4TVY2c2h0dUJ5dDZUTzBIOWZo?=
 =?utf-8?B?OFNxQXVKa0tRS1c5dE5WVmZOSUpyRnQ0d3hkRWhJcldGTGw1WEpjaUJJOGFa?=
 =?utf-8?B?ZllZczBFdjUyQjZHSkMrSHdZWUpiYUdyQnZiWnNYMTI3OUI2K2h4cUJ3b1N3?=
 =?utf-8?B?ZXQrSDlwRmNlYWFaemV4TGZnNjBQZ3JIQWl5UmZib1cwOUJDRDJKbjQza0pP?=
 =?utf-8?B?QmFxd2lQWG9KYkxKT1RYVXJwN0xEcGtZdFQzNHFzZG5TTWcza2tHRDRBM04r?=
 =?utf-8?B?M0cySVd0RkZuUmJQd1M0L1FTdVcwTVZOMU9CWkloWDlRL3VzQ1lVT2syb2Rn?=
 =?utf-8?B?YmtyaTZ0OWhIVEVKNTA4eGEwUGZEL2JUVEJ3ZHZLTUgxaGtSUVlmS2Z6MzN0?=
 =?utf-8?B?c2tmdFpCRmVibXoxaGFDR3BCVWRpOWRhdEhOYktKeUcxaktlK0t5bVRBOU90?=
 =?utf-8?B?aEVJcjlEVTVnVW5pT1NqVVVDWjE4VFo3c0xDTndkTVV1NG9KTXUwTVJENU5J?=
 =?utf-8?B?UDJUbFZKQngrYXgrV21mVVdkczd5bEprK1VicXA4UXZPWFhxbjIzWWl3aDNl?=
 =?utf-8?B?VGRSQXhyV1k0WVF5UzlwTXlwSnM1NmhlSStaOFlOekFZUlNaY0d0Mms4VWdF?=
 =?utf-8?B?T0pEWC94bjBFYWpHVUMwT3pQYm1Ccmt6cUR4emplR2VJaStNTzFHc2lyMHdG?=
 =?utf-8?B?dlRuNFlVQ1VaSVBIVytDK2FXTndKTTlzTUJQMEJoWnRQaEhvN1JPdFN3TGhp?=
 =?utf-8?B?SGhGZUdJWnVEZ2p2aUZzNE5GWndnQUlXTUVKNFg4MUhnVzQ3U3FPMUFxMnRS?=
 =?utf-8?B?TDZ3ZmhCMVNXK3FuWHhsRGdsbjEyYjEzMnlGMUR2YmVjencrWWNtYW44VTEw?=
 =?utf-8?B?eThnZ3B4SEhJOElEa1VFMGROKzRlSFJxTG55ejNURkpPTk9OaXliTElTZTU1?=
 =?utf-8?B?cGFld0tnbXVTV1QwRmxYdnRxUHlyYjBCL3pCYS9hOTRSMW1RTWJ1ZkFzZnpi?=
 =?utf-8?B?SUFTOXpBTzlPUUhyVDlXaUo4V2NlMDBQaEpxRkdLaGVNby8zbEM5cEh5dmE2?=
 =?utf-8?B?YUNhVnFPN00yVFYxZWsxTWVEODlqZC85akc2UkdmSWlwRlVkb0YyUytHVGli?=
 =?utf-8?B?NUhZY01MOWhYcVFJL2dxeXl1UFpxOXVJZHViR25IVkVZaVNVWHpoQVBNeXRh?=
 =?utf-8?B?MWtJRCt1UytGaFFBcWtyaG9JYTdsZVFwbW01WE13SWpMZFMwOHc2VEJHcTBu?=
 =?utf-8?B?amZDa2hZZ25oYWdMR0lIQzZaazl5bTM4aWkyaVdGb2wwMmliK0tpNElZN3JR?=
 =?utf-8?B?QjZVT0lMajRlWEM4QTVtdzB5R2hWd0lPUjR0cTd6cmFERWxsa0tpdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B554D3995399134D8A9841BCE632C2A1@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nlZ81mQCjQdmy7Fk9Vp9vYqDVz9YfgDDU9IeTkPiXVx/zGz+55SKcZmicnAO3ICX1MEWeuby5Av+oEBMVzai0qwRU0E3aPXBZ/ymQQJa5+8JOnWT1DMqeCgiGNc0h/nFrf1XHkNSnv2rJv+/J5X9NbeqHO1CTdPxzpHxOI8o1QCP2rHLAVOmU8vf5F4HNywMHvJQ10hDP4+5ToIymKIz1HThwwwzRUpqDOLBvyRzpjfnQxTbCWqIEHt00Xk0YwMZZOAmtebe6usDzTI5tZyQSUtXjgFPAJhvnnuAa4bFSd+eFwS1P/OVUy81kewiFKyhhZ4+hDLRK+gGuIhH3FNb2A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AZIcl7f0yCZTvGG5Z2KEUf8hpYBLxZ902CWBtL+C454WFrKm1cnzyzZ4wK8K7e0KKvCv6u52to3m/a1rrRPY6UDld0bcYN2OnRKpevU1Wq5TPRljpEnN7rtePKUfqf85j+z0OWpBr9KBEVIKnHOaivaQStqGh45V+RfQlpUWIHuCTy0ALnOE1P2NUeGC1vqXD+vMZyxjQPbAH52dIS+h+HweuNbd/Cb4HQEnC9LDleeF71ZhPGM90HUqqqvjZp3+M/MBpzUy6W+xFY/csEDQ5vkaCQ4jLKBPs08/hlwZvBYkBRL3AH/E/svt0OJI/ONH6zcfHZoYKKWHlauTZq3fxb2Kw+j4lLfCr5V76drPBmp4jy7/ZNcshdlY1vNEztfAcJoyzRytW3TXTZhDWHSvEREHG/F+zy60wNwvYkGmbUUvmhWgMuvPjXjPrlIHSf2RGNqKeHXSDrf7y/wVkcgjHnwcfaVYPdPz0ayKJqt1enfUF7tkoILY/QygW2JH1zNWE3OrpD5MQBStrrLahYNty2vwrnIWz7KB1dj6PA5zhar8++fN7CQZffF/5ZkrmJJTW4W7ZGMJZ9jZx9NGqfH8aENBR4NyNtlA6aTTOaZE3wJLbgZYQlU/GPJfdz4v3HA3
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB5518.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a610de6f-c913-4e37-9247-08df04e7f615
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 09:37:22.2245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Za02UZ+pv8AfrwmoxX8LTuVr6odNmxpKPz4rdxeBX2uM+39CX5ediskOggXJNtuzwX/HqjqJpjAB39TLfHlBMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR02MB11111
X-Authority-Analysis: v=2.4 cv=a8YAM0SF c=1 sm=1 tr=0 ts=6a9156d4 cx=c_pps
 a=kkL2Kc6oeAmw00bzYmamMQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=goPkpk6FxlyG6Hy1EQEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8ROWXuuep8xzP7GectIH4lXaQKltfWCR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA4MiBTYWx0ZWRfX214iac29cFUl
 6sw1ztU4NmISveutgGfeuXM84CupBn8+RaeUXt2KJ8vZCNE+KrrYKjPnDdh3ofegNVoVzqVH+7m
 SQAI6TjgQ4kxsEuOCTwUprItAuOGsLU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA4MiBTYWx0ZWRfXzEKT602VseEl
 khX2OGDY1fbz1cNtAV46NarLWlLZB6vxUZGKN1tR/s1DiGcjbPLlb0g1vn2jz+uYEidBDpJYHqG
 9OwT1XCPC0TgxGhZUCnBh/Ko4T3pWopy+td5LvDxMUW5aG6FPxz/q2OxtYNu/4R21A4SbYUC2Q1
 5ZmldGSraSR8HBbK7ovVoDUWvcPhWxt6GjElzZ1oQBqX3oRdtIgoQ9zBWBExNC4395E+IONDCWK
 MitZQONT/hMCMEyOxxDY3Zq7yyGxGo68JdVwUIDfPelYUgranwtyS5dIxi2swGOGcI7XfYW9Y+k
 WtKBH8BdhXG8BfkVIKN9x37k0sYHJzTxD+9a64PvtluL3/EztbhHZYKw0AWq/NiCuW+JUfg6u+Y
 VzYf32SYwFSpUgv150p7/+i/ZZJta9YLOj9hPqlvxRC1iP52X6uiSxn6Ha4yJ5ZV6Vce6+3h+hY
 39w1buWgqNdApv3HIiQ==
X-Proofpoint-GUID: 8ROWXuuep8xzP7GectIH4lXaQKltfWCR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280082
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@qti.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 28 Aug 2026 07:56:03 -0400
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

T24gMjAyNi0wOC0yOCAxMTowNCwgSmFtaW4gTGluIHdyb3RlOg0KDQo+IEphbWluIExpbiAoNCk6
DQo+ICAgIGh3L3VzYi9hc3BlZWQtdWRjOiBBZGQgQVNQRUVEIFVEQyBkZXZpY2UgY29udHJvbGxl
cg0KPiAgICBody91c2IvYXNwZWVkLXVkYzogQWRkIEFTUEVFRCBVREMgZ2FkZ2V0IFVTQiBkZXZp
Y2UNCj4gICAgaHcvdXNiL2FzcGVlZC11ZGM6IEFkZCBwcm9ncmFtbWFibGUgZW5kcG9pbnQgRE1B
IHRyYW5zZmVycw0KDQpQYXRjaGVzIDEtMyBMR1RNIGFsdGhvdWdoIEkgbGVmdCBhIGNvbW1lbnQg
b24gcGF0Y2ggIzIuDQoNCj4gICAgaHcvYXJtL2FzcGVlZF9hc3QyNjAwOiBXaXJlIHVwIHRoZSBV
REMNCg==

