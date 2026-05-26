Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD84CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRnT3-0002tp-9t; Tue, 26 May 2026 04:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wRnT2-0002t6-4E
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:48:52 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wRnSz-0007uB-Nx
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779785329; x=1811321329;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JUr2e0Rwo7pLQ3ETWesMcJ8MB0Wr4shkGNg2UmrA5yw=;
 b=n2Ik5UwQMOuTzsB622ZqDZ5jkbT1O5z8/px/DnLcxGUdBia8tfRByA7M
 xtLYW034jl/OUuRfpobf3XmynWKwx7L0IkhzCWYMsmIjNOpSEdGsCkmsp
 4oLSG50fnJSU3HRrdtNWoM1UpLe0qHEFXbjK2cHAoael8SOrQNEup9rVB
 kbDxbrBU57J+ryfzmUx3B/WnNsY3bqqGuNNLuTS+f34NufDmgn2LL2tI5
 Q4+bMq3Alm95Qu5k7nBrSeLDXhTCEwRKwiUL5t21GtuMGQQ0YTSlfArpl
 ooSoPRxGokPZGLcc/dWcsdaU/tuq1KMxJjIrxSI2nXiwFnDHFeEF1Gc9l A==;
X-CSE-ConnectionGUID: 0BfQw6VwQMiYsQ0DxYETvA==
X-CSE-MsgGUID: crTVaHVwRi6Vazv7uigYlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="106051503"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="106051503"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 01:48:44 -0700
X-CSE-ConnectionGUID: 8vR9OH1qQom2qQy0noEsrg==
X-CSE-MsgGUID: oWPij+EfTyG0QKfspizbjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; d="scan'208";a="239257418"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 01:48:43 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 01:48:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 01:48:42 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.19)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 01:48:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQg/Kug8/+XtGFiA3ebJCbSjSoq3nbA9W/zrrGOZvy1HjVhg/FJfi+rN323NH79sfnRd5lYPEQsd1X2YnbVKlIaSQqROYW2QexJjrkmjfDUuIK2I6l4Fk3Evjfh0VVbRUyaCoGL4ikl1cC/jxWGjllNQ0QuAl9Y0jxLSJNZQlQaAgN5iRbyvhP3hqPlQWe43v6yPH9lfv4tQbpDog2ZIa7lOrY72J8MogL4fJWEy008RG6swxWDPwVO3aQpfQm3lK1Lc4JptscaD767OHze5s1QeXXgyulACLUamXLHwcy4l51ZQ0WKEfFhe2B4tvQd30xMNpy77HLHyAdjAhdwMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUr2e0Rwo7pLQ3ETWesMcJ8MB0Wr4shkGNg2UmrA5yw=;
 b=SlCyEh5wLx0iWAaNisy5d5ZhVsUwmhxU7Lt+bipOcVGDjHvvsgunRWufaaJUm7OHZaQqNnJ+3bU3qzihzeMepa/Ne76cWLTULoW64qzvP+kZdfEr4rYdi64LWKb+vpeA2pzuXe+WpdJTI+ILuL29sApmUxhF3Wl4FP7xRRaGptAYnck40Bk5wFB6oijsW25OCQ2p1k8If//6d50KEbGzMXR95xMmJwSOMe4AEa60bpRCtKEYpKXbhGq835gmZyAXgQdKbY98o+WaIXN/I3+N1emagVV+Agk03lJKJqMiXYFzS/5ek+p2sza7w3NU7AVJXg4WAz5mSFukD41KNsppAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 08:48:37 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 08:48:37 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Qiang, Chenyi" <chenyi.qiang@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>, Steve Sistare <steven.sistare@oracle.com>, "Chen, Farrah"
 <farrah.chen@intel.com>
Subject: RE: [PATCH] vfio/container: Restrict dma_map_file() to shared RAM
Thread-Topic: [PATCH] vfio/container: Restrict dma_map_file() to shared RAM
Thread-Index: AQHc51R9QaxMMIgCgUK6cdv+zRft/rYekyZQgAALygCAAWTDwA==
Date: Tue, 26 May 2026 08:48:37 +0000
Message-ID: <IA3PR11MB9136A7F81365676AD698AD12920B2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260519055756.70575-1-chenyi.qiang@intel.com>
 <IA3PR11MB9136AD783C648B7ABF5E65E4920A2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <951500a3-be6b-4f14-b5de-03802117f62e@intel.com>
