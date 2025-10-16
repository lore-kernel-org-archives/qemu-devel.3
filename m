Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17E6CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mp2-0001oB-IU; Thu, 16 Oct 2025 08:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v9Mp0-0001fH-BE
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:11:06 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v9Mon-0007LU-Q1
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760616653; x=1792152653;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=96c7W70cMh9i789+ZJfMVY/RPZC6ReWGOMcHLkbIHEo=;
 b=jqhavS7Gxx+sSjrgDGrZZBinT18UeWzJ7duiruyS8BEX7RvDUCnGQ76l
 MfuHFSMK+yeCY2adXRAfPlb1EmUl9Ju3G/n+Jjf1z5llfBPjZ1iYVmBJM
 db+jo7FkrQ9tHHxzSNg90W9AMYNlU/4I1kGxC6j4F7p8t3JfaFFJlzOUy
 y2vE4NTHJBPQ4RrKlsBe+M1xojmcI+YMU0zEsaEwM7tD7CzdPPEYb34TT
 Zj9dde8f+5D1yr9r8/+Ggd3tF+6Mb3krkbWR+/Hmy0N2uYUmL27C/bcmA
 IDpWn7TpcMJKaowY8mNckuW+HHMp8N0pFRZYOa4Sgh5Kau7skiu0QOdEE g==;
