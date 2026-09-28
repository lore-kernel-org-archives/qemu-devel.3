Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DD9CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDDl-00014g-Lg; Mon, 28 Sep 2026 11:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1xBDDh-00013O-IT
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:24:45 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1xBDDe-0002kI-V7
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:24:45 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEhU4w1856331; Mon, 28 Sep 2026 08:24:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4pwOWGwIiL0Gbn1VNRLx8zNm0wYvkWXFlLUCo900k
 YU=; b=yxj64p5mI/NHxoqGTvK56GChCJHpRJg1fenSj26iUYWKCFfzq470z54UA
 0FCtcSz8IFf4+5QAvNQLXTc1DWLLe7P2nzhhENEY+ip2uNKLu82SP958VZVNNSKB
 VK14ugyQFEiNRIH+d1FuI9OjM1brZTHXH7O6ZOBTMokmcuZ3sLcHqr3SAVwJe7ot
 ybkKRjQVM5uQjORIGfd67BWQBZOsgTLA5AMxg07j6P9zUJ8xeJc4BTZsyg6gWy7M
 jRhQys8oTPcAN+ac1JnvHJMWeBqINHLVOV6AATdvsmvbreGF5dgISS8i7o14eVfP
 RZGMwAht5BHdC/XN/jKpBSi9sgNOg==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023119.outbound.protection.outlook.com
 [40.93.196.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gxd4em6ux-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 08:24:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eX+5aytPJzZiVxaXtik+ube8bdqgDIJxtUIUXgaR3q8ie/EXp2lJt9NSIB2FYCWV1x6aC64Z/J2P8XAyY936F0mM51ASw0sTiGjkjt7FnustxaBt5TJMSMWsI/jFGHMkpbmpe9XR4lYDgzppFI2ZGpmEMtcvirWEdy395BImqCrNkfZPGQM9UfhJ6beTJH6X+RwdeOOae7h05yZmNK7eFWCXzYWH2sggonrWk1BjUcpdn2dwmv1aL5hXTifSNyij/kqpcmVniJ2cK70B+2xe0VUE+bC+RHcZ6oc/yCqe7oDVtloSpgHRBN+L/75m9V+6e6N1mRmZjT5e5xi72PwQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pwOWGwIiL0Gbn1VNRLx8zNm0wYvkWXFlLUCo900kYU=;
 b=E8w04WiP5l3CYW4TLaHIIGSMWd7Oprw861hJvYaE4sxSE0jQjRKMamDf2bEzC68dCxAoaGRayOJWWVmfss7okF1IdclGizGyHuhiIhB0yBpNwCsqVvjpHVjMnXr1jVefpzxYXiivijOWSqjmsfr+cnnZxchXm00p4rV/VDuq7LZ7V4HZgSeima9QtdV5EtsdYI9ECdRhI4m9NygBHBc4AAO7JEElt0xD3iVKexycEKiP/t3r4irpVqSnu2Dl+KyfAB4f0cQ4pJOmPv9EXGLoWS3TuLtcmYE8Z2p8VPBFtREvDZvLqEndFob/Rgpk5q+vpEy/6meTiIIGwuwj/FSP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pwOWGwIiL0Gbn1VNRLx8zNm0wYvkWXFlLUCo900kYU=;
 b=TUANdfWosTHNaGelKRaMYLtp6KT/iMC7GJw4AVBDewmklnBWIz2KVJptHFuRG8c5lAR50v96Ru2xcOiYJQnLrh3nK+1U5+vZ3FqsX0URlq962YnAn3QLLa5jJX1pAKfT9mxhqVf4ERO2JWGBMJuuqd+AGep1oAKzGS2R2RfWaBHgGlqRKf7XPZtC+u9Gcqk1qKSKfoLhZY5jWwuNZ/7M5XPT81OFbRUy4rg+ZOVIUBbFtDs++cYs8ACeP/0+yZJ25eWIIHrTsQtiHDTromPqWCcBYM34xPtrch1Q1J0glMgolsNSPLdggDgoLYx4m115M6EK2NOWDDSzC53Bqbaj5Q==
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by PH7PR02MB8884.namprd02.prod.outlook.com (2603:10b6:510:1fc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:24:36 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:24:36 +0000
From: David Vrabel <david.vrabel@nutanix.com>
To: David Vrabel <david.vrabel@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 4/4] hw/pci: Ensure PCIe link speed/width is consistent
 between both ends
Thread-Topic: [PATCH v3 4/4] hw/pci: Ensure PCIe link speed/width is
 consistent between both ends
Thread-Index: AQHdT1140g0hFNsIW0ykC5A75kwnlw==
Date: Mon, 28 Sep 2026 15:24:35 +0000
Message-ID: <20260928152431.310363-5-david.vrabel@nutanix.com>
References: <20260928152431.310363-1-david.vrabel@nutanix.com>
In-Reply-To: <20260928152431.310363-1-david.vrabel@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR02MB8368:EE_|PH7PR02MB8884:EE_
x-ms-office365-filtering-correlation-id: e55ac8a1-1762-4600-9044-08df1d749afc
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|5023799004|6133799003|18002099003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: 26pPqSRFGcZsdLiiT3XZbVpzgPlB3Bzx5HR33Tf2cNh9y+aksiLNla2fg4phhTEcUkSjBj3mVpfejA7hjveC2wBOTQ+pzxUPlImsx2ug3Xzdr2WE7C+RGw5vl0fcwyqcHSNxud7BE0esmgB6SiVq/qg1GW0aLvcvKYCsXrYUDBUmy2GcVa+vLs42cELSJBckkS55VR83y98oVsFFQTtPAWdBVhP3UC967Kdp9JfC5giGi0RErMADhWUF713zaGbrfP2kv+dJKcu0qSNBWYst6F6LSf2qqWFNOvCG1e9uJmH9eD2B1bkPgZ5b6JWW2XjQPlD07fa0jH7/axuGfL5iavkkix+TThpTqKIuSFHz1Cf71i2uwFYxTdmf5dYEFLaY7id6OrJC2j+lcHwiI9/aD/INdDd5UMjxYrkSxhvXnyz5yg0sRxym4pXWx8IWWpTPXIgyxXRZx/rmjNODSg7DyJfNdRUeRsx7nLOXTkyl7wUGHRzuzHrjMiLu8X0QdtfPHYKB74coG+Gdrh11copRvHG9i6WrhIMBpg/z/2l9dkZVp8rOWx4eyGVydKGc0ZEl8L5UN5LuWHBuYvihq4Dj7gRb5rNDTjxjjBUQKBl2hZj+qBdhDUTKOsOwzqiI2XkdSXxXtLccxfmtR/7ZipACN1p6mOp5bbjl/SY2vw7o0OTaGolzq9u/HzZFRRG4dgT4Q9AGXbCbUlB9SO3ufNHO6iw6waAw7kJio0L6tp9rn3w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(5023799004)(6133799003)(18002099003)(22082099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P0EJBvTInvanffZjOeWF5uMMsvgYJrJ1tya2EQol/2/sLO3vK+EYgJ0Sxr?=
 =?iso-8859-1?Q?JKKPey41O/3NAYezrvqBX7FKbGsrG0t4KYTwvfUFIl+D8hshzGjXVha2d7?=
 =?iso-8859-1?Q?ghPvRGRB+2H0pdeUrC+uOlCSNDsizAi9E0gfQnnOKSzeIw8KoYpCO3DIJP?=
 =?iso-8859-1?Q?/mez2kngWK4cDo9NbeVega0vErEgmLq0V6U3lmph+cWxO+PHvoCkuuOKvs?=
 =?iso-8859-1?Q?VIyv3grjaFqCYy9FuA3H3BL84Ldz/lUN/bDupyxHJZb+prswRjn1K+Ldqi?=
 =?iso-8859-1?Q?O7jThQDt3icb1RMeSVw5Im2BNkl8eFQNtsW+UnyGcGAt29u8aTbRlQFJfj?=
 =?iso-8859-1?Q?0LhuzMAhklM3PkPEWsuqimooDGNbCVtYEbJmALoXhoETQI2EmcRCFZJTmQ?=
 =?iso-8859-1?Q?uTP/MKheUH1O2spgBxvgaJGa9LOwLCCAmdUR3d/pMxAI/EKPG9FuUMn2hZ?=
 =?iso-8859-1?Q?jLLV71ynNdFThZpa9uOqi7fIzN5kDNtWuGmoC80v9i6SMOcncS2nkZi6xm?=
 =?iso-8859-1?Q?sVCc99/x/QAxaqV3CsuBLXLLOmWv8UhIqaaa+U6aSGcpIFRsES3boFl55O?=
 =?iso-8859-1?Q?GcDSiR2FqwAI6yzZC43ksD/ptt62psm5i11LGj3NtGRqENW4eknG419lwh?=
 =?iso-8859-1?Q?YppLzX0jY1OzKucWcekEGUUFBl2cxUa9+tL9tfmOIQg/xo/GtI2EFAda9y?=
 =?iso-8859-1?Q?XCR4Jac6kFoiuk1egsl1LU1XKZNcnPjZzswk7XqaUPnaA6Z/oOXKS38+6T?=
 =?iso-8859-1?Q?rmK7Ph4bPGFq7/4R5vsYgwRYkUq+9Xg70EE0cgQebVbqmc6BmvbIPqLsbK?=
 =?iso-8859-1?Q?vKrt1p7/nkrOmd2h/BRVdTXwCTe0/UJJhxPVHyoKXvi3BMJofSQAiVyYE6?=
 =?iso-8859-1?Q?U3aD9TNUgPtSAPGb218Y9YHQDBZ7EO7jGLej2OZLyiMCaP7e8RIlQw3CDE?=
 =?iso-8859-1?Q?8b+VgvlYuxCwM1Ovl+8o5Fra7A4OpmyVvy8tFMdQZpyRdQ24WNULNnFdlh?=
 =?iso-8859-1?Q?7rWxCsO/6nwPYSa5AGgXx5MP/HCssYpaD2xvYJbUxrskDeGOVML63a5Tkg?=
 =?iso-8859-1?Q?V5wEYzmKNQTCccEK2uSnoqlGBuCXZZLXWa/3Hq7149RWGKRkV1sYArZb2n?=
 =?iso-8859-1?Q?SrxyLOY+jzNZgXWDVZ6cq2w3WLwOmfPl8f2VQ8ebRiPYE9WstFAVcTdK2I?=
 =?iso-8859-1?Q?LUHoBl4AQG3ep3S9eny5zsswn8nc9tBmjPetSWC+uXyoOLnAIsKVJ0R/Pe?=
 =?iso-8859-1?Q?vGFNFDD2lgjvHx67MmYXw/+b8GQdX9Sm7/2Q+T6gCS758hjekluFgsBKXr?=
 =?iso-8859-1?Q?FygfDmKOo5IaW8X1JnY/AjaUk7qTZs9vAS6favJL3kmznZSNST9Z9JNSjG?=
 =?iso-8859-1?Q?0PcFtvvcGVYT01dxKDgKO2Sa4SLvEVuBvRJ2CAArvRjd7WZJtr16n4gDbw?=
 =?iso-8859-1?Q?31lpV6ZAQJQyirFR+z+p/G1ublRNxupL8o97mqsyy/VffO5aSi6AbktnGo?=
 =?iso-8859-1?Q?uL9KQien9fET5+KWqTSHgwzMGWuXJea3OsIH4bSa6KVFbCqYxKXm04il29?=
 =?iso-8859-1?Q?afdbgIFnz0HkyunRLQEsOaPGEGvZtsbp/6+ZSjQuLueKp9P35kQDRLhzCW?=
 =?iso-8859-1?Q?w1c/uBh8IkIYoIwAOrfvcSdPi4L/o0amO8dygtLNBzxY2qw4AcySfppWxU?=
 =?iso-8859-1?Q?PVkcVDgKBathF/jXjWNdrP99Gr484IrRNlk9Mjqqb6mSLRtMhuqwJKzKu3?=
 =?iso-8859-1?Q?A2hUR/6iZHKvFdzwEZEbciuVB+phKnHrG6+3m7d9p7IP2PbSHdnMTaY1MA?=
 =?iso-8859-1?Q?TiSTnYR88AeYgGO8eP+KKc+tzdwbHcc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q6GeE0I/crYklTmnHxs8MmfnI3v7VGiv0YF4/3u2/PHEcsLcjL/bD8KX4cWpId0BpWz69r/orqTzje+rx4VBwcz6Wno7Nm1Ea0kJs1dg3TNHoCS/QzE+mPKiXS8qrsbbsXEO2VSdlLK1cT808BfZq91nfSHZkD/AUrF0vgi+d/bLWltfOggAJ70QfVKmOI3mTs4yKXuUZXK0SQNMNLaf4dtODR1QrBBFtttFETcERUOG6fkRC67xFuBhmiOBCpwlx41I169Con+HkAcCNqvq+otxkSnh/IMfiYuHcWGqWUvCw9b2IzUV9uR61feR1zKGVEzgNWEk1F1rfJYR+xVhEw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55ac8a1-1762-4600-9044-08df1d749afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 15:24:35.7021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32Xp4lriTOsGko+2aewDhCdmFRAgjSElPKREmilF8eVvLib2xaphbZBbB3SyuRjzQaNGy0L9T26tcsoVLZX4BLDiO65CxzArZ7G6dm88z1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8884
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MSBTYWx0ZWRfXzYQ5891V0kR7
 UGL6onxRxyJJ57pFrYFJMfYMcyY3Z2jO/crO3UXifnzkDlvOJHkBBcqFF3hionbdYOclo8xQGgT
 KNfmq+fIh9Sy5Qs9gx3oixwtmkr1d0U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MSBTYWx0ZWRfX6vgrSVf5R0T4
 nir71DWTenfb8QXTwZfIKLx4FAghIRn3vo2EPSGuIvyj6LRwL05ioonhRGBj8ivTvDzB3z+9kvK
 wfn0NSiIFEeFOiTzfQjyUcale6JUZFHnofLlkxCbbO+zImzDTT5s6VkQj58t80bGDbhX8HrvNlx
 dH7OUkO5fxUJaw6JyiUPG2tyGCTsLi1m6Lz+KHaPQlq0S9LyfNk4QpBe2lSbiOr+8zkGRCgjjy0
 0m27IjA6nTjYsvwBamV4NlzPxDqmIZI1T1e5kpo33G8y3kgYx0ORkOT8uaPUQuCJFj8O/XTyM9C
 rkGf3NF86v5dljrytbNW9O+dH4FEbcil1xMC9YBphImcQDRNPGDLymsKJGnz00ot8xzL1U8ajLu
 5spivLmp2eNq0x6X3iRyIO/eQlLKywswqYyNszPdg2zjVHEIQWqhrIPNRb2ZnnctcRfejW0rdMO
 iIf79+P0vrEGlE9WP1w==
X-Authority-Analysis: v=2.4 cv=SqMFe/O0 c=1 sm=1 tr=0 ts=6aba86b7 cx=c_pps
 a=SNRzDqNuYCMO/bT9QdJRMw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22 a=64Cc0HZtAAAA:8
 a=dcECTNVlaVxwar02G84A:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: oqte04CdEQbcBsnG6gnqRnThoppi-Ci8
X-Proofpoint-GUID: oqte04CdEQbcBsnG6gnqRnThoppi-Ci8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=david.vrabel@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

If an emulated PCIe endpoint has higher link speed or width=0A=
capabilities than the upstream port it is connected to, ensure that=0A=
the link status on both ends is consistent by using the link status=0A=
computed for the upstream port.=0A=
=0A=
If the PCIe endpoint is a passthrough device, the link status=0A=
continues to match the real status and consistent values requires the=0A=
emulated upstream port to be at least as capable as the endpoint.=0A=
=0A=
Signed-off-by: David Vrabel <david.vrabel@nutanix.com>=0A=
---=0A=
 hw/pci/pcie.c | 26 ++++++++++++++++++++++----=0A=
 1 file changed, 22 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c=0A=
index 42bcb9206d..bd00305ecc 100644=0A=
--- a/hw/pci/pcie.c=0A=
+++ b/hw/pci/pcie.c=0A=
@@ -169,18 +169,36 @@ void pcie_cap_fill_link_ep_usp(PCIDevice *dev, PCIExp=
LinkWidth width,=0A=
                                PCIExpLinkSpeed speed, bool flitmode)=0A=
 {=0A=
     uint8_t *exp_cap =3D dev->config + dev->exp.exp_cap;=0A=
+    PCIDevice *upstream;=0A=
 =0A=
     /*=0A=
-     * For an end point or USP need to set the current status as well=0A=
-     * as the capabilities.=0A=
+     * For an endpoint or USP, set Link Status as well as capabilities.=0A=
+     * Provisionally use this device's width/speed, then adopt the upstrea=
m=0A=
+     * port's values so both ends of an emulated link agree.  The upstream=
=0A=
+     * LNKSTA is already clamped to the negotiated link capabilities via=
=0A=
+     * pcie_sync_bridge_lnk().=0A=
      */=0A=
-    pci_long_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,=0A=
+    pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,=0A=
                                  PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW);=
=0A=
-    pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,=0A=
+    pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,=0A=
                                QEMU_PCI_EXP_LNKSTA_NLW(width) |=0A=
                                QEMU_PCI_EXP_LNKSTA_CLS(speed));=0A=
 =0A=
     pcie_cap_fill_lnk(exp_cap, width, speed, flitmode);=0A=
+=0A=
+    upstream =3D pci_bridge_get_device(pci_get_bus(dev));=0A=
+    if (upstream && pci_is_express_downstream_port(upstream)) {=0A=
+        uint8_t *up_exp =3D upstream->config + upstream->exp.exp_cap;=0A=
+        uint16_t lnksta;=0A=
+=0A=
+        pcie_sync_bridge_lnk(upstream);=0A=
+        lnksta =3D pci_get_word(up_exp + PCI_EXP_LNKSTA);=0A=
+        pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,=0A=
+                                     PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_N=
LW);=0A=
+        pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA,=0A=
+                                   lnksta & (PCI_EXP_LNKSTA_CLS |=0A=
+                                             PCI_EXP_LNKSTA_NLW));=0A=
+    }=0A=
 }=0A=
 =0A=
 static void pcie_cap_fill_slot_lnk(PCIDevice *dev)=0A=
-- =0A=
2.43.0=0A=
=0A=

