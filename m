Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D1DC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 10:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlPta-00015I-IT; Fri, 21 Feb 2025 05:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tlPtY-00014p-Jk; Fri, 21 Feb 2025 05:04:32 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tlPtW-0004Z4-4b; Fri, 21 Feb 2025 05:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740132270; x=1771668270;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6onBRj/Jp8cp11Bd1pNP70//ZRD2mBmv5g8jmzeBvtM=;
 b=Ic2aU5tsAOJcf4djCoSFVsvLsSmaJnWZ74ZV0PsJtqafvNymEmtEXQbJ
 CtsWwDWUTiOP1YGSzH2QxeY5EnJV0J5b6HLMrPKvR3qQ6JS45Hc/gO2Yb
 WAWxxOoI0JD0xrdCyDcsdbTTC0NdD1+FufcsMBdekm8jgk44EJzrfIWsB
 fuv9jf3ST2wObSnC0WXvFY31D22oIYBOTRLnhNwxrWv59P7GXbk/dmEEC
 NKFHsjqwC5zNWUdyFXEV4ZgTGERIlGErywR+x0hUzjsDoCWjuhRXZUhFR
 l1mgBcgcBJE7LXYTcUFdyleaRmgM30Ww+istVqYVa1BLOTDLKYe/oUXfC A==;
X-CSE-ConnectionGUID: Kc8011mSTCGUvjZWs+6leQ==
X-CSE-MsgGUID: HRqFTRMhSkmPTMWUp5HWMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="66308912"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="66308912"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 02:04:26 -0800
X-CSE-ConnectionGUID: UgQVcqVpQzysza6xSh57zw==
X-CSE-MsgGUID: OFWQZkXwSiSykQb1VpEdPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="115868461"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Feb 2025 02:04:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Feb 2025 02:04:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Feb 2025 02:04:25 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Feb 2025 02:04:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZDHrGcljzv2ET7SRe/UHowKj1rdK6f4j0IxrfB2SUZ7T2lVRAPzAiZDD0QtgEnIGWpM5LJF46n/RFpbIg0PblIVepovYoO+m3RmgdZHdSh6DYdoicjYNC0EByYURhZ0Zh3TiS4Z+2pM/Xo2p1huQUwA/yEj5WMqTPDl+wkAYs5dcKst3sFrjwiLVt8sjFPxnfTT2Z6kozzRoDjskA4WAEmE6+JtU7+EO/CHk09PHqaJifS70xYtDPITyNZo4pZ+FYLPSK0dth2Ce8fX6llLedQiA7DI6Jbsg+/AmyoOv+jm/oG5LdBJnrevgdyXNY42CXib6Hmf4+qVwPnzM5nDCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Deq3Lug/GuWzogUgmtj6S20jgYhWZhiSz52mMwVsrio=;
 b=xW2zN9uyLHRJ8uG6w4uqMiHIBlvdNVQ8mUtveUO0Q+2FyMxUTONRuNm2s4QDvsIjeul83rEsRmFy8f2JWfq0meUOBE2AC9XaOX6kZ89Hq0lfH5iBs6wDdKmIXZ28cSltuRO4vQSMK2TfAB/9bvcmRwoW6yHke3mcOfNCzAm40i7xuR1ypAQBNIypEOcllHuglCgsCUrIUpZsLKC9Jm2N/K1Z8R73iM7WofbyQHWIexWxG+ia9MZRnvw9GemXV5o6H4yLW14dZYBEanxSwB87/CjVx7cnP8U7P48RtiHOePSKCbBLVWFkEJqszRVaP9ysnKX85tCNwrzg9RQJFGp4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 MN0PR11MB5988.namprd11.prod.outlook.com (2603:10b6:208:373::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.15; Fri, 21 Feb 2025 10:04:09 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%7]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 10:04:08 +0000
Message-ID: <108be3a5-cfc1-4268-a913-3a41d1e4451f@intel.com>
Date: Fri, 21 Feb 2025 18:04:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] system/memory: Allow creating IOMMU mappings from RAM
 discard populate notifiers
To: David Hildenbrand <david@redhat.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, <philmd@linaro.org>, <peterx@redhat.com>,
 <pbonzini@redhat.com>, <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
