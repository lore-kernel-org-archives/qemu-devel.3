Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F843C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 09:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnwoJ-0006UC-6p; Fri, 28 Feb 2025 04:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnwo8-0006OF-Jn
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:37:26 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnwo6-00049D-LL
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 04:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740735443; x=1772271443;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yXTZRTky1rHXgtGNU9PCMMAlKpRNtrPB0RMKQM0x1iM=;
 b=kBI4fiUVCCUdpfOiBvyDqdXeVzurnnJDC5gsrNfAub1V0stOQNkfOmbN
 akAr9lDEblwJNxwMamXyfBzKSjDhfPMdXFnbnykrOboVSNXfFMDk/gyhE
 mtIlbLpjTwbMLxN9Br09i8S9MLhqYpc18pBR32HwuvbvYG6foOSQC1Zwu
 4wb6pc7WZVjpBGykWNIRmey7kmWJnf5EcU53aI/hQwT54kW4QG91M/uIz
 Qd4OTrlyDjYr0Ls4YsVql09DOfqT6xtirDB10p0hELW8nMfxthTFk71jA
 cYbBEPXXohYiW0nkic8oxoTAqOP80q5MZkwBSNRKE8/QFO+qpYrg1zaNv w==;
X-CSE-ConnectionGUID: DvvlktMsT3C66Ij6RKbfVQ==
X-CSE-MsgGUID: 5dGK8oW1RjaqJHjZtqLOkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45439382"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; d="scan'208";a="45439382"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 01:37:21 -0800
X-CSE-ConnectionGUID: FANgZRtmTBuuvBVgbL6fJA==
X-CSE-MsgGUID: MLGB2FmURJu+haZ8yJr1UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="148215922"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 01:37:20 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 01:37:19 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 01:37:19 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 01:37:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rghcszDYp8+5MgoPU1De0pXkiySTkSQiuU9YIfQKpIeMJa3P1+SQySxwfKaX21siOPY9cq1XLPoVe9VnCazMRHdYwHJymqEyQ6JcsfnDwZrCYxzEHFFzdM+mYCSGam6m/FSzGSGSKvQfkK2SHacu2SpCoveFtXvCQP+7epsZfRLRmQo2eeWHxX1Jp0qRq3rjI10FpUFYclL0/E6Vfagmp3birzdvCwP5SuwhvNRIhT/Olwji8PBk6YC2+lBpI6dncXucwh1i7K/1XJOtEi+IE0xdZvnzBPZbi5zifrxrtvDbI60BCRnwPSkZLyq6gbUUgmoYRpig7gCb72Lc+dMVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5E/vlQw1gzfyX0G3POLeoyuFYRH8tAVX5aqaOsfEcs=;
 b=QoqXvbgzWv1u+GlEepO8mnVum7jwf9Vpo+wBKMGqNN1koSUdOt5wicdBGgecibLRnpGkpbVV14EGAw7Nb7kfRkrv3oDPiIsbhBfdgiM1cL36ylYJyp7pNuI6EKczfLuhDzZP7erZVYUVKQRpk0Y16O+NK1IUawneeB1okwqjK+A+leevInp011SnbLB69tXgw3eUQlzuP8YvaZYzWehbwGmL50CQLDh6v0Vnj4J8j98txQ8wEFv+FYrgEiDumMQTDsa3tOCO+g8w8r1OLPWsssr0ubYWZ6PNvcxV1Nu0PsH0hoFIj3S/tM6ccVffnSvaoUCqTE7VkoN3lMnJB2jKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB6897.namprd11.prod.outlook.com (2603:10b6:806:2a5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 09:37:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 09:36:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 01/20] backends/iommufd: Add helpers for
 invalidating user-managed HWPT
Thread-Topic: [PATCH rfcv2 01/20] backends/iommufd: Add helpers for
 invalidating user-managed HWPT
Thread-Index: AQHbgqf2du4TDl7Tuku7EhsMkpByw7NWQVOAgAZByZA=
Date: Fri, 28 Feb 2025 09:36:57 +0000
Message-ID: <SJ0PR11MB6744CC7A5CF8C7CE9CD9C33D92CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-2-zhenzhong.duan@intel.com>
 <9c47c785082b4c6c8751164de6481c08@huawei.com>
