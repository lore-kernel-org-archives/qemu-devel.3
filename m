Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4265D1CA28
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 05:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8BgW-0006mM-IG; Tue, 05 Nov 2024 00:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t8BgQ-0006li-Lq
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 00:00:51 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t8BgO-0000kf-1O
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 00:00:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730782848; x=1762318848;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hs1tz6mL7+1vQqWtPO9iX4keNShXy5xbcSvnZwKvgGU=;
 b=aPxJcYUhBlsgwjmqIVfi2MWBC+smMYfKvbwg2Zkp8yPPFYos33XnE5Ka
 Uw89Y8LGCVMTRMOBUI29Rsr8nwwZDBe0Bpsz+9p98gQ3Myemu4ydkU8B5
 SRYdl6zVxGsvP8plLeC1RoXi37MfhJJiHGQTUPVZtqYYP2zUe4RRVICrm
 UNrN8y5Ikr/MTRxxeQP+xW3Ph0DK/zO0f/ebrtb+c/SqfdAr2iiApdxp+
 Y2xc80VmbfAG1wR1lgoYWPX/ZIQt7ZY3ciDd9thzdLI5Qt8SbFEuCbK/X
 qdEnC5OR5D29aH1S4Z80pupwATr5QA8UCytOu8kkCBz1CTPCG//AKM/yk A==;
