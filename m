Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF113C30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 02:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPZ1I-0003nC-8S; Thu, 04 Jul 2024 22:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sPZ1G-0003mq-09
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 22:49:54 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sPZ1E-0007RJ-AD
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 22:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720147793; x=1751683793;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tmD1xZCXcOqOLmEK2rMJPxN1OmH/5S/bpnawGaFpErQ=;
 b=ZIsaNUcWRDOx3gbPFj7jm0/5OT61MeTfsGe8nP0LNFhOg8bXlhLU1XQz
 tSyReoUCP4H5kgnZKeFnKjJ4ALMmsKVei8LOaRKqvTNDYN1YScXKV7a3Q
 UCcGzXjg36tPhXw86DX3ZWl2C0I/ZS1AifSFPMXBlFNIntnGywjml/bnW
 G7SgGawvA4bLyBSsTyXQUWSJDJYpcUi4bxKEfmxGRlQDxwoR9X2RVwMH+
 q+ufkudvQ2C2eqIRLhkTEZI3mIYPS6N0Yla1FP3uryW4X6wDdDfQwBPGJ
 ieINeLwVeGh5IWqAq3zg6UjQGnDrf4Cq4JxCtUuaq0tF2cVQjhKbIW4qj Q==;
X-CSE-ConnectionGUID: 71LiosBaTSmUi7p2avjmiQ==
X-CSE-MsgGUID: 1qa17NRuR7Cw7vNHm/jxKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="21242845"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="21242845"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 19:49:50 -0700
X-CSE-ConnectionGUID: TFizgv/sQuev42rvClyapw==
X-CSE-MsgGUID: kjHA8trNQeieGDhqsbmXFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="51075805"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jul 2024 19:49:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 19:49:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 19:49:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 19:49:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 19:49:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLZENsWZJzJ+SH04eyY6TmUX6LqR4gkB17A6IrCZvkxfTt4+c1aoh63i13vnmatCIPcLcvwTUtSAki9MSBtlkKqmMNC72idYEm6cRgq7vr7TxDKG6bFyXW/iDrKntjB3dVpCY5Ztv/+dARCk0RF/rHN4iQmauvTeQuOJpT+SNbndd4MW0snsD8E6R2lIFzrYkO9Im2EzvS5WPxxZPoc2ns4W2t2Iovk1xVghxR/APeDwefbscz87v5MRSzsXkGiMUAS2UXGBEQKrOQKkC5G8BxGnbyFW3Q4Sn4nnNZtPAPitKEYXIcz9G/ma5JKqCwAu/BK1DCcl0ngpKoKdhnR1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAOch8/W70BYuzwLCgP10GW9zekVnUrvZxO73JFlIEk=;
 b=XBEQehWEgxULMjQOVazWzfgZRCaAr0KrOZrqipVGI6Exy11dgdyNv8yQQqsXZcJ2WaKcwUJ+Zt6wsL09hQwDe2f11Qyctqqavy0a8WU5+XhUduZKhul+HRKApSubDwwkEChkRASRP9XAaF43CkKfZsOh0NRD/vR+1qgMpjwpjaWaKuwtpojpU5QoYshnRlcWWKmD0WVCzVoxq+FodS37mfCVDTDO5zybo80Jw/zCxOWn/2bdNdf6lF+Ous6JY6lkCf5h3zfs8tgAyyJx4Wjmqj4lCwAydwzRWiSDcdL3vCduDMyXcm88f17D7OCJOnOmhgOlNsQRYfp3X36zd+7BgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV3PR11MB8744.namprd11.prod.outlook.com (2603:10b6:408:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 02:49:46 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 02:49:46 +0000
Message-ID: <075d57d1-6ddf-4a78-a3af-aac585224075@intel.com>
Date: Fri, 5 Jul 2024 10:53:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] intel_iommu: make types match
To: "Michael S. Tsirkin" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>
References: <20240704151220.1018104-1-clement.mathieu--drif@eviden.com>
 <20240704151220.1018104-3-clement.mathieu--drif@eviden.com>
 <20240704180821-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240704180821-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV3PR11MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9426e3-c391-4344-7dd0-08dc9c9d2163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?STJBaGZIT3NnTTlyM3NRdEl6NFdoMG1TTGdQWG5ZeER5Z2Q3Um5yS2RkYVVQ?=
 =?utf-8?B?VzV2R29JZXpEdDYzNWhYR1p6cHpjQzdaMFg3bGhxdS8xT0h5Mzg3b3lValNP?=
 =?utf-8?B?d2E0U3RCZDJQUURVSzBNWjZjbGFzbC9nZ2xKUmxiTS82WUxzNzYwWUp6aFdq?=
 =?utf-8?B?Sk9OazMvNFpJaGVrTUcyWnRidkRLeWZpRWpaN20way9qalMzVlBVSlJLN05j?=
 =?utf-8?B?NzdPS3hRNDVlUFRSQ2NoZVNPcUNMVEFGclpsaVlROEx3VnRZTkE0NlJkZzUz?=
 =?utf-8?B?aCtYODNXd3ZtYytYUXExU09nTkVqQjFZYnRSYlo3WEE4SFJCNkNpeHlnVXpU?=
 =?utf-8?B?bDhrUkdObXZod3pvSHN0VnBDV2dCMm9Oa3pEdW5hTTlmWWZTSHJFWEFWb1Nq?=
 =?utf-8?B?bnpTcVpaTlhIWThqeTZmUEpGTUUydFZ5OEwwbjNWaDdYN3UyeVRuc3JNOU9X?=
 =?utf-8?B?QWdLQWNKRTFCcGpWaW90aG4yYk5IdkRwNDZWQStIeGFVdXFwTVZaZWJwN2Rh?=
 =?utf-8?B?QktaSUw1ZjVTZ2k4WUhQMDdMTEVPcGMxUjRsTzNiMC9XTjB3WjU1bTZrOW1m?=
 =?utf-8?B?UHRUTFBnQmRES01TV3ZnOVkxWDduOFhJR2RBWVlDaFl6WmVtbHBRRGh5SU1i?=
 =?utf-8?B?L3BYUFl0TDdMMWFDYzVyWEYwMmVra1R0K3k2dVo3cHhpSkhoeWIvbTE2cEY2?=
 =?utf-8?B?K3JJMFhkbURPdXBjOE93aTdwM3MxRU1sTWsyQS9QOU51eTg0QVA2RllRNWww?=
 =?utf-8?B?dFA1WHNoUmp4WWhNcU5vMnY2VXRlc0dBTUZSM2dJVHRjWTJVbENwUXJOU0Iy?=
 =?utf-8?B?WjZoR2k4YWpPSlU2WkNnNkFvTThqUFBqVkhnY29MVXZmVVlKK3hKVGxFOTFD?=
 =?utf-8?B?bG5wWmFicmdZRE9pZWVGNXQycjhlZjFrcUNrRHo2WTk0dWwwSDMySGV3bjhS?=
 =?utf-8?B?dUtFVUc4a1lZRXppN3lyQ0ZmWWExMXQ4cWorSWpjZ296ZEE4b3hjQ0Ixbldh?=
 =?utf-8?B?eEJ6eDZ0QkIyV3F5bWE0enVGQ3RWeWhXTlM2aFU4eGV5STk4c3dCTXlYTnFU?=
 =?utf-8?B?UmQrQzZiWW56Szk2YjAzU3dOalpLU1NRWWdqL0RuR1ZSbDVVM2dYelRSdE5i?=
 =?utf-8?B?ZmdQYllyZlNuQUZERVJ6R3ZDc09XMzdKS1QvaElUYVBIT2hWTTlxelpsdDNw?=
 =?utf-8?B?dS9QN3JNcTRXL2FqNTNRTEJRQXlCVVhvNVljWS9mNUh2elRjbHg4Y3FMLzBY?=
 =?utf-8?B?VDNIMVhUdzh1MFUvTTdUd3hzSHA0bFZKNmM2L0FVNnVTMkxNc2gybGxvSU44?=
 =?utf-8?B?RkVmUHZyVDlvb3VweTVBN3RxT3JNNmIrZllQNjBNVDU5R0YxaXNiZFpsbnQ4?=
 =?utf-8?B?bHRqalpxSGV3NlJUM2xKaTFkVDlXTG1ETkJDUEJlb3RKdWpBSE93UDI5eHZm?=
 =?utf-8?B?UEJJSnhjMm1TbXJDdW9hR254VnNJWDlnc25ZWDZsWStWOVNYZytRallRY1d0?=
 =?utf-8?B?S0RLa1VleUorR2VXd3ZNMEthMSs4MVBLMW84b3ZkaTExZTJZSUIyM1VrL2ty?=
 =?utf-8?B?bHpEWkNveHJSeCtuK0tkemR5Y05PVm84V21BNndDNWVtdTFYdnByZExncFJ0?=
 =?utf-8?B?aVdqQU4rVUpHc0NYdEhiUEdYeDYyRGtqaE5xN1JvOWNESUlOTGh2Tm5xZWp6?=
 =?utf-8?B?YlVUSE5NSnhoUmVBSkxRLzdIakFEM0tSZnZ6L2Q2NTRhZ3R0Y3JJa2RDVzFD?=
 =?utf-8?B?YTAxUGFDMUI3ek9IY0ZHL3JaSFNGTGFTaUJKZWsvYWgyUWd6L0xxZUtqdUhw?=
 =?utf-8?B?Smp1dUc1VHdSL25uYjBGQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmN4YkdTS2xpNkJQYUJBVnB1ZnM5UklZalQ3OHZ2TC9RVzNOREpoZmczWXVl?=
 =?utf-8?B?dUp0ZjdDZ1hCak5hb3pXZEhmVzEwaVNmMnFtNDVvQzFTblIyRVdpYUl4TnBH?=
 =?utf-8?B?ajBkYUNIdXFibFkxTHI4U3JyblpzcUltbzh2Rzl6OTllSUZFY21RUHdBTzMy?=
 =?utf-8?B?a2c5cDVLOTR0TldPOEpYWDlaY0F2MHdONXpzTnhBTGdCeEZYVFhpeXFiQjY2?=
 =?utf-8?B?NjNYUTNxVDRrZnZtN3EzQ0dGcnRFZFZzUngySHpzM0x2eHhiMEhBQjF0OTEw?=
 =?utf-8?B?b0pPNDdXamlhZmM4UkIxaGpnVzJ6S1VGVkM5U3M3ZnhJMUVwWU51NmtjK2FO?=
 =?utf-8?B?elFTcG1zU3JRcm9nQ2dMVzhRZWNJdTdORndMRTY4UlBpL1Yya05lNE9udlpl?=
 =?utf-8?B?cVhEK2gwVSt2RWM1V1pIelNrbVVjUDZmTmdpZmVsOEdZSkIraTV2N0xOSEJ2?=
 =?utf-8?B?SkhtcWpEU0U3YmtBT0Y0eS9Uc29rR29WTnhGRGlpNHdSWERKNkpCMWdtVUov?=
 =?utf-8?B?RGFGU042dTdOZFE5RHMxbmlFREIvd1VWcEhYM2xnblQzRHpXRDluQ1MwWlFK?=
 =?utf-8?B?dGpnNHZxcGFYdVhIYnRaUGRpSndzMDFVSjh2a3pzSWRUdkhZU0lsNEpIeW9m?=
 =?utf-8?B?RFlNNDBJbW5ycHJmVmF2eXdPWFF5V2NIM050WWk5VEdUM1BDVXcvRUt6bXE3?=
 =?utf-8?B?a21Lam42R1o4dUNySURLWkRvM09GbS9xTWNWcmdxSWc1YWhTejNxRURIb1ZF?=
 =?utf-8?B?Q0prdXZ3NFFuVCt6ZzU3VWhNRlc1dWJRRytLY2FJUHdpdGVYaFV1Z1RNL1BQ?=
 =?utf-8?B?SkpqOXdBVDExV0NxWE80dnUvQUJQS0NiWVl4V2dMNnZ0K2JhaEtzcFdqaTIz?=
 =?utf-8?B?UkdSaG1HaGxNNU1wQkxvNVA5bDVoKzdwTnEyMkU2NTY4b2dLd3BSR3RZQTFE?=
 =?utf-8?B?RXhHb1ZiaHZmTlZpYnlSWmJNTkIvSkdGb2ZRUXowSjhaQ0lOV2loRTlZSVVs?=
 =?utf-8?B?M1lIR015QUZqK240dFErYWIyY0VjR1kyc1ovYjRmVWh4QW9uRVd0TWIzQ2Jp?=
 =?utf-8?B?YTZvcjRQVnBVaU9VNG9CZzFZRHNkVDRNYUhkMUFjMHVWSkpZUWNNWkFHTTE1?=
 =?utf-8?B?WTZrRzJjZ3VYVXVoY0ZiN3lLM2FXMTVmK2tWZWt3SEdkTm1LcDFSb1F5UjdQ?=
 =?utf-8?B?bzVxTlV1eXFmK05lRGcxQzZsZ3Z0KzRGUmZBeUhCMjdGN2xLYm1BbnYxTVkv?=
 =?utf-8?B?OUUvdVdzcXMxaEM0aVRFdmQxM3V5cWVLR2t2SUNxdFJXTzM5eGcxZksvblFU?=
 =?utf-8?B?L2JJS0JCVWxscmF1SVcvUExBT1h6MUVsY2ptajFJamlSN3UrRlZKSGp6UU5L?=
 =?utf-8?B?V3lDL2hGR3JCaTdPYVR2bktscTFNSDBqRFNqYkQ5M2pFa25XbERXS09VMXE5?=
 =?utf-8?B?OFQ1UmM3dGtMUTFFMk9KNXRjdkN0R0FvMUVjVzJFdGtqSFJkbk5SSXdUVnNn?=
 =?utf-8?B?TGhJd04zcldyYWVhWUpDL0JoSGRhVjlmWE5zS2c4RUpXdmJrelh4Tk5vM1Ar?=
 =?utf-8?B?dnFnVFFWKzJPR3pxOSsxQ1pKYnlEVWI5N0ZUaXNLMUlBK2Q5aU1NVVNtUVo5?=
 =?utf-8?B?RlJocnBqckJOeHRucjF0R3dlb0ErWVdmdHhGQWxENXRibFJrK2kxT3BSZUFh?=
 =?utf-8?B?NUo1eUQ3cVlaVk5NdkMzQnhVYnRXS0ZvYjB2aUxaZlVGMHNxZDdpQWJNK3ht?=
 =?utf-8?B?RWtmNGRRVXB2Y2JtMXpQdk5iUzR1S0F5c3NKb1NNRExzckFCZzA1TXVTZ2d1?=
 =?utf-8?B?blZyUk9Lc0tTcG84cVlFclpJQjdjYUJkRmVLd3RiemtZSnpvNmtaNEpaOWY4?=
 =?utf-8?B?dHdaNHN3aFJxQUZtM2JlZ29iNzB5VEhwWWljUlpLK0gwZUhJMXFUNWRZVFV2?=
 =?utf-8?B?UTZuclgxS2g1b2wwQTRnTlgwRFdiN0lTNS8vWDRVTGhleGpqQWJDb1NOUWg1?=
 =?utf-8?B?MGpFTGVBcVZNK0tFUWFINHhLelNLd21keHNZTXdwRzkvS3UwZkpKWktmMmdk?=
 =?utf-8?B?bGtsRldMQklKZVd4K3RxQjVJWFJ3bStJMFpLejlhV3BVQUtvOGdXdzFXUGdy?=
 =?utf-8?Q?3MWmiCXfxbxl44j8UjeIv7wSX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9426e3-c391-4344-7dd0-08dc9c9d2163
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 02:49:46.6701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrO1tt6yzW/cMi9oVImywcj0dWFJKuUP1XYbIzZQusAwwLTeBrv7MujroARuMApH3j2VHVYwe/Pf3KhZvXeBWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8744
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

