Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF48CA1010
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkTS-0003JL-1W; Wed, 03 Sep 2025 06:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1utkTH-000318-2f
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:12:08 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1utkTB-0000j8-Al
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756894322; x=1788430322;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FxYrH7PF0CmnR75lbo5eFs12Go0OeffIACr0qt0rhEQ=;
 b=N47eYGLeYKR9e1Jg02KTA3r6qbuyq0Xcom4SJM5vIyCZZOfJ9gBaszd3
 WzuQOzGp0Qde09EGUBRUeT5QyFKP+iCR0HPvR/izwV5MakBxm8ldUD2h9
 jsXvxmDMlTrISRF6ZosycGhaf670sSaglGeX0K1qqSkll6AoRA2Gu9P1z
 jRzJLoers5ICDI6915t6CqPjz60yiXqhKDCVjfip3m9GjEuEDT+Wk/ZNs
 g+ivPWJX0u9si8CnpPuc6UjjApGaS/gDX0Bof4PrelRhoIrO/ewNg3jCV
 2fKuuTJioCU6XecivCUWaSQDU0fah+k8NK9GAkw+OfJ0qWxKq5Orso5na w==;
X-CSE-ConnectionGUID: ubq4IraNRK+JahcMIxJtAA==
X-CSE-MsgGUID: Pbhz/4BRRkGZm25kXaHdWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59316707"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="59316707"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 03:11:57 -0700
X-CSE-ConnectionGUID: DWm7iF1UTG2dd69Z3fnFyA==
X-CSE-MsgGUID: yx7qRPB3Q1GmIaPKZOJQUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="172011280"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2025 03:11:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 03:11:54 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 03:11:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.76)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 03:11:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhis0gILfwBnDCyfDWdiw/nnZMW9X1Cgyq2JlEcLqEUZoxAQmxkt7W8PtLlmLd9YV0iPPmzElu7ql29e0m0QVyWo0GyC/4vsOJXJy9Wiyd5YIhagX8n8WYJ/hWz+QI1Qmvl8ENRo4QWIl/s4lrwX7HQynDARGu8d26CxdbU78LDHl2cb4V6ujYpnaWwQ7qfoqhx0HAOGQHWqFq+lTtNRzru8eZsN7PKhyxYpm2EofNm/zArkSDt9hOsVlcreFuGlC9iGwBJrKS5iRxlhQQ2rcQ04J6dS8ztI1cpGWvaawZDsScjiZYnyFGfj0DV7KN2ckipBXMYDx+rac9mPn9vQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7NMJbM92x8aRlTo2xI4yWiSqO7lgSzdzxZ3eeB0dZ8=;
 b=h2r2IKQgwRUf66HIhjSZig8FXMCw2+wuqrD6uDq7fBV8i4A8ZWxfUDyEdmctVMAoXr189eEh+t9n32+8kNE6QTFYQhnx9Jvq+3X83uR9TN4xfIxEm3gORls1BF7WPvQo7dThhHMGl3G3SHpJmBwY9+OTCH+quiY+h30x0HOR/+5gf/cJDUj3IFtpr85T2AMbAVvJcEYP1mR9ipgUxmCQ4ZE8vXrDTDfiooNLDqU5EXhtRQAaio/05USbaLAJn7x2xEac+jyvNI5x95mcAtJ1ukmASYTsLwUYuqEGfiuAqWDgMaLt9ImWSBw2OcdhfSjtIWYKbBhDKmTV2TOGCuqjzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Wed, 3 Sep
 2025 10:11:52 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.021; Wed, 3 Sep 2025
 10:11:52 +0000
