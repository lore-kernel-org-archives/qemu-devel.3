Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9E7C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 06:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVmAr-0000pY-B4; Mon, 22 Jul 2024 02:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVmAk-0000oi-I0
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:05:24 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVmAg-0004aO-NZ
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 02:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721628319; x=1753164319;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=luybQjK6hAu3F7bU1IAv70uvRG6W8juFxqD4VL9Hk4w=;
 b=luJLgt3GnuA+fXlV6at/z9/5YFLX2YEYTY8zvDCz2OTxJRvkclhQZu//
 0JJGA3g3xs6UaEtXdW/zMiJcwVnLRzqQ3DK8XDLtkwNDiIA1mI1lsuMw1
 n5KQjJy0TfpHWbfLWyuNzWyfjHUVY+a/wXnsY9tIPIe31yB5MWukr72WU
 1wbgZfOB7ckMN23vZEti08J/tJTce1Q6NPYn2kZIHSO6jw/kR1bSM+gHs
 MGwoT2r/cX5Qq+mcFW0JzdGgaZzaWjruexduElFUUxiWEPDLF7lAH43bV
 YloPfEEoTd0azW144nOQEGiqBoKKzBC02fjWrr46KZzzzQrAY56Ybvvqg w==;
X-CSE-ConnectionGUID: kF4Fr1jkTyKHLLhriAjc1A==
X-CSE-MsgGUID: atZsOkdYTWSfn+qSvshHJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="19139348"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="19139348"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2024 23:05:16 -0700
X-CSE-ConnectionGUID: sKvfATZNSwqujspL3okpgQ==
X-CSE-MsgGUID: VTX3uSxDR8e0jaCyizJHgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="82792346"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jul 2024 23:05:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 23:05:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 21 Jul 2024 23:05:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 21 Jul 2024 23:05:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpYaNsPw9tdVosClb8Gb1yoWU/PU9bI9Dyn0lAq49ZMttCPxNVRuYKg4s0FaPc4kbrmdR1dLHFSdBeuCPDToVJgOQwj+IzdbWQdGQ3iLHgGPevSI7H+pGqKJbDSQKmuMbEaCkpO675BXtNxHfZzHzBsHwMD4SFxWeN443tsO4VSb43xln6o4/xC/lnUG/2gjDsL6CuwJzXoHV6TxymksvIgixS9c8pfUbIBxBQwl3lb0/MQXymhXAnmbMh66Vmfo2pUVbonj2ekyORaSqzdjiJ9ZTmsWqKI+pVnwv+Tp07uOJhcXJLdFdb5S3uANS3hEDJJyolAEFjhCURxvS6o4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbpyL5c9RwRuE37r/VTdjvsf5pEOrsDA5Mj345m3Q6Q=;
 b=Kmm5Uri0dBPJsMO3zbCLj3OolLXJv11MnekThskMiVM4zVkhpQggIteVlXMybnxKcHacp3PY6S+7+uPqUbnQPGxFYXK5a2uh2VYNHVf6l+OaEt10fFNLh/Ys9KdTgJ5zDbF8TUrGhSFVuMnkRwwmTYGl70oaeN+Av3KaseMc7MP2VEIadsQWe2jVTqX5+p6OKeqoEbuqvXwfkRQDldUTCFqGNqlnDIg+hoGpiZWm1Nj0vkp1gIp3l78i7dg7tHtfFvugU9BjKHueezrsrB4GK/CY/qSwSXxKU0iK9RTrlh8LXvwpcPwaxVovcr4KC/cdJJVwYa9hYKahtbbCWdPa5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB7668.namprd11.prod.outlook.com (2603:10b6:806:341::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 06:05:12 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 06:05:12 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v5 09/13] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
Thread-Topic: [PATCH v5 09/13] vfio/iommufd: Probe and request hwpt dirty
 tracking capability
