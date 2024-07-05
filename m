Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA60FC30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 03:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPZAr-00076I-Ru; Thu, 04 Jul 2024 22:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sPZAq-000768-T0
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 22:59:48 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sPZAp-0004WD-45
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 22:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720148387; x=1751684387;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Rvx++ozrrcS6ZE7l7Ql9n9Vnlo2/wHgV/ISFS0ci13M=;
 b=AKLjKd+kUZ0Z0dUmQMSJMX0RlWm1YptQTpuBgVyNsjsI0gKyUL+dXQ8m
 6IHUDnYRP8uIV4BIoRKwMrXwBXLdOARe0arzPNyqQBvf2f8ROjvsONBbl
 ONlN+kWYkRuz2biDrMULwMjrQZZYQZRpt272Eu7shGrTWGcynF7L/AyWi
 L8N8WvbF9M5u76LBmdiHYbByHAu434rZgx7J/DFLOlb6VD+1tAkBpdMjK
 usgc0nuWBuyp+2kRECVdHR0bXY1Dc7BoKR2WvI/Ludf6/13fflXDyfxeN
 zgqMy6tKBtPjRV9z6o1FZWGMDjicV8KTmgveec95vtW04EyGJYo0CN3ve A==;
X-CSE-ConnectionGUID: q4gtxVBJSQiUsAPAOewl6g==
X-CSE-MsgGUID: hm46LelFTHizjA/ECMi+sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="17644424"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="17644424"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 19:59:45 -0700
X-CSE-ConnectionGUID: Rl+pv/72QnKHEQ57mZDlig==
X-CSE-MsgGUID: JXi+HFI0THeVlunt78yeUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="51353257"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jul 2024 19:59:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 19:59:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 19:59:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 19:59:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 19:59:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+e6T5OpsCzDYuuN6TxwCk4U//yTt6CPW7ai+MKtHpRg1ySJjtqfMkH7CQvtiQZKy1KGu6+Ti/kdVzd243nZjYCotrC6Vb+RMeCDrMFndEhOd02Eu471770Hrar1p7Bac5CJvJThf980G/mNZO9T8yUf1O20QT1TjeTtyZQbY/cSPSjPHpEVz2+2l+ZGjBrnlqQzF+e+PobxM+GMYPv45CjwW73anBvKFuSQ7JZXPioWQHe18DAhlE/YAE05sfNGBw7EtVdc4VkXkMIvIIapdHoplHHFcfb5Z9d4twCdxjCJifi/bywafrnAOJVxHHNrtrQ5GlKM6kiWYJAm8OWGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZO38PRZKD2IvIqFoqkQ9WEpyAxB2VeVr22fGmUbvEw=;
 b=LJ1WwCDwt70+EHoR44A1/Gwp9mwnGk7U9B+cYmANvev64I/W6YzIa9UfLcRNBWJ55uiAvggzwUN9DSYAwjUEr3CD0li15+egXxIBzyQu6vsXU6F7pS8PY/uqOk/7pLOUqnVFGx/zuEv8llYh8xIo5MchItzGr1DpwejHfeV2UoMlsD3+n/Pkybz/BLEZZwYQCzuZ7TLYlAKzt4a3OLXIhGvBDcKhaP2cLEoXPAOmr9fXMWZHcNG5Ow6Nydj6QQfb9rxac2P3oFuniv/LhwqPFW3ZxO27MlGZmjDsoxVuKK5fwLZQXaJ1tslRbd9yUQaQvZR0hWp2OADT7SY6eaATTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB8076.namprd11.prod.outlook.com (2603:10b6:806:2f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Fri, 5 Jul
 2024 02:59:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 02:59:40 +0000
Message-ID: <311d4200-a5a4-418b-bc54-9f2c871235b0@intel.com>
Date: Fri, 5 Jul 2024 11:03:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] PRI support for VT-d
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
References: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c959c5-85da-418b-4679-08dc9c9e8331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFUzUmsyVXJ5UlJNZUFDb2thUFE4bXFCdHFrSUMzTWRKa0p1SEFQZlBUMk11?=
 =?utf-8?B?YWFISnl3UnRwVjRNQkZvL3NuT2dta283WWZ3OHdtYjM3eUlRak1QVzdTMk5H?=
 =?utf-8?B?czcwdVFDNmZNL0xPckhMQ1VHd2xTdFVXWFptaDJBMEtRcUpmVGtySEhFaTVr?=
 =?utf-8?B?SG1NelY2bXNVSFZqVlJIdlVWS1NWcUgrajZRZFJPQVNickI4L045ZTZpRUFE?=
 =?utf-8?B?eWhRU2R0UHJqdVpnUnorNytCc0pIRXUyNUc1MXREUXBaTUg0L0FtREsrTlpU?=
 =?utf-8?B?UnQ2L2hUQVNJRmFpSXRyV1dXa3I3cjNqenM4enczdmxtOTRLRkVzODRhd3Fu?=
 =?utf-8?B?a1I4QkgzekNiT1hmYnF4QzRjdFFQckc2Ry84ZlE3RmlORnNCTlhsamxwVXZQ?=
 =?utf-8?B?aEZoOXhCa20zWDRQaHl4UW9Ib3UxcGFXUy8zL080TnhRa1c0ZEdyZ0R6U3R1?=
 =?utf-8?B?NGlrbUN6VFk1ajh2N2VzRWRCbldLWWRzRWloaW1tRUJianRaMjJsSk5rVXh3?=
 =?utf-8?B?UWY4VGJwemdURVdJSjM1ZjBCWDQxbFFFRnJlUzR1R0V1R1pVRk0yS2RneXVq?=
 =?utf-8?B?SGptUlI0WDdvd2ppTDQ4MHU2SHVUN0VkZVFlRkVJbGhHaGRnalBUcnQxZW51?=
 =?utf-8?B?RTRPcU92b2hEUkFDZkNFcXpTbjV6R2pONGFKdWdManZ1U0twWEpmTHNjY2Mw?=
 =?utf-8?B?SUVKQUt0RlZ6eW4rT0VMMmRtNGd6UUY1Y1BheFRjM2gvSkdsVGNMQzZLVWRZ?=
 =?utf-8?B?bFJDWGdZYnV0dDB3N29sZk9Lbk93RUljM1FOVzl6Q1JqMG9ScG0weVhtVTB6?=
 =?utf-8?B?Q1BySTlkY0kydkJOTHd4RU1BRzJlRjR4YTZBZ0taM2xNOU90cGVJWVIyMGsr?=
 =?utf-8?B?QXM1cGNWVEhXcHRCQ0x1MTBOdWlCTjJKTG5NMG1EUmV4R2xQMTQxT05Mb1RY?=
 =?utf-8?B?NklLSDY2V3pyRzBrZWJBT1d3VnVwTzFBbHMyMW1Bb1NENy9lS2ZwVFlITFVa?=
 =?utf-8?B?UzNFTDZERGFINDgxbGR1YStyblE2QTdsbHRDMW1BclJlbDcxQk96ejNDNEUr?=
 =?utf-8?B?YnY1R1R6NldOSUFDdzdxVklEQThWQTJmNFB3aDU3b0VwSlM3U01wTStvWkZU?=
 =?utf-8?B?UGVLWjM0NElFWXNVRTIzak92TXNQa2h2a1JKUXdNaVJIUnZkOFYwM3lvNnlh?=
 =?utf-8?B?QURmMEhNanl1dFU1NkRxU3hJRW1Yb2hKWjV0OWtSV0tUNmV0ZWxFaTFDY05Q?=
 =?utf-8?B?ZVVod1puVTRFeEdHK0kweUZpT1hxMWlqYW9rRWp6Z3o0M25OMnVYaGhZK01C?=
 =?utf-8?B?VVNFbDRVdW81Z3ViY0FDRXNxM0pZY0d5dTlYbCtubjdiVnBtQUtmNndMYXJq?=
 =?utf-8?B?Ylo0OU0zOTZIemFDTWU2c250ZTQ3WVBoSjVLQ0h4a28wV3BmNXN6bG43cG82?=
 =?utf-8?B?SDFmanBmc0JQd09KZTZMZjduUWpBamQ3KzJ5S091UUlzZVlTQnNWc2N0Ny9q?=
 =?utf-8?B?Ym5UYmtvenVBVnFoWGZjN0NqR3VJSGUzc1BTUklYSm4rdUFocGtJT1lRU0V2?=
 =?utf-8?B?L2tOaUFBN0FSbjBRaUhHaEhnd21KMGx4UHpPUzQ3RkhnZlA5TEZ3b05VSnlU?=
 =?utf-8?B?UlhmZ2lxaWdDb2ljdm5sK2ZQSUlaU3V5cEwwcUZtd2NlaGovdWFIb1REUDRi?=
 =?utf-8?B?VkR2QThhV2VPYVRUdXlxVjdGQWx0ZzErbkhNWUl3Rjgrb29jTjF3YUpyZ09r?=
 =?utf-8?Q?ETtgJp0DqJY4TzLEP4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2lYaktUYnBlek9WMnIzcEdBeWlIdFRvRGRPTm5zVG5XUFVicW90ZVJkVjNR?=
 =?utf-8?B?MkpTSFJjeVhoV1JjbnAvaitScFdiN3grcHl6a3lKMHpnWEQ1dzRuczhORVdP?=
 =?utf-8?B?WUNjZGtqbHV0NHJFekZMVHRmazd4NkVlM1huYTduRXV1TUlLbDlYblBvaXIz?=
 =?utf-8?B?UW8xeFpUMmdzN2FKSlRVVzZxOVN2SGZpTEsyUjFiQ2MzU3p3Wk92QTV4N09V?=
 =?utf-8?B?KzFibzBKMEpwY2dwRkZBRG5UaWNxRExkUVgzY2ZqVmdSR1B6YXVuZmg3dVJZ?=
 =?utf-8?B?cG81Mi9DdjNkRWFlQVF0L3FZVXB1SWYwZ0ZtN2tjZ2hyT29GeUdoaWpudnEx?=
 =?utf-8?B?aSt1bWdNR2FKMk5TQUhMZ1kyTGZ6THpwSFcybVZGSElQQ1ZITVI2ei9XUXlI?=
 =?utf-8?B?M0kvZVd5Y3dISk1aYy96azNuWkhuNHV5VUNxalJ3N244Qm5hUU1nL1BXQUR0?=
 =?utf-8?B?dDJ2Zzhsc3o2YjBScEZNTVkwTzlmMmlIZlFHanZvd0lPOWF5ZmMwZ3NzQzhm?=
 =?utf-8?B?VS9rVU9WTjhCOHRhR0JYMEJ6cUEvWkV6YkNSMkVEZVNsMW5mM0wwZW5wVTRT?=
 =?utf-8?B?R21Ca2dsRGRaQ1JlVHdYZ0JBUGp1TlVmTFEwZlBUd1RWandmYmFXRS9heHpG?=
 =?utf-8?B?cTlEQ2dMZXNqOVNhUHowZHY2OFRTeDJxb1hxV3lta0RrU3V5Q1ZtKzdlbGQy?=
 =?utf-8?B?cThVYUZkUHQ0K2xzUW1vU2pndlhrdVdtMEFmUml6eHRCZG56V0tsUHJlTDBt?=
 =?utf-8?B?MzZPMGlNZEhMaFJlMFdMVjZpQksvY1cydXhQem9JUjFhT1pWNUxVWWxrbDRG?=
 =?utf-8?B?WG90NGd1MytPbkNkWnBhUlgwalhCYnRramZLclFxMmZxTEQ4QzlMaHlqZmRm?=
 =?utf-8?B?RTU2M1RMdHU1WlE2Q1NPRjJGR2RJS0ZRMUkrMTcwQ1p3dW9aWXIxcDU4dWRn?=
 =?utf-8?B?N09yUStjWUlzb2lRenlhR3Y4d1pPQlBBZFhIQTZsZVdxUVllV1RFeGVxdUo0?=
 =?utf-8?B?SkI0R3EzYS9GbnFPbGNQSmlYR080L3ZaSEk2SnJNTW5reVFOSUYzTzFNdUhK?=
 =?utf-8?B?eEFhSDJWempHWU5xU3B0QUJrdENOK1hoQUFnd2dUOXB0b1UvYi81RW9PS2p4?=
 =?utf-8?B?emRrcWJRZkRBSWQrMkNMUTJLWkVvWXNibTA2c1ZxVU5ySElzMVVrQ3hIanZr?=
 =?utf-8?B?RElxc2F0dTFIQ2tpc3ZMZ21mRnQrMkVBMC95TWowRkdDSnQ5OFNvLzl2UHBL?=
 =?utf-8?B?SkZtNHF0MmZESnVUUTYvbVpYZkFtRVVOR1VBMUpJM3IzTTcxekJZd2dvWGg1?=
 =?utf-8?B?WmhXa1Q4dmcrYVZsQk5XSDN5WjNhei9kMGNkWkVXMG1vU2VYS0hQNFJ2WTVC?=
 =?utf-8?B?UlFodzEvWmM2UFRKbk50azFKN2F0N3BZcWpSakdmdUVuaFJzZjl5NW5Od1oy?=
 =?utf-8?B?YUtyWjJQczlHN1BGelVkaitseHhLMEhrMmtXeFhGQ09oQ2ZUSitua0NMcWZs?=
 =?utf-8?B?c3k0Z3Y3UndkbE83NGYvTkthZnBWWC9SeXIxY2p3bXNaSkZhd1FnQjRSbXE4?=
 =?utf-8?B?RGZOb2prVDh6YzQzdjlyRk9oQmZLQmhGS0RUa2lFWkhjMndEMSswQkRyaEdi?=
 =?utf-8?B?Rm1PQSthZ29ndk40d3M0enROcUNzOFc0bFE1R1dWdVhZeDU0OXFvZVUrbitj?=
 =?utf-8?B?TzNFcUxYUDFDNWpyVFlsOFMxb05ZTEtHRExGdXo5MGhSVGdTakV2WUloZWFS?=
 =?utf-8?B?N1ozQ0hrRjJ1cU9ld3h1ZGwwOEFZTzVzTmtBYmRPaFRFQXpjMzdMNzRZZmtI?=
 =?utf-8?B?VkhMNTRIMVV6MC9Cdi9CUkI2VS9YOHI0QWZ3R0NCaXp1N1MyaDhwVXJRUzht?=
 =?utf-8?B?VC9mQzJrRFhOd2NQeVY4RDNRRDhVVkVkcm9rbDN0ZWxjSUQyaGUxZzVweE5z?=
 =?utf-8?B?VFZuR1NIYi93Kzc0cEhLTlloSStLV0dQTGtOYXlpcGsvNmVNN1FxVWo3eUtG?=
 =?utf-8?B?ZGU0c3laMW5NSWpUWWthT0xGdnI0MDBjQ0ZIQzkzajBsMFVkbzZzekFVWHpR?=
 =?utf-8?B?QjJRSW9NeVNVWVZDN1ZqSGxaRUhydkk5MUU0U1BtMm5oTWtwNFVQeUs4UEVU?=
 =?utf-8?Q?U1i69+rV5aoZdiT2Iq/W8WVHL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c959c5-85da-418b-4679-08dc9c9e8331
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 02:59:40.2308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkwsuEyFYYqOlULRiseGOZ+ZHWpoz07KNHkDBIWEPUdXW5hnYuuD+jdEq9pMu8xA3/srfyLsdPo4U/qMs4ETOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 2024/5/30 20:24, CLEMENT MATHIEU--DRIF wrote:
> This series belongs to a list of series that add SVM support for VT-d.
> 
> Here we focus on the implementation of PRI support in the IOMMU and on a PCI-level
> API for PRI to be used by virtual devices.
> 
> This work is based on the VT-d specification version 4.1 (March 2023).
> Here is a link to a GitHub repository where you can find the following elements :
>      - Qemu with all the patches for SVM
>          - ATS
>          - PRI
>          - Device IOTLB invalidations
>          - Requests with already translated addresses
>      - A demo device
>      - A simple driver for the demo device
>      - A userspace program (for testing and demonstration purposes)

