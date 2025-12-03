Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EB4D116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 06:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQg2B-0004B7-St; Wed, 03 Dec 2025 01:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vQg22-0004Ai-4L
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:08:07 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vQg1x-0000cF-P8
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 01:08:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764742082; x=1796278082;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ajBm6q2WJGVv9AiXOJf7YtPj4VNgCjcmQheOLfVXJ7Q=;
 b=FdTIK3d5BKsOGTHYmyrxOMNVf5HOagbVla0uts1mY8UAfV/1TZ6cbHAO
 pQ5dXSV9M3RdMIKD+WqA3/rxNQkRJncxDKCJTnPc1/7YOt08GdApeNK87
 OFnVO15NiKnpwWjgs+VNVLCPvmYI117wDoeY+UEFcS9ZC4z6P3T5qYmZl
 v3zeKy8MHcAp+glhwrMKzaA+1C2LhBQrqTOzzA5A7M1vwDwsyHK0SIS3E
 ko4m4J6IdMYdOa2EyEqukXRv9VHIw3fFTUmrK7RTYyZmNjZIgf9stv+69
 sDkN6HSTdmUQqKICoZ86Onj4W1XgG5HxSFfmLqpwTfJPnlrdnQcmpH4KO w==;
X-CSE-ConnectionGUID: T438vTVvTyOgqMcposYctQ==
X-CSE-MsgGUID: tyuBT/q9QkOvtnJXQWNa7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="77834292"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="77834292"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 22:07:55 -0800
X-CSE-ConnectionGUID: YgcF8ZpLR9CdUg+LMGMeDw==
X-CSE-MsgGUID: w23L6ii4Qx+0yVbozuyQCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; d="scan'208";a="231927848"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Dec 2025 22:07:55 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 22:07:54 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 2 Dec 2025 22:07:54 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 2 Dec 2025 22:07:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6YmRrD4TbkmL4b0xw4iB1NND8OmWP3Y1usnGcMHu4qw+4Oze+nj8FAxwXNWiyjgaEou7/MKskWJUBsK351gJARKSGUCdLLaZUczmOMSZcKlYTMwK/UVkIzqbCLuR4TGOxVyqQTD9BINoTZ6HSE0fyhbkV+wQ2yMc3E50Us/OXnvSuEjZe+2VdEDHxats3pM5bVOIHYMtw4Z7XdW1kzOUq6B9OdeN1bnZr7d8hqRY8OH+Qfk4irEJDSXR5/rFm3K6rt1Aj6NdtqScGBmf5UkzPUYgvacuNfB4NYX4u6N3qqvhYvLAKlqx1iu5bc66ZAEvSs0ODs7g+Husvsl5PEj5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T12fjDnFxgE6m1/DV3duTIVwcl/9/Ve0sl5TCJLplQc=;
 b=Ce64gjLhquuiBHvHdOiG4hScvV2hi/vNNDCs/wt3AEQU/1oO7xhDnB6B5kGHM8o6WeMw5WYN2mwlhBsUQxO3iCG2aLrvtscWcROvQMPujuiXTxC6dM9vc5FL1ObVeVbFjA0Vep/x7ymtXiRtrjdGDYMJ8HRTBBtDlAkxGEnUYvHCNW5VRQKw3JrfyKvsg6bifzuGmYI3un/RQu3bKNt+JIeJrYhWE4Xf9lm9tQUi1WFOno9928XlTpOvz8JMwR0VHQdMmCBrHAlJQDuY0ZksOEhV820v6sqKrAsiYWZXKYGRNmGqmSWsXM3VSrY3I9GkT/x33M1HRqabUyYUvDWWLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CY8PR11MB7105.namprd11.prod.outlook.com (2603:10b6:930:53::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 06:07:46 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%6]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 06:07:45 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v3 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v3 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcW3xQap9NDYNKLkWy5QRJs1FMO7T+S0cAgAD95GCAAKhfAIAO03UA
Date: Wed, 3 Dec 2025 06:07:44 +0000
Message-ID: <IA0PR11MB7185CE5E9C5312934849F8B4F8D9A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251122064936.2948632-1-vivek.kasireddy@intel.com>
 <20251122064936.2948632-10-vivek.kasireddy@intel.com>
 <74f4e219-a094-42b9-a30c-8de597692ab6@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185273C43DA53473EC8B796F8D3A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <a52f86c1-9cd3-4c1e-9b25-880dbd756712@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <a52f86c1-9cd3-4c1e-9b25-880dbd756712@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CY8PR11MB7105:EE_
