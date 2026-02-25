Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06845E9B25A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 06:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv81C-0003Y1-DN; Wed, 25 Feb 2026 01:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vv811-0003XJ-Cm
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:04:57 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vv80x-0001ly-SX
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 01:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771999492; x=1803535492;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ijw59wrzfzt0Nu0PytL6YVfesc2Eo2AXng3PSYfYi8g=;
 b=LA0C3f1CkNJefSG2DYi4VOHmWyLDKjrw5LAYN3GGUwOxR0ln9+bgM7fI
 CZLylpsJL9cC5Po7eJaCFWmm/5dWsYnLz2kj3IZUxtkwCyvCQqUh0PUKr
 KWYAcW54bXE4JQWrKIOg2Kkhc+37s8UsQzysVqydeHgkchMQGd5O0Dirx
 HUXknROAg3Y2JQSMMI1tJczZKoaLxoZv81G0wmj3Fnfm9PPtmh5nZqoqA
 kK5RIqMOfcG9YEk447rJ9fzFA3CMQpPWE3OHK3iiIo0JpKoCbjVN9Fj6I
 XexxhVKrr7GwKcqc23kmMwFf/5iFtFAQEqAvgSOLDABH9tJ7M6kGBGnPI w==;
X-CSE-ConnectionGUID: mAvdmpJ5T+uhUggDIHNt/w==
X-CSE-MsgGUID: gC0uzopPSnqSObvi87rlWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72933683"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="72933683"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 22:04:50 -0800
X-CSE-ConnectionGUID: W/TLlzN7Tgejudr22kBdhw==
X-CSE-MsgGUID: B4mspbXjQBGCmvXYIbNzyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; d="scan'208";a="213859058"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 22:04:49 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 22:04:49 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 24 Feb 2026 22:04:49 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 24 Feb 2026 22:04:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKRIsyC8gwMmwSXacKeZij0JekY1vzb0Wocu/4PW572prI16dVjXReec9ybtKegixh2G18ShwQBkxOXlVatec52HsR/wocIF+zpROjBCB0MhCvuG58a4+QPsjzuZplQsJGgICaGBhMBGAlpSIhYtZ9vOViZ0DwPeflH154ENdDMq5ALqJHt8DitPFKPM+KH/P2ir/FtDmkXDmkR2pVd3dofAHdSaHIJy4Q5SZ0LIyXABmK/SA4PWJBTdEktyVfOaMKZdI6w+DpVTXGdD7oeJJrPOP99qXC4MjvHzoH5IGgN38FoHQsm5k8gETuWPqkDKhgfvwIpQTOVkrnP/PFJlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytbRIJsQW/yi8nUBVUBe5SIxpT8DE9mNX7KGpHlmvgI=;
 b=ebmWvZsumCyD4+oIyZDbRXFrw1vEyc9SkggY0cAC2F1Ud2wTbtHyAUHtGFQwPpAKpWlu/aRZCZVX7jN2sbVRpkVlkcsY3A/ZgGAifUs/GHajC2HKfbVvo8rcoGAhx60Q1ZIEnTGVwJ0xhwF182JkUcAQWv2+Y826QpQ7urABJ6CUyCdulIrrUHc3/LO8Gg5R+q8it3Z66FIG9GIvG+tb8dTkhwhYwOhBoVppRb0duKwC6AlzoGn7VyDV3SsJsF8xOE1ZzaUdaKyu0KpiA6McI9F0JgtfrnfZ5E/hBirV0S/oIwhfjcgD+zCzCit8bCYePwhckuBhtFO+LymKWAF5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH0PR11MB5927.namprd11.prod.outlook.com (2603:10b6:510:14e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 06:04:47 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 06:04:46 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v7 06/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Topic: [PATCH v7 06/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Index: AQHcpJsNU38pqXozyUy3FaU5XrOP87WROn0AgAEu9BA=
Date: Wed, 25 Feb 2026 06:04:46 +0000
Message-ID: <IA0PR11MB718522807D0371785F93337CF875A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260223080200.468558-1-vivek.kasireddy@intel.com>
 <20260223080200.468558-7-vivek.kasireddy@intel.com>
 <829317cc-551b-457d-a27f-9db0fc749c52@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <829317cc-551b-457d-a27f-9db0fc749c52@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH0PR11MB5927:EE_
x-ms-office365-filtering-correlation-id: 64fb9fb7-3c2a-4622-78a4-08de7433c751
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?qk0uMvpmDZv8kvpeN+ELJlCNJmJJolWEHAXJVYlz8tSBiGeN9ldEHPtOIc?=
 =?iso-8859-1?Q?weN82W9D6YKl4kPFE/VttrZmN/ruKWUWwW8DMIzIHFZfDHHiZct4NIUSdQ?=
 =?iso-8859-1?Q?ZdSbmpMMVS7NEb8HVbFDDfi6R1OhSfvaTTvNsHXmUOoveFq43+alkzBQkI?=
 =?iso-8859-1?Q?VMJYrmRi8M8zfkf/nvtjIUtbD1xayGsBJNCYtD8qs/nNgORZZ/6NS6wPQP?=
 =?iso-8859-1?Q?gvL3qCVnY6OJxCoFaaiCMGcvXeafMwr4jAaFdh6Pii4FyBxfmKb72/0fft?=
 =?iso-8859-1?Q?mDzfNNHnfFFQmme1vGosBOeQeeyjlWhuwqggRtSkWUxxxn5UofHptN38w3?=
 =?iso-8859-1?Q?Rf8+U5It8cmiMsjXx92Pim9iBsCfARgjgBkTNAZWBsW8yUA53Fnb+iQmWZ?=
 =?iso-8859-1?Q?aZk9AUsiUpun5Lv8u105rTdgmZ3o+fo+oG9I6FFvzKVDU6dQzMPn92ZtNR?=
 =?iso-8859-1?Q?Jqymdt4pfB4Cz8eti/A8MBefIBgmjsll38rV3DkWugVPun6n0MI4Ulx3L8?=
 =?iso-8859-1?Q?d/7oDGH5mb/5JBRKyio+2ytAOlp0PiHHLyM9FW5IV1WmNWVdjE59apsxZq?=
 =?iso-8859-1?Q?oNYMOyUwAKEnml1h/B7bGpLZtsqDada2EZ1v8Vo1vdDZ4mferH3ULlnqSs?=
 =?iso-8859-1?Q?7MBfeYKQ87TPTHTLknM6Acl9AO7icCNW39AZHKkBQLVfdNd0FEzPFp+QBz?=
 =?iso-8859-1?Q?p6gX8rz3H+I3LRvdKNLBjCBI+M/LNY6yDBAHIBYlVYh/6uiHOEAUFpepd9?=
 =?iso-8859-1?Q?1ZDYkciEuUIfchjDohEMapSZnlL0fJNIYn9nyZNBxr+XBmCF88dftIRMCH?=
 =?iso-8859-1?Q?toIyRa2Tng3AHaWGR9XI9NzkOEJxFwlzsL6wZLzss4FUexB4U1z7g1TVo9?=
 =?iso-8859-1?Q?sO4ZEFI9Z1tM7XRd6UCguhU7hHZKZKZ1cwg4sc6h1+s1W7KhKk1wkjLnvb?=
 =?iso-8859-1?Q?XpIj3Q1QkRLcLKn71ymrcFQ15RUx9ErHOtvstQbwsvLlZhlLhiFD3l+NKk?=
 =?iso-8859-1?Q?we4KkBza72uQne9SvyXRV7fvyEpJmFgWFiWiRwdoeoUHYZbzYPS+tXomRu?=
 =?iso-8859-1?Q?iRIgmGLAkDknoFMkyRkgEpmUE8tbDGJVYLzNOZiX6MQmPGji3TTY75l0RB?=
 =?iso-8859-1?Q?neMgsJzGX4gOpZiZHZI4gDdakOLTUJ4AhiSBnV9S7akKJFb69B/B3lrE78?=
 =?iso-8859-1?Q?4vndTj/3Ay51Ik14xBFkQHN75K8D65JX/QY6VGeG/k1s2bY1Lq09kyUR+P?=
 =?iso-8859-1?Q?Ih55DJvru/f7JFKxpP/c1IgM325NmVAXa50l+4OqFRxjSQElwT0JewUOCv?=
 =?iso-8859-1?Q?PwpINQirln39LGYpGrKrDDuNzWAcY9UduAcSDVsDaUdsYmX2pZrXsIbIc+?=
 =?iso-8859-1?Q?vRe9kmp34dRcOecFdqYJ2gWLDSc/ryv2bYE8Hpvvcfm71r8gff7Xw/lxBN?=
 =?iso-8859-1?Q?Yx0ItHdzBYvrAYgqQYBCRExF5EaYjuvswnOXqQ3WmHdk6xz/jI9zjG276l?=
 =?iso-8859-1?Q?OCogZ/ho/5lKfgvUelXhU311isqotvMVrTRPKbHj7hywpBZDwWxqjMLqu0?=
 =?iso-8859-1?Q?+ZgJgcwgacID5VI4WuZqbkyQ+IDzXJt3Nf0HtN/QEglzPF1sG8hmxuzTJf?=
 =?iso-8859-1?Q?enASSjIfoMMgyhXm0oSXca6/3cxjNqZB21gb54Z/y46TjhzyQndn6+CiKZ?=
 =?iso-8859-1?Q?UIAdUF9HhK5rksCqgCI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RdHHbEtTCIJYTUpNyhRiQmtfEpK9H2Lx5DACw8jR9mz7Z0BV/PiIpgqUFY?=
 =?iso-8859-1?Q?CzRVic70yzPD9j5hDrCoLr4KiIeMb3bwK/GIm6J2MbPJblRthksWTPuPKY?=
 =?iso-8859-1?Q?Xg79BJNMCkBw2nhxYcFkiauwPkDFn8cUhLH/qU9UyshGXerKe56RUE2qrp?=
 =?iso-8859-1?Q?3+i2M942wHH6KS2gVVa7y4jPx2muKQHNxT7eJZpytLhNhOsCOdx/9EVfSp?=
 =?iso-8859-1?Q?L7jBC1JgqFp3p8CSW4L7y1Na/RGiwxqDbabth8ojy8K6d3LUsBF7KKAXMO?=
 =?iso-8859-1?Q?eCkOnLVhVpRptkNnynPJpp6o+zBLuapi4XVH3Gir291nKlmlq5fKZdry/S?=
 =?iso-8859-1?Q?2TefUQehp3V9mQkRKBDfN4rBB7XqkIoZqQcHcfWGzGXhP4JX//Mvz73sKg?=
 =?iso-8859-1?Q?2fEHnqiwpd7dNcMPxPfyWXu9f16N8QilnvYL66FIdJZ1wOFXrjPEQxFrUz?=
 =?iso-8859-1?Q?pW41TrjX0x9vIYfmKqqdaScbpK6tqp7HyqMTtw+7H5fNbkQScP5mO001na?=
 =?iso-8859-1?Q?G5jzXVbygLabARvd0UuR09zJVfRHOeLYHMX6i64/+vJhqOj8/J270RLEvu?=
 =?iso-8859-1?Q?OrTA6J7yK1kR0gNO9bHwSHw2e4t+r9mVLND9bR/+UBmOpYRsGLyj2UczOF?=
 =?iso-8859-1?Q?Pi77K5ZoK0ymceFEDONOVa2h9KwHT/x9QuZkrRRnMN6YanqsZv34mT/gCu?=
 =?iso-8859-1?Q?PCk0V1WLN/8geq1T61raiQbCQboL/wUYNVSrZsiYly002diPZxfo8ul+ZU?=
 =?iso-8859-1?Q?m5SJ1Mnvgdf3gkVn6ctxlLi7MrwDLU9pH5hqw2tHbm9JHx2mWoINi5awCC?=
 =?iso-8859-1?Q?ycmHQDLdk3gHrLWtU5yYNZAeP9XM7tNizXAhuYZd02TSL5HUgPCQNoWgX+?=
 =?iso-8859-1?Q?ojSe6tEs7yVBOc1569Iub8svbOLBvhmaDKGi3Ees6m1KRt6iNaXy0M4vef?=
 =?iso-8859-1?Q?iBsSnTSxrZhkQEGT4gV+lvMCHG5UUs+sGBsZUEb3sw13+OKAS0+3Cy21qO?=
 =?iso-8859-1?Q?1WDiD6fWgePNDxy7kpvPVludRmEdI4aETUQXmjKW2JE/RcCVEvn60v/Fug?=
 =?iso-8859-1?Q?2DK7mlzh/rjZ/apPGKDf2jzB9cMoQOrpSx/KbLQrtrA+vsRWP9w5uL5x8M?=
 =?iso-8859-1?Q?bf1Qu1zntG1qewdVUD3fETgBDLva9BCptchWzqgmdNaDF7L/VyViln8qIW?=
 =?iso-8859-1?Q?qBP1u45gpROaf128DZbMLxNmrn7EJhHzkelyjYJiIRHeR/C3GssqnQLKJq?=
 =?iso-8859-1?Q?rLb6ECWtttTXJtqrKZ9+w1EbiOIQs+EnhM+XsC+CTjeqOyZERIVLPcPyCx?=
 =?iso-8859-1?Q?mjaz2VBPD9zKN9pj1XhqlgStTCsRuW3N3EOA9FGPTE5lKx58JMBUA8CHjT?=
 =?iso-8859-1?Q?BkcjFfAqlYsk8iovH+ig0Y2tadZsyLghmaeQ+K7XTy7JqIXegHT0Yzuyd2?=
 =?iso-8859-1?Q?s5pzLfVNvXVOMQdJVoGQPx8ZJunxI8TP0383W7v8e/Kxo+zwk1DoQrBsNg?=
 =?iso-8859-1?Q?KiarI4kpraaELumUlfkQtdy++MPkYpaENxKis20jqty54X++sRj4Crq/rz?=
 =?iso-8859-1?Q?5qsaDjNmoU3+39KVhIT+AGGysfYZret3f4jT5w27/gXg4av7Dj0o1s+mir?=
 =?iso-8859-1?Q?7qSGqEXEC/VnR4obnWRwoKrcilcbFreW1XpHuD6TSz4jwsmKQVcLs1vV+P?=
 =?iso-8859-1?Q?/hpyhc4R/HoRkrTmGv46Rnw3E00cQzbOmTo2Jsqs9lXycMvK/+4s8X/UHO?=
 =?iso-8859-1?Q?nxhfhX8RR35Ijy3v0/io/0Iyu+ZVthDl57g3erQgV8K1lQji1y83uNwurG?=
 =?iso-8859-1?Q?dB1yAq7bXw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fb9fb7-3c2a-4622-78a4-08de7433c751
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 06:04:46.9158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F1xSeIMSlfOFK+1bsgy1GFZ6J22kRSZswNSfyHgM4dnvorIZlbumSWK1a2h9JKS9eifqYyiu3bXKiswVdLjufCnBp5ThyFjonR1R8A7+RLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5927
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> Subject: Re: [PATCH v7 06/10] virtio-gpu-dmabuf: Improve error
> handling with 'Error **' and err enum
>=20
> On 2026/02/23 17:00, Vivek Kasireddy wrote:
> > Make the error handling more robust in virtio_gpu_init_udmabuf()
> > by introducing 'Error **' parameter to capture errors and an enum
> > to categorize Guest and Host errors. This allows for better error
> > reporting and handling of errors from virtio_gpu_create_udmabuf()
> > and virtio_gpu_remap_dmabuf().
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu-dmabuf.c | 65 +++++++++++++++++++++++++---
> ------
> >   1 file changed, 48 insertions(+), 17 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index 8d67ef7c2a..fdcf8e53a2 100644
> > --- a/hw/display/virtio-gpu-dmabuf.c
> > +++ b/hw/display/virtio-gpu-dmabuf.c
> > @@ -27,7 +27,17 @@
> >   #include "standard-headers/linux/udmabuf.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >
> > -static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> > +typedef enum VirtIOGPUErrorType {
> > +    VIRTIO_GPU_NO_ERROR =3D 0,
> > +    /* Guest is responsible for this error */
> > +    VIRTIO_GPU_GUEST_ERROR =3D 1,
> > +    /* Host is at fault for this error */
> > +    VIRTIO_GPU_HOST_ERROR =3D 2,
>=20
> include/qapi/error.h says:
>  > - Whenever practical, also return a value that indicates success /
>  >   failure.  This can make the error checking more concise, and can
>  >   avoid useless error object creation and destruction.  Note that
>  >   we still have many functions returning void.  We recommend
>  >   . bool-valued functions return true on success / false on failure,
>  >   . pointer-valued functions return non-null / null pointer, and
>  >   . integer-valued functions return non-negative / negative.
>=20
> Do what it says. Non-negative if *errp is set. Negative otherwise.
Ok, I'll change the values in the following way:
typedef enum VirtIOGPUErrorType {
    VIRTIO_GPU_NO_ERROR =3D 1,
    /* Guest is responsible for this error */
    VIRTIO_GPU_GUEST_ERROR =3D -1,
    /* Host is at fault for this error */
    VIRTIO_GPU_HOST_ERROR =3D -2,
} VirtIOGPUErrorType;

>=20
> > +} VirtIOGPUErrorType;
> > +
> > +static VirtIOGPUErrorType
> > +virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
> int *fd,
> > +                          Error **errp)
> >   {
> >       g_autofree struct udmabuf_create_list *list =3D NULL;
> >       RAMBlock *rb;
> > @@ -36,7 +46,8 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >
> >       udmabuf =3D udmabuf_fd();
> >       if (udmabuf < 0) {
> > -        return;
> > +        error_setg(errp, "udmabuf device not available");
> > +        return VIRTIO_GPU_HOST_ERROR;
> >       }
> >
> >       list =3D g_malloc0(sizeof(struct udmabuf_create_list) +
> > @@ -45,7 +56,8 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >       for (i =3D 0; i < res->iov_cnt; i++) {
> >           rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false,
> &offset);
> >           if (!rb || rb->fd < 0) {
> > -            return;
> > +            error_setg(errp, "Could not find valid ramblock");
>=20
> It is a valid ramblock even if rb->fd < 0. It is just "incompatible"
> with udmabuf.
Does "IOV memory address incompatible with udmabuf " sound better?

>=20
> > +            return VIRTIO_GPU_GUEST_ERROR;
> >           }
> >
> >           list->list[i].memfd  =3D rb->fd;
> > @@ -56,22 +68,30 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >       list->count =3D res->iov_cnt;
> >       list->flags =3D UDMABUF_FLAGS_CLOEXEC;
> >
> > -    res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> > -    if (res->dmabuf_fd < 0) {
> > -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> > -                    strerror(errno));
> > +    *fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> > +    if (*fd < 0) {
> > +        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl
> failed");
> > +        if (errno =3D=3D EINVAL || errno =3D=3D EBADFD) {
> > +            return VIRTIO_GPU_GUEST_ERROR;
> > +        }
> > +        return VIRTIO_GPU_HOST_ERROR;
> >       }
> > +    return VIRTIO_GPU_NO_ERROR;
> >   }
> >
> > -static void virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res)
> > +static bool virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res,
> > +                                    Error **errp)
> >   {
> > -    res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> > -                         MAP_SHARED, res->dmabuf_fd, 0);
> > -    if (res->remapped =3D=3D MAP_FAILED) {
> > -        warn_report("%s: dmabuf mmap failed: %s", __func__,
> > -                    strerror(errno));
> > +    void *map;
> > +
> > +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> res->dmabuf_fd, 0);
> > +    if (map =3D=3D MAP_FAILED) {
> > +        error_setg_errno(errp, errno, "dmabuf mmap failed");
> >           res->remapped =3D NULL;
> > +        return false;
> >       }
> > +    res->remapped =3D map;
> > +    return true;
> >   }
> >
> >   static void virtio_gpu_destroy_dmabuf(struct
> virtio_gpu_simple_resource *res)
> > @@ -125,19 +145,30 @@ bool virtio_gpu_have_udmabuf(void)
> >
> >   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > +    Error *local_err =3D NULL;
> > +    VirtIOGPUErrorType err;
> >       void *pdata =3D NULL;
> > +    int fd;
> >
> >       res->dmabuf_fd =3D -1;
> >       if (res->iov_cnt =3D=3D 1 &&
> >           res->iov[0].iov_len < 4096) {
> >           pdata =3D res->iov[0].iov_base;
> >       } else {
> > -        virtio_gpu_create_udmabuf(res);
> > -        if (res->dmabuf_fd < 0) {
> > +        err =3D virtio_gpu_create_udmabuf(res, &fd, &local_err);
> > +        if (err !=3D VIRTIO_GPU_NO_ERROR) {
> > +            error_prepend(&local_err, "Cannot create dmabuf: ");
> > +            if (err =3D=3D VIRTIO_GPU_GUEST_ERROR) {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "Cannot create dmabuf: incompatible mem\=
n");
>=20
> s/mem/memory/
>=20
> The log is not that long so we can have a full correct spelling.
It was going over the 80 char limit and I was reluctant to split it
across lines.

>=20
> > +            }
> > +            error_report_err(local_err);
>=20
> This prints a message even for a guest error.
This is intentional. My thinking is that if the user did not enable logging
then it will fail silently in the case of Guest error. So, I thought it mak=
es
sense to print an error regardless of the type of error.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> >               return;
> >           }
> > -        virtio_gpu_remap_dmabuf(res);
> > -        if (!res->remapped) {
> > +
> > +        res->dmabuf_fd =3D fd;
> > +        if (!virtio_gpu_remap_dmabuf(res, &local_err)) {
> > +            error_report_err(local_err);
> >               return;
> >           }
> >           pdata =3D res->remapped;


