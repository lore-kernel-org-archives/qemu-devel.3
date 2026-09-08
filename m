Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC9EC79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 02:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3lIJ-0006M2-1O; Mon, 07 Sep 2026 22:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1x3lIH-0006LS-DJ
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 22:10:41 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chang.seok.bae@intel.com>)
 id 1x3lIF-0002eL-O3
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 22:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788833440; x=1820369440;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=lw8MSfNl97cT9HbVSF4C1j3iY4lN2p/5EvRBKb4Q3HM=;
 b=iPf2TJDXTLD27j17SF87caAvzHR694tbW3NE62yu++S0/8VkL5Zfvug2
 TWWgOoIaFOM2BfRuFpvEuA1yjhkUECELO8ECFcIVfU1FLfj5hDciuxUj1
 U6cC5dh9mHCXCeun6WvEV/PufcDgsYn6OueKen7wMLIWjyT3FaClJ50gG
 xRbpA/tTRhqgm44g8U3F7BnZlBcsDEo4+GRDPFnKzIeBea1fYXMw+ZsvC
 szw1pIOfVXMZXVs/wGa98XorDCWMF5CTnM7d72NP47XLuoKnELR3Apmsb
 hTbhhLX1hx6iwQ2Hp5EW40sUxYdvoovt8Lzr3v+6joWjSb25e2dJRs71P w==;
X-CSE-ConnectionGUID: 7sDlIOQvRjqH0iGv5uSarA==
X-CSE-MsgGUID: v+hFDeiWRaCeDbTAWkE4Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89433168"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="89433168"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 19:10:38 -0700
X-CSE-ConnectionGUID: zugfTm1BQAWD3T9B8+aLLQ==
X-CSE-MsgGUID: TIxAhCVCRY6pWukOk/K71A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="267166788"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 19:10:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 19:10:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 19:10:36 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 19:10:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+JuZGUnFCSIth/4wSoaKKk2zlvRcYHSGvle/C5KBVPNQA+OOBMO7cfKi1uBgABe56waKr54YCGPNnoypcyZtw4JCktvkFlDv/fEIaz6w/fxMcwoQMcbKeBY5b4kh665LgRV9OXw5O2Nzpi4ZNgeLJWfDcZpeUH8RU8DhRJ7gGIfACewdf8uwrzSNvJRajEb9VHP3ExFNpRuAPbicRpuW8/BczVIId7I+SuTslPtvOEWfhEodOrZw/RcTq8W+8Auj4s+NGnbMNr3WpG6tgl1tttmPGVXzTr69l0gCOxLypmhVkCr6Vl4c/736ikjKABbMgSHfc8oTLWXXwQStzNMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH0Pr9eUjfZJdkQzoArpdzut9G3tikwDOzX2k6ar3Ws=;
 b=KUa6Kk4j6aT2b90AdJ5G51/cnFERbqzW2zevDpLZhcr52jlTpRYQ02E7N1JUhsvVd/18OWsvmM8+xcPQ2Is8nTrk0J8eNUaFAWD7hdrR+x5FY+UTbshzDmFs1ch0gcQiMN6zzW9LuE6yq4t0n9H4HSP3a3FfaHFcDpsvhMGQuvb7FAMUrbEyDtpz8Hm8JTP3YKrmMKBk5T5BfoS+FMbnkjMEIdCfNrNNfifR1/bCU7EcqYj6RiW5/qur9jq4qTTGfiY426uTZ8QRcTH8m5mrGHaUEka/YHzZMJF0DV9RBm76c6pn8ULwWIYbTopqHMO3Z2WHP2d6T5fNDkEYyGDNTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 02:10:33 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 02:10:33 +0000
