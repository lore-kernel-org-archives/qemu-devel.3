Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355D9CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN5h-0005Tf-JO; Sat, 30 Aug 2025 11:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urs07-0000i0-Q2
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 01:50:15 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urs05-0003dS-DS
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 01:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756446614; x=1787982614;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/DxZQH4uCWHlYDyvRb/JmFp0F/O5EiboQEtDBYoJHhw=;
 b=BnYsBpchPmpMZjw2Vvkc0RsJ87Fje0G4+Bmqn7vB4vYBKP7K0LTHreKe
 RVHNzdr392xuvxusGUvq8HkHHCQouckEuipwoz5i+EoDtl3f61+PmDW+7
 yEckTtV6sWtT2VoHPO1lCeao3IF6ov7N4HZH5nooZr6e4G1m5Toc/lILM
 EJn3hv6TPOShHYrgyS8MLaF/jSYLj6BmWkUpyNFIDyW2BXCwjMcFvRs6f
 k8d/D4wuxkwT3b7YHkmZ21lAytJhL9DLFUeK+i0Fd4Iy7cObNnPHWNCCp
 oakDErJ38MBqrfPKkdTKQaC6FpAMgPWnFDmCyZ/jL4/1S/3R/mYfyBaLy Q==;
X-CSE-ConnectionGUID: nlVXp5eGSUGUgs5r+P2TeA==
X-CSE-MsgGUID: S35p0F4tRKWD9uwi2KWaYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58436905"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="58436905"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 22:50:11 -0700
X-CSE-ConnectionGUID: afyRa96vS9aYgawHlx5Hag==
X-CSE-MsgGUID: hoWv7lkTQhyKPhF9DbTURw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="175597630"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 22:50:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 22:50:09 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 22:50:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.43)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 22:50:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlkyqN0js/dRo8qKAlWjjrlYVpfkBYfTkTUmdvyYIAX5YF6bDdV3uwNNtd4ALXov30qnPySdj9PMYX9WM+Q7RJ7eWy2xx3ynR50d15TiHLz5mupFxUK5gHsdDV0dz2n94ZhKPLh88bnnGUA82u3i3gj5vBApbFcxP/a+F+xzIXV0kVQJ6+sGVMHn93JOMu+c23Nf3riIjAPQ6M/aofVWJGEO5gYGhqUTRNx0YDCNH36QxggLBe8oFTZCqbJ2hab9L2Fwf6koMtdwDUuz0Dqa9Kehq5hqJgF+5macyMhk9NsA7+BeOFkbt5Py4hy2KgL4i47Iv8rQQI+YUb76kXC8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hrSIcD1iQpBYS9APvxjilAoL0cEj83GTf1I5owVCh0=;
 b=lJL2YfPWvn+vdGn+MWt6wvVbv4BRcq1lUZQoM0ZFWxxy4Mx1ZazoEJ0SA+gui90NN5lRV/OgLgPMg7F6pp24ygirdJAi2AQUucDHTamC9pv+zi+PjNzii5ejGMlIG8ehz46VCPW03r9rJGynPs+UJY8kPaq9ZkEaew1lNz9uKQ21oV7Ety0844PvPoIE8pDuh7CWCt2frH3piuJ/b8WMzQZUmO9dSSCsjgdrx3EIyTJabVAkZgccdU9U4RFmFb1lsu+fGgdzSK5HcracqedISto9KN5doBb2itXSqmDJ2LhF5Gs2HE7yoBA0Dy32llz8BKf/+WNHrwTuvdeoSPeizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Fri, 29 Aug
 2025 05:49:59 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 05:49:58 +0000
Message-ID: <dc919852-01be-4c19-832a-19f694f0448d@intel.com>
Date: Fri, 29 Aug 2025 13:56:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/21] intel_iommu: Introduce a new pasid cache
 invalidation type FORCE_RESET
