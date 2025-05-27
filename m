Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59066C5B542
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 21:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK1x0-000839-6c; Tue, 27 May 2025 17:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1uK1wz-00082q-1E
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:35:09 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1uK1ww-0004v8-7s
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748381706; x=1779917706;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0KAK1BjpfftqrrzeQQd8jPlen8GI5mTuglnHwAte4io=;
 b=LYTbC5Ejca2LqCkxjV63G3VDQO3VYtgdJtLP6FXEZAApYUEtCL8uqbWc
 +8YloPkMPlhXetXA+SFY1bVYcCdob0GtcRDcZVKMX6ltpXHD23l8W9cLe
 HOncn2Td8975CY1XwA8yn1Xu2uHWh3CmicKYqogzSYXQxOw9PUbAxK6LI
 wNeKdv30UAqfU37OUbh/fVj2Yy5ImPCRUfNPjD+1+B5IGxAAKQx/9UxpH
 MDiRnGCmvZ9mVeo4KqzGANjESkNlPN4rNxWzHUEBmAtSFquBxE0u2roDY
 yTI8gR1aw+twJTDMVwLz2bnXQNzx5x88XvC+n5Fl+ReWc8Q9LvYjxAjJT Q==;
X-CSE-ConnectionGUID: lMkQlBeXT52vEKz4lGEpfA==
X-CSE-MsgGUID: /7uP0+7OSuaruiVPmyyvdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="67806175"
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="67806175"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 14:34:59 -0700
X-CSE-ConnectionGUID: ogafYzl7RYOMP2qARUpZpQ==
X-CSE-MsgGUID: HjSKxlM3RJyGp6S7wqcmOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,319,1739865600"; d="scan'208";a="143010654"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 14:34:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 14:34:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 14:34:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.45)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 14:34:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2eOiSHDsKuYCqj/f260iJvGVVWJVqJ3LeRBePrPmDYhMjMS1zaNL0KfBeC/0Shs1cxJamKhHPJfBqNX5YnBLoorJTb1BPQjwbXx3HJMLa9ZRaLhqNlK131uH3tA6Y6BKkP1EJvEWpPYwprAUwITR/Bwwk/ziGLtCH/bSv/WztS09/Cmhflsmq1aBYA+TMi92WYs+gMEW0KNUKewNa3PFdlfrvVjMvQCHMVggdBWo5xiIcwE9XLQl5viZ48WWTwbfmAGf++TmxjLiLuR86NgbPq7lMlnV4l26yfhjZEAV6W4F/HhrNKoVxA7PJRGPGjydekyBB/zsRUtqdCK6pd1zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KAK1BjpfftqrrzeQQd8jPlen8GI5mTuglnHwAte4io=;
 b=rwNlu/uCZpFbkDRPt/2eCSPft0nJ1+0wXeKR1IaG+qCKCbtGzI7PzondXkrkDXRRhJAfs3LfwNKm45F4OP5kcqsv1F1VtBrw6BYfDzXo4I1ywd/kP/+CPDp0uso5QvfXYRKyd+BRCKs8LtXYjJ8DKFHuGZsSvnHBQ4o7uw3XlsP4QcF2c8LYcodyNhpAT3NACs7sPmFXuyB0xbB0IxH4VUMI/FiTz3SFwKL1xwLXu8mqpAenlAwv96ePjDJVnflmJD13clyAftuzbxYFCCMitS+3QBRzCGm6BOtO9prIjze00zCjL5DManOMpbx//MIyqndZLH6+q/1f7bRcm/Vehg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SJ5PPFD56E32CC2.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::859) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 27 May
 2025 21:34:51 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%7]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 21:34:51 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: hikalium <hikalium@hikalium.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Subject: RE: Some regression due to "ui/gtk: Fix mouse/motion event scaling
 issue with GTK display backend"
Thread-Topic: Some regression due to "ui/gtk: Fix mouse/motion event scaling
 issue with GTK display backend"
Thread-Index: AduHr3IQUyMyDh5wS+uW6ITUR0kANACxaDOAAOTJTcAQUa/JkA==
Date: Tue, 27 May 2025 21:34:51 +0000
Message-ID: <PH8PR11MB6879099BFBA582C913B6EA4DFA64A@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <PH8PR11MB6879500CDBB703E22EC3D6F0FAC32@PH8PR11MB6879.namprd11.prod.outlook.com>
 <CAB7+XXqH9efN-bG4mAt51jM7ucnH4QcdRHhDnsNjWz8s9A=mqw@mail.gmail.com>
 <PH8PR11MB68796F0A7BE7BE3926CF95BDFACB2@PH8PR11MB6879.namprd11.prod.outlook.com>
