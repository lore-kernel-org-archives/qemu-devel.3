Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99914C3DA4B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 02:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTY1M-0002VO-8s; Mon, 15 Jul 2024 22:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTY1J-0002Uh-6O
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 22:34:26 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTY1F-000651-RL
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 22:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721097262; x=1752633262;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZBMZHa3QvQ1DSwQn1o3mokUg9tjwrll5FRXTKxpUJj4=;
 b=KZnOo/CRHkVzc0Z1aPXsbbsUdSlAADW8nMktQbECtGbki41+vgvGwoSX
 5/9y5cdZvAcBEgwCya2QczCdGtwD6JazuT8Kg0DNKilrsHvX4OVJ5Lj1x
 iEFLkLimjIdI2ewPUsdVmtrenCOuq4vGrO6n0tKvuJwNJXU3Zx3eG0G1U
 0KxF+jev5Dg+0v6/FY6LOyrQCnPEWi8tcBSyAV+2kZAPRRYzlX1goEkZZ
 cbuIcwU7Tm+Gy/r+FYXgkbCJ932CkI5mrFtz60OUCvhEHEAxim0hwE0cy
 b8HWjJdIsQqZrS7Tp/Cuq49ij8LfDKZ81FeBUMYw/rfsbz9M1fWDdfxQL A==;
X-CSE-ConnectionGUID: mytvsgTATwWO8Z786RiRxg==
X-CSE-MsgGUID: bXupj4ujQ3eldHwu4/U6RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="29660837"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="29660837"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2024 19:34:18 -0700
X-CSE-ConnectionGUID: fAQc1c9OQr+z8XvnGIembg==
X-CSE-MsgGUID: S7W9LR1PTHOTeCiuuZGs1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="49690385"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Jul 2024 19:34:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 19:34:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 19:34:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 19:34:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lL0YtGkZ6UqdCaYJlXL9jqQ/b5nIC3JY2TLdnc3OBz8oI5Zts/XY5hORa0gCFpA3R6iDZ2v5Gjq0sV0a8s/HoBOcZxSwhSjg7/jKw/ohzyzWAwVtdURS/iuMoGuMGCduHrHQCSYglGrCvse/lDZrBlyzzXWIq09KHGMyHw83uBtUhghXaVsQ2mTsmL6kCMx38EUkItU89P1XMZeEyEn2yRMblk7UZFmO/8wyiycQYKPu0cIOYAyi+8g6dgkKGoyYCLqPD9NRy6AmWZCAABguWxfLEcZh6ntyglb+eP8wYP6pKjMAwm2rLsGO/QGAF0ETlIfpnNXSPgUpwwXO13URfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtqfvDhcjV/JVYcAABot8Wop00GmJikIky4CqZJoY+s=;
 b=oX1F05l2jVk/pFxrIVNSXFuFvxXoXJMcbbI1561grP2wlHRQLzfbBUJzTtGC65wIfeeVEgvh4xtYxwXK8iY+Eg8WDAeOOQ23t4V0/VOnRAEqtvh1mP+1TNSVU3WE9SQAdOol8a5wHssTUYGPCdLWTu6XKObsyoH7x3gRqu5RoW9kHPS7N63FXO/xHjuRQkoqN2FHxr45G5/h3V6wVVE3KEB4Pd1Mt51PA0/BMOsZX8Y02WnqAJSMIPrBMifCNk3eR6uSD/Ju66V0T4y4mjuHtXm7mSkQ9ryJn2fWTGkGD3NQCb2ydANJOA6IX18m/QDYrCTVrBSZ+G9oHXRkLD+n/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 02:34:07 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7762.025; Tue, 16 Jul 2024
 02:34:07 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: "Wang, Yichen" <yichen.wang@bytedance.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Hao Xiang <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, "Wang, Yichen"
 <yichen.wang@bytedance.com>
Subject: RE: [PATCH v6 1/5] docs/migration: add qatzip compression feature
Thread-Topic: [PATCH v6 1/5] docs/migration: add qatzip compression feature
Thread-Index: AQHa1wQ1enQ4qsaU50qKhJvQzA0F47H4oTJQ
Date: Tue, 16 Jul 2024 02:34:07 +0000
Message-ID: <PH7PR11MB59410143A089733E8FAC5A36A3A22@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240715221245.12435-1-yichen.wang@bytedance.com>
 <20240715221245.12435-2-yichen.wang@bytedance.com>
