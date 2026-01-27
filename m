Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7527BD25948
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkcEa-0006h6-ST; Tue, 27 Jan 2026 01:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vkcEZ-0006go-Ja
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:07:27 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vkcEX-0000V2-5y
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769494045; x=1801030045;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mcHQVv3sU9/GirvenP+/Z3k6Jw1GYikKu0atTfptBYg=;
 b=EhE+08a8yk0V3uxsRPJ0PFHmm7Q8nqD8iaYxhyaJaioxw8FF/br3iy5W
 O11NMHMbp1Q9lsLVqBTQcGOmJzsy1ftP0qS7y3gpU/hMCS0yxd3RTl2Yr
 gTw1VaJntZLhgkGVrpFPlZy6cqPbV0Ac8/mrQODWCYTeQy71YcFCndHsM
 95vU4P6sPX+Q4tWZ1o9Nfk18K+yzVOEjC1xddR9RRGFyg+I2NuHlk8+16
 XshDTLVVMHwb0u134ZKE1ByFwyZ+Qd74+n3kZ16a5f3ZHYbkVD3pJHXeI
 kxUXUN+fSOeSBd+StpTwzHXPH1dgF6d8uLqsYfwaH1+5Wyn8r6K0MpeLZ w==;
X-CSE-ConnectionGUID: 5Ux0aYW2R1m+K96DTSfB+A==
X-CSE-MsgGUID: 1zVlr+rjTMute9cSyQMXZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="88095777"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="88095777"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 22:07:21 -0800
X-CSE-ConnectionGUID: WCSyZFY7QRiYqZiyGUYEUQ==
X-CSE-MsgGUID: HTpyPMnORFSIdAhdAiwJUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="207904313"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 22:07:21 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 22:07:20 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 22:07:20 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 22:07:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BNTsSh/eOd5EpgQIi2v5O7zmPgeuiOrk5jeWh1TrotEntHtqaPwM0ZgjsiYuT33IaNZ45DAfmVmgVw2mV6YY+q70ARZOKbkdHsE+2UWYnQEXFkxx52NfQH7upjF9O/qBZf1ZJbcvHQG8xKCsAqr1JGFSggeZpUnE43IgBM2rc+WXRUKCiVjKFblxnMkTa5z0+HK8NPpOqAG4G72odn22Lxt+xpru8MZGW9bI+qT0ClbeWeNWPVYqd8dTo+hIiv84IpUOGR4Af+Ztip0r34PhwMTn54t2Xpz+IK7PTYWNR9UPsdDBKFLbmZ9nQ5krf07PbSuYOGu9R3+4Y6M6c9/D4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbaly8Dn9ktK7M6vjTooLCsLvNPPas1tQu6tco2Zr0A=;
 b=cyBnojubqHz+3XeZCygWDvNzQvGf5+4YjOG21cV54T++IfTCMsuON+JDuJgmKW4uT4Yp6BQt6/6kPWGIZMX9VOt1pg9i3EbvxcC27z4qNKhjnbqnS80UFCkevwwQLEwW+ksDEBAaoQJN28M7E2ZO5HMADUM31RWdtObJi29FjthF+ItTPors3efeEmPhl2rozQXEVXCITFKwTlfi116lMkEQm8kMLo2fex29/PkqMTm3UOr0vMVHHWlw8NJF7NkVpqJJtP4x9QK/XPWgx24rjqKWuN/81QbJ/zopvqTsW2qCqz+6MpUVYjrNeWpwiwQn72YVbJHSxpXcpgKkbAN6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 06:07:18 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 06:07:18 +0000
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
Thread-Index: AQHcjDCeQw49HQKsGE+uYIqUk8vykLVfT2SAgAW++RA=
Date: Tue, 27 Jan 2026 06:07:18 +0000
Message-ID: <IA0PR11MB7185FE7AA93FDB21AE6F8D14F890A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
 <20260123062042.568703-3-vivek.kasireddy@intel.com>
 <0d57e3df-3ae6-496f-b621-8d979e2ab3f8@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <0d57e3df-3ae6-496f-b621-8d979e2ab3f8@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CY5PR11MB6318:EE_
