Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CEEC25B5C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YOO-0004SO-Ax; Thu, 02 May 2024 11:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YO5-0004EF-6S
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:30:24 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNt-0005ys-QA
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663809; x=1746199809;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+UqGxNkmEEVK9qOUIr81H5+0nzmF7R37bpPM1v81DI0=;
 b=dDZywA9dgOl4Y29stv6ExFskigt8htP6GnBy/d5iK7NIMhrkwQ9m2sqk
 gv9QaF4jhnGfWHODP2DCilb7TrOaha5eqyO3PxdBx2G9vzqUSxMfN4PhD
 NkvlOcSAuG1WwXHkVVaU636CRGJ3uS1ucxJP6uQWBU2gK68DyoOryQG2u
 1l5XSpkra1HVZ/mGLO84k1Hl6B9i2pxc8cWUvwFZc+QPjsoW10TrwMcZ2
 T2mz/XtaEvo4iNTiprb8GRzptu8hSF6t0Wy7OzYS3gH6FZtEpGokYrjSR
 8UK/eUGWDUsV0ObXFnymqiYrKm6qKTKPYy35/oVNSJbRZI0FjPUqwWtS2 A==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785888"
X-MGA-submission: =?us-ascii?q?MDGLwFYRyRSZnQWf8tLjkjOymNtqXk/1rh0DYS?=
 =?us-ascii?q?rjB6salSYBs8ONmvj33F4B6+2p0OmE6Z4qIXgZ58ZNoaOoydT+RovQme?=
 =?us-ascii?q?n+P8uVh0+VwhM2BLQchPL61xEBznbyh6mvE+08ktWANTazvgBsrym+EX?=
 =?us-ascii?q?y/B5mUd+8bJl0ace9xP7wEag=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:23 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAtC6Pxg45LAQ9kUh+TF24As8CKhDgBAjC5MylKvzkPIw6tahBbhgxTe6Ziu2RhR+1kcFGgZ34ZILzEEVy6I49ICO2AAax8Iu60dctK6sJqUlVw3T/cNs4CKRXOFWJhN0wvj+VYsQkzrXE2+/Qg3H+XLut5pU9jUGs3gDOX50HYyhathHgf7vpnUrOAa/sENxu0DE5A+JyEXtt/eAdTyI9rsOf5GAp0iA046gu9AJNNT2rmsH7wQQC5/SbYJB5xnBZsUUeb+cjsvZQ83lf+c139EMuVnJW6ToAto5t8aBK5yEJnEeSWzVzceNDd4oBr5nxZPoZAtuDOyjBJzS89x2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UqGxNkmEEVK9qOUIr81H5+0nzmF7R37bpPM1v81DI0=;
 b=IPAVQQhn3aTLGZEjm+VGK7e/o9QQ/T9WzJx7gNA4X4bcEGTjHXG4A1Fg86Z/qjpPPyIqDAaSJkg+qVFX1TrCMK2nvHeIvWlqKcS3dfnCgC0rR+GhlpUEUqMBpMJP9Gamg3STxh1oo2E5T5nReIutYjha3g10f1eU/R7D4AqiPwmRoF4C0cPrvqD/tTgwTfNUxRrhRZnmNsBy9xN26Y2PcnbgUdcnZLnqI8jJeAahG3501uUQvMkqAKtGUMqNHFWAEL/K8o8aB0Cxxa97PMVAxbAYWgXvBSC/1R8CWYCycvoq/THHF3H8ArctTzlRfsC33PTePphRMvXIQni8p1C3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:19 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:19 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 14/24] pci: add IOMMU operations to get address
 spaces and memory regions with PASID
Thread-Topic: [PATCH ats_vtd v1 14/24] pci: add IOMMU operations to get
 address spaces and memory regions with PASID
