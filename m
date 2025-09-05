Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47CACA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 09:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuSMu-0007Qu-3H; Fri, 05 Sep 2025 05:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uuSMs-0007OR-4q
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 05:04:26 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uuSMn-0006DZ-QQ
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 05:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757063063; x=1788599063;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mtzes118dtZOYyr5RadQssoOqj4HYwv7pLAnCw1EL3M=;
 b=cd1wVno5EMAWGo4Xm8FKcv16Z8ttQBr30/c4Z+tccSlQOSrxcIQ0GOds
 b2GqpSD0eCjmAmkuKZL+idgjdie9skdO9Ri6rNskXvc/cRSVO3IpXBUsk
 //fBHlP/2y7Npde/wOlFOQC1oLVR8VC7b3/JPOx39yMzAGORSF0ArBzLW
 Cj2dZok6e7JbBJTe2bud1SKd8TM2dG3dlw8+44A+DMnX3uvvFnYJLK86X
 sJyX/4i0FNFeJTw51HbsN+EvknM4Sxe5DMyE9ukcm7k6mJIEacGMjeiHI
 Qly4o+3X3YPOJkYeuKx+6doMy/ALSoZsXpP7MMYWhTVB7FvZN9U4lOp3b g==;
X-CSE-ConnectionGUID: n2v/Lk39Tsqd5IpNjDeN5A==
X-CSE-MsgGUID: mSloWRPGTpepf4ZYtUJ9aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82003724"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="82003724"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 02:04:15 -0700
X-CSE-ConnectionGUID: sR700GB7RRK/5zGkAvwrEA==
X-CSE-MsgGUID: Ah9XvfAARwuDhKzw3S6uJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,240,1751266800"; d="scan'208";a="172049746"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2025 02:04:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 02:04:13 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Sep 2025 02:04:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.87) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Sep 2025 02:04:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTdsuGLxCHI2XB30V4pLz6hGMFkHM9aaGC/ZZnRYQrtNXoamG6LtnPPzBounXjkcsvC0S/SSxSQKAhh2l2dk9z/tNIeyYxurrkSo9ACq2J5kZZlcRNUb+Caedipwz8O3FaBPxQMPNtkedAFlrsDH8ySBmBzUAJGLfiSMIbDAO684cfVne0vV3D5XCMDBnJBBuxd8pkIOfjSBhynK5WainaPC+dI4ux29M4mRF0E5gSVCvnZGe/I22z3JNFF2tkwvg/6to4IBYPull+tbf/2IFgAbn100tO1VGECr33rM7Z1cKx6HPeFUWOwUezvf5rR9C1MCXvYSggab7P/PkGXzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtzes118dtZOYyr5RadQssoOqj4HYwv7pLAnCw1EL3M=;
 b=ElqXYRljVonwWKzFb2eLSHGMsv2Z5IfXQZIhiGGNrfm3XZEUjNLSH/CHjTgTbOHCIYYSmxXduBfKF3w1egJRI9yR9hrmuQJMtqB3T1TNaSuH77svobRMh8+5uPoPrO+EE7BK7CjdgRgRlG/e0KCXbQUFVqpNgOmHrF3O//Lb4O7eiZZ3b+DfQ0bjpI4W9k51PkLB77zcFcZlNj2W45zcj1NeVYlhkz9IZA8fx/SDRtjx+6YeeiyIkyeOH2ijWVcMfgrYrQr0IxkyXvGsli1+Hhn/IvzNc5/20OYabglL6nMp1lee5k2Pum48CmgTl3IDHwMQn9YPzhU+ykzzK6C+GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ2PR11MB7473.namprd11.prod.outlook.com (2603:10b6:a03:4d2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 09:04:10 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9073.026; Fri, 5 Sep 2025
 09:04:10 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>
Subject: RE: [PATCH] vfio/container: Remap only populated parts in a section
Thread-Topic: [PATCH] vfio/container: Remap only populated parts in a section
Thread-Index: AQHcDMr9Ap6MRYQc10GVaAw/xMLNqbR4FPYAgAWb3iCAAkuLAIAEca3Q
Date: Fri, 5 Sep 2025 09:04:10 +0000
Message-ID: <IA3PR11MB913635617BAC00289BC3DB1B9203A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250814032414.301387-1-zhenzhong.duan@intel.com>
 <0286f864-9aaa-4a49-8975-cb1af3bb1270@oracle.com>
 <IA3PR11MB91363501F1A6ED40098AF8249207A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <0026017b-770e-467b-ab7d-98cac1c70463@oracle.com>