x-ms-office365-filtering-correlation-id: 1ab14b8b-a1e7-4e07-5735-08de5d6a5373
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ORmIgswmKru5wWNH3scbIO8iW8OT5HFistKw6ATj+jmTLY7m/0q1IEQaXi?=
 =?iso-8859-1?Q?2EUZ2L1UMZxQgtP/NM/vDAKmd1KYcliTottD235jdllb9c0BVS6r6Nx1R0?=
 =?iso-8859-1?Q?Sp26HmTOLo1xRzncY3SIauDvotIvIv/J1VuCLfvNsmDbaPYMtTSiySyiVw?=
 =?iso-8859-1?Q?GO/UqgLvLjRMKcgfcU3ajc+KpLeO3DJZPClT5NxY45tx3KZOutbaXF7dvu?=
 =?iso-8859-1?Q?HE8PvFU8I9kApZCKrTZ/XAJdXzEOt5ONxxxjfxpFFTZT5JSlfj0024OM63?=
 =?iso-8859-1?Q?xGkbH6St6gbmyzaeZi5Rc/yH972qNgctldGLgv6es+YsZ9K3QX0DZ91bJh?=
 =?iso-8859-1?Q?J8ZL8zmw6jyjDBkCqPS327+qYyQhM9ufjNZETk4QeHRsrLpOi1O9Nhj9lE?=
 =?iso-8859-1?Q?FwpZLaRUeVKAUQva2ArWZzFBf9PVx86MK3Gf+E1Jb6P7dadNHhvi9qhhht?=
 =?iso-8859-1?Q?LS/+NaTj6C6j3ppPReTX47Ih7eKZoHqGboI6UUsgrSd2gzvH+cPR2ePLIn?=
 =?iso-8859-1?Q?vaadMjCZP0owzAm3SuH8J87bmb0neqPO+y8bL0p158sCdsQqoK+jj5CKfo?=
 =?iso-8859-1?Q?M7T+BzTCtpABNvSJekPzG2bW/7pShiDJXSCDjcj8xU31p0XONNpOMEaX+Q?=
 =?iso-8859-1?Q?2DVRiiMfdqAvo2BEfqfSw4E2AwEEyuRECfR6Kqaous5rR0qVXl9AHU02R+?=
 =?iso-8859-1?Q?w0Cu6YdvYm/KZyPCILsK187n5Rky8hnQbQjAzu5TTw3Saz4/u6HustmcMN?=
 =?iso-8859-1?Q?Es2bK3sLwSE3ISGxeHKfotbi3HDlrOSHBPECkuSzpNNiO4hSQGdZAO7q4w?=
 =?iso-8859-1?Q?o0GJjZI1EVa+nF7SfKEUSlb1Cx52j/DKassKRJWo00/2kCm8hGt0k6OEct?=
 =?iso-8859-1?Q?MflQ/V/IjGIxz4y+xWpPxNvFbBT6Gwo5DYEW62ZzuflXE3pyMl2dd294YK?=
 =?iso-8859-1?Q?iJKsfCvh6F3bg+Vnn05VNYzNLjGSLy+q4Yq6uTYxrqBQssSsIIG7xREtXF?=
 =?iso-8859-1?Q?j/JAsa5o1HUSNXAPcOg+k4yMw9le3OyRLDM+GZ7LuB9NxZtub5lSgfr6+q?=
 =?iso-8859-1?Q?Y5ivfETY3qnJ5SN6y9cI0UD++8m7X13lHB0WnuyWiKemSUmCdvRzWeRLU8?=
 =?iso-8859-1?Q?2+GHhwdDVXhJeFMMQsbVL0QNY6Bhm20RbrI//FpYzX3YsUqGqpgcQrY8RT?=
 =?iso-8859-1?Q?HbT+QvmBHTJ9q9UWBTbiglhyxHUGqxdJ2Bg/ETrdH2sEi60qqJRr+sLUBl?=
 =?iso-8859-1?Q?4dfP9EaZ2baQZimSHKXY7O/LRC3UCUV08gJDs4wbrNpO3nVyOcDJrTMAdO?=
 =?iso-8859-1?Q?arY+PAcE/wxh/IuQwgq3WcK88bDAW1urJkOqMvQlm3irkRcKqznYM8y89p?=
 =?iso-8859-1?Q?5ITaoC+86BsFahIBIkm4nx5DNKYlEL5Pjz4xY2HagqGMrRw4MW5pVqFRD3?=
 =?iso-8859-1?Q?+vm+BlQIphlSi0iwwa6TxfiLTtU8M2oQDQc0esr5Y8Nkbae9jOBheVlgRG?=
 =?iso-8859-1?Q?CZTptPWx5+K3kKBgtDaWKXezL3ZLXeN9ls4yzwsxdnRi7ltVd53/Yxpbcq?=
 =?iso-8859-1?Q?8lMep9eq1Y+wrbRJyZqpF9wDPfawKfuKWSsg7B5JxGE8m9sDBlsVlZFcNG?=
 =?iso-8859-1?Q?nINMAB3iheRoWpMlmwJ+XCegiqAjVzmtRZnSFoKEU/EVTyJXC7FHT/84AJ?=
 =?iso-8859-1?Q?rxzsggPTnOkVXdQNwqM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QyX90bBxKtTKahNHPsuFrS2sznyqrP/2oBgB6ntM/+nDn2mWktZ37iEueg?=
 =?iso-8859-1?Q?fEUtgBRmnZDtUFYQRQ6vj1b2j8D2XctPzNCQ7DJjD0+hDMBUyICV0DS9Nn?=
 =?iso-8859-1?Q?8tj+15vDQhyHuz3v/nYA1UwEt4IuTwCUahol/VwnbiSE7lbRAlCSgOT56L?=
 =?iso-8859-1?Q?yplBGLgO4dp1DZJiqSteKR6+5RSILipYP1u/LCJ4mGxZBenS2iBI5XitYm?=
 =?iso-8859-1?Q?GbW4DbR6sGxg9QT6SQDi6w6T8mlR+QYtWLGppc6StJciBn5v55LQIccniC?=
 =?iso-8859-1?Q?S8Vus3z13co7f9Gmo0qvMkasKj51LMzAHiUrGeq2s5hGhE7LCehE84qecG?=
 =?iso-8859-1?Q?/Hpn/jF98oax/Xkw2M3Bwx8wA9xt8eyffICh1aX4InlvxzvjEX/Cfvp8HP?=
 =?iso-8859-1?Q?DD4iAWCbbYfX+xBlK5UorjHW4O+sA3ZxNuhBh6jnP9RWqpSbQI+JU3R2Pw?=
 =?iso-8859-1?Q?fTT9cFN9Eaf7APr29jil0zR1pZ0uTzHPncU0WpuaWUdWnqRaugNbj/v2ET?=
 =?iso-8859-1?Q?QQSZMFOP+ofoYpZf/yZEMufM2Lh0+XetRU3h79l9dOShqDiEM6F7Gg+zlq?=
 =?iso-8859-1?Q?Ra841rGaUima2rP3ka4tzJAYyKfAZM+zmiNwxnHXbdsmo6yMy7YvQwnEB+?=
 =?iso-8859-1?Q?67XMtp6HlpKGJnKS/Q58LA7Xf7G57S0xaWIyUJFclNYoNWFizkQ0lUU15g?=
 =?iso-8859-1?Q?SRLChTcMwn7C44ACrgfd5HNKCcuIQJfXJ5Nj4Y/3f5Aef9B6QrYimNj3qX?=
 =?iso-8859-1?Q?DpVvs+dmHMwg9uSjogA6UlLnf0cqY/9Bk01QB3L6uWm6M07ll1sKF+prG8?=
 =?iso-8859-1?Q?p1KTVteCnH8WXm47yAI5B+YrAxOLCxtydBNh8RK4wrKIc/dzUrevRYRyrc?=
 =?iso-8859-1?Q?YrRWfa9pGzfWRSs17s5bfvaVVCPCsbwgD0FfjEFxU7EppXy2rLPWNa6LET?=
 =?iso-8859-1?Q?egxx9zye/M97GuziUeaYFBZTXfWKFbz4obEDj3K0BiGupHCSomyw/y5aAT?=
 =?iso-8859-1?Q?T9OYUDpV9CK0wYASFaydGtKviTEu8leMV46TFkqcX/SvErw2jwjbQPGzW1?=
 =?iso-8859-1?Q?539q+2YKtGlWTF/FOJG+r4q0VTQjsNs5/IHVIVg2YBg0CLDzYb+fPUOgUL?=
 =?iso-8859-1?Q?5H8KmCoKvI2h9sHtwjfyF7URCQZNgI4lhIwhXA4UX9J9cb+MC/YsIt+enY?=
 =?iso-8859-1?Q?+QFkQsuFaAzYeAqeupAvoZtPt9AlxEkcP31BGNM9BBY6PG9L9Hd1wDWfyD?=
 =?iso-8859-1?Q?6fCQkGRwur/IsJHALlyaYHs2laEU2VHNYAJadwzwfw7ro20EJK/liws+zF?=
 =?iso-8859-1?Q?1vEgS1uydDm1SPGWOqpIvgPTleRhg6xaNyNvxzYgUtTHh9Le4cZRG0FtOT?=
 =?iso-8859-1?Q?EBs+jGzoZ5+Qyt5el6v2HHqp91Jh5wxA6Ipn518Sf9oLn4jTawW2Qn6ige?=
 =?iso-8859-1?Q?kW7Gt9Ox1cmrfidUDHYLSFu+nBVx0vbESlgxZAM6IlC2Jjj5THRfW9vL5p?=
 =?iso-8859-1?Q?1hcpEuAaV279HgKPLjAvSwOFM0Rr3B/ZSqikoHMwI6VnIQ0oNtiSEax/sH?=
 =?iso-8859-1?Q?554wBtU/6jgrCxEYNeU1rayKfhm1Y/oyN+ds1qF0pDPP7t5fPVEfycARd/?=
 =?iso-8859-1?Q?q5CW1hpHRIhQXngm6JqD23TIfk/6wpnG5BmYYTVnXmeS4uIhl/KATCFW59?=
 =?iso-8859-1?Q?wdpQE033lKcYMpGkiunSxbFMDa1nfFvIFxlZNdJ571L1kTukS1/7FZ+K13?=
 =?iso-8859-1?Q?ggLW1sAD9pjiFJHpeSu79XO2HGxaw12nZ1lfGf9KUK6RpvPdjGFbY/XqH5?=
 =?iso-8859-1?Q?dwBZJD16/g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab14b8b-a1e7-4e07-5735-08de5d6a5373
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 06:07:18.0931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: flk5ouL34nwXVhXkC//Vbd2vwFe2gMAMrfPEmPyn2bmvfyy436BZ9XmA812muN4lZE5o6lnS3EwAlF57uIzsG5eLO8nP9XsEPtZU0NQg3X8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
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
> On 2026/01/23 15:17, Vivek Kasireddy wrote:
> > If the Guest provides a DMA address that is associated with a ram
> > device (such as a PCI device region and not its system memory),
> > then we can obtain the hva (host virtual address) by invoking
> > address_space_translate() followed by memory_region_get_ram_ptr().
> >
> > This is because the ram device's address space is not accessible
> > to virtio-gpu directly and hence dma_memory_map() cannot be used.
>=20
> This description is a bit confusing.
I agree; the description does seem ambiguous.

