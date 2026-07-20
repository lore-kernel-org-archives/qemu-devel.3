Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C1FC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wloWU-000538-K1; Mon, 20 Jul 2026 09:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloW7-0004oU-Jr
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:58:47 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloW6-0006ZI-1I
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:58:47 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDtNY0516432; Mon, 20 Jul 2026 06:58:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=0oOiYBTxU4+rRjU/EFTPbWFSyUgklSJbgBeq4FGez
 7c=; b=tr2tT4wbKYYy/6pcxe2baecJO5MwBWFIYihPoPEsYkk2B/ilCsrhRXDPw
 C3t29a8KmE+9Hwxkasi0bHPSS5etHjFmjdH/0xcyBl9p5IqRoDA8lSW3QXBynCdb
 75xFvUj5K0G1/34DC8s7W3QP/OuG7VbPAKP+CPh+MTEXhDxkWt/GW0Lqh83mmpfF
 Ovo61Q5FakqXIJPaxoL0YEZzOPVFruFdtpCJZMp5GDr6J9Mz9FwbWYSDTlfHz1OZ
 ECvZfaqdYGZOWUQPbsFtK2J/2XVkZWGuK4mZAKLcawCSmcGS2ZjeneD8KvgOVYGX
 cylIW63Uuk7jWpF5XGRmjc/Fr5EJQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020123.outbound.protection.outlook.com [52.101.201.123])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8jcue54-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 06:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxsMIRLwhg074oiAEn6KILm0AK+RwacG8zPtAm6cc5kGdwIwnVobSqsKl8PXnnYKNqSpYvDUoNXMt1iTo3PfAVyrKsKmpotUrD66jSCHM9vZd/jWNG/cHjleFfAq+FrohukiS8eFgSv1FVwL8UM4UpQSw+UFrNfxtfKET96XX6OzRmiiYkmmBMw/pOT9UgkpdUxkrHVN0f25qUL2aaingxt03BNBpy7+kBd7JzAJSf8/ZLwdOt6mcou7AwvqiUJbvL7rcx1gAkNwDPD/HMbilgpRAaxDUtxFNgcLLpNdd7NDvL41rMgeeJxSaogBgX24bOfJVpyghaSY3iCPhkOh1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oOiYBTxU4+rRjU/EFTPbWFSyUgklSJbgBeq4FGez7c=;
 b=VbRx8eVHLD3NDdtdzBITu2kx9cg1l0qz1AERA7OM57a7NWg+Fzz401DkPmFBjCM/fIVYdewYvY3aa0JEbxGR4U7YukiEGq9Orl6/NaH3GGYrjvSkbX7aint5m/Xyt4a3X7WpqOxc1OxCBDxLC6PZ8/bLAhK5Sn1xSv1LjWkJ1zUr717qkumqYzxkSqRDirJnUVhYHY9PcEYAeT6PdZT+QP++LUs9kPvYyi0I9yK7V32DkrWAqVlMxBbEql+9iHJfEnCH24gsfQRt+pRRP/cXHlrmasby8Sox50GKtGNVd5fdXjdn0j2ROKzO8F1K2KdCRLLrk9vy6P/RppM646teLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oOiYBTxU4+rRjU/EFTPbWFSyUgklSJbgBeq4FGez7c=;
 b=dNZ+W82jpeXSLxwscyuKf2Ix708ey2zrpaZGibu/q8HJDGk8r8CUauGTd1XQT4FDmKeK9uOB8W9sohkBUyXAdHDgmb8Ti0qyZA9P3kxnX+xRsySCOJmxsDVEJuR+uWYeXAmrUf5rgchzNCh0b1amJt33VQDwBl8nfoiMQcHm9KawvamlWRhQBBjEn7DIFxS1IRYFJ+GmzqMVMSAmAbxeqK+2tbQ24vHjjJuei37Yh4pxj/KJmdsEPQBiE70zQCUd1/in2KNvtXiLNDxvu3t3WsuR92x1UjPfzPPJSuZr7VLhJQ2vh+rBKpqEUjMbVLUJevLRMHUtJw/91HAjNVQxYA==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by PH7PR02MB8883.namprd02.prod.outlook.com (2603:10b6:510:1fd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:58:41 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:58:41 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v2 3/6] vfio-user: vfio_user_get_region_info: reject
 unreasonably short struct
