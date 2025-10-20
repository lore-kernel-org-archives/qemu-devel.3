Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6436CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 08:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAlI4-0003eL-Gt; Mon, 20 Oct 2025 04:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAlHk-0003dk-V7
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:30:33 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAlHi-0007wG-6N
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760949030; x=1792485030;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=StWjOg81IkF+G2CWRiUL+2ntKvPCrvBsDEjeNfIz/0E=;
 b=OnlcaAYrJEVs/2zGjvK0udE+iQOLOBkXMEbCfec5zyVVGuaPqaz1jNcR
 Ct4MrjM8let1YxfulYQuiVjZ8YxX6MjwzaPLnhf/hTGtYutNLMuNHawOF
 aw6mK6rXxMqsDqqvWkx6R7TKzRBVpii5LGaiLSUoCABsEaSEXgANnI+v6
 cl4Hw8e6pHkU7GY6TsOpY5uww84gZpvsf6579TyKqgT/kKckTg1Fek7A+
 22ry1W8AqR0pDFuSxQRPKpdgFFL8TEehjOOPmo3fO+2mbDjHg0fWj2Rq/
 6kBDYNR9YfaNBz0s+g5zMkbRvbeDSbuVzTp4D2FMlPouAzG1vegQj5L9a A==;
X-CSE-ConnectionGUID: QwG03eMDQvyHMK0BlFHekg==
X-CSE-MsgGUID: 5BdpABxqSIai/snLlCN0EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="85683875"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="85683875"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 01:30:27 -0700
X-CSE-ConnectionGUID: wLTCTWglR5uijbDDFXtHFw==
X-CSE-MsgGUID: 5CQZ2QbwSRm9YJ7FTt6ltg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="187690625"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 01:30:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 01:30:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 01:30:25 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.61) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 01:30:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1JMBUYenw3bsllKkFt58dz15zzrLkVEltB6yqZsGYkwonEfONKx4HW+xhMP40VhoKPrgpvKkyX92qoJm6QPLqlBHzEAs+iONLMWXs2gXKNCOxC7BkSYwyBTp8rgK0+5nLwe6yemIP46zl6/LtiKjVdobPUMyv+uw7cB7aEBg4aYUrP+8rbSmRX43SxCiN5Qv8goWS/AIbFEmywEIAIM4Omnt1FFO8XdZDhHF5j6+Iz2/pyS/Wq6FEjnwZmDZeCp4Prutd4I+V0z8p45TAQ1zqJTpEPv7eUYeiWgvzWo3lcRbXoXepRlaI075JMlPvs6yqg7Y9hIV3QDZ36Zg8+syQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwcNxPeB5VqM76fMRgyBWpK5I8xcR+C14qMRFJunSUM=;
 b=OhQi+mKd0CFeLB+RupvrL+OjkDooPGlMBF6QkXBj711A5ReIQO0QYqI2dGyBtdOIF123tqAG/wdTJZgjkOClApbmrSESa+5EWBLAEFSimfx3adO+u8Q17qYIXQN9JNNt8dMnwpNOBbD1iWsPtHQgGzY6NxSUdrCv0s93XHr62lRjkggyc0erxvXinpL8c8eCGBulcOp5k5wjLccy+72Oz1p/GjN7AFlSZSxMrPitJV7XWqWz1rAzvnYimW16y7tdBgEFAcK0jUkQAu2v+iErPcU2lLjgs0AD2W3c58lD7zn27eixLu82zt4dYO+LMa3hTLez3CLcKyx9BkH860yt4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by DM3PPFF3DEC9799.namprd11.prod.outlook.com (2603:10b6:f:fc00::f61)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 08:30:24 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 08:30:24 +0000
