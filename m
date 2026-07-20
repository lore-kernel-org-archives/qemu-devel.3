Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8848C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wloWW-00054F-G9; Mon, 20 Jul 2026 09:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloWB-0004qm-2g
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:58:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wloW9-0006aM-Gp
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 09:58:50 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDqBEJ608275; Mon, 20 Jul 2026 06:58:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=JmfE5UZJCVSwDDDKWPb7G3NOCO82E0VcKdcGeenJH
 BE=; b=ZRQmhI0mRHxkDm9s7pgyHxxajFaoa/7FFPkkXv1NJIONjwbuMIDe03/m3
 X0axDriXjeJGeXz3gnLb/d0bDX8VM7VC8VXpBMskP3w4KLC/1Brtbe0dyze/7yVi
 uB0QQSI3N3+S+sqSEnB62pQDY4WonLlR79jz7qkGxiIGO1ZpiWq28nNFX9KRoOB7
 d6EtJ5JochkIx+AcMFUJb294eeizcsHnyvbpWl26AISzswgKOb1uSWdZ+GCIza7a
 8jFo0IaQmLL9l6WT6evO1t+f9zbQOqsd+YZdukT9ONDi0kYKUIuXL4Pm3HaIXGDI
 Xtb4sNmZCS5f7bgBEO6bhKG4/IWHA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020090.outbound.protection.outlook.com [52.101.201.90])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8fskdjc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 06:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhxxpAUsZqWvq+12jPyigFK4RxzKWs1Uis0EPbNP0wExa25URwZpX3Cg0JB/kakhuWgNO324/RmpbaJiDcKQHc6fR+iNFX/QWzqY8j3LJZ1ZUt0KLHLsX/Fv0rtHPqTgWJLbvd73VjZuM8LwplZyqQox1PChxLSomN5RarlQvgPsZIDX0pbvmhSGFlXEE9CtjhEbsDcQadEEVg99LLNHJUyKtBvihYhJA1LspFjZigwePL7t5CXZx5rNLgLa1hPuYkN1vaWFpLAATEZWgY1MKLGw1J4z7j1GRxe0WnihB4JUtA/JrK4g942hujag1aYPP2zB6HUVggPQjdCb57BLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmfE5UZJCVSwDDDKWPb7G3NOCO82E0VcKdcGeenJHBE=;
 b=Xu/TTlDGufvrJQayJXaU7z2a8DxC7Wq71i37KFR3hEvys+tiJjQ711Q69+M5AcGNnSlI5Ew35imrZdDXREkF1HmBaiGVFCE9UbhgmFEsf+wI8iFZfbIyjxYFk+/xzI9JbfqtUzazS2SgzXHVMe1WbPoMB/rwBtRKHuLPY08wP/qR/aErabtz3KSixBADqqpy6X7NWjNOIt6fLlwfoS7hY9ErNbxDxZjNH/I5OHCibvOCclJNJEadO4IzOO5wXiHiV19ptg9HPTd8LkwC/Gzn9JvCkt25Tiz46dTgyCpMI5eH7fY/ZSUpge0E6DbONHV7MDK2RyaGstUwe6LELa+QHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmfE5UZJCVSwDDDKWPb7G3NOCO82E0VcKdcGeenJHBE=;
 b=uTsVfetcSLnu1D6C+dls67oBrwulhm0d9DH/AE1ReF0TXTWlCeFCP32flPBIuz5SlHf5BEVbk+2NmzBvyk706eeLfrF7RdA9rKmvqa9j3lmhoZcqw2fLZFoJJUnQVAcnUg1L75iVZimNEyD0fZpnaOJJ3KgLVOdkSdd3BZz/PVH2Y1r7hHNJa1G4M0TJLG0wAalwJB2ZzZcM4m5k0pyPQI7TErt62E2C54PciKpeCE/6XksXi3mpNDmQrhrNG41ooOEJVDuIND4ovm+uzu5sHLnkzFEEhOIvDBsAG7Qtqi/iMIJb/8v0+ym8tlBUkKzHZhpnukJTNhUVYEVTiYCgQA==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by PH7PR02MB8883.namprd02.prod.outlook.com (2603:10b6:510:1fd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:58:46 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 13:58:46 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v2 6/6] vfio-user: vfio_user_device_io_device_feature: prevent
 buffer overflow
