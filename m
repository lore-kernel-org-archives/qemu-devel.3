Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88993CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf2L-0004xF-St; Wed, 20 May 2026 07:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wPf0h-00030N-KY
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:23:03 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wPf0d-0002Uu-7Y
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779276163; x=1810812163;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vqbdT6Y/BZCghkoleriPV5iIYvWzdevJMbSFahnQr+k=;
 b=A0FLymXL0K/Dg3zgdl7yoWRY1vuPHKyKHN03PKGwHNx/ZARmBcgWUKP6
 PIVT1+X7f9qMvrqq6PajcDci1xwjg7MtpbNeXTUJfayYZ2LvKrRfJ17XA
 qVKJCLkKqt0SsYcIH4RM7aooy8/9FraN7ec9uf0AX0xalttRiAfH3z8p0
 uPbZNUjZF4lXcK5MKMF266RRFTaOUsXvwfET6+Kq6E2hCUAuAE+7e6lkP
 5kM3T5rQU4OoNBIuS3mxApWJJWO666za8HO3ZxRhWNob94mvI1Ul7w6Sn
 Ln+5ZwFdSwtfxkoMvbAjKmhLqG8z0juakDchn40V+t0IUvibkYEJdxHJA w==;
X-CSE-ConnectionGUID: w36RKHcRRFKIUPxdY/xprw==
X-CSE-MsgGUID: GMQHkmCgTTugvo+13jprqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80286817"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="80286817"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 04:00:29 -0700
X-CSE-ConnectionGUID: LaP/oN1bRZi3Gy+xsJE16w==
X-CSE-MsgGUID: pHPnh8yHQ2mMu3wh141ZZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="263932113"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 04:00:29 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 04:00:28 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 04:00:28 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 04:00:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSOjRgOBSESiSpmNf5FnlDkpu7xmqRieCA8vGeO46WxjkwXfFc62pqLBmSesegyoB4f2fmVkP6Yzv++RsuuTOCf2Nz9gki4xh0cNTqZsEzdzVfb9YCXQHjSfR+zrfM6MaKjvi8r/WLEpPfAe5Ijwt0RFGV8b4uhh4qU1O+NNKmmtsAxuAn8UzIfDSo40JOWdhG7ohUI59q3RtAuo/KwqZq4HycdTMV2pYgyTk67zMrBuxkgdO5QvtXyLyUFcber+HH7v0YlzyS7WlhZkSY3F0wBovz7Q5S3vspZLIzYrpoJODgwCMhH8FeYJN4Ush7QJbjmVe4ivut15MxAFSvq+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqbdT6Y/BZCghkoleriPV5iIYvWzdevJMbSFahnQr+k=;
 b=eBKMuTZYWeIlJC3XUjh83FjeMq32+gtW02U2oGnOC4e+6FtEpY5U0/FFPskc82YH1U6CmSmAQ/ZZRPR7ihXCr6hmnCXf5vmNAN7MQg/99wCM87l/iC7fO8MfotANyxLAabF1A7ojGCRrpeTHFKHfJTUo/+fVtw7MwHIE4JOm3Fa6R+/bqZN5huY0TBpMoTjDUvr9VwXJI1D8RIVbBTVI69tqsJFKmqRJPkm9He7hzAUQbx7O8ERQ8Fe9OGCzLJjT2XWQyRjt0mi1Buxay96DKIaPlVDQ4iY68QPCGy9omyDJ2NZGHzlydRtgK9tEhD4UJooEGy9AAfVPn87H9/xVPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB7451.namprd11.prod.outlook.com (2603:10b6:510:27b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 11:00:25 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9913.009; Wed, 20 May 2026
 11:00:25 +0000
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
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: RE: [PATCH v5 08/15] intel_iommu: Refactor PASID processing to use
 IOMMU_NO_PASID internally
Thread-Topic: [PATCH v5 08/15] intel_iommu: Refactor PASID processing to use
 IOMMU_NO_PASID internally
Thread-Index: AQHc32mcVP/GY7HLckeIzCovUgMZdLYNac+AgAeWiTCAAa3PAIAAAqxg
Date: Wed, 20 May 2026 11:00:00 +0000
Message-ID: <IA3PR11MB91365BAAAC96F5E996416BC592012@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-9-zhenzhong.duan@intel.com>
 <eb419b7c-8fe9-421c-b0b9-d2dd5993e6d1@intel.com>
 <IA3PR11MB9136FA1C2BD60E9A028FC71692002@IA3PR11MB9136.namprd11.prod.outlook.com>
 <053b39b1-c522-491d-a36f-aa105485f916@intel.com>
In-Reply-To: <053b39b1-c522-491d-a36f-aa105485f916@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB7451:EE_
x-ms-office365-filtering-correlation-id: 06f965be-acfa-4350-e324-08deb65eff28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|11063799006|4143699003|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 5BCOse7WL78u99qtJvH+XAtTpUfRMWz2TOIVky/iRtN2TCwnDs+qzMAuGo9zlCwTLMfxy4xJ8BUiSo5fsBbrv4h7TjDeCmkS8BMSXVwKf8JnGzS6HI71crNrIbZv/GvsKDRTKHEUwiopupUjcanyqhbZCPjL7PSaJP94obA0k1Pkw6Nzaf18I8lRhhGEig/pbQgLwpONwEnFCS3/HzzqIfYyt4nfae0cnDmfiZ/wScA2QC8pKEhGmmXwTzzuwIft1OUHBuXJRgEY+WRIiXhDAVMenYqF4NF3Ttskmu89KRsFGWggJESsHynhZeY/1LePPYOR32oXpHRui9J3Mnuf4RYw/JrudCvwExp3XmiKFS5CdOEM6mCaccNUr88OM9jgmTODD5nR+uUCZdT/NTXYG3RwMlh1Oqy6oBwfdfbT4k6POfR9EuUchndXdZigfsAZ6is9lDE83pBXyLrfaJCvsJEXHKQRSKih4XA+aS9CoHPMFHi7Is3MbAR7FfDICnvomEXzpoWuKRuh15BKdKfroYV3/geKu4ynq+59fijsxtmS4M/Tlz0mY6mHaNP51gOacs3xJtP6v+/bGj9Nawupfb67Kl2sNDuRnUXvmi/WlDBeMMzjJdbbsAuAg97TOcypA6J2TNjkqQ0otaqi5xnOCLMtmhWC40vVOj3R9xTXWinPkTofCORE+qZ4XAAe1FByup4eUH/K9jdW1MR6D4YK3Z5CExFQOrGv/AdUk6y5TXg0G0d5EaYS62l/eUMdhsdO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(11063799006)(4143699003)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rmx3aFNJaUJEMUdNbi9BT1ZoaDloUS81ZGdvWlY3c0lTaWpwakR2RmVZWUNU?=
 =?utf-8?B?Si9yVklGUFNtcnM2UUh6TGRoUGdoeld3YTFyT2wwSVhyWFNtUXR3VUVrUEFV?=
 =?utf-8?B?MS91RlM1QmNUSGZEVGVoSGFGRjFxZk11SGJ6NzVEUHBjdTUwRXlQVEg3WERz?=
 =?utf-8?B?bE1zYWNlNWFuQ1U4VlVSdnlWWVdGKzJIOXpoMHFEb1c1TXh3VXk3QTA0czN4?=
 =?utf-8?B?VTBIWERXY004cWhXZFRBdE0yUUlOeVprSkt1TmlmTENRRHhLWng2aVBPQjd6?=
 =?utf-8?B?MHluYWI4VWw0c1RncCtFSG1JR21nTTNMcXJ4b1Izc0l2VFlvT0pNWFAyN1lm?=
 =?utf-8?B?Snc2eENUTjVZSnBWODM2T2ppRncrRnVqSk9nYTM1Y3FBS0ZNODdkbTJBdTZX?=
 =?utf-8?B?Z3BMV1RHaEROdVcwcHl6cDJxemxBZ3N3dW1zbCtkcHZIOTZydk1CS2l2cEEr?=
 =?utf-8?B?RGJkclo1MzRBTDl2RC83aGpkOWhQdmVEcWxzQUtRRktlQi93Q2UzSnlLYm10?=
 =?utf-8?B?R3Vnd2FOeHoyTmJxZWlkcG56VjY2ZEEzUktlemhrb0lTbDdNTzRYUDZ4eVlB?=
 =?utf-8?B?YnRsaWoyc1lvbXZSb1d0WFZ2dWc4MnNVRENzd29yWkg5dUd6dWxKbUdyai82?=
 =?utf-8?B?V283eHBFY2gybHFvUkU2aG94bzRjbVVFYTFBRVBTY1JWcGcrV1lESWxzSWcr?=
 =?utf-8?B?RHI4QUJVZ21NNU01S3p1VmpiWnJ0RkdIajdxWXZOTVdUN09XL3pEWTFwb0pS?=
 =?utf-8?B?cXNIMko2aWRJVjBTeUF1Y3paRWRCcFNlN1QwaEwybk91YWNWMHdVOFpuMEtt?=
 =?utf-8?B?TXhUaURFM1dWN3Z1a2pnbXRCUkdIZGxMbzMvSWVSSkg2NjNUUVpHWkRGdEdp?=
 =?utf-8?B?NXV4TXNpbjNNTW1wbFE0TFV5eG04bks2L0QxLzd3V01LVnlxaXduRVhNdHdk?=
 =?utf-8?B?SCtEVFlkYWo5bjhCSmgrQVFLU0VmQmZyeFNjZ3FUV21sdXJmV04wcmRoM0lh?=
 =?utf-8?B?alV4bnJtWXZycGczM1NPcTQyNXd3TEFNK2RYSXNjcEpSblBLd2xoMXlRdDVC?=
 =?utf-8?B?NkFyNk0vMWNvVUU3eVBrT1lucTdKMWlhYXVCRURLald5L1k1YmZvS1RJa08z?=
 =?utf-8?B?ZE1DdTU0ZHlUSitnb2gyakRkcmJKZnZHU2RjNTh0eC9hYzFMTjVRb2VXRXAz?=
 =?utf-8?B?QWxQRDQvUHhCdGxoRVJWcU9RVW05dm9HWGltYjA2TWhMN1RLNFdVdSt6dmc2?=
 =?utf-8?B?czQzVTZtMUYzbnp5V0NSTllKQ01DTXdWb3JDemplbnFQZm9JV080VmVWRU5p?=
 =?utf-8?B?Yis0bXlGSjlqKysrdHdSbCtkRlRxUDRLNHlDVmRCL05jT2Y5ZlVZKzZoZmxu?=
 =?utf-8?B?SC8vc3JyUFdLZFhnUWNSM2gydS83QlR4VFhxMDI1OHV2eWV2QnRuZDYzcm9F?=
 =?utf-8?B?VjJqOExiZUw3aGFEYXAwZTFFV2hzcXFSc1VFN2ZpbkgxVlo4UVhsazBuenFV?=
 =?utf-8?B?KzRqTzZmZkpmV1hybGVzMlNtTU8rbmRJVm1PTjJGOVFmQUhqVnI5TGk5NGpH?=
 =?utf-8?B?dTFwY1NjMXVPa05RN2g3QmN2WHJBN1hzbWV0dzJyaUVsN2I2bVg3a3J4aXAx?=
 =?utf-8?B?RzVnYlFkZTZIS1B1b1BwVGp3TXNRQ0graGsrNnFST1NxbTZpN3BZdS9FanMv?=
 =?utf-8?B?Ry9IbGZzV1F6KytIYU5hSzlYMWZUY1FlWVlvbVhtaE4zSW5vNHRQT1I1SDBl?=
 =?utf-8?B?dUFOajZkenRWRDRycjZTQy92dkFVWHQ4U0xYbVZ2SjdSeTlQZUxJaGdockpL?=
 =?utf-8?B?WXBoV2krSlRFdGdJN3BrV0FkbkxETGdOQXlBVUJobHpXRkowWU5rQ1R1QTFX?=
 =?utf-8?B?RzlTUTEvRVZaeGlPdkJuaHFwa1BMK1Y0TnFpQjdyd2taOXdQbjNLOW1BSnpU?=
 =?utf-8?B?dGFDbWdvTjBjdlI1QjJnT1dsU256V0dtRXFTVkZqQXc2ZkwzbVFodFJOTGN2?=
 =?utf-8?B?K0Z5L2l4UTVTa3k1UWxrZ09uWm9IY0gxdVg5K3FVcjVDWHlZVzlTQW8veXM2?=
 =?utf-8?B?cG8vQUl2cE1MYnFxY1lBaFh4YmJYVE5iOWtTV3dWWkdoc3NhTzJ5MG9YVzBL?=
 =?utf-8?B?bmo4RG13bEcwOUlLNUdnbnk0SUEvcTM0elE3MHVBUWc4UStNOEM4UVdqeHBX?=
 =?utf-8?B?cDlvVWRxaEZYMld4eGc3eEdyQmV5SGliYytsWDVremMrR1l2eVhlWVFhRkRm?=
 =?utf-8?B?NklEKzUrRnR2MUlvTDhvak1Xd1l2UDY4Y3VkZ0JsVGNHU045elNpcTRVUTYy?=
 =?utf-8?B?MmVhZk9GMk1ITDJObUl4V3ptR3J3cFlaSHB2K0xpU1ViUXViMHFVZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tHfAS5IKOGth2hun6Lso7qB9Ni8f6G58XxVWTjc966x8R9v7ZIw95xVjU+egRH9UVGSvJsl7MBbWGyfXIQfDM6AlSPzAeAUoEktiuaRrlYRLQnTVGgNNJUzC0YgkTmSwjFYIWXM6LG03X8Ooiz1NU/oVuSCAGV9j8Foy5QWhmSQFI/+UeN3ZKQG6ZlvpjseyW5Z0JCpuxHeidCLKOSYsj92HcAm/oXfPAj7DpJrW3bylvAwxpMkY6Xn6qa1sUXfx7GE75x6u8tcMsVu5iA+bIJWNE0OygsbXS9waTvszXNbxiDwnLlHleaZau/w1gtz79RH9TxZCTj1w5W6lFoGY2Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f965be-acfa-4350-e324-08deb65eff28
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 11:00:25.7124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCClGMHpfoBq4jSKtFQCTW+OtlogwyCB1WDCa0EJA4yrpE8j7XoeGIfbDvnwzWmNvfT+GF4FjqV+5j1rXWirTH8E+Z3zi6LUQiDwpJl9qQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7451
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
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

Pj4+PiBAQCAtMjEyMSwxMCArMjExMiw2IEBAIHN0YXRpYyBib29sDQo+Pj4gdnRkX2RvX2lvbW11
X3RyYW5zbGF0ZShWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywgUENJQnVzICpidXMsDQo+Pj4+DQo+
Pj4+ICAgICAgICB2dGRfaW9tbXVfbG9jayhzKTsNCj4+Pj4NCj4+Pj4gLSAgICBpZiAocGFzaWQg
PT0gUENJX05PX1BBU0lEICYmIHMtPnJvb3Rfc2NhbGFibGUpIHsNCj4+Pj4gLSAgICAgICAgcGFz
aWQgPSBJT01NVV9OT19QQVNJRDsNCj4+Pj4gLSAgICB9DQo+Pj4+IC0NCj4+Pj4gICAgICAgIC8q
IFRyeSB0byBmZXRjaCBwdGUgZnJvbSBJT1RMQiAqLw0KPj4+PiAgICAgICAgaW90bGJfZW50cnkg
PSB2dGRfbG9va3VwX2lvdGxiKHMsIHNvdXJjZV9pZCwgcGFzaWQsIGFkZHIpOw0KPj4+PiAgICAg
ICAgaWYgKGlvdGxiX2VudHJ5KSB7DQo+Pj4+IEBAIC0yMjM1LDcgKzIyMjIsNyBAQCBzdGF0aWMg
Ym9vbA0KPj4+IHZ0ZF9kb19pb21tdV90cmFuc2xhdGUoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMs
IFBDSUJ1cyAqYnVzLA0KPj4+PiAgICAgICAgaWYgKHJldF9mcikgew0KPj4+PiAgICAgICAgICAg
IGlmICghdnRkX2lzX3JlY292ZXJhYmxlX2ZhdWx0KC1yZXRfZnIsIGlvbW11X2lkeCkpIHsNCj4+
Pj4gICAgICAgICAgICAgICAgdnRkX3JlcG9ydF9mYXVsdChzLCAtcmV0X2ZyLCBpc19mcGRfc2V0
LCBzb3VyY2VfaWQsDQo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgYWRkciwgaXNf
d3JpdGUsIHBhc2lkICE9IFBDSV9OT19QQVNJRCwgcGFzaWQpOw0KPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFkZHIsIGlzX3dyaXRlLCBzLT5yb290X3NjYWxhYmxlLCBwYXNpZCk7
DQo+Pj4NCj4+PiBhIHR5cG8gaGVyZT8gcy0+cm9vdF9zY2FsYWJsZSBzaG91bGQgYmUgInBhc2lk
ICE9IElPTU1VX05PX1BBU0lEIj8NCj4+DQo+PiBUaGlzIGlzIGludGVudGlvbmFsLg0KPj4gcGFz
aWQgPSB2dGRfYXMtPnBhc2lkID0gaW9tbXVfcGFzaWQsIHNvIGl0IG5ldmVyIGVxdWFscyBQQ0lf
Tk9fUEFTSUQgbm93Lg0KPg0KPm5vdCBxdWl0ZSBnZXQuIEl0IGNhbiBzdGlsbCBwb3NzaWJseSBi
ZSBJT01NVV9OT19QQVNJRCwgcmlnaHQ/IElmIG5vdCwNCj50aGlzIGxvb2tzIHRvIGhhdmUgaW50
cm9kdWNlZCBmdW5jdGlvbmFsIGNoYW5nZSwgd2hpY2ggc2hvdWxkIG5vdCBiZQ0KPmV4cGVjdGVk
IGJ5IHRoaXMgcGF0Y2guDQoNCkJlZm9yZSB0aGlzIHBhdGNoLCBJZiBwYXNpZCA9PSBQQ0lfTk9f
UEFTSUQgJiYgcy0+cm9vdF9zY2FsYWJsZSBpcyB0cnVlLCB0aGVuIHdlIHBhc3MgaXNfcGFzaWQ9
dHJ1ZSB0byB2dGRfcmVwb3J0X2ZhdWx0KCkuDQpJZiB3ZSBjaGFuZ2UgdG8gdXNlICJwYXNpZCAh
PSBJT01NVV9OT19QQVNJRCIgaW4gdGhpcyBwYXRjaCwgdGhlbiB3ZSBwYXNzIGlzX3Bhc2lkPWZh
bHNlIHRvIHZ0ZF9yZXBvcnRfZmF1bHQoKSBmb3IgdGhlIHNhbWUgc2NlbmFyaW8gYmVjYXVzZSBw
YXNpZCBpcyBJT01NVV9OT19QQVNJRCBub3cuDQoNCkJ1dCB1c2luZyBzLT5yb290X3NjYWxhYmxl
IGNvdWxkIGtlZXAgZnVuY3Rpb25zIHVuY2hhbmdlZCwgcmlnaHQ/DQoNClRoYW5rcw0KWmhlbnpo
b25nDQo=

