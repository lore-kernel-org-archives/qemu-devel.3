Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03ACCCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 05:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9dTk-0008SD-DG; Fri, 17 Oct 2025 01:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v9dTi-0008Rx-Uf
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:58:15 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v9dTf-0005iy-R2
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 01:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760680692; x=1792216692;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=u3f4wOZcpTavFrNsgwTU6dodZ1Kh8Wt2jhtrzT9YppA=;
 b=m5+eV/oiX73pR2x38OOCjkxfwfZzd92PtDW8RbRQzf0Uhwa9UoK+RZ3g
 ABNC+9cYPiiFido/XSsrfbfIt2eQ1vkKW2mQof1uA0+5hC3O1FTr1Q7us
 JfAxrZx21Yp+FTSm1fouST4xon65nCmzcePxjG4MA15ScKZlIyDa3DUp/
 PmC60/ngjh1mij+S345makGVDMjL+D2FoCGkzPHQFbzAgETfGewu3x3AV
 NxnzrkkLYnQcb4KIkqasTnuZBr4+TKc/SoCU8qesUgy4CFD4VEjeGkykt
 txsQhSz489ncwjYj7eueM6nzhLH1OBQ3hr4dkxl0bZWDkTt/SVpGpuRgO A==;
X-CSE-ConnectionGUID: Sn+8lVZnSTyV8irsNU/AIQ==
X-CSE-MsgGUID: 71hFYWxGTpq03ChrlNNArg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62787754"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="62787754"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 22:58:07 -0700
X-CSE-ConnectionGUID: FnLLFwu/Q5KEdYqUTxZI6Q==
X-CSE-MsgGUID: 4nRwLin/TRuJjr2Yktbxlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="182334306"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 22:58:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 22:58:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 22:58:05 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 22:58:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1iut/8D9p9vUPiB+mMHdciay0BSn+ZsAKptZeRlfcXLMwHDb9wxkhJ6u0gVwPUwUe6lZSuHJVW4coBLHpl+tWnpbdm/84xFsE4y5TRKCF+KD9mdJ7SM5ZpnJidyLkn57h1ctWXN9hWc3+ur0csUBf+1tCHPGWOZghSXqhBCdof95JnmEKPpsZTrVTDgNUPoNJeLZa06k9SFPDHdnYtUrq4Ysp+4/jTzmD5FdHT13yzEXfk6KfatHvRbJApyjIemtyAkQcA8tdmvpREmrHAA19ldCCDkFFbinRAdzFaMS7vExzwVmDAfmpWDNjarvPisYVz5Gw3mlxr0epQYT08o4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3f4wOZcpTavFrNsgwTU6dodZ1Kh8Wt2jhtrzT9YppA=;
 b=yqFpp70+/nGWVQMLnYjieWGEdoNswN/OS5+141E3dSJB7+byj0qVkdEiTQ1cyw6rvAauLERQjVRvXSHqE3pM4T8xCfq+9CDR7vUZV7uTPr0uoO4HjtXckBryZ7v6mVYQ3X9LBeNjLwFCsK+4f4rYIzJEsC2Nrxe/mpzHcQqpn+FSZghtJYLTsunRLbcESR3BRG1FLnFIGnXl+bDk2Hraw5nrW69CxYCfih4wQzYe9uqPYCS5hXhdLTSljQYmmD5Zv0SMj3w3kvpTKEhjO7oizsoV1aVTvNlHBQvbhhAU5UUfPbSzN2kZJk+OXD7qtigGnjl79iG+TWrrmwyU99gkbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MW4PR11MB7102.namprd11.prod.outlook.com (2603:10b6:303:22b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 05:58:03 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 05:58:03 +0000
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
Thread-Index: AQHcNL+RUYjirTlu+0+SWGS5LfcOTbS60JoAgAQ3pzCAAhCigIABcDrggABCiYCAAGOhAIAA+5vwgAA96YCAANQF8A==
Date: Fri, 17 Oct 2025 05:58:02 +0000
Message-ID: <IA0PR11MB7185A158F3DC20170E673E7BF8F6A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-3-vivek.kasireddy@intel.com>
 <1fd966d9-95a5-45aa-8a20-46f2987cd65a@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718547E3A9E97A0DD6A4A2D6F8EAA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <ba762750-cab1-4cb8-a629-101de5fdc179@rsg.ci.i.u-tokyo.ac.jp>
 <CH3PR11MB7177C4541131508F53BD27F3F8E8A@CH3PR11MB7177.namprd11.prod.outlook.com>
 <955ea687-ed25-47bd-9ba9-73c6b98c8e29@rsg.ci.i.u-tokyo.ac.jp>
 <1f127ac5-10dd-435e-9ff5-f70596d7aac4@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71853F97E13556E781AAE104F8E9A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <a0bcfbed-b6a1-42e5-b482-eb056fc2cd25@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <a0bcfbed-b6a1-42e5-b482-eb056fc2cd25@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MW4PR11MB7102:EE_
x-ms-office365-filtering-correlation-id: 3b6c07f2-8d06-4d9f-b469-08de0d42226b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?rhg5GEN/+lGnMJW5Rx4PS2oslvcwwws5ilQoQmzwro/p0aOr/ZYBOLIC0x?=
 =?iso-8859-1?Q?bORto9ixddlzJdzJ6AyJhHmtwSgobiBEbsqQFQVxZKN7FXEHBnUtrv4Bsb?=
 =?iso-8859-1?Q?rgyQhVJrEkL3SJusgzJBnq09nF4HeXUm+vJ/6tbWVP9yhRfb6soYpEGX7r?=
 =?iso-8859-1?Q?Lbi29VbQyxwg+edCyNi2POM9DJ6nHPyemwhml3T2k99JbgZGfQdfvzVU6y?=
 =?iso-8859-1?Q?1VChDYuscA6EDoXFbHAytHs8bXGwcbBxGBfv0JRRTgyFNwLr2l01DsUHKA?=
 =?iso-8859-1?Q?7VhmGaxrJIJM40+7Zk/y7PqE2zno6WovD0fsjX2MJRbwIcQu8Rukc8J+cX?=
 =?iso-8859-1?Q?QVfKRKTjqTjkLF2jpmJZvNw3JoFz5FqasdxJsBpIgcWvbIua/G88aMaL8w?=
 =?iso-8859-1?Q?MaDfqVyDjwmj09VMz8ug+EKqgA1SH+N/g7m7RsQh/Xf5OVz+erNcqGSdEG?=
 =?iso-8859-1?Q?HH1etnOxzlXYkoo/mBisBoT2GEKHyy3T1/td0O6XzOy2uHUNwG7p9iW5/b?=
 =?iso-8859-1?Q?wCB1aYNyVifhlbaaL8vCTfCsYWzBJUkeA4Cnl/Pq3UV1o5h5MwW83CL9Rf?=
 =?iso-8859-1?Q?JcwPLjVj37lvp0PBDBJ3w9QEhVZPsJniYnSDAocvjd2zvVPUfD4sIANWft?=
 =?iso-8859-1?Q?5cSVZliQv7LbUiUKCm1nGUjMm9/69xBik3G6cQNxl1bMX3k2cKNNDiQ7Fj?=
 =?iso-8859-1?Q?YD61ZJTSl2WqPIXtoRjqWFBgRK7GqxvNN1idYFBmLayzWaZRXZW6WkBGrZ?=
 =?iso-8859-1?Q?TuFXs4IWSf36GOdSTtuaKduLa5KCgMNDMmeeX7agbdKIjK3KmzHIQIOy31?=
 =?iso-8859-1?Q?RniMIqj/84jJ6f3BNUdJy2BHUp4yWrJg8aH/oRXCPcwnOGB4R1poydsUD1?=
 =?iso-8859-1?Q?/fgBpzN4B9dr6zum1eIrfKbCZlKu1+zHwI8tPssamn4h0m+/+IKhkJoSJ6?=
 =?iso-8859-1?Q?y50kjxeAVY2VVfh5cneubAkhNwxBPbfXNQ0nbTB8d8tSWQzq+Evnw8lRtk?=
 =?iso-8859-1?Q?w9U/sKYh9sX3ac6CKpRxXLXQSkmWZldw3DB2NSiOeUUIAr+AAokUAYj0gn?=
 =?iso-8859-1?Q?Ms7fvrTrBvIj572q+snTTuC4NUhmYuKCV0G0q8nqTDIaIswkUa4ma/iIJc?=
 =?iso-8859-1?Q?B9wR59i5ua+u7168VBN/smxvni1VJVjlKB7Hd5Yifcl6AZKkgpctNf7gnU?=
 =?iso-8859-1?Q?C9pYLFIGPXpUnc9h6nrBvO1yVGlzrohmJKPuwMsvHrFv/k77WohBtEA9CS?=
 =?iso-8859-1?Q?jjXT+LsInv5Adji/6Zqh8aPsKwAiRRjCOOYCZHbqOkCS9V7axLLZT6AW//?=
 =?iso-8859-1?Q?Wdw1W0DUSwC0qBdrpRt2V/+fIu3kWKehb+/fp31UpJPzyC6gibJqTeulRC?=
 =?iso-8859-1?Q?ALTN6nShd5kPGw/vs7hBgbEULppOywL0VcBphxfeoc/Yr0FjvV2c60/GKf?=
 =?iso-8859-1?Q?8c7GttF/phftOUFvKhgU9QJ/Xgwf6fpknej+/4ktoUraHZTNhOTMOApxNz?=
 =?iso-8859-1?Q?P4XfLiS0wAW7gZiqsLsOKAYkJroJnjnhDt+hHMP+eAVu4OXY+sKj6KHOKk?=
 =?iso-8859-1?Q?A8tujF7zUIBTKbRnN1rfYRTSftW5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dbQuZLm4Kt3j6SqKMdv7mu0VhvtqvOTTnXGNLK0/wDaCW/WKznrl3FA33L?=
 =?iso-8859-1?Q?l9WiC3T8ETSZMsj91gS77Suux/Ze8emnJbfKo1BiM8PLYrivwHAB2dAeEg?=
 =?iso-8859-1?Q?2TBrLV7E+ArzAansQQHPI1KIIuI7nQSzcQXBKzw8rfD0gvupnqEHGfLaDZ?=
 =?iso-8859-1?Q?NGwbnGUNE8BQyjeccsfA01NYwF/XMGGDuqE8OrZYmXpwSlGm6Co9odVhBk?=
 =?iso-8859-1?Q?KYPn7ni0GWa8TdN9rFfEzzgyiQh31p7vQksjpQLUKfAROGRo3PbPe+I+8o?=
 =?iso-8859-1?Q?cactqtifDbQmrd+ApWesbgP3N1TftgpTPXjs9kCqY0UoW1ujYTzs4zGb7w?=
 =?iso-8859-1?Q?iCV4Utyquvc3utG+EuwoCaOP8qGB1Rh2casoEQPyP8V724zuzjbWdkGn+m?=
 =?iso-8859-1?Q?b2N+UAKUjWW+wa/Y4JivdtlCuCFeW4d3OrnF09Ooolkxwzo+slvy38+O1+?=
 =?iso-8859-1?Q?7I/fuiA7H4NevMDlL8c8rHL9iNKq/9CSQPgpjIdvmSWK3a21GpRNACH3LA?=
 =?iso-8859-1?Q?SWsNSyu+rWEMLwCh5ni2ipMCndWPrdEkTmiwj5apdSoRtI2IAYaCmNeotd?=
 =?iso-8859-1?Q?IVgjP+Kq6N7uSqrex06lVT+bInyqk/uRqwaECFVCrxBX23v1CMAbTlO1Hm?=
 =?iso-8859-1?Q?h967FYrCIJ9hG4KK8p4+ViwEhhiVUMwsijQg3ZRV/NjJc4LYIEK2FLn8NU?=
 =?iso-8859-1?Q?Ko2zA1bApOqrjbr3jl9IL5+U15nCEMotRgvq6Jmxg1S2DSP9/DLok5EuUd?=
 =?iso-8859-1?Q?3YDC5/sPp+OcvyS2AnFadBlKG5qNf8bBSVjR7ro5IzXNjrV8s6gRcEFk7/?=
 =?iso-8859-1?Q?i6W5GASzg3jRkOTXYKZ6XkT1Zd24UdELvxA8nm+N2kHmnS15VCkLBLcS0M?=
 =?iso-8859-1?Q?E037/MqNJyYhConV2gf7hqmPAwClxcGwhkklq8Pl7hWmNwkAQRPekbynH6?=
 =?iso-8859-1?Q?FnfIbEPyO7fNfP/MKsdP6RLxq3sXUyDi9EG9jKO3qnGgb2NFCZWHUd5XVH?=
 =?iso-8859-1?Q?kY+gPHTHuAfYDTMJ8lj4m1b7J4lVIEDFicbXm8u24MrDR42Q45zm28QIwF?=
 =?iso-8859-1?Q?rfhd4Gexo7jwtHqEFuo2WhhRgazdH0sIyqG6crMi3YKQpOPmP3pzTXw9EP?=
 =?iso-8859-1?Q?cHI6Z+ciaOOh5N1UxNKPYcXQt+MU9fDP+ZbyBp2IGAH9Fb4HKbWXKVwJGg?=
 =?iso-8859-1?Q?opWE/JF6SJRL4I1G6WKSq3m31/pPaAaUBSMJSCvkVGX3ohoZZJcRs3nTED?=
 =?iso-8859-1?Q?Udzt9K6wFcaobYvv0KD/SGmA7JofU87RABtTAxhOjHRJQcM5YJW/lBOs17?=
 =?iso-8859-1?Q?jLL+MSJDSp0BEWXuiutkycATHh0ALdv5LxDnQch0UP998uoC94xeXJoz0u?=
 =?iso-8859-1?Q?TdPGQWVayCyVdTGDAVMNzDBDxesYVs3MetocmoZQChT6IgBTHg13FABift?=
 =?iso-8859-1?Q?+gjv/bVTPiob8C0hN5L7Eq4SoX5cCKnPbgtVaMNGnbaX/TxkKO3V1erpDK?=
 =?iso-8859-1?Q?LI5M5Jkmap47y1hSVsW0wO+M1rfEjuyKNNF5diWN0bMOnJxoYAtwnmoVSQ?=
 =?iso-8859-1?Q?YxiwYBI860WyobajgQw09jPZsCDHc7qaKWQFTZtL5E1CZsxlsjqvaRyu74?=
 =?iso-8859-1?Q?0gCDDmeEsygVzpmEr4FGQ2+TLCwB3S0He7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6c07f2-8d06-4d9f-b469-08de0d42226b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 05:58:02.9613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMPfkYvPLteVo6mJ1ChnkTqzg6MG7xR9L7ZSbl502RvnTrkV2EFezBhFgb2+04khfrPw5oa6y/us7QOmqkRB8Ke9VAwoJbYIzj8JAceZflU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7102
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
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

> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identi=
fy
> blob resources
>=20
> >>>>
> >>>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to
> >>>>> identify blob
> >>>>> resources
> >>>>>
> >>>>>>
> >>>>>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob t=
o
> >>>>>>> identify
> >>>>> blob
> >>>>>>> resources
> >>>>>>>
> >>>>>>> On 2025/10/04 8:35, Vivek Kasireddy wrote:
> >>>>>>>> The res->blob pointer may not be valid (non-NULL) for some blobs
> >>>>>>>> where the backing storage is not memfd based. Therefore, we
> cannot
> >>>>>>>> use it to determine if a resource is a blob or not. Instead, we
> >>>>>>>> could use res->blob_size to make this determination as it is
> >>>>>>>> non-zero for blob resources regardless of where their backing
> >>>>>>>> storage is located.
> >>>>>>>
> >>>>>>> I think this patch is no longer necessary since now you add code =
to
> >>>>>>> mmap() VFIO storage with "[PATCH v1 7/7] virtio-gpu-udmabuf:
> Create
> >>>>>>> dmabuf for blobs associated with VFIO devices".
> >>>>>> Right, but given that mmap() can still fail for various reasons an=
d
> >>>>>> this
> >>>>>> use-case can work as long as dmabuf creation succeeds, I think it
> makes
> >>>>>> sense to not rely on res->blob to determine if a resource is blob =
or
> >>>>>> not.
> >>>>>
> >>>>> I think the code will be simpler by making resource creation fail w=
hen
> >>>>> mmap() fails, and I am concerned that the guest may mulfunction
> with
> >>>>> such an incomplete resource.
> >>>> AFAICT, mmap() is a slow, optional path except for the cursor (which
> >>>> needs
> >>>> further improvement). So, failing resource creation when mmap() fail=
s
> >>>> does not seem like a good idea to me given the fact that supporting
> >>>> mmap()
> >>>> is considered optional for dmabuf providers. And, even with vfio,
> mmap()
> >>>> can be blocked for various reasons by the kernel driver IIUC.
> >>
> >> Reviewing the code again, I don't think mmap() can fail with the curre=
nt
> >> version of this series.
> >>
> >> udmabuf obviously always supports mmap().
> >>
> >> For VFIO, checking memory_region_is_ram_device() ensures that VFIO
> >> supports mmap(); memory_region_init_ram_device_ptr() is called from
> >> vfio_region_mmap(), which is only called when VFIO supports mmap().
> > My point is not whether a dmabuf provider provides support for mmap()
> > or not but about the fact that mmap() can fail (for various reasons
> because
> > it is not a guarantee) making res->blob NULL. But we are incorrectly us=
ing
> > res->blob pointer to determine whether a resource is a blob (and usable=
)
> > or not which doesn't make sense because even if res->blob is NULL, the
> > resource is still valid and usable via the dmabuf fd, which is the pref=
erred,
> > accelerated path.
>=20
> Failing to mmap something that is already mmap-ed to another address is
> very unrealistic and I can't really think of a possibility of such a
> failure aside bugs.
The fact that it is already mmap'd to another address would only be true fo=
r
VFIO devices but as I mentioned previously, we cannot make such assumptions
with other (future) dmabuf providers.

>=20
> If this condition (a valid resource with a NULL res->blob) could only
> happen due to a bug, then, in my opinion, marking such a resource as
> invalid is actually a more defensive and desirable approach. If a core
> operation like mmap fails unexpectedly on a resource that should support
But mmap is not considered as a core operation for dmabuf. It is considered
optional by dmabuf providers. For example, although very unlikely, it might
be possible that support for mmap() can be removed from udmabuf driver
driver for some reason. And, when this happens, the only adverse effect wou=
ld
be that gl=3Doff would not work, which is not great but definitely not cata=
strophic.

Thanks,
Vivek

> it, continuing to treat it as functional could lead to worse,
> harder-to-debug failures later in the pipeline. And I hope it can be
> done without complicating the code (or it even simplifies).
>=20
> Regards,
> Akihiko Odaki

