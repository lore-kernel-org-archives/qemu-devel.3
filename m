Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92CBC54FC6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 03:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJOnN-00020k-9N; Sun, 25 May 2025 23:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uJOnI-00020T-UI
 for qemu-devel@nongnu.org; Sun, 25 May 2025 23:46:33 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uJOnG-0006gg-Al
 for qemu-devel@nongnu.org; Sun, 25 May 2025 23:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748231190; x=1779767190;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7cLYrtB7BsibcT2bMMqH8nfKOtaQ2kO4Hsi8KBsmJYY=;
 b=QEMOQCgRiijlMSWAK+dbDtmnezPStAL3Qf2SZjEoeba+h3PLUhvVFiEm
 86EOwEnBqvIlpz7GTaht6c8WDOQPPL+bzdXJdyd0F7FV6vfTm+XNSzwEI
 FenBAj7+H5z2dCuYSpdHRn/qpb8LY1FHpGaqBqL0uH9uhG2v/SUH///Qp
 MjKcaxCYiALKHGs9vWQ3iMxsdUXvLIOqtG8W1+WB9iz8oJFYSsis6kSpD
 Sey9Pp6MX875pb+6qtlJ6IGG1fwJb0OOI386fbsXJehyWpL4kecj3iFX9
 9hPs4wqp2Ps+BYeSRrZR6QfuN+xUdkDPKZMc+zDx09kNsU+6LKzElml3l A==;
X-CSE-ConnectionGUID: KdNtknOLRd2hG4CBEgZ/aQ==
X-CSE-MsgGUID: OqLhtTe3SJuwbtnzrmuNyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="50353007"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="50353007"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2025 20:46:26 -0700
X-CSE-ConnectionGUID: xAmc4/BLR5+We6AHiv+3sw==
X-CSE-MsgGUID: sNsVVTNrR/qdLY96dHIElQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="179364555"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2025 20:46:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 25 May 2025 20:46:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 25 May 2025 20:46:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.69)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Sun, 25 May 2025 20:46:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3SBbq8jSc77p29YdVHSwobaGiNBvJz0GIH7t5iE6I9u380YHi6dX9uGPkbuQTI62I8mPh0rC2G4qe6JQJrQC0pKvb6NqyGwoYk14jaEU9KhAyJ27tmNDDaqJmtYVRlOnqg7VHKR+63MqVVeVudTKaVa8BwCi+f1xfnLOyR3KMO5tU7LyJKI2Q+1k23+fasA/OeJq43n9KLPVWSF53I2maaKJPKdVNoLe0+vJy2o9VTywrlFeRv46CHJFvJf6FiIfiMGILUQH/Xu8FYdJKx8GdEBarxAfLyQbetW0ePSQiN05H4R2AuklLuYqqid7seSfMVzIxlJ4lC8mgSwvWmivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opZWw4qxzgnd3X5YUUOs7jiQntG47+oFw9GL03cAf7Y=;
 b=oBLquHpCEztEIbzPSLZ2L8rBQlQjKdKzd3NmENKlR/X8i7x7VDStHzEyn9BZxFz1jTQC8dpiIySIBZaajfxZ2i1m3kSkkwrURUZ8bEvkON8QfhSnK8tqvry0Vhcy1+w/BLlguH243JdxtB0B2BU2Od3u4gTVsr4N6/UBofgFmLu+KSHmxfyX0v+o78+dmCajE35yaXvWeZmKtEcCNX1C9c1Y5d0hgX0gtzDApntV+V2stUCpH8sP2/j+pD4S3HLCF4zsZ7/1gacyxr1a9uHsd/BMRC6LZ99tZXYiW5X5MwnxM2vISGMFuTw+ZkW7OruwX6KaJ6TAsWRQxnVMh17iuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM3PPF01A5BE19B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f04)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 03:46:23 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8769.021; Mon, 26 May 2025
 03:46:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Topic: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Index: AQHbykJMfKt9Mfha3Ee+klVeu6JiiLPdsMoAgAIQvoCAAPjWAIADj22Q
