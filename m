Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66077C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 08:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTdCi-0003vC-CY; Tue, 16 Jul 2024 04:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sTdCg-0003tX-DU; Tue, 16 Jul 2024 04:06:30 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sTdCe-0005lq-EI; Tue, 16 Jul 2024 04:06:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721117189; x=1752653189;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xb+sTNK36j6nvBt4TXLNGLWJnqcrrXYz4DUnV1CTnZk=;
 b=VDfuqlE3LKZrRXrvgkbYG23D0LmpNYx70G7ZcA0nYM4Fz2vajJna60TF
 yXNK0JJH7Muw1j9mjVPRH46JmoEc0m9auwYCu0uZ67gZ5rvKxsH2RrBMn
 HjhgXEZ+WRQxozxdd6z0Ul71H8D82l247OgwL4lbuge/ibvr1GGu3eKQ8
 JssrJJ4XcIMhcyFUVQdtbPtGjaBT9DgduONKMiADwx3L3whPDdtLo2xV0
 2m9t5oz1Tp5yHv0UgaE9u1s5el+NmCyaPu49AyuYMpnNsA6d6dZ+nLCUL
 kW8D+NXoMX6dqiFwl0ALU4onvxga2NYNjX0piSxAqmxLB/xqE9+nH+9FR A==;
X-CSE-ConnectionGUID: PH1DL/wVRVm+5wVSwlbnkA==
X-CSE-MsgGUID: 0DLv4z8rTgSDN5Fr0+x9YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="12567327"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="12567327"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 01:06:25 -0700
X-CSE-ConnectionGUID: cX97gJD6Q2eO6jzzoA+qWg==
X-CSE-MsgGUID: SZ/xydZST5yGoRC0WRGE1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="55075729"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jul 2024 01:06:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 01:06:23 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 01:06:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 01:06:23 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 01:06:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNckEgdKn7cLyEUeVX1BdSc1y0tvPHhIi9H47nwJXem9AhW4RB/UjgA36C6K4blsDed/PAhnRAr4JgitxvqlPRyugVCD/gEwCUeBypT+zbIQpTaKD8uCZAW0J/DR+FKts1myrlq+aeoGietDaK2hwxuz90yXwTCpR8DE63NlSzRRBnCtlB2GazeOPvB/NLekH5i0cgpbKxM0HmPrZ5CePGjiHjWO7Jvj9ROAy2E87smxe5gJjNceOrSgc/oNhEDJv3qHIUB5TT6/d39vB3NkbuKsPpToXgQuUBmy1AUhHAPt5YCFhyzGHL1P0t/WYSxLoOiaCcoF447L9kcrLFtBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9IxLhpoDcRWlm/4jQmkZOznCjWENLeCA2S/Q6D3y7c=;
 b=bgEfLKJyUKOYR1SbZcc6OoETZNp+YraHYJD+gdWiHwnYpLUgiAJmS9TkNnDa2CkMICW6+ON4TdPnmNc5uXaB+gIaGqCg3pVhDkSQ0I249jahlJCbIrq97CyBbZpUE/VTz7R1SKWzuQ94ajkoWYzCbhZPdKRzri9J2CRycXeB3msRQ5PDZ0Z93OcDkmSLFUiDd0Hw6NV+PYhtOLJcwrpUpBtczuOtYnN5alQcY8AJmxoVNjIfXGzxFe6H0LDnQDDk4MB5+NgZO9okoHrJgKpzGix4bW5TCTjUeZn4kIhz16jJU+capLZHcNS0q10DRjd1Im0uMfd4xYRgaCvjjkPs6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6389.namprd11.prod.outlook.com (2603:10b6:930:3a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 08:06:21 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 08:06:21 +0000
Message-ID: <2984776e-4857-4056-8f34-8152c3813fa7@intel.com>
Date: Tue, 16 Jul 2024 16:10:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] backends/iommufd: Get rid of qemu_open_old()
To: Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>, "Laurent
 Vivier" <laurent@vivier.eu>
