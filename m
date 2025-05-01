Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9F1C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 05:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAMke-0002hb-LJ; Thu, 01 May 2025 01:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uAMk6-0002Xz-Bm
 for qemu-devel@nongnu.org; Thu, 01 May 2025 01:46:04 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uAMk2-000199-Pm
 for qemu-devel@nongnu.org; Thu, 01 May 2025 01:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746078351; x=1777614351;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ywxTa0q5L1MHc7Cg397t08TfVzU+ptYJQuzAiADCSbs=;
 b=VIs7v3jDI+68IZePhQT4hkOlzP6Mm9rJfplV7hPd4G38tc+vLqB7U9ZR
 VquoDbbsFc+YZKrQzrNXPfDY6jGFLHxHGJ/qpBvWqWSlquuXBkmipXXst
 lfHRyOITHMJaqdcnKZ9MWQybhsVfuG533xKRFf/d4lgrtLO+67PD4D/ix
 MYP62kddWN/HAaoJmnC6/nYm9TK9s4twtQt/HCdiXa1nJtOJyuc90kN2Z
 rMnx0OkVA/E6RVSg07DOUR+4qQlNzB2ii7hIXMG9XPrn++xo5+X1ctzlG
 rkXXlZoJtUTdQEkG0po8U2+xZ9XqCDaXhW6cjyoO3Bm6UqlVJXKO8j2Tu A==;
X-CSE-ConnectionGUID: AjDaydphQFyvjGZY1iDMBg==
X-CSE-MsgGUID: 2HMfaFGsQLGvO8XWD+F1RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47887618"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; d="scan'208";a="47887618"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2025 22:45:49 -0700
X-CSE-ConnectionGUID: 2BbbX1oER8OItb1qd2SwNA==
X-CSE-MsgGUID: 8V2s9rP7Sh+FO02HmToN9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; d="scan'208";a="135284109"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2025 22:45:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 22:45:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 22:45:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 22:45:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+o3drWgCdcnxHiyG9JUaMkHZcPeg1SH9S6uYLZNFlCGoKjM5Hm0r1plhYRuaD82FUdwQGeaiaSBPPm7Qpf4vFl+6hkJQ7PDSI8Z9NV39NhBmkvtJP25mtKR0oRARmAcU6MSce3enuNJYo9bqz5gpnYWQlDWIYXubQBmtG2TN3TF7S7wp1ZK4TTRlKjuCZ9hoy60DmcqMxahKcEGE5B6AHuWSVOAIFA5ZqQ1KdyJkUdZI3N7FGtsMZCTpmUxpcFzF1pR5lFJ+S9Vzep11nx8vWMBPy94UmJSXnd1Hr36VETdLaIKhXEHUHLnZJc7meM9UI4zZYFmNHE9hxpcub5mwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywxTa0q5L1MHc7Cg397t08TfVzU+ptYJQuzAiADCSbs=;
 b=SL1QewCQGGVxvWI1/roAylq5/tfjcaKXEIbMt6xHWwzRw+uXkDrChqqFbZzIfnZU7rLbvd+IBnoMwPrRVTfl+Y1owTdct/pDJdVkFYBs4r4ES2JmkDfJObFK/rLgWN5DcsUkrMkhUqTm7bLPM4m0OEDd4M8DN2/Ypre2NW7AEK2NOA0Pi/FI67y4bAyfSjo249D2GWbl/76jO0ESPqY2KhIbGV7eCNcSSlnFx8bitjXmh+vRpSzWBamqK+afVzPWq4sD/b1WqD9GED1aikEqdGz3TvHBy6dwOxrKPrMtckz1Opt4XMOmC89RsjSEZzPxXdTCa72gy7wTrlxdZ7nquA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 05:45:39 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 05:45:39 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@redhat.com>, Frediano Ziglio <freddy77@gmail.com>, "Kim,
 Dongwon" <dongwon.kim@intel.com>
Subject: RE: [PATCH v3 4/6] ui/console-gl: Add a helper to create a texture
 with linear memory layout
Thread-Topic: [PATCH v3 4/6] ui/console-gl: Add a helper to create a texture
 with linear memory layout