Message-ID: <6f1ca5b3-8993-42ae-95b3-16ccccf51efa@intel.com>
Date: Mon, 20 Oct 2025 16:37:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] intel_iommu: Fix unmap_bitmap failure with legacy
 VFIO backend
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-7-zhenzhong.duan@intel.com>
 <5cabe9ba-fad4-4f23-9d00-10f775f12f7d@intel.com>
 <IA3PR11MB913639B9E0AB36CE6890BCE792F5A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB913639B9E0AB36CE6890BCE792F5A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|DM3PPFF3DEC9799:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a916cf-11b8-4664-7b7d-08de0fb2ea1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|42112799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWxmaUxWUWlpSWF3VHZWRjJHaHVXNkR4ZkYxeDJrejFoNGN1MkhmcnFNa3N4?=
 =?utf-8?B?TXhRV1lGZnlDb1RTQkUxZ0c1WCs5Y0x5cjFoeTlSZm8zVWtQMTJpS1ROMStD?=
 =?utf-8?B?Sjl2aXp4R2FPekMrM0xyS2x4N25OTlB5OXNRVE9MM2xYUHZ3SlBYSTBVOFFO?=
 =?utf-8?B?WnpVbC9oVnhkd25ML0hSRkpGRFNiUUVCOExzK3kwT1NqcmpDNlVJTmZxMXhN?=
 =?utf-8?B?THFlMUZWZHFnaDlFeGMvMEtyNVQ4Skt1L3prRkhMMmhHRkFCV2FqMlNoMmF2?=
 =?utf-8?B?RytyT2RCdGVkbnZjS1dTYTBqSWFWYncwWjBEcDJFTkJqS3ZteXp6dUlKMmdq?=
 =?utf-8?B?VzZOWGgveVNwZXlkYmlZb2UwaUpJMTNrNEFTZWFwNlBrNnB3ZDVneEtQWDRL?=
 =?utf-8?B?S1dCdnlxcGJLRC9SM1BYdTlZcklad1ppNmx2SVNxYno5ZGl1WjlmOHVMVUph?=
 =?utf-8?B?YzhBYTNHZWJVM3kzUjZyeWR1d2xwNmxYUDJ6aHZodEJwa1N4WEFTRzFiTFhP?=
 =?utf-8?B?Vkc0Qkd2SWZzU255bFk1c3dETXp4WjZid1crNExQczY2ZEJ3S1pMMllJNmty?=
 =?utf-8?B?ZTcxblQrbXlNcUFnWk9aWlV5M1NuMFV4R2M1Qzh4cVFuV2dOVXZ1K0YxR0ZY?=
 =?utf-8?B?eUhjR3dVbVpzQXpMbFM1a0dFWjR6aEY1SDUzT2FWRmJ6bC8wQmVPNE84d1kx?=
 =?utf-8?B?KzljUDhzSDRjSGpFWjdsYmpkT0x2VWdmSnVaUlM1R1dxdnVvUFFqclhCSXJy?=
 =?utf-8?B?cTNMUGRnemZ0NG5pRkdLZkRMTzBpUWRWcjA4OG8yQzRrWUxpN2VoSVliNisx?=
 =?utf-8?B?UlJzNTFUZVRxRlIrZ0VRZ3pOaDNraFlJM1d2VlVUa1ZpZ3MyblpxK0MydGRF?=
 =?utf-8?B?akl1Qis5NDVlaTgybGZmUXlNNVRsWWJLZ29hNGM1VjNuVmJzQ2E4dVJ1UlNs?=
 =?utf-8?B?STRnUDRBdXNHdDB4WWgvaUNLZ2txV0FTK2duUkVocXpaRUhTOHVhaUFOMnVH?=
 =?utf-8?B?ZFBxUHR3ZnVKd04vc25ZUzMrcm1ReWtTbUVncjJzc3prRmFFTkRia082dElH?=
 =?utf-8?B?dExxVHFGMS9xcWUyNzlHRUk0WkFxVTRLUTRhVnVhTk1LYkQ5VXF4R2Z1OU93?=
 =?utf-8?B?UVFQSGxZSmRpL0ZPYTNuOWV4VWt2S01VSzkyY09zZ1Zud3JBbTd2VTBrVTN1?=
 =?utf-8?B?djdvWS9la2ZDalV3bnpWNVJnMGt4dnJFaFhtSUFHUGFqQTJoUWU4WVhhV0ZF?=
 =?utf-8?B?R200UHREeVU3VGtjaE1ubW50T0NSZ0ZvZThTZTdJK01DSWszS2lQZ2lhMWFE?=
 =?utf-8?B?SGJHNVc5QzFVYkdCMFkzdjZucXAyUS9TRUh5MzFMYXliM2RFNTN6bmo4YVpv?=
 =?utf-8?B?MVFLZUlHdm1uK1pzN0piZEYzS3FZc1I0dzdPQzF4TTFqdURQcUE4cVRGRkVj?=
 =?utf-8?B?QXpFbU5pYUQ2ZkRyVDh6YWFiQVBtcCt4WTQrazVyYnV4R1p0K0g4NHlqMnUy?=
 =?utf-8?B?bFQ2bDl4UTR2dlUvNDk3V2dsRGhNTXFsZ241aVIxL0MyWDRONXJvNWFlVG5l?=
 =?utf-8?B?ZzZuWXRwc01zelhZN1pkMzBYWCtZUE9FWksxejUrS1IrSTdiNUVkUDdxSnN1?=
 =?utf-8?B?OUIva3FUSkJPMHpzdEJnSEM2VHdOb2dmYW5xMTZ3VFA2elZTODJhN3Nja2dT?=
 =?utf-8?B?dG5RdXRwbVlqZGZJMFBvbUZQVnNKcWp6QW5uNEx4d2RyRDBPbnpGUkZEUlRi?=
 =?utf-8?B?SnJXN093YUxDZlpyWkdyejBIWU9tTzFMVHZxUlQ5blNsUUNBOFdJWFR0VHVw?=
 =?utf-8?B?cElrNVpmMHpUc2x2bHpqOGZRNjFQYjJneWcvTG8waitQVEJGSFRudUdodkU2?=
 =?utf-8?B?YkNzVmdONWxZMjVYdzhkRk1YN0QvT2lKYnNxR1BXeUlESnBwaU1tR1FEeVEy?=
 =?utf-8?Q?Bdn0Wbim74UHebLkmZPXgz8xQqCkT+BQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlVnY2pCZlJxZDhJMzNlUnB6T2xqUHd5V0htOTVaYWtOVTRyb0IyaGVEWU05?=
 =?utf-8?B?ZEVWaDRaZXdZRzJucVdwM2FmNTE0UTJYekVmWXVZT3NDVjI5YlI2MzhZVzFQ?=
 =?utf-8?B?YkJLdTFSLzNHRHUvRTlqd3kzbUwwbnlpWjExTVZNYWUyMW5TZ25yU1FnOVhi?=
 =?utf-8?B?ZWU2R2RjeDRiU2xUZE1kZnpLMTNpYVZxRVBSQlg1SnArYkpBQkxneWdPWTNh?=
 =?utf-8?B?NFR1MmdYKzZYWEd4UXIzaFNWeTl5WVIrTEM3VUxHbnl4UFFOQ3p2R1pNTjU5?=
 =?utf-8?B?c05uK244STVaa0NPUnVmZjl1Z2lVbFNVczJ5b1VMaWRtazBPODZ1a1JjOVVm?=
 =?utf-8?B?RWRPZ25qYlpkSkFWTytjMXNDdDR4dHNpcHJWWm9Nb3daTGN1ekdJQ05kNW1S?=
 =?utf-8?B?b2MxSHFzZmVUWVBiS2lqcjhLNXQ2NFJYSU9URWt4blYyak03clZEbHhtK1hN?=
 =?utf-8?B?YjgxNzRmQytleFM0SlgyK3N2Y25HMERqc2t6eGpQQVRHQUVGRTkrRUVWS0VG?=
 =?utf-8?B?OHdOb2RvSlBPT0VxdGR6STRoM2JBclBKaEFpeVFaVXdUallWUjRYQ2FHNFNT?=
 =?utf-8?B?UWR2UkN1bHZNNHV3NGsyZVV4ZWsranZ5OVRWT0xwRklhSkRmRmVFNFpYeFd0?=
 =?utf-8?B?Qi92Vk5OSFdTSWwxejBIVGErWlg3TTcyOVByTEpWRXhvMEhNNnllb0dlbVl6?=
 =?utf-8?B?OEpLNTJkdy9jNUNud0ZwKy9HY3hvZUwyeFhKeUdISlFTRGROOWdiQjUzamkx?=
 =?utf-8?B?M2xKcXlxR1ZONWV3ekFXSHdVdnhvTFV1OUd1b1R2RmNOcGlRZUFKZ1FrdFZ4?=
 =?utf-8?B?SlV2YVBtWm5valowcDNPSXVXRHpjbmZJZ0oyY3hwYWVhMlBua3lKVXZCR2dn?=
 =?utf-8?B?bmV6N094ZlErSy9CU1ozMEhNRzNjQi9kYVpkdDA5YTN0K05RVXNhZFh5a1Bj?=
 =?utf-8?B?ajFMbVBsNktkTHdpZDNob2h3RGhRMUd2eFViR1h4akpmY3Y4NUJZaytNaVBG?=
 =?utf-8?B?b3o2bEQ1aENMMmtPUy9MSTRNTDV2M1hrdDVRWGFmUVIzdU9VdUVydXd1N1Q4?=
 =?utf-8?B?aGJsbTFzcG5RV2x3bW4xUUI3S3ZZV1hMSC96a082c0gvSEwramt3SElUaEto?=
 =?utf-8?B?ZUhoVHdGU0ZRUnVuK3R2enlBWWhqdm5yd2JsUkdtSHdwWHQ2TlBWK2YvdHdI?=
 =?utf-8?B?SE53a3g5Y1d2RG9MWGdOOEZNQ3k3WDF1UlZZazBRRTlaUG4wUmpHWWhrZDFk?=
 =?utf-8?B?VStSK213RHpaQXp6eDJueEtncllrNVVKakc3b09PcXc1ckw4MllWWEo2bzlR?=
 =?utf-8?B?RmN5WU9ibk5KV1RabnhNY2RwdjJmdDdGWmxuYWJqWVI5WWpaOUVSRkFCRXNw?=
 =?utf-8?B?T2VYeDAxaWMyeFNSTDR3OFFCa3J2VzUyTDRhcVdmeDl1ZWFnWGUyQ29OWVRt?=
 =?utf-8?B?dEU3TlpGc0ZwZ2NudDljcGVOMU9IQzZheWNGK3czZUU2SzJ3ZFUrNkxaMVJr?=
 =?utf-8?B?NHpDUmF0OSsxeDJpOU1iQWUyQzVlVCthUG92SVQ0dnFFdUJIZzJrQk5jOWlw?=
 =?utf-8?B?SG5LV3pFZnhjZmF1WkFwalIySXJ1dzVqbnZhRkZEdHFvMW14UTNLSFdPam9H?=
 =?utf-8?B?Q2hhVGdpaGRYUUVwVExiRFRIMzYxMyszTm5UOFRWRmZHdDN3NlF0ZzVJRGpk?=
 =?utf-8?B?YzBhNGE5ZXJkbHlaRDYveFFRMnFEdkVhNnZtQmNGN0lVemgyd3hKdGpSSS9D?=
 =?utf-8?B?ak1YaXVjV3krai8xUDYzRE4xLzlleWVzdkFXL0FjSFZIYVZFRHBpdERKS2dQ?=
 =?utf-8?B?MFdnZCt5SGt6emxwa3pnOG85YTFHeStSV3QzMUNTc1hsUjNxeklNNGx6VWZs?=
 =?utf-8?B?N2Z3ZUh3RE5rWHhOa2ZhVk9JQ3duYUk0UmltRUl5OHJvd1llNjFaN2dWSDhG?=
 =?utf-8?B?N2dpd0lGRnVScTZqblQ3MUpONVM0K2pxWldZaERYdmo3SW8zWEtWWWNHSEoy?=
 =?utf-8?B?V2lobGhSZU44QkphZWhLaHVSSXpQY1d2bi9IMEtSbGJ2Wm95UGRIVXEvZW4y?=
 =?utf-8?B?cUVoWWdiNTFsQjE0LzM1U3RSYkNhYlprbmtjK05kTHArMFhCRjZCd3o0WmZs?=
 =?utf-8?Q?CKVivE6qIDmFfpnr9UrBx3uAP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a916cf-11b8-4664-7b7d-08de0fb2ea1c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 08:30:24.0651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucLXyI8Wy87QLYJVL+n3uEoC0nZxcYyR99+LjjfH33xS7C8+xVlJeZAJfEL8eZMs7dwd7yjoIxfuGueKEo/8iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF3DEC9799
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
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



