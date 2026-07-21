Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A26C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm9Yv-00089i-Nn; Tue, 21 Jul 2026 08:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yt-00088X-QM
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:03 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1wm9Yr-0004mL-3k
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 08:27:03 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LARHFR3272672; Tue, 21 Jul 2026 05:27:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=1Hc/qhemsrrgfCxI+K3Spk+aNhpSDK1P9WtH5TUxl
 tM=; b=YNDLv6C11o896GrqdPL4lRfBVXCuqwbJcIohlDwgCl7n2B8RG5FhKT8s0
 uRCVumVXssgb5kmuj1DdQ8yO4WR/CyB5mPAgD71Cv9w0qP1L29bcbNpzlcAtwF/F
 QhBm+/bFQSnSwVHxnBbVQjA0F/5MO10cqCmHb9WO2IYj5CezdToYnRbuSa3E6vMY
 nc7YtLfppd5xhNCDL1CB/xLT5rd4kiudBXvB9ejUU/M2kqTjaJGc35cC0ygfKm60
 NAv5X/OzQ8ASBOW3GEre+IKA+4DbCsVUlO+6lE11gceRKK/KLbtWlq6Nj0kWgHgY
 XWRdzZ+OrV9GOWszoqCwGP6adUmVQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020091.outbound.protection.outlook.com
 [40.93.198.91])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4fg8fspbfn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 05:27:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yplcTWg5Ia0xXZdYsZj1Y3FPO9Ibd5VwxNA7Ce7YR2my93fJbVRhvWydOf76OnJqaqQCikH7dXATKPgwdC5KH+a23DI8vax445nwN9BJ/1oYsBDV/kUms10lP17wZ1vHQBtlPFo2hV66RB2WlNSp+EH16OAdf7b3TEsgLL3Pg4u9kAf8Ib7jg9ZpPY2XO3HV3BJ/3KdqkFw45Ysg0oI4qhNhrOwpKhTNre6n9kkMvg84xvMl8drqWAwMBxO81XZWiMO0HE8ChvfgifQ5VzQo1xnPJiKR5ioNP6ieg+vnhvSrxLtXArdDx3O2svQFs/XMtsM5bOmlduUL5Mw/msRl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Hc/qhemsrrgfCxI+K3Spk+aNhpSDK1P9WtH5TUxltM=;
 b=QsMbYNwRMvDAXwgFNTVGAaYDJCwYTL7UZzC80eNVWyLyP8JZI2yMNXrZc46BwjWyIWgNf/f4f534i5iCfGqQEMw1Gf79IxN8NsJQhZayhvviRiP05vSlNT/WsyBdrPZhTjzCoZkrPvaXuhA+XGCOObZKVEc6ckjwKD7dzXVVH+TjXQTXw6IPPKv1SYaYsKwSrFPVxh4nBcAxVjTp6wpNsiU+MGVzXcM1vifJfc7pLzdPa1j9hXbrJkx/kYI/70Ktej3LUSdssQN6R8TZ6tHewonwBTnRxTAO4A89fovs77o2M3HXKR74+we3S1NV5I6MqUhOeXpLIFG/5d9f8oS0Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Hc/qhemsrrgfCxI+K3Spk+aNhpSDK1P9WtH5TUxltM=;
 b=wzMGZIoJ+XpJXXNRwXbbyiu0XFf7aqLIcxrrL6hOTdveic9D51p3ZMpN/o6jUyMTsW479hsuGfEwd6EUoAwnDQ/xLXSe8A7MPS45cceAtzQxLRIjSJitIlH9ySQtdSRQZ65BeEuWH9Yf1pGzPRT5qRknqO7W+wxKUlB9rzOlkOmO45e7QeAjjghiVZp8hpR+7Cp2zGIOB2TsinQCFUfecBp06IV9Zjzy65ssB8zEpA28p875ufKTS2sH9WMhodTKd9kzj9yvPTIQnyuP3PKkOw3OPxikLcnztD4HGbFis77svE3MoSUD4Z/sCTiFNAmcGl2ILKySg1VW2XO+bgIGxg==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by DS0PR02MB10249.namprd02.prod.outlook.com (2603:10b6:8:1a1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:26:58 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%7]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 12:26:58 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: John Levon <john.levon@nutanix.com>, "clg@redhat.com" <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: [PATCH v3 6/9] vfio-user: vfio_user_device_io_device_feature: prevent
 buffer overflow
