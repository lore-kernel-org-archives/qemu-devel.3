Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542D4C3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 05:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAMkY-0002dJ-I0; Thu, 01 May 2025 01:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uAMk9-0002Zz-9Y
 for qemu-devel@nongnu.org; Thu, 01 May 2025 01:46:04 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uAMk6-000199-Lu
 for qemu-devel@nongnu.org; Thu, 01 May 2025 01:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746078354; x=1777614354;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cZyReNsnN+QkRlMgUFkWxJWnTAQ2yrMKve+EmpF9BKk=;
 b=C+EE7AliuMtvgPGmO03sj/fLJHdICOS1g1jT9BZWZnu6mcPEjFOGOwXV
 cj4VbD3WuhoRJWU4+HpCBAkS4ciK3yO/kGJNFqFC2+Aek5dA1BzXX9s2H
 qlE8/afA9YUUyp3tg1+Ez/gx0mHmIPUcJ+XFLevKUU66jpbn8VJeEq6A0
 NCFFja7Xh1eKqod/UOskCNa5cO6dkBRFWGKwRpXNzqKs/i4+PXN5Ry/cu
 U+3mdQUvWz4wvuQgZBbYHyZGK7SIFL8CUJByVNxEFFVGaKs6HR8IL0ClG
 NtFFdLOZA9d7YbxTvJkezDL56FNgD8fA+o+iKHSCGS/cb+KlD5rs3n7Ub w==;
X-CSE-ConnectionGUID: ajBQvACOSP6vANI4ehTDlA==
X-CSE-MsgGUID: gD2fs4Y5SyuIAEByZdYm9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="47887623"
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; d="scan'208";a="47887623"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2025 22:45:49 -0700
X-CSE-ConnectionGUID: /GMoINqhQpq2CM4iYaMUHg==
X-CSE-MsgGUID: 1LLDc9hjS52+uNJJkDMEtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,253,1739865600"; d="scan'208";a="135284108"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2025 22:45:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 22:45:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 22:45:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 22:45:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpwjLxKrzTkKUo7L5SsolAZAKo9h4D4WL7GekHZHPi+z4mZPWXejrQ2/mrN8z4EhdaWHAaXRYlb1UUR842giWvoV256PaOwWRtkkklktjE9xlNjp8HlMnrdwnyCHnZDCtsbVwEJlVnjN41dwI8WaoEUBjq9w8sJYB29R8/dmGkAGVqZlnw1P/fhxf93nOC5GtMFsboc38dho39d6xeQoorGx8frkZ7Btqd7lhtkthlA5wODaCTG2D+1MIwGUnmKGAPd57pxOzhxAAI1zvV+ZuilmnI704myMm7X1FPHwkMo8W5Q1LdJodt5Joas5aDwB48QZWLfELQ3yUWzelUwxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZyReNsnN+QkRlMgUFkWxJWnTAQ2yrMKve+EmpF9BKk=;
 b=NUkygZyfq6lbQe9JQMgOExom4XukAN/b1kCJTPChQv1DtKTugYowioasbAuwl19zFHsFyvJd48YoOVfFT01KjW5XqfVGZub3VC91lEJO7WwOdKHINx6W2pThMHJR+wB/8gI6KMCKbdywlGuUGmYoca2UxzJgc9Y76nMOjuF2R++T6eii1WduNRAqqvHHhZB3Y6ymOhK5C1Y0qFX7xKdi67eVxDqDHqla8hNLkaVOTzvNx+xjn7U668VqjjZcY6CUCxGlTBtL4RMxT+IR91Z/om6bVGvTPhAtjunhoJSaC738PR7ZLWG9akfl4ddZjS2JUCRJiFrHESoW9IAokKgzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 05:45:02 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.8678.028; Thu, 1 May 2025
 05:45:02 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, "Kim, Dongwon" <dongwon.kim@intel.com>
Subject: RE: [PATCH v3 4/6] ui/console-gl: Add a helper to create a texture
 with linear memory layout