Thread-Topic: [PATCH v2 6/6] vfio-user: vfio_user_device_io_device_feature:
 prevent buffer overflow
Thread-Index: AQHdGE/h3HueaJd1rkmtksu7R8aSjQ==
Date: Mon, 20 Jul 2026 13:58:46 +0000
Message-ID: <20260720135823.21070-7-thanos.makatos@nutanix.com>
References: <20260720091718.2642-1-thanos.makatos@nutanix.com>
 <20260720135823.21070-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260720135823.21070-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|PH7PR02MB8883:EE_
x-ms-office365-filtering-correlation-id: f17d8365-7188-4e6b-15cd-08dee667046e
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|4143699003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: 3Mx0qULsHa7vkhldCoQ54oS3k+JSkrEa7fJ2lOWeyGxO/C0x1W3XsVw26zIL7vl8kfwH1D6fGeJyMeip680WOEyxNWCSN67794vLB119bgJtq8JuZfkp3/NZ+ZiyzqO9w01EsG5SRuX0SCOKH2kig8q3SN7MZicg/4WALxwaT+x7MJbHnBkL/bcATq2uJT/c9GHzxgsavtGYODZFoumyU/VH17rB5p3lkXuDIYCK0VaqI/UUgzuEbxYQyDuJxebTUr4P1bZJiDINkF1bd2jYToDfeHji6C+LNghbKx++h9G45t9MduxvGLlEH6F8aEEa9Zt9ZH9f/NEshaW2RyOOi1SXL8owI3wK0v/0009sJdN3h0Ei3czowUvBrmtY1vCPBL1laSMzx5HzqpmwvKWT0qG+V3aj5PEYQSBSXgQII7g1C/I8YvvQwmUhakbe3bFth2G+Cdj/uyLkgItCvnD3DxVu39IZtvaGFcdODrzHUlYGO5RRFqh5Wmu5z6cW5TQdZ286S8bZccWrNJMuY7TbBSGh0oIeoZA6PWhNR/bx4tuuncGR1CpvansIhZKuvX0HXlnVaInKlxKrJ9FV+vhTUmpy8gkn9swCmKxAcmnhzXiB1ElFiRIa+9ZM9nEJMAgQeyg9YAgmnYGQTvwRkt+iadxZX0nXQe7prVV7kAqnKaURZx+onXqI/Y3G6zwjeQKAujE4lpitofNHSeg0MLCHs9Nyxh736nIpPLVAtB0OKsA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZU3SPZZbkixe79a4gyQNjJDcbRgkGd02kk+1kQul4flnwMb47p8vHKylZl?=
 =?iso-8859-1?Q?M9/pbeQeWM/F4+NlYzF1230lQlqaP7pP4ABDZurh14WS+g1ZvWgHvujGZq?=
 =?iso-8859-1?Q?sgJKXyRZa+cLnGiBYKaOT8tCOl1HqEQSgoIEsoTiZA0Sy8C7rn4m7J2xE4?=
 =?iso-8859-1?Q?rdapm88zS57PwehEUsLQVxSTDoExMXgSguKdoam2zfI1M4Uw/R3GwMl136?=
 =?iso-8859-1?Q?pPcwXev2IbAFFgpupWYozlaJQ1PorynOHgJ9Xdib2TQmQGVGGHUIcogAo7?=
 =?iso-8859-1?Q?6eSJy4WA9XHssMbootIFukSenamJdmZYhbDH88NJUaQ33n9+HxCuoxOW1M?=
 =?iso-8859-1?Q?kY3cRvdX5+UY7CfZmQEsYfKnvP1GUQOENREa3VGnrMZc/v9s5zfNUz+Y6G?=
 =?iso-8859-1?Q?S6pAua8WQgpDQ3JH6DOQ2S/EGSbWWy3vNc7Y/y/jahHGMx5q6Z3/TODuu4?=
 =?iso-8859-1?Q?MRtesgINCrE/YCG9VAH5FKfTGyChtsOi9KRiBkOAB7F+uU+5ghBr4DfjEo?=
 =?iso-8859-1?Q?QI2cks2g5ZlaClhF6PhGCzK1iCmGLyXpTzhaf/YMcMZHWA5ejrprcaZquD?=
 =?iso-8859-1?Q?fqOPEm5eGaYxRjyfFa+PBwdEhEpf0mVSqwefAb/XbU9VPyezb72T8V81x2?=
 =?iso-8859-1?Q?lnk5RfYsxyW8AyA8tH1EXVEO+Re050W+A5D7sLYI5t5qouATmBr8jccNlQ?=
 =?iso-8859-1?Q?k30+0oAIz8H4RQzdo23vQgH1lTak44qEzOfn79I1gXG2veNsRq+02F8OMI?=
 =?iso-8859-1?Q?lNNiFpbAFbp2bcfOtH2J8lz24jfyXAkgbdA+USdrqjUlU+iOjTX9gmnbkN?=
 =?iso-8859-1?Q?S9coVtYGZB6ISyYHqWA8jTVg/kSliAacamfnOiUzLOgiaD+/Ksp5W7v5eT?=
 =?iso-8859-1?Q?srjlpz0p+MlaZNEShiT0jKfpKZjXoa6YNJcKeVqiiH4s7e0BiIQEzRDEn0?=
 =?iso-8859-1?Q?GzKZcWB7RnxDwm5K+7BF5OpfD2eg26OYbGe6MQgM/xvdKPKPSj96Gtt/t+?=
 =?iso-8859-1?Q?f3RNHu9JzcOCyVTsHW8xpk75J+djReZXQNiVL89CP7NgDd+EQcHa8BKQ+H?=
 =?iso-8859-1?Q?igK2fo2tH596c9hnlvtChHm8Rv8Ndwoo3t2IV67RuhgzgRk2J6Ly5CsoXT?=
 =?iso-8859-1?Q?zaPnf8xH/Pdp7L/WWL3jvO7kwkQXE2DPOgnWGO+LFyi3tny7Qekdlmyakx?=
 =?iso-8859-1?Q?AGlzgmSpkoTKe8SHNVUAZdxpkohtKNrtSj2LdDDc4dkpsGHkrS7Vra31Uu?=
 =?iso-8859-1?Q?m39pRzYnIlErSizAVzIGjyyTgBYsRmLVKkRLGEiDmi1jY3lIl/ASBZV2/N?=
 =?iso-8859-1?Q?oC6kd+ar6wxwZOSN5NcJgHQp1+kEvEHJsjI2X5zpt1g7TauH3BXD5YOhK7?=
 =?iso-8859-1?Q?eq4S6VwdIXnOCcGw1bcVc6eh+cwxzHFAyEfRHOXSOB9Ss28cSPL9Fun6Jz?=
 =?iso-8859-1?Q?gp28MEgy5QBcjOIFJ8KpqWmvJyd7Jj709UhLc9E30ZsnVyRjph2PvXqlhT?=
 =?iso-8859-1?Q?Xk8tizogXXBIqlvzGLIpXPPrXX5cQs++r5CSuBCrmtbbGj63TD02zcxdKV?=
 =?iso-8859-1?Q?LRjYf66a0WKFc1Kzd5gPz9v9WoOIiDdEbBt1aZ+OhXWJxxunLjKeQlTfdm?=
 =?iso-8859-1?Q?F6KqnTwcLYYKz0WIR5NWGJkEqoutGKBl4hxiQMOghm+VCCZPLXr7ANJesD?=
 =?iso-8859-1?Q?0CbgbwMG8axFFClwPXwNwcuwrB1UJJ4xDyY87bUU+RaC7eQq0XjD/zB6So?=
 =?iso-8859-1?Q?kHK4Q/axc37X4Jw/cng31pLZjfl2AeKDaBMBWmRPmmj5/Azen1kEGXkIOT?=
 =?iso-8859-1?Q?8ZPmQ3I7AlmDwWLQ8/dh+HU2nIo4hHE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BGseFcMU5kDRuXXDsjHGBJjz+ukof6d0EXeFx7YZ0aXKr3oRyMJ3csJoDUOg8lISqQG7Y1GKrY+W/kVY8PZbsBMDUA1DDIXsjk98gfQe/eWmIwpX/AVD/sUS8NTCEW9m436s+sH40hSiX+HowiHgzCsaZYPTdkG4LWgnZab1+zrSoIqwlNwbgD+OeNy7gj28R0ZQKNol1Po3+Ix/m41RarXDf7g9buqVqw9jEjzUJvVuUr/xx+7lqi+Q7HKzcJfrBHaxBnNOvlqSC2vm50/Agi+/wppCRkmJMSrboPpVIA2W9WXHD0UDNdEbhBO2I/feMtEiqWL1dvkN+tJXcBT9cA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17d8365-7188-4e6b-15cd-08dee667046e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 13:58:46.2981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwpLBIdk2HZoL21qWjPzV+6p6cJIAqUEKHfuXX1xZeQrXPTEykyhVe9QJwsiQld3deC0XPNYj1KXOfZiylAvss6rMqziWmZAGYSO1TG0EMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB8883
