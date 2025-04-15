Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90574C369B5
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bhJ-0008Fq-Do; Tue, 15 Apr 2025 04:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1u4bhG-0008BT-JW
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:31:10 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1u4bhD-0004gJ-Pg
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744705868; x=1776241868;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yktnXZg3lW6hO83R8e0KLq4Wjjyo0e6N4+ny+4KKlHk=;
 b=drnI6ebxtJOFtGBp5OAvMn74kopJZEZm6WRQgNNll4pB326oUucUzO4N
 leuwiNgJXffAz8eUHhOd2Mh568ylkEin0IgZhphX5kuN6c5qQVYxkPIDA
 Qb4mfyqpikR6FpsFcfgwoAmEaJieRwKk4nOYTHA4G5VISbuqiiHqB9srF
 sZh7K8Yyhz+tmZORt//WEcPaakqZ3WLRj28r0muffOPAqvlDPrkWZAwY5
 ZM92D/XHIYmw/KjNER4SBOSl1niQVc/Nj7WXQIGZYDxhRSSJi2rVXcytK
 /y58G+EtJ9t4783UBnxcwKv8c+1/NcotxX8+QjqY11am2Xi0Yn4v92tex w==;
X-CSE-ConnectionGUID: RbbICsFmT5qqVkaNlQSJcQ==
X-CSE-MsgGUID: as8C281kRImAqoTJ6/iiQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="50004943"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; d="scan'208";a="50004943"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2025 01:31:06 -0700
X-CSE-ConnectionGUID: shm7Du+NRc21fwshwiYJTA==
X-CSE-MsgGUID: qvvCiKQQRR2W70hX4fHpdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; d="scan'208";a="134158322"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2025 01:31:05 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 01:31:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 01:31:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 01:31:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2lCOfIl1tlynoo+H8Q8Td0P7Uk1k1CY/v+E3Q54lo54Imf6ZU7heYh0E5oy2PzjjRQv8KtWCI/4MJ49QTmVFt8ZERkQQKDoq2Uv4SzEcSrDF0JjfS8REwzlTwjk6mTckwosJUdKsQhaol6pjw+SJbKj2x9kMp+tZYfwR+MqgfrNhlIQ+D2biqKsP8u6Z97ceLMkBMQlS2oWcEc+4lpUU2JXPytLDkpUqj0G4i/auqO/qiIPaYE0CK666n0MEj4/xpG+jeDgeq48xa28chTyNsRaPlDoAO2JbgWr6WFT3y6LOhSqNb1gcQ0cDEfrZOsWzsyjHRGUED8uMqPtYAvz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IF7QBiLVuAh2IhK1u1YmXnq7XU0A5pg2I79G1Jxq6s=;
 b=elK0SLXaRnTBAVrxaXqv+3NJhNbfTBUHVDDBtlpNLcjU9d+NPw6UIE/QZe+KEZC7nIfZS3N4/qXd7jEYUfULQXHW3OTKNCEfgbfXcn29v1o+BjkPKqyj/P/MQzhg1VRop2yatF3gaWdIZvgCl0thP4UyVuOpNIgAiOUfDcQMg6TilUMIcjY5YyNovba4luMpdIBd2h2h0eOoSu5O+wRuw9Jms7MnXlvcsGb2Sh7KUufNjaDLc6yEccFIp6ijDGlpQ11wxnS/ojpd6wgcPN0tuLP40UOGDKAZSuW0mseIHeJ/pauAKCaYeZNkHGJ2SwcmyZbpS4Lfxf+wm4GaBcJApg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB7581.namprd11.prod.outlook.com (2603:10b6:806:31b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Tue, 15 Apr
 2025 08:30:57 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 08:30:57 +0000
Message-ID: <c335d240-dcb7-4f4d-a6bf-ec01914ef97d@intel.com>
Date: Tue, 15 Apr 2025 16:36:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "peterx@redhat.com"
 <peterx@redhat.com>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <23c9f066-f30c-4e35-8629-504eeb9cd7a8@linaro.org>
 <f3b38c07-f099-4422-87fa-32c78c7630a4@eviden.com>
 <20250415034112-mutt-send-email-mst@kernel.org>
 <b0a898ef-93cf-4ce9-8737-cac94ed4f731@linaro.org>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <b0a898ef-93cf-4ce9-8737-cac94ed4f731@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA3PR11MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 151381b0-606a-463c-e062-08dd7bf7d81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZitPbFZwNkFuSTBBb2ltSjBmYm0vbEw0VEFXMXlMK3BHMWIxRTV6ZVVhMnhv?=
 =?utf-8?B?NWpSWFNTWUtqK0hwOHQ1NU5BOFNGNjdjZEYyYTY3c3NZYlM0TnMvZnp1anhU?=
 =?utf-8?B?Z21QNUhFL0l1MktuTGtHWXVML3BrNVRTZnh0UGhJdGJGUlJMZS9na0JKbkJw?=
 =?utf-8?B?YjRia0tBMGNLWERxbW4xZTlPRmdOenk2WlptNldRUmZhakpjRksydmNmcVFv?=
 =?utf-8?B?MnEvWVRLc0JCLy9tVDRPM0c2K2NFWjJkdFF4UGZqUDVLdnpETUl4VnNmTTNa?=
 =?utf-8?B?MGt1bFMvWEcrVmJraUZZWkZwL2p6VFZwd3JQdDNrdXBtam9oVytCM3ZLUmI2?=
 =?utf-8?B?NnJjTkV2Qm5Ra0VsYlhCNFZHYzFCViszcmRITlprRDdvdU8wRXpjUkVkMldC?=
 =?utf-8?B?S3Z4V09XUnlJNW5uZ2hlYzBVSXlodmM1MDFtaXJsc0VVbStqelpJaW85VTdW?=
 =?utf-8?B?d0s3bllhd1NqZzJ0UVQvWTdpVHM1Wjc3VUpZWC9ZM1hvbm4wQWFDcHQzRnhS?=
 =?utf-8?B?eExvbDN0U1JITE8wSmIxY3BOUHZIRk5DS0k4VnNTMnloK3JzblgyZHNOUFJv?=
 =?utf-8?B?Szc5QXVOWFRrck5aMHZZbTdCY0I4S3BoUHRvK2RtT2ZQd0FBUU0vR2x0MVJL?=
 =?utf-8?B?UVFSNUxDRXBrbEF4cTRsbGhjazNxVVdySFhVeTQ4QVNkeVl5T1JTOFR6b2tO?=
 =?utf-8?B?M3IvNEpNeC80TGh6R3RmSGlMNmVVaTkrQUpCZWt6YjBhanBGcnJudE5PNHZm?=
 =?utf-8?B?TlRDd3prazduZ1BsNEhiWTZJd2h0eHRGUitERGhJTWtOd04xNmw0Rnh2Vzc0?=
 =?utf-8?B?dGN4SW5UL0JGMStxUDJvVlpOV1pJc1BpQ2NocmE4VDFWbUdFTCtKcUtiaklT?=
 =?utf-8?B?T0l0TGkxYmE5bm56b2VnTnBRUTdoMUhkajZjZE5neUlveFcyY0UrZWpMSDZq?=
 =?utf-8?B?WllYQW9KOXZ6S2JhMVBMd1VrZDNZQkpqdmNpeU1DUEFiVmhLUFhpbmdVMFBp?=
 =?utf-8?B?WWRoM1h3UzhrNWY2ZHEwQ2VDck5JTUJzeDE5QWYwMTA1aE1STXlhVDFlM2Zq?=
 =?utf-8?B?YndjMVFlZ0NZdnlZdDdGR3NLMnJVVS9uRG5XRmZKVldqZXRmZFNmdTRJMDdE?=
 =?utf-8?B?U29pR0tEaUVZY1dvZzViZ0JYVk5pZHA3aFZhd21LY0diQVpReG1WWVZoRTlZ?=
 =?utf-8?B?dkZONWNmZ2hwVGI2UjJBd0h2Y2FUNDJnNWF6UjFnOUhZcnlVT1JMTUQzZVEx?=
 =?utf-8?B?VVExOVBJeUE3UUJldkFEQWZxM1A3ZGNvK242eU5kYXZMNTdHZytRMi9CYnI2?=
 =?utf-8?B?LzdxbnNIL2N4NTRvdjFpaHhSVUlkK0FOQTBoSG1pazA0MUVCUy80Tk9MQVh2?=
 =?utf-8?B?Y0RNL1YxRldXOW0vOGFOK2dMWmU3K3JtOVNad09nU1lKSno0TzZtL0JKNjMr?=
 =?utf-8?B?OGNLbUlnRnUrQm9DTWFaVjFYTGJ6TXR2YVk3bzhSdEF1WGNrRFgyNk15b0hV?=
 =?utf-8?B?N3lXNUNCZjQ0RUgzS3ZrNEtyNHQ1bzNiSWoxanRRcXNqd1Q1NE5PeE9nV0Qx?=
 =?utf-8?B?Vmw4SjdHVDlmSUU3REJnNDUwR3EvY2hQQmU1UDZnUnJGbUNxVC9aLy80T1V3?=
 =?utf-8?B?K1Q0TjN1WXBRVFI2cWZGWHhWdUdLVnRIeUFqa3dnSFp4ME52UFpZT0xFZ2lP?=
 =?utf-8?B?ckRBeE5zY1Zxdnp0Skc1ZG5XU2Z5TDhQSjU3Wkw3Y1pGdEl1d1djQ2gyUmJy?=
 =?utf-8?B?L1VVa1B1SkxhTXZZQXdBN1h0QjE4dmY3L2lMUFA3dlpzc1NXMEt0WGduNDJ0?=
 =?utf-8?B?UWhuMHEzaGFXWjVtK2JLTCtZeTJ2OWkrekJob3VCQnB0VHRuWjRLNUQzQ2Qy?=
 =?utf-8?B?TERpckNTSHBLeitvUXE3UndkbTJRMzA2QWI3NTlkMi9TMHg3NldyL1NNMnRt?=
 =?utf-8?Q?SxOrdSXC6AQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bE9rNmd0d3FBMG1VeWNGQnByV1J3NGpGeTF6SkdYT1lETFdxbEg2TkRWL2ts?=
 =?utf-8?B?UjQwUlFobmFiL2RRZno4ZnRiamk4SndTU1V3WXBzRXhDaDlld2kvQkJtUFBh?=
 =?utf-8?B?a0kzLzdzSFB4dnN0akMvUXBCMmNTTDh4TklMRlRtRjNJeEdReVUrN3pVWE51?=
 =?utf-8?B?aTN1YUZycXNEa3BNdFNTd1U4YjZwY1k2bkRKVis1U25PWFMvVXFjNGZ3U1F2?=
 =?utf-8?B?eHkvSDdXemNOQjBCZUE0dUh6cEFtOTE4NWIzd2VxL2ZXNFBhVVpzbElYb05o?=
 =?utf-8?B?ZGZaZTBVUVFtcWxZYUFqaUFtTERUWDNFclBGVVVhTkt2MXdIRXpwZWxPdnVs?=
 =?utf-8?B?blBwbVZtWHFQMFo5b2k1UWtwamNSdmNYbUFtN1QvcGdyOEF0dVowWG8vc1BM?=
 =?utf-8?B?NnRHSC9rMUdwd0xyZXRTWWhIRG5KZ2NxNE5iZ1h2ZVFiOTNSakZYbmNyVU1i?=
 =?utf-8?B?ZkdRR3ZFa2hTeERsTC8zOFpNUTA4Mzg1dnFSWHIzK2tpR08xd3RTQ0c0VVlp?=
 =?utf-8?B?dUEvRFQ0YzhlZWh3ZUtwVmpmUDErWDRrTnJmaW9hR1VtK2RTVis0TnZJcXB0?=
 =?utf-8?B?alhwR1J5WDNRMUNpbDhUdzhCMlo4T0o5RExMdERMOStXZlBUMHpKVUJ6OXZT?=
 =?utf-8?B?TGE5S3NlN1AyR05yV1kvdTFlRkhvY2JOamU1TkM0Z0JjTlNyWnZZV1JXcWpo?=
 =?utf-8?B?TjZNNXZER01NSjB3NE9vRjZibld4M0lkdk02eGs5VlVkYUdkc2xQNWVVSXZZ?=
 =?utf-8?B?RkJEbUd4eHR0eXQwdXAxMDdGRzRTdU4wcmQ0M1VYZWRwdnUxNThGcDMrdC9z?=
 =?utf-8?B?R21FWTRId1M2d1l0MEpCQnN3b2h3M3BqTzkrZlVsc255aVI1RURoQmc1L2cw?=
 =?utf-8?B?N0p5VlRGd1FUcWg2aGxmMVM0ZjVYaHZPNEZybXRDa0ZZbWVrNXFpZ3JTMkRi?=
 =?utf-8?B?MjdsWXhBcm9rNlRYSkhoTmtOMG0xdnFLUUM2MWxpMzJ6VTMxZ3RubXprRDho?=
 =?utf-8?B?dGcvcmdGQ3Y5T1E0L3lhOTRuUndmdVZrcnlCWlY5V1N2RUIvY2gwMUJUaHFv?=
 =?utf-8?B?VGN0dWJ4dE81dEJ0NllKc3lqaWZwTUQ2bE42QjBvcVRwUVlJWHdwaDArWjY1?=
 =?utf-8?B?T2FWeStKSlRUUmd6MWxUN3lSamZLd1pTL21OMHlacmpjZURTMkN2UEFEM3Ja?=
 =?utf-8?B?UmVhTTB2RXpsR3NLb1Iwdng4UjkyQUw4djRzSk1XdHcwRTRlZTRCZUZCMEtq?=
 =?utf-8?B?UStmbXFDd0JScmxFdTV2aGMrMVNMdTQxdU5sbXdvbHpCR1ltYUJINzI1U3Nr?=
 =?utf-8?B?RmZPQmx2SWw0d2duMmdiRXlSZXluZmQvZ21zd3h6eDRDVTdvMTYrd2IwWHdH?=
 =?utf-8?B?bjE5ZDVpelJ6MjllNzNMZGpXM0p1OVp1ajduYkxTTW5oekt5Wi9uU1lZOTg2?=
 =?utf-8?B?Z2pXN2tscWhWTjh0ejRSRVFleHBLbDZoNU5JbmZwdjkyZ2tMcmxJVGNSQzhw?=
 =?utf-8?B?bjcwZ3dMcFZXVEZMS3JPSWVWWmlpcEtaek5IVjZwUXlGN1UyY1ZTNmQyN1M2?=
 =?utf-8?B?K3gyUTNrVXRJMUp1YWFiZmFsTDFoQjBxTFUyRmM2eVc4Y3EyMldsWEpZT00x?=
 =?utf-8?B?dWs1TkRZZHhWeUNORkVta3hkOFlGZENOWDdjbU5tU3dTNGZWQkNvUmptbEF0?=
 =?utf-8?B?NTgzejBQQis4cFo3cDFmTDQzNUUrdlJ0QlA3U1NkMTl5RHgxaVg3VjhXbGdV?=
 =?utf-8?B?REhwQWhGRFVmYzJCM2JBT1pORFdrMFRTYkdzL0d6bDVXa0N1K2M4bDR2MUZY?=
 =?utf-8?B?MkIxSGdjOE85cHdzUUJuLzVxbTZVdDZyTG5SSmtSa0poZjFBZWhOc3o3Y29B?=
 =?utf-8?B?RmJ0U2RPSGYrajRjUXFXekNYUzdKcFNoRE1SV3ZwN2dRanJ0c1lKNkhuQjha?=
 =?utf-8?B?Rk5DYktNS1RRVlFYeEtmTHo2dUd4Z2pyMWlHOXlpZmlXTCtobjI2dkhhZlhv?=
 =?utf-8?B?WlA1THdRQy9WeWN6enVvamREVnB4M2hCYVB6RFp2NmZPMEMyU0hVL1FEYnc3?=
 =?utf-8?B?ckxrbDlpeFFWTE5NSzkxU01yRE1NaFArVTBVMEdVN252UHoyN3FkemVjQ05K?=
 =?utf-8?Q?IaaK7CDbNLaJVObBgwUCDpD9M?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 151381b0-606a-463c-e062-08dd7bf7d81b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 08:30:57.2326 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKnN3Ew2WE1KvK1zHPosvz/0NHfIh30bU7z19gWYLzQ/yrQnPJrMhXDzL4HgJCo9qj4RSTez2GQw/5Tc9BQ7Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7581
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
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

On 2025/4/15 16:03, Philippe Mathieu-Daudé wrote:
> On 15/4/25 09:42, Michael S. Tsirkin wrote:
>> On Tue, Apr 15, 2025 at 07:28:34AM +0000, CLEMENT MATHIEU--DRIF wrote:
>>>
>>>
>>> On 15/04/2025 8:53 am, Philippe Mathieu-Daudé wrote:
>>>> Caution: External email. Do not open attachments or click links, unless
>>>> this email comes from a known sender and you know the content is safe.
>>>>
>>>>
>>>> On 15/4/25 08:18, CLEMENT MATHIEU--DRIF wrote:
>>>>> Address space creation might end up being called without holding the
>>>>> bql as it is exposed through the IOMMU ops.
>>>>>
>>>>> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>>>> ---
>>>>>    hw/i386/intel_iommu.c | 10 ++++++++++
>>>>>    1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>>> index dffd7ee885..fea2220013 100644
>>>>> --- a/hw/i386/intel_iommu.c
>>>>> +++ b/hw/i386/intel_iommu.c
>>>>> @@ -4216,6 +4216,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState
>>>>> *s, PCIBus *bus,
>>>>>        vtd_dev_as = g_hash_table_lookup(s->vtd_address_spaces, &key);
>>>>>        if (!vtd_dev_as) {
>>>>>            struct vtd_as_key *new_key = g_malloc(sizeof(*new_key));
>>>>> +        bool take_bql = !bql_locked();
>>>>>
>>>>>            new_key->bus = bus;
>>>>>            new_key->devfn = devfn;
>>>>> @@ -4238,6 +4239,11 @@ VTDAddressSpace
>>>>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>>>>            vtd_dev_as->context_cache_entry.context_cache_gen = 0;
>>>>>            vtd_dev_as->iova_tree = iova_tree_new();
>>>>>
>>>>> +        /* Some functions in this branch require the bql, make sure
>>>>> we own it */
>>>>> +        if (take_bql) {
>>>>> +            bql_lock();
>>>>> +        }
>>>>> +
>>>>>            memory_region_init(&vtd_dev_as->root, OBJECT(s), name,
>>>>> UINT64_MAX);
>>>>>            address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd-
>>>>> root");
>>>>>
>>>>> @@ -4305,6 +4311,10 @@ VTDAddressSpace
>>>>> *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
>>>>>
>>>>>            vtd_switch_address_space(vtd_dev_as);
>>>>
>>>> Would it help clarifying to propagate this argument down?
>>>> vtd_switch_address_space(VTDAddressSpace *as, bool need_lock);
>>>
>>> Hi phil, vtd_switch_address_space already does the same kind of check
>>>
>>>>
>>>>>
>>>>> +        if (take_bql) {
>>>>> +            bql_unlock();
>>>>> +        }
>>>>> +
>>>>>            g_hash_table_insert(s->vtd_address_spaces, new_key,
>>>>> vtd_dev_as);
>>>>>        }
>>>>>        return vtd_dev_as;
>>>>
>>
>>
>> As an apropos, I think any caller of bql_lock really should call
>> bql_lock_impl so we know who took BQL. Or just use BQL_LOCK_GUARD.
>> But, that's an unrelated cleanup.
>>
> 
> Yeah unrelated cleanup. Although I don't understand why these
> code paths don't use memory_region_transaction_begin/commit and
> have to access BQL.

The below two functions would call memory_region_transaction_begin/commit().
So these paths need BQL.

memory_region_set_enabled()
memory_region_add_subregion_overlap()

-- 
Regards,
Yi Liu

