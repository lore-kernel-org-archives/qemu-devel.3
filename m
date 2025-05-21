Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C38BC54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHemG-0003mp-48; Wed, 21 May 2025 04:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHemD-0003m3-J4
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:26:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHem7-0001HP-Mt
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:26:13 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L50fb2020831;
 Wed, 21 May 2025 01:26:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YzHkYGwa4Yn0ZO8YMMChFLHhSF4iRiQOwdKmRYKk1
 Xo=; b=WF7ZvoMooPG34gLe6i0LliwDJUMJyT6kfB6GSby613R8Ig2z7NDOKfY+7
 MTk2ukc7K9ce6XbQkCnWYaBgkMHnpc1XFHwHStV7xHfuOFBD9nGfFyhK7p2+ENR0
 joyRdF/Bgpi/rbe3MGSlxnBA+XQhUaUvbZm4xrn1TiwuykO5MTb/Ip0PWS25jlK1
 6elpq7yBr8jafBS81nrdveTwnzZu90Lu/wfH/D/g1/2KnuCEKvrUR4hLGFt+xtoE
 Y2nvWBjrIoDVnaUuoy/SY/OhEGj0RM7Ob0pdrCEdINWWNBFC1VWBXOOk5VAeQWvd
 P2X3rrcslqsPoX6FCfetR6SYjcqsA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46rwgs1vwu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 May 2025 01:26:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rv5LxOu6TaDu7/twwfPQ8cZTwV23GCfq0tl+XjvsOZCIDkqf7Phf2RdLczESKIA6IF6jk0p5eXPOuLSm8nj8oHT5eDDB8A7vs6vFd1fEWXrxHbWXA6rY5WwEMCCBQ4rOfvPkz9Q+wo0DO6jkacBlNpU2fYGpBLZVlxLk76If2x0k7mdSq/ertd4emdkPXtGPtGI/EJBdpxqpRWH0VMm+cF5FVy4N+BZ7adyUW2svRPk6BAM0bgL3HXgSBWp8twxb/uQKuYZMzE7Sv5Udh5UWRtLY01o5hzhyAVsJRIbE0KiVKtqQAkeWl6svweW97jvvHmv4aLQGGmpbIPih+sLj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8zY0FuranLbfOrTosoRHixowLsX418JBJ8vZXnBiWo=;
 b=pJcbA/cnDoNkmwKm+nmR7CtqK2lututolpRzhdrpwZpEabuEXOlU4SkMToGWSzTtPb7R/89i2fscVlMzxfTs1ANVFHPkBUPOCSW2DyNhT5QINRxlKHgifrfpODHHxfHJoW8ychH/N7C9LjCnMHeaXSFRfx+DLbNE2qi/W6D2xnnKyriPnqxM0ricjU5nzX42sOeIKcw29mNEJzGBvJeRUQHMzulHdDm82al6ytc77isWjpWI1tvvLsL/wM201j7Jhzcs4Nj9KzHJHgnwQ7HOukT/HGmIZWpu2KQoPgL1ObwlTPolK24XwbnjXk8x+qkGb6N6KmZuOLeYXM4iVDZ8Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8zY0FuranLbfOrTosoRHixowLsX418JBJ8vZXnBiWo=;
 b=I/1jyphBZBxnpup1zkveH0UABtX72uz0XL/y9RX8WjVsGwJdh6V2ZUoLCw5QP/xlKaC4eHucUxSmnO9TwGdLGt5JU+RVyav2N4Mf/wGyngejbGjmIe/0wBlfuhfHzMi5KXxxaL7qTIToo3cbrsn28e61NyCPDRUaT+ss72Kq5WKZHx8zZpF9og6H96Eh630qKmHn2G1EZWrz/Z3uypAXmt8Tnh0vQ4IVhfD3eM/3XVH/nPdOQChz4PWe9/4y5XnQAymkGsznjqD2Lf2PPk/x5zk4aw1UM1hdu7q0yzS/i3H9Yvrs3wr2v6is5mg4sXfY8AQ9fBv086dZqljnq4TU7g==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8653.namprd02.prod.outlook.com (2603:10b6:806:1fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 21 May
 2025 08:25:59 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Wed, 21 May 2025
 08:25:59 +0000
Date: Wed, 21 May 2025 09:25:54 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: [PATCH v2 07/29] vfio: add per-region fd support
Message-ID: <aC2OEkS9IjFNiH1g@lent>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
 <20250520150419.2172078-8-john.levon@nutanix.com>
 <340d64a0-b85c-422a-ac81-4de6b10c8228@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <340d64a0-b85c-422a-ac81-4de6b10c8228@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM8P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::33) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: c798c3f1-cfd4-42d5-b1e4-08dd98411d46
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?TGLCGN6wVSL3AOpIa3N9oc+h4Wml17RMLrS2AqAthjgj4PpoepzYEkW2df?=
 =?iso-8859-1?Q?isBTvEyM8pIM6MmPdH6/1wzHEoqUqKAn+kTQTL+dO0jvCFryUlteHFVfWL?=
 =?iso-8859-1?Q?pZl85k3AVIL/fSg/19I8v+Xf9GQfkk0yF2jJwRrGThgF2hrIPUsKo3TvNa?=
 =?iso-8859-1?Q?nRmhqrK5+WqfKzjabekQmYkOU4r7PHoiK50auHYTsLnHAUPNqos2vIM9p0?=
 =?iso-8859-1?Q?8voAiRySzVRCePGwophSQg2+PzurUxMGfAro+TA28sGTYCGz8G1XJpkHTd?=
 =?iso-8859-1?Q?mDezZ/GkynVNpWzV9p12pOCmtZ50WRuhWkbhB3cvxg9jGM10wtn1IcoBTG?=
 =?iso-8859-1?Q?q64hYwiDh+noPXPjDNlA+e+U6+DUnxD1E4zJYXT5rsUPZ4sGyRidr4otVs?=
 =?iso-8859-1?Q?6D5xg27Cch+EOt1+ldfcFPdIFL0av+vTOJFAZev8hgvVjMuOUXBgPE3Xh0?=
 =?iso-8859-1?Q?21F30z1tn4ZzAPjqgJk2BKy1Ijxs+esnLHwv8kRh4O4CC70T+87ObfvCUl?=
 =?iso-8859-1?Q?h/FNY7rqmZ5b/BVC2B9TipKhqbuQuF7XRT0F0aLeBW4AVxRffjxti7FfHn?=
 =?iso-8859-1?Q?w1y33WOESAKjYyD/gcFNrB1OgmbAH/qVNryt6YX/dV4ZRz28rzJBpwNtSx?=
 =?iso-8859-1?Q?Vrggotg8opjOk31ZMc5YYkWeXzinekjAD19cE3Xqsm3mSo3CKoAzNan+cx?=
 =?iso-8859-1?Q?/PHCXLGabCuViHNW4L1m9cDXfraHLQn6kMKcde3+d2MQu9Ayqb/fFiYIqp?=
 =?iso-8859-1?Q?iwfiIcH8u+lwR+wFnnYVaxoi6r+DUc9Oj1b/AfKdszEiXcNp9EhyKugk1Z?=
 =?iso-8859-1?Q?eC5wb/mBWr7heFtE12qyaTQfSBNEx5VO9jrXbYZx4GXmGytNSIEGLOoUbw?=
 =?iso-8859-1?Q?7SyQCQsTyWYkKZ9k/fdJ+7vnUyl2Jm/IZE6lgwGXer9paLJ6NQFC17Hzef?=
 =?iso-8859-1?Q?5v3mJPP/FlW82WeYNIYTMYu5opQB5mI3OwH4BcUGdhNLbKjO0auH99NB9z?=
 =?iso-8859-1?Q?r7OdTgPscuEvZt2WdO3GMUe80g5XQqaXCE6GhHs2ndC2pJorTia91+EBEV?=
 =?iso-8859-1?Q?Pp+ModxNHbzOGtfHvOCVoHoB0GofxmTPPlzwZi9HhrRD/fNsdq/OYc93Pa?=
 =?iso-8859-1?Q?ylLNBhK5a5PWlzxyOu1uRky6Xs9nSkt/Gf2IInpbLaozsglxJ+vM4K7HkU?=
 =?iso-8859-1?Q?ArbzEVMBGUJjAA94qgDnwXP1DQsskE5INYGlOPbmNGH3Zt6bfDEx/CChwN?=
 =?iso-8859-1?Q?pzTDSv6LTR/dgK9EPEaFrwt5DuwZK62KdSzGL3rDcXAI0G6Z6XB8Z8epVE?=
 =?iso-8859-1?Q?+pNbxdIO0y6vNP8o62lGlUHOIjTD3QZ+YNsah9yJZTjEPU9Hu+Mr3PP6W0?=
 =?iso-8859-1?Q?Nin+M+6gpN+2/XzGqcvG6qmQkqO9KXbiPhIYRA+zOHSInOSW6j/QzG4Dn6?=
 =?iso-8859-1?Q?AvE6gyIiUzMDvPoWRqcKlSofwn64NebrM9F/kg7EqVHxvhELn/9tB1LT5s?=
 =?iso-8859-1?Q?4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hzWYblU1xVo8j19GRwk63JMHun8+hcovzFja2CYt+23j84gYZ3uRt5Hjzq?=
 =?iso-8859-1?Q?1+PbCc6s0DDVeyZneed1wvKxJcDLduus+mtJBHOfhMHGm9KO5W0r6UwPul?=
 =?iso-8859-1?Q?dEuNYFHNY4Efv/IPBNU2CtCW3mUVtymnksEYVbAXhmDpylv5DnNGgor7D7?=
 =?iso-8859-1?Q?BktSKB7BVJmmTB4AGcZoIjrRQV8aCTBHPmDZ4DjkbfRQDRv8Tq/YFlNaJ7?=
 =?iso-8859-1?Q?0MinOCzXBFuUP4UtkvRr3+/nfzJSaWUTaq75movsGmuYSC0YGvAA8HnppC?=
 =?iso-8859-1?Q?VfKGPrb2UZ0k4HUh45fWVguwPGHD1EJE1CJPKSuPUkBld6vaCCjy9WZ7oF?=
 =?iso-8859-1?Q?twDMiW0EwNxSPA0rJaeR2gTRJI896Lf1V7mOil2o+tjVGpiOwV8M1k++AB?=
 =?iso-8859-1?Q?j61J6JmRjSwRfh4Rtg9IMmFuqwZf5f/qdfc8gUOS5Y1illVu7dYzv8GdGw?=
 =?iso-8859-1?Q?vuyg/pzoST0e6NOSNOnEuVQcm7Lr2iS1h5wqURiRaY3ouIZMB5tAiXpvax?=
 =?iso-8859-1?Q?AkKn2D37NSJAAJNrPaSA8LBaQ+tbCb+ecdtPnpEzej7O/4dC6pptWcbmLL?=
 =?iso-8859-1?Q?HKH1zqdqPbnmEN3ZUeyxtXbNnCeSQmCOESwUa3X3xKbcEJCCiU+iW3AlDA?=
 =?iso-8859-1?Q?ke4PRW2StwnKGAJoglrYZwypCrWijxCfl3hV5WSkSOsjoTozkYKWfKAbSt?=
 =?iso-8859-1?Q?KdnBTTX2Pp3g6GWvZZZrfFCwjuGf2Z5T/nrdYhlfOhonXFOvSHV4QId+Fk?=
 =?iso-8859-1?Q?009OvamkCMBtiUOvzA48+tnhb/VSuP00Vru0T5U6s/rX2iCwEU1FWef6cz?=
 =?iso-8859-1?Q?iBFZXf191mj9spp30z68RGXkL09pUSWYmYuPH5tTaTKYe3hjYcPmZk+eW/?=
 =?iso-8859-1?Q?3f4JA1D2WGtiGFbIFN9LXsvDn5+EvXqXBHzYa0N44y9S8O9QoN1906AG3c?=
 =?iso-8859-1?Q?lpSToTeRuqCsz7apBi8XExNutnJklbNFK6IfcQFTAYQvJuaAyakbeCJMaB?=
 =?iso-8859-1?Q?W1AqU/K6fEiaLL+zrhPG+gY18TJif8vVTgnMceuka8RXf+XJIm7vtf3bxA?=
 =?iso-8859-1?Q?E0tFtSNQz+v3mVTrQnI6bra0GVDVQ0sQsVe0SWVN2SKVN5ZgP4xBR0KZdx?=
 =?iso-8859-1?Q?PS4ENUn63A1vsnT8VQUVOMVgVk9FlnuwJEzdvHsmuVvWBaSQv8R5aqAfSo?=
 =?iso-8859-1?Q?ms/9ck9NyMAkyE3fs5bsmKn8aUnAfZF/OdYb68IgJ1TvG+VuH4o95EkJ11?=
 =?iso-8859-1?Q?CnzHpGcBsGaxvw8YiOe8VFEjgG/stMtFn2v0NWioM/Orq/gvMi8uxeu7Wo?=
 =?iso-8859-1?Q?9BM87EH4+oh88eld/nnWuUv4QNGieuP8XU6EHWStnGnmkz0dN2txQbNFin?=
 =?iso-8859-1?Q?i2MgM74h7q7JbVDLfKLnSIIbvhrxTLfHgbfLjrxCPakI9RW9ov4Ffbsfza?=
 =?iso-8859-1?Q?dQUAPIFPx2nlF0UCGM7sd49Q3JuIZGp2F82L2FEi6Wt3M3hnbBG11tdxOT?=
 =?iso-8859-1?Q?lsDZbR2Kp+2qroUvScnQ48EOjmR83jpatoTTt/PDKyyJGBw9KuLvzE00n9?=
 =?iso-8859-1?Q?5xh9D8ZLd89ahX3ZE1UWX5tcX1/t/kCJKGg5y3yCq6zKsVzEGA7kLZ/syy?=
 =?iso-8859-1?Q?N4MhcMMqfsIT1Y796X70D5ng2YoQb94tq7?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c798c3f1-cfd4-42d5-b1e4-08dd98411d46
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 08:25:58.9865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcPf+TY8vUz4TfMgLDxat9K8os8bqovGRta4cjyO8pSULY6nTL3SA+MzZsvxWT+fvU1Xm3j3SrjlBslKrwfp6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8653
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA4MSBTYWx0ZWRfXzL+KWcXyi9aw
 FkALdkNE4+OS652JGDGHiKZIZao42CVoR0X2qX3fjGg1N6n5G9+CySSTAwRe+npBDIbGVKgoVzL
 GUBUbZbBkMqa/RgkX+QEUDrQKw4bGWBXDOdTDIvmCNoQzP8uCnniPip214q+0Kvjs11flwfEzcT
 AGabHenVTkHlxvy8U//2wU2B5rw3MY3hnAtP2B+FnC/eCSM0Hmt1DVcwQwm04Qawh9sQWfVX7VG
 uFDnoXmwurMiNCGpZ/NW/xQouQUqgPxMbH4cVz07nD+L3v7JnH0s/ltLszuKLByzofAiSTUdUJ6
 RstLtE40RZe4nT8YqDV5CwCFAXhpq+ihzF7yi1ig67/uqZXjKtziKsx5rDBQfNgC7TkEE+cx3F5
 yQRturKVEL2uFXkaogjnAfcbbke0vZxMiulQE2pvBvhZtflGz3Oao+BBO9BwU1nrsqGBEw0r
