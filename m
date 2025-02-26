Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98800C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 12:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnGlo-0005Zw-Un; Wed, 26 Feb 2025 07:44:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tnGlm-0005ZC-Di; Wed, 26 Feb 2025 07:44:10 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tnGli-0003pp-Na; Wed, 26 Feb 2025 07:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740573847; x=1772109847;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/x0Nz+B05gKS8jc/iXbc7wvAYUfq4kvc0MF5YsHaedk=;
 b=dHZMOQZC3ZoX+J6FOCsPTyXgCkKECdbxD087H6iW2pTuAmWPzjJBGi80
 FeNzGzPJ1cAitEZjswWZXTC3Qx5oDPy1tcirlcIhK7WWV3j39r7vFMdUM
 EfZ/1YLtmjJF3Z9PnFFCI0S4+S8EAS7ee7lZmAWs4Pc30O54QT1hMu458
 SsAXkczQBQ5gI7IBegmctUuxrDhzpJZDE31MWXbdY7SUy2CmiHnvXzt/H
 ivP0UsqpfiknCC7zWgjG4L1/d8443dl18f1Rqsu5sJA3NUn1A6LQYuRjS
 NiuZ+HBGB34zbgyqWbPFULBIGeuTOhScYj5mIr42g8D7Pcn/bW5wteBIW w==;
X-CSE-ConnectionGUID: K5nuOL3IQt+EgecloBn0FQ==
X-CSE-MsgGUID: 4xGQSBBaQ+2xTvWv72p+cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52807237"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; d="scan'208";a="52807237"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 04:44:02 -0800
X-CSE-ConnectionGUID: FF3ljN6YRBWn/rdycjLCOA==
X-CSE-MsgGUID: pbsI+XYbRR+XzjPRYxBMFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="120799825"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 04:44:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 04:44:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 04:44:00 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 04:44:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypPNDLrAFfd79ve1C+kkl0OjH3/eCGzdYvsypU2gYK7YdjznoVzKSwZqnzZHMAVAzbErtj9rMIle37DubI6ok05k45wvKBP9hBqqHKcO5bd/JtXYi7ASeiDPoFndPqV1YLd6zCouiRJop0k8i9+moqdXtBzUdMkRWv7Tb0xvBrNxxFVhdhybsG9Zs33W8+nSykhWZbip14OxYpK1VL3YvZCTqfftT/kSJAC+8W7XmU6JVr6QrJNKonOoUbIPIUIJ/ajGgwyNdQv6pwQQaV4ZAVeIXWX8xRTkNtDMy4xy5s/3r+tv9iZbqaQPNsbyPlBV1NrwxPbXz7N4XAcjqpIGow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyUr8RwFTOjF4vIeGJhyF6qYOczcd7KBDWtUiYsrSs0=;
 b=cJSxbXel2Q8Pd97XfZN2CslL2tcsGRGgHjQ6WnjbjbmV0c1PXdhlAn4JdPyv2zVgNcRfD8mr/0znhxkRk2gdG/FJb7AIU244fbygFnrc3dxTlM6e+h2aAnz4rS2DwHog9GIgOgvM71YLnVYTwel1M5gEdUx6H7+d6k3jWUhaNiO/dxI5SHopwuj3osGWes13nFPOGbzC7QW6FNQQ83gxBFSZK3Qo/0K920+1q9Rw+5z5q/xGlzmFAIuHZ613Vd5jL/xqgQLRiUdUMAx4LMYov09OzbC9yY/k1fopq0ho6L/jXkJy7x9qLiAqjGwG5n0BuaQCKBBs2ydgxndpbgqH9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 PH7PR11MB7552.namprd11.prod.outlook.com (2603:10b6:510:26a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Wed, 26 Feb
 2025 12:43:44 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%7]) with mapi id 15.20.8445.017; Wed, 26 Feb 2025
 12:43:44 +0000
