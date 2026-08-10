Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9901FC5AE5D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtNZU-0004JT-ES; Mon, 10 Aug 2026 06:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wtNZS-0004J1-V6
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 06:49:30 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wtNZR-0001hi-9E
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 06:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786358970; x=1817894970;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iW9expB6szDurnLaEuatxBULZLDUmm/rgIqmnEZ+K54=;
 b=RTuWMWTFW6u3YwiGXuaosXiankePlTx/HKrGa8XS6Vi+a+uaXkvSvAMv
 nC5v6I3UCs2Pb2mpZsHn5TPzGv3VNAAm1u7Ju7hk1/wyXr6rRsePTzZ4Z
 xI/yR3abl81pZxzy4lr7y6ICfqEAflMyRhYCzX4wwY+Yqq+kJDcVP7RSr
 iHPYJCvhpCukphsG/Z93aXuoTu7WT3K9QqBePDS999zz1q0nPTt/Xb9fp
 RFzRTPC0cUu9rPb3ttBmts8FvIwTHALAdjkZM9i3sGEWTvgvkwDjReC6z
 Ys9j74r05IXcYZCLlWTB87fI85WWIMFxkiMeGAQF2Phtgn7dEJBWxcP2p g==;
X-CSE-ConnectionGUID: 6k4WvqSmTPOTUTpdSZr9/Q==
X-CSE-MsgGUID: dx0MSHW1SY+GgOlsW4aWVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="90550663"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="90550663"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 03:49:28 -0700
X-CSE-ConnectionGUID: JrjD7do0SWKRnuXHJAwF5g==
X-CSE-MsgGUID: DT5Ahm7+TGq+VtsNqOmHTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="301237248"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 03:49:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 03:49:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 03:49:26 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 03:49:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwnMevDRuSo6KUGZvTeA4nH75uypNi9QwNV1sFfhPDlKiA1oRKnR5Fi1fOnA+VA/2bROQafsLgcTw98Zzsxp/QVUTTorF7Fzo1uUifwi9p0GKuqJ5Zh6tujqOW3EEJoHz8JVmWa5tRzynF6/PzFEbtBlOgH97pZNEdPG4QGsVHlQJzGDHNnWI8dUBsax7qoCl7UqkKGl0nk4gMnrg3P4A5Qnis7Vm/sGdISxawRSKOzL7XtHNtkgUkqCbQtV5vrxwr2oPCcWM9fIcAZLnDr3PV2GVX9PElL7CdVRhQO82YMBrkjVgEnNPCcW2kRK2Z7pKP6J9QO43h7qL2FOGQODwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iW9expB6szDurnLaEuatxBULZLDUmm/rgIqmnEZ+K54=;
 b=HxhWv5xHKzDU7cBHmjQtsEdbofsSQ/UDsPYmsJf91v68Gj1jUbVnloH9kcWPX/Ies8zQYnpUlBc833rDyRxHmfypbhoNoGj6xoBEQjt+2L3RQnIR6zm4CWMEaLUvK8l9/K0bfyT4gG8Thl1EUuixMej+4Eu68NkCTlOKEMInqNgT9MGUCCqD99xSasBL8ZH9Wd40wkgtvlFGzZoIfRHtCdCpJraygLT3EuOUgA6O5/xNs+C5hTtZ9Td+JTBTPREyBkxrw96dD8LPeADwbm9n5suId41utlFyTo1sPTHVyvFkZ0GeKlpIyjctl7FgwW2JWj3PNCa3huvF6QqWILSZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH3PPFD114713BA.namprd11.prod.outlook.com (2603:10b6:518:1::d50)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:49:23 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 10:49:23 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Topic: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Index: AQHdJXaoJ2foc7Rrs0CFGZilBc0gdraUUwKAgALNe6A=
Date: Mon, 10 Aug 2026 10:49:23 +0000
Message-ID: <IA3PR11MB9136D461AAF0FCC8D757B33C92DE2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
 <45013c8a3fe7983ee31f52d9d9ba6c176ce98fdb.camel@bull.com>
