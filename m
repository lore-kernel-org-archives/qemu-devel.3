Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A3CCD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWaRy-0006Ma-6y; Mon, 08 Jun 2026 09:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wWaRv-0006LO-PE
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:55:32 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <khushit.shah@nutanix.com>)
 id 1wWaRt-0005cJ-Nr
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 09:55:31 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658B94SJ2539450; Mon, 8 Jun 2026 06:54:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=erfbiCVIAw48zip+1Hy+wyqBxFPah5knjiIptDtfT
 Rg=; b=sSbopUFwhBHMM6pj61ZObugC8BOJy3ovPp+xjhShvjQJnkOTfjeC2piYq
 F+P2OhEEDN8xnigACpY01AzRfNwzz0+SZaI/+26Pm8Sph75Rnp7WcRmlTmywkknS
 KRJcBrOtXngLCyUVXoXT7KmfT0uxzZ/tWx3s5A5Kriby3zd3pM51d1ZmVJze0Awg
 sR5gwf1p5k91UAynsrWNTWdZvFbTNP1ou5LjES6qaqZtNgL4Keo/oNvFKZKpdlSG
 1wVxwSuGkbYl3SLgvP12Ihbix9beilz4TGvEefUN+g82JOm0CML1ieWggSrE4uTT
 xXPxiUdCJ5bcKwC4r4iUy9IgYyZ+Q==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022099.outbound.protection.outlook.com [52.101.43.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4emk2xumvt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 06:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cDMaTnqAqYE8ur9Eq7IrcyuRdlX+FVvW0Bn8LvFh/fSWN7AtU/wYC0mXDdis0n0+qhMLxkQSPvzdId6IZEWCKW4hQDeghNAHDs3GixToxuIvDFjgpxzmF7BqwMk9fYUDZ5wgMMm6Xo4+Ga9tmAFWo14fAoxt/7QzidNQUDt3QJzKU39Je4EUbbK75SrfmFTtkeQR3PBxuIiIeKqIHvGJScW/kjbjFhEnTxVhrhuIZB3/h0Cl4BOopxEOuJGp4+c8ivLSC1z1uN2piH/J68ccCN/p1QqIVOoc3Me96GSvsJJN3Fq1ie5J6XylF4UGzds3f8iZUfhUPAGSPu5Lm+SY3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=erfbiCVIAw48zip+1Hy+wyqBxFPah5knjiIptDtfTRg=;
 b=LvYZWe257CHAIo+t3fn7tTipebm5O0xJwNN/xZJOscIg2WjRVA2yS/Pd4XrSLt/AVzTmrblJMOV/1W39XiWxFFhnozdjS+rTgtZ9gac3Ycj02aU+7EdDtcx+QT1oPTfFnPZz6A+XdxcGbVcBJ50/L9sf8dKnjxFI/t21DRvABp1U60YMiHm6hq0XdMLgq0ty0UC3pd77p8ifVGSFM7OckZhZ+uUWMUkVoG0S3yYL8GiOloFiALTOWBfHq8ruljqLqZftI79afqHBi8IHRDR0a6oWZtWXx9q/1Ey3XPcBq5zYp9pj0Sl1SlWvDW3pzkkuPc3sCf+rwfKwUS4pV4HdbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=erfbiCVIAw48zip+1Hy+wyqBxFPah5knjiIptDtfTRg=;
 b=XjxbhdMaN7vS3s5F4f6E8fAPJDTLWnmbPwEDzKHTLxn839s6gr0UySQt8Ezfon5Usl/PuedOAEi8vJu6BILt2ppvu3NXlwZaoQp86QuqoM05X62TJXURmfFwX87PHYQ+WnK9DZ548q6bJqekkQ/9pzFgLR7yZ7jEVDO14K9gli0H5lQR4XvvNXfo3T8sfA4if0cJQCKlDyIG8KqF4rFwjR7x2eepUfkuodcJZdz1AUgQ3jRtgsBXaQdTr9K+Rh2EWht2RWmhNfg63cYnAgxfFXFgd2TzzBm8C3Jco+zLQ3zLOXsnbXo4MeMtncc9405/yVhKgjTZUluDlgL/ahvVuw==
Received: from SA2PR02MB7564.namprd02.prod.outlook.com (2603:10b6:806:146::23)
 by SA1PR02MB11148.namprd02.prod.outlook.com (2603:10b6:806:4a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 13:54:47 +0000
Received: from SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4]) by SA2PR02MB7564.namprd02.prod.outlook.com
 ([fe80::1ea5:acb6:ebe1:e1c4%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 13:54:47 +0000
From: Khushit Shah <khushit.shah@nutanix.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Eric Auger
 <eric.auger@redhat.com>
CC: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>, "cw@f00f.org" <cw@f00f.org>, Demi Marie Obenour
 <demiobenour@gmail.com>, "dhedde@kalrayinc.com" <dhedde@kalrayinc.com>,
 Eric Blake <eblake@redhat.com>, "eblot@rivosinc.com" <eblot@rivosinc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Elena Ufimtseva <elena.ufimtseva@oracle.com>, Auger
 Eric <eric.auger@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 "helge.deller@googlemail.com" <helge.deller@googlemail.com>, Alyssa Ross
 <hi@alyssa.is>, "iggy@theiggy.com" <iggy@theiggy.com>, Warner Losh
 <imp@bsdimp.com>, "jacob.oursland@gmail.com" <jacob.oursland@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 "jidong.xiao@gmail.com" <jidong.xiao@gmail.com>, Jim Shu
 <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>, Konrad
 Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>,
 "matthieu@minio.io" <matthieu@minio.io>, Max Chou <max.chou@sifive.com>,
 Mark Burton <mburton@qti.qualcomm.com>,
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU
 Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>, Wei
 Wang <wei.w.wang@intel.com>, "z.huo@139.com" <z.huo@139.com>, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>,
 "zwu.kernel@gmail.com" <zwu.kernel@gmail.com>
Subject: Re: KVM/QEMU community call 9/6/2026 agenda items?
Thread-Topic: KVM/QEMU community call 9/6/2026 agenda items?
Thread-Index: AQHc905e13a3MjHP7kWpEfalY1mhoQ==
Date: Mon, 8 Jun 2026 13:54:47 +0000
Message-ID: <3824E675-7333-4FE4-AA5D-E2F4E08C9F2F@nutanix.com>
References: <87a4t52z0u.fsf@draig.linaro.org>
In-Reply-To: <87a4t52z0u.fsf@draig.linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA2PR02MB7564:EE_|SA1PR02MB11148:EE_
x-ms-office365-filtering-correlation-id: 95a169ab-6627-4751-153b-08dec565809f
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: xppHpcS6x1lrrLhFJePMnpHnOIWWRepXGqN/9VCO/dZa0oxPKa2ZVxpNmSJWVe0EZbTN0wPJWnG9ZHqgJa0m1uSnDIk+5DshPegmT0C2gYUof5TETRCBmKVrsjJV03vCKoWt3scHpIYOn2wXWsXGKCiiD1G8NoVILj5+/VNeX8mbD0p5JEbTQy47Ub7jDualsbUiO15kFHkiBuls4mi0qKLVDbxAgIVya74z3r58XSBIR0Ptup80nniIj4wtDWu7mc+U8dMBpui/rWtsPwlpTup5dd1mwijfZx/s21z6lX3XXNx+nGHe0ThlhRrAJ8lQmN9v/Y4w9DX4IEDxeyxwDXzyOp344JfyP7s4x1W164Ux2PA1YExDEBaQEZ8HwTkqdyH1+YbPQvOSUo8S2J77vx1qsOgd7Kj+9LxpkYRFSAUHZRydg6YGAIlLISSz/9roTrSF8xDDZ9fj0FLVxi+UAEkcvJnLVE4gr0uh2DVT3vEGOq80qNyrtLSE9vJxmZOCPnfzA/XNKL1Cpdfcdp6PGObZ2uUoEH5tpkCDRp6/OuEn6BLGCW0jU190QSssoI6rSVR5Q5It2QhpXlnxpu4NHfLRzEDmibQWPYdEeup2DG+G1R5gPcDrgWekaFofnh6YT+qukhCg8EvIBzP01d1+7mvQ6ApHe1Zk2oBd9fzi2xgroAHPl7/r8nleDmR9yvLMEzHamgHzmBi10XlH6Ib4syj3Lrtjr0ua5PjXPujQptGGOzJwtOWrV3laRupg/9vE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR02MB7564.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lXRqB4VjIRDiWn7EsdyZV+zn9GlCvavGyMdU8wYaeBWf7sKiq0r4i7iK7z?=
 =?iso-8859-1?Q?mDnhOg90otv1m0+ZzvG7FjySZIXE+FBDmN/9wz9RxpKLY7tGd+47ddqkPi?=
 =?iso-8859-1?Q?BJFOIrHBvyG9+avDKVAtqx/Z6DeGgsExultio8ry732J96/oJ5AGBN3aPW?=
 =?iso-8859-1?Q?M8ssq6HRFNHfVo9szquG9vAYItp3AgFhJzmBDCoCVKv0dH20GwqQ2v9Mgk?=
 =?iso-8859-1?Q?7bdW7B+U8gvCXwYN8oto4WfLHKGigSlLN+pmu0igBfPGNEu94+t5JCnZya?=
 =?iso-8859-1?Q?SW/O8C7wt/S8syefKImpSjC0IBVxYes9ZX7acmGCFOdmGYqLy/JFHb5VDA?=
 =?iso-8859-1?Q?sCjehnMfpzGl7oLW8FUD/6PEvETqX2tUAuzzGDJt3k9JSz8I6IM0ouzKr+?=
 =?iso-8859-1?Q?Z08QHN67Lc342w7n23lwtxE/8Ks9/uu/kBZjg0elD6aLxg11TcttuySriv?=
 =?iso-8859-1?Q?C087CLMF68V2mGPfMtFon3Gki9D0S4wD49H9oqoulmTQAluZ0YTlNgQUK4?=
 =?iso-8859-1?Q?/hfqonm98a5ElM+Ns+3eakgnw5KJffg2GUjg/hdE/JWlo9eaJXHvdA8Q+y?=
 =?iso-8859-1?Q?6ziUkLJjMCjSWnI7m4MFqNUe97RXzN3VpVZNVaQ0W103VdS6KKlf4O5VKO?=
 =?iso-8859-1?Q?CojTDs14POOHnTPnerGM+9yp41JvHMpXJJlOShUv7WfHXN78FG/sBk37lZ?=
 =?iso-8859-1?Q?Mk5gaa/Z/c67OcJK4LE/xzAVg7vXojpaIvhB/a4rn6u5dIjvZ6HFdBG0ws?=
 =?iso-8859-1?Q?pERODoWSevWnpYrDsnueXTADxifsprRtUR55zJA4hKDUKMsNXjCypT7Aye?=
 =?iso-8859-1?Q?zIKmNAwb1wy1QthwgCs5a3MLnwg0TLKOQzVSqVvcMQCnYrvfpg0H3xT/hl?=
 =?iso-8859-1?Q?65C/1B+vOBvTA464cUnfjolr76MoJcjktVd2jNftdoc0SSlLUCgxzTbisc?=
 =?iso-8859-1?Q?Bds+htRVx6/olnV6ZiMKo0fI88VeZxCeSCs68nw79B7kixchs82Aa/L1lT?=
 =?iso-8859-1?Q?EtJm7/okW+wGZ/vKh1N3XjDeEH47v7JKw1/QJeLJammTLQgMzR6LL4M18M?=
 =?iso-8859-1?Q?YEdTy9V0eTU3TDBUZIRgwjnCh4dggR7foQ0ILjp0e3TpZ7GiZl/9KWPOnR?=
 =?iso-8859-1?Q?Mg7xpKXQp1p+DfvPaTS2x2KGvWQvJTYI8v1f6OdNQL0W1BDP9OiQR2QZa0?=
 =?iso-8859-1?Q?B4AQ5fd95zyM03VSM7kceh2KBTH/VGMs7yYQuPhvugSOA6siwXmES8VXTb?=
 =?iso-8859-1?Q?sVCGl49Ba6i1x9VZnnUDrvd2DC+vkuGypcaPreVEROPGtGuxtIvWixXp4l?=
 =?iso-8859-1?Q?DIKTuOhHKUYrkb0ZicBnf9au0qi1A/BoJgfHvdYNTb/3wVW49S0j/0z4qq?=
 =?iso-8859-1?Q?fWaRLiujNZblWb7PxEX4X3jOkuO88XBb9aJG9onvAhqLXkNRVmGRiMPhEq?=
 =?iso-8859-1?Q?pEb4y37aAVGes88xBaG+783J5UaIeMrJP4xoMi2PtO3nk4HgzkLyO/+2Sx?=
 =?iso-8859-1?Q?BRbbYFVSUtbFQmdrDUm4vIvsbKS3KhwZn4JQ+y6HhfR3pA0nL6jPrFPh72?=
 =?iso-8859-1?Q?MBtts7pSqx0D0ANdCrBQVCqXFK4B5BzoOH64/7w0wOMVShEqA4FDb8tkzU?=
 =?iso-8859-1?Q?xE4Akj1/vp/uLoHoTmAVd6fYdnKPkUNs1SYsqivBGtGurnup92z0FupUhw?=
 =?iso-8859-1?Q?yTU5QheJsgZpR5NJyg5mOpALfWY/xBOkh/EApH6rbxHgGguOmj8qK1SqDM?=
 =?iso-8859-1?Q?Zus/xv4Wa1sCy/rbb4KpWRt/EJskDfL9FjLvEDy6/lAv7RwzUeoVd0OkV6?=
 =?iso-8859-1?Q?IFjdpLNWzpRZ31K0UGnSQNE51ITu7bc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7C9EB2721A25ED43AE16D048440FB803@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SumbshTGbJ2/wviFIyn7IHgfiVxJmWGk20zoLWncr1ti9vQT5F8AIEDH2N7zpTDufxJE4fRwugV7H8GznmtbIjCsJ3RNuKIK8qZSWgWmokon4zBmTSmtvxEKfYqqfvYJYKXCs8nnfUFBypXsrDzKQxpO0rBFgH0I4paAuD3fq7Iidzwl/3sw/Yn8M09KLJROYgc0QVS7a0BBuAehnLB018At8ividkgsoXI2us45gykTIAdJM7uTX99NGtzVS3tWmJW80EJcX+8FXV89GhLZJCTOPvQOnLEtmoJc63TkfQbpU+FTRn8JoGJeyZu5WwLg8lN8/++i6WIPygLY3nUQFg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR02MB7564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a169ab-6627-4751-153b-08dec565809f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 13:54:47.3164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1/1SWkTTPxdqQzoc8uzf8TJAT08AvXzHBh4FWM97OquKKHvoWXK6cSsISd0r79PORKhPXPEWTRNErYC4Bg88+j1saWIgjr5c7+T83Km380=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB11148
X-Proofpoint-GUID: CPvjcJLhhl5dwNFI_bq3UZk05pp2CvbQ
X-Proofpoint-ORIG-GUID: CPvjcJLhhl5dwNFI_bq3UZk05pp2CvbQ
X-Authority-Analysis: v=2.4 cv=RcigzVtv c=1 sm=1 tr=0 ts=6a26c9a9 cx=c_pps
 a=MyZQQtGQDv4zT9mHdzB88A==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=VwQbUJbxAAAA:8
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=ilBhJ_WY75J2y3JuSoYA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzMSBTYWx0ZWRfX+1zCIWMOSYv0
 eMF/LEklaFpuptRQdVbgYGjuFO5eM0PhasdqSc+28LJ3XvR7pgjgh+R2omGBRPrPKlzuNfmGBaG
 HYrekEwV2GEXWXKiGCpraYdgXyZuTKf1JJ8mWSF9ebU9YncxnwbrMEvlZiVrz8n96dovEjbtoYH
 yPo2Xq9zCq86L74Qom6xAW08lLLEPs4xAd7xGZM732lstmCdP2KdkPyeLvLPHMOUH331VHi3Vdi
 nYLrXjyFUSlHgRHVUYGUiITQ5zqO5flkpMZxHt9OZ+0yyij13OzeIXW+AEnXgcN6xQ7IiY44Px+
 Oo2XaT25xECicEEeh4b94S5rVmlJXk//AEp9AZ+3+cV/3d5eaJOkKkgV5wzzCpdQm4O0EyAVZEV
 jAUpjlfC5LDvIOtVKliK9kmh6LQ9IlqtS9YvrZvvOdBtdqQEK9GX+4tkZuy0p+Fscgg4DlGrCAq
 Cl5QnI8CcCPAbWHUDdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=khushit.shah@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Hi Alex,

If there is room on the agenda, I'd love to add a topic on the ARM64
named CPU models on KVM (RFC v2 sent last week, [1]) and its overlap
with "customizable host model" series ([2]):

  - Property and value naming. Given the two approaches in [1] and [2]:
      * property names: feat_<FIELD> [1] or <SYSREG>_<REG>_<FIELD> [2]
      * value naming: kernel sysreg derived string values [1] or
        u64 numerical values [2]

  - Named-model overall hierarchical design:
    (Architecture mandates -> Reference core -> SoC/Vendor opt-ins)

Thanks,
Khushit

[1] https://lore.kernel.org/qemu-arm/20260605083358.1320563-1-khushit.shah@=
nutanix.com/
[2] https://lore.kernel.org/qemu-arm/20260519132905.145643-1-eric.auger@red=
hat.com/=

