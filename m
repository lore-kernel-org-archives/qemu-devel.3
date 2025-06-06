Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A97CC5B549
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 06:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNQIL-0008V0-N4; Fri, 06 Jun 2025 02:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uNQIH-0008UF-Tl
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:11:10 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uNQI6-0004Q3-KI
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 02:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749190258; x=1780726258;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3IvyQH1BNT30mtIS+aePqGlEPS13ivTmMo+bVaBwUWI=;
 b=OHnHxeEK2PoR1Sgjr0TODqirBUOKVMmKsnZ4+GhHzRk6aG2/KOjky/6K
 SejYf74brxfmO9UZ0D8Y6uDQBZcNwpqtfXVIxXZ28Tb+QQZ9/BehedRlL
 RgIBM3GAdbSSKctAUgCc/xVXn+xcxsWdrorzcbE0zdeTIZ9ZbPmfuggVc
 i496wMi9+7sOeuY8F9hip/xiTUrsoSec2H2lV/OMrHEkk2T63f1dTR0ey
 Tge7WAsRPtjv0GVwoW90LPw0VhWcM/AEKpnnm3uBfTb7Czbg/C7MNcmbm
 MmNNOnmKh5i2COOfThAVmFji3BBUaOglSQIthBlpd83lRtfNLEZ6qa8Ii A==;