Thread-Index: AQHa2dTA3KmeNYPbQE2nM4EhLBdlNrICRLsQ
Date: Mon, 22 Jul 2024 06:05:12 +0000
Message-ID: <SJ0PR11MB67446F1658661C5F1542D00C92A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-10-joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-10-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB7668:EE_
x-ms-office365-filtering-correlation-id: a19845ae-5a73-47c1-5a48-08dcaa143fd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tpH9K0HeT8h3OmwRtECW2ZVgQwvT5Q6jMh2Ud9wI4sEx672BNeuuG9oGHNwN?=
 =?us-ascii?Q?wrXr+kbUF1VAFy/YGq/9JA9YNt1EFQtF73xAmEtfrj2KmH/AokjBwauyrIqE?=
 =?us-ascii?Q?EgMldoEbmUhSFFpEsoKgYyNe4ofc8J1VMT4553IBqc84C68mCTfof09O+zIN?=
 =?us-ascii?Q?Er3hhwkFiAVoyuuR7ED8sfOaExUUlBxVmhE4AudwNdvkhgsrntClBrK2RgYL?=
 =?us-ascii?Q?/qoSWeh/jEh8NkqpNYrcNlBjpz400Sm+MQ3ZxLKG972qenaKAEACAWdCQJiy?=
 =?us-ascii?Q?Z8Di0jDI/y0wsPYLZs1O6pl+Jvu4nsMzwhCq5yqD4k5INLdtcqcNxHz99biq?=
 =?us-ascii?Q?os37lXSh/pabL1OoF/2qOb5JUoe0Kk4BChdPJjVPlF4Y5A9Qv8wQ2oG53LHC?=
 =?us-ascii?Q?H5Lnij8lf6HBVrSsoYT68pYcLr8brA9l7Xxp3kPe8UmWl0sIyYWTrBYuSL1M?=
 =?us-ascii?Q?vFqtEy/AfcshntOakezD2J9FGrwXHrymz10i8hZ5YIjRXcWl878yRg3+O4JL?=
 =?us-ascii?Q?n+BBPRNlT0zNIc4DrkvRsGAVH+9v8Ubd5Idxy+YzrgRBTDPxynZQkl86N54N?=
 =?us-ascii?Q?qOVeW/Sukqd9D5em9pYEQjZWy/ZQoUxK6i1Kgx7HJWnG4LrmDQsnbvRVURD2?=
 =?us-ascii?Q?qlP0dzRh9Hivf0rRLx0xkpllpWP1UsDqAQx7KFonuHXttuzAtKNmjW9p3YI8?=
 =?us-ascii?Q?Wb+cyy4fnhN0LPGZC6xJP8uVFYDqbKwCw6L7nSLDxsWM3Y8e3tm4Fjb+xVr9?=
 =?us-ascii?Q?VCQncnN4pccFpjm9tbRp0xD21M3nBiXY04pCF0Im5HLMNTEFv39+RMb2EG9Z?=
 =?us-ascii?Q?cGfeWVcnvaWhLwlOykaL9kzvc+4GYs7lLVIAO/dk0dcYboNhGb+tfebMX/0M?=
 =?us-ascii?Q?mHUzKhMMgCfN/C1MYLgx8sncnTDSl+JJPoaO7tDnJoGbAu3t5r3zx7VfM/qD?=
 =?us-ascii?Q?r4zLAghbjNZEoaxKwRAYhYn6dz2Vnv44ezO89g0IGspAQ2f7ZwFpnLxQwVMk?=
 =?us-ascii?Q?Rvo+2rpYEDNQi9pMXuxnu3kw+uyTFo+IxJik+QbYAhlzq3l1T1f/r94Qs4OB?=
 =?us-ascii?Q?zFaFX70PYhndlBA09eL9WJVMDAMRttkxXYSJ49ro7bVCnGtHHXdJhRuzdBVC?=
 =?us-ascii?Q?gvPBtKF30pBaeHkmxD7PUpQBKHnPMc1sUAqJVjZNl4oNmUqwfJ70zysii/cc?=
 =?us-ascii?Q?aGrk3HdH7RjFaGEvn3LFmvIwGS063EkBieCg5JnelfjtPbSn6uOOHCiKgiFD?=
 =?us-ascii?Q?gQz1g1uCU06YQoHTSXYcMej5l93s7DucHrr/YuLT4iuFEWdKnhkn6V0rnge5?=
 =?us-ascii?Q?BT5ufhQFmojfPXYkQjKwAaRS2I+6XNbDq8RzjQdbkhf/ZhYg120aazLITlPP?=
 =?us-ascii?Q?Fglb8UAv4/PQJIWX3tl7WXc84njRGrexHwy6PpNqO8vB0CMDSQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QoYyarkZW1HvSRSFuMoT04GbXXEFOAzCfrfFwmnq5N2cuOwQ6kNoRpE1uVTC?=
 =?us-ascii?Q?PCc4wLOK17JLx+umhDJbz8bM6Kz7QDZklA+Hs1E8uFlSnnd4pyxD0lAhmx5f?=
 =?us-ascii?Q?chS9VdDgxsvB2cZSTVqof6cdFVHsLGKGICunCQLFb2yOpQuoYAaNQ+GDFDc9?=
 =?us-ascii?Q?9ncfHy7wtljrugH4wMsKAoTBVSoASypi+QSOH83Z3Sl49J+1ezfC0q88Tu9N?=
 =?us-ascii?Q?TAOjSYOpT8u2jQceZ93VausVO5yowmfDH9g22Hxq3pWvygMj42uqF/aG210C?=
 =?us-ascii?Q?o3CYo+2EXBWeJoOaGpqCyQvSX/ELCvpwITdwdGUMtLpxW2kTWLPnNIwWDGYX?=
 =?us-ascii?Q?RmGpZNs4bfBbscs3nCSy0ZoNVHnEv+i40RhkmPpcX4iHqcjrs4dIZQlugQ2L?=
 =?us-ascii?Q?IeAhu93O/9LxGvUQJfeEIZBF/rLgUqFaypJuX3eylqwUEre9TrumVciV4Bp6?=
 =?us-ascii?Q?kfkUWpFniY+6S0ZNZ+LaIHBoE0I/eAeR+5YgRiwRGv0Z+rw6VkeJYq5292or?=
 =?us-ascii?Q?R7V6HkTZZhAt1vYsFuG/oF48K8CtHqE86aLYsPZDHxWOcsfMQMocyjkhwLtE?=
 =?us-ascii?Q?ns+wkJJcI0fH0gn/cJtaOz59pUCkL72BJlEgTzXezqo1/Pd1IcbOpntN7lRJ?=
 =?us-ascii?Q?e8Zv1aPWHrKyK1R/15boxphdADGoHdu4Karf5JXeH8XgeTAJlx9ZUOq0VivA?=
 =?us-ascii?Q?B5oYsj/B2YvXvXyngnKr6nINrdcZjFefXcoerF8nw87W9PBJBIqu7c6w0TNV?=
 =?us-ascii?Q?BsMuS08qRJBCaVuRjAhAOdBJPxeR4x4ip/HJXXeyWZOCvFf4DD5N3zKnwcBW?=
 =?us-ascii?Q?DBkwBO9tQ4SkAOd5xLOqOHt74KuQ9MULQA455oxSo+noWOP/4pZKhqUThfP9?=
 =?us-ascii?Q?qUtMEQzo5y7/t3M6ZT1xFfJWVRsoipnzfc3lX2sJ8QbELAGM700NuaK6J5QF?=
 =?us-ascii?Q?mZ2lRbNA1dyJHT8yUphBH9fBvsEvi4XKtH5KZ4pRR+yCKjuGTeYIGb+ZQpCx?=
 =?us-ascii?Q?3a+tZiTsPvzEkxGA1ux2S2xL72QL1nB0G2odfuhvLNH7mUv5E+fJakKi7bYh?=
 =?us-ascii?Q?L275ZhvvjrEp5hZ5D0R6U5xREmMsCiIJRmXEE/fxmnlxGLVACuqMN91cur2Q?=
 =?us-ascii?Q?n0BvjtDZiCtG3hfcKqOkZHeulMVVDkYC2jH95dy/jjl6tm3eUZbZfoj9LlYL?=
 =?us-ascii?Q?q4XCiqqI87GH0z8l2TWZWOjUnpsQVmdgGKJxHfgvZ6XVKZpLfA7nQdALAUJG?=
 =?us-ascii?Q?S2i+kp+DmqQ+Vhybclx8hshOQ6b1zOP2yYY8+dSQOmbwdq8QYTV56L5BRnDQ?=
 =?us-ascii?Q?vIiDnA6g0/DnuMOhk0UI2ZjbvNHexS0oFCggRehDdO829Ps+ODTsga2IBYvc?=
 =?us-ascii?Q?Enz9asIBcORpNEQgH5iW3jGcJoLKcgZluG1cyOirQqdvUh95hyCSQao7K4JB?=
 =?us-ascii?Q?9gZk0neuhd/yZWlXN0zaZwVpbm6LbPlksDLGsoLUM4/hcIgKHaS5aAJBZXsh?=
 =?us-ascii?Q?D07wxFkT5FYmXBdr9JmWmNEpLuXtd3V0nWjg+MIjJEM5lRKWpVq0WnF0/y+s?=
 =?us-ascii?Q?vWv5BF97eo5bcyJUzbyNfQ6glm2KWL3h22NzSm5I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19845ae-5a73-47c1-5a48-08dcaa143fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 06:05:12.6595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +eKZJPIH4nFfiE+dDZ31AGowuRUEYNIPgwSfryoZ961IwpRQbK/mKPvo+/zfoMtMb4CnzyfZj9y2uFOfH71rPtV+eYQYL4i5s/nTqk4D9gI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7668
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v5 09/13] vfio/iommufd: Probe and request hwpt dirty
>tracking capability
>
>In preparation to using the dirty tracking UAPI, probe whether the IOMMU
>supports dirty tracking. This is done via the data stored in
>hiod::caps::hw_caps initialized from GET_HW_INFO.
>
>Qemu doesn't know if VF dirty tracking is supported when allocating
>hardware pagetable in iommufd_cdev_autodomains_get(). This is because
>VFIODevice migration state hasn't been initialized *yet* hence it can't pi=
ck
>between VF dirty tracking vs IOMMU dirty tracking. So, if IOMMU supports
>dirty tracking it always creates HWPTs with
>IOMMU_HWPT_ALLOC_DIRTY_TRACKING
>even if later on VFIOMigration decides to use VF dirty tracking instead.

