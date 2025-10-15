Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BA4CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 04:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8tYd-0008UM-Tf; Wed, 15 Oct 2025 00:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v8tYa-0008Ty-Rv
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 00:56:12 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v8tYV-0006Mv-DR
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 00:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760504168; x=1792040168;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Rzpdp1CruxhfTb7zsakp6uSePDcjc69cb52VvZp3Pps=;
 b=dKRCiJG0wLIB+iquF9gecLTMX2M27MveRR7sWcW7vOaEP/AIlfXzlKXB
 CU647afZlRvfqLJeWtVrsZ/b340xlLBhIESNX/yFvRKYl5JnCgTh8gQIn
 CmHSKX9nTNBtYGiNt/RTrTbKa4dqcVf3PEq3pobsX5pOvAthr1wvEbx+e
 PnBgqwLEUizKODcs8H505H5q/SYiUZyMMH/SwApScGdxBeKF1NwkT7qcZ
 j1OUkyw3UDE4ckleT7HeDbtawzfR3jSneTFr23/0AcY/BEM5a2t1D1PgY
 iMfw1GkCyz0nVJYQ+NGqevfEPFec+hmUzzq4lDL0YxWsqTuxfOLjMPct3 g==;
X-CSE-ConnectionGUID: SCl1i4YITc6KJ0TzTGntKg==
X-CSE-MsgGUID: Ia69DdQrQOaLs7EBIHePGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66321197"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; d="scan'208";a="66321197"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 21:56:02 -0700
X-CSE-ConnectionGUID: FCy6eezeTKCXZ502R3sJ7w==
X-CSE-MsgGUID: 1g+EhbXxSJC7NMCVdSE+ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; d="scan'208";a="186321312"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 21:56:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 21:56:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 21:56:00 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 21:56:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKHUgDKaUdUkI/3PjOQfS6UMkLaIDtCTQ5nI8i9pFB2mhD10njWGbUvaXU7crsGt3cnOfNgglcnzqbCXrnXJourjFQ/68GPdH5uY9ERX165McDYAGhswZB05rNTxYGu7O5j2yrNKHv4a5DKvWBYAZ76ROR+lB0RS6vBg03jH6yuE9xrMipidKORkiCoeoy4dc7a1+i2wfYM/x2QjkZ17S5X7fCmIjm81IrEcZzj9FLkh64zPhJ1viXPrurIjUWsdo5NJlHcLn3xzKTbSWgftYNp8/0JxDVFUT9XRKBtfZ+HNsHs15vISUiLC8SpruRF4xSciqqRJISIXiIo2+tzBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJti04Wi00G1l+4eA1/r+xCrqPHn2Lw74D6uXpIUpAo=;
 b=xB+tktvSPIxcDynmhxdsZG8j/h4unHEt1o2Qfo8i8ng/33AYp5eAM4+MepKwuDtHzEtTX6+dQpRjXPf21bljuvEZ9KMs/Pd/WUZ/Qu8GsbZgnwwbvm+QK19tcUlqiFO8UxKJKmLSLoByIDAPXfZ3JaJAr6QinoXl9n6krfsi4zmOfOJxvj/PhRQi9KIexNlVeYVD78ZEEhePGRLiEzcPFIyRSOzASBI7zPlGZtFItAYLcgzlVsg2ZQPX2NYdv0QDCbTq3+QN3P4rpYnydoMsJwodUia60HG/Iyjzula2pCZy1dw9xAuePubLLy3kOJKvJcxkwEbWzq8rJ94SrT34Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH7PR11MB5957.namprd11.prod.outlook.com (2603:10b6:510:1e0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 04:55:57 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 04:55:52 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [PATCH v1 3/7] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Topic: [PATCH v1 3/7] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Index: AQHcNL+RWmobuqB6Pkqib8U2rEv1a7TBH1sAgAFtUDA=
Date: Wed, 15 Oct 2025 04:55:52 +0000
Message-ID: <IA0PR11MB71854538EFDCFB9717B6C01CF8E8A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-4-vivek.kasireddy@intel.com>
 <ebb13e38-adf6-4754-ad06-d72e2eb309f1@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ebb13e38-adf6-4754-ad06-d72e2eb309f1@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH7PR11MB5957:EE_
x-ms-office365-filtering-correlation-id: fe761474-71de-4b94-c008-08de0ba71de6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7cpJAWBEGnzBJ9+sGo8NSuUP5t6y1N6VUNUN7PtjAR9qmT4tvaAQPjmuwl?=
 =?iso-8859-1?Q?hbcNywQArzYli4r4MkQkrQl31jLDK0bJO0MYl+z/YaXkk/VhV3cIS/NsfD?=
 =?iso-8859-1?Q?rso1Mu9HmTn1TgcI57nZpyPfduY6jaQcm/tuV2gewQEZQxuM1Z3NH4YYGL?=
 =?iso-8859-1?Q?GVyhAawxWW/8WAyOfCbS6VwXIrRWPl0nm94dXyU8KZMk1t2D+4oQQR86Pp?=
 =?iso-8859-1?Q?d0yZTgqIQOAmx4Nq6TS7IW5T/IJhhoHh5f4pWVkYzzkXOd2netrBWzMNy9?=
 =?iso-8859-1?Q?EZkKmlPgCBsRbLElodX2ImfZn+8uK/F+wEcdVFoY+dLlhNr3lhc+9yk4pq?=
 =?iso-8859-1?Q?ZQZvg350+ttn09psuMLaqeiheBfCfTSs7v0vON8jKqsQzYVMOTTj7wXEUP?=
 =?iso-8859-1?Q?TESoDmN8X5k23DuwQKHSjTRpSG4ZrpOH49JEa3AstnGTlaEMp7nGKz5a6I?=
 =?iso-8859-1?Q?0FtnuDI9XCVO8LgKuHuDZShqFM4pPGydX/vPpCZTsuxDYwYm8yNZE4iQje?=
 =?iso-8859-1?Q?Q6lN73JNSn1QngSwDazkHdX7cuk5ftZjno+cSmFkIKU6sySQl1UnSxe2Gj?=
 =?iso-8859-1?Q?NADria/gSoMxQxJgPQH0wvxNcBOB+71+bKHfvX88bO5NvXNdV33Tuu5r7h?=
 =?iso-8859-1?Q?Qgna5SX2llnpYxeQSxyJB7vObAW9HdzMeQmAPCmowOXi2yRKcNyhYhISc+?=
 =?iso-8859-1?Q?0o4yKzuT8K3APDxuDNeRdd5gMbDuiYIsRgUDBqAvdZagmv3ut/Yz0DO3K9?=
 =?iso-8859-1?Q?juvaIW4fFM8izx0f3b6sdbhK8lFm45W3fHA6x2SBWExXiXikZgrjykgiWT?=
 =?iso-8859-1?Q?QXEU5qVKahWQmMp5TV+n9LAPzeOSi6qwHLUIrMFrmXnkLmJkweXpIUYgLx?=
 =?iso-8859-1?Q?JpZfM+9a6RarBEj6/LRQ6nKnOcWr/QASLgy2T8q5NVJE7p2Y2ZUjIKj1Kp?=
 =?iso-8859-1?Q?ngPPLJzRmF+2W7f1ah9lfBV+RJqUV2IIS/mqDcNshn1J3UTkQtuo+iGm/1?=
 =?iso-8859-1?Q?pASSWLg8cBuDueP4nVZdPsyEUrNyhAq3AD7y27Ii5U72HLDjQ5J+4aGRZf?=
 =?iso-8859-1?Q?I6suNlBcDjfFyqpRzqsDAQbtHn3uafI9XxgdrNrK5J6j8lQ2Mc92MrUOMa?=
 =?iso-8859-1?Q?B9MQL4HAl35GjEN2sqVLIekJNI82N3t5L+jeEGdO5UMfwkr2PBoaIsYyxx?=
 =?iso-8859-1?Q?9hWiKuUMfc/3bOTWWYh2qskLfJFuHBEacjfnEPzJhZnwg5hHdgkJkbcNs4?=
 =?iso-8859-1?Q?g9Rxp5CUrEiAz5v8rLCiUXr1Wf+jueVm+67sWko8OzDwOwapzNvImm5E7z?=
 =?iso-8859-1?Q?Zh6PVrMf1JHcp+7gW8M9Ih8fYyX/JV3eDal7KwTTJnjIpfK0Gvi8xF7H07?=
 =?iso-8859-1?Q?jGDY27asC0rKpeg4HzyFH9oyUMduJBqQNJXf/tEbbqUPuQ23PpEKoAk9Hv?=
 =?iso-8859-1?Q?aclxbSwaUTYRzQVlu4AG4UibzPdtfr5nD/qdefpOXcklUIhDUolB7RG3NF?=
 =?iso-8859-1?Q?q6AnfWhayAdEAaKN2guXcJmGmx+klq762Xey00hK/s0U1MGYaDyVrnWtgp?=
 =?iso-8859-1?Q?sDch4OZfdedphPtIcrA0ecEGJL+n?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AQu2HDRKkH6G2/Ceh61Y10xSYDBF7tWm9OoHp1145PaDz0haxdFPYWYd81?=
 =?iso-8859-1?Q?Udu2UyfhUrMhHZU30B4tU7znVP0dH1gBoKnmgKaaqLZNCV3VriLszR/7La?=
 =?iso-8859-1?Q?LXEUwQcCcNNYBmXACxwVJGC+dmdITylnIFNF4AAviBL2Swnwc8H5q+c/ih?=
 =?iso-8859-1?Q?QPUZ3EOoHsJ1A/wrKv1CHEx1VZRJkFNjyByaNh8+EQfxdhOWSPsnhp2RbE?=
 =?iso-8859-1?Q?JEEkPtVCFDKbeA8SESCYfJe/a5m07D9eQjtZPERIXFaIsY54efPwVmx5Hi?=
 =?iso-8859-1?Q?aZvJPcZ1+jL7sGOy6/rY9OId8z/Pn2bGAea7FP1z3Hy6DeR3Qnw2Y+d+zB?=
 =?iso-8859-1?Q?6KlizvBRH/RGYe5Jljq1WGIxUBKldCbQfpkUaKl5UXq0v+tWa5XlxSu80r?=
 =?iso-8859-1?Q?Oiv4KwFKfc1xhB0OH3U3n1N6GKU2ZGvDrLkh5ERSWxsmFgEg0ybrWQXgB7?=
 =?iso-8859-1?Q?Btd2dEyUfmzwLYqR36jUpG6hPBG19VPFnOdgtMQyvIGj7era1AUYZsKKta?=
 =?iso-8859-1?Q?4YJkCPgCRrsRLGeBk5QfdosWztF5BbyilNLNfmBj9gNXfiGP5hgJgId5bq?=
 =?iso-8859-1?Q?T9xAwZqj2Pi8uvSYcfxd6TYs789E9ifxe1qmCC4jQhiuX4W9cV38cKuKqQ?=
 =?iso-8859-1?Q?nFfvgnnoODFOHRSddcD1b0DvEekNgSYhdKubkySZbKp/BKU47D8k0e5CGI?=
 =?iso-8859-1?Q?YaJEzmmiqpgNwclothEOFD9DCQQcup/dTThGEam9VkKQBVGe29PD51VhrO?=
 =?iso-8859-1?Q?HPdjO8x8Qbr+PB07cz2XISgmg8Ptp22gw4ieBH1Ah6gBnqEBllrG7ELVTy?=
 =?iso-8859-1?Q?NsC3FLz7ec1g5ACMrqFbvvZk8l/c9PLSLD4Twim4TO+bxJA4sxKEcNi4Bo?=
 =?iso-8859-1?Q?JMUFLZVtAyFX5eOdHraV/F5ttsZsuZ6Uv2xaIUOL7UWwg3KVyIMSnUYcds?=
 =?iso-8859-1?Q?D+Ko/gm3rzpQEzpdvL+JrR0WAoUZOFwJ61c+LJl7FQJ64dU496oz8t9lvO?=
 =?iso-8859-1?Q?OnTGpPxfsker3ObYJTWJgEJ/AoVgzYW+BNzG57Ti79JuclAuppXTjcAECf?=
 =?iso-8859-1?Q?vUW0sWXLJ66O72NKkPhysO8FrRRPJJyq61Sw8hrjp0OsvljcgwUSpT4Tcg?=
 =?iso-8859-1?Q?ycRgPyW2VhOZCR8k/iqZhOQhZlrd2LIQUXUyJgyd8XOO2q0tnAJPSwcjYK?=
 =?iso-8859-1?Q?kD484gDAXfV2rEfBbg92uI7iOr4l7BgTmB7odDQC3feFpYKhRbF9v85KAj?=
 =?iso-8859-1?Q?BzsyJbSFbd9nUq6PFdWrryM8YOCjnQolcqnWW27OooZX/gJo8nogW56C65?=
 =?iso-8859-1?Q?chV5uOVKAb4WNXvakTQLK5OXL5FGAKp6xuuwOKGlC+ppc4O0Aqs931iy62?=
 =?iso-8859-1?Q?jsS0DsCOzFXAQ3/846fK5NTkz6Yl8/Y0KBHF2JhpB6IbsJSbidCGE8gv6k?=
 =?iso-8859-1?Q?u3fl8I4JBvQ2PqqT0qGkI8pgMGXgjpE7SluLLTdBYwyXWa6m186S/G+T3O?=
 =?iso-8859-1?Q?V6TW+VGsZasvNIwAHW8KKg/hS2t3LnpsXPPMhYUETCxjfgqac4Ntfj3KC6?=
 =?iso-8859-1?Q?9uKhQTehwjqekY1e2/AsagSmn8xO0jS/HZTffVYKGrUAx1DwV7DzlkxraJ?=
 =?iso-8859-1?Q?QOlTvXHW1XsSVlZ55Q22XQg/ajzQfFJ70O?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe761474-71de-4b94-c008-08de0ba71de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 04:55:52.2279 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zisQK4A2vcBjzuPamHiMKZo6vPKS1FRfWTEpiV6TtLWqCO8XFYohsKRbZNofsOUXh4oXBHikpBJsujBHEG5UPX1ayzXoBYgSX7P9gaJ7WqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5957
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
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

> Subject: Re: [PATCH v1 3/7] virtio-gpu: Find hva for Guest's DMA addr
> associated with a ram device
>=20
> On 2025/10/04 8:35, Vivek Kasireddy wrote:
> > If the Guest provides a DMA address that is associated with a ram
> > device (such as a PCI device region and not its system memory),
> > then we can obtain the hva (host virtual address) by invoking
> > address_space_translate() followed by memory_region_get_ram_ptr().
> >
> > This is because the ram device's address space is not accessible
> > to virtio-gpu directly and hence dma_memory_map() cannot be used.
> > Therefore, we first need to identify the memory region associated
> > with the DMA address and figure out if it belongs to a ram device
> > or not and decide how to obtain the host address accordingly.
> >
> > Note that we take a reference on the memory region if it belongs
> > to a ram device but we would still call dma_memory_unmap() later
> > (to unref mr) regardless of how we obtained the hva.
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu.c | 30 +++++++++++++++++++++++++++---
> >   1 file changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index df696611a4..22bbe76809 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -801,6 +801,32 @@ static void virtio_gpu_set_scanout_blob(VirtIOGPU
> *g,
> >                                 &fb, res, &ss.r, &cmd->error);
> >   }
> >
> > +static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
> > +                                       struct virtio_gpu_ctrl_command =
*cmd,
> > +                                       uint64_t a, hwaddr *len)
> > +{
> > +    MemoryRegion *mr =3D NULL;
> > +    hwaddr xlat;
> > +
> > +    if (cmd->cmd_hdr.type !=3D VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB)
> {
>=20
> I wonder what this conditional for. I think this breaks mapping VFIO
> with VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING.
You are right, it does break attach_backing cmd. I'll remove it.

Thanks,
Vivek

>=20
> > +        return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, len,
> > +                              DMA_DIRECTION_TO_DEVICE,
> > +                              MEMTXATTRS_UNSPECIFIED);
> > +    }
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
> > +}
> > +
> >   int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
> >                                     uint32_t nr_entries, uint32_t offse=
t,
> >                                     struct virtio_gpu_ctrl_command *cmd=
,
> > @@ -842,9 +868,7 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
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


