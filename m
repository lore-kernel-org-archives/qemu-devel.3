Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11809C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAvD-0006Yo-Hd; Fri, 14 Jun 2024 13:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sIAv9-0006YM-Hl
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:41:03 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sIAv6-0008Vw-GK
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718386860; x=1749922860;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HcQyYzcDNZk6+wfWzc6Jvk12sFR7PGLWOTY8ovI7XxQ=;
 b=BiPgJPfn7aIdyPNDz2xXXd/HkpR9d29Ox8qSZfFz+Z6FHVlimGXn4zK/
 XrrL/CZOgtGHHe1v19k0JFlZ8+2IFGWZyhr8rb9RTI5qoONYiXbN4KM5E
 jar2AhkxVeIei8fys6NrV/jA8QvH0vobE4M6TM7skE6qVkAjQcexhoClq
 Okdq8ceCR7YGhIHdfrHNe82op6Rw44FGgphUNCi7OdSd6OnI+11vTWeMY
 D/h7cC2aDVbA24onZWv1xi8CvRySosvl8X7GElPvE7LVEJQ0+VcyQ4zDq
 82tYUFXzqHxPqJjyq8Ex6VbA896V59dyUriD/z8rHH15n6f6PQ4Pi0Ukp Q==;
X-CSE-ConnectionGUID: yWn6rsbGRgSbYNGiNg2kNw==
X-CSE-MsgGUID: j6PjhwjYRfm+p33fET+TTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15122755"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; d="scan'208";a="15122755"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2024 10:40:56 -0700
X-CSE-ConnectionGUID: 76Or/oI/TX6OLlCZetn0wQ==
X-CSE-MsgGUID: bUXySFEvQS+OCNADUOIq7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; d="scan'208";a="45677887"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Jun 2024 10:40:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 10:40:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 10:40:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 10:40:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 10:40:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD9w83OUJypdwJn6+W6oHt+Jm8Y0JjzZMqMn48vgh68NIruZ3n25yY2Aiz1b2Ej7TJrS9uZZsJbVVKaKT0i60DyBbo3ZX7Gwuh1VV8mhFGdD7UPxSAGm74fcLSew5WH/WmHHyOUdiqLPNBL/gfU1g18j/IH2Ub7r8da5R/ct8cvHrDK5l1ybu66zC++Klj075a4ILvmpYXhL2XDWCs21U0rvfCLOpRHHV7jJKjlgInuaBDwUkKD+YvfG2u3SmRx4NP9iybUUiYmJlimENJjijp8o/YFiDa+zrgnj4XguD43qqF+tiWyMDO6RBNynXWvrLN6GIuxP6ODjdhq/meOjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoiQ9iDQgc84kEHV7D/UaXGELs47oua6jMDIXWLKZ1Y=;
 b=NZQ5QRNFLGuibmFtE/qDJMNsBQeKAxtwjtT9K2jniE9/wdQgHsDTJtncvKuZml3f9iB3u7IVVtZvZF6f9jZfqPyqkYimoqEivV1PYXXamaajWKDVqoP2mim1lKCDH2kvZ4aJaU8WT5wA6B9TmYaFDK0n63i7oHSPWhfaHMJqBf6tWkTg2RExM21p4evQy0RTJhJvhEniUhUv3xgFqpqkx9/soqk08fx9QpffQIwPkLkRedVy5DevdeylWzLY5DiKGmAM96vXbglX5XkXfA9E+8RH9ALB638fLwx9QSqreBtBNHr/gylUpGsVwzDLTXWRUHKulJbD+vRW+7cgnZQBAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by CH3PR11MB8237.namprd11.prod.outlook.com (2603:10b6:610:154::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Fri, 14 Jun
 2024 17:40:52 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7633.036; Fri, 14 Jun 2024
 17:40:52 +0000
Message-ID: <6e4aef36-a6e2-4a13-b728-49f6ce90258c@intel.com>
Date: Fri, 14 Jun 2024 10:40:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/2] ui/gtk: Introduce new param - Connectors
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
CC: <qemu-devel@nongnu.org>
References: <20240531185804.119557-1-dongwon.kim@intel.com>
 <CAJ+F1C+PG-Tf-ADFTgBGq5nvJSCEVhFW0Pk6a2Pf7gVurbJeuw@mail.gmail.com>
 <a89b283a-24e3-4117-b465-ab8d79252625@intel.com>
 <CAJ+F1CJ-4cWV81_YTit5jTEoY6FPTeu7u177pZzb61FhXw_j0Q@mail.gmail.com>
 <fa43009f-1292-49f5-bab0-618028c16045@intel.com>
 <CAJ+F1CLAJTZLHKa9_zVo=-GLRw8JHnzJT=G4fdLLsaS1sK2HUg@mail.gmail.com>
 <0fe76150-c347-40df-8d69-18a5d132d8bc@intel.com>
 <CAJ+F1CKsboFZ-fWUXrf5BSMKCY6boRAoTMVRLaHgGja2Eppx8g@mail.gmail.com>
 <d5c18317-da45-4751-8392-56acf8e87ad9@intel.com>
 <CAJ+F1CKOcw_cfCHj7vOYOcBs22=yqokS7Wmxk+WY06a1Mk60sQ@mail.gmail.com>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1CKOcw_cfCHj7vOYOcBs22=yqokS7Wmxk+WY06a1Mk60sQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::18) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|CH3PR11MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c97a37-2f1c-4f18-1793-08dc8c992321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWJsV29TZmM5YStSbTFnQUJaTTM0bVh3S1BRb0FEVm41ek5BZXBTc2V2Vzc2?=
 =?utf-8?B?bFQwNHdBNEpkVGw3M3VVWEdNVDN5aTNSS2ZBSTRYMEU2S1NiZFhNbHR2ZjlO?=
 =?utf-8?B?aFdyQTZ5Si9EVGxsWHU1WVBqdnJjU2EvellFNTJEeE9wZnN5QUxyeGNKMVNM?=
 =?utf-8?B?cEZKVG4zOXVDZlBuZ2dqS1FGVFc4SWVKOW45UE1ESDY1Rm1JLzRoQUs5VlJm?=
 =?utf-8?B?Z0RCRHV2MFhUSTZMaFRJa2cyWHFWN2p5MjVOQi81MDRyT1NzbEkydjJpM2Nk?=
 =?utf-8?B?eW9EdUthVTFvVlBROFFhT1FaTmFvamU1QVlhMlEydElwQUpxcVpCK1BreEZ4?=
 =?utf-8?B?UjFqL3dCNUlwZGV4SldSbnlmL2hYVDlzaFlQMHl1L0k3U3Vqb0V1cmFMeXJW?=
 =?utf-8?B?YVFjdEV1dDkxSnVnb1lTaDFiQ0VFSmxHSFNCb21WRXVjVFFrVVIwN01ZNThK?=
 =?utf-8?B?Q211ZDlsR1J3cHBtUkN4Y0hUdlJzOU1jWVQzN0ZyMGwvcHI0RU1rWXdDcW1F?=
 =?utf-8?B?MEM4TldsQ2xBQnFRSmpGY1lIUGJLZXFIOW82NytJcktGRUtmS0JhSkdZYkxz?=
 =?utf-8?B?NzVKQTBxeGFKVU1HYTlzRU5hb01VU09QS2VPc2lyc3l6ODg0N0NPS1kxdjVG?=
 =?utf-8?B?TldUK3hxaU9HekJFVFJHYWptVmk0c09Kbk9jMi8rMlhJNVhXSDhpK2NhMU9L?=
 =?utf-8?B?THdkU1VsSFpXdW1XcHo2Y3hDakdYN0ZGbms2emtYZkwxQTNMb05GV1RrRW5s?=
 =?utf-8?B?MEQrTFRDeUtKSHl0R24rN28rNkdLbnZtLzdPanBEM0JlZkVLenRld2psNk1G?=
 =?utf-8?B?aXRFbWlXNWd5ZnpJVTNTa1gwbWFFY0VlMXRiUnVydW4yK0EvcDg3OUNKa3NV?=
 =?utf-8?B?d29Td0ZPYjljcm5OYUQ2TU43enFicSt1RVZQbFhiTUIxUy85ZjVFbzhkSEFY?=
 =?utf-8?B?UGFObHJ5WVpsakE3V1dJWGFXWTNjdnJTUFprbUhGRXJqUEZBVFpSS3VFcGhv?=
 =?utf-8?B?c3pUbUVLenhCWEk4U05lYTBwZjdJY3Z2SlgrTFIrcGpnU1Bicys1Q2Zja3Vz?=
 =?utf-8?B?WXE4M3paa2tWcUdlUnlwRVlTdlV0RS9iTUh4REg3VFduMjgwTHVnNEpZZmpi?=
 =?utf-8?B?S1ZqQThrYUJ5bnRsQTZzcEpXU1d4MDNiZ3M2Q1MrMDdORkhkdEdXUmZ5cGV0?=
 =?utf-8?B?dncyTHFOU0paK2lpWm4wRmpVeDdsVFp6THJ2MTR3OGlsbjJvemY0ZThWNkZR?=
 =?utf-8?B?bTNjRmJSaDgrM2JIOVJTcUpNa0MyUSt2OHdTWDRzdkJWSStOK3FMZjZ3MUxr?=
 =?utf-8?B?VHg4SVE1V0N5RCtTQXZ3MmVsdGpscHU1U3g5Q0dGQjg3dDF1UEdVUkFDVWdK?=
 =?utf-8?B?a1FLc2tUQWVVWXh2YnBXbUxwbUlRbGo3ZERRUnFkc0VhcW43bVZkaFpFSTVD?=
 =?utf-8?B?Zm4yWnhOcm1Ka3RiY2V6b0JXbjNuY2NSMU01K1JEakp0cmNxOFhkUy90L3Ey?=
 =?utf-8?B?WDlVK094NTUzZ1Z1WTloRGRFMWdWNTdiUkVyekhzZGNTSDQ0SFhzeEdodEQw?=
 =?utf-8?B?QUJCVVJYREQrcCtOQWRoTGh4eUlIdGFISVNibDYwQmQvdU04QXkvRS9vancr?=
 =?utf-8?B?RlQ0akdSREtydzQzVlJibEtDc3VIWTBkWEI1eHZnQ2kwR2RUNWRzbWtVcnJa?=
 =?utf-8?B?VUNCSVA0UWZ2VUd1cUNFRmR2aEZ0VWVoK081UW5tRFhsdTE2dEZPQzhXU2tU?=
 =?utf-8?Q?L8G5GNN/YJJPCctPGUj0UCUt3wyzsFRn0ZsUnQk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlQySEltelRRYTFKVWxiU1phUWMvZ2ZGUnhVbU9vaEg3MVNyOXo2c05xRit4?=
 =?utf-8?B?ZjZWUk1LMGZPNW9IQnFUbUNnc09vS3FRMm84ZE5NdjByUTFEaU5WYks0cytD?=
 =?utf-8?B?VFl5S3Vqem8wOTM0blduYU9tQkR5cFVZTGF3REVmciszL1FGckM1dmJ5RUJu?=
 =?utf-8?B?ZEFaN2t6eW84dGNoYzBNaCs4aVlzeER6OEJ4MzJFSk9LWmdVNStZZkR4bUsw?=
 =?utf-8?B?Tk5uYmoxU1F6cW4zR1pUa281NjVJMjNKQk9OVERSR202ckJZa2pybm10WCtI?=
 =?utf-8?B?dkxrMVZTaGJISmc5S0RXWXBiN043N0taWnBxdWEzRkllYjh6d3NLSGZJbVdL?=
 =?utf-8?B?RGlvMUliclpOem1OVDFLallucklseDdlbDdFR1lFSW41eG5nd1BVR0NFcEEw?=
 =?utf-8?B?WlRqSWFKeE9XMkNUWUgrVVB2Rk5NbnR4bGU2S3oraDVZdWRUUWFxajNScFp2?=
 =?utf-8?B?V1E5Y2ozTWRmZ2hrdlFvcnJMbmtLWkR0L0dIOWltMGZnbzVBZXZmdWJMaEhS?=
 =?utf-8?B?b1VpQXpzRE02M2VZR0lmSll0c0xXMy9POUFUSjZ2VEVMRzcrbzNZNkl0ci9W?=
 =?utf-8?B?T1ovUFZZWUhwSlh3ZnJRT2IwOE9QaHA2aW42TzVBR3IzY0R0OGQ1cVU1dXNN?=
 =?utf-8?B?cUZqeDRzQnRaQ2xuQklDU3pHdHBzaEo1Q1JqZUFOelNsUllhZnBZQXpCMVEw?=
 =?utf-8?B?Q3NlT240dE9wZ2pXVnhzL1o0TXZKL1crYW5iRTZidGlXRnhLMUdOWnBadGgv?=
 =?utf-8?B?ZzVsbStYSlN6MUViTVc1Y0JFbzJ2a2FENTN0Y015RGFZU3p0QXA0aXpXNXdN?=
 =?utf-8?B?QVROS2hYZmFGc1c3cVpSL1FqeHRNRDlGSHY3QU40U3pNMjIzVUxJTDAvc241?=
 =?utf-8?B?UVFRRE1aVU9zL3R0bzhwVTEreENGZ0ZkaWV1c1I5RnRPNS9PNEpOMWpPVXA0?=
 =?utf-8?B?MlJFWk9vc0lxWW1SWmd6RjJ2TmNCMmlMZUxHR1UySmV2ZWRMbFZjOTE4bXUw?=
 =?utf-8?B?ejNqbnF6TCtCOWJuSVQ4SGJINy92Tjd6NGJodzVaeTB5U2V2azVkZnRkRDhK?=
 =?utf-8?B?RWFKbkJOT1FkV3dzMzZRVHdRZkxUbzVrK2ZaYXhpYkxvQyszT1VKcUFTaEZB?=
 =?utf-8?B?ODUrc1NuVStCQUVHQVdVazVkUkE4RmJkay9SbE9pTDhjY3d6bWFuaGVCcXFT?=
 =?utf-8?B?NWlObzdIOU9yQmJhRTJOa0ltb25ZMHVkUWNhM09zdkxYbDRvRDJFQ2tJRzJX?=
 =?utf-8?B?bHdnQXlzSnViUWt1c0pDaTYvdTJQdFdrQzZMZW5RZjV3T2FjTEhmSlNWSDI3?=
 =?utf-8?B?eDJLckxycTg1b29qNzRCNlR0UEhRdmhnZUFaN0FmUndLT1FMQlVYOHFsZWFE?=
 =?utf-8?B?YnovVGk2Z2lZRW5panhmdkQvdm9RSHlKS0JuTllta2ZWWmdySktVNUUwZUtu?=
 =?utf-8?B?K05HRndXS29qV1diNW93QnpSeGhWV2Q2WjFSWXh1Q3lRSFVDTmREQUs2cHN3?=
 =?utf-8?B?NTNwRkp6QlZnQVJLRDF4SGJQL0h3Nk1hV293K3F3Z3JMRGF3VHpqa3hWWTBn?=
 =?utf-8?B?Y3hTdU14MVRMOER0QU5OVWt3VjAyR1Q1L3NiTjd3QVEyR3lubnduQnVSdjlJ?=
 =?utf-8?B?aHhROEdkS0tRQTk4THdVN3h3dkVNMUN2SDVXcE12aVk1WERaaXE1eExyenV5?=
 =?utf-8?B?MnJzNEJ6dzVrVjJRaDNQVWM0dFpRQXZ2Z2xFeVRLUjQ1RVgzWTdzZFJPa1d2?=
 =?utf-8?B?V216RkdCNmpTVjVVekJtdU1QMnNEU3lnSE9oVWJsM05WWk1HbGQ1REdWZ3gr?=
 =?utf-8?B?cXFDUFZNbFovWThlQ0dFMnF0ZmExQWh0M1h4RGIrTjVBN1lueUdUcEwyRFJl?=
 =?utf-8?B?K2FRVkk2R0dpcFB4dHlaN1NrUXFndi9sdUtIckR0c0dKRkxLODg0TEsyTFRs?=
 =?utf-8?B?aC82c3Nhcyt1U0ZZMGJYaGY5QjNZVWlEcnN2VkRaaEhnc1EyYXN6SGFKWGhK?=
 =?utf-8?B?SDhhQUw4L21IQ0VBVDgzcUF0WTBNbGZ3Z0crL0lpaTdBdXFhRFc0Vmhib3dO?=
 =?utf-8?B?OGJjQnNwbkp5eWZ1SWIrNEZoVEs2cUdjZ292VXE5K1hZWmVpNlZhenR6UzhE?=
 =?utf-8?Q?BPGAjZ4oyMXK4Ev4uzl7OOE13?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c97a37-2f1c-4f18-1793-08dc8c992321
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 17:40:52.8114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpFo8WJmJB8qB1EyJK7M0yXZBKSMOuyQgtbxJfWleN4R3ruXQdjwh5FnjPWiVfu+rOmhwROlEB0/jwrKbdMU0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8237
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Hi Marc-André,

