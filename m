Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C943CC4452B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wloWS-000524-Iq; Mon, 20 Jul 2026 09:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloW6-0004n7-BC
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:58:46 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloW2-0006Z1-Kv
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:58:45 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDuNkN603929; Mon, 20 Jul 2026 06:58:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=LzcEiILVrbmsZkMUlQYjET4mH54ypEOEtl1+esP4K
 3I=; b=kZf2ukN3k1z/hayKQJ/yXDI6BBiKUJJF1cORUyGrAQINQXhP2bU/XmG61
 /lEnIwSRQqTjTU2o7RryOEdqT0szhvOTltdEw27Ty5MsAegFPbzxNtQyhEz5Dj88
 pAVIFDF24iYbGOZNa0vO7EDonexrPnwXxMAiz/07fv9Gy+se5lUyBmrMQ/qE3+on
 ePgWQy8FDwPOc5Km7o3AXBgOjlME3WMEcQWp1+rZkGS3O/CSwMZxs5xjP23tYVaF
 uZkrCCF/PHc3jAd68qV7v00cUyKtyK66D7ujH1bCWKvGmEVM2XWKxQVoSDNbE5dM
 4oXelGwrtKDD4CmZhBHI2WUQGh8rA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020082.outbound.protection.outlook.com [52.101.201.82])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg91uudqm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 06:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8FmvymtfwCg9/o3QTO1GZuXfa925qD5WFBbS3q5PIKiKGjNF1zhymV2Jr+J28Qd4dBWXO+JavkHGp/cyrUg6bi0tSST8R737UZjg28N/VbzsCnAA2BAoJTe5jzI6u2+PbofP12uU4h+lAH96lzO2F0ygNLq1yAmMHITpNNVvixUr7qeFAmVCsBI1cvu8WkOBvZNmdH0nGBKt0a8MpdYDgxIolQ8yg5QfXDxpa8fkYOa1J1JWwFjZpZNcl3bFQIVB1rvc2CKWMh8P61baecmfGeEOffY6YmZAkdlaW7ohvi5S9RvouXkMj3g7bgDM9MHkPnSqjkzOYGXDiFP7irdOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzcEiILVrbmsZkMUlQYjET4mH54ypEOEtl1+esP4K3I=;
 b=Lwqm52yivzmGAqRrlhOcpNR0stjVOD6uI5KUAGGh8z/Yj5VGR1R8hBWHQ5buOXB/osyE5lFGjxQDr+0CajshTey3W3iy8i8HQj/taT5ySV4hDyDAU/bssuZ/YMlbWhjyBt9mqZdOEsEnFA4JVbtDoYjAsVXeeRYLglcg6sgZdOmBvGSOyPBTbBM2cFmGU26Hx8NIFn4T2NRV0TlihNhQNEhCX718DK28ak4rkmBlXyBIP5XOcKUPD2eR6zTIJpjf6fdIyvkGyYjoOrwEaBl3FCkGA/MsMmLp6U9+5T4vZ0Jzo299y0rcSjYEQUSJETTNvYaBaWrDQ2RFAMQm3BsfZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzcEiILVrbmsZkMUlQYjET4mH54ypEOEtl1+esP4K3I=;
 b=NyTLPGjMFv6HifZ1Jcm9z80yPzx2LRil3bUGHgjy4fKBRy7AJhl3Mk0Bjoo2ycPvcRBJM/tvh62jFUllKJIqlzXwvq4c4PP2+Zr6fOGdfedfHZE4p1CVfrw5Iy8JYCq4RWIBm4rxz3M2J/3OxPI9QWNSolhuZjQG2uOJZHkafRmDWWGKYowuXfTLyGEKFxas+X7+QHBhMCw8Ul143+MHWDSg6dO5bzpxYY3Nhxzv3K9QOOSOYUoCOqZ0zqHVSxjpk8t4RPbE8kAj32elFBbbKWt7yySnuBUlOyXmsDCfFsOp7Va5goPk3IXBCds0uPWK4OMOY+gf1lh0XGp4kfydjQ==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by PH7PR02MB8883.namprd02.prod.outlook.com (2603:10b6:510:1fd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:58:38 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:58:38 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v2 1/6] vfio-user: vfio_user_get_region_info: prevent buffer
 overflow
