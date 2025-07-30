Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509A7C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 11:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh4pA-0002rE-FO; Wed, 30 Jul 2025 07:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uh4TJ-0007Sd-5h
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:55:47 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uh4TF-0000Fd-Hv
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753872941; x=1785408941;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QDnRTLkAh2LPXcDSaPKquLGUfHa515r/2Ik426wx2Oo=;
 b=R+Sd/y4cwwyOvL/Bk1PM8yHkBOj7w6BxX1yWsm1208U+LWtOYqlW5927
 mozICdBH8ZLjczeSdIWZSATjp8Q2hXOTQugAYvcVDfYS57Ml0mUZw4qtH
 9/6qDGuqqYRF52zKhv/XDPSq9oQNyrignwgoG09YUj4V0r4VfIroadgzv
 +pnhvkhcSYVtghukH6q6hiHdIhMFU3E/lLvFRLC61k2cORpy88i9KxPvA
 7ZScBoO7ZrFHplZ5iUL6jQ1XdXobdvWIvme5EJNFFo0CJYWfaj6ddSGUz
 FEtuABaZfzJdMq8SB41oFMb8Y/M8Y6n6sCTDva/Plc7RNS9MBxv7sSlb9 g==;
X-CSE-ConnectionGUID: Pg6X62S4Qj6ZWnO3PCQCLg==
X-CSE-MsgGUID: /URgorY8RrqCnWWC9gBIGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="56135541"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="56135541"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 03:55:35 -0700
X-CSE-ConnectionGUID: wQqT/jjTRA2F/a4ZbRKLjQ==
X-CSE-MsgGUID: +gcX4YTWTeCEzOYpuAe3rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="167441821"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 03:55:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 03:55:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 03:55:35 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 03:55:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNxPRZIW+eFC/tj5tnNsdFT3EYOycW6YLWsvN4KqSakFYEKoaJMfkI6ETKzUB4xIoq38TtFTcg334fFyoF9vl0OkAHRJOxUGjMWG23Jj/mMxOAPUde+dPZ3aWDnQGEuDjYPVOTnrCt9Igio/qPXjlt/x+4BbJMr8bv0YMiVzkWV1hs7Adx173W88mYTo1He8DECiFYgGdEP/BIMR6iFr0nMBpPUODF4Jqsb4HNdtiEFoFNn/95LSOSGAj916SlIAh51ixf/5qP7BqCwSJAKb/nWbM5SuYFnlaAFUc5wFMAg/C4bE4c27OquGs+XRK1vlX937HLtT3/secGfbaAw8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rnpxV/3wkGq8K/Ul014XHLeSyR5IyLKea9xaUYohVM=;
 b=Kkn5rfwC4pMMvUFMBpJNVia7+r1Q2UT3Y8qcND54YBf5I2gr/10A+H3+l2upPVfSFsGp7GdjQsZEaKVRYJnr4Wf4+5BHtGMRa9FtjxUZQLWmlZaAUX3k54qzs1pcwvSY1MD/pulv7gy4qGKe809hruqbQy+9TvlT/az+tWetAowOhy/lq8ynQPaTPEqJUrVGIbmiCWAD85ClfmEYHUWgqQtuyXSDMR6GmfBylsdf43zvPHF2y5kP0eByC1NSanRgHAoaGLgaIwei2F4w9m/IQTJ9uEhMgfqZXrtpe8glA9nSNRE1Gitsnwg94toRZoRUIy1CWkF7ZFFS7y038Cszow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Wed, 30 Jul
 2025 10:55:19 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8943.028; Wed, 30 Jul 2025
 10:55:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 04/20] vfio/iommufd: Force creating nested parent domain
Thread-Topic: [PATCH v4 04/20] vfio/iommufd: Force creating nested parent
 domain
Thread-Index: AQHcAGoofFm7MkRMFk+/2nrYogGqmLRJHN6AgAFiUjA=
Date: Wed, 30 Jul 2025 10:55:19 +0000
Message-ID: <IA3PR11MB91365795415087EF9550FB209224A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <20250729092043.785836-5-zhenzhong.duan@intel.com>
 <74895627-74a8-4cb4-a460-491ac5dd1c2b@redhat.com>