Message-ID: <b0e11469-775e-45e3-bbcb-319557c20a47@intel.com>
Date: Wed, 26 Feb 2025 20:43:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] system/memory: Allow creating IOMMU mappings from RAM
 discard populate notifiers
To: David Hildenbrand <david@redhat.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, <philmd@linaro.org>, <peterx@redhat.com>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>, Alexey Kardashevskiy
 <aik@amd.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
References: <20250220161320.518450-2-jean-philippe@linaro.org>
 <20250220161320.518450-3-jean-philippe@linaro.org>
 <0d761daf-174d-487f-80fe-09b04902006f@redhat.com>
 <75d90f78-151f-4169-84f5-cc3c13180518@intel.com>
 <ce2306f9-19a4-4979-80e6-29b1e8a92318@redhat.com>
 <108be3a5-cfc1-4268-a913-3a41d1e4451f@intel.com>
 <16cb9605-ba4c-441e-8709-369a37655b4a@intel.com>
 <4a589056-b331-4dde-aa77-9129106a14c0@redhat.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <4a589056-b331-4dde-aa77-9129106a14c0@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|PH7PR11MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6c759e-9314-45f2-08a9-08dd56633484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVJtTHl3WTE2U2o2VXJkT29xeVZxSGk3ZzdZNFBYQmg0bGkwMFFudVJ6L0d3?=
 =?utf-8?B?YlhnVGVHOUQ3c3BVQktJd2xFWFNnZ1QwMjlHT21qM21Ha1oyMEtRdVNMMjRq?=
 =?utf-8?B?cDVUS25VZHZsQm9VNnVYaUpjTmZVRWhnQ2FvaTBNRXA0TkNZbTlpdFJQYVBW?=
 =?utf-8?B?ZW02T3dudFVJSWVkQTZpbkY4NzJTSjRaNGJxWVRPL2Y3ZXhtcjgyU2pWM2Yr?=
 =?utf-8?B?NjhqbjNYT055TzB1SDNoR0dDeXRJVmxPNHFpQlpJM1VwZVdsaGVYekMvTU1m?=
 =?utf-8?B?RFNMamdDenhGY3VRdTdDT0I4TUpBeFZjUE8xTXZxeHZWeUM5UHYwS0R1VTlj?=
 =?utf-8?B?Q0JXSW1NRVJsajZnVFV3KzIyNUIzVDRtUzBnZ2QwekdMVnlqd2t1Q0krQW5E?=
 =?utf-8?B?eXJSVEc4SG43Y09wWnNlMFZhNERqR3RUekVJNnQzbFg4dGxTT1lEWlR1d1ZY?=
 =?utf-8?B?aXBMbUhZNmEvekNwS3luQStFcnJMQjhVYmx1cWhKL2V2dHZKa3VYUkRkSko0?=
 =?utf-8?B?MXQyZkMxSjJzMjdVT3FQY1N5ZVM0V2RNb2NUMlVISk1mM3BjTzduL0w3ak9i?=
 =?utf-8?B?TllqVDNRVVlQMmQ4OFgrLzJuL0R5YTRlN0U4c2FGaXRHWGpkVXNMQ0psMzBr?=
 =?utf-8?B?Sy9yZ1R1TkI3YUhxQjNCZktxSnRaUUJ4WU45ei9taldYcG5XWVQxOWcyV2xC?=
 =?utf-8?B?eDFHTVl0MXFxWHN1cmVBckk5MnQ1a0xqbGZrU2NvaWt1QXlPODhzMDdUSjNK?=
 =?utf-8?B?WENFc1A1UDlweHlUWWF3aHZ1TkZwVkZmUUg0MG85eEpMaWtnVEU1YzVRMEc1?=
 =?utf-8?B?cmsvN0pqbmFDS2NlNzBkTE9nSEp3T2tiYjVIL2xHSzRvNlR2TGt1Y041d0Zj?=
 =?utf-8?B?cFBPMS9kUDgrWGJSM0VWZEtRa1N4WjQ3S3V3WUpZWXBwSTlSbGI5WnNlUmx3?=
 =?utf-8?B?Rzl0OUtsMyszKys1aVlCdEpJTCtBME1oOS9iU1NOUzVGck9ialByL041NDU1?=
 =?utf-8?B?bVIxUkgwTVR2OC9HeXpCbnR6dHlWYThkNnJFRnZ2UnNYQnV5SzM1Zy9pVlNG?=
 =?utf-8?B?V2E2NUZPNkF6WXBIYTVXT2JPUjlhd0tSU0NkR1Z3amVuT1BTVXJZbzhhVXlO?=
 =?utf-8?B?Z2ZTbnZiZjl3ZTA4V0VENGZXZURVaCs5cW05QzZ2VGRGSWJIWlBkNGRKNEdZ?=
 =?utf-8?B?cXZPWlRwcEdPbjdEZ3M5VG9IdjBiL3lMQ2tDNTVEbkp5dEE0eDViWmt4MWN2?=
 =?utf-8?B?QmtYNE5zRUY1YUZMMzJ1K3piOVZ0WlVmQTJZTDBGeXI0UFlvWUFYMlRuRXlV?=
 =?utf-8?B?SFE3amRzcmxMWGE0enZwNitJcjRyN2xIb0N6dGtKK05vY2VGbEMzcmlkdUF3?=
 =?utf-8?B?YXNFOGdWVWUyajA2bE5jM1RFQ1BBTERBUzBWRFlRc2VOeUhyUkZmNytKc3J0?=
 =?utf-8?B?bEFpSHR4SGo4Y2lRaEltc29PRlZJSElaQXZtaWRudWRhZXIzcUxncFREZ1ND?=
 =?utf-8?B?L2dpcXE0YXVIMTJIa0lVT0pCTE1peXYrbUhXQ0pDVnlteDJ5WGoyTG4zRTds?=
 =?utf-8?B?ckNCTk5IOURmS08weENmN3JHdzlsSW5KSXRoWUg4SE9UOVFaWEtvZmJYUE12?=
 =?utf-8?B?WWF2OXl3Ni9WOGpqUlRlV1phN0s1UVdaK0Q0ZGlFSFZ2UGUxa3Q1RytzMWlR?=
 =?utf-8?B?NVZ0SXdTd1V6UVluY1VwNnlWVHJ6NGFOMEZjaFhENGc5eEh4VTJXYnZ1cy95?=
 =?utf-8?B?bElYK2NKbTh5M2d6czRIRktEcEozMnd6Z09aajFxNlArNlpJb0lJQUorNWRv?=
 =?utf-8?B?SHRUREZQUVViUUZ0OEVYTlVzTlVzS0hDQXZuWVF3bUpuSDBOZVl2enZnRFRu?=
 =?utf-8?Q?6Bbs3oKm0f9fo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0V0WERxOHRNK05iUmR2blVQZlBqeUxvaENoNmlsTnVMSlNDb3AyUGE3bkxK?=
 =?utf-8?B?UktCMUJ6RTdRWDNjTmg3ZHZrdWdlVnlJY2d1dVFUYU1uZ0xRK256WUJydndD?=
 =?utf-8?B?ZlBpa1ZFUTQzUFNWb3hyTWZqb1NidFIwbHhVTWVWL3lGMzJzSUdDbzFLVkw5?=
 =?utf-8?B?Q2JOTzVPYmZ1bkRaZjRROXpiU0h2QjBLTzNWK1FUOGd6OFZhWHFuM2l1NXpu?=
 =?utf-8?B?RDR4dWZPNzRMQW9ieHNxRmlIK0J5blpnRGtKcGRyVXlvWXpVMGd5QlZOYUhC?=
 =?utf-8?B?eTlqaDJySTFmY2IvTEhGVy9aZGQxU2d6S01FbVQ5OGdiTFo2MURDQVlnN0Rk?=
 =?utf-8?B?aFRnN3VTRE1PU2FFMmNRUHZVem84ZUh5Q3dIdjRCWEdvbWUwSWFZcVVtenE2?=
 =?utf-8?B?c0ZVRmJjeWdTaHg4RGs4bzE3R3QwVi9xTTI2SWlJT2x0aXN3cVBWWHNUZFpz?=
 =?utf-8?B?YURVZWxCQ0VLVDI3bEhlMEptKzhZS3NYTG9xVld0TGNqUmUvOS9yeUVkZWhm?=
 =?utf-8?B?bnFiLy9kVjYySUkyTU1JbHdGYnY2RE9yQ0pTNmpNRzE5SXdRTVJIOUFuM1pV?=
 =?utf-8?B?Wmtjcy9PK0NRc2xBdjE2N0M2SUZaWUlBVkhvYUl3MEpKdEovNkorQURRTFBK?=
 =?utf-8?B?T1ZOUUMrSWdVTWd5N0c3MmlsM1c2N2JMQ0JXUUU3UlJrV1dFZmtKQWZWdTZG?=
 =?utf-8?B?SmxqU0dXaXJmRHhpc0JIdDBadFhLdHJmZEdFOTZFaWd0TGV0UkFEdVpRV3ZR?=
 =?utf-8?B?VGNjRDI3ZWdHQVhsNEFPb1FWYVJTVnI0Y0NPNUxCZ1cxWDUxSVhkbHFWTDJD?=
 =?utf-8?B?eGh1Z2lJejA1TmhiK2Z0TDZHcXZPVncyNXlCRUxhUEFnL0l3SDNRZ2diZVp2?=
 =?utf-8?B?akRlWHVPbys4U29Dc24xdEM1dm9PUGFYZmt4ekNrNGR0QkFZSVNGNTFrZ3lG?=
 =?utf-8?B?L2Z6dC9nV0k1djVmSkFyQnc4K1h2alVPVFBSWWdPcDZvZGxOWlVuV3Q3ZnVW?=
 =?utf-8?B?OXd5cXVXcWlaZ1lXWHJqWmNpRW5rUEl4Zlk3NXdYSXNPUFRPR2N2K1QrdTlT?=
 =?utf-8?B?ZmI5SzVXNzl2a29qdlJQemZnc1BMZGVCSEtvVHdBbWFBNElhTXVYSlViSmpj?=
 =?utf-8?B?NTI1b0k3ZDE4VnpCVVByVHd3T3o1VUJXcTdjNU01RlQ3TGJtWDltdTJ3T0k5?=
 =?utf-8?B?QTJ2bWFGN1FGdFY4ajB6Y2tnMVdic2Zyb2VmL2pWZ0FNZEVNN2VPYnB3Qlor?=
 =?utf-8?B?amdIRVpRVUxBTmFIeG42WS9RRi9TWDhmNjkwNWFlQ1JMaFl2NkdveUl2dFFT?=
 =?utf-8?B?ak5IS0xZbEpIT0JUajBuVTFxYkc4K1UydC9seTBSZEZVQ3doN1cybUgrU2tR?=
 =?utf-8?B?eXBwV2pXbk9rY09HeklFREdCbVhadFJKMlpaUXBwTGU1NmIxazZPRDJHVkxi?=
 =?utf-8?B?eGpBL2RmRlYwckRGVUhFWEdyQUl4SWF5eVNURHhsMkNDcWlyY0l4TElIREd2?=
 =?utf-8?B?end5UHMxL2U3YS91T09tczhtR0ViNlJLUU1uRzFUT3UrS1lVS1kyWC9BaEF0?=
 =?utf-8?B?Y0Y5QmtTeFlZSm1qaGFhVTlWbWhRY1lMVW9JZjIwYy8wYTBSVlc5Q1NwOWV5?=
 =?utf-8?B?d2FWR1RHY0thc1Z1bnh2UFV2R2FJUnluM1dpRVgrTTA5cGhwbnQrVit2QXpr?=
 =?utf-8?B?YUVtTHVrU1Z6Z3kyb0NjYlphMC9Bb2hMaHNmZjJ3NDlaNG4zT0I0NVo4R2NX?=
 =?utf-8?B?cEtybFJSakt0TTlCVWhqbHNwTGFzaEJiWXBFRGFzdGxzMEE1SVZuNTdBMmJx?=
 =?utf-8?B?U0s2VGJGZDNITTB4bVh5b2d1MEZNYW5DZ1BaSTNNbDdMTzhTRmZLTVRSZExS?=
 =?utf-8?B?L1pzY2JKc0NLNkt5SmY3OFozUmpKVFVIcmVOTDNXMFJyVnFVKzFLYXNLMUNW?=
 =?utf-8?B?T1VmcGRDYXI3Qjg5ZU15WXVNRXhIbU15S2JoZWpudnM2U1d5ZWRVSHNPMDNs?=
 =?utf-8?B?MS9UdSs5eFBMbHg2M2tVWThIcDlld0pqSEJtM0gwTkZvNUVrVUw2V0RzZHVr?=
 =?utf-8?B?N1o2UGlnVDVWTGZEQXJKRGk3RVRZaVpCZ0Uwc3lPSnZFVHZObFlHQzBQOG9V?=
 =?utf-8?B?ZStUVExid3hHTXA1WDdiWjFCZEU5REtLYS9HamN1Q0lIMUl4Q3JUR2tIZzJu?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6c759e-9314-45f2-08a9-08dd56633484
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 12:43:44.2074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjTpAliaGkeiY0hX6y5pBHbsxatyq7fIKBOU40yGgMomHeUktaQvCx1q3Nh580pT+wnVxGLAr6yom4PKt9EJvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7552
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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



