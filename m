Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EA6C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6XZG-0001QE-QX; Tue, 15 Sep 2026 14:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x6XZ5-0001Pg-Gz
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 14:07:34 -0400
Received: from mgamail.intel.com ([192.198.163.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x6XYx-0006SB-MB
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 14:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789495643; x=1821031643;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CitGWG8uj+pizLpOCi+t5YVp5Qdmu7FlObE/BnPWh2w=;
 b=OMpUX3oLe5pi2dsnvfSKKuClz7vn7YsekySUpBfOFQ96+LKuSpe809bE
 iIQDtRsIsHxS4w1hshIAHJL7NvM+N2P3jIf4GIIVBnBiQ9ii79JYOi3bO
 f6fWU4gFAfS2Mhdho+3/HlYf+tQxEEWoKjIT7JlGlrckcdjhlSBuSXoQ7
 XPEAJ2Hj+0St4xByM/4+ydtT8FenVl9RI5p/1B0fxQxGQQQuBix6CtSuv
 /kaVZdHTagz8hTJUdBYAXBI3b0ZpBaK+JPfaYJpISJMRklv/shy6ObvI9
 nfa6poDcGvMWmkkw+KPjC9f4BRnA9Cw9Recw8zx5msIZgpTa490LqgwbR w==;
X-CSE-ConnectionGUID: 4yfIlTmQTVe8WE6oQhAEGA==
X-CSE-MsgGUID: 3UfEc9G2Rkqi2t+mFGzv7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="378839"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="378839"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:07:20 -0700
X-CSE-ConnectionGUID: mExB10pYT3iuOYbNnAkQLw==
X-CSE-MsgGUID: y/3N3wG3TyG5vQj4E1376g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="269824709"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:07:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 11:07:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 11:07:19 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 11:07:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVc9jhpj6/hbp0yyRATBVjWjEM+inw8c5e4Pc8OGcAVdn7lqCiMOFcqS9agjdhe84nt6F5Sjc9gQcgTlm8yX6+8wsMHECgX/aa0kmBGqFSReiSwoWb2yib5wqBNN6qydCQBheWchQik1Dwq4Mairl6af5NiZojxgMUPUv3iWJ4dUvEP7NY6MyApWGO0stURtqrtvIRA/BjTuRCo47VuHjpKAyIK+4BZ/GNFYxD1bmzdJGOy8BT/4N8oW3vC22B3qK44n/KDyzGRqaRW49U8gLtjfW12gw2Q/SDeeseQB+L3vW8cEPL3vFhiyBmtSo1OMt2vUi37L5ISw40EBHGeSqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CitGWG8uj+pizLpOCi+t5YVp5Qdmu7FlObE/BnPWh2w=;
 b=S3K5LJWrbIfaPq2fU40qYzZqi7oLDDfM4V7Fe2oawUCzsRMK8ABBPORKQ2Zpey3rQtgCOeR6nLctoZtYs0AV9PrS7YFEw9dx3Vq5VgMAR1YNszicvW+2Eerv0Gzm2PMjbjl5TgZLOfJmqEGD93SRfqn3NE8M84jCqbFZprgfDaYqDGac+r4rsRXH/6weMczpOPwpFU/XWHHmDZhfQoz7pJDkl4gYBdtLQneIpFSsIjihOTSVyURQNRNM6wARWt05/73jllq8fEVSHIkiglO72uRgR/+0uxe9i7zHf2QzbLJtUtFKy2Gw2gG1h/iOSClMeXwW3cK7MffRW6gAfxWdKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by LVUPR11MB9859.namprd11.prod.outlook.com (2603:10b6:408:38b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 18:07:15 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 18:07:14 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/2] ui/gtk: enable fullscreen hotkey for detached windows
Thread-Topic: [PATCH 1/2] ui/gtk: enable fullscreen hotkey for detached windows
Thread-Index: AQHdRHnvzsJbzokrtkeP2oOPsGyTuLbPZ00AgACGF3A=
Date: Tue, 15 Sep 2026 18:07:14 +0000
Message-ID: <PH0PR11MB511272535F8EF5246481CB83FABA2@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <20260804090847.18871-1-dongwon.kim@intel.com>
 <CAJ+F1CJd6P7YPpCMx4Ntv6KAD=hv8yHzPHDq8=c2ZEcwHnjN2A@mail.gmail.com>
In-Reply-To: <CAJ+F1CJd6P7YPpCMx4Ntv6KAD=hv8yHzPHDq8=c2ZEcwHnjN2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|LVUPR11MB9859:EE_
x-ms-office365-filtering-correlation-id: 151a50e5-196d-40ff-fba2-08df13542c30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|4143699003|6133799003|56012099006|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: TWl7oG1N6WSpTkDwG6mxUPL01sdaCC6k4+rcRtmuMFY+eErK3XP6XulF384gp8qYZpAeowP7xsySARtDwekJ4kOIohoALfDgrrrS+cgZ5TFAanlR5fPF6tAmqsiTCetQaQigs8UTrTCT+gjwj4oI6ABYQVMHL2K9TDxox6ZN8TJw7lI3vPKNgnPraZy4RGt/T7Y4ZPlYg78/vqMwa6xFhy3HWIPTqji80adiFLofX0p1C7lWicCswW1SQ2NwajdEjTxCOzNQJF9Q7D4KUitiWFDsUPWhgYsrTceoQ6Zd8pmjZUj7G/6KEKUD9DKmXi+e9x1FPmkrC+IuQRgtJyx9qklVv0QsByDEJ518T/vO5gxs3B/xojA3GOdRGGxbw4rF3hAl0g78eOY9X3MaC9HZ4rsTLRl98CBEl0+iJBpLHKcBvqVUQ1gMIY609xhzoQIKKekbvw4qQ4Mz5j4EiX+Y1BynCUZO74AyRD7fLHvP+3t1Zyyzjxsf51tfx5AFzHIvvrHPX/HgYPkSH37ySzKIeVzltnC/HJca2YtredXdJ0rowWV5vdYLoPiZZ/iAODUZAWQvM3w0b76PF0lR6rHoEZDX3Iw3LsJnwCdfWWaSjo0ftPgp6p/X0ANueZpf6rzrtqOxK4giclC17/o5Mp+g/fg2/OVekjynohulcym5ikAEaqQOHa0ngHBJ/hftdChptNi8gvCniXzAhh0oe5D0GUBB7bnlsKzs3hL6E/032ow=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5112.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(4143699003)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHE2OFZPdUlVSlJsbnExYld6b2hXSlpzZVMzcEVER2tlMzR0RlBrMHI1aHhw?=
 =?utf-8?B?cnVGQlpmRHRCOHBETkVLcTJRelZJdTlBZGNIMS91THRudFJxUXlMa0hORFgy?=
 =?utf-8?B?RnhHa1hmTEdqZE1jT1hCck9KV0ZqUXFoTE9pc3JPYTErVXVUSU5Pb1BKaXgx?=
 =?utf-8?B?L1o5aUZCOGs2L3o1MWc3Z3R0Y2psODhqNzRYMlppeTZpZ3BNNVh4WWhFNk9D?=
 =?utf-8?B?dTdycVVqcVJoc1ZUbkh5SnBtK2ZtQi9yejdQditHcUhRUWE0OGNRdUVqZTdy?=
 =?utf-8?B?UUFrMGFpYVI2blFTSGh2MzBCRVlkc3FkRXpNUG1DRFE1VjA5WlRneC94MXRy?=
 =?utf-8?B?SWxUV3hZdm9pcDlpS2psL3BZU0R6UVBQcmRaekxzN0srNDM5K2pGU1NBaXNV?=
 =?utf-8?B?bU80TnRjTUZQZzhkYlp5dXJkMElxT29xVlVKREtSQWw1WDFaSENFSS9pRTVL?=
 =?utf-8?B?Uk15bWRxdVhiSld2OU5yM1Q4V0gvanZ2TGZQU2J3Y3BWd1RuZ2luZG5NU0NP?=
 =?utf-8?B?SE1RZUN0MXl3MkF6WFhTeTkzT3M1aURRN2pXbVBGM1dvYThnT25jbzVGYjZW?=
 =?utf-8?B?Z1N2blZsL0hXWC8zdHRXb3ArMllsa0RjQ2FTL1R6dXI0SHNSbUwwcDh6elRv?=
 =?utf-8?B?WnlKeEF0UFpZOEpHYnpUUTFBRThTRzQwbDVadlc2UnRjeEZTSFdrOXdBdnVz?=
 =?utf-8?B?MVI2Q1pVZVFlRVdmN0RMbGxSYTJtbFlYWnBLY2R2MkVkNXhoTEJMeksxNGtV?=
 =?utf-8?B?MDVJMHJKWi95UkN4WW9hNmRIcUZ1RTcvVWh4MmdPRlQ5SkV3c2NsUUJwTHlK?=
 =?utf-8?B?Qk1nejNET3pIdkxrTDc0UlplaThWTDFGenNBWHhOMlQ0VFVaa2dtVU1rMHJ6?=
 =?utf-8?B?QlVJeDhxM3g4ajRkbVRTYkhrTEwveVZBd2UxcTJYM3RXTllMdy9UWC82VG85?=
 =?utf-8?B?Z1RNV2UwUEJ5eTRaK2FFV0NHVnFBcUVxWTFZeDY2STNCVVJiY0lYQlY2TXFX?=
 =?utf-8?B?ZTF2NUR3NUVZQWc4TnJaMGpqWVh0akxOWGNHd0Mzd2w0elJ3TmFWWG45TDVJ?=
 =?utf-8?B?bWZTR1NuWlFab0pjcnJoTHJ1bE1hS2xiUE5KV21GaTByMGNQSkhpRk92SUVa?=
 =?utf-8?B?dDdEc21lakdXbndjT1ZZTFhJWkRtcUh4TGJKVUpuYVNPS0Q2RENVc2pPNnEy?=
 =?utf-8?B?SVMwL2txUWE4d0ZqNDh4WkxOYm1XbFNiQm1mNy9YQkZXRGxkdlFnQ243SFBU?=
 =?utf-8?B?T0ViSzR3OXdhV0xrVk01Nkp2d0JjKzRsTENYZ2RyV21oSk15bHhsL0FDaTNP?=
 =?utf-8?B?MnBtNmY1UUtnUkxzUHc2YTdWMHVoQ0pqYVczYTRwT3lkd054a2V4c2tQa2p1?=
 =?utf-8?B?d2pzSlRod0lnTDhYMlY1TVpXbnhTTXphamcrRFA1VWNwMXFRRUpRUnNSaHQ1?=
 =?utf-8?B?dkIySlorSStiMmRzaHdwRXJ2UURHRTBWcXBUZVdTdVg5VzI5TDBlTG9XNnJ4?=
 =?utf-8?B?NW0xRWRRQW1Xa0lBSHpIM1R2c1EyQ0JqZVBVOXJoQU5TNHpHUlNxMnJSRHBs?=
 =?utf-8?B?UkV1NDFvSXNJUkprWGZQOVV3YURETHp2WkZ3KzF2SlNiTTJmeXhjd3BpZkhV?=
 =?utf-8?B?WnFWMSszREFTMlJ3ekhYWjhoeGpMZTlNd0VHbU0vQVkvOVd6TmgxSm1rTzFo?=
 =?utf-8?B?dFVIWFU1Nm9HTjJiOUtqM1EvN2IvdWRGV3Z5ZUMzMmhtZmErVjQrVlZGUWpP?=
 =?utf-8?B?UkNlS0dZcHRsQjFZN3QrZURPVE5QWGhZaFBkZ3pHbWFTZFdsQmpndHdxaVVY?=
 =?utf-8?B?NVFqc2tYbjhTYzJCaFNPNW4vSk40OWVmQkRRRWtOK0wyblk3QnFyRHRGdE5P?=
 =?utf-8?B?MlBQN2xEcS9IYUNEeVRMbmtqYXdWandRVWhDOXlvQ3BmU0JuTUtncUx5VDBU?=
 =?utf-8?B?UGtZTTU3Y1ViaVZ2L1RYQ0pYV2ZpYk5iRWtNVHhKZVhTeWl0Uk8wTW01enRE?=
 =?utf-8?B?b0NVQkF6dWZrNmdhOURzS08vQllnZkJiWnNmZlV0bzN4M0Fhekk0blhmR0Er?=
 =?utf-8?B?U0IzdnQ0TmM5dm9PUWVtbE5UMWdINFZUMHdYSDJOVHBhbVdTQ0lIZWJTdEIx?=
 =?utf-8?B?aERjWnB6Rk9CTUl6RHJxZUxCejRUT1lkV0VTQW9LRWdXUlpvUEJwdEdnOWtw?=
 =?utf-8?B?ZXFjVFNJK1JHZGVjN3JrSjdUUERUM1UyZmhOWUVmWlNQSHgrWGRJQmpMZWxk?=
 =?utf-8?B?a2lHclJKNzJqTjh5M3VYWDMxQlFnSnFyZE4wSUFOaGN4c1A4UDFGcFlZUEgv?=
 =?utf-8?Q?gMiB/wrne/52Up4joY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4F/P41b4pFD38ZoCEsXtQ9Hi4IELYQ0ER/A6NiDDsVHzY+JjDcUyrl2iMZBQaw4VDJnZZVFnriUXIEpYunp4yT+8+9gq9tiCz6bRHpJ9tx/9Chz0Tkmi02vG387eKRc6h/Xm6AWIhmCKCZ8/qq535jnDAqEJtfjrOAlbFi4EEGNI2Fo/rRAkZP7JFPnDWl0F97UqDrYy/a9NhzhjFHMSUOWd06p/tF7ncm1eYmhxBqB1KyD568VAoFxKMis3KQK9190zBCiUG+y9gZcUwfEe/FBjn8x++dLWzr+y+oVuqEjsLtiM+b3XXrmxfG3RkFh3vTidshE2OzcYEfvI9853Xg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151a50e5-196d-40ff-fba2-08df13542c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 18:07:14.9053 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Mu9N254xMjYmqG+2ngUcSqAbjZC63WLgd3fjatTdQyj9QRLEK29O865yEUJM9Z5Hr9YBmgG3HINdZr9GlOSqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9859
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.4; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIHVpL2d0azogZW5h
YmxlIGZ1bGxzY3JlZW4gaG90a2V5IGZvciBkZXRhY2hlZA0KPiB3aW5kb3dzDQo+IA0KPiBIaQ0K
PiANCj4gT24gTW9uLCBTZXAgMTQsIDIwMjYgYXQgMTA6NTDigK9QTSA8ZG9uZ3dvbi5raW1AaW50
ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBp
bnRlbC5jb20+DQo+ID4NCj4gPiBDdXJyZW50bHksIHRoZSBmdWxsc2NyZWVuIHRvZ2dsZSBob3Rr
ZXkgKEN0cmwrQWx0K2YgYnkgZGVmYXVsdCkgb25seQ0KPiA+IGZ1bmN0aW9ucyBmb3IgdGhlIG1h
aW4gUUVNVSB3aW5kb3cuIFdoZW4gYSBWaXJ0dWFsIENvbnNvbGUgKFZDKSBpcw0KPiA+IGRldGFj
aGVkIGludG8gaXRzIG93biBzZXBhcmF0ZSB3aW5kb3cgKHVudGFiaWZpZWQpLCBpdCBsb3NlcyB0
aGlzDQo+ID4gY2FwYWJpbGl0eS4NCj4gPg0KPiA+IEltcGxlbWVudCBhIHRvZ2dsZSBoZWxwZXIs
IGdkX3dpbl9mdWxsc2NyZWVuLCBhbmQgY29ubmVjdCBpdCB0byB0aGUNCj4gPiAnZicgYWNjZWxl
cmF0b3Igd2hlbiBhIGRldGFjaGVkIHdpbmRvdyBpcyBjcmVhdGVkIGluIGdkX21lbnVfdW50YWJp
ZnkuDQo+ID4gVGhpcyBhbGxvd3MgaW5kaXZpZHVhbCBkZXRhY2hlZCB3aW5kb3dzIHRvIGJlIHRv
Z2dsZWQgZnVsbHNjcmVlbg0KPiA+IGluZGVwZW5kZW50bHkuDQo+ID4NCj4gPiBDYzogTWFyYy1B
bmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogRG9uZ3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAg
dWkvZ3RrLmMgfCA0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3VpL2d0ay5jIGIvdWkvZ3RrLmMNCj4gPiBpbmRleCBh
NzIzYzgyMTVkLi4zYzk3MjBhMzMwIDEwMDY0NA0KPiA+IC0tLSBhL3VpL2d0ay5jDQo+ID4gKysr
IGIvdWkvZ3RrLmMNCj4gPiBAQCAtMTU1Niw2ICsxNTU2LDQyIEBAIHN0YXRpYyBnYm9vbGVhbiBn
ZF93aW5fZ3JhYih2b2lkICpvcGFxdWUpDQo+ID4gICAgICByZXR1cm4gVFJVRTsNCj4gPiAgfQ0K
PiA+DQo+ID4gK3N0YXRpYyB2b2lkIGdkX3dpbl9mdWxsc2NyZWVuKHZvaWQgKm9wYXF1ZSkgew0K
PiA+ICsgICAgVmlydHVhbENvbnNvbGUgKnZjID0gb3BhcXVlOw0KPiA+ICsgICAgR3RrRGlzcGxh
eVN0YXRlICpzID0gdmMtPnM7DQo+ID4gKyAgICBHZGtXaW5kb3cgKndpbmRvdzsNCj4gPiArICAg
IEdka1dpbmRvd1N0YXRlIHN0YXRlOw0KPiA+ICsNCj4gPiArICAgIGlmICghdmMtPndpbmRvdyB8
fCAhZ3RrX3dpZGdldF9nZXRfcmVhbGl6ZWQodmMtPndpbmRvdykpIHsNCj4gPiArICAgICAgICBy
ZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgd2luZG93ID0gZ3RrX3dpZGdldF9n
ZXRfd2luZG93KHZjLT53aW5kb3cpOw0KPiA+ICsgICAgaWYgKCF3aW5kb3cpIHsNCj4gPiArICAg
ICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgc3RhdGUgPSBnZGtfd2lu
ZG93X2dldF9zdGF0ZSh3aW5kb3cpOw0KPiA+ICsNCj4gPiArICAgIGlmIChzdGF0ZSAmIEdES19X
SU5ET1dfU1RBVEVfRlVMTFNDUkVFTikgew0KPiA+ICsgICAgICAgIGd0a193aW5kb3dfdW5mdWxs
c2NyZWVuKEdUS19XSU5ET1codmMtPndpbmRvdykpOw0KPiA+ICsNCj4gPiArICAgICAgICBpZiAo
dmMtPnR5cGUgPT0gR0RfVkNfR0ZYKSB7DQo+ID4gKyAgICAgICAgICAgIGlmICghcy0+ZnJlZV9z
Y2FsZSkgew0KPiA+ICsgICAgICAgICAgICAgICAgdmMtPmdmeC5zY2FsZV94ID0gMS4wOw0KPiA+
ICsgICAgICAgICAgICAgICAgdmMtPmdmeC5zY2FsZV95ID0gMS4wOw0KPiANCj4gZ2RfbWVudV9m
dWxsX3NjcmVlbiByZXN0b3JlcyBpdCB0byBnZngucHJlZmVycmVkX3NjYWxlDQoNCkkgd2lsbCBj
aGFuZ2UgdGhpcy4gVGhpcyB3YXMgYmFzZWQgb24gd2hhdCB3YXMgZG9uZSBpbiBtZW51X2Z1bGxf
c2NyZWVuIGEgd2hpbGUgYWdvLg0KSSBkaWRuJ3Qgbm90aWNlIGl0IHdhcyBjaGFuZ2VkIHRoZXJl
LiBJbiBhZGRpdGlvbiB0byB0aGF0LCBJIHdpbGwgdGFrZSBvdXQgY2hlY2sgb24gZnJlZV9zY2Fs
ZQ0KYXMgd2VsbC4gDQoNCj4gDQo+ID4gKyAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAg
Z2RfdXBkYXRlX3dpbmRvd3NpemUodmMpOw0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0gZWxz
ZSB7DQo+ID4gKyAgICAgICAgaWYgKHZjLT50eXBlID09IEdEX1ZDX0dGWCkgew0KPiA+ICsgICAg
ICAgICAgICBndGtfd2lkZ2V0X3NldF9zaXplX3JlcXVlc3QodmMtPmdmeC5kcmF3aW5nX2FyZWEs
IC0xLCAtMSk7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgICAgIGd0a193aW5kb3dfZnVsbHNj
cmVlbihHVEtfV0lORE9XKHZjLT53aW5kb3cpKTsNCj4gPiArICAgIH0NCj4gPiArfQ0KPiANCj4g
Rm9yIGNvbnNpc3RlbmN5IHdpdGggZ2RfbWVudV9mdWxsX3NjcmVlbigpIGl0IHNob3VsZCBjYWxs
IGdkX3VwZGF0ZV9jdXJzb3INCg0KWWVzDQoNCj4gDQo+ID4gKw0KPiA+ICBzdGF0aWMgdm9pZCBn
ZF9tZW51X3VudGFiaWZ5KEd0a01lbnVJdGVtICppdGVtLCB2b2lkICpvcGFxdWUpICB7DQo+ID4g
ICAgICBHdGtEaXNwbGF5U3RhdGUgKnMgPSBvcGFxdWU7DQo+ID4gQEAgLTE1OTAsOSArMTYyNiwx
MyBAQCBzdGF0aWMgdm9pZCBnZF9tZW51X3VudGFiaWZ5KEd0a01lbnVJdGVtDQo+ICppdGVtLCB2
b2lkICpvcGFxdWUpDQo+ID4gICAgICAgICAgICAgIEd0a0FjY2VsR3JvdXAgKmFnID0gZ3RrX2Fj
Y2VsX2dyb3VwX25ldygpOw0KPiA+ICAgICAgICAgICAgICBndGtfd2luZG93X2FkZF9hY2NlbF9n
cm91cChHVEtfV0lORE9XKHZjLT53aW5kb3cpLCBhZyk7DQo+ID4NCj4gPiAtICAgICAgICAgICAg
R0Nsb3N1cmUgKmNiID0gZ19jY2xvc3VyZV9uZXdfc3dhcChHX0NBTExCQUNLKGdkX3dpbl9ncmFi
KSwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2
YywgTlVMTCk7DQo+ID4gLSAgICAgICAgICAgIGd0a19hY2NlbF9ncm91cF9jb25uZWN0KGFnLCBH
REtfS0VZX2csIEhPVEtFWV9NT0RJRklFUlMsIDAsDQo+IGNiKTsNCj4gPiArICAgICAgICAgICAg
R0Nsb3N1cmUgKmNiX2dyYWIgPQ0KPiBnX2NjbG9zdXJlX25ld19zd2FwKEdfQ0FMTEJBQ0soZ2Rf
d2luX2dyYWIpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdmMsIE5VTEwpOw0KPiA+ICsgICAgICAgICAgICBndGtfYWNjZWxfZ3JvdXBf
Y29ubmVjdChhZywgR0RLX0tFWV9nLCBIT1RLRVlfTU9ESUZJRVJTLA0KPiA+ICsgMCwgY2JfZ3Jh
Yik7DQo+IA0KPiBZb3UgYWxzbyBob29rIGdyYWIsIHRoaXMgc2hvdWxkIGJlIG1lbnRpb25uZWQg
aW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiANCj4gYnR3LCBpdCB3b3VsZCBiZSBuaWNlIHRvIHJl
bW92ZSB0aGUgc3RkZXJyIHByaW50ZiB0aGVyZS4uDQoNClllcywgSSB3aWxsIHJlbW92ZSBpdC4N
Cg0KPiANCj4gV2h5IG5vdCBhZGQgdGhlIHpvb20ga2V5cyB3aGlsZSBhdCBpdD8NCg0KWWVzLCB3
ZSBjYW4gZW5hYmxlIG90aGVyIGhvdGtleXMuIEkgYW0gZ29pbmcgdG8gYWRkIHpvb20gaW4vb3V0
L3Jlc2V0IGtleXMuDQpJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIGNyZWF0ZSBhIG5ldyBjb21taXQg
d2l0aCBhbGwgdGhlc2UgbWFqb3IgY2hhbmdlcyBpbmNsdWRlZA0KcmF0aGVyIHRoYW4gZ29pbmcg
d2l0aCB2Mi4NCg0KVGhhbmtzLA0KRFcNCj4gDQo+IHRoYW5rcw0KPiANCj4gPiArICAgICAgICAg
ICAgR0Nsb3N1cmUgKmNiX2Z1bGxzY3JlZW4gPSBnX2NjbG9zdXJlX25ld19zd2FwKA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHX0NBTExCQUNLKGdk
X3dpbl9mdWxsc2NyZWVuKSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdmMsIE5VTEwpOw0KPiA+ICsgICAgICAgICAgICBndGtfYWNjZWxfZ3JvdXBf
Y29ubmVjdChhZywgR0RLX0tFWV9mLCBIT1RLRVlfTU9ESUZJRVJTLA0KPiA+ICsgMCwgY2JfZnVs
bHNjcmVlbik7DQo+ID4gICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICAgZ2RfcmVidWlsZF92
Y19tZW51KHMpOw0KPiA+IC0tDQo+ID4gMi40My4wDQo+ID4NCj4gPg0KPiANCj4gDQo+IC0tDQo+
IE1hcmMtQW5kcsOpIEx1cmVhdQ0K

