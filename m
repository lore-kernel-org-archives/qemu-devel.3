Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE9AC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 12:58:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOd4a-0004c4-OH; Tue, 02 Jul 2024 08:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOd4W-0004bU-8d
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 08:57:24 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOd4S-0000Ro-UH
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 08:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719925041; x=1751461041;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NhaBqxTEfno7kXCJg7PvZC3ipjLDFQN8l1QuHws20KY=;
 b=VStAvpb2lqEq4jR9YGt8lpH8QdGjDXLLzZwLgry7HZK4rvkMXxC6ylaH
 a6s0hDPogt37AgRKtW/luCjaXSNS6+b84+BtDUdIqxOdZWKCH3IeEL8DJ
 Wj7TmtpD6LEI39ivjvLF4i9KYT91F3wIafW5UXr5UZVvhNMoQTSRSqltN
 PYSu9shoGQc2YKakMrBLGkLgK1teoVDwqai2LOYC8rr7u2lWijzmElYW4
 4PSlJWgFb8t3vYv9zAHiO3mdXh3UNWiJwjKO9oz0v1QIX1w0QxmcaAVqw
 gX9iUy4YyEU7A4jCHVGgv/1pT4yKCA7abhozVE4N3Ml35vGDIx+eBXGG1 A==;
X-CSE-ConnectionGUID: mg1/vMpsTb+iT1pUObqF6A==
X-CSE-MsgGUID: XePF2nTqQ5K2xFr078E8/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28495755"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="28495755"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 05:57:18 -0700
X-CSE-ConnectionGUID: Kt61ezMfQXqrPDj7dUeppA==
X-CSE-MsgGUID: haMdMMWWQz+dOYNiDx9snw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="46316099"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Jul 2024 05:57:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 05:57:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 05:57:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 05:57:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O45AHTBRss0BEU75m/oaP5Y+yUqy5FXlcxIJZPopnS6PMT1YggUYzYJoUKZO+xrAYDNhyV3ubMT3K8yUcbZfKFp90aC+fL3XurOJjAmIPcCrR6RXDZQ3XpkrGmfExqGwrYhLRzr91dqqZ86QVWwFuA+61ON6ThuwfOUlvOtXULJC3oviH3rpf2zYdfrOb0bncZ6Hg+HY2FAxDCd0x5osZ7536hBTvzqMASy1F5cWXSohbTx8jqWquzKB5+NvYwXrrx+e+z5I34NuEcH4EQNr1kl8fvNo0oIwm30MmDbQrWRX+ETGhsLX2SUU8CKw7YVR1yBqmdv2RzF7Rlo9Xp0myQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sUk2a58E8rI33MrlQwA7jBvWNSjeIJSVH5i/5999Xs=;
 b=UNDiAgSabTPTuqsvKduLZ5RYNq69DzOVH1eQLZqaVVQ3U3gGfUiGXgwx3IRW1nHgmbmQ134c7FFMx+clylhhYK3P8LvoAQbgE4xxWG20Rn3sH11//V5fGyDCaBrkpjYIfeGf5uQ+g/t6MUjIIFcr+1TX2/uaUWFIXeIxLqOaulfHXXZkg6/IHp68Epn5FLhme8RDKLzaEygLErxLh2GrvYNKyohTQhotCIM5Race9H6zUvzzqoHKoroLTzQkISGlKgWAHxuMYaGzfKW/n4ksceA4fMeqkyPpRihJyGaGysRcLhRprbjD6H12cZ4JceTFQ/z+c3THhD2rtg11bfj4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV8PR11MB8511.namprd11.prod.outlook.com (2603:10b6:408:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Tue, 2 Jul
 2024 12:57:15 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Tue, 2 Jul 2024
 12:57:15 +0000
