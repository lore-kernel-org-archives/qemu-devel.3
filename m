Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FB4F532CC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5yl1-0003fT-A6; Fri, 27 Mar 2026 00:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5ykz-0003dh-Sc
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:25:13 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5yky-0005Yp-18
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774585512; x=1806121512;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jQ5BIxlGD6VqK7pUAlB7PREMb6bayYi/PbiXMgCJZ0o=;
 b=b4hHj48HbU2JycAC9JRN1/rj2qxJnvGwUz/+9qlOe0KAfEm7QAUnBXqW
 udzdSL8vTJwWw+vBLwTtTjxYiorO19lSuji2xL9MUS4CBTW9iUdSjmLFa
 6CYVVDZ5nq0B+5tWe0B/hYr1aPDInBsrcu4Wwb0a3tZu+YyF0qkIKv0b/
 ZBl5/yMlgp33GW3c5uunuPrUfjXUeeac9YgPsfFzCZ0HhctPgEkwqBI6F
 iv6o2Fz/NMnHBXTUEKXcoTA7AqJWQjDHRuWCqHlnER/ryxfCkPk0Q8z6X
 dfbfOZU+nTDzvtEc3s9Bxln03I+FzwyZXt7HTSaWrh1CTsMjzQ+AnyXFz w==;
X-CSE-ConnectionGUID: jhDltWRjSn6Bxw/s+SYTKg==
X-CSE-MsgGUID: v91zgxCOR+y1PB561oHbxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75769489"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75769489"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:25:10 -0700
X-CSE-ConnectionGUID: KJSleS4wQMesKiKwmOfpag==
X-CSE-MsgGUID: RzH+O84TRSCklctQ4S1y5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="224253735"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:25:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:25:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 21:25:09 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.62)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:25:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qwmyprn7y0WINKS5CBIGmR1crc6gA5Y80o8o5WHODG6dYt+5rbSAxelRqKKESxmLbM7GFAY4fwS6P9ILck0IEFFxGPkpq2fNWSt0gd58GHirV57MFE+dHflpe3IJFlW1Adgjvns+ypSKg2cuYmnQXRr8P85TacN1MIIP2I4fxSZqMeyaYs+tgtYStEvUAOYDMScetgQcztOxUdYntpUytHznJJ10ekUxdT8PD8muqBJzmIUrHe4hkJe1MX68sOyk4l82qORw2ryUzYf+zfEjYxhTWJnbBurZhpi1YzXAXddYGq4p4cJH/r1U9F+92i0ktUm6kxjuBLwlPJ2F3IRzpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdGi9yIIRsmOQCX4K95ul0X9yqbFLOsYj9vNjhxetRw=;
 b=a1Q1eeeERqbm4CobRDLk/t2j3HH2hHVMo5os6oS5WdLY1YNwx4e8mc5OJvnZ7kWUxj80z2Kp8EK7BXN/Pvz/+KIIQ80C1ufsQBw2QV5mu2nJ/79OipKjRZg64Jc1+2tsTeHogDIpJr89Qozon5rvqg6T/t2hAtxOjBKU6uinyNJ2oeFUbm5YAAiAW3eovYdgpQjcluQXmrLklmxEgpHG8B91WN/7YZcPN2ZjfVE+8wnVaHCX2gmKnPMokobNMzWeFO1BQVJVpqVtQYs/ckagLwcgmT64gA0mTQDjWmzmbt8Mgt+kn6/srJyjHyWQYJmLnfHhmWzlLpfwSQYhkMX+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA1PR11MB9614.namprd11.prod.outlook.com (2603:10b6:806:4c4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 04:25:02 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 04:25:02 +0000
Message-ID: <0ae09582-4e0d-4fcd-a7ad-5b6b0b470b93@intel.com>
Date: Fri, 27 Mar 2026 12:32:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] intel_iommu_accel: Add pasid bits size check
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-14-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260326091130.321483-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0024.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::7) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA1PR11MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: f1109a85-0fdc-4dcb-00c1-08de8bb8d0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: XGxWZDXNhYHRcnM/h2ghPNNe52VIwRc/CTw3Jv8jHLXS3nt0phtIW2env3USWwuSrZe/rsRjD20bzFFdOm/wcCNffUlsHw/Ne6FYej8hVQ8Fu2J0t3iRrWohQbueApODpitYyQgXXR/PlR1KqPZol/8oAg8gJ6+fa1wYVZQbw4ZmLvbJYrel1d1NJVdU+D9iTQcqV1RHGG15qtTZ89p98+CefPhKCAmJf5PxW9JaZwJDKt5kWE23QLLv2mmPe9cmzWjSiSxqegFggSfE6E+gsdTC95tcxFIP5WEAN8ObfJmETBXP4lD1qBW19BGMv9gO3P1JtzNGnx71thV1ijkum8WKpXAvsBebgfwotL4ZF//Guw5ZDqjGYrYvY9VZ59nFldd5dULvGupfm4nCoXo6ubaq1XrDjvDht/xlMLZuBhr+Lg9TEkGFFEgH5b9UQRsW9B2RZAWjiGEvDqQjwyoS9YnYJgKAOGI1ziICGwVPG+Zh6/9F8boI5vWZ4fD/QbOXntpccJg8UH1quAMhjpZSdYRAt3D1uUdkEu1auKUyQsdEeEGecG9O8rAzSQV75OD/gsWlvxjtuGpsV+SQfuz9fXtp1Ey/kRzXlCxFsCVKbmX8Ll3I32nPZH+86uGL4DXk+1kpGP4BsapNYuSIqlfGFfAApyVYy0NNfoh80SN8RxuiGiT4fQHpXb3loDDuCh1/aCkDYQf5krXPTqF7xeCU7S5MC/5PcW6V05szmP3/EvU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(376014)(7416014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHI4MUlxZ2gwSlIyVkhRY0JBMlIrSjllSHQwNVo1YS9rSG9mSzU1NmZNNkZH?=
 =?utf-8?B?RE16QTlMY0E0WGVjWkdPbWliZXdDYmQxMlhGTUZ5RTVMZnM4WVhUS1pmLzBD?=
 =?utf-8?B?b202c1JjQU0vUWFaNFNMQXc1QUxrR094SmVpOGhvakZjOHFBWHlLTXBvWnBy?=
 =?utf-8?B?bG5XZU1iUkxMZTZsRi9rN2VkQU1pbTRNK2J2OS9ZbCt5WnhNMjgwWUs2YTk4?=
 =?utf-8?B?eS9MRmlYMkI2TUFZM0FTKzAwdmZGRTQ4dUhaOExadmNpVndPdFdVby9ROXNK?=
 =?utf-8?B?ODRyMi9BOFk3V2swSGpIbk12NEZPWVYwekFieVl2SUVyUmkyKzdGU29mYSta?=
 =?utf-8?B?bUpTUTZ5TjZhcy9uOVU5M292R3p4TjFZd01YTzVzUEhZK2NUV1pPL2REUHdP?=
 =?utf-8?B?Vm9HdjhtYU8wN1pEenA2cnRoanFGZk0xamczTXJYbUtJS2ZCQlJUVnYzR25o?=
 =?utf-8?B?TWxrZXNUM25HQ3JONU1tTlF2MWpJVnNMdDBpU0hOK1Z4Yk1ZbE82NUhpcWZ2?=
 =?utf-8?B?OVlHUXJYSGQ5TEN0a2NJdTRtN3g0UXJkSVFYUjdJNk5oV2Q0MEc0ZEpNUjQr?=
 =?utf-8?B?WXNKN0tRMEIvVzAvSmNZR0dKUlQ2eHY4Tnl6MDdVVSsxU2E3QnNHMEI1a0VC?=
 =?utf-8?B?WUFSbnlTRDBKb1FiU2ZYMEN6UGNEdTc2YnJGaUtkd0dSNEZRa0hxbGZvMnBw?=
 =?utf-8?B?MUwvbW9xWUpjWE9LK3lhMFRaVFBFNVcwY2VqMHFLVG4rekU0MDk2Ym1OZE5O?=
 =?utf-8?B?S3pmaEdiSTJPYWtkOGdRekMxWnBRMjBYdDFJeDlQU0VsalR4SFJBRXl0cWY3?=
 =?utf-8?B?QmhrVXF5L1hua0swenovY0FsWC9GaGI4L1VmRlF6YzkxdFB6K3RNTGR2RGds?=
 =?utf-8?B?bEkvaklsOTZhTW5LMFhsa0J3OUVmRnRsQ2JvUlZZc25Pd1g4OWwwS2h4OGF4?=
 =?utf-8?B?a2JIK2t3Q3d2UUdyanZ2Und5d2hyenRlMHBaYlUva3ZqZWZBMWl3amJYeTQ2?=
 =?utf-8?B?ZkRvN1FwMmtyN0xaYlhGRmZvTU5KNXdJNXlqZ2lCQXdYZGRuWmtYOU9yaHBX?=
 =?utf-8?B?Tlc4QzlCaUVrWlhnRzdBcUFUVEF5UllLUWYwK3h4VGxsQ2hZSjM3M05pdFA0?=
 =?utf-8?B?VDhnU1pDYXNqVVVRekhYaUVTT0JqaFhsYlRHUHJEMUV2eC9FNlhaQmFhREJh?=
 =?utf-8?B?dnExM0daY3A0NExtdXg0cnZTRVUwYjk2NlN1WGY1S2FvbWxYTU9rSFJxYnM4?=
 =?utf-8?B?bE42YVVRSFBzK09OVVlTbld6VXE1cDlsNnk5S3ZWNVpFQUNmNmpQdVBGclpx?=
 =?utf-8?B?SmFiTmtIaXUvcTdVNTFyRGlFU2tzVHZGQXY3cnY4S0ZvaUI3T0VrcXMyUndm?=
 =?utf-8?B?SDV0QWJuaXl5SlJ3RVJTaFpHV2k4eDJoNUZOK0c2bjRvVFB4cUh2M0tKZ0Z1?=
 =?utf-8?B?N3FLT3MzalI4emE2cmNkZnA5TnFmWXJaYXViRk9qdXFTcFMwamw5MlFOYzVW?=
 =?utf-8?B?ZFd0YjFBZnFMVEQzNUxSZTZWSXlzdGExVXMyZVZVc0YzYUg1eWNuVXRFNzN3?=
 =?utf-8?B?R3EzdHBxbllJdnRoUSszLzRqNCs2S1RXcGhtTlA2THRZVFNQWjJ6RVREampW?=
 =?utf-8?B?V3VUOUlETDR1eWlqS2NIVnRrbW5ycHplZnAwUzA3Wnk0VVNwblRmbmVodHhv?=
 =?utf-8?B?clFhelp0WmpHb25FNG40OFlLSHFXeHFLVEM5ZExrUTduSnFBNFJmZjR1MHZh?=
 =?utf-8?B?OUJqdDZzYWcrbnJFekZoTWllN0p2NkRIQXhzWUhlYmR3QThNSkl3eStVazNr?=
 =?utf-8?B?YkRteUF0eDBKc1lLR24zZC9VeVhHNHJrZ29udWxMMGlzVnZjdkUya3c0NkVK?=
 =?utf-8?B?a1hVS1RiL1k1WC93ZkVIaVpaWDRTMncxd21STVdwL1RUT3MyRVJSQWtVa2VE?=
 =?utf-8?B?cWpyZXNXMDhUb3pzRFdMRUZ6UFRjVHd0QUh0YklwaHFGWXYxM2tocVNVdUc3?=
 =?utf-8?B?SGUweG1zazUycWlzRTUyMU1JWkhBdUx1QkZDQVpRSEw2Y3U2ZUQycCs5Snpy?=
 =?utf-8?B?bnBOa050dmNrZHBCL2VEZExQVGVDMGJvaEtVSUgzOTJBZjYxQkRnZ0JQUWhr?=
 =?utf-8?B?YXVjR0V6QlpFcTIwRk5GZ0pqRFpiM1Y0M1U0T2dmK2NwVTB0dGNxd05VdTZ3?=
 =?utf-8?B?a1prTzc0Q01Ja1l3YXNKUkZrak1ic0NQNmVvckt0NU1raHBFbi90UzdBeFZZ?=
 =?utf-8?B?S3pyS3lwdFZha3hmS242SjYzMVRZWWNtWExMRC9IT3hOQ2tIY1RpMVk0NFM2?=
 =?utf-8?B?cTE2bFcya2puVCsxLzVlQ0NkL0cyZ1V2c3JsWUVkVnAxUW5TenY5Zz09?=
