Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB5DC71134
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 06:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPF65-0003fo-7h; Wed, 11 Jun 2025 02:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uPF62-0003fO-3k
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:38:02 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uPF5z-0001qL-Qj
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 02:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749623880; x=1781159880;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gfz9ryWcfFOlgHilbsX7lQf0brjOLA1NyTEhVvZblUY=;
 b=ikCiYfeWqb8lAm9kfi3EmOg38BRBn9oQXirikQeW7UzHdaSEfPlkewMw
 bVEm54zZ+Y7sZLoFrTetSUzCsWke66PTfEy+/K/sFd3L4g45ifa65rbsu
 WJufXRT7/QbQ3cKgxVw+Z+4S1N1GQ1nIgvYEh3VpoEGLXnCrD0WLPLXIp
 JG1IC5u/CPU5cbNe3L3Iz3IwQ6fGalBUSab1ndIRfGo13FDB+DPyxfjIO
 Vfn+v2CrIdKGfnJmhg369cw2xMsJcvD3nsE3C/mst+WJlpOr9Dt+YSVhc
 edI0V78TNqaazbcgSdNv282BYYzpsebonsOgLREhdV9GcQpZLD3kDui95 g==;
X-CSE-ConnectionGUID: uwKVRsqLQouxpZAsX+fC6A==
X-CSE-MsgGUID: NerdDgSmQKGpbUrLN5JDUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51670493"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="51670493"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 23:37:48 -0700
X-CSE-ConnectionGUID: Ylg51rvPSnWW9saSsGX1Qg==
X-CSE-MsgGUID: 2GAFbCqoS3udB0FKgT19LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; d="scan'208";a="146972755"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 23:37:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 23:37:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 10 Jun 2025 23:37:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.83)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 10 Jun 2025 23:37:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZiNPBhdbLbHkBZheHWLO6oCN631WvrUXhSsdPnIXgDfsgqiNBPeS7KqTw4Myyz9RhtWKn2E8oDHKxTEiONTGPzrnUGWxFgGBzaK65w0rrISJya8lrT51H5Bhw2kWPeoaEDEMWt2wDoOj14IJhOsgB8M1SpW5OSdUGBlFxXtuwd0oX0njxnfOA+/mTKMxJ8/G3n5swbC3ggAoimO/9TaPecxFDYSC0OfjM0gLOu2d5PrgAS6kMD/4bmd1hiq71yOLcXBegu8AhhYGFh/6csexuxS05Mb9vkTYjSIwMwiurpGRv4YAxkgbLxGoMA9aW9UAb4Ht9fFntF3QT3YFsG7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnIxaU/CyqSYi8rCrk+UftDENdUKngst4UE+jjEmB04=;
 b=ei2jBI6Fd7kZg2nImtdvLSkrWD7r9xsKTxxeJ1/WG6J1X85poGZTDwyIp1i4GGIhz9p9/aiwpOeZfBcCWu+0uF0iE68rAvL5yhvaijxKolqGuWXD40tlwc0zrNTvUSxWJ3kkx8l/3D+Gkm3XW7KhsxurVNpaAAiEoBvqU+N2f4+vjd/mF1K1ZrSSdINXgkVSobfE8Kx9Io8m4HOM9qixuw5AuuMhIQjh5WnokqirrsOY3osAV3gCBYgFCcu3BIJVk5H6riTg9NJ7/HnY0utiR4yTw78RkMMMLIiZWfUeYyfpoy0LBJE2do/fXfLB6ORfh5Euwak/QpcS3huiQ4qNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB7145.namprd11.prod.outlook.com (2603:10b6:510:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 06:37:44 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 06:37:44 +0000
Message-ID: <d73507da-b8bb-489d-9255-d8ab7dcb5ff9@intel.com>
Date: Wed, 11 Jun 2025 14:43:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Fix instance_size of VFIO_PCI_BASE
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <john.levon@nutanix.com>, <chao.p.peng@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20250611024228.423666-1-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250611024228.423666-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0057.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3d::11) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 12152310-1c81-483e-6aaa-08dda8b2789d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHVFbklVT2dSTHFQWU8rMk9rU1M4bzZ1ZnlIZDNHUXVOYXluc3hxOTVrZk8x?=
 =?utf-8?B?bmVRVC83R1BseWJaVUtUeHF0S1RYaHpmc016MzBIU1MrREFFQnBLK2lDZ2Rw?=
 =?utf-8?B?R2hxR3dETkNzZTdJODl3aTJOVW8xcTJrT2JHZ2J1M3NSRElKaXZFdkZRUGRk?=
 =?utf-8?B?aXN3TXFLRG5QWFR2Yzh2SDlYSlRsTnN2NUM3d1JlUnk4cUJhdmdERE9qUGt1?=
 =?utf-8?B?SFlLOGFOOWVsSzdna2tESndVVlhpemVHWThvVkJadVhjMG8wT3dLR3RlQitQ?=
 =?utf-8?B?bnpzOTJDcjZSSURQQitGZExxdDl5RFFDVkNZM1ZuajRZTTZoZjl4WGdJeGhr?=
 =?utf-8?B?d0pXL3hVaGhoQ1k2b0FnRHlwNTNzRUwxa2VPZUxLMlQ1Zk9CbDRyeFRWM2tU?=
 =?utf-8?B?M0pQcmVyVGNlSUh1a0piK21ESWtTSjlzTWFJL2hONDUydlNFKzZKQ0hVQW1D?=
 =?utf-8?B?T0dIR2hmN2JFdXZwZjhIM0VlZ2hoSERleTg4UWR0bnFWWTViS2VjNXpoV2w1?=
 =?utf-8?B?MHJSVmJBTHBvZFpxSE5YSDF1WGJ5N2s0WU5IWG1Bc1o1TmVHMXhxZVIrRER4?=
 =?utf-8?B?am5rUXRtRSsyVm90VVd0ZWY4b29HYjV3V2ZWSFNJUW5WNkEySHJyQ24zNmJI?=
 =?utf-8?B?OHZSd3FXKy9VdnA5cUxZWHVyZUVlZENmUElpSzVIVUpGTVJwWUtGOXd2ZjZ1?=
 =?utf-8?B?TkxaU0o3UHduZlBoZ1RRQ0NDSnFEYm9makY3WExqZ0hLZEFwc2pkYlR4Nnpo?=
 =?utf-8?B?Smh3VXYydE9ReDRyc1Y1WUFjYWlEUVJlTVdGQXZLbTAwV0N5TldZOElKdk5o?=
 =?utf-8?B?MnZqalVsbzV0eEVYc3lqdUJtd0llc0NtNnQwSzAzQzBwMGtqMFUrTXltcHlX?=
 =?utf-8?B?QWppOVhUeVI5NEwreHFaQTNDdkx3bXFheDRGWG9kR3QxUHZYY3RWTHFQRlNW?=
 =?utf-8?B?RDlLQXlOT0RwZ0xLQlhqbHJKdkxNVTlHSUw0OEJ3d1BPaW1PaEprRkJ1Yzli?=
 =?utf-8?B?VE1qLy8wa3dtd3JoSHBpVVRBcEdudTlHTFA4Ujg3NTdnWHRETExZQVhnY2E0?=
 =?utf-8?B?cnhpaEJwYnAxaHpKV1RJUTMwWDFPbEJWSDY2Vk95ejQ4dlUrd0huSVA3bGpv?=
 =?utf-8?B?MGhGZ2pyT1dGa3UwZU9yanJSaXFUK0VKbmZvQlBZajJLNDliM3dJUHpYRHF6?=
 =?utf-8?B?UlJSRmtPdlVpaWJnV2d3ZFRCNStXK1F0RG4rb09FZmhQRUo2WjFWcDRWTURi?=
 =?utf-8?B?RUl6RWJpSG9sdEFUeEhNTDY0Nzk3Tm1NM3RFbGpGTFB5Q1RnMm5XajZPV1V2?=
 =?utf-8?B?STNBV21XeG9yakpudXJpWUt4UjRDYUx1RC9vTk9IQlRvMkNkKyszSHczbW9j?=
 =?utf-8?B?S0J5QUVlVUFPWElNRVJRQWhzelFsdHZoMUdyb1NqTDlhQkZ4dGtqbVA3TUEz?=
 =?utf-8?B?NWVEVXNFdGp3cG0yY0RuQ1lYRFZoQmtZSXg5bmxNNFFNY0J1YnVQQnBUQ3g0?=
 =?utf-8?B?blhOOXlCdndqQ2dpb1BjNThFZUdXL0hzMzM0L01xQ2RJY2xyNEsxczFTSWIx?=
 =?utf-8?B?cmR3c0ZOWkoxTHVqNEc2TlMxVFlvMzhjbUk4N3dMd3VrcWhvMFNqRzJ0dUpN?=
 =?utf-8?B?RVAwZGcxRXpkaEhXcER4R1grMnNZZzkzRUc1MXhya3U1dzlWU1NFaElaMjR4?=
 =?utf-8?B?ZFZaZFcvcFRIR3ZCZDU0TkpsbkNhd1c1WkM0ci9EcENvU2FnMTcydUpaTUNX?=
 =?utf-8?B?SkE0UzZDcm1oUmJIZndQNVBZV3NhWlJjbWh6T2hZVk5FTWRsUUZDaHFra3c2?=
 =?utf-8?B?SFRtY2FuQ0JVcUJWU3pOaUYxTktKclE4S1llNm5TUEEyTDBGd2NVRmthdS93?=
 =?utf-8?B?UE5BcmdaekdMNmxFUXZUWlBGaTh5VkhnZjVlb1dybnhwSWx1dEM1TDN5VDc0?=
 =?utf-8?Q?WepFWsM749M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0twS3ZRcFIxK0l6RmY0N0pITUd2b3h6V3NRL1EyekNoTU1SNGJDeUJ3ZkR4?=
 =?utf-8?B?elJXNXJzZkFNVVNLYlZiYlF6Y0wzZm9oUFcwTXRuMmErQVRFNEhrUGk5MFgz?=
 =?utf-8?B?V1NCMTRGcGx4dXRjZU5pbXlYMXMzTTBYS21YMGNNcGZ0RGZrN3ByL0RWcjI1?=
 =?utf-8?B?L0o4U3RncGNzMzFjcURBVko0bmQyRjRBTW1VWEZ1U0Y5RmM2MW1YRkpManNn?=
 =?utf-8?B?cStlTFowYmVFYXprVGV6ZTcvNlpEQXd4M1BnQllySi91MFlINnFnUi81NmFy?=
 =?utf-8?B?ZkNCSjZLa05ncko2S0RGczJPanNVdVVNZ0M4anZUU25DeFF6ekZ5Ly9OeHcx?=
 =?utf-8?B?N3JlcGdmUzJzT21DYjBqelRZbkhpQjh1eEZJOCt4WXVET1Z0Qk5ZMjhXQVl2?=
 =?utf-8?B?SUxKWmlCSWpkYXR6bTdNV2Yyb3pLdUdmWlpKbVZxUFFBUjR6cVhmMXR1aUhG?=
 =?utf-8?B?K1NtNzBudVh5amx6ZXBXOGxTaEVnV2RzOGt2VmdqMTNwU1ZJNFBhOTFNVFZF?=
 =?utf-8?B?USsvdTIwb3U5Rng0aFpkd2syRllseFdPRUxnblVJM1FQeWFxN1RESGpwTjBP?=
 =?utf-8?B?S2ppbkNTdUloV3A5TWVBNEVCVEFLWVYyRDlrbmkyL3NrMVRkdGdiWHBUSW5y?=
 =?utf-8?B?VFpOWU42ZFA1YmdCdUVHT2ZkWFNLQkp4UUY1RWQ3YStObisxVERJM0I2MkJl?=
 =?utf-8?B?SEVraEUzNDE5ZmYyV0VTMlBTZzllTTR3K1ZVQkFzb2QvZmZ3aEtCZ2NwMnZj?=
 =?utf-8?B?SkFxei85WXF3WWptM21vZXNrVFBRb1J6SjRsR3YvdmlQMjBYMElQVXBIbFVl?=
 =?utf-8?B?aE5KV0Z6aVRmbUFkRWtJTkI1TWtBOTMxakNDTHJoWVBveUJsc2RQUzJNdkQv?=
 =?utf-8?B?UlVLVkl4R1RNLzcyaEt5MUNJNFM0NmFIR3A0aEc0OWtXRCtRajFxRzlsbFJC?=
 =?utf-8?B?bUthV1lDNU5rOXJ3a1BwUHhqODRpN0x6WjRZN3g3ZGxiZ295WkFra2I3UFZi?=
 =?utf-8?B?cDNwR0hNL3N5Z2x4Tmw2QUNHc1d1RjAyNkdlOVNnREcvUDNrZzBHUEFxYXdm?=
 =?utf-8?B?Q0h1M3p5TWNJTjkvQ0xDVUZ6WFpuS3hrdjdYUTZZc1BTYjFrMXU3a0U5ZEFB?=
 =?utf-8?B?R1FlaUFmeVk2dC8zcUtnRE1VdUY2L1pqbVU4ZFhYN1I4cjM4YmwvamFUMU9r?=
 =?utf-8?B?VldIalpXbVhzR1g3R1Fxc1JZSkFaaFNmWTVadHppTStCY08zWVdaYTE1OStp?=
 =?utf-8?B?OExxRDJ0QWhQOEEwNEZYeWs1c2RIN08rcXFudEMyL1lMOEpnMW5rWE5yS081?=
 =?utf-8?B?Q2dOK1drS2ZXSFEzTmNldVdwSzczbE1kOEROaUtEaUxRcDNZKzFwQkYyRjhZ?=
 =?utf-8?B?akZ2UzJZSU9Mdk91aFV3ZUUzZ3Z0eHh2ZDlsdU9FbmFTVUY1RFJPWG14VUpS?=
 =?utf-8?B?c3RBNFJ5cGJVZ2JmU0hFa3FvUXoxZ0tZZUNRUGtrbUFoa2tNZEhUYmFQZTV2?=
 =?utf-8?B?clZtaTZMRFlwY3B0c3BLU2Z4WlhRaVlBM2t5ZjdZYU54NWp1dm1BdkpBMDRL?=
 =?utf-8?B?VFI2TGJ2NFdXNkRvSjE4U0xZT2l5VUlSK0NmdVhjS0M0TkVtbWptRm5Rcjhi?=
 =?utf-8?B?V1ZqUlBOb0xqSTBkbVlDNFd4WHIxc2tzTk1TRk9KTXN3b0dMcmJXMHJPeG1z?=
 =?utf-8?B?QmZ3bnhSY2RhMG1XQ0xJOHIzdFpHaCs3c2MyYXZRdTM2aUQzelcwSGtWZ0Jz?=
 =?utf-8?B?R1dUNTVURFlWdTBGWFR5UmRQU09SK2FydWZjNDBVL00vRnNRN054SWk2bXVP?=
 =?utf-8?B?b0V3d01tWlJ4aS9GYnd2NU1reDQ2dnN5OGZqb2JsbHQ0eG1ibm9LWkR2czRx?=
 =?utf-8?B?c1gzZkN1a1hYakNsYkxndGI5T1piREoya29Gc0VkaDlDeDhjR3lXdWd3RVUr?=
 =?utf-8?B?Y0VXY01oY3hFOFdiWmlQK04xYVBsenhsQ2E5NERqb0lqSU41S3FRVzUrZjdj?=
 =?utf-8?B?Q1QvREYwNVk5NVpBWXNheGxGQUdWeVR3VC9RRU1GMmpmcXh3dzl0WElLbFl4?=
 =?utf-8?B?Vm1HT2k3UE9jK2hUaWRPN25yM2xSQzE5ekREWDZxc0xFSmhWSVFqVTFmRzU3?=
 =?utf-8?Q?rb1e5hqOgn3EfvnVFEGQUJZsH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 12152310-1c81-483e-6aaa-08dda8b2789d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 06:37:44.0647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEsnUl3OrgP8qCGJvwhNVevbHQiw92VNnIsT4lCpP4LMSZnYCFvAcPh/X/ttU60YZK3p1grxliKlZQn7m8zcZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7145
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17; envelope-from=yi.l.liu@intel.com;
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

