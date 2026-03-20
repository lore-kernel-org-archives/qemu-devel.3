Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3914109316E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 04:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3R66-0004Lk-5V; Fri, 20 Mar 2026 00:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w3R64-0004LH-6s
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 00:04:28 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w3R61-00041w-Ej
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 00:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773979466; x=1805515466;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=R9OCBUYZBHapACvOH946r6oGPHKeiTJFd5QeI4LWvr4=;
 b=ZcXzlgj35zKKpi5nhEvT0QtH4gXSLG20Rx/SflbJxSasR3AqN1kHGTNv
 pZC6e59eD7+TK87xPZ5jL/T29rTgWR5238dYeUmTTmCpzE5Pe7/VYjiSv
 p8D1UZ04kZ7iSTH5TZ2DOXboXUtf2q8R3awnarsLkb843Geqnm6OZtcJs
 cHHwRpou3QDAI5PrKYhpuQWUsTVRbR640Ru2ZBsT8j6gvklVtkl2iuTqK
 KyUHNeV3E1gLPFVBn+vXcmz7pwl2309SkN9KJaV4gdgcyH4gKiHzDknBb
 cED/9iS017gCRD++ATRo7mqiND+D/Z9XPscBnnHxvGzwXQeSf5dHQWDzy g==;
X-CSE-ConnectionGUID: QMDb2Ko1Q36Ynr4jnJ9zBg==
X-CSE-MsgGUID: J4/W3JsuRpWMTPQ0b7QvkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="78668351"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="78668351"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 21:04:23 -0700
X-CSE-ConnectionGUID: AqGi8o9mT52lqXjrQR9paw==
X-CSE-MsgGUID: DP2ihL5fQG+BDRltEhqCww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="219015451"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 21:04:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 21:04:21 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 19 Mar 2026 21:04:21 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 19 Mar 2026 21:04:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8R8KlHw0R8l9rBxykcdfs1jIzNYSemg39MfdXSA+b9xwHjNduxeFH/93oGjtctrQ0dq6fWxaz4cZHOa+IgJVekHUIoz0ATE1zqH75kFxaYCodOi8G2j2FLHZNAkcHnAjb4ml5vsqIWDJHaoaRUeHW/+UaKzDjLqjdQk2pRTs5Rpojajv7rUsPzvaiJNQCAi+yolJQ0L80wU2vTjmtqEivS3IvLGj399cuYQhI/vDTOr7cJLz/Ia7YZlJVO/VdSqbmPptbxDfDTf/pmN8YwISxFIsgzOAvef1xc2nofaGGFLNexTpGdx2aKD80F7UJff6/W9urJPshwwttisFRGXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9OCBUYZBHapACvOH946r6oGPHKeiTJFd5QeI4LWvr4=;
 b=YJgkMVMPbf1rSGUfgNKZOHYR4Gcl5z2OOe1RBy2pwbuHG94eXvOsOcL1LUXu7ZU9BxUhwThOZOeYnC5v7r2FH7brlLW5POw9J60PFO5M0DL6JjYtK0BqE/kBMIwKYNUZOZHRSqXmKMkfjPT3ZM0E78/mmfYq3auwJs0mJj92yajPnYC42Rrpiohxz+lv1IBsflXS3b2f/XJE/eEWBDqQ30c2KJjSu/anJAAqo3G4j6phMrOIjU8RwwqbNhK48o7anTI5u4olGk81GrbnVQtaINTtxlC9U16xUMckiL4dyT1hiTJ648zHqL1nNPYRW/jmIqXCjx0m7CDMiAqllyGYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS4PPF3FCD980E2.namprd11.prod.outlook.com (2603:10b6:f:fc02::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 20 Mar
 2026 04:04:14 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Fri, 20 Mar 2026
 04:04:14 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Topic: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Index: AQHcrRueV4S7cttZ6U6X0YZKvVaD9bW1kyWAgAAOusCAASn/8A==
Date: Fri, 20 Mar 2026 04:04:13 +0000
Message-ID: <IA3PR11MB9136B3C106DDF70856F27FE6924CA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-12-zhenzhong.duan@intel.com>
 <1b2b191e2f9f1315c883ed2de4fb9644a01c8713.camel@eviden.com>
 <IA3PR11MB9136F0D294E9FBE576E0CF91924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136F0D294E9FBE576E0CF91924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS4PPF3FCD980E2:EE_
x-ms-office365-filtering-correlation-id: 371e5b32-5ba8-404f-9e3f-08de8635bfaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: aF4jSZYu4HFpRgtyQ06qggp7L1YZ9BA5BWWD50BZw6PtUi3AnGw4JTwL7ggS2ThXZ0XeW9qHSfhxUbshpddLyUzXI/x12/PEdnkvzX80mtWlYy1shC2k6BK/ZXCSts0oEhPW7UHWJ6ZWVgW8JR3oBh2SmkwBD1Y54tTQOzSNf0BXgGZArmQvww8AnG0vGCc4KhsptqTbv2ewQMrA5Ae5uIT9SljhBR65AmDAycDe3JrglDxcAscsHa83loUPu6BMjZbUULMjv0Iar1GksBAEdp4oS0C1a0RKVyiaMeP1Fm8kL+DbzMHkd5qu3QwSWp57x9tCqxxRXFcXZ6+0wMc/dXQtHRytCHgmJ3ekfTvYvV/+YaxAtxTGOwFbYA4d/r1rS/LwfsL5fk74N4Lm1gocstA3q7XSp1hmpvOAx3HZE/Z8UJJDKTubHwsucEAUbuDgLzdg3lu3CoIX7pK38QCQtCDkvsx8OGGl7moxBeQCupgYU6b5zKgsnRxdbZU5FEretNgDQI1EfvDPYJvQcO/9Qpwd/pWOHH29rZKv8QNtPVPbDVTAGPxaJIEJFiyB3zc+1v133qmO7UJu7AWdR/ZopcNaj6mMOaakFZ/za9AXytQUYk+OZS0G+W1xWasY94qumxU8xscpLxVIqjOrty6HC85IrOvkjxn91tPzITlZcnHQX6VPfiSpF2qhl4124CC6tHVOvtJqvSXEAwWJOkxszGjwgr8l0zQ2uADw2QVi9J6JmRxK8pZqS6/nb4PsBLBSIX1yHD7pqlTdTGgSdqNxR+J9KTXy3FTdXC3D/p/a+6A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHRlblUzWkxWbE5nWEdPaFhWalk1L1Q5Qk4yb2cwV0xFSHRmc2lEdmg5Zk9s?=
 =?utf-8?B?YWZMbDltQlRjRDF1YjN4VGgvRnRDQmFleStEdnpINXF6anowcm9rUUxPRVpi?=
 =?utf-8?B?U05DVmUzcEEzZm81aFJyWHBRaFNWWlFwR2Y1RlBScW5XaUU1MUdGalBiWXQz?=
 =?utf-8?B?YmVlbnNnaExhN3FPcGtuL2VGUEZFV3U0dTlHRE9QdmRyS0Z4Q2gxdkYzSWhu?=
 =?utf-8?B?R2RibHpobEwvWnVTYVpsYldNNDZkbGhpRENvdEprcm92dUpPM0dBNWNMWXQy?=
 =?utf-8?B?T0NtejNMTG5UZUloWHRYY0JjMzRVM08vU1pRNWpRN2g4THZWL29FR2VaWlpZ?=
 =?utf-8?B?NE1CckdmZVZoSFVCSnFCeCtoYmZ6R25CdG5aaXlhQTU2TG9UUXltOEE1dG12?=
 =?utf-8?B?bmRqY0pxdU9JQU5vNEhIMGs3UVRhN3VrREdmYk1jVXk1ZXBLY041Y0srZ2gx?=
 =?utf-8?B?WFBiVHpGbFJwZ2tvVFptMUw4bFVnK05jTUFZMmNWMFp1N2c1bUZoa3owdXQv?=
 =?utf-8?B?RWFNQy9GN012T0ZXQndNLzgxTWZHSHpiaTZ6ZU5CWjBGcm8wN0RwVmNudFpv?=
 =?utf-8?B?VjhydnRiOHUrMHQ3TVdlS2llZlRMWlRTbEdKTUdicnYxTk95TWJhb1dvdG93?=
 =?utf-8?B?cHU3RlFpTXFBZXJMOHludk9rN3VQV3NSS0oyajZsVUg2Znpvd1lYVm93ZkpC?=
 =?utf-8?B?SkpRMllQUDRWU2NjVkJQTWs4aDhaNEtvVFNEOEF1bXh1ZlpVZlpZMjh3MmtY?=
 =?utf-8?B?eitBY1ZYQ1N3SkIvQ2JRczhYSnFiSDRjR2M4OWZsOURodnBPNXJzeFZlOWdp?=
 =?utf-8?B?dU1lbFNac2hzbzJtallmSWZWZWY0N3k3aXZ0ZWJMTEVSMVgxanZLTzU4YUh6?=
 =?utf-8?B?YUZPVGdFVm1mWjlmWUVmR3RtTEJCWlBnWlQrTzVtU2tWY1FEdXoxMllYcUFH?=
 =?utf-8?B?QXBaM21PaysxcEQ4eUd0SCtHUkJkM3c3cUttZzlhNm5wM3h1S1NaTm5WR3Vx?=
 =?utf-8?B?K2YrYXovTWZyUXpFK0pHUWg1bkZVdkVHWE9hdjhVa3o5Uit2dEk5UHkyYWFu?=
 =?utf-8?B?SlRVZ0VuMStqYXB3MG9ibG9XQ0pXSmZTVnJXM2hVWXNIZzFHVHRnQS9GZzhh?=
 =?utf-8?B?aFE4K1pIMEViWTBKcVJnd1YwS08zVlN5VnFPdGpOc0Jtdkw0ZzVzaEsyWEtU?=
 =?utf-8?B?QjhHaHowczhwbjRtNkYxVWM4Y2Q1aDNCaWpDQzkwSDNmYmpjTXZmUkVDOVA5?=
 =?utf-8?B?SVd1cnJTMXdiSGltdFNHbHNzSHFlb2dTcE52QUh3b3R6UVByWk4yUGR1ZXFI?=
 =?utf-8?B?SDhKVVNaaXZXVmxuOWVqRkYrUlcwL0tISHRXSFhFY2NsbWh1VWNIVC92UHJ0?=
 =?utf-8?B?RmhnSW9iSDRHMWJaMnZybG9qdVlxQ1hkUldrZjJKSmhSSE42WkhweXU1WUhs?=
 =?utf-8?B?WmVoM2lOUEU1N240UlZwQk9UVkt2ZlBTL01xRFZNcnloUXAyamNDTXJQWFIw?=
 =?utf-8?B?VjF2anNDdVgyZU91Vzk2TWExNktXTkhncm9ZckY4Q0tlU0tRdE42QVdJUmk5?=
 =?utf-8?B?V1dxQ0xyNVExc25XOXZrdzVOVXJwb0cxZVlRR0hNOC93YnB3YlR5UE1sWkFn?=
 =?utf-8?B?enBmaGF3WXNYWHZ1ay8yb3FmUFNQNkplTzNaYU4vT3hpRFY5UkNvZmdEVmpK?=
 =?utf-8?B?ekpES2ZTNFZlOU41WnRlVkpoNHNwcnN1Y05oc0U1bFovbmtDa0M5MktiZEhT?=
 =?utf-8?B?SjlpNFI0ekZwenVpR045dXYvZmszbldzMnF5ZzhMUkFzR0Q1cXd4MW9WRlRk?=
 =?utf-8?B?UXNtS3RtV21LN0g3clgweURDdXNnT3E3QXZkMUJPSWFndTVyN3RlaGt3QnFv?=
 =?utf-8?B?eDVvOEpwR0ZKZXlOY1QwVU8zUjduaVZkUDQyYUUzZHo3bWtWZXRSNmtRVGdB?=
 =?utf-8?B?NnduUnFvZ0ZsSllycUxoSHYrRkVJTXhrRWk2NnRLZzIyZ2JRczV2Z2lUQk8r?=
 =?utf-8?B?UStaRUpNa0lyZWN0SXUybnltTWRKU0VTMlFjKzNubG8wOVV1TWtXU3Y3RHJp?=
 =?utf-8?B?U3Q5ZHluWTB1Sk5IdmJpeHAyUGkzM1ZJTmlQSVVZemRsKytCdDFnUTJNVVBL?=
 =?utf-8?B?dVVLVmZnSEV1NFpINXBQTkxneG9pSkc2NGpJc1RYVHV6ZktvdWV0MXFKZlpP?=
 =?utf-8?B?VERxZERNNHNTSXNuaUE4MFdUY290KzRHY21qdXVoNitsdC9TV1ZnbkYzMkdG?=
 =?utf-8?B?U1dkOXNhV1VLMXZiczByWUdGalNqQU51T1BSaHo1ZmRXckthSk51TmVqSXF0?=
 =?utf-8?B?c3VSNlQxclJHVC9VTHBUMXJpQ0FFN0R3UFVvSVgwcTlRbmd5cUMrdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KOVm6ugSDoNPigvDtyK5jAwrBvY9f5RsA1P/paqnDZawKx2Mqc+ESA+w0dmwqj1P2vJ3fdt6z7AD4p65CCXJFaOjw4n/hQSTMR7zhjK09HPRTD29jhim5eEiSC994g2xAOHgBQdvZr+5HNe3ZT6/shtssPbqBlKiz3dghGNfw00GaEgOBZ8h3rfwDWSUCcvCl12yGyXG26ustNZJ2jNj6bYfTtaSivq8hYI6Tu+zPzJMwqxHcffm8RgCcGfHz35mjf6cSQjqwSa4ZoJuX97PEWq/Ygr3i1AszsbUB+ZLfexIWxRraAaKjF7G1uS3TXHLeHfWu8zgHBm385lBS8PySw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371e5b32-5ba8-404f-9e3f-08de8635bfaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 04:04:14.0157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tK0zmikgYpVivvZhoUu6IMH06f4oCLvt4oSUchc8kaPjeyyeHWdIZWD/+BWQyqgdLmnbwcN75n2Cc+iNkXM9qQnEcGuV+mbIE1WjX5GgLC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3FCD980E2
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRHVhbiwg
Wmhlbnpob25nDQo+U3ViamVjdDogUkU6IFtQQVRDSCB2MSAxMS8xM10gaW50ZWxfaW9tbXVfYWNj
ZWw6IGRyb3AgX2xvY2sgc3VmZml4IGluDQo+dnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9sb2Nr
ZWQoKQ0KPg0KPkhpIENsZW1lbnQsDQo+DQo+Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
PkZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwu
Y29tPg0KPj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDExLzEzXSBpbnRlbF9pb21tdV9hY2NlbDog
ZHJvcCBfbG9jayBzdWZmaXggaW4NCj4+dnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9sb2NrZWQo
KQ0KPj4NCj4+dnRkX3Bpb3RsYl9wYWdlX2ludmFsaWRhdGUgY2FuIGJlIGNhbGxlZCBmcm9tDQo+
PnZ0ZF9wcmlfcGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRpb24gd2l0aG91dCBhbnkgbG9jay4g
VGh1cyB3ZSBjYW4gY2FsbA0KPj52dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2FjY2VsIHVubG9j
a2VkLiBJcyB0aGVyZSBhIHJpc2sgaW4gY2FzZSBvZiBjb25jdXJyZW50IGhvdA0KPj5wbHVnZ2lu
ZyBvZiBhbm90aGVyIGRldmljZT8NCj4NCj5Hb29kIGNhdGNoLCBob3RwbHVnIGlzIHByb3RlY3Rl
ZCBieSBCUUwsIGJ1dCBpZiBhbiBpb3RocmVhZCBjb3VsZCBzZW5kIFBSSSByZXF1ZXN0LA0KPndl
IHN1ZmZlciBmcm9tIHRoZSByYWNlLg0KPg0KPkkgdGhpbmsgd2UgY2FuIGJ5cGFzcyB2dGRfcHJp
X3BlcmZvcm1faW1wbGljaXRfaW52YWxpZGF0aW9uKCkgZm9yIHBhc3N0aHJvdWdoDQo+ZGV2aWNl
DQo+d2hpY2ggZG9lc24ndCBjYWNoZSBpb3RsYiBlbnRyeSBpbiBRRU1VIGJ1dCBpbiBob3N0LCBs
aWtlOg0KPg0KPkBAIC01NDAxLDcgKzU0MDEsOCBAQCBzdGF0aWMgaW50IHZ0ZF9wcmlfcmVxdWVz
dF9wYWdlKFBDSUJ1cyAqYnVzLCB2b2lkDQo+Km9wYXF1ZSwgaW50IGRldmZuLA0KPiAgICAgICAg
IHJldHVybiAtRU5PU1BDOw0KPiAgICAgfQ0KPg0KPi0gICAgaWYgKHZ0ZF9wcmlfcGVyZm9ybV9p
bXBsaWNpdF9pbnZhbGlkYXRpb24odnRkX2FzLCBhZGRyKSkgew0KPisgICAgaWYgKCF2dGRfZmlu
ZF9oaW9kX2lvbW11ZmQodnRkX2FzKSAmJg0KPisgICAgICAgIHZ0ZF9wcmlfcGVyZm9ybV9pbXBs
aWNpdF9pbnZhbGlkYXRpb24odnRkX2FzLCBhZGRyKSkgew0KPiAgICAgICAgIHJldHVybiAtRUlO
VkFMOw0KPiAgICAgfQ0KDQpBZnRlciBmdXJ0aGVyIHRoaW5raW5nLCBJIGZvdW5kIGFib3ZlIGNo
YW5nZSBkb2VzbuKAmXQgcmVzb2x2ZSB0aGUgcmFjZSB5b3UgbWVudGlvbmVkLg0KDQpCdXQgSSB0
aGluayB0aGUgaW90aHJlYWQgc2hvdWxkIHRha2UgQlFMIGJlZm9yZSBjYWxsaW5nIDo6cHJpX3Jl
cXVlc3RfcGFnZSgpLA0KYmVjYXVzZSBpdCBpcyBhIGZ1bmN0aW9uIGNoYW5naW5nIHZ0ZCBkZXZp
Y2UgY29udGV4dCwgZS5nLiwgUFFUIGFuZCBQUlMgcmVnaXN0ZXIsDQpwYWdlIGludmFsaWRhdGlv
biBxdWV1ZSBhbmQgaW90bGIgZW50cmllcy4gV2Ugc2hvdWxkIGFsd2F5cyB0YWtlIEJRTCBiZWZv
cmUgY2hhbmdpbmcNCmNvbnRleHQgb2YgYW55IGRldmljZS4gTGV0IG1lIGtub3cgaWYgeW91IGhh
dmUgZGlmZmVyZW50IG9waW5pb25zLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