CC: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Markus
 Armbruster" <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-trivial@nongnu.org>, <qemu-devel@nongnu.org>, Eric Auger
 <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
 <20240715082155.28771-7-zhao1.liu@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240715082155.28771-7-zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY5PR11MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ffe765d-d37f-497d-7cde-08dca56e2d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2R6TEpnRzBvRHk5aytaSVhMMUZUSlFOa0pkeUNnN2Z3dThCb3UzWnlIcnhM?=
 =?utf-8?B?MEE3K0hCcm1pQUM2N3dSbUV2MVNxSEM3SW5LVFRkckZISkVmaGhCenJIQi9D?=
 =?utf-8?B?c3ZsWk5xa3lLOEVxRTJjU1RXSUcwQmZwcDlLRElOdmlGM29zRjRSTVdDRjlr?=
 =?utf-8?B?R0o0YlV3WGpFZVBtVmlEWWNxRHQ2SjVzdkRhNFZWZU9nM0lJSnJES21DeSts?=
 =?utf-8?B?M3crVTRCb1dsWVVlbjlYQk5VajNveFN2ZzBhMWtGZVoxRHE2Wk0vK3ZabGdp?=
 =?utf-8?B?TlU0ZmVxVytsWG8xZUptb0hCbldsVGViaFYzc1VJSXYyeDhyd3VsK2taZFR6?=
 =?utf-8?B?NHdUbitJOTZjdUlGbXhNeDdPQW1zQkRQTUJOQWtYdnBTc0Y1a1lJQ0xTOTlt?=
 =?utf-8?B?LzZIakZqVUk5YVlQaDVOYUN4bmU5TkxXUythUklzbG1YQmpNNktINkdyVzFr?=
 =?utf-8?B?Ri9RS2tSVHBnK3A3SkJTRG96amZiYTl6UWZyaUtMalIzRDk1NEswYk5PdEpY?=
 =?utf-8?B?UzhyK216ajdHaldONlpvUzFNM1V3OTVydkdMcndxcE5WMlM5OS8xaUlrb2N1?=
 =?utf-8?B?dm5aVkV3MkswYTdYQ3VjbFBrMWZza05Td211SElBUHYzdW5KNlJHR0tFaVdZ?=
 =?utf-8?B?ZmxqMll2dUdSaHdRb1daWmhxbEs1Qm1XZnJUK0VJQklRODllU1NNT2lCamJI?=
 =?utf-8?B?NmNLdFh2UGVFdVlHYVA3V3BaVkI3M3piNEx3QUN3dDdJUzFBelBNVSt4UHJz?=
 =?utf-8?B?VmtZclp3YVhCaFJSOHgrZllsNitDeFFmTWtiUWNUK2xRWXJVdzlNWHlTTUVC?=
 =?utf-8?B?WUpsaFExcElCY3RtUVFHR1podUMxYjJJRVM5NnJwcjF4SWJMdmE3S2pFZjYx?=
 =?utf-8?B?NTFPRGV1dVMzR1BKaGo4Y2wraU5JVTFmZW1ENGRFSG5Rbk5QUkN3VFVzWDZv?=
 =?utf-8?B?SjJ3ejdDYUpUQnZRejFRRnRCV1JOQnUxR0cxNmhvSjVnMmx5WlpQL2lVVVo2?=
 =?utf-8?B?ekVyK0F1TlpxZzZtSWFDZWdObFVzK0lvVUNxanlsL1ZVa0NzY2NYcjBnSlJD?=
 =?utf-8?B?MDM1QkF5b3J5RGk3TDRHLzl5WmpSbFlJVnRPMm9XSVBla0g3S1FGTGVzT0lI?=
 =?utf-8?B?d25YNnhsSXJoTlIydjJxZ0FPVFhjSVZBcmtZYUZaVUo5ckZKZnNmbmdWRGlm?=
 =?utf-8?B?ZUJTNlZVdEcvUTgwQXN0Wm9pMGExRlRWN203ZTRBWmZpeGZoaW1wTVRXWG1v?=
 =?utf-8?B?VnlmeDV2N2VUOWVpWFpCUzlRL3VGZUNWdk84WVlvcW53OWppbm1HUm5DNndr?=
 =?utf-8?B?TGx2U05Ea3FKNUZYSm9oM0luTkdPM3RYRmYrV0RiSnRwL2RtNnVvOS9mSENT?=
 =?utf-8?B?bllUKzF3elZHd1cwZzdFU2JHc1FzYXNwSWlvVllGUlhZby9XNUNlWkhXS0gy?=
 =?utf-8?B?NlMwWVVNZ2ozZlFPSSttdjRSZ05iUGRIMm1leFBLRVVac3VHM2R1L3NmUnk1?=
 =?utf-8?B?OEttQ0dqcWpPdEhhdjRjWUp5Nngrd0t1QUVhemNYNlYwcG1ocTFrMXBZdlJP?=
 =?utf-8?B?d2x4RG5jaHBNM052RXhTMGlMWVBoNEFSUG12azRCa2xacU50NWJGenlmbVpl?=
 =?utf-8?B?Qml6S2F4ZFFxcTBtUWd3Q1V6bG5lUU5qNW5XTDRMUHNBejg3VUZCYXc4WmNP?=
 =?utf-8?B?ZkxLLzE2Qm9xeHBGa012ekxuaVkwVktuN0xyM0J1cmJMTXk4SEM1SmJPQkZz?=
 =?utf-8?B?NVJab1ZFOWdjQkN4dHhlZnFhc1RNL2tkdmcwU0FvV1JDYXBEeUU4YUdLcWtC?=
 =?utf-8?B?UzlWUlBVSitwdFIwUmhLdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEppQmxGeGp1dVQxWkR1RnFrOERuTkk2SUJsOXVZTEdHVXlZUWhJc1F3VUJ3?=
 =?utf-8?B?UlpKc2dGZXdmb1ptazEwdUhxcW0yc1NGM29oWGUvSGFzc2xxaUVwZFdQQ0Mw?=
 =?utf-8?B?dW10OGFLUlgwazhqdnBYZmdHUTF3QnVSc2lvbFRxNy92WUxua2I1WkhWZW9D?=
 =?utf-8?B?amw0WUJleDFzOFUyYXFaMGZKRUpuMEFzUkhCZGJWOTc0MG5NMHNkM3RlRzlT?=
 =?utf-8?B?VThNNTdSR1NzVDN0TFZJT2RyVkhGVllzU3RBK1dLMzR6ZUg4SHNQVDZDa212?=
 =?utf-8?B?T3JIdmtraFk1NlJ6VzVTcFRBTG43MzBBY1Q5eG9HcUJLTVQ5dk9TbHlDdGMr?=
 =?utf-8?B?SDhhdlRtZWpWc2I0TjVtc0FzWnVtRm5QdExHcVkrdW9IdjNBN2Z5eU9vbFRj?=
 =?utf-8?B?SmVqV0VMNzhhSGVrSjRiZTEydjI4NHIza2RULzBtTkp6MHNDSTNXZHZiRFFE?=
 =?utf-8?B?OStmcTBBOVNXc3NxVlMzdzFxUUtTUU1wWjJWaFpkRHVCNU9VUVRUdXBORWN1?=
 =?utf-8?B?Z1NHUWJLem5IQnhLQytKbG9XOHVVTFVDVXQwajRLZU4vQXVPZ3d5azhHL1Bn?=
 =?utf-8?B?cFdJVlllZTkwOExwemc1RFNSOWhyUktHTE9Mbm9jV1htUmtvOHZHK0JZSW5r?=
 =?utf-8?B?MjRiMVhkK1FiS0o5NjREdjFsTXV6aWVmS2tVeHdabnF6T2lFQ1FnUDZQNUxa?=
 =?utf-8?B?WjlMMFR1TURrRVA3UGZ6QUhlWWZrdVRtcWcyQmJ3TGVpeUNtSTF1MHNLa3F6?=
 =?utf-8?B?dVlYRUZhT2R3ZGovTFl6SU9nRnlsLytzaEJ1QndiR1U4QnhvQUNhT05QdXNl?=
 =?utf-8?B?R2FRTUlkQksrczh0ekNia1lKTlRvMlJVbUJEb2lZRm84aTVodWNJSHhvOFpy?=
 =?utf-8?B?U0s3N2JKc2x1dVg3dzhIcHR0VmFnZkFFQStTK2t6b0djUGFvRldNTDBRMXZK?=
 =?utf-8?B?WUhUODlrck4vSlZldlpJWFpUQ1EyL2dHZ0RpR1RsR09VbFhxemJkelRMVm1Z?=
 =?utf-8?B?RjVHeE9uRXR6U2hmd1BaM2s5RzVvOWhuWTd5djJwSTh2TE12NEY0ZHFrWVU2?=
 =?utf-8?B?UnNlOUlPR1hGTGRDaGl2WWlJWThFL1g4ZFlpc1BRVlhKelhicXdLcW8ySGtP?=
 =?utf-8?B?enVPRXlDTFR6ODdGSjlnOEhuc28yK0ZsTXFxN09TRHhDZUtaVmQ0Qm83TENL?=
 =?utf-8?B?WFl0QVZaK3N1RVMwbWZDT2FqbW1FdDdmQnloRXlaaEYxalZFK0hMcXFSNTNN?=
 =?utf-8?B?SSt6eHdjRlBtQjQvY245MEJCcUVwd0NRSmNudU5UVmp0SWJaaU1Xc1VQd1ZE?=
 =?utf-8?B?b1V4bzhzT0t2aGU1YmExM0FxVnIwbk9zSmdGdWxLempRUTJkdzRsb3pjWVdJ?=
 =?utf-8?B?cDFHUTE4TEptQ3Rib2R3azJLMHlvYkE5KzVWcWZ5MXdoRzZTR0phV3U0WStZ?=
 =?utf-8?B?VkNtZnhvY2JzazM5dXpzQmVTeXhqd0hFU1R5M1BEbU8rWk5haEhJYlFhRmRh?=
 =?utf-8?B?SHdOTElUMlZyRUpDZzBuTk5rTnVYV0llY1RDL3M4MmhtU0JBcUIrK1haeDZJ?=
 =?utf-8?B?dzIvaHIwamVuUFdZT3ZtcWlmb3N6VXQ3ZXZNbzFVOXlOVzJ2czl0RTd6Z1JE?=
 =?utf-8?B?QzZ2dng0ZmI3RTFXckw0bnhQWU5QVGxRQ1RqdlJJYUw4enVwekFjdkwxenNr?=
 =?utf-8?B?MWhqZXBxSE1sZGhDTlpoNi9vQlZkaS9pRDFXU2ZibkQzSGhucXVaR0xubm5u?=
 =?utf-8?B?b1JVMWxxTTZHNG01N2xDMmlMS3R6S0VJamV2cG8vRit3K2ZTT1VCbUgyK2pH?=
 =?utf-8?B?UjBocDV5Q0xEN3lqbU9tTkJzVmtQV2pWNFlDZXEyQ29jelc0dzZ1T0FwNUNH?=
 =?utf-8?B?NFBYWDU2ckIvVFZkMU1kd2VEQ3BxNHBsb05scllMZWpEQUlRUlltS2E5OGdl?=
 =?utf-8?B?amVlaWR1SmhtQTNvTmNQWGdlOXBKeTJwTVdLY3hKV2xrUHI4OGtmMFhuclFq?=
 =?utf-8?B?aWg4R2lhT09aOXpxTlA4bTZHaWFPU0ZRZG1ISnJKeXNUL1RCQjF6WTBaZ1VX?=
 =?utf-8?B?blF6bnBtMkRYV2hzWVhjczYyQmtpa3pQay9ldEljVXlUSzBXcnU1cjBxdlBC?=
 =?utf-8?Q?0Jg1VcWln1UwvHHPxqhP/HE9L?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffe765d-d37f-497d-7cde-08dca56e2d85
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:06:21.1347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Gv0rkwNE3aeyhg1/Mw7p5IGWc+/YQMEpX2Mli2lbkuWpj5auGxsxBPfxtXY4f5wbtc83ab23jbK3RMX1Yznxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6389
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16; envelope-from=yi.l.liu@intel.com;
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

On 2024/7/15 16:21, Zhao Liu wrote:
> For qemu_open_old(), osdep.h said:
> 
>> Don't introduce new usage of this function, prefer the following
>> qemu_open/qemu_create that take an "Error **errp".
> 
> So replace qemu_open_old() with qemu_open().
> 
> Cc: Yi Liu <yi.l.liu@intel.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   backends/iommufd.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 84fefbc9ee7a..cabd1b50025d 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -77,9 +77,8 @@ bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>       int fd;
>   
>       if (be->owned && !be->users) {
> -        fd = qemu_open_old("/dev/iommu", O_RDWR);
> +        fd = qemu_open("/dev/iommu", O_RDWR, errp);
>           if (fd < 0) {
> -            error_setg_errno(errp, errno, "/dev/iommu opening failed");
>               return false;
>           }
>           be->fd = fd;

-- 
Regards,
Yi Liu