In-Reply-To: <9c47c785082b4c6c8751164de6481c08@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB6897:EE_
x-ms-office365-filtering-correlation-id: f54b6c84-3779-45d8-2c62-08dd57db71a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OPPXm+bz/s4wc8Fh1D0gnE+3dnbnD4EMKHlTbfqPClFsughQXRd5mXPOpQ8B?=
 =?us-ascii?Q?xpphKj6cRqsWC6NWU+Qo3Slozxysw3rBlklOzkpPO68tffvcFhRxF5/1eTIi?=
 =?us-ascii?Q?dTs/uNepm6xBpBFJIoIzB049M5jvRLEdJ5YZuhfNvKWvigsPfZZKeMdqOuC5?=
 =?us-ascii?Q?2Pf6/WniMg65Td2ZE7GuzdOhY01fcqGrkINF+9Up25W/lWGyop71uAFvKCj7?=
 =?us-ascii?Q?Bvc7mOZ1l+75q2B0clsQq74vEww8ULAx2jmfVp4PQs8C6QpsqnuayJ/awqqA?=
 =?us-ascii?Q?lMcP8m67rXuZit3c1rtBccDmwrZe1OKntRm5in3HdjIStHnjgACrCs04LOyj?=
 =?us-ascii?Q?sHKX7UpXv5MrIvdj04s17YogIsfyswonaKUD49+3Nwzb7i73XI7omgv9KI1e?=
 =?us-ascii?Q?tMxXILyAB0504XyFf9T873XVO1ARzLJxxVGNbp2iFlpC7kb9a8FlV1le+yPu?=
 =?us-ascii?Q?qItfCD9on173P5d/QfNLQaML942vrAJ8RYwuP7AMNW+8ibJ4LyvcuLZ5DzO5?=
 =?us-ascii?Q?ReTthRxr3yB7aVUpO5XRsXMvojxLRDRu+yzajOZ8A6Xx39zt1r2YkPUtM2Jp?=
 =?us-ascii?Q?/RMya9bDXfgJmcPg+KnHNg6H7XCM5OvYlOFUEqqfRhiCQcFjIZumzugthBi3?=
 =?us-ascii?Q?jnal4q5IRrluzXXq6ofKc/8840u+xP9hJQROHtyA66gHLvJo55Tbyt7h97YG?=
 =?us-ascii?Q?xD1Y2ZyhoxrVXfW15fejoJbO3rI4l71I5wUxkY/Tb2laLTTjn2/E3F9yHFs/?=
 =?us-ascii?Q?BWvcX7D8S/orXQDIYB4XFZLLkou/3GiatXJ007GxSqJ8CY4xwwNwcycuQId8?=
 =?us-ascii?Q?edDNb0D6LinFT3srQknXYZOKVi2gEhp6DDu+swOkhQKeo0hvVfI7SdNr1XTB?=
 =?us-ascii?Q?YJKT6587smyjnVf+IoloIFyUjw84gJU+djk1qe9Vb316dRhd06/nZdYLx7R/?=
 =?us-ascii?Q?k4fGCb20LEmIZUzHz9I1DdHXRxPlMpE47dFL27BT00TkbMbzt+0rbJegcrmA?=
 =?us-ascii?Q?ayqbXa82+75hxGFPiiqX2UzUL/bhRkejynXKuje8sbw28ujDpbZP+j3//ypZ?=
 =?us-ascii?Q?mUul4z+OdXGOGRwlD/hW/ABBl2FybFI6X9Ebx/zEeeW9aIa4FJ/HrGhJrLKT?=
 =?us-ascii?Q?z7s65IWcC5TNJOc1WnVmdBebapD6MnQN+HS+tpY/OWSHYBsRRYzvzq9AHjnC?=
 =?us-ascii?Q?ILsR8jxNe2D2q93QVXMSvVRQHfJVaZVC71VC7RiBqp0A2bYJIShof4xCCJvo?=
 =?us-ascii?Q?mxqbCgL8lYoCOjC8DDRD67DYRVyXdN7DCzD5KM0lEd7ZHURmHFYxfCwJKaL8?=
 =?us-ascii?Q?pHxATKe/BeOApwJYA5sSy5G6LxXMbUKy1PYAYmBQPhgjLYzqRRmjYee6FLQa?=
 =?us-ascii?Q?+zQCaSC2hpbRddr9aKXozeWUO0BNxFCRplTbtuyn3otjDcFnnvesjxD/NUUm?=
 =?us-ascii?Q?sLpB/PHsqlvd8s2ON3IQGPrMpfz4yd3x?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?21Yx5ZgcQjcvdzmyNBvWfEos3tvhs0oFl/vMIzkbE/CgBCxzSyLL2u4JqH5r?=
 =?us-ascii?Q?ik0OS0R6hUx6rgjBFLc1rpKORLnMFwnyGIlz3XPBVQHr6YQ7+Mugxk6R+kz1?=
 =?us-ascii?Q?w9PL+cIUuQbh9EcqmNm4tAZw0YqT3Y8jzghKJO+gfbzvt6WLi1f2Px8eWYFe?=
 =?us-ascii?Q?7givU873FMKAvokWy5GYnlPvMV5YPL32m1D7qnSdWYiPedO9WNZg86o9kdW8?=
 =?us-ascii?Q?iWqJ1XgqZDnaDhwPP34BTPz8d+yiPHpSz/hs+iI6Eu17c6Xl6YyUvb129Tb3?=
 =?us-ascii?Q?zAOq1uoCQWBvxo+l6m2favk7ngzD0WgYfeHxiVlxtFyLdQH0Bu6gDjupnbhU?=
 =?us-ascii?Q?u8tYVVhUDg89iDpovtzh3dTucBBLjHPIlY2Sre8hInIGPWl7+dMc3EMMkcjK?=
 =?us-ascii?Q?QQqxx38PA96ahIxG/Bz2brZCQgPXsgbA3iPAmQ9kW0GA9Es88lY1WWryUyNq?=
 =?us-ascii?Q?uKKDXvvzkX/bSyc7YN1CPKgPsvTxQhnrQotnKfRn3DeI/HZTHZMyec53OJD1?=
 =?us-ascii?Q?GF6qsy55HwSOfVg2F7KfZpoq5vPCix/2LZdJLtTw/QnFZKcdH/dskLARN5os?=
 =?us-ascii?Q?9vf44vJqkxUZpJZs08wVKSXM8xgs/1f6JW1qq9weIRP31QGjrRpdBc6OAc+v?=
 =?us-ascii?Q?mP01XT+PZJYwR4YX6J+FrjqdUDdsY4BcCuu5hoJ17ynRt/D6pVq9P1INCfHR?=
 =?us-ascii?Q?N9QXSu+QCmCZzJ3BIcvLQ0FM8P44GD/O7wu29slMIuV8bEfSQMwtw22WCIQK?=
 =?us-ascii?Q?BJs0zHsEexgono1AKA9zXVFWEoPwT1W9BkFib/I2eGR91mAqxPqOR8pVOYsA?=
 =?us-ascii?Q?givX5aS9ywQhwMlFOPxMxVeGl6uU4+QlX7uDkYEEfsPR4xWhFwvrmjrAHYPv?=
 =?us-ascii?Q?CgwVuoVSw8MuUpnLu4OWl0hpI2Ba3l2GBvB/gH/VKa3kUm7aI73TvhmuRLU0?=
 =?us-ascii?Q?AvgYJrSXxzETYVI8v+MzFaS2sjpgPBnJkIPNW0Abk0h1FdhbyLxUU0n4HXxr?=
 =?us-ascii?Q?WLNaPwiL4INOy9GmftlR+I3LjcKFdESkULFqgv/vNKf3Q0d8PDN82kl7xiRF?=
 =?us-ascii?Q?umvCnaxRIYivNxeVGlU6Ca/sNWEs6Rx8aeo7QVT9M5lpiztPjBpFQorK6jqj?=
 =?us-ascii?Q?hNJWHw+sIJ9sNdrQ9GtIHotFY/WsJuWgW7kVxgQpxuPaJQKyoPrr4PgxE2Gd?=
 =?us-ascii?Q?ORW/RkB3daX14Yeq5CS4uemt9raXiLXCLGlx1K0buLFsTQ6AbqKbISmB1vR8?=
 =?us-ascii?Q?TKxFwFYruPUSKDEO7ALt85GCokVq1QnYxcOlXyokDqTI2E8GQXZ9AgXD3B/w?=
 =?us-ascii?Q?FtSoBHe9hNPFUtitcwzg9d6Jm2IkOlB2Bfg7IAawSbzvotSsJH4Pwee9mn+t?=
 =?us-ascii?Q?pe3FGkFZOQUtUsz4eXssP6nDO97xpyj/5ERPx1IOxeXK+FrUgmaZEkJvLgcH?=
 =?us-ascii?Q?0/XH1GnzAPgXfZODJtPD/t7bv9lkQKEjbRZrJxwq7neTX6xaUVKLGdbXaCGB?=
 =?us-ascii?Q?zIBpNxnsQTuhs3WJr+bsKoa0gbpKdRXVbQXi9KI/DcH8Qn1HVLQdzMovvKaO?=
 =?us-ascii?Q?gpQMniG9KLVBkza0J0d9pN/PEOmhR+AZD2fCUaHQZgSUSiLPtRPpHBHm8En+?=
 =?us-ascii?Q?Rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54b6c84-3779-45d8-2c62-08dd57db71a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 09:36:57.2115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FiKdsRbS8GfTcep8ZKZU+Gw6qHUmW/JAWUzRl7hD36Lzo81kBOzfd0Vb5WsIFkt8eXv6o5hxZyjEsuoTGKjn6jTP5P3m75Vn+3PJiKQUI3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6897
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Hi Shameer,

