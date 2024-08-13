Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA4FC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 10:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdp9N-0008In-4a; Tue, 13 Aug 2024 06:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sdp9K-0008HR-Ve
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:53:10 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sdp9H-0002v9-Pp
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723546388; x=1755082388;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lWfYNDahoqs7Dy69kH4M7H8qggOI0g0fazg8aR2UH6w=;
 b=MKkvSMb6FnU7pNDmuStwe8PShZYvGRknaNPXzWJw4qQ8UNhpm2igtiAS
 p0O+gPgrkPXx88M23ZYw7/oCwykPWgG30DTY9v8l7hXmIvWAQkjz+vdZq
 v1Up9tDdH3acvjO5a0zGWt7F06l7nzjQ2vCHIeQH0VqSq1NTSb80/DIKN
 4LvPOKrsIa4urKUb4HaxdSSTu2OQd5DWY81Lq5smRMZWu8DkXBjChCHBM
 VuML+X9pBIh/4RLivnVmmoRRaP3jt4LCIzXpSzlopOD8BbH7LsHVKh3RX
 5r1ac8Ne7e8/S+eEtzyUb4nZXN9mFi36kZaKjEZlc8RaJ25yeuKZLHhYB w==;
X-CSE-ConnectionGUID: LV1Q7bHKSr2gFa+c+vDCWA==
X-CSE-MsgGUID: 8GMynP+JTESmR5GsMqL9dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32274906"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="32274906"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 03:53:00 -0700
X-CSE-ConnectionGUID: UFmBfjgcSaimCQ+w5r4mzQ==
X-CSE-MsgGUID: A+YOwoFwRZC+DuEBYHLDYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="63584486"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Aug 2024 03:52:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 03:52:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 03:52:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 03:52:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sbmw0PC+bFIv3PTGJmWA6RZmikM56eWyYOeABhYJdkCC7Z1y/MBlLxplSFwOrN6kDEFkJJfVltnjSb09w44SCUbVYDc1rfoeR9/gb8jFbXhwEVWSlfoliW8NSUPT+3vykqcjfeVvGgwQZNs2rh6/4dCK60nySytzoSPn8X4/1BGRW7PjHjOW3NI8xn7LSbTQ/UGbknu50cWwSKOopCrA7v5Bsl25Ju9A0KANtetKl5BgMkCWnjGYWYyiWVQ3HU2N2bic+NXh/fG9XSV2dTlic5/E1K29OWuQ2x+suu4OG3U6jFTCM+DUx0Xs5yCINSYcqJ6eUPUbmgQlJU/myz4+ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQ+H173KZcP6JmHuGL595WCO7U9rY23DiB64ediUEug=;
 b=fErwK+XC+gr4oSerlD3YugrSJx7hYMVanx2p7sKbBlbie8mQOpXhNViqw0jcdk6Pv0GtdaECjAGsC/k1Ptkp/ozic9Ab/x/cgBRsJigLa1GyGB6c1ejw4lc+JD1SB32BfrEPf1PrRK71yyZZnMcDHkxddnfZYguQAB8IPLzV9ss2vtJ9vs4HaMRr3qbYmkN4RzZLR+/RmyDzzkw1eZe1+xh5KptLtgYl7YsCTMRrGHPxBr457Vn7h2EzOYo1NvzjGcXX48+KyiFH5/yBPHpmcuJNTTT4jBpuK8Wa1dRKpWi6mL5VOV/OHUSZAdXH3kUFG3s747zHKszy3qHa/HrazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6379.namprd11.prod.outlook.com (2603:10b6:510:1f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Tue, 13 Aug
 2024 10:52:55 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7828.030; Tue, 13 Aug 2024
 10:52:55 +0000
Message-ID: <a2894553-cd5f-4ebc-80c6-6b33128ceefe@intel.com>
Date: Tue, 13 Aug 2024 18:57:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/17] intel_iommu: Use the latest fault reasons
 defined by spec
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240805062727.2307552-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 7880367d-e462-464d-48f4-08dcbb8615e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWFOcVJXWThRZGpjak52eXNKNDQrbDVCUlcrekNmcFFheTNmQ2ZLRks3TGsy?=
 =?utf-8?B?b2VCdkFxM0lEWU1mYk1PT1piU2l3T3JiV1NIbllGblRpZk1VVlhxcnVKeDU3?=
 =?utf-8?B?RkpKN201dDA3MXpJVUJzU05ydEVJVHpoTy9BUFhZaTBKTE1vbno2M0V6WUF6?=
 =?utf-8?B?Z0svZ2pXSGdoZ2JpVDJkUnhzdU8zSkN2aHNsUk9nSnozeHU0eGZFRWQyMlpV?=
 =?utf-8?B?d3Y0NWtXb0luN2ljOFYwY1NYQjU2dno2YmJiZ2ZvcHg4RUZFR2FhYlROQjQ1?=
 =?utf-8?B?ZkZMOTFGZTA3ZXdkSkFxekZjaFJtdU15VzZjczFnazRpdGtjU0ZuRDU0TXdz?=
 =?utf-8?B?M09VTnFqeCtYVlU2aHdTMVNWdDZtWHRPaytjVGpBSTBTWHRRWEx2NGNCR2pK?=
 =?utf-8?B?amdndHdVWXNmY2cwUFNmZ0dtWFVudnYyREV5SllWaU5sbXNKbkVWM3VONHNL?=
 =?utf-8?B?czQxVHczUFpWdmRWK0RSdVZud0ZsWE5oWEk2cFNGbVorMnBhamtNM214T2dG?=
 =?utf-8?B?bXY5WHNvRWJTWEdWUlhBU3JWSVRjVm5JN1RyVDRVMU9wOXk3cCtoeEZwMjZS?=
 =?utf-8?B?Q3NDckRMRThZSEhMSHJ4VmJuYzZ2d29DYW9rRWo2YlNDQ2hwV292c1ZxeVVz?=
 =?utf-8?B?aWNjUW8wTWxzSUZvMkVkNDBuVVBDTGFwbjhVQm1uZzBIeGdRT3lMd25ib0Ex?=
 =?utf-8?B?QWF4dDl3ZVZlcUkveTdERWlGZFhML0hpVWxMaWE3VXdMWHJvRE5qZE9ZcUdQ?=
 =?utf-8?B?MDFXNjR6cUgyN0ZSTXBGTzg5US9jZlU4RXY4eFdZUk9xMWtuYlp2QmwwejVV?=
 =?utf-8?B?eWdpMzFOdUNlVTYwODRRQzFNbW90eldQS2dJWXB0MjF0c1RSTGFxVGdiZ0dG?=
 =?utf-8?B?NjRuMWVFSUZ3WTBWMXB4MERENStsMXBqZ3Zna3ZlRmtKanV4V1NtR3cvbEs0?=
 =?utf-8?B?dmpVU3M3OVhKRE01WStVbkNNcWhHYWhUVVk4VnU2U3pWdXhWWXg5bDdON2gr?=
 =?utf-8?B?Uk03eHdRRG15ZzRRYUhsQXNxWE0vZlQva0E3S1kweXJRUFl1RFNKdjR3Wm9l?=
 =?utf-8?B?RWFGSjIvemRmeTFsSlJDVC9Na1RqVjlzSEZ4TkQ2c09pQ1VmSU1GSWk1YXVR?=
 =?utf-8?B?M2tSZkd3RW5HMGNMc2dGMmt6YzJZY3BaUEhtSjhYUGtvUVJzU1Vsb2R4ZTFZ?=
 =?utf-8?B?bFp4Q0dzYk0wZnJma0doRDFrU2lrdTlIMVpnQVNteCtvWTVpZnRUU0E1T1JY?=
 =?utf-8?B?OXg2SnpLQ1JmUldlbHJoSHErMjNqZFFVMUtQdWlUQzlrSXJuY0dld3BTc0V2?=
 =?utf-8?B?eWlZZ3czMUtWR0xUaW0vQUVJSlo1RCthVG1VT3NyWmxZNExFNkhiOXJrSG53?=
 =?utf-8?B?N3B4ZGV6cFRnWHNoQ2RoYnV6MlNLT2ZFTW5lOWRSdFByV3JBeHI2SFVEWTI3?=
 =?utf-8?B?RmlselVsMlg0aUw1REpnVVdtbWdGVEV4Q0wvaFFwejc3MGNHTTJtSnk1a2g0?=
 =?utf-8?B?U1k3eWdFd0hOZDRqZ1JMUkRSNzNOYjdhK2xVTFdxMVZVczYxYWlueU9RaVVF?=
 =?utf-8?B?cFZ6b2hzSGlSS2NrZ1U1U2kzYjBBRWlqK2J1SmxXV3dCdVpxTVhPVDkxc2NK?=
 =?utf-8?B?bmx3UUQ2TDljNHBCWmRKMW5ZQkd0QzY4c1N1SzFjQW5TSGNod0cwbmhUT0FM?=
 =?utf-8?B?SVg0Rkl3T2xOQU5PczhDd1R3dWV3ZUgyd3FrM1llSXBmOUhGUlloNmttaHdN?=
 =?utf-8?B?SUhXZ2VqZDRMUmJLeWhFRDVHVXhqM1IralQwN1BPQThRUWpINW9kaEZKL2Zh?=
 =?utf-8?B?Q251d0tiSVZJMTg1MVIyQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWlLVElZK09ZOU14b0dQTEgzYVJ4b25UeDFpdVVJV2Z3REpqZ1gycUNsSlk3?=
 =?utf-8?B?SHU0SVh0b3hldUk4ZW5wNkxkUmtuY1EyY0svd0sybzFjWmpFZHhwN0V3UU9T?=
 =?utf-8?B?WW1LRDc5QUNLUTkzQjVLbkM5OFZYWE5xdFF6WTljT0ZCSmg2UlgzaXBUQXdp?=
 =?utf-8?B?Mm5mcXkzdWJLS1FidTJxcnRjYjFvaXlrM2JVY3JvaFhMcDArNHA1MVkrckFo?=
 =?utf-8?B?dlF0QVFtRDRsdkpCUWlNRE5IR2RrTE1xOGQ1VjhMUlVLSGZHRlFYd2hnaW0w?=
 =?utf-8?B?TUJXUG4yT2RaRE5hcysyY3RCTWdCaGJadEllNlJpRWplUFpDbDI1bk5tN0h2?=
 =?utf-8?B?eExGRmFjcVlYZTJPMjR6NVRpd0dqcnhvUUpzejlHRHpSTmxDeWhPalIzTGs2?=
 =?utf-8?B?TEZoUXZLOUFnV2dHTHFjMk1QUENxR1lsSTlDaitxejJaTXdHOTU4WW03NlN3?=
 =?utf-8?B?QUV4QmxzMmErelV4Qk0vdWFxL3VhWFBXVHFFZVhPbGora201bE5jUi8vNEkz?=
 =?utf-8?B?WUJvY1dGbE5rY2ZOb2tVVDN4MThtbVJhL09VdXEwWnN5NXoyMHp5UExSUmRX?=
 =?utf-8?B?b1Y2U3ZZcWZ2SnJDck1wMmkxcFg4ci93OHF0dzFzT2ZqL2xvUE44M2xiUnZO?=
 =?utf-8?B?cUtIWkZYaXhvSjQvT0pTZnhTakN6cVU3ZE1TMllOUHZuZUhLT1BhZUl6bFh2?=
 =?utf-8?B?Q0tnQTJwS2RLdVozVk00UGtaaHZqMmViM09ZUmlrRkp5Wm5PMXZlcUl3Rzhx?=
 =?utf-8?B?RzlYbmgzWnpYWVdIOG9URHhkRTZmNUc1T2h5WHIvZEJ4VC9Iamo4dVorY3lw?=
 =?utf-8?B?ek9Ybm5TY2pNWjMxMVdPekhrd1BBd3dXbjFvYnNtTkxtd1NSOG1MVEVNTkF6?=
 =?utf-8?B?ZXVEU2Z5Y2c3ckEzMEtLUnc3Kzluemd3K0RaUjRQVlRxc1hGV1BDZStWUVpL?=
 =?utf-8?B?R3JHd0tZODVKa1R6QjdUcEFKaUF4Q21ZbVdNS0NjYUNPaU1TeUpwSDBaaGdY?=
 =?utf-8?B?dXhQbkp6T0JNaW9zbHcxVWJPYi9HalVMR0RCeEZUTE1CdU5WdTRKUUNvTUxW?=
 =?utf-8?B?alFhTXEyVENlUlZuSXg3T01EaWxxUWthMXFvV3ZUWmNpYUhqOCszdEhaSkQw?=
 =?utf-8?B?VjgrS3BLMitFYmhhQTRhbVN2UW5nWmYvZjNCZTNwWWUwdVJvRkJCUHhSYXh3?=
 =?utf-8?B?bm1pNDR5SXNMYW4zZ1JGT0NDeW1KaWI0dUJHZGlRbmx0VGloYTl5V1g3a09h?=
 =?utf-8?B?MTN0QVVJZGNDalFNajZ1RlhNMGI5MUljRStqTDRPUzhMRjYzdWxqMmtiZ3Bm?=
 =?utf-8?B?MUovc3doQ3VYeDNoN254TWVteWJoVUNHSnB4UlpCRUNSWm9ad2Z3R2hrQkhs?=
 =?utf-8?B?RVNKK1FtdC9qUDdmaDBlWTduZEdKZ3ZoWUZveWkxdmFvazlpc0ZCY084K0du?=
 =?utf-8?B?Z2kzdmVYUlZnVGFlYmZJRURINWhMT25SRWhOa2VrLytsNndnWEJNOGVPdWVo?=
 =?utf-8?B?cThaTlVNUDdoTW5yMTFVTU1HUURXbFZJV0o2SlJVd1pCd2R0UEw1VlNxZUla?=
 =?utf-8?B?cG50ZnZjOVpSbnpvb01PUkJGK0U3SzV6SmhiN2pzZHptUTZseFM2V3gzRTdm?=
 =?utf-8?B?emxXMkxDd285cytnc1RXYmZXbHlUdmtWQkxLaGplSUQzSS8xQ2kvNWpzT3Nj?=
 =?utf-8?B?dzQ2bFlPWlZoSXlCNWd6QWpJL1IxR3ZRY1hJT0trM05VMm52bkNKRTVDd011?=
 =?utf-8?B?eGpYRmJWaU4vT0pGUTlNRWptd2JhbnlQYzR6VlY4TkdzV2ZKamZDT0dIQ0s3?=
 =?utf-8?B?ZjNxWXozVTNTMUFBRStJbVk2cUFTQm8ybGVvRDRQcm5HVm01STNJRTRDdEc2?=
 =?utf-8?B?c3NuOEFEUzJPMkZNekdQZ1JBalNEMkdiQUFpa2lDRmZ3d0I5Uy94cWRjQkQ5?=
 =?utf-8?B?NXl3NWZSdjdXR0JJcGFySkFDenJUalNkZDY4bUhncVNteDhGWVRSVXlaNUs2?=
 =?utf-8?B?eng4VktYV3BTUEFFay9sRWNhK1A5MzFHTmh4NituekhMdEhtQndrUm00WGJt?=
 =?utf-8?B?UU1EOXd5MWozcThMSWh6UzBQaDViM09peDdkS3d3SUVRRkVtN0hBYzg1NmNB?=
 =?utf-8?Q?wEil8e/0zg7bMqYn+tV4z4rBs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7880367d-e462-464d-48f4-08dcbb8615e4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 10:52:55.0190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t55CXJwNkXETvHxrFX7ERfYZP70jxkm/iZC12MWhXeX2/xrty7CKOINaKmC2svqAs0uyIksbHbilT02wIqe4Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6379
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

