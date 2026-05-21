Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05683CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 11:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ209-0003VO-6v; Thu, 21 May 2026 07:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQ207-0003UC-Du
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:55:43 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQ205-0003Zx-5U
 for qemu-devel@nongnu.org; Thu, 21 May 2026 07:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779364541; x=1810900541;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=f1wTzFTVyi611jwW5JrNJYx3lTV2ATjpDuMtxtmdpaI=;
 b=ZcrXhNPLj0jDk0xtZWg+FAmgtfkv81JdcHugA8jbwqWFMsm8WEVZX0Tw
 FqudDLHJ1x0/p8NzwKfy2IBn5j6JrR8zUvi6pnh5iqfHxTm3TMYPY2r8A
 MShoDheBDj7lWE5J/XZHqmXuvlMFi4M1ebN4WamyuslOqREujXxd5TeaF
 NcR+bCkzIMOapps62Z/3RdAlgTStKosuSQPkrqvLh/1K8ELQUDRPgiG3a
 XOKWuJDzZk/wQGTWqG872cMwrADeMw2gs7y4NfUCpCDnpq5eDUwr7C08c
 CXdNfrW/8wTJUrvzaNxw8U6oILITwSqU0OUfIljin9/9cIZkZdENJ+/jN g==;
X-CSE-ConnectionGUID: OmfkUhjnTriy7ts7yoDUHQ==
X-CSE-MsgGUID: OrxUaaf0S9GLm2QSN06QYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80314206"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="80314206"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 04:55:39 -0700
X-CSE-ConnectionGUID: In8f67DpQHKWkwsQaPM3cw==
X-CSE-MsgGUID: qbRIM5x4TGuSOttESfFVXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="237907765"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 04:55:39 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 04:55:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 04:55:39 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 04:55:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/ZOqdh8xMkzQcHXAhlErpALWDjPCKUm3w1q7WQZfhd69Xj9/jdXj4mj3OZIPs+fa45WOHaSeFT9jntg9tON0L6CwJhBR/wPArEaMN80l0toR1Ix+BY3NwZVOEZjXWf9+1eme16kfXeNUzXNpOgjBiDJVk0cTNpn1VSHfZgk9nPj1y8rn27sa1TiMRBGZdgYaDidTqFCPpriu5t/QCDUZMfgAelEmePTu6snroH/Bz8Snpbx4lfamHvSZ2VTpR3PwpPx4YVlFFpyTUkTyR2QQ/l3RASbQPOdlsdq0KwU4XrIDSpozxk34HRE82f1qertpBFwJC4qjvGVbDzl327+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7EysnU5C0lloVr5XubL8G4gSLWUwZ+i+RtlRyMp4FI=;
 b=G70/8ly6vI5wbfm1NjVHwGKFnhd51skTCfMSJa7kHLqtW3jiZXNh3fl2U9dqxrRtksBUyzJlD7Ruz21yA8ugxeep86Oq0ocetOQ78AfUuGXv1vaQjq/X4xSSU2/c7b8ni1CN51LOah2rUaXjSr7gUARHX7IX5kVefxyadVoNZCuQ+8pnOpdfn05L0hR79lTT0a8oqLEL9ZcQND3OFD17Lw2wcmTO46l5kwUjLh9tyXy6LdNGlip/m1Yv8sp2M368nzs5bEj9pTYGtK0FJrZVb0SQMU3vitz7yfOJz4MVSB4q8HXz7jACL56siqYM7Kn4Ca37dYaCnEfrPG7m83IesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by LV3PR11MB8484.namprd11.prod.outlook.com (2603:10b6:408:1b4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:55:29 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 11:55:29 +0000
Message-ID: <a628bd88-f15d-4b92-8dc3-9394f6e50a41@intel.com>
Date: Thu, 21 May 2026 20:03:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] intel_iommu_accel: Accept PRQ response for
 passthrough device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260327025228.474257-1-zhenzhong.duan@intel.com>
 <20260327025228.474257-5-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260327025228.474257-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|LV3PR11MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d899a9-603d-4e13-fcca-08deb72fdaaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|7416014|366016|4143699003|18002099003|56012099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: q7dPdbAmsLkdHzd0GisU868d0T/tLBqGNafgiAeLTLG+HaT5M8Y/2JBZiTrUiMQ7yMFwNRCsaV2oauLCqKf94sBc9le3mM3HVH3storIl0qpBXjTfIdxS6iLzuBtP+b9unxFaZghJBOlAE8EZaH+3aKaC11I8cHmia4u9ZNVRp8K6YCg2B3wWR8xchwIQ+nZ+IX5e8qiRhW52a9CVK3IhrLzzQbpYO12+ktjCwiK9uODU2ogoEQrSAtsN/Nh1qXLCz5ZsI8MXlAU4qdPFYi1NH5paYFvKYujdKNBQH2O3TpDKbEi3D0P9BIazefWCWC1XNpoNr9d9lynu9pi99GAKTkZs1/X8TXs4GaEPJX4rKQMQDamqIT8FnAWNd1onylIQ5ZrRcs7sIm1b2lOArHUfYpvSYd+vTEJlU6VXnXsb4i1fMMhW3VaQ5bgtUr0sGt7dMI6SbyHkwhl5YeM0JGPA9n/fJ7hMWleorvwK+CIGHpinG0NdlTmd3okU4up8dIi1Heib3efPJq+epgIG+6w/BJKbdtmyacGMVibJoVfMY8DduAmtJBLoENN30PUe0t93TQwW4E2HTGtm1ui+uVqTkJcZ5z72OWSiCEQ7vaz0I4N8LuNpyHFRO0TV6IITlfRzOUSVNokkM8VC5rKhANPdOW9sPxTxR3Wa2UZ1TkkqS0yWM+SYmr7SDG58Zta7mdj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(7416014)(366016)(4143699003)(18002099003)(56012099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFpZVDlJeC95UTByTWVPOTYzUUE4U2wwVUI2T1FBaGxBNmxVc2VxeXoxaUpQ?=
 =?utf-8?B?Y1RyM3RBM29ta2pPSXNuUFdUbUt6R2hGdjcvcjFxTzUrb204akhic04xdmtZ?=
 =?utf-8?B?TXZMWWY4dVJWZmZKMzZqMjMyM3BVY2lEMTZhY1FKdkVNVDhOczZ3V1NId2FN?=
 =?utf-8?B?RjBaYlNFTk8walVMT2E2WUUxR3dTb3FPYnA5dTZhcStNYnREdHh6RDdmdnhz?=
 =?utf-8?B?cFlYTndVZlh0VE5TV2xDWERNbllqY0FvS3hlN2hPcDEzVWd1dkV0ZXlwaGlU?=
 =?utf-8?B?S0dJQkJ2TDZSQlVPYzJhS2N5Vm5HUWxseThNZmltdkYwNkxpdkx6dFhvMkxD?=
 =?utf-8?B?b1RaZUZjZmV4QmlNVlFIb2ZCcEs2Q0c5bHRka0ZPcUxmTDRTRlJvUkNhOW9Z?=
 =?utf-8?B?SEdiVElSNUhIQlFJMUFxazZYWkdJc2tZUHRIdlBYajdrbklhZ1I4Q2RVd0tL?=
 =?utf-8?B?d2tSWFlCck9scURyTTFTTTVwd0RhT3drZ1Z5YXcxN2QyTFpEU0h5ZGdPWXho?=
 =?utf-8?B?dkszSUttZit2T2cyS2hjeHUrT1JBdHlpcEFnUGNiVjlmTVBXODlWQzd3Snla?=
 =?utf-8?B?b2xZS1lKdmtEOU9kNWJiRnBobFNZcmxOQXUwTy9KUkQxVFNEL2RlcUcxamVB?=
 =?utf-8?B?UVpVeVJzQ21VbnJpdDAvOERSNjVjeVdHLzJrUEFYWmxJOVFtR2ppR29yUWw0?=
 =?utf-8?B?QjZraWQ2SWV0T0hxQlZQWWxFa0tFUjMxYktZbFNsMGxFL1ZwdlpRN0tkWmpK?=
 =?utf-8?B?TTNHdFR3UlU1T1ZqMnhOMHBMd3R3WWQ3L1pOdHJDRnBIS3VIZ01jb3VDbUpn?=
 =?utf-8?B?MEd6Ym5ZUWhtQU1KOUMySGt1MTRUNlIxNzlQMVFObGE1K2hDcDZadjhpWEhs?=
 =?utf-8?B?d1JKZzYvWmZLYXp2OTYzNzlja1V3MncxTjQrTGVuQmt0WDU1ck15Y3l2amlE?=
 =?utf-8?B?dStZcTlXeGFubHNKMG80dUp1WHJsNUhPY3ptOTRwMmthWjEvZHN1T2FBaC9r?=
 =?utf-8?B?YTB0Qk5WQUlIb3AwaTF6VWY1QlpaT09aT0hvRERhYXNmOFdQQkg1dHVSMW85?=
 =?utf-8?B?UzdHZnpGdUNIRXNocnV0SVptUVVyd1dXYVVXbVJVMjJFcmRRZFZxQVNGRWtt?=
 =?utf-8?B?cGlLN3NwaVVkT0NmZUFJTGxYTkhQbGZjaitOdkgyNWxmZ0Rjdjl6M2I1dVZt?=
 =?utf-8?B?REI4UmN0aSs5alhDWnVLRHhOTWEyRER6VnFaN20wdVUvN2Vrb2xMVldUTVpJ?=
 =?utf-8?B?NEpRZDk3MlArdkJPbkhoaUIwL1ZrNkhsdWZsR3UxUUhxbGhFWkdUTjM4YmpD?=
 =?utf-8?B?Q29kT1hGbVpBY2RNTmgvTUVNbk5jck5TOWt5SngrQmlaeXR5elpOV1pRQVE1?=
 =?utf-8?B?SzV1M3hEQ0xKTEoxbW9QSisvdDJMQS9hcUZXbnNMbW94cjVVNkZRRUFrMzIy?=
 =?utf-8?B?UUNHalZyUkRnYjFKeFI0VE96ZnJPNTNxYk5LUmZBOE84ZTJLQ2JnQlFydTJR?=
 =?utf-8?B?all1VWQvOFREeWx4OWo1VCt5Rmdkcmx1U0xZL3NiMGZQYU5VR3NlamNwS0hi?=
 =?utf-8?B?LytRMjZDS1BRTkVMSW5uZWdiMjh1UkxCWlVlcnp0VkFWVUcrS2tMUkF2bXlp?=
 =?utf-8?B?WHpjaTVHaHNuWTlPU2k2eVR5MndNUHh1Q0hUNkp5Ujc3aXExakxpc1FFNzdK?=
 =?utf-8?B?SWhPYWNQdnlzY3RnSWJCN1VJcmUrOCt1TDJKTzlOWU9odGNhTkJrTXQyNEhV?=
 =?utf-8?B?TWNOb3ZhbmNrWVF4cTU2K2RUQklmc1Z2VEdIWlZCQVZJbzc0Szk1dWZoRWg5?=
 =?utf-8?B?RDV2TFlIOXpvMk9CbjdRUFYvVklkY1JoeXVCNllvYk1mWm5EVzcwSE5DalZB?=
 =?utf-8?B?bzhYeXNSWTJiQWlnMlAralFzaWZyaENqUkdrQVZjNG9DR3ZpUll2eGJaa1pI?=
 =?utf-8?B?MmN4MitmZlN6aE5IOXNVbk9NeklLMUJXcmRwV2VVdzE2WDdzc296Ym9JZWRT?=
 =?utf-8?B?a1U5emk4dDRxWUI2UWYyRTlBUTJWWU9iVE9KeFZGdjZKYVFOSHl4Q1dqbjVT?=
 =?utf-8?B?SGpkQkFWNmJhRDJ3K29VOWhxbXV0SEpjMElsSTdOdnByeC91QlE2c2pYbFFX?=
 =?utf-8?B?dDM1M2dzWXllbXZ3SHYzZFRKVUNveWk0VUQwVnc1WEFQbEVrVWRYalpxTHRu?=
 =?utf-8?B?c05xUzRBSnpyMFp4U0NlQnR6cWtTTW93WnY3dE9kOFNzdWxmQlh5REFoM3Vh?=
 =?utf-8?B?eGFEdEFkNWhhR2JaZjRIMXdzaThCQ3lqenRQaUljWGpkNzJ6eDY5YVMwbVFx?=
 =?utf-8?B?QVNPQ29kMkpDanY2UVdmRXQ1ekVHSmJSRFhVaFJrRnIvMTE0TUxIZz09?=
X-Exchange-RoutingPolicyChecked: XzPFeLGTlZvUpaWoaaG/VjkSazGE1F5BhnZZcJg5oyoMhRuWWVnZSVq6SmkkaRQcjl9UaknOsiQD4ZWajyqx9F4lWI6LSD8iwcottTzPafvLgEVbnmjz8om1S8syrS2yxXawWGeMFccDQG/oxvOtnEYUpA38EdCwKqNqXM43P/KJdxvbLPHX+ToiaQ2hkQOqN6Dc9nCAhlwGVI6ZXj6dIE8cvMAnpMtD4ipw40gaHChpdacQwcgwx+9Ns6ugMqFNHHxHes76jU7Pl/2dcp+dsKxIAFVuhA9DZ+lS3fP/DY3P2vEl0NxxQV7PqOVTBSj78h6Aa/jJG+LnuUYN1I2wYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d899a9-603d-4e13-fcca-08deb72fdaaf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 11:55:29.5192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9et6qKSrcuF99GagG/CbtdVVLe1InTpWk9NTsSlxDqZGyzZCNXAciZFif2JnDDMUElxBzPQSRkxnvTPVt+6GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8484
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/27/26 10:52, Zhenzhong Duan wrote:
> Propagate guest's PRQ response to host by writing to fault_fd.
> Create a new VTDPRQEntry to cache cookie for each fault group,
> this cookie is used to mark the fault group on host side.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_accel.h   | 14 ++++++++
>   include/hw/i386/intel_iommu.h |  6 ++++
>   hw/i386/intel_iommu.c         |  4 +++
>   hw/i386/intel_iommu_accel.c   | 65 +++++++++++++++++++++++++++++++++++
>   hw/i386/trace-events          |  1 +
>   5 files changed, 90 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index 10e6ee5722..b46c7126f7 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -19,6 +19,9 @@ typedef struct VTDAccelPASIDCacheEntry {
>       uint32_t fs_hwpt_id;
>       uint32_t fault_id;
>       int fault_fd;
> +    QLIST_HEAD(, VTDPRQEntry) vtd_prq_list;
> +    IOMMUPRINotifier pri_notifier_entry;
> +    IOMMUPRINotifier *pri_notifier;
>       QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
>   } VTDAccelPASIDCacheEntry;
>   
> @@ -31,6 +34,9 @@ void vtd_flush_host_piotlb_all_accel(IntelIOMMUState *s, uint16_t domain_id,
>                                        uint64_t npages, bool ih);
>   void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
>   void vtd_pasid_cache_reset_accel(IntelIOMMUState *s);
> +bool vtd_propagate_page_group_response_accel(IntelIOMMUState *s,
> +                                             uint16_t rid, uint32_t pasid,
> +                                             IOMMUPRIResponse *response);
>   void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
>   #else
>   static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
> @@ -69,6 +75,14 @@ static inline void vtd_pasid_cache_reset_accel(IntelIOMMUState *s)
>   {
>   }
>   
> +static inline
> +bool vtd_propagate_page_group_response_accel(IntelIOMMUState *s,
> +                                             uint16_t rid, uint32_t pasid,
> +                                             IOMMUPRIResponse *response)
> +{
> +    return false;
> +}
> +
>   static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
>   {
>   }
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 1842ba5840..5d44eac0ed 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -100,6 +100,12 @@ typedef struct VTDPASIDCacheEntry {
>       bool valid;
>   } VTDPASIDCacheEntry;
>   
> +typedef struct VTDPRQEntry {
> +    uint32_t grpid;
> +    uint32_t cookie;
> +    QLIST_ENTRY(VTDPRQEntry) next;
> +} VTDPRQEntry;
> +
>   struct VTDAddressSpace {
>       PCIBus *bus;
>       uint8_t devfn;
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 96b4102ab9..d670a0377b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3390,6 +3390,10 @@ static bool vtd_process_page_group_response_desc(IntelIOMMUState *s,
>           response.response_code = IOMMU_PRI_RESP_FAILURE;
>       }
>   
> +    if (vtd_propagate_page_group_response_accel(s, rid, pasid, &response)) {
> +        return true;
> +    }
> +
>       if (vtd_dev_as->pri_notifier) {
>           vtd_dev_as->pri_notifier->notify(vtd_dev_as->pri_notifier, &response);
>       }
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 0fce62ff75..44af534c55 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -102,6 +102,30 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
>       return NULL;
>   }
>   
> +bool vtd_propagate_page_group_response_accel(IntelIOMMUState *s,
> +                                             uint16_t rid, uint32_t pasid,
> +                                             IOMMUPRIResponse *response)

s/vtd_propagate_page_group_response_accel/vtd_accel_propagate_page_group_response/

> +{
> +    VTDAddressSpace *vtd_as = vtd_get_as_by_sid(s, rid);
> +    VTDAccelPASIDCacheEntry *vtd_pce;
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
> +
> +    if (!vtd_hiod) {
> +        return false;
> +    }
> +
> +    QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
> +        if (vtd_pce->pasid == pasid) {
> +            if (vtd_pce->pri_notifier) {
> +                vtd_pce->pri_notifier->notify(vtd_pce->pri_notifier, response);

is the notify mechanism really needed? You already have vtd_pce here 
which is the main input that needed by vtd_prq_response_notify().
You might call vtd_prq_response_notify() directly here since it's
internal helper?

> +            }
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
>   static void vtd_prq_report_fault(VTDAccelPASIDCacheEntry *vtd_pce,
>                                    struct iommu_hwpt_pgfault *fault, int cnt)
>   {
> @@ -117,6 +141,13 @@ static void vtd_prq_report_fault(VTDAccelPASIDCacheEntry *vtd_pce,
>                                       fault->addr, last_page, fault->grpid,
>                                       fault->perm & IOMMU_PGFAULT_PERM_READ,
>                                       fault->perm & IOMMU_PGFAULT_PERM_WRITE);
> +        if (last_page) {
> +            VTDPRQEntry *prqe = g_malloc0(sizeof(*prqe));
> +
> +            prqe->grpid = fault->grpid;
> +            prqe->cookie = fault->cookie;
> +            QLIST_INSERT_HEAD(&vtd_pce->vtd_prq_list, prqe, next);
> +        }
>       }
>   }
>   
> @@ -150,6 +181,36 @@ static void vtd_prq_read_fault(void *opaque)
>       vtd_prq_report_fault(vtd_pce, fault, bytes / sizeof(fault[0]));
>   }
>   
> +static void vtd_prq_response_notify(struct IOMMUPRINotifier *notifier,
> +                                    IOMMUPRIResponse *response)
> +{
> +    VTDAccelPASIDCacheEntry *vtd_pce =
> +        container_of(notifier, VTDAccelPASIDCacheEntry, pri_notifier_entry);
> +    uint32_t id = vtd_pce->fault_id, fd = vtd_pce->fault_fd;
> +    struct iommu_hwpt_page_response resp;
> +    VTDPRQEntry *prqe, *tmp;
> +    ssize_t bytes;
> +
> +    QLIST_FOREACH_SAFE(prqe, &vtd_pce->vtd_prq_list, next, tmp) {
> +        if (prqe->grpid != response->prgi) {
> +            continue;
> +        }
> +
> +        resp.cookie = prqe->cookie;
> +        resp.code = response->response_code;
> +        bytes = write(fd, &resp, sizeof(resp));
> +        trace_vtd_prq_response_notify(id, fd, resp.cookie, resp.code, bytes);
> +        if (bytes < 0) {
> +            error_report_once("FAULTQ(id %u): write failed "
> +                              "[cookie 0x%x code 0x%x] (%m)",
> +                              id, resp.cookie, resp.code);
> +        }
> +
> +        QLIST_REMOVE(prqe, next);
> +        g_free(prqe);
> +    }
> +}
> +
>   static void vtd_destroy_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
>                                     uint32_t fault_id, uint32_t fault_fd)
>   {
> @@ -213,6 +274,7 @@ static void vtd_destroy_old_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
>           return;
>       }
>   
> +    vtd_pce->pri_notifier = NULL;
>       qemu_set_fd_handler(vtd_pce->fault_fd, NULL, NULL, NULL);
>       vtd_destroy_fs_faultq(vtd_hiod, vtd_pce->fault_id, vtd_pce->fault_fd);
>       vtd_pce->fault_id = 0;
> @@ -228,6 +290,8 @@ static void vtd_setup_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
>   
>       vtd_pce->fault_id = fault_id;
>       vtd_pce->fault_fd = fault_fd;
> +    vtd_pce->pri_notifier_entry.notify = vtd_prq_response_notify;
> +    vtd_pce->pri_notifier = &vtd_pce->pri_notifier_entry;
>       qemu_set_fd_handler(fault_fd, vtd_prq_read_fault, NULL, vtd_pce);
>   }
>   
> @@ -492,6 +556,7 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>       vtd_pce->vtd_hiod = vtd_hiod;
>       vtd_pce->pasid = pasid;
>       vtd_pce->pasid_entry = *pe;
> +    QLIST_INIT(&vtd_pce->vtd_prq_list);
>       QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
>   
>       if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index bf139338f7..52dab0b508 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -78,6 +78,7 @@ vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int re
>   vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
>   vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
>   vtd_prq_read_fault(uint32_t fault_id, uint32_t fault_fd, ssize_t bytes) "fault_id %d fault_fd %d ret: %zd"
> +vtd_prq_response_notify(uint32_t fault_id, uint32_t fault_fd, uint32_t cookie, uint32_t code, ssize_t bytes) "fault_id %d fault_fd %d cookie %d code %d ret: %zd"
>   
>   # amd_iommu.c
>   amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32


