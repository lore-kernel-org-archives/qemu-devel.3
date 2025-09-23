Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BA4CAC5AA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0t2Y-0003kY-5q; Mon, 22 Sep 2025 22:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v0t2W-0003jl-BV
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:46:00 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v0t2P-0004US-6F
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758595554; x=1790131554;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=390/z/73CKtcBKL0HQRNVccHTS3uM6N3at9bRdl73Y0=;
 b=fnJbAuI2XIDLnqoZpflCBi56yz30tHf5CyjsmGJLrZQKtt+xX1Gcg1Jf
 yl+1Zc4kRF/BGds4MejG4C+UzDtByAMg7454heoo35eZgtnIdwyuKWHrw
 DZ2Xlr5pAVxcL/J42YN5d/gGDA6t95EQxg3uWalGaNTBIlrimGi1DUtcr
 IiI0/o+r/8I+so6m6zrCdgtNs/I6YYLIJXPMeAj2GJgBW9X+rkApNaty5
 7Jyxir23nm1QCTZcX4OFLUBjkmkcXLqJknZgYdgQ6/VeIz/Pk4pmsnyET
 xkmK7AdHcH3klfv5+1bD5siAzzt2t14NjjNJbXWvT0iehYBugOSeKdOZJ Q==;
X-CSE-ConnectionGUID: gmborsLsSna47IMKVpuGVQ==
X-CSE-MsgGUID: C/4D61d/QXC96BASCY3PLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60783032"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="60783032"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2025 19:45:48 -0700
X-CSE-ConnectionGUID: LO+HtSACTX6Eea4GMrig5g==
X-CSE-MsgGUID: csIDiTf9RzGmDJazFnz0XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; d="scan'208";a="181887932"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2025 19:45:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 19:45:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 19:45:45 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 19:45:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J60q7QNTAge/EV4iuoWHua0wlnFn/HbVLH3J6z2bH9T2N3mXzRhWAx0sWZgMZ+3810zD31LqQ+rY9TbtW20aOSzyhv19QbDjHAyDMlLerdsGbzVmihiGG/G2O7W94PWMtZPPrdbypXHTP1fAbjkzgGWASBXYFCTLxwXXyR5XoArw84TqRv6xHZQl/VnagmW9tgk4ytbiUHbBJXwnB605edHJhwbIv+Wsm2EmrBq6aiAeHsU5eZ1mJ0SGog3DfixZlaNWsdxc66vjVijmuwWzLkk9xyJ+Ytjqb4yI/yB119VYyxlkHwNKVWNeXAVubwtKw3CgEVeaImHPr5t4Ion7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XL111GwprGny3alX6kVFe9lD1U3ddmmPYUu9t/uftMc=;
 b=vmSt1R0pfRU4EDySoRYU1Getf2JRo04KvkzfAGBbHFqdPTEUe7hC+R5/CQLgPsabBdSmlsiS8GJnjhSgj63s8G46zDzgDJb7Be5MqcTgpOZlyFsDT6Ur/cs5ozpox4TE0jDjAEjxPCRhaszZ2b8XRamD2f2oFwwbOp0qsXcOnr3oixQ1I04ELXjx4cuaBpy2Jf3KabV5xjZan1zcu3WsvR2eOtNGHErrZAbb/RmpdNggXc25uVI44h3HPajNeeD5EYAfpat+T+SWZnRh4CMI6sXKJMIPIEiIhrfhdbM3L7swkgVwTJlOEUx4mjSjq8LOu2zJFr21deBpUqBLeie0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ5PPF8EC896901.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::844) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 02:45:43 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Tue, 23 Sep 2025
 02:45:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH 1/5] vfio/iommufd: Add framework code to support getting
 dirty bitmap before unmap
Thread-Topic: [PATCH 1/5] vfio/iommufd: Add framework code to support getting
 dirty bitmap before unmap
Thread-Index: AQHcIfvimBrBaa+XB0KbskuA8pwIdbSaTDWAgAHZT1CAAsvsAIABMVsw
Date: Tue, 23 Sep 2025 02:45:42 +0000
Message-ID: <IA3PR11MB9136A7B487A547CB5EAD9FEE921DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-2-zhenzhong.duan@intel.com>
 <ee5c9d7c-a85e-4da4-bd5a-a59951a19a06@redhat.com>
 <IA3PR11MB91368AE2A58185BE00627E149212A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <e0a2c3f0-eb14-4d06-9658-23208ee6e870@redhat.com>
