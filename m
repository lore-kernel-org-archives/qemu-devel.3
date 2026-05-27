Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48557CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 11:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSCd3-00045y-DC; Wed, 27 May 2026 07:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1wSCd1-00045p-9A
 for qemu-devel@nongnu.org; Wed, 27 May 2026 07:40:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <felipe@nutanix.com>)
 id 1wSCcw-0007ss-KI
 for qemu-devel@nongnu.org; Wed, 27 May 2026 07:40:50 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64R8mZAk2245323; Wed, 27 May 2026 04:40:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Rfv/iFNBKvN9DGT8FV+yc/UHbcjJau12A5KuYwB2J
 FI=; b=FNn2rxKh66HwkJyZ3oOQr13GRTEHPOhgFLqe7hbDfs4yRmTD8/EPqRZTp
 DK1DBRxI9IYBzzS3dNbC5i6/uzMzijXtWo203iNgt54PPJ7MV8CEEK59wWEEzesd
 G05ltFMA4Em1QvvnmcA1v/3FN7O0f8dALUVs69RCreK0NuLX5IV642A1lCJ6rxQk
 C7fshvxHwxoaW37u575NeUVlEADhbFV9zcz0IPfKh9ikcDKvhBdDyEUdwX6g3s1P
 RxSvDe8Y8C4xovXmRJsFi1YOUcQpAQc/In/xOak2zfDzGvM3McH+kCfSRq+j/IK0
 1KKEomOBY1zqgL6iVYRgn+dLlEBUg==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020078.outbound.protection.outlook.com [52.101.61.78])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4edhn7svkg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 27 May 2026 04:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2lh8tP6mnHU7kanSYQa8TTqSIlnObesAhegRyoQrlAU/TVV3ooPfDdCHUKQi1B9c8Dxm0lxtxtDCtCG2fmmWre50veyKtRHAvqBZyk5N2DUlVgA951Oe/SWwhFviEIXIDMZO871baF4aBn7g2M50WB+/1gxG23UApAsXiAd4zhwfsblGspFb3NZINYCNe7sYguxAMNYI+1R4IdtgbupUI+GRU7fvWANRshWtuvFQbbZHCKdCUeaGUrdvCfKZa85qhzdPYpyh8nHgCBv8XJKbDigc5ikzSH10FWBjXN9tiMH91j8sWLFDKX5uqfhWTuUM/6LwBzsyoVhub3ap5pmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rfv/iFNBKvN9DGT8FV+yc/UHbcjJau12A5KuYwB2JFI=;
 b=GqiFHkfRqIhRH8XeF+BN9mz5Wmy5+b5JMNOMnV7WQI8e9X/X0LMXhet7g1Q9j/jF8zXSVH3zq/eJjlsC5oia7uVoGys5KH3+netxrwOL6pelNLIEPsxh+U3O2utmgn1N7DgMeeRBexBEyf+TnaxKSZjbFt02ISLHgnvn/aXKPYMuRPXfw5+sGuPRVeVqbOMy6xzTWLBW/EjPBVcoAYNDXLiQ8kh3gh/P2PUKHZWkSExLzZYZEXmovS67bbazL1GdH7g63sXZ68ee8snI5U662obOnfJIssjS1ZWGDqxQ99DXMRsUywElWOmQBeYDsl7W3tNNoz+6ccIU6N0RjyhDug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfv/iFNBKvN9DGT8FV+yc/UHbcjJau12A5KuYwB2JFI=;
 b=pDKj1iF0IpYfEZj7LZK4lqm8dVVctXlRuRw61znWNjUeptDklrbr/HerQ4/yXxrkt0AxS6gROXVIoqH4/8rSbPfrC05shFmOv+fhyDP7IFCKno4ovjCvBhNu4u4AmTkEmYh3SHlMg/nFpIFcv0dmQMt3y4wKK0soNnRir9KS6KCRc/ShDHsfUyh5eroju8EbUJFiCO3M6V0It+C/HM+xPazN4x/iwjlgPCgdBPOF8w1GibUe5k/zMRq+wCTdQ7d4g+OPGrcSf++2i9l7FyAqKXIZBCxm6W4oaLJYviqSN0w9p31v1EBN65dRJ/++mO6m9plNAKmFUYPkYDeQ6YPR4A==