Thread-Topic: [PATCH v2 1/6] vfio-user: vfio_user_get_region_info: prevent
 buffer overflow
Thread-Index: AQHdGE/dc0LS0ijbPUWcjqNXc0gU8Q==
Date: Mon, 20 Jul 2026 13:58:38 +0000
Message-ID: <20260720135823.21070-2-thanos.makatos@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260720135823.21070-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|PH7PR02MB8883:EE_
x-ms-office365-filtering-correlation-id: 75a9b6fb-f623-40ab-6a6b-08dee666ffc0
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: tiPG5duhKSQwcag1tRP5Jrby4XcmkUFQ28kLtzHSrQYjcG6c9SVboPN0iLVTLrvhppaddO3pdWmbaIkFoE9NMMxf3gWNwk3x1pPaDmRD4yeGDINNsTH5E84sopaMCHGzLdiIa1WWFhsuatDFLSY3ZzusC+XSpIiZVvtOtVBkDFK2y2M3OL4m9UIm+Dg+J+fYLi6pDh5xOdgLP8iHpY2FbkewcxZBmHzmemKIsgyp4ltbv9vbd1i19ZxpTmEDftd1u0NopxpsjRoHysf8oS7vVLxSKo9uH0WwkLUsnNdhdxmepD9+bTpp2LsyAgdMBDEL0Jjcpp1ZJelrH/fvGBe4qdKlT24SmY2cWDY0OKH9HbyXhpmnBbSPfhrRm0OegF2IHbU2nTmd8nCRxhMf24uM4Bc5onrLr+j22GpBF+/ux4A9wCC4OMoemfyWNtfReMDt0vhoIvm7tPfdSvG0p4CIRkAkzdyN0D8xLHkpKVmBzAN3T6UP3UxrL8i3SjNuC2dIPB0Pm/vhKJ9hYB4zdli22QRdZjOE3lDgFh8qpTIiUijdoaKYHNvtzoxeZYWKCNkrD3ZqDoqO9+4l96JS+lDxuwrsV1dUHopuhB/Rj28s2EZINwmqiPgdHQPBMJU/e5Zw45vR0Viuxt/Xzly5LY3Ec+P80b5X2m0ZS0W/JmRPd4L/WJKQt0N5Q9WmzrPcY+6XjPBOQcxRK/RCh7ywNZrGXhgBr0DuYTWBcCeneiLq6/c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6ZM4nvWZGW6hZ3O8ZXys4SS/DOjsNIhOnpyqfgWo0Le0APNO+qzZxFaObc?=
 =?iso-8859-1?Q?1LpbLKXUFOrXTHF8p2Ieq7R+FEdIb2aV3vKSjfa9WBpyHkbxLPBoS3Cas1?=
 =?iso-8859-1?Q?OJmYngipP0uMqPkgy9Bo/QnRdQ3v2nPsZeSjv+JBEjsmlhxsXkUsGeVFxJ?=
 =?iso-8859-1?Q?Lu5xBUCQXKKiH7VnEFJlRkgubEAEJWEXd5kL4vlYDDyg7psSMLW16A09PJ?=
 =?iso-8859-1?Q?tu9EdacmHkSFjwYcvwvQr6puSQiSSDbKgm2poiAhPST7BcUItEPSPllr/F?=
 =?iso-8859-1?Q?Vc4ZGKZ2qwQoWz+Jf6AbVFTR8Eo0PcNHOuGQY9GtuQPcqDBrOZfvbjPIMS?=
 =?iso-8859-1?Q?B9iZFm0oGv0Z1Mt1o+P0T7p+5Jwt1XrZUEMFlQeqsUh2M5S4s93yAeFzne?=
 =?iso-8859-1?Q?6AoPpMmcADg24K/cqa3jbjGtsKFY6W9B375BJGDnkBWjECw7OH5vKqu51i?=
 =?iso-8859-1?Q?PncV7JlSYCS427ZsNOlJvBnQndA45zYidygC/DD6y0IOZODSOB/PFatFK6?=
 =?iso-8859-1?Q?DKFjUdda8wHLOJylTCqrdbVKgLo579Nup0QHzZHF5wh16t7WQR3hb5lEDT?=
 =?iso-8859-1?Q?xHQbEfofjKbePSG40d+zTjotODziLYoK2pVjKxfOk4NtR8lfyq8eNcHq1w?=
 =?iso-8859-1?Q?qE70vPf3Wcq566ZUiLmNZFLx79kzt+RtBeVNbBEqTVaJN0gKKsgePu95wv?=
 =?iso-8859-1?Q?5+Oj2NB8tA3VI+nmD/pjzREaUiQuf5QF424xDMY680i38ofeXZBUtClaD4?=
 =?iso-8859-1?Q?/JWWpuWvE/wmK/SUta7mlEGt2NfbIiaYk26fp0lP5QrnehWgxCNh02Tqc7?=
 =?iso-8859-1?Q?XCbSiuZKd5iDJTp5UXWYB3EbUe8AN8k5uDca3JdO1oYWQc0HV3LFBtI2Za?=
 =?iso-8859-1?Q?hSRQV6sWDMPmxWrsxLKZMEgz7M0KADiq2/nznTlv97fam0DfF9GzlppfYS?=
 =?iso-8859-1?Q?QtIK946m8tffnDQoHsuEWqD5sIqe30eAEaxyIuiKu+R4bx1NYvFOpFqxE/?=
 =?iso-8859-1?Q?fUUpe2SdgUmLPM4WLlTS+x4kBppneTOSGC0K3rYnkY8Y7/Cl8l9Q5yPShR?=
 =?iso-8859-1?Q?N4/73pezwLFcwLtHQw0Z/728L847zX3ZepkjvszdIsqhcGY1aG9J2PKbo3?=
 =?iso-8859-1?Q?NnvvaYNWSj0f8omvrBDlLHq9bZnUcfpPVxETMqiX7YwqaFFCqz3EFCPyCl?=
 =?iso-8859-1?Q?TVdeVGXyYgdMkd+Q1ItSPGr0F/fe9rdal9Gh66V95mZIH9st45fpLy/55F?=
 =?iso-8859-1?Q?CP4TGl4+7tt9tnUrboEAQ6KCFQSGGT1BKTgo/80wAQ9L2JkiDkn5lqTWL1?=
 =?iso-8859-1?Q?glbxi00pK+IpLdFm1pvmzELaioK//i07qXYBNVJd+eXgCYKYFuCmklAjYS?=
 =?iso-8859-1?Q?+MYyza2F3oBpsFQwxh9Z8wuQtontPfDatUfL9DaP8vQgyqoVF5Id3y8/sE?=
 =?iso-8859-1?Q?in83lPMc76irrxck1pqaGe/Pk9iBUULsgAooxSjqvblOabatGVjERuIjzq?=
 =?iso-8859-1?Q?w8VEWg8Chi98zoCpeWRKcWVKAmOJL3TEZdPr4LKVRMNIDitCHeCSZjL7Ui?=
 =?iso-8859-1?Q?0FT2GVI8cH7xgZGbBJ8xjPYSqMgpWR99p02FJITdV2LAfgtcTqlLuCr+h3?=
 =?iso-8859-1?Q?S2sYMFKPmG9rn7GbN8zi7/PJSvsDIMWOZMjOnlGr/i5CtFA30AU1SGTOGY?=
 =?iso-8859-1?Q?fadVFRA6XZWByR66N6T/yZroXg/CFdcW+wcjVYgnl5MePzZu5iWk6vyIMq?=
 =?iso-8859-1?Q?u1JAdaNuQZErNUArcmpvSQtEHlx/TudmJPZEILwVMSAZC/12ZW22wDPona?=
 =?iso-8859-1?Q?xnTGt603a4Zyc5UQlCY574sUN4Ek0ko=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: m57G1EMvH4j7jDRO39ZjLIxewk/3Ol/zkoP0QimyVhm5qm/9Gr/sy3aO0t/YPRCrOszcZHBJdj2xtOtsNvL+jH21dzOalHnhorskK5S6Bs0v/b8td1yXB6x+g/InXrRLe2tpLr0A+/3fIwo9oDpN/5aIy1rkxO/2yCqNIjR4tbzTe7BFmbaih3fS3qOg2M6XSg6YAIFH53VDcToCgybzHpIVrF8w4+xGm13vLnBqRa14Z3Zr7uO/uWDoLmZXkknFQGoAdXTMs8gfK2le+nz33p96/n4EWhiy09qFm+eV1MYECLVcfvqArUznA8MPL1E7qYgDTChfnB85L4ms95ZLmw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a9b6fb-f623-40ab-6a6b-08dee666ffc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 13:58:38.4414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBG+0ZclopvMOS+G24ijUMQvs1KoNM4/s2tM7ja8Lx5XWtQv8sNSyZeEuZRjSajwq8xFTskxqVFF1RRC8vUABxqS35AUhwuTB4rErWTBpZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8883
