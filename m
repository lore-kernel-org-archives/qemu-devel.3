Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01549E7717F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 02:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLCoP-00058g-9M; Tue, 10 Dec 2024 21:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLCoN-00058T-Hn
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 21:50:51 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLCoK-0005zC-Sj
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 21:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733885448; x=1765421448;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nphxwNOeqS0IHKp6+/K04y51RIp2IMJNmq7dxuPLLyw=;
 b=PmZHWg/duBnSDQx55fz5Oqq+j+kP90couuRff2Be4em/5yi1cZU7HARl
 KA+8POEHNG+i/sMsHVteLcCdijKKR812hdnlqwD/n8WA4/yxSMoXJa6Wy
 szEMX0zuey19xHWdWkXG/eToIUDpRpL/S8tHZFpHsrXze9AdHkucYF8kt
 aVyFdxgKRZRCUQ3daex7k/Pw9FDa+hMnQt1G3B12lUV3ST2tFs015jh7b
 aU9oc5TulniR0+o8FxgtCaF1Uupv2IO+NFftWYj5/FgP9XKMazVbplaL1
 lhxy8PfRb2k1jdAK+WnljIwZbnNfZVZXljwUBy4ShQX5U/RLAoytlDwSE Q==;
X-CSE-ConnectionGUID: jGfBwjIvR5ehzeQHoss55A==
X-CSE-MsgGUID: E0cU1uAeQaGhWlwFfKvrVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34301688"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="34301688"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2024 18:22:34 -0800
X-CSE-ConnectionGUID: 2xArOKN3RIWhqw0UkQrzxQ==
X-CSE-MsgGUID: tJEgGthBTw+dJfA6vA4vkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="100667634"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Dec 2024 18:22:35 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 18:22:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 18:22:35 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 18:22:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzhpkAatgim6BcVBRejRVu578MQ+yOLR7hwCkodQ4PfDhKGMOkwFRyg2aOSUVNUR/uXGFrpe9CPzI4yrRM81nCasl1VLLSKpEN0Hsn1zsXXZUOVJ9BSB4osw1v7uEzA0oeku5cr7NpcvA52umR3ZsnYKN5aSqZc+oEn5MOHyeq7Nl0yHrwf1IShe5/RwRDIcYRoqgkwcw62IAMjBZ1fTIoI+LW7mgjAHsfFHqLWj1fDmAPj5mg9uhhtNJYV7JqT7i3A7jQuRb3J3wxNYgi/QTdPD55cAnbWoqBesYbdBcNJxaU9u9mfV88mMaKAuZuF2hcYU1Lkq8decaXV2kQeRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nphxwNOeqS0IHKp6+/K04y51RIp2IMJNmq7dxuPLLyw=;
 b=p+8hpGH9zgrHLwwuMTdSErtP3bX7L1H8r2n2q7g70OagQF6C7F7vEaThzDReOA/XqxNPi9gXODa7cWfHRUoZS04fQdvGhfLdzc6MXIQF1l0kS2x46QhL/nBS6w7GvpR4rIE28BiMlX8RRggBwWx73Skccg684DXpbN28GXsk2fDP4cPWbpWVpp1tcByfPcVAwe2ZwFooMMDq1x8SGlJryib9rW18g4btS5SL3U5BrmDJj/GIZ35trSc5PjGePBcCwWTw4/YRjrmxF/WpXZnKqtgzeW6rVBEF7rPxn3jEH0Uji3iWDE4bPSmWNgW3FkqjoSxvVHpI8lMklBW5trzNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB5887.namprd11.prod.outlook.com (2603:10b6:510:136::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 02:22:32 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.8230.016; Wed, 11 Dec 2024
 02:22:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, Jason Wang
 <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Thread-Topic: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Thread-Index: AQHbNBVBkR3y0fzlt0GxzbBCrTjZVrLVkrqAgAAskgCAB6ksgIAAMrUAgAACvICAAAT3gIAC1sZg
Date: Wed, 11 Dec 2024 02:22:32 +0000
Message-ID: <SJ0PR11MB67442853FBF1FAD572A3CC37923E2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-19-zhenzhong.duan@intel.com>
 <CACGkMEtwV51X9ovWB3JHtyW4gpLT8zD8bieKFA2X=BVNZF8ymA@mail.gmail.com>
 <7126398e-fc27-4d4f-894b-f71b012f98e1@eviden.com>
 <CACGkMEvuX4CtADqq0O3TnD1=Jh2aBnXFdTzLS9junGyxkKq+Xw@mail.gmail.com>
 <68d3a523-19c4-4296-9df8-b98b498d4c0e@eviden.com>
 <CACGkMEs0xTf+YeCWmBbyJaQSS2RzBe2pBYzrv3n_mW+6EV4few@mail.gmail.com>
 <bb7df163-e3fe-4d26-93c2-756a7b6be15a@eviden.com>
In-Reply-To: <bb7df163-e3fe-4d26-93c2-756a7b6be15a@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB5887:EE_
x-ms-office365-filtering-correlation-id: 9c9445e9-ecc9-40de-6d7e-08dd198aaaf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UFFuajQzTWJYVVdUTzFrc1dMV283YkR2Q0tObU01N09MTHVHWFA5K1AxUkls?=
 =?utf-8?B?UFJicjhqc3U4WTI2ZjFpakY4TkRlRFdlaHMwWU54d1lPUHRRWFk3U2g3N09J?=
 =?utf-8?B?REN6SmxEdE15R0o4RVR5TkYwMFJVVnRnbjQ3a2lETm51dGErSEhQK3YwZkpv?=
 =?utf-8?B?R05MN3hCWlFrRW5KSUxFaG82TjRYZis5ZlU0cFB2VzFNdm1xZ2U1dGtOSHZp?=
 =?utf-8?B?OXQycFlYRGdmc3ZKdk9Vc2ZQWEFLSDRNNXNlVHFrQURDNW9rOWMyNlBqMVl3?=
 =?utf-8?B?UmZZQTRpNXkxQlBJNUJkVmJYYnlWVTBTNnNSamdIV0FvWjVoSTlwTE42RUs0?=
 =?utf-8?B?Sk9VaS9GdHZzNlEvTHIvcnZ1OVJVc2VYODRwa3hOd2pZRWJybE4ydkorUEhO?=
 =?utf-8?B?NGxNMXRyL3JuYmdRek9tNU1DaU9BM281V1Y1ZW5GK3kvWlBWS2grYzBrTUto?=
 =?utf-8?B?LytBZFg2WW1DK2lyUGNZY0RYdEpOcUZXeUt0amdabGU0WEF5K3duci9xRkxF?=
 =?utf-8?B?SWFOUFErZXExYkhkY1lYbm10TElBZVNaamVwRzZKeUNwRmJxUXY2OXNBUFNJ?=
 =?utf-8?B?SXBkbHV1SXJhSkJBVTh3V1IyTHpHQjQ1N3BrVFJDZDM5QnJ5dmw1VGtFN0NT?=
 =?utf-8?B?NzdMSkJETm03WmhEU3dienlSYnZrZW9TVGxLck5DU1lqallLaXE5ZzJLNHNs?=
 =?utf-8?B?d1R4VStBbXNqYlVSVi9mdkt4bWozazNGNGdTOVovRmR3Wk1BeTdCWjZBLytN?=
 =?utf-8?B?a1VsaWVEZkZmMklFdzBsdnAvZ2FpNkpvZFdVYm8veVdWdUc0QzJYZ2pBREdz?=
 =?utf-8?B?K3hkd0hFS2dUT2VoR2NZaW5OZGZzeEl1c2FRaHJvZm90TnJyNjlXQTV6cW00?=
 =?utf-8?B?L2VhdU9WZDB5TmpndFNhcFVzbkF1MTQxeU5kTTMzVEEzei82UE9QQ2MzQjlW?=
 =?utf-8?B?MmJ0bkRIVlJaRGxaSG1NQ0lWOEplUXNUR1U0bU85eGlNNlJXQ1h0bU1Kc0tK?=
 =?utf-8?B?Y1g2U3F6M1A3ZVZEcHEvUDd0a1pjcGY5OFNXU3FlalcxaFBaWVlaWHBLcUJ4?=
 =?utf-8?B?WTMxZmVlNGFLN2NJRG1weTVsSEhXSC9BV2RRcStSUmtiMngyVGVCUXdyblAx?=
 =?utf-8?B?eXdGTlpBYmFSUWNreUd1cU80eHBaUTl1RlN2ODVwM3JvK3p1ZnBJeURBbStX?=
 =?utf-8?B?VHBxUmhmdm55Y1BsQjNxbnpseDZjMURqY2FhRnFGdEZMNkswUDg0T2wrejlS?=
 =?utf-8?B?WEU2ejRwc3dYeWtwaHRqU21SK1dCY3ZQdE12S2FQdXBhaE9TSWtreDJjbTZE?=
 =?utf-8?B?bHA4eUlwYkhuTGw4WEV0TWNPbURsYzZzMFdpaE1sYUxoMlJyWTN3OXVtSWZD?=
 =?utf-8?B?dC9hUXJERzBVb2ZhbzZ2dVphaG5KSmpXcHR3dXUzQmUveXBvdVBrN1J0L3hK?=
 =?utf-8?B?OUdCVVNhQVZtMk84Vk9sSllJTVdYcTd2M3lDcCt3RVpYMTQ0UnNYUllHK2ZX?=
 =?utf-8?B?eFlUMmJRQnh6Vy9uc1FFMjA4b2lMMll1VlZpK1hRTHZaQmFLVS8xN3NHbit6?=
 =?utf-8?B?SUhjV1MrNDdOL1E3RGErYXljOGNCQ0h3MElsT0VpWWo3NElMaVN3M1kvVHhQ?=
 =?utf-8?B?ZHF4NWpYekxML2k3SThYRlNvT0dCR0NmMFdjTmx5U1UzWFlxZHFyOVFvazVz?=
 =?utf-8?B?T0o5NXhianVHVHkyMUp4U1UzVndENTFHNzRqdS9rRWwzLzNITmY1aDBLdFI0?=
 =?utf-8?B?cnMxdU9oZitEb2Y4dWUvdUMzN3RaUUNtWnRpOTBDV1ZDSTJiMVdYVkhMY3dx?=
 =?utf-8?B?Q08xaTBJcjFBQkRTc2k2bWNrclNiaElRQm9pSGpKNUZsTkx1aUlvR0tFdVdW?=
 =?utf-8?B?cHoyMjdoTDFXcThFTS9rY2JxRHJxZ1FhMmhsOTVQVENXK1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1NobDhnZG5TVkVJR3FicTQ3U2RaN1A3eWZINEVrSEJOMHZ4MllhVWVKVDBl?=
 =?utf-8?B?SVU2YUNpanFUOWFPTzZMTWwxNDBwdGFURkdIR2lPbHJ6d3NRQ2pGcW5mUlp3?=
 =?utf-8?B?RTJtcXBGanpGU0ZhdWVWTFowQ1FrcmVZZUl3OHIxNVIrYzA0TGlRZlBwanM5?=
 =?utf-8?B?a0xVZHlvclkrZUN1VFo2ci9ZS0tNTUJlWUhLZGw2UGJhOWljcEdUQWxST3Jq?=
 =?utf-8?B?bSszZVU4c1pNMHYyanhXN25oa1JLSnNyL0pLQUFhSFFHUzJka2lqV0dVUHhQ?=
 =?utf-8?B?OVByLzc2RThFUTdwL2tOVU9Wb3QvUFFQSG9hbEQwUklrMlowTGpzMFNHRXMr?=
 =?utf-8?B?cWZQSm1zaW43WFVqSDRONHpya3dGUVAybEQyWmgxUUNOYzhwa1FJL1JLQlgx?=
 =?utf-8?B?ZCt1TW1TUldyYUZkWDk3c3R3cXBMRGxRZFlVbU9mOHF6VkNGZEIwd1ZHVFgx?=
 =?utf-8?B?RXVTTGZTeUErM29OKzZHUUZzV2FBZ1B3cUVyYVZqMXp3VkpocWFZWE9RL1Uw?=
 =?utf-8?B?SzRjbUgzcSthOEp3dW0yUVFyYzNFT00rME5NalZXZS9MOHhmUHlaMm9QSVV4?=
 =?utf-8?B?QXhRdWg3ZGlRU1B0eitYakRRY1RlQW1iazJneXlvVzBnbXNJckxOUUVrM1V1?=
 =?utf-8?B?c0dzOEZNQzQ3N055eU9qN2hVUTNCaExnVkR4RXZoS1Nsb3FkeVFsQ2t0cmRW?=
 =?utf-8?B?S0RiekZmU0hTdzd3UGs3WUpEWnplS1h6UndRN0ZWNWxQaVdSMkZ1Q05xNTI1?=
 =?utf-8?B?VFVmdS92eExkbEJtb0FNRmlNQWtQb0Vqak9QTDBvNUFvNmNIcnJwZExSWXRZ?=
 =?utf-8?B?d2VEYVY0U1BaOG9wVlovQ3BwckV2T1VZajVWVkZ2eFI5d1RsNWNXeS9SMGVZ?=
 =?utf-8?B?ZkR0NEFkckVWeEZrYjM1RWhLMllWTW5la1hGaFB3NnVUM3pqT2FnQVRCVHQw?=
 =?utf-8?B?cWRtZk1PdFFGeUxnamNOL2hIWmFxM3oyMGozUHJKQnEweWtORjhqb2lQbWYx?=
 =?utf-8?B?UGd6WmhvVWhlbHNjRnY2VHl2UHYwcDhNNitLK1BXTnp0WDZNdTFuMGVpTmZG?=
 =?utf-8?B?Q2lYRE5IbnV1cXB3bERjd0VwNTNsT3RiNjV2R2t2bFNRODB5RDF1SnBuMDh5?=
 =?utf-8?B?UWlJVTA0NEovWU5pbzlzc3ZUdzdjNTdYUHJtMFVqN2l1UVRBN24wVDQyNnRq?=
 =?utf-8?B?dVdheWQvYXJmSTBQZk94ZlJPdEk4eXhTY3d3bVFtSXdCSTBMUlpGZDMyR2FX?=
 =?utf-8?B?NDJTNFM1clA3R0hreHVzMjFIY090RmZ5SkxBWEpqMkxvVlVycDluZW1ORGc3?=
 =?utf-8?B?WXBENTQ2VGhxYmk2WU8xWlhhQ2V0YWhhYWtVY01MeXF4c0NZTi9hREtKcmE0?=
 =?utf-8?B?c3gxVnBqdVJsNEg0WHVaaHR0cUY0ZGZmQmVQcnZZb1Q3Vi9FNE40UnJybjNZ?=
 =?utf-8?B?cmMzT00zWDkwOVBYUXV5RHdOaGxTMmJFNDRFMzJOL2Vxci9JQlZDZ1FuV21M?=
 =?utf-8?B?RUNEOGxBY3JlWndiYUFLQzZUcWZOc2gzTUovT1lIckVITGhxTjdkMDdUQWQ0?=
 =?utf-8?B?dEtSSUtLcTljWllaSlFsQ2JqbkdiZzcrbHBDQjlmR1lGYXNwSmNsWjRvSEZH?=
 =?utf-8?B?TFhrczQ2aHFSTHAyWlBJa1V3UEk3WHNSOFljcnlaSnpRV2o2aVFJeUMzNFAy?=
 =?utf-8?B?QjdrcWJRSk4rS0VpT3d5YzdlOXZqNHcwWWNTTkN3UmJwWit3RTJhMWdiamFH?=
 =?utf-8?B?eG5iU1pJTUt1Vkh2RUs1QUNXVzVxWHdRSHp3clBsZVlETGhvYU5zOTlPalFP?=
 =?utf-8?B?eG83REo4THZGV1Z2Q1lPclp4M2cvLzdIQmtVRys0N01FTXR3SmhOOE5YVDlD?=
 =?utf-8?B?ZGVDT0JtaWZ0czJURkgvSi8xcFBYTnVmSDBOOWFYR282WnQ2TWVHTk0yL2dV?=
 =?utf-8?B?Z0F2RW9rUDBWQ1NpeTRzQ0t0d09RNVA1Y2hneVVIcUdmNm9sb1J3OEd1WXJM?=
 =?utf-8?B?K3NEMVdOcnpWT0pvQTlYSkdFUThtZ01PYkJXRk9oUUEwU1psYmI0M2EraDA0?=
 =?utf-8?B?ZlFDSVFMSFN5d3IyUU1zRVN0Nm5DQXV6VHFHcUliMUFSNUNRSWRpSDBFNGhM?=
 =?utf-8?Q?gH4ZLr5FlDD4759NfD6uZPTrx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9445e9-ecc9-40de-6d7e-08dd198aaaf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 02:22:32.0650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3PbGYTI9D/E28+ldgsteuek279fLes9ddcXWfs4PDrkRGVraQvQpVgIuBrg0fI5v6CWLUSDtvwGZw0UkXB9n4Z6I6GSXqF0NqoycRoJ94BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5887
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

SGkgSmFzb24sIENsZW1lbnQsDQoNClNvcnJ5IGZvciBsYXRlIHJlcGx5LCBqdXN0IGJhY2sgZnJv
bSB2YWNhdGlvbi4NCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ0xFTUVO
VCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj5TdWJq
ZWN0OiBSZTogW1BBVENIIHY1IDE4LzIwXSBpbnRlbF9pb21tdTogSW50cm9kdWNlIGEgcHJvcGVy
dHkgeC1mbHRzIGZvcg0KPnNjYWxhYmxlIG1vZGVybiBtb2RlDQo+DQo+DQo+DQo+DQo+T24gMDkv
MTIvMjAyNCAwNzoyNCwgSmFzb24gV2FuZyB3cm90ZToNCj4+IENhdXRpb246IEV4dGVybmFsIGVt
YWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMN
Cj5lbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVu
dCBpcyBzYWZlLg0KPj4NCj4+DQo+PiBPbiBNb24sIERlYyA5LCAyMDI0IGF0IDI6MTXigK9QTSBD
TEVNRU5UIE1BVEhJRVUtLURSSUYNCj4+IDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNv
bT4gd3JvdGU6DQo+Pj4NCj4+Pg0KPj4+IE9uIDA5LzEyLzIwMjQgMDQ6MTMsIEphc29uIFdhbmcg
d3JvdGU6DQo+Pj4+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2ht
ZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMNCj5lbWFpbCBjb21lcyBmcm9tIGEga25v
d24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4+Pg0KPj4+Pg0K
Pj4+PiBPbiBXZWQsIERlYyA0LCAyMDI0IGF0IDI6MTTigK9QTSBDTEVNRU5UIE1BVEhJRVUtLURS
SUYNCj4+Pj4gPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPiB3cm90ZToNCj4+Pj4+
DQo+Pj4+Pg0KPj4+Pj4gT24gMDQvMTIvMjAyNCAwNDozNCwgSmFzb24gV2FuZyB3cm90ZToNCj4+
Pj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3Ig
Y2xpY2sgbGlua3MsIHVubGVzcyB0aGlzDQo+ZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRl
ciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+
Pj4gT24gTW9uLCBOb3YgMTEsIDIwMjQgYXQgNDozOeKAr1BNIFpoZW56aG9uZyBEdWFuDQo+PHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4gd3JvdGU6DQo+Pj4+Pj4+IEludGVsIFZULWQgMy4wIGlu
dHJvZHVjZXMgc2NhbGFibGUgbW9kZSwgYW5kIGl0IGhhcyBhIGJ1bmNoIG9mIGNhcGFiaWxpdGll
cw0KPj4+Pj4+PiByZWxhdGVkIHRvIHNjYWxhYmxlIG1vZGUgdHJhbnNsYXRpb24sIHRodXMgdGhl
cmUgYXJlIG11bHRpcGxlDQo+Y29tYmluYXRpb25zLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBUaGlzIHZJ
T01NVSBpbXBsZW1lbnRhdGlvbiB3YW50cyB0byBzaW1wbGlmeSBpdCB3aXRoIGEgbmV3IHByb3Bl
cnR5ICJ4LQ0KPmZsdHMiLg0KPj4+Pj4+PiBXaGVuIGVuYWJsZWQgaW4gc2NhbGFibGUgbW9kZSwg
Zmlyc3Qgc3RhZ2UgdHJhbnNsYXRpb24gYWxzbyBrbm93biBhcw0KPnNjYWxhYmxlDQo+Pj4+Pj4+
IG1vZGVybiBtb2RlIGlzIHN1cHBvcnRlZC4gV2hlbiBlbmFibGVkIGluIGxlZ2FjeSBtb2RlLCB0
aHJvdyBvdXQNCj5lcnJvci4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gV2l0aCBzY2FsYWJsZSBtb2Rlcm4g
bW9kZSBleHBvc2VkIHRvIHVzZXIsIGFsc28gYWNjdXJhdGUgdGhlIHBhc2lkDQo+ZW50cnkNCj4+
Pj4+Pj4gY2hlY2sgaW4gdnRkX3BlX3R5cGVfY2hlY2soKS4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gU3Vn
Z2VzdGVkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPj4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+Pj4+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+Pj4+
IC0tLQ0KPj4+Pj4+PiAgICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDIgKysN
Cj4+Pj4+Pj4gICAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDI4ICsrKysrKysr
KysrKysrKysrKystLS0tLS0tLS0NCj4+Pj4+Pj4gICAgIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5z
ZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4+Pj4+Pj4NCj4+Pj4+Pj4gZGlmZiAtLWdpdCBh
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPmIvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQo+Pj4+Pj4+IGluZGV4IDJjOTc3YWE3ZGEuLmU4YjIxMWU4YjAgMTAwNjQ0DQo+
Pj4+Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+Pj4+PiArKysg
Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCi4uLg0KPj4+Pj4+PiBAQCAtNDczNyw2
ICs0NzQyLDExIEBAIHN0YXRpYyBib29sDQo+dnRkX2RlY2lkZV9jb25maWcoSW50ZWxJT01NVVN0
YXRlICpzLCBFcnJvciAqKmVycnApDQo+Pj4+Pj4+ICAgICAgICAgICAgIH0NCj4+Pj4+Pj4gICAg
ICAgICB9DQo+Pj4+Pj4+DQo+Pj4+Pj4+ICsgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2RlICYmIHMt
PnNjYWxhYmxlX21vZGVybikgew0KPj4+Pj4+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJM
ZWdhY3kgbW9kZTogbm90IHN1cHBvcnQgeC1mbHRzPW9uIik7DQo+Pj4+Pj4gVGhpcyBzZWVtcyB0
byBiZSB3aXJlZCwgc2hvdWxkIHdlIHNheSAic2NhbGFibGUgbW9kZSBpcyBuZWVkZWQgZm9yDQo+
Pj4+Pj4gc2NhbGFibGUgbW9kZXJuIG1vZGUiPw0KPj4+Pj4gSGkgSmFzb24sDQo+Pj4+Pg0KPj4+
Pj4gV2UgYWdyZWVkIHRvIHVzZSB0aGUgZm9sbG93aW5nIHNlbnRlbmNlOiAieC1mbHRzIGlzIG9u
bHkgYXZhaWxhYmxlIGluDQo+Pj4+PiBzY2FsYWJsZSBtb2RlIg0KPj4+Pj4NCj4+Pj4+IERvZXMg
aXQgbG9vayBnb290IHRvIHlvdT8NCj4+Pj4gQmV0dGVyIGJ1dCBpZiB3ZSBhZGQgbW9yZSBmZWF0
dXJlcyB0byB0aGUgc2NhbGFibGUgbW9kZXJuLCB3ZSBuZWVkIHRvDQo+Pj4+IGNoYW5nZSB0aGUg
ZXJyb3IgbWVzc2FnZSBoZXJlLg0KPj4+IEhpIEphc29uDQo+Pj4NCj4+PiBNYXliZSB0aGUgd2Vp
cmRuZXNzIGNvbWVzIGZyb20gdGhlIGZhY3QgdGhhdCB4LWZsdHMgb24gdGhlIGNvbW1hbmQgbGlu
ZQ0KPj4+IGlzIG1hcHBlZCB0byBzY2FsYWJsZV9tb2Rlcm4gaW4gdGhlIGNvZGU/DQo+PiBZZXMs
IGFjdHVhbGx5IHRoZSBjb2RlIGNoZWNrcyBpZiBzY2FsYWJsZSBtb2RlIGlzIGVuYWJsZWQgaWYg
c2NhbGFibGUNCj4+IG1vZGVybiBpcyBlbmFibGVkLiBCdXQgdGhpcyBpcyBpbmNvbnNpc3RlbnQg
d2l0aCB0aGUgZXJyb3IgbWVzc2FnZQ0KPj4gKHRob3VnaCB4LWZsdHMgd2FzIGltcGxpZWQgdGhl
cmUgcHJvYmFibHkpLg0KPg0KPldvdWxkIHlvdSByZW5hbWUgcy0+c2NhbGFibGVfbW9kZXJuIHRv
IHMtPmZsdHM/DQoNClN0YXJ0aW5nIGZyb20gdjQsIHdlIHJlcGxhY2UgeC1zY2FsYWJsZS1tb2Rl
PW1vZGVybiB3aXRoIGZsdHM9b24gb24gUUVNVSBjbWRsaW5lLg0KU2NhbGFibGUgbW9kZXJuIG1v
ZGUgaXMgYW4gYWxpYXMgb2Ygc3RhZ2UtMSBwYWdlIHRhYmxlLCBzbyBJIHJldXNlIHMtPnNjYWxh
YmxlX21vZGVybg0KaW4gY29kZSwgSSdtIGZpbmUgdG8gcmVuYW1lIHRvIHMtPmZsdHMgaWYgdGhh
dCdzIHByZWZlcnJlZC4gSW4gdGhhdCBjYXNlLCBtYXliZSB3ZSBzaG91bGQNCmFsc28gZHJvcCB0
aGUgY29uY2VwdCBvZiAnc2NhbGFibGUgbW9kZXJuIG1vZGUnIHRvdGFsbHk/DQoNClRoYW5rcw0K
Wmhlbnpob25nDQo=

