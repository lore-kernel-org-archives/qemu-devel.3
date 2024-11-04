Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DBCD111B0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 07:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7r5T-000651-GV; Mon, 04 Nov 2024 02:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7r5R-00064s-UV
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:01:17 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7r5P-0002gz-5V
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 02:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730703675; x=1762239675;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4tCweUi598HsyHVtgU6i54vttW92UpAcZhmmIdmy6/c=;
 b=EnEi54f4Qe+yCZ0O+JDoWkg9IzfzKzdcYSRgJZNQlLHApSmozQbW97md
 N1IcKduK8twvYbzy2cwFDCTbgvEmrx7MduxeMTx9mN+TEC5/VDdZOoWUT
 d8xv9i2CbZp9FzfiiiiOJw1j/UDK9mPb9XySCAcJ+ovzGYdSwBOcf+ozN
 /pH+Yni4qrCRJp/TB6oae8oltiTG1d9wRhoyslhmdbefUH+QMpGAh8c17
 CRA+YacCiC9CihJwMXv2IiRyXZayvWHt4NzP+HGnUMaLchZqeRYHD+gOp
 fnqACdTzv34vxtergHfk+bhsbZEUWjjz3J+5MhFSn21pvNg/gY5s9BOrn w==;
X-CSE-ConnectionGUID: g987lVD2QcOVPQjsQVGfZA==
X-CSE-MsgGUID: TXQZtc4CTP2RraVLNygZAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="29814454"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="29814454"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 23:01:11 -0800
X-CSE-ConnectionGUID: UziYVFAkQgizSVxfYTtXkw==
X-CSE-MsgGUID: pT/mJt4yRLq+ObICFOgSIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="83659146"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 23:01:06 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 23:01:05 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 23:01:05 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 23:01:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bzn2FFJem9PEer/PNsvOjFSFi0KVlCeiO8hI4YMPZaYw1G0S5NouJt/rpermTrzGfhhAHdxU3XlZEzx5gPS7sptMti7XgMjas8VIUMyAd/FAcXoNAgIx7MlTdXNxAaNMLNdp7qrSglM4vK8RSAQ+vnxF6p3YLfRLtAptOKGEFfmmy1VA/sxG/1XoMDBVVuSAcg3x6P9znQlTWitoP+Va7ble0+kqy1YykRy+zcJMEMEQ0cr8DywS/ANfEXR14l0eSdxXID7gskgcq74XXWtiHXT0AFVxg2gVZjVUG50BdaXxCw/g/M9C03Yv2W8PiVHOvytQtUt6vjDogW1pjQMXEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/ZN4I3yhsCzz+9R6HiBZKHIV4BRXjPD7zmQDrztvVc=;
 b=QhahCHCZokKTkDatkSCL7q0WtJtOEQisG9hokUvEpBXi/xwRyDxxXJuYR4nsVcM2JMXtUmdiKFqFbJkvBtbsns81BI6uvRFLzuP/7TNk9PGT3SerMUn/HRUPmMCHsWfI8smAdF3b8ggbgNxrNQGO3Km/F2XZ9YDdRaAV/fP4ZsJmjloSbv06J3Si2eXGM+rsshXem3l0Qo0le4lhAGElSii924posBtPtfuIXQ3WH5ruzyx+EhbBKLMHX2z6BhBK9YYR0E9mbCgeh7nhRY8DN5WUJUmiyMII4owaoH4AWemX0OY8sNRo6gFxDer4rAvGVZkaoGDeSRSVyVNsdkTfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB6875.namprd11.prod.outlook.com (2603:10b6:806:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 07:01:03 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 07:01:02 +0000
Message-ID: <121cdb54-fa7e-4f95-9468-edbd01dfc10f@intel.com>
Date: Mon, 4 Nov 2024 15:05:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/17] intel_iommu: Process PASID-based iotlb
 invalidation
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-11-zhenzhong.duan@intel.com>
 <ca5e5eed-ea6b-4e74-beaf-990ba8ca5f07@intel.com>
 <SJ0PR11MB6744981BA2E527F9F6E7959192512@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <SJ0PR11MB6744981BA2E527F9F6E7959192512@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ad9517-5730-427c-5745-08dcfc9e71dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXpjdEFzZWsvZVFpN2NCOVJlR3VyZ01WeWd4VlFsNC9wU2J4aE1wNnhJMEQw?=
 =?utf-8?B?R3I1RC85cWZHR3B4SkxrT2tsVGRta25Ld3Q4QWRxa2VtY1Z4WGhqNHBsdHpv?=
 =?utf-8?B?dllHZ2NQK3lnVElIUVI2MDJiQmlZdGNCWTgwY0NOd0JRRjRJbVo3d213TXpi?=
 =?utf-8?B?R1BLalFKaWlRdThzSjhTM1FvV1JSdTk1TlU4a3FCL0JuZnVKMEhacWRyazdW?=
 =?utf-8?B?MGErU2JCL1J1M1J2clB4d2UweHViSWxqU21MN3BrSWNJNHVCaW9QbEdURlNT?=
 =?utf-8?B?d0VrTEl1L3RRY2JmbnY2c2JodE41M0FMSElSUEFua3VSSnlmbzRTRVdENjdx?=
 =?utf-8?B?VGlPcG9jSi9GQ1VERXhPYWZRWll6YkFkNEoxUlNmR3NCV2xhWHpVNGMzZG9j?=
 =?utf-8?B?WDhia3pZd09MRWNiUXBzcVFVM21EWWJtYlZVMHQ1ZXZadFZJRVg0RmFtS3o2?=
 =?utf-8?B?bUVMWjBzV3VYYU5HTVBEa1dBN0E3ejYwek0zdHZldVlnektlS3JEOGJteGtw?=
 =?utf-8?B?R1JxY2JzVHgzclU5cU1iZ1diRGpweFAxenR2cE9aU1M2UDhXZEEyRHBIOWpo?=
 =?utf-8?B?NUpteFpyTFl4QnBsQjlack9rOVZBWW95ZWVKVVNIeWdtSmFma2wxd0pBcW9X?=
 =?utf-8?B?KzNIa2kwVWV5aWl1bHIwd0d4aWdRakZ0NHF1Q0o3VG43ZGlFOHhkVlZyU1hs?=
 =?utf-8?B?eTRaaVAxM1NwSTJTNlVuVFpDaGFBUzNydGxaMWpzQmR0NFJpZFozL0pKa0Ru?=
 =?utf-8?B?Q1BXUlZmWVhYOU5iRUlZdVpzTVhpSmZCUE1TQ3U0SStlRy9pV1g0YWJ3M3hv?=
 =?utf-8?B?T3JrTWdGUEI1WlZMbGkwOHFOZ25PVnRIU3pCQmJXczZPSW5YV2d6eTNMa3J3?=
 =?utf-8?B?OXRHcFlBZk9seVNBOVIyYWFNaFVvSVcxenN1bXlsM3J3T2VoTzdHcGZiVWNn?=
 =?utf-8?B?RGsxUEQxaEF6bTl3Z0t2WDRZcUtHNlVYQWgwSTl3ZUdZWlRCc1ZlcFhpVHQr?=
 =?utf-8?B?YlEwVC9zSzN2ckZHbVZvKyt3d2ttSGR3dEJCdmFIengvL00wOU0xK21HMjB1?=
 =?utf-8?B?L2M2cm5CU0VaYThjb29TaGJ4dFNvRzViMGZMUHNTVnYwRUhZRE9wSG5MbnA2?=
 =?utf-8?B?dFBlbnphaCtEcEFoVks1TDVRMzBoRjFVNC83Z3RWZm9qS1RwcERIYXFNUVc2?=
 =?utf-8?B?SWpkdUdXU04ydkNXdGlMWk1QUnBpTExMTEZYcjVXak5HMk9IV0lyc3FvRHkz?=
 =?utf-8?B?TGdwcWxhS2RhbUpkVTU1QVRwbURieTFPaTdOc2UyQXNhYUFhQzJZTnR1Q0Fw?=
 =?utf-8?B?dzR3bjFsNDZheDNGZ2hXUXJyUGFLUHVrY0docTFmMVVtUENEY1VUdUdpUGhj?=
 =?utf-8?B?b0djd2VQclgrUnNHYm02aUU0bkVvVzVkaGNzZDcvdEEwZHFVUjdJZi9Mb2xZ?=
 =?utf-8?B?elAycTZKYUlEVUFKTThnQXBsNFZFOTJESlJHTEU5TExJR0JVelk4cjUydUo4?=
 =?utf-8?B?cUhHRHNJUnB0Q0JsbzBRSzBtT2VHWGRnTWZxOHlnWmk0eU9SWVhiVUFIV1dw?=
 =?utf-8?B?WmZzVlVZRE5pcFJsN2lZQ2NMQzA1NVpHYndNVlZCaW1QWTlwbW9BODYxK3BY?=
 =?utf-8?B?aUJheVZFQ0M2NnNCS2l4bkloTVBZaHNCaE1rK0dYQjd2TUJQNnlTSnFSSFRV?=
 =?utf-8?B?aVlnWXFnd1FnTlphQkM1TUdjQlJvZ21TZUFqZHBObzR3WUd1UWQ3Ykp0aTlo?=
 =?utf-8?Q?yRqyGpudGGZ1+lo/7st2xvpYNFQIpp2DIyd/RGJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTRicnZXOURiczRlNU9YaFN5LzZFRHJGbUMyaG9jKzNHcXh2RWk0cnlCZmVC?=
 =?utf-8?B?WitBU1pnaklJOWM5dTVUa3ViUGhxNUFIbzZ0WnhOb1h2TkF3dTBjUU0xRHRw?=
 =?utf-8?B?VlFQU2NSMDNXOTlCWThBVitjdTFETzZlRDFOV3h3OGs2VGRSaVEzM09pQ0xk?=
 =?utf-8?B?T1h1N055dmxQUXowd2VKc2FFY1pQa25Fd3lKeXNIbzN0Q3JKakhsWUd1Nyt5?=
 =?utf-8?B?cUJoK2R6Rjd6eVdhb2JtcGRGUUJUczB3R3dPU2tXSTJvTzZvY25TRTc5T052?=
 =?utf-8?B?WGtnNXRIaXNGaGFneTc1M2ZXa3U2Qmx4V3RhRldjN2FwMEg4MmoyMmt0Q2dy?=
 =?utf-8?B?bHhOMmRjT2Zvc1lVL08xWUh6SnluSkRxUDJYZUxQSmFPWEliSVE5V3JqTHZS?=
 =?utf-8?B?Q00vYmM0YVNwaGpkMnFRcm9lNHoxR04waGxoZFlwajRmcE9sc0cxNElXMHFW?=
 =?utf-8?B?WmFlcXhadjVqYnVkcnl2UllONVk2L2M0QThuWnJaMkZSVTVQUEVUdThFbU8y?=
 =?utf-8?B?UGJZeSthcTdDK3UyLytzNVEzL0pJSVdHK3hKT1JmaWZyRmJqUWNXSEdmUU94?=
 =?utf-8?B?Y0tHMmV5Q3JoMk5kdjNJbEFrMWs5QUlCRjJOQzkrT0svNXppVWFTanlVa05o?=
 =?utf-8?B?a3gwcU00eFNTbnQ4OERWc053L0pXOG9ITHVIbSt1SXBrVVJBbUl4cW8yUHM4?=
 =?utf-8?B?NjJBRk9jaEJ6c2Q0ZWppQktWbVNGcTc4Z091UWoxODBMVGVxQXZOcXlpdm4w?=
 =?utf-8?B?ZzZ4eUVhNlhJa01leC9RVkdBdGhlenNWNExyWEpEWXpFb0gwdWFncC83ZHAz?=
 =?utf-8?B?RUhVUytPU3pZczAwVHhJSnprVExkMWs2dEM0cEtJanh5bG5vU0JJNUNUazcx?=
 =?utf-8?B?ZE1DZ1ZJTWZvcmxlL1VJRHJxL0syNDNqL2tKWERwRGZ0cVM2aFVQekxBNE52?=
 =?utf-8?B?QTFCSCtGZ1hRQWdMTFRFT0Vsd2pxWWY5MXMrOGZPR2lyMElJamRxcjAwQXBj?=
 =?utf-8?B?M25PSHQvdEJubUc5SDBGUGlCMzU4dHVLaU40SzFOU1R4SkowTkJoT0l2UjRQ?=
 =?utf-8?B?MGRMbWNtVG1HRWh0bWYzVisxcFJpMUQ1N0RLeWJqNCtWUXlIUHJqdnZLVjZl?=
 =?utf-8?B?akRjcjBna0ZlbHJzS2xtMklkcFZyUVRaQnNDU0lQaFU3RGxvTVhUdnBEek1C?=
 =?utf-8?B?eWcrMGJFV0ltR3BoYkM5dnFoUTBOQmtNK3dmZWZwTDY1OXFYZWh2ZzFqT05G?=
 =?utf-8?B?M3ZncmZCaE9Nc3hxOFhQQ1B2QVBRcVVsV2dTVmU0TUt0OWdSOHNEMzZib1JZ?=
 =?utf-8?B?Mkh2SWxrTFdlM29kWkt6SXRQRnhPbEc3T2p5SWkzdHk4ajk4d2ttNzh3UW5F?=
 =?utf-8?B?REIzUytUdjBuNHhidjNMWWw3ZHoxU0kzK0lpMERRUDJpbFg2UHRNbHlTYU9K?=
 =?utf-8?B?TmNETWV4NTdNaC9tL085dnNxTlZ3M2hKYm84djh1OUJpdVBCNHNWOEh6VE8z?=
 =?utf-8?B?dFpFclJYSzgxODRCQ25iMFgyblpzdGtNNHArRnp2VmlZNDV6K0RkdEVDTTdN?=
 =?utf-8?B?T3hHQ1RCd3VlWmlIc0xhbEorNFk2WHo4cmJUMHZwaUJrZngwcGloQWlvNGhY?=
 =?utf-8?B?cXZIcDFDRlgrMVUxL0kvalhYTUxiL2pqdGxvRkQ3RUVoMkhYQWRndWhDLzla?=
 =?utf-8?B?dXp1ODlRVWFsVWJyaXQ3WnlIRHoyN0d0UmlyYnQvRUFlWUJNczd1Q1Fod09i?=
 =?utf-8?B?ZDY3eUpMQUhxSDIwSE55WTYwYSt6VGVKUGJlL1ZBRG5KN2sxMTVYdzlwb3R6?=
 =?utf-8?B?K0hzVEpPd0xOakJsei9sN0JCWjZwMnNiTUZxcmFWcElrR1BtOERDckJpVmIz?=
 =?utf-8?B?bEgxaDA0N1FtQlZFeThEQ3k1TGd5bmJoSDl4c01yN3BGdjJXcWN0NUJCZmNQ?=
 =?utf-8?B?aTVTaEdWQXArODQ3eEYreXJ6UzNvSzNvQURlR213MEd6ZVA5dDZIYi9HV0ZN?=
 =?utf-8?B?WUs4SGJjdWhIOER2cURrRnRNRXUrNEYweVRrclExc2NIQ0phSytBRitMUENi?=
 =?utf-8?B?cWo5Mmc3YjlleFBEcWtRZVgweHI1cGU2TkY1Mk9TeFBxSWRoZHBONUVCS1hF?=
 =?utf-8?Q?YTGVBWV9O6Z6lm8d7HiUlhoc3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ad9517-5730-427c-5745-08dcfc9e71dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 07:01:02.8076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K09ah5F8jrmS+D+InqKN4OTxkJ+DctP+bLqaNsJejUsuECrRY2HEDgY1fh3bqZFLKTF015xQ0GSjFo+MsrOXfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6875
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yi.l.liu@intel.com;
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

