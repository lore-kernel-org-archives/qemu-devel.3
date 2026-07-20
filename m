Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9193BC4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlk7z-0002s9-F7; Mon, 20 Jul 2026 05:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wlk7w-0002rd-3c
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:17:32 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wlk7t-0007NP-UL
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:17:31 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6SVH63828896; Mon, 20 Jul 2026 02:17:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=79NcBIAvbglnhdB7Igq0lGRbdOWcTtjTIUXC0/yWH
 Fs=; b=K9IzYQyqd9/pqwDN6L2yqAhhN/j5gFT/rEWke4XKVTm9ljtL9TXM2Q+CG
 dDjQtAefDLcmqDI0EfX0fQfmZXpw6B3K2hkmRImZvX7YEttNnJ5G5pWDMfVjAbN6
 9QoxUFD8adc5KgXMCp4nxPi4UGyrp5EUKtiyC/t03yRfsNUFHKzOQUAiTOwgEUKL
 gnhbWJSVxPkeebnW90Vz+6BEKYQMSgLgOyQv4Xqe7eO/x5rF99/y/rd5vTuZ3nWj
 t2DOws3n9TwxseDSGVIHpQidN3PAZy97O6OgcrzyDDu7NX7qm+56JHbyZEEBy6oI
 CR9Yd3VJZxrmuH37EslZKczsJGBcQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022102.outbound.protection.outlook.com
 [40.93.195.102])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8bdtsw6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 02:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+vL5GD3cQ1/M/VuZ991g7rMw2bR2MP42Zd7JKqg8TmcgqA7JUksoFmamHIXdvyx0uHjfFyK+yqLtVR7buoukd/uIm9NlO34pDMRyYpj+0cP0GPcYV09z59M9Eak/wI+0bbQ4tVQj7lwci9hszXeVuk0pTXC/30/oKCouO9b9I8WnCaSabOcLsPeoogREZk1zbbiIy9DwLORfz1yGZdXydduDJqvTyePDGiyMmyNY6Z5PPUZRmxCR1yJZ3OoQiVJFAXSX5H15/JDSIki5ZyGQ5inZJ82+y1VKjxc9oamwviGrEVQyK1RxH/DhshOusBAOoAsQ3jNOSampUHhIE47dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79NcBIAvbglnhdB7Igq0lGRbdOWcTtjTIUXC0/yWHFs=;
 b=mNvcixnjxQ/gMc+IRjyG6KTADtE5Xo5GQISbv/9MQF59iiOxSn8NVIDaeLxyOuEyLxcUtpp9ZjUwPAJ7j7yAUILB+tlHiRv0H13/cifA4L0y1yfmB0fuksEU/MEXsPpW4wgjCcY+LvVd6Oe83zIO6LCJ7jJ196LTqbflSkTiqxTztsom/jNGPYWE7Q1Uwnc/G96TvOUkLdyL2CVvrWAoxjbSSNx61O7uT03dMp92d4j2b9S3IC+MCXAfzCuQHlImIHAnrnIq9RnLbOTEQhayel9K5CylHZJknLF6+ndbrSFwjLSkTfI/RXmpz6AtHTq7gHwpvpG6vkGmEUnIeSyhOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79NcBIAvbglnhdB7Igq0lGRbdOWcTtjTIUXC0/yWHFs=;
 b=fst/iAjrn95WCSby/40hWmHxc7moE4JlOlLawRt2Jm2diE7DrkwhSwAVYe/eN5yaJNOqNiLH+AEXMSXqqXnOWzDJfC2e1Owh+D/AxsMVFg5M55yXahrtx7eoYU3lk3xr8RFc4QdJzLUhPHQpzYbVMxuPYljm5ZHTBViCZZ0O0p+KtcZHQ1SFPanChG6PruyYnyHAKqHDjGtGksBRNxB6jnVVjRJ4exoqcU3l6bBarWB0B7tj0ef4H4cIi9PRk0lH0PUatHosThVdzOHHIW0+8C+JHS+lLvEDmaODV6fOXBSrRH6HiVSzLBbmjQ2wOIIbwoYLFfe33J6/MRCdh5JMeg==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by CH3PR02MB9860.namprd02.prod.outlook.com (2603:10b6:610:17a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Mon, 20 Jul
 2026 09:17:25 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 09:17:25 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH 1/5] vfio-user: vfio_user_get_region_info: prevent buffer
 overflow
