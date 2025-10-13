Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290DACCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 10:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Fdx-0003Rw-Bl; Mon, 13 Oct 2025 06:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v8Fdu-0003Qw-1V
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 06:19:02 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v8Fdq-0004GC-0b
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 06:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760350738; x=1791886738;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YQLWIbBw84pwOsWIM1VJsnQa2F3LpHHMrfki0XYKxHY=;
 b=iYNyU/RgnZQLY85Aqq8wo8CUHJu4BTjUD+WQcvqTv2oxuavVnkMiAGqd
 pl+n61onpJZZNYG1CrZ1ONL5Bn9qG2O/0zS5NECjZkl2o/tH2mXZ74XdN
 yG2hv26X84YUdhcEhfp2pj1PchDLEMeUB5NVTDvA3NT0+4KUGrkldEl4s
 sluFKpShSELVWaExXhOIHBDMtF1zMydVy1jjmDDGlH+gc+MeIn21Oqwq1
 ea/3Y2aDokYIEKCc/9zoCO2o8Kb2c0ZLrdnMhPQx9Ywu+/CW4LsWYOd8E
 HgCrMEgHBDbsfbYH8j4TBeX8R7+lydz2gblnL9SFO1mc67z12iA25rnXT A==;
X-CSE-ConnectionGUID: 1SqAMBrXSJ66WxR8cQNXUA==
X-CSE-MsgGUID: lJAesvihRGivwSM4EKADYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="87945129"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="87945129"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 03:18:51 -0700
X-CSE-ConnectionGUID: athSdHk+TMagiZWYDWFJrA==
X-CSE-MsgGUID: ubTinUdpSYyygXbSZs3VsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="185823839"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 03:18:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 03:18:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 03:18:49 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.32) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 03:18:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMljP/j4GsUEoxWpgKD39106HUJRxeF5/A4fwozkAdd0kLots5RRlShTqVNzXxs/dwpeZcQ79PyM8bWoSiknorxCTMcADz0smGd5eDqqN1baECDc66rfQlWZaii548ZXIjUSwk+cXsmZpQyJ0C9BoU4AtjXa+uD+SlpVtwtDlAB9AjHa9NoYReJNdav1G3tbFJzudP8iA8hX9Nn3745li7J11ESLmMNUlgRP08zeqI0PJGuJ48/t4i7BEy89wZnYSFLbqbHu2S72KodLwnTHvtF7bbkuDfytCNUhn0WdkEznTzGsidPK+FHivJ0s75smsJ8IU9vKO2T+mn1fIyeMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeMJRwP7m7pudSdRj+c+g9KUyUDFAJ9SZigJVEmev3E=;
 b=xMtQ7u9gNZFzKMx7g5o8/1+lF9vrV4oGaOUNzm9ib44BMAhVuB9bYrSVJfsVdWB+tZ6dsfGsB/dMG3N+3plCT0uiZJcIUyGZCnRydI2o1XfV5ruuyDjbogGW/gMYXzx6YYOm3fvVzINjwmiZmVvzSVJfktjbHzrojADK550ScyX2rn70x5dZQYtr4c9Yfr10LsONOu6P4AG3k6urRXHKGKNAgLHa3YMRDf42syrsNZMcu1a9DjIk9R1Ss4DjpEQHZmB+YuYDDjWUx8Dw/3Qqv9e/A9bVS2wxUXuekLoeLn6weql1M5LkNd5jckwGH4rwkTHXgvrVPa/zQkRQ7f168A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SN7PR11MB6828.namprd11.prod.outlook.com (2603:10b6:806:2a3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 10:18:47 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 10:18:47 +0000
Message-ID: <3f5e636b-255b-4535-acc9-79a6179439ef@intel.com>
Date: Mon, 13 Oct 2025 18:25:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/22] intel_iommu: Reset pasid cache when system level
 reset
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-14-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250918085803.796942-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY0PR01CA0015.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::23) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SN7PR11MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c756dd0-50d4-4c7e-52b4-08de0a41e582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|376014|7416014|366016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXFDNW9UUnhPYk9NQmhHN3IreER2WGJIUm1lRTVKMGtKL1RQQVZHMkgzZGJj?=
 =?utf-8?B?NjVqVitEUmYzT0t6WmVzaDZZSWZhNFJFZlVNeGp6bk44ZEQyQ0w2TlEwQUUw?=
 =?utf-8?B?K0ZuN21QVWtPOEE1eC93VXNzQ04vSWdLenhnTGpxWDNhaWIya1ZNdks1NmtN?=
 =?utf-8?B?KzY1enFBQzI1TUJ1VldIdEViRmFuQnpqQjJZU1g5MFZsYmlPaUczL0R0T2JM?=
 =?utf-8?B?NFp4K2puWmxkN3I3NmJzRTZkRjdpVHVaOWpvRWVPTGN4ajY1NHFsckRXS2dj?=
 =?utf-8?B?L1JVaThwaWpuaGRyVkNWTm9aMlZHdXpNRUVyRWtCK3VQYUVYdlFBRnlpbXUx?=
 =?utf-8?B?eVhNWVhybnB6RkxHV1p1YnBvQXpPRUdKSEJCTXhrZ2VJNFNaZWVNM1hwcnRH?=
 =?utf-8?B?OXBLY003TUZaWHJJZ2haUXhvdTVHYVh4YzI1aS9KWThVUUtMaDNIQzZyTys3?=
 =?utf-8?B?Q0tETHFrWVVKVDYya0R3VGl2a0Y4NWhNNjJQandWSXNGUUJ4MDdtbGJQTG5a?=
 =?utf-8?B?NVZHREhMOVRZNWllNThuZFFjcFB5TzNrSmtJWUU3OFBPZFdYdDBCSUgxZWtU?=
 =?utf-8?B?ZjlwZHREV0VUZU1FMms5dVRPVEgvVFFaWFU0V2hVb2VBWE0reEJkZ25FT1dV?=
 =?utf-8?B?cjN2YVpFNG44WjZvUmRWVnkzMTZBUENlZ3JBQWltZlpuVUhTbHNrbXpTUzhV?=
 =?utf-8?B?ejBKa0tFYS9HbVFhSktQeFlHWkVJSW45Y00ycFN3NVRGZ3Q1aXBoQksraGRB?=
 =?utf-8?B?SG1aSW1xeUVDc1hlbDJPa0lFUU5YcTRLaG9qc2grSjZrSUdyK0tMTHJWZWJl?=
 =?utf-8?B?WTE1RVhIN3ExeC9hdEJaclJvc3VvS043Tm4walFGaGJ5YVIyY0J2N3dMM0lt?=
 =?utf-8?B?b1JXY2o3NFJYRnI5dEdDTU9MUzkram5TQWxTWFRXdUhSb2hBL2tyeU03TFBj?=
 =?utf-8?B?alBPdkp0ZFZHSGw2cjNxc3piMkpmbmxsTWpTcFhTazhxMXJ3dTFXZUdKMVJy?=
 =?utf-8?B?SlVjQmlFUlRKbEdUYTRLeHBJMGNSUE1CSjhBT1ZDSXBwWmxhWXYwL0FvN3k2?=
 =?utf-8?B?d0lBMFBOSHlxVUZINzZaMkpteVZRaHhNUEZ0cG1KcVdudG14VUF3LzMxcmxY?=
 =?utf-8?B?NXNneS9TUWJCMFpyK3BlOFZzbGZZeThuUjRhbUVGUVBadWJwK2N4MDhBRTJv?=
 =?utf-8?B?VlBSOEZmMTAweFFaNE5IbDRJQTJpS2c5NCt1R3RSYmNiVHViSTFIb3ZrTnJo?=
 =?utf-8?B?dWtNN0NBSkJvb3pSNDJLSFgwRVJ3d3c1YlA2aTUrOEdwNVFhcjliQ3h0TkVO?=
 =?utf-8?B?aXhYTE1iWGZaNDBVUklVVDNQaUlzRzZiSE4rMklLa25BQnBxYk1ud25Bekts?=
 =?utf-8?B?enRZNHdTV2ltbGpndzVYZy8zb25sTXN4c09HU1dZMGhIMUlScC9PLy9tRGcw?=
 =?utf-8?B?MEFEV0c3eDFUekxVbC9wbkh4L3NlOVdTTVkzK0JxSHg3UEVieUFzUjlDQU83?=
 =?utf-8?B?YUpiKzhUYlRiTVVXTEFyWlhEMjdYRnFCMGNBVVBhVkw0QWVobGJFcFE4NmJ6?=
 =?utf-8?B?aDI5QjVGTVAwY0ptYU9xd1d2SURQejkvMkM4V1ByUGZFcXdJMVN6Tm9GazJS?=
 =?utf-8?B?akNXUlJ3TC9FWGpKV1FzVFhEMG14TGEyQ2cvZ3VsajhFVHptN1NPWVlWcVgv?=
 =?utf-8?B?RDVDdnZjVmhUNDlRdFdHbTRyaFVoSFNNa3IyVHNteldudXd0dXNYR2RLM3hL?=
 =?utf-8?B?VzVVOHVTTFBZbHRyd0FEWmZjeE9RNWlqWVZMU3dpZ2dSS3gzTzBqY09Oc1FT?=
 =?utf-8?B?TThVUzZrd3VDZVFzQ2c5K1VpOFVkNlF2M1ZTZHU1ZG4rZXFHYXp3UDlpT3Nx?=
 =?utf-8?B?RmRLd2twOVN2ZkVZS0ExTzhsdWpTcFk5WUFIZDZnWUlDVTV0czNDVTRZUEo4?=
 =?utf-8?Q?BuMdnvOs7x+DXxLLJuvYNyrMDz9ZBbTf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(7416014)(366016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2NNejRlQ3h4dkNoQlhCaUZTVGQvMXdhcW1YZXl4RlJ2cFA0SzVJZTV2VFF5?=
 =?utf-8?B?QzBNNGtCMzVRanFwQmt0Q3gzYWpjYzVxblNDNjFNbnN5NmhxR1J4Q0hMc0hq?=
 =?utf-8?B?eDZQOE9uL3o3eklncE1DUEoyWFU5TGw1NU9iUmY4Z1QxdVoxQU9jVW5ZVmZ6?=
 =?utf-8?B?aW5pYXk4OXJPS2huYUp2WVlNMWVkeXgzQ0VuYTNTMzJNNHVrMzlwWlByaEFw?=
 =?utf-8?B?aGVmaVVDMXE0N1BvQXVGL3NpMlNGenZOWVFuWUhDUCtlbHhmT1dra3VRQkky?=
 =?utf-8?B?RWFPd2JmY0YvdVBKN2ZIWklvcXdVSStibExqK1ZwZXVCTS93Nnd5U2tKSEQx?=
 =?utf-8?B?N29BcVpCakhMd1A1VW44b2lEQS9CNlovTlRDTy9PR0pMeTRjTEk0cGtmRlpJ?=
 =?utf-8?B?UVZCOHVtdFNLdEVaeVlwSXRJNXM0SytLVk1kdE9ZWGhibUVuQUNVSVdrMXdO?=
 =?utf-8?B?ZHluNVVadFZzMjFFRHNMVTVTcmtGSzFxRTRWUURScTRJTU9xOForWFUrUVdx?=
 =?utf-8?B?d0V2Y2liNy80ZkVWNmV0OS9HLzVxSVZtZm5DSitXRmlEMzRrUDFOUzdORzJw?=
 =?utf-8?B?b1FCd0k1cldsVGJNUDNaU3VUUWV0Um5kMEliSncrN2pGUmZyNkZFaVI3bXlK?=
 =?utf-8?B?bEVGTjdOb2Vndnd3RGkzbS9aYktFc01JMmEzNDNSODVpeXRrejg0dE9tc3Uv?=
 =?utf-8?B?UHppRFdJL2IwWVhRaHNqZmFQZ3Z1a3NkdmZZZFdrZWxUQ3dTQmt5dU0zUitQ?=
 =?utf-8?B?RDJCelBGSlQ4Q1pzREppSTRWTEc5SnozdGZYTDBqSFdscUZ1eW0rZVhMR1RE?=
 =?utf-8?B?bVN4NDZWOURsMHEzQTZwclR4RVhPUVpGSnVNVTlCQVdBdEhvMGU3U2c3d21V?=
 =?utf-8?B?ZGFqaEIwQkRmZHhXd1JnZ1E3d3BXNm5lWFNZd0ZpNHFPVlE1Z3p3QjBCOUZK?=
 =?utf-8?B?VGVlZHhJNmk5NTRzbWg5RnYxSDdSZHNlRmJENXV1N0VNSVZEdU5UR1NlaEhw?=
 =?utf-8?B?Y1hsemRybDYvRXVNeDE5THE3NG44TUFoZ2lLeFpLOHNPTk1wb2U3UDl0YnA3?=
 =?utf-8?B?V2dTRFF0ajZNbG1HNnJCRElEWG0wTmhXbkFrUE1BQlZvS3h0WkoyQVgyL0Jh?=
 =?utf-8?B?eFVFMHJqNGdrS01RbHpOSHFMYnFkV3V2Wm9kaDV4ZzlGUE50Wjd4YmdIN1d5?=
 =?utf-8?B?a0FUVDFLVm5MWnduUGZVaDdkSFdPN0lRd3lxelliVmlxemZiT3pwSXNvWHEy?=
 =?utf-8?B?YmdyRGNmdEZyM1dGZ0pNZlNuM3l3bzdrOXVtU2lCc0dYZXZwQjNGSitOQk5R?=
 =?utf-8?B?RXNObXIzR2dEeWxVdVlLdDZPMkdweHJ5ZE11eUlPK2JWRzNXYUpETVV5UDQ0?=
 =?utf-8?B?dFBwUTlNaHpIa3VEWWtpRWVmMTZ1NlUzTkQrSkR4aGRJaDAzMTJVcFJoUE9C?=
 =?utf-8?B?eUVzT0ZsbFJ5S3FhZDBDc0dBbWxjeXlPUm5yODlRWjJ6dDRPUnlEWmNOS1Z4?=
 =?utf-8?B?Y1FQQnUwSUNaZFNxV0lCaVhXNzZXVWRmUDFVeVRlZ2hWTmE1TWhOdHJ1aXc0?=
 =?utf-8?B?TU4xb2ora0k3NTY5N1FtTjRCV0VaOGxLREdCQkJkVHVVaVVyMHczZVZqeWpJ?=
 =?utf-8?B?RnlmRElxV2RZUjFIc2hsamk3VDQwdWVPcWRaL25LR01yRCtnemo0VkxHc0tR?=
 =?utf-8?B?UldlUUN4Y2d1YnNrQzIxOUhmcUI1MVdhQXplK0lUSElJQUN1T3VpSld3L09h?=
 =?utf-8?B?MjRSOEtPNDY4bW5ycFdvbEdRTTJxQ3ZzVVQ5OExxQThJY0Q3dkkrMGJpeGtU?=
 =?utf-8?B?Ums4N2tZTGx0M3ozOGFTTFBSR1VBK2VtbW51Y2l0M1ZZWUt6dU9IRFZzMEdD?=
 =?utf-8?B?TkVDenViNzNnK2J6N2ZsWjEvSUtwL0ZIMkJQOFdoN21SMGdFMzBJcEdoM3Fy?=
 =?utf-8?B?S0RQUXpacWpsbWxUUlNBTlZzTG0waThyaGdWK3RTTTc0YlZVc0p5NFFiM2VL?=
 =?utf-8?B?MzZ6U01DR2xqS3FzUm9wdlo1bjFVU0ROUkE1eGsrNDdmdGhER2tWK0tQTW5J?=
 =?utf-8?B?c0s1aXhmN2VKbXVJTHl2b3dRUnR4VGM4NXhvOVJaeXpvQ1pyMzNkNVZUMDNV?=
 =?utf-8?Q?Jb4L5vf79LtQqKUFO1bqRQNCI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c756dd0-50d4-4c7e-52b4-08de0a41e582
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 10:18:47.5416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NmKrdtVCufWPKXK8C7vV+vjRKuvjlD3CvVt0WgTh0I9PWfD6q2HVJaxP35fO+GKZwBiT/Yu0wg2LerARG60Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6828
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
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

On 2025/9/18 16:57, Zhenzhong Duan wrote:
> Reset pasid cache when system level reset, for RID_PASID, its vtd_as is
> allocated by PCI system and never removed, just mark pasid cache invalid.
> 
> As we already have vtd_pasid_cache_sync_locked() to handle pasid cache
> invalidation, reuse it to do pasid cache invalidation at system reset
> level.
> 
> Currently only IOMMUFD backed VFIO device caches pasid entry, so we don't
> need to care about emulated device.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 15 ++++++++++++++-
>   hw/i386/trace-events  |  1 +
>   2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 24061f6dc6..a6638e13be 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -85,6 +85,18 @@ struct vtd_iotlb_key {
>   
>   static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>   static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
> +static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
> +                                        gpointer user_data);
> +
> +static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
> +{
> +    VTDPASIDCacheInfo pc_info = { .reset = true };
> +
> +    trace_vtd_pasid_cache_reset();
> +    g_hash_table_foreach(s->vtd_address_spaces,
> +                         vtd_pasid_cache_sync_locked, &pc_info);
> +}
> +
>   
>   static void vtd_panic_require_caching_mode(void)
>   {
> @@ -390,6 +402,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
>       vtd_iommu_lock(s);
>       vtd_reset_iotlb_locked(s);
>       vtd_reset_context_cache_locked(s);
> +    vtd_pasid_cache_reset_locked(s);
>       vtd_iommu_unlock(s);
>   }
>   
> @@ -3115,7 +3128,7 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>       /* non-RID_PASID isn't supported yet */
>       assert(vtd_as->pasid == PCI_NO_PASID);
>   
> -    if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
> +    if (pc_info->reset || vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
>           /*
>            * No valid pasid entry in guest memory. e.g. pasid entry was modified
>            * to be either all-zero or non-present. Either case means existing

do you want to update the comment accordingly? otherwise, the patch
looks good.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Regards,
Yi Liu