Ok, it is good to know dmabuf is used for sharing the scanout between 
processes when using dbus or virt-viewer.

BTW,

I have some more comments on your previous answers. I just copied ans 
pasted your previous comments. Sorry about any inconvenience caused by 
this delayed response.

[Marc-André] The plan is there, GNOME has made bold moves in the past. 
There is not much left in the TODO. But yes, it takes a bit longer than 
expected.

[Dongwon] If Gnome abandons Xorg, then users would find other distros or 
other desktop environments that support Xorg. My point is why should 
Qemu GTK UI not support those distros/environments that support Xorg 
today with new features? If maintainability is your concern, again we 
can offer supporting this feature as long as there is a distro out there 
that supports Xorg.

[Marc-André] Intuitive, perhaps. Discoverable and portable?

[Dongwon] We thought about doing the multi monitor mapping similar to 
how virt-viewer is doing it but we chose monitor labels because they 
uniquely identify the monitors even if they are repeatedly 
unplugged/plugged which may not be possible if we use integer IDs to 
represent monitors. For example, if virt-viewer client identifies a DP-1 
with monitor ID 1 and a HDMI-1 with ID 2 and they are both unplugged and 
HDMI-1 is hotplugged first, I don't think it would probably ID 1 with 
HDMI-1 as there is no way for it to know without the label.