On 2024/7/5 06:13, Michael S. Tsirkin wrote:
> On Thu, Jul 04, 2024 at 03:12:48PM +0000, CLEMENT MATHIEU--DRIF wrote:
>> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>
>> The 'level' field in vtd_iotlb_key is an unsigned integer.
>> We don't need to store level as an int in vtd_lookup_iotlb.
>>
>> VTDIOTLBPageInvInfo.mask is used in binary operations with addresses.
> 
> this last sentence is a bit opaque. is there a bug ? E.g.
> can mask ever get so big it does not fit in u8?

yes, this looks to be a bug. It's initialized and used by below code.
The am is a u8. So it may make more sense to split this patch. One
is to make type match, another is to fix a bug.

info.mask = ~((1 << am) - 1);

uint64_t gfn = (info->addr >> VTD_PAGE_SHIFT_4K) & info->mask;

>> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>> ---
>>   hw/i386/intel_iommu.c          | 2 +-
>>   hw/i386/intel_iommu_internal.h | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 37c21a0aec..be0cb39b5c 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -358,7 +358,7 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
>>   {
>>       struct vtd_iotlb_key key;
>>       VTDIOTLBEntry *entry;
>> -    int level;
>> +    unsigned level;
>>   
>>       for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
>>           key.gfn = vtd_get_iotlb_gfn(addr, level);
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>> index cbc4030031..5fcbe2744f 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -436,7 +436,7 @@ struct VTDIOTLBPageInvInfo {
>>       uint16_t domain_id;
>>       uint32_t pasid;
>>       uint64_t addr;
>> -    uint8_t mask;
>> +    uint64_t mask;
>>   };
>>   typedef struct VTDIOTLBPageInvInfo VTDIOTLBPageInvInfo;
>>   
>> -- 
>> 2.45.2
> 

-- 
Regards,
Yi Liu

