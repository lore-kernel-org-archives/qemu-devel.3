Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ED6CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 07:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPF4N-0005yt-Co; Tue, 19 May 2026 03:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wPF4J-0005yX-2q
 for qemu-devel@nongnu.org; Tue, 19 May 2026 03:40:47 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wPF4G-0004bz-OH
 for qemu-devel@nongnu.org; Tue, 19 May 2026 03:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779176445; x=1810712445;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TNkmbohU4kKEHmJfm5gjrsG4KrMPLANSUmhr3Gn0Ul0=;
 b=JA2tj80VB76eZfGHSZTxYs786L9rPIfmzA1OxQDQWMheC9CX0Yvr7CiY
 COuujmnrr17RA46UAtO/OuhSbVUlpqMSrdCGuv/ob3cqiPs9n5BIqn1eS
 OB1GRH1miVdMMR5JjXWMwyqQk5Y5968qvhdXHc+vMFtD+YrZvDTPUMkk1
 fykoBNu7lYi3wVc9PLGWQad70aCPLVqFAMlH2+fw5CUkZrPTpThGOYr5Z
 pPon641wmtjgFJQe0NTUja5rXlYDq+5yGI/hJ2pgx52D3VSI1ZxWIl7Lo
 h5lddcz6lbAmTE8o+47rqkb9olWBRetFiQMsnLfeeLgTBCVtibkShVLll A==;
