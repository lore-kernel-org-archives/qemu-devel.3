Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B816CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 10:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGx30-00023r-Sz; Thu, 06 Nov 2025 05:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vGx2z-00023e-EF; Thu, 06 Nov 2025 05:16:53 -0500
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vGx2x-0004aC-GN; Thu, 06 Nov 2025 05:16:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxWjjA+SI/2t22cR0qNvwIos1/xLuqKp8fL6DGDCBDoEe2lK9FOV1ALZjHAG4Vp3XzouH/wFzIXqOr/P1rp57vih0XI+woosTg3NYCL8kBhgLCI63KehBENt5NXagbiE3FoINGpd+4d2YOM80N3WXVNxM/bI3KjD9VQz07UwjAZ80l0Y31fw0mPKCVZp+fVcP1HfHH9I4436a9jUwHtlLkhD54Jtkcru5loYgu7RTLZ4LT6U3Q11Nd7GclWarBmRrmLMRT+hjKdhf0RsEMp/h+wrqn9aWM4iAHQgCasTLPR7i/tWeKS/Cwsz3UvMy5aVCG4Ad2qFMwaull7stD4iqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zwfh+mXvM9lJBlrchTTG9suLsc/qbu1JuCc7X6yk5w=;
 b=Vgl+O/7g8IhkBUr12iOORX5n9SLUqr29AOFxVUSpyWMR2QLOjWXZlaAMrpaUwaED/VDftZNk6oQwC5apifAAjQ57tXRu7qUWx3SehcVX3fCuH7uUMfTT5UM9kCMEf5lizF0GoHLly6z0F/I8wULo9bQXpwb3GeL//9g/Qy+zwIdshGExMgcNUN7Ao8JmP1+aH+jg4OdFLLFUetUi099Ml2OpGiw3BIycdrp4ynqwGqn5eKdJm+XB4i/CrBEmKFfhEH+ipbnchQ0e01+rN8K2V4+phwftif/sqF44NO8Bo3NXy8x/OlPyNhADntnaDklFjsaBKoTj82PGCFxg6qd5iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zwfh+mXvM9lJBlrchTTG9suLsc/qbu1JuCc7X6yk5w=;
 b=P443LKwWnnQWgNU2XfQ53zDhRBWH9QdiLH02VDWq5or1dumrM4Wrwd0Bu2otUGv6R/l5k4iILnaBnNllw/cY+Ezmw+D47fnAilN4DhmLlLuWgvDHjcaQ0JT/uTtLR5kndlRPtrdvCShHMkYnQSXhjFDGhLIapesIVm7OvWGC/eY71fbxE8IOCwQHguaikUTExQ5wwLC0rdkU40w7H3wIZjUz849LZ6exd8YDtstL8VLRPPihb9iHR/LQ0pKCJwOh8OBUqXnJENfW/0dA5RBFVWwiKCLqC3cp/xPuib3j0rVZyM+5oPNF4EAysPfd7sqnCPbtLoOWaaTEKN+4Oemfog==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA4PR09MB4686.eurprd09.prod.outlook.com (2603:10a6:102:e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 10:16:44 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 10:16:44 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v1 0/1] riscv: Update MIPS vendor id
Thread-Topic: [PATCH v1 0/1] riscv: Update MIPS vendor id
Thread-Index: AQHcTZy0WB//FmK49UaNRcS3d/Iv/LTjJJOAgAJNGYA=
Date: Thu, 6 Nov 2025 10:16:44 +0000
Message-ID: <5301acd3-6e1e-41f0-9cf0-f262bd8c5521@htecgroup.com>
References: <20251104150708.3345289-1-djordje.todorovic@htecgroup.com>
 <CAKmqyKNV9Dc5-mszwg8aFCkqLiASLZ_u+dbLLyG_59usMAL6Mw@mail.gmail.com>
