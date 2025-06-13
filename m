Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A23C71135
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 09:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ0PJ-0004AB-CT; Fri, 13 Jun 2025 05:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uQ0P1-00047o-Ge
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 05:08:53 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uQ0Oz-0002wf-4Z
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 05:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749805725; x=1781341725;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1bz6Vw//CJ7jpyk0VgaAnwwKc9mUGLxoKGEBDOkjAS8=;
 b=BUlNB43ft/B2UeljAEnZaoqfwrTEfC730cJ9cW1vlPguuhhLYOAZ8ba2
 3isN8eR6/tMagcf4urxOXXqi2PqL0CsKW12jK5DeCt4rhbFIiQYBTEaJs
 JatnkQEIgZOxy/MPGRc3WYsAffDfac0VUX87PJOam0fbyOSm8WW3jWcN0
 3eGrexqyBM2NBWwioYDARCuBZ0hZhQnsUgvRHB8isZ/RhL9eTcAIGuq6U
 znNQ2npcfSB8Xl2Am+8wxEaWxWlDl1qACrEYI4DhZWmtWj5ywRNvqKo7T
 t5Zd5FmQLvIjr3jVdO6JYs07/eC3tRpYbWM2wNJv83cNfGgk+4V4hKoKF g==;
X-CSE-ConnectionGUID: /dTyR6sTRl+5WLZWzWscRw==
X-CSE-MsgGUID: aQ/fvNReSYK/tvQ1lFhjmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="52110860"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; d="scan'208";a="52110860"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 02:08:39 -0700
X-CSE-ConnectionGUID: pp9W25tZS0+lN3mgOQwqSA==
X-CSE-MsgGUID: v7t1gHDTSZ6yY1xxJXlr+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; d="scan'208";a="153067478"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2025 02:08:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 02:08:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 13 Jun 2025 02:08:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.72)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 13 Jun 2025 02:08:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c+dMwqdVFQ08OZxe7SYLfzDSL+55syo4UAxJr8LTyFnrcMeyjc+6MywA7Hj5LK4LJIkG/G7Felp+7cZYADxADbL3Kdl0DKaRhL/BQpASODTzG6HjyJpEgkU7OTvYQsrSXpI1fdGWX0haK25Kimo4gIKJgikuZ9K6kzQhttwj5xy/xjcCCXlv/NRpKQdMB7JROhtneHFE8fWVWmRntw6HtvqWsHhNHlU/XvqSP18RMJtFIWbfkVZ7ERMFkbt9wLorVkls6TEPvi9mMKRvI3mHfZPawTignhChbYrRPfAnanEREdSdAZzw9tGZ/Nm9gf/o/tTUfdF0ZGZzwvhWIL6w2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bz6Vw//CJ7jpyk0VgaAnwwKc9mUGLxoKGEBDOkjAS8=;
 b=AVLzH3iNYkpzeYU6VoT48xyELSso58E/n4JlkMErPZ9zQi9jLmEf9MYFr8ay3tnwJTjYIE7Cm4HKgki0x0e0yruZXCU89JmYDynGhML1iqxQPz61dsuxYWeeNbYFW39CbqZqLqh9YS3HjdIdqaJJ7iVyfyl051BRK+eFOo99aGqFwasGvNgRBtDkp6w9pg5DkI0LW26WBWNYOXx6klslmM7+dagcaeVyrLQ52gn4OtO0VD4FWSRSQXZEChgkZGRWNUn/0fy2U4WIMcovN/1M5WDvPTvtp/l7MxL33lIy+DNOI59Ut5NWPEznokq5/CKgJOdKiPr37yMIBmyVumzaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA3PR11MB7485.namprd11.prod.outlook.com (2603:10b6:806:31c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Fri, 13 Jun
 2025 09:08:33 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8813.036; Fri, 13 Jun 2025
 09:08:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v1 04/15] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Thread-Topic: [PATCH v1 04/15] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Thread-Index: AQHb1sr6ZBH0bAdOMU2U0Bx9QtO/NbP/udgAgAEdYPA=
Date: Fri, 13 Jun 2025 09:08:33 +0000
Message-ID: <IA3PR11MB91363F234F379A878B612FE69277A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
 <20250606100416.346132-5-zhenzhong.duan@intel.com>
 <1cf2ecbe-1f98-452f-8a39-331e7d459969@eviden.com>
