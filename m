Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FCCC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 05:56:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rodJL-0000SA-8o; Mon, 25 Mar 2024 01:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rodJD-0000Rl-4n
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 01:55:47 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1rodJ9-0003ho-B4
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 01:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1711346143; x=1742882143;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=096eshvs7UfaWKHcOIOlS9mx6AjfzTc6DQPcZRDKI9Q=;
 b=LgBejenZ9xb3m8cQ6U+jiRZ2ZcmX2BmEUPHCKp+AszMWrfM/ziYIGB70
 ZGPgRUeAGbtfMHh8q+e/odsXyFU5o5W3eXd3tvnkQ5Zr5Guc0vCy2tupz
 Otj6Mq8Rma1Ol2+r1DzL9DN0mQqudFnXwYIPs+iZ8jkSzmSBg57Cxeg8B
 jp0gfWqBofH6t6h3al0/zSSPQ8/ipmXWmkav7O6cjAPkuYnKZcCMNfBzA
 ToJinOKSZI3h2Iso34qnKwJqwgNSKJeojnNB8IsbRl7TSkqJ9UdqkLy4v
 QM5Q65DF/b3+G7ALUe3mRxIhZBVKB31/7mpqiE4yXKRTrqPYH5Zhjarv1 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="114993730"
X-IronPort-AV: E=Sophos;i="6.07,152,1708354800"; d="scan'208";a="114993730"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 14:55:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEr0CACL4Po4yfH6DLy2rYE/JTxO/xgtL11s9ir+mWPHRwkCux3651DDEbOR+v5YMzPS4Dy81eXilwijeGWPZ9tAK5lMogTPRqf4OupA4Bqxt18Y02xWMK/RzcErZR7ZrxvYDymBEE00EtVcKf4GXRDtP0pEKqypqAmwqjyGGessmwdec1H6OOaljo4S4OAWH4Z111tHDG5pN0oJC5gZvZfkH39NTPK3HR9jOZTOU5rmGMYnYinZLLsyUHIwjHeT1aUK2ZQLQI8Xm9XQ8oSbHA4R5RE6+ZXOwDi45eGeb6pzoO4/49twRo3NAq24WtBFhTjAqujmDnK+aUjxvDGpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=096eshvs7UfaWKHcOIOlS9mx6AjfzTc6DQPcZRDKI9Q=;
 b=HpPHYswjwukNhZ5g/F1owrTmwM/dJ2TzMIJBPeGi6C9TeDyDFEWFKSYmGSvr8drjRhYvWG0L2ffPsWmiE0EdDlHasNOMTsSHQBGJFkb5Fz6bDuBN8oO9XUYLapWcsFgbmCvmBla0bPJ0rw3vMzdKqkuROedj4q5M1NFgc9OT2dydmZZRwEXQ3l7txt0ge+CxRAbg0NlytcuzEp9wLb61E6OwAZpcxu2/vKU9m/2zRvT54W/nDM20rOvFgZk8lQqML53exJNsMTPzguyUuf0Mkc8V0gzRY6SGJJ4Sh/X7WDcKqPgD2ONqdy8yaCPvxOfyVxMZ9nFVBfxPvCd3GG8zKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com (2603:1096:604:ed::14)
 by TYCPR01MB11887.jpnprd01.prod.outlook.com (2603:1096:400:3e3::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 05:55:32 +0000
Received: from OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d]) by OSZPR01MB6453.jpnprd01.prod.outlook.com
 ([fe80::3a1c:a3fe:854f:2e1d%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 05:55:32 +0000
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "erdnaxe@crans.org"
 <erdnaxe@crans.org>, "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] contrib/plugins/execlog: Fix compiler warning
Thread-Topic: [PATCH] contrib/plugins/execlog: Fix compiler warning
Thread-Index: AQHaemrmPT2EHGnEyk2ga5p3A7g8V7FDqW4AgAQbN9CAACEQgIAAFL2g
Date: Mon, 25 Mar 2024 05:55:32 +0000
Message-ID: <OSZPR01MB645315B66E56C3CD3B2067778D362@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
 <CAFEAcA_7E62a4QJtQRk0AHw0hjNaReB1zyGXNjFM1EMAK-unOg@mail.gmail.com>
 <OSZPR01MB645321820A55828922270D5A8D362@OSZPR01MB6453.jpnprd01.prod.outlook.com>
 <11198af6-593a-4aba-afba-c3b8101d03f3@linaro.org>
In-Reply-To: <11198af6-593a-4aba-afba-c3b8101d03f3@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9Y2I5YjZjOTEtYWEyMC00ZDQ5LTgwZTgtNGE5NzUxMTAy?=
 =?utf-8?B?MWU4O01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFROKAiztNU0lQ?=
 =?utf-8?B?X0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRkLTNiMGY0ZmVjZTA1MF9T?=
 =?utf-8?B?ZXREYXRlPTIwMjQtMDMtMjVUMDU6NDU6MjhaO01TSVBfTGFiZWxfYTcyOTVj?=
 =?utf-8?B?YzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX1NpdGVJZD1hMTlmMTIx?=
 =?utf-8?Q?d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB6453:EE_|TYCPR01MB11887:EE_
x-ms-office365-filtering-correlation-id: 6992cad2-87a5-444a-ead2-08dc4c902ebb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ozKFfHFgJAlFLvoXqlLTAcl2mB/jlinatQjPz9/8VYc/QP8SalGAse8AAWnMnAho7NeePp0bX7q3danznpBLqyy/ljaRCtok59w3DV2rFq2ELPzh4m4B8iDtjQ1fOZo052k9+51a39JquaNEON90mT9b+8mcigteHgxTgUSF72iZY/XBMEDXde98C91cce493y2hSmabVkLbkbvuG4NmziJoEYlKeVP+SqBQ8Tw21l4XKpLl4/SPL9PwmY2ui0Dw0DwlAcA2SwtbSNlGcCP29VxJCvWY/jNlycqtcLJxMZeRw4hQ2hnhhLq9v/2gJBKEVbeCeenBVkCJozhvtSo/DUOr9pNKegkuXNAMJPgvBv/gVf2IDggOr9noxtv1+FN04ZPlXy0OUw98xlpvyJeWk7Ck6RsjvfR3tdZBowilz1JhuUa9up6gMOiKeRHulVvjSiL2HGOeZjZ5ohfhrA+oPx1r6R1H2FQvMpjA55D0NtXuCiWD25YPLXSTQRejoIGEPD9JdySeS/jDSqbfeL6jqCJp+T7bCY/qRWEvcCwQhbosIS6iwzph+8HseZt6+VOmLbU7o6JvDog/QpXpeHMf55Wm+0/OhELmNBjiJmec0bEuMOMiHMxFY5smjdU7DY8OPxpbpAOH+ieM7/10ike2nmhoB+qyELa+y3lKgecsf1goAr5cFSDSYvOxxWjyllBI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:OSZPR01MB6453.jpnprd01.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(1800799015)(376005)(366007)(38070700009)(1580799018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmR2b2tYeEVKT09uV2hCSDFQT0FXdnhHK0hlUDM3Z0NPUThYYVBGWkovS3Z3?=
 =?utf-8?B?ZXBKZmY5ME5uQ3EvTkwzMGVaMjNBbHBwK1pmSmhOZExCbGVqRS9wM1l0SS9W?=
 =?utf-8?B?WnR0ZW1LOFJCOCtubWQ2TkhSelhkWVFsY3NBMHE5YUZuZ0cwa0dhdzliUi81?=
 =?utf-8?B?ZzJYQ2VPcDE2SGNKTWt3UmNDa0U1bGVwNFd4N2ZaR2psdWt5aFREbUFheFVT?=
 =?utf-8?B?SFdVazRJTFhXSERTNFJlR1liMlFYUklaN1V3Q2RHenNGeGc5cUl0NisxTTZY?=
 =?utf-8?B?ZzRxVlVKdHZmQ29WOXE4bU5SbHJIYUJSM0xaVmVjaXZiUndZd0hmSjlBU2d3?=
 =?utf-8?B?blFtMGZhTXZuT1g1c2FkZG05UDBUYVdiQTFlNjFzR1NFTjdLaHZUNlNvdXlx?=
 =?utf-8?B?NzJ0MjNNVk96V0hKTm52VEtBQVZvOHoxK1VtRDdNdjR5VWtEYW9UeFE1cjZt?=
 =?utf-8?B?WGQ3MzBvbmVRd2VYKzkwejVCVThCVGRZNTRoY3VFa1hYSnhhL21XZ093Q3po?=
 =?utf-8?B?c00zYTc1eEhKNnd4aGNNaTh6ZUpxU3VZNnQvTTJrT2I3OGhwUzUrWXZzN1ky?=
 =?utf-8?B?OWVMODlIUWI1clBQcjZxWWtFSGE0cGJoV25mSStGcGJiTXFPOHBEcmdNYUNU?=
 =?utf-8?B?MGJUYWk4KzlPK3ZGbThMcjVYWVB2NExaZXZwMDVLM0JYOFBJelFRTFlUOFla?=
 =?utf-8?B?dFZFZDVlbmt2OU94WDRYVjJwWktkL2NwVUZCME9Lc0xDbEtCTGUxMWZaNFZV?=
 =?utf-8?B?dDllby80d0N4cHNBZ0RPaGF4cVl2bUpRcnh3aVNVOTNyZTNRWXMyUU8xVnlO?=
 =?utf-8?B?c09sNE1RbzFvaHJOY1llYVV2U0ZlWlRLVEExcFFkNzluZGdxcGpFNTd3SDJK?=
 =?utf-8?B?MTh1UHpXb0g4elZ5QUY4SEczOS9RNldHOGVYY1hpWlJrbHFndEhvV2Q2eHJD?=
 =?utf-8?B?ZFlRbW9MS2Q0cElwZURjZFljTXU1UGYxRytvd2pxa1pmbE5CYnA5a3FyTTBV?=
 =?utf-8?B?Yk1HczBXelVyNjV3SWJOdkUrZ2wraFc1TnVZQ3BjUGJoY0FjVm91amNXUFpr?=
 =?utf-8?B?ZXFSdDFtcDdXNVJEY09nUDdxUHBlZU8rTjlUMyszMU1yTzNMY2VUdEJDd21F?=
 =?utf-8?B?c3JVQUtVSmZmK0dyTXZrUHpGUDZJZGtvaUk0K2JPcHRIYkp0VENVVWFrdE1p?=
 =?utf-8?B?QWFGa0pFblNUVDdJNytMN0poSGRRNFRPbkx4b0NvblRBMWdLeVFaZjIrTnVa?=
 =?utf-8?B?Vno5TXppTElhRHpONzlBV3YyT3ZTWHZJWHpNZjNkNHhKOGZpaW9wWThlUUlL?=
 =?utf-8?B?VTdPbUF6TUEwVmYzRUZkTHNKbjg4N05nVTY4VFVYclZHSklkNVVTa3ZZempS?=
 =?utf-8?B?WlVDbUVGMTJrRjMzOFRoM1o4WHp4L3lyRkVMU0NybW15N2hZdHc0MnVuZjJi?=
 =?utf-8?B?L0g3bGluOE8rLzBUTlROM3pydGhReXFyaGx3bzlQcjc3YkVhSFI2UnR2M3Yy?=
 =?utf-8?B?aHE1aEJoSnJnM0JBUDFIalhwOUZhWHpEbWIvaVpJc2ZhaFRlTWJhREM5SVdN?=
 =?utf-8?B?QS8yV2IwZUhlRzZRbjI0SWYzMzh3N3YxWnBtVkY3TnIwNUpDYlNETy9nRzFz?=
 =?utf-8?B?S2kreVBaTnhXWUtibEtDUDFoNk9XMkUwRXBXaGJjdUhNWWNvK28wN3RBdldj?=
 =?utf-8?B?TkRmTEJUUGhkZmRhMjFhMit4cXRqU3RxYUdQVnJjWVBSZCtDaVVWY0s5Umpj?=
 =?utf-8?B?V1JONFgyclpmREZWTTk1WU1paDh6TTVibkV4ZVJGeDRyL1YyN1Jud2ZoR2NV?=
 =?utf-8?B?RHFUVGlnUjdDaEVNMVBudVd3KzAybE1ucEJvTk9TMVZXejVRaUdzMXd0S0xT?=
 =?utf-8?B?dzVtOEs2b0owKzFQOFF5cXplVkNBV2N2b1FKS0JGTkFoZHNBNDM4UmJxVTZN?=
 =?utf-8?B?Z1d5K1Boalk3LzNrdCs1aWNKaFNSdUQ0ZWVFM2dKdXFoSGtkanNCNzZORjNV?=
 =?utf-8?B?eWZoYk9QdzNoZWtnelRQN1AwUkdLdEY3Ris5Y1RUeE85ZW1VbExXOHBna05u?=
 =?utf-8?B?YitnbnBKbnBBT0FRUXVIYzVkcFBnM3BZSzhqVlpsT2oySzl4U2JPc3JweTFj?=
 =?utf-8?Q?40vRCkjYyXMnkBy/ftWrkGMMB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ggrYS3+d7FLME8N6DVV6krZ8KtWneQaazj/H2sGjzedRbH64gVmz7mY3+ckDhHW4R19JLN2CSTJ3XazpVRhPrgPKPwrLVeCj8qGeZIzaxFf1own2d9RLaUT69o++4a+crIuSN+oCcd32y4n4ZYDpvuZdJ8SDYqtIl013SCx5pv9Yqp1T9TE0+3vRZUvz7wFWE47Zw9ZmYQM4JZfnVSorQn4RA/DAl/+Qixqb6aIyCV/4NDl460JUiL5VYHJ0WCTrFKql6+0m7uaUIzKejjgSEGTctN5Bp+JoijvMolLcPErNTQXK1sTsLIWuCxnM65mbbUYgamnE1rjExb0hJsG1xCP2Mr0e8V0qNV88/5wJEgCGRAr9FP0ulUdN3Zip2E7ScndLrWoA4IzTjD+zZaQz4ChhBRIwwN6O78Ou31XredB5V4yCm/RgO5CqRJjckz4LW97ToaSUoHfrRb+oSqjxqyvpZkOpBr8hwGq7LS/TAtLpSHgu0EeeoZliXLrfrCdMjrdWFFneaEvPVCK7Igk0Nsg1tzn9/OUptHNK9K49i4RnW1gHQHG+3fAlKgc6jVVnGIb8GDjnqR1wvs/8LRiRhPoo2jhqnrCclWg8++IPwfnHC+rK06/4PxAIBc9SVeTY
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6453.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6992cad2-87a5-444a-ead2-08dc4c902ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 05:55:32.2744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tNjGhnsrOsTWn2graRqdHYd0cCRCodTfdaHFBsvT/zvF1tUi3rI/v4Dn9q1wvd0K4xHIe0howfdVwAnfiCVJLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11887
Received-SPF: pass client-ip=68.232.159.247;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa10.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
From:  "Xingtao Yao (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgUGllcnJpY2ssDQoNCnRoYW5rcyBmb3IgeW91ciByZXBseSwgIGFuZCBJIHdpbGwgbW9kaWZ5
IGFuZCBwdXNoIHRoZSBwYXRjaCBsYXRlci4NCg0KdGhhbmtzDQpYaW5ndGFvDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDI1LCAyMDI0IDEyOjMx
IFBNDQo+IFRvOiBZYW8sIFhpbmd0YW8v5aeaIOW5uOa2myA8eWFveHQuZm5zdEBmdWppdHN1LmNv
bT47IFBldGVyIE1heWRlbGwNCj4gPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4gQ2M6IGFs
ZXguYmVubmVlQGxpbmFyby5vcmc7IGVyZG5heGVAY3JhbnMub3JnOyBtYS5tYW5kb3VyckBnbWFp
bC5jb207DQo+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBj
b250cmliL3BsdWdpbnMvZXhlY2xvZzogRml4IGNvbXBpbGVyIHdhcm5pbmcNCj4gDQo+IE9uIDMv
MjUvMjQgMDc6MDAsIFhpbmd0YW8gWWFvIChGdWppdHN1KSB3cm90ZToNCj4gPiBQZXRlOg0KPiA+
IFRoYW5rcyBmb3IgeW91ciBjb21tZW50Lg0KPiA+DQo+ID4gSSBhbHNvIGZpbmQgYSBzaW1pbGFy
IHBhdGNoIHdyaXR0ZW4gYnkgUGllcnJpY2s6DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
cWVtdS1kZXZlbC8yMDI0MDExODAzMjQwMC4zNzYyNjU4LTE1LXBpZXJyaWNrLg0KPiA+IGJvdXZp
ZXJAbGluYXJvLm9yZy8gYnV0IGZvciBzb21lIHJlYXNvbiwgdGhlIHBhdGNoIHdhcyBub3QgbWVy
Z2VkIHlldC4NCj4gPg0KPiA+IHNoYWxsIEkgbmVlZCB0byBjb250aW51ZSB0cmFja2luZyB0aGUg
Zml4ZXMgb2YgdGhpcyBidWc/DQo+ID4NCj4gDQo+IEhpIFhpbmd0YW8sDQo+IA0KPiB5b3UncmUg
ZG9pbmcgdGhlIHJpZ2h0IHRoaW5nIGhlcmUuIEluIG15IG9yaWdpbmFsIHBhdGNoLCB0aGVyZSB3
YXMgbm8NCj4gY29uc2lkZXJhdGlvbiBmb3IgYmFja3dhcmQgY29tcGF0aWJpbGl0eSwgdG8gdGhl
IG9wcG9zaXRlIG9mIHdoYXQgeW91IGRpZC4NCj4gDQo+IEFsZXggd2lsbCBiZSBvdXQgZm9yIHNl
dmVyYWwgd2Vla3MsIHNvIGl0IG1pZ2h0IHRha2Ugc29tZSB0aW1lIHRvIGdldCB0aGlzIG1lcmdl
ZCwNCj4gYnV0IEknbSBkZWZpbml0ZWx5IHZvdGluZyBmb3IgdGhpcyDwn5GNLg0KPiANCj4gUGll
cnJpY2sNCj4gDQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFBl
dGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogRnJpZGF5
LCBNYXJjaCAyMiwgMjAyNCA3OjUwIFBNDQo+ID4+IFRvOiBZYW8sIFhpbmd0YW8v5aeaIOW5uOa2
myA8eWFveHQuZm5zdEBmdWppdHN1LmNvbT4NCj4gPj4gQ2M6IGFsZXguYmVubmVlQGxpbmFyby5v
cmc7IGVyZG5heGVAY3JhbnMub3JnOyBtYS5tYW5kb3VyckBnbWFpbC5jb207DQo+ID4+IHBpZXJy
aWNrLmJvdXZpZXJAbGluYXJvLm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+ID4+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGNvbnRyaWIvcGx1Z2lucy9leGVjbG9nOiBGaXggY29tcGlsZXIgd2Fy
bmluZw0KPiA+Pg0KPiA+PiBPbiBXZWQsIDIwIE1hciAyMDI0IGF0IDAyOjA1LCBZYW8gWGluZ3Rh
byB2aWEgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gPj4gd3JvdGU6DQo+ID4+Pg0KPiA+Pj4g
MS4gVGhlIGdfcGF0dGVybl9tYXRjaF9zdHJpbmcoKSBpcyBkZXByZWNhdGVkIHdoZW4gZ2xpYjIg
dmVyc2lvbiA+PQ0KPiAyLjcwLg0KPiA+Pj4gICAgIFVzZSBnX3BhdHRlcm5fc3BlY19tYXRjaF9z
dHJpbmcoKSBpbnN0ZWFkIHRvIGF2b2lkIHRoaXMgcHJvYmxlbS4NCj4gPj4+DQo+ID4+PiAyLiBU
aGUgdHlwZSBvZiBzZWNvbmQgcGFyYW1ldGVyIGluIGdfcHRyX2FycmF5X2FkZCgpIGlzDQo+ID4+
PiAgICAgJ2dwb2ludGVyJyB7YWthICd2b2lkIConfSwgYnV0IHRoZSB0eXBlIG9mIHJlZy0+bmFt
ZSBpcyAnY29uc3QgY2hhcionLg0KPiA+Pj4gICAgIENhc3QgdGhlIHR5cGUgb2YgcmVnLT5uYW1l
IHRvICdncG9pbnRlcicgdG8gYXZvaWQgdGhpcyBwcm9ibGVtLg0KPiA+Pj4NCj4gPj4+IGNvbXBp
bGVyIHdhcm5pbmcgbWVzc2FnZToNCj4gPj4+IC9yb290L3FlbXUvY29udHJpYi9wbHVnaW5zL2V4
ZWNsb2cuYzozMzA6MTc6IHdhcm5pbmc6DQo+ID4+IOKAmGdfcGF0dGVybl9tYXRjaF9zdHJpbmfi
gJkNCj4gPj4+IGlzIGRlcHJlY2F0ZWQ6IFVzZSAnZ19wYXR0ZXJuX3NwZWNfbWF0Y2hfc3RyaW5n
Jw0KPiA+Pj4gaW5zdGVhZCBbLVdkZXByZWNhdGVkLWRlY2xhcmF0aW9uc10NCj4gPj4+ICAgIDMz
MCB8ICAgICAgICAgICAgICAgICBpZiAoZ19wYXR0ZXJuX21hdGNoX3N0cmluZyhwYXQsIHJkLT5u
YW1lKSB8fA0KPiA+Pj4gICAgICAgIHwgICAgICAgICAgICAgICAgIF5+DQo+ID4+PiBJbiBmaWxl
IGluY2x1ZGVkIGZyb20gL3Vzci9pbmNsdWRlL2dsaWItMi4wL2dsaWIuaDo2NywNCj4gPj4+ICAg
ICAgICAgICAgICAgICAgIGZyb20gL3Jvb3QvcWVtdS9jb250cmliL3BsdWdpbnMvZXhlY2xvZy5j
Ojk6DQo+ID4+PiAvdXNyL2luY2x1ZGUvZ2xpYi0yLjAvZ2xpYi9ncGF0dGVybi5oOjU3OjE1OiBu
b3RlOiBkZWNsYXJlZCBoZXJlDQo+ID4+PiAgICAgNTcgfCBnYm9vbGVhbiAgICAgIGdfcGF0dGVy
bl9tYXRjaF9zdHJpbmcgICAoR1BhdHRlcm5TcGVjDQo+ICpwc3BlYywNCj4gPj4+ICAgICAgICB8
ICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+Pj4gL3Jvb3QvcWVtdS9j
b250cmliL3BsdWdpbnMvZXhlY2xvZy5jOjMzMToyMTogd2FybmluZzoNCj4gPj4g4oCYZ19wYXR0
ZXJuX21hdGNoX3N0cmluZ+KAmQ0KPiA+Pj4gaXMgZGVwcmVjYXRlZDogVXNlICdnX3BhdHRlcm5f
c3BlY19tYXRjaF9zdHJpbmcnDQo+ID4+PiBpbnN0ZWFkIFstV2RlcHJlY2F0ZWQtZGVjbGFyYXRp
b25zXQ0KPiA+Pj4gICAgMzMxIHwgICAgICAgICAgICAgICAgICAgICBnX3BhdHRlcm5fbWF0Y2hf
c3RyaW5nKHBhdCwgcmRfbG93ZXIpKSB7DQo+ID4+PiAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gPj4+IC91c3IvaW5jbHVkZS9nbGliLTIuMC9n
bGliL2dwYXR0ZXJuLmg6NTc6MTU6IG5vdGU6IGRlY2xhcmVkIGhlcmUNCj4gPj4+ICAgICA1NyB8
IGdib29sZWFuICAgICAgZ19wYXR0ZXJuX21hdGNoX3N0cmluZyAgIChHUGF0dGVyblNwZWMNCj4g
KnBzcGVjLA0KPiA+Pj4gICAgICAgIHwgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+
fn5+DQo+ID4+PiAvcm9vdC9xZW11L2NvbnRyaWIvcGx1Z2lucy9leGVjbG9nLmM6MzM5OjYzOiB3
YXJuaW5nOiBwYXNzaW5nDQo+ID4+PiBhcmd1bWVudA0KPiA+Pj4gMiBvZiDigJhnX3B0cl9hcnJh
eV9hZGTigJkgZGlzY2FyZHMg4oCYY29uc3TigJkgcXVhbGlmaWVyIGZyb20gcG9pbnRlcg0KPiA+
Pj4gdGFyZ2V0IHR5cGUgWy1XZGlzY2FyZGVkLXF1YWxpZmllcnNdDQo+ID4+PiAgICAzMzkgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ19wdHJfYXJyYXlfYWRkKGFsbF9yZWdfbmFtZXMs
DQo+ID4+IHJlZy0+bmFtZSk7DQo+ID4+PiAgICAgICAgfA0KPiA+PiB+fn5efn5+fn4NCj4gPj4+
IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdXNyL2luY2x1ZGUvZ2xpYi0yLjAvZ2xpYi5oOjMzOg0K
PiA+Pj4gL3Vzci9pbmNsdWRlL2dsaWItMi4wL2dsaWIvZ2FycmF5Lmg6MTk4OjYyOiBub3RlOiBl
eHBlY3RlZCDigJhncG9pbnRlcuKAmQ0KPiA+Pj4ge2FrYSDigJh2b2lkICrigJl9IGJ1dCBhcmd1
bWVudCBpcyBvZiB0eXBlIOKAmGNvbnN0IGNoYXIgKuKAmQ0KPiA+Pj4gICAgMTk4IHwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdwb2ludGVyDQo+ID4+IGRhdGEp
Ow0KPiA+Pj4gICAgICAgIHwNCj4gPj4gfn5+fn5+fn5+fn5+fn5+fn5+Xn5+fg0KPiA+Pj4NCj4g
Pj4NCj4gPj4gSGk7IHRoYW5rcyBmb3IgdGhpcyBwYXRjaC4NCj4gPj4NCj4gPj4gVGhpcyBmaXhl
cyBhIGJ1ZyByZXBvcnRlZCBpbiB0aGUgYnVnIHRyYWNrZXIgc28gd2Ugc2hvdWxkIHB1dA0KPiA+
Pg0KPiA+PiBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0v
aXNzdWVzLzIyMTANCj4gPj4NCj4gPj4gaW4gdGhlIGNvbW1pdCBtZXNzYWdlIGp1c3QgYWJvdmUg
eW91ciBzaWduZWQtb2ZmLWJ5IHRhZy4NCj4gPj4NCj4gPj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6
IFlhbyBYaW5ndGFvIDx5YW94dC5mbnN0QGZ1aml0c3UuY29tPg0KPiA+IEkgd2lsbCBpZiBuZWVk
ZWQuDQo+ID4NCj4gPj4+IC0tLQ0KPiA+Pj4gICBjb250cmliL3BsdWdpbnMvZXhlY2xvZy5jIHwg
NyArKysrKystDQo+ID4+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvY29udHJpYi9wbHVnaW5zL2V4ZWNs
b2cuYyBiL2NvbnRyaWIvcGx1Z2lucy9leGVjbG9nLmMNCj4gPj4+IGluZGV4IGExZGZkNTlhYjcu
LjQxZjY3NzQxMTYgMTAwNjQ0DQo+ID4+PiAtLS0gYS9jb250cmliL3BsdWdpbnMvZXhlY2xvZy5j
DQo+ID4+PiArKysgYi9jb250cmliL3BsdWdpbnMvZXhlY2xvZy5jDQo+ID4+PiBAQCAtMzI3LDgg
KzMyNywxMyBAQCBzdGF0aWMgR1B0ckFycmF5ICpyZWdpc3RlcnNfaW5pdChpbnQgdmNwdV9pbmRl
eCkNCj4gPj4+ICAgICAgICAgICAgICAgZm9yIChpbnQgcCA9IDA7IHAgPCBybWF0Y2hlcy0+bGVu
OyBwKyspIHsNCj4gPj4+ICAgICAgICAgICAgICAgICAgIGdfYXV0b3B0cihHUGF0dGVyblNwZWMp
IHBhdCA9DQo+ID4+IGdfcGF0dGVybl9zcGVjX25ldyhybWF0Y2hlcy0+cGRhdGFbcF0pOw0KPiA+
Pj4gICAgICAgICAgICAgICAgICAgZ19hdXRvZnJlZSBnY2hhciAqcmRfbG93ZXIgPQ0KPiA+Pj4g
Z191dGY4X3N0cmRvd24ocmQtPm5hbWUsIC0xKTsNCj4gPj4+ICsjaWYgR0xJQl9WRVJTSU9OX01B
WF9BTExPV0VEIDwgR19FTkNPREVfVkVSU0lPTigyLCA3MCkNCj4gPj4NCj4gPj4gRWxzZXdoZXJl
IHdlIGRvIGdsaWIgdmVyc2lvbiBjaGVja3Mgd2l0aA0KPiA+Pg0KPiA+PiAjaWYgR0xJQl9DSEVD
S19WRVJTSU9OKDIsIDcwLCAwKQ0KPiA+PiAgICAgIGNvZGUgZm9yIDIuNzAuMCBhbmQgdXA7DQo+
ID4+ICNlbHNlDQo+ID4+ICAgICAgY29kZSBmb3Igb2xkZXIgdmVyc2lvbnMNCj4gPj4gI2VuZGlm
DQo+ID4+DQo+ID4+IHNvIEkgdGhpbmsgd2Ugc2hvdWxkIHByb2JhYmx5IGRvIHRoYXQgaGVyZSB0
b28uDQo+ID4+DQo+ID4+PiAgICAgICAgICAgICAgICAgICBpZiAoZ19wYXR0ZXJuX21hdGNoX3N0
cmluZyhwYXQsIHJkLT5uYW1lKSB8fA0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgIGdfcGF0
dGVybl9tYXRjaF9zdHJpbmcocGF0LCByZF9sb3dlcikpIHsNCj4gPj4+ICsjZWxzZQ0KPiA+Pj4g
KyAgICAgICAgICAgICAgICBpZiAoZ19wYXR0ZXJuX3NwZWNfbWF0Y2hfc3RyaW5nKHBhdCwgcmQt
Pm5hbWUpIHx8DQo+ID4+PiArICAgICAgICAgICAgICAgICAgICBnX3BhdHRlcm5fc3BlY19tYXRj
aF9zdHJpbmcocGF0LCByZF9sb3dlcikpIHsNCj4gPj4+ICsjZW5kaWYNCj4gPiB0aGFua3MsIEkg
Z290IGl0Lg0KPiA+DQo+ID4+DQo+ID4+IFJhdGhlciB0aGFuIHB1dHRpbmcgdGhpcyBpZmRlZiBp
biB0aGUgbWlkZGxlIG9mIHRoaXMgZnVuY3Rpb24sIEkNCj4gPj4gdGhpbmsgaXQgd291bGQgYmUg
ZWFzaWVyIHRvIHJlYWQgaWYgd2UgYWJzdHJhY3Qgb3V0IGEgZnVuY3Rpb24gd2hpY2gNCj4gPj4g
ZG9lcyB0aGUgcGF0dGVybiBtYXRjaGluZyBhbmQgd2hvc2UgYm9keSBjYWxscyB0aGUgcmlnaHQg
Z2xpYg0KPiA+PiBmdW5jdGlvbiBkZXBlbmRpbmcgb24gZ2xpYiB2ZXJzaW9uLiBXZSBnZW5lcmFs
bHkgY2FsbCB0aGVzZSBmdW5jdGlvbnMNCj4gPj4gdGhlIHNhbWUgYXMgdGhlIGdsaWIgZnVuY3Rp
b24gYnV0IHdpdGggYSBfcWVtdSBzdWZmaXggKGNvbXBhcmUgdGhlDQo+ID4+IG9uZXMgaW4gaW5j
bHVkZS9nbGliLWNvbXBhdC5oKSwgc28gaGVyZSB0aGF0IHdvdWxkIGJlDQo+IGdfcGF0dGVybl9z
cGVjX21hdGNoX3N0cmluZ19xZW11KCkuDQo+ID4+DQo+ID4+PiAgICAgICAgICAgICAgICAgICAg
ICAgUmVnaXN0ZXIgKnJlZyA9IGluaXRfdmNwdV9yZWdpc3RlcihyZCk7DQo+ID4+PiAgICAgICAg
ICAgICAgICAgICAgICAgZ19wdHJfYXJyYXlfYWRkKHJlZ2lzdGVycywgcmVnKTsNCj4gPj4+DQo+
ID4+PiBAQCAtMzM2LDcgKzM0MSw3IEBAIHN0YXRpYyBHUHRyQXJyYXkgKnJlZ2lzdGVyc19pbml0
KGludCB2Y3B1X2luZGV4KQ0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgIGlmIChkaXNhc19h
c3Npc3QpIHsNCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ19tdXRleF9sb2NrKCZh
ZGRfcmVnX25hbWVfbG9jayk7DQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICgh
Z19wdHJfYXJyYXlfZmluZChhbGxfcmVnX25hbWVzLA0KPiA+Pj4gcmVnLT5uYW1lLA0KPiA+PiBO
VUxMKSkgew0KPiA+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICBnX3B0cl9hcnJheV9h
ZGQoYWxsX3JlZ19uYW1lcywNCj4gcmVnLT5uYW1lKTsNCj4gPj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZ19wdHJfYXJyYXlfYWRkKGFsbF9yZWdfbmFtZXMsDQo+ID4+PiArIChncG9p
bnRlcilyZWctPm5hbWUpOw0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGdfbXV0ZXhfdW5sb2NrKCZhZGRfcmVnX25hbWVf
bG9jayk7DQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiA+Pg0KPiA+IEkgdGhpbmsg
aXQncyBub3Qgd29ydGggYWRkaW5nIHRoaXMgdG8gZ2xpYi1jb21wYXQuaCB0b28uDQo+ID4NCj4g
Pj4gdGhhbmtzDQo+ID4+IC0tIFBNTQ0KPiA+DQo+ID4gdGhhbmtzDQo+ID4gWGluZ3Rhbw0K