In-Reply-To: <20240715221245.12435-2-yichen.wang@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|PH7PR11MB7429:EE_
x-ms-office365-filtering-correlation-id: bd52dbf0-66b0-41fa-3926-08dca53fc452
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?N3rKLarMhkGZ5/e/jBUgPBbqv1Ha/X7mYV1u5csed0ZtrwJJCxtOKJfwuX?=
 =?iso-8859-1?Q?XnCI+rtDY4D3EPWQ1Z9Ik/nWMcNOG9mhBe7hrltxhEflplk2908vHIJ+Op?=
 =?iso-8859-1?Q?MaPJg/iOxmqKj18qlKaBR0n9VX5m1whueGjUl3GcEVVZN3wf+NDjJgJJTu?=
 =?iso-8859-1?Q?xBZY0G/yR83SUeBc4ZvFQ7sQRe8LdlvPgfuQhOlHkKtbCsVdlfpnsgJMB8?=
 =?iso-8859-1?Q?k1v5RkH0MpKtmqSegr2EW5FNySG42Rh7WylZO7qdmr7s4ulFoamiRfpOlD?=
 =?iso-8859-1?Q?zsiRkP0iVx1WwXq//bi727MQ2obyH2DYddOEcW7l0ne8N80TS2Ru3kNZlS?=
 =?iso-8859-1?Q?zmU0ah5B4CDhff5CknU69AxLyaRE9Qs56IeHoc4vCmuGwXhA69tOUr0RjE?=
 =?iso-8859-1?Q?GwlY+NAm/O1cjlq0HiMoR4zXB5LHHHabPIJ7fYFCB3ehZIc2cXOXL+mquv?=
 =?iso-8859-1?Q?M2lwhWr5ekhy+M7fyU4F1o5LrtvF90z9GkA7KQtyVXPjo2XfV/N+ttv6cC?=
 =?iso-8859-1?Q?K0Bx99lkpGDsbuq8wIjo4us0EvcJvJGIDjmUWD8l0H/N+CMD2iwf9OmEL1?=
 =?iso-8859-1?Q?fO+YjUIr1EwSIj760TYmKZTrLKv6uRH4pbBbqIDGwIKcSTkjTIFIlopZV6?=
 =?iso-8859-1?Q?4nPLag+WgOcxYoeGxXo79nx9177iW1SSpdRolTcfmWZe5gk+ZBN/EQIPPo?=
 =?iso-8859-1?Q?ZFDzNsw2400y9K6SrMv+L+kHxseEk5bhxhdLkmjrt+ZkKbs5C2oTjdxxCe?=
 =?iso-8859-1?Q?r6fJ+2e+EKejx2EEWkN/gM7xISHWUCtOgvMCy3N6rCX/pMei4lBHib5MQM?=
 =?iso-8859-1?Q?MIpav6MTR8/jPVzd6OLVhVvk8QnWBFes1p8vM44XWdoXMG+nONV3lwvNqq?=
 =?iso-8859-1?Q?ryl6qjuJB17uhujYqvutsZENTDIi4VQPfLRCNiLIKLfJmeSpJunIt/eZXE?=
 =?iso-8859-1?Q?3J5e76sXLqZbmJw8Emy8QGHse0afRtUdv+zylMJd7ln8wvR5JWzHfpIYE/?=
 =?iso-8859-1?Q?h5u9z6MyV2wbnRfLw+6fG9OIjGKFYxoCYSr4o5wc4TC+VUZeGsM1D6WbLk?=
 =?iso-8859-1?Q?cC8bhie++QDwtRZoAPcKzdM6RKM5ANRjJIkJvFB94Xwne7lF4l1gaSXySq?=
 =?iso-8859-1?Q?V3sXixyucMElEetBd33J1DAMGjqrAU01iJs6UzaGhnH44d2TnOUV65NFyN?=
 =?iso-8859-1?Q?Ta7mUWJFG5LqjGIII/sSpwVrAkZ2KxfbpksYHhO+7EES2AQbPszDeWsD6K?=
 =?iso-8859-1?Q?mYkKaCrrGDdP+jVxR72UR4N6VQ3MBZyGsKi1XB0eE6RLRxCsMhQJjCr5EO?=
 =?iso-8859-1?Q?pJ9qaHVUN6cofqOsn6N4zd9cR9+I61EMZKfOVDWbmBFcv8EcmK+J06T8UF?=
 =?iso-8859-1?Q?J0kVTKNtubu8iMCOw4ZDhC2NcjDXOE8EkNyu6r8BMdMlvaDFHNmCaN3UXV?=
 =?iso-8859-1?Q?qXaVUW5ZzAuzS6PM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+8Kwt5RqrD99ApO+Zvz58ntP1P/Tw2zM9q8qvMcy6X+hkno3jnn10mTsAI?=
 =?iso-8859-1?Q?lZO6UPuDq3VcFuKkdinPtXk+3NMCJHSIDBk599PvCNxsdUKF7uUxxFqB6z?=
 =?iso-8859-1?Q?SdSEuJXVnALnBQTqSxe7iT7d/la8o6C8uA/+ppBcsZuaEgkKIo4W0Qk7N3?=
 =?iso-8859-1?Q?OKJo8CsqS0GUiT/Fph7/OydHmknEEFmCRODlNHkQRyyuw76nf7EOKI3wd+?=
 =?iso-8859-1?Q?pEQPX3GhkHkiXclGtozxeaNwMAlAaKI5F5gWeCdNRndCdsqAFT4R7dVevA?=
 =?iso-8859-1?Q?NS7ZnPA5QPACpDxNYaiSQ92+qNwUR9CXqLxCKHfezB591SYAwyddQVPtQO?=
 =?iso-8859-1?Q?150v/53zjeHrp4bYSFrTdTVy1Ck2Xfk7AsAE5vZK/BI9xvujFvaL/IjmaV?=
 =?iso-8859-1?Q?RvmqPBaJwREBdCTGbPmdKTwQsYwrYzkKSBqhvA8uFCcWDyS4WnqGUyti21?=
 =?iso-8859-1?Q?Kin3WngidSLvbCvQqWqzGlv8cJWFjexfHF3V/D0UyAGhZzipBYOMWFFoX+?=
 =?iso-8859-1?Q?zhIZXQtaYXKM4YnzvgY6Zo+2jUbKwmC45dAEFlO1he2dQsUjmpLSVa9z3X?=
 =?iso-8859-1?Q?WXS41kHkt2OB6quWAC7QB1UWw0LZmuLVY5jStvio9b2Cl+h+MncrFBLE+d?=
 =?iso-8859-1?Q?+X0VRNAq8d0W3O+TlWDzbbfRgUx8tAwfaYaktTmX8w2U3M80K44SGqMTJd?=
 =?iso-8859-1?Q?4kx/LL1UUXlsKjfx46D7KEmP1rRFT9X0wVbpYop02Q361esjeA+Ybj57+c?=
 =?iso-8859-1?Q?dBM1D5IUSfOpz/Jvg9tlNmXnxOvWGGvyGKMtqjFCdQ/FgHaZ701wxOjE6O?=
 =?iso-8859-1?Q?GgBVl9K/LKd/iS8FVv/E0TZfDs7i3cpEjAH3FiQCjfVLfMq4UtkMUeBfGG?=
 =?iso-8859-1?Q?THcnP6+2OPzH38RLvgsqh6q00jdr2g8H9HEk7ty/TwvrCjT59OzO7kulZz?=
 =?iso-8859-1?Q?QrHhtARWqYhZERtal9L7Mwl6LqHPbBhE5BwsM0zOLJeX31qthrfnTJcoRx?=
 =?iso-8859-1?Q?yZjw+fPSxBSE9NBPpoOEydkRJY2e+kU2XaXtECBHdO9gNSm6csrSNS2DWd?=
 =?iso-8859-1?Q?QHCiVdK7nt7MmuLg+IerMLW0qwSuyXc3tmjp5JraGOPAnWZFhKaFl+rYCW?=
 =?iso-8859-1?Q?chMeg9B113mKQ//RASzifICiTWumCFciklex7Sb47kNT/t5vPN1zKSLEez?=
 =?iso-8859-1?Q?lVSb0lUjHma2vthDxAZak1mTw85XJXBcl+JVmKMcAwidgUJauCPcryK1DK?=
 =?iso-8859-1?Q?+QRy+FB42wJH+OgsrIp2HQgdv1hL0pTS9mQvhJYmSRU8ZdZqhU9JYX/zMu?=
 =?iso-8859-1?Q?He21yeRzSTZ9aKwlPiGXxrYUkU16gTFMZeKP7UnPk2MtX+JPEtO3BqZG7Y?=
 =?iso-8859-1?Q?1uSDBU8jpx0r0pDU+TL7Y7nehBDHvMiKPuz+AlcPvwVuBPOjV7ikyuLVM7?=
 =?iso-8859-1?Q?M1gmBku6MEY6PQ62RZtzORNVZDJ2yACKvF+80UJGelLCf7xwZm1bMbx6TA?=
 =?iso-8859-1?Q?H97QOks0KJqoE8TLd2musV0mvrBDTKWWSl0rXzD0qSN1GrECV3yFBLeOL3?=
 =?iso-8859-1?Q?o61ZF+wuP1JxmL5stYr5lDSQfHdlWHkAeDtDeNhGMrCPVDcS1NdTifsVVX?=
 =?iso-8859-1?Q?7TJzEYRx3rVWMPQhvhyhvDH9IAbxqoultn?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd52dbf0-66b0-41fa-3926-08dca53fc452
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 02:34:07.4803 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0bAWXJuV96SDznRuHlIYxblOiSvr2S/pWox5O8JmDS4x7uplQxSv1CoQ9EL3A7o8MFnzwKuqo4MNntREayCzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> -----Original Message-----
> From: Yichen Wang <yichen.wang@bytedance.com>
> Sent: Tuesday, July 16, 2024 6:13 AM
> To: Peter Xu <peterx@redhat.com>; Fabiano Rosas <farosas@suse.de>; Paolo
> Bonzini <pbonzini@redhat.com>; Daniel P. Berrang=E9 <berrange@redhat.com>=
;
> Eduardo Habkost <eduardo@habkost.net>; Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com>; Thomas Huth <thuth@redhat.com>; Philippe
> Mathieu-Daud=E9 <philmd@linaro.org>; Eric Blake <eblake@redhat.com>; Mark=
us
> Armbruster <armbru@redhat.com>; Laurent Vivier <lvivier@redhat.com>; qemu=
-
> devel@nongnu.org
> Cc: Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1 <yuan1.liu@intel.com>;
> Zou, Nanhai <nanhai.zou@intel.com>; Ho-Ren (Jack) Chuang
> <horenchuang@bytedance.com>; Wang, Yichen <yichen.wang@bytedance.com>
> Subject: [PATCH v6 1/5] docs/migration: add qatzip compression feature
>=20
> From: Yuan Liu <yuan1.liu@intel.com>
>=20
> add Intel QATzip compression method introduction
>=20
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  docs/devel/migration/features.rst           |   1 +
>  docs/devel/migration/qatzip-compression.rst | 251 ++++++++++++++++++++
>  2 files changed, 252 insertions(+)
>  create mode 100644 docs/devel/migration/qatzip-compression.rst
>=20
> diff --git a/docs/devel/migration/features.rst
> b/docs/devel/migration/features.rst
> index 58f8fd9e16..8f431d52f9 100644
> --- a/docs/devel/migration/features.rst
> +++ b/docs/devel/migration/features.rst
> @@ -14,3 +14,4 @@ Migration has plenty of features to support different
> use cases.
>     CPR
>     qpl-compression
>     uadk-compression
> +   qatzip-compression
> diff --git a/docs/devel/migration/qatzip-compression.rst
> b/docs/devel/migration/qatzip-compression.rst
> new file mode 100644
> index 0000000000..72fa3e2826
> --- /dev/null
> +++ b/docs/devel/migration/qatzip-compression.rst
> @@ -0,0 +1,251 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +QATzip Compression
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +In scenarios with limited network bandwidth, the ``QATzip`` solution can
> help
> +users save a lot of host CPU resources by accelerating compression and
> +decompression through the Intel QuickAssist Technology(``QAT``) hardware=
.

