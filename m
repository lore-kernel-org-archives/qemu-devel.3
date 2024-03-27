Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D1EC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 14:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpUPy-0003tN-Au; Wed, 27 Mar 2024 10:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=78160ec3c5=aidan_leuck@selinc.com>)
 id 1rpUPv-0003tB-QK
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:38:15 -0400
Received: from mx0b-000e8d01.pphosted.com ([148.163.143.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=78160ec3c5=aidan_leuck@selinc.com>)
 id 1rpUPs-0005Mh-Nx
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:38:15 -0400
Received: from pps.filterd (m0136174.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42RCoBvu011610; Wed, 27 Mar 2024 07:38:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=sel1;
 bh=z5ChE/gwXrOAPkbrQYyL0KabIiX3M01LRP4AGUjmAxM=; b=c3ZbOqbojgRT
 Yvl0t1mMdLC/bbZyhbPJEPhdnwQQ1vSsiqnuw1d71e90GX702N1ZtPb4t5xSMTWX
 4jZzF0Mu3yfNvxVaRewIubCzTMEiMD3x0JIUtKpKaVTSDuSN1dAjXvHWWGPLxw5n
 ScJrGJHPqsWE8JRd2HGhnssYv04uZA02xPD3kN4j33iDe3jgkPSHoidSUUXll7RA
 PgqrCMK/4O5R2etNm8N02vronSuVXy5xPG7zEV+ut4eEVANbjhQxdUjMuBjEo9gk
 XF+LvcjEYlSzHm6C2RINsZe5grtlHVUyF4aOUBkEeUAYTIylrem5ZxtHQEXnGPzy
 F7749Y3hUg==
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x41928puh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2024 07:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLgXpV0lsVJne4FKGnSsjECVAIA0kgDfflYGFDkjIi2llc6uPcLweb8QPI9EenZjosLhgUz+aCyQQRFGs2sGXvpM97T4e83AHObteKhyEd/5v8swt+H+TUdyNG1DBkHWrwwlANSIBGGzUhwU2jIp5ZcoZLryLRW23OQ89tljGMirRzBipv6m+WDXV1sehrtZese7hFLGLDURMTg2KavkoFc1/o0T6TV5an//33LjNGJ5H9Vr9MNp1x9j9H5u5Is6BlRXp6so9jZbDnkd0Bb5BE09KlW7KGy817LswBPP36XdCKj2LydxrDOI4QEihwgWldGagT2fwezC1PZCJ7z3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5ChE/gwXrOAPkbrQYyL0KabIiX3M01LRP4AGUjmAxM=;
 b=JdKu0PUuh20C9Ed04VWNe1iBitnSxm4uvXVoWgzlbCp5fbeL4zCN34jqZYOPCz6+VeBUsnIiQC0keZiAK7WrpqawcKRbqkKyp0grNWXkW3Q6AM7tv2IH8DYxtuQLfAGvdHrMjAKLCCyhEp4FZr49U/fujEKcVvbb6AdkZyaCo6KBSSM8fEDgdntYreNcGbwv/c6aupDFZuwqeg/50Q0DcUUn86fizT0LnPsPbsDpqC4TuvyvUAGzpRtPEXJqo7i7eYe5KToqTxDNtPKqQDC6Mx3ILbP8WueFqumouDCedWizu0+Z4wKJfRm6CiMnaibmmHk+AzfoFLET0ms2uCPOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=selinc.com; dmarc=pass action=none header.from=selinc.com;
 dkim=pass header.d=selinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5ChE/gwXrOAPkbrQYyL0KabIiX3M01LRP4AGUjmAxM=;
 b=XkNIf2GHrJuA3/+W5tUjBKLuvS1xUFJVV4eSix/riqxcpUsLu9Jw1Iwn+LJ6FSGD8I6QG619/T9GwqcmEGRgdLq0XyPbyN0f2CgKdVGk7ZzlV6ADNPRGXhNaTY0+YZU/BrQD50VOToi0yV/tNN2NBQWYR/qZtOVRWdMqxzNhi2yqgL9L2kZ9UFyJ6tEo0Ez6Ea+dPk2+67FV795D9dj8M9WFBZcmjgcZ6iU7ib/h6Hs6cwXmYvijgg+NuXRNF/w0h6Gn9UDPzt3eSCA/T+1VSDfhXorzQ26rqSXEHW83ygNaVBH79Gz7lzeZ5CPII4EFl4nh/wbbGq5ylGc8y6M35A==
Received: from LV8PR22MB4551.namprd22.prod.outlook.com (2603:10b6:408:191::9)
 by SN7PR22MB3833.namprd22.prod.outlook.com (2603:10b6:806:35b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 14:38:05 +0000
Received: from LV8PR22MB4551.namprd22.prod.outlook.com
 ([fe80::4699:3244:6e1f:3d0]) by LV8PR22MB4551.namprd22.prod.outlook.com
 ([fe80::4699:3244:6e1f:3d0%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 14:38:05 +0000
From: Aidan Leuck <aidan_leuck@selinc.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "kkostiuk@redhat.com" <kkostiuk@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>
Subject: RE: [PATCH v3 2/2] Implement SSH commands in QEMU GA for Windows
Thread-Topic: [PATCH v3 2/2] Implement SSH commands in QEMU GA for Windows
Thread-Index: AQHafID/9gwWMd1Nv0WEOcKrxrIAc7FIwNoAgALuMeA=
Date: Wed, 27 Mar 2024 14:38:05 +0000
Message-ID: <LV8PR22MB455124393BD875586CBDBEE7E3342@LV8PR22MB4551.namprd22.prod.outlook.com>
References: <20240322174637.499113-1-aidan_leuck@selinc.com>
 <20240322174637.499113-3-aidan_leuck@selinc.com>
 <330d90fc-e5ff-4b7d-a01f-5587274a5f2a@linaro.org>
In-Reply-To: <330d90fc-e5ff-4b7d-a01f-5587274a5f2a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR22MB4551:EE_|SN7PR22MB3833:EE_
x-ms-office365-filtering-correlation-id: 2add2b27-7cf9-4bf7-87e4-08dc4e6b836d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7G/cAehNaBrMkpzka9l/k0iD03IxK4dZc5RpZkmX7Nj+V7KKeOw8P1EQkhhc1IxBAw6b0GpFFhFLmgApie4JUM3vJpxg52xud1/Pxwi3hhfazXM6XB60qZdSe+AYu1ERVBwRC8D62xSqLuB5jljW7qcCApFcBr49NbIcEPmCksnlWS9cBvFI8Ejm6/s/Jl9V19/bT38CpUF5aI7UdLhmXRkK+x02OCqaLF51qSRdQx0937CnJKIR+YQPfzVpumVP1TzZgF3FrRyo/k8mZOQAb8UPSfPZMYXx/XXn1/8QTBf23KyI/kfRsxo2IM+70RKkoOkYCUzKf60Z+csCse3DEg5SxwCCIb+96kbIBZmwrlEhFUIAK4ENV1ln959Ibbaf6TgzWzgPdE2Ug0fJrABb7TZrGC/W0qaT5PWWkOaIo6yXALCpCQnpWAF7i3dUQZWXU/hBd6dnD+dRr2g/I0f+McpiAClZknB+bM9DL6h7mzjguMTTWCovGDWv+70YMC/+bYYL2beWDRs4fjZKajtgd8jAxUY/T5kgWtLejurV5ye+n6Kjnwqk+bfWqp5G+JdfoSYtsAy7SPFZWI1K+frqZVUmTe2XrRYP354FPy/Keer4KtBNAYbF3H/bW821ZB6d4zyOXpYZzN/4vIpz7xHiEq60JEnHiBQVaAwdUOjqt6j/n6pE5jvBhXkwU/qJsVDFMKmrJLUvnfhLY/iBuj1sNmNXHN+txFUG8cwK1ohvjsQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR22MB4551.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG1HZkxOYmxJajRwZ3Z0WnYzNStWYzRUbFlhSVp6UGp5RmNyR2UyYytTMlhh?=
 =?utf-8?B?andyZGlOQ3ZjZGR3NUtmVG1xVjlidmZ2TUpuVXhMUVpmRC9nUm9hb3JzbWZD?=
 =?utf-8?B?NkFidG81Qldya1dVUWR3bWN6V294eENJUVg1Tkh6N2puNVdCNk1DbUlSbGdQ?=
 =?utf-8?B?YVRzRjBXWERVTWFURkFSS0taZHg5MFFDMEhnbmdxbm5JYWJLOXFTT1k1a3Zt?=
 =?utf-8?B?RHE4TWc2Qk56TCtXUk5zcGpycjdsMExWeGhTYnBScXEvdG9zc1YvRm5IcUxX?=
 =?utf-8?B?ZitOYTNER3d4YW90OEljYjJEb3VGZS9WNEF6d3AyM3pHUHhWNHBKeWNCNDUy?=
 =?utf-8?B?NEUwOUN2cys1N09wOHV4UWN0d3JZejVhNUJKSzd6bnZpWlRwbS9xUHlOa0Fo?=
 =?utf-8?B?eW9TV21vTzNXNEo3Z29Tb25KcGpMRWZUTzRKK1NPaExTcXMwYnFYYzNpTlFi?=
 =?utf-8?B?VVlsUjROUFBJVmoveE5iODFZMTBSamo0c3RDT21wQlJzRllpM0x5dXo3S0RO?=
 =?utf-8?B?cHRuRlRDK3U3S1dWMW0xcFh6ZWwxL2ovKzJRMDQ0eHpTajcrMGlJbHhMZnZh?=
 =?utf-8?B?dWppNG5aU3ZZb0pEdkhNNnFZY0x5eW5IY2hueFJYSmZJZllkZldmQTIvMzZn?=
 =?utf-8?B?Tm1FWWxJRldqdFFhbDF6bVZpRXZBNmEyTk5QSzFqQlFFMlRQcTVnY1l0RHIv?=
 =?utf-8?B?OG5sMHJ5NitEdlJMMVlVYVhmTFlYQmNMZ21NRUt2MDhNekI1NlNSMjJiaDlL?=
 =?utf-8?B?WGdDL1FqUmo5WWNBdVlvM01GcHhDeEZBMlNuclNHRnYzNHVOTkdrMjZhcFhZ?=
 =?utf-8?B?NU9OZTA4WWlOZ2pyN0pINEdMOFZJMk9Ma01JUDJzMlMrTHpUcDJZbGNESjVn?=
 =?utf-8?B?bDI4WjZWV2h5K3gxU2NaQUxBMXpGbHFjczJwS29sUExZRVA0S1Q4WFVNNTg1?=
 =?utf-8?B?RmxDVWZscHhqRTI0TzFqM0lyYzFVSkNTRHdRZytDUHFtaWkyNzE0cllvY2pa?=
 =?utf-8?B?bk8rYkFXaXJPY3dLbDRhaGRHU1Jha2JoUG1aa0tNQXFSbEdhWU1TYVExTW1Z?=
 =?utf-8?B?WlhlWFI2WDRrOHVET2tTQXZpeDlGb0FhOE9tM3h4OUhVZ2RVd3ROUnBkaU9t?=
 =?utf-8?B?K0JUN201WTNVOFVDdjY1akJ3Y09Fa0hFZTdUenRwelk3Zm1VdHNjak1HaGxF?=
 =?utf-8?B?ZFlSSVdqSy9xdHNpTC9TZ3BpK2dhb0NVUGNzcEpTWkF3d0F3YlQxdXRuSDRU?=
 =?utf-8?B?K0dKYUxwaWEwRHE3aFFEdUpnODZ6QmY1NVhyWjl3YTFLenYyNzYrY09WMVN6?=
 =?utf-8?B?ZlBNaTgxV1k2Yys2QmZoSUNBVjIrbWQrSU90K2tJMGJjRFJ0WGxsNnRQQlRu?=
 =?utf-8?B?QWFrZVZRTXZvcW5qT3M5UXNObHUwTS9TT3p5YnZvc05jS1VrZ3FWQWdrNUNQ?=
 =?utf-8?B?eEFDd2ZraFg2UXVVdkY2TnpHampqbHhidEdLU21sNUY2akV6aVdZdjJ6cElP?=
 =?utf-8?B?QXRoL2wrRUFOVy9sZHI0UkhDRitzdjFGQUluMVlwK3l5R250djhFT0VnNVBp?=
 =?utf-8?B?T3RIMU1uWTFIV1hvbmZtV3dWSmFiTm9qV3ZaM0tMVktoSjNyNXN1ZlRmQXR4?=
 =?utf-8?B?eUZsOWk1cVhOcGREbjZBeW5sNHRCT09zODlHenpBeWp4OFB6WkhBUlRWSU5o?=
 =?utf-8?B?UHcyWTZwbVNNTks1eWF1Wnd1dWE2aGU3eUtONmdSSWtDMCtnN1REekloS2ts?=
 =?utf-8?B?ZzBuT3R4bkw4SDF0L2paeDA2UHJiencwaTFtVktKZSsvVWhQTWNWUzVCM2Ju?=
 =?utf-8?B?ZjMxSXhka0ZHQTNOaU5YWnhWaXRQQ3l3NW5xTEtKckhndmJCZTl2Z25GdlZZ?=
 =?utf-8?B?S2VJSW5SQ2FvTy9VVGtZZlJMVjlaY2pmWUs5KzRwVG5zS2o0bnczWVJhNFAv?=
 =?utf-8?B?YXJSQnU4TmJiTjRUd2NiL3A1L2Y2SkJUR1FlL20vQUlldXBFeExPYVI3cHZv?=
 =?utf-8?B?NElwcDVMaUg1RzVjVndUUWVBOVhwb2Zac2MwL0l3VHprZlJlR0I2eERxZHlu?=
 =?utf-8?B?UDRaRkV0TE5oVjY4Z0ZZRy94WTdYRlJ6MlNFcGFZUU5keUNzd1J2QjJBOGxn?=
 =?utf-8?Q?m1N9RDVE9ZNXxkyXMgzV2KBnh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR22MB4551.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2add2b27-7cf9-4bf7-87e4-08dc4e6b836d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 14:38:05.3051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RWx3vy89+rB9Ow+MJhj5M97S5kzDmYOalXG7XlGYLC+jT4VIZGJ1KafhvJwZpwFZ6jHKSpDNeBGEzWY3NVFCiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR22MB3833
X-Proofpoint-ORIG-GUID: Yco_J02UTOgPlDNjOD6gAxyTqWEmHCfP
X-Proofpoint-GUID: Yco_J02UTOgPlDNjOD6gAxyTqWEmHCfP
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 clxscore=1011 mlxlogscore=999
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270099
Received-SPF: pass client-ip=148.163.143.141;
 envelope-from=prvs=78160ec3c5=aidan_leuck@selinc.com;
 helo=mx0b-000e8d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgUGhpbGlwcGUsIA0KVGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrIEkgd2lsbCBnZXQgdGhl
c2UgaXNzdWVzIGFkZHJlc3NlZC4gSSBsZWZ0IG9uZSBzbWFsbCBjb21tZW50IG9uIHRoZSBRQVBJ
IHNjaGVtYSBKU09OLg0KDQpBaWRhbiBMZXVjaw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPiANClNl
bnQ6IE1vbmRheSwgTWFyY2ggMjUsIDIwMjQgMTE6NTEgQU0NClRvOiBBaWRhbiBMZXVjayA8YWlk
YW5fbGV1Y2tAc2VsaW5jLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KQ2M6IGtrb3N0aXVr
QHJlZGhhdC5jb207IGJlcnJhbmdlQHJlZGhhdC5jb20NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMg
Mi8yXSBJbXBsZW1lbnQgU1NIIGNvbW1hbmRzIGluIFFFTVUgR0EgZm9yIFdpbmRvd3MNCg0KW0Nh
dXRpb24gLSBFeHRlcm5hbF0NCg0KT24gMjIvMy8yNCAxODo0NiwgYWlkYW5fbGV1Y2tAc2VsaW5j
LmNvbSB3cm90ZToNCj4gRnJvbTogQWlkYW4gTGV1Y2sgPGFpZGFuX2xldWNrQHNlbGluYy5jb20+
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFpZGFuIExldWNrIDxhaWRhbl9sZXVja0BzZWxpbmMuY29t
Pg0KPiAtLS0NCj4gICBxZ2EvY29tbWFuZHMtd2luZG93cy1zc2guYyB8IDc5MSANCj4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KDQpIdWdlIGZpbGUsIEknbSBza2lwcGlu
ZyBpdC4NCg0KPiAgIHFnYS9jb21tYW5kcy13aW5kb3dzLXNzaC5oIHwgIDI2ICsrDQo+ICAgcWdh
L21lc29uLmJ1aWxkICAgICAgICAgICAgfCAgIDUgKy0NCj4gICBxZ2EvcWFwaS1zY2hlbWEuanNv
biAgICAgICB8ICAxNyArLQ0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgODI4IGluc2VydGlvbnMoKyks
IDExIGRlbGV0aW9ucygtKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBxZ2EvY29tbWFuZHMtd2lu
ZG93cy1zc2guYw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBxZ2EvY29tbWFuZHMtd2luZG93cy1z
c2guaA0KDQoNCj4gZGlmZiAtLWdpdCBhL3FnYS9xYXBpLXNjaGVtYS5qc29uIGIvcWdhL3FhcGkt
c2NoZW1hLmpzb24gaW5kZXggDQo+IDk1NTRiNTY2YTcuLmE2NGE2ZDkxY2YgMTAwNjQ0DQo+IC0t
LSBhL3FnYS9xYXBpLXNjaGVtYS5qc29uDQo+ICsrKyBiL3FnYS9xYXBpLXNjaGVtYS5qc29uDQo+
IEBAIC0xNTYyLDkgKzE1NjIsOCBAQA0KPiAgIHsgJ3N0cnVjdCc6ICdHdWVzdEF1dGhvcml6ZWRL
ZXlzJywNCj4gICAgICdkYXRhJzogew0KPiAgICAgICAgICdrZXlzJzogWydzdHInXQ0KPiAtICB9
LA0KPiAtICAnaWYnOiAnQ09ORklHX1BPU0lYJyB9DQo+IC0NCg0KRm9yIFdpbmRvd3MgeW91IGhh
dmUgdG8gY2hlY2sgdGhlIENPTkZJR19XSU4zMiBkZWZpbml0aW9uLCBzbyB5b3Ugd2FudDoNCg0K
SSBkb24ndCB0aGluayB0aGlzIGlzIG5lY2Vzc2FyeSwgdGhlIFFFTVUgZ3Vlc3QgYWdlbnQgaXMg
Y29tcGlsZWQgZm9yIG9ubHkgUE9TSVggYW5kIFdpbmRvd3MuIEkgZG9uJ3Qgc2VlIHRoaXMgcGF0
dGVybiBiZWluZyB1c2VkIGVsc2V3aGVyZSBpbiB0aGUgcWFwaSBzY2hlbWEgZmlsZS4gSSB3b3Vs
ZCBiZSBpbnRlcmVzdGVkIGluIHdoYXQgdGhlIG1haW50YWluZXJzIHRoaW5rPyANCg0KICAgJ2lm
JzogeyAnYW55JzogWyAnQ09ORklHX1BPU0lYJywNCiAgICAgICAgICAgICAgICAgICAgJ0NPTkZJ
R19XSU4zMicgXSB9LA0KDQo+ICsgIH0NCj4gK30NCj4NCj4gICAjIw0KPiAgICMgQGd1ZXN0LXNz
aC1nZXQtYXV0aG9yaXplZC1rZXlzOg0KPiBAQCAtMTU4MCw4ICsxNTc5LDggQEANCj4gICAjIw0K
PiAgIHsgJ2NvbW1hbmQnOiAnZ3Vlc3Qtc3NoLWdldC1hdXRob3JpemVkLWtleXMnLA0KPiAgICAg
J2RhdGEnOiB7ICd1c2VybmFtZSc6ICdzdHInIH0sDQo+IC0gICdyZXR1cm5zJzogJ0d1ZXN0QXV0
aG9yaXplZEtleXMnLA0KPiAtICAnaWYnOiAnQ09ORklHX1BPU0lYJyB9DQo+ICsgICdyZXR1cm5z
JzogJ0d1ZXN0QXV0aG9yaXplZEtleXMnDQo+ICt9DQo+DQo+ICAgIyMNCj4gICAjIEBndWVzdC1z
c2gtYWRkLWF1dGhvcml6ZWQta2V5czoNCj4gQEAgLTE1OTksOCArMTU5OCw4IEBADQo+ICAgIyBT
aW5jZTogNS4yDQo+ICAgIyMNCj4gICB7ICdjb21tYW5kJzogJ2d1ZXN0LXNzaC1hZGQtYXV0aG9y
aXplZC1rZXlzJywNCj4gLSAgJ2RhdGEnOiB7ICd1c2VybmFtZSc6ICdzdHInLCAna2V5cyc6IFsn
c3RyJ10sICcqcmVzZXQnOiAnYm9vbCcgfSwNCj4gLSAgJ2lmJzogJ0NPTkZJR19QT1NJWCcgfQ0K
PiArICAnZGF0YSc6IHsgJ3VzZXJuYW1lJzogJ3N0cicsICdrZXlzJzogWydzdHInXSwgJypyZXNl
dCc6ICdib29sJyB9IH0NCj4NCj4gICAjIw0KPiAgICMgQGd1ZXN0LXNzaC1yZW1vdmUtYXV0aG9y
aXplZC1rZXlzOg0KPiBAQCAtMTYxNyw4ICsxNjE2LDggQEANCj4gICAjIFNpbmNlOiA1LjINCj4g
ICAjIw0KPiAgIHsgJ2NvbW1hbmQnOiAnZ3Vlc3Qtc3NoLXJlbW92ZS1hdXRob3JpemVkLWtleXMn
LA0KPiAtICAnZGF0YSc6IHsgJ3VzZXJuYW1lJzogJ3N0cicsICdrZXlzJzogWydzdHInXSB9LA0K
PiAtICAnaWYnOiAnQ09ORklHX1BPU0lYJyB9DQo+ICsgICdkYXRhJzogeyAndXNlcm5hbWUnOiAn
c3RyJywgJ2tleXMnOiBbJ3N0ciddIH0gfQ0KPg0KPiAgICMjDQo+ICAgIyBAR3Vlc3REaXNrU3Rh
dHM6DQoNCg==

