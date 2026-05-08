Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7460ECD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHUY-00054h-Qc; Fri, 08 May 2026 05:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wLHUW-00054J-Lk
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:27:28 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wLHUU-0000VY-JI
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778232446; x=1809768446;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YIDouYuP6kuH/EuCVGCi0IiRZTkJ4vr1FZNAGQkU7wg=;
 b=g9pE15S8+YEVHAniKHjT8TvG7JbX2lErtyj4oCEFKfJfF0+JtLPhobdU
 jEKNIhOq3vlqB8X9LHrGRGjBYxui+/0O0ueixhmbFe92ipvrhy3vSpp9P
 XckPN4NPAlmKIdfPfI8YgFX0wDu9waw8T7/DNLoNtWgtQPMgl91OqGKs0
 q1IYSlPw1fSB5vn1a4CA78ynpnrr2RMimJdaUPZRM94bmTAR1qYimkaBf
 wyaCRDb2ZIKDdWDxGcci8zopiF0UJTKAKrc8stppaNyJ1iff5ctAd3AfV
 +hT9GnvrGR87pJ3YbW5f5d0pnAq3zpIRWLlF3uIg7waI2CBbCWzsBSQsb w==;
X-CSE-ConnectionGUID: jbsQ4bm9QeWA9fCC5f/T8w==
X-CSE-MsgGUID: FhZWCU7eTUutsGBQM4KrGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="101870254"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="101870254"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:27:26 -0700
X-CSE-ConnectionGUID: wTnTqZvDSW6N7mR/KmMJeQ==
X-CSE-MsgGUID: xEiZ6Q1LRtWeLvQr1jDQvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="241724031"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:27:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:27:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 02:27:25 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.32) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:27:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ociEHxF7B0MzStf19JnPkzcSZaN4o588xE1pawk+AnwsjSpyYzid9ebdjRKJkJDGcWFMdOHhnTdVFlkS+J/QBLcmuOd9xZPconcWCc9ogZq+YQFID6/Q6yilp6uGNHcBEUzKq73O2VZISKoZO6j+CJ3IfTgmqd9bLKJLsg0XA9ilCTVqcrcLX8R52h3skOT8Zt08yNTKIMsm7OA5FqI2wThCk72VpLKUg2tM/OU7X9kx6Bi/y26SIATNNhURyehZdsiUis7XS34U9LvzUPrjIal9wtGYUYMoCsN0QDxyUqXy44kkyGjynMbZJFHxHkfxaYT9I/yNfbSO/b3luCeISQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/p8KpoVchdmmCxtY30/qH6uwaeKcaLumsENlkzfmKI=;
 b=W+A46kTvSAQCv8na57vq08YNRM9akC1L17saD0KWhPQuPR79axKAyXBil5De+OvgUgz2XEosqSWj8fMbhXSA2VbzNVBu7KzXbRdeIKbN9z0zjOQJYtURVTaj96q1CFYNUNbu+HsjMcoR5xFI/hqSIg1HLCKme7wSlFeyWpA3eCA+Ylr5/Z7peAgZWLPzYKBNmg6LeJc3fqrtmxs9osXIVeRhpu1xXUuUIw6qW7F1TLByLlY7RkLx7ghnjxtu48sBrsT0fnnxRaCcfwLrMCW47i/BYn8vHkPMVZDTSJGEbpJOF2dExZO5/3z+XaZyi74z7q8RgurId4XQNnceIl+KXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by PH7PR11MB6700.namprd11.prod.outlook.com (2603:10b6:510:1ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 09:27:21 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%4]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 09:27:21 +0000
