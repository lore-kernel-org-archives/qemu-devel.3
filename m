Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B415FCCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6nl6-0005Wm-93; Thu, 09 Oct 2025 06:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6nl4-0005Vw-0S
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:20:26 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6nku-0008Vw-KS
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760005216; x=1791541216;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rzJpmTI01NOZZ9aw8CPql/JlK2flnKBU7HworDlimN8=;
 b=EQXNPmcxs+S180YOC2RMIPjx/NQYi4Uf8DU/SttagyI0NIJ0D4K+HPE2
 Akjdf4GW/pnS1rzwKkwLNFS5vuIbsktz3OwpO7rsRD/fyOk5WPt0OS4ko
 08KKFqKaQiMy3mViHZPwHF6BBPjoO3X5gB8JaeLoRKs5R2Y2Df5SYz20v
 2HVRO4saMAjritx25qX9oFEGRkgaCluaDlR7MUg+mtoCpiIDzBKsjW8Sd
 /Okowojcsa4vg4H496I9vuMH5Q+u3dXjBl4RpRGLGxuo/cmCdBmrHj/fW
 kZUAVJ73MuKViUxEv3CA98m2Ky+vxaY2v8Yv8r6dVZ2SjJVTz5CwmSxHE w==;
X-CSE-ConnectionGUID: FGXcWZ0cSkuRgHxJ579KTg==
X-CSE-MsgGUID: FXwsNQFWS0y30Fcy5y5qkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="62095985"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; d="scan'208";a="62095985"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 03:20:08 -0700
X-CSE-ConnectionGUID: +GkqostYTVKREd9q1D38BQ==
X-CSE-MsgGUID: cpv44IpSQzChQN0w4FbrUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; d="scan'208";a="204390591"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 03:20:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 03:20:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 03:20:07 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.17) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 03:20:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUKV/DDoqsok4hwjES3NLqgR4Ssff0JFtBuJlI9tOifn+WnDHoeZxeYDMyWoLXXkntHZvVFiOTm88NH2FnCF95XLCjpnKXBL5FFEhB7nBO656DUMcY3PAO26s7AKAXJLVR++W5dMxTM9rrScBZlTfmtv+bWmEW72BtRaHJQIDOJk6Pb/FoFcF93G6D/vy1yhXsl48o4i54PUg1vTjS7aN/WAIwAC1z1Dgxbst7rieESHheAt+EfhUawqLg3yq3Igk4Gy65nRbiPlrs/J2vpVA+J8T88papmDOyvFWvv5QYz333YZ8hkOnOeZjEyudkQs0Utl7rgsfTDqg3rvn7Vy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoJH4GFWoRVjyvYEAVU/OEAQooEqBnMbBxlSbEQimTA=;
 b=aRuvrSvpEKNbBgu8fVgnWAIhqQLr5p74m+IG+nkZo0z+7yLuzQnrlri9NzX8eMxomIXN/VGb0URTIN2zp8iDvyx4IEPLfoZwoVTZCXAGVHHnD8/DGic1umE5nGjO8uOmFTZw3wu9r5R0+tG9wvdGhViSyJTTKQdp+YDD9+sw7ICGKz0jX4JB7gYNhcWcHu1ItJHXBksoNZYr5/xKhlAmTtA3hrsRKAgqAGwkUzPBSEwI76g8iS39BVT9z8ovcB6z+6lmcvRInBTUtPsx24d7XX5ad07+eQkxz3fujgPpgn3KxKkIA0mP/wd1ZOBwYq64D4qezqYIDeD0sp2TCmie8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8436.namprd11.prod.outlook.com (2603:10b6:610:173::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 10:20:04 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Thu, 9 Oct 2025
 10:20:04 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "avihaih@nvidia.com"
 <avihaih@nvidia.com>, "Hao, Xudong" <xudong.hao@intel.com>, "Cabiddu,
 Giovanni" <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, 
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
Thread-Topic: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
Thread-Index: AQHcIfvtcDcAUY1arESRh5H1VPguD7SaXCYAgAQ5VOCAANsXgIAaVi/w
Date: Thu, 9 Oct 2025 10:20:04 +0000
Message-ID: <IA3PR11MB9136EAD2D625ED90DD89A13492EEA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-4-zhenzhong.duan@intel.com>
 <d167b62a-be06-4bb1-b88e-e1cc96d7c4a4@oracle.com>
 <IA3PR11MB9136B9DA08CC2A48E1678DED9212A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ac9e71a9-972d-4fba-a0f1-9823ae6664cb@redhat.com>
In-Reply-To: <ac9e71a9-972d-4fba-a0f1-9823ae6664cb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8436:EE_
x-ms-office365-filtering-correlation-id: b121bccf-dc80-4318-3fc8-08de071d69e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?9IP9moL9BE/LNk4z6VQ5baY0okvTHTpA2EgywEdfoj7fCXkkh5tl/HSRVn?=
 =?iso-8859-1?Q?QIVe5wOv/R9Z3rrQwH78/mzidZQR1Mp6ZcLhC9ygBZ9KYKcF/NQc60mRFK?=
 =?iso-8859-1?Q?Amf1yxyX2TeYd1/bkFlLwl1k5CDW1IgU4WOwnG53kZK1G1FRutIuAWvzgQ?=
 =?iso-8859-1?Q?pDZSjxxdJAq1iFG6kkx7ZtNvHPwz+oIecpoAn+9FoZTAV3y9rxSA6gPR48?=
 =?iso-8859-1?Q?vK9raIkAZIlq8wq11uF27mmKDOS38f2lSLpz3bi5GUdVY7vb2Znyz6H6EI?=
 =?iso-8859-1?Q?qcyKrJtKWVktbicTuJiuRUmyoYics498X+UZwyep+Jn8+QF4NJoQ5szJO0?=
 =?iso-8859-1?Q?ga3XaS9hTY8VREjMxK2dv6K1Jbvv4v76bxrFqWSmuRfDKiW/luVWldYtA4?=
 =?iso-8859-1?Q?6qpVNxKkPuJCXpa6yceUsHmxopwqYV1tSQ9b4rDcd23+vmpwBAn8GUqrlq?=
 =?iso-8859-1?Q?IeM7SEgYuvqO3C3sNKll3Lpue7Py23s2Ts/wjpbnzBLRs6zABnrbPfXwDd?=
 =?iso-8859-1?Q?bgdZG1r9nN/cCRQW9+Be40spkqRBJU2S/CG78+ZL5yeHc7Ch0bV4O9EbVH?=
 =?iso-8859-1?Q?8+7NcoL8VtvDfce0kRY3GSuXqofV75EsKdevxwAjIbGSQ0f6vpOnXZw3Bm?=
 =?iso-8859-1?Q?XUs0FZmJJpj9974Z8IpJeXpIOL/AsiNXjNY+sj1LYkFEP5ng1J0BbwLs9a?=
 =?iso-8859-1?Q?xpw89QChD8MGPxVLHOOfubVzq4LZsOboF2d6TK2s8vmcndc+0FwRgRC1lZ?=
 =?iso-8859-1?Q?FzTSitX0HuxT9HsqOOIHwpdDHh/S1+QWEoRY1NLf2Wcrz35fNERzXIVJFu?=
 =?iso-8859-1?Q?bHdk7ODjuFRiJ3zFepf/LRYmMjAEFC51IoyzCXmGtpjNQ202MV+A3grRT6?=
 =?iso-8859-1?Q?EKarJnXmOIohdr7Cqav5KkwhzFqX8FARNZdyinscHFC+/3ZLxvg+GYwEVD?=
 =?iso-8859-1?Q?B22+qk/8uq5g0lqTIkPqU48QLwWcjgrYv5wH+CJJQ246x44BSXUYYCyo6n?=
 =?iso-8859-1?Q?tin6mv22juYiVSfKIqr31JRv9qVCVFmhem3giiP0Y2MhnMPP/CyU8SLdad?=
 =?iso-8859-1?Q?8yFluLPX3clU6c06DLdlYV1YhhvDD4lOxUXk3ray9QrsYiG3WzjTCjHO9D?=
 =?iso-8859-1?Q?/OzA/PfCvSZkVX5j2nSuNvNrhJzbHUV2okorIJQZ4wcc8kLaV+xJJ61jdy?=
 =?iso-8859-1?Q?QB2wYDDTJE0yma5C8Zw9i27/dM6xMMRcPBRKri3PYbffjQALz0T4d61bo+?=
 =?iso-8859-1?Q?unFXhyDRTGtCbpFECQN5dekukqrjGFlsKS/8RQTnI7Ff0xXHdjxRZm1maW?=
 =?iso-8859-1?Q?wU3SPhdXgdO5Q0SKkJyfi+fBtSeG/ba245oT4VyqfWSn850kdqJ0zlVwx6?=
 =?iso-8859-1?Q?XUE0O3JsbyvGOVP1qzQCjU5eM2KQY/uIgNXQSnKSZ7ReGFbLFxrgfQ0Eva?=
 =?iso-8859-1?Q?h5y7hd9NzZCxKRD+Zuj44YhqBRoAnMr9pEII210TQfeEte43lTH7SltdSH?=
 =?iso-8859-1?Q?Kdjtv05RqqnrJYTMKqHfL3DrgOBDdT7W0xfkf6jGyDjEI2gDoAADvWFldI?=
 =?iso-8859-1?Q?aUFsltjdYTEEyj6sLWHzsJdvWzDK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sWsG6iMwpWt1zpM6FV2raOcOqi4yNkU5lef1o59oVBJGkqwxk96wZKLo9O?=
 =?iso-8859-1?Q?5qLKu7hcq2I8KXDMrHMS+Pgv2RiHojEOhJbk8bz3XUwhdhCMe6OF+pEu8s?=
 =?iso-8859-1?Q?Lly9lz/6CQZt3rqi/OfLvC+qsXnsdao5BhPTZ/Md1/T/6ejLU8DdYBX421?=
 =?iso-8859-1?Q?J9FoA022D79leIMyfzuDDl4Q6ZQonY0ESJXwqyr+l4ok4l1qU3zBX8WGqj?=
 =?iso-8859-1?Q?up1Ggws4tflnlL0kMi1ELk7kngvXgW81Y8iHq+BOvBwJyMWTz2qeZVPh/E?=
 =?iso-8859-1?Q?B6mTTgmaYGrbw3lDkS7eMH7oeCX+91HbtVJLRf1v0zlT7qLpo/QQSRKBUy?=
 =?iso-8859-1?Q?tiyTZ5HenjzNzsIZGLorFmdn941ai1POmiRedWKAFqaqXn+MzLFAM+bzlP?=
 =?iso-8859-1?Q?iDwpKwpz8UQVR1eRfVh1zaMi23bZRece1q81Aa4lObhotatdu9vKq3Nj1u?=
 =?iso-8859-1?Q?uRyXkc802W2FK6o7yKgxkFuUwEEqvKsJtREIaD/go0ZZDNFfjlTXZ0V0Im?=
 =?iso-8859-1?Q?pJtv6+BgdkE9FKgBSaeJt0/hKaeOUgQP0VKsGMXVH235D1V5w9K18d0w2S?=
 =?iso-8859-1?Q?7SZZvqnLaqi6FgJp+8YkyJXUPr4doKP1NEjyUzqDEilyedULrXp+qSC/rg?=
 =?iso-8859-1?Q?ltQb6Vb3MWD6UtrzorM1YXaMt47zvzcjUpeqbsVuqS1qeyqLdR+okKP4rR?=
 =?iso-8859-1?Q?DwQe/RCXcmiJNGuhOQNItYJcDnLTljOC7D0vn7G54lcBJGfpl2vx5QIOnZ?=
 =?iso-8859-1?Q?30988RbqCiGI5R/gLC3Ah1wUybuiZt5N/EZptCbGUI3w4+wdB2TlKOYBBg?=
 =?iso-8859-1?Q?f9JiZVbkbfL288s8z+FRWM7Emus/1yTwzvLEWLHiMaSFxmOm+mS0MW10iS?=
 =?iso-8859-1?Q?Sp5PCBImbJSqAhGejZTLkOU17e7wsv1DKCjPlkknmP5HQtIxb/N83D2hgD?=
 =?iso-8859-1?Q?36XNf136jj2iPmUCjWijktw5sMS/H4Ois0slZgDjlwA36iY2xRMy5R31d5?=
 =?iso-8859-1?Q?WRuzINMiuVNgJP8SaR35qnbTsTfoY0pUtFSilVyrg58J2dPB93bIHFtJcI?=
 =?iso-8859-1?Q?1m03Lyp9qxNMg2RYCiffF44YNsuYVjhkRg5xMDEUkkMbopb1SJ036LUqdO?=
 =?iso-8859-1?Q?80gxHef7LPTVmPyd22T772QKr1t9P1W4FZMZyF3XCOUrZcpemfSwdrET61?=
 =?iso-8859-1?Q?4+gVa68YYCzteOXeM4LtTGmSuUfV8b26F9r0cmNtB++bDxTqdymX1g428j?=
 =?iso-8859-1?Q?yoBGD1ZRjNUZs61UptaCrSRbrOcZ/bcuJT/HfRoK8SfSI0Pwo7TjLhv18g?=
 =?iso-8859-1?Q?SHldypuCAiPE2KHGGQEJ1X9Gv3kIS93m9/SV26GDfAjvQDK16tdo/eVP3Q?=
 =?iso-8859-1?Q?p27/iKAvMqyWf6JCzJbgy6WVsCRcSAykOuBka9VOLiuLgE1+5db90jnKjl?=
 =?iso-8859-1?Q?MFZ+ylgpByYO+Umav2jeyGI/zRVq014RPo/WE9LjAu1C1UEQiZE2NxsbLW?=
 =?iso-8859-1?Q?a+HQTU+SqiwJda0X5r00oeFOQRZaEDVogF4OWVGqgzP8WSCHpMgAmjFnSC?=
 =?iso-8859-1?Q?jQjx/X6iowXbzgBs5JcRovPl/dXiOxHH4OzujlmZWyj0CyiU+sAQc5l+WQ?=
 =?iso-8859-1?Q?CevmXNlN7GTbWBKk/y95oj50pbjDOoBMpQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b121bccf-dc80-4318-3fc8-08de071d69e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 10:20:04.4934 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkOj0VZTZ6nCA6fHJxLUWUMFSXxO6aq9y+J99GZ340OebcbbbXgvdoOXLC/cpx9+mNamtc2dsJMeBHR/tkFHBsnByEnWMLLMNbbbM9aMqKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8436
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi C=E9dric,

>-----Original Message-----
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: Re: [PATCH 3/5] vfio/iommufd: Add
>IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
>
>On 9/22/25 07:49, Duan, Zhenzhong wrote:
>> Hi Joao,
>>
>>> -----Original Message-----
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>> Subject: Re: [PATCH 3/5] vfio/iommufd: Add
>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
>>>
>>> On 10/09/2025 03:36, Zhenzhong Duan wrote:
>>>> Pass IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR when doing the
>last
>>> dirty
>>>> bitmap query right before unmap, no PTEs flushes. This accelerates the
>>>> query without issue because unmap will tear down the mapping anyway.
>>>>
>>>> Add a new element dirty_tracking_flags in VFIOIOMMUFDContainer to
>>>> be used for the flags of iommufd dirty tracking. Currently it is
>>>> set to either IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR or 0 based
>on
>>>> the scenario.
>>>>
>>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>>> ---
>>>>   hw/vfio/vfio-iommufd.h   | 1 +
>>>>   include/system/iommufd.h | 2 +-
>>>>   backends/iommufd.c       | 5 +++--
>>>>   hw/vfio/iommufd.c        | 6 +++++-
>>>>   backends/trace-events    | 2 +-
>>>>   5 files changed, 11 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
>>>> index 07ea0f4304..e0af241c75 100644
>>>> --- a/hw/vfio/vfio-iommufd.h
>>>> +++ b/hw/vfio/vfio-iommufd.h
>>>> @@ -26,6 +26,7 @@ typedef struct VFIOIOMMUFDContainer {
>>>>       VFIOContainerBase bcontainer;
>>>>       IOMMUFDBackend *be;
>>>>       uint32_t ioas_id;
>>>> +    uint64_t dirty_tracking_flags;
>>>>       QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>>>   } VFIOIOMMUFDContainer;
>>>>
>>>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>>>> index c9c72ffc45..63898e7b0d 100644
>>>> --- a/include/system/iommufd.h
>>>> +++ b/include/system/iommufd.h
>>>> @@ -64,7 +64,7 @@ bool
>>> iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t
>>> hwpt_id,
>>>>   bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>> uint32_t hwpt_id,
>>>>                                         uint64_t iova,
>ram_addr_t
>>> size,
>>>>                                         uint64_t page_size,
>>> uint64_t *data,
>>>> -                                      Error **errp);
>>>> +                                      uint64_t flags, Error
>>> **errp);
>>>>   bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be,
>>> uint32_t id,
>>>>                                         uint32_t data_type,
>>> uint32_t entry_len,
>>>>                                         uint32_t *entry_num,
>void
>>> *data,
>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>> index 2a33c7ab0b..3c4f6157e2 100644
>>>> --- a/backends/iommufd.c
>>>> +++ b/backends/iommufd.c
>>>> @@ -361,7 +361,7 @@ bool
>>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>>                                         uint32_t hwpt_id,
>>>>                                         uint64_t iova,
>ram_addr_t
>>> size,
>>>>                                         uint64_t page_size,
>>> uint64_t *data,
>>>> -                                      Error **errp)
>>>> +                                      uint64_t flags, Error
>**errp)
>>>>   {
>>>>       int ret;
>>>>       struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap =3D {
>>>> @@ -371,11 +371,12 @@ bool
>>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>>           .length =3D size,
>>>>           .page_size =3D page_size,
>>>>           .data =3D (uintptr_t)data,
>>>> +        .flags =3D flags,
>>>>       };
>>>>
>>>>       ret =3D ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP,
>>> &get_dirty_bitmap);
>>>>       trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id,
>iova,
>>> size,
>>>> -                                           page_size, ret ?
>errno :
>>> 0);
>>>> +                                           flags, page_size,
>ret ?
>>> errno : 0);
>>>>       if (ret) {
>>>>           error_setg_errno(errp, errno,
>>>>                            "IOMMU_HWPT_GET_DIRTY_BITMAP
>>> (iova: 0x%"HWADDR_PRIx
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index 0057488ce9..c897aa6b17 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -62,7 +62,7 @@ static int iommufd_cdev_unmap_one(const
>>> VFIOContainerBase *bcontainer,
>>>>                                     hwaddr iova, ram_addr_t
>size,
>>>>                                     IOMMUTLBEntry *iotlb)
>>>>   {
>>>> -    const VFIOIOMMUFDContainer *container =3D
>>>> +    VFIOIOMMUFDContainer *container =3D
>>>>           container_of(bcontainer, VFIOIOMMUFDContainer,
>>> bcontainer);
>>>>       bool need_dirty_sync =3D false;
>>>>       Error *local_err =3D NULL;
>>>> @@ -73,9 +73,12 @@ static int iommufd_cdev_unmap_one(const
>>> VFIOContainerBase *bcontainer,
>>>>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer=
))
>{
>>>>           if
>>> (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>>>>               bcontainer->dirty_pages_supported) {
>>>> +            container->dirty_tracking_flags =3D
>>>> +
>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR;
>>>>               ret =3D vfio_container_query_dirty_bitmap(bcontainer,
>iova,
>>> size,
>>>>
>>> iotlb->translated_addr,
>>>>
>>> &local_err);
>>>> +            container->dirty_tracking_flags =3D 0;
>>>
>>> Why not changing vfio_container_query_dirty_bitmap to pass a flags too,
>like
>>> the
>>> original patches? This is a little unnecssary odd style to pass a flag =
via
>>> container structure rather and then clearing.
>>
>> Just want to be simpler, original patch introduced a new parameter to
>almost all
>> variants of *_query_dirty_bitmap() while the flags parameter is only use=
d by
>> IOMMUFD backend when doing unmap_bitmap. Currently we already have
>three
>> backends, legacy VFIO, IOMMUFD and VFIO-user, only IOMMUFD need the
>flag.
>>
>> I take container->dirty_tracking_flags as a notification mechanism, so s=
et it
>before
>> vfio_container_query_dirty_bitmap() and clear it thereafter. Maybe clear=
ing
>it in
>> iommufd_query_dirty_bitmap() is easier to be acceptable?
>>
>>>
>>> Part of the reason the original series had a VFIO_GET_DIRTY_NO_FLUSH
>for
>>> generic
>>> container abstraction was to not mix IOMMUFD UAPI specifics into base
>>> container
>>> API. Then in getting a VFIO_GET_DIRTY_NO_FLUSH, then type1 backend
>>> could just
>>> ignore the flag, while IOMMUFD translates it to
>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR
>>
>> I did port original patch
>https://github.com/yiliu1765/qemu/commit/99f83595d79d2e4170c9e456cf1
>a7b9521bd4f80
>> But it looks complex to have 'flags' parameter everywhere.
>I think I would prefer like Joao to avoid caching information if possible
>but I haven't check closely the mess it would introduce in the code. Let
>me check.

Kindly ping. Just in case you have further comments on this.

Thanks
Zhenzhong

