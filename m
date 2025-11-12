Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC9DCCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 04:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ2Po-0002cr-RK; Tue, 11 Nov 2025 23:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vJ2PR-0002KA-2d
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 23:24:41 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vJ2PP-0003rH-81
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 23:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762921480; x=1794457480;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U9Wg/trWrvzRtfNuLT7BfQ689G05q8vIlUKiy9iVgyw=;
 b=DToblIPyGTh6olywAqrh2V8eaQnSuPpTAK9fISR3DeJ/6JzKvT4RsVpc
 9ZMOi5Sdc92rgvZ6FoMmq9ELV5yK2ol7iqJJLm+eMkDGX8jK2Dn6PNK/u
 EnElWHpMLDMA0uWMNly6H9OvxLiagPMM3PsK8az1s0HBf3S20JTkldhVP
 5PhqLJxZMfzSxSzek7AG0wYjaGOYIAaAQOkwSGlpTfhQhTYn6fI2cvSn8
 mwLdSd3afD/IZgKr8rlnkaDXXDQtXWvGt4xo/6DyffKxgfsIAvKSt9peL
 003/msjCe9vKsRlCQHHZx1TMhhuLiy33r/ha3DE4Gkpr61pDWgiI5yicU g==;
X-CSE-ConnectionGUID: aHtsRfdEStCDMtsPXFTDag==
X-CSE-MsgGUID: sRdc6fNxRPKNVFhXU4Ayag==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="76084559"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; d="scan'208";a="76084559"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 20:24:35 -0800
X-CSE-ConnectionGUID: 9jyIYWEcTti5HU0nucRwzw==
X-CSE-MsgGUID: WJOddE9iQ9G4zxzF9g60JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; d="scan'208";a="188960206"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 20:24:35 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 20:24:34 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 11 Nov 2025 20:24:34 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 20:24:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMb381YqdQh2xI/LhK0C6VS+xk9GBzQcQHZrPGq/BcbQC9WcQyXjBNcn53GB4tjpOD2OH5iffntNx+GFNR3ucAQeqmbbVAvhtgbmG0iX9pq6Gx3Sop76t9/4D4RdEHxaeC35ASJTBwGbMYjlpNABEtfcH527hemTq/D26rd8eEK+smKyYWsw4df2hSLBZ5bxMrIxkDMRMWD9cWuGiH6JcWAZFSL6aFi/6OVGT8CMsSXTCuIejg5EX0pvrhXDYz1D5e1kGUccwe4+faTrNLFIfUunHWk/BL7WzgxGbKWMJCNQimPF+U0SJI77+7+YRF/Qw/BOsASWiLhcvg7BrCSnkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTWy7jNslr7pDYtZnzNlEjFdKstApYu9YcJE4xCtwj8=;
 b=uh4EfahokcKbNcKRiHD+iHBkr1paOkC6/IIlPaoBetNL2U0fHaj7mtucvDXljNCQvlRbdGLFy9Hk1RZRH7C8Hu7K5772W2qpXwTgvfaiTbEIFV0A+NpVkRQzJ8935Wwa+rImnfdfIr0n3cYgLqx9ANJTq6uVA4t54WqM3uNUsDoFu9sv2dE7Q33mLC4ewW0L+XEv2lYNGoMUWuVJUv9xEkH40wI8zvjzW9D5mvwC0ugNIX2avXgezolZ8DkHMgIl0NilbefY0M9x8abB9yF+J0MS6dsfFPWvjPI5RZ6F3S19GPbG1Kizwak63TLUz7mYfEBjYeflIh7aWR6eCb6NWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH0PR11MB5904.namprd11.prod.outlook.com (2603:10b6:510:14e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 04:24:26 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 04:24:25 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: RE: [PATCH v2 09/10] virtio-gpu-dmabuf: Introduce
 qemu_iovec_same_memory_regions()
Thread-Topic: [PATCH v2 09/10] virtio-gpu-dmabuf: Introduce
 qemu_iovec_same_memory_regions()
Thread-Index: AQHcUTsfvAmEvBE55UuEj1Z1sXK9/bTrYKcAgAEJ0eA=
Date: Wed, 12 Nov 2025 04:24:25 +0000
Message-ID: <IA0PR11MB7185F1DA0CD274FBB2C30672F8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-10-vivek.kasireddy@intel.com>
 <83274ca7-dd37-4856-b198-f334bf630835@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <83274ca7-dd37-4856-b198-f334bf630835@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH0PR11MB5904:EE_
x-ms-office365-filtering-correlation-id: d65adcd8-0f95-4cde-d6c8-08de21a35cfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+mf5hYJid85Gny66Bibi4Y7OjqA75nYbDeNMreO4mVKO4EHSjIZ0VqHEtK?=
 =?iso-8859-1?Q?A+EMHMbWP5NeFnYxgE1eozokmFq1iMpWt4Nu6KulcbRcHweCGFC5tm8bsq?=
 =?iso-8859-1?Q?AY+SdbRodDLSVxvRMBpiuBbzEAUHM9PCAMST6yejkS0BHaITxu6SYs01i2?=
 =?iso-8859-1?Q?RCZUFXpe+IhvkP7UcYVKci8GfYCj96Daof3/v99HYKWR6bHsI7CRlHIM+4?=
 =?iso-8859-1?Q?WR2x4iKyRMmHFHD3Rh8oKIzpGjHXuOrHyh1J5//e8NFYU78XdMIp67Xjh7?=
 =?iso-8859-1?Q?LJSnnYs33I0OnOy21/JV2CAe5ii2U2DGdKrpmYQ5+i/o93YOLlFyZEX4Ep?=
 =?iso-8859-1?Q?WMRHt2sZsN4PveB9Erb7yWeU6f7bUtknvq1tAQ1lRCjTOQx3NvCtDWGQKG?=
 =?iso-8859-1?Q?Hpb8pXHmiZ52oYyCu0MeyzcP3bsrlsulH3KvicXAnOuHKsIrNN9dM5bjll?=
 =?iso-8859-1?Q?JgAzzGnqm8IyRGzLELvgey/FPr2rizKc5Q8TKlK5ez8QHsEyTxCoKc3Paa?=
 =?iso-8859-1?Q?JkxRYLigSfSNvsvTWlPZmX85EL6GxU7EeJyI3EwnLRSMC3v2cE6OTaElTo?=
 =?iso-8859-1?Q?4kAV4mXvA8qQSl3wxcaWJCKf5NYCK7MIate4fV6Ja6zkUa9GDm7dLj0lpm?=
 =?iso-8859-1?Q?bu3P92BNZJqa5GWlmBRwU/rWvptaRCZeOVEo0e1sO18WKuvfJO1DErJJ4l?=
 =?iso-8859-1?Q?CyZFurZPDvZ0YuYHecLQ3SqvcNMsgJoCRxRzr3q+5az/hoSjIMK0rtOHka?=
 =?iso-8859-1?Q?VU48kyYB6A4/FHSL/NQh21lvEG6lemfaadORFPnaiaWvmJR/3cdUFYSilq?=
 =?iso-8859-1?Q?XNz6peeRihErbChHplLF2oTYQRKrkmWG+AVHay/IanowMBD3SypNjtw7+x?=
 =?iso-8859-1?Q?uPDs+kMfngwJDAWVTnfALAGWKw9a+8jaDRxS4cnSHk/ET5Ry/DNa+R7l05?=
 =?iso-8859-1?Q?lqxA6maEZ5ZsrKDLW1yek85SIutj5DPMKRurjnM8QFXJJsF4llUgrL9jQX?=
 =?iso-8859-1?Q?xvAaShidvtXzjGpUyCyr5SU2NQYkmUX64sYYiu4l5M/5xGDbVePXIYrKjl?=
 =?iso-8859-1?Q?gZXC6sh1oH4g+xI3Wk4F0EDTPutg8ZYTKAjG2vgBijFdfokND628GnHsBT?=
 =?iso-8859-1?Q?jTYEn+/fUHJF4WJEq74JKHcCmmGJFB0F3ENRPQpnhngiKoudd9bUjcAaGY?=
 =?iso-8859-1?Q?cBFA3o5NwLa8HhgRwYjjlP8Al1/R6EHUgkTlWi4qX8BOby18NyR8fR0g1B?=
 =?iso-8859-1?Q?Y5qCft0sp28ynqAveDQq2TmFtf9KCY4Y72gUQJE0uKgy+Wz1kwlM0AQsFU?=
 =?iso-8859-1?Q?L7oY+/CBFnA+HoUW3G3P9lyQheu5D65bTzZqr3nY4BpEBPt8gpq4vC4wuf?=
 =?iso-8859-1?Q?nrnAoUHs1z+F99tzroOEPchhQHeRdc4alfQt9kfeC09tBhO9JPFCnaCF9n?=
 =?iso-8859-1?Q?pyGdghdmiUWgkjHNtLr5Ji6/vbOBvKP80JInD0couLbyCJxpQXF9/sQo0h?=
 =?iso-8859-1?Q?O78UIjXXSEg/on6AqeccchD8zUTtmTYM2TQz6o69tO9Nz0awthf/AYGcYL?=
 =?iso-8859-1?Q?VPxJFgdndYdq7uuW/B3HfgFtg9zr?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZqtLziXHDNPjwYH7v5JaZu75EssExhTUdPmP5maRtSsQJak9qkFRHgYSwJ?=
 =?iso-8859-1?Q?d4PhFqeTlGLrrincR2Q277mxiChA0KbXStyU1x2R4Mvt3kpB0qGRvmemcu?=
 =?iso-8859-1?Q?H6v0Y5Zf6+KJZPOArZT07zrEXNHSQrp5HH4UF5ULmuBoOtEikyu0jesKo7?=
 =?iso-8859-1?Q?xGpelpsNc94Hdk/AWFwgzdcYyG+CNIt+j3gSRmTORjupuhzCoAtKmcxafi?=
 =?iso-8859-1?Q?LkrzNs2KohWjlr4PLxIAJ7+Mi0i9pKNwcrDT6uQtc17u4z4QP7/w97MeCe?=
 =?iso-8859-1?Q?r3nwIjrbuEbnyxrhsXBufpNGr0O7W3oZUTY9+0Nh0OlpL5plQsOFhkaYqJ?=
 =?iso-8859-1?Q?OhYNOFqmM3rUvXowXRK7erFf2L+ZW7FW11rwztwUiXgdn+YceBQjbF87Sw?=
 =?iso-8859-1?Q?t4kWSuuOkr8hPxxTOiYSVTw1xm6UngQoYeXbrWsiDc4hz+BoduytIh6+zf?=
 =?iso-8859-1?Q?nb6Wq4v/RfZCskvbYGkOndk5zAIXhFcr7rN6J8U2sJGWBkAWGDDuOzp9dx?=
 =?iso-8859-1?Q?CWIExu7b9oqMy9K+PeWGc1YiPcAN7hQAqttSOsw5r2XxnQCW5He+ls2mNT?=
 =?iso-8859-1?Q?HJLhgoUkxbPePIJiP8bL2nl6/cORL6FHnr0ADBVwqWgKzkPiNI0fQ5SHSA?=
 =?iso-8859-1?Q?RWu9iXKjwpG3S1s0wnq0hq4LhHJlh+LIfMPWn5a5ZQh1dyvT3RLPZ5SclU?=
 =?iso-8859-1?Q?fdEE7bKlcbzg5dYn71BPqyz6ZfOuxHvMQRWArNZOaCUYm2LYvgeJzZdusp?=
 =?iso-8859-1?Q?3pCqjadP7EVFsslwLf7XOphz/Z9cO6dfRyXAuAPTZqAHqF6nrAfR9SQysf?=
 =?iso-8859-1?Q?kVBccZGmJ1PJdCfEmdjAYTg1ZlNhL2PCU+b9KN863IIrSwd67aIoRDv69i?=
 =?iso-8859-1?Q?kkso8zHEWErFm8hURipTCL/YP1G2LkZTBJbQb48TRJrhUijtH1ajoJioXX?=
 =?iso-8859-1?Q?q9PQ8gx+3F3cdx5K6RvMUPF63L4XqMqRtukL5o+vsmvDRIBWjr91son6EA?=
 =?iso-8859-1?Q?fi3UK7utpLBLSR3/HRfsDJM3XkNuJfywCU6yzxwJq7/4YOrQBPPFoX7mu5?=
 =?iso-8859-1?Q?jotu/ZRzwvvbeATo1ruqIWVMBwvVbvY/9zk1A2Kp9625autqdqpS3lKQRv?=
 =?iso-8859-1?Q?SFwm9kGshthhuMiWEPcjsq9UGAAMf9Zj8HSzJ8GP4xPYcTTl6hnhP/jk64?=
 =?iso-8859-1?Q?6UtaVyM/CyepuXaTtnzIUCZjS9mRtqF/DAQahcuxx3iypDtfozjFylrLjH?=
 =?iso-8859-1?Q?DGlEFSzJBByw9qTxC+8MzIm3Qtf28JNGM5zJHMm/BfpqSySzmCuUVuHkpy?=
 =?iso-8859-1?Q?lMju5LxIjGcm3SrYOtj6FV+xLrUkDoIQTK6jniyO5v7J3yDUzaf2HEYLpj?=
 =?iso-8859-1?Q?BR0WdjyjeAo/rbHwyooD4KvUWtvkH9xXxiL65zjWbg1NK7PZHpCvPzL7zB?=
 =?iso-8859-1?Q?v6tNJaTHzxrtdIFqUZMeUDH0newUBW+5svlvyNHta8jbtfDjLSXjYoPt07?=
 =?iso-8859-1?Q?EW820coRXQaIj8KAHrC9m+9FgZCMmge+H0X61AAb5vsAhtL2J6OdB5TMUp?=
 =?iso-8859-1?Q?xzB7bJdZ2gwfofrywN4mI5ZOowom94QS9ScTyRcniS8VCdU9a0DWkKkNnM?=
 =?iso-8859-1?Q?opCaIActKCYOHWhhUZ85HT5EVHhFx/bKlI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65adcd8-0f95-4cde-d6c8-08de21a35cfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 04:24:25.6351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OxpZ4bqTiLIi7eSeROTh5YinCh3fhdMvXFes/Fcmqd0pWzvTUGDwmh4eB7fQ7S+q6hlYp6FJaAN1B0ISXwQzOHgr4TThXQY8Z/aoCDNrOmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5904
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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

> Subject: Re: [PATCH v2 09/10] virtio-gpu-dmabuf: Introduce
> qemu_iovec_same_memory_regions()
>=20
> On 2025/11/09 14:33, Vivek Kasireddy wrote:
> > Add a helper to check whether the addresses in an iovec array
> > belong to the same memory region or not. This is useful to verify
> > before trying to create a dmabuf from an iovec array.
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu-dmabuf.c | 29 +++++++++++++++++++++++++++++
> >   1 file changed, 29 insertions(+)
> >
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index c34d4c85bc..80143034d4 100644
> > --- a/hw/display/virtio-gpu-dmabuf.c
> > +++ b/hw/display/virtio-gpu-dmabuf.c
> > @@ -27,6 +27,31 @@
> >   #include "standard-headers/linux/udmabuf.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >
> > +static bool qemu_iovec_same_memory_regions(const struct iovec *iov,
> int iov_cnt)
> > +{
> > +    RAMBlock *rb, *curr_rb;
> > +    ram_addr_t offset;
> > +    int i;
> > +
> > +    rb =3D qemu_ram_block_from_host(iov[0].iov_base, false, &offset);
> > +    if (!rb) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Could not find ramblock/memory region\n", _=
_func__);
> > +        return false;
> > +    }
> > +
> > +    for (i =3D 1; i < iov_cnt; i++) {
> > +	curr_rb =3D qemu_ram_block_from_host(iov[i].iov_base, false,
> &offset);
> > +	if (curr_rb !=3D rb) {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: memory regions not same for iov entries=
\n",
> > +                          __func__);
> > +            return false;
> > +	}
> > +    }
> > +    return true;
> > +}
> > +
> >   static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resour=
ce
> *res)
> >   {
> >       struct udmabuf_create_list *list;
> > @@ -137,6 +162,10 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >           res->iov[0].iov_len < 4096) {
> >           pdata =3D res->iov[0].iov_base;
> >       } else {
> > +        if (!qemu_iovec_same_memory_regions(res->iov, res->iov_cnt)) {
> > +            return;
> > +        }
> > +
>=20
> This check is unnecessary. Perhaps rejecting iov with different memory
> regions may be fine if that simplifies the code, but this actually adds
> some code.
I think we can keep this sanity check but I don't really mind dropping this
patch given that buffers with mixed memory regions are not encountered
in practical situations. Or, I guess I could move the if (curr_rb !=3D rb) =
check
to virtio_gpu_create_udmabuf() and vfio_device_create_dmabuf_fd()
like you suggested previously.

Thanks,
Vivek

>=20
> >           virtio_gpu_create_udmabuf(res);
> >           if (res->dmabuf_fd < 0) {
> >               return;
>=20
> Regards,
> Akihiko Odaki

