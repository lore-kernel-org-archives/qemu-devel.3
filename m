Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B772FC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGM4-00063y-Ss; Tue, 23 Jul 2024 10:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sWGM1-0005hy-Lv
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:19:02 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sWGLw-0007fw-E8
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721744337; x=1753280337;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mPNNaYku8sYNj436cy5flo16FDLZp1hyLo0SIuyyu+k=;
 b=lXAsmdNvKKzvA9jjIH2nRaTue7bPVeEfraYGlovWQv7JQ8xy6mPARZJg
 8XnBfZq9c/zkOqinvCHwyTPeNXdS72gipp/Ee/w6DdWwc2ULwqaJXDR8r
 HXC2VAEu4RR+IMTl2kSoTBR6pKQRT/9vSIakJmXBt7qADpuxSorMen7oI
 qToxpMuJT67JO6MkLWX7JvHCpM8rS3j64SAwQIQ0IJypmpqcSvwks/AP8
 CFLZEfRs3dUyB95iFrKclcErG7viclInOIX0rFzHPpFgcFsIyCvASr0zk
 o0JlajYftMmi2Vmbf+93EB+tNK+7kyk0SZKm/gkcZguCTJTlKkAWdLkp3 Q==;
X-CSE-ConnectionGUID: Pl5zlp3fTzuRBiG2Q51mIQ==
X-CSE-MsgGUID: 7Vf9KyUMSx+xYdMKljEEew==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19182425"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="19182425"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 07:18:53 -0700
X-CSE-ConnectionGUID: OoqaLmCVR9+qyRXV5TTs9Q==
X-CSE-MsgGUID: kNZ96B1SSomFbHwzc/eMHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; d="scan'208";a="57371947"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jul 2024 07:18:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 23 Jul 2024 07:18:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 23 Jul 2024 07:18:52 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 23 Jul 2024 07:18:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gd9ycTCiRzE3sMyW7Y41bQnrX/6Lh8lWm7PmUQ1MjTFgVHM13I65TNRIxgMpaVmuaKoFIHjHCWn8gqwJoeH70/+TQnyTnClsOzlxwuZ4UN8DWKwl2vfcAUw/BQstkPpcy6MUF9BHdoa2Tcr29piu8pZmV1WcK9fhp1fNllw9naBhksRHCjJ4kg2TMckSsBhMPe5bLHR9V6rHvrzXH3t38HR6/iGTsYeHsLibceWaqhlwLOmJEjYQ3CHeC+h/lgxi82BNlc49oBiTxcWw794i9V8jnte26HKzyX23psnnYPiLoa8wIfZJQoFEU5grkHGfkbjcZSycjPx5QEc/DKBKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jo13xYBHF2wwag5U+pdayXhToMIC1wKUmJ7XJdIGyFQ=;
 b=E02hnl7pt9wLUFmheCl08RMxzloU0mWG7jL15ZkUAh5JphjxZTix1m5EaCJ7ZrDkmIFTka0LYhoWNVsBFyQN3HmFP70pw6JQ6VZAAlZ3teZLzDUCoc7xNu5cW3Tt1d7KzRfhX0xxgDRcYLDR6eRgJ1GvbNmP5V5sTssA8qwEhnUt/PdU2VwNhbk9qIDachMO4kDvvfVniHP8KeT9oFGmup1L78Q6Oy828etaEfqVp6I6aJm6G9nT/l7gXDdjuv6eGKdFE+pQEh3+0WcxLn51qztskTZw8GoqLNgXjSXvrPcV/tOaBCTqpDK+Korp9k/v16c+0uX4KVcTnviLS6xaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB7018.namprd11.prod.outlook.com (2603:10b6:806:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 14:18:48 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 14:18:48 +0000
Message-ID: <de5a8b4d-7a3f-4957-b76d-9bb11d8d3de1@intel.com>
Date: Tue, 23 Jul 2024 22:23:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] hw/iommufd: IOMMUFD Dirty Tracking
To: Joao Martins <joao.m.martins@oracle.com>, <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, "Avihai
 Horon" <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240722211326.70162-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: 7436ae56-69bb-41b7-91dc-08dcab225e93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M3ZDS2dkdlhFNEhDdUxpcDdrZ0pNcHVhQzF0cXBYckhiMHpvVmVOODhnaE5J?=
 =?utf-8?B?N1FsbVVLTzlwb0RrSmt0cllkYXIvR3FYQ3g2M0h5WTJXRjZveTBCd0RmbEY3?=
 =?utf-8?B?bWI4TThrdUFWYlVzd2lHMHRRUGxRRk55K2Z0VUNtdXlVdk9GVmVLcjFZQXU3?=
 =?utf-8?B?QWE4cnc4WlFUNmVMczhxaGhZVmF5UnJoYnNiTGRuQy9IKzZ6OVVwU0VOVmI0?=
 =?utf-8?B?ZEQ5dUxRTXlIRnY2RkV1cTZBdll6L1VKWXdOc2FUUDU4UzF2YWFpZ0hvcWdZ?=
 =?utf-8?B?K3ZicUZZSWNoZHpPWjUreW11SHFhMXY1Tk9GMEZRdlpYLy8yeXRkMXljYndK?=
 =?utf-8?B?VGRTT0kyUlNYYTFKOEh4b3NOWDF5aTJCNDRrNmo0UDk4Qmx0T0cxM3QyRmt4?=
 =?utf-8?B?VmtIYXFZM2RuK2ZaaGFHZnI4ZisrOXQ3cTdPSEloZGRhTzYwOVhPRlJWdnlv?=
 =?utf-8?B?ZW5ORUpLMDVFZmRaR0lVeEkySXE3WU8wVXNjZFhBSDc1SGtnRExuQU1JN291?=
 =?utf-8?B?N0NuR1kyd1pZRGp3Qkk5RndtZDhxRGc3dFJyK3gvaHR4YXp5WUlLZ0FCa3dh?=
 =?utf-8?B?RWRxVzc2NXRLcFpVajdLU1lxSEN1QW9nKzFwRllyU1N2amJ0Y2l1ZEhlV2ox?=
 =?utf-8?B?bEMzWVg5N3o4THVPaTg0Z2NiOWozcEkvazg0VFlQWTJXbkI0TDRiU1FMVlR0?=
 =?utf-8?B?SWhSWktVd0doUFZSRThIRFQ3K2JPeUQzL2Q2bE1LU3JuZWh2NFhpUktrRU1s?=
 =?utf-8?B?VzdCcm9sRVIrM0pmOHBPdlNycFpWbkxVZnVtQ3pmL01rb21uaDB6M3p0dUpn?=
 =?utf-8?B?T2JDVGFxOGNjZnhMWERGRWUxeThtOHZzQUo1RXJpdCt1MTRPTlltV0pxbStw?=
 =?utf-8?B?UGY3SjhqOUNnWmh2WmNOY0hOTUxrWFZ4a0owaC9Wa0JBZURENzJ5NzhSTDVo?=
 =?utf-8?B?aWNNNEZWampsRVpDbGlPYXZDRU41dktWbFF2MDFiVExsYmM4WUxNaHJ3Q3gy?=
 =?utf-8?B?RDBmc1IrV0VmbkdxUlAvT1pSSmJNN3hsRi81T3hhdlNDak1HTUc0ZzdOS24r?=
 =?utf-8?B?dTNVTmtzSWJyVG1ROFNWakg0NzEyWldYWVg3d0pMbGVqTGc0Tys2Wk1MWGhj?=
 =?utf-8?B?bFVQbDhIRyt2TE94eVgwSDh5dlpHbHBOYXp3K3BIVHZUOVVqRjYydnNJQkVH?=
 =?utf-8?B?VXNkcmdWMjZiWjBma2pNb3VRS3NEVmVLa0ZkRm5BYVpvNEJkb1hDa1VIZDI2?=
 =?utf-8?B?N2o5Vm90QzZiTDFFNXM5YStOc2VOcDY2c1doN2VRQnVFRWNCc3pkN0sxZ2tT?=
 =?utf-8?B?d2I1c1pUeU96T1UzNnRqelRqOW1Jb1NmckoyTEM4UERnUlFYcFBHeXEzZXZ5?=
 =?utf-8?B?RlhlYlVtMnBZQTMxUFRIMWc4cVF2S2trNmNWR2ZaTjl5b21FN0x6MURQdXly?=
 =?utf-8?B?d1pidlNWblduc2hKQUY4cW5oNlU5ZHBrWkhSbHAwUnFUWjFORHk4UlVZQTl4?=
 =?utf-8?B?RXBnTmh6aVRKaXdlYWxqVTI2ZnRWd2EwZ1NsYk0vdWR6NCt6QXh1WlhCcFdN?=
 =?utf-8?B?c2VnamNxRVB4UnhibGZEeDhVc2hZQW1hQms0L3BteXpWbU8yQVZmVlo3Y1lR?=
 =?utf-8?B?ZThVUHNHRlM0cnhwOVNjb0xkdDl3RmdMQzZLb2UwZ05iN2hDQWJ4YlIyUVNm?=
 =?utf-8?B?N1h4RmhPcmdGQWxIVVNFang2Wnl4T0xULzRXekQ3WEVlRDF0QlczamZVSDE5?=
 =?utf-8?Q?f0Iet2CrKYYnLde4XgNxHPwr0FPj0Ll1Gon6j7N?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ek9ydzFlUGhDUEM5NERhdFQ3c3hBSUNidXprN21KQmdSTlhaaVRmcHgrQ1Bz?=
 =?utf-8?B?OXZBN3o3YStRWGViRW9wbnZzZ3owcGdqZXJiVC8vRndQczE0c0ZJaTBOVkxH?=
 =?utf-8?B?NXJKNXBqczFacEdLR2lpQ0VSU0lycDlBRWdINEpJcEFMU3ZxQUszb2VxK0I0?=
 =?utf-8?B?bis2d201dzNrVWQ1MmdlTlI1MytrSDlqdWx1Q3A4azVLbU1HTng2M2REd1pF?=
 =?utf-8?B?aWhhd3lWRXozQW94dUV4UnJjVkZWN0tHRzBUQkp0dHhDWDFxQU16ZjdOc1Va?=
 =?utf-8?B?MEJrNS9HOXJzZVVCM2VkWERsY0hSWEFxNHdCUkpRT0tEVGVDMDdRY1MxYmFF?=
 =?utf-8?B?VHZ0VnlGSkNFbFZ3NzA1NDZtek1QOWdjOVFZL25Nb01IZmdnOWVrVEtyU1N0?=
 =?utf-8?B?a053a1pCM3pWeUo2TWNFL0JSbDRpblhsSGdNRHBIS29qRG5Bd2FaTVI5aXM4?=
 =?utf-8?B?dEExVTJtMUlrM1I3RVFLcGhqZTZzRDBuL3dLUC9LNWNLWGp3c3VrQkNDeGE0?=
 =?utf-8?B?VXN5bEU4dUFldVdOeGxCMGRSYVdYWEQxRVNZWFpJdElMUk1kc2gvRXR4Y3FJ?=
 =?utf-8?B?MFpTVC9yb0FzU0toM3VpdGp0MU5BYk5pcVZEODBGRElacnhGT1NoSG1PUXJ1?=
 =?utf-8?B?aFIzNURrd3BiL1BvSDRGZnV2ZmNnTmVmM2hBVnArNHBzamNObmd1aWNZcDdk?=
 =?utf-8?B?K3d4NmtyRXhLS2M5b0xJSWwzSlM5dEpaR3N3dCtBcWE5aG4vRzlyaHBoVlk0?=
 =?utf-8?B?WVlTVFY5bVM2Mis1a2RQbFdIMEs4SlFKN093cjBOTk9GeWsvWTVBbGYvVE1w?=
 =?utf-8?B?c0o2YzUrRGhLWnRSUHk5YjRaT2pBT3Z0STlWYXI4UGlPeWc1RGhTNzRzNHVa?=
 =?utf-8?B?R1N5dThGVzBYckMrMmxuWXJ4dGh3TWVrYXNyUW5IZVM5WG5VbnZWK3ZZVjRT?=
 =?utf-8?B?aUN1WVRtRTBBeFRJZjB3ckhKQU9ldTB2T3k2dlk4aXdZMERUNVU2YUtxWUha?=
 =?utf-8?B?T1JrbE5xN1JBZTdBVmJBOEF4VDI5WTJEKzE1SVNpMEVLU0JJQ0thVXBUQi9Z?=
 =?utf-8?B?c3Z2V1lvSUdwMEtPZkcvRzB0dGZkY2NFck9ZbWFIa2lySE5oRDgyUUJkR2dy?=
 =?utf-8?B?bEVEaGgvRGpVUEp4b2hRT0tTWG1pSzBQZXFscm5TNnhVVDRuejZIQ2NYak9W?=
 =?utf-8?B?ZTdYdGVlbHgxMFJEcG9adjczZ04rU2tUT0ZqZUtsWnhiUXRzRjROMk12dXh1?=
 =?utf-8?B?WkZBVndSRmVSODkySE0rOU1lSjlmTExCYmVtdXJtYmRHbVU2Yk5tNk51VGFW?=
 =?utf-8?B?MUFrbWJqVTdHdkRDc0w5MzhxR0xPK2JqMmt0SllYTkt6Nk4zNnhCYldkbWlU?=
 =?utf-8?B?dTMvVGtpb2pwT0tCajR5UDZqcVZWMkNvdFhUdnVGMGl5R3hYTG4zZWdSWmFt?=
 =?utf-8?B?VHNDRHNMaHdCYjEvSUNvTXJLR2p2LzErRkpiRXUzTlkxUEZubmpzUVRvZEY0?=
 =?utf-8?B?K3VjUXVaS2tqcS83aTdHK2I2T2JtRWhhTXJkUHNpVEdZeHlOTGxUNWl5RU01?=
 =?utf-8?B?MFZtdVRuYldGTmtQbXYrMGpXUk44MDFJZDFLT0xGRk1ZUGYycVZBWG9VdzBH?=
 =?utf-8?B?bVBnSnNOQnB6T2RBNVpwVnFsREJTUWdkRVdJWmlGUkdmTm5Vbk1veFJobUR4?=
 =?utf-8?B?SDhWUjdlS3N0YkJ0VEZQdkxWVGVnaU0yRm5hLzdRc1RYQksxZDQ1SW53MXlu?=
 =?utf-8?B?NTg3ZGdQajVHUVFSayt0SW9qaWJhOXRScVFVMVFJMWs5NWRhOXUzTjhDaUE4?=
 =?utf-8?B?TFlqMDJyTmJhL09EY3hrSjRrb3dLL3NickNTNHFvcGt5M1lNYXFvY3lmRld5?=
 =?utf-8?B?cGdlMGwrQjhvNGtkMzVQRC9qODRtL3krSGw2eU1SaHJ2UXJLaXZhZHBTQWo0?=
 =?utf-8?B?VXN4bDM5dFd1N0RMdlVLaXF3Q1VwVHM2ZVc3cXBITFI4cUQvY0RJdEpiUE1t?=
 =?utf-8?B?bC9UaXJQL2UvZnROMHZyYit6bjZzampXdEoveUxaa0NGcTdEQkRhelgySkZG?=
 =?utf-8?B?aWJZTStud1JYSEZFVlArQk4wZjNjYXpmb0txVWMwL3JKajRrVktQK0ZURnhy?=
 =?utf-8?Q?Bu4o2u/RdE03VDNW2Cp99Nqyg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7436ae56-69bb-41b7-91dc-08dcab225e93
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 14:18:48.5494 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V8w7LL2w2ZnG/ZcS5pASrgpVppAtkB5TlamOD0UIprj3VedECW1oLF1DbTeT4MnAW3DPLeufaJ4kBuCR0P2RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7018
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On 2024/7/23 05:13, Joao Martins wrote:
> This small series adds support for IOMMU dirty tracking support via the
> IOMMUFD backend. The hardware capability is available on most recent x86
> hardware (and these SMMUv3 in upcoming v6.11). The series is divided
> organized as follows:
> 
> * Patches 1 - 7: IOMMUFD backend support for dirty tracking;
> 
> Introduce auto domains -- Patch 3 goes into more detail, but the gist is that
> we will find and attach a device to a compatible IOMMU domain, or allocate a new
> hardware pagetable *or* rely on kernel IOAS attach (for mdevs). Afterwards the
> workflow is relatively simple:
> 
> 1) Probe device and allow dirty tracking in the HWPT
> 2) Toggling dirty tracking on/off
> 3) Read-and-clear of Dirty IOVAs
> 
> The heuristics selected for (1) were to always request the HWPT for
> dirty tracking if supported, or rely on device dirty page tracking. This
> is a little simplistic and we aren't necessarily utilizing IOMMU dirty
> tracking even if we ask during hwpt allocation.
> 
> The unmap case is deferred until further vIOMMU support with migration
> is added[3] which will then introduce the usage of
> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR in GET_DIRTY_BITMAP ioctl in the
> dma unmap bitmap flow.
> 
> * Patches 8 - 9: Don't block live migration where there's no VF dirty
> tracker, considering that we have IOMMU dirty tracking.
> 
> Comments and feedback appreciated (on patches 1, 5, 8, 9)

