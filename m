Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F877C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 07:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwzJL-0006H6-FN; Wed, 17 Apr 2024 03:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rwzJH-0006Gp-U6
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 03:02:24 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rwzJD-0001wu-1H
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 03:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1713337339; x=1744873339;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Eu979Jh3JZra+F/lcz2WRk7a9bCjLUAv+I8wS5TE7RQ=;
 b=gbwb/OpMmzAVuG6+7HblJPedWVslT6DR+KXs0nndVVzhgHLRbT5pByUF
 DFmPN0nfFgCnEGGBphMnGQSL1VjqqpnH8hlurAYNEPaiZeX4RytZbHmST
 PLrqNmj8zpJiv726ni8lA8F3Y149EW568fDW1HPn2Chd6kToFZdZgJSkq
 AMY9kS/Hle2cmuEUF3F1xDMlEu/+TvHaP3WxncAdAtrJr74SsLvgl9xcY
 pFjuRBpquXtLwgwXAwE+sB8ZMSvmUPBXMuDb8jsUb25++ATy9nU/pFDmt
 ycCCsgvH1vGcigAb1i+yT5yubv4Pp+NmFT8mjdJ/MnD9FaooxtpbM/4et w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="116663373"
X-IronPort-AV: E=Sophos;i="6.07,208,1708354800"; d="scan'208";a="116663373"
Received: from mail-japaneastazlp17011004.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2024 16:02:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyHDN2L6meWB+J4hYBo5gmGi3ed6SwXZOfcTnil6fAQUpehyldLfw9qTGDq6KsSbvhykxaMN8EI3f+6USpyjLMpOtCuk+y7lDQlNT6bldULRdKwgPC1nIu6v4bRzs8L/Wwq0WGbBw7xU4wyhiTSERx6FE0QsEtAwxLZWDIHyIqFpSzaprp1gocU83Obe9bdYhlKAvtNpCTY195EzoPWP6xs/8GD5Gunz7vHI9h2M9lFUYLvqKTDX3n7E3BN9GavSir575kk+Q5zKg4WPgyiXLwUb3rSQScu4rLQo+fYJEI8xMLCP7Vq2h9wQcWhXfCZ5Z8nGa9O8T1E8qFl25Mip+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu979Jh3JZra+F/lcz2WRk7a9bCjLUAv+I8wS5TE7RQ=;
 b=RJSc/FolCBbX7/VqWc+UfS7iiwAaRjxIqGdVRXYggl0ojMu5PERtXfzMHkljLn+BawDX94KK3CsOR/A4QYobnzw5NyRZ6DoNyR+eo9/nvzS5YVCwPF5I9ZXxQTkyWbWPNddReMQp+GuXjTn/LgvJiL05Qr8iLPsN9HRz5/1cVk04PFbE+aLxypQ/adUMbdLqTuq3NWsFOqxWWDDDA7TTKV0zUvgqKrF7WyQGQU41Y8Ts7ncHnOkGrMlu7SlXe2fps9IDO9KG9Q1etOvEza2RusAFDnTejZWpv6yhYDWmP6itRYVgafSJC5WMkhSp+KR8ZDWm0VbB7NtpQxbEcsoLRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSZPR01MB9456.jpnprd01.prod.outlook.com (2603:1096:604:1d8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.51; Wed, 17 Apr
 2024 07:02:09 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::8f3e:a36f:e4bb:8d33]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::8f3e:a36f:e4bb:8d33%6]) with mapi id 15.20.7452.046; Wed, 17 Apr 2024
 07:02:09 +0000
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "zhanghailiang@xfusion.com" <zhanghailiang@xfusion.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "chen.zhang@intel.com"
 <chen.zhang@intel.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong
 <xiechanglong.d@gmail.com>
Subject: Re: [PATCH v2] migration/colo: Fix bdrv_graph_rdlock_main_loop:
 Assertion `!qemu_in_coroutine()' failed.
Thread-Topic: [PATCH v2] migration/colo: Fix bdrv_graph_rdlock_main_loop:
 Assertion `!qemu_in_coroutine()' failed.
Thread-Index: AQHakHJf0hDxNp4iJkm42T2+zVyWvbFr+9+AgAANjYA=
Date: Wed, 17 Apr 2024 07:02:09 +0000
Message-ID: <d1783584-ff29-43a9-937f-57a039ccdecc@fujitsu.com>
References: <20240417025634.1014582-1-lizhijian@fujitsu.com>
 <84c98291-c9a4-4349-9143-aff61e06c125@linaro.org>
