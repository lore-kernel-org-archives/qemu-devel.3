Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C39CEB2D2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 01:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svRTy-0007Q3-Lj; Mon, 30 Sep 2024 21:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1svRTv-0007Nd-2g; Mon, 30 Sep 2024 21:15:16 -0400
Received: from mail-sgaapc01on2071c.outbound.protection.outlook.com
 ([2a01:111:f400:feab::71c]
 helo=APC01-SG2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1svRTs-0005ka-Cu; Mon, 30 Sep 2024 21:15:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGX5y7R2zmrP7jcyhvz2qhkDqG2uB/ivIjDdZefuSGpggz+MlLW11wIcSNDLdN7O6qosMMQLrcPw+b473CHZOysiXtCI3gEHTmlHcH4PNLFUd/y4Ao3UFpzM50c6eiFvf3E5MH64vhTSSvEpdc3zmyxVaRs2+sMJdtm7aF/QCSggBzTXXflKYc/yyaLizgnktdnx5YaNsHRJQaz7G/619ZsF5+TqzTdPpfetl7Qx18GKisaqCv+KdAdHY/7ObEp/kozJrUssiY13OFqFDJaDKSOtzzg5GLonqwnS0NrURzZkaVa+sPlgY91qptQAzY38a6Sflb+opa4Sm47X5s43ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsPfZMccgWwCUU/u+0NCOFIJdWhNdKN2u73Uz1Wd0i0=;
 b=kCButkh77AEjnvcug0laG7JDCA5RVNiwiQMoXqzv3jYPGZXQSYl1AMCjrnlbcgfLFbExaznqtGYCXGE7JF1Vi0CQJhcTr7rwLpU7iixehkubNizBAoJx0QJtxpury+ehAXXzftQ6Uns+izfWr68y2/a3EOmf6jnDQwh4r2aI1zcAFqjqlcyD/X/rFVh3AcfXWDXlcaudINwq5nj9GhDy/KrTPyBZ8kvLg/v2Ay3xrZ/1PHTxbNNeOPeX6hRIirItYIyScgs8PpYmziARk2A9txlltUt8Vky5/D8TosheYO75hAvNxsYzn80qVByBhgqNvSKz225ERDEqWGga5XaPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsPfZMccgWwCUU/u+0NCOFIJdWhNdKN2u73Uz1Wd0i0=;
 b=frtQdOcZza98AOlh5iCVN3y97hZ0OThumesgKaH0X9gGs+gKVtusOfziNz+wANoz1Xe3kQL/dIMxr1qFR2FJw8ZitUTVIOLbEERuwmnKMP8rHm84WKJdp1gXHqn6YdL6ARC0pjcOolWmwiNy1aF0g38IJ5lERhVVkuGUQpppbJOC8TwPDpTxL5wjfUNivKC0E2fcBC7lqc9HHOF1htt7azNChF6d7BTXFjGvxA4bbxXN0+0NajhbNy4ta+qtwdKu5OmM0EL86RzhyDvarWtN8bCeTabo+I9pgDiomkBicOfmkWZrwuln8DUyC4KtTqrYtyw5VY97wd2L9I76OtJG9A==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEZPR06MB5716.apcprd06.prod.outlook.com (2603:1096:101:ae::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.27; Tue, 1 Oct 2024 01:15:00 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 01:15:00 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Thomas Huth <thuth@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v6 8/8] hw/gpio/aspeed: Add test case for AST2700
Thread-Topic: [PATCH v6 8/8] hw/gpio/aspeed: Add test case for AST2700
Thread-Index: AQHbExYjUA5tJJdUfUubPj60l7DX3bJwh74AgAADN4CAAAneAIAAg1gg
Date: Tue, 1 Oct 2024 01:15:00 +0000
Message-ID: <SI2PR06MB504158B5D1DE2457C8C88BBBFC772@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240930085239.3089901-1-jamin_lin@aspeedtech.com>
 <20240930085239.3089901-9-jamin_lin@aspeedtech.com>
 <e3f31190-85fb-41c9-9ecb-eefdaa8c5c49@redhat.com>
 <2d7ef0e9-02ba-4a93-91c5-f6101c64b576@kaod.org>
 <283b488e-1f39-472a-806d-7b9031a8afb2@redhat.com>
In-Reply-To: <283b488e-1f39-472a-806d-7b9031a8afb2@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEZPR06MB5716:EE_
x-ms-office365-filtering-correlation-id: cc35483a-2ba2-4d3c-6a0c-08dce1b678a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bVFKNWZqR1FLelgwcklGcTlWWU1xR0Uyc0FGNFR6bi9HdEVlMytGTlE2QmFL?=
 =?utf-8?B?ZzJ2VlZiR1pFVm10bnJUMDNXQ2pWOVlQZXg2V3hJVHJNLzIzb0V6UHFoTlFB?=
 =?utf-8?B?bzRncFpGTG1KSmNneTYzRlVOeUlRTUFGcHlHSzd3bUQ0clhrVHVzS1h5ck5r?=
 =?utf-8?B?MmpMcnQ3bXEzNmVRRHZsSm1ES3gyVEZUQ2lDZVFCc1JEZDJxc3V6cGE2SG00?=
 =?utf-8?B?UlMzcGdlRW9LWmtZaEozeTJtaitTamc3czZDRWNtUUQwTC9IaG1IamdjSVN4?=
 =?utf-8?B?L1F2M2hOcE5sOVZXSmY5enl5UG1IRldvYXRjMTE5WFQ2TXdxOG80Qklra0Jv?=
 =?utf-8?B?amlsWlV5SjVrbmpQNGxHTENRNnB4WHVHdWRzd3lCS2RldFVXY1JkOW05TlBH?=
 =?utf-8?B?UllYaG9wbGtoVDA5dmFjOEN1ZzBod0orWTZVdngycm1KQ1hkS2kzZmxYTGFF?=
 =?utf-8?B?R1g2WThibENlV2xTSFp6cXQycWFKcEt5M2trYlJIb3IvZUlXaU9DYUtTdUg4?=
 =?utf-8?B?L0NGa2Z3dnpiS0NNZ0syZEJlbUE0VERzYVgxdGltNldLZURHMjIwTWkvY3hR?=
 =?utf-8?B?MnVjVFNrWFZhRWtNQjI1cytLeTVMMVcwNm1UMmQydmxrSGRYKzZ4YzhZeUxv?=
 =?utf-8?B?VHd3azdPOTRpVTAya0E1bkl4MkFZbVMzN0pYdnN6Z3dQWjVqYUsrSVN4TERK?=
 =?utf-8?B?RStieWFoN2RuQzdrWDltalE2eG42WmkzR1FNTTg2TGFCQnI3MDAzLzNzTnlK?=
 =?utf-8?B?NngvbWwyN3plMlEvUG1Ta2R6eVdsb3ZzeGtaWnYwc3pWM1pEMmNRb05Fc1p4?=
 =?utf-8?B?WWNab0w5b1l3b05aR3NDN2RuU0lwS2dRSUtzRWdDMDVaekVJa3E1VW5TSjVE?=
 =?utf-8?B?S3MySENvTlVpN1ZuU2l5eHNKczc0N1MxZklKRTZnVDYvZ240blNzU3lkU0Vt?=
 =?utf-8?B?cTdFTmx4VEJvWktKU2VTRENXWkFQZ1FTbU5LQllPTjM4ZWdacU9POWRDckFz?=
 =?utf-8?B?eHR3dzNJQ3ZzNjlFeXZmUmpnSmIwY28rSUF0Q3k0QjcxN3J1cU94MG5QYWxl?=
 =?utf-8?B?VWl3WDAwVkVyc1FPcmRYQXJCRlpDbjVQdUc2TXhKQ2plNVE2SU9QN1VYVUZM?=
 =?utf-8?B?Sm1ueG8zbEJFZmhLNXc4MGJnY3lsS1d1TmFsSFRDenYxd014M0Jwb3o3Ykly?=
 =?utf-8?B?YjViSjlrS3BiaG5BdUViUUowSms2L1FVRVphMEpaZGZSSmYzMU9FNjBCKzVH?=
 =?utf-8?B?NmNkdkM3bkpUTzNLZVhyQTg1NDIvL003bUxIZGRJa3RjeFpFVU1pRlZwVktu?=
 =?utf-8?B?MDl5ZTJWTWtiS2xOT01Icmdvc3k3U0o3ZnZXRHUwT3JHTmFKQ2VDazE4WjQ0?=
 =?utf-8?B?R1lrVk5xb0tBdHpXWHptQUc1c2RWTGVMUUwzSGlVSjdJWlIwV0F1UFoxOU9j?=
 =?utf-8?B?eWFiN0F0Z21kQmhDR2plbDhXeTd5UUpNNVZnQXd3bE40OHRlZW1KSjJoSkVC?=
 =?utf-8?B?ZXhSaG1NcStTQTgyeG5RYUY5NVFQQU9MMDc0K0FwMk5PQXJ4Tnl5T3FNQUEr?=
 =?utf-8?B?RU5US2VnemNqUG9qVG9KSkl0SElQYlNoeGxJOGpMTE1wYkoyV2dkSlNkUWIx?=
 =?utf-8?B?Rlp1MTdtS1RNc3V3UGw2Z09hbnRoY1NzVHJySDF4VndjNUw0L2lHVkJOaTlk?=
 =?utf-8?B?VEhPbkZkVUFQMmRMU1V1eElCeVBkZXFHb0VjNU9oSGhzRTUxNGdZc1laQ29U?=
 =?utf-8?B?YmNmazY0WEVZalhnNG9lRlVSRGxOYTQ3UGV1TzdheFZnYXRGQ2tZdjVPcGta?=
 =?utf-8?Q?zRVYlol0E9+WhwkpkPP1wWwyYDRRZC8UKIf7I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2IzQWtsR2RRb1dWejhoTlJrOFNrOVROVWZNSldLWCtyTVlWZ1k5a09HNktw?=
 =?utf-8?B?VjFReUdtcmdzMlhsUHlPU3kwdzh5cXZHbmcyTTdvYTdITStnYjh3OERaY3g1?=
 =?utf-8?B?cHd4ZmhuZUF3aEg1TmlSRGVpampmWjY0d1BvRnVZaEtrNzJwdUpoWXAybDgx?=
 =?utf-8?B?ZWFqTFB1VDBGelRGbTNvUHFIWXM4c092eks2dmRFVmhKaDZSTHo3TmlFRnVR?=
 =?utf-8?B?d0F1WE1VK3NacnkzOURjOG9XaW5LZzNJYkFGUkdEOVRNbmQweUZqWXdXL0hR?=
 =?utf-8?B?S1pYellGeDVCSVhueExVN3hmeFY2dHZQdURQVlVBV2V6aTVlNkFtNlJXS0Fi?=
 =?utf-8?B?NHBqYVVTditCNHZTdnorWUh1MC9DNUhJS1ZMNGVQQm5IaGVUVzlXWG1SRWdZ?=
 =?utf-8?B?UDIyNFIzVzdZSzFzbmtoeHF5UitzaklmU09CRERiOFd6alpsRktvc1IzSlc5?=
 =?utf-8?B?R1cwbmtiVWhEUS9SNEZ2azN2OGNzaHBiTExPRUpGV3BmVmRVdDJ4cFBjWXpM?=
 =?utf-8?B?T2s3SUJxcTdVK0dOQTlHanRwNE1OZnBzVG91dm5zWDNEaDd1VWZ3eUxHRGE3?=
 =?utf-8?B?Ym9oNDdESWx0STRKU0txeTBBZFQ0TitMMFBkSUpmYjNMRGRDd0ZPaHVJbGYv?=
 =?utf-8?B?aktRQkRtRXZQWStYSWJFaG9rQTVIcTBQazJZeDl2N0thSElCUVFCNEhvQ1RS?=
 =?utf-8?B?WnF5VHhnZitUcUE4c2M5U2F6WTBQMmJqdkJId1lUMndDUm9RaHBlTDkxdVZO?=
 =?utf-8?B?Q2JkbzVaRFZoK3ZST09XK0p4ZWhLR0QwYkQ5cUxmdzl3UVBKNW9GMHVXdlBK?=
 =?utf-8?B?M1prQkdWR0lBd3c0YXpPbTlTUnlWV3lBdHRoWXUvZlR1ODJlWTNyTmN5cldh?=
 =?utf-8?B?SXpnWC9jOGx0RlU1ei9pUlFyRyt1dmdZeXlNU0ZWelpTK29MT09MaWo1b3ly?=
 =?utf-8?B?ZTFsV0tjbEJBUjdnRjZ4Q0hZNzVxMTNSclFTcU1nc21VZFFsdW1OcFdHS2ht?=
 =?utf-8?B?U0plZEs5T1hWQlRFR1V1WlZya21iYjBqV052OStwS25RRDd6Y1BFT0EwWkw1?=
 =?utf-8?B?NEVzdS91MFRlUmE3eGJTZ0w3ZWwvN0NPV0ZKUVNqSVZnVzlPakhkcmRyeEVz?=
 =?utf-8?B?WVlORmZ4RkE0MUZqdHdLTmJnUXIxUXVLSE1FVWM0aVF6aUJPV1VPSHV2enhs?=
 =?utf-8?B?QVExOEpTWkhDQ0ZhRUdPMG1haUdMR0F3K1IrR3hKL2lmVFVPdXhFcVRValdW?=
 =?utf-8?B?bnJ1b09NL3M5OWM5UGhlRlArRGhUdHBmQ21BZnNTVHZ5VExCV2dNL1ZUL0V6?=
 =?utf-8?B?L09NWmFJWmc3TnUxUTUvakltTklqSG5EZUFjU1o3WnVTMit0QzB3QmhseHRs?=
 =?utf-8?B?eXJBVFEzUXkyTkRvTGYzd1RITjd1SkRLUi9hUzZGOFkzYjRuZk5lZmZ0Ty9X?=
 =?utf-8?B?WGNEYTFTekh5bHpYNFFId3JBV2hkS3UzZEpyOUF4NlM5R3ZPblhRbGE4aEhU?=
 =?utf-8?B?ZVlNL24ya2lDNTVKWHZRYW1mcEZsNDJSY3d3UHpWMjV6MGdWaTdVZUg5Y01q?=
 =?utf-8?B?bUkyZERRaFBqK21KQkc4ZUlPMDRwOGxNMy9lRzBSazBvOHd2bjBnN3Aza3pi?=
 =?utf-8?B?dGIyVi9NWXNVUnFBdStHOWtrU2g4UkRDR2RWRCtBbGJHVUFacnRrNnI1MXJU?=
 =?utf-8?B?OTF6ZTNrL00xRkt3aFZyMTIrMmd1aVBiNFR2NHQvemdoUHZUNnlnclZqa0dU?=
 =?utf-8?B?M3c1SU9PTmFVY2FMMVM2dSs1UmN3WUducHhjaklRbkl6cTFnSWhOckk2OUZP?=
 =?utf-8?B?aVBIM2crK0RiRldFeGVxd2lTK1JZRHdSb2RHdjdIS3RlT0w3MFROaW9BOC93?=
 =?utf-8?B?T2ZkaGlTNzhDMVZScnYzTHpYMmt6SFRPUU5YaVdTdXRuSko0eDYxdkRVUzZr?=
 =?utf-8?B?U1hhNnZ1NVhUaVJ0T202NHd2TkhoeEJXY2JVYVJaT0c5cXNidmU1M2NUNUwy?=
 =?utf-8?B?SEJVS3J4eTcxcDhJQWJjODFWeXQ1ZlNaVXRZS2t3dG5lWkxlL2g3MmIwRU91?=
 =?utf-8?B?Y0pjTGtaMSs2VmJkbnU4LzhYOGE2OU5TQTQwNlRxYUVvWUJoL1d4OEVzalFD?=
 =?utf-8?Q?L68nTb3dOo8ZFLlwB5KsXiFcq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc35483a-2ba2-4d3c-6a0c-08dce1b678a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 01:15:00.3984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GM13/Oz/ym0oUkqgFv2U33h0hJ3Rt9mCkf++esM8CfDbMqvIdYd+a1j419Ke7eolu8skfMJUJOnOzQx8Q/SKhnSZkDQVQigLNP6570nPVcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5716
Received-SPF: pass client-ip=2a01:111:f400:feab::71c;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-SG2-obe.outbound.protection.outlook.com
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

SGkgVGhvbWFzLCBDZWRyaWMNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDgvOF0gaHcvZ3Bp
by9hc3BlZWQ6IEFkZCB0ZXN0IGNhc2UgZm9yIEFTVDI3MDANCj4gDQo+IE9uIDMwLzA5LzIwMjQg
MTguNDgsIEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOg0KPiA+IE9uIDkvMzAvMjQgMTg6MzYsIFRo
b21hcyBIdXRoIHdyb3RlOg0KPiA+PiBPbiAzMC8wOS8yMDI0IDEwLjUyLCBKYW1pbiBMaW4gd3Jv
dGU6DQo+ID4+PiBBZGQgdGVzdCBjYXNlIHRvIHRlc3QgR1BJTyBvdXRwdXQgYW5kIGlucHV0IHBp
bnMgZnJvbSBBMCB0byBENyBmb3INCj4gQVNUMjcwMC4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2Zm
LWJ5OiBKYW1pbiBMaW4gPGphbWluX2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4+IC0tLQ0KPiA+
Pj4gwqAgdGVzdHMvcXRlc3QvYXNwZWVkX2dwaW8tdGVzdC5jIHwgNzcNCj4gPj4+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPj4+IMKgIHRlc3RzL3F0ZXN0L21lc29uLmJ1
aWxkwqDCoMKgwqDCoMKgwqAgfMKgIDMgKysNCj4gPj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgNzYg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEv
dGVzdHMvcXRlc3QvYXNwZWVkX2dwaW8tdGVzdC5jDQo+ID4+PiBiL3Rlc3RzL3F0ZXN0L2FzcGVl
ZF9ncGlvLXRlc3QuYyBpbmRleCBkMzhmNTFkNzE5Li4wM2IzYjFjMmIyIDEwMDY0NA0KPiA+Pj4g
LS0tIGEvdGVzdHMvcXRlc3QvYXNwZWVkX2dwaW8tdGVzdC5jDQo+ID4+PiArKysgYi90ZXN0cy9x
dGVzdC9hc3BlZWRfZ3Bpby10ZXN0LmMNCj4gPj4+IEBAIC0zMyw2ICszMywxMCBAQA0KPiA+Pj4g
wqAgI2RlZmluZSBHUElPX0FCQ0RfREFUQV9WQUxVRSAweDAwMA0KPiA+Pj4gwqAgI2RlZmluZSBH
UElPX0FCQ0RfRElSRUNUSU9OwqAgMHgwMDQNCj4gPj4+ICsvKiBBU1QyNzAwICovDQo+ID4+PiAr
I2RlZmluZSBBU1QyNzAwX0dQSU9fQkFTRSAweDE0QzBCMDAwICNkZWZpbmUgR1BJT0EwX0NPTlRS
T0wNCj4gMHgxODANCj4gPj4+ICsNCj4gPj4+IMKgIHN0YXRpYyB2b2lkIHRlc3Rfc2V0X2NvbG9j
YXRlZF9waW5zKGNvbnN0IHZvaWQgKmRhdGEpDQo+ID4+PiDCoCB7DQo+ID4+PiDCoMKgwqDCoMKg
IFFUZXN0U3RhdGUgKnMgPSAoUVRlc3RTdGF0ZSAqKWRhdGE7IEBAIC03MiwxNyArNzYsODIgQEAg
c3RhdGljDQo+ID4+PiB2b2lkIHRlc3Rfc2V0X2lucHV0X3BpbnMoY29uc3Qgdm9pZCAqZGF0YSkN
Cj4gPj4+IMKgwqDCoMKgwqAgZ19hc3NlcnRfY21waGV4KHZhbHVlLCA9PSwgMHhmZmZmZmZmZik7
DQo+ID4+PiDCoCB9DQo+ID4+PiArc3RhdGljIHZvaWQgdGVzdF8yNzAwX291dHB1dF9waW5zKGNv
bnN0IHZvaWQgKmRhdGEpIHsNCj4gPj4+ICvCoMKgwqAgUVRlc3RTdGF0ZSAqcyA9IChRVGVzdFN0
YXRlICopZGF0YTsNCj4gPj4+ICvCoMKgwqAgdWludDMyX3Qgb2Zmc2V0ID0gMDsNCj4gPj4+ICvC
oMKgwqAgdWludDMyX3QgdmFsdWUgPSAwOw0KPiA+Pj4gK8KgwqDCoCB1aW50MzJfdCBwaW4gPSAw
Ow0KPiA+Pj4gKw0KPiA+Pj4gK8KgwqDCoCBmb3IgKGNoYXIgYyA9ICdBJzsgYyA8PSAnRCc7IGMr
Kykgew0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgIGZvciAoaW50IGkgPSAwOyBpIDwgODsgaSsrKSB7
DQo+ID4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvZmZzZXQgPSBBU1QyNzAwX0dQSU9fQkFT
RSArIEdQSU9BMF9DT05UUk9MICsNCj4gKHBpbiAqDQo+ID4+PiArNCk7DQo+ID4+PiArDQo+ID4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBvdXRwdXQgZGlyZWN0aW9uIGFuZCBvdXRwdXQg
aGkgKi8NCj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHF0ZXN0X3dyaXRlbChzLCBvZmZz
ZXQsIDB4MDAwMDAwMDMpOw0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFsdWUgPSBx
dGVzdF9yZWFkbChzLCBvZmZzZXQpOw0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ19h
c3NlcnRfY21waGV4KHZhbHVlLCA9PSwgMHgwMDAwMDAwMyk7DQo+ID4+PiArDQo+ID4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBvdXRwdXQgZGlyZWN0aW9uIGFuZCBvdXRwdXQgbG93ICov
DQo+ID4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxdGVzdF93cml0ZWwocywgb2Zmc2V0LCAw
eDAwMDAwMDAyKTsNCj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbHVlID0gcXRlc3Rf
cmVhZGwocywgb2Zmc2V0KTsNCj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdfYXNzZXJ0
X2NtcGhleCh2YWx1ZSwgPT0sIDB4MDAwMDAwMDIpOw0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcGluKys7DQo+ID4+PiArwqDCoMKgwqDCoMKgwqAgfQ0KPiA+Pj4gK8KgwqDCoCB9DQo+
ID4+PiArfQ0KPiA+Pj4gKw0KPiA+Pj4gK3N0YXRpYyB2b2lkIHRlc3RfMjcwMF9pbnB1dF9waW5z
KGNvbnN0IHZvaWQgKmRhdGEpIHsNCj4gPj4+ICvCoMKgwqAgUVRlc3RTdGF0ZSAqcyA9IChRVGVz
dFN0YXRlICopZGF0YTsNCj4gPj4+ICvCoMKgwqAgY2hhciBuYW1lWzE2XTsNCj4gPj4+ICvCoMKg
wqAgdWludDMyX3Qgb2Zmc2V0ID0gMDsNCj4gPj4+ICvCoMKgwqAgdWludDMyX3QgdmFsdWUgPSAw
Ow0KPiA+Pj4gK8KgwqDCoCB1aW50MzJfdCBwaW4gPSAwOw0KPiA+Pj4gKw0KPiA+Pj4gK8KgwqDC
oCBmb3IgKGNoYXIgYyA9ICdBJzsgYyA8PSAnRCc7IGMrKykgew0KPiA+Pj4gK8KgwqDCoMKgwqDC
oMKgIGZvciAoaW50IGkgPSAwOyBpIDwgODsgaSsrKSB7DQo+ID4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzcHJpbnRmKG5hbWUsICJncGlvJWMlZCIsIGMsIGkpOw0KPiA+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgb2Zmc2V0ID0gQVNUMjcwMF9HUElPX0JBU0UgKyBHUElPQTBfQ09OVFJP
TCArDQo+IChwaW4gKg0KPiA+Pj4gKzQpOw0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LyogaW5wdXQgZGlyZWN0aW9uICovDQo+ID4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxdGVz
dF93cml0ZWwocywgb2Zmc2V0LCAwKTsNCj4gPj4+ICsNCj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC8qIHNldCBpbnB1dCAqLw0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcXRl
c3RfcW9tX3NldF9ib29sKHMsICIvbWFjaGluZS9zb2MvZ3BpbyIsIG5hbWUsDQo+IHRydWUpOw0K
PiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFsdWUgPSBxdGVzdF9yZWFkbChzLCBvZmZz
ZXQpOw0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ19hc3NlcnRfY21waGV4KHZhbHVl
LCA9PSwgMHgwMDAwMjAwMCk7DQo+ID4+PiArDQo+ID4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAvKiBjbGVhciBpbnB1dCAqLw0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcXRlc3Rf
cW9tX3NldF9ib29sKHMsICIvbWFjaGluZS9zb2MvZ3BpbyIsIG5hbWUsDQo+ID4+PiArZmFsc2Up
Ow0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFsdWUgPSBxdGVzdF9yZWFkbChzLCBv
ZmZzZXQpOw0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ19hc3NlcnRfY21waGV4KHZh
bHVlLCA9PSwgMCk7DQo+ID4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwaW4rKzsNCj4gPj4+
ICvCoMKgwqDCoMKgwqDCoCB9DQo+ID4+PiArwqDCoMKgIH0NCj4gPj4+ICt9DQo+ID4+DQo+ID4+
IEFzIGZhciBhcyBJIGNhbiBzZWUsIHRoZXJlIGlzIG5vdGhpbmcgaW4gdGhlc2UgdHdvIGZ1bmN0
aW9ucyB0aGF0DQo+ID4+IHJlcXVpcmVzIGFueSBvZiB0aGUgb3RoZXIgY29kZSBpbiB0aGlzIGZp
bGUgLi4uDQo+ID4+DQo+ID4+PiArDQo+ID4+PiDCoCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
KmFyZ3YpDQo+ID4+PiDCoCB7DQo+ID4+PiArwqDCoMKgIGNvbnN0IGNoYXIgKmFyY2ggPSBxdGVz
dF9nZXRfYXJjaCgpOw0KPiA+Pj4gwqDCoMKgwqDCoCBRVGVzdFN0YXRlICpzOw0KPiA+Pj4gwqDC
oMKgwqDCoCBpbnQgcjsNCj4gPj4+IMKgwqDCoMKgwqAgZ190ZXN0X2luaXQoJmFyZ2MsICZhcmd2
LCBOVUxMKTsNCj4gPj4+IC3CoMKgwqAgcyA9IHF0ZXN0X2luaXQoIi1tYWNoaW5lIGFzdDI2MDAt
ZXZiIik7DQo+ID4+PiAtwqDCoMKgIHF0ZXN0X2FkZF9kYXRhX2Z1bmMoIi9hc3QyNjAwL2dwaW8v
c2V0X2NvbG9jYXRlZF9waW5zIiwgcywNCj4gPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRlc3Rfc2V0X2NvbG9jYXRlZF9waW5zKTsNCj4gPj4+IC3C
oMKgwqAgcXRlc3RfYWRkX2RhdGFfZnVuYygiL2FzdDI2MDAvZ3Bpby9zZXRfaW5wdXRfcGlucyIs
IHMsDQo+ID4+PiB0ZXN0X3NldF9pbnB1dF9waW5zKTsNCj4gPj4+ICvCoMKgwqAgaWYgKHN0cmNt
cChhcmNoLCAiYWFyY2g2NCIpID09IDApIHsNCj4gPj4+ICvCoMKgwqDCoMKgwqDCoCBzID0gcXRl
c3RfaW5pdCgiLW1hY2hpbmUgYXN0MjcwMC1ldmIiKTsNCj4gPj4+ICvCoMKgwqDCoMKgwqDCoCBx
dGVzdF9hZGRfZGF0YV9mdW5jKCIvYXN0MjcwMC9ncGlvL2lucHV0X3BpbnMiLA0KPiA+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzLCB0
ZXN0XzI3MDBfaW5wdXRfcGlucyk7DQo+ID4+PiArwqDCoMKgwqDCoMKgwqAgcXRlc3RfYWRkX2Rh
dGFfZnVuYygiL2FzdDI3MDAvZ3Bpby9vdXRfcGlucyIsIHMsDQo+ID4+PiB0ZXN0XzI3MDBfb3V0
cHV0X3BpbnMpOw0KPiA+Pj4gK8KgwqDCoCB9IGVsc2Ugew0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKg
IHMgPSBxdGVzdF9pbml0KCItbWFjaGluZSBhc3QyNjAwLWV2YiIpOw0KPiA+Pj4gK8KgwqDCoMKg
wqDCoMKgIHF0ZXN0X2FkZF9kYXRhX2Z1bmMoIi9hc3QyNjAwL2dwaW8vc2V0X2NvbG9jYXRlZF9w
aW5zIiwgcywNCj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdGVzdF9zZXRfY29sb2NhdGVkX3BpbnMpOw0KPiA+Pj4gK8KgwqDCoMKg
wqDCoMKgIHF0ZXN0X2FkZF9kYXRhX2Z1bmMoIi9hc3QyNjAwL2dwaW8vc2V0X2lucHV0X3BpbnMi
LCBzLA0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB0ZXN0X3NldF9pbnB1dF9waW5zKTsNCj4gPj4+ICvCoMKgwqAgfQ0KPiA+Pg0K
PiA+PiAuLi4gc28gdGhlIG1vcmUgSSBsb29rIGF0IHRoaXMsIHRoZSBtb3JlIEkgdGhpbmsgeW91
ciBuZXcgdGVzdCBzaG91bGQNCj4gPj4gcmVzaWRlIGluIGEgc2VwYXJhdGUgZmlsZSB0aGF0IG9u
bHkgZ2V0cyBleGVjdXRlZCBmb3IgYWFyY2g2NCwgd2hpbGUNCj4gPj4gdGhpcyBmaWxlIGhlcmUg
c2hvdWxkIHN0YXkgZm9yIGFybSAzMi1iaXQuIE9yIGlzIHRoZXJlIGEgcmVhbA0KPiA+PiBjb21w
ZWxsaW5nIHJlYXNvbiBmb3IgcHV0dGluZyB5b3VyIGNvZGUgaW4gdGhpcyBmaWxlIGhlcmU/DQo+
ID4NCj4gPiBCZWNhdXNlIGl0IGlzIHJlbGF0ZWQgdG8gdGhlIEFzcGVlZCBHUElPIGNvbnRyb2xs
ZXJzLiBVbmxlc3Mgd2Ugd2FudA0KPiA+IHRvIGludHJvZHVjZSBhIG5ldyBzZXQgb2YgdGVzdCBm
aWxlcyBmb3IgNjQtYml0IEFzcGVlZCBTb0MgY29udHJvbGxlcnMNCj4gPiA/IHdoeSBub3QuDQo+
ID4NCj4gPiBJIGFtIG9rIHdpdGggYm90aCBvcHRpb25zLiBPcHRpb24gMSBpcyBzaW1wbGVyIHRv
IGltcGxlbWVudCwgYnV0IHRoZXJlDQo+ID4gbWF5IGJlIHJlYXNvbnMgdG8gc2VwYXJhdGUgdGhl
IHRlc3RzIGJhc2VkIG9uIGFyY2hpdGVjdHVyZSwgYWx0aG91Z2gNCj4gPiBJJ20gbm90IGF3YXJl
IG9mIGFueSBhdCB0aGUgbW9tZW50LiBXb3VsZCB5b3UgcmF0aGVyIHByZWZlciBvcHRpb24gMiA/
DQo+ID4gSG93IHNob3VsZCB3ZSBuYW1lIHRoZSB0ZXN0IGZpbGUgPw0KPiANCj4gU2luY2UgYWxs
IGFybSAzMi1iaXQgdGVzdHMgYXJlIGN1cnJlbnRseSBjb21wbGV0ZWx5IHNlcGFyYXRlIGZyb20g
dGhlDQo+IGFhcmNoNjQgdGVzdHMsIEkgdGhpbmsgYSBzZXBhcmF0ZSBmaWxlIHdvdWxkIGJlIGJl
dHRlciwgaW5kZWVkLg0KPiBTaW1wbHkgY2FsbCBpdCBhc3QyNzAwLWdwaW8tdGVzdC5jID8NCj4g
DQoNClRoYW5rcyBmb3Igc3VnZ2VzdGlvbi4NCldpbGwgbW92ZSBpdCBpbnRvIG5ldyBmaWxlLCBh
c3QyNzAwLWdwdGlvLXRlc3QuYy4NCg0KSmFtaW4NCj4gICBUaG9tYXMNCg0K

