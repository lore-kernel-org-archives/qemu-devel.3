Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91182C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 12:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seDAk-0003rA-3k; Wed, 14 Aug 2024 08:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1seDAh-0003pq-Jr
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 08:32:11 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1seDAf-0001xh-Em
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 08:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723638729; x=1755174729;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/nWrt5HBkl7fUVzbLBy2ZGm3Rx41Ejbr/0lp6ZXm1XE=;
 b=WfszE4ZEKndwkC6GbmYeG3CXAZaBKRjU3tYij7uPIenVtC0qA82RYALd
 bmOC3TBGNffSiohTH+C5kf509z7QXuXxUe2qjEtOxGBPAFmK0C99NPL6Q
 /NRiFhi59LYAYBZY2kZ75UD5Kw6/uFeB1r0h+PtyaWKYA3S/qscr2hxwO
 LnaKeHDrvuy+Xee34oTH/MDntt0pqYI8JFLLXMHZtIOoDCGnEddOgcgV8
 RIfJMAt5nUSAlGsGXwrxjizF7r4x4HPMxwqYMtCSk1ECI4OcXgVWiU50q
 IUB52vKCMaqsuyw31wcYRoTrXx3qchbrAISptWwUbg+68HrHF1qi279sD Q==;
X-CSE-ConnectionGUID: UdZlTk6cR8uEQkT2bvn+2w==
X-CSE-MsgGUID: FVHE7dSNQre5/PGcfMN0kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="24757427"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; d="scan'208";a="24757427"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 05:32:07 -0700
X-CSE-ConnectionGUID: 4GADGstZTGOwuEHoBJtH1g==
X-CSE-MsgGUID: 0WSTtjTEQdGXsgzx6ZJ3WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; d="scan'208";a="59285850"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Aug 2024 05:32:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 05:32:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 05:32:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 05:32:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2hDBC8vbpKEdRGmsLDY/gFc4uLDUzK9PeQgZQjr7iqSXHA3JoSTuiQuCz/YjW/lvzg7rFlqB8eIMeKVPAH552Cf4vFACXJ7Pn0tl7jRg7YnG/rv4BVStxcZX1I3a+fBAB97kQOSOFNFBe8wDnIlW8CEBp4ceTCoVUOaLNDzLt0ArmzggWkMcsv/PdL8DO8gytXrkfurKeuaMepgcgGd5HZ4Q59+CrRMdJRv+4GzfzvPqHAYw34O1U9gpN3Vhae+EB38NZqU8oORau+eyXjp3Ra6F3ijNWdKrBcd5EJUWp3NFEDtKaIXIKomJUGMhUAK3PvQ4dgCXpU5jzL2wZfovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vI5BnV0ubOMZZlj0VV/2J8wDz9SUX39HiJBmz41KKc=;
 b=dh2KzkrdTTgJ2N4mHZhuZo5Td09bFg8CjtG6K24ypz2xDQosnE8VYsZCOeOqGSiPMy9J6g0Sc6aRjleYM3aRMkNIN8Hu5onQGCf1R1DGffWyGC0i5e4QPOV2wlVdvEr6jOp3Y53OpYzObg4Xpw5Zjiba+fNDxKIwgVUl6dBaRg1TowNE6pCPXNecU8aBKmX1q3KUXUapJS+ZSSG34+FdwKL0cxyUEWoaswtHFxmAqiV8JrXSO7eRkS/zMo+FvN0sVqjQSbgvhgiQVrNFv1U/gTsCVTwAqJUi2c7YM6wt1v+70fwJJuFsyJYAHNg1d5rRgLfHndD94O9VYv2AzY2KAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN2PR11MB4759.namprd11.prod.outlook.com (2603:10b6:208:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33; Wed, 14 Aug
 2024 12:32:03 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 12:32:03 +0000
Message-ID: <2ba9a72a-c68e-4352-90a2-918994f9357d@intel.com>
Date: Wed, 14 Aug 2024 20:36:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-5-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240805062727.2307552-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN2PR11MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: 801fff45-5152-4cac-efcd-08dcbc5d19cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGtpSlFBdDBROWlCZUwxNUxIZDgyakZTNUxaWnNsOUxoTWtHbGFTMGJxNzVr?=
 =?utf-8?B?VEdEMHB5QjJEaXhSai9WeGM3N3RodTExWVlpbjIxRnRsZnNON2RSVGlCYzRk?=
 =?utf-8?B?cDE4ME9mZm9uNUhCSGtEMjJvM28wdEJPK1VTamNoR2xrZlhuTWJNS1hMN0tN?=
 =?utf-8?B?eXlUQVB0eW9IVUdhNTVzOVpSRS9xUTNsRVBjc0hyRXhvemJMNmFkakw4blZ0?=
 =?utf-8?B?NkVIemcrQ29NNGFQVTRRUnRNeXJSbUtKUTFWbWZiNUx6RXhtUzNJY215SCti?=
 =?utf-8?B?Z0dPMis1cEJNSUFUT2Z0NFpLRkhJSHRHYmtsT3BJaXZYSnIyV2ZJY1o0KzRY?=
 =?utf-8?B?cEdsSVEyMzJPYUo4U2U5OXE1WGhGZ3lxNzdlb3ZPWGNMNm02czdYR0FaMzZz?=
 =?utf-8?B?MDJyUW10NDUzUU1tU3N4cUxLREp5cHVHbHhsaGdxdHg4TXRDL1l5ZU5oZDFI?=
 =?utf-8?B?Z2QyWnZDdVR1UDUyK000aDVUWmFEU3NLN3JlMnZrRUZZS3pVSUVJbm1iK3Bs?=
 =?utf-8?B?bTZ5cU9xdCtHOVFUejFOSm5FLzJsdC94M3BTRkRKL3M1a2NDOWl6MEU2ZGNW?=
 =?utf-8?B?WU9FMnNnQmJGb3psK1lyTDUrU2cwcWxMSGpCMjBqMy9PVmZBNkE3eVFKbTVm?=
 =?utf-8?B?QWs5UHdZUDh3UE5SQ21NUlZNRTF4Qlh6bmlTdUZyZkszdFhJZGVJQnBjQ0JH?=
 =?utf-8?B?NTdNSU90UUNHUit5U2hUbnNDSnphc1B5aXViMWRRc0E1NFBFMzNCNVd0amtw?=
 =?utf-8?B?NXJZT0RtemlVK0VzUGgva0grRmFmOU5acWl1OCtlb3pHaSsyZmpUV0p1VUpt?=
 =?utf-8?B?TTNQRnI1M0U0QkhucXhjR05WbFVMcEtFbUVTNXJxN1JFbFVIc1lLalh4NnlR?=
 =?utf-8?B?TU9hM0tMalVwWVo1VWFZTSt3Q2p2UHpHcEFUWTVha3diVkx4algzUUcvVVRB?=
 =?utf-8?B?NGJJeHpDN0ZuRGM1azZ4cGM1eUZUVmgwWkdPYjh4cWdtUzE4N2hZS2Q3L0hC?=
 =?utf-8?B?YTFRUU5rcHlPR2xSdEhReDZSa3JqaVZadXh0eHVlZGxDNXNIMVNKQmpOaG5o?=
 =?utf-8?B?YVhPWkRkY3dsVWhlR1hQSkZwWVNqMnFGdjJpSUhOUkRZdU5YMnNuOUhYU1U1?=
 =?utf-8?B?TUJ3WUZLdUNVUG1mYndFV0lTSEgxOHg5L21QdTdTZ1dpK3RIS1FLRENFK2ls?=
 =?utf-8?B?ZDVaL3Juelpxai9ZdFFzUU9jUGduUXZqNUU1eUJnc1M3Q1ZwQmxUT1lTSExB?=
 =?utf-8?B?a0MydTlyajdOU0VwTzBNNmYxa2RYS292RGxDYzhWTXhiL2pNZnNjcEVKK2cx?=
 =?utf-8?B?Y29yRk1KV0pPVXRGUU1CMGdiYmxDN1ZSYSt5dEFIang5dlc3SnMvZGFOSkpw?=
 =?utf-8?B?WU44SkQrazNSOGRnR1JQTnF4TUxTbDQ4dzVTbDNUcG4za0drbUQ3a3RkeXdV?=
 =?utf-8?B?MjhVZUY1SndmZEpzZ1VidHh0dnVUMHk1VEtCT0kvbTc0bWo0eFNZVmtyWWxW?=
 =?utf-8?B?NFVXdU5iaDFXOEpxdW53dVFScm1KbUg1SWRYRUQwdllsV21mcVR1VzRHNldh?=
 =?utf-8?B?SVB0OUFSTERjVDVZa3BCZUlSMHlvT3FhcHhsMW1FcFpsZysveXUvN2gzdTN4?=
 =?utf-8?B?dUNYbnAxWFVJdDk0ZlJTQ1phVUY4bDh3dHgzeFVubTlTeEsrcjZ0a2pnQm1u?=
 =?utf-8?B?MEFnVFFDc3U0Z3V5ZEp5cW1WdEFNUE0ySUtCMWtjQ1h1YzZzUVRFeWtqc1pF?=
 =?utf-8?B?cjN4dTAxZkZRV3ovZnZETFhNUWowMXNXaTZFK25jL1hudFlFck52K1BKQUR3?=
 =?utf-8?B?V1c5M2tHTjZic2tZL0Q0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjhTMVdzb1IxUmkvdFI3YUM0UVprNVZjRjVHbk1IK2V2algzRzgxa0g5ODNP?=
 =?utf-8?B?Sk5welkyUnFFZFlOTHBva2M3Q1RUT1hINFYwOWpyMXZ3dU1EaHcxUHhnOG9o?=
 =?utf-8?B?aVBLdm9DYWd1ZUpTRGpQRFI0U3RDbFMxWXUyM0s5bjZYdnkvclc2UEpxd1p6?=
 =?utf-8?B?Z1dxZEVSenF0ZmFoVW56VTFkK0h0TzhqQjRrdnFLdmsrd0RhMVR3SXdNeldu?=
 =?utf-8?B?NUxhK2QvRFgza3AxTER0ODBTU0F6amZPdC9NVWs4V2V5ZHQ4M28vNDlWNEtv?=
 =?utf-8?B?aXc5eU9PODhPQkJiSzVleWZlM1hhRjdqZ0NlVU1sV3RQY0cwNldrcWt3MnQz?=
 =?utf-8?B?UERZOVhHU2RNT1NjUEliY3EvRWpzVHcxVVVXcmI3NFRJRkh2RE9sQS96bjRa?=
 =?utf-8?B?N29tc0pTd1ppT2RvMTl2bEVsOEdqM05kVG1GVEhSNDBub0pxQkgvNndqcVZF?=
 =?utf-8?B?QkdwWVlEODRnODF5VVFvakJqSnZwamNzeEpDMFlocDZIYUR2Zzcvc3RPRVpp?=
 =?utf-8?B?bWJJRk45Q0pjakVZaW1GZ2tHNjVRd3FOcldUUGxFWlh0T2xKcURGZHFDeGRm?=
 =?utf-8?B?YnBBNm5WbmpBenRIUGQxaGZvMzdqd0JzM0hFSlVJcUtvNDlvVVN2dVhoZFVP?=
 =?utf-8?B?dmY4a3dxT3dEYjkrQk91VThHYzZJR1BTZTN6WWo0a3ZLS0JlV2JoWXVtY2VV?=
 =?utf-8?B?NDNBOFNTUkswYzdweUNYNjRJWStwdHVaVlFtN3A1bUcvUGFnV2pyZlhURDE4?=
 =?utf-8?B?NDQ2NjdiTERLUzl2YkJ1SG5ZKzE2cGlRYjcxRVRtTHh5eHZzMXF4RXQ4S3FV?=
 =?utf-8?B?d0lQQ1JoMVN3aVJ2a01VMnN6NUE0RVRraUhnaXdJNFg5YjJEOTNJYVVHWXhR?=
 =?utf-8?B?Zzd5Ky9ZV2pkS1hxdi80Z09sMzVOMk1CMXBOQTFwMjdrNGhzalBTODJCM2NQ?=
 =?utf-8?B?MVZ4V21nYm9LWnZEdnZtY2ZYZFJtaURCem0wVDhjSm5IZWhsTVNyWUZRVUYy?=
 =?utf-8?B?RkRtbVVkbGw4ZEdDQlJPSnZYMnloS0FhaDdMVXFlbzllUXd2RlgrRjZKTjZU?=
 =?utf-8?B?REkvYlpxVUhHQzdNRENHdHRjSThJK1FFU0MyUkN6TU9KU2lnSzNzOGlJbzFa?=
 =?utf-8?B?aXF3dnpjdHBPTksyVzBqMWdqME5XNWd5ejNDRml0N055QVViNEo5OVducTlk?=
 =?utf-8?B?NFk0L0FqdXFoYjRvZ3lhMzZ5VGNUOWtkRnF2MnRmaVVHOExBQk9EdWdHWHBY?=
 =?utf-8?B?cW5KNldKM3l0K3VtSTZRd0ZWaTVTVlZCbTUrK05WSzgvSy9iNXpjYWZwbE4x?=
 =?utf-8?B?ZVN6VW43bDVlOFo1RGpvVU5KcWJSbUh5R1g3R0ZRTk5hSUtXOUYzc0VYeDNV?=
 =?utf-8?B?OCt0dm9OZm9DWjJsajExNDE0SFVHb2JFdlFqMUllUnBWbm0wQlU1Z0Z3c056?=
 =?utf-8?B?ZnFxajRPd0FqMGF5Rm8wUDFMTWIxa2pXbFU2LzZIOUxEY25TalR5eTQvRVJ2?=
 =?utf-8?B?TkpxaUp1VWQwSTN3SlAxZlpVaVZNTU96NzNHS1R3a2t3Vy9VVmsrdDU3cm5p?=
 =?utf-8?B?ejhwWTNkUWUxcDFzdTVVcnllUWFCNGpyL3RLM1RCVjkyMzZmdWROdEwrUDNO?=
 =?utf-8?B?dUlLZG52OURYcVdHN1BjcWlNM2hXWXJORHNkOHZaNHlDNlF4d1J1Z2M5WTNr?=
 =?utf-8?B?NTU2clV2WXJLU2xoTjlicUR6WUhCSzhkL21xZGtBNloreWdubWFldElnMS9B?=
 =?utf-8?B?UVp0WjN2N1lKZi9KWm5sOVZsYWF2ZU52UnEyYkZzV2hwNU1WWEdUdDRyWUln?=
 =?utf-8?B?WTZrVjlxaCszelo4bnd5QmdKMFZ0RVIrUnRwRFpnR0Uwckwza2Z0Q29PUWw5?=
 =?utf-8?B?Z1BkUG52MDJGK01acE50TG5RcUVsWEdYVUNZOHZnQkVvU1M3SGJzYmFCekRm?=
 =?utf-8?B?YmVZVTRTNzZ5SGN4MWYzMzY2bzh5U2ZZWFUzY2RSVFVQbVNPcE1CWXJkL3lZ?=
 =?utf-8?B?QmtKNHV0R1dVRzViQ3VtUndNT1RsbE5LbWsxTnJhRCtZSll4M0RzN3BFcXJG?=
 =?utf-8?B?OWRmWWl0NGlVUVNFWnVuTkZiNzF6Q2UzbHVaOVVPbFlwN1BzU0FyT2g0N0tl?=
 =?utf-8?Q?lPpro+lvGM+qdVb0yjBgU9yFj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 801fff45-5152-4cac-efcd-08dcbc5d19cd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 12:32:03.1896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Colm6oWCq1ghddLujh12qC1xISd5EnWHDI8FJ5WSxc/LSIloFhDtQ+BLuq5krlbflWxmFLK3ZPTkQH2wJcK9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4759
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> Per spec 6.5.2.4, PADID-selective PASID-based iotlb invalidation will
> flush stage-2 iotlb entries with matching domain id and pasid.
> 
> With scalable modern mode introduced, guest could send PASID-selective
> PASID-based iotlb invalidation to flush both stage-1 and stage-2 entries.

I'm not quite sure if this is correct. In the last collumn of the table 21 
in 6.5.2.4, the paging structures of SS will not be invalidated. So it's
not quite recommended for software to invalidate the iotlb entries with
PGTT==SS-only by P_IOTLB invalidation, it's more recommended to use the
IOTLB invalidation.

> By this chance, remove old IOTLB related definition.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h | 14 +++---
>   hw/i386/intel_iommu.c          | 81 ++++++++++++++++++++++++++++++++++
>   2 files changed, 90 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 8fa27c7f3b..19e4ed52ca 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -402,11 +402,6 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
>   #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000ff00ULL
>   #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
> -#define VTD_INV_DESC_IOTLB_PASID_PASID  (2ULL << 4)
> -#define VTD_INV_DESC_IOTLB_PASID_PAGE   (3ULL << 4)
> -#define VTD_INV_DESC_IOTLB_PASID(val)   (((val) >> 32) & VTD_PASID_ID_MASK)
> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_LO      0xfff00000000001c0ULL
> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_HI      0xf80ULL
>   
>   /* Mask for Device IOTLB Invalidate Descriptor */
>   #define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) & 0xfffffffffffff000ULL)
> @@ -438,6 +433,15 @@ typedef union VTDInvDesc VTDInvDesc;
>           (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
>           (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
>   
> +/* Masks for PIOTLB Invalidate Descriptor */
> +#define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
> +#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
> +#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
> +#define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & VTD_DOMAIN_ID_MASK)
> +#define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
> +
>   /* Information about page-selective IOTLB invalidate */
>   struct VTDIOTLBPageInvInfo {
>       uint16_t domain_id;
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c1382a5651..df591419b7 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2656,6 +2656,83 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>       return true;
>   }
>   
> +static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer value,
> +                                         gpointer user_data)
> +{
> +    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
> +    VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
> +
> +    return ((entry->domain_id == info->domain_id) &&
> +            (entry->pasid == info->pasid));
> +}
> +
> +static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
> +                                        uint16_t domain_id, uint32_t pasid)
> +{
> +    VTDIOTLBPageInvInfo info;
> +    VTDAddressSpace *vtd_as;
> +    VTDContextEntry ce;
> +
> +    info.domain_id = domain_id;
> +    info.pasid = pasid;
> +
> +    vtd_iommu_lock(s);
> +    g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
> +                                &info);
> +    vtd_iommu_unlock(s);
> +
> +    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> +        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
> +                                      vtd_as->devfn, &ce) &&
> +            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> +            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
> +
> +            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
> +                vtd_as->pasid != pasid) {
> +                continue;
> +            }
> +
> +            if (!s->scalable_modern) {
> +                vtd_address_space_sync(vtd_as);
> +            }
> +        }
> +    }
> +}
> +
> +static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
> +                                    VTDInvDesc *inv_desc)
> +{
> +    uint16_t domain_id;
> +    uint32_t pasid;
> +
> +    if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) ||
> +        (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD_VAL1)) {
> +        error_report_once("%s: invalid piotlb inv desc hi=0x%"PRIx64
> +                          " lo=0x%"PRIx64" (reserved bits unzero)",
> +                          __func__, inv_desc->val[1], inv_desc->val[0]);
> +        return false;
> +    }
> +
> +    domain_id = VTD_INV_DESC_PIOTLB_DID(inv_desc->val[0]);
> +    pasid = VTD_INV_DESC_PIOTLB_PASID(inv_desc->val[0]);
> +    switch (inv_desc->val[0] & VTD_INV_DESC_PIOTLB_G) {
> +    case VTD_INV_DESC_PIOTLB_ALL_IN_PASID:
> +        vtd_piotlb_pasid_invalidate(s, domain_id, pasid);
> +        break;
> +
> +    case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
> +        break;
> +
> +    default:
> +        error_report_once("%s: invalid piotlb inv desc: hi=0x%"PRIx64
> +                          ", lo=0x%"PRIx64" (type mismatch: 0x%llx)",
> +                          __func__, inv_desc->val[1], inv_desc->val[0],
> +                          inv_desc->val[0] & VTD_INV_DESC_IOTLB_G);
> +        return false;
> +    }
> +    return true;
> +}
> +
>   static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
>                                        VTDInvDesc *inv_desc)
>   {
> @@ -2775,6 +2852,10 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>           break;
>   
>       case VTD_INV_DESC_PIOTLB:
> +        trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
> +        if (!vtd_process_piotlb_desc(s, &inv_desc)) {
> +            return false;
> +        }
>           break;
>   
>       case VTD_INV_DESC_WAIT:

-- 
Regards,
Yi Liu

