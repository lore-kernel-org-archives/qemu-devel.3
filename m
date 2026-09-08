Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E62DC79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 02:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3lIA-0006KO-3Q; Mon, 07 Sep 2026 22:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1x3lI4-0006Ca-NU
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 22:10:30 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1x3lI2-0002dW-HR
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 22:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788833426; x=1820369426;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=8NvoMsEkeaEoxVhEaU+Yei09IuCK63192QpTdYEa7WY=;
 b=iPpjqeyu06mKeK4G9w7qtgrHzxPqwJ7Lh26l/mLaIGEFdVsoYqYc051M
 J+M/cB0932jfs5sp7pppLXEpK2pMcVziqG//D2AVNaRWN5aZ58x4jIHxR
 1elBkQ/tC1eS4COo4uhJhwmq1hltlL5jTz4ABAZxDNbVcSr4mOB88uk9E
 i6SkWofdZukf7ALu2yCGwvocr5rhTGM/H3+K3deoFjrMQfcrATQY/r/fL
 tpk11N8thByZ/WV5NNL5CNx/JPek3Rhht1KYexuOArhg10Vhi0EOszEop
 I0qcw5JEaarkeTJfYXqKgQQPGoDzAy2cNrDoLfWornJNE8FKIa+3ix6Lt w==;
X-CSE-ConnectionGUID: dn9W93D8QEWPTVmWG5pGPw==
X-CSE-MsgGUID: 7rkEJP8HTmGZeI86PiwHqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="88377477"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="88377477"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 19:10:20 -0700
X-CSE-ConnectionGUID: bGzy5njnTqa8AdwEsasvkA==
X-CSE-MsgGUID: taJf8LKTSWmLB1tZ8ZH1RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="269531379"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 19:10:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 19:10:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 19:10:19 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 19:10:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+PRqs8kLdusSjHS3nEZr5OU0SMMbtP3ZUwmCnrZIjbnCz9TS+QEUnlG5irtib2HDPvBLsVnBvJw4HfAUNV33yVB2UqqM6EqAjPYKQvTU+hShQR5a7EC66YF6TffNFTOZvtQgaSUa0M55eGugmsE8s+QZM72AgRaKEKlMSdvy+wMNg9/zccMlER6uPI1IYWpGBWhq6l+M4vwMQmQ01sY+9OZMLasuKgiJEij7uYPXGiU9WAoeLlwX8Zb2p8AYqMNrmgW1FYMl0mz5xC7XTp8XuiYPwOD7vQCl/ZsIsY+P3VoNRR7txQGE2/wthcFuRNDtsOOZL21UjNOB06v/FNxPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2M9IItTsER2TBPqYR7uCcgJf9JO0Y8QECdZu69Xm+w=;
 b=SjXYu4pZO6U5dGZG1ZUWYpBlD4EZKuWxDibD0qT+o2tav+AD+BM48txnxfHgzkX8FyaVwERPg7OIilp5fSn2rkTp4prj8nYLyCka9mUo0ZcjDK8FIZ+NH9ysXYlgmicbFUkqrcWtp0f/HoHiZ6892iCYTnwNUieWxJHFK3igOe0Vl6elT+NpINLA2BOu1NThIEeDLUgQ95TmivqE9uzymTd4xnKtNSYppB0Wk/EcAtqKwZ3My+PnNO9BSiAYcU7PxBTEC7uZe3LSW01fnEe+TNKZ39XRBhyuU2iQjvTC9CVu6ysgmihuRteSRwsGx7pZiI6U9Cscl5GJ2upGC2W3eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 02:10:15 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 02:10:15 +0000