Message-ID: <4d2f4c70-ed7c-4c2c-8140-04e2203d30f1@intel.com>
Date: Wed, 3 Sep 2025 18:18:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/21] intel_iommu: Replay pasid bindings after context
 cache invalidation
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-17-zhenzhong.duan@intel.com>
 <ed8f5d83-0bcf-4685-a362-cbb948b01baa@redhat.com>
 <eede18d2-e8fb-4bbd-b718-3f11544716ba@intel.com>
 <IA3PR11MB9136319CC57353A1E2F0F26A9207A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136319CC57353A1E2F0F26A9207A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|PH7PR11MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 7858d660-18fc-41d6-de65-08ddead24d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|42112799006|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0RyVVZENXBCU2h3d1FhaW14WWVrSlRLUEtOQ2RLRjR0N2dLeU5MK1NDZzdx?=
 =?utf-8?B?OVNyL1ZlSnkwQXBmK3IyYS94aTkzVlFkZjFGY0FZNG8rVjFnMjVWdWVJMXhN?=
 =?utf-8?B?MndSR2R4SFRWWFc0VTJCR09pL3NIVWJzU0x0L1ZiZXo4cXBCaG5XeW5ON1h6?=
 =?utf-8?B?U0lSVUpTTnphNVc5UkpoYk5CYjVyNDA0elZuSHN5UkdWUnBJSEVPWU1yTzh4?=
 =?utf-8?B?Y2FVM05sL0VvTjRmOS9IMytkcDNzd2dYd1c1SWttNjE5ZjJncHlFQ0RzOCtF?=
 =?utf-8?B?cmdHUGVzWjliY2JpLzNkVDEyTmtkVmRvMlVvaklmcHVEZUhRNkE0cmZLQTkr?=
 =?utf-8?B?YzhEdHZHd3pFT2lqZjNDWnN2ckpXNmJ2RURIU294Rlg0QXRKK1JtQmhtNjAw?=
 =?utf-8?B?bUlSZ05ZckNmSDQzMlVSdVlUR2tNVVc5K0M1YTNPVnMxKzBvWTFJNno5S1RE?=
 =?utf-8?B?SCs4TXl3aFppb2N0NnNUcEMrT0xsaDl2SlhWSkwwbXJHVEhoYThNMUlzcmhU?=
 =?utf-8?B?SkUvYWhyQkprd0xsNlVEU2RsSWVYRDFmbUp5SlhlN3l2dnM1OE5Vd2lTaFBJ?=
 =?utf-8?B?d0IrS3ljVmwvUjBNOEladU5Yc083Y0pQR2pRbEN3alM4Z0pPWTRoRG5MaDZw?=
 =?utf-8?B?WFhFazU3NDJ5NkFIVEd6aFBVbkIxLzhjVGJIbXY4d2RDa25VNlFoblhBTHJ5?=
 =?utf-8?B?UmdBV3ZST2JmODVuVFdIdkhJVE40RExaK1QyOUJuczZ1T016dkFGNTJkUkxk?=
 =?utf-8?B?SE5oeVlMOEt6V1NGM2xuTjRNUDM1c1RnaWhKQnVBd0tqYXlXa3JTN1VJbGs2?=
 =?utf-8?B?Yk14NVMzRmREb3lINmFZSy9ZaVI1ZEZpV2xFc2FMTDBQSW9uOXMrMnRWYkll?=
 =?utf-8?B?Z3d3Tyt4K1RLbFNzWWVTMGFrZFNGcWhwRUt0YlJvY3dyTXVWa3VoOUtjWXVl?=
 =?utf-8?B?Z0lSVmtBa0NlS1FnZ2pNbmtQU25XTitBM3RxeDBUZllQUmJQckwzNmxtNlJE?=
 =?utf-8?B?U2RxeXlWcW9oTDdobTUwK0s4YjhabGdxWm1WL1JMZzJwYlNXQ0FzK29rczJP?=
 =?utf-8?B?TFBXUGlZdjJoRjlHQnV5UTQzMEdVM0V2cTBBY0xNbFE1akpselZtei9Cb251?=
 =?utf-8?B?Nzl0M1YyN05KbjUwL2VlVWZ1SklVQ0E1YnlocFNyQVdUazBiNGhTSkMvT08x?=
 =?utf-8?B?bDdLVXRkUEdTa2RCdUtsTzBkWmt5MFJYZ09DaWU3cHRkYzh4RXJBVmRTd3JU?=
 =?utf-8?B?bzBMUVkxbU1qWU9jVld1YUJSTm50TDRYVmNGU1lFUmM2U2VEZTBpT25YNjVm?=
 =?utf-8?B?N2FhUnBRUnAvYXQ0UHY4bDZVdlhEVDNQNUNkM25ranlUZnNFRnVySjZqbXdN?=
 =?utf-8?B?Z2FLdXY4WHo0bkJsU1g3Tm5RRU8rVXd3UHpHMWlRWUFiOFFCWVRrazdnVzd1?=
 =?utf-8?B?TnNIYWlXZVBPQksyS3VOZHo1SDhkZG9jcGVSZHk5N2hMeUUrUTc3dmV1eGVR?=
 =?utf-8?B?SlFCaUxMakhnVHh0djFQRVc0YW9vQUM1NTVmbjdUTGRqQzhYZVFLZXhCTG4y?=
 =?utf-8?B?b2hYV015dlhxTUFDc1EzS1dibTFGZWw1OERUK1BjUXZmaE1GSk9DdHl0blA5?=
 =?utf-8?B?aXpYazRZZXlWMDIyYkNVZGFCNjc5STBqdnhTWHF3MlgwOENEZVFXT1Y0dW1k?=
 =?utf-8?B?QU5zU0NOL21MZmM3YnJ1WGNYdjdFQ2JsdWRlN2dPNEJWUk1Id0NNRmNvNmJU?=
 =?utf-8?B?cEZubW5SWkVROWRoRHRlV1dxSVprNlJjelV6SUVrZGMzS0xYdUlZWUR5RW5a?=
 =?utf-8?B?QzRQWThSU1BWZzkxRW1EeEo3akdNQzBFenBoT2hNaENmV1NNV2tkZ2o1bFI1?=
 =?utf-8?B?eHFxaTZ4SjNPOEZ1TE51ODkzK1JleFh0Y1ZDbm54Uk1iZHpWUGpWVk9xTnBt?=
 =?utf-8?Q?q0NI1KOMOtg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1E4blFZRXlYVDJSRGZFaUZYYUIwS0MydEt0R1FsZWNNS0Vhb0xJRTVreUhp?=
 =?utf-8?B?YS9YYmYzRi9qSSswNGpYeEhNbDB5TDRSM1V1UFFOOXlZbUpNSnNGY0w5bVdC?=
 =?utf-8?B?SmJtVTVCVU1Ucmd4RmJ1MXMxeXJsbElCNm42YS9BOGZoYUNndHgxMUdZendx?=
 =?utf-8?B?a3RqVjlXZ0NWQ3hrQ3RyTnNDMERIM1RJWEplY0tXSlp0V0NjVkRYVmk4VFJp?=
 =?utf-8?B?aDVlZEpmVzJlNHo0YThKWXNyUk1ncS82a1B5dzVnWjhpYWpxVWMySk5yRlV3?=
 =?utf-8?B?VU5KVDBpRUNDT2hMZ3Z1L3RZZTY2bWxjc3FGdkh3SCtLSWJZMWVYbkNCSG51?=
 =?utf-8?B?U2tKeGkvSGF1czlqeGkyQk1aMU9YVnJDTmd6RTBUMTlubFBlU2dNMTllTGhz?=
 =?utf-8?B?RDBOUnJGQmR6YXg1ZGNaSExGVE9UT1dFQWhWWTRMSXZUeHYzTmpkWHl1enNn?=
 =?utf-8?B?Wml0UXd3MGVOWEVsK3ZTcU1uV3IyWXlGdHFQUmZ5NFB2b2lFTkdyOVo4dmVF?=
 =?utf-8?B?QlBLYTJhU2M2RkdJNndOQXBXa1JnMHhJUm9zZ2lER2xaTGZzSEJxTDVpZEtY?=
 =?utf-8?B?QWNsUk00SnRPakp6cENXQTlMSi8zU05uMjhQNkdyaUs2UmNPbGtXKzFGcGRi?=
 =?utf-8?B?MW0reXFMZUgzRS9aVWxpbmo1NkYwRzJ1c2c0R3o0TzIyOTgvSGFvUnpKWHJ1?=
 =?utf-8?B?WFprNjVCMUV5MTZZeHNKTGw0MVZrclh5NXVkQUN5QS9LZS85eGFVU0RFTHc1?=
 =?utf-8?B?eEVSMlRTYmk2UE91VWZVYlh4WDFqendBYkowV2ZSN0FSSm02V3JicTRndzJC?=
 =?utf-8?B?U3RidUVPZ2VoelVBK3B6WnI1Q1FHWko3Y1pZNzFSb3I5ZmRIMDd2b3NiVzVT?=
 =?utf-8?B?dlFxR3BieW5PL3VxY1IwTU1rU052eHdnbDYvMS9peHBXZkJKVFl5QWljVjFT?=
 =?utf-8?B?ZytjbGhsU0R5QlhwSm5CdzFTOHM4VjRWd3pmQjlsc0JHWXBjdGNOZzJhU1VG?=
 =?utf-8?B?QTR4aTZtTHZvZmhhUHh1YVZPcFZ1d3BCeElnM01Ib2h2SzQ0THBkaGt1KzUz?=
 =?utf-8?B?UVc2MUNxbldoVXhjSFcxSDBSOU5ucm91M1hUZURCblpJMkJJd1lkSWJMRDdq?=
 =?utf-8?B?WndNWE4xbzFxK2hqUjJ3a1VXMDdGR1d4anZoTUdZcHhCNG9SRmFUZGtyejZY?=
 =?utf-8?B?SXl4TExrWTZmck9DeUw4ZkJmZkZlUEVyUEtMMGdVK25FRCs3Wk5MeWM3YlE1?=
 =?utf-8?B?cDlKc1BtSzdGd1Nxek9TelN1K3QrNUdTQ1VEL092b3I4d1VkL1FzdU9KbWdj?=
 =?utf-8?B?Q0dxSWhJUWZsbW93d0RlbjNTU1pkWjVGZUJyRm1yRzNPRDVhZGtiWlY0dGN6?=
 =?utf-8?B?N3JMSzVQMnhPWVFLOWRGVzJxOTloa1ZMallYK2h4NHVsWFp5ZjRpdUZSbmt0?=
 =?utf-8?B?cGY0OEZncmo1aGc1b0UzZzF0bnhvVE1ZZFJrcDlld1BPNmpXdnBtSTUrZEdw?=
 =?utf-8?B?a1RCMk1WWTBGcDU1OVNpZDNyaDI1T0ozRVhjM2ZZMFdKNmxKSUR0VVRuL05w?=
 =?utf-8?B?WTUyYXhHRnMxTWpKUVdxQW1KZnRXMUlZcjFaelpyUDdxSXdJSzFwbHlyNm9I?=
 =?utf-8?B?UGlXVGZTSk1oQklOSjZmTEVtR0dvbEJZUE9tMHBIcDhaV0VBNnRwWnBvQUU4?=
 =?utf-8?B?WkZKdXdmdU5FTk5GU2R6TExQRlg2cDl0R2RJb2RmYWNMY3czZDhCaXY1K3Mv?=
 =?utf-8?B?VmNCQ0NtbjhrYUhmQU0vRlJidFNBdnRxZjQyOEpkMzNiYWVwelNGaWhBeHVT?=
 =?utf-8?B?cGRvT3RSKzdWazYyaE81Q2t2enU2NjZOd2cxU1AwQTVhTER2RWlqNDhxMWU5?=
 =?utf-8?B?TTczRHkxOVIrVjIwSWFRL1pMeDZjSUVvZFJTVkVOSUQ2cTVzM3IyVWpZRUdr?=
 =?utf-8?B?Q1dHZGZjaW5GMVlZTFhCZHBRK21aUzI3dFBSRlVWMzV6NTBOaFBQWWFGK004?=
 =?utf-8?B?cGdLKy9hcVVaRkdNOWNpc3duWFI3blN1MTF1MWxMcmJVWEdBZkNrbk1MTlRO?=
 =?utf-8?B?T0d3MU5YOUhqYS9xdUZ1YUx6UGJ2akg0VURHcmZaeVQ1ZTd3RytoZ29IM0hu?=
 =?utf-8?Q?IbGbGE1s0siYwgPVX/RU2eSEB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7858d660-18fc-41d6-de65-08ddead24d37
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 10:11:51.9287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgOBnPG9wnKcRfb4aA7noQwzONcsq7uf5J7dTMG94WcBV7zqYqTnR2kmsxlUS4AverISSSkSVe2PPANIr7rxig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7605
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
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