Thread-Index: AQHanKWAsBsGY5rV/UyOtoHHEEzYSw==
Date: Thu, 2 May 2024 15:29:19 +0000
Message-ID: <20240502152810.187492-15-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9661:EE_
x-ms-office365-filtering-correlation-id: f8641a4a-ed32-4d9a-3bd7-08dc6abca2e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?emJUaEFrWWhuN1ZXUEMxMldMdGhTUXFjeDJNaGYyb3RZWDUwZVJiOHB3ZWpj?=
 =?utf-8?B?cGQzQ3Q5b3JEVE1vRmFzcTM1cGxTcUpXaUJEOU5aUjVhUzBSd1I0aUtIR2l5?=
 =?utf-8?B?T010R0dQZkJpQm5iU3Bkb0d6UmdCTmtXQTB6bEJ5UlJDSUg2c01zeDcrNFh0?=
 =?utf-8?B?cXpJYmxtVTFTa1NTcnRyN202VjYvbkM1S2RONG44VjZwc1dmbSt3K2pxZmtZ?=
 =?utf-8?B?QU5QM05CVDRKZUlZd0duZkxUNjFJRWVMYzcySy9zMVVxcmFaRFAvVXRHazZ0?=
 =?utf-8?B?N0doNUhQZG42cmFLNmhqQnpOMzNUUjM0aytpM1l2d21FMkhWRE9yTkFGSmd3?=
 =?utf-8?B?TjJWOVQyOEErcGxhZDFZU2VVNndwYWJNZTZHL1NLcGM0Y2lENlNNVE9zcWR6?=
 =?utf-8?B?cGlPMGI0Z3lsVFdXa0FhQ3VZdVp5QnlPWTRtWm9kS1JpWS9vMkdpZG9Yd3Ez?=
 =?utf-8?B?REN0a1dKVkxFcXZVVnNJTXdYa0hYRTl4V3JyK0ZTT1A4RmJHUzBqTDRxQ2Iw?=
 =?utf-8?B?MFNqSXRjS2FiZTk2d3g0V0lITHgzRXY3Wnk4WHlwRkpBRnFwUUdhTDNmZGZn?=
 =?utf-8?B?RHhjb0ovZCtTL3FKcDdjVlEwK2Q2UStBOXlUYlFOUkY0dnZuMzNWb2w2QVVK?=
 =?utf-8?B?V2Z3T1RsVjd0ejJjSzVrazhUSjl0OXhYY1RSbitYbzJ0bU4rS2ZyZnlWL3ht?=
 =?utf-8?B?SHZnd1JFRzkzWmR4VExlMDF3VjZkeVRldDBXRDJuM1Y5ajVOT3VZY0E4b2M2?=
 =?utf-8?B?OUVIZnQ5SEFWS2xzYTRpZmFBSE10TmhaREk3elVlSE8rbFVmOUFmd05SVzR0?=
 =?utf-8?B?WS90VWJ1TEJoSzFkMEpzOGl5UFQ0c3JlZ05BcGg3c3A3VGswUEszTWN0cGlS?=
 =?utf-8?B?RlcwNWtaSVU2cjFUQnpnUlhmVGNiOUk3eEpyUlM4MGNzUDIyM3hnMmhGZFl2?=
 =?utf-8?B?T242Uk56R01WeFdKMDUyem1LMjN3SXJuVzhsdGtkd0hRU3JmZFVPd3Fyck8r?=
 =?utf-8?B?UTZNTzk0elFVYVFIQ1JObkVic1ovNkR1dzNIeHZWKzlSMUlHTGhUTjBmTmdE?=
 =?utf-8?B?SWRqWmszS3pPWUtxaTlCaHk0ZzRxZldqTTd4TmE4aUkwZGNIUG5sVjNOMzJa?=
 =?utf-8?B?V25nMzd3Y1hVU0tXSVJ0N2gwTkNCSG9xNmRHQmJOOWx5VDZTbnFGV0ZHKzFi?=
 =?utf-8?B?dG9hTTNVc2RQSEJsQnY3cVJiMUpxdkdMQjloS2lpQlN3WllrZ29nanFFVkc5?=
 =?utf-8?B?WWxaSzBYSnpHaEVZdnh4UDNFT0hOR05yTlhYV2tOYjZXeXQ2ZE0zZm5ya3p6?=
 =?utf-8?B?RzdRbkpDR2lNY3V0dVYzc0syb2RPN1BqMm1xMWF5RWhRL05OWldITnZZdDQ5?=
 =?utf-8?B?eTFwYUVwekx1N0hkSzRGTjRSb3dFcHA2dXBhejkrczhJMHZqQmY1cVZyY1FY?=
 =?utf-8?B?NThWa0pSK2lsQWdIR3VCZGFNWWNjUXNlN3FIcmVBaVFKV2pOdWZsNlQ2eDQz?=
 =?utf-8?B?czNlTEU5UTJ0Z2FiR1Y1YWZtWERkUjVJdW9uMUMrNEp6VHlaclB1R3hENVFD?=
 =?utf-8?B?ZmUvRFlDcUFUUDhtV1RZbjQ4RTVnS3l3cnZ2bmZVYmlDQ1hCOG4rQm1yMGY4?=
 =?utf-8?B?djZMbURWVlBXanNtY3BsR2N2S08zcFREQVJ6T29mWXNjMWN5MDRvTVdPUi9y?=
 =?utf-8?B?dlk2eCtweHliQWl3QzRtUW5hT1gvMVp6SUY0b2tKMnZHT1lQV1BtcXVDUHlY?=
 =?utf-8?B?bnl1TU40NktEdGVDbjJnK0UyWlZkclpjeGlxZFZRcjlxTTUyN3Fia0tDVFkx?=
 =?utf-8?B?dzA1VjVML3k2Y3ErTDVqdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3ArSWxiTTQrdjExVjlsNWRGM0xuaU1PN1hBWTd0cktoRURXSWhjbER1VDJM?=
 =?utf-8?B?TUN5R2xtck0xdG9iS2FTZ3NINFNEbUpERzVBcnptV0sydGltSGpiLy9Ma0hx?=
 =?utf-8?B?TzRMMWthTGY1L1VtUG1DajlkNnB2OGVTelRFOFFVTFdwUEp4ZCtrS1g4T0sr?=
 =?utf-8?B?ZHgzZDNWck5ZZ1YxQkJxVlc1SGw1bW8zK3pnaHh1UTdwSkt4elNSNElKeGxv?=
 =?utf-8?B?MEhubE9iN1dORHd6aGxJak83MnF4blpiNHNEV2R2QlNqSkU4SXQ4OElhR0hV?=
 =?utf-8?B?eGxWWHdZenNwMEFYUVBBUGQyMGZvZkt6Q0F2SmFSTE94NzNUZjArd2xHYlcz?=
 =?utf-8?B?TTNyck10UjJqQjNpRGtudUhORnIrZTdzeTFLN05EZ0JuUWpLRTg5dThMQ2wx?=
 =?utf-8?B?SVhxeGNJMm1DTVpONlRSTjhGNm9HZGVDejl5TFZPR01ielVsRDVpdzdmTDZs?=
 =?utf-8?B?QTZ5TVJJczNKdkNRU2Jkamt4bXlHOTloSjkxVzkrQjVjSHdjSUFnb3dTcE16?=
 =?utf-8?B?NGcxOTJ2Mis5cWliR3Q2djE5dHdLL2FINThNRE5EWlo2WU80VEFMeUZKMkVG?=
 =?utf-8?B?dy9zUUg3Y2pSeEFKY29tQytkNUNrSEM1Ky91ODRNcmwxRW5RUWJtY3RpN0pk?=
 =?utf-8?B?a2N2aW1qWUVzV1g3UjF4aGNFZkx3U2djbjQ3eVpYK2tPcityaWEyWFRKaUlq?=
 =?utf-8?B?dWpMTjgybDVGMlVQYzBqcGQ3TDlJWXdRY1NjaFdSeERRd2Jxejl6MXdSME05?=
 =?utf-8?B?SklwQ2xVa3B5NGZvMHNJTk0wRlFqSnByVDRaL0RjenJXQVBxbEVGdU1teENq?=
 =?utf-8?B?YURhM2NFdlVRYkZlcnh3SnRmcXJ6bkdFNDJFdlp0QXRFMFZZSFFTeFhiZ2J2?=
 =?utf-8?B?WlpReENjdUNGUTdQRk9uMjNoajZaVXpUK0JsOXVrK0RVeDRCbGtTVFpKelEw?=
 =?utf-8?B?dUV2dEhkVE4xMUdZTGs1VEo0YVBDTTFWRnNDU2tNaVBLb29kU2VvaWFqdUJS?=
 =?utf-8?B?QzZuVkd5LzNLbDBGNENoWVM4OFA3OHdkcElQMVhkdHJxTTYwM0pUQlNnbHp3?=
 =?utf-8?B?UkFVSWlNQURMYWlWYWZiWTNHWFJiZkxPSVh3SEdLcDIrSVd1WmR6WnJ5LzFB?=
 =?utf-8?B?MlhFZkM2OGdvUHNEZzBmMU5yditxVng3bVE1bDQyaFFlUDdJeWUyb2NPUUgv?=
 =?utf-8?B?NTVGb2VZNUVhaHpCSTAwcE1lTnlCQTczZkNqVDA2YS9LTW92VENGYklwTkZT?=
 =?utf-8?B?NEpaOEJRbHYrTSs2RHp1blpXdzVPb0VhSjNEZkE0MmNtWTZ5bnVSYlh6MFV5?=
 =?utf-8?B?WXFleE5GTHBwNi9ta1E1d05neGdEc283NlJadUVDckR1YnBxenY1cDhGeGZl?=
 =?utf-8?B?R2xkRUdjSS9oSExWOVB1REFjMGp4VTZ0WGlLa2dwSjAzZHRXcUl5S0s1dng1?=
 =?utf-8?B?Ri9oNTFOTEFRRnVIOHNIdy9zQU93VThjcS80czB2VHVRRzUvTVdsVVQ1QVBt?=
 =?utf-8?B?NWJZU3UxQWdvYUhuYUM5UVNlSHBpcUZwOXhieGc1YnlkVmQwYkZrOC80bmkz?=
 =?utf-8?B?U1MybjFaelFFUWNJY0MrL0M0Wlk4aW0wSHlqQ1JiWTlPZWo0RW1RbHBTbEEr?=
 =?utf-8?B?NVArYy90b1A4aVRJSjZYc284bTA4WHpzUEQ0NEt5aDN0NG85QlNnU0czb3VI?=
 =?utf-8?B?WDBnS1l6M2x6UlJCZ3dnOE9LQ3NlejR6UHRCeWFaRVVCTGx1Mm5FM1BCMkFt?=
 =?utf-8?B?Zm1LVVZiWThwdWZMKzlLUU14VzMrdzRsN0QrbllCb3JqNWNxNXlzWGhNL0th?=
 =?utf-8?B?QVFQZG1UaThOc0tDM2RxVUdRMTZlN3pGL3NrOGMyNGVPVHRFMjBvS1JMVWg5?=
 =?utf-8?B?bDBlZE1mQSszRlIzeGpYZW5VazBXbjloZEhvNDZqQjFoejh2d2FTeHBWY0F5?=
 =?utf-8?B?UkxPdTc5MDUrRkZiWFBxL1BRU2M0YVZBOURHQkh1M3d0NGo4YjhackRUdnpp?=
 =?utf-8?B?NG9nNmIxYVFYVWF3ZG13VTVXdFViZUY1UnBwdHBFODlMT2paSUI5WGhrWi9M?=
 =?utf-8?B?anluVWRQYWlDRkJOOFQ0dUQ2NVR0QkdBaDhTbzhaSDJXay9ndHVXd1hKNkYr?=
 =?utf-8?B?a3A3L0dDR045djNLMi9WM1BueCs2eVdEUjh5Y0JBY0VnZFk1aWhFSUdlWVhY?=
 =?utf-8?Q?3PEcAQn0WqIZwkwDftiTVfE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCF2DC3AD7026D4D957D86ED7C1B15C3@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8641a4a-ed32-4d9a-3bd7-08dc6abca2e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:19.8588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYVUGmHRwXIdlTHFwvTWOH0J+BzrWmkaqy0plkezD+zdTRODVq7Uk5hRDAKP6bTw61dBh82Jb0iVQ49vB0gRWPc36GxapavZ3xGkw/FIE+k8y12gX0fbLm1I9GjpV4ja
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9661
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9wY2kvcGNpLmMgICAgICAgICB8IDIwICsrKysrKysr
KysrKysrKysrKysrDQogaW5jbHVkZS9ody9wY2kvcGNpLmggfCAzNCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspDQoN
CmRpZmYgLS1naXQgYS9ody9wY2kvcGNpLmMgYi9ody9wY2kvcGNpLmMNCmluZGV4IGU1ZjcyZjlm
MWQuLjllZDc4OGM5NWQgMTAwNjQ0DQotLS0gYS9ody9wY2kvcGNpLmMNCisrKyBiL2h3L3BjaS9w
Y2kuYw0KQEAgLTI3NDcsNiArMjc0NywyNiBAQCBBZGRyZXNzU3BhY2UgKnBjaV9kZXZpY2VfaW9t
bXVfYWRkcmVzc19zcGFjZShQQ0lEZXZpY2UgKmRldikNCiAgICAgcmV0dXJuICZhZGRyZXNzX3Nw
YWNlX21lbW9yeTsNCiB9DQogDQorQWRkcmVzc1NwYWNlICpwY2lfZGV2aWNlX2lvbW11X2FkZHJl
c3Nfc3BhY2VfcGFzaWQoUENJRGV2aWNlICpkZXYsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQpDQorew0KKyAgICBQQ0lC
dXMgKmJ1czsNCisgICAgUENJQnVzICppb21tdV9idXM7DQorICAgIGludCBkZXZmbjsNCisNCisg
ICAgaWYgKCFkZXYtPmlzX21hc3RlciB8fCAhcGNpZV9wYXNpZF9lbmFibGVkKGRldikgfHwgcGFz
aWQgPT0gUENJX05PX1BBU0lEKSB7DQorICAgICAgICByZXR1cm4gTlVMTDsNCisgICAgfQ0KKw0K
KyAgICBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oZGV2LCAmYnVzLCAmaW9tbXVfYnVz
LCAmZGV2Zm4pOw0KKyAgICBpZiAoIXBjaV9idXNfYnlwYXNzX2lvbW11KGJ1cykgJiYgaW9tbXVf
YnVzLT5pb21tdV9vcHMgJiYNCisgICAgICAgICAgICBpb21tdV9idXMtPmlvbW11X29wcy0+Z2V0
X2FkZHJlc3Nfc3BhY2VfcGFzaWQpIHsNCisgICAgICAgIHJldHVybiBpb21tdV9idXMtPmlvbW11
X29wcy0+Z2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQoYnVzLA0KKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGlvbW11X2J1cy0+aW9tbXVfb3BhcXVlLCBkZXZmbiwgcGFzaWQpOw0K
KyAgICB9DQorICAgIHJldHVybiBOVUxMOw0KK30NCisNCiBpbnQgcGNpX2RldmljZV9zZXRfaW9t
bXVfZGV2aWNlKFBDSURldmljZSAqZGV2LCBIb3N0SU9NTVVEZXZpY2UgKmhpb2QsDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQogew0KZGlmZiAtLWdpdCBh
L2luY2x1ZGUvaHcvcGNpL3BjaS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCmluZGV4IDg0OWUz
OTE4MTMuLjBjNTMyYzU2M2MgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2h3L3BjaS9wY2kuaA0KKysr
IGIvaW5jbHVkZS9ody9wY2kvcGNpLmgNCkBAIC0zODUsNiArMzg1LDM4IEBAIHR5cGVkZWYgc3Ry
dWN0IFBDSUlPTU1VT3BzIHsNCiAgICAgICogQGRldmZuOiBkZXZpY2UgYW5kIGZ1bmN0aW9uIG51
bWJlcg0KICAgICAgKi8NCiAgICAgQWRkcmVzc1NwYWNlICogKCpnZXRfYWRkcmVzc19zcGFjZSko
UENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50IGRldmZuKTsNCisgICAgLyoqDQorICAgICAq
IEBnZXRfYWRkcmVzc19zcGFjZV9wYXNpZDogc2FtZSBhcyBnZXRfYWRkcmVzc19zcGFjZSBidXQg
cmV0dXJucyBhbg0KKyAgICAgKiBhZGRyZXNzIHNwYWNlIHdpdGggdGhlIHJlcXVlc3RlZCBQQVNJ
RA0KKyAgICAgKg0KKyAgICAgKiBUaGlzIGNhbGxiYWNrIGlzIHJlcXVpcmVkIGZvciBQQVNJRC1i
YXNlZCBvcGVyYXRpb25zDQorICAgICAqDQorICAgICAqIEBidXM6IHRoZSAjUENJQnVzIGJlaW5n
IGFjY2Vzc2VkLg0KKyAgICAgKg0KKyAgICAgKiBAb3BhcXVlOiB0aGUgZGF0YSBwYXNzZWQgdG8g
cGNpX3NldHVwX2lvbW11KCkuDQorICAgICAqDQorICAgICAqIEBkZXZmbjogZGV2aWNlIGFuZCBm
dW5jdGlvbiBudW1iZXINCisgICAgICoNCisgICAgICogQHBhc2lkOiB0aGUgcGFzaWQgYXNzb2Np
YXRlZCB3aXRoIHRoZSByZXF1ZXN0ZWQgbWVtb3J5IHJlZ2lvbg0KKyAgICAgKi8NCisgICAgQWRk
cmVzc1NwYWNlICogKCpnZXRfYWRkcmVzc19zcGFjZV9wYXNpZCkoUENJQnVzICpidXMsIHZvaWQg
Km9wYXF1ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aW50IGRldmZuLCB1aW50MzJfdCBwYXNpZCk7DQorICAgIC8qKg0KKyAgICAgKiBAZ2V0X21lbW9y
eV9yZWdpb25fcGFzaWQ6IGdldCB0aGUgaW9tbXUgbWVtb3J5IHJlZ2lvbiBmb3IgYSBnaXZlbg0K
KyAgICAgKiBkZXZpY2UgYW5kIHBhc2lkDQorICAgICAqDQorICAgICAqIEBidXM6IHRoZSAjUENJ
QnVzIGJlaW5nIGFjY2Vzc2VkLg0KKyAgICAgKg0KKyAgICAgKiBAb3BhcXVlOiB0aGUgZGF0YSBw
YXNzZWQgdG8gcGNpX3NldHVwX2lvbW11KCkuDQorICAgICAqDQorICAgICAqIEBkZXZmbjogZGV2
aWNlIGFuZCBmdW5jdGlvbiBudW1iZXINCisgICAgICoNCisgICAgICogQHBhc2lkOiB0aGUgcGFz
aWQgYXNzb2NpYXRlZCB3aXRoIHRoZSByZXF1ZXN0ZWQgbWVtb3J5IHJlZ2lvbg0KKyAgICAgKi8N
CisgICAgSU9NTVVNZW1vcnlSZWdpb24gKiAoKmdldF9tZW1vcnlfcmVnaW9uX3Bhc2lkKShQQ0lC
dXMgKmJ1cywNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2b2lkICpvcGFxdWUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaW50IGRldmZuLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkKTsNCiAgICAgLyoqDQogICAgICAq
IEBzZXRfaW9tbXVfZGV2aWNlOiBhdHRhY2ggYSBIb3N0SU9NTVVEZXZpY2UgdG8gYSB2SU9NTVUN
CiAgICAgICoNCkBAIC00MjAsNiArNDUyLDggQEAgdHlwZWRlZiBzdHJ1Y3QgUENJSU9NTVVPcHMg
ew0KIH0gUENJSU9NTVVPcHM7DQogDQogQWRkcmVzc1NwYWNlICpwY2lfZGV2aWNlX2lvbW11X2Fk
ZHJlc3Nfc3BhY2UoUENJRGV2aWNlICpkZXYpOw0KK0FkZHJlc3NTcGFjZSAqcGNpX2RldmljZV9p
b21tdV9hZGRyZXNzX3NwYWNlX3Bhc2lkKFBDSURldmljZSAqZGV2LA0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkKTsNCiBp
bnQgcGNpX2RldmljZV9zZXRfaW9tbXVfZGV2aWNlKFBDSURldmljZSAqZGV2LCBIb3N0SU9NTVVE
ZXZpY2UgKmhpb2QsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVy
cnApOw0KIHZvaWQgcGNpX2RldmljZV91bnNldF9pb21tdV9kZXZpY2UoUENJRGV2aWNlICpkZXYp
Ow0KLS0gDQoyLjQ0LjANCg==

