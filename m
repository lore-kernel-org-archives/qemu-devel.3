Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024B9CD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 03:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQGH0-0003P6-Kg; Thu, 21 May 2026 23:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wQGGz-0003Ol-CQ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 23:10:05 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wQGGx-00024r-P4
 for qemu-devel@nongnu.org; Thu, 21 May 2026 23:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779419404; x=1810955404;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LrnqDEJRk4MVMVzCiAbIn3M8dnSbisut2VA1vEC5/ZU=;
 b=IyY5u9x5as8JkNYEpw2wFZr4V+z597E5MTlMaM7VIYm8ila17K3cZzo3
 a175n23InJlAY847Yj4tUT9YP+k7UQeD/i5nL6IMG5mKxrGUgtXUH02X2
 +OMQSceYIDlNJw4VBo2ZUgPzHVJ052VEHkqGZv103syxClGifQt2gTdaU
 fulilmH4UzeXpOsWPJX3Ov2hZjvZSmT5UagT2S8ItaX80eyFUoMzArKRi
 JYKMdYua46OLKQDRx0hIZBlG22MyLa8GXnM8i/MuSbGc8WqHMpUdfUoyl
 NT3IKD56vdD6X+yxHlJQv/CeXKtgTezbfC3B21VaKd7pw6luF509Jtt9K A==;