X-Proofpoint-GUID: QREJbDdIGloKIhdYiN1cpCbeyckL8P00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1NSBTYWx0ZWRfX6VyE11Il5Vsq
 M9IoojG1XCggXe7uVMvvM4svMm08p1OBIoIR4/UiAhLAny6HC9iF0UpVtuoO25b4OS6yOUzCeUN
 LKydGBzbUKPnuiMkKaftT8gsQct0Ndw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1NSBTYWx0ZWRfX5p2iaj09FGu7
 RrpdqRIh50JykOHNb5S/iveuOIdV8pJkSYKaueIuMq44k2G4Dmy3adMlclVa6N2HWUS5AzbBpzO
 dhhvZob3Faqw1JPMxKRI6JHQe3z2jzrJTmlvjEcCOG60pdpxjDP4jA4vGU3pmt0QzW4eXESuXGb
 Z54Hr8/hFyuxAKvvj7q9DR/faeW/U19XdliskRHD8U/m2kHdDzYFtaqEjyVjLK61FM1Qqb6R1hY
 KWNXGAvlLvd+1bbzFx6y0uiKZOKOy3gdA/SveRbf1qovPZuSSq0rhdQzAJy894IoPLC9/92gK0+
 4Lb31RDk4HjZmuIs4qElglV+W0dDzx7LUDGsK/zO18a6o85dIhdeweysJV0QCL7iS4qx34hIArT
 oFJAU/WVYzsZPrVsl+1LxJM/tRSRDp94yYaIrXdo8mFDmYKqyv0rN0gjfm8hmOMIL2/fycWxOOc
 kYE4cIXgbSge3OOP84g==