Thread-Topic: [PATCH 1/5] vfio-user: vfio_user_get_region_info: prevent buffer
 overflow
Thread-Index: AQHdGCiUeQzpPGhc9U+w6z3aHy5MpQ==
Date: Mon, 20 Jul 2026 09:17:25 +0000
Message-ID: <20260720091718.2642-2-thanos.makatos@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260720091718.2642-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|CH3PR02MB9860:EE_
x-ms-office365-filtering-correlation-id: d475f0eb-66dd-4f71-1364-08dee63fb6c8
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: s9jBAlKbo6a4GG0fMmw0fajb+KH2fSSOIs0+X937BDy8WXOAgrmJnB+tSBtgSNvtXQHCtFTaS5TiTk5xcrMpFi1MUiwK1ZB49Wa3LzJwvfA1/9iQ6rz6oZF86u/2/Zs4t9XdUK/r1aWFGjTWqQM1DukukmOO5oCI2TL749QfcUHZQlKh8gFE/2E6oUodImZfONdt+cPOSbnWPuSxaZnHS9dtsK+3Wej2WW2zUa3OGUv8k1euYqANv+axhuT++jjQ/9Pz3rrqXy/AalQ6BVt9Eq7PqncZtLfnsUllYHADJ4LhNeq+5rrFQ8UHdTysVUl+xIMMlImnacutfXEwHX7kd12AQvkKSJkNFjO4ml11C6Br+zElQIgaK25/Y9PHZ6XxlW4gx0GW6ieV2bMidSGMB+vh3sMSFOw/A0e4eqWeU8NWjky0KJ3JOVITyzWUe2OxRj8IV0AEHZCkeElSJSqZbqjTWb5pPk4OBhLjKcVKvc0kwWsrQySDuS5dhGGBqRawAWS2ak1NzFx3ZL+SDqIt7XEjCXm2tfNatRANMj/NovEvWipaenBb8c7lW0c/mUZ4f6RnlOyvjGNjUSnXLCAk7OnsP7AEVSFyLzHbDlBZOuRxauHBzIZ9x8kmd3EEtlEi/P30QHKnJmslawYVUEForNZHoS4G6X+mPgYhrXay7p8616v1yuyb8AOUAtqnBdP0JPBtWZRI2z2GjUKiny0IlGOvpqwJ3MxFkKIN0IMsNmM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CPGs9ITNXBiZlrnvLPGbQOzzN+3UoPU1j94FTpgazEGfsUllAxTXAF4iHL?=
 =?iso-8859-1?Q?hBy8y2U1/oJRAuo47urVoZQ0pvi0sbSDkeKl/e+xqob7RWoMOjbGDqkztA?=
 =?iso-8859-1?Q?Jge9qaCJbn6MvF9o2U2yXNNCzDHsL41llhmvo9Sc/1u6v6ENDch71iGJV2?=
 =?iso-8859-1?Q?gBALoaqUv7NZPa+3oRbFMkzKV36/OeMaI6KKWhVSHp04Ju1Pj0S4j0ak7/?=
 =?iso-8859-1?Q?Nv2288D0jnldbvmlgrDeCEW3k9q25LW7nbaKIbjESpvb/U6hdX7DYzeoUw?=
 =?iso-8859-1?Q?zHoyBRf7D0HtY5hyv40JpSFWpmtE8TUXPhlOB/YOFWPbnL7yhvqyQhQ4ao?=
 =?iso-8859-1?Q?P7lIB48/XtX5WxxMzIxQUESij9eawOqd3R8BM23+acB/I+KhHJn0IdBvWU?=
 =?iso-8859-1?Q?wBvHzwCz9Rgvir3kfrPOwc0wAQ1Iws5Y+1NCniAk++CVu2WwYZBe+K6Gg6?=
 =?iso-8859-1?Q?Cz2KLH+ngUCJTNI21bI/OHLlg7oFJKp4ynleeEqG59suP7vLUMD3kpBGIu?=
 =?iso-8859-1?Q?niK0rinQfTb0X+jdMuCI3qdXDiQGcVtzQRPmyTSZ7A/y64NRx1D0fSp93I?=
 =?iso-8859-1?Q?oDVwrSZorCaMuPTbOST6mVsKqB7gwY4+7/F6OCxu7vSlN9onEW1xcWX3tT?=
 =?iso-8859-1?Q?JX5aq3VI3NYpAnXD/5lGkSmV215XkWsDnWxqcTdvg9RzlqVHPkVcOiWH7H?=
 =?iso-8859-1?Q?fuuhzPOoyDJzpcQAaxtB9xFWo96fdWoVSBtcs/IqDCnchE+q1BUYssGORX?=
 =?iso-8859-1?Q?Z2yK6pM9EXp0OIfs9rXfHhA1P7lL9A++fl0nqkYWWIWfKSQA/0iM82GQlf?=
 =?iso-8859-1?Q?Nf1MIE2i2Vs5l/XEAc2bgpFbyolGH0mDJPSJS6CKJx5uyX3x+QL0tBQNuY?=
 =?iso-8859-1?Q?3+OoVB3/SQPbzgj557ztNP7fTZWvXa9e51eL30CWo7L6C8YYm21I85q0FY?=
 =?iso-8859-1?Q?l79he0FXuMb+bzxScnSWBluuhtnU9Wj16dCxVIXu+FW/WjmlpMeddy3RHN?=
 =?iso-8859-1?Q?ZYQNakLUSaOCqLYCQHbNdC2ds34qCBBfhSAnhawVMc8wQXw0X7GYEUlzRe?=
 =?iso-8859-1?Q?wqVVmbBq3bsJPNoCh3n2sX0/t3JO/tpsLcunU670CKUhSPlrUFNdiArYEB?=
 =?iso-8859-1?Q?bOJf6/1GRk7UFzzaQP39zy7t+khMlmAtiArHunaLh39uexYmbUP6uAIUVY?=
 =?iso-8859-1?Q?7U343F5L85qIhn7AVQRtFT5Wcpt2NOhuvAVhJoIpX+NRx+2dgMMdRtlYGB?=
 =?iso-8859-1?Q?pGXSAWmlsLEzUjzDXdxIu04Z28ptn/VS+F6SLluYk/jP2j1OhPyr0GZRgJ?=
 =?iso-8859-1?Q?RaAjr6bcSDz5+gNtRSfFXpEbGGfwiI2dgiYKb1DQR97XXPFVBypxevGaAQ?=
 =?iso-8859-1?Q?9kVJaEE+IDASYd2RMMUT1hHlGHJ4VbxZ9jlXOcx2dQs4cB0d/f3TyUdRa4?=
 =?iso-8859-1?Q?dqjCfEZjI6fPee+ReUyfA/5U+GyRAUkf/QeZMDqiKDWL8pmaXwj0eWN7nn?=
 =?iso-8859-1?Q?3grHjJZbYVeRcBMyzn39cdmsAoPawmSDQ/h4u4FGrWTeIlqFnB0aJvZKHg?=
 =?iso-8859-1?Q?Nf16RA5WJtUJOQejCFObq7D5QdkHdm7lmkc4r/Ox+ir8K+wdSNzpvFHmQN?=
 =?iso-8859-1?Q?qIs94jwVo82UDz3XhbFr13ZFC6Y46/0kJeBuanxPqmfo9Zl/Su4kMUF/kO?=
 =?iso-8859-1?Q?9438wl3+8z4ky148ZAbsiJbx0l8Gq2FO/gPiB/nbYu7Zf3xsZk/NP9EOvM?=
 =?iso-8859-1?Q?tXFWAlkos/DrAUb2MN9eBg6oeLnGroF30O/OpJOwnHrcTyPgQNyxlJEKcE?=
 =?iso-8859-1?Q?E0nBJEfqRbT7X+w6eLsqUYsHzV/BIQM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SUJFainNogr8TY+TU99RzgSTPIUAN/ACtb9dUrD20OjeYbhVR9jPdvHEFqrElV9qdioo0TcHnjLVTaUr/jctNh4SGAuckmGzs9T0+qPM8TsPqgiTvKE+80LtKjCKUPpKQD5VWplccxUC7fP2jsqjGRpFy01/FpG9s5I96qPKL80ZPj4mecUJJ+wAVHT3Y/ImOZ/IQP8ysvODrOHKxnNTJp3ZaoIBvLMHUlONApckb81X4xxta6idGe0uoTA8SEJO3IIkGtSnBELKez0rf+kGmA6Z2XItMOF7qoSa9jAGzE8UWB7KnGYDIz/HP3Mwul0HHM2u4BiNG2SqpGwM0zcvVQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d475f0eb-66dd-4f71-1364-08dee63fb6c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 09:17:25.6969 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NV8QGS63JdctSm3eQtOKS+i5np1N60kqvdu7kImiZzACPck6sL/n81gv3ZYEd+g4mi05kh+rJMwATRJ7eDGaQ+89DEHtpp/sOi8YLpVGxlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9860
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfX4aBqCJMA0GjR
 3nArYCNBe1vrcjzFbWKmSJ1KJ/vHPcZLZOeSs5I6DFSzydssLGYRCseb53x5FYVbsY7+Skm7loA
 FwQuz8fsCqjw1NzuEfJIxOVTZemfgWD4rBEny7MFOmkkwVrbOM7PwLiy7v0ngvh0RiCwmdllUwe
 jziNeEF4dckDNVbI6kVsrFe2GEZRQZXJTHz42zT5n28MPE7CSjEC9u44JAU5bi0p2p7wqsyjUfK
 rCsGZXdaVoIZGg1l6G7JC/EXPAbXg5AgK8ZFszgf9MLLDPLQY6IhIVDvnq1HbukTsZ5lHFCYZXp
 JAkHIepM6afhgE3H9rhi+pcaFhL5+2f4sGoiaDxOyrC6tZfrDKv1PAcLqb2qUB67lw4O2kIw2CL
 Ycjl6SRfqWXzw0P8E+Okld3L906QSchLJczGB3lkPD+MGFD5Y/NL0MYDf3Z9u06BHNofr4AzDNt
 0fyRGWsIFcBIpcW9jHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfX2iRxj0Ki16Sy
 jMhmqzEhBvD1VK2Y8WGZ3KSAI8520H7etXI+UBXMU9+Td4WO+2mowz5qQPmwGPsILUiRDBO1X5O
 XYGzRw+wVgt+JJA5bY8uuapNEk/dROI=