In-Reply-To: <951500a3-be6b-4f14-b5de-03802117f62e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB4824:EE_
x-ms-office365-filtering-correlation-id: 8942025d-9326-4b70-215b-08debb03940c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|4143699003|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: HuB5dXSkVUYqOP5yZV7ELEjjC7GtL3Be9XdLMskREYy2Rk3npxz69U5y6m5lNXVX+dR0zEHM4RB9ZBrr1ouL5fMqxTL6VFmCe25IMKCSjpQvvzKx8ajmBO5fx/WBj36+DuNDmz/OEdAwd88R/w2LnQN/lCXxbAg9vBZ764SVwnHM+ZxTVqCCHYQwGRwy5k79zanRJIPT7dKFBbHoZCAXule87mJnzLHnQrO5lJRfwo+VhXMtrzT2lzLxt985UfdlvlugqkPBYI60IuYvYwQQY25P0N7ickMJTlqE5OxJJW1mV+XKu98V8uZdKRNY4A+A/Y/aFUNFUzQmUdF+TR36yuKY9RbIEp466HnlGh+ZwXshoXg/RuPus09gUV2iBnfSMq7FiRLhgZnbNs1VTll1eamO7/6qdAIy2ISCcUZWHuRfPXswyiptIGuMe/KPJlkjVBZ/w080I7k4cM9lROznr8236QB99U05AMuSvk2QY5oGucIB0rlan15kzwOaOV+ZI2nB/bnaojH2pim+yu+QGaIbpdaYSbjnShnNUQ4zvpwNLWipJnuwRjUOcvrSq3HGmpph15Vf6Vy6suROP+Q42J5QQxX2ADAtlOPnTvfUyQcEdlS+wjz8LW0EJBvqiBSfMTOwPqDR1hnHmd09nEABXJ9mUNNd0pv5Bfkqgba/Wc+fKdSezilVGKbv1B10JU5gqPndWSZImuNy2HNa2NtiseEIZ4w3OZUp515Xo2Z8+OYRx+uCMRvdIByfHQttbmAN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(4143699003)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWQ5RTQ2QlUyN2taR0ErNUNkMVpiemVEL3Uxd010T2JVQjRMek5XcUIwU01K?=
 =?utf-8?B?ajBjKytBNjlPRHAzdThJUlRvQ1pmZmRSUlpON0NqOU9JMEV5dG85enlOeU1s?=
 =?utf-8?B?eHdyTGpNY2RWaGJLOE1ubkZSZWI5QytSMkczTUlibkY2eityNjZYVDYyS0xN?=
 =?utf-8?B?YThKWGo3Yjd2VDlEQWR3UUU4NnJnVkZiQ3FUSzAzcHB2UHVBemhBRlZrQ1I5?=
 =?utf-8?B?Mm55bitSdkZRUkRIZ1pMeWwxa0NsSGtBaWFqRjJxNFZKVVpMaVN6UE5kNlRQ?=
 =?utf-8?B?NDJxNC9YcWtFMWVod1JaaVVXZEM4eFVIUUtkTGRoRklwYXIyTWRQSGhGQVBI?=
 =?utf-8?B?N21qWmhqeXc2VWZqU0pxWGkxTnduVUVuaFNyWlMzaHZWSVdsM3h4b0J3UGtR?=
 =?utf-8?B?STkvV1NHVFU4ZE1wbGRVWWpudkdycWhubDRHTnNvRXpvanpkRVBPNWpYK2Vm?=
 =?utf-8?B?MU1TZjJ6dXFvNUMrbEhJWlFobStQM0haZXFuc05SZFZETWJhQXcwT1o2SnpD?=
 =?utf-8?B?NTY5UDhHSUo3ekl6WjJnNzV1VEtBOTBwZUJZL0hkTzc1aUo0ZEdpR25TN21L?=
 =?utf-8?B?WkszTEZzZVgvVHQ1eDMrUlljSnoxeGtWZ1RHOCtnaTdUQUlKYWc2MnNqd0hU?=
 =?utf-8?B?Z3l5SEdlb0Vmb0QvQm9uN0F1UUd6YmRQL1UxOTJsQmZ1QkpzQ2t2bGZaenl6?=
 =?utf-8?B?VXlDUjNybkpkZDFYU3o1VXQ0OEJ2d0xrRmpwNk9zNUlhSmpnNVJJUnFhbEV2?=
 =?utf-8?B?K0JWM0p5ZHZnTDMvSC9pSlEyS3Vrc05CYkpmWENzdy9wWXFUL01vWHVYZHBB?=
 =?utf-8?B?SUNPYjZYQkg5QlB1UDRHOE5KN0JmVEgwM3AyaVdhM25FTkxZZ3NETXgzRkxo?=
 =?utf-8?B?WlFqZEg4V3V6cGtyMVRYYnE1bVZJT1BoaEgrSHNCalhDSXM5Q0N6eTR6RjBZ?=
 =?utf-8?B?OGg4MU1nRWhyOGViY2V1eHZmdzAxRWI1QUJrS2liTmFzYXBiOG9SYjNsR005?=
 =?utf-8?B?QXJSWndkajUydHlrK214dGl1YUlwc2grSnVFYnpMQmg1aGFLS2tTK2ZDZitC?=
 =?utf-8?B?M1BEZThrUGE2OUNLczA1WmRJQjc2TngwU1BMa0w5KytvelRUN0MvWE1SUlBP?=
 =?utf-8?B?NjBBWjRnV3UzRXAxdnZNeUZDZlJKcjBDV1ZpVmpWcWsvWVNWb01uOVBVbDdN?=
 =?utf-8?B?aXQ5aDQ2Mm1oc0Vqa2VTa0R0ME1qajhuZVhEMHRocGxha2N5cTZlNC9hR3ln?=
 =?utf-8?B?bkFIQmJDOGtTM2NOYTlEUmR2b2VBcWNMUkE2UXBWaGtrMXZlK2hUdkdqK3RP?=
 =?utf-8?B?ZVRsTFNjR3pUZDNHMnJZMTBqTXBJdkRyWXdOUHlXbmhpVi9wbnc0NW1FZmFE?=
 =?utf-8?B?c2toendwcHl0VS9FcE14Mk53bTNQeWUxMXNDaFNtZU92U3BDV0tkTlFoSXpj?=
 =?utf-8?B?VFE4N2ZTSmt4bm9WTVIwTFd0MWhVU2Z2OVlPWG4rcE9sZ3VqS0cwa1JQdlRN?=
 =?utf-8?B?dXdlbU9MdHF1Nloyci92WFFZNFdtOG9rUjVETnp0Qlo3WlV3TkZLU3dJNEpj?=
 =?utf-8?B?RmtRa1BpcEZnQThmaUdiKzNHTlZONDlXeUl1SkwrNnRTeWRGZzBlcHROSW9z?=
 =?utf-8?B?a3BkaFNhc3lobDZLbDYzZlhGMytWbHAxUDdJbDBaRmdIa25PT291NHY0VC9o?=
 =?utf-8?B?azBzamdOVkRTOEhBekQvSVhHcllJbDRpcjlGYVBiSkNaR3ErWWZBWTk2ZDIw?=
 =?utf-8?B?amFlODQyRE4rSXR1anc2QXQ0OXk1WXJObXFVUDZmSGsveVV2bTkrdHZXUkE3?=
 =?utf-8?B?UjRlUmJib3pWU0RQQU1pUklpb25vcUM1VUNtYU13STFzUytBQkJWRTUzdG1C?=
 =?utf-8?B?OWFZRzZhYW5hM3NpYzF0cnhQS2cwcWovT3EwcXA2b1U0L1grZTRvT2JZUXU1?=
 =?utf-8?B?RTZvQ2hNK1ZiUEtlenhOczk5c2R0TjV2UEhRQUFBTVd1cy9QOVJNdXhHR2pE?=
 =?utf-8?B?UFNLa3Z0Nnp5TWJYc05OQmFUOXY4ZEtlSzR4S0dQUHg2c28yVVBWNzM1Q3BN?=
 =?utf-8?B?N3FoUERWYW83MHVNYllUa2dER1Ntbm4vNUU3K2JqODRFRlUxOTJzdFNsQlBK?=
 =?utf-8?B?SW12K1JZS0c0OEJCM0lVZi9FcjhoTmxHYUx2ZW51RTIzenpjUENlOEIyZkxU?=
 =?utf-8?B?VHZTUFRlWHpWZERMR3crOVkrdG9OS1pMVUtBTXFCa2ZuaWlzcU5DeDc1MnEr?=
 =?utf-8?B?Wjk4Wm5RTWthY2UyS2FmSjFwQ2ZhR0x1RzhsRWY1YThhcVd3alBhWmtWK0FM?=
 =?utf-8?B?NG5yNXV6V1FCZzExSmpYL2dOUlhtbWlxWGdPVGVxZU5IWHd5ejg2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LDw3mJyYfANBTvm+4pkJUhzr/NtT43ItBYX6F2vWEnXxOSsXWAmQEKw/NkTiGVyij2iRfL0gZCcfbQmIavOooYmkl/VgGe6xtm6GMS90eRBY5dx5bK02UJipjDsLFOnRFmMo3lsZXW4b0aRJ7GD1wyDQwlnehnsNdzI7JHIs8jGfiRUkiTMW2GSsZVqwR86kg/+AmSOhAJRctfu7hVVlAbJSK0sjjNFMhsdIQ+3E0nTYD8MkSmTOjdyWh3h2nz0NqU02T3ApP2iQRMw7u+eTywJcKYOgY30BmHQxSwZEiMufX8jJNpyvr8Ld1NkkkvhOzCymmwXaNVwcdwj2HSKt9Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8942025d-9326-4b70-215b-08debb03940c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 08:48:37.6104 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S8i497GNVoGJwe0M8Z1Gw+vGJRaTBFL76OIz/3CrO2aGi8tglfq0wj0XjGnfGSlcANR+63XmbjpgJlmIZcYTRQJjKGBKcd+Tz6FhEnMwCw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFFpYW5nLCBDaGVueWkgPGNo
