Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEB5C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 05:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz8Lr-0002oT-Va; Tue, 23 Apr 2024 01:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1rz8Lq-0002oK-7D
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 01:05:54 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1rz8Ln-0005HN-TJ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 01:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1713848752; x=1745384752;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=31B5TL+pw7mFl2g1dtA6pwZrRwCXcaEWWe1HzTAW4tE=;
 b=GTNO3fsjf4mMOtz5ZTbpVoGqGyevDP+QWwD7Aza9Jt7sbvxqn8HpnBCi
 XAUNZp6pSJ1gm7zqjIgxFK9F6TtkhMS5DJRBe/1ndVbkfXmh3ylC/UE7z
 mRuDubrmpzrMh+sydRUOLHKFVz3BnHe6+p8HbBG4wv5oWDFwazh/omtHZ
 yKk5N4F/945NUrbLEjWvpuh6ki9pmYb78zVeT/Qv+w6FrimYx8ppEeQbd
 nqbOVJaqeK0HwzucCHIJZdQ47cfYXa0vRqUDjPN50sSq5AEj+LP1JK/MC
 0jQwkby/IXaiTdv58ZAzJcT07f+ICAIvUXcq0moxUj/p1IoFbO4fJ1sLi A==;
X-IronPort-AV: E=Sophos;i="6.07,222,1708383600"; d="scan'208";a="11056776"
X-MGA-submission: =?us-ascii?q?MDHVLcVlItrPEafzq7Yn1A5mibAUMay16ici/8?=
 =?us-ascii?q?Unvb/sdT4avneAIUyEV73TWWAzvB2JaT60gvajkKdG3jjUyvp6XXBG2h?=
 =?us-ascii?q?34RIEfB0VHIywTEdtNeAYbVHNyYVedEOuH0CAXXIgHBrm0zcMQL8Rs0e?=
 =?us-ascii?q?lSlkrfHNXguo0P5j+toCWx/w=3D=3D?=
Received: from mail-vi1eur04lp2050.outbound.protection.outlook.com (HELO
 EUR04-VI1-obe.outbound.protection.outlook.com) ([104.47.14.50])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2024 07:05:43 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzFMReHS/6UR+Kk4pA/IwDMOJPoX7YGeb1UNcnIlG+BClWk7y7m+tH8V0Q2VEB4WzBxtl3bcNW1JfYzynVTvJwW1dYM+zTKAH+7Bm9BIRamNVzfovKPN0JlXgvBvdDGtcw8M+ASGPhouXmrr44iGd1YOHVsIUmKWABdsvM8gDfzu2wZVAkzhr9Dthata4NC0jmKE1vNuVC4N422Na9PGZfzrQpLVuG+mJOQwyWBrTxY3la0hQMiVW14GqO0o0m5NE2uInWXq/Wv8dDZSPDRGphlI6RojzlavlcQYlpZSbVQlYpdaKL67pKBUEsGKUPPnRcLb/YeeDs5SVcfvzxFkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31B5TL+pw7mFl2g1dtA6pwZrRwCXcaEWWe1HzTAW4tE=;
 b=Uc/e2hYR720Rb/pHxP1X4pfOPkENezcw0VFkKzBLqXYeUTyi/KVtYiEkTvIPuw4OQOIb479Lsbr4pQ2J6icsb1vQQG92kD/n3MpwZgrNSaibn1tozT+Efh176Q1cbyD1cyenFoubK1mg5eE3y2HU7NtMO4Q7qm1UGqZuUlmmKBzffTih21kaQDOQVjcBMYn8RaPcMwbIHNDWr8e8CZqqnxM7mUEDgZBvo2UPjoAV5wdH0JzupJXSktIUyWGQ4FW5TzRdDXdJ5dzGTfe7acWG2mRgczKULE0cE4Hllr6fS0/Ll826F5/h4hq3tqS8AgZ8jxMcyHOLApYpHzduR0zB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8530.eurprd07.prod.outlook.com (2603:10a6:20b:4e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 05:05:41 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 05:05:40 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH intel_iommu 3/7] intel_iommu: make types match
