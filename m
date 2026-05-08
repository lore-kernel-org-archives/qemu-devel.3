Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77851CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHVU-0006Vx-4o; Fri, 08 May 2026 05:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wLHVS-0006Vd-Iz
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:28:26 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wLHVQ-0000yX-JY
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778232504; x=1809768504;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FLKpIT0uq6cQUyXhgm/9XkARVnpxJjNgzbL4lsxfAFU=;
 b=nBIEI8d/RJdYJDSpgi8+/wlEecLzx3hv94zQ878eg4ATCRL3ss5yLuvF
 AC3VQgT3seaOd3zLwjWLPR8gAadx/VWVwa2YkVkXVfKuR6fignXb9jy7d
 vlBzOq6r3fm5JGqI28BgllInxVjEfBVVoiwLeOKy4SV/MdgXvUvgjSFoz
 zDHwSckvBAFk92eQ8asQBKcYVXRO7y/VmEi0vNWvGVanwOxjnN5SbBS2K
 qEYsdudbKz6NiJnFkZKs8y5SwTOvDITRRp3y4NTQKHRvaf9PPf+5gLrIT
 ZzhXnSf5gVfrUca7x06+hoq1x//6SeBgLRFc5Fzcx01TC0cmm/uZHT3ZQ Q==;
X-CSE-ConnectionGUID: /PaP1DLUS2mwgYL3xe1raw==
X-CSE-MsgGUID: UkY1gHFdS1qvsrs8fVkFwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79051807"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="79051807"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:28:22 -0700
X-CSE-ConnectionGUID: 94I1rLBqTA6EzCku6aygaQ==
X-CSE-MsgGUID: AbA5pnMwSIONqQ7dB5PHcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="274837818"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:28:23 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:28:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 02:28:21 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:28:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbVV1Kp8HC9fNcZI5uQTEA/pDi19evtTENoi0Kh/mQuRNNGgC7i9CXpdsbqVlPv4U0vYF4mbW1/qK5+R/w4xa/C6ZMDaDRoe28wPvZ0OmjjKdqti9PMaOWeDx/XShLdWP2DiFomzF10fC0lBYZgyEfGBdpF4+vI4Y33ClPvS1wkiLSg3E8qkf7kKDxK9HmmgvIYUgOeDPBHCquRRiBE8TvYMctJR6lOnu9h7Ce01dEjQ+17flUc9i+01/vCIEYb/xaEEkIUC+pmZM9AFfi+ElSRVXjKDKC3xgaSsbCImty5FlpepA8UhYYbo7Zalfp2qugfrJ9I1oy3s4irGeiuL2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBRip6KSXCMtlCP2ScPuaZt8MxnA9gkscwUjdbmvpAI=;
 b=NO3n3ftiQvoicZtsxo9zzPtqkv8w+R1JoK6wKI0DBCwQoF+sqn37jCFVyD5yO4xWZv/W6TuNRiuE+c95HiIMtc8BihcF/1fqe0Jpg/7cfUtrqOKjL+/k01L8sdYQujn6OFtCOq16OhJXYF5FvGr9zj4r0gL0/AFLXU23gLni32Fe3J8BKEb5ceUh+uYQf9fZsmq8/atRG37IalE4X9DId8aNdt5bZzPE8Ofxb00YvqORpukCIqRzDJjmnQmuSrIlvWwz8yn7OcdL7Ug0A5rLSGqlaKg7BGaTu5qTlT18DD5wJqgBjCeW8e+6IN1QzahZUs4GZ08oSbd0i7b0ns+sCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by PH7PR11MB6700.namprd11.prod.outlook.com (2603:10b6:510:1ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 09:28:17 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%4]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 09:28:17 +0000
Message-ID: <42ec9559-3445-4712-bfd4-1319b4d4ce2d@intel.com>
Date: Fri, 8 May 2026 17:36:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] intel_iommu: fix guest-triggerable abort on
 oversized MMIO access
To: Junjie Cao <junjie.cao@intel.com>, <qemu-devel@nongnu.org>
CC: <zhenzhong.duan@intel.com>, <philmd@linaro.org>, <mst@redhat.com>,
 <jasowang@redhat.com>, <clement.mathieu--drif@bull.com>,
 <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <farosas@suse.de>, <lvivier@redhat.com>
