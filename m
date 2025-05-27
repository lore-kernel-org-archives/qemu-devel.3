Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37EDC54FB3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 02:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJjoE-00045M-Hk; Mon, 26 May 2025 22:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uJjoB-00044u-TT
 for qemu-devel@nongnu.org; Mon, 26 May 2025 22:12:52 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uJjo9-0004ir-Kh
 for qemu-devel@nongnu.org; Mon, 26 May 2025 22:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748311970; x=1779847970;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vSBIxud+fqp5I3IyLmvBRYW5cgQ3J2ncN7KWK8r+XDk=;
 b=BmK+5gRa379jNCr3YKzngOjIqDgqHnShzJWHetGhB6ZU/IHIodugOmxh
 tWzPsl70e3inqRJSqS8QqYgWdcOFg9E5XAKt6rSYf2g9+RyO2Q+Qv/hhP
 /6a/i/6Zz6z6X1ykvl3Cqp7jWkAM/1mdiKVjCvp41OnycNdrq0b7X//8m
 aSUqnH39mSVDX7ta15kQNCJ/5GdcPSY2P7pFdSsPV4r6Mtj3vhM4RFVud
 XfBxLDdUpevLNNhjmgQ623MCaPBAAZm0MV3gIRBldD8w4L82O8xSVd7fg
 wJ5f5gz6hPBH6Vt+Zk/T4bNMAdgjXxb76TCF/8ljCPENDN715mhG84Wvy A==;
X-CSE-ConnectionGUID: iTqkWpWRQo2ObJR1gkS58Q==
X-CSE-MsgGUID: wxurHbvwReatW4kwjpWv0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="49534604"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="49534604"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 19:12:46 -0700
X-CSE-ConnectionGUID: zzjHjZ+UT8+KV/w5CQbttw==
X-CSE-MsgGUID: bsIN4L+SRyqPr+TptO8uzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="147612733"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 19:12:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 19:12:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 19:12:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.71)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 19:12:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYYg1QcPv89oOBwyv5omd993G01HFFJA2HXf3oklaoPd29fCjn7R8ovCK+PbKtizzXyposGX1x1ZpvokpYIjXyewCr588qPwUneml4jHw7x90sJTQKhUnLk7xRbcEEBu3X1uFIIF5X2ZQvTkb1+PIBg/bvhS9Xs3FfRD5spfcuTdtMcOuoYizDepqmnG+d/TgoVih9btzXdlohOwxzBY/islUxMlNp/yAQ9dOPtzz3at3Zs8E1f5ldpSyUtg/4oE6FkO75AI9goWlqoYQToNtNiCiz8SxCOBFacPsQ0BB60F9o1EZhnmCaY8WanuB+syzvAjmlpayCqAMr73EXn2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSBIxud+fqp5I3IyLmvBRYW5cgQ3J2ncN7KWK8r+XDk=;
 b=HRevmx6UrmFXnVx/28UlsE9oyOrXamharRGULn4TkQn46u98X0QPCj/FcNdq6Vjl/8Xo1jHHGQihcMDsO0w79lOS3qABgwUc7gGQnMECQJDco+FXjZh7lCrYNzcl4bAr/gikUTohBydlY/JzmITV2uh1WX9Y83tTxLDwB5xRzR21QdYKo/ntGypNeHvvrB6svCwnEUaIj8OStz1DOGilasjYKBGR+IrOA4CnnD2U+g5xlZbydYbnpESsmr2KF6dvugU73EJ5NJqd7VZymKSYJq6p4i/HkVn7r5HtoTV0lln3k8NsJBdCCtG7Q1zv4YsLBu+AZo2ioy3S/aM7C52Uqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6829.namprd11.prod.outlook.com (2603:10b6:510:22f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 27 May
 2025 02:12:09 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 02:12:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv3 05/21] vfio/iommufd: Save vendor specific device info
Thread-Topic: [PATCH rfcv3 05/21] vfio/iommufd: Save vendor specific device
 info
