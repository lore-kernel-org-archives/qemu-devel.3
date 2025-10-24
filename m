Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D0BCCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 06:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCAya-00055W-CE; Fri, 24 Oct 2025 02:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vCAyW-000515-DQ
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:08:33 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vCAyS-0000XB-La
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 02:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761286109; x=1792822109;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LysFFjwBBny+FcLz8emB+81EeGQo18T17MoN4SXQAgI=;
 b=mUbo3RsjwHe8CfWJvUv4pLyzwXvq4UM8JN87ElcaSaOy9B9U7fv2v10Y
 2vlWShtcbB3iClWMaU0RensyYnOG8DbKkMiX9jfQMZRCMT8wzHru1llPu
 +bJfXfCBmYvWlldTBSQPEBEU84GWhRBP7p2Sbbb7Ks0QxfnG0Nw1fJDD2
 w4Li6mVTLLtHNaS0ba9gE4G3bMd9PjcoQ+gP7iCdzuDvjxvvYgwgulSRG
 X/ED2r9NxGQBxeC853vTyUhsTbIhJeXf1a6KPtBO/LUyeZEwIsj+Dvs3c
 Sjn/iAPkNBlYhNoichN5ICP5Fjq8z/jM01XKO2sPA55Q9m6u0kHAdktrw w==;