In-Reply-To: <CAKmqyKNV9Dc5-mszwg8aFCkqLiASLZ_u+dbLLyG_59usMAL6Mw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA4PR09MB4686:EE_
x-ms-office365-filtering-correlation-id: 7cf51927-0eec-496c-7765-08de1d1d9644
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?Unc0NjdsY20xOWZRY0ZxOHkyWkhaVW5way92QXp4NG1MS09meDJVdU1BMmdX?=
 =?utf-8?B?eVFVbWRic2lGRndqZHREMW1YNFk3bnh2NDBDTHR6RGRCc2doMTlaSGovbFFi?=
 =?utf-8?B?SE15QnpwM3R6bmpnZVBhMFRDbnExK0dJZUJzU0F3UXFYRjYzTnRwOEh5dXho?=
 =?utf-8?B?RXVnMTF5TkZ6RDVSZE4rR3VDUUlVa25hTUk3SjF4WXcxSEhFNTUwdlpta0hn?=
 =?utf-8?B?bVB2OHplTUtUSjdLUU1ic2lpaXUrUjhVb3ZxUlo4blc4bGJoRytKYTB6MXhh?=
 =?utf-8?B?Ymc5QXkrY0dSZ2ZkZXNpZGVTVDFac2IzTU9qUllOREdDM0FRb1llZ1IwNWhV?=
 =?utf-8?B?eWY3ZWpwZDZuMlZFR1M3cnN5RUl3ekcvYStjd01JUGR6cUxtOFpkM0tYaThu?=
 =?utf-8?B?WFdoZ3NCWS92YncrVitoT0dvMlBwR0JzUHFBYXE3UWN2aW1scEFjNmJZTkIw?=
 =?utf-8?B?S2RxbkU5R0lJTGRnYktydFdEaElUeDl2Nm95RnFIdnZRRnpZM0piVCtwNURS?=
 =?utf-8?B?THlWUmQzc2ozMkt5bVUvUWpzSWs0RGl5eHhxQ2FzMnlBdkkraTFPU1RwdVJ4?=
 =?utf-8?B?Si95NTBSNS8vL2x6YVlyWVd4c0ZkQXEyNzJLZnBwZzRwWWo5a2FpTXVmcVQ2?=
 =?utf-8?B?UFlNb2NWOVd6blU1YkxWYW5qRDBKRGNhY1BkWVQ4YmRSK2ZHVEN1bmtlbXVV?=
 =?utf-8?B?NkJzQUp6WHlOVlJSeEpFVG4vOWJUUml0aktEcVdCUFRYbDdRcDBtaDQ5Sktk?=
 =?utf-8?B?TktwamREWGcya0JaVHFpNWhxWEViZHdja0tMYmtzbWlZT2FRZEdxVVA4SHZB?=
 =?utf-8?B?dHY0cXFwbGdvdkdkTGtOZlZSMndHK3RzNHFaOGp1blZiQ0drZlZtMWl1VlNl?=
 =?utf-8?B?bjNWdzgxbCtXVzhPdldVQzF2M1cyK1M4cDAvUDlwM1pVVE0rVTNLMVZZb0Jm?=
 =?utf-8?B?QzBEeDNNZ2RQaGFIck81cEpzdzR4ZjAzVGRYMnlMSHpvc2FRSGIxQjVjbGxV?=
 =?utf-8?B?ZXJlTjJ2SG1ienFDd0dZZHh1VGRhejgzY25RWlRtM2RkNGJUa2ZiRVhxdC8v?=
 =?utf-8?B?dFJUWXEzTlAwTmdsNGpIczJrTkh5ckRzSmJxNDN3R3JoQ3kyU0ZXRlNwblVX?=
 =?utf-8?B?VytVRUY3eEVncXNYMFVIdXpiZDZQSGRVaW50T0ZXZXpsN0xQWm83cjhxcGVT?=
 =?utf-8?B?QkZlUFJyaHkwMk5WRUVpbWFqSkZ2SHhlYWp1eHBra3FBWVlIQWJmbWs5RXd1?=
 =?utf-8?B?ZTNpcUxqVjJzRkdrSEFVMmc4VGxTdnIvcjV1Q0lEaUNTTlRuTERHR0tKamIr?=
 =?utf-8?B?dXJhNDBRQUV1SmlVL1ZBcVRLM0FISU1QQmxIbzY0MG52ZlI3b2RKZllFZU8w?=
 =?utf-8?B?VEltR2hRT0dMVm1XcTZteUZ1WU9yU0lodnBBaDFFWTZDbW1GQUFtUEVrNDFX?=
 =?utf-8?B?NU56ZklpQmJVVDRWbTlQd2YvMlRXc3orM3kzbkR3NkZjbkI0b0t4K0xIa2Y3?=
 =?utf-8?B?aGdjcElNUXU5MjMrdDU0WlRwaDhOY00xcUlJNXVWQlpIUUtlbGhvQkhlK2RW?=
 =?utf-8?B?ZWh6c3B6Y1BZc3dWWVdOUEpja2xkYXBFZm5oZEIvdlVhRUw3TXl5K0xDQUp5?=
 =?utf-8?B?RGVnT05uUXNnQXpqNVBVZExNaEVWQzZ2bjV0dGxxZ1NWK3I4WlhYY1BnZWN1?=
 =?utf-8?B?a1BpMHBtMHhUVlRpWTlkZVVTRlV3RXByNGNSdmFQL1cxWXQ1aWpEcFJJVkxq?=
 =?utf-8?B?ZHo2c04wNTY5ZTY3dHFOUnFXcEc0Y3gwWEp6TkVnbUpORG9TSnZVSDZXY245?=
 =?utf-8?B?NERUQ3VVck5pa0FuNlZHaHZvVVNFa2o5b0JlVm1CTEFJWlZTOEhmbTI4RDhw?=
 =?utf-8?B?SjhBaURVYmcxWXdiRlV2Y1JBMGx1KzcwWVlqcGhQZTg3OExTbGxyT1M0UWUz?=
 =?utf-8?B?TVRaVXN6aGVyNE01KzlGcXk5cE8yZmt1d3A1UVBqQld4NVlnTFU2dnVlU1lx?=
 =?utf-8?B?dHJyZnNiWkJRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGROQWkrQ2F3bzVMdUI3d1M3YzZKR0VLZ2gvYTI1QTE5QW5GSDBGdEtGZC9W?=
 =?utf-8?B?T1c0UWljakYxMENDMkRUQ1JPa0Z6Z1QvUTZ5MCsrZzBSUzRFODFpN0NITXJV?=
 =?utf-8?B?YWU1U0JveUExTm8yMDlabGJ1R29TUHEyeVBGNDgzUTZSaStFT1V6VEhYK2lk?=
 =?utf-8?B?MHFjUEhYTDR0MUI1amNjU0xwNGJMdFlFbDRuWUpNYmo4citER3g1aHRPQ2Jw?=
 =?utf-8?B?WTJ2bGhiemNPOTYzaXBXSGY4amZqN3FDSEE0RVphNTlCZHRMazZiSWhOU2Vx?=
 =?utf-8?B?WHNDdXlLRWxaSlp0SmVUeXVJcVFUbGJKd0xUNHBqL1J4S0hIa0t3YktLSDlM?=
 =?utf-8?B?cHB4dFBxTGtmMlptWmQrK2RCOS9xanBlYXpnb0hkdEtQZkRhNU9MdmUxUUtj?=
 =?utf-8?B?aENxNFpIbHRZT2VKS1lCRHZYcHVqNUFoZXBrd3JwbjZ5UkFYeUdXK0cvK2NL?=
 =?utf-8?B?N2F6OXpPb2JiVFVNSmRXdGRpTHpSaC9wL2JWdWNSb0NBL0pUbVFveld1MEJn?=
 =?utf-8?B?djhlZitnNUJCMURxUFZOb0lrQzNtU1FLQ0JmSW5CcTkveTU0dnV0anRFWFE5?=
 =?utf-8?B?c3VFRnRZdGVzWGdnUTZWRXdQcmN2NlVSczJHSDZVY0EwM0tSY1U3UC9pTEMw?=
 =?utf-8?B?OXJEalAxMDU3b2FBYktNNGtnR0o0ZUxFY05BU3lHd2RlT2xzdkViU2cwcHFL?=
 =?utf-8?B?TndTcmp1YkgyVko5UDFqK0FzRTJuTGRvdzMxSWZEWFcvejlhNEcxV3lmRndv?=
 =?utf-8?B?aTNsVkUzS1NzTmpFRi82TzhUdytaMlNqdVI4SDg2UjZ0MkpHZGNQcWdpdS9t?=
 =?utf-8?B?cC9jR3MvVk0yQ1JURjd3WGxOakh6akhrOUM5eDRKSHlZbHpIcGtzWWtndW96?=
 =?utf-8?B?QXF3UVEyTDVySFNxZm43MFZtT2RWK0NORUtFMERFb28zZk1VVEJ4bkt0a21C?=
 =?utf-8?B?NCtzSU9mazNXdjdtQ1ZoS1BKSHdZcXM1aEsyTHdpSHl2SDgrTDVpQkJ0RWhm?=
 =?utf-8?B?MXFIWTlVaGlvYTVCb0lnNTVhQkVIb01ZaTlQTWJ0enltQkl0YTFrUTl5ZmdB?=
 =?utf-8?B?dENpMGNSb2NiKzFocmRMWTIwK3VBUFZTaWpQNWtHcHM3UDgxU1lrT25GcGVS?=
 =?utf-8?B?WFg0NVhCdlpKZFRjQlFodTFrOXZ3K0F0MUpmRjY4SWhrWGlCTjZEcU5mT1hT?=
 =?utf-8?B?Z21LMXdPNGxnMjUwQjFlR0MvRWV4ODlmVFRYRHpaSEN3MFU1RGtDc3puK0d4?=
 =?utf-8?B?VGppWTdZV1VJU0hjSkJiR1phbDZzbVRGcmI3WXpKVUVheHc3NWdsa3dLK0ty?=
 =?utf-8?B?NWQwQWl6RE5HZW9rbk02dVI4ajBOWWw4VGJUQnFOZlVOeU9HUVlXY1FYWEU5?=
 =?utf-8?B?Z296WDdXWE5GS0ovK0N6bis3T2J3ekhpbHlGQ0xselRpM1kwQWQ1VENxYklx?=
 =?utf-8?B?UjdLZGtaMjE3U2xTYzlOQWprMW1FYVUzcjZYcU5LUnpVTG9mTnVQSitIMHFZ?=
 =?utf-8?B?UzdRNktySjJ1dXMvNjA3MFR5VnZyMmd0eS84M3hzY3FaOERGL25hYXdKK3Ey?=
 =?utf-8?B?VHNVbkFxa3psd0s5N3hhbnViYTFLOWVWbUd4SHBibDBvbEJUSW55dExSd01B?=
 =?utf-8?B?ZUt1ZVVsKzZSN3hZaGlRSy93MnA1NkVjTGoxK21nejltS0V2WFlRc0RtZ1dn?=
 =?utf-8?B?K0R6cEk2b1BzV2Y4dytZSXZISG81cjlVUHN1R0gzV2tHZHppVTBZZ2JieFR4?=
 =?utf-8?B?YkRBWEhkK3hBR20zbnlvc084NzJOYkpWRjdpOVo1WUR3RFFZSDBsL2N6WEwv?=
 =?utf-8?B?UzlkdDRGUjJ2S0J0WnJoVy9iVmhqWkFEYkJhbjdFV1puZmdNamNWeXZtYzBP?=
 =?utf-8?B?U2pTMnArVFRjUjZ6UERtbVQ4Vkd5N21DRE1rV0JlaktkVHl5TzNNVGN3OEc3?=
 =?utf-8?B?OXFqUS9IbnIxZ0xYeTV6TjJMeTRjT0xCTjNnM3ZsNGlZQ0hhSDgvd2xjWTRv?=
 =?utf-8?B?MmkxdU42ZlpTeXZiQjV6Zk1vMkxLZkIybHRPc05UaWJXNHhqdDNmVjMrLzlI?=
 =?utf-8?B?eTJiblR6NmFSSkxrdDE2ZFRTQ2hveEEzVmtCMFh4RnM5bjZPa3FGTFlVVXFL?=
 =?utf-8?B?RCtEV1NHZ2VYVTFUd2V2RldHU1JtWGVvcWM4Z1ptUzNMTUp1ZHl4TnJEd0hO?=
 =?utf-8?Q?MjeOZV/kz45vy+NtpLjk6W8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4023F337E8FB224397E0D535A912E571@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf51927-0eec-496c-7765-08de1d1d9644
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2025 10:16:44.5140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kBFQ7VxwJF2Dam3WMWxoUbDoex7SsHzITrg6afsrJTrMoDuAa/FBlf8cHTJn709UYkb5u/+Qz0GXhQUKput8L7OQVCLJ+Omciz1fXSuWMPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR09MB4686
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

