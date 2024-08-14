Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F68C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 11:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seCNu-0000Jm-Va; Wed, 14 Aug 2024 07:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1seCNt-0000II-3e
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:41:45 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1seCNq-0000sH-7y
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723635703; x=1755171703;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NmMh3vBszu3QBYN3Dved+rsv1Q5RUJgF2Xbf5mW2JEM=;
 b=VWt+Q5ovN1jtaHbu2scDjhA33ttixsbsBkOm199RN9MdogKbW1Q60zsm
 QK5vyuBxDOskIVoIvd5YUzFVYZVvJ/Nt0kxy1vEpwsjj04Wy5srvVwGGf
 /9RTmhqOapEycnKC/GfRRaq6ZjqLq55m/sg9X7a8oT6yMHcqBSdNDwNnA
 9tQbBne3vtQHVuR1HXBsK0qxxPgoyL7yiws2heqJMozEt51nUE98QWpnU
 wWIOZNxjheC5Z+/OrVPBQ+BNrBNxALf6Uigt49IRiWUB0MDcfqRdKgfja
 7UW0uItWfILrUV/9uGYo+2DE6VoTUjVAO82jyUPZIYTcl5BIv4FBqsNdX Q==;
X-CSE-ConnectionGUID: nWnzmirMQUWMms+Eu/E8+w==
X-CSE-MsgGUID: m+1GfkOAQPqpwbCqETUptA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25605603"
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; d="scan'208";a="25605603"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 04:41:39 -0700
X-CSE-ConnectionGUID: Zms902B7TB6+oh9eYJZ4qw==
X-CSE-MsgGUID: KkeBO6LURLmlpywuL8eCVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,145,1716274800"; d="scan'208";a="58618051"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Aug 2024 04:41:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 04:41:38 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 04:41:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 04:41:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 04:41:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZURgYb1KAk0vuT7Ex5/oC+GpSTx3GnNHh5bzTgHm7g8y/JgazAVzQIefbxIWegrisXKz4hJjsOFMs/T7gHxV+72aqKfB5I24HlLNNZletJgCjnCNJ1bm+etWiBnWDAtBsi9BNyIIB8DPfaL462pq0uqojbxDGrt7IPkN60cUmu96lQACnyTAcWq8U7thZHF+MIA0ivhh3EU+SULu5QUDA7y4nuaHlx3FdqM0Q8IatWnd/OtBMUXa/bj+wZZy4SLpGPbUpgXspcOCqCwyhl1zToEVrUzUBO/tQbJHAsXyNUWenS4I7Q55kFcl92JOwqG3IAweeOX7qu/Km4O8dNjXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7wn69i/w4HDfYo6RHw+Huq1OWvRPBIzl3vukZWBOBk=;
 b=vUAZJdPG4Itft7J4rM5pQjrPel8jgNE3+Rp56Nj8du8hhsfG6sIdSJRkCBhaDzRyzolpO4meHQKBLBMijcOM2iyDV8ErZKPrrFvwutigUlHp1rul6+HowtWz9Byite9VdvCiNvmgkmKzoGkV1Cadh+zbH05eeM4UX0XqoFjwXU9abVb7nN3DNmnYCpuBe8xzEdqBAsWqV4K83rCsI1ZulS/u0ARXV7cHzXBWC5hnTPL6M9LRjxMBYDKsd4KhqDiopD5rCEjzzvKo3fIGRdbw854I0jLQ/KY5SdAKoj3DiZkaJDHOv8/g4DCXMuRR7sKkinOFgeLQXHeyH6sv9Si1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB7913.namprd11.prod.outlook.com (2603:10b6:610:12e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Wed, 14 Aug
 2024 11:41:35 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 11:41:35 +0000
Message-ID: <516fa8d2-ac16-4f2f-b7de-e5ac6b6d8663@intel.com>
Date: Wed, 14 Aug 2024 19:45:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-9-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240805062727.2307552-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cc9056-b087-4925-6760-08dcbc560cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXcwc3Y2Yldrb2xpejMyOHMvL1drMFllU2I0ZDVtaXpjaktKaU5jMnpHZ0Jm?=
 =?utf-8?B?dDRXc21lMDF0VVVqRUZ3UTFOeEt0OWJJV1dOV0hGWmtvSURyMVVEdlNkd21N?=
 =?utf-8?B?c1Q3eUxNRVVUM1M4Zis0NG9qRGRycmVsU2lBMCtRVFg2K2ljNFB6Z294djdC?=
 =?utf-8?B?cDdDOWZWNy96a2xHUEdGc05ZdVBiMTdySTR1Ui9LdnEzbVFOcTNMbTZKWmY0?=
 =?utf-8?B?c29JKzRwa1VGdnZRRmhnWWZjemx1SlNBZCswVTMzUGd2Z2E2TTd3MU5vVk4y?=
 =?utf-8?B?TEM1bk9IUVpFMTY0bmprQWhUamxXcmZBNFVKbW5NVlY1TEd4RWtuSHQrSGU2?=
 =?utf-8?B?UVBNT2FZTzdRM2lqTWFKcDg4UjFwQzhOcmVqWTJXd0kyNjliaVo1Skpaem1Q?=
 =?utf-8?B?VmdPcUtTYmVEWFVTWS8wN3hkN3ZCalRCRldGV2JMQ25QVjN6ajV1MUswcHNF?=
 =?utf-8?B?T0ZDNm9IY1hEN2RTQ1QxV2Jmem1vSHJxVjJ6MUNxM205dlBYYlRRYlZWZHZj?=
 =?utf-8?B?SnlreGNHbVpWWkQ2ZmtMVVVSV3UxaGx3ZTNDekxtSGVjRm0vRkVpZHlvUmgx?=
 =?utf-8?B?S3pTa0NJSUxNMzlFazlOOFFGZUg0MTQrTVBDdHhIVFM3d1lTblVpSkVxbWNF?=
 =?utf-8?B?Ri9lMVdkOEVYd1k2S1prZ21jR0hrTjBkN1JtN0IrVmFoaWkweGtwUTVmVUlu?=
 =?utf-8?B?WmZKWmRWQ0ZWQjlsSWxjeGNTOTlGV3RzOEVObUdsT240ZnZaK1RFZ2Jkdzhz?=
 =?utf-8?B?UjNPeVRSNFROTTVWcWV1YW0yOUxMZGNPa0p0aDJRRmRpRjRCbGhGOXRNNXJG?=
 =?utf-8?B?Nmk5a0REbk1yT0JnSEZhK3E0dGwvcXUxdUR5MisyNTd4K01sU2twQnMwM0lr?=
 =?utf-8?B?aEttQUZWbnRDQWZ1dWx2azN2amtHY0l1dENNaFVlTjYrK3RiL2xEeHJqWGt4?=
 =?utf-8?B?NDFlOUl2U2piN2ZGSlg2UTFrdXAxR2wrb09zbG5JMUduandJd2dBUVRxT2xr?=
 =?utf-8?B?ajZxdEZmQWhOZDlJeVZhL3VvWndjeVdWSk4zNUlEQ0hvK29vSXVCbzNOd2RZ?=
 =?utf-8?B?aFNyYUZST3RPb1ZvVElRNGNoc1FmY2FJR01tTzJVMWM0UFUxQmJpUzhjUTBo?=
 =?utf-8?B?UzlHNG00VFJhZ2VTV2hiTlV4dW56NEtoRC94N2RueWhzbUhLaU8vQXd3YkRD?=
 =?utf-8?B?dTI2aUtkUnpDZWsreGFTYjkyczFtOGxMaWpRU1duZnNOQ2hPSGJTSmhRcGZV?=
 =?utf-8?B?VVRsQWF4eURRUHQycnBrbkJ5RDVkd2lMN015d1BMeGlXdGJQUUExV2didzlI?=
 =?utf-8?B?S1E5bkhXM0ZrK21HOWRDWXJLWmRyQUl4Y2IvalJhRFZmTnlPbjFadmdsaU1j?=
 =?utf-8?B?ajlCK3BmdGxRREs5Q096TG9jMitsVmc5YmhDUGhTU0FzNDZSWHYxa2VVQXhR?=
 =?utf-8?B?ckZBSjI5UVRqR1BGYXUwZnBPZlJQWjZWRUZJTlRaRnRnNTdjc3Q1T280M2Ix?=
 =?utf-8?B?bDV3N2N2UDBKN0NTWFh1V0pSbHd1UzdjOElwaU5yaUxGbG1yK2tLQ05ZSTFi?=
 =?utf-8?B?cUJvMFIrYk1HZGlDaGtPQ255SnlUUVBuRjhjRnVWYWc2akF2M240ekRWZzU4?=
 =?utf-8?B?cWZiOXZuVFBRMVVoQ292Tjk5WEJic3RUeGdJUHl5WG00ZXBoWkp0OUplOElD?=
 =?utf-8?B?WEFzNGxHWGgvWGJwRFR6TjJ5aENQTTFxTlVjd041MjE4YURGcDBPWEV4VmJG?=
 =?utf-8?B?SzI5a3RDSTJZMmd2Ty9MVG4yVUQvR2IyOEFvQzIvUTNRQ3IreU1OdFZFL1RR?=
 =?utf-8?B?NDJCYnBLT0xueFZqcG9Xdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmYzSGxZUGNzMUNWT0JpMzZnRTlnRWt6UGYxdjYvZW5wK1VXQ3FUUVZQOEhU?=
 =?utf-8?B?UWhvbERrZDRFMWFtT0ZYYjFXTGxxWDByK2FhV1FjeGlsOVdYOVU0OWhDRlYy?=
 =?utf-8?B?SnZwMlMzVlA2T3pjOXM2Y0pxeXI4NGVCbVpKZDlpVGF4R2R0ZmE5U1Y1cnVo?=
 =?utf-8?B?RnhFWm1JeWdxVkFIUnlLbXFVSTI1YVJtYld5d29GeGI4emhpNkVRVVZtb2la?=
 =?utf-8?B?Z3pMNnBkRml1Z3VEZmlNZ3QrOTdDbnZ4aXlyZFN5WXpWSzQ4MzVNM0xtVVBG?=
 =?utf-8?B?cHRQaTU1Q3N2ckJoczdTUnlhUHFPY1dGUkJuR0t0c3dEMDN6N1dOeWl5M2Fp?=
 =?utf-8?B?bUJqVXAvRjdDY05GK2tHblFuMVhOK0lCNlpHQVpsb2dwb0JGb1o1RlYxbERZ?=
 =?utf-8?B?cHpnZVNDdy8xU2VRbHZ1QkFOM2RndVRQVDZ2RGNLR3o0NHRrcDBBTnRJTUdm?=
 =?utf-8?B?SDB2UjAwRTNtR3ZyVHA0alhqOElkSy91TStwblgwd2EyVjdzREZmbnpscG1E?=
 =?utf-8?B?NWpGMENhTjZuYkJNeG02ekRmVkpUKzhvVXQrYytldjQ5NWQwQ2xDWFdnTmtw?=
 =?utf-8?B?cW9JNkRScHlmWFFYQ1htNURGZDFHWlB6RTZISHZLaWcyQmNEY3QzVUI0ZVB1?=
 =?utf-8?B?YzNiYTl2TEZxeEw1SmFyOTZrci8reXFFMlptUytwRSt4K2FVVXhHVlVsOVkx?=
 =?utf-8?B?Rnk5c3pZczN4MFUxT1RRVUhOcGgvNXJOYlJjcW83dEpNQlR6d0YvNmloaHRX?=
 =?utf-8?B?RFh1eG44Q2EzTkZjQkpadk50dktKSlhrbS94SFA4Ny9hcG9lVDhXNGJ5UHRl?=
 =?utf-8?B?cmxkcTk3K0tiZmFFZFczSVloVm5TdDJ5RjFhWVUzMDZOcDNGQ2cyNjVSNFJT?=
 =?utf-8?B?SmpMdUJrc0dZYmNwMVRUbWRGUmhDRWoxRUp1dEFyYU0xMWh0STJIazAwM2cx?=
 =?utf-8?B?U0swRDF5eXFwcFNMOHRpQlhYUnYybTBCSTFtUjlncmRSbjF1R2JZdmJabmwr?=
 =?utf-8?B?YWJvUzNLRGE5c1EyUGdSWTU1QVhUZVh4bjhYclhiR3M3ZVJERGFUdjUybUl2?=
 =?utf-8?B?ZENkUU9hL044ekMzMmw0OFc4RlJaS3hSZTJOYThVZ2dyMTNEOUdRaHFZZi8r?=
 =?utf-8?B?TUVnYnF5dTByS0loV1lnMFl0VXhjb3ZkYXducHVxUFREUGdvbENLUzZRVWZK?=
 =?utf-8?B?V3NMOG5SdUwvZTBtSEJ3aCs2UUtzSTNtd2NxQzRJQ0FzKzBiWE9FaEp3Ri8z?=
 =?utf-8?B?Y1hDd2pLOU53S0FxRVpEV0o4ejhJamhieUxhY1NneFVQU0h5dkhlc1V3Sm5O?=
 =?utf-8?B?cFFUZHQ5MGZvZzF0ZjZRQzZqRnN1U0wzZHV6WDQ3Y3YweU1IYzdKRHNvNXlj?=
 =?utf-8?B?MmEreUJUUHBGL245TmdXNW11ZzVRRjA5cVFaRkdDL2JEUFBYeDhCN0NpK1kr?=
 =?utf-8?B?NUZYa0RWWklWN2I4VzJsRjVFcy9LM2NtOGJSTlgvelJUMExMVUxVK05nYmNV?=
 =?utf-8?B?U3VnbzZEZHJOMTRLMjMyYmZWQmxtd1FuYlV5WDFTTHltdlVJbjhTdjhpNURr?=
 =?utf-8?B?UUJOWkN2SHpzS01vMUJUTUJGK3hmMFZnNnJJYmtOcDNrUU8wbXZWOHBrbGtl?=
 =?utf-8?B?VWIzK1FpRDJqS3VMNFFseEdZeU5Nb0lQRWtGL0NhaTZJdkFXVWY1WVg2WWdJ?=
 =?utf-8?B?RWJ1NkJFdXhLQnI5OUhZSCtiYkZqMjVld25sWEltcE9ZSWxvUElnWTkyNHgx?=
 =?utf-8?B?YUo1ejRvSXdBVWlCcGk5ZWpPM0Vwb05JM0dpa21wa1d6WVlZTGJPQlVUVk12?=
 =?utf-8?B?UUMyeEY2OUZhUk9QTVZmVDBXbVlSYWxWamN5UWFUck5lOXB4R0lwaktMbWtD?=
 =?utf-8?B?ZHlwNXBQVkE4akJlUDI1V0VCcGZ3aGNSWUU2b2pLcjN3TG1vbWNWTkxXcDRF?=
 =?utf-8?B?MDl3TU8raGlpUC8ycno5UnlaU2xkOTd2VStjMHBTN3lnU2dqZklKYWlQSlAz?=
 =?utf-8?B?U2hvTWF5dk0rc2ZCd1MxMmp0OHQyWmZ2Y0VtV3cybVF1aXNsZlV5a0ROZjNq?=
 =?utf-8?B?bC9RN0MrQXphZ3VSQUhTamJjWGNKVFlGMG82N3RDVW5OS1E5ckhHV3RiVGk2?=
 =?utf-8?Q?XHV8OeLT0XsnIPq+qR7R+0stB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cc9056-b087-4925-6760-08dcbc560cff
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 11:41:35.4370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qC0VwD/4rOjxhSC2ToMl6dmj3YlhQjvksx38daHhn9BHEz+Mc6kiwgRwlzMbfzTzAZwADP+/R8lucSBYe2QlEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7913
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2024/8/5 14:27, Zhenzhong Duan wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  3 +++
>   hw/i386/intel_iommu.c          | 24 ++++++++++++++++++++++++
>   2 files changed, 27 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 668583aeca..7786ef7624 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -324,6 +324,7 @@ typedef enum VTDFaultReason {
>   
>       /* Output address in the interrupt address range for scalable mode */
>       VTD_FR_SM_INTERRUPT_ADDR = 0x87,
> +    VTD_FR_FS_BIT_UPDATE_FAILED = 0x91, /* SFS.10 */
>       VTD_FR_MAX,                 /* Guard */
>   } VTDFaultReason;
>   
> @@ -549,6 +550,8 @@ typedef struct VTDRootEntry VTDRootEntry;
>   /* Masks for First Level Paging Entry */
>   #define VTD_FL_P                    1ULL
>   #define VTD_FL_RW_MASK              (1ULL << 1)
> +#define VTD_FL_A                    0x20
> +#define VTD_FL_D                    0x40
>   
>   /* Second Level Page Translation Pointer*/
>   #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6121cca4cd..3c2ceed284 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1822,6 +1822,7 @@ static const bool vtd_qualified_faults[] = {
>       [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
>       [VTD_FR_SM_INTERRUPT_ADDR] = true,
>       [VTD_FR_FS_NON_CANONICAL] = true,
> +    [VTD_FR_FS_BIT_UPDATE_FAILED] = true,
>       [VTD_FR_MAX] = false,
>   };
>   
> @@ -1939,6 +1940,20 @@ static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
>               );
>   }
>   
> +static MemTxResult vtd_set_flag_in_pte(dma_addr_t base_addr, uint32_t index,
> +                                       uint64_t pte, uint64_t flag)
> +{
> +    if (pte & flag) {
> +        return MEMTX_OK;
> +    }
> +    pte |= flag;
> +    pte = cpu_to_le64(pte);
> +    return dma_memory_write(&address_space_memory,
> +                            base_addr + index * sizeof(pte),
> +                            &pte, sizeof(pte),
> +                            MEMTXATTRS_UNSPECIFIED);

Can we ensure this write is atomic? A/D bit setting should be atomic from
guest p.o.v.

> +}
> +
>   /*
>    * Given the @iova, get relevant @flptep. @flpte_level will be the last level
>    * of the translation, can be used for deciding the size of large page.
> @@ -1990,7 +2005,16 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
>               return -VTD_FR_PAGING_ENTRY_RSVD;
>           }
>   
> +        if (vtd_set_flag_in_pte(addr, offset, flpte, VTD_FL_A) != MEMTX_OK) {
> +            return -VTD_FR_FS_BIT_UPDATE_FAILED;
> +        }
> +
>           if (vtd_is_last_pte(flpte, level)) {
> +            if (is_write &&
> +                (vtd_set_flag_in_pte(addr, offset, flpte, VTD_FL_D) !=
> +                                                                    MEMTX_OK)) {
> +                    return -VTD_FR_FS_BIT_UPDATE_FAILED;
> +            }
>               *flptep = flpte;
>               *flpte_level = level;
>               return 0;

-- 
Regards,
Yi Liu

