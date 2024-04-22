Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C057C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryvyZ-0007E5-6F; Mon, 22 Apr 2024 11:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ryvyW-0007DJ-OM
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:53:00 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1ryvyU-0007bi-Qv
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1713801179; x=1745337179;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4cnIcDoqGHDL1Z0x70yJNdcDhiQCEDUbH698gtLc7kE=;
 b=nG5aTr3hJWu7UTPHJtYzEa492Z0CuuLejTThjkO5ICOgXR8Y2otbopPk
 6hfigrB7bCvUDZ0B82dD4woz1qgr1HyvJRfmVTIp02AW9q5b6rTlcB+dO
 tsAQh8j4vP+HkLttPk7yMQsJxjlZ9zfkhqo4tlX+5senLKnv3iwgGun/O
 GXQuwnqsFxn3peZ+XOgXcFaA2z2W/42sLPH7uS0l4448PwtvkutvxL5qf
 GmnhYOfCQeMVuAD4Xe0V14JOCmX+qjXf0Eup8AYB8Awqw/Alt5v9iptbo
 VyCYmW6S8AibPLqVzJnn+4DtSOxnGGl72MgqZIqPFqTG8MpCcsBAh33A0 Q==;
X-IronPort-AV: E=Sophos;i="6.07,220,1708383600"; d="scan'208";a="11027665"
X-MGA-submission: =?us-ascii?q?MDHJ37PvaTsQTQVLnmavDLm4el/1eeDDDWgdMI?=
 =?us-ascii?q?/+e1wunmKBenyQowoL+MyhNQX9VzyjgXnXag8mSF3q+lURaVKmPyBafv?=
 =?us-ascii?q?IzUh5oJxMrfj/gFGDHCKMu5oC5z00PFXeVIak+vD4rAl2dEWlQfjGxac?=
 =?us-ascii?q?+EqnAqYsW0jel3psINO1K/CA=3D=3D?=
Received: from mail-am0eur02lp2233.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.233])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2024 17:52:54 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivKfQXwGrGOigYZuFYqHhiV6InQoasJsqpn7pauYKPg3lpM8lgVUnkS80E6fAZnUaKAkbFw3ZJJxCFrAvSgNjM6YXLlr//4tsOnwIs05Ew9B0O6Mbmmb+k9hhY9i9sj/YWMPIXosu2jeWq5O2JpkBa9IP/aA7lBm2K5P8/oLRqqUrpb0Fx0Rw6SO+6AVXnj0nIRDI6rdoEMLZ/yhQojqyfEpjRYsZ07hHh1jXPA0bUEh5SlOtMNM6OJyOqrM58pgtjxuHJCUUd/xiJ08/s9GThZGvnJawdPrGEwdalKwrkqTjB2uVnfMfO19QhLyRzfO7Z3MMiR5BkVDknAdbBBMRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cnIcDoqGHDL1Z0x70yJNdcDhiQCEDUbH698gtLc7kE=;
 b=bSJ9bZuAqy5qQMdysOiOznzqh51iONcNbhhFp71a+js4LHi6rsoJ8VvIBTf91qzS10dlZBq9TasZvZiWoZH54gJC5INvqsR/cs2+h7X+96l9YIpqopzqaDKBnp6KJW6JtAR0EAA4naeKw6yqQ2vbQBnb8OUIfePDbYWDBgElUwCT6jlb+VOUxtTXnIFuYJrru1UOdwENdS+Rl927mO0/tswolLlisjDlK9RCLbjnBBJyAFQyzHpsOLBt45eqM0PnH4CicS9Lw60aw1CcacRlZpSXpAndRqeQlFRm50hkwJPKTl1os/WZ5DJzX/beyJ4GWBBd4ZlXXsEEY6hPebMHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DU0PR07MB9626.eurprd07.prod.outlook.com (2603:10a6:10:31e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:52:52 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 15:52:52 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH intel_iommu 1/7] intel_iommu: fix FRCD construction macro.