Message-ID: <ccfbd5d4-e00f-4de5-890f-2a88ee5620c5@intel.com>
Date: Mon, 7 Sep 2026 19:10:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/20] target/i386/tcg: add APX support to XSAVE/XRSTOR
To: Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-6-pbonzini@redhat.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260825122921.431739-6-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|MN2PR11MB4648:EE_
X-MS-Office365-Filtering-Correlation-Id: fb4b7188-93bc-4f09-6a3c-08df0d4e52a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|18002099003|22082099003|56012099006|5023799004|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: veI3fCnNYxs2zpF2W4ieCupNLM1uwz4AZUJETdaZkqoqXYbCbAsfQNykNplyi1WzOZFU2yDrVI8ZXuYSKW1yP8u91I22bQL+t4bm58TKrkqNYJiZadnRv8XjcUHFQcCjUl0+tNxSeOVnEm0q3qzMlCFHZcxVMyJoDKObiEv9L0vOzChTA2IvGnivlqzzvpQotZwJXd7l354Itc7xLE9dWZCB5HMi7yr2nqv7bkeIIE+9GYbrG0H/tO4DwiK378zxKHEqn+UeVlqcnQC43wppiFDzy2Q/vs9yQ3WdxDXzojCUImVu32CXw8SUs2ssyT4OWDdTdGxbr5o04BOaXiR0jpfiEh5V34KSy0Rgzklr3aP4maXzWb93OhJB/y4jFTFrKpCPtLeB8gArDh5KqroLZPA59BQiD2F7EQzLZqB38Femg5+JFfJFb6tcZcKu9hvMh9BKf1OOSxm4NgNKUr6yg5h7FkxooCNSQ/+iT1sS0zQ6teBqCSLYsWVMtMnKHweDjOOLDFJg7B9s4z9mX0gheP0PomKsAgYvkvDYViVc0eI+dt6dTjbcLuOFi+trUBtMOmFntDmtH6CwxWmu9k59hbemQrfhFts3jSzW+K7x7PWTt/56pdomHJ+h91Sz2hH2but1w15/fn3SzsYJtErUAU3wHG6iId5ynEkFaUw3MMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7925.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlV1aktxRmNaZWtwb1pwY1I2L1RqQk1ZQ2VheGs3SVBLakFrYWxKOFFyeU9G?=
 =?utf-8?B?NnF5MWk4T0ZaajFUUEVuajQvTlNRNnFHT3o3UWVBTzM0NkxCL2tHaWRmWmNo?=
 =?utf-8?B?KzRCbytlYlpnYWV1a0cyYU50ZFRhUkRsT2pqbHlzOG5vd2Zrck9rOEhTYUVB?=
 =?utf-8?B?QmxJYUpXdE1Vd0RRVVFaZFNRQkNnMEp0b3owZWRxZzU3ZFdUeTlGK1owR0pM?=
 =?utf-8?B?U3JvQWZPb1JNbVp0NSsycXF4N1lsK1dhSGtPMnV6Z210cXUzOGRDUHJpeWJV?=
 =?utf-8?B?REdvb1BBaTNnV29JMzdPY0lYOHpwVW93SkU1Q1AyVWQrek9HVmtKV20wR3Rq?=
 =?utf-8?B?Vm9XVWF3aFNyeSthdFV3NEs0TnJzQlVuMkUwZnVUV256MndZVDN6WW5GU2Z1?=
 =?utf-8?B?VS9tR3Y5Y0hLMHZkcHNTL2x0N2EycjVJcGxPZlBYckhSdmhqZGtPU0NFVkVs?=
 =?utf-8?B?VkNSSjZEQjFpS3V5VGM3WGNLK21sZkl1bm1xdXdQdm5SMitJaW0zNW9VenhH?=
 =?utf-8?B?cGVsVUlLV2VpaDE2QUZLdFRJOFpXTktPaXRvV09mUFJqeUgzYlBIVlJpUkZx?=
 =?utf-8?B?aHlGSEFiUk9BWkZBU01GOXFwak0zZllRUFVzSVZXcTRpZVVJOWltalVlSENm?=
 =?utf-8?B?eXdEbVFKVnYvSkMwOGNXanhvdXRZMVpOZ2NGd2F1dmd2RUNYeGNvd3U5TDdD?=
 =?utf-8?B?VG54bDRKQUxBbTRpZlRjL2xsWTBseVdVeWx2cUMrajFSdE0vcURpWmpQOHVp?=
 =?utf-8?B?STljMk1wc3ZXSHFlSVhKd2pLNmhaMmFsckNHRHA5eENjdGdrVzVRRzlvd09C?=
 =?utf-8?B?b2lqdHJFYkdDM2J6Y2FnQkUzNmlLRFJNcUZlZjRoenczRzcyMUtWS0pjUWEz?=
 =?utf-8?B?QXVJaStqaVQyNXZ2TmsyS2Uyd0JTT2JEdHhXbXIvWHJ3YjV2K1ZDTk80bnBi?=
 =?utf-8?B?Z2ZBUnkwRkJscjJxSHBjUTRpZWpucUFIZEdhS2pkaGZVVzN5ZXNKWjVnOFo4?=
 =?utf-8?B?aTRFL2pJVTA2OVdWTFcySmx5Ym9rU2kzQzQ2N2RjNkZTekpxcGlrdjhDbTQ0?=
 =?utf-8?B?czNSdHpvbC96aUFPMjFnL3B0UkNrSXk1MGw2UEMrVmxyaDg4NmlRNHdVa2Fn?=
 =?utf-8?B?aS9tWTN1S1JRamhXaVhDeEdYaExMeWZVR3RKdERJVnhpMTZoOVJWdXMwejVk?=
 =?utf-8?B?NGtleHZRQmRkVURxNzVRZjJJOHFvMDhqbkFQTHR2Z0kyTERFRERraWRFOXMz?=
 =?utf-8?B?NTdQekZrTGFqczBWWDlNQ1cvVVdKQUhPNU8rS1IwbEV5QkVGVzFobnJ2MUly?=
 =?utf-8?B?TFhiNHVMQk8yUURHdmo3cXhhR3FYdmkyS2NROUVDWmZ3VlJzTjdUWU05bTJX?=
 =?utf-8?B?aVkyTU82aFk1Y1czNTBkaVdjTkdYb1pPOHNrM2tVcEN5YWxrNEJFaVBFWGpn?=
 =?utf-8?B?dS9XMkt5YTZ6RXc2NHc0K3NrSHhhbUgxemNrWDRwdXdDRzkwVVBYenVIbFJG?=
 =?utf-8?B?NmVuL2ttdjBpRDZxdUg5S2ZRZWxDODlMcnlxTFNOU3ZDQklxVHhvc2ZnMmpG?=
 =?utf-8?B?dE1ybS85NC8yRUhVQWgrbkVvbjNsN1NmTjhUTTNYbVZkclFmY01nRmpCenpQ?=
 =?utf-8?B?ZjQyWlNrNnFnc3lYSDJNQXFMZ0ZjcGdDRkpxODVRZmpmVjNtSDE5RE16V3dC?=
 =?utf-8?B?T01XWXlkdVdmTGxGMDVEd2dCQ052NWUrSmp3alViZXlZTm5OQmR0YXhkdGtV?=
 =?utf-8?B?bjBueG9mRCtabXRJNi8zbVIxNlhUOElDWis1TVQwRWZLVGVLK1RwdkFibVUw?=
 =?utf-8?B?Ui9hMXFGUC9xbC9kQ0tJRGJobmNpM01nS1liVy9VN0c4WlZ4TWpQajYvTExU?=
 =?utf-8?B?K3EvT0FaRjJJaURnV0x0MXkzNEZra2x4VFp0YXJVVzJKZFdNRFdhems0Uk42?=
 =?utf-8?B?T1lDTGdCVGRBZUJmK3E5Si9qN3pZT1pjRHd2VmZNYkpsU1ZIYit0SGhSTFNK?=
 =?utf-8?B?cjdsZXFFNXFXRHBISDRxQ1A2Q0dCZmN1SmcrbEhxRHkxVkMwWkFHaE16OXJO?=
 =?utf-8?B?c3hBbXhBeGZHNGFEeVljTnErcmh6NHMzTGcyelRUbW9kaDFINWNnV2dLVFNi?=
 =?utf-8?B?U1Z6VlAzYVhYeDkvVURSOEZLS1dWTmM4d1Y1cDdaZ1dhVVhjTUJvbDRhSFZi?=
 =?utf-8?B?cUlvbkNnbzloQ1pkSzRtYkdDRTQ5aG9tK1hxZGc3ZXdIMTJZMENUeXRMbjVL?=
 =?utf-8?B?dGVpWnlQS2N2bmpWaE5VT0FFaWtRQzFKVnJreCttWEdydFVqOVZnVncrQ1Rr?=
 =?utf-8?B?dWpEcDM4WGp3T1F2SVpjU0RWTVZCMnFjZVhmTHhkVXBUTnlsTkFXUT09?=
