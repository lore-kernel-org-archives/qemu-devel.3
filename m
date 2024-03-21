Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8B0C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 01:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn7NL-0001vx-Vi; Wed, 20 Mar 2024 21:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rn7NJ-0001vp-Vd
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 21:37:45 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rn7NH-0003JD-Fl
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 21:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710985064; x=1742521064;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vwEIMYevTBE7E5jgl3itFQ83tMgutpBAkUCx3AsS/Bw=;
 b=GpDoqGb4VE4A6pW5J2MfnAN2q1aSZcaM3LJ1JRn/8u8IF/I8o/cwoJHf
 beacEViPZaq+MDmBGIMoPtNQUXSM37Wp1whgctMa/KOF9pR8fdxRglsrc
 nujO4RzrShKLHzWxS6FLGkSuu7NwSIxDRKewOMF1OObMMVaUmPLLVt8Tl
 ojqZ3GIHXXfKeC4S62YJMcrjy1eUlE6jJ5fmPypDf4KXFIwXZukChqzsj
 yxt6jJut3SUBFX2uJQP+X+6DfbcISt6n9dPVm+rOc/AbblVRLYedst/xo
 yRI+pcn5fHa1xUgcDALNHdfikvc9Csx8cgh3Cert+nqZWsL3IDy1VpAMd w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6066210"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="6066210"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 18:37:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; d="scan'208";a="14738692"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Mar 2024 18:37:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 18:37:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 18:37:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 18:37:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 18:37:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ba0sfugd86D+TTTDEp5t15vaCvVA8DXKjKxbiyNrnlGMq86reyHS9I0PdvAWpz4MaxIwMBsheUU6WQfq7ZVgFwhvMi3b+/dBi36E0r8GLzU4NiyzZPHkmHWppEkApFWCqTTzD9WjZZtwoo0kA00b/zM+aAGkbLOoEiHh7KVzIOziZRLz9mjocrhWb6GyV8VVssT77Nlfzkq2CPm4/lYGLHXI8hhA4RWxDdAZt5jLdhvixbbKJZibl8luS/kKQKfkqMM0OFE0YyzLP75zccCkkksv5Hk1JLWhck8dy0eqDBO+wa01WNYdLTOsoi1MebEnVHmqqpx+9ShNRbCEEuZaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwEIMYevTBE7E5jgl3itFQ83tMgutpBAkUCx3AsS/Bw=;
 b=YE/fYfY9D9SazyxLkanZelvZug4hcapdms8KBL2dGhhHYAye6+jFbS3Wb6AwfqU3zAtrEsjNPJ4V88VshrkINOTNsmF/E+9Ryex8Wj2kc7ENuuHG73n2lRmB5iYVJh20iKVdRMR6Oza1eRdjghBGEfM8gCi2O/ft77IdcWNm+jhvmRqlJImvJkWJUpL+dLh6oaJ3GrBFQ+e9MXA/6ya0OPd9tRaEulDpNtPQhw06rtHGior8NClDiKBM+ArcjWYc17NyLHi4C9zxNtOh7FixMvzCWaGWCltUj/wiuo1WU+lMw0immOsuuQt5/SSe0qHmw/hMRu7neNdNdd88KTy6rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by DS0PR11MB8161.namprd11.prod.outlook.com (2603:10b6:8:164::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Thu, 21 Mar
 2024 01:37:36 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Thu, 21 Mar 2024
 01:37:36 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>, 
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v5 5/7] migration/multifd: implement initialization of qpl
 compression
Thread-Topic: [PATCH v5 5/7] migration/multifd: implement initialization of
 qpl compression
Thread-Index: AQHaeqFFcriI4s02jkWbmxh5d6Bh27FAcVgAgABDk6CAAA4OAIAACKEggABKaQCAAFH34A==
Date: Thu, 21 Mar 2024 01:37:36 +0000
Message-ID: <PH7PR11MB5941186DCF12ED13130CBF5FA3322@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-6-yuan1.liu@intel.com> <Zfq9lBXZWcy3Alhw@redhat.com>
 <PH7PR11MB59410E02C6C7CECD7E30AA4FA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfsCDhnYYmjxLTRW@x1n>
 <PH7PR11MB5941F8AE52DBD0F197798103A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZftHtgpxOPNA8AYE@x1n>
