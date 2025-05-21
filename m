Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEFEC54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 02:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHZVc-0008RZ-6x; Tue, 20 May 2025 22:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHZVZ-0008Qt-EH
 for qemu-devel@nongnu.org; Tue, 20 May 2025 22:48:41 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHZVX-0002U0-IK
 for qemu-devel@nongnu.org; Tue, 20 May 2025 22:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747795719; x=1779331719;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=70jqFeE9DBKx3v6bMvoewQJrcDZiIRphwXMiOV6BKps=;
 b=DzFxJ7RKIxQWrrpFSXIvIchxyZtiD9S8w3Kj9wMbghnUZ9vP3lvV/WaA
 PKht/Ur29W8B28MdBC04zcMr6EZMEBu3/VokC4nu3vKRw1Y7mhowfU/Ci
 +oQpHAdfbSn7gq3lutpR0bwwrN5Xa/uWVwpyOvlJW0aVNyZEuKF1+LtMt
 snXGJdynW892aL+e7ptNvWGpq9MRHaGj+ey5thFWNYN3kLd+kmS1O+mE9
 RDAGlFBR/cllw8/uGWUDz4WMyeV6mGCwgTdGDWcFtUvTBMftCTLQNBNN6
 n04Lsp72ucwEkzNhDho3PuKEYHuXX1Fk3T8KU8JXu1XDw3EYz1qGN48Jq g==;
X-CSE-ConnectionGUID: A24eiMGuRlqoYkPRuNKTaQ==
X-CSE-MsgGUID: LJ5iT90yTU24JGk49odzTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49656649"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49656649"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 19:48:38 -0700
X-CSE-ConnectionGUID: BvNrneBEQNaIwdJzFYqF6A==
X-CSE-MsgGUID: 2Uz8Ctj2TJe63Bnpt8sslw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="145028038"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 19:48:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 19:48:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 19:48:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 19:48:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfDwRuKOGUr1kJyd8gjlUwcLPXI9LInKKGt5mb6AQdgW9poUTX+iXoCUTrYPqb+WqJRtH2sZiK5cr7tJCgSpTulNnN7salFcCFsLse1n43/qFDxAgSe3gCJYsnXeEkMqNODIiPo+JZ/aBF00cBhzESjy+7c63TJQUKSWEc3DmUT8nRH41/zR/SYyIiZv8F3s6NTgayz8SHg10Ry+Y+3xLckdBtJGnNsPGT9Z5tK7hnppnXmc0GmSbkgKGtRTO/s1a4dtI8StnXWSxw+qpfj1ZlX9fyM+NPtWKefltfsszxj9k7Rb/kpVh9Txq82rSv74X4K0Y5AwyUha8ls/zMMtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70jqFeE9DBKx3v6bMvoewQJrcDZiIRphwXMiOV6BKps=;
 b=IeaY8cHMMx+rtAu6dLYr6qwUPORShLmR1NvUI6cwjNE6Rzt9/PMDMuESonsyGBApfuvT8chRlXbbBNKTib/YP75xPjwDEOlgS0ylF9CQJJ6IJkYmuOkA/seuBZj2l5NGUYmzHAq1+h0afdoTqQ1xavlMgS1FpKsppebLATw8GqMXtv1S0p/xfyQsm2jHnPZDnFvZZZsVxowWTm2y70dAbDG/5uy3B1QYrr2bn0fMq/JyWPL7YhjxH6cPRMfWtBNwwVjdU746N8dArtx+Iy65xAGq/Fyez1CqH++hVkCw9GAvsHD2uOLApiKfh2R0kUGkMdkNZmVCTVzXY4VNl5WKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW5PR11MB5929.namprd11.prod.outlook.com (2603:10b6:303:194::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 02:48:32 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 02:48:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 28/42] backends/iommufd: iommufd_backend_map_file_dma
Thread-Topic: [PATCH V3 28/42] backends/iommufd: iommufd_backend_map_file_dma
Thread-Index: AQHbw17TGeUM/AlJvEajt07i15f4jbPU8WQAgAUzr4CAAc/3gIAAb5OQ
Date: Wed, 21 May 2025 02:48:32 +0000
Message-ID: <SJ0PR11MB6744806B14209B1CC4007A2F929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-29-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744903C16544B81D8317DDF9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c0a4593c-dbfe-4e9e-a90f-d173b388e34b@oracle.com>
 <5abeb08c-3cce-415b-a90d-6659fb0e53c4@oracle.com>