References: <20250220161320.518450-2-jean-philippe@linaro.org>
 <20250220161320.518450-3-jean-philippe@linaro.org>
 <0d761daf-174d-487f-80fe-09b04902006f@redhat.com>
 <75d90f78-151f-4169-84f5-cc3c13180518@intel.com>
 <ce2306f9-19a4-4979-80e6-29b1e8a92318@redhat.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <ce2306f9-19a4-4979-80e6-29b1e8a92318@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|MN0PR11MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e96cf74-4143-4470-0ebc-08dd525f150f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDVHblYzMlpKRWVzUnVPQXNsOHdqbzdWWU9scUFtU1JWR2tjbGxIalJxRUJU?=
 =?utf-8?B?dlJJZWJ5TXlCbXBxdUxYcndWM0pVamFiRG5KWnExRTdWMTNTYVhDNXplV2Rl?=
 =?utf-8?B?MURRcVhzV1gzaFc4MGhjd3F5Y0xJYW9TQyt5RFc3a0tXUXBkbEsyMzRkSWJM?=
 =?utf-8?B?bUg4dFJaY3FkQk5jb3RxNlJpV2pSN1EzU0d6WExoUElRc0N0ajhPWlhpdGZ6?=
 =?utf-8?B?dGU5MmNyNlA4LzhJNVQ4eS85MDloV3Z2aE9ZaWJSY095ZURnUXBvcWdQN3hj?=
 =?utf-8?B?bmRVbHFrUjJMditzbGRpeWhVcUYyOGFQRWRFMU8rRGJ2TXNFODZSTFRQR2J5?=
 =?utf-8?B?ZDNLaWN6Y1JNdnlyM2paZndWblErM0xxRTd6cE0rd2RJSkdRYzA5Wk03REtU?=
 =?utf-8?B?L3AwN29MS1pTSHBNWlBnbzluK0ZlbWR4SHFTcnhkeDF6YXNpY3JDMVMyTHdu?=
 =?utf-8?B?WnFoSEF4b3ZpeDdneFE4aHAzWU0yWThRTFAxTHIyZmxVaXphQjVXdW1UTUtD?=
 =?utf-8?B?OVliUmtxN1I2S1hzVFRURUVsUkhqRW9QRVBHbmtZeGROd2VQRXMxbUVLS3A3?=
 =?utf-8?B?WXV5b3NUQUw4R3ZLVmdNT3d5TnIxd3hNbzBaRnZUSkJMM3BzcDVCQUFNamZO?=
 =?utf-8?B?MFVVcWRyVmhUdFRRYWYzQW1zVWdsQ0lYN1E1bjFyemhSL0dFRlRFQlhEUjQw?=
 =?utf-8?B?ZzN3NGFTVnJuVCtTQ2tuSDI3bExjWlhjTmtKanVjMkMxbzdWcmo4cDJxNDA1?=
 =?utf-8?B?dnYrQkdCZUcySm5Gc0YwWlJaUE1heTZZVkNtNDNMdmhVbFhUcjZhOUtnelpU?=
 =?utf-8?B?Vm80cHlVSWRNS3k0WlhUbjVJbG91U2lDT1g2Y1EvZnpVYWJPZkZ2MTVOV0VM?=
 =?utf-8?B?RVFkdGwwaXM4RXpsQVFEU2U2eXpiMXV2bTRhNGE3cFYvQWtEbEhwanZtWnhs?=
 =?utf-8?B?bmNTNTZ0akZHWnM4N1c5ZERnRGU1WmJOTEt2MHNaRlB2cE5jSHNNYnk0c2Nk?=
 =?utf-8?B?Slk5RHF1QVNwT1BSd0xaekxweFFmZ3U1QW1SWWthUmM2Y3YzcUlQbXE3aXVS?=
 =?utf-8?B?K2ZXaG1BcFZKVS9pbnlZR3hQNDhHMCtaNnlIVFJNV0xmUW9aSjYzb1V2Vm1N?=
 =?utf-8?B?aWN6WG5VRS9ZNEgwdkh2WWpSazdyWFRURFQyNS94WDhnVjU0azh4aytySzJP?=
 =?utf-8?B?bWdHa0o2eVdway9CUjBMUEFYdkxEM08xVTI3dTBiTUx6dTJXdUlCOWJVazR3?=
 =?utf-8?B?Q2dWTUpWVkZSNkRtei9Sd3lHQitJL0lmWkdZeHMreDBHRUVSbmxXYkZjNUha?=
 =?utf-8?B?NmlMVW9mcDdxTlJMZWVNb3gvUnlxUFRraUV6elJ4T3NYTzc4SGpvODhYZlNr?=
 =?utf-8?B?UDFkVUNhL1dnck90WjFydjFmZG9JSzFoOGNPUkNIaEs4NERRZWFMVER3aDAr?=
 =?utf-8?B?eFRqdjdCb05LVTNaalJvNlAzYnNCT29ZQkgvOUIxZW1XNmtPaDVxVUhTL3Ix?=
 =?utf-8?B?M200QTlsMXFKZlVXbXJuZlNsS3ZFclJwZmxpNUhRWm5ZZk5pSnJzcGhpcDhL?=
 =?utf-8?B?eFNzMVJxVE1UZFlJTm9tMzNiRU94OWRBNEkrc2J1TkN4RlJMUnhxdmt4VjF4?=
 =?utf-8?B?Ulc2WXFseSs1NUdKMDNPR3crZnBXbUMrOG5MaGNlbVdxK0NDS29NUS9CQmtz?=
 =?utf-8?B?OE03TUhzSVRaa0FSVzRiL3FiQVFjRjZGQnZVR0FnV3N2Vk5EZnlLUFBxM0xs?=
 =?utf-8?B?RTJ2NDhDaEZqaVRxRlpOK25DbSs1Z2FmQ3E1T29naDk1bmVuWmdRcTJDNUtC?=
 =?utf-8?B?Y0t2TmRxVWxjUGxnMVp4MzJNMURBcmVkZHdmRzhkR09FdE9xbXhJcjdqb2Js?=
 =?utf-8?Q?j0yeeA4ZPf0t7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnhOMkVaM0U4QzBCYi9vNmdNL3dISTJueW1mKzFja0FpMzU0eHZWRXJoT2Zj?=
 =?utf-8?B?WkJieDhkcmlVdHpGY3Fvc3dwZVI1QWE4UkVLV0JhUlUxak45S0JrQTArcHdX?=
 =?utf-8?B?bExNb2RIajdqdFNWdXpoSlR2cFlqSFZyVXpPZmhuNERjVFFkaUJzS1hRTjVt?=
 =?utf-8?B?Qm9yY0FCQk8yZENkSjc5alUwV0FKUEdsWTllTDMxaUlvTXluQTNTaUtuUTMr?=
 =?utf-8?B?eXZLOG5mUGZ6dmplZHNGUDcwaWFOWkswNlhXZ1MyRWtVQXVid2dYcVhWcWti?=
 =?utf-8?B?TUVrZHMwaFViUDk1UW1MYWRiZkNwSFBKSS9WVFZsdWdGUVdIUWN2ZkV3Q2Ny?=
 =?utf-8?B?QU04dkNSY1llV0JVKzBRYzVMbWUzSlRDM0dJWi9Sc3BteldVN1REamlEK2hN?=
 =?utf-8?B?cEhmMlQxK2grZ1FvVEwyWE1WamtqUUcvYkgzYmNIeVJVZkpmdXZLM2JUeVB4?=
 =?utf-8?B?ZU5OYmtMbHIyRDNsTUtoaExOeXBUcks4ci9oZDk0YlcrZ0Z6ZEZYelJRUkN0?=
 =?utf-8?B?ZVlPM3UxRWZCRVFTYWdXZDk4S01jT3VCdVh5djhtRkRzbCtxZTJnVmFCWExo?=
 =?utf-8?B?L0JhbEhlQ2FWMk5yQ1N2aTQ2Nk9BRHIwZXZraWZmQ2hMNGVlUS9NbHprTWpN?=
 =?utf-8?B?ZzRMTG9UUk5sSkIyd3RVNFYycTFDSjEzZkt4cnBYMTdxeHFJVkFQbmlDR2xQ?=
 =?utf-8?B?RnFHMU1veUpxb2NIOHdGSGdmaHpwMHVKMU1haHdwcXNXNEtKQlZQTUN5QWhj?=
 =?utf-8?B?VkZSZENkQ25TNjRvTi9FcitlNHBrcCtWcW9VQldwK05ZbEczTnZEeDNYR2wz?=
 =?utf-8?B?Ly9CY1l5dFpTMWdTZFdpY1RlNjBGWG1ZYWhsZDZWb2ZiejJrOWdXRVdma2VI?=
 =?utf-8?B?RVdWSFhKN3pHNm0rVkxDOWVLN3dsb25JYlg1SXArVnNwdmlMQlg2QmpOUjdS?=
 =?utf-8?B?ekhOOE1wdm9ZVGlXZXdTc3N4YS9SWFFneEVOcjBscTV2YWZDZmMxZllOREhs?=
 =?utf-8?B?ZFlSWUNKTWtpRDdJNlFNYmRDb2xuZlBhWm5SdnlaVE00L0QrdWdrclJWMGNu?=
 =?utf-8?B?MHBDMEZ2ZGpQYjl4OHFTTjh3bkxtRnN2Y1R6ekNpK2dFSDc5MjQxN05ya2E2?=
 =?utf-8?B?SnRkQ0NhNlkvR0NTcWNXNjV1cTdSVDFxc2V5NytsYk1Lb1Nad3RNQnJIcUV0?=
 =?utf-8?B?a3ZYRUlscUNBbSs4YjUxeUhuVlgzQktkeUxyWVpWRlR5UHhybUtHSC9SZ0x5?=
 =?utf-8?B?ODZTNnI0SmRTL1hmMkVKNTA3WkN5VzJOaFIyNllJUUVVZjJhZSswSERCUUNH?=
 =?utf-8?B?dC9XeGc1anJSRkdaYS9kY0NnV0tqZFlDb0I1c1BVVlQrVUlrWVhzMlJ3SDEy?=
 =?utf-8?B?YzlsNllmeFU1a3hOYzNCUWxSTzZMdWVpVWZHUlhpcU1vYzNzT1c3NVR4c2x4?=
 =?utf-8?B?VC9qTmNabE5vTGZlWERrdTQxWUw0TEx4MDFWQ1dRcGtKVFhqbW1oQmRNOVdY?=
 =?utf-8?B?MGdWcjd0aXJnYzdMMVlJd3VBb0dBcldSaGwwVTV5b3dnYVduSHpGTzRSMlRJ?=
 =?utf-8?B?VUZ2Z0Q4ZHl4dTJyUEtlZFJrdnNzVnRVbGpzTWkyK3FYSzY3YlZaU1l0NjFa?=
 =?utf-8?B?cGtFVnZBeDRoOU1pcXdUSWQrTVFaM3paY0dwNlpSQy80Rks4MjZVTkpQQTJj?=
 =?utf-8?B?SjVkYW00QXpmYmpYSWc5WmxXdGk0THdsdVVOVWZvYTE4SnNPRW5hd1VvZkJQ?=
 =?utf-8?B?dnB4My9yb243bmJ6RGYxYlhJZlVVZjQvbDhGbEU2TkV4VTdXcEpmT2lCVG5V?=
 =?utf-8?B?eEcyK3dXY0hIV1BsdS9Idk1KdVdYZzBqdFQxREg5dy8zK3dROG54TlN2T3Qv?=
 =?utf-8?B?Z1lLZzhnNjliUytVYUNUaDk0TFdNL1hMcDlnV2ViK25VeTFsOFI3UFN6SGtw?=
 =?utf-8?B?RnhuSlZLWCtBM1laRUw3SjhtekRTaWlXV3FNcGt2R09qWkZSNjBTN2luNnk0?=
 =?utf-8?B?NUFRc0RjZVhtVm8rNXhicmwyMjI5aTNGMlpQbVBMdExKK2x5QzN1czNMRU1O?=
 =?utf-8?B?VDYyeEpscXQrbFNxRmtNM1o1SU1tOVAyMHJQU0huQ0h5SCtNOTV3MisybVFo?=
 =?utf-8?B?TEw0UlVuVW83bFRlZk5Zb2NRMEQvZDRqMERkc2twNnM2aTNWNVpDRnJZNVFl?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e96cf74-4143-4470-0ebc-08dd525f150f
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 10:04:08.8342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWahT1LixjoD8iXJjMwX3dbyYFZDiBflzg6TYADm0IvgzRh7ub+vPoGPF4yjMOsMZ1HqYd2T7jgO0LU5ZcXGiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5988
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
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



