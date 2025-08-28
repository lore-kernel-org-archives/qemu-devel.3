Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1B2CA0FF7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgJN-0000T8-CO; Thu, 28 Aug 2025 13:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ureW3-0003En-BN; Thu, 28 Aug 2025 11:26:19 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1ureVv-0008IZ-7N; Thu, 28 Aug 2025 11:26:17 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57SA2B6v3413377; Thu, 28 Aug 2025 08:25:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=XqfadS+meL8TigJ
 2LSmLGqIMTG3yEBqCEenqYNXoTzA=; b=1+lqPbELsWoa1Ll5/HOgMCyGFzkp64g
 aLMD+WSIb8i3Y24p2IhHzZ6/Z4obXL2NxxfEz4b+DFlfxDcj9jeLvF13fhU5wo4M
 Bv13Vh0BkSEbI6CgbEMo6bEJP7NdMBwbRG3bJZlB/nmGXZyZ1x2iCBGh5FFVJIIx
 NUz9A5as6snv/6d8VRsxAAB3EOa7vtC4aqd29zmRSqMiZZxrXz9n5dtY9W1UvbTH
 Bf8VgVVSD3i2DThIs3r3vETmAKYuna8H2TcvxwytbyTnzoffinn5XN49HoB9LJZ3
 ESVz7CipPKk4KwYIrd2sp5WUsmHnxDQG8xSA1TwspDT+FARyzTpvkuQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2096.outbound.protection.outlook.com [40.107.236.96])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48tbd9svrq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 08:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEToAyzMojt43SxCpkg3appKKh7AppR0dWWQ4RuP3kzYxGSpVkJFoioCQmMUZRks4+wB7AQw9AvWHDrodaaZqjCRnu26PDs1rXGgjflB71PSzprx7utXpm0DNnDnKMp/hZmzshLflTwVX8/7+toHTcOm+U4kLRjczD32DNzds6/W3YWG18xeroeWVXdKYSe479AwvkfqgSzMa2rFHBIO0N6iOHcqtPLiWmqazoSoRieUBHPJaU3vnb6oPdsIxi+RDLoB0CWBhXOf48kEyzoM0HI1suCRnWUSab5eJylyNIeRatM9svXCVzaReQDtaR6xIpwrD3JcIQRJqzhBcqvKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqfadS+meL8TigJ2LSmLGqIMTG3yEBqCEenqYNXoTzA=;
 b=K8smy3L2ujsSIOtRhOCCgizUx5pX/xPVwVaJX6nVocO/N+3ef/ykslsRh/7l+TeDq3MDM6pxtDzwaI+fjZgkOZ9gv/RHmfXqJ5ocFakH2S0diotKzilW42vvw1jds95K7zJsf78CxX2v7Bk6ggmpzngFiqxpw+IXO4Dq6hHIHmoUDl5mj6ZeX6QHtlctkEw70VL4ZAG/gu3BlgdYdJICcQz34xsMJPDUZoEgGYq0wBHTSWwDKCUq0y2zQzDZ4kYnJrDquV60pQ/7fOHp0wqnl58kJ042l4MjKEvB7IqDCraf2dfHjhIKUxELsqNlZLY/x9Ypj1ZGACPEkO/s9BGaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqfadS+meL8TigJ2LSmLGqIMTG3yEBqCEenqYNXoTzA=;
 b=WjWPAJW1/9o6FTx121noXyrZ+DRH6u1TkZoYdCeDxnIbgH4BnzvEuyBALVx1//fNFmdHiucDd87qEakmiV6iRioj4Koe2b/SSkjcr8zxY/tTdptmfUIhGivRuBeSEtYvZySw0MQNsEaY8y3O+cSpIP2Ja+Rg3Ri+Q8QO+ES9YsDizKXK45kZvsulIZuMZjQ97lTmFR9NI4ny7NUO2m6kM6wAKUqxXuCbJOaJcuIlCxWWM3ppBUI5T07vKbPUiFl3d+PEofPEX4MZyvUmt18d6oTZUpHMSwUaUKHR1g7oTepZFiRQfncDVP26G/jPrbKG4Oe0TRTQZz9ezOgEmYcwSg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MWHPR02MB10523.namprd02.prod.outlook.com (2603:10b6:303:283::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 15:25:53 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9052.021; Thu, 28 Aug 2025
 15:25:53 +0000
