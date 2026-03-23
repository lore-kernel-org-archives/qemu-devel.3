Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18919F483D8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jL2-0002Pa-Pw; Mon, 23 Mar 2026 13:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saarnio@qti.qualcomm.com>)
 id 1w4jKv-0002PE-9V; Mon, 23 Mar 2026 13:45:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saarnio@qti.qualcomm.com>)
 id 1w4jKs-0007Dt-J6; Mon, 23 Mar 2026 13:45:09 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NFGitO3589370; Mon, 23 Mar 2026 17:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TvokymQhWA/opH+qXWJW5KQKu85V4pIzUnkfjX2j+co=; b=jf7oU7O1SAP91AoG
 QbTLe9DkacPvihf+tbHgx/30S3H/78Xxd0+JEMbAE1nqsM2GCFX+CGAz9uq8h/oH
 Cq893zY2YsV8o90mDEqpskowEorclkp6MBIoQpcrDqBPWOedYjoDkBMYCtYI57n+
 U3/uP3J/NnqaKwc2GKHQsuXYTnM3ziGPpaPPougcKC7rcRlatLtbFU+iBdElVqnu
 zG5HfsuItsOpkbnWnlKgn4VEBP3nh3vJP/mbXjw8dTUkl0ynAPsPSE6XPjO80/m2
 c0sWU8KK94KpyegQgAyoropjDuN/GZmeJbH4KOlYGmWBfZcxceCjX+CmnapT6ZvA
 edOf3w==
