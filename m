Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB7FCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIRJg-0003G1-MU; Sun, 18 Oct 2026 09:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xIRJf-0003Fi-AL
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:52:47 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xIRJd-0003cc-II
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792331566; x=1823867566;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=w7mEs+bk47Qhp5k66pFYr28BwNUKdFyw3cyp1SODmUE=;
 b=Ju/M1NAwGBqnK61u+zJWXDV/XlPABP6SVhMkYnRZm12ilUk0f8D/MXGC
 5wegz2qsBRdi2qV4pSteFu9TTde+K31ZlDlbx8m5/QAaj6tg/gkGIsbKI
 H/MieOtOBS0cQ2WKKbiWTO7kPVuJx2B96WiCrai9eZK9PrEw3zUkRdLrt
 tGZMDoW4ZRCrV9SfKdoDRvDkrh6GqF6X/O1yQZY292YBUbtSHfJqvVpAH
 0uV+5P7A7QY7R1pUKEUDVV06Ih/g2x81MvCNGMdf+6RAMfb6k5StXx560
 EXddDivQzJ3SdCToINImMxUVawOZ+j9Sl0/6cOR+027vtqj9HmnaFUgu9 A==;
X-CSE-ConnectionGUID: JeBFvfXgQMqYDYzIuZCpnA==
X-CSE-MsgGUID: Z4H6eUuPQ0+WzJh8YLf7Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1055881"
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="1055881"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2026 06:52:45 -0700
X-CSE-ConnectionGUID: F8mvXTALQyes1WJQuGjzjg==
X-CSE-MsgGUID: at+D9ViATcOMuVybcA5UCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="2261415"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2026 06:52:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 18 Oct 2026 06:52:44 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 18 Oct 2026 06:52:44 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.68) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 18 Oct 2026 06:52:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owOTdTXzK8UbnvgtH/a8cvwYZpY1tKdUL4mJX3/LdJJh13SF8T5yUbPjXFBb8FqLFAjHPSWSdUC0c+zEGHj9SuSJLZCq/5g+QLzg3WwsO0DjlplnM51eI6g+G0cmYima7hwztVzeoiy9wwBJFuHFNwPny87eD1fLBixqUPezMAaV9jd0QHabDPNQHB2PJl3HVMYbKdDzF5zCselujMt6rIKuEIHHGiEMTYK9op9T9Z5wLB5MTWpg0PDiblxG9R8JFV8iH2YjCifXgAeCoduVgjrZ7ZAiULmzNu6TcyEMgpArITQ2eqsn7I1membGSJQWaY4iytBtl41GFxl6h+bFtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCaM9AMgiN5ZDtymFTGJhKWknqd2KZBj7qCEMu9a1CI=;
 b=nHkIX7uTTRF7HzR39/4JkxN29qchuKOk3VxpCRHDBkZVJhZ07qpDKuVdtvkcS9ogyizehrR825D4cCfDwZA+ViBQh2Na+VWOQc3clcplitpNAc9xmPhIiMxCeutXpap2vhsJ31bwOHaCZ+NxvvZNr+U632cyDOGB3bpcSjSrz08z3YW0lUvqtxDJ0MeqsjWJPTZZQyPvxicdXvJZiwO9CkwhvMvEjBq0VdsPafSEPam6qG1K1bgR5ocUgHnwyNznzqUg+RdRlUBqwA4p2sFP0E5CmiXVpLtIRIAxmaURYNrZ7OPmNY5mMJ4KtnvvBj5rLao0TBMf3qplo8LLwOaWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 by DM6PR11MB4562.namprd11.prod.outlook.com (2603:10b6:5:2a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 13:52:42 +0000
Received: from SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe]) by SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 13:52:42 +0000
Message-ID: <d7b37c65-7234-4eb4-b960-454572f447a5@intel.com>
Date: Sun, 18 Oct 2026 22:01:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] intel_iommu_accel: teardown FAULTQ resources in
 bottom half
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowangio@gmail.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261009090737.3930000-1-zhenzhong.duan@intel.com>
 <20261009090737.3930000-7-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20261009090737.3930000-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To SA0PR11MB4527.namprd11.prod.outlook.com
 (2603:10b6:806:72::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4527:EE_|DM6PR11MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fd73232-779e-450a-e2af-08df2d1f144f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|7416014|42112799006|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: LvxnUTg0eXd7/Hxd0dHLNXq0v0tRQovfb+5gzXl/bBjbujjsrnovpvLVniY3EJ20Y+zOJMXM0bjMkgpGzUgEhZhKr6x+FpgZjmvE0xbOD8otjpDVKsIFJu2u97AX9jMuOzhvUmwEbgrpHLeoEozcpx35Qqy023lpiJBVbgb6Xcvuky4vew6MQoPK0fca9V8W7upaUxnZa1AEmL4mGew2Yzeq0yhPyJH/9+ADDQgQwSNpuRLU30LaJYXEDcYBPsmFqG5mDE7doVmMU5KxSaUtv+5oh29vyi0zxAzGr6QMA5ouRq7Kjf/i9jEeIQLlLH06LxvRK8eUlKKwoFgCd8alF8IpeDqKBt5CHMah7xvRKAjW4N6covdYDz93XOBapjgSRFTLK91+9HVyjjEulYNBUkoTbf8I5640KimKFiDJvmVlS3vOc1GTrZwLuVcTLpDqNZB3emeUxInJPGt+PZHAz1cuEsxg7Nvs7VeL90U9mKAnXeSfLO8m6Q12W6KxQyF7lmBCg/D0XmI6ZEZPoaLYM9lfKZsrmLuKfQRbd4AFud3GPbAylIaIHJyqtgD6XrMbj0XVR3nxQBCeC4x/d6v75lXmYYDpD17QnNDBooE7X1YgKrHTOLIa5ToQOfQNPUw/vMxJywnNJ3hU9wXsyTXDRH5i5k1MqZoKG/PB6KlSIjM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR11MB4527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(42112799006)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk1UQVplUU5YRFA4OUlaYVhCYUljMlZNVmRVMldxTG1aayt3bzRRSENWaWdx?=
 =?utf-8?B?RjhENS96T1kvNGtDNVBpMGxsaGRqNUVOdFFnc0pqbGpadlFGNldLOTVkR1pi?=
 =?utf-8?B?Y0NuNFRpUDZ0c0RnNGFmN2lqekVpTXRoaFduM2JvYXNXdk5rNmh2eUNENzNh?=
 =?utf-8?B?Y20yY0VNSXdLWFgwZEk4dnNoQmIrQkpkUTFVcTdEeWdRRmpDb2gyZmF5aUtI?=
 =?utf-8?B?bTZnY3Q2b0w2M1BGTndvcDBCck9lbFZvN3pvcnYwQ0RDVjdyWHpxOURROFR1?=
 =?utf-8?B?d3JIYVgxOWZyUTR6c1NGaUVWT1FWZi9iNStEMGd3UlpOL2FnaXZPMzFjdFJx?=
 =?utf-8?B?ek4xR3FKWGttSUp4WUJEeThhV2RDb1hDMjg0ZWdGV3h1MmJ2OVhzR0ljYStS?=
 =?utf-8?B?cFZhUFpjSW9xM3pkWHY1ajl3NmZuRXY3TUFQbkxZMGh6MytMaklTSDhlWnMy?=
 =?utf-8?B?R2JaQThaNlVoaTZScUt1azdiK25OSjA1TURTT3RyQXFYa3FCeHVmZ29ENlYr?=
 =?utf-8?B?YUZHampMSTNURUhsdW9rZXVjN2sraHJMSmkzaHNiQjhWVFU2dVh0OHNqaWUz?=
 =?utf-8?B?ZXJXeHcwdFFPV0s0bldZelcwMVFIOWpxcW1ZYldrOXpxV2dUWlB5MUtiN3BE?=
 =?utf-8?B?bExnUjB3bm5McDFjMHU0am9qYjdUblRQSWtkOFlwN1U5V3p2bTBYc3NMWXF2?=
 =?utf-8?B?MlpJaFU0SHZ0NzBpSG9NVTVrelRhNXNVbTlVdk9yalo1bkwvSWRMbmtFT0tr?=
 =?utf-8?B?QXBHQmtZbk5mbDZCRGM2eGtxemp5SEdIRUlETEZaeWM0UlUvbkUrcTJsdnNK?=
 =?utf-8?B?VzNZUlhuZFhJOEYwQ1pSZnhJaDRxbE5XV3dOUUJYbjVxN1QrZlJjZEZ2L0xk?=
 =?utf-8?B?dFpYMFk3YlJNY0xUbE4xMFJ2ZUhqaXBMU2Nmbnpwc29oaE50eitPRE9vZjMy?=
 =?utf-8?B?d1dyUDRoWVhYRVpGWmdSSXVSK2xaaXpJQlc0Vk1UaURRNUM2RVIwWmxLcWVS?=
 =?utf-8?B?Z2hDZ2lPM1QyMSs0cm9sU1IzU0p1RnBUaWZSVnRsQ0pyMExJY0RvQmFQTHN0?=
 =?utf-8?B?aUV0K3F2SnMyNGRzaEpjcDlDVW5XQytzM0F3dmdWTzhUdE10WWpWc2IrbkRj?=
 =?utf-8?B?SlZZSm83K0pTWUZyUDQrS0ZtNUlwcGJtQTNUd3krUVRMSFdyeEZwUkE4akds?=
 =?utf-8?B?Z1F5ZzlxR0hlanAxOTJPbUp3ZStVd2VjNUM3VDBZRFRJVldSZi9UT0FvcVRP?=
 =?utf-8?B?ZVhOMmlLT0FnZ0I1blF6WURWRlMwRWk2bmJjZytYdmhuOWVFeWNDK2F6b00y?=
 =?utf-8?B?QUlrbmVhOUxzM1dja240SENNTDZMQmZvRDhuWlpWUVd0RmV1a05hcjV4d294?=
 =?utf-8?B?VjBIL3hjTXZCSS9aVmQ2dkxZNFlRQmdNVlp2dHhETlNjWHFKUlMwVUxIZUZK?=
 =?utf-8?B?TmJBNkdMa2hDUFJTZmd0bW9XR3QzVGt5cjNQKzRPWDdCdjUvMmc3NTVYY2FH?=
 =?utf-8?B?VzEwNVdkQjdnNnUrMzV0Z3ZaMGpGYjdYZTZYbjNIWFVLcEJDdy81L1FKQ05Z?=
 =?utf-8?B?UzRpVGdGNVB0Z0xHR0M3Q1o5dzU5cTRLQ1pYeStJanpkaXJnOGJveGg0YnNO?=
 =?utf-8?B?dkl4amV0WU40VURQeFR4U2E3c1FiQmJvWFNacWUwR3pqd3hEU3pEdlNGSFFh?=
 =?utf-8?B?ejg2NzVEc2ZTcE9JTGc3VUJDVEVpQWFrUWRocjhacEh3d1luY3lKNEt2bW9y?=
 =?utf-8?B?WGEwMVZYS2Q1UHhSMUR6R090QURrTkhzMDFLUkJCQWpwcEhoYmFjai9JelBL?=
 =?utf-8?B?VzBmcXFuMXlqRzVtRWF1SWNVZUY1YThZMWxTNzJrTVUrRWdBYS9RUzdkditR?=
 =?utf-8?B?dGpDM1Y5bHBhWE9sM01lYVo3TU1ON3JiK1FYOFZyQnROZk9Ua09STnF2RTlC?=
 =?utf-8?B?SEd1M2xCNlpkMnBqa2R3M0FXSGdKaTR1ZDBLYjhJZFA5VmphdGI1dmdjNk8w?=
 =?utf-8?B?SHJEdnBMSXB4bTI5Uk14c09CMVVpdGgybU5Zc0lLRVJkME1SWFpoVDZhMUZD?=
 =?utf-8?B?YVFKa0JqU1Fsa3JhcnhqNk1vbThuNXd3RHdWTW5iRUpZcW9oM1lmUXNTUzdh?=
 =?utf-8?B?SjZKd2V6UlRqanBnZFpsOFYzMzU4NE9ERFVTRE5lYlhnNWNBRTU3bjNiMkY4?=
 =?utf-8?B?REZORDRTOVA1VnBvSlI1RTVSQ0s4cDRLanlJVVBnWEVUV2ZJVjZxaDdxWXdM?=
 =?utf-8?B?K0RjTjZDTEgxUy9ac0VtVG9YYU5zYUFvS2c4TmZ3S2lOQklSYjNaeWVYYzlu?=
 =?utf-8?B?M0NpZy9YMHlxWitoMSt4S0d6cThSUkhBWVhsTkZjNmxCTW8zMXY1Zz09?=
X-Exchange-RoutingPolicyChecked: mhZKf0D7Tsp4Pc6mCMueij3t2thaOy2a/DBn4nNKL5tqECiJAxXdjMcLIML/c3AiYMAANHgLUjjHSZ6gj9KvPYZG/EzCml8AaIur5wADDWohu/FJID+pK8+OWw5nAvMBDAbqm3osHZTpcATh1abZbznPQZYjg6W8aNOU8QL8RJQXtaJUbwMVi7OtcR3vul3Ag2DxndGu0eIxiwoZdKW6lpHoE2S8YUSZHdMfz7essRCJXmIMKJcMr6MBmozJZiJBGFHcfbB/UNUZgUmeVP8/WzaVwxyNTrNq03d3oOayoqXUhP6SO6/hNjecPK2zdtZvLrDj6uTkCGLODjmXwU/PKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd73232-779e-450a-e2af-08df2d1f144f
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 13:52:42.0649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /m+XDrWHNKpHdrkS09Bi5jOapLICkog/H6eGQsWY694kvcd2Z9cm0toPCxkcjOlnrDDoLqlLH6Tay9ejFfwkPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4562
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On 10/9/26 17:07, Zhenzhong Duan wrote:
> When a pasid entry becomes invalid, we need to release all resources
> allocated for that entry including FAULTQ object and fault_fd.
> 
> We call qemu_set_fd_handler() to detach fault_fd's io_read handler and
> wakes up main thread from poll(), but there could still be a small
> window we call iommufd_backend_free_id(fault_id) before poll() exit
> and release fault_id file reference. In this rare case, FAULTQ object
> free return -EBUSY because opened fault_id file keeps reference of
> FAULTQ object.
> 
> Teardown FAULTQ resources in bottom half to ensure poll() has released
> fault_id file reference.
> 
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   hw/i386/intel_iommu_accel.c | 40 ++++++++++++++++++++++++++++++++++---
>   1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index cd227315da..c07ffa68e0 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -268,17 +268,51 @@ free_faultq:
>       return false;
>   }
>   
> +typedef struct IOMMUFaultQueue {
> +    IOMMUFDBackend *iommufd;
> +    uint32_t id;
> +    int fd;
> +    QLIST_HEAD(, VTDPRQEntry) vtd_prq_list;
> +} IOMMUFaultQueue;
> +
> +static void faultq_teardown_bh(void *opaque)
> +{
> +    IOMMUFaultQueue *fq = opaque;
> +    VTDPRQEntry *prqe, *next;
> +
> +    QLIST_FOREACH_SAFE(prqe, &fq->vtd_prq_list, next, next) {
> +        QLIST_REMOVE(prqe, next);
> +        g_free(prqe);
> +    }
> +
> +    qemu_set_fd_handler(fq->fd, NULL, NULL, NULL);
> +    close(fq->fd);
> +    iommufd_backend_free_id(fq->iommufd, fq->id);
> +

a nit: any reason that you open code instead of reusing
vtd_destroy_fs_faultq() as the existing code? If no special
reason, may be better reusing it.

Other part LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>


> +    g_free(fq);
> +}
> +
>   static void vtd_destroy_old_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce)
>   {
> +    HostIOMMUDeviceIOMMUFD *idev =
> +        HOST_IOMMU_DEVICE_IOMMUFD(vtd_pce->vtd_hiod->hiod);
> +    IOMMUFaultQueue *fq;
> +
>       if (vtd_pce->fault_fd < 0) {
>           return;
>       }
>   
> -    qemu_set_fd_handler(vtd_pce->fault_fd, NULL, NULL, NULL);
> -    vtd_destroy_fs_faultq(vtd_pce->vtd_hiod, vtd_pce->fault_id,
> -                          vtd_pce->fault_fd);
> +    fq = g_malloc(sizeof(*fq));
> +    fq->iommufd = idev->iommufd;
> +    fq->fd = vtd_pce->fault_fd;
> +    fq->id = vtd_pce->fault_id;
>       vtd_pce->fault_id = 0;
>       vtd_pce->fault_fd = -1;
> +    fq->vtd_prq_list.lh_first = vtd_pce->vtd_prq_list.lh_first;
> +    QLIST_INIT(&vtd_pce->vtd_prq_list);
> +
> +    aio_bh_schedule_oneshot(iohandler_get_aio_context(),
> +                            faultq_teardown_bh, fq);
>   }
>   
>   static void vtd_setup_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,


