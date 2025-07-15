Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC54C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubdE4-0007ny-FJ; Tue, 15 Jul 2025 06:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubdDu-0007dd-Dn; Tue, 15 Jul 2025 06:49:22 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubdDs-0007BX-AO; Tue, 15 Jul 2025 06:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752576560; x=1784112560;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=e0JjzgfWdH8VMQBtN6paO6qdE1ZKhLF7LObcnSObRHs=;
 b=DpADCDEPEFEOhH9Vq9yh07C3zGU0d/FuwyU1yXh1OwLnDDLwuF9eKu6t
 /3Lv8vdnrjwR+dvkTIvMwZRl6mvFft1MZdGz73PXAPEvNAopl6O91o5Zv
 XKf9ItHiTsy9CHuPni1BCJCbNekTO9j5rsf9sv22wETDupOmdokkYNHBA
 s47d6wCr5q5b5FJWgnU/fYl/4Jdh/38ZFWdR8sRzAY8h7j6CyXBWDUuC7
 p+HShQx8S6D+ZRPOlynaM2GgqlpOkGbltMetYEtSwKs8KA8llUMm+7YlY
 BCLwqHmZNgTBPIiV/3dHoqfmd2kot2oRufi+NblTYqCKObByNsVFs0Tva w==;
X-CSE-ConnectionGUID: DQhODGf1S/+IQIttVm9HIg==
X-CSE-MsgGUID: BrgdYwEZR1WWBsfc+G+UYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54763728"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="54763728"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 03:49:15 -0700
X-CSE-ConnectionGUID: XOOHoW/GT06IeOmPQGwCnw==
X-CSE-MsgGUID: LooaxODFSSik6J0k2NV3LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="156996003"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 03:49:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 03:49:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 03:49:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.59)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 03:49:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbZ9Ph+OkOLpOlfR16zKN48sBO3bI/M4T4g5HcgJhLLf7czRKfj0p9Whn06VXsfQVSmqubBbd5f/lCOk4rUS1j3zzq7fsIT3q42qXpx4snhwNBkPo9nfy0SxmsfWStpJtumjopHNKnnzzVrsnFzcAMXCpn0KRimWTEFb8V+KL0ui+1rytGl2Szmublq8lxCB4Lm0SV6I1rEJE3t7KJ1/giYFRKLosWvu2BG6JFxrbcBzWftrnesy8FQQI+q1T1uhK4G2SadGCDlmglczxuu86OilDJgbtQL7GmMAhol0VyVWZNYZKPM8L/M83YvgCPAu0nNDuk24S46aqeqwuKhyiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJnrc7ZQftN2diTnTxMAvosfQeS1/GBYXW6PQyH1qo4=;
 b=DNi730GjYB17JtGQtMdaDwVnQ8Y7Gdr9qRghDC8PmjhckiMSZQuWBH/USXqzbm/IS/PYnEWmFNKhqo8my1LKKsQOcazA/kzkDGu/tdYy3sV0O0qkKQSsIbDzZODc5wk862tz16gRxWnlbntu9BlbE+0NAs7rB+q03qEcYGMcbszcETZbqx5TjXdX+7sXfPl3h1rjE8PZovRSLChPGRiZ3W7u9FmzhR0B62suVJvvmaZSQTqDXn2Sdveg0N1tPPI9y0+u+LMkDRR6ueK/gvwW6ZGreVxC8k6GN5ad61BQNpxOfWSNTUBXQPAq1otLmE0/BItRwmwD027COsYCyIXGmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB6417.namprd11.prod.outlook.com (2603:10b6:208:3ab::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 10:48:31 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Tue, 15 Jul 2025
 10:48:31 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "shameerkolothum@gmail.com"
 <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Thread-Topic: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Thread-Index: AQHb9NiWa9jIv+ZnGEuy/ByzKF9RYrQzAfCg
Date: Tue, 15 Jul 2025 10:48:31 +0000
Message-ID: <IA3PR11MB9136ACFB4721D47304A9885C9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-6-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20250714155941.22176-6-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB6417:EE_
x-ms-office365-filtering-correlation-id: 20addca2-0521-4a2d-f6d7-08ddc38d23ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+svXbzMpL82OMnPIacepONgW7R4rowrYO6RP4LZOReP9nrkwPmA+srrtAHRK?=
 =?us-ascii?Q?IuSkfOGtL5No4dv4SejnmySYj5y6rTxnDRe/WvlHp8CmZDa1VII7F7UpiU6X?=
 =?us-ascii?Q?fxglwKn2WuRB9BUXbqwfgb1KfVXSxQg1GPXLH8sDmlPouSD/cslutCREgCJd?=
 =?us-ascii?Q?BuWGgOwYyYTBXDV+V3L9kuFBVx4e6/EvCu2wLwazyDruzNV1o4K/aiu7Yog/?=
 =?us-ascii?Q?pQoL6SKMsFEBjJSCUlFAxg0FLJsWVxWyWsxhgNdtXqQmtb1mGetVYD0cFA8p?=
 =?us-ascii?Q?LDyYXuajXookK3p2l+p+imgjsFKcNPtwDg3ro8mT1aDyXvX2EeW+ORJdUEsT?=
 =?us-ascii?Q?F3KdAYeqLSRzquHJ3QHii4jpsctpnoj5QHhqgZm35dq45RD7bW34yuCYs1ho?=
 =?us-ascii?Q?Wr7i+b0LeNFO1h0Xo5L39gKAjpnCYY6bD0mcgARj3kQzAX1NCksyLBc49+is?=
 =?us-ascii?Q?/KwX52K6de+puX0AGiYPe6OPIVXfni0BDatZceltCTd9k+GN1ReW0M8pOdq9?=
 =?us-ascii?Q?kByUgyvltJI683bVGAnqRuyAFdVRv71MQ4kxOtIO/v6R6oP9xO8yFVrCvTMz?=
 =?us-ascii?Q?HhM+8i2Qt3sY8jckD+fQFiHKrmmBBGWhRG8dyseMjuck9xug4Z1S7ElgQc81?=
 =?us-ascii?Q?wmzh/l9b2/iFPPP7VXap9OxJtKjfGiO/9yK166wjSjCfJZrm+NnwO9JZdj0z?=
 =?us-ascii?Q?IhwXl6BALIQkSQz6RnSB+78JDE1lBemi72K9Uitqr60nHs2A7Z7b5xYjNP+a?=
 =?us-ascii?Q?75A2Ha8EkW+DOXerAG27Klo8D4EWIuzUnmI0mDSHuoD45U5jx5lPP9uM3E6k?=
 =?us-ascii?Q?AOaDWeSpprdXJM//w05zonejMNCEE74uXnV+qKgEj2lOhOyjhVQ6BryHJ+EY?=
 =?us-ascii?Q?eYViGN7I7khKqvgl4Qg4wWa97v7dmEx0pSy/FLRxVuBPZLs1kBDhLipqgA/v?=
 =?us-ascii?Q?9Et3vptXr74WczGCk87jH/0X992iXMWuA/79byKQ0Zzi6z1goJj4pL7GKohK?=
 =?us-ascii?Q?HubcFKK9e5QnHWYHt2eryFse0VNT2tCD/oL/RTn+BfCBJqrE8SnhM+5CWEvb?=
 =?us-ascii?Q?o3uA3ImL1Kx72tsIk+NV36a4czH7FrtiYSYPWDBdHl/NxMI9iLzHcFX+aqWc?=
 =?us-ascii?Q?/nG0N5jsu+7lzNmFidTMwpTVIGGPvUNSi6FLWAk88OBLklUxMYKkDFfyNAZb?=
 =?us-ascii?Q?qvbEBiR/IQuivUtUx/zxVxpJfRCBFClAKCsA8BgDxSujS2KsDAFkQJQwmTzy?=
 =?us-ascii?Q?geM+34RLYT/wMydCM51U31V3dwwY5BeDhmHyqYkI8oEe1riThsr2liCmTWVb?=
 =?us-ascii?Q?6GgS9pfFqPN0TKzgcb1hJ2Grct5afH+py+r0Y4x3o27jW/EtjoWIR24fZAGc?=
 =?us-ascii?Q?4bm5s302jJ5LKsaaWO0afMHugfPbesoHH1NYNA6fUQ8/mJTzHY3Uh3CNCjlR?=
 =?us-ascii?Q?CueakSsBYaz142TgpMfRe4YaNplym9BhYBHfoQ7hy64JsADWaZ0Wwg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1xhpGedIzHxRi+N1kei/LAijQlqGvEuh/+INcHEROF/wvwtvc2vGOEsvSqbz?=
 =?us-ascii?Q?fN+JLILdfOB/gywEgDqNeu9xtG26trM430T+tJ7OBg4pe0IuVj0Bmk5wf2Xv?=
 =?us-ascii?Q?itI+APjCbPqA8C0rDFqEOvH04keGcYPi5zPqAi2oSKpv9tsGkELnJVlp4nwN?=
 =?us-ascii?Q?RtyCToD/AtRqHAjpkQhhgToQQ72fnUWAdK1uYiHuwjxkrpU2DKmhZFLr1zuf?=
 =?us-ascii?Q?7IE2euw+iPygW2Xs90z7iOynBhmmqupM1ZZuO5belq9INSAFzqOrNHdHEjYh?=
 =?us-ascii?Q?xdMMFs8pwvXSEpHXU/3QUBmOvjL3Wk7wZP2tfTUuAPQT0H3jRR4QWvqvRrkt?=
 =?us-ascii?Q?nlMqFK1vIoR4I9tZN1T0ToghJjpHwwrEpSCfNseUk/hMzAPzcWxcwjgFvjOj?=
 =?us-ascii?Q?VEuTnJeejajdYfrNFKvKafpULjmjIi+wGROeUmQYn4c7gK2MEhPdK1e8tjuW?=
 =?us-ascii?Q?YWvWusS9LBYuOjk5RspbcmCeY1Z8fbO1Raqo3KspR9w0ar73STIrjHY1Y0Ew?=
 =?us-ascii?Q?56sJxhd8hUuWFxe9i2lstdFGt6m0SO//I/cjrAruc42I7bcQAYG29Hzz1uTs?=
 =?us-ascii?Q?hJvRd+hbC41JlEiN2fdcvtkxhSxeH+hF+bp0K0QD5+cwYm3UlEuhwk7msPmm?=
 =?us-ascii?Q?bx2PazRvg/aKvPNPcnOz8sd7KbymscDrB5RmUMj9NX0PAIHMi+cyMDjUKsYR?=
 =?us-ascii?Q?54VMxJKD18eKNE4Hsvke9gWAE3wxYuqVuXNLXmcDMM80CtCoZf+50cgUFmNu?=
 =?us-ascii?Q?czfEa08E9XlABK0OkAJbgiQdWkvkfNSHQb0l4yGWSF83TsNkiOWN0IMfF/8m?=
 =?us-ascii?Q?n1iRjU3jVk0b9ceskV5aGg3qeTSvq1zsuiIpQ/ROLCarGrmMUcSKjOvaBMXq?=
 =?us-ascii?Q?f0owbLkG+bs2oRWUHh7AweL9AuutXYSS1KzxVHsN+QER1Z0Q0IHFDnsCIJz3?=
 =?us-ascii?Q?1eGZF1xrBBcQdUNvm8GGccD6UoTtJDfMHbLrRcwdgdEPVDvfXZIWgZu1pjec?=
 =?us-ascii?Q?veUU1i0UW3ml1sK2wQJsYmt8OjnAQh1JwztGFgy/+xaqsXbbXBzE/R2+mbIR?=
 =?us-ascii?Q?/ifbbRDIO5DcLG6pFxa+zlRofmowBjWKRUb4v7U6fN32r/82aBiNua8lHyas?=
 =?us-ascii?Q?YvzB9iWmO62fdfFCqnUj4ojdcvFF426AIsa8t9W1WbDA+RytZzrphi5YJyJm?=
 =?us-ascii?Q?MgO1ImxKR0AUnDEWu6oU9P7Jki5TOq5tHLPBncyyYs/zn8DNluiBCZwFGgEg?=
 =?us-ascii?Q?+xxVExOvVGkq7xYWZ9j2XZoLJK7ti+dY4+1wgUqjL0jOdNbV87p/W7fNdIYe?=
 =?us-ascii?Q?oL0mANFOEBRFe3Yqe7k6Ucm4MZl44Oq547UtKQg7HIbW4ElYLrpnXY0G/cOA?=
 =?us-ascii?Q?3lC+Kukbr8BJRXzDYVlgUee6MVAStbJh1WXhqG2PHSJn2Qq9k5VLAS9vQP3X?=
 =?us-ascii?Q?jA3CHugXeAnF1z3c5qog0guQ+Bjc89MeST8q2LNxD5UqnoEWpSdcd5xB9tpf?=
 =?us-ascii?Q?dPwEzQHc9tyjmo6UI/RJGxy/QWESjFFCj5YlOWJUrS7EvqRV4B+tAzugZsbr?=
 =?us-ascii?Q?no7/AZKxC8D5aIe36M9UH1CSOdTFCBF3Oy95GaXv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20addca2-0521-4a2d-f6d7-08ddc38d23ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 10:48:31.6569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qm68JdC/ip0YozGRG6xbzDLV58UO1UiVudeFUlaiY1nRodNrQuWiX69vWcyLKDRgpZm3xibFqZ6s8cJFN7FketsUw11HFURWtTFPOjcMl5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6417
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
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



>-----Original Message-----
>From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>Subject: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3
>accel device
>
>Also setup specific PCIIOMMUOps for accel SMMUv3 as accel
>SMMUv3 will have different handling for those ops callbacks
>in subsequent patches.
>
>The "accel" property is not yet added, so users cannot set it at this
>point. It will be introduced in a subsequent patch once the necessary
>support is in place.
>
>Signed-off-by: Shameer Kolothum
><shameerali.kolothum.thodi@huawei.com>
>---
> hw/arm/meson.build           |  3 +-
> hw/arm/smmu-common.c         |  6 +++-
> hw/arm/smmuv3-accel.c        | 66
>++++++++++++++++++++++++++++++++++++
> hw/arm/smmuv3-accel.h        | 19 +++++++++++
> include/hw/arm/smmu-common.h |  3 ++
> 5 files changed, 95 insertions(+), 2 deletions(-)
> create mode 100644 hw/arm/smmuv3-accel.c
> create mode 100644 hw/arm/smmuv3-accel.h
>
>diff --git a/hw/arm/meson.build b/hw/arm/meson.build
>index dc68391305..6126eb1b64 100644
>--- a/hw/arm/meson.build
>+++ b/hw/arm/meson.build
>@@ -61,7 +61,8 @@ arm_common_ss.add(when: 'CONFIG_ARMSSE', if_true:
>files('armsse.c'))
> arm_common_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c',
>'mcimx7d-sabre.c'))
> arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP', if_true:
>files('fsl-imx8mp.c'))
> arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true:
>files('imx8mp-evk.c'))
>-arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true:
>files('smmuv3.c'))
>+arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
>+arm_ss.add(when: ['CONFIG_ARM_SMMUV3', 'CONFIG_IOMMUFD'], if_true:
>files('smmuv3-accel.c'))
> arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true:
>files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
> arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true:
>files('nrf51_soc.c'))
> arm_ss.add(when: 'CONFIG_XEN', if_true: files(
>diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>index 3a1080773a..6a58f574d3 100644
>--- a/hw/arm/smmu-common.c
>+++ b/hw/arm/smmu-common.c
>@@ -938,7 +938,11 @@ static const PCIIOMMUOps
>*smmu_iommu_ops_by_type(SMMUState *s)
> {
>     SMMUBaseClass *sbc;
>
>-    sbc =3D ARM_SMMU_CLASS(object_class_by_name(TYPE_ARM_SMMU));
>+    if (s->accel) {
>+        sbc =3D
>ARM_SMMU_CLASS(object_class_by_name(TYPE_ARM_SMMUV3_ACCEL));
>+    } else {
>+        sbc =3D
>ARM_SMMU_CLASS(object_class_by_name(TYPE_ARM_SMMU));
>+    }
>     assert(sbc->iommu_ops);
>
>     return sbc->iommu_ops;
>diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>new file mode 100644
>index 0000000000..2eac9c6ff4
>--- /dev/null
>+++ b/hw/arm/smmuv3-accel.c
>@@ -0,0 +1,66 @@
>+/*
>+ * Copyright (c) 2025 Huawei Technologies R & D (UK) Ltd
>+ * Copyright (C) 2025 NVIDIA
>+ * Written by Nicolin Chen, Shameer Kolothum
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later
>+ */
>+
>+#include "qemu/osdep.h"
>+
>+#include "hw/arm/smmuv3.h"
>+#include "smmuv3-accel.h"
>+
>+static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs,
>SMMUPciBus *sbus,
>+                                                PCIBus *bus, int
>devfn)
>+{
>+    SMMUDevice *sdev =3D sbus->pbdev[devfn];
>+    SMMUv3AccelDevice *accel_dev;
>+
>+    if (sdev) {
>+        accel_dev =3D container_of(sdev, SMMUv3AccelDevice, sdev);
>+    } else {
>+        accel_dev =3D g_new0(SMMUv3AccelDevice, 1);
>+        sdev =3D &accel_dev->sdev;
>+
>+        sbus->pbdev[devfn] =3D sdev;
>+        smmu_init_sdev(bs, sdev, bus, devfn);
>+    }
>+
>+    return accel_dev;
>+}
>+
>+static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void
>*opaque,
>+                                              int devfn)
>+{
>+    SMMUState *bs =3D opaque;
>+    SMMUPciBus *sbus;
>+    SMMUv3AccelDevice *accel_dev;
>+    SMMUDevice *sdev;
>+
>+    sbus =3D smmu_get_sbus(bs, bus);
>+    accel_dev =3D smmuv3_accel_get_dev(bs, sbus, bus, devfn);
>+    sdev =3D &accel_dev->sdev;
>+
>+    return &sdev->as;
>+}
>+
>+static const PCIIOMMUOps smmuv3_accel_ops =3D {
>+    .get_address_space =3D smmuv3_accel_find_add_as,
>+};
>+
>+static void smmuv3_accel_class_init(ObjectClass *oc, const void *data)
>+{
>+    SMMUBaseClass *sbc =3D ARM_SMMU_CLASS(oc);
>+
>+    sbc->iommu_ops =3D &smmuv3_accel_ops;
>+}
>+
>+static const TypeInfo types[] =3D {
>+    {
>+        .name =3D TYPE_ARM_SMMUV3_ACCEL,
>+        .parent =3D TYPE_ARM_SMMUV3,
>+        .class_init =3D smmuv3_accel_class_init,
>+    }

In cover-letter, I see "-device arm-smmuv3", so where is above accel device
created so we could use smmuv3_accel_ops?


