Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5049BC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 09:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjxGh-00077j-8d; Mon, 17 Feb 2025 04:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tjxGY-00077E-3k; Mon, 17 Feb 2025 04:18:14 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tjxGT-0008Bd-Ec; Mon, 17 Feb 2025 04:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739783890; x=1771319890;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tvjAtnEo57fGQ3vTRMVAS5zhjyLrO22piPUDiza5t3E=;
 b=P3rS1t5DUo2BkFHbCMTbXr0e0cnsEvJrN2PPr4zX/jBFgKY5AMmEyScH
 v5gl9NxR4s8ExtET8t/tB4ifAhDPyvgKfGD5R7k59m3NSdCsFoo3FjokA
 vO2PF2WYR4Niz1DKeBxg42b5FbdAqbqvoRfZ3fzqj2nkqjy3vY9eeNvG2
 x2Re0J+FuCSIQFCUc8bLYPZs3fk+gkIuDgL+rsOOXMK1ZUO2sa0KpE/0B
 oBGV36h/x4TKnq1LsR8xZw7o87GjIiL1vkoRK8FDIHu38TcrTwjFVMEoZ
 uHyj2fy5bgPqLNOrh+8Eh0DBt8aIWkP7W/51Q2eKbu5feCeCobR2JlEgc Q==;
