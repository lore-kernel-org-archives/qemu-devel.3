Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A1AD68BE1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 06:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW7gf-0001bs-89; Thu, 18 Dec 2025 01:40:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vW7gd-0001bb-SS
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:40:31 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vW7gb-0005FR-Mt
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 01:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766040030; x=1797576030;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UVu0BzH5SOZMVMTdYj3UFYJ1Q8F7AWIFKTjGLenRnkw=;
 b=KP8z8WYohyy3x6i0WxK4yTPB/HUn2kAZ5ZozzOCrobL/iRHlF6y2f7cf
 4ZfDSqY9OCU1YlRQptlBo9hSL6C5hlo4atJKuLvVS3CN0BVRX2g7eQS/2
 jtQTh2pMOHR6/TYsIdllfKac9AJbDzVhuBsSHogrSVOl/+6AXncHguH6C
 Aub2NuEVQiGo5kJqdxvj9fRjAB68W9/6WhwBUMCFz0/3KGb2Cz9U+Aeey
 +Z9qX6h2fEJadszpNSzDkC+kZL6Z0R8Za/sv7svi5iHHohJNcu5OJn9/7
 7YjYSWNs55e5/IMUB0MyHTQ2vaXp/FREln8CpgY0RoBW80xMKZVcOoe8a A==;
X-CSE-ConnectionGUID: mY9nYAn+T7yb16GQ3hQv7w==
X-CSE-MsgGUID: vKR+pooRRq6z9gKUPzg9zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="93462664"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="93462664"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:40:26 -0800
X-CSE-ConnectionGUID: WE/hSJqlQKqxs+5xyMcyZg==
X-CSE-MsgGUID: ZSfiFRuMSe6NdzGwVe9Ekg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; d="scan'208";a="197661823"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Dec 2025 22:40:26 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 22:40:25 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 17 Dec 2025 22:40:25 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Dec 2025 22:40:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gm2f7CT7UH6qP0janxDzpc3AUWmEwhA/Qun6DDjLB2HIq/G+ZwvdGJ5vt1pH8gGHHrYplWKCKQuQjTooFEgehKwbsvVaOklOPXfN8pAY3/FCalNDZVFQsjyPilvmCkNSO39H4hElnds7G2fn9HBN3ClGYfdBTS2k5YAwnsIr7cU6IE1izaZCY6wom4qqVKGc1TqKm13ksaym+yBAOQ52H8cHCVjEbEQ4so/57YuFpC6Fyh2gUpXdKjHxXHSVJCpzlYWUIxihyrI5rmshgpzJUH0bjveyhicksJ/lZrUWGu6XdkvFnRlGsHE3gH+Dn4C2UT5Cpfe6mpy9xl0pcVYmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxFuPjhe6ecVepJgMO75OiO3pzNADzrTtFtc57PIIqY=;
 b=W1PZxiq8GiQnOYbDy5yMVmtz1vDSKZpC5q+qeKaqpKVpSe8mgfJccB5BMapky/3DM0px2cOl77LC+vsO4G0ZfvOtzd1Zt830mhjJuQpKTy6A6zlCBqLrenb+Dayu+TzfNL0ZRaBQZzNfqai6UIL6PZ+4fudJiOQwCPJclQzMTP24PhYmn1ULAsMgugI3dyzzaaIXtzJqmazRnoW1eUbrmeF7Vh9wdJV+uEl7bHdV0oStK5V6hX3FlFoIwiQfvSF8JGXwJmhRY+OiWQVj5EcX4L7FHRla3NM8PdXD39llZmHK7De6H2s0jK+hvRGJa1HCEqF/SG+5FhrC3JPIT8cgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by PH0PR11MB5878.namprd11.prod.outlook.com (2603:10b6:510:14c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 06:40:22 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::2e98:2a3a:ea82:c1bb]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::2e98:2a3a:ea82:c1bb%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 06:40:22 +0000