On 2/25/2025 5:41 PM, David Hildenbrand wrote:
> On 25.02.25 03:00, Chenyi Qiang wrote:
>>
>>
>> On 2/21/2025 6:04 PM, Chenyi Qiang wrote:
>>>
>>>
>>> On 2/21/2025 4:09 PM, David Hildenbrand wrote:
>>>> On 21.02.25 03:25, Chenyi Qiang wrote:
>>>>>
>>>>>
>>>>> On 2/21/2025 3:39 AM, David Hildenbrand wrote:
>>>>>> On 20.02.25 17:13, Jean-Philippe Brucker wrote:
>>>>>>> For Arm CCA we'd like the guest_memfd discard notifier to call the
>>>>>>> IOMMU
>>>>>>> notifiers and create e.g. VFIO mappings. The default VFIO discard
>>>>>>> notifier isn't sufficient for CCA because the DMA addresses need a
>>>>>>> translation (even without vIOMMU).
>>>>>>>
>>>>>>> At the moment:
>>>>>>> * guest_memfd_state_change() calls the populate() notifier
>>>>>>> * the populate notifier() calls IOMMU notifiers
>>>>>>> * the IOMMU notifier handler calls memory_get_xlat_addr() to get
>>>>>>> a VA
>>>>>>> * it calls ram_discard_manager_is_populated() which fails.
>>>>>>>
>>>>>>> guest_memfd_state_change() only changes the section's state after
>>>>>>> calling the populate() notifier. We can't easily invert the order of
>>>>>>> operation because it uses the old state bitmap to know which
>>>>>>> pages need
>>>>>>> the populate() notifier.
>>>>>>
>>>>>> I assume we talk about this code: [1]
>>>>>>
>>>>>> [1] https://lkml.kernel.org/r/20250217081833.21568-1-
>>>>>> chenyi.qiang@intel.com
>>>>>>
>>>>>>
>>>>>> +static int memory_attribute_state_change(MemoryAttributeManager
>>>>>> *mgr,
>>>>>> uint64_t offset,
>>>>>> +                                         uint64_t size, bool
>>>>>> shared_to_private)
>>>>>> +{
>>>>>> +    int block_size = memory_attribute_manager_get_block_size(mgr);
>>>>>> +    int ret = 0;
>>>>>> +
>>>>>> +    if (!memory_attribute_is_valid_range(mgr, offset, size)) {
>>>>>> +        error_report("%s, invalid range: offset 0x%lx, size 0x%lx",
>>>>>> +                     __func__, offset, size);
>>>>>> +        return -1;
>>>>>> +    }
>>>>>> +
>>>>>> +    if ((shared_to_private &&
>>>>>> memory_attribute_is_range_discarded(mgr,
>>>>>> offset, size)) ||
>>>>>> +        (!shared_to_private &&
>>>>>> memory_attribute_is_range_populated(mgr,
>>>>>> offset, size))) {
>>>>>> +        return 0;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (shared_to_private) {
>>>>>> +        memory_attribute_notify_discard(mgr, offset, size);
>>>>>> +    } else {
>>>>>> +        ret = memory_attribute_notify_populate(mgr, offset, size);
>>>>>> +    }
>>>>>> +
>>>>>> +    if (!ret) {
>>>>>> +        unsigned long first_bit = offset / block_size;
>>>>>> +        unsigned long nbits = size / block_size;
>>>>>> +
>>>>>> +        g_assert((first_bit + nbits) <= mgr->bitmap_size);
>>>>>> +
>>>>>> +        if (shared_to_private) {
>>>>>> +            bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
>>>>>> +        } else {
>>>>>> +            bitmap_set(mgr->shared_bitmap, first_bit, nbits);
>>>>>> +        }
>>>>>> +
>>>>>> +        return 0;
>>>>>> +    }
>>>>>> +
>>>>>> +    return ret;
>>>>>> +}
>>>>>>
>>>>>> Then, in memory_attribute_notify_populate(), we walk the bitmap
>>>>>> again.
>>>>>>
>>>>>> Why?
>>>>>>
>>>>>> We just checked that it's all in the expected state, no?
>>>>>>
>>>>>>
>>>>>> virtio-mem doesn't handle it that way, so I'm curious why we would
>>>>>> have
>>>>>> to do it here?
>>>>>
>>>>> I was concerned about the case where the guest issues a request that
>>>>> only partial of the range is in the desired state.
>>>>> I think the main problem is the policy for the guest conversion
>>>>> request.
>>>>> My current handling is:
>>>>>
>>>>> 1. When a conversion request is made for a range already in the
>>>>> desired
>>>>>     state, the helper simply returns success.
>>>>
>>>> Yes.
>>>>
>>>>> 2. For requests involving a range partially in the desired state, only
>>>>>     the necessary segments are converted, ensuring the entire range
>>>>>     complies with the request efficiently.
>>>>
>>>>
>>>> Ah, now I get:
>>>>
>>>> +    if ((shared_to_private && memory_attribute_is_range_discarded(mgr,
>>>> offset, size)) ||
>>>> +        (!shared_to_private &&
>>>> memory_attribute_is_range_populated(mgr,
>>>> offset, size))) {
>>>> +        return 0;
>>>> +    }
>>>> +
>>>>
>>>> We're not failing if it might already partially be in the other state.
>>>>
>>>>> 3. In scenarios where a conversion request is declined by other
>>>>> systems,
>>>>>     such as a failure from VFIO during notify_populate(), the
>>>>> helper will
>>>>>     roll back the request, maintaining consistency.
>>>>>
>>>>> And the policy of virtio-mem is to refuse the state change if not all
>>>>> blocks are in the opposite state.
>>>>
>>>> Yes.
>>>>
>>>>>
>>>>> Actually, this part is still a uncertain to me.
>>>>>
>>>>
>>>> IIUC, the problem does not exist if we only convert a single page at a
>>>> time.
>>>>
>>>> Is there a known use case where such partial conversions could happen?
>>>
>>> I don't see such case yet. Actually, I'm trying to follow the behavior
>>> of KVM_SET_MEMORY_ATTRIBUTES ioctl during page conversion. In KVM, it
>>> doesn't reject the request if the whole range isn't in the opposite
>>> state. It just uses xa_store() to update it. Also, I don't see the spec
>>> says how to handle such case. To be robust, I just allow this special
>>> case.
>>>
>>>>
>>>>> BTW, per the status/bitmap track, the virtio-mem also changes the
>>>>> bitmap
>>>>> after the plug/unplug notifier. This is the same, correct?
>>>> Right. But because we reject these partial requests, we don't have to
>>>> traverse the bitmap and could just adjust the bitmap operations.
>>>
>>> Yes, If we treat it as a guest error/bug, we can adjust it.
>>
>> Hi David, do you think which option is better? If prefer to reject the
>> partial requests, I'll change it in my next version.
> 
> Hi,
> 
> still scratching my head. Having to work around it as in this patch here is
> suboptimal.
> 
> Could we simplify the whole thing while still allowing for (unexpected)
> partial
> conversions?
> 
> Essentially: If states are mixed, fallback to a "1 block at a time"
> handling.
> 
> The only problem is: what to do if we fail halfway through? Well, we can
> only have
> such partial completions for "populate", not for discard.
> 
> Option a) Just leave it as "partially completed populate" and return the
> error. The
> bitmap and the notifiers are consistent.
> 
> Option b) Just discard everything: someone tried to convert something
> "partial
> shared" to "shared". So maybe, if anything goes wrong, we can just have
> "all private".
> 
> The question is also, what the expectation from the caller is: can the
> caller
> even make progress on failure or do we have to retry until it works?

