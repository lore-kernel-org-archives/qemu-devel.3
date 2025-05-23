Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80BEC3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 06:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uILmq-0004sj-Uk; Fri, 23 May 2025 02:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uILmo-0004sF-Uw
 for qemu-devel@nongnu.org; Fri, 23 May 2025 02:21:42 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uILmm-0006ZQ-Gc
 for qemu-devel@nongnu.org; Fri, 23 May 2025 02:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747981300; x=1779517300;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=p1G79nDtd3TcuENOeRC6fu0Eq4zauHeSI1jfS/83eFM=;
 b=CCnEuKNMiQ7CWDehEvdrYwGTRnPiZnK/kAYhx2amDVaXxr4Eo4TRjrhs
 IkNaH9YSLgSIGrgV3GD8ZPmbxbNRWsoizxfgaTL7xEdHx7KNYhVqeLCBf
 qNO88TmG5x8qUTouUEWi8jy1ir/8MfgPPhaIKyK76lYQVWWAHvi4Lbr9v
 QUASBMfrxKsEAaC1MxW4xEHfzL+Dl6BPCWydZAoJ07q65rUlD9AVhPyd/
 8By+VDEJeLt6B92ZjDhm746Js968P37uwZG5DMWy3lOsdRnPlK0J15Sn6
 fI+DUrKXpSgdsdZYArZKPbxC2cw+vFuvtnEnOF1D+RIcIfKN70oQf/uPd g==;
