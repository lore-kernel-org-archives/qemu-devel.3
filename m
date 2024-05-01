Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E8BC4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 12:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s29Ab-0008QJ-Vi; Wed, 01 May 2024 08:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s29AZ-0008PW-6B
 for qemu-devel@nongnu.org; Wed, 01 May 2024 08:34:43 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s29AW-0000f6-AE
 for qemu-devel@nongnu.org; Wed, 01 May 2024 08:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714566880; x=1746102880;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ka6Trdd3YqG2iilZb6Nd7V/asHjgsPhxWaOo9ysi8LI=;
 b=bv8nK4A16VqLUEgBW5Shp/1TS41dH3LZUwH3eGqb3gXLnjj0F9FVPwsl
 rabwnExkV/EUjNpe8j+99uOS3iuioJVHzSBntbnScwgyaEaRYhB5Su0ht
 +UCEkEDGfo1PjUhxWKyKp7/N+DjyYr9IkEasH9YZrUu47ERWsus+QGdmY
 GmfruB6KqaFfbGdLzapudMJXaymb2KKcA5z9/LcFY8GRN91XBO/3wGuDq
 +qvgGMbUdQiUD2gUaTJSxykjWn+XU6bMO6xMCeuEcPqL4mVbWV1FvD+aO
 y1rHmk4coTCG235BP7cLoR2+2Emuqv33zZej9qmfpasfMadMNDTHvqo32 Q==;