I thought there is no overhead for HWPT with IOMMU_HWPT_ALLOC_DIRTY_TRACKIN=
G vs. HWPT without IOMMU_HWPT_ALLOC_DIRTY_TRACKING if we don't enable dirty=
 tracking. Right?

>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>---
> include/hw/vfio/vfio-common.h |  1 +
> hw/vfio/iommufd.c             | 19 +++++++++++++++++++
> 2 files changed, 20 insertions(+)
>
>diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>common.h
>index 4e44b26d3c45..7e530c7869dc 100644
>--- a/include/hw/vfio/vfio-common.h
>+++ b/include/hw/vfio/vfio-common.h
>@@ -97,6 +97,7 @@ typedef struct IOMMUFDBackend IOMMUFDBackend;
>
> typedef struct VFIOIOASHwpt {
>     uint32_t hwpt_id;
>+    uint32_t hwpt_flags;
>     QLIST_HEAD(, VFIODevice) device_list;
>     QLIST_ENTRY(VFIOIOASHwpt) next;
> } VFIOIOASHwpt;
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index bb44d948c735..2e5c207bbca0 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -110,6 +110,11 @@ static void
>iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>     iommufd_backend_disconnect(vbasedev->iommufd);
> }
>
>+static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>+{
>+    return hwpt && hwpt->hwpt_flags &
>IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>+}
>+
> static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
> {
>     ERRP_GUARD();
>@@ -246,6 +251,17 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>         }
>     }
>
>+    /*
>+     * This is quite early and VFIO Migration state isn't yet fully
>+     * initialized, thus rely only on IOMMU hardware capabilities as to
>+     * whether IOMMU dirty tracking is going to be requested. Later
>+     * vfio_migration_realize() may decide to use VF dirty tracking
>+     * instead.
>+     */
>+    if (vbasedev->hiod->caps.hw_caps &
>IOMMU_HW_CAP_DIRTY_TRACKING) {

Looks there is still reference to hw_caps, then would suggest to bring back=
 the NEW CAP.

>+        flags =3D IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>+    }
>+
>     if (!iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
>                                     container->ioas_id, flags,
>                                     IOMMU_HWPT_DATA_NONE, 0, NULL,
>@@ -255,6 +271,7 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>
>     hwpt =3D g_malloc0(sizeof(*hwpt));
>     hwpt->hwpt_id =3D hwpt_id;
>+    hwpt->hwpt_flags =3D flags;
>     QLIST_INIT(&hwpt->device_list);
>
>     ret =3D iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>@@ -267,6 +284,8 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>     vbasedev->hwpt =3D hwpt;
>     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>+    container->bcontainer.dirty_pages_supported |=3D
>+                              iommufd_hwpt_dirty_tracking(hwpt);

If there is at least one hwpt without dirty tracking, shouldn't we make bco=
ntainer.dirty_pages_supported false?

Thanks
Zhenzhong

>     return true;
> }
>
>--
>2.17.2


