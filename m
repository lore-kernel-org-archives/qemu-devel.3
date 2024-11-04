Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37E6CFB422
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 08:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7sdi-0007em-66; Mon, 04 Nov 2024 03:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7sdg-0007eQ-Ha
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:40:44 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7sda-0007dC-Iv
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730709639; x=1762245639;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QNndSLZ1YY34SS+zF8b7s+oOFPHVbVCyPovuWp3iMIs=;
 b=nd2AUB85SNFYR9uV0AEHvkGJqKa/KmI+dS1on+yJ7LdyXH1N2BC83znh
 fiW3cmGkqbcJ3bFyn3ld7dN2Ws28keLJHmFJaeby1OIdWgsKnH5UeOqt8
 HJVLakqtGgXtx2L224hEzCRmN6uixxlYjAKSRjAUIdXXTHH6yAhREn5pl
 NLGAsE+UV5PLP6LyREItwLNynwKzZnVUDNRgSnIDyFS83z/r+lqF70zda
 3hrqVQU08KUxu+zGGm3cGPknuGE/GbMIxePhSl1G6aK5QZYvLNN/r3+Sx
 P0EOddSMeo5TWSh/3GIHGRazwcCb8XOe77JR3hZMgBkNurFdUEDvUjLUl A==;
X-CSE-ConnectionGUID: JPPcBa6JTciMGcTGgnYwZQ==
X-CSE-MsgGUID: uEYcVmn1QwusYOaFi2Y6/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="41786326"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="41786326"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 00:40:36 -0800
X-CSE-ConnectionGUID: zNXAjkaTQx2ASLVi1DCnng==
X-CSE-MsgGUID: D9C12tqaRIemQr8Dm6H9jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="88347027"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 00:40:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 00:40:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 00:40:35 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 00:40:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOtJ35PJHAxgk8zkbyE7Kb4UkWSIc9KETEBFUAx0CaNKC3qdCDGwfkImPDp1dtZpvmUguZUblNmR9pwnCBHHHGhygvD5iJBdsTvQ2lmXF3JESEnG3kD1vXw8XMMvElOthd1rRpUZ34vKJSv2sDvORAPFlYluhvlg779ay8v64EoMjL/hZQ+4qdbj6YAlztxTLiZnhdkyY6ZoAHfPDSpGTJc6OpkKcH1t0j7b8o+6bZR9AilIQa+X37+8FUEWEkI3SuDahJND32ek6sRFsO8D3QGUK1VRcwbjhWC8pkAzkKyIGNmorvDjqv6JjOQgdtkuGwrD5lOrqaSsxEoi/06Ylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASmxJwySLq9jzSWTeBRmWyYM92KZ7aAG0Drcboma2i8=;
 b=wP/JemzGCs+Y6Z4UcUFYJAJx8Re+4M/b8rV05M7eZNO580aLFiAsV8KCNz3oKZ3I1qT288jlJ0IpOelZGvWFDAEDfZ0IGmdzZS2ud8rYVdGdMHi1MUt6fWl2u5APJLM1qqMpHtr40CoOPDoSK9BmZ//rDeCVLtoD/Uo4Eneecejlwum+VUQFN/50T/bsLKJZvSsriWD++3zddZgSncTqfYDo2bRqR6JyuhnM0H90H0cpTvyjUb8b0UQYW6OOEMCnDNEU6IYHFG42ddyZpnYePWmsos6NpZi/jRQt94iwr8vBVnNZz95wHqZeHBZNPCHZBcJesB6Y+ZDY6iwPonOX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB5924.namprd11.prod.outlook.com (2603:10b6:806:23b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:40:26 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:40:25 +0000
