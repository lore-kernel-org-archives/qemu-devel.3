Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56511D2594A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkcLS-0007U7-RK; Tue, 27 Jan 2026 01:14:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vkcLQ-0007RG-RK
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:14:32 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vkcLO-00020G-Cz
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769494470; x=1801030470;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kEcPnw1MtAyFjOAOrETGRWDSxM/3EDEfkChayG61rj4=;
 b=e6i4ea/wXWP7dBvX32ztfJW8r3CBCbBetUaNuJ+vOAjmcUFTN2jPrqRF
 +01IIzr1dk9hw4DZfMmUx0IopBZvcvtw/II4hgvZ1GGqMwZLkqbkq99+q
 TUKRIi38dj2Q+YzJ0HFubka3ObFKSNd4W11SgJRDTn33WSwjOFyIr+IRr
 X5GfzP1jacpUNcK2ye06NsgFFotV3Mq8hGyShhkcmImV2yoO/m/hMbwk4
 VGOLL3hH34BoA88i0rU982/jcl4vY+3Pig5IVjpDa+XgHXywTij+j9U9t
 TR0vyaMtkQT72F+nJjD33oV6kPx+kh8tEQNdsB5aSE+xsnI76esYeF1oX A==;
X-CSE-ConnectionGUID: lpsUtxHRTN+WYCLHg2/y2g==
X-CSE-MsgGUID: FjvaFUHqQLKUsDoavqlEYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="74306585"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="74306585"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 22:14:28 -0800
X-CSE-ConnectionGUID: YdINGb2yQQq+EzUeioEEnw==
X-CSE-MsgGUID: mGDcbCP3QQisBmQZwInQjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; d="scan'208";a="207499679"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 22:14:27 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 22:14:26 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 26 Jan 2026 22:14:26 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.23) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 26 Jan 2026 22:14:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDq+YrNNgcD9J72W2F6Ec3Rp8iW7PVUoZ2L9jfhiuoeCQzcExZiN97v+MYIgS0xWOIXo567rE5gh62PrxmsvXUT/rD4tDrQvxK/YpI/VZWvZbeaDIkTqEJsv88vtRp0lf59BNClhWaDiJBKP0pLv3i5Dd5eR7gB40px+ZyxyC8fGpt9Y2+f/HlCgHcz22pJA29MrJ5AknenvVOk1GJj18yy+3sNqJteNJZeO2hTdJ53M2p10xUyITfnW3lo/SgggN0kW59TqLP6C218QoIq039c1ebrdznJF68YUm19XiKXSMKvYIlxhQHPy+J92ECmyT6CdenZ78hppV5WDCNbWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VkgD7tFmcFe5QlIp2ChUMXcuzZ8J9oNm9GdJxwrtV4=;
 b=I574Cf1HHWUsxz5NxIyrZNCloOXN4cCDfO62eBd+UpxONY53qZF7nfJgbaCwArzxmtP3bYnjuLkmeLCB4DAkYMGVZ2oA0cDy1k/JaJX4lAA0jFnFD5GLpMQ+pIW/KZ9923oPFCscc+Dwjn21+rdsskG6o6+ArjH8QWyzGJVs8Jl6uRHiRmsde/YzqKiGyX9/J7N5QHhDqguKUXio9l/LMtLeK/tHqQMcI/tTxuqAgtORDeQOFQdbk7X42lTbqxNqvuY5WVu2fldvOJZn0gFS1nWDN3/2CI3mBZ6seXfqBm1FAnQGSlhWr6UNc3E1cp4Vi2ypbBgUfIkxAlxU5h43lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SN7PR11MB6923.namprd11.prod.outlook.com (2603:10b6:806:2aa::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 06:14:19 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9564.006; Tue, 27 Jan 2026
 06:14:18 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcjDCjL5JILwxhKUSESHcm3Ev6grVfTecAgAXcUAA=
Date: Tue, 27 Jan 2026 06:14:18 +0000
Message-ID: <IA0PR11MB718584261475341CB7958A8FF890A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
 <20260123062042.568703-9-vivek.kasireddy@intel.com>
 <ef2f5779-a23b-44dc-b467-0da00e6b1243@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ef2f5779-a23b-44dc-b467-0da00e6b1243@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SN7PR11MB6923:EE_
x-ms-office365-filtering-correlation-id: f198da2f-52f3-490e-3214-08de5d6b4dce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?JBf2eX8Ko9oqX5dp7BPDpVsqG+XHSGyVr95SM/5JlyYYk9AcbgA2bHl2se?=
 =?iso-8859-1?Q?FZRt+2vlLFUKZbgyJma4hilDF+y4W+gfVQChKolx8efWVbLFHGf1lBp1Kt?=
 =?iso-8859-1?Q?wnLHZJ3Qn0uQdyWQHDv+l/fi9tXDpLrS5Y1dQYygwesPbquPhgxgiD2Vq3?=
 =?iso-8859-1?Q?UU7zPkzTjVgPwq3J3BuUudHihMDoqp6WnnI3BnBKqAzEjRjstIApggnXE6?=
 =?iso-8859-1?Q?wHo07r4m9QL3OhqSoy0+x/6XetvGDT1QjRWWUv+WBraGj+wlhhQKNuiyj4?=
 =?iso-8859-1?Q?40XTW+nhTkcbptFmN/TRTitDdWon0y4ce82pQA23hZQWoVui1jwVJZxxjf?=
 =?iso-8859-1?Q?+335WlkjIl4S9FdD07n0z+6pV0TI3VO+WwFZH9VayFoXx96qkL+1bP48VK?=
 =?iso-8859-1?Q?t/QjcDu5VHLPRKxETjfgiAkYCleAuDidF4UbZ627EN6S0/ch/FXUNgn+Ir?=
 =?iso-8859-1?Q?n2s/rRJt6YbGxDqjENP5MslONB6xAAuchg7BOUKbXHG15r8TSL03KXM03D?=
 =?iso-8859-1?Q?mus6uvZth0xqjwBWkdOaFfEZ2dHtvDtb5dHP1UPh8R39qu1WyL39oaDIze?=
 =?iso-8859-1?Q?NxE5TJ47j+GPBDSGJXpY96P43m1BMlkMXfyCNAucgH4vMHXTSUH5FcOjEw?=
 =?iso-8859-1?Q?sVp5vpLS4vZNoEeD6nuY2K62NtJTx9Xz0Ixj8lH7LUknHmIwJB+LlnOKrH?=
 =?iso-8859-1?Q?WAa3Z7hwM9OAQgmS/PpPr4rOmKJ2ogMRQhar1isr85VkJFXhzU29qTctdG?=
 =?iso-8859-1?Q?Plwgd1lH8AvQRHVFusbnXmIfxYPRiebeM9h1mMyT24D7Cz6NgF5r2l9jkr?=
 =?iso-8859-1?Q?Fr6UQDx8bS+nIhcz12CgXJpTCNefG42KWZOguMBPKoVMYDA0FXIb6G+w9B?=
 =?iso-8859-1?Q?MIbsHBGNb4ivhJLuCZdhbZ/yN5YS0/JCY2NN7gJSCZh5PE2i+dFeUE9WK2?=
 =?iso-8859-1?Q?j1ZO59gDb0JdWhce80SX/LxZM6jJL+BJdSjI81b0n3aRW89TFpSsGKr5aC?=
 =?iso-8859-1?Q?Pqpv+mItPbDfcxS4oVOxMXXU4mSynzPMzXd9QZLgNEKUvpr4Aa/UO8Wtqa?=
 =?iso-8859-1?Q?EtSGOnGq4OTBiBHnzc47qz98NVAH/j/jdqDqNS7esSbf9ysQsDmyRiC1Ig?=
 =?iso-8859-1?Q?TE6pMNROvT2m+Q4LO1ndk2XgDF9z5XiAQSKlV74D44q5Hqncnk77SEs2Qd?=
 =?iso-8859-1?Q?naBcgbuXsqx1X5GYhJmgzCQPWBp4C70sBFAzbIgHFdz5dvc/YisqFX78z+?=
 =?iso-8859-1?Q?OPFhJ/c01nqHhqQjW1Gx7OLtzEiswSb7egqWbzhgPrfnRI/zPGaRpJK7ld?=
 =?iso-8859-1?Q?f7QsC5e+RaruD/+PCPsWNzSJG/Rwg1nnw7icyzLK+rLtA/WjsblkF7zXL5?=
 =?iso-8859-1?Q?4NjWZ8LD2w9S7ILCAjhc3x0+uEeAneIFvUbYzduFpDRjFk3mITIEEy9uGz?=
 =?iso-8859-1?Q?vYt5l0XChk3BJ+MjTvliw/GgUjvAgT4jVC5tPkMAbFA1TZneMIB6AM60PZ?=
 =?iso-8859-1?Q?aiZzdIiBJGu7+2sy2ltttHeOAkQzaL7X6HyrU0k6QZxVNIXvdbqHslWAW+?=
 =?iso-8859-1?Q?L5rhKbZhXQoY9GVVRSXnIFcuhGz1RpbUECjX7kx3FOoMyT+o5ly7g+ZTJ6?=
 =?iso-8859-1?Q?n7Hi6OdScWpinc2g4kyTqPUM/TDit83DEOmZtUreKm4GZ+WzAbaEnWayxj?=
 =?iso-8859-1?Q?/SEaLWtsIRCyRilGsqM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MPllqzNW23eRI/Pk4L+dtcwJkHr4hY86bvggZjsfJO7qpiToeGZ2gHhsse?=
 =?iso-8859-1?Q?bREZ3y/j2Awns8jO1t+l14sm7zbuvmjMV5gH67ds5aNTTjtyROgNB7yR0l?=
 =?iso-8859-1?Q?zKPqHL/PF06KzOTsSUwHdN2YASLycRIQAC84N3S4c/IlSolcVGx+kggddZ?=
 =?iso-8859-1?Q?VcHAvHuRZrIxAnjsGzrT+A2tt6fnZMqHu+C7RmzV3uG4Lr6WARoAwwLE/N?=
 =?iso-8859-1?Q?o2ijnsAY3h96Qz4Y/cPlrN7yPH3aB6xptemSAjTSS999M6t7Bkg3sI355H?=
 =?iso-8859-1?Q?+nDYNOopuAD7RZ1PTnyiMN23uhYIxV8lPOfi7QKJNLvH9sjDicykha20w8?=
 =?iso-8859-1?Q?JG3mSnoz38qKkikDZUv5VQqeT9lqkBnWE++kSm7FKVyk613GKJmt7F8jDo?=
 =?iso-8859-1?Q?TjCI9wTowDWF4MDN4HpO6nmGinX5+WT8vZSxjKO4+KXqGcbLZ1xyppJ3rA?=
 =?iso-8859-1?Q?hsV/YqWBg8HSCF5+yGvrYY1Xd1SyE+B7+cOr5iy8u5ewgEuImqn3tbzMKi?=
 =?iso-8859-1?Q?WIVm5bFDTBsHH7KWefWrEwUcbZQtTcrAoUBebYjcmOpss6hoNVJMTECDXz?=
 =?iso-8859-1?Q?wjzv5K3nIHFBhaYKxQHJxllOhDGZMsSHB6+0IQdekaMRAlDNci6qaosyzR?=
 =?iso-8859-1?Q?jIju2ZU4sMQJjBkVuMEL/lCNG3LakmQvV0ba3Q4H+gb056QJ6M6oPKhVPO?=
 =?iso-8859-1?Q?j8wP6EHidyi2xoidOILtgLIsRFkW8BjGR+BlwOD0iaTaJiX60pIC3HY9sR?=
 =?iso-8859-1?Q?8zVKY2ZdyXRcG+Btz1kEcQGrzs7/4m8P+sp+po/nCoeo+CveqGPomr4kwv?=
 =?iso-8859-1?Q?RJTGpqiAn8iV1Fv+h+Ca+NP0zanZK9rcyeAolKv7wgYjRf/G59Ua8FhucP?=
 =?iso-8859-1?Q?+VxILkB2uudOTZyP2IsbEszRR/Ib95JzjOXvBYfEUzvBMid+vZarVDHTSV?=
 =?iso-8859-1?Q?b/rCyguCAZUCIxXAOxHR+YViuwUm2LlvuPvfOA+q79bgf+4SJFE3CS64QK?=
 =?iso-8859-1?Q?5GjDu1J0XgZJR/iYn8MCvBa0/6b3Y9uiPdcUSsSY7WUWEX6QUee6YPqSvj?=
 =?iso-8859-1?Q?DpTyEtQR1NOPbIYNbcJYhlEB6n78EzUx2bAWDY+f4n7aPLdr581JU9npPJ?=
 =?iso-8859-1?Q?nTOHmFwQLFd56NBMKtc+2JdjgVBR4MNz8f8j+PPxiBBIVrM/ee+/WBcLBK?=
 =?iso-8859-1?Q?2SMNTVRpI/WcxP/7+9djVRk16TG1dENU+7lgZKoepYT8JHzACkGJKxTK4S?=
 =?iso-8859-1?Q?msOqZgF7AblswFXNdhq2JDuR51jponjyceyJw+2ltkChhCuDr01JOsmpmv?=
 =?iso-8859-1?Q?Kj8hwqBfS61QJeTNFZLcayUtN/eTuntp2NKbIcexynCJuItPlGFsc/sgFF?=
 =?iso-8859-1?Q?1Zt9Sx46G10uTK25o0xQddxzs+xeKPrp/XO1222yadtS1voVp6Ua6r8rQX?=
 =?iso-8859-1?Q?533C8taa4pBK6D+bpPs5kJJAWpMuncGTg7hkhxQBcvAUzeixvOlp/OgnsO?=
 =?iso-8859-1?Q?sYL6nVjnHCgZ2VPxhXZZ6hlLDWKhQpk4qzcrusd2gB0kpqNQxRqp9xjQ08?=
 =?iso-8859-1?Q?Yjn8yFpkI7QmL98c722RzkxZTj+2paDibEjAfZqWluouSwzw7+Zbm51o0K?=
 =?iso-8859-1?Q?T/2ShEnlvHriYE1KSjpuyH5Uz26VK1zeZYioyenF8mJNmZonccamNNEKSV?=
 =?iso-8859-1?Q?zncA1h7rE0x6qKDPNmpI3mIwrph0Z9PQMVHoSTD0icLphUjpp1A+SI8JjW?=
 =?iso-8859-1?Q?oDLC6Xf5lQC6LsOdJVOwkuaFRekAk+N9CJSlUr60n65+mvR/Uju1+qi0t7?=
 =?iso-8859-1?Q?iuhGQ5MirQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f198da2f-52f3-490e-3214-08de5d6b4dce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2026 06:14:18.1091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8oADpZrd4xjZ7TrEHhjVhUe4YZOyIN/Td+OYGmU/tuqztdkoPzP+fT5XONSgioDAWH78/TnqrrxhVS7dCQt/Auz3KaPctRGXBl9zf5u8rII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6923
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

> Subject: Re: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs
> associated with VFIO devices
>=20
> On 2026/01/23 15:17, Vivek Kasireddy wrote:
> > In addition to memfd, a blob resource can also have its backing
> > storage in a VFIO device region. Since, there is no effective way
> > to determine where the backing storage is located, we first try to
> > create a dmabuf assuming it is in memfd. If that fails, we try to
> > create a dmabuf assuming it is in VFIO device region.
> >
> > So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> > backing storage is located in a memfd or not. If it is not, we call
> > vfio_create_dmabuf() which identifies the right VFIO device and
> > eventually invokes the vfio_device_create_dmabuf_fd() API to have
> > a dmabuf fd created.
> >
> > Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> > the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> > use the VFIO device fd directly to create the CPU mapping.
> >
> > While at it, remove the unnecessary rcu_read_lock/rcu_read_unlock
> > from virtio_gpu_create_udmabuf() and also replace warn_report()
> > with qemu_log_mask().
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/Kconfig             |   5 ++
> >   hw/display/virtio-gpu-dmabuf.c | 117
> ++++++++++++++++++++++++++++++---
> >   2 files changed, 113 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index 1e95ab28ef..0d090f25f5 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -106,6 +106,11 @@ config VIRTIO_VGA
> >       depends on VIRTIO_PCI
> >       select VGA
> >
> > +config VIRTIO_GPU_VFIO_BLOB
> > +    bool
> > +    default y
> > +    depends on VFIO
> > +
> >   config VHOST_USER_GPU
> >       bool
> >       default y
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index c34d4c85bc..2dfe70d7eb 100644
> > --- a/hw/display/virtio-gpu-dmabuf.c
> > +++ b/hw/display/virtio-gpu-dmabuf.c
> > @@ -18,6 +18,7 @@
> >   #include "ui/console.h"
> >   #include "hw/virtio/virtio-gpu.h"
> >   #include "hw/virtio/virtio-gpu-pixman.h"
> > +#include "hw/vfio/vfio-device.h"
> >   #include "trace.h"
> >   #include "system/ramblock.h"
> >   #include "system/hostmem.h"
> > @@ -27,6 +28,38 @@
> >   #include "standard-headers/linux/udmabuf.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >
> > +static void vfio_create_dmabuf(struct virtio_gpu_simple_resource
> *res)
> > +{
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +    VFIODevice *vbasedev;
> > +    RAMBlock *first_rb;
> > +    ram_addr_t offset;
> > +
> > +    first_rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, false,
> &offset);
> > +    if (!first_rb) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Could not find ramblock\n", __func__);
> > +        return;
> > +    }
> > +
> > +    vbasedev =3D vfio_device_lookup(first_rb->mr);
> > +    if (!vbasedev) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: No VFIO device found to create dmabuf from\=
n",
> > +                      __func__);
> > +        return;
> > +    }
> > +
> > +    res->dmabuf_fd =3D vfio_device_create_dmabuf_fd(vbasedev,
> > +                                                  res->iov, res->iov_c=
nt);
> > +    if (res->dmabuf_fd < 0) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
> > +                      __func__, strerror(errno));
> > +    }
>=20
> This API design of vfio_device_create_dmabuf_fd() has some room of
> improvements.
>=20
> First, this function requires to pass VFIODevice * which is derived from
> res->iov[0]. Since it is getting res->iov[0] anyway, such a parameter is
> redundant. vfio_device_create_dmabuf_fd() can call
> vfio_device_lookup()
> itself instead.
Yeah, I agree. I'll move the call to lookup into vfio_device_create_dmabuf_=
fd().