Hi Yichen

Thanks for adding the part of Performance Testing with QATzip, I wonder if =
we
can remove Performance Testing with QATzip part and directly add the follow=
ing
content.=20

Here, we use a typical example of limited bandwidth to illustrate the advan=
tages
of QATzip. If the user is interested in qatzip, he still needs to verify th=
e performance
by himself.

+The following test was conducted using 8 multifd channels and 10Gbps netwo=
rk
+bandwidth. The results show that, compared to zstd, ``QATzip`` significant=
ly
+saves CPU resources on the sender and reduces migration time. Compared to =
the
+uncompressed solution, ``QATzip`` greatly improves the dirty page processi=
ng
+capability, indicated by the Pages per Second metric, and also reduces the
+total migration time.
+
+::
+
+   VM Configuration: 16 vCPU and 64G memory
+   VM Workload: all vCPUs are idle and 54G memory is filled with Silesia d=
ata.
+   QAT Devices: 4
+   |-----------|--------|---------|----------|----------|------|------|
+   |8 Channels |Total   |down     |throughput|pages per | send | recv |
+   |           |time(ms)|time(ms) |(mbps)    |second    | cpu %| cpu% |
+   |-----------|--------|---------|----------|----------|------|------|
+   |qatzip     |   16630|       28|     10467|   2940235|   160|   360|
+   |-----------|--------|---------|----------|----------|------|------|
+   |zstd       |   20165|       24|      8579|   2391465|   810|   340|
+   |-----------|--------|---------|----------|----------|------|------|
+   |none       |   46063|       40|     10848|    330240|    45|    85|
+   |-----------|--------|---------|----------|----------|------|------|