ZW55aS5xaWFuZ0BpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gdmZpby9jb250YWlu
ZXI6IFJlc3RyaWN0IGRtYV9tYXBfZmlsZSgpIHRvIHNoYXJlZCBSQU0NCj4NCj4NCj4NCj5PbiA1
LzI1LzIwMjYgNjozMSBQTSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogUWlhbmcsIENoZW55aSA8Y2hl
bnlpLnFpYW5nQGludGVsLmNvbT4NCj4+PiBTdWJqZWN0OiBbUEFUQ0hdIHZmaW8vY29udGFpbmVy
OiBSZXN0cmljdCBkbWFfbWFwX2ZpbGUoKSB0byBzaGFyZWQgUkFNDQo+Pj4NCj4+PiB2ZmlvX2Nv
bnRhaW5lcl9kbWFfbWFwKCkgdXNlcyBkbWFfbWFwX2ZpbGUoKSB3aGVuZXZlciBhIFJBTUJsb2Nr
IGhhcyBhbg0KPj4+IGZkIGFuZCB0aGUgVkZJTyBJT01NVSBiYWNrZW5kIHN1cHBvcnRzIGZpbGUt
YmFzZWQgRE1BIG1hcHBpbmcuIFRoYXQgaXMNCj4+PiBub3QgY29ycmVjdCBmb3IgcHJpdmF0ZSBm
aWxlLWJhY2tlZCBSQU0uDQo+Pj4NCj4+PiBkbWFfbWFwX2ZpbGUoKSByZXNvbHZlcyBQRk5zIGZy
b20gdGhlIGJhY2tpbmcgZmlsZSwgYnV0IHByaXZhdGUNCj4+PiBtYXBwaW5ncyBjYW4gcnVuIG9u
IGRpZmZlcmVudCBQRk5zIHRoYW4gdGhlIGZpbGUgaXRzZWxmLiBBcyBhIHJlc3VsdCwNCj4+PiB1
c2luZyBkbWFfbWFwX2ZpbGUoKSBvbiBhIHByaXZhdGUgUkFNQmxvY2sgY2FuIHByb2dyYW0gRE1B
IGFnYWluc3QgcGFnZXMNCj4+PiB0aGF0IGRvIG5vdCBiYWNrIFFFTVUncyBhY3R1YWwgZ3Vlc3Qg
bWVtb3J5Lg0KPj4+DQo+Pj4gVGhpcyB3YXMgb2JzZXJ2ZWQgd2l0aCBodWdldGxiZnMtYmFja2Vk
IGd1ZXN0IG1lbW9yeSBhbmQgaW9tbXVmZC9WRklPOg0KPj4+IHNoYXJlPW9uIHdvcmtzLCB3aGls
ZSBzaGFyZT1vZmYgY2FuIGZhdWx0IGJlY2F1c2UgdGhlIGZpbGUtYmFja2VkIFBGTnMNCj4+PiBj
YW4gZGl2ZXJnZSBmcm9tIHRoZSBQRk5zIGJhY2tpbmcgUUVNVSdzIHByaXZhdGUgbWFwcGluZy4N
Cj4+DQo+PiBHb29kIGZpbmRpbmcsIGRpZCB5b3Ugc2VlIHNhbWUgaXNzdWUgd2l0aCBjb21tb24g
ZmlsZShub3QgaHVnZXRsYmZzIGZpbGUpIGJhY2tlZA0KPnByaXZhdGUgbWFwcGluZz8NCj4NCj5Z
ZXMsIEkgYWxzbyB0cmllZCB3aXRoICItb2JqZWN0IG1lbW9yeS1iYWNrZW5kLQ0KPm1lbWZkLGlk
PW1lbTEsc2l6ZT0yRyxzaGFyZT1vZmYiLCBhbmQgaXQgY2FuIGFsc28gYmUgcmVwcm9kdWNlZC4N
Cg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+
DQo=

