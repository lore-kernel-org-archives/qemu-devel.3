Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36661CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 04:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5zgD-0006VQ-2U; Tue, 07 Oct 2025 00:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v5zgB-0006VI-Lb
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 00:52:03 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v5zg9-0006NV-GI
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 00:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759812722; x=1791348722;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dW3jLLGThyTWTiGENZHNOufG9ZcQUUTBrTW1JzkIGDk=;
 b=SS8R+UijcpCdr1r686x4/liOUNgeHdrHgf6cEiBlxfDRNAz6WWylqO+c
 8LVVQwbuJR7ncZO+y/fi9zZ3vbueTa7Ij7LMbPYR+j2Or2UJETj0/HzaV
 YFK5wWqpktpfDFR0FN9cy9sO5a92ccyENw0Bd3Nu7eiA6aCZHg5a8VuoS
 5+iyA4/RUseETgdptXtE3ElBqcpR6IXH2zQZA0pM1UpvOFgLlF23t9S0y
 FkKTfnUaKmcmFN1ZuSfA+hFVHRqofNgtUmlZCDjGIyxcmkJtBQlgrfno3
 B3EHrxgsnP+btjsXP3dtX8XqZcCnJsXDhExb3n0VWmvzfl857MjSQ2rJT Q==;
X-CSE-ConnectionGUID: yw0CmvR9QxO1/ZekVKMqvA==
X-CSE-MsgGUID: l1JSgla6T4uFrXOazXM1MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="79640016"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="79640016"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2025 21:52:00 -0700
X-CSE-ConnectionGUID: MykTvKTcT6W1WbwHGW4Cng==
X-CSE-MsgGUID: qzHWR4zaS+OWcLytjzYO3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="180850532"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2025 21:51:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 21:51:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 21:51:58 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 21:51:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzjrVYm9oa1ouw4c1J2x8Uxmtx2L0vlMsZObMB7g2L9eb6g392suVpsgAeXjy6SrgXRHbtl3B6JAq3oFwSZIv/Dl2x8BWqqifC4W3uwkITzBaeLqzo3jSuYXzucx1pZFx19CzO/9LzAawd4qHu8W75M4G40MyFNazgofUk0XfO85tx8rcePmI1nMCfSgwj8DJxIs8rep5Gn9te/1vTjrqwHfpgCJ4Yjj5vZaiV0pMF8PQp5WELYyW20yAwFALXXIOn2uwNsc0fd3BeRMLh6O9+JneyuKVNw8zjjt8NleLqYza8U/4NtyH5SEHJNPgkHXzIFz2EcmBjua3rHcleoobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/MGkv2KHhuzUtbzzxr7q2jb8iw1UvrVs1Z858KA/Tw=;
 b=j3qjldWPv1wdA1vOmb3yNQcM/jr7dObZ3aIKA6L08G9xilpgoAg+3RQ12LwFytjYpZeyZ0YZCjmLbb4vo9Vi0dSBkCCKMAuRe19NC5Yak4Cnq3tHgk6MVJoPnrgVuwmQUQAfdiZqZEeMDtQUThA8hERQQjFqJ3ZKpmpZFv9KLAD4ceXuzrgift6tSV1Tj42Fcxne4k1cr7I3qTtXwov4kT9EoGuKaMAHUElfEPoPUUuohUDuR9KmkF6Dms0us444cgpNpvlWS6wkhSgUqTIG9nHZgiU0iCMlAoswHGHTKdq6BveVQkx3gnHz/gu7v9PMlFEfvVMGwscVUNh1XcFxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SA1PR11MB6566.namprd11.prod.outlook.com (2603:10b6:806:251::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 04:51:51 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 04:51:51 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson
 <alex.williamson@redhat.com>, Leon Romanovsky <leon@kernel.org>, "Leon
 Romanovsky" <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, "Kim,
 Dongwon" <dongwon.kim@intel.com>
Subject: RE: [PATCH v1 0/7] vfio: Implement VFIO_DEVICE_FEATURE_DMA_BUF and
 use it in virtio-gpu
Thread-Topic: [PATCH v1 0/7] vfio: Implement VFIO_DEVICE_FEATURE_DMA_BUF and
 use it in virtio-gpu
Thread-Index: AQHcNL+QUUZCsF4ZZESi4ibLnnA6/LS1QlUAgAC6XTA=
Date: Tue, 7 Oct 2025 04:51:51 +0000
Message-ID: <IA0PR11MB71852ED5F080865AFF5FB501F8E0A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <6aae1d93-f531-4550-95e5-07f91b432aba@redhat.com>
In-Reply-To: <6aae1d93-f531-4550-95e5-07f91b432aba@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SA1PR11MB6566:EE_
x-ms-office365-filtering-correlation-id: 40f8c7a7-b265-487d-02c6-08de055d3af1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?xqeIpSsS/i+kTF7VX5ZrrqsYnuzSEDFqsRxT9ijZamykcYvwA6nCrIOmTp?=
 =?iso-8859-1?Q?BEJ3Pqe/AynM9tjeIYISjlKQ2J36lw1rPzuthJ+VG55dSwCEL5R8Auoxmq?=
 =?iso-8859-1?Q?1EPwoMY+Da/2rhDXm4Nb1aL3uyi28d4VS9veMCXMoGk1d7W0nPnqBVAoEu?=
 =?iso-8859-1?Q?3kjmR+e/8ihIUI7DFgMnIHtCRyPzk38m42pfMQzuwbc4Pvtu0EAdbZpfII?=
 =?iso-8859-1?Q?99/Q2OpFWQYIEo28To47e9MTfNH3MxT4kp1HwkGOk+eCxIufcWkwqt3ziF?=
 =?iso-8859-1?Q?9xRPW0XvvGW7Dxmn9SZuOHedL1lqfS4JmohsKeiooPrl/E0nmfxS+Pjqn7?=
 =?iso-8859-1?Q?ADknwaIyivp+kFS1V9L836DqCnyVjfvsGTst/jsqKQMSgctnzHT8XX9On0?=
 =?iso-8859-1?Q?fWbQj2LqJtk6XgfvfcETGEJYYFOkgmcvGryy2db0tKscKjrVlrlQbd2k7w?=
 =?iso-8859-1?Q?j7rXVWwlmkc6G6s+/If/4w8qXDyi9hPZ1CZ1QvwMxadd49LEQiikk4TYQx?=
 =?iso-8859-1?Q?bCt+lb7LUmXZw3LRpXKIXEECd/hK+Cg7qFHsGJkz5WyGF3ggI4F5jJVBbM?=
 =?iso-8859-1?Q?FmzqXh6QvnyCYW/Oq9P/A83ziV3jwhukAOT105IrNmBE46GkV6YB44R0g+?=
 =?iso-8859-1?Q?2MjCRnjtlojHNZ/IVPZB61rpn7OpIUK9sqo6ffdcAaRaIBawCw1AKU4uqy?=
 =?iso-8859-1?Q?qqJJNedc2SuVv2jK0aZF+DoaUp39IMV2ufGn+q2M5mE1Zv7VJ4L+8RGg6V?=
 =?iso-8859-1?Q?0QOiQ69pv+JD3yp/s29hOuG3k2aT23l2pcaNUD/UlXbvNfRidvlza9UGrP?=
 =?iso-8859-1?Q?jBWEanazf27HHbd6hpLXDmUBxzLHEyFbinvGhSvU9cp78D8eoL0REf/gGZ?=
 =?iso-8859-1?Q?6+1vMekhVpToYLVnsOLqHRU6daP4tfwNP5L1V98T8WVHOCLbYoL3543rlK?=
 =?iso-8859-1?Q?/iBd9rLXWekzQjmEbnSZkzIdnWgMJ/COl+2SRil6z/qrpELOa8+qnNI7ZT?=
 =?iso-8859-1?Q?oy6k89EiMNb7thLjKvBA1vXV+oAFt3uSEuUKpqSoFrAEpFASbbGf3u2ALf?=
 =?iso-8859-1?Q?uu0F0x9TfdMYMLjnQVRsjFZhuGHGrere6h5WHIugw0ASFa0cOUlWp9rW+C?=
 =?iso-8859-1?Q?4vn1t5GmuYebM62hJpkGuUx35ZMV5VngkKuZtlPOXirj+iasF3G9FECo9O?=
 =?iso-8859-1?Q?QS0sc/bvvw0cG+B5W8RkjacMFhjjmhZojjuKmllqcGdHyXb+3+AMsrfk07?=
 =?iso-8859-1?Q?h+hvClvgzHFWIE2qPQLh2RX0Lv56wAJfEjIW3G2Y9JDcLbpS9hZcYjZVFa?=
 =?iso-8859-1?Q?p4n1T8v+cdKypKDA3HvQPAaNYAV4eJx6iyxhSfBEwnoCKlqgGQSiQHxdvF?=
 =?iso-8859-1?Q?ljtWzZqnmuM0VUKuXnxOiwo9L0B3PrCCeaNY0Wqgd8ZxOkANmkUyE6mmsU?=
 =?iso-8859-1?Q?ux816O/JKAPdkQU95WL1oLXTabtCOIko7sfYVMNia9jYIuDK6gKci6RBsQ?=
 =?iso-8859-1?Q?NxuQQ63ie4yb17EP7cdLWP5r1DJ/BFFJ6BzhRPR5wGfCncplv5u+31j6pi?=
 =?iso-8859-1?Q?MPwukAu+SWTfFFTA8LgkMlE2EvCmi5mnvHAuxCdHRn7QqSDadg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0fwOLGvIv6VhWHKmI2hlhZTGJESZzsBiLsNk5q6ULUcVVoyOyPsQGO5LkJ?=
 =?iso-8859-1?Q?EoFNLaB7Hk1IVbsT1y0585RY1Ym14VtoP9KwUI+ThRwvtMiRmMLLwEc20Z?=
 =?iso-8859-1?Q?bRmOikJLrAn2X3iv2OrWkK9VTtTUqVIeJWkP78iGomjg7y0JAwxUTUKDTW?=
 =?iso-8859-1?Q?rwxUxEegSjxvPz+JnN+G8MPMNcBs3XJ+W16cuSSCrjAHoeTi/M2Agyw+S5?=
 =?iso-8859-1?Q?Z/10a+XFqHR9g1sgun2po4yZHMkj7+Dul+cLq2gYFUAwx9dlzA7C5mwfLX?=
 =?iso-8859-1?Q?kxaAlEDh92t0sNQIKPN2LeN/tNaGLXsZYtdv5iTFx4NMx+gNLeGn+He5H8?=
 =?iso-8859-1?Q?c7MTpGdaeWgPtJI2K/k+25Qb0FUp6O7UKvWfsC3n1ZCL8mh+VpxQvOvcsA?=
 =?iso-8859-1?Q?Igk1BAlP3b+cFe837qKUPvqQUg6w0dH3sOjrgKw7OuCiRNNU6orpzyYza5?=
 =?iso-8859-1?Q?MiD1aY8wilhwCVjyJtPRKkRoWeFHvzI8kcSw7qU1OOQy4Z20FvDerbrwBw?=
 =?iso-8859-1?Q?hrSzamW3qNEIWDjni3JyNNrxANnVf87F2lCZJfAHsM4RyUMm0ZJ+Vs6vTJ?=
 =?iso-8859-1?Q?FRu8CCWNLeP0Gsmb8kGfpGV4SJa1gh5dQoXRuFhfRC8qQbSCBOGm4VNDVU?=
 =?iso-8859-1?Q?EIl9jrXNxG/Y55WygokGiZCX0ydFXAk+FRf4jSKD30jmGRU0zxEPYmRKWq?=
 =?iso-8859-1?Q?iKIy6oHZjf5ejcNubull7EGtGC/uEOaJ+koDpUKv3E9cg261sTVk4w2Qn1?=
 =?iso-8859-1?Q?AXK9m1SyPVZV9kM7o1JNwXbPkBxepnTHT+28TrJwGSA1Rg36Myv7zyrwqP?=
 =?iso-8859-1?Q?Ppkc7aZx6ae8ivwDs+o6amFcO9n0u+VjV7R4GnFo42BwSV7gbwvTqMRlR6?=
 =?iso-8859-1?Q?yjqP+cOLMXDPhRPU29q05copAO0T9uWkUD+lr/Sjc24PG+DkgjxQdF5HqO?=
 =?iso-8859-1?Q?pWsIGv8LX3XaE7In1CiviV3nEZLpXEu9H4m1oBWp/vN5a+6O+4YXdNQ3C8?=
 =?iso-8859-1?Q?j/KQJsQvIUkrs4xeLOH+WrL7tNKTsTo5QGusOaRf1z/9LhbkQ7UN4w53zN?=
 =?iso-8859-1?Q?AC7vdrj3iIIzMy8vxLICsHYtJTFYzs+/fnyV+jFy7qKj8XRU7ikmbx/1VA?=
 =?iso-8859-1?Q?32zK5YSkt1E1zSCZ0mjmpFPiiB5rhCJErt2zXwUsyJJ4DE/ju0t6J9EyIm?=
 =?iso-8859-1?Q?wf0J2AgWFzxHmKW5M8STQWdTbFqLj1Xy5iUSn1iy2DW5D8DO8ucfTJBpns?=
 =?iso-8859-1?Q?imP4Y+o3aWSTfXZfytWzi8k81vHMev2jm/x5KXhQloPPS3Ta2ZRZXqIKX2?=
 =?iso-8859-1?Q?UToIzFEgKEy56eEG55ExtjSHzPHrF2Qt1XoB9OqIPGBRY2upinFt1C6O4f?=
 =?iso-8859-1?Q?XKU3hL+WrkKtgdhpyzucJD0EnKbxjmreib0FSoI4IDN3TzJxaoW/q2BtX0?=
 =?iso-8859-1?Q?hadxW1/apIYw6y9G3T9hOS6TXRoAInS2lXcJ+3wBJbEToXWrpGr8GScntA?=
 =?iso-8859-1?Q?cvnU1C4AMZ53VJVmksf6Pe7Kr7sSK5I9Dz8D4cyXz0SH4aAtP+YKIFma1B?=
 =?iso-8859-1?Q?VNJcgCHDIbqSoB3AI2dnSXCxdRjNTlZr+prK7xJZLfgaNP8ixsiEONL6IF?=
 =?iso-8859-1?Q?yHJ1pU4isl9ZFeXk04hM+AS5AaWZ4CXWIW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f8c7a7-b265-487d-02c6-08de055d3af1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 04:51:51.2082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OJdnhucz4PP6sm2bXMOW9fdOg/hReOge/VMwpBKcYklTbdO5sBbDPjW4uxkT/JoRG4JA8nnDxbfs66F7lfyqvSgFqF3PHmrJHCxMtoKbw3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6566
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
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

Hi Cedric,

> Subject: Re: [PATCH v1 0/7] vfio: Implement
> VFIO_DEVICE_FEATURE_DMA_BUF and use it in virtio-gpu
>=20
> Vivek,
>=20
> On 10/4/25 01:35, Vivek Kasireddy wrote:
> > The virtio-gpu driver running in the Guest VM can create Guest blob
> > resources (by importing dmabufs) that are backed by System RAM. This
> > is made possible by making use of memfd memory backend and udmabuf
> > driver on the Host side. However, in order to create Guest blobs
> > that are backed by vfio-pci device regions (which happens when
> > virtio-gpu imports dmabufs from devices that have local memory such
> > as dGPU VFs), we have to implement VFIO_DEVICE_FEATURE_DMA_BUF and
> > leverage it in virtio-gpu.
> >
> > So, while creating the blobs we use memory_region_is_ram_device() to
> > figure out if the blob is backed by memfd or a vfio-pci device. If
> > it is determined that the blob is backed by vfio-pci device region,
> > instead of calling into udmabuf driver to create dmabuf we would
> > now call into vfio-pci driver to have a dmabuf created on the Host.
> >
> > RFC -> v1:
> > - Create the CPU mapping using vfio device fd if the dmabuf exporter
> >    (vfio-pci) does not provide mmap() support (Akihiko)
> > - Log a warning with LOG_GUEST_ERROR instead of warn_report() when
> >    dmabuf cannot be created using Guest provided addresses (Akihiko)
> > - Use address_space_translate() instead of gpa2hva() to obtain the
> >    Host addresses (Akihiko)
> > - Rearrange the patches and improve the commit messages (Akihiko)
> > - Fix compilation error when VFIO is not enabled (Alex)
> > - Add a new helper to obtain VFIO region index from memory region
> > - Move vfio_device_create_dmabuf() to hw/vfio/device.c
> >
> > Tested with an SRIOV enabled Intel dGPU by running Gnome Wayland
>=20
> Could you please be more precise on the HW ?
Ok, I'll mention the specific model.

>=20
> > (in the VM) and Qemu with the following (relevant) parameters:
> > -device vfio-pci,host=3D0000:03:00.1
> > -device virtio-vga,max_outputs=3D1,xres=3D1920,yres=3D1080,blob=3Dtrue
> > -display gtk,gl=3Don
> >
> > Associated vfio-pci kernel driver series:
> > https://lore.kernel.org/dri-devel/cover.1754311439.git.leon@kernel.org/
> > Associated virtio-gpu kernel driver series (merged):
> > https://lore.kernel.org/dri-devel/20241126031643.3490496-1-
> vivek.kasireddy@intel.com/
> >
> > ---
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Cc: Leon Romanovsky <leon@kernel.org>
> > Cc: Leon Romanovsky <leonro@nvidia.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Cc: Dongwon Kim <dongwon.kim@intel.com>
> >
> > Vivek Kasireddy (7):
> >    virtio-gpu: Recreate the resource's dmabuf if new backing is attache=
d
> >    virtio-gpu: Don't rely on res->blob to identify blob resources
> >    virtio-gpu: Find hva for Guest's DMA addr associated with a ram devi=
ce
> >    vfio/region: Add a helper to get region index from memory region
> >    linux-headers: Update vfio.h to include VFIO_DEVICE_FEATURE_DMA_BUF
> >    vfio/device: Add support for VFIO_DEVICE_FEATURE_DMA_BUF
> >    virtio-gpu-udmabuf: Create dmabuf for blobs associated with VFIO
> >      devices
> >
> >   hw/display/Kconfig              |   5 ++
> >   hw/display/virtio-gpu-udmabuf.c | 143
> ++++++++++++++++++++++++++++++--
> >   hw/display/virtio-gpu.c         |  53 +++++++++---
> >   hw/vfio/device.c                |  43 ++++++++++
> >   hw/vfio/region.c                |  14 ++++
> >   include/hw/vfio/vfio-device.h   |   5 ++
> >   linux-headers/linux/vfio.h      |  25 ++++++
> >   7 files changed, 270 insertions(+), 18 deletions(-)
> >
>=20
> Please cc: Alex and I on all patches.
Sure, will do.

Thanks,
Vivek

>=20
> Thanks,
>=20
> C.