X-CSE-ConnectionGUID: wWSIIrPAQ76dH+ga2K65vg==
X-CSE-MsgGUID: z6oqcJ5wRKmGlAh2uPx93g==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61381200"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="61381200"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 23:21:31 -0700
X-CSE-ConnectionGUID: 3aeZDk9WSpu9GfJDmWlrQw==
X-CSE-MsgGUID: wssXzRB8RSaWQdNnxKrZAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; d="scan'208";a="171972870"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2025 23:21:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 23:21:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 23:21:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.54)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 23:21:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E12Pwe5jOZoovZxA4MXKqrHXkbdldCwlXf//Qrcj00WW4KEkeTehEWi/dDr74+5jHc8U6IVBOZdd3aQZgyIxaQQB8vBZM3ODeEQBJnQ78dy7iPMXNui1F088hIqFwmd3LlbN60YiTQ8tadSE9+ZVRjpDX6TettyA2RQyWywhK2kIjzuMu2Sm3RwnvF70tvLqLn2ISxbTJk1QsQuKvmk7WdQ+6EWoOJNtN0faEgL3yEQkk/ECL920sNvDZOzDsat8oWHzJFacRxPxQKmk8Lt+4U93ii4Y86TcqeCC5hhnP006SwduuxU1yqe1R+DMgUPeHgMSnYMekftnebE1rqhUQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSVZOYujSqXEgWgZkI8Z9tE30aIS3GyXB88iM3+TR/c=;
 b=LwsV2csw67Z8XRpQroz2as2jTvvN3wRTJh3rxkMwTq1XOnXlS5fWhBPQzrFa5FlBLIZfjmNhPb1AqK6eFs/ocZE/uqgMy6heTvKKkNUJ56qSTDs82PFyCyJrLBATMndm2GVmX+cixc+huQjgfGzm55cQnOH783Qfp47z/1uus0GZsmpzxVROSo/evh+9pkE6cr0M7FMuvz4ChezXYKoVkc7lYg6gZBn3jseHTsRVSYXcX2wFZeuWesCzls+UMPqg3XXCXQxXh650V/BPzngmnKs9KmiO5gJ6Rr9CY3QuvRdNswQBmrTCCmYcXqLS33MgnKCF0T+TbCIlv/Q+7Iz48Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6355.namprd11.prod.outlook.com (2603:10b6:510:1fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Fri, 23 May
 2025 06:20:42 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 06:20:42 +0000
Message-ID: <1b6e8e16-cc9f-4ac1-bf98-3d79460ba837@intel.com>
Date: Fri, 23 May 2025 14:26:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
To: Nicolin Chen <nicolinc@nvidia.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <SJ0PR11MB67446AF2F48F35D64E98B3D69299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <aC97Kn+M5/9/naY0@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <aC97Kn+M5/9/naY0@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f933fc2-7f1e-4937-4d47-08dd99c1f1fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UW1JSmxMSUQzbkt3aHhETnVob1h5aXRqRDFmQkJJU1pvTHAyVks3RHNXazVO?=
 =?utf-8?B?WkJEdHFPdkxZNW9JUjRUVEttTFM3TVhCcWhXdkdmMlllQWVtMDRMbDg4Snow?=
 =?utf-8?B?OVBZT0d0cUhJZWJqa0RUbjUwRFdXUFJ1SVByck13Mzd5andsY1N2UmpDanNL?=
 =?utf-8?B?U2I5UTZ5V2IrN0FoWXNLNmZWck1Ja2NZdC9UN2IwMVZKaDNOM3JOVXozanlL?=
 =?utf-8?B?dUM4cnR0Y1hYMTBLaE9QbG1md1Z3bVFldENTN0ZjRDBreVpuWmZDUklDem15?=
 =?utf-8?B?SWFMMm5JMFZlTWRuR0twcFdyTXFZV1ZwMXpUU01vd2JFY2VoMzBPYVdqbERJ?=
 =?utf-8?B?UU9SWXRkS2F4aGpWZ3pNaVBiS3VJczlUaUZPdkZZVGV5WlVuWnhSNTBZTVlN?=
 =?utf-8?B?NUpoT2dhcHZRSytpaEdaNng4YURuTTU1MEgyZGhzZ0hscVlGWjFvWUFTSWxk?=
 =?utf-8?B?dXlGalFWQmtodDdYbG9CbFp5a2IxMGJDelJldzBPSXMvTnRXYWJ3dXhVUFNO?=
 =?utf-8?B?ZVArRTZDaVRucG1KM1ZtakRnYXNWZUhrWEJmSjVteitGVzBaMlBpeWhSTU5M?=
 =?utf-8?B?NDZ3S3RvalpmQWdVMmdQbk02VUZLNEFsbU5qbnIweEVieHU4VmNPc2hTSE5K?=
 =?utf-8?B?ek84MDlWVk1nbElvMVVnYzZtLzgwSjhtbFU5RXlLWEJvdzA4MEtWTGlNNVdp?=
 =?utf-8?B?bVdRRUpiekliMWVLYmpSekJqY3MxRzNOdzBOTldseDJud2NUbTF3alhRQ0xh?=
 =?utf-8?B?VlY5Z0xPWlpQTDRyOFA2TXFqNWRmaE94d1VZL3hkOUZ4VEs5KzRoOWQ1YzA5?=
 =?utf-8?B?b2U3emQ3Tml2dDU3Q3JES21XcHdSMEd1QUg0RURFVUZsMFMvUkdValhzYk02?=
 =?utf-8?B?clRxMExLdE0yblc0REh1SmYrbElZYXFudGcxdUdSRnJhZUZWa0c3VlA2dTdH?=
 =?utf-8?B?VlMwNCtoYm0xOS9TUzlxMGk2VThvNUwwOGNHRnV4K0g0dWlha2I0eHFiSmdR?=
 =?utf-8?B?QWd1dXZkTE5zVDd2RDNMOGxWRWhZSEZmSnAvNDZ1bnBDUnRRNkU2STB5OVp2?=
 =?utf-8?B?OE9NbzN2M1F4QnBCaUFXa0gxNXdJZUtScE9wWWloK3BaMjN1UVp5T2Q3R3Br?=
 =?utf-8?B?c2Q4QTJjWkw2Q1B1ajhVeXB0Yi9UOHI0dnZOYngrb0xUSVZMOVFuZHdGcUgw?=
 =?utf-8?B?U2FmeFhoTEhiVk9Mc2k4WDhqY1RmSVliZFVtczJkcllFQmtGTkxGb20wbCtB?=
 =?utf-8?B?L3l4aFdqdE1iYlYxN0lkZUx1cFpoUm44MGlMbEdGZ25icVRtd3prSEFrNTZ5?=
 =?utf-8?B?RGFGWGNTK0RUUnZqRElBWUt0Z1Z3bmh5V2JkWWhHcjlXWmNKUUU2OGEzWHdo?=
 =?utf-8?B?NWhIYWRNaXQrOTc3cklCTlpGWFZHWUU3RjNFa3JhVjFSdGRTOGZ5WjRNVTky?=
 =?utf-8?B?TjV5WFJxQVhROXNqWEREY2hvN09VWnZFUlVOWDhZamx3a3RSY1ZsQ1UzclFB?=
 =?utf-8?B?aG12QlNKY0s5cmtZeGdPM1E4bzZoYk55M1FUTFkvYSsxbnk1TmUrand0Umkx?=
 =?utf-8?B?alpLaU1TYTdVQUFLMGpXM0FsazRlYWZieU5DdHZqN09WMElyVW50ZGwwMnZG?=
 =?utf-8?B?UzFuOE9weEh2Ky90U2MxZjFKaTU4NEd6N1RSTFBQbTZIcUlRNjl1YjlSOFpV?=
 =?utf-8?B?QU1DUUhNMS9yVlZFeUo0ZjI0WGQxUE1MMTgxZUF1TEZ5U085aDNRS3U5UnJX?=
 =?utf-8?B?SVhEQjRCRHBvUC9XM0t4MGxZMEoyS2lBbWh2OUp3U1Brc3B2OTB3Ti8veEV0?=
 =?utf-8?Q?2dBNI+IXBQgmmPah/F8OazAZSATc91pCPz/bc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDY2UGhnb1p6MTZBODBOSW5kODRlUG5EcUdFRWZJSmxld0Rkb2ZOMkxFZytK?=
 =?utf-8?B?OGQxZC9ORXg2STdjNTZObFRuL3d4dGxXbU9QUkpKRUxwZitTdGZacUpXYjNH?=
 =?utf-8?B?b2YwTmhweG5VRnA3eGZhNW1PRnZnVmlHRGRXdkdwcDRUZjBKT0hpMFN0VUVI?=
 =?utf-8?B?MytEUHp6NkNjRm5YelFuQTRJWTVxdlhmU01iTDQyWFdQcW9HQmFXa2lCREcx?=
 =?utf-8?B?ZEo4MGlrNlVCRE4vdDVLYmphVzBNNHpFb0t3SS9RWTdnSGZEWnF4aG82cXBK?=
 =?utf-8?B?Mlg3SSt6V0xFVHlLNDZwUjd3WTRnZU1lbWVNQ3RobUhIRG54WG5zNzBkd0dE?=
 =?utf-8?B?VW9zTXVmd1k1MUVtWk90TWxVbzlNSlViMG9uVklvOXduU0ExWFVuVHJLNXRr?=
 =?utf-8?B?eEpyTXhqeU54c0g2bWQwYVFUeDlVOFlJekhrVkNWT0NDckw5ZkFrekJDR21z?=
 =?utf-8?B?VDkzVXIreW5QZlNsZmlOYTRYbnBMZ0pJTzFhcWt2WjRPQ1FXL2JnU3JScUFa?=
 =?utf-8?B?MGVnN01OZWZMZlNmMXhJQWxBVkR5dWQwN3dtbjl1cUVtaExqSkthNDArT3d0?=
 =?utf-8?B?ZHEwU25TQVJoek1WanJqMVQ2T2d5eXBHSHovVnByQlUrWXNPVVR6ZkcxOGVV?=
 =?utf-8?B?WGxCZHZjaGtxeWN6QmdlWWFnekxPQllDSU15aXVVTDZJc01QOEl2OU9RZXJ1?=
 =?utf-8?B?dEFrY1h1TGtrenBtWmxUNDhvTmxlbmJudFZOUUJucnU0N2RWQWg2NlJiS3lo?=
 =?utf-8?B?VzVSMnNJQ2pvOXR0MS9YSjBGQ3QzU3YxS3ZIaXpYQ2QxYWl6VytBU2pyS3V2?=
 =?utf-8?B?YVcrL05aZzZPVnEvVzNWMWxBbmdqSTV0clZId2xSWmFHMDZQdndjUndaRmM2?=
 =?utf-8?B?MW1lYVRoS2YyRWFnenRxQk9vR2NJWDVVRTRmbjl6d2VDbmFpN2ZSbzU1TU9B?=
 =?utf-8?B?RW1BQTIxK1F6L3NMSldPZzZkQTZJblpqeHg5TmFkYVpGRVIrWVd1UUdhaU0z?=
 =?utf-8?B?WnFBV2JxYkhwVm9GT3VaRS9oMVR3OVRmc0h1bFhIMUdiZktPZDlHbVhlM0lo?=
 =?utf-8?B?Z2k1Si80aHpZcEduNFFISG9yc0o4UFREZ1FFblN3b2pTNE1IVUs4ZjlNMVhY?=
 =?utf-8?B?VTVXRXJnaHNsd3F2MXlJR3FoVnR0NmlDV2l5OStCVy9JREx2QmlPNk5sZTlI?=
 =?utf-8?B?M25QaHkyZXF0ZkNLTkozWnk3Y2t0bzg2dksxa2xEend6cmtHTzlzSDF2U2U1?=
 =?utf-8?B?ZGFMUFN5eFk5RmpSTFZvMzlnY3IvQTI1TmtueTVIRG41em9DUk5RNW1pMFB3?=
 =?utf-8?B?SFZVNmNzUi9maEMwclErZlZpM3pqaVVQcWhFMzRDaEJyTDlNVTdOT0M2czRF?=
 =?utf-8?B?aWVEalcvQ1Z3TWFtQmNTWEJnbGtOWWwwSXYyVGYxUmNLZEYwRkx6VHZUTmpq?=
 =?utf-8?B?RnJNUzAwTENNRnp6aEJCWEswcmM4Zmx0a2FjbXB3SmVlVWxaRnptcjNDc3VN?=
 =?utf-8?B?bDFYNUNBd1gxaExRV3JpMUl4UWNTazQvLzZBWGVLaG9PVldzODFoOWJUQmhX?=
 =?utf-8?B?ckJLSVFRZFAwWjNHaVAwd1VKdzIzYnRsZGxvRUEvQnlyYVgwWE1QUWE3djVu?=
 =?utf-8?B?WXBLUFpTNE5USmtWdUEvKzFLNFRPbVdPUmd2am9hVmFqV0RmUnhBU2NNRzJq?=
 =?utf-8?B?UVNNaWIwRXBSMDk1WnRNdHhPMDJocy9mZnZ5aDd5WDRLK1BsYS90RGRLVkRV?=
 =?utf-8?B?R0FjMWV1aUs4ajNFV2hrZnN0UklZR2dIMHc4aGx6MkNNQkZZRzgrbTRsaS8r?=
 =?utf-8?B?a1ZwMmExSmF6ckFWaUhqRWpsTy81aTFyYVRVTnBkYkRNTk4xZGZocmFJWHFx?=
 =?utf-8?B?SzlvZTBHeW5XdFVTSllXNXdET1FIWCszazBmSTdQUFJxanVjMTc5MVAzLzVM?=
 =?utf-8?B?Vlh0b3ZZN2F2V0NYaDFZZFZwQkZCYUFESnVoZHc5K1B1aEY2WW1DWjVPcEs5?=
 =?utf-8?B?WEc1ZUYxZEJDeVZGd1Y5Ty93d3BQVXBmMHE4bXMrWDJzd3pTSzYxN00yU2ly?=
 =?utf-8?B?U2hvenRWVUs5bXoyNmgvemJwVjlmNlFzUnZIUkowTHlqZ0hRSE53VytXQ3lY?=
 =?utf-8?Q?lE53hjxKvcWqimR8aiVULj1Pm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f933fc2-7f1e-4937-4d47-08dd99c1f1fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 06:20:42.8421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsxiDbZ7YS8f5LVg6g7GkDQfm63Ng1qxamVFmWi0ZUph5ZuazYHDeY+NAI/YyzYjJJYOGneaGBQmU2SH8sTKuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6355
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
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

On 2025/5/23 03:29, Nicolin Chen wrote:
> On Thu, May 22, 2025 at 06:50:42AM +0000, Duan, Zhenzhong wrote:
>>
>>
>>> -----Original Message-----
>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>> Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
>>> host
>>>
>>> On Wed, May 21, 2025 at 07:14:45PM +0800, Zhenzhong Duan wrote:
>>>> +static const MemoryListener iommufd_s2domain_memory_listener = {
>>>> +    .name = "iommufd_s2domain",
>>>> +    .priority = 1000,
>>>> +    .region_add = iommufd_listener_region_add_s2domain,
>>>> +    .region_del = iommufd_listener_region_del_s2domain,
>>>> +};
>>>
>>> Would you mind elaborating When and how vtd does all S2 mappings?
>>
>> When guest trigger pasid cache invalidation, vIOMMU will attach device
>> to stage2 page table if guest's PGTT=PT or nested page table if PGTT=Stage1.
>> All these page tables are dynamically created during attach. We don't use
>> VFIO's shadow page table. The S2 mappings are also created during attach.
> 
> OK. That I can understand.
> 
> Next question: what does VTD actually map onto the S2 page table?
> The entire guest RAM? Or just a part of that?
> 
> On ARM, the VFIO listener would capture the entire RAM, and map it
> on S2 page table. I wonder if VTD would do the same.
> 
>>> On ARM, the default vfio_memory_listener could capture the entire
>>> guest RAM and add to the address space. So what we do is basically
>>> reusing the vfio_memory_listener:
>>> https://lore.kernel.org/qemu-devel/20250311141045.66620-13-
>>> shameerali.kolothum.thodi@huawei.com/
>>>
>>> The thing is that when a VFIO device is attached to the container
>>> upon a nesting configuration, the ->get_address_space op should
>>> return the system address space as S1 nested HWPT isn't allocated
>>> yet. Then all the iommu as routines in vfio_listener_region_add()
>>> would be skipped, ending up with mapping the guest RAM in S2 HWPT
>>> correctly. Not until the S1 nested HWPT is allocated by the guest
>>> OS (after guest boots), can the ->get_address_space op return the
>>> iommu address space.
>>
>> When S1 hwpt is allocated by guest, who will notify VFIO to call
>> ->get_address_space op() again to get iommu address space?
> 
> Hmm, would you please elaborate why VFIO needs to call that again?
> 
> I can see VFIO create the MAP/UNMAP notifiers for an iommu address
> space. However, the device operating in the nested translation mode
> should go through IOMMU HW for these two:
>   - S1 page table (MAP) will be created by the guest OS
>   - S1 invalidation (UNMAP) will be issued by the guest OS, and then
>     trapped by QEMU to forward to the HWPT uAPI to the host kernel.
> 
> As you mentioned, there is no need of a shadow page table in this
> mode. What else does VT-d need from an iommu address space?
> 
> On ARM, the only reason that we shift address space, is for KVM to
> inject MSI, as it only has the gIOVA and requires the iommu address
> space to translate that to gPA. Refer to kvm_arch_fixup_msi_route()
> in target/arm/kvm.c where it calls pci_device_iommu_address_space.
> 
>>> With this address space shift, S2 mappings can be simply captured
>>> and done by vfio_memory_listener. Then, such an s2domain listener
>>> would be largely redundant.
>>
>> I didn't get how arm smmu supports switching address space, will VFIO call
>> ->get_address_space() twice, once to get system address space and the other
>> for iommu address space?
> 
> The set_iommu_device() attaches the device to an stage2 page table

hmmm. I'm not sure if this is accurate. I think this set_iommu_device
just acts as setting some handle for this particular device to the vIOMMU
side. It has not idea about what address space nor page table.

> by default, indicating that the device works in the S1 passthrough
> mode (for VTD, that's PGTT=PT) at VM creation. And this is where
> the system address space should be returned by get_address_space().
> 
> If the guest kernel sets an S1 Translate mode for the device (for
> VTD, that's PGTT=Stage1), QEMU would trap that and allocate an S1
> HWPT for device to attach. Starting from here, get_address_space()
> can return the iommu address space -- on ARM, we only need it for
> KVM to translate MSI.
> 

refer to the last reply. This seems to be different between ARM and VT-d
emulation.

-- 
Regards,
Yi Liu