Thread-Topic: [PATCH intel_iommu 1/7] intel_iommu: fix FRCD construction macro.
Thread-Index: AQHalM0iDk6hOYr1Bkut1qmJ4l2A4Q==
Date: Mon, 22 Apr 2024 15:52:52 +0000
Message-ID: <20240422155236.129179-2-clement.mathieu--drif@eviden.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DU0PR07MB9626:EE_
x-ms-office365-filtering-correlation-id: e63b34bf-bb6b-4008-e083-08dc62e444ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?MnJyUWZqbGJvQ1R5Vi9lTDZJT0xzV09xajh2UTE4TmIvbmRoNjFzVVZWYXN0?=
 =?utf-8?B?L29vcmsyaTE5Qzg5dllmSGpqUVFBL0NrZE16SnlobnMrRE1IMnlSSXE4cGtV?=
 =?utf-8?B?dDFjRVM4bmZKRzdkUzBCT3pQejhJd0ZRRi8zQzlNcWdMUnVqbUpEZ1ZvOGwr?=
 =?utf-8?B?WEFJU3pObWNjemhGOFVndnpleFlNL2EvMVROYlR1cmdyTTFXdlRvckwvS3dF?=
 =?utf-8?B?TjRUS096dlZQeDZYM2gvUEFhMUlOR3JOclVrYWVUNVpKaGRNMEordTV6VWU5?=
 =?utf-8?B?RnFHcVJUTURtTGV2NU9PYWpJSnFYajVzYS9zVlQ5VitZbllDQ2FGQ3ZXOFo2?=
 =?utf-8?B?WGsxd0p0bzFac3ZsWThQV2tVS0dLUWpyUnEycjJJZ1NTOGg0TUZDd2Jmc09r?=
 =?utf-8?B?d3M5ZEJUbXpxS29LWWxkTVNFbzAwWFByQlRzS0tQS1RQUElyN3Q4QUQ4VnpN?=
 =?utf-8?B?QmgvREhkeXQwTjdoM212bmNtazBVOXNqNjdXNVBVeHJQd0M5VzJ4VnRFbUVI?=
 =?utf-8?B?ZUJBZEJKSnJkWEFvbkg4SGZ1QUJuc0sxNkNmb2ZXelIvMWZSaXZZRklnSzBj?=
 =?utf-8?B?UG40cmg2L2RCY29iNTNKRXRuWThlTjIvU3QwMW1IRmdlbEVIWm1LMk5QNG8v?=
 =?utf-8?B?NlhrRy9CMENHWC9PM01CSmJURTg3bm9pdFRMbG1QRy91dExDSWswTEFJeitp?=
 =?utf-8?B?Qkt5aGdwWkx1THloZkJIdTNFTFBSeXl1U21JZXJyOEZZeER6ZVhCbzMwaDhI?=
 =?utf-8?B?dnlNei9rN2dCNzdwMVJkNUpkNHZheHBGaERJcGwyd1ZwSDJCem5kL3h1UFRN?=
 =?utf-8?B?Ni9MQVBDOEN0V1Roc1RIdVhSNExCSzA0Tll3b3NjSWJ1NkhtYVVCanliZysv?=
 =?utf-8?B?Z1creG9OZlE4MVMzK1pPc1F2UENadEVxVVdranpLRG9seG05SzlwZmExdTRr?=
 =?utf-8?B?Y2MwcXdtNnZFMHhiaVdFQ3ZwaVNzRnYwSlJpNXhUMC94YnBZaHF2VElyMGRh?=
 =?utf-8?B?UnJObmo1QThqbE0vRE1wU0pvMjdtVkpvZ3JTYWRWdzNPd0N4alhIa2J4R1NZ?=
 =?utf-8?B?dDBmUE1aOFB6YWllRll5dlJWYnhaMlBjcnQvMnd6MXFncHhnQkZQbXljU01G?=
 =?utf-8?B?c3IveGZLa0tVSHlIeHFjSnBmUjhjajViN1RSZTNSS0YvMzZIUzk3UW1FTDM1?=
 =?utf-8?B?d3RNNytUQTJNWjZZRGdlUGxKM2hLZDRmMitmbnQ0UW1mUlpZWC83UWlaSS9Z?=
 =?utf-8?B?ank2VnFMSWQ1TmRLK0g0ZVc4ZXdjQkZSVUtPbDEzeHFUVmFQUWkzcEh3ODFS?=
 =?utf-8?B?OWd6KzdHRFRQUGxRRDhvSXdkMzVKNWQzU1pyUTdyNEEwVjk1M2cxRlYzREF3?=
 =?utf-8?B?N3VNTG5xVEVjWFBIQWY2Q1FQendDaWZwcHEwNE05UzZGRzhCZ3lpUWpiQjFB?=
 =?utf-8?B?QW5abm53Q0VxaEc1Y0FVZDlRd25zak5QVVVIbjhlWGRTTWYzdEF2UThsbFFB?=
 =?utf-8?B?NEN3Nld3WGhucXlRcWN5NU5NZVZwY0luOU9mWTNKWDNRY01RT1RxcXlZbDc5?=
 =?utf-8?B?MXVMcHovaWxTQWFaUHFlZ0FMQ0wyRmJReE83bFhmR3dBNzdLZ3QzS3poazJ6?=
 =?utf-8?B?Tkp0RUR2S2VIL082QlljMXFyTzFxSFNpdUVnc3djTFJJSVhQYjZHVFlUeGU3?=
 =?utf-8?B?bkxOVVp5bUhYU1lYRVNWbERqSzAxRTY3ZjVWL3EyV2hDQ2daZ0YyalI2RkJk?=
 =?utf-8?B?Q1JsR09TTlJESHdBTHliZHJqZHJoR0dsM29RN3VjSHd3Yk05ckFVeURDMFlZ?=
 =?utf-8?B?RXdUUUdZRlhKeFQxTVJpUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWk4bkdzUnNaZHZ4MmZnZTUzellCL3dxa1hCcHpWSHhNZVNrRWxtSEI1eUwx?=
 =?utf-8?B?REh0WWtuSTZabEp6aE9tN2RtdzlwRGdHaHVoeXE4K0VTYnlpMzhEOTYzY05t?=
 =?utf-8?B?NTRCQkt3ZlNoOWpZejMrU05OM1Q1L0JrQUFpRThWWXY5SDVZTzg4OS9YaExa?=
 =?utf-8?B?Y0dGbC9PWVZxR1c0QWRUOFBtL0dYc0dmQ3Z2NXM1Z0xSdTQwaEtkTUhoWHFI?=
 =?utf-8?B?eDZrRy84dUpoMEtFKzNwd00rVkNvalQ3WHZ0MytsWFlXTWo2ZitvdHBZMFB4?=
 =?utf-8?B?UHNQcEZhM3VOT0srYWlmMk9JckdaNG9pZnh1V3FmQWRZNWVkVVZEOUN0SVRE?=
 =?utf-8?B?OXNzMFhZUTFCQ3QzMHl0MFlSYWRlcGVrQlR5ZTAxSDE0TjZ4M1ExdS8zV0Iy?=
 =?utf-8?B?Uitsa1FJbDlqWjFHc1Q5c2dScm9weXh5bjZuSG1yTzQvTGZwMzBFdktYM09U?=
 =?utf-8?B?ekZ3RHdlNXdnZ1ozT3hXb3FyMUlKYlFIa0JNM2g1T0RHRUMzMzZuU1NqcytE?=
 =?utf-8?B?aWpUd3g1SmwxTFlqRFBlQ2szdmZoWGk4bGY2SXVjRHpuM2xiSEgxZ1JiZ2RJ?=
 =?utf-8?B?RVdtaHd3VDZ5TzlVY2Exc2tVK0xHdllJd3owRFBGZ0p5MWxzZ3F3TzRURzlh?=
 =?utf-8?B?SmhIMWhMcGR1Rmg1RGcvbE1DL2ZZZ0FESHcwOCtDbGNKMjdHdkp3OUROOFFk?=
 =?utf-8?B?K2g5Q1l3U0FFM0FpQ3E2NkNhRUtPWG9LQVdPalZnN0syN1VJeWlMV2pLZXFr?=
 =?utf-8?B?U3o4blYvd2xBN0Z0MXdBbStBTUd1R0JSQTJvamxsSzZmTVBodHBrQkF0dnBi?=
 =?utf-8?B?Z2RTUUt5cGNhMlExQnRadGF4TU5ERnEyWkpKd0FyZ0ZMUVozblAxL0EvMjRt?=
 =?utf-8?B?b0g3Yzk2UTYrUUZnRTNSKzcxcDZwdlZSLzJSSExFeTN0SjB1eko1cnhaS2xv?=
 =?utf-8?B?SGhoYXFtZEtpN3FFbVVPRk5IZXgwanRqMjU4Wm1iZ1R0TGU1SXEyVDhOcTlX?=
 =?utf-8?B?NEd6QnA0bGN4Wi9RWTFHbmxFVzRGNVU2ZldJbXRRUHRpWWFoK0lKc3ZaWUJM?=
 =?utf-8?B?azdrRWY4ZTY2UGJFVXp4U1ozOFlIMFZ3SEQrOVovWVN3UXNhczFzSjVPWXlJ?=
 =?utf-8?B?VzJ0Sld4Y3E5RG9yOFBQc1BpZ0FDYzZ0a3pqQ3l0NncvWUFvMlFzekc5RjE2?=
 =?utf-8?B?enhSUml0SzBibU1ndWhDdVJRTVdTL1BHeGVCb3Vyc1d3U1BEZGFlOEVlTS9M?=
 =?utf-8?B?YkVmOXR0akc1ZklRRFhEVWFzeFA2NitKcGpQU21FK3pWVG56enRmOGFmZmRH?=
 =?utf-8?B?Zm5wZjlqdWZpalBNSzV3U0NsMnBTdWw0K2VkR2ZIWmJmYU9lcjEvRUgxUXFj?=
 =?utf-8?B?VlVPOGRXazNsV3ZUK0I0cGNlSlBFVENsNXkzQjBUNVNSZlU3eGFBVUFkUDIx?=
 =?utf-8?B?TUlHUFJVa3I5c2lKdWVBL1pvdkczYjcrc2w5SlpZT1pvUXRlbFBTNG81Sy85?=
 =?utf-8?B?NkNMNVpoSDNGRHU1QndlZ1NoVTgvdTZIUThkQnpDR2tRWGg4dGhQU2JSelQx?=
 =?utf-8?B?YXQyMUlGUWE3alB2R0wyRHg0cFBEb1lwWVZWRUZYNHhzYSthNC94S25hRlM3?=
 =?utf-8?B?RUlxdFpaRWN0NlhYczAyeWdkOTNBa1dCcURyeVkxTHpjWG1tL2VPL3dSNkZw?=
 =?utf-8?B?cko4ajhvZmtnY0tMWjVWZDNCdXRkU0RMNFlpUnd6REpmaEdhVGpRSmRpWXhw?=
 =?utf-8?B?Qi8weDBpZHdHMEQyendaMVJEYmxSYVlHL0RPTWFoaWFCKzJtYUR6Y2NsMmRL?=
 =?utf-8?B?Y012VzNUbDlrSHhiS2hGUnNpbjErYmluUEpLYmk3eElhdzVLcUlQTWszdmxq?=
 =?utf-8?B?cnFLU29udWV1Y0xUTmVPN3gwTmJNSUlhTFlWaDlkZmROT1BrMG9mY1d3c3dX?=
 =?utf-8?B?ZmhzbFdRLzUxVkdIanQ5OEpIazE0Wm5UZUdxRVpnQ3ZyOUN4S1J0T2JRa1dp?=
 =?utf-8?B?blhwbUdNZzBleVJHSEtvWWhIWW0rYXBHTUcycEV2WUN3YXJUU1hHY21ST2hp?=
 =?utf-8?B?d0R5bWc4V3A0bU83bk12RzVvbjdYMXNJRkVycEdJbk1jZ3ZBT3ZBd1R6RWFv?=
 =?utf-8?B?ZXEyd09mV3NLYUNkenJLemR4ZURsYzY0OWhlNUxaVFlQRVllS0hUdzh6M1BZ?=
 =?utf-8?Q?AZJq26Mkaj9nXZmL//z98R0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5561B50DE06953448E44197C645B2BB6@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63b34bf-bb6b-4008-e083-08dc62e444ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 15:52:52.6475 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TqjMOYcFwf5gnZioe91//QxdTKjxsdvKMtAIAMJqYDeYyGybNAtKJi1OVKAL9JdwoRFm0O0lzPFV0imu+6HiW1ZyOuFULNeHkZJwj2FfbL1SzNAj4jrXydZAF/ZoAW8c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9626
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