X-Exchange-RoutingPolicyChecked: 5wN1jSl/Dcl8U01k9LxMdz9CoyPVjoTRyxiK0nX0aB2To4PiMO6q5uVsRf6qXziZcnQgYeXDELevxpYoo7X5qrcNSGEJT+nUSPqriedRQfFTgGgpYH462KuzCF1d3hdxuAZx60WnIDeX5IayZ3FAprhR/1ZgFBlZdar2ZM9jUriSUhD/4gW7oJ3SZTu6+/+m//zpH/sTOu2KYrdCgMqpdx1NVtDk3N0bpuQtcu1yXT2HGI3o7kAKh/elzKKycswMaL1c+xMi/r4ZRjJWvNbheWULEfpq3oqyioZs9Rw5Ki4QTK+sJhdaY8MRPvqQ3n/pNnti9gJQysY/jwyrd/EFXg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4b7188-93bc-4f09-6a3c-08df0d4e52a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 02:10:15.6814 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygNdnp5h8laP0RtQuJG6yD470ccE8z7hd16gg/G/mC+CWadL9Y0RMpQqGJJbWq8ihn7/ZLA1VMDG94FB3IguDb5eNTkhmnWeLsLlvVIW2zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=chang.seok.bae@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/25/2026 5:29 AM, Paolo Bonzini wrote:
> With it, add a new hidden flag that will be used to enable the REX2 prefix
> and EVEX map4.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/cpu.h            |  3 ++
>   target/i386/tcg/tcg-cpu.h    | 16 +++++++---
>   target/i386/helper.c         | 11 +++++++
>   target/i386/tcg/fpu_helper.c | 59 +++++++++++++++++++++++++++++++++---
>   target/i386/tcg/tcg-cpu.c    |  5 +--
>   5 files changed, 83 insertions(+), 11 deletions(-)

