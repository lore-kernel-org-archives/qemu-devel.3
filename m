Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19419D1119D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 03:02:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7nLM-00016A-2x; Sun, 03 Nov 2024 22:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7nL5-00015O-A9
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 22:01:16 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7nKz-00029V-2V
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 22:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730689265; x=1762225265;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5FRlfY8C2/S8BW/xlC2qEIznrQjkD7nixFqCWErW/EA=;
 b=ZqflyYJuruYo7m2vpZ7XzcOWqHqVwCH0gDOEs/KsKYebPXJ/WtkxnAas
 ntCRxHgQ63g3zAb6D1dZyWGJ890sSbnPK7oKShfitXA11T0MrMQaqZcEK
 FC7OV7jRgJ73I7MTPQT4SH3Pv4A6cMzc3yJagd0Qpbxq0JxHMcyh2f5to
 T/wU9QzMlE19mlpVnjtV5QVVfIAzlnO4m/MHiIFNjvMj9ftDU4NgHooMD
 VFbhzuIk3vaTolipyrNtT14AV/eLfsgeoPTDcw+sbTbXZhiu3E9EZAIe5
 dPPypMphsYNuO4B+/3Jw+5QtmcTsYzI8CGuhQGX0sYuEEyRHuWp4WkJjy w==;
X-CSE-ConnectionGUID: OQdEiTUuRqGDZs1Z6FIEUQ==
X-CSE-MsgGUID: Hh/XmtoORR+mk/uxmdGQjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30319930"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30319930"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 19:01:01 -0800
X-CSE-ConnectionGUID: lZDcQH2cTIiNrMobN0bDsw==
X-CSE-MsgGUID: IkbqWQW5Q3C1VRcHDXYaCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="83402087"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 19:00:57 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 19:00:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 19:00:52 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 19:00:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UvW2AwITVgHKR8BnYaADtkjvAAnVy/lFTCrr8LEfmojKmPrLUi5JZ3pgevEOmM5V75EfOgix1wKzIXHlJ65zx04sKOa4J7/H8IDRTGGsWnW1qKrnzrkHGMgTLl1FHqVFEr9aTbNHzMOVHjXKhKXGUKbH/aaKHSpMw0n6buE78ak6O5MaTGy7B0ZeVUIbpy/gNcRMRUCEIo9Jm1P7deTuNCZ1tAydTBZaXM/mkaIlEyZSDhqt1tCG1gevWqmqyIpLX9a5HzDvQ5gvJgBxWifwBtVNQU2yJ3cWxZPFyP4Oe3aklVwtmCaHLZpafqjH1qAhMcBlvCZnwW2FOdN13cK64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDbxFfq/dDGl3gzDxYHyY0++V41pQVJMg8EaF+qSNiM=;
 b=unMxk6IvVGtszAJ/pdjTbgmOTb7z7hPQDSX8T1xpIDIIC3344yq/TRikbqL0LbOnSuVUfikcsZK61HsD70ZerLhY6anFStcz5CAU2RPDbXosiuIrjgLvZa++zryLrrtJqtHfGeCX1pPnSz0+WqTepVGTywI76I/cBFURb7ut16SBV7MgTN2DZ4dq8qd24fxRquJu3zT3+JbI57GOezsHPw2/cST3fC/ztQoMmPUuPjfJt1NWqRv3Ykm5ioQ98nPMz9vx+LLUmD9vGNlMaoE1PmALGyEa/0oP15FzW9nmV6rbgZ9I8TgfBYBrghOM6iZkczRb1yi4H0vNwOcRtBew9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 03:00:45 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 03:00:45 +0000