Thread-Topic: [PATCH v3 6/9] vfio-user: vfio_user_device_io_device_feature:
 prevent buffer overflow
Thread-Index: AQHdGQw5uwDr1Dh3eE605cuorXi5kw==
Date: Tue, 21 Jul 2026 12:26:58 +0000
Message-ID: <20260721122643.30985-7-thanos.makatos@nutanix.com>
References: <20260720135823.21070-1-thanos.makatos@nutanix.com>
 <20260721122643.30985-1-thanos.makatos@nutanix.com>
In-Reply-To: <20260721122643.30985-1-thanos.makatos@nutanix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|DS0PR02MB10249:EE_
x-ms-office365-filtering-correlation-id: c32088d2-3fc2-40aa-5b18-08dee7235bc7
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|22082099003|18002099003|56012099006|4143699003|10067099003;
x-microsoft-antispam-message-info: moVywDSWjkSVV8yrf7WTy7/zk5l7DinRObNbX9/9CcPaa4tf8CvwKWU8yqRIeTyrKXkJlG72sSmQymZNxW5WMLNKF3RE3GZ5wjbk1eLTBZTglzN8b2luh2boEC+M/vEH43uuvo58/WwPZHq80QrZDpjHY5tVxVnipnijii+NmW3O074zwG3VATnjujt682cCIO6s2jRE/T11mOi6SefQobO+5NZnIC3R9IMosNzTDjb/BWPX0VH5RKpkFqg/FAj4uRQP2DPFevZih759A0jwI8hourSNKSe7+if3e8tzhOSWeItspHxD53jcZxgLvE908YhBbA/mmrXHuIsBIvtCKfkYUd+3uRk78S9T7a2xxSHuzOKWZXEnfZ8mUkSvA4vaTjtkTucfMpSs8WTUWp26uzIJSnONoc+q8QC8ITlIfkHsXA+jjl3ulJg7kqnMq/T5BqYoMev7R2vseDC31/TUrmzF3Kb4Vzhu6VMjWZevMu/8ytOj5Z/qrwGgWGpyzdaYwJCPziLfL2GkC9hD1juwT/YHzqWLqtEaL/xBAZgzNROEIwZyO8EVNcXZXe55hUAxtvAfMg6E/tqInPvViTgkFljksqgtP7Rwcj+bK5ydHkOtPtvA5ipupKoiy9O3jEOYfoKmMJejNbDwcyNcZIGsGIaHFFtHhJ6bZgGNXKt2KfpdLxbTLQr/Dn2Nke6xhpb2Yn4UPun++2Zcd79lKYJOdXGQpWAEjp2kUjhKdlVFy7M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6hVECHrzlgIkdujxOcGsrvAdRZspnJkIT+UC0vo5btmYvXhjG2ZbChEEMI?=
 =?iso-8859-1?Q?wnGugGqUJRe6dQofoJzq17QYXqM+/IUPnM3SfPX6s/nLZhm6uYQ1BS7Ugm?=
 =?iso-8859-1?Q?DQIC+QjDcDnu5PNOLfS2wIE5mT6BSHu0h0Xdi49uICOqOJuUW4s5rwNqAq?=
 =?iso-8859-1?Q?8tHEpLV8a4LVTCX9FaztP9Zw2WkD0vnhIYEzNF9ZTq2BIAzsJcPDRScr1v?=
 =?iso-8859-1?Q?GkqyQOP2AugNWbQTrYeDDLJAv4X0ZRpsivRchlUm5WZd2SM5FdJece9PX5?=
 =?iso-8859-1?Q?+sfejSJBZV9CMgP6uoPI+pwnGl+SexKWZ61l7axqb+xgDJeYkAiEnBLWEX?=
 =?iso-8859-1?Q?GoMfPNPCkgBaEzAOJcOsk312MyeLgX4ysCD7oOor3Q75yNg5HvOZPw6Mdx?=
 =?iso-8859-1?Q?xh8+5ZvwRV7yutZZfIww+anaihYNsycpZsbCoiEJKjm+eLQl74daZUQgic?=
 =?iso-8859-1?Q?WOsrTo+xED6UXKKpIHNxtoqiirauq5HDXF+jn9uFFg38vYl7RHw5/rHMfp?=
 =?iso-8859-1?Q?cKasUtupicZLEPEOVvsmskUSyv6ldj8eoHoQvDbJtDr5dIJUjB7F3ZVVnV?=
 =?iso-8859-1?Q?HSAuJ8EbLcfS4hhrQkwuQ7aPh3Z53fmiBzbzyDYb9zVl5Rho/PwVp8My2M?=
 =?iso-8859-1?Q?CUjn2PvZJxQZI5isOfon+zfHoNnJzwfl/LunphuCoI35mYSgZyWvT2hF8W?=
 =?iso-8859-1?Q?gpaxozOAIr4YxXmpYouhBs7d1wwI7LZC8wirmo8wmhCdufu1dq9lD6WILa?=
 =?iso-8859-1?Q?u966jXF62VObjAd/bggwsPO2LeUQL9HXEfOmJybJ6SyWW5BKf04RI74AsY?=
 =?iso-8859-1?Q?WEsbobPRlH6rDkC8ire64RyIfQg4SEMVEfGfwpuQJ3161zMniwHQdS595B?=
 =?iso-8859-1?Q?CwXTXmi/G4A5JCmemqC+VEGys1HGHqnlAIiIFOvxmE67GxewgrI9RTWp01?=
 =?iso-8859-1?Q?0ABWte3sGwZ/N0EmIkyHNabKhBWSbC2CWa5JfkxjwXZ8oNGeSVFq2xCDGO?=
 =?iso-8859-1?Q?i3nVwlrfFJcxesp11/GGq+7SedP+SgsQQ4Jg7bXplyTUjdxAc1DigcvFpI?=
 =?iso-8859-1?Q?NEhe2izFQSdGvnKIARtSvjheE490XOzpf1185Idv3jzPCvsPnPcUnLmrzT?=
 =?iso-8859-1?Q?n+zta5YzM6DhZklZ5M46i1s8lvbT+M74gaXhx9attTnwHl2kF9qme1hI+h?=
 =?iso-8859-1?Q?mA8+INQL2dqn3Aa7HrIThjzpfzfpD6SUhrqRuVXgEpiYSJl8fTM3R9ySSv?=
 =?iso-8859-1?Q?z5k52A+aOqH4entJ69Ed9Jai99pmxKkvYaydTANwZLzDn3t/CHRa1PWwOP?=
 =?iso-8859-1?Q?f5owiCTZC9sRLSISEdTnG/sBlO7ItKuTKmEX9WHG+Dm/9zeHPiDpfgCkoD?=
 =?iso-8859-1?Q?klal3g4AxILhkv/FW32xUWUv0aL5qUF0aZ6piXVdcKenr5NTf9zJX7QR6i?=
 =?iso-8859-1?Q?agpeH9rN35bfA6yL2oSwEWYZWxPND57V6cWv0NtK0xhXYv+0Zj2Y1hM7Pg?=
 =?iso-8859-1?Q?PBvicH4R90GDfS9t0Ay06VMREX210w0erlKqW/hLqF7I8+v+PUN0mTOK49?=
 =?iso-8859-1?Q?JHdvDo01ED9oKe5GBmBbWmraoObnDXSiPlaxxFkpd47bJzrI5O9XkNW/4u?=
 =?iso-8859-1?Q?UXn4qzUtpccpM6PKXnign3AqkkfQP2A5a36Dx/ltOTO0QfNgs6itxkinmo?=
 =?iso-8859-1?Q?z3rb2Xh9TyA6LKbGmAcSR42DH8fFnkUKyhShubA03oy2aZaeDyZ0pIuJ3L?=
 =?iso-8859-1?Q?fY8s/CXbxCWN6Atiug4tVOWw558rZitH7EoDNAF4Ehro/09Fn5+SQnxYa6?=
 =?iso-8859-1?Q?MGKU2jSyiOgN9FdatJOKvgUXPTwNB8I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FYG5F767nYi7dlYYQuIU2w6lnn2v/kR1DGOSKLJQOuO4BzkF2/aI/G/Cf1U7gUc9YihVLD3CVPI8CclFoFeUpaOPElcPHgHzPVyeicLKmjX1V6LFl+Cj/RpXJYJG3V0LtfvCq7LKHvGqAw7f7n1r3nWByhtMCujM7VDkuT0N/qrv//nQmwSXDX4SxF1aWjQN4aTQQDs2nJ+zALFnd75J0dxGZ1EVUujhrIT8JfS/W2cTM/LMlukabsyb1FuT4FTdTONxKYem7jEIXp+/IZAKGOT9nYOti5K03Eit7YpPzmsPgCAlIhaw1lfcpkdJbw6yqNm93x1v6mQ5BRPMolNkMQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32088d2-3fc2-40aa-5b18-08dee7235bc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2026 12:26:58.2410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qmakO6VB4wOrVYzAG0pTb8zjQ/Hkcw6rzOU4UomMqX2d84mAACZIPjKaH9X31s5YSYtwwBWL3eQrBsmTQyy00t2rI3CEiLeoEoRQJoKgwEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249
