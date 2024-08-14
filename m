Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F93C52D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 12:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seCxu-0001z7-7v; Wed, 14 Aug 2024 08:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1seCxr-0001yD-Tm
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 08:18:56 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1seCxp-0008S5-L6
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 08:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723637934; x=1755173934;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fzaSQ2gnTK+WdKPkljeXsYKuW9IhAeHq72xA0mwXrpM=;
 b=dC1Dv9nrRCfPMZT8wDFEKp8w5C4/LtPQv7RNoiP0kgcFiCQYwG+qB/Ng
 seuJEgSuI13zJUr9oTRM6JtT+1YORAb1+fDBV6TVbPkp/MdKegul3sllP
 TEmF8kdxIxOG5z1K0bzndiujZn4B58dti6gctpGyNUXr0zn0H5Asl4n37
 VsgP4qWmUnCv9s9VacnXRl9b9uO3+9qkUmHrE0qtrAUs0vlElPmQvKiZ0
 be3+8YGmxYYWDAcGWZjFTOHR3DcW1PL1jNNEpWgGWNIfWS2aXwxRhBSjV
 SXd2YwGecLj7/RIRVgNgrgdQq3OzJnkBepu1cCml30oE3XFQNCmT78Qso A==;
X-CSE-ConnectionGUID: Cfc0KVChRealuc8O1EbuMA==
X-CSE-MsgGUID: 46SzoiuDRqeNA4n5CTjUwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="39354695"
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; d="scan'208";a="39354695"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2024 05:18:50 -0700
X-CSE-ConnectionGUID: 8frSWXkKTKSSpLR6bX9A0g==
X-CSE-MsgGUID: E9M91xKwT6e2uvoBpQelaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,145,1719903600"; d="scan'208";a="59563816"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Aug 2024 05:18:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 05:18:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 14 Aug 2024 05:18:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 Aug 2024 05:18:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 Aug 2024 05:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8d1vuJdf2DXDdJFOy1sd4SvLQCkfUhPu/byrn6mZdi/8gLaZ/ekfQEB0D5ER+v29149hFwkj4NqZDSkNrBJ0ZJik8UzJG9VbbucarQbaqYxzUZwmAzCpxss6kAnbirTG3xtPG/ZHbJfF1EmsX58u1Z/vkI1jv3fBljKF0OtsVLi8bp48/4tCGeS/p6BIEzCV0a1hnrNaOuT/DqmzQbTcu9r8gGWl03lvJzjouSo8ExBqURjua69TAyPJClhNAtZ+Cp3ts5wg3Z+FjiREKUvyqsLeBj6S1tHH4yIhoEE+i+njM7UuB5mhH+pq4N4HBYULBQglkFG4xZHB9kz4FcfXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNKehBBIGcYDINVmSV/Lg50zZtDZEFaH38mlYzmT0Oc=;
 b=aUDmTEQDsm2Mt/uCiZPH7pIlv9ANhAVznEJHkDFXQ3j9EMvMmmnyNDFgxUlvyvnx/G58x+vlLe9krktUgaKORVBbHFE4I2gDwnBPUx1a076XVFPDAYBF1wNLXCFhplPfmibMhaRGnFjA0vm87od9vumew0tc31wxmmln1lYvL1nUr/gWe7rXIZ+yrAPWzLYB6aYDvUpgIpJk3twZphvN5kEz/YokfFbPZK9jE/SwDg+hT0SJH2c0Z8Sdfz5NzbI1Fmx3trWuvQa1BapiiOxeF0f3KWU/1xZlEDpDbrol7Zx/ChjNmhD3kY/mTQioBOBtXmNS6Pkdps57WimRxhyhyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB8502.namprd11.prod.outlook.com (2603:10b6:510:30c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 14 Aug
 2024 12:18:46 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 12:18:46 +0000
Message-ID: <9b2b2f76-a5ef-4378-b233-af1a44f742c7@intel.com>
Date: Wed, 14 Aug 2024 20:22:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/17] intel_iommu: Introduce a property to control
 FS1GP cap bit setting
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-17-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240805062727.2307552-17-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:3:17::22) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 05739166-f174-4e17-0c81-08dcbc5b3ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODBMTW5FMjJSVkQ2YWNubHNMK2NvWEg3N0dYVnlBK0J3VmlycFpZdGRQMFV6?=
 =?utf-8?B?VmovaC9PNzN6WlJ2QnN1cnRlTTU1elRyOHZMTFJrVWN0RXZoNXFPcTJjcVFY?=
 =?utf-8?B?ZlArWmVFajBwdzFZbW5rdGx0MzduMkdGVXFWbWYwcXRpVlNjaDRtYWlFYVJ6?=
 =?utf-8?B?V2Y5bHc1di9yN1FCeVpiVHBKaE5Pb2RQcU9lTysrR0txa0cyNTZrakg3ZWt4?=
 =?utf-8?B?aVBiSTJIZ1l5V3BkRTJWMXNyUFljaG5ELzVsa3FlZml6U1EvbzBCOVAvR3FK?=
 =?utf-8?B?RDduWTMwVm9hdWVwWW5GMmFYQzhsZnVKUktTcFZvUWhoMU0ydDJjd1JXUXAr?=
 =?utf-8?B?UGxhUU9icmloQ0k0ekRha0JONWdVTG00b3VBTmNHOXdpUUIrRmI0cU9Ja01t?=
 =?utf-8?B?RzFuVzhnT01QRmVYOVBNOEEvdGtWRjFTeUxlZEJIWUE2MEdTSXhGY0NzUmRn?=
 =?utf-8?B?NTY2TFJndElPWmt6Ti9KcnRKRVlLQzVHYkNIS3QrdllwTy9NbHRSc1l5TG56?=
 =?utf-8?B?YWgzc3pvYnNxbzZhcnRabndQcGZackxRUXNLNThnR1p1TW5ENGY0MnFGNmNT?=
 =?utf-8?B?QUVJUnFCdjQ5VHdIMmZpa3loK0RIMWYyK3cweFQvdS9IWnRqazZIcEEzSVVI?=
 =?utf-8?B?UGFLQ3BUSE5LMmNSaHhXTHhiSjV1NVR2ZUpzOTQrSFliRVZOR01zVjVhZERI?=
 =?utf-8?B?WUxXMU5pTVNRb3Y5d0huTVlSd1VNWjVycWp2WEtiQTdrTm5GVXBCenJtOEpy?=
 =?utf-8?B?Zyt1VUV2Q3N1N0xSNDlqS2Y0WjMvK0RPK0wvZFJDMVZtZ3hLNFZIcmNPVHh5?=
 =?utf-8?B?a3FJQk0rR1ZGWnd1NXVqTTFxZ0pOd2VsOTZoVURPNEFGWFJETUlWcld1K3hB?=
 =?utf-8?B?UmlINndaMGY5YTBLV3hLUnlaZTNkOXVjcmE4V3NJQ0xlZmRZUm5TUGRxOEdj?=
 =?utf-8?B?NHhTUDZiaDMxMWlOcTJYaVRDNUlSVko4ZXNROUQyaHdUNkVPajVTYTBlYTVr?=
 =?utf-8?B?bGNQSmFzQkxZNVkxSWEzUW5GWUxaYjZ1UWFEQlRwK2xaMzZTQ1NwTGRFK1NS?=
 =?utf-8?B?RFlNT1ZqNDc5ZjQyU3ZUOUt1WjFJTjNhS0wvRW9ZWTVVQWtLaHFaZzdEVnVt?=
 =?utf-8?B?b0pRa2FDT1daSi82ekdOajRJTTJldjVpYWpabDhWeUk5VUFxeFlHYjd6TVl1?=
 =?utf-8?B?NVE5b2NhOWdIR1ZuMmg0elNweElGamtscDdlTks5QzZHM0J4cU5NRTZjWTU4?=
 =?utf-8?B?dSs4Q2JlQy9JOXhsaWlEd1EvOFpic253SWUxMGtXOVJvblpveGMxL3FsSGIv?=
 =?utf-8?B?UXVKTnd1aXl5dFZtQnNidnFpWnNKRnovU0RmQUlYdCtaaGwvMCt4SWVzS2FY?=
 =?utf-8?B?R2ZGYW5HMnhVcW5qUjJTeCt3UTJpbGJTQWFHbEYrRU4rbmVMU2RRT3lhaXFQ?=
 =?utf-8?B?OTdjbit4NmEwN3pTMEhmZDErSkp2NnB5M3VZWEEybVkvTk9Md2lOaFBRaWh2?=
 =?utf-8?B?c1RJQ29walFHbkVzMnU0MGllcG5QMWlqb1J4ZmdYWHFVMzcrcWFUelFoRUha?=
 =?utf-8?B?bDdaalJoR3ZGakNpZGVudVRjVVlqeTYwRkhOWXVocTJMU09hYW1UQ015eUsx?=
 =?utf-8?B?Yk9aOHBRMDJoa0lpclhrR3Q0YUh2NXdUaDZFZDZkaEN0ZVJsZkYrQzJpQmZP?=
 =?utf-8?B?b0N1ZWg2YkpDNEw3OEFRZlRwS3g1bjZ5YVdNKzg0dHhybXMvS045NlVkeDBi?=
 =?utf-8?B?V1RxT1lpQzkza3NJU1VWYU8ra0VBYnB5S25GSUVIdFhQWWl2ZXVOWkx1NnhP?=
 =?utf-8?B?bGxaY0tRZ25LMHBNOFRPdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHVyRVhxVmh5SlA5bnFZQVNpNlZSN0JnR3V5K2FRL295aXBrV05FVDBlcHpv?=
 =?utf-8?B?MndBYlhXWnVzTXBLZXBFNHhiam9pcTRLdGlzLy94ZDhldEZwd0tFd3pLY2NX?=
 =?utf-8?B?ZGIyTEV3QWQ2citxQlNLQzF0OWMvMTZDOUphcG5VNHE5U1ZZb0o2S0hBUnV2?=
 =?utf-8?B?b3NlbWlnWTVuZWxpV2UvN1NvWkhyU0s2bGg1aS96OVl0RkZVaHUrMCtlUm0v?=
 =?utf-8?B?NDNLUWJtTXZINFc1bUZtNEZDa0VsV2ZFVVFqZ2EwU3F5Nm9LeUlBRnpwZ1Nq?=
 =?utf-8?B?S0w0S3I4Z3djN1I0M2x4YzdySlRYNjVERTdOSlNoWXc2TFVZcEE0djZ3bHZn?=
 =?utf-8?B?c2o0MFhWOWNsRVcvT3MzTE5jMjkrOFgyQVlZRXI1NWRCZEVMWk50SXhDellN?=
 =?utf-8?B?WDAxYVNGazFrdi93V2JoTGh4THVqZUk2K0FTYzNqMitjRnpMUUZTZ01jQURm?=
 =?utf-8?B?aDVDN05KN29JVGtlbWtlUGtQM1lJUVR2eWNkdkRoZ1BSNElabnRrNDF5T2NF?=
 =?utf-8?B?LzlMMlo1WFhrNzE2WlhZYWVwdHAwYjJKM3RSSWMxdkYwRmNrektzSGE5Z3dD?=
 =?utf-8?B?ZWFldU9rUkV2T3p0aDN4STNqbjlEUXJ4dHVhUHdpeFR3cU54ZzZDMzFJREt2?=
 =?utf-8?B?REVIcWZ6WFdLT2EreGRITmZpbmpQRGFoZ2h0U2s0V0ZjcVdEZ1p0eTB5dlpI?=
 =?utf-8?B?eWVwajJTbVVGSkJuaDhGNGNRQm80SjVqbFBmdVpTTWN1b2E1eUs1ZzUzMzlR?=
 =?utf-8?B?WlBHcEZ2NW5JRVJyMzZRWDY2YlVqK0tCOVExaG12TnN6WmV6VHlQZ3lrQjNa?=
 =?utf-8?B?eDh2Qmc4TWQxSE1hRS9mRGVhVU1nL1duNGdxK3gzTnllMTdTNmdjMzBDYXBu?=
 =?utf-8?B?NlBlZno3Z0llNGlwSnh6ZTNTM1FMY1pvSHl5Uk5lb0NsS1Z6NXZSUStLTUFD?=
 =?utf-8?B?QlIrQThCQTFidnNENEFxS1VvL204YUdNTlNiSHdvRHhEbExLdnE4Y29KbmtQ?=
 =?utf-8?B?Kyt4N0RMQW0zNnBsTEM3ZUwyL2M5d01XRHAxR2xOVVBCYXlrMFQ2a0xMYkJG?=
 =?utf-8?B?a0lWSGs4VmhFSnAzblZ6dkNmREd1ZlN4VlFlNW5ZanlFQ0gySnJWL2s3R2xX?=
 =?utf-8?B?Mjk4cmVMdVBvYW9IZ1RWdktSV21oeDhWc3RXOERkaHNhTEZHWmFLWmtrdURO?=
 =?utf-8?B?WlJORHJrbitnY2Z4enNURlBDZmlCanN6Q3NrcDc3RDFFdlBHak16WlJWRXRL?=
 =?utf-8?B?NG1oenZXNEYwSlE0OGJLNUdTWjcrU3pPRkxxMURqWWFMbHVvTzdBdzVMUjJW?=
 =?utf-8?B?ZGUvT2twbWFOclJIVWJFU0ZVbWNqdFZ1NVVUSWhKeHR5U0N2djMyWllNM0lz?=
 =?utf-8?B?TWJUN3dLUnRPNVBsY05xRVd0elMwVnk5eHVPampqYVlVaGJYMWFBT3dsWmxE?=
 =?utf-8?B?NlkzcjV2Z3UvSlhaMmI3SmpBTGJaaTVBbFhzRHYvSWhQQnljRGVvdWFuY0ZW?=
 =?utf-8?B?SDJUNTlkakNRKzM1eUtWdlBzUkhWdW51dFh5Uzh2Umwvd1FITW9JMlNnZlMv?=
 =?utf-8?B?ZlFJM1dIVXlrZ3hSc2dpcUQ3TWNNV2hQOU1ubEJnZThLeWVSR0VqeTllTzV0?=
 =?utf-8?B?Y2MxRmtwMURGOS9VZk11K3pXUDVtbHJ1aGZuZXRRdVk5aVVTWWxOaU5rWSs5?=
 =?utf-8?B?ZXdRNlRCaXNxWlE5aXJJTmc0dHBBSll4em5lSStmTkNhR3l1dVFmTE9UbCsy?=
 =?utf-8?B?VGtBREkrcFdxRUQ4cmNsd1ZLc0RTcTZKaHhtdG5sRDNHdGxKSERaZnZkbWs3?=
 =?utf-8?B?bFpwVE45bjFtaXdScVM4d2haVm85UDFuR1RBYy8waEd0U2k3cW1TbW96b3Vk?=
 =?utf-8?B?UnhqT2l0a1BraFNwaXFQSGo0d1hacTh2d0xUNCt3cDBqQ25nYjdtOGNYZE8x?=
 =?utf-8?B?elExUDEwN212V2VVcnJZU1lVSWIrKzk2V0VxVTg3blVUSTdqQjZOT2VuLzVY?=
 =?utf-8?B?UTJsbU1NVGh3K0tGTDlpYTBpZzlWMWt2TzdLeEs0SEgxM3RQaEgxREphYkxp?=
 =?utf-8?B?eGNNQWEyOGpVbERyUWxEdmNYeVlBUTFQTEVsbkFQQlFLM2lhdXlFTWpxejZX?=
 =?utf-8?Q?iXoRGCX4iUYZ/6WVVVg6xJifF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05739166-f174-4e17-0c81-08dcbc5b3ee3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 12:18:46.5903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJ6uPYw51JJodnNIenee14c6Fqhmy38cx0GHZJtRkV7gsFx1b1UGm/uJsZ3eJwz2U1zV56sYdY9gr23ATtx1fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8502
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=yi.l.liu@intel.com;
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
> When host IOMMU doesn't support FS1GP but vIOMMU does, host IOMMU
> can't translate stage-1 page table from guest correctly.

