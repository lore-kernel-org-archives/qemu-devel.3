Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3B2CA0ECC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 01:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjqIf-0006Iq-4Z; Thu, 29 Aug 2024 21:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1sjqId-0006IH-DB
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 21:19:39 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junjie.mao@intel.com>)
 id 1sjqIY-0005xK-9l
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 21:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1724980774; x=1756516774;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TdFSN06QIWL1ZgEd9zSLh5mhbqH3IHLfiMBnS1MxGXc=;
 b=cL+FEuTxXoZJJ93dhsoS9aK29d1Cpb1Stx5NF6Pzdv2Hc1LRT6BtVjxB
 H6IVyF+RizASf1uYxID6ldI71gE8zb2wvONfthwW1u6LcToow72lgFluA
 8IYojV64PX8mU+pCrVJf2e9LFz6SPh9ams+0AKBOlG4nUh4gIZDbTZSr4
 mvjbYwfEhEDE8bdZxo7VLz92C5CVYmXT656iHqD08ZVGYhNl+7hUegVCE
 mOt0QGMo83Q/VmBZ+ZRyny0HT/DzhJPULJ8s1coi0zc39m4zdhoYmbgj+
 j2BZVr1vGXt1O88DPJLuO0wkwZYjIV+HCYmahBq9pqhiLqAlpBI1K82iW A==;