Thread-Topic: [PATCH intel_iommu 3/7] intel_iommu: make types match
Thread-Index: AQHalM0i32KNWd9K4kWnjKS4kUptSrF0hHEAgADJsYA=
Date: Tue, 23 Apr 2024 05:05:40 +0000
Message-ID: <2537c79d-60d8-4504-a612-ad5a75e1bd20@eviden.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
 <20240422155236.129179-4-clement.mathieu--drif@eviden.com>
 <5acf21ec-216b-4d11-a7c1-ecf9a8ddf76f@linaro.org>
In-Reply-To: <5acf21ec-216b-4d11-a7c1-ecf9a8ddf76f@linaro.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8530:EE_
x-ms-office365-filtering-correlation-id: 9e4f5fb2-98cd-49d8-d76c-08dc635305bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?U0JuWVpxV2s0aUxIck8xakpzcDdNVXhxbVZFVDk0Zkx1aGZRRWpIZHRGbXFi?=
 =?utf-8?B?SGMyZFgzRDQxNW5uZ3pZOHpiRWN3R3lsZE9ESkpoZnpKazhZd2puN3NUN1Rm?=
 =?utf-8?B?V1gwdDFUOFRIOGJBRWE4QVJOQXE2SXU2TFlwR2hoU2cvUzltVWNqNUEyMXRM?=
 =?utf-8?B?blRqWTNlek9lYmtYQjcyS0c4T0hoL2JmR0tEQ0tJWkNnTExkd1M2Tm9QTE50?=
 =?utf-8?B?VFdwNlp3MERiMnRiWFZNYVJ2NlZNd3c4OWM1ODR5TC9kSzZuS3FRV1lWalBj?=
 =?utf-8?B?M2piWU1hU250SzBrNGUwa1c3N0xBZnkzaWtXaG5vNGtwVkQ0MkhhRkxKNy9E?=
 =?utf-8?B?Y3RDbUh1bUgyQzJjdWJrbzViNld0TEhqbVk4TkJiWTZHTHBxUjN6N1dwcGZO?=
 =?utf-8?B?T1RJbXNGaCtrVXd6M3NQKy9yNGlYMGI5T0xjL1FvK3p4cTVsRW9jUE14aFdw?=
 =?utf-8?B?ejZFakRFNFUxdkgzeEZNSEJmS3BOREFrWWVuQ3VFTWFWbzVRdFlrNFprYllY?=
 =?utf-8?B?bEIvYkxPR0MyeDdkM3pidDl6QWVkQjlRN2V6ZlEyN1hGZjFCV09tVmhUVStL?=
 =?utf-8?B?SjNqRGdNZmhYWEoyZnFRTDFJUUxDY3AyaDlqOTJtcFhIR3ZPYWd3c09Zc2NL?=
 =?utf-8?B?R2FYN2ZkSDB2MnU3Q0RnL0duakh5VFJFaVlUSHFmeklTTERwcFpnSm1CbnVT?=
 =?utf-8?B?ZlFDTnZpUWJLbnVwdHRDWTI3Q29qWlNXTmlBMW52QjZoNmVDRnlRQ2IxR3RF?=
 =?utf-8?B?eE9CL1pUTGpaenhZSWgvUWhkVGpHcjFOME1pOFBxSURIYm10MVJLNWtvZW0x?=
 =?utf-8?B?Qk9qdzdwVG1xMnhLNDZ5aEgxS1hYSGtiWGgrVTlyd1N3MnhpcjJXVjRuWnJm?=
 =?utf-8?B?NFAwNm9Gck5CcFJqUm5kQXIzYkEvV25QdCtWV1VaZ0NXV2U0NHNVL1Q2a0ZP?=
 =?utf-8?B?RHJQemVHQWMwT0NrQVhYbDlFR0p4VlBBcFk4MmJJelV3bERhZ0wvWkVYZXdy?=
 =?utf-8?B?NkExOEZySWhvc1V5cXlBRmw5VGY2cjBUNEN0cUNrd0VpYWcwR2dHa1U0OTIw?=
 =?utf-8?B?S3AvZWpEdmp6SWMzS0F5anRCckR5OUFYRHpQQXp4UDV2cFVkbys4S2c4cjhp?=
 =?utf-8?B?U3RtaHJ2VStvSTg4UWdYVmtkSWlBTTBRelVVK1F2RjJBbXhVdldVWW1lYWVB?=
 =?utf-8?B?azQ4KzZGRmtvWDRhcXZoM1I2S0p6UjhuNHB3Q01INncvYlBXczhtb28vbmhQ?=
 =?utf-8?B?QklJTGFrTFc1NlNJN0NxajdnOE1VdGgvcUdEU01LZ3Qwc0ozMUdBT3hZbEps?=
 =?utf-8?B?QWdBWDk4SU0zL05HNnRITG55VGx5WEc2THl2eEt0UE9HeE1uaVR2cEN4NlZx?=
 =?utf-8?B?QnpCUjd0eVZwemVvY0VncGx3RHY4Z0grYy81TDBrRjFTQXFxRXJDcWh3R1VT?=
 =?utf-8?B?MXFaaEZSZkg3WENMdVBCNkxnOG5iYktHRlNKSUozNHZWVkpSSE9kVUJBemxh?=
 =?utf-8?B?d2FKNnFNcTgvUTZYZWRDUXVlWTRKOGIzNElQbmVJZUVRTkpYYmRDNTBaNk50?=
 =?utf-8?B?emdGMGY5OE1HaDdsNEEyaGJ5c3BaZlhiQkFFVFhPSEdZR2liOFE2N1ZqZXVl?=
 =?utf-8?B?aG1qaHhhNHNpYXNwMnU0SUtVdWd3L1ZXZFN5Y0xMV0JtWjBMMkxTK09IZE5U?=
 =?utf-8?B?Vnp2WWUwaHlWZWlOYmJWNUQzSS9nbFBCOUw0QTV6dWpaOHV0MEIyb2xScm1j?=
 =?utf-8?B?ZFAzU2kzeWUyTHZab1c5elljSG9xTnpmRDNITGE1S0JrQmcyUDNpSVc4SVVo?=
 =?utf-8?B?LzBQZFpubDFGVlpDR0Jldz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3NibWpOT0JBWmJiL1NmTVQya1lOa1VORzNDa2NRVVFTRmtpbXp1SXJhMVdR?=
 =?utf-8?B?MWQwdFJpN2FjaWh4SFBJVXQyaU8veDhYY2U4SDFsZ29hd1JoYlk5WDlMN3lY?=
 =?utf-8?B?TWorZG1ROGJUNXJHcGZnVUcwd1RRNzZLdW84QjAyVDNHTU9jRGNoV0lKelQv?=
 =?utf-8?B?RDVBa2lxenkzV1p3WkdDeXBUcC95KzhyT0s4TGdxTTY0ZDRacFMyOVhDbDk3?=
 =?utf-8?B?N0VCZ3lLalN6Qy84L0gzWVNzY1NqSGFmdnpRR3B1ZnhqQStjZHJEUkdUYTh6?=
 =?utf-8?B?MERFWDNFckJpTkFCMnlCNzRHdmdFaE1HSGN0RVlpQTVmTVRFVXN4MzhFVTQ2?=
 =?utf-8?B?MDZJWHVxMk0yK1V0NFpwdHdvR0dabGsyMGZUOE5QVkx0VkhsNVJhMk1WanFo?=
 =?utf-8?B?VlJxN1k0NTRULzZkWWVGcXB4c0xacWtWMnpmSmllWmpqa1hSTVF4N0pEYVlQ?=
 =?utf-8?B?Ylk4cHI2dmFqRmhFbnRjcW4vaDByUmYxRjhCQW9DZGdQcCtlSUxqM3FQYUZ4?=
 =?utf-8?B?RHJWTmw3RUgzSGpWdlNQS2JNaGJKR0kzNTNxOTg5akJMcFYrWnB4Ti8wejJI?=
 =?utf-8?B?cXMxWjFPYlZ3cVl0YXUxSXptT3Zpd1VYSVRaSVlSM005SGx4WFZ1L2dVaDFQ?=
 =?utf-8?B?WElTaThFc0pZeW5kYThNVDVybEdQRWNTcnlSNE5GRHlTTG1BZWlQczMyNGl2?=
 =?utf-8?B?aWt2aERpTk9nWjh5am5xQy9peVo3VHpDU095Wk1pR0wxYXMvUkZ3M2ppTTdY?=
 =?utf-8?B?MUE3RXhsQ3BoNHRLY0x1dDdxRlZ3M3ZSZ0ZsMXZ2dXpITkZuUy9GMmhxUGMx?=
 =?utf-8?B?MlJ6TXR4b1lQc092M3V5SXV1M1dBU29yZEZ6OUZaREpTS3MzRU9Ba1JZL2Ew?=
 =?utf-8?B?YzZJZkgyUDFqQVNZb3F0ZXo2cTdVbVp1dGtLaHhQSG1KaGJZeUo2NFNaTWk2?=
 =?utf-8?B?cFdtc2Q5UmlZZjZFQTg2Z2c5VkM5b0FOVzkwSWpqVWVLc1BQZStOZVhiZVFu?=
 =?utf-8?B?Nnp6OGJMTXh2LzhHS2xDeUJ3SklxSUtDSUFnUXBsTjBobzNZV2Q1M1Q4SzBF?=
 =?utf-8?B?R0RKYVh3eVNMbjBpY1JOaGJqOVMrem9yQWhNTEI3MzlrWm9LZ2ZyTSs2UHRX?=
 =?utf-8?B?U0ppNXZSQ0Jkc25rSE9UbGpyQ0lKbHgxN2FYSTFiRWxrUnpsYmNSRTBHOXgx?=
 =?utf-8?B?Vm56YndqR3dyVXZxcEdjRWhWcFIxR0wzZWx2cjFGM1BUL0U1VG1qSzVEMFpB?=
 =?utf-8?B?TnhRRjVpMVZ6RDhUTmszY01Pd05aNFJhVHZNU1RsQTh1QzlQK290WjRZeDl0?=
 =?utf-8?B?ZDR3dStqaUVKQkVqTWg5eHIxZExrL216bHdpMXVUUVEzSXpDYXBqTGdaMysv?=
 =?utf-8?B?dVFVblhudHNWZWFDTmlIK29QSjFaZ05QQjNCa2RjaE1LTWwvcFk2M0FabXBS?=
 =?utf-8?B?dkFWNFVpZkNsTXduYmkxVkRwUXg0OVdaemI1cVFUajV3RVdlZ2R3R3A5UnBD?=
 =?utf-8?B?cjBEQkwxejNtSXJ0Vng3Mm9acFhGb25jT0wrY1pCKzdLZ0x0WXpJQ213YWNu?=
 =?utf-8?B?di9veWRDMVg2aVNMNjlJb0Vlbkt5dDNMaUdKYzk0ck5vcUZxZUY5OHpkMXJ5?=
 =?utf-8?B?TGJUN0hBSHdVR1YrZkVqbWZBR3hOam9hNE4rVmVQOHlaMUdRY1E3aVVpNnh0?=
 =?utf-8?B?ajRLdzMxN3kvT1BRam5tcStmMXF4eEVYL1JTYzBaM3NROTBqQXVLK2FkdTdF?=
 =?utf-8?B?eFBWYlRWQ0VHMUFyZDRFL05JcS9TZTcrRlBGdWtqdzNLZ2didXFMNTFhbzNH?=
 =?utf-8?B?NFBxTC9OamFxWFEyVGpUQU9YejRsR3doUWhPZC9MQlN5bWFtT1ZDd1p6TVVk?=
 =?utf-8?B?YVovb25vRU1MbGJYZWV6VHpMNTJnSGRTbGZEN2htMHdYS2hBQTUzRHNLalZo?=
 =?utf-8?B?Z1o5YUR3ZlV0eFZ0ZEVzV3FJNnVwZ2p3T1dtTlZJZkhHSXZldVkzWEM2QTVS?=
 =?utf-8?B?U1l0elJHbEFFVnVNd2VqU1VYdHFSL0EzMnpPb0p4THByN3I2eFQ3WE1GRU8z?=
 =?utf-8?B?cURpbEpzbEkvS3lKemNTbHJTejFDaFIzN29CR3dOV1FmcGJzTmdoQVBPYU1Y?=
 =?utf-8?B?WmpQd0c3cWJPZVFORU9qN0plb1R0QXo0aFd4Y3J0SnpSanE2Rm1QQXZSOC9P?=
 =?utf-8?Q?wyvr8mBsN2CocskU0hVZcwg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E2DFDDC9ED1724697CBC2E120D7D44D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4f5fb2-98cd-49d8-d76c-08dc635305bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 05:05:40.9115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cFjJIwT6qNZmwfTe1ypfy6cE8iK5t39V7qY3pIlUQdMF8eiO1nt9TYld0dYG5iEZIDFiZvP0IfppPNpO88vuQsiW11DkowhY7JHPV56dPexYxHf48o4++Yf6rld2r33K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8530
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

