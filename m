Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB121C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 10:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUwY-0007V7-SW; Mon, 26 May 2025 06:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uJUwV-0007Ua-HU
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:20:27 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1uJUwS-0002Gg-Gf
 for qemu-devel@nongnu.org; Mon, 26 May 2025 06:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748254824; x=1779790824;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=e+9+wY1NThaQACYMqojZUoTmCukWZYS0mFSIkBm7cSA=;
 b=lsmzovyzhdAX39YzMzCjusjiafafEV4zWTZVMQxiEkco0AmgNoKQHPlo
 DJbX53s4meEKCnLhOhEq7hc3VXOJQDI0CoyOMZCB0RAU5DfTcjNpUPAhr
 KR2UoVedQqDci730t7sf3fI0rO+jIYc6F4ufzKYvapZ5gO/lPTmV1kfNK
 xm+I+rA5BjTrO+AmtvBGTXjDWh82OtRzvEoEDS6H5K1l3K85oPWCKW6O/
 yAsdgocfjvM8Xcq3AJPBbSTKrNtcS4Bk64FQ47dPve2+huuPCykgaSxOd
 HJnHD8lwt1FARoRSGguC+IoHlHMeVNw4c6NHhdj0xTTyVoCp98dwB7WSA Q==;
X-CSE-ConnectionGUID: E+mydr2YQdu+3rfJRGdcIw==
X-CSE-MsgGUID: k5Ju8uXLTJG+omDec7PRuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="50150848"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="50150848"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 03:20:21 -0700
X-CSE-ConnectionGUID: v5/RyZsySkCVHqkGX+naYA==
X-CSE-MsgGUID: gqPBXVJxT0W4ikg8q/qjJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; d="scan'208";a="165504405"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 03:20:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 03:20:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 03:20:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.85) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 03:20:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jth0bQe/fRah+Et9rTBxB9pM8SMhecQxK6uatwyT9FY9n52cwawvEAvBUACn4h3OwZy0QAGq9YTkOOA+ql7cKr8uC0UijNUuQZmh71E9iS2B8md0kwfWrKyN480pJAvxMk5+vj+gF+WU2IGgkgRBTsSbs9KyZlLuOLYE05h5rm3lxSqASC+2jbR3KTsgH3Rg/w+vLRPjNJGey+rtDDWtgaZ1nn2+ex/kd7J/XA1SRApRctcU5yJdpLoIPPIeYRA5FtKrclvNP2HauffJw8huPk5QPDqhD8tuXdGvq968fekciw7wT2VCqd/ed6DQp4kkC6obSg7OqYy9zwj9q0sKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLPY29KDDMyS6vYT40U5CvKEndwzsgkFgwyxamNMVBc=;
 b=KHdwTJazok2IBKhmrD9Lbedn9XCfTYl6RR17TZGM8w33lwZdwzgST9NTNcsleTN1BhL7YQUbHkX++3ONRL59zgz8nsAlcd9pwismPaYrTJWxgN3tnoJCMK7lCwNXcaecRFcrd4OLrjoBTVYkHsfSVMg1aESZcuzmV8FLXzJwFMAP9oCOfbj0GXN5g5Oasz7AGBrVxCJW9cWX3PDaLiqccQUUNqQAO+P2TpLBicyl/y0Ns3y8H4lvyl9Dw2vQ9EEoNJda3TgI8Dt75fQiLEjO8OyalepEpeR30e5SA1ZdFnb8U5pquqUYWkYKK63pZKavd0TbPDJZux1fytMr/r1scw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 CH3PR11MB7372.namprd11.prod.outlook.com (2603:10b6:610:145::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Mon, 26 May
 2025 10:19:49 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::3225:d39b:ca64:ab95%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 10:19:49 +0000
Message-ID: <1674a16c-e4fb-4702-a21d-9c4923528b2f@intel.com>
Date: Mon, 26 May 2025 18:19:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] ram-block-attribute: Add more error handling
 during state changes