X-CSE-ConnectionGUID: Bcl5wZW2SuyNzvfYCmdyvA==
X-CSE-MsgGUID: s/KSMrqFTimvR/kkWMkm1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="62928677"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208";a="62928677"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 01:18:06 -0800
X-CSE-ConnectionGUID: ExqPBtaFSTGjtIKXT3a1EQ==
X-CSE-MsgGUID: l7ZAxHCWSWCIWOQo50Mdcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; d="scan'208";a="114697007"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2025 01:18:06 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Feb 2025 01:18:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 01:18:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Feb 2025 01:18:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcXTvY/Y9j55sij6+Rq6S2nw7qsJFpMgyx61MT9D8aDgD6HZlqjNErP24/5k7Zvs/Bl5ItSKRGOD/HmRwgt4krzQ3YTLGeOOxUVdTVVpRHkAl9S+1Un4X/06MkP6GVrBRacpuNzXQwq+UxXTkq1blQ4J+VjOt3ef6b23hgW1b4bGxHShz3n7aPoToeok3XUl4ZW31Xi4trl26h3YiVaqfkQkHaXGehl0hwm5v+szyRLYfDnQPrm2CQEuu7uLnjd04mNPeqPJU527k0mbRKFVQcORFheJ4elOVRIlPDreCHjEW2MnCIPh37Ngqigpbzx3ywuI7vwhO450K3d7f1vFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ti0gH2j7m0y6xZ010kP8/FA2qqjVo79RNBuUIV7DOE4=;
 b=TbBURXL0S8puCj+Pg1kl30aFxlRy/PPu2MroVmP5NcZvarGM3FfomOq/ZeXVEmeMYN13ImKf9Oq3Py7NHz3QMlfzcTUVJazgc+9Qo/ZvmCf9sA3tOkSnYUP3MZuN2yi5RsEpazHDXcfhRRepEEDV8wLyi7C88axOWsoNzqmT737mzE72LF2zE/xcXDDksesHlqh3FqjPF7K4mOsBpijITN9wW2KQBF73ziDDyEwAJS7axyr8ETVcIEHVNJ+ZlbZJQtdyEuwOzMwO1YD3Q6rHzBhTliN28LUEFRE7fWMo85ESygngWF3yeh8BzvEeidUCZKXaThSTfO853MBbcvScyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5805.namprd11.prod.outlook.com (2603:10b6:510:14a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 09:17:20 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 09:17:20 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Nicolin
 Chen" <nicolinc@nvidia.com>, Donald Dutile <ddutile@redhat.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rLkOMCAgAAM2QCAAAz2gIAEhqeggCVVAYCAAxlYAIAS3VEAgABWAvCAACxmsIAnKXxw
Date: Mon, 17 Feb 2025 09:17:20 +0000
Message-ID: <SJ0PR11MB6744B3D96A98584525B0401292FB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <568014f5-25fd-439b-b70c-9cf50f31255b@redhat.com>
 <Z5HBJOgO4tUJApY+@nvidia.com> <8fe09b60e6f04cc6aec99b72b46b2fb3@huawei.com>
 <SJ0PR11MB6744943702EB5798EC9B3B9992E02@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744943702EB5798EC9B3B9992E02@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5805:EE_
x-ms-office365-filtering-correlation-id: 4b21b787-72d3-4576-dcd0-08dd4f33e198
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3Usk4HCbaFRXF0szbJO3DbzoAGBPH5AfYTrsTrj5LYH2OmV8229XNxayhR?=
 =?iso-8859-1?Q?hCzEmwmA2xLVIMC1JxTL0/bHA2QBjcJ+WkQFVApNRc/H4e0Phsq9Rlorzs?=
 =?iso-8859-1?Q?3VwDJ2pJoCnF26wnvUd2cxE1QXLjzp1o6Q7HdI6ppNsKKYYZ4Zht0lJkEh?=
 =?iso-8859-1?Q?+a3w5+fKb8kLt4fkcTzubopGsvLk6bZE68DbM62/EbMqVwRwJzrJ6cu1wT?=
 =?iso-8859-1?Q?DoiXMI3AOJRxDL575imp9CNhYdTGhPfex+hFyD+KrDIkiM01qSXnODOEhr?=
 =?iso-8859-1?Q?2D1prVXEXMxsAWnwVQe+Ho1gvzjsTpawzzdVEa5Mf64qyR/zpcjtdImIM1?=
 =?iso-8859-1?Q?nVL6zNDkLqnqHhV0O7nEOYrVvN/E9Bsi1YUjQVGIhNBzlPqBpsjkQK47gY?=
 =?iso-8859-1?Q?0uzV+OKWZ7GuR24az9tZeQ3RdxAryMsXYMkXQn9hSRzeol5KS1cAWOMRgo?=
 =?iso-8859-1?Q?s+kq110NxnbJAn4rmXEZjDnoqUIlxcqxbBe+5VAk9xaTkjPqKtxbUfhP4D?=
 =?iso-8859-1?Q?4YcVcbgRvZZ6KoIQ2yC6EieKWdRtyq7YtMMLOfOu40SCLZtvmTs9ZDCdwZ?=
 =?iso-8859-1?Q?B+QLbCsBvsbjm+2sAwmd6ytgL9OVISbTGFsa5J0DFfQbutwyjfgOtiWrHe?=
 =?iso-8859-1?Q?JGhOPXr2L3INCbBSvA0L/m6CjXNJiUZeXa+bNdkGvVW99J6Gfn3t0yLzi5?=
 =?iso-8859-1?Q?MOxeo9ssKAZNJMO5yy8y5nltTnxIhSBkj8Adllavg+qn2ykl2XbLFVZScR?=
 =?iso-8859-1?Q?fM8jGNc6TyyKLAZsZU8wHeLm5JOubPC7Jkt3EPAFOQcY1FY/43cVmE4Hy/?=
 =?iso-8859-1?Q?KPk+aNS4x6l+Xnd1H7/2aVcSHe5MKAALgIbfzbIZd5fZy7cpvvwy4qogs2?=
 =?iso-8859-1?Q?xaarLbPTPup8hAWui7TYn73j9yJHZBU56cEWOd7WvKLqQrmKiz2VD/VIQX?=
 =?iso-8859-1?Q?a9szYG3sja7lM+GAOVZIGvgGckHdqr44mywjn1uiOJD5CBfEK7sk5yevzG?=
 =?iso-8859-1?Q?mD1UlaSNXU/jBaGMzt0Q6hebmEspgSSuv/Svv2vSIaYJTAk8K9/rSgaD19?=
 =?iso-8859-1?Q?E+pyK3mY2akYgwZVbC4NbWcIKFOsfdTwTOYgkfMhsDWNxx+DxWBOYNPwk3?=
 =?iso-8859-1?Q?zWzvPmLT2ooeEI/yExAcmzRTrnd87XJ27sy1vJ3F56P1pODhkoRFQz8E6z?=
 =?iso-8859-1?Q?zs3y7fQoMpYG6xUmECTiGTRF6ezwxztMw/zAC+ynKupf32zkzI1aUkGemh?=
 =?iso-8859-1?Q?ik59gwB1BvMo7+jWy02A8fiPC3DJXEax7vz5oe1ViK/oVjgpGEIrnlc1xy?=
 =?iso-8859-1?Q?RjJ3GcE0sjFil46qztt4WLvt2G10MaONz0NTvpdaY2aU3vzcBAX581xTVm?=
 =?iso-8859-1?Q?l4oMzDwabzaquYWNVHYyrFK1jZRSnfp1dmrmn7y4xsnvNgJrrOj1lx3Ji0?=
 =?iso-8859-1?Q?5sRLmQONECojwN0xZuGRQqGCoXpDy9k3rC1hqQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AXT9CwiLFwCyZYtV9Yrqo52NJEcdeud95t2AW8Z52+UPbtnoSoJ0Ja4mKo?=
 =?iso-8859-1?Q?Cx36zj2k33tQZwgygCyj8jrGh/Yv4LRSboZNMorWgCqsxXdILYlbQEYwyP?=
 =?iso-8859-1?Q?Eql3Dbjp8xBCzbbs4hLSSjgGWRJ7OnbqePff5eelI5zXzRu1MstJic4CIT?=
 =?iso-8859-1?Q?fDaFEjzIsqqkKfSv2MVzqSCS8GcGTjyPhy1UT5bCBOow50R/ewCPA5ToIe?=
 =?iso-8859-1?Q?ZGxm0UwUOpgrFH03qDSft8kryyIsz0H5RL1eJhI7t26IoALAfF4jaDeBLq?=
 =?iso-8859-1?Q?EfUuEfDxi0XraTg5PoQGKFyJKr6W8xzav/OiXFsMaPrVjGzHdwVMenETd/?=
 =?iso-8859-1?Q?/eE5AHLTL9VZnrFdJ1NMCaWK25o+YoWJYYmM0bH03daHqY/sPFmB6v3OHz?=
 =?iso-8859-1?Q?uPj/t+KMB1PCdKZMrUMb1ys2biPCNKCAuAovE1bgLBXAIXXmlU8Qy+4leX?=
 =?iso-8859-1?Q?YqPKG+zjmDKEWzTcZ+jTqdZvPfV0Dw/J/B5Pcp4PRTHpsQxgcNpz6czJBs?=
 =?iso-8859-1?Q?VZ5JibhbfMedvjrAmDqiLiH6NDV/3q2HxFJhsspLGFRDgsjynWcdai/S5u?=
 =?iso-8859-1?Q?eFALnp9PRMiMsPnVdkkgqEFjXknxcSguD4O7VcBm1R9TNXfIfud6Z3ocRT?=
 =?iso-8859-1?Q?r8GUuSMo9U28sVZ5IDq1Z9ZuRGCiKzhUHNoL3ZJh9nqCAx1RyhOxkMpPBa?=
 =?iso-8859-1?Q?iz+pg4ZoFEaY9yoHloXaqum/8UZyQU01fEBAFN9vQ0EyLcg+7G0MDSUp8K?=
 =?iso-8859-1?Q?9GbxR76Qyn/0s0EK8jC9FyJV3LHP/uGA7aunxVU9elsmnySYntDalljjz+?=
 =?iso-8859-1?Q?JHlq68jPtNhCF2ucoHQRqdeZrSSF1TqFxK3tsDjhf5WXA0sDBG31hZwhd1?=
 =?iso-8859-1?Q?hEskJ1uo019oPXnadKIewnvz8MR4XuHQqx/ImcWgsSjA3K7sE4jcDvvvSx?=
 =?iso-8859-1?Q?n8CE8FJfxLqbBvHA+dwEkp1tDFnZMjNe6sD5HPBoTLVnmULROSaj7SYI52?=
 =?iso-8859-1?Q?tv6u2HVaUNBRo3Cm0WkEy1JPw4ZutdP1cMA4lpWMAbN7iO2wZG9Okcy5Kj?=
 =?iso-8859-1?Q?a1lhN8td7dXAGhgblZYdtkVh7k5UZbq8e3xcW0KvJCBwVGEnIoME5IIvc8?=
 =?iso-8859-1?Q?lv1ARnkFHu0vq2Qt7xcHraI4Mup3uI16pweLqkaQEW6TAWCgOjEBDOj0S/?=
 =?iso-8859-1?Q?7wDFCVqWhDKuHSHgPB15Uv1mK4LpsU8kRRWnAjdJwpcDxQ8+n+iRgFS63G?=
 =?iso-8859-1?Q?58U7jI2HnF+SXFIWjhzZrtq7a2Qilr+05a5GVNqgo0nZavFP1453oKv4D4?=
 =?iso-8859-1?Q?LSw8uGvBVHbT85jJKLnkz4yd/m6oiMVDxXvcxkZkGLtY6vT1PsQHZfG9zb?=
 =?iso-8859-1?Q?os3kQ7lOeJ6yvL0oD/WZK3AnMKJefBK37k626m9MWOX2spLI6xYbNRkCYa?=
 =?iso-8859-1?Q?RDNa6A4vWIxYq5hStmecOtNWbEie0CHcYmJdM6653NvqOfKa+3DvmPm3dh?=
 =?iso-8859-1?Q?VKTADFSjXNcVfl7k3iAiyQgZ7HyE1wtSFdPU6323m548S19wwDgOtAK3n4?=
 =?iso-8859-1?Q?Cx523QCVb3YzNwoXQh1jCY1fD45Glm+tRzS9/6x38hbCYzXfPxlq+/Kor9?=
 =?iso-8859-1?Q?T786af104qEB4nUlPMMFFUOFqtbadE2zeI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b21b787-72d3-4576-dcd0-08dd4f33e198
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 09:17:20.2842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CIJ6WV+1weBD0P2kNA9bqkE0gtzjjFneA2sZXqKGZvi9Fl2uucUnk577JKTIfcEbGMrJGH6NsbiiF7U1jASl9WzkLl9zdqnFyN6cmqJ39Gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5805
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Hi Shameer, Nicolin,

>-----Original Message-----
>From: Duan, Zhenzhong
>Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable n=
ested
>SMMUv3
>
>Hi Shameer,
>
>>-----Original Message-----
>>From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>>Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
>nested
>>SMMUv3
>>
>>
>>
>>> -----Original Message-----
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>> Sent: Thursday, January 23, 2025 4:10 AM
>>> To: Donald Dutile <ddutile@redhat.com>
>>> Cc: Shameerali Kolothum Thodi
>>> <shameerali.kolothum.thodi@huawei.com>; eric.auger@redhat.com; Peter
>>> Maydell <peter.maydell@linaro.org>; Jason Gunthorpe <jgg@nvidia.com>;
>>> Daniel P. Berrang=E9 <berrange@redhat.com>; qemu-arm@nongnu.org;
>>> qemu-devel@nongnu.org; Linuxarm <linuxarm@huawei.com>; Wangzhou
>>> (B) <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>>> zhangfei.gao@linaro.org
>>> Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatabl=
e
>>> nested SMMUv3
>>>
>>> Hi Don,
>>>
>>> On Fri, Jan 10, 2025 at 11:05:24PM -0500, Donald Dutile wrote:
>>> > On 1/8/25 11:45 PM, Nicolin Chen wrote:
>>> > > On Mon, Dec 16, 2024 at 10:01:29AM +0000, Shameerali Kolothum Thodi
>>> wrote:
>>> > > > And patches prior to this commit adds that support:
>>> > > > 4ccdbe3: ("cover-letter: Add HW accelerated nesting support for a=
rm
>>> > > > SMMUv3")
>>> > > >
>>> > > > Nicolin is soon going to send out those for review. Or I can incl=
ude
>>> > > > those in this series so that it gives a complete picture. Nicolin=
?
>>> > >
>>> > > Just found that I forgot to reply this one...sorry
>>> > >
>>> > > I asked Don/Eric to take over that vSMMU series:
>>> > > https://lore.kernel.org/qemu-devel/Zy0jiPItu8A3wNTL@Asurada-Nvidia/
>>> > > (The majority of my effort has been still on the kernel side:
>>> > >   previously vIOMMU/vDEVICE, and now vEVENTQ/MSI/vCMDQ..)
>>> > >
>>> > > Don/Eric, is there any update from your side?
>>> > >
>>> > Apologies for delayed response, been at customer site, and haven't be=
en
>>> keeping up w/biz email.
>>> > Eric is probably waiting for me to get back and chat as well.
>>> > Will look to reply early next week.
>>>
>>> I wonder if we can make some progress in Feb? If so, we can start
>>> to wrap up the iommufd uAPI patches for HWPT, which was a part of
>>> intel's series but never got sent since their emulated series is
>>> seemingly still pending?
>>
>>I think these are the  5 patches that we require from Intel pass-through =
series,
>>
>>vfio/iommufd: Implement [at|de]tach_hwpt handlers
>>vfio/iommufd: Implement HostIOMMUDeviceClass::realize_late() handler
>>HostIOMMUDevice: Introduce realize_late callback
>>vfio/iommufd: Add properties and handlers to
>>TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>>backends/iommufd: Add helpers for invalidating user-managed HWPT
>>
>>See the commits from here,
>>https://github.com/hisilicon/qemu/commit/bbdc65af38fa5723f1bd9b026e2927
>3
>>0901f57b5
>>
>>[CC  Zhenzhong]
>>
>>Hi Zhenzhong,
>>
>>Just wondering what your plans are for the above patches.  If it make sen=
se and
>>you
>>are fine with it, I think it is a good idea one of us can pick up those f=
rom that
>>series
>>and sent out separately so that it can get some review and take it forwar=
d.
>
>Emulated series is merged, I plan to send Intel pass-through series after
>Chinese festival vacation, but at least half a month later. So feel free t=
o
>pick those patches you need and send for comments.

I plan to send vtd nesting series out this week and want to ask about statu=
s
of "1) HWPT uAPI patches in backends/iommufd.c" series.

If you had sent it out, I will do a rebase and bypass them to avoid duplica=
te
review effort in community. Or I can send them in vtd nesting series if you=
 not yet.

Thanks
Zhenzhong