DQpPbiAyMi8wNC8yMDI0IDE5OjAzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4g
T24gMjIvNC8yNCAxNzo1MiwgQ0xFTUVOVCBNQVRISUVVLS1EUklGIHdyb3RlOg0KPj4gVGhlICds
ZXZlbCcgZmllbGQgaW4gdnRkX2lvdGxiX2tleSBpcyBhbiB1aW50OF90Lg0KPj4gV2UgZG9uJ3Qg
bmVlZCB0byBzdG9yZSBsZXZlbCBhcyBhbiBpbnQgaW4gdnRkX2xvb2t1cF9pb3RsYg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQubWF0aGlldS0t
ZHJpZkBldmlkZW4uY29tPg0KPj4gLS0tDQo+PiDCoCBody9pMzg2L2ludGVsX2lvbW11LmMgfCAy
ICstDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdS5jDQo+PiBpbmRleCA2ZjEzNjRiM2ZkLi5iYTU0NTU5MGIxIDEwMDY0NA0KPj4gLS0t
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4+IEBAIC0zMzMsNyArMzMzLDcgQEAgc3RhdGljIFZURElPVExCRW50cnkgDQo+PiAqdnRkX2xv
b2t1cF9pb3RsYihJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IHNvdXJjZV9pZCwNCj4+IMKg
IHsNCj4+IMKgwqDCoMKgwqAgc3RydWN0IHZ0ZF9pb3RsYl9rZXkga2V5Ow0KPj4gwqDCoMKgwqDC
oCBWVERJT1RMQkVudHJ5ICplbnRyeTsNCj4+IC3CoMKgwqAgaW50IGxldmVsOw0KPj4gK8KgwqDC
oCB1aW50OF90IGxldmVsOw0KPg0KPiBPciBzaW1wbHkgJ3Vuc2lnbmVkJyB1cCB0byB2dGRfc2xw
dF9sZXZlbF9zaGlmdCgpPw0KdnRkX2lvdGxiX2tleS5sZXZlbCBpcyBhbiB1aW50OF90LCBqdXN0
IGF2b2lkaW5nIGEgd2FybmluZyBoZXJl