In-Reply-To: <e0a2c3f0-eb14-4d06-9658-23208ee6e870@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ5PPF8EC896901:EE_
x-ms-office365-filtering-correlation-id: bd24f70d-c615-428a-895b-08ddfa4b4a2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bdjTOIlgBnNfGTm1mXcgHF5XPrf+de78DQIOwAE2562sBdeZxxR8OECMq9?=
 =?iso-8859-1?Q?R+Ed4bQAHIhMwqp8U8r+jReW5Kih+H8EhTwVBaK/ChP7OkmLDSzok/q7cl?=
 =?iso-8859-1?Q?EUeAl8VJMunBz2WHc9mFytmJYHMMC/MRWNVRzczam6OaDKV9fTy8kHFXjt?=
 =?iso-8859-1?Q?jTVJhIHFrVShJfnngYxT+blnXmE4vteJFvIg4LpOuBDUbzxzgk0B39IRCQ?=
 =?iso-8859-1?Q?TsaXACLWWwgxEptDQ8AQYFZPWQHaosZG8W3EEkai2PdXvF+AfpXavUphMF?=
 =?iso-8859-1?Q?8Fdas3NPBny/4lvJH9k2bQyGYjzACI4jLNBrRRAUNrXNYnbjRi0PVKwM8F?=
 =?iso-8859-1?Q?W1Hkh71hOVt/YKnJllmjAQFGcuTBqaIWDuLGL+dx3ApzC0h+COQrN0vMt0?=
 =?iso-8859-1?Q?YRDizW6FUTtgipulMmj20v+C01fAbED7g3jQ8mx5P25AKGlFybpcJNwJ3v?=
 =?iso-8859-1?Q?N9AfUvInwn+lEAMjDljhsICjrFxcNV+nDpoh1xBAbQOrXtxFiSMCys+tbr?=
 =?iso-8859-1?Q?XHqauxT42W6Rk+SQtI3oypjnjBV7CaVi0r5AtVs5obsqWmSvmv3CNTJx8q?=
 =?iso-8859-1?Q?QnEKzceA6ZpO6MV4G9W0pdNvtga/RBVF5fc7s1cKPHXRYUyG9dPhRUZa0Z?=
 =?iso-8859-1?Q?yYMBnsx72HFRP/6zDF9kh2WQ5R4RaxoqvvYyTZi5ZAW3uBf/VuVM43YyQF?=
 =?iso-8859-1?Q?VfZ98cetl8Zu/OkSu+y8bOKX7dq9XoQc79m8GElyfQJqtdNi1pwAoNN8TP?=
 =?iso-8859-1?Q?f7HAS0m5MTzreIufXjLNGNsUwS5HCLaXkIAQ3NYlU0wOg/wYugzDZKHaN4?=
 =?iso-8859-1?Q?wBLl1GcYZ8/26/xzNxSiQkwrrIpRo3Lq4w3YPMgK+s/VT2zyctiG2bitv1?=
 =?iso-8859-1?Q?6HiCDJfJaU83Lfs86AyLRL68d0cjJByraqlkTy25vNobVXPW/iIQxphqT3?=
 =?iso-8859-1?Q?9rXPBbXAisYwB3s0oJfET0tKBMvZk64Mv3Mhwf2jjL7MnMJM1QFPh+L9U5?=
 =?iso-8859-1?Q?CYM8tztM2aMeCAKGnFAi80oz4HdaBt+0EeZMSCHtmIAU0+C8BA5di9p345?=
 =?iso-8859-1?Q?O1+KMGYut2zhKO1bWglXXlE7LrcGh8VFVHGG4hYhKsW8uIhiLve37QTrWR?=
 =?iso-8859-1?Q?iosjP0JMHdxk3I8Ni/bSqCQa2a2iSvmtjUKUuNFyP7aTy3bHBlp638y+Ew?=
 =?iso-8859-1?Q?jeZ9mIPW13jObTnNkBBDP4jJHu+gDYDMo1342tHtEizU7lyHhrdXhZRcfM?=
 =?iso-8859-1?Q?mILBg9RLGkZg1JNMF9XAljlQLg6h+36WXXGv1cH/V1zRHdJocPLgmhFk98?=
 =?iso-8859-1?Q?iie8KcnGgRGR4jhh3Qr9i+vheiJlBYo75BjhANJsp2xtIi7z6h5Ga2lkWh?=
 =?iso-8859-1?Q?G3sMPfiFoO0gv8Q07O3zLUlpiI4Ed+MgXROCLKsvJE9qiaU6jEy+JZ47ZC?=
 =?iso-8859-1?Q?e7/XYoEsXy3cuvZEBPTohDu2DtpOpZg4WfVefLvUaxoxUvllOMRqeLqMcW?=
 =?iso-8859-1?Q?XiyW6kQ/34Cbq51ekQp4noyozr54MCdonzuRVHyAgqHCPHe8dCnkZPowX7?=
 =?iso-8859-1?Q?53c9xN8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ukEB8CHb+dLuz8RKg3TW6HLdi06Gu/b2li4PD6rjF6Ss9NqNt2wseUlLF8?=
 =?iso-8859-1?Q?4DxAlArwmvPUV0EYASbEtsO4BST27KtW+vSYa9IHZjYX0vdTqcTYv5yFlT?=
 =?iso-8859-1?Q?gEe0wSA0BPudFrqoYEhjpJF0Xn+k9CAbtVQ3GODX1XXcrxSCNmCD58pJ4k?=
 =?iso-8859-1?Q?fGEG5B6yYBv3Oao6odd/I2UUfLP1XhrDyw/9gZvwrfKSpuwszYqLXk6gWL?=
 =?iso-8859-1?Q?v5LmgL5Cdxt743rDmduihSt0LR5tLGqbL5kIcwHuvbYO7OGhXIFjY5I1QM?=
 =?iso-8859-1?Q?UUt/gLKAWlOZGC5R7Wb2d8bo2ZE4Bcnard7zhntPEquWCg+dRoH1N61b4K?=
 =?iso-8859-1?Q?hZCcqna1B6tORB4kEzgugHrkWqp9a9I/Mm2YClAkINowP5c2xl1qT+Vru/?=
 =?iso-8859-1?Q?KzhxxLNAdnlGgthMKUNoChu282kU7ShOr1QxHl3PtncVN8gsoukTvr9EdE?=
 =?iso-8859-1?Q?zB9cVEV63G1hBzRTaY89RkWVlftZJECC41LbbHqYJNAknk6Hkho3pPHuV2?=
 =?iso-8859-1?Q?zRIqNHxO/Is4EHnmI98iYWeA0E5jBc0rjr/xvRiAbtsixPDK5ePui9SLLL?=
 =?iso-8859-1?Q?7pgAjoj1D1c8Qn9kQtoQBtABgG0wl7U086kH7e3O2MQ7q8UK5x5dklpJda?=
 =?iso-8859-1?Q?FwTbFSiEkVTrGYPTUUEx4WWUyTElEyIRRjBohxq44Ml9CarsP/9xKfm2zg?=
 =?iso-8859-1?Q?VeK89Z+n8tbDUcC3qYL03o1pnjCzLxMtHLUof4QYGJR/ywln0shCs3KRkN?=
 =?iso-8859-1?Q?UZNJr+zFujK/KjsHTdmEeXqfvSyThygGf/6DID3062i2DNPolI5VBqBzsR?=
 =?iso-8859-1?Q?zjAFa2qcH8SMFnlthloA5CYfh3FfMT4LJ0OuUI6tVESPpRlKG793HTks/7?=
 =?iso-8859-1?Q?5KceNyweGI/oAkLa8Fslz6wj9ydQRGAHEw5nuORC/j3vn1YFnDWP34JzNI?=
 =?iso-8859-1?Q?seabd4LrRIa9ur8tGoLlYrjj0wV0fAbBdyVkoRAOuoitfzbG3WiO3npJif?=
 =?iso-8859-1?Q?qjqC4N1CAcAvy5emd9FsRbAXuSDag1jd+5SffvA0vmySspqHJN9ZFHDS5n?=
 =?iso-8859-1?Q?RwMtXCxJPG1xy+0neGvwqlxvlW1CxOOFnEyrWUSwoiVRpZb3ogIzELbjxU?=
 =?iso-8859-1?Q?Xi7r1m5JwyLg++M9HI6OMs9rkNe1GVhRBv8M+2QzrYsaycWHKMbSQjb36M?=
 =?iso-8859-1?Q?aBQBaRV705UjC4qU9LANY6rXWp498zin2T9tg07ov4jL1tYQzLR60pUV1f?=
 =?iso-8859-1?Q?JhUSUVrgLICkABQI64rZye/+lzFmHhWQVgTdoey5oKZZudMW2IJCZqplVY?=
 =?iso-8859-1?Q?4YRyMESkaCxWKYY8RilAncDbD0VfafeSboJEU8Mth4scnEYBGX5a3BNJHo?=
 =?iso-8859-1?Q?FDH5iu+ujN535VzI9aX1UHfCiYJ/DjU6uyre6tRMzB+ssaFIlmj5kr5wDO?=
 =?iso-8859-1?Q?ruLcoPYqGjtS+1qj8Qp/oqDg1eK6Va+C435JDbWKf4f6b36QmGNNcF/K0H?=
 =?iso-8859-1?Q?YFqE6ShCaI4o3kjFn1mIAUvAsPTv6+RuUeF70zsJgCtdKYRKaiL63bmqHV?=
 =?iso-8859-1?Q?ydiP6U+FU1LM17L+QEy4PpmlANo8xJPMhg8zFwHBapuyfakS8q4B6SSMDg?=
 =?iso-8859-1?Q?TlkPw/l0hM218yqJt3nYk6QG/S5vlt7Z9K?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd24f70d-c615-428a-895b-08ddfa4b4a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 02:45:43.0131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8hkwZEjwYKGAAGTC41PlkHfys4sRhl2EerCSCpgQnQpuCIcMU/lax85yF/cMOBBwpV9eeRcBkkpIP6fcnUOvyE0CPmNI283gf4FMru1IU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8EC896901
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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
>Subject: Re: [PATCH 1/5] vfio/iommufd: Add framework code to support
>getting dirty bitmap before unmap
>
>On 9/22/25 05:17, Duan, Zhenzhong wrote:
>> Hi Cedric,
>>
>>> -----Original Message-----
>>> From: C=E9dric Le Goater <clg@redhat.com>
>>> Subject: Re: [PATCH 1/5] vfio/iommufd: Add framework code to support
>>> getting dirty bitmap before unmap
>>>
>>> Hello Zhenzhong
>>>
>>> On 9/10/25 04:36, Zhenzhong Duan wrote:
>>>> Currently we support device and iommu dirty tracking, device dirty
>>>> tracking is preferred.
>>>>
>>>> Add the framework code in iommufd_cdev_unmap_one() to choose
>either
>>>> device or iommu dirty tracking, just like vfio_legacy_dma_unmap_one().
>>>
>>> I wonder if commit 567d7d3e6be5 ("vfio/common: Work around kernel
>>> overflow bug in DMA unmap") could be removed now to make the code
>>> common to both VFIO IOMMU Type1 and IOMMUFD backends.
>>
>> I am not clear if there is other reason to keep the workaround, but the
>original
>> kernel issue had been fixed with below commit:
>>
>> commit 58fec830fc19208354895d9832785505046d6c01
>> Author: Alex Williamson <alex.williamson@redhat.com>
>> Date:   Mon Jan 7 22:13:22 2019 -0700
>>
>>      vfio/type1: Fix unmap overflow off-by-one
>>
>>      The below referenced commit adds a test for integer overflow, but i=
n
>>      doing so prevents the unmap ioctl from ever including the last page
>of
>>      the address space.  Subtract one to compare to the last address of
>the
>>      unmap to avoid the overflow and wrap-around.
>>
>>      Fixes: 71a7d3d78e3c ("vfio/type1: silence integer overflow warning"=
)
>>      Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1662291
>>      Cc: stable@vger.kernel.org # v4.15+
>>      Reported-by: Pei Zhang <pezhang@redhat.com>
>>      Debugged-by: Peter Xu <peterx@redhat.com>
>>      Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
>>      Reviewed-by: Peter Xu <peterx@redhat.com>
>>      Tested-by: Peter Xu <peterx@redhat.com>
>>      Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>      Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>>
>>>
>>> I asked Alex and Peter in another thread.
>>
>> Just curious on the answer, may I ask which thread?
>
>According to Alex, the QEMU workaround can be removed :
>
>https://lore.kernel.org/qemu-devel/20250919102447.748e17fe.alex.williams
>on@redhat.com/
>
>> btw: I just found unmapping in halves seems unnecessary as both backends
>of kernel side support unmap_all now.
>>
>>      if (unmap_all) {
>>          /* The unmap ioctl doesn't accept a full 64-bit span. */
>>          Int128 llsize =3D int128_rshift(int128_2_64(), 1);
>>
>>          ret =3D vfio_legacy_dma_unmap_one(bcontainer, 0,
>int128_get64(llsize),
>>                                          iotlb);
>>
>>          if (ret =3D=3D 0) {
>>              ret =3D vfio_legacy_dma_unmap_one(bcontainer,
>int128_get64(llsize),
>>                                              int128_get64(llsize),
>iotlb);
>>          }
>>
>>      } else {
>>          ret =3D vfio_legacy_dma_unmap_one(bcontainer, iova, size,
>iotlb);
>>      }
>
>Good. So we can simply both backends it seems.

Will you handle them or not? I mean the workaround removing and unmapping_a=
ll optimization.

Thanks
Zhenzhong