Hi Joao,

Do you have a github branch for this version? :)

> Cheers,
>      Joao
> 
> P.S. Suggest v6.11-rc as hypervisor kernel as there's
> some bugs fixed there with regards to IOMMU hugepage dirty tracking.
> 
> Changes since v5[6]:
> * Remove patches 1-4 as these were commited to vfio-next
> * Add the Rb by Cedric and Zhenzhong (previously patches 7, 8, 10, 11)
> * Introduce VFIODevice::iommu_dirty_tracking and use it on patch 5, 8
> to store whether we can use IOMMU dirty tracking.
> 
> Changes since v4[5]:
> * Add various Reviewed-by in patches 2,3,4,6,8,11
> * Change error messages to mention IOMMU (Zhenzhong)
> * Better improve the checking of dirty page tracking in
>    vfio_migration_realize() to detect per-device IOMMU instead of using
>    container dirty_page_supported().
> * Improve various commit messages (Eric)
> * Extract the caps::hw_caps into its own patch as it was miosleading to
> be hidden in another patch (new patch 7)
> * Restructure patch 1 helper to be vfio_device_is_mdev() and use
> vfio::mdev directly in rest of patches (Cedric)
> * Improve error messages of set,query dirty tracking (Cedric)
> * Add missing casts to uintptr and uint64_t* (Cedric)
> * Add missing commens to struct doc from aw_bits removal (and hw_caps
> addition) (Eric)
> * Fix the detach flow in auto domains (Eric)
> * Set hwpt to NULL on detach (Eric)
> * Spurious line (Eric)
> 
> Changes since v3[5]:
> * Skip HostIOMMUDevice::realize for mdev, and introduce a helper to check if the VFIO
>    device is mdev. (Zhenzhong)
> * Skip setting IOMMU device for mdev (Zhenzhong)
> * Add Zhenzhong review tag in patch 3
> * Utilize vbasedev::bcontainer::dirty_pages_supported instead of introducing
>    a new HostIOMMUDevice capability and thus remove the cap patch from the series (Zhenzhong)
> * Move the HostIOMMUDevice::realize() to be part of VFIODevice initialization in attach_device()
> while skipping it all together for mdev. (Cedric)
> * Due to the previous item, had to remove aw_bits because it depends on device attach being
> finished, instead defer it to when get_cap() gets called.
> * Skip auto domains for mdev instead of purposedly erroring out (Zhenzhong)
> * Pass errp in all cases, and instead just free the error in case of -EINVAL
>    in most of all patches, and also pass Error* in iommufd_backend_alloc_hwpt() amd
>    set/query dirty. This is made better thanks in part to skipping auto domains for mdev (Cedric)
> 
> Changes since RFCv2[4]:
> * Always allocate hwpt with IOMMU_HWPT_ALLOC_DIRTY_TRACKING even if
> we end up not actually toggling dirty tracking. (Avihai)
> * Fix error handling widely in auto domains logic and all patches (Avihai)
> * Reuse iommufd_backend_get_device_info() for capabilities (Zhenzhong)
> * New patches 1 and 2 taking into consideration previous comments.
> * Store hwpt::flags to know if we have dirty tracking (Avihai)
> * New patch 8, that allows to query dirty tracking support after
> provisioning. This is a cleaner way to check IOMMU dirty tracking support
> when vfio::migration is iniitalized, as opposed to RFCv2 via device caps.
> device caps way is still used because at vfio attach we aren't yet with
> a fully initialized migration state.
> * Adopt error propagation in query,set dirty tracking
> * Misc improvements overall broadly and Avihai
> * Drop hugepages as it's a bit unrelated; I can pursue that patch
> * separately. The main motivation is to provide a way to test
> without hugepages similar to what vfio_type1_iommu.disable_hugepages=1
> does.
> 
> Changes since RFCv1[2]:
> * Remove intel/amd dirty tracking emulation enabling
> * Remove the dirtyrate improvement for VF/IOMMU dirty tracking
> [Will pursue these two in separate series]
> * Introduce auto domains support
> * Enforce dirty tracking following the IOMMUFD UAPI for this
> * Add support for toggling hugepages in IOMMUFD
> * Auto enable support when VF supports migration to use IOMMU
> when it doesn't have VF dirty tracking
> * Add a parameter to toggle VF dirty tracking
> 
> [0] https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/
> [1] https://lore.kernel.org/qemu-devel/20240201072818.327930-10-zhenzhong.duan@intel.com/
> [2] https://lore.kernel.org/qemu-devel/20220428211351.3897-1-joao.m.martins@oracle.com/
> [3] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
> [4] https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/
> [5] https://lore.kernel.org/qemu-devel/20240708143420.16953-1-joao.m.martins@oracle.com/
> [6] https://lore.kernel.org/qemu-devel/20240719120501.81279-1-joao.m.martins@oracle.com/
> 
> Joao Martins (9):
>    vfio/iommufd: Introduce auto domain creation
>    vfio/{iommufd,container}: Remove caps::aw_bits
>    vfio/iommufd: Add hw_caps field to HostIOMMUDeviceCaps
>    vfio/{iommufd,container}: Invoke HostIOMMUDevice::realize() during
>      attach_device()
>    vfio/iommufd: Probe and request hwpt dirty tracking capability
>    vfio/iommufd: Implement VFIOIOMMUClass::set_dirty_tracking support
>    vfio/iommufd: Implement VFIOIOMMUClass::query_dirty_bitmap support
>    vfio/migration: Don't block migration device dirty tracking is
>      unsupported
>    vfio/common: Allow disabling device dirty page tracking
> 
>   include/hw/vfio/vfio-common.h      |  13 +++
>   include/sysemu/host_iommu_device.h |   5 +-
>   include/sysemu/iommufd.h           |  11 ++
>   backends/iommufd.c                 |  85 ++++++++++++++-
>   hw/vfio/common.c                   |  19 ++--
>   hw/vfio/container.c                |   9 +-
>   hw/vfio/helpers.c                  |  11 ++
>   hw/vfio/iommufd.c                  | 170 ++++++++++++++++++++++++++++-
>   hw/vfio/migration.c                |  12 +-
>   hw/vfio/pci.c                      |   3 +
>   backends/trace-events              |   3 +
>   11 files changed, 318 insertions(+), 23 deletions(-)
> 

-- 
Regards,
Yi Liu