X-CSE-ConnectionGUID: 5t2Gzv95Q/+X2Ss8IGwYjQ==
X-CSE-MsgGUID: MemN5OFBQ+ucpBFcI9ZP1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="90741236"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="90741236"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 00:40:41 -0700
X-CSE-ConnectionGUID: cqdhYm8yTcmLRxxkVsJUBQ==
X-CSE-MsgGUID: js32a7/iSjyEcW4nEa2fJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="244674181"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 00:40:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 00:40:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 00:40:40 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.1) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 00:40:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTee8/GDGifV5544kSgqCtH8D4htb1Gvkvm9dZRJsyX6XgpkqDvK6bBWTrb7EUd1JPxvtGGw0L7cIGI3JTCVM99TNPIaFmQ7whDiHZ3uCmk5b3H2g6t2Z0mPTXsoagiDF7P6tl3fRENHYuepBH3ILpZLLsR4bZG3nt29gYA6UilpJqWhRT4Kl4c2wIu40a+KEP4K5UbjAUS/AaVYVPhIDbz22mdF0hNT+z+eBjGsOSj6YLw0c45yfosHdB5XLFaz1Suv8236+e7/Hovk4n8pYMpaCY/kHDFVMg1sh2mroeaPCLww4two8Ht9Kp1qKt0w31bNKnruDH9P/V0K/6mviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNkmbohU4kKEHmJfm5gjrsG4KrMPLANSUmhr3Gn0Ul0=;
 b=mTCl5ZL2qS6jKH0kpifsx+w76v3hXtf5IgzZwLc+CSu/EibbwW7OunonVnIeoz7AwEFz0JMnnyPnhshlUxy6CfCQROd6V7c+4kPgW3yeOqEVL0zy7huj0zNUpaTAGwB8CWzK+Cw29rXYoffZcO/achJND9Rg7ed458vwz/MDv5wlLhI93hbLhqkIPWShFPkFX7iLXTWgwpeeYHX30ERDmyCc1TIh0oVFRH5Isrx36qQj2yDXOao99XE/nkjyALvu+MmFV+S3w3BstqaqpTnlT2sGQXtQMuO26LysbSZTWHPW9sdRb876v4a00U+qXczcaSXMUs6E9/foFuRtDsM1rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA3PR11MB7414.namprd11.prod.outlook.com (2603:10b6:806:31c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 07:40:34 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 07:40:34 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>
Subject: RE: [PATCH v5 08/15] intel_iommu: Refactor PASID processing to use
 IOMMU_NO_PASID internally
Thread-Topic: [PATCH v5 08/15] intel_iommu: Refactor PASID processing to use
 IOMMU_NO_PASID internally
Thread-Index: AQHc32mcVP/GY7HLckeIzCovUgMZdLYQVv6AgASuiLA=
Date: Tue, 19 May 2026 07:40:34 +0000
Message-ID: <IA3PR11MB91361E31374E30CC4B948A9C92002@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-9-zhenzhong.duan@intel.com>
 <6b8401f4d86ab69fd8bdb81ffa21a21ca637b74c.camel@bull.com>
In-Reply-To: <6b8401f4d86ab69fd8bdb81ffa21a21ca637b74c.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA3PR11MB7414:EE_
x-ms-office365-filtering-correlation-id: de3a5707-13b9-4d2c-7c13-08deb579e976
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|22082099003|56012099003|11063799003|4143699003;
x-microsoft-antispam-message-info: YWPZlavlxD+t5pLskHPkfnCbs5fwkEW1ALHTQYrPqd9uUcMUkvCiclkWZF7lBmiFkcPpGJvKXWybc+hocBqhfgwDOGevXDBJveCb+n4aaLLM7I9yXMPSP4YV7MPwpzDAZ7DsD6s9v3nHq8sgiWUG5cWZIez0QQnmWERkXzHwDqpZvoMzYTSSTxKOgkZpudN0H1E1bzfOYQHT/IzJFZ9yMVvbxF6bPhKYaA72hkTZr7wIPtyODE/gHph/D1ace6vGDLfBcoQrcxGxqzFsKxcszr2q38SsdGfG9w50EIEKNqp44Q/je2xgp7UxcOLGh3FH+tIqnp0OEALR1FBX2cnaNMSmGW0gQw5NhUWkBwpCinuxEEWdBY1kjmcadkSalvei0gonXKmCblS6Wbx2kwW+Faxjyz7aZgGaY3jD3lTXrPrP+pTBtZp+6jpLQm6fUMDGKdhft1P1OHLXIC61NYRVeo5OOjYSRHIQBcb2XuXboxLtqkULRXGhKJ7RmMoaTllXv2gkr3hivbXmfQzj7U63tmPAzRYc+7w/fBpQzxCRVgeFHL6V0tr3u2x14cu5V9yvKvJWFx1C5z3bC78gu5qvVgGZ44B9YBFiabvdpRAM+JYWELHe0i4Tsi0gECWtSpd7+Nd+5H+ilc0w4x/ITtnpUoZe1ys2yhVub9pin9niko/Lt7G/yJXO7EeAtK/4FiPdLTrQiAqt1WOCI2FSYyeRY4dFn82mN/YogfqdtOEEFbBUgYiq5puPiTx/vpEQdE1+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z25kQVUwSTZHZ1AwaWJSZ3pwODFueVc4N2xWRDdyWFE2akhvZHl6NFI1aGtT?=
 =?utf-8?B?U2VTSDBCcDZIRWtRdndNQmk5WUVtSUNGTWhWSVdlbnkvVzd2NldoQ1hkNHlp?=
 =?utf-8?B?ZFZOcHc4RWlkZzJibGZIdTQzeEthRXowZFptUm9pM3ptc3RSU3ZuZUFzbk9J?=
 =?utf-8?B?WUFTbStSZFMrU1hCSVhCdm9ZWW5qZFhCbDNOZDlmTWphZC9raVNHSCt6MzlC?=
 =?utf-8?B?NWVqeEltaDVSUEpwZlhHK3dGeWEwZU1jcDZjQStZOVdWM1RQZllWWXdDck80?=
 =?utf-8?B?bllQY2VRajBjcEJhKzEwZkFraFdoQXdPdm9CMDRZUlptcmNRVTlZVGI3b3lm?=
 =?utf-8?B?VUNpaUp6ekxUcUVEOTNJdjBHQzNDRVhNK1VXYWdXUGJJSEhPdU5UODB4Z1Zn?=
 =?utf-8?B?NHovV25tbkR5NlErOHhPb1JjcEJJcDBkMERFcnlUeTB5Zkh4WE5DT2NJQ0gy?=
 =?utf-8?B?VHJyWWJiMnMzV2YwQWdZb1h0ZnU0bEZwYm1LbGRPL1ozZU5CRm5jUGlRcWpR?=
 =?utf-8?B?M1VUR25HTk5PS3RZRkJLTVVHQ0N6aExxWHZjaHR1dHJPRWIwRXJEeDhHUEY4?=
 =?utf-8?B?OEVRRUgrai9YOE1FVmZQRnpzN2dlWllvZUlST3cyMGM1ZVZ5WXNFVUkxTmVU?=
 =?utf-8?B?TE1rdkRxZnRyL0FOdHpKZy9LOXRQTEk3RUZBblUwbjFpQnpIQy9aVTBLNDNq?=
 =?utf-8?B?a1RneXAxOVZzaUQzdGJ5M1czREFwUmh4MVhVUStOd3JmbnB1MWFSbUt0VVVl?=
 =?utf-8?B?L0lOSDBycjhPeVI2MFR0VVJNOWUvYWFDS2E2QTR0WWJLYVhyaUY1ZS8vaE1u?=
 =?utf-8?B?eFBmLzkybWtQYVFkNy9QU1BBQ1ZycGM5S0RtenVEUUtZck15M0Rxa3NOcDA0?=
 =?utf-8?B?QkVNODRSSkp0UEQrRWpNR3JLRnVwZE9SYTZoRUdQbi9lUTZiSm1oWXphVndZ?=
 =?utf-8?B?K2VHcXNSL2FFaWUwVE16UVBqd1N4TFV2TXFkZXgzUW1yazRpNERsWkQxSkVB?=
 =?utf-8?B?TTVDVGhkbkRqUFFabkpRU0hBV3FaQ1Q4YWtlMjlYdmtETmRDMENPL0ZnV1da?=
 =?utf-8?B?dUVZLzlKSGpNTjZmWStwbVRUMDF5UWROeU9WRzNwZzBWQ3RFZ1VnVURDRUNF?=
 =?utf-8?B?K1krRlZhQnMyK2NZYm9Ea1A5UmpNSmNLNmNoL2J6RzRnYWhTZmt1RlJiWW5i?=
 =?utf-8?B?c2N0UkRGZHlqd2ZvR2trZHRFeS9GYUJTQ0UvOHNuMFh2WFR4ZjBlNGhaaldw?=
 =?utf-8?B?RlA0WWE4SjZndDRYNjVxMVc5WUVFYkhVdkN1L2dIRVVHaVlZSG96UWM4Tm9D?=
 =?utf-8?B?M0orUGVLY3VrbnhZaFcrWVdPa3pxcGFSUEdoYUZSQzlKN3hzQnZvYmt5MHY4?=
 =?utf-8?B?VXV5QkFSM2VEWnFqcGJsNFMreWlVaDZwakh2ci9IdTZEdFJoMkdWc1M0aUE5?=
 =?utf-8?B?ZmNDYVo0c1Q3dXdXQlE0SUpGYzNhbmthOUFWQ0w5UXNNUktaRnhRc3Q3Y2FS?=
 =?utf-8?B?Uzh5SnYxZGFKdUFjYXZvak5NVWljNCtCYUF3QU1MOXdZTGlvM0FPZWphRVZw?=
 =?utf-8?B?WDJWYkF1TjNRUjlSZlAxOG9pNTVOOVJvaHpvckZYem0yWVhVeFZuMDJtWmUw?=
 =?utf-8?B?MitoS3RIOE9mRmFON25lMkp5MXFCL0FYSmJBc0NNRUR5MW5FNzc0YmZMR1Fh?=
 =?utf-8?B?V0VLMjdBYmh0UUtKdHNBb255TE8wdU5hejIvQklQQlpsL25nZUhkSk1rcVlC?=
 =?utf-8?B?NmdPanh3cVE1cHRKWGdTaEZPeVFrNFNQMXFMdGN2OEJMMDI5VTIrVytMUUR5?=
 =?utf-8?B?a3V4UEt0S1VvWG9LcXNQQitiNzgwdmlPcjNrZE9wOWhGWmNuVlI3NHkwUWUz?=
 =?utf-8?B?K2xMMUxvaTBRYWRHQ1BMc3dxR1hMNE41ZEo0VC9GTENvRFd1WHNmRGI0Ym9p?=
 =?utf-8?B?SFZXRjlQN1F2S1FTVXZzcW9DbmhvdThBbjVwbXVaODJsdS9BUWo5S25udFR1?=
 =?utf-8?B?ZWlWWTRrRWErL0FscGNJdVd4ODJ1c2thU0Z4QmxRRC9GekFCM2tCdE5kSjNK?=
 =?utf-8?B?UndsTS90aFpXcnB4ZEI5aWNPOFhHVjF1V0RTZm5VWm5NbVBHZ0kxVDBXc1cy?=
 =?utf-8?B?alNKU0tJbEx3UlY0TURlZ3ZkVmRrY1RSbjlvVllrL0M1SEJ6OUwrRy9iR21R?=
 =?utf-8?B?eEFzbFZBYW9PMGVWbmQzUXh5UTI1UnBMSUlIcG1PL25UVGhRWUVtTDB2MDZH?=
 =?utf-8?B?VFBVb0VNeU1EaVQxQ2RBQ2x1VEV2eGpsTEtxT1ptUG9GMVlOalFrWnc2NDUy?=
 =?utf-8?B?SkdQTmxINGNtTEdNbXkxMm9mbGxmSUc1YVFaSkw4Ykh1dG9EZnUvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YRki6DAwAf9OoHdkyGIYca7jxhMESNwCFGDT/QGtRUfa4grMeiizn6yTU/F6Z9lcUhby4TSszIuiP67WNOnf1S4cBqdEf7BtVjjwRJ2m9DwIie68lNjdpHUHwiUznTJywpISXgkltY4ug+LH/2yZTHNvcndzSMEZTwMEbUgEfSxwwVSHaOq5gnCAZx4+8lMs0GZ+Cql6sQySgNHp//+QOBMIAZ45NiWK3sA8N/OBAmZWVQ44klPRCtYVHejccZswCsy7z3CjIE5GK1M4Ct28K/PKUjFlTrSnghl5N3W2aOby2zKy8XTX/kRYg/bT/wHzUVtB7j6QEFQZ4OIJXCTDKA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3a5707-13b9-4d2c-7c13-08deb579e976
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 07:40:34.4734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VDb0igSBXCrCCKPUguXMmw4hMN2y+feeUp4KEOKiwfTtpzUF8q105hfRopKERYA2cCXyyIKdPjP5BeD5+CYEYJ4UyfgW43MXyWmsrJ3wVTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7414
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
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

Pj4gQEAgLTQ0ODgsNyArNDQ3MSw2IEBAIHN0YXRpYyBNZW1UeFJlc3VsdCB2dGRfbWVtX2lyX3dy
aXRlKHZvaWQgKm9wYXF1ZSwNCj5od2FkZHIgYWRkciwNCj4+IMKgwqDCoMKgIGludCByZXQgPSAw
Ow0KPj4gwqDCoMKgwqAgTVNJTWVzc2FnZSBmcm9tID0ge30sIHRvID0ge307DQo+PiDCoMKgwqDC
oCB1aW50MTZfdCBzaWQgPSBYODZfSU9NTVVfU0lEX0lOVkFMSUQ7DQo+PiAtwqDCoMKgIHVpbnQz
Ml90IHBhc2lkOw0KPj4NCj4+IMKgwqDCoMKgIGZyb20uYWRkcmVzcyA9ICh1aW50NjRfdCkgYWRk
ciArIFZURF9JTlRFUlJVUFRfQUREUl9GSVJTVDsNCj4+IMKgwqDCoMKgIGZyb20uZGF0YSA9ICh1
aW50MzJfdCkgdmFsdWU7DQo+PiBAQCAtNDQ5NiwxMSArNDQ3OCwxMSBAQCBzdGF0aWMgTWVtVHhS
ZXN1bHQgdnRkX21lbV9pcl93cml0ZSh2b2lkDQo+Km9wYXF1ZSwgaHdhZGRyIGFkZHIsDQo+PiDC
oMKgwqDCoCBpZiAoIWF0dHJzLnVuc3BlY2lmaWVkKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgIC8q
IFdlIGhhdmUgZXhwbGljaXQgU291cmNlIElEICovDQo+PiDCoMKgwqDCoMKgwqDCoMKgIHNpZCA9
IGF0dHJzLnJlcXVlc3Rlcl9pZDsNCj4+IC3CoMKgwqDCoMKgwqDCoCBwYXNpZCA9IGF0dHJzLnBp
ZCAhPSAwID8gYXR0cnMucGlkIDogUENJX05PX1BBU0lEOw0KPg0KPkFyZSB3ZSByZWx5aW5nIG9u
IHRoZSBmYWN0IHRoYXQgSU9NTVVfTk9fUEFTSUQgaXMgMD8NCj5NYXliZSB3ZSBjb3VsZCBhZGQg
YSBjb21tZW50L2Fzc2VydCBhYm91dCB0aGF0Pw0KDQpZZXMsIHdpbGwgYWRkIGJlbG93IHRvIHBy
ZXZlbnQgYW55b25lIGNoYW5naW5nIGl0cyB2YWx1ZS4NCg0KLS0tIGEvaW5jbHVkZS9ody9jb3Jl
L2lvbW11LmgNCisrKyBiL2luY2x1ZGUvaHcvY29yZS9pb21tdS5oDQpAQCAtNDEsNiArNDEsMTAg
QEAgZW51bSBob3N0X2lvbW11X3F1aXJrcyB7DQogICAgIEhPU1RfSU9NTVVfUVVJUktfTkVTVElO
R19QQVJFTlRfQllQQVNTX1JPID0gQklUX1VMTCgwKSwNCiB9Ow0KDQorLyoNCisgKiBWYWx1ZSAw
IGlzIHNoYXJlZCBiZXR3ZWVuIGtlcm5lbCBhbmQgUUVNVSBmb3IgSU9NTVVfTk9fUEFTSUQsIHNv
IG5ldmVyDQorICogY2hhbmdlIGl0DQorICovDQogI2RlZmluZSBJT01NVV9OT19QQVNJRCAwDQoN
ClRoYW5rcw0KWmhlbnpob25nDQoNCg==