In-Reply-To: <84c98291-c9a4-4349-9143-aff61e06c125@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSZPR01MB9456:EE_
x-ms-office365-filtering-correlation-id: dce1b9b1-c931-47d4-0e26-08dc5eac4cbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 95tTNc0mqQT2JuJxyQIa4mMnQEn4wayaRTn+4y5+h5GpDiAoFX2S6HLp9x4YKD1RwAAwZvmFA/UNbwFrItWEjzT5rTkqUu3h/qLAjQhSIydAUpyAb+qPEv0F2XL/ksv9VqPCDSX3Tz1/R9ZVsuaVcTgTsb23mXOoL+FebVPNpL81DOCGt3ArH4p+OVQdVY2+tI+vfeaS9jPuavYgENsTuEPxcmCM1W+RBZebUG/Vpyvt34GthPRDDKCGQp9ooFBkIqoE8tE7yFZvTkw3V0YiM8rQJaMCpvl+JyJ396KyvAAfD8+/mUBKTcrLU6aAZ4d8TozD4K+pgz16GqiqyJYOINvHPNIvUr7WVRHNNfaeQRvLOQiTRUbLcPulFiV6EpSE47rrF2RMKZNy7YaMcOPxusZ/rBScnHJQ7CZoNlPj+BACh15Q5yOODXsV9htt9N9VOLRttWL8OCZ2M0gal5nREdhnPULZM8+D9bp2UqT5A7srkL6Mzjexy27JfYCrzpalKO/mpaEfmg3fKW6x2LZpdxxmEQzOWPYi+0TI3NYw9n3futr1RC4p/01ahdQ7BIfx8w1MS01Lbt66Lb4zrC+qK0kK8MZo53IXsoCy521I5oePIZA6AQr+WKaVnAM30B89GI/yFFvZg2mfXVJXfRVbYe8FfZYmmtcNZwTtdBdOMuO0VNkYCV45XZf2hs5Q3Up7xCzwF0S+4s4ojTCyXLjt8Jp8WkdxExrF/Pcr7/zmgmSsKPc62xeL2w5t+YhWOm2/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(1580799018)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckIzM3JRRXVzaHhra0ZNdWNXc0VGTXo1aWp0ejZ5S0JTVkxHbmcxRzdNNUFC?=
 =?utf-8?B?dlVzRmpxWmtEbGg4bEZSQ3FvKy9PcXVrNURnWjZQZVpTV1R2NmtmNWVDN0Zo?=
 =?utf-8?B?VThGS3FLUkRXZFc4R0RmRGNWakcwN3BRdG1qeFRycng5STJ0dzNzNUxKb3Rr?=
 =?utf-8?B?a01YcjNBcVB1R2ROK3NGU2U1Mmo0c251ZndIaEVoL1V3L0cwVDZsMVJoT09k?=
 =?utf-8?B?eS9ER0FLY2V0cGRSWnpMbHZIbVlwMFJVT0x0dGVJODVuQXdoajJ2ajFGSDk3?=
 =?utf-8?B?alFNU1VybFpwVmtmVFUveUtpV3hFTmpkVzBmbHAwNllYWmZSTVRNdkJXNkdo?=
 =?utf-8?B?RDFWNU93ZUE4K3ZodjFjcVoxSUQwSUR3QjNqdkRRUnIyY3lHOVc3UG1SYlJY?=
 =?utf-8?B?OG9xYlZLTHBwNkptS3p0R0dDM3liSnZIQTJpWEk3SStTT3JUWGM2MjZwcDd6?=
 =?utf-8?B?QktDNVpIV3F2Q1BHSDQyT1RQRFY0S2Z0NHBSaGppQnNFZnczSDVEcFF4UmVq?=
 =?utf-8?B?b2xHMkE2dEhzT0pNNC9ua2xLYjh5cDVUOWRlYXErUEw3eE9aMW9HZ2xGL3NY?=
 =?utf-8?B?SXNudUNJeDAranlLdFdsOU5zZE5MSDQrUEVmREd3SmNmRHZrak54Q1VXQllD?=
 =?utf-8?B?YmFSdkhBcWFaUHc0UXlPMGFTdDVqOW1tOUdsQ202ZWo5cDdNUjF2WHBlbHBh?=
 =?utf-8?B?cmkrUm5DbDA3cHlMQ2tyNW52Y2NiMGorM3dtOXd2ZGNNZ2VJOEVENG5OVlQz?=
 =?utf-8?B?Rm1TTjJ1eUd6TmlwM3BnenlvT3dKbDk1MTBJT09FSm95OWZ3TDVaTi9tZmMz?=
 =?utf-8?B?MWJyZDdrNEZZaTNzdUh3ZlBRWmg5MU9WTTY2YTdtcUh0T2J3TG1RRmNFUjVZ?=
 =?utf-8?B?TFQwc0k5YUwyRU54TTA2UHdiMUJKTm1CZ2E0S0N0d0taTS96WlBrVzhJaTZO?=
 =?utf-8?B?WjllUVlhTkNsZFNCendPRG4zTGlEMGFxcHdBNUpBZ25PQkU2b1FmdXYvUkcy?=
 =?utf-8?B?SE5lQzB5QW9nTGs1dVlYclUzNHQyNkJ6WW81ZERnZ0U5K2xEMWZjVnRYUXRT?=
 =?utf-8?B?TTE0VnJZRDZHLzVGVkkvMmUrYkQwWXUrQ1dvMWxtZ2x6YjFOYTBPSmQ0dWt0?=
 =?utf-8?B?M1pWckZaaEZ2UkhMQjcrRlROODhFajMxazMyQlNyTk1UbmRoVGc5dzBzUnlC?=
 =?utf-8?B?Z2JSQ0JvTmxQT1VnTGdoL0ZIZ3dkbzRxYURRb3lpNS9KUDJsaDZvczNQalVu?=
 =?utf-8?B?SmRZdURHSWNLSG45VVRjMEZmWmNUL1l0WnlLcmJncFU3YXB2VURwcXRDZXhK?=
 =?utf-8?B?QmF1ZzNlcnA2Z3VxZUEwa0dOUDVJdjhCbWxkdnZUdmwxWktXdTh4bjQ4UUth?=
 =?utf-8?B?TUszTTRHTndVZ0FGMWptdHhxdEV3ZGhYWXVEWWZONHJpa1YyYzRoVFRpSTg2?=
 =?utf-8?B?SWRaV3U3aTlMQzlkdmZ4c0NSRm1BWkY4T2J1dzk5VEVqa0hGYzM5VWtzM3FO?=
 =?utf-8?B?ZXg4QWFwaVhwMnk4YTJTaDBtVi9LdCtFMUpTMDRWL2NYTTIxMGQ0TjFDWVJZ?=
 =?utf-8?B?Q2JRekp5ZDcwbWdLYnRpVXVnMEx3WkJiMHRueStDTTc5Z3hiZnkvbVovYUN3?=
 =?utf-8?B?YnMvNGdGdndxS1dkang3cURYZUhMcTBZcUFKZzJPeFNuZTJhbmE5QjVFUktq?=
 =?utf-8?B?YVpsNVZmaGl2ZHJHR0xmbDFZaTlaTFAvRjBrc2FXdG9XY3JSd3ZpK24wQytZ?=
 =?utf-8?B?ZG52Wk91VVZwMmFTRDdsbytCeG9SSkRsZzR1ckN6NVF4TW1QbTRzOTVRbC9P?=
 =?utf-8?B?UG5laVJvZzVqOXdRSFlTcEF2aS8xRFdOdnpPaXI0dEJoTlEzUjVUSFhKN2h0?=
 =?utf-8?B?MjM1VGh0eTlGU1VOVld1b2NwYUZJbGF5aS85L0E4L1Y5cURIR0dXN2d2SXRy?=
 =?utf-8?B?cjVmbGk2QnFoeHc2dUo1MTNQN1FwVkNmTk0xVmd0Q0Vmakx5bEU0R1YwU21n?=
 =?utf-8?B?RlVhRUN4c0t5eUlleEttYzNuWC9rU3lCRXlWSlZJK0taaHhnaFNXdGF6K3hn?=
 =?utf-8?B?US82eWdxc083UW1WNHpLc2pZUm1FRmlCQWJ2K0pLRDgzNVFab2dqcUphenFi?=
 =?utf-8?B?QWJ1eUtKdEhFZExRS2Y4TjBmTUFaSXZmV1FSQ0JvR1VBWHU1bTA3djZubEJq?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E572083E90EF4A4DAAA593FB7A4C317C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qEsG4oJw0WV3LFyXo3gii+SJJvV6JfRJAMPKIMcLS5H/AhVVX7cTgFmNcHk7OpMbGiAuDXNw/ert4HbNExkpgj0Z3r1k9SRRrhvJGV5yNzalUheBCYjaNqgTjnjc2ATewslxLL5Ec1VMipLDwI6ELpBptpsZz7F7xfCA8w1kOI7e1d7k/7UxkSBsfrgE/it+VrijEaaWjiosQ6T39QvQw8+Aurri/5EIZLmzVO/bp4KZeV75kznOJ70cEcUOTcC7t1heyMgtLoEuO54/D/gB/6snckyeW+NKO2N8hR5QHbn5Nh/YsXPGExCTNXMU0NOZ7kgJ7ROf7POFNuB8xHD15v+snnqrFywrDrOgCGFYBELfnSfPLaf5xuyks3qtoeUvXmLywhD2gd4MMWpjb4CHNBEaM2Tt4hAgAZhOD/itIxauO15v+QJsrIqNw1QtgyHQFYyHnv6WYk4HPGKa83YU5MbmY9rrmcW1PbqY/7zGnN8ITywiswiRWwJd3FZuAIAoLfO9b5zQ5tIYedrVTu/ez29VbYqGGtWlTJCrWtrnxqrHrCgkG6StRs7kNbb6khCH/dW0c/oA+ugXma7/f0e1oeJkqCWT4Oc0HY0g2np+k1jU+9O6y/KtMYD6Ktfcu5dl
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce1b9b1-c931-47d4-0e26-08dc5eac4cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 07:02:09.4591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lTHjr4fUeC0AN+VFzupWkBmEMwEK+3JSiulIqRzl8E6YphA7lyaByuhnJABZE+JaGoLDdY3JJqfDRzHlOXmAXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9456
Received-SPF: pass client-ip=68.232.156.96; envelope-from=lizhijian@fujitsu.com;
 helo=esa13.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDE3LzA0LzIwMjQgMTQ6MTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0K