On 2/21/2025 4:09 PM, David Hildenbrand wrote:
> On 21.02.25 03:25, Chenyi Qiang wrote:
>>
>>
>> On 2/21/2025 3:39 AM, David Hildenbrand wrote:
>>> On 20.02.25 17:13, Jean-Philippe Brucker wrote:
>>>> For Arm CCA we'd like the guest_memfd discard notifier to call the
>>>> IOMMU
>>>> notifiers and create e.g. VFIO mappings. The default VFIO discard
>>>> notifier isn't sufficient for CCA because the DMA addresses need a
>>>> translation (even without vIOMMU).
>>>>
>>>> At the moment:
>>>> * guest_memfd_state_change() calls the populate() notifier
>>>> * the populate notifier() calls IOMMU notifiers
>>>> * the IOMMU notifier handler calls memory_get_xlat_addr() to get a VA
>>>> * it calls ram_discard_manager_is_populated() which fails.
>>>>
>>>> guest_memfd_state_change() only changes the section's state after
>>>> calling the populate() notifier. We can't easily invert the order of
>>>> operation because it uses the old state bitmap to know which pages need
>>>> the populate() notifier.
>>>
>>> I assume we talk about this code: [1]
>>>
>>> [1] https://lkml.kernel.org/r/20250217081833.21568-1-
>>> chenyi.qiang@intel.com
>>>
>>>
>>> +static int memory_attribute_state_change(MemoryAttributeManager *mgr,
>>> uint64_t offset,
>>> +                                         uint64_t size, bool
>>> shared_to_private)
>>> +{
>>> +    int block_size = memory_attribute_manager_get_block_size(mgr);
>>> +    int ret = 0;
>>> +
>>> +    if (!memory_attribute_is_valid_range(mgr, offset, size)) {
>>> +        error_report("%s, invalid range: offset 0x%lx, size 0x%lx",
>>> +                     __func__, offset, size);
>>> +        return -1;
>>> +    }
>>> +
>>> +    if ((shared_to_private && memory_attribute_is_range_discarded(mgr,
>>> offset, size)) ||
>>> +        (!shared_to_private && memory_attribute_is_range_populated(mgr,
>>> offset, size))) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (shared_to_private) {
>>> +        memory_attribute_notify_discard(mgr, offset, size);
>>> +    } else {
>>> +        ret = memory_attribute_notify_populate(mgr, offset, size);
>>> +    }
>>> +
>>> +    if (!ret) {
>>> +        unsigned long first_bit = offset / block_size;
>>> +        unsigned long nbits = size / block_size;
>>> +
>>> +        g_assert((first_bit + nbits) <= mgr->bitmap_size);
>>> +
>>> +        if (shared_to_private) {
>>> +            bitmap_clear(mgr->shared_bitmap, first_bit, nbits);
>>> +        } else {
>>> +            bitmap_set(mgr->shared_bitmap, first_bit, nbits);
>>> +        }
>>> +
>>> +        return 0;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>>
>>> Then, in memory_attribute_notify_populate(), we walk the bitmap again.
>>>
>>> Why?
>>>
>>> We just checked that it's all in the expected state, no?
>>>
>>>
>>> virtio-mem doesn't handle it that way, so I'm curious why we would have
>>> to do it here?
>>
>> I was concerned about the case where the guest issues a request that
>> only partial of the range is in the desired state.
>> I think the main problem is the policy for the guest conversion request.
>> My current handling is:
>>
>> 1. When a conversion request is made for a range already in the desired
>>    state, the helper simply returns success.
> 
> Yes.
> 
>> 2. For requests involving a range partially in the desired state, only
>>    the necessary segments are converted, ensuring the entire range
>>    complies with the request efficiently.
> 
> 
> Ah, now I get:
> 
> +    if ((shared_to_private && memory_attribute_is_range_discarded(mgr,
> offset, size)) ||
> +        (!shared_to_private && memory_attribute_is_range_populated(mgr,
> offset, size))) {
> +        return 0;
> +    }
> +
> 
> We're not failing if it might already partially be in the other state.
> 
>> 3. In scenarios where a conversion request is declined by other systems,
>>    such as a failure from VFIO during notify_populate(), the helper will
>>    roll back the request, maintaining consistency.
>>
>> And the policy of virtio-mem is to refuse the state change if not all
>> blocks are in the opposite state.
> 
> Yes.
> 
>>
>> Actually, this part is still a uncertain to me.
>>
> 
> IIUC, the problem does not exist if we only convert a single page at a
> time.
> 
> Is there a known use case where such partial conversions could happen?

I don't see such case yet. Actually, I'm trying to follow the behavior
of KVM_SET_MEMORY_ATTRIBUTES ioctl during page conversion. In KVM, it
doesn't reject the request if the whole range isn't in the opposite
state. It just uses xa_store() to update it. Also, I don't see the spec
says how to handle such case. To be robust, I just allow this special case.

> 
>> BTW, per the status/bitmap track, the virtio-mem also changes the bitmap
>> after the plug/unplug notifier. This is the same, correct?
> Right. But because we reject these partial requests, we don't have to
> traverse the bitmap and could just adjust the bitmap operations.

Yes, If we treat it as a guest error/bug, we can adjust it.

> 


