Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFA2C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 06:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2PMt-0000H9-3x; Wed, 09 Apr 2025 02:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u2PMq-0000Gu-Ii
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 02:57:01 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1u2PMo-0004dE-7I
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 02:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744181818; x=1775717818;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eY6+PDnv2FOqriIOwdGmKF4DmnZfw9si8G2tzwXeI7o=;
 b=FY83Hw1N4WdnrM9bX8UQvdQ3zAU94KbBwOWU6XE/5micsgMh1pa0Pfbz
 oN66EpUzQ69iafLbzLEUH5Y2lAAN444OIOnw3dxi62XSbowqQ6J3T23ee
 83YRkWHArsacyKeLyNsIwZmu5ohw79BIIaE+3pLkDUv5t6wvP3qncPxo8
 O7Z82FWHjOvKZSBqqtNQd6PyKoPA44/m3kR3Uf6I3GrEmyhHuIW0QYDou
 qZSncQ3/vSw4h2cqQKEUdXShlQ/+PNCosd3VgSqNfETUgj7bcXeqA1eJe
 1AJqv+p37gW8GFvSDhdJaqM2vVTtRwbO0LL85qqrRDgnFWp4gePTQeIDh Q==;
X-CSE-ConnectionGUID: sIvZqofITYOIlsZla/ubBA==
X-CSE-MsgGUID: Wb6iMUOTTaygZ5Daq45COg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45771996"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="45771996"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 23:56:55 -0700
X-CSE-ConnectionGUID: VTVkWwknRxelngC6y8xe6w==
X-CSE-MsgGUID: pv/piWs2TouHFxOmJ5E++Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; d="scan'208";a="129007054"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Apr 2025 23:56:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 23:56:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 23:56:54 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 23:56:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMHq2xTusG5RYFPquQM2bR4LFGvBth4B3ReqWf40Tc4b6k2vxkOqrDternIznMrw5nb7cMjx/JeDGEFHy8wO78jdIuxAjhTQy0v2041IXiGQhsp2OdwWzweoQSGwOe2ytb/OBp0j+f2R3D25Ud46vakno+oVKq6iLudhEZbn4+Ac30wwJKlI7C6MkXn7b//jflPjU5XieEUB4fovKwXRQzbq/nxoOPodGyELW1+tRBBJQTmet5Y0QH+NPPIZwcmADFNxpGmBX5DC6geAxJm87FsAb9NFzq49SeLyOReXsVlBtbT339rWdbw7BUzeKmCAnDp7MvXbJSx8/ZTZqFlZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QehsNTUgcqhBVUtCjrQOsn+EyqlPBSZxWlbAzQA17jI=;
 b=sZexFDTV5LpHM61BkJf6PRS6n3kWoesiQEJaWyYZSve3Om6c96fclbbZ9KZIdI5DOcy95BlxCGNYLecsTQaFFaOYa5T4mJV3KQao/EeLckOs9nk+kq3ZXoWMCDd7dPufBgb+uaFFLNCwG7M32DxBAL2t6gkwLCsfExdcyTdfaTPrrxkYjG0Aq+MpBSv+GJrFCOYGmUTjaVOniH0qfC0K8YKbnAwGHxTWdcMKYyrh3bUQvT4kyDe6zMGQPJtWvMbmW2lzKDlld6dQ3vHitc87ReXH6Ewe8v22HhN1GIN79ZlGc7RVpx2JU6BG+hPgcUn9D5EPK5bYCkV2OsPait43Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 SJ0PR11MB5215.namprd11.prod.outlook.com (2603:10b6:a03:2d9::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.35; Wed, 9 Apr 2025 06:56:52 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%7]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 06:56:51 +0000
Message-ID: <b35fab5a-b46e-4e89-8c04-0282a1f9d1a4@intel.com>
Date: Wed, 9 Apr 2025 14:56:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/13] memory: Unify the definiton of
 ReplayRamPopulate() and ReplayRamDiscard()