X-Proofpoint-ORIG-GUID: 8bZR3r-hPRKYjXKl0T7FYfD_7HhlCbdw
X-Authority-Analysis: v=2.4 cv=KIJaDEFo c=1 sm=1 tr=0 ts=682d8e1a cx=c_pps
 a=YkRwJB1Lcas13D3J5+BQ6w==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=p8-iE_GOF7vaPz944eQA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: 8bZR3r-hPRKYjXKl0T7FYfD_7HhlCbdw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Wed, May 21, 2025 at 10:11:06AM +0200, Cédric Le Goater wrote:

> > -     * Fill in @info with information on the region given by @info->index.
> > +     * Fill in @info (and optionally @fd) with information on the region given
> > +     * by @info->index.
> 
> The whole VFIODeviceIOOps struct needs better documentation. The arguments
> are missing.

Will add another preparatory patch, thanks.

> > @@ -29,6 +29,7 @@ typedef struct VFIORegion {
> >       uint32_t nr_mmaps;
> >       VFIOMmap *mmaps;
> >       uint8_t nr; /* cache the region number for debug */
> > +    int fd; /* fd to mmap() region */
> 
> Could you split this change ? I am not sure it is needed.

The idea was to avoid having every bit of code that needed the region fd having
to remember to do:

> > @@ -278,7 +283,7 @@ int vfio_region_mmap(VFIORegion *region)
> >           region->mmaps[i].mmap = mmap(map_align, region->mmaps[i].size, prot,
> >                                        MAP_SHARED | MAP_FIXED,
> > -                                     region->vbasedev->fd,
> > +                                     region->fd,
> 
> Would this work ?
> 
> 		vbasedev->region_fds ? vbasedev->region_fds[region->nr] : vbasedev->fd,

That is, region->fd is *always* correct, and there is less chance of a bug where
somebody incorrectly uses vbasedev fd instead. IMO "region->fd" is much
cleaner/clearer.

But, if you don't like that, yes, I can drop region->fd in favour of the above.

thanks
john