>=20
> The second problem is the error handling. The error may not be caused by
> VFIO_DEVICE_FEATURE_DMA_BUF but may be caused by the guest
> passing
> regions that do not belong to one VFIO device. The two cases should be
> distinguished for a correct message.
Ok, I'll add separate error messages.=20

>=20
> > +#endif
> > +}
> > +
> >   static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >   {
> >       struct udmabuf_create_list *list;
> > @@ -43,10 +76,7 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >                        sizeof(struct udmabuf_create_item) * res->iov_cn=
t);
> >
> >       for (i =3D 0; i < res->iov_cnt; i++) {
> > -        rcu_read_lock();
> >           rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false,
> &offset);
> > -        rcu_read_unlock();
> > -
> >           if (!rb || rb->fd < 0) {
> >               g_free(list);
> >               return;
> > @@ -62,17 +92,84 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >
> >       res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> >       if (res->dmabuf_fd < 0) {
> > -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> > -                    strerror(errno));
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: UDMABUF_CREATE_LIST: %s\n",
> > +                      __func__, strerror(errno));
> >       }
> >       g_free(list);
> >   }
>=20
> These changes of virtio_gpu_create_udmabuf() are independent so
> should
> go into separate patches with explanation.
I called these out in the commit message and included them as they were
trivial but I guess I could move them into separate patches.