x-ms-office365-filtering-correlation-id: 142e8911-be6a-4e6b-abfb-08de3232470e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?+aJyGPOZTPg/dEfA71Oo6Xi+BWFrVTWp4kYDimQaBpsBm+0oNET6E8tY9N?=
 =?iso-8859-1?Q?YquGj8oylwH09g1VzjVLhL23TYrd0GYYvtvDoEoxxKYdR4QVL8raetovUh?=
 =?iso-8859-1?Q?Zu5hkUzXRf/uQvx83fYB/i48aY8ZQxo7xp5GmgeCjhO84D/ZdkBWMEHNqL?=
 =?iso-8859-1?Q?5fISBlc1MC811eeQ7PlMejNnDd/XB23gMGZid0pf3AB2xzI3z1d35jR+m+?=
 =?iso-8859-1?Q?E2OiDgomF1qb2ygpgohcRwGVKJUg0FyVPhSrghzKGbjqhP1nO0Il4BkhB9?=
 =?iso-8859-1?Q?NhfofMPxfQlpzJ0mKdexI+DVWGBq3h9rQXyQeg7Y/1CtHxyq/oFyfKjvmV?=
 =?iso-8859-1?Q?dUg87p0G2BCZvr4cWs/D6+zI19/Rtwum0D9YPToQ5H+wIzwTTJyouecnD5?=
 =?iso-8859-1?Q?M2EuVxHSzcIJtCuBi3sK5Z9kHESl4Bk6Ica92RCAk08c7QeuXuxHG2DzmC?=
 =?iso-8859-1?Q?43MyXgtynKtifr0fdNEwtfn5kGcChVinIANedLVBVoDFtRN6Z8yqNZlEEx?=
 =?iso-8859-1?Q?hvFKKH+wfsCVWIdq9G/eBds5J2xeH5yVRTjb4kNlIwt5icnLfOZ/Fg30Qi?=
 =?iso-8859-1?Q?Wwxb1cIGKrvoc/UW4CosIN8gVA2sXe+69AqvUtSHN/H7RIWZmOKYczjPnE?=
 =?iso-8859-1?Q?mjwaV4Fqr5AbSjrwWJEOtdzS69RIjDqCXLA1v7uvplGkOOcxd9o6e5Ubl2?=
 =?iso-8859-1?Q?Gf8anDiYbq7Sz1zbtq+FCCX8I1HmBs1LxVVAGv//eVHxBzAXFaQk0uD4LZ?=
 =?iso-8859-1?Q?6CauhYJBWLr3IzzwCbFRNHSpozHqB4wU58+Blo23FYh3nqIPl0rE0jELri?=
 =?iso-8859-1?Q?GBuPuX/W6PqGTXaWL1XSJa4g8sWchWlMGRe4x1lXSR/Omf2V8xI/9O2tKY?=
 =?iso-8859-1?Q?Xk5EiAIxr9ds7FVfGukKASqAf0IhM5Oh2A5OINAxyNH/5c03KlU84KgIsi?=
 =?iso-8859-1?Q?8GEpOnYBPRZGQ4johfjPY/3mR1r1W8W/dY2pugIrclLecyfrk37W6V/sNm?=
 =?iso-8859-1?Q?nZuXqWZSCMGzDqgu2Cyw53GgSvWkZzL7NX+CEeENosJvRPjU0Gf0vxuNcZ?=
 =?iso-8859-1?Q?w77fnoyYxaEYmBSQ7+XHxYxQVAthhrflt+hE8Q+wpnXvSjhzS3E0TeH86u?=
 =?iso-8859-1?Q?d9gcCLB8qwQ+dHgb+xxDABz1/WoEzWSZx+fg9GaZkVqNk4BLT1IQJ25yvO?=
 =?iso-8859-1?Q?T7AEWNrT9mswWJkVS6qN3CVStElkIq+rL9t1+KXI3qQISXk2U/FvPYCuZz?=
 =?iso-8859-1?Q?blIaHL4iNSMZPohHXNcjIB1pf/NrBupY0lFx/UOHQlRWgxq2QsOfgNLXiO?=
 =?iso-8859-1?Q?JKMzh41J1esgcx4NTZsB0d1slLMgr8GkZpfdVUoiQwyUy9Ib8ULc6wYg3N?=
 =?iso-8859-1?Q?Y4mVSor0aGzzIt9kgpQy2c6zNKEqWx+sYMg8t22EtmwSiHrX3TN91fUCTh?=
 =?iso-8859-1?Q?Yn3u+KOYUrXp3wJnGLumXiclPPscz973F6EhUTs47rxGtTdtKXioHkvz56?=
 =?iso-8859-1?Q?pEcgKjmwODpw4/iX82Xyr0NO5JiYISvxQWmM+xu9Qlhm+wZovqUAPpGmtu?=
 =?iso-8859-1?Q?emvBZeA8s/yvNp4iHt21ZBLhbcil?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2JLMwFKduizpANaFq7b4aYeHgLGDUNeH+JeeMvD92gPxxKeK4Ia6VZpfqB?=
 =?iso-8859-1?Q?HP6JMnhr+Ywd5XnOB9Fe1csr0sPD3djylu/N9mdFOI7H/285J4w+0WleSb?=
 =?iso-8859-1?Q?1feR1M8Pd+b5+khBDK2txvMJFiC1kC89WVoB9zefuvvboo2GGrWCihNR6N?=
 =?iso-8859-1?Q?YVZRxZYgVllD6CdEPGWbsd9k5BDTBA5Y9a+HyJ9jElrdkd8U4s4dOz9XYD?=
 =?iso-8859-1?Q?p0wxK24FASfRhSDLtHptYFjq1LZozrJDf8eW3s8bT7VnXhz2c+gofvMiNC?=
 =?iso-8859-1?Q?LWjUJbkyrCJ6mhI3Qyb9CxQOt1NBaP3LRcEjsMkS9i1v1LyXQu9TeoBhio?=
 =?iso-8859-1?Q?JIPXdev+/v+wsnxjaV8tqM8XUYNu09NaKGJYTOzi6aSg5ZOvdn2bIU62+C?=
 =?iso-8859-1?Q?0MFhBdm/gSLpJTlpLX8BBmAC2MWCg5Id/I7oYxucLrBVyAWzrzidX5QCKc?=
 =?iso-8859-1?Q?o1+/xatJeOFPXvEhhje8orCenG+ElMjjUevAknLHx044sP4iz3AD7ksJz7?=
 =?iso-8859-1?Q?LY5zdZK1xXuqkOGOQ03JT5HuZJ5Z3DHHd8m2dYCXKRTNwsOLamdE5Ss7Vz?=
 =?iso-8859-1?Q?bEUD+T4Gmby4kptvJBsonewEsGxL0auNlWh/vCYKUgk84HRNvEY6bgnQ9O?=
 =?iso-8859-1?Q?ttCiZ8bLLejcypbGR+uaawRxtEAqPseiS/fS1Ea8Sp0hAP1TbJ7NXJFmQG?=
 =?iso-8859-1?Q?q8qazEPxZThYej+Iz5wM2evkNF5jvnSD0dLUGimRELQ0lm082qfNpLmkGt?=
 =?iso-8859-1?Q?EPDlLXO9qjFDE7sQfPlxAmo1KRsO7FWshSbfFq7jf+j2tbxUONJpmmRYfD?=
 =?iso-8859-1?Q?BohJBeBzPcqpwXNbZ2H/ZahgpCVRJtSFAJCBu5+1JuTIz4ToRowlshgc5j?=
 =?iso-8859-1?Q?LcCM5p64FdLug35DYLDQGTSr34NGKD6rKSA/FJlCrdCawVPrP9IF29wi6d?=
 =?iso-8859-1?Q?kWePRTCc5ICBS6N4FPQs9BSlz8/rGOyX/2+psec3ebv/2uU6K+lv2cwy6g?=
 =?iso-8859-1?Q?/nSCXbU50DOLBhbJRmRuqNGPjnGniapZ+75DpF3Vel4Fj23L4FaZNXawGv?=
 =?iso-8859-1?Q?FcDMgEoTXYmbbGXIlyEsKCHApUPri81jK0ZOdtcDOqVnx0P5UBRY+JDMKI?=
 =?iso-8859-1?Q?vpeDGB99iH6rKTHJsyv2zSIGc/H3EygNExHKyrcdDzkAgclTCYli4M6iCY?=
 =?iso-8859-1?Q?10roLhEcBijd2bZesX2XK/KR82DoDcATY/BUFtf1GXenOEr1jcFSlgoiEL?=
 =?iso-8859-1?Q?6py21gvxvMhhYY/XPambEXMgMt3VcBseJ0INitOJMRYvpoCYoJmJhX6SlP?=
 =?iso-8859-1?Q?GugaOzQQ+OFPuBU25Ed9a39EjIsKUiY/nCQ6Pa+ygeJPbfPfSbkUxGAhXk?=
 =?iso-8859-1?Q?NSj/MvQqUv/bkWEG/oXFX1kfimxhNcU5JxwmuAtkgh64yWsw0t4i9QhBY0?=
 =?iso-8859-1?Q?a+HrKk+y5JX8XA5DQx3Aoh7Qq2K44tTPp7Rk1FrIiU8gyPKNReybeXUaTa?=
 =?iso-8859-1?Q?nKpwDquYbHFB/wW94+rVidDhUmwGDaImo81JTBXf6tYEu7VKxxsWFInhFc?=
 =?iso-8859-1?Q?coz65yUHEbB2yIL6ilAhTg2lWOOrh1VcWy2+UlVQKrniF2awR7VR7W30+h?=
 =?iso-8859-1?Q?3HOV2Cli4Yo4ORhVLMUWbdGD1fCK7PCTw7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 142e8911-be6a-4e6b-abfb-08de3232470e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 06:07:44.8332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RpkjLPexRH4qeZWAkyunc92yHgXTcExpgihH2hKMPMfI4EN2DPe+ETDFoEot8p+OucUNFJQGclPYib2uZP2SOF5DG4OYojSPq/v5XkaDX8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7105
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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