X-Authority-Analysis: v=2.4 cv=TdamcxQh c=1 sm=1 tr=0 ts=6a5de7a7 cx=c_pps
 a=wVfAXNSrx9oslCtdZ7LgKA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22 a=OO7PBntrVmndeWE3w6kA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: 2sXIBnz4DgVsIhf44Vz45x7z0BrjDGyu
X-Proofpoint-GUID: 2sXIBnz4DgVsIhf44Vz45x7z0BrjDGyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

If the vfio-user responds with a value large enough such that adding=0A=
the header size to it overflows, a smaller buffer would be=0A=
inadvertently allocated, leading to buffer overflow.=0A=
---=0A=
 hw/vfio-user/device.c | 10 ++++++++++=0A=
 1 file changed, 10 insertions(+)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index b8d2b7c1a8..19a42c2a25 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -128,6 +128,16 @@ static int vfio_user_get_region_info(VFIOUserProxy *pr=
oxy,=0A=
         error_printf("vfio_user_get_region_info argsz too small\n");=0A=
         return -E2BIG;=0A=
     }=0A=
+=0A=
+    /*=0A=
+     * Ensure that size doesn't overflow, otherwise we'll allocate a much=
=0A=
+     * smaller buffer than we need.=0A=
+     */=0A=
+    if (__builtin_add_overflow(info->argsz, sizeof(VFIOUserHdr), &size)) {=
=0A=
+        error_printf("vfio_user_get_region_info argsz too large\n");=0A=
+        return -E2BIG;=0A=
+    }=0A=
+=0A=
     if (fds !=3D NULL && fds->send_fds !=3D 0) {=0A=
         error_printf("vfio_user_get_region_info can't send FDs\n");=0A=
         return -EINVAL;=0A=
-- =0A=
2.34.1=0A=
=0A=

