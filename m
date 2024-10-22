Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319F7D2C543
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 12:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Dml-0005sJ-3p; Tue, 22 Oct 2024 08:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <DaniSzebenyi@ibm.com>)
 id 1t3Dmj-0005s6-7F; Tue, 22 Oct 2024 08:14:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <DaniSzebenyi@ibm.com>)
 id 1t3Dmg-0006gf-Q2; Tue, 22 Oct 2024 08:14:48 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M2HkQP023799;
 Tue, 22 Oct 2024 12:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:message-id:mime-version:subject:to; s=
 pp1; bh=/yhUphKiPfnqAsPyFWjI1+2B1NepIEIRrJ6lv4wNcS8=; b=GsL8qxfW
 MUwtI1xrETk+MNioQtKQfYWoJBLyZjISvOF0irFD5GpTXWDqYiLKOb8LYSQql1DV
 2pyIeBdqjS/TRsKQxK1rx776XAI6BJq0GB2shNgCmRgSA8b2DahH8U/D4DNEEVXP
 H2WKSlpC00+9NK8KcRyixkOHdHFEvrKiVcpoPDMiMwzHyFSchzOV5AAB0+iRToPx
 XLn5DAjRCP2oKzEmDHl8kDUEFM2HgmpoPSrZ2zbN9aVesIpRajlVN4amfFZ7y+6D
 2d+/OW5JflWNJy6pzbjvXescV0dxFkkOtyAQQpibHfjmgCM1bwvUd3DUPJMY1PP0
 wcMa1P5gypSjAQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5h36dtw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Oct 2024 12:14:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siaq0m1g2eMbH0DLccHY42G5mF0DxBqQAh0CB8LbrcdDIDx4N4BEds9DHSzbYj87ruHjZi2Bcpoy3/ZMS33ipk4AiCF0yypXscqoDbaokNfPuP3gQvsqINyJIEPPNN4XxDhyJrkcvRQq90xfc2TZ++uMF8z0HRdpWBMx3sdGAE2erjcDPrd0JBYGe+z0cwFn0oXHLqZmzPnP1XlTkr07CLWUPR+kxbbgZ8fpodCG4ZVXwN/QsxIFW/WNdt1RukmsatuEdEXb1DN0y2MP6exs3ljnxG0TTkC8T5de/A22bxaO133F/F5jnSQXvpXGUtcwCSrJshU9DBWfrETRXHijOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yhUphKiPfnqAsPyFWjI1+2B1NepIEIRrJ6lv4wNcS8=;
 b=HsroY/TyJl67qZL2cNPyrboSVSujnIkn6cZ6B+3OohfpnfvAQJ0tlQTNiQhT5j50UzEQouF19xTiCssM6XYr7j2urct0HrxQigHYP+1VVFqWGpwTuBepAuf42K0eCVZjWCATnzQ+JnUwqJobP/6iiEqgaL6PXFArdCVgyC+BeSwjdY/xLhPT3lvKRHiOvO2eabdpzFIrvGG5Ogf2irHZE73CWb5fw+vXVZP/qhgyk9vrHpZARbdHlWI+YHnoO8L+WGE/YZgbLb4h7FPpl0tTOeplFIDBLlsC8Lj8/Dgmn0xyvnEjMO5gxhmtPj8wd1LfoUdiX89sFz0XciQKBEN3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SJ2PR15MB6422.namprd15.prod.outlook.com (2603:10b6:a03:576::19)
 by SJ0PR15MB5178.namprd15.prod.outlook.com (2603:10b6:a03:426::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 12:14:38 +0000
Received: from SJ2PR15MB6422.namprd15.prod.outlook.com
 ([fe80::de53:8989:99de:31ef]) by SJ2PR15MB6422.namprd15.prod.outlook.com
 ([fe80::de53:8989:99de:31ef%3]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 12:14:38 +0000
From: Dani Szebenyi <DaniSzebenyi@ibm.com>
To: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>
CC: Dani Szebenyi <DaniSzebenyi@ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] tcg/ppc/tcg-target.c.inc: Fix tcg_out_rlw_rc
Thread-Topic: [PATCH] tcg/ppc/tcg-target.c.inc: Fix tcg_out_rlw_rc
Thread-Index: AQHbJHrSPodw8Xc/i0etSWI1teFSeA==
Date: Tue, 22 Oct 2024 12:14:38 +0000
Message-ID: <SJ2PR15MB642247C424ED44DB51FEA6FBC44C2@SJ2PR15MB6422.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB6422:EE_|SJ0PR15MB5178:EE_
x-ms-office365-filtering-correlation-id: 3064bb1b-0246-4041-ef25-08dcf29319b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?l/OrlFt8mznQ6mGvatk7ZoXu1UKSOwg1ctnPWELYDa9vwd9IM5V3ow48wp?=
 =?iso-8859-1?Q?HIyO5CzTc7E0SMO0WqbstVqhYka9RZRZt23XVGIQq/i7hDZ0BTMT9uAMVI?=
 =?iso-8859-1?Q?2BG9/XJp1bpkpHNrX1OxWuuIWjViJOOuRcgGEeF2R5lKu9VKnr8xauTNTR?=
 =?iso-8859-1?Q?CkQ/J9YgG046L+HjplBbA0CSUNARFBKF3+M6zHXnqQkeG6wIeeiQX27ED5?=
 =?iso-8859-1?Q?Ay6ElDrrN3IOPcPRFcnETo2u38k555+wtpWwEerjUkERU0mXV/S22km6Lv?=
 =?iso-8859-1?Q?SArZe56mgmteS2ZMxXtdN420hudLQCTmINc5DSfR6PuQETxhG9jin+gizS?=
 =?iso-8859-1?Q?y+huKFal2pL3HuITajsu/XSrjcFupuLrSlVppt6kLFGFmzhDYzWPEvwzem?=
 =?iso-8859-1?Q?WXfs/xyvqF2LgdOxXO4gilN5bARL5Nkz+3TE9TKiBEyGKvGuW/eeMnkFh2?=
 =?iso-8859-1?Q?dQ/xn2TErU1OTgROCQMUlgNaG9qUDvpbONvBOeUZ9Rb23bHSgf38dlCLA1?=
 =?iso-8859-1?Q?Mpw8xT8cKrc8X7XEQLSuCCrlv2VCHYHAEdQ2Gx7ObtOhnndQHs/shbJ4NW?=
 =?iso-8859-1?Q?/HGgxgVZwH1foSobq4/Z9CDslI6X9rYZBDpWvjQTVrbtKldsnDl8+EvXAb?=
 =?iso-8859-1?Q?GRA3ug3VMTSu83Hy5eYGZz9ecBiQMuVBuCfO1d9fJ9Y8guJV5Hkb1BVXpw?=
 =?iso-8859-1?Q?TJt1wrclsUh69y+nb67Qs0Eiv+iDzdNodgGKRUK99WArt+LEnyVRWONpAt?=
 =?iso-8859-1?Q?ejQlz7oZwiJ3cVANj0mh//GNaHI2mF/XJlGtInutsx86mwdA3WX8GZlbws?=
 =?iso-8859-1?Q?oTPiDOPL5HEcZI2NrmjYClrLk+pwnCPJgT2ky82e0POCs22UEm8K8yZOdk?=
 =?iso-8859-1?Q?gUGf1viKiqJxmlr1EdHhcLi6t4SEOKpqywwhiWFdoqtd5qpZ9SuFSqKpfx?=
 =?iso-8859-1?Q?14lNyXS4dYjtKFByCUFZv5UwdMf/EE6783wOMkmGDPRvLAt+raF2936aGM?=
 =?iso-8859-1?Q?4JoDkNXimivbKlgUUc2CVG41d8KmDP4XtrBJudKyzfZOp6Rp+5+XWKGqRd?=
 =?iso-8859-1?Q?jl/pu8gzWOferooyr/WWYymvNh04bgEX7srUy5OwDwYG/3HlMbh6V9yWXp?=
 =?iso-8859-1?Q?pN7Yc0QbY2ThGNzus4EvJed9zYHgLVp34Y5W0jJclAmsMKIAq4yhIPyEFe?=
 =?iso-8859-1?Q?oMjRwbp1IUl81khNfIOUIfX6nCRZBr4S1KZhnIUAMJPrTKlRFxvkodj5L2?=
 =?iso-8859-1?Q?qK7qmQwlEpELknJi9Fi/cAocdZcIOW/pt/lbkHBpWgCBPYQKfWGGoOn1hZ?=
 =?iso-8859-1?Q?cC8JWm6tIFRUWDmlIAMYrgLnyv9Z5fs7yzMmaCAtSh2yXrju/ZeM+w6jAY?=
 =?iso-8859-1?Q?2N/nTWUuHahvF9JaIcAWvTTYj6E3LyYQ9Y3lyDs4JKzQeGfE/s7no=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR15MB6422.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TD8kQyG9Jm0d7va0vfdAFTfLt3qf8yzRxrArXZ1IzwLvzUqwUAEi8WLLr2?=
 =?iso-8859-1?Q?wnn5VUZ5mdO+yxAovLFzYc6Z6xryPJyDOhs0DbfeRQT+IGeVPUow1V0Px1?=
 =?iso-8859-1?Q?vdU7zY3PaM7Z665fnS9MwASb2uG2qA45HrIDghRm70FOnhV/1MvWL7XMa5?=
 =?iso-8859-1?Q?IWKBIqWYnpvpQBBXZdiVh3f/BDnp/gc/GgkcsEnImqXy7yFx4hqWuJLAvh?=
 =?iso-8859-1?Q?8C3oFjuJfGVEhB095eXAt4tRmLQdB9qlHItHBf3pFH9wW1Y6Bl6N4uDDKj?=
 =?iso-8859-1?Q?wtcwVE5YkltS3sG9hUCsGYRU1ma3PUUewIbU9LvIZ8328irehEoM1koZbD?=
 =?iso-8859-1?Q?+BONOouYnvc1horqd6Bp7+xUgPyTBRN71GxOFdPTN66xpb9xbgfa5naNLN?=
 =?iso-8859-1?Q?TRxPkdOJmgZkoiPIlAmryL/50xdHQOFn5dVsX9x8n8lBv4sUgawugvAHle?=
 =?iso-8859-1?Q?RU3v0g5iRMJIZqmknmFTM2ih/7Mb2o+2uypsGoGgbYzfRh4CA5LrNmREcc?=
 =?iso-8859-1?Q?EvM2pzwUhhiz2A5Mq+7xG14bY4oo6UuDwLn2f60gTaq9aLLZSBXLPxEBa3?=
 =?iso-8859-1?Q?+K1aqtX17/mpomecbH1JClRFNHwP9BKbw1eWHOO161eJ75n5FZ+ZJzRLUS?=
 =?iso-8859-1?Q?RGcuK9OIe1stSQKuNSx4hSbW6GtRDiv4G/SjGCqrpcvdFTVI188eKeROAc?=
 =?iso-8859-1?Q?nkigweo2sXhs29UeRZduzJRw+it9lKPPn24dvnbP/b+wgncWnj5er4Rup+?=
 =?iso-8859-1?Q?kERtxXlvzMegcNBXcf0aCi9n6oEYLu5I06MrKhEn38hYmLAzvXcpqoK/z7?=
 =?iso-8859-1?Q?Tb8njeYKXfVTSDi70M0Hmbg8+l3zHYyR/V/TpnkfvWTGASNVGqb6WJ2ZVR?=
 =?iso-8859-1?Q?adcOUuWAaAFW4EYmIRXfDT3i+XrCEcw2LX4YaRiixC0n2LPlt0ytbfkPJZ?=
 =?iso-8859-1?Q?QqEkHcgbC6n13fMbTEK7akoqtEuFWcX8/KH05aDQpuufmI2wBiPrwdGGQ5?=
 =?iso-8859-1?Q?UQ48HOHrYXMzTNKsQgKZBJgzyIrze3HV/obRLOWek5X00U+pdJjCDo+MiR?=
 =?iso-8859-1?Q?6h/iATN1N1qjZeIxSk+5btrugk60tA5xrwBP6i9nb08EwqrMe4ohlK8k3S?=
 =?iso-8859-1?Q?doUWU7qvCKycB1mUWZPNZk1FwcHC53jf1AiMz20BjLRsL28WfDtXp+1BMu?=
 =?iso-8859-1?Q?b6g/fw5uOBbryS1K/eqRwVxQ0L26MfF3dB+fOym5TclMFX7aLLVUrtyP/U?=
 =?iso-8859-1?Q?zaHCRuKI4mlagY2571rTGKbrCj4IWIC1sfLk8bWUCh7+k8CqhVxVGEthDa?=
 =?iso-8859-1?Q?01Z4pRjxtrN22NALLwqWvoeTLIXj7K+7hhdRDCm9gt6nZd2zZjDaTuUVgk?=
 =?iso-8859-1?Q?vBQaE43kjN73hKyOdZmlrzfIEUDXFKMQDPC0nrpNyb7vSLcpPKEP5EMKFn?=
 =?iso-8859-1?Q?aQ3lVZLcP0c6+U+pWy0ufidUdlpgDQ+BxEr/Y4aXNZxNqBMtd51m0NNwCW?=
 =?iso-8859-1?Q?26x3Rq2ganxZaLJuo54WS0Xr3tBr7j915bDngcGPfdKBGnGfrLadYJkWVH?=
 =?iso-8859-1?Q?kkmC80PZOLjAEpmdiHXLWaffthwK/s5fNSoi2VGMARQHUhafX9fPJzy+1C?=
 =?iso-8859-1?Q?plD6viO+SWITRlb8Q5talUmt4UhdQUnCgFeeklTQb6CqCuRHeGfKAxT8bk?=
 =?iso-8859-1?Q?ubn+njHxcJKzGqn01c+aKn5qq0jyilhBH37KAV1b?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR15MB642247C424ED44DB51FEA6FBC44C2SJ2PR15MB6422namp_"
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB6422.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3064bb1b-0246-4041-ef25-08dcf29319b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 12:14:38.5155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oPVcjwJgNdeC4NV+E33OdN/YmfVSpAICfCPQmlkjm+vgNWZMXAxTD5pcw1OiNIJECkX8V9GQDdCGMfQ0KJzn5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5178
X-Proofpoint-GUID: SasH2mgQQi7U3DXbY5zHSDMpu9fHZO0D
X-Proofpoint-ORIG-GUID: SasH2mgQQi7U3DXbY5zHSDMpu9fHZO0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=660
 adultscore=0 clxscore=1011 phishscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220077
Received-SPF: pass client-ip=148.163.156.1; envelope-from=DaniSzebenyi@ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_SJ2PR15MB642247C424ED44DB51FEA6FBC44C2SJ2PR15MB6422namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

The TCG IR sequence:
mov_i32 tmp97,$0xc4240000                dead: 1  pref=3D0xffffffff
mov_i32 tmp98,$0x0                       pref=3D0xffffffff
rotr_i32 tmp97,tmp97,tmp98               dead: 1 2  pref=3D0xffffffff

was translated to `slwi r15, r14, 0` instead of `slwi   r14, r14, 0` due to=
 SH field overflow.

SH field is 5 bits, and tcg_out_rlw is called in some situations with `32-n=
`, when `n` is 0 it results in an overflow to RA field.

This commit prevents overflow of that field and adds debug assertions for t=
he other fields

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Dani Szebenyi <DaniSzebenyi@ibm.com>
---
tcg/ppc/tcg-target.c.inc | 4 +++-
1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 3f413ce3c1..3a6b9df68d 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -911,7 +911,9 @@ static void tcg_out_rld(TCGContext *s, int op, TCGReg r=
a, TCGReg rs,
static void tcg_out_rlw_rc(TCGContext *s, int op, TCGReg ra, TCGReg rs,
                           int sh, int mb, int me, bool rc)
{
-    tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh) | MB(mb) | ME(me) | rc);
+    tcg_debug_assert((mb & 0x1f) =3D=3D mb);
+    tcg_debug_assert((me & 0x1f) =3D=3D me);
+    tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh & 0x1f) | MB(mb) | ME(me) | =
rc);
}
static void tcg_out_rlw(TCGContext *s, int op, TCGReg ra, TCGReg rs,
--
2.47.0




--_000_SJ2PR15MB642247C424ED44DB51FEA6FBC44C2SJ2PR15MB6422namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
The TCG IR sequence:</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
mov_i32 tmp97,$0xc4240000 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;dead: 1 &nbsp;pref=3D0xffffffff</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
mov_i32 tmp98,$0x0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; pref=3D0xffffffff</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
rotr_i32 tmp97,tmp97,tmp98 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 dead: 1 2 &nbsp;pref=3D0xffffffff</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
was translated to `slwi r15, r14, 0` instead of `slwi &nbsp; r14, r14, 0` d=
ue to SH field overflow.</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
SH field is 5 bits, and tcg_out_rlw is called in some situations with `32-n=
`, when `n` is 0 it results in an overflow to RA field.</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
This commit prevents overflow of that field and adds debug assertions for t=
he other fields</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
Acked-by: Ilya Leoshkevich &lt;iii@linux.ibm.com&gt;</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
Signed-off-by: Dani Szebenyi &lt;DaniSzebenyi@ibm.com&gt;</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
---</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
tcg/ppc/tcg-target.c.inc | 4 +++-</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
1 file changed, 3 insertions(+), 1 deletion(-)</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
index 3f413ce3c1..3a6b9df68d 100644</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
--- a/tcg/ppc/tcg-target.c.inc</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
+++ b/tcg/ppc/tcg-target.c.inc</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
@@ -911,7 +911,9 @@ static void tcg_out_rld(TCGContext *s, int op, TCGReg r=
a, TCGReg rs,</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
static void tcg_out_rlw_rc(TCGContext *s, int op, TCGReg ra, TCGReg rs,</di=
v>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;int sh, int mb, int me, bool rc)</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
{</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
- &nbsp; &nbsp;tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh) | MB(mb) | ME(me)=
 | rc);</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp;tcg_debug_assert((mb &amp; 0x1f) =3D=3D mb);</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp;tcg_debug_assert((me &amp; 0x1f) =3D=3D me);</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
+ &nbsp; &nbsp;tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh &amp; 0x1f) | MB(m=
b) | ME(me) | rc);</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
}</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
static void tcg_out_rlw(TCGContext *s, int op, TCGReg ra, TCGReg rs,</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
-- </div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
2.47.0</div>
<div style=3D"line-height: 19px; white-space: pre; font-family: Aptos, Apto=
s_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-s=
ize: 12pt; color: rgb(0, 0, 0);">
<br>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_SJ2PR15MB642247C424ED44DB51FEA6FBC44C2SJ2PR15MB6422namp_--