X-CSE-ConnectionGUID: fSJjFBpISRCinfL7TxKpBQ==
X-CSE-MsgGUID: iB9d5AfQRPm11ZKxPcAL7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73407216"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="73407216"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 05:10:46 -0700
X-CSE-ConnectionGUID: SIdnh6YmRFuSTibtg7STVw==
X-CSE-MsgGUID: Ee6sEPcpR3ip1FdbBiin6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="182008815"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 05:10:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 05:10:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 05:10:46 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 05:10:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEMvKjKoPmwPB4kfc6eWl01482VDqoqXLF0R0MgS3/IUKDxBCrmRD77iDc+NIGIW7dKkEfPNuXtKa4jvLABs45HrUeCb8vJETzUK6jjoo6JhBKC69NKD44ryzEiDoEwfPsQuBQHvdADes8BLJSwzTnrj2EDfSu2LjYKzBmjxW36wmHcJwCKuw0LHnkrx8k13G68gfck8I1e4pHNFUL4PxmnTddkU8UJVAUDtBiq8GJgvol5mGRqumqa5WAuL8IdxbrrM2Jdi4vIWF9U3+j+Z1qcgq0DT7Og+f2txQzYOh9PkmBFXFIwRlpx61zw9XPEorvN0vGk6Jto+xetshoDhPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIRmPlBauBrENzFEiKnHsXULXnqs7F5mLhmOWG7eAu8=;
 b=glJvddT2Dr1FqjDQlQoj927HypL+w3sYXcTdm083nRyLqqGWXrH193Sk+s3utkQVGYMlb/Fgb2tuA33ttR26oF36ZyE6LhKzDyqqT/hmjbfI+derIvoxJTuaXGb0QShjeUj5BIMjD8NoDRN8tMGcnDhDyvqpYpJLvwBtgYFSo7vzX5n1VNzuwKNXbOvKGF4qrqun+0dmibFVxasrnWJJdwIEvLQjJzq3Dc0Jpm1YyUOPDGBkIfMsTaolLE9Yzt0NC0qaqLJSTB+4nrACKw4e3XpzFTkd61NFh7piqY5tsKp1+oCSWBIvcMqXSKoVHItzTRieBeVVe93BKVkk5F8enw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by PH0PR11MB7168.namprd11.prod.outlook.com (2603:10b6:510:1e9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 12:10:39 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 12:10:38 +0000
Message-ID: <f3a3bf0a-e002-4ef2-a8c8-43df511a7f3b@intel.com>
Date: Thu, 16 Oct 2025 20:17:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] intel_iommu: Handle PASID cache invalidation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <clement.mathieu--drif@eviden.com>
References: <20251016074544.377637-1-zhenzhong.duan@intel.com>
 <20251016074544.377637-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251016074544.377637-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0002.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:17::20) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|PH0PR11MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 259fa467-765b-4b4f-a195-08de0cad04e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmxBd0luNnVoTkdvWC80OGdvUVpxRlp5bDE0VGp3ZHhvdzh2TE1HUXVSdUJW?=
 =?utf-8?B?ZldLWmozcGJ3WWRtTVZCMjVFT0Y0ajNRVTZBMjNubTROWm81WDlQeCt4ei92?=
 =?utf-8?B?UkpwblQ5YTJheW1LUCtoNUVWVTRjR2hmbjJhQUVtdTRnQU1WUHIvQ2doM0xB?=
 =?utf-8?B?UUU0QjVNd2dOTi9mLzNLNEYwTUtmbU1QNkltczlKaUU1NVRmVHZLZ29xbHJL?=
 =?utf-8?B?bG9RcTVpTis5bmVBd1pFYmlLZWlWdUVvLzNYT0JtYmErZzgyODB3MDA1dFhM?=
 =?utf-8?B?S1V5Q0JxQjRKNm44cTIyQkNCNWlEOWFWQlBMYzl0WWJOZzdsM2g1THdkYjBL?=
 =?utf-8?B?REt4MDRRNmJWSUc0VzhHYlFzNzJvQWRiU3BOOTlwKy9QQ015NXBPaDFQRStm?=
 =?utf-8?B?SmJ6NlJNLzl0dEN3RGtPT1V2RkpPSWtXaHVQZE9raStSd0FMRlVlL2JDRVlo?=
 =?utf-8?B?bGZhY2NocFdCNy9WQVJXUHhOWENqd3N1WmF6em14VUZob1BYcUk2TndzYTRN?=
 =?utf-8?B?Z0F0NmhUeEUvYVNBdm5USDRDRUtBWXIvUW9jTWZZNng1MUU4TWMyMStRdGpn?=
 =?utf-8?B?SEE3UklDZStCd1BROFFlZHV0ZmdReWxteS8zbTR3Tmt6ZGM1YVQ0c0VtUGg4?=
 =?utf-8?B?YW5LVCtZYWlZdVJIVHZoTEdEMnVvN2J2ZVQwSE5JeTBYZHhLQ3hxdmIvV3RN?=
 =?utf-8?B?RndJUUtTRE5tYzN1aGd2RGpLanhHUHk3RElmME9UMTJza3Z4M1Vja2Nncy9P?=
 =?utf-8?B?Z0RkdCtWZVRoTXRCMEdoTTZnTFZXdXI3NnpQc21OZ0dRZ0RPNWZ0UDd5ODlo?=
 =?utf-8?B?STM5RExYNVEvZzJSa3NvMmZtakVaWnlYS1p6dk1HejU2QWR6NXlGUWo0UGov?=
 =?utf-8?B?N0tiaFAzVkgrZ1JCSGFGMmFXTm5IREozcnlaYWdRYVdKOG9oeGhJMlhJZVBO?=
 =?utf-8?B?a1pjbTJSSm9WQTQ2TzV1aFB6aEpJczFieHR1enBDSG5HOFZnajZoV2tRMkV6?=
 =?utf-8?B?SkRFdWNGcGk5eU5xMDI2YmNtUDRaem1TcnozZ1d6N3NlVXpJWGRCd2tyRXpW?=
 =?utf-8?B?MnptVWlLelJ2M0lObndvRTdHWCs3UjZpaFhhbk52aXpSQVRQZnJtTkkvaW85?=
 =?utf-8?B?aGtBMGQ5T0Ira3I2STg5R2Y1Wk9aU2I5dHB2eUc3bDlsZGxrUkR6LytHc2JU?=
 =?utf-8?B?Q3d5ZlFCNkFyMEFDRFN4NXFqZTZuN2FwamcrV1NVT1kvaC9YcnV1d2JCRjJC?=
 =?utf-8?B?Z1dHTDM3czFKQVA0azlSZWtSR3BwRGdvNEVQcy9kQTJXUE0yNlJUVjNZRG9k?=
 =?utf-8?B?dUdqKzB3UzlMV0tYVUNHNkFUbm9pc2RiQzhIQjhKYmZpSnA2YWRWbkJPQWRu?=
 =?utf-8?B?MGF2THpHT2pnaExvWG9aYXUyUHpFV0JpTkNPcnBHdmdEY3pUZE1aQUpGNHZX?=
 =?utf-8?B?aGZtZmFPMzdmM0hXV0diU1BwQ1AzK1hZbkVWWWdRQjkySG5OVllMOHJXMUNK?=
 =?utf-8?B?ZUNsN3NFMGhKTThRcTJVMkRSekhtMHlTNTg1d0VaYnoreUhMRTNSNTEvczRo?=
 =?utf-8?B?SUxtTHhTdkFmSEZ6djhEVzVIUVBvRko1ck0vMDF6VER4VUNuamxaQ0xRdE5N?=
 =?utf-8?B?QVJOdGxXZUV4WEcxYktoclNjWTdqc0hNTW10eFBBQTAvM28zMDlxb0Fvc3lr?=
 =?utf-8?B?M1hPbS9YS0Fla3hTQTJWUUJvbmQvV0NjbnlpRnQ1SzcxUStkazJ5T3ZiY1g0?=
 =?utf-8?B?UkNPbHJnQzdkVGVKbVl2SFBHbUl0dElFWklmWGUzcjFOUHBOVjhxWnVNd0FL?=
 =?utf-8?B?bnljNVFBdFoxVXBkUkxldWt3WW9qbTcveWlsd3IwdXJEUXR5UHZFM0U0bXBr?=
 =?utf-8?B?N3pMRHlMelNnU2dYN1JIdHptWWkvMUh5SkI3bnhNZHRGSk85bmtIR1JYUTdk?=
 =?utf-8?Q?HDYN2GbPS9FvtgG0GrPE97DF3mjFvpSm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkR5ay9VYXNFNFV0WVBGM2ZWcHhhUFVXUXMvbGtyZGxmcEZRSlN6VmRrN3lp?=
 =?utf-8?B?bmpPWkdSazcrY0ZINUlvYlJKakV1NldQc2YrY1ZpRW9YZjdIVnJhMFVQeTlp?=
 =?utf-8?B?RVZMd1liK1N5OGhRNlpYbHlpUnd0NTYzSlRqWllBUW15aE03NUtBbWV2Snh2?=
 =?utf-8?B?OG0xMnJKMVJoMDhpb0JaU3JZaTcvaFUyVXdPdTZnZjcwbS9LcW1LaEdvbUla?=
 =?utf-8?B?NUxyTjI4Ky84ajYwK1A4aW9tL0ZKOG1kNERMUmZ4UUJiK2dqS1VOclJYZ2lF?=
 =?utf-8?B?WHZ3WHdnSTJjTnZWekVZMmZLS1ZMeXlPSy93cUR1SnNzeFp6VFVleGNrRlIz?=
 =?utf-8?B?cE5GaldBeTdDeW1hYUdsaVNMbDBLRWE0dnVYcFZkS29tanU3TzJMaHZyNW5x?=
 =?utf-8?B?eTFGcG9LZ1h3aGE2Vi9DMEN0OFlFVWZ4cmxCYjdzaHN3UDhqNm14MWJac0Q4?=
 =?utf-8?B?anJNNDZ3bmoxcldvTEljOUJpT0xCLys5NDZiRTh0TzRFQjNIS2g2OXp4Rnht?=
 =?utf-8?B?WHpXaEo1ODZiN3N3M09YYnBCOGcxdFFXaWNLYnlKaFVZTEYvVTkxQTYzSVUr?=
 =?utf-8?B?OGEwZnMwZXRpTTFYMFhldHlTWTBERUJzZHNFQ1RJZ3d0QXVYZE5URitXOFRm?=
 =?utf-8?B?akRlSk5jelpGR3AvdDFNSG90T2JaMXBNR1JyMHlZTHJzREd0SlFPZFdCdk00?=
 =?utf-8?B?akVtNmQ3bmhFUE03L09PVWZWelNiTHgvbUFtOVFlOUdBd2hscmhCV3QxVnpa?=
 =?utf-8?B?bUhwRkJZbU94Tk5iUG5YZEhwcWx5N1Y4WU51d1BkciszaXFwVmx3NlljbWI3?=
 =?utf-8?B?N25ZWXN0Vjg5ODFzV0VaV2ZWNlhQbkJXR0czQ1Q0WmlBTE9lUFNHMlp4M0t0?=
 =?utf-8?B?czg0a2o5QVN4c293WWNxQkcxUURTUTZMcHZQUy9RWlU2MkZ0OU00TlcxZElF?=
 =?utf-8?B?bW4xUUVML1FybE5wSXhtdGwzU3RKV1R5akx3WHR4dFhwRXdPTC9Pay93QWth?=
 =?utf-8?B?Qk5CcWtkWWYyNHMrMFo2aGMrM0N3bytKdXVseEVPZ0FGSm9rRTBZYmhtcW51?=
 =?utf-8?B?eEgxTEVhcFNWN2YzNmcwbitwTldaWTBKTHJRTC9qL3RyRHpBd0pFMUJieEVJ?=
 =?utf-8?B?UzY5NWRZeS9DT0Fscng3MHNzY0U5cEQyamRnaENNSFBhZ0NFZGlSUTViL1dm?=
 =?utf-8?B?Um10YUlDWTJLL0xhQnlVWjlVK3Q0d3ZkS1VHUmQxSmp5QTRhcHl0V1UyY0F5?=
 =?utf-8?B?bDgrNXYxeDROSHVpcnN5S0tZUS9ETTdNb2hSdVRZdEd5MnVUenVnL0NISkIy?=
 =?utf-8?B?UVI0dVZlUUpvQlhCUDQ2UElTalVwQ3VucCt1M1NXUHE3clUzOWFZd0piZmMz?=
 =?utf-8?B?QmRGWVYwUVE1bythNEgySEMzMGJwL3ljUERSK3dwdTNWRHlVaCtCZnNSa2VU?=
 =?utf-8?B?dVdLZ0psOEtWdjJvVXhOd3lWRVVkTFBxeElQbU9pTWdjMkZUYjdIZnBMUTdv?=
 =?utf-8?B?cW91ODg4Z213ZXRlWjhzeUhpRHczTWxHZ3k0N1ZjdnNwaGdrQlB5T05yemJi?=
 =?utf-8?B?eVlPZUJOZHhlSnM4a0dtdVlHM01GZnJFbDN4ZEFVeWREUC8xdlg0NjFQUnJr?=
 =?utf-8?B?L2N6Z2pYaU1qd0hzVUVEdmwxZGUyUGJJdG9rN2Y1TlpMdDhNME5aYnp3OHgr?=
 =?utf-8?B?ZkdGS0lwamV2KzdQNVZiTnJpOXFtN1NuRkJXSmdsZWE3VW9WeEdaM0s3dXlv?=
 =?utf-8?B?TlJ2TlFtUzJmSnEweVlXcVd0ak9KZlRBeTVnTStOLy9zbUk0SW53VE1nOTVy?=
 =?utf-8?B?cHVsWmMwdWtMb0FST0VCWDM3OFN2Z3RLeHlEdDJENTJ5TUMwRW1XOWc1T083?=
 =?utf-8?B?T1lVQXpDWTVNak1CcXhBM3Z3Q2IvTS9jODNXS3ZvSnRrdlVZYk8xU2k2MXlj?=
 =?utf-8?B?M2tBTFBDQk9uL1oyOXo4ZmFHSEYzYnpXZXJwUFMrZXI3WGRjNDUzN3dSbEs5?=
 =?utf-8?B?eFc1T3c1SUhmRS9KSDYrbENNdGwreDUyd21iS3RHb29LLzRQTHphNVpSOVdD?=
 =?utf-8?B?K0pQaHZ3VFdaa0JwdG05Zm11SjJJSW5WNUVXWmJ1SzlRRzRaVGZvTkZNNmJW?=
 =?utf-8?Q?q512o26rAoehz4Z5MBBfRdUl4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 259fa467-765b-4b4f-a195-08de0cad04e5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 12:10:38.9005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8bgdyqZUgz1gzMkZ5EKbLsHI4d7QCY85KDij5Ow9WdajXoEIwc3ul6/0zGa1YLiLmgaAymbmoozLjGzjAq1gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7168
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2025/10/16 15:45, Zhenzhong Duan wrote:
> Adds an new entry VTDPASIDCacheEntry in VTDAddressSpace to cache the pasid
> entry and track PASID usage and future PASID tagged DMA address translation
> support in vIOMMU.
> 
> When guest triggers pasid cache invalidation, QEMU will capture it and
> update or invalidate pasid cache.
> 
> vIOMMU emulator could figure out the reason by fetching latest guest pasid
> entry in memory and compare it with cached PASID entry if it's valid.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

