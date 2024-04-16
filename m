Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D5FC04FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 07:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwcwZ-0007hy-Uk; Tue, 16 Apr 2024 03:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwcwW-0007hk-4L
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 03:09:24 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwcwP-0002Hl-MR
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 03:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713251358; x=1744787358;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sMbCcMDyVlLCJI5T0KoZZvIQxx1iioW+9svD+F3BKL0=;
 b=Qz3+mAOMH20LYKoWWMvCqvH/YerN8JtVUNYhEcm07SiyHjJxwqMfQQhM
 bOgZXHRVIFdkvq86uIBOlb+fd7S3bqyfwqtJD7Thr4dhnfvTeFzePscaj
 ZeFMo8IsH4CXjKpYzcDm7S3+zrPXKfkPPe6/cvrZxj01/3LYnyTq3Dw/y
 AZJhJodQHYzf2iQV8Oh+lzpPlgdiUwH8MwSrkl6EqRbdFPB9V/eOvPccd
 z8tNCIsL/Y64xaaAwDktS5Hm2Zld450IaSWSr558DdZ5YZCBQo//S2cyX
 fniMxN5q4xy7TzYQ2nqGj5CvUWqZnZTeEi+AEcTrZaUXr9oULmB5bUnm6 A==;
X-CSE-ConnectionGUID: k06byhe/TIKqLY9R7opPZw==
X-CSE-MsgGUID: imRgE1ryScu4u2bTPHBFAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="31153073"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; d="scan'208";a="31153073"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 00:09:13 -0700
X-CSE-ConnectionGUID: fKdxiz0CTGObpiCaJIOyjA==
X-CSE-MsgGUID: h+EkDIAuTlOU1KSXpOnUQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; d="scan'208";a="26825572"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Apr 2024 00:09:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 00:09:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 00:09:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 00:09:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP3nxv9kLAIu/vfdmbkUl/I2IICzQGKMk9HW0bFngzeuKJ4ihM84p4bbNqvh9NRYrn1KTwtfafOen57HmgXhVdQC0nA75GrURlv3HnNEg2yNwmTHaVukQHzVWDiz7MwSEq+MQSbY8Z1uZFHHhuzgTkPWuGuslmR5mImW2cY5AW74oONSp8k/9bVqSxjGvd37GE7r0hct2mcr0F0ZhbTJTZYRFpyvmcxehidMWPxHjxf9Ez2JNRjlQ6dsWJmdag6Gmgs4KVz/kakWCNSedog6mGbvFOXAnzL7ABP0FFrFhXSl5XjY/DWAuBKJ4cJsNQdpCklRquby66tYwvw87rfDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMbCcMDyVlLCJI5T0KoZZvIQxx1iioW+9svD+F3BKL0=;
 b=TYK1eYlltC09NEeQqC9FrzAfintztLWrhxH2HZLogjBg07WoH5RbIZPP28N64kIU0iqag6jdvdQJMKm18YoKRWkMoq/QK3VMSxvqfdeJ5mRMG4ip1c/Qvsr+0LBL6lXMNS0FcS2mUS/85/TR3SitxTZoqjNnn7hpxtEz3OE7nWBvDh9MnHqa+dSsUwyl9eQ7hBx3G084BLIHv/UEXJqn0yjDzmVnFroWvKPwUjwnTPKMJ6mFjOHGue/PQ13GbYdoS5gySB8c/iOW5gW49qlvNpIbAuKapteEvfGJH49Q+P7v+Zsk3nhQ9MnyYiBWSAkuFrF0uW8FlIHvrZZ55vGxrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN0PR11MB6303.namprd11.prod.outlook.com (2603:10b6:208:3c1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.28; Tue, 16 Apr
 2024 07:09:04 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7472.025; Tue, 16 Apr 2024
 07:09:04 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v2 3/5] intel_iommu: Add a framework to do compatibility
 check with host IOMMU cap/ecap
Thread-Topic: [PATCH v2 3/5] intel_iommu: Add a framework to do compatibility
 check with host IOMMU cap/ecap
