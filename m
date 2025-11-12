Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40F4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 04:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ2Uy-0008UV-Sm; Tue, 11 Nov 2025 23:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vJ2Ux-0008LV-30
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 23:30:23 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vJ2Uu-0004th-Ub
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 23:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762921822; x=1794457822;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/XSKzls9fBtDZFZykSLzjLjsT084r6eP7DgVJsq+V7g=;
 b=HUJh7UbIywmwanfMfVO3oBhmmMmB5Q4/FdUiUCrBd9mdtHIVk9lLnKUy
 JQA6IJ7qutJ/KJj8C/+U/wqYyOurrpcRYnQsNl6qcL7AM8g/Y3qAu0R6K
 08yqWEJdWjoB0vZQfkEMa6C+N1dP57ALNlLtrkH5qWpi2R1soWAyNmS9N
 glVpP00JXZV0Wt2EWz25GzjP9jLvSFTHTStM36dXbk5ri9Xak+U+0KQOa
 VjZfckQ2cSjQ0wzcCQSDSdso9SaSVKlZqKEDBkdeENu1Lly6dkWATxgG1
 98MCbpldbCMIk04HmdNDQtQQJ9IsXYUkFL6SuXNYeG9i9e5j4MZo96heU g==;
X-CSE-ConnectionGUID: +Sp/tW93Tu2a1momWIVJww==
X-CSE-MsgGUID: 24yFOS97RJ+CPROQFjEoRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="65015585"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; d="scan'208";a="65015585"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 20:30:20 -0800
X-CSE-ConnectionGUID: i+l/asX4RgK8zC96pJqUtw==
X-CSE-MsgGUID: rjS+oKK/TvC1/c3V3jyt2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; d="scan'208";a="188417289"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 20:30:19 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 20:30:18 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 11 Nov 2025 20:30:18 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 20:30:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jf1zk1igcHz1gf4vXgr8OeSQ2uhsq/leUkx0eQlxm2FdhnQMOq7kkc/4E0/iCirf71idrMnHHaYyVX9bOQj81hjywU93IoVyRCzTZgBPNwNbWsCQM1UhmM4micJt2eUz4NNwPfj5oO1pNck6QcMSz6ZJ8bIVEyS8bAdCnhe9BHaQqnYrwYvrhbiDY7x2AFsbL/nQk16pmNuylZac0KeVw5mRlCwN242U6w4s1/SRoiy4Eh8xRHaRkU+N9dDs+7eaAGq0MHkV4BQKYhHdzo28dVYTh8JmkZu4L8e06gDFn4deVlU9NK1nPxKJp+hQr1vKAmyy4sKCLx5eEX87lzd7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4VbgFInfmtv+f0IxH6W+UM9anGbCHODG81rz/cH0NI=;
 b=SbHA+nf0kQJ1ZGAUzoSIu+BkQm92ZNDENWoNJ844ZVtPTQR+Z4VZFKxQm1RfusWUwCRGbRU3JmPs4cJWwGei/KbJ+BweMVabcqCksfHLfEV9vaZSMIhpl2xFMp9lBZFeHhYFqZgSKB2uCZ/tIleZltrMuStntHvDFZ63fH4EjuMdbfc3WvrJcDC8ULgn2c6GCsf6rquuXR83MP+0qpUJ2cI3MSaJeXbdwKpwNowE7ZZwk1fWdXUr4G+cIrw1lQbuvNbsrf4yR7DkKKlmADEogRY/mhOE624Qg0G4i3IIf8FEvStDr+Tq2Pzic2dR9Q1GXvvOoD4VQ0pZ0OVWHTLSdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH0PR11MB5904.namprd11.prod.outlook.com (2603:10b6:510:14e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 04:30:16 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 04:30:16 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: RE: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Topic: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Index: AQHcUTsfaCBAQNqK6UqI5jTHJ6PIg7Ts6XoAgAE6QFA=
Date: Wed, 12 Nov 2025 04:30:16 +0000
Message-ID: <IA0PR11MB7185866AD30B9A73097934CCF8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-3-vivek.kasireddy@intel.com>
 <ea2e1bd7-d681-4929-b902-1948b854e488@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ea2e1bd7-d681-4929-b902-1948b854e488@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH0PR11MB5904:EE_
x-ms-office365-filtering-correlation-id: dd03372b-0e98-4455-7599-08de21a42e28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?CeZ3D1HdqFuHB/l2PIFOOLEszLIKe5GIAmZGTr/C5nFI9FtbEdJjrYs8rJ?=
 =?iso-8859-1?Q?HyHjMsSDM44Z6e6Eqy4g8i3oqp4O2qfppdqb8vPI1eX0lpdQQ2qEx0G7Cz?=
 =?iso-8859-1?Q?EFuN3CinKQA4B0qlydt6qBO0JJvi1rd4P5lThVGUW1fagiKP3f2DtFFSE+?=
 =?iso-8859-1?Q?mrKvcW5MgeEH9DU78S/wDRbqPJgkWMYGpCVExn8CrwQSavDmiy//KUISS1?=
 =?iso-8859-1?Q?Q0CB2DVaAsB3V30wO4ZrLBLMCDQczIOiL+Wcz3P5Lsi7YKrxkKWSt3wpz9?=
 =?iso-8859-1?Q?dbo3Aoc3f4TMhxC/sUq5FI9fFSUAf9QAyTCwgqAnTvXgqjy9d399jkBCzf?=
 =?iso-8859-1?Q?FOflQO/yopeN7iDhKr6pR1fmYvtEp/eA9e94x3N9hxbpHbXd72xz2slyB9?=
 =?iso-8859-1?Q?hLnij7tsFRZNZq5LsfXRKnbqBPDUoXQJjyqJYA0nRcfx15mo47ro4oN3Wg?=
 =?iso-8859-1?Q?vWA/SWSRMmr73zA/BBPybZVRAumLtLQWGI8sMBZ5MtxgqJKFsBjopWEF9A?=
 =?iso-8859-1?Q?/taiPU1GXoiTy5e7vsjoUiCgssyp/KDvenK9ShlaIJDs9mthgo/8PkkJ3X?=
 =?iso-8859-1?Q?I9gJsZKhgspcKXPwe27k6LTO9nvSGGtq5+2eHgukgp62M1IrbmzpIRuxH3?=
 =?iso-8859-1?Q?yiipmbI76sU+Tty6ls9UEKiKz4Hg9pZPj2n/Wipx7DHuuE2P2AmCS96hlr?=
 =?iso-8859-1?Q?Ko5d6VEqMfNZhNceKBdwe/f1XBHifGfjP/YusLxOowch/QrzgbV/cOWTz5?=
 =?iso-8859-1?Q?4XpQG+Z1VrCzKyzy/qVjUwWt95HAul6xmc2+0jQ3RQa1k+Gqz4Y9n3mCY0?=
 =?iso-8859-1?Q?Lvcf0erdSroO5WQ/T+icW/yTUgRr+/TvoaJMSOfg1EiVkOnvExpJ44BnB9?=
 =?iso-8859-1?Q?26ycNVZ+K2JwXESwdGUlbTABgxaO+IX+Qs269gOfhvMgye3GyENk0lxPVb?=
 =?iso-8859-1?Q?omzjFTdiuzKSWnKm68uCVvK9467v2LAphtby2YI7sOwibTcEWncRrnwfOp?=
 =?iso-8859-1?Q?+FtNeByw/UlWZT08SDBw+yDY433aCcOTRykLa8iGaZ3i6luouv4fTvqg9A?=
 =?iso-8859-1?Q?1JQlLvTyYn3+MC1noTFfEoWTocMJw4621C+6EQbrhh9XbD3DyLd+b3wYin?=
 =?iso-8859-1?Q?bDoaQJtAcTek0zYJGGg6YGoXqh+brGfSMAOj7P79NG4399KjWpALCt2Aoj?=
 =?iso-8859-1?Q?dO3DMkvQQk1AKjcTw15OQEYHb1v6UkN6/Re6c60KMc6eRMCZk938By0pRg?=
 =?iso-8859-1?Q?40w75vJCtFFwXUOHVvcc20uj3EdReEM+VQaANkDYH4E5Mf2yT3pe85NVMc?=
 =?iso-8859-1?Q?CRBgos8CK/2FMWqg02TEMUZc1Yd91TsPEYtsT5W/u1IICatQZQDbw3M0Mw?=
 =?iso-8859-1?Q?pvJwb304kvoIucO5qAYuj+s5LFzvI9IRLKaJMRbIWJ+r+7w5X7csWr0oWO?=
 =?iso-8859-1?Q?d2xnFDzfAbK28vo4xxAW1t/uxaydtwmCcaSGe3+Ep5QmFIV8rU0phO05ry?=
 =?iso-8859-1?Q?5f0zSuGuJ/Zthw3LFnOHcLDc1qUtcJfZjGO46Fz12qtLAr9YvJEhouXtKy?=
 =?iso-8859-1?Q?LPlUr/V/QikSwofZMag+HA3WQCCU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5pEenT09+9OMJdQVVVtAzrFaLTSL1wVq4WaYHfgFNGu5uJtSAb0J4K4qta?=
 =?iso-8859-1?Q?hqUqmHFUVz75h6puLqaC67oyOm6PLZv6aOFHlE4U6cVTxOZqPSdQdM1iSm?=
 =?iso-8859-1?Q?xCeMCFmV99EV+SVb7uV23rDck3UIfTH7hXoxT+5QmwkeDI0h1l5WGevqr3?=
 =?iso-8859-1?Q?QrC6gy8ic3B361Sq0qjOhBxA9+A7RERFBWGqVzAR5oH5HsBA5hDpLi8EHP?=
 =?iso-8859-1?Q?ZtHFWK2GRznu4e5OoxTUTaDjO05fcE6BKIqvC9v5YwZ/AujfROMccmZsYQ?=
 =?iso-8859-1?Q?Zi/8ZhXZxhlz4esUY+NTMWT/YilNUbgHxydh/BlyAeDtdq3ZwToZ6m7nIp?=
 =?iso-8859-1?Q?w6xvMFn5j9EaBfa/XIGZ5YJu7Q9F+Wz73VWZdpB710WksjD/H3JVjsWjFi?=
 =?iso-8859-1?Q?2ayk3aJ7LQrWsfYs7stIlNoncWtffIp5ldrcRZgoDHMGmQb8HPlYliTobU?=
 =?iso-8859-1?Q?SeaLBJt1MxqB8ZaMDU/GYZ4eTy6j4ilHN5ysund1l4lkOHlKwyMYBNFWu/?=
 =?iso-8859-1?Q?CbCuTVDvqMv9ws514t4eVOZ2/fDs8sTXNFwnpSISB9vXbd+raWpZsMM18Z?=
 =?iso-8859-1?Q?vCiJXkbrfb5Xx9ScNi/aQd8HjfCfotqZ+CE+Str1AE98rA4NtuZbOQac6j?=
 =?iso-8859-1?Q?Zce1qLG4hqFUStQC0JWQYhFCE2+CxVYMBQXOz9kIytq46kF/QUSxklImbs?=
 =?iso-8859-1?Q?pLafEPD5KeKg20AGIF0XzeYZs3cHB3iZrgHIWUOmM4n/RrqGA5OnPQZ8aN?=
 =?iso-8859-1?Q?DOIqQfpIjL/Yzva79I9gwFN/ModL+KiXk4AOmDFlQGFiM/fReGFTZl4i7O?=
 =?iso-8859-1?Q?86oIHq9gynFR3AYqvOjOLeobraAotk2syalPwJ73fUTON3iU0apEZZRKEn?=
 =?iso-8859-1?Q?d7v/JN9Q+LVbMxCv3b8EZVa9hcWAmv3XQpKBrT/BIiOjX+XraVy1JiwhA4?=
 =?iso-8859-1?Q?ybgS6mp7witK/mAMXFMJIPsDlaJ/o5tvjsdMUFT5JLAEl1ShuIPCctY0WV?=
 =?iso-8859-1?Q?Lv2i6HX1czxb4X5b+xJWqjR1/XuLsJrcQUmk7XSeCpbsB2Y5Zxj4VEkl7t?=
 =?iso-8859-1?Q?mxcrq7YT2Eca/za3VoWgleVUBgdPbj+meMHGtnOu7AKNA6Z02Y4v3HYTF9?=
 =?iso-8859-1?Q?ix3DNP7Vvih5wvYDQyqeVVZ05j3DNZcLVpG2BKUSmZurWMprRqUzH4bvNf?=
 =?iso-8859-1?Q?GxuOcbfdbX/S+9qxsxwyEH3pnM0K97uRLxkkyH9suEAWKJiwLqB1V3VwTR?=
 =?iso-8859-1?Q?sb/XnjeidRqjSxMa5nAlaQmoaIA8r+ghMbXkqqGHaOT3jKT06VXCqlx3ry?=
 =?iso-8859-1?Q?mTuRaORKOuQGclj8G2NNsfaUE6j24d5eENG7HAL5G03ltZAl504CxBZpRN?=
 =?iso-8859-1?Q?OfFgdC8rHmyZlYK73uIP2nQR7+gqEnFX9+Do/vOIIY/K9b8hmbIjxR/RCC?=
 =?iso-8859-1?Q?RgOln8dgDNqxhQwH93FOpB1gW6+UIMwGommkmQcTgCkonj61c2T8jlWLbY?=
 =?iso-8859-1?Q?2H0Nvh98akck1ANWPNoAz8Gy7S8+DK5wINrdLu2CPyFmjFoCQSTLpzEtdF?=
 =?iso-8859-1?Q?tLuxhi9iaDzVtQMVSBu3rZmTIjRHk8jA7Jiq85ccDwWawBnxo3kwqwLLt7?=
 =?iso-8859-1?Q?FyikDoyaOKH8MaweZNCEzfyh5X9Cj7/WvK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd03372b-0e98-4455-7599-08de21a42e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 04:30:16.5894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nlmiT5xWE38zZYbbHRk9dJ/6XGAo3kD50WpPLXFXZgHvRP5DmA8diKfARyGdcEk8E9PZCkMZcl5fOU4vcMGatGWXMGHm1pf+h6noWBrO30U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5904
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA addr
> associated with a ram device
>=20
> On 2025/11/09 14:33, Vivek Kasireddy wrote:
> > If the Guest provides a DMA address that is associated with a ram
> > device (such as a PCI device region and not its system memory), then
> > we can obtain the hva (host virtual address) by invoking
> > address_space_translate() followed by memory_region_get_ram_ptr().
> >
> > This is because the ram device's address space is not accessible to
> > virtio-gpu directly and hence dma_memory_map() cannot be used.
> > Therefore, we first need to identify the memory region associated with
> > the DMA address and figure out if it belongs to a ram device or not
> > and decide how to obtain the host address accordingly.
> >
> > Note that we take a reference on the memory region if it belongs to a
> > ram device but we would still call dma_memory_unmap() later (to unref
> > mr) regardless of how we obtained the hva.
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu.c | 24 +++++++++++++++++++++---
> >   1 file changed, 21 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c index
> > 199b18c746..d352b5afd6 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -798,6 +798,26 @@ static void virtio_gpu_set_scanout_blob(VirtIOGPU
> *g,
> >                                 &fb, res, &ss.r, &cmd->error);
> >   }
> >
> > +static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
> > +                                       struct virtio_gpu_ctrl_command =
*cmd,
> > +                                       uint64_t a, hwaddr *len) {
> > +    MemoryRegion *mr =3D NULL;
> > +    hwaddr xlat;
> > +
> > +    mr =3D address_space_translate(VIRTIO_DEVICE(g)->dma_as, a, &xlat,=
 len,
> > +                                 DMA_DIRECTION_TO_DEVICE,
> > +                                 MEMTXATTRS_UNSPECIFIED);
> > +    if (memory_region_is_ram_device(mr)) {
> > +        memory_region_ref(mr);
> > +        return memory_region_get_ram_ptr(mr) + xlat;
> > +    }
> > +
> > +    return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, len,
> > +                          DMA_DIRECTION_TO_DEVICE,
> > +                          MEMTXATTRS_UNSPECIFIED);
>=20
> This function should:
> - call memory_region_get_ram_ptr(mr)
>    if memory_region_is_ram(mr)
> - return NULL otherwise
>=20
> There are a few reasons. First, the documentation of dma_memory_map()
> tells to use it "only for reads OR writes - not for read-modify-write
> operations." It can be used for read-modify-write operations so
> dma_memory_map() should be avoided.
This patch series only deals with non-virgl use-cases where AFAICS resource=
s
are not written to on the Host.

