Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B544C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 06:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta7jB-0008Vl-K1; Tue, 21 Jan 2025 01:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1ta7j8-0008SJ-PP
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 01:27:07 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1ta7j5-00068w-Oe
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 01:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737440824; x=1768976824;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=37ZTRPodJF4TcCGBraq1ImuG4fXuXXU4/o4RWOLjQq8=;
 b=QIindjb8taReay5Y1k2u7pxt+L92gBIQA23FHnXtVGcDo/YKm5aMZWed
 4m3W+O+miC28tSr0Je/g0X+HovI001aNHxY1BEk0D3M8Qpi1bnP7v+QT6
 Ac3G8r1TYW1ikvkNJCH+P8QlOmQWqIEleBB/m3vNivF4QiL9Gfvin9K6j
 4V4ekjn9pJNpanSJeiNirSxlf0NRax9Ujs78cVavz7ZlOZYtZN7VyIyGI
 wY/J+YvTel+x58bNhw0+WZK2g01O7kw3Q0YxPFTP6tIAAkW6+NAoz5pV3
 UR/9QOfNpu38FM3XCTvYjK/apAwNpItXbWs4g6AVcOGe2XQ279Tb0/np1 w==;
X-CSE-ConnectionGUID: TKYuUoKKQBu1qjz7Y2ILiA==
X-CSE-MsgGUID: 3C5+vrQCRHiOUj4oq/lqdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="37109704"
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; d="scan'208";a="37109704"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2025 22:27:00 -0800
X-CSE-ConnectionGUID: g/trmrs0R7GG/4blW6CTGg==
X-CSE-MsgGUID: 09XYhzRbQqKd4FXe3xFFPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,221,1732608000"; d="scan'208";a="106835258"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Jan 2025 22:26:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 20 Jan 2025 22:26:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 20 Jan 2025 22:26:56 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 20 Jan 2025 22:26:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5CZ4P6u0XXznP2Jgh3MkvIXUZzCArPpL59/cfuNRhQnX9pWhYq8eoXI2bMkuMZNJtEhP3kfGUO0phSyR0MBXCorC4qKZTUEerIih7qXdfwCuOP/cgQ2+cg4BdR4IBuJKD/BJbi4oTD6ZYtxAcyY/vGupdKDabFqJsz+Lo/mGF9UfUm8aIX11DZp7jcUkdxpKwVOPI/Hy7jpWIL37ur+V1mDrvfShKf1W6ktDZhmxP7Z7U2EFLqFVFydlb5m9YW15caRdsH8bxylP/KD+mRC+4JpzGORnmd58AHl1UwoN4f7Srt5QLoHj8LZ9ZqsENqGUQkeO6g/e5VNJDS1uMLvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5U3zePLCnLOz6EKN2u023YznU5+fHmnbIbvX3akHCU=;
 b=KDSobj4H3lkDixpNVkp7u/IydyKxgNMjSdyo15BWD5M0KyEr8LARKyVTeVCE1SueG1/bjAl0ZokiD5Wrbjnt1AcvfwvbmbVXEeoXCe2UOfb0+6+uzUOFAnPlfVWnd6QR8wIFXqbhXzOEhyYtR+1YxYn7J6XfthfKoQ3qQgV0Ijn3lz1CF/yDfcBV1fyIJEYbCKVri2zdlTL/icPb+opMOnBGbK6yh5iLa2Nan65tWTyGbzpFOU7jdkd7A0XivlAQHrdcn8Zr7cOkkjTwzIydHj7W/UZaF2fxmKSZf5p7kNXv8EEYnIGxjuNcMtt8+12I7AiYr2tEJzJ1ITIdI0MT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 SJ2PR11MB8369.namprd11.prod.outlook.com (2603:10b6:a03:53d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.17; Tue, 21 Jan
 2025 06:26:27 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 06:26:26 +0000
Message-ID: <46fcd4fd-999a-46ac-a268-e3651b94ef49@intel.com>
Date: Tue, 21 Jan 2025 14:26:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] RAMBlock: make guest_memfd require coordinate discard
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Peng Chao P <chao.p.peng@intel.com>, Gao Chao
 <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <20241213070852.106092-7-chenyi.qiang@intel.com>
 <3e23b5b0-963c-4ca1-a26b-dd5f247a3a60@redhat.com>
 <b01003cd-c3d1-4e78-b442-a8d0ff19fb04@intel.com>
 <e1141052-1dec-435b-8635-a41881fedd4c@redhat.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <e1141052-1dec-435b-8635-a41881fedd4c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|SJ2PR11MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6cedfb-9d4c-4fad-04af-08dd39e488bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0RPY2x6MU1rUEFldUlYUXlBSERQYk5GV2dFVEV0bFMvSm5hNG5lb1ZEdmxy?=
 =?utf-8?B?UGg4Tyt5MG9tUWxPQUVJS1Z4dXluNVlFalNnVWVwNHBDSTNZdmtuMDRGL3Bm?=
 =?utf-8?B?RjJIUm82RXFxbC9VVWZ5LzF6emVCOUpSWi83enhyY3Y2ZnZ3SWU0S2lBSjRE?=
 =?utf-8?B?Sm5lOVlMcjFlakpBZTYvOGxMSW1WbkxCeEREbHZtc2ZvWEZVUWRNRi9KdVFC?=
 =?utf-8?B?elk0MjEwQzYrYjVNTFVsQnFCWEMyT0IrNTFhUXVpU3VoRk1iYTlDMllYTjQ3?=
 =?utf-8?B?UkNWQWVtbEZtYkZJWEorK0VkN1lxU05laVlCN3RsbUhsTEZCNEV2WUdpcHFw?=
 =?utf-8?B?cXhzWGVqVzNJZlJ0cElvWDVYeU9lMlpadHhpaFZORjU4OUVUdkNKY01wTnlh?=
 =?utf-8?B?RzJMUFhnWWF4dCtZREZacHBvcHBKNlIreVAvd2lmRTZ6Znl4NVdoR0xEUUo2?=
 =?utf-8?B?SVpvd3NPOWJncWRNcjdmZTdtOWxVbktnSVdTRU54MlZTMWVjZE1TVldWZGJK?=
 =?utf-8?B?cVhudEV5VW5jMmowM0xxZW5hc2xlbUpqVWpLVTN2UElCb3BNRjhIWFFVL0Zq?=
 =?utf-8?B?K2lYUnpNa2owNCtJdW04YThNdk5xVTFZMTlRREpKbWN5ek9JSjRMYTlGc1pQ?=
 =?utf-8?B?aXpwdTZGaitJdlQwZ1J1MDcxWExXN0djWHU4ZWpZbnJhOFdFVkt2VURPdXJx?=
 =?utf-8?B?dU1YYkZKd29EcUl2SmxlSUNIU1hwbHJ4YnY1UWFmVHlRdVcydTJDV0FnNWYw?=
 =?utf-8?B?VFRnanBsd0h5aEc0ZkdNR0I1aW5tLytFN0lwNXBjM2tLNmsxbytMZ1VLUzhZ?=
 =?utf-8?B?b3VyWTRwVzVsMjlNWVNQYzlSUE1LeWFLT01WUTkyM1dOUlFSemlZVDhjOG9o?=
 =?utf-8?B?d04xZlpkUWRTRkNXSTlCc1hYdndBT3ZwcEJjTGZ5UFFTWXBOV0ptcE0vKytS?=
 =?utf-8?B?RE03TGhpNXo1MkRPUENpekpRVnNKT3BHbzEwQkptVTloTVNzSzkrU1A3VHIw?=
 =?utf-8?B?QWZYZ1hpT1dtT2NOSHRXYzJ5ei9uZzhib3VLRE5aakRsYWhpQXc2SjRkOTZz?=
 =?utf-8?B?SkxFeXpWVnhlMVk3TFgxUmFoZDM3WEFRUDlNRWF3eTBIa1B3NEtvVUJjcEdT?=
 =?utf-8?B?cm16S3ZMZHVvdEs5Q3ZQcG9YUFBEbkFQNDZEVCtkWmRSRDRTcExpQmlPU1NE?=
 =?utf-8?B?VldIRUhseFhnTk01UjE3cDhoaEpPZ0lHcXNONHBRMW1aUnNzZEpqVzFBU09V?=
 =?utf-8?B?SGU0Y0xiOUFCZWRVYUpXNlZ6OUtUUjBBYzZLVzc0ZFZnWVJYSWF5enBzdSsv?=
 =?utf-8?B?ekhPd21kcU81ZGpiM1VsZ2RicDBRcmhGSitBY1Y3SzJhZFdhbnEwTzNXZU5n?=
 =?utf-8?B?M3pKOXJwVGoxdWZ6ZGIwMld5WVBtMlIzb0lCYWlJT1podzBXWGh0MTNKVTky?=
 =?utf-8?B?Nk9uK3FBWnNYcVYyeWdCb3dLL1RoYTJyODVLYXU3QlJMR3NtYVBSRkIwakFm?=
 =?utf-8?B?L2E4OW11ZS9mcG1zZFFkWEFUb3dFU1BQemYzTFkrQ0NicHlsdFZGL2tPMHMz?=
 =?utf-8?B?NzlrTU1jUjV2dXhrYzBPUHI4ZlBmOG5mOTA5T3hlcGwyU01vNElwTFRJdkY5?=
 =?utf-8?B?eUFQZk1UQTVVS2ZxOVRQUDR1OEI3Z3ZsL0NOUFpmYUNwV3ZSaFcrMkRvdWpu?=
 =?utf-8?B?WHB2Y1hpVzFNTHlTTkw4L3AxRm9qTmNhQStJcHNLSHZmaEk1UGdhR1I5YkxJ?=
 =?utf-8?B?TnEzL0ZyZTA1RHpOUDQzU0pNN1JKcnMzYml0UHB0dnNIU2E1US8zcHlZWmIy?=
 =?utf-8?B?ZVhmUUs3T1U4OFNFZDNmeGdDa0ZaRlRlZHlwMVJDdzRWa1ZQeHliWEptYWFG?=
 =?utf-8?Q?XJJcgfCqUZKqT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU5oU1Z4SW50RXVwa1dobnh6OTA1RGE5MkVZZFArUml0ZjlYQnNRdTU4TU8v?=
 =?utf-8?B?azJFWkJDNC9rZFluTzV6MlBoUXRkWkdhZmQ1Z1RsbERDYktUUE90ZFVYcEo0?=
 =?utf-8?B?LzVyZHRQUld6RHFhampmN3p0UFBqYzhuOXlHSjlVcFlBS1VBeFRsYUlXTlBs?=
 =?utf-8?B?QWZxRmdwZ0xEUzJXK0ZFNnl1ZmFlN2RsUlFUUDFKVVA4V0gvZ0xJRzJ0bnhF?=
 =?utf-8?B?T3Z5WGFoN1pEeWh0dlpRTitjQ3hncUNvYUVlWjVvTzU3bGRzYWZpSXpaTk5D?=
 =?utf-8?B?aUd1Y1pTWTUrT2w3YzRzc1FvYjNiNm5aQXpidVVRdkhQS2Z1eDJtaFU5ZmFh?=
 =?utf-8?B?dHFxT2tSKzVINVppdGp2cndud011emlKbThXeDVVZTB4eC9GZENQRllnVVow?=
 =?utf-8?B?VEoxNGgrNk1Bb0NWQ2xtRzhqMjhZd0I1anRqR0pHVGs4cGNnNmJPc0o0U2xH?=
 =?utf-8?B?NE15aDd5U1RHaVlwN0lEVFl6SGhmRVF2b1dmWWhPdk1nQ3duOTR5TzkxdHhX?=
 =?utf-8?B?czBsS1NpMXMvaXNsYW1aYnF0YnRJalFyRGdOVndxNmlnQktvb3BtU1JuSE9V?=
 =?utf-8?B?emM3aEsvY3N2d096YlI4dnpuWmQ1OU1BU1lWb3BnUWpGRFlRWTNseVVKcDZC?=
 =?utf-8?B?b2RLL0ZQTjV0NVJVYkdoS1lhVGx6cDh4MlhVR29LM0pSKzd2SDZHN0tLa1VJ?=
 =?utf-8?B?VFFYK2laZmpBMlFEdVROUnRxeXl2NVVRTVZuN2VmQU5iUVhveU9vUHNlRnYw?=
 =?utf-8?B?TVBLUjRLNXRSS3FpRVZqT1VrbkI3R2hEQjNmai9xeXorMDYwVTBHUk1zeEhm?=
 =?utf-8?B?dStVT21ZQ0VZcndmS2ZrWkxabEhtY2NzbE1hNGZVN0o2SGczRUs0K1k1MHZr?=
 =?utf-8?B?Uml2VWQ0STZId1Z1bWcvTVMwU3FXbGtyRisyNXV5UnEvOEZCbS9CZWJtSDBx?=
 =?utf-8?B?dzRLQkJPbnVPU1lFUHVseGtvYkJiV2E4V3pqVG9vRk54UVQwLzhCY3RYSGJE?=
 =?utf-8?B?c2paWHdsdkk3dWtEVlliUWVDMC9YK0FucHk3elVJNkR5WWNlRGdydHZqN1Vy?=
 =?utf-8?B?OXdMUzFmRGoxVHRwZGxlZ3FiT1dlMk91MjRDQ1lDcEcrVFpkUzloNEd0amp0?=
 =?utf-8?B?YlpuWVQ4Rm9aN1Z6UHY0dGxWM0FzYmw4MFovcHVrVkxjcGJlSHdFeXNQQWwv?=
 =?utf-8?B?cVNKVTVxREdVL0luZkVPUHFubHhZakJpejZiZnFWVkh2MFZrZlgzeVRIdWlQ?=
 =?utf-8?B?c1FrT0tTZmhxYzk2UzA2enNEUWdLMDg5T3FNMVlZQXNYRFJwbGtVY3c3Nit0?=
 =?utf-8?B?eldERFN3YmNtTmtuNXNpR2h4MlZJTFpycUhJZjBNODdYbUNEN0NtSnNkcnVS?=
 =?utf-8?B?dUtOTml4NXVMaXFxREtNMnpYNUNlTlFSMnhuRGdaM2RGWDlhak9WekFMT2tx?=
 =?utf-8?B?Q204UjRZUG1MYU95WnZSenhMdytoVXJISTBtS01lOFFsNml1NU10Zmc2MGdL?=
 =?utf-8?B?eEVWRU5aZFZ0bXVEUnRiZmNLTC91UGxtaUlQdDVjV21EaFF3TkpjRWxlVVFu?=
 =?utf-8?B?cWEraVNSTlIzTWF0MlN2WmxrTU9JcFdicWEwNkIyZkQyd3pmMGJEMzZGSkdl?=
 =?utf-8?B?K0YxYmdrQkQvS0xaTVhIYU9BUGZjY1F0eDZFaEpUNHU5dy9XdUlzTDJnbEtj?=
 =?utf-8?B?Y1Z0WWNORSs0cHQrWmwrakJwQ0JxUHhIZVpKUXNEQjgrYTdKZnhYbTBLRERT?=
 =?utf-8?B?UUkzKytvSFVGcURuOHA5aHFnQnRqdlJiUTlNTW1YZ3dIZjhOZmNhaHU0Tk91?=
 =?utf-8?B?UlVWd0R1UnhQaE52c2cvM1I0OFF5aE1UM0tvT3VURjRKcmlqTmh3TVo4Mitm?=
 =?utf-8?B?VjdabjBRejR4c0RrTno2MTdNSCt3NU9NczJpNGVCU09ta256dXBvMng2WUNM?=
 =?utf-8?B?RHlDZFZnNGNJbXBRSHFhcTZ3bDNGVUZtM3VwUVpBdzAwbU9uMDkxRWhlN1RH?=
 =?utf-8?B?bVpJS0ZidU5QMTM3OUxQUmlWYWZKSTkyY09CQWwxL1RTTkU2ejZzUExnNGZy?=
 =?utf-8?B?TllwVS9zc29rYVdzWDVKOFhVVE9BNFZrTlFBczhVYjdQOGxxUWpUZU5SUGhJ?=
 =?utf-8?B?bnpjdU8vSlQxMEFPR21pUzdURkFPNWxkOXFRZFRudTNWd0QwQ2xDMjZLTmJB?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6cedfb-9d4c-4fad-04af-08dd39e488bb
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 06:26:26.8772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAauuU0OTBTtFDVDPhfvhH8xEenrai74RGh3/8JFv/uFmz7hgGZCaJ8OxN36K67MQwwFNkEowrXW0jXPiwlZKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8369
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
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