Message-ID: <a89735b3-a914-4626-9103-2f41d8167d77@intel.com>
Date: Thu, 18 Dec 2025 14:47:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: How do i know which "iommu" i used on VM? qemu emulated or
 hardware DMAR?
To: tugouxp <13824125580@163.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
CC: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Michael S.Tsirkin
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <e29aa4d.52b4.19b2a89a442.Coremail.13824125580@163.com>
 <87ecot2uj2.fsf@draig.linaro.org>
 <8cb142e6b6bef3bdfd8329322a4a9b5d5921b001.camel@eviden.com>
 <5bd1d463.282d.19b2f173883.Coremail.13824125580@163.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <5bd1d463.282d.19b2f173883.Coremail.13824125580@163.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|PH0PR11MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f66b09-4a1a-49b6-4cd9-08de3e005184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWpna1NWTDAxWjBkN1hLQmt1VDBrcUs5TmhSb3JHUzdLK0hZOFFkRnJrcHRW?=
 =?utf-8?B?bFZOZFRZbzRBL0dickpvNHpCV21sK2k2ZndWc0JaZnJKdEI2RG0rSlRydWxS?=
 =?utf-8?B?TFJUVkVGTnVtRVdqb3pySlFvYUNDQ1N6VGM5ZGpPN0tQa1RQZ1pEeVJEQ2ps?=
 =?utf-8?B?Uk1nSFJib2VqODN1QXVoK3JNb3FvYjhMT3ZSNWpJSTdoVThGSDhZbklHajIr?=
 =?utf-8?B?S2xPRUZzQXR1M21KTWxRTmRWa1BxcWVwV1FEb0VkbkFtVEFjSTFCanh4T3Qz?=
 =?utf-8?B?SzdEdmpHSFpJTmZPRCthY2VwckZPbkJLZGxTejF3NkR4WFR3ak50TFJDMTlh?=
 =?utf-8?B?NHpRVWdLbXV5NEx4cjd4alJuYjJsNDluYVR1VnRDVU5COFdpdWxsNTViTUNa?=
 =?utf-8?B?ajFtcDk1Z2V0WnhkK3FiWWlkeHpmejJsNzh0SDEzdjhkeHBEeTdwcjRYNHdi?=
 =?utf-8?B?T2F3V3l4clBPUWdiZ2JGMGdidzRiTkIwSndXNyt4RTFTaHRacFVJZ2dRZGpY?=
 =?utf-8?B?cWdKRGtObWovNDlCWkY1Q1pLNGZDZEYvNXdYV1k1cEQydlhVRVY0M09GT0hn?=
 =?utf-8?B?enY5UWRqbTlFbXQ1ZzZubVg0TllackdMcHAzbjRiU011Y2FaWUsxT1ZtZWY3?=
 =?utf-8?B?WjRZa3VxcllnQlhXNUxxdE1Zb2kwVDcyT0d0MEpRZ1dDdFQzNnFodUtwRk1q?=
 =?utf-8?B?U3o4SFRWOWhYSDdHUFp0MVdIWko5V1BwNExEdkdWeDIyaEdCSUFkaG95Q1M2?=
 =?utf-8?B?ZUxSVUFhRFpXRDZLNUFjUS9GL1BrWnRkWDNYdzlRYXE5UEpJYm1zSHZQVlpl?=
 =?utf-8?B?MG4wTjFhckNTUEdsTTUxY1lLM2N3UTltOTRyWlR2MmxJeCt0QnUweUgrcDdk?=
 =?utf-8?B?dVFuUjVlK2pDOG9CSS9DS0g3V0dnMlAyejNuOXZmMDQvcnZkN3F3T01aeElR?=
 =?utf-8?B?QjA2SEJ2cjd0dThvKy9kcEZIUTVScm43WTcvdjBVSEVpeE5nN0J3b1U2dHgr?=
 =?utf-8?B?R203N2NCdGtDUGRCYkNmazN1MXp3V3F3cGZQVWVsTjIzL2lWSFY2MmlYNlBq?=
 =?utf-8?B?TTFmQjRjaGFJK04vZ0VGUXpQQXVQR1RDZytYNW9YdmNKRnRwdUlaOE1qUE1Y?=
 =?utf-8?B?K2lZNGlYenhOOE9NS2Y5cjhYUGNrUm8rZ0lRM2pBeVcxRU5takFXeG9JbTM2?=
 =?utf-8?B?azZjWUJTV2RGaHQ5dVhxcHUzMllER0d2WmFKNlhSazVvbnM3UVRUa25DaDlt?=
 =?utf-8?B?d1ZZWXBldFpmVGJHdFVYL1VTWnhwT0d3Rm9IWHp2cjJLT0ZZTTI4UXgvbDBT?=
 =?utf-8?B?dnJwVmZ4S2lGU1FyRTk3WStKUjhqOTdEQkI5dHE2RlQya2taNHN5OWsvRjd6?=
 =?utf-8?B?RkplWlFleTRIVWhwK24xemZCZDB1MUZRQjVEVTVOREtsdnJJMEpTNS91djd4?=
 =?utf-8?B?QUV3ckdHY2dxaHJsRmJiVnhxWWxoMWl2Q1FqSkN0bDdlTGdldzkrckJCeEhY?=
 =?utf-8?B?QjdCMWE2YTQzWUVReWhVdjBSTEpmMzdHM05FVFpoeXEvQk1kQzQ2anA2ZnJJ?=
 =?utf-8?B?Kys1eFV1M0E2dGJaeksrdVFxVjltcXR0ZDFMYUVsdjkyTkphZnhuTmNUak8z?=
 =?utf-8?B?MjRIYTZDV1ZscGhWaEV0cTQ0dVI1cXBwVFRWM3RKQmhOUlBjK3BBZVhvQVMz?=
 =?utf-8?B?ZFoydi9uVksxVk40MW84U3pwbWVubFBMVFRxdU1jUXRuVWNWUFZuRXdmakk0?=
 =?utf-8?B?blhCd0lZdlJmbGRhalJPY2hTcTRUdHJMTkw0aktYTUN3RjBVcnM5OXFPOW1j?=
 =?utf-8?B?WVltaVJqSkkwUm1mNEZMcEw5TFFkWkFWT3h3MWw4SzNMSFppY0ZxeldyNFM1?=
 =?utf-8?B?U2thSDd4em9SMldtbEJXNnR3TjJGMG40cEVJVVNaQlNZcHZTMXkvNmw3cXVq?=
 =?utf-8?B?T3dPY1Y3bGRwV3IrNmNFcUd3d2hKMytCMmtlU3VSTGcwZFV3Z3h1WUhiRUJv?=
 =?utf-8?B?N1Q0dGJud0tBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHVkWTkxdTVndXFBb3c3V3o4NXU0SDFjTzhoYVhBNThKdVRhSkRCUkNKZWxM?=
 =?utf-8?B?MzZXaGZTRllQSmFaQTFtUjlPS3RHOHpCVGJJK20va2sza3NiTnJzbFY4Slcw?=
 =?utf-8?B?SnI4VGNNSFBGR1EzVDNXbFZlK2hObDI4N3Rad0NmREcvY3A2NWJEeUNybUlu?=
 =?utf-8?B?ODdPRTVuZktWUFFxM0dwOUZTQWU4TzczU1I5TE54OWlWdm5pNlc0ellrdy9K?=
 =?utf-8?B?Sm9leUFKZVJXc1M1WnVIYVQwNUdXUXdaSUtMaERucHRlVjExcnlraXQ0YldD?=
 =?utf-8?B?TFFhRm9UNlBaY3IwSmJDKzczdFBjMjNvdmU5ejhtSytpdTFrajZ2b3ZXa2Vs?=
 =?utf-8?B?d3R1YmFqTDM3NkVVYkZreitTenB3bjNERmJwRUE3QSthVHhrdTNIVlRuQTlT?=
 =?utf-8?B?Sm5UR2JkMTJNQ3dJc2ZscmJKemk0N0VxV3hOMVlvNDFzb1hOUHZLNnVsdXRW?=
 =?utf-8?B?OTh4djRCSnk1Q1BnMGZ2K3lMZ0c3UG9SbnNpZUE0RG9hSjR5UndsR3BsWDN6?=
 =?utf-8?B?c2JUWGRGZjJ1am91MEVaZlRZcHY5WlQzWFBDdjE4WjJtTkdWSWxaOTFISU9X?=
 =?utf-8?B?RlVLVzVleklhcWVlK3hhZTRsNmh5Q2U1NEFEcVpvd1FzcHBKOTNZNmtGUW5V?=
 =?utf-8?B?QzhDTGFtZUhTRUY5UWNZcGxtT1FaNGJiNFAvdU5RYnFJVkhiQTJDRmFIdHVo?=
 =?utf-8?B?dDlJdlA2WDQxVS9wZUdmTWtra0NwU1hxVEtndnBiZDRyYXVxTWMrWDkrQU5a?=
 =?utf-8?B?blRVVVIzVm5TZU5OSXFKbURaZzA0bjRsUDFKSVRSZkpYSEs0M1g4cXR3ZXFH?=
 =?utf-8?B?eDJjRVdtT3Q5WXlIRUhWeWROd1IxaGkwY2ZUaG5uZjJvUzJpS3RVZ0Y0M1Y4?=
 =?utf-8?B?K1JrVEVRNTBHM1czSU55dVFIZDdMY2MxZkt5SjNMdVJvYjNySlJvdms4Yisz?=
 =?utf-8?B?WXo4RzRYWHYvOVhEQjE0ZVc3WU1XVDJrQmI4d2tVREkzVjdTTU9VQXY5bnc4?=
 =?utf-8?B?Ri9ad3lNTlpSS0NqM2FtdnpraDVXcTJyU0FwakJkSXMxWFhhZEhBRmU3WFdh?=
 =?utf-8?B?aURqRHkwTk9ZcnZWYlltcHR5bC94YmhLdFVSVmN0dTRyYmcxNjFSNFBXMk8w?=
 =?utf-8?B?UjVYN0ludStXZ24xa3hveEJzdlplRU1CRDdRZDd6NEpvWEszNzVBcFF0aDBz?=
 =?utf-8?B?MW1qMEoyd3ZLZDFiL0NUQkI3aGI4ZDljYTVSSUZBcGFqNE5FYzRCYmliMTBE?=
 =?utf-8?B?Y3BxWmRYa2dHb3dveXIvQ3NlTEVOWkdxQ3RPc2R5bXRsN1ZXYzRWZEExOHA0?=
 =?utf-8?B?SHYzamhrQ1BRdHRKT0kyTlhKMU8xaWtjL1VWWkV0Z1Q1QXlaeERMcERaT0Fo?=
 =?utf-8?B?eVJHUVlhYmdMMEFaQStkQ2pnYUZ0ajBIWERSKzZBT2o2L25HU240TFNRQzVP?=
 =?utf-8?B?dnhDYlUrRVZlc29VS0FGcHdKUEFBMm5HS1RkbzhsbDEvUXNVOGgxK2ZtTkV2?=
 =?utf-8?B?TTlCZWNNZm5SMVNUeC9RZVdwNUlzcG9HaXFhQmxaQ0g2bnpMR01OVWlPT1JS?=
 =?utf-8?B?QTBjbEpkS3V2cGxJSzhicWU0cjFHME4reWZsZy9PUGJ3NzVwa2g2UDBqSFBu?=
 =?utf-8?B?TGN6YWFzUXlVeUhDVnk3QmZHdXgwZWY3RFNsbWJ0L1dGM2RORVdrdHlOdDgz?=
 =?utf-8?B?QUVWSTdpQUFsK2srYXlTK0FUWGtLbmxLRHBDZVUycXZFZTR1em8vK1BzMURl?=
 =?utf-8?B?TTE0WGk5SzVPWlVSaklFVU9VNFVHb2lZMU4zRmFYL0lickFjdHg1Y3NDMjFa?=
 =?utf-8?B?WEFETzNBOGxUNGdBUWd6SmtrZ3JQbkRZTU5Ec3BOMjRnZ2M2bndyWnpzNjMr?=
 =?utf-8?B?eWt4ZFVqay9xQVlCRDkvdjFuVm1KdFNzQkJVWUVDTDdlK2pmTkVMM01wL3Iw?=
 =?utf-8?B?SGlldEo4Q2pRTW9CWGFxRkFRaHBaQ0UxY2pWMXMzdHFxeEpnemNwL2dUZWM2?=
 =?utf-8?B?MytaTGp2QjBsbWtRQ3Y1V2VibEZ0Yy9YV3RPdGZac0RuczNkeTl2dFdTOVVP?=
 =?utf-8?B?MWF4bVc0NEdxbEw2WndKZHdpdE8yYVhsdzQySUNaZWRVaG00d2RINXNoajZ4?=
 =?utf-8?Q?9sdhfUTZ7/Jn+Fd7iK0l/le5S?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f66b09-4a1a-49b6-4cd9-08de3e005184
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 06:40:22.5444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdQ5l/5M9mQyq5VgQbdFwM5xHm2CEV7tsjrOt1O3Oum6GvnPz3UYYsqSib4qOW9yxJ+mhJZgLeBpnOGqPv4frg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5878
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/12/18 09:33, tugouxp wrote:
> 
> Thanks for your kindly help, it seems much clear now!
> 
>        So it seems that the QEMU parameters |-device intel-iommu| and 
> |virtio-iommu| you said both implement purely software-emulated IOMMUs, 
> is that correct? I have another question: Both Intel IOMMU and ARM SMMU 
> support two-stage translation, where the second stage is managed by VFIO 
> to handle the translation from IPA to HPA. Then, who manages the first 
> stage?

