Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D870BC44524
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlk82-0002tx-3m; Mon, 20 Jul 2026 05:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wlk7y-0002sG-SD
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:17:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wlk7x-0007R6-BY
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 05:17:34 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6SEG73770183; Mon, 20 Jul 2026 02:17:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=weyQGnPK6dFGhfxKxx6oUxQWCwM+m21Evf4fHX24x
 tg=; b=jQcjtHprBAY7D+pQcuulAnVvmJCjaHQY8XL0mHq6ehgXEsTwp+57iApJy
 z7DOtej9GiAm2d86Ej7f2ezHgc0NfNHgWa5HP73joAWoFm8R7mGVeGwhTME3Vzx7
 l1hEG0Tq4faXZwDzkwXiCX/yGUBqLD40DbD6Au73vcXUv1Nz0cazTHEnbLmNz8b0
 uemYsO4+am1hRkHuFVxqaNriEuksOE9Zxwc9S7CV+/yZZFbCygdjN16HZna//K+E
 P0nG//SeD6PuUBt8hclYLZKU4iIDl8Q6GvEzrNiTko/uOq3lR7K8Hj3RbMFrmbDr
 3b4a0jCQFJm/3i4ghrq6148piV1IQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020125.outbound.protection.outlook.com [52.101.85.125])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg90xaqus-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 02:17:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xO6DHaRc7alL1oOuC/kQHEF8c2NcZkNVFRk/uld/EPPH3TRZOVEwm3wXAsL9OQCodCax6r9cl7azheWGfiJnmy/oxqA1kKXyP845uq3ihYxYzRzh3cdE1ufN0qjE83c/yFF/PLwcIcIaN5f3ETqPieMOCu5DhRnaqc047JItH0y2UggXY2e8YwVGrPzsFq1LvjSF6/b0GIsBB/VMu1BHeCXCEcc9zlUkYwYs7lxfVN/91vAMzMeOaQTdRJiUcuD7kYgRbviql9eK0BOTMqwX/yByoIBDggmtX7DiHWOc/KIHBraam6nE7EluN2b/qJBUuyU0mVit0Avy/dNy3Mo50g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weyQGnPK6dFGhfxKxx6oUxQWCwM+m21Evf4fHX24xtg=;
 b=AmLF7v8+8mVrYYsrkNAYZ15A9ocqbVa10SlMeS1J3rd3AkhVkKLaAzTV9H1QeQQc0Nm1VCMcE86TLe91Vdn2bdGyeCRIpQ27nPPqIvX4gPRMEXnDPQqszmkw6DgaODTFAq8EK2eVug2YU4flvhnjcGKpEGYsw6IURPLKM/EbdANn2IhQaxP4OykDQPP2hbFCUnE6FrFNQpjLrUwtVFX3kO5TiOi5nQaPNgpm6yZewkNIgJLOzMCXThm1OnYpu6fg0p2Dt0wgrYKtW13hWjaOa9dSrEkd6oOZehQhqh2ktsNZ4/4qzx7nZT4lVRZaRszF1bxNJmH2wDo/WGEFqo1bdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weyQGnPK6dFGhfxKxx6oUxQWCwM+m21Evf4fHX24xtg=;
 b=IRNjcCvVnc9XHJnC2b5PSlLLh3GzMNYlSoPKZCkW+1Aiv0cHMem53dU724fiSkmhbBT5s07PUcuFOzJMQeeVBEqVXS3QDOzfb+uxxNeQR9aSDhY9dy6c6AQz3t911LHjluZvmP5/A4oKk9pYMs36pVUE08YzMfKWgfimWrc+aW0KQd2gdmZF4g2Nggd/cCm4XJFifCaYEHhqkkiiFk44FJWZOqxzKEewthOhazTohohJZb09zHtYmXDTN8OszDtYWDkzUQPtwkLNFcT8Y1eFlQSt/sJ8UhlZ6kBJwdkx2KfcK74DwrdMav+O8MEbTsiAZmu6ZhAda/fC7/sJP/BmLQ==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by DSVPR02MB12010.namprd02.prod.outlook.com (2603:10b6:8:41d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 09:17:29 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 09:17:29 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH 3/5] vfio-user: vfio_user_get_region_info: reject unreasonably
 short struct
