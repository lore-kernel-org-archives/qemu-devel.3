Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F38FCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 07:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uozat-00076s-AQ; Thu, 21 Aug 2025 03:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uozar-00076D-9Q
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 03:20:17 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uozam-0004gW-QX
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 03:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755760813; x=1787296813;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MQ0PiqwBmSxr7Y3lYrerJAcznvGfKCC8EAIFdewTkjM=;
 b=FhE7nuOJTa3e1LRr5XvPuo7YK+YhdmsrJszl+lAFbfBjAxiORgUFvd5x
 VLGVHwRLdQSLKfFHGlqWXYqWxD25xXk7JC8YzsC2SprgQiekbiIAFoJcg
 mRAhbQkWZONJm0gZHh/I3T+JyCTqwJMfd0IXrpmh5j4GUIYYBCuRv69e+
 1UPIEzwt09maOmr53YIOJMDi9SmkM9FbEFNvVKpeSUwEiDQ/4ef6ijNoV
 lXbWHHbVMuvwWO/cTXNc1JP6Fh1m2ZkhwskqLSZ++CJO+f6qWJ/jOCowu
 HY6iwgQrjxqemXvoxqIzq2RprU7M0a3krVZfpNh8jd5Yu/GEPxWGEXuAr g==;
X-CSE-ConnectionGUID: yNY4amyaR2OPcxEm2Sf7KQ==
X-CSE-MsgGUID: 9xpwticMRUC+xZ7Yx5jLeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="60668766"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; d="scan'208";a="60668766"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 00:20:02 -0700
X-CSE-ConnectionGUID: AbSDFmGzQMqRBs34oOpDpA==
X-CSE-MsgGUID: IVgR4wgeStqF1oNm5ICWBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; d="scan'208";a="192019672"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 00:20:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 00:20:01 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 00:20:01 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.61)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 00:19:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLf70gy4MVvOXm+Nkbh/uZI7nr8MearAgnehMv03Ab8TPA3ZYbw0MjjCjaHID65QG5D4RcWKRWqW8EI7cPl0ks1wjRbyo8f3Qmbjb/eb35kQzAnzHgxwsEKOve5kO+pboWxjZxxUTIYDAT/t5jVQfX+QzDubWlCIfr8GgGrjk91LvtBlSKdxr+SgSCLYalMPSwPC/dfBRwy5Jb3T2MaZQKT8d4uNCf6IQ6oPV1cP5CktHpkAIbA+nv3m75eqdrcS0HxIMAZsufLuoRQILz8LgjTuytvPgdJq7WA2jIHC1XmChFr+HgbmXx2QfK8Xono51vVYKGjQmCNM2MDR40HuqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFXqqOHWCOU4y6erD/8ciQLUCJ2cNBbQhnhOneMncGw=;
 b=VUhM8J/oswqsYsPXZXPeBFHl7Xr0nwa5JLIpw5ubG+5CJqeeVPFfQzo2pyNeVUaOoC5dhDNyWVzA9g/BwpvgH7TDidrNUVCxEIt3QN/ERMRKnnv/E5c52XArDKcrmXI/Tvr2jlNRESnBPHVf+pH9GM9uYBWKqwJRV4Gp5BvoZIwPBjhaTb5A29qGltDLLWdFMq4NO5lZfaZwftljfjroPjfFGnblYZ6SmrvSbNMBw1Qt1eWJ9i4AK1ArUlongbSoYi+tDsjKDS7lYiDhwCiu8RF38OiQryz8+6VEEZKxq0saRpakOSdJJwIAKYfIe/hoTPc2lx1D1Yx819nr++DwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by PH7PR11MB7515.namprd11.prod.outlook.com
 (2603:10b6:510:278::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 07:19:44 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::e495:c424:3fc7:e18]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::e495:c424:3fc7:e18%6]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 07:19:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Thread-Topic: [PATCH v4 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Thread-Index: AQHcAGod+i7KqE+Pt02Tk9KMC5fQ97Rs1sxg
Date: Thu, 21 Aug 2025 07:19:43 +0000
Message-ID: <DS4PPF93A1BBECD1D6A6FEA7C800E6EDD069232A@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
In-Reply-To: <20250729092043.785836-1-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|PH7PR11MB7515:EE_
x-ms-office365-filtering-correlation-id: 9e0ad2ae-fd6e-46ce-5f6b-08dde0831a11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?04GRba7Py0jNEwWeH1Oyz6qwdwTd1umJMxaK/H9SrZBOrJ/A57ZaDbrghL6M?=
 =?us-ascii?Q?z/dWf7tx+c4P65N1mgSxTlRf0AsC9kzyahmfufNhXH+NOF0I8mC36YDCpkqt?=
 =?us-ascii?Q?kfTw9puKgMxb8MMYr7LNXp+XwRGi8NgNObgn8pWMkw8KPISGNpdp41fOUr49?=
 =?us-ascii?Q?0d1sMf/jalpCUF/cjckqJQglk3HkoUgSvM0KDixQkek4pOzZPKAljLOQSa0P?=
 =?us-ascii?Q?kdcZa+iW4wtvLKz0CR9/OtJLYO7hv/5jLkwk6ZqYWTIrZD+c+JaLYofgoyzS?=
 =?us-ascii?Q?B9ShfLNKp16m0kftfpNr9iSeTFEfcxDSkh8tpUkWb9MUYzTw0cx2X4Tc1kUV?=
 =?us-ascii?Q?Z46hATow5XNltvlrQDwb08/GokwxBPY57Mz88JEaM87HbwlB8Rt0DrvFbDd3?=
 =?us-ascii?Q?j5WywUM9CGULHu+BK21XzPdZN2klRF2BuWgVFIFbhM8+5eRN+Y+bJMQuIEaS?=
 =?us-ascii?Q?de0qL7HFovBxHtHvQ3Tvgw20JvDs6//E5zI9z/nch4+bzGDGKZgCdU0dhYJy?=
 =?us-ascii?Q?ajxfc4NKZ9UZC0oUgoGxxQZ+pVkynhf1o9cF3ihl7/+zPotTMhKR5V6it0oR?=
 =?us-ascii?Q?tK1dzwBD3iTwKNYPRZ3ws0fDgDjzODPByv8h0fBcS6869WgHvscCRLUtBeHa?=
 =?us-ascii?Q?FJlLfI5z2lXmFRbjQnMfr+nkf/zrdQyrDEFxBW2DNv62Ipaj/n9GYg8Djx7Q?=
 =?us-ascii?Q?w9r8QAcWXvw44GtKuQNuO/V6S4QyZsT0uC9oraQjDJnFTLlnKRWeHjgQHd9L?=
 =?us-ascii?Q?0ZmFYto9PO2ZS3HWfUxFPVGtnG9FpguzCqn53CbtVR+1muq1roWuT5PuwFAZ?=
 =?us-ascii?Q?HFbb78oNu1OhHldv6c7rxyd7+FLiEJCY3fsDpaLf0RDxSXJykOwA2TWh98a8?=
 =?us-ascii?Q?c9xuYmLhuT8VdSZf88Xgg6TCnw21DKC9evRA8bkS/vyr0G+aEQG9osN140WW?=
 =?us-ascii?Q?bM1YzuGsbaCM5Ik+T+1AukR6SkDJx4zx2Ng+6x8ik+BTENdJ6SPE+DNKNkms?=
 =?us-ascii?Q?thw4TyKN61F6x+3xpXkasKEV3Gg7ArlFSMCadHw7ZOx5EUT305N3FCZmZy5s?=
 =?us-ascii?Q?eLTgxv8/A52JsyTuP0PRgM/6mXm82Cx3NHmBCZOwkolwpyE9jHqUsPjv/JgT?=
 =?us-ascii?Q?6X6rDI4cyA2rzqleZrOAUkgyril0RQcnZxNDB7fEZV65pM4sAwMj/yK2Y7Uc?=
 =?us-ascii?Q?hrz1pSFftZN3SxgeXrTTT8vq5SfC9tAov1I2Vu75CR5fnxW8oWCJcr78M6E6?=
 =?us-ascii?Q?urjzbaBvzGh27mUEdRGdcE4WzBRda1wLo0NZG4p+AaIuhuW80e5+0V6clkI8?=
 =?us-ascii?Q?Sd8Seb76aQB0IUQBohoB9C91Pb3N5uWY0np5O9ijDhkbHccoZICDlQo0TDXz?=
 =?us-ascii?Q?1jU+9v2RLxibIqPRWm4dSJ11KdiIUe2bLaQXQjqHb3NvH2RFdnRg+KLqQZR4?=
 =?us-ascii?Q?1XIXWj17kQO335ZnkAEjNDLNsvSAmo+A7CluMGuhN7jGSuEkl2sOnF00ua/W?=
 =?us-ascii?Q?2/VGA8ALRxC5Y18=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/gPC6rYqOyoNxVjYlGF9LEszi8uEreSVWi/bHeo57cnCMX+M2BESHofb1r8c?=
 =?us-ascii?Q?Fk54qlg1Xa1bkumyqqlAgydanZJ+leTxvHvJ6nZNiGHECRUE6wN5O0Nr3t2S?=
 =?us-ascii?Q?T4zEJenX5up9VOXnwlF6dfRT0lfXvJNJaYMFpJEjTz1ilNy8wbm7jHwjhWbv?=
 =?us-ascii?Q?ZyIGx8YG8cbX/MSClIRHRAVOCHRCuf+s46eEJdsosQoB475QQeJop2WlO0Id?=
 =?us-ascii?Q?Gqr9843FPJRftw24qJZawYm0LDVrUu0k+Z6QEVYAEYm4DQrZoznc6/AB1bg8?=
 =?us-ascii?Q?sqGJKtrPnFI1DqoA/8Kyuy3vbvZbSs/jR0yZWQ6ne3fhEHcLuyuUodJIyDNt?=
 =?us-ascii?Q?38/9pNda2RHPfqrnXN6s1qCM6APxeDxoK9nMQKlOb/BgxmsgD8e5SnrexxSH?=
 =?us-ascii?Q?JMCe07m2kgO8nVXsduL/VqSHng19SKIigKI8YfMj9Qd14/a/Ixi0AUBxmEO2?=
 =?us-ascii?Q?XeJxHZXiWK6OxgcA0/8E1zBomKjAcLtkx/CAOY+5q1ztu4wCwUkH6+Eztj0X?=
 =?us-ascii?Q?JwtRQx7VKX6L/siSdjdTrtpz96ziYcUN7aEWcIr1eKf6MdHIy8zo6+zICClK?=
 =?us-ascii?Q?g1knflL5RGfDVl3r7HZgq0++93IjVsVLIf+r/l9Ph33U53Vi5xTx90vl23pL?=
 =?us-ascii?Q?3drHaK7huo12PSpGK701yNdxhC/IZ/NsYLApFHyQw04KleTL4nj2MHVx4jHC?=
 =?us-ascii?Q?57nWx2PIvdvMsMeqjx+8tZxiCIZqPp9QmnbLBv0o9i1yqFjHK4h1Viniwzu5?=
 =?us-ascii?Q?oXsQG6eAF97D7baE5yr2VNnXfUUeARW8rhSbTiqVks05G1E5chvKxwdkAjTC?=
 =?us-ascii?Q?qeKZmnlOODcRyXTcOF/zKmH3yyrHFs/vAPc1AP/KNCdwmzHf4jhZ7jlMg9FO?=
 =?us-ascii?Q?oM4EQmS7QytQT6LRAqL0WnT07sLrwVK8SVRO1xOVsk5go7ZEofliPMBcFSCJ?=
 =?us-ascii?Q?/vA9DCeZ9UpFRn9Saya1obshG0d+auq7gb2grS8xgaxpHqRzEu+iCgQ1xS4o?=
 =?us-ascii?Q?ytR3lopVS6C+HiV8OEJgO3iErChMEC+3DUgsySrnDc86UCuXZ0AP5OwC/n7D?=
 =?us-ascii?Q?il4rw+NxLbaBso40fVbP2JLAKxtsKh1SJ93fgIcA9mPF21vINTHERoSKZ/gP?=
 =?us-ascii?Q?CnkE5wPX/WN6Tbtmf5lunElCLWRvGg7qpJ8uXyJiNehGIQZ7HQnNhhgxDP15?=
 =?us-ascii?Q?zHuLx5jeONRMrIx7ryo63aMCnL6XQ2wc1mzI31G+DiC/kmLX6I4PPv8z0vXD?=
 =?us-ascii?Q?O765SBkCDLZgL1/CwjYrRqPBkKoNNy6Tj4il6IsHyeV6YTY7nxSbhqAFmNev?=
 =?us-ascii?Q?Oi/eAawdVO4rns1SQzhgWQzEAMcQNUZoMzK2a13JTPbnf9Q1I17cZ6RnOzP3?=
 =?us-ascii?Q?Jg+FW/nDpIRES6EG+BuymEzZMlsKfw6LgHVal3Tw/ywVS4ilBZV+bKBrTF30?=
 =?us-ascii?Q?koplCdpviE+i895GOEyoO36RlNIbh7quXg0F94W/LX0BoeIVo5s01C9xqiGV?=
 =?us-ascii?Q?/UTCrZMrG4f0lsJwwzFtc/JDEzl71DxCHShac2v3ItZ5BB616bRA2pHJyG1K?=
 =?us-ascii?Q?/lxIU/hswOr6bP2u4O5aBapqzdC5XGxq+KPJ7UK3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0ad2ae-fd6e-46ce-5f6b-08dde0831a11
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 07:19:43.8901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bO7y96mM+1Bk0YaphryNB0zTgGGcEZ+rPaVWF22Dx+jlQf3hdc+zqrfr80nRswzvwBshQajcikKBGta1vQ2Cdz5uGWcQEg2oEX7Hx8baZ8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7515
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Kindly ping, any more comments?

Thanks
Zhenzhong

>-----Original Message-----
>From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>Subject: [PATCH v4 00/20] intel_iommu: Enable stage-1 translation for
>passthrough device
>
>Hi,
>
>For passthrough device with intel_iommu.x-flts=3Don, we don't do shadowing
>of
>guest page table for passthrough device but pass stage-1 page table to hos=
t
>side to construct a nested domain. There was some effort to enable this
>feature
>in old days, see [1] for details.
>
>The key design is to utilize the dual-stage IOMMU translation (also known =
as
>IOMMU nested translation) capability in host IOMMU. As the below diagram
>shows,
>guest I/O page table pointer in GPA (guest physical address) is passed to =
host
>and be used to perform the stage-1 address translation. Along with it,
>modifications to present mappings in the guest I/O page table should be
>followed
>with an IOTLB invalidation.
>
>        .-------------.  .---------------------------.
>        |   vIOMMU    |  | Guest I/O page table      |
>        |             |  '---------------------------'
>        .----------------/
>        | PASID Entry |--- PASID cache flush --+
>        '-------------'                        |
>        |             |                        V
>        |             |           I/O page table pointer in GPA
>        '-------------'
>    Guest
>    ------| Shadow |---------------------------|--------
>          v        v                           v
>    Host
>        .-------------.  .------------------------.
>        |   pIOMMU    |  | Stage1 for GIOVA->GPA  |
>        |             |  '------------------------'
>        .----------------/  |
>        | PASID Entry |     V (Nested xlate)
>        '----------------\.--------------------------------------.
>        |             |   | Stage2 for GPA->HPA, unmanaged domain|
>        |             |   '--------------------------------------'
>        '-------------'
>For history reason, there are different namings in different VTD spec rev,
>Where:
> - Stage1 =3D First stage =3D First level =3D flts
> - Stage2 =3D Second stage =3D Second level =3D slts
><Intel VT-d Nested translation>
>
>This series reuse VFIO device's default hwpt as nested parent instead of
>creating new one. This way avoids duplicate code of a new memory listener,
>all existing feature from VFIO listener can be shared, e.g., ram discard,
>dirty tracking, etc. Two limitations are: 1) not supporting VFIO device
>under a PCI bridge with emulated device, because emulated device wants
>IOMMU AS and VFIO device stick to system AS; 2) not supporting kexec or
>reboot from "intel_iommu=3Don,sm_on" to "intel_iommu=3Don,sm_off", because
>VFIO device's default hwpt is created with NEST_PARENT flag, kernel
>inhibit RO mappings when switch to shadow mode.
>
>This series is also a prerequisite work for vSVA, i.e. Sharing guest
>application address space with passthrough devices.
>
>There are some interactions between VFIO and vIOMMU
>* vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
>  subsystem. VFIO calls them to register/unregister HostIOMMUDevice
>  instance to vIOMMU at vfio device realize stage.
>* vIOMMU registers PCIIOMMUOps get_viommu_cap to PCI subsystem.
>  VFIO calls it to get vIOMMU exposed capabilities.
>* vIOMMU calls HostIOMMUDeviceIOMMUFD interface [at|de]tach_hwpt
>  to bind/unbind device to IOMMUFD backed domains, either nested
>  domain or not.
>
>See below diagram:
>
>        VFIO Device                                 Intel IOMMU
>    .-----------------.                         .-------------------.
>    |                 |                         |
>|
>    |       .---------|PCIIOMMUOps              |.-------------.    |
>    |       | IOMMUFD |(set/unset_iommu_device) || Host IOMMU  |
>|
>    |       | Device  |------------------------>|| Device list |    |
>    |       .---------|(get_viommu_cap)         |.-------------.    |
>    |                 |                         |       |
>|
>    |                 |                         |       V
>|
>    |       .---------|  HostIOMMUDeviceIOMMUFD |  .-------------.  |
>    |       | IOMMUFD |            (attach_hwpt)|  | Host IOMMU
>|  |
>    |       | link    |<------------------------|  |   Device    |  |
>    |       .---------|            (detach_hwpt)|  .-------------.  |
>    |                 |                         |       |
>|
>    |                 |                         |       ...
>|
>    .-----------------.                         .-------------------.
>
>Below is an example to enable stage-1 translation for passthrough device:
>
>    -M q35,...
>    -device intel-iommu,x-scalable-mode=3Don,x-flts=3Don...
>    -object iommufd,id=3Diommufd0 -device vfio-pci,iommufd=3Diommufd0,...
>
>Test done:
>- VFIO devices hotplug/unplug
>- different VFIO devices linked to different iommufds
>- vhost net device ping test
>
>PATCH1-6:  Some preparing work
>PATCH7-8:  Compatibility check between vIOMMU and Host IOMMU
>PATCH9-17: Implement stage-1 page table for passthrough device
>PATCH18-19:Workaround for ERRATA_772415_SPR17
>PATCH20:   Enable stage-1 translation for passthrough device
>
>Qemu code can be found at [2]
>
>Fault report isn't supported in this series, we presume guest kernel alway=
s
>construct correct stage1 page table for passthrough device. For emulated
>devices, the emulation code already provided stage1 fault injection.
>
>TODO:
>- Fault report to guest when HW stage1 faults
>
>[1]
>https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1
>-yi.l.liu@intel.com/
>[2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting.v4
>
>Thanks
>Zhenzhong
>
>Changelog:
>v4:
>- s/VIOMMU_CAP_STAGE1/VIOMMU_CAP_HW_NESTED (Eric, Nicolin,
>Donald, Shameer)
>- clarify get_viommu_cap() return pure emulated caps and explain reason in
>commit log (Eric)
>- retrieve the ce only if vtd_as->pasid in vtd_as_to_iommu_pasid_locked (E=
ric)
>- refine doc comment and commit log in patch10-11 (Eric)
>
>v3:
>- define enum type for VIOMMU_CAP_* (Eric)
>- drop inline flag in the patch which uses the helper (Eric)
>- use extract64 in new introduced MACRO (Eric)
>- polish comments and fix typo error (Eric)
>- split workaround patch for ERRATA_772415_SPR17 to two patches (Eric)
>- optimize bind/unbind error path processing
>
>v2:
>- introduce get_viommu_cap() to get STAGE1 flag to create nested parent
>hwpt (Liuyi)
>- reuse VFIO's default hwpt as parent hwpt of nested translation (Nicolin,
>Liuyi)
>- abandon support of VFIO device under pcie-to-pci bridge to simplify desi=
gn
>(Liuyi)
>- bypass RO mapping in VFIO's default hwpt if ERRATA_772415_SPR17 (Liuyi)
>- drop vtd_dev_to_context_entry optimization (Liuyi)
>
>v1:
>- simplify vendor specific checking in vtd_check_hiod (Cedric, Nicolin)
>- rebase to master
>
>rfcv3:
>- s/hwpt_id/id in iommufd_backend_invalidate_cache()'s parameter
>(Shameer)
>- hide vtd vendor specific caps in a wrapper union (Eric, Nicolin)
>- simplify return value check of get_cap() (Eric)
>- drop realize_late (Cedric, Eric)
>- split patch13:intel_iommu: Add PASID cache management infrastructure
>(Eric)
>- s/vtd_pasid_cache_reset/vtd_pasid_cache_reset_locked (Eric)
>- s/vtd_pe_get_domain_id/vtd_pe_get_did (Eric)
>- refine comments (Eric, Donald)
>
>rfcv2:
>- Drop VTDPASIDAddressSpace and use VTDAddressSpace (Eric, Liuyi)
>- Move HWPT uAPI patches ahead(patch1-8) so arm nesting could easily
>rebase
>- add two cleanup patches(patch9-10)
>- VFIO passes iommufd/devid/hwpt_id to vIOMMU instead of
>iommufd/devid/ioas_id
>- add vtd_as_[from|to]_iommu_pasid() helper to translate between vtd_as
>and
>  iommu pasid, this is important for dropping VTDPASIDAddressSpace
>
>
>Yi Liu (3):
>  intel_iommu: Replay pasid bindings after context cache invalidation
>  intel_iommu: Propagate PASID-based iotlb invalidation to host
>  intel_iommu: Replay all pasid bindings when either SRTP or TE bit is
>    changed
>
>Zhenzhong Duan (17):
>  intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
>    vtd_ce_get_pasid_entry
>  hw/pci: Introduce pci_device_get_viommu_cap()
>  intel_iommu: Implement get_viommu_cap() callback
>  vfio/iommufd: Force creating nested parent domain
>  hw/pci: Export pci_device_get_iommu_bus_devfn() and return bool
>  intel_iommu: Introduce a new structure VTDHostIOMMUDevice
>  intel_iommu: Check for compatibility with IOMMUFD backed device when
>    x-flts=3Don
>  intel_iommu: Fail passthrough device under PCI bridge if x-flts=3Don
>  intel_iommu: Introduce two helpers vtd_as_from/to_iommu_pasid_locked
>  intel_iommu: Handle PASID entry removal and update
>  intel_iommu: Handle PASID entry addition
>  intel_iommu: Introduce a new pasid cache invalidation type FORCE_RESET
>  intel_iommu: Stick to system MR for IOMMUFD backed host device when
>    x-fls=3Don
>  intel_iommu: Bind/unbind guest page table to host
>  vfio: Add a new element bypass_ro in VFIOContainerBase
>  Workaround for ERRATA_772415_SPR17
>  intel_iommu: Enable host device when x-flts=3Don in scalable mode
>
> MAINTAINERS                           |   1 +
> hw/i386/intel_iommu_internal.h        |  68 +-
> include/hw/i386/intel_iommu.h         |   9 +-
> include/hw/iommu.h                    |  17 +
> include/hw/pci/pci.h                  |  27 +
> include/hw/vfio/vfio-container-base.h |   1 +
> hw/i386/intel_iommu.c                 | 941
>+++++++++++++++++++++++++-
> hw/pci/pci.c                          |  23 +-
> hw/vfio/iommufd.c                     |  22 +-
> hw/vfio/listener.c                    |  13 +-
> hw/i386/trace-events                  |   8 +
> 11 files changed, 1088 insertions(+), 42 deletions(-)
> create mode 100644 include/hw/iommu.h
>
>
>base-commit: 92c05be4dfb59a71033d4c57dac944b29f7dabf0
>--
>2.47.1


