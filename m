Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2C2CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 12:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAp9y-0000BO-Ii; Mon, 20 Oct 2025 08:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAp9Y-0008Jk-5f
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:38:21 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAp9Q-0000iQ-Ih
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 08:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760963893; x=1792499893;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=S6nfwRX9buDsr/HQRFsPqOHKNbRDrGTpQY6/YZvhJ5c=;
 b=drFUW7yBQ7dzH5balc4qiqA1s/MCvH2Ui8wWp6tx2xGesk9ndzdtHJUe
 3ZZUjr1geImyLY2+0S9VAzQRE4WJdbmvuaZ+l1wsvpukeDAEk2ES5NB9j
 sP6/4un+lb4/O5UzEVhp/R+uDgl4ofE6zgD66CogTDBiixvgT0uORChAE
 aIzu5s41S59Sj8rfvu2l/V8msRfmq59GEAwFVEjtZy0PwtM0rtKLA36RK
 6pzDsSMUIz/7pBtpuRRdoHTzVnVcnLJhy7Ybm9Rp50UBfdJHnwB3OUs6X
 saJ8b6HNnLDCve/UiFlDMcY3x0KCGhLnfKUj8cfU7yHVmCCJoBTLgJHJ/ A==;
X-CSE-ConnectionGUID: 3YbRmCmMRACKRnvO8n+Szw==
X-CSE-MsgGUID: qVmYusRbTOOvdijLo09bYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50646629"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="50646629"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:37:53 -0700
X-CSE-ConnectionGUID: /OerXcKRQqqmcLsAtsQ4/A==
X-CSE-MsgGUID: m/i+uFyGTtSiACwH5QUQEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="214281319"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 05:37:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:37:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 05:37:51 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 05:37:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tykQgEuXd8v7EzzEZefYmPXa2s1WfS+d7uaTB6sRpUc6RntCVZWcy5DSHKDdWYtcJgZ54Fv6EpeUqorqTxaoaOfe1SPX0/ssiyAJUBvN49wjs0F0irZdvBW862NFztg73qnGrOnZg9NjQ3Ti6WQ87L1HxHFCOTCURlxdOCSNPol8UrSPHok8Xe+W+2A462Sv55TWNwRBf6AU98DC/tDJPM9bSVGwgXSTnNTWNA0buVpb2CmCVQnwMnzHcFx4Ulp52KrJTojfizRa4KXAl0otB0bO9J8MW9euRuKEMuifjgIQHhIWaSQHsyHtIyxrh1OCRQxlIHOy3ftH4530c6r/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=145jxrt12rpNXc+CZ+ru2fOyJsDOEUP9h3dLAqZiUIg=;
 b=St+wyc5b75sU/2/zpjia04CZV4qKjkrQmqO4g00etuLhqrxFKE+kA5IEaX7MK6MVO792mnchi55MfgofMZ9G9boAZTuWKnxde9RsXWrVr6bX1Hn8GHaM/P+o9IyDui1aOkMfWC0RXOIiPlMGan1EBQBKcTX1+bPCq9+yjmWI7Us28jtIdTsP4rm4Cey/fBOEEuASLg063MIr4M5y3hgwwmFuGkbAn8S2AYRThIh6LsKroo9PjbQd/eFOsWIY+w91fu6Sh55Fg/F/7VPgVZWwVrkajaWOSlBE6bmN4YEZujgnQqYkECfZlwz3vZyJE/f3KLzmWkon2oGtzmBr+gYBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by IA4PR11MB9059.namprd11.prod.outlook.com (2603:10b6:208:560::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 12:37:49 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:37:49 +0000
Message-ID: <6c0f8cd8-543a-4512-827b-57a49cfd53f5@intel.com>
Date: Mon, 20 Oct 2025 20:44:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] intel_iommu: Reset pasid cache when system level
 reset
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <clement.mathieu--drif@eviden.com>
References: <20251017093602.525338-1-zhenzhong.duan@intel.com>
 <20251017093602.525338-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251017093602.525338-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PS2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::36) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|IA4PR11MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bcda484-ecad-4344-98db-08de0fd57ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|42112799006|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDFEN1VpYVQ5NzFjUkxwd1BUWjJMZkJEamZwS2kyL3hKSkZpcWJnZzZBRFBt?=
 =?utf-8?B?dU0vSkNCcHNWbXpQMCsySHhPMnlsOU1WYzViWEZDL3lEVTQ5Mlk3YWl0cURa?=
 =?utf-8?B?QkFXTW9FMzRlYTIxT0JZTFRMVE50dlJwZ0ladU1pbnlrREVZNzJhT0lEOXc4?=
 =?utf-8?B?RTVNbVRsOFp1YlVGbkt2OGJFdk9tNjl3bS95aXRHdXBST3FuVkpJTEF0RmdP?=
 =?utf-8?B?cmhKZEtsNjk3WUljVHgvcmhqclIvMmVRL0NxRWViU3djZ3RpWkJFaVVDdnBh?=
 =?utf-8?B?Rmw3RlVIYk9ManFtNEw4dzkyUVJhMTZlUThZY2NSaHRHOGFTOVM4MlhWNUJI?=
 =?utf-8?B?QUNsWUZpMldjMnhwZTNxSXE4dXZSYnlnM0NmUXoxUHh1cEc3Q01xc09jOUJz?=
 =?utf-8?B?T2EvZUlyb1VXMzZNM0lhM3lKdllCY3hHTUptVGtJOW1sRU5vM2ZlRHVsTXk0?=
 =?utf-8?B?QmlRb2RnZmZ0cGZkcndCT3Z4NU9lOHdudE85ODV2cDU2UVI5M1k1elFMSW40?=
 =?utf-8?B?SERlVnNkRUNmNjVqd2IxM0pXNGZJMnErakZFYm1KcXBEVEMvQllHQnNjZ0JX?=
 =?utf-8?B?SGRGOVpFZE5wN1NjVFdpazkrNlNqMFJlaitLYU5UN2ZoZ1U3aFlvQTZSVEpG?=
 =?utf-8?B?TmpiVXRIdG9MeVhJaW5lR1p5MUNLd1laOFVXVWs2R0pLTzJUaWFkTHpXemc1?=
 =?utf-8?B?ODRjUUF6eDJraTNnNFdQaHNjZzJBWVZQVm9GODdVeVBHa1JIUlFZWENMcnVR?=
 =?utf-8?B?d2VpUG1OdEVLOEZSaFdaVm9oaGhMVjV4dXBrWjRBL2w4VVAvYUxCY2RKNDNT?=
 =?utf-8?B?SEJTRjRvbjlyL0o5Z2FHMkNmUml5enFhZWV0dXdkcDJsZ29UcFBTNStwbDlU?=
 =?utf-8?B?OVU2RkMvbzVQQi94WUhJYlJlWVVHTG1ucWIwYUpTWjQzZmJGdUxVRFRDS1JE?=
 =?utf-8?B?MUpFUEp4ZDlUOUkzUTVkRUl0Q1JrdkdkOHc0SFRRK0JKVUpzZTZibWhGS1d4?=
 =?utf-8?B?VFErRWVHMk1OVllMNGtkNjRWZmZkdDRmZjErV0JrRGRua3puRWFUdCtFS1VZ?=
 =?utf-8?B?S2FZcU5Mb3c4eDRhMjAxQlovaXc3S0E5L25SZlFvWDg0UGJPV3NEYy9PeXVI?=
 =?utf-8?B?eXZpd0EvN3lWeWV2T1R0cWpmUTBNRlNkN2V2NDR3YmVSS0JhR0Zib0YwMHJy?=
 =?utf-8?B?M1pXTU9LN055bGRBSFNhV1ZiQWRkdWlxT1p3Vm8vVVdkTitsVHpRS0FZTTVx?=
 =?utf-8?B?RTBKMWNuQ3VsVk1UdldhOTJWM1ZQYnliQzFHd2JDUHRVb2NQc3d4UFlwaEhM?=
 =?utf-8?B?RnFxUEM5dzQwUWpNZDE2dDlqcHp4YWwyUk9oY1JaNnFSRXV5MUhWRnJYWG93?=
 =?utf-8?B?WTlYdVVpOTNNMWcwZTVyaXdWNVpzQ2VydHVYT3NLTkxzVzA3dHNBYzBHTFFV?=
 =?utf-8?B?aFJJYVVPanlHcmp1Q0c2OHlHQTN1YTU4RE5Ic2pRT0h2bnFQZGxNMGZ4OEN6?=
 =?utf-8?B?ZGkxYytYeTJrZ2cyb2dEYlVpb1p1ejF1ZXl3ZmYxaHo2VEhoM0J4V3ZHanBt?=
 =?utf-8?B?VWRvVVppdFdVYjVKcVJra2huYktvK21tT1I4bHd2SG10WTJWSEJlb2ZhWmhW?=
 =?utf-8?B?SFpPVXdKd25SL01YeHI4TUpCVnBXMXZOSzNWbG10WmdOTnFINTFhaGxkTFVR?=
 =?utf-8?B?b2JXUkhnVlRCSVlieGlLQnJtUC9WeU9zMmJLN3FwVzNOZXN3amJMcXZBWGht?=
 =?utf-8?B?SGFjbHBlTDVVVmpsM0tvZmg3SktUbWZZOWExblRQenhYR0lhV3g2bURVNjdQ?=
 =?utf-8?B?ZVl4VjJHby85UTF3Q0J0bHhWSzZ5V0ZaU1d5UTE4K3AydUt1UTdtNmQ3SUVo?=
 =?utf-8?B?VUViTDlDOVEzSFBLMnpBS3lEQkVpTVZTdnI0QWU1Q0tzd25CRmVudXRBa2wr?=
 =?utf-8?Q?q6i7/DdwxNHUzCQIVsE0oOqv29tn1SY9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rkd1S3hIa3d3R1htUkMwMlFkcFg4SGIrS0hkd0FRY2drdndvdENUN0Z1Nk9L?=
 =?utf-8?B?MldwM2cwQXBLRE1IWUJyckovTHRLU1BON2FneGJOWGtnSm5hQldQV1drYkV2?=
 =?utf-8?B?YUZ1ZzFKMHJNRDZNS1JCTmcreUtpR1RoOWR0aTRGR3lmUWNEcnJ3b1NsSkE1?=
 =?utf-8?B?RnBzeTQ1bVZKWmU1VFBrUTJMRmowVWFwM2NLZUpvNGJFbUhuUHRyYTZuRE15?=
 =?utf-8?B?cnZ1ZmZySHFUMisxVlRMV2xmVkFKK3hpdXlCRW5BTENVOSs5RTdtMzUrK3ZK?=
 =?utf-8?B?SG94cXgvRHpiS2ZmSzVCNE1MemhFS1I1cjg4NE9SVkZHa21IYVFTZWlpeUxQ?=
 =?utf-8?B?d1RHRUZySTJ0WitLeHAxU1g4QU9VTmd3bXllUzVPdUtDTlI5RkhOM2l0RTRX?=
 =?utf-8?B?WDlKdU1PS1VpdU83OXIrbUx0U1FyZ3lZWmpnTDcxL1ZzZFc0VVB2TVhBajRn?=
 =?utf-8?B?Q1pmdHZqREFQTG5XTWtUbXRDVldMWDZpYVNXS3JuTjhJVXRvOTVWTUR0Y2w5?=
 =?utf-8?B?ekNDaGFiN3V5bEFmWnVWYjQ0SzNMdWhNY1hJS0QxWkplM3hYaDFIRVFhTVNh?=
 =?utf-8?B?Y0dYakJqd096emgyVGs2dkZwai8wRUlFV3FpOUdMMGNZd2czTFI3dHZrU3dB?=
 =?utf-8?B?WjRWcDBLWEdlR3kyaGZaRDMydDRuQXZFakFCRzVKQVZKSlhMc1VtbkVPenFL?=
 =?utf-8?B?cnZaQnRIV1FzampWbWloR2Z1MzNlQjlBMFJrWTNpQ3RocGJma3JhY3RDdzBx?=
 =?utf-8?B?cFV3Wk85N0JPWkFaQ3RjSUxPYXczbDd1aGpYd2NsL1d5NG5TbmlYQjlNekhS?=
 =?utf-8?B?ZGVwMEpnUXZvY2RVdkpIZDBhNGNkaVZzU2NZd1kyaTFLRXdkdkRpY0pFZUFa?=
 =?utf-8?B?T0pzTjRTeXFDalR5R1Eyekl1OUROQzBpNUF6d2ZaTlNxQ2Jra3VjK3VwRi9J?=
 =?utf-8?B?OUVNaVMzUzNqWWVzUWlRY2hkNTU1aVBWT0cvclBKKy80M2llQzdnV3pRK08y?=
 =?utf-8?B?MXNOR3NqWHVOaHdLdU9GVEViVHZHMmZ3ZzFVUkZad2dxczRXdjlaeTVRQUZl?=
 =?utf-8?B?dHRneWRPYVNzODR5M0xrZndaQXZiemJray9CZlFvcDU3Z09FNU9pZlFEMGxv?=
 =?utf-8?B?elBJUHk5YmdMMzJxb0JTalV5TkRoeFhBV05MYzZVYUdMSlNUWC8xSjcrdHVP?=
 =?utf-8?B?aytUL2lKZDkvWFBGT1VYZGtwaHphWUwwc3FudGJNL0pkVDBEN0QvUXVnQzFP?=
 =?utf-8?B?aVhvTWpYc014bnNKa3FBSUoyelo4SmxTYzEycUhHT1NiRURjWE1iYml0T29s?=
 =?utf-8?B?T3RMWFd1aEZhS01kenZZYzh3L2JsZmtMVHdQeGUwRlR6OWZHYlduZnNGTVky?=
 =?utf-8?B?WGNTUzUrcGxMd1hYR1E1Uk41dFYxS3M4cU15akp2ZS9LL3ZsT1FZKzJEM3pY?=
 =?utf-8?B?VzZoTndWWWdkYlFSTWZnTlUrc05kQldYNUo4NEhhUmpHMDF6U2o5MEZudG1y?=
 =?utf-8?B?Q1FEcTFYMjhnV2lRWVdCMW4xV0h5dFhaZ3dmb2pML0ppYXlJaWttRlFJWmNv?=
 =?utf-8?B?ZnlZaUJnc0E0dzBHaDhOVHR4b0RRWmVWbHhKK1dLL1NQam9oWm5QOVJSVnZo?=
 =?utf-8?B?U0M3OGprRHJkNGJjZkNwS0tiaS9UVVArV3JFY1pzd3lSYUh3VlhaNk5JUE9V?=
 =?utf-8?B?UVFnMTYrQVJuUmpNSGVNTzFKMFJjb2ZrV3QzdjdLT253U1g3ZDJXQVIzTzBm?=
 =?utf-8?B?OUFUcFl1Vnh0VE9FSldCZnJsVXRUK3A4ZGhQMkpKN1VwREhUcDg5QUJXWVlx?=
 =?utf-8?B?YlB2dWV3azRYaUtTdE5zd2xiQ2VwWDdxc3VlSmw4WVhkMVRyay9lMytQZWI0?=
 =?utf-8?B?V2ppdGhtaEVGOGw3cEhDVzMyVG5kVXB3NzRzMGNGN3VjdmdqMVk2Rkl6TWxD?=
 =?utf-8?B?NDg1LzBVWkhQcG1MQllsQmZSYUZmSHpyQUpRM0paVXAzek8rb3NSdDFkQ0Fk?=
 =?utf-8?B?RmJMdTdyRW4vTjZCWC8vNzkyZzc5L3phZzQ2d1BDRmpTMkFSOXZXTFdGeC9q?=
 =?utf-8?B?SXFobFVQSzNRdGFVdGRDUC9TN3hpVzY4dGNUWVJrTEJtbllndkFoWGhaK2lm?=
 =?utf-8?Q?A4wX5Wiyfm+b7VnPOTCpru6wz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcda484-ecad-4344-98db-08de0fd57ab9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:37:49.6674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQS21divPOQ2B82OZ3+EsF4tjna8RKK05FX47VBQwrjoT/5bNSWz/XUzmO1EMK/WtK9C1NZK3esVjLxHR42X3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9059
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/10/17 17:36, Zhenzhong Duan wrote:
> Reset pasid cache when system level reset. Currently we don't have any
> device supporting PASID yet. So all are PASID_0, its vtd_as is allocated
> by PCI system and never removed, just mark pasid cache invalid.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 16 ++++++++++++++++
>   hw/i386/trace-events  |  1 +
>   2 files changed, 17 insertions(+)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index c47f13b659..07bc0a749c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -87,6 +87,21 @@ struct vtd_iotlb_key {
>   static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>   static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
>   
> +static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
> +{
> +    VTDAddressSpace *vtd_as;
> +    GHashTableIter as_it;
> +
> +    trace_vtd_pasid_cache_reset();
> +
> +    g_hash_table_iter_init(&as_it, s->vtd_address_spaces);
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_as)) {
> +        VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +        pc_entry->valid = false;
> +    }
> +}
> +
> +
>   static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
>                               uint64_t wmask, uint64_t w1cmask)
>   {
> @@ -381,6 +396,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
>       vtd_iommu_lock(s);
>       vtd_reset_iotlb_locked(s);
>       vtd_reset_context_cache_locked(s);
> +    vtd_pasid_cache_reset_locked(s);
>       vtd_iommu_unlock(s);
>   }
>   
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 298addb24d..b704f4f90c 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -24,6 +24,7 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
>   vtd_inv_qi_tail(uint16_t head) "write tail %d"
>   vtd_inv_qi_fetch(void) ""
>   vtd_context_cache_reset(void) ""
> +vtd_pasid_cache_reset(void) ""
>   vtd_inv_desc_pasid_cache_gsi(void) ""
>   vtd_inv_desc_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
>   vtd_inv_desc_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32