On 1/20/2025 9:11 PM, David Hildenbrand wrote:
> On 14.01.25 02:38, Chenyi Qiang wrote:
>>
>>
>> On 1/13/2025 6:56 PM, David Hildenbrand wrote:
>>> On 13.12.24 08:08, Chenyi Qiang wrote:
>>>> As guest_memfd is now managed by guest_memfd_manager with
>>>> RamDiscardManager, only block uncoordinated discard.
>>>>
>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>> ---
>>>>    system/physmem.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/system/physmem.c b/system/physmem.c
>>>> index 532182a6dd..585090b063 100644
>>>> --- a/system/physmem.c
>>>> +++ b/system/physmem.c
>>>> @@ -1872,7 +1872,7 @@ static void ram_block_add(RAMBlock *new_block,
>>>> Error **errp)
>>>>            assert(kvm_enabled());
>>>>            assert(new_block->guest_memfd < 0);
>>>>    -        ret = ram_block_discard_require(true);
>>>> +        ret = ram_block_coordinated_discard_require(true);
>>>>            if (ret < 0) {
>>>>                error_setg_errno(errp, -ret,
>>>>                                 "cannot set up private guest memory:
>>>> discard currently blocked");
>>>
>>> Would that also unlock virtio-mem by accident?
>>
>> Hum, that's true. At present, the rdm in MR can only point to one
>> instance, thus if we unlock virtio-mem and try to use it with
>> guest_memfd, it would trigger assert in
>> memory_region_set_ram_discard_manager().
>>
>> Maybe we need to add some explicit check in virtio-mem to exclude it
>> with guest_memfd at present?
> 
> Likely we should make memory_region_set_ram_discard_manager() fail if
> there is already something, and handle it in the callers?
> 
> In case of virtio-mem, we'd have to undo what we did and fail realize().
> 
> In case of CC, we'd have to bail out in a different way.
> 
> 
> Then, I think if we see new_block->guest_memfd here, that we can assume
> that any coordinated discard corresponds to only the guest_memfd one,
> not to anything else?

LGTM. In case of CC, I think we can also check the
memory_region_set_ram_discard_manager() failure, undo what we did and
make the ram_block_add() fail (set errno).

> 


