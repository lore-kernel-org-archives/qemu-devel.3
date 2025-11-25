Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37B2CFD37A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 09:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNpnt-0006Lr-3p; Tue, 25 Nov 2025 04:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vNpnr-0006LE-IU
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 04:57:43 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vNpno-0000vd-Ji
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 04:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764064661; x=1795600661;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rZzq2mxEW1v2ADYvUFefQrzbI5oXDxnGxiIDsLmSya8=;
 b=cpERhGng3WApsWZrk0VH67E991B1WhOgiQO4MHLoBFdvu8II0w1TnKo4
 +OriYg2Z4toiGfyh/7kktZfItBvnyBzSVOSCPrAgN+XodB4kBgZOAm6c8
 gl/Q4xqlESqW9OR7wrbkPM4iX/upt9x6FVK4R6p3dhbgyVZIveo7iKbQA
 ynOJGZLW2JS4KYrjHLt5/OPjKX/baL4bolNfXN0BkYLgF0753uBO/AtPK
 HIU1H5xuWDSydiaFkX5pJnUD/2MPWRedU6b2F9XxGhIoPwoEbv9X8/cRv
 LhetoitGMAqRvywx9acFyA/ypRFM3nCM081sxMWcxlg+5r+jAZmqD0zPE w==;
X-CSE-ConnectionGUID: RKwIKOPwTQGhXyEPSFJ3Tg==
X-CSE-MsgGUID: EcqcxeCvS+WE19vjDYiBRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77554560"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; d="scan'208";a="77554560"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 01:57:37 -0800
X-CSE-ConnectionGUID: QP6DmDgnSpmrOOiFIa3emA==
X-CSE-MsgGUID: m752xHRoS1W+gvvzIwd9gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; d="scan'208";a="223271025"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 01:57:36 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 01:57:35 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 01:57:35 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 01:57:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqRVfOUJI0vs/HzCEkRCDZrnI4chR35u1dOl6ZMXqKDaZV5w7o7iCE8cwZ6QhDVonukQv6ZNGHO6/IxastZ3rf0wUDcTTgHYgEbzSltJ3Kd3f7cAA3fuwkXcHi8kVDZ4iF8XWswAsHpRdIZqEOjcAkaC0xKvC++JbBXk7CTY73H5rCyA0Le1nCFCml2nhXTxcSWgdpK8rSJLMS0OCKElOH7MLc/Or3eKA2UigTgWbhTW9ml7D7rqxfIZjxOregr65ff43HO38fA54RlR5hBpcAq7AFWcQVTvgmSMARN5VyY6u1DQ7Z97jsq2JNhdnx6i3urHILcHwxpLsGVPbeuyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=infIvUL5VV1mpr4ek9cjnDr0anVfRFpvm8YI+z14gJw=;
 b=chVwnp81QRCiYLGo2O4T0dWLLfVDRrsgZdirqHJ6cwlB9GEYBZGhVAA2Di8UMaEMu+AB9XfbW/QCMB8imxMb9PfDAo+zwUPsjDAy/85qb2lqJU1A+uLiLXf11Y597iiyR7/tINTqU2MT8SntJ6sd4pwuMPmaSGh73YH+1r+6SZG4VrpQ0nWny8qnxKV+Fr3OafK/dPUhdLpMXF8Ujl0xA2cwaXao7qt3+L0pVvT+CVDtZLaI5aYbAcuGFF7YWPxlxdbVTiAkg2Z++KpiW5EeyP0JLzxnNHGyZSOxm/C/ZAfB216NyQbjcZoXvS4m8StZP+goAF3TeVYWTC6FDFOrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by DM3PPF74831EF4B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 09:57:33 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 09:57:33 +0000