In-Reply-To: <45013c8a3fe7983ee31f52d9d9ba6c176ce98fdb.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH3PPFD114713BA:EE_
x-ms-office365-filtering-correlation-id: 5d04bc8d-c815-40d6-bf14-08def6cd0a3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|23010399003|38070700021|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 1/tuLXRbaqvk8fxK1yUz9AN5AwcsH8UTh/SM5mkARZ0qbFN5V+cQXPE5YYqHxVV8fWDX4TKxRHyuyhx9UrjL70ASliLeZjyrHYxAZcR0iEwRf2RUiVnGmJCybZY9d9BAiMvzUXhHfTOxeyX26BWNcq0L5CGclisk7Z08mHbUdRomGlkmzodcH6URg3+7YVkpOaIibFSSd/cqjcEnXDr2mTnfhTfr/Nhbkn7+tWMPBK8tXtsnlkhT/f75vb9fTY3IDy0uAwcHR7hr32WHd5ikpRZsuyJtWLfC4NHQv9xN0u468wMIlvB5Z3aQtgyeIlQZtvD4JVNMMsCZALwZqIVIo0kmgRmvml17ye5zNOa0NmqBxOKFejZ4qeRrAhXLonUAcLKU2vUbwdqmvz+RrL2KRZCfmzmYsiQ3+Dn1wEqbB5RQdgfkpAulLlj75xXf8eVWrOmxIKNc45dbDzRl7ogznNjs2X/cJdDgpitnSgFvno1+2z7rU5tHY+t30OJrqUX+0pW/wr+pjnGEkPQ0bCLiBbjPCPRygqrcJh3hmftxatscuADW3MT5P64RLX4k5ywIw6bNZfM7pJCqwZ3Z/7mxnU5DQW5dI2FQ1hKdHBUBPRPJcTHVi4HE4xEaQARPlO8buMQVSGaYzofAK/Q1URV756/z2/q5QwnFmJ6g/GoNfeXN6lUU5pxvsknYudkFXqVcUDYABfacJ0NqHsjKQjM/Hk5VSD9Aw54W8ogaozR7zf8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(23010399003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVNQcjVWSDF6V21hRzF4cUJEMGU3c0ZVYUpQV0ZJNHV5aXhhYTRramVmR3gx?=
 =?utf-8?B?T0JXK25xbExnTStlUjNURDZBL09GRXM5bDE0M0l1VjJQYVg4WDlZeWVHYVNB?=
 =?utf-8?B?U3Aza2o3ZHkxS0tyc2h1eXpsRHhkT0ZweEs0V1FhQ25XMFBMWFJpa0UyYWRW?=
 =?utf-8?B?MGNIZFR3ckV4cW56OWhsWnkwRGVPUmRRS3djZnNwTVJGbHZhSmQ4SnRHUkll?=
 =?utf-8?B?VHlpSjU4RWxLU0ZodXdpNEhsNmNjUEZKVUZvWW8zb2kzRzhVS0pSZzBOZ1RD?=
 =?utf-8?B?dW01Z3JlRmpYQ2lpRnNNVnFrbnVxT2pkZmNWeVFMa3ZkTW9BZ3BLVFpqYUVs?=
 =?utf-8?B?RkRSYVFWdDAzNHJlck1YK2RCeVlBMlVMMytSY2g2SnQyWnNyTmQ3VmRQTmtV?=
 =?utf-8?B?czg1VEZVQWlNa2grZDhqUVZkQ0NuNzlUNkpRbXlXbU9uNHd6UHBRU2pHNUN2?=
 =?utf-8?B?d2k1WENsdjBOTEdva0l0MHJZa1VNSmxpWU4zUWQ2NHA1ODUyaG1OVDdldWp2?=
 =?utf-8?B?d2JIZWM4T3lzYlFkcWIxNDRNNkZMSDVSQk43ZHNoTFJkUDZtMER2RWpPcjdF?=
 =?utf-8?B?Q1ZUK21PbEFJSThTaUFpMTRrbWZ2b0g2eUkzTmw3azJXMGF0b0QxR1BWaVdQ?=
 =?utf-8?B?enJWeUUvV2NvME0rcUg0REN3TGtZT1lUNDJTSzNkZ0lvNlUvSWYvRlN3b3dq?=
 =?utf-8?B?U3ZNaFR1Y24vbGxoSUJoYk02SVFEZi8wNGlwWkVtVDBhQllxdDVBQnVvRWtL?=
 =?utf-8?B?WC9QL09aQU8rZ0hzZHNFVjI2VlB6S1ZEK2hSRzR4a0JmU2NZc0VyNGsreDlD?=
 =?utf-8?B?MDk2WkpQMVpNZWVXNTcxNUtxWmFBZTJTRDllaC9TcHR2TWlkVGVGYzFTaytK?=
 =?utf-8?B?cXlQejhEM1ZManZFNWpxcitZWjhxbWU5RXBqTUZaMlNNUTFhWmpTcldJRDdS?=
 =?utf-8?B?bXNPMG1HUkdBcmlMZ1lwajBYSFlkNTh1dVV6QTliNXpCTU1yWFFGSDZrdE9u?=
 =?utf-8?B?a0M3bWFxdUdDMmRmV1llWlRmd1JURnBVajB4YXZPK2ZkRVBncUgrZnVSWkNL?=
 =?utf-8?B?bmJudkQ4QUZrUzJWNjhLeXc3TUZEaDJSaXQ3aWVpTExqN0U3V3lBUXJWNzFV?=
 =?utf-8?B?T1dRODVKbk1POXVFajc5R3VQeVBGZFl2MFBlcGhwS2VQVnpPcmJGdHJCY1k3?=
 =?utf-8?B?K2xNZTh0NmFqLzNmbGFlQ2RTa0pUSmxaZ3JsQWlWQWZwV3Q0ZThNb08xUTZi?=
 =?utf-8?B?Umpmb0ZCY2hOYjQrY0dxK0hsM2c3U1BzT2s3Vi8wYTZydFgyVDJwc2ZVUmth?=
 =?utf-8?B?QlRKVzlwcEd4ckE0UUFQd25zYlpuanRzRW5VQTV1bllkdTJvZ3NnTmk0UlVC?=
 =?utf-8?B?QVRzRlo1Uk1VYi9HYzZsWkVLZ0J6VmNOSGxMUXBWUXhjTURoOXU0SEx4amhF?=
 =?utf-8?B?djdDOVYwcEZvYUNMSDVseEtCd1F2K0huWUo0WDBDQmZ5ZzB6RUJTZ2Npbi9D?=
 =?utf-8?B?ck85QnZPeVBYcG1xcWpzT0tHeUZ2bnpZcUJCMWlla21Eb2wwWFZrMS8vNXRT?=
 =?utf-8?B?N0F5bDNZSXJ5NGhzdGxncmprMDVBUEY4OHBqY1BuTE1WU2FVdndVRGZOSG5r?=
 =?utf-8?B?QjBpNUhicnhqUUJQZElmMVBsbjZvRDAwb2FZUE1yK1BQNEo5dFZoaGxtaVNu?=
 =?utf-8?B?MUo3cU9rNGJkOFVPUGFRQmlWYk8xZmlBaTlscDlzcUVyZzVNR05uak5xYWFx?=
 =?utf-8?B?cDNUNTBaUE9UNzJ1bHpFNjdKaUQxN1EzWDB0RXIwdUlIN3FkTkV6dkVzYVJm?=
 =?utf-8?B?eGlMQm40dWpkUDRnSWFhM0NvOXdmekZsNFFNNXNWOEdUQlcwWXpjU1B2OWJz?=
 =?utf-8?B?TktOZDhnV3VadGNQMmJPWGhRTnN2WWdxQS9ObFpka1hZUFhPYUwrSGtJNTdH?=
 =?utf-8?B?MldHRGhmQ1BjQXRHYnh6Nk1oNFlmaFZGNGs0ek1PejBKOS9qSWsrRHUwa3dV?=
 =?utf-8?B?R2FHTzdjZ28ydEdNWWMyL0hKQjRQTm9CODBYYmdHRm1FYUFGQVd1NW50cnVT?=
 =?utf-8?B?aFg0Q2dKSXpieUtNam42cURYcVV6ZjI4bDVtUGluSTdmMlYxazJTVjFpdnlH?=
 =?utf-8?B?WkpFME1Zb0ZEUHZ3MjhReklrSkhWbng0OXlkcExSdU9Md2g2djdzWXU1WkNR?=
 =?utf-8?B?KzA4RDJNaWYydzZlK2RaYm5OSUpjdFZMalVqSDlFYlNuZkhDMEFxaTRvOHFT?=
 =?utf-8?B?c2ZYWW1ObnJ6TStLWk1sbENSNXFLd3Z6NmxOc2pTM3NwSHovdmU1UlQ0MElJ?=
 =?utf-8?B?dTVHQjd1Z2JpK1psVTdlRUhhcjZzbDVQRWlPeXhNREVKUmJFSDEwUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ctmScNSaG0N2jhpqrSSpIbER2kSJE4I0Cn+FI+rQNaackaWmgAaz2XZ3dljf1+ZbH1tmXzdzEyIiiC/5w2Dn66kouDym+IZgUWrZvdbrqi+KllmT8ZC1wn21TFXZuO3JkcBDkKt50MdH2U5OQ4GkZcGbD1moJJp9T7uKaiTCf2UXdY/1Et7dj2J7ityzoDcnR5rDQaeM7KsNK4OaYADcSq9Qs0fH/h4I0fPZ0YH1WuAxODWWEuHAIZfDqdU5CiFDbzw8mtfUlQGgU8EWua6mfZUXNetm0sxA3r3o1AwTBGeiLaL2PQWVIblXaus9FIxWy00AcPxxNhTfl5Sgu6S/CQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d04bc8d-c815-40d6-bf14-08def6cd0a3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 10:49:23.2778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqXKPCJ10y7Z6U8y2rDrjSpI6pWVhKZPRUI4p4LpgvbTZdK173D7GjwubyVyQCWeYWa5w1jKQeZUiOmx6ihWKQzpr8CkQSbkdo2LkNTzmCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD114713BA
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.827,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ2zDqW1l
bnQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tPg0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjMgMC82XSBpbnRlbF9pb21tdTogRW5hYmxlIFBSUSBzdXBwb3J0IGZv
ciBwYXNzdGhyb3VnaA0KPmRldmljZQ0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5JIHdpbGwgcmVh
ZCB0aGlzIHNlcmllcyBlYXJseSBuZXh0IHdlZWsuDQo+dGhhbmtzIGZvciB0aGUgcmVzcGluIQ0K
Pg0KPmJ0dywgcmVsYXRlZCB0byB0aGlzIHdvcms6IGhhdmUgZXZlciBzZWVuDQo+dmZpb19kZXZp
Y2VfZ2V0X2F3X2JpdHMgcmV0dXJuaW5nIDQ3IHdoZXJlYXMNCj50aGUgaW9tbXUgc3VwcG9ydHMg
NDg/IFRoaXMgbGVhZHMgdGhlIGZvbGxvd2luZw0KPmF3IHRlc3QgdG8gZmFpbDoNCj4NCj5gYGAN
Cj5yZXQgPSBoaW9kYy0+Z2V0X2NhcChoaW9kLCBIT1NUX0lPTU1VX0RFVklDRV9DQVBfQVdfQklU
UywgZXJycCk7DQo+aWYgKHJldCA8IDApIHsNCj4gICAgcmV0dXJuIGZhbHNlOw0KPn0NCj5pZiAo
cy0+YXdfYml0cyA+IHJldCkgew0KPiAgICBlcnJvcl9zZXRnKGVycnAsICJhdy1iaXRzICVkID4g
aG9zdCBhdy1iaXRzICVkIiwgcy0+YXdfYml0cywgcmV0KTsNCj4gICAgcmV0dXJuIGZhbHNlOw0K
Pn0NCj5gYGANCj4NCj5JIGdvdCB0aGlzIHdoZW4gdHJ5aW5nIHRvIG5lc3QgVk1zLg0KDQpJIGFt
IHRyeWluZyB0byByZXByb2R1Y2UsIHdoYXQgZGV2aWNlIGRpZCB5b3UgcGFzc3Rocm91Z2g/DQoN
ClRoYW5rcw0KWmhlbnpob25nDQo=