On 2025/6/11 10:42, Zhenzhong Duan wrote:
> Currently the final instance_size of VFIO_PCI_BASE is sizeof(PCIDevice).

For the people who has a doubt how the size is sizeof(PCIDevice). :)

   * @instance_size: The size of the object (derivative of #Object).  If
   *   @instance_size is 0, then the size of the object will be the size of the
   *   parent object.


> It should be sizeof(VFIOPCIDevice), VFIO_PCI uses same structure as
> base class VFIO_PCI_BASE, so no need to set its instance_size explicitly.
> 
> This isn't catastrophic only because VFIO_PCI_BASE is an abstract class.
> 
> Fixes: d4e392d0a99b ("vfio: add vfio-pci-base class")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/pci.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 92562898e4..03f52a9b8f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3478,7 +3478,7 @@ static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
>   static const TypeInfo vfio_pci_base_dev_info = {
>       .name = TYPE_VFIO_PCI_BASE,
>       .parent = TYPE_PCI_DEVICE,
> -    .instance_size = 0,
> +    .instance_size = sizeof(VFIOPCIDevice),
>       .abstract = true,
>       .class_init = vfio_pci_base_dev_class_init,
>       .interfaces = (const InterfaceInfo[]) {
> @@ -3701,7 +3701,6 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
>   static const TypeInfo vfio_pci_dev_info = {
>       .name = TYPE_VFIO_PCI,
>       .parent = TYPE_VFIO_PCI_BASE,
> -    .instance_size = sizeof(VFIOPCIDevice),
>       .class_init = vfio_pci_dev_class_init,
>       .instance_init = vfio_instance_init,
>       .instance_finalize = vfio_instance_finalize,

LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

-- 
Regards,
Yi Liu

