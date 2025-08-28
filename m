Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E14C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urapZ-0000g1-3v; Thu, 28 Aug 2025 07:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urapH-0000Yz-Ci
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:29:57 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urapE-0003rd-Gz
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756380593; x=1787916593;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=awmSOS05xakKwt5VxKlLwX07VEkTVENRE+JPMTxJyIY=;
 b=an5RjQTbbjzXq3M4pRor066AvqUOk2CRehXDZFSBkX6C73wSsvwzQ9mW
 9y1UpR915b+Ux8u56DORmJsza2R4dhNq/P6Yppnja7kvw0p3BO9uSSrUF
 mMxUFQGwJwF7022Qio59dbBfi/C41RZoNd7Ipqs1OEic3tQH0ughxhgwQ
 jCeylCNyDzXOMnIWAgDztqEUt9UQmNzWwOfD4SSlPCgC0kWP8ZcKBHlYP
 lPBd1qelPQdDo783yrY92SBhh944ZzIRNSfCcbk7Yo8j7CegLwc1gJ2NI
 42COqdol3DTaRKJXJBcFGULzZkm8LwWAbYGuuYDJApfbwmHgOpWicFZoh Q==;
X-CSE-ConnectionGUID: dBOY+eIpTYmSn1p1+5yVOg==
X-CSE-MsgGUID: MP2z8Fa9TI2vw85Jh0lGag==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58570700"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58570700"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 04:29:43 -0700
X-CSE-ConnectionGUID: cr2DUtErRTeINpseOnh+dA==
X-CSE-MsgGUID: Kfl0aWKfQHuOC7qFY+9+wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="170474946"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 04:29:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 04:29:41 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 04:29:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.44)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 04:29:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLDRVgAs2+cGPytllq6MotINgjjdYFom5BUI318xJFRhHdEoGr6ULlSAC6LT1BwAWPbP/IWldN8/R9yhQNwJxMnbbivGn3fjNbNblBnzJy1EcIH0QaFo65AcUE0aOqW09SEdF01CUGWhrcEm/sWQPGgluTQoJs0AuedyV0RZNiurN9X0f09N2k1m+5gAV0IlCgB6xp5rtPmR7WQKpn6p7O5JqsCn7jfPl0BMwINV9rfke1pFY2Jsz56sUHTDdclqr1/9U7Cd1DBJReEbg7jphT7rH2rYALSoO6GN8fviJxZDEZUlwl8SWwguJyRZHPkvE+9O068eGGErZ5dmbMlFjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYLkhabZZyROzabd/3L66m65JyuthcffRWs6DZMryZk=;
 b=Qx4aCIq0iOjoesv2bjBFDOwiIK6lrFAZ1/LJADT2z5w9CIZjdu+g8xsp2qGxqTHYc3zajiHgpwougtibrWeqcmvav7BkTnaJeOGFHDqa30F3S7GIHf2uGOe+QH5vdRuvZN2nPD7M0TxU2GQuPFCOgeT/oe8R3Be0JeCMAZ+aVHs+nISypA0LSO3YyDFQgKgV3Dvfo83OertGFgmQcd0PPM4VKcfQ223yU3Bq8+2r1g6rZ03jZyxuyZiCzDauLifVEFf+AuK5fdOPKGThb+/yLUTNKJQrC4yjUxIAbQERhBlA3pup7RsVRuwoBlyFqaN+c7wwtpS6BEyv78VkdUyfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by IA3PR11MB9206.namprd11.prod.outlook.com (2603:10b6:208:574::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Thu, 28 Aug
 2025 11:29:34 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 11:29:34 +0000
Message-ID: <a8e8ed01-8e37-467a-8e95-8afc2f6a16e3@intel.com>
Date: Thu, 28 Aug 2025 19:36:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/21] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-11-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250822064101.123526-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|IA3PR11MB9206:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa56e2d-8163-4aa6-7aef-08dde62629ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|42112799006|366016|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDYyR3pyc2grVDg5a0pJbWtoNHN6UVZIYm9qQmNSc3lFQXJXc3c4RXl0Lzhl?=
 =?utf-8?B?TCtZYUV2d0NsVzh1VjhmblZVVVpVRitEWWdsdXZDOVVyTTNVanp4K2NkRlo4?=
 =?utf-8?B?Yk1jQnpkNnJJaGNpemZEckRSMHkxSkVMTm15dVEwRnJHVGk4eERNQ3VxMVJM?=
 =?utf-8?B?Tk5ZRFJSSnBZeUEzTmtWTVllUHlMclpxa1dMQTlxVHY1WFRSN0JETmJ5UmND?=
 =?utf-8?B?SWNhQkJIbk1COEh6cDcweHlseVljSENDRktNa0s3U2czYVkxREcxYWtOS2V6?=
 =?utf-8?B?aTFuOTdXY240ZFpVeFpNaHJFdVU4U1Q2enlLUDQ4WFBTK2NrcmhYWnBqR1VF?=
 =?utf-8?B?SU80T0dYNHZJSkxreUtVVVRPVlpkRk1TaVpZZGZQa1R2NlJTYkpXMHg3cjZG?=
 =?utf-8?B?cWVjL2l2MkV0TDR3dkhLOFpKMDR1YzV5NDBJTk9WeXZBa2w0cmplUnFMRWc0?=
 =?utf-8?B?Snc5N2UvdVg5YkRiOERKQThJWHhaa2NBdTVuVE1pb3hMVlFRZXhJdU1lbWhC?=
 =?utf-8?B?a0s5M3owMzBLeCtXU1ArR3pXaFVyMzFEODl2MDFHaUE5M1ZaUFpWa1NhT0VC?=
 =?utf-8?B?V3RQSnpQRXVmN3p6VUsrNW1TRnUxbUxsMFJjSHJUTmNpNFBCSUxySkhvd2Zs?=
 =?utf-8?B?WVprUnlCQW45RXlBUldNTEdFTEVMMjVIYmhScTNadFVhTFdhS3ZuVDdmTlFr?=
 =?utf-8?B?a3lra2ZrU0U4S0x1UlNQWWY1Q291bW84SWtXVkhuN3JJRE93RkY0ak1vUWdm?=
 =?utf-8?B?Z1RlN00vTXAzRHBJSy9JSTdGU2ZFSTBodG9FR2FVT2xjMnkzS1hVeGYybzJQ?=
 =?utf-8?B?ZnF1azZFYXZKMTJwR2tzVXFWdHVJVi9GZHVFZEtyTkY2end2K3ViNWJNQnBl?=
 =?utf-8?B?Z1JNS0tWSDhvejEvYWR2YWlCWm9wNWFVUDJobi9kNlA2ZDk0eWJQRnlZbzlp?=
 =?utf-8?B?Nkk0RnFycHBuYStTZVlONjQwREFxKzVTM2FScGl5QzhyRDNJK1RkNGNLeE9x?=
 =?utf-8?B?RldvcWJBZUdQaERuaW9pa0xzWDhSazg4V0hYcjFqQnByNnFreFVHM3psNW1W?=
 =?utf-8?B?TlJiK1dtWEk3MW1mWm94aGZVd0sxY0hURU5DZmp6R25UTmVKbWZGdjczQ1Ur?=
 =?utf-8?B?QStoN3dTcFk0TENXNEkyR20vV0MrczRPbk1kN2JsRnRzNnhRWktmc3lNTjBK?=
 =?utf-8?B?UThmOWJWbHNQTjBtYTVYZTkzbC9TSXgzZHVMZjhUOGFrdkRLY3lvZXVGaStB?=
 =?utf-8?B?dlYzMjU0ZXdTU1o2d1hua3B0NFI4TWRSU1hSVW90SzRXWlJ6MkFzYW1GMXNz?=
 =?utf-8?B?LzA0YkV4ZmlmSGxsYjB5RkJjZkswL2hkZGVBTmcxUVlLTDNNSE5SWVNoZXl5?=
 =?utf-8?B?Z2F1dmJCTFZoZktVejBlRFRHWi9EZ1NjTE9IUzJ4OHQ2VWRhblowSVpqdnk4?=
 =?utf-8?B?U3RySW5VcEpiUjZXU01HekpLbnBPWWtwYVdRTCsvZFdqS214d2c5MlZUWFRY?=
 =?utf-8?B?SmdocDduYjV3V0lCd1ZVNlRpYjExRnJpVlU0TWw5d0t0WkxHeXB1R3BaYW5B?=
 =?utf-8?B?dnNicGRobkg2WXcvdmcyc3ZNUnpkRHFpY0JraVBBUTl6d0tBT0l5ei9vL3h3?=
 =?utf-8?B?VUFiTTdiSTBtYlp5RFJBZTJxb2dEVHk4THVMeEFiWnEvd1RUQUx1d1dZNHZx?=
 =?utf-8?B?anQwTEMxMk0rTWs1ZjEyNjM0U1NNa29kT3F4MDFZcGxOTmdoY2pSeXNLYkVs?=
 =?utf-8?B?NU4zajdpS1YrM09QTmV6QTBkQ09pUXlKbG1QUlVLRE9IditDd3gyZi92SW5M?=
 =?utf-8?B?K1ZZbGczSHZHRzN3MnpHTldhOXU1S1g1NkVnV1hWdUVwVm9yei85STI4dzZH?=
 =?utf-8?B?eldDWm9Qc0FpbWVHYTJVNlJWcUZZSkFyLy9JV2VhMkora2F2eEJnMVN6bnIz?=
 =?utf-8?Q?bmheU2aTzsE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(42112799006)(366016)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjJjQlhUQzZCR2x0NTl1ZXhsQng0cFZrRG5McXJ4YVh1c1VRUXpxS0dWd2Iy?=
 =?utf-8?B?bUhrSXRMTWphMVlHYWJud2dUQWlRc282NEV5aTRkMUxSZ0NzRUY4bHJDWkQw?=
 =?utf-8?B?N3hYclpUT2dSZktoL0MyZUo0dk9kNTgzTHRrUUxZZXdVNGIyRk5XcDFKcGF4?=
 =?utf-8?B?QStXaDkxNWt4YzJyR1dNWG0rNGMzRUlPeUZoWk1pc2lpM1BkQ0VJK09NMnJU?=
 =?utf-8?B?cnp0bkNmVHI2Uk5ZQUZkMDFuVU5xUFQyR0NkbTFLQlpSQzRPR1FGRVNzNEtU?=
 =?utf-8?B?QmtRVjNRaUNkOEoyWngwVml1allLclNIZHlCYk9FbVozcmw3REtZc2xOcHRl?=
 =?utf-8?B?NUJzY1V2S3l5dXpra3Nxa0I4UUNQa0pRRFBTTU9kNEM5cmw1Zld1ZHovMXhL?=
 =?utf-8?B?UXI4d2MzQVpDSlpqUnBROXB5dFMrbGF4SFJXVWp5SEVhOE1MR0pXVWdINTZy?=
 =?utf-8?B?QitXcjV3QUUxUlhSVGZoaEJ0Kzc0K0Q2a1UvaVhuVWh2ZXFFNGhHL3c2Qng0?=
 =?utf-8?B?TVM3Tm5admRJQm9KVDhOcXUvWGJhYW50VnJVeDViTy91K25HZ0VrMklWWDQ1?=
 =?utf-8?B?d0lIUUpBK3h5eEtwck9CSmJoaTAzL3FKSHdZeTZ4NGtVdEFwYmIzcm9UYzFV?=
 =?utf-8?B?dG05NlpEWUxQYXpLSGhmaVRLMldTdWM4dmNXRjJkSHVhUW15QzZEUFlEWW5m?=
 =?utf-8?B?UkJ2c01UT1NHMDI4bVIzRlRwSHBpR1NWTnFVYnlNUmk2Qm50OFg5MVhwcWdT?=
 =?utf-8?B?aWtXQmVhQ05BZlY5cHltdlY5TlozSmlNUjBZMDRYSmZ5ek9PNmh1d1gram9P?=
 =?utf-8?B?UTJjUkdFMnoyV0JwbWkzWVlxV2JLYXdGTjdJQkY4MVZZVUFYL04zSCtuNmU3?=
 =?utf-8?B?eUdLbWw3NXY1ZmR5VGFpZXp6T1NDY0E4RmZIenRQQjMweHBhVzVVb1g5aFBS?=
 =?utf-8?B?YThFcUNzbUc2MDIzVkdIVGcrK1l1UDBqU1lvV093NS9LazNOYnNjRGVqRDV2?=
 =?utf-8?B?bTMxbGZ2Q1VDcHo3NS96dzlKUENEbUhUWjFEZFFFMHpCZXdQM0V0dkhwNXQw?=
 =?utf-8?B?YzhuNjVlS2s2eE11a0tPdkZ4bTBIWTQ5aEt6MWRYL0wzY2J5MVh5M3hBbDlJ?=
 =?utf-8?B?d3dDL1hCSG9IU0FsWmZPaFZFMkY2VE10UmIveC9iWWtRS3kyRkZkOHJiUlha?=
 =?utf-8?B?aEtoV0YrNE8rZEhZdE5oZGNaN2NDSkQ5czNGUjF2V0hFTzA3MUFiOUpucktZ?=
 =?utf-8?B?R3JkYVd0VHpSTXg3eS9MMzFqaVFZSlJQZ0Y2Zy9BTTExOG1zTmlrS29HREJV?=
 =?utf-8?B?TXgvNWRpRjV1RzVMcExhM0pHQmxFYmNicmtWRGR2SjZIOHA0WUtTWFVLais4?=
 =?utf-8?B?VDREa2MrSUdpNjVpbkpRa29UWklEN2cwdlFDVjJoS1llbHR1OWZ2NXdNYXZ4?=
 =?utf-8?B?ajdUZ2wxdXRObWNWaWdMOXF1Vk5SVzJ6R1VIalB0SkV1T1IyYklwenFHTDJZ?=
 =?utf-8?B?MWprQ2Y0ckk5cENTeWhnRFhIa0JZUTZsYkRLVjhaVmd0cHJ6M1JLSEJuY2hm?=
 =?utf-8?B?VXR4cWU1SVRFcGpxR0Y0TTRkTVFuZlgvMW05eDQxelovZW40QnNJVGIwb1lk?=
 =?utf-8?B?VVY5dVZtZlBMOUhtbmt0NGxGZzcvSnhaZzd2MTJvK1V5Y2wyZ2svTDJXMkRY?=
 =?utf-8?B?UmczbXAwWjdrVWE4U0JuMWZZeXcvQVViT0pGVHJLU01EQ1hOeXNpTUVDM2I3?=
 =?utf-8?B?ZjNLelp1dmZ0SnZCZTNkOEtSdjRtZ3JXRDQ0L1V1ZjJuRHora0JlSjR1NE9L?=
 =?utf-8?B?MTBrT1ZNWUxMY3o4SGY5a01aTEtoZjRFcE10cC9hZjU0ZWtNY0RxRExta2Ez?=
 =?utf-8?B?eS8yWFp1SUk2NjB4bWRWQVdlYVdPcU9haVo5TldNMDNUMGhITWVUT2ZERmtC?=
 =?utf-8?B?VU1HY3c2b092a1ExWVJ6cFdoQzJVTERVV2VZRFc0TUlRd1ZadURBQ0czWVl1?=
 =?utf-8?B?VURsQ0gzYVF4QzF1WlpzYUcrcFVwaXc2Z2FmWHJBOUpOWDRnRm51Y3RIOUlj?=
 =?utf-8?B?d1JYNEVpSExvK1NPMDlNMVNIZVFaTnNzTW4rUmxGaEN2QjhoclpROE5GbVEz?=
 =?utf-8?Q?9IaHOfp/7RCFlnrceDK1qbdNv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa56e2d-8163-4aa6-7aef-08dde62629ce
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:29:34.4535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUyDMCNvfgT+pkwTRi0dTrgEYD7zmBoh/PqLxQtoSuXH+amxxxkt7f2hwAUyi0OGc2X1pYyJy0mbq0bHkZrbJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9206
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=yi.l.liu@intel.com;
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