In-Reply-To: <PH8PR11MB68796F0A7BE7BE3926CF95BDFACB2@PH8PR11MB6879.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|SJ5PPFD56E32CC2:EE_
x-ms-office365-filtering-correlation-id: 24819e53-4007-444b-e844-08dd9d66502c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cTlzNzZPUDV3L1lKdmRybGxuSXV3dk9LMzJZWDZJaXJ0V0xGUGNoSlAwZFho?=
 =?utf-8?B?dmliL1ZGWWtpemF4VFNvMTVCM0YxNFdtSGNkTndhTUk5NDlSQmNPaVJxT3p2?=
 =?utf-8?B?dGkrb3c0a2lQZzRveTZMTlJkelBrVytvSVd1MkFBOCtObEtQNGx5US9raEI5?=
 =?utf-8?B?aXpEa1AyVm9vRHNhMm84MzZvWXp0MGRRdFFYNG9ITlFKY3dZdzF6Sm1kcyts?=
 =?utf-8?B?cDFJSzhwRmlwZ2Zha1pObUlTTDBqMWU3N2JSOWhxVTR2aTh5eG9jSkdLeWY3?=
 =?utf-8?B?TnF5aUpLQi9MbUFKYkdMTUxoeXFnWisrM2lyQXpWMFR0UUs4REF4cTlUdHVP?=
 =?utf-8?B?ZDB2VS8wbFpFbXRRNkVqNkZjWFVaeUVhOTNCYWNKbW1WdDNKd0hFZzBaUzdD?=
 =?utf-8?B?cENaUmVsSkM3OVVSTDJqb0tjSWV2ellIZU16UGl0K0VpQW1RNzA1NWk0cTZW?=
 =?utf-8?B?SjF1MFArR1hocitIOFY4dDNHeUZoTWM4cDFGc3c3eXhKZFdYa3lRMWRpbVlS?=
 =?utf-8?B?KzVkZDZHSjllcm85dWpaSE9tdE9yc2dxWVVQbW50eWRZRWcyQ2pwTlNsbFdJ?=
 =?utf-8?B?VW1lVzFEMkREUnRUaExzd2d2SGhyYUxRWnhnK1g5ekxoRzFYRmQ2YVh4TmMz?=
 =?utf-8?B?VHFlekMvbVViYitaUk96ZEo1N29CeXZCUnNQWXM0QUQ2MkpnczB1bXBCamhO?=
 =?utf-8?B?aDltZmhad3ZLbHNqWEFueXpiQnpRc2QyMkFsTVA3U2lDR3hJaGtpU2VTekNn?=
 =?utf-8?B?TEl2b2VNYkgwSWhCZThUdmwwTk1MWWhLaUkrN1RhZlF5VUVGR3YydG9JSkZR?=
 =?utf-8?B?Mk5yNU85T0YyOExTWUdIcE9IVVNNTlYybmpqTDY3RC96ZnhWYThWRHpKNnFR?=
 =?utf-8?B?Zy9weURuT3NEWjdZMzR5MU9qS0VtbktFaHl0UVhkSHR1NzBzS3k4dS8zSCtM?=
 =?utf-8?B?anZRVEhSeG5LeHJZc3lyN3B1L0IzVFd4YjVWeDZpWU9TNEdJVUhZR2RyTEZK?=
 =?utf-8?B?OVpGWklIK2VZZ29BTG1ieW5FaUpqMk5EOTdjU0thMm90bEMwOWFmVkFweTNI?=
 =?utf-8?B?bWFIK2xFRkIxVzRhZWJXdGNySkdHbDArVEVxVEdzUFF5QU52dGFPc090K2ht?=
 =?utf-8?B?WVU4bDExWkpOVnhiWUYwRkpuV2NxTGJWMW1MOHhMSWxubWhwZGdiVFlWNE56?=
 =?utf-8?B?bSt3YkxvUXhPeUZvWlBRWndMZWdzYnlpVWFvUHE0bHltSXB6YUNTbmlsYk5x?=
 =?utf-8?B?RWh1R0ZyaXJNV1dZN1phdG5mR1hsSTVuajhUc3RIeUdWR0JXQXlmSENJNWM4?=
 =?utf-8?B?M09ha1UyTE5BN1dDRDlzcXF0M2ppZTJNNGphemRUMUVVa1k1Z1pmNEM2bXg5?=
 =?utf-8?B?SFJuVnJWUjRXbml2U2tmZndMVG1XNDIxOVNHaE5qSFp5VUg3c1JBN2Z4cUwv?=
 =?utf-8?B?akN4OExXSTk5eExYdEw1MXNoOWQ0UWZ2OFlaU0Y2UkxZdE9Qc0lLYkJrKzd6?=
 =?utf-8?B?bTd1YXNxR3k1NFVZR3IwbExnOTlBU1NYQ3VpVTN0ZHVRR0NadzZHNFpRaDRy?=
 =?utf-8?B?UFRTQ2t1eHpJM2NUQVRxWWF4UFFjZW9MalNMbFJEQ1QxVDB1ZjJiNU1KWE5D?=
 =?utf-8?B?cUxtWUlNMHA0d3ZXNVdxeVB2ck5wK1RnSk9pSTE2c0tzNC9nUzdXWGxHWnh5?=
 =?utf-8?B?cnRpcnpoUFlSWWhSSGlET2FudWFxdWhYMFBZUGxFbDBwOE1Eay9CUm9uY3pM?=
 =?utf-8?B?N0JwR25xdXFTbTdrbTNWdk45S0RrMDR1YXVNbGx3S2pvbHE0Z3V4ZkZNNWN6?=
 =?utf-8?B?V3FZcVNvTjR3QTJJOEZxeUdSVFg1Uy9pbFE3RmNISlBaWFpSeG1OOFNKOCs3?=
 =?utf-8?B?OE1PRVVhU25kQlFtK1phcGRWTUx1K0t6YWRQblZPN3lCY2VzbkV1ZDQxWWk2?=
 =?utf-8?Q?ibbz8DnRDew=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVoxMmZtQmJWcm41L2pYb2dHeWFzZ2VNOFJqcXh6WkZSYXoxbkYzL1diTDlO?=
 =?utf-8?B?elY5RU0vbWVESER3WUNKYjFrVk11OXRmM1Rmd25xRlNQckVVTytzYytPY21D?=
 =?utf-8?B?a0FkRGJDY1JQSEV3RFp2bG9SWU5rdlczVzlPUVpEYTZDL2V2YkdNSDFNbzZP?=
 =?utf-8?B?eUw4c1NENTBrdGVSdG1PZENoOTlUckRKTUR6akZWcy9nU0l2YWFaSEFBeW1E?=
 =?utf-8?B?SDZyVE1kcHhSaWtMVnJjdHlrcnMrbUlJSEU4RHJxYlhReEhBVWtTL0JJaGRs?=
 =?utf-8?B?aFB4ZkJWUVRxMURpVG9ZRXV5Y0xUUkh6a3BMeldkSW9rZllwaC9YNGRZU3lR?=
 =?utf-8?B?ajhVNFVTNHpJcEZaZWhYU3REdksrdkt6bEZYUDhkdzVjRkpzSWxCcUF4bkFN?=
 =?utf-8?B?TElNcXFoQ28xWHNMejlIc2VIMm9CZlNtZERzN1JJMFJURjcyYWlUZFQ4Zlhx?=
 =?utf-8?B?Q3ZTY0c4MFNPU1RUUFU0QStvdCs2MW55NjFTY0pjaUt1MVpzSWRqQlppdEx0?=
 =?utf-8?B?ak95aXhXeTE2Vm4vRkFraHlaSWoyZTRLdm40L1IzeXZKSUFFTlhiSzV1bHRC?=
 =?utf-8?B?c1F2TzRFRTF2Umd2L09tNHJjUjYxK1pQM2hWZktSbXhLUGNrNHZVb3dLUi95?=
 =?utf-8?B?Rm5wbWZOV21uMkhHQk0zeG5NK3dRK0RXa0ZJWU95bXlCM3JGcUJNcXFZUEVj?=
 =?utf-8?B?RXpCY0g2WFpGaTZZWGZGclVEVFYvWjJseFc4ZDJuZmJqY3RWVGF3N0xzSzRI?=
 =?utf-8?B?ZjFyaFhuRW1LZHpDRnp4L1FhenVBRjJiUVJlc2dWaXdpSUFhOHpIZklUVm5I?=
 =?utf-8?B?dFRaaDdQMnhBSkx4RFNUVWxkclNVZ0hRRHFhUGlxZ0Y5SFAxY3JmQklaVGti?=
 =?utf-8?B?cUFtUlEvWUJOWlgrSzFSWmVEWmdYZzNYcEU0Yk0xbzJqWGs4aTBxNmw2NGRm?=
 =?utf-8?B?eWNMYWZjNjhrTElkRCs2RVZHY2dRaHhJYklGOWdpdDg5U3BBSUJaYVVtb1gr?=
 =?utf-8?B?NGJuOTJ6ZWdITmFSL1h4ZE91cmhNc2tra0lFRDhKYlRzZFpTaEliRkdUZTFO?=
 =?utf-8?B?eHl0MXRiSWsvQVpzNW56RmhiNEtSbE04eVVBZG9BVFFRZW80UjhDbVJtVHBC?=
 =?utf-8?B?M0N4bUNidGFJKzJIZXgzbE1RdDFyL2doY1ZWemFObGZkYWVGTzNaRVozY2hO?=
 =?utf-8?B?RVR3TGJqMUF4YUxzbWRCR2R6dHVid3Nka2tITDRDa05xVzlEU0ZnOFd3YmF4?=
 =?utf-8?B?RUtTN2xpSkJJSjY1T1lIQzlpd28vM2o5bUNHKzl2bXRaNVQxNk4yb1h2V0ly?=
 =?utf-8?B?dDZrZnBob1FGajZTbzRnTTJmbW9VMjI1YjJjQ2lLUkZNNmtNbElGTEhFVXAr?=
 =?utf-8?B?Ris5ZUZMbXRDVURWV3BuK0FSNmkyTHZ1MTUrcE13ekt6WEx6dyszVXhKL1Aw?=
 =?utf-8?B?RWppcmpVclVjSEM4cUROd3A3TWdsMFV5ZDlKTlR0TWNRVXRIM1VKc2xmSENT?=
 =?utf-8?B?STY4ejhtZVA0YWppWm10bVhYS2NIQkFQVzVQazlsTnozWXRwbkNERGVQSjkw?=
 =?utf-8?B?TW5Pbk02TU9hZEU3NVg5U05vVGJjQkxEem5raHlxVHR2NEI2TEhDaVF2RkEw?=
 =?utf-8?B?bmM0bHpFREt3ZTJpSCtDUUY0dktUMlpGWTQyQkVPUFZjdzdERk83YUl4alNi?=
 =?utf-8?B?bkovUFdhNStzcDRqOTZKb05zT09MTWcvRFRETjBaMDRkdUN6QTFFSTZ3M3Ba?=
 =?utf-8?B?R2pENXprUmU3NDdjMnhDc2tuNmtSeEQ0NFlOMEZyRmZvSy9BbE93bFhkMDZR?=
 =?utf-8?B?czIydXEvZThXM29UTldORVRvc1JGdjgxYXR4R29FTlhIVUVrMnlYVlo0QkFV?=
 =?utf-8?B?TzRyVTJWWWQ2ckNOVUwwY2RGMzRIUXhCNFhMTjdLb3V1cTFwU2Vzd2lyRHkz?=
 =?utf-8?B?eWlhQ2o2cW9xZGhTOEtCdm41Z1p2QW5EaVhYTm42TVJXN1hSSmRuMHJyZlZX?=
 =?utf-8?B?K0FidkgzME5vK2RERDM2M2pNTXdkdXJQOUszenJwQnY4R0xMYXhadjYwc3VT?=
 =?utf-8?B?YzJaSkNlYXZEckpPUUhUd2N3RXJ2aHlzQVdKLzY2b2VmQ0k4WGQwTXZjWElJ?=
 =?utf-8?Q?vc16BxUXky5DliSC4C2DDfK9n?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24819e53-4007-444b-e844-08dd9d66502c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 21:34:51.3481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZ4fAAl02EDRmzYvHT3OdHhvs87xsPdy/yrqcT7uwhZXOBmTx5Mq5VoZ8Y56p8rmucdvLvoaUqtRCe5cL6tUJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD56E32CC2
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
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

