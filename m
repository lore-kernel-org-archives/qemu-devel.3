Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39100CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 04:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKqiJ-00080X-Iv; Sun, 16 Nov 2025 23:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vKqiH-00080P-1i
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 23:19:37 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vKqiE-0005Lo-Hi
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 23:19:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763353175; x=1794889175;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0F03M7PCYWJet5pSzaK5P2KACUh4yvEpungTT8JREWY=;
 b=NB7YoZZkVw92uSBXHKoxoryZ8EgVgwI/HDiHp48Jy+6c097P3+ox7SKj
 mg7lLqNuVdw0VVm/olwwZqDK9BUyfLjlDyd7ZG2iTjk3FTkdNgKbt/TmJ
 jDeqWHhuKWpCobES64b5R5vjLLwyIhtsqPpjJcRa4yPsNIjmXzxPSmwo8
 aTRTGzq73Pd8Z8ry9sp+VeByB39wXdc6eJlDJ5ImFSFSuJmV/Mqj7c461
 Q+Fh0CcRZpZr8xVGAJTNeD8tVOq0XCeGnKnJOIcDae+GkBaJ1FqR72KoS
 87bl88I4hS+2JQMWsUInWxCtstVWnRXq0oPgNpMrhjAHClnNLU4hRtqeR g==;