Thread-Topic: [PATCH v2 3/6] vfio-user: vfio_user_get_region_info: reject
 unreasonably short struct
Thread-Index: AQHdGE/ef2cCCauaqE+6oT4SgJt7xw==
Date: Mon, 20 Jul 2026 13:58:41 +0000
Message-ID: <20260720135823.21070-4-thanos.makatos@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260720135823.21070-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|PH7PR02MB8883:EE_
x-ms-office365-filtering-correlation-id: edb5e501-17ba-44a5-c9ea-08dee6670192
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: RDfe+/SKanZh3lYwOyRUDmfvsdRVRQjQH21i2a5q9QAXe6BpdB9ob8vs9GLUwreIR7DHtHvm2EWEqflSRyv6LHdZm1DrSBO3y9aoDTlKfIbcHlx3ZlpEVcyelZvrJ7XC9ITYW3nsHOKeQLyFBJXNwju04F0QB4aN3IOsVAht30mFXrN8xCNgKrDCY+LlXDsEdkXiV7636pzIbVLUj8phqbE6NVO17mdbqDChKxzhgi5oWE4bdaz5Irz3b78l1MCmpjucV+lLBOR31OBPW1UxrUw8t9dprd0mmQxNqGN6NYkOazW/WqCZU63u4UPUZiZBzMz/TMYZfXh80RuW6Yn0jFLuidtmGansONRYRXsKGiSZf1DpDwUCREMFv4eEHlXVYyBnrE4eQQcFFVc/LZPYNCjqSMB5onMW1LW6N5QtZPe34ylfExAFkJNoXvoDmMjGP6N5BGzsGCsfpADxN7egLyHRtr/v8oMndvC3saGIZDapRZaSz8VlldnRo+Gc87VbQ9UsiV2Fas9F6tXUhUyYm2Bxn9FI0GZOnZK6YaFg+EQqPsvy6Y/tjh/z75030k9xNaV0IYNr+gXvf64Nr1Px2NArGaPnXO+aSiY8RMOJTINDJVRDgMA+HnqX0eKaqauQ3w1P7SzCsvIcUmaVDofGJiNzjuzwnuoYw5iC9RpByT6RSNw4YyXtgEZEkpNccELeXYIeAES2faolDCVMCXXEUg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OiejzjY7XWzNdJjn7DYKcY2hWD6R1wLsLEFVMouVZMk2RKWwXXu4A0nWB9?=
 =?iso-8859-1?Q?qD4K0i2LdlcxPS5tYIJar3+6gFH0vfhvrMza5NmnEE5mR6IaUFUAtzriL4?=
 =?iso-8859-1?Q?SzoD8kvZ7HYEQG3cJ/1bYjZ0eaqQa3lHwR5bR1sIKeFRAuICUjmv2WH2fL?=
 =?iso-8859-1?Q?XRyl9cTfRNk56a0XOg1uZX2TU3rkCFAvka8ua3Y0bWOtF5XagquKaxkGL+?=
 =?iso-8859-1?Q?3SRI//Ocq8meHx8mNSLBRMe7s1Wkp/K8YesIDF1XWdbA9oGZTh1ZQO4op4?=
 =?iso-8859-1?Q?XRBF3NzNj5dxP/uh/6ICS6bAcFh//1xGbGt+9izNxYD+QzLlQj8A5wZy3h?=
 =?iso-8859-1?Q?1GL6m1UWO9xkJyTgNK0eVQYU2+GWYA32e9h5DDkMknnq7XfgZzcYew6eUF?=
 =?iso-8859-1?Q?rGMc5lHyADKtK7lk/j50O27KZqrAzV3HdP7rY/Pb5ltKh+JOWG3QXVbgNX?=
 =?iso-8859-1?Q?Jd7c2MP9F8+ehCeCqfybPGwr6diFziDmx1K2EVs9OHVuicPtZnSBYRGVCK?=
 =?iso-8859-1?Q?j9UVl7++40U++qniaqg5eyYCCWOkJrXl5FESmBw9FowZy1MBAjyH5oNKfl?=
 =?iso-8859-1?Q?h81jc0koEHvSvarRC2qs6n+z4W9uBYZ32jD/UrU2JedYAympDeZh+0TaBo?=
 =?iso-8859-1?Q?PNbvQEChpfbMDKphZmsy/U/c6eTrUPpAsLqgO8NVwCKu+u0QFKJ3svwk3n?=
 =?iso-8859-1?Q?3XSfLWAU8uY2Vy0Kn6JTaY89ZBx/z9q+OsO/4VQN1+zj2KwDcpIfuKuJsf?=
 =?iso-8859-1?Q?3Ea1hN26vhPBH9dJhrsenejDaJ+VBZCn4hNspfUf7hrvaRn7EslAaeDTVH?=
 =?iso-8859-1?Q?dMFR6S2dATi1btw/BTic3B/6kXeZY/Na6dL84Bcx6hHhU5W0+cnRhCdCnq?=
 =?iso-8859-1?Q?ABJNXJcDzPh6qBxxNcUvgLzdWB0iwDzLJHbhlLdnOOgrENeltpJ+7aXASf?=
 =?iso-8859-1?Q?7dE4Grn/NKjfO3GZNG4YrqpCXkxfWVNtk0yQAh/9QvU5jGjy4oJpjbpBX3?=
 =?iso-8859-1?Q?e2UE6rBBnRQl5YANMWVoC3ti2T9ZkdopgwYxvf3R3j7MMHSyf6tA89W/Ku?=
 =?iso-8859-1?Q?cXX9f8FkTSW/CtYddY4PxuQJTApAfgaq4Q2bleR42Mvli9cA/I7OQWcNJQ?=
 =?iso-8859-1?Q?muHLR57gIND2NkNRSjAso37svtyCotfzl+TcQZD/rZ5S7SpdiP5hCgWQT+?=
 =?iso-8859-1?Q?Bax/do4iTci4+6QsyEvCyUc3FdAwTBXcJVkwuYJyB4LPn4MrNLEbjmT/iK?=
 =?iso-8859-1?Q?aSOr0qjoCnvykzuUZHpPoSVhzBXeB02NBexLWtKyRWswbxGvfmWQFfgjZh?=
 =?iso-8859-1?Q?pJ08AIg87Gm77TQJzCwJse5AhHFnrO/oPIaFOoXZ9y4XvDlnC0ut38Ao5j?=
 =?iso-8859-1?Q?Tx6CEcUATpOqR/MDUWyMGkN9d60GyroC/G/UCTh+EZXobE5nXWpYtyQs+x?=
 =?iso-8859-1?Q?V3FHwPxu9nKplvuWQQlo+V1Fu4/bH6pF4DxW0qtF6In7VcGkFtaNnYIriC?=
 =?iso-8859-1?Q?McSJUudVVEHlnwFJDOPO8jzZteHvtxssExHWVMhcH4Szl2wXX+/Ib5+kkI?=
 =?iso-8859-1?Q?h3w/jjpR7LGkApFmajBy+Z9lyO1iVRLNFwwD8lSF+KuwSeEXvTzTeAZqna?=
 =?iso-8859-1?Q?l9k62q7GU2Sgw3ADGnLjDczVeIuwMx9iSmUlvaxiCCAz16tSmzPS3VORZg?=
 =?iso-8859-1?Q?N9ORv+2/CSuRM9TUJnrX9u+FHunLndnrrmdyNoK/rfrdSDx5/opx8wTr9Q?=
 =?iso-8859-1?Q?1CB/g2bf4FZbNMB5C+RH+ohIc488iIfybg4AreluCv8msr2pxXNqbP1lWU?=
 =?iso-8859-1?Q?IuGyyRZfeH/ag77TCH3jhd/Hsf2m4oU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TvZr6Mlj4xAaNopTj/eXvWOV36VtPQajVZ6MCfL1ce3GkXBZwMRPX/Ra6uMJwzdupP1i/q1jwoVXT0wgIHSNMmOVWDoTap+g/fpDf8tSHp7p3WXgLe7SArX2v+7aVDwJMjIQz3ytYQHOK9RXfuP7ufDltt8oiOyc5IsDRNBGDHKJHgPYMIYDuSjmBG3EBb4Gm9zpttpJo2ocqIaWOtscMx20bmd/rMoGZwBL3fBTWobXVHlawtPMrFJVMXFPGAUsIADAdBA/I1UeOsYZYuNcblDLQfXnNvZzuAGsv4JSYME+jGnL0f5JY8ysawVasOI3NqaTYvk/xqics8YHd3NnhA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb5e501-17ba-44a5-c9ea-08dee6670192
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 13:58:41.4193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2zuvY62j3tKtNDse7WFaNGzfXNKmFN8OB/BQzwM2B//iTW1GtEnOk1Ra0atMlHXAJW53XD2a2eF3X3KPfWXPWdY5gdb+uMXH6WXMq9gh7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8883
X-Proofpoint-ORIG-GUID: qJhUEq2jg79U0-xSZmepAgoaH3wbo1Uk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1NCBTYWx0ZWRfXx3YvxIbUet5X
 UuM/KknkEqo20Bv7H2Lp97ABJd18jiLP+eS+WKX4oCAQtZV0Pp2Hj/eGamOafzf2ZCWOJUoqvLS
 2bfnsF7qPAHIXl4Ei+VduzW1FHzYpQk=