>-----Original Message-----
>From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>Subject: RE: [PATCH rfcv2 01/20] backends/iommufd: Add helpers for invalid=
ating
>user-managed HWPT
>
>Hi Zhenzhong,
>
>> -----Original Message-----
>> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Sent: Wednesday, February 19, 2025 8:22 AM
>> To: qemu-devel@nongnu.org
>> Cc: alex.williamson@redhat.com; clg@redhat.com; eric.auger@redhat.com;
>> mst@redhat.com; jasowang@redhat.com; peterx@redhat.com;
>> jgg@nvidia.com; nicolinc@nvidia.com; Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; joao.m.martins@oracle.com;
>> clement.mathieu--drif@eviden.com; kevin.tian@intel.com;
>> yi.l.liu@intel.com; chao.p.peng@intel.com; Zhenzhong Duan
>> <zhenzhong.duan@intel.com>
>> Subject: [PATCH rfcv2 01/20] backends/iommufd: Add helpers for
>> invalidating user-managed HWPT
>>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  include/system/iommufd.h |  3 +++
>>  backends/iommufd.c       | 30 ++++++++++++++++++++++++++++++
>>  backends/trace-events    |  1 +
>>  3 files changed, 34 insertions(+)
>>
>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>> index cbab75bfbf..5d02e9d148 100644
>> --- a/include/system/iommufd.h
>> +++ b/include/system/iommufd.h
>> @@ -61,6 +61,9 @@ bool
>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t
>> hwpt_id,
>>                                        uint64_t iova, ram_addr_t size,
>>                                        uint64_t page_size, uint64_t *dat=
a,
>>                                        Error **errp);
>> +int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t
>> hwpt_id,
>> +                                     uint32_t data_type, uint32_t entry=
_len,
>> +                                     uint32_t *entry_num, void *data_pt=
r);
>>
>>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>> TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>  #endif
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index d57da44755..fc32aad5cb 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -311,6 +311,36 @@ bool
>> iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>      return true;
>>  }
>>
>> +int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t
>> hwpt_id,
>
>Nit: As per struct iommu_hwpt_invalidate documentation this can be an ID o=
f
>Nested HWPT or vIOMMU.  May be better to rename this just to id.

Sure, will do.

Thanks
Zhenzhong