To: <eric.auger@redhat.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <peterx@redhat.com>, <ddutile@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-14-zhenzhong.duan@intel.com>
 <c53b7bc6-fe76-4357-9eba-56f4c3111fa9@redhat.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <c53b7bc6-fe76-4357-9eba-56f4c3111fa9@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|DM4PR11MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: c3dce36d-31bd-43d6-97b7-08dde6bfe2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1kxelo1RFhybllKYTNsQ3lVSnJKaUN6N2FYSWdnazBXeEovSHJxU1dIbzNi?=
 =?utf-8?B?eHNkYlRYcHR5ZFM0TmRIeVJuQVMzeVdWa05aUkxpajE3QzhlN21hZHlaZHU5?=
 =?utf-8?B?VVFuaFAvT3Q4ZlQvVnA3S2JpbEViVXVSQURyMTMzQTdveHlYdk5jUExSMkdC?=
 =?utf-8?B?OVB3VStjV09oSFA4UVlnQlZEVXIyNnJ0ZHhyNlBVZStXQ2tQd0tvWDVaaUhv?=
 =?utf-8?B?SnRwNjRpSHVtcEpiT3I1TWY5aUtGNVJCcSsrdzZWS3J2TTE1a1NlVGU0WXZB?=
 =?utf-8?B?WVAraVBjcmJYckM1ZTdSdmhXWUNDREo2Q1FOalo3RktaQmpFemx5cVFKem9m?=
 =?utf-8?B?RytlekJiWWFnUS9JTEZ3eEZhT2psYWplWEVEbVdvbVdCVWpyaE1CK1ZlTmNE?=
 =?utf-8?B?RjliQ2daWWRzRm9ROTRCOHQwWjJheDNFNnV1WVNIdUdrRHVtenVLQW1wSDNh?=
 =?utf-8?B?eFpoaFMyM0ZGb29XM2d1RTRiV3BGVkhnb1hZY0JvODNMWmQyWW5uSStWSHZ1?=
 =?utf-8?B?SStwMGlsV1Q1c3cwSDZiR3g3cWcxT3Y3S1pSa2Z5NGI2VldBaDh4TW8vUEVu?=
 =?utf-8?B?WmFYTDFQYzJYT1gvUW85YmVEOTVwZVc4aWc2N1BIdlZaWkw5MnV6T3NpNWo4?=
 =?utf-8?B?VE42MXRWeGwwYm82Z1pmdmc2ZEFtMW1Wc2pSZENxU1FhWVFXVm00WVkvN0hx?=
 =?utf-8?B?bzI3cGlLY0VreXNuTUhCM3BjZnJMTThVTEpoaEIvMnBUcEhLdjZhRTY4anNS?=
 =?utf-8?B?RDN1bVVZbVVIeU9YU2p6cHNOaHVkL1dBMHovNmVaZGdaY1cyY1VsRGJ3WHc0?=
 =?utf-8?B?WTdSSDg2UlZkb05Sd0EwY2pxQjFRWVNXb1IxcEJySHp3S3B3Qm1RMEJMeTRF?=
 =?utf-8?B?V0tvME1BcTYyalA4Vjl5SjdsRGUxL3kyZzhKYk1kNS9pSm5hK1J3aldScEVn?=
 =?utf-8?B?UjVWbWNjTnR3N1JHdnhtMnliUUh5K0JadDRoOUdBdGVnSUQyd0tISjNwM3dM?=
 =?utf-8?B?VFA0OFlNcWtISVpLVVNnbEwxUUZYbGRGS0JUbXJYR1JQRjlMS0lQV05SWGhP?=
 =?utf-8?B?Q3RUZDliVTJzNHg4SHhZc0xUcXk1eEN1ZGhNUkVOTERRSFJyTFBucllHSzFx?=
 =?utf-8?B?OFk3NEVUOVhNenZUbzd3b3orTHRMV2gvazY4THV0MHM3T29KSi9sRzFKNk03?=
 =?utf-8?B?V3VGQk01bnlHQ1l6RkpCMEJlVGltdmllMDdNeUhjU21YTE1QK3k4RW1BOXdL?=
 =?utf-8?B?dCs5cFJianF3MkpvdFVMWDY2eXRuM3dNRmxJTUxzNWE1YnNMeHBGd3N4Wkh2?=
 =?utf-8?B?Z2Zna0d4bVFoVEpvOGdkL0tRck9iWUluNndodmdzN1pIdWlnc0F6dkFTT2Zp?=
 =?utf-8?B?SDBEdmkzeHQ4V0U1TGpJaGZERk1qSExHaURmM09KOFRTWUFjRjR5MG4xM3VQ?=
 =?utf-8?B?TGUrRERSdHZreXNUM0x3QjVFVEtyRHorTGVGN1B3cmtWUlVrclFKeWtQWlRO?=
 =?utf-8?B?OEVNV254d3FkN0tpMncxNjdMckZiK1VUZlZtd3RWM3BTTlliaCtHRDIxbm9S?=
 =?utf-8?B?MHV5SFlYaXMwNjJMTUp0YklNUTMwN1dDNmFCYXFGRzVWU2d3eVZIRldJLzUy?=
 =?utf-8?B?RkltYitiakRkTDNNeGZ5b2U3amZxNGZ1WWxsTytaMEtXbEZvak4xZFZReUR3?=
 =?utf-8?B?cDFDT2tjOW5vTFpqV1RMYzRNTExaMHAxWGZOYjNwVFZnRHlxbWl3aDY4dUQ5?=
 =?utf-8?B?NXFmOUJRR09SMk5JTFVudG5zeTFOYkpHaERsQ0dUQ0RCVm1QaUdGSFVOYTk3?=
 =?utf-8?B?MlhMb1ZXcE04eWVvNXJZYUtXRnZOaUtSeUM5cHZUWGNycEpub25FaGlHTy9n?=
 =?utf-8?B?cFA2VElzRm9hNzIxb0VWUE5rOG05dDAxOFJyT0tQbzdiR2FrelV3LzlHemNp?=
 =?utf-8?Q?PaxWCyeTCXY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1E1TXlWS1ZpeWRuYnUyMHdnRnY0NGNPYkRJSDF4VzZRK0doM0Y1UXRkY3Bq?=
 =?utf-8?B?WGx3V0pjKzJscFMrcmdkakl2SnE4OEVIZzNteFZOZ0UrdGJFenFrZVJlSU51?=
 =?utf-8?B?cDFSRk5iMVVlWjdLSi9oZUNBWnFsMDI3K3g3U3VnRjR4WGY2STEvN2VHM3Fo?=
 =?utf-8?B?ZkZRYlFtK082YTA5U2dhZ2dHWkxXUWo2MTNNVzhUNEhsT1dFVGhQOFlDWXpO?=
 =?utf-8?B?KzBQOTNScjRwSlRDMzdpWEtuaUhOWUZ0dDNZTk5kUnkwbnZSa2Ruc2dLdmhy?=
 =?utf-8?B?TWVkQ3BDbFhVaUxTZ3hTdVZFQjhQSFY5cW5lbjF3ZWlRd1dXVFV2OUhSUkds?=
 =?utf-8?B?aU5jRjVUb1NudTl4WHg1czltdm9VS2VLS013b2E5aHpOWDcydEtjdGhWNEFC?=
 =?utf-8?B?VzRHZmkwVm9EOU95SFZrRmlKS2ZVSnhuY0QvY0V4Q3BPbzQwWitSMjg4NC9S?=
 =?utf-8?B?VzRwZkozT0lUbCt6YlJOdmphWThpMDY1NWZ5TC9aWXkrekppeUxpbGY2Y2s1?=
 =?utf-8?B?NU9lUk8wSWd2UG5tUVRYYXFEbFpZV3R6YnBLZzNyQzlTTmw4cEU0RnBqV1o2?=
 =?utf-8?B?RU9nRGtvOGh1MjFlVUNFcmxPaWZ5Y0VyMmx2bmpZM1pvWUZSTDk3OXJUNk5M?=
 =?utf-8?B?UzNrWFNzWU1rQ243ZEl6UmdiWFFSdTBMUTY0MnlxeWlTVmFYRGN1TXdoc2dF?=
 =?utf-8?B?RFNmajE0WHVLTmVsaWQ5cGdXSmxWTTZHZVVpTWxqcVNpUHZSNm5Xanp3ZC8y?=
 =?utf-8?B?Y3RXckcxRWk4QUZOMVA2RjZuNU5vRkFkcVdVOURSb0prZFNRZFlSRXJIblJS?=
 =?utf-8?B?R05FVU5vVXoyNlN5OFl2MXdiSUxwUkVCVUxseUxGcXFUUGFZT1lvdk1UZUpj?=
 =?utf-8?B?OGNmcFlidTlJQk5lS3RrU1ZiUUV5di93ZXBCbHZYb1pIa2phbWJvczhna2dT?=
 =?utf-8?B?WHFJeDVRRUc1VTczYmhNTnJEQ21GTHgzWDF6Tjg1RXpEV3gxU2V1SjVoY3I5?=
 =?utf-8?B?d2l1TitIaGtySllsbi9OM281eFNSS1UwR2VaTTlUTGg0ZTlER2FkN0Z0NFI1?=
 =?utf-8?B?eHZ2K0U4RjlybVhrV1FpSUZqSzR2SGhvZVMzV1k5c1ZKRzZEQ1lCbFZaN2w4?=
 =?utf-8?B?ZW1WLzZRSmRWczRVVUFrZ01LRThSM1NQZUpYSTFlU0k0UWFHSUJhclVIc3dn?=
 =?utf-8?B?Y2U5dFBqb2tNaXpFQXRwWElib2FZMDJxYnUrVDkyeEdpK3h3enVTdlhPazdU?=
 =?utf-8?B?S2J2K1NSMTFQdTZDL3lSRVBJbmsvaEgxSDY3Ui8zZlhuZVNocUd3MWdVMmtu?=
 =?utf-8?B?c0NOV01uWkFNRytJdFNDdXpneG5wVlhjakF4SEkwT0psTTZrRXhwVjZyZEJD?=
 =?utf-8?B?bUlJdmpPd0dpcS84N2hhbC94eTQ5ckRPRzd2L2FwVVArYzVxeDNxK0x6T1Jy?=
 =?utf-8?B?TFNUMFdqMXhOSHZad0hKR3lhS01kZ3JndUNOK0FISS96NlovRWE4d3dBcUV1?=
 =?utf-8?B?QmFOMDc5d0xVQWVBazlWUFd1WEI2ZDdCZTkxNExyM21UTHdaU0dpZ25iNVNa?=
 =?utf-8?B?UzNPTzJLU1NUNnRQeGJvWU9LTkFWS0txRjNBZGxNVFBKY01EZlFTY3lSVkpK?=
 =?utf-8?B?eWZxa2NSRTBTQXdTaWZQbnlRb0s0TUw0OVV4c0pobG5GdXZRcDYzRTRCcWJT?=
 =?utf-8?B?cXRBVFlmYlRkRTNoQXlnRHU2dDd1K0o4UHN1SFpUWUh0Y2grVVlEelZwRTZQ?=
 =?utf-8?B?WElyUGpidy9MZzlnMmpxR1VoM2NWdG5OMlh6ZGFST2dtOVZXZGJNVUxkTEZj?=
 =?utf-8?B?eE14bS9RbUtnd2U0c0NVdzV5OURuRExzcnpIWmN6dzQxdWtaVUxVNlc5czlY?=
 =?utf-8?B?STY3UHA0b3ZFeVIra1FsRDA0ejdLS0QxNFM0aFVOYUhZdVF0ejRMVnhKWTQ3?=
 =?utf-8?B?aEN4MFFYNXFEbEI3Z3lIRHFGZC9ZNkFyTGFZYXJvdVlDVDY4OWZqVnU5WHlU?=
 =?utf-8?B?TnpLWFZOYnNocnlRWjh2bTQ3VTlnNW5DeWZ1c05Sdkc3empKVVZBcElDekV4?=
 =?utf-8?B?VVFVVDZHcFVoM2xPMk4yUE9ZbmRwUkRuekxHdVpMaDhveTFhSEwveEY3NURh?=
 =?utf-8?Q?FUeYUZ6J/wtJwkMAWzkjlKWgt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3dce36d-31bd-43d6-97b7-08dde6bfe2e6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:49:58.0544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWDitamXAshFpwdw+M/udwUfvKamH5eEW6q3gZ3yEApPIwPX3YLPVt5+kUg7gi6KoQiPtO5oA8qkBkUmStvbBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2025/8/28 00:28, Eric Auger wrote:
> Hi Zhenzhong,
> 
> On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
>> FORCE_RESET is different from GLOBAL_INV which updates pasid cache if
>> underlying pasid entry is still valid, it drops all the pasid caches.
>>
>> FORCE_RESET isn't a VTD spec defined invalidation type for pasid cache,
>> only used internally in system level reset.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/i386/intel_iommu_internal.h |  9 +++++++++
>>   hw/i386/intel_iommu.c          | 25 +++++++++++++++++++++++++
>>   hw/i386/trace-events           |  1 +
>>   3 files changed, 35 insertions(+)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>> index fb2a919e87..c510b09d1a 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -569,6 +569,15 @@ typedef enum VTDPCInvType {
>>       VTD_PASID_CACHE_DOMSI = VTD_INV_DESC_PASIDC_G_DSI,
>>       VTD_PASID_CACHE_PASIDSI = VTD_INV_DESC_PASIDC_G_PASID_SI,
>>       VTD_PASID_CACHE_GLOBAL_INV = VTD_INV_DESC_PASIDC_G_GLOBAL,
>> +
>> +    /*
>> +     * Internally used PASID cache invalidation type starts here,
>> +     * 0x10 is large enough as invalidation type in pc_inv_desc
>> +     * is 2bits in size.
>> +     */
>> +
>> +    /* Reset all PASID cache entries, used in system level reset */
>> +    VTD_PASID_CACHE_FORCE_RESET = 0x10,
> I am not very keen on adding such an artifical enum value that does not
> exist in the spec.
> 
> Why not simply introduce another function (instead of
> vtd_flush_pasid_locked) that does the cleanup. To me it would be
> cleaner. Thanks Eric

this makes sense. Just wrap the code after the remove tag into a helper.

