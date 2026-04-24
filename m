Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AC8FED3EF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGJuz-0000UC-Gq; Fri, 24 Apr 2026 13:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wGJuu-0000Sz-Qg; Fri, 24 Apr 2026 13:02:12 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1wGJut-0001eW-6b; Fri, 24 Apr 2026 13:02:12 -0400
Received: from pps.filterd (m0409408.ppops.net [127.0.0.1])
 by m0409408.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 63O8xe0g1810266; Fri, 24 Apr 2026 18:02:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :message-id:mime-version:subject:to; s=jan2016.eng; bh=S6RP3jI5v
 q/79xFbbtUgHIQXqR0Y9eaLr5aZtlwRlJY=; b=V/TODus0LeIxCCWVI+9nZfEn+
 hTmIZQ4Sa4S1NOKw3iZSMbQszi7IixVLMze+QMFYfLoxr/JBOzG0fLEzxN57vyG+
 AzHrtR5i2FMliEe+KSjKIbbzJIXOxkmO76jlvWk9dWpEM+yZrn15c2BEvBekQKds
 CHlx78kyJ3uZh+zLAKDT+UL1KkvpFROeN1t9qVZ9vXAHFyZnv+0xyUYKMGXev2Fq
 SDvb2JSN0xXmFKGP3yTRGtVqs/FwuZFF+J1+ZIFxEdzXSYwt6M7xy9WutNgWuDIS
 VbqGYinSsC2T1rVvvQHIdKtDK0ZCMeYQgO6sxvjBwB8mYemzAUJtqwlNphgcA==
Received: from prod-mail-ppoint3
 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be
 forged))
 by m0409408.ppops.net-00190b01. (PPS) with ESMTPS id 4dpvbjrujh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 18:02:05 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
 by prod-mail-ppoint3.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id
 63OGfvIp003132; Fri, 24 Apr 2026 13:02:04 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 4dpjg60pm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 13:02:04 -0400 (EDT)