On 2025/8/22 14:40, Zhenzhong Duan wrote:
> PCI device supports two request types, Requests-without-PASID and
> Requests-with-PASID. Requests-without-PASID doesn't include a PASID TLP
> prefix, IOMMU fetches rid_pasid from context entry and use it as IOMMU's
> pasid to index pasid table.
> 
> So we need to translate between PCI's pasid and IOMMU's pasid specially
> for Requests-without-PASID, e.g., PCI_NO_PASID(-1) <-> rid_pasid.
> For Requests-with-PASID, PCI's pasid and IOMMU's pasid are same value.
> 
> vtd_as_from_iommu_pasid_locked() translates from BDF+iommu_pasid to vtd_as
> which contains PCI's pasid vtd_as->pasid.
> 
> vtd_as_to_iommu_pasid_locked() translates from BDF+vtd_as->pasid to iommu_pasid.

translate is somehow strange. convert or get might be better? Same to
the translate terms in the patch.

> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 58 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6edd91d94e..1801f1cdf6 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1602,6 +1602,64 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>       return 0;
>   }
>   
> +static int vtd_as_to_iommu_pasid_locked(VTDAddressSpace *vtd_as,
> +                                        uint32_t *pasid)
> +{
> +    VTDContextCacheEntry *cc_entry = &vtd_as->context_cache_entry;
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    uint8_t bus_num = pci_bus_num(vtd_as->bus);
> +    uint8_t devfn = vtd_as->devfn;
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    /* For Requests-with-PASID, its pasid value is used by vIOMMU directly */
> +    if (vtd_as->pasid != PCI_NO_PASID) {
> +        *pasid = vtd_as->pasid;
> +        return 0;
> +    }
> +
> +    if (cc_entry->context_cache_gen == s->context_cache_gen) {
> +        ce = cc_entry->context_entry;
> +    } else {
> +        ret = vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +    *pasid = VTD_CE_GET_RID2PASID(&ce);

looks like we have quite a few code get rid_pasid from the context
entry. I think we may simplify it by using PASID #0 since vIOMMU does
not report ECAP.RPS bit at all. It could be done as a separate cleanup.

> +    return 0;
> +}
> +
> +static gboolean vtd_find_as_by_sid_and_iommu_pasid(gpointer key, gpointer value,
> +                                                   gpointer user_data)
> +{
> +    VTDAddressSpace *vtd_as = (VTDAddressSpace *)value;
> +    struct vtd_as_raw_key *target = (struct vtd_as_raw_key *)user_data;
> +    uint16_t sid = PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn);
> +    uint32_t pasid;
> +
> +    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
> +        return false;
> +    }
> +
> +    return (pasid == target->pasid) && (sid == target->sid);
> +}
> +
> +/* Translate iommu pasid to vtd_as */
> +static inline
> +VTDAddressSpace *vtd_as_from_iommu_pasid_locked(IntelIOMMUState *s,
> +                                                uint16_t sid, uint32_t pasid)
> +{
> +    struct vtd_as_raw_key key = {
> +        .sid = sid,
> +        .pasid = pasid
> +    };
> +
> +    return g_hash_table_find(s->vtd_address_spaces,
> +                             vtd_find_as_by_sid_and_iommu_pasid, &key);
> +}
> +
>   static int vtd_sync_shadow_page_hook(const IOMMUTLBEvent *event,
>                                        void *private)
>   {

the code looks good to me.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