Message-ID: <119078eb-81f0-47a7-81b0-aaf6b7878581@intel.com>
Date: Mon, 4 Nov 2024 16:45:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "chao.p.peng@intel.com" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-5-zhenzhong.duan@intel.com>
 <3bb9da3b-f1de-4a3a-bdd8-37937ed15d50@intel.com>
 <14799ff1-8da4-4b42-921a-ad1198de1bdb@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <14799ff1-8da4-4b42-921a-ad1198de1bdb@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb81c65-d108-48ca-9da1-08dcfcac5437
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHdkaXo2ZXV3MGxOMERIcUJQWVBTQVhKZllYQnJsZnMxQ004cVVYMER4YWRP?=
 =?utf-8?B?QTVFcG92VVdUVFNQNUc1Y0xXVVFDWUxJd1ZMb3Z5ZEdqU1hBRzBUbWVPQ1c4?=
 =?utf-8?B?ZDhOQUEvd3hoMERjS1I1RG4xcXNNd29hY2hzSzBOVnd5Z1VSS21XNktYY2Y1?=
 =?utf-8?B?QUlMWU9yMy9hWVRrVnBKb3lsZ3FFYzRCSFpieVRuTjA3VXMzaExNejI4NVVU?=
 =?utf-8?B?NzhEK2g4bWJ0NVhhbG5CVDk4RUFvaHBQWUc2VXp1TDcyb1FTK3VCWVpFc25m?=
 =?utf-8?B?T1puRWdXR1poT2JoUnRoOEZXdUpxN3RUeHdjOGNXaHloODhrMXJxS2pUS3hQ?=
 =?utf-8?B?WUw1Vnp2T1U1VEtFNVFhQzdCM0FiV2RDT3VnM0hxcm0vYWhUUWt4SFk2UlpQ?=
 =?utf-8?B?QmEwNkJMZ0RiQjVscEZFSmtoMWRYb1JHcVFtN1Q1cnBJZ0hCZXdqV0p0TWgz?=
 =?utf-8?B?NW5oWkg5MmF3K0NLVHhRS2JMcEpZZm5JVnBxUTlyQjFGWFkyQjlHa2twQVpk?=
 =?utf-8?B?L1h4aVZrMW56K1hLcWNlZDB6cHljUUdMdmdzN3lpQSszVzhZVXlSa05NVHlK?=
 =?utf-8?B?aTZsL0FOTzFyNFFmQzZ3TWs5WWcydFF6VHRlenNFdXhQVXNhNi9oVkVzMTNm?=
 =?utf-8?B?RDFJTW40bXpKVnhMUlVGYzR6Mjk4a3QxOVRVRnFNemdybDJqclpEKzNTQ2ZC?=
 =?utf-8?B?ODhCd2tmSmFpS0dBdXlpMmg4SnJZMlNZU0dhUVRlRUFnK3JWeG1DNkNUTGsy?=
 =?utf-8?B?UHk3VGQvbGJUNVRIZkkvdFgvUnlhS3ZyNTJwSVE3djVNTDV0OE1QVWZ5cXcy?=
 =?utf-8?B?d3lrY254WWw5RTZPZTVSVHJSY0RSOUp1dXR6WlZ6VGo3VllvdVBtWGVxbXBn?=
 =?utf-8?B?azdZNW9FUTdRU0NvemRLRjdDNXZIR2Nqcml3WWVDbkJDQTVHRjRsWTlZL3Fn?=
 =?utf-8?B?eTBaMG9ab2ZwcE1tVHFpQ1BTdlErQlRFL2trdWx0QkoyOUJuTmNEaUdpT0Zt?=
 =?utf-8?B?SmY1ZjNOb3R1Yk5KR2M2ZFQvZVBJbjN6a0YrbUV0M0svYjZjNWtEbFlyZHV6?=
 =?utf-8?B?ekNRQXBEeFRFWmloVGcraURmWGZGa21kMmcxNDM0NS9WdHFYWmFQdWFOY3ps?=
 =?utf-8?B?Wm5FcDBVTGt1ZnNWUUNtL1MwbnhLckYzOGVNZWZ2S3UzekRXejNYeTJFaXJB?=
 =?utf-8?B?akphbU5oSTNvZllpZ2FONlZ6d0lTRmMxK09mQ0MyeDVZUkJiNDlSUldCeFY3?=
 =?utf-8?B?QlF5Z2NpUEtzdWpjZGQxYk9SQVZEaGxXcTNTTmlyUFZCdStJK3E4TDFwemdJ?=
 =?utf-8?B?SEV5MDE1RTBXMnhCbFBFdWdhelBLcUR0UndIYmVzSW9TNXBhMS9LeVlpbVBF?=
 =?utf-8?B?REU2RlluV256ZnMzWU1nd3FieUNVS0xEb1JQOVpKWFAvVk5ET01GOTNxTGhx?=
 =?utf-8?B?cCtqVERsUFJqMHNWZEVHYm5QYllqeDkya3J1aVVXQjlSUUlmMVNrSjRTR1RS?=
 =?utf-8?B?ZlNkNjQyVStNd3ltNm9VaTZNZVZMRS9sYXFIcU5GUTRWYmtxN2lSQzFCTm9n?=
 =?utf-8?B?OTF6SlQvSTBXbWpFZHo5NzV5TWF1Y0M2ZGZvL1hpZ0w0cGt4MDFjdGhuL3RK?=
 =?utf-8?B?eWJnZ2RBZDVrUCsrQ0N6NERwNkJUYWNqT0VPUHJnMGhOY3VnTXl1OGNCTXFi?=
 =?utf-8?B?NWNwQnRhOVVnb0N1TkdGSTFoMHVmSDltT3gzQkZJbmhSdXhZSUlJRVlKejB1?=
 =?utf-8?Q?pqPOK+s4E4z/ncJiUqejt1589W4639njqPxvueP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkh5SFp1cGlCdG1yZW9Jc2pMYXp6dHE0dFBnL2RkUmk2WWRsdy9SRGVUSWdF?=
 =?utf-8?B?T1VPQkZDMHBUUUdycVI1UlNVa3p5WGs1TGRSQ28rcFZtQU9JeXVwSXlIaHp1?=
 =?utf-8?B?ZDJNZmtZK1BjYUNRU0JmbGVvTW1TV1hna0RFb0NxZEZGbmE2YjNkWkVyZjlI?=
 =?utf-8?B?YnF6anB1WlZERFVwaG5wenlIQVR2dUNiSjgwTDhsOXdYUzdSZDc4aDllOEtt?=
 =?utf-8?B?WGxxUUZyVXZibXhSdCtlNXhBeGpRYUorUkMyekwvMTd6SFRQMEo2c2kyY25n?=
 =?utf-8?B?VThmVndjMXBYYVp3ZnZxN0Z4cHNTN1dVL2hpNWZEUzg1U0F1WmRnUWZDOGJE?=
 =?utf-8?B?T1dhZHpTRDdtS2VTSklHTVg0aEtqZS9mNHQ5Ly9wZjdDa0wrblRyLzZBNWxr?=
 =?utf-8?B?YzFRWHFlaWFjVjBLRUNBNEtkVWJKUWt3TU1pcUFWS3hVbEU2WWtGaFhTbCti?=
 =?utf-8?B?d3FwMjFlK25YbGNER2Zibi9xdW9zMlVjZ1R3T0ttTy80YzcxMndiYUZKV3dp?=
 =?utf-8?B?enhmd0FWL3FwMXZlS3AzMGlIQ1hMMHhraXlzRDhMbUxwNzRyL2pOanA4WWFC?=
 =?utf-8?B?OFVGZ05ZTEFVTHdhejdoME05azBIUkJqNlZoN0srVkFPOStYREVHazR5ZmM4?=
 =?utf-8?B?RnIvMzlkSmtPQVRqUU0xdDdiTFkrZURGOUpFZWVBb3Z2YlA1aFBhMkE0bERq?=
 =?utf-8?B?REMvNjErQ2F0dVQ4bVQzUUNWRE83NHpFVi8ycTk5UCtaZnlSeUhYYmhQa1gw?=
 =?utf-8?B?b3BEQmNrQitTNEh1ZGVkMHc3UlIySDdoc2poWUprTitMbDkwSWdnb0ZVWHZQ?=
 =?utf-8?B?SFRuKy9HY3NQSDk3UnFBVlVIWFBTUTJZMGlSaGlYcllPc3lCLzQ3Z3kvbEFN?=
 =?utf-8?B?TnB0U25UZ1h3VjRhSVlNTlJjc052QzdHWTVZZTMvaGM3eUlPakdFUDVFS01R?=
 =?utf-8?B?d3hPVkdLMVhNejJTczl6Y2grSHFEOEJKaEgwNnl0OEh0R2dOWGxPZmNzNGJX?=
 =?utf-8?B?Q2IydStabTUvYWIwUlBLbGswVkdIRks5Ry9kb0VENURqaFFNMDg0eHdRSXNu?=
 =?utf-8?B?RW92bDlFSkowaUU3UmdCTWo2YTVNWGQyRkhmemhmeEdaaVJpSDJMbERyM09z?=
 =?utf-8?B?NXlaQkNKN29xYUhzbWo2clNuaVY2eURVYlJqd2lEU3JCWVBjLzRkWWh5QXdh?=
 =?utf-8?B?NVFKMWVFSWUrZ3ZuKzY1Z1AreFMzaHZCeWpFcDRoSWdTdEM0YXlscnI5NlFv?=
 =?utf-8?B?TGhMWDdIMCtORElZQ2tBTWZtYVRxMHk2ekNmazVXNTdic3JRc2V1QndKODkw?=
 =?utf-8?B?ZEhKa2huRXQvSVQyMTFYV3NabFVCdkNWUTFXc2FXVFZiaVZOSFZWVy9sWlZu?=
 =?utf-8?B?WGJ6aWRtbjBuZS9CcFlFYjBPa09lcTQ1Y2ErUHA3Z05XTGZrTGltSEhLbC9o?=
 =?utf-8?B?YlNpNnNjaUNJZXlQS1R1ZWR6UGtycTJvREIzNENJbWxXQ3o4bW42TjlUSmk2?=
 =?utf-8?B?cVE0dkp3ZHFzTVNqTmtXSytFejlYamtSZm1iNHhYMFZaaStGQTVDSmRpWXcw?=
 =?utf-8?B?R3F5Z2p4aXJMQXZGc0laOGlYbjROVjJnNlprY2pkRWF4VzE1MWJsS0VGM2lp?=
 =?utf-8?B?TUl4QWRGMkFIRElQWGpyRHAvUGxaY2pXN2pVWTUzZkZlM1lrdER1M29CbUNI?=
 =?utf-8?B?aXlUV1U5TkpoTXZDTEt2QWRESjVHTnRiWTc0WDNXenRTdnVYeTZrRjJIOE9L?=
 =?utf-8?B?RklnZU5YODFkRENPYnc3bnY1VnJBSTc0U0FhRkFSeHE5WlBwWVd2MGhjN1Az?=
 =?utf-8?B?Mm8xb2k1RnRYay9aTjU0MlZodmw0RXIzR3JFOUJWYXFIQ1lLOGdNbG1yeElV?=
 =?utf-8?B?c1V6SWszVEtmY01YQ2tydjk5RlY4V0ZvM1RRMVJVTFRhL3JTTTlEUkdNT09E?=
 =?utf-8?B?TUo1SFVvUGRuaWQ2WlhTSDhZVHZTRG1kSVdZUVFLclBIcHBQUk4vRGJNdjBw?=
 =?utf-8?B?c0N0MUVTQ0J4TzJ5UGxjdHN1WW4zZ1RGVlFjSUtsU0dwbUxkem5KUUVlTkFC?=
 =?utf-8?B?QnpCMzZxTU54dEFUVmdKN3YxY1ZGSnphS3BtZWIxdG4xb014ZXB4Q0pwcE1l?=
 =?utf-8?Q?Nk5PABzIpl2+mMXw6n8qTFdug?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb81c65-d108-48ca-9da1-08dcfcac5437
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:40:25.8502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSRztP96cZkT+KEX3k2SXoOrhvq5Lo2zgpLmKzv6WyynEq9e7lhaL6Vzhk1yVyh+S6lMeZ6B0rA5hgCQJavjPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5924
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2024/11/4 15:37, CLEMENT MATHIEU--DRIF wrote:
> 
> 
> On 04/11/2024 03:49, Yi Liu wrote:
>> Caution: External email. Do not open attachments or click links, unless
>> this email comes from a known sender and you know the content is safe.
>>
>>
>> On 2024/9/30 17:26, Zhenzhong Duan wrote:
>>> Per spec 6.5.2.4, PADID-selective PASID-based iotlb invalidation will
>>> flush stage-2 iotlb entries with matching domain id and pasid.
>>
>> Also, call out it's per table Table 21. PASID-based-IOTLB Invalidation of
>> VT-d spec 4.1.
>>
>>> With scalable modern mode introduced, guest could send PASID-selective
>>> PASID-based iotlb invalidation to flush both stage-1 and stage-2 entries.
>>>
>>> By this chance, remove old IOTLB related definitions which were unused.
>>
>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>> ---
>>>    hw/i386/intel_iommu_internal.h | 14 ++++--
>>>    hw/i386/intel_iommu.c          | 88 +++++++++++++++++++++++++++++++++-
>>>    2 files changed, 96 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/
>>> intel_iommu_internal.h
>>> index d0f9d4589d..eec8090190 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -403,11 +403,6 @@ typedef union VTDInvDesc VTDInvDesc;
>>>    #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
>>>    #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000f100ULL
>>>    #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
>>> -#define VTD_INV_DESC_IOTLB_PASID_PASID  (2ULL << 4)
>>> -#define VTD_INV_DESC_IOTLB_PASID_PAGE   (3ULL << 4)
>>> -#define VTD_INV_DESC_IOTLB_PASID(val)   (((val) >> 32) &
>>> VTD_PASID_ID_MASK)
>>> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_LO      0xfff00000000001c0ULL
>>> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_HI      0xf80ULL
>>>
>>>    /* Mask for Device IOTLB Invalidate Descriptor */
>>>    #define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) &
>>> 0xfffffffffffff000ULL)
>>> @@ -433,6 +428,15 @@ typedef union VTDInvDesc VTDInvDesc;
>>>    #define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
>>>            (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>>>
>>> +/* Masks for PIOTLB Invalidate Descriptor */
>>> +#define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
>>> +#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
>>> +#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
>>> +#define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) &
>>> VTD_DOMAIN_ID_MASK)
>>> +#define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
>>> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
>>> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
>>> +
>>>    /* Information about page-selective IOTLB invalidate */
>>>    struct VTDIOTLBPageInvInfo {
>>>        uint16_t domain_id;
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 9e6ef0cb99..72c9c91d4f 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -2656,6 +2656,86 @@ static bool
>>> vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>>>        return true;
>>>    }
>>>
>>> +static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer value,
>>> +                                         gpointer user_data)
>>> +{
>>> +    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
>>> +    VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
>>> +
>>> +    return ((entry->domain_id == info->domain_id) &&
>>> +            (entry->pasid == info->pasid));
>>> +}
>>> +
>>> +static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>>> +                                        uint16_t domain_id, uint32_t
>>> pasid)
>>> +{
>>> +    VTDIOTLBPageInvInfo info;
>>> +    VTDAddressSpace *vtd_as;
>>> +    VTDContextEntry ce;
>>> +
>>> +    info.domain_id = domain_id;
>>> +    info.pasid = pasid;
>>> +
>>> +    vtd_iommu_lock(s);
>>> +    g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
>>> +                                &info);
>>> +    vtd_iommu_unlock(s);
>>> +
>>> +    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
>>> +        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>>> +                                      vtd_as->devfn, &ce) &&
>>> +            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
>>> +            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
>>> +
>>> +            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
>>> +                vtd_as->pasid != pasid) {
>>> +                continue;
>>> +            }
>>> +
>>> +            if (!s->scalable_modern) {
>>> +                vtd_address_space_sync(vtd_as);
>>> +            }
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>>> +                                    VTDInvDesc *inv_desc)
>>> +{
>>> +    uint16_t domain_id;
>>> +    uint32_t pasid;
>>> +
>>> +    if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) ||
>>> +        (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD_VAL1) ||
>>> +        inv_desc->val[2] || inv_desc->val[3]) {
>>> +        error_report_once("%s: invalid piotlb inv desc val[3]=0x%"PRIx64
>>> +                          " val[2]=0x%"PRIx64" val[1]=0x%"PRIx64
>>> +                          " val[0]=0x%"PRIx64" (reserved bits unzero)",
>>> +                          __func__, inv_desc->val[3], inv_desc->val[2],
>>> +                          inv_desc->val[1], inv_desc->val[0]);
>>> +        return false;
>>> +    }
>>
>> Need to consider the below behaviour as well.
>>
>> "
>> This
>> descriptor is a 256-bit descriptor and will result in an invalid descriptor
>> error if submitted in an IQ that
>> is setup to provide hardware with 128-bit descriptors (IQA_REG.DW=0)
>> "
>>
>> Also there are descriptions about the old inv desc types (e.g.
>> iotlb_inv_desc) that can be either 128bits or 256bits.
>>
>> "If a 128-bit
>> version of this descriptor is submitted into an IQ that is setup to provide
>> hardware with 256-bit
>> descriptors or vice-versa it will result in an invalid descriptor error.
>> "
>>
>> If DW==1, vIOMMU fetches 32 bytes per desc. In such case, if the guest
>> submits 128bits desc, then the high 128bits would be non-zero if there is
>> more than one desc. But if there is only one desc in the queue, then the
>> high 128bits would be zero as well. While, it may be captured by the
>> tail register update. Bit4 is reserved when DW==1, and guest would use
>> bit4 when it only submits one desc.
>>
>> If DW==0, vIOMMU fetchs 16bytes per desc. If guest submits 256bits desc,
>> it would appear to be two descs from vIOMMU p.o.v. The first 128bits
>> can be identified as valid except for the types that does not requires
>> 256bits. The higher 128bits would be subjected to the desc sanity check
>> as well.
>>
>> Based on the above, I think you may need to add two more checks. If DW==0,
>> vIOMMU should fail the inv types that requires 256bits; If DW==1, you
>> should check the inv_desc->val[2] and inv_desc->val[3]. You've already
>> done it in this patch.
>>
>> Thoughts are welcomed here.
> 
> Good catch,
> I think we should write the check in vtd_process_inv_desc
> rather than updating the handlers.
> 
> What are your thoughts?

the first check can be done in vtd_process_inv_desc(). The second may
be better in the handlers as the handlers have the reserved bits check.
But given that none of the inv types use the high 128bits, so it is also
acceptable to do it in vtd_process_inv_desc(). Do add proper comment.

-- 
Regards,
Yi Liu

