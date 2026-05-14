Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DF1CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 11:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNU4V-0005OK-Ux; Thu, 14 May 2026 07:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU4P-0005LS-H7
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:17:38 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU4M-00085w-Lq
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778757454; x=1810293454;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4sntOSzYzE9WyLrZqgLCG1Pl2MksHB1A1ZD/WrUTPdU=;
 b=a2G8kWq0yWSTF2PvJ1gp5Q5YqmBsO5CnSjbl3hUFMis/ZQWgXHXFjNP6
 TnLobg99xybpC73jcCo4dGInsT+cfIe8Y5NdVIJz2ddSmM7tEMHcy9HFj
 V55qi3nDS1c4P8QldQOR8IHkWkpFN8O6Rq+U7XmhSmG8rhqa8JCZ4jqu3
 hVUpLy1+cqtKnEUDFeKWxJqMN4hKTRTPCylEMRxRwncdYfNd1XQfFuVOD
 63O4rOkUsqUbOGXaNtOsUAU+0hiiBT5ZESsrtbQjd4z6GqfSz7D9HLQGO
 0qBcYDzmvdRxjNHr4TSBjYqYHobX6+EMgSrBP7mV5jLQMIhZ2V2mlzTMT g==;
X-CSE-ConnectionGUID: tjl0ppRgSqSTF/0AOj8Qgw==
X-CSE-MsgGUID: s/TQSifpShi/9ralIVmLtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90800566"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="90800566"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:17:31 -0700
X-CSE-ConnectionGUID: 8awpy1FXTpW1mCQQxuU8TQ==
X-CSE-MsgGUID: sUVzuBGmRq6q+TJyP7XZ9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="238255106"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:17:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:17:30 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 04:17:30 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:17:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJXJ1wKVQblBlsBYMcQ3NTm4BFu8HwkXtDbqGB66AQNKgsTTt59ny0doFQqz+qKDNU3oSXtnDrqdrWHggWpyTM2n3nB/Sn47tJNArLWEi3UwmKIj0QdZDGznVF5JsPzJwhtVFmL0JvXhzRjMlRD6MYxjYlcULsSTaciaWGHk7IkPFNInymn19JmLMbZ6hbMSRgxQCrSmXc2gYd2IJl3G6HpfafADy3cWCcjaDKeRtWNlW4D9U8IsGCbZ3Os2pJ/KV5DGAv/jm0Aa2nfxYf6cheFnJhD13oab8MUGsLBfvOMoREPfixn3JCpsNHQFwCNT6aNET4FHCo1Jrl/gpmUBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HDrR2ziumqDe4bAxMSrH5zVNQeosSCMkH6ueHv7Bh8=;
 b=Dsac6+S7MHh9s+HzvoEVyASJSr5Hy8vhGPk/PrQy5RohQCezs1FqI69xXVQ3Ywqbeyd3CIOzlYmXjxLGR4KtadXcOsurSx47HtS4wCs0U9vuG8kP17ujhItFxJs2MZFp+DaebD4BefCHazLi3DBYMmhAeoRiMRJ8OgE4anjBaGaSNIUDayaedvPUOz7ylhmlQQSjqjY48eUUlE9yRQXpQs6CYs5x5/utpPvdPJN50D8+hJRlEEMHHDIKLz22cTVHnb9p1erVkO+xWaNpPqf1/FP4dGaGDftmjkIB7bphWlxnF8z3VNvQnYuUUDCi2z5oGKP1MEpaOSOh6MC5Em1R+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by EAYPR11MB9588.namprd11.prod.outlook.com (2603:10b6:303:2c2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 11:17:27 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 11:17:27 +0000
Message-ID: <829fcf6f-39e4-4d21-9f08-2772c0813c32@intel.com>
Date: Thu, 14 May 2026 19:25:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/15] intel_iommu_accel: Handle PASID entry removal
 for pc_inv_dsc request
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-11-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260509040819.1044702-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::15) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|EAYPR11MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 55787ab1-66e1-48b7-1001-08deb1aa6199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|366016|7416014|376014|11063799003|4143699003|56012099003|22082099003|3613699012|18002099003;
X-Microsoft-Antispam-Message-Info: s+hlMFgI1v6Te28i11yXMEp4fFcuH5fDQ3hrZNcuLza++HnT6Dg1l+sDd/hJ+9oUugx8UgF1RtvqvsYjGZwhFox+/erE6eWp3eMh0fzbsGLedBieMxikeOcjApJ3utWdHnudxmQFu+EPUooRxUiZUJhwHMbEUW7fQTJBNpTJ/ICOAsNwAdlNJN6pZIGyHyLW89eiHxvpzehua/8xWX76dRzf6HwJ8QqfiLC/qjpib58PtbafuZdbFRLQs0tJwZEJmON87I/Bov3aEqvmv1ZFK3WbZNmKXIHHJopKFrsPbWIJIhbtfN8D07LbyScwcQcdzYjHnrKtSjjm7okAMT7OSI2MfiAbut6msUxifxxkD79QLCf/qjG/mURwPQ7rRl51D6IY1YyNiUiuqSZrKQ2nKwNpqxHayzTMm85JR/haokPmK7J3853Lb1ObBwQtg39ZfDQuLcwjdFH0NAitOfbswAJ3q2vQc5QUbiWtzRC83DbtAbkWOPb55iT7zrfiLiw+ICXGpU/rMAo+gD5zYu4uiNmfTUmdYGM9MGmnJ15keau5vkTJIyzbxv1XFKyPrnR3b74VtStjr+Wik5i/TNIzADF+66ivjUI9rJq+UQuTGibYDhQ+raVM86KjzEmkbmfEGpz8gzTEvWU2aK9lWfKRALvhkk04OC9XvCkVeNOm3QEHOPTYFctrPBHADCrRoPKWyasoDNL+dFrRm34za3Hyvpdb/Q9Rm/Iz4ze5j6DOuyEvLSNFpwHPyU4E4uU9t0hu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(366016)(7416014)(376014)(11063799003)(4143699003)(56012099003)(22082099003)(3613699012)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0s4TGY1T1k5UllaanBhNWpnenBNbzlTTXA5Z21PdVpRUUhKUnRNZDRxamRI?=
 =?utf-8?B?SlJINk5JOGY0SFN4M2E0SW9FY1JUTm5xcS9CaUpzMm1zSUsxNWFheGdObDF3?=
 =?utf-8?B?bjdXdWs1cnBiSmZvMytVV1BkRmF4akpHeEk5NUlvTk55T2tEaHF1OUJLNVNZ?=
 =?utf-8?B?d05UV25CRzdRQjAyUSt0MEVRb2xiNmF1Tkp6R1pKM0xKWUIvMEhGVzNnTjV1?=
 =?utf-8?B?WUFuOFNBTnp6SlNyc1U3ckJRT0QrZjFZZlhCMXFPMXVxYjBSaWpJNERSaldI?=
 =?utf-8?B?VCs5d0M2dTV6emFhVjR4YlJ0SGdsb1gzeGRwK0xTV1dCN1lyMGtXZEFjMGdF?=
 =?utf-8?B?TWhERjgyNSttYUhFN3QrNE5LQW9FTm1JcVBIY1NjcHUwT2g5c1VGTThqeHVs?=
 =?utf-8?B?VlBsZmx1TFZIQkJKMWpUKzgxTmsrWVY4aHgxaFhmSUhFL0ZNdHo5TFlPa09s?=
 =?utf-8?B?Y0JwUmZMQ2crdFlEbjhKVmtyd1lsRlNiNm5XbGJzU3lvUkcyMXRDeCtEVzZh?=
 =?utf-8?B?bHJ2UDZJNGR5S0h1VUZyMWR2YitvbENkUVk1Rk5QVFRFdGx4V01wOExQTHlv?=
 =?utf-8?B?YU9KQ0dGOWF1K2hEN1luY2RSWC9JeHM2YkhlYkRDTWs5cnFBQ29IbjlBZGtn?=
 =?utf-8?B?OGhxN0U4djV0UDh2MU5ObTVacXhMVk1zK0EvVFEyaHNWVjlYd3p0dTJ0RDBR?=
 =?utf-8?B?WFBvWVpIUWNnV0ZNUW1yWlF5V3kxWnZhWXpqc2hGK2ZuTEEyOXN3VTI2bWVF?=
 =?utf-8?B?UG9UTU5JUUFIYUpIWm1LMGRWMGVGN1N6RFMzbE4zVlBlSFRkVEpEaG9aSkVi?=
 =?utf-8?B?d0dFeG5IUTRQSGQyYXlVRlBTTGxackRwN29rMWJJanRKaXpsSUJmNEdnRTJz?=
 =?utf-8?B?RStqYzE1ai9ZTnNJVVVFckpTSTdXU2ZiNGRiVEJpd1NIQ3hSM2d5SkxKb0tP?=
 =?utf-8?B?TjJkNThyRlhDWmJONTdManY2T1lpZDBEY1lCc0J6a1pZaW11RkVGcFhOL1lD?=
 =?utf-8?B?OWFycVpNaHF1QmVkbVpYVVVaa3YzQ1cvakxJQmZvM0RIY2p4T1h0ZFdIWVFH?=
 =?utf-8?B?eU9Kczg1ZFB2V0NEZmdOdkhYOTVXOHozWSthTVQvbExPL1ZNQTArQkZSZG5a?=
 =?utf-8?B?OHdsdHNiaHlNV2pmMHU1dE4xSHFsVmtGVlFtS1VxQ0V2SWFjcWlJYW8raFg4?=
 =?utf-8?B?MmJmK2V5N2UyckpiL2hBMEwxeG8zcDc5VDd1NVdLUzVyVjBJZkJYYUNUckR3?=
 =?utf-8?B?bllqTUw0VENmNXZGVVhOYzVVc1JvS3VGQkgzSExmRElLRU5XK1c3czllUUNF?=
 =?utf-8?B?Qjk4VVlmUzBkNUg3eDdYdlFKbndOeWVsNWQ1YVdTUmNlK3llSEg5aU1VRGMx?=
 =?utf-8?B?dnBJMVRHTlcrNC9UcGdTdGlDalVGak1OdFIySXJRM2x6eUwvdStLU0JnWFds?=
 =?utf-8?B?MittaDlzaWU5OXUxY1MyMU5CNXV5aHRGWldmS2l3aGxWaDVkQ0lkaEZkeTlr?=
 =?utf-8?B?OHg2aTg0NEo0aE5nUHJrZnVGdEpZck1VeUFMcks4aStZcFpYb01FNzIyOWpz?=
 =?utf-8?B?bXB4K2g1SjF3ZmtSY1RyR0FRc3dyZGtqM2FROFpxYzVkVjd0ZTdjdzhua3Zu?=
 =?utf-8?B?R2F0WjRYWnFjMzU2SE1YZkhtQXBvZFVHOWJiaFVKT29DUTR0M0ZLUTc1cnJw?=
 =?utf-8?B?a29YaWxGeGZFV1h5eDdiWmdKVjUwMC9GMTJOQWljMUZwVnVaUWVwcDdRU0hy?=
 =?utf-8?B?ZUREV3JxSDdselFtUGl5RXNiN3FUb2dtb05lT3Fmbml0QlV1L2dHa00rUlNq?=
 =?utf-8?B?bVI0WVp5ZmxSK3N4by9yajdrU0lxNVptY0hpdWtybU9FR24zZVdaWmV4MS91?=
 =?utf-8?B?K1FtQUpLTVJXZ00xV0crejRobHQzZm9hemU5SS9RV3JkZ3JuaUNuV0QzVm96?=
 =?utf-8?B?RmNuLzdmZ29wTGRLaGxCUjcrTVJzOFVNZFBHb09MZHdEbXo4VVNQYWk1NU9R?=
 =?utf-8?B?Uk9vZTNLck1lbC9VbzdHc3pGM3FMR0JHU1YyeFQyRVVNbkpnVTF5eW1wSVpV?=
 =?utf-8?B?eTk2UFovd3RaNVFVV090bVpLSGtMbGhNbmRyNEorTXEvMXR4L3FsMHNYQzBl?=
 =?utf-8?B?K2UzcjJ6YmxnZ09SR1RhWFVnV3NwR2pLT1dOaFFsMzhHcXE4dGZtVzJjRThW?=
 =?utf-8?B?aEdwL3hrOHVUeTlmU21CdUNOL3pRWnAvMWtlbXJhNlVvclBjNDdQNnBKaVd5?=
 =?utf-8?B?YnVDWW9jemZSSDFUZ1h4eDJJbkxqWGJFQ3FIOUpJczRTRUZzcEVteW1nL3M4?=
 =?utf-8?B?V2gwK3MrcVd6RzkraEc0SWl3NUs4ZEp3aG9jWHZMdzVJYXUwbm54QT09?=