In-Reply-To: <5abeb08c-3cce-415b-a90d-6659fb0e53c4@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW5PR11MB5929:EE_
x-ms-office365-filtering-correlation-id: 40cc19f9-3098-48d8-ae69-08dd9811f9c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?y3VJF2BS25ZX6034g7461C0C6HU5lB5/Eq2r7tboHyDkGIA0DP0VZsRfUW?=
 =?iso-8859-1?Q?nIPhK9/fSOAQPs2nUdeb/tUbu3eWys0nVfZOpXH0sEOZJLIu8RCbgME8x+?=
 =?iso-8859-1?Q?qfezIZ3AO4l8ZiwsAKcxDGDFykW4RBONxsxC26XdOrjckbGL6ypGrPFsiO?=
 =?iso-8859-1?Q?vKNmskBkZz9wYjEjuNnavglpBaCNQ68kxodP9c6JiJ5f6LNiUhrrAytdXF?=
 =?iso-8859-1?Q?hHZRRHDGo9jesp7OM14kz8yGLbgcMzDXB9a43hAKFyMfPxefIRb2d20NTl?=
 =?iso-8859-1?Q?M1otQsJR2KuoBioIwMQ+0oiwtGcZbR4YZvPajTK1RvlftEp8Bw7SUTCUOZ?=
 =?iso-8859-1?Q?C9kIg3cch+B6i09+Y6lluO5r4Tz9hksorYIsEx8bOp2EphWAUseuSs8o0C?=
 =?iso-8859-1?Q?9ykR80HZDWbq6sXZZsSMz7u9nLNYAnX7bLzh2Tk0pX8mpRQ7eWBD2g0jI3?=
 =?iso-8859-1?Q?QL8PxHJZTtJ11yJuByAKQyK7sL0F8q14AqUUabfu9t0yk4pp+8N+Ug0OgE?=
 =?iso-8859-1?Q?SzqBtHJpip26fTRJah0iB6CbYOPPyR/wHm1IBkvcyOsRMjFOR87ma9Wl/n?=
 =?iso-8859-1?Q?1aoGWBHHLDaD2cRX4oL73f81DBE68dr1yVcTs27zQ3l+Y7v1wvM4asndI2?=
 =?iso-8859-1?Q?dBvBbdysg6c2RuaPitXNKPIaAy7na+vIs/zpzPtBuZ1bSZddu9FVS5tKY5?=
 =?iso-8859-1?Q?TDtXvwk7JiAxN6VTfFjKcogjGM2rbIbnXfLUF2C0HmMI1pfrdfYZwjmho1?=
 =?iso-8859-1?Q?FV9f2jDcaPLilPa64MFMzxj/ART0zRsRwlWgPBCcU8/c1+SVDev0ufn21r?=
 =?iso-8859-1?Q?lEI5CEKNT5GOA9HXleyYiB1vdrWklmyEG3WLJto2/HnGkxvE+n6zCKwuWp?=
 =?iso-8859-1?Q?QeaMYe5J6l7O787zO6MSlxfFF/Xsh5l8skjV1ixu9j8rku/aJ0hSjHhsxG?=
 =?iso-8859-1?Q?u9Tey7zGkc6jpzDn2M98ZgSq1ouJ2M1PykUe8i1U0LSjoTel/aOumiuOCp?=
 =?iso-8859-1?Q?unxYn8m+XH/LVa1FPk8yKTGzZGqFFuc0KA/KAtVt52TUYS2paria+Xtyc6?=
 =?iso-8859-1?Q?zGckTLTSzyhdiTUmcze0SAierlI+H8W6D0KR/shjYtZ29cjW88W6S6ScZ4?=
 =?iso-8859-1?Q?NNQxjqZQWo/DXlNcDPNJk7OmxsMeq82g8ovis0cOrXJkN1Di/hfCdtOhbw?=
 =?iso-8859-1?Q?SM9PptOYTCXNLgfDzKk5TOc+B6gC8rsf0WHLWzV2gJGAXdqseMtrI74hlo?=
 =?iso-8859-1?Q?3ClhhL7RLaQDVev65fBMJXjSomKe0tOrE5LnS767wqPtPG3c6l1XvMKVos?=
 =?iso-8859-1?Q?12enRTiT97V5L8bCNH9nevPuFPGr8SZL8je/fdjl1Rzbpyo/5t96ZV2MAn?=
 =?iso-8859-1?Q?0HCvK3j1WmkbIRGPWhrR4Y2FUi6gX4rgFzxzv1zh2mOURWh7YHAHZ0v6oK?=
 =?iso-8859-1?Q?puVX0IfXUnWTTpzpSfxCeGdgL6cE7XFPjaIQuHidtn3HLww6c7iSv3rhY2?=
 =?iso-8859-1?Q?a34uPxBQ92JcbrBpuvjE1NL2JjtE+Yd0X6/g1/29o3nQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RhQr+8s3TYEe964xs8/u/L+rpI+h/BSiyj0UWAO0ZK5cnz3SGRCmvG6kx/?=
 =?iso-8859-1?Q?mZMup59PXovbE/6zAvuH+mOvC/BFK8d05LrPxlU+fmN6qd2D030MK8Vxz7?=
 =?iso-8859-1?Q?wN2uUa9CsrQTPx1jzwOTF7opXQwo8zXKDSrS73+fteaNUVG1FFZ2RBy1Te?=
 =?iso-8859-1?Q?D/X3fDeufJJV2X62vOBde1KimVLSbPDjEgtUjoODkyBKLFKHotZor+Fdea?=
 =?iso-8859-1?Q?ROOiV/331pLxDszcKlrU+3NiQC4108Cg5CQwIbZu2xw3WY3xAyy2ea77sx?=
 =?iso-8859-1?Q?VsPcmHHc9oWU+ozOMGXG8cdRf8s3omet5jjr/d1pWZr4zTdMzww0hgmyIY?=
 =?iso-8859-1?Q?h9hr70x5giuahgrust8C056dlWM+hwTdVMVIdd3vMWuFLsD07d6DLILu6w?=
 =?iso-8859-1?Q?RN3piyQvAB4x4biYU48nKfQRhUje2zbUa4p7dxBnAVMFOZbxW7lhTxo5B5?=
 =?iso-8859-1?Q?6Ph72jePhaeAv/Aw15mafI8TNPXJL4KyQTW2COTsRhYIQZXSFK4Tco0atM?=
 =?iso-8859-1?Q?Q5be7o1YqfaMsU5QFIpHWU2sQs5aPKsCr2t41NiehlHPHzRptGuNVm1Cek?=
 =?iso-8859-1?Q?SNZHArdc65hln5VVeLnLKN1Tke/pV280UHcPFdx8N8STKrhBcDYob1lHVz?=
 =?iso-8859-1?Q?svSiCn3p2T3Cp7X0h2vsaQDhqRx7iVXx58DjclUP1suGkKF+Q277+8pLsS?=
 =?iso-8859-1?Q?cwm3x73hTrdZ4GDTXyu4rKBGBkIMoMHJYpImGm6jDH1KpCRJ3XtQtE0sqp?=
 =?iso-8859-1?Q?fEgIqZZ64EIA/mRpCcge0Nu8iEKfF/Z5V6QZg5BGyZKl2PTOIn9I2rkkpt?=
 =?iso-8859-1?Q?ecBdLM7CAnkz5zAW6eVzWeqy7F6VA8PAjMK05ES684u20UKJXWpv+eB4uB?=
 =?iso-8859-1?Q?ST8Wt+kZvUvu5GhbSrntPpTfPdqCyvjjQVyqa8F9C4X4DuxfIxOJe0eGRD?=
 =?iso-8859-1?Q?wkR4trsfNGmhC+dFgbekU1RPi2FL5GClWBPR0vnoPzwaKGALcfNmh7DJit?=
 =?iso-8859-1?Q?3n/HgKrL4oAm/n57faz7e9mB4ONpWgH63LAAkM9uztSCxGugrjXsxcm7Yq?=
 =?iso-8859-1?Q?Hsjr71AHR9hRHCStvT52DCIV1YRkJlyePyG+YgTJhRrQXsaklJUIziAr/z?=
 =?iso-8859-1?Q?OrND/dOtRGOiQbBEjhtcJ3Dxz9YHJrLqOTCijBmM5UuVSm2HpL9qRjX3ma?=
 =?iso-8859-1?Q?DCeDWucHRUep5oxV2Phje5Dir7N36hfDR/PHqmGV5dZ8cbMuwQEWjj3ppa?=
 =?iso-8859-1?Q?dYtDiPTj3cifEpICWzKQlgWs6jnW9lew50g4umuKz0AY/X+4cY6OTVzGq4?=
 =?iso-8859-1?Q?jIQYtZhFxyVm8NRyV7Ng01Kv2bMc3BgrIFRP7dMfD+p7Xq7V5+bIBJulLw?=
 =?iso-8859-1?Q?54YB0sbCTLV43k7sRzDpSH6ecR9eP1oZvl3oMauvRl/yKjtN/9WWd04ff4?=
 =?iso-8859-1?Q?sMHMGMoBGhxNdoUIYg1tlars0y4qYgOjAyUOTvlxSh5qhQzHQmCYE0H4zo?=
 =?iso-8859-1?Q?r/2GrERf383V8yFVhHc9oXtI4HG1Q6EXpgglgpgBwDVPBlyBh6JYPhhtiS?=
 =?iso-8859-1?Q?85RMaA1N9gfvMVnLK/VwZrw44Qt6IjX2hWkml6xgrUWoxWEZVbCaOTyFwM?=
 =?iso-8859-1?Q?5GOQIYv4Wk226m81GsPcOwbkNzGdpJSUT7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cc19f9-3098-48d8-ae69-08dd9811f9c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 02:48:32.8502 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bdBbZDCQORxEFsu+vQigCe/5RxcT6C4xdnD6YEI/mKoXX8432jaVEFCsf5NAzV3+7ZmvGa0xKao91VMiYCtcPrudiFVZiR1HgYSeP67VOhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5929
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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
>From: Steven Sistare <steven.sistare@oracle.com>
>Subject: Re: [PATCH V3 28/42] backends/iommufd:
>iommufd_backend_map_file_dma
>
>On 5/19/2025 11:51 AM, Steven Sistare wrote:
>> On 5/16/2025 4:26 AM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>> Subject: [PATCH V3 28/42] backends/iommufd:
>>>> iommufd_backend_map_file_dma
>>>>
>>>> Define iommufd_backend_map_file_dma to implement
>IOMMU_IOAS_MAP_FILE.
>>>> This will be called as a substitute for iommufd_backend_map_dma, so
>>>> the error conditions for BARs are copied as-is from that function.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>> backends/iommufd.c=A0=A0=A0=A0=A0=A0 | 36 ++++++++++++++++++++++++++++=
++++++++
>>>> backends/trace-events=A0=A0=A0 |=A0 1 +
>>>> include/system/iommufd.h |=A0 3 +++
>>>> 3 files changed, 40 insertions(+)
>>>>
>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>> index b73f75c..5c1958f 100644
>>>> --- a/backends/iommufd.c
>>>> +++ b/backends/iommufd.c
>>>> @@ -172,6 +172,42 @@ int
>iommufd_backend_map_dma(IOMMUFDBackend
>>>> *be, uint32_t ioas_id, hwaddr iova,
>>>> =A0=A0=A0=A0 return ret;
>>>> }
>>>>
>>>> +int iommufd_backend_map_file_dma(IOMMUFDBackend *be, uint32_t
>ioas_id,
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 hwaddr iova, ram_addr_t size,
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 int mfd, unsigned long start, bool readonly)
>>>> +{
>>>> +=A0=A0=A0 int ret, fd =3D be->fd;
>>>> +=A0=A0=A0 struct iommu_ioas_map_file map =3D {
>>>> +=A0=A0=A0=A0=A0=A0=A0 .size =3D sizeof(map),
>>>> +=A0=A0=A0=A0=A0=A0=A0 .flags =3D IOMMU_IOAS_MAP_READABLE |
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IOMMU_IOAS_MAP_FIXED=
_IOVA,
>>>> +=A0=A0=A0=A0=A0=A0=A0 .ioas_id =3D ioas_id,
>>>> +=A0=A0=A0=A0=A0=A0=A0 .fd =3D mfd,
>>>> +=A0=A0=A0=A0=A0=A0=A0 .start =3D start,
>>>> +=A0=A0=A0=A0=A0=A0=A0 .iova =3D iova,
>>>> +=A0=A0=A0=A0=A0=A0=A0 .length =3D size,
>>>> +=A0=A0=A0 };
>>>> +
>>>> +=A0=A0=A0 if (!readonly) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 map.flags |=3D IOMMU_IOAS_MAP_WRITEABLE;
>>>> +=A0=A0=A0 }
>>>> +
>>>> +=A0=A0=A0 ret =3D ioctl(fd, IOMMU_IOAS_MAP_FILE, &map);
>>>> +=A0=A0=A0 trace_iommufd_backend_map_file_dma(fd, ioas_id, iova, size,=
 mfd, start,
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 readonly, ret);
>>>> +=A0=A0=A0 if (ret) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 ret =3D -errno;
>>>> +
>>>> +=A0=A0=A0=A0=A0=A0=A0 /* TODO: Not support mapping hardware PCI BAR r=
egion for now. */
>>>> +=A0=A0=A0=A0=A0=A0=A0 if (errno =3D=3D EFAULT) {
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 warn_report("IOMMU_IOAS_MAP_FILE fa=
iled: %m, PCI BAR?");
>>>> +=A0=A0=A0=A0=A0=A0=A0 } else {
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 error_report("IOMMU_IOAS_MAP_FILE f=
ailed: %m");
>>>
>>> No need to print error here as caller does the same thing.
>>
>> OK.=A0 I was copying iommufd_backend_map_dma, but I see it has recently
>> dropped the error_report.
>
>If I delete the error_report line, can I add your RB?

Sure.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