In-Reply-To: <0026017b-770e-467b-ab7d-98cac1c70463@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ2PR11MB7473:EE_
x-ms-office365-filtering-correlation-id: ac5b6365-71c4-4c02-8cfb-08ddec5b2d55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WEtGWnNuS2VvbXdVZXVvYytvMG1sK1F5dDF4L0J1RmZqeFhxczN4OWxKeFA1?=
 =?utf-8?B?OG9oZm9LSUZqSlZhQlpWNGlBek0zeVhzbHNGMzNWMUkzRkNuaENSbHB6andj?=
 =?utf-8?B?OFdOb3FJYS9UK2J1WFdPbU9JZm51ckVBa3o2SmRGZjVyaFYyREFTcjFOUVZO?=
 =?utf-8?B?b1RsU2t2UGhTTWJuRUhzS2lTWnVCdTFHcWJiajdmSWF5SUpZaU43alFkM1dt?=
 =?utf-8?B?QkhnYVhudGNnV1JPQXJXajlhbm5LNmxxZEtZVUFjR3ZieG9LT1lLTDI4cExm?=
 =?utf-8?B?bDBvR0RxdzYzc0ZhYnRzL2hkSzB2TThsN0tydG16VnhlV1BsTFFPRTUvc2FE?=
 =?utf-8?B?WXNhWXVoa3cwS0l5cjNibDFFeFdiOWRxSGVIWTlQMFE0eVgvZGg1d2oyMXJ2?=
 =?utf-8?B?TjIwYmNkbmpEVGhzMGRFMHBlUTR5Tk5qZm1uRnFHc3VYcEFWOG5QdmFQak80?=
 =?utf-8?B?ajY1cEJtNjBvOEl1em1xMHgvMUk2Y0p6QjBPQnYxNGdxNUQ0V2dHdHU3czlM?=
 =?utf-8?B?bzcwNUUxSHBkTkhSOUJxdW9tUy9NaUc0Q2wzd1RKZVB5WEJuRUU5dVBXK0xt?=
 =?utf-8?B?M1haY1IzdTBDQ2JMaEEyY3BzRFdnS2xnaWFkVUdPRzRMRHhkWExxc0U0WnJN?=
 =?utf-8?B?Z2Jkb1J4TjJhNG9mU2JRWmEwYzNFUkxRVXNNc3JrTTBVcDRreGNON1FKVzJQ?=
 =?utf-8?B?aXRGNmNrOFM5K21PcmcvK0xPVGdYZzVLZlpFVG1pemhjN0pmT2U0M3YvbnZs?=
 =?utf-8?B?R09lV09nZG1ENjdDZTk4cDU3cEdJK0I2SmtIQ2R4WkRFYi9YK2lqSW5sbWMv?=
 =?utf-8?B?OFlVU0tHT2czL1NTQmVmeXBJT0M5SzU5VHBUQ2IzeEJEMWpqSG9NNm1HS3NT?=
 =?utf-8?B?Wk9XVk52enNFMlhlWVBXYmtYckQ4UjU4bjZSOW5rWHE4QkZzVFFDcWJwNzZm?=
 =?utf-8?B?MHBZWDByNEJtQkNDUjNFK2crdmVER0xKZ3d3dk1rdFhQaVJ5QXhybXk4ZEww?=
 =?utf-8?B?dGMyMTZBM0oxS1BzYVhIaFRRVVF1dW81eUtiN08vQzk5eGliOU84RWR3cXk2?=
 =?utf-8?B?K01hVEJlT1J2b0ZtRktrazhJd2FYajlmcmwzQlRyQkl1N2ZzUGxZbXdYb0hV?=
 =?utf-8?B?OFFTU0RnMTNEY2NYV2xraWRWQTlmaDM3MnBXTEpBRUhFUkx1WWRIYzRIbTRL?=
 =?utf-8?B?U24rODJZbW1oSS9jUjdQeVc4aVB2clNtK09LQkdsRGVBaXBKaEtBTHhPaWRZ?=
 =?utf-8?B?MTZUTVM2TS9EQ1lYdFI4blF3SlQwVmNKei9qQk1oa1ZRYzRSbExxdWJCaGtz?=
 =?utf-8?B?SmxxNUhueU94YmdvNk1vU2h1bWg0UmxSMU1jY3BNWjVKeEdBM0Z0MENGOW54?=
 =?utf-8?B?NExySDB4b3pmMDh6WlFWemwrWGRNRnNZbjBXZjM1MlUrdkhYVEFMNTJFTDls?=
 =?utf-8?B?RWZKb3BiNmcvby9zV3RIUWRIOHczQnh1TityTXJsV2MxSjhabGxzL3RyOGFa?=
 =?utf-8?B?UTJjNSt3K3VNS1o0ZkV0YjZERzc3UmJZSnRRMTk2TEIySzl6MFAvRnZKVlRH?=
 =?utf-8?B?VVZYSmtnZGdpakJaWVE0aDZ2VWVKVGRlM25zVlEvUGVnWDNXQmZKYWRsUUo4?=
 =?utf-8?B?eElkVG5ualY0U2o4NTRXVHhYQWViQWl6RXI5SWhHWjlWMUJ1Z2l6Mm53ZG9v?=
 =?utf-8?B?Qld0ZG1UZHUxRm83cnR3NEtXd2pKZFdKZ0JkYWhEdlJTUEJBcFUzM1EyVjJu?=
 =?utf-8?B?blNwcTZ3dzlKWDQyNG1SMERxN3ZZYzdqcXpXK1FIQ1o0NGlEeHZ2Y1g1Z0Jv?=
 =?utf-8?B?UHVTZDVIcnNnQ0E4bGZtaXg3Zy93Y1BLQ3pkTkl5MmRNWWEwbWlrbUtRc2Qy?=
 =?utf-8?B?eXF4dWZzcWdsOWZJVHVsUTVJR3hUU29nWlhCZGxMamNDL25waGkyc0QrR0lF?=
 =?utf-8?B?TmNyMkExcXQ4VGQwYjE2S0JpcmpoSXdTaU5GK2ttYko0aDg0Yyt4a29qcERX?=
 =?utf-8?B?QTZPQjlmdEJnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkNqZHdsRVA4clpQYXA4eVoxREgvRnBBNTYvaEo3dEp4dnQ1ZmRPYzI5OWlD?=
 =?utf-8?B?ODdPSURvclNnbi9KMlJ4Y2Rpc29ycURlQkFNUzZPOTVMaEJ3bXUwM2lHVkZu?=
 =?utf-8?B?blRPZ21Ld1RWZTU2ckRvOVUwK3R3WHlXZUJhRDBEb3dBVkNFWDJFWU1ER0Ja?=
 =?utf-8?B?N3BySjFDWEUwcWpaMmgwRy9tRUJSWnlaR2NndjBWZU1FZ1pzKzQ5cGwvUEtO?=
 =?utf-8?B?b1Y1OTNTdlpMa0JYVHpLOEVleEhCRkp6L2JNRmJSSmYzYkdVazNoUmNiTnB0?=
 =?utf-8?B?YnI3VzNoTHhtY3pWOER1RFhSaTBHRlBaWDFtcWNLTEhTbzJ5RENVNTlNOW50?=
 =?utf-8?B?dFFwTGRwRmlGWG9qclBhanp5ekxUWXhENUJxYS93VWptTklMUUl1eExaY1hz?=
 =?utf-8?B?azhib2xlcmVPbU5SWkVJeUEzM3FBNGpucis0d2RLQlgvWFl6dDRZVEZCc0pi?=
 =?utf-8?B?aHhmUG91NTRsb0lqSkdVQmttOVpReEpOL3J2TXhaZ1dBdWFsTXR2K3dFMGc3?=
 =?utf-8?B?b1EwZTU2UEVoSTdpU3dsRjE3TWMvcXZGSlBRZEJyQ2ZkRVlKbzA5RzZrdE1J?=
 =?utf-8?B?RFdZQnEvZWRRR29lZ0J0Q2VvZzIrM1BxR0RBaEVoTGxzd04wb0JVVS9Ja2ZO?=
 =?utf-8?B?RlZNTHlkUDFHc1NNK1pIN3U1U1lZR2NIR0cyY0lKcGlKdGd2VnRzbGFtaXZy?=
 =?utf-8?B?aklRMUM1bzJiYVRTOWFzZkRhYStRWDNFNm11RU5aUytaZVREK0IwVnRobzFm?=
 =?utf-8?B?ZWVGbGhRaE1rK1Q0VVZCcDcxSVZvbEZjb3ZyQ2NDOUZyN1FIaHR6aGZyZTJR?=
 =?utf-8?B?dXNiTkNOY1RDWXNuTUxYUFllT3dOLzFmRWVRUWw1TnpNSUxrUG9wSngvOFpn?=
 =?utf-8?B?Y09VWWtvVjdNQlFqSzZjK2VtcjRFdjcyd21pWHlxa2FVTGhRRm9sVmN0Y3kw?=
 =?utf-8?B?RDlxQjZSL0VKVWFEYWVVdktOUGp2NlBIOFVlSmUramF1OGU5UVI2OC8yN0VX?=
 =?utf-8?B?ZmM0WnNnOEVnSjkzVGZYNjlkRW1FZ3VMRFRjZzJoU1ExeU8yeW1malVMNGpR?=
 =?utf-8?B?Z1FCYy9Qa21oVkpWdjhodjdLQzQvWkM4UXhtQ05uQTk1eUFTN1BiczF2Lytt?=
 =?utf-8?B?UDlkYjE5ZzNxalVOR0Fnc2RrSVQ2UU1TUlZXQVNhUWdScnFWV3dHc0Zsc3Jk?=
 =?utf-8?B?OGYvWHBscnJBM1BrbEhOSTFpZnQxT0doWVhXeW1rQ05NU0NNaDdLY3VxaTY0?=
 =?utf-8?B?RmtXRko3WHllckQ2OFBRQ1VzNXJieC9wOXVzSVd6WWtQM004TWs0ZXJCaXln?=
 =?utf-8?B?NUJKcWNLOURTNFkxYkUvcjNKay8wNFNvZDBObTNPNVNwWE8wTExacnkrcFRZ?=
 =?utf-8?B?bHZZcVVjWTRxYUg0b0RsNE5WMmhaazlyWU1WdzN0K25uMW0xQi9iOHZRZmhv?=
 =?utf-8?B?cmxxeWJmU3hDSGk1bjIwSHBhaXVFSFA5ZlRoZ2NLWm5CcVB3b3Nvc3Y3MUs3?=
 =?utf-8?B?MjRoMDZLOFMyKzhmSEtDODRhd2N1NWlGU2ppSllUNytIdm85bldnTTNRU3N1?=
 =?utf-8?B?SFYwWlNVVE1kcUVaMlVwYjNZSHhrN0lQb0FKOUNrRmYrM1pXak5WbFNSMTk5?=
 =?utf-8?B?c3ZIQnp0aWxIbVh5RXRVVXUzWnB4TCs1bXdkU2Z0WHJOQ0YxOEpvL2kyOHlk?=
 =?utf-8?B?T0ZSMXcrcktLaHhORjg0bEtzYXp3b3lPRWxSRFZsOExlN3dwNXJPeXZjL2hJ?=
 =?utf-8?B?dEhIcDNqd1lmRDJsYjdNaGVBNDBiWXcyL0d2SDFtMmRqVFZDeGxtRkhKWXRK?=
 =?utf-8?B?bzRIWVY0Y3FhaVFrU3FHb2dlS2tzb01RZVhPYmg3MlFoZCtreFNjUHZrQjcv?=
 =?utf-8?B?bGxJVzZBQkVlL0NLeEMvd1ZrZHh4SVkxM0JkNVZYS3ZLSUZ5N0JqOVVNcW5j?=
 =?utf-8?B?RUlldkRaSDRhOWxHZ2FCaXNTcmxGZFhHOFkzbWlTYlQ2enpqTjdncHplVGE3?=
 =?utf-8?B?aTU4SW9RcEZQWWtvelpERXUzOW9SVkk0ZUtDQXIxRFliV1pWZVB2UTA4dWFP?=
 =?utf-8?B?WWVtaE1Dc3BaeGNsejgxZkxIOTZ4K1Z4MjBRRXB4WEhlaWQ0SjlWNk1WNm91?=
 =?utf-8?Q?cCeL9ssrxUcvEFSaXLfeHyHYs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5b6365-71c4-4c02-8cfb-08ddec5b2d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 09:04:10.2613 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BCtb1/GbugrM5Y86a+mUP+SPA3r2VtfWHuCSJCm5Pg+YKZJaNtoU7/eAN3yV9hP5Q/UBoN1OT81BRq+LnXEtXsDYpvL5T94BMfLLyAXhbh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7473
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