X-Proofpoint-ORIG-GUID: QREJbDdIGloKIhdYiN1cpCbeyckL8P00
X-Authority-Analysis: v=2.4 cv=Ifm3n2qa c=1 sm=1 tr=0 ts=6a5e2998 cx=c_pps
 a=onnDVuI42kX/OVeLv55qNg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22 a=64Cc0HZtAAAA:8
 a=aB6u2EZEa9mQxSzGBCIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
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

This isn't in practise a problem since feature->argsz is not=0A=
externally provided, it's a good hardening step nonetheless.=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 8 +++++++-=0A=
 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 67736383b8..131be7af61 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -79,9 +79,15 @@ vfio_user_device_io_device_feature(VFIODevice *vbasedev,=
=0A=
                                    struct vfio_device_feature *feature)=0A=
 {=0A=
     g_autofree VFIOUserDeviceFeature *msgp =3D NULL;=0A=
-    int size =3D sizeof(VFIOUserHdr) + feature->argsz;=0A=
     VFIOUserProxy *proxy =3D vbasedev->proxy;=0A=
     Error *local_err =3D NULL;=0A=
+    int size;=0A=
+=0A=
+    if (__builtin_add_overflow(feature->argsz, sizeof(VFIOUserHdr), &size)=
) {=0A=
+        error_printf("vfio_user_device_io_device_feature argsz too large\n=
");=0A=
+        return -E2BIG;=0A=
+    }=0A=
+=0A=
 =0A=
     msgp =3D g_malloc0(size);=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