To: David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>, 
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>, Baolu Lu
 <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>, Xu Yilun
 <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-11-chenyi.qiang@intel.com>
 <6b5957fa-8036-40b6-b79d-db5babb5f7b9@redhat.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <6b5957fa-8036-40b6-b79d-db5babb5f7b9@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|CH3PR11MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: e097b502-f42a-43de-219a-08dd9c3ed835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2ZSdXRnSjM5Z2JXZGF5V2JqQ1E0U0JuN1ZadEVyNlNjaUFZZ0pNRUsvOHFZ?=
 =?utf-8?B?RW1HNHRnWWJ0OVJTNUt6NE9wMHNrRjNLRTlsQytMT3o0VkdZbTB3KzRPVlpS?=
 =?utf-8?B?OEhNR2kzRzVyWmJ0TlorYWorZ3RONUt6MGttT1NubytURUlEUjdtdzJYN1BP?=
 =?utf-8?B?b3RuV01PQUVhWWxFMi84NDFJSFNpK2M2R1VQYmo3SnBIVzNlZEhDL0dJRSth?=
 =?utf-8?B?QkY5WFZxaEUwekgwSGgvMzI4QmdyeEZCZnhPd0ZET2gwcW1FUDVlTWtCSEVp?=
 =?utf-8?B?Q0dhb1hjMUpkTEJYUWhPQVBvVVNadEVBOVd3UWhOUEpvbm5YbUkyTDB2N0tq?=
 =?utf-8?B?MlVkWStHNzJXc2tHUS91OVZuZmthYnk1VnMyMFdqRXlnUzVwWmpHVkZjcSt4?=
 =?utf-8?B?dWFIMFF4dkJvc24wMWlIWHQ3L0tlTzlBNitITGJRRmRYVUkvc0lpcEd1V25x?=
 =?utf-8?B?cEx6OVBlamRycWZWcmlqWk5TcURrbCt5L0pwa1VESTFRYU5FRVRoK3JIWlN4?=
 =?utf-8?B?SUhQNUtEblhDamRQendaRllJWDI4VldDME53Y0w4bDU0dlJmUERRRWhpYmlk?=
 =?utf-8?B?QnR0Ukxxdk51ZVNJN0UzdC9qOFZyRURBOXVDMVpZZGppT1JyWWtQdVFqTUV4?=
 =?utf-8?B?Q21lWC9KT09QK25oRFBJYUNnbWdwUnhSQzB4cG5zazlZd3Ezdy9VeVV4MWRV?=
 =?utf-8?B?WDl6Y3dVMWlWR1kzL2N0aHF5OUlXOXVvZG5tcUgwSUVVMVJrV3ljQ1ZlbmlK?=
 =?utf-8?B?ZCtHMEhraHpOZHpvbU1GSHZmaytZcW9CcU82N2tJYUw1S3dSOUZhSVBaRGhD?=
 =?utf-8?B?clFJK2MzZTM0NUFUQnU3SjUyVUh6TzNUOVhjZ1dleHhrRVhNNFhJSHIvU21J?=
 =?utf-8?B?WkdlY2FBekxBOUsvT2Jkb1hicFRTTmdXU21MZ2ZnNTZHdXVQeXhXREhQMExt?=
 =?utf-8?B?TEgvQzZST0FLOE1BZExzbmQvVEY0ODF4ZVVtUzF6aS9XNk5xajFHQWMvVzAz?=
 =?utf-8?B?MDYwV3pqMUpjcGlNRDhIUkJqd2xheHpxaHp0UzhMSUUrbjJ6UG1OMXBYWklU?=
 =?utf-8?B?VFl4WXJha2NWandzNVVDM3o5Tzkzd2JGbDlrTnFtMHhVSjg1QTAydGxXaEZX?=
 =?utf-8?B?WUxVY1pxN3NJWEViM3BQMFNBLzZJMkM0cEJERjJCcXlkeXpMWUY0dFlWNFg4?=
 =?utf-8?B?SS9kazlBdmxoeUJCWUE5NkZ1RlNUa2NKSldreEJ5TFlIZkttRDF1aWpIZUx0?=
 =?utf-8?B?RlZwM25zYjh0T0F5ZkhBS24wNlJnOGx3Z05TbjZHQWtvMEMwc0VkTjVXZnk0?=
 =?utf-8?B?N1JwbnRPbjcyZm9Sc05GcENBK1pFSmpQV3BYQkJJeW82OE0yZ0VjTWY1QlZX?=
 =?utf-8?B?RzBVeWxRczZYOVc5T2Z1bkFDeGRkYk4zcHd2NmxJaCtFZURyYVU5YTZlWDJi?=
 =?utf-8?B?NGp3SVJ5c3R5Vk1mSjlhTTBZUDdCUWZGZHRQWmkxd3lGRlc5WDBveEdQZzM1?=
 =?utf-8?B?MHJiZkJJbzdHUVZmY2pCeUFyYmZTMThGdjRIOEVzL0NjUUlRTlhEOXZwMXRB?=
 =?utf-8?B?VzNIVkJlNWRsWk5qNmI0UDU5WVNPeE1Jam5oaVBXNW5ydHF3aHFrUVZ4SlBm?=
 =?utf-8?B?ekVTOGdURnUyK3FlRHhkd2xObEM4blUrbUZJbWNjZHNVSWRWSUpvTmR3cGg5?=
 =?utf-8?B?aE8ycDFSMW5LTElGdnk3T2Uxc3ZVN3JIMGJvVzg5UnZUR291Yk5HNFJzbW8z?=
 =?utf-8?B?VExJQUYvbGk2U0oxSThjZU1aMU5yeTJ1Q3hZa1pqNFBuWHUxcXNoaWJjQWRN?=
 =?utf-8?B?TFlHeGx0cDZxRjA3ZHp6WWJSRTJLMXQ2NmhlMGxuYXBENlJSZFZvdlB0NDU0?=
 =?utf-8?B?L0xxRkxqVEFQaXJWMGRpaHhTcXV0ejJzZWN1Q1R3Vy9La2dNUmpBWGkzVkp5?=
 =?utf-8?Q?WdkmuEIcRVo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGc5NzBTcXpYbjVjcG9NeTQyU1dzMmNQa2EvY1c0STlFSHdYV1BKdVF6VUNK?=
 =?utf-8?B?bWZhbnpXcDA2MVFrSDhjY01qZ3J5SDdkemhjeHd0UWxBRWV6a0xYWnJKUzJ3?=
 =?utf-8?B?ZzlLOXNJRjFDTkdYL2pxbGNoMGZuMGJPaEJUMFdDVFR4dnVnQmVocDdrZkJl?=
 =?utf-8?B?YzBYTjNQQnNjNm9RZ0pqQkNTM0hPTlYzV3kxa1paTk1QQy9FdTlIWjgzeTM3?=
 =?utf-8?B?bGNwcjM4cTVaUDJERjkzUWVjbmNwSlFsTXpKME1jM1JNQ3lQOGFyMDdUTGdi?=
 =?utf-8?B?SnVaV3FqbzJTWFF4RmJKdml0V3ozRnUxVVFtbEFzYTlUY1ZFUVZNR25LRSs3?=
 =?utf-8?B?VXJjK0E5U1BRTUxiV0s5ZE9VNDlOUlhnS3AvUHZPQ0RGdHdQSnFHR3VXUEVX?=
 =?utf-8?B?R0ZPMk15azEzelkzc0FIazJEdm9XRXZUTi9NRGRzMVd6aHlNeUpYVFVpeHpq?=
 =?utf-8?B?SlZIVEVLanV0RXRlZDh4NXNHYmxvVkhTRE1TbjdsWUl2L3BFVHZBVStHTGZC?=
 =?utf-8?B?TXdLWGlOZjlBcjlFdHlVb0FYVU5PTnRVL3hRVW5ZaDhaY3E2SFh2UlVTa09G?=
 =?utf-8?B?VGFub3QyMHVVTHhnbFExcmJPOVk5a1VLcFVra3FIQ1hVT1pCdnRZWHloeHlY?=
 =?utf-8?B?Q0R5SER6VDMwRlNjcWxIZUpndTByZG5tSEZYY2QvSnFCNVFhbjBRanFkL2JY?=
 =?utf-8?B?Wm45MHgwM010WFNXVzhaZXpYb0E1cWhJdHluZDFwSk1rMHBSWG1sMTQ5YWlw?=
 =?utf-8?B?WDgwQzF1WHJtMFQyYjJxaSs3dTI4WlpzcWRqZkxEcXUvaUFJaU1nb3JBbG1U?=
 =?utf-8?B?cmxLckxZU1IvanI1SmV5Smgva3NSOExaU1QrN3lCU1V4bUlHM3JOdVdsUmo5?=
 =?utf-8?B?WnZWNUlKSFh2cVdyb2F4MS9iS0VKYWVDTythbXlhcWVzcVliZ3NCTDBaQXF6?=
 =?utf-8?B?em13TzYxL1JLVG1zeTlsOUhVTXFXVlBuelBoMmRTSGQrMjZVcEJ1TFJNNWFN?=
 =?utf-8?B?VVkxeVRsWDdwaGptTjY3b2ErL1c1QXI1VTNUNnRDazhXem9oTlpReExrcFNn?=
 =?utf-8?B?THh4bkwyM0N1ZG1Ecm1oUDZkSXdtSkpaSzdUSzl5dUpWMFBVMlRMamZtS3p1?=
 =?utf-8?B?ZE9NYk0zTjVoY0tyNGNSOXNPekU1d3cyejdaZTlqc05idkY2Y0dIb3FFZHVv?=
 =?utf-8?B?OTZKa2JHZ0pxTG1ZTExIMldVMlFOZ1VObWVFVkpEVHdMZ056b2E1eVVzVm1M?=
 =?utf-8?B?UnZPRkZMTGhrMmplL3FhVS8yWkVKUW9pRDlRL1ZRTk5PRHlaMFJLN3MxK0ZB?=
 =?utf-8?B?RWR6by9xRi9saTUxMXFCSFlkTGxKRTBmbVBJM1c2QjR1ZGhZNUN5bXJNNTF4?=
 =?utf-8?B?MXROSGNVbnVycjIzM1dsMVlTN2paRGRFZzNKU0tRY3JTanFma1ozRk5sYVI1?=
 =?utf-8?B?eGUzUEdibHpUYkpIKzRBZGNFdzEwLzdtNG1tWGtHaVk0cmx2aTdwN0J5ZXNT?=
 =?utf-8?B?azBTOG9WOUw1TWExWXAxaVhUUkc1bWVTWXVDdTF5Y1E2WkQrU1NOVTNqZWZS?=
 =?utf-8?B?VnVuVjZsTHozc29Bc2g0UXM5WDhlMEpQTFIyWmxsNWFOL3JUNkNPc3ovYzVa?=
 =?utf-8?B?NGxvc2tiU2VQb2VUNlBOajlpelY1Z0plUCtTc1NCM2FORHIwVGdJQkNtUDRD?=
 =?utf-8?B?d1JvcXRJSllYRlJobGlXbG4vZWR6RXNObTdUaHAwQVF6TVRZdjVoT0tLdnRI?=
 =?utf-8?B?ZkRKVndhaTN5eXl0K3lDQWFMMGRXR3o3bnlkYVZHSTBWVGkvRGc3TFRIMjNW?=
 =?utf-8?B?LzZnK1prdmh5bjlyMUlJQ2I3RW9NcGdUSEVacC9UelJxMjV3VXVWdnBPQTB2?=
 =?utf-8?B?V2g1Qm5hUGhySE50clhwMENEQUlDSGZacU9XOVBuaHN3OFdlbWFBYkR5TWhm?=
 =?utf-8?B?THRSZEVZejBrTUg4ZkF0M3A4Ujc2c3BBdEkrZjRZK1ZMTWZsQnFtV0JOREJr?=
 =?utf-8?B?RmZxeE5Ia0Z5dzVrVTVSVG9lZXNGcms4bU04ajFrQjhhVUU2NmhzK092ME1S?=
 =?utf-8?B?TTlLY0lrQy85a3ZoSGtYL0lzYnBoWWNVYWdZQ29xVXFoT3R6VUExWVNpNnRL?=
 =?utf-8?B?VmZ2Y1A5QktLODZxeWhkR2lQMXRwZDZTTTZqUjVmKy90bXhNQ0VqRWIyWTZI?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e097b502-f42a-43de-219a-08dd9c3ed835
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 10:19:48.9118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aQqiuIG5KqAcOwmgoKER4R2OM9kC/RYablRIF/8PGJv4tvuqkczX9Q34T69It9K+h2/4j3GAvnfedhhrktBpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7372
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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



