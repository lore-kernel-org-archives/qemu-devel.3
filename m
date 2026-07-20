Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADE5C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlk8C-0002uo-0p; Mon, 20 Jul 2026 05:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wlk7z-0002sI-9j
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:17:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wlk7x-0007RJ-S1
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:17:35 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6SEG83770183; Mon, 20 Jul 2026 02:17:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=W1C8jdd3oPV2WcD+lWL/ohSznIFUpLYH6QNAa5xYw
 3M=; b=VUNuEOXsU5wiFKzZ6hgKRXCCYvsHWWmw5vPKXgRDs9SybaZ6+k0/rW+T6
 VgL6Pa1vjJ4UsBCkn40BdNeAD4GQ3/YmUY1Cgz8KzobZsynhr3rvmfXjVFnamyLp
 L4mstcL/YpanFiitbB0fA3xKf5Rb071wzSxzCOy7HyLIgoDo0VqKc2u7FbFo68Uo
 Ckulo+dTxq8EkOmqONfw492i8Vs1cwyApuxHxjeBAwL1ZZoRSYJgZ2bTnmBvd7U6
 J/gazRVtynYPZDbwVmqk44ik7nFoyMBcdUUAWbZOlNCtJ3IDYDN4xcDWDKvFf7v3
 eW/FVg4lzFgU/BEBcu9Lyo575q7Gw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020125.outbound.protection.outlook.com [52.101.85.125])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg90xaqus-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 02:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrDckvnM9DJCCU0Sql5CA9rrp6C3LDw1CQ5Kcx1I9s8TaSgHZi4WpQR9Np7Aq5xA86S2GavqTVbmSLx7wVvdoB/Li8GQVDhTS7AaJaI5i4g6oIMs38bB4oSW6M8YI+EXrWSYE7AQ1TvyrrDXH5BB3EjGuAWoedMB2BazgvwrPiJk+k/EN6lWJpzkvxgkh7AMtzZpzoV7QHy4fe65Z4Zv5yk1/pVfbh5FPr1Yig+I5ShtX/WR4w2JIiBzZQ1I3C9TloMsGDjA/CbAJu0DkLgse90iWGWFPV61NkmTPbbnWWKcO6KmqOzAaIOsOgOwlclRYI5/Hewcfxx/Zzt//nR90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1C8jdd3oPV2WcD+lWL/ohSznIFUpLYH6QNAa5xYw3M=;
 b=asEoC+17LbU52MPdruBCJTORPP0SSA+vTsnBQB+5JbEuY0pRyXq475n5Jau6IcMJArOhHcHNjSRwvoRux7PsD5jyqeQGI2lnqbPBGyi+2u6V2BwYF5ljKrtBq1BubtKdtkNrjZd+z0tmmFeqBvyl3twDRfFejYjMSVZM+smKdaaF68hx7U4AL2OOExyd9pJ7xrMrLQ8O8EH+fhFTJ4Ktj6DA9NSXyk7nwEEBbzaU3e+9ImwQUgSxYKb7ud8FayXkdE6l+WFH8X+cv4ly3A5V6oKJClL6UOkexnceD4aEt1eFf2c86lzIEMtpbpGudS55OFSIm9uumRiTNYnDVEMZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1C8jdd3oPV2WcD+lWL/ohSznIFUpLYH6QNAa5xYw3M=;
 b=lbqH5jymCvOLR358cCIy+t1JHub8O0xfN5gq6hWFaJC5ea0X5hxQRIDpwIWf82kxv6WPF5n4G50mJdlO+nex8pFPNQRtsD+JSwMPoJjsVzpjy3ui/Y3cP1pAcevgK2ON6bhPJqmwqjZAOSbtBMm4iFRhxzL8w12MUtcniBsvaAUd212HpTgdaC1flfNMtIb05uETm0P2ffB/LPE+qDO4vG0cqs29RCp4b4c+u55f01qQb6H3URB6jKTDOMA0AN1whWwlWysPKmB8oUKiwNUoIrZR7LWy/rCuZXVKquvUAQ6xYGPO4D1c96jdZmS3rVO6F05J6pTMgEZJ/F5PqZS2+w==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by DSVPR02MB12010.namprd02.prod.outlook.com (2603:10b6:8:41d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 09:17:30 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 09:17:30 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH 4/5] vfio-user: vfio_user_get_region_info: prevent excessive
 malloc
