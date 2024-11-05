Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58013D1CA2E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 05:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8CUA-0004xU-9f; Tue, 05 Nov 2024 00:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t8CU8-0004xM-UM
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 00:52:12 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t8CU5-0006EW-EI
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 00:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730785930; x=1762321930;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xo9YkMl44iOru4OWatcu39idLl/7alAK3oJybR0WHZo=;
 b=FDCAkVmBcUqB5SP98BD6E8HfMZVcy3vIPAVgSq96ymLfP0UAOpoaTCoo
 vlLGTymi4UyVUcSs6dMHyyXpkEDAHTBqOPD/bNsPBViXprUd8lFsrBjAw
 KfYnJtjuPd1kwD3jjjKjl2xAb5GVrA7HozlHi52/BnKz7YBMGSHmn1Wae
 X+tp+d8FjYFLPHvIDaLL9yblzbi2kIgchASp3NsYZnYtv1mzb+ehf1bRx
 SpvYXwP3hLdZQw5pjKYe5rkgA0CZ1gmmaZaygbzKvf9MtQCrhqw8zlKKy
 CCcF3emSweuY1x5Y8hXXvZuL7tQd9hmuG+/ihtnlhyPCZYwLH5pf1a3LZ A==;
X-CSE-ConnectionGUID: /2T+FG05RKKBFZXK5Dry+g==
X-CSE-MsgGUID: 5PMUlWo4RMWvbZ8zedw3kA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="34296604"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="34296604"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 21:52:06 -0800
X-CSE-ConnectionGUID: DGbhCBR+SxuRd4EU8tvPgg==
X-CSE-MsgGUID: 2/Jy+mywSm6/UsHsP5v5vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="88447643"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 21:52:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 21:52:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 21:52:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 21:52:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iX4LxeKBRqK9C8SXSItbItyvMY/QReSoVauUEt6HoKCjqNXbePEvwEinR5vccFRFWneyQGU9alYNYHXvO14lKWAQ09DpMmi/zJv1Y2jHuFvDJcS7EGyGZBigMOhpzJFTMjpz5vke/xR/OjD0+3PgHKwOX2ze0yJDCyqG/m22YCMmjhsFjAFMaweIWAG6GxhfoXV9e62zLheUTEkKd7wXcMj7mQC4g7OtoZzBz9U+KutXi1nVYQ89nmztHwD5vzXW5DV+DdI6XLeEIRz6+YO0psvvLkIYazHKjgqjGzmo2Fnf11SvE8XalCXJiwtOqUtjm6yL8bUUY0+wygRmcrZUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azJfzZhEcL9pbYvG1sRo5lXUlCwOxpOkqHiRW+R/Hxo=;
 b=o+iOMC54Gs3uFtQ+lopN6Kub+Q5qDQi5VbZI8t8Jtk61EkT5r5bOkwBugVQ+zabNXu1vedgvWjiteuTNmZYZURDEUHD9s2slDjwFz8bowNpG7icS1sWfPuKIiwprEVRhyhgruLeI2aiZtPApvOjdoldUBCeiOcyMXYjjbyWrBJRf/Xil8PZ1nRZsLhjPlAMWD28RZZT2OntWlmCHZevUVlQvv3YV0RpbsYS5sC03GKiacpUWzCPG/7tcgb7+Two6eRvSrcP08fdu7oi8rPZBneHuxbA+HIxb9TI6OM6yC3VpCBuwEKhkixnK6BcX4EMLCpc5939KVzu3rNPx4pXgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Tue, 5 Nov
 2024 05:52:02 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 05:51:55 +0000