To: Alexey Kardashevskiy <aik@amd.com>, David Hildenbrand <david@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Peng Chao P <chao.p.peng@intel.com>, Gao Chao
 <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao
 <xiaoyao.li@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-4-chenyi.qiang@intel.com>
 <20936115-1d56-4504-9305-e023eaac081d@amd.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <20936115-1d56-4504-9305-e023eaac081d@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0088.apcprd03.prod.outlook.com
 (2603:1096:4:7c::16) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|SJ0PR11MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d77cb2-b310-422c-4bdf-08dd7733b4af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tkl5VWQya2xuK1Y2Rm1XVnpwMEllMmtBUWM5Mzh2azRZM3lvNUdyblJmRGFw?=
 =?utf-8?B?ZDE1MVVaWkRmdTVmNHZqNFJVRmpEamVTSXpiRzhEd3c1Q3B2STk1OUpNYnZk?=
 =?utf-8?B?cC9YQnhEY0R3akoweThmb0VZdFRjb3llQi8wN292WmVhMlVSY1VCaWJnU1dE?=
 =?utf-8?B?dEUrYlJod0krdENaVjU5R1dxQk1WZEYyWnR6Y1IzRFRVaFRObFM4a1RkOHBH?=
 =?utf-8?B?bXRlQ3RpcXJVenc5V0EvTWJucU93bS9jR2Z0bmEwdWV1Rmx1dk1QNHZwY2lZ?=
 =?utf-8?B?NDg3OHpYM1JmZE92MXZyTzRUcFVtcXJFbEV4cE14VFl2d3JXcjlMeWtiQXpx?=
 =?utf-8?B?K0lsQlNqd3pJelU0eDU3Njh0VG0vUFNpcEpnUDZDamR4U2hvdGp2aDlpZUJN?=
 =?utf-8?B?eWRiWUFnbW5jMjY5Q1RZVmFUTFZxZld0TWF6c2F5ZHVaUW12UVdhaG92dTdI?=
 =?utf-8?B?UUNvN0N5Z3l4WURyS0VBdSs0QmNFZmxPd1BRb2dvSGpIamNndVpCb21VMVpr?=
 =?utf-8?B?eC9VU25kNWFTTkNaRTltZnZWMXZiZzVJcWw2Unc2RUZZOVgxQXZhVW5FQStt?=
 =?utf-8?B?MWRxN2syMlI1a1JScWRsYUxvL0xTaGhkSUFtSXVOVUR3c1BBc2JPb3hEYjJC?=
 =?utf-8?B?MWx6R2RTSXhkS0JPUjB6ajlyUHFXdi9DYS9HVHNoSnVEQzcxMi9IdmZLTVd0?=
 =?utf-8?B?TUlDSjBFanM1TnpXcHh6RE1NUDFMSTMraDFxWHNKYjdRSCs0aEVtSXg5RG9j?=
 =?utf-8?B?U2J2VTlwN0FIWFExZlVPSlhZMkMyOU91U2JXMEhoNmR2K1M0TisxaGVyakdH?=
 =?utf-8?B?RVROaXcwNHVBSVRzZ1lBeUZsU2Fsd3RuaE83aDk5OHd0SWUwMytMWTJnVnlo?=
 =?utf-8?B?S3kxSVdhekIrSTdLVHowdXg1TngxZW5BUmNDU2kvVHJBN1hTcUEzclkzbVE4?=
 =?utf-8?B?YnJPaHFNZWZXQ0RXTVM3MkZ1cjBrY3JNSDBTRzJWMUhZcHA0SWhJUEN3Rzcr?=
 =?utf-8?B?d3BpYmc3bEhXYy9rcmJMSGJLaXVMRXNYbGNBN3YvdHcrMCs2dFhaaUN2aXJs?=
 =?utf-8?B?bTFzekVhcDVySWJZZ0x5VXFtMDhpUDl1SE1tdFJFb2VIalN0emh1aEtPTmti?=
 =?utf-8?B?elhwd3lMVHVob0svZFBWMnVoeDNtMkpuZEZKWUg3cUdCalFtNDVMa2EvOVpa?=
 =?utf-8?B?bTc3Qm82RGVoZ1JRdFpMOU1kenpWRDdqd0QzTlBDMzV4aTlnRkNhejI4NTht?=
 =?utf-8?B?eUxmcXNJV3FPaTUzSkh4eGJ2K2FXdzV0SzFoaG5tRURsRlF4b3A1ZlMyb0Iy?=
 =?utf-8?B?bVkvRm1wVW9XTzg4a0d2cFB1QjdObHdwbnJyVHhIb21LdXd5eG5nT1lOU21E?=
 =?utf-8?B?d2RHUHdIdnd5SWtZZmp2dlVuYzJIOVdCNmxJRjNnVTRhT0dMR0QxSHV4U1d2?=
 =?utf-8?B?SXNZT1ZuUk5wME1oL0J4UWlJcW1LQkxOOUIxYzdkWmZnSjFLbklZRk9tRUpT?=
 =?utf-8?B?YjkwVVJEQ0RSL3BINU9XZTFGTTY5dlZ2TjRtZ3l3RGZUdnJqSndPYk1SbDNh?=
 =?utf-8?B?RTFvRlJXTk15YXRKRE1iQXYzN0xISmdKQ1JFaE9xTE5lbWJ2aUxaVURQeHRJ?=
 =?utf-8?B?YzM3U0htTE9Rb3FJMXBUYjk0TFc3N29NMENPZDlaRHkyZnpvNTBPcGFKeStk?=
 =?utf-8?B?ZDkvdTRzZlA3dEp5eFBNbzRtNkwzcmE3WUE2YWRDclU1NHhtWTlNeFEzeG8x?=
 =?utf-8?B?MjRkV0w0b0t4VTFlbmJLYi8rclJkL3JFSjZ4WC83cXRNOVYvUjhFT3JIdTNJ?=
 =?utf-8?B?dmp3Y3RpYTVxcThxTThpZG9pZVY2aDNMSy85UVVKN0U2dWdTOUc0Q01pdmFt?=
 =?utf-8?B?SUdsL1hXMTlVd090dlU2RmFwYjM1cC9RTUdGalBzVkJFV2owd3hCUitESjhT?=
 =?utf-8?Q?HkzWnJf33Rs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1FDeGJlZG40ME91bXNxMnNUVmlrQ1BaaDZ0Y1hOVXVRWmRFaStycjhkQlFE?=
 =?utf-8?B?Q1ZiZmdsbE9TL2p5TERYcHc4Q3JmbXFHSjFhN3pTNy8yUEtlcjdQRkxtaDNE?=
 =?utf-8?B?S0RZREM4dDFFUVhrOGpTTjJkTjRaTjVJa21WTit3bG1rYitLUzBweGZFZThO?=
 =?utf-8?B?N21NRm9DaHE1a2c0K251NEdoc3M4UWExSi9udlRLa1dLN0NpTXhHN1o2c3Rl?=
 =?utf-8?B?U0x5S2Q3SGRLZ1EvaWV6TGhFUjg0aDZaTnB4ZUZXYlh0NE1lYU1pU1Q5c3c2?=
 =?utf-8?B?VHl4NTNraTllNksxT3pFSjNCRkdQMWpVQ0dVbFBrNm5TUnZadjIxTUlyQzVB?=
 =?utf-8?B?N3V5YWJ3Q1lPa2JnZUtFbkxCMW1wRjZYNUNEOTNTWFlRcFQzQnpJa2czeUht?=
 =?utf-8?B?R0JsNzlOcHJWQ2czbmNYdnpGakF4Myt2Qi93YnY5TmUyZnpzOFJEeWZiQWc1?=
 =?utf-8?B?MW1iMDhBSWIyOWFMb2ZYbDJyVGpaa2tmaWVwd3VpNStTTHVGMHZiWitSK1gz?=
 =?utf-8?B?aVhuL1BGN0d6N0RZMkhsd0xmNThXR0xmQWx2amZudnlYZGoyVXg0Z0JHMGti?=
 =?utf-8?B?UXBETWN6RnMwL2dUYWF0R2JoVW5kbC9NQmZJaHNDb1ZsOXNDdGc2ZWVvMFd4?=
 =?utf-8?B?QU5wS09peFVWQU50T2ljajJvWmRyZ3huWm1rZzNycnVvZDgxYkNYc2RkRHFH?=
 =?utf-8?B?TFFFaC9Uc3czYUwrdmg1WXl6emJqMlV6SFJYOW85SGsra1ZWbW1SVlNHSzRl?=
 =?utf-8?B?RWhVNDEyREFqVGpHdHo5cmQzVWM5ZnZ3YWtWUE1URVFhNWowa3FMSzBZOWQ0?=
 =?utf-8?B?MkZkZWNjb2doMTlTNHBSamlHZXp3TUJLTEZjWXdtQ1ZFRWRsUVJyVldsUExN?=
 =?utf-8?B?M3FocUJNMVgrL2VhL2ttZFpVQk9Dbm5BbnBjZUNQcnlnU2RQQzFWcHYrUkwv?=
 =?utf-8?B?Q1NyRTJnVWJyY1lWbFltUFpqbUIvWVM3YVkzSnB5SmxuSzB4V0V5Um5BbDhF?=
 =?utf-8?B?NEdhSTZTUmM3VzlLelFJNDBCaFVKQk80cXJqTVB3czJMZk5qRFBtZHQxT1FI?=
 =?utf-8?B?U3RwU1UvQVF5QVpHelVWZGk4Y202UTFXRWJCcCtKMXZpUlFUWWpOR05UZEF4?=
 =?utf-8?B?R3pzUUhsVThqakZVblNjTkdjVGhrU2hPYkZzUEtqSE9xZkpBazdmQzNNZENp?=
 =?utf-8?B?UlA4eFVmc2dIRUF5NmRNdDY2WEExNHVaVlhMNmJHYTZERFlnZEViS1B6MVFw?=
 =?utf-8?B?b3VxYVNQZUFvR3MvR29uWDY3bkxvaDdnRXZ0a0ZVS2tpWVFzaXBOODhYQW5N?=
 =?utf-8?B?eHJubFpTM2taNWxraXdSaE5pSzIrKy9CbHhIMHh1QnhNdVRDYVNsVy9CQlcw?=
 =?utf-8?B?NThEUzVsVytqTnJIR3d1bjhSR25WSFVibmhaM2h0SThPcmR2NWR3Wkkxdlpm?=
 =?utf-8?B?RnhxV0M1ZXVwSHBlbE5hZmxlN1JNdnpmUEl4YmVHUUtISktva1M0eVJMNVkx?=
 =?utf-8?B?OTRRZmF2aEdhNE1JSU43U0k5anJwZGVPdEFCZDRYaGVsNTFmWkxzRVNNdnFK?=
 =?utf-8?B?ck9IV2xhc0gxQlQzM0t6a1FDQmpWdE16eEc4a2lZRm9HekRsT1lSYXlBY05I?=
 =?utf-8?B?YkdLTVU1by9WOTdIMzhLVy9Ybjk1OUdqZkpiZEdqSnVvVUFRcFJ3TXlBM2pr?=
 =?utf-8?B?K2hTZlJNbngzRS8rRHJTVWJNZjFVQVFGeGdxRlNLb2lXYnRLaEVFVTNNMjlT?=
 =?utf-8?B?aStCU28rQVoyaE4yVHcvMDJMM1JDMmhWNUJjLzR1RUN4eitnUmJadFZKdkxB?=
 =?utf-8?B?UjVSQnRiaGJtWEdxSmxRYVpQRVJ1dkNkdmJaOFBzQjhMSHZycXJsOS9sNUZE?=
 =?utf-8?B?dWhKRkNBSjRZZU5ySldXazRIS21XTGhhM0RxZmJpVldaZjRndHVBS0JjeC9X?=
 =?utf-8?B?ckFCV3g3N3pxaXFSWlY2WlBsVC9lWWlTNmpXMUtOMmRrY2p5eitaNURxWDdN?=
 =?utf-8?B?NldQQm1MaXFlanlBYjJWdXI1V2FYV2ZEUFNzaGpsckp3a0M3U0kzVG43cW9Q?=
 =?utf-8?B?UUtQcmo0dFdqVFFXQlp4cE90SHNmQ05TQnVZdXgzaWhOZk9pMXViaFByMjNu?=
 =?utf-8?B?MHAyVEppRFVOTDhiSitYNlFaM3Y1K3ovOU9RdWJjVWlpT0E5OE0xUzJkQ1Vw?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d77cb2-b310-422c-4bdf-08dd7733b4af
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 06:56:51.8300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHxiCH3Fy6PS7NXhYpHq85KPrHA767rBZPCnmJEoY/gYAJ+R9xFoQfGGpjgnTPgK4kzcGVtmcEkqVkXj0TksPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5215
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.845,
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



