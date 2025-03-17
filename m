Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E38C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 04:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu2Ip-0004p1-NQ; Mon, 17 Mar 2025 00:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kishen.maloor@intel.com>)
 id 1tu0k0-00058G-L8
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 23:02:19 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kishen.maloor@intel.com>)
 id 1tu0jx-0008EW-Ni
 for qemu-devel@nongnu.org; Sun, 16 Mar 2025 23:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742180529; x=1773716529;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=267h9s6CnW20U13jUsZOwwP3HjXqR5+9IienTK0AWb8=;
 b=FEGo0icKYQYmKyenKvDgQVnYSoSYWU1eyNiulIkWubnGGZDoL8GQDtlI
 xD3cb+6f41UHFz/nZGnPpmU4M8v9n5mh3EM6ql8AQYT57HvwEdzKKaaO0
 hd2PJehCdojvCBcPrcK0zp9kJ0EFVrENceN1qCnrLVX+NY5ipSunDruzl
 g89mnsSu3K1umldM4r3C28PUev601G222jXfjGBIvFSRy/g4042ar80YY
 X4/RmjbcW6Luu4Jun9cFyt2EO+vt2hUG+mDHBhoI3vfgvHI0j3m3+Lixc
 Doq011DHRcT6pklc2xg4jmZHkkx134mbRQpJq8qlxM/LPRhjYNQkIpiba g==;
X-CSE-ConnectionGUID: j/0JLjU7SCmENolahHT9Mg==
X-CSE-MsgGUID: J7oM/Ht1QVO99ud4usf3Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="42438143"
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; d="scan'208";a="42438143"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2025 20:02:01 -0700
X-CSE-ConnectionGUID: WhcIBaeaQ0eprRSDUvkBlA==
X-CSE-MsgGUID: fpnzvJE2SwKGQBFfZFtb8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,252,1736841600"; d="scan'208";a="152737030"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2025 20:01:40 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 16 Mar 2025 20:01:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 16 Mar 2025 20:01:35 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 16 Mar 2025 20:01:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Akh8FlIyU5BXnLL0jC7ihqp/WuWpzDy4LRK6w/3M3HRer6i+WHljalcc1nZ9pd0D8UuxC0fhepGltWoIGHrummjaZPWcLLcr2KQdr0ip9uRMTjCCyeho4LfvSPFE/f+DD54DjMS+d5ZV0D4aEpkP/pPw71k/vIa1hOVNxPS8kzEhbdmLeI4BZV203Sn1niqWYZgTgr23tyQXgUikL/ecXgDT8kl4ioddFgw14ulDQM/GLgOJrqSdSDZ1u+eGa8S4C/vCz+EJ85WljrLzW2ITs+EwSPfYYCPUPnKaPFNDiup3FP0v5fVjmhENFydTgFs9ql5NmIebFPTc8VhI6/RDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kECPfY/VZLw7WluIFNJ002UsBT+GOnFRgh7tNtmU80o=;
 b=wgo5iamrAWae8TonDk/UvqwwNTzVD1NFTDxOfDRSGgwsMioiItAokLDI9k0BogHhcGaQy2nMD4U0OUpHkP6MpqibbIEdxOXI/qspeM+sDO45wHdZiG/KaJcrJtnkSd0qPM8wtgjOl8Z4b3amypthJ4Qew4abxa5TznpSL07UdJc5R+w5BfIUNUIHL8iVgi1UXFooQuux75k/u5jZ1o3o6dQCPZw+WzoVGO6frBLhm9aXzSAz5Uam3FU6heeORisbJpRCJJJ8vVGvYmIFegQzfG9Opjy00YyRqodkF4RD5mbvbEngWbbDi+L186gmGgDu6v+H6jMc9GR6oFwg0yA9AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) by
 CO1PR11MB5026.namprd11.prod.outlook.com (2603:10b6:303:9c::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 03:01:03 +0000
Received: from DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::bcc7:4a98:f4cb:b3bb]) by DS0PR11MB8050.namprd11.prod.outlook.com
 ([fe80::bcc7:4a98:f4cb:b3bb%7]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 03:01:02 +0000
Message-ID: <a5fa4844-e4c3-4d7b-a08c-ed0ce77d9028@intel.com>
Date: Sun, 16 Mar 2025 20:00:59 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] memory: Unify the definiton of ReplayRamPopulate()
 and ReplayRamDiscard()
To: Chenyi Qiang <chenyi.qiang@intel.com>, David Hildenbrand
 <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>, Peter Xu
 <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Michael Roth
 <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Peng Chao P <chao.p.peng@intel.com>, Gao Chao
 <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao
 <xiaoyao.li@intel.com>
References: <20250310081837.13123-1-chenyi.qiang@intel.com>
 <20250310081837.13123-4-chenyi.qiang@intel.com>
