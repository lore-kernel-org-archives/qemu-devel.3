Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93ADC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 08:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPHY4-0001dU-3z; Thu, 04 Jul 2024 04:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sPHXy-0001cv-9F
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 04:10:30 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sPHXv-0005mq-6j
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 04:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720080627; x=1751616627;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ulraeTowOM5dN/7tqNenbpvEpKog5C8tnXJyhss2U70=;
 b=iHhzaSsdiBxk3WxPs1L4sCRNk3imKRNyZJ1oc/Q3ivFZ5Cszu236uf+0
 U1rEwOk5EwQJlQet4wZL6UaOm4UY+76Ioeyu1joPX2DZ21ncm86M4Nrc5
 GsM/3bKeZLMqwDs5mq5DAn5pzH7yc+4rRpu0GZ0U7yQ4nOLleVnnn+zUC
 mSXNl1Z8QWqbbbn+idLPD1RLJwZ8MD2KP12FkC8KtyalzPpBtbmA2/K99
 2kUmVp8P4DuRmaxc1BWTCgPUB8NXYD9ZbOnVGvT3tSppxApM5LQYND6hg
 lwvt7JYI0jhqtSr2lPRnguHvM9lF9Vgp5WPD6e/k7pochJn2RpwwkD1JG A==;
X-CSE-ConnectionGUID: K6Q1MJqZQoWumSBj+BipAw==
X-CSE-MsgGUID: XdsckM0jQr2Ctn8ajU76NA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="27962289"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="27962289"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 01:10:24 -0700
X-CSE-ConnectionGUID: n03Evz8xRGKIteqtrIGNsw==
X-CSE-MsgGUID: VUoKIPRWT26v+3J5bYnRPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="46941136"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jul 2024 01:10:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 4 Jul 2024 01:10:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 4 Jul 2024 01:10:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 4 Jul 2024 01:10:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksSD6QwLRyNm9KtzGEpPlgeBIlIGtB8sTwK0yvIvDzWbqQPYHyOR2Fk+RHGBq/VPAHSP774FDcfLYZxMWVR99Ecb9GOI0oGt0Sc4zJR1NyvXrr5EJX92z4Eg/JwYRIGUjf6LbED7UlwkRBpFy8dlZ7+vyweRXXoU7oJWKTZU5bwPEHQqBxmTRfMjMf+4U+ycG01yXkds5VvKV2wLLE7FICw/2Q+enI+EpS3iXzVSqyhmJXaAZBAyD6haqGs6cJR7jlTva87ly3lE/smJUViE6SsMtKAN+O8DsH3bf8XKqWiZXlbNF2kK9B3ux/T04CNLaewqBXAX3f0BfBQMOb9WFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dM26j+XC04+vYm7en+IKbE6/vZnKawkFez32aXAZHs=;
 b=TQuKm0jyt57vm0Y6omcdZPsQOR8cBz+6tMx2v7uRFkapv8WrA+z7Az77NxU6XzI4t76O3uuErx3SfcXF2JEktfXUITq6uFindpnFOzje/ksyzLUO0tjdJFNYDBRG64WDV9jq9dPBnqGlR72MsizGWj0HAQziYsjuJ0YLG6A/AiTt/wNSSNoP6yP7VrCmnf98btC1drA7r1+BKHrxQEIu4BxdTDGCBvXW8zyizMXMHj5kk7hxi0IptsUGG1t2zvm9UEj2/8SYUUEo91/+mzhGe9iVghNJmjyfLAa03MXO2mzbxmBxVqoS9o/vhHfLPXGeW/Iy40RH7rZO2hJ6y3XZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH0PR11MB5950.namprd11.prod.outlook.com (2603:10b6:510:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Thu, 4 Jul
 2024 08:10:21 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 08:10:21 +0000
Message-ID: <1c480d3c-f501-43d4-a5ee-ce6cca171dab@intel.com>
Date: Thu, 4 Jul 2024 16:14:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Clement Mathieu--Drif
 <cmdetu@gmail.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <1d0c56fe-b821-43c3-9e40-b686573ca840@intel.com>
 <da9c8ec1-0915-43c7-a4a5-9fb28683fd20@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <da9c8ec1-0915-43c7-a4a5-9fb28683fd20@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH0PR11MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: e5095caa-d003-4df5-01b4-08dc9c00bf73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0M2NExVSFN6Z2tnWXRYZEVJbWpseFVtS00zNVJMMWxMUTAxbEIzcmpMRHNn?=
 =?utf-8?B?b3RUSTEzNjBJTDRrUG1zNHFEVGQ0TXM0S0JCdFVvNlIyeFRCZmNIMHdUOE1G?=
 =?utf-8?B?MElHL1ZXR3UxOHN5eTVKWGVjWWV1bjBtWGtRdnI4Rk1Lc2FuMjdSd1gybzNW?=
 =?utf-8?B?NEdUbU96bU9ENFV0RlBQM2p4ejRJWTNNdnI5dUR0OWNNRXJScWpscUhFTTV0?=
 =?utf-8?B?aXBqeDhNRWE1b1FVVUdpU3gxWmNVM2VRUWhndmdrMVpZNERubVpDempuZ3pq?=
 =?utf-8?B?NG9icWl6SE4vY1hWV09LOVR6dGhodktpUzl0eGVwTVJSaUFwQXdPOWg5Mm1E?=
 =?utf-8?B?THk4R3pHcVBESWU2cjdxamg2Q0FnMk9pUTJ4RStaVXlPNE9MTWlUb2xqYkRQ?=
 =?utf-8?B?Z3FuOGxsenJFaFdMcTFybmpRVlNFVVpLdkI4MEZGTTVSdk9pWCtHK3RLNGtz?=
 =?utf-8?B?d2JZcDZDeU9JNVlET1B2T2dnLzliS0NyZjV0MlhYUTVIV091U244YVNGSkZ3?=
 =?utf-8?B?M1R0Y054b3Q3bGplQmtkK3dubG04cHhHYnRPSElJMllxaVVCaEFxMS9WNlhV?=
 =?utf-8?B?TGpmREp6Nms5LzAwZjZBT3lxclZwR3VPcW1sMzVHc0l6c2YwNHJYQXVqdm1J?=
 =?utf-8?B?SVFnbCs4Ri9rNzNqWkV5WHpsMllsOW9xMjRNZkVZaTdlMmZYaHdGOXpPeWRu?=
 =?utf-8?B?WjVjR3RweUJOY3VKeTJ2U1d2TEdtQmZ1QXAwVjlsNTNtZ3NENjJzTGdwMzBO?=
 =?utf-8?B?VFNMSzZGaEVOdU03V3BGcnN0TmM1ejRydit6SXpuNEZ3VFBzM2hvVFI5a0hB?=
 =?utf-8?B?RkVoQ0Y2TEhQSXR4QXFrRnlQRStSU3lRTThsQXN5cDhQRnRyV0JIMnFxcDJR?=
 =?utf-8?B?OVY3TFhjU000Zis0S2kwMGVYMmdVYnlxUTc2c0orL2g4ZDZtMVdDSENJS1lP?=
 =?utf-8?B?U2FnYU5vQWpYN0dDVUFvVFV3ZGt1NkpwSWJES21rcS91enk3UHV0TFUrdUhk?=
 =?utf-8?B?dnRSWTRGTit5RVpObDZTcGNQbXV4Q1FzQXpPUk5xcWdacG4xSkxxNzRsa0F2?=
 =?utf-8?B?MmYvTVY1REs3N3ZqeWYzMU5MT0dNUm95ZlJwOXlUTFBXQXpmUDJIREFuQXY3?=
 =?utf-8?B?NjAxVTFOSTBVSnhvaExrenZtT2VZVi9maGsrR3plYWxHR0RBZVRSbE9KYmV2?=
 =?utf-8?B?Q2U2ZENUTGVkcVk4UnhkV3h2N2crU0VGODlWOEZvOWR6MzZTdTlsRWdkWUdU?=
 =?utf-8?B?S2lLQzh3VDZqVzhJM1pnS2h1SUxGelI2b0F4L2t1VXZoZUgvbWozWTVoNCtn?=
 =?utf-8?B?Y2NCeVpEOFhXQXlhVXoxVFlEeVVUL3MreWdRYVk1MXhDa2ZYbjdGdE13SDBU?=
 =?utf-8?B?Z1RQWkl6NyttQ2ZSRlR5TjhXSnNZVnBQenVmNGZMd1JsNll5RnVtTmMyQmk5?=
 =?utf-8?B?RysvWWU1TDBjWkZMSnhYdWg3VzRwOGVnUkZNVWc4TjBJWWlMeG5kZkJLNFFR?=
 =?utf-8?B?clYvWXM0ZnBUMGpkMmdma3gvcTkvY0lkMmt5S1hVc2pITmhSVjJUaHJwazNy?=
 =?utf-8?B?RTRvR1llSml4WEU4MkZiRzliU0pUN2lsWng3L0sraVFveGs4OThxTHE3WmlL?=
 =?utf-8?B?YlZON1VIajVDV3R6aEpDZmp1WEZaNkdGdHMvY2xNZEd3bW9TTFd2cFVKVnZr?=
 =?utf-8?B?aFJUTTV1TVZOQmFYWEJYK25hN0xzZElFYkZIMmdHZXlUazZxalRsNjhXeWRm?=
 =?utf-8?Q?aZjZygqH5SwRHrpQZqLSZVrk1g9RFcYl2R1NQ+u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR11MB7540.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkpQUWhUcTYvdkdxV0dIZnoyU0ltLzJjc3BjeGxMZ1Q5VUN5RTRidFhGZlM1?=
 =?utf-8?B?RHgrZmZJMnpBblNYQlJMYmN6NkF4UmxjemY1NStEbnRGQ2Z0ajVWMGVNYXFt?=
 =?utf-8?B?NERHOXdEbWorMEJQb3NFQXFnQnZuVkRJdG9FaDZ3TjcrTS9YWUZDbGpCUFEz?=
 =?utf-8?B?UGFxZXFYUmgxZGxzVWpUNnBrLzJrUVc1UExpdm0xRlEyUEp6eHovTStYcWtz?=
 =?utf-8?B?YWNHbmVUMlBDYU41QjdWdFFJMGtFdUg1aWRIc0Nab2dwQzUySEh2ZmxwYmY5?=
 =?utf-8?B?MlNkRmdvK1p5MFNZSUk5clNXZkluVlJuNnB5djA3MHRhR2pQUVZxVXAzUHRG?=
 =?utf-8?B?SkJIbHZpUFpaaG1nWkxyU2t4NmtYeEU4cjI1VmQ3T2E2VlNibWQrUURRWklv?=
 =?utf-8?B?MkFCa0hHWTl3eFZlbTRKK2tUNnFCcHZsSWgyUXJsbGh5RE03WXk5V3VsUGJt?=
 =?utf-8?B?UnppMVNnNmZoS3RrUWJUQnhvd2xMdkVPS3M3ak5WN04zTG13eDlDM0R6KzhV?=
 =?utf-8?B?QlkxVndpam9KaTQzQnM3K3FnK1diNVVWVHdydEJ2d1pLQVBWU3FIOFVzVFZF?=
 =?utf-8?B?S1J3d2hlRUFqK1RIY3NwRlFZbUIxaE5MczZPSSt2cWJMcXRDMmViaTZTNjgw?=
 =?utf-8?B?Y1piajEwcWJTZ05xZCt4YjR2Q09GYkVybmY3dkNCUytpMUJxb3dzdkVXcDdO?=
 =?utf-8?B?TWtEcXF2d3JRSTNCZ2o4VkxFTVJmWUY5SzNnbTR4dWgxcHc1blcxRzBVNjcx?=
 =?utf-8?B?TGxkTlM0NmN2NUFGak1RWnQ0N285c0RucTc2VDB1c0hHY21jdU4wRzdiY3E4?=
 =?utf-8?B?VFp6YmRYMGxJelk3WDE3bytGYjIvNmJCQ2pJQmI1dXgydHBxekVKbUlwNVIz?=
 =?utf-8?B?NElOYWJwRE5mZWJKVEZCT0pLdFpoSFdFcTNLaFVLR015S21TUlorc0xISTRj?=
 =?utf-8?B?ZUtRU0d5bzZlQ29BbmJmZlFsTHFQalJwaEVKQ3lmUWQ1UGhaWGkzYllwcGJ5?=
 =?utf-8?B?UzRMeFZCcWdSVThVTTBhbU53T2JLOVVOcXc2a2JXRmdUWTlDY2pCWmd2NVZl?=
 =?utf-8?B?V2c4b0hJVXRTMk5uZFI2aU1Kc2VrMnNERW9zcDFCanMwcVBuejh5Vms1a042?=
 =?utf-8?B?Z2dpSm13UFFhTzlPSlZScjBCS1ZnYXhQZ1crZUY0a0RTK0UzenYrYUxFbEVy?=
 =?utf-8?B?aERQbHBaMTBDUWZuaEpZWFBvWGYrK2xrVnY2YXFCMy9peDRRcU1IVmdybFlZ?=
 =?utf-8?B?Qnh5VFM3R2dENmU3Vkd6Zm1HbGtTQmFrNzIyaEJSTy9DbDh3Vk5YOEF0M3dk?=
 =?utf-8?B?RkVxa3BjRXR6Z0E5dWxpMTBlcVBQU1UvMEliVzNGVXZqUThLQVlOcFBVYW9k?=
 =?utf-8?B?RlNySnd5TUpSM3dORVhHemhYeU43NVhMWGJjeDZseVpMMEQxODU3aExaQXBW?=
 =?utf-8?B?Qm5BRGE0WmhMbkpubmJpS2E5bG9LamJEVkYzdVdrdE5GWHV2RUxtc1ZDZzN3?=
 =?utf-8?B?eDR1NUdva3IwTXo5enJsYXp2c2FwemZDSXA5Sk95S3BscExYSzZzOVdwL1Rq?=
 =?utf-8?B?UHNiUGZCMGl2WURUZTdBZGRUcnJDTk9paU04QjFuSzdKNzlvL0lFMkMzalVh?=
 =?utf-8?B?c3pEdG1wdm1MdWtCdk9KaGtyUVI0RmVYTnpHTWNLbmZjNW5mV0lsaUFtMEQw?=
 =?utf-8?B?Y1IzejA5aDByVjUycjdkV3FUajZLL1VrTURXemVxWEhhRXFmdFQrUEtwZHJV?=
 =?utf-8?B?MEw1UzVZTm00MFpLcGlqMDVvWWJtZVd3U0MyaG1ONm8xQ2RpNzZzdWJsYkUv?=
 =?utf-8?B?T1F0TWdiWUFXVnRzLzY0QUcyZGo4YkUwcXByTXBxOGxJMGZ1eE5NWnp4eTF5?=
 =?utf-8?B?NVJZZjdObjZQa3dBMFoyU21ZZW1QTjl6aWtaa0M0QTUxWXNKZjFYcnFrdklX?=
 =?utf-8?B?MWdzNFl5Z0NiS2graGI4OU8xM1g2V0tVYStXRzg5aGMyMmpmb0hObnlSR1FS?=
 =?utf-8?B?M1djblhmM08xZFNUSlZuU2c3N3dHRVRjWEZQMUhQejk5K1l6ckRnNUZadDFF?=
 =?utf-8?B?eGRBQmZFYW5ySHZPNTZsekNSVUhIVjZTd1ltTmxRUjJsN0V6Mmhpa2lIcmNK?=
 =?utf-8?Q?xT67r46kBv7FxWRvzSTW3qmnM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5095caa-d003-4df5-01b4-08dc9c00bf73
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 08:10:20.9271 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsA4mjrgxY0u7TrjzN4xGpCsFCxF9JXvh8pvOM9fncPC1MgN0kyNuqEiGPpFWfWR0VJdpAN25eK1R9KSKt8Cdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5950
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yi.l.liu@intel.com;
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

On 2024/7/4 12:36, CLEMENT MATHIEU--DRIF wrote:
> 
> On 03/07/2024 14:32, Yi Liu wrote:
>> Caution: External email. Do not open attachments or click links,
>> unless this email comes from a known sender and you know the content
>> is safe.
>>
> Hi, thanks for your review! very efficient!
>>
>> Hi CMD,
>>
>> I've went through the series. Some general suggestions on the series.
>>
>> 1) Patch 01, 02, 04 can be sent separately as they are fixes.
> Will do
>> 2) This series mixed the ATS and PASID capability a bit. Actually,
>>     they don't have dependency. I'd suggest you split the series into
>>        - support ATS for the requests without PASID
>>        - support ATS for requests with PASID
>>     The second part should be an incremental change based on the first
>>     part. If you can make use of the existing translate() callback, then
>>     it is possible to remove the dependency on Zhenzhong's stage-1 series.
> The final purpose is to support SVM, consequently, we only add support
> for ATS with PASID here

