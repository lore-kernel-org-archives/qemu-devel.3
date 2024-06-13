Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB28C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 16:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHnFl-0003zV-KS; Thu, 13 Jun 2024 12:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tedwood@quicinc.com>)
 id 1sHlyn-0003jd-2j
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:03:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tedwood@quicinc.com>)
 id 1sHlyi-0003uW-7m
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:03:08 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DBApWX004228;
 Thu, 13 Jun 2024 15:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TVJ2V8YBpGWjirXtOsdv+2BUSJdz+EI5xtnZ7bDcIx8=; b=eyFe1ciGvRvZgwnV
 6rwEfT8OECDJZfAxewyrbOy8H/QhvbJRR2+EHUC8cbX+oaag+YGiBIkm8RAt2Pns
 4d+CAZ9xqm0ljTN9d+SGf3g+Sorozo2Vma9374qEHkaN6mSuulsb+LgH5e27topM
 7RuI+axQTet73cQCI2c82MbruYnNq0IkJqzMR9GxNN+PetMTV1DV3iZL8SVlE5zo
 Egc2pEGrS2MrWKXZhVXI+aE3c9PgudcXC9LirX0JJEtzfhpkEJwmgM7MpUzVgAjy
 pCQNKJi5UkLXGrugTuJNAE/C6UPMDmXPRso3JBH4GjVDIhqpSrbAy/H+AgRekgAy
 useauA==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqqn31x43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jun 2024 15:02:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSHmFTQqKJcsjAGQwxxWCl1+GEN9qlr0PPa/EIDmKYIqvtgL7N+tIcJyd06XpKIL22jdJnX5DmQ1STx2xJAz7aXylBQVtiyjc4kNMfjpluMMAuHT3mcEMeGMFdGcQpUG+CXBVKRysJIhFdw0nWyXaAh01H3OcNT0gv20f7gRoFlxdbfwIPmtYXVnam2sAw2YER/tr2wfUhpRkoFipRkr8qTaka9Nouy9KC6XdAb5zloxOqdCRUHKQKPUdvHkl9KbCOJHCrzVSdVd78pRvCxY2/FHNk5LbZmitQxh6147gmqpeAuB9YSGNbFcHB65uxIzAsMNGtSc1FVmNhqQwsUzZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVJ2V8YBpGWjirXtOsdv+2BUSJdz+EI5xtnZ7bDcIx8=;
 b=J+D0HEOxhx3qVJAQC4Cr+2tu427kjq/ELqwt43b47Kg3ZTy9V2lT1QM2Qa8CJiCSzkKTuxp+LDerpOgs2CyOHrurLrTW0Lb9lf0gxa1J6XMW1hB4Adn4kDslUrf+86FVTY2imz7SnWN7YGRvYD/ToVEfGV/GyLDAG6EWsJujagi947B7Dq8KzjeBz9QFrPmmzATZ/xuioQAoTN7mPKHoULMeTF/rL0PYNDJVl8fd0WyRqlWF4HMhd30jXB5A7GrApo2TW7JjX8n/+Ly/U5RvmgnxA3bwOGyBfjNY9p//mFE+s2Hiz4Smd+SLIzbJTbD0gCfezqu9Jd4YmSERhmUqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from PH0PR02MB8422.namprd02.prod.outlook.com (2603:10b6:510:10f::13)
 by DS0PR02MB9247.namprd02.prod.outlook.com (2603:10b6:8:134::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 15:02:38 +0000
Received: from PH0PR02MB8422.namprd02.prod.outlook.com
 ([fe80::c1cb:a3c8:661c:8ea8]) by PH0PR02MB8422.namprd02.prod.outlook.com
 ([fe80::c1cb:a3c8:661c:8ea8%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 15:02:38 +0000
From: Ted Woodward <tedwood@quicinc.com>
To: "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>, "Matheus Bernardino
 (QUIC)" <quic_mathbern@quicinc.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Brian Cain
 <bcain@quicinc.com>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>, Sid
 Manning <sidneym@quicinc.com>, "Marco Liebel (QUIC)"
 <quic_mliebel@quicinc.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "ale@rev.ng" <ale@rev.ng>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: RE: [PATCH] Hexagon: lldb read/write predicate registers p0/p1/p2/p3
Thread-Topic: [PATCH] Hexagon: lldb read/write predicate registers p0/p1/p2/p3
Thread-Index: AQHavOeYspDfy4vbzE2hbivxnJt5fLHEc0sAgACLTACAAMqF8A==
Date: Thu, 13 Jun 2024 15:02:38 +0000
Message-ID: <PH0PR02MB842235CD70F3B06BB27FA447B9C12@PH0PR02MB8422.namprd02.prod.outlook.com>
References: <20240612164239.90276-1-ltaylorsimpson@gmail.com>
 <20240612183008.4123155-1-quic_mathbern@quicinc.com>
 <066c01dabd3c$343be980$9cb3bc80$@gmail.com>
In-Reply-To: <066c01dabd3c$343be980$9cb3bc80$@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR02MB8422:EE_|DS0PR02MB9247:EE_
x-ms-office365-filtering-correlation-id: 971e7e55-e134-4e5c-20a9-08dc8bb9dd94
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230035|1800799019|366011|376009|38070700013;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ro1Vkx39h5fZAaOfIdAz0hpaPcRrGVsR21Ui23+ITM9iANw9ahO6cIFvOim0?=
 =?us-ascii?Q?4d+P7OqMbFNxXrlQWNH5AYb6fTMadWk7WAj/d9rgmskGE+VfrMfKnVtgLD+9?=
 =?us-ascii?Q?Su6/ZSImX568tM8NZwPwrVO+p4fhDjPdb75rW+MZnPUB4H+BonGhxNDoyXeI?=
 =?us-ascii?Q?8vAaEIYkL2DQI/stxmnWlBPJ0BR5h6XXaqDMt5D1bg+HrkLg7MDshfCXjAxn?=
 =?us-ascii?Q?5lVyI4IywOYyVhct1//jXTRJbRlXLn4WyPcEt8KpsAoTjW0lxCEbcLZf1oS3?=
 =?us-ascii?Q?xhbV26VkVWYTUWBhe/NuEk3cxDsNsOgM7Te2Rk+eYdCPP87cM94skNYhK7Z8?=
 =?us-ascii?Q?qbZoGOXtssudY76A/06e9s5IdV7eBM/xRVcRvWAAPxumrb7Zg01nut2/V/vJ?=
 =?us-ascii?Q?IqvQo8GZL5uvCMdDicJQdH5J0h3pGFjTJyqORi9WiIxc3IowONidXPtcewoc?=
 =?us-ascii?Q?Aoax95vtexMCJlTyLB9/TwA7sm3uaXzYT3e1BHV9t/+zaLbDbxGbMuXXe8Me?=
 =?us-ascii?Q?SbSMSuhs28eXPVuUT1rWDqHTX4O3uzkm3I3tDVSg7S9Br0LnWJ/UDvSTA3Gd?=
 =?us-ascii?Q?IHNX+amP+JgzrUdnNKXsYCgPDttaAEJW5Ihfbc+jN+CmL0WQHMby6tx7R0QP?=
 =?us-ascii?Q?PFO37ig5pNgIcqxlQDsErvOvmtLUxTKyr9OnZ9VEGTwG+alzbe8nP3pnV5yJ?=
 =?us-ascii?Q?B1gtddYfA3Y5LJMmMz826XXgB4jbzgF9Ot49t1W69yCgjVi0R5/iK9MxIJTl?=
 =?us-ascii?Q?8m5Lr39LFbE9sjzjy8W5HQ/TKwqTJz4rHbfSIxGdzHX10zIq2OkRJUZqNdc9?=
 =?us-ascii?Q?7kd6tJWc5Ke1+r1LJHJloAMayZ2MgV0fCh54wnw3XaZVd+QUjxNmnZ/7fSKo?=
 =?us-ascii?Q?45mv/W1ERYo5jsOHXj5t3DFxmm0OCW8/Y7/Oeia6ADA6z4XMQt4K/ohLf1u/?=
 =?us-ascii?Q?gkUba/SGJiHR1hvR490XlxDzdJa2R7MRJH03Tju/E7oelWGyPgGKdwMwR2pX?=
 =?us-ascii?Q?BKyREGcEayE/BQ3TrSWTa0RETAyvKHnn04XeUeFsQkOrWV5OHvRTkPbF+0Nc?=
 =?us-ascii?Q?uXV7V3RHFS8pocDNJvLlSRJ8YPZTxX8/eZxc2s7M1xCcTSCKGLcBEwteEzeR?=
 =?us-ascii?Q?fFUxgILz7y/8Wb1/oNMyo/sug0WcwH15yTEb3LoZ3Vl9efXJthSTr2s12jPy?=
 =?us-ascii?Q?nOh33xjb8qFB4RUWq0QEwSrmb8bH5QnjD9Xsv14zuWeDyZTfuIVycdvXcKbF?=
 =?us-ascii?Q?aLO4Uiql4Pg0PRMaoN5L4FV2li9FriquSaSEJbaRsSiQU2szLOLatpqwjIvM?=
 =?us-ascii?Q?2crnMcmeh03P0PJ/BwmKIjaUesobWJCHanVtpFhRZreQMLHvXyoE+vETZBke?=
 =?us-ascii?Q?sZuZhmk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB8422.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230035)(1800799019)(366011)(376009)(38070700013); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mEm0B15kPkeAmY9IkqXKfha5xmNyMNZS2PIrhqQxT6mK5v1qTWu8Cn9ipBc9?=
 =?us-ascii?Q?ZW01/XmxGBPTmBp8W6NJYX/qHN41bEmNW5JMH/AREeRnvrYkOl0s5gW4B812?=
 =?us-ascii?Q?5y61LHlOs+XhGbI4gVOuHH8566erv1S4/uFQwgYbz/DK1oKoLZt/Y3wdAvqq?=
 =?us-ascii?Q?O6SHAoegiMHprSOIIu5p2qHH3eYQKbetq7sVpum9XI7dU5S5kglDmaZ7eHMy?=
 =?us-ascii?Q?gKO3YAqWcX7GmhKhhwnneYlqzkLXQTa+BXrhPOx6otQel/h86TP1nFj70rM4?=
 =?us-ascii?Q?iH5y2m2E6O82XCDzVxx5JvKNP/4YE+I0iTf8eoxLYIaMSGL7RPdNDZGurdgS?=
 =?us-ascii?Q?JSZOYfeTvg54X3Qn9+SwT/MxXKsLsmFVvHtwWePuBvyjNjKbpA81NBfZeUdz?=
 =?us-ascii?Q?1IOY9jAnD2+uxanCoIWn9hHsthi8nqZRlo8xnMSbBZC1WU11b99NVpJz5Zlj?=
 =?us-ascii?Q?aDoiUzmN9+AWII9ywkZQRBf6IAHLEefo/aAlCNfSA9CHZ/BrUyELKXEXyWVO?=
 =?us-ascii?Q?gCpxPdtOaczmcetHdyleNDigbWJxztExuXWDxMnAPJNQx5Q6r6JkozUbzLpR?=
 =?us-ascii?Q?CUYft3uItVm7TUxeUVqwpu3IhXzLEUDsco/4b0X4z5W9G95LKpG48KcZ/Vau?=
 =?us-ascii?Q?9cRtyECEXiusp9z3wMtIoqyYlK4M1C6jGlyTWVxSPRXLhtK8hOcsOdlBcEfj?=
 =?us-ascii?Q?aV52yx8aAEGRJ0CkjYFF0FFd4kESslNMKaXceVpyAywwQrf1to+RKsDYe27Z?=
 =?us-ascii?Q?W2OO6FHoVcRWOYCuVDstag9oNtqHLeCAk8NHPh1PV/iVV/SRIPa4jeYJUG7L?=
 =?us-ascii?Q?Ujv7RlRfp6lOHEj9df4YDb+fpVNaEMVCYZkhGwJcM6l/lKEgB44vWYqEOpzf?=
 =?us-ascii?Q?4CVIlIUIy8CzBI4WN4w2srL6VLdoJOjq6Pc6O3nST0Cha4kOBADogYthitxY?=
 =?us-ascii?Q?bT+L67Huyw6dtSPw9gJpvxowxMlwP7gQ10rGvs3LwC89Z/jFy4KqG45abSMB?=
 =?us-ascii?Q?5ZEhQKMbkdew7cMjGK1jYn0rhcV9SGYIlXNc1lf+gs9PllbNMypnwsKACURi?=
 =?us-ascii?Q?F6DlMc+M3d8IIF1QO8qjS99FhOv1U9Nz5KCtLvgGJc7+vizGVQ6Lgu2gKEnj?=
 =?us-ascii?Q?QI//EIHZO3CPxKp4gVKTLS/2Xfe7743uU8ZE0Zjbj1PnZZeiV9EJQngujigh?=
 =?us-ascii?Q?friFuOEzJHUJ7c3RTuiXhKO4VnGnvexDiNE/QLRmSP+s2pol40X9iSX/JtY5?=
 =?us-ascii?Q?As7T/B6u6/3u/HkWXVQGsepc0IUFLPC2ZDRrS3qCt62P4FNYDQcvhYU7Ibx0?=
 =?us-ascii?Q?xlQLdnh81x+4BaUm76WIINHe8FX19bApSeKE8xLkcgbBaAHhpXzsCym2fr3M?=
 =?us-ascii?Q?pEi59qZsKlfD8LmQ5L2d2/H3pYqBwBqb9tFti1CM8j/O363PHB1I3pj2mC9w?=
 =?us-ascii?Q?BshOnZX/32XpLM2vJuGpJtpy9bvJ/jOoIwRO7pRJM3ah7HcVJsk0wGojpHov?=
 =?us-ascii?Q?ofc61hnH6zSVB6d8/k0PVoZKWbN9tFBtr21/hRoXFdNBNOHBykJB/xSJBZhm?=
 =?us-ascii?Q?W8E/mMEISIPgxxQMhNnAKn4jiAMTDiKxs+TPD2sG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Obl1nknFEo2Rkv5ocsFtLrsJyuKaZvO2TNIes2he+n8grZUdPsQL2Byi82CxIxCL+S0ZXXFxNxFUwWKOGf2CHVqUr6JPdezGQ2KPenlqKsVug8HQQCafMOhN+y6jQ5+0LInLMb7JX1cAPw6c1Q8rxnLHudxpSAOnHPkJqUF4QxbY9U6zRZyNcj5KqS1ax52S3GGV8AFU9GQjb9K7xJ6ds3lmE+0OvA1RxrhBmsWAkvaGEB1CF9b0KUL8g4er0+HK4LFxd5vnH8rM/EqABN29+KScT+rBXQPUm1Z7hGym3UeQfqUKoslJueWdDB0eYhrPkMODy3DEEQZEzK2A2iNiPZs9jVI3hVl+oUTDWS5QwjKRCetwNAA1xUDYVwgP8bPLhk+JSCO1gG2HLqlihbzxqvFUYmLjwbj4aYGOJaypLVOlW4G+HkL5p2ZPbVw/kITxHwa4zYRzR7QmjqgqqP+7trmNj3o9qjTNtLCHKx5qYfVnwtoaYcVg60lLn/NKpmmNR2M+v652aMYRXNgNfNPf++ydtKF0pv6U3E1Ful+Wkgy1FFpSXkU31EZ3gn9WVWOe7GFtBRZ0K6Iuy47KAOl9QNjSOsU0SbtctSXdV8l6Q8u8MrQGBSmnGy4oQfD7TT3T
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB8422.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971e7e55-e134-4e5c-20a9-08dc8bb9dd94
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 15:02:38.2061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5xDI3PkfGQBbhiGzt7XY7JRPJ1Arzd23YQ1i8TMDYiP+RnFWaN6pzuMOA4JpXcnvHUXUXgwgkp2c35OGx/OrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9247
X-Proofpoint-GUID: MgcUMuxK0N9WtSiF1rdmjz2dZ21DyGbS
X-Proofpoint-ORIG-GUID: MgcUMuxK0N9WtSiF1rdmjz2dZ21DyGbS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_08,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130110
Received-SPF: pass client-ip=205.220.180.131; envelope-from=tedwood@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 13 Jun 2024 12:24:34 -0400
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



> -----Original Message-----
> From: ltaylorsimpson@gmail.com <ltaylorsimpson@gmail.com>
> Sent: Wednesday, June 12, 2024 9:49 PM
> To: Matheus Bernardino (QUIC) <quic_mathbern@quicinc.com>
> Cc: qemu-devel@nongnu.org; Brian Cain <bcain@quicinc.com>; Ted
> Woodward <tedwood@quicinc.com>; alex.bennee@linaro.org; Sid Manning
> <sidneym@quicinc.com>; Marco Liebel (QUIC) <quic_mliebel@quicinc.com>;
> richard.henderson@linaro.org; philmd@linaro.org; ale@rev.ng; anjo@rev.ng
> Subject: RE: [PATCH] Hexagon: lldb read/write predicate registers
> p0/p1/p2/p3
>=20
> > -----Original Message-----
> > From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> > Sent: Wednesday, June 12, 2024 12:30 PM
> > To: ltaylorsimpson@gmail.com
> > Cc: qemu-devel@nongnu.org; bcain@quicinc.com; tedwood@quicinc.com;
> > alex.bennee@linaro.org; quic_mathbern@quicinc.com;
> > sidneym@quicinc.com; quic_mliebel@quicinc.com;
> > richard.henderson@linaro.org; philmd@linaro.org; ale@rev.ng;
> > anjo@rev.ng
> > Subject: Re: [PATCH] Hexagon: lldb read/write predicate registers
> > p0/p1/p2/p3
> >
> > On Wed, 12 Jun 2024 10:42:39 -0600 Taylor Simpson
> > <ltaylorsimpson@gmail.com> wrote:
> > >
> > > diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
> > > index
> > > 502c6987f0..e67e627fc9 100644
> > > --- a/target/hexagon/gdbstub.c
> > > +++ b/target/hexagon/gdbstub.c
> > > @@ -56,6 +64,15 @@ int hexagon_gdb_write_register(CPUState *cs,
> > uint8_t *mem_buf, int n)
> > >          return sizeof(target_ulong);
> > >      }
> > >
> > > +    n -=3D TOTAL_PER_THREAD_REGS;
> > > +
> > > +    if (n < NUM_PREGS) {
> > > +        env->pred[n] =3D ldtul_p(mem_buf);
> > > +        return sizeof(uint8_t);
> >
> > I wonder, shouldn't this be sizeof(target_ulong) since we wrote a
> > target_ulong?
>=20
> Good question.
>=20
> From the architecture point of view, predicates are 8 bits (Section 2.2.5=
 of the
> v73 Hexagon PRM).  However, we model them in QEMU as target_ulong
> because TCG variables must be either 32 bits or 64 bits.  There isn't an =
option
> for 8 bits.  Whenever we write to a predicate, do "and" with 0xff first t=
o ensure
> there are only 8 bits written (see gen_log_pred_write in
> target/hexagon/genptr.c).
>=20
> I did some more digging and here is what I found:
> - Since we have bitsize=3D"8" in hexagon-core.xml, lldb will reject any a=
ttempt to
> write something larger.
>   (lldb) reg write p1 0x1ff
>   error: Failed to write register 'p1' with value '0x1ff': value 0x1ff is=
 too large to
> fit in a 1 byte unsigned integer value
> - For the lldb "reg write" command, the return value from
> hexagon_gdb_write_register isn't used.
> - The only place the return value is used is in handle_write_all_regs.  T=
his
> function is called in response to a "G" packet from the debugger.  I don'=
t know
> if/when lldb uses this packet, but it seems like it would count on it bei=
ng 8 bits
> since that's what is in hexagon-core.xml.
>=20
> Ted <tedwood@quicinc.com>, when would lldb generate a "G" packet, and
> what assumptions will it make about the size of predicate registers?

When you use the expression parser to call a function, lldb will save the c=
urrent state,
set up the function call, set a breakpoint on a return (by changing the lr =
register and setting
a breakpoint on the new address), set the PC to the function address, and r=
esume. After the
breakpoint is hit, lldb will restore the saved state.

Since QEMU doesn't support the lldb RSP extension QSaveRegisterState/QResto=
reRegisterState,
lldb will use G/g packets to save and restore the register state.

lldb doesn't interpret the values from the G/g packets. It just saves and r=
estores them, so I don't
think the new predicate definitions will matter for that. You can test this=
 out by changing the
predicate registers, then calling a function with the expression parser. No=
t a varargs function,
since the IR interpreter doesn't handle those.

Ted

> Thanks,
> Taylor
>=20
>=20