>=20
> Second, it ensures that the mapped pointer is writable.
> "[PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs associated
> with VFIO devices" adds checks for memory_region_is_ram() and
> memory_region_is_ram_device() to virtio_gpu_init_dmabuf(), but the other
> callers also use the function to map writable pointers.
Unless I am missing something, I don't see where writable pointers are used
in non-virgl use-cases?

>=20
> It also makes the check of memory_region_is_ram_device() and
> memory_region_is_ram() unnecessary for virtio_gpu_init_dmabuf(), reducing
> the overall complexity.
Since buffers reside completely in either ram or ram_device regions, using =
both
memory_region_is_ram_device() and memory_region_is_ram() to check where
they are located seems necessary and unavoidable.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> > +}
> > +
> >   int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
> >                                     uint32_t nr_entries, uint32_t offse=
t,
> >                                     struct virtio_gpu_ctrl_command
> > *cmd, @@ -839,9 +859,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU
> > *g,
> >
> >           do {
> >               len =3D l;
> > -            map =3D dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, &len,
> > -                                 DMA_DIRECTION_TO_DEVICE,
> > -                                 MEMTXATTRS_UNSPECIFIED);
> > +            map =3D virtio_gpu_dma_memory_map(g, cmd, a, &len);
> >               if (!map) {
> >                   qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map MMI=
O
> memory for"
> >                                 " element %d\n", __func__, e);