On 2025/10/20 16:03, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v2 6/8] intel_iommu: Fix unmap_bitmap failure with
>> legacy VFIO backend
>>
>> On 2025/10/17 16:22, Zhenzhong Duan wrote:
>>> If a VFIO device in guest switches from IOMMU domain to block domain,
>>> vtd_address_space_unmap() is called to unmap whole address space.
>>>
>>> If that happens during migration, migration fails with legacy VFIO
>>> backend as below:
>>>
>>> Status: failed (vfio_container_dma_unmap(0x561bbbd92d90,
>> 0x100000000000, 0x100000000000) = -7 (Argument list too long))
>>>
>>> Because legacy VFIO limits maximum bitmap size to 256MB which maps to
>> 8TB on
>>> 4K page system, when 16TB sized UNMAP notification is sent,
>> unmap_bitmap
>>> ioctl fails.
>>
>> It would be great to add some words to note why vIOMMU can trigger this.
> 
> Hi Yi, I think the first sentence in description is explaining that?
> 
> "If a VFIO device in guest switches from IOMMU domain to block domain,
> vtd_address_space_unmap() is called to unmap whole address space."

aha, yes. I was trying to mark it is NOT necessarily related to VM
memory size. Could you note that the address space is guest IOVA which
is not system memory?

Regards,
Yi Liu


> 

