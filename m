Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48334CD5BA0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 08:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJSv3-0008Cj-Af; Thu, 13 Nov 2025 03:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vJSuD-0007q7-7P
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:42:13 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vJSuB-0006Q3-Ep
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763023332; x=1794559332;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aA4SZEosADGiTiaFF8jBfaTOBq5IDG7eu7D9+XFvzOA=;
 b=m74FGv98EFwVomyADDGWzzmfDFlsvet4k+6+RM/xRpi/pQeOco6JyDb7
 b1DmS2eDyzYrxPeWIdoXQhijNqwQ/mYiVzwiMlDT1X6vGKaRdJ5XWdGLw
 l7Kgdmkd85tKdrx1eYwmPJbBKqAVKC0jvosv8oOUt2n/hxtS1QI5OpOaZ
 yZW6THRjsewmeK0u4cPC/2/Ip5TU7WlNVe+VS1GhMk0dCOdv8g73o3+1B
 GzimnvuGC0aMB4AUQPqiZVBP1HSlmUjKA/5LQgCC7gfKPpkFFhvJxiX8t
 UZ0j3NR/PCLlSw86jEKDqDGsaVGoMGq9EwgPoHlVEgl34a2XgkPYD9f5T g==;
X-CSE-ConnectionGUID: NWtr1BJYRau7qkC1prw6Bg==
X-CSE-MsgGUID: ysDfnWOQTX+oRqAwKIu3Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64303353"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="64303353"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 00:42:06 -0800
X-CSE-ConnectionGUID: 5PUCB6mwR7egLqs/wLemgw==
X-CSE-MsgGUID: 6n/5Mo10QayR8hUd5HldPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="194617967"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 00:42:03 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:42:02 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 00:42:02 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.34) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:42:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWQXHeib7yc0FQTQXCqNeay6PkY4LDzGr/1VUKbeO4nuYRV/lWzertrzTzp69uJMKDhw/vKY1t7jB9GTNa1HAm12Rn/XYL+Myq6jKtP+vuKsXcY31fzaz0XfRpD2skAFtTLzkRBR3l7WnVitrR+vRbtcFGy2Z8+gK+zttHlnxGBcigSc8a6KOVHBY2hS5yxUE7OTUnZ1SFnBRkD28imJ8bvMJATIf0fLq89qyw/IWPUapCfcPF9t/5VWOgNXDwxIZneKynUJN5AIFhD+h0Hi7tLZn+ZFYA6zdNTyjZmkK+RD792neHEbulJ+c4dL7tXTkeOJ2d2pBga0GYRVwguxWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA4SZEosADGiTiaFF8jBfaTOBq5IDG7eu7D9+XFvzOA=;
 b=y5ujeOJnmzagjf2siA9Y1/ttZcs3zyfkNmDHq2oLM8FzpwMmj2fIdRFJ4DA8W/hKrorAcc76v6XTr90C6V9DopNWQmL2ZNEEv5n5X9EYiO05e3OJC7sG7NREV0+eUJrshzyctcOv2yQJHgqm7oN82qL32A+9+CqdU8v03KFNB0y6b9QX7+79Dacc+9h4MzN18k0aH1hXdszV150bHVTSxDKgy/0Wt4Kc+WMRbPN9AT4L7zueQPVgEjGrSRQl0VVu6GaJQJBihZHN9GBrNd5yt4PPDVU7HSXyPqFIEKpKDV0VBlOMndD1oQfkAU9fxGSs8MnEsbCdbEC3ZhlsEx5YWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB5926.namprd11.prod.outlook.com (2603:10b6:510:14d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 08:41:58 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 08:41:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 23/23] docs/devel: Add IOMMUFD nesting documentation
Thread-Topic: [PATCH v7 23/23] docs/devel: Add IOMMUFD nesting documentation
Thread-Index: AQHcRMKprG5y6lWO1063NtaV8Np447ThAHGAgA9hvwA=
Date: Thu, 13 Nov 2025 08:41:58 +0000
Message-ID: <IA3PR11MB91369431E4753EA41E70D83C92CDA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-24-zhenzhong.duan@intel.com>
 <923f350a-1aa0-4402-b328-fa6dd5abd530@redhat.com>