Message-ID: <9f1a5921-a86e-4f79-9ae2-860a10f24d80@intel.com>
Date: Fri, 8 May 2026 17:35:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] intel_iommu: Simplify PASID matching logic in
 invalidation handlers
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-8-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260430071315.354333-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0010.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::19) To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|PH7PR11MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b18ad0-15f9-4e5d-3c9d-08deace40159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|42112799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 5x40/jrEPn3yPULFlw+OqmYxQ3DM4jlZtIbWKz68ji1+5DPtvF5wtmP4E4ggnVReVNds/g5EIQd0FHdowu56QyhhYufXvWVE8gUMJGFhD9f7927xf4Ihn+1vQE/ckSS58PykRMJbYDb0uN2OcNPA3WS9PjsAgtXqe6ExHHfJ37gLpnfTIXS4ie6e5LwAwubYLtwBhqVz9xTcssNx9MVHtEi7NvX5XunVK9tNfnVNLGJ7IpaZizRoX6IfhEOauk4rMAryc3pHzaqWGcXKmUSHqCzp2Aw1ZUz8K9YPKXmLie07bKvQxANmRWeHBvoodcnTd8hFiuYYgX+8i7cSRwqjKiXz1EENlkKYa/U1t3YlkDjlsYdZVyIrrciWRXg4d/uqlPk+DggFfIWnUVb6i0bBaHvYNaZ1Hu5dc6hs0eSB2VGHjMS0HSVcmBNFZyr4ul9J366VK6MM3wqKy2QzDCD3CnkBe4rpYasT32yWE41S9ZogdYNZ0vWJnY0j7f2qYJPSnP/76rhAndY8g6sdGFy5ZnTU4F5ttbfzy0BnhX/9katFMcydF+IOIRqrXQWDUyk3ZSD2n19n7R/IgnqIBOgbEBKayZppOMKenKdyKrYP0JHni2VRlqhG0J+sCuWRhUajJwZwH/NJP24zs+i43Lp53czhu5yeEQqZoDX/f3qdkf2GoGeG82diL5XVkRUcW69D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(42112799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVFRU1hGWjUySzA5T0tqMDU3U1ZSOW5hVVJ3WDRhWVVvaGRWWEtJTzdwL2Vz?=
 =?utf-8?B?M3Z1aWdnbFNUSUNJbGlmakZWT2RlOHNlU3NXRWxVLzB0Q0MwbHhmNjlSVjJK?=
 =?utf-8?B?V050OXA0ZVZvN2Jha1RRT01hTTNUUkNlR01ZeWsrYVYrWG52clRCbE9Odjlo?=
 =?utf-8?B?TlpvbmgrSzlZbWJMMFpDYlVRL2ZRc0ZoQ1hOZHdLMG14OWU0VVFkR3lWK0w5?=
 =?utf-8?B?ZXZSUUs3aDRGTGFvMnl3VEJlSUxvTEpwNVJjaXAycGJubkkyTXNMemF6Mnll?=
 =?utf-8?B?clJmbWRuUzdxWHNCVXZHQUVuTWtSU1c0TjQ2M3BtTDA5ZzhpQ0xmMXhXbHpZ?=
 =?utf-8?B?MkY5clo0dUM5MXJpaUdGWG55ZGxRMFBlOWRiMXBZdGQvNVlSSXpDN0dnUnN6?=
 =?utf-8?B?eHpBWHE5US9QWTdVaysrbmtsVFJ3ajBIdXQ5Szk0K0dWRVhpVU92ZDgrMnh5?=
 =?utf-8?B?Q3FYb3JXNDI4MGI3aXIvdWh3V0diWTlXTUhScXJqb3lGUUFXVUdrcUZCNVlm?=
 =?utf-8?B?RlEvZ2JHN2I4SjE3dHY2OFVLNlIzbE43cE1YajBCc3hwRmZrbWZBS29WRkQ3?=
 =?utf-8?B?WUUwMnE3WUd2TzlrRTQ0T0puaHZ6L2ZWMFdvWWcxUW1yYk1LdHYzdXFyRnVT?=
 =?utf-8?B?cnlOQ0hQTWVQV3FnVXpCMVdqOWpwSmxuaStmSHhqZE9TZ3hNdmRnRExKYjRt?=
 =?utf-8?B?c2hMZDRrWjhIdjBUWUcvZUlzZFJ4KzNFTUlycStvOEljUnAvbWRJRFBXM3Z6?=
 =?utf-8?B?Q2c2Rk8vdmliaUFIYnBzNElkVENXeG5nWHh3YllxQ1R1WE5ad3JvVXhvb09D?=
 =?utf-8?B?cDh2aGtzdTNNbTdoMlJWRXRtRXYreGVGZW1rYk12cERSRTFocDB0OWdueHF6?=
 =?utf-8?B?OHk0Yys5Yk5TN2ZWcGcrd1JEV1hZcjQvTXp2UFVpdkhGekpiWE9JSkFSRTFH?=
 =?utf-8?B?bjZmYmlVWXNQMGxocnh3UlN1MDdCNFllUzdubFplc0VSSnRWTEVrbFI3dFhM?=
 =?utf-8?B?cWhZRWhBNkhnZUZNanU0WWJLdGdkcXBYbWF1NHV2RStTYndPUWtienNJWkJO?=
 =?utf-8?B?UFpOa0RJT241VUsyNERpU0hLek1ZWUNHSU5tamh3TUNyZkFHMC9oRUlxNUI1?=
 =?utf-8?B?NWJIZldjemxDOGdQemdmZ2xVUFRiRm4yMU1VMUhRQkFwT3lpNXFVZk9xbStN?=
 =?utf-8?B?eTNjcnZqOC9TcnhUcmpydWVWWER5dXBFMysxQ2NKUjRDeU1ucStnbkJmZkRS?=
 =?utf-8?B?QytkcGhGZVdhaklWSHlZRW9MVUVhNTJQSGl0ZUsxbGx2ZXNQUGMyem1EQ0Zp?=
 =?utf-8?B?aTRONXNMc2NuVmMvQkNVQlA4VzcybnZPWTJqU2NEK0dSZVMxWDRzbWdrMFlj?=
 =?utf-8?B?ekpXd0oyc2NzTjBwWVNMUEd5UjREUUNmbm4xY1JQVmtyWWh3dkQ0a0xEV0Fp?=
 =?utf-8?B?VVJiSXFrVjR2c21RRmI5YTQ3NnFTZUIySWlNMnNmQTJtYkNkV29MRmVTVmlP?=
 =?utf-8?B?aHp5dUJVUmxGQ3ZQazBqVFprMHJHbmw3TUpoVFVRdUM1MUw1K0l6K0VkZm5U?=
 =?utf-8?B?ZkJ5cmZvc1U0WldKUGROaTdxZ2xOaEpzbU02UzdRR09CaHc0WmtRaDNmWVkv?=
 =?utf-8?B?dUZxMWpsencxcEZVV2VBSjhGTnhGajgxOEcvT2hXOFJOeXNpYWhWSWt1aFNi?=
 =?utf-8?B?MXNvc1RQZGFUM2R1eWl5QUpPTEFvV0U5VDU1bEkwSG8xV3pMcjhURWVKTXFJ?=
 =?utf-8?B?SU10bHE5Z3ZXU3A1MkNhdXdTU2pBQUQvZmN1MWwzbUlGeDh5U1paUkJ0WWxR?=
 =?utf-8?B?T281K09xenNmaGhjRitNaWpTaG5GUWxoR0xvdng0ZEFNNm1lMERWYlF0RHZB?=
 =?utf-8?B?MklGRVRxckJVTSthaHNkQmJVUjZFVTlHUng3b0I2UHZzMFNuMDk1UEZZSWhM?=
 =?utf-8?B?RWg5UHl5U3BCMlhsN21CbmdFYk55dlhIVDhPOWVaNzJvTmV0L0NkczQ5a2pp?=
 =?utf-8?B?bmhKRGdJQzFxSzJnMkpMdEhJYjQ2blAxK2dmT3NYSjdPNXBtWnN4U0k1d21K?=
 =?utf-8?B?Y3RJSzh2SEMxOFVNMHN2T1NtdnRESDVTcTZxb2tlVGpRMGtIY2I0UjQ1Q0w3?=
 =?utf-8?B?K3IzYnVEUkZ3VFNCRHQyTm02ZXhOSWF5cEo3c1MwVW5OTSsxVGluRFY4c0RY?=
 =?utf-8?B?SXVsMm1tdTRxeDYybTRzVWxDK3Y5bE9RZXV5Y0pVUXk3c1dKUG5MTGZJY21X?=
 =?utf-8?B?M2M2QWRrbVV0bENOOGVmdmMrRnVhcU1RMmxyZFhHempleGlzSDlCSzBCeXFQ?=
 =?utf-8?B?eS9BS2E2NFNUZk9qc1RQWWRkZ1hHWU1HQjl1akMvc1dLamJWeXZPZz09?=
X-Exchange-RoutingPolicyChecked: t8NVmrV5zYHqZcJtCM8QJuybxki4QPzdG2GQTQhvCZ41vocabjrWZVzU/imWpuND1pKFtB2FcQJ1sJwnhJWJFvANeTOcTM9iI62DGxXhp1azbUHzSUxci9OxySig62wB2cFEimil6TudfloaQzXkUa+81hUBHBJT/3kSKoxgxJQJNNPXa8lsILgc5FQ3zzzKtrjBFZ8S63ISU3TmrYQNswiHWd/gHitwwOqWiZydezWsY4aqFMHsCtcn84njSaxveZoSxVszeF8yptXs1EJwF2zc62fRKf4xtdf9Z24nfchn8LSlVbFOjAtIeJB4j1nOjp77kepBF25UJVac3vYg4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b18ad0-15f9-4e5d-3c9d-08deace40159
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:27:20.9905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pfHCIWy6ER9pefprWLokvxeXkRUfPA+t3Y8eESpEEVJop+oNkmjxCoiiXh9O7qgwFBJv27NQqx8GGYYzHZA1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6700
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

On 4/30/26 15:13, Zhenzhong Duan wrote:
> Refactor PASID matching in IOTLB/PIOTLB invalidation handlers by
> introducing a helper function to convert VT-d PASID to PCI PASID,
> eliminating complex conditions.
> 
> Suggested-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 132 +++++++++++++++++++++++++-----------------
>   1 file changed, 80 insertions(+), 52 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6715cc4383..74642d8123 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -92,6 +92,34 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>       }
>   }
>   
> +/*
> + * Converts VT-d PASID to PCI PASID representation
> + *
> + * This function handles the semantic difference between how Intel VT-d IOMMU
> + * and the PCI subsystem represent "no PASID" scenarios:
> + *
> + * Requests-without-PASID:
> + *   - PCI subsystem: Uses PCI_NO_PASID (-1) to indicate no PASID present
> + *   - VT-d IOMMU:    Uses PASID_0 (0) to index the PASID table for translation
> + *
> + * Requests-with-PASID:
> + *   - Both subsystems use identical PASID values (1-0xFFFFF)
> + *
> + * Since PCI PASID values are cached in vtd_as->pasid, this conversion is
> + * required when mapping from VT-d PASID space back to the corresponding
> + * vtd_as (address space) structure.
> + *
> + * @pasid: VT-d PASID value to convert
> + * @return: Corresponding PCI PASID value
> + */
> +static uint32_t vtd_pasid_to_pci_pasid(uint32_t pasid)
> +{
> +    if (pasid == PASID_0) {
> +        pasid = PCI_NO_PASID;
> +    }
> +    return pasid;
> +}
> +

