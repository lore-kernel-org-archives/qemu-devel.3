Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E063C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 07:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQiUL-0003jB-Qj; Mon, 08 Jul 2024 03:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sQiUJ-0003bd-KY
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 03:08:39 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sQiUH-0004Vg-RX
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 03:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720422518; x=1751958518;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=g1SRUJ91IaXSCC3AIcqg6w1yIXW8B819zDSKi0KNLA0=;
 b=TbcC/1vVVgIAcpPojUFvSzabTTcGdB7Uw1KpRn4pVrDNxYDLDIPkBUkz
 suj5gJFMzwYXLey9iusi807iIZkpa+uHXpxDaf+jJ47FzEaTLDObi6miE
 TBzjvyxOyQmThsdiM+qR4yTn6aziPAeLR1vbEzGmOhhfv+yoF9FqQIzEo
 CrDMhjfYnZI/ALEe3YJTXb4LuCGdDMFsDsVdDBKNmZ0UnOkCKpbIuCiND
 rNdIuRJ6m6WxmWjDGw6n3OCFFR5NIFRzHHf2KEJm8RS8XucJgFLA2rTNx
 bGvJlmKUOYc7UvBBJnds8l9NeEMoe8oCW1/H9PkUKmbxFK6DMhRqjc0FX Q==;
