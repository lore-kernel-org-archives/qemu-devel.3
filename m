Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5EDFCC9AD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 03:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vznZw-0008LN-BO; Mon, 09 Mar 2026 23:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vznZu-0008Kx-Dv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 23:16:14 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vznZr-0000dB-Em
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 23:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773112571; x=1804648571;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=M/32kzxY+9QsydrbaE6pYXU/hUSmwZNYCqWJuG0dyXQ=;
 b=bE0agiDGqyeLlP8uFZFj2Y0FAm3Vk7vu4yAterIsi7hGZMXBDmjo9aWl
 fSnu/qi+oEaacpPqp4F0zqskGK5QR+rTtZNYFaeBL6nAtTePAQyIf1BL+
 CN0mzTKpLERNsyNUilwo21pgMNsGI1rD6iHRpK9LN/K+munx3sn5Icbi0
 OU/QzcZejdVDQX0WD85DBamBnakIrIdLb83ONf/2fMuh6JlbO/NgtKPI6
 BQiGbbdqqjz37mVcMbbo7G2lem9shHDrTrzn8mwn3wTiHy/28HM7692gl
 +k8iPMequBKIMXHWhNPEn1YrhWmNlUPXw7QCOVqfI511a3mqDnuf6QHTe g==;
X-CSE-ConnectionGUID: meXixLxBQ1iS1Kut+v1PHA==
X-CSE-MsgGUID: FnTpr7dmQ8+JGNhf8nAuVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74228303"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; d="scan'208";a="74228303"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 20:16:06 -0700
X-CSE-ConnectionGUID: aNg7TesoQTehHSKlInd4IA==
X-CSE-MsgGUID: UnMRHDMgTra60arPywlEpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; d="scan'208";a="257879788"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 20:16:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 20:16:05 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 20:16:05 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.25) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 20:16:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yo9S9IfNh66r6Ij1EZITnw65X1dCNh2XyqDesIW+K9u9zNJuP8GDW8+ELIb+W/pV6lNPaE6pKBrsCXzNi1oWFkLLe/QDNuD8WWf+LYmcmz/S6cvmd/wB0QDuAd2Jc3POO0YSDtp6GeiP44GIa0U89NOCz8EFstACwAPyhGWXY3YKyMXLhd7u7wN9ctWrT+okj9i6ygaD9+qC9j1e6ltir4pvmFKVnvEg3ijYkcU66tET28wpwVZw2z7XJM7prybz8nCAOczIYPmWiRvwh1i502nUo2wBIKWpk8fxrSNPuNW0mlKPR3FMHsrAD6PwFykKUYSi6mSqW2R+SHGY9iNnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/32kzxY+9QsydrbaE6pYXU/hUSmwZNYCqWJuG0dyXQ=;
 b=FZAt9UmE0e+iahMtK5A4sPrBaQzOA8IwN/f0KwgyOGgdt/gLtlE5oXrMsoZMsUw1CbE2EME+Z1JAPY4gZ5NmJv8kKICVTzY1jLAlD2/geEDtIBGLW2pbqTedwTwICatmwYdIHyEld4hwnIo/oFL4FaoKdd79hJ7IxDHhPTsoukda4zO+usjUG0bm8tesPXbIGJqtUwgX70hdt/WogfXAJ/xX10D63UaPvoLp87duVQ8YEWwdM+zp/a2cX0PKac8jN5ZzttIXLJP+V4AeF8tPp+uu7AQ0e3o92Riy35EYO4SNuDr/0qJGlI44WiKJbATFDfyfUS5pu5yM38Kl9WkSBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS7PR11MB8784.namprd11.prod.outlook.com (2603:10b6:8:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 03:16:03 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 03:16:02 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>, 
 "Liu, Yi L" <yi.l.liu@intel.com>,
 =?utf-8?B?Q2zDqW1lbnQgTWF0aGlldS0tRHJpZg==?=
 <clement.mathieu--drif@bull.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [PATCH] intel_iommu: Remove 'x-' prefix from 'x-scalable-mode'
 and 'x-flts' properties
Thread-Topic: [PATCH] intel_iommu: Remove 'x-' prefix from 'x-scalable-mode'
 and 'x-flts' properties
Thread-Index: AQHcr6YGzz6xdqy6GE2gPu/CciTCTLWmJZOAgAADv4CAAO6CEA==
Date: Tue, 10 Mar 2026 03:16:02 +0000
Message-ID: <IA3PR11MB9136B00F46D18E977140FFDF9246A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260309092027.404489-1-zhenzhong.duan@intel.com>
 <02d2312f-99a8-44b2-b55a-b9cbc72feb60@linaro.org>
 <aa7Dw5PBcqLpG5HC@redhat.com>
In-Reply-To: <aa7Dw5PBcqLpG5HC@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS7PR11MB8784:EE_
x-ms-office365-filtering-correlation-id: d8f7aca2-2553-43f4-64a0-08de7e535c4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: Ks7kMnmLiJ6+h5G5RVDN9GHo1fw6EIIXZSSmRSCwzWld9ziLzc8VjDgMxxihYOlnm6UE1WmBqKvy5N/OVNJR9WqHlp4EuAfjt4pCWSQNQ8lrXkYzJ/R1JPwIPvHkEKvDuVaABfSttImlRx757CxszaVx5Zhgdn151UK1xYBnYAZTD+Lenhe6B17mxlVYr0Rk/qt7pygzAWOgZ7iCnLv7A+IDwoUqDTg06a8+bW0/mUv2la5R3CP9lBL9a5B6It/9l7Fp4O7l7Jc8hS8cqJwusvGqn31UC+oERI4gUlK6TsrHv1VI4iReldmi53AgWjU7XJ/0nZEIWf6G2GvIRFSuY5umz1D87XZ6KcePS7icUuIunVvvVB0jc7EDq/FKe9YXY79iqsNNCZQJx5gCl4GBX+EzaP4jvkkxIMz3Mym7fDaZlrJyL4MxVgY619gmZA0ZVJBu005ABLaENdBY10lNt198U8nLIi8XIXhZ94JS5lKtl6P01RFVzVzY3/sZhbG6TK09pShqrtwh9giPfiVKp6AEdj2tVGa3M+U3M2Bh6cSc7af+Dwr3nQ2UdESKote4QJJn975l6jj0c/9k2jiPK8mIqeypOZvRJcnU2X9+RNiiNa0jPlklmXR7NZW+bDP/zUIk7sviGo4+lMhRG9pnTuy71ajYEbkZbTnO+9r1Iftn/6+INnKxFzgwXKQYB9yqE/p+SfH5MNYWiSqPj+6lEGkSAEU+3e3zU9e5PLpGFYM34T50ydp6trquxuAVrvwtP3Ag6u5/jKUXms8jOa9vuSBKB46mkc9LYIA5Sz9wAwU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzFlNU9zSzFsQmdRSUQrbWFCUlNTQ1VRQlMweHQyV1VZcFNkSGJBK3FHdXFN?=
 =?utf-8?B?R25ITTVkOWNHYmZTS2VNYk14TDNudzFXNXRxQWtnK1YwSTdzNVUvU21ncHFL?=
 =?utf-8?B?clV4RENJQUR1L3A0SU5qOCtQaFdCL1l3WVFkOVh1NS9zcHpRYU11dlpJWjVq?=
 =?utf-8?B?L3lzcEVCRFo1Z1FjVkpNcytFMmJpdTh0MEtzT3hPb3lTclREZmwxdjU1TVEx?=
 =?utf-8?B?aTA5UllpTG4zTjVqci8xSUF5dFkzdVpla2xVZ0lxcEV6dTRMSndMbHBYL1Qz?=
 =?utf-8?B?bXZzQkVjQVI5dUJOckxIaTlkR2VkUm9HeEgxRlBrUmFQQUdzMmg0UkFBdllp?=
 =?utf-8?B?SkJvT3NDZW5yREtmWXNuYUVuSW9ZcE45eGZrUHU4cEt6SUZYNHVCcVlZbUxt?=
 =?utf-8?B?SWVnQkxWSnI5djJxRGM2Smd6aDltYnU4UVVlV2xiYUN1dDVDV082OU5RVU9i?=
 =?utf-8?B?MWRsc1JZR3dGYnhnOENzcTh6ZmpGZWczQzNOc2dVM2ozZ0dDRW51MFNPU0xy?=
 =?utf-8?B?bDdsVUVXRHdBbmo0akF6YUFqVThsOUF5NklyVzYyNjh2TGdlTzNLUmJ4alNM?=
 =?utf-8?B?cUdraS9JTWRHOEtQTnJvdkRJUWtKL3plUWF2RzR2Mk9oa2Fra2dBNmNjNHlp?=
 =?utf-8?B?NUZCc05DU2lPUCs1QVVFT012N2N0b3pzK09OcW9sc2lNM1BsN2JRT21ncTU0?=
 =?utf-8?B?M05MR1ZaUkFiTzUvY1VKb3JtTTFoT3NHNEQycEtHNUROdFAwb1VEYjQ0UkpK?=
 =?utf-8?B?cDNTRW1nMUw0WTJEelVzSnBGRHVFaVBBUVNFUmNGakFWaGhIUVpGbGJTczF0?=
 =?utf-8?B?YkxsMjVzUEVuaHBhSW91SkRDL01ZTWJia0RoTUYrSTMyYUNWMUpCMnk5Z2VK?=
 =?utf-8?B?N2lpVmtjMU44UVpJRDIrU0l4cVA2SEI4MUhZT1lobUVmc0Q0dGZKcTdmcUNz?=
 =?utf-8?B?WlAwOTl0MmVSY2cvY1g0anhpa3UyYzNVL090V3V1VkRKNTU3K0hIbVNiZ2VQ?=
 =?utf-8?B?OEZ3cGVnZ1ZRVFhqdnFXOXBRdEJ2bWZ1TnpGV0hTUnFsbkhTT292TTV3WVNX?=
 =?utf-8?B?UnlwUUJYanpPWGpIVHl2RkhwUWtXbTZLNXZZQ29RN3BibWNhV3JUUmY2RWNV?=
 =?utf-8?B?VW5NV2psV1NkSjdxU2hOdW1RR0tXa1VNRTVlUzVZZ2VxQW9YanZYcTNKbjhI?=
 =?utf-8?B?c1VPSy9DZHZKNUhSMFk0dDJJTjBsUUtzRUpSdERLaVhSRkx4Z3h6alFKbGsz?=
 =?utf-8?B?eXdGWHRDMU9STSs2dWZPWlJjcXUyVzZNS0FNbGpERUI5aHIwdVNSd0hKTGZW?=
 =?utf-8?B?NVhsWnJUeXlZNk1GZnhpTEFSNVZPVkZOc0p2YWIraUFaQzJzZ01rS0ZGVzlw?=
 =?utf-8?B?TmZxRmZQemsvdElxZmZPMXgrT1RTU3Y5VFpKbVlRQzcwMUZVQVlWdTBlL1pt?=
 =?utf-8?B?S1YyVG9DOGxQN1Q5YkFtcHZFb0thekFhS2VqSXdIcW5aSk9sWUpTQXNPVURv?=
 =?utf-8?B?WkErSDlQUWYwU2ZjanNKRnUrVEVRd2Y0MVJ2UTdROW5LMUZCd0RobkFXRDNP?=
 =?utf-8?B?azJsUHJrUnM4RVh6RjFETFRac2ptVFVjTElHdmdLalpmWUpNZStMYkVQTnRq?=
 =?utf-8?B?bDh2TkhLTlVMbzNiUE84Y2JaelZPTlowaG5JVjJ3WGRoTjlWSVpTTUkzT1BQ?=
 =?utf-8?B?TGpXUld1cE5oalZyY25pWnN3NlYxN0QxQ01pZEdXMUV4NFQzaGZiamVTaytU?=
 =?utf-8?B?c2JLVVlsQm5Wdnl2STM2MXdUNklKQk85TWkzSkVGem1rUWpjRTlLUWFCc2VT?=
 =?utf-8?B?aGMxUXBkcG9DRUhGVXVLS2hjMHk1R2NHNGhkU0JZWk0wVjZmbkVQWmgxSkow?=
 =?utf-8?B?ZnkrQTJROVIxRjMrS25iOXRKV0QzSEUreGNMZmJBWTFLaXZLVy9ERlRhZDA1?=
 =?utf-8?B?aHYxRnNrbFFiM3hqdFRDSlI5RDRJTTZBa215UmxXZDFNK1p4TzJlWGR5Witt?=
 =?utf-8?B?ZGpDMVpsclU5TWszN2NXNzVzdUp6eEZtSGI3QUNmVGlMbEEzUFBETU5IQXlQ?=
 =?utf-8?B?TmYwb3JiQThmWGRRRGdqdFMrUmk5NjhjVVdaZEtFMzBobXZUYUNpZ3ZKNzl4?=
 =?utf-8?B?dXdOQnF6b0dBVURXYmRxay9pOTZpWlBCS2tpTGg1TzNJdkVKdSsycWdDSEpa?=
 =?utf-8?B?MnFocU01Nk9ZazNMcHNFTENJUWhGZWNTV1RlcjlRYWlaTHFMR1hBRkNTMDNx?=
 =?utf-8?B?VkNIUmFJYUYvOEVRQkxYMFJPZWxiR2g3ODBsVmxSclVuMGNWSXRxMnpxYk5R?=
 =?utf-8?B?UnJxN0psYVFWeFU1aTg0aUVmYTkxaGsyVlp4SzNocGRnTVJ2ZGlmZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oKsdIe1DOSwB468O2KKcuujbR5IMxpy3vD5fJNOqEFABJKVDwytAWAXCnFhTaSmXq521buP2hi8trfMcPptD6gUn64fPoCuIyjGw3ZPEnTVw7PYBiBemGHwSbAiZz6XNSuLIR0M7gLnbWuKccUclUUAX3FxjV977rXpH3/Cg2gK446MdFr2YjI4uChRDC+bb9VWQ+9IFSxp/SEWD5bbrELz7XDHwm/2Vz+zIVj2fhx+LnJO6t5HExwcVhKCQlz54ZXBXEiRLvMDOGfoTgHbbuFPyOyP4lYH6AdqoCeErdFlxfQtfp/LrxYZTj2gV6yEhrr94uNAiWPYMNoWTbx19Dg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f7aca2-2553-43f4-64a0-08de7e535c4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 03:16:02.8972 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BeAsV5QLLb0LEhblz6R2ZJH+SQQVa+k+fS1BSH2/lXJbxUDND3K3h8rp18pDf/qLScEx7Hx/wclwgPAvLRKX1LvhzHUJ504o8aC6y+DtF5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8784
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhbmllbCBQLiBCZXJyYW5n
w6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gaW50ZWxfaW9t
bXU6IFJlbW92ZSAneC0nIHByZWZpeCBmcm9tICd4LXNjYWxhYmxlLW1vZGUnIGFuZA0KPid4LWZs
dHMnIHByb3BlcnRpZXMNCj4NCj5PbiBNb24sIE1hciAwOSwgMjAyNiBhdCAwMTo0NDoxNVBNICsw
MTAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+IEhpLA0KPj4NCj4+IE9uIDkv
My8yNiAxMDoyMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiA+IFdlIGhhZCAneC1zY2FsYWJs
ZS1tb2RlJyBmb3IgbW9yZSB0aGFuIDUgeWVhcnMgYW5kICd4LWZsdHMnIGZvciBtb3JlIHRoYW4g
MQ0KPj4gPiB5ZWFyLCBpdCdzIGZpbmUgdG8gcmVtb3ZlICd4LScgbm93Lg0KPj4gPg0KPj4gPiBU
aGlzIGlzIGEgcHJlcmVxdWlzaXRlIHRvIGVuYWJsZSBpbnRlbF9pb21tdSdzIHNjYWxhYmxlIG1v
ZGUgYW5kIGZpcnN0IHN0YWdlDQo+PiA+IHRyYW5zbGF0aW9uIHN1cHBvcnQgaW4gbGlidmlydC4N
Cj4+ID4NCj4+ID4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4NCj4+ID4gLS0tDQo+PiA+ICAgZG9jcy9kZXZlbC92ZmlvLWlvbW11ZmQucnN0
ICAgIHwgMTAgKysrKystLS0tLQ0KPj4gPiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAg
ICB8ICA4ICsrKystLS0tDQo+PiA+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jICAgIHwg
IDQgKystLQ0KPj4gPiAgIHRlc3RzL3F0ZXN0L2ludGVsLWlvbW11LXRlc3QuYyB8ICAyICstDQo+
PiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkN
Cj4+ID4NCj4+ID4gZGlmZiAtLWdpdCBhL2RvY3MvZGV2ZWwvdmZpby1pb21tdWZkLnJzdCBiL2Rv
Y3MvZGV2ZWwvdmZpby1pb21tdWZkLnJzdA0KPj4gPiBpbmRleCA3OGJjZGZmYWM3Li41NzU1NTMy
NDQzIDEwMDY0NA0KPj4gPiAtLS0gYS9kb2NzL2RldmVsL3ZmaW8taW9tbXVmZC5yc3QNCj4+ID4g
KysrIGIvZG9jcy9kZXZlbC92ZmlvLWlvbW11ZmQucnN0DQo+PiA+IEBAIC0xNTMsMjIgKzE1Mywy
MiBAQCBSQU0gZGlzY2FyZGluZyBmb3IgbWRldi4NCj4+ID4gICBgYHZmaW8tYXBgYCBhbmQgYGB2
ZmlvLWNjd2BgIGRldmljZXMgZG9uJ3QgaGF2ZSBzYW1lIGlzc3VlIGFzIHRoZWlyIGJhY2tlbmQN
Cj4+ID4gICBkZXZpY2VzIGFyZSBhbHdheXMgbWRldiBhbmQgUkFNIGRpc2NhcmRpbmcgaXMgZm9y
Y2UgZW5hYmxlZC4NCj4+ID4gLVVzYWdlIHdpdGggaW50ZWxfaW9tbXUgZmVhdHVyaW5nIHgtZmx0
cz1vbg0KPj4gPiArVXNhZ2Ugd2l0aCBpbnRlbF9pb21tdSBmZWF0dXJpbmcgZmx0cz1vbg0KPj4g
PiAgIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gPiAgIE9u
bHkgSU9NTVVGRCBiYWNrZWQgVkZJTyBkZXZpY2UgaXMgc3VwcG9ydGVkIHdoZW4gaW50ZWxfaW9t
bXUgaXMNCj5jb25maWd1cmVkDQo+PiA+IC13aXRoIHgtZmx0cz1vbiwgZm9yIGxlZ2FjeSBjb250
YWluZXIgYmFja2VkIFZGSU8gZGV2aWNlLCBiZWxvdyBlcnJvciBzaG93czoNCj4+ID4gK3dpdGgg
Zmx0cz1vbiwgZm9yIGxlZ2FjeSBjb250YWluZXIgYmFja2VkIFZGSU8gZGV2aWNlLCBiZWxvdyBl
cnJvciBzaG93czoNCj4+ID4gICAuLiBjb2RlLWJsb2NrOjogbm9uZQ0KPj4gPiAtICAgIHFlbXUt
c3lzdGVtLXg4Nl82NDogLWRldmljZSB2ZmlvLXBjaSxob3N0PTAwMDA6MDI6MDAuMDogdmZpbw0K
PjAwMDA6MDI6MDAuMDogRmFpbGVkIHRvIHNldCB2SU9NTVU6IE5lZWQgSU9NTVVGRCBiYWNrZW5k
IHdoZW4geC1mbHRzPW9uDQo+PiA+ICsgICAgcWVtdS1zeXN0ZW0teDg2XzY0OiAtZGV2aWNlIHZm
aW8tcGNpLGhvc3Q9MDAwMDowMjowMC4wOiB2ZmlvDQo+MDAwMDowMjowMC4wOiBGYWlsZWQgdG8g
c2V0IHZJT01NVTogTmVlZCBJT01NVUZEIGJhY2tlbmQgd2hlbiBmbHRzPW9uDQo+PiA+ICAgVkZJ
TyBkZXZpY2UgdW5kZXIgUENJIGJyaWRnZSBpcyB1bnN1cHBvcnRlZCwgdXNlIFBDSUUgYnJpZGdl
IGlmIG5lY2Vzc2FyeSwNCj4+ID4gICBvdGhlcndpc2UgYmVsb3cgZXJyb3Igc2hvd3M6DQo+PiA+
ICAgLi4gY29kZS1ibG9jazo6IG5vbmUNCj4+ID4gLSAgICBxZW11LXN5c3RlbS14ODZfNjQ6IC1k
ZXZpY2UgdmZpby0NCj5wY2ksaG9zdD0wMDAwOjAyOjAwLjAsYnVzPWJyaWRnZTEsaW9tbXVmZD1p
b21tdWZkMDogdmZpbyAwMDAwOjAyOjAwLjA6IEZhaWxlZA0KPnRvIHNldCB2SU9NTVU6IEhvc3Qg
ZGV2aWNlIGRvd25zdHJlYW0gdG8gYSBQQ0kgYnJpZGdlIGlzIHVuc3VwcG9ydGVkIHdoZW4geC0N
Cj5mbHRzPW9uDQo+PiA+ICsgICAgcWVtdS1zeXN0ZW0teDg2XzY0OiAtZGV2aWNlIHZmaW8tDQo+
cGNpLGhvc3Q9MDAwMDowMjowMC4wLGJ1cz1icmlkZ2UxLGlvbW11ZmQ9aW9tbXVmZDA6IHZmaW8g
MDAwMDowMjowMC4wOiBGYWlsZWQNCj50byBzZXQgdklPTU1VOiBIb3N0IGRldmljZSBkb3duc3Ry
ZWFtIHRvIGEgUENJIGJyaWRnZSBpcyB1bnN1cHBvcnRlZCB3aGVuDQo+Zmx0cz1vbg0KPj4gPiAg
IElmIGhvc3QgSU9NTVUgaGFzIEVSUkFUQV83NzI0MTVfU1BSMTcsIHJ1bm5pbmcgZ3Vlc3Qgd2l0
aA0KPiJpbnRlbF9pb21tdT1vbixzbV9vZmYiDQo+PiA+ICAgaXMgdW5zdXBwb3J0ZWQsIGtleGVj
IG9yIHJlYm9vdCBndWVzdCBmcm9tICJpbnRlbF9pb21tdT1vbixzbV9vbiIgdG8NCj4+ID4gQEAg
LTE3Nyw0ICsxNzcsNCBAQCBiZWxvdyBpZiBpdCdzIG5vdCBuZWVkZWQgYnkgZ3Vlc3Q6DQo+PiA+
ICAgLi4gY29kZS1ibG9jazo6IGJhc2gNCj4+ID4gLSAgICAtZGV2aWNlIGludGVsLWlvbW11LHgt
c2NhbGFibGUtbW9kZT1vZmYNCj4+ID4gKyAgICAtZGV2aWNlIGludGVsLWlvbW11LHNjYWxhYmxl
LW1vZGU9b2ZmDQo+PiA+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCj4+ID4gaW5kZXggZDI0YmE5ODliZi4uMDAxODQ3YWQzNyAxMDA2
NDQNCj4+ID4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiA+ICsrKyBiL2h3L2kzODYv
aW50ZWxfaW9tbXUuYw0KPj4gPiBAQCAtNDIwMCw4ICs0MjAwLDggQEAgc3RhdGljIGNvbnN0IFBy
b3BlcnR5IHZ0ZF9wcm9wZXJ0aWVzW10gPSB7DQo+PiA+ICAgICAgIERFRklORV9QUk9QX1VJTlQ4
KCJhdy1iaXRzIiwgSW50ZWxJT01NVVN0YXRlLCBhd19iaXRzLA0KPj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICBWVERfSE9TVF9BRERSRVNTX1dJRFRIKSwNCj4+ID4gICAgICAgREVGSU5FX1BS
T1BfQk9PTCgiY2FjaGluZy1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBjYWNoaW5nX21vZGUsDQo+
RkFMU0UpLA0KPj4gPiAtICAgIERFRklORV9QUk9QX0JPT0woIngtc2NhbGFibGUtbW9kZSIsIElu
dGVsSU9NTVVTdGF0ZSwNCj5zY2FsYWJsZV9tb2RlLCBGQUxTRSksDQo+PiA+IC0gICAgREVGSU5F
X1BST1BfQk9PTCgieC1mbHRzIiwgSW50ZWxJT01NVVN0YXRlLCBmc3RzLCBGQUxTRSksDQo+Pg0K
Pj4gSU1ITyBzYWZlciB3b3VsZCBiZSB0byBvZmZpY2lhbGx5IGRlcHJlY2F0ZSB0aGVzZSBpbg0K
Pj4gZG9jcy9hYm91dC9kZXByZWNhdGVkLnJzdCBhbmQga2VlcGluZyB0aGVtIGFsaWFzZWQgdW50
aWwgZGVwcmVjYXRpb24NCj4+IHBlcmlvZCBleHBpcmVzLiBPdGhlciBjaGFuZ2VzIExHVE0uDQo+
DQo+VGhlIHB1cnBvc2Ugb2YgdXNpbmcgYW4gJ3gtJyBwcmVmaXggZm9yIHByb3BlcnRpZXMgaW4g
UUVNVSBpcyB0byBkZWNsYXJlDQo+dGhhdCB0aGV5IGFyZSBzdWJqZWN0IHRvIGNoYW5nZSB3aXRo
IG5vIHdhcm5pbmcsIHNvIHdlIGFyZSBmcmVlIHRvIGNoYW5nZQ0KPnRoZW0gd2l0aG91dCBhbnkg
ZGVwcmVjYXRpb24gSU1ITy4NCg0KRG9lcyB0aGF0IG1lYW4gSSBjYW4gYWRkIGFub3RoZXIgcGF0
Y2ggdG8gcy9mbHRzL2ZzdHMgb3Bwb3J0dW5pc3RpY2FsbHk/DQpmbHRzKGZpcnN0IGxldmVsIHRy
YW5zbGF0aW9uIHN1cHBvcnQpIGlzIGEgbmFtaW5nIGJhc2VkIG9uIG9sZCB2ZXJzaW9uIHZ0ZCBz
cGVjLA0KaW4gbmV3IHNwZWMsIGl0IGNoYW5nZWQgdG8gdXNlIGZzdHMoZmlyc3Qgc3RhZ2UgdHJh
bnNsYXRpb24gc3VwcG9ydCkgbmFtaW5nLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