X-Proofpoint-GUID: cpS2xRtgCAezg9Sy88TRaSqWqgytfqkp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX5IanjNoBo/GH
 Tf4G4RbChEIohpqlcaKvoJGEO1+ucwpefIg+Ipp4ZV6Zx1qrJPw4V22m53OVd+UA2fukxtwZUPg
 j7bi4fvltpzsJi6/laHEcMC1oriXfp8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEzMiBTYWx0ZWRfX3iTFgbpfF/2r
 rY+p+8hHexojoi0knc1Yto6EhNa2XrlG+xJZBX1zhJpm3Dfa2K7e5iajNbqvQyT8ocrS/I694Qo
 DS27LHPB7agLs2ismB0Ug7GPqdPDtUx2mpFhgFI/b8aFtlmeT0PZ3i0AWL7m0mePt0Tm6zx0MUd
 yeygBkZ7joYVzY20KnVDJTFEYucBX2BpdZ30cTgSIbo6NbFw2jwJeJ+HsjP9ORR3seOdMSx8K5G
 x2Z5mbFZ1mRVvUQ42FTFT+3bZ6D6YK61YVT5Arpbn1BwsApv1lXT46yZDbCfiQU6z7UKxYUZfLS
 87vCAfidlkhy/jWSEDtLyK5z/9xxCQ3SQwb97iKAS/qrRUA1sdjjkoBzpznBd73qBLhjyZsi4WS
 //Kzp7CFCjtQS/ej8b66tWsiOkdFCwMQaFXJNSu7DAmP8M0S+nIA8NGHVh0skHaBjKhWEAsideV
 D9jyAysR/wtENurDRmQ==
X-Proofpoint-ORIG-GUID: cpS2xRtgCAezg9Sy88TRaSqWqgytfqkp
X-Authority-Analysis: v=2.4 cv=Ifm3n2qa c=1 sm=1 tr=0 ts=6a5f6594 cx=c_pps
 a=LgTXwy+OxRus0W5fFstXuQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22 a=64Cc0HZtAAAA:8
 a=aB6u2EZEa9mQxSzGBCIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
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
Fixes: e2358af5838d ("vfio-user: support VFIO_USER_DEVICE_FEATURE")=0A=
=0A=
Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>=0A=
---=0A=
 hw/vfio-user/device.c | 7 ++++++-=0A=
 1 file changed, 6 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c=0A=
index 3d0dbe8406..353fa5ee21 100644=0A=
--- a/hw/vfio-user/device.c=0A=
+++ b/hw/vfio-user/device.c=0A=
@@ -79,9 +79,14 @@ vfio_user_device_io_device_feature(VFIODevice *vbasedev,=
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
 =0A=
     msgp =3D g_malloc0(size);=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