In-Reply-To: <1cf2ecbe-1f98-452f-8a39-331e7d459969@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA3PR11MB7485:EE_
x-ms-office365-filtering-correlation-id: 3f3e9835-7ae5-4c18-274a-08ddaa59df57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?M1doQThwVU85dHpmaE03RVJlRG5sRnRPYkFHeWExS09heS9BOWZBelFhZ0k3?=
 =?utf-8?B?NWlTQVAxQmE4K0pPVHNHMjNwcjk4MWV5VXh4RXc2VGc2R3BBdlBWOHpSeG1Y?=
 =?utf-8?B?cmtid3RtUjFMVSsrdVR1MkdXbHZmcXRZRnVQUlJ2RTlSNHJUY0szZlRIR2FK?=
 =?utf-8?B?blFYa1pXNzYvWmxBR09WUlRVVTE3MU9xM3JzRndud1oxc0kzTE1qSm1YaFlY?=
 =?utf-8?B?K1g5UUlPbkwvRThqUEJpYmpPa3dNeFJ6dHlENG1zdHlyd3FDV1JmTThCdm9B?=
 =?utf-8?B?MkVsbWlRdWxSUkFLblhFaDlVdmhyOERUTWV0cmg0Wlc0b2x6Zmp0M3ZPWG1t?=
 =?utf-8?B?NEdIZGJ0Q0tFL0w0VmhEemVGVThzNEh6L0ZFY1pKVHowWmxBSCtna1lZVHJz?=
 =?utf-8?B?MVFRRXdDakRyM0RpdHA1cjI4TkR5TWsvWkZwcUVGK05sb2JWNHhQWnpseDc2?=
 =?utf-8?B?YUpPcWtCSEMwNS82U3VZUEJXY2dITDV6OFBOUnRqc3RhVGNNa25OQklZYkxB?=
 =?utf-8?B?aDVML0Y3MEYzVFBvRnB1U0hhZ0w5Nlg1aXhxMHovOXZGKzIrRUJaZ3dxNjhv?=
 =?utf-8?B?MGFCclgvWlZtSmNaNEZ0SnJtb3VkZHd3cTdncGRqVDQvR01oTVJiRXVMeFlB?=
 =?utf-8?B?Vlc2cFg0aGJLcy9KSTl1QmxlZ3RwRG1XR0xXVThTVENpVUtPRzUwYVZtZmd4?=
 =?utf-8?B?TXVkK3psaFBNY09kR2Z2eDc3Vi9UdDZXR0dmMlB6K2hoZFJBYnNtVUo4c3lH?=
 =?utf-8?B?STdSZ2tuT2N4dkFZRWtPZXp0MURxV0ZxcWttZ0p2UVovZ0p0RTl0OVNIQi9P?=
 =?utf-8?B?TlYvN25TSVJya1U5K25FbHJVMUhGaUtLRm9hUm16VGU4ME5Qem1jTnc0MUl2?=
 =?utf-8?B?dk1WOUN1bDIxaDZNSEhJWlVCRk5uem9NSi8wL2h1akJjbVNsL2xwbWRkNmo4?=
 =?utf-8?B?cEErbDNBS1E4YkNhSUVaazUveVErZlZ6UDVhWG8xY0NFT2VRczlvaWZHTkEy?=
 =?utf-8?B?MUEybHNxODJwNmZraXptZnFFR2lXTjMyelNkTGRZRTJCdUxjZ1RyRzJwcG1U?=
 =?utf-8?B?empBQkh2cUpjSkUzVHV3NGxIYjZjVVlab2JRV1MzcXVxeUVVdzVpdmZEYkli?=
 =?utf-8?B?SkFBbEp1UjJWdVcyMnl3ZEpuR2oyak1xUVM3WXJUMitpYVBDbnpBQWpLL0tp?=
 =?utf-8?B?d2VDUDZ5RExodjdqL1drMXNycHdRdytaR3JJRzNOR3NxQXBFaDZIQ0o4L1Zo?=
 =?utf-8?B?RUJjZHdJY0tDYVFoYzE2aXRoeFRyRFdGYk1Jc2NwUWVyaU53SmRBcFlpREk2?=
 =?utf-8?B?bEpBUDFQQ0x3dkFDTTFUR1pXR3Z1eHh4N1E1NTlGbGI1blNBNDRTcnl4ZHp3?=
 =?utf-8?B?cXFJTVBTeHdaZjQ2SVM3TUZjUjA1bkFDWHRpcXkxaVl6UFlpU290S0htRlNE?=
 =?utf-8?B?YnArZzZaTGZxZ2dWcERqZUd5OU9LbVFQZ25zamhteHRPeUtld2JLU3diUEcr?=
 =?utf-8?B?dXJzZlVka2V6aDdvMmNlS2lMSmNZdHh2cFl2QXdXU2pHTUpqai9rZzBIaHd4?=
 =?utf-8?B?SkRaeFNWZnN5YjdFRVA3by9TZGxIZEFtWHBtSzYzVW5GbTVrN1pPWG4yQnlM?=
 =?utf-8?B?VHF0R2xmY0Q5Z2tqek5HMDNlY1dxVjVNczk2aklzRnJEajI2NCtZQkVmeElC?=
 =?utf-8?B?NHhBbFMvUFE2WFN3M0hQbC9lbkNMK1oyTUhiMHBaQWZIaVFMVG94Q3RsZnd1?=
 =?utf-8?B?QS9QbXJEampaU2J2T1dSUm05NUZuWmc1VnYwaVJheVJEb1lPN2xRa2t4VHd4?=
 =?utf-8?B?M1JvN2hhYXM2dEhRMjNHbm01eDczdERsL05nN1dJSGFoZDRpUzd2VXU5d1VE?=
 =?utf-8?B?RHF2dnFRU2VSdGlnbmhUTHVTODc2c2oyN2xpV2VleGc3UTF4NnVmWWxWM1My?=
 =?utf-8?B?R01zRUVQT1pwWWx0QXJ6K04zUjZjVGNDNWVseWh5ZEFBKyt2UXZiL2psQjR2?=
 =?utf-8?B?Uy9rckdnMExBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MElEMDJXSjNaS3BXRlFvcW85RitqR0owK1dCUXg3anFYaENMRDRZVE9IS0pz?=
 =?utf-8?B?dnE3M1pVb2t2dXY4RUxKRmFFeHFTbXZFQkxib2hkVU5QTTRNRmRHMTdya1A0?=
 =?utf-8?B?cXdpUFVWR1V6a2ZlcG5vNm1IQmJsUzdFZ0RJK3YySC9ZVzV6WHVYQ2RaNTJC?=
 =?utf-8?B?UDBMRHIxYUl0bDRyK0l6c2lJRjlhS2JET09PRVVpZDlSbzJTZlgvSWdGZHlv?=
 =?utf-8?B?MVA2dUtWdnFRMk9pWEtuYlptWlZmZ01rVFV4V25tUHBqWUEvcU0xdUEzYlBw?=
 =?utf-8?B?MG40THZwYjNZbkJDVGRFNC9Nbi9KazIrN0RDZDJVNG42SWpKRHBWVGw3Ulls?=
 =?utf-8?B?cG1kK1V3Y3RUd1RZa3h4cXpReCs5UVZaeFVRd0lwcXRkVVM4dGFxdVNKRzAy?=
 =?utf-8?B?cEZYT29sZEJGNkhIaXhGM253NkJXUlRuVzRkZ2REaDhTZVorSXFrTFhySzlO?=
 =?utf-8?B?UzY3TnJhOGRZblJJdWprcUpHNnZtM0swc3VTSERySjgzQ3pMVnBWSnRqWDVw?=
 =?utf-8?B?cHdmODl4UUR4eHhEYU04bzloU0Jzam90OHhwSldPVHFmSWQzU0dPdHRpY0xk?=
 =?utf-8?B?bForM2R3KzRmVVFtY1VaeEozaDZweVhBVUNaREFERWI3aUYreS9PMXRPc0dx?=
 =?utf-8?B?R0xiVkhQWjNUdTN3cURrMVZPVHBMWCtzQ2lyTlo4T0tJYzNSUkRIL05RSHNZ?=
 =?utf-8?B?bXd5SjFPSzZ6alRZaUhwa2ZnMVFUVjRZUGxnRlgza3Nock0wTGUyRkR0MTVw?=
 =?utf-8?B?cmZKVjQxWmpQS0pJNHE0TXFsaVlUNVFvRXRMdjRtK1E2aTFwczNxT2hNL01F?=
 =?utf-8?B?Qm00ZGVLQXorSVl6cEVYWVJGcUwyaVdmaTM1MWFiY2hxUTdCb1JTVXhJS3Bt?=
 =?utf-8?B?MFRuc2F6bThqUzA4empFUDdYR0UwOUhraC9CZ0taU0tBTi9OejZqRzdYTjhP?=
 =?utf-8?B?ZXJZZFY1QkJZVnB4Z2pkdHNLVTgydnpFbERPQ3cxZHIxdTA0eEFreGp4QTU2?=
 =?utf-8?B?Z3RIcE5UVzJwNmlsV1QrMFdTb3h4eWhRUGVLNDZCd2VQM3ZtbGRqdzJlTEpM?=
 =?utf-8?B?enR4OXI0YVBpOWd6eG0xbzJubXRzeEd3TnVHOTRGaDVvOGVhbHBNb0h4eEhE?=
 =?utf-8?B?QjBmcnhqU2tRdGlsNFNLT3NWaEJoTGJDdlc4YlBGa2JPWCt4UnhOd2lMN0h4?=
 =?utf-8?B?L0xYU1BKUHRhbUdRakpVUytYejNrL2l2TDhNQS9qbzRBdGN4WWpaTlBJMXBP?=
 =?utf-8?B?MWk5SjBpdEpoVjlLcE15eEUzc1dEdWYzdmdibGY4KzdKR1lSd1U4YmtDcmRM?=
 =?utf-8?B?QmNOWHg1ZXpKUkdzUmtnWWdqMG5Gek8rRUs5dnVKZEx2WWtycEJJYTlsLzl3?=
 =?utf-8?B?Yi9Db2txTVNKenZlOUtPMFkrMFA0ZXRWeENsTmxqUUtHUDdSaFBURm5JWXpF?=
 =?utf-8?B?RUxFenJPd0RXRm9YRUpzZmtubjFFNWVDRURnUHRreVo2ZWZaNVJ2VXB1N29n?=
 =?utf-8?B?eHFUeGswUzNjdjVOK1dTcDNEdXVIM2ZOWVduVTY4RnQvMVAzZldibUMrQ1VR?=
 =?utf-8?B?dnBKa3hxcGhQdldtZlE3dFoyY3FKQjYyeTVZY0pTSGk4clFZM3BnRGU5Rmxv?=
 =?utf-8?B?d1pDS0szVGFkSEJiM3JiSGNLYWpMdnJMdlB5aWJPNzhDcHZwWVVSelhUTEhZ?=
 =?utf-8?B?WFpkczR2dGJCeEVYUHVMYzY5Z2pwSS8zUVZyNzl5d1Z3OWx2a3FPdiszbjRH?=
 =?utf-8?B?ZElsT0JGTDhsdHdqRWV3RlJDdXQ2U3RzNUVhQWxWd1hpLzV4ZnhwWnFjaWYz?=
 =?utf-8?B?bjBJM1M4bnd0dFgrWWpjTllYeldlbnNmOUxyQzFxZEgybXM2R0hkakFZd1Ev?=
 =?utf-8?B?YWdNMzRaZVZyYjlybUlVV2cwdWtWZVQwUmxhTVNjV0E4b1dXWlRwN2g4UDNY?=
 =?utf-8?B?c0MrMXpnNTN6c2sxSU5MZm96Y09ENm84a2ZOMnN2U2dkUzl2MjY4NmJ2NzQy?=
 =?utf-8?B?UlpQV1lyS244VE5KRnk4Zm1vcWhzL3ZLTURocmlRMTM0ZnFYNktVdnNXM1d1?=
 =?utf-8?B?K2ZDUHQwMXMwbGl6V0t6Q1FVWkZEVTl4MkhSZUxtY015YVdNbGxkTjdFVkNN?=
 =?utf-8?Q?S0rgH4ZauOR1TL+seq5VuRfhc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3e9835-7ae5-4c18-274a-08ddaa59df57
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 09:08:33.1703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vI1CpQ4FC5Du3QrHlqaiEO7NY/TopCiiBDBSIwHLj1cwK23UQ0hZAu3EzqQLkGcTQPjrIWJS2kCL0TxDoh25Yg9NXx2KG8XfmrjkWSIZ2hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7485
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ0xFTUVO
VCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj5TdWJq
ZWN0OiBSZTogW1BBVENIIHYxIDA0LzE1XSBpbnRlbF9pb21tdTogSW50cm9kdWNlIGEgbmV3IHN0
cnVjdHVyZQ0KPlZUREhvc3RJT01NVURldmljZQ0KPg0KPkhpLA0KPg0KPk9uIDA2LzA2LzIwMjUg
MTI6MDQgcG0sIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1h
aWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcw0K
PmVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUuDQo+Pg0KPj4NCj4+IEludHJvZHVjZSBhIG5ldyBzdHJ1Y3R1cmUgVlRESG9zdElP
TU1VRGV2aWNlIHdoaWNoIHJlcGxhY2VzDQo+PiBIb3N0SU9NTVVEZXZpY2UgdG8gYmUgc3RvcmVk
IGluIGhhc2ggdGFibGUuDQo+Pg0KPj4gSXQgaW5jbHVkZXMgYSByZWZlcmVuY2UgdG8gSG9zdElP
TU1VRGV2aWNlIGFuZCBJbnRlbElPTU1VU3RhdGUsDQo+PiBhbHNvIGluY2x1ZGVzIEJERiBpbmZv
cm1hdGlvbiB3aGljaCB3aWxsIGJlIHVzZWQgaW4gZnV0dXJlDQo+PiBwYXRjaGVzLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+
DQo+PiAtLS0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDcgKysrKysr
Kw0KPj4gICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAgfCAgMiArLQ0KPj4gICBody9p
Mzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAxNCArKysrKysrKysrKystLQ0KPj4gICAzIGZp
bGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxf
aW9tbXVfaW50ZXJuYWwuaA0KPj4gaW5kZXggMmNkYTc0NDc4Ni4uMThiYzIyZmM3MiAxMDA2NDQN
Cj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gKysrIGIvaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiBAQCAtMjgsNiArMjgsNyBAQA0KPj4gICAjaWZu
ZGVmIEhXX0kzODZfSU5URUxfSU9NTVVfSU5URVJOQUxfSA0KPj4gICAjZGVmaW5lIEhXX0kzODZf
SU5URUxfSU9NTVVfSU5URVJOQUxfSA0KPj4gICAjaW5jbHVkZSAiaHcvaTM4Ni9pbnRlbF9pb21t
dS5oIg0KPj4gKyNpbmNsdWRlICJzeXN0ZW0vaG9zdF9pb21tdV9kZXZpY2UuaCINCj4+DQo+PiAg
IC8qDQo+PiAgICAqIEludGVsIElPTU1VIHJlZ2lzdGVyIHNwZWNpZmljYXRpb24NCj4+IEBAIC02
MDgsNCArNjA5LDEwIEBAIHR5cGVkZWYgc3RydWN0IFZURFJvb3RFbnRyeSBWVERSb290RW50cnk7
DQo+PiAgIC8qIEJpdHMgdG8gZGVjaWRlIHRoZSBvZmZzZXQgZm9yIGVhY2ggbGV2ZWwgKi8NCj4+
ICAgI2RlZmluZSBWVERfTEVWRUxfQklUUyAgICAgICAgICAgOQ0KPj4NCj4+ICt0eXBlZGVmIHN0
cnVjdCBWVERIb3N0SU9NTVVEZXZpY2Ugew0KPj4gKyAgICBJbnRlbElPTU1VU3RhdGUgKmlvbW11
X3N0YXRlOw0KPj4gKyAgICBQQ0lCdXMgKmJ1czsNCj4+ICsgICAgdWludDhfdCBkZXZmbjsNCj4+
ICsgICAgSG9zdElPTU1VRGV2aWNlICpoaW9kOw0KPj4gK30gVlRESG9zdElPTU1VRGV2aWNlOw0K
Pj4gICAjZW5kaWYNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUu
aCBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBpbmRleCBlOTU0NzdlODU1Li41
MGY5YjI3YTQ1IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgN
Cj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBAQCAtMjk1LDcgKzI5
NSw3IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPj4gICAgICAgLyogbGlzdCBvZiByZWdp
c3RlcmVkIG5vdGlmaWVycyAqLw0KPj4gICAgICAgUUxJU1RfSEVBRCgsIFZUREFkZHJlc3NTcGFj
ZSkgdnRkX2FzX3dpdGhfbm90aWZpZXJzOw0KPj4NCj4+IC0gICAgR0hhc2hUYWJsZSAqdnRkX2hv
c3RfaW9tbXVfZGV2OyAgICAgICAgICAgICAvKiBIb3N0SU9NTVVEZXZpY2UgKi8NCj4+ICsgICAg
R0hhc2hUYWJsZSAqdnRkX2hvc3RfaW9tbXVfZGV2OyAgICAgICAgICAgICAvKiBWVERIb3N0SU9N
TVVEZXZpY2UgKi8NCj4+DQo+PiAgICAgICAvKiBpbnRlcnJ1cHQgcmVtYXBwaW5nICovDQo+PiAg
ICAgICBib29sIGludHJfZW5hYmxlZDsgICAgICAgICAgICAgIC8qIFdoZXRoZXIgZ3Vlc3QgZW5h
YmxlZCBJUiAqLw0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPj4gaW5kZXggYzQyZWY4M2RkYy4uNzk2YjcxNjA1YyAxMDA2NDQN
Cj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+PiBAQCAtMjgxLDcgKzI4MSwxMCBAQCBzdGF0aWMgZ2Jvb2xlYW4gdnRkX2hpb2Rf
ZXF1YWwoZ2NvbnN0cG9pbnRlciB2MSwNCj5nY29uc3Rwb2ludGVyIHYyKQ0KPj4NCj4+ICAgc3Rh
dGljIHZvaWQgdnRkX2hpb2RfZGVzdHJveShncG9pbnRlciB2KQ0KPj4gICB7DQo+PiAtICAgIG9i
amVjdF91bnJlZih2KTsNCj4+ICsgICAgVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGlvZCA9IHY7
DQo+PiArDQo+PiArICAgIG9iamVjdF91bnJlZih2dGRfaGlvZC0+aGlvZCk7DQo+PiArICAgIGdf
ZnJlZSh2dGRfaGlvZCk7DQo+PiAgIH0NCj4+DQo+PiAgIHN0YXRpYyBnYm9vbGVhbiB2dGRfaGFz
aF9yZW1vdmVfYnlfZG9tYWluKGdwb2ludGVyIGtleSwgZ3BvaW50ZXIgdmFsdWUsDQo+PiBAQCAt
NDM5Nyw2ICs0NDAwLDcgQEAgc3RhdGljIGJvb2wgdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBD
SUJ1cyAqYnVzLA0KPnZvaWQgKm9wYXF1ZSwgaW50IGRldmZuLA0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgSG9zdElPTU1VRGV2aWNlICpoaW9kLCBFcnJvciAqKmVy
cnApDQo+PiAgIHsNCj4+ICAgICAgIEludGVsSU9NTVVTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4+ICsg
ICAgVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGlvZDsNCj4+ICAgICAgIHN0cnVjdCB2dGRfYXNf
a2V5IGtleSA9IHsNCj4+ICAgICAgICAgICAuYnVzID0gYnVzLA0KPj4gICAgICAgICAgIC5kZXZm
biA9IGRldmZuLA0KPj4gQEAgLTQ0MTMsNiArNDQxNywxMiBAQCBzdGF0aWMgYm9vbCB2dGRfZGV2
X3NldF9pb21tdV9kZXZpY2UoUENJQnVzICpidXMsDQo+dm9pZCAqb3BhcXVlLCBpbnQgZGV2Zm4s
DQo+PiAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gICAgICAgfQ0KPj4NCj4+ICsgICAgdnRk
X2hpb2QgPSBnX21hbGxvYzAoc2l6ZW9mKFZUREhvc3RJT01NVURldmljZSkpOw0KPj4gKyAgICB2
dGRfaGlvZC0+YnVzID0gYnVzOw0KPj4gKyAgICB2dGRfaGlvZC0+ZGV2Zm4gPSAodWludDhfdClk
ZXZmbjsNCj4+ICsgICAgdnRkX2hpb2QtPmlvbW11X3N0YXRlID0gczsNCj4+ICsgICAgdnRkX2hp
b2QtPmhpb2QgPSBoaW9kOw0KPj4gKw0KPj4gICAgICAgaWYgKCF2dGRfY2hlY2tfaGlvZChzLCBo
aW9kLCBlcnJwKSkgew0KPg0KPlNob3VsZG4ndCB3ZSBmcmVlIHZ0ZF9oaW9kIGhlcmU/DQoNCkdv
b2QgY2F0Y2gsIFRoYW5rcy4NCkkgcHV0IGdfZnJlZSBpbiBwYXRjaDEwLCBidXQgaXQgc2hvdWxk
IGJlIGluIHRoaXMgcGF0Y2gsIHdpbGwgZml4Lg0KDQpCUnMsDQpaaGVuemhvbmcNCg0K