Message-ID: <83d1fbf5-1559-4a4a-9a48-6a44e11d2164@intel.com>
Date: Tue, 2 Jul 2024 21:01:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ats_vtd v5 01/22] intel_iommu: fix FRCD construction macro.
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-2-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240702055221.1337035-2-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV8PR11MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bab088f-3916-41c3-b7f4-08dc9a967f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azlCUXR6MEtZSXNjRUxJUFdRb1RtM2xlWFBJSkppV0Npc3Q5UktpZlB4ZnJy?=
 =?utf-8?B?VEZFaHVneGlYWVFEeEJyTVhTNEg5SGtIMEhhR2VJUm80TElXcEZCQWFRZ2ll?=
 =?utf-8?B?YW1HNDQxdC9PRnk4VURyN01aeXdvcmwzZXZnT0MyM3VZbTllY093S0JCTzl0?=
 =?utf-8?B?OUNmekhYMW1oNkNUVXkvejZpdndXRjFMNVRBdUtaSFpFQm1OdjJnUnV0bWRJ?=
 =?utf-8?B?N1o5Q1pRdzY0SHQrc0FQWjU5bzFpNjF0UGg1MjhWcmQzay80RjQ1TGhYR3lB?=
 =?utf-8?B?eGh1bm1oeUJPL1lGcmNJYk9Kakd3YmRKNlg0TlBJTUk1S0dqakQ5aExLRlRh?=
 =?utf-8?B?MGx0UjVOQnJ1cWMrY09NQWJFeHhnaGFhUUJsalEvaHFKdm9iMnZIMGNHanlP?=
 =?utf-8?B?Vnc1MktUeEt0N3BLcjRpT09QQmhpN3YrUW1yR003V0k5enFEVkpKMlBocDNq?=
 =?utf-8?B?dS9vNTBoT2I5dmN0cFlmNHM0TWlESzU0VW1OZFFIWFo1Ujk4YVZIcEV5THl3?=
 =?utf-8?B?THBHTnkwaEFJYkhRcTY3UkxqUitRUURXYXhpVkt1V3hkNTl5NllUQzdiZmp6?=
 =?utf-8?B?czl2WXZXVXJIMzRINjN4YzRZc2NHN1Jlb0dreXFBa0FFaE9xSmdMQXN6TlFi?=
 =?utf-8?B?ZDh4K3B5Tlllb0tHbGNhUHVpYVduVGJPdVowZVFzVHFSSUVXTkZ4WkliS1Bt?=
 =?utf-8?B?WjRsaE9SOGt0eU5zTTc0d3p6K2UxT0prb210NWprOUpmYVZnTHNHdUtHYjNz?=
 =?utf-8?B?aTF1VmQwdThUSmsyVjhDaGcydHRRRGRnVkE4YWJNZDRVaUdkMFcwblRpblMv?=
 =?utf-8?B?ZDJvT1RaN0FhRnAwMVpXakludG1hS25Qc1NQeUlJWVZLSUM0N0w4cW1zR1k2?=
 =?utf-8?B?N0gwaDUxUXA4VGl5d2w2aUw5bkk1L2lVYzVZMzR5OTl2NHA1VTlkVXNFWXp1?=
 =?utf-8?B?SWxlaGtJY3RmSTdBMzRwc3NSRnpha1N6Q25SN1FmWjhtZHEvM1ZPRDI0Z0VR?=
 =?utf-8?B?R3FHeXB2cXQvUFVqRm1WSlV1RW1NQ2F1ZTJwcUZtU2lzWmRzT2ViMnk4MDg3?=
 =?utf-8?B?ZGw4eXZNY0JEREluZWwwS3VNbFFFWGVVR09qSE1yR1ZwSWxUU3ZjcklXeGhr?=
 =?utf-8?B?MDlhRWt0YmpCc3NBdTFBdTFjRTdqTVNkaEY2bS8vUWRXaGFmWXNzU2pRRHh6?=
 =?utf-8?B?dW1IQzNaYjZHUncyMks1MjczTnJkM2gxWVAwSWFETy9nTlo0R3haRUVzTExa?=
 =?utf-8?B?VE43aU1BY1p0MHJOK0tyOFlWekdvZWFPcUtlQk9RMkNGRnY1WTEzRlgyekp0?=
 =?utf-8?B?d0UvNkpWcUJMTjBmUWRubHNZU1JLbEJLMkJ0aDN4TENsWTZyLzUvRUh1dWJ5?=
 =?utf-8?B?NGU1WUxDUzV3eXlaUGRTNG1jTlYzdkR3T0JlTnBTZ1RyWU02bmRHQStyUFcw?=
 =?utf-8?B?aEZGRG9KdXptQmMrZTd5OEdFa2Znb2lpMC9hZXArLy9rU0xwYXVobkpRZUlo?=
 =?utf-8?B?VTZrRFBNeDVSOGVlbmdSRWN2RldEd1lDam5wME8zVUFUR0R0S1Jaakh6NmUx?=
 =?utf-8?B?M1Y0SEVldWtzejRuV2k2WjRmRk9qUVdVaFZ0RVAyelQxR2s3OE1OakU3WDEy?=
 =?utf-8?B?ejg5N3Q4Y1ovUlhKdlIyNWhoZ3YzbDZuZU9LK1FQY0tVQUp4ZHhLR1plKy9w?=
 =?utf-8?B?WnR4a0xrZXdKZm0wUTlzaHA4ZkFIbVdMeldEc1ZiWFk0ekkvMzBBT1IvZWc2?=
 =?utf-8?B?TjBsOFBsOE14TkhzakRJUlQ0QWg5UWI3Sld6c2JVendyUERyUVo1MDd5L2JM?=
 =?utf-8?B?TDVqRUEvVEJLSldtcGRSZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU84a1RmUHpUV254cWc3dVNvNytMWEJ3VVByUWhtYTF2ZWtvTXV1bkpPMzk0?=
 =?utf-8?B?QnRUcC9QdWg5R0ZBMTdsSXBVN1o3Zk9DalM1WnhQMmp0OEJLa0Z4RThRZnhw?=
 =?utf-8?B?YkJKTWZIVm1TdXBGc3o5OXcwWUgwRnB2d1J4SkxXeTl2SVdHWEo0cUZ2ckVk?=
 =?utf-8?B?cDdwMkJGRG5ib0ZVK1hZM3RUVEFIWGZFWWdqbitZd3lITmtaTTBSNjI4RGln?=
 =?utf-8?B?aGhqU1UxT1liOXRwSFI0MkoyTzNrTDFncDY2V2dpNWh4OGdDQmFuczQrK3NE?=
 =?utf-8?B?VFpKUmNrL0wxR201WGxOVkh1K3RQUDR2cXl3eUloa1doTjN5RldSekZkNzdT?=
 =?utf-8?B?bndCTktrUG1wY3paYzZIZFZoTG1pcnVtYldBVFZZa1hYMC9YVDB0bGtucCtX?=
 =?utf-8?B?TEdqemF1bEhNd2dBNW5QZVNhYzN2MUg3UXVOb3V0d3RhZXFGWkQzOS83ejFI?=
 =?utf-8?B?UW1BWnZ4c0hUQTZhenlPV1pVSHRMZGlRZWg0TkRMbk9DSHF2VEZvWWZoWWgr?=
 =?utf-8?B?Z0ZBVmVLQkFUVHMwSmt2NEFVZEZycHYwSG41eDZYbXlwUU9OMmdZNU96ejA1?=
 =?utf-8?B?SlZOanltQjUzOXk0NTlRanZsSWozT0lCWEJGaHVLUFhMVHFMM2hOVk5XVmxy?=
 =?utf-8?B?ZnBid1ZSdjB4OU51NDNmWlEzalNDZnZ4MVJ5N0FOOEtqZ3VQRXB4b203djVq?=
 =?utf-8?B?aEFnUXNENmloaERacjlmQ1ZrNVo3aFVOUnlLWVk4VHJVQm9iaFQ0czZSM3Zx?=
 =?utf-8?B?S3FwOURXT3hEQXB0eGFua1NRZWxjT3dPN0xnVHpMWnlLNHo1emtjcGdwQ0hx?=
 =?utf-8?B?bnV4dUVzL2lpSkpvL3J5WlNJVzRTeFFQaTdQb05SVjI1aTVNdTRyL1NFazEx?=
 =?utf-8?B?SDNYNzN6MFE2a0NMaFZXMkdZVXh0VzR3NE1VNnA0b0R0REJhVyt3UHZSbVFK?=
 =?utf-8?B?MkdMSS9uYzZvQXExVy9CRkNPOFNodGFqTUhQTzIzdEw1dFJTV3BPeXh6TnRW?=
 =?utf-8?B?RnQ4dndmQkovL3g2cDg2WVRrSGUxWUxSbERScU1NZG1HTDdWcUZNSzhWQnlq?=
 =?utf-8?B?SDE2STIyWFlDZ1M4U1dSbE4vS0toL2VNcGRxOUxsK0xLM0xzS3lFdWpMcnN5?=
 =?utf-8?B?YmpoRmxNdklmWkRrNnB1eUdMRG4rY1NtTVNhODBMdGdWUE12VTF2Ung1UjlO?=
 =?utf-8?B?WXZsT3dMRzdrSElxTVVoMXZKdlhOcS9IcGNTVGx1bm9Sdm1FS3NFcy9yeHFz?=
 =?utf-8?B?eEsxM2hpVHFxTk9PdkowQ1d5ZmNscG9rdzdWMktVZEF2TkRCK1FJbUYyNE5t?=
 =?utf-8?B?VmxLK0lyMWY3alpaamdrWnpXbUkxUURPbkdvUHFWRzE2cXJndWNtdjExT1JI?=
 =?utf-8?B?Qzg1bTdlV0ZQbXdQNUJrMy9iVlJFL3Z0MnpTMS9Cb25JNWxPVW1vQVdnNG9u?=
 =?utf-8?B?dmpKRTdSSXBjUnoxNEo5ZUFPZmppcG04Z0wxTEhBSkQ1Yk5CY3M2QkNnR3Nh?=
 =?utf-8?B?bC9qUFZmZHl3V1o5bW1qcUN4T0hxelN4NUUvR0U3a2o0QmhhU29acWx3amVu?=
 =?utf-8?B?T1F2bzFvN0FHSGsrcXdvQlprZjZzZTdqcXNDTVluQ1FnOE5DT3pBV0xHY2xk?=
 =?utf-8?B?Rm9DN1gyajFmbWp6R0EwWmgvTjdOSFZudlJ2YU14bVc4S3hlcEhVL1hIU2xs?=
 =?utf-8?B?MjhzbnFQNWZMbmJKaE5qdmZyS2dtbDVTVXNFek1OTHptSkNOcXlBeks2K2hp?=
 =?utf-8?B?bFByeWRIbFBJWlRKVkJnWS8ySTZuK3VVWkFPR3NmeGc5T3dFdjFZZkxzb3U1?=
 =?utf-8?B?MXFwb0FxcG15ZWVJM3ZNdVBiNzF3NGU1bXhjamxzTG5Hb1JwaVhSVHBtWEl6?=
 =?utf-8?B?L1FKL3pxNy9jWDRTTHU5cWsrdFRQQkN3WEVFWVYyU09qTWt3dlZ6Y1VKUXBD?=
 =?utf-8?B?d3VTQXFaU0Z6VmNoRHI5Q21XS0lBNWtnMVFkZkdqTWlJWkhqSHpxMTY4bWph?=
 =?utf-8?B?VTRwMmNPZ214cVNGTTZwMjRDVWNXTkV3OXJ1UUUwd1lEcGdCaHF6cWdFdDJJ?=
 =?utf-8?B?R3FIRmFya3NtOWYvcE9Ldm5keDZBOXpMUmZxb3BEeENSYWFXL3lqWkxkK2Rw?=
 =?utf-8?Q?MTnz0XeVkrQ40xXbaIoeLzqM0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bab088f-3916-41c3-b7f4-08dc9a967f32
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 12:57:15.2720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2bmMNUsbALwz+ulf3i6TuOuZYqL7+qwWdmtzdjgyTZhz1264unXJRr6atF+7ABbn7mRjfOkhp36IW2TrKTJXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8511
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10; envelope-from=yi.l.liu@intel.com;
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

On 2024/7/2 13:52, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> The constant must be unsigned, otherwise the two's complement
> overrides the other fields when a PASID is present

does it need a fix tag since it overrides the other fields?

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu_internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index e8396575eb..b19f14ef63 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -272,7 +272,7 @@
>   /* For the low 64-bit of 128-bit */
>   #define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
>   #define VTD_FRCD_PV(val)        (((val) & 0xffffULL) << 40)
> -#define VTD_FRCD_PP(val)        (((val) & 0x1) << 31)
> +#define VTD_FRCD_PP(val)        (((val) & 0x1ULL) << 31)
>   #define VTD_FRCD_IR_IDX(val)    (((val) & 0xffffULL) << 48)
>   
>   /* DMA Remapping Fault Conditions */

-- 
Regards,
Yi Liu