yes. but no need to put all of them in one series. Just like you sent
the PRI series separately.

>> 3) Some commits do not have commit message. It would be good to have
>>     it.
> Ok, I will be more verbose ;)
>> 4) Some helpers look to be used by device model, if possible, it's better
>>     to submit them with a demo device.
> The demo device is already in my GitHub repo
> (https://github.com/BullSequana/qemu/tree/master)
> It will be sent in a future series that adds the last features required
> for SVM (splitting the series to make reviews less painful)
>> 5) A design description in the cover-letter would be helpful.
> Ok, I will elaborate
>>
>> On 2024/7/2 13:52, CLEMENT MATHIEU--DRIF wrote:
>>> From: Clement Mathieu--Drif <cmdetu@gmail.com>
>>>
>>> This series belongs to a list of series that add SVM support for VT-d.
>>>
>>> As a starting point, we use the series called 'intel_iommu: Enable
>>> stage-1 translation' (rfc2) by Zhenzhong Duan and Yi Liu.
>>>
>>> Here we focus on the implementation of ATS support in the IOMMU and
>>> on a PCI-level
>>> API for ATS to be used by virtual devices.
>>>
>>> This work is based on the VT-d specification version 4.1 (March 2023).
>>> Here is a link to a GitHub repository where you can find the
>>> following elements :
>>>       - Qemu with all the patches for SVM
>>>           - ATS
>>>           - PRI
>>>           - Device IOTLB invalidations
>>>           - Requests with already translated addresses
>>>       - A demo device
>>>       - A simple driver for the demo device
>>>       - A userspace program (for testing and demonstration purposes)
>>>
>>> https://github.com/BullSequana/Qemu-in-guest-SVM-demo
>>>
>>>
>>> v2
>>>       - handle huge pages better by detecting the page table level at
>>> which the translation errors occur
>>>       - Changes after review by ZhenZhong Duan :
>>>        - Set the access bit after checking permissions
>>>        - helper for PASID and ATS : make the commit message more
>>> accurate ('present' replaced with 'enabled')
>>>        - pcie_pasid_init: add PCI_PASID_CAP_WIDTH_SHIFT and use it
>>> instead of PCI_EXT_CAP_PASID_SIZEOF for shifting the pasid width when
>>> preparing the capability register
>>>        - pci: do not check pci_bus_bypass_iommu after calling
>>> pci_device_get_iommu_bus_devfn
>>>        - do not alter formatting of IOMMUTLBEntry declaration
>>>        - vtd_iova_fl_check_canonical : directly use s->aw_bits instead
>>> of aw for the sake of clarity
>>>
>>> v3
>>>       - rebase on new version of Zhenzhong's flts implementation
>>>       - fix the atc lookup operation (check the mask before returning
>>> an entry)
>>>       - add a unit test for the ATC
>>>       - store a user pointer in the iommu notifiers to simplify the
>>> implementation of svm devices
>>>       Changes after review by Zhenzhong :
>>>        - store the input pasid instead of rid2pasid when returning an
>>> entry after a translation
>>>        - split the ATC implementation and its unit tests
>>>
>>> v4
>>>       Changes after internal review
>>>        - Fix the nowrite optimization, an ATS translation without the
>>> nowrite flag should not fail when the write permission is not set
>>
>> It's strange to list internal review here.
>>
>>> v5
>>>       Changes after review by Philippe :
>>>        - change the type of 'level' to unsigned in vtd_lookup_iotlb
>>
>> list change log from latest to the earliest would be nice too. Look
>> forward
>> to your next version. :)
>>
>> Regards,
>> Yi Liu
>>
>>> Clément Mathieu--Drif (22):
>>>     intel_iommu: fix FRCD construction macro.
>>>     intel_iommu: make types match
>>>     intel_iommu: return page walk level even when the translation fails
>>>     intel_iommu: do not consider wait_desc as an invalid descriptor
>>>     memory: add permissions in IOMMUAccessFlags
>>>     pcie: add helper to declare PASID capability for a pcie device
>>>     pcie: helper functions to check if PASID and ATS are enabled
>>>     intel_iommu: declare supported PASID size
>>>     pci: cache the bus mastering status in the device
>>>     pci: add IOMMU operations to get address spaces and memory regions
>>>       with PASID
>>>     memory: store user data pointer in the IOMMU notifiers
>>>     pci: add a pci-level initialization function for iommu notifiers
>>>     intel_iommu: implement the get_address_space_pasid iommu operation
>>>     intel_iommu: implement the get_memory_region_pasid iommu operation
>>>     memory: Allow to store the PASID in IOMMUTLBEntry
>>>     intel_iommu: fill the PASID field when creating an instance of
>>>       IOMMUTLBEntry
>>>     atc: generic ATC that can be used by PCIe devices that support SVM
>>>     atc: add unit tests
>>>     memory: add an API for ATS support
>>>     pci: add a pci-level API for ATS
>>>     intel_iommu: set the address mask even when a translation fails
>>>     intel_iommu: add support for ATS
>>>
>>>    hw/i386/intel_iommu.c                     | 146 +++++-
>>>    hw/i386/intel_iommu_internal.h            |   6 +-
>>>    hw/pci/pci.c                              | 127 +++++-
>>>    hw/pci/pcie.c                             |  42 ++
>>>    include/exec/memory.h                     |  51 ++-
>>>    include/hw/i386/intel_iommu.h             |   2 +-
>>>    include/hw/pci/pci.h                      | 101 +++++
>>>    include/hw/pci/pci_device.h               |   1 +
>>>    include/hw/pci/pcie.h                     |   9 +-
>>>    include/hw/pci/pcie_regs.h                |   3 +
>>>    include/standard-headers/linux/pci_regs.h |   1 +
>>>    system/memory.c                           |  20 +
>>>    tests/unit/meson.build                    |   1 +
>>>    tests/unit/test-atc.c                     | 527 ++++++++++++++++++++++
>>>    util/atc.c                                | 211 +++++++++
>>>    util/atc.h                                | 117 +++++
>>>    util/meson.build                          |   1 +
>>>    17 files changed, 1332 insertions(+), 34 deletions(-)
>>>    create mode 100644 tests/unit/test-atc.c
>>>    create mode 100644 util/atc.c
>>>    create mode 100644 util/atc.h
>>>
>>
>>

-- 
Regards,
Yi Liu