Message-ID: <0780dca7-d5a7-4554-abf1-0cb92d49a2a1@intel.com>
Date: Tue, 5 Nov 2024 13:56:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] intel_iommu: Introduce a property x-fls for
 scalable modern mode
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-16-zhenzhong.duan@intel.com>
 <5cbe6426-e64c-45f1-b276-c7dbb70ff3ed@intel.com>
 <SJ0PR11MB6744F2BFCE29E91D6180609292512@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <df02d9d4-3a54-449f-8d99-cca10bd28cf5@intel.com>
 <SJ0PR11MB6744C2B6BF0942C17720B23B92522@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744C2B6BF0942C17720B23B92522@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 78da4700-01b4-4ec1-330f-08dcfd5df42a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejRiZkJtWGxsWTY0YXRwa2VVYUVNT3g0SHd1cnZEVnd0Tmk2TjlyNVBhU3V3?=
 =?utf-8?B?U2N0WElGNW1LU0k4K0FjSEVzNHhoZkJuZ1VZdkxzRnBCSmlreDVHMFhIZ1B4?=
 =?utf-8?B?Rk5JclhZaVhrZDdQYk9LbTU3UXI2TVdlTTV1REJXK2hDbTBZQzNhNkZxOVp4?=
 =?utf-8?B?VElpb1Q0a3RPU2dIdjdYdStPeW4zVkVQaS83VzRNWFhZekp3UUhxWjc4UWpY?=
 =?utf-8?B?NHdGU3ExbzV6U3VtSVRoZk4yREFvNW9oQUF2UlBFenhNaXNmKy9TTW5xQjB5?=
 =?utf-8?B?RTlRQXAxcHUrdDMwODVsaVJSSVdkdlY2K1VPaDltbFRwYyt2Z2t4YVpETXBw?=
 =?utf-8?B?V29ha0hLVm5pKytZUlVFSXBGdXhqNnZrakF6Q3ZRaDhPb2NRK3kyazRMZnJS?=
 =?utf-8?B?a09hdDRGR1RhWEduWlNyRlpqZlJjOUJDbjRxV2xKTkkwWGNHcWFiMXdCdDY4?=
 =?utf-8?B?YlZJWDVMMDJVUk54UVFQaHIrVkt6U2ZQS1VZUGVDOGJqN25ORy8wNXAzVzBE?=
 =?utf-8?B?VlVLZXpEWU5nWkdsNXBEYUZtRmh3TEhMc3dWQlYyQXpnU1JEM1IrSVN4dERD?=
 =?utf-8?B?RFh3YUZCcGkrNjNodEJhZ3BtODg5SXFxUVo2U0h6QjRpanJJTzQwWDdpZVFB?=
 =?utf-8?B?R05NdkFNbm90YWhwU3ZCa2ZoQWhidDUxUVczbjdqeC8vRi9ybE5CckVSaXRt?=
 =?utf-8?B?WEVrODlLek1KZE4rOU8xdkorSmpvSHZCNWw0cWFyL29uRUN2TWs3WTdOdXgx?=
 =?utf-8?B?Y211OXo2ZGo3QkpWdUkzZCtNd2YrUXJ3ZUZ5blNNSzZNd2VOVkcyRVNHeFJS?=
 =?utf-8?B?VFVwNE5RZEwzUCtCVWVYdHJ2TERqZnNVZTB6SStJK0ZQTCsycGdzR0xlVExq?=
 =?utf-8?B?M2c4aXNBSmdjc2kySE1La1BlQ2t1RWVEWXhqSmg2N1A5NnhlNlNSL2o5aXRI?=
 =?utf-8?B?Nmsrdmp1Wk1HK1RZQmc0ZXlObUZzdjB0NjBoeVBZUFNvaXRCOVM4aXpyRXR4?=
 =?utf-8?B?enU3WVR0dzIzdXVZU2JIaWpGYzc3aDhpeVdnTjgrVnNXMllqWHRFNUs3THRn?=
 =?utf-8?B?bUZyYVFGNGN4a0tibytOSG80OUhTZlhBVEt5VGlUeWtEbGN1OGJudmtrKzVV?=
 =?utf-8?B?WnRxUW8zM2R2TFNTTmk0TjVGc0FST1IxckQybmliRDE2RlBEbXJxZWcvaTRD?=
 =?utf-8?B?SjNSRjNIbUw2TGdyeTlpWS84UjBRSC9BaFlwQ3N2QnYxUGZmY2hQZHBXR1F5?=
 =?utf-8?B?aFNLUUo4dnV5bWlzQWxJU1pZOEw4cStkRCtpTkh3QndXWWEzT2N5bEFCVlJF?=
 =?utf-8?B?VmlDZ3RDd0tBb1dKdnp0L0l2ZkZqOG5LNDRDQzVkREFnY1IzNnVuWS90TnZy?=
 =?utf-8?B?MVdBdG1Qd1o4STNLR0x5N1JsWWdOZ2ZMK1lwb0xDMTYwWXBXZExKNUJQVjRx?=
 =?utf-8?B?OTNsMnA1WThxSWY2cytzODRWZXBvSmNsZVZZcGw4b0xPcWF6MkxOajVCbmpI?=
 =?utf-8?B?UlBid0ZHWkwxbUJrc3RhRGMzOFpDc0EwNWJsQkZ3dTN5cHZjbEd3N2JiVVhW?=
 =?utf-8?B?and6YVNJcC9zTmN6UnFDcWhaYWlRbTlpVUF0MWk1K0VBTTJINVJQLzhWVXB1?=
 =?utf-8?B?NVg4RGlQNU1iY0l6d0xJOWpmRmNieEJzWkZ1M2hnY3dCbGxDb3poTjNsZU9p?=
 =?utf-8?B?dHNyRWg4WXdGN1kvL09FUHUxVjduL1JtSi81OGhXK21xbENzZGpiMTdVY2Yy?=
 =?utf-8?Q?kbs8ucrg8d6M7twfAyOHoZRYyEHRnP0Wv6NemeY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXZ4Q0hBRmphS0FDbm8xd0hFemVrVXdOOVZzVTVpQzF6eW9wbHJYajZjRHcy?=
 =?utf-8?B?ZGNxMDVSSDllcnlNQ1oxQy9FY2JQVVdxajBGcENYc2p4Uk0yS0lwbU82aXFM?=
 =?utf-8?B?T2IzU0RBZTh2TFBoKzdYMnA1YUhFR2w1WUxOdWQvQ3Fsd3RSTnJiU01ZU2Rt?=
 =?utf-8?B?bWtxT0ZLVFVyYW5YcEZJTTFER1RDTS9xRkM1VllndmdYZk44MzVvRy8zWEdL?=
 =?utf-8?B?TVFUN0dJNWJGRTlSZnpLbGlFbWtHV3ExQjFvWEtiQS80SEVZUG1UMnRNcnNB?=
 =?utf-8?B?SHlrUzVYaUFrd0MzTnJhV1FSdWs3MkU1YlZaUDhMZjFVL2dTZ2M2d3NwemV5?=
 =?utf-8?B?WG4rTXdONERSdVdIdjlBeGw4VmUraURLMmdicE1XTUpWTDVXSzU4OG80aDgv?=
 =?utf-8?B?UkJIZ2dpZnBVdUk1SkZRbjhITGNtVnNhOVlpdUlFYzhSa09SVytVM1lMMkxK?=
 =?utf-8?B?NjZGaHVIMHNmbTBxMTIyUVRMdnJWeW1QYlkzbzQ0OVFveWNid3FVVDBBTHlG?=
 =?utf-8?B?c280T3ZzZTJILy9EVFlJbTgyNGtxNGQzRm1SQ2c4T3BhMnJvOEozQyttL2V4?=
 =?utf-8?B?N0psTWFuazl4emlmRXNaaG1oUDlsLzFBY25nWEJndE5IMWEraXVVOVpBQStB?=
 =?utf-8?B?U05ha0ZySFREUmp5ZndMQlY5Q1krL004dUoyOEpILzZLSnNIbXZPNkdYUk1T?=
 =?utf-8?B?aTk3aFFJVHRBa0NGcXRaYjh3Mm0vVFpqeUFHT1FOaUl2M2xtWGFkakIzdzli?=
 =?utf-8?B?WTJZMUdGZS9QM1E0eCtOd1JiNTF5b0tkb2t3eUpQSU96WUpzSDhoemVzOG9O?=
 =?utf-8?B?OHhpc3FkckxhSDJzZjlIM1Irc1RwZ09EbUlyclI0cElTOE5xMll2cGZkdnRR?=
 =?utf-8?B?eFJFb2tJRVVGY0VPNTlDa051R2FIS3R6SnBBc1k0ZlJlbndYdTdEYkFJWjB5?=
 =?utf-8?B?azJ3bUVyL0RZSnVSZUNhWGpXUzlmd0oyMEtac2t2a2V6MXVEejB4Nll5dTQz?=
 =?utf-8?B?ZllWRU8wd1lIRE9rbExjdzk3dFJaL05zY0ZGOTZkOHllVUlEN240dVZvNVRj?=
 =?utf-8?B?dE5lVWdzVzZjVE5MRmdHNlpyMlJ2bmNIdkR0bGFXbHE2SS9zRWl6SGdYaVZX?=
 =?utf-8?B?UFIvVUZVZFZacmt0VkNHdGNEK1ZWL2w3Z0U1M3Q2SVpVQjBubDZmbHZ4Z3pV?=
 =?utf-8?B?L0hYTTVRU1VYbWE2Kzd3aXdneitXZlpkSkNlK1JxL1FadWxCdEIxSUVuOG9s?=
 =?utf-8?B?c0tmQytYZHV5Y0RpQ01CZ3JJWERkVnR4MWN0RlBCT0gzMWN4OGtuamFyK3Vi?=
 =?utf-8?B?bjE4NUkxaU5hSEhKOElLVGw4Y3ZUYnF2bkNzdmN2bFZrOUQvUEN6enJ1NFlO?=
 =?utf-8?B?OERnWmNwSDdNQ1hLcnJLVjA5ckhDa2MyRXJuanh0cG5GQU9YaDA5NlVYSHNE?=
 =?utf-8?B?eW04TmFXZGR4UWhFay9wc2I1YUZlZWpxcGJ1MTZHVHpMQW5DSzVBRlQyV1NO?=
 =?utf-8?B?bEJUZno0VkFub0sxTlVEZk9qTHhzbXYwZGVmbHRMb0VnaGpWbng3bEdROEJu?=
 =?utf-8?B?bmdiSUNrV3JtU0tKUld5eTdXenhEYkE2WC9lSTdvWWNpdjQ5ZlpVblp0SUpj?=
 =?utf-8?B?OGQwbE1ZQnJub2NjN2twb2NJZm8reXNXRnNlLzNpbUd2aUxJUXc1NVpzQnph?=
 =?utf-8?B?NCtKQ01rOTNYaExTK2ROckU0UE5MSVNuaEY4Nm5DRFRHUnA5QXd3YURmcndC?=
 =?utf-8?B?clRvNWIwQkY4S3Q2VzQvMDdSOGx6aWJkMmFWZCt2VFV3YlAzaXluQ2xQMERw?=
 =?utf-8?B?Z0dUaEN5emZrOUtNWlI3UkFIYUN2TFhaZHFnczZqd1hJeVplTEdUSStadXgv?=
 =?utf-8?B?OGErbmJVTWZwWHBVY2tVZFp1ZDJhOGhOUEFUK2IwbTVPVGlNNXFveW1mdXp3?=
 =?utf-8?B?ZlBkSlJvY2xmbTkwbHhmV3dDTXlRSHVQNEJGUkdJZ0lDWFBpb1BoUkpHU1I0?=
 =?utf-8?B?MXdtOHUxV2Y2WmhicjA3MFhGalZXdjFzSEV5VmQ4clBJbmpwV0l4cTFzNjZz?=
 =?utf-8?B?bE9taUlqL3gvZ0FPRDVwemNtWTBYTnFsd2MraTg3TUxkMlBUVjJwNmtaa1Ax?=
 =?utf-8?Q?V7IRzw2mcaNJxxYbNxxDJK99Z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78da4700-01b4-4ec1-330f-08dcfd5df42a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 05:51:55.3039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRNDt7RPXj5HOaEsG3tSlo9/sVCogBRQo6Kns6f3ObMDaJ1j1vocXhg3UUBb5Ez4sTVitRW8bjvnoRRHa6kcZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On 2024/11/5 11:11, Duan, Zhenzhong wrote:

>>>>> +    DEFINE_PROP_BOOL("x-fls", IntelIOMMUState, scalable_modern, FALSE),
>>>>>         DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control,
>>>> false),
>>>>
>>>> a question: is there any requirement on the layout of this array? Should
>>>> new fields added in the end?
>>>
>>> Looked over the history, seems we didn't have an explicit rule in vtd_properties.
>>> I put "x-fls" just under "x-scalable-mode" as stage-1 is a sub-feature of scalable
>> mode.
>>> Let me know if you have preference to add in the end.
>>
>> I don't have a preference for now as long as it does not break any
>> functionality. BTW. Will x-flt or x-flts better?
> 
> So first level support(fls) vs. first level translation(flt) or first level translation support(flts),
> looks same for me, but I can change to x-flt or x-flts if you prefer.

x-flts looks better as it suits more how spec tells it (FSTS in the eap
register). :)

-- 
Regards,
Yi Liu