Message-ID: <2d2c2515-6a74-4e81-8ab5-0390aa59f6dd@intel.com>
Date: Mon, 4 Nov 2024 11:05:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/17] intel_iommu: piotlb invalidation should notify
 unmap
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-14-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240930092631.2997543-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0045.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::14)
 To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 608ecb01-ac2c-4c69-a17b-08dcfc7ce037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0dmTzdVMzY3OHZweGJyanpIVk1FNlVrNUZDZk9kK2MyRkdTTFhjNERzSUta?=
 =?utf-8?B?UXp4d3JpWktSSTIrV3E5UHlYclJZYUduQTRtZHUzSGYweUdjY04zSElTbDAv?=
 =?utf-8?B?M0h0T1dUMG5DbnFiT3d3dVhLeDE4MEErc3pIWHovRXNpa2hzL3JZUU1Cdnpo?=
 =?utf-8?B?NTZMb2tpNWt6MU5sN1UwT3ZwN0FKdnRrTExqS2JJKzEyUHJKK0xwWGpOU3V5?=
 =?utf-8?B?WmNUWHVLbTY4RCtWSElLM0lzWEtyMTNJZVNPT1FTNXMwYnlFRGU5eSt3OTRq?=
 =?utf-8?B?VnAxUS9JeTNQTkxmNWZJSG5CK0VQWXlDNWY1NEt5dG54Mmh5QUZsUGJVTi9p?=
 =?utf-8?B?UU4vT0Q1REI2a3QvODNHYWpuMXVKVVlIVXlBVXpVbnoxcS9NMjMxSmRDN1FX?=
 =?utf-8?B?VmdqMWNlSExDQjRRSVZ1cFVPb0JhczJpWVFYWkZSSHozZDlqRW8zNVRMU0VF?=
 =?utf-8?B?d2RtN2QxdE5UVTVIVjhtNG8rVjVwNTd1QTU4amdFYUpCc1M4N3NNYUpBaVBm?=
 =?utf-8?B?VXB3dlk1TUJLanR6SU5BdzRnMlZhUUZJM2tPVWFqd2NLcm82S3ZUeTJXZ0Ja?=
 =?utf-8?B?clBHMWNWVkFSUzlrY2xvaWpEcHczZDZZMWUzRklTekVFUTFVWnFXUTRHa0Y3?=
 =?utf-8?B?cVpSSnJJUG9TUzFpSGVwYkxjRkx6Z3ZDcG5uY2VoVDZpWXdrZW1vN2hYMDdJ?=
 =?utf-8?B?NC9TTGgzRHY4cWxRSkZMZ2lhUjk1QiszeHNITk1mWWtUZDYxV2l5V1VSWjRs?=
 =?utf-8?B?L0lnOWcxOStZYUhyNW5NZUNuaUdOOE5vZlA1M2VDVFlQcFU4SVFCNEFsOTls?=
 =?utf-8?B?bTlIRFFjYlhRanR4VDR4WXB4WG45RDJLeXZvMmpYd0RwVUNHeGlZOWIrTG04?=
 =?utf-8?B?NXg2cHZYcWJObUxJMjNUT3hCZXJhVGRITGlEYWpnc1RNVlk2b056REZZbG83?=
 =?utf-8?B?S0M4ZlA3czdtUGlYRG9HbHN4Vlkxdm9VZ0xzd1Y1RE1zQVc1NytRczk5S2Jz?=
 =?utf-8?B?dWlraVh3eE5JbXNtRitZTGl1NVpHcDJOa2NySjlpOHROTGNwOStBMjNseWNP?=
 =?utf-8?B?L2pxSzFPeW9xUzVrRGlNYzNsa0U4M2FCSGtVRjlYVkdhM2t1bm4yUkUvajkz?=
 =?utf-8?B?bE1WenFWVnczcmNYdGhHSEdRcjZJZ0IzRjZPR2M1bWlmZUFWeFRpRUlNZC8x?=
 =?utf-8?B?ZUJCTzQzeSsxU0k0WnZ3V2JZd29pUXVtVEhoMy9qRFh5OUFQekUyUTltL2c5?=
 =?utf-8?B?Z1c3NWhWMHgwTG1XMHhRYStHNDBTaDdHdWR3aGREbXlkVmJ5bEtKeFhGUHJW?=
 =?utf-8?B?bjJhSTJleDNMVnlXb3FRL3Qyajd0VVhTdVY5dWlXS291VHRlc1o3MCtNMVhH?=
 =?utf-8?B?a2pQV0JjMVk3MDF1UzFHV2FxSCtHU0EzaCtaT1pUVGNDOC84eXpTTDM3Q05x?=
 =?utf-8?B?OXhGUjA4QmVwZ0dRbVBDanVxazJteXVSMUFXSitERnlYeW5hVTJnSFo2SmhB?=
 =?utf-8?B?Y3VFYzUwU0hJNGFnNUszVzN5N3o5SGUrVndsY25SN1VqZ1lNZ01VUFhQL3dF?=
 =?utf-8?B?eHRDMVAyNmRlUGlqWTJlQ3hibkdFYzFzVmlCT05kdG1BUXJJRXhBd2lNSUJx?=
 =?utf-8?B?WXZFT0lGbUVhaGpPRnUyZHJ0bmgrZVdqSUdUZEhrWCtqMGlCMzJNZXplMEww?=
 =?utf-8?B?S0lNenpTaG5jUWd2bnNlNTR4NHpmbG96Sk1oREtBNnZucjArR0pYMkdxK2w2?=
 =?utf-8?Q?nmwm+2djvG3pbIjisKg5bqrpMkKfLKOsKc0sjHI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHlmYytVNVpPMnA2eGM4eEljbHc1R2JLbTVqR1pHY2RpSTdBVFZKQ3lnaGxW?=
 =?utf-8?B?bUMxWU5lZEhya3BHbUcwM0RSdGF1bkEyZ0UyZ1F3RFFaRnBoQVBrMTM1cFl4?=
 =?utf-8?B?VW9odHp3bmhFdEFUOVlLRUxISGFlNGdrVDN6aTNRZ09mbGJwVEp6REFBemNs?=
 =?utf-8?B?dWNpaS84NTRRUGJ3RjBtTnJKd2VaOTJYSVM5UXVoMGpkRjB0QURWQWEwZ2kx?=
 =?utf-8?B?d2U1WHlWbjRMU0l0NlRmekRoVndnK1Nrd3ZmZ2hqTENwcS90WkFiWGt3WUp2?=
 =?utf-8?B?MkZmR21OTGJMRDdVcHFzMmkwbytqc1pBUThTNUhLTmx2ak4wZTl2QVJEWnBn?=
 =?utf-8?B?MmxOTGl5N3Azc1JTMFFkbnBlbGs5YXVDS0YvREgzeFE0SXg3Yzg0Z0laNXZC?=
 =?utf-8?B?ZGhBR1ZqOHRxWU9PZFNWeXQ1YVY1dHBOc0FlQkRJVHFNK29ITGQ5anNNSmFQ?=
 =?utf-8?B?WGp0R1paRXVRNkhITmFiZzdrMnBKVkI2OGdXcEZlK2JMNUtFOHM3cGkvMmZt?=
 =?utf-8?B?MHdtUmJKTmZOQkllN3hQckxGaHBrbnJ0bDdwa0NKMHYvTEpqeFZmS0t4NHVJ?=
 =?utf-8?B?cW1IRjExQlI4emlqNEFiV24yalBySDdBWmJIQUZsNWl0QWJkc1ZCTWhoY2xD?=
 =?utf-8?B?clUxS2tOanpWOGE4U1lvTC9KZUh4TmtabkJEeGwvd2dDYlpObTdKMVpPUGdJ?=
 =?utf-8?B?azdtM3JDU2RRenpJN0lwcnRaNkhFYkZwK2RGaXNMZUtqT2Y0OWJrWGpWN2Jm?=
 =?utf-8?B?VlpVbzlLMjBLeUlYL09nWHhOLzRLM0k2czBqaWN4a2JLUGNDNkFTQ3oxUm91?=
 =?utf-8?B?L3dROGg1azU5NzBqQWJVN0g5NFU5OW1mSGltSnY2ZTRpZStlWUwwbGhDZTln?=
 =?utf-8?B?QUdJcHdQVngwd3NGZ0JQQVJ4UTg3OWlCOWdHVW5rU3BoNnlEeU5mYVJIRm5I?=
 =?utf-8?B?QlMvMVUxek15cFY5NVVGUTBGYnZLNEtkUUppcjY3dWh4aC83MTV0UDhwSkFr?=
 =?utf-8?B?SzlpVGRvWXR3UmJ5ODVlV21QTkhWRHB6SER1QVBuaFZnVWpVcEtOUlJMR1VG?=
 =?utf-8?B?V0dPTjdHUThTR2VxbG85ZU1kUXVHdXU4ZlJISUxiZDM4QU14MnIzZGRkQ3Er?=
 =?utf-8?B?S2lHaVRsdm1neStzQUF5TVQ4c2JFYytwclN0dFBhTEtxSmpSaC9pN252YVVK?=
 =?utf-8?B?UVI5U1V5Tzl1QWtiZ3puZzlLY2owQnJFWE9PTTVLMElTcDNSa1RnREdCTmtp?=
 =?utf-8?B?S1o0U0lwQnlkakJpSkRNS1dUbjZsOGUvbUgydml6L0NoQm5MTjRzb0xXR2Mr?=
 =?utf-8?B?eHVNNVFLd0VhbE5kcWFOREFQcVJKeEtJd2huU0kxaWNONWljVThmZHZja0dW?=
 =?utf-8?B?ZXZtVEJGVDF0WllnbXhxVEtwVUZFRytreTQ4bG5PeFdoYTBMQ3RQWExpY0lD?=
 =?utf-8?B?LzlZZ0NFRFFFNHVBTUo0UUpIR2U2cElPeUdpMCtNNmZOWTN5ZnNTVExjWnlm?=
 =?utf-8?B?cmVzeGhLYmFHWThkK2dSNVBnRmNxeGtTdkI5Qm0xdDk1U2Uvdkd5eVVoUjAr?=
 =?utf-8?B?M1kyZkwzb05mTk9pVHhWQUg4aTMxZzlGNVluOW95U0k2OHBxZ1Z3eUJTNjNW?=
 =?utf-8?B?WWZKL0Q0Ky9IaXZ4dmNidUdtaUh5Z0crQWhiQzJHeHJSS1BScFNqb0JYMVFT?=
 =?utf-8?B?RVFVTG9oMis0MVRlRGo2R3M4ZWRRTVpKUFRxRDBONEtYTkR4MDdueitLVEs2?=
 =?utf-8?B?bUdObUxoTzRndUpUQlk2MkVCeGRHQ245eFF3M2UrbGcyOUFTakhkcnV1RWRR?=
 =?utf-8?B?K2d5a2VnMHRHaWs4ZkVldlZEQ1I0TGpmMkpnUmdPQmhzZ1dyc1g0TDh1L3M3?=
 =?utf-8?B?TjFzOUdtSW5RODhXQ0NHL29ZUXJSaXloV3hJWXJCdC92UVRsVzFWUTM3Wi9Z?=
 =?utf-8?B?bVcxWUN5dWp2V3RmR2FlWUIyaElZWGhCbUd4RUpmQ0grc3ZnS2RwdjVCaTEw?=
 =?utf-8?B?cjI1eEJmbGJkcERvcm1mWEFSald5UjJKWnNPdG5rU3liOVp3TDdNN2FQaE40?=
 =?utf-8?B?cWU4ZldBU3FXWkxMbzIwcmswNDBITFFFdEtUOVVYUkttSVBRUFY4VGQvSEJw?=
 =?utf-8?Q?TrPgZq9ezjngkA820QDGUhO65?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 608ecb01-ac2c-4c69-a17b-08dcfc7ce037
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 03:00:45.0723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IarNSrjfxvUlYUJYm5NQAo6u54pWwOgma0HAp5DXmt7aIJJYXI9hG3SWeSWV20D14Em7fCbr3g9YFBSeR4dB2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7529
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On 2024/9/30 17:26, Zhenzhong Duan wrote:
> This is used by some emulated devices which caches address
> translation result. When piotlb invalidation issued in guest,
> those caches should be refreshed.
> 
> For device that does not implement ATS capability or disable
> it but still caches the translation result, it is better to
> implement ATS cap or enable it if there is need to cache the
> translation result.