Received: from ustx2ex-dag4mb6.msg.corp.akamai.com (172.27.50.205) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 24 Apr 2026 10:02:03 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb6.msg.corp.akamai.com (172.27.50.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 24 Apr 2026 10:02:03 -0700
Received: from CH4PR07CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 24 Apr 2026 12:02:03 -0500
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by IA1PR17MB6196.namprd17.prod.outlook.com (2603:10b6:208:3a0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 17:02:01 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::9e2e:cabd:1b09:bab%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 17:02:00 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: "mjt@tls.msk.ru" <mjt@tls.msk.ru>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "qemu-stable@nongnu.org"
 <qemu-stable@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zhivich, Michael"
 <mzhivich@akamai.com>, "Hunt, Joshua" <johunt@akamai.com>
Subject: qemu stable process questions
Thread-Topic: qemu stable process questions
Thread-Index: AQHc1AwRb+1ByKdD1Um30qkGP0GOrQ==
Date: Fri, 24 Apr 2026 17:02:00 +0000
Message-ID: <9C918929-E60B-4298-84A3-0B9C2F7E399F@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.106.26021521
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|IA1PR17MB6196:EE_
x-ms-office365-filtering-correlation-id: 27029141-ccce-40e8-9229-08dea22333a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: vUUZs0k8XOfByGoJDhlZYfMTk0GyQJmqGCst4xbztpf6h5gpmqVr4xBlyW2atIYeG36ZKL2XU8TG3x7Nhaa8r0r8J7GWfO012j6QK+szEe0eQuxnhjJYHfrsAsXe6ECoJOTby/scHPyHRgbptRu12Y7bKkj0GybCAmvZV9EGwq60ItZBwNBfVmvhC/ADc80etaBAItRew5ah4yDKkiOdPcc0A3MlELLUXNYreKpwDQL1KWOnUy5hQxd0ZHn2uIq+N96Nh1z0PUIUKGtk5HzK+oVvMp0K/QcSsq6ZI9YiCDqxyaV/C8AUy+tBgPL8dv0+Q+KLkwU1WxyBe8TxPvWt3fc6G6R4/RrNWOML2Ebhgo923g2lObtgvKvZKIvNX+sTQVKOPEiWKOZR1wN8VBB6CDklpZyFN5sb/UuMejyS31bTSCJ+N/7QJQ3wTagDiwfM01lsxx2Kc+bBTD+sERdCXgAHhXT3z53JBzkSobf+qRmkCZUPScp6z9bErecxlZE/CYaSd/SR/A32ezti6kmjhbLaoNAPkUseEIeodJVYy5ChmNz6HA8iriIIWy3kbD3aNa28rgmJf8NIZ/4G686G6o2AhUNAxA2MJxNPz24MkEJy4Km0l13QXU9QJ3IZM0CB/YKg/lji9s/dKlVXcs3s7tk6Z0NnC9ruH+IDZCA8kLVvxRw1d5grR1YvaF+dHip9bNKR4GcvVW00Faw5ByetrzB84/JHOmE6dK6gWShavddYO1RdFo5AzwUN3c0nK1RIG1lb6qZFxvXyPcA/mZ78cbX+qkQDPqutHUe9YNo0kiA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3Evc1IzRVV1RzRRSnAwL25zeEVQTTF0WWk3S2dHdHd1RmF6cjlSOWxXOFp0?=
 =?utf-8?B?SzZWN2JTRHlCcS83dEhYaUpnUG4vRUl3QldnUWxwZmhweUR3aUQ4QTFGTU1K?=
 =?utf-8?B?VHM2ZklVNGNSMVNoUFJOMEZ4bkE0ZXEyV1A0ejJKamZuY3hqVjhRSjllb1I3?=
 =?utf-8?B?bHB0c2hYMlZ1c1UyalVZbGh1bW9mRHNCREJmUTYrdEh6MWNFRkk5WW1kQ0xV?=
 =?utf-8?B?ekFmYUhYZ21rY3lTOUIvRlpDZXpIUlJEOEVnUHZIOHI1cko3dmlzelNoN3lV?=
 =?utf-8?B?cjltUmw0dDBsQ05XUnNDN2xGb3A3ZzNBNTk0ejVocDAwaGwwc2NQdVRyTFlN?=
 =?utf-8?B?czhsM3F3OVA2Z3FZYXpiWWlvVmVER2VxcmlaVzMycUFPSTVrSExXWkwrS0Fx?=
 =?utf-8?B?dy9WcHdqc2hNYjN3dThud2JURWZLaWlUTHpZVXpudWxMZ0xsdTVqMWN4VEdF?=
 =?utf-8?B?NmVTQklES3dCZG9VZy93ZEtldG9GNUlQc3hnbnM5cmVENXQzKzZkZm9BQUlT?=
 =?utf-8?B?ZThVRm1DUmY2cHhzV2NlaWFFTWlHWWg2S2VtVUo5Yk5Jc3M3NXNWbUhoZTBP?=
 =?utf-8?B?SWZWMFFtVmNpa2RYTTNySXkrem4veERObnNsbFNtWUZ3UEpIbnZQMU5mNGpx?=
 =?utf-8?B?Y1E0VmlBTGh0ZWltaHNNS2FWUk01ME5HUCtZMGV1NndSajg2aENQRHF5aFo0?=
 =?utf-8?B?QWlTV3NueENIcjdDZFMyNFFWb05hUXZjbkUzUFBnWk9PUEthTS9URWFNRUZO?=
 =?utf-8?B?SjB1RVc3NHEyWDNuTk9hMDJDT0FUUXlVL1ZVUTBPVkhUTkZLK0QzVUp6YS8v?=
 =?utf-8?B?Ynh3aWZrakRCUU9VcUM4UjZQSGVwV0Jhc0YrYXZtTkVPZDJqeDBPNjdJdzZ0?=
 =?utf-8?B?QWtJZ1J4Z1I4NFM1UXlTdzF4T2NzdDVRVWhyTDh3UUt5M3ZESCs5QTVZZFJv?=
 =?utf-8?B?Nmg0czdOV0RuVmRLVjRSV3JBQ3pvWkpmczlCaWQ5S2ltTEUxd1VndE9ZTXV1?=
 =?utf-8?B?OXI5VklMdXpRWnp3YUtzVzNJdUpwRHFodi9HbU42ZzN2WTZiVVU2Ykw1aXla?=
 =?utf-8?B?WitHai9qTDFXZGpKSW41WDE2QS96U3NLZGlaWkthNFJCR1JUdjA4NUNKS2Ux?=
 =?utf-8?B?aEYwTVRXbjlVM1NLRUc3Y1NZQ2c2RTcyMG12YnNiUWkrUVp6VXU0UW81SFNQ?=
 =?utf-8?B?UmVZaFFTY2ZPKy9mUW5WT0xocGt2OXRhZlhQVFhDYklpcFI3SnlUQzFNNWRm?=
 =?utf-8?B?ODdqNGtBVmx0Um5lbGlPbm9iK3ZqMlRaeHp1SEI4aE9JaU1kRThUSjdHOUsx?=
 =?utf-8?B?WEw2OUpOME1CVWpTaXVVREMrK2xFQ0poS1BHVC9NU2wwOXNnZzhNWlVZYmk3?=
 =?utf-8?B?VGVvbVQ5MkM5YWpiWmFBWERsbE9yYXNncDJqQTBnWTI0b1IwMmVhVm1XSXFr?=
 =?utf-8?B?N3lQcnQwTGVkM1p0ZTNKdjE2WWN0SmNZWUZTR2ZRZTBKSHlYTjBXNTRHempw?=
 =?utf-8?B?L3lmbkdtcHBZOFRYNVVVZzI2MjdtU0NXR3V4WWlwaHpJU1BSUWdNTWdoaGRP?=
 =?utf-8?B?VHcxZXlvYmxhanVBSHczVG5NaldzWDRKdmlTRUhqRmNENkJObVFMYkZ0dWNZ?=
 =?utf-8?B?TTRrbkhYQzJETGpWYjdIalV1cE9ja0RqVENnSFordFZhTVZkOTMreXhQblFN?=
 =?utf-8?B?cWFCOE1NNnBKRWdaOUdiM01lTWRnQjQzL2hNUXV4aTJOV095aUQvamw5U0lk?=
 =?utf-8?B?dDJmWHRaSEhiOWJTU3V5OWdITzJ6U014SlBoSksxZlJRZnBVZko0SXhkWlIr?=
 =?utf-8?B?Q3dJdnVNTlBTSW1TMElmN3dEUERvNTFoZCtUMm0yTC9CQXVOaDM2WHNMN1Np?=
 =?utf-8?B?cytJaDA1aWUxSjE4aVdqTTdwYU5IcFViY0hIVVhOMTFVZVp4K1gwM0lNWG5I?=
 =?utf-8?B?MHpRYjVzd1pPQUI4QnZRVnJvZDVGVHd1cUxlRDc5alZKNFJ5NWY2ZkZtZTJj?=
 =?utf-8?B?WlJDZHFVK2lEM2w1Y3AwVFM4VVh0cklub2lrMXlmTXRMYzl0cngzR3N5S3di?=
 =?utf-8?B?NlZCb2VzT0ZtWG5EaGwwUTlIa3QzTHNBcVNFT2g4MGRNNlZ3T1hKS1FCNUpD?=
 =?utf-8?B?b1dNYTZnN1JPcjFqL0tublczYk1zd2ZQT25leGJyTEZod3V2WHp3aXdRTEd4?=
 =?utf-8?B?bmRHZkV3TTFVTC9rekdmTEN5Q1dRbGRtY1pDeTROZDBkbGlPTEdMUW04QWxx?=
 =?utf-8?B?b05Jd0gyUzZKRGtKellOZUt1MGM2NVZCVWlwdFBiYW0rM2xiZi9EZ2ZsK2hD?=
 =?utf-8?B?ajRTV3k1bnlKejBOWWhpVTE1cmhMblVtaHVxQ25qbVR5elVqMTk5M0NwWSta?=
 =?utf-8?Q?6nHbzASYHT04Dna8FGZkQux0X99P4RMO2+UBKxPDNkUGR?=
x-ms-exchange-antispam-messagedata-1: dTz1+7TCmE8zow==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zy9SRdsfD5qRrpGJjsG5shzN5cXuEtNXYIhehoikWKTEmQVvZy2mMSVRyQXMRuC4qIRNjnkclTBVhohAnMkWxCiuztN+ZNNgBnv/enAe1pngT0rDWiCwvwT1vVpCD6/yziYHK3ZybhCVvV3HGvlo86gay+CwmiPoLzqQ4CANT8+5CDGGA7omPIDC075xB3bRpl05eFg6MkWYvG5lC9xXDbXiFs6UiMBm7OcVZR0Cujqk//NRZpJKkDfXGszNRn+zluJ29hyP6REE+Yf/4bH2OalRHVjX01gBGT4eLN4LRg6wWrZF9dwQEpuciDy5YfeYR7q3L0RWveXo5NmdsZxfcA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar+MSc15hfQkTnlSEUZwkKnMBZP26l1rEUyTF9snT4o=;
 b=cME2deCQ3J5q0I/b3qOCJlBbGHYhD9yIKXpjlaLLJa0J08UI6cDcRiUPqCHtsLCIrkYuTjgmatnPFAAg9dXEVe8j1HKHG+p8aWE1ixUwj08wfKe4KvU3PFKrTSjUtHH2gmvH4OBlWW7MFeufgiRY01HVBpCjJF1okjEHJGSYwbDoTAmBVphoP2arbcnARA3v/fRZuGH4Pd4DLBrWlZ4W34WYMc0aRZ5En0fYZ8KUSciAolNbatwIR4GY+TV29EIZVSjegD6tEXksRuZiuV0e5reeo1Reu0AH4gS9xJ6Ts4t00P1wCmT7znS40Gd4D64g5ssc2kaLgXP2s0xflqCZ8Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: lo1o3utakWBCDuFb9fOZg0cU9IAYmVCtEM8tQoLQqv6430THptZyG+w82zICxFH5GGJiQzwEHNZ9QozPo3HePNO/l32k80m5k1qsgcN5YW41ECP1KLhrB0ixk9R4dp4pwVxIYKUvejRvh6Pb8mdIPqGs9zDkHcw0pyGuFgtRhRAFawAE3/BaYWLsSOi6mQ1E/Vb4jkJNs/2lhNYT0bAHkLT0EQOZJq/8aR3NUkYeFjcAne0pp157EBmtEXH3gREgEa9u82RoiUkm6ylCQ4vV50iY/twshxKvseGLSwrTYKN1MKp+Cu7DuIbj13HImPjRvgT4Y5Wxftb5i/m/UT7QNA==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 27029141-ccce-40e8-9229-08dea22333a7
x-ms-exchange-crosstenant-originalarrivaltime: 24 Apr 2026 17:02:00.6939 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: dnQr9CAkR6PUp89vjm2FwIEO5so4mYllvjB7juZCUhar7oE4+lXO6TM2ee4MxMAK0rIA7KmOKCco2VAI0EPTPg==
x-ms-exchange-transport-crosstenantheadersstamped: IA1PR17MB6196
Content-Type: text/plain; charset="utf-8"
Content-ID: <A263B84B6DEF18408FD3708BE2C23F30@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=759 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2604240162
X-Authority-Analysis: v=2.4 cv=RPuD2Yi+ c=1 sm=1 tr=0 ts=69eba20d cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22
 a=BYUV7c42er6_Rx9bq0XK:22 a=Vr6tuaZLnnQgMxs4WjsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OHFimfe-XzmdftAdFAv6BjHaHexOhg2m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE2NiBTYWx0ZWRfX2CtlzRBrp6v5
 +egk0jDH6D5L0IX3ERZi5dlVr/uMKAj9J2kyprOTqvtVXWhtA7JEwqbuXkVUUUH6q4G3hans5ZK
 5q9ebkeP1Rn5EBjRBRfH3w9U1nnjMXkPI3mSjzfAoHmlwtRXJ3fAzeDSjB1VaK2oZ8xw2Mi+vgr
 sqapQ6DNxK/2Ku6fuz+PrL7YxWlKu52GYPCSrdmLQd21OrYpyC4A01kK1Dz3XQNqo2YD6y1r2qp
 ToAszQUJcCntNhqNMjRPNcVCQDdvT+uxJD3lAN9OcHwZI/u88wUW9EIu6fozUQn6mZs+CxM/kqk
 aKLXly829k2L6nfBskrKakmyuwWkDZhngni9rRFpPGZvSc8zZUoManTuLBBzJKkmbFe2KgBK6Et
 /208759omGDnAGO21z6MLZWZhoJMcVkBm95IZ/Ts5H+h1Q7dH8rFEcDWjIGT/dyeaUh0gjiSn1u
 dhy2aRlZ67uNL4hKWBQ==
X-Proofpoint-ORIG-GUID: OHFimfe-XzmdftAdFAv6BjHaHexOhg2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240166
Received-SPF: pass client-ip=67.231.149.131; envelope-from=bchaney@akamai.com;
 helo=mx0a-00190b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGVsbG8sDQogICAgICAgIEknbSB0cnlpbmcgdG8gYmV0dGVyIHVuZGVyc3RhbmQgdGhlIGxpZmVj
eWNsZSBvZiB0aGUgcWVtdSBzdGFibGUgYnJhbmNoZXMuDQoNCiAgICAgICAgSXMgdGhlcmUgYW4g
b2ZmaWNpYWwgc2NoZWR1bGUgZm9yIHdoZW4gZWFjaCByZWxlYXNlIGdvZXMgRU9MPyBDdXJyZW50
bHkgdGhlIG9ubHkgaW5kaWNhdGlvbiBJIGNhbiBmaW5kIHRoYXQgYSBzdGFibGUgYnJhbmNoIGlz
IEVPTCBpcyBvbiB0aGUgcGxhbm5pbmcgcGFnZSBmb3IgdGhhdCByZWxlYXNlLCBidXQgdGhpcyBv
bmx5IHNob3dzIHVwIGFmdGVyIHRoZSBmYWN0Lg0KDQogICAgICAgIERvIGFsbCBzdGFibGUgYnJh
bmNoZXMgaGF2ZSB0aGUgc2FtZSBsZW5ndGggb2Ygc3VwcG9ydD8gSW4gdGhlIHBhc3QsIHFlbXUt
Ny4yIGhhZCBhIGxvbmdlciBzdXBwb3J0IGN5Y2xlLiBXaWxsIGFueSBjdXJyZW50IG9yIGZ1dHVy
ZSBicmFuY2hlcyBoYXZlIHRoYXQgbG9uZ2VyIGN5Y2xlIG5vdyB0aGF0IDcuMiBoYXMgYmVlbiBy
ZXRpcmVkPw0KDQpUaGFuayB5b3UsDQogICAgICAgIEJlbg0KDQo=