Received: from dm2pr0701cu001.outbound.protection.outlook.com
 (mail-dm2pr0701cu00102.outbound.protection.outlook.com [40.93.13.66])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d37a0gq10-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Mar 2026 17:45:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STMfPyti9lhTqQbJ/RdGgmR1DMEnNL2cYcGxh/A0LnO3PpIjuWIsBSs3eyWfthlR6/XOamj5Ag5SlrxNpGmvghvgU+4cTXLqMRuFql9dVY7FcerPb92/0yP+e3TsB/ZN54kx/OEdT73U7cpiRZwqMuR3h9cHCi1rsISN4mxAeQS43vW7/XHp8eK4axGiQSnuJSvKUUN7TkFyP7Z7GhvEE8/f3DgIj5rkPnq015XMDaffWB9y5L6EC/Uigb34ey91+xxFppC2n2B/bomfaEMolYRq8S9+OLcHPT3962Z0qLIp2PyrgDAlG+nTS3lgq2Zy4NcLtrYfJCmNl7gwWbWFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvokymQhWA/opH+qXWJW5KQKu85V4pIzUnkfjX2j+co=;
 b=VgCpupJlGmXxYAKyRdj0f+ODg3w+8Bi5w5gV9FJmiDHZuL+JUpCKZIAKLIoaz43nnBnQqmkCb/9+uLtIFN8k8hogPHRkx95kayhdNWx1iLcUt7NiwdPdXzUpSc0f4T1Ccm8UYnsyB1x8xUXmYg/9uG/Bxah6sov1RQSaNPNk8B/M6ZQYLJ8+tQ84sRq3idx92I0THH3/8N0gTNVGs0X3QiC1AaXT7MkR5zSGX9L7WUwDRKs65US+VyAOQGYXtDtrRtlKpD2mTez5dWxctpyY1N6c9KcxTkLE9aE9FYItrmS9YxJ+tEVhGPBIep1heqnxGUwSynRTkaNG69Fcnok5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from MN2PR02MB6622.namprd02.prod.outlook.com (2603:10b6:208:1df::21)
 by CY8PR02MB9522.namprd02.prod.outlook.com (2603:10b6:930:79::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 17:44:58 +0000
Received: from MN2PR02MB6622.namprd02.prod.outlook.com
 ([fe80::6dd2:4e81:dacc:f239]) by MN2PR02MB6622.namprd02.prod.outlook.com
 ([fe80::6dd2:4e81:dacc:f239%4]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 17:44:58 +0000
From: Steve Aarnio <saarnio@qti.qualcomm.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>, Michael Tokarev
 <mjt@tls.msk.ru>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: Re: [PATCH v2 1/1] meson.build: Add --enable-pdb option
Thread-Topic: [PATCH v2 1/1] meson.build: Add --enable-pdb option
Thread-Index: AQHcuuzEMOnVsxuCJECJrh+gjREEfA==
Date: Mon, 23 Mar 2026 17:44:57 +0000
Message-ID: <MN2PR02MB6622D6619419DCD792B5F3B59B4BA@MN2PR02MB6622.namprd02.prod.outlook.com>
References: <MN2PR02MB6622718572E2A2B5E4EE3C039B4EA@MN2PR02MB6622.namprd02.prod.outlook.com>
 <9c5998db-7368-4345-8d87-bdc0a0c9da78@tls.msk.ru>
 <CD39E113-FAE4-457D-A5C1-16BED1A94774@unpredictable.fr>
In-Reply-To: <CD39E113-FAE4-457D-A5C1-16BED1A94774@unpredictable.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6622:EE_|CY8PR02MB9522:EE_
x-ms-office365-filtering-correlation-id: bb0ce974-64b4-4fc1-6b99-08de8903e6b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: iZBpndmUJ4Q89maUz1J4BbHrMtTZcWOfCseCqkmccbzVeWFeAZiIkSqvIHfiqeaH3yy94HE9SLP8JvKH6n7tfIrcg8jadtn58fZizT3+Yjn070Fn/pKWaeD97NdJ2OHs9cJLM6zqF0cdXY2d+1AREvdgPYq2VFE5SmclggtDg0Br2nZ1Do87ymw8eomBVPmHx9/JTR2C9gX42jMvUnXm6uBl6BGQupBt/M8S/Jrk4rGVrT1qAv6S3ip02EsE/tLsQAShEWi15wh4gu9jnZs1LCVIRXz3BEXb4DyZOsuj3Wr2X6SVZBaGxqqvlvPctm4hwRtsSYsYU1sXlUiWHPf/hjrWvrKXyA7uywi3RMApO03RwOpmT9oxrL847/YCCC7m/vnmmV4QiUiaHpJRRLjD8XONk0GIEw0uf9elD9MjwzRbYK36MbWaFvaD3Y6mlj5basIHyM4+Y3G1eRO1rIvAFttMTYWKipGvRmWtBjWfmzk3qCKr+YDCXpAOJEkWluKlvrikUseXbVz83ld0KXocV3ZF4Xu4gB7FLdPQBBQ0FGY/zgKBRCYnvfJDdJSNB3RF6Zhp7+SMKQVqJSM2PnTBWZnBzO/4xy+PZ11Au5dsmMxeEIZBbBOEsgJYxuDJ7Al/AaLHvHRS+c6wFLVnNisgEJGv0xfTVY/7khr/ICX18Saau/EPiBpvWk/fuFeLrYuWKoBd3Gz9nNGfa/br+wXe6/zksmugAXnrtta/Qx31EgmGaGRSEE2IRsE/hucg6r3etISS6RYX/Ou6lW4UXflqDAqiVd5m55D/2Iqyl121QQA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR02MB6622.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PDAYkE2/KyupQuuLahv90MdtY2gqTDSoufGITa1ar/DXL/q2pc0meNX06H?=
 =?iso-8859-1?Q?bTgQXsnWM68wTERRs3no1NiF27fK7TouHFn36j4JpAfCj/sSn/VBkwL1sG?=
 =?iso-8859-1?Q?zD1QoEB76n6/IajR02izBROXapF0IYjs9+ud+tmwyKIuD/xgwKg3wDk/Rl?=
 =?iso-8859-1?Q?zRDrCUEu/bcTcGG9X+wbkdcm6gBpQJ0iHfJWK5ndxqq3YAFTTk9yk2gg5l?=
 =?iso-8859-1?Q?EP2Ytq39ypQVaxvWwWj3Ymx4h8GOidQY1zqhEGk+f8+17/Hwct4SmWe0kB?=
 =?iso-8859-1?Q?cE+uuT3r25OZXMCzJs3i0J3LBb+ALeCo3NCJ2Jsn1R1i0S2HHIxYaRhbpL?=
 =?iso-8859-1?Q?NfUtI6st+xLIG15v3nRqfhsZMhJpr+eucMzTWXdE8hzNweg4FGZNWe0n52?=
 =?iso-8859-1?Q?jY5nhY476AZ0Vr5HadAz9y5+61TDY8cNpeYQElERAvo4W/3YGI4kek07Dz?=
 =?iso-8859-1?Q?fK1UJzza+cgcey2XXVGVT/2N4OHFJHzxcNKi16M6QW3dWdCkev+j0ZgYDr?=
 =?iso-8859-1?Q?Saum/OzwKBmZmHsu70efe6MRzsmUlTqG6hMT4n09pXJX91VJXA3yRr/hBI?=
 =?iso-8859-1?Q?bcYII9284+VwG03B9HELJphlluW/uheYT4t7Ldzj1gc5IVf1AwwqqJUN5G?=
 =?iso-8859-1?Q?FwNy4k/SIkZ2OlJWikTquLkYNqmBn0RwnzFKv3VrkQfTtyAoisW0i9o7Fn?=
 =?iso-8859-1?Q?eTtftaN/NegGK68qce5sGm1lB+3V/P7lQkxac+1X9KKvlXE3t3q3gN/JVO?=
 =?iso-8859-1?Q?DbeKiFQtQSjtajLx/mhjpNR2XLwAx/t7Tna0y4aeCbV3ctiBMSreUZFQgT?=
 =?iso-8859-1?Q?tr+oN8uM12ezRXQtY0Kbt5jUHNpRpMNz4s4GEdAq/JMKzN85H+Cg2y42GO?=
 =?iso-8859-1?Q?WBhXyKUE4dikYApWuBA6HppgLjOirHBM6uBMRgEEXhDM6Mb4zhaOl/rptM?=
 =?iso-8859-1?Q?ydzeIeT4Ww2uF5Rq8Zhd42OzQjwOOjmXwdJXA2u6MOnjXPVHYZ/8HywMbe?=
 =?iso-8859-1?Q?A+WMhsRHBbR5pwQTEYr00IDciSneUNotOfevEBEl0gZT0pLT9sv/EzyHYh?=
 =?iso-8859-1?Q?3FFoiX2scdZ0WP5jw31OQIlOBl++UPDzoyv4SGW/9cfcjzQqZ62dQpAMEM?=
 =?iso-8859-1?Q?qSn7OTl2AtaKtltc+CeyROkCCyBbSi+SD7aJnmQ1hkVhHO2P0eRW9LVphj?=
 =?iso-8859-1?Q?hf3ydjfKK3N8cWPxiv/lTp38Tb0O0UPGhS1Lr3+K4IjuhH6oES1hLA7H2a?=
 =?iso-8859-1?Q?/u6Ld0ieVpk4SrBhoPQDQ3wGUYtOpmjADpQtdhwCl2SJACOxGya3UCyZ80?=
 =?iso-8859-1?Q?45cJXa3l0eq05SFTXAh7E10ncSixb+3LwJ/cniHipMVhUZKHri7sxAA539?=
 =?iso-8859-1?Q?HqaIkMFIzuchNgqxI1ivyFsacstvRZoAoDP2ZTbRBQbv5Uu3shhxz2ow6E?=
 =?iso-8859-1?Q?4C3FLBQSecmcZeJFXlmcb2om79orOS7yP3kOah7izl3yYaXjq/QB0YCtDd?=
 =?iso-8859-1?Q?NbUb7ON0/O86NSC7ZarkI5S1v2H/7t6Hzoqt00F8TR+tBAeGZvLlIiRcUh?=
 =?iso-8859-1?Q?hohaOwynbbJqfgWeVeyV4E6SwMSVz18kacyrlZcccb+P0ueRgzVboWYVin?=
 =?iso-8859-1?Q?chzbgOjj5Tfe5qnJUlNPB0xB2Bg+wh/e7anT6DJY/0w+lUZ74+ZtPoeLPm?=
 =?iso-8859-1?Q?Q+j3tjbLriVQDo/BzBp2ys+YAEOMBtsVtF1tyCg9npT6YqtQONDydl3w7c?=
 =?iso-8859-1?Q?LicIuxyP0ZQH/Qh1Pb9go4LBDKT4Rex73i4aTMljLkPiF0Xo0B9/OZtN6S?=
 =?iso-8859-1?Q?XDF8SkO1Jw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: txzPd/n7acg2jq5zMKAKY7xAxIaaI3cqT8tODHCh/hJLDsFLHyNojAf/aUpvyoQEHb8c38B2uQVaDnN6fSSpAgkIFdrPwYEBzYwFef+Hhq0tGwInI525hr4o+4YhxyQDwWMziNihCAz5/HGHrLx9VErS+PC27zv0Qc65YeyOMNPbrk6E06luKh/ktfbmDsrWs/zNXYxlfl+BjM45QZJ+5QvDRTjbcul4w/r4kWGxf4MDGydsbCi53ipq8QYwH0Rx/zFU0qAWdoCXbs3IS7qE6Xqu/Pca7YieHiKUK6W0lp3T6fmkMpdyjs6TT9UePt0Iwu4uK4V+PkkHOmu94DOXHw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bZjovf2jU5/o1TG0R7HUnbTAInVI0XeIt+aeFFSA86aqmADcXmY9i7NutRY2NT9U100i+++3zniS1aGPAEmJiRzsuUYWngFB2gzK22SRMIGSPwQjYkGgbYPd5nd+g5DftqYABKo1Qx9hFgG9gaGtO1DDLhRgK4Li5JxNaoOk6baoaY7wFzug5MIej3FcbR1+mIvoDbaXfnLC+idLV+1Wl57pGBfZr/AKmyhR20quTsVHZEaCOVA97kIYN64C1O9shpuvwhDd6DyRqObDzS64LIpfETX0RsId3g2xQUeDsBNphUZjqsLqVtCz6o+YzeCLKPA26CJEfE5BPcLFWrw2CiIvfLehcxH5gif02o9CWEZ+l5XLATwK9ftqzw4GlgaJBKLgBzvkul+viBspkXcO1qIt6mB35dqJMTSDTaiDsdxkEafxy8Lk+xo4JDiTQDzNdptlOa6IlHIf2Dg2pgf78yROC7UrcMBp6KLMaEKveRzrOuN9/8mt6zXJHijtnofEsbW+tk+yDKgUMYksS/Xu+Fg8GtsHW6a/84cj/StzuZIUoUbHMZjTYjz/muQkr7OC7JHWPL8MUE+uktwYqcSxz8v5e6vntEJlodPDAPfuerPOU06mB9uU7GKut/AW0mQK
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6622.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0ce974-64b4-4fc1-6b99-08de8903e6b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 17:44:58.1451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o8I6SkHBDRrrFh0oaw5PtnKlg7tSTFA+wRxvZBoRIQGEo+6LBh6p7zrprfRJ5b8GVdiQskw1PXXfPiXxL0dLVfbUfzPJSqi1g3RhShQB1WE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9522
X-Authority-Analysis: v=2.4 cv=GIIF0+NK c=1 sm=1 tr=0 ts=69c17c1d cx=c_pps
 a=7uB9oqvJVKmA46VAnYT5EA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=NVi2nPTPkhjdRQwViucA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDEzMCBTYWx0ZWRfX5mUhrv/oMj6Q
 xyxQUgemGkUri83/2z/jxxgvPsNBjPTpn2wgc7PCGJ6Rjpc7U1mCKKhiaKpX46z7ecWyyZA/TnG
 oZv3e4uy8OirqaNDrsYfPUIAB67BKCt63FkFvjBK6sUmSpPlo9zNwiUIuYs8HyUYur3f2CQSYom
 /0zq93p2SmMzpUJu1ktRgPMg1Gpx52/igMUKWKlH7ClJtETv9OGBUxpTQS+LafCp8PByOOEOtWp
 lzPObMUcGtVXGqsWoV4j9FFkyTDxmmYBV8VsFjzC71NuxrsJFbnJnp+CiLZpwNlu0D3MOZJDAle
 sadT67IhboWBBummI6Usflk1XOwRqi8uL6JySvKKTGfOgKEUXu5i2o/VrFwbnRj1sLGh7fAZ02x
 iQduMU+LK+Deb6lpjqmZvVPtYIZn2evbWX+mVaXGXc+ngrQxa5IoQQ2fvYgJpa4qNDAss+sa/g8
 tMGvPyye++d5rmt7vJA==
X-Proofpoint-GUID: XBc-SHipux842bqsR2i7g1WYbX2Bi6N-
X-Proofpoint-ORIG-GUID: XBc-SHipux842bqsR2i7g1WYbX2Bi6N-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230130
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=saarnio@qti.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This option will (attempt to) modify the QEMU compile and link flags to=0A=
emit PDB symbol files rather than the standard (DWARF?) symbol output=0A=
from gcc/clang. Prerequisites for this are host_os =3D=3D Windows and=0A=
--enable-debug flag set.=0A=
=0A=
This enables using native Windows debug tools (Windbg/Visual Studio) for=0A=
debugging QEMU.=0A=
=0A=
Signed-off-by: Steve Aarnio <saarnio@qti.qualcomm.com>=0A=
---=0A=
 meson.build       | 5 +++++=0A=
 meson_options.txt | 2 ++=0A=
 2 files changed, 7 insertions(+)=0A=
=0A=
diff --git a/meson.build b/meson.build=0A=
index d7c4095b39..e6f17dd5f7 100644=0A=
--- a/meson.build=0A=
+++ b/meson.build=0A=
@@ -692,6 +692,11 @@ endif=0A=
=0A=
 qemu_common_flags +=3D hardening_flags=0A=
=0A=
+if host_os =3D=3D 'windows' and get_option('debug') and get_option('pdb')=
=0A=
+  qemu_common_flags +=3D cc.get_supported_arguments('-g','-gcodeview','-gc=
olumn-info','-fno-omit-frame-pointer')=0A=
+  qemu_ldflags +=3D cc.get_supported_link_arguments('-g','-Wl,--pdb=3D')=
=0A=
+endif=0A=
+=0A=
 # Collect warning flags we want to set, sorted alphabetically=0A=
 warn_flags =3D [=0A=
   # First enable interesting warnings=0A=
diff --git a/meson_options.txt b/meson_options.txt=0A=
index 31d5916cfc..bffbc7923d 100644=0A=
--- a/meson_options.txt=0A=
+++ b/meson_options.txt=0A=
@@ -372,6 +372,8 @@ option('debug_stack_usage', type: 'boolean', value: fal=
se,=0A=
        description: 'measure coroutine stack usage')=0A=
 option('qom_cast_debug', type: 'boolean', value: true,=0A=
        description: 'cast debugging support')=0A=
+option('pdb', type: 'boolean', value: false,=0A=
+       description: 'use pdb symbol format on Windows debug builds')=0A=
 option('slirp_smbd', type : 'feature', value : 'auto',=0A=
        description: 'use smbd (at path --smbd=3D*) in slirp networking')=
=0A=
=0A=
--=0A=
2.53.0=0A=

