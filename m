Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AC1C3600C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 08:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txin9-0001W7-3L; Thu, 27 Mar 2025 04:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txin7-0001Vr-KR
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:40:45 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txin5-0002Uc-7S
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743064843; x=1774600843;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZF7aV5QhgHakoBT40nAYeTZJCw1LTxjb07A1oyVmyFg=;
 b=BRprtXRkbQHsgpG2OempwAo/FJ2geSMviMbpkDVPTpJ5fGxVADyvl5S9
 bmgGrAQcaH4BXST8EEcZqB/zdGmxlggC7/ZW4aEOrOWU3dYpBoC6RMAiv
 3ZkxSg9kzIpi31+X9HszzTv/bxX6M8JK7mMzjD+nfUAqkrW+bM2GNq8yy
 HD4QPxyvRDsYOURKOI0uFTuN/Ve3NVf/PoUEpo4gOOU13/HO6+K2F3x3A
 jmy9N47esAq1cUV8RM55sxdj9kUegnGOSQurB6B1/ObCZ0PkKNbhIvWTw
 SIKvAURnUDjIzp1cEKvYojburgDxqzScu9jRxAmCXOvrJZPv0iloS9q3P Q==;
X-CSE-ConnectionGUID: Y9aCoTFYQ3iOUtlWQR/Qqg==
X-CSE-MsgGUID: J1RiZ5E3RA+ezjC4KsF1xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="66853204"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="66853204"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 01:40:39 -0700
X-CSE-ConnectionGUID: PKc3QYl+S+GOn/fOSNugVQ==
X-CSE-MsgGUID: NY92XSDyRU+j9/2A0yMC4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="125897440"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 01:40:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 01:40:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 01:40:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 01:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dyTsgPBCbK+DugoAf1/alnHin88DSORD0C6hJC28ukV+HOYDJpaacon7kRgnLo1yio3bIHhoZMVImrdW6sjMZ3bA+4aI/4R8jN+nZ1j0UPpTTJl6P3DKFvLIfs1ZNc6QQBSb8csuWosCZdETYZn/1aPGrziZ6VzfrtM5anZ9ItYW5npsoUj0CJpQwloW98fYbMbzu7F1wCEgr88aQktj4WHUZ4UHFzOvesm9NKxBUhnIeZjVh0ju/hCtpwh40PCZ1SbLv+2azAgI37OnK9+u3gXtAlHryaeWb2ILBlHhGkq0iqIPzbrFN/EoN3SLMIcVecMUPS3ed+tmGyzJEm6b6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZF7aV5QhgHakoBT40nAYeTZJCw1LTxjb07A1oyVmyFg=;
 b=lsbSAGNZ013zRMny0VfGaArocHTgCW3DnYFVjO2+y7Cf/PHB6ArlNX4AjBEGwlJXUKdtuVk3izGsI5Uv9/Egu4Rb5eqh7K7cLPgN6OY/ASA09qKCX6hEG1baOHXgR6iFWkmpLUSq2VgjB9/rojnl9mQ0tHJZ/vvYOLsLKCdp9+0BcR7TM8oetiH1Q8rjP8ola9ChdNGojnIrTDJehkY8lR7PDlzPAxMb+adSjdD1AtIQM6qM7zCxSFu0Wo4hDK3zV6JNNnk+tks2EgRTIxyn0thgwYkWSpFDMDMMtG27bhYKZTOMS4AjMkZHkaKgVXFWPA3WyvLvFKpnkFoacGeaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7729.namprd11.prod.outlook.com (2603:10b6:930:70::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 08:40:06 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 08:40:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH for-10.1 v2 09/37] vfio: Move VFIOHostDMAWindow definition
 into spapr.c
Thread-Topic: [PATCH for-10.1 v2 09/37] vfio: Move VFIOHostDMAWindow
 definition into spapr.c