On 2024/8/5 14:27, Zhenzhong Duan wrote:
> From: Yu Zhang <yu.c.zhang@linux.intel.com>
> 
> Spec revision 3.0 or above defines more detailed fault reasons for
> scalable mode. So introduce them into emulation code, see spec
> section 7.1.2 for details.
> 
> Note spec revision has no relation with VERSION register, Guest
> kernel should not use that register to judge what features are
> supported. Instead cap/ecap bits should be checked.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu_internal.h |  9 ++++++++-
>   hw/i386/intel_iommu.c          | 25 ++++++++++++++++---------
>   2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 5f32c36943..8fa27c7f3b 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -311,7 +311,14 @@ typedef enum VTDFaultReason {
>                                     * request while disabled */
>       VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
>   
> -    VTD_FR_PASID_TABLE_INV = 0x58,  /*Invalid PASID table entry */
> +    /* PASID directory entry access failure */
> +    VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
> +    /* The Present(P) field of pasid directory entry is 0 */
> +    VTD_FR_PASID_DIR_ENTRY_P = 0x51,
> +    VTD_FR_PASID_TABLE_ACCESS_ERR = 0x58, /* PASID table entry access failure */
> +    /* The Present(P) field of pasid table entry is 0 */
> +    VTD_FR_PASID_ENTRY_P = 0x59,
> +    VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */

how about making the comment line aligned? Either one line or two lines.
Besides this, lgtm.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>   
>       /* Output address in the interrupt address range for scalable mode */
>       VTD_FR_SM_INTERRUPT_ADDR = 0x87,
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 16d2885fcc..c52912f593 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -796,7 +796,7 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
>       addr = pasid_dir_base + index * entry_size;
>       if (dma_memory_read(&address_space_memory, addr,
>                           pdire, entry_size, MEMTXATTRS_UNSPECIFIED)) {
> -        return -VTD_FR_PASID_TABLE_INV;
> +        return -VTD_FR_PASID_DIR_ACCESS_ERR;
>       }
>   
>       pdire->val = le64_to_cpu(pdire->val);
> @@ -814,6 +814,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>                                             dma_addr_t addr,
>                                             VTDPASIDEntry *pe)
>   {
> +    uint8_t pgtt;
>       uint32_t index;
>       dma_addr_t entry_size;
>       X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
> @@ -823,7 +824,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>       addr = addr + index * entry_size;
>       if (dma_memory_read(&address_space_memory, addr,
>                           pe, entry_size, MEMTXATTRS_UNSPECIFIED)) {
> -        return -VTD_FR_PASID_TABLE_INV;
> +        return -VTD_FR_PASID_TABLE_ACCESS_ERR;
>       }
>       for (size_t i = 0; i < ARRAY_SIZE(pe->val); i++) {
>           pe->val[i] = le64_to_cpu(pe->val[i]);
> @@ -831,11 +832,13 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>   
>       /* Do translation type check */
>       if (!vtd_pe_type_check(x86_iommu, pe)) {
> -        return -VTD_FR_PASID_TABLE_INV;
> +        return -VTD_FR_PASID_TABLE_ENTRY_INV;
>       }
>   
> -    if (!vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
> -        return -VTD_FR_PASID_TABLE_INV;
> +    pgtt = VTD_PE_GET_TYPE(pe);
> +    if (pgtt == VTD_SM_PASID_ENTRY_SLT &&
> +        !vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
> +            return -VTD_FR_PASID_TABLE_ENTRY_INV;
>       }
>   
>       return 0;
> @@ -876,7 +879,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
>       }
>   
>       if (!vtd_pdire_present(&pdire)) {
> -        return -VTD_FR_PASID_TABLE_INV;
> +        return -VTD_FR_PASID_DIR_ENTRY_P;
>       }
>   
>       ret = vtd_get_pe_from_pdire(s, pasid, &pdire, pe);
> @@ -885,7 +888,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
>       }
>   
>       if (!vtd_pe_present(pe)) {
> -        return -VTD_FR_PASID_TABLE_INV;
> +        return -VTD_FR_PASID_ENTRY_P;
>       }
>   
>       return 0;
> @@ -938,7 +941,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
>       }
>   
>       if (!vtd_pdire_present(&pdire)) {
> -        return -VTD_FR_PASID_TABLE_INV;
> +        return -VTD_FR_PASID_DIR_ENTRY_P;
>       }
>   
>       /*
> @@ -1795,7 +1798,11 @@ static const bool vtd_qualified_faults[] = {
>       [VTD_FR_ROOT_ENTRY_RSVD] = false,
>       [VTD_FR_PAGING_ENTRY_RSVD] = true,
>       [VTD_FR_CONTEXT_ENTRY_TT] = true,
> -    [VTD_FR_PASID_TABLE_INV] = false,
> +    [VTD_FR_PASID_DIR_ACCESS_ERR] = false,
> +    [VTD_FR_PASID_DIR_ENTRY_P] = true,
> +    [VTD_FR_PASID_TABLE_ACCESS_ERR] = false,
> +    [VTD_FR_PASID_ENTRY_P] = true,
> +    [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
>       [VTD_FR_SM_INTERRUPT_ADDR] = true,
>       [VTD_FR_MAX] = false,
>   };

-- 
Regards,
Yi Liu

