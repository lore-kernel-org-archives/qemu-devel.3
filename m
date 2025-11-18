Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94539CED240
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 05:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLEB5-0001dT-Pa; Tue, 18 Nov 2025 00:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vLEB4-0001b4-3r
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 00:22:54 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vLEB1-0005HA-3e
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 00:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763443371; x=1794979371;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=a0786cJjSpoJCmSUpJv6l2XLZ5MjNRujFyYBBVixSAs=;
 b=AplJBSe6iVsihZyBBTXIxidJR0woXgAKE9WqZBmN778VeaxWPpDHJY/t
 ta6l5adq+KutD07djFXCTO9wy/GLpzlBEB2b9sgaZ5ZmcKwYXAfYzkL3/
 mAVT/W1ZmpggbE3XCDbbYTTtoBCc3fg+bvQyDPGZTWncox8UcrqqQko0Z
 H1o0xbT2lSFqlFGXPP9LHRrAFhJREbl+YDhs1MNRhulCp0Vyh8fPrOZbG
 Yqw1mTnoSFfqZUdBbQIHmu1n1sUvqgdixd9m1uaY3Co7pKq/aaoDdATsm
 X0kw0qdGKVzRylePWNDulocSDPP3Cy5dj3a2RsQfxyaHw+r8ZDg02HEVR g==;