Date: Thu, 28 Aug 2025 16:25:47 +0100
From: John Levon <john.levon@nutanix.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 thanos.makatos@nutanix.com, alex.williamson@redhat.com, clg@redhat.com,
 steven.sistare@oracle.com, tomitamoeko@gmail.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 09/22] vfio/container.c: use QOM casts where appropriate
Message-ID: <aLB0-8tLV202Rpwg@lent>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-10-mark.caveayland@nutanix.com>
 <aHZh7JmS9iEBkFBE@lent>
 <1a3457cf-978d-40f3-8b1d-163dab362e68@nutanix.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a3457cf-978d-40f3-8b1d-163dab362e68@nutanix.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: AM0PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::45) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MWHPR02MB10523:EE_
X-MS-Office365-Filtering-Correlation-Id: 32da17c6-b6dc-4339-2fdd-08dde6472ccd
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S//SffOyPWDXbh4jTbhj2YEReJc7vFTpMj5KdbLjgTSMljNO1f6KXMEAhzWr?=
 =?us-ascii?Q?Q94eqBwKFoPuJvDxoIVWoziZfcU9c1LdNy7xwPfTDI1BuzjHRQkFpveuL0Tt?=
 =?us-ascii?Q?qYtKvh0pVniv6oYBMN+iESeWsdqajaRlEx8DZojzNxdNKIR3QgP7mZr62kkk?=
 =?us-ascii?Q?9ddoZN6XUnILEJ7TOoVqMADlyEFhZStwffEuL70eFjg5BlvKH2QOMG3MS+5f?=
 =?us-ascii?Q?YKuVe3CfswIqtfsOJJ8XUHcSeOsRv68fz+tNsfuFMoK3UjxPUJ6GCnxvThiH?=
 =?us-ascii?Q?tZglsNGdfJ7qy0iXfYEc0ryym2hq0x7fGN8+mthcPCjYpu+I9m5VzB6ETZXY?=
 =?us-ascii?Q?aoLJ5uCAzP6ugqerZKUz9EZAXi1GRu25sOHlC+4rcKW5h17oHIZRlpuYD9Ii?=
 =?us-ascii?Q?vOreUKB9pJg4qGjYwB3MVIZ1IpBWQx27500m4g9lYRY3dIW1gQ/r6yu57PiC?=
 =?us-ascii?Q?qFEjnhYB8MEktPQzDUybj5/TH2AAVuQXvONqqvW7V63pHlhgeR/eenw9rCHB?=
 =?us-ascii?Q?9uTudQb49WfQRzThoe3o9Zlwg4pcAumSUHtNMpRzerooURskdr4D4Xmfv+CO?=
 =?us-ascii?Q?k/TwdursGl9VZSrOHNNZb2Cmtng/AjthpzI12Tj7B2TAJ4OUbllGgRg3XW81?=
 =?us-ascii?Q?1baa2hV++bdeH+u4otLQC89RILImaANc7cQbGTSjdx4npX9ZXgP09vaqLOY4?=
 =?us-ascii?Q?mwXP74Oi2kwGwAqS+ugjrXXJBGIW/lSAN85I1kDx4qRHVibPopeiPPzBXjaV?=
 =?us-ascii?Q?pdEz0LZ484GY62+S0oKfES+kRMRTmErrHl13PMrlpekNHx7nM1sr2yPILBg6?=
 =?us-ascii?Q?U7txK42VtgWHqJ3nl9Wljcb2n/445QCD5h1ZtIbHuw8DqhEAm19oRcYWnq3e?=
 =?us-ascii?Q?U6+pYtype9hHaxMcSZ0gvVBNP2Jp24UigxdCfe2dAbbBzy6Rrw4Ioy3ULI8r?=
 =?us-ascii?Q?BWum5fb8QKviW1aNYqsIWkrFq0YzT1xVMiBTRyqjCQ2tf+WQieyxqSiZ5+Wh?=
 =?us-ascii?Q?GkJaZpXtb8gyhk6vzMN5MsKHGf8TKm7om5cfggG7kvZYFkrIUUtNudok+pOM?=
 =?us-ascii?Q?KnLVnwJfqYYTUni2Tb3zckSPcBDxk/af4AdBIBomH3ky0YihKn7Z+v/CVEAA?=
 =?us-ascii?Q?ks7j80y3PH7Y7nQKiU6Ing9CWfro31D0jpbt8uMTcLJ15qqPNkKSAv6pSFX/?=
 =?us-ascii?Q?9tDvnIsPZVWzTDBNi+O4Yx9II1mDeSZvMxM31MiVw7NB9dizQjiZ29uQTJBt?=
 =?us-ascii?Q?hO8QaItpR8pwv0IXpNKE2NlaaWAEIlbSXo5hor1/gj7AyJLUlidLYeQvScnQ?=
 =?us-ascii?Q?FSLfxCf/4D+3qm9Q+iXZqo9+/xWPff2nZHzV2Y01tlD61sWZpXerVenx7sx9?=
 =?us-ascii?Q?NGJ+n75Lvz0aXKh3HJiPFeyWfwwDcj9iQgDTzmac6oztBcMCUpMhmLXa5RiY?=
 =?us-ascii?Q?b6tbSb+Ruyo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jBwgqGf50uJFrlFXgCl1vAOVIQIUKnIbAOXe1TsReJPlLcVFQADkJyGPE5+4?=
 =?us-ascii?Q?pNhG1k/VVKQ8Ro/nsjkHBl2o/ShrMZ0pvfhdSWWKiLQkBqcrgzIMYnc9gd50?=
 =?us-ascii?Q?LI0Z/uD8iw5gRozaqTNFbb3QBbe7MnBq6vs9UGy4Hc91N70mfg8J6h/xuDaZ?=
 =?us-ascii?Q?vr3ZUkoYO1cthiovNL+PPzX/+tZJxzSTbK1i8ffdQjB91v00wBYYeo8gl38c?=
 =?us-ascii?Q?b1rEo0ExkYoJ9scPvfrxCnSjoxQ1ZderflI0fumSzpq5NcNqFpMy9uPfmptA?=
 =?us-ascii?Q?DrEznJbaGoVQSZqDQmgLtyaN20VheF7h4RGsv5hs83/3TgqAbnt1ppTBLrR+?=
 =?us-ascii?Q?q0uhT5Q5+X/9ONci3TBMhZ1gM3kaz38rTMd/C9R8UyuS8UfIT7TmpnizPjmX?=
 =?us-ascii?Q?nykvMoMZlJ8f8k+zJ+B9zcImIWigyLroWaVAUbjyfXcZah2KIcsRBg6vjgN9?=
 =?us-ascii?Q?MjY5XCZJyPXLyAXk23lgNIOw0uEoNpE08HTAiORsEi5YW+36zyhTV+kGTdIU?=
 =?us-ascii?Q?x4qIrY4y9eJMToXZEvKnGPNNN+VcQWQR9CInSojlyLDBipzVngfGCHgPUFUe?=
 =?us-ascii?Q?NZnphhlSnOvz9YG5/whzlRrqALlF2ZsJwEawdvEI4fyN01gmcVpqzqUIEsrG?=
 =?us-ascii?Q?eN5Q2HZEPND3GF2LPtUK4Y6Axf8vmWSLOydbue/gcsMHKZT2WQn7k42ZlKwn?=
 =?us-ascii?Q?01z8VtRF0OtmKihoy1IGGQxXy6jXcDQGOzKOWAr1zpM55O7Zf9aAehUh8Zs3?=
 =?us-ascii?Q?PssHlH9Ag7uyGDyqk49YogpO7UFckR8nLlxhsWiVy7CE1jPOd+NXsEwbGIIP?=
 =?us-ascii?Q?tSSaV74ehNT5qdkC+5nkLV8Sr4QhRnhrb/zNydX2KDvNDk4mv8S+kuC3D9K+?=
 =?us-ascii?Q?X8VG0LgC1N7WKu4qI/4caxLvxLAoKzUya21t5Kg1IDmjiR3MT++DZBN2VRHg?=
 =?us-ascii?Q?4oui0uiqawbgZi4F/0G3B1PtJlsxonwsoE/4x4luIf61OzQDudcYD4B31STr?=
 =?us-ascii?Q?s1Jmpjsfsp+JUb0Yc51X1OdeHpKehPY4PF9mV/H8qXbbSJhEPKdXkAJvnHGa?=
 =?us-ascii?Q?d3/ud77oUphWtthST1z+Q3hCqXCGu/v7F8jY4POK4EHPsKyz6/XY+/DQXUvU?=
 =?us-ascii?Q?aS5D6YEDD/s1n+T+U6zrmuS+Ue6rCBmjKR2ac3RLk0ReoJB4yvVZRcwkrBKW?=
 =?us-ascii?Q?lDICfp+Y8YFsSqTuOCce/x9dR+lZFi79vJmC8B6NaKeE9jEn8MD72mAZOfR7?=
 =?us-ascii?Q?DGc305SH4yQBurMW9rwu27qVMDqMWb6zp7Y4mRjcMuibVF/jxH2bbcwYruYr?=
 =?us-ascii?Q?8VYPKkXnz+JU8/+WMr2rbvqUrhBRlmECaQv4Am5u5ltwQLTSIJ/i0lcmfFRy?=
 =?us-ascii?Q?1TgX4RM3D9/w42jxWnSaDRoAxHV73GL7MMhF76F1AjMW6S34aABgcFoux8Rm?=
 =?us-ascii?Q?3LL1QcIHQfEImwMXovSXvva5xOnpUg7hcyjfXJCy9RWPqUGcsSVDIB4pSbHH?=
 =?us-ascii?Q?9E8wSGrDvRlo4ATj1/SpYY9VqQ6mAkDquzWT6jP00t4awC4W0FOrtcsEw0B0?=
 =?us-ascii?Q?xkr9g7Ow1dPjKXJWJSeYK65o++o/KH02tKD/6lji?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32da17c6-b6dc-4339-2fdd-08dde6472ccd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 15:25:52.8866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9B6eAY8O/uz3csvchjv3v2m9HF8c+KzX3CGPGs8rKOnoE2wW3v7FIb6znsv4m1BIKEqRZ69C9bgdiikOyLzoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10523
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDEyOCBTYWx0ZWRfX4ZcNE4eU01/K
 4ekbEZn+HEAjg2p7h8yP60s01S/ckUYPkWKAMLVDZ56gIvQYJBc1P1Dg01DRyrBQpV4m0Ah5SWJ
 WJcxBYsERFHneGYQd2IXbYKOsGFFPKmnfjGMcXjNIh1bZXo7Amtx+UUtoVICuhigAx0vv2P5yqF
 gx/ssxXd/Pb2zghJ/TZHPzQQuBYfmPBlLiis18WhmYULeb88mW4SyuW9Pi0eEbdvlV/fqUtj3o0
 mqeakn8iXvhsVeQ21quB/cXKDnMw0O60rUEwyvcXxpNZu0ncy9lvMWIDEHJq7yV/Ubf6/DXJUgO
 r9sLrLbzg+xug54uYP67JJ7LzpSpHEzYf54Cch8I08INwYnxTkTe8ARBQ8TyTY=
X-Proofpoint-ORIG-GUID: gz1A02fv9VoQTSQupA6ByerC7rK324s2
X-Authority-Analysis: v=2.4 cv=IZ+HWXqa c=1 sm=1 tr=0 ts=68b07507 cx=c_pps
 a=kjibDtZFsfb23vkhyTqs2g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=iYulMLyRRgnnG7ezGhEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: gz1A02fv9VoQTSQupA6ByerC7rK324s2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Aug 28, 2025 at 04:14:06PM +0100, Mark Cave-Ayland wrote:

> On 15/07/2025 15:13, John Levon wrote:
> 
> > On Tue, Jul 15, 2025 at 10:25:49AM +0100, Mark Cave-Ayland wrote:
> > 
> > > Use QOM casts to convert between VFIOUserContainer and VFIOContainerBase instead
> > > of accessing bcontainer directly.
> > > 
> > > Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> > 
> > Patch subject should be  "vfio-user/container.c" not vfio/container.c
> > 
> > regards
> > john
> 
> Ooops yes, I can easily fix that in v2. With that fixed, are you happy to
> give a SoB tag?

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