Date: Mon, 26 May 2025 03:46:22 +0000
Message-ID: <SJ0PR11MB6744E2BA00BBE677B2B49BE99265A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
In-Reply-To: <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM3PPF01A5BE19B:EE_
x-ms-office365-filtering-correlation-id: fe38caf0-c3fe-4b0e-70ae-08dd9c07e222
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?GtvtaRn857ClW6NwQGo2XY4/WVsKTlydZZmlc/xGCk3Av12qUAjN2toiYa2D?=
 =?us-ascii?Q?bBlSAprY03LZefGfUl5J3NUjc6zcpkO6KQgCsPau2am6eszMgusksPKdqL19?=
 =?us-ascii?Q?rlQCd1Td/a5rUQSMKMLO3nk7a2O940YewLceJoFUhDovk9Plokj9XmOJtEiS?=
 =?us-ascii?Q?o6tB4/zT7lo2EqXZAzPzBtPbOR+AB01x/090hI7BaOhBp37TzHEHhP9LYJqd?=
 =?us-ascii?Q?2x2lMaf01y/MoghQPihaCqGROCOmvHrwG4yZkdHrB/Q/TKLomJ81p7AJXKkU?=
 =?us-ascii?Q?dejPPcJVkChwoJ/UgiTz1Rr78HSHNCA9fA4+jbJa4RlD0LYJ1q31BSLK58QD?=
 =?us-ascii?Q?7mYnQ3UYg3w2S4ttt/Yjx9URI5GG0K9WvVH8khKN9MyByWcr74DVnwx+sArU?=
 =?us-ascii?Q?yIkhzGJwRMJgDRTZeDN963Z5nBDdPSXJtEHJEkLO5xZ+22q1PvA3HRP8lOwY?=
 =?us-ascii?Q?x5Ce7Tmw1EfPDFj88z/GrbiN8K0+gWazBHgnAM3+vXdJ+XObe3NjvVbvW38z?=
 =?us-ascii?Q?72fGdE4Keq8QgKXN26VfCdXNeYZKI47TO6e2h/7u0oSakVRKCS+sTd6q+7HX?=
 =?us-ascii?Q?08eNLCH/m2P8wS7AifWjINNA6lVfNR6mF811BNGww5jJ60CcuB9Ld+zXJj7s?=
 =?us-ascii?Q?+q3uKkHROr2042ZRkV1W6aUY9eACaNZ3zzCuiDvybi50s6VQ6n+ddCwmvJIR?=
 =?us-ascii?Q?6xWabsMBCkw2CSQpDk4Mw2S955KhGfQya8aROSJPsKOBUeBvTVIqb9x6JGv2?=
 =?us-ascii?Q?d+MXEj8wIgYcfnJ+RQdlH/JCN9/Lm9tCbzusSlUEH/PHl789nznnVeE9sQyw?=
 =?us-ascii?Q?cGTQv9CVn5BOEacCoyUvbn/+C/O+WVSlcW1A5M/N2aei7yKQvVAEbmeeQYA8?=
 =?us-ascii?Q?6l+e+UnsxVzYlp71rjzCUzg89ZnLyxgpbpfXMCmd/cC6n/vRHnMrDdx2/5Eu?=
 =?us-ascii?Q?cEoHXH9J/hcjoaqjSyPdwT7U0ffPQCoE6H/uvLE4nEYhKUzqwf/8617akZYC?=
 =?us-ascii?Q?ahoD6r+CIlLWajaHYL4S+DiskkRM9MhjyYcdZR06utpFQBDdyiY7eyCozOz6?=
 =?us-ascii?Q?ABmPduH7xdBiDx+CrCn4As4YEYPXU7//onlwBcoG2VNNCNd0LcWvJJGZPmyq?=
 =?us-ascii?Q?8GKEXYQ7QD2eyykr4J4j0RcYWghBUdLeWIzQdlWdI5+OyZBTetJlt+WOrY3k?=
 =?us-ascii?Q?T+amgOlNiCvhbswprOrG43X0kjZJCo+Od+UggFiriweoH3zl42bYU+ZpwhsR?=
 =?us-ascii?Q?ZaB8XCVB8ucRBPs6zcGKWPJhiddoLkBOIXfRGU0SYwc8m6pJUU7DlAcR5b3i?=
 =?us-ascii?Q?BPvntf2zFTDU17Dnqolkb/EnKGARaeeITeGL3Q3/tKXQgPD312mFM9i1hJ70?=
 =?us-ascii?Q?L/M+8DFio5TLTsgizNL6TKM0EdtBdPhCYBFGW/nnoffofh2FA0mMIWrUn+3P?=
 =?us-ascii?Q?CUPKtAdr9YY5HsEH3LSyCAz7outFguoWTxGmHUA67itukoUwIjvGAw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h934Fnt8bD9YZfEVPiDeF/amKLgPDbFyTz+fZ58cUxxkO3pRNSlsWHJLhPKi?=
 =?us-ascii?Q?tfqkdh6H+Lo+/FneCv66DIW220+oFK1wckbR0XonRCDtQ4n7PXie+XE4qqcw?=
 =?us-ascii?Q?aknFxK1+/Ti/Kkrf9qMq9W8CbpaDktArVqBRIC0itUfk39VXeFraAoYaulaC?=
 =?us-ascii?Q?e00P016JlDRu5Wei0OqXw78RRH8ef3BQ4UhKAGnpn4g28CtmI7rqfGEIVCix?=
 =?us-ascii?Q?OcrS+kTbp5a1xtHL/4ZU3JwcpARWSdyCwQNrdL0Q+4TI5HExxcxjvTU0eK6u?=
 =?us-ascii?Q?OQHJq8/Gp+M9Rmz51irSvg0UoPu0FC8JHxpRVekCk+00pHLTYjFOnaETM4cn?=
 =?us-ascii?Q?MKUsz0RX16+6suwzbVwsRS0cdOKgvJcvgMnU4e3q52DlCDWETsmhas4+WnOv?=
 =?us-ascii?Q?cpuSPcw8EA5LEOPgYDWpBRrV9WgXPOh4rVqSy4rwF3WWDK3qUk7mwn83aKSk?=
 =?us-ascii?Q?BIjoIf/8WrU79EvpY/eAXQbWiGz7QUAFK0yL+vR3RKU7l7OLQ1qa+VMN1+Cx?=
 =?us-ascii?Q?6DymZb/+Cz+IYYpYLq4iTKmqA8xqiUzF+ILWn/gvtKhm5bCaHk9JGYIFnDXe?=
 =?us-ascii?Q?EBagk6W2SDei7u5e8lyBPsfCb4tQvqj6UTmf5S9FN5HpGRLCBSKeTGPvgNWF?=
 =?us-ascii?Q?STixAER7KhP8PJQnzwXbjXxuxmx0xMS7POuFi5s4jv0uPOoJ4lzn6JWN3Wxp?=
 =?us-ascii?Q?1djByv5IRUE8ND84Oh+z0ZuxVjx4GpIlFtGXCVtGc3Sini7FWUsjyyaYn9v+?=
 =?us-ascii?Q?0hDnm7vOiD3ZDC3Xf9PkqlH+iPzGPzV9XurJHrXe5zbF6XVYTXxkxznXFjWr?=
 =?us-ascii?Q?ujSz6knGB6nwQXd1nOU1vwAJQ0/15sqOUeOntznk2jefV7lq8YW2/ZLAtQ6S?=
 =?us-ascii?Q?AgH1e1Iqo5w308nzNR9doUCifgsyQN0tfAI4epFpStquXXuAgeCU6upcYtwT?=
 =?us-ascii?Q?44RVvxhL9/S+sXygIcFuwPgKrMh/0t/unlv+eWU+dcww8UnzzK9Imj3BeNuN?=
 =?us-ascii?Q?ZFWygLkb+iYFTw+R7JA4imp6/iHPPOO/U8cLijYtUBe/Oa0JBCJEJ1GrPuGF?=
 =?us-ascii?Q?eI4a4GEBoFnFgyyQ8ytvwh0GRIvRnUfoVKv1yzKxYN9Vl60rHn1aaDP990XH?=
 =?us-ascii?Q?1Md5Yb3/WJ0U9T0MW42TAYX8UA0QaTwsSNu+2968wKonJ5sqsXBi9okMod9f?=
 =?us-ascii?Q?pq1Liauyx9OoB+Ya9SLVhQuboAx4S3REmUNtcot2RKmgzrbTBi1rC7tWMloT?=
 =?us-ascii?Q?AV6hIYm/pWylyisbSNvt6P52Hn0FE4ZtHgA7iLV/OPtN8RtuoTUgMYEIYCnF?=
 =?us-ascii?Q?aPBTyJZtGYq8f8jplbugEiYgDuv3p5WthIT5rRsgm2tRpc2QBEeG2ohc+aCb?=
 =?us-ascii?Q?Wli2kqtzrj1lWst2J5s+OVh4hkWqKi/mor0WsesBXHDSiJywPZ1ltQA/gaF5?=
 =?us-ascii?Q?6TK8qQwzGdad894DSzsPFGYk7xr3+Z9OmhGx1ltEYRC+ACI3gxW2UElLXO64?=
 =?us-ascii?Q?/aympFl0CYfYXLunQFjINWUIFEnJoxw7oA/b3Cic40WTzO8xVEhyQcGLmnSK?=
 =?us-ascii?Q?9lDibiLnL37SmWEB+QvmjOmV5oP9dSkr5J7jruEl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe38caf0-c3fe-4b0e-70ae-08dd9c07e222
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 03:46:22.8568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rn2enUC/8mkjFJPSLsX7hJ9ovgWnHKQZoEzkQGyP+sT7mdGxmWYBd0g2OUPs95LxIUUnbR3byuTVWAlwgqtga0wm7WRCJE0Ux/lgNd8dqdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF01A5BE19B
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table=
 to
...
>> yes based on the current design. when guest GPTT=3D=3DPT, attach device
>> to S2 hwpt, when it goes to S1, then attach it to a S1 hwpt whose
>> parent is the aforementioned S2 hwpt. This S2 hwpt is always there
>> for use.
>
>ARM is doing the same thing. And the exact point "this S2 hwpt is
>always there for use" has been telling me that the device can just
>stay at the S2 address space (system), since the guest kernel will
>take care of the S1 address space (iommu).
>
>Overall, the questions here have been two-fold:
>
>1.Why does VT-d need an internal listener?
>
>  I can see the (only) reason is for the RO mappings.

It's not the only reason. Another reason is we want to support the
case that VFIO device and emulated device under same group,
e.g., they are under a PCIe-to-PCI bridge.

In fact, .get_address_space() returns the AS for the group rather
than device, see pci_device_get_iommu_bus_devfn().

>
>  Yet, Is there anything that we can do to the VFIO listener to
>  bypass these RO mappings?
>
>2.Why not return the system AS all the time when nesting is on?
>  Why switch to the iommu AS when device attaches to S1 HWPT?

The emulated device wants the iommu AS and VFIO device wants
System AS, just curious how you handle this case in your series?

Thanks
Zhenzhong