In-Reply-To: <74895627-74a8-4cb4-a460-491ac5dd1c2b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB5327:EE_
x-ms-office365-filtering-correlation-id: 6281bcca-681c-4be2-76d3-08ddcf579331
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CfK1rSe8hdQ+10XRCLvrfYHRO7SVlpi4LLM/Tb0Cbn06q6cPN4gMHnIg/Z?=
 =?iso-8859-1?Q?p4/8jTU7KzLI04obSBzsW/leNqmvJcp5jzm2DfWfnZUK6Rs25damNuMlth?=
 =?iso-8859-1?Q?taW5dt3zH2irEI8inwjUj9vmW+AhfNj68j14pOxdJStDHqsxRtRK0m8Qu0?=
 =?iso-8859-1?Q?3+nunmo8RwIjGyGFb6GVJfgM3XRwzhoMFYVjp04vMe+mfLSZ+791nqHrix?=
 =?iso-8859-1?Q?Z/FW6ojZqFUAxa9WLnfRhaNaov6/q+ffjfUXAHBQtv79t5Q4F6RPT14E//?=
 =?iso-8859-1?Q?7Zsx7kIk/IM60U94pg+wK/UeVp5V5ZVe+X3daNAO8xHBWmPhpSRYdSQdr7?=
 =?iso-8859-1?Q?dtFclsMnrgA3wim4hGRjs1CHCIIHSuHGKy2nXHfJh8MW3hcvWzPzL8JkpQ?=
 =?iso-8859-1?Q?zP6jXypA9DmxcNYwfqaqjBfbaS43JYGhz1QKb2qdt+V2+jfwpRWptGfDCe?=
 =?iso-8859-1?Q?zVD1LbAjhV4I2QvfIvK/iL+af2FvrCaQglMXIXo4bezxfb9OU/hr96+b7T?=
 =?iso-8859-1?Q?ITqVtZvEsLtdyp97aF/fq6ZV2NRgnWVt5j5MvbNAQGf21AxB7XaBrlTkhx?=
 =?iso-8859-1?Q?7OCeajpLifbkI6Xo/nPm/IMNtRaN46n8oxMDPeYV6HJ81e+SvTD4XgN+2e?=
 =?iso-8859-1?Q?OvOHTKvyHzuUVMg0zh9fLGqVtFAbvyFqr20umqeu1W5k7FEwm4xm1WEkp/?=
 =?iso-8859-1?Q?Kh/NNfC1mJGYHwiPQX4it2r3yw0RORMcmw+wDgejYtVKq1OUHU9mtA8N/j?=
 =?iso-8859-1?Q?vcbHg73FpqhoT3ylx0HLPcl1sswtl0bM3CQ9L7AXU+w00enRBZaESU0qxU?=
 =?iso-8859-1?Q?wP63nFu/Mzg2nFoFAqAFRAu0s41URa2PtjeMqC3daSjkZq+HTSJtR+6582?=
 =?iso-8859-1?Q?5u9JuadqThdEmPxXKjMjevSnKQVoATer54jkmWkwDQ4SVv2BQseRF9a/GK?=
 =?iso-8859-1?Q?xMEQvib5HawJCVrgRdbF7YKJEiJJL1Jn5+3xxn6JyDw37FcnJG935xhhX+?=
 =?iso-8859-1?Q?mN1tPiTjnogL5sJXqRbj9XOMNE+XRm3QT3q7Z1H+GfN7iUTTUmuz9m9qtc?=
 =?iso-8859-1?Q?2V9iAFPSNuFi47Mvflu3BH7NXPJAy/jIU5H33wDNiqSfDbWey0PjRqelBv?=
 =?iso-8859-1?Q?2ulDtJR7jou8Xd7BRXpdM5Vet7pcxRcUhb5CJnz4d8H6h8fZqRROOzlGT+?=
 =?iso-8859-1?Q?Ttd2QdxnfqaZaopzM0W27xF3bJxHXboPYOSmf9P4DmXSTkr3pdIbQHuB9K?=
 =?iso-8859-1?Q?wHlqhtOGAX4vn1lXBWEHXQNmL3/Fz/FffgX9jpyI3wwVLthw3UlJTRg1aj?=
 =?iso-8859-1?Q?MtXGSVXWWq+y/LLHpkXPCACYipDxUcdzLDbHIuHVTcvzA69JOjMMnL6s2L?=
 =?iso-8859-1?Q?LjmYwQGKURwo46xsYzRGVJEe7MCx9RsogzXIIghLEQrwS97AJVBUfq3ilZ?=
 =?iso-8859-1?Q?FJvVOIeb1kBobzYjOOlK5uqMCPPh56jvEGigUwpB0Xg9N5JVi3ywlV6Hr/?=
 =?iso-8859-1?Q?HXmWgiUDREEVXWkoLvuYxk2/RdXO7bFu3kNlsZdDKcgZk58T3JMVoqMJNk?=
 =?iso-8859-1?Q?fH1ROWY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5fO6tngodmvvZUPIOsxVi6bjSMqTYGsy6xDZCWQTFgRv/shkFFMyLHLX1C?=
 =?iso-8859-1?Q?TtbiODq8U1Vpq7bBLpjYM0+VHfjhAmR/ICCZxcJ0kLjg8eV9/Q5xbcODx2?=
 =?iso-8859-1?Q?/bj4MQ97pV1pN/mLpUAVd1eTt8ekS5SIP7sL30XmJzQtPSsxX0fZaGRhc6?=
 =?iso-8859-1?Q?jURmJRuM4n/+1hPFyGiZ+jQHppOtIysktnJwR9njOURR+a2GgcVGEgxOco?=
 =?iso-8859-1?Q?hgh7TUKvm+b+QEWo2faNKEQB8xLKRAVX44z7bhHDog1iGL5S3q4L2ipQee?=
 =?iso-8859-1?Q?2GXshwV9YpwwoQR1UTFv9xzFkqf2O+ehUvN1zoNUVqlfIUwrbTeetNO5Ue?=
 =?iso-8859-1?Q?yH9CtWU07KAqXFXWOdSIK/ZKbrKIuoc9dR2Lu/56hmbUDAGhxL54VrrRp3?=
 =?iso-8859-1?Q?qUvZR9CYVhDV/KnvlqmTwAjlDESxpRtbpBAhOlRIWiZJEhvshB0DEyb1mW?=
 =?iso-8859-1?Q?L16RyIxIn4kcSNYJHYuQZoPbcfrdhtptBr6d379jfAI1iwte1KaPgIkkVF?=
 =?iso-8859-1?Q?p3NqvN4AYMp1FSVLob5ZFlmOGi4QzQHsLngaMGX4L8O9usWM926iYj/dNi?=
 =?iso-8859-1?Q?rwMFVGusuvNyfvSmP0j5ZQk8W3tbx0Khd/tzEQJw/vZOkM+MaNLmHcasW4?=
 =?iso-8859-1?Q?tzL/9ke17MRC8Yd3Sd8Tsfjfr2sy6kqLO/S2+w7oQedO6NPBWE88sVPtym?=
 =?iso-8859-1?Q?7f4JD/SdltbMqWpzsH51YPsSR2U1zOAPLx/IZwVBrla3JhWAdNVbtHJlvH?=
 =?iso-8859-1?Q?whLPEK6OJD9kTCtt7s5EuHUK7UiUVeDXVijPmtEmOtg/GOMuYKSaNYCBj0?=
 =?iso-8859-1?Q?mqAQWBqgErSlZr1qxn0jV4rcjRmot9DsDi2C/rdGgIGvHgwpP0tzj1sLjJ?=
 =?iso-8859-1?Q?knhfMQ9s3XMZx3r27SHALBLBZHFEt5weEkBh3gMpQVZzpHXMrEoBEyZLKX?=
 =?iso-8859-1?Q?f4D69mGg2doZ6Z9IwsW8x21IThL2l33Nz4LnQkW/HxR1LDUTlS9GUE3GSX?=
 =?iso-8859-1?Q?B1r9H0FyKvePtwp4Wo8IxTcElTr+coA5ie93L26QoNeuYBhXTySR5uJGNH?=
 =?iso-8859-1?Q?GsCgw713u74OJSKtDfkupip2ihoDPfQF0NTx3LckrQ/JtVZJEM/ttgu5LK?=
 =?iso-8859-1?Q?oHeUbZHtankcJceBih+IVefegy4ceefl031qlJtz0hX2/rp8MxlzWtZQPw?=
 =?iso-8859-1?Q?xcrEYv8u2S72EE+8vCAh7frjOrdPpoFKU+6M9o3U6KQ258sjYwL591rL98?=
 =?iso-8859-1?Q?5zMRBNWcSDzMejpWZJ5oHZadncqp3EBfwqRfouuM66yxPW8R2MMjJJrceD?=
 =?iso-8859-1?Q?Q7o/pmR3vgFDR6PiSWZSCTyNrd0rrlZ9WUIMsu6s4ZJdrO6zpyh6fAsjHG?=
 =?iso-8859-1?Q?+/O74MIvm9W0OZgw0yI/nlT2gP03xTK98AcDWs11RrjwstUP8sJebmVJiY?=
 =?iso-8859-1?Q?2IvUfxJnbwFaqSik04GqVA3MAJUldnxIBcIc0h0YSWIW+HaTgxFI79uCTr?=
 =?iso-8859-1?Q?q4F9qIHUEXajyG1uJ5rpxTkM4JqEHQRX7Vzx0Il1p0lXKWb1rVhRAuJlPd?=
 =?iso-8859-1?Q?7GWuBUbAXKaWYDhZt4cSvo1IVbO0Tu1yjhYPDHKyn07nIZ8gpuKqv0rlMC?=
 =?iso-8859-1?Q?ysiJ03gDZQxJ4fOTSAuA8xGzWCvlQxUcOU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6281bcca-681c-4be2-76d3-08ddcf579331
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 10:55:19.4677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hs55oFso86/qucA+Qug/dPZnlKMQOEzhHg931U5s06wB8qZxzFNlB7kcAYSqg3pwi9XEHkeAHqxW8ahmkBqZzD9/nY33kprT3axY1MEbjVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
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
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: Re: [PATCH v4 04/20] vfio/iommufd: Force creating nested parent
>domain
>
>On 7/29/25 11:20, Zhenzhong Duan wrote:
>> Call pci_device_get_viommu_cap() to get if vIOMMU supports
>VIOMMU_CAP_HW_NESTED,
>> if yes, create nested parent domain which could be reused by vIOMMU to
>create
>> nested domain.
>>
>> It is safe because hw_caps & VIOMMU_CAP_HW_NESTED cannot be set yet
>because
>> s->flts is forbidden until we support passthrough device with x-flts=3Do=
n.
>>
>> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   hw/vfio/iommufd.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 48c590b6a9..61a548f13f 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -20,6 +20,7 @@
>>   #include "trace.h"
>>   #include "qapi/error.h"
>>   #include "system/iommufd.h"
>> +#include "hw/iommu.h"
>>   #include "hw/qdev-core.h"
>>   #include "hw/vfio/vfio-cpr.h"
>>   #include "system/reset.h"
>> @@ -379,6 +380,19 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>           flags =3D IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>       }
>>
>> +    /*
>> +     * If vIOMMU supports stage-1 translation, force to create nested
>parent
>> +     * domain which could be reused by vIOMMU to create nested
>domain.
>> +     */
>> +    if (vbasedev->type =3D=3D VFIO_DEVICE_TYPE_PCI) {
>> +        VFIOPCIDevice *vdev =3D container_of(vbasedev, VFIOPCIDevice,
>vbasedev);
>> +
>> +        hw_caps =3D pci_device_get_viommu_cap(&vdev->pdev);
>> +        if (hw_caps & VIOMMU_CAP_HW_NESTED) {
>> +            flags |=3D IOMMU_HWPT_ALLOC_NEST_PARENT;
>> +        }
>> +    }
>>
>
>Could you please add a wrapper for the above ? Something like :
>
>static bool vfio_device_viommu_get_nested(VFIODevice *vbasedev)
>{
>     if (vbasedev->type =3D=3D VFIO_DEVICE_TYPE_PCI) {
>         VFIOPCIDevice *vdev =3D container_of(vbasedev, VFIOPCIDevice,
>vbasedev);
>
>	return !!(pci_device_get_viommu_cap(&vdev->pdev) &
>VIOMMU_CAP_HW_NESTED);
>     }
>     return false;
>}
>
>May be this routine belongs to hw/vfio/device.c.

Done, see https://github.com/yiliu1765/qemu/commit/7ce1af90d5c1f418f23c9e39=
7a16a3914b30f09f

I also introduced another wrapper vfio_device_to_vfio_pci(), let me know if=
 you think it's unnecessary, I'll fold it.

Thanks
Zhenzhong