>=20
> >
> > +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource
> *res)
> > +{
> > +    struct vfio_region_info *info =3D NULL;
> > +    VFIODevice *vbasedev =3D NULL;
> > +    ram_addr_t offset, len =3D 0;
> > +    RAMBlock *first_rb, *rb;
> > +    void *map, *submap;
> > +    int i, ret =3D -1;
> > +
> > +    first_rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, false,
> &offset);
> > +    if (!first_rb) {
> > +        return MAP_FAILED;
> > +    }
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +    vbasedev =3D vfio_device_lookup(first_rb->mr);
> > +#endif
> > +    if (!vbasedev) {
> > +        return MAP_FAILED;
> > +    }
> > +
> > +    /*
> > +     * We first reserve a contiguous chunk of address space for the en=
tire
> > +     * dmabuf, then replace it with smaller mappings that correspond t=
o
> the
> > +     * individual segments of the dmabuf.
> > +     */
> > +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> vbasedev->fd, 0);
>=20
> It should have PROT_NONE instead of PROT_READ to prevent accidental
> accesses to the placeholder mapping.
> Likewise, -1 should be passed instead of vbasedev->fd so that the
> placeholder mapping won't result in a mapping to real device.
I am OK with both suggestions. However, I don't see any problem if the
placeholder mapping is associated with the real device. In other words,
what specific problem do you see if we keep vbasedev->fd instead of -1?