Yes, That's the key problem.

For core mm side conversion, The caller (guest) handles three case:
success, failure and retry. guest can continue on failure but will keep
the memory in its original attribute and trigger some calltrace. While
in QEMU side, it would cause VM stop if kvm_set_memory_attributes() failed.

As for the VFIO conversion, at present, we allow it to fail and don't
return error code to guest as long as we undo the conversion. It only
causes the device not work in guest.

I think if we view the attribute mismatch between core mm and IOMMU as a
fatal error, we can call VM stop or let guest retry until it converts
successfully.

> 
> Both options would be compatible with "the caller must retry either way
> until it works".
> 
> a) is probably easiest. Something like the following on top of your code:

LGTM, with option a), We need to return the retry status to guest. the
caller (guest) must handle the retry. Not doing so with "partially
completed populate" would cause some problem.

> 
> 
> 
> From 40c001a57c3c1350f3a44288ccb013d903d300cf Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Tue, 25 Feb 2025 09:55:38 +0100
> Subject: [PATCH] tmp
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  system/memory-attribute-manager.c | 66 +++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 30 deletions(-)
> 
> diff --git a/system/memory-attribute-manager.c b/system/memory-
> attribute-manager.c
> index 17c70cf677..31960e4a54 100644
> --- a/system/memory-attribute-manager.c
> +++ b/system/memory-attribute-manager.c
> @@ -274,9 +274,7 @@ static void
> memory_attribute_notify_discard(MemoryAttributeManager *mgr,
>          if (!memory_region_section_intersect_range(&tmp, offset, size)) {
>              continue;
>          }
> -
> -        memory_attribute_for_each_populated_section(mgr, &tmp, rdl,
> -                                                   
> memory_attribute_notify_discard_cb);
> +        rdl->notify_discard(rdl, &tmp);
>      }
>  }
>  
> @@ -292,9 +290,7 @@ static int
> memory_attribute_notify_populate(MemoryAttributeManager *mgr,
>          if (!memory_region_section_intersect_range(&tmp, offset, size)) {
>              continue;
>          }
> -
> -        ret = memory_attribute_for_each_discarded_section(mgr, &tmp, rdl,
> -                                                         
> memory_attribute_notify_populate_cb);
> +        ret = rdl->notify_populate(rdl, &tmp);
>          if (ret) {
>              break;
>          }
> @@ -311,9 +307,7 @@ static int
> memory_attribute_notify_populate(MemoryAttributeManager *mgr,
>              if (!memory_region_section_intersect_range(&tmp, offset,
> size)) {
>                  continue;
>              }
> -
> -            memory_attribute_for_each_discarded_section(mgr, &tmp, rdl2,
> -                                                       
> memory_attribute_notify_discard_cb);
> +            rdl2->notify_discard(rdl2, &tmp);
>          }
>      }
>      return ret;
> @@ -348,7 +342,10 @@ static bool
> memory_attribute_is_range_discarded(MemoryAttributeManager *mgr,
>  static int memory_attribute_state_change(MemoryAttributeManager *mgr,
> uint64_t offset,
>                                           uint64_t size, bool
> shared_to_private)
>  {
> -    int block_size = memory_attribute_manager_get_block_size(mgr);
> +    const int block_size = memory_attribute_manager_get_block_size(mgr);
> +    const unsigned long first_bit = offset / block_size;
> +    const unsigned long nbits = size / block_size;
> +    uint64_t cur_offset;
>      int ret = 0;
>  
>      if (!memory_attribute_is_valid_range(mgr, offset, size)) {
> @@ -357,32 +354,41 @@ static int
> memory_attribute_state_change(MemoryAttributeManager *mgr, uint64_t o
>          return -1;
>      }
>  
> -    if ((shared_to_private && memory_attribute_is_range_discarded(mgr,
> offset, size)) ||
> -        (!shared_to_private && memory_attribute_is_range_populated(mgr,
> offset, size))) {
> -        return 0;
> -    }
> -
>      if (shared_to_private) {
> -        memory_attribute_notify_discard(mgr, offset, size);
> -    } else {
> -        ret = memory_attribute_notify_populate(mgr, offset, size);
> -    }
> -
> -    if (!ret) {
> -        unsigned long first_bit = offset / block_size;
> -        unsigned long nbits = size / block_size;
> -
> -        g_assert((first_bit + nbits) <= mgr->bitmap_size);
> -
> -        if (shared_to_private) {
> +        if (memory_attribute_is_range_discarded(mgr, offset, size)) {
> +            /* Already private. */
> +        } else if (!memory_attribute_is_range_populated(mgr, offset,
> size)) {
> +            /* Unexpected mixture: not completely shared. */
> +            for (cur_offset = 0; cur_offset < offset; cur_offset +=
> block_size) {
> +               memory_attribute_state_change(mgr, cur_offset, block_size,
> +                                             true);
> +            }
> +        } else {
> +            /* Completely shared. */
>              bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
> +            memory_attribute_notify_discard(mgr, offset, size);
> +        }
> +    } else {
> +        if (memory_attribute_is_range_populated(mgr, offset, size)) {
> +            /* Already shared. */
> +        } else if (!memory_attribute_is_range_discarded(mgr, offset,
> size)) {
> +            /* Unexpected mixture: not completely private. */
> +            for (cur_offset = 0; cur_offset < offset; cur_offset +=
> block_size) {
> +               ret = memory_attribute_state_change(mgr, cur_offset,
> block_size,
> +                                                   false);
> +               if (ret) {
> +                   break;
> +               }
> +            }
>          } else {
> +            /* Completely private. */
>              bitmap_set(mgr->shared_bitmap, first_bit, nbits);
> +            ret = memory_attribute_notify_populate(mgr, offset, size);
> +            if (ret) {
> +                bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
> +            }
>          }
> -
> -        return 0;
>      }
> -
>      return ret;
>  }
>  