[Marc-André] Interesting case that could be added to virt-viewer if it's 
necessary.

[Dongwon] The implementation might become very complex if we were to add 
the "hotplug" functionality as opposed to the simplicity with which it 
is done with Qemu GTK UI. And, it appears there is no flexibility to 
make policy changes such as using monitor labels instead of monitor IDs. 
And, btw, from a quick look, virt-viewer appears to use the same 
API(gtk_window_move()) that we are relying on, so I guess a similar fate 
awaits it if Xorg is gone or it switches to GTK4.

[Marc-André] Honestly, I don't support the idea of duplicating this 
effort in QEMU.

[Dongwon] That is unfortunate. It is a similar, but a different feature 
with "hotplug" and labels as its core as described earlier. I think it 
may not be a great idea to force users who are already using Qemu GTK UI 
given their use-cases, to use virt-viewer (which adds another layer of
complexity) just to use this feature.

[Dongwon]
Thanks!

On 6/14/2024 1:41 AM, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jun 13, 2024 at 9:08 PM Kim, Dongwon <dongwon.kim@intel.com 
> <mailto:dongwon.kim@intel.com>> wrote:
> 
>      >     "hotplug" functionality where a Guest display/window is
>     deeply tied to a
>      >     physical monitor to make it appear to the guest that it is
>     dealing with
>      >     a real physical monitor.
>      >
>      >     In other words, when the physical monitor is unplugged, the
>     associated
>      >     guest display/window gets destroyed/hidden and gets
>     recreated/shown
>      >     when
>      >     the monitor is hotplugged again.
>      >
>      >
>      > Interesting case that could be added to virt-viewer if it's
>     necessary.
>      >
>      > The subject is sufficiently complex that there is already additional
>      > documentation/specification in:
>      >
>     https://gitlab.com/virt-viewer/virt-viewer/-/tree/master/docs?ref_type=heads <https://gitlab.com/virt-viewer/virt-viewer/-/tree/master/docs?ref_type=heads> <https://gitlab.com/virt-viewer/virt-viewer/-/tree/master/docs?ref_type=heads <https://gitlab.com/virt-viewer/virt-viewer/-/tree/master/docs?ref_type=heads>>
>      >
>      > Honestly, I don't support the idea of duplicating this effort in
>     QEMU.
> 
>     Marc-André,
> 
>     My assumption is virt-viewer might not be able to completely replace
>     GTK-UI path in terms of performance and smoothness of display update as
>     (I think) frame copy between processes is implied, which is same as
> 
> 
> There is no frame copy when using DMABUF scanouts between qemu and client.
> Iow, the performance difference is negligible / noise level.
> 
>     spice-remote viewer. What about display-bus that you have been working
>     on? Would it be a good alternative w.r.t perf concern that I specified
>     above?
> 
> 
> There shouldn't be much difference for the local DMABUF display case.
> 
> 
>      >
>      > --
>      > Marc-André Lureau
> 
> 
> 
> -- 
> Marc-André Lureau