...

>   
> -    /* MPX State: */
> -    XSaveBNDREG bndreg_state;
> -    XSaveBNDCSR bndcsr_state;
> +    /* Overlapping MPX and APX States: */
> +    union {
> +        struct {
> +            XSaveBNDREG bndreg;
> +            XSaveBNDCSR bndcsr;
> +        } mpx_state;
> +        XSaveAPX apx_state;
> +    };
> +

Nit:
Along with this, I was curios if something like this would be 
worthwhile, or too much:

#define XSAVE_APX_OFFSET	XSAVE_BNDREG_OFFSET


>   
> +void cpu_sync_apx_hflag(CPUX86State *env)
> +{
> +    if ((env->cr[4] & CR4_OSXSAVE_MASK)
> +        && (env->xcr0 & XSTATE_APX_MASK) == XSTATE_APX_MASK) {
> +        env->hflags |= HF_APX_EN_MASK;
> +    } else{
> +        env->hflags &= ~HF_APX_EN_MASK;
> +    }
> +}

This check could be simply (xcr0 & XSTATE_APX_MASK) since testing one 
bit here unlike the AVX check below.

> +
>   void cpu_sync_avx_hflag(CPUX86State *env)
>   {
>       if ((env->cr[4] & CR4_OSXSAVE_MASK)
> @@ -250,6 +260,7 @@ void cpu_x86_update_cr4(CPUX86State *env, uint32_t new_cr4)


Overall, the change looks fine from my perspective. If allowed,

   Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>