On 5/26/2025 5:17 PM, David Hildenbrand wrote:
> On 20.05.25 12:28, Chenyi Qiang wrote:
>> The current error handling is simple with the following assumption:
>> - QEMU will quit instead of resuming the guest if kvm_convert_memory()
>>    fails, thus no need to do rollback.
>> - The convert range is required to be in the desired state. It is not
>>    allowed to handle the mixture case.
>> - The conversion from shared to private is a non-failure operation.
>>
>> This is sufficient for now as complext error handling is not required.
>> For future extension, add some potential error handling.
>> - For private to shared conversion, do the rollback operation if
>>    ram_block_attribute_notify_to_populated() fails.
>> - For shared to private conversion, still assert it as a non-failure
>>    operation for now. It could be an easy fail path with in-place
>>    conversion, which will likely have to retry the conversion until it
>>    works in the future.
>> - For mixture case, process individual blocks for ease of rollback.
>>
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> ---
>>   system/ram-block-attribute.c | 116 +++++++++++++++++++++++++++--------
>>   1 file changed, 90 insertions(+), 26 deletions(-)
>>
>> diff --git a/system/ram-block-attribute.c b/system/ram-block-attribute.c
>> index 387501b569..0af3396aa4 100644
>> --- a/system/ram-block-attribute.c
>> +++ b/system/ram-block-attribute.c
>> @@ -289,7 +289,12 @@ static int
>> ram_block_attribute_notify_to_discard(RamBlockAttribute *attr,
>>           }
>>           ret = rdl->notify_discard(rdl, &tmp);
>>           if (ret) {
>> -            break;
>> +            /*
>> +             * The current to_private listeners (VFIO dma_unmap and
>> +             * KVM set_attribute_private) are non-failing operations.
>> +             * TODO: add rollback operations if it is allowed to fail.
>> +             */
>> +            g_assert(ret);
>>           }
>>       }
>>   
> 
> If it's not allowed to fail for now, then patch #8 does not make sense
> and should be dropped :)

