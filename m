Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A221C3600D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 05:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txJ5o-0008NX-BR; Wed, 26 Mar 2025 01:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1txJ5m-0008NF-CI
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 01:14:18 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1txJ5j-0002ao-K9
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 01:14:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742966056; x=1774502056;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zo0D4bH3Zl7qFdiwARiWBibTWQ1QBn32qiy5mUcHmBc=;
 b=lgzrmHvnieqOHHDTx+S06890R2vD5jZ7e1Ujcz/Z03ujvFGmU9ajDuPO
 nxgdTxHLidPaUVzV2c6qyuwFS9UtYnn8FY8a6B9QM7+DvNzFyMHlUbYu3
 beCw9Vau8x1biu/2Ij7guuGt1ZhP7Av7NHP4ZEygy5ODCABSELNRD/UUM
 DA8aPw+5plFMM10VSz9gvsnIgRqqWMn1SPAtTk9GizpZ2qmUXJ7BnZUNj
 UHKrkzdjEIpey7PR/NTbTFzESIksaFtXBogEHAkc087Fs57/YnthOZIZ0
 6E+nI+GMZTg7OFY+y3DPPQXP5Ty7lWrJnOZFaByzqWZTw2rVKllDCmgeP A==;
X-CSE-ConnectionGUID: 3ARXhMWISseJsKLkeVll5Q==
X-CSE-MsgGUID: Nz5Nr7RMRi2nQKRy4jC1tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="44253991"
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; d="scan'208";a="44253991"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 22:14:12 -0700
X-CSE-ConnectionGUID: pqJfCr0vQAuSlCh8j3MUOQ==
X-CSE-MsgGUID: CZvz7aslR9+K2b2FPc6HAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,276,1736841600"; d="scan'208";a="124561627"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2025 22:14:13 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Mar 2025 22:14:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Mar 2025 22:14:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Mar 2025 22:14:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHBZUq0JKT4khVuFMTwAWy4mTVos7qShQNkedWpCETAAdMBLuopuJrF+RC4nM3zIUtC5rCnkxkdQ1rB74K+jro9PLVV6E7dWAwTqTJImq6a1z59VUIv5HbOnAbTD8rKvIpRF9Ufez8obFRLdQCtLWABAwW92fuxqrw8U3um433ySxKTjqNO32qNuyUlg6y7qnOirh+I8Bq1rSvbxLUouEJ8savc7yLiW1A8GEMO49/9wTq0w1dg5Ae9xv7lfZNwHFk5wG/RaOnhdpg+pfusDLkkPRM70mXCfgHSAQB4Z9+pLgZlXl5R6lA20196/KEOEfWKIG0DEvUeLkwk55y/MGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zo0D4bH3Zl7qFdiwARiWBibTWQ1QBn32qiy5mUcHmBc=;
 b=VJzhqpLI/q13TuLXIpiaOVYTz9r16xB6ynMnl003t1G3b2nD3mIwdfOXk+94aKqCmPrEj9ZFu0eKspGdBPCQn2wvZ9rhI57i5B8B9TLPUnK+dES34TGe+76TE6heJhGGScJpyJDre4fXisWsZ2/TLe0ySJ+HZkv24Jx9PDL+XlJ/IDz/2zTes2QPgIYI1NVbhEtsnggbuzA0vGKysqLzqSNYRxkZ/ExBHplv2MuplFUQoW72iM8eFmFGlJ8GR+IJmB+kKr9ikTc+qyMfsfHTp/L1dcLAeiCgNzoS0TDb5jdD/hPA5MDfRssT78inWo6JMTFfRgrcvleuYUVqw51Kug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MW4PR11MB6787.namprd11.prod.outlook.com (2603:10b6:303:209::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 05:13:50 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 05:13:50 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@redhat.com>, Frediano Ziglio <freddy77@gmail.com>, "Kim,
 Dongwon" <dongwon.kim@intel.com>
Subject: RE: [PATCH v2 4/6] ui/console-gl: Add a helper to create a texture
 with linear memory layout
Thread-Topic: [PATCH v2 4/6] ui/console-gl: Add a helper to create a texture
 with linear memory layout
Thread-Index: AQHbnd+z4eFLVEmfKUuj7FPTRFoXy7OErqMAgAAQRkA=
Date: Wed, 26 Mar 2025 05:13:50 +0000
Message-ID: <IA0PR11MB7185DF8715A421878FD84E77F8A62@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250325234115.1332883-1-vivek.kasireddy@intel.com>
 <20250325234115.1332883-5-vivek.kasireddy@intel.com>
 <11ccee8d-7378-42d0-878e-91b61affb1cb@collabora.com>
In-Reply-To: <11ccee8d-7378-42d0-878e-91b61affb1cb@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MW4PR11MB6787:EE_
x-ms-office365-filtering-correlation-id: 8674b31c-0b6d-4d54-d645-08dd6c24fe79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RzU5YXZtRGZ5OFQ2TjFSa3FDZUxReCtqL2RVaXc0UGhpZ2Iydy8xczJTZDFQ?=
 =?utf-8?B?K1UzZG5PRlBTdWtVWnlGUVlRcVBvRzZDZGR3NE9TeUJlS0NVWDh1RVBrbXZm?=
 =?utf-8?B?OVhlM2FmS1FScml4S0YxSHd1eXg2YWRERkJoTmpCOWhpTVMwNW9HMWFHd2NY?=
 =?utf-8?B?WDltTE9ESlpwcUxVN0IybE55SkZhZFgxNEc4Q3FEQTFNcFVxM0l0MGZhb1Rl?=
 =?utf-8?B?YVBOVi9saXVnMWx0QXk4VGozTEppT3l6akVaemx6NkE5TVF6U09CUEtJTklt?=
 =?utf-8?B?NmlUclNCaTlvcjFYMkpRNXJkWERwazZnTU1NWGxiNUJmOWNjMlp6Y0k3dExx?=
 =?utf-8?B?VXpTVnVNWDF0RUViZXROV1c0WUxQUnhFUVdZclVOaWlDZTRYZlQrcHQ4bnRC?=
 =?utf-8?B?RDkwRHRrdG5xQklVeVhuL3lvZ0RIMVVkRlZZNHMxbUd0T1dHeUpnL3pPRUF1?=
 =?utf-8?B?bzhSRmRPcFVhWFFFc2ZQTlNuQUg2U0tNajBqN2x2SURLck9Xa2luSTg0TFpt?=
 =?utf-8?B?UG9yS2daMDJkSU5NMHMzanZWYWZONDJKakl1cDZRbUxiUDR2RGhVSUNjZDBX?=
 =?utf-8?B?WUVibFBUdThESjFEeGRpaEVYaTVUeW9lM0NBUTlDcEVySTRTWDBXUHpzTnZj?=
 =?utf-8?B?cVY2OGNjeFBnVzA0VklJZkY4cXRxMUJrQkdHMW03dEFOdkwxekswTFNwelJn?=
 =?utf-8?B?cS94N05QZHl4RU84OWNRN2JGeGZrRVhlOGg2T3ZaRUtkZXJmNHBueVY4ekpR?=
 =?utf-8?B?elFnKysvRHR5N2NtNFJzaWJxQ0lycUFKQ1Q0enVybE1ROFBpcHllS21BbVVI?=
 =?utf-8?B?MHVZSi9weEtFTlhqbGp5Zzk2L09jbm9mbGFNMDNaYzFld2p4OGN0djJQdERv?=
 =?utf-8?B?M3NQNTRjYk1nN2F2ZU5mby9OTStHUE9qeXY2RU51Y05qbUp0dWc3VGwrbTJ3?=
 =?utf-8?B?ME9YYjRBc3p2YmFVQTd0Rk1QUVQyMzhXUzhaZVJsT0dyNi9FaGo4aE1kNjlC?=
 =?utf-8?B?aGJOOW96UzVRcjJwb1dqb080ODV2Q1pzT3lOZkdiN3dtT2VXdXpXZVI3L2h1?=
 =?utf-8?B?eWcwMmxmTGpTaU1FT21FN1FxSDE2TmlDelRXVVlkSjhDakRWWUR2UGUyZE5q?=
 =?utf-8?B?dERCZ3JSV2J0QVdEUE1meG9SajhCeCtJOGhqczIwSUpwQzVoYkV0WmlzRStx?=
 =?utf-8?B?ckhQLzdqeGhtUDZMMlJ2bjZhTmxLcTBSZStUaUZnMmE3UW1rL2w4bmRkc2FQ?=
 =?utf-8?B?dFEyUi9hTHNLRUdUVWFDRHRCL2hEZFE3d1hxL1FDTHF0aE0wN3RyU1QyVVFq?=
 =?utf-8?B?aHFtNXN0aW5TMjZzN01jaWlHdU1WS25oMWw1aFhBM3lUUE01U3A3WTNmMzEw?=
 =?utf-8?B?Z21idFFmaU92NjREYkk2U205NlJUbElvcGkyYnhmdzlyTUtNMzlVVHdXMkE2?=
 =?utf-8?B?a2FrYkFFU1NwTWMyZDhvUXpEcG1yWGtaTXcvOThPcVBTTTZsYlRpZ2ZvRjJk?=
 =?utf-8?B?WE02OEptZzBYUlhhdXAxdDk3Y2IyZzZXUjdPTGQ1TkMrVVBHbm5jeExnS2JZ?=
 =?utf-8?B?dkhzWGo2bjlXTE9PVFBpSEN1V2hJYS9aVEJmTU5mVVUybVFvRG1BR3R0dzBx?=
 =?utf-8?B?eC8zVENQb3UxRnNvMnBYenBZZFA3aS9qb0h1SW5UNHpBU0FhVFlRVTBQZmc2?=
 =?utf-8?B?TXJ1Tk45NVd2cFNqSDFIVE5lcXl3SnRRZ3VFRlcwaEZxN1Jab1I3Y0xHZlFP?=
 =?utf-8?B?L0RGNUNlNGYxbTN1Nm8xaVZ4dGlOY0RnZTJMR3ZVMERQN2tJOUUzcDJQdnF6?=
 =?utf-8?B?TkMxbWR2NEc2VjFBK3RkcUIvRWJCdStPQmNKZVF4dVNYTVZWVlFOTGI5bFNH?=
 =?utf-8?B?VEtKUUlRbVQxRGFzcnJzcFluLzNsM0l3TnI0dHAxcm1jcGtvZWx3R3VVWTRM?=
 =?utf-8?Q?F4Ma2PmH6Zp7P33ZjZuYscsDj4khXqYj?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?di85eFdHRUVhZHVhN0pGSHRJUVZ6b2hhUVRRTXJpZExYeDhiSFRBakRZSUFY?=
 =?utf-8?B?bmlSOUdsL3JCQWI4RkhrOVliakFaUUo4NVlrSEZWd1NPZXlsM1hQbTVEOFlB?=
 =?utf-8?B?c0w0V1d4NGRGRk5hUWVSUkFvdzFNdWlkeTI0djRvUTFIK1IwZjg5VU1FLzZi?=
 =?utf-8?B?YXhpUzI5djhWSEIwQ2trQW1TNHo0SDdzNnU1WWUrMWVMaXU5N01ac1hXVU5m?=
 =?utf-8?B?d04xa0Q5cVk3bWRKbzk3cURtS0VucVJpWEkraXBpbnNjN0Q1OEREZHlVSld3?=
 =?utf-8?B?V0h6cWQwT0hVUjBaQlJ0d0xBaUs0S296WDQ5QW5YRUtNYkVsZndmU0xzaEd1?=
 =?utf-8?B?ZEV2WnV2WXJQUVpiRE5Ea09xbEZSNTNnR0RmL2xXME9kdC9OMzl6U0RTQkhU?=
 =?utf-8?B?eDNsZ3ppSitZQm5UekVZWmJLNVl1WDg2YURoLzQvN2ZEZDU2ekxuU0hPcW1X?=
 =?utf-8?B?L2ZLN2lLdU9xclJPdERSblBib3NvVjNtTEppNmRxeFVhRXV3emk4VVI0eWpE?=
 =?utf-8?B?NGN1bk9FaEc3K1pDN0xLNkk3K215Wmt0M3IrOGVzcWp0aHYzNDhBcFFFTC8r?=
 =?utf-8?B?Tk9NNWdvMllSNTRwdjFqWWQxYUVrL1VqQW9EVFNXdlJ6S2ZzMTNZYjQyVk5V?=
 =?utf-8?B?L1UvVnFNT0srMnZTNUFWQjBGYXRJalJsRldqUC9FVEViNVcxd0tTd0MrdjRL?=
 =?utf-8?B?UkRmZ3p1djByWHYzU0tkVXpTRVh6R2xNeTVrM1drZmdxUXNSd1IwV3h2Ymhl?=
 =?utf-8?B?T3JJYzJjZVl5eENFVDYrK1czSHAwaVlxNm16ZzFaajlXZlZkN2ZBTksxY2l4?=
 =?utf-8?B?ekVTY1BpbG0vSDJycXZTUU5oUjVFYXNqUW54MXlMaDM4RExJR2psSm16RVVp?=
 =?utf-8?B?Ui9FNnZXU0lUMUJaL24wOFBpMUw0dXZwaStSYVRUNmc1SjlWR1BvbFhDKzdr?=
 =?utf-8?B?UlBJR0lQbm1GTllleW9lNXRyTi95Vnkzell5akVmWDNHeTM2TCtVR2FNa2NI?=
 =?utf-8?B?K3UveFJlb0JRQmlEdXJ4K25qVnZhUjZVaytMUjRCQjBVVXB1aXhqVFZEZExQ?=
 =?utf-8?B?b2NpNS9MZ0c1eE5rTnc2UDR4VVdYSndUcUV4R21oOXZTODI1NzIwOVNDeHZi?=
 =?utf-8?B?M2RVWURHNGFFSmxCVTkwVlNNZzFFc2tKUVdWSzJROWViNmhaR2dzZEphbXZZ?=
 =?utf-8?B?aGJVbWtvTTNPeHBhSDVmWFh4NEVDeHRnaEJKemM2UnFiVUtzL0YyUTMrMzRO?=
 =?utf-8?B?L0VYMjJBUWErU3czVnErZWlYSDdMQlpjakg1UWJHZm4yc3pTUWJKcitOVEpJ?=
 =?utf-8?B?MGhqN2dqT2pBN1g0TXQ5K1F0RlFNMFFDSFp3bkF6bm5INVBUaE5VKzBDV2d6?=
 =?utf-8?B?NnVDZ2taZ240LzlGcGNJaGxjNEhPWmdvMW8yQWxIY25SYnovdmU3aGFHUSt5?=
 =?utf-8?B?bG1NbGxkSFFLVmQzY3hvNXIyRlZiVWRQTll3Qk9KNmlFbmJydHNaVnpFWitI?=
 =?utf-8?B?NjZjZ0tJQXlOUy9SSkpvRWszR3Q5VHdyS3F5eFMwc0N3SGpCWkx4SGR4RTc5?=
 =?utf-8?B?VGtoSk9DUVVYWUw2NzRYY204dEJQUk1PZVdSTW1HU0ZUekVkc05tSWwySkV2?=
 =?utf-8?B?TGZHQVU0aVZXTVdvdDRUT09VV21wQ3dtQk0xdzdKRUtiRjBlUHJnZHNzOHly?=
 =?utf-8?B?VkJrNGdLUUdER01iWFRPZTZRNUhENmRyd2ZMMitQREphOXpsWXN2MzRRVWhn?=
 =?utf-8?B?RCswR0ZaUzJYUkNuRUpnMFpoaGorUk80dFZhUGxEQ3ZjcHdSQmJMaUw4R202?=
 =?utf-8?B?dzlWTnR0S04wWmN1bDI3RW81RDY0MWVyc2I1Mmt6OFpHeGdzeWd0UEVOdXFF?=
 =?utf-8?B?aDNyUTdNdGFYTGFyR2pnSHJ3blBzbDZnNzB2ZVZMVmkzU1F0VzkreFFUVUMx?=
 =?utf-8?B?NExpb0Zmc1dDc0NVbnpqanNvY1dWUGxtb3VKVklUY3JTWGdUSVUxdlZSdFB1?=
 =?utf-8?B?ZmtIM2xZYWF6bXBHd3lNUW9IdnNDWS96YUVBTXlJUVMwWWNiWHFVWUpGYjVM?=
 =?utf-8?B?a1Z3UUd5Q1dETG9lcFpkYkVUYWhrd0VXNzB4cjFnUHl4RlVxQXlBdy94TWw0?=
 =?utf-8?Q?DO59ARpNt+7uXsaHjl1b2BGgH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8674b31c-0b6d-4d54-d645-08dd6c24fe79
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 05:13:50.0215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6g3kfLyKKrkyWRN2OyqAgVw+A6OGz/OsqRtDevNccLG71Ts8s7nGhD8DgS3oK9aoyKmvG+tZEKQUKSDuKhW7rqsM2FJ+tu3FfNZQf5Fp/L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6787
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
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

SGkgRG1pdHJ5LA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNC82XSB1aS9jb25zb2xlLWds
OiBBZGQgYSBoZWxwZXIgdG8gY3JlYXRlIGEgdGV4dHVyZQ0KPiB3aXRoIGxpbmVhciBtZW1vcnkg
bGF5b3V0DQo+IA0KPiBPbiAzLzI2LzI1IDAyOjM5LCBWaXZlayBLYXNpcmVkZHkgd3JvdGU6DQo+
ID4gK3ZvaWQgc3VyZmFjZV9nbF9jcmVhdGVfdGV4dHVyZV9mcm9tX2ZkKERpc3BsYXlTdXJmYWNl
ICpzdXJmYWNlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
bnQgZmQsIEdMdWludCAqdGV4dHVyZSkNCj4gPiArew0KPiA+ICsgICAgdW5zaWduZWQgbG9uZyBz
aXplID0gc3VyZmFjZV9zdHJpZGUoc3VyZmFjZSkgKiBzdXJmYWNlX2hlaWdodChzdXJmYWNlKTsN
Cj4gPiArICAgIEdMdWludCBtZW1fb2JqOw0KPiA+ICsNCj4gPiArICAgIGlmICghZXBveHlfaGFz
X2dsX2V4dGVuc2lvbigiR0xfRVhUX21lbW9yeV9vYmplY3QiKSB8fA0KPiA+ICsgICAgICAgICFl
cG94eV9oYXNfZ2xfZXh0ZW5zaW9uKCJHTF9FWFRfbWVtb3J5X29iamVjdF9mZCIpKSB7DQo+ID4g
KyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArI2lmZGVmIEdMX0VYVF9t
ZW1vcnlfb2JqZWN0X2ZkDQo+ID4gKyAgICBnbENyZWF0ZU1lbW9yeU9iamVjdHNFWFQoMSwgJm1l
bV9vYmopOw0KPiA+ICsgICAgZ2xJbXBvcnRNZW1vcnlGZEVYVChtZW1fb2JqLCBzaXplLA0KPiBH
TF9IQU5ETEVfVFlQRV9PUEFRVUVfRkRfRVhULCBmZCk7DQo+ID4gKyAgICBpZiAoIWdsSXNNZW1v
cnlPYmplY3RFWFQobWVtX29iaikpIHsNCj4gDQo+IFRoaXMgY2hlY2sgc2hvdWxkIGFsd2F5cyBz
dWNjZWVkLiBnbEdldEVycm9yKCkgc2hvdWxkIGJlIHVzZWQgZm9yDQo+IGdsSW1wb3J0TWVtb3J5
RmRFWFQoKSBmYWlsdXJlIGNoZWNraW5nLg0KPiANCj4gV29uJ3QgaHVydCB0byBwcmludCBlcnJv
ciBtZXNzYWdlcyBpbnN0ZWFkIG9mIGZhaWxpbmcgc2lsZW50bHkuDQpNYWtlcyBzZW5zZTsgd2ls
bCBhZGQgZ2xHZXRFcnJvcigpIGFuZCBlcnJvciBtZXNzYWdlcyBpbiB0aGUgbmV4dCB2ZXJzaW9u
Lg0KDQpUaGFua3MsDQpWaXZlaw0KDQo+IA0KPiAtLQ0KPiBCZXN0IHJlZ2FyZHMsDQo+IERtaXRy
eQ0K

