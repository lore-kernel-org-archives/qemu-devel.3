Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA76CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBCpT-0003Bk-Vx; Mon, 28 Sep 2026 10:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1xBCpP-0003BS-24
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:59:39 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1xBCpL-0000Cu-Us
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:59:37 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEgaxL1871306; Mon, 28 Sep 2026 07:59:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=0xly/Tuv4PoSgxD+x3uIyheC1n3z/n5uuo3tHGAA+
 MA=; b=gen9EueOvHX8O3LP0+YMYgwoZcXoWuoL8eHFLdD4/0cYOVB/Faaw+jpWZ
 Tf9jtzgY0UiLoOmC7cGzZ0RxdkXxZvnYdHa/3hWC2vvoLZqDX0MRU27B1na7MCTk
 CoalwV/94vmmfDjZ9ac6jB3C7AF1tx04hVcUoQme+gXnltDLrphJfX8uPRyjp5Qv
 cm8q1hYiqmKWVk/Vgis/zR7qaGK82a4EQGedToUDxB95Vl/u2JWbCMyXjy1k7mG3
 CkppINZU/+u+XmPlmAwpVbST1+3Satsew+2rJdNXS0B6yjhB6pZ4YvD675ND/xGg
 12gxJUaAIJQBVkxqEmflSjkBgAJUA==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023136.outbound.protection.outlook.com
 [40.93.201.136])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gxbk5kntr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 07:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDy4+nQ9AknmP22MgHjrGiIz6/i6XzjSEKgotSBdCEOPVBZnFLvTFXp+YFfc/VuHg1FgG67T87rN9EkGHKXW+AZquPQoUoh/2og7jywBIAEqtxPKn1kj6AV+xzxj5821vMvgEsJoOiVBKdt609BPytDRy6q3qRCLOQdMoxrbbySYhDl+FCj/CRc9o5lV/JcB+WzmeoKiUIoLfCSxtE/vXwWK2Q0IKOvG+CQaa1z7QbDrCh9/DooVF2m4orq0GEHy8ajzBMOS6yz7MlL8e5zvfo7sDRKcsX2OzUaTakMsVo1iUQ4jYL5wRgU8VT6DezTrGJWvjwy/BgRglr6waQAEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xly/Tuv4PoSgxD+x3uIyheC1n3z/n5uuo3tHGAA+MA=;
 b=enC+vA+HJ3TpbcSkySKgEgVuS4bUjpPoFmMNy6Hxbn/uA6mxat7zG/xyOsnVCFTZ6LJZ0mAb1CfV2Oc4SVdvRsxGPbVj1IuOQg0Y5A3KDP5wOadozPYNtB9ESmR9fvkP422I6O8YACJFEnW/xd2JbwM3zmWM/UUbBoi1OrepGSdH6hAxs1aazHFu5AkTVO4k0wiGx6RqT6Dc35NRy2iL0AeMB+R/qD1W5k7G2/51dz+c/yjOpW5/9sojtX5502wwNuway0Gmin3awQrl/BPJUmPWl5OMduM+0qBp37KvM6WMlYf2HyUGxAnrFSKQHxfnUZ2XyEL1xPekTw5taA2nPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xly/Tuv4PoSgxD+x3uIyheC1n3z/n5uuo3tHGAA+MA=;
 b=oDqkZKOeTl4ath88yGqcjHyQn4sgfuRMEl0+RHe3vdcpS91YrPJUuUQHgsFaHVE2bOfad9HRxIo2DJFw4yBVL4IzcGqhOKqvV9bmHYdjiFoB8pGoWCPL2B4NNP7xKMNHNxg70AdqhGMeSSFkKoNm29CeFKhvKjfa63AyPPtRdvKjOQoofkSerSQbzgT++s3+sIatyejogfjO5um94TYd9ZnR2S8D+qTpuW77PnyYwgRN7Ac/sjVu5CrZb6qBq5RBjzfidWiNjguPfvSOiBctmE7JyCd3XieVzUP1qF6O0fA3CdPKD1ilbFpAPXPa4AzO9GTqnMN1LD/vUpR2uAPcJA==