PiBPbiAxNy80LzI0IDA0OjU2LCBMaSBaaGlqaWFuIHZpYSB3cm90ZToNCj4+IGJkcnZfYWN0aXZh
dGVfYWxsKCkgc2hvdWxkIG5vdCBiZSBjYWxsZWQgZnJvbSB0aGUgY29yb3V0aW5lIGNvbnRleHQs
IG1vdmUNCj4+IGl0IHRvIHRoZSBRRU1VIHRocmVhZCBjb2xvX3Byb2Nlc3NfaW5jb21pbmdfdGhy
ZWFkKCkgd2l0aCB0aGUgYnFsX2xvY2sNCj4+IHByb3RlY3RlZC4NCj4+DQo+PiBUaGUgYmFja3Ry
YWNlIGlzIGFzIGZvbGxvd3M6DQo+PiDCoCAjNMKgIDB4MDAwMDU2MWFmNzk0ODM2MiBpbiBiZHJ2
X2dyYXBoX3JkbG9ja19tYWluX2xvb3AgKCkgYXQgLi4vYmxvY2svZ3JhcGgtbG9jay5jOjI2MA0K
Pj4gwqAgIzXCoCAweDAwMDA1NjFhZjc5MDdhNjggaW4gZ3JhcGhfbG9ja2FibGVfYXV0b19sb2Nr
X21haW5sb29wICh4PTB4N2ZkMjk4MTBiZTdiKSBhdCAvcGF0Y2gvdG8vcWVtdS9pbmNsdWRlL2Js
b2NrL2dyYXBoLWxvY2suaDoyNTkNCj4+IMKgICM2wqAgMHgwMDAwNTYxYWY3OTE2N2QxIGluIGJk
cnZfYWN0aXZhdGVfYWxsIChlcnJwPTB4N2ZkMjk4MTBiZWQwKSBhdCAuLi9ibG9jay5jOjY5MDYN
Cj4+IMKgICM3wqAgMHgwMDAwNTYxYWY3NjJiNGFmIGluIGNvbG9faW5jb21pbmdfY28gKCkgYXQg
Li4vbWlncmF0aW9uL2NvbG8uYzo5MzUNCj4+IMKgICM4wqAgMHgwMDAwNTYxYWY3NjA3ZTU3IGlu
IHByb2Nlc3NfaW5jb21pbmdfbWlncmF0aW9uX2NvIChvcGFxdWU9MHgwKSBhdCAuLi9taWdyYXRp
b24vbWlncmF0aW9uLmM6NzkzDQo+PiDCoCAjOcKgIDB4MDAwMDU2MWFmN2FkYmVlYiBpbiBjb3Jv
dXRpbmVfdHJhbXBvbGluZSAoaTA9LTEwNjg3NjE0NCwgaTE9MjIwNDIpIGF0IC4uL3V0aWwvY29y
b3V0aW5lLXVjb250ZXh0LmM6MTc1DQo+PiDCoCAjMTAgMHgwMDAwN2ZkMmE1Y2YyMWMwIGluwqAg
KCkgYXQgL2xpYjY0L2xpYmMuc28uNg0KPj4NCj4+IENDOiBGYWJpYW5vIFJvc2FzIDxmYXJvc2Fz
QHN1c2UuZGU+DQo+IA0KPiBDYzogcWVtdS1zdGFibGVAbm9uZ251Lm9yZw0KPiANCj4+IENsb3Nl
czogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vaXNzdWVzLzIyNzcNCj4+
IEZpeGVzOiAyYjM5MTJmMTM1ICgiYmxvY2s6IE1hcmsgYmRydl9maXJzdF9ibGsoKSBhbmQgYmRy
dl9pc19yb290X25vZGUoKSBHUkFQSF9SRExPQ0siKQ0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhp
amlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiBWMjogZml4IG1pc3Npbmcg
YnFsX3VubG9jaygpIGluIGVycm9yIHBhdGguDQo+PiAtLS0NCj4+IMKgIG1pZ3JhdGlvbi9jb2xv
LmMgfCAxOCArKysrKysrKysrLS0tLS0tLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNl
cnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9taWdyYXRpb24v
Y29sby5jIGIvbWlncmF0aW9uL2NvbG8uYw0KPj4gaW5kZXggODQ2MzJhNjAzZS4uNTYwMGE0M2Q3
OCAxMDA2NDQNCj4+IC0tLSBhL21pZ3JhdGlvbi9jb2xvLmMNCj4+ICsrKyBiL21pZ3JhdGlvbi9j
b2xvLmMNCj4+IEBAIC04MzUsNiArODM1LDE2IEBAIHN0YXRpYyB2b2lkICpjb2xvX3Byb2Nlc3Nf
aW5jb21pbmdfdGhyZWFkKHZvaWQgKm9wYXF1ZSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gTlVMTDsNCj4+IMKgwqDCoMKgwqAgfQ0KPj4gK8KgwqDCoCAvKiBNYWtlIHN1cmUgYWxsIGZp
bGUgZm9ybWF0cyB0aHJvdyBhd2F5IHRoZWlyIG11dGFibGUgbWV0YWRhdGEgKi8NCj4+ICvCoMKg
wqAgYnFsX2xvY2soKTsNCj4gDQo+IE5vdGUgdGhlcmUgaXMgYWxzbyB0aGUgY29udmVuaWVudCBC
UUxfTE9DS19HVUFSRCgpIG1hY3JvLg0KDQpUaGFua3MgZm9yIHlvdXIgcmVtaW5kZXIsIFBoaWxp
cHBlLg0KDQpJSVVDLCBCUUxfTE9DS19HVUFSRCgpIHdpbGwgbG9jayBhbGwgdGhlIHJlc3QgY29k
ZSB0aWxsIHRoZSBzdWJyb3V0aW5lIGVuZHMuDQpTbyBpdCdzIG5vdCBzdWl0YWJsZSBmb3IgdGhp
cyBjYXNlIHdoZXJlIHdlIG9ubHkgbmVlZCBhIHBhcnRpYWwgY3JpdGljYWwgc2VjdGlvbi4NCg0K
DQpUaGFua3MNClpoaWppYW4NCg0KDQo+IA0KPj4gK8KgwqDCoCBiZHJ2X2FjdGl2YXRlX2FsbCgm
bG9jYWxfZXJyKTsNCj4+ICvCoMKgwqAgaWYgKGxvY2FsX2Vycikgew0KPj4gK8KgwqDCoMKgwqDC
oMKgIGJxbF91bmxvY2soKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCBlcnJvcl9yZXBvcnRfZXJyKGxv
Y2FsX2Vycik7DQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5VTEw7DQo+PiArwqDCoMKgIH0N
Cj4+ICvCoMKgwqAgYnFsX3VubG9jaygpOw0KPj4gKw0KPj4gwqDCoMKgwqDCoCBmYWlsb3Zlcl9p
bml0X3N0YXRlKCk7DQo+IA==