> Subject: Re: [PATCH v3 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
> associated with VFIO devices
> >> On 2025/11/22 15:46, Vivek Kasireddy wrote:
> >>> In addition to memfd, a blob resource can also have its backing
> >>> storage in a VFIO device region. Therefore, we first need to figure
> >>> out if the blob is backed by a VFIO device region or a memfd before
> >>> we can call the right API to get a dmabuf fd created.
> >>>
> >>> So, we first call virtio_gpu_create_udmabuf() which further calls
> >>> ram_block_is_memfd_backed() to check if the blob's backing storage
> >>> is located in a memfd or not. If it is not, we call vfio_create_dmabu=
f()
> >>> which identifies the right VFIO device and eventually invokes the
> >>> API vfio_device_create_dmabuf_fd() to have a dmabuf fd created.
> >>>
> >>> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> >>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> >>> use the VFIO device fd directly to create the CPU mapping.
> >>>
> >>> While at it, remove the unnecessary rcu_read_lock/rcu_read_unlock
> >>> from virtio_gpu_create_udmabuf().
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Cc: Alex Williamson <alex@shazbot.org>
> >>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/Kconfig             |   5 ++
> >>>    hw/display/virtio-gpu-dmabuf.c | 122
> >> ++++++++++++++++++++++++++++++---
> >>>    2 files changed, 119 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> >>> index 1e95ab28ef..0d090f25f5 100644
> >>> --- a/hw/display/Kconfig
> >>> +++ b/hw/display/Kconfig
> >>> @@ -106,6 +106,11 @@ config VIRTIO_VGA
> >>>        depends on VIRTIO_PCI
> >>>        select VGA
> >>>
> >>> +config VIRTIO_GPU_VFIO_BLOB
> >>> +    bool
> >>> +    default y
> >>> +    depends on VFIO
> >>> +
> >>>    config VHOST_USER_GPU
> >>>        bool
> >>>        default y
> >>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> >> dmabuf.c
> >>> index 258c48d31b..d121a2c9a7 100644
> >>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>> @@ -18,6 +18,7 @@
> >>>    #include "ui/console.h"
> >>>    #include "hw/virtio/virtio-gpu.h"
> >>>    #include "hw/virtio/virtio-gpu-pixman.h"
> >>> +#include "hw/vfio/vfio-device.h"
> >>>    #include "trace.h"
> >>>    #include "system/ramblock.h"
> >>>    #include "system/hostmem.h"
> >>> @@ -40,10 +41,42 @@ static bool
> ram_block_is_memfd_backed(RAMBlock
> >> *rb)
> >>>        return false;
> >>>    }
> >>>
> >>> +static void vfio_create_dmabuf(struct virtio_gpu_simple_resource *re=
s)
> >>> +{
> >>> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> >>> +    VFIODevice *vbasedev;
> >>> +    RAMBlock *first_rb;
> >>> +    ram_addr_t offset;
> >>> +
> >>> +    first_rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, fals=
e,
> >> &offset);
> >>> +    if (!first_rb) {
> >>> +        qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                      "%s: Could not find ramblock\n", __func__);
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    vbasedev =3D vfio_device_lookup(first_rb->mr);
> >>> +    if (!vbasedev) {
> >>> +        qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                      "%s: No VFIO device found to create dmabuf fro=
m\n",
> >>> +                      __func__);
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    res->dmabuf_fd =3D vfio_device_create_dmabuf_fd(vbasedev,
> >>> +                                                  res->iov, res->iov=
_cnt);
> >>> +    if (res->dmabuf_fd < 0) {
> >>> +        qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
> >>> +                      __func__, strerror(errno));
> >>> +    }
> >>> +#endif
> >>> +}
> >>> +
> >>>    static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource
> >> *res)
> >>>    {
> >>>        struct udmabuf_create_list *list;
> >>> -    RAMBlock *rb;
> >>> +    RAMBlock *rb, *first_rb;
> >>>        ram_addr_t offset;
> >>>        int udmabuf, i;
> >>>
> >>> @@ -52,15 +85,17 @@ static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>            return;
> >>>        }
> >>>
> >>> +    first_rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, fals=
e,
> >> &offset);
> >>> +    if (!ram_block_is_memfd_backed(first_rb)) {
> >>> +        return;
> >>> +    }
> >>> +
> >>
> >> We had an extensive discussion but I still don't understand the benefi=
t
> >> of this change while I see it adds complexity by having another call o=
f
> > I'll get rid of the extra call to qemu_ram_block_from_host() in the nex=
t
> version.
>=20
> It is possible to reduce the number of the execution of
> qemu_ram_block_from_host() calls, but the code complexity remains unless
> you keep the original code.
>=20
> >
> >> qemu_ram_block_from_host() and imposing an extra restriction that all
> >> elements need to belong to one RAMBlock.
> > I thought you suggested that we need to ensure all entries (need to be
> > validated and) are associated with the same memory region? As
> > virtio_gpu_create_udmabuf() was not doing that, I thought this
> > change/restriction needs to be added.
>=20
> My first comment I raised for "[PATCH v2 09/10] virtio-gpu-dmabuf:
> Introduce qemu_iovec_same_memory_regions()" was that it complicates
> the
> codebase without necessity.
> https://lore.kernel.org/qemu-devel/83274ca7-dd37-4856-b198-
> f334bf630835@rsg.ci.i.u-tokyo.ac.jp/
>=20
> >
> > And, since calling ram_block_is_memfd_backed() for each entry would
> > incur extra overhead (as there can be thousands of entries and fcntl ne=
eds
> > to check with the kernel), I figured calling it once for the first ram =
block
> > and comparing all the other ram blocks against it made sense.
>=20
> I don't think the change is irrelevant with adding support of VFIO, and
> I doubt its necessity either; the UDMABUF_CREATE_LIST ioctl will catch it=
.
>=20
> >
> > Also, rethinking this whole situation again, I don't think we should tr=
y to
> create
> > a dmabuf for a buffer that might have mixed/different memory regions or
> > memfds (as this is most likely an invalid scenario that could lead to
> undefined
> > behavior) so this change is meant to prevent such scenario.
>=20
> In the email thread I cited I only said the check is unnecessary, but it
> can be also problematic.
>=20
> For example, if you hotplug some memory, the memory can be backed by
> another memfd, and the kernel may use both the existing memory and the
> hotplugged one to back a virtually contiguous region allocated for a
> virtio-gpu resource. You may look at drm_gem_get_pages() in Linux and
> find out that it allocates on a per-page basis.
Ok, this seems like a case where having multiple memfds associated with a
dmabuf makes sense, so, I'll go ahead and drop this extra check/restriction
in the next version.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