X-CSE-ConnectionGUID: jw4muP4cQtaiOEHyk+qrXg==
X-CSE-MsgGUID: hNQXMQIITE2JKIpsyNgaqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10418599"
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; d="scan'208";a="10418599"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2024 05:34:35 -0700
X-CSE-ConnectionGUID: aZv9nsZXTby1uNgRGWcenA==
X-CSE-MsgGUID: BUF2LOJbTOOEgfW8wwsZog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,245,1708416000"; d="scan'208";a="26801911"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 01 May 2024 05:34:35 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 1 May 2024 05:34:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 1 May 2024 05:34:34 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 1 May 2024 05:34:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yg324x6+OuaW9rW3vt8ryZhQV57xp63x48O0RIEwg3L6YKoe9UAsfKH9KbaWiqieSrhc4H+QV1kiZ5S5JXp3mjQowPnNNIB8YVaQ1qPkLW/caLIZnYixIRxblWXnLRcpIFDvQN5Yg3PACujd+t/MjhmSeB2/ghNnsYMlGQgc8UMxFgyOYUNgbMM9nhELgN/rCpf9qJmb85rE8nadfL+h2oKZvK8jKyEzUNV0mgKtaEXZsKTmFRvSJqxbG3vT4FGuWhzKx/8wJL8pA45/D/6v3DdDKOZHGUVRpkPgbMtYhSVk7M2JbSbo6YCi/W4+9eVzzwWwef4xT/LfCpHP2CgEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys2QcocTL59CMlgVyEYtFA7GpgELg7eY0krYC6HAdao=;
 b=ewp2fVglvu/1OSs9Zvuk5B6UiVJZ/BBcxyzylQEn+4Nab6VK6WpDEnx4wJKpRre/KYE+RrNDQ/NHGBQ3OKiLHcIJurvhs725mpY0C9ysxw2Tn36MoPzMU/zvdQ4dT1qzaoBC00wWJ5uAIevuIZrYz6oNrzv2YRyZOovBDhWwU7d5Jn80tK0Qb2vPWkbA7sH81F18P7Dqd2ZHex+QvxlrnrXTuYXVXtlxtQbirRttfFvMxx3Y+aF4XvxTRR+lGFAEkq3JLntidnxrEmxK0n4kQZwdARrseo9QotUNtzzSDxIRtaFVZ4eUAvE+vpgDjnMN60RumSC6BVR5JL0NgMoZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA0PR11MB4735.namprd11.prod.outlook.com (2603:10b6:806:92::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Wed, 1 May
 2024 12:34:31 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 12:34:30 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::check_cap() handler
Thread-Topic: [PATCH v3 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::check_cap() handler
Thread-Index: AQHamgISrtOEAFqTuEa3yBgglOPHg7GAkSsAgAAE4yCAACVMgIAA38Og
Date: Wed, 1 May 2024 12:34:30 +0000
Message-ID: <SJ0PR11MB674486E8B903DF6B182936F492192@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-12-zhenzhong.duan@intel.com>
 <dccbba66-57c9-45de-9fa9-beb7b528e0b1@redhat.com>
 <SJ0PR11MB6744DC907835CB7FEF992EA7921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <47877e84-cf7d-4b51-997a-f61cd208a55c@redhat.com>
In-Reply-To: <47877e84-cf7d-4b51-997a-f61cd208a55c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA0PR11MB4735:EE_
x-ms-office365-filtering-correlation-id: a31f94fa-5972-413c-f03d-08dc69db0c63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|1800799015|7416005|38070700009; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?x33Uyu6ksz9ibXdM4kJbz9H1kLBp4ww9K0I7NOIOe63b7xfCoRF1g5NvpK?=
 =?iso-8859-1?Q?BVkwcY0U0amab9uAs7gbtwRo+WiHD8ZKPCJiZVW9R4se5IcVJ722caTB7y?=
 =?iso-8859-1?Q?2aI2OkwB0dowEjhHfaXlo4N69rHGj6A4piSyhegztw5lxuDi3d6RAn2vdr?=
 =?iso-8859-1?Q?8PrzDT5Q3Km4RhaPWL3orYRJr1ql5nOMBu6fJnBU8UzSpsaeBV3VMOQS9H?=
 =?iso-8859-1?Q?jzf5145sKMWdf8OQuDFCC+2QIiDEryBpzSs8D7pBm0hi6YIWCFZJGoZC+8?=
 =?iso-8859-1?Q?TJV9Qh2sKIFzPF7AQGxejALKat0rwVUeajqs3F9/qaz62rTs16yqD741d8?=
 =?iso-8859-1?Q?L162IB8cNSrt7nLOujkHWUvaxp46LYRWJEoGyvDibjHjZAUZ6Hg34x/032?=
 =?iso-8859-1?Q?Uyzo6peK/Mr/3Zlm/0/ColUUlY/OQJYp7DANBaz6dXcONWWxSPx4BonRKg?=
 =?iso-8859-1?Q?B30epSFYeTiOB/RqVX35dTV8lCVz85h0anFMK6CDS2kYUI0NOKIXFpPhrm?=
 =?iso-8859-1?Q?/Fe89CTqNHClwAyzXLJlA/t4rx3g112CXyfLmCo57aVGMIuJlEwtDTjM1r?=
 =?iso-8859-1?Q?d+uIRm1RXmU81os07sYloH2dyGwlz6NOca2HUYL8jwrDUsFbv77pVeoTdt?=
 =?iso-8859-1?Q?Xk3dr/rr3T9otP5X8uFawouRGZAMfUSZDoR+yH9uZW8Q/aIg44WeVNVnVV?=
 =?iso-8859-1?Q?WiO74wYknFI51Z92MTOxyw1Njk+MP2Fh6sfwhiiG7m5TT0cpxws8UsvNy7?=
 =?iso-8859-1?Q?ywV07Sv7ScPvgS25WXQK5ptMpRZ8v2nfb3yqPc2jCrSZIv5DW7vRFv1NY0?=
 =?iso-8859-1?Q?ahCmPa5faekeHhq+CWFeyOGpz138X03Gj/SUrZcX6O7KTQ2J+Fp45QsgXI?=
 =?iso-8859-1?Q?P9U97YRij1jpp+ktSABvxosldZRgzthwz86NAcsQc7CWim6Eri1ega8h/w?=
 =?iso-8859-1?Q?Zmh7RBAoLqn6/LqGpiqceHfKk7m5gUM9GWBmWz7RoL6hi3Q+k1LmjrXJG+?=
 =?iso-8859-1?Q?UEumIIiPIsaiH3tDxZbpcISY57/WYqNiOiPuXPqNNz0IemASDdt8H1ZTGN?=
 =?iso-8859-1?Q?4R7ecU/LQQzFHsRdSe2uctBCxfV9pM3Ia+FciXjWAUVTpr0pS4ueujRIbW?=
 =?iso-8859-1?Q?EdFE2luof9zBKBxaO/gZDirno/sRLKjGhd6vDk/wxmosWnPnoHpA6ExzZV?=
 =?iso-8859-1?Q?QZLOm0oH5Bq5KmFuJVPfD4PTqDbDVTU4kdqTwmEqzPFRJKl+TjcJQjb2DY?=
 =?iso-8859-1?Q?FL/5YyKsA9TmIFhZoXNUucPEXampzSMW/kSra9AnmRluwHlU2uvk/Dryih?=
 =?iso-8859-1?Q?KpZoKi0X7oviGlQQP9X2LSm6YuCD6p5nLdVd2atAZ7tkesd7xRt87f3pOo?=
 =?iso-8859-1?Q?JAxHwU0eS9XvDqvCg6gmHj/EdH/fVfkg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V/nvbB3DwvyvmxSjhCSRnNAH7qF8f3YGLYLezUAQJyycJwitZM/S4nNRxa?=
 =?iso-8859-1?Q?D0s2kjrq7Kf6/ttcW5VOmgngeYtRiF8lq/zJAy4pggX02mvnnBovSQycP7?=
 =?iso-8859-1?Q?1QYxjaT7NI8J0u20Onagc4GiPCq7MXq6as+iOoR1+RhNzTg3j85MX9IaLB?=
 =?iso-8859-1?Q?8d09jdoDS49mBFKey8UN2XlfKH1XM+/xZK6yt52gU/2sUV/4ms3v4uPl21?=
 =?iso-8859-1?Q?MCqXBW6/UNOIQdbmk9DzcRH04NncJ9/rqgB+KiOqyEtSIXgpkimEdt5PxO?=
 =?iso-8859-1?Q?ZA6KpqHgBe/xtFR54jNDGWaCNMXVtyC5dOhp3Mca+S4Me2mlzsK2MRQ5IR?=
 =?iso-8859-1?Q?o0/1YS+m3hxSSKyKvPjZe8CDSpot+9IiQMLjwVtDXTByTxTE2dsg/e3WBJ?=
 =?iso-8859-1?Q?KnIHVYDyUnM7JP9WTaPrD14gPprtQSze5/1sX23OPm6Dyy8YmfGZsZdFUB?=
 =?iso-8859-1?Q?bPuFgVqaAX83e1V8Hf3ehX9tqeuNrsNjYF1iVQfypX5Rl+bBdP06yxeCww?=
 =?iso-8859-1?Q?XgBnxGDnb05zgsmONZujJWVR5PMvPqY95fsH3b+8T+j/lyMh/sfbpnmJ72?=
 =?iso-8859-1?Q?5McyS5AzBG2M8yo+PVcpc/LQa7/xIIA9cX1kuCDD0JRh/9yvH+Yk2vdbmp?=
 =?iso-8859-1?Q?HLyBL1bnxAKP6qBHJmD3osfASVFqasjG9ZrZ0LAwit6Le/EkiBYn12fQ6l?=
 =?iso-8859-1?Q?I0T206mYYS5mzwVbOT2Um4y6Rg3JJ+8eZ4hriIqz9VTyYv3qiULOG70V16?=
 =?iso-8859-1?Q?Ljt81H382f0KZixhqY2gKiwtMnfXGKO6w5i8SW349J6CxoQmaH9l/5Zr27?=
 =?iso-8859-1?Q?6iIKhEn8XGaFD81IMwr8fDxUNheGEULHMubkeU/G3NP+4MUO0+pLyeqDZf?=
 =?iso-8859-1?Q?iPcyIl+aR1KSnOPyyRiO2kUEUvAqO3K5K0isrAWlWmET7LAdU/IgrAHhpn?=
 =?iso-8859-1?Q?M1GQjkH+oXm4Y98uTyFbdUrtItryeBlIcKCvZljTYacPmdfCTjXOPs6oun?=
 =?iso-8859-1?Q?rSnC0i9iyEMkbnPxtIIbsasRrJL2EfgJJ+RjswWzB+FjvtymI7Gz4BWRqB?=
 =?iso-8859-1?Q?CYg+ZjAfz3UNbwO/RIf2cVOjItLndA/0UHsN4KMUowEfHMqD9f9ih0u84e?=
 =?iso-8859-1?Q?Kto2IYtO8473B3TbS/zBU0Y5frgLixkFdAMns91jAB11spfzn++tmbyiXX?=
 =?iso-8859-1?Q?Y2wGoPM+yzUeV8K+G9zEU4tV+XqIQewJ5Qc0tO6hHjQ7GaClOiU8MJ/fYl?=
 =?iso-8859-1?Q?3oEOUlKZ6EcXyauuVHfveHhO/X/7tITMmMNg/iTYs54/M8yDtdbwS4UiVX?=
 =?iso-8859-1?Q?tJL8oWEANoqyIyK14J9tz/ijIhZ+5dLzY94Xf69gjpuZveGq3hnUuxwy/S?=
 =?iso-8859-1?Q?r9kZ0/6CyDSv3EyCNDpCi7H9Km0rVv74hr2+ZziEtkNlAaYidk+CX3HCKR?=
 =?iso-8859-1?Q?tPE6q/PEKOzW/wYAFH1nY/eko1bWClQI0S2aju/Y9oSVyqSM31Er0LHViF?=
 =?iso-8859-1?Q?+WJ8068N5+nDzni7pCxzxCzEV0762TsbVXEHzl9sF3LX2xAuGWcsMu15Gt?=
 =?iso-8859-1?Q?BT1Z6osyTaa6GCS3H0iwkwuJvqY4w9unH3kjn32MgKl/Thd/fLigRHBnKT?=
 =?iso-8859-1?Q?uE0HWZyB7dBZlXFj/JsqPz2uNFtlr2glZK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31f94fa-5972-413c-f03d-08dc69db0c63
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 12:34:30.6149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Go2QNwNm4Vw3Mh3E2dWK+vL/auS97vqd5XxU0uMdyqf/P6T9RZ7rXknTSrzXPkMNcjL2zTm3LpkbOkP8aO58vUCiOML6lK42ecow97EhezQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4735
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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



>-----Original Message-----
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: Re: [PATCH v3 11/19] backends/iommufd: Implement
>HostIOMMUDeviceClass::check_cap() handler
>
>On 4/30/24 12:06, Duan, Zhenzhong wrote:
>>
>>
>>> -----Original Message-----
>>> From: C=E9dric Le Goater <clg@redhat.com>
>>> Subject: Re: [PATCH v3 11/19] backends/iommufd: Implement
>>> HostIOMMUDeviceClass::check_cap() handler
>>>
>>> On 4/29/24 08:50, Zhenzhong Duan wrote:
>>>> Suggested-by: C=E9dric Le Goater <clg@redhat.com>
>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> ---
>>>>    backends/iommufd.c | 18 ++++++++++++++++++
>>>>    1 file changed, 18 insertions(+)
>>>>
>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>> index d61209788a..28faec528e 100644
>>>> --- a/backends/iommufd.c
>>>> +++ b/backends/iommufd.c
>>>> @@ -233,6 +233,23 @@ int
>>> iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>devid,
>>>>        return ret;
>>>>    }
>>>>
>>>> +static int hiod_iommufd_check_cap(HostIOMMUDevice *hiod, int cap,
>>> Error **errp)
>>>> +{
>>>> +    switch (cap) {
>>>> +    case HOST_IOMMU_DEVICE_CAP_IOMMUFD:
>>>> +        return 1;
>>>
>>> I don't understand this value.
>>
>> 1 means this host iommu device is attached to IOMMUFD backend,
>> or else 0 if attached to legacy backend.
>
>Hmm, this looks hacky to me and it is not used anywhere in the patchset.
>Let's reconsider when there is actually a use for it. Until then, please
>drop. My feeling is that a new HostIOMMUDeviceClass handler/attributed
>should be introduced instead.

Got it, will drop it in this series.

Is "return 1" directly the concern on your side? If yes, what about adding =
a new
element be_type which can be initialized in realize(), like below:

--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -28,6 +28,9 @@
  * @fs1gp: first stage(a.k.a, Stage-1) 1GB huge page support.
  */
 typedef struct HostIOMMUDeviceCaps {
+#define HOST_IOMMU_DEVICE_CAP_BACKEND_LEGACY        0
+#define HOST_IOMMU_DEVICE_CAP_BACKEND_IOMMUFD       1
+    uint32_t be_type;
     enum iommu_hw_info_type type;
     uint8_t aw_bits;
     bool nesting;
@@ -91,7 +94,7 @@ struct HostIOMMUDeviceClass {
 /*
  * Host IOMMU device capability list.
  */
-#define HOST_IOMMU_DEVICE_CAP_IOMMUFD       0
+#define HOST_IOMMU_DEVICE_CAP_BACKEND_TYPE  0
 #define HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE    1
 #define HOST_IOMMU_DEVICE_CAP_AW_BITS       2
 #define HOST_IOMMU_DEVICE_CAP_NESTING       3

This looks a bit simpler than adding another handler.
Or you have other concern?

Thanks
Zhenzhong=20

>
>
>Thanks,
>
>C.
>
>
>
>> Strictly speaking, HOST_IOMMU_DEVICE_CAP_IOMMUFD is not a
>> hardware capability, I'm trying to put all(sw/hw) in CAPs checking
>> framework just like KVM<->qemu CAPs does.
>>
>> Thanks
>> Zhenzhong
>>
>>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>>> +    default:
>>>> +        return host_iommu_device_check_cap_common(hiod, cap, errp);
>>>> +    }
>>>> +}
>>>> +
>>>> +static void hiod_iommufd_class_init(ObjectClass *oc, void *data)
>>>> +{
>>>> +    HostIOMMUDeviceClass *hioc =3D HOST_IOMMU_DEVICE_CLASS(oc);
>>>> +
>>>> +    hioc->check_cap =3D hiod_iommufd_check_cap;
>>>> +};
>>>> +
>>>>    static const TypeInfo types[] =3D {
>>>>        {
>>>>            .name =3D TYPE_IOMMUFD_BACKEND,
>>>> @@ -251,6 +268,7 @@ static const TypeInfo types[] =3D {
>>>>            .parent =3D TYPE_HOST_IOMMU_DEVICE,
>>>>            .instance_size =3D sizeof(HostIOMMUDeviceIOMMUFD),
>>>>            .class_size =3D sizeof(HostIOMMUDeviceIOMMUFDClass),
>>>> +        .class_init =3D hiod_iommufd_class_init,
>>>>            .abstract =3D true,
>>>>        }
>>>>    };
>>