Thread-Topic: [PATCH v3 4/6] ui/console-gl: Add a helper to create a texture
 with linear memory layout
Thread-Index: AQHbuM2vJGY9cDV2T0CKHHxp48RlbrO6QeeAgAEJM8A=
Date: Thu, 1 May 2025 05:45:01 +0000
Message-ID: <IA0PR11MB7185489E4CFF628C94522C3DF8822@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250429060952.59508-1-vivek.kasireddy@intel.com>
 <20250429060952.59508-5-vivek.kasireddy@intel.com>
 <CAJ+F1CJEJW_MaBCBc0Ybua8tuaa4oBWLtVVCernz+6LvsfhmGA@mail.gmail.com>
In-Reply-To: <CAJ+F1CJEJW_MaBCBc0Ybua8tuaa4oBWLtVVCernz+6LvsfhmGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|IA1PR11MB7248:EE_
x-ms-office365-filtering-correlation-id: 184d5f6f-8630-41f8-eee4-08dd88735121
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MkxyRFZmWC9EcXNZKzJ5amdlUXlqMTNLWEtBMUtHR3VmMU80eU4wUlUvakE2?=
 =?utf-8?B?VTN0TzZ1aVNobjZqWTVvakdGa1hvSjFtUUNTYVg3OWIreDdGSkR0YnlmbDlC?=
 =?utf-8?B?QUF4bmtiaTQ5VGw2cktYdk1kMXpSY2RHTFg5ODhERU1DSFN2d0crVStLYTRr?=
 =?utf-8?B?NnV1L3ZyaUk4Z2dZS3JSemI1TU53VTFsRnp3ZDV6VHd2b2VBejlDYWtyUzB1?=
 =?utf-8?B?RlZ1UnpzV2JaSGJvSmExcjd6YVljWncySHY4Z2I3N054Zno3MWhBTG5RV0o2?=
 =?utf-8?B?WVNRM1hTN2ovTW00SEdwdWZlNFdBL0tkVFhWb3NWN1Z1VTA4cGRBNXlxRGZF?=
 =?utf-8?B?NFNURkNUV1ZkVjZHS1RZcE92NW5iOXNzUHc2eTY4akl1M3BuZmVJUENkc3My?=
 =?utf-8?B?WnRFbEdUTURBZzBINEtEemV2YzNjMTRBN010MU8reEZxaDlFZUF0RVY5S0JC?=
 =?utf-8?B?T3U5MkpITXBFaUpiZlhuSitsLzVDMWxIRTE0OStrWDQzWnNLbFFNWEE2QkhE?=
 =?utf-8?B?UnBJWms4NDF0MXRZdkJvOFkwblZ5eFBtdzd3Y1g3bzkvT2M5MmxtMHUvbWF5?=
 =?utf-8?B?b3lQN0tObDdOV1RqTFE4SGxnSy9JcjQwSEdjWDVDcGlkMjU5ZG1HZDA5SFhq?=
 =?utf-8?B?azVKTk1SbFJnUUtTdmJIdU05T3ViV3lhOGVKYlJBTzJIcGZRQjFFeWZSZXov?=
 =?utf-8?B?cDJHdjBrSGZUWkduUGhwMXhjd2ppcC9EMXlzYTZUQ3ZFZWxGRGF5TWExUEx3?=
 =?utf-8?B?TEJoc0w2V21OY0VaRm5JYUtxVk0yaC9EWnNXYkIrTDZwbnRGYTJDOS90OTda?=
 =?utf-8?B?V2NqSHFGUHdtWE93eWE1bUI2ZlRGdXJrY0cvZlBjTFhucm9ONDFvOVU0NFpi?=
 =?utf-8?B?cmh6bGgybzNlVzFVRzlIdXNIcWNNVmxMTVU5V2ZDM1NjcEo3MWxaaWtNT0tt?=
 =?utf-8?B?ZEpaeElDOFJqSkJWK21YUGVRa2VJNGNUeFhCNzluWVJWZ0FUeTc3ZGFUUmd4?=
 =?utf-8?B?UkRHZkt3OEVGZFVjRDJ0aVEzRFFMSTc3VkFQV3Z3L0lLTDRvSUdnNmNtZ3F2?=
 =?utf-8?B?VHU1TG5ibmg4T0haaFZIYmF3cmg2clVvVFJ6UktHSEV3SVV5NFZ0VlE0ZUxU?=
 =?utf-8?B?bHF4a3F4RWZUTjNZQTYwZmxNZTV4THpDUkJsaU45cEovTnVxeDBDQVhaR0M0?=
 =?utf-8?B?OHc3M1REeFkyUEdKcmpjOGhBNFdnWEpTMm1UMm92SFRhNDIrVU1BNFhxeG9p?=
 =?utf-8?B?L3lBbXBvM3ZSZmd0bXBOTTdlVVBDdWdsMFpTRVJWcjhBNVpEYzFqbm95NHVY?=
 =?utf-8?B?MUJIdzBybWRTa0t0SnplQzhoUGQ1ZDJFTVFkUGR4V0NaV28yOXVrWjhFYTJQ?=
 =?utf-8?B?Y3BVZ2d2SHU4eFF4eTNSaWd4cW5TVzNnTUo4K1ZqRTZ5RjZjZ000SjNMNk5D?=
 =?utf-8?B?emFPbHV1Z0xUdUEwVHIvNDRDVGZWVWgrbXBQamNJZnZ1TCtVWEdTRVZYWith?=
 =?utf-8?B?cXFQOFYrMjk2Q1M0a01tczN1d3hvZ2wreUQzNEozZEdrdXNlb0ZKa3BXeld6?=
 =?utf-8?B?bWxncnRrOWx3OVkxOCtZNGp4Z1p4NGpaSUZxN1UxVldjYXc3YXFrOVhXL2NR?=
 =?utf-8?B?TUFrZmMrMEpjK29sbnAwWURKSmFidW1Ia1BycXRqelhZZFZ4cW9DVGpRUEZP?=
 =?utf-8?B?K2ZtelBEWSs0ZEVQR2psTHpIZEszRzJ1SGdYdGYzWHU1Q0pLMDJWUTJwMlJq?=
 =?utf-8?B?eE9UVUNNOWQweUtRYzZGMTVuZ3ZaajYvMVJZNDZENkxpU25ERUR4QkFNQlNj?=
 =?utf-8?B?TXVVU1loczk5L1JMQkdKb3hFRVVYNlFPd3B2RUtDWXRhM0w0bS90bzNRNzU2?=
 =?utf-8?B?MldKdkNFZzd6ZSt2TjFpV01KWkVjU3NzcFN4YUZPMG1raHV4bVJXMlpLNXNU?=
 =?utf-8?B?N1YyWlhzWE9Kb1ZHeE0zTVhyNVpONDhSZjVlSmtLSk9LOHA0aG5RUFdkZGtN?=
 =?utf-8?B?WGw1eEcxcTdnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0xCUUQwQlFqWjFsMjduREtIVEJWZkJQOUVpL0NETXVJdEh6WWtERmtVQS9X?=
 =?utf-8?B?RkQxZHFFbUZWQlRSUjZkZG5aWFkvQXdjSkVvUTlPNHMwMnpCRjNHWFE0WVpU?=
 =?utf-8?B?S3VaSzQ5OXdUbnR4cmFxb1VJbUVNQ0FUU25SQ0crNVlSeVUxOGRhQkhHRXJ3?=
 =?utf-8?B?b2lwdnN2bUZ4NVRrbmlVMHk3Q3p1cWxLb3MzTC9VaHlkditBRmE5TG5LdFdt?=
 =?utf-8?B?VHhLS0hNb3VVTHRQVzRQQ0tkR2FaTkYvZTdsUTB5RWpYNFBkV29GWGVmdUdl?=
 =?utf-8?B?Nm5USWcvR3RNYVhuMDAxamNFb1loMkQyMGlmcFhYdlM4YVhHV05kMFVPNytz?=
 =?utf-8?B?U1pOd3hQMmlBOFhLeTc2SW9pVGVLb2FZNE1HcEk0OFErcXFYMkZmVG1QUzdn?=
 =?utf-8?B?VUxERHFWaEZEdnBZNmpMRGJoYkZ6RlJ6V2pqU3pPeURKMzNPYitoRU10d002?=
 =?utf-8?B?UG0ydlJjeEhLZDlLakswUFpBREtVVkk2Tm14NHlNOTZjRk84b0ppUUxnNS9u?=
 =?utf-8?B?Zm50SGJmamM1WjNPU291R3JFUHNVQjhnTWg4ZUZKeTl5MkJndWtIOHVtRzdj?=
 =?utf-8?B?ZDhvRlpMMUF3QUMwUmVVUVNCd2ZqQW83cjhRbm4rdEJIUzltOEZrVnU1TVhU?=
 =?utf-8?B?L3duRFJHMjFWSFViRWloRjA4NHdqbVpaZlhhQW1rWUVTUzN2alVnTmZJZWMw?=
 =?utf-8?B?UVFzRzhpRUZVQlZYSnpnNDR1SDFSYzd6cW50N3JJUnI1QkRWVWc4YzhOZ2FN?=
 =?utf-8?B?UWF3aUkvdXlWdGxXcitQK2NObDM5WGlkazIxdEE5ZnlkQmlQVjNZU0s1M3pq?=
 =?utf-8?B?TEs0TGlWVVpoMndLTFlRUzVKbFAxQWRSNnBnYmZKVkpMczQwOFNEOEthSlox?=
 =?utf-8?B?UFZQVStmWEN1Tm5iZE5lN2xWQS82dUo5WmRCWlZod2pOVERzVThvQWxMSlov?=
 =?utf-8?B?akZUdDJDUGF0OXJMbUpGNkZ3RVhFK0F1UkNWNGdDTDU2QkRuTHBEYVF6MEV0?=
 =?utf-8?B?WWUxemdPQTAyaytlUDNLdHc0TUlmR1p5N0xuanZoT2grT2hZZko1dlVaMTFI?=
 =?utf-8?B?MUJGcUZ4YldHNE5ienFSRXA4K2xLUjVtWDluN3V3dlFwNUZjRHEraVF4bk5T?=
 =?utf-8?B?NlNpQ1dhc2dpVHo3cmJUcjRzN1ozaUxQQU5Qcmw4a1V1ZnNXNkY2SDN3T1BG?=
 =?utf-8?B?SkN5ZkRTd1FLOC81SzZ6VUhLZWQ2TldsRWNpZ3dVc3c2K2t3WXlUWkhhRy9T?=
 =?utf-8?B?VmlrMjk0WUh3c2kxUjhjS3NobjBDd2Q4cUJWN0JXeklqQzhqcGVLQklyanZS?=
 =?utf-8?B?N1E0WVpQWUI0eDcvKzRCbFhsUmVJVEVnTU9YdHUwaWIxR1F5S1FCZUdaZjAr?=
 =?utf-8?B?ald1c1FiQ2VmZ1VSU1U1TEU3WGM2UFh2c2tQRjBxRXFtbGNXNGlMcWtWOEFn?=
 =?utf-8?B?bmxRN0tFQnNlSVJrT2R0TjUvT25ucGxEZ1YvUDd0Tmd1YWI4SlpkbXJ5WXUr?=
 =?utf-8?B?c1RLU0JxOUVhcGN1U2NGSnZPVTV1b0RsZ1g0c1p5S1p3d2FCei9PeTVQL2Z2?=
 =?utf-8?B?WnhPd05KNEdxSGcxUmlobEJTRjlkd0NvVysvaGE5dC9mMzFnODFMTnBaZXFn?=
 =?utf-8?B?UUFRSTQ3V0Y4b1g0WjZRVEVqdkV3MExpQWw2UmtWQitnVmo0aW1MdWVhYnMw?=
 =?utf-8?B?L3dwVVBIRkljUVZrSlJrMnNlODAvekdnTFd6WUdhVjRuVjlYYWdlSnpqekpP?=
 =?utf-8?B?WWhzVEhDcXlzTlNrTlFvR3FYbFlJVlNjNStBYzVRZTI0UTcxWUVmeFo1cXFp?=
 =?utf-8?B?VXBIVC9IazdBQUJiT1pEUWxvMEU1dU1WbEIxZHY0cm1kSWxqcTltWlBxTU5w?=
 =?utf-8?B?bUlkY0I3SFIzZ1NjUWVkOEFnZWxiV3VtKzdjRk4rUzkwQUNFQm5GdDFXUWto?=
 =?utf-8?B?ZnFhTVdyTk8yamUvdnhoL3JFaDhDTTN2Yld5QUZqTzdmaGI5eUQ4eENkNnF0?=
 =?utf-8?B?U2RJWm5IRjFFSWNtNGxyZmVzNytXS1lVSUhjMTVjWjlZRG9yNE9VNG9TVjVK?=
 =?utf-8?B?RlpubUQ0cjQ0T0NKbHJuY3RFb2NtUC9TN2lFWVp6M1pNNm9zYjF4V3hjN1VI?=
 =?utf-8?Q?OoCgilr939uGkyl3VIIo6jDfn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184d5f6f-8630-41f8-eee4-08dd88735121
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2025 05:45:02.0116 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YxRuBfVRd+A9TEzeizcSSSDAZW2mfng+ApzNf1MmG7EP3oN4iZ6wrM/5scXOVZP97uKTmZ5/OJldnOXXWnqvI4NE2fxXS7Z6oUPGTq5YhoE=
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