Message-ID: <6db6365a-225d-4fbb-ac20-d10c424d364b@intel.com>
Date: Tue, 25 Nov 2025 18:04:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] vfio/listener: Construct iotlb entry when unmap
 memory address space
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <clement.mathieu--drif@eviden.com>,
 <eric.auger@redhat.com>, <joao.m.martins@oracle.com>, <avihaih@nvidia.com>,
 <xudong.hao@intel.com>, <giovanni.cabiddu@intel.com>, <rohith.s.r@intel.com>, 
 <mark.gross@intel.com>, <arjan.van.de.ven@intel.com>
References: <20251106042027.856594-1-zhenzhong.duan@intel.com>
 <20251106042027.856594-8-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251106042027.856594-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0028.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::10) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|DM3PPF74831EF4B:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b83108-72fc-434d-225b-08de2c090de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|42112799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFFmRkE4bVQ5bkNCbDZ6SzNaRE9zQmQ5WnphNTQ5eUozQ0NDTk8xSUFBVVRh?=
 =?utf-8?B?cTNrV08vZksxSXRHUFd3cHlpTEtKa01Wd21LVXdLVlNIQVk2SFB3OXcwL1Rs?=
 =?utf-8?B?cFRrNUFmazdFU1Z2K2MyMTlKY1h5ZUpFNFBYSk1WSW4rclhHYlo2YlR4UnBT?=
 =?utf-8?B?MXZnSmYvVi9BTDdiZDQ0YXRGam1vNUNBZnhsWDFBdTVMNloxeU90azVpMUFj?=
 =?utf-8?B?cGRTWmhTWCtEdUNGTFMyMnJObkpGMG5wbVBYaU1HNXMxT0paK0paTisxQkxh?=
 =?utf-8?B?Uy8vVFBjQ1hkdjRsL2NCSXRPekRkK1N5K2c2ZVdZS1N0UHl5ODIxRVhsbXhO?=
 =?utf-8?B?YnpxNkM3TWxMUWFmcGJXeE80V2h6ZGZ6VXF1ZDI3b0Q2WWVIK2o0R2NGSlJY?=
 =?utf-8?B?VDAxMldPTzYwMDNVUklISEVmUUJHb00xYzl0RjRSOFVRd3JrMVdpb2RVZjMv?=
 =?utf-8?B?RTdJUFpWRGFYcHhDVERQdXFNWkpzQ0c3M0VYRjJhVnVEZlcvRm15YTB4cGcz?=
 =?utf-8?B?d2RFcGEwK1dlUEVYYVZINGgzSHFkVDM0Q2k1MUtrRFhLdlpNR2ZkOHk3ZGx1?=
 =?utf-8?B?cVFNVThTV3c2UFhSYlBpamRIbW5xdHJLODFzZmlpTDRkeW5HQTN2Wjc0WThp?=
 =?utf-8?B?RlgxR1ZaVml1ZGVPTnArbDJEK1EzempVN1hTNXY5ZTZ1d3Zud3BScE1Lbzhs?=
 =?utf-8?B?M3hhV044RlF1UjVsMU5kYzRQRGlZdXl2dnZXalp4RVg4aTM4NUpjYzhxSHJL?=
 =?utf-8?B?cTV2a05OcE5SenB2emFhYS9tT3I4ei9na01TRVNGbitJb3p6Z0VRMkhDbzZi?=
 =?utf-8?B?cnYwYmVlcFBDQ3NxSUovaXg5SWtsK2pqN2R1aDNFaXpoSTlndGllc3BwUWNX?=
 =?utf-8?B?UWNkSVNVb2l0THVpTHRDN3oxL2p4ODEwZVJHZWExcEh6QWdQV3RaTVM4Sm1M?=
 =?utf-8?B?SVNyOUdOL3h2VFZEcVRLMWV3enVZV2huTytQSWZEcFg3ck8xNWxFK0lMNHIw?=
 =?utf-8?B?UHdZdlc2MWpwZFNtNGhoa2FPK0x5ZUpYQWpnenFKMkhDdTlUcDkwQ0hEVU1x?=
 =?utf-8?B?ZGFGcDN6dDRkQXB3Z2RSRGF5aTFDeUtQd0N3UlFTZ2loKzhMKzdTMmtSWnN1?=
 =?utf-8?B?TjBXOGFGTkUwM0l5K002SU1aUzNTdXIwajErWWxpbDdEdDRpcU1VaDBGZEd1?=
 =?utf-8?B?VzBRSnplc2lqKzdZbnVEVDJSbkQvM0RrV2dMVi8zV1RDVUcyYmZSL3daS2or?=
 =?utf-8?B?OXI4RDFnR2tQUnE2WGx1ay90UUV2Z2xON2RrY25mMVdKRUcxdnFxaGFtcFYx?=
 =?utf-8?B?SnMzM0VDYUNvM1k0aUo0VmlkR0ZubVhpSWdGdGFpSXRjNUVWbVdqSjdGZFN4?=
 =?utf-8?B?QlRoVjQ2bXZEUVhIU1BxZEFuaTVDTExGcHU1TDdqNk9Ma1NzS2xXODVrSTY4?=
 =?utf-8?B?WHhVZFh4c0o3Ui84aDU2V29vcjBTRFZtemVtRmxUSXl3eWJvVG5ZZldnaVgv?=
 =?utf-8?B?aVpWY21KMGFWWmYwWERSSSsybmFqVUpSTXFFRndjQzQvblJLbkdGbGdCZmsw?=
 =?utf-8?B?a1FQRm9JYmlGQnNKaU9FcjRaWEdMdmtpemRpWnJENkJocVZ6b1RHU1Vqa1pK?=
 =?utf-8?B?QTNyUE1LTjBOUmZxWjRLOE5sVDFsMWdicmFWTFVCaFVhQ2dMUFhuRjgweTFH?=
 =?utf-8?B?Mmh5aXhnU2F3bkFBTmRQa3RMdHV5aE00RTVjcXNpNEJTdWNDOURvVG1abTRl?=
 =?utf-8?B?ZTV3VTFhcGhIZEhwWENVa2UvZzBoSkRZaEcyZHVtNlphaGNPdTFGL0hYTXBy?=
 =?utf-8?B?aTlxNllHeXA1NkcwU1NDSXJGeVh3Y2VZNWx3S1AwR3UrZjRpb0Z4Mk5QUW9s?=
 =?utf-8?B?TnpRWHBvUWJVLzVMaFIwYXZLK3pZL29wY0xjOEJubDYzaHZ0R2NEaHpIYzUr?=
 =?utf-8?Q?K9UiQ2jT9UNOKhAsSNxNg/DZamexY53c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SSsxdnN4aWtLOWRiNk1GbVFlRW5ZWldXZmR3dGg5dDVETFNaVytaYjU2YUQz?=
 =?utf-8?B?TzFleklET3BlZHVlZmZ4eFFwbjNFb0dieDJlNzJmdmoyT2s5TlgvYUJiK2ow?=
 =?utf-8?B?TTljR3hEL0ExUnV5UHZBOHRFWlc1c01JSDZjUE50c3hsdkNnTGYzNDNjdG81?=
 =?utf-8?B?eERBVWwrZ0h4MnBRZXZKblN5eElRYWtob1orSjRNUkJpTit2azhqTEpTY2xz?=
 =?utf-8?B?MmZpNUdXN2g0NVllWTNpV01hNDlHQlNmb2cva3ltampNUVJkRHVFN1h3aGZ6?=
 =?utf-8?B?a05uSEg5ZHdpSEZjcUZ2TkxuWkRySEk2L25xeDg5QUwrcTU4em01eHRSaWpq?=
 =?utf-8?B?eXRHS2t3UzJwdXMrUHQyL09CcmNoTkwyWnljQmpKMEY4eWhQNGR4K1Yxbi9D?=
 =?utf-8?B?bHVDSVRTalhEQkdOWG04UUVLb29xNnVFQkw2OTJDSDN2M2xKaVJlU1hvOXhp?=
 =?utf-8?B?enJVRnZrK2JYeThBN0V5c1hQb20yMzRycER0Wk5NRDAxV0JHRmJ0Y1B5TlN0?=
 =?utf-8?B?OVNTcDFzOFpFaW9CZTVGZkVHREZ4L09mYXRFQUliTTZjVmVvNWlORDNrZ2JD?=
 =?utf-8?B?ZDlBSGdzbGl0b3dwWDJQRWRtZEhmM0lXdmR6bW9zQzA2QXJHUEFWQUdBYVFT?=
 =?utf-8?B?SUEzbWROelJIVXgrVlNxcHF0eFd6N2RMdmo5VUpPWjZwM0lMb3ZWNDlOcjlE?=
 =?utf-8?B?a3FTejAvdGlzR1MyYTJUREFhQWUzK25wbmQ4QlVxVGJlNUtYMFRtMTJncVBL?=
 =?utf-8?B?NHVmSFArMkVyRGNvWG8rU1BGN29JRkZ5ZlJVejlIcWRBOHVmK1ZraWJnRTVl?=
 =?utf-8?B?V1NpQzBhWlVmOFY0bUV2K2NJQzU2aTZzSlNkc3BCNS9FLzZFWHVFb0w5T2N3?=
 =?utf-8?B?TEpBT2l5cUs4NE8zc1RZc29GQlIySk51eTlILzlLeWJCM2VUSlFNdDZSOVdD?=
 =?utf-8?B?UnN2U0t3K0E1WkVKQVBzaDVpUmFvTXBjbEZmcjFmL29ldDNCZTVUdkZZM1du?=
 =?utf-8?B?V0tIT3ducEUwb0k2aXFhUUhLS1RZcWJjSm1VMGZocUo5NjhRMVdZdFMvUHR3?=
 =?utf-8?B?c3kvdWcranpLMzVWK3BRUWJ3SUl2QXJzeE1OSjRRV2dVTlVGemM5RTZZLzZT?=
 =?utf-8?B?b04yc1JjNmxLVFR2a25oU1NWaTRvM1Z2TjF1d0h1c2VuclJiaUJGeEFiTkpi?=
 =?utf-8?B?NytrWXBrbXRmS3dMeEQ2RG5RUHVLdlltNXNRMURRYnRlbzhNR0xLaXowc21P?=
 =?utf-8?B?dkJ5UGtYcmZyODJ0YUJtQTNIaGdxVGZoWFlML2RrMWNPSnZDQ0s5L1pYYldH?=
 =?utf-8?B?WG1NYXdpaWNwaERBZ2JUdjhOeHcxUHBoajMwdWhFbVYwcDVZb0VkZWlyYVFa?=
 =?utf-8?B?bG5UY0k5c2RuQnYvTUwvV081eVZLUDV2NE96YTgxMy9reDhUQTdVRWtJeVJj?=
 =?utf-8?B?WFhnRGFrdXdqQ1R0Tk1BRENJcjVhaWVCTGh0cWxwdVZkNnNNTEJuYWt2dzVw?=
 =?utf-8?B?TGxqeHdJblFERkY3clRCOGdpa1lwUi9sVkdpcjYxOWhWUUZFTkdod2ZQUlJS?=
 =?utf-8?B?dkI4RzFhWVN5K08yYi8zT0ZUUGVTdlRHZ2lhZHp0WXZTNGx4bjZpWUt3ZnZW?=
 =?utf-8?B?cXFpT2hwMzAwaWVZazZaM0w3K0tkc2dHZnRvRWYxa2h2WnpqNDVqc3NSeVUz?=
 =?utf-8?B?YkN1UVVYV1Y0Q0xQdkh2ZFh3SkorNW0za1c0blRzME43VDdVOWJSRGRjMHZt?=
 =?utf-8?B?aW8vODU5ZnhPRTFjTXhLcXM1cndBREZibWxteTcvNVZwTXRjcm5iYjZFYmlx?=
 =?utf-8?B?cTYyVUhNRG9JRXBhS3I2dnRIZElYVnVoN25BNU1adzFkZ2UzY29jYnpRUlNq?=
 =?utf-8?B?OTJzUFdtSFlPL0d1ckZrb1ZHT0o4RXU3ajd3d2RISjF5NktFckpRQVErZ01k?=
 =?utf-8?B?dWlMOWVhMEZ5OFNHTTZIWUI3amxpMEV1ZzJKUmFWWGU1VkpiMDRWQVgvSUo5?=
 =?utf-8?B?OXc1K0tiK3VNM1ZnaFpGUHhTQk5FVUNIQWdDSUlZRjc3OTQ5VmhNcUNaUzVV?=
 =?utf-8?B?b0tYUk84UW93RkZ4bXNwQzhlMlZBSTEyNHRrK0ZKNkVJTDlsTXRSL3FCYWZG?=
 =?utf-8?Q?b0SMMMKoG37FUgNetwvkxnocf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b83108-72fc-434d-225b-08de2c090de4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 09:57:33.3801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4jjFQnXDNg0RH1TSkxG/14XwNT4u+RI8qfEMMbYipsHcUSEbWPujL7n2mF7E143kfniuXz5aaciI8bQ2m7qBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF74831EF4B
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
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

