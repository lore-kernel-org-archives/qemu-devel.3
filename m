Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1028BD358C8
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 06:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlLlb-0001kK-4k; Thu, 29 Jan 2026 01:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vlLlW-0001iX-GF
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 01:44:31 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vlLlS-0004Tv-Gk
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 01:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769669067; x=1801205067;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Zw218QlyX/DvnGtbgW9DEhI1Pq+Vd9FeNDdDzy6cewo=;
 b=MTLay6yGQjq/a30WcBuqhEcqbmyVDbnSEUU82Fn1pFs4DgH/ULVAOyT3
 THMgR1EQE/H9J9qvJdP8obTgjejVlY7MRi511zcEt7ZQfekHZq5OAHR8i
 I5kgDXwQ0Gkj3GcS8rEJOZBDXfv+iuYg2UryAsRaNG4iirt7JX165G33s
 6sAcnsnh5Tm2TCGRT1o83zq6VrN7kyJckYUPNfWIqCg5NBnD7NGnnC2fI
 eVd5l12DWpafmEuBER3TceDpZSDC9e2aUdJaHQMsCkK6CDcyvPPYh4jMk
 YBlwUQnETmgjouOTuHhOXKxB2PeYAL9jeoyo7S5zmQP7T/8tWkq/YAgc3 g==;
X-CSE-ConnectionGUID: DSsacUuJTHiUuULwNvy6PA==
X-CSE-MsgGUID: 9t1WDTf1RM2LD/LGgQGa6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70612844"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="70612844"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 22:44:23 -0800
X-CSE-ConnectionGUID: 2a3FMw5ARk+b2ZjWhalgbA==
X-CSE-MsgGUID: 2DIiHLTSRHavBE9vRDp/vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="239738851"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 22:44:21 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 22:44:21 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 22:44:21 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 22:44:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/2NS/+lVVJgGutKKhJyomwsMqekEQgo+Qq7rTKL0fGvN12D4rxyKwRWOwEVLf2+2zpwWZV0+Num1NV9DpYrFFbr9Hh0vT5nG3yhaf3PGsLa8xBXnuLwBFyVFk3+0tbNc6enJ84klx4pfGl1Up7ZybF61ao7rXgIxtYUEi5ILBJboEDS8o+7WoUhLzXpBj8P75awQvNx3OT4nQicXS2svvq47MgysHMJ74D8brcgv6QY6Q/H1Ad/9lsyIRzlzmhi6AbedCjuERwpbiYoSAVTfQSfZU5oUxIZazyi3JkQToNzHk7Z5ip2Ubpj4p+2McscaF3UgBKu/95+gH9i38FhzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQnXIYTCM/6p0ZuP0xUvNyMf+/cXLazAksrn9zLsh6g=;
 b=OK6eTo3PYg/WMxm0jFmLU69tZalS1gTLyFt+Sq70+GtdHrkh0k5trpXyQlng1BSQO8EmiFXQSKt9foFgYYmPROw279IFPjPcxHYYRMQ4ipEpn4dC4EqcGi/9s84XAMeCfBrHMEP4g+Yi8pQDv4qEcMV315pIDECDDTTRRudBJlirkGsV75QO73Rz5BB2vXntk9fvULX4XiBPThsuCACAHXsyr0cfnCubD9cZntc4B77rTkc61T75yer0xBBpzvg7NQSjfCdtnxfo6pnLtN6X3Jhr2o5pV2h7GOcF0zoqHR0J/vpkuEgAgOfW7JpdcXZvK4ni+ETGNeLWQ0RvhYkRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DM3PPF027BB0053.namprd11.prod.outlook.com (2603:10b6:f:fc00::f05)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 06:44:19 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 06:44:18 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v4 2/8] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Topic: [PATCH v4 2/8] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Index: AQHcjDCeQw49HQKsGE+uYIqUk8vykLVfT2SAgAW++RCAAfXNgIABdJJw