Thread-Topic: [PATCH 4/5] vfio-user: vfio_user_get_region_info: prevent
 excessive malloc
Thread-Index: AQHdGCiXPAzqtXek9Ey2cZEKaM6pcw==
Date: Mon, 20 Jul 2026 09:17:30 +0000
Message-ID: <20260720091718.2642-5-thanos.makatos@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260720091718.2642-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DSVPR02MB12010:EE_
x-ms-office365-filtering-correlation-id: f6f40e1f-6f3a-4c5c-c6c7-08dee63fb9c1
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|6133799003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 6ODLUPdCjWJPtue4eKziMnWj6epnTUamma+CJr/g46c2IhaT3ir/2L4CiMaE4WzWVdoSsHxFEPbVRapvrD+EzMSx6Y9cnUcgAACkjqa9y1HPvvJxYXHJ8oYT3SbADi4Tdpl+PMpY1LWrORK8U2dyEqTXRO/i0Jy7UMi7SOoafMYvuXIDj/OsfYccti/QozmgB75d4Egj2KMBehNc9kxu8yAT8KLtmw7cf7FmbNZULWqS3zj58NR5vHikG7jL5ksjpVZNlLWVTi5PEZ0OTXzlmbA1h3cW25H+9fW7XKqTpM1T6OaRZK5NVc9eOZgRF/P9b9ny46MYFxCp+LDvzfmCIJQoLtCu9Zpqx+XgIWgFhk0MYYUneF1Ol3f6gM0lHc/PFgb3UpeKwXoaFYMgVQPwzuvDGIZoByhDxP+2EhzhlmhtNqiMpHZlts5Oer4Iq1JaJy2sfjGWohc1zzpV20HTSkwOgV5Xyb/WIRw4kbkV/54xCsnOnGVkR1xJA4bIYn1dd332xZiKCQbZxMh88LUI4qHcpRrTh7hLVqSmyGU9uuCPNQKk7JfDUvcBiWkUm0KzYUvVL9rBe09aEuHsaIv68UkciWfNCkayQPhr967OPvF43DuSLR4RidTBcKoWQByaYyNO3sVtsCIYIZUuI/cliRJaYHZNvYbGtR8XPb0AtXG0925bHTNWaBzXJnrkQ9ORd55lTB9XxqOxmKKLJ18OkQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7mRuOC8GXBm3DYOAOrGeba6y33+d4+m0847ZB34+Hur0x7B+bYq/CHcBTu?=
 =?iso-8859-1?Q?MabigqKBSM542Jpld84XiC6wmwN+VuUtE2zik/0zHO2xQ3sztSahJI/oFE?=
 =?iso-8859-1?Q?6010erHC2MesHpjLseySORKK07SQiyD+UgewXFOUfSGGH2Jf1PDb814EJc?=
 =?iso-8859-1?Q?l2e0fI+U2zEaj5LQEXWL5Njcmh49ZJwRKMMJSvoPUvaMReL0D3Bw1U9ife?=
 =?iso-8859-1?Q?8x8M2817F9Cm3ahx4p9HYcSbXmfakXSUx5tj1pcd5EbdLciE/xcI1ui4nv?=
 =?iso-8859-1?Q?EPjLuVWdjCK4C8n7XikMirOsOMllH4/NFSKceyGQPTTFECZNVTMvWHnN/T?=
 =?iso-8859-1?Q?+BKSGJ+ww498S2s+DW74sGfExjthhpkepn6g7D+kLoz9H9Fgg+Gq/hjHJg?=
 =?iso-8859-1?Q?c0ieaXb4DLMZj8TvPu39eOiklShmbXcTwrcDzS8fDZ/DHUHoEeU5NxCzi7?=
 =?iso-8859-1?Q?YiLd6RKrzZzSB4wuhsi230ghLxRBGekqUzS1s5MTyOXj5JmmO22JATqM1l?=
 =?iso-8859-1?Q?mfnD71PlleQ4vcXG1B6lpc5L2vBsqbZ4XwxJZ/J3Az7Dcq0Amks34d4ghg?=
 =?iso-8859-1?Q?WIPQ1leDgCezzrRYpltdnEy0IneYt40vDGHTMzn/HZ0+F9zHQwSKLlyMo3?=
 =?iso-8859-1?Q?OLzDF76v9EYag4a2vKYdWCHYqEBYmMJTukErHHnvB+XuMRetGuTly+FBVE?=
 =?iso-8859-1?Q?9M30kf+xGbipU4zHNgkPOQUXqCDZ2H9IIKeTIitU22TWH2UZcboYQY+Gas?=
 =?iso-8859-1?Q?aLsYap+bREULd20X6YeDUk6Hl3zJdjKooFIczA3gRtf3YyqkuWD2iCsQX5?=
 =?iso-8859-1?Q?1rhumv45Tea5QpRZc4bzURof3Igh2y5Kp09LB7/RT3Y5NOfx2USsDQLqIz?=
 =?iso-8859-1?Q?rt/u7XrxQcwl/cdEsBMHrOClJbF8cGpB60wZ0ysW4hZGLHwJDG6L1zaWi2?=
 =?iso-8859-1?Q?U2Es/AQZeZIKsRWQiHpaQPZW3pK+joIJEzlwEzG9XM38ZGJ/me+26czrPE?=
 =?iso-8859-1?Q?bQIU4SZiFSkgyj0icwr/SsWRuS5gMzCdZ1Y4lmzKHyN5ELGSzXRJLG/IJN?=
 =?iso-8859-1?Q?GkieedNSKIAFXRHj6/WsGjLIs9SUHid8DsIh0W+3sOt4Xlpm5hYKnUsmHZ?=
 =?iso-8859-1?Q?hRQQsXd/zXXhgCQ/0KA3xtJLmTJj5U/0STCMLLCOuPCX7Vt0ah3nFPRKma?=
 =?iso-8859-1?Q?qmOvnjHn7QbA/4D2QSNPzGqk2Fs4iZd4Vsv4EZX710Q7BbUczLgTxJr01Y?=
 =?iso-8859-1?Q?fgvxiJPXGYakrxdbfeJTQAZySPfUmVdt5ZKAc/tRnMlMDbgdB2lXoVJoKF?=
 =?iso-8859-1?Q?NzkXPuD9zTP+jz3ZurLaUDOKPDSZ/4YMs6DqIYRG2+UGopMSmc0dLU1YKZ?=
 =?iso-8859-1?Q?w0N6iCehJlC2v7jszFptOVv1UuqAikrZbXEECOPA2Hd+Ltm0IrYu54q3DJ?=
 =?iso-8859-1?Q?WCb9SpX5GFjpS/VQXBHphc0ofnG73okdLWW1Jx+zpNBdbFsTpeaR8tXnm0?=
 =?iso-8859-1?Q?bqTtBCDrCcsxChAZtpMLHWBCDTVoDrG4CCW34+51I37yE6x2hB2l98niaP?=
 =?iso-8859-1?Q?Hjb8GOLexH5iHobyR7XPGK6pkd+TGA2CK4evI95dtBGNI9spAUDUuenfZ/?=
 =?iso-8859-1?Q?zkwVyomPDMfqQZs5uFA+mqH6UAcFMP78T7DPL7HYDdw6AHN7ZFdwo6ZV+T?=
 =?iso-8859-1?Q?Dq5/BwcZipZt3mIZomyDoAfTVY4bgCUKqAR752IjMnD1InJVjbzWkGHeSt?=
 =?iso-8859-1?Q?9MpghCWFxN/CiM/UVvfTM1rPS1/uM9ARoOl8iO3f0iTlXciERxsQQZAY34?=
 =?iso-8859-1?Q?Ua3JwBhGLo2B76q94CuYI+fukAONLco=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MFPNrouBxbPfFbXP1Y6/L61xRTXlQEhk0HzbpHbDLQdW/chnpuc2IXpLmTXLLLpjYFufhDXECHeb/MzFUVrDtoYg5TuhF0l2z+7rvzmVdkHL7AqoAVON4rSmz5zlFmz4yq5hxJzjDK+XVrrTPeOx+AY+/HSfQwAVUslniJfo/Z9+Ww6trl01/gCxsgp48MhBXA7nMJicC6Rem25Xdx8CeKa5GuA4+svKNTeacVBKYgvxjTzpQbhx0bLSKsEix7Hr/KV2rwTk0BSaArrDdxSRFMaOpSgGeYBsvsMQfm/yPoOhwIn2C1bxg7aZ9mGOdBLIhWQpX7FZOque585gth6skw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f40e1f-6f3a-4c5c-c6c7-08dee63fb9c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 09:17:30.6678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlRI5G19PcDsChOf/jYNW8vzLzfgm4AkmhpL2vXr/5nX5Od0Fc5KIG+9/hoZ52APBYH4KAmpAJVED1Exdv6GfVYzSaEk36dqjWHoAnVoG0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB12010
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfX+eWfGReebtqT
 FhizkiTmzwTqbM99VDi88l+KQ6rGYFv8KsClbIrSEQcI0kYIM5/6KOzjnMiwqHLgzPhmwSovHUe
 jkbH/6OYkLP1EClKX6fh1KlvApBwRpA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfX+gVby7r2E4iv
 U0m0uYSrv9IxCHsuY5GJZxeaLYy3WXmkqfuhAXrTI2xq9dyS++YjqPPLrCOKpdT4CgB5/IJ7sOj
 ff6S/1xYaurMNrtYcKadX226K8nzRLSeR02KBY5KyBC76+cL88iN5rGnoKERwJ6zUUuPeVa6gYI
 aG62YVl3viBdzNL3BdvQlR4rumo1mK5d2PXyikLTkdLl/iEM8sdPESRF+tb/H3Q8nAB33dSIweL
 edSKvcoRCLsEtWUYwvxDRtOwpuCUtmkJgwGlC4eSUzdXUaFFB+HH1PlhPhuOr2/zLlnIoVhGZGr
 1WtK9lvAW4IaknETmhRGoN4kFoQZctKyBxbohOOpMKh/gDzTkuWfqO7ZJrni81Yse9KxCiaPfYS
 29cCKNfvCLhJdTcj9GAt+RQh7vDdNt9Z+6O6+SCim6qQg6PBlesfYoyGkKKAQyiucfvej1GIyAw
 VMn/M+e1zHfkGtDDNTA==