Thread-Index: AQHbniQFwx+iRbonJEmI4T5kSXVPArOGqVsw
Date: Thu, 27 Mar 2025 08:40:06 +0000
Message-ID: <SJ0PR11MB67447179E13E7628991223F892A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-10-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-10-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7729:EE_
x-ms-office365-filtering-correlation-id: fc289cef-9c76-4291-da7f-08dd6d0af9c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AQWjJwAH0XDjAWKYYfc0iRXpvsC2q7q23XQlIy9+8a3DSxpDkJw952a7Q4?=
 =?iso-8859-1?Q?rnGR8+Dvb6MkqhOTAI2pUuwKGK72oljsGzNIkj0eIsjpzLxUr4pLNO0jhH?=
 =?iso-8859-1?Q?vy9+FLXqRIKq4vDrpUwuf7toYRj0l18SWwaJ8aeXv3UVvYkfQzETsMR3DP?=
 =?iso-8859-1?Q?beprFQkCsyMKQQkDW60nSqQwkLV+1RZdyf8nT1pdwZDMA2FYAdAVHa8SWl?=
 =?iso-8859-1?Q?IFqp27j0fj6qRc9edPnHYPohFW3aOf7iKIewmJUNnxEzleY75VViRCRbVt?=
 =?iso-8859-1?Q?v+R/h8N6W2jm+0ouHBcIp4nh9Qp51ymNQLdHVXwMJEB9eEQhGX0Sz7s9oI?=
 =?iso-8859-1?Q?AIBs+vzSzDQ/ghv3bfuRIskljFpw+B+w0+YXkszneKneNj3eoiwDUcmk3C?=
 =?iso-8859-1?Q?cFBvGGRtea1KYvrsWnRGjiIYOmZVC8SDZcBH9O0ZkvI2D429G7uIINqQVB?=
 =?iso-8859-1?Q?Kdw91TjCoSkdyHA0N3wWMwSvKsD+7wsRuKfzEsw+wWHK8eCqUKEQbB+I+Y?=
 =?iso-8859-1?Q?UaVdgQE7g8iPRe7LAn11geQdOuNk+00iaTljl3+WPID4jZTWAx1qCBW8EM?=
 =?iso-8859-1?Q?UAdAad5McAB3hsxaqF4xmVL7imJOkx0anafyU4Y51NGw5bis7r6uXfCEej?=
 =?iso-8859-1?Q?ipjSO8tzjSllMhpcbExadSj3HNbhdo0gv0EADetkW5NZXq1dc2ShT8/kIl?=
 =?iso-8859-1?Q?9Hb7jMYZi30p5hwhyzevFm24yRwRTbSo0KXUkrQ5qeajFbpORZmIDjHURM?=
 =?iso-8859-1?Q?kqGErFV751W6nAC+jUS6npgSLxvGpO7EYfEE1uN4TThOKDpXWA+3KZrqx/?=
 =?iso-8859-1?Q?ebz2B35pJZWqsDPbzro48YW2zqfbQVLyFI2IMiIPOapUFL2nlNMkXoSYkm?=
 =?iso-8859-1?Q?nhA0OW/QI6uCjfi8zlrmwgSJDEYxMMj9F3Y9uz9veLbAUJ/4PyMo8yzm7P?=
 =?iso-8859-1?Q?edkWhaGBtuONXZ4tkFUquw7SgYZMgTXu2ZcaJ4jXRy4Cn7wpsoqs8Tgz25?=
 =?iso-8859-1?Q?BNXvbY3xWG49TjSCvNz4dJnMkf4W1emwe6q8XHXAbC5bb9Bnce0xlVDT67?=
 =?iso-8859-1?Q?koYlBSaPgg8J3fTF/I1tHQMuvN/VKYGt81h/Aw6niH8tjEhyUiD6s5pIAG?=
 =?iso-8859-1?Q?2EV3khmNcQB2CnD2jdSaxvYB8MZWE6Frsh8B7SFXqETiR1lkdq+8MuwZSJ?=
 =?iso-8859-1?Q?Z4U+QcOCiEdTgyE2vwXpq1UYYLq7ECNgKIgvzfVNewULrS8/p+uluydCnI?=
 =?iso-8859-1?Q?LhgKw2Z3QdNNogXHlQ2J2aHO+fWTHT5eJg099jrTDUwubzxlLfLDLXYHdi?=
 =?iso-8859-1?Q?khyM5Cjhla22VxCArBOiDtkglevjAoyHZEUIuQdzOyMjKRS+HD1SUPtR+n?=
 =?iso-8859-1?Q?bK2pX3TbQ/7r/P01SkwtFuOgUgmW+WodfDDSwioLQLxh78J8wWTmuHjV2D?=
 =?iso-8859-1?Q?U+GlQ1pAy/kTTzXNjzrjG+JSb8iLAjyZhRhr3LT0/EqSDQlAcymRnsZYt/?=
 =?iso-8859-1?Q?T2O5H5xcyyPBTvjDMBMpDJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EvgPMOXBWROSzqPPm4rx+C/2uFTVmEk+HCPKDdJd98OpOCouaKWRyGpsDo?=
 =?iso-8859-1?Q?qKm2Dch9aE3TIWK93JtBBhJJo8lBw1r0QbNVx2muL6ZVr1AWDn9YtAmUCX?=
 =?iso-8859-1?Q?gDLGAAlHh4wIA3btdc/N2Sxf9FtOil8mgUduRPIbwKHXAT8j8KRAeN5ItQ?=
 =?iso-8859-1?Q?BhL3+4Pn+dhiQ25SUIUlIGtU8D5NAlldqiJyc3NI/KVpUzahEUFcOIVKGa?=
 =?iso-8859-1?Q?0R6SdZ905mh0Fp0nLpZkpOlTWw7CNX0GtuALJpUlsKYRu0mVT4CA7zSaC3?=
 =?iso-8859-1?Q?xPwwqHU7nhjQtvm0xYxqzzhaY05UJ+UHqJyUulIa5zVQs/WcKYqcwtBCux?=
 =?iso-8859-1?Q?fsRZx61w0rGPV3nNr2IZOpY0UaSkZT/M3CbrQS2jodtiO9fyMb05xOkkz+?=
 =?iso-8859-1?Q?AjIO9NydL1+R1B8EEQn4NPTVqz5fHsLSjaK5zZr5Jy1VTq+HmKKRY6E8+p?=
 =?iso-8859-1?Q?M8IgPCKi9U0BZoEgAXNh5iD/jgLI2nIqfwoh6h7ut76jVD/58QvOW4H4Oe?=
 =?iso-8859-1?Q?T/xQCgmQrQi7RyciV9T2CsiLl9qG1DvGfNiFsQGae6VAZ2e68RFOkAqOME?=
 =?iso-8859-1?Q?VNz3tErUw0XFXEA9k/+TYlD05PP5xjt7nWy+5e5qXFXmx5axZt3Of/w+v6?=
 =?iso-8859-1?Q?EfRMb9xrFtbF6uKx1mGN/giHRaRlleBMlkTZuyzRgVkB1iA0TMq4LL50Hx?=
 =?iso-8859-1?Q?CK2s/Rb96DHG7IbUE1iBBZhcxB4+6hUxS41xhAnGFBdb3sSJBeaqZCw3g9?=
 =?iso-8859-1?Q?T9k3FgIn7zALmnAKTbPcngIXJG4KrsWX51aI7TM66mzHmhBPkg47mcAECM?=
 =?iso-8859-1?Q?wjVG12pyYIp7AWTuUoCwB1pmwPrSspsLVcWI4LivnSXyKc54Rov+x/Pv0f?=
 =?iso-8859-1?Q?FaBBALJQ0+b+ZSJUnPBTcM4G/d1y68mrNIG+5QdCD3AsDibX7GxTJSmW72?=
 =?iso-8859-1?Q?/TkxWwfzoLLZdca0x92vrw8+acE02fV7U8u6/Xj0va+2W59LhpMd0lbUgi?=
 =?iso-8859-1?Q?HzqkInr80lX7LpyDuj+1hwdIhCKXCsw0grCkUaQj7i+dvF20j9QrH2HImF?=
 =?iso-8859-1?Q?+mFODkokHY1oC/ESnjtaznvhibv0IgV1+O6KYITn07/VpkDEJij996Mby2?=
 =?iso-8859-1?Q?3uYL/bPhEMMu2PZZcxrqQ9H8vPckVgQzE1wyS4lt+xV0Vw4KT8rt4Fuhc9?=
 =?iso-8859-1?Q?cZl+A5Ny7gwYjF5XtZru5Yk96fLbntGLk04Htq/b9i1cs/Ba33rTe0F3LG?=
 =?iso-8859-1?Q?V+Puq9Bb8Kp57ushkWtP0Vl+i7ZZQVoB6JJjYsjvbM/vdMs9TjdpSLvVhM?=
 =?iso-8859-1?Q?/r6lDTPncEEkFlcEtFx91lXXlwexgvTOkcYeqgsOXoo0QGYnvmpqH0oXQN?=
 =?iso-8859-1?Q?rORaNUExN+dtmlY4tM/touAhBPkldkwXKqosDjUomkhXCfmw8C49MLyv1P?=
 =?iso-8859-1?Q?muznxXFogTCnNscKy1ThOovbY7bQ3xoYPSVq+CZBT4kpkS9HTmTKgxTBEV?=
 =?iso-8859-1?Q?b4MvNc2xF+zFnx2X+HCCemum/HnD+w0Ldq2UQVXxtMA+ilpkpxg1fGliex?=
 =?iso-8859-1?Q?JzDxYv8RBYDnl4t4AN3kgF/4H9ih/BUEA9wVoQCLng2HoQvMGKYVPZ2iUl?=
 =?iso-8859-1?Q?BWTiT2rwWw+AnxrcOk1Y7ackyLfvw8mF0o?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc289cef-9c76-4291-da7f-08dd6d0af9c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 08:40:06.3770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0MP257dO0T3aV0z8S4lOhVLXaVbbu4SApW+MSEJHxZW9oME2AzbsKqhQHfaGCKnyBFdWSGlf5U3Revs66Js25zGcfaJFceSoGEUe/ueMxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7729
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
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
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: [PATCH for-10.1 v2 09/37] vfio: Move VFIOHostDMAWindow definition
>into spapr.c
>
>VFIOHostDMAWindow is only used in file "spapr.c". Move it there.
>
>Reviewed-by: John Levon <john.levon@nutanix.com>
>Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-9-
>clg@redhat.com
>Signed-off-by: C=E9dric Le Goater <clg@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

