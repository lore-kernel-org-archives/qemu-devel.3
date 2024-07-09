Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D330EC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR40A-0004wa-E1; Tue, 09 Jul 2024 02:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sR404-0004pA-9o
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:06:52 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sR400-0005Xz-VW
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720505209; x=1752041209;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PuDHRplVWbjvaCH8Aj1j18tB0ynPP2vMo5HykoC45Ek=;
 b=hHb7+HaN1wqYoEEJNXEY0GJ8pEL7/bih6MoBVPNKMLToHhZTfWzoeYrP
 nnNETmIKrtjOSXQpUqI3H8WsYxpFBTKGf/0Qvxbn2VOwyaBobbgoIUMDF
 +B79YBK3PjtSguXGatal7sy4aDPjpiScbpXctDqjpCLE6piqcCQqKV2Gh
 Y4TIecFNuFfNGF2dcdiIqgqcriW01UouZZGD0OFlEwEMeFcgQmA2sP7UP
 cIk1BFb5PCeqrlULwFZgfu8rjB87iH6ZnLHpz+7i71lw/gm8beC5xijJd
 /rM1mj5pQy1Cab0CsN/lHdaAP6LgVC4lS/8ulu328flGQ/RT3YsywgmCj g==;
X-CSE-ConnectionGUID: VdaiOa8HRxaaJncHWYCzPA==
X-CSE-MsgGUID: zRJxmlWySMC+JQwG0FkJpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17943614"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; d="scan'208";a="17943614"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 23:06:46 -0700
X-CSE-ConnectionGUID: wQBMOB8eSqufcW057vKWCQ==
X-CSE-MsgGUID: XG+9e3gFQmKDjHVfW/8zwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; d="scan'208";a="52678744"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Jul 2024 23:06:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 23:06:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 23:06:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 23:06:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 23:06:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkuCxXtmoLrzjrUAJikfMeW98hDepkIxvbEG9SoUjzXa6UF56L0uhyRN+9Jg1+Q3Hv0hyY2N6xZ6Qv9w/Xem3mxs8CnXUcpQYCl0Ii2qOQ8LA/xG0GOOd5Hn3THEGee6feKinfKZd1LPIHu9y3AilV1rpwChT5KxDYiEldYq9N3fYEvAnXnly3bRsFEzRqLYV3rIRJEuIJrsWKKSX7CFRt1uZSxpZSrdW1zr8MyUrUiPk2n0zf/my7SGhAzFHWjYzagxdrNYQ9ef3oweCDJ+N2LDOWtMEvT8LsJGy3vYWFrK1mCVfkagSrcpzswBuOP6TqSHZoS83066GgAjJDwDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWQ0FVQXOqQqQq3WEMu5HbE5XzAj3dB3I84sneKGA3Q=;
 b=YWHlnFL7sCYW4L0MG3MnqfqvssgR/y21AVPZOD8WbudvHQxUO94QqF2SyWxOAGjVbJXKMTJyrPiTZ2aRRLzr71eLMfKr3iXC4D0R/JSPxKLBf+kUiH8CuKdicToEN6eH6gzoG+lOLZeR55s3KnSDgb5cS2tnD50f90zb6pmJCocNqqC5QDL6qBIkdZo/aINJ1OvUwp+1vk7Dah7GjkNndfH+TYrcJYZ14Y4Eq2mVv0TsCDz4zsDXYNVd64+NGvjuLF68tefBG3qstTGbTKbfF/ulG+Hj/YsN7gixIxGmKNB+exr6TAfCoolUDqiJ+RU+Lx8a37KHprnJFmv9fb+Qnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 06:06:42 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:06:42 +0000