X-CSE-ConnectionGUID: 3q+zbbUfRwOA362CkHif1Q==
X-CSE-MsgGUID: SfU7oHezSouTxd1nq6Ctyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67300189"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="67300189"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:08:23 -0700
X-CSE-ConnectionGUID: /pCS0YBLT12jqv4YfIS01A==
X-CSE-MsgGUID: 1Wy/8UnQSE2r/WTP5mRqew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="188643339"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 23:08:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 23:08:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 23 Oct 2025 23:08:21 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.16) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 23 Oct 2025 23:08:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JiRl34ZCpDw0N0wQVwoDLrw3vxPfYMJ6ph7cYp3ksEIf/5jZdGo8UpP5JFPkrOPRe+J6Cr03JAA3iNe5dpP49YI914CK8gbK8TXtA+oeIy387tm6k7KF4laaz0A8/ClllTFQujQK3wCNUmki62uUBhouYP9rj48mTutUPKs0Z7eIfTxfPTq67SZmKJr42coV6SFEN/ZKPc1EOjshnVr1JDSSnAcoondv7JwmKlUs9tTQV8cqnPVLYqjAUG2WWPvSDcWF7TbRxhRAUIBQLl8N1gNBi1sNjRaLXYt/95514/8A+1358H+ep9xqLKt9oJUXBvLxlGNlgBzAKpZFcPFq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6saV13jtwE28La5N39JeKbWslaG/urrFDpKwtiw0+0=;
 b=v8lKz+OXB/Gp/lIug7vA2BnRbvALqrfgqPhamXUEX+QDT2r3ja4OHwtQ9/jthSfIB+QgRZd7QjaCbjBr37sv9GJ484V59c34P+0+esSCRntanYKDmD4I3eiFJDMPG62HThmFHRdbGi1RlsA9moQTEPBSYLnWzTd2otr9JruEAMRoxoGH2cJVJBkpXbYwiR9sNE3SftVwSbN80lR+tRK+JdqU3IXzrdUJ1Z7SQuuKJsRvgSUNbgP9c7bG0G92u0k+MLf0480KbBPohoEDiVC440GI2XpaYUjmhxDpiLqLv2uzDlRDAqnrlFClybMz2hiikDIP3SXgdlK67Zpx7S/Z/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SA2PR11MB4939.namprd11.prod.outlook.com (2603:10b6:806:115::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 06:08:19 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:08:19 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify
 blob resources
Thread-Topic: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify
 blob resources
Thread-Index: AQHcNL+RUYjirTlu+0+SWGS5LfcOTbS60JoAgAQ3pzCAAhCigIABcDrggABCiYCAAGOhAIAA+5vwgAA96YCAANQF8IABGecAgABPohCABXQMAIABCQfwgAItPwCAAMOqsA==
Date: Fri, 24 Oct 2025 06:08:19 +0000
Message-ID: <IA0PR11MB71857EB2EF81E44097C26834F8F1A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <1fd966d9-95a5-45aa-8a20-46f2987cd65a@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718547E3A9E97A0DD6A4A2D6F8EAA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <ba762750-cab1-4cb8-a629-101de5fdc179@rsg.ci.i.u-tokyo.ac.jp>
 <CH3PR11MB7177C4541131508F53BD27F3F8E8A@CH3PR11MB7177.namprd11.prod.outlook.com>
 <955ea687-ed25-47bd-9ba9-73c6b98c8e29@rsg.ci.i.u-tokyo.ac.jp>
 <1f127ac5-10dd-435e-9ff5-f70596d7aac4@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71853F97E13556E781AAE104F8E9A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <a0bcfbed-b6a1-42e5-b482-eb056fc2cd25@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185A158F3DC20170E673E7BF8F6A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <096c74d3-ffb7-4555-b8cd-caf88eb4de74@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71856839617B01F9CB852880F8F5A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <d5d9d06c-368f-4098-bc04-41f08945778a@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718515058F01C0E9F89AAC53F8F3A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <d60ee137-736c-47e4-826b-800885085891@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <d60ee137-736c-47e4-826b-800885085891@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SA2PR11MB4939:EE_
x-ms-office365-filtering-correlation-id: 7eea07cd-9cad-4158-7a05-08de12c3bacf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?y/H1LNozEr8lQpdRQFkpkkZ4nkqQLIgKQp0YONsBfBixw5mnvYoS/AfSrk?=
 =?iso-8859-1?Q?zOZ+1zCwqStCq9Qsuf18C9rMaTGpVR90qlt6CFYsNzBKjcAxdheVzSNtDd?=
 =?iso-8859-1?Q?CE7FYptwtGDUJ7ds6XC25uJoqo5rpi85D1jWQ5DSDhp0A2PDEvmYZrvdrq?=
 =?iso-8859-1?Q?EcOPvAyzaG/8KWjs3gbXrZtJc+kVapwSqR9tUWnwbQ18pQ4p62G7kdgsgs?=
 =?iso-8859-1?Q?AF5JLrIL0u+MgrMto+eJfL4jhB3s5sROzVr4A60mkffcptlC/Q/8HV0F9t?=
 =?iso-8859-1?Q?xfbfpACWYGMW7ENsc0zP79s5vRCc7G0L6npIkOX6XgdYAsT6fAkMTUu4fG?=
 =?iso-8859-1?Q?ROeZH7dOuT9CaM4CpFI29wy+u+5lwl0qGkoeP0gLdd/hXb9VTmf6LoWnEz?=
 =?iso-8859-1?Q?dR9u4+vU2AacTliRRUhKdAoSkQTGYAxPpNDc0Mb3IMMW+DFBHwegpqk4VO?=
 =?iso-8859-1?Q?/aNfwfMiI2X6B7T/Bj+fQ8dCZlIi140Ddnksq4R5Ta9v9BoW2JjQ2r3N7y?=
 =?iso-8859-1?Q?7T+wQW/TREiL8eOKBK9G4QYjC+QRmJgPjI6K3+P+nxvPRw+CZseFtgCx/f?=
 =?iso-8859-1?Q?e45JX4xXGx+8NAY+UQz6TGUQ8p+B6GzuU6lZnPj3N5zruLIbzAEtVH7RLk?=
 =?iso-8859-1?Q?mGe8oiASjIintXRGfv6nb63sq5qY5KBW4xz1hAUURpefkUNnHqqnstnVN/?=
 =?iso-8859-1?Q?7FqphjlndSb9Ua5kN83Pw2BrInPV1LJNxvvLVEFtJWSyhaH7ZRE+FpXexM?=
 =?iso-8859-1?Q?tT5snb1EmCSUDehc4bmxRAy8Zq1m0Zqc39MMH5MYoODqO2C2sd8/ZePwTx?=
 =?iso-8859-1?Q?mZa1LWtcINH7nqa7e7FIvKXaRm/+NEHlF2toyoUE+7Lt5hthFNM/VC4drz?=
 =?iso-8859-1?Q?NoK8S49yusMv//a1yQgFKYH0ykw/Zz4wa0mb+18p6WyNL5ZGgIutKZXvOW?=
 =?iso-8859-1?Q?m6hz+Y4Ya7WVZV59La/SyrvdlgCwdBlkfNE7+iIW0wkapwT1g7MymkLTJz?=
 =?iso-8859-1?Q?7iIl+c3lGxINoNAMgJn+Q6vWUYFgcBc2weniIXAhkf1W3jqzbyCCdQqrKj?=
 =?iso-8859-1?Q?2GeL9+rSEbpyH49oRTysU7le8R4jynX5Xp+CJ4MMobW1BWQuWQbk33Q7q6?=
 =?iso-8859-1?Q?5YiZ9zClWKjcKGRIa8Hp3iFb2mw2IS5Ml4rfGMvFigjI6aAHZJgkSb8Hqq?=
 =?iso-8859-1?Q?UNhBs5rAtDshS5Q/ad6nR1pctK6xQ/RVtqti59b9x7dB2umtfvbezG3JuR?=
 =?iso-8859-1?Q?p9YSy0xscEZfrhNpjMibE1FLPJgQoSD8K1uj388pAyXddN5dRp8INA9zjr?=
 =?iso-8859-1?Q?UgdEUafFP9VwE2RK5odxdyQC8ScmOeO7ZjRuHBhqTemCXZV5VWFPWQOppd?=
 =?iso-8859-1?Q?lo8/JKP4V1m2OVre4AqjnSJqlobr4o1cMxg44ckQ1ZBFxIa+0E5rTNLuta?=
 =?iso-8859-1?Q?fHHQs5yvlyIeggyrDR8czJ01miqGF7AWjbvLVknFdvXtY/s8tEdXVOpdA5?=
 =?iso-8859-1?Q?8SkFdE1QuD/grt312oR6ubPr6YhswwxzUwJJvgGtpXHd4NZTrX9dzXXW2z?=
 =?iso-8859-1?Q?PBvYJXvNv7Ryp9JnVUeN4witX76xQ2xYuoP7B/khjipiC1JvbQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ez6C0ditwCM1C1t81gMeOx24AyKd3dcwluIx9tOdiwT8q/01mHDlPhLNJz?=
 =?iso-8859-1?Q?hL0vs7HE4lkn77T5kwEeqmrMH4qP0RntAEcLNxwfljhXUVW/p+XNzZGLWh?=
 =?iso-8859-1?Q?6vGq4Rtecp6gy83mCBPzZ4Z8gV+jRBXSlExJYcXbeWlHjROtBL5jnfVlLp?=
 =?iso-8859-1?Q?opBxgkIVHnCScUTycJcKk96sHKK6vm5Ci2JSgNRgIXdN2KWgeAvHN+7f1f?=
 =?iso-8859-1?Q?DeBhjGX6bUAdqKAsQIk9eMdCHxKfpF42U3QvbsmeTQI7+1YetPGTxgRDS+?=
 =?iso-8859-1?Q?VXG4z//YFK8x3rGC+DRmfggfiddJBAXpkxg3TuHZhPbOm8q0elc+QQsHOE?=
 =?iso-8859-1?Q?zL6xoZOlTPgFkKLEM67/3IwmP/oUShBG0REtTxDrk+PT5gPVfY02dq4jzv?=
 =?iso-8859-1?Q?jIqYdYzt36TrJOW3m6eGVgVo73sfLxRR+I67xbSxT8DNCOBV6Ucn2kFgC6?=
 =?iso-8859-1?Q?8gXHoMhXABBnElcspEOVGGCvIEOejkcpQrZyi82v4l1DNSHBf7E3tzMwEh?=
 =?iso-8859-1?Q?R8IP47CMrQuiEtDJWyTFkSsvNco1RAymRU1DZk0POPm4ht5s4Y1hDnKtw2?=
 =?iso-8859-1?Q?azWTthg2KdQGiHIBY8gzdFozz/yOcFww7CXpuzC1NR39k5k9SoMROW8Zq5?=
 =?iso-8859-1?Q?RE974r+Wg3NPBk3LPJlP9h/X7MVyPTqglqIFg5YuIH4zZNUN3Uafi+RGlY?=
 =?iso-8859-1?Q?+k+J5jzemIWYfODNLjysmYc6I1JmFfjwWNTIo5Uk/Fa2GhnFihuYxaLfN4?=
 =?iso-8859-1?Q?HiuTW5t6TX3tPfofCYg8FXhOiIbzvfVF1woiITZDQ2x1qd/NZqpD5BTf6U?=
 =?iso-8859-1?Q?iBprEsM4PSL1tMBgh1ruiVBNIFxmsDw13z0P41d2GmbYw1k5UHwVWX1yZc?=
 =?iso-8859-1?Q?5xqXqkC4fb4vXwkwIeM62jWuJd4dikkaGn4PismMaok/wYijQ08perX+MX?=
 =?iso-8859-1?Q?sSJ6a24L3qK9c6Hp4Wf8i9iHRuBNv/efHthtOMqytm4XJVE43L9omBq7BO?=
 =?iso-8859-1?Q?iVKilVwgT4kcxrS2sj9d6ihN8uFz5QV5/ZRzYQaY8RNS+maNpzy5ev5kYq?=
 =?iso-8859-1?Q?fTMNiE9aMh6k+eXAzx55wMY/Hm6WYat7jA2te+/Q8XsSUi/Il9wyr0CjWs?=
 =?iso-8859-1?Q?1vGo/GWNpcAs/3gImSrWxpJ/k6aeDCppB0Sdd31FywxZEQ7f54+DWgKy21?=
 =?iso-8859-1?Q?jRu1oqXm8XcySf3gAbwuDRbTJWkjY9Ws1BVTcjWi5NQcuE5THBSAhQOkf0?=
 =?iso-8859-1?Q?pCpo/CbydGq0tuP0mbN/xRkqk7i8wGr1gjbl1VqjCAzZB353FvBqY8F2q8?=
 =?iso-8859-1?Q?/SZcY8k8VNgchqEo9vOuravv77PX0HYG8SEqIZrWXjCZSufp7Xuvcclo+M?=
 =?iso-8859-1?Q?melEl3omzhD83IaEFYZ7ygfrH6zWBu4j6Sg9dCk4aY9zZ8AG/U+HmoOgd2?=
 =?iso-8859-1?Q?ggLCcLYpBXp7wGN2OBwfC+K71tslLffUuiHQkdlfb9Phn2nz/x63qECyPZ?=
 =?iso-8859-1?Q?fMOJXk2N1MLfKknni99dxMSlYOsLLFO5/vE+dt613AmF9LjquIR3tz2xFe?=
 =?iso-8859-1?Q?DBcSu9wxfWQjOgA6VHyqqp/15lzrk/fYQngfftD5HIh8ab/5qhzyy6RcTZ?=
 =?iso-8859-1?Q?Sv5H6dRthfNA7hWdDK9XUI/VQkrHwfhr0p?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eea07cd-9cad-4158-7a05-08de12c3bacf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 06:08:19.5070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxjzb6af50T7KFu0ls3tOBOwuX22iUoARcB/IeeJ+n9bePTpEdd5FLe4z9XyAgA5h72STZMj/uMnkiIxFPO0L/RhjyRaBetFpDp0VTrPTJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4939
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> >
> >>>>>
> >>>>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to
> >> identify
> >>>>>> blob resources
> >>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->bl=
ob
> to
> >>>>>>>>>>> identify blob
> >>>>>>>>>>> resources
> >>>>>>>>>>>
> >>>>>>>>>>>>
> >>>>>>>>>>>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res-
> >blob
> >> to
> >>>>>>>>>>>>> identify
> >>>>>>>>>>> blob
> >>>>>>>>>>>>> resources
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On 2025/10/04 8:35, Vivek Kasireddy wrote:
> >>>>>>>>>>>>>> The res->blob pointer may not be valid (non-NULL) for
> some
> >>>> blobs
> >>>>>>>>>>>>>> where the backing storage is not memfd based. Therefore,
> >> we
> >>>>>> cannot
> >>>>>>>>>>>>>> use it to determine if a resource is a blob or not. Instea=
d,
> we
> >>>>>>>>>>>>>> could use res->blob_size to make this determination as it
> is
> >>>>>>>>>>>>>> non-zero for blob resources regardless of where their
> backing
> >>>>>>>>>>>>>> storage is located.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> I think this patch is no longer necessary since now you add
> >> code to
> >>>>>>>>>>>>> mmap() VFIO storage with "[PATCH v1 7/7] virtio-gpu-
> >> udmabuf:
> >>>>>> Create
> >>>>>>>>>>>>> dmabuf for blobs associated with VFIO devices".
> >>>>>>>>>>>> Right, but given that mmap() can still fail for various reas=
ons
> >> and
> >>>>>>>>>>>> this
> >>>>>>>>>>>> use-case can work as long as dmabuf creation succeeds, I
> think
> >> it
> >>>>>> makes
> >>>>>>>>>>>> sense to not rely on res->blob to determine if a resource is
> blob
> >> or
> >>>>>>>>>>>> not.
> >>>>>>>>>>>
> >>>>>>>>>>> I think the code will be simpler by making resource creation
> fail
> >> when
> >>>>>>>>>>> mmap() fails, and I am concerned that the guest may
> >> mulfunction
> >>>>>> with
> >>>>>>>>>>> such an incomplete resource.
> >>>>>>>>>> AFAICT, mmap() is a slow, optional path except for the cursor
> >> (which
> >>>>>>>>>> needs
> >>>>>>>>>> further improvement). So, failing resource creation when
> mmap()
> >> fails
> >>>>>>>>>> does not seem like a good idea to me given the fact that
> >> supporting
> >>>>>>>>>> mmap()
> >>>>>>>>>> is considered optional for dmabuf providers. And, even with
> vfio,
> >>>>>> mmap()
> >>>>>>>>>> can be blocked for various reasons by the kernel driver IIUC.
> >>>>>>>>
> >>>>>>>> Reviewing the code again, I don't think mmap() can fail with the
> >> current
> >>>>>>>> version of this series.
> >>>>>>>>
> >>>>>>>> udmabuf obviously always supports mmap().
> >>>>>>>>
> >>>>>>>> For VFIO, checking memory_region_is_ram_device() ensures that
> >> VFIO
> >>>>>>>> supports mmap(); memory_region_init_ram_device_ptr() is called
> >> from
> >>>>>>>> vfio_region_mmap(), which is only called when VFIO supports
> >> mmap().
> >>>>>>> My point is not whether a dmabuf provider provides support for
> >> mmap()
> >>>>>>> or not but about the fact that mmap() can fail (for various reaso=
ns
> >>>>>> because
> >>>>>>> it is not a guarantee) making res->blob NULL. But we are incorrec=
tly
> >> using
> >>>>>>> res->blob pointer to determine whether a resource is a blob (and
> >> usable)
> >>>>>>> or not which doesn't make sense because even if res->blob is NULL=
,
> >> the
> >>>>>>> resource is still valid and usable via the dmabuf fd, which is th=
e
> >> preferred,
> >>>>>>> accelerated path.
> >>>>>>
> >>>>>> Failing to mmap something that is already mmap-ed to another
> >> address is
> >>>>>> very unrealistic and I can't really think of a possibility of such=
 a
> >>>>>> failure aside bugs.
> >>>>> The fact that it is already mmap'd to another address would only be
> >> true for
> >>>>> VFIO devices but as I mentioned previously, we cannot make such
> >>>> assumptions
> >>>>> with other (future) dmabuf providers.
> >>>>
> >>>> It is true for udmabuf, though the memfds that back udmabuf are
> >> directly
> >>>> mapped instead; I don't think the indirection of udmabuf makes any
> >>>> difference.
> >>>>
> >>>> If it's only for future DMA-BUF exporter, it is better to make the
> >>>> change when the exporter is actually added, or we are adding code
> that
> >>>> cannot be tested right now and may or may not work when such an
> >> exporter
> >>>> is added.
> >>>>
> >>>>>
> >>>>>>
> >>>>>> If this condition (a valid resource with a NULL res->blob) could o=
nly
> >>>>>> happen due to a bug, then, in my opinion, marking such a resource
> as
> >>>>>> invalid is actually a more defensive and desirable approach. If a =
core
> >>>>>> operation like mmap fails unexpectedly on a resource that should
> >> support
> >>>>> But mmap is not considered as a core operation for dmabuf. It is
> >> considered
> >>>>> optional by dmabuf providers. For example, although very unlikely, =
it
> >> might
> >>>>> be possible that support for mmap() can be removed from udmabuf
> >> driver
> >>>>> driver for some reason. And, when this happens, the only adverse
> effect
> >>>> would
> >>>>> be that gl=3Doff would not work, which is not great but definitely =
not
> >>>> catastrophic.
> >>>>
> >>>> We should be able to safely assume it never happens due to the "no
> >>>> regressions" rule of Linux. If a userspace program breaks due to a U=
API
> >>> I help maintain the udmabuf driver in the kernel and AFAICT, that rul=
e
> >> does
> >>> not apply here because udmabuf driver providing support for mmap()
> >> cannot
> >>> be considered UAPI because it is not providing any direct (user visib=
le)
> >> interface
> >>> to invoke mmap() as described here:
> >>> https://docs.kernel.org/admin-guide/reporting-regressions.html#what-
> is-
> >> a-regression-and-what-is-the-no-regressions-rule
> >>
> >> I suppose that the result of open("/dev/udmabuf", O_RDWR) and the
> >> UDMABUF_CREATE_LIST ioctl is always compatible with mmap(). Not sure
> >> what you mean by "direct" interface, but they are all plain userspace
> >> interfaces.
> >>
> >> I suggest asking people maintaining the udmabuf and the DMA-BUF
> >> infrastructure if you know them.
> > I am one of the two maintainers of udmabuf driver and I am also involve=
d
> > in the discussions with dmabuf maintainers regarding upstreaming of
> > vfio-pci dmabuf feature in the kernel. And, based on these interactions=
,
> > it is clear that mmap() is completely optional for dmabuf providers and
> > userspace should never make any assumptions about whether mmap()
> > (for dmabuf) works or not. Here is one reference:
> > https://lore.kernel.org/dri-devel/Zjs2bVVxBHEGUhF_@phenom.ffwll.local/
>=20
> That adds nothing more than you have already told in the past discussion
> in this thread.
>=20
> I started this thread because I found that the current implementation
> only exercises udmabuf and VFIO devices that is known to implement
> mmap(). On the other hand, the cited email discusses VFIO devices that
> are not known to implement mmap() or future DMA-BUF exporters in
> general. It says:
>  > Just wanted to confirm that it's entirely legit to not implement
>  > dma-buf mmap. Same for the in-kernel vmap functions. Especially for
>  > really funny buffers like these it's just not a good idea, and the
>  > dma-buf interfaces are intentionally "everything is optional".
>=20
> This doesn't apply to udmabuf and VFIO devices we are concerned with.
> udmabuf is obviously not "funny buffers", and can be vmapped. Besides,
> the udmabuf already implements mmap() and *removing* it can break
> userspace unlike a DMA-BUF exporter that never implemented mmap(),
> which
> was discussed in the cited email.
>=20
> Speaking of VFIO devices, the code already checks it's mmapped by
> calling memory_region_is_ram_device() and yet this patch tries to allow
> blobs that cannot be mmapped, which is inconsistent.
>=20
> So, the discussion should be summarized as the following two questions:
> 1. Can the kernel remove an existing mmap() implementation that is known
> to be depended by the userspace (udmabuf)?
> 2. Can the kernel let an mmap() implementation fail though it once
> worked (VFIO)?
IMO, the answer to both these questions is yes because mmap for dmabufs
was optional to begin with. And, just because it works in most cases doesn'=
t
mean it would work with 100% certainty in all cases at all times. In other =
words,
we should reasonably assume that mmap() can fail sometimes and when it
does fail, it should not take down the fast, h/w accelerated path, which is=
 what
happens currently.

AFAICS, you are putting undue emphasis on mmap() capability for dmabufs.
It is simply not important for GPU based use-cases because it is a very slo=
w
(and sometimes practically unusable) path (60 FPS vs 1 FPS for VFIO based
buffers in my testing), which is why it was made optional for dmabuf provid=
ers.

And, what this patch is essentially doing is just making sure that the fast=
 path=20
continues to work even when the slow path is not available (or fails) for s=
ome
reason. But IIUC, your argument is that if the slow path cannot work, then =
the
fast path should also remain unavailable, which is what happens without thi=
s
patch.

So, the status quo is not that great but I don't think I have any further a=
rguments
to add to this discussion at this time.

>=20
> The cited email doesn't answer either of them.
I am not sure who can provide definitive answers to these questions but
I'd like to move on by dropping this patch. I guess we could revisit this
discussion when new use-cases (or potential failures) arise or more informa=
tion
becomes available.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