> +``QATzip`` is a user space library which builds on top of the Intel
> QuickAssist
> +Technology user space library, to provide extended accelerated
> compression and
> +decompression services.
> +
> +For more ``QATzip`` introduction, please refer to `QATzip Introduction
> +<https://github.com/intel/QATzip?tab=3Dreadme-ov-file#introductionl>`_
> +
> +QATzip Compression Framework
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +::
> +
> +  +----------------+
> +  | MultiFd Thread |
> +  +-------+--------+
> +          |
> +          | compress/decompress
> +  +-------+--------+
> +  | QATzip library |
> +  +-------+--------+
> +          |
> +  +-------+--------+
> +  |  QAT library   |
> +  +-------+--------+
> +          |         user space
> +  --------+---------------------
> +          |         kernel space
> +   +------+-------+
> +   |  QAT  Driver |
> +   +------+-------+
> +          |
> +   +------+-------+
> +   | QAT Devices  |
> +   +--------------+
> +
> +
> +QATzip Installation
> +-------------------
> +
> +The ``QATzip`` installation package has been integrated into some Linux
> +distributions and can be installed directly. For example, the Ubuntu
> Server
> +24.04 LTS system can be installed using below command
> +
> +.. code-block:: shell
> +
> +   #apt search qatzip
> +   libqatzip-dev/noble 1.2.0-0ubuntu3 amd64
> +     Intel QuickAssist user space library development files
> +
> +   libqatzip3/noble 1.2.0-0ubuntu3 amd64
> +     Intel QuickAssist user space library
> +
> +   qatzip/noble,now 1.2.0-0ubuntu3 amd64 [installed]
> +     Compression user-space tool for Intel QuickAssist Technology
> +
> +   #sudo apt install libqatzip-dev libqatzip3 qatzip
> +
> +If your system does not support the ``QATzip`` installation package, you
> can
> +use the source code to build and install, please refer to `QATzip source
> code installation
> +<https://github.com/intel/QATzip?tab=3Dreadme-ov-file#build-intel-
> quickassist-technology-driver>`_
> +
> +QAT Hardware Deployment
> +-----------------------
> +
> +``QAT`` supports physical functions(PFs) and virtual functions(VFs) for
> +deployment, and users can configure ``QAT`` resources for migration
> according
> +to actual needs. For more details about ``QAT`` deployment, please refer
> to
> +`Intel QuickAssist Technology Documentation
> +<https://intel.github.io/quickassist/index.html>`_
> +
> +For more ``QAT`` hardware introduction, please refer to `intel-quick-
> assist-technology-overview
> +<https://www.intel.com/content/www/us/en/architecture-and-
> technology/intel-quick-assist-technology-overview.html>`_
> +
> +How To Use QATzip Compression
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +
> +1 - Install ``QATzip`` library
> +
> +2 - Build ``QEMU`` with ``--enable-qatzip`` parameter
> +
> +  E.g. configure --target-list=3Dx86_64-softmmu --enable-kvm ``--enable-
> qatzip``
> +
> +3 - Set ``migrate_set_parameter multifd-compression qatzip``
> +
> +4 - Set ``migrate_set_parameter multifd-qatzip-level comp_level``, the
> default
> +comp_level value is 1, and it supports levels from 1 to 9
> +
> +
> +Performance Testing with QATzip
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +Testing environment is being set as below:
> +
> +VM configuration:16 vCPU, 64G memory;
> +
> +VM Workload: all vCPUs are idle and 54G memory is filled with Silesia
> data;
> +
> +QAT Devices: 4;
> +
> +Sender migration parameters:
> +
> +.. code-block:: shell
> +
> +    migrate_set_capability multifd on
> +    migrate_set_parameter multifd-channels 2/4/8
> +    migrate_set_parameter max-bandwidth 1G/10G
> +    migrate_set_parameter multifd-compression qatzip/zstd
> +
> +Receiver migration parameters:
> +
> +.. code-block:: shell
> +
> +    migrate_set_capability multifd on
> +    migrate_set_parameter multifd-channels 2
> +    migrate_set_parameter multifd-compression qatzip/zstd
> +
> +max-bandwidth: 1 GBps (Gbytes/sec)
> +
> +.. code-block:: text
> +
> +    |-----------|--------|---------|----------|------|------|
> +    |2 Channels |Total   |down     |throughput| send | recv |
> +    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
> +    |-----------|--------|---------|----------|------|------|
> +    |qatzip     |   21607|       77|      8051|    88|   125|
> +    |-----------|--------|---------|----------|------|------|
> +    |zstd       |   78351|       96|      2199|   204|    80|
> +    |-----------|--------|---------|----------|------|------|
> +
> +    |-----------|--------|---------|----------|------|------|
> +    |4 Channels |Total   |down     |throughput| send | recv |
> +    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
> +    |-----------|--------|---------|----------|------|------|
> +    |qatzip     |   20336|       25|      8557|   110|   190|
> +    |-----------|--------|---------|----------|------|------|
> +    |zstd       |   39324|       31|      4389|   406|   160|
> +    |-----------|--------|---------|----------|------|------|
> +
> +    |-----------|--------|---------|----------|------|------|
> +    |8 Channels |Total   |down     |throughput| send | recv |
> +    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
> +    |-----------|--------|---------|----------|------|------|
> +    |qatzip     |   20208|       22|      8613|   125|   300|
> +    |-----------|--------|---------|----------|------|------|
> +    |zstd       |   20515|       22|      8438|   800|   340|
> +    |-----------|--------|---------|----------|------|------|
> +
> +max-bandwidth: 10 GBps (Gbytes/sec)
> +
> +.. code-block:: text
> +
> +    |-----------|--------|---------|----------|------|------|
> +    |2 Channels |Total   |down     |throughput| send | recv |
> +    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
> +    |-----------|--------|---------|----------|------|------|
> +    |qatzip     |   22450|       77|      7748|    80|   125|
> +    |-----------|--------|---------|----------|------|------|
> +    |zstd       |   78339|       76|      2199|   204|    80|
> +    |-----------|--------|---------|----------|------|------|
> +
> +    |-----------|--------|---------|----------|------|------|
> +    |4 Channels |Total   |down     |throughput| send | recv |
> +    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
> +    |-----------|--------|---------|----------|------|------|
> +    |qatzip     |   13017|       24|     13401|   180|   285|
> +    |-----------|--------|---------|----------|------|------|
> +    |zstd       |   39466|       21|      4373|   406|   160|
> +    |-----------|--------|---------|----------|------|------|
> +
> +    |-----------|--------|---------|----------|------|------|
> +    |8 Channels |Total   |down     |throughput| send | recv |
> +    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
> +    |-----------|--------|---------|----------|------|------|
> +    |qatzip     |   10255|       22|     17037|   280|   590|
> +    |-----------|--------|---------|----------|------|------|
> +    |zstd       |   20126|       77|      8595|   810|   340|
> +    |-----------|--------|---------|----------|------|------|
> +
> +max-bandwidth: 1.25 GBps (Gbytes/sec)
> +
> +.. code-block:: text
> +
> +    |-----------|--------|---------|----------|----------|------|------|
> +    |8 Channels |Total   |down     |throughput|pages per | send | recv |
> +    |           |time(ms)|time(ms) |(mbps)    |second    | cpu %| cpu% |
> +    |-----------|--------|---------|----------|----------|------|------|
> +    |qatzip     |   16630|       28|     10467|   2940235|   160|   360|
> +    |-----------|--------|---------|----------|----------|------|------|
> +    |zstd       |   20165|       24|      8579|   2391465|   810|   340|
> +    |-----------|--------|---------|----------|----------|------|------|
> +    |none       |   46063|       40|     10848|    330240|    45|    85|
> +    |-----------|--------|---------|----------|----------|------|------|
> +
> +If the user has enabled compression in live migration, using QAT can sav=
e
> the
> +host CPU resources.
> +
> +When compression is enabled, the bottleneck of migration is usually the
> +compression throughput on the sender side, since CPU decompression
> throughput
> +is higher than compression, some reference data
> +https://github.com/inikep/lzbench, so more CPU resources need to be
> allocated
> +to the sender side.
> +
> +Summary:
> +
> +1. In the 1GBps case, QAT only uses 88% CPU utilization to reach 1GBps,
> but
> +   ZSTD needs 800%.
> +
> +2. In the 10Gbps case, QAT uses 180% CPU utilization to reach 10GBps. bu=
t
> ZSTD
> +   still cannot reach 10Gbps even if it uses 810%.
> +
> +3. The QAT decompression CPU utilization is higher than compression and
> ZSTD,
> +   because:
> +
> +   a. When using QAT compression, the data needs to be copied to the QAT
> memory
> +   (for DMA operations), and the same for decompression. However,
> +   do_user_addr_fault will be triggered during decompression because the
> QAT
> +   decompressed data is copied to the VM address space for the first
> time, in
> +   addition, both compression and decompression are processed by QAT and
> do not
> +   consume CPU resources, so the CPU utilization of the receiver is
> slightly
> +   higher than the sender.
> +
> +   b. Since zstd decompression decompresses data directly into the VM
> address
> +   space, there is one less memory copy than QAT, so the CPU utilization
> on the
> +   receiver is better than QAT. For the 1GBps case, the receiver CPU
> +   utilization is 125%, and the memory copy occupies ~80% of CPU
> utilization.
> +
> +How To Choose Between QATzip and QPL
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Starting from Intel 4th Gen Intel Xeon Scalable processors, codenamed
> Sapphire
> +Rapids processor(``SPR``), it supports multiple build-in accelerators
> including
> +``QAT`` and ``IAA``, the former can accelerate ``QATzip``, and the latte=
r
> is
> +used to accelerate ``QPL``.
> +
> +Here are some suggestions:
> +
> +1 - If your live migration scenario is limited network bandwidth and
> ``QAT``
> +hardware resources exceed ``IAA``, then use the ``QATzip`` method, which
> +can save a lot of host CPU resources for compression.
> +
> +2 - If your system cannot support shared virtual memory(SVM) technology,
> please
> +use ``QATzip`` method because ``QPL`` performance is not good without SV=
M
> +support.
> +
> +3 - For other scenarios, please use the ``QPL`` method first.
> --
> Yichen Wang