On 4/9/2025 1:43 PM, Alexey Kardashevskiy wrote:
> 
> 
> On 7/4/25 17:49, Chenyi Qiang wrote:
>> Update ReplayRamDiscard() function to return the result and unify the
>> ReplayRamPopulate() and ReplayRamDiscard() to ReplayStateChange() at
>> the same time due to their identical definitions. This unification
>> simplifies related structures, such as VirtIOMEMReplayData, which makes
>> it more cleaner and maintainable.
>>
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> ---
>> Changes in v4:
>>      - Modify the commit message. We won't use Replay() operation when
>>        doing the attribute change like v3.
>>
>> Changes in v3:
>>      - Newly added.
>> ---
>>   hw/virtio/virtio-mem.c | 20 ++++++++++----------
>>   include/exec/memory.h  | 31 ++++++++++++++++---------------
>>   migration/ram.c        |  5 +++--
>>   system/memory.c        | 12 ++++++------
>>   4 files changed, 35 insertions(+), 33 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
>> index d0d3a0240f..1a88d649cb 100644
>> --- a/hw/virtio/virtio-mem.c
>> +++ b/hw/virtio/virtio-mem.c
>> @@ -1733,7 +1733,7 @@ static bool virtio_mem_rdm_is_populated(const
>> RamDiscardManager *rdm,
>>   }
>>     struct VirtIOMEMReplayData {
>> -    void *fn;
>> +    ReplayStateChange fn;
> 
> 
> s/ReplayStateChange/ReplayRamStateChange/
> 
> Just "State" is way too generic imho.

LGTM.

> 
> 
>>       void *opaque;
>>   };
>>   @@ -1741,12 +1741,12 @@ static int
>> virtio_mem_rdm_replay_populated_cb(MemoryRegionSection *s, void *arg)
>>   {
>>       struct VirtIOMEMReplayData *data = arg;
>>   -    return ((ReplayRamPopulate)data->fn)(s, data->opaque);
>> +    return data->fn(s, data->opaque);
>>   }
>>     static int virtio_mem_rdm_replay_populated(const RamDiscardManager
>> *rdm,
>>                                              MemoryRegionSection *s,
>> -                                           ReplayRamPopulate replay_fn,
>> +                                           ReplayStateChange replay_fn,
>>                                              void *opaque)
>>   {
>>       const VirtIOMEM *vmem = VIRTIO_MEM(rdm);
>> @@ -1765,14 +1765,14 @@ static int
>> virtio_mem_rdm_replay_discarded_cb(MemoryRegionSection *s,
>>   {
>>       struct VirtIOMEMReplayData *data = arg;
>>   -    ((ReplayRamDiscard)data->fn)(s, data->opaque);
>> +    data->fn(s, data->opaque);
>>       return 0;
> 
> return data->fn(s, data->opaque); ?
> 
> Or a comment why we ignore the return result? Thanks,

You are right, since we have made ReplayRamDiscard() return the results,
it is doable to use "return data->fn(s, data->opaque)" directly. Thanks.

> 
>>   }
>>   -static void virtio_mem_rdm_replay_discarded(const RamDiscardManager
>> *rdm,
>> -                                            MemoryRegionSection *s,
>> -                                            ReplayRamDiscard replay_fn,
>> -                                            void *opaque)
>> +static int virtio_mem_rdm_replay_discarded(const RamDiscardManager *rdm,
>> +                                           MemoryRegionSection *s,
>> +                                           ReplayStateChange replay_fn,
>> +                                           void *opaque)
>>   {
>>       const VirtIOMEM *vmem = VIRTIO_MEM(rdm);
>>       struct VirtIOMEMReplayData data = {
>> @@ -1781,8 +1781,8 @@ static void
>> virtio_mem_rdm_replay_discarded(const RamDiscardManager *rdm,
>>       };
>>         g_assert(s->mr == &vmem->memdev->mr);
>> -    virtio_mem_for_each_unplugged_section(vmem, s, &data,
>> -                                         
>> virtio_mem_rdm_replay_discarded_cb);
>> +    return virtio_mem_for_each_unplugged_section(vmem, s, &data,
>> +                                                
>> virtio_mem_rdm_replay_discarded_cb);
> 
> 
> a nit: "WARNING: line over 80 characters" - I have no idea what is the
> best thing to do here though.

It is not easy to adjust the line. Then I think we can keep it.

> 
> 
> 

