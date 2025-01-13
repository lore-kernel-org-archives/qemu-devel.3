Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8979E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8ms-000252-6A; Sun, 12 Jan 2025 19:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1tX8mq-00024b-7X; Sun, 12 Jan 2025 19:58:36 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1tX8mn-0005pw-T4; Sun, 12 Jan 2025 19:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736729914; x=1768265914;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DPzPYjUonFEzGao+KlAnRelps5f0hhDFugMpkU9jsxg=;
 b=TbRqJ2hf8EivnwJt5rnGP93BKq9ztMp7TBFD5to2Da4LqHfLfUEIq/ic
 m2VQt9zFtPESC88+zWLF1VywycoZ9Ll02EXTsnF5E70Uw6W/1MHsmfP+e
 mGxRqfmTGI3bouJH7p9GYYI/pQZh1Mh8hiZjUb0c9ox1z4QpXf3kioAUE
 z2ZlyFP/zxxvv2xkHhVhdrjlpqhJZGvBqAGGx2fgJes1kDQPvGrCeigRU
 NqBoNNN9cFGro5OJxqcAxcoV++k4DAojacEQLGh6GFuqRrcF7yHd88tzD
 mfPC2JtoW8B75gfQaRH/U33InMkv3nsCBpgXcHqsQUd9imgkbK1LkQSoZ A==;
X-CSE-ConnectionGUID: uIBe9GlkTXuRSdUFfAEdjg==
X-CSE-MsgGUID: gFL526BZQ02i6F4TU4A7nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="36190202"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="36190202"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2025 16:58:28 -0800
X-CSE-ConnectionGUID: 9sfaL3CZSlSk7Leg6iHnTA==
X-CSE-MsgGUID: F4ICUyrwQt6ssAhzTQ1/HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="104111436"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Jan 2025 16:58:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 12 Jan 2025 16:58:27 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 12 Jan 2025 16:58:27 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 12 Jan 2025 16:58:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCBYvPAHnluag4FEKRegMGrBhFn0Uj8khfxqpBSOVNoKDmBk4sMDf4bmS0mn02nUtnFrioz3RvFa5rCrcdySUuZQQsOCmoc23RyhdLxoX7wzaq5cVi+w+drixcNowX2h2BKow1MZB7P2YlZGjwiCOnOSMBlxZwIwC5CVjPNGlvfDtLbtTIvLCNFokbPV/Hj3RmoF0dHvVqIjOdqoXBNuvKxqIl9k7SZkEGLadqicu8CPY7AqxSeGgoWUCIhc7iVCE1ZqmgSsgSGI6V+1rcWBgO0dU1rIEVsqpHKATtSUuaAdjNymPxBNOqKZgSC0w6Qr6P6mNmA3W/3ZephDr10WZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPzPYjUonFEzGao+KlAnRelps5f0hhDFugMpkU9jsxg=;
 b=pj3Z1A2Tq6nmWDkKYUR3sbhg57mYMowurwNgSqToM+ORj303MdsR1oVXRTnBJY2Nre2ovV1puTnbFfbuxRT/jz6Kq7ApJRvpaRrjZA6u5mcciJLt2kuhcai/rmo2FMYgmRS4y/ApIidjurbj41BZik1VY/kq6k+DNR5k2tExvS3SEs31y7HXgQS6d1a2u7xojtHPE8y938tawz1w6lt1BFsCy4iz/Z8R+E6BDAghDHe+HTVMsCuxcSTNYzrT0pKqNaCwLQKkT1exxtVzInlqcCm3e/9CS1YkrxYNweNCAssM7iT5rFjfbnGchAn4IjJy5xrz2X+nUmlYmt5oKb8WCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 00:58:18 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.8335.015; Mon, 13 Jan 2025
 00:58:17 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>, "peterx@redhat.com" <peterx@redhat.com>, 
 "farosas@suse.de" <farosas@suse.de>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zeng, Jason"
 <jason.zeng@intel.com>, "Wang, Yichen" <yichen.wang@bytedance.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: RE: [PATCH 0/3] bugfixes for migration using compression methods
