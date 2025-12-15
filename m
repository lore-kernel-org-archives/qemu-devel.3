Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF718D41D74
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 09:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV4YB-0003zz-Kh; Mon, 15 Dec 2025 04:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV4Y9-0003zY-Mn
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 04:07:25 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV4Y6-0004xF-Ft
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 04:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765789642; x=1797325642;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eIds8uvll/Acu0uB1n3bxd2aUKLFte8cFDAOBONunKU=;
 b=AOAt/zgAeseMDKXGVoTEC5zpgDJiLUV2LiWRetboxB4A8iFzbCBKlsAX
 MVw/6FaqB2KhmG2MTc7/U6ruJK/vFmhghN4VryFqy74AtDJnx5cP+vXwk
 aSOEnSUhLU0T8yG3GF8gsWuRPuIFzb1ME2ndjzgBxozt+Mn7WqyhNCFLt
 VaVKP1oZsjhglRzzPLJl8vBlh1ix3EG3WifxIQLPvCY0z6GY4mEAT/Pv4
 BhZLDvR9oMwQjRcNkcwJgeUryCikSLX2KOudCxoteKp4pNAXJHNGKE0Xz
 RiNmNpI08H3fG6sJG6HJMkbwx5J/H7t2BpT4wDZqK8l39B5hjGEzrbIXP g==;
X-CSE-ConnectionGUID: Dm+82D07TaG0yGhq0eBtlQ==
X-CSE-MsgGUID: oqFyhDcASFaxez1AL3zpsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="78392422"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="78392422"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 01:07:19 -0800
X-CSE-ConnectionGUID: APNvkVJvRUirwcMifcVCjA==
X-CSE-MsgGUID: iou1fn8PT2aOqJu22Pk2yg==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 01:07:19 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 01:07:19 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 15 Dec 2025 01:07:19 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Dec 2025 01:07:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErfinERQQD2I6o4rKkXuwzhgLAOfMZ7m2hmBcQs+9GyTB/LhCZk9ETNDi/4U9AJbZzslZyj3PzCrC4r6WtptYqA9Pd7nWaOy3cJPkmNgMn4AHHtJbt5tYsiWb/McyUv1PfwNt6Kl85EFzt5T/XGvCpVY+3uwyXhTO/bOuDAQfgSRiuX0YBg2N0TwOVvLEnPSDWuCGsd8AA9lFGb97oUl/1i3OttpQIBAVFvY4POckwNVhStBljowm4v+GQ6NPC39xrrTDjYqZVESzgqfgVRL/lgy/N//0Uyi07D3jhwCJKVovS9KPmglnnJ+awoHzOF/LSt0e84LaOP31N7kY9wKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIds8uvll/Acu0uB1n3bxd2aUKLFte8cFDAOBONunKU=;
 b=P0teFykwQz4HXLUbmpuuk+R7XEENXKUIIPGcS2y8LdD04V37GoomFhAIHeCP01DZlJ/xjlMQmtaAsivuNnTR+70qwnUE30E7dBM6P/nMg2z423ZVOWGGVKqWIFONcp956D36NGsMmLCsOKt5qo9uE/xOPFJAWAKgmJBFfsrTNiwoK2ckuw+yBLPwbTbW8OXZoiW1VtK7oQ+ELeqkAndENIA/L0Ntrnrp+5gSofVOjkYpG4gA3+iVoCMxdeq4v9jOQS3FljkzX0ih07pYtgJZGDCMSX6PHhI2AtJj5Rrb8OAKS1qbymAcDfaHtyobCqJGWIBMIXnvHmYBTm0Do/z/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS7PR11MB7907.namprd11.prod.outlook.com (2603:10b6:8:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 09:07:16 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 09:07:16 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v8 02/23] intel_iommu: Delete RPS capability related
 supporting code
Thread-Topic: [PATCH v8 02/23] intel_iommu: Delete RPS capability related
 supporting code