this series is for emulated devices, so the above statement does not
belong to this series. Is there any other reason to have this option?

> Add a property x-cap-fs1gp for user to turn FS1GP off so that
> nested page table on host side works.

I guess you would need to sync the FS1GP cap with host before reporting it
in vIOMMU when comes to support passthrough devices.

> This property has no effect when vIOMMU isn't in scalable modern
> mode.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/i386/intel_iommu.h | 1 +
>   hw/i386/intel_iommu.c         | 5 ++++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 650641544c..f6d9b41b80 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -308,6 +308,7 @@ struct IntelIOMMUState {
>       bool dma_drain;                 /* Whether DMA r/w draining enabled */
>       bool dma_translation;           /* Whether DMA translation supported */
>       bool pasid;                     /* Whether to support PASID */
> +    bool fs1gp;                     /* First Stage 1-GByte Page Support */
>   
>       /*
>        * Protects IOMMU states in general.  Currently it protects the
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 9e973bd710..d7e7354db4 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3778,6 +3778,7 @@ static Property vtd_properties[] = {
>       DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
>       DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
>       DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation, true),
> +    DEFINE_PROP_BOOL("x-cap-fs1gp", IntelIOMMUState, fs1gp, true),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> @@ -4506,7 +4507,9 @@ static void vtd_cap_init(IntelIOMMUState *s)
>       /* TODO: read cap/ecap from host to decide which cap to be exposed. */
>       if (s->scalable_modern) {
>           s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
> -        s->cap |= VTD_CAP_FS1GP;
> +        if (s->fs1gp) {
> +            s->cap |= VTD_CAP_FS1GP;
> +        }
>       } else if (s->scalable_mode) {
>           s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
>       }

-- 
Regards,
Yi Liu