SGkgSGlrYWxpdW0sDQoNCkkgYW0gd29uZGVyaW5nIGlmIHlvdSBoYWQgYSBjaGFuY2UgdG8gdGFr
ZSBhIGxvb2sgYXQgdGhpcyAtIERQSSB1cHNjYWxpbmcgY2FzZT8NCg0KPiBTdWJqZWN0OiBSRTog
U29tZSByZWdyZXNzaW9uIGR1ZSB0byAidWkvZ3RrOiBGaXggbW91c2UvbW90aW9uIGV2ZW50IHNj
YWxpbmcNCj4gaXNzdWUgd2l0aCBHVEsgZGlzcGxheSBiYWNrZW5kIg0KPiANCj4gSGkgSGlrYWxp
dW0sDQo+IA0KPiBPbmUgZWFzeSB3YXkgdG8gb2JzZXJ2ZSB0aGUgcHJvYmxlbSBpcyB0byB0cnkg
dG8gYm9vdCB1YnVudHUgaW1hZ2UNCj4gKGh0dHBzOi8vdWJ1bnR1LmNvbS9kb3dubG9hZC9kZXNr
dG9wKQ0KPiBmcm9tIHVidW50dSBtYWNoaW5lIChlLmcuIHVidW50dSAyNC4wNCBMVFMgaG9zdCku
DQo+IA0KPiBUaGUgY29tbWFuZCB5b3UgY2FuIHVzZSBpcw0KPiANCj4gcWVtdS1zeXN0ZW0teDg2
XzY0IC1ub2RlZmF1bHRzIC1tIDIwNDggLWVuYWJsZS1rdm0gLWNwdSBob3N0IC1zbXANCj4gY29y
ZXM9NCx0aHJlYWRzPTIsc29ja2V0cz0xIC1jZHJvbSAgdWJ1bnR1LTI0LjA0LjItZGVza3RvcC1h
bWQ2NC5pc28gLQ0KPiBkZXZpY2UgZTEwMDAsbmV0ZGV2PW5ldDAsbWFjPURFOkFEOkJFOkVGOkJG
OkZBIC1uZXRkZXYNCj4gdXNlcixpZD1uZXQwLGhvc3Rmd2Q9dGNwOjoxMTExLToyMiAtZGV2aWNl
IHZpcnRpby12Z2EgLWRpc3BsYXkgZ3RrLGdsPW9uIC0NCj4gb2JqZWN0IG1lbW9yeS1iYWNrZW5k
LW1lbWZkLGlkPW1lbTEsc2l6ZT00MDk2TSAtbWFjaGluZSBtZW1vcnktDQo+IGJhY2tlbmQ9bWVt
MQ0KPiANCj4gT25jZSBib290cyB1cCwgeW91IGNhbiBjaG9vc2UgdHJ5IG9yIGluc3RhbGwgaXQg
ZnJvbSBncnViIG1lbnUuIFRoZW4gbWFrZQ0KPiBzdXJlIHRoZSBtb3VzZSBpcyBjdXJzb3IgaXMg
cG9pbnRpbmcgdG8gdGhlIHJpZ2h0IHNwb3Qgb24gdGhlIGd1ZXN0IGRlc2t0b3ANCj4gd2l0aCAx
MDAlIERQSSBzZXR0aW5nIG9uIHRoZSBob3N0ICh1YnVudHUgc2V0dGluZyAtPiBkaXNwbGF5KS4g
VGhlbiBjaGFuZ2UNCj4gdGhlIERQSSB0byAyMDAlIHRoZW4gY2hlY2sgaWYgdGhlIG1vdXNlIGN1
cnNvciBpcyBwb2ludGluZyB0byB0aGUgcmlnaHQgc3BvdA0KPiAoZS5nLiBtb3VzZSByaWdodCBj
bGljayBhbmQgY2hlY2sgd2hldGhlciBtZW51IGlzIHBvcHBpbmcgdXAgb24gdGhlDQo+IGV4cGVj
dGVkIGxvY2F0aW9uKS4NCj4gDQo+IEZvciBzb21lIHJlYXNvbiwgY3VycmVudCBtYXN0ZXIgYnJh
bmNoIGhhcyBzb21lIGlzc3VlIHdpdGggdGhpcyBzY2FsaW5nLA0KPiB3aGljaCBtYWtlcyB0aGUg
Z3Vlc3QgdXNlcyBvbmx5IDEvNCBvZiB0aGUgcWVtdSB3aW5kb3cgc28geW91IG5lZWQgdG8gdXNl
DQo+IHNsaWdodGx5IG9sZGVyIGNvZGUgYmFzZSBsaWtlIHY5LjEuMCAoZ2l0IGNoZWNrb3V0IHY5
LjEuMCkuDQo+IA0KPiBzb21lIHZpZGVvIHRoYXQgc2hvd3MgdGhlIHdyb25nIGJlaGF2aW9yDQo+
IGh0dHBzOi8vc2hhcmUuaWNsb3VkLmNvbS9waG90b3MvMGEycnM1cVU3YlF5YjhxcGtVYmtsZDRR
QQ0KPiANCj4gVGhhbmtzLA0KPiBEVw0KPiANCj4gU3ViamVjdDogUmU6IFNvbWUgcmVncmVzc2lv
biBkdWUgdG8gInVpL2d0azogRml4IG1vdXNlL21vdGlvbiBldmVudCBzY2FsaW5nDQo+IGlzc3Vl
IHdpdGggR1RLIGRpc3BsYXkgYmFja2VuZCINCj4gDQo+IEhpIEtpbSwNCj4gDQo+IFRoYW5rcyBm
b3IgdGhlIHJlcG9ydCENCj4gQ291bGQgeW91IGdpdmUgbWUgZGV0YWlsZWQgc3RlcHMgdG8gcmVw
cm9kdWNlIHRoZSBpc3N1ZSBzbyB0aGF0IHdlIGNhbiB3b3JrDQo+IG9uIGEgcHJvcGVyIGZpeD8N
Cj4gDQo+IFRoYW5rIHlvdSwNCj4gLS0NCj4gaGlrYWxpdW0NCj4gDQo+IA0KPiAyMDI15bm0Muac
iDI25pelKOawtCkgMzowMyBLaW0sIERvbmd3b24gPG1haWx0bzpkb25nd29uLmtpbUBpbnRlbC5j
b20+Og0KPiBIaSBoaWthbGl1bSwNCj4gDQo+IFRoaXMgY29tbWl0IGFjdHVhbGx5IGJyZWFrcyBv
bmUgb2Ygb3VyIHVzZSBjYXNlcyB3aXRoIFVidW50dSBob3N0IHdoZW4gdGhlDQo+IGRpc3BsYXkg
c2NhbGluZyBmYWN0b3IgaXMgc2V0IHRvIDIwMCUuIEl0IHNlZW1zIGxpa2UgZ3RrX3dpZGdldF9n
ZXRfc2NhbGVfZmFjdG9yDQo+IGlzIG9ubHkgd2F5IHRvIGdldCB0aGF0IERQSSBzY2FsaW5nIGZh
Y3RvciBhbmQgd2l0aG91dCB0aGlzLCBtb3VzZSBtb3ZlbWVudA0KPiBvbiB0aGUgZ3Vlc3Qgd291
bGRuJ3QgYmUgYWJsZSB0byBnbyBhY3Jvc3MgY2VydGFpbiBib3VuZGFyeSBhcyB0aGUNCj4gY29v
cmRpbmF0ZSB3aWxsIGJlIGhhbHZlZCAoaW4gY2FzZSBEUEkgc2NhbGluZyBmYWN0b3IgaXMgMjAw
JSkuDQo+IA0KPiBjb21taXQgMzdlOTE0MTUwMThkYjM2NTZiNDZjZGVhOGY5ZTRkNDdiM2ZmMTMw
ZA0KPiBBdXRob3I6IGhpa2FsaXVtIDxtYWlsdG86aGlrYWxpdW1AaGlrYWxpdW0uY29tPg0KPiBE
YXRlOsKgIMKgU3VuIE1heSAxMiAyMDoxNDozNSAyMDI0ICswOTAwDQo+IA0KPiDCoCDCoCB1aS9n
dGs6IEZpeCBtb3VzZS9tb3Rpb24gZXZlbnQgc2NhbGluZyBpc3N1ZSB3aXRoIEdUSyBkaXNwbGF5
IGJhY2tlbmQNCg==