Thread-Topic: [PATCH 0/3] bugfixes for migration using compression methods
Thread-Index: AQHbUS07z1swRAzZQU2VynN3qtKLwbMTRO4AgADEUqA=
Date: Mon, 13 Jan 2025 00:58:17 +0000
Message-ID: <PH7PR11MB594190850FECE93C583D9ED1A31F2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20241218091413.140396-1-yuan1.liu@intel.com>
 <d565340c-8e81-4582-a2dd-1abed5879e95@tls.msk.ru>
In-Reply-To: <d565340c-8e81-4582-a2dd-1abed5879e95@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|LV2PR11MB5976:EE_
x-ms-office365-filtering-correlation-id: 09131727-7928-45da-ed31-08dd336d5deb
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M1pqL1E4NGprdXN5NEN4eVZZU1ZIL1Q3RlJkMk84emRIckdFSzk4b3I2WGFH?=
 =?utf-8?B?SnprRWhkT2YxTVRxRHl5bzViTTQxcnRSc2F5MXpWeUU0Uk8rR1JNNi9Lek9K?=
 =?utf-8?B?WTNPci92Wi9kVjJpeVhJQUpRTUlFcmhRK3ZzWFBzeVd1OG9kZWJKZm5sbWNq?=
 =?utf-8?B?cVZ4Q0tQbWdWVHJJZ2FWekgzL0oxRElkS1VBV09MV0Y3ZExaSGx1dmNGeXdE?=
 =?utf-8?B?WGZlWU5rcFVaVDBHcXZMc09ERnR3UVlxWkErVkp4TTVvVG5xOElrYzZpV05S?=
 =?utf-8?B?anQ3REV0eDN0RnVFWm1hN2o1YjMyWHl5ZVlmVjB4N0h6UlNQUE1aMHNlVG5o?=
 =?utf-8?B?VGtleVphbm9naFhycThsS29xWUtuajU0VUNHUjlnUWRWbzNTUWdpTUhLMG5a?=
 =?utf-8?B?L2xzdnl0bzNtSUdpMDhhQ3ZzakF1RmM4RmoyZVB5MW5IZENlUXlEeFkrcFlD?=
 =?utf-8?B?bFlZRkJRaEwzdTlJc3IzUG5ReEhQY3I3Nmhtd2tWL3gvZTVmbGJQZUJwQVRy?=
 =?utf-8?B?ejdVTXc3ZDAvQXJrTnE3V1hOY1gwTlh6Y3JRSG9vaXMyVTZyYldpUEZKaU1t?=
 =?utf-8?B?OUl4RVRLTFNPSjhpOUtLaUplcGdmZ0RPOVBhZWdYRUNYZVlKOXlPSGRnUGlo?=
 =?utf-8?B?cUtIc2JFbDJGbHNFYTEweXQzcnhDZkluTzRzVlZWTUtMc05rcHlnczFpei9L?=
 =?utf-8?B?QzlpZ2U4RHd0T1BGSGd3NkN6MS9YbnpwcUhyRzdOTTZ6K2NWTXdDNTBRcnNa?=
 =?utf-8?B?Z0NZOGZjZEw4dEIxemJhSlVxeXpHRzRaUytJT3k2RDZGV0MyWmxpTVZiS3Zo?=
 =?utf-8?B?MEpob2pLOHJnWTVCTTNUbjVYWTBNeGpNbkRpMUdXSjduNG5aRG8zMkxvdThG?=
 =?utf-8?B?N1ozZDAyVlI1QitUVUltZ3hCY0t4UzVucUdXb1FhR0diTWIyV09oVS9nMEZs?=
 =?utf-8?B?ZmlxakREaE1TNEF2djZlTmRxQ1UvTytaYnVKUjlLbzBaL3NVZVFoQjNJQy9n?=
 =?utf-8?B?dHZuSno5ZWJsWjBRWlZSMkY0aGRPeHhNT082RmhONy9CU1ZvdTdzdjZQNDZm?=
 =?utf-8?B?UU82QXRqSXpiU0tPL3gvb3ZZU3Z6V3Y1YzM5Yy9JUTlEZUFDOVM1SlNPZXNo?=
 =?utf-8?B?QXBTVXFoUFpJZFZ3aHdrOTRvVUN3R21CK0hOcmNiTGNObjFIWnJWYmNQMEtx?=
 =?utf-8?B?N3A4MHBMVno3cnhQeHhEVFNGUTZWMlV0dlFkem4xQlNvWVBUYU9QK3V2cUJ6?=
 =?utf-8?B?RmMvVUdhTWJaT0lPK1Y2SWZBODhvRFd1NE10Nzg1UU5ta1o1NHRwYWFRamNk?=
 =?utf-8?B?WHFrNm5meTJxSUk5dEZ0aGZaZEZpc0E3Y3huc2JSdjVsWFZnMmlFS1Q1UktS?=
 =?utf-8?B?MVNhT2x0dEQwL3hSdDFaY3pxNjNhd2krSEdqUnhlVFFsL2g3bnFaT1BIQmRr?=
 =?utf-8?B?ZnRsOWhpM0k5UW5sSi9yWWEzZzVnVFhmR0FPdEF5YlVmNmM4VHo3TjNWT0NC?=
 =?utf-8?B?d0FPZGtGVHhkZzFoa1lBVGFuY045bzBtbncwTTM1UkNaWGJ4VkJFeWk3cDBI?=
 =?utf-8?B?ZFFmMzdpemNRcEMrTmMyKzFPMlRZb0NhTXI0NG1pNUQ0RVhDczZGSFErUmVV?=
 =?utf-8?B?QnFYclBxVHc0OUZJMHQ0ditJQlhpSkJXWEY0eE5MQWxOQldrcW1OSWh3VXRq?=
 =?utf-8?B?YVZiVWQrWEVvN0J5K1hEVUVRVDlFblJOOTFNdU84MlR0WHd6Y1VKUWxQTUJs?=
 =?utf-8?B?MUFnblZlcTg5NzhpTkszQk41TG1vaCtBRTNFdWFZY1BzaGp5VnJkT1U4elNO?=
 =?utf-8?B?ZzRQS1lPMGVFS1UvQTdKQzVnVnBNZ1ZlL0JwZzdQRzZyYlZzZk9uZkJpZks1?=
 =?utf-8?B?ejA4YlRSOURGenZtSThmWUVhTlY5aTRGU3FEUENWTmtKaVJGTjJJSWlzZlZu?=
 =?utf-8?Q?mxMu2fNqnQ53IBLdBJp6cm0S4hQUSlm7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHNSdXBIUFZmZjdLZFN5c0xsY2l2dndmNUEwMEpSc3htSTRYR1RPWnB2cENl?=
 =?utf-8?B?NGcxSHUyNVJPdVJPYmpGOGhYM1AvN2hZRkdvbmttcnpyemtPbjVqNTZURXlN?=
 =?utf-8?B?TW5paEJEd0ZiZWhwc1hFcHJ3RlM5RTgrVmdTanpjL1R0OWFVeU1LY0NFVjFZ?=
 =?utf-8?B?WGgzN3hSUFB0QkxieENzWEhrejJwY3dXWnk4WDJQdXRKbEZaMnRpRXRQMG1j?=
 =?utf-8?B?UmhYRHdZbExkTnpDU1JzZUtsd1ZnbFRHbFVySXYxRjZ5TXJZOTN5WUtrQk94?=
 =?utf-8?B?aVF3T05Xd2ZGOExld3kwai9ieWlZOFh4ekxyK2QzdldueHFrZGNzQjFwSTNr?=
 =?utf-8?B?Tk5Dc1ptWEY3QlpkNGFtYWNBa2FUSWtxUkJ2b3lnWG1YQXd5VG45OGdHOHlW?=
 =?utf-8?B?ZDVFYlYzT0x5blgrckpqcWJuREdWaU95cVdCSGYyNkJ2VWhBOUovZ3ZHdUda?=
 =?utf-8?B?blZIbktaZ0tjZHNBUENJaUc1dWxJS0p5ZjN5Y2NpNGs4eUNCcFhPd3Jla0Ev?=
 =?utf-8?B?WjB0T0RNbC9kb3A2WTFKOGZUd1c3aDFZUWtmNERiQktiWURhSkZtejdhZzM1?=
 =?utf-8?B?V1FQbENaRU9vM0pBbmFZeWlMUzJSU2F4RnBESHFkR0ZQTEE2dmt4bmpENTNi?=
 =?utf-8?B?bXlOaHJJaHpFT0I0MGNEMUhONE5mb0FhMFBmR29mL2pqbEYzUGNzMks1OW9u?=
 =?utf-8?B?WkNWUUtlVEhOdzBaV0VQTC83WjF2U0xyODJMeTBjckFJTHBTNnl0Z2pEb3c0?=
 =?utf-8?B?djVJQlhabEtMNkNvNTAwNTVBUlM4LzdMM1NlMVRrRUZYNXZzNGtuczRxTVpr?=
 =?utf-8?B?SE9zN0pHam9oMGFvZ2VrRWhMNS9idUd3Qy8ralZxbFplZi9NMUxYNm1QMXV2?=
 =?utf-8?B?SVhBWkFLNkxadVVIZ3h4a3VlS1JQS0VYdUYyd3FXRTJ4dWlZWnRYL1Y1VlJM?=
 =?utf-8?B?cjdmejd2dXhTQzNialcwZWxPa3FBZzduSHlYWXArNlFtNE9DUVNuVUY0RW5Y?=
 =?utf-8?B?K2F0RVlSSGJXT0Z2aXZiN1pkencwcVdwZmRzNktJdkxBbUUxQytvT3hlalpT?=
 =?utf-8?B?MEg2RjBRUDBwVzlQWENaWk1hdzVxZUs2MUswVjVaeVo5TnlSWFdVa25ST3ly?=
 =?utf-8?B?emhwWjBLazdVeWxUaVJadTZ6UWpVKzB3M0NFMWZaNTZ4aDRqNVR0WjUzOTZW?=
 =?utf-8?B?NnpoSDlqL3BFa1pVQWczYjE3SG5lQVFwUXB1WHh5cGtRUEJXMTlvZy9QV29a?=
 =?utf-8?B?MC9TTld2bTJGaTB5QUVDbi9JTE56R2VEODFFZllJWkJtV0VWaVovRmV4R240?=
 =?utf-8?B?RGpBWEgwaFVwYlVYWEFvUXpqaXVWcThwdnlVVThsL0c3RU9nVGVSQ2VtQncv?=
 =?utf-8?B?U2V3UVJIV0FiWDFXWUZWTTBEUzV2ZXowNkNHOEc3OXBlZTJqbCtidGh3TThS?=
 =?utf-8?B?T3FmbjVRdVpyaGxaVXdKY05iR2xXWFJsaHMvdmJsNWo3azZKMUE5bWFPUTJu?=
 =?utf-8?B?cTlxK1Urcy9Qa0FhVkFNSlNSNENBU0l0Q2pPeVcveFh5QW5DM0ZnTGp1WUJ4?=
 =?utf-8?B?alVLRVV1aWlLSnRvMHRkRnJUa1FmZ1M0RWtHZW82N1pkcXZOb0VDR1B0VHFU?=
 =?utf-8?B?TUtVV1o4VEhubU1BZU9SQjRraUFpN3BWWlhrQ1E5NWZ6ME51Y2RhTzVpTnFQ?=
 =?utf-8?B?V3NiVnMzOFc4WnU0ME9kcjJaTVpNVXZHZkZxS2xDRUgxQ21KYzB4TTFFU3dR?=
 =?utf-8?B?S2FtU04vQVd3aEdzQTdnU0h0dU5pUXFKR2JhZUhUcFkzYUVicHlJclRzb3VU?=
 =?utf-8?B?cXBrQTRsZ0R3aDJBQ1VEODdEejV3WXZmYm5QT3Vid2ZqMyt1MVR2Ny8xSlFy?=
 =?utf-8?B?cFpUTDA1VWlOWmtXdmlwMWJFa2F2NWJJMHF6SHZLRTJhRURnbmQzcm1KV0E5?=
 =?utf-8?B?RmcrYVZPdE4rWUgrRVNJcDNvaDh5QXV2bHV4YmtxbjRyTmV6REt0b0dJaFV1?=
 =?utf-8?B?QWtnMFNydU9uK0o2dS8zMkpvWXhzSW1FeFBYdW8raFhoaG90TmVuY0gyV2V3?=
 =?utf-8?B?MTVIUk16NnphaU9LWEIwdmhQYVhOWVh6MFdrNWxueWMxNWt6V0JEYjN1NHho?=
 =?utf-8?Q?7uc1i09aaDnOWgb6MXORG3tvb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09131727-7928-45da-ed31-08dd336d5deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 00:58:17.6287 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mqkEO0Z3BUMNMKj43GBewFkCY4tUaS8nW9MVndqDm0kaK1s2H06Ig1WjBrjPrFBCdKxxI/0jYpP16elnhleHXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5976
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNoYWVsIFRva2FyZXYgPG1q
dEB0bHMubXNrLnJ1Pg0KPiBTZW50OiBTdW5kYXksIEphbnVhcnkgMTIsIDIwMjUgOToxMyBQTQ0K
PiBUbzogTGl1LCBZdWFuMSA8eXVhbjEubGl1QGludGVsLmNvbT47IHBldGVyeEByZWRoYXQuY29t
OyBmYXJvc2FzQHN1c2UuZGUNCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgWmVuZywgSmFz
b24gPGphc29uLnplbmdAaW50ZWwuY29tPjsgV2FuZywNCj4gWWljaGVuIDx5aWNoZW4ud2FuZ0Bi
eXRlZGFuY2UuY29tPjsgcWVtdS1zdGFibGUgPHFlbXUtc3RhYmxlQG5vbmdudS5vcmc+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMC8zXSBidWdmaXhlcyBmb3IgbWlncmF0aW9uIHVzaW5nIGNvbXBy
ZXNzaW9uIG1ldGhvZHMNCj4gDQo+IDE4LjEyLjIwMjQgMTI6MTQsIFl1YW4gTGl1IHdyb3RlOg0K
PiA+IFRoaXMgc2V0IG9mIHBhdGNoZXMgaXMgdXNlZCB0byBmaXggdGhlIGJ1Z3Mgb2YgaW5jb3Jy
ZWN0IG1pZ3JhdGlvbg0KPiA+IG1lbW9yeSBkYXRhIHdoZW4gY29tcHJlc3Npb24gaXMgZW5hYmxl
ZC4NCj4gPg0KPiA+IFRoZSBtZXRob2QgdG8gcmVwcm9kdWNlIHRoaXMgYnVnIGlzIGFzIGZvbGxv
d3MNCj4gPiAxLiBSdW4gInN0cmVzcy1uZyAtLWNsYXNzIG1lbW9yeSAtLWFsbCAxIiBpbiB0aGUg
c291cmNlIHNpZGUsIHRoZQ0KPiA+IHN0cmVzcy1uZyB0b29sIGNvbWVzIGZyb20gaHR0cHM6Ly9n
aXRodWIuY29tL0NvbGluSWFuS2luZy9zdHJlc3MtbmcuZ2l0DQo+ID4NCj4gPiAyLiBFbmFibGUg
dGhlIG11bHRpZmQgY29tcHJlc3Npb24gbWV0aG9kcyBhbmQgc3RhcnQgbWlncmF0aW9uDQo+ID4g
ICAgIGUuZy4gbWlncmF0ZV9zZXRfcGFyYW1ldGVyIG11bHRpZmQtY29tcHJlc3Npb24gcXBsDQo+
ID4NCj4gPiAzLiBUaGUgZ3Vlc3Qga2VybmVsIHdpbGwgY3Jhc2ggYXV0b21hdGljYWxseSBvciBj
cmFzaCBhdCBzaHV0ZG93biBhZnRlcg0KPiA+ICAgICB0aGUgbWlncmF0aW9uIGlzIGNvbXBsZXRl
DQo+ID4NCj4gPiBUaGUgcm9vdCBjYXVzZSBvZiB0aGUgYnVncyBhbmQgdGhlIHNvbHV0aW9ucyBh
cmUgZGVzY3JpYmVkIGluIGRldGFpbCBpbg0KPiA+IHRoZSBwYXRjaC4NCj4gPg0KPiA+IE15IHZl
cmlmaWNhdGlvbiBtZXRob2QgYXMgZm9sbG93cw0KPiA+IDEuIFN0YXJ0IHRoZSBWTSBhbmQgcnVu
IHRoZSBzdGVzcy1uZyB0ZXN0IGNvbW1hbmQgb24gdGhlIHNvdXJjZSBzaWRlLg0KPiA+IDIuIFN0
YXJ0IHRoZSBWTSB3aXRoICItUyIgcGFyYW1ldGVyIG9uIHRoZSB0YXJnZXQgc2lkZSwgaXQgaXMN
Cj4gPiAgICAgdXNlZCB0byBwYXVzZSB0aGUgdkNQVXMgYWZ0ZXIgbWlncmF0aW9uLg0KPiA+IDMu
IEFmdGVyIHRoZSBtaWdyYXRpb24gaXMgc3VjY2Vzc2Z1bCwgdXNlIHRoZSBkdW1wLWd1ZXN0LW1l
bW9yeSBjb21tYW5kDQo+ID4gICAgIHRvIGV4cG9ydCB0aGUgbWVtb3J5IGRhdGEgb2YgdGhlIHNv
dXJjZSBhbmQgdGFyZ2V0IFZNcyByZXNwZWN0aXZlbHkuDQo+ID4gNC4gVXNlICJjbXAgLWwgc291
cmNlX21lbW9yeSB0YXJnZXRfbWVtb3J5IiB0byB2ZXJpZnkgbWVtb3J5IGRhdGEuDQo+ID4NCj4g
PiBZdWFuIExpdSAoMyk6DQo+ID4gICAgbXVsdGlmZDogYnVnZml4IGZvciBtaWdyYXRpb24gdXNp
bmcgY29tcHJlc3Npb24gbWV0aG9kcw0KPiA+ICAgIG11bHRpZmQ6IGJ1Z2ZpeCBmb3IgaW5jb3Jy
ZWN0IG1pZ3JhdGlvbiBkYXRhIHdpdGggUVBMIGNvbXByZXNzaW9uDQo+ID4gICAgbXVsdGlmZDog
YnVnZml4IGZvciBpbmNvcnJlY3QgbWlncmF0aW9uIGRhdGEgd2l0aCBxYXR6aXAgY29tcHJlc3Np
b24NCj4gDQo+IFNob3VsZCBqdXN0IHRoZSBmaXJzdCBwYXRjaCBiZSBhcHBsaWVkIHRvIHFlbXUt
c3RhYmxlIGJyYW5jaGVzLCBvciBhbGwgMz8NCj4gVGhlIGZpcnN0IG9uZSBoYXMgYmVlbiBDYydk
IHFlbXUtc3RhYmxlLCBidXQgdGhlIG90aGVyIHR3byBoYXNuJ3Q/DQoNCkkgdGhpbmsgYWxsIHRo
cmVlIHBhdGNoZXMgc2hvdWxkIGJlIGFwcGxpZWQsIHRoZXkgc29sdmUgdGhyZWUgZGlmZmVyZW50
IGJ1Z3MuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAvbWp0DQo=