X-Exchange-RoutingPolicyChecked: L/UfVjZyFSCjBq1+VjxEh3o9JaMvpjFXuegvHPH6fSn2xHCJA3QxcGEnHPaO3Veep3J6/51gZeSw/6qLkkdpVfYGfJ6lAVH5SHbNjIKWeA0wNyl3xSKBbfxPLqysTMlujHX7izQM5qDR8zjJZ32648v9U29Xao4OSN6soODZMClgZDh84MKLhtXnZRqohsUT3E/ftMykKbrbm+jepQY+IgZ5bDWaGLpK3H0QAejIAixfrPeNhjssazrbxT54XMo8NyDzBnPrgemKxmws68m+fLUHn3sk5vgItSDbumF6FlPFoRF57era1RUi0jYLRQtSDqR1TmOcnsPBxfZmJYiDrA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f1109a85-0fdc-4dcb-00c1-08de8bb8d0ac
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 04:25:02.5431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZh83Oh4gPw7sJRNs8emMItJY2FAnDL7PtiwXv6z1o7qav3Dhs+M6bRJonbFiQcfysqu6C3U6+d48JQ8oHPpTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9614
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/26/26 17:11, Zhenzhong Duan wrote:
> If pasid bits size is bigger than host side, host could fail to emulate
> all bindings in guest. Add a check to fail device plug early.
> 
> Pasid bits size should also be no more than 20 bits according to PCI spec.