Thread-Index: AQHbuM2vJGY9cDV2T0CKHHxp48RlbrO6fZsAgADN49A=
Date: Thu, 1 May 2025 05:45:39 +0000
Message-ID: <IA0PR11MB7185377896548F4ED6202EE8F8822@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250429060952.59508-1-vivek.kasireddy@intel.com>
 <20250429060952.59508-5-vivek.kasireddy@intel.com>
 <5b6404dd-7b33-4960-820e-628eb0de0960@collabora.com>
In-Reply-To: <5b6404dd-7b33-4960-820e-628eb0de0960@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|IA1PR11MB7248:EE_
x-ms-office365-filtering-correlation-id: 7fccc90f-2a97-4543-aeae-08dd88736740
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aU41U0lORDdKNmtqT0lVVnNZbFRFQm91a1BTWHRRdi8zeE9CdlJJOGhHSllr?=
 =?utf-8?B?WEV4dmVBWHYwTDJHRVFub2s5Y2V6WVhJbDUrdzFRZ3hTUWNmeHFKS2FHTWd6?=
 =?utf-8?B?dEIwODdHK2pLd0lqNzQ2K2M2aTdtL3NoWWhlaXNLV3ZPWm44VWFjNVVOb0FU?=
 =?utf-8?B?cmRWcXBzWVRCcFNNUk5DKzIxb21xTWphVTY5alN2THRCOGxheStZNk03bCtu?=
 =?utf-8?B?b2x6dmJtaGFSYkoxdnRyeko1VStLc1QzSHF5ZmF0ZExTbE4rRno3cTRFVDM0?=
 =?utf-8?B?aVh6Q1BpWThBR1pGekd4clB3Mi93NUpTZE84VGxDZTdsNUZ4OXF5UjFRMm1z?=
 =?utf-8?B?RkhZR0pOMk5ueCtWUzh6R3hmelhtU3FQcjFvSHE0NlRYK1NvMzYzTHRRSGIw?=
 =?utf-8?B?bWFMWHpoZElSb2hDaE1USmY0enl0L2lZYjBoa1dQY2J0cVd2MDZDaUZJQi9M?=
 =?utf-8?B?QUxGeXZWWmk1WWlFbWNkb2VQcnZJV0RQM1E1NU0relpTcjBiRkd2Z2tHY1Fq?=
 =?utf-8?B?b253THJ5c0s4dUtKOU1RNDhJMjVmRThIY3RPTTVuWlI5QXA4c3ZiWjVnL0xE?=
 =?utf-8?B?MExCWWRGSGY5Z0FVV3NkVDNqU05FakIvYUlQa2ZGY3pqVmVQaXdENk5UWVBu?=
 =?utf-8?B?TnV2ckFZMDVYLy85YzNFYnl5RGp6dS81Y0pBOGU5b2pUSlBKOSt4WVh4MVNz?=
 =?utf-8?B?cVhsWW55OUh0RE9TY2VXZjdpY1d4WkJFSEtHM0ZtWkhsb28zZm9pZVJDbDRh?=
 =?utf-8?B?VUZIbkVhZVhwbGlIMCsyb0VQUUtLcHh5aGVjSlYxZTZzUXVMQzJDd1QyeHN1?=
 =?utf-8?B?VmVQWHdYRzYweGZ0NE5aaG5XVGpib2RRS1YyeXVtKytUVm54MzkvTVFteXp2?=
 =?utf-8?B?b1VPQmdBS2V3MkVzaWZ0QWh0QStHSUEvR3c5M1dlVmNIVzRKdGVPR1IxODc5?=
 =?utf-8?B?UzZCL1lmWHlFckQxcHFnSXZUOWRROEM5cUx2ME5hcXhBTFR0VWdHY1BIeTF2?=
 =?utf-8?B?LyszZml1R1dydnFkdHJYZFdnbm1paVVxSFlNZnBNZk4rMHZha1AyUmlvQXNr?=
 =?utf-8?B?a2lFTDBYTGFmZGV6ZThxYWc1R0dpTHFuVzgvQjRUNzM2emRZN0s1UG9hS3Vy?=
 =?utf-8?B?WnNYOUs3ZTFxby95OTNROHB1b21qMFI3K29LanAvKzZHamFWZ2xhcWp6aWRi?=
 =?utf-8?B?UzVyY2MySjlsc3QzT0F4QmYrekRlVkt1ZFJmeUpEdm5Vdmo2b2J0eGVpUity?=
 =?utf-8?B?cmVWZ0FuOWJObzNxb3VjQ1hHRUI4YjBNOUZId2QvTHV4cVl5WllyaWlHMDhZ?=
 =?utf-8?B?K29Db0gvbmtXMnFJRXFCTUlyTDFSQlNNMGRJTW5MS3QwbllkNXh5SVZnYUdP?=
 =?utf-8?B?ZzFycVpVUFBBUHo2d25iMFlKcDU5a29sdDhGcktDS1JyUk9OUklrbTNORzFr?=
 =?utf-8?B?cE5yT0xBK2I5RFJkUTJ1MFZjc3J6cTlBZnpNZXJQTzlKNW5kaUZNbWJ6WXA0?=
 =?utf-8?B?eDFRRWxQTkZaV3pHZWV2MHYvTVlKVW9vVy9laTdFb3JoY0ZTeCtBYmZSSjl5?=
 =?utf-8?B?aXZRWk50b1RVeGFEU2hvNi8wYXp3UmNRalk0Uk5kMUtadW9ka1RTWHZISkls?=
 =?utf-8?B?T1MzYXdPSGRldGdDZkRUejRmMlVPbHdQL0xMKzdxTXI2UGFaRjBuR3BIMkdK?=
 =?utf-8?B?K3BGY1REMTRTNVY5aTJqTUF3bUsvRW5kakhtNVEzbDg0NUlJdExQWWd3Z1Q4?=
 =?utf-8?B?bEFVN292YlczNTJXTXJjbUlWT3hBeXp4VkVrUTdFZkVwTTNkMGFQRXNTZ3Ax?=
 =?utf-8?B?cVQ4cTZYZDhVUEVNSlRDZGFudU92Z3I2VWVUaVBrY3BHU2t5NWtVZ29FaFdS?=
 =?utf-8?B?RUJicE9WLytTUEVzZWMxSkFKRXdGYUtUVGw3WG9NQmRmbnNXOXdhY1NpM0k4?=
 =?utf-8?B?ZnF4dW9DWFpIQnNVQm5lTE9od3pGdFdMZFRwZElqSlBQYjJPWTNCZzBBTEZ2?=
 =?utf-8?B?RTNnWHNYS3BBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjhXQ1VPaHVNTDFZZzI0YU9Gd0hVWnp1eGtJaGJkL25nWENTR2tPMytrNm4r?=
 =?utf-8?B?OWw2Tlp2RlZZVkUvQ0Q4WHpzbUN6Z1hLdVlnS055RjRxb0ZCVGZtd2FjUEc0?=
 =?utf-8?B?L2V5RDdha3Q0R0U5aWVmR2RLdkFmWVdPYTdLQnB1RjExK2NYdTYrQWVFcWdJ?=
 =?utf-8?B?NDB2T2YzbzlwOUxPMTN3ZExUMElTdDRtVTN4cWRoYzNJbWpBOWlxR3JBYzFO?=
 =?utf-8?B?a0lPdW4ybHQxeDdxaWJwYitZY25DazNQeWpZQjFxbWkyRlEzdTYzdFhsQ0lw?=
 =?utf-8?B?ODFQQjJpOS9ZaThob3EwOFRHOXZFdHhKMUZldmszU2RvS3FOQnpZVkk1MGhL?=
 =?utf-8?B?TEYvRi9TQUpCTkJhMjJoL1J4OS94ODBmTldFcmdINk9mT0NkaXh1eHVzN0Rq?=
 =?utf-8?B?aElvMEtSbnJyeWpKTm9vaVI4VUNMUVBsYzZKV2hFRzdxbTFYbGFqWXg5TGZR?=
 =?utf-8?B?NFpZOXZTYVlmbTBOZ0l3a3Bmc1lmemNmLzB4TnpzeDZ5TTByZkpzMnZuNTQ0?=
 =?utf-8?B?K3FEUkF6azV5Tk5sOGo0S2ZYa0lKMjBNeW9nbVJIT09lc2RyL0hFVHVVcC82?=
 =?utf-8?B?aCsrdHFIMERxTThPZEFYM0dMaGt2L0hLRFNnWUthNEcvaENyMm1hNmJwaktO?=
 =?utf-8?B?SFlQTkQ0aVNRcGJBV0JLRGwzaTNhU2RySFNYUHNiRE5USkF6eGlXbDJoZVFS?=
 =?utf-8?B?Q2NQUzNTdnU3cEh6RFJBenJKOHNqVzdJbTFaZFRxcjZMV05OSWNTaHBPNmZs?=
 =?utf-8?B?RkhIVmZYWEhzVDcxVmx4NG5jU0tCK2JDd21tNWlXTzQ1ZGQ3NmlqbTB3RHJw?=
 =?utf-8?B?dlM2aDE1T0FYL2JqVUxPcXRlQzdORFdZcWl5TG5OMk1qY1FIWmJJRStGVUpI?=
 =?utf-8?B?QSs4OHNCS3lnNmh3STFsSVkydngvVHVERS8wTmJReSsrbHN1VEYrWTFhcm40?=
 =?utf-8?B?SDdOTHpnVlNGYlEzcDRSSVpQa1l2VTdrcFlLZ1JqQkNkWkZxaEhtUllLZ3p4?=
 =?utf-8?B?MCtkZ1FndlRxZnFDTHFyejg3SFdVUFA1TFFDZjV3QTNhaU9ZK2RUeUhza0Ex?=
 =?utf-8?B?blBJaEw4RHp5UCtKMndhTHh4TVhsTzBleEFIS2tEWGpuR0huTjBvbGZISUJO?=
 =?utf-8?B?UlFpRWdEYk9SREpvRlRqY2w2RGVubjNydXdVVWM0U25PS2xJaktnTDdPcEFi?=
 =?utf-8?B?cnNKYndYMnExczZ6L1VleVhtNnR6b3pTQ1grUmpCQVk4bW1KRGhzdDNKam5a?=
 =?utf-8?B?WVVQRWxiYytQMW8vUXZscGxoWFdobWtIY1c3Ti91enJibFlLLzh1UXZMYnQy?=
 =?utf-8?B?RzBOdFYycXRWeDh2Yk9YUHZHZTBHRENVdWorZ05hWTczVUhMU3praEdETHg5?=
 =?utf-8?B?SVo1VFdsN3BGVFV1b05nU0pwNk5DZ1FHMUMzTUY5TUpvaThSbjVHaVFFOGxw?=
 =?utf-8?B?a1BHODBUQ0dmWncwWWVBSGw0cCtTUXZnRVluRk8zN2VjNThPTnFKdEszN0xV?=
 =?utf-8?B?Zk1YZjV3aGQvMDNoLzBKZXdxUC84cnEvb2NxNXRDU3hHUVBNMW44MlBjMkh4?=
 =?utf-8?B?czZBR1J2d2R5WkExYW8yckw2N3p6OHZKQjJYbDErQ05YZkdKSEJTUHNHWEQ0?=
 =?utf-8?B?M0tnMTY1VjMxdXRyNkZLV0Evb2IrdEpCUUx1ZGZnQ0ZySWMxQithWGcyV0Z6?=
 =?utf-8?B?NDRuVEFlb0ttbzhMa0RhZjFTVDFCOGRCMVdvQjVaSkVLb1grQWk2OURheWVs?=
 =?utf-8?B?VGRqdHZacE0wd3FQQzE2aHRyR3NUbDArRThKcm0wVUJHWFZYRDZVNjl0RENp?=
 =?utf-8?B?OFpGVWgwbnBlMDFmeFZNQ2V1TDl1ZjlWN3ZuS3lOM20xYlVYR1dJWGlwUzNM?=
 =?utf-8?B?cmVTWXZWTk1OZVRtUlUycjNwN0x5ck1Pak1iMkJLb1lUZVBBVWwvZWVUN2Vj?=
 =?utf-8?B?N2k2WjBGeUdXbG14UXN4emFxYXlYeld0ZjBYNlJ1ckVhOE8vdWIxRlRyaG5o?=
 =?utf-8?B?ekp3K01KTmJ0WVYrR1VkUDVqWFEram1PZ1JYcEwyMzhRYjFQYkZBN1hzNW03?=
 =?utf-8?B?ZzV1dVFEV25uT3JDK05zS2dnY0VkQlA0aW9aaExGOVk4bXZhSmloK3d6d2U1?=
 =?utf-8?Q?wF0tjnL7/HZQq7j5YyjdD07Qa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fccc90f-2a97-4543-aeae-08dd88736740
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 05:45:39.1143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdaTSuyStlUk6LYeK573DqWr4RS7RvxDoPUfE6WfoC+BXC6azWJv9EIucrjNrI2aPZNz58ovC0rXdU7dXWpQwvS/OOFWjyPgAJ6bvF3VPOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7248
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