Content-Language: en-US
From: Kishen Maloor <kishen.maloor@intel.com>
In-Reply-To: <20250310081837.13123-4-chenyi.qiang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0203.namprd04.prod.outlook.com
 (2603:10b6:303:86::28) To DS0PR11MB8050.namprd11.prod.outlook.com
 (2603:10b6:8:117::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8050:EE_|CO1PR11MB5026:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b8c59b6-3464-4424-148a-08dd64fff3a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmFNSVROUE50b0RpTGp1VjNWdGh2SDd4M0xwbUttU2FKaXlMREQ3alpXcngv?=
 =?utf-8?B?NktkZys2T29Ob0pxc01mdFhNTGp1REoyWFh2ZGxKcy9STmhrVTZNWTYwcGN3?=
 =?utf-8?B?TWs1ZDBJNnlrUHVHSlZTam5RY0FQd0FoMTYxM2J3SHM1Y2U4MHY1RlcxYjEw?=
 =?utf-8?B?c3BXWEhheW9kNjVkV0R2c094RC9EWE5EQmFiVmNVZWdFeVJLdCt4RUV2Mnhp?=
 =?utf-8?B?MUJvVFFwTFIzMnZXd3pPY29wRHJ1SkZqM1FKZzd0eWZvQnQ1SUduT0F0UUwz?=
 =?utf-8?B?ZjZOSFpZSmNVYnFsMWEyOE1wNGlrMFNJNXppN056Q0pPdjBmc3YrOGJMNVZK?=
 =?utf-8?B?dWMyenVwTlFlNmllQ0U1QlA4TmxKbmVkWjJUWlVldnA2OStkTjY1bS9lS0xW?=
 =?utf-8?B?U3JoYU9TemVkTjB1eEl2UndPMFFQZ1FzeUp5VGNmZlVJaFVQRDd4UGZLWVUv?=
 =?utf-8?B?ZGR4MUdCdEdBS0pMeFp0bGFjY1lvTHdFdkVrY1FsWlAvL0IvYS9zaEx6OFVm?=
 =?utf-8?B?VVY3eWpjUlZhWEFoRGhrMUZCaVg1ZUM2KzBQa09KRkhmcDhGUWFNT2xTTkdM?=
 =?utf-8?B?NFZwcExCanBxLzNsMm16TENpdW9VdVlTYjk4c1Y3eDVMSGRXamRBd0RycDBV?=
 =?utf-8?B?NGZOcGh5Y29HVHVtMWppbkRMQmlWMkppRExpWllTVkZnUU1HbC9ENzdZcXVs?=
 =?utf-8?B?N0FWenZITGNZOXVYTFNCT3Evd0hhRHJpZUR1UXF5clVLTHc5MjIxR25hZWs2?=
 =?utf-8?B?WFJ6ajVPakY3STFOR0x3V3VxZ3JRSHpqUE9udFlBUmJQQXFuT1VENk85cTB5?=
 =?utf-8?B?T05qdXMrSW5mZFZWUnp6Q0pQbHZrMlFJMEhZMlZSczdjUnNpV0ZJb1RFR0JE?=
 =?utf-8?B?Yk9jNFMzdDkyT0MwdHBYNHFkU0p2VzFSYlVwNEIyYXBmY3ljQndsNFlyTkRa?=
 =?utf-8?B?QWNpTjVRU2dTYUNlRXFGWWY4dDIxTGQzSE01bUJiYVZPYWJmUEhDNVFINE04?=
 =?utf-8?B?T0dBdmNrcHEraW9lckhpemFsdU5zVU9zWnpqbUNES1plTSt2aEI2bVY5aDIv?=
 =?utf-8?B?ZFFzWTJJY1FGQTQwdjlUcUthOHl3UlROSFg0YUlsS3M4T2JQV21qQ3d5VkdR?=
 =?utf-8?B?dE5KU1M2UEJmcmh0ZEp2UkJNbnVBSWdaSVRhejZ3V1lLeDNxTVdCdWNGOTg4?=
 =?utf-8?B?TGw2OGlqMFZkdDRiVkxLbXo0b2sxSHIwRGJTenpaRXRzdXcwMU9HcHRQWmRZ?=
 =?utf-8?B?d2lKNGdvQXlIZ2dBV1piMW96WWVtemhJQ1hiUWh5OFcvMkdwSE5zVTM5QTEw?=
 =?utf-8?B?bWY5OVZnT1MveFlySnpqZUUwUTlxN3V2OTVqU01iblFzbC9ZY2M3bjRlZTVQ?=
 =?utf-8?B?aHlxU1VVbEU3anUwQm0vUmJsZFM0M1dwQXp5SUIwL0xScmNDYW5VMTZGeTZm?=
 =?utf-8?B?TUI4dFVJdDcwSkw4Y1VXWGR0ZDJFUUNKaTlxUS9FU3lWcCtCak5JTFRuV2xO?=
 =?utf-8?B?LzZGUGFMN214Ky90YVNRNmIwalFCRUpYdXU3bUZsSS9vL3JFZ0psZUFBTTNy?=
 =?utf-8?B?TlZZdlVrZlR1Z201T2twcytOZnFiUEFZempOVElCU3lienNtcllxY0xMTG5k?=
 =?utf-8?B?MnUwSHhydEN0TUJXaXgvNE1RU2ZJd1QwbDNqeWp6L2FyN2tES0VYaXo0RjJl?=
 =?utf-8?B?bXVQemhhakRvNU9KS0tFSVdTY1Jia25IWWtOQXJHL2ZVM1U2SjE3RklRaTlJ?=
 =?utf-8?B?bTFSKzRNcCtkTEdwa2F6eUJrYVo1U0NjWVQrd2dqRWhmN3lwWWhYTGNGOU45?=
 =?utf-8?B?TUQ5bklrZnl1RDVORlh2NlFhb2l2Ym5iVFpDTi9sZ3plUVNzTmFPYm84bVpp?=
 =?utf-8?Q?lc62bEwm8sZTa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8050.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1BLRDFmZ2luUU9haDZxOWl4VFVVYUdwcG50SVBnekFnUmphMzBPRTJMMTBX?=
 =?utf-8?B?cmVZS0wxbS9MdVRkeE5DKzdhb0JvWktYRmx3d0ZJZ1d4MUM2ejVIaWpNa1Vn?=
 =?utf-8?B?aGlFN01nTWNHTSswdkZidzlVSWY5RWtabHBsb2dZQ2VqS09uNnZIenJ0bmxZ?=
 =?utf-8?B?RTZWM3g5aENYaGJSODhNWGxtVzJ1eklORlNWLzJ2UlNITGpsWUVQNy91eFFI?=
 =?utf-8?B?VHJGaU90elVRdkt4cHExc2N4WHN2YzV0RExyblVSQ2dwd01reFJrYUZKSnRJ?=
 =?utf-8?B?Z3c5NXJvNnd4a3Y1dHZWNW9ET09ERC9iY2dsNXppVUJhekh6cVNLTEdPNHVk?=
 =?utf-8?B?RFRra1N2YlJJK1dUdlZ5dXV1SHJWZGFSM0FHa0xmQ0dPY1NPdi9oYnVtT3hK?=
 =?utf-8?B?WExUZUZaczVxWUlDcTFzRlVVbDg2OXgwZ21CYkxtazBWZHp6Q3FlUlBmUE5q?=
 =?utf-8?B?MDBaUk1uWjFVcUZxOHNYbXViLy9aQ2hib3NiR1Yzb3RNY0k0VFNGOUI1RkFC?=
 =?utf-8?B?MjZSOG9nakxQbVNTd05JUnJCL0ZEVFhRMjhUQ3cwTmZSeHBseHp3WE1yQVRE?=
 =?utf-8?B?VFRWNXRJVDBYeTR2RHE2NjFGdThaNHNOdkF0ZDI2aG41Z05Zd0s1WDROUEJ2?=
 =?utf-8?B?ZnR0MTZuWGFhNm5ONFVqWjFwekxhZGtpTi90TEdFUC83ODRjbjF6b0owdVVZ?=
 =?utf-8?B?YmY1N0N6SmR1LzZEM1BGdGRxODRpMEY2M2U4dTd2aitVVmkvVFd1VVgzQkYr?=
 =?utf-8?B?UjgvS2d1aEg2MnpsTkVsOWZEdkQxSmFiOEIrbm5XRDdSRjYrOG9nSDEzRTlo?=
 =?utf-8?B?T2d4QmV5aS8xRlRaT3B6dWYycTg5NjBYR29mZ3BLcnNrYTdRZTY4VjIxM3hT?=
 =?utf-8?B?RGRqcnF0MDl5eFJSV2hvOTVVUDlFcFJxQWt0eGZSREZPZ2ExSzYyTlkwbWgy?=
 =?utf-8?B?RFVpajVDYmlTR09JdTc3QkJ6VUFSUVdxOTRobkk0dTgvRS93bWEvMVVLNU5V?=
 =?utf-8?B?K3JNbEJTb1hjQ053enRBRE8yc2ZPaFErUTk5N2swY2g0SDYrY3RoaHMwUHk5?=
 =?utf-8?B?WkM5aVRvbmZKRG9iMjlOMEhjcVBuK0l0V0xhY1Q4bDArbHI1Q1FRYmZRTXho?=
 =?utf-8?B?RURTeTJGN2gvYUIyTlZ0dHIvbWREZGxwNXAvcmw2NkNsRXlLa3l3QXpnR1c5?=
 =?utf-8?B?L2I4aDBNU091SXp5YXUyNHFYRE5OUDJyTHFpS2NRelRQM0sxWHNlTUhrd3ZY?=
 =?utf-8?B?S3IwajJpOHFvbkNDNktIVEJjTDI3Skpla3VCK2VKOFZ1anJZZlQzbmlEM04y?=
 =?utf-8?B?dHRKemRKYVd1UkVNaUVDMzZnMkRvM0wyNVcyQ2ZZVk4zZmc5Wnd4YTZRWTV2?=
 =?utf-8?B?cW1Sd1ErRGJjNnYvY01QNGdVSDd1L1lUUE1Reko5Q3luRjJSUlkwd2JjOW1Y?=
 =?utf-8?B?cUtYbmdNL0JVK2R4czRGVjI4MC9RMlVtV3dPMXQ0dWlVcVpPek92UWdvKy9J?=
 =?utf-8?B?M2RocXBhbTg1bTZIV1YzMkx1dllxbmRLcVZLVVpaTmtXUEZyWXJGMkl1bDNV?=
 =?utf-8?B?blVCUGsvNzRKTFFTa3NMMXJxcUp4dUZoRnJRcmtxZCtXOWpjMlNLRVFsSWcr?=
 =?utf-8?B?K3A4WDlRQisrVHpUUXRUa1pWYktJU2E1akJGV1hTZGJINWpicWRsSERvTHZ3?=
 =?utf-8?B?bS90cllOU0RsN1FiU2p1N2wzRG9oWGk3L3RxM1hqZVdVajV2UmZIMmhVTUFp?=
 =?utf-8?B?cjMvVC9TWDZtbEJFRko3a3c3ekY5WHlFYUMxQU5lS1l6SHJBWkwzMEgwTTRN?=
 =?utf-8?B?VXQ2RGxQYnhxMHQ2bllSK3AyYVJGd1lHdkQ3L0I5TzRCUCtUdEUvSlIyY0du?=
 =?utf-8?B?SFFhbVBZWk5kdVpEOXlhL2RQbjJ2L05nKzV1YVlCaG5pUDZwekhnM2VWbURs?=
 =?utf-8?B?cXNYSWRxbThuRnAvMVMrMWRUMytzcEovYStadmNhVVJmZGlYQkRtRVhQaDZC?=
 =?utf-8?B?c3h1dEhCQnp1elg0ZVp0c01sVlNpZUpXbEhDblNjSE4raFE1WHpCSFZ5SzRv?=
 =?utf-8?B?V2FIaFArOFZMa0haNFpPdzkwd1BWQ3FCamlvV05zV21KVkpHZHhjeGlPYTlD?=
 =?utf-8?B?TFBBL0pUTzJ0OEwvTjYyWklvSEVnQk9wcWJ3NExjUzNUWTI3V3JvSlNNbTBl?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8c59b6-3464-4424-148a-08dd64fff3a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 03:01:02.5732 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HHs2RAZyqJX4ilymNhB9HGJiv1C0A3vqLMHU8WtkLTULeusYdAhY3H05U34dI6sVTNkxoevhZXE9lGm6YVMFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5026
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=kishen.maloor@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Mar 2025 00:42:13 -0400
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

On 3/10/25 1:18 AM, Chenyi Qiang wrote:
> ...
> diff --git a/migration/ram.c b/migration/ram.c
> index ce28328141..053730367b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -816,8 +816,8 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>       return ret;
>   }
>   
> -static void dirty_bitmap_clear_section(MemoryRegionSection *section,
> -                                       void *opaque)
> +static int dirty_bitmap_clear_section(MemoryRegionSection *section,
> +                                      void *opaque)
>   {
>       const hwaddr offset = section->offset_within_region;
>       const hwaddr size = int128_get64(section->size);
> @@ -836,6 +836,7 @@ static void dirty_bitmap_clear_section(MemoryRegionSection *section,
>       }
>       *cleared_bits += bitmap_count_one_with_offset(rb->bmap, start, npages);
>       bitmap_clear(rb->bmap, start, npages);

It appears that the ram_discard_manager_replay_discarded() path would clear all private pages
from the dirty bitmap over here, and thus break migration.

Perhaps the MemoryAttributeManager should be excluded from this flow, something like below?

@@ -910,6 +909,9 @@ static uint64_t ramblock_dirty_bitmap_clear_discarded_pages(RAMBlock *rb)
              .size = int128_make64(qemu_ram_get_used_length(rb)),
          };
  
+        if (object_dynamic_cast(OBJECT(rdm), TYPE_MEMORY_ATTRIBUTE_MANAGER))
+            return 0;
+
          ram_discard_manager_replay_discarded(rdm, &section,
                                               dirty_bitmap_clear_section,
                                               &cleared_bits);


