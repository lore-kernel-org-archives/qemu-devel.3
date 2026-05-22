Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14E7CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 06:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQJFY-0005G7-GE; Fri, 22 May 2026 02:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wQJFW-0005Fu-Ag
 for qemu-devel@nongnu.org; Fri, 22 May 2026 02:20:46 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wQJFT-0001Ac-HD
 for qemu-devel@nongnu.org; Fri, 22 May 2026 02:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779430843; x=1810966843;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qPocOtRDLpkNgZAihRdDN8YyzMGe/MCuH+0YWGx3OrQ=;
 b=Tm6kRDtPfjYOYXYGiB8aWcjVQuEJyiwOXZN+IDXGhYFYn50Fe+AsQxEk
 Unsaae8BGJ/Nxj6+VWG8PNV6qMxLaDCN95QDH1CJsm10oXJumLsYzAqBd
 xcvq5XhWQQPV48a/KZ6VAI7MPrNxcFOgSdeRwpGaI/iwSHhBfOTHu+3FU
 V80VnktqthifyiYOkVovRbL0GCIP6UnXOryTUdjfj5GJvMfHC5KT7AK8d
 HxPw29Hq2jKw3aPSUP6fk+WS1welL0UfnQS5x4EUngMplE3SjqyBqHQgE
 hBfvsnD2Y9gxwiCJqTtR8OVHfQ5OyTNMo/3sxEkSa2UMFlVAhR69NZk+/ g==;
X-CSE-ConnectionGUID: bEnLmTzZQOyx639d8p+w3w==
X-CSE-MsgGUID: KuBqPeKrR+u8VRkX7YSQdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91047628"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="91047628"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 23:20:41 -0700
X-CSE-ConnectionGUID: QCnb+Y+kS7SsFqNQJJAdEw==
X-CSE-MsgGUID: Qu+7tzY6TwuDXZrUkycxpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="264351687"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 23:20:41 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 23:20:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 23:20:39 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.71) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 23:20:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKKTwn1hmbEZVtnn8YoKvbbL0iDMCOuKoE7Rvk8D3uLRdT+FqNi4cvfZFDmF1ortduQyyx46iwEG07kgF+dDjv47qKDQ0CZsi3yXwUIScdtZ8vTaHru9m+ZCAaJvmUILqXMbp9dcovyfaV2G3Rn0FyR1nC1H/7bsjRRyFj1aRCI0EgxKp6gx/TZRCAweM/IgipocHh/pYpmZWzk7O16NK5msRjtmUDGHQ/bLIN6BcuADecvL3VczJ9e6jFCirwSmshFSMyForFcsiPCh9Z/A4OGkx8AmgLxzhmmJQEy2d3kpRarOOEZRjYQAsni0VnDbJLMjDPjzGcAPMGZTsq2ZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPocOtRDLpkNgZAihRdDN8YyzMGe/MCuH+0YWGx3OrQ=;
 b=CbJUp6CMFR8+e+rUPvSV6gqWHr7+1W8opkb0tVhjbpIHyDRLad59C8tOcUnxnGxLaJGNIaktozjElfA/ko8p0wB/hj4WjeuyqaoC55oMY03yaAZoa4ZRRTi4TJpWG57+xoC9yILtcrAgV8W3pz+yd+8zWPYt01a2WP/EcxW/jHQ7OJK2BU0i9wCc0ZGUvv/AiAGyVJCwtvZ66Q/f6d8hMLI4mcodMOyrDvyBa1I0MFJkYwPpr0LSJJIU6NrYAuWOG0aaC6LMb/MjQ6XUKPY2wHRG+FBL8+7r+EMsAQgfxWsrOjaIVE3FxfF3T36w6+jJEP0k6KMK7Y9O4zgnWHWAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB7256.namprd11.prod.outlook.com (2603:10b6:8:10c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 06:20:32 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9913.009; Fri, 22 May 2026
 06:20:31 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v5 10/15] intel_iommu_accel: Handle PASID entry removal
 for pc_inv_dsc request
