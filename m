Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B56CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 05:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9GkZ-0004J1-Jw; Thu, 16 Oct 2025 01:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v9GkX-0004IZ-Em
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:42:05 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v9GkV-0005EK-4j
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760593323; x=1792129323;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MqXhX/f9anz7hjmVu4/kGqilMISpNjPURX3c2mXSImE=;
 b=BOBWdlGBk7dbmSLSwoM5Cpok5Jw08WKF+9YTPnt2w28VzcCPbVGVHBko
 eyGBqo8EEPQ8/T/C20bJJmS1aijLvwEXY0JS4M4HG9FNcN2oZDB8FIHuR
 TypmRdlSeIRuM7yWHgl8kdwHlpilRtzkzuPpp5pOYqX1B5M2dfsI+2hwM
 IMVrQJi3ia9emwqdaGkZgZ9d1mPFtNhK/H+kV7+H0SakW1B8qv1p0yZUp
 Ng7Q45ezhTRvlR/yd2bxCWaDNYzFCtXKbW9yYi+Oei8I8Nwpt5TMSa7RV
 ixO9YA4WLJeSGHxGeT3xVo5UaqonsqxFJ/jS33LcikvmWmE1LuVryFBLJ A==;
X-CSE-ConnectionGUID: 1SX0DsIKT9a4kC3pKjo+4Q==
X-CSE-MsgGUID: dcJ9pEXsRUmsqbMZq9XADw==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="62816436"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="62816436"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 22:42:00 -0700
X-CSE-ConnectionGUID: r0op6UcESjywtd9aao+atQ==
X-CSE-MsgGUID: TdqaO+0zTrui9Z8a1S6MUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="182346799"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 22:42:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 22:41:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 22:41:59 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.54) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 22:41:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSuwcfncsixbqce8aU8H6371xpDbN0MwVV7BfUvfBiyZUzKRI36EnC7ynnLhjKnMXftroYHGQ87pShs6+vrCLjGcTnqwtoZmbAs3yjKDmNeHp0zdWa5G4hJsmUGfRcNaUOL5KvzKemFI92hrHrR4tKnkGf8xmm4GFPnBYIoF/O0Z0OWxT7pz58QLLceaRHrMhw+vYMJpXc/Rdec71otm2cSdpRGiSNDYx+5ZrkZmDUCnAE4UwEOzZ9SaxETVZxh9ZMmt/aqfsEVjfuuFwlUBIakjLC3Tn0oUvFi/VJTkCBQNuM74LeYOz7nIbHl7fhcP7Toa9lo21DoOEYA1UBdjkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqXhX/f9anz7hjmVu4/kGqilMISpNjPURX3c2mXSImE=;
 b=pKPlazaWjXhZ9jgENWrvscUcPVXzTlx4YeH7+OPyJ835QP2ySvHmTlDihfcbkeVpu/SeDoEIORp19l5XviTemfYkZ0j3Iu+6GHzODxkraNNsZdNh+prqbq+op5wwHu1H9I9daxxgQIqOlIjqsn2dG/qWg53rEtimyjKsFW/DwGMAVo14gR9vy7Fno5zL06jCdJwCuIbKaU5Ob+2/OmIi7L3SxtvWl1/ICElWy/9A1l/2E39tGhtFN33Mbt777g7QgfU2i0T0DoNW4K4/I9cHR3gmEeY90iRy5dHPq50koqE0FrGoInH1pGf9kM6MYeLB9rlaPp5rPHFpcC0+1UwsoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SJ1PR11MB6177.namprd11.prod.outlook.com (2603:10b6:a03:45c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.15; Thu, 16 Oct
 2025 05:41:55 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9203.015; Thu, 16 Oct 2025
 05:41:54 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify
 blob resources
Thread-Topic: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify
 blob resources
Thread-Index: AQHcNL+RUYjirTlu+0+SWGS5LfcOTbS60JoAgAQ3pzCAAhCigIABcDrggABCiYCAAGOhAIAA+5vw
Date: Thu, 16 Oct 2025 05:41:54 +0000
Message-ID: <IA0PR11MB71853F97E13556E781AAE104F8E9A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-3-vivek.kasireddy@intel.com>
 <1fd966d9-95a5-45aa-8a20-46f2987cd65a@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718547E3A9E97A0DD6A4A2D6F8EAA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <ba762750-cab1-4cb8-a629-101de5fdc179@rsg.ci.i.u-tokyo.ac.jp>
 <CH3PR11MB7177C4541131508F53BD27F3F8E8A@CH3PR11MB7177.namprd11.prod.outlook.com>
 <955ea687-ed25-47bd-9ba9-73c6b98c8e29@rsg.ci.i.u-tokyo.ac.jp>
 <1f127ac5-10dd-435e-9ff5-f70596d7aac4@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <1f127ac5-10dd-435e-9ff5-f70596d7aac4@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SJ1PR11MB6177:EE_
x-ms-office365-filtering-correlation-id: be300c5e-30df-4754-1d5e-08de0c76b6d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AQA4joU4On+8RevDIjNLUNKoiQOt/T8iogbvyMZqzL8lsZY5Hp6+9ZGRQK?=
 =?iso-8859-1?Q?u60SSWLmUyh3/ZEKz6ARigdNDNVVneZ4sIF5eeCtH44E7uDARrrh+nYowq?=
 =?iso-8859-1?Q?B7D38v/rxpHLuxyzgGy1Nxbzx6dWxQaN2T+IghVVjXRbm+zq9RyLm6OeVf?=
 =?iso-8859-1?Q?oyBpQeRTh8zMTwVfumnTwVTeLzmsDBG0IGg5wzZUym0M7PUJIk95liP9Rq?=
 =?iso-8859-1?Q?gMlDwO8RLowb2WfucMhNwDIJcvFi3BKEO5k19Yu8JYdIl1kPRVlEamjI/o?=
 =?iso-8859-1?Q?a759wFWjpeeIwlMShhanu7qu0YIjCwi9jT7nqOLg1mwszZVByitxv3HSPV?=
 =?iso-8859-1?Q?UmWiitL+IwwKrfeZF3dsbJHWD0T4eURpNR/ZDw6i3PFqkp6nf4gOmZFaUQ?=
 =?iso-8859-1?Q?s4MqrxwGo2A1WRHvk8BPHYVXf7hqm+G6UYz46ey43/+VxORtUlGSjnr5Gm?=
 =?iso-8859-1?Q?Awa/TiE1lVcSvAQMj1pPQLKT4yF5zbjZxWUdG6ikFmvK9/0Sm91EiwPRxr?=
 =?iso-8859-1?Q?VDqNom6Rx/aBwOoSj6hJX7eh1KbjiyhpsbjyrxaxipFjl2d6LZ2vy9rIVF?=
 =?iso-8859-1?Q?ZUupTcJREKAKg0ysf2Q5LKwyFbxnUy3xgOKajt5rBPBk2gRsbuGQeJTYIV?=
 =?iso-8859-1?Q?iEJR3IqQ7ZIt9YkDGaTj+bQniUZOnMuUMGPQdBNsf6QWC/jQSBepcEjXIv?=
 =?iso-8859-1?Q?n56xorZu2DA6TZ2i+YVdYgaUFiUqe1YEn0T+957DGETvoyiDO/vUXTuDeh?=
 =?iso-8859-1?Q?WHladQ55heac6FR8wyIl1Xw7/tNlY8fc4dk5aMzxfq2jfhihVJ4Ajtlj6j?=
 =?iso-8859-1?Q?y0w2d4fYtqfSOvioIL+nRZSXJt0ISmUAK33O1y0MXaCNAvAxQpGJe4e20e?=
 =?iso-8859-1?Q?lc0kqu3AeT+0vLnci2wSbXQHySW+jPzDqhKG+wlnfSsrVWDqeZ9lUzhYYc?=
 =?iso-8859-1?Q?9LTmYVW6ZYo29IOyzESeLvJ9XqvtiHqEjJ+idpNZgPPnjs4toVkRzIrimn?=
 =?iso-8859-1?Q?YxchODjcUKTeA40SomtMc9Rrpd5GqGDjCOp1fgdlzg1IVJmF1EK7UlM4cN?=
 =?iso-8859-1?Q?zXHmu8MFdhZWg6WYyirT+/l8rt0hG9d7D11nZn/wBoJKUk8GiHG36+JBs8?=
 =?iso-8859-1?Q?cegSNSd1XhpbjNWwa37ix0vhXYeNGHtXlX+jRDsNE58TMnkPaXU96unh6l?=
 =?iso-8859-1?Q?R3YLNomYu9gZWbE4nVUiGx5Z0ugkYrbeLz2lQPnV93qRy12tTPxZiiPmQC?=
 =?iso-8859-1?Q?qJFfi5MJBU/sgVM8xM6rfd39wIHc2e68veKq6r9SDGatxOtC9d5Kglsob3?=
 =?iso-8859-1?Q?X2gj2L46TOMdrrvGZRzCE69Gh7rFvA2smNqj5mq/bZRQ31v6cWFl2SyoGT?=
 =?iso-8859-1?Q?ZcSmiMzro1jow9q2c/8yrPohySihNKds+crN43b1muqcYny10JJda6PTtd?=
 =?iso-8859-1?Q?81fzY02qMaFpGjVE3BaXwu+KukGlTbB6T5hFTgXQPZX3hnkUwizMTPW/Qe?=
 =?iso-8859-1?Q?FQMbrEGN9yml7LZqjk6WDy7wRvSX8RmtojyN85OeyrRSjG3cTaKI9TwPoL?=
 =?iso-8859-1?Q?IuJL/oxYxfWRywIcImD9MoFfMN8r?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9CQpSlzF/9nBywl1u/JhXGcp6ofn9/1uXoLo0A7zB+kA1I1DvBw2idqL/a?=
 =?iso-8859-1?Q?yqV3SMka2UqRfbJtSOskUzEjpzysmZa3uyV0h8zNBh2pXJqmUwXw/07Epj?=
 =?iso-8859-1?Q?nNY1On/7uYKHqoMKTDT3CTHuKX8Np1f+MEJXpwu7zRxt545N5K3YNI2f0i?=
 =?iso-8859-1?Q?Bx4T2cs3WZ8whPmTt/amcHeVt7JU/ZuGZwoXJ3lDjVlHDn2dAt58WYhN5C?=
 =?iso-8859-1?Q?NPtagLGYZIVIWnHkxSLYXY90LzYsX7ouZeoHeOZ3taiWVeJlirtdKaRfJW?=
 =?iso-8859-1?Q?cL9MmdBTMtK5FWx9yiOoLz/Z6P6ZlThuph9VyhqKLfwLEViBYTCtbg5iiH?=
 =?iso-8859-1?Q?VVRbhYKQ8YtdcuAuIQHC25jaoWhlYcRyeywfFiPtx2fMCA54GPg7JSftSU?=
 =?iso-8859-1?Q?I9Gx+Hu4oNTLvnBYIlGrVCwGWVdAjAEmoY/bRpDMAMpcrY9zWDjWYzzy3k?=
 =?iso-8859-1?Q?DgVqt2g8t/5oXIG5yzgoNVm8k53hOtT6UppnUL0GTDhk3lwMLKGtJvA5Wk?=
 =?iso-8859-1?Q?XhzTrZeH7dAnOpsGPBPVIg0FaKTNAC5ejFWNgY4zhuX/G2atvYip8vmxxf?=
 =?iso-8859-1?Q?ABl0z2+3kuhjW34236zFFm5EGrjEhYSmWMENWNOUrNJ5be16kYoSDMttnI?=
 =?iso-8859-1?Q?Votr4qV3Nnqsv8J2t71AedRha44kbfroLNdjooXjAgLXzK+Dh5N2/FmnPO?=
 =?iso-8859-1?Q?y2Qvm9wB3dWBqVQe30nPzQPSKp3faMidfIsUbUUfQfzMNwOePiOz+x/ksl?=
 =?iso-8859-1?Q?Kagq43MGKSGQ7o/NpOrFtmpe+zwBYArUcjHe6I7OZZu9SnrdjooYqO7GSy?=
 =?iso-8859-1?Q?+TWXH4fk4eVf5t8D4scOGp93LdivH3AejJuRJWrsXcGyQYeFO9S6kH4WcQ?=
 =?iso-8859-1?Q?99uyxOGMlJRldHnI0FU/07kUSZphAiL0gsDOHaaRyXPYqctDDfs5s0SQJl?=
 =?iso-8859-1?Q?cNs8gCqeFehk7rPqp4LEIzSS9tflqF46Yt09diFt5g3tVX26hfLIfmlnfj?=
 =?iso-8859-1?Q?GdZubY8ZujDEpLfU/hAPy7HFRKo0aOeMg9yA5CLpRu7CZb9LDM+8aBbGzs?=
 =?iso-8859-1?Q?gMsx98MBN7fcsjCZuXmrofJ4gFEP1JjEHInOnGbHLU0rGmTZwcNiK7tC8T?=
 =?iso-8859-1?Q?y6QFvpRFVwrnak78mnqMu4Xwn6OpisWN265dK7kSsLCv5wHXbWnDIs52tb?=
 =?iso-8859-1?Q?PgvYUTa0osVSWZNcg0sKvqvGBh8TWZ6uZf/QywUoOyrOHpyMIFCTD2HSw/?=
 =?iso-8859-1?Q?iiuFqc/LOitSaGSHfLGMCljZsPT8f7iZ2uGaSdOimD0V99f3fhmlmLMTZT?=
 =?iso-8859-1?Q?D6BNuEUkKfgXlN/5CrlxcjJcMIm6Yi+pToIFS+YjNu1HVGtINs117iurJh?=
 =?iso-8859-1?Q?lFHDNgBtm+K7mxt4FMR8/vGU3L4zr0900HysyaZ3i/Xu5OpaqcB78LQ43K?=
 =?iso-8859-1?Q?xTE2yUHoYuj7iBBJfJ+pU/JIfen4VG7WddMRo+9hMdEWAWGqI0JixRov4c?=
 =?iso-8859-1?Q?pvL0rp7ZBEHJGMqHh6U8XCG/rDl6P+M/Jqu/VD0hlT5Do21PIr766GK/5B?=
 =?iso-8859-1?Q?N6rRlpngs41wZBHUzNob2+CsN9y3aZUF0VPLKqz+R/R0FVsSgD+U3RTtMn?=
 =?iso-8859-1?Q?/Sh1r2v/03tyZtO/AUjhXTT2wrmyi48y1/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be300c5e-30df-4754-1d5e-08de0c76b6d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 05:41:54.6077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbeV/kU4Lj4gcI3MwxvnWgzCIQzuZMPZuAIqCOputXyfi/MN0gRyMQJrtmSllKyXwDFX0ihUyxTRogZZ89YodkcydzjnQDgEAjkFoL0yAs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6177
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
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

> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identi=
fy blob
> resources
>=20
> On 2025/10/15 15:11, Akihiko Odaki wrote:
> > On 2025/10/15 14:07, Kasireddy, Vivek wrote:
> >> Hi Akihiko,
> >>
> >>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to
> >>> identify blob
> >>> resources
> >>>
> >>>>
> >>>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to
> >>>>> identify
> >>> blob
> >>>>> resources
> >>>>>
> >>>>> On 2025/10/04 8:35, Vivek Kasireddy wrote:
> >>>>>> The res->blob pointer may not be valid (non-NULL) for some blobs
> >>>>>> where the backing storage is not memfd based. Therefore, we cannot
> >>>>>> use it to determine if a resource is a blob or not. Instead, we
> >>>>>> could use res->blob_size to make this determination as it is
> >>>>>> non-zero for blob resources regardless of where their backing
> >>>>>> storage is located.
> >>>>>
> >>>>> I think this patch is no longer necessary since now you add code to
> >>>>> mmap() VFIO storage with "[PATCH v1 7/7] virtio-gpu-udmabuf: Create
> >>>>> dmabuf for blobs associated with VFIO devices".
> >>>> Right, but given that mmap() can still fail for various reasons and
> >>>> this
> >>>> use-case can work as long as dmabuf creation succeeds, I think it ma=
kes
> >>>> sense to not rely on res->blob to determine if a resource is blob or
> >>>> not.
> >>>
> >>> I think the code will be simpler by making resource creation fail whe=
n
> >>> mmap() fails, and I am concerned that the guest may mulfunction with
> >>> such an incomplete resource.
> >> AFAICT, mmap() is a slow, optional path except for the cursor (which
> >> needs
> >> further improvement). So, failing resource creation when mmap() fails
> >> does not seem like a good idea to me given the fact that supporting
> >> mmap()
> >> is considered optional for dmabuf providers. And, even with vfio, mmap=
()
> >> can be blocked for various reasons by the kernel driver IIUC.
>=20
> Reviewing the code again, I don't think mmap() can fail with the current
> version of this series.
>=20
> udmabuf obviously always supports mmap().
>=20
> For VFIO, checking memory_region_is_ram_device() ensures that VFIO
> supports mmap(); memory_region_init_ram_device_ptr() is called from
> vfio_region_mmap(), which is only called when VFIO supports mmap().
My point is not whether a dmabuf provider provides support for mmap()
or not but about the fact that mmap() can fail (for various reasons because
it is not a guarantee) making res->blob NULL. But we are incorrectly using
res->blob pointer to determine whether a resource is a blob (and usable)
or not which doesn't make sense because even if res->blob is NULL, the
resource is still valid and usable via the dmabuf fd, which is the preferre=
d,
accelerated path.

Thanks,
Vivek

>=20
> The use of ram_device needs to be removed if it is really wanted to
> create resources with VFIO devices lacking mmap(). This patch is
> unnecessary otherwise.
>=20
> >
> > Being slow doesn't matter, and it is not just for the cursor, but there
> > are several other functions modified; I guess the resulting resource
> > will be unusable except for accelerations like virgl.
> >
> >>
> >>>
> >>> To motivate the proposed patch, there should be a use-case that requi=
res
> >>> to have a resource without mmap(), not one that "can work" a resource
> >>> without mmap(). It is extraneous complexity otherwise.
> >>>
> >>> Such a use case should be explained in the patch message and perhaps
> >>> also with a comment in the code. The current patch message needs an
> >>> update as it sounds like it is unnecessary when theere is code to mma=
p()
> >>> VFIO-based backing storage, which this series has already gained.
> >> Although VFIO supports mmap(), it is not guaranteed to work in all cas=
es
> >> and with a different dmabuf provider (in the future), it may not be
> >> possible
> >> at all.
> >
> > The fact that mmap() is being optional for DMA-BUF and VFIO is
> > insufficient, but what matters here is whether a DMA-BUF that lacks
> > mmap() is usable for graphics.
> >
> > Reading the cover letter, I suppose you are importing a mmap-incapable
> > DMA-BUF exported by a dGPU, and the imported DMA-BUF is used with virgl
> > or something. Explaining the use case will show that there is a mmap-
> > incapable DMA-BUF usable for graphics.
> >
> > Regards,
> > Akihiko Odaki