X-CSE-ConnectionGUID: nxk9WHLbS5CUhwN/qbYxvQ==
X-CSE-MsgGUID: kmyktmD3Qtm98/GUYjKeSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80200930"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="80200930"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 20:10:02 -0700
X-CSE-ConnectionGUID: CA4mZVNfSz+1Sqf0PVATRw==
X-CSE-MsgGUID: ieHKXWlKTbilTnTqfYmr4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="240993039"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 20:10:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 20:10:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 20:10:00 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.32) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 20:09:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J9x68mqGR4P4AqsF8OefDFjyOQIEh8d1JVDkCkOqO1SFEKXcCb8w/mtbekC4yeZuYd16YPCf86+XjBsrjMugxyjqJVJNDKXErd84Z9s/0EXXSGMyJVizYMFjThqHLflcnkhhJn62fCFpLptp1eYj8aAK/g5G/sE2xFljhWE8ZW21pmI99hfdPP+daUmdf5LpSYmrN77hfmWeJBqCCSfDDan5R3CFaZgw79ZDCCuhuK9CURZz7s2P0mCEJA9ykswJiWznzvNFuvRtp8UXDQjdGX3Ghov8SWOO9vpRT+CTCzgaRrZj8Tc0dqYLdFNx0QTdEzY8VOfogTfJGle2MhFmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrnqDEJRk4MVMVzCiAbIn3M8dnSbisut2VA1vEC5/ZU=;
 b=G+p+IJ+zSt2V54kXItnmVhg5wjA2vs/tK7xEzatjyBdGoV3RbJjVCL48+NxwVIqaJiRJ9HeBsBEs/ClsfhZq7+8U60dLFYcomViJCxfJeRNDVcVl7pbI0TFJiwnLirchV6xSM+fpQwRgWW4NXKWv6+dEXXC9NyWNBmptFhQQYdflYgHQ5kbUeZElFBGFSB4C3+rx5M0gjSHPqLpb2IvKN5oCNj/+o7LjctWXYz+Jch4gE3G+iCuAmKQUikEuA2NCkJyNMNrcErxOc5ZORx98HckjsSKl0JX/P7qYNkJst0YxvxukiKDwsj972KU5AGc66RNUjszUowu3ahXh39QHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MN6PR11MB8218.namprd11.prod.outlook.com (2603:10b6:208:47c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 03:09:50 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9913.009; Fri, 22 May 2026
 03:09:50 +0000
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
Thread-Index: AQHc32mg4oXI8zixW0uZHfCp60fO67YNafCAgAwHexA=
Date: Fri, 22 May 2026 03:09:50 +0000
Message-ID: <IA3PR11MB913674858DB7097F67EC3A7A920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-11-zhenzhong.duan@intel.com>
 <829fcf6f-39e4-4d21-9f08-2772c0813c32@intel.com>
In-Reply-To: <829fcf6f-39e4-4d21-9f08-2772c0813c32@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MN6PR11MB8218:EE_
x-ms-office365-filtering-correlation-id: 8a715e76-8ea2-4670-e2c2-08deb7af9684
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|4143699003|56012099003|18002099003|3613699012|38070700021|11063799006|22082099003;
x-microsoft-antispam-message-info: PwaWcfZmDjIIJXNgIuHWKM1ArMWgeAZ2RrICjiJkLVR8rgxXo/zjzwyHdlwubJyaq0z+l8Ieablg6k7Hi56XoFJh0GLGJa+Os9ixLFNDzWb6xW6pgTfaKwUpdAgc0SQF1jbjPxLFlSArYB1xtKhSyFVwf7ZOrpW2xyD0N5fh8CvYj7oOKtqGQGF+jWdYK/xbn5DP6Oj5/7YGiWYtY84yPYP2SBHIiJGjk0boTAyRI6g3Q6/LZFW3V/na2Id2ZjIg2Fc2KjWl00fAXRYwOirExZchdjo2HR/9RkO9deajd39he3EtdsMzs/SNW6bkAXStkQiiU4m4gnvQtbbJcfB8TsRmS6rSMBaC7E09SIwiZG5GGgtwQSftm/rrh0/QA5dcNwgkaklxVcZnGXOrOH/oqRx2hDJaP53CHIox4cJ41TZngAz8PVIat2DDKcXhrdRmZ8Gqxalq+d9u5ojiSlJu3tjKmMa8SId0h5jOL02Jftg7NTx6yBQUGCQOLQD/rfaySBCafzpbpD6mkBlS/ryEGTIPgvkrTwHKwyXHvMY9LOVwyYophbGTROA0I87cDr2RIRLhJbKVeYqlX+9PN7tVIGAlavbmlwpOsA5Od2CbDBWGGucCYEdDpr2LYlRFvNFQ+nmWXFHR0N/S71H7tG3UGSro/a6GkO9kNLcBlYo7Lm7dnTQ8z/qQ9QErokLqCpVBsnQ1rgxa1UaEdt7FqZLO8s46+6K3kj2jcuoDQD+Kg4Ssoxdfw4WjpDGQyY41jwkGV/DS2fcRI117qZIlmTyv6w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(4143699003)(56012099003)(18002099003)(3613699012)(38070700021)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clpNditHNjQxVUp2a0tCQnM4RXBjTHhadm90dk4yVDNDR09PV0ZXVkljRDVP?=
 =?utf-8?B?b0Z6dnFKRXBYMnlGZmhYb3MxQjR5OFJGSnhZQTN6ajlUTkNhM2NndVVORDJP?=
 =?utf-8?B?aWRVMjV5alFEOTlpYU16T3FwZ1RDWHJJQ0s3OGdHZ3RsMmlNR1krb0IyeXgx?=
 =?utf-8?B?WjRhdjdRbmRmQ2V5OTlXcjhrcmZ1RytoZzgvRm9RSm1COVpWcmdaMThQNFNu?=
 =?utf-8?B?eGtqZkxvci9nS25xV3gxQlVaTEZxbThhTFc4R3d6UjRrZFZYMXdrU05VM1pX?=
 =?utf-8?B?L1JwTEZETk10cFFtc0RFLzQzU2VScDN5ckxJREZiQXVKOVgrbVNKZFA2dUFJ?=
 =?utf-8?B?U1BhNlY0L1BpVDVGU3JCaDJ1S1d6TE0vS1gvMjk1N05RTjdVMnFYSnhKT09F?=
 =?utf-8?B?TDRwcHVVb2haWGllMEdSUitOaWNSclZGOE5yTHk3QjAyTFZLci8ranZtN01V?=
 =?utf-8?B?Q1JRdlZZRlBVeERycUFkTzZuTTVkYS9ZSC93T0FoUlVjYlZIYlduQ3Rpditj?=
 =?utf-8?B?RGVUTU0wRFA4MCt1YVhmY0xwdVNWa1dvOGNnWEhBeFA5dW1mMm04a2haSElF?=
 =?utf-8?B?Q21ObWlwK0plRzFmMW5PWGdZMlhiUzJHd0xoN3F1NktJVE5FclIvTWZiZ3dN?=
 =?utf-8?B?dDA0ZXZMbVd6YXkzd2FOSEttNS9WWjY0MjNWY21odHN4RGt6ZTJHczFTZitk?=
 =?utf-8?B?TDZHUC9pcnhQQUlJbmZBRWN0OXNDTWpUYjFaeVhPL0dQbUM1MU80VVpxRGkz?=
 =?utf-8?B?YjBtMGdkdmdYWGFnTEpINy94ODZGZjJBSE14UDVOR1Y3dXNacHpCMFBMNzIx?=
 =?utf-8?B?ZE43N3RpWU1CTVMweUpDMDU4TndubDFpNk5SL2hwVWRZTzBaSHZIaUowTC9m?=
 =?utf-8?B?T0dhN0w4eWxndG9CVjRGYWdsaFFOajVaZlRPekd5eGZ3UHBJdE5YMkk0Yi9o?=
 =?utf-8?B?TW9PN2VvZFY3dWg2MktMQ2Q3cDRVTFM1cDZ4VWRkOXJKaHVrQjI3TUNNdmV5?=
 =?utf-8?B?bWp2QUpaUEJPU2VDVXlNcndTdnJMMlpFN1NaMno1bHE5TE5leXk0MnRBT1hW?=
 =?utf-8?B?WVBaajVSVmxVM29VUWxpbHhxcHZFZ2d0bktGN0lNY2tBUVcwZ293NGd3R1lZ?=
 =?utf-8?B?ZXEwcUlGZ0NFSW1VVzdtMjNTd1RDMGk1UFAvaTRwR3Q0a1M2c2VBcXZiRUNa?=
 =?utf-8?B?M0NrQ1Qyb051ZHYwQnJUQUhFZ2RFSGd2WVNiUzI2RFpUSmVlUVRFMzZvVXBT?=
 =?utf-8?B?WWFFNzFtK3dNbVZhYVVlSTl6NXFxUnRFNUs1SzlyRXM5TmJZcmYwS3FuNCtq?=
 =?utf-8?B?WTdvZzRnQWVGODFQLzkwRkk5YldVWTNjbXU0aW5WZEtWZ05Sa000b0tlRlJQ?=
 =?utf-8?B?RHVWMnVNWEhUeTdOb1Z6d1F0ZU9HK3cyTExhZnBlc1BDQjk5RHBpZ3J6eGl3?=
 =?utf-8?B?OUxXejA2aDBaS21ENzNpVFNEWmhCbnZ4dHBWZi95UFR5UWkwT2FLOWFueTZ0?=
 =?utf-8?B?UVBoZXVZWnh6d25XWWEvdkEvcVBlRUhtTkFXTzNDSVBUZ2dLUHRMaWIvK05K?=
 =?utf-8?B?dE9wRFdaYXUvdWJMemVMVHE4eXJLMWRQUXV4YzRMdmZXcm5NRjRiZHRLalhr?=
 =?utf-8?B?OWlZYTQxb3U4ejMzRTFaeUNpWU5MUTVKWUoyNjF6UnQrSGI1T2JzT3pleStj?=
 =?utf-8?B?dXY0RVA1NjY5S0VxaEpvLzRnUWhJWnY1YkR3a3F1ZENGcEFBa05CaVhua1Av?=
 =?utf-8?B?cWJRSzBuY2ZiWkxXdDJiZmdBRVJvb0VGYlBJMWRWM0U5aE40U0pVc1daUGNl?=
 =?utf-8?B?bmpSNTBDaHYxV2YvRXhjZDdmYzlWOWN1dHFrSWg5UEw3NzVJbjVxM2wzbVp6?=
 =?utf-8?B?YnpjL3BUSk13bGhIeHV1S3pLeTRFcnJLVUFYTHVlY1YxblUvSWNSTi93YTc1?=
 =?utf-8?B?U1M4VUFDMitBNnR3V0dDREFwVHIwRWNHV3czQ0RrUXgxUkdLT1ZqVmVGZkc4?=
 =?utf-8?B?czJESzdMdE9JNVBoTmlLTEs2anpRQUtzUmwvZVNiZndYNk9TYkEya2trNE5R?=
 =?utf-8?B?aTI1WWdMSDkrVjVtMG0zV2F3a3B0eDZQZXhkdmtzWnVaUWJlWEVNUUhpSDNM?=
 =?utf-8?B?dC8xUlIyMnVGeW9LSWhKV0hJNWhqQkMxamUwYWhYdWM2UjFUYW1Eb3NqY3lY?=
 =?utf-8?B?Y3BQMk85ZHl0MDQzVVIrYWNaMlphZVUwVmQ1VStOUEpTSFRXZUxxMjI0dm8z?=
 =?utf-8?B?ZkZpZ1d0ZFNLL0dFTW1OWkN6ODZNODRjNnRzQngvMnJzaGNwWVV6OXRYNHBu?=
 =?utf-8?B?ZFpDK1RJVHdYN3Y3WDN2cVVmZW9mazdtZ1AvQ1RwZ2kySkxwU0t1Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YEBVEOQH0MrnbysqeFNgoyg1kGAQd+S/IHJOnqNqeADHW0Xk6vJgBzDFrb80QJMemGl0/S8k5APefg40HiWi8ykAlVIZoTGlurgEyZk2cxWmejbPXM2wXhP8A5qlJP4AYK3AYx4tMURDbmb2RFlC2dubPXm1gi0jpOnKjCnDPXguc8JxDKAXjjTfjctzkI+2c7Lk5PRPxn2RbfS7rI0OH4gEODsijAvPRiCXW5Gbmzxxfwf92bPYBRfOsQqBbHfLKbG5IYDSsVrILMve9/N111BNry7juXSkZWVihgHvPaVTVhGpoFlu8fvExXZeuzFCShu6iQvPB3v9QyU9UvKRyQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a715e76-8ea2-4670-e2c2-08deb7af9684
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 03:09:50.5324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6DEvdaoRn92HFs++dRSKqr2kQxJxzAMXlInONY6QrouxeDua9Zd+GP3xIKiHlEzq4Qow7Bb8wcGmFM2V8nmt9AZaxzPRKGbx7ky31h/y/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8218
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
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

Pj4gQEAgLTQxMSw2ICs0ODQsMTMgQEAgdm9pZCB2dGRfYWNjZWxfcGFzaWRfY2FjaGVfc3luYyhJ
bnRlbElPTU1VU3RhdGUNCj4qcywgVlREUEFTSURDYWNoZUluZm8gKnBjX2luZm8pDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0VfSU9N
TVVGRCkpIHsNCj4+ICAgICAgICAgICAgICAgY29udGludWU7DQo+PiAgICAgICAgICAgfQ0KPj4g
Kw0KPj4gKyAgICAgICAgLyoNCj4+ICsgICAgICAgICAqIFBBU0lEIGVudHJ5IHJlbW92YWwgaXMg
aGFuZGxlZCBiZWZvcmUgYWRkaXRpb24gaW50ZW50aW9uYWxseSwNCj4+ICsgICAgICAgICAqIGJl
Y2F1c2UgaXQncyB1bm5lY2Vzc2FyeSB0byBpdGVyYXRlIG9uIGFuIGVudHJ5IHRoYXQgd2lsbCBi
ZQ0KPj4gKyAgICAgICAgICogcmVtb3ZlZC4NCj4NCj5ob3cgYWJvdXQgYmVsb3c/IDopDQo+DQo+
LyoNCj4gICogVGhlIHJlcGxheSBwYXRoIGluZXZpdGFibHkgbmVlZHMgdG8gaXRlcmF0ZSB0aHJv
dWdoIGV4aXN0aW5nDQo+ICAqIFBBU0lEIGNhY2hlIGVudHJpZXMuIFNpbmNlIGNhY2hlZCBQQVNJ
RCBlbnRyaWVzIHRoYXQgYXJlIG1hcmtlZA0KPiAgKiBmb3IgcmVtb3ZhbCBkb24ndCBuZWVkIHRv
IGJlIGl0ZXJhdGVkLCB3ZSBpbnRlbnRpb25hbGx5IGhhbmRsZQ0KPiAgKiByZW1vdmFscyBiZWZv
cmUgYWRkaXRpb25zIHRvIG9wdGltaXplIHRoZSByZXBsYXkgcHJvY2Vzcy4NCj4gICovDQoNCkdv
b2QsIHdpbGwgZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