Thread-Index: AQHcV6X7qwJIBON1NEWq9tp1RQ6GhLUcP2UAgAAtIACABg5GgIAAFj5Q
Date: Mon, 15 Dec 2025 09:07:16 +0000
Message-ID: <IA3PR11MB913615CFBC12A24FEB3B580F92ADA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-3-zhenzhong.duan@intel.com>
 <CACGkMEtK_KiT+PCvxi2NUQ-gX0ekV3RtZ6E5T7oZSeiOqkSSkw@mail.gmail.com>
 <4618ef6c-9f54-45bf-a95c-5f813f9a2365@intel.com>
 <CACGkMEuBNf6wRPOrprbUDBUnWVieaKEXMRhpJhFhTszznsCTHA@mail.gmail.com>
In-Reply-To: <CACGkMEuBNf6wRPOrprbUDBUnWVieaKEXMRhpJhFhTszznsCTHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS7PR11MB7907:EE_
x-ms-office365-filtering-correlation-id: 96cd1fa0-bd31-4d0b-7316-08de3bb9580c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?UnNpNk5remJzb21KRHRDeGFCWGxZbGl2cjdtcXRvRGd1QjRYTE1ZUlNoK29W?=
 =?utf-8?B?ZE9lUzFSNVNTV2IzZXFGRFVKNHZVVU5BbE92RGJmYlJPRWh1VlZTSC9XVyt3?=
 =?utf-8?B?WDduY2tlblVxL0JFeWF1K0w2eFQ4cW44R1pzZWdZaytHMm8rZitsTWxRcWRq?=
 =?utf-8?B?U29mNTR0QmU3aDQ4K1dXeUhFTmRlL1BxL3lJRWZiSWJrY1V4Y1ZPb1B4RmQ1?=
 =?utf-8?B?b1Jpb1hmbXFqQVNxejFTaWJaQzFUd0FRajBBQkJKcnVNbzdrNUpZSzFtR1By?=
 =?utf-8?B?ZGhsVzlRc1VnRUtQNWNZWk9OLzFyTkY2ekpKejBmWU55ZjVBOVJmRTFjSlNL?=
 =?utf-8?B?UlVhajkrV1oxck8xL2tldTJUbTlZSXhvWUFGZjFCbm1XdUR0VC9uQ2huVGha?=
 =?utf-8?B?VTFsVm5LaGVKZy9OVnRHS1NQWkFzdmlPNExuNUdmWTRybnY5eWU3L1pzUDBL?=
 =?utf-8?B?dDd0Z2NaS05xUXRrZDc2cHZxV0pPRFJyWlJscUtqMWF1dm12STdHOElZbTRn?=
 =?utf-8?B?YWlPWno2akVmRHo3VkFtbmx3cThlZXVuR0EzSFRLTzExc0ZSanYxbE1GbG5s?=
 =?utf-8?B?eHBxcWRUYUFORjl1eUUxdSttaHN1UjZ6akdZM1NnOTZhN3hZcGFmbC90OHhR?=
 =?utf-8?B?UkZYcW5GN3U2VythdmNjQnpmTE0zUnBMdGE2d0ZoUnloU1V2SWV4L25EdFFJ?=
 =?utf-8?B?VjFEVkVVQmgrQ09kQndMYm9jeUd6blZZY1ZKeDltUWtRSllGdFBGNzBtcG1P?=
 =?utf-8?B?SDdDZEJVY0s1RHNBVm9CcnBnK3IrYUdRSXhJVm82bExFSVRYVnFrSWQxL3FW?=
 =?utf-8?B?bFVyaEVscHhlL0NIYzhwSmpJVjkrZHRhazhGNy92MWt5SktKTVEwK0h1MHQy?=
 =?utf-8?B?MlBxTjZkS3J2ampHZ3JYcTFDRUJaMmh1dzdzSFV0SnM4RWo4UWNlVFdLUFE0?=
 =?utf-8?B?RFk3dll3UW9iekdvMStsc1ROYWNONFJVWXp5c09mVkFWbWdMTC9YY1RPZ1Zl?=
 =?utf-8?B?a2tIV2IyZUYyV2NXcDkrRXpscCtMVkdPTXk2Y3VsaEtiNjFER0tjcDNkSTVU?=
 =?utf-8?B?bGVqOUxmWVVka056Y2xZeU5OTER4Zm5Uc2xNOVk5a2Z2aXdiRlhxWHAwQzU0?=
 =?utf-8?B?elppSHhNbktmTnhtWUtUU1pmeHNaVjNGNzZsdjNhZ3c3L2VJQjRTU2o0RHda?=
 =?utf-8?B?MkNMczNsa2NXMUs5a0pnMjM0L3o2N09pVjdQSHFKTjJSRVBoSHJRSXd6MS9y?=
 =?utf-8?B?WktXNkdOUFRGOXVwMzVKQWJJV0tRVjRqQjFDMVBHVHE1TG9WTVBScFBvMlQ4?=
 =?utf-8?B?VWxjSnF1cWc5NkRnTUdqVDgxTFFybFp6UWdmYkdUeWx3VnFWZ3NIcUVkekto?=
 =?utf-8?B?amd1eldhT0Q4UUwzdzRqRmY2VHpPSExsT3JQaUNHaXFPdmlOQmRXOS9lT1Y4?=
 =?utf-8?B?ai9MeDdXTnJ1OElkWkphMjkvaXNqeENyNjJ2VmwzSnZnZmVTc0l5Y2p1SWRV?=
 =?utf-8?B?TnhJSDU2OHVsa3R1L3B2RjVWdFBQRytvQ2kxOXZKVU8zMUFSbSttanQzejZG?=
 =?utf-8?B?d1FmZzBwb1owZFowZW44UnVGYmMvYnNIWEt1a0F5L2IycmVBWGJtRUJFNlhY?=
 =?utf-8?B?c01MZks4V0ZnbEJQS3BoU2V2bS9lMEZGUFpTM1B6TUVSYXpibXJCZXlRMW0y?=
 =?utf-8?B?NEJ0WFg2by9PUnRHTFBYcE5oaDBzQ2ZpVTA2Tjl4cWFodXRsM2lvaDg3NHlp?=
 =?utf-8?B?RUY0bEtxU2xGQ01vdEt4UURuLzV4bjRJclZKTkRpYllpRWJYRDdFTk0wK3p2?=
 =?utf-8?B?VWlzWEJYTUphSys0ODVLOURnWjBybXlqbHpFK2l2NWM2cGl3WEpMR2xoL0xi?=
 =?utf-8?B?cGdNeElUVVhwMlZOT3VHNjh4aEVmeWNjOXgyMkRVY3JCZ1JyYlR6b1kreHBo?=
 =?utf-8?B?dnpUU3ZvMURFZnBhNkdtUEdkQ0EyVGxvZ2pBL013VWhtZVkxa29lMFcyMzZp?=
 =?utf-8?B?L2MyTU5pTWo1SUVlcWt6bi92UEZvS0hLVWgrTjF0bTBOOGV4cCtxT3A0b01P?=
 =?utf-8?Q?8FInMc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTdPWUpCak94NlBndkZDM0NmYmRrdktueE1xcWZFTk0rMlV1b2FPQWF2WlhF?=
 =?utf-8?B?RGRQT1VLYXo4R0JmNnlXd1dwanVXb3NtTmtVRDJTbU5XU1lCUjhhYmI5YXEv?=
 =?utf-8?B?cnlHWHZoM2h0eXFHa0RZdjBna0NWaXBONkJFWXk2OC9FSVArcTU2MnpiY1JP?=
 =?utf-8?B?SEZLMit0VGFlTkU5UEd0bTQ5cDVzc2FNT21iTUlXSnJqWmI5b0VmM0d0QXl3?=
 =?utf-8?B?allCSkRQY3VMSkFBT3hmbFV1WnB4VUl6V0JZR0VKTFRZMlB5QmY1MExOT2dZ?=
 =?utf-8?B?RDMrY2p1N2hrU050NkQvMmlNLzlXN3pFYklzczl5Q2k2bldZMjk4MHlTWnhT?=
 =?utf-8?B?NUNNVWxEVTY4SFcxdm1qRG0vWGpMUi9Wd3UwQmw0WjBPSlUxa1dCRzQxL25V?=
 =?utf-8?B?bVJ3VzVTQVg3UHFnYlZudlhIRG05QXRMSHBsdWdtcmQ4SkZQMGVKWDNKVTln?=
 =?utf-8?B?c3kwZDIzNm53d0xGS0pHekZLTlBSNkxlUGV1WUpiK0tWMXNhbTBWTWRiODZF?=
 =?utf-8?B?Y0ZrSzBJcU0yVjhtc2FiUlZ1RGZBY3BPSURJQWtmUk91RThoNEN1MEtpa3dj?=
 =?utf-8?B?THZrdUhaOXVNOFNTamdSVVpuZnNkM2hDdWdmUmJzTXQ3UWVUa096OFR1Vyta?=
 =?utf-8?B?T1NNQ0ErK0VaOTBwYXJQbWhic3hMWS9uWDZPeTJISkFIS0ZHV0xBR2hRNEJr?=
 =?utf-8?B?Q3JCY1U5ZmlmQjNVSEc4QkZzYnA3clpnQ0JuWGZ6b1NXR3RhejB3MnlWSDRO?=
 =?utf-8?B?bDhIV01aSy94azBHcnN0THptVE1oclB6Z2t0eVlEa0hXc3pZeGJORER1dHhN?=
 =?utf-8?B?SVpiR0Z6Y3FHZmNaaTFwaExzM1ZpR2Zvd3E5bHExbzkxNVlyWGdZWmNPZmtF?=
 =?utf-8?B?S3ZQdEFrV2tTR01wVTlmTTNwbEJDRldLT3JWWm5mWWROV0g0Z1NIRXV1QXdh?=
 =?utf-8?B?SXZoc3NMRk1PNkpDOEtYcS9oYi9vYW51dTBQY1Qwd2d1ZGRUQU5rRlRVdXNO?=
 =?utf-8?B?MTgvQ1F4anRGVXYvako3aHVsOXBTbEdCYjF1dkZsM3FFK2lTei90eFNRSGc4?=
 =?utf-8?B?cnZ5aEtLRCtMRGNGblArUS8yVEtQelgxRkFBcTBYTjQwZHVXeVZiVVgwU3U1?=
 =?utf-8?B?bkw2TzA1aGUrbk9PZGxjWVpDQ2tORU5kcEpDdno0a1NNTmNWRUhtSlcrdkEy?=
 =?utf-8?B?Wk93N3lkTUZzNjFhK3lhaDJzNkJhclA3cWxVY0dJQWxSamltdEw4ZE9ka280?=
 =?utf-8?B?akdycGxxb1AwUWNETFFRM0pNMlJKbEZkVGdLZzJic3ZydjliZUVWS01ha0ha?=
 =?utf-8?B?RnZvclFGa2ZUd3kxa25NTUJwRGVDRUsvTTZhZE5yZkgyUmpMTVh4UzVmNE1L?=
 =?utf-8?B?WWxHWFFjM0ZmTDdZRWNybXZhQkR0QXo1QUJXMnlCeU1uYXM2RHNBaVNyV25F?=
 =?utf-8?B?QnNUcTZIcTlWNFd3TVBncGp4VWlHMFAyc204dVpWaC9DRXlUbWc5RVBGQ2xD?=
 =?utf-8?B?MjJBYnJ4L0JQWkdaT2F3SCsrdmoyNi93azlvNHNnN1dpa21Oa0x0RGt1VHEy?=
 =?utf-8?B?UkR2KzF5UDF5VHRaQ3MvVW9iamNyQXFuMlNHdldzWDRVQU5vMlV6N1YvMHF6?=
 =?utf-8?B?Zno3MzZKTndtZ3pjc3NEdHEyUUl0N1BWQWdXT3pFTXVlclVLbXV1clQ3enBi?=
 =?utf-8?B?K2dGYyszMEhNMWpGY3JmYi8vY0JDV2p3c2EyeXJubUZRZmQ5RnVMQzd1UGF2?=
 =?utf-8?B?d2ljS1l5UHZiYUZiZGszL21NUGorVmFIazF2WDF0UTU1QkZKRFpvd0RYYU5i?=
 =?utf-8?B?bHVyZCs0Qlp2aTY2amUzaWtXeDlTdGNBWklEcGNzUlhOdFFEaGh5YjVRTmJu?=
 =?utf-8?B?RE5aR0N2ZFd2WEVFd0J5NnJvekdUVnZFd2VIN1V1Z3VpSGozVUR1TDNTSWZT?=
 =?utf-8?B?Z0NKRTI4WHd5T1JLY3VPQ3ZJbmg0d21vYThINFZHRnNsenh4Y0pPN3VTNnVK?=
 =?utf-8?B?THQwVnlYdVEySlp6SXVNWVFPTFh0YTRmRFhvcU9JcEVZTHhLWjJlamhsVnpm?=
 =?utf-8?B?NkFKTW9ONTNCczBjTDM4MGhSczE5emI3MU8xZmFCWWRQWWJ2Um8yckw3VnBG?=
 =?utf-8?Q?ctw3wN80i2+w3Oojvz6yJ+Gde?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cd1fa0-bd31-4d0b-7316-08de3bb9580c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:07:16.4913 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXkbF1HZMq1888ITSE/LsJ08ptipKQt0ddCTa4x1QxoXyaJqZ8VZW3b3267UvXreko33rOg/zvAYjr+NVNrK7dVQgN+7QBqH2ueOzATTbaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7907
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2OCAwMi8yM10gaW50ZWxfaW9t
bXU6IERlbGV0ZSBSUFMgY2FwYWJpbGl0eSByZWxhdGVkDQo+c3VwcG9ydGluZyBjb2RlDQo+DQo+
T24gVGh1LCBEZWMgMTEsIDIwMjUgYXQgNjo1N+KAr1BNIFlpIExpdSA8eWkubC5saXVAaW50ZWwu
Y29tPiB3cm90ZToNCj4+DQo+PiBPbiAyMDI1LzEyLzExIDE2OjIyLCBKYXNvbiBXYW5nIHdyb3Rl
Og0KPj4gPiBPbiBNb24sIE5vdiAxNywgMjAyNSBhdCA1OjM44oCvUE0gWmhlbnpob25nIER1YW4N
Cj48emhlbnpob25nLmR1YW5AaW50ZWwuY29tPiB3cm90ZToNCj4+ID4+DQo+PiA+PiBSSUQtUEFT
SUQgU3VwcG9ydChSUFMpIGlzIG5vdCBzZXQgaW4gdklPTU1VIEVDQVAgcmVnaXN0ZXIsIHRoZQ0K
PnN1cHBvcnRpbmcNCj4+ID4+IGNvZGUgaXMgdGhlcmUgYnV0IG5ldmVyIHRha2VzIGVmZmVjdC4N
Cj4+ID4+DQo+PiA+PiBNZWFud2hpbGUsIGFjY29yZGluZyB0byBWVEQgc3BlYyBzZWN0aW9uIDMu
NC4zOg0KPj4gPj4gIkltcGxlbWVudGF0aW9ucyBub3Qgc3VwcG9ydGluZyBSSURfUEFTSUQgY2Fw
YWJpbGl0eSAoRUNBUF9SRUcuUlBTIGlzDQo+MGIpLA0KPj4gPj4gdXNlIGEgUEFTSUQgdmFsdWUg
b2YgMCB0byBwZXJmb3JtIGFkZHJlc3MgdHJhbnNsYXRpb24gZm9yIHJlcXVlc3RzDQo+d2l0aG91
dA0KPj4gPj4gUEFTSUQuIg0KPj4gPj4NCj4+ID4+IFdlIHNob3VsZCBkZWxldGUgdGhlIHN1cHBv
cnRpbmcgY29kZSB3aGljaCBmZXRjaGVzIFJJRF9QQVNJRCBmaWVsZA0KPmZyb20NCj4+ID4+IHNj
YWxhYmxlIGNvbnRleHQgZW50cnkgYW5kIHVzZSAwIGFzIFJJRF9QQVNJRCBkaXJlY3RseSwgYmVj
YXVzZQ0KPlJJRF9QQVNJRA0KPj4gPj4gZmllbGQgaXMgaWdub3JlZCBpZiBubyBSUFMgc3VwcG9y
dCBhY2NvcmRpbmcgdG8gc3BlYy4NCj4+ID4+DQo+PiA+PiBUaGlzIHNpbXBsaWZpZXMgdGhlIGNv
ZGUgYW5kIGRvZXNuJ3QgYnJpbmcgYW55IHBlbmFsdHkuDQo+PiA+Pg0KPj4gPj4gU3VnZ2VzdGVk
LWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+ID4+IFNpZ25lZC1vZmYtYnk6IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiA+PiAtLS0NCj4+ID4N
Cj4+ID4gSXMgdGhlIGZlYXR1cmUgZGVwcmVjYXRlZCBpbiB0aGUgc3BlYz8gSWYgbm90LCBpdCBz
aG91bGQgYmUgc3RpbGwNCj4+ID4gYmV0dGVyIHRvIGVuYWJsZSBpdC4NCj4+DQo+PiBIaSBKYXNv
biwNCj4+DQo+PiBUaGUgZmVhdHVyZSBpcyBzdGlsbCBpbiB0aGUgc3BlYy4gSG93ZXZlciwgdXNp
bmcgUEFTSUQjMCBmb3IgdGhlDQo+PiByZXF1ZXN0cyB3aXRob3V0IHBhc2lkIGlzIGFsaWduZWQg
YWNyb3NzIHZlbmRvcnMuIFNvIHRoZSBsaW51eCBpb21tdQ0KPj4gc3Vic3lzdGVtIHVzZXMgUEFT
SUQjMCB0byBkaWZmZXJlbnRpYXRlIHRoZSBwYXNpZCBwYXRoIGFuZCBub24tcGFzaWQNCj4+IHBh
dGggbGlrZSBiZWxvdzoNCj4+DQo+PiBjb21taXQgYmMwNmY3ZjY2ZGU0MDRhZTYzMjM5NjMzNjFm
ZTRlMmY1ZjcxYTFlNQ0KPj4gQXV0aG9yOiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+
IERhdGU6ICAgRnJpIE1hciAyMSAxMDoxOToyNiAyMDI1IC0wNzAwDQo+Pg0KPj4gICAgICBpb21t
dWZkL2RldmljZTogT25seSBhZGQgcmVzZXJ2ZWRfaW92YSBpbiBub24tcGFzaWQgcGF0aA0KPj4N
Cj4+ICAgICAgQXMgdGhlIHBhc2lkIGlzIHBhc3NlZCB0aHJvdWdoIHRoZSBhdHRhY2gvcmVwbGFj
ZS9kZXRhY2ggaGVscGVycywgaXQgaXMNCj4+ICAgICAgbmVjZXNzYXJ5IHRvIGVuc3VyZSBvbmx5
IHRoZSBub24tcGFzaWQgcGF0aCBhZGRzIHJlc2VydmVkX2lvdmEuDQo+Pg0KPj4gICAgICBMaW5r
Og0KPj4gaHR0cHM6Ly9wYXRjaC5tc2dpZC5saW5rL3IvMjAyNTAzMjExNzE5NDAuNzIxMy01LXlp
LmwubGl1QGludGVsLmNvbQ0KPj4gICAgICBSZXZpZXdlZC1ieTogSmFzb24gR3VudGhvcnBlIDxq
Z2dAbnZpZGlhLmNvbT4NCj4+ICAgICAgUmV2aWV3ZWQtYnk6IEtldmluIFRpYW4gPGtldmluLnRp
YW5AaW50ZWwuY29tPg0KPj4gICAgICBSZXZpZXdlZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGlu
Y0BudmlkaWEuY29tPg0KPj4gICAgICBSZXZpZXdlZC1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxp
bnV4LmludGVsLmNvbT4NCj4+ICAgICAgU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBp
bnRlbC5jb20+DQo+PiAgICAgIFRlc3RlZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0Budmlk
aWEuY29tPg0KPj4gICAgICBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBHdW50aG9ycGUgPGpnZ0Budmlk
aWEuY29tPg0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvbW11ZmQvZGV2aWNl
LmMNCj5iL2RyaXZlcnMvaW9tbXUvaW9tbXVmZC9kZXZpY2UuYw0KPj4gaW5kZXggNzA1MWZlZGEy
ZmFiLi40NjI1ZjA4NGY3ZDAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11ZmQv
ZGV2aWNlLmMNCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW9tbXVmZC9kZXZpY2UuYw0KPj4gQEAg
LTQ4Myw2ICs0ODMsNyBAQCBpbnQgaW9tbXVmZF9od19wYWdldGFibGVfYXR0YWNoKHN0cnVjdA0K
Pj4gaW9tbXVmZF9od19wYWdldGFibGUgKmh3cHQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgaW9tbXVmZF9kZXZpY2UgKmlkZXYsDQo+aW9hc2lkX3QNCj4+IHBh
c2lkKQ0KPj4gICB7DQo+PiAgICAgICAgICBzdHJ1Y3QgaW9tbXVmZF9od3B0X3BhZ2luZyAqaHdw
dF9wYWdpbmcgPQ0KPmZpbmRfaHdwdF9wYWdpbmcoaHdwdCk7DQo+PiArICAgICAgIGJvb2wgYXR0
YWNoX3Jlc3YgPSBod3B0X3BhZ2luZyAmJiBwYXNpZCA9PSBJT01NVV9OT19QQVNJRDsNCj4+ICAg
ICAgICAgIGludCByYzsNCj4+DQo+Pg0KPj4gU28gZXZlbiB0aG91Z2ggaW50ZWwgaGFyZHdhcmUg
cmVwb3J0IFJQUz0xLCB0aGUgbGludXggaW50ZWwgaW9tbXUNCj4+IGRyaXZlciB1c2VzIFBBU0lE
IzAgYXMgcmlkX3Bhc2lkIGFuZCBpZ25vcmVzIHRoZSBSUFMgdmFsdWUuDQo+DQo+UHJvYmFibHks
IGJ1dCB3ZSBuZWVkIHRvIHN1cHBvcnQgT1NlcyBvdGhlciB0aGFuIExpbnV4Lg0KDQpJSVVDLCBl
eGlzdGluZyBxZW11IGRvZXNuJ3QgZXhwb3NlIFJQUyBjYXAsIGEgd29ya2luZyBPUyB3aXRoIGV4
aXN0aW5nIHFlbXUgc2hvdWxkIGFsc28gd29yayBhZnRlciB0aGlzIHBhdGNoLCBiZWNhdXNlIGl0
IHNob3VsZCBhbHdheXMgY2hvb3NlIFBBSVNEXzAgZm9yIHJpZF9wYXNpZC4NCg0KPg0KPj4gU28N
Cj4+IEkgZG9uJ3QgdGhpbmsgd2Ugd2lsbCBldmVyIHJlcG9ydCBSUFM9MSB0byBWTS4gQWxzbywg
YXMgWmhlbnpob25nJ3MNCj4+IGNvbW1pdCBtZXNzYWdlIHN0YXRlcywgY3VycmVudCB2SU9NTVUg
ZG9lcyBub3QgcmVwb3J0IFJQUywgdGhlIGxvZ2ljIHRvDQo+PiByZXRyaWV2ZSByaWRfcGFzaWQg
ZnJvbSBjb250ZXh0IGVudHJ5IGlzIG5vdCBuZWNlc3NhcnkgYXMgd2VsbC4gQmFzZWQgb24NCj4+
IHRoZSBmYWN0LCBJIHRoaW5rIGl0IGlzIG5pY2UgdG8gZHJvcCB0aGUgc3VwcG9ydC4gUGxlYXNl
IGxldCB1cyBrbm93IGlmDQo+PiB5b3UgaGF2ZSBvdGhlciBpZGVhcy4NCj4NCj5JJ20gZmluZSB0
byBkcm9wIHRoYXQsIGp1c3Qgd2FudCB0byBkb3VibGUgY2hlY2sgaWYgaXQncyB3b3J0aCBrZWVw
aW5nDQo+d2l0aCBhbiBvcHRpb24gdG8gZW5hYmxlIGl0Lg0KDQpJIHRoaW5rIG5vIG5lZWQsIGVu
YWJsaW5nIGl0IGRvZXNuJ3QgbWFrZSBxZW11IGNvbXBhdGlibGUgd2l0aCBtb3JlIE9TZXMuDQpB
biBPUyBzdXBwb3J0aW5nIFJQUyBjYXAgc2hvdWxkIGFscmVhZHkgZm9sbG93IFZURCBzcGVjIGFu
ZCBzdXBwb3J0IHdpdGhvdXQgUlBTIGNhcC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