Message-ID: <944bc1ac-3614-4f32-8489-e75779da9944@intel.com>
Date: Mon, 7 Sep 2026 19:10:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/20] target/i386/tcg: decode REX2 prefix
To: Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
References: <20260825122921.431739-1-pbonzini@redhat.com>
 <20260825122921.431739-10-pbonzini@redhat.com>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260825122921.431739-10-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::18) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SN7PR11MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a28e9a9-e291-4135-bc2e-08df0d4e5d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 3KOUXJPO3XVbPEt0jqyW3Lj5LcaXWQvJi0fPIQktT7AiKzCthlYZPqVNM777kfTjGLdlEvmrT34XJz2mtSmj3yZ4NCk+2rkFK31h/mOmdq1JX6Jn9yqd6m8tRSWRf06QB8BVGYtqYzz+okFKwzqdRPcLDlmaQ066vJ2/CogqTZSjsSgLuifVInB50yht7fRHZB3v1RnO3WtA+dhb1AFzafGWTFNw/J/JDVIH9hMFojwQlayZer5Ea7FuCfP9QPUlotZPryFkLMxuEgWWOQCq1KQRybYAMBqf9S8SJN8v4i9wFD2a65/ZBGWQl/TVH+AuMgfUL6US/pRMsQMTqpYmqxOoTILENsX42HAJ9lBt8UVBAYhDVLBixMSMUAU5JUxr00fGtkXKsNU6a8LUFFsFcOv6cEUz9j6/YJpT1o8cOoCimptovsd4LL9+R94CyRnMEW7D+ljc//Zq3g6xA9EjJtIVS0OYgVbKHpuoZE3Pzf/E4xRlVQ0x8SW7mn2XL9otwBN0OsNmjn3gsNe6RKsmLlMCCSiefv2aAiJIhIspQpnNd8I5ArmPXACeLt/jDS8DUoF/Sg+eTBnJzHCgHHsz3P5RS7o0ehjw+N9FRyvWPAHekr5z8qJFbyFnQb0V1zzRW+bfcExq0v8wPmMwawd/U0xzj08VRWZdIU3MfVPMHkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7925.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGN3MnQxdXNCd2tSTitVdkR6cWVvQWRNZmVubml1L2Z6cEZnazBJclhsMlZ1?=
 =?utf-8?B?ZVdWM2lmWEljS3kybG1WSnllMi82NCtWV3pQMGYyWlNWWE8xUjB4Ymw4TUhV?=
 =?utf-8?B?N0dLcnhBc055aVQvUTdaeGNVZUd6OEM2ZE5vZ0tIcDZlVUptR2Uxb2t4TnAw?=
 =?utf-8?B?UktrS2taNlBVaFRnUDlycnRxaTRxUk5PM2YwV0R1cGF4bTYyZGU2ejJoUGV1?=
 =?utf-8?B?ODhwUEQ5d0M2ellBRzFIS0JMelRVV2FQY3JvUU9ZMGJ6N3k5ZzJWbXhkd002?=
 =?utf-8?B?YjQ0Slh0eG9scWtHNk5lSW01VzJDY1k0UlF2cHRONEpVZ3dHSXhGVUJrOW1W?=
 =?utf-8?B?UmRGMGRzZkcyY1ZNRjlHdnMzNjZCcjJxaG1qTmREZytCVkJmNkQ3UHl5eHEx?=
 =?utf-8?B?b0RDaDRVeHhRbUluTkx1cFFmeHc3cHVVbGdHdktpSmRNTjdxSEpUd1MrOWdX?=
 =?utf-8?B?dnlEOVZiSmQxOENzRlVEUTU4WERpN2I0MDgwSDdPSldWNUpYNk9Gb1gxRUtz?=
 =?utf-8?B?OGdHL2NsZU41aHBlZ1RDQmVpMnZFamJTRUcrbERObWp2L1dzVDg1R3FLdytR?=
 =?utf-8?B?cTA4YXFkOEtXVzVSc3hJRldiYUdtelgxMVFTektNR3hMUWpnN3oydXV6Q2VY?=
 =?utf-8?B?eHhoNktDZUJ0L0N1MVVKNzRqTlNhZ2I1OGd1V05xcElNaWFIS0haVUcyb0JK?=
 =?utf-8?B?cUk2M0hjOEVabmdrRDhqWStMRHUxTWswTkUzaVVuYTJpcTJwKzFsbDlKU3Ru?=
 =?utf-8?B?Qng3bFhvN0dnckk1S0pCV1dodk1xV0d1bUl3RFpqQmZaenVhY1Y2ckJCT2VL?=
 =?utf-8?B?dG1SRXZzU2xaZHpnM1c5SnhtMEdCcUF1WUFZZWJaNTBEZTBhUXlXV3R5NW9J?=
 =?utf-8?B?MlV3QW5yRm9yUE55aGhlc3Y2UnU0a29sOEhGNm5vVUxQa0FJRnRHS3JzZnFW?=
 =?utf-8?B?VnliT0xPeHJ6QnRBNndtbENkUGFUNnVWT0pudnhQckw4MjRqalFwTzhSWHBG?=
 =?utf-8?B?Zlo3SnRzNFA2cy9VVTdiVGxudjJmY1pXZ0NGbmFKN2thUTJlazdCbFNobWo5?=
 =?utf-8?B?R0N1T0lmam51blJ2QmNUWVlYWUdvMW13N2NOaGlmbTVtYm84Y1RFbzcyejNI?=
 =?utf-8?B?L0R0NHlOR1M3Ym5udEcrNXRQOWhFRHpvZjd4cFVuRGVIMTdXOGRzNFBNTzlM?=
 =?utf-8?B?Nnc2RU1PRHAwUmRGYy9WYS9KRzJSaG1HZjNXV045RERENTJyNks0ZHBuTllH?=
 =?utf-8?B?cmtoVFBocUY4N25FUHpjM0JvWGQ4NHE3a2FYRGdoUHBBNXJXZDc0di9mTEVy?=
 =?utf-8?B?dm5XNDVOaWxrT2RuWGdYQ2FqcHlNd1RsbE1TcURBODl2aFZPVmd3U3k4ZUtG?=
 =?utf-8?B?U2pUcUViM2QxMjdSYmFsdElYNVhjamhJdkh5eDRpcVZOdmltbmRseXNOcjNN?=
 =?utf-8?B?K2lWQTNpZUhRQm9USU5kdDVDRTdOT1liMlpsU1J5QkFnOXg1ckQxRldyVnZj?=
 =?utf-8?B?eEQ5M2xvVmdBQWkwQ3VlMEczMGtPY3phQmdEWVcyenZOU3ZHQzk0NEFpd0Z4?=
 =?utf-8?B?ZklZa1RYRm56ZU10aWl5OUd5cEVKenFWVElaVjhNWWo1MUcrUmpUUTNaanJG?=
 =?utf-8?B?by8zdCtvQmJ6cjZSNzZvL2NPeElUVzM3TVVpMmo1cGxhaG9vNVpnK1JnZDFF?=
 =?utf-8?B?UXZRRWZLd2FCdkhlekMyczlKQ0NwU1pIUHh3c3JxbktMYzdGbUliNDF3OWxm?=
 =?utf-8?B?c3JmUkJFZmVOcDdka1IrU1VjVEFPcG9SdVRkQ09SNGVWbUIrY2d5M0txWDBI?=
 =?utf-8?B?Z0VVWjZaL0xYdHZHWHR3Tm16eWI4ejc4cSt6USt6dE9vMGQydlFkUjFMWVUz?=
 =?utf-8?B?ZVF4cVUyRGE4VU04UHhTVlRZVm03WVpPNit0dTZmQWRhVjBjNjkrZy9aQW5X?=
 =?utf-8?B?NFAxbmZLNmFQVlUySXRJMHc5M1BvYVdXeUx5UmtiNEVUT3YxeXAvSjJjeGov?=
 =?utf-8?B?QlVOcnlCTElCcnlUUGdab2poK3ZaLzBMVjM5YWpHMlhTWUlLb2hSL3NnUk1T?=
 =?utf-8?B?YzRlRmJ0cGRtN1VpRGVTQzYxS3NCVzI5RGFFZlVybFhzZW42bWxzNEYvMGww?=
 =?utf-8?B?LzVKaHQrbmdnR0xoUHhpdlVKZ2ZZVXh6ZzNIU1ZhTS85VytNMXFPdktlTVli?=
 =?utf-8?B?aHZNRllRMkRNQTQxaXcxZ0pwaTBWSCtqMHZoK0JpWnJLcTFveWFrb3FUVnVD?=
 =?utf-8?B?K205S0FnK2ZqUXN0UmR5THlhVGNmNkgxc3RyYnZOc3k5eUxnaVAxV3FoOWNL?=
 =?utf-8?B?UVpSODlTcHMwcEFLK2lxQlgyU1AxWVpoZjRWN0I3SEl0NHF0dUNWQT09?=