X-Exchange-RoutingPolicyChecked: asi6zCORplU1KjbTNZ6iIl0KtEn+csgBW1IvKnepYOrUO3o0k11VWDgZ80eH+twUyhSEBX5WdwOr1h/jRb8chddP/n7u8rCaSs8/1By7Q2ydLrDTN2GEutxHeQGmHnxJsb8WX/ryq/i+kjkPy2ckfJHjbpI3pIkp3yQyDvBiulSVe+DQl6HAmNlJHJZ533oJrBdgnUt7Ge4Ug4k18q/0dXZxwmvwRtnVfoOHSoqCiS7cXM0jHfE11MjS6eHrsI1sfIoNAcGwHFInq6JkzKq3XfsaivX/8/0Z91cOnjzs7BlHjBod7XsI6KbPLqaqWuwRD/qjsso3cCiS06fxZJEhWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 55787ab1-66e1-48b7-1001-08deb1aa6199
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:17:27.6626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OE0LGWlFvZHzXzi6sC4L2g8Q5AX+b4SAiJ2O69zKOIZeMXfQrD0+eCSwgdWpilatAMIEBkF9hohq/rWUqDsg+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9588
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=yi.l.liu@intel.com;
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

On 5/9/26 12:08, Zhenzhong Duan wrote:
> When guest deletes PASID entries, QEMU will capture the pasid cache
> invalidation request, walk through pasid_cache_list in each passthrough
> device to find stale VTDAccelPASIDCacheEntry and delete them.
> 
> Co-developed-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   hw/i386/intel_iommu_accel.c | 80 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 80 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index a66d63b4c8..82bfbdf484 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -16,6 +16,28 @@
>   #include "hw/pci/pci_bus.h"
>   #include "trace.h"
>   
> +static int vtd_hiod_get_pe_from_pasid(VTDAccelPASIDCacheEntry *vtd_pce,

this helper is tricky. vtd_pce already has a pe cached, then why need
to do this? I think it's better to have a helper receives s, devfn, and
pasid instead of accepting vtd_pce. btw. I think the intel_iommu.c
should have such a helper. is it?

> +                                      VTDPASIDEntry *pe)
> +{
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
> +    IntelIOMMUState *s = vtd_hiod->iommu_state;
> +    uint32_t pasid = vtd_pce->pasid;
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    if (!s->dmar_enabled || !s->root_scalable) {
> +        return -VTD_FR_RTADDR_INV_TTM;
> +    }
> +
> +    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_hiod->bus),
> +                                   vtd_hiod->devfn, &ce);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
> +}
> +
>   bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                             Error **errp)
>   {
> @@ -280,6 +302,57 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>       QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
>   }
>   
> +static void vtd_accel_delete_pc(VTDAccelPASIDCacheEntry *vtd_pce)
> +{
> +    QLIST_REMOVE(vtd_pce, next);
> +    g_free(vtd_pce);
> +}
> +
> +static void
> +vtd_accel_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                     VTDPASIDCacheInfo *pc_info)
> +{
> +    VTDPASIDEntry pe;
> +    uint16_t did;
> +
> +    /*
> +     * VTD_INV_DESC_PASIDC_G_DSI and VTD_INV_DESC_PASIDC_G_PASID_SI require
> +     * DID check. If DID doesn't match the value in cache or memory, then
> +     * it's not a pasid entry we want to invalidate.
> +     */
> +    switch (pc_info->type) {
> +    case VTD_INV_DESC_PASIDC_G_PASID_SI:
> +        if (pc_info->pasid != vtd_pce->pasid) {
> +            return;
> +        }
> +        /* Fall through */
> +    case VTD_INV_DESC_PASIDC_G_DSI:
> +        did = VTD_SM_PASID_ENTRY_DID(&vtd_pce->pasid_entry);
> +        if (pc_info->did != did) {
> +            return;
> +        }
> +    }
> +
> +    if (vtd_hiod_get_pe_from_pasid(vtd_pce, &pe)) {
> +        /*
> +         * No valid pasid entry in guest memory. e.g. pasid entry was modified
> +         * to be either all-zero or non-present. Either case means existing
> +         * pasid cache should be invalidated.
> +         */
> +        vtd_accel_delete_pc(vtd_pce);
> +    }
> +}
> +
> +static void vtd_accel_pasid_cache_invalidate(VTDHostIOMMUDevice *vtd_hiod,
> +                                             VTDPASIDCacheInfo *pc_info)
> +{
> +    VTDAccelPASIDCacheEntry *vtd_pce, *next;
> +
> +    QLIST_FOREACH_SAFE(vtd_pce, &vtd_hiod->pasid_cache_list, next, next) {
> +        vtd_accel_pasid_cache_invalidate_one(vtd_pce, pc_info);
> +    }
> +}
> +
>   /*
>    * This function walks over PASID range within [start, end) in a single
>    * PASID table for entries matching @info type/did, then create
> @@ -411,6 +484,13 @@ void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>                                    TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
>               continue;
>           }
> +
> +        /*
> +         * PASID entry removal is handled before addition intentionally,
> +         * because it's unnecessary to iterate on an entry that will be
> +         * removed.

how about below? :)

/*
  * The replay path inevitably needs to iterate through existing
  * PASID cache entries. Since cached PASID entries that are marked
  * for removal don't need to be iterated, we intentionally handle
  * removals before additions to optimize the replay process.
  */


> +         */
> +        vtd_accel_pasid_cache_invalidate(vtd_hiod, pc_info);
>           vtd_accel_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
>       }
>   }