X-Authority-Analysis: v=2.4 cv=R6Yz39RX c=1 sm=1 tr=0 ts=6a5e2993 cx=c_pps
 a=/J5H70gqsNCigf7dtRDCFw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22 a=64Cc0HZtAAAA:8
 a=iamFcwByjoOU0uyVQI4A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: qJhUEq2jg79U0-xSZmepAgoaH3wbo1Uk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1NCBTYWx0ZWRfX4+aJ3jjRTL7c
 XS3MMWRUbvs+nd63l/hTlO6VOGkSyaoSgmeLYmpsyKfAQ+DmasdfgBCuMcOj8vg7ch3KJkSlOl3
 0hHW5QhqAKk7L63Hd/rbAbjbSDXjI+DPj+mvfgUr4sPjg0GZsAouU7/nWd6eJBNi2MVC5Hmor49
 lMvhXMPYzs1elwRmMWxLuG0PUXbYoxmKVOCNoxJsOGgYXC4NAihFpo+37TxoIb/xwKDcI9TQtzE
 2ZfR0ZdRTYs3teSZfCabEvmWwxEyzQhAAo/yPnqXW308lUU0NlxXt5VgdSMVJ3AISkmBqRegxY2
 4NhzoaSFEbDJwgCHe27vuR2c932CVreqzPBOEczsL5lWzlyRTfbdDXHd9tvTqcqnYAWvtT+40ak
 9kRAdNNkt4NjIrCW74DzqV/ygBzWmuY/AEka4ACsGBB0BdBrbDuO7W7H8K6klFc2voNELRt0qXl
 7YydXA7eLBs7D/VpyYA==
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

While this isn't technically a bug, it's highly unlikely that the=0A=
server wouldn't be writing an entire struct.=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 5 +++++=0A=
 1 file changed, 5 insertions(+)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 8350bb2c01..3d12e8b2a2 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -165,6 +165,11 @@ static int vfio_user_get_region_info(VFIOUserProxy *pr=
oxy,=0A=
     }=0A=
     trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);=
=0A=
 =0A=
+    if (msgp->argsz < sizeof(*info)) {=0A=
+        error_printf("vfio_user_get_region_info reply argsz too small\n");=
=0A=
+        return -EINVAL;=0A=
+    }=0A=
+=0A=
     memcpy(info, &msgp->argsz, info->argsz);=0A=
 =0A=
     /*=0A=
-- =0A=
2.34.1=0A=
=0A=

