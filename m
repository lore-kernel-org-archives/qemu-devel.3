Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB2DC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1kY3-00076K-4e; Wed, 02 Sep 2026 08:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1x1kY1-00076B-DL
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:58:37 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1x1kXy-0003Q0-QI
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788353915; x=1819889915;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bNXDujXisiSKx2yaE1wq2g1hV2EnLcQxxVhgylO7ICg=;
 b=jic8nfencbt7gp8Zy9uhwvR2qVrfc99FT8eUgl1rBbgYRD0PSG4Va/Gh
 lDhpVNxVmtgzdvzS7xnIHgPtNsE99TlcOL4TWF7KFA1/VP57fLtXtEZkf
 Fb+eLuZIgg3DfgvMuLkHHI0cQq2nHdRfJAxLA5wuSaFgHfSseliW6rmr4
 acLqq/3DdE4h9OSAdn+F0DFqAJWtoNyk7q9xTKXSTSfSmgbFPsXFQlwDb
 gzvZHlCX16HlFMNbApWHW4ci5/6o8dp7fVdhX58l1o0KEBxn0LHGaul7j
 XZmocQv3aXCGXd4sgwTqGZpU/3EQ0joXpfPxnHtRnFEruYiRFId6UPjYs g==;
X-CSE-ConnectionGUID: VZYIs18kRFm4imyUOchWIQ==
X-CSE-MsgGUID: rvI7FwM1Q5uAgMFq3NAUiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="111579105"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="111579105"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 05:58:31 -0700
X-CSE-ConnectionGUID: yVVoJi8zQne1a6+8lVsCrg==
X-CSE-MsgGUID: pcd6/q07Rm2DEYqvAruIrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="266168487"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 05:58:30 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 05:58:29 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 05:58:29 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 05:58:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXAs/NTempd+EXPxAA/5YlhqlSsSG3PvWnJmHpYWuYEz3tTOpwYz5PzLu+v6oLtXeeWIjxFRRm7t178Cvc+jBn1f1YJcyh0qIwhe5kpbSwH0leLju0NcgdA1KJYiO6Zebr8AwncHy5ndgJkWjlAMOh1jehlL/jAdB7zgdcYAX1IN8ZkMzvJeYl/RFYFn3O4YCA4UJWRt/TuCY/+5VfAdg7GxsbNcj62V/Ia19YMNlVG0s0kFNOFB7/CNP5lbrAhFPhRAzAZcvbiQ0ElJsdUh1RHnt5izqrcnxLvJKQj4nkq0j4jMKFdNc7dtr/fWKwYnM0+vj9GBGfnorSVXyAyBnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlSSXatr3STC/Q6qmk8OGPhyNu6y2f3vj4kMNmRSrWw=;
 b=lyEVi2R7suFE+z4lT85rtTbyIRNsxzYy0VulXZZUV/xZdWkOYRalqSsHdX5Qq6BBGN+bf0dSaqwJxVgB+cC7prkaCU7jGzGQJMwdrhhbaZEnsdSrcKj3kx1UWvsLW67Vq4uTuAM6abXUb1zH0Z3ubLHpJhjV1zvIZmUHC8JBegEpDej0G+76369UPm3V00bO5qfpv7FqgwnCIfS8lSEsO4qeo1cJcoGm1vSYBbak/1iqt9T3J6X/zw0Wf5eaPSBQR9fhgfgFYU7yZDjnDUx0X4tBl0F45HrnHipbxdp1Z1zYn6XmzffbXMJ7bZukkHwfpOi/0O51NY7KFAmNlon4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS0PR11MB8666.namprd11.prod.outlook.com (2603:10b6:8:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:58:25 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 12:58:23 +0000
Message-ID: <bd0dd80f-17e6-49e1-af62-f55cc11dc500@intel.com>
Date: Wed, 2 Sep 2026 21:06:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] intel_iommu_accel: Guard VTDAccelPASIDCacheEntry
 definition
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowangio@gmail.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
References: <20260831095200.1279366-1-zhenzhong.duan@intel.com>
 <20260831095200.1279366-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260831095200.1279366-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS0PR11MB8666:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c893a0b-3181-4e53-240a-08df08f1ded7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|42112799006|1800799024|23010399003|7416014|376014|10067099003|18002099003|4143699003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: firTz8v9UjlhpGHPs/W9baQeGNWDdR/hVKS+ttDeJebj6k50NTtFV3ZbAXw26jE64F1+YE5tMLeqRa6s108tTxCKxynr5QFiljUkWnHev+pm5F26TjS0H7eCiUq5qay64UGOZW5RpxAr6yB1ZOHySUtzQ3zGVPhXBQlJDC8vVWXGV5QXMXkkLJ5Y4rCi1gxraNQdU0zp5UvSMA1qBnjLb8BkUqTjWKFeaHoywY6/vkxPzmQk6faTjMOdj9VI1vnuNwnqYxlrT5srqV9Ddm5FS3hBHO7qBER5Sr+p19hZ9kH71MZOX9FVYdnTODygJDSe2089nO6pPeknqZ26IJVTEWZ6f0qsZlXcsQAsN0MhloWn+j+WrcWkbeUVyqqf4VkL76p2xjxESCzb7qA2oZg6SSZHmvYQhip6OwgNYgE/pit8ba0+ZKgmJdi0VQ+SRa96deCFfyyY/eKhfmRr5MlIpu0tDG13WlXZ/kQ3CK7Zh3YWIEY1qhE+IYyV0Jlyfg3rN/fW9bp7hGp4mptDNJEer0n5eXg5OOlzmRNsCVuYQNlBWlXPLWnlAXjeuWHOQPn0x+b7NXrrB+xlR9MMCtmagbeJ/QshcCGO387zQ+cxqRwGt/qYk0ZhWRqBq6bjv4Yoj6pq7qewaxejuyXWI3ACQ7idW0uHskk+fTS/R7PlSg4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(1800799024)(23010399003)(7416014)(376014)(10067099003)(18002099003)(4143699003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dC9GTWRwQXkrcDd6U1g4TmFMQUY2QVBNYWVORmZrOE5lRmhadHhCYnNiREw4?=
 =?utf-8?B?UkZua3d5U1pCeUEvNzBud1NkSXJsOG9GMU9qNWNQdi9COFh1aUdtSnQ1UG1K?=
 =?utf-8?B?ZC80Z2puZDJBYTR2c3lBUUhiWllmQlFCSk82OTFIQUR5Uzk4Wk1kRncveXpo?=
 =?utf-8?B?MG82SEhPSVpZUWZEWGlqTEV1UDBCeHcwVlZpa0xJRmdvc2xhNm45TFVvYUJa?=
 =?utf-8?B?M3JkVkJxektiQ0dmZ2kzM002TVZ6UmRtSnFZL0JpR2w4clc3Wlljc1M2MGdz?=
 =?utf-8?B?S1psd3gyeFJrNmozV1YwNjRFS3dkUy83cDNYVFY2L1BCTTd3MjlvajM4aDRU?=
 =?utf-8?B?YzBCSXNVR1k1R2J3Z1RHYVVWaWFrekVuOU9RcEM4ZXdQVzVYVmh5b01hSm5s?=
 =?utf-8?B?TjQ0Z2NCbGdGVWFYWHFqdFpoRUlkak1IZitOcENnOXhNekR0WUgxeE1QVEUy?=
 =?utf-8?B?NHFXN1JLRDc4UUhhK1hEMHlkd3JUVCtJSE4yOE9sdk1tZVI1MkNWT3lDUkhK?=
 =?utf-8?B?VXZ4VGg2bXl4QU40UGlvMXpSTlFZUFhwZUcxZW1KZEMxd3I1bDQzWlBHcnYy?=
 =?utf-8?B?bU5PaTNtblcyT0daSjZRZ2VhOU9wUWN2eGtoUHgwUVp3QXJJdjYyR09JNGVx?=
 =?utf-8?B?Q3hBZGFqcTZzYmhoR1JNcng5ZXJxSjUxRXVXVlRybjVFdHFZUnFYWk00U3Nw?=
 =?utf-8?B?UVFCNGZCUWF3VkVQNzdxQngyMWZyaktkNENnUGFxdXFaOHd5VUp0RWovT2VG?=
 =?utf-8?B?bDg5c1NjZDI5NmcvaFdwRTE0SkZJQUtpUWM1UlpUSnA1cjh0TU41TTdTbUVZ?=
 =?utf-8?B?bEl5RHRuMkxnMEtpd0dZZUdNbC9FNkFtTnR5bTZoUVk4YXd6Q1hFb3o4UzAv?=
 =?utf-8?B?Z3p1bEphTytBRmdGYUkwdWJBWERrSlRNSHRPTlRuZVRuSmJCcmtZV01uWlNB?=
 =?utf-8?B?M1pwZFk4Q3F6Q3RBY1l1a21yNTFUOE5yU0JKZVNOeEdhNmZ0MHR2d0ZaRjc4?=
 =?utf-8?B?bE42NU9EcWY3TDdRNDlJQS9IVXdGYUtiTmpyMmxKL3VBL09Nd0F0d3hKbmNK?=
 =?utf-8?B?TnhzaXlNa1BCcWsvUlNsNmxKdG0ySXlIemtEdUYybmMwQVo4YVY0YnB4dCtz?=
 =?utf-8?B?N2doVnBNdW1NdTFGS1JFOWhVTVEyT1VsVVRUT09MS1lWZzFCSDBTQzN1M3ZX?=
 =?utf-8?B?MXhwN2hoZ0FVRFBma1Z2N3N2Vk9RazdRb0JSRUZab0JQell1QTFJT25pdTU4?=
 =?utf-8?B?dTQ3UGlSZE9BQk1KRS9HZkF2Z3hlRmI2YzUyWUFMQTlySm1FMUthOUYzckJy?=
 =?utf-8?B?czhaRHNUSjBIaElBWUVqMTdWSjUvTlI3TklFSFFIY2s3S20vVmNyQW53Y1ZT?=
 =?utf-8?B?UGhmU0lBYkhNL1JMajZvU3Q5bWhpdkd3dGwveUV2U2lLYUJLeHh5ak9yajJP?=
 =?utf-8?B?c1JBMWFOR2VnejhWMEN4TGN4ZHp3emtTQ0V3Y1lsRHoydmlWczVIbDk1dDBH?=
 =?utf-8?B?SERGM3pxV0ZvNEtzNm9TWHFIWFRzQ3dZcDZVNTNPSEN3ejJYMGZVY1FOdCtk?=
 =?utf-8?B?OEkrQzk3c2hYV3FSTmZ0UDV5bkRXbjZQYk5vL2NTSTFKMkoveXZwaXlPa01S?=
 =?utf-8?B?b3ZIUFl4SFZnVmU2dVg5QWdEV3VReXNCcmJQdDBnRDM4M2l5S1dzM0JaeSs2?=
 =?utf-8?B?ajRNMFdPbW1EUTV6bDFmMFhDZVlGZFNIREEySUJIeWNqNTNGN2FEQkpoaTJi?=
 =?utf-8?B?b0I1aDFoZmErM3g5QWd0TWcyOHY1R2thV1U4ZS9HcisybjFJWnV0enhUanlr?=
 =?utf-8?B?dXlDbWNtamdYbnVZRVZzSmFiSHJZZGhLdndjOTk3RTcvdWk0V2hQb3lISy9V?=
 =?utf-8?B?NEdOeDlmQmlyTnhxSi8vc0xSZFdpaUdvWmdVVU4vSUtFL3duQ1R5OGRVbDlp?=
 =?utf-8?B?TmJHTFkwelJzT21oaDFuVTUrVlp4TWlwTU9UNENRMm51OWRHd0VhUDErVmxw?=
 =?utf-8?B?TFBjbXFTemhKdk5wOXJpZVc3cFNkcXJwak10VndJZ1NyalRlUk5TN3E0Sk5x?=
 =?utf-8?B?K3lFM2ZJcnk3a3o2R1lUUkdiNFNVMEM3dFN6eEFQQnNpRGJYODdnbHBEQVVF?=
 =?utf-8?B?LytDWURWNktTVUNXRDJPQnRmZlM3TnZ0TTIvVEJudXMrR1MyczN6VjlMUVlJ?=
 =?utf-8?B?Yi9CVU9UaFgvNGJPWS9sVVVaZ0IrUFB1aXZyL05XVWlwdlYwQ2ZmZ01ROWZX?=
 =?utf-8?B?R2NOdFVXVDA2MThsM1c5WWdsaXJabXNaQzA0TnRLcU8zdERBVENkT1FBWjdK?=
 =?utf-8?B?UEpXRFBlaWg5dFNma1diMi9odm1PWnpCYVFVd0ZzUjVZWG45T2R3QT09?=
X-Exchange-RoutingPolicyChecked: IpU8Ek0v0j+7Q2AF628CoPbyYRZJNRrHtmhp/B9NwD2p8mNkF9H56bNruyGUavKx5cwSc86dDEDTTWqL4+xPXqlS/5dvE49R2tVAl6paHZhjpUrpP2EyuWKad4MeJoHrJ7rB9JuOusRUqNOJ8WjOnpHHjpQm1C0kmo9CaBlkHPFIZ3zQOaF74dKZ6AKoo/omuRfqbbdypf7j0cKOTHjBbzmqb3xi0WrsklGcWHlG/KFOIh/9cv6hBdI2sXcifgcINQYlnFveGCPAm2HsSjc2mybEmxhILGAKkgV6yXgSwQhlZEWmb6lRsKU5hMU0Bku6mlpaIJDnwychVMfie2uQxQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c893a0b-3181-4e53-240a-08df08f1ded7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:58:23.2585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IbXBGFvmGDmiTXb4td4HtnTyUCZANf/KUYDp4ZuQNmUIpaDp3z2V5RCwHDuycexx/HHXzsqFdrf4zRXpsmmbEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8666
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 8/31/26 17:51, Zhenzhong Duan wrote:
> Move the VTDAccelPASIDCacheEntry typedef structure inside the
> CONFIG_VTD_ACCEL ifdef block.
> 
> When CONFIG_VTD_ACCEL is disabled, this structure is entirely unused
> throughout the code. Moving the layout under the existing preprocessor
> guard prevents exposing dead type definitions and ensures the header
> remains clean when building without VTD acceleration support.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> ---
>   hw/i386/intel_iommu_accel.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index 4a9003c92d..46c1a29409 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -12,6 +12,7 @@
>   #define HW_I386_INTEL_IOMMU_ACCEL_H
>   #include CONFIG_DEVICES
>   
> +#ifdef CONFIG_VTD_ACCEL
>   typedef struct VTDAccelPASIDCacheEntry {
>       VTDHostIOMMUDevice *vtd_hiod;
>       VTDPASIDEntry pasid_entry;
> @@ -20,7 +21,6 @@ typedef struct VTDAccelPASIDCacheEntry {
>       QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
>   } VTDAccelPASIDCacheEntry;
>   
> -#ifdef CONFIG_VTD_ACCEL
>   bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                             Error **errp);
>   VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);

LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