Thread-Topic: [PATCH v5 10/15] intel_iommu_accel: Handle PASID entry removal
 for pc_inv_dsc request
Thread-Index: AQHc32mg4oXI8zixW0uZHfCp60fO67YNafCAgAwEaZCAACpEAIAADc0w
Date: Fri, 22 May 2026 06:20:31 +0000
Message-ID: <IA3PR11MB9136F4193E5334152DDD6048920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-11-zhenzhong.duan@intel.com>
 <829fcf6f-39e4-4d21-9f08-2772c0813c32@intel.com>
 <IA3PR11MB91369A610C7F2DDEC9F2D5BD920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <1d15367a-d28e-40cf-b051-6c047392a3c9@intel.com>
In-Reply-To: <1d15367a-d28e-40cf-b051-6c047392a3c9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB7256:EE_
x-ms-office365-filtering-correlation-id: d1d8450d-064f-4bbf-13fe-08deb7ca3a15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|56012099003|22082099003|3613699012|38070700021|11063799006|3023799007|4143699003;
x-microsoft-antispam-message-info: GwS0/ejGaesBDsiWkfdtXBsUhfszWfFQ64NioWXM3Va7j/E08NlT8aaXjgsA62WV26ZtMFYop6j/MVsjzi3P59Rbm24/fg4uajt51ZILu3TrBMsq2tE0a9JCPG2Inuk6hzkNJtNbMRZpWN7+83l0PliWDvDtq9C/hCzr+z1I9b+p5Vwuo0yabD0eljg2Z5QRyAvPJ8vr5Y6weEhMGqDnCKmvKCH9VQGaD6rSSLN+9TugIyk5j8OK29lbmzzcCxb3EMLjqtVvUSl623WqRjGacYRa2eUE7JV7QcXde0Gu25C+W2NWzz9JEHr38s95ZwHNVs/lq97ddmcGU+LKSD9+s8pb/Y/24TXnvzEByjKqwFPn+PqyL6drSoySyWPtwXY8VmY+Jd7OLnM+Qv/bslClmR9BserQpIpsQL0FEA5qAh978A43jmm0Cm2DJuBKbqRdMCFPl3vl/5PvuLWhgenTW8bv3JZiow0MJ+cIMNAyQIlcTgR756JaTP6PuosMLU5V5uuabm1Yu4kl8g94uTzqW76kg2nFViIg6VTQDNafg3/1HjWROZaJoDmY7pJhooOxEM1b3wKDgLy9uVap8WntkrHGATnpV7zOEvRQcxaXS1wtnD+horZlz5jobXEyt3xEuJ6fqk3TBQf6k8w4wHvwamdkAShKviW2tb0i4o48pq+U96DgqJvuGtDigp7VaZ1DzzxCxfFshWseEETE538JNUkRtj+02Vq4Tb9XomVkp5WggeIaMcPw4+Xa4H7EfDFlzruazcpq5izo4O5GVvQ+nQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(3613699012)(38070700021)(11063799006)(3023799007)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXg1Sm05MFpTZ3RwbDR4L1FXY2g2T2NETlB6eTBWdU1ZM3ozaEc0aFV0c3Bt?=
 =?utf-8?B?bnRMdENPMXRkM2FQaHBCZ08vUzN2YXU3b1RuYWxGRkhHY1E5TkVlZHV4cHo1?=
 =?utf-8?B?ejcwd1F3SjJxSjFnWklFSlZJUE04RkpsYWY0YkNrVTVQTkwzL0xqUXVBRksw?=
 =?utf-8?B?ZWJVNnRjYkRydVdLcmJuOU9NN0xvTFA4SlpzV1l1WkNDSUYzYWMxaEJuUWVM?=
 =?utf-8?B?bzUxVXRHQnRkaDNka0FOUHAvbkpGRGlEY3A4RmNyTW1ka3BoUUpPT2JLc2xG?=
 =?utf-8?B?SHB5VGkrdFlNUVl5eHArOVJPZnJTY01NeTBEQnZ4SjBIYkZFaVNUUjRreklB?=
 =?utf-8?B?RlJHQUh5dEJ5OVZyWU9TeEtRTWxtZ210ZXFPS2RmOHRZcU05UDcrVlJNeXFB?=
 =?utf-8?B?ekN5NnFRQ3ZPRlFWMXRQS2I3WnF0TXQ1bEt3aktxc0N1R1NvNUNHQVhoMkpK?=
 =?utf-8?B?WUlRc0xSOElOYW9INDdvL2FyZUZWM1dHRDJDWEswbjZJQ083MDB5NGE0SVRj?=
 =?utf-8?B?K1RiK3BXRWZndkw1TlpvSnlrK2RQRFNzVTd5THBPSkQvdEZ1cVliYjZlcW5B?=
 =?utf-8?B?ZDFralp2THZQREFtQndTalNpUkhmV0NzSmdxWlBucDZ1VG50b3NKeWpIUzA3?=
 =?utf-8?B?L3BicmVKSE9kV3VrUGJDa3JoZ01aU3UwMWw3L1pDeTIzUTk3cTBjM2ZkaDJv?=
 =?utf-8?B?RXJXQ1lxaGFUZEIxZ0lWSkVjY2M0cEVHL0dLZnl4emNOWTcwMGY1OHBCL3lG?=
 =?utf-8?B?WHdPL1RUeXpXUDBCRENCTlA0YVFOaFdQdlRkcEZXeUdOM1pJcWV0UU9ibU55?=
 =?utf-8?B?STc5Z1Boa0prQk5hUGRKa0xYekRmNTJSdmFPUGpGbG9kcHVONDN5azk5SUc0?=
 =?utf-8?B?TjRaRXczS1cxcmtKOFl2RkJPdkF6VE14amw1dTdjczUrdnlhQ09SdUtKNGNk?=
 =?utf-8?B?Y1dTSEtqa0FaWUxhZHdJWTcwTEwrMFNXM1gzaUl6N21scUF0eCtNLzJHd2Rr?=
 =?utf-8?B?dm81elJyUjFUWWpIRlNGMVhVdFdPb1FHQXRVeTNoZUcvR1BIOGlHa0I4QWJH?=
 =?utf-8?B?Y0ZJWmtoZXZ5RjhhdzZjdGtxbWVXR0htVXBQZDRJQnFJN0d2WmtYTUt1SE84?=
 =?utf-8?B?MkV4aW9FdzRIekhvV3dOKzlwYlR6WHVBT29FckE2YTV5b3NzNlpManhJTzI2?=
 =?utf-8?B?eWozYmR3R0ozVWM2bEZaL2tKclRia3M2YTdIdUR0aUFpTkg0aHhQYjl4Qlgz?=
 =?utf-8?B?aGpvdVNNZUFqVWJaZ0E1Q1g0MDQ1ZEZHc0ZqOU9TTHREWjZDUXVwWVYxTTNC?=
 =?utf-8?B?R2RCMnFUQU00YTJ4TTNHa3BBUFNORHRUVGRSRjV1ZGVIeWQvalB6M1FqbmFz?=
 =?utf-8?B?UldTTkVTTkNNbjVzMEJJZXl5TjNicm1zSDg5U0lpS21JdWROb0ZsMVhtcFpU?=
 =?utf-8?B?cWQxY011UHQzSkFsaU1zOGV1VlZUY0lxcDdJdjkrMGFHWVFNSG5tcDFMQW16?=
 =?utf-8?B?YStQa0tDeitaUE5MWkpCTnRhcW5CSTJCb3F2elJDYW8wQmRoWjhCTXFxS1Fy?=
 =?utf-8?B?UEphU0c3amcrNEsvSXBsTGZiZXRXSnYrckJHR3g1VnZVRUNQR2R5ejhIMEx0?=
 =?utf-8?B?VndWdzBJWkc1clZ1T2NaZVpiWkpOa2RyQll5VU5FWTVlNU9VaFlMR0ZxU2dL?=
 =?utf-8?B?RVJSUERTM2ZER2djd21TTXZta1ZPT2lYaE9Jb04rVW5RMldsSnJQLy9BbFBQ?=
 =?utf-8?B?c2o1bk9mdHowYldhZlhBTy9GYVBNa1ZmYjQ2ZXJHamw1aGhBMkdldlVkL1Ra?=
 =?utf-8?B?Q3B3YS9vMDJTYnlDa1dEcnFsMmRmU0w2WXYzWmNhdUlTVFJySlA2K2xPUVVN?=
 =?utf-8?B?NHd5QVNsbEVxMEE0SzR3NUdDeExrYk1mTmNsUmsyRlhNUlJGUnhDUGk2aDFP?=
 =?utf-8?B?YkJaaFFxdVEvdUV5RkJ5aUJ2NWhPSTVSeUFzQ2dsU29aTTRUYURhL1pmOTVy?=
 =?utf-8?B?cXM4M1ovN1VrVEJzeXBjVldOb3dPUEhhTk5KWmxPRHJwcmpRV3VYUGd2TEVw?=
 =?utf-8?B?ZjIxVkp2RGdkbDE1SUt0VWZibmNNYUZ3V1VtSkhWMFB5cDJyR3Y5Nit1TU93?=
 =?utf-8?B?RThGcEREYkwxZnpXTW9CdzlNR1d2YzhhUGxaYUhnM2pzZ0JzVWpDMm1YZVpa?=
 =?utf-8?B?VjEzZmxIWDhBS1VSYnZoUDRrOUE1U3NLYVgxSkhRVFhzYnBsaE01RS9INDNV?=
 =?utf-8?B?WjBWZzNyOFVRVVBBMEJQNFFkZXZkbUo4d0xDcGxoL0Z3a2FDaW9ocndiRk5R?=
 =?utf-8?B?WlA3MHFDSng1WHcvQ0p5Y2oycE9SZUJjalFPR0xYak1vOU1walFtZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mgn4omyFfCjJLOYcOahvd+IbT0JGv1qNJShadH1iv8O0kSmlD2dhd5GY8jcb3nQ3lPn2eqhhSD0VY8yjgyb6cH7vHUOXBh6gxeRdidXH6OuU/NPy1f3Tsym/MJzI45r/7ZF10212ar+QcyREN6zyzxEO5dtqD8iBIH4rnIutXrE0EYgp2Fkz6dWClrYLMfoOnZin9S25zd948sLiYWG2HdKrbJFIB5B6VS6mOUrMK2fhMQmNVx6Rgu0HjaDhTLlbzh9TRer6cGod49eT8R+LCKxTXLQiVW2yCBH9PHE0jP8e/xHecsKcgerdZXONVuhH6FgkcrrULBT7sf32BLnU5w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d8450d-064f-4bbf-13fe-08deb7ca3a15
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 06:20:31.8813 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPgXy85twGWIJRXKDYQupQ1NZCkhUfw/V11PXakEK+AMDI8suwlRg55Vno3E7uO/YpN0LCUIsF6VZzQveSn5nf/dimwEfnKlW+Ni8C9W+GE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7256
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTAvMTVdIGludGVsX2lvbW11
X2FjY2VsOiBIYW5kbGUgUEFTSUQgZW50cnkgcmVtb3ZhbCBmb3INCj5wY19pbnZfZHNjIHJlcXVl
c3QNCj4NCj5PbiA1LzIyLzI2IDExOjA3LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4N
Cj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IExpdSwgWWkgTCA8eWku
bC5saXVAaW50ZWwuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTAvMTVdIGludGVs
X2lvbW11X2FjY2VsOiBIYW5kbGUgUEFTSUQgZW50cnkgcmVtb3ZhbA0KPmZvcg0KPj4+IHBjX2lu
dl9kc2MgcmVxdWVzdA0KPj4+DQo+Pj4gT24gNS85LzI2IDEyOjA4LCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4+Pj4gV2hlbiBndWVzdCBkZWxldGVzIFBBU0lEIGVudHJpZXMsIFFFTVUgd2lsbCBj
YXB0dXJlIHRoZSBwYXNpZCBjYWNoZQ0KPj4+PiBpbnZhbGlkYXRpb24gcmVxdWVzdCwgd2FsayB0
aHJvdWdoIHBhc2lkX2NhY2hlX2xpc3QgaW4gZWFjaCBwYXNzdGhyb3VnaA0KPj4+PiBkZXZpY2Ug
dG8gZmluZCBzdGFsZSBWVERBY2NlbFBBU0lEQ2FjaGVFbnRyeSBhbmQgZGVsZXRlIHRoZW0uDQo+
Pj4+DQo+Pj4+IENvLWRldmVsb3BlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+
Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+
PiBUZXN0ZWQtYnk6IFh1ZG9uZyBIYW8gPHh1ZG9uZy5oYW9AaW50ZWwuY29tPg0KPj4+PiAtLS0N
Cj4+Pj4gICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jIHwgODANCj4+PiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA4MCBp
bnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
X2FjY2VsLmMgYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+Pj4gaW5kZXggYTY2ZDYz
YjRjOC4uODJiZmJkZjQ4NCAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9h
Y2NlbC5jDQo+Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4+PiBAQCAt
MTYsNiArMTYsMjggQEANCj4+Pj4gICAgI2luY2x1ZGUgImh3L3BjaS9wY2lfYnVzLmgiDQo+Pj4+
ICAgICNpbmNsdWRlICJ0cmFjZS5oIg0KPj4+Pg0KPj4+PiArc3RhdGljIGludCB2dGRfaGlvZF9n
ZXRfcGVfZnJvbV9wYXNpZChWVERBY2NlbFBBU0lEQ2FjaGVFbnRyeSAqdnRkX3BjZSwNCj4+Pg0K
Pj4+IHRoaXMgaGVscGVyIGlzIHRyaWNreS4gdnRkX3BjZSBhbHJlYWR5IGhhcyBhIHBlIGNhY2hl
ZCwgdGhlbiB3aHkgbmVlZA0KPj4+IHRvIGRvIHRoaXM/DQo+Pg0KPj4gSXQncyB1c2VkIG9uIHBj
X2ludl9kc2MgaGFuZGxlciBwYXRoLCB2dGRfcGNlIGNhY2hlcyBvbGQgcGUsIHdlIG5lZWQgdG8g
Z2V0DQo+cmVmcmVzaGVkIG9uZSBpbiBtZW1vcnkuDQo+Pg0KPj4+IEkgdGhpbmsgaXQncyBiZXR0
ZXIgdG8gaGF2ZSBhIGhlbHBlciByZWNlaXZlcyBzLCBkZXZmbiwgYW5kDQo+Pj4gcGFzaWQgaW5z
dGVhZCBvZiBhY2NlcHRpbmcgdnRkX3BjZS4gYnR3LiBJIHRoaW5rIHRoZSBpbnRlbF9pb21tdS5j
DQo+Pj4gc2hvdWxkIGhhdmUgc3VjaCBhIGhlbHBlci4gaXMgaXQ/DQo+Pg0KPj4gSW4gaW50ZWxf
aW9tbXUuYywgdGhlcmUgaXMgYSBoZWxwZXIgZm9yIHZ0ZF9hczoNCj4+DQo+PiBzdGF0aWMgaW5s
aW5lIGludCB2dGRfZGV2X2dldF9wZV9mcm9tX3Bhc2lkKFZUREFkZHJlc3NTcGFjZSAqdnRkX2Fz
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlREUEFT
SURFbnRyeSAqcGUpDQo+Pg0KPj4gc28gaW4gaW50ZWxfaW9tbXVfYWNjZWwuYywgdnRkX2hpb2Rf
Z2V0X3BlX2Zyb21fcGFzaWQoKSBpcyBhZGRlZCBmb3IgdnRkX3BjZS4NCj4+DQo+DQo+Z290IGl0
LiBWVERBZGRyZXNzU3BhY2UgYWxzbyBjYWNoZWQgYSBwZSwgd2l0aCBhIGNsb3NlciByZWFkLCBp
dCdzDQo+dHJpY2t5IGFzIHdlbGwuIENvdWxkIHlvdSByZWZhY3RvciBhIGJpdD8gZS5nLiBhdm9p
ZCB1c2luZyB0aGUNCj5WVERBZGRyZXNzU3BhY2UgYXMgYW4gaW5wdXQuDQoNCkFkZGVkIGFzIGEg
cHJlcGFyaW5nIHBhdGNoLCBsZXQgbWUga25vdyBpZiBhbnkgbWlzdW5kZXJzdGFuZGluZ3M6DQoN
CmNvbW1pdCAzMWZjNmU0MDlmMjg1YTJhOTNmMDlmOTlmZDI3MWQ0YjAxZDg3YzUzIChIRUFEKQ0K
QXV0aG9yOiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KRGF0ZTog
ICBGcmkgTWF5IDIyIDAyOjE0OjMwIDIwMjYgLTA0MDANCg0KICAgIGludGVsX2lvbW11OiBtYWtl
IHZ0ZF9kZXZfZ2V0X3BlX2Zyb21fcGFzaWQoKSBtb3JlIGdlbmVyaWMNCg0KICAgIFJlZmFjdG9y
IHZ0ZF9kZXZfZ2V0X3BlX2Zyb21fcGFzaWQoKSB0byB0YWtlIGluZGl2aWR1YWwgcGFyYW1ldGVy
cw0KICAgIChJbnRlbElPTU1VU3RhdGUsIFBDSUJ1cywgZGV2Zm4sIHBhc2lkKSBpbnN0ZWFkIG9m
IFZUREFkZHJlc3NTcGFjZS4NCg0KICAgIFRoaXMgbWFrZXMgdGhlIGZ1bmN0aW9uIG1vcmUgcmV1
c2FibGUgYW5kIHByZXBhcmVzIGl0IGZvciBleHBvcnQgdG8gYmUNCiAgICB1c2VkIGluIHRoZSBh
Y2NlbGVyYXRpb24gcGF0aC4gUmVtb3ZlIGlubGluZSBxdWFsaWZpZXIgYXMgdGhlIGZ1bmN0aW9u
DQogICAgd2lsbCBiZSBleHBvcnRlZCBpbiBhIHN1YnNlcXVlbnQgcGF0Y2guDQoNCiAgICBObyBm
dW5jdGlvbmFsIGNoYW5nZXMgaW50ZW5kZWQuDQoNCiAgICBTdWdnZXN0ZWQtYnk6IFlpIExpdSA8
eWkubC5saXVAaW50ZWwuY29tPg0KICAgIFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lv
bW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IGNmMjc1YjQ5NmUuLmFhMjcxODdl
MDIgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50
ZWxfaW9tbXUuYw0KQEAgLTMxMTMsMTAgKzMxMTMsMTAgQEAgc3RhdGljIGJvb2wgdnRkX3Byb2Nl
c3NfcGlvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KICAgICByZXR1cm4gdHJ1ZTsNCiB9
DQoNCi1zdGF0aWMgaW5saW5lIGludCB2dGRfZGV2X2dldF9wZV9mcm9tX3Bhc2lkKFZUREFkZHJl
c3NTcGFjZSAqdnRkX2FzLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgVlREUEFTSURFbnRyeSAqcGUpDQorc3RhdGljIGludCB2dGRfZGV2X2dldF9wZV9mcm9t
X3Bhc2lkKEludGVsSU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnQ4X3QgZGV2Zm4sIHVpbnQzMl90IHBhc2lkLA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERQQVNJREVudHJ5ICpwZSkNCiB7
DQotICAgIEludGVsSU9NTVVTdGF0ZSAqcyA9IHZ0ZF9hcy0+aW9tbXVfc3RhdGU7DQogICAgIFZU
RENvbnRleHRFbnRyeSBjZTsNCiAgICAgaW50IHJldDsNCg0KQEAgLTMxMjQsMTMgKzMxMjQsMTIg
QEAgc3RhdGljIGlubGluZSBpbnQgdnRkX2Rldl9nZXRfcGVfZnJvbV9wYXNpZChWVERBZGRyZXNz
U3BhY2UgKnZ0ZF9hcywNCiAgICAgICAgIHJldHVybiAtVlREX0ZSX1JUQUREUl9JTlZfVFRNOw0K
ICAgICB9DQoNCi0gICAgcmV0ID0gdnRkX2Rldl90b19jb250ZXh0X2VudHJ5KHMsIHBjaV9idXNf
bnVtKHZ0ZF9hcy0+YnVzKSwgdnRkX2FzLT5kZXZmbiwNCi0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICZjZSk7DQorICAgIHJldCA9IHZ0ZF9kZXZfdG9fY29udGV4dF9lbnRyeShz
LCBwY2lfYnVzX251bShidXMpLCBkZXZmbiwgJmNlKTsNCiAgICAgaWYgKHJldCkgew0KICAgICAg
ICAgcmV0dXJuIHJldDsNCiAgICAgfQ0KDQotICAgIHJldHVybiB2dGRfY2VfZ2V0X3Bhc2lkX2Vu
dHJ5KHMsICZjZSwgcGUsIHZ0ZF9hcy0+cGFzaWQpOw0KKyAgICByZXR1cm4gdnRkX2NlX2dldF9w
YXNpZF9lbnRyeShzLCAmY2UsIHBlLCBwYXNpZCk7DQogfQ0KDQogc3RhdGljIGludCB2dGRfcGFz
aWRfZW50cnlfY29tcGFyZShWVERQQVNJREVudHJ5ICpwMSwgVlREUEFTSURFbnRyeSAqcDIpDQpA
QCAtMzE1MSw3ICszMTUwLDggQEAgc3RhdGljIHZvaWQgdnRkX3Bhc2lkX2NhY2hlX3N5bmNfbG9j
a2VkKGdwb2ludGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsDQogICAgIGNvbnN0IGNoYXIgKmVycl9w
cmVmaXggPSAiQXR0YWNoaW5nIHRvIEhXUFQgZmFpbGVkOiAiOw0KICAgICBFcnJvciAqbG9jYWxf
ZXJyID0gTlVMTDsNCg0KLSAgICBpZiAodnRkX2Rldl9nZXRfcGVfZnJvbV9wYXNpZCh2dGRfYXMs
ICZwZSkpIHsNCisgICAgaWYgKHZ0ZF9kZXZfZ2V0X3BlX2Zyb21fcGFzaWQodnRkX2FzLT5pb21t
dV9zdGF0ZSwgdnRkX2FzLT5idXMsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZ0ZF9hcy0+ZGV2Zm4sIHZ0ZF9hcy0+cGFzaWQsICZwZSkpIHsNCiAgICAgICAgIGlmICghcGNf
ZW50cnktPnZhbGlkKSB7DQogICAgICAgICAgICAgcmV0dXJuOw0KICAgICAgICAgfQ0K