X-CSE-ConnectionGUID: ECVGw3bbQpaOAVVsw46+hg==
X-CSE-MsgGUID: 5AqAm2RHTGGf7/VipT9leA==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="53026885"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="53026885"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 21:22:46 -0800
X-CSE-ConnectionGUID: NbjcMHJlRha21/yH2dUyog==
X-CSE-MsgGUID: QTdspaTpSL+q7h8xOUmKHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="189920375"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 21:22:46 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 21:22:45 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 21:22:45 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 21:22:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAdNDVy0iu6nxgqvYXDXI9WLSeYNkSfyos4RUKDje2Z3BV8HHcW31hFBGeoccqmobyXHbD7JPjYD0xJgui2/BZctbXXy/GD+SyqUHDEJMTPOsSBUHn3sVg1kUJXZEQhCluCJNqpBDIV9xf3ByM0yx6etKm49lJAHPFy6WZ+kHVntFcikjzh9S0DU8bDZbXiAWt4PZe+UHf3Uf0BKBvApYesSu4DPsn1+lFRG/VozsTVw8QAj+SZU4kNV+68symrrrX1EUCOE4CeThWAMHFAa5jag0JIpYjYYK7xtANHCEXoje9zbC/7eNySUh1QnVY7QSD7o5stcHyNrB3t0fjGWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzDKjTdOjkc8TOwfsmt41fsnIm523jDxNrG5wX6dgnU=;
 b=U1zBdvm6LFjntM3loljTalwk72JzLvwm0aYScLjuYH2XyOGOojM0UNsiLxkMV9zd4m+MyqDuL4hp3/t4lEvLSNdnSp8jFw0qAWwikScU/RjaTGShAqz/tcaMkDmdp2mTQe0f2/0vO8kFeRn/0+oiZxHNL3jdwGuto+PYKeeQl1Q8eGn2Ba6s9uiJjpbxf3MRAh/EvuLENcEFj4yBYjJ4GXtUFP59P80It5iq23UntaklVIGOY46vT9Rw4ZOMvh8/WEKSBLjZ0RYY6R48sHPRc/BKVfEjf0icQN+SfBcpcka3dyK7j+j/90bD+EmxBmgoU9qBQgd1kACB3GzJZX4vPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CYXPR11MB8709.namprd11.prod.outlook.com (2603:10b6:930:dd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 05:22:43 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 05:22:43 +0000
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
Thread-Index: AQHcUTsgsJEAjPPBdEeeacaZ/CcvobTrWiQAgAEUO2CAAkjDAIAA2a3wgABopoCAARmAkIAFbe4AgAEEI9A=
Date: Tue, 18 Nov 2025 05:22:43 +0000
Message-ID: <IA0PR11MB71850777A66759ADCAFEB53EF8D6A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-11-vivek.kasireddy@intel.com>
 <5c224e00-8114-4586-b502-3819770bc8ff@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71853FE6CD48B77FA586B628F8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <3c0fe9e8-7efa-4936-b5ef-5cabc4239cdd@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71855ADFEEC4E3267B464768F8CDA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <8451c0ee-6c9d-4fbf-b1c2-05fd5fd8e4c3@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185D06DA886C3758E9B0FB5F8C9A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <8dcffe42-da84-44cf-a240-90680cdb0953@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <8dcffe42-da84-44cf-a240-90680cdb0953@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CYXPR11MB8709:EE_
x-ms-office365-filtering-correlation-id: cc91e30b-402a-43b6-4d38-08de2662802b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ZLNstdl59gMgkqdYeUITVbLiFIPhkN4YdWb8lVNGl5GftnUhYCu/+ePKrh?=
 =?iso-8859-1?Q?ogixklMgofaklde7SvL4A4jy7SIBEpVOUKjScE1E3zEIOM0bvawDAMTd5e?=
 =?iso-8859-1?Q?X0akoOyghQAzm+tBJ33MWJP2X3olbt0lDtvUtSBgLZwO7lvM0pZR/B73v9?=
 =?iso-8859-1?Q?OTm2NuuXbTmGgmc4WmXKeUebLqCBgaEPKUbLhz92aKFg8mYBlsQ6fgQWd1?=
 =?iso-8859-1?Q?7zumBl+gYDuFy3Q/bFfgA+zEtI61FXOuaFI6V6pjb+wcYuGoQpPhPp2or6?=
 =?iso-8859-1?Q?JVPcCJytCSYvKBJX3m7KugT5idwQbTuEdyei/Q+sRqaea0TsA5nkN+fBRs?=
 =?iso-8859-1?Q?HvVKrKjssMp3IdnXtL2oTQNhcRK6ZBrOQfudTvcrdF77uueCG6l9HHVOo0?=
 =?iso-8859-1?Q?W7Le67kzCi6QqsSit3kx88Y+xd8gh1kTm3C6GMPDT8m6e6q9Lh4upoIhUM?=
 =?iso-8859-1?Q?hWkVAKzcBh3lJZAQbgXMIsG2uw5Y7qW/rbBJHBw2nbjiwRvNbpr6xR7DRa?=
 =?iso-8859-1?Q?BvnDvxUkR0ApsclofQftKGB58HYNh8A1rzY4U581Al736uZQE/yctB5d4z?=
 =?iso-8859-1?Q?ybPpHk5IEffOIHbz/394Tk96uiqsGzsEPbaXljNKBa31YVd/KXPDkyLgAW?=
 =?iso-8859-1?Q?fzfGxX2H9EqxiWkgy94Ptd+NnqzQ+4S++Z/Mh7+DC4sCt/q2/tHEYE5HZw?=
 =?iso-8859-1?Q?/Hi1W0ubmXksN9VmlRLDzl+axFv3+Pi4QZbC3so645MAXrqtkrjrhZW3wM?=
 =?iso-8859-1?Q?DOVBZ1oUdFYCNoPM1RgTQ1aN6RqNmAMk+e5htnXrhn6z7jcfOymRAS9Y/j?=
 =?iso-8859-1?Q?4wh4NyhelkxI3KEjJ3/p6BxiUpEXW/Px+M5xIdRpQar57FmeP9Rukvw50e?=
 =?iso-8859-1?Q?f0l3Mmn/fHUWNcxhF9mgcGNIyEqoEDNmfMhz7HzqPUgK+zc62VkxCf5VyU?=
 =?iso-8859-1?Q?7eDXvQAEfyphkMd+YRMBOdiRq5JupB8nn/NbgVGewBC9c+f3KnpwECt+Xq?=
 =?iso-8859-1?Q?qH+Weg46Hgg9kcJ9nl9fGOdmORKnASoRCq1dWEazkskKjSaublTJdhE1DF?=
 =?iso-8859-1?Q?KH+Lt/WX6gEaD58CgEb86LedDpCQb2GrhD3KXqpq6Ulnzy37ZU/Hja4rzl?=
 =?iso-8859-1?Q?TYw9Z7OGgWLdjnrP6xBbwxrZvHuVTTrOyn8Dbxqt5S3h6+/HlmC7pPGU0c?=
 =?iso-8859-1?Q?lDwJMhqNQtUQIx6+DMiN2CXEpPR0dFuJUGqX+aI6dY3/GrsBLETrdGbUcI?=
 =?iso-8859-1?Q?R0wZ94rTDcui/dzwfU8sBOxac6u9slJIerhxhr+lZdSIXXK/Mqg98/bxvK?=
 =?iso-8859-1?Q?amNQZfLOl8RMo+q0w5m4dY3VNY6hZP9gVCLSxo/b8R3PcaxaJz8sUv+plL?=
 =?iso-8859-1?Q?3Rzs9AAm57C1Sgixyw+vZRM02XNcs4YYEGUd/n3jsD6DqXUfu72EA9QBvV?=
 =?iso-8859-1?Q?XVv/0PLOP1kgMG4qfLdzEPOCmd5o5QaMTz+1RXy5VZmo6H+W3i8heJiTVl?=
 =?iso-8859-1?Q?31cOgQUoeAsySf2qDWGuagjtTN0BNqXIUrAizWd5D2sTaiJ1rdUGHxSSFM?=
 =?iso-8859-1?Q?9yeWmtVFxwncYUpJMWc7UKNWgGEM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?i9h4HFRfw0IqFJPpmZBLJflmsj/WI7m/eXhlUStcEfysoOa5LEJqRwmfTg?=
 =?iso-8859-1?Q?k0j5P2h8wYhsXL9Ac30AdGfQpNF7nYLA43izyw79CVkRNEBD56F4OyN5K1?=
 =?iso-8859-1?Q?fqO5nEZZbMyRWO6GFViowxlMAGUpSwm+MlNxAubiRAFEJxXTpvCR68g6s5?=
 =?iso-8859-1?Q?oRkpKDrCW7M6H32Ywn75FOFQSoJ65KJhyufbEt3T4jELksJ3DstzeVE0fL?=
 =?iso-8859-1?Q?YsjnRBdBr/idPZ0KPW1k7NJLDOaJOEvr9u6855j6Sd7bWXCLSDynVpFb6D?=
 =?iso-8859-1?Q?ti0f000Je9g2Ost2QOOsnpaPvn/IC4zRIPP5jfljLTchnaz6a2VBxdxpS5?=
 =?iso-8859-1?Q?yAluT07VENqfEiAQS8r0s053/l86UY1SL01OV+MNdseAFPQyaBwhfC0Xcb?=
 =?iso-8859-1?Q?T75uDB+fnBk5OFYxOc1rSDq2PMCbpg5o/dh60kLYRKoj8+if8K4sIfiFmT?=
 =?iso-8859-1?Q?WSmUFewBk9ZD+Z/A2Lf5mmNAubg2me/hbNY4hxhgYWi+ja3+k7r8R8t8aw?=
 =?iso-8859-1?Q?JSG3XCWARj25c96aZBA31Dp1hWfCqfT0jBMZJDi3dJ0Vxa01M5W7yg5K3+?=
 =?iso-8859-1?Q?FnTS5wQJZP2E73yZ5RvaG9WnaWJZ/ZXW+KZHAXcDFNKRdRHR3dZoTiJ/hC?=
 =?iso-8859-1?Q?JVdq5ugLR3Yko13VeyRiwRcsuT6eStrXOdBv/RbQu2wLup+KxSDkuibu9r?=
 =?iso-8859-1?Q?asS/6kob6A0xa3QwCTD/2p9e/dJtglL5vWpg2szP0XZdYeb+3nPYpDm+35?=
 =?iso-8859-1?Q?UwI5M9ZkDa3wH1gv/Zq/cBithHXg643n+B+6mdEQ/KUYUdYu6k+SJMLNYD?=
 =?iso-8859-1?Q?L9UA3cmOTY8IeMwi8/tTU2AL4lUHm9BdXm3Amy13rOyyE8N0jwdAteKGPW?=
 =?iso-8859-1?Q?HmNz9PFKXTJOp/PILCfl4DLbI+Y2PNr5CFLVUQR/w+C6RDwvB9uQxrXui7?=
 =?iso-8859-1?Q?vHOkvNgiO7wipMZgb0DagugMcjAzfH3I1PysNPCuYED5vNQZLxyX9pjqLr?=
 =?iso-8859-1?Q?M17+9rvOhnWaJ9pS9d+B9duuewM8hw7ugx6mo7HLnQI1Kx2OHgDeNSN9Vt?=
 =?iso-8859-1?Q?2OBqVTtvEv14uZALdkEoiPUcl5aNn0nH2TJVbjCVkB39yajToUFhQiVip0?=
 =?iso-8859-1?Q?h9Sg5ZyjrWBJeK3eJgTkokbVoh40vAh2rEtdSpl2NtxiQoXbWbJv5xmh3y?=
 =?iso-8859-1?Q?WwC4+6moIpO1Ew4TzZvpj0LQqE2gdfc5GzeZolGwy3ktObzNGf3VWPlbyE?=
 =?iso-8859-1?Q?jmYuHOfVGUwgJ4MgEINb+/dFTQ6fWztYzAlQaV6MN+bE+3BeO9+MXxqS+d?=
 =?iso-8859-1?Q?ri9kCLo3c49nLY+dRRQ9i7T38GurVfhx0fjQ7A6v2BjzCPeDCxO+k8KfGH?=
 =?iso-8859-1?Q?X0MzCS/wtXc+9sY5qwz+iRdhA14fdopJZ90INGdsVGcYtrBtNXsq/9trrm?=
 =?iso-8859-1?Q?KsSIZjTp6t14R5K58vY4sqZHZXlWv7cZmCmXOm75Kk/8zUHCpFCtVCKU9n?=
 =?iso-8859-1?Q?ftO8mho91cKz0r2nT5SMlA4C6QsvtD7up9KJFE46UWQ2OXYQPJh5BLWKsi?=
 =?iso-8859-1?Q?wCNQw9+D+AgZ135Pgdh0W+6U9BZZm81ChJd13dbWM6XKXhu/sftv06Pu16?=
 =?iso-8859-1?Q?P74D/Ywbi77s2HkdtbilOc8Qi8QXkALwAt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc91e30b-402a-43b6-4d38-08de2662802b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 05:22:43.1959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C4nPHSYsE68HjXso5umdL6mZ2wFf5BtmfOW7vXbu4ZYGrSy+ByL3+EPwirLB+VJ3sZHAcwAKWZ1NZk2HSQExNBFBxnyehIqM9fCHX6Wx2p4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8709
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
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
> On 2025/11/17 13:19, Kasireddy, Vivek wrote:
> > Hi Akihiko,
> >
> >> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blo=
bs
> >> associated with VFIO devices
> >>
> >> On 2025/11/13 12:17, Kasireddy, Vivek wrote:
> >>> Hi Akihiko,
> >>>
> >>>> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for
> >> blobs
> >>>> associated with VFIO devices
> >>>>
> >>>> On 2025/11/12 13:26, Kasireddy, Vivek wrote:
> >>>>> Hi Akihiko,
> >>>>>
> >>>>>> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for
> >>>> blobs
> >>>>>> associated with VFIO devices
> >>>>>>
> >>>>>> On 2025/11/09 14:33, Vivek Kasireddy wrote:
> >>>>>>> In addition to memfd, a blob resource can also have its backing
> >>>>>>> storage in a VFIO device region. Therefore, we first need to figu=
re
> >>>>>>> out if the blob is backed by a VFIO device region or a memfd befo=
re
> >>>>>>> we can call the right API to get a dmabuf fd created.
> >>>>>>>
> >>>>>>> So, once we have the ramblock and the associated mr, we rely on
> >>>>>>> memory_region_is_ram_device() to tell us where the backing storag=
e
> >>>>>>> is located. If the blob resource is VFIO backed, we try to find t=
he
> >>>>>>> right VFIO device that contains the blob and then invoke the API
> >>>>>>> vfio_device_create_dmabuf().
> >>>>>>>
> >>>>>>> Note that in virtio_gpu_remap_udmabuf(), we first try to test if
> >>>>>>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> >>>>>>> use the VFIO device fd directly to create the CPU mapping.
> >>>>>>
> >>>>>> I have just remembered that mremap() will work for either of udmab=
uf
> >>>> and
> >>>>>> VFIO. That will avoid having two different methods and make
> >>>>>> vfio_get_region_index_from_mr() and vfio_device_get_region_info()
> >>>>>> unnecessary.
> >>>>> IIUC, the name virtio_gpu_remap_dmabuf() is misleading because we
> >> are
> >>>> not
> >>>>> actually doing remap but are simply calling mmap(). In other words,=
 we
> >>>> are not
> >>>>> expanding or shrinking existing mapping but are creating a new
> >> mapping.
> >>>>> And, for dmabufs associated with VFIO devices, without having to ca=
ll
> >>>>> vfio_get_region_index_from_mr() and vfio_device_get_region_info(), =
I
> >>>> don't see
> >>>>> any other way to determine the region offset.
> >>>>>
> >>>>> So, I guess I'll create a new patch to do s/remapped/map.
> >>>>
> >>>> I mean calling mremap() with 0 as the old_size parameter. The man pa=
ge
> >>>> says:
> >>>>    > If the value of old_size is zero, and old_address refers to a
> >>>>    > shareable mapping (see the description of MAP_SHARED in
> mmap(2)),
> >>>> then
> >>>>    > mremap() will create a new mapping of the same pages.
> >>> It might be possible to use mremap() here but using mmap() seems very
> >>> straightforward given that we are actually not shrinking or expanding
> >>> an existing mapping but are instead creating a new mapping. Also, I a=
m
> >>> wondering what benefit would mremap() bring as opposed to just using
> >>> mmap()?
> >>
> >> As I noted earlier, mremap() removes the need of having two different
> >> paths for udmabuf and VFIO, and make vfio_get_region_index_from_mr()
> >> and
> >> vfio_device_get_region_info() unnecessary, reducing code complexity.
> > Sorry, I should have researched thoroughly before but after looking at =
the
> code
> > again, I don't see how mremap() removes the need for having two differe=
nt
> > paths for udmabuf and VFIO and make vfio_get_region_index_from_mr()
> > and vfio_device_get_region_info() unnecessary. Could you please elabora=
te
> > how it can be done?
>=20
> Not tested, but something like the following:
>=20
> head =3D qemu_ram_mmap(-1, res->blob_size, qemu_real_host_page_size(),
>                       QEMU_MAP_READONLY | QEMU_MAP_SHARED, 0);
> if (head =3D=3D MAP_FAILED) {
>      return NULL;
> }
>=20
> cursor =3D head;
>=20
> for (i =3D 0; i < res->iov_cnt; i++) {
>      if (mremap(res->iov[i].iov_base, 0, res->iov[i].iov_len,
>                 MREMAP_FIXED, cursor) =3D=3D MAP_FAILED) {
This is very elegant and I can now see how it is expected to work. However,
I went ahead and tested it and it does not seem to work for VFIO backed
buffers. It works for buffers based out of System RAM though. Here is the
actual code I tested with that I am unconditionally calling for both VFIO
and udmabuf cases:
static void *vfio_dmabuf_mmap2(struct virtio_gpu_simple_resource *res,
                               VFIODevice *vdev)
{
    void *head, *cursor;
    int i;

    head =3D qemu_ram_mmap(-1, res->blob_size, qemu_real_host_page_size(),
                         			QEMU_MAP_READONLY | QEMU_MAP_SHARED, 0);
    if (head =3D=3D MAP_FAILED) {
        return head;
    }

    cursor =3D head;
    for (i =3D 0; i < res->iov_cnt; i++) {
         if (mremap(res->iov[i].iov_base, 0, res->iov[i].iov_len,
             MREMAP_FIXED | MREMAP_MAYMOVE, cursor) =3D=3D MAP_FAILED) {
             goto err;
         }
         cursor +=3D res->iov[i].iov_len;
    }
    return head;
err:
    qemu_ram_munmap(-1, head, res->blob_size);
    return MAP_FAILED;
}

It (mremap) initially errored with -EINVAL in all cases but adding MREMAP_M=
AYMOVE
fixed it for buffers based out of RAM but for VFIO backed buffers, it seems=
 to be
throwing -EFAULT/Bad Address error. I did not yet check why or where the ke=
rnel
driver is returning this error from.

Thanks,
Vivek


>          qemu_ram_munmap(-1, head, res->blob_size);
>          return NULL;
>      }
>=20
>      cursor +=3D res->iov[i].iov_len;
> }
>=20
> return head;
>=20
> Regards,
> Akihiko Odaki
>=20
> >
> > Thanks,
> > Vivek
> >
> >>
> >> mremap() is also sufficiently straightforward. The man page explicitly
> >> states it is designed to create a new mapping. Using it for the purpos=
e
> >> (not shrinking or expanding an existing mapping) is not an abuse of th=
e API.
> >>
> >> Regards,
> >> Akihiko Odaki


