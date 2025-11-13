Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9DACCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 03:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJNpr-0003Jn-Di; Wed, 12 Nov 2025 22:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vJNpp-0003J7-2R
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 22:17:21 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vJNpn-0005wE-4M
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 22:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763003839; x=1794539839;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qM51bUFYxLSHJu4iIobQeL0m4FvTgSx5BeOG38d2LAI=;
 b=SEsFGEcNt5J/ly5rr18447z3YLUaP9Tmy1hxaiTZToFk2P1B+xwZrJco
 rqFPNrup6rS5FEuGJiO20cqBpX3To6WxD0PCX7dOWac+LhDB1S9KUWTc0
 QQa6yUbN30qS33vQrl8zVcAXBmXqfB2+TiZr/3xdGt1K4mUj9eyeGNMBP
 By0yQpsXiHAoN+z6zXWSdhi2eRYD3R3Q06R0cm/QaOeFCkKkv6BAOjKiL
 lTte4CckB+fLwKlMcKkdg3k/5AT/p0SdUvQmum9RPAjQ/uiXoae6ADmfs
 17ln05Mz/fF/B3Q6EzCXx5CHLs+UunvzdMoM7HG+rYWafbKfvIiVlxlHg g==;
X-CSE-ConnectionGUID: lqbBVLeFTUG3M7u9t4NTQw==
X-CSE-MsgGUID: gtsaOr2IRp6zjc2VQj4a0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="76423814"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; d="scan'208";a="76423814"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 19:17:16 -0800
X-CSE-ConnectionGUID: zPC6jNW+SAmvqZOSkdiGnQ==
X-CSE-MsgGUID: +KNf9J2sQf2Fn7fkBYGwog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; d="scan'208";a="193778781"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 19:17:16 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 19:17:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 19:17:16 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.16)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 19:17:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygl1OWbuGFpKGMg8CCUKnaPYOQkAXCAOt25ZvE9DQomnViCQ0d+xus2nfs+onZIXYn2S+6Ck3TUznz2bOGdGizxC9w+MydGnQH04tvPfPvjPAF66SxihyYO4AU1Zdv4iVaZp2kv3AxLgQFXfNU6rS0RnFIQzdlxsFQKj27ZdSk7YVhX+GsKxLyG+5NvGnj1jzpda/XRnPSJUKkW0YrGbgghXkNSuCxXcnjAwSEf3gHl9eRED+K/vFhCjd131s/ikQ/wp+S/j1tDKJAngDuAOR70W9Y79mxAd95MwdGk8g2bD5X2DV/tWgjpNvVdECUZl/086pLAwTL3uOlF1QWpxFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJrJonO/bdo8QWjhR0lLdEypdNEy4vmtjnwMq+/9bbE=;
 b=Pa6mYOe79FOyCRyzgXAit/bU8pnz2TwpepYPUZ3moV4/j4ZKcwu74ARpnhG/YajY8xSxVJSIUtFoIaebde+trF58CwS7KqIl8kHIjnWgzDPUZ/bZ4/6++jLgVh7q1o+gG5UlfsHLDEHEuO2QvyVXX/1jrLv3f77WsTuBMrdkFzDUGkLVKFd0hQE17xmByzs7KZI2rClPT98vYmuEsXWe40Tpeyn5rNrcqXxVlifSOq1vdiQReiRwNnj7qmAybFY2Ht8pniGlCAnieJyKXX3q5tjhqmkuOKlwIP2oeW3+3DaUtrPvurodFb40aRJQ450ke/x6+bTyuM9Z3E8To2LXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by IA0PR11MB7401.namprd11.prod.outlook.com (2603:10b6:208:433::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 03:17:14 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9298.015; Thu, 13 Nov 2025
 03:17:14 +0000
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
Thread-Index: AQHcUTsgsJEAjPPBdEeeacaZ/CcvobTrWiQAgAEUO2CAAkjDAIAA2a3w
Date: Thu, 13 Nov 2025 03:17:13 +0000
Message-ID: <IA0PR11MB71855ADFEEC4E3267B464768F8CDA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-11-vivek.kasireddy@intel.com>
 <5c224e00-8114-4586-b502-3819770bc8ff@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71853FE6CD48B77FA586B628F8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <3c0fe9e8-7efa-4936-b5ef-5cabc4239cdd@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <3c0fe9e8-7efa-4936-b5ef-5cabc4239cdd@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|IA0PR11MB7401:EE_
x-ms-office365-filtering-correlation-id: 0b58076c-38af-419d-adf8-08de2263245e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7v4SAkfeJF0ktr2B0tOIAdaYUcjXrRxv2/UtXsdLrnBpaN63HuetUM2pjX?=
 =?iso-8859-1?Q?ZsppqiJqTlI65+m2WcZpqmuLrlESJB+kfiuSg8ISo900Zsoq2enjtJLBhe?=
 =?iso-8859-1?Q?UQdYAexTWq7vswMqGIyJH7enTYzsNbhZF1uJCiD3NlD6bg5yxsBj/8r/19?=
 =?iso-8859-1?Q?MYoU7rqH4gYzu4WTLv9y/YZ8G1rePwKk7wexGst4UI7+7BQPVnw7ZAfdl1?=
 =?iso-8859-1?Q?AOGwUDeeuPb+3OBXPlUZfuhYBYpjDqR6e/dyZsggOeOYLOXsaLO+dwk+Wv?=
 =?iso-8859-1?Q?DSOGX/3hiGGVkT1h7FNlW9PW7AtiNMosHUx2/hU1MBhjxTd95DiQhmcxaX?=
 =?iso-8859-1?Q?l+gtzkWL9xEJvkZ6XkQSZdU3LKfQyGLvwIyS2NJoPOcf5cYykxnkw3DNyE?=
 =?iso-8859-1?Q?xcUNB+KLoiXawKhi/5Qh6k8GhDUDZN1BIjPZ0Hw/ky/MCDhAiq8dxx2kcV?=
 =?iso-8859-1?Q?XanyOayt1lMM1trTZvfbYdIwrQ7ok72dHmeGMbHEufLh3o/WpIBknhc38K?=
 =?iso-8859-1?Q?KstM2lqMYJMlgSKiVk3bm1EWRtL31s1ksw/4K1vjUvJXVvaoD1gvTMJ//1?=
 =?iso-8859-1?Q?8dzkn300mnP2rglMGySCGdJI67RSiq5lFNGHIZK7qesF0WiQDHu2++NHdQ?=
 =?iso-8859-1?Q?RakneKlVE65UGVL2J6q0U5wylTObOgNJRPL8uUy7JUieWaHebX4cwGXOl6?=
 =?iso-8859-1?Q?qeBv3j8OzaJ8ozeClRK6kNRsd1WffdKnymtPE2JZz8OLLvGN+U8vkyhV1L?=
 =?iso-8859-1?Q?s7Bu99puddBycMA3P+EnKDvmsP1hiPfiMiQQ/52eINzTMehsCPsTOxsOrv?=
 =?iso-8859-1?Q?cKHk5PgF1k8ZAIyBZaXdbTwzLpZMIvNIpTvGUq1tyuPcuFR1r4LnccO3tu?=
 =?iso-8859-1?Q?vxGTIdSG3E6WTLr0KCzijo3imzOkIF9KiGi6n4S8Syb+b2QqTHMSRELFwK?=
 =?iso-8859-1?Q?KynMePcUHcQQN9OpOU/priU8VM8GVgNGMoBVvUASWTxDjSJd7HB2rAJAi9?=
 =?iso-8859-1?Q?/y2+R7/aFcgSe/G74ag4SjO5BsOJQrLMM3MmRmu8WuwZ9XZ7NCdgwoAB+T?=
 =?iso-8859-1?Q?IXZ93Jm4PMZ5ucMnr2jwyTS8yl5L5JKz+h1UitD3Sch2uA+ORb04w5Jubs?=
 =?iso-8859-1?Q?eGgpSSBnwZTrPMHySAQDDd73M+UbS6nQP+j94b3U6n02CzLbsRwJqUw6p9?=
 =?iso-8859-1?Q?npooOwXsNXg7fNGtT4wNLZQ5m0EfwBXIjr3IkV30V/mlCIv7n/VxsUrSp8?=
 =?iso-8859-1?Q?Qxf4Dq9wOFsq8E8b07Sw4Gb0rLjrLaXRqfyxI55uAiQWtINuufenZaxqA8?=
 =?iso-8859-1?Q?UBLLotnCT8zzZF+oQIHcvUDAfM2wAHiog7/GngvmwssloZSqcA9jtdHyWV?=
 =?iso-8859-1?Q?HsgTdDtqkdyhaIYFcY9UjJ63YRo1Ej2DIy6+khQUm9d5cj0YBI+aRp1i01?=
 =?iso-8859-1?Q?FBpcle5GcNP8n7v4O1yEVyQDlTYe2nfzQ+2pM4yUMFZiIJxnoaZuON/2Ht?=
 =?iso-8859-1?Q?tWmwPvBQr+JfUWGiLPiVr80NI3J9+JG9/SQwa/Z3xUSHl9xHlPH7NW33lD?=
 =?iso-8859-1?Q?ijfNMLqmUs59NgbKZTLjQhz1PSRJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hZ0/uCLRVsqKNqtBfpLCUX6IQOO8cmQxnIq7DuYsE3sTP4hyxK3QFH6w10?=
 =?iso-8859-1?Q?znE85Otp+cKP27W1OFyiejvtFkSpxO7F9YPC1ShGikW6oGLXon457cqG2g?=
 =?iso-8859-1?Q?+AHTLwZ11NDObOQHfGgeUvr7vhz8AQ4bVzmv8RXxTwjeounAr/ZMU5a3zp?=
 =?iso-8859-1?Q?jLgulehkeqv8Jev8V+cfROjqcNP4zai/aJwYrqy5x6/35j4LZfp09NTmjy?=
 =?iso-8859-1?Q?+38xO4AhKd1YBwIyhK95PfzgqPvisd1Kvs768jvRitM2LqMmZGPydUDqnV?=
 =?iso-8859-1?Q?g6l7hyFqf42yPp5zRgF0+CD3boXseI/91/t2Rozl/s1SQlB1+Ov6VyPQ46?=
 =?iso-8859-1?Q?Shg8VClrAdDiRaIGXPkbkuee9GfUKlXOj6Yz64HL31PBu2v7M5GQ1bbdfY?=
 =?iso-8859-1?Q?Ja49I4Cq9UkAeoNVxTn/le96w1p8LbuNYt7X/ptC0i1VQ+a2zLqI2HHe5i?=
 =?iso-8859-1?Q?n4GDaDM4yaHR8yUlRstvmHe1zRco2mcHzqwOgH0k9HYfrb505CgN05eL9K?=
 =?iso-8859-1?Q?CZpe2mmuFP9PjsWUPRYxrRpfDGDz4oNSiCLJ7nfddz4rbVExQGAKAxhD25?=
 =?iso-8859-1?Q?UeEni0L/tOnCD6WiUjQDNKsWNWkPJSQDUoFZG5jXr5+JENiZyYYIGBFX4b?=
 =?iso-8859-1?Q?K4YLO6iiwncRiNpsw53S+6tc/BZBcWw09AckgXRWxJ1J3QcO6aXsltSCll?=
 =?iso-8859-1?Q?my8XQD+LAXy9giDesUUd96XITTNR6NR0pCJRsQpKQR6ctJQwuq6Utylgn0?=
 =?iso-8859-1?Q?lEcNHGdgXC466TtM/HYQD+qcaqf6Gr27iNbJ86Njv/t/CLUoqF4hs9Hlgu?=
 =?iso-8859-1?Q?Mi1UXzXoJ6o/3pViIdNR96LGqWz9OCZkgDyGoEqL44qBqCVffqwuVKwtvn?=
 =?iso-8859-1?Q?sgLWRgVBbZZCk0+mRbT2vJct8pMgSMHyGEtnkQqr2NMD6mphrgMKtQkuJM?=
 =?iso-8859-1?Q?rufH5iMlVrDePJusMixUCotd0TZVnsqh8V/b+cqPXVlC/5bynnH8goKG+K?=
 =?iso-8859-1?Q?1UEHaDYCSrONxTGffwLpxytriKECW/CLdeXLmDr/a9GfA+tuXApjRbKE2A?=
 =?iso-8859-1?Q?P48MiwS1seE0ts/JhlRLiZHn0CkyW9OXc5xF6xosoaZxzDc9M6Dynu5A1c?=
 =?iso-8859-1?Q?TQD2KMZKITPWZCp12ie4m11T+BJmwsWPxzDkuLowiAtnawlvdEBkutJ4q9?=
 =?iso-8859-1?Q?c013+nqyOKe54WR+KZaQqCTugVDjeauhKIKQIj6iEoglqXlJdFjJfJuN6+?=
 =?iso-8859-1?Q?/Np58eacSlssLuU4sWYktoIZ9a35lTCEARytQdOT9HMxD0o+ZcO707EYuP?=
 =?iso-8859-1?Q?iW74dYsK9uWhx5cU/QglvUesjiIJUYqXl7glj8iCqmNkml4crZZgzdZR+V?=
 =?iso-8859-1?Q?GD3XDr2CgQ4VvCYXZ50CJtatxbxb21k5x9xk/zNZSQ9GLm1s63kX0CdVzr?=
 =?iso-8859-1?Q?JpcXqop/WV62zTqY81GbsjsLG6fDwNipB/4VGmX8wGnYxdtbQU0jkzxsLi?=
 =?iso-8859-1?Q?7Y908rVMDvGZk+UncVmChcNckz6Bs8x7/AK5gUteuLgOGmiSGl7/ii2Zqh?=
 =?iso-8859-1?Q?cIyF4ypk70wL1NhX1hcFBO6k1oLkd5KAsdYVm9yirahZrM7NxDgV+Pb7e0?=
 =?iso-8859-1?Q?bQXG8nImFYOyrf487RwpZFKE+uLFk1he3f?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b58076c-38af-419d-adf8-08de2263245e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 03:17:14.0073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RBhsAEhCYuKYz2ajeX0l9bOQu12h7Vtto6HLIA5YbX5LtjfgeC0CVyZjyMBDKfDdR18D4+1UtA1GGCX5eLDIrNKG4fLiIk8DjevWERgYW9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7401
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
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
> On 2025/11/12 13:26, Kasireddy, Vivek wrote:
> > Hi Akihiko,
> >
> >> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for
> blobs
> >> associated with VFIO devices
> >>
> >> On 2025/11/09 14:33, Vivek Kasireddy wrote:
> >>> In addition to memfd, a blob resource can also have its backing
> >>> storage in a VFIO device region. Therefore, we first need to figure
> >>> out if the blob is backed by a VFIO device region or a memfd before
> >>> we can call the right API to get a dmabuf fd created.
> >>>
> >>> So, once we have the ramblock and the associated mr, we rely on
> >>> memory_region_is_ram_device() to tell us where the backing storage
> >>> is located. If the blob resource is VFIO backed, we try to find the
> >>> right VFIO device that contains the blob and then invoke the API
> >>> vfio_device_create_dmabuf().
> >>>
> >>> Note that in virtio_gpu_remap_udmabuf(), we first try to test if
> >>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> >>> use the VFIO device fd directly to create the CPU mapping.
> >>
> >> I have just remembered that mremap() will work for either of udmabuf
> and
> >> VFIO. That will avoid having two different methods and make
> >> vfio_get_region_index_from_mr() and vfio_device_get_region_info()
> >> unnecessary.
> > IIUC, the name virtio_gpu_remap_dmabuf() is misleading because we are
> not
> > actually doing remap but are simply calling mmap(). In other words, we
> are not
> > expanding or shrinking existing mapping but are creating a new mapping.
> > And, for dmabufs associated with VFIO devices, without having to call
> > vfio_get_region_index_from_mr() and vfio_device_get_region_info(), I
> don't see
> > any other way to determine the region offset.
> >
> > So, I guess I'll create a new patch to do s/remapped/map.
>=20
> I mean calling mremap() with 0 as the old_size parameter. The man page
> says:
>  > If the value of old_size is zero, and old_address refers to a
>  > shareable mapping (see the description of MAP_SHARED in mmap(2)),
> then
>  > mremap() will create a new mapping of the same pages.
It might be possible to use mremap() here but using mmap() seems very
straightforward given that we are actually not shrinking or expanding
an existing mapping but are instead creating a new mapping. Also, I am
wondering what benefit would mremap() bring as opposed to just using
mmap()?

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