X-Exchange-RoutingPolicyChecked: grb+92/wy2zzMvWJ6EE8+TIwGiCGZ583zRC9tP7k0TIb6MxBcvOinHhAyL8MaYcSfj/DFnIF57yY9dfnQSdnv668LxOnLjLQSuneJTUZxofpJKdxgTBLkyivj9Tn72lKsVoHJMos+T8sEQkLBDVhKSUU4JUQ+UFg7nAGEX0javqcCiLpWzR2OTFHvHxksxMYiIl/O7yaEZQftrpl4+x31WlN+Dyo5kmyIsFAmOs53G+83bnNKlopgOkf7cpY0UMfNPi9ztIFxQERYV/p/I7hyJMb3h4uTwAypvv+tHtj+vrqQTyaPt4I6423gvXTiSpsuxBCO/urFbOc/r4g3abLcw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a28e9a9-e291-4135-bc2e-08df0d4e5d31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 02:10:33.6798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjC6toQv3KpL3A18NShKC0gMdiVKZlX69vULXq6G9Yh9OpLtxLywxRsFtj1XH34tbm65z4n0yDtNPD1LltqILfBLtTe2x6s7cKIG3YkkiHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6678
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
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
> The REX2 prefix has two main complications: it does not apply
> to vector registers, and it disables or mutates some opcodes
> (thus needing separate decoding functions instead of decode_root
> and decode_0F).  Otherwise, all it does is extend s->rex_r,
> s->rex_w and s->rex_b to two bits.
> 
> Since REX2 provides the ability to access r16...r31, extend
> cpu_regs[] to CPU_NB_EREGS elements.