References: <DS4PPF93A1BBECDC498B677FE8B259BCEAD92352@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <20260506031942.251335-2-junjie.cao@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260506031942.251335-2-junjie.cao@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0009.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::8)
 To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|PH7PR11MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f779d9f-6c30-452a-cbc8-08deace422ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|42112799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qdZj5RYCgZ+8RckT+u15iV/VKoQBW4lYkviAaorlyYyP2wkGtZ6z+hs894pqxAPRs3dSRCYqx+5Pq6ESTsFe7gJghEw561F0tMitzLJbVLXID7kUZ0yqdYzP/bmH7Fn7fso/DbOOoGOhjGKcnj3VtJEhrA+GNpXINOn5Y0GIaI7e3DHfOtPlNiox3a1c1BhmEpVTiZcGItajE4Fl3Bo0hFUMzKb84K3LBsZcmlTGN7lLugFpzhurgpEPtYN5xpyK7CN4YeO1TQ/P2Ia0ZZqemR1zcJ+d1pEhpQxJMAEZiqZGUHQrHat5z5EImGt5KcACd4BsS+Wdf0L7ZwDuGHVW6kc7f9mXx2oSr+pxx33c1HJdfA0qdyu4d4E/nftGZODih4freOHdfiyyH96VqdRpbhw8LY+cjhesFtMIVyfFGlOw7qeRRnrT0fiizZcyqsDy6dQvwR6f4b/jhpZawpGhp4THz/+/Nz0Kmkwwcx5MQPXTrnXAADREOhzb8BxqEDDnZWeP3SdX1zBokDBKbYQR1qy3wKQpmKuy/8OPAowt7L76iIxfDQKS7SvjrAzzFxQ6gWPhue8VSlfdIgPB8Muz9ehB6cbgG9epB5Po/7R4Ml9XCFgBt9UPlL0xWRAX2GOVAlwmCc4UVloMTGQ/A8o0tWnrg6Aq6ziARU/RlX6LN3fSRBiAZAGKwUXloI88cTkc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(42112799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRMVHVhRmFjSXBMV3piU1IyczdadGdLMGYvWHhwZU5wQXFQZEZiU3VJYmp4?=
 =?utf-8?B?K2xhM3EwS3JBM0pTR1pWTlg2SVkxOCtzNno5S0RSUDBEcjFsbjNJZlhYNHhP?=
 =?utf-8?B?KzVuN2RUcjBsak1GR0pDNXBlQ1p4cnhVTDIrVFJKVDJQdkJrNGJZcHRFQkpB?=
 =?utf-8?B?TXRnUElGRWhpbTA3T2xzbkxBUWZiVVhoeHg1dEFQa0NHQTl6SXZnS0hTdkkv?=
 =?utf-8?B?VWFxVCtOcExsNzNQVHIzWlJ1WDNMdG92TUFVYk9YN0VjVzZrcU9FSkptV1Nm?=
 =?utf-8?B?QWprZDBZbWE1S1RKTDRIOEFqQTdsUGpqeEJIUE1OOER6eVVTT3FMcThJWU9k?=
 =?utf-8?B?SUlDQzV4UmVaNXpxUnVNbDZrR09HNytoaktiZDdHN1ZaLzk3dnNhSG5SckFR?=
 =?utf-8?B?UElzRjN2RVc3NlZhMnRiSUJZT3ZIUVJVekVlY3J3WmRjMzlERVY4cHp5eG1I?=
 =?utf-8?B?NjUrQ0hPUGlwZHE2UFNFWU14VVdRNjBtQTJTZUtndm5tNGFWUHM0b3dtQWEv?=
 =?utf-8?B?Wmk4a2E5bDVjekFwT2hnak1TYlBYZUZEaklYTnI4cUtYUDNJaTRDdTlhSzdp?=
 =?utf-8?B?VE9pRVdxQTBOK3RhcWRQdmRHdVlVaU1yeEQ4YUZSWXhrWFNBY1BIemRjS2lX?=
 =?utf-8?B?bmJHTk1JdEVQdEhUcTI3L0FrcmRJaVArNWRJaE11eHk2M2xZWURObDFEeStq?=
 =?utf-8?B?MTJZb1MwYmdEZks2QVd1YVVqbFFJaFhrTlRlNXJDTEpwemxlcDZzc3RQOG1H?=
 =?utf-8?B?RVV1TGgwN3VrR3VFVDJJVTRHY20yS210RmRTVEtGaEQrbTFuWm9GeU45cHFS?=
 =?utf-8?B?bFlJZ1E5bkdQNWdMYUNtYmI3NnozQ2lmNHpHNjB0czdwZlFNWnA3cGFiZlVu?=
 =?utf-8?B?M1cyNzVGanRlbU1xUkxWRThYaTJTbFpITUxTbWttclVsUGJYR3ZsbmM5K1lC?=
 =?utf-8?B?aDFXVFdrRWZnN0luaFVHeXBob0RRZ2UweTVyOXhUaXpXWFh0MzhhbGF4bnNi?=
 =?utf-8?B?a1dBSmEwenNNWnlxOFdBQ0psU2FJMlJXN1BWYzV1ZXhVK1hIUUlPNmY0endK?=
 =?utf-8?B?WFhJTDU4NTVjTk5WTDZiNUtnck9MamszRDhJQ0hNNlBhL2grdFVOeXhSUFZX?=
 =?utf-8?B?U2EzcE9ybHFqeEZ5QlI4WThpQWdhWDlValhqSTNUYnQwWU43ZnIwTlA0bE04?=
 =?utf-8?B?eXZvM2pZbUNmQkFISyt6N01jOFpDYUhTanFqMGhNN0g4VDU0NDl4N2lQU2Ew?=
 =?utf-8?B?VEVqdTVvSG9aYXJ2SXlpK3pyblNldHk1WXI4b1pjSkhENkwyY2pjUjVHLzVP?=
 =?utf-8?B?U0JJbm1Uc1BDUG5tazRhSGZiczBpcWlScS9EV3N4YXZML3RQWGUwdzAvYy9v?=
 =?utf-8?B?UC9rZHNKYURsa004T2JyeWNPeW5qeXRiTkZ3c0VLRDNSWStoRTh6dTFZcDF5?=
 =?utf-8?B?emJVYmVUbmVOY2RaOHJJUkcwUHp0N0syaUJMV3JKSmJlcEVkcndLelVaLzlN?=
 =?utf-8?B?L1psWmlhdVJhamNDM2lCRmNPaXZHTTY3OUQ3YmFhRGVDUnROd29vNnRiZk1w?=
 =?utf-8?B?RFkwaXJ0ekxmVkJIMU1XbUZOT0lrTkladi9BZzYrbVZVbUdtc2lQVGRZL0Rv?=
 =?utf-8?B?K2h5ODM1R1Z2dnhtczAvVFRQSk9ZNzBxV0lWbjc5b002QS9BeEFES2JtVEo3?=
 =?utf-8?B?ajNUcnJBQXVpZTVHTGdPNWU1VkNGaXBDYzZ2ODQrei9NLzB5Q1JRSkp0NDdY?=
 =?utf-8?B?eTU1dDhLV0xXSVpIYWFhdTFvRHR6cU8rRkV5WHlUQWhBQ2tTQ1NyRUpEbnUy?=
 =?utf-8?B?NnZPUWdtQ3hFcFRuVzF5bEljTExlb2MvWGhLa3dnbllGcktzaUprckhsN3lx?=
 =?utf-8?B?TzlEMThMcFRWb3VSU3JHUlh5QzVzb0w2RDJFUmhib0RVZ3ZqZS8wcXhPOG1W?=
 =?utf-8?B?MVlBYnd6V2FUUzRKR28vOFVhVWNHeDVtUnBUQjc2ZlQrMmozMlVFWnVTdjV0?=
 =?utf-8?B?aHN6a0l4TW5DaXVFVnR4bXZZdFprZVNPUUJEVElkNGJ2aFlWeEhnaXRCSnFo?=
 =?utf-8?B?Zkt1SmFnZ29rbG9TQzc0OXo0MHlWbmJVTjhFYlpJY1h1SSsxN0t3ak1ZL05Z?=
 =?utf-8?B?NDJidFB1bldPZE9pL0Z6LytwUEFoMnQrSDZSRjZaSkFTN3ZIdzVoSU1hai9L?=
 =?utf-8?B?dVZHdU5oRmp1SkhEWndsNXNRUit3K0NFZjFNMTV0OU9LeUxXT0RoS0pRMExZ?=
 =?utf-8?B?bVNtdXMxdFd0V0lJb0ZhUVhIYVhaaHlVRjY5UUM4MGNvVFN1WEdmV2xOSjlX?=
 =?utf-8?B?ZDQrYjhrTTZwNy9CUFQvajRncW93TGNyZkFBc1pvUWJtTDhrRk4rZz09?=
X-Exchange-RoutingPolicyChecked: oTc0sHXv8H7f4jcLP01As/d1BoCQR7CGLRHbsLiyyJoJV0Tf7Ijh5o9xoZRg3jsMdLlfhlBMJc8G68I3u1bKLh4J9twmt37oIWHmM90A7yB7qXmqhJFk8DtmsQPG1Xuo21vRym7fPFsavAwzbUkZusVK3k6DkI+1zuRsgILbdcdt8waBMej60ryWvSnyJYnh11MXn39X/GKUbOfEH+1bmi3822cM0RjqOshQ1tbkCZw2BW9KHUJPNiYWk2ImBZi1nUjOJDamJwE+F34F3XvBAN5JEsxKu5I1eDHaAa91KbhscxN3NQEkLa+2N+C7gG03y5iyHRjrAKkP38UvjA+gVg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f779d9f-6c30-452a-cbc8-08deace422ea
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:28:17.4305 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W9SKEmhcXML6R+DS9NXv7E2z6hq4/mD5V3x7DPGd/lyYoRUVS1K8npNt0bLs+u1SqXEhd5ysLzxWY5O2ypqrig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6700
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17; envelope-from=yi.l.liu@intel.com;
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

On 5/6/26 11:19, Junjie Cao wrote:
> An 8-byte guest access to a 32-bit-only VT-d register hit
> assert(size == 4) and aborted QEMU.  Remove all 25 asserts.
> 
> 21 sit at non-8-byte-aligned offsets and are rejected by
> memory_region_access_valid() before reaching the handler -- dead
> code, simply deleted.
> 
> The remaining 4 guard 8-byte-aligned 32-bit registers reachable
> by a well-formed 8-byte access (FECTL 0x38, IECTL 0xa0, IEADDR
> 0xa8, PECTL 0xe0). 

could you share how you identify the 4 registers among all the
registers. The offset of such registers are multiple of 8? is it? Just
curious why only 4 registers.

> Writes fall through to vtd_set_long(), which
> takes uint32_t and implicitly truncates, and log a guest error.
> Reads fall through to the default vtd_get_quad() -- equivalent
> to two 4-byte reads and therefore harmless, no warn needed.
> min_access_size stays 4, so all size-based branches on 64-bit
> register pairs are preserved.
> 
> Found by generic-fuzz (24 distinct crash seeds, all fixed).
> 
> Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   hw/i386/intel_iommu.c | 41 ++++++++++++++++-------------------------
>   1 file changed, 16 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index f395fa248c..0fb89332f9 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3713,7 +3713,6 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
>           break;
>   
>       case DMAR_RTADDR_REG_HI:
> -        assert(size == 4);
>           val = vtd_get_quad_raw(s, DMAR_RTADDR_REG) >> 32;
>           break;
>   
> @@ -3728,12 +3727,10 @@ static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
>           break;
>   
>       case DMAR_IQA_REG_HI:
> -        assert(size == 4);
>           val = s->iq >> 32;
>           break;
>   
>       case DMAR_PEUADDR_REG:
> -        assert(size == 4);
>           val = vtd_get_long_raw(s, DMAR_PEUADDR_REG);
>           break;
>   
> @@ -3779,7 +3776,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>           break;
>   
>       case DMAR_CCMD_REG_HI:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           vtd_handle_ccmd_write(s);
>           break;
> @@ -3795,13 +3791,11 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>           break;
>   
>       case DMAR_IOTLB_REG_HI:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           vtd_handle_iotlb_write(s);
>           break;
>   
>       case DMAR_PEUADDR_REG:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           break;
>   
> @@ -3815,27 +3809,27 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>           break;
>   
>       case DMAR_IVA_REG_HI:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           break;
>   
>       /* Fault Status Register, 32-bit */
>       case DMAR_FSTS_REG:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           vtd_handle_fsts_write(s);
>           break;
>   
>       /* Fault Event Control Register, 32-bit */
>       case DMAR_FECTL_REG:
> -        assert(size == 4);
> +        if (size != 4) {
> +            error_report_once("%s: invalid %u-byte access to 32-bit reg "
> +                              "addr=0x%" PRIx64, __func__, size, addr);
> +        }

Since such writes are harmless, I don't think it is really helpful to
have this error log. Instead, we should have a comment here to avoid
somebody break it in future.

>           vtd_set_long(s, addr, val);
>           vtd_handle_fectl_write(s);
>           break;
>   
>       /* Fault Event Data Register, 32-bit */
>       case DMAR_FEDATA_REG:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           break;
>   
> @@ -3854,13 +3848,11 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>   
>       /* Fault Event Upper Address Register, 32-bit */
>       case DMAR_FEUADDR_REG:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           break;
>   
>       /* Protected Memory Enable Register, 32-bit */
>       case DMAR_PMEN_REG:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           break;
>   
> @@ -3874,7 +3866,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>           break;
>   
>       case DMAR_RTADDR_REG_HI:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           break;
>   
> @@ -3889,7 +3880,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>           break;
>   
>       case DMAR_IQT_REG_HI:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           /* 19:63 of IQT_REG is RsvdZ, do nothing here */
>           break;
> @@ -3905,39 +3895,41 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>           break;
>   
>       case DMAR_IQA_REG_HI:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           break;
>   
>       /* Invalidation Completion Status Register, 32-bit */
>       case DMAR_ICS_REG:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           vtd_handle_ics_write(s);
>           break;
>   
>       /* Invalidation Event Control Register, 32-bit */
>       case DMAR_IECTL_REG:
> -        assert(size == 4);
> +        if (size != 4) {
> +            error_report_once("%s: invalid %u-byte access to 32-bit reg "
> +                              "addr=0x%" PRIx64, __func__, size, addr);
> +        }
>           vtd_set_long(s, addr, val);
>           vtd_handle_iectl_write(s);
>           break;
>   
>       /* Invalidation Event Data Register, 32-bit */
>       case DMAR_IEDATA_REG:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           break;
>   
>       /* Invalidation Event Address Register, 32-bit */
>       case DMAR_IEADDR_REG:
> -        assert(size == 4);
> +        if (size != 4) {
> +            error_report_once("%s: invalid %u-byte access to 32-bit reg "
> +                              "addr=0x%" PRIx64, __func__, size, addr);
> +        }
>           vtd_set_long(s, addr, val);
>           break;
>   
>       /* Invalidation Event Upper Address Register, 32-bit */
>       case DMAR_IEUADDR_REG:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           break;
>   
> @@ -3951,7 +3943,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>           break;
>   
>       case DMAR_FRCD_REG_0_1:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           break;
>   
> @@ -3966,7 +3957,6 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>           break;
>   
>       case DMAR_FRCD_REG_0_3:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           /* May clear bit 127 (Fault), update PPF */
>           vtd_update_fsts_ppf(s);
> @@ -3981,18 +3971,19 @@ static void vtd_mem_write(void *opaque, hwaddr addr,
>           break;
>   
>       case DMAR_IRTA_REG_HI:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           break;
>   
>       case DMAR_PRS_REG:
> -        assert(size == 4);
>           vtd_set_long(s, addr, val);
>           vtd_handle_prs_write(s);
>           break;
>   
>       case DMAR_PECTL_REG:
> -        assert(size == 4);
> +        if (size != 4) {
> +            error_report_once("%s: invalid %u-byte access to 32-bit reg "
> +                              "addr=0x%" PRIx64, __func__, size, addr);
> +        }
>           vtd_set_long(s, addr, val);
>           vtd_handle_pectl_write(s);
>           break;