this is a good cleanup. We can do something further:

1) Rename the pasid field of VTDAddressSpace, VTDPASIDCacheInfo to be
    pci_pasid. This would help a lot when reading. w.r.t the one in
    IOMMUTLBEntry, I'm not sure since it's already out of vtd, but a
    a comment in the definition might be helpful.
2) vtd_get_domain_id() now accepts a pci_pasid, so rename the parameter
    accordingly.

>   static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
>                               uint64_t wmask, uint64_t w1cmask)
>   {
> @@ -2487,9 +2515,10 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
>   }
>   
>   /*
> - * There is no pasid field in iotlb invalidation descriptor, so PCI_NO_PASID
> + * There is no pasid field in iotlb invalidation descriptor, so PASID_0
>    * is passed as parameter. Piotlb invalidation supports pasid, pasid in its
> - * descriptor is passed which should not be PCI_NO_PASID.
> + * descriptor is passed. In both cases, pasid is converted to PCI pasid
> + * before checking with vtd_as->pasid.
>    */
>   static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>                                                uint16_t domain_id, hwaddr addr,
> @@ -2500,51 +2529,45 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>       int ret;
>       hwaddr size = (1 << am) * VTD_PAGE_SIZE;
>   
> +    pasid = vtd_pasid_to_pci_pasid(pasid);
> +
>       QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
>           ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>                                          vtd_as->devfn, &ce);
> -        if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> +        if (ret || vtd_as->pasid != pasid ||
> +            domain_id != vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> +            continue;
> +        }
> +
> +        if (vtd_as_has_map_notifier(vtd_as)) {
>               /*
> -             * In legacy mode, vtd_as->pasid == pasid is always true.
> -             * In scalable mode, for vtd address space backing a PCI
> -             * device without pasid, needs to compare pasid with
> -             * PASID_0 of this device.
> +             * When first stage translation is off, as long as we have MAP
> +             * notifications registered in any of our IOMMU notifiers,
> +             * we need to sync the shadow page table. Otherwise VFIO
> +             * device attaches to nested page table instead of shadow
> +             * page table, so no need to sync.
>                */
> -            if (!(vtd_as->pasid == pasid ||
> -                  (vtd_as->pasid == PCI_NO_PASID && pasid == PASID_0))) {
> -                continue;
> -            }
> -
> -            if (vtd_as_has_map_notifier(vtd_as)) {
> -                /*
> -                 * When first stage translation is off, as long as we have MAP
> -                 * notifications registered in any of our IOMMU notifiers,
> -                 * we need to sync the shadow page table. Otherwise VFIO
> -                 * device attaches to nested page table instead of shadow
> -                 * page table, so no need to sync.
> -                 */
> -                if (!s->fsts || !s->root_scalable) {
> -                    vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
> -                }
> -            } else {
> -                /*
> -                 * For UNMAP-only notifiers, we don't need to walk the
> -                 * page tables.  We just deliver the PSI down to
> -                 * invalidate caches.
> -                 */
> -                const IOMMUTLBEvent event = {
> -                    .type = IOMMU_NOTIFIER_UNMAP,
> -                    .entry = {
> -                        .target_as = &address_space_memory,
> -                        .iova = addr,
> -                        .translated_addr = 0,
> -                        .addr_mask = size - 1,
> -                        .perm = IOMMU_NONE,
> -                        .pasid = vtd_as->pasid,
> -                    },
> -                };
> -                memory_region_notify_iommu(&vtd_as->iommu, 0, event);
> +            if (!s->fsts || !s->root_scalable) {
> +                vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
>               }
> +        } else {
> +            /*
> +             * For UNMAP-only notifiers, we don't need to walk the
> +             * page tables.  We just deliver the PSI down to
> +             * invalidate caches.
> +             */
> +            const IOMMUTLBEvent event = {
> +                .type = IOMMU_NOTIFIER_UNMAP,
> +                .entry = {
> +                    .target_as = &address_space_memory,
> +                    .iova = addr,
> +                    .translated_addr = 0,
> +                    .addr_mask = size - 1,
> +                    .perm = IOMMU_NONE,
> +                    .pasid = vtd_as->pasid,
> +                },
> +            };
> +            memory_region_notify_iommu(&vtd_as->iommu, 0, event);
>           }
>       }
>   }
> @@ -2563,7 +2586,7 @@ static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>       vtd_iommu_lock(s);
>       g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page, &info);
>       vtd_iommu_unlock(s);
> -    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, PCI_NO_PASID);
> +    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, PASID_0);
>   }
>   
>   /* Flush IOTLB
> @@ -3001,12 +3024,17 @@ static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer value,
>               (entry->pasid == info->pasid));
>   }
>   
> +/*
> + * Piotlb invalidation supports pasid, pasid in its descriptor is passed and
> + * is converted to PCI pasid before checking with vtd_as->pasid.
> + */
>   static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>                                           uint16_t domain_id, uint32_t pasid)
>   {
>       VTDIOTLBPageInvInfo info;
>       VTDAddressSpace *vtd_as;
>       VTDContextEntry ce;
> +    int ret;
>   
>       info.domain_id = domain_id;
>       info.pasid = pasid;
> @@ -3018,18 +3046,18 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>                                        false);
>       vtd_iommu_unlock(s);
>   
> +    pasid = vtd_pasid_to_pci_pasid(pasid);
> +
>       QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> -        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> -                                      vtd_as->devfn, &ce) &&
> -            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> -            if ((vtd_as->pasid != PCI_NO_PASID || pasid != PASID_0) &&
> -                vtd_as->pasid != pasid) {
> -                continue;
> -            }
> +        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> +                                       vtd_as->devfn, &ce);
> +        if (ret || vtd_as->pasid != pasid ||
> +            domain_id != vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> +            continue;
> +        }
>   
> -            if (!s->fsts || !vtd_as_has_map_notifier(vtd_as)) {
> -                vtd_address_space_sync(vtd_as);
> -            }
> +        if (!s->fsts || !vtd_as_has_map_notifier(vtd_as)) {
> +            vtd_address_space_sync(vtd_as);
>           }
>       }
>   }


