Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6385EC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 10:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ9Xn-0001h5-I9; Mon, 17 Jun 2024 06:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sJ9Xk-0001gn-W0
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:24:57 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sJ9Xi-00005J-3j
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 06:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718619894; x=1750155894;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=D8rvy/8VbKymtR0Va8J9HurmHX5NmsPx9Cp2vmkHVAg=;
 b=ktl1wfwQYn41uof1Upu4Qtl0bi3D4OBi8vTQBdR+U4S+dfNDvTK2EtCA
 MZ0cmQrkFKe/RJTtN8hYLp1MILctFYogbxaBnkMj9KuLEji5Htsi07yMf
 rvU2U1eT4QVk6/ojj/aTa+tOkYOdFvTW7LvrJ5Sk17RkSMCQt6/kKbnJ4
 gyrdSRBWeBGorGZnS/nH+cGYSex7p6bzD/QIcv05lN3SB9jjldj45PB3n
 VKyYw2p4W0+v0tUFI9wEcPrZtWwfAq7vhmEgtoVVf2DfiZq1Jxte4/97+
 GYqTN9lG4Z82k+mOzqmxZDZ/pMl2TsZ+LFK1WSF6dBFz6q4f2Zt++oUz/ A==;
X-CSE-ConnectionGUID: K7ABxM6fRNa7etC3ODVUrw==
X-CSE-MsgGUID: xK/LaiBdT5acmaz3HU3F8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="15209295"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; d="scan'208";a="15209295"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2024 03:24:51 -0700
X-CSE-ConnectionGUID: K6vt3PXQT9mORxdZteETjg==
X-CSE-MsgGUID: kUhVVfHmRZ2BbicjyngJ7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; d="scan'208";a="41621684"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Jun 2024 03:24:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 03:24:50 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 03:24:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 03:24:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 03:24:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhzSUGmhvv7tBW4Lrf44gcdqHkfhAqxjTp5QZCj+Gam9r7cmfONYjpRt06bMk3YbGHxvBRgxlPJ1NaByr0/HS9K5zjHsWX0AJEdhEU6J3BTR1Tv4RgDjPjwCxtCLCiQ4wAmAHnBeGagxtPQyIFxYrnjj+CSXV6EUJU8vuK1JtamWr4AW07tGS5RHdsTVm1dAJPLdNN6t9HFIPSg2/zbB+C4aeX6mX0Xw2cELLsY6XzJj7uekbYJ4CIhjwc1kiNxgWmky1a+wOq5KvVGd0BR/V9dXv7cC0Y+w9ntcWY2UZADqaAMt6wxIl4dNQ/jZZa1cEHKLZFQVCnSeLWxthp+qkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8rvy/8VbKymtR0Va8J9HurmHX5NmsPx9Cp2vmkHVAg=;
 b=Nr8yQq8F2vh9Tq1x0UYsWgNQKpXNUSy6rbMY4uywrehJygzLfdtZv/penYFuZRWzBvBa1hnzRnY2d7iWbHPbpgM/fGkfx6Nhjvvj/bVXhwlvvP8u7VBq8i9YKvwdY25K6ANAG5n2vuzvmec9ELXXuK8LLO0uTE8VPhSqL4nExeCjjL85Q30lhsKTjH10BI2jZtiIAGWabA4953BtAQlppvfjKjKMi0lC5ltb49MJRRj47HtHkIX/M9fYsRJV8gGVK9LKRoav2LkMqv/zlVY0D9wERn9PF5OXQeuHFZXOpP0Th7V/bO54c2hNOEYJMeMa6OLIougQtExX62duswTF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by LV3PR11MB8767.namprd11.prod.outlook.com (2603:10b6:408:215::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 10:24:46 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 10:24:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v2 17/17] vfio/container: Move vfio_container_destroy() to
 an instance_finalize() handler