>=20
> > +    if (map =3D=3D MAP_FAILED) {
> > +        return map;
> > +    }
> > +
> > +    for (i =3D 0; i < res->iov_cnt; i++) {
> > +        rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false,
> &offset);
> > +        if (rb !=3D first_rb) {
> > +            goto err;
> > +        }
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +        ret =3D vfio_get_region_index_from_mr(rb->mr);
> > +        if (ret < 0) {
> > +            goto err;
> > +        }
> > +
> > +        ret =3D vfio_device_get_region_info(vbasedev, ret, &info);
>=20
> This function can take rb->mr and call vfio_device_lookup() and
> vfio_get_region_index_from_mr() internally to simplify the API as
> similar can be done for vfio_device_create_dmabuf_fd().
Right, but vfio_device_get_region_info() is an already existing API
that is called from various places that I am trying to leverage. I could
create another API to wrap the calls to vfio_get_region_index_from_mr()
and vfio_device_get_region_info() but not sure if that makes sense given
that it would only have one caller.=20

Thanks,
Vivek

>=20
> > +#endif
> > +        if (ret < 0 || !info) {
> > +            goto err;
> > +        }
> > +
> > +        submap =3D mmap(map + len, res->iov[i].iov_len, PROT_READ,
> > +                      MAP_SHARED | MAP_FIXED, vbasedev->fd,
> > +                      info->offset + offset);
> > +        if (submap =3D=3D MAP_FAILED) {
> > +            goto err;
> > +        }
> > +
> > +        len +=3D res->iov[i].iov_len;
> > +    }
> > +    return map;
> > +err:
> > +    munmap(map, res->blob_size);
> > +    return MAP_FAILED;
> > +}
> > +
> >   static void virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >   {
> >       res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >                            MAP_SHARED, res->dmabuf_fd, 0);
> >       if (res->remapped =3D=3D MAP_FAILED) {
> > +        res->remapped =3D vfio_dmabuf_mmap(res);
> > +        if (res->remapped !=3D MAP_FAILED) {
> > +            return;
> > +        }
> >           warn_report("%s: dmabuf mmap failed: %s", __func__,
> >                       strerror(errno));
> >           res->remapped =3D NULL;
> > @@ -139,8 +236,12 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >       } else {
> >           virtio_gpu_create_udmabuf(res);
> >           if (res->dmabuf_fd < 0) {
> > -            return;
> > +            vfio_create_dmabuf(res);
> > +            if (res->dmabuf_fd < 0) {
> > +                return;
> > +            }
> >           }
> > +
> >           virtio_gpu_remap_dmabuf(res);
> >           if (!res->remapped) {
> >               return;
> > @@ -153,9 +254,7 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >
> >   void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > -    if (res->remapped) {
> > -        virtio_gpu_destroy_dmabuf(res);
> > -    }
> > +    virtio_gpu_destroy_dmabuf(res);
> >   }
> >
> >   static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf
> *dmabuf)