X-CSE-ConnectionGUID: VEME77YzQlaD+UeQmaPVow==
X-CSE-MsgGUID: z3s3vvqWTnCCHF9YscWawA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="29928675"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="29928675"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 21:00:42 -0800
X-CSE-ConnectionGUID: 1507te/PRO+NvYIfiGzpvQ==
X-CSE-MsgGUID: dv4AVuHeRsOZZtA9f/3FLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="114662168"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 21:00:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 21:00:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 21:00:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 21:00:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCSnyvUJgtlnUZ2hQ1yWB2Z0NBlyNt5trP3QTIe64GEfFMgKcwEsxXcO9DWaBqnfniofuG0nOwrVxNJ7PDwwy+c8VvfNzqXXxI15adm6QsVk+O9KtEaYjzms9l2qmm2xgH4LAz18mS86BfkYSZJ+RsuhC7tzl9H+tnBwqPpWcU1ok9ztFj3kV1Ttgex3WUspdEk2V4NyqyFQ82gJhVZFcquqkAs1CvRcv3TDDi4vJYNqXcbyJlpXtbdG3oshvoC7T6iwWZ9QmBIv3EJMSD7MWA13Ul97m3NnA6RCq5kaSVhBsxAC6m0nQZ8p8gX5j7N5FGCPwQgSyS9FLXjWfzIMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0os1D0nFqLjltss7pjvAc/8g4QOqxnPDahgaYLtrBpk=;
 b=Fqg15hN2jkw2LcUUfOk2vr7dTk/EjM5JsXbKnGkqBCJ/0k/EGQKjlWaUQ6HhTgXZ/D/r1S7MaZ0IHCrfogH41ZvtUP/lRnd1b5ISLBH+1cGa+iBLgQZZ1UJEVVZOSs5NzlRo1uSyQMQau3OJl46HKWsf2ApOAE30dHOoLZ0KgUC7VizZ0NhP/QlkhcRC+vaNCsxSN4W2C6+f0ATcjE5YK+nkbowqscLY8EwROeMTy0EroubNxi1jPM1wnsA7Vn1ljWUf4SAaMVtjEE38lV+fyJ7Eswm4RUhW3VSOtiZKQbHRekbu9VL/r3inVAOJ1jyxyXaiAd2FSLri47OH9bvKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB5126.namprd11.prod.outlook.com (2603:10b6:510:3a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 05:00:39 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 05:00:39 +0000
Message-ID: <0e8716db-9a3a-4007-823b-6b0ef5ad455b@intel.com>
Date: Tue, 5 Nov 2024 13:05:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>,
 <clement.mathieu--drif@eviden.com>, <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
 <20241104125536.1236118-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241104125536.1236118-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB5126:EE_
X-MS-Office365-Filtering-Correlation-Id: 32dd9d8e-a833-4209-be42-08dcfd56ca80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlBxR0JneWpFSWFuV293VnZTUDhKZkEyakw5MU1tVFBzWlo1VWVJWVBycUQ3?=
 =?utf-8?B?aWxLYTlTMllRSjVuYld3TW5hWkFaK1VqTVUva2UrMDZpZmRzR2ZpZjF4U3I1?=
 =?utf-8?B?dmx0VWs3am02RHdIUVo2UVFtdm56TTlLMEpacVZKUUlQWmNWZjl2VWlBRTNu?=
 =?utf-8?B?OWd6SndrVjA1NWdVRjR2c0VMNFNFa1VkcFQ5TlBzUURBb25TWFM1aWxWc3JP?=
 =?utf-8?B?bm92aytYazZYMmlVTWg5SVFaaE9ibEtDWXJKckJTVUt2M3VuQjVYNUNERkpx?=
 =?utf-8?B?V011L3pqTDdTakFrMlFIdHpweGJ0ZldEVWdKeURCalZZZWVuWjQ5V1NpU1pn?=
 =?utf-8?B?Rm01Ym1rRHNoTFJpU3J0RlJiYnlwTU5CcTlScVdWVVBPTXlRNkpTK0Q0Nzk2?=
 =?utf-8?B?aXRxcW9BQ2ZLZ0lwdDlYaUNqV2hTTGlBMHRwa0JYeDdVWTVFemt2d1pOVXUy?=
 =?utf-8?B?UldwdVBhVWhtTlpoNHYwamc1a0xPTGExamlPMUg1ODZVSHZaTndqM1ZuTjZt?=
 =?utf-8?B?T1VtT3dxU1dhRGtkQUV1anc0WW1FL3ZWMnIyMWwyZUJ4NVRzZFNCaFZscjlx?=
 =?utf-8?B?L3d0NU1PZW80MnljV0g0NmpMRXY1ci9qZkZPdG92R3o5UVcxNzZrQVNkVklP?=
 =?utf-8?B?VVlrTjh1cDFxTUNEZDIyK2gydUVlanhKekJudzl6cHlOcCtuWEYyMi9oRHBF?=
 =?utf-8?B?RzBHNWkxOUtReUg0d0FkdGZsUlFzc1F6WnIxRnZscDcvWDF6S09jSFY3SSt0?=
 =?utf-8?B?N2tQdFM3RG81aitWSWltMGZBUTlmWkpJYnBvZXgrTXdiVGMvYjlCcVdlRzFC?=
 =?utf-8?B?QWVKNmY3dTNVZS9lVjcvU1VYVU9wL3lsd3k0Z2ZCaWFYMWh6Y0lvUCtOaWt4?=
 =?utf-8?B?cFU5RmgxQ080a2pxSEN3d2RKb3JwY3VxQS91Zjl1Y1FKbUVQcGt2d0toWGh0?=
 =?utf-8?B?dmlkWG9jUFNoeXZtMWRLNm5PRUovZDV0M0phdnpKRk1ZRHFsazlVSDEwZFlG?=
 =?utf-8?B?eVg3SE5jcVU5Qjc2eEtkcDZiMEhDM3ZPeHdCbm1LWDF1dW80YkN5NjB4S2d5?=
 =?utf-8?B?dDNFL242K1NxcjRqVDZHUHpRb2ZSUHF3UmdUQnpqZlEvajdwMVA3d2hLN25z?=
 =?utf-8?B?aWdpRVlZQTlMTy91VTVJUlI0aUgraUJ0SXhvdzRPOFZEVzFPWkVNbnNPQVVs?=
 =?utf-8?B?M01tM2NjOUc2MjBkUklpc3l1UkpWNVFaMjU0Y1M0U2V1ajI2YldHN096RXpV?=
 =?utf-8?B?b0VtUmxwZnI3aHpGUWtUc2d5bmtHMFdvU0NWbW94NDFQNms0Z2NNQ3dKVHh2?=
 =?utf-8?B?eW5Qbk1mVHI1bUVoTWZXQ0tKMkxaL21yZzRqL2JsWmxOajNLc3lyVEw3RWRq?=
 =?utf-8?B?Uk1DQW12TXBQVWZ3UERTbnR2VGdxakhNU2RSdjJqZ3E4SnZibDJPRHlCdXVM?=
 =?utf-8?B?RGRNdGRMZjZ6VjlITW04eFZzbjNlZnZHQjFsNkoyZUw5MEVNRmFqOEVPUWQw?=
 =?utf-8?B?Q2dmRFRpY1gvcWZvZWJhMjJtd3FQdXBGTGpXL1hWSi9ROWprUE1HaVByMHVi?=
 =?utf-8?B?U1RVRitJVXBnQWdwNkhhVGQrbGFoRlBocnZLQkNxYlVSQ2RYejZZS3dVbENI?=
 =?utf-8?B?VWxMRFNLUVJOUnE5WmdNM2xZNzhneDBodE9EdW1sdjlid3ZSWG5QTWNGVDgy?=
 =?utf-8?B?QkJsK3dlam1NVGx6VTFmSTA3MVV2L05FaTFiUWdITG5ia21aWEs3ek80U3Nw?=
 =?utf-8?Q?1LmXIpOW9rXMYT+pY47KppzaHzK8J+OAlOY9WH9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVdwWnBLdUVzZEx3djVLbkQwUVNoblAvYXc5WDdKRDRhQkh1cFROcEFmd2Vl?=
 =?utf-8?B?ZVdjVCswY055MGJRRTlUdFFiWVJQbEdDTFZUcGF3MnYrUzdYQVZDVGVzN3A4?=
 =?utf-8?B?anZUekdldDQzd3JtdVdzRCtFQjhhSXliZFlOLzdMcGNMNTVHV2c4OUxXMjZ1?=
 =?utf-8?B?clhYbTlDbXB3S00xcFhYUkNBSUowbURaSUp4ZXV2NDUzZ3NDZUx0d0JxQ3Rs?=
 =?utf-8?B?QkNHUjFxR0Jiai9hR3MrMmMyMmkreWV0bnRmK3psSmxYWWQ2ck5PRlliRUhE?=
 =?utf-8?B?RlZ0akNyK0pqMXJCUkhKa2Q5b3R2NHBKdzhQMGtsMVRRUWl0REZZUnlBaHdH?=
 =?utf-8?B?cm5Ud0R5cTMrTVR4NDRId3dJMUVUdjJNS2JrVllSSGF2b0lUSjltL05qZU9F?=
 =?utf-8?B?clBRU2h4ZlNHbk5veTdHMGc5VWR3dS9majRtZDlqOXF3eHNPSDlGOGdCbW4y?=
 =?utf-8?B?RHNZVnpEY2lWZnl1RjMwRkxkcWJVWDBZdDhDakpnczJ3Z3FlTlIvWXlwZGFX?=
 =?utf-8?B?REhZYmJoQ0UyMzBwRG5QU0V6K2tlMUlYUkpJRWVCY2RnWkdadlRxdlJlK2Uz?=
 =?utf-8?B?YVZOMkxpZVhkb2pxalNLT1VBUE5xMEJld3o0S0JvdkpWRGhoSE1MS1pveEtH?=
 =?utf-8?B?d3J2dUNVekNhOWJrQVQ3b2JMRThZbkZMWHNBR0ZUY0hyN2t6ZEF2bE5xZnFU?=
 =?utf-8?B?Ukp2Z0tXVnVKRWl6b2pOTjYvN3A5S09kTFFNa3hvSGlpMXcvRHgzbVEyZFpl?=
 =?utf-8?B?SmQrc1cvRVRZMDZXN0oveEd0NXI3TWpvUmtXUWgrcGpXNG52eGZoNGM5ckI1?=
 =?utf-8?B?SWtCZjRQaDFONUs1VE9XL2syTEZ0bXBxTVVyNXpvOVM5bk1CRlFUYWtpZlRE?=
 =?utf-8?B?N0E3Y0dWNVY2RkhwdUduNVVhVi9jZmNIQWkzYkplbkxHRW93V1hvOUN4ZDd1?=
 =?utf-8?B?K1Bpc2ZIRnpFMnV5Vng5TXFNMVU4ODgvcnVuTnYvZXZ4NmpxbFBvZDJPSHBQ?=
 =?utf-8?B?QkFYM002U1lXRG5yWk5pYVRzM09ZTEt0NEZ3SVhZd2NGM0xCbTVrZ3RDTjZV?=
 =?utf-8?B?K3BCSmQxbTZmSU92am95R25PQjQ5NXNVcXhvb0p1YkVkTnlJOHhrRjdCb215?=
 =?utf-8?B?NjdZcUw4dnpnbHpTQTlSVGlVRTUzbStxQVZpbTYvalQ4andPOXYzalU3aTNW?=
 =?utf-8?B?NWhJUnNiSk9LejZ5UXNCV2FkQ2c4Z1ZJK1YrUUMyRkVaRjFXcjZDMjhkQ3k0?=
 =?utf-8?B?bjc3NHFVZWhEOGdaQy96YzBUaTFsNnV1MVZSTnJJaCtNQVM0Y21LQktqQkZr?=
 =?utf-8?B?U1haTmk0U25sWTF0YzNkY3pXK2ZQSk1UQ3czNUZlaWxQZ0hWQWxFWWxFdzc1?=
 =?utf-8?B?TkxYbm52bXBjY2hSZ01teklwZ3Mxc29RQUNJdTRkczQyVGp4M3F0MG9mT0Zz?=
 =?utf-8?B?WkRndzU0V1ArNTQva0l6c0NSVWRvS2Q3NUNHSGszZ1g5allVWmR3UHBBZnRa?=
 =?utf-8?B?UE9NUit3WXNtWmJrV0ZiNHdnVEd4QSttcTR4NmlTMWFXUUJXTmpvZXovNXRu?=
 =?utf-8?B?Rm54OVBsVm1rOG11aUlpT2FQamRKNmF1eVJjdk82YXJhOERBK1B0a1NZakc4?=
 =?utf-8?B?Q3dOK0RTRGRaSlZsZ0FkTXBndkxodjV1WDY5UWlieWltTDVlTEVqY0Zhalhy?=
 =?utf-8?B?bjdGb0pvekxYWkxHT2hrS1VRbEFOYTlGQmEwYmtJK3VGRXNqQWVQM3dhM0pS?=
 =?utf-8?B?Sk96alA3QU15N01DZjMxdm1KekozQ21meEhzMGUxZTdWZlkyTUI5dGY1eUs0?=
 =?utf-8?B?NnEzNmhYcFJ2QWFPenBOT1M5WHJJMFpucTdPcGlRVzMwcWQ2cTRFY3VIUUR2?=
 =?utf-8?B?YytXWk5rMVFKbFVqT1VzZ0kwT21XelcxazFPTit5QW42cDd4NURNeE9TdCt4?=
 =?utf-8?B?cVRYSktJQ0NXN3lKakNucVFPbmVJTFVuVFJWMFFPR2taU3hYdFZiMHphQmZh?=
 =?utf-8?B?bklPazFEdWhBS3BhMlVCVEkzakN3ZG5acXZYSHZaQWlCb0VET3hWT3ZWWFBO?=
 =?utf-8?B?Y3ljMmlSdnZuN3E4OHl1Q0crcG4wRW50WnhFNUVSM3Q4NmZxamthZmpKQXI4?=
 =?utf-8?Q?KHqfQYZCjqcYlSKXdRF6R1jls?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32dd9d8e-a833-4209-be42-08dcfd56ca80
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 05:00:38.9432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMf1O0/DdzcImgvP7ny0BATdVX9tMLw6l0H4ME2k5MmaVsUOz4Q06CoIV3qxDkyATRSVWx67qJRga5OmhIg+Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5126
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=yi.l.liu@intel.com;
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

On 2024/11/4 20:55, Zhenzhong Duan wrote:
> According to VTD spec, a 256-bit descriptor will result in an invalid
> descriptor error if submitted in an IQ that is setup to provide hardware
> with 128-bit descriptors (IQA_REG.DW=0). Meanwhile, there are old inv desc
> types (e.g. iotlb_inv_desc) that can be either 128bits or 256bits. If a
> 128-bit version of this descriptor is submitted into an IQ that is setup
> to provide hardware with 256-bit descriptors will also result in an invalid
> descriptor error.
> 
> The 2nd will be captured by the tail register update. So we only need to
> focus on the 1st.
> 
> Because the reserved bit check between different types of invalidation desc
> are common, so introduce a common function vtd_inv_desc_reserved_check()
> to do all the checks and pass the differences as parameters.
> 
> With this change, need to replace error_report_once() call with error_report()
> to catch different call sites. This isn't an issue as error_report_once()
> here is mainly used to help debug guest error, but it only dumps once in
> qemu life cycle and doesn't help much, we need error_report() instead.
> 
> Fixes: c0c1d351849b ("intel_iommu: add 256 bits qi_desc support")
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  1 +
>   hw/i386/intel_iommu.c          | 80 ++++++++++++++++++++++++----------
>   2 files changed, 59 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 2f9bc0147d..75ccd501b0 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -356,6 +356,7 @@ union VTDInvDesc {
>   typedef union VTDInvDesc VTDInvDesc;
>   
>   /* Masks for struct VTDInvDesc */
> +#define VTD_INV_DESC_ALL_ONE            -1ULL
>   #define VTD_INV_DESC_TYPE(val)          ((((val) >> 5) & 0x70ULL) | \
>                                            ((val) & 0xfULL))
>   #define VTD_INV_DESC_CC                 0x1 /* Context-cache Invalidate Desc */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1ecfe47963..2fc3866433 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2532,15 +2532,51 @@ static bool vtd_get_inv_desc(IntelIOMMUState *s,
>       return true;
>   }
>   
> +static bool vtd_inv_desc_reserved_check(IntelIOMMUState *s,
> +                                        VTDInvDesc *inv_desc,
> +                                        uint64_t mask[4], bool dw,
> +                                        const char *func_name,
> +                                        const char *desc_type)
> +{
> +    if (s->iq_dw) {
> +        if (inv_desc->val[0] & mask[0] || inv_desc->val[1] & mask[1] ||
> +            inv_desc->val[2] & mask[2] || inv_desc->val[3] & mask[3]) {
> +            error_report("%s: invalid %s desc val[3]: 0x%"PRIx64
> +                         " val[2]: 0x%"PRIx64" val[1]=0x%"PRIx64
> +                         " val[0]=0x%"PRIx64" (reserved nonzero)",
> +                         func_name, desc_type, inv_desc->val[3],
> +                         inv_desc->val[2], inv_desc->val[1],
> +                         inv_desc->val[0]);
> +            return false;
> +        }
> +    } else {
> +        if (dw) {
> +            error_report("%s: 256-bit %s desc in 128-bit invalidation queue",
> +                         func_name, desc_type);
> +            return false;
> +        }
> +

If a respin is made, I'd prefer to move this check out of this helper since
it's not about reserved bit check. Another reason is you cannot find a good
naming for the @dw parameter. It's confusing as s->iq_dw is checked as
well. So put this check out of this helper may be better.

-- 
Regards,
Yi Liu