KyBEYXZpZCBIaWxkZW5icmFuZA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9t
OiBTdGV2ZW4gU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBS
ZTogW1BBVENIXSB2ZmlvL2NvbnRhaW5lcjogUmVtYXAgb25seSBwb3B1bGF0ZWQgcGFydHMgaW4g
YSBzZWN0aW9uDQo+DQo+T24gOC8zMS8yMDI1IDEwOjEzIFBNLCBEdWFuLCBaaGVuemhvbmcgd3Jv
dGU6DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBTdGV2ZW4gU2lz
dGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENI
XSB2ZmlvL2NvbnRhaW5lcjogUmVtYXAgb25seSBwb3B1bGF0ZWQgcGFydHMgaW4gYQ0KPnNlY3Rp
b24NCj4+Pg0KPj4+IE9uIDgvMTMvMjAyNSAxMToyNCBQTSwgWmhlbnpob25nIER1YW4gd3JvdGU6
DQo+Pj4+IElmIHRoZXJlIGFyZSBtdWx0aXBsZSBjb250YWluZXJzIGFuZCB1bm1hcC1hbGwgZmFp
bHMgZm9yIHNvbWUgY29udGFpbmVyLA0KPndlDQo+Pj4+IG5lZWQgdG8gcmVtYXAgdmFkZHIgZm9y
IHRoZSBvdGhlciBjb250YWluZXJzIGZvciB3aGljaCB1bm1hcC1hbGwNCj4+PiBzdWNjZWVkZWQu
DQo+Pj4+IFdoZW4gcmFtIGRpc2NhcmQgaXMgZW5hYmxlZCwgd2Ugc2hvdWxkIG9ubHkgcmVtYXAg
cG9wdWxhdGVkIHBhcnRzIGluIGENCj4+Pj4gc2VjdGlvbiBpbnN0ZWFkIG9mIHRoZSB3aG9sZSBz
ZWN0aW9uLg0KPj4+Pg0KPj4+PiBFeHBvcnQgdmZpb19yYW1fZGlzY2FyZF9ub3RpZnlfcG9wdWxh
dGUoKSBhbmQgdXNlIGl0IHRvIGRvIHBvcHVsYXRpb24uDQo+Pj4+DQo+Pj4+IEZpeGVzOiBlYmEx
ZjY1N2NiYjEgKCJ2ZmlvL2NvbnRhaW5lcjogcmVjb3ZlciBmcm9tIHVubWFwLWFsbC12YWRkcg0K
Pj4+IGZhaWx1cmUiKQ0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KPj4+PiAtLS0NCj4+Pj4gYnR3OiBJIGRpZG4ndCBmaW5kIGVh
c3kgdG8gdGVzdCB0aGlzIGNvcm5lciBjYXNlLCBvbmx5IGNvZGUgaW5zcGVjdGluZw0KPj4+DQo+
Pj4gVGhhbmtzIFpoZW56aG9uZywgdGhpcyBsb29rcyBjb3JyZWN0Lg0KPj4+DQo+Pj4gSG93ZXZl
ciwgSSBuZXZlciBsaWtlZCBwYXRjaA0KPj4+ICAgIGViYTFmNjU3Y2JiMSAoInZmaW8vY29udGFp
bmVyOiByZWNvdmVyIGZyb20gdW5tYXAtYWxsLXZhZGRyDQo+ZmFpbHVyZSIpDQo+Pj4NCj4+PiBJ
IHRoaW5rIGl0IGFkZHMgdG9vIG11Y2ggY29tcGxleGl0eSBmb3IgYSByYXJlIGNhc2UuICBJbiBm
YWN0LCBpZiB3ZQ0KPj4+IGV4YW1pbmUgYWxsIHRoZSBwb3NzaWJsZSBlcnJvciByZXR1cm4gY29k
ZXMsIEkgYmVsaWV2ZSB0aGV5IGFsbCB3b3VsZA0KPj4+IGJlIGNhdXNlZCBieSBvdGhlciBxZW11
IGFwcGxpY2F0aW9uIGJ1Z3MsIG9yIGtlcm5lbCBidWdzOg0KPj4+DQo+Pj4gdmZpb19kbWFfZG9f
dW5tYXAoKQ0KPj4+ICAgIHJldHVybnMgLUVCVVNZIGlmIGFuIG1kZXYgZXhpc3RzLiAgcWVtdSBi
bG9ja3MgbGl2ZSB1cGRhdGUgYmxvY2tlcg0KPj4+ICAgICAgd2hlbiBtZGV2IGlzIHByZXNlbnQu
ICBJZiB0aGlzIG9jY3VycywgdGhlIGJsb2NrZXIgaGFzIGEgYnVnLg0KPj4+ICAgIHJldHVybnMg
LUVJTlZBTCBpZiB0aGUgdmFkZHIgd2FzIGFscmVhZHkgaW52YWxpZGF0ZWQuICBxZW11IGFscmVh
ZHkNCj4+PiAgICAgIGludmFsaWRhdGVkIGl0LCBvciBuZXZlciByZW1hcHBlZCB0aGUgdmFkZHIg
YWZ0ZXIgYSBwcmV2aW91cyBsaXZlDQo+Pj4gICAgICB1cGRhdGUuICBCb3RoIGFyZSBxZW11IGJ1
Z3MuDQo+Pj4NCj4+PiBpb3B0X3VubWFwX2FsbA0KPj4+ICAgIGlvcHRfdW5tYXBfaW92YV9yYW5n
ZQ0KPj4+ICAgICAgLUVCVVNZIC0gcWVtdSBpcyBjb25jdXJyZW50bHkgcGVyZm9ybWluZyBvdGhl
ciBkbWEgbWFwIG9yIHVubWFwDQo+Pj4gICAgICAgICAgICAgICBvcGVyYXRpb25zLiAgYSBidWcu
DQo+Pj4NCj4+PiAgICAgIC1FREVBRExPQ0sgLSBTb21ldGhpbmcgaXMgbm90IHJlc3BvbmRpbmcg
dG8gdW5tYXAgcmVxdWVzdHMuDQo+Pj4NCj4+PiBUaGVyZWZvcmUsIEkgdGhpbmsgd2Ugc2hvdWxk
IGp1c3QgcmV2ZXJ0IGViYTFmNjU3Y2JiMSwgYW5kIGFzc2VydCB0aGF0DQo+Pj4gdGhlIHFlbXUg
dmZpb19kbWFfdW5tYXBfdmFkZHJfYWxsKCkgY2FsbCBzdWNjZWVkcy4NCj4+Pg0KPj4+IFRob3Vn
aHRzPw0KPj4NCj4+IEkgYWdyZWUgaXQncyBhIHJhcmUgY2FzZSBhbmQgeW91ciBzdWdnZXN0aW9u
IHdpbGwgbWFrZSBjb2RlIHNpbXBsZSwgYnV0IEkgZmVlbA0KPml0J3MgYWdncmVzc2l2ZSB0byBr
aWxsIFFFTVUgaW5zdGFuY2UgaWYgbGl2ZSB1cGRhdGUgZmFpbHMsIHRyeSB0byByZXN0b3JlIGFu
ZA0KPmtlZXAgY3VycmVudCBpbnN0YW5jZSBydW5uaW5nIGlzIGltcG9ydGFudCBpbiBjbG91ZCBl
bnYgYW5kIGxvb2tzIG1vcmUNCj5tb2RlcmF0ZS4NCj4NCj5PSy4NCj4NCj5SZXZpZXdlZC1ieTog
U3RldmUgU2lzdGFyZSA8c3RldmVuLnNpc3RhcmVAb3JhY2xlLmNvbT4NCj4NCj4oYnV0IHlvdSBz
aG91bGQgYWxzbyBzZWVrIGFuIFJCIGZyb20gc29tZW9uZSB3aG8gaXMgbW9yZSBmYW1pbGlhciB3
aXRoIHJhbQ0KPmRpc2NhcmQgYW5kDQo+aXRzIGNhbGxiYWNrcykuDQoNCkhpIERhdmlkLCBsb29r
IGZvcndhcmQgdG8geW91ciBjb21tZW50cywgc3VnZ2VzdGlvbnMuIFRoYW5rcw0KDQpCUnMsDQpa
aGVuemhvbmcNCg==