this has been enforced in the prior patch. right? hence just drop it. Or
you may be merge them into one patch.

> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h | 1 +
>   hw/i386/intel_iommu_accel.c    | 8 ++++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index f3cb6cff1c..d11064b527 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -196,6 +196,7 @@
>   #define VTD_ECAP_SRS                (1ULL << 31)
>   #define VTD_ECAP_NWFS               (1ULL << 33)
>   #define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap = deposit64((x)->ecap, 35, 5, v))
> +#define VTD_ECAP_PSS(ecap)          extract64(ecap, 35, 5)

perhaps VTD_ECAP_GET_PSS. I'm also wondering if we should have a set
of macros to get other caps as well. Like "s->ecap & VTD_ECAP_SMTS"
may be VTD_EAP_GET_SMTS(s->ecap, VTD_ECAP_SMTS)".

>   #define VTD_ECAP_PASID              (1ULL << 40)
>   #define VTD_ECAP_PDS                (1ULL << 42)
>   #define VTD_ECAP_SMTS               (1ULL << 43)
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 2fd26690b9..e73695ff83 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>       HostIOMMUDevice *hiod = vtd_hiod->hiod;
>       struct HostIOMMUDeviceCaps *caps = &hiod->caps;
>       struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
> +    uint8_t hpasid = VTD_ECAP_PSS(vtd->ecap_reg) + 1;
>       PCIBus *bus = vtd_hiod->bus;
>       PCIDevice *pdev = bus->devices[vtd_hiod->devfn];
>   
> @@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>           return false;
>       }
>   
> +    /* Only do the check when host device support PASIDs */
> +    if (caps->max_pasid_log2 && s->pasid > hpasid) {
> +        error_setg(errp, "PASID bits size %d > host IOMMU PASID bits size %d",
> +                   s->pasid, hpasid);
> +        return false;
> +    }
> +
>       if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
>           error_setg(errp, "Host device downstream to a PCI bridge is "
>                      "unsupported when x-flts=on");