In-Reply-To: <923f350a-1aa0-4402-b328-fa6dd5abd530@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB5926:EE_
x-ms-office365-filtering-correlation-id: 6180ca7c-d1b3-4918-6da2-08de22908204
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ODNZalUzVW5CVjhMNnVzdVREOEUyM1h0eExnUEZ4VFQwckc1Z0g3d1ZSUDNa?=
 =?utf-8?B?bGVXV3NzZS9xcXRWRklEM2ZiTXUxdUVoemViZVp3TWcrSzhPRVNOQlBKdFhV?=
 =?utf-8?B?Zlg4cEV4Qys0eUVIL3pXSmo4dnA1aGgya0ZEM2ZRYUN1dmxkMWVUNHRBamEw?=
 =?utf-8?B?RlQrSnVLZk05N2IxS3ZxQnRwWW9uRGlOSUdGdlljdHlIaVMzK3lDdHQyMHRn?=
 =?utf-8?B?d2tYQlJiMHkrL2xhQ1BGbnJKdlRSVnhPbVRKbTJYc1pTWS94TVJFYU1Fd25G?=
 =?utf-8?B?cXZ6UUlOcVpmNTRPUVQycVRsNzVyS1dPeDI3SU1sM2N6aUFsWEcvZExndFhI?=
 =?utf-8?B?OGRxenFKeDNSY2sreFZPOENJMi9wWTdYNHZWTmEwakhmL01BZ2RtYWNVekNE?=
 =?utf-8?B?aHN4Vi9nbzIrRXpDemZjVWxGVEVVa2FHMWRnTW84TS8rQmROVkxjeTQrdXc1?=
 =?utf-8?B?bjFCNnhkcGdWc2xXL0JwcFRUYXNpOXNScG1ZT2ZSZ2ErV2l6cmIxT1FDa3l1?=
 =?utf-8?B?S1dOeDc4YjAyTVJkWkN3WWw5QU1rNW1od3J3THdiMUphVmZTR2E1U3kySEwy?=
 =?utf-8?B?SS8vaDErSThWcVMybmkvTnZ5YW5xL0VGK3V6UkpvT2VhQW9ScDhjRHhzVHA2?=
 =?utf-8?B?eTdoNlQvRWxRbS8wOVM4MVo2L1R4R3hDMW4yTmhBeUZEWnNZSERYcHpFN2li?=
 =?utf-8?B?cUZDaVhlejJFRnVTZlVyOTAzNHFlWTgwMU9raEh2R21PSVA2VjhCNkJ5YUtk?=
 =?utf-8?B?M3d6bndUMDdkU0Rzak1weGg3Vm1lc1FNK3MwY1h3UkNmMzJuMVdCZjh3L21y?=
 =?utf-8?B?YVcxVW9SVGl4VVNkMDdnT1YzNHlyaVEyRFFTUjEyMlo2RWVUWU1RRWV0VzlJ?=
 =?utf-8?B?RWJhdS9DSkRJTHdwR01ETmswME0xT3R4aHQ1MlNLRFpiNXhMSVViQUZRbjBW?=
 =?utf-8?B?d0kyL051NkRDZjdZc3RKbVZUOWFqeVUzd2E5ZlVWTDlVS24wbU40a0hTL3Zq?=
 =?utf-8?B?RWtlNGdmbk42K3VZQWtiMFJBOWhwSUMrZGNHS3JWaXJ3N2JUUUIwVE9FMFZG?=
 =?utf-8?B?b2Y3SjNOWFYxbWxCeU83NjlOd0VTWnR5WkdrL0xBQTdJWHF4SExTa0NPd0dQ?=
 =?utf-8?B?K2FZbFJoaXRxZllCUm5zSVFDSTU2dm5JazdHQVdWdWZhcXU4TXJpcWZ2Qng5?=
 =?utf-8?B?T1dLWlR5U3BpRGQwZ2V4WjVwRjl5K0EwYlVra3pVYnNSdmRocHc2MGlGMXRh?=
 =?utf-8?B?ZG5ZWjVaVXlKU0NSNS9kelN6NEtEb2ZrYk9yT2wrdzdabFZma1NuN0p4L0NU?=
 =?utf-8?B?aVhHK3hhYW5aSGVVS3BlbUVqSUF6TnUzaWRHcjJUS0UrRTdiaGk5MzE3dWNR?=
 =?utf-8?B?ZW04YlVHZ1ViVTM1aHJmVEhKSDBwZDVOd2xNZmwzMzc5eWpaMXBSNzd1djFv?=
 =?utf-8?B?cWJaT2lPUHNOclZBdHpnRVVXSW9ETFd5akQ1MkVwQkd5NjJTTm9WS2toelhB?=
 =?utf-8?B?dGZpNS95ZzJqYkNVNkFyeHIxN2R5bnd3S1NyU1RhZGt5V1RwTHBUWE5obmJC?=
 =?utf-8?B?TFJtSndheEhOY3ZDbEd0Tzd5d3hYakFhbXRkRzNDcjZBNWI3bEZTQlhFOUtk?=
 =?utf-8?B?RGVrcHdpcDNrUGtqSVhEZENZMk5zY3BQakdwMUpKdVpJMjhwYllhWG9ITUJU?=
 =?utf-8?B?dEhIUy9xMUJjcVJJQ0o5WjZxRm1MV1FzcVNBTFAybC9obXlrKzByemlzQ2pj?=
 =?utf-8?B?KzRxM2twamU3b1o3b0FtdmFYOUJEZzBIR2xFdHlRNUVQM254ZzQ4SmxSdGVV?=
 =?utf-8?B?ajR2b0VuZno4WHhmY1pRZUgrMi81WUEvU3RVQ0ptMlFaZ3lhU1FZUkJmWGYw?=
 =?utf-8?B?WEdVVHVEbUZKSVFpWlZ2Y0dpWHBiZ25Qck05bURVdTZMaUFHNEtpMEFDaklH?=
 =?utf-8?B?aEZTdzRRTTVxUHArTXdkK3V4K1N3TDZnNGdEd2dNUTBxSWlRQ2ppd3NMRU12?=
 =?utf-8?B?aTBwZThYSnh6NHpkRFlKclV0ZjdoQ3hQZDZsMXlDN21maHFLNjJYWU5reUZL?=
 =?utf-8?Q?Zfoxl+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODJhekRET2tZNG5oSVJ2MHBDQWs4U2tJZVRic2RFMmdPbDJoODJsMkd4N2c4?=
 =?utf-8?B?Y2VQSFc2aDA2U3lYTVhSY0FtRUF4MWNUTG1qZmNMU05rT3drN3poZmFZTnRl?=
 =?utf-8?B?a05JSU44QUQ2VGphT2puS01RVStOTENKbDFWdEtzNzA2c3ovWUptb2dsRWo2?=
 =?utf-8?B?NlVNUHJ5WXZqeUlSQWg0cDZpL3N6dDY0c2FlN1Q1N285azNIQW5uUVpDY0g0?=
 =?utf-8?B?K0I0L0ZETFY4Q3FlUkwySjYzVG00Uk5jVy9rMU0yK2xYTUx2WWFoSEE4UzVI?=
 =?utf-8?B?ckhCMXdmMGorcFRPUW5yUEN6ZmpOWDVpRk9UVzFlV3JKZDFBcElPaDJ1TGgw?=
 =?utf-8?B?bEV6THMwdzdacDBRb0NpVkZlYUpZUUpQcmoyOWF4ZTF3ay83czhNeHFzWUNp?=
 =?utf-8?B?b0VIQjNnQVBjRHhaL3ZxUVRCbCtQSy9zWkFCQjFwMzFSbzRka1VOeUJNbTJ6?=
 =?utf-8?B?Y0liUEpzQnJER01IdFRZakxzbUg2WFVMUVhCZ014Z2IyV0hwOC9NNDc5WFlT?=
 =?utf-8?B?Qll5SjRpUnVTNXU3dlQzS3ZzaEJHU01NV1NUQlNuNkVHSnFmV08ySWhiK25z?=
 =?utf-8?B?RG4rUlM0aVl4QUt0NkZOV0Y1VlJIb3BuOG41UTFVUTFuQUNUaVVQMlhKVHZU?=
 =?utf-8?B?aGNMTWRheE5OZEt2c3c1VksyNEJnVmFIU3phM3pMUmtYOGxiYVN5NEwrdGhO?=
 =?utf-8?B?cDlMdGlzRlVGWGFiWEo4MG9RcE9xaHFSQUhxOXdRVGwzb1c3cHZ1TkluOFdh?=
 =?utf-8?B?TW5Mc1dvQ0lwT3BGU29jbmFxaUhPRTF4THBPbG5URW1JZWIwb2ZIUW9uZWhJ?=
 =?utf-8?B?OW9saWdTTldLTUVwdi9jOEZDWEtESEJJUmdXMEZNUzJJNW9LYzFSNHdtblhN?=
 =?utf-8?B?S1NzS3hQWVhraTJTaFNkcmlEQ1BKSHpIRU05QzFXa2dRVkNmUXM2ME04NDR0?=
 =?utf-8?B?cXh1d1gyRFIzWnBMSGRRbFJxc2k1RHE4cEQyaGxoSGR5QnJldFBud1ZScnNJ?=
 =?utf-8?B?YjF3S2k1aSt4b0tlaWpQbEcrU2RqU0pENGxzeHVIMnNRNjJLNEd3K0s0a0VG?=
 =?utf-8?B?aklFakxqMnRBeDRKVkFKQ1RqZ3JGVlN6VmNNS0tNOFJVQUR3NFJTMlFSOVBa?=
 =?utf-8?B?TWRZek96Rjc0K2ROUVl5Qit2Q1hpVTFsVTFUSUlMVzR1ckdTL0lZMVM3WEtB?=
 =?utf-8?B?SDBEN3ErMEhrcGVUQVIvOVJjdWs5VUlZcGFJeWViajltSEdoeUpvbm5BTmg5?=
 =?utf-8?B?TG1UT1FKOEQ3d1ZOejl6bU85ZEYvQUdpVmtkZTNRdHlzQWJBb3o0Z0I2Yk1B?=
 =?utf-8?B?UkI0aUYyK0R5RUt2b0I0cytyNnJxZ1d2eC83WFRkSVp2L2NKekwzVFhQQldp?=
 =?utf-8?B?a2NMVzhwVVNFTkRJbDFvL3RBN2hEcEFaSStVU3JRUHkxMkNzUjJmTzlIbExU?=
 =?utf-8?B?Z3lqckthc0o4TnJJQnQzbWFabVk3WEgvQkZVL1BaZmlBNWw2TUtZVGV3YUtj?=
 =?utf-8?B?UWkvZ1JaSjg4a3Nad1FDaHpmeHB4YWoxUHQyK3VXTlA1UmRmYWQrZXA1U1N3?=
 =?utf-8?B?dHMycnhPTTcrNTQrU2xqc1UyY29PNU5XUEYxMVF5b0Y2SWhTanJPRm9FdXlP?=
 =?utf-8?B?bURkbWhzNTRjVGMwWnVBaCtaN01JSW1qaHBSd2tOV3BacEViM1BYUlpRY1FF?=
 =?utf-8?B?QUs2ZUFHQ2Fsd01GeWlyZUQ3bi93YjI5RCtEVFJzMUpES3BUeFR3aURlUmUx?=
 =?utf-8?B?bUFPMTdRajNldWJCUXVzWXdaZWNDcTBIQ1VnYUhQNXNNL0IxUnUrSTg3VVND?=
 =?utf-8?B?anc3ZjlwcURtRE9EQW9TWkhER3VUWGRFOHRhYjNZQzJjMjhNT3lyaXEzV0Fu?=
 =?utf-8?B?R3U3eUpiQmJSWEFuUFIxbUluY2F3NnlMZ1I0RjhFSmZiUWtRWEFrV0dERzB1?=
 =?utf-8?B?VHhTdXUrVlp0VU9LNEV5aE5MYkZOU2lQeXgxY0NVcnBTNUpreVRzeUxuc04v?=
 =?utf-8?B?NHN1K2ZaQUhuS29YeWFYREJuYXZrTWtRSmVQM052QVdHMmlMNTNjUkZJM3RC?=
 =?utf-8?B?WU5mRmY4amtIelRXSEc0MHdKWUxJd2dnSy80YWdBWEsra1RtdGJza2xUUWpx?=
 =?utf-8?Q?RYsD/eqCt8BuYeKLmLwRC3hwl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6180ca7c-d1b3-4918-6da2-08de22908204
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 08:41:58.5012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeggDQ5euYtraNLbsmsn0uDd+1k8OQvShIHSLPdj4eBugGGh2FcxcoZRlnqU4g46BBDvhMY51iVKhgPoOhSMeAbB9TinfSaX2V3DNnZW6II=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5926
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SGkgRXJpYywNCg0KQWxsIGRvbmUgZm9yIHN1Z2dlc3Rpb25zIG9uIHRoaXMgcGF0Y2ggYW5kIHBh
dGNoMjEuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBS
ZTogW1BBVENIIHY3IDIzLzIzXSBkb2NzL2RldmVsOiBBZGQgSU9NTVVGRCBuZXN0aW5nDQo+ZG9j
dW1lbnRhdGlvbg0KPg0KPlpoZW56aG9uZywNCj4NCj5PbiAxMC8yNC8yNSAxMDo0MyBBTSwgWmhl
bnpob25nIER1YW4gd3JvdGU6DQo+PiBBZGQgZG9jdW1lbnRhdGlvbiBhYm91dCB1c2luZyBJT01N
VUZEIGJhY2tlZCBWRklPIGRldmljZSB3aXRoDQo+aW50ZWxfaW9tbXUgd2l0aA0KPj4geC1mbHRz
PW9uLg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
Pg0KPj4gLS0tDQo+PiAgZG9jcy9kZXZlbC92ZmlvLWlvbW11ZmQucnN0IHwgMjUgKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2RvY3MvZGV2ZWwvdmZpby1pb21tdWZkLnJzdCBiL2RvY3MvZGV2
ZWwvdmZpby1pb21tdWZkLnJzdA0KPj4gaW5kZXggM2QxYzExZjE3NS4uZjFlNGQ5NDBlNiAxMDA2
NDQNCj4+IC0tLSBhL2RvY3MvZGV2ZWwvdmZpby1pb21tdWZkLnJzdA0KPj4gKysrIGIvZG9jcy9k
ZXZlbC92ZmlvLWlvbW11ZmQucnN0DQo+PiBAQCAtMTY0LDMgKzE2NCwyOCBAQCBSQU0gZGlzY2Fy
ZGluZyBmb3IgbWRldi4NCj4+DQo+PiAgYGB2ZmlvLWFwYGAgYW5kIGBgdmZpby1jY3dgYCBkZXZp
Y2VzIGRvbid0IGhhdmUgc2FtZSBpc3N1ZSBhcyB0aGVpciBiYWNrZW5kDQo+PiAgZGV2aWNlcyBh
cmUgYWx3YXlzIG1kZXYgYW5kIFJBTSBkaXNjYXJkaW5nIGlzIGZvcmNlIGVuYWJsZWQuDQo+PiAr
DQo+PiArVXNhZ2Ugd2l0aCBpbnRlbF9pb21tdSB3aXRoIHgtZmx0cz1vbg0KPnMvd2l0aC9mZWF0
dXJpbmcgdG8gdm9pZCByZXBldGl0aW9uPw0KPj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4+ICsNCj4+ICtPbmx5IElPTU1VRkQgYmFja2VkIFZGSU8gZGV2aWNlIGlz
IHN1cHBvcnRlZCB3aGVuIGludGVsX2lvbW11IGlzDQo+Y29uZmlndXJlZA0KPj4gK3dpdGggeC1m
bHRzPW9uLCBmb3IgbGVnYWN5IGNvbnRhaW5lciBiYWNrZWQgVkZJTyBkZXZpY2UsIGJlbG93IGVy
cm9yDQo+c2hvd3M6DQo+PiArDQo+PiArLi4gY29kZS1ibG9jazo6IG5vbmUNCj4+ICsNCj4+ICsg
ICAgcWVtdS1zeXN0ZW0teDg2XzY0OiAtZGV2aWNlIHZmaW8tcGNpLGhvc3Q9MDAwMDowMjowMC4w
OiB2ZmlvDQo+MDAwMDowMjowMC4wOiBGYWlsZWQgdG8gc2V0IHZJT01NVTogTmVlZCBJT01NVUZE
IGJhY2tlbmQgd2hlbg0KPngtZmx0cz1vbg0KPj4gKw0KPj4gK1ZGSU8gZGV2aWNlIHVuZGVyIFBD
SSBicmlkZ2UgaXMgdW5zdXBwb3J0ZWQsIHVzZSBQQ0lFIGJyaWRnZSBpZiBuZWNlc3NhcnksDQo+
PiArb3IgZWxzZSBiZWxvdyBlcnJvciBzaG93czoNCj5zL29yIGVsc2Uvb3RoZXJ3aXNlDQo+PiAr
DQo+PiArLi4gY29kZS1ibG9jazo6IG5vbmUNCj4+ICsNCj4+ICsgICAgcWVtdS1zeXN0ZW0teDg2
XzY0OiAtZGV2aWNlDQo+dmZpby1wY2ksaG9zdD0wMDAwOjAyOjAwLjAsYnVzPWJyaWRnZTEsaW9t
bXVmZD1pb21tdWZkMDogdmZpbw0KPjAwMDA6MDI6MDAuMDogRmFpbGVkIHRvIHNldCB2SU9NTVU6
IEhvc3QgZGV2aWNlIHVuZGVyIFBDSSBicmlkZ2UgaXMNCj51bnN1cHBvcnRlZCB3aGVuIHgtZmx0
cz1vbg0KPnMvdW5kZXIgUENJIGJyaWRnZS9kb3duc3RyZWFtIHRvIGEgUENJIGJyaWRnZQ0KPm1h
eSBoYXZlIGJlZW4gYmV0dGVyIEkgdGhpbmsNCj4+ICsNCj4+ICtJZiBob3N0IElPTU1VIGhhcyBF
UlJBVEFfNzcyNDE1X1NQUjE3LCBrZXhlYyBvciByZWJvb3QgZnJvbQ0KPiJpbnRlbF9pb21tdT1v
bixzbV9vbiINCj4+ICt0byAiaW50ZWxfaW9tbXU9b24sc21fb2ZmIiBpbiBndWVzdCBpcyBhbHNv
IHVuc3VwcG9ydGVkLiBDb25maWd1cmUNCj5zY2FsYWJsZSBtb2RlDQo+PiArb2ZmIGFzIGJlbG93
IGlmIGl0J3Mgbm90IG5lZWRlZCBieSBndWVzdC4NCj4+ICsNCj4+ICsuLiBjb2RlLWJsb2NrOjog
YmFzaA0KPj4gKw0KPj4gKyAgICAtZGV2aWNlIGludGVsLWlvbW11LHgtc2NhbGFibGUtbW9kZT1v
ZmYNCj5CZXNpZGVzDQo+UmV2aWV3ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0
LmNvbT4NCj4NCj5FcmljDQoNCg==

