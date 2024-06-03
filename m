Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C226C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE5Sy-0007IF-CL; Mon, 03 Jun 2024 07:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE5Sv-0007Gr-Ed
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:03:01 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE5Ss-0002vo-Cl
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717412579; x=1748948579;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+EMq+OQNWw/DFTS8tDRdo2y0qsvjQJj/q9IHx6YE2Uc=;
 b=ZdV7FIKgTTnSkix90hPQsdxOIpQcpPQJ4+iHITj8Ujkuz+gSOolQJ97p
 u6Gsdnr4cblyAiz6kFyKajjAIaOtMN2Nma13NxQfrv+fSvLRafz455KEF
 KSPaDheahwD8gtcU5jSS1KhlHJs6VSzLPrlmOFLCY18E4+4Z4T4VuLDbp
 As03SLvWcZUk4zjQjRdB7PxnXXLyajvxldvxO0UVxbO06Ye5Iecmt46dZ
 X4Laz5/y3mvDaH22dCQso1gqaSTOR/N6olAavqjooboWijBLoV/4wQ5sI
 w++8xlodsMZKC7B16oMMWZ/Tcye9hm2zdTnfEMzuEx1JHUgXqinac1vdD A==;
X-CSE-ConnectionGUID: ZFQaD36yTeuy6UKPlGAidQ==
X-CSE-MsgGUID: 8j5rL2QkQ3eo3Wp5nwDobw==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13709668"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; d="scan'208";a="13709668"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 04:02:18 -0700
X-CSE-ConnectionGUID: xHIKZBf7TVSBVO2g1ZEPsg==
X-CSE-MsgGUID: jLqmgsacTn2VenWPzjqvFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; d="scan'208";a="41265659"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jun 2024 04:02:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 04:02:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 04:02:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 04:02:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxuvypPCwQ916EcHY5rlsJtHbnwI6uBK8VXOhfRhCt2xnF8HDVjJCS9cdLH9IE46nirbQARRKAQYrcegaR/OA4ByHBCF7MF0NFI1UhA0/4vseq+i8SXuHfydTq06voPVdriCcB9zxiC+667LJeaMHS4gPmZ5pwKwCdATpFvseUWP08un22orPb7ps+fLBAx+ygp68THvSuUI/PJaO/3PrcXi5tXxm3Cvs/a5u+v2AKppYjMi351CxYdBqSpcGDFxGOgMejim3VglApIDJ1U+iLdn3/mSPY2Rzt0bnuwbgi1wbTxmftEYP6A9vF/pv4IEE4plh81hLjl2bXF922nwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EMq+OQNWw/DFTS8tDRdo2y0qsvjQJj/q9IHx6YE2Uc=;
 b=KKe7Fq8zHPja9G3sysRbv1ShxqYy6n/E0bX3avIxHQIFzUvxDA62a5/dumqrI9MZHBy0chFg6jMONWuuuwjxBAlkJVbFc4IfycRmHkHfIumLGePIjVHzgIibPj5KWWUA5l0DAnTiKTgZPREDdq5yW/6AlqW6tpLEj+Vr+U05wByCDf4mqxPtXAa9jJqJ102mL+LeG7yg/yPpR99/BRuxZ4cTg60PnBxWyKIjrQjnzJU2wuE0wDHenAYrY0e0A7B+5POgg74Y9LcYeKvBVEu5/EzzfRncB05GV5IRuSjbOX3h5bNVB9lXkJ1MGnJN2KxKbFyzPIntHUuKMwAPyGvm/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7914.namprd11.prod.outlook.com (2603:10b6:610:12c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 11:02:14 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 11:02:14 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Thread-Topic: [PATCH v6 18/19] intel_iommu: Implement
 [set|unset]_iommu_device() callbacks
Thread-Index: AQHatX1NjS0WvnbGzEqvnm/9l/Wze7G10h8AgAANccA=
Date: Mon, 3 Jun 2024 11:02:14 +0000
Message-ID: <SJ0PR11MB6744E89A1A959BE312ECE5B592FF2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-19-zhenzhong.duan@intel.com>
 <6cfdde68-a138-4ac3-ab3c-29f6a94a1045@eviden.com>
In-Reply-To: <6cfdde68-a138-4ac3-ab3c-29f6a94a1045@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7914:EE_
x-ms-office365-filtering-correlation-id: 1116e435-5eb3-4b83-2af8-08dc83bca026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|1800799015|376005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?YjJnUHgwaG1JN1pHeUE2aDhtYlh2M0gybHhYQmNJVytXR2drbE9VSGJIb3dS?=
 =?utf-8?B?T2Mwb01aT01CbXhaUUVqOXFOT2dpK2hLWStxV0JZMnNMNFNQSHR6bEZMZmdw?=
 =?utf-8?B?aitYYTNRZENNMHh3dVZURFYwem81SjFFQmEySVd2THEwUVc4Z1piSTNyWGJt?=
 =?utf-8?B?NkdnZFJ5ZnlJTGVyd3F6V0lId3lhLyszVm5xaWNyM0g3RDR3UXEzdk04Q2cz?=
 =?utf-8?B?dEtLcGNuRkFFZ0dONVZsT0JpbGQ4akljS0Y3MVNydDc2ajZjRG1mVG1BQUdr?=
 =?utf-8?B?MTFKK3ljZGN6UzVZbU9IMlNvcDZramlleUZMOVYrOHc2Yk5zSm01UkNUWitO?=
 =?utf-8?B?SE1DR0NUK2pwcUZ5dVh5YmRpbE5iODZNWWJHS3lyVkliRVdXbVBJM0pXMFFw?=
 =?utf-8?B?WEVIOUFwc1RvVUVkaVFmK1ZoQVVFeGJDY25GTWJYZlhpTDNLaFhvUDlwNmRX?=
 =?utf-8?B?RVBnVGxERG9vM2hwTG95WFF4aDhPWDU1bzZWNTB2S21Fd2lQM3VtZFJmZnZo?=
 =?utf-8?B?UzBMY1JnVlNXKy9qQm9DMHlLRnJhay9RQVRrVDNpWWhlcFd2MXRUU0tLR0RG?=
 =?utf-8?B?cDc5b1NFZXB6NENaM1NyVW5JOThBWkdHemV5YmYwWXdTbkMvd2VNalhPNjR5?=
 =?utf-8?B?cjVmblVmM3N3K21YTit6L1JTMC9wYjA0eFUxSDkyV01XRnF1V2MyRHdyK0gy?=
 =?utf-8?B?K1dmVFgzeEtoLzlNR281OWJvOUxPN0orR1h5eklUYm1wVWJYQTRtVFZqendk?=
 =?utf-8?B?NnZ4VWM4RElWSy9vZWZQTTdkQTVnNmZDeEdvdlZieFJzZXdmejRlL3VvdW51?=
 =?utf-8?B?RjFpUURVb0o2aFRod3Nubmp5SlMwMUw5SnhzdHY4YjZkUnFScy8rdDk0Wmxr?=
 =?utf-8?B?NytmWnROaDdzdklNb3J1UTVJY24raU54cTYwTkswN0hxRDNabnc2blVCTG13?=
 =?utf-8?B?RXpzdjZnUnV1Zjd0S0orUkNPTk0zNlBTRkQvTDlzYVMveHU3MlozN1NNZmgy?=
 =?utf-8?B?T3hDZzltMWQzUWtPWjF1bjMxMTdmTG9uS1dyUnRVNFNwVmVYS2NJYTI0VVlO?=
 =?utf-8?B?a0s1NVZJZmlDTkQ4OXJYdXdVbFlGZTQ2c2lCT1A1RlIwMnNocjR6b2czZ2VJ?=
 =?utf-8?B?MzNEL1J2ZkdPYzFtWjI5N0Q4dzloci9XNDdRa3hEajhCWlJsUnFUekhqVGdn?=
 =?utf-8?B?TkNJSnN6Qjh0ZlNLQ2QxeXpJUXppUVU1ZFVXWCtmME4rWVlieXYySVNIODg5?=
 =?utf-8?B?VVZ0TmlxNXhhSEpmSXdDa0djWSs2QWh1ODlxY3BZR2lqV1JYcFFVWUpSNG9W?=
 =?utf-8?B?blU3bndhSzBySHFjTm5KVTNINDFBQ0NOTmlOMndON1JSNkhwY3hVTWdjYzFS?=
 =?utf-8?B?ZGI3cjM1Q1ozbmQwUzBXYVd6UW51SlNnUHhQWGlLakZRa3ZBY0cyM0grWGlM?=
 =?utf-8?B?T3cyQnUrcFJJME5UZSs4akoxVVhycjZveVFxVTJvNlR1RnVrRGEyMDU3SEY0?=
 =?utf-8?B?L0xtRHFndlBGV05CVlZrc1RTWGRRTHJFcXV6WnpKeHZwVWZJMnl6OGVNdE9j?=
 =?utf-8?B?YXV2Y1BVRUtoUmxXbmoyOTAwL1IrUCt5ZkM0aEYwYld3WWwrcm16MXFoRS9H?=
 =?utf-8?B?Vjl6NndsVlNYSTNoVkhVOXRqNnJBZ2V2SXUzS05GbEFmcFlaS2t0ZzNZOUlr?=
 =?utf-8?B?dkNkb0VhRFNWRXQwUHREclluOXRWM3YzMXljUXZMc1JwNVEwYTFhSFBJRXRx?=
 =?utf-8?B?c3YrVDdQZHNnN1JiUUFScWdjbEdqQmJ1bGMweWppdFUyL2RxMlZFaEpnY0NL?=
 =?utf-8?B?RzdRWmIzWmw1eFZ4bTErQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWVINEVjbG9HU0N0aFVQOUJvU3NZWHYvTHpNbkpSYVFsOG9GMFZMS2lzWUdn?=
 =?utf-8?B?bUhiWjllNVBMdEkvL3ZITHNzeVRvMDB3YURNOEZrS2VDdDIzQnBWV2tEeTR4?=
 =?utf-8?B?YTR0TTVPd3ZMWUxRQlRKSVZ6RmhLUVU0Zm92UC9wTGVPS0NHVTlOM1NXRUZk?=
 =?utf-8?B?OERwV2lRSlJjSkR4M2dlblBTWWJmTExJZ0V4Ni84TDhrOS9wb0JZdUVWVHV3?=
 =?utf-8?B?UmFEK1FDWStJSFlxR1hFR2hxRCtZYVFDcmFFdDBlMFdIdUgrVkw5Y20vM05u?=
 =?utf-8?B?TEZROUhFaHRDcFlYR0srTU5kNDlrNjAvZDI0SG13VnpNZjM3TUZnWGJ5dXJk?=
 =?utf-8?B?K1V0Sk82OVE0ak1vL3I0QkdwYWxkTVNYOHlKblBlOUM4TXRQWWwvdVphbEUy?=
 =?utf-8?B?UXZnbVduanA1WFdCa1QwdmpHOVBaaVhYK1A5OUhyMnVaZmRUZzlMYlNwTjJm?=
 =?utf-8?B?bitBOWRQYXlJYkN0aFdMNE83UC80bnRxQXQrNzE2SGlTNW5MS0wwZlAyZTY4?=
 =?utf-8?B?WU42NFpmVmdjT1VwRmduY3A5YzJ3NFh4ZFBBczBNSDVxS1JQbWY5aG5DcjZt?=
 =?utf-8?B?V0pPSFZXYUF3UmoxL3AyV0g4YjZldUdkcGtoa3JRT0dJR3B6RG8zR3dRWjR0?=
 =?utf-8?B?bjh6cDhLRmJwZi9TNlN3bGQ3V0ZablFHSlNnWW44WFpkekNlZEVQenpoRWZL?=
 =?utf-8?B?QVVGd1JSZElaQjhDZ0N6dDBpRzhYUytsTHA2SDNoa1NubE5iT0duU0YrNEhG?=
 =?utf-8?B?Y0VaK3NaY2NvUGtoN0t1U25WTURyWHN5c3BOZWs4dFAyVkVzY0ZXMkxWSllp?=
 =?utf-8?B?UUY2Z2VMcGxVL0g0dERGcWtqWkswRDVFdGhXVzZIa1l3Y2hXOEFLV0ZSNU1H?=
 =?utf-8?B?NzlxdERYUHhxNHdyVnlEcmxBUmVEY1N6Uzl3dmJPUUE1RW9sNFJiaWkxbElL?=
 =?utf-8?B?RmpvTjVWWFp2ZnZ6VEEwaEVLQ1VDME5KTlhiYUFMQjYzN24wU2NSWGVqbHZS?=
 =?utf-8?B?OFFNYjBuWXUvdUliTDRzOGpkSGxQcW1uL3ErR3JONzJSOEg1ZVFUczArY2JD?=
 =?utf-8?B?VDdXUUtnUkM3MzRPczBNbkdyaG9qV3MyRDFPMkZHbFRKS0hFSDRlY1prSlZo?=
 =?utf-8?B?TXd0MUo3eEVxWmhNMks2eE8wemtVUXZCQVMzMmxXb3dESkVKZVJPN1Y1WHh5?=
 =?utf-8?B?c1JaTW1iMmRENXQxZllZRDRWRVdyTmZPUzJScnRjd3cwQkIvZDJkNkFnNmsv?=
 =?utf-8?B?Ykg1WnFpUENUbnlwb0FSOTE3eTg2RGJzZDFHN1BVMHBEeDVaMFp2cExTTDJS?=
 =?utf-8?B?T0ZCdTRHYnNYMU5RRmxkZUNEZHpmTlpramt3QXVyekNwNnlZYStyZHQ0VGx5?=
 =?utf-8?B?RDMvNklPWm9YQ1dsaC9jYzdxTEVrVFJobE12U25rc3JpajF1WE1BUjFIZ2FL?=
 =?utf-8?B?bmpmQlFXVEFoWTlKVS9qWFMvWW1laFNoNXNXUzZnbndmN082alRNR25tby85?=
 =?utf-8?B?TENYMG1YRndRbVlZcWJTSnBlUGZsQXl6UnRWb243d1dSV2ZKU2YxeUlXaEpC?=
 =?utf-8?B?eFdad2RoRjZSN2dkY1BmcjQyZkVITitBelAwSC9MalRhNkJ1NnFZUmFyYTdy?=
 =?utf-8?B?UDl3WXVXOTJzRnVmeURvWEpSbmpsVmV0M2Z1d1hoSXh5aE9aR3BEMkIyeG9F?=
 =?utf-8?B?emgzMktnVlVQeDNrM0w3QUNMWFpuWTdGRW9TU3B2cTlWdG9jajRoQlVTeHZY?=
 =?utf-8?B?R1hHQ09pbmQrbWhNTUs3VUowdHhTbkl2ZlIyeG9vOThqMzRIL3B3QVpPTGVS?=
 =?utf-8?B?QU1xVlVkUFNINEZ3cUY1UC9ENHVsNTkvbXk4QWRqZzJ0RjhzQXllUzRTcHpv?=
 =?utf-8?B?ZWRpSStXNzY4d2FDdi9yUkdIU3hTdFRjdnNiT3pleXVmcVpKWGFZbU5SUjBt?=
 =?utf-8?B?ZUJSTXJBQVNyTGhtWmsra2kxbnFnSHVsZGdSRllqMG9JTUwxUEcwcDhWb284?=
 =?utf-8?B?SDlOVU5oWW54UVNZOFc3bzg1b1pMRFQxZzhaczA0UHp2STBZZzhubTM2T24x?=
 =?utf-8?B?SUg4VnhUUXNXcXEwbER4dmNQYmQydEtaLzVhUXh1eXB1RWx6M3Yyb3F4Sk1y?=
 =?utf-8?Q?195xfGcgRU0WMLPf+pHLHuuQG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1116e435-5eb3-4b83-2af8-08dc83bca026
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 11:02:14.3101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 260kYa3Rzpo53AHr4OqugzIaUvC94KmpoMVV1SuP4McLgsOWCdzbhMiPp54H3Z7zU+1MiQ8eRsXHbCPhbgb8FdxbaVGFsBVWAASF45LMh/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7914
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2NiAxOC8xOV0gaW50ZWxfaW9tbXU6IEltcGxlbWVudA0KPltzZXR8dW5zZXRdX2lvbW11
X2RldmljZSgpIGNhbGxiYWNrcw0KPg0KPg0KPk9uIDAzLzA2LzIwMjQgMDg6MTAsIFpoZW56aG9u
ZyBEdWFuIHdyb3RlOg0KPj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0
dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcw0KPmVtYWlsIGNvbWVzIGZyb20g
YSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pg0KPj4N
Cj4+IEZyb206IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4NCj4+IEltcGxlbWVudCBb
c2V0fHVuc2V0XV9pb21tdV9kZXZpY2UoKSBjYWxsYmFja3MgaW4gSW50ZWwgdklPTU1VLg0KPj4g
SW4gc2V0IGNhbGwsIGEgbmV3IHN0cnVjdHVyZSBWVERIb3N0SU9NTVVEZXZpY2Ugd2hpY2ggaG9s
ZHMNCj4+IGEgcmVmZXJlbmNlIHRvIEhvc3RJT01NVURldmljZSBpcyBzdG9yZWQgaW4gaGFzaCB0
YWJsZQ0KPj4gaW5kZXhlZCBieSBQQ0kgQkRGLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExp
dSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1
bkBsaW51eC5pbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaCB8ICA5ICsrKysNCj4+ICAgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11Lmgg
IHwgIDIgKw0KPj4gICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA3Ng0KPisrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA4NyBp
bnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50
ZXJuYWwuaA0KPmIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiBpbmRleCBmOGNm
OTliZGRmLi5iODAwZDYyY2EwIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IEBA
IC0yOCw2ICsyOCw3IEBADQo+PiAgICNpZm5kZWYgSFdfSTM4Nl9JTlRFTF9JT01NVV9JTlRFUk5B
TF9IDQo+PiAgICNkZWZpbmUgSFdfSTM4Nl9JTlRFTF9JT01NVV9JTlRFUk5BTF9IDQo+PiAgICNp
bmNsdWRlICJody9pMzg2L2ludGVsX2lvbW11LmgiDQo+PiArI2luY2x1ZGUgInN5c2VtdS9ob3N0
X2lvbW11X2RldmljZS5oIg0KPj4NCj4+ICAgLyoNCj4+ICAgICogSW50ZWwgSU9NTVUgcmVnaXN0
ZXIgc3BlY2lmaWNhdGlvbg0KPj4gQEAgLTUzNyw0ICs1MzgsMTIgQEAgdHlwZWRlZiBzdHJ1Y3Qg
VlREUm9vdEVudHJ5IFZURFJvb3RFbnRyeTsNCj4+ICAgI2RlZmluZSBWVERfU0xfSUdOX0NPTSAg
ICAgICAgICAgICAgMHhiZmYwMDAwMDAwMDAwMDAwVUxMDQo+PiAgICNkZWZpbmUgVlREX1NMX1RN
ICAgICAgICAgICAgICAgICAgICgxVUxMIDw8IDYyKQ0KPj4NCj4+ICsNCj4+ICt0eXBlZGVmIHN0
cnVjdCBWVERIb3N0SU9NTVVEZXZpY2Ugew0KPj4gKyAgICBJbnRlbElPTU1VU3RhdGUgKmlvbW11
X3N0YXRlOw0KPj4gKyAgICBQQ0lCdXMgKmJ1czsNCj4+ICsgICAgdWludDhfdCBkZXZmbjsNCj4+
ICsgICAgSG9zdElPTU1VRGV2aWNlICpkZXY7DQo+PiArICAgIFFMSVNUX0VOVFJZKFZUREhvc3RJ
T01NVURldmljZSkgbmV4dDsNCj4+ICt9IFZUREhvc3RJT01NVURldmljZTsNCj4+ICAgI2VuZGlm
DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj5iL2luY2x1
ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBpbmRleCA3ZDY5NGIwODEzLi4yYmJkZTQxZTQ1
IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+ICsrKyBi
L2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBAQCAtMjkzLDYgKzI5Myw4IEBAIHN0
cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPj4gICAgICAgLyogbGlzdCBvZiByZWdpc3RlcmVkIG5v
dGlmaWVycyAqLw0KPj4gICAgICAgUUxJU1RfSEVBRCgsIFZUREFkZHJlc3NTcGFjZSkgdnRkX2Fz
X3dpdGhfbm90aWZpZXJzOw0KPj4NCj4+ICsgICAgR0hhc2hUYWJsZSAqdnRkX2hvc3RfaW9tbXVf
ZGV2OyAgICAgICAgICAgICAvKiBWVERIb3N0SU9NTVVEZXZpY2UNCj4qLw0KPj4gKw0KPj4gICAg
ICAgLyogaW50ZXJydXB0IHJlbWFwcGluZyAqLw0KPj4gICAgICAgYm9vbCBpbnRyX2VuYWJsZWQ7
ICAgICAgICAgICAgICAvKiBXaGV0aGVyIGd1ZXN0IGVuYWJsZWQgSVIgKi8NCj4+ICAgICAgIGRt
YV9hZGRyX3QgaW50cl9yb290OyAgICAgICAgICAgLyogSW50ZXJydXB0IHJlbWFwcGluZyB0YWJs
ZSBwb2ludGVyICovDQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCA1MTkwNjNjOGY4Li43NDdjOTg4YmM0IDEwMDY0
NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVs
X2lvbW11LmMNCj4+IEBAIC0yMzcsNiArMjM3LDEzIEBAIHN0YXRpYyBnYm9vbGVhbiB2dGRfYXNf
ZXF1YWwoZ2NvbnN0cG9pbnRlciB2MSwNCj5nY29uc3Rwb2ludGVyIHYyKQ0KPj4gICAgICAgICAg
ICAgIChrZXkxLT5wYXNpZCA9PSBrZXkyLT5wYXNpZCk7DQo+PiAgIH0NCj4+DQo+PiArc3RhdGlj
IGdib29sZWFuIHZ0ZF9hc19pZGV2X2VxdWFsKGdjb25zdHBvaW50ZXIgdjEsIGdjb25zdHBvaW50
ZXIgdjIpDQo+PiArew0KPj4gKyAgICBjb25zdCBzdHJ1Y3QgdnRkX2FzX2tleSAqa2V5MSA9IHYx
Ow0KPj4gKyAgICBjb25zdCBzdHJ1Y3QgdnRkX2FzX2tleSAqa2V5MiA9IHYyOw0KPj4gKw0KPj4g
KyAgICByZXR1cm4gKGtleTEtPmJ1cyA9PSBrZXkyLT5idXMpICYmIChrZXkxLT5kZXZmbiA9PSBr
ZXkyLT5kZXZmbik7DQo+PiArfQ0KPj4gICAvKg0KPj4gICAgKiBOb3RlIHRoYXQgd2UgdXNlIHBv
aW50ZXIgdG8gUENJQnVzIGFzIHRoZSBrZXksIHNvIGhhc2hpbmcvc2hpZnRpbmcNCj4+ICAgICog
YmFzZWQgb24gdGhlIHBvaW50ZXIgdmFsdWUgaXMgaW50ZW5kZWQuIE5vdGUgdGhhdCB3ZSBkZWFs
IHdpdGgNCj4+IEBAIC0zODEyLDYgKzM4MTksNzAgQEAgVlREQWRkcmVzc1NwYWNlDQo+KnZ0ZF9m
aW5kX2FkZF9hcyhJbnRlbElPTU1VU3RhdGUgKnMsIFBDSUJ1cyAqYnVzLA0KPj4gICAgICAgcmV0
dXJuIHZ0ZF9kZXZfYXM7DQo+PiAgIH0NCj4+DQo+PiArc3RhdGljIGJvb2wgdnRkX2Rldl9zZXRf
aW9tbXVfZGV2aWNlKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludA0KPmRldmZuLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIb3N0SU9NTVVEZXZpY2UgKmhp
b2QsIEVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIEludGVsSU9NTVVTdGF0ZSAqcyA9IG9w
YXF1ZTsNCj4+ICsgICAgVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGRldjsNCj4+ICsgICAgc3Ry
dWN0IHZ0ZF9hc19rZXkga2V5ID0gew0KPj4gKyAgICAgICAgLmJ1cyA9IGJ1cywNCj4+ICsgICAg
ICAgIC5kZXZmbiA9IGRldmZuLA0KPj4gKyAgICB9Ow0KPj4gKyAgICBzdHJ1Y3QgdnRkX2FzX2tl
eSAqbmV3X2tleTsNCj4+ICsNCj4+ICsgICAgYXNzZXJ0KGhpb2QpOw0KPj4gKw0KPj4gKyAgICB2
dGRfaW9tbXVfbG9jayhzKTsNCj4+ICsNCj4+ICsgICAgdnRkX2hkZXYgPSBnX2hhc2hfdGFibGVf
bG9va3VwKHMtPnZ0ZF9ob3N0X2lvbW11X2RldiwgJmtleSk7DQo+PiArDQo+PiArICAgIGlmICh2
dGRfaGRldikgew0KPj4gKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiSU9NTVVGRCBkZXZpY2Ug
YWxyZWFkeSBleGlzdCIpOw0KPj4gKyAgICAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4+ICsg
ICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICB2dGRfaGRldiA9
IGdfbWFsbG9jMChzaXplb2YoVlRESG9zdElPTU1VRGV2aWNlKSk7DQo+PiArICAgIHZ0ZF9oZGV2
LT5idXMgPSBidXM7DQo+PiArICAgIHZ0ZF9oZGV2LT5kZXZmbiA9ICh1aW50OF90KWRldmZuOw0K
Pj4gKyAgICB2dGRfaGRldi0+aW9tbXVfc3RhdGUgPSBzOw0KPj4gKyAgICB2dGRfaGRldi0+ZGV2
ID0gaGlvZDsNCj4+ICsNCj4+ICsgICAgbmV3X2tleSA9IGdfbWFsbG9jKHNpemVvZigqbmV3X2tl
eSkpOw0KPj4gKyAgICBuZXdfa2V5LT5idXMgPSBidXM7DQo+PiArICAgIG5ld19rZXktPmRldmZu
ID0gZGV2Zm47DQo+PiArDQo+PiArICAgIG9iamVjdF9yZWYoaGlvZCk7DQo+PiArICAgIGdfaGFz
aF90YWJsZV9pbnNlcnQocy0+dnRkX2hvc3RfaW9tbXVfZGV2LCBuZXdfa2V5LCB2dGRfaGRldik7
DQo+PiArDQo+PiArICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+PiArDQo+PiArICAgIHJldHVy
biB0cnVlOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCB2dGRfZGV2X3Vuc2V0X2lvbW11
X2RldmljZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQNCj5kZXZmbikNCj4+ICt7DQo+
PiArICAgIEludGVsSU9NTVVTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4+ICsgICAgVlRESG9zdElPTU1V
RGV2aWNlICp2dGRfaGRldjsNCj4+ICsgICAgc3RydWN0IHZ0ZF9hc19rZXkga2V5ID0gew0KPj4g
KyAgICAgICAgLmJ1cyA9IGJ1cywNCj4+ICsgICAgICAgIC5kZXZmbiA9IGRldmZuLA0KPj4gKyAg
ICB9Ow0KPj4gKw0KPj4gKyAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4+ICsNCj4+ICsgICAgdnRk
X2hkZXYgPSBnX2hhc2hfdGFibGVfbG9va3VwKHMtPnZ0ZF9ob3N0X2lvbW11X2RldiwgJmtleSk7
DQo+PiArICAgIGlmICghdnRkX2hkZXYpIHsNCj4+ICsgICAgICAgIHZ0ZF9pb21tdV91bmxvY2so
cyk7DQo+PiArICAgICAgICByZXR1cm47DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgZ19oYXNo
X3RhYmxlX3JlbW92ZShzLT52dGRfaG9zdF9pb21tdV9kZXYsICZrZXkpOw0KPj4gKyAgICBvYmpl
Y3RfdW5yZWYodnRkX2hkZXYtPmRldik7DQo+Tm90IHN1cmUgYnV0IGlzbid0IHRoYXQgYSBwb3Rl
bnRpYWwgdXNlIGFmdGVyIGZyZWU/DQoNCkdvb2QgY2F0Y2ghIFdpbGwgZml4LiBTaG91bGQgYmU6
DQoNCm9iamVjdF91bnJlZih2dGRfaGRldi0+ZGV2KTsNCmdfaGFzaF90YWJsZV9yZW1vdmUocy0+
dnRkX2hvc3RfaW9tbXVfZGV2LCAma2V5KTsNCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPj4gKw0K
Pj4gKyAgICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPj4gK30NCj4+ICsNCj4+ICAgLyogVW5tYXAg
dGhlIHdob2xlIHJhbmdlIGluIHRoZSBub3RpZmllcidzIHNjb3BlLiAqLw0KPj4gICBzdGF0aWMg
dm9pZCB2dGRfYWRkcmVzc19zcGFjZV91bm1hcChWVERBZGRyZXNzU3BhY2UgKmFzLA0KPklPTU1V
Tm90aWZpZXIgKm4pDQo+PiAgIHsNCj4+IEBAIC00MTE2LDYgKzQxODcsOCBAQCBzdGF0aWMgQWRk
cmVzc1NwYWNlDQo+KnZ0ZF9ob3N0X2RtYV9pb21tdShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVl
LCBpbnQgZGV2Zm4pDQo+Pg0KPj4gICBzdGF0aWMgUENJSU9NTVVPcHMgdnRkX2lvbW11X29wcyA9
IHsNCj4+ICAgICAgIC5nZXRfYWRkcmVzc19zcGFjZSA9IHZ0ZF9ob3N0X2RtYV9pb21tdSwNCj4+
ICsgICAgLnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3NldF9pb21tdV9kZXZpY2UsDQo+PiAr
ICAgIC51bnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3Vuc2V0X2lvbW11X2RldmljZSwNCj4+
ICAgfTsNCj4+DQo+PiAgIHN0YXRpYyBib29sIHZ0ZF9kZWNpZGVfY29uZmlnKEludGVsSU9NTVVT
dGF0ZSAqcywgRXJyb3IgKiplcnJwKQ0KPj4gQEAgLTQyMzUsNiArNDMwOCw5IEBAIHN0YXRpYyB2
b2lkIHZ0ZF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yDQo+KiplcnJwKQ0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ19mcmVlLCBnX2ZyZWUpOw0KPj4g
ICAgICAgcy0+dnRkX2FkZHJlc3Nfc3BhY2VzID0gZ19oYXNoX3RhYmxlX25ld19mdWxsKHZ0ZF9h
c19oYXNoLA0KPnZ0ZF9hc19lcXVhbCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBnX2ZyZWUsIGdfZnJlZSk7DQo+PiArICAgIHMtPnZ0ZF9ob3N0X2lvbW11X2Rl
diA9IGdfaGFzaF90YWJsZV9uZXdfZnVsbCh2dGRfYXNfaGFzaCwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZ0ZF9hc19pZGV2X2VxdWFsLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ19m
cmVlLCBnX2ZyZWUpOw0KPj4gICAgICAgdnRkX2luaXQocyk7DQo+PiAgICAgICBwY2lfc2V0dXBf
aW9tbXUoYnVzLCAmdnRkX2lvbW11X29wcywgZGV2KTsNCj4+ICAgICAgIC8qIFBzZXVkbyBhZGRy
ZXNzIHNwYWNlIHVuZGVyIHJvb3QgUENJIGJ1cy4gKi8NCj4+IC0tDQo+PiAyLjM0LjENCj4+DQo=