X-CSE-ConnectionGUID: orkNadZZRrOMr29eQcoZUw==
X-CSE-MsgGUID: A31/3imJTQiw2QBShsNq1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="50561684"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="50561684"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 23:10:53 -0700
X-CSE-ConnectionGUID: OqA5rXQzTMuJAt9Pn1ZDjw==
X-CSE-MsgGUID: XtC/CtWRRR2+srMwyhKXQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="149571345"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2025 23:10:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 5 Jun 2025 23:10:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 5 Jun 2025 23:10:52 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.77)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 5 Jun 2025 23:10:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPoIXiqfR5KFzJQNIuM3dceXiNpoVJHjy9IYBsHbP9GK3AiZuu8cxW+YnVKo0EOzXF1IapGhDLRsHMvuv5we5eDXIVw3oeozkomB8Fr00gHNke12or66Nr5BLKg/JjR4vgMHp14bbJHsM1nBnhFKbpS8fxXCzerSQbjqZivISnpT7F0o0yjpLHZjw4ll1F0L/BqEwRO1wb1rHrX6XBL4e4/3Jz/oNy8f2oRDn0eUcbM6Yq2DtHdY1wHAQNM4WMLd8MchenBNoZ3x+fYo6oxHpf0SaVGmBXH2eNsYmG+XGqCMo2XSTRoex96amh7KBKUusS7Y1iIE1vUHyhWh3ounIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1J7ieBu+sJ6XEc0xL/JKZCz4STwNtvefdkuasIHRJeA=;
 b=fq2Q1WlK0UwaVd8o7jNj6dMwiG7vzZhGFaBNblii05gWxTzPRGIA+rP2AmpGwBYT1hUCxrBH1nD7XWcG1Z1d06F0c1vbSU6h1dcHvGJmD8VOGVSiILHcnDDlaLLlP8E++BXf96zLkYZY/o1f1LaAX7ubOESCKc/Bqh+JvoJE8v6eXfVt3mJdt4h+WGt766XAynMEX4P2KZzN4jewAR9tovMEGcBhMp/SPVlAQzfCXagK0NwENlxtMVKQnNhn56jUtKDsRPAurdkpnV9waZrnNF6IbXAFeL3KProZo4gY+WxGP3/yvf7xWjPI3lqLWSGAukXg4L8XYWRPLhIcmRpqCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CO1PR11MB4980.namprd11.prod.outlook.com (2603:10b6:303:98::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 06:10:32 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 06:10:32 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Frediano Ziglio <freddy77@gmail.com>, "Kim,
 Dongwon" <dongwon.kim@intel.com>, Michael Scherle
 <michael.scherle@rz.uni-freiburg.de>
Subject: RE: [PATCH v5 2/7] ui/spice: Add an option for users to provide a
 preferred codec
Thread-Topic: [PATCH v5 2/7] ui/spice: Add an option for users to provide a
 preferred codec
Thread-Index: AQHb0Fi8UW3vff7ct0Sn43ua8j5j4rP0SwiAgACmDjA=
Date: Fri, 6 Jun 2025 06:10:31 +0000
Message-ID: <IA0PR11MB71852C724D241204B8C09AF0F86EA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
 <20250529051352.1409904-3-vivek.kasireddy@intel.com>
 <aEFYnTvaDQ6Kd0o4@redhat.com>
In-Reply-To: <aEFYnTvaDQ6Kd0o4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CO1PR11MB4980:EE_
x-ms-office365-filtering-correlation-id: 8c9104b1-872a-41ae-38f3-08dda4c0d7ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jfcYBrvbXZ6b7EJgJ8musaRZ0JW21u++Lz2OQuKwoDKudb55tyyDEPpJhV?=
 =?iso-8859-1?Q?6qfLHU8bSaQe8cQxnUJkMGp0HC5l4SnGO9z6m1O+d1nqEy61abJhM2Swgu?=
 =?iso-8859-1?Q?LBWVDwOTKV7+u13NDkfWcpGAjMTd0cY47W1HQYJQ92/dTql7fSoN6bg1eF?=
 =?iso-8859-1?Q?5n8ODDx0apakSsUdPmp4Yll3DcFZrQot29PVoMmZfQCbR1hfETrVRkGYGK?=
 =?iso-8859-1?Q?t8QLnFeZvq+KO0p9YfF+fi5nDdLkKrkIJNvJp3Q+X6tKwcNDDlLmRtNlOZ?=
 =?iso-8859-1?Q?/sR8Tq/WxpnPx0NTuMERADZzN1qhIyRl68nkuC4Tfw3EJXGF6D0MkmNgXM?=
 =?iso-8859-1?Q?lO+8qDBzTpwkv1btC1kXn5YmmmKo6FG0U0wTVHBgYq/vzHj3PNi3uHu6t0?=
 =?iso-8859-1?Q?MR8YrJxCanDU8a2QrSydQt+Yw/UhzUIAs1qbtqLnlNmqdAqWGJIqSEPT8X?=
 =?iso-8859-1?Q?A5JKZebtOXXb2vAPNBAloJKu44eCXZatcL7NKxb59bN1urnAcnHZ6kNikc?=
 =?iso-8859-1?Q?viwDvumRBSmdt/LpkR0upNYQur9QXqOYOz97kQN9eG17fHLeOQcAFTvLBo?=
 =?iso-8859-1?Q?bliZ0zA2Z8F966xqUkEz9P8+2c0NC9dGtdtRDA2SQscnCg0Cyaj9DJOSQi?=
 =?iso-8859-1?Q?slTpRyh4bFtnpM98kaQxzh23nXmF4TXypDa34Lzhe1DzZvIM3kVvyc9EV8?=
 =?iso-8859-1?Q?KEu77w343zxQhzj9P39qwUPT+lb6pD4Br16lBsN2U4HSHrmilxmBPbOueU?=
 =?iso-8859-1?Q?qeRGpjlKAEnrw08B04Ukgsx9wdYzUYRxNTmSQwjyco0LTWcKjOstdYZSgo?=
 =?iso-8859-1?Q?R3MOXnCEwWfquqptPg+coqLsCAdYI9PzGB/CfWUpQwMIFcNA2zeQZkVjhu?=
 =?iso-8859-1?Q?t9ORG16wVqcyTPjWfnVZhC/VRW6BepX1jgzSdMQP2xHUa2CjEflM2Q+hAa?=
 =?iso-8859-1?Q?HV/1NFSUCA0V/HtvWRvcgIGFsJXcKmJlXd8Jypx1sHUUf3L1aDsyGpKUAv?=
 =?iso-8859-1?Q?2iPbrh1/VHWVzkMpKPPn8IaDNOdoQScXjSGHeZrJECAQ07I5uIItlaklq0?=
 =?iso-8859-1?Q?XR+I6htCkaCqoK0WrMwwaWgsrl8HqZ3tBbEFutPsbpugyVYDQEZ103HDfg?=
 =?iso-8859-1?Q?fgnoVnGNNTmx1IN3fqU7Mp1/gK2oDj+9vM910cuKsaJ1wwqfuuuvcP9Osc?=
 =?iso-8859-1?Q?kfQFpXhdGjn1L8pVswHH6wVuDEE5vstqwCS/qH3QX8dqEU9IEeDwJEvAzj?=
 =?iso-8859-1?Q?AU1I2MV804ZWgZ9Q/jYiQEBeNOe+wmaqDx+Q5RGzogXQhkGfDqyCfidPXE?=
 =?iso-8859-1?Q?BRTsGs2p9Qn3+abaCuk8Pc5Po3P2nKMk6D6imRyh1k8CF65ccmrH41irnF?=
 =?iso-8859-1?Q?J233Gu3VbFNDw+H2IJmrvOZN5I+SXui8JlPMXpQoTwYuC6VSbaIB9IPC5o?=
 =?iso-8859-1?Q?9sQ3zrxUgJ+3V1/QR0Fd6fWvLVMaFmw6lvX32cDsKCU5qMQN4MegosqrIa?=
 =?iso-8859-1?Q?A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HuJmWTFO5dFUCMZudjWSb+jZop3xXlTjjFX9FrLf8XhQlAo4XvtIkKnbBX?=
 =?iso-8859-1?Q?yNoIqZJkWuETZx0guO20+ahMni3QFmfxsqHuHItVpBi2wnNLI8wzYq0jpA?=
 =?iso-8859-1?Q?zt8j5zoipgnnn3a+HlWZVq/thDwmAu5AtQHauVyH0KFu4KGG6u9r0XZM6c?=
 =?iso-8859-1?Q?61D1ucuEo+1JwDWo294QgrfahRfoPBc+UnAH7LddbO4oY7VOfL35BAI1/K?=
 =?iso-8859-1?Q?CZrGz2+jHyDo7NPG3QKLAlWS7ZCAMyfuXCk0CU8sIGESM1N3nSPVvYBPzJ?=
 =?iso-8859-1?Q?HSxqgOAHgxnedF5zTIz3N2IpIB6CkYQHOVZnO30dWKGVivHSzlRAcqr3Xe?=
 =?iso-8859-1?Q?GU+DFXc8lwz/EK+CObEBXa35Aqmrf8Zum/qpcktUt7ITMNDQGjNgMu1Wpe?=
 =?iso-8859-1?Q?8Y2VO8qn0pG8yIojtzdRhObNecggFTujhcCTa5f831YbTAjQ62L1Spz46l?=
 =?iso-8859-1?Q?8m8S9V9zRVmhmcwNd1CF4i71SeddkythPhCNPOv4dZArB2Sksi6IM+s2iv?=
 =?iso-8859-1?Q?xmGbmF5KOATei25B/0rjbRDFJBIyrMZ9DxT5ptX/tOpiMmx4NmSD41f3H4?=
 =?iso-8859-1?Q?NPL0Pch6+5EeFknNKlUOdIgiJA8vVzG7P66J5Rvd5DOHhgZDGu542S27eB?=
 =?iso-8859-1?Q?74Zo6Bot3MeEDh0Y2TI0lQaZTTQ19TRbD+/AAai8z/EzI1QV75jO/XsyMQ?=
 =?iso-8859-1?Q?yibaboJL/mCZSw0pxDzS4iEGKd7e1G49TQlpnsDqEif65caGAPoJLH9z1l?=
 =?iso-8859-1?Q?S+3WI02h37n9tXYqsDN1OD3YyTH01bfXUTdiLLyENRNJRfI9w55pv0opUi?=
 =?iso-8859-1?Q?ELEizggbA/1Nc9JyKRs9aZvDEkD/FmYa1AjdZ1jFHqqGBEyiW5hIrtnmRn?=
 =?iso-8859-1?Q?I4vETsYARdCoiWqV+K7Ar/lnwbHJsk42L456cIpqx6afWf+nM12Kiow93t?=
 =?iso-8859-1?Q?HDtTzQaAvlSyhyEDOGzeGRxcJKgxmKJAFa4JOqowq1r3QWOMkZIPohyTWV?=
 =?iso-8859-1?Q?5gOvogRdloulV5d8P+fVmnukpoi0HbF+rQdnQ50gqsAx4Yg7er4fKwliba?=
 =?iso-8859-1?Q?gG81VZlLxOnzN9yCECpFyyTp9CbBlSF4ISn3KMjv9U/uyTwGVskIAaCKNK?=
 =?iso-8859-1?Q?DP4zVfj1QwOvp10huPA9P8IqzTx1EHSD4rHgPLC93sqWGyZzDdY/GX+mrK?=
 =?iso-8859-1?Q?MfwES50kTrPSj9d2CUjGkNb7lVohvHnjAxCEL4TOcEu//N813vXz/oAV1n?=
 =?iso-8859-1?Q?9TH7dPuDX7EoZK8fXGQeBamD1sXh6ktf90aiPRsXPxzFaF+k1V4oRVB9Eb?=
 =?iso-8859-1?Q?wkTtLnyQ3cTHCIMIpKYJxKXfoiqqPuU+U64C8ztE4eFqmZ1Thf3rylQQ54?=
 =?iso-8859-1?Q?Fy1hkurR4wSm7AI1qcTx/HUhKj9YDm5R2ijU9Jv+DG3938jYX8UG/5Gv0L?=
 =?iso-8859-1?Q?b0p6/pwC06xlf5edb3N/6WlQJVZTV715a7YMQJ4WC6NwsHCOqewdsp1tea?=
 =?iso-8859-1?Q?M4yvKYS/+6rpqzRwzgeeGIGU50eDtwIGGTrLy8sis7a5MJVfHbJvzuzX8k?=
 =?iso-8859-1?Q?ge9aQK6rkB3t+0q11k+M71FUCQM6PQLIqEf7jp85y3wzArrb/Q5Mc4wZ/z?=
 =?iso-8859-1?Q?z59EVDdbNfycBQmGrYbDflDpDVWgH5J3PJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9104b1-872a-41ae-38f3-08dda4c0d7ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 06:10:31.9556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7BTZZ7eLBQtBObJk46LBPD2fsoNng5Gf0vZn8hEW0xYnsOiAnAHUYBF5/d33fvi2SM/TNTXQc9b6IBx/G68U/mnaBOJR9i2HXBkCkkoOa0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4980
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

Hi Daniel,

> Subject: Re: [PATCH v5 2/7] ui/spice: Add an option for users to provide =
a
> preferred codec
>=20
> On Wed, May 28, 2025 at 10:11:13PM -0700, Vivek Kasireddy wrote:
> > Giving users an option to choose a particular codec will enable
> > them to make an appropriate decision based on their hardware and
> > use-case.
> >
> > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Frediano Ziglio <freddy77@gmail.com>
> > Cc: Dongwon Kim <dongwon.kim@intel.com>
> > Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >  qemu-options.hx |  5 +++++
> >  ui/spice-core.c | 12 ++++++++++++
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index 7eb8e02b4b..fcddb583c9 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -2281,6 +2281,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
> >      "       [,streaming-video=3D[off|all|filter]][,disable-copy-paste=
=3Don|off]\n"
> >      "       [,disable-agent-file-xfer=3Don|off][,agent-mouse=3D[on|off=
]]\n"
> >      "       [,playback-compression=3D[on|off]][,seamless-
> migration=3D[on|off]]\n"
> > +    "       [,video-codecs=3D<encoder>:<codec>\n"
> >      "       [,gl=3D[on|off]][,rendernode=3D<file>]\n"
> >      "                enable spice\n"
> >      "                at least one of {port, tls-port} is mandatory\n",
> > @@ -2369,6 +2370,10 @@ SRST
> >      ``seamless-migration=3D[on|off]``
> >          Enable/disable spice seamless migration. Default is off.
> >
> > +    ``video-codecs=3D<encoder>:<codec>``
> > +        Provide the preferred codec the Spice server should use.
> > +        Default would be spice:mjpeg.
>=20
> This looks like two distinct settings overloaded into one command
> line parameter, which is a design anti-pattern.
>=20
> Why can't this be done as separate parameters
The Spice server API used by Qemu (spice_server_set_video_codecs)
to set the preferred codec requires the video-codecs string to be in
encoder:codec format. AFAIK, there is no other option or API to set
the encoder and codec values separately.

Thanks,
Vivek

>=20
>    video-encoder=3D<blah>
>    video-codec=3D<blah>
>=20
>=20
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge
> :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge
> :|