In nested translation mode, guest manages the first stage.

> I find it hard to believe that the first stage is directly 
> managed by the VM OS because, as you mentioned earlier, simultaneous 
> access to the IOMMU hardware by both the VM and the host would pose 
> security issues.

In nested translation, any output of first stage translation is
subjected to the second stage, and second stage is under VMM's
control. So guest cannot harm the system even it manages first
stage.

> Therefore, it is highly likely that the first stage is 
> also managed by QEMU. However, in both QEMU's code and VFIO's code, I 
> only see calls for creating second-stage IOMMU domains, and I haven’t 
> traced any calls related to creating a first-stage IOMMU domain. This is 
> where my understanding gets stuck. Am I misunderstanding something here?

nested translation mode is wip. You can get a full view by referring the
below links.

[1] 
https://lore.kernel.org/qemu-devel/20251215065046.86991-1-zhenzhong.duan@intel.com/
[2] 
https://lore.kernel.org/qemu-devel/20251120132213.56581-1-skolothumtho@nvidia.com/

 >>> > 2 Given that both the GUEST OS and HOST OS have IOMMU enabled, 
when the MX250 performs DMA, it should go through two-stage
 >>> >  page table translation—first in the GUEST OS and then in the 
HOST OS—with VFIO-PCI assisting in this process, correct? If so, are
 >>> >  both stages handled by hardware? I understand that the second 
stage is definitely hardware-assisted, but I’m uncertain about the
 >>> >  first stage: whether the translation from IOVA to GPA (IPA) within
 >>> > the GUEST OS is also hardware-assisted.

Alex has provided a comprehensive response to this quetion. I'd like to
emphasize one key point in case there are any remaining questions: For
passthrough devices, DMA address translation is invariably handled by
the hardware IOMMU. The VMM is responsible for configuring the
appropriate translation type and establishing the correct page table
mappings.

Regards,
Yi Liu