I didn't see the drain PRQ related logics in this series. Please consider
adding it in next version. It's needed when repurposing a PASID.

> https://github.com/BullSequana/Qemu-in-guest-SVM-demo
> 
> Clément Mathieu--Drif (8):
>    pcie: add a helper to declare the PRI capability for a pcie device
>    pcie: helper functions to check to check if PRI is enabled
>    pcie: add a way to get the outstanding page request allocation (pri)
>      from the config space.
>    pci: declare structures and IOMMU operation for PRI
>    pci: add a PCI-level API for PRI
>    intel_iommu: declare PRI constants and structures
>    intel_iommu: declare registers for PRI
>    intel_iommu: add PRI operations support
> 
>   hw/i386/intel_iommu.c          | 302 +++++++++++++++++++++++++++++++++
>   hw/i386/intel_iommu_internal.h |  54 +++++-
>   hw/pci/pci.c                   |  37 ++++
>   hw/pci/pcie.c                  |  42 +++++
>   include/exec/memory.h          |  65 +++++++
>   include/hw/pci/pci.h           |  45 +++++
>   include/hw/pci/pci_bus.h       |   1 +
>   include/hw/pci/pcie.h          |   7 +-
>   include/hw/pci/pcie_regs.h     |   4 +
>   system/memory.c                |  49 ++++++
>   10 files changed, 604 insertions(+), 2 deletions(-)
> 

-- 
Regards,
Yi Liu