SGkgRG1pdHJ5LA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNC82XSB1aS9jb25zb2xlLWds
OiBBZGQgYSBoZWxwZXIgdG8gY3JlYXRlIGEgdGV4dHVyZQ0KPiB3aXRoIGxpbmVhciBtZW1vcnkg
bGF5b3V0DQo+IA0KPiBPbiA0LzI5LzI1IDA5OjA4LCBWaXZlayBLYXNpcmVkZHkgd3JvdGU6DQo+
ID4gKyNpZmRlZiBHTF9FWFRfbWVtb3J5X29iamVjdF9mZA0KPiA+ICsgICAgZ2xDcmVhdGVNZW1v
cnlPYmplY3RzRVhUKDEsICZtZW1fb2JqKTsNCj4gPiArICAgIGdsSW1wb3J0TWVtb3J5RmRFWFQo
bWVtX29iaiwgc2l6ZSwNCj4gR0xfSEFORExFX1RZUEVfT1BBUVVFX0ZEX0VYVCwgZmQpOw0KPiA+
ICsgICAgaWYgKGdsR2V0RXJyb3IoKSAhPSBHTF9OT19FUlJPUikgew0KPiA+ICsgICAgICAgIGVy
cm9yX3JlcG9ydCgic3BpY2U6IGNhbm5vdCBpbXBvcnQgbWVtb3J5IG9iamVjdCBmcm9tIGZkIik7
DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiANCj4gZ2xHZXRFcnJvcigpIHJl
dGFpbnMgZXJyb3Igb25jZSBlcnJvciBvY2N1cnJlZC4gQ2FsbGluZyBnbEdldEVycm9yKCkNCj4g
cmV0dXJucyBsYXN0IGVycm9yIGNvZGUgYW5kIGNsZWFycyB0aGUgZXJyb3Igc3RhdGUuIEhlbmNl
IHlvdSBzaG91bGQgYWRkDQo+IGEgZHVtbXkgZ2xHZXRFcnJvcigpIGNhbGwgYmVmb3JlIGdsQ3Jl
YXRlTWVtb3J5T2JqZWN0c0VYVCgpIHRvIGNsZWFyIHRoZQ0KPiBwb3RlbnRpYWwgc3RhbGUgR0wg
ZXJyb3JzLCBvdGhlcndpc2UgeW91ciBjb2RlIHdpbGwgaGFuZGxlIHVucmVsYXRlZCBHTA0KPiBl
cnJvcnMgYW5kIHJlcG9ydCB0aGVtIGFzIG1lbWZkIGltcG9ydCBmYWlsdXJlcy4NClRoYW5rIHlv
dSBmb3IgZXhwbGFpbmluZyBob3cgZ2xHZXRFcnJvcigpIHdvcmtzLiBJJ2xsIGZpeCB0aGlzIGlu
IHRoZSBuZXh0IHZlcnNpb24uDQoNClRoYW5rcywNClZpdmVrDQoNCj4gDQo+IC0tDQo+IEJlc3Qg
cmVnYXJkcywNCj4gRG1pdHJ5DQo=