On 2024/11/4 13:40, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, November 4, 2024 10:51 AM
>> Subject: Re: [PATCH v4 10/17] intel_iommu: Process PASID-based iotlb
>> invalidation
>>
>> On 2024/9/30 17:26, Zhenzhong Duan wrote:
>>> PASID-based iotlb (piotlb) is used during walking Intel
>>> VT-d stage-1 page table.
>>>
>>> This emulates the stage-1 page table iotlb invalidation requested
>>> by a PASID-based IOTLB Invalidate Descriptor (P_IOTLB).
>>>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
>>> Acked-by: Jason Wang <jasowang@redhat.com>
>>> ---
>>>    hw/i386/intel_iommu_internal.h |  3 +++
>>>    hw/i386/intel_iommu.c          | 45 ++++++++++++++++++++++++++++++++++
>>>    2 files changed, 48 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>>> index 4c3e75e593..20d922d600 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -453,6 +453,9 @@ typedef union VTDInvDesc VTDInvDesc;
>>>    #define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
>>>    #define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) &
>> VTD_DOMAIN_ID_MASK)
>>>    #define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
>>> +#define VTD_INV_DESC_PIOTLB_AM(val)       ((val) & 0x3fULL)
>>> +#define VTD_INV_DESC_PIOTLB_IH(val)       (((val) >> 6) & 0x1)
>>> +#define VTD_INV_DESC_PIOTLB_ADDR(val)     ((val) & ~0xfffULL)
>>>    #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
>>>    #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index 46bde1ad40..289278ce30 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -322,6 +322,28 @@ static gboolean vtd_hash_remove_by_page(gpointer
>> key, gpointer value,
>>>        return (entry->gfn & info->mask) == gfn || entry->gfn == gfn_tlb;
>>>    }
>>>
>>> +static gboolean vtd_hash_remove_by_page_piotlb(gpointer key, gpointer
>> value,
>>> +                                               gpointer user_data)
>>> +{
>>> +    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
>>> +    VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
>>> +    uint64_t gfn = (info->addr >> VTD_PAGE_SHIFT_4K) & info->mask;
>>> +    uint64_t gfn_tlb = (info->addr & entry->mask) >> VTD_PAGE_SHIFT_4K;
>>> +
>>> +    /*
>>> +     * According to spec, PASID-based-IOTLB Invalidation in page granularity
>>> +     * doesn't invalidate IOTLB entries caching second-stage (PGTT=010b)
>>> +     * or pass-through (PGTT=100b) mappings. Nested isn't supported yet,
>>> +     * so only need to check first-stage (PGTT=001b) mappings.
>>> +     */
>>> +    if (entry->pgtt != VTD_SM_PASID_ENTRY_FLT) {
>>> +        return false;
>>> +    }
>>> +
>>> +    return entry->domain_id == info->domain_id && entry->pasid == info->pasid
>> &&
>>> +           ((entry->gfn & info->mask) == gfn || entry->gfn == gfn_tlb);
>>> +}
>>> +
>>>    /* Reset all the gen of VTDAddressSpace to zero and set the gen of
>>>     * IntelIOMMUState to 1.  Must be called with IOMMU lock held.
>>>     */
>>> @@ -2884,11 +2906,30 @@ static void
>> vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>>>        }
>>>    }
>>>
>>> +static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t
>> domain_id,
>>> +                                       uint32_t pasid, hwaddr addr, uint8_t am,
>>> +                                       bool ih)
>>
>> @ih is not used, perhaps you can drop it. Seems like we don't cache paging
>> structure, hence ih can be ignored so far. Besides this, the patch looks
>> good to me.
> 
> OK, will drop it. But nesting series needs it, see below.
> I'll drop it in this series and add back in nesting series.

yep, you can add it back when it's going to be used. :)

-- 
Regards,
Yi Liu