Thread-Topic: [PATCH v2 17/17] vfio/container: Move vfio_container_destroy()
 to an instance_finalize() handler
Thread-Index: AQHawICBMyWtmufg10+APnvNnTNCmrHLv94w
Date: Mon, 17 Jun 2024 10:24:46 +0000
Message-ID: <SJ0PR11MB6744B1B13C92EB6B3A95C7C392CD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240617063409.34393-1-clg@redhat.com>
 <20240617063409.34393-18-clg@redhat.com>
In-Reply-To: <20240617063409.34393-18-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|LV3PR11MB8767:EE_
x-ms-office365-filtering-correlation-id: 30c5d6a5-7bf5-45c3-67e9-08dc8eb7b63d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?MFZpZFdpVTFMdFoxV1NRL3NLNU9qM2VLZUJ4cUVWQ0JkS2xFdG51VVZ2SUJw?=
 =?utf-8?B?QzhLT0ZCQ3Y0QUI0amlVL1ZOTDdNNmFmVXZlOXdzb0xWQ2ZTM2NXMk81ZE5l?=
 =?utf-8?B?ZzlvaVkwR0lLOU11Tjc2T3ZETDl4N1Y4MVRCMVRoM3k0RmxMYkVPdFRKY3ZI?=
 =?utf-8?B?aUFYdzh3a3VITVA1bXh5Z0xpUmNjVHkyVW1Ma2pBek8wTkxNY1NOVjJQczZt?=
 =?utf-8?B?bTJnU0lEbnVnNnd4L2JUU3RBUkdQK2NrS29GeDJFcGtFSktxVGFQYjFqVWpo?=
 =?utf-8?B?MHpYcklSYVFBeWE1VXl1ZGE2OWFkdjM0TkFuQWt6SjViVlJaTXNudCsyMTAr?=
 =?utf-8?B?SllQNmVLYjk5UnlPSXdaTFhXS2o2VUxBZ2lucDU1WFpRcEdqU3dBQXVUN0dn?=
 =?utf-8?B?aVkyN0Vkazhydm1uQnpXOHFrQ08xWmlCdmhCa2FTOE9mejlqL1p3cjcyT3FH?=
 =?utf-8?B?TDNFUWtpcXNLWmhKRzJZc3RjN0lQSVhRc3JxTGx2bzB3MFcyZDlTZldHc2pO?=
 =?utf-8?B?MDFBT1ptamFFVzkyMVVJZWUwRmdwZG5YTW5WMkNINGxrazdUY3UwYktDaUsy?=
 =?utf-8?B?OFN0alY3b2gzRGU2K3doMGhWQXdzRXdoWWNnN1ljQStJaURmczladld1dG00?=
 =?utf-8?B?YU5Kd3dIZ2RscjA3akl5YlozSWxPWnp3R0kycE1Ob2FnM0dyMFo2anlDaXA4?=
 =?utf-8?B?QURKcEFIVnBGSEswNkNBZ3NhMkpGZms4VG5DSVhOYzRacFdzUGREbDNSL3Ev?=
 =?utf-8?B?K0NBVUxFSHpydmJFOEpxY0xoNXJuMnRFSm94bk1VV1dVejd6V0l2T0lwcmJo?=
 =?utf-8?B?R1d1Z3BLU2dmdHVySk1oOWY1VTR5bVA1d0FIRDlSV0pUL21zbEtEZXFrbk4w?=
 =?utf-8?B?RHRydkVqWU1kN09ncFpjaXAxUXlXTzFDcnJwcURJRGdGY1JBQ3U5QmNlWi9P?=
 =?utf-8?B?UzA4d05UUlB4TWRKckY4V0VxUHhkQ2RTcGZ1aklsT1E0YVpNL1U3YUVvRW9u?=
 =?utf-8?B?c1VqYUtLWU8xVkxPTFRpRzd4TXlmQUZxdGZabzd1SGpwSDlGempzZE9DVjQx?=
 =?utf-8?B?VnRNdTEzTmtpUmlEUHNxc2R4VEd3TGJRZ3kwMUpVL2YzeTBqbEs5aENUTW9v?=
 =?utf-8?B?Z1hZVnFMWGQ0V2hJbUkybGNUL00wTk1WeEI0UXlDQVVvSE1ieEVqTWovTnpD?=
 =?utf-8?B?d3JJZm9PUzUrZUJ0QWpORThmb1ZLTXNHbWpsUGE3Rlg3TnBCWnMvRjdyayt4?=
 =?utf-8?B?RjNRMkx4QjlxY2JxcEd5cHB3aHVQUDFxWVU0djZ2Qm1HU2hFbk1UTEZGRmwv?=
 =?utf-8?B?ZWxacWFnblM4ZzlZZmZyVitwSFQ5aGRILzVwRjNrRmwzWkU4OWRhR2c2ZWov?=
 =?utf-8?B?TXFCSGNkdEt3MnpHUnRZb1RCSDJ6KzBBa2ExU0FEMEhROHVPVGIrelBYOElr?=
 =?utf-8?B?aEIzaHY3SWgzVy90V0ljR0tsUjZOQkNBQW04dVVvRzd0TTBSZ1grNWVUQk15?=
 =?utf-8?B?YkRGekVQQ0k2amJFbkhxc1ZWb3ZESWcwVVZXQWNxSWQ0VE9uUVpiYXg4K3lm?=
 =?utf-8?B?ZUF5aEVubXdRUThQZ045NTM0VGluWFNJODNnU2JNZ0paMWsyWGdvUkM0bXN1?=
 =?utf-8?B?a3NZNWNkUmNSL1pqZmZtL3FLN3AwOVZpcXRqV2tTTkxrQWhQSEI0UlZqaEpp?=
 =?utf-8?B?UERqUmY2ei8rdU1ZOWFpNTJsbzlPS3g4eXJaQWpmQ3VrYnV6bTJUbnpseGhY?=
 =?utf-8?B?NDVrTVN5WGVReElPUjE2Uk1MYWdJV015ZHlZSE96YjZxS1JxQWFkTUl3VDFh?=
 =?utf-8?Q?URo3DKGh+EfJVXD2r/lGqx/SSNo4pi8Uz2V3M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE1OUkJ3WjEyY1VTZmFQTStRQzhUd1RVRTNpMGJjNUFJNm5wRy9WWWtTWkli?=
 =?utf-8?B?dVZLcTczSWhuZnpKVlJ4YW5MeEdpby9CL2lwcCtQNWJDbmNLY2c5NVpLbEY2?=
 =?utf-8?B?ZytGV0xyNE1zY2ZFaXEvYjU3WWxKZTNZd3RNenN0QlhWRU4rV2ZqdVViMU9H?=
 =?utf-8?B?KzJvSGFKb28va1ZyUUd3WU9YL0FrVHJWZXRHcXdma2FtMnR2bjh6dmJRWGZP?=
 =?utf-8?B?SzBFeWhhMmdrUkhsR203TVNueHd3Qm9pZWJuNEVuOGdIVTVDcXhMU2hYOGFv?=
 =?utf-8?B?WVlPNXhuVFZGSVlkRm1xNThsa25iYk1IUkF2aUVTWUlCbmNLSVdaOUFmY0l0?=
 =?utf-8?B?SWtUSkZ4Rm45Y1o3NGpJeDJaQi9hRVRmUFc5aHVKRHhHYTBUdXd6Z0ViRFJE?=
 =?utf-8?B?NjZTd3g4RmpiVWhyL3k5ako4VS9kSFdoTStpeGZEUDJMSjR0WVJLWk5WU3VS?=
 =?utf-8?B?OXN3VFVYUW1SSUhEVU50bUtDTGh0eER3M3NDQ1o2Ly9SZ2xwK21iUG9YelBs?=
 =?utf-8?B?RkpOUVlIRnZrWWFlL0Zyb3NzejRVeEVhWWQyOENtK0lWbWNKWjZTTVpzN3lP?=
 =?utf-8?B?Nnh1YTUwSXNUK2c1ZDhJUngwU0lmZmVjV1Y2S09iMThMQTlzY0ZzZEZkVVRl?=
 =?utf-8?B?MEFTUnJIQ2c5TEpXL0w0TWdJUmJyYlMxMTNQc2N3bUxCTXNpS0dKWFl3ck90?=
 =?utf-8?B?L1Vob21hc3drU0xySkhKVmxUcllIaWdaK3psVEJRNWplWnBiMy9mMVdLUUN5?=
 =?utf-8?B?ME56eCtIeWkrcUU2OXBKUWkvU3JpYWlIOTJXNmlpZUROc1JVVnE5Mkk3aXZi?=
 =?utf-8?B?NzBjMFFrRWtKQnFKd2U3dWhTL2g2Wk9NODVTbjJEeE9qSTNuNDBnZXpSdFdE?=
 =?utf-8?B?bGhySFZlMzdBZFltc2FnSmFKTm1FVWh1QTByL0NJS1ViRk5lUmZjYkpvVmd2?=
 =?utf-8?B?YW9aRmNPMW13R21wZTlvRlVGRUI5VnIra0w2bHBrSFZXZjFSZnl5NEVyZDI5?=
 =?utf-8?B?TDV2TTFPR0p1MjgzZCtwdnRtVmt0bElHamdNa1NjaVJOVWk4ZVh2YmJ6cW5M?=
 =?utf-8?B?WUxXMHNtYS9TNitlbzhId2hUanlZU2gzcDFNMG1oT1F1S25zSFVBUWhCeXZC?=
 =?utf-8?B?Z3dsNWY0cnJYQW1kQ21VTzBrYnVKZW5xYlNUM09vVmRlK3lYenJUOTJTWDhK?=
 =?utf-8?B?YkUveFV1NFNpSllaUDM3TmlUbCtodktrOGVSQnNKMTRtMFBSSlV5OWRGelFU?=
 =?utf-8?B?TjlQTFY4a05PS1R4S01hL0pUSU5EWDN5VEVyc29oeXI0QmRCVEo0Uk1JZEh5?=
 =?utf-8?B?ZWNFWVFyMTVZaHUxdzFMSk9GWXU5MS9ZeC9GVTJCSk9DckFjUVhrZ2R3dEZY?=
 =?utf-8?B?VlFwdndZRC9NUkgyVmY4K0xZV1lQTDliOUlMTDZIY012ZXZUaGpJOHpvVXdj?=
 =?utf-8?B?U1VSOVM4QjRzb0k2bDMvb2FjVUVMRlg1SWFGSVpIblMreWJRSlpONjVvY0Vi?=
 =?utf-8?B?dFo4SndrbUsvVFpaRTNaaXNhbllRWDZpdmJlTHZjcUIwaXp1cmpOOGdVeEhw?=
 =?utf-8?B?dUw3UnppT1dqTHY1dXZlTHdhaDJBa1o2cTE1OCtaZ1orM0p0dXhZNFc5TDNr?=
 =?utf-8?B?NVVOa041T3QralcvQVYxWWZWSEVDMDE3NVNRR05VUloxTWIxTUxzSUVpVzNS?=
 =?utf-8?B?ZE5zcVlOczNmZ0F0VEczVm5hTTZ6V3JxYkZrSkYzL1J0YlpWb1hVbzIyUzhq?=
 =?utf-8?B?VU9Sd2xQZFc4UjdBNmlFSENZdVEvMHRGWmowYTFOTVVXMXExRDd3M3E3R0F4?=
 =?utf-8?B?V0RlNGdyeXFwSzVEQ2ZPZGNMY09kOTBYVjRyQXcxZHRmdGtVSkRDTTlUQ0lT?=
 =?utf-8?B?cVhiZTdCb1dZa1V6ZXpKMEVDQVlRUUx6UFdFQUhRWWV6dkMwV0R6MFI5aHB5?=
 =?utf-8?B?OGY1TmRkaDdNdlliQlc0RjdteTZFbW9YNVlKNU53TGVvdW1RUG9JaksrWStw?=
 =?utf-8?B?bHUrcjI2UWluYW9lem5XWmkyaktRSVBidTltTk43T3BpRHRuOHNmc3hOMWd5?=
 =?utf-8?B?SkxSc1ZNZllaZFhMNmJQMXhXc1poV3k1TXBaVExnOURIdjZySW5qTG95N0tm?=
 =?utf-8?Q?kDvrW9yEP2XWPFzmvNzsAfqWQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c5d6a5-7bf5-45c3-67e9-08dc8eb7b63d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 10:24:46.6982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ajIFOVuRrLx5E1ZhvB1NN5TFS5JnwA7uZ6Hh+wh9PElxMivjbn02aa2INFK766LovOxxPqJaXe43VaZ0ziWaDOt8mjJAQSLYM/mp0ZcGHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8767
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjIgMTcvMTddIHZmaW8vY29udGFp
bmVyOiBNb3ZlIHZmaW9fY29udGFpbmVyX2Rlc3Ryb3koKSB0bw0KPmFuIGluc3RhbmNlX2ZpbmFs
aXplKCkgaGFuZGxlcg0KPg0KPnZmaW9fY29udGFpbmVyX2Rlc3Ryb3koKSBjbGVhcnMgdGhlIHJl
c291cmNlcyBhbGxvY2F0ZWQNCj5WRklPQ29udGFpbmVyQmFzZSBvYmplY3QuIE5vdyB0aGF0IFZG
SU9Db250YWluZXJCYXNlIGlzIGEgUU9NIG9iamVjdCwNCj5hZGQgYW4gaW5zdGFuY2VfZmluYWxp
emUoKSBoYW5kbGVyIHRvIGRvIHRoZSBjbGVhbnVwLiBJdCB3aWxsIGJlDQo+Y2FsbGVkIHRocm91
Z2ggb2JqZWN0X3VucmVmKCkuDQo+DQo+U3VnZ2VzdGVkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPg0KPlNpZ25lZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhv
bmcuZHVhbkBpbnRlbC5jb20+DQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4tLS0NCj4gaW5jbHVk
ZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaCB8IDMgLS0tDQo+IGh3L3ZmaW8vY29udGFp
bmVyLWJhc2UuYyAgICAgICAgICAgICAgfCA0ICsrKy0NCj4gaHcvdmZpby9jb250YWluZXIuYyAg
ICAgICAgICAgICAgICAgICB8IDIgLS0NCj4gaHcvdmZpby9pb21tdWZkLmMgICAgICAgICAgICAg
ICAgICAgICB8IDEgLQ0KPiA0IGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVy
LWJhc2UuaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0KPmNvbnRhaW5lci1iYXNlLmgNCj5pbmRl
eA0KPjYyNDJhNjI3NzFjYWE4Y2YxOTQ0MGE1M2FkNmY0ZGI4NjJjYTEyZDcuLjQxOWU0NWVlN2E1
YWM5NjBkYWU0YTkNCj45MzEyN2ZjOWVlNjZkNDhkYjIgMTAwNjQ0DQo+LS0tIGEvaW5jbHVkZS9o
dy92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPisrKyBiL2luY2x1ZGUvaHcvdmZpby92Zmlv
LWNvbnRhaW5lci1iYXNlLmgNCj5AQCAtODYsOSArODYsNiBAQCBpbnQNCj52ZmlvX2NvbnRhaW5l
cl9zZXRfZGlydHlfcGFnZV90cmFja2luZyhWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwN
Cj4gaW50IHZmaW9fY29udGFpbmVyX3F1ZXJ5X2RpcnR5X2JpdG1hcChjb25zdCBWRklPQ29udGFp
bmVyQmFzZQ0KPipiY29udGFpbmVyLA0KPiAgICAgICAgICAgICAgICAgICAgVkZJT0JpdG1hcCAq
dmJtYXAsIGh3YWRkciBpb3ZhLCBod2FkZHIgc2l6ZSwgRXJyb3IgKiplcnJwKTsNCj4NCj4tdm9p
ZCB2ZmlvX2NvbnRhaW5lcl9kZXN0cm95KFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyKTsN
Cj4tDQo+LQ0KPiAjZGVmaW5lIFRZUEVfVkZJT19JT01NVSAidmZpby1pb21tdSINCj4gI2RlZmlu
ZSBUWVBFX1ZGSU9fSU9NTVVfTEVHQUNZIFRZUEVfVkZJT19JT01NVSAiLWxlZ2FjeSINCj4gI2Rl
ZmluZSBUWVBFX1ZGSU9fSU9NTVVfU1BBUFIgVFlQRV9WRklPX0lPTU1VICItc3BhcHIiDQo+ZGlm
ZiAtLWdpdCBhL2h3L3ZmaW8vY29udGFpbmVyLWJhc2UuYyBiL2h3L3ZmaW8vY29udGFpbmVyLWJh
c2UuYw0KPmluZGV4DQo+OTcwYWUyMzU2YTkyZjg3ZGY0NGUxZGQ1OGZmOGM2NzA0NWEyNGVmMS4u
NTBiMTY2NGY4OWE4MTkyY2Y0MDIxNDkNCj44ZTU5ZjJhOTJjZDJmNmU4OSAxMDA2NDQNCj4tLS0g
YS9ody92ZmlvL2NvbnRhaW5lci1iYXNlLmMNCj4rKysgYi9ody92ZmlvL2NvbnRhaW5lci1iYXNl
LmMNCj5AQCAtODMsOCArODMsOSBAQCBpbnQgdmZpb19jb250YWluZXJfcXVlcnlfZGlydHlfYml0
bWFwKGNvbnN0DQo+VkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJycCk7DQo+IH0NCj4NCj4tdm9p
ZCB2ZmlvX2NvbnRhaW5lcl9kZXN0cm95KFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyKQ0K
PitzdGF0aWMgdm9pZCB2ZmlvX2NvbnRhaW5lcl9pbnN0YW5jZV9maW5hbGl6ZShPYmplY3QgKm9i
aikNCj4gew0KPisgICAgVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIgPSBWRklPX0lPTU1V
KG9iaik7DQo+ICAgICBWRklPR3Vlc3RJT01NVSAqZ2lvbW11LCAqdG1wOw0KPg0KPiAgICAgUUxJ
U1RfUkVNT1ZFKGJjb250YWluZXIsIG5leHQpOw0KPkBAIC0xMTYsNiArMTE3LDcgQEAgc3RhdGlj
IGNvbnN0IFR5cGVJbmZvIHR5cGVzW10gPSB7DQo+ICAgICAgICAgLm5hbWUgPSBUWVBFX1ZGSU9f
SU9NTVUsDQo+ICAgICAgICAgLnBhcmVudCA9IFRZUEVfT0JKRUNULA0KPiAgICAgICAgIC5pbnN0
YW5jZV9pbml0ID0gdmZpb19jb250YWluZXJfaW5zdGFuY2VfaW5pdCwNCj4rICAgICAgICAuaW5z
dGFuY2VfZmluYWxpemUgPSB2ZmlvX2NvbnRhaW5lcl9pbnN0YW5jZV9maW5hbGl6ZSwNCj4gICAg
ICAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihWRklPQ29udGFpbmVyQmFzZSksDQo+ICAgICAg
ICAgLmNsYXNzX3NpemUgPSBzaXplb2YoVkZJT0lPTU1VQ2xhc3MpLA0KPiAgICAgICAgIC5hYnN0
cmFjdCA9IHRydWUsDQo+ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY29udGFpbmVyLmMgYi9ody92Zmlv
L2NvbnRhaW5lci5jDQo+aW5kZXgNCj40NTEyM2FjYmRkNmE2ODFmNGNlN2NhZTdhYTI1MDkxMDBl
YTIyNWFiLi4yZTdlY2RmMTBlZGM0ZDg0OTYzYTQ1DQo+YWU5NTA3MDk2OTY1ZGE2NGZjIDEwMDY0
NA0KPi0tLSBhL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4rKysgYi9ody92ZmlvL2NvbnRhaW5lci5j
DQo+QEAgLTcxMiw4ICs3MTIsNiBAQCBzdGF0aWMgdm9pZCB2ZmlvX2Rpc2Nvbm5lY3RfY29udGFp
bmVyKFZGSU9Hcm91cA0KPipncm91cCkNCj4gICAgIGlmIChRTElTVF9FTVBUWSgmY29udGFpbmVy
LT5ncm91cF9saXN0KSkgew0KPiAgICAgICAgIFZGSU9BZGRyZXNzU3BhY2UgKnNwYWNlID0gYmNv
bnRhaW5lci0+c3BhY2U7DQo+DQo+LSAgICAgICAgdmZpb19jb250YWluZXJfZGVzdHJveShiY29u
dGFpbmVyKTsNCj4tDQo+ICAgICAgICAgdHJhY2VfdmZpb19kaXNjb25uZWN0X2NvbnRhaW5lcihj
b250YWluZXItPmZkKTsNCj4gICAgICAgICB2ZmlvX2Nwcl91bnJlZ2lzdGVyX2NvbnRhaW5lcihi
Y29udGFpbmVyKTsNCj4gICAgICAgICBjbG9zZShjb250YWluZXItPmZkKTsNCj5kaWZmIC0tZ2l0
IGEvaHcvdmZpby9pb21tdWZkLmMgYi9ody92ZmlvL2lvbW11ZmQuYw0KPmluZGV4DQo+MDliNzFh
NjYxNzgwN2M2MjEyNzVjNzRiOTI0Y2ZkMzllYjY0Mzk2MS4uYzJmMTU4ZTYwMzg2NTAyZWVmMjY3
DQo+NzY5YWM5YmNlMWVmZmI2NzAzMyAxMDA2NDQNCj4tLS0gYS9ody92ZmlvL2lvbW11ZmQuYw0K
PisrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+QEAgLTIzNyw3ICsyMzcsNiBAQCBzdGF0aWMgdm9p
ZA0KPmlvbW11ZmRfY2Rldl9jb250YWluZXJfZGVzdHJveShWRklPSU9NTVVGRENvbnRhaW5lciAq
Y29udGFpbmVyKQ0KPiAgICAgICAgIHJldHVybjsNCj4gICAgIH0NCj4gICAgIG1lbW9yeV9saXN0
ZW5lcl91bnJlZ2lzdGVyKCZiY29udGFpbmVyLT5saXN0ZW5lcik7DQo+LSAgICB2ZmlvX2NvbnRh
aW5lcl9kZXN0cm95KGJjb250YWluZXIpOw0KPiAgICAgaW9tbXVmZF9iYWNrZW5kX2ZyZWVfaWQo
Y29udGFpbmVyLT5iZSwgY29udGFpbmVyLT5pb2FzX2lkKTsNCj4gICAgIG9iamVjdF91bnJlZihj
b250YWluZXIpOw0KPiB9DQo+LS0NCj4yLjQ1LjINCg0K