Date: Thu, 29 Jan 2026 06:44:18 +0000
Message-ID: <IA0PR11MB7185A50C661BB777686D16A4F89EA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
 <20260123062042.568703-3-vivek.kasireddy@intel.com>
 <0d57e3df-3ae6-496f-b621-8d979e2ab3f8@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185FE7AA93FDB21AE6F8D14F890A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <2883c714-f03b-4381-920a-959a98380c23@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <2883c714-f03b-4381-920a-959a98380c23@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DM3PPF027BB0053:EE_
x-ms-office365-filtering-correlation-id: e3283ded-5d3d-40c5-e763-08de5f01d3e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3FktO9zF7VYafcSOxM4UA9UjEd88p38M2y9fFzYZlPHhu8tqSumSozrEfz?=
 =?iso-8859-1?Q?bQ3HxiZDG7Ys/iENJWaMuhcYcr/3/M5kW1YNsXwCxRuffsCR44ICI6wcpZ?=
 =?iso-8859-1?Q?VYSlEnQZGq8Hk7dPj8tnk/YPb2KCqJLYvQ4/ggkhI8YANQ4M4UrfaCHQQn?=
 =?iso-8859-1?Q?F2P/He578MCac37REFmnj4W9R6Btstrtt88iR+o+nmFilsGh7O2IsWttgK?=
 =?iso-8859-1?Q?yiMJpUTpdbuF6AOL/pIccvAJTS/QefEnO9cmI2d059F3oh41Kvb+i+XXzm?=
 =?iso-8859-1?Q?sIQwl7KYemdMNp3BorAPdtQIXlvdvJRViSKjJ4qQAvLiaeKaVQY9U+T2/f?=
 =?iso-8859-1?Q?J2IJxq1KJ5Ndn4F4fDEAuTSmReMSJ91lytL7G9eIFSf2xVAOnEIb5NDH9O?=
 =?iso-8859-1?Q?RTbPt3j+86khk3MrJEKe6q44OotZAkV/1hO/pgeNqkyFwEhOsSWQrhsnh7?=
 =?iso-8859-1?Q?cdnrTCjgbAQuwp/rWEKc3TGdVexDu2O1q7LAZhOJ047HEevwiYzGY0J/JW?=
 =?iso-8859-1?Q?Z0OnqzdEV2O2qegEEAYeXlJojri0of+n4V7vq4XG6uSy3mt/txz1MsjGM+?=
 =?iso-8859-1?Q?Gm+LA0rJuHupPPrUL4agfGjvGP99UNEzaURNmhmySiudQ8wKOD0XuD0qDC?=
 =?iso-8859-1?Q?/frw39ZvFrjAcyUV9hqw2HKcXRhKwzo1U13MGC+Gdh14vJSxDdJ7T+Oeg2?=
 =?iso-8859-1?Q?z3iBSvLMqGYgu6lThXG4q+4H7yZ/KeYXfPsA4+e6U1Xs44qYvLm42BbLhq?=
 =?iso-8859-1?Q?v70ZIa2+ngRUu3evE86IyuP+mkMKEyj7Dt2GYCdtLJzZOXHvYyZbHFgubk?=
 =?iso-8859-1?Q?SV/q3Nt640rZ6+8kz+mWz6LZdUlUBp5x+mkyetNXrUXnvIMOsVytFWU8Db?=
 =?iso-8859-1?Q?6poMtJjnAxoc+vq2QdVIXOVTBKuKrM/VkJq2Lq8eJT39Fb5B+ijGXs7h1E?=
 =?iso-8859-1?Q?DdbMc13gmzIGDY/mxcZ41cbj1HMrAabMB2lFZpF8pvuE8SnckeenIx2luC?=
 =?iso-8859-1?Q?DWxX564/2/zJC7v99cXDT30tYNpzKCtNI3lia6fru1r05JKRhHm2bWtJUC?=
 =?iso-8859-1?Q?qlFsa/Akt4Iden3o4hnwE5/54FyCEPcKBBNrWJ0KpYcLjb3MKFrDgX7TDl?=
 =?iso-8859-1?Q?ck71vJuB06gUOpYnEoMcjhjVGQyg7FVnuGR71iZzYr4vu6lqCqT3XyFg56?=
 =?iso-8859-1?Q?gn8XxeiUBurRdhdavHwVNf66YW0KLnZmyHBaaDAtP27umHJiO43Iwg3Ofz?=
 =?iso-8859-1?Q?9NFG2deAg/CZxUrZMj+K9SrQ3hUj/TG37PKUUZ7LkwIhXW5V+4n6tyTzGT?=
 =?iso-8859-1?Q?E0uO0BtZK63j73r+vuxYauXWybhesO/4LQCGhxw2kQtRzKU2bc4HAdTmMw?=
 =?iso-8859-1?Q?4LMJl8+HSvJTE2FulAn/wX5AyzGDpH4tdHAu6rbSFfn7sAJV5G+XPXBXJy?=
 =?iso-8859-1?Q?orVuxwHoNSIAPD14PheXWbl+hICoW/Ye8kvDaSsGWWo3G5U34fGP6aclR8?=
 =?iso-8859-1?Q?7HU+zyyLOzzReFhMwLuL0tRjhvk+OFE5lh0e7BPBswX/vDiutnfX4kUMra?=
 =?iso-8859-1?Q?+haWHTMYtsUsr3i8o2vYEmTnwXU1Qj61lM0Bk93a182defBvjV38DV9j2p?=
 =?iso-8859-1?Q?IqHwVIQRCXY0UYxd/YPTzVSGhH/v/PXjZ3reL3RCPU3yJirY4xQncfmkXs?=
 =?iso-8859-1?Q?56/bRfycjPUr8jQ7n4Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hh93v+wSO26w6oizVTOo0jWxCnlA85sgz7H7wMNnvMnX4SPsqvt38EEjxE?=
 =?iso-8859-1?Q?kzLgPx/tND8CkJcJ0u4u5N+pU3pbaM2CVCx/Sc1fsy1ipyWUZfW2WReEUg?=
 =?iso-8859-1?Q?h5bsEP9Wb8+SacLayw86Xiq8YCzBK57aJC+cgM5f94hI1dJWfJllwMxl3U?=
 =?iso-8859-1?Q?M2Ti5U+9LrNsJHY2FyQNoyGnHNCb0l0Yu0HvK61y79dcIw5pWaxadsciiq?=
 =?iso-8859-1?Q?jpqaODkDAB/ehB+DVNnNS7dqmigtjfl7DX/jJLrgZJhdU0dbeEzDfaF3UG?=
 =?iso-8859-1?Q?LZ7vZaUzTnuDOgqGZvM7dbsMitX8FecmDEP+oOVFxIMEk34MCnLIUdd3BR?=
 =?iso-8859-1?Q?Y0ptpJ1YdZ9Rj1OsueKwjMr17P5VNzVZmoJ+gXuI9l0zy3abziiyyZfAYJ?=
 =?iso-8859-1?Q?B/kSBkoLI5PsQu+RAuHByWVNRGllUyAf4Tb78+g1m1plSVaK2Za9JKDKcp?=
 =?iso-8859-1?Q?iQxoDz5lz4UWNzbpr0si7DwSkbpNEulYIFcePvgE6rRD8cB55mjxWAl2iJ?=
 =?iso-8859-1?Q?RYn/7ftOXJT9n0ooG+Gr9rMtQQ9psizClhhVg10GteYRAs/PU/vasC513D?=
 =?iso-8859-1?Q?xQv5b6rhbUFCPUmFkF2E9rxrO1JFZCj2s6VjyOGbADYvYcAimStHsszqLp?=
 =?iso-8859-1?Q?zhq36LlRCUIfcJtyBxu7Fq6MVlp3XERPiwS1ggQOyLNCi1tzXLq8FhHOLH?=
 =?iso-8859-1?Q?cbHAaETZ16sh1PE96mWUcUkY+THvw3UbG5rcOUu4zBnAqzGs8R0FYtQo/D?=
 =?iso-8859-1?Q?vGEgVdyXHIcaAwXkIrmALad8YVmZa/4H8qWvu2QaJPGFlyxWGjW/dLX2/r?=
 =?iso-8859-1?Q?E9mk11rqXLKWT7uXYPdsNebMgOwKDlxcR5OLWEjFy3xl5aZRGvGLHt8vRb?=
 =?iso-8859-1?Q?joj+LnrfQCsvk/Xrr34looi0pvDIdu4oH35dcGZH2ShPtHLJl0m0I++zV1?=
 =?iso-8859-1?Q?m/Z/2cNK+sfET9bsg6jRqL9+yof2ZpSTBHib9ECutXd+7pLVszxD/Lkwx7?=
 =?iso-8859-1?Q?8AxUJQaoKcQhSNdYNWRFfueIdhGL5vfdLutqcJHG6Sy+65BAsAPnar5lCx?=
 =?iso-8859-1?Q?yD1GxzpS9Jh5YTIrv/dOevnSArigumXuL1TOWIFG30GbASi6/Ba0U7r1s8?=
 =?iso-8859-1?Q?vnNCi1ltCSTsNh5z4KOQvFX/fRneZNZv034tyQ8Ezo7ba6U2gk/NTNa/37?=
 =?iso-8859-1?Q?e9cTqcZO/iftL/Ug+tsEDFW945dDFoH+ZpFErfic5Vbg1KeDxK21JGGdwl?=
 =?iso-8859-1?Q?iUp5HzmE4VaGNo3BGAdWv5icog3eqiu+f5iTODkHXA68pGFINcuh/1O39y?=
 =?iso-8859-1?Q?9r+I6TyfSbTivs7O7MfGeOoe6e32Vsk8+JYJBOVOBPm/Lx8Cq82eJVZmms?=
 =?iso-8859-1?Q?y0KS3ZdPOzc4q79eW6rUUXp1lb5jiEtpxiDf9tuC6tsxOswtS6lRR463Gw?=
 =?iso-8859-1?Q?/Hgmoi6kuttG5RwHQWBr3GjWGDcByXfF9JD+SfrksKrJhAnGpO1nVTi18b?=
 =?iso-8859-1?Q?iGZW2HUrfcCxvebCvjW5XK9wxY8yC7a4TajGlvNhUUAbjZRDkI6nIWb3Gb?=
 =?iso-8859-1?Q?5prnjD5fzsYtlVXGDpD8KTzSoIXdh5hXKQ8OkL40gisBKrl6hjSO1LzTx/?=
 =?iso-8859-1?Q?KK9u3mLjpW3X6C44BOZa6ko6yWqtxOhmaFRpDHJ685/A5eYl9rzL+doFvb?=
 =?iso-8859-1?Q?gLpq4jQgqqyYxXvX+HB0G+uWL6DKpoJ4Rzz6vh4Xm+wA5her4dF4MP2MWx?=
 =?iso-8859-1?Q?8ztEJsnpkgD2PWvWyrey0YZB4HbtysX9VsElAdjlFekTkyUcmGlcecK/yj?=
 =?iso-8859-1?Q?MvZNwMbXYw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3283ded-5d3d-40c5-e763-08de5f01d3e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 06:44:18.7174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FFtbz+UhQ+y0Yw7i3NPxt34EVGc5yOLEL5jRk5j/k/h8zbxOYXhzZ791AwqeFzqlneRZ3t3UM3kIpSLj/b5AGwl4nX1DYrtFvt+/FzP5RFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF027BB0053
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
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