X-Proofpoint-ORIG-GUID: nFdkPz1dSgjrp74FYzEuxJQIbUWOy9N5
X-Proofpoint-GUID: nFdkPz1dSgjrp74FYzEuxJQIbUWOy9N5
X-Authority-Analysis: v=2.4 cv=CfY4Irrl c=1 sm=1 tr=0 ts=6a5de7ac cx=c_pps
 a=bA8WxO540RzhAQ9tgvMHlg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=64Cc0HZtAAAA:8
 a=Wq__iFXxit1-DUNQLyoA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

If the vfio-user server responds with a value larger than max_xfer_size=0A=
vfio_device_get_region_info() blindly uses it in the next loop in=0A=
g_realloc. An value larger than max_xfer_size is anyway rejected by the=0A=
check at the beginning of vfio_user_get_region_info(), however that only=0A=
happens _after_ the g_realloc, and if that value is excessively large it=0A=
can cause g_realloc to fail, so check it here.=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 10 ++++++++++=0A=
 1 file changed, 10 insertions(+)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 1907a6653f..d7cf39dda7 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -171,6 +171,16 @@ static int vfio_user_get_region_info(VFIOUserProxy *pr=
oxy,=0A=
         return -EINVAL;=0A=
     }=0A=
 =0A=
+    /*=0A=
+     * The server can respond with a larger argsz in the reply to request =
a=0A=
+     * larger buffer on the next iteration via vfio_device_get_region_info=
().=0A=
+     * Reject values that would trigger an oversized realloc.=0A=
+     */=0A=
+    if (msgp->argsz > proxy->max_xfer_size) {=0A=
+        error_printf("vfio_user_get_region_info reply argsz too large\n");=
=0A=
+        return -E2BIG;=0A=
+    }=0A=
+=0A=
     memcpy(info, &msgp->argsz, info->argsz);=0A=
 =0A=
     /*=0A=
-- =0A=
2.34.1=0A=
=0A=