On 2025/11/6 12:20, Zhenzhong Duan wrote:
> If a VFIO device in guest switches from passthrough(PT) domain to block
> domain, the whole memory address space is unmapped, but we passed a NULL
> iotlb entry to unmap_bitmap, then bitmap query didn't happen and we lost
> dirty pages.

this is a good catch. :) Have you observed problem in testing or just
identified it with patch iteration?

> By constructing an iotlb entry with iova = gpa for unmap_bitmap, it can
> set dirty bits correctly.
> 
> For IOMMU address space, we still send NULL iotlb because VFIO don't
> know the actual mappings in guest. It's vIOMMU's responsibility to send
> actual unmapping notifications, e.g., vtd_address_space_unmap_in_migration()
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>   hw/vfio/listener.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 2109101158..3b48f6796c 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -713,14 +713,27 @@ static void vfio_listener_region_del(MemoryListener *listener,
>   
>       if (try_unmap) {
>           bool unmap_all = false;
> +        IOMMUTLBEntry entry = {}, *iotlb = NULL;
>   
>           if (int128_eq(llsize, int128_2_64())) {
>               assert(!iova);
>               unmap_all = true;
>               llsize = int128_zero();
>           }
> +
> +        /*
> +         * Fake an IOTLB entry for identity mapping which is needed by dirty
> +         * tracking. In fact, in unmap_bitmap, only translated_addr field is
> +         * used to set dirty bitmap.

Just say sync dirty is needed per unmap. So you may add a check
in_migration as well. If not in migration, it is no needed to do it.

> +         */
> +        if (!memory_region_is_iommu(section->mr)) {
> +            entry.iova = iova;
> +            entry.translated_addr = iova;
> +            iotlb = &entry;
> +        }
> +

While, I'm still wondering how to deal with iommu MR case. Let's see a
scenario first. When switching from DMA domain to PT, QEMU will switch
to PT. This shall trigger the vfio_listener_region_del() and unregister
the iommu notifier. This means vIOMMU side needs to do unmap prior to
switching AS. If not, the iommu notifier is gone when vIOMMU wants to
unmap with an IOTLBEvent. For virtual intel_iommu, it is calling
vtd_address_space_unmap_in_migration() prior to calling
vtd_switch_address_space(). So I think you need to tweak the intel_iommu
a bit to suit the order requirement. :)

BTW. should the iommu MRs even go to this try_unmap branch? I think for
such MRs, it relies on the vIOMMU to unmap explicitly (hence trigger the
vfio_iommu_map_notify()).

>           ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
> -                                       NULL, unmap_all);
> +                                       iotlb, unmap_all);
>           if (ret) {
>               error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
>                            "0x%"HWADDR_PRIx") = %d (%s)",

Regards,
Yi Liu