It was intended for future extension as in-place conversion to_private
allows it to fail. So I add the patch #8.

But as you mentioned, since the conversion path is changing, and maybe
it is easier to handle from KVM code directly. Let me drop patch #8 and
wait for the in-place conversion to mature.

> 
> The implementations (vfio) should likely exit() instead on unexpected
> errors when discarding.

After drop patch #8, maybe keep vfio discard handling as it was. Adding
an additional exit() is also OK to me since it's non-fail case.

> 
> 
> 
> Why not squash all the below into the corresponding patch? Looks mostly
> like handling partial conversions correctly (as discussed previously)?

I extract these two handling 1) mixture conversion; 2) operation
rollback into this individual patch because they are not the practical
cases and are untested.

For 1), I still don't see any real case which will convert a range with
mixture attributes.

For 2), current failure of memory conversion (as seen in kvm_cpu_exec()
->kvm_convert_memory()) will cause the QEMU to quit instead of resuming
guest. Doing the rollback seems useless at present.

> 
>> @@ -300,7 +305,7 @@ static int
>>   ram_block_attribute_notify_to_populated(RamBlockAttribute *attr,
>>                                           uint64_t offset, uint64_t size)
>>   {
>> -    RamDiscardListener *rdl;
>> +    RamDiscardListener *rdl, *rdl2;
>>       int ret = 0;
>>         QLIST_FOREACH(rdl, &attr->rdl_list, next) {
>> @@ -315,6 +320,20 @@
>> ram_block_attribute_notify_to_populated(RamBlockAttribute *attr,
>>           }
>>       }
>>   +    if (ret) {
>> +        /* Notify all already-notified listeners. */
>> +        QLIST_FOREACH(rdl2, &attr->rdl_list, next) {
>> +            MemoryRegionSection tmp = *rdl2->section;
>> +
>> +            if (rdl == rdl2) {
>> +                break;
>> +            }
>> +            if (!memory_region_section_intersect_range(&tmp, offset,
>> size)) {
>> +                continue;
>> +            }
>> +            rdl2->notify_discard(rdl2, &tmp);
>> +        }
>> +    }
>>       return ret;
>>   }
>>   @@ -353,6 +372,9 @@ int
>> ram_block_attribute_state_change(RamBlockAttribute *attr, uint64_t
>> offset,
>>       const int block_size = ram_block_attribute_get_block_size(attr);
>>       const unsigned long first_bit = offset / block_size;
>>       const unsigned long nbits = size / block_size;
>> +    const uint64_t end = offset + size;
>> +    unsigned long bit;
>> +    uint64_t cur;
>>       int ret = 0;
>>         if (!ram_block_attribute_is_valid_range(attr, offset, size)) {
>> @@ -361,32 +383,74 @@ int
>> ram_block_attribute_state_change(RamBlockAttribute *attr, uint64_t
>> offset,
>>           return -1;
>>       }
>>   -    /* Already discard/populated */
>> -    if ((ram_block_attribute_is_range_discard(attr, offset, size) &&
>> -         to_private) ||
>> -        (ram_block_attribute_is_range_populated(attr, offset, size) &&
>> -         !to_private)) {
>> -        return 0;
>> -    }
>> -
>> -    /* Unexpected mixture */
>> -    if ((!ram_block_attribute_is_range_populated(attr, offset, size) &&
>> -         to_private) ||
>> -        (!ram_block_attribute_is_range_discard(attr, offset, size) &&
>> -         !to_private)) {
>> -        error_report("%s, the range is not all in the desired state: "
>> -                     "(offset 0x%lx, size 0x%lx), %s",
>> -                     __func__, offset, size,
>> -                     to_private ? "private" : "shared");
>> -        return -1;
>> -    }
>> -
>>       if (to_private) {
>> -        bitmap_clear(attr->bitmap, first_bit, nbits);
>> -        ret = ram_block_attribute_notify_to_discard(attr, offset, size);
>> +        if (ram_block_attribute_is_range_discard(attr, offset, size)) {
>> +            /* Already private */
>> +        } else if (!ram_block_attribute_is_range_populated(attr, offset,
>> +                                                           size)) {
>> +            /* Unexpected mixture: process individual blocks */
>> +            for (cur = offset; cur < end; cur += block_size) {
>> +                bit = cur / block_size;
>> +                if (!test_bit(bit, attr->bitmap)) {
>> +                    continue;
>> +                }
>> +                clear_bit(bit, attr->bitmap);
>> +                ram_block_attribute_notify_to_discard(attr, cur,
>> block_size);
>> +            }
>> +        } else {
>> +            /* Completely shared */
>> +            bitmap_clear(attr->bitmap, first_bit, nbits);
>> +            ram_block_attribute_notify_to_discard(attr, offset, size);
>> +        }
>>       } else {
>> -        bitmap_set(attr->bitmap, first_bit, nbits);
>> -        ret = ram_block_attribute_notify_to_populated(attr, offset,
>> size);
>> +        if (ram_block_attribute_is_range_populated(attr, offset,
>> size)) {
>> +            /* Already shared */
>> +        } else if (!ram_block_attribute_is_range_discard(attr,
>> offset, size)) {
>> +            /* Unexpected mixture: process individual blocks */
>> +            unsigned long *modified_bitmap = bitmap_new(nbits);
>> +
>> +            for (cur = offset; cur < end; cur += block_size) {
>> +                bit = cur / block_size;
>> +                if (test_bit(bit, attr->bitmap)) {
>> +                    continue;
>> +                }
>> +                set_bit(bit, attr->bitmap);
>> +                ret = ram_block_attribute_notify_to_populated(attr, cur,
>> +                                                           block_size);
>> +                if (!ret) {
>> +                    set_bit(bit - first_bit, modified_bitmap);
>> +                    continue;
>> +                }
>> +                clear_bit(bit, attr->bitmap);
>> +                break;
>> +            }
>> +
>> +            if (ret) {
>> +                /*
>> +                 * Very unexpected: something went wrong. Revert to
>> the old
>> +                 * state, marking only the blocks as private that we
>> converted
>> +                 * to shared.
>> +                 */
>> +                for (cur = offset; cur < end; cur += block_size) {
>> +                    bit = cur / block_size;
>> +                    if (!test_bit(bit - first_bit, modified_bitmap)) {
>> +                        continue;
>> +                    }
>> +                    assert(test_bit(bit, attr->bitmap));
>> +                    clear_bit(bit, attr->bitmap);
>> +                    ram_block_attribute_notify_to_discard(attr, cur,
>> +                                                          block_size);
>> +                }
>> +            }
>> +            g_free(modified_bitmap);
>> +        } else {
>> +            /* Complete private */
>> +            bitmap_set(attr->bitmap, first_bit, nbits);
>> +            ret = ram_block_attribute_notify_to_populated(attr,
>> offset, size);
>> +            if (ret) {
>> +                bitmap_clear(attr->bitmap, first_bit, nbits);
>> +            }
>> +        }
>>       }
>>         return ret;
> 
> 