In-Reply-To: <ZftHtgpxOPNA8AYE@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|DS0PR11MB8161:EE_
x-ms-office365-filtering-correlation-id: 5c4c8178-ac9f-44f8-5131-08dc49477ce3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hhHf+7IfBmIvat2H+cvUxz03S3fazbbfO0fQx6k+1RD/n36J/U+E+Q0u+8cU83jP+LOr0nepdZ601YHCiGDmoOSeJi9gBPWhxQqiSvocahoFh3slHvaAPnpCjtO6Ru2RUP9PLMEjVdBxeAdPOLVkd9Alv4pRcZxvhiUU85271Neai6v0MdHxyQzP64c8Xlfb/I2KQWcM2YGN5RdDXuRuvobVgslehlWZt99XNfbxalgits6X5QiJ8GKvsUO3ZJyc2OsdG/amWgRtSX/7iY/CDz0QKj+z59Bah3oLS1m7W5NCkxqp7SPFKRePyR2LykyNaZxWfqXmGdVUP1TCndoIC99doJ04jjE1v4SxxUCBEcKK7oGGnzYJ2spUgMBGGdSYrex7WcsfINktCla3eg9IwaZ6STk9m2B5z/Jsst4o1Pcv+z0XVUycD+xCvXCLRKpf5yEbVEPWkrIXIDOZkamT02y0V0r8ccGv9Rp9ka27vsORq5EDAUTX897DSXJtuU9JIhbd1dtiiMGEAKekiqjHxy9M9sB4vMlLaK/ZtQ4QsQI8mVVhRLhndHkPGdZgqon511rhGMx/EPXn44EfX+OLIPZ/reKkAPTHmfdrNHVVPG7FX2u+aylUDWjft/lO6QrVE/LlZKYzJJw5J8oTQbfIA5lBGke45NTaAyFvGHA57P085CGZ4B94SaY4++126OMhxxi+oY2vWAMehQgVFxfYgtWiBCaO0H2ZgGl7fkjBr1M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0JMRHlBMHB5S1RuRkk0RndwUk1QYzRsVEJXbW1ocnQ2WjNFd0dFTTd3dVhu?=
 =?utf-8?B?RzlBMER0YVZNZW8yN25QNmJjUnM3YkpMOVZDVjZ5eXcydVdtR2Rqb0ZaR3JU?=
 =?utf-8?B?aEtVektLVktPRXYzYk1FajFiREc0V1VpQmlaS3lMSGNxcXdhd0N2ckdzNFhJ?=
 =?utf-8?B?MkU0Y1Z2WlRXSzFkMFJnR1hnSnVteTlMemx0VG0xMDVRV2ptYWZseUd2azFz?=
 =?utf-8?B?S3AyWUZYRlZtNDlmazgxRlFieE5GcWZiUC9tQTBYYXVnRSsySGhrR003aDlI?=
 =?utf-8?B?L3lWdWxybUVyZUNPSFpGbC9ENmRHMmtOc0hHY1VBUGl5ZGZvZjZvUFNlWDVj?=
 =?utf-8?B?VHRzcGtMdm0yWDMydE14cGU1WWhMa1kxRW85WW9SZkxrbmRwVlVyM3ROL1RU?=
 =?utf-8?B?OHZmNmZvVkpqVHkrS29raDNYNldzeUNncEtVcWs2RzN6YVBDZlM5cEZsMVB1?=
 =?utf-8?B?ZXBUR1RubUgvYWY3cTkyY0pGaDhGOE8zSEYxZjNyTGJ4aFIrUXBmWnJnLzZi?=
 =?utf-8?B?bDNwYi9ES2FQcFF4V2JTbUI2RjdBT2xWNVR3aU1GcG5pcFAvc3Vtc3Q0NFha?=
 =?utf-8?B?RytnRldlc3FqWG00YWR1SjNWZXVmZ1dCQVMrWWMxTUhpR0o2dDhldTR0MGJ2?=
 =?utf-8?B?TU9QaFhlQmRoZC9OTmZRa0ZWZ211amNlakFEMFliSTIycFhLTDlUQ1grN1Fx?=
 =?utf-8?B?TWVBL3dGRUpSNFBSUVY5Z3Y5NDd0VVhlRnRkNzN0diszbytCMmFIaDYzTEw3?=
 =?utf-8?B?eU1SdHcvZEdYWithMVZoRzk4QkNjNzJOUlhRMzFXUm9FQUl0OE94dk80LzJK?=
 =?utf-8?B?VVQ0SHN2dWVwWTdLM1lCRGRLS3JLaEhMeWhmS3pxTE5VanRMOU1kVUpab0VE?=
 =?utf-8?B?YkF1bWZoNkJ5MEdKR2R0N0hWSGkwazJGMzRUZzZSOE03Y3FIM1NHVUlKZXdM?=
 =?utf-8?B?OVFRRWs1N1lSM0NxWVdMWlpjMTY1KzZOWFFhWkVEM2ZRdjdSN3pHUzJ0SjJ4?=
 =?utf-8?B?MGMxcHJjNGs5NFdzTzhhWnkxZGpvVXppcVFSMkY1Q3k3UWJXSndDOTdCMS9F?=
 =?utf-8?B?UWtwMkNVTHR5YzVSWjBaU203SlVsa0g4Zkhybm1EKzJUelNvbUVVMEJrS0FM?=
 =?utf-8?B?NlFwc1JBSis1aGViWE1XWGpuZkVKRk1iSU1qRE1ySnFHbGRhQVB2SHBaYkJ4?=
 =?utf-8?B?U3RYQ01RRkZoWWtKTGpEcWRFWExJa3h6aVhQZkxyQ0xycFFFazZ4R0tTZFpo?=
 =?utf-8?B?Q0FTREd1UmhqUXRMU1NxOVFBbklSNXNpVEhOZml4T3ptY1pRdEltb2syYktu?=
 =?utf-8?B?Wk9VTUtmT0F4d3k5TEJZUDVxVGF6RTNXbGhVWnMybWhVVHEyaXdYU2M4blV5?=
 =?utf-8?B?ZjdoN0pNU09iWWpTekNjRlBMZDFwMkJSQ0ZneVFBNmFhT1BwdW81LzhiSFJ5?=
 =?utf-8?B?cDlSUUQvYU12Zm9ET0t1SHBUeVlUUDBVbjFIVSsyTENFeWs3MHpEdUlKd3RI?=
 =?utf-8?B?cGUvdXlBZElDdmV4RDNsWG41N2NTVlNJR2RxM1cxOW9EbUdWVm96dTBzWWE1?=
 =?utf-8?B?QW82SHBlZVRKQ1FrS0dyUXVRTm1naVdVTFFFVlNKdERUWUUvSzcveWlrcXUz?=
 =?utf-8?B?SCs4Um5UM0NoZkRwWWJxN1BzeFoyUE9yNjhRbk00ckIvM0xlbTA5YUZYd2or?=
 =?utf-8?B?RlVHQ3FybUxrME1nY2dMWnJ1ajMxL2wybGZQb1JHdzNDRDhoOGJ2bkl3ZC9H?=
 =?utf-8?B?Zzdpa1prSitYd2tmME5VUE5sS1lSeHFDWWlaR0xPZWJHdTFQejN1cWR0dDF5?=
 =?utf-8?B?TUFhWW1BU0tSaTN4NVFLNFc0WnFGcGZ4a2RrSnhnbVpxbEU4K0I3aU1XWUtr?=
 =?utf-8?B?RFU0TEVjNTRCL0dMbjgrVHF2cm5FcDN1ZWduMXZFelJyV0tDazNlQ1J1WVds?=
 =?utf-8?B?RGRSYjhkTVNIeTNtclo5b0VWcFlMQU5XZEF5cjB4WGhzR0F3TklMdE9sbXA0?=
 =?utf-8?B?c0F5aU1tanc4QW93SllMSU9NWGNOTmdSb3pMLzdsUHMzdlJtb1BLa3dOSmNz?=
 =?utf-8?B?SXp6OFd2bnNtU29uWmZCdU12dmcydWRhQjJGek5jQzFlV3I5TGFMN2pyQmtQ?=
 =?utf-8?Q?t6WsUd5dTatiVwHs1lnF6p/yQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4c8178-ac9f-44f8-5131-08dc49477ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 01:37:36.6030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFSvOHLG6M2JBDlzBm2QgboHLmf/L/s0aLisY/yGfPP3lwmpJkaa2z0CyIhhmEFkNZOe1u3vSZTy+/4whe/HIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8161
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyMSwgMjAyNCA0OjMyIEFNDQo+IFRv
OiBMaXUsIFl1YW4xIDx5dWFuMS5saXVAaW50ZWwuY29tPg0KPiBDYzogRGFuaWVsIFAuIEJlcnJh
bmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT47IGZhcm9zYXNAc3VzZS5kZTsgcWVtdS0NCj4gZGV2
ZWxAbm9uZ251Lm9yZzsgaGFvLnhpYW5nQGJ5dGVkYW5jZS5jb207IGJyeWFuLnpoYW5nQGJ5dGVk
YW5jZS5jb207IFpvdSwNCj4gTmFuaGFpIDxuYW5oYWkuem91QGludGVsLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NSA1LzddIG1pZ3JhdGlvbi9tdWx0aWZkOiBpbXBsZW1lbnQgaW5pdGlh
bGl6YXRpb24gb2YNCj4gcXBsIGNvbXByZXNzaW9uDQo+IA0KPiBPbiBXZWQsIE1hciAyMCwgMjAy
NCBhdCAwNDoyMzowMVBNICswMDAwLCBMaXUsIFl1YW4xIHdyb3RlOg0KPiA+IGxldCBtZSBleHBs
YWluIGhlcmUsIGR1cmluZyB0aGUgZGVjb21wcmVzc2lvbiBvcGVyYXRpb24gb2YgSUFBLCB0aGUN
Cj4gPiBkZWNvbXByZXNzZWQgZGF0YSBjYW4gYmUgZGlyZWN0bHkgb3V0cHV0IHRvIHRoZSB2aXJ0
dWFsIGFkZHJlc3Mgb2YgdGhlDQo+ID4gZ3Vlc3QgbWVtb3J5IGJ5IElBQSBoYXJkd2FyZS4gIEl0
IGNhbiBhdm9pZCBjb3B5aW5nIHRoZSBkZWNvbXByZXNzZWQNCj4gZGF0YQ0KPiA+IHRvIGd1ZXN0
IG1lbW9yeSBieSBDUFUuDQo+IA0KPiBJIHNlZS4NCj4gDQo+ID4gV2l0aG91dCAtbWVtLXByZWFs
bG9jLCBhbGwgdGhlIGd1ZXN0IG1lbW9yeSBpcyBub3QgcG9wdWxhdGVkLCBhbmQgSUFBDQo+ID4g
aGFyZHdhcmUgbmVlZHMgdG8gdHJpZ2dlciBJL08gcGFnZSBmYXVsdCBmaXJzdCBhbmQgdGhlbiBv
dXRwdXQgdGhlDQo+ID4gZGVjb21wcmVzc2VkIGRhdGEgdG8gdGhlIGd1ZXN0IG1lbW9yeSByZWdp
b24uICBCZXNpZGVzIHRoYXQsIENQVSBwYWdlDQo+ID4gZmF1bHRzIHdpbGwgYWxzbyB0cmlnZ2Vy
IElPVExCIGZsdXNoIG9wZXJhdGlvbiB3aGVuIElBQSBkZXZpY2VzIHVzZSBTVk0uDQo+IA0KPiBP
aCBzbyB0aGUgSUFBIGhhcmR3YXJlIGFscmVhZHkgY2FuIHVzZSBDUFUgcGd0YWJsZXM/ICBOaWNl
Li4NCj4gDQo+IFdoeSBJT1RMQiBmbHVzaCBpcyBuZWVkZWQ/ICBBRkFJVSB3ZSdyZSBvbmx5IGlu
c3RhbGxpbmcgbmV3IHBhZ2VzLCB0aGUNCj4gcmVxdWVzdCBjYW4gZWl0aGVyIGNvbWUgZnJvbSBh
IENQVSBhY2Nlc3Mgb3IgYSBETUEuICBJbiBhbGwgY2FzZXMgdGhlcmUNCj4gc2hvdWxkIGhhdmUg
bm8gdGVhcmluZyBkb3duIG9mIGFuIG9sZCBwYWdlLiAgSXNuJ3QgYW4gaW90bGIgZmx1c2ggb25s
eQ0KPiBuZWVkZWQgaWYgYSB0ZWFyIGRvd24gaGFwcGVucz8NCg0KQXMgZmFyIGFzIEkga25vdywg
SUFBIGhhcmR3YXJlIHVzZXMgU1ZNIHRlY2hub2xvZ3kgdG8gdXNlIHRoZSBDUFUncyBwYWdlIHRh
YmxlIA0KZm9yIGFkZHJlc3MgdHJhbnNsYXRpb24gKElPTU1VIHNjYWxhYmxlIG1vZGUgZGlyZWN0
bHkgYWNjZXNzZXMgdGhlIENQVSBwYWdlIHRhYmxlKS4NClRoZXJlZm9yZSwgd2hlbiB0aGUgQ1BV
IHBhZ2UgdGFibGUgY2hhbmdlcywgdGhlIGRldmljZSdzIEludmFsaWRhdGlvbiBvcGVyYXRpb24g
bmVlZHMNCnRvIGJlIHRyaWdnZXJlZCB0byB1cGRhdGUgdGhlIElPTU1VIGFuZCB0aGUgZGV2aWNl
J3MgY2FjaGUuIA0KDQpNeSBjdXJyZW50IGtlcm5lbCB2ZXJzaW9uIGlzIG1haW5saW5lIDYuMi4g
VGhlIGlzc3VlIEkgc2VlIGlzIGFzIGZvbGxvd3M6DQotLUhhbmRsZV9tbV9mYXVsdA0KIHwNCiAg
LS0gd3BfcGFnZV9jb3B5DQogICAgfA0KICAgIC0tIG1tdV9ub3RpZmllcl9pbnZhbGlkYXRlX3Jh
bmdlDQogICAgICB8DQogICAgICAtLSBpbnRlbF9pbnZhbGlkYXRlX3JhZ2UNCiAgICAgICAgfA0K
ICAgICAgICAtLSBxaV9mbHVzaF9waW90bGINCiAgICAgICAgLS0gcWlfZmx1c2hfZGV2X2lvdGxi
X3Bhc2lkDQoJIA0KDQo+ID4gRHVlIHRvIHRoZSBpbmFiaWxpdHkgdG8gcXVpY2tseSByZXNvbHZl
IGEgbGFyZ2UgbnVtYmVyIG9mIElPIHBhZ2UgZmF1bHRzDQo+ID4gYW5kIElPVExCIGZsdXNoZXMs
IHRoZSBkZWNvbXByZXNzaW9uIHRocm91Z2hwdXQgb2YgdGhlIElBQSBkZXZpY2Ugd2lsbA0KPiA+
IGRlY3JlYXNlIHNpZ25pZmljYW50bHkuDQo+IA0KPiAtLQ0KPiBQZXRlciBYdQ0KDQo=