X-CSE-ConnectionGUID: +d91AoMaQhKTf5j96tlcRQ==
X-CSE-MsgGUID: bmLUr2eBTZeDdPMSZE4Gzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="69196539"
X-IronPort-AV: E=Sophos;i="6.19,310,1754982000"; d="scan'208";a="69196539"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2025 20:19:33 -0800
X-CSE-ConnectionGUID: 9gIUtPhUQbGbqXklfYwLsA==
X-CSE-MsgGUID: tcHyWOFqRT+MhQTaWDvMUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,310,1754982000"; d="scan'208";a="213741288"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2025 20:19:32 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 20:19:31 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 16 Nov 2025 20:19:31 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 16 Nov 2025 20:19:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8p8GuxdwXxcQ80GLw5hfEq8aq5nNTtQKZc7AiP3mq+LXxKRwoooK3qJiYgVTAfzeYOCCB6aslj3lBKnFKhqdXCv6ElRD3TdE5FXfD2hglmCOT15nxVQEjbmtTbFMiMmtWjzkOJt3BgDZhF0X2ps7Q/yig7RVPUqTz9Js4cru/0y08i9kQu0w4RljjdsRXzM5pt6Ikhcnyiw0NnAYemMy8SumpyLu1fgFN2f6f+cJKT+idlLF5iPYkkQQqSWXXuk5KmogeJrL05wEhVEpE0cmP8oklhUvfs68bSMhqUHLQNV48dHZvd65Nh0IDZt2qccfrY8FNyQpgEHFMJcfKTfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnmxUDSmMcZT6paLhZeSFl8CfW16Lt58cXA2TTzVQg0=;
 b=hEHYa+3D5JPg+51ffJGbUS1zqOQ8DTdtLWXVkmGF7HwjnH5P3vYTOKOLVH88HXayM+PoJG37OUrRGW1+zf4dKEK4RdJt+ChSo/qeslhpI2m0Mh6uyMFasAqg74AGBMKKrbqwUzOs6mAOCmwAf1nNDh/2P+VmpWRLBCzAN63pSGQrfui6geOeTgg9WBfBdbUEvhlLaF3dWG7PZf1HxRoXISX1sAPmgiGNvEhjlTcyT6vVGJaTC8o9PYlQJXvBN5vh7RFVadrgL/F8In3NDrwyFZKJ+5uSpgAaiAdeqLpGi5kX0QVugtM+EjzO849gfA2ZDUr6yQ28MvpLuXUO1o2kTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DS4PPF6915D992B.namprd11.prod.outlook.com (2603:10b6:f:fc02::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 04:19:30 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 04:19:30 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: RE: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcUTsgsJEAjPPBdEeeacaZ/CcvobTrWiQAgAEUO2CAAkjDAIAA2a3wgABopoCAARmAkA==
Date: Mon, 17 Nov 2025 04:19:30 +0000
Message-ID: <IA0PR11MB7185D06DA886C3758E9B0FB5F8C9A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-11-vivek.kasireddy@intel.com>
 <5c224e00-8114-4586-b502-3819770bc8ff@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71853FE6CD48B77FA586B628F8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <3c0fe9e8-7efa-4936-b5ef-5cabc4239cdd@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71855ADFEEC4E3267B464768F8CDA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <8451c0ee-6c9d-4fbf-b1c2-05fd5fd8e4c3@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <8451c0ee-6c9d-4fbf-b1c2-05fd5fd8e4c3@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DS4PPF6915D992B:EE_
x-ms-office365-filtering-correlation-id: 88841074-9abe-4e59-fc36-08de259080e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?udjzJSCQjf6W3m47w1ajyJzgdtWIsSv1H3tfl0CehhsLtQ+vfwYNWO6Vkr?=
 =?iso-8859-1?Q?g+wgHMYu4jZ6HPW9x9M0J6ps63oiyOGAgalCKwC4uicLJmaJqckDytXtpB?=
 =?iso-8859-1?Q?/nLvRgf3aCqfEiE7Xi0EOnVQwzhjCaATw5BJK+WO6mgCT+n3eGxy8dAL0E?=
 =?iso-8859-1?Q?c9fQB7fcNyOBgJ6PkmB+E9MX9W0Bq8BhFP1SDNDPVoeHlS3lcedUGIT2Qx?=
 =?iso-8859-1?Q?/CYpWlILoC7K2L73cmg/1KBC5tEaNUMFnDEv5GGXnrxkAlWDsjdeYli6Kp?=
 =?iso-8859-1?Q?sL99ne/3GrH4tnQHqmFggxh/MCKQNaIcgM6RpgqvX9tSzHi/wGuGLA/i98?=
 =?iso-8859-1?Q?80pFY4VSjWkBM931mb/0OJFuJ/YFo9zqiPRe2FFopgIpkbOU0nxJ+brtg8?=
 =?iso-8859-1?Q?q8o+y9axWl3wxQBlKiQULzBIWrEGm/jTSwSz3oZfeewdvJbByLU4z4kOtX?=
 =?iso-8859-1?Q?CMA7UTK9HA8T438/kZKCTWtZd73TDjN8i69SDy7e2w5DzjfjbatSYOqJgh?=
 =?iso-8859-1?Q?g4k6xuLkDSWXE4LD1OLJGxkr1SMKuilXE9wH3XnBcKT4WONSeXlMvBoTrw?=
 =?iso-8859-1?Q?9H3Hm+Y96ri1ZkgO/XmpVtbavk6Oqq1UO6XX1WB949wM72H89ietJ9S1MK?=
 =?iso-8859-1?Q?1KaZNB0ZIrYGBGo/Kc6FJQ94GgGr9zYqxmQ7fq/bCHp4VXqkk8Q3adZntK?=
 =?iso-8859-1?Q?+4wForv6F7nE9xrbQZbWkQiLTHMUmwh/BWuMmrjj3Dg0TS1nZ98hBL5ca9?=
 =?iso-8859-1?Q?76fKV6eghBuuMzV8BhSxKbntfvy5VnzCNwPAkA/MIBloP2lcXl8JM/BM6b?=
 =?iso-8859-1?Q?t1egT3LDB1sgSDUAh3v2Juwu+aHtWmO7cddf5Q4HdrBwO4DXOJLV1yaxjb?=
 =?iso-8859-1?Q?Bjw/HexotC7IVPEo/WWzWr9f09bwiLB/QlCs0ASCbR7XmnM1yhvfH2x/NA?=
 =?iso-8859-1?Q?wDHmRIk0uaUBEZxb3IRJ54R2WsiYgDWmEPJZecGuN0RRUCoy0ZiG5N84nY?=
 =?iso-8859-1?Q?tS/yUv8w6Vsqa8CAOoh8zIbEdQBiJmEeffgroM3exul3jgv5rh9LFIwXZz?=
 =?iso-8859-1?Q?bURRGj3ipfBUKpzDywbIPcALamzxbexXmAlMSQxBtQx8tuhqzuXSYVDxmU?=
 =?iso-8859-1?Q?FJTIcpcmMY8SON2Xwgkef1le9wEYDcCKqEH4JZAKRZD5VFewGD4HIrID/x?=
 =?iso-8859-1?Q?gwspmsb7pUEMoiRb9wS4fzdJ3QPyTOc2ybTU2QgiFyU0NFKTAqA6bWcgJ2?=
 =?iso-8859-1?Q?ayUzwG+4sNPqkNYEfXK1j7f7R2+gnKgGsaJbvc71m5m1Ztx71AwrxSoIoG?=
 =?iso-8859-1?Q?ZMBm4Zc1W58w0+JxV9tz+VEPbshqp/oJy1ENsgaQIuYfnGw8RGknaoZHOj?=
 =?iso-8859-1?Q?4U6eudACP3f+YAMCAffged+i0SU9pykZOIhAN6ASZkYQ4cy67I/HXv2jUp?=
 =?iso-8859-1?Q?rz6ALTrUBIC9y75L9euB/26LR5uKVjBWr19mOo/5tt7s7ELUp/oJWRLqDk?=
 =?iso-8859-1?Q?k/pHzsU9vV+zpdBAzi+rTcipxznhdiD8AVl0n9T3MIQB39UBvLHiCnS7dJ?=
 =?iso-8859-1?Q?RqoV5VdK1o0SdaWxKev3691Y5mf3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?htQEOnRXCFx4H5ILqevusA308VAWACdUe+/Jv3G+6W3iea/ZKITCzaaJOT?=
 =?iso-8859-1?Q?tnak0nIVU92sdci2XSmATUnwyg651PPWSwSdY3+nA2UTQmJvWYFWiX3En7?=
 =?iso-8859-1?Q?ha+Sy3329ltOs5qoZJCQQhZrHmjrrlx3seGjXhTAKDa5aWKi5rqXAPOoIi?=
 =?iso-8859-1?Q?imOhVREY4NngF3Tc6GRVpK9BaTY0JsoY+Jz6JforU835l4jUIWDWCX2rtB?=
 =?iso-8859-1?Q?3Y/qCMCQtSS7pXnQbc++C0CIaGGEcMiv0MIOYOXKWsgPGn00SfnoMnoMyV?=
 =?iso-8859-1?Q?vXWy86SZb5SBNCbuWqa0XVWE51SZHnbCaEnsod1k0P8/FKv6VCbLO/vS2J?=
 =?iso-8859-1?Q?o46pOEKwWUdSgMIOnHSdViiS8hndPtkTYzToL18Y5/xbyztuBMEDHtkjnJ?=
 =?iso-8859-1?Q?45wU1bEX78z9nyYsfJFrn5kicngaKVlOteXsiNTE+6/WP8zA5pQxwRh2El?=
 =?iso-8859-1?Q?2vUIYYX+Ik5CBqhaRAQCPjRtKDPaFqM7YXyOnBcXxYC9iZbKQ8RFNfPKhb?=
 =?iso-8859-1?Q?FdQCl82WzF0Xy8nQ1INi5/FwKi6S1Gd7z+mBv55AuhFS3UgDMfVrmKAtcZ?=
 =?iso-8859-1?Q?x46is7Vc0BCP/M6hmSzjocArnIlm6IG27jXDzcOPeHKhBo5qOxOVXVZpOW?=
 =?iso-8859-1?Q?/Ba2MKgFoUNPnNOlw4ELgGccuZNHYhyxo0NuUQJZ6pJ6ek5fP4mKKAp/Ua?=
 =?iso-8859-1?Q?kRs/q7JziHV9qH4Rn1bGz93ZDauzE38fheePpBl/aCUUPAesbu8LOGZPoF?=
 =?iso-8859-1?Q?wGsQvCh8rHe8ZMmWgDo3Xv61Wke2ub51uGYqLIbdg4t5wM5Wdk1kG48Hyf?=
 =?iso-8859-1?Q?9/dKPvhRvcIBiUcEdjVrR2ZKUhMYjwAlzy26nVuNqkuYXXnn6JVPrhPb3X?=
 =?iso-8859-1?Q?fqQRXqQ0rk6kGzO/vsl2zq4HKPmfEmBYnFWxRAh98udwaPkLznc5+yYZxx?=
 =?iso-8859-1?Q?OPM3JOfD7oGjB5s2+0P2mfAmGofu7BDmR8cNv59cM9jg/BFIY02axAS7Ez?=
 =?iso-8859-1?Q?LCnYUuwL0HrGqmkGpr8pl1lWSgHK3MmHZxNitDavhI1m/Ir+1zMNPQYj2X?=
 =?iso-8859-1?Q?+yp5EVinGQGo+lCyOO8L3yC9Kq/VM1klYUMwhnwsyWNUosFupl59uoJohS?=
 =?iso-8859-1?Q?F0b3ZlHr1Rihqz4WQLRIaJh8tEU/CvDjb6vuadlCMhuN3gTTk4Vifn77h+?=
 =?iso-8859-1?Q?8RyhVV8Hy1g9Qoq88gN1yNvbFO64hLdmlGMkZwCHBoW4sb95BsHOW59jnW?=
 =?iso-8859-1?Q?WT5qsM8xA9UAtLzFOUmn/nIMUoa83AfXz2OVSBFMWk4r0zy/J8EMDMMAuU?=
 =?iso-8859-1?Q?v77kqb6DZFQz7mqB/vfHStMReMQWLYX73lU05WOgySqqtclPa7M8Z66ZFs?=
 =?iso-8859-1?Q?WfjHwI5M+AkPV3FPxHsF/bD39z1hL7jaJgqLCQMlWdYp0w8s5CcRPQQOVS?=
 =?iso-8859-1?Q?PEY7DAUP2/BEtcTLZZwX2+/RJ4FUrmxuwTBjLEBrK47XIdC3WlNivvxB/9?=
 =?iso-8859-1?Q?lGRMsellk9C1/uw0Y/O4JUyXLWrfDt95AVM6b5XeRbNKILDcne+uPEB1uc?=
 =?iso-8859-1?Q?bPhKRWudnG0/FtilJz0XHszKog7PW01ZJ7fzkZHgWCfqUlKfi18Ex1MJQt?=
 =?iso-8859-1?Q?e3rphO8G5Lo2ePaUvQWSY/z3m5cpDsZMw1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88841074-9abe-4e59-fc36-08de259080e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 04:19:30.0878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDG+oMhN8R/AlboMu8+bGh+mqoK5IbT92Ypmz9XaADWaJRsUeGdU0L0gOsZBMGd5FedZNj2BJFI4yk1/sD/rp+Kjns73c5hjbNSP0rLUFcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6915D992B
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
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

Hi Akihiko,

> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
> associated with VFIO devices
>=20
> On 2025/11/13 12:17, Kasireddy, Vivek wrote:
> > Hi Akihiko,
> >
> >> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for
> blobs
> >> associated with VFIO devices
> >>
> >> On 2025/11/12 13:26, Kasireddy, Vivek wrote:
> >>> Hi Akihiko,
> >>>
> >>>> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for
> >> blobs
> >>>> associated with VFIO devices
> >>>>
> >>>> On 2025/11/09 14:33, Vivek Kasireddy wrote:
> >>>>> In addition to memfd, a blob resource can also have its backing
> >>>>> storage in a VFIO device region. Therefore, we first need to figure
> >>>>> out if the blob is backed by a VFIO device region or a memfd before
> >>>>> we can call the right API to get a dmabuf fd created.
> >>>>>
> >>>>> So, once we have the ramblock and the associated mr, we rely on
> >>>>> memory_region_is_ram_device() to tell us where the backing storage
> >>>>> is located. If the blob resource is VFIO backed, we try to find the
> >>>>> right VFIO device that contains the blob and then invoke the API
> >>>>> vfio_device_create_dmabuf().
> >>>>>
> >>>>> Note that in virtio_gpu_remap_udmabuf(), we first try to test if
> >>>>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> >>>>> use the VFIO device fd directly to create the CPU mapping.
> >>>>
> >>>> I have just remembered that mremap() will work for either of udmabuf
> >> and
> >>>> VFIO. That will avoid having two different methods and make
> >>>> vfio_get_region_index_from_mr() and vfio_device_get_region_info()
> >>>> unnecessary.
> >>> IIUC, the name virtio_gpu_remap_dmabuf() is misleading because we
> are
> >> not
> >>> actually doing remap but are simply calling mmap(). In other words, w=
e
> >> are not
> >>> expanding or shrinking existing mapping but are creating a new
> mapping.
> >>> And, for dmabufs associated with VFIO devices, without having to call
> >>> vfio_get_region_index_from_mr() and vfio_device_get_region_info(), I
> >> don't see
> >>> any other way to determine the region offset.
> >>>
> >>> So, I guess I'll create a new patch to do s/remapped/map.
> >>
> >> I mean calling mremap() with 0 as the old_size parameter. The man page
> >> says:
> >>   > If the value of old_size is zero, and old_address refers to a
> >>   > shareable mapping (see the description of MAP_SHARED in mmap(2)),
> >> then
> >>   > mremap() will create a new mapping of the same pages.
> > It might be possible to use mremap() here but using mmap() seems very
> > straightforward given that we are actually not shrinking or expanding
> > an existing mapping but are instead creating a new mapping. Also, I am
> > wondering what benefit would mremap() bring as opposed to just using
> > mmap()?
>=20
> As I noted earlier, mremap() removes the need of having two different
> paths for udmabuf and VFIO, and make vfio_get_region_index_from_mr()
> and
> vfio_device_get_region_info() unnecessary, reducing code complexity.
Sorry, I should have researched thoroughly before but after looking at the =
code
again, I don't see how mremap() removes the need for having two different
paths for udmabuf and VFIO and make vfio_get_region_index_from_mr()
and vfio_device_get_region_info() unnecessary. Could you please elaborate
how it can be done?

Thanks,
Vivek

>=20
> mremap() is also sufficiently straightforward. The man page explicitly
> states it is designed to create a new mapping. Using it for the purpose
> (not shrinking or expanding an existing mapping) is not an abuse of the A=
PI.
>=20
> Regards,
> Akihiko Odaki

