Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FD7D3B7DE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 10:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSYAn-0000Wd-43; Mon, 08 Dec 2025 05:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vSYAR-0000VN-Pz; Mon, 08 Dec 2025 05:08:32 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vSYAO-0002LW-40; Mon, 08 Dec 2025 05:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765188508; x=1796724508;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mOTMhZr2CtohU3u9vW6yGzv+V2EtCvnDUaYTycX4+NU=;
 b=eoHRr/J2XrJWNChZZAvsjf8sRgsuD9AIa5LL/coe7s/4GSTHnhAgoy5n
 Bghmqqdna8e0uoqNOY3SLAeuNOPJymJQ3vsfpZeYDLeT9+xN9BLWPvV/E
 eauZVeFNgdsnamEbd00btTKFEGUz03YVNHIq0m1vL3HwEKUNM+zks7y0W
 aIA2hxN4XDPo3BQNkZVvlMetthrf37sydL21C9IlqoqivVuPe7ZdIWHhj
 BGlz7bOnam5e1mFLVhG2Wt64KnrrcKZE3B56BS8uD3Y6zXLD0SRxUWpqi
 FIxxfS+vqZcd2/ItTwnNMpKDJyQm5GpXydBfgZr+mZNf1JiSJ4aGQwNq+ A==;
X-CSE-ConnectionGUID: xyz2APBDSGmwDbIBPWcG5Q==
X-CSE-MsgGUID: +hT32N3kQs2Kl9tajBh3pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67014651"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="67014651"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 02:08:22 -0800
X-CSE-ConnectionGUID: hqU2Di8sSgqZLpTPgDFeDw==
X-CSE-MsgGUID: sX3yC6tzS6mQSv7uV982bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; d="scan'208";a="226911280"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2025 02:08:21 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 02:08:21 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 8 Dec 2025 02:08:21 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.58) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 02:08:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzHb4UgNCorA7I0ZfNdnUMmo3UvKOyzsW/w7ogA5LzEBuDtzFgqQGctAOxFu0db6A4M+Nx5v96SJqiy+wO3SuuVDfPePKjZnTr+CefTyEcl6nT0iKYTxjB/V1e2vL5a4/7d04aYCPiRcq7+iqOOTZVBlVF8qBjOytcGCwP6lDnL3Izb6GZXyMb9snWmAhQcFuAoPL34AP08eCWlUHcACHRLHvuho+BZ9PugITvvrzi2VucuuJgxI5N33A2jl/zevhFej2aqSUai4+huU+XSHZ6/Ny6R222qwYlRyD7tk/n990xYO3FJvae+n/j16GLy45ZDLiKi5Xa5218KY+Xy5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOTMhZr2CtohU3u9vW6yGzv+V2EtCvnDUaYTycX4+NU=;
 b=wO+MdBrleUtoWGLjBKCeEZqmR6hAfb+bsxEsSyGqfGBs7ZqE+5Rl9R46wFIlJBJvwA2ekNF1DE6Jvl4r+cGq5t7mAYvQQbImVqs9okXPPtbjybt5pP+6m8o7HFsrxbDPCabJmDq9Sr2ni++84p1l2XHuS9mW/quX71YBzja2tLYiwgJEHEuJM6Oq1JbvaaEslyFoalhNP4GV37n+dvyvlJMkn9nguMZ4pdQxl3Eslkb4Qvw1Di/itflmb597fYYDtdKU/vLbXqgYG7zsvWpMjAk4zbqaoDmeAmTOd1rYlaZ8wsCDIaBbIH71xo43itLerxdMoyTi+wbsvVelt5hoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ2PR11MB7517.namprd11.prod.outlook.com (2603:10b6:a03:4cb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 10:08:18 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 10:08:18 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "kjaju@nvidia.com" <kjaju@nvidia.com>
Subject: RE: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Topic: [PATCH v6 00/33] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
Thread-Index: AQHcWiDbJ8FjAQNp6EKbX4GqkmMsN7UXmGbQ
Date: Mon, 8 Dec 2025 10:08:18 +0000
Message-ID: <IA3PR11MB91361CCD9C11FACB77057AB092A2A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
In-Reply-To: <20251120132213.56581-1-skolothumtho@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ2PR11MB7517:EE_
x-ms-office365-filtering-correlation-id: 8199a60d-fac9-44c7-4306-08de3641b5b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?Wk5YeUh1OU5UNFJVOFh0Q2VsblVTOG1XYVJ3VU5jT0drMHY2NUdOQkp2Q2Fa?=
 =?utf-8?B?djJHM21zTEp3K0k1Um9lLzFKLzR5Vk9ta2RnVFY5QU1oN0ZkYWJ1VUU5SXFM?=
 =?utf-8?B?UHJoem5Beitkc3FKUG5HNStFV2grYTY4TkxjOXc0Q1lOSGJXbUFWbFVNNDR4?=
 =?utf-8?B?clEwTHlMYjFTRDZKdk5OOUk5U3RUWC93WHI2RkY1K1YrL1VmZDI5TXo3M0px?=
 =?utf-8?B?QncyeVVzT1JidHNPV2RwaFlwbXlBemRlWU5PcEdZYlY5SWV6aTI1VC9ac2RO?=
 =?utf-8?B?ZlhvbGY2UCtUSFZVekp3bTYzdmhqdSsxQzlHcFV1ZzRPYjFoS0E0c1V0amVp?=
 =?utf-8?B?bi83UXpRRWYxODVRU2s2Q0hPUUN1Q2RXN1ErM28xUWhteThoY0p6UWk0Y2dO?=
 =?utf-8?B?TUdnNFFhQk90VEJMdHNaME9RVDRJK2NMa3dvWmZoc1NYMjh6eW1ualUrU2FW?=
 =?utf-8?B?bTRXZjluRFJTR0pjZHoyMlNEdjRBUWtqZVZyM3lxQUFGT0ZGOFlFMmpZMWZN?=
 =?utf-8?B?d05FMC9NUExqcUdkVndpT1ZOay9vaytwUDdqTkdCdmhIaGRSTURyeEc2L0hE?=
 =?utf-8?B?TVlHai9Wa0hVMkhEV1ZqS0lORzdNOGlLMVJMT1ZYek9ibUY1Q09CTkFvM0pz?=
 =?utf-8?B?ZVF0UUdsM0pRMjZMcE9iS1o4UGRMenJLdkJVM1hRMTdyMnFOeG4veVRCZlBy?=
 =?utf-8?B?MFdKS2l4SlRVNmxQMHNXMStQQTY2MTROZEQyN1JYWVNkWlYvNEtlb1ZvTFlp?=
 =?utf-8?B?YzlQV0tqREFzcml5OWtDMEVhYmYxL2JFTmdtM2szdHkza29ocEFKNHdoRE1k?=
 =?utf-8?B?UzJFNTYwNmlwcXNaZHVHUGwyRE1HUVVZMldDN1EzU1ZSSDB1Unc5TmU3VlFk?=
 =?utf-8?B?S010c2h3VS9wZS9ic3hMakhZdnErbkpGbjkwaEZ5RVlBV05ldHphanl0UEFP?=
 =?utf-8?B?Y2VhRGQ4ZUNqdXlhS1Z2VlpONkRNWHNMemVyWEZVbUF3ZGtIN3FCODNqdkE4?=
 =?utf-8?B?TFF2ejJLRWJwRkN2Q25CaUVvMy9kbzNIMzV1TWRVVStuREZzTTY2cmlrZkRj?=
 =?utf-8?B?aFE0allTYVE3K1VJby9McjUzQnJyOXBoNDRmZlpVaWdKcnI4NEx1MjJpcGM0?=
 =?utf-8?B?aWFpSDJvYTgwTTRVZ1hZNDFaeHJWYTNjTE9VV3lzYVdabGpkTE1SVDFCTkx5?=
 =?utf-8?B?Z3IyMWdYMzIzbzZQalJzbmYyaHNLMFZkaUN1OElENGkxQVJ2U0d3dXE1Z1p2?=
 =?utf-8?B?cWttWTQ3WitFcTVtc0VyRU1EbTdqdWhKN1Jydlh6UFNDRGlLZ0hDVUkza2JT?=
 =?utf-8?B?M3FndUpJcG5IcUM3cm9FTU5adEpmcHpLTjY0Y3hyd01vMzhjQjlkYUdXeE42?=
 =?utf-8?B?a2gxb3dFeWtCK1VqNkQvZHBUSHlpdCtjUXF0UUY3QnlIWEFkMzluV0FSL3JL?=
 =?utf-8?B?emMveVlsQVdaNEh0alBlMVl2K2QwR2c5UVVIUTFFZjRYeHdVZWtrZDgxa2g3?=
 =?utf-8?B?QzU0VzUyQkNUYzBXa0JpQUFlenFMQzhQK0hDSVY4K1ArV3A2dmIzczltRjc4?=
 =?utf-8?B?bmJFUWNyY2RUWG5ldWgxL055S1g4S0hsUEdCcnI2UEZ0L0ZzUm5HQ3B4YUty?=
 =?utf-8?B?bmlQODJLYTJBUnRLTGZDbkVkdHR6VVpNV1BwWTRNWmRlTTQ4YXBMbDBaVVEz?=
 =?utf-8?B?bkdxZ0dJNTEwYzBvdktldHBzYVpIdnBpc0RzeHhNRTF0YjJ0emxhQ3lYckVl?=
 =?utf-8?B?cTcveEg4NlllMkdnTHN1TTVKeWgyRnhoZER4MHVURitFYUFWRDRuYVFudjh5?=
 =?utf-8?B?d1o0RTU5Y1huNFZIbTQvNHZnejYweTR3UnV3Z0J3ZVdCVGh3bUIxc2xnV0lp?=
 =?utf-8?B?aFVlYlluOTlqZWRILzB3d0RRUVM0SC9xbFlCTTFzZEliSDBzYnZnRE5qeFZV?=
 =?utf-8?B?YVhCT1VXSGY0RXl4R1YzQi9tcTk3TkVvanJEOHpnOFZEY3ZmU0w0aEVETXpw?=
 =?utf-8?B?eFFja2lNNVVlblJsTS8rZ2p2ZVlNK3dVRk5YYm9ub3VsdGw5MkRXQlJ3MGVt?=
 =?utf-8?Q?SCcbZd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2VyMW9zTDBGRU54YTVZQkJrdldhZXdNUExIZGtDbnkzUFFUNjZZYWxSM0Nx?=
 =?utf-8?B?MTVwUTVIZFRqb3JMT003bE9kcFA0eEJ2M2d4OE9FMEpNcGJQWmZZNzcxQkNH?=
 =?utf-8?B?cDB2bmNIT1NtVFd1aXNDS2t2MzI4K0dvaVNBNjd3eksrOUdYWFR0V2FiTmQ0?=
 =?utf-8?B?ZUdrZnQwVUE3YitwM3NZblBYOW43NThSOFZJR1ZsMUc1SkV5NDh1RHRlTjAy?=
 =?utf-8?B?VGg4TkVyNkgxdktjNE1UTGs5d1pvOVlTbE10RlZPcDdxM0QzTkg3emZZTk5U?=
 =?utf-8?B?aHBKSnFHRld4aHk0S1lsRHFaOFMrNVdPa2pWSk9tWFZqczVrWHF1OTlJR1Fp?=
 =?utf-8?B?NmZUdDh4YjRZU2ZBRWdzdGo0VkVUeGlkUjJybDBDdzV5Z3dBVXhyL0h1NjVC?=
 =?utf-8?B?bjRlL01pbVQ1d3dLZnN0SkJ2U1hRNmdkUlFtNjJIbzFLM1d1WnlMS1BvMTYx?=
 =?utf-8?B?aUZqM1ZLcS9BTzhDbDBGU0szQXpnZ0hpWEhScFM4bmVkdG8xMTlBaUNDQi9t?=
 =?utf-8?B?Sko1OXZFU0pFM1d3blZKR1kyR0l3bHIwNVB0aTRzVTNNTWcydkdGWi9TMW1t?=
 =?utf-8?B?bkQ4dTFRa29Tc05vNmlPcXNRallYRDNBUnlob0w0REFBL2pOcVhwNGovMnhm?=
 =?utf-8?B?djVacUlXNWxvNUlkNnNTYnlTZGM1aVVQTWltdGZBZHdkc1RaOHc5WDBZWmY1?=
 =?utf-8?B?c2ROSFNQam8rbENDWmRHRjZHc3RGWmxnRFEyT0gxZmRxVHAwUEJ2RmVNS3E1?=
 =?utf-8?B?UW9SY2ZyYjJqSzNEWWZFbkEzTlpIV1pWYndZK2hYaElTT1BTVUpFaE9sdHFX?=
 =?utf-8?B?Umd3THJ0alVJSjlUL05TNkV3Skpvd2dlblpQRUZraHR6bGFvOUF5RVJubmJZ?=
 =?utf-8?B?K3NtajB4bC9jUWdHcTlOckZEZDU3WDlmeGlLTHEvSkEyMmQ1Mzc1YUpiUlZ4?=
 =?utf-8?B?T0lQaStwalZIaGZaUUdDR056Z2pPTENzanVoSlJpbjB4RWw0ZFRteHB6RjBO?=
 =?utf-8?B?SlRiUWdIQkQxUys0VXkzOUFvcDY4blgwckpVc2FMTVpUemtWcVBwM3JoTVVV?=
 =?utf-8?B?UlZRdjhFc0RhYnBueThLQzZRNHpidUx5OEVHK0l1bDJYTmN2cWFtRnVxdFIw?=
 =?utf-8?B?ZHJWTFY1RERJYkZuQzJ2Yy9aMnBCcHBtbDgwNjBlamwvMHkrWEM4TytmeDU0?=
 =?utf-8?B?cnF3MjUzUG4zaHFPeExSWGpvdzFmS00xbDJkWEFnL01sYWlBTmVwVk4wdTdG?=
 =?utf-8?B?ZGxwM1NDNlF0L0tNc2czVytmSCtUMlNzeHlYTWxlUjI3ZmhuaTVWa1BmVXBv?=
 =?utf-8?B?clhBdFRnckt2aHZQeWJqZlhwOW5oSHk2OUJJb2lWVEtRZzVjVWxvTW5oZk9Y?=
 =?utf-8?B?aFVNbGJhUGxyS3JUdGVYdmNZLzB3NmFIYUxHaVFqb2ZmWjgrdEk1ZnNwNUx6?=
 =?utf-8?B?WGd5OTM4dWY4OVo0d0RTdk1BWlhwWXlmUVc5ZzVhbkd2U0NNaGlFMHBOc3RS?=
 =?utf-8?B?aC9Db2hNV0l6OXlZM3FFa3crNTZXakIxUVlqWENyNFhybVJQWnZ6c3NRaEZS?=
 =?utf-8?B?Q1BqNEwweTZMMFZJd3dOMEFGU1BmQWZMOVFKUUlaTjR1azhxUW9jQk9KUlFP?=
 =?utf-8?B?R3l6b002S0hTcDRERWVYcGJLamtUTkZ6NEs3dFRIRkxZWDJYbnhTNnVkbzRh?=
 =?utf-8?B?SkdiZ3hsWGlhVWNDYkhpSG9meEhtVVJhMTdQNHA1VWhOVnVvSExuZHNJUmEy?=
 =?utf-8?B?RVJBVmhaYTcyUjdkSzBtVGlTWmZrN1lNZVpFOFJrSW9TVS9zNjllalBJeWc2?=
 =?utf-8?B?WUtkMXRXak9YVVhrdHRDN0hqMjFuTkc0V09YWlhUV3k0WVJTbFFBYkRiemFa?=
 =?utf-8?B?OG9vY1BuMDgzSjR3cVpGblkrSjlTSWFtM1Q5UUhuZXFjc1BzWUt4ZHhuVkhL?=
 =?utf-8?B?VmJDRXN3YmR0eUxFUWlOOGtFdXBNQlNhTTlhaUJ2bENaOVFOaFQvU1V2bEVp?=
 =?utf-8?B?WExJSHJKY09CM2daOXZqNllBY1VNclloWEEzR0UyMC9RZHNHK1pGTDNUS3JS?=
 =?utf-8?B?cWxFZENjTHBOT0Vybm16UnAveEpZWEVhNElPSkVlVGdQVXlwNFRzbVJBM0J5?=
 =?utf-8?Q?Yqq5riiYc6YeJ8TLKkfeUN0/Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8199a60d-fac9-44c7-4306-08de3641b5b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2025 10:08:18.2058 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhFksnAynPF8VmsQjcFpyq+SHXBbhcJL0BLJxX4VGlcYbV8GoQQ65nNE3v4u0Nj+zVZUx57FWCn3tf3agRCQIDMuAk34hnONXX8ahCTpM98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7517
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
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

SGkgU2hhbWVlciwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogU2hhbWVl
ciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+U3ViamVjdDogW1BBVENIIHY2
IDAwLzMzXSBody9hcm0vdmlydDogQWRkIHN1cHBvcnQgZm9yIHVzZXItY3JlYXRhYmxlDQo+YWNj
ZWxlcmF0ZWQgU01NVXYzDQo+DQo+SGksDQo+DQo+Q2hhbmdlcyBmcm9tIHY1Og0KPg0KPmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTEwMzExMDUwMDUuMjQ2MTgtMS1za29s
b3RodW10aG8NCj5AbnZpZGlhLmNvbS8NCj4NCj4gLSBBZGRyZXNzZWQgZmVlZGJhY2sgZnJvbSB2
NSBhbmQgcGlja2VkIHVwIFItYnkgdGFncy4gVGhhbmtzIHRvIGFsbCENCj4gLSBUaGUgcHJldmlv
dXNseSBzcGxpdCBvdXQgX0RTTSBmaXggbWluaS1zZXJpZXMgaXMgbm93IGFjY2VwdGVkIFswXS4N
Cj4gLSBJbXByb3ZlZCBkb2N1bWVudGF0aW9uIGFib3V0IHRoZSByYXRpb25hbGUgYmVoaW5kIHRo
ZSBkZXNpZ24gY2hvaWNlIG9mDQo+ICAgcmV0dXJuaW5nIGFuIGFkZHJlc3Mgc3BhY2UgYWxpYXNl
ZCB0byB0aGUgc3lzdGVtIGFkZHJlc3Mgc3BhY2UgZm9yDQo+ICAgdmZpby1wY2kgZW5kcG9pbnQg
ZGV2aWNlcyAocGF0Y2ggIzEwKS4NCj4gLSBBZGRlZCBlcnJvciBwcm9wYWdhdGlvbiBzdXBwb3J0
IGZvciBzbW11djNfY21kcV9jb25zdW1lKCkgKHBhdGNoDQo+IzEzKS4NCj4gLSBVcGRhdGVkIHZT
VEUgYmFzZWQgSFdQVCBpbnN0YWxsYXRpb24gdG8gY2hlY2sgdGhlIFNNTVUgZW5hYmxlZCBjYXNl
DQo+ICAgKHBhdGNoICMxNCkuDQo+IC0gSW50cm9kdWNlZCBhbiBvcHRpb25hbCBjYWxsYmFjayB0
byBQQ0lJT01NVU9wcyB0byByZXRyaWV2ZSB0aGUgTVNJDQo+ICAgZG9vcmJlbGwgR1BBIGRpcmVj
dGx5LCBhbGxvd2luZyB1cyB0byBhdm9pZCB1bnNhZmUgcGFnZSB0YWJsZSB3YWxrcyBmb3INCj4g
ICBNU0kgdHJhbnNsYXRpb24gaW4gYWNjZWxlcmF0ZWQgU01NVXYzIGNhc2VzIChwYXRjaCAjMTYp
Lg0KPiAtIEdCUEEtYmFzZWQgdlNURSB1cGRhdGUgZGVwZW5kcyBvbiBOaWNvbGluJ3Mga2VybmVs
IHBhdGNoIFsxXS4NCj4gLSBWRklPL0lPTU1VRkQgaGFzIGRlcGVuZGVuY3kgb24gWmhlbnpob25n
J3MgcGF0Y2hlczogNC81LzggZnJvbSB0aGUNCj4gICBwYXNzLXRocm91Z2ggc3VwcG9ydCBzZXJp
ZXMgWzJdLg0KPg0KPlBBVENIIG9yZ2FuaXphdGlvbjoNCj4gMeKAkzI2OiBFbmFibGVzIGFjY2Vs
ZXJhdGVkIFNNTVV2MyB3aXRoIGZlYXR1cmVzIGJhc2VkIG9uIGRlZmF1bHQgUUVNVQ0KPlNNTVV2
MywNCj4gICAgICAgaW5jbHVkaW5nIElPUlQgUk1SIGJhc2VkIE1TSSBzdXBwb3J0Lg0KPiAyN+KA
kzI5OiBBZGRzIG9wdGlvbnMgZm9yIHNwZWNpZnlpbmcgUklMLCBBVFMsIGFuZCBPQVMgZmVhdHVy
ZXMuDQo+IDMw4oCTMzM6IEFkZHMgUEFTSUQgc3VwcG9ydCwgaW5jbHVkaW5nIFZGSU8gY2hhbmdl
cy4NCj4NCj5UZXN0czoNCj5QZXJmb3JtZWQgYmFzaWMgc2FuaXR5IHRlc3RzIG9uIGFuIE5WSURJ
QSBHUkFDRSBwbGF0Zm9ybSB3aXRoIEdQVSBkZXZpY2UNCj5hc3NpZ25tZW50cy4gQSBDVURBIHRl
c3QgYXBwbGljYXRpb24gd2FzIHVzZWQgdG8gdmVyaWZ5IHRoZSBTVkEgdXNlIGNhc2UuDQo+RnVy
dGhlciB0ZXN0cyBhcmUgYWx3YXlzIHdlbGNvbWUuDQoNCkkgc2VlIFBBU0lEIGNhcGFiaWxpdHkg
aXMgZXhwb3NlZCB0byBndWVzdCBidXQgbm8gcGFzaWQgYXR0YWNobWVudCBpbiB0aGlzIHNlcmll
cy4NCldhcyB0aGUgbmVzdGVkIGh3cHQgYXR0YWNoZWQgdG8gU0lEIGluc3RlYWQgb2YgcGFzaWQ/
IEhvdyB3YXMgcGFnZSBmYXVsdCBoYW5kbGVkDQppbiBzdGFnZTE/DQoNClRoYW5rcw0KWmhlbnpo
b25nDQo=

