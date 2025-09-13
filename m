Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87DACA101F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 02:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxGLR-0005D7-7V; Fri, 12 Sep 2025 22:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uxGLO-0005CK-Am
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 22:50:30 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uxGLI-0006Yx-RM
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 22:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757731825; x=1789267825;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3AyvaJd1Ed/84YHMXPGJzG2DLwpRVhUISYjoqkP3xh8=;
 b=VtnWbsegLmVWRozU2D18EeBo+FDvAaZC9t2M1ZsjMEMJy7znhGbm17Mz
 sD4GY9BR0U/3FnPLACWr6CUc4kzx8fHNr50Y6hhi7SxBbNIJ3vZECwaTX
 k0ebXC8sTxNw/WLKK9ZpKmhykiH8j6apsYvG7kedX2wtkQa9DM25zC+uA
 7Xoyb/nRZBMt465cq6Z6pu5NAs+khMZcKM9JxO7+NU21bM4+YSYDRMLPD
 NB5BRDTLLQO0yhdCaS2FLX2x+0bmU2+mQjug3YlY4Pe7GqPxIm3ocBbzA
 zCO0h/bW42zh4wWhjJdZP7PzLJ0sZUJDHcPnwe5IHCBrmernNnhMXC5t2 Q==;
X-CSE-ConnectionGUID: DiI40yGvSUi+FyOXAXRHhw==
X-CSE-MsgGUID: lGEeOEFiRO6CUgK6kGd3Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="60184247"
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; d="scan'208";a="60184247"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 19:50:18 -0700
X-CSE-ConnectionGUID: zqoG09kESvqa5umXFPDeYw==
X-CSE-MsgGUID: UY4GkdWUQ0akcp5DtAYblA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; d="scan'208";a="173968661"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 19:50:17 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 19:50:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 19:50:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.58) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 19:50:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgtY1lcWxSdh296pBu3MUQqCFEo010mZZD+mXoVeyWj6Qu5NH+0hG6EtKfFMm6/prJSqoyvkJ/QboaPuAh7/NY3DhonEgB0H2gpiTzXrTWD74UYS8SCyVCRA/mbF59JNe7gXzwq+vXVhIqtOBxgbMHHcOEYqZiTZsT5kiZMv7GQAyrAZQ/NCZ6cgyY8D5fgtsY10gZo9sXSJLzmqZ2GaC4RBYz1CSbcP0Ai8/MuZYCnrxGxej9vBh3TSEQXHYfvdNXvy9rEkg22Q5XOcFt+THppdXewqo337+z+CDoj5WYD6PwSfXZQZw7+bwNGReF2zldtgAg4mXncWrUsuYy2SpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xk99Af9OXBdnSa8JzRDsSeiZi6Og0SBfunaaXPsqjoI=;
 b=EYDMd9JU0hDaUr8RpxVhAzSa/ePCEOebgSiDkwYoJn/bY77D1355u7tdG7Fb9BmxVFPyC5SEUf6169KZhlTDLVnmPEeg/Uo09OVVXEaWznSyORIW3I6SHHzOCCUOkRhDnEopzmlj6wr6mZCWd2dsrj/J3AsrIphiNWAUBInRaKxA3GEtkTat9GSQUo+tMtMiXmaYNNWn3mCjfoPN8AdW7kRgmuQrh9fpjiI3OH/GAMuoFk++rwr7LVgO/F3hPhxgguhgpf60xU9dayaWoW9E/Ik2L5VigPoY78i+CcNxiygbkpSbPC8hE6KerOOMaWO0fWp9bTZ+dUZu5mO3Fg59XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MN2PR11MB4567.namprd11.prod.outlook.com (2603:10b6:208:26d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sat, 13 Sep
 2025 02:50:14 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9094.021; Sat, 13 Sep 2025
 02:50:14 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [RFC 5/6] virtio-gpu: Recreate the resource's dmabuf if new
 backing is attached
Thread-Topic: [RFC 5/6] virtio-gpu: Recreate the resource's dmabuf if new
 backing is attached
Thread-Index: AQHcHJY1NxrjCrIu8EKO1Np84D4OYLSFi+OAgAqRuRA=
Date: Sat, 13 Sep 2025 02:50:14 +0000
Message-ID: <IA0PR11MB718530C3E677A674E67B08DCF80BA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
 <20250903054438.1179384-6-vivek.kasireddy@intel.com>
 <98ba7bf7-3d27-4040-b01c-c769a058fb19@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <98ba7bf7-3d27-4040-b01c-c769a058fb19@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MN2PR11MB4567:EE_
x-ms-office365-filtering-correlation-id: 64d438e3-bc8f-46ed-3050-08ddf27043fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jyw1psks7VD6/9uI9KkxnWv3zvw/tni/FDLILd/FxVo6+NW6J0XyvgtWyo?=
 =?iso-8859-1?Q?+NdFIgL4HjB/74937HtElwAFtHSM7Zc7sHntOA3n1ATRUq6gbh37Ch4Ysc?=
 =?iso-8859-1?Q?2Y0OGwqZ6iMO9YMC8Y6y5CcXQRGR0PMG57uvKCcnH67q6kSH8puEvW5oGt?=
 =?iso-8859-1?Q?1bFFWoJfA0upbfnhgMFTVsEdw2jyF3GZ26XpPptefCaeY6b9DuIagXM/kU?=
 =?iso-8859-1?Q?6bDwb+BnQpw6HTxG1cV4osr2px/3VoeE/6X+sGmTLwQojNi/pNqfyG0rKF?=
 =?iso-8859-1?Q?bAPphGgMEs9HhMQFhtKMRkyW7Fe+sZUFIux3/MNUkF1cwnbC5+CFSNMrlI?=
 =?iso-8859-1?Q?ZeRn4xkqHw416cAyXrp87H/x20OXntuUlmvjjpWmjdqfGedFC2ZtprAz7t?=
 =?iso-8859-1?Q?L66XNT7TyKMgHF3JXJIrB0tpOiNW+2moOOlUd8s0HRG3req+OsyuZytO/x?=
 =?iso-8859-1?Q?kp1Z0t7mJfE0XhzXBVUMe9f4LkXMVeoMhr/j6p+HbGFJXjD7Dz0GI5egfO?=
 =?iso-8859-1?Q?ENlMc9Vvbr786unem4CCPUL66nmQcua3DpboxwHwPDkOt5OjY4QzUB46Z2?=
 =?iso-8859-1?Q?0b7woYJ9Rc2CXY/pcFc07JWJ2pTUPz3Hjg/sH2d5nGfd2Y3IxHX7jgK1tE?=
 =?iso-8859-1?Q?emCoa0PI6b9Sr26AqbC3loo3x6t0eCA9PmhzU/nht58h0100iiJBNjQ4ew?=
 =?iso-8859-1?Q?Hwa/LpuHn/B15isnSxSNBHH+OpKvAZoqk/OYJNNbq5AE8sRjulXAzhea5K?=
 =?iso-8859-1?Q?cxRFZiGfTwq/tccLT8w5KJQB1RXPHF7xhzLiz2g4DRNhZjmYoh+YALDaZC?=
 =?iso-8859-1?Q?GZGFSlrTFkQ7qWAxO5RRmZD/lPY7X1gWV3tkudIx9EfizNiq9CxHo4XAIc?=
 =?iso-8859-1?Q?pwuw51FZcCaQLrYjzkd2svdqDNcRollVFdzay78nfbezwwwLtHRtK3lKxA?=
 =?iso-8859-1?Q?2RmrZdH/c4vHOxNn5c2afz8NCHVr9pacwQvS9tmP9nTblIrx0+M38WmQDB?=
 =?iso-8859-1?Q?SnqwH2NG1SEjPHOoFIMevgkD/oA8QkUgie51FspDxM8n3U1/Ubf3IZG3XD?=
 =?iso-8859-1?Q?0m13mzFu2rslyUcSRHZ2yiAD93S9CwJsgyUOZN5tpUNp7Jgkjo6yq1zIOJ?=
 =?iso-8859-1?Q?UZw9p+/04ksysVz1GImx55QeB0bzH/LRUj/pX7OQSte/H1KeuobnSr8di4?=
 =?iso-8859-1?Q?wJ9e7CutX58RVg/2yfwhSV/FbWX1T5VsYyv9/MyKXfAXs0ijWbTT8LyG5c?=
 =?iso-8859-1?Q?hT9GZKe+7lQzLmp22ZgmI1nVBzzK6BOyv59FYdHx13uu8U1PJCyK7/BFTq?=
 =?iso-8859-1?Q?o2r4FTxXyFRPaGKYC7Xsix+1noaD1y1ZlcbZqx9H8P4Tf99SQWzxyHUWIV?=
 =?iso-8859-1?Q?tGxRBAEiWbIbeS5woYquIuGpGoGyChIdiiYoyVL/YrZzdLUsrjJm74zmez?=
 =?iso-8859-1?Q?3AefRH0NL/fcSM6dJCs7BPhUVDm4v8bC6UAVVjNjA5hn9x+39bIZn7UNVF?=
 =?iso-8859-1?Q?iwkqfRShvIafW17EBpx/QBaVbSBN+d+1nAAzN+Uh3bVEHWYqme2dERJmED?=
 =?iso-8859-1?Q?LStjX54=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Zf4zvVv7C7hAkXnvK7ftnh9TlOHwP3fY3NTTAjytSGuQRrv/vDhWY07yoq?=
 =?iso-8859-1?Q?jVAHxgWVCpa5Vgok9VsTSCBzFXhuM/mxYD2X5hwwMpItt85A6z4xaPH+lF?=
 =?iso-8859-1?Q?W685TLzREFmRYDof/lZohiCYQBRjkrMZ21VaXlZdSZLnMPo7vt+aqAJIt6?=
 =?iso-8859-1?Q?xswQcJL78j3fO57t0TQsmwvKTjNPcBKCgTQv4lohTPSJEWg1pdg/tZajrj?=
 =?iso-8859-1?Q?7oIDMt82d6Kcrd2/huIrpKiUwaNM39uyGUACLxmJK7qxPAXY2TRxPFHRHc?=
 =?iso-8859-1?Q?z+km0idrF68/L08TuGxr89aVJgD07PSXL7mvZB3updvublvcfuhFHyxwCl?=
 =?iso-8859-1?Q?dnZgMfIy4Q04T6l2akG0JoXVMBwK0XmzgjNmlrmDcoq8FratuUVoGC//CC?=
 =?iso-8859-1?Q?qNYfKamW8NbvuDNT4DTshpMuRm62+ggepRZC4nUqz2C5scxkE8KJWEjkgn?=
 =?iso-8859-1?Q?LSYuzvJ3W3tdMs7i3ZIAm1C9OhL1vKPsM5CdjlhjYAGiN9eGU3y2tSIHFc?=
 =?iso-8859-1?Q?z7b8RcSVDxxapgFGQlrCLi7SCmuQBeTIx4W6b+i0KzWXHafLOmVaRkxTCa?=
 =?iso-8859-1?Q?EkGfsqtWha89L4NPny7r9HC2XV4x8UqgjWoCuL7NZ2IxYuQAshy/HzSbQb?=
 =?iso-8859-1?Q?uu5R5STtlTionxojnl0yzgDuy93QEaJLYzXgTT3f6Of+DhedAb70xMcqv7?=
 =?iso-8859-1?Q?jeiXADU2vWM3mh+L8JVFrBlRT/rNGtcoXmhmH3D92v5sDtUX3OuZG5Kv/2?=
 =?iso-8859-1?Q?6mBwj6tatTEG+6YMGHjLaokbewpZvBsMtEm4W4vHHPj/HnMMzkVut3mil3?=
 =?iso-8859-1?Q?OWmv5McRGfQNcjX9D3tlEvM1d23/ef9sazuGCHjKBP5o6tBmy9AYLmEQMx?=
 =?iso-8859-1?Q?2d0LPfwHBEXVgr7trATRrLi80pxcJvfuxX56h5uUTShksb3liLdD0lmB7U?=
 =?iso-8859-1?Q?uyn02NahNJ85eOBU/h5oACrmnAyjrAOTfA0B6H3EtOzQr67JlwM5HIJpCn?=
 =?iso-8859-1?Q?omAgTR+sGRxgXG8Wwp3YtYvuzUdlhYSUMlkuOHS8a4zRr9igtf4GDVHQsJ?=
 =?iso-8859-1?Q?LvhYIWGZW0reTzA/ikSlGUYQ75qUxlvfAfj248lxkrppf99Nkr573ZNag4?=
 =?iso-8859-1?Q?DskK7y6q1xZ/hiijcZsWW8Yyj5ZyycHoZDeg6yxoidKl6LkpSoR4ou7eB6?=
 =?iso-8859-1?Q?qwm8nhumYbSYyDtgfPC78izDtJG8QiTVBdHZty1Rt6fBSKCaOMiXIMlojL?=
 =?iso-8859-1?Q?YYLDuG93SsXk9Zqpikww3dhc9eLUTHdUWnQ2Z1D8TAjpe3GB4e3usSCrIH?=
 =?iso-8859-1?Q?cWe1oMWpyD35Rrb0Ybg8691ylsincBCPIUaPQi8scC6mE841j8sBpVZvIw?=
 =?iso-8859-1?Q?WvGq/GyCoHx+aJjUKZD8aqDeOLTWWcMrWyG5R76b8fUMpUohM3h5lc0Fha?=
 =?iso-8859-1?Q?Pj6aFeEAb0Lc4Q+E//fukkr/l2onk2uD3WW4gvJYW/LQfMhjSt5EYNtoRa?=
 =?iso-8859-1?Q?APMNvyihg2sv6yunRQqN03/ddv6KrWdoeLAVfgGeYaeSoRLuIvAd3vUSws?=
 =?iso-8859-1?Q?E5qF3lA9KYTRCm4KjVPud1W1JplGJKo697FSYCaUZQ/TkK8LRgMenAI10N?=
 =?iso-8859-1?Q?hPc4OJWh/Hw42I6DjLMJ2MkYC72BV8PcrD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d438e3-bc8f-46ed-3050-08ddf27043fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2025 02:50:14.6629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tkAiBHBMUXeZUraUUA2Rm5V/RtFOxM7aixL+3y6I9LFDS1NvdASlpRaTMIg9SzUPLloeL8d3zVoIDzatW0kjL+V+F+jWw0wyGqBb7/OK9zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4567
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

> Subject: Re: [RFC 5/6] virtio-gpu: Recreate the resource's dmabuf if new
> backing is attached
>=20
> On 2025/09/03 7:42, Vivek Kasireddy wrote:
> > There are cases when a blob resource's backing might get detached
> > and re-attached again such as when the underlying object is getting
> > migrated in the Guest. In these situations, we need to obtain a new
> > dmabuf fd, which can be done by calling virtio_gpu_init_udmabuf().
>=20
> It sounds like a bug fix. Perhaps you may add a Fixes: tag and reorder
> patches to make this change come first.
Sure, I can do that.

Thanks,
Vivek

>=20
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 2f9133c3b6..1654a417b8 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -938,6 +938,10 @@ virtio_gpu_resource_attach_backing(VirtIOGPU
> *g,
> >           cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> >           return;
> >       }
> > +
> > +    if (res->blob_size && res->dmabuf_fd < 0) {
> > +        virtio_gpu_init_udmabuf(res);
> > +    }
> >   }
> >
> >   static void