Message-ID: <a8a43d6a-c38c-4c8f-989f-3e2497ab7b1f@intel.com>
Date: Tue, 9 Jul 2024 14:10:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] intel_iommu: make type match
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240708113908.19535-1-clement.mathieu--drif@eviden.com>
 <20240708113908.19535-5-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240708113908.19535-5-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d82f6f-06a0-466e-253d-08dc9fdd4e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RS9kdVpuYlJGQjVZNXVXMzBrRXFNS2g5dUJkcFZnbXEyWUZJb2x2Wko5WTdm?=
 =?utf-8?B?UzlhZlhEU0FwakdOYm5TUTFhMnIrZm5lUUJUcVM2VC9nVE1odFlMOWpwZkhz?=
 =?utf-8?B?cEV0MXVEbEJDS2xsL1AwREpZMmZHbGZ5MGNONCtFQWVHekgrWHZIdEhnT05k?=
 =?utf-8?B?VXpDelZFa0htWmJ0NkJMd00wd2VPKzluckNuM2ExSVdIbms4Q01Na1hMSVJV?=
 =?utf-8?B?S3pNdEdwcWFXNXVURFd6V2svaVVCODJEZDNwWlQ2NU9YaXZhSUZWNWozcFI1?=
 =?utf-8?B?b0Excy9ZajNmankweGExdTlDRXhaQWtDZURFYmVRMm5tTWE0YndISE5tQ2hw?=
 =?utf-8?B?NVBSYzlYUFIzUVZoSnpMclZkVXJWaDFGcFdES0N5LzFKc0VicW52dkRvK1lX?=
 =?utf-8?B?d3VBa0RvWFZtcXhIZW5id1IwTzlpMk90VVZURm5WOTVrNWVQNlozT3QyV3Ar?=
 =?utf-8?B?Q0Zua0tNMmUweHZXd2EvSnhoU2F6U3ZaQm5lMjk3NTljZ3U3MnlhNGhUK1Bt?=
 =?utf-8?B?MEJnRHZKSzl5c01TQm1ZVEwxbkJJQWFmWERpVUFaTVVia1hEb0s4VmRMOVJp?=
 =?utf-8?B?elhtazJIM3NIekhnd3cwcEx2S1lmcy9UaE5RbkpaNzhsQ3V5ZXRxTWFYdkF3?=
 =?utf-8?B?UlM4cFN3dDJJeGJHNnhZdjFpMmpWa2JvRlU5UkJzWUFIdFl0U2diczlJZzdv?=
 =?utf-8?B?NHRPcDZib05DeTZmQ3ZNT2IrbVZNNytLVnVNZUF5N1ZqOGVqbDIzQ2tMM3hC?=
 =?utf-8?B?LzZmVlZmZjlqTnFXeWo5ZFZYMTQxVG1zSzhJdEZRakhuZ0NWSW9XeW5GSHZE?=
 =?utf-8?B?eVRLYjQyazYwUTBvMVBSY3FCbEVaQXEzSXdPdFpnMXZIVjAvb2M5UHpBclR4?=
 =?utf-8?B?aS9YdEM4N2YwekZ2NGtWendBRXR2MDJtY2pSdkUxemxSR3dYWVd6V0R1Skdh?=
 =?utf-8?B?QWN4NHN6ZlNBSjR3V0ZMVU1RcDZVVnc1VTJhVmFxb0tKNjJOUG9DTWpjYzQ2?=
 =?utf-8?B?UFROSHJkYnhlVjR2VytlMDh0K3N3amxuTDB0SjJRN01FdkR4eGdGdk1GM0tZ?=
 =?utf-8?B?bDVMcXcwZ2lHNW9PQ2RiekhKWjJRWEljNUFuT2JYV014SWU2TEM3M3UySXFu?=
 =?utf-8?B?b0VmRUF6ZHk5ZUxTcGU0bFRZdm1yczBEMWlQcFVoS0JIZjk2T25OZEpiMmlx?=
 =?utf-8?B?b1ZEdmdESE1nVnFBeUFRZjZ1V3NWY0Fwb01XeEpiNkdRL0dNNlF3aEkrZGRX?=
 =?utf-8?B?ZGhiWWhGZUx0d0kvYnFWejNWK0VQYkhnN1ZFSVBHcktrZzlPbWlLM3phbmZD?=
 =?utf-8?B?aGRJVlJabHRZUCtlR0x0anNCRlN2VG12cGZBQUFIR3J3TUZzcVE2TlVmV0o3?=
 =?utf-8?B?TXdhd2VOeGRidGg0N00rM0pqRy9zanlUVmVkcFZoYnZ1OFFwUExNV1lFZEtG?=
 =?utf-8?B?NEhHeGw4WFNwREZmZXRYbGdmQnFSdXFTTFo3dGxMN040L3hTc2RVdDJuRGdk?=
 =?utf-8?B?SzRRSkx2QWh3VkpBMEJBUkVVaDdXbWd2WGpHSWJIQ01pTitkSFJBR2RtT3hV?=
 =?utf-8?B?ZityZ0MyT3d6emVRT3hpRDJ5UGpiOUZzVXVFOG1rV0pGTGlNNkQ2K2I5b2FJ?=
 =?utf-8?B?VXllRXdaa0d2WkF5SkM3ZUdkalk4cE1kNXJpbCtoL09BOGc1NXBTMmdqNHQ4?=
 =?utf-8?B?QnRRN3gzNjBtTG1XdXV2Wnc2SGpQdlhXMUoxeUNoTnN3WjladFhmUWVKS3Fo?=
 =?utf-8?B?RzBCbkRkak5pWlBCNml5NWhjSExOeHhVbXZCOVdjbDRRYno0WG9BeEtuYU9W?=
 =?utf-8?B?UG9ncW1UWE13N0dENWVFdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlVuNEk0Um9taFNJSEZaYy9RaFdDUkRJUDBpbWI3Y0JkcTljbDhOdGhCN0lR?=
 =?utf-8?B?VmNaTzJwNGIxQk40VWhXSFVqdVRKR2psMkY4VWtGeXMyOVo5NStXM296Tm1p?=
 =?utf-8?B?azczb2l1bTR1MVozelhpRVpmSWlUM2NOTXFaYXpPUy9TMDNtczN2NTBBK0Rq?=
 =?utf-8?B?dkl0N3RTV2VMK0dUcno3RzBidk5COHNLNWZmY0t0UFlvR2xFQVIxdzZYTENZ?=
 =?utf-8?B?RGF2cVdDOTRGbDhPczVLcHBBQ1RRT2ozenVjNW03eXVWdGNLRGkrT1lkRlh2?=
 =?utf-8?B?aXdvT1orSXdxSDlLejhIVU1XbFp5RDZDWGlENlFzRG5BMTdSWG93QmtKeWFJ?=
 =?utf-8?B?d3BHMFNTLzY3b0tKSW5CQ21WVVRNbzAwOGduTGt6Nit5ZERrQ056Ri9HYnZ3?=
 =?utf-8?B?UjNWWEZKVVREYmZNU1ZXU0FGOWZ4aW80R0RpeWZzS0xEbnNJaWdVWGpNd1Ru?=
 =?utf-8?B?eUxONTN4a3dLb1dmL3k2eGdKTjJETHVJYk83QTdNMzh0dnNpc3FuU1picTdY?=
 =?utf-8?B?WWx2WXFvNDh6N3lIc3gyNTNGWmU5NjlqRFBlM1Q1VTUxNDZKaTQ5QWkyaElt?=
 =?utf-8?B?dkJVbG1MK0J2aitqZGV0RFprSWNSSWlsWUw0REFucTN1M0wxOURpeThjMlRn?=
 =?utf-8?B?RU1DSHVHSlNydGtYSlp5M3hwZW45QUc2cWM0MmxXeTI4aHdOSEZPcUhJc3hS?=
 =?utf-8?B?eEREL1lYb3lXK3JvemJIMjY5RHlyc05tMDEyUnJ2bXpEWFdlM0luREpiUlNh?=
 =?utf-8?B?MlV4dUFwQ0tWS3ZUWmovUTdtQnRsK3FoZmZadmVPT2FGeWNvbTFGRE5QK3dT?=
 =?utf-8?B?aWRGN0hZYk45Y0t6S1NOb3VGTWI0bGdzdjVEVzRUK2ZHNDN5cFFGUU83RkVr?=
 =?utf-8?B?SytVcHlJTUIwNjFoaTl1TDhwVFlMQ1ZZZmZEMG1OOW5DSzFSWnFrVUoyRE9S?=
 =?utf-8?B?bEVHQXhCT2toS29NZWxHZTA2WjNod2NsS3kzMVp3QVJpOXk3cnBRY3pBV3N1?=
 =?utf-8?B?VTMvMW9VY3hmbmtjYUhJUDFGQWhmMGJxWjdZRlEwQXZKMkhra1BYZys3cHY1?=
 =?utf-8?B?akVCSnBINzVGVzR6VENwbkdtc1ZGUWpjL1k3UHg4TTJFdmRWVUlueWJHYzR5?=
 =?utf-8?B?TGZyVmkzcXBwUzFGOVhEbEpham4yMUZlTFRhN2Q0b0g1d0JtSi9ybk9NdGxr?=
 =?utf-8?B?VjJXY2cxK0wvNldoNFNGL25qZ0VTL1lYRGJCSmRGUGRMaHdmSjdzQ2VRTVBZ?=
 =?utf-8?B?YS9lUE9XdDgwckNteHhneXY4ZjUxeFlDOHY5NkdoZlVpbnF3dGNUd2RyZjdJ?=
 =?utf-8?B?SGFJWVhGOE9SYTNoVGVkQkpjcG1FOEVWQUpuUU02L1dRT2lwSitrTnUvZ2dz?=
 =?utf-8?B?U210bjVGMWRYQ0oyejk3S1JTWTdXR3BzU2FYYUpLVUcvUHdpVEtMTmtEVEUv?=
 =?utf-8?B?WFoyNW40VHdIUzRGVmlpZU04cUt0ZWlPK2lXckxuVDJhU3NsZGRyRnJWcmZG?=
 =?utf-8?B?eGYvKy9naUZGcnE5dUswZXI3enUvU05iejduT3JnL3E0OEFOd0NDeGIyUHFj?=
 =?utf-8?B?b1ovMHY0TGllWmhFUFgvdE8xMkhhZ2Z0S3hmRUJxcEFuZGNnUzNjRWdhRTVH?=
 =?utf-8?B?T3poT2RwVHIyeUg1T0kwdFViRloxaXpoOGUzOTE1dGNwcDlzKzZYcFJFc3NF?=
 =?utf-8?B?YUMrcEpSMXVSTFliS0UwazN2cGk1bHR6UytUaGVVT3ZCZWVDUEVsRzRoc3M0?=
 =?utf-8?B?d2xrRm5nSzduM3BQSlpCbk13K3k4NlFoWm5OZVZmTDJJbFFqZUNQazBuYndT?=
 =?utf-8?B?QjRNR3pmSjVZMC96SzZ2SklsVFg4SWM1VDZQODBuZnlQV3hFbG5RRkZlRDBG?=
 =?utf-8?B?Tm5rMjI2WUMvV2tCZ2NkYVlFWHdPT1VBQThEamJHZmtPaXBSMnNtcGx0V1Vs?=
 =?utf-8?B?NndtM0V1NVh0SmZTWXAxUElEelV1clY5MlMzRTNtOUNzeEh0cjd1cWNTMnlF?=
 =?utf-8?B?bkJtNXcrN0tSS3dWK2IrRm85LzJkN3ExM1oyZ21NRFpiZnZwV3Y3d2I4ME5m?=
 =?utf-8?B?Q0pYVnhmWkdNcFRUaHBwTldZQ1h5c01tMGFEUUh0M2NFQU90ZmJHUHc2N1gz?=
 =?utf-8?Q?qF22ktBwiqBZ8NAvvXWXO2Wnr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d82f6f-06a0-466e-253d-08dc9fdd4e0b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 06:06:42.8328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbS82bhb3FXotYhMwXxn7ben+e1Eo+/mNvgw6PYJ3gH6rMt6PADoUTDTleaVz9obx1y2vKnMMnXioY8WidUy9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7198
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On 2024/7/8 19:39, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> The 'level' field in vtd_iotlb_key is an unsigned integer.
> We don't need to store level as an int in vtd_lookup_iotlb.
> 
> This is not an issue by itself, but using unsigned here seems cleaner.
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 37c21a0aec..be0cb39b5c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -358,7 +358,7 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
>   {
>       struct vtd_iotlb_key key;
>       VTDIOTLBEntry *entry;
> -    int level;
> +    unsigned level;
>   
>       for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
>           key.gfn = vtd_get_iotlb_gfn(addr, level);

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

-- 
Regards,
Yi Liu