DQpPbiA1LiAxMS4gMjUuIDAwOjA4LCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBDQVVUSU9O
OiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24u
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2du
aXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gT24g
V2VkLCBOb3YgNSwgMjAyNSBhdCAxOjA34oCvQU0gRGpvcmRqZSBUb2Rvcm92aWMNCj4gPERqb3Jk
amUuVG9kb3JvdmljQGh0ZWNncm91cC5jb20+IHdyb3RlOg0KPj4gV2UgaGF2ZSBhbHJlYWR5IHNl
bnQgcGF0Y2ggc2V0IGZvciBpbnRyb2R1Y2luZyBNSVBTJ3MNCj4+IHA4NzAwIENQVSBpbiBxZW11
IGF0Og0KPj4NCj4+ICAgIGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDI1MTAxODE1NDUyMi43
NDU3ODgtMS1kam9yZGplLnRvZG9yb3ZpY0BodGVjZ3JvdXAuY29tLw0KPiBUaGF0IHNlcmllcyB3
YXMgZHJvcHBlZCBhcyBpdCBmYWlsZWQgdG8gcGFzcyB0aGUgQ0kgdGVzdHM6DQo+IGh0dHBzOi8v
cGF0Y2hldy5vcmcvUUVNVS8yMDI1MTAyMzA0MTQzNS4xNzc1MjA4LTEtYWxpc3RhaXIuZnJhbmNp
c0B3ZGMuY29tLw0KPg0KPiBZb3UgY2FuIGp1c3QgaW5jbHVkZSB0aGlzIGNoYW5nZSBpbiBhIG5l
dyBwYXRjaHNldA0KPg0KPiBBbGlzdGFpcg0KPg0KSGkgQWxpc3RhaXIsDQoNCg0KSSBhbSBsb29r
aW5nIGludG8gdGhlIA0KaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vam9i
cy8xMTgyNzA4MDkzOSNMNTg1OQ0KDQphbmQgaXQgc2VlbXMgdGhhdCBpdCBkaWQgbm90IGdldCB0
aGUgYmluYXJpZXMgZnJvbToNCg0KaHR0cHM6Ly9naXRodWIuY29tL01JUFMvbGludXgtdGVzdC1k
b3dubG9hZHMvcmF3L21haW4vcDg3MDAvZndfcGF5bG9hZC5iaW4NCg0KVGhlIHRlc3QgZm9yIEJv
c3RvbiBib2FyZCBzaG91bGQgdHJ5IHRvIGRvd25sb2FkIHRoYXQsIGJ1dCB0aGVyZSBpcyANClRJ
TUVPVVQgc2V0IGZvciBpdC4NCg0KDQpBbnkgYWR2aWNlIG9uIGhvdyB0byBjaGVjayB0aGlzIG9u
IHRoZSBzMzkweCBtYWNoaW5lPw0KDQpJcyB0aGVyZSBhIHdheSB0byBydW4gdGhlIENJIGZyb20g
YSBmb3JrPw0KDQoNClRoYW5rcyBhIGxvdCwNCkRqb3JkamUNCg0KDQo+PiBTbywgdGhpcyBpcyBh
IGJ1Z2ZpeCB0aGF0IHNob3VsZCBnbyBvbiB0b3Agb2YgaXQuDQo+Pg0KPj4gRGpvcmRqZSBUb2Rv
cm92aWMgKDEpOg0KPj4gICAgcmlzY3Y6IFVwZGF0ZSBNSVBTIHZlbmRvciBpZA0KPj4NCj4+ICAg
dGFyZ2V0L3Jpc2N2L2NwdV92ZW5kb3JpZC5oIHwgMiArLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiAtLQ0KPj4gMi4zNC4x