The code looks like it matches the definition quite well to me:

   Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>

> +/* MASK must have two bits set.  Bring the lowest just below the highest;
> + * for example if MASK == 0x11, bit 1 of value is moved to bit 3.  Clear
> + * every other bit in VALUE.
> + *
> + * Generally mask will be a constant, so that all of the first three
> + * lines disappear.  Likewise, if the bits in mask are already adjacent
> + * this becomes just "return value & mask".
> + */
> +static inline uint8_t collapse_two_bits(uint8_t value, uint8_t mask)
> +{
> +    uint8_t high = mask & (mask - 1);
> +    uint8_t low = mask & ~high;
> +    uint8_t tweak = (high >> 1) - low;
> +
> +    value &= mask;
> +    return (value + tweak) & (mask + tweak);
> +}
This logic looks quite interesting. The following changes look pretty 
much usage sites -- for the possible combinations for the input. Then 
just quickly ran the calculation. The math seems to work as expected:

   value,  mask,   return

   0x0     0x11    0x0
   0x1     0x11    0x8
   0x10    0x11    0x10
   0x11    0x11    0x18

   0x0     0x22    0x0
   0x2     0x22    0x10
   0x20    0x22    0x20
   0x22    0x22    0x30

   0x0     0x44    0x0
   0x4     0x44    0x20
   0x40    0x44    0x40
   0x44    0x44    0x60

Alternatively, while with more lines,

enum rex {
         REX_B,
         REX_X,
         REX_R
};

static inline uint8_t get_reg_bits(uint8_t value, enum rex rex)
{
         bool bit4 = false, bit3 = false;
         uint8_t bits = 0;

         switch (rex) {
         case REX_B:
                 bit4 = 0x10 & value;
                 bit3 = 0x01 & value;
                 break;
         case REX_X:
                 bit4 = 0x20 & value;
                 bit3 = 0x02 & value;
                 break;
         case REX_R:
                 bit4 = 0x40 & value;
                 bit3 = 0x04 & value;
                 break;
         default:
         }

         bits += bit4 ? 0x10 : 0;
         bits += bit3 ? 0x08 : 0;
         return bits;
}

...later
         s->rex_b = get_reg_bits(rex2, REX_B);
         s->rex_x = get_reg_bits(rex2, REX_X);
         s->rex_r = get_reg_bits(rex2, REX_R);