X-CSE-ConnectionGUID: /aMIHllQQJu9CWS71OITBA==
X-CSE-MsgGUID: hNI1HjcFRMKWEMgtz/sorw==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="21419919"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; d="scan'208";a="21419919"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 00:08:35 -0700
X-CSE-ConnectionGUID: IyCVnblWTomJInQcd0musw==
X-CSE-MsgGUID: Gixndk9iQXiq4EkPiiIBFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; d="scan'208";a="52237690"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Jul 2024 00:08:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 00:08:35 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 00:08:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 00:08:34 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 00:08:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBDYbfk96kou11992VDmXVow4gBx/nFmbAHEnyed9crDk5zGu4rHbAihk8Sw1grgNsMIE3EcjaaNTlFW8YavvyoXoFU2XmyQsn+EcH63wXhyfrRnQEPndPI4OGfNdVV/l74bO6wfVp1OgNgjtB2nfVPHxN5HrPgzoV8kSvteuq3za9HSHEI2B4g/TPpJg7sQPqm3l6qplwF50SEgoQcA6S/AJcp39VngqXHyFGB/1y8V+erE/v8kh9m742vMmxiY4YJPsuY66lC5BE2BTkJjZyPSgpzNlcWww+Hc7matXVVoIcU+X/mkk/rtn6G27Oa4V2CgyjdxgpmML+lE8w4sSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxKYzuL3CIY++WDbnpskJURr4R9B1C1aYFNQkmjL14g=;
 b=SRxMvde+ung/gVNwE4GdrneMkc/hWbCMdm8FOMXlyvumtrP2aqhRERoEADR3JYGa5aTBuSR0YSHh4bVQgCAsqt7mrTAKLRTfxD14Q+xVOZaEekOYO3hsUv2aGe8wzg/wDTDnHFUb+ntuav6UbA6B17JfH5kvNgEwI3R/SdxCSB7WRj3aK/qE3zsZfN5lSGlzeBL+Hjsy40W6bD0Bp49icmsh92MohoIoxoaQkqFTaFBIm0LkHigTfWDucL/IKl29VXE2XbB3dtKYjddLXF9IlRvPJekxkICnZiOtk43F5fku45wJw9MfjoUtBQ9TqG9MFEJTSeSm/Mng95eaUVigsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB7583.namprd11.prod.outlook.com (2603:10b6:806:306::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 07:08:32 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 07:08:32 +0000
Message-ID: <2c2590ea-a761-4617-8b1f-0d99abeca586@intel.com>
Date: Mon, 8 Jul 2024 15:12:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240705105937.1630829-1-clement.mathieu--drif@eviden.com>
 <20240705105937.1630829-4-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240705105937.1630829-4-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA3PR11MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8e26e5-1e0e-41c6-eeba-08dc9f1cc67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVQrR2FyMHhheVZ1Zk5OeTBGZkpIaStwbzFRMkZqQ1F1UC8vMGRhNjVzZ0xj?=
 =?utf-8?B?YVJodytablFZVXI4WUczSkYvczN5NW1nLzVMNzhVSy9yRVhVM1lkai9NcUQx?=
 =?utf-8?B?cERXUzhWUkxBMDNKVTJCcVZLdG1jSFFyZUJXb3pTTmNGcEt0eEJET3ZOeTJU?=
 =?utf-8?B?QTZVR3ZzUERPamFETSt0eHVFWFZwZFNiL01lcE1wWVEvZSswditTbWN3TXhr?=
 =?utf-8?B?UWNDSnNPV0pUdUd5T0Fkd1FqalNnS3l0ZWlkVjVZQml4c0ZxcEdZMEtITlFO?=
 =?utf-8?B?cW94aHVCMVZWR1ExZlBXSEpvQWxIcmhheTdCUTAzaEF3THdTeUhRRUgxTmlF?=
 =?utf-8?B?QUZGenZINmk0Tk5vOHVyVlNLYys3R3VQOTltd0FyU216WWhKODd5S1RFUnpv?=
 =?utf-8?B?eVJwd2Q5WXFvQUE2NlRjUkNNUUZKU0FDVHlPWTBmY0NTazUyZFN3ZWh0bkMv?=
 =?utf-8?B?TDhEUGdGdzBSRXBPSnNEU0k0S1hMemE4b05iQTBWZHNlbzlrUDRSY1RJSk1E?=
 =?utf-8?B?ZVMzVkJJd2RNQ0dOb28zb0RvMHAyc3JZMUx6RG5KdjdMMDVndkhtazdFRmY1?=
 =?utf-8?B?VEoxdkxqc0pVLzFHVHRKMENwSTJVeGdzdW9rb0pVQ0lLRkR5Mk9icmdNUUpQ?=
 =?utf-8?B?Mk12RitGZ2F4b3pidHZIUkl4T2s1enUramcyT3F3RXNCTlNsYWxsemFrZXN3?=
 =?utf-8?B?YXdhMHgyZ0VKdStXZHEwcW5hUkhqK0l5aXdqbm5OOEZnSzM0dU5ZUFBWTXQr?=
 =?utf-8?B?akNXbDYyM1JXeHN1c0xDalorU3AwRVk0MFVYMlFWTXl6K0h5SDRkVzdQRHE5?=
 =?utf-8?B?TFRhRzMwcElTcEtiTjRVdUIvZTVCNC9qM0tQdTRiTnBKVkFuMXQ0ai8wK2t0?=
 =?utf-8?B?bGVPaWZWRWpVZkFuWm96aDNERFlJYlRESFlQVW96TnZ5YlZqNUZPY1l5b0k5?=
 =?utf-8?B?SXNsRTgrbmpicjBORk9VMFR1WEt4ZllZRVVKdVVMeDhTREFRdm9mTkRzQVFW?=
 =?utf-8?B?VDR6UG92MkNOUVB0WnRVY0poM1RNZkY3TlVEY05tSHIwR2FCdEdKcUFTOEgz?=
 =?utf-8?B?aGhMaDQ5ZS8xVHV2R2Z5YnRLbHZWaytlR2NSWTFOeXJYUUhnRkp4M1NYdk1V?=
 =?utf-8?B?T0YrMzNnL1NwcW85SXJ3bW5pdnZSYXYwSEtHcnlzeGx1aXRGVUw1cENDOTRM?=
 =?utf-8?B?cjdyV1R3Q0IxaHVndzJnclMvOGtDZFJJRGwwUWU1c2xkTVdJWDc5WnVUamNW?=
 =?utf-8?B?VkJZdW1pREpjTlloalJ3K3pSVHIrc3VFQkpDTlJHWmRZVzBOa0RLMkc4ZExm?=
 =?utf-8?B?b1hIS0x5WHhXVStWaVZFUUwrRHNHVDlzTzFFaTNLbDM5dDA0YmhMTnRZQnFx?=
 =?utf-8?B?Q2Z6bU05MkNNMzRrV2lPTjRKeG02TVZ1cTNpSGR6QzdvRHhKd1o1Q3NzSmU0?=
 =?utf-8?B?MVpWODlwTjIxbDRwbGtuNmRrMlRTeGhCU2wzTS9ITW9WUkdRYmh2SGVtVmUw?=
 =?utf-8?B?TnlXYzA5aEVrVFVMRUlnb0tEb01JTWMvaTVNMS96N1IzYUlNQnhrUXd0TEpH?=
 =?utf-8?B?NGE4WWEyMklxaVBadmlnU1BmM3FHTmhFSHRlTkJqaUJxTmQ2QWcwL0pWL2Qx?=
 =?utf-8?B?M0Q0d2VqRmQwaU45OHl4aXd4QTlIZnNuamtuV2gwSUs0YVZhQnh4R2RiR2xT?=
 =?utf-8?B?SGl2RFRGVG92TENRUmJTSndVU2tZQmJsY3lCc20zbDBUUERUc1grUlpnamNz?=
 =?utf-8?B?VGEzcnR1S2R5clNEVjR1ODZiejQzVm9lN1ZyOU9Tczgxb3duVy9DakJQbXcv?=
 =?utf-8?B?WTZvdXVqZTd1NUthUkk3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0txQW5ocndyc3NlZm9DanB0SytWSEhrUnloQUV3ZmtUeHc1cWpkelRpZkZW?=
 =?utf-8?B?UDZlYXF6di83YU1wZ3NMdUtBUXFTZFhDbHlOdkcxbFBZbW5JcmVzaFhhWjFR?=
 =?utf-8?B?dko4WXU0Q25qdUt6bWlnbGhlQzc2UGYxSkpPS2JHQnppRmFOZzVBMjEzRTFK?=
 =?utf-8?B?TTZQV21Qa1hJS0JFN0tNQmZyRmNrSk81eGkzY3hQZENUcG1ROFNQL0gvVy9K?=
 =?utf-8?B?NHZyZWZVbk5kTDJNTnFZczhtb1JpUVdod0NReWduMGVPRDlaaUFHZW44WmlC?=
 =?utf-8?B?d0hGejdrOUJuREw3YlA3KzFTaVJRNkZ5cHJQUVNnTU1UckRxS1NpK0lMS2Va?=
 =?utf-8?B?NTlFUVFPVkozOTFxMy9tektrYkFRVldyZ2NIRi9ZWkV6bXUzK0M4Y1N5Y1k1?=
 =?utf-8?B?ZHhDQ21JaUE0bnVMUVVDN3JMKzZMdEFnZG9ubkVEZmRXU25HSFAyVFU4MHY5?=
 =?utf-8?B?ellwWmc3c2w2K2xFWjEvS2lCODgzZlJGamdibU1nYkp3ekN5TVllLzg3ZzY3?=
 =?utf-8?B?V201cmIweHozejM4T1JEa3lreHdValpMRHowSFNpVm5ia1J3emk0MjlJYnh1?=
 =?utf-8?B?K2djWU5Jd1IwSHJiazNlTXVkMmFRV0xTa2FrMlNLanRGVVFkaHlNdDlMVW9B?=
 =?utf-8?B?ZE5oV09iWG0wWWp2NlpvSW1WdDk2VUFLOGhOUHYvbi9VdnBTZjBXTjNnQWli?=
 =?utf-8?B?NldvUVZGTnBmUzF4OURSbjJkUURJOXJRUUJkZldUVkpEZTJqY2d2RjlyRXBZ?=
 =?utf-8?B?Tm5hdEROS08vaFRMdDVEVEV0dFZ0eGt6WjYrY29STEVuVDNDeURqM0ZZQ3h1?=
 =?utf-8?B?c1BSOWJyb2NxTDllYjdmVngrbUJwTnUzTU81enNUYUxoN3BjV2RHQmtmNEZF?=
 =?utf-8?B?eWVRTEJCWlJncXViMzBDT2MrZ0dwUGk1UVgyMEpwaStDY3dreWdSMEk1OHE0?=
 =?utf-8?B?YThzL0l1NUJHbmhSZXFpMURqUFdkaFByL2FpaFJKUEpWYmhRRVJYckRFM2Ra?=
 =?utf-8?B?a0hzTnM5eTQ2a2lzN29TYm5aeVNwemVzMjBvQVhPSVJIT2pzTmhHNVJhSHdQ?=
 =?utf-8?B?RkI0RDdNNTVkZ0dhZm0wK0twT29xREFjLzZIK2pPZ3kxM2hQMUcySUdhdi9K?=
 =?utf-8?B?Z1V6UVh4MVd5bU4rcVYvYklhQkcxWVE3RStpcmpCTEJlM0FWSSsvNWVWdmVj?=
 =?utf-8?B?VjAxaWJiTFJ6cW4xU0pVMlFCMzVySkJ3NUJ5WGdkSlBURW1DR2VPUEttRDAz?=
 =?utf-8?B?dVE3R3ExNHduNHZOVzdOTVhDZ0EwSFZ2OEZ1S0Jha0ZTY3NvVlppcVNDcW83?=
 =?utf-8?B?dVRzTHZMWTlDSlUyem9ENHRoOUpoZEs5L3cvTTBmN2VZcWNrNnB6d3JOR0th?=
 =?utf-8?B?SkE2Z3lYT2lITzlJYkdVcEs4UVJLM0dpR014eUd5SGhxcVN4Sm9SNTBEazBB?=
 =?utf-8?B?ZWRpTm5YYkNNcFJpM0I0R05EcElRYUJnUFI3aU5GV1pYbnZPcXFVd0NKOTIy?=
 =?utf-8?B?VTBKY04vVU1Td280ajcxTk9VajlKU3hVb1kwZFN4ckdwbnI5aDVWamlwUDR5?=
 =?utf-8?B?TWRyWmFPclpvdXVJRDBUQlVxd2xreTBxQURtYkZTVVk4anlwTEE3cUp4VEFS?=
 =?utf-8?B?Znp4bk5IRnVyK1dodmlPRHZSWUtnTlZHMXA3VmplM0NxSVkxcUhpaGpuUE9v?=
 =?utf-8?B?TTJRUlJVckI4R2haZEtQUUVUcEsybHd3OHhkcWNKb1VoVUxYaFNnTHA3cWNB?=
 =?utf-8?B?Z3hCbHNrdENFbEVjclJ2enRWTWc5bEI1bGFhRmxpZHZyTkRvWENXR3JMa3V3?=
 =?utf-8?B?VnFqNzd0WjJHRzNGek01bTJUNWE2Ry9BSktEemN2clNLN05yRjg4V0JZVWlD?=
 =?utf-8?B?K3JxYTVncS9xRjdCeXhMYWNSemhzUTRIWWJuYk5IY1pBcnA4cFlsSGtSOWMw?=
 =?utf-8?B?S3BaKzhsQldZbGlpZ0hrMTFhUGVYOHVkUEsxaFJMSi9RTzVsZC93SVNYVXI2?=
 =?utf-8?B?TUJpOXIvYll0ck0yR2NDK0k5T2xNdjdvR0JkMU53V0RaMXJucHBxMW5QWFlw?=
 =?utf-8?B?d0R4QzFwMmtpS05ublc5YnJ3STVJaTJvUkR2SEoyVWpOZ0FqVXBtOGttNm5N?=
 =?utf-8?Q?pfnWJjTFvIWScU7F17Rrd9bJY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8e26e5-1e0e-41c6-eeba-08dc9f1cc67b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 07:08:32.0522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vuOix4E7k+byP8j7AaOlMxtPFQDYUEXW2/gGsg5rhQNOIn0QZ8SaYyMtbkTCVfWP7lcGUtcdBAsGfznrPP0PDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7583
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 2024/7/5 19:01, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> The mask we are trying to store into VTDIOTLBPageInvInfo.mask might not
> fit in an uint8_t. Use uint64_t to avoid overflows

Per the below code, it can overflow as am can be larger than 8 according
to the CH 6.5.2.3 IOTLB Invalidate. And you may want a fix tag as well.

info.mask = ~((1 << am) - 1);

CH 6.5.2.3 IOTLB Invalidate

Address Mask (AM): For page-selective-within-domain invalidations, the 
Address Mask specifies
the number of low order bits of the ADDR field that must be masked for the 
invalidation operation.
This field enables software to request invalidation of contiguous mappings 
for size-aligned
regions. Refer to Table 19 for encodings of this field. When invalidating a 
large-page translation,
software must use the appropriate Address Mask value (0 for 4KByte page, 9 
for 2-MByte page,
and 18 for 1-GByte page). Hardware implementations report the maximum 
supported address
mask value through the Capability register

> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu_internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index faea23e8d6..5f32c36943 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -436,7 +436,7 @@ struct VTDIOTLBPageInvInfo {
>       uint16_t domain_id;
>       uint32_t pasid;
>       uint64_t addr;
> -    uint8_t mask;
> +    uint64_t mask;
>   };
>   typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
>   

-- 
Regards,
Yi Liu