Thread-Index: AQHbykIti5D5SWxjUESxh4+ddQnLJ7Pk2yyAgADpkbA=
Date: Tue, 27 May 2025 02:12:08 +0000
Message-ID: <SJ0PR11MB674454617A15BC60811FBC679264A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-6-zhenzhong.duan@intel.com>
 <0212e796-9869-47ea-bcab-0d86bae2580e@redhat.com>
In-Reply-To: <0212e796-9869-47ea-bcab-0d86bae2580e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6829:EE_
x-ms-office365-filtering-correlation-id: bd02d16a-9071-47b3-3312-08dd9cc3e263
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?N0xyN2xLN20xN0JlLzBIeDU1dEtGNmtJUnc4ZkozV3NDNnlmclpLV3plSXY4?=
 =?utf-8?B?VTk1MTQ3dmU0RXFnVFp1UjRXQkZDcEJCOUtJWmtDUGhjSEV4TmZMMkFBYlVo?=
 =?utf-8?B?Q013VnA4VWxVdkVGeWdNSXBETFoyR0dHTWJEUVVzcnBiWjNtYTVIKzBNdEE1?=
 =?utf-8?B?MjhPeUhQdnBWY2ZrQXVtYzRsL29Cb3FEWE9RQ1hXdEg5eEI4ZEFJek0vMXhn?=
 =?utf-8?B?Y25JK2VzNjFJWGFFbXh1bVJXVUhtL05TL2RaeWZoVjFlc0U1bDdITzRyOGFm?=
 =?utf-8?B?TE00UVdXakhqa0grWGYzblVpVS9EcldHWVlkZmRacHFmRE01a1UzamRYTHpo?=
 =?utf-8?B?SDlGeGtJVGtzbVNkVkR6WXdKaHdMWlVMVzhmVnZpeGUzZUFiOGdjckF0MFQ0?=
 =?utf-8?B?ZG85UXdhN2hTcDAyVGl0ZGVFejZDMStqMSszRGtHRXZONnRYcjF3Ylc3TWdo?=
 =?utf-8?B?SDJQMVcxRWNycW41VmIzYjFac0hSVnNmU0kweTIzWmFZcW9tamxRN0Q0MVJH?=
 =?utf-8?B?QnRQQk1xbzJtSTdaZXhkTHRPMEg0Zk5JdVpZaFhxV25aU0xmSWxJSEtybjZs?=
 =?utf-8?B?M2xmaVBoUTdPdHUwK1Z1MlFRbHp0MVN1SkJpQ015QmErTm93cCtUa1k2Mm03?=
 =?utf-8?B?V2MxZlZlQzFVTCtaeWxGMmRjVXNDanNjU1dvYTdZTHpjWDJPcWhIZVdIRXE4?=
 =?utf-8?B?T2FJSU94VzBMUHoxZWUzZFZQMGFzU2dzV1VFcEV2SHZhb1BJMjZvSVJQZUJY?=
 =?utf-8?B?UjkwRkM0Y3dzeExvTTFLcWVxN01wam9FTnhNLzlxcXNrRDZxRnVyUVQ5Z3ZU?=
 =?utf-8?B?QVp1alZCdmJxR2RYcElMVHZ3RGdMeitRdDRNM292WW1wZnZCV3VHRVZISDJo?=
 =?utf-8?B?OSsxVktpWnd0OW9JSVYwOHl3dW5vVU4yMjRwVytKZ2lVb3lJMmM0TVlkclJx?=
 =?utf-8?B?Wm9nL0lGOWQxOENLelgyZWNMWmNFYnI0aEx5RUhIeXJnWnlobnZyQy83Q25k?=
 =?utf-8?B?OHptZlpwWWJOVFlVbXVmZmwrWkwyZ0N3UFN0RGJzcFBOT2pFelo3RlRZUVQr?=
 =?utf-8?B?U1JTSE9TVjFyUGhhNEs0TmNzcGc4SEQydWFXMDJEV1NXUVB0ZllKT3oyanpC?=
 =?utf-8?B?YkxmdkxXeTI0ZGtvUTl2V09mTlRFSTF5UTNLU1hkS3E1cnlKQldlU1VoVm1V?=
 =?utf-8?B?Y2FTQ3JvYm1sWXh0cGU4R2RVenVwT0I0TnJVM3FYVlBNWFdITWVjSjZCKysw?=
 =?utf-8?B?TDliYy9rVGs2UG8rYzhZb3NwOEsxdjRNbTA0MG9UTG56M3hiV1Y4c0t6Titt?=
 =?utf-8?B?RkFmSzZxY3ZjcnA5M2FHU1R1cVNyL1Q4eGNsQ0d4elNCRnMwTFdqN0V1VnVz?=
 =?utf-8?B?Nnp3dmNyTk9yN2RCTDc0K3Bmd3VLYVVkazZuUFZYemUxdzFiZzRyT2lUN1E4?=
 =?utf-8?B?ZTdQNUxNazh5WG9HTmc1VE1FUk1YRUpkODExTE9vd2xOZzZsbU5mTWxTUHVP?=
 =?utf-8?B?cHZ4Q1VKT0Rranc0azBUenRNWldqam1LUjdqbWNkMmtsZVliaGFCRDhCdlhk?=
 =?utf-8?B?U3BCQWhnaVF5WEM5R3k0aDlJdEJIa2Jvc2NYcUF3Z3pGSVdGNXlCOU96ajFJ?=
 =?utf-8?B?cTZsaTF3czRFUEtEd0JxTFIzcmxOZTJQQ2hoK3dBVk1iZy9YMTc4a1FjUjNp?=
 =?utf-8?B?aUdYd29kVjVRQmg1bkhjZU9JdEdMZytuZWRQNVZFN0tNeTI2T3ZYbmgvUHNj?=
 =?utf-8?B?Nk04azlVc1NKQlVOcHhYalB2eVZIZVV1YlZ6bWpyZ25nSklGNVBMMzc4WWZV?=
 =?utf-8?B?WFZSRzVUTmZ5S3VSYVNGN3lLV0QrSTdsVUJ3R1czMCt4VkM0OUsxYVhGVGh6?=
 =?utf-8?B?TW1HMSt1blFwcDZMSFRvb1hBL2dncUVFTzhsSzdtQmZGYzZZdncvckxNY0cv?=
 =?utf-8?B?ZjRPRGdmYWxnVWNEbktIbUsrenRnS2VvR2pNeU5ORkhUTG9UeGhNbVk5UmZC?=
 =?utf-8?Q?6vih/dfDnxg+IGQxj4a37fNkCtTfqw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dG5ubU8xOFhyZ0ozK0QxRHdGcWhBK0QrTTRvL2lpM2Y1NVZkbklicC83UkdJ?=
 =?utf-8?B?bndXeXFueG52SWFobjlrcWQwZzNraDkxZm9MNFAvTTljWjc2NzR2b1UxNmtY?=
 =?utf-8?B?dkpRQ0pUVDBpbEVuZU5iUTEyNVdMaTZTbDYxUldRTktsK3B0cks3TVMwRHk0?=
 =?utf-8?B?YzZ3QmFpaEw4ZVBkMHRWTlhESFhXS2MzZC9kbzRORUc2MTZsZU1LUm5VNlR2?=
 =?utf-8?B?ZmJ2aDc5M3orQkZlb25wSzRmM1JFZUE4UFZlakQyTktnaU1jdHJOMHc0VkhT?=
 =?utf-8?B?Mlo0ZjlnQmNWdklxSVV0NE8xU3l1Y28vZWsvZlZqWWllTWxJZzlhdXRvcFkw?=
 =?utf-8?B?U2o5ZkVQTHF4dmtrKzJGSFlHUHd1cDMyb1lKcXhVZ2dSNy8wMWdlcHdXWnZH?=
 =?utf-8?B?M0h3dUhMaUF5OG5XZjA2L0Z5TTYvUFZyVEx0NlpqUmJJUXlYYldieHYvVlVl?=
 =?utf-8?B?ZW5oMEorSnVlR1ZIRnhBVnlnQTl6NFBqVnFFK3FTNG0vOHNsZE1kTC81eU9M?=
 =?utf-8?B?V1AwTVFla0tPYmd3Y3d2NUxlbWRXS08xaGpyRFlJQWNqTTZjdkdIbXNpTFJQ?=
 =?utf-8?B?WXE5cHRaV2lrbVpjckFnTVluZU9kbzFqbllGRXpoQ2JlN2R4Y2hJYTBhQXBr?=
 =?utf-8?B?R2Jhc1R1cUtkRGc5KzJ5bXUvMUNjZmkwUHFkeURaNVpNcy9QTXdzcE5ZNzhh?=
 =?utf-8?B?YXMzK2VkaEZqZzd1WnFjZW9YMitjNVI1YllGVURXYVdBek5IUzZIQXpSRkw0?=
 =?utf-8?B?bGtwOWdET0U1ZGk4V3Exckx2K2lrY3VWVjJxODJRVnlHSko2U2ExZHdqNjVK?=
 =?utf-8?B?VGc1K3ptS2ZBN3hEa2R2YlVsZ1YycDI3L3Y1TE1mSVZUOWNiUE1jRnQ5anV4?=
 =?utf-8?B?bWhGMjB1QWx0N2c0cHFlOWo0WDdjRnRsa3A3NWVrOFdjWUxQUTFxNDRkSytk?=
 =?utf-8?B?eVBCNGp3YmljcG9kYjJyZzBQWURXMUpEK2pqUTJ6bUExRUhlM3FoSlo4eWZE?=
 =?utf-8?B?N2Q1RHVxeDBQdUZtdzhtTExFeXN4WU1mVnFWQnA5STF4VWk1QWF3U0VuMlNz?=
 =?utf-8?B?ZUpwM2Nxc0VLdFRxbUt4UHBlNVZlWExoaGl4NDBHRzdIRzJCYmpzOFhRTGFN?=
 =?utf-8?B?VTN0RHlNdlFQaEpwVUFvT2dVOVIzYngxK3pXMk1qNEQzenNqYWcwMGNRbUEv?=
 =?utf-8?B?MjhMd1hxWHl4QU1KOTh4dHJiN3NoV1RCQWJiZ0Z2ZUlGdFVHWDlHMFVvNjRl?=
 =?utf-8?B?a0xwcHJrRFdIeE55QVZTaTMxN2NCbmQvK0FKcFF1ZE1IZUo2ZkxvdGd0SVZM?=
 =?utf-8?B?NHJUTG1VZGJPOXhlZmptSWd1SzIrVFk2WGRWUHFqNWpodnF0RWhFZFA5Mzd5?=
 =?utf-8?B?TlVUUFBVQjZCemNtaG93Q0p3aFZabTI4eDJpQUd4OVdXQk5iQVIzdGJrQ0Rj?=
 =?utf-8?B?cTJic1cvd2xVZ3R3Uy9TUnJpdkdZNkRMaXdBM3A0Z2Nua1FhZVZuZzd0UlNR?=
 =?utf-8?B?QnVXTGhTZDNwdEFDdHRYWjZUYzFQMGZNOGU5SnhERUk2MTM2UkVzUjNhdXM4?=
 =?utf-8?B?UVQrQ0kwQjk4ayt6SFUxaDJDNGljcmlZSTNMaURlRW1pa1U2aHRVRVRVaUZm?=
 =?utf-8?B?MWFJNXA4ODUyanRJTTRtTVpPWUJhK0VHaFQxcUsweGU1MW44djlPWUwyeDN4?=
 =?utf-8?B?ZzNEczRSNmNXdjlsd2lQK2MrWlJJdVFmNVE2YVYzS1RRZjQ3YXNQaGMyMmVS?=
 =?utf-8?B?ZUFsenlYMDJWcytNNlVhZlRRZUU5Z0p2Nnd3eFQ3TlpIL0dqQnhIQVFpd3BX?=
 =?utf-8?B?MzFmWUJlb3dZekVyOUNZUDlLbkc1NlZtcU9YQTYxdFFCT2ZnVGs0ZWNUU215?=
 =?utf-8?B?NW16UDJHdXh2QmhkcjRjUDhTZXBPNUxKRzQrc1ZPS2RRZ1M1ajdnTmFRMFpt?=
 =?utf-8?B?YWhVVURCN2MzUVhEakI1YjBCLzZoV3ZjNVdtdUpsUGZuSWY4Tk9kekgvalFI?=
 =?utf-8?B?QzBNbU51RTNNbDJHcGRRenIzdWhpZnRZVVdpN0owd3FPSFVFNU5YNHhHMzRr?=
 =?utf-8?B?TVl1d1ZRNW1wQU81akwvRUdvNXpuMk0vL0UzaHl1NG4xZ3dTNmUzSjJ0RDg5?=
 =?utf-8?Q?43f3QQZZG2JycQH1gAnDEFd3u?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd02d16a-9071-47b3-3312-08dd9cc3e263
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 02:12:08.7098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RehJ2EvDsIlujTpM60v+ZCX/bNWWNiNj2ctKVZGjyHOPqsoCYoEUlPU8M1BHtTnMvGQCeOkF5eNgvLVzQ9+8XDnL8WSQ1dGTS/fCBwC4A8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6829
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggcmZjdjMg
MDUvMjFdIHZmaW8vaW9tbXVmZDogU2F2ZSB2ZW5kb3Igc3BlY2lmaWMgZGV2aWNlIGluZm8NCj4N
Cj5IZWxsbyBaaGVuemhvbmcsDQo+DQo+T24gNS8yMS8yNSAxMzoxNCwgWmhlbnpob25nIER1YW4g
d3JvdGU6DQo+PiBTb21lIGRldmljZSBpbmZvcm1hdGlvbiByZXR1cm5lZCBieSBpb2N0bChJT01N
VV9HRVRfSFdfSU5GTykgYXJlIHZlbmRvcg0KPj4gc3BlY2lmaWMuIFNhdmUgdGhlbSBhbGwgaW4g
YSBuZXcgZGVmaW5lZCBzdHJ1Y3R1cmUgbWlycm9yaW5nIHRoYXQgdmVuZG9yDQo+PiBJT01NVSdz
IHN0cnVjdHVyZSwgdGhlbiBnZXRfY2FwKCkgY2FuIHF1ZXJ5IHRob3NlIGluZm9ybWF0aW9uIGZv
cg0KPj4gY2FwYWJpbGl0eS4NCj4+DQo+PiBXZSBjYW4ndCB1c2UgdGhlIHZlbmRvciBJT01NVSdz
IHN0cnVjdHVyZSBkaXJlY3RseSBiZWNhdXNlIHRoZXkgYXJlIGluDQo+PiBsaW51eC9pb21tdWZk
Lmggd2hpY2ggYnJlYWtzIGJ1aWxkIG9uIHdpbmRvd3MuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBF
cmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+PiBTdWdnZXN0ZWQtYnk6IE5pY29s
aW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9u
ZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS9z
eXN0ZW0vaG9zdF9pb21tdV9kZXZpY2UuaCB8IDEyICsrKysrKysrKysrKw0KPj4gICBody92Zmlv
L2lvbW11ZmQuYyAgICAgICAgICAgICAgICAgIHwgMTIgKysrKysrKysrKysrDQo+PiAgIDIgZmls
ZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L3N5c3RlbS9ob3N0X2lvbW11X2RldmljZS5oDQo+Yi9pbmNsdWRlL3N5c3RlbS9ob3N0X2lvbW11
X2RldmljZS5oDQo+PiBpbmRleCA4MDljY2VkNGJhLi45MDhiZmUzMmM3IDEwMDY0NA0KPj4gLS0t
IGEvaW5jbHVkZS9zeXN0ZW0vaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4gKysrIGIvaW5jbHVkZS9z
eXN0ZW0vaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4gQEAgLTE1LDYgKzE1LDE3IEBADQo+PiAgICNp
bmNsdWRlICJxb20vb2JqZWN0LmgiDQo+PiAgICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+Pg0K
Pj4gKy8qIFRoaXMgaXMgbWlycm9yIG9mIHN0cnVjdCBpb21tdV9od19pbmZvX3Z0ZCAqLw0KPj4g
K3R5cGVkZWYgc3RydWN0IFZ0ZF9DYXBzIHsNCj4NCj5wbGVhc2UgbmFtZSB0aGUgc3RydWN0IFZ0
ZENhcHMgaW5zdGVhZC4NCg0KV2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