SGkgTWFyYy1BbmRyZSwNCg0KPiANCj4gT24gVHVlLCBBcHIgMjksIDIwMjUgYXQgMTA6MTTigK9B
TSBWaXZlayBLYXNpcmVkZHkNCj4gPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gVGhlcmUgYXJlIGNhc2VzIHdoZXJlIHdlIGRvIG5vdCB3YW50IHRoZSBtZW1vcnkg
bGF5b3V0IG9mIGEgdGV4dHVyZSB0bw0KPiA+IGJlIHRpbGVkIGFzIHRoZSBjb21wb25lbnQgcHJv
Y2Vzc2luZyB0aGUgdGV4dHVyZSB3b3VsZCBub3Qga25vdyBob3cgdG8NCj4gPiBkZS10aWxlIGVp
dGhlciB2aWEgc29mdHdhcmUgb3IgaGFyZHdhcmUuIFRoZXJlZm9yZSwgZW5zdXJpbmcgdGhhdCB0
aGUNCj4gPiBtZW1vcnkgYmFja2luZyB0aGUgdGV4dHVyZSBoYXMgYSBsaW5lYXIgbGF5b3V0IGlz
IGFic29sdXRlbHkgbmVjZXNzYXJ5DQo+ID4gaW4gdGhlc2Ugc2l0dWF0aW9ucy4NCj4gPg0KPiA+
IENjOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4NCj4gPiBDYzogTWFyYy1BbmRy
w6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+DQo+ID4gQ2M6IERtaXRyeSBP
c2lwZW5rbyA8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+DQo+ID4gQ2M6IEZyZWRpYW5v
IFppZ2xpbyA8ZnJlZGR5NzdAZ21haWwuY29tPg0KPiA+IENjOiBEb25nd29uIEtpbSA8ZG9uZ3dv
bi5raW1AaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZpdmVrIEthc2lyZWRkeSA8dml2
ZWsua2FzaXJlZGR5QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS91aS9jb25zb2xl
LmggfCAgMiArKw0KPiA+ICB1aS9jb25zb2xlLWdsLmMgICAgICB8IDI4ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91aS9jb25zb2xlLmggYi9pbmNsdWRlL3VpL2Nv
bnNvbGUuaA0KPiA+IGluZGV4IDQ2YjMxMjgxODUuLmZhMmRkNTNlMmUgMTAwNjQ0DQo+ID4gLS0t
IGEvaW5jbHVkZS91aS9jb25zb2xlLmgNCj4gPiArKysgYi9pbmNsdWRlL3VpL2NvbnNvbGUuaA0K
PiA+IEBAIC00MjIsNiArNDIyLDggQEAgYm9vbA0KPiBjb25zb2xlX2dsX2NoZWNrX2Zvcm1hdChE
aXNwbGF5Q2hhbmdlTGlzdGVuZXIgKmRjbCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBwaXhtYW5fZm9ybWF0X2NvZGVfdCBmb3JtYXQpOw0KPiA+ICB2b2lkIHN1cmZhY2VfZ2xf
Y3JlYXRlX3RleHR1cmUoUWVtdUdMU2hhZGVyICpnbHMsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBEaXNwbGF5U3VyZmFjZSAqc3VyZmFjZSk7DQo+ID4gK3ZvaWQgc3VyZmFj
ZV9nbF9jcmVhdGVfdGV4dHVyZV9mcm9tX2ZkKERpc3BsYXlTdXJmYWNlICpzdXJmYWNlLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgZmQsIEdMdWludCAq
dGV4dHVyZSk7DQo+ID4gIHZvaWQgc3VyZmFjZV9nbF91cGRhdGVfdGV4dHVyZShRZW11R0xTaGFk
ZXIgKmdscywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERpc3BsYXlTdXJm
YWNlICpzdXJmYWNlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHgs
IGludCB5LCBpbnQgdywgaW50IGgpOw0KPiA+IGRpZmYgLS1naXQgYS91aS9jb25zb2xlLWdsLmMg
Yi91aS9jb25zb2xlLWdsLmMNCj4gPiBpbmRleCAxMDNiOTU0MDE3Li5mODMwMTJmZWQ0IDEwMDY0
NA0KPiA+IC0tLSBhL3VpL2NvbnNvbGUtZ2wuYw0KPiA+ICsrKyBiL3VpL2NvbnNvbGUtZ2wuYw0K
PiA+IEBAIC0yNSw2ICsyNSw3IEBADQo+ID4gICAqIFRIRSBTT0ZUV0FSRS4NCj4gPiAgICovDQo+
ID4gICNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+ID4gKyNpbmNsdWRlICJxZW11L2Vycm9yLXJl
cG9ydC5oIg0KPiA+ICAjaW5jbHVkZSAidWkvY29uc29sZS5oIg0KPiA+ICAjaW5jbHVkZSAidWkv
c2hhZGVyLmgiDQo+ID4NCj4gPiBAQCAtOTYsNiArOTcsMzMgQEAgdm9pZCBzdXJmYWNlX2dsX2Ny
ZWF0ZV90ZXh0dXJlKFFlbXVHTFNoYWRlciAqZ2xzLA0KPiA+ICAgICAgZ2xUZXhQYXJhbWV0ZXJp
KEdMX1RFWFRVUkVfMkQsIEdMX1RFWFRVUkVfTUlOX0ZJTFRFUiwNCj4gR0xfTElORUFSKTsNCj4g
PiAgfQ0KPiA+DQo+ID4gK3ZvaWQgc3VyZmFjZV9nbF9jcmVhdGVfdGV4dHVyZV9mcm9tX2ZkKERp
c3BsYXlTdXJmYWNlICpzdXJmYWNlLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpbnQgZmQsIEdMdWludCAqdGV4dHVyZSkNCj4gPiArew0KPiA+ICsgICAgdW5z
aWduZWQgbG9uZyBzaXplID0gc3VyZmFjZV9zdHJpZGUoc3VyZmFjZSkgKiBzdXJmYWNlX2hlaWdo
dChzdXJmYWNlKTsNCj4gPiArICAgIEdMdWludCBtZW1fb2JqOw0KPiA+ICsNCj4gPiArICAgIGlm
ICghZXBveHlfaGFzX2dsX2V4dGVuc2lvbigiR0xfRVhUX21lbW9yeV9vYmplY3QiKSB8fA0KPiA+
ICsgICAgICAgICFlcG94eV9oYXNfZ2xfZXh0ZW5zaW9uKCJHTF9FWFRfbWVtb3J5X29iamVjdF9m
ZCIpKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArI2lm
ZGVmIEdMX0VYVF9tZW1vcnlfb2JqZWN0X2ZkDQo+ID4gKyAgICBnbENyZWF0ZU1lbW9yeU9iamVj
dHNFWFQoMSwgJm1lbV9vYmopOw0KPiA+ICsgICAgZ2xJbXBvcnRNZW1vcnlGZEVYVChtZW1fb2Jq
LCBzaXplLA0KPiBHTF9IQU5ETEVfVFlQRV9PUEFRVUVfRkRfRVhULCBmZCk7DQo+ID4gKyAgICBp
ZiAoZ2xHZXRFcnJvcigpICE9IEdMX05PX0VSUk9SKSB7DQo+ID4gKyAgICAgICAgZXJyb3JfcmVw
b3J0KCJzcGljZTogY2Fubm90IGltcG9ydCBtZW1vcnkgb2JqZWN0IGZyb20gZmQiKTsNCj4gPiAr
ICAgICAgICByZXR1cm47DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgZ2xHZW5UZXh0dXJl
cygxLCB0ZXh0dXJlKTsNCj4gPiArICAgIGdsQmluZFRleHR1cmUoR0xfVEVYVFVSRV8yRCwgKnRl
eHR1cmUpOw0KPiA+ICsgICAgZ2xUZXhQYXJhbWV0ZXJpKEdMX1RFWFRVUkVfMkQsIEdMX1RFWFRV
UkVfVElMSU5HX0VYVCwNCj4gR0xfTElORUFSX1RJTElOR19FWFQpOw0KPiA+ICsgICAgZ2xUZXhT
dG9yYWdlTWVtMkRFWFQoR0xfVEVYVFVSRV8yRCwgMSwgR0xfUkdCQTgsDQo+IHN1cmZhY2Vfd2lk
dGgoc3VyZmFjZSksDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICBzdXJmYWNlX2hlaWdo
dChzdXJmYWNlKSwgbWVtX29iaiwgMCk7DQo+ID4gKyNlbmRpZg0KPiANCj4gSSBzdWdnZXN0IG1h
a2luZyB0aGUgZnVuY3Rpb24gcmV0dXJuIGEgImJvb2wiIGZvciBzdWNjZXNzLiByZXR1cm4NCj4g
KnRleHR1cmUgPiAwICYmIGdsR2V0RXJyb3IoKSA9PSBHTF9OT19FUlJPUiAgZm9yIGV4YW1wbGUu
DQpTdXJlLCB3aWxsIGRvIHRoYXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLA0KVml2
ZWsNCg0KPiANCj4gPiArfQ0KPiA+ICsNCj4gPiAgdm9pZCBzdXJmYWNlX2dsX3VwZGF0ZV90ZXh0
dXJlKFFlbXVHTFNoYWRlciAqZ2xzLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRGlzcGxheVN1cmZhY2UgKnN1cmZhY2UsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnQgeCwgaW50IHksIGludCB3LCBpbnQgaCkNCj4gPiAtLQ0KPiA+IDIuNDkuMA0K
PiA+DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBNYXJjLUFuZHLDqSBMdXJlYXUNCg==

