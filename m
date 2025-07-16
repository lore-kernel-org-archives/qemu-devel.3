Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DD2C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 03:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubsym-0004hG-Hs; Tue, 15 Jul 2025 23:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubsyj-0004Rm-SU; Tue, 15 Jul 2025 23:38:46 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubsyg-0006cJ-QW; Tue, 15 Jul 2025 23:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752637123; x=1784173123;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7sye2yE3rkqtQtYYq4k2NaJCwVi3A1WsWEBgwr9MQ1I=;
 b=j1h4pxXqJfxWVLgBP1QEYkW0MLcIade5czdlbq9NfjsgdAp2KU4J3PNU
 HD1XN5tawtLeZY2zY2nqlxjGD4vGJvDS8ddWCtyiPuIpRjvlY2ffq34ZO
 z2g/Vc1h3G+2QWesOjnYRNTtWptxz11GvDdfyM6RNCw+GFHIMHKzQfVDv
 5mHxJqAA4n/fLjN9UmDbnmdZdJMG0iwpLbfF8XmRjQNoJCAwlRMFGM9S7
 sApsDWWJwU22Gk37kahgWYSFaWoWvwqYiiewmOF10E5e5yKJTGHn/Ej5j
 vSTy2Cw5AAp7xtXVoBdK0JFnV70sqYohatqHmohIgGolD+s4lt6bjvZgi g==;