VGhlIGNvbnN0YW50IG11c3QgYmUgdW5zaWduZWQsIG90aGVyd2lzZSB0aGUgdHdvJ3MgY29tcGxl
bWVudA0Kb3ZlcnJpZGVzIHRoZSBvdGhlciBmaWVsZHMgd2hlbiBhIFBBU0lEIGlzIHByZXNlbnQN
Cg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1
LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgg
fCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoN
CmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCmluZGV4IGY4Y2Y5OWJkZGYuLmNiYzQwMzAwMzEgMTAwNjQ0
DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBiL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaA0KQEAgLTI2Nyw3ICsyNjcsNyBAQA0KIC8qIEZvciB0aGUgbG93
IDY0LWJpdCBvZiAxMjgtYml0ICovDQogI2RlZmluZSBWVERfRlJDRF9GSSh2YWwpICAgICAgICAo
KHZhbCkgJiB+MHhmZmZVTEwpDQogI2RlZmluZSBWVERfRlJDRF9QVih2YWwpICAgICAgICAoKCh2
YWwpICYgMHhmZmZmVUxMKSA8PCA0MCkNCi0jZGVmaW5lIFZURF9GUkNEX1BQKHZhbCkgICAgICAg
ICgoKHZhbCkgJiAweDEpIDw8IDMxKQ0KKyNkZWZpbmUgVlREX0ZSQ0RfUFAodmFsKSAgICAgICAg
KCgodmFsKSAmIDB4MVVMTCkgPDwgMzEpDQogI2RlZmluZSBWVERfRlJDRF9JUl9JRFgodmFsKSAg
ICAoKCh2YWwpICYgMHhmZmZmVUxMKSA8PCA0OCkNCiANCiAvKiBETUEgUmVtYXBwaW5nIEZhdWx0
IENvbmRpdGlvbnMgKi8NCi0tIA0KMi40NC4wDQo=