Thread-Index: AQHaiZFH29IOEDl1dk20/jsEyJLG5bFpgLMAgAD2WaA=
Date: Tue, 16 Apr 2024 07:09:04 +0000
Message-ID: <SJ0PR11MB67443BF6BC7CABCE28F482A392082@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408084404.1111628-1-zhenzhong.duan@intel.com>
 <20240408084404.1111628-4-zhenzhong.duan@intel.com>
 <251715ae-5378-4dfb-bc14-47ba2e62f83a@redhat.com>
In-Reply-To: <251715ae-5378-4dfb-bc14-47ba2e62f83a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN0PR11MB6303:EE_
x-ms-office365-filtering-correlation-id: 184d197c-3790-49b9-374c-08dc5de419c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OfZpLM6giHLJswQPTq4Y86durHXwcc8pMDlWDeZslHLvtQmUe09FosNJKAPrbpK8/EUfw5jSJybXEHdilgCR2Iw4unsa16UogjUIp+VXCORQi7p6co174MUWGeFALi+ef4E2Y2SNleqzJticwITesq44MOygJgajKhTpcZLa7Pzrd++0sdnWJUDNgGB9tcCSOKdBUel5nqSE5slRBKLx/CwKVmMjZ4SiLlnkKVEORb4B2qdiZXBL+E+d1hXJ6yj9aYad7B3eqnrZFZc6mBqfDg9FP3i2fJyZ9N9T6nKXUV0POfOyVUeva5EiTgal7PNxoThJE2ZRJTLWIlyfB2WamxFQ/753yT2tXQB/30TrcqPVx+OttGA87zG/bRG38E5Flle8Sn8R2C16YRKPgc9Ehicla4acQJUB3HQVnMsxthK355/ralkltvAh1HruyoCuUiYQQsKmU7TdzoDYhc+w7EUbq8j4+geiuI2oeSve8Oyw18yPsATC+L17J67RlpWgI/dM0yhsQPamk+LyuW6w7JDZTNDDimUcuWg8LSVVJArdNO62Dz3Q4dvPZWSeswyfCOKt8BuMi1zeu/z99z1tHxk04GxY4Qqf2HVQrSLQoRrjqNq/62ve7+raJOTWEZ7887wntsTNVZyuvM9jftHEcMbK/S9QdwD4bFQXy4Dw5Hw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WU5pN0tCWWFLWm8vQ3lESDlyYmJWQmhtK1JOekthZm16OG9BTUZzejJJWjJK?=
 =?utf-8?B?bmRHekMzdWlzYzdleVRoeHFVNzF6NjVkQzdyYVRlbVQ5YlhPcU1lUjVGOUlt?=
 =?utf-8?B?VlQxRlBWWGVxSFYzaUdSV3FidmFxNEhGeHQ4WjFXZkpIUUlOcXlZZHJMdm5y?=
 =?utf-8?B?YlJIYURNNC9Ib3YxaXdDdE9iWGJhdm4wd2RGSm1yUWhIT2xkSnBZdmxsV2ZL?=
 =?utf-8?B?K0U5VVJFNy9OT1I2bVdieTBHV0ZyL3JhZGw1Z0NZUXdSVXB6VjRHUHZSaWlz?=
 =?utf-8?B?STE5OURxMklFdHNpdXhvOEw5TGViUVJldFNhbDdyaWFjNC9mLzdYNHpFOG5I?=
 =?utf-8?B?bFFidU5uWE40NWpOYkwwdWVlemY5dGhkdzdwd2FpZ1NqdC8wQUgzOVYxb1Uw?=
 =?utf-8?B?YmFRa0pOTW1ROW5YdzIrR1BFUWM1L3o0ZTFaaVJwaVhYeHJIcUVXK2trWlBt?=
 =?utf-8?B?SmU5Y2Y1bnF5T1k0OWRidFp4dXljTDJFR1FzNDNlY0Jyc09oUmVvQ2hrR1Iz?=
 =?utf-8?B?T0hwb09aMkRCNlhQNGYvaXczeks2RmNWMC9qemxEU1cxUUFzT1dWZCs2RjVw?=
 =?utf-8?B?Z1IyQjBiTUNDL0hxeTJsMXQ3UzVNcGxmZFhHUGtjWDYyVVZYMnd6YUZZRkg4?=
 =?utf-8?B?NU1PQ01WbzgrVXA1Sk5RcU9ka3JqbkIxRjNkNjJNTlVzRjJKRnVpWTdFREVG?=
 =?utf-8?B?WWxsRjJtUHVwWWxhcnpyVFU4eUtmMmZxb20ySjJJOEFyTjVBdnJPRjA4d3dl?=
 =?utf-8?B?b1VOTGVsUmhJazMwUzNNSjhITHZBVFhweVRFNHFQNFIrMkI4TDRjUWhnVmJD?=
 =?utf-8?B?elFRYkVEL0tRQ1JNdHp5cTJyYklRZFZobVNCODJFYnpXRndMQ00vZ0FQeUd0?=
 =?utf-8?B?R09VNmNCNjExY0RUZm1ML2hyeXF6Z1BXSngrdnZvU3g3RUlMbmt2UlRwYWNp?=
 =?utf-8?B?MG5YeGh2TlJkcVc0L3hnekxxV3M4blRuVmh4MDFzYW85SzhtYVloR0srRmpE?=
 =?utf-8?B?UFlCOWZWVHNWRmxWRkFMcmhrRzIrVGZZV3Azb0tPYlpjUk96VWxYZnhtVEo4?=
 =?utf-8?B?MFNUbmx5bmV0RlNhdEFZOHpNNkYySFJWOXlyREFNY1ppbHRjTFRrZUVEckpP?=
 =?utf-8?B?ZkFtYXFSUmx6Y2g3WXlucG1tQ1F3cFFFV0RBazlUUUNzUWxLaVJpY1QvTGZ0?=
 =?utf-8?B?aHdpZkZTdU9kTU4zbEp5RnNaUGhGWTE1NEd1V1lGRVhzUERjMnMweWlRUjQz?=
 =?utf-8?B?U2FPVUxNVU12ZDVCYUxVUmxXd3A0OSs0Lzh4bFZtZ1lEQS9nQWVsZjcrVFlK?=
 =?utf-8?B?K1V6L2YvS3hrWWJVRU1Kc0o2SHo1SkVBRkdTdXloMkZnR1RjeG41NmRVVGpV?=
 =?utf-8?B?Q0FyZUhnd1ZWeTkzL25WeE9iZlpDTWpPWHRaV2Fhd3FnMTc0cHJvZjlzbW1Q?=
 =?utf-8?B?K1hYbWowNUEzbk9RdWU3ZUpDUnllRUI4bHdTK1Znd3BCWldoM05TQlh6SkVy?=
 =?utf-8?B?K2VaQktnUzZjQW5pRCt3Y1BYVGc1TGM3aElFVzU5a05JL2kxcFhFS1lFOWJl?=
 =?utf-8?B?Tnl4cHZtTkhiL2JYZUtyOWkvZGlJbW5TbDU5WkJlejJ4cVlycFJSa0ZwRlFp?=
 =?utf-8?B?d3p4b2VYR3J4WlprQnJtK0xSai94TVYyeXFWbExCU3RaY3pISXlmVlVFc1ZF?=
 =?utf-8?B?cUMrdkVNS2QwRVhwZ20zNGExNnZKWDFTMXVlTFRTSUlGUVpNdjJJdUdsUlRH?=
 =?utf-8?B?M2pzNUdPVFlNa0pZOHpmUkZjSlFpRFJJN0M0eFlYUEFCeWJuNzkvY0RvYUI1?=
 =?utf-8?B?ZFdlaFNUd2NZdmhQQmtja1RQVmZ6MXJWb0lQRm1nZ1diQTZIRnJJalE4b3pX?=
 =?utf-8?B?TlNySVdJc2llZk15SXFoMi91aEJKa01xMzFoUGZac0MxTkNDd2VzQXZCQUs5?=
 =?utf-8?B?NGM2elBSeGdpM1JNa3lRNnFlNDdQYXdIK3M5anhyemh3SjdyeGpaMFhIbitv?=
 =?utf-8?B?Vyt6dmsyVnhJUnA3SUU0WGpPYTV5SEgwMTM5SWlvUHlsZC9Gc3hHVDJUVUx1?=
 =?utf-8?B?RTNBZ2l3K05aaEZ6YWNjVFBqMXBDTkZ4ZXh5c3laMGZlcUdmY3RIUjR0YXpU?=
 =?utf-8?Q?xXX5eRRU/tlCBLq1jYZseCFkd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184d197c-3790-49b9-374c-08dc5de419c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 07:09:04.6275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YvY5MrxrGIOMo4muDSABk6645q2efCmc8EF61kJTeG/TmIMxmYrOOxSWiSniqvMcGVHqBTHZHZf1v/FQf6V4/NJmWhygglGUHfPHy1MWu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6303
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy81
XSBpbnRlbF9pb21tdTogQWRkIGEgZnJhbWV3b3JrIHRvIGRvDQo+Y29tcGF0aWJpbGl0eSBjaGVj
ayB3aXRoIGhvc3QgSU9NTVUgY2FwL2VjYXANCj4NCj5PbiA0LzgvMjQgMTA6NDQsIFpoZW56aG9u
ZyBEdWFuIHdyb3RlOg0KPj4gRnJvbTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pg0K
Pj4gSWYgY2hlY2sgZmFpbHMsIHRoZSBob3N0IHNpZGUgZGV2aWNlKGVpdGhlciB2ZmlvIG9yIHZk
cGEgZGV2aWNlKSBzaG91bGQgbm90DQo+PiBiZSBwYXNzZWQgdG8gZ3Vlc3QuDQo+Pg0KPj4gSW1w
bGVtZW50YXRpb24gZGV0YWlscyBmb3IgZGlmZmVyZW50IGJhY2tlbmRzIHdpbGwgYmUgaW4gZm9s
bG93aW5nIHBhdGNoZXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBp
bnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVs
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgMzUNCj4rKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMzUg
aW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMg
Yi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDRmODRlMmU4MDEuLmE0OWI1ODdjNzMg
MTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYv
aW50ZWxfaW9tbXUuYw0KPj4gQEAgLTM1LDYgKzM1LDcgQEANCj4+ICAgI2luY2x1ZGUgInN5c2Vt
dS9rdm0uaCINCj4+ICAgI2luY2x1ZGUgInN5c2VtdS9kbWEuaCINCj4+ICAgI2luY2x1ZGUgInN5
c2VtdS9zeXNlbXUuaCINCj4+ICsjaW5jbHVkZSAic3lzZW11L2lvbW11ZmQuaCINCj4+ICAgI2lu
Y2x1ZGUgImh3L2kzODYvYXBpY19pbnRlcm5hbC5oIg0KPj4gICAjaW5jbHVkZSAia3ZtL2t2bV9p
Mzg2LmgiDQo+PiAgICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KPj4gQEAgLTM4MTks
NiArMzgyMCwzMiBAQCBWVERBZGRyZXNzU3BhY2UNCj4qdnRkX2ZpbmRfYWRkX2FzKEludGVsSU9N
TVVTdGF0ZSAqcywgUENJQnVzICpidXMsDQo+PiAgICAgICByZXR1cm4gdnRkX2Rldl9hczsNCj4+
ICAgfQ0KPj4NCj4+ICtzdGF0aWMgaW50IHZ0ZF9jaGVja19sZWdhY3lfaGRldihJbnRlbElPTU1V
U3RhdGUgKnMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSG9zdElPTU1V
RGV2aWNlICpoaW9kLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9y
ICoqZXJycCkNCj4+ICt7DQo+PiArICAgIHJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0
aWMgaW50IHZ0ZF9jaGVja19pb21tdWZkX2hkZXYoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIb3N0SU9NTVVEZXZpY2UgKmhpb2QsDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICt7
DQo+PiArICAgIHJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW50IHZ0ZF9jaGVj
a19oZGV2KEludGVsSU9NTVVTdGF0ZSAqcywgVlRESG9zdElPTU1VRGV2aWNlDQo+KnZ0ZF9oZGV2
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4+
ICsgICAgSG9zdElPTU1VRGV2aWNlICpoaW9kID0gdnRkX2hkZXYtPmRldjsNCj4+ICsNCj4+ICsg
ICAgaWYgKG9iamVjdF9keW5hbWljX2Nhc3QoT0JKRUNUKGhpb2QpLCBUWVBFX0hJT0RfSU9NTVVG
RCkpIHsNCj4+ICsgICAgICAgIHJldHVybiB2dGRfY2hlY2tfaW9tbXVmZF9oZGV2KHMsIGhpb2Qs
IGVycnApOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHJldHVybiB2dGRfY2hlY2tfbGVnYWN5
X2hkZXYocywgaGlvZCwgZXJycCk7DQo+PiArfQ0KPg0KPg0KPkkgdGhpbmsgd2Ugc2hvdWxkIGJl
IHVzaW5nIHRoZSAuZ2V0X2hvc3RfaW9tbXVfaW5mbygpIGNsYXNzIGhhbmRsZXINCj5pbnN0ZWFk
LiBDYW4gd2UgcmVmYWN0b3IgdGhlIGNvZGUgc2xpZ2h0bHkgdG8gYXZvaWQgdGhpcyBjaGVjayBv
bg0KPnRoZSB0eXBlID8NCg0KVGhlcmUgaXMgc29tZSBkaWZmaWN1bHR5IGluaSBhdm9pZGluZyB0
aGlzIGNoZWNrLCB0aGUgYmVoYXZpb3Igb2YgdnRkX2NoZWNrX2xlZ2FjeV9oZGV2DQphbmQgdnRk
X2NoZWNrX2lvbW11ZmRfaGRldiBhcmUgZGlmZmVyZW50IGVzcGVjaWFsbHkgYWZ0ZXIgbmVzdGlu
ZyBzdXBwb3J0IGludHJvZHVjZWQuDQp2dGRfY2hlY2tfaW9tbXVmZF9oZGV2KCkgaGFzIG11Y2gg
d2lkZXIgY2hlY2sgb3ZlciBjYXAvZWNhcCBiaXRzIGJlc2lkZXMgYXdfYml0cy4NClRoYXQgdGhl
IHJlYXNvbiBJIGhhdmUgdHdvIGZ1bmN0aW9ucyB0byBkbyBkaWZmZXJlbnQgdGhpbmcuDQpTZWU6
DQpodHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvYmxvYi96aGVuemhvbmcvaW9tbXVm
ZF9uZXN0aW5nX3JmY3YyL2h3L2kzODYvaW50ZWxfaW9tbXUuYyNMNTQ3Mg0KDQpNZWFud2hpbGUg
aW4gdnRkX2NoZWNrX2xlZ2FjeV9oZGV2KCksIHdoZW4gbGVnYWN5IFZGSU8gZGV2aWNlIGF0dGFj
aGVzIHRvIG1vZGVybiB2SU9NTVUsDQp0aGlzIGlzIHVuc3VwcG9ydGVkIGFuZCBlcnJvciBvdXQg
ZWFybHksIGl0IHdpbGwgbm90IGNhbGwgLmdldF9ob3N0X2lvbW11X2luZm8oKS4NCkkgbWVhbiB3
ZSBkb24ndCBuZWVkIHRvIHVuY29uZGl0aW9uYWxseSBjYWxsIC5nZXRfaG9zdF9pb21tdV9pbmZv
KCkgaW4gc29tZSBjYXNlcy4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