Received: from BY5PR02MB6307.namprd02.prod.outlook.com (2603:10b6:a03:1b2::16)
 by SJ0PR02MB7790.namprd02.prod.outlook.com (2603:10b6:a03:32a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 14:59:20 +0000
Received: from BY5PR02MB6307.namprd02.prod.outlook.com
 ([fe80::63a4:3abf:9207:1093]) by BY5PR02MB6307.namprd02.prod.outlook.com
 ([fe80::63a4:3abf:9207:1093%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 14:59:20 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: Richard Henderson <richard.henderson@linaro.org>, Mark Cave-Ayland
 <mark.caveayland@nutanix.com>, QEMU Developers <qemu-devel@nongnu.org>
CC: Tejus GK <tejus.gk@nutanix.com>
Subject: Re: buffer_is_zero() constant optimisation not always applied
Thread-Topic: buffer_is_zero() constant optimisation not always applied
Thread-Index: AQHdS1KT5OzPCAhS8k62avTjeFZ3Z7bcTYWAgAfNyoA=
Date: Mon, 28 Sep 2026 14:59:20 +0000
Message-ID: <272BAD3A-5243-479A-A090-2D65E314CAAE@nutanix.com>
References: <06a98356-20c4-479a-a8f7-392ce5b941b5@nutanix.com>
 <a78097cd-0a54-468c-b999-4b37d5f92032@linaro.org>
In-Reply-To: <a78097cd-0a54-468c-b999-4b37d5f92032@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6307:EE_|SJ0PR02MB7790:EE_
x-ms-office365-filtering-correlation-id: 0857028b-9185-4d46-89dd-08df1d71136d
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: mloV767jMLD8vDkYpR1yHh2sSx6s8QLYk0xejTMhwXWo0rgcF9eDKt5cY82zM3NIzLxQfrmQyDTVveFatZsQXJdN5HhsFzAUpuO9jqwsmwsSJpMIlxNLnBCJK1Sz0NO1GATIccBvrR4WhnQ7Qir5s5iLWY4wVzJbCgiY5kvf2ciFT97cuPZlwNDjmGoA0ddG8jl2jcLYIk9D7s/Vrxz5xIWbyPNiaEKTNuuJaJQOxwwWR7zZHpddTlQIC/HP7Is6CsA1EFuJGRD4+FdDezQUT7ZNv/qDJJomsrnAD/s5r3JnC73oH97sIDIYcRmHegsuvQq6BnFCYFiIC8HYnmjUuhbcmBLgEtTB8c4Doev6rdmTSRt0Z/zaxZAwLhQ7kwsepHrjiIbcUCdUJEMZ2syTbyiIhuzQ/tlJ30C++nfbxLvcljACNaBc5ZG0oSThYYMg9BmjbEveREN6tVh1UipQhiR5Sl9NSmoZjjFru4uz7ymg5ItwpOs90UtqN1yfcRT7+W+aG9i548SwRIPuuYmK/FVYy9MxTEciAWWvUYJkl8VJYoRWW49IIw3rrNx+aNf7AY414JHnTRgYTXXgWwEmivkqkKaIxJvFY6uECdxAx70HxFeizrkWKf6jA+pUV3IqctoqQi6uH/bldBiv0C4VEy317jxcXvmd1cXoQPZ5FQMLh7mi4WA4K0T7SWrQ3634H+Cv0g8iPuw5MvNBfhepJ8D8c0pdWv6TvOaast9CjQ4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6307.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8lVRa3LIe2b15WIh/y0SCJYWuRdgz/KlpgNuAzMYPXEeXoQZG9mUz4wIwDIs?=
 =?us-ascii?Q?9/XUOv0DGVlfCvL3Hsku+f1lrhG4R+mUxnSEMUs+Ytzi9BwJeeOiT62pOHWi?=
 =?us-ascii?Q?qrGa5Wzsf7+wZcB4/xlm0/8GhANVS/mhD6bBSRNne8a94UeS07AYGRiUIOmC?=
 =?us-ascii?Q?nZvu9PWvg9HS3hVC/5mQWB48lILf5DyVFikWyzY2GupB7fG6vymSEp9CHuCv?=
 =?us-ascii?Q?zujHYfmMFUOLM/tpCbVo7PjbIlCtNwEWLWd7yk8fTOdAENVzFScGkxneip1U?=
 =?us-ascii?Q?Ktx9jcgn81OMY208GIZSJ0/kdGAjweBn4mlOXIVxJTWxsHah6gBIv0mnMzMV?=
 =?us-ascii?Q?55rAF4K2OvVpBwXgxNGFA2YHN7YS8TVp/x/88REmyWEX5MUHDRpvSEQWuKu2?=
 =?us-ascii?Q?eSz3mJvoAnRqcKwV1FUQkqGnCN6a3ZWUguDMFbHkjqT1uCe+a+tlpox0Q+M+?=
 =?us-ascii?Q?BmmoauvZ+1sADNRGS5A0ZASO0/IdbJ8a4S60xPLRY+IlOWWn6Dgi93uO+qF1?=
 =?us-ascii?Q?JYtMu5MiSdOkcXMEm+E8AwgZDjFo11+H2rWA58fT7n36nn7AyGv42pvLUfP5?=
 =?us-ascii?Q?sgNsNmu3mA3TBxox551FtuXicrUnis61UkfHJ18LHacbX0dBdlq8Jvs6j8p3?=
 =?us-ascii?Q?g4UnQId3B7uX+DBOOGTE4AtVnl1aWc+l+E80ws7ZsuQuviUwedyldob972K/?=
 =?us-ascii?Q?NPlzLw6N4Y9U/L/ofDZy+o0GM+nBrsJPMnS5+oYsxHThXU9Y7YZWMVno0SML?=
 =?us-ascii?Q?3clddWX4MQlncAHEp1vBKiqoBqhkFeDDCRBIPqRxhXtRacIs4BLVYafUbKfn?=
 =?us-ascii?Q?HF37sKnxIyCFsvFmKLbtHCo3IY3pqraB5T8bpfU76krq9/zoO88L3kwpg9RW?=
 =?us-ascii?Q?PeMA5IBhzgXZs9pETuzkDl4Rlxk2ic8Y2MXFKDRgrSimrw4eQto931J0gQed?=
 =?us-ascii?Q?kajL25sdwHcvhxoqGutnL0SEbc+ACR8jJfN1FQp0VBwMpHSC6Ym7vvEudLLN?=
 =?us-ascii?Q?a+NTMlppZLDKtkHog78CdCoq403R4deJxUZltehQe/6AyWbchUrItawjDtuW?=
 =?us-ascii?Q?PejGJmBfIAOOJPT1L8C+qkyy4HE8fokZoxHBSDx+i1q1qgqN769enCkAtuBk?=
 =?us-ascii?Q?AOsMbbTLpbPppTU1yAQ0ek03wxbdM8p57fzYXyATlfEewoCe6L9wFeX3yNGx?=
 =?us-ascii?Q?lZ74w6tDaJfb/DIj/iJv/57U2kZgYBp68evo1mbF0gxCavfKrBJWPenHfKnS?=
 =?us-ascii?Q?VpwcOjzYDy2mo2gN6IibZAoVdzMkC9BQnVEVzsTq7OiSU2xQxcG+hkcNpFkM?=
 =?us-ascii?Q?dONDVJmDJXeprn9+0zJWr134X0Rdl7kb09/gIskqnWrEwrgKgCuYrA63t+WZ?=
 =?us-ascii?Q?bpumnxoiq5EXi6IJOD7c7yptWZC5jt1Uinzbpax2GCMi6AuXXygYvhNp8olT?=
 =?us-ascii?Q?T+yCy6uc209ITWbo2Oe+yqCd5hnZsR3Dzh4XNP4A6uhWeSN884rzddCnTQlI?=
 =?us-ascii?Q?/59fEwFpaiJlNKklsk1PrS0WRT5Y/jHOX7yxb1CXv8LbXGCWr0rOv+OdNTQt?=
 =?us-ascii?Q?T29ug6t8ZiW+rJVo3555urizljTW5zEIWZqMfXpa+Lde9gX19AWFelllkwjI?=
 =?us-ascii?Q?cVShYFljZgEqPffxBKQh5n467bsNb/ifmU6wEu1FjiCmO7MMDkTzJUibfvAe?=
 =?us-ascii?Q?kI1uoFpL3QPidQpFGeRYjQG3jR82iaJx9Ie2pKXy3juF1T8czE9cmwqkwfjF?=
 =?us-ascii?Q?sis5cFcLvg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B69EC4B7B5A9A7459AE4BE24AC1C862F@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FSxEVqko4awsG2mx5W5PQlktG7032KC2dJxiLjU/VW5pYLJ4201+DDtZzjXUG6rDGUwPUQySJhNBjaHyshulDbpq2iXSjlwjcYrzE0OiuBm+OxIomNvub30uzk9/CtUtJk3wW6+/70J4cxqDetPUCPbJMzUf/OCW9ZLpmtZTQ4hWuERVI2ITtTEDJFACFgce1+QlxcdXUM34ekFmrk/Pk2RueoKexSuhNQNNS5VaxlLJ1hF5ydbvgYvKfYNLqc7iYjXBVlfYjiZBFzba+HYTJhn2SQ3D1lSbKtXTsVwjUrot/bl9n/owEnOKEpgkTCztmzR1K97OrU2O/t3wu0SfeA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6307.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0857028b-9185-4d46-89dd-08df1d71136d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 14:59:20.3980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQuVi2W4t6racceziKvTXeL9K7Wm0hrBSRkrk2DykUO8eJzXwUJnI4/S2NaiJW6fRMO+LT3sTwQgf4kLY2wXmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7790
X-Authority-Analysis: v=2.4 cv=T6EZ3PKQ c=1 sm=1 tr=0 ts=6aba80cb cx=c_pps
 a=ppJUfaEfP5EjbsERzBeGhw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=83Diauz75JeXwYjDjCkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: MIlE9g1DJjpd-UJ-uf0-gQf1UULAeYpX
X-Proofpoint-ORIG-GUID: MIlE9g1DJjpd-UJ-uf0-gQf1UULAeYpX
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OSBTYWx0ZWRfX7tuLwmIVMtkE
 xwbaqe2JcD998G9mtuBvlC/MjeYm6DqYAL8MCjXVXtnAvp2f4QedXcGXdIhcuiuti0Bdb/B7kJn
 uf0ygo82P6MTIobtscUzgz0ydLoaF/M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OSBTYWx0ZWRfX9dISLFer/x2x
 E2PS4CvIsn0KTanZB9cmvsQBYjrwL4JtgW6YbnYawZW6n27huo+Lve8TIK92ERkr2pLssnWx8XO
 sP2WqFxtL37VMoyFFMhyY9bba+xZ3NslFHmNxkpiPMDdCy2caDT/dJDTV2nFYzhys9oSUzOPZHc
 vfJcG5/68lu6Hhr0FPZD9i9jqT8LnmbYq8BuxFo+/RVzzfk5q4QDWUV4dLc0B1GhkZpXustnl6A
 bxRZUzVrVAdM5i6olJab29YP1BNLgEsomWwn9WWoRdBFawCUBgNmPLOyfbLCRrJLok2DzS4QOgO
 8YtiSnHCS4Ic68mggXt8O2cMvO7gAbZbZv0i7FzA6Q18HRw8bzQzQm2mu04/kTSkRyHfDVxvM43
 02w6TTXafuruwScn9MWyx/W7gyJ9blsz83zmM0uvfzsL+ndQ0FPiZ7spJtacmNywH3mN0XJ5rBO
 M3gYwGJ4MbS3KkpptAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=tejus.gk@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

On 23/09/26 9:12 pm, Richard Henderson wrote:
> !-------------------------------------------------------------------|
>  CAUTION: External Email
> |-------------------------------------------------------------------!
> On 9/23/26 04:55, Mark Cave-Ayland wrote:
>> Hi Richard,
>>=20
>> One of our engineers, Tejus, reported an interesting observation that du=
ring multifd migration the zero-page detection logic was falling back to us=
e the out-of-line buffer_is_zero_ool() implementation instead of calling th=
e accelerated implementation directly.
>>=20
>> What we discovered is that the optimisation was not being applied to the=
 buffer_is_zero() call in multifd_send_zero_page_detect(), even though mult=
ifd_ram_page_size() is effectively a wrapper around qemu_target_page_size()=
.
>>=20
>> Digging a bit deeper we found that migration/multifd-zero-page.c is not =
being built with COMPILING_PER_TARGET and so we fall back to the TargetPage=
Bits logic for qemu_target_page_size(). On a local x86 host here the expans=
ion for qemu_target_page_size() becomes:
>>=20
>> static inline size_t qemu_target_page_size(void)
>> {
>>      return (-(int)((int)target_page.mask));
>> }
>>=20
>> which isn't considered to be constant at compile time. Given that we are=
 building a fixed x86 target, is it still possible to get the optimisation =
applied at least for the migration use-case?
> Mm.  And we certainly won't want to build migration/ with COMPILING_PER_T=
ARGET anymore either.  We should probably just drop the __builtin_constant_=
p test these days, since it'll basically never be true.
> The question is whether buffer_is_zero_ool is good enough or if the inlin=
e buffer_is_zero_sample3 to (potentially) avoid the function call still has=
 value.
> Anyone willing to do some microbenchmarking to find out what's best?
> r~

Hi Richard,

I ended up doing some microbenchmarking to evaluate this (i.e, buffer_is_ze=
ro_ool() vs buffer_is_zero_sample3() && buffer_is_zero_ge256())

This is a hacky benchmark on top of the existing bufferiszero-bench.c
across 5 different scenarios.
1. A totally zero buffer
2/3/4. A buffer with the first/middle/last bit set to 1.
5. A buffer with the second bit set to 1.

From the results it seems that both look roughly the same, sharing 4 runs o=
f the benchmark below.

[builder@59dede8818a3 src]$ ./build/tests/bench/bufferiszero-bench --tap -k=
 -p /cutils/bufferiszero/page-paths
# random seed: R02S51984eb049bd55991e22d5c5a5db2d30
# Start of cutils tests
# Start of bufferiszero tests
# zero              inline    29.57 ns/call, ool    29.21 ns/call
# nonzero-first     inline     0.98 ns/call, ool     1.57 ns/call
# nonzero-middle    inline     0.94 ns/call, ool     1.61 ns/call
# nonzero-last      inline     0.81 ns/call, ool     1.56 ns/call
# nonzero-unsampled inline     4.62 ns/call, ool     4.39 ns/call
ok 1 /cutils/bufferiszero/page-paths
# End of bufferiszero tests
# End of cutils tests
1..1
[builder@59dede8818a3 src]$ ./build/tests/bench/bufferiszero-bench --tap -k=
 -p /cutils/bufferiszero/page-paths
# random seed: R02S9384443a1f0d8d9720d33bebfd88da0a
# Start of cutils tests
# Start of bufferiszero tests
# zero              inline    29.90 ns/call, ool    28.48 ns/call
# nonzero-first     inline     0.78 ns/call, ool     1.57 ns/call
# nonzero-middle    inline     0.91 ns/call, ool     1.57 ns/call
# nonzero-last      inline     0.78 ns/call, ool     1.58 ns/call
# nonzero-unsampled inline     4.64 ns/call, ool     4.53 ns/call
ok 1 /cutils/bufferiszero/page-paths
# End of bufferiszero tests
# End of cutils tests
1..1
[builder@59dede8818a3 src]$ ./build/tests/bench/bufferiszero-bench --tap -k=
 -p /cutils/bufferiszero/page-paths
# random seed: R02S5bc450f60fc7d570caf1cbd793fb3b7e
# Start of cutils tests
# Start of bufferiszero tests
# zero              inline    29.17 ns/call, ool    29.11 ns/call
# nonzero-first     inline     0.82 ns/call, ool     1.66 ns/call
# nonzero-middle    inline     0.91 ns/call, ool     1.55 ns/call
# nonzero-last      inline     0.78 ns/call, ool     1.69 ns/call
# nonzero-unsampled inline     5.30 ns/call, ool     5.22 ns/call
ok 1 /cutils/bufferiszero/page-paths
# End of bufferiszero tests
# End of cutils tests
1..1
[builder@59dede8818a3 src]$ ./build/tests/bench/bufferiszero-bench --tap -k=
 -p /cutils/bufferiszero/page-paths
# random seed: R02S82f69e448d8bb03acde648f445b37d35
# Start of cutils tests
# Start of bufferiszero tests
# zero              inline    30.23 ns/call, ool    29.22 ns/call
# nonzero-first     inline     0.78 ns/call, ool     1.56 ns/call
# nonzero-middle    inline     0.91 ns/call, ool     1.74 ns/call
# nonzero-last      inline     0.78 ns/call, ool     1.57 ns/call
# nonzero-unsampled inline     4.64 ns/call, ool     4.42 ns/call
ok 1 /cutils/bufferiszero/page-paths
# End of bufferiszero tests
# End of cutils tests
1..1

Here's the diff of the test for reference

diff --git a/tests/bench/bufferiszero-bench.c b/tests/bench/bufferiszero-be=
nch.c
index 222695c1faa..0d5b63a3e8a 100644
--- a/tests/bench/bufferiszero-bench.c
+++ b/tests/bench/bufferiszero-bench.c
@@ -8,6 +8,93 @@
#include "qemu/osdep.h"
#include "qemu/cutils.h"
#include "qemu/units.h"
+#include "qemu/atomic.h"
+
+
+#define PAGE_TEST_SIZE (4 * KiB)
+#define PAGE_TEST_BATCH 1000000
+
+typedef uint64_t (*PageTestFn)(const void *buf);
+
+
+static bool __attribute__((noinline)) buffer_is_zero_internal(const void *=
buf)
+{
+    return buffer_is_zero_ool(buf, PAGE_TEST_SIZE);
+}
+
+static uint64_t __attribute__((noinline))test_buffer_is_zero_ool(const voi=
d *buf)
+{
+    uint64_t total =3D 0;
+    for (size_t i =3D 0; i < PAGE_TEST_BATCH; i++) {
+        barrier();
+        total +=3D buffer_is_zero_internal(buf);
+    }
+    return total;
+}
+
+static uint64_t __attribute__((noinline)) test_buffer_is_zero_inline(const=
 void *buf)
+{
+    uint64_t total =3D 0;
+    for (size_t i =3D 0; i < PAGE_TEST_BATCH; i++) {
+        barrier();
+        total +=3D (buffer_is_zero_sample3(buf, PAGE_TEST_SIZE) &&
+                  buffer_is_zero_ge256(buf, PAGE_TEST_SIZE));
+    }
+
+    return total;
+}
+
+static double benchmark_page(PageTestFn test_fn, const void *buf,
+                             bool expected, uint64_t *calls)
+{
+    uint64_t zero =3D 0;
+    double elapsed;
+
+    *calls =3D 0;
+    g_test_timer_start();
+    do {
+        zero +=3D test_fn(buf);
+        *calls +=3D PAGE_TEST_BATCH;
+        elapsed =3D g_test_timer_elapsed();
+    } while (elapsed < 0.5);
+
+    g_assert_cmpuint(zero, =3D=3D, expected ? *calls : 0);
+    return elapsed * 1e9 / *calls;
+}
+
+static void test_page_paths(const void *opaque)
+{
+    const struct {
+        const char *name;
+        size_t nonzero_offset;
+    } cases[] =3D {
+        { "zero", SIZE_MAX },
+        { "nonzero-first", 0 },
+        { "nonzero-middle", PAGE_TEST_SIZE / 2 },
+        { "nonzero-last", PAGE_TEST_SIZE - 1 },
+        { "nonzero-unsampled", 1 },
+    };
+    g_autofree char *buf =3D g_malloc0(PAGE_TEST_SIZE);
+
+    for (int i =3D 0; i < ARRAY_SIZE(cases); i++) {
+        double inline_ns;
+        double ool_ns;
+        uint64_t inline_calls;
+        uint64_t ool_calls;
+        bool expected =3D cases[i].nonzero_offset =3D=3D SIZE_MAX;
+
+        memset(buf, 0, PAGE_TEST_SIZE);
+        if (!expected) {
+            buf[cases[i].nonzero_offset] =3D 1;
+        }
+
+        inline_ns =3D benchmark_page(test_buffer_is_zero_inline, buf, expe=
cted,
+                                   &inline_calls);
+        ool_ns =3D benchmark_page(test_buffer_is_zero_ool, buf, expected, =
&ool_calls);
+        g_test_message("%-17s inline %8.2f ns/call, ool %8.2f ns/call",
+                       cases[i].name, inline_ns, ool_ns);
+    }
+}

static void test(const void *opaque)
{
@@ -42,6 +129,8 @@ static void test(const void *opaque)
int main(int argc, char **argv)
{
    g_test_init(&argc, &argv, NULL);
+    g_test_add_data_func("/cutils/bufferiszero/page-paths", NULL,
+        test_page_paths);
    g_test_add_data_func("/cutils/bufferiszero/speed", NULL, test);
    return g_test_run();
}


regards,
tejus