Received: from LV0PR02MB11110.namprd02.prod.outlook.com
 (2603:10b6:408:333::23) by DM4PR02MB8911.namprd02.prod.outlook.com
 (2603:10b6:8:8e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Wed, 27 May
 2026 11:40:38 +0000
Received: from LV0PR02MB11110.namprd02.prod.outlook.com
 ([fe80::3eed:f79f:3e56:f0aa]) by LV0PR02MB11110.namprd02.prod.outlook.com
 ([fe80::3eed:f79f:3e56:f0aa%6]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 11:40:37 +0000
From: Felipe Franciosi <felipe@nutanix.com>
To: Alyssa Ross <hi@alyssa.is>, =?utf-8?B?QWxleCBCZW5uw6ll?=
 <alex.bennee@linaro.org>
CC: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Demi Marie Obenour
 <demiobenour@gmail.com>, Albert Esteve <aesteve@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Eric Blake
 <eblake@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, Jan Kiszka <jan.kiszka@web.de>, Joao
 Martins <joao.m.martins@oracle.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>,
 =?utf-8?B?UGhpbCBNYXRoaWV1LURhdWTDqQ==?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard
 Henderson <richard.henderson@linaro.org>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: vhost-user implementations
Thread-Topic: vhost-user implementations
Thread-Index: AQHc7b6Fu5ybqZo8dUCb86pkLMK6o7Yhvq4A
Date: Wed, 27 May 2026 11:40:37 +0000
Message-ID: <03395964-23FF-4FA3-8B78-483CF2938BB6@nutanix.com>
References: <875x4fmzcv.fsf@draig.linaro.org>
 <96181e0d-4c75-430a-9b80-9d8d0eabcce7@gmail.com>
 <CAAjaMXbFhtiHgiUwmJFXti25+vXRebjtaD6fFD+GkOHsDny=Bg@mail.gmail.com>
 <878q961nkz.fsf@draig.linaro.org> <87mrxlgt6u.fsf@alyssa.is>
 <87y0h5xl7h.fsf@draig.linaro.org> <877bopgoxe.fsf@alyssa.is>
In-Reply-To: <877bopgoxe.fsf@alyssa.is>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.500.181)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11110:EE_|DM4PR02MB8911:EE_
x-ms-office365-filtering-correlation-id: ed4faf7b-973e-49ec-5261-08debbe4c5c2
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|38070700021|56012099006|4143699003;
x-microsoft-antispam-message-info: F1Wegcjw6MspRy/B5a/ESlCRLPR+jQIif4ljgfebqfygUx9vxl9T38sFc7lcIs/Il5MNdxBnN0kNSrlPivxAYzPsB6Ry2dYhiblSNjGIBANTBlbEkRRFCvzf30mtzRMc/YjIjSTQQqgmplhQETO3eyTL/8XVMW7gKusknZuHTx7PM2q9rfrkSa85x3ovj0Jw5H9IY8TH97DUHYDXCoTFjR0tPppi3bhNuDgmhs74uS4Qv9SIc4X5h4y45XpIqjwqw0wvKgi5WIbeDoBQuj/XfrTbQ5kdVS01xjFXpDiQ5JKcxVpwKP/8uV3X7oPxWus93n7MT/hvcFIJ4dGdRdpvoeS0GJ3EonPGThocmk6CAx5/A4Ky671vaKmadQ98S2W8ekIljR3uFX3iBxqt86pGZtTjZf9YMC0E3NvYISuvg5EusrsF3Yoh7PEpZVqcZvkEawBmDn4KVPTGlUOJ553sjZOp/xXeDS2UGCBmZJetmlIdTJgknjGnj/7bHRUt7g0dPUt5F+6yvWMkXJjPW1qhuNS/5U8XXD+VFvx9wCc8XuLBBgUOUZ16n+SszQ8d5f08iBTrf2IPBg7J9tQXVyXj9ZowjInevfxaA4PB1q7w3+BE7O/vV26+Inj34d8itGz8L7wvNg1rHDPAVzVUfOm+pkbQUjDzzcYkn7HcPN1iO7o/lMfBxIkcyj8TbibqyNlj/e1AfYZh2dghsbCpkttvbaxiYr16U7syKHUKqXcBxRydnndZ6P2nlSBCjDyH8lio
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11110.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlR6d2JzQ0YrZ0lJMUk2M3BFSkhabWhlczZnWVlnYTlUT1krU2hsMlVMYWU2?=
 =?utf-8?B?ZGpPUG8venFwamlUNFNuZUo2b1FmRTlYVzhOeXVoOGIySjNmTFhrTjlwQnIx?=
 =?utf-8?B?UXlaSXk4UnNGWG9wZk1aZzI5cHRFUTIvS2FTcjZoeUl6QTB6aFg0YXZaQS9W?=
 =?utf-8?B?NjZDSHlwR3oxMVhSRGh2RUJiNDNOZVREVjVuc3ExUHA4eHpaNTJWQTc1SC9G?=
 =?utf-8?B?OU81ajlkSkZGZU1KVmd0NkRlV0huUVhBNXI2R2VISUtiK29mUjZMTW4rK1JV?=
 =?utf-8?B?eU1tSzE4TXpjUmIrcGxLZERkQmc4WC9MOEhoV0pjOFJLQWcrY3I4RGtkZUJt?=
 =?utf-8?B?U2NZTTJjUjZ1SDNKYVo2YWpNai9kQktRSU9scnNyT1dDOGFleTFFRmRIakdW?=
 =?utf-8?B?SHVrSERpMlkraFRkNTljbWszS256T2Jqa1BVbEMzTHI4OEFLd21tQTZrNzlQ?=
 =?utf-8?B?UkVYR0h2Q29VVDhDeGp6T25rcm14dWRrSFI2RXNUUURSVzZKZWV3ZzlObHFj?=
 =?utf-8?B?TnZtZXRRLzJYNmdvY1llQ25tVE9XT2g0ZkdTZ0xqeUtjaDNIRjM4cDJFWS9j?=
 =?utf-8?B?WHYzMGZPdnVtWHJ6a1A0K01tN0U4dnk1cTRJcG16a1psOGh3VHBLWG1aaFNC?=
 =?utf-8?B?UnRMRjVPV0xDRk5QNnFHVFN2UW9iOURodVNXdk8zY0FKUnZLRzkvSXZNeGsr?=
 =?utf-8?B?WEQ2NFNTK1luMFVLbCtmd25kd3FIVFBXRnNQSmtnYkdIVWhOVWJHcmhIK1E2?=
 =?utf-8?B?Mlo0SlNsditzYnlPd2FCWTBRVFhsNnJhUE9jVkw1WndyMGd4djRsZURiSTNv?=
 =?utf-8?B?K24zSDU2SDZLZ3ZHb3lhaWhUY1RPdVdnNXgyblYrU2FLLzdma05Xby9iSDBt?=
 =?utf-8?B?QkltVnNVNTdSMkdSOFNmK3dsUlh1TmtIaVhRTVlqYm1qL3Y1UTRTZVlETjkw?=
 =?utf-8?B?K3RiOUxOZkQ1OWVtMUc5NTZCTUdaeGtMWVhLaXc5aUpJdEVqamx3WG51d0h6?=
 =?utf-8?B?bE53RU8vWkVtdm91NmhBc3JxVk04NXJVNUJPYXR3bjJPbDNkVTBDWXpyYSs4?=
 =?utf-8?B?Z2FwdTJWRnhoYldudFZEMENMSnl4TnZyM3lvRWJzU0FDUWt3ZXNkSFljQWhj?=
 =?utf-8?B?NTVDRnRCL242T2p6TjFldUN6ZjhHeDUxRFNZYllnZUVGcjJaMnprdjc3Unp3?=
 =?utf-8?B?bUxveEtYZHlpRXkrZCtYdGpGMVBWYzdyVnBmR2FXNGVpTzdpS0lNdFc0TVZW?=
 =?utf-8?B?a2FTRGdQR3BuV1RDQWh6VFo5NE1Rcy9rMWZYdlZSNkFuRzI3RERncnBldUhp?=
 =?utf-8?B?bEpUNXEvL2VxV0ljWmtMSmVSVmltMUxUVTcvTDc3WGVxb0NZUnoxVDl6Rysw?=
 =?utf-8?B?STFodS9hWmNuTTFPbjIvNkRFK3YxQUYvTlBXVUVLaDRvUWtzNWp4dWwyc2tH?=
 =?utf-8?B?eUFlR1JoWng2ZjhPcXJ5NkhIdGt2VHhwalBGcWhjUmZDU1hUcDZicXV0QjVI?=
 =?utf-8?B?K2xFUEhmbEUyS2F5V3A5amY0V0RRMiszWUVyRWtEUmlUNlFuYWpCT08zc1dn?=
 =?utf-8?B?U09aRlBoVHpFdkU0S0VpS3VtUVZmSnR4a3NCRHlKcGtIWUVBV2JZdEZ1NzMr?=
 =?utf-8?B?UFZFc2pXMXIvakVkWFBYMm1DcEtRcmxJeDZMRVdrMU44OStYdjVTYkFzaFpW?=
 =?utf-8?B?VUNWaElmdTV6bGU2eEZpSG1VcEd1UlE5N2pOMTlZVkYybHo4Y2VZSkx6YlVO?=
 =?utf-8?B?bm8rN0hoanVySjVNb3MydXNYdHpkZW5zZTAzN2Vna2U5eWVab1hTLzVkY2Jo?=
 =?utf-8?B?NFFka3EycmE2ZURMTWpBaWRCYlFlMTd2NkVkN3Nzd2c0cUNJUEdiZkRDVGpm?=
 =?utf-8?B?TkFEdmIzS3dYMVNGeWV0dnNrN3VWUDhVWlRMOWFjR3pjMDl5a1NBT0FhQVZo?=
 =?utf-8?B?aHV0OERCV21iUHhUSy95WjhFQXZBa1o1Rkl2bjFYQVNhT3lYQnova1VBSkht?=
 =?utf-8?B?TzdHQW1qMWU3SlBJL0ZFeEFabWMvQnFCZ2Q5bjhTbDArSDAwR0JSbzdkZ3NF?=
 =?utf-8?B?UGlvdXpzdkgzZHFGNUo0b1VneXN5MGM3NTN1dzRwNkxESGVOY3pjbGNEdGFX?=
 =?utf-8?B?TUUyeFpqeFJSczhpby9XM2pxN2t1Q1JoZWd6aTUwZ1RzQ1l0cUc1SHkrSFE0?=
 =?utf-8?B?MklNMDFGclBFS1Jub09TUEN6NU1FZVlYK0c2a3dHd0lnY1g4ckFCVW9aNFhO?=
 =?utf-8?B?UmI2NTMrblUvTFdTOEhzaHNrZnMzalcwcDJZY2RHenZrUzBObVJySXJGUWhC?=
 =?utf-8?B?VytqaU5GMDYvbjNpSHFPeDAwaWRNK2FsSm9PN0FCNEJXVElMU1dRbGJuYlVP?=
 =?utf-8?Q?epYXmNhIKQFqMbb8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F29A762B084114CB9D16CF6E10F5713@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N/0AVjZBlFMCZQJocaVqWTUevpo9x6nLPvBtA2OgPK8M/2hNUgJxqJst84/jcTBo3qecLIQTKnUSznXIaZ2IRCwNLyD0hr17edHwlr05u+O6SVTjkbbOEsjFl+JzjHOh4QmEh6F8jlOjqGIRG/SMFDeJrkJRbbBXQIDYRX+kARkXTcmaJAtUHoGNLBeVK2f0G6TrEW+N0qvNwsw1As9wVtI4K2HISCHNyCd/Iu+ZJ8NJNhGDz8UvJFdyuvUjfjRTNvDdD1d5bYJHJtlaaJOdE4lvpiPMPjVe+XpxrfwXp8qoBpUMLavioHabfi/HKAe6IoTMzh2WN10rufA+kPZlXw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11110.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4faf7b-973e-49ec-5261-08debbe4c5c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 11:40:37.7546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zc4GAA4aoLm8KITIHc6JIlJE0rhSe5GLWP4kj8G+8aOHwZHZGDnP1P/Dh/BOJsaNCm/hPgTT7ULT+297LRPIxfxzVwE8W6SykHNVn8c30P4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8911
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDExMyBTYWx0ZWRfX0gisWYjIWf3F
 3AT7UeTYGDTv4U3mruQeEK45ZfHiA/rHHxSVK4TRJnCpHgusTpR0U15ARl7mDxr/x7+bGzJIlwf
 RTy1Tssox+uTkiAQG0OhrRnSiTwfzjD8tOAiK4DhNmbMw5IIgWrE+xjXaDCvW5TWDLDB8yge+AW
 Xb5gE5CUf7qZPDIipQmMbSGHTNyqKDbkusqPEf30NmoGGOX+0CFmPOgAiGeRyvMFmbQmW8UzUwo
 fnTbItR7NmyVkiR3uD4CIDhDBWf9sjhjrAc/ip8rrCxJfzITL29P8UuJ1PXpZ47ceddGru8PLgA
 JUVMdTroMYpZgtTOaRIF2sbEYNfXDzVQUKq++fecWvXm5x5NYPKsHZsXjRfknZRWUb0JU3cy/Sm
 ty54y3p8ZlR62qbCiYOyT082faOay/YMOPdvxD4uC2VGaG5BhWdLI4HUt8BaGmYot5UzF22BVrj
 8OAT++GRhPvy+y7pS3g==
X-Proofpoint-ORIG-GUID: 2JBAZKTdEOgRtbONqOzkkY6hQb3WZ9AF
X-Proofpoint-GUID: 2JBAZKTdEOgRtbONqOzkkY6hQb3WZ9AF
X-Authority-Analysis: v=2.4 cv=f/l4wuyM c=1 sm=1 tr=0 ts=6a16d837 cx=c_pps
 a=qgEGzIGkZH4qQFF7vfwnSQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22 a=KKAkSRfTAAAA:8
 a=dPY9I4-_J_pqmiUGp8oA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_01,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=felipe@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQo+IE9uIDI3IE1heSAyMDI2LCBhdCAxMDo1MiwgQWx5c3NhIFJvc3MgPGhpQGFseXNzYS5pcz4g
d3JvdGU6DQo+IA0KPiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+IHdyaXRl
czoNCj4gDQo+PiAqZXZlcnlvbmUgLSBkbyB3ZSBoYXZlIGEgY29tcHJlaGVuc2l2ZSBsaXN0IG9m
IHdobyBpbXBsZW1lbnRzIHZob3N0LXVzZXINCj4+IHRoZXNlIGRheXM/DQo+IA0KPiBJJ2xsIGdl
dCBzdGFydGVkIHdpdGggc29tZSBpbXBsZW1lbnRhdGlvbnMgSSBrbm93IGFib3V0IDopDQo+IA0K
PiBGcm9udGVuZHMNCj4gLS0tLS0tLS0tDQo+IA0KPiDigKIgY3Jvc3ZtDQo+IOKAoiBRRU1VDQo+
IOKAoiBDbG91ZCBIeXBlcnZpc29yDQo+IOKAoiBGaXJlY3JhY2tlcg0KPiDigKIgU3RyYXRvVmly
dA0KPiDigKIgYWxpb3RoDQo+IOKAoiBEcmFnb25iYWxsDQo+IA0KPiBCYWNrZW5kcw0KPiAtLS0t
LS0tLQ0KPiANCj4g4oCiIHZob3N0LWRldmljZQ0KPiDigKIgdmlydGlvZnNkDQo+IOKAoiBjcm9z
dm0NCj4g4oCiIENsb3VkIEh5cGVydmlzb3INCj4g4oCiIFNwZWN0cnVtJ3Mgcm91dGVyDQo+IOKA
oiBEUERLDQo+IOKAoiBTUERLDQoNCk51dGFuaXggQUhWIGxldmVyYWdlcyB2aG9zdC11c2VyLXNj
c2kuIEFwb2xvZ2llcyBidXQgSSBtaXNzZWQgdGhlIG9yaWdpbmFsDQptZXNzYWdlIHNvbWVob3cu
IERvIHlvdSBuZWVkIG91ciBoZWxwIHRvIHBvcnQgb3IgdmFsaWRhdGUgY2hhbmdlcz8NCg0KQ2hl
ZXJzIQ0KRi4=