On 2025/9/1 16:11, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v5 16/21] intel_iommu: Replay pasid bindings after
>> context cache invalidation
>>
>> On 2025/8/28 17:43, Eric Auger wrote:
>>>
>>>
>>> On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
>>>> From: Yi Liu <yi.l.liu@intel.com>
>>>>
>>>> This replays guest pasid bindings after context cache invalidation.
>>>> This is a behavior to ensure safety. Actually, programmer should issue
>>>> pasid cache invalidation with proper granularity after issuing a context
>>>> cache invalidation.
>>> So is this mandated? If the spec mandates specific invalidations and the
>>> guest does not comply with the expected invalidation sequence shall we
>>> do that behind the curtain?
>>
>> I think this is following the below decision. We can discuss if it's
>> really needed to replay the pasid bind.
>>
>> d4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800
>> 2321)
>>      /*
>> dd4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800
>> 2322)      * From VT-d spec 6.5.2.1, a global context entry invalidation
>> dd4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800
>> 2323)      * should be followed by a IOTLB global invalidation, so we
>> should
>> dd4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800
>> 2324)      * be safe even without this. Hoewever, let's replay the region as
>> dd4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800
>> 2325)      * well to be safer, and go back here when we need finer tunes
>> for
>> dd4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800
>> 2326)      * VT-d emulation codes.
>> dd4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800
>> 2327)      */
>> dd4d607e40d (Peter Xu                     2017-04-07 18:59:15 +0800
>> 2328)     vtd_iommu_replay_all(s);
> 
> I have tested this series with this patch reverted, it works with guest linux kernel.
> 
> Personally, I am inclined to stop adding workaround for guest kenrel bug, there will be more and more over time and it makes current code complex unnecessarily. @Eric, @Liu, Yi L your thought?

Let's go back to the original purpose of this. Peter has identified a
case in which a context modification is not followed by IOTLB
invalidation. [1] This is a valid behavior since the old domain is still
in use, no need to invalidate IOTLB. Hence the shadow page of the
changed device has not been updated. So the vIOMMU chose to enforce a
synchronization on the shadow page per context entry modification. Let's
see if similar requirement on PASID table.

Let me ask one question: since PASID cache is also tagged with domain
ID, if the DID has not changed, maybe iommu driver will skip the PASID
cache flush?

[1] https://lore.kernel.org/qemu-devel/20170117084604.2b1f5e50@t450s.home/

Regards,
Yi Liu