Is there a list of such devices? Though I don't object this patch,
but it may be helpful to list such devices. One day we may remove
this when the list becomes empty.

> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu.c | 35 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 5ea59167b3..91d7b1abfa 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2908,7 +2908,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>                   continue;
>               }
>   
> -            if (!s->scalable_modern) {
> +            if (!s->scalable_modern || !vtd_as_has_map_notifier(vtd_as)) {
>                   vtd_address_space_sync(vtd_as);
>               }
>           }
> @@ -2920,6 +2920,9 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>                                          bool ih)
>   {
>       VTDIOTLBPageInvInfo info;
> +    VTDAddressSpace *vtd_as;
> +    VTDContextEntry ce;
> +    hwaddr size = (1 << am) * VTD_PAGE_SIZE;
>   
>       info.domain_id = domain_id;
>       info.pasid = pasid;
> @@ -2930,6 +2933,36 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>       g_hash_table_foreach_remove(s->iotlb,
>                                   vtd_hash_remove_by_page_piotlb, &info);
>       vtd_iommu_unlock(s);
> +
> +    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> +        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> +                                      vtd_as->devfn, &ce) &&
> +            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> +            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
> +            IOMMUTLBEvent event;
> +
> +            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
> +                vtd_as->pasid != pasid) {
> +                continue;

not quite get the logic here. patch 4 has a similar logic.

> +            }
> +
> +            /*
> +             * Page-Selective-within-PASID PASID-based-IOTLB Invalidation
> +             * does not flush stage-2 entries. See spec section 6.5.2.4
> +             */
> +            if (!s->scalable_modern) {
> +                continue;
> +            }
> +
> +            event.type = IOMMU_NOTIFIER_UNMAP;
> +            event.entry.target_as = &address_space_memory;
> +            event.entry.iova = addr;
> +            event.entry.perm = IOMMU_NONE;
> +            event.entry.addr_mask = size - 1;
> +            event.entry.translated_addr = 0;
> +            memory_region_notify_iommu(&vtd_as->iommu, 0, event);
> +        }
> +    }
>   }
>   
>   static bool vtd_process_piotlb_desc(IntelIOMMUState *s,

-- 
Regards,
Yi Liu