X-CSE-ConnectionGUID: j6JTzmLfRLqmXproWgCcjQ==
X-CSE-MsgGUID: tbhXalvcTIy4tZAYhZ3SDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54581356"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="54581356"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 20:38:40 -0700
X-CSE-ConnectionGUID: o7NKCJYjRju7qo0lk5kkcw==
X-CSE-MsgGUID: WCzASU3uSN+m58+6iNySPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="161416760"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 20:38:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 20:38:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 20:38:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.87) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 20:38:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrUrcsCSCAEtFvjs7cy8CSbOkHGnJekGxjkHmcSDjWIIoC94d6q1fpjnPfrPaYJZEvbtaZZIHJAQAknrNS7w5p3Ehjj4O8gbwEZJIvtJKGuhiXVuL3qHEC9IGzy2Q7gpg7qQ1rpPzwx0ZxiChY8VZQQsAjvD6EhL6xPALlgpbPoKWO3geQyz7u414Ka6DACqNUGpi7JVfMJvtyumNmGxX4/GVuftOM0kDcE22oV1sGvXNvUCTzPXiuht0WUKSzFeNfa1oIrYXN4/iZCu6OetvE6iGKa9i5BhI6kVxzdKJDFXl7gnaPEXPGa6uFLARXOXmWlboPf7hyy2/RGT+7ogEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4euy1Ppxrb1H+dU9iBLtH8BDZh7+onVYCVuGAkpaT8=;
 b=AcloB0RVAGzhxFMHzr0Y/sGX8fvzhyb5p1ugeEPG0vNyqUdZ0KRiGijtfF3Y1Bhi90dcGgS8znDcoTd/TZ8+THqeMkWlLYxe95Tw/UB6c8d2mgoowjddS6qrpHOb39+2e3bY/0nfVLAGgsCBViI/aiDDRf8L9QdMndQV8+g0cTDpF+RaFtCSmiX8BBQlaFGPip176E4AP8N+2zcIPtVpBE+QDxrJ8MrGSkTQsQIA2SxQP6cONeYTMIv592xSRl16lFpcXEb1Pz/1VhFHG2mo9eK8b0Ga7RGiuDrysBaiDw/9EgQaafPHJ1dwKW4omgGuiQvyMpS0/QBfb8t66EejRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB8527.namprd11.prod.outlook.com (2603:10b6:510:2ff::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 03:38:34 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 16 Jul 2025
 03:38:34 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Thread-Topic: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Thread-Index: AQHb9NiWa9jIv+ZnGEuy/ByzKF9RYrQzAfCggABwRoCAAKjY0A==
Date: Wed, 16 Jul 2025 03:38:34 +0000
Message-ID: <IA3PR11MB9136C94472D7D50CDC627CB49256A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-6-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136ACFB4721D47304A9885C9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aHaP3ULG90gGqWHJ@Asurada-Nvidia>
In-Reply-To: <aHaP3ULG90gGqWHJ@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB8527:EE_
x-ms-office365-filtering-correlation-id: 8132d145-26bb-48ef-ffd4-08ddc41a3e11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?kXU67+/OCzCrwequKd0CIcnLUTqxptjnr34lTKDGVFljz93CIsnJm/vbYQ8p?=
 =?us-ascii?Q?T/fvqceenESBKl3xfhW62ae5PRYg5sHBOe2BxPEBDn2JPAXdENZPVfGjv+0s?=
 =?us-ascii?Q?sSV5ZSvdmDyItMwPjkvz7oNVD0uOrTuFTXSmSxDtin4rPBoOa9BOuGPVuCx2?=
 =?us-ascii?Q?kGs87Yt5/3GtqIk8LbqJ4N2uI0ZjetwOIZixRlzJ+iGuct4qDznKc68X58/9?=
 =?us-ascii?Q?E2VZ0qqkqRKFsSPasy6i4Lz1PRRr8o6hn4v4d2UZZQ8UG8FalIoXrhbbEE/r?=
 =?us-ascii?Q?DdTsUszosoZQeGGV4pmh3bSPhGM4SaNTUrkwcmFMh8uengAT0qHNqdPBHhwe?=
 =?us-ascii?Q?qSubE8xqc47S+C5ZzFUNV1cpeH5Tq8Ck93H4kPAmP9X7gN++4IWRLob5s83M?=
 =?us-ascii?Q?QUSrbzpsUQXwJ/gLvw/dKQ0RXdjIQAY9TQlojdWGo8rInhk2EyVP41RM74BU?=
 =?us-ascii?Q?FpJlSUjBtwlSH0VIGa9nSj2wqQYAWqiE92377rhKtOe9HguhautGVn2xu4D8?=
 =?us-ascii?Q?LZWPw/HCRaxkn3SASvhwgRim3CQoVK4cRySZypSQF0/VwYtI8IsqmfqT0PJY?=
 =?us-ascii?Q?deCRVPSRDL+LzUKhUtGtSDQsU5iGu0tZXVzFasprTff913qpG6ZYq7s91SMe?=
 =?us-ascii?Q?XkEJgwa6f2+LDvpdnSlcyKH/cyz2XaYqvhJn3tUfVwFmjXIU0Tecu8urow2T?=
 =?us-ascii?Q?4jw1UpaavsWW9hTJuptoKIXF3wBkKS2ZqsfHTm7oThaN2Qgj/+yVrcSKfugd?=
 =?us-ascii?Q?yT/TQbmRi0Jnuaq8O/KatqKh5a3OgAT4geRnxYwexqlAsicHtiqZHybEOr4G?=
 =?us-ascii?Q?WP8KMW0e1up/jCL7uI1a0154IVDr/3O0O8z2a9ORiROHsYGqQSn3tdR4jyNM?=
 =?us-ascii?Q?p1AfVA4NsKsiQp+uJ9SnR3V1Xn1STTCC92TPZWIz069oYbN7ax9zOPzzBt0G?=
 =?us-ascii?Q?FYlLMr6bvUGfKlip/JhsPLhsecHc1dKecJcyzhECdo2PYsBHEsxeLCRm9MIp?=
 =?us-ascii?Q?7LoxtdRnvUn4SpgO1PRoi8eqGlndRm5CnYOL/vzcKi4SVPWh0h1a2ZCwi2kU?=
 =?us-ascii?Q?kh3G391pUooXioTomemD98daIYrZCCmKEuWjbruQ2H+eFD2W74g/1mYuLISa?=
 =?us-ascii?Q?2YPpJBj3+XflxXfx5EQk36qfvHqeJhJZmwxKKnrW5V5xy1gPRKWDvq0NRy1a?=
 =?us-ascii?Q?5mJ7I0BT76fp308RlOkKCcul58n3bzSlShaCnJIvNeB7L2W6KJN7iWJLfKsu?=
 =?us-ascii?Q?1hqDp51HkgqG+B6mhWW2MwZ9FA8d/6QndHXW6IRSu6CHTBW073mjJnGe4vbT?=
 =?us-ascii?Q?SNSG12SSxbRRKBi+0/3XltTmgttw70F4ktQvzx59bxuPfIoG3auj3g05OaoN?=
 =?us-ascii?Q?FJLy0QKn4bxPVllj3lHbvXgkO1TcABYI0B7VgK8Xk5sOvtS/sx9/uqFh4Z5j?=
 =?us-ascii?Q?39f5euYF643YIVEc9K7Y9x22QiS/syNxxUoT1C3eEnUZ4HRr2jsFxKJxEvSX?=
 =?us-ascii?Q?oeEiiHc5ZSvUuzw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vLpPLz1h3Ym99IGCx8acvGgNCjAu1/uYIXt2g9pdGMnKAQC8hjADb2oRmy+4?=
 =?us-ascii?Q?5k5dZaElH5X5tKX0eZVe8/+DtINJ9Hf0I8Y46LxW8e33xX+OFtS0CzmbXMsU?=
 =?us-ascii?Q?ovsDv0PmPCTZix2RSiDGX6Szihf/H01BdysAhoBi2jjaza5gnGwFyRlRTEaA?=
 =?us-ascii?Q?d8bzNA39skirzvaEo6ckKXLNNhep/ya4kE3TPadgQtMJxcM/JkASZ4MN7UuL?=
 =?us-ascii?Q?sDLd2H6Ew0/4+6CAZtV07GEXmUDMavCBe3xS/F9aLGanL9Z0eszOAjZTXp1L?=
 =?us-ascii?Q?buHIDyovdaCDBah9RQx6QxBdN/XDeierObDZctuKZJtJdui8tEV+vfbMruDa?=
 =?us-ascii?Q?bataTEA/OpiX8Bhb6JIRZQfRbZ4WXIEhUR3ejn7Ycrcs19C/lf3JNM7AF82p?=
 =?us-ascii?Q?fpqQhuRCAPTLbgVDlBBzme7sj/jYRglFQbYX8qQHnortrY7ThLd7Id9D/Ol6?=
 =?us-ascii?Q?ba1wqVHXK5Oe72uNX4nTE79WzHxrco2/Zyrf4ccOEz4tiKoBDnfGG9w5VHQS?=
 =?us-ascii?Q?8sezIlLoVvto3huwHW8rFCiuPvKrDxv5Kwvg0KkdU3+Bhi5KQK2FcPo+9gHF?=
 =?us-ascii?Q?tnjr0yIq2Wb4xK5G5CDmCo3v8cW/TKPGzPuy6K/cJ5o/Rp9s6duxh5V7e94l?=
 =?us-ascii?Q?xqfm6lZM1snTP/OunBabfbCmmE3U6GBGwLZLXMjfTakFDlTpK+4pPsOPB4Pp?=
 =?us-ascii?Q?sUHTc0R5M3qOME90JvK43sH9Bx9jmf4E6pcN5N2ObitWhHSqKJwWykmmefxx?=
 =?us-ascii?Q?FvD8S1V1btQH98wGXiBQ260dDK44Hfw5Xh9fupXZZOze8xr0zGhel0d4vJJ+?=
 =?us-ascii?Q?yXpcy2Ej1F+5I7ijEjaBpRVJGSQgAoGf2tPfDOxvBMbbR3S1FWc3diEtuKW2?=
 =?us-ascii?Q?MUDE/mtg1w8s4063hVeS2Fo1SwIKEXgvAas8tlX11OfgFtyFh9dPqc14bNUD?=
 =?us-ascii?Q?Mc5hIEBiOrfwqmLimALLaDSXqD1h0c/Wrf3NvqLaMf7KH757xw9roABIOQEe?=
 =?us-ascii?Q?89OfPET9vwsyell02w9HLbNO9dfskMfTZ5wddz6KfToSCtkWrzX2CNbUv8bM?=
 =?us-ascii?Q?MJHTJuKhYvM0HSyyYdekcTS/mFbwv9yzdKW03Ek9mImrIKwOXYIkL0OvYLx/?=
 =?us-ascii?Q?nqpRzxjW7e/c9OlmnQDj+SCStiClKPBK/0S7+87IXOTOA+C3i8zbCjfbAX3f?=
 =?us-ascii?Q?Fdf6KuShBQMNKRxDY+6hpFCnC8436P7XrB/f4bzyMCvPzXEi9BIcbb1rsVlb?=
 =?us-ascii?Q?ERLphmgDvuh9L6REGJw9Ptl0kbiav2P92GYdy3nMAYnmTau6GhMFk7GF2w8L?=
 =?us-ascii?Q?vvtiMXhNnj92xt4kQJ1/U/cUXGe/MfO8+ozHG0swoyQZSummQttnMPUA1IV5?=
 =?us-ascii?Q?4D/rQOPm5/Rq6I7312Z4jTvd1i/t3gS6iqiaf6kmnlee6s9nG/1ccU0PyXYJ?=
 =?us-ascii?Q?gOeZjanSGXllxbjnahoAL14XAkAJ1B+FINc3Ly0fDD7l8ypS+VXHMpAhwIQC?=
 =?us-ascii?Q?Q+nbGviFyzAnIGGm0JEDe2ACU5gvpJf0oFhtvt+pB6h6KQPpal/h9ymViaCv?=
 =?us-ascii?Q?KrMjPofOD2P2Ok753uDdbsJD6INhisosFz5SdfKT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8132d145-26bb-48ef-ffd4-08ddc41a3e11
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 03:38:34.5597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDrFlRNqxQY6xIHS/qVLwd8jgGTUrexm9iDwk6XkRCGlYZZkCPUAYUMpZwnVytmD5y2mq64066ZyRXmopyVe+liyzQdjy6BmNlCvn2WmcG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8527
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce
>smmuv3 accel device
>
>On Tue, Jul 15, 2025 at 10:48:31AM +0000, Duan, Zhenzhong wrote:
>> >+static const TypeInfo types[] =3D {
>> >+    {
>> >+        .name =3D TYPE_ARM_SMMUV3_ACCEL,
>> >+        .parent =3D TYPE_ARM_SMMUV3,
>> >+        .class_init =3D smmuv3_accel_class_init,
>> >+    }
>>
>> In cover-letter, I see "-device arm-smmuv3", so where is above accel dev=
ice
>> created so we could use smmuv3_accel_ops?
>
>The smmu-common.c is the shared file between accel and non-accel
>instances. It has a module property:
>    DEFINE_PROP_BOOL("accel", SMMUState, accel, false),

It looks we expose a new TYPE_ARM_SMMUV3_ACCEL type device just for exporti=
ng accel iommu_ops?
What about returning accel iommu_ops directly in smmu_iommu_ops_by_type() a=
nd drop the new type?

>
>where it directs to different iommu_ops:
>937 static const PCIIOMMUOps *smmu_iommu_ops_by_type(SMMUState *s)
>938 {
>939     SMMUBaseClass *sbc;
>940
>941     if (s->accel) {
>942         sbc =3D
>ARM_SMMU_CLASS(object_class_by_name(TYPE_ARM_SMMUV3_ACCEL));
>943     } else {
>944         sbc =3D
>ARM_SMMU_CLASS(object_class_by_name(TYPE_ARM_SMMU));
>945     }
>946     assert(sbc->iommu_ops);
>947
>948     return sbc->iommu_ops;
>949 }
>
>Nicolin