X-CSE-ConnectionGUID: HXmjFOJpQviNzf7aQF+uaQ==
X-CSE-MsgGUID: mih6PrTJTWuOFa7ZbK/1tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23776017"
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; d="scan'208";a="23776017"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2024 18:19:30 -0700
X-CSE-ConnectionGUID: T1VO+i/kSqWUQ24iLRJVYQ==
X-CSE-MsgGUID: vbfEEipYSr6ux4KrpEz0lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,187,1719903600"; d="scan'208";a="63600717"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Aug 2024 18:19:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 18:19:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 29 Aug 2024 18:19:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 29 Aug 2024 18:19:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 18:19:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsF3v/YXa+3FoONlsQwSFoGldGKjVs1tzacG/9c+FiRtDcndNO8Ua2+vKVRDB+mZxCRxb7XIzXZuFBLfPYhUk/W8hOpNtkBJ9p4E3cQobytIV1gWofed2WiRiI/8J2lfJN0+64epPrHxtqM+bQVjbLop7u2pFKIhmQuS1RqTjZyMDFniDp3s3Ujfyf2McEWd3qjxH2NDwxRjojELsmJKjD6yYyqjmgqFaZCg1mqtyvtaPTX6YgkNflqSdSOOOqkcq+d+VndwJ0V1ImiGXdGgg66fsV8/jXQh5TFfSeRnNI/JdEEQBvqM9UB/fSu36OzGQ+ArBXazIx0BLjXR1Zouvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdFSN06QIWL1ZgEd9zSLh5mhbqH3IHLfiMBnS1MxGXc=;
 b=fkAc6hY/S2wr8YLPWDoW0B9s9Fjycgguwrrf6oGG7nnRa46mni1T8yTodnqViEw1c6uHXnU3QMd5AG3D7tY6OWu2exmA7NC5z9F19fne+HthbeCdhlgUe1MC4VkvP+a+vDJ8dVd/4D2jr7zsxf2dc7V5J7k4+MXYT9kS7Ki7Uz2NoHmsP3oAhKii2mPKTDojL4dAT0k9O9I98f6bKkWbNcLk6S+KF+irM1gOTsrdL/wS6gC364TXVtuFWaJ7bx+uBqAUwL8DW8DwUKKtRiCzsYLhOuJ3nHhTTYtyKs7xhmzC9D7d44wPm4hVMfv9nCzeN/BNSZYe0Xi5SPAfY+rCqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12)
 by IA1PR11MB6538.namprd11.prod.outlook.com (2603:10b6:208:3a2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 01:19:26 +0000
Received: from CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed]) by CY8PR11MB7009.namprd11.prod.outlook.com
 ([fe80::7ebc:871a:bc7f:1eed%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 01:19:26 +0000
Message-ID: <dd2ed180-3624-4981-adb7-c78e699048a7@intel.com>
Date: Fri, 30 Aug 2024 09:19:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v9 7/9] rust: add crate to expose bindings and
 interfaces
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
CC: <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, Gustavo Romero
 <gustavo.romero@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, "Zhao
 Liu" <zhao1.liu@intel.com>
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-7-35579191f17c@linaro.org>
 <871q284wxk.fsf@draig.linaro.org>
Content-Language: en-US
From: Junjie Mao <junjie.mao@intel.com>
In-Reply-To: <871q284wxk.fsf@draig.linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To CY8PR11MB7009.namprd11.prod.outlook.com
 (2603:10b6:930:57::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7009:EE_|IA1PR11MB6538:EE_
X-MS-Office365-Filtering-Correlation-Id: 73de5a3b-46e6-4033-0920-08dcc891c9bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1d0eERmekhUeDJGbVByS3lXVUZvdmpGbzBsMDZabmlQem83YlhaVGZVaHNC?=
 =?utf-8?B?VktIRllyTm01ZXl5b3RLelpNdys5VmI5WmIrVnBuazcyOUk5WER2QU1VQkY4?=
 =?utf-8?B?N0k0RXFYbER3dUdaY0EvbC8wZFFUbVMzd0VwVVJxbXQ0RTNPcE1ta096ckY4?=
 =?utf-8?B?RmJXdUd3MWk5eE9vVzZtQ2xxRTJUQWd1N1ZMZDNLZU5pbXpWaWtEaEZ4TlVN?=
 =?utf-8?B?SUVjNm1vR1dlWm9ZVWp1bEk3UXR3emZBRitZN0xCTm5jVWVxZ25LeXVFek5V?=
 =?utf-8?B?cWJjc016dm4wR2hjNGp2YkhTTjVaS1JOZ1hUekdQdzBJL0dhc3RKUnFLTDhs?=
 =?utf-8?B?M3RZYk90U3l3cGpXTVlUdFcwNnFGLzZLL0NHejl4dnB3Y1RONHRhN3VUQ1Zo?=
 =?utf-8?B?ZnJOSlVvbHBtWk1xRVhodEpvMEo3MUlraWJBcWFzQUdzN0NKRFhDUktHSDBI?=
 =?utf-8?B?RkdnVDR5QVlpMVl5WVVKdk40dGZhQmNiemVLWlh6cWNDWFpqN0dKSk44dkp5?=
 =?utf-8?B?cGowNTgrSEsxRlZ5RkhHQlFSRkJwdVMxOThjc2pzRmhmSVpsTzJUTDZLaHlH?=
 =?utf-8?B?aE5uUUNxQ05LSXdDOUM4Zjl3aTR6SmNnWnUrWDlSblAwNDVCeGpZb1BCYzlM?=
 =?utf-8?B?TE0xK05tbFZEVXdNaU1XTXQ1VUNxaWR3MWhzZ0p2TTdReGFDWlhjV1RHY0Rv?=
 =?utf-8?B?QnZNcFp2bTVETDNtOEt2VFlYRGgwd1lSK29WSW0xQXpsTU93MEs4cmJBNlg0?=
 =?utf-8?B?Y2o5anZzcVNmZG03WkxMU2tnWFFqdGwyVjlpNFdvbTA1cUdzMTFqRGkxM0E0?=
 =?utf-8?B?bGVxK0NTblAwUithNXhqVEwxYVNuYkZQemFKb09ZNTZrTHZybHdRbnhMRUtH?=
 =?utf-8?B?cWNDQk55UE1sdTllSnVHTDBFVU85WUxNWng3RzJka1ovTFlMbGxmTXVVM1Nl?=
 =?utf-8?B?d3lhSVFrRlJzTXRGSGM1emxYVnFWd2VZVWlQMWY3QWJjbU5CSGtGZndHdmFo?=
 =?utf-8?B?bm91eGppdFp5K0laZW1IQ2tqc3djc3lwWGlhU0NsVi9RN2VYWjQvY2ZVN3VZ?=
 =?utf-8?B?YmlYQkFHOHZwbHF5WDFHRkU5YnNlaTdoOE9yS0FRQy8ySVBBelpySmFBaDd2?=
 =?utf-8?B?WlRyaFFueEhwVGlpQkFRYWkwaEN3OVBXbysxekpHeU1NUC81ZEhFTUVzMVFz?=
 =?utf-8?B?UHpRYStwSjhnNWZzY29LM1RKZVZOcVBuWTQycUs5R25JWmFWaC80N0NmUDFC?=
 =?utf-8?B?M1czL2lnOVl0MFU4Sk50NVlJM1pmOUtJY2NUbXZNUUFZOVRCSTIwTjV1Z0ZB?=
 =?utf-8?B?a2VYZTd3aDZZb3Z6eEtoUW9WdCtmS1hGMk9VdzMrdWk4UXFNeWZQTC8yTVUv?=
 =?utf-8?B?TU9ZdlV6c3pQL29zSWtoend3YzUvaXY2UW5IcEEwR2FoeWxRZHFZcXA3WHdn?=
 =?utf-8?B?KzhCc0RsdzNsWkt3RDJOOCt1NzhMVkl6QTVSVGJOaWhsZ2NweEZETm1nekZK?=
 =?utf-8?B?cmEySWxPVzNrOWwrL3RFSWo2VmZ3eE5ObDU5VUNkVW10RVNOeTZIUHhSTTJI?=
 =?utf-8?B?aFBhMks5UXJtK3ZiMzNtMHN0bFhFN3dTL2ZrRm9XRXQ5VDNBc1BGa29GUmg5?=
 =?utf-8?B?TVhPbzVhd0RBblNNVHpiN093OWZOVU5nUHF1Yk9qelpyVzVUT3ViQXMreW5O?=
 =?utf-8?B?ZHVzaDZaWW0raXdrajV4VEVkT21XWTdHUlgrSE9ZdlcvSUF6M3NLOUI5Y25j?=
 =?utf-8?B?ODlDZkphYmlGM1N6UlFkMXJNRkF3M3VzN3ppZEQvaDJxR0pPWDNMYzN3emln?=
 =?utf-8?B?M1dSbWVEY2h6WkkzekQ4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7009.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDRuUlVIMlFKRm1acnNIdGhzY3QyWHlNT1ZwbVAzMG40R0tPaFdrQjhTNEE5?=
 =?utf-8?B?TTYrWHMwNTgxVDZ6SGI5WUVDSnlvcW1wTkVtcG1NU3A4QjVYdXlrSFhPOWJt?=
 =?utf-8?B?dHVZZHM3VlpjZGpoUUdMcHpEc1JodDZrc2ZVamZmQmM2R2pUQXdnSW9zcGNy?=
 =?utf-8?B?SS8zV1lGVVZLeWNOOWdiS0dWT1U3YVJXanlZZklGWlhyekppQ3huR2NKdk5o?=
 =?utf-8?B?Z2ltMEx2Wnd1SzErZjFNUWpZSC9DZkc5S3FHTG53YmlVT1NXSG5vV1dGQU9C?=
 =?utf-8?B?bkVIZ2dnQ0s5QklNTEpyY0NlalI2UExsWEhRQWg1OUZUVDRDc3pzeWJSMUk3?=
 =?utf-8?B?WlBlR041UTB1MUp0WXN0bDFWWmg0dmZRRWhKNmxYeWkrZ2lVZkFzbCtSdGUx?=
 =?utf-8?B?MjErWUxIMWxockFNMDN0cEFKNGpOcVhhV1RhOWtHYlhHUXQ5dndIU2RPZGI5?=
 =?utf-8?B?ZS83dFZydjVpbEs5YzdBVnV2SE1wQjl0QmZvYm1PNUt4SXZaOXowK25JNmlH?=
 =?utf-8?B?TytpTThkcXdmNFVVZTdjaEdjRGNsb3ZzNmd5ektNZ3BQdGFnbzZRODlCdWEx?=
 =?utf-8?B?WkE5bjRZMlFhNGphL0kzRmhIU29oVGtjUm5rSHRvL1NIUjIzQWtHVldmVzJ5?=
 =?utf-8?B?KzBuZkJuejhOQmNPNFkvb1Y0VWgvWkJCVlRESE53eDdqZlRmbnZYbjJoWHBi?=
 =?utf-8?B?QkltTjgxdjZieURoRkFweUpEWGtJMVZXamFORXl2Qm16WEI2dHpVN0ozdmZT?=
 =?utf-8?B?c0RZVUs2RStIMmZNc2lHN2xVWDNHSi9uSFlQT0pTcGJrQ3NWb3JIVEQ2Wnho?=
 =?utf-8?B?cFZSYm5vYWlYWUYrdk1JaDhVWlRTaGZCbVg3b0VLY3RXWDJ2aTVMeG9hV0dC?=
 =?utf-8?B?TXdnZHhQOWdFLytMaURndm5lN2RFZ2F0LzROSG9qWmRzT1RvVDV4OWlwV1BV?=
 =?utf-8?B?ak9PT1k1YnJEOHd1YVJoajZneVBid3dNWlVKK3Jkd1p5RG5JbXV3NlZQelZ0?=
 =?utf-8?B?L0FiUmRKZHNrQXZObktGNEFORTd3VktJSTZ3THhmL21lblA4MnhCU2FHbE94?=
 =?utf-8?B?OXFtbk9ZYzNjMmQrY2dlRlZRdHpTSGY5T2ZsZisvWHZuNzFEOURIdVF6dk54?=
 =?utf-8?B?T1FnR3VnQXJHMmJkNDdKamYrN2dFN1RidDE0T1NMM1Q4UCtvN1k0aDI0NjlI?=
 =?utf-8?B?ak9hVTFBOFo1djJsMFhlcEl2dUJFUjZlZ05XRGwwejNxa1FZcFNOMEhiOGtl?=
 =?utf-8?B?UGFHQ0NnV1JzQ0tFdCttRFpSM1dMRWpYRmxaRzFnbnZwNjdQalNyTjlFRDh0?=
 =?utf-8?B?aE1NNUhJbWZDRWZBWUtETnFJbElscE0raVJoQXJLYUo2WlV2OUxoYlN2M1pP?=
 =?utf-8?B?K1l1aE5EcTl3S0xyT0RHbXVsaHh1YjVZM0w2blNkNzFPa0h1Tk10ZUlYRTJr?=
 =?utf-8?B?RU5DbjZKU1Z0eTFscFpDOUVvYXNjQVl2c0VNc09qRW1DckNFVVEzTnhqaUh1?=
 =?utf-8?B?UUtsQWM2QmNiVUxmTWlpUThOR0UvS1M5c3Vzb0FqL21VSHZaOC9HWm93dDRp?=
 =?utf-8?B?Q2lvQXQ5Ym9KQjJRRWNmQ0FEMko2N3Mramh4WGowZXo5VTlBKzIwTVVRYTBM?=
 =?utf-8?B?aUxoRkFaNHVMY05ua3hsV01KeTBYOGRlNkptNjA3UmJTeHRhbVZYQXBuNlFX?=
 =?utf-8?B?TkpxTlhpWWloSlpXY3FuZ2piSDBnQUFmNzZKRmVUYUQrcnBTV2c0RHNLRGJq?=
 =?utf-8?B?aGJkd25rdmFuZnhtM3BMekd5VjZhbk9LVENiL0dhNnZoVXBpMHpkVVhhYk5Q?=
 =?utf-8?B?S3ZvMDZ0ZFUyMGVROW9oc2pvalBHUHlzRlZsdFFvUmZIRFphVTBZTHFJelJH?=
 =?utf-8?B?Uy9ZQUsveGJKcnhkc1RwaWxnaThTYldwZlh0bmhSMzBzeTRUcDdyZEs1Z203?=
 =?utf-8?B?SmMwblU2LzNmamFBUTk0WnN1NEl6SHBqbVRvWlNJWEVSbkJqRUttdTV4MVl0?=
 =?utf-8?B?VmFSVHQrVGVIbFhlWlg2R25PWGFuTnhNeVVxblhCbCtoZkJzdFhZei84Rjhs?=
 =?utf-8?B?emJQQlhXMlVJOXVoby9rcDZQamVsQ0xCaytmNDhmaG4vYjVaQUhseVRWbzM5?=
 =?utf-8?Q?IiqkliwSdajyMshfpDcTyqNqO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73de5a3b-46e6-4033-0920-08dcc891c9bb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 01:19:26.0954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/EeB1EgboUvV7Apd2Aw1kvOOsigLaqfKePKEH7LSZXZ5mmSUWtX2gNUgtYDqqo6rFDbt1iywpF5pSX8bXggRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6538
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15; envelope-from=junjie.mao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

T24gOC8yOC8yMDI0IDk6MDggUE0sIEFsZXggQmVubsOpZSB3cm90ZToNCj4gTWFub3MgUGl0c2lk
aWFuYWtpcyA8bWFub3MucGl0c2lkaWFuYWtpc0BsaW5hcm8ub3JnPiB3cml0ZXM6DQo+IA0KPj4g
QWRkIHJ1c3QvcWVtdS1hcGksIHdoaWNoIGV4cG9zZXMgcnVzdC1iaW5kZ2VuIGdlbmVyYXRlZCBG
RkkgYmluZGluZ3MgYW5kDQo+PiBwcm92aWRlcyBzb21lIGRlY2xhcmF0aW9uIG1hY3JvcyBmb3Ig
c3ltYm9scyB2aXNpYmxlIHRvIHRoZSByZXN0IG9mDQo+PiBRRU1VLg0KPiANCj4gQXMgbWVudGlv
bmVkIG9uIElSQyBJJ20gaGl0dGluZyBhIGNvbXBpbGF0aW9uIGVycm9yIHRoYXQgYmlzZWN0cyB0
byB0aGlzDQo+IGNvbW1pdDoNCj4gDQo+ICAgIFsxNDgvMTAxMF0gR2VuZXJhdGluZyBiaW5kaW5n
cyBmb3IgUnVzdCBydXN0bW9kLWJpbmRnZW4tcnVzdF93cmFwcGVyLmgNCj4gICAgRkFJTEVEOiBi
aW5kaW5ncy5ycw0KPiAgICAvaG9tZS9hbGV4Ly5jYXJnby9iaW4vYmluZGdlbiAuLi8uLi9ydXN0
L3dyYXBwZXIuaCAtLW91dHB1dCAvaG9tZS9hbGV4L2xzcmMvcWVtdS5naXQvYnVpbGRzL3J1c3Qv
YmluZGluZ3MucnMgLS1kaXNhYmxlLWhlYWRlci1jb21tZW50IC0tcmF3LWxpbmUgJy8vIEBnZW5l
cmF0ZWQnIC0tY3R5cGVzLXByZWZpeCBjb3JlOjpmZmkgLS1mb3JtYXR0ZXIgcnVzdGZtdCAtLWdl
bmVyYXRlLWJsb2NrIC0tZ2VuZXJhdGUtY3N0ciAtLWltcGwtZGVidWcgLS1tZXJnZS1leHRlcm4t
YmxvY2tzIC0tbm8tZG9jLWNvbW1lbnRzIC0tdXNlLWNvcmUgLS13aXRoLWRlcml2ZS1kZWZhdWx0
IC0tYWxsb3dsaXN0LWZpbGUgJy9ob21lL2FsZXgvbHNyYy9xZW11LmdpdC9pbmNsdWRlLy4qJyAt
LWFsbG93bGlzdC1maWxlICcvaG9tZS9hbGV4L2xzcmMvcWVtdS5naXQvLionIC0tYWxsb3dsaXN0
LWZpbGUgJy9ob21lL2FsZXgvbHNyYy9xZW11LmdpdC9idWlsZHMvcnVzdC8uKicgLS0gLUkvaG9t
ZS9hbGV4L2xzcmMvcWVtdS5naXQvLiAtSS9ob21lL2FsZXgvbHNyYy9xZW11LmdpdC9idWlsZHMv
cnVzdC8uIC1JL2hvbWUvYWxleC9sc3JjL3FlbXUuZ2l0L2luY2x1ZGUgLUkvaG9tZS9hbGV4L2xz
cmMvcWVtdS5naXQvYnVpbGRzL3J1c3QvaW5jbHVkZSAtSS91c3IvaW5jbHVkZS9jYXBzdG9uZSAt
SS91c3IvaW5jbHVkZS9wMTEta2l0LTEgLUkvdXNyL2luY2x1ZGUvcGl4bWFuLTEgLUkvdXNyL2lu
Y2x1ZGUvbGlicG5nMTYgLUkvdXNyL2luY2x1ZGUvc3BpY2Utc2VydmVyIC1JL3Vzci9pbmNsdWRl
L3NwaWNlLTEgLUkvdXNyL2luY2x1ZGUvc3BpY2UtMSAtRFNUUlVDVF9JT1ZFQ19ERUZJTkVEIC1J
L3Vzci9pbmNsdWRlL2xpYnVzYi0xLjAgLUkvdXNyL2luY2x1ZGUvU0RMMiAtRF9SRUVOVFJBTlQg
LUkvdXNyL2luY2x1ZGUvZ2xpYi0yLjAgLUkvdXNyL2xpYi94ODZfNjQtbGludXgtZ251L2dsaWIt
Mi4wL2luY2x1ZGUgLXB0aHJlYWQgLUkvdXNyL2luY2x1ZGUvbGlibW91bnQgLUkvdXNyL2luY2x1
ZGUvYmxraWQgLUkvdXNyL2luY2x1ZGUvZ2lvLXVuaXgtMi4wIC1JL3Vzci9pbmNsdWRlL2dsaWIt
Mi4wIC1JL3Vzci9saWIveDg2XzY0LWxpbnV4LWdudS9nbGliLTIuMC9pbmNsdWRlIC1wdGhyZWFk
IC1JL3Vzci9pbmNsdWRlL2xpYm1vdW50IC1JL3Vzci9pbmNsdWRlL2Jsa2lkIC1JL3Vzci9pbmNs
dWRlL3NsaXJwIC1JL3Vzci9pbmNsdWRlL2dsaWItMi4wIC1JL3Vzci9saWIveDg2XzY0LWxpbnV4
LWdudS9nbGliLTIuMC9pbmNsdWRlIC1ETkNVUlNFU19XSURFQ0hBUj0xIC1EX0RFRkFVTFRfU09V
UkNFIC1EX1hPUEVOX1NPVVJDRT02MDAgLUkvdXNyL2luY2x1ZGUvZ2xpYi0yLjAgLUkvdXNyL2xp
Yi94ODZfNjQtbGludXgtZ251L2dsaWItMi4wL2luY2x1ZGUgLUkvdXNyL2luY2x1ZGUvZ3RrLTMu
MCAtSS91c3IvaW5jbHVkZS9wYW5nby0xLjAgLUkvdXNyL2luY2x1ZGUvZ2xpYi0yLjAgLUkvdXNy
L2xpYi94ODZfNjQtbGludXgtZ251L2dsaWItMi4wL2luY2x1ZGUgLUkvdXNyL2luY2x1ZGUvaGFy
ZmJ1enogLUkvdXNyL2luY2x1ZGUvZnJlZXR5cGUyIC1JL3Vzci9pbmNsdWRlL2xpYnBuZzE2IC1J
L3Vzci9pbmNsdWRlL2xpYm1vdW50IC1JL3Vzci9pbmNsdWRlL2Jsa2lkIC1JL3Vzci9pbmNsdWRl
L2ZyaWJpZGkgLUkvdXNyL2luY2x1ZGUvY2Fpcm8gLUkvdXNyL2luY2x1ZGUvcGl4bWFuLTEgLUkv
dXNyL2luY2x1ZGUvZ2RrLXBpeGJ1Zi0yLjAgLUkvdXNyL2luY2x1ZGUveDg2XzY0LWxpbnV4LWdu
dSAtSS91c3IvaW5jbHVkZS9naW8tdW5peC0yLjAgLUkvdXNyL2luY2x1ZGUvYXRrLTEuMCAtSS91
c3IvaW5jbHVkZS9hdC1zcGkyLWF0ay8yLjAgLUkvdXNyL2luY2x1ZGUvYXQtc3BpLTIuMCAtSS91
c3IvaW5jbHVkZS9kYnVzLTEuMCAtSS91c3IvbGliL3g4Nl82NC1saW51eC1nbnUvZGJ1cy0xLjAv
aW5jbHVkZSAtcHRocmVhZCAtSS91c3IvaW5jbHVkZS9ndGstMy4wIC1JL3Vzci9pbmNsdWRlL3Bh
bmdvLTEuMCAtSS91c3IvaW5jbHVkZS9nbGliLTIuMCAtSS91c3IvbGliL3g4Nl82NC1saW51eC1n
bnUvZ2xpYi0yLjAvaW5jbHVkZSAtSS91c3IvaW5jbHVkZS9oYXJmYnV6eiAtSS91c3IvaW5jbHVk
ZS9mcmVldHlwZTIgLUkvdXNyL2luY2x1ZGUvbGlicG5nMTYgLUkvdXNyL2luY2x1ZGUvbGlibW91
bnQgLUkvdXNyL2luY2x1ZGUvYmxraWQgLUkvdXNyL2luY2x1ZGUvZnJpYmlkaSAtSS91c3IvaW5j
bHVkZS9jYWlybyAtSS91c3IvaW5jbHVkZS9waXhtYW4tMSAtSS91c3IvaW5jbHVkZS9nZGstcGl4
YnVmLTIuMCAtSS91c3IvaW5jbHVkZS94ODZfNjQtbGludXgtZ251IC1JL3Vzci9pbmNsdWRlL2dp
by11bml4LTIuMCAtSS91c3IvaW5jbHVkZS9hdGstMS4wIC1JL3Vzci9pbmNsdWRlL2F0LXNwaTIt
YXRrLzIuMCAtSS91c3IvaW5jbHVkZS9hdC1zcGktMi4wIC1JL3Vzci9pbmNsdWRlL2RidXMtMS4w
IC1JL3Vzci9saWIveDg2XzY0LWxpbnV4LWdudS9kYnVzLTEuMC9pbmNsdWRlIC1wdGhyZWFkIC1J
L3Vzci9pbmNsdWRlL3Z0ZS0yLjkxIC1JL3Vzci9pbmNsdWRlL2dsaWItMi4wIC1JL3Vzci9saWIv
eDg2XzY0LWxpbnV4LWdudS9nbGliLTIuMC9pbmNsdWRlIC1JL3Vzci9pbmNsdWRlL2xpYm1vdW50
IC1JL3Vzci9pbmNsdWRlL2Jsa2lkIC1JL3Vzci9pbmNsdWRlL3BhbmdvLTEuMCAtSS91c3IvaW5j
bHVkZS9oYXJmYnV6eiAtSS91c3IvaW5jbHVkZS9mcmVldHlwZTIgLUkvdXNyL2luY2x1ZGUvbGli
cG5nMTYgLUkvdXNyL2luY2x1ZGUvZnJpYmlkaSAtSS91c3IvaW5jbHVkZS9jYWlybyAtSS91c3Iv
aW5jbHVkZS9waXhtYW4tMSAtSS91c3IvaW5jbHVkZS9ndGstMy4wIC1JL3Vzci9pbmNsdWRlL2dk
ay1waXhidWYtMi4wIC1JL3Vzci9pbmNsdWRlL3g4Nl82NC1saW51eC1nbnUgLUkvdXNyL2luY2x1
ZGUvZ2lvLXVuaXgtMi4wIC1JL3Vzci9pbmNsdWRlL2F0ay0xLjAgLUkvdXNyL2luY2x1ZGUvYXQt
c3BpMi1hdGsvMi4wIC1JL3Vzci9pbmNsdWRlL2F0LXNwaS0yLjAgLUkvdXNyL2luY2x1ZGUvZGJ1
cy0xLjAgLUkvdXNyL2xpYi94ODZfNjQtbGludXgtZ251L2RidXMtMS4wL2luY2x1ZGUgLXB0aHJl
YWQgLUkvdXNyL2luY2x1ZGUvZ2xpYi0yLjAgLUkvdXNyL2xpYi94ODZfNjQtbGludXgtZ251L2ds
aWItMi4wL2luY2x1ZGUgLUkvdXNyL2luY2x1ZGUvc3BpY2Utc2VydmVyIC1JL3Vzci9pbmNsdWRl
L3NwaWNlLTEgLUkvdXNyL2luY2x1ZGUvY2FjYXJkIC1JL3Vzci9pbmNsdWRlL2dsaWItMi4wIC1J
L3Vzci9saWIveDg2XzY0LWxpbnV4LWdudS9nbGliLTIuMC9pbmNsdWRlIC1JL3Vzci9pbmNsdWRl
L25zcyAtSS91c3IvaW5jbHVkZS9uc3ByIC1JL3Vzci9pbmNsdWRlL1BDU0MgLXB0aHJlYWQgLURf
UkVFTlRSQU5UIC1JL3Vzci9pbmNsdWRlL3BpcGV3aXJlLTAuMyAtSS91c3IvaW5jbHVkZS9zcGEt
MC4yIC1EX1JFRU5UUkFOVCAtSS91c3IvaW5jbHVkZS9wMTEta2l0LTEgLUkvdXNyL2luY2x1ZGUv
ZnVzZTMgLUkvdXNyL2luY2x1ZGUveDg2XzY0LWxpbnV4LWdudSAtRF9GSUxFX09GRlNFVF9CSVRT
PTY0IC1EX19VU0VfRklMRV9PRkZTRVQ2NCAtRF9fVVNFX0xBUkdFRklMRTY0IC1EVVNFX1BPU0lY
X0FDTFM9MSAtSS91c3IvaW5jbHVkZS91dWlkIC1JL3Vzci9pbmNsdWRlL2dsaWItMi4wIC1JL3Vz
ci9saWIveDg2XzY0LWxpbnV4LWdudS9nbGliLTIuMC9pbmNsdWRlIC1JL3Vzci9pbmNsdWRlL3Ax
MS1raXQtMSAtSS91c3IvaW5jbHVkZS9wMTEta2l0LTEgLUkvdXNyL2luY2x1ZGUvcDExLWtpdC0x
IC1JL3Vzci9pbmNsdWRlL3AxMS1raXQtMSAtRF9HTlVfU09VUkNFIC1EX0ZJTEVfT0ZGU0VUX0JJ
VFM9NjQgLURfTEFSR0VGSUxFX1NPVVJDRSAtSS91c3IvaW5jbHVkZS9nbGliLTIuMCAtSS91c3Iv
bGliL3g4Nl82NC1saW51eC1nbnUvZ2xpYi0yLjAvaW5jbHVkZSAtc3RkPWdudTExIC1NRCAtTVEg
Li4vLi4vcnVzdC93cmFwcGVyLmggLU1GIHdyYXBwZXIuaC5kDQo+ICAgIC91c3IvaW5jbHVkZS9s
aWJ1cmluZy5oOjI5NjozOiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnbWVt
b3J5X29yZGVyX3JlbGVhc2UnDQo+ICAgIC91c3IvaW5jbHVkZS9saWJ1cmluZy5oOjEwODA6MTE6
IGVycm9yOiB1c2Ugb2YgdW5kZWNsYXJlZCBpZGVudGlmaWVyICdtZW1vcnlfb3JkZXJfYWNxdWly
ZScNCj4gICAgL3Vzci9pbmNsdWRlL2xpYnVyaW5nLmg6MTExNjo5OiBlcnJvcjogdXNlIG9mIHVu
ZGVjbGFyZWQgaWRlbnRpZmllciAnbWVtb3J5X29yZGVyX2FjcXVpcmUnDQo+ICAgIC91c3IvaW5j
bHVkZS9saWJ1cmluZy5oOjExMjU6OTogZXJyb3I6IHVzZSBvZiB1bmRlY2xhcmVkIGlkZW50aWZp
ZXIgJ21lbW9yeV9vcmRlcl9yZWxheGVkJw0KPiAgICAvdXNyL2luY2x1ZGUvbGlidXJpbmcuaDox
MTYxOjI6IGVycm9yOiB1c2Ugb2YgdW5kZWNsYXJlZCBpZGVudGlmaWVyICdtZW1vcnlfb3JkZXJf
cmVsYXhlZCcNCj4gICAgL3Vzci9pbmNsdWRlL2xpYnVyaW5nLmg6MTE5NzoxOTogZXJyb3I6IHVz
ZSBvZiB1bmRlY2xhcmVkIGlkZW50aWZpZXIgJ21lbW9yeV9vcmRlcl9hY3F1aXJlJw0KPiAgICAv
dXNyL2luY2x1ZGUvbGlidXJpbmcuaDoxMjY3OjEwOiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQg
aWRlbnRpZmllciAnbWVtb3J5X29yZGVyX3JlbGF4ZWQnDQo+ICAgIC91c3IvaW5jbHVkZS9saWJ1
cmluZy5oOjEyNjk6MTA6IGVycm9yOiB1c2Ugb2YgdW5kZWNsYXJlZCBpZGVudGlmaWVyICdtZW1v
cnlfb3JkZXJfYWNxdWlyZScNCj4gICAgL3Vzci9pbmNsdWRlL2xpYnVyaW5nLmg6MTMyMDoyOiBl
cnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnbWVtb3J5X29yZGVyX3JlbGVhc2Un
DQo+ICAgIHBhbmlja2VkIGF0IC9ob21lL2FsZXgvLmNhcmdvL3JlZ2lzdHJ5L3NyYy9pbmRleC5j
cmF0ZXMuaW8tNmYxN2QyMmJiYTE1MDAxZi9iaW5kZ2VuLWNsaS0wLjY5LjQvbWFpbi5yczo1Mjoz
NjoNCj4gICAgVW5hYmxlIHRvIGdlbmVyYXRlIGJpbmRpbmdzOiBDbGFuZ0RpYWdub3N0aWMoIi91
c3IvaW5jbHVkZS9saWJ1cmluZy5oOjI5NjozOiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRl
bnRpZmllciAnbWVtb3J5X29yZGVyX3JlbGVhc2UnXG4vdXNyL2luY2x1ZGUvbGlidXJpbmcuaDox
MDgwOjExOiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnbWVtb3J5X29yZGVy
X2FjcXVpcmUnXG4vdXNyL2luY2x1ZGUvbGlidXJpbmcuaDoxMTE2Ojk6IGVycm9yOiB1c2Ugb2Yg
dW5kZWNsYXJlZCBpZGVudGlmaWVyICdtZW1vcnlfb3JkZXJfYWNxdWlyZSdcbi91c3IvaW5jbHVk
ZS9saWJ1cmluZy5oOjExMjU6OTogZXJyb3I6IHVzZSBvZiB1bmRlY2xhcmVkIGlkZW50aWZpZXIg
J21lbW9yeV9vcmRlcl9yZWxheGVkJ1xuL3Vzci9pbmNsdWRlL2xpYnVyaW5nLmg6MTE2MToyOiBl
cnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnbWVtb3J5X29yZGVyX3JlbGF4ZWQn
XG4vdXNyL2luY2x1ZGUvbGlidXJpbmcuaDoxMTk3OjE5OiBlcnJvcjogdXNlIG9mIHVuZGVjbGFy
ZWQgaWRlbnRpZmllciAnbWVtb3J5X29yZGVyX2FjcXVpcmUnXG4vdXNyL2luY2x1ZGUvbGlidXJp
bmcuaDoxMjY3OjEwOiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnbWVtb3J5
X29yZGVyX3JlbGF4ZWQnXG4vdXNyL2luY2x1ZGUvbGlidXJpbmcuaDoxMjY5OjEwOiBlcnJvcjog
dXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnbWVtb3J5X29yZGVyX2FjcXVpcmUnXG4vdXNy
L2luY2x1ZGUvbGlidXJpbmcuaDoxMzIwOjI6IGVycm9yOiB1c2Ugb2YgdW5kZWNsYXJlZCBpZGVu
dGlmaWVyICdtZW1vcnlfb3JkZXJfcmVsZWFzZSdcbiIpDQoNClRob3NlIG1pc3NpbmcgaWRlbnRp
ZmllcnMgc2hvdWxkIGhhdmUgYmVlbiBkZWZpbmVkIGluIHN0ZGF0b21pYy5oIHdoaWNoIGlzIHBh
cnQgDQpvZiBDMTEuIFlvdSBjYW4gY2hlY2sgaWYgdGhhdCBoZWFkZXIgZXhpc3RzIHVuZGVyIHRo
ZSBkZWZhdWx0IGhlYWRlciBzZWFyY2ggDQpwYXRocyAod2hpY2ggaXMgbGlzdGVkIGJ5IGNsYW5n
IC1FIC1XcCwtdiAtKSBhbmQgd2hldGhlciB0aGF0IGZpbGUgZGVjbGFyZXMgDQp0aG9zZSBlbnVt
IGNvbnN0YW50cy4gSWYgc28sIHlvdSBjYW4gZnVydGhlciBjaGVjayB3aGV0aGVyIHRoZXJlIGlz
IGFueSANCnN0ZGF0b21pYy5oIGVsc2V3aGVyZSB0aGF0IHNoYWRvd3MgdGhlIHN0YW5kYXJkIG9u
ZS4NCg0KPiANCj4gQW5kIEkgd2Fzbid0IGFibGUgdG8gZm9yY2UgdGhlIG5ld2VyIGNsYW5nIHdp
dGg6DQo+IA0KPiAgICBlbnYgQ0xBTkdfUEFUSD0vdXNyL2Jpbi9jbGFuZy0xNSAuLi8uLi9jb25m
aWd1cmUgJy0tZGlzYWJsZS1kb2NzJyAtLXRhcmdldC1saXN0PWFhcmNoNjQtc29mdG1tdSAtLWVu
YWJsZS1ydXN0DQo+IA0KPiBTbyBpZiBjbGFuZyBpcyByZXF1aXJlZCBmb3IgYmluZGdlbiB3ZSBh
dCBsZWFzdCBuZWVkOg0KPiANCj4gICAgLSB0byBwcm9iZSBmb3IgY2xhbmcgKHNlcGFyYXRlbHkg
ZnJvbSAtLWNjKQ0KPiAgICAtIGFsbG93IHRoZSB1c2VyIHRvIG92ZXJyaWRlIHRoZSBkZWZhdWx0
DQo+ICAgIC0gcGFzcyB0aGUgY2xhbmcgd2Ugd2FudCB0byB1c2Ugc29tZWhvdyB0byBiaW5kZ2Vu
DQo+IA0KPiBCcmllZmx5IGxvb2tpbmcgYXQgdGhlIGJpbmRnZW4gY29kZSBJIHNlZToNCj4gDQo+
ICAgIGZuIG1haW4oKSB7DQo+ICAgICAgICBsZXQgb3V0X2RpciA9IFBhdGhCdWY6OmZyb20oZW52
Ojp2YXIoIk9VVF9ESVIiKS51bndyYXAoKSk7DQo+IA0KPiAgICAgICAgbGV0IG11dCBkc3QgPQ0K
PiAgICAgICAgICAgIEZpbGU6OmNyZWF0ZShQYXRoOjpuZXcoJm91dF9kaXIpLmpvaW4oImhvc3Qt
dGFyZ2V0LnR4dCIpKS51bndyYXAoKTsNCj4gICAgICAgIGRzdC53cml0ZV9hbGwoZW52Ojp2YXIo
IlRBUkdFVCIpLnVud3JhcCgpLmFzX2J5dGVzKCkpDQo+ICAgICAgICAgICAgLnVud3JhcCgpOw0K
PiANCj4gICAgICAgIC8vIE9uIGJlaGFsZiBvZiBjbGFuZ19zeXMsIHJlYnVpbGQgb3Vyc2VsdmVz
IGlmIGltcG9ydGFudCBjb25maWd1cmF0aW9uDQo+ICAgICAgICAvLyB2YXJpYWJsZXMgY2hhbmdl
LCB0byBlbnN1cmUgdGhhdCBiaW5kaW5ncyBnZXQgcmVidWlsdCBpZiB0aGUNCj4gICAgICAgIC8v
IHVuZGVybHlpbmcgbGliY2xhbmcgY2hhbmdlcy4NCj4gICAgICAgIHByaW50bG4hKCJjYXJnbzpy
ZXJ1bi1pZi1lbnYtY2hhbmdlZD1MTFZNX0NPTkZJR19QQVRIIik7DQo+ICAgICAgICBwcmludGxu
ISgiY2FyZ286cmVydW4taWYtZW52LWNoYW5nZWQ9TElCQ0xBTkdfUEFUSCIpOw0KPiAgICAgICAg
cHJpbnRsbiEoImNhcmdvOnJlcnVuLWlmLWVudi1jaGFuZ2VkPUxJQkNMQU5HX1NUQVRJQ19QQVRI
Iik7DQo+ICAgICAgICBwcmludGxuISgiY2FyZ286cmVydW4taWYtZW52LWNoYW5nZWQ9QklOREdF
Tl9FWFRSQV9DTEFOR19BUkdTIik7DQo+ICAgICAgICBwcmludGxuISgNCj4gICAgICAgICAgICAi
Y2FyZ286cmVydW4taWYtZW52LWNoYW5nZWQ9QklOREdFTl9FWFRSQV9DTEFOR19BUkdTX3t9IiwN
Cj4gICAgICAgICAgICBzdGQ6OmVudjo6dmFyKCJUQVJHRVQiKS51bndyYXAoKQ0KPiAgICAgICAg
KTsNCj4gICAgICAgIHByaW50bG4hKA0KPiAgICAgICAgICAgICJjYXJnbzpyZXJ1bi1pZi1lbnYt
Y2hhbmdlZD1CSU5ER0VOX0VYVFJBX0NMQU5HX0FSR1Nfe30iLA0KPiAgICAgICAgICAgIHN0ZDo6
ZW52Ojp2YXIoIlRBUkdFVCIpLnVud3JhcCgpLnJlcGxhY2UoJy0nLCAiXyIpDQo+ICAgICAgICAp
Ow0KPiAgICB9DQoNClRoaXMgaXMgYnVpbGQucnMgd2hpY2ggaXMgYSBidWlsZCBzY3JpcHQgaW52
b2tlZCBieSBjYXJnby4gVGhlIGVudHJ5IG9mIHRoZSANCmJpbmRnZW4gZXhlY3V0YWJsZSBpcyBp
biB0aGUgYmluZGdlbi1jbGkgY3JhdGUuDQoNCi0tLQ0KQmVzdCBSZWdhcmRzDQpKdW5qaWUgTWFv
DQoNCj4gDQo+IFNvIEkgd29uZGVyIGlmIHRoaXMgZGVwZW5kcyBvbiB3aGF0IGxpYmNsYW5nIHZl
cnNpb25zIGNhbiBiZSBmb3VuZCB3aGVuDQo+IGNhcmdvIGJ1aWxkcyBpdD8gQWx0aG91Z2ggaWYg
aXQgZG9lcyBpdCBtdXN0IGRvIHNvIGR5bmFtaWNhbGx5Og0KPiANCj4gICAgJCBsZGQgL2hvbWUv
YWxleC8uY2FyZ28vYmluL2JpbmRnZW4NCj4gICAgICAgICAgICBsaW51eC12ZHNvLnNvLjEgKDB4
MDAwMDdmN2NiNDNkODAwMCkNCj4gICAgICAgICAgICBsaWJnY2Nfcy5zby4xID0+IC9saWIveDg2
XzY0LWxpbnV4LWdudS9saWJnY2Nfcy5zby4xICgweDAwMDA3ZjdjYjQzOGMwMDApDQo+ICAgICAg
ICAgICAgbGlibS5zby42ID0+IC9saWIveDg2XzY0LWxpbnV4LWdudS9saWJtLnNvLjYgKDB4MDAw
MDdmN2NiNDJhZDAwMCkNCj4gICAgICAgICAgICBsaWJjLnNvLjYgPT4gL2xpYi94ODZfNjQtbGlu
dXgtZ251L2xpYmMuc28uNiAoMHgwMDAwN2Y3Y2IzYTFmMDAwKQ0KPiAgICAgICAgICAgIC9saWI2
NC9sZC1saW51eC14ODYtNjQuc28uMiAoMHgwMDAwN2Y3Y2I0M2RhMDAwKQ0KPiANCg==