> Subject: Re: [PATCH v4 2/8] virtio-gpu: Find hva for Guest's DMA addr
> associated with a ram device
>=20
> >>
> >> On 2026/01/23 15:17, Vivek Kasireddy wrote:
> >>> If the Guest provides a DMA address that is associated with a ram
> >>> device (such as a PCI device region and not its system memory),
> >>> then we can obtain the hva (host virtual address) by invoking
> >>> address_space_translate() followed by
> memory_region_get_ram_ptr().
> >>>
> >>> This is because the ram device's address space is not accessible
> >>> to virtio-gpu directly and hence dma_memory_map() cannot be used.
> >>
> >> This description is a bit confusing.
> > I agree; the description does seem ambiguous.
> >
> >>
> >> The first problem is with the phrase "the ram device's address space".
> >> The address space we are dealing with is always
> >> VIRTIO_DEVICE(g)->dma_as. More precisely it is a memory region, not
> >> address space.
> >>
> >> The second problem is that it says the ram device's memory region is
> not
> >> directly accessible. It is usually true, but here we are directly
> >> accessing it anyway because the guest knows how to do so.
> > Does this look better:
> >     "virtio-gpu: Find hva for Guest's DMA addr associated with a ram
> device
> >
> >      If the Guest provides a DMA address that is associated with a ram
> >      device (such as a PCI device region and not its system memory),
> >      then we can obtain the hva (host virtual address) by invoking
> >      address_space_translate() followed by
> memory_region_get_ram_ptr().
> >
> >      We cannot use dma_memory_map() in this case to get the hva
> because
> >      it can only be used with addresses that are associated with the
> >      system (or physical) memory region. Therefore, in order to handle
> >      addresses associated with ram devices, we need to use the
> >      address_space_translate() API to first identify the right memory
> >      region and the appropriate offset within that region and then use
> >      memory_region_get_ram_ptr() to get the hva. This approach also
> >      works for addresses associated with the system memory region.
>=20
> Sorry but I don't think it's improved much. It still contains a phrase
> not well-established ("system (or physical) memory region").
I think it is well-established given this line in include/system/memory.h:
/* address_space_map: map a physical memory region into a host virtual addr=
ess
and considering the fact that address_space_map() is called by
dma_memory_map().

>=20
> The description of what the logic does is expanded, but it's not really
> useful; it says the logic is to add the offset and the retrieved
> pointer, but it's obvious if you read the code. So let's focus on "why"
> the logic is added instead of what the logic does.
>=20
> Below is my analysis on "why":
> First, let's stick to the phrase "direct access"; its meaning is
> established in include/system/memory.h.
>=20
> With the concept of "direct access", the underlying problem being solved
> can be understood as follows: dma_memory_map() automatically
> determines
> what is directly accessible, and VFIO devices are considered not
> directly accessible because such accesses may be part of MMIO. But
> virtio-gpu is not doing MMIO, which leads to a disagreement with the
> function and virtio-gpu.
Here is another try:
    "virtio-gpu: Find hva for Guest's DMA addr associated with a ram device

    If the Guest provides a DMA address that is associated with a ram
    device (such as a VFIO PCI device region and not its system memory),
    then we can obtain the hva (host virtual address) by invoking
    address_space_translate() followed by memory_region_get_ram_ptr().

    We cannot use dma_memory_map() in this case to get the hva because
    it can only be used with addresses that are associated with memory
    regions that support direct access. Since VFIO device regions are
    not considered directly accessible (because they are mostly MMIO based)=
,
    dma_memory_map() would fail to return the hva for such addresses
    when invoked by virtio-gpu.

    Therefore, in order to handle addresses associated with VFIO devices,
    we need to use the address_space_translate() API to first identify
    the right memory region and the appropriate offset within that
    region and then use memory_region_get_ram_ptr() to get the hva.
    This approach also works for addresses associated with the system
    memory region.

    Note that, although we take an explicit reference on the memory
    region, we would still rely on dma_memory_unmap() to drop that
    reference when the dma mapping is eventually unmapped."

Thanks,
Vivek


>=20
> Regards,
> Akihiko Odaki