Thread-Topic: [PATCH 3/5] vfio-user: vfio_user_get_region_info: reject
 unreasonably short struct
Thread-Index: AQHdGCiWBAVbTpT3BEif/DTrR372ig==
Date: Mon, 20 Jul 2026 09:17:28 +0000
Message-ID: <20260720091718.2642-4-thanos.makatos@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260720091718.2642-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DSVPR02MB12010:EE_
x-ms-office365-filtering-correlation-id: 76f26ba7-9293-45f6-1cc1-08dee63fb8d5
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: tXuDeaW4a6csW5aI5548JPTOLWrzHgwRHMiDKNXOzTox2xF2DGxIy1IPwVLIYU+2yJXEgEeCaRfcCo26FiEN7pgZfVJdbRHaA2S9aC1RdSIXIf+mRa87a8YJGfJq6XdQBW8vX7/SZWzRMJtvxTOqRYj8GSeXFv+IY/NGSYXdb/zihMST0sbjdMveKvYy7rx2AK6NwVErPXTnD4JvFukrVJ8gv9vVQw6slHAi0hf9voqvH+QLJ5zE2n9e6tpE+r2m2m4PWADev1OS6O5YMNchyEnenZXP8PO7L8M5qQmU4JqI00GHvmdwQZmllODi5zIHw5Rwo/uP1+MzulvUJf2wGx2grEudkfLF9i0YSCgnrW6k9hWENrkc2fW1lpibLvMJOUr7RFsH8uObi7MyVhVeyqBPejSufN5fgGpfYNte05tfteqyIZd4s4jgl7nQoG9KywwgPWfkVtNLkY67QkZzYEiCVovP2rOv9NJH00LppVY0UtK02yWhkyo8a6qlyjeISpho0ivLyRrpSl8XLMkJkNUES7Z0+m50t5MnNOKhPpOVIgteiCeS6SYhXtHKr4tyUtJccnU5YtxxWj7YUn7LTLkFzd2v/kBK6WkuGeASVo6PT3GAbd5xmZZGQfQ6LmPenDwq151tN2kzug5AXhQMYOFU5F3cF9xLfhYbcjbgnasgopaVAROzctIxGWPROw3ZLUGck0xoClhJkzDBJh7CtQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m77uD0Y434olHl6mu6suk0ms0MkG07jLnYQk/IRtoXROMg+xC8/QF+pTei?=
 =?iso-8859-1?Q?AbBb0tGC44oZZDLbRH2iRsRzxIvn2uhKK37yhOpfZT/629JfO6CpcZUhp3?=
 =?iso-8859-1?Q?nRTW65xt+/QG6xjxjVjirXnIhXfAoaFuhVkzuasufx0quMDWdp+HxO5u9O?=
 =?iso-8859-1?Q?XVm4YzAazT5wBmVtGs9Wld6FL+edMt5N8gov5KrDCe3vu5RMBDYZiLEYur?=
 =?iso-8859-1?Q?y0dVjGPsLTYRvtyqxDWLj6C2XvNTuqq89Rs114xfYj7NX5882pKth8td5P?=
 =?iso-8859-1?Q?UWyOjNEYlb3vIezsZwRvahwYeywz29/hYD3SfAxqN+Yu4jSzfneZvp/YgR?=
 =?iso-8859-1?Q?eUVzmmQDx9VaztegEWMMyQNs3h3OZIp6fpf07uT9y0+1nT8TBYVg8P9aYR?=
 =?iso-8859-1?Q?6oJPb06bsthBPG0wHqWGs2OP414L/66YOWBWcz7aYzqsvycozGhZahgshi?=
 =?iso-8859-1?Q?1ILXIgFEUypo6WmdQDV4HgDWwxuS6h+MDruDyHMlMwy9ya9sHxejWpaN/a?=
 =?iso-8859-1?Q?N35rsv9g0ApZuy++Xtbj8hwJf0B3BPigKoWafAhxUWlpuGwjk6S0GUEhUM?=
 =?iso-8859-1?Q?EM12fHdUqsKDgIzVbaVHxnkxejrH++eVhyyHhzrGiwzxCuI6YA1DlCIUVe?=
 =?iso-8859-1?Q?aCqmXwQHDmxAZvxJGF0GwAEqcarM3f1zoW6u5BX4jNBpaOkHWxIKwaqNAu?=
 =?iso-8859-1?Q?9WNlHCSRED2hMkhBsAiusbRXLZygLWXwEEJlmQmj/6cEm1e/VvKaKN1x99?=
 =?iso-8859-1?Q?EBTmUTE1d0tv8TivoVM3YljhqntjtDwMu4gmbCM0v9rIGZDUBnncS5BwD4?=
 =?iso-8859-1?Q?cas0eNhu9de+ub8yppdGrOcF9BnJoOXbECgWHgR9ptFJzSGEZQVQyUiD/y?=
 =?iso-8859-1?Q?YKtZrpXyNBknOrny0Kc0ZcHtlT2+UwygfncO5P7Y67660WJVJrZD6XiYYW?=
 =?iso-8859-1?Q?wn4T/o1l0yD3y6Mhys7Ajaj2i8s5Po/nSW6QB3osMT5Y01ONHuGF47jfmP?=
 =?iso-8859-1?Q?3WaKl3AREQvwCLi/C93MkyiuKNKcuOMOc16bja+lfqVpdeCbBatKLHff0b?=
 =?iso-8859-1?Q?zqZw+ZyvFN29gPalCMasshNTJYPOGLaC9YwSQmsEFpkrkukdIotegzk8jP?=
 =?iso-8859-1?Q?Z8Np7ZuzFJnAziosCV+pm1lDjtES4EQQE9s0Y/iiNOF4FYdun5enO4VyWy?=
 =?iso-8859-1?Q?2bC4OseaJQi+1lWrCK7tDFZF7J434YamaqEoJXoBR6M2XH82XL8lUAdDCv?=
 =?iso-8859-1?Q?e/1IT91MRBThCfhkfZMIelYx+SP39cWVUx0XF4mV0nyOTKPf8KCvNcZS2B?=
 =?iso-8859-1?Q?tX3qpEQjdrZDHJjtofP2mkinaxV4pHHEg6L2fbdDPpEmJ025TwgAOknxnj?=
 =?iso-8859-1?Q?8mN+aR9bsXvEDdquIEwEcmH8H2lR8s7YqqcFCz2xVnDkTpSqhJkT0JM3mV?=
 =?iso-8859-1?Q?fF76Gw6JSop1SqUkZ5A2QuFb4SbPfn9PK6bPurT4HI2QQMiAL0URFfU8Gs?=
 =?iso-8859-1?Q?HY+pWCah8bBdHT8FeRY50VrisBfwl+shqMsbobu8NIBi7iAzq+rpgwB63o?=
 =?iso-8859-1?Q?DIJsv5q2GEQjMZRwjgx66MGUZpn7KooYcTH3Ef5lMTzmeE6QzIHU5nXlYZ?=
 =?iso-8859-1?Q?BLvKOnqc4kg3s23965QILfluBk4sEZSmeJLPhS5MLa9iiKiHGSmwMMcj/5?=
 =?iso-8859-1?Q?A6k646X6Ohz3arctSvt6+fZGcz0BNHtK3tSt/tBVSQCjAUFXTACjyk18bO?=
 =?iso-8859-1?Q?jtTZ3zizlV6IUA0a7MI0EnWTvmFjAvXhFMK0EjJNa1nO+uqo2iC8K0LNzi?=
 =?iso-8859-1?Q?2YPwM4GEwjx4SkP5XE6rrW5F3aHZxQg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rWFSKlnKjbwygpV9KtEI8uYIzl3a6uGVlTJsG2qrdSnFv6NQr8ysDMlaEWlhfoowo/E96qBgUZNOR+wDJ8z1FYdjpqQAjsIXlM+SXmG1YE7SS04O4Ww8BYL62cmuqxfsF6g56rQV7NoNJFF8/2B+e4Y3exMW3wN7wouj9ghiOtGVm8/SQGBBNp8Xr5z/wu191M7cbkCvnMhu8WuDFihN8M8bSUcTlTh0egzjFolXpf8HBUKN/aQNNg4qxULhN0/NLcw6o/ZKrBq27vZIHts/1qJuMBBzMh5Li0Um3kuXYe9aGr0HMX0/PWkT3xOLknBE8cVWrBZ8l3Jb9QAmcjO4jw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f26ba7-9293-45f6-1cc1-08dee63fb8d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 09:17:29.0338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMQKIU4wCLEfFAk/lRC0Rcc3HOggC9S/8pG0voSmfM2+4Zu/omtA13fygx303w9DHi5kxgtdhw10sS5YpTAp2duT/cCSpZff4+iO0k1rddM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB12010
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfX/Cf56/6nBllZ
 KgsFPps9XmrpKJuwP6TmLGZsQBbxtStnybm4wAgJuJb4c6NPyZFI9LG19lB0Rnv9agUafmBXzed
 Gwn7S8lBqu8/mempdF5Gi4KVxSNa998=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEwMyBTYWx0ZWRfXylEjKz+bOpcJ
 Vx+hFe4NkEjoczhjbMtm9BPeQysuK3f4o0rfgTaUcReQm0zU30aC7sY6Cs8QqHoTVtgQyvn9Wp7
 HKAOdivRoWrSh8ND7oW/SBnqX0pLrEpejyyUrnfTdcIVA5DCTKexFh8ZmxcWrq7xybv0I4TnDOh
 lyyNzCu4H5ZZiLYl5dEc4EfEUJzhsjCDISBlTqHJYobw8IJkCbN2XTAOTvBPQlEprWjDtFypDtr
 UMoDfk2U+SPler9+KTjHeqdVBGoSTye2SmnT/6EAlhJrqKqPB2mmuuCrHAxiEezD4qwemsPYopH
 u8XFa/xQADywIs0o2Z4/wzYiXJiM2sljMs1Z0buDjxBuZvcwmDwoweIh8Smhp8NgH12aYz5rSAp
 IVWL7Vd1BNdm93BhVxo5cXvCSdnGOaT7q8x14oYfEZSEM/T2g/N6alAVD/Srec0ARcbE3InqTrX
 zTVvEAvcdHfNK1oKWJg==
X-Proofpoint-ORIG-GUID: Tsvn7aODIpf_QahRbxFOFM_SNWIE0Rw7
X-Proofpoint-GUID: Tsvn7aODIpf_QahRbxFOFM_SNWIE0Rw7
X-Authority-Analysis: v=2.4 cv=CfY4Irrl c=1 sm=1 tr=0 ts=6a5de7ac cx=c_pps
 a=bA8WxO540RzhAQ9tgvMHlg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22 a=64Cc0HZtAAAA:8
 a=iamFcwByjoOU0uyVQI4A:9 a=wPNLvfGTeEIA:10
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

While this isn't technically a bug, it's highly unlikely that the=0A=
server wouldn't be writing an entire struct.=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 5 +++++=0A=
 1 file changed, 5 insertions(+)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 201bf34c8b..1907a6653f 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -166,6 +166,11 @@ static int vfio_user_get_region_info(VFIOUserProxy *pr=
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