X-Proofpoint-GUID: rM3AWohgIhVXTPer2FNKQ3ZgVdsctnQF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1NCBTYWx0ZWRfXxQOykznGigLw
 mKQNF7ZLopJ/WtPPH4EnTM2v0Szg/mzLpfvfWLV8swon+HiQCVKW+JzsOOUt9EY6KsAa8ILtLii
 7fWU6w0LsWsm5Gj0aj7vWk44y+Ae3N0=
X-Proofpoint-ORIG-GUID: rM3AWohgIhVXTPer2FNKQ3ZgVdsctnQF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1NCBTYWx0ZWRfX2nww0q2+DbXP
 fSSCsxUqWVN74Hz6cVZ6p2+7bui4j1q50/f/GT1g+N+JAMDy5zlynG2C33Q+0wwlPYxEzNWXOIm
 pzA60/6lq7zuQq//IJDVnuHmV/3ALewAz5ZenSsCEFaXMlzkewz775lnxoGvyXyHORzXSx1HfZJ
 OXJENIITwi/kj6QGCW5VMjpjU+ydlLw7QZCh9Rv68FCBoM0JsrfHcalOhQIZqYxB1T5fE3E6B4Q
 NIkpeFRbyND8awxf1u4k2dqWbUj1hcvnLLXXqZ7jegb4jBKSX1PNoARK4IV8eWLif+6m6NycJaY
 v+Xd3wSDdPRfpr5Ig7tPvI9JWdKQ/2wjEUAv/CJugSnSRfhj72AX3O0o+wtK7OoeIy4ug/x1OL0
 XjkRwJFiCvs+OTS1DzcV5K9WJr0uuX0Z2DShKJnLR+Mn+qR+WQrGblfsU/yK/WRKAbJAix2TqYT
 6jk6y1p5YzC6EwR/i3g==
X-Authority-Analysis: v=2.4 cv=T4a8ifKQ c=1 sm=1 tr=0 ts=6a5e2990 cx=c_pps
 a=UUrofF6GnltCzEOzQKub5w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22 a=p0WdMEafAAAA:8
 a=64Cc0HZtAAAA:8 a=RAxQ1p1dZfU1kADbkrQA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
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
=0A=
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3867=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 11 ++++++++++-=0A=
 1 file changed, 10 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index b8d2b7c1a8..e58167a818 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -128,12 +128,21 @@ static int vfio_user_get_region_info(VFIOUserProxy *p=
roxy,=0A=
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
     }=0A=
 =0A=
-    size =3D info->argsz + sizeof(VFIOUserHdr);=0A=
     msgp =3D g_malloc0(size);=0A=
 =0A=
     vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_GET_REGION_INFO,=0A=
-- =0A=
2.34.1=0A=
=0A=