>=20
> The first problem is with the phrase "the ram device's address space".
> The address space we are dealing with is always
> VIRTIO_DEVICE(g)->dma_as. More precisely it is a memory region, not
> address space.
>=20
> The second problem is that it says the ram device's memory region is not
> directly accessible. It is usually true, but here we are directly
> accessing it anyway because the guest knows how to do so.
Does this look better:
   "virtio-gpu: Find hva for Guest's DMA addr associated with a ram device

    If the Guest provides a DMA address that is associated with a ram
    device (such as a PCI device region and not its system memory),
    then we can obtain the hva (host virtual address) by invoking
    address_space_translate() followed by memory_region_get_ram_ptr().

    We cannot use dma_memory_map() in this case to get the hva because
    it can only be used with addresses that are associated with the
    system (or physical) memory region. Therefore, in order to handle
    addresses associated with ram devices, we need to use the
    address_space_translate() API to first identify the right memory
    region and the appropriate offset within that region and then use
    memory_region_get_ram_ptr() to get the hva. This approach also
    works for addresses associated with the system memory region.

    Note that, although we take an explicit reference on the memory
    region, we would still rely on dma_memory_unmap() to drop that
    reference when the dma mapping is eventually unmapped."

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> > Therefore, we first need to identify the memory region associated
> > with the DMA address and add the offset to the pointer returned
> > from memory_region_get_ram_ptr() to obtain the host address.
> >
> > Note that we take a reference on the memory region but we would
> > still eventually call dma_memory_unmap() (to unref the mr).
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu.c | 21 ++++++++++++++++++---
> >   1 file changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 3d58cebf4b..9930a21317 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -798,6 +798,23 @@ static void
> virtio_gpu_set_scanout_blob(VirtIOGPU *g,
> >                                 &fb, res, &ss.r, &cmd->error);
> >   }
> >
> > +static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
> > +                                       struct virtio_gpu_ctrl_command =
*cmd,
> > +                                       uint64_t a, hwaddr *len)
> > +{
> > +    MemoryRegion *mr;
> > +    hwaddr xlat;
> > +
> > +    mr =3D address_space_translate(VIRTIO_DEVICE(g)->dma_as, a, &xlat,
> len,
> > +                                 DMA_DIRECTION_TO_DEVICE,
> > +                                 MEMTXATTRS_UNSPECIFIED);
> > +    if (memory_region_is_ram(mr)) {
> > +        memory_region_ref(mr);
> > +        return memory_region_get_ram_ptr(mr) + xlat;
> > +    }
> > +    return NULL;
> > +}
> > +
> >   int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
> >                                     uint32_t nr_entries, uint32_t offse=
t,
> >                                     struct virtio_gpu_ctrl_command *cmd=
,
> > @@ -839,9 +856,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU
> *g,
> >
> >           do {
> >               len =3D l;
> > -            map =3D dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, &len,
> > -                                 DMA_DIRECTION_TO_DEVICE,
> > -                                 MEMTXATTRS_UNSPECIFIED);
> > +            map =3D virtio_gpu_dma_memory_map(g, cmd, a, &len);
> >               if (!map) {
> >                   qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map
> MMIO memory for"
> >                                 " element %d\n", __func__, e);


