Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056C3103E170
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 12:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2q7T-0001ms-IA; Wed, 18 Mar 2026 08:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2q7Q-0001mX-S2
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:35:24 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2q7N-0001FR-I8
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773837322; x=1805373322;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZDuXj0VjwUGrdozYqpUhq93Wk2YDnx8nnMlBzScjGhU=;
 b=AjUrVq1LormTYR/sMMqyUkCkBH8PUQAgJI7L/QrLyDJjvHzN0jyySACD
 ec4pk9POqBaKUBpeq9a5pTuTvl6zwRshGNMo/limV5S+/LR4iOMZlDVem
 d1JCG3u+7hr8UfPUMh4r5OONuVJw65f5a+cL7xoipKQjCBObX98b+mgD0
 eaeN4DsCDBfevh6LGpTG6Yu8Ltj21Xz5P0RJTkjdUCvy5aOO6ePwCdb6b
 5+XnHNiaEkoQR2A32H2sLKDPLuIHWg+it+nMVEhtv8O97ZkFOI3Rpt0yx
 GGu0CCHjUtS7TKY+T66PcRL+Dr2+YgwPHx0FRJhK19w1d2xJggMJGArM3 w==;
X-CSE-ConnectionGUID: MzkpNaIkROey4B2QH7JSVQ==
X-CSE-MsgGUID: 5WI+bbj3SIi+iTEWu9lSRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="78747616"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="78747616"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 05:35:18 -0700
X-CSE-ConnectionGUID: qxY2kGoyS761gVkifqHG+Q==
X-CSE-MsgGUID: Cnw1YBbsTf2+25LcBqIJuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="226748903"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 05:35:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 05:35:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 05:35:17 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.51) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 05:35:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRyEwI2jLusuY0UGuYldQP+OY1PuvCnzzG1wRr/98LzpSCQbxqGmge2lU3ckXK7wZYVJs5UgK/+4zNut7wOYj4oR0oDVzm4M31Z9MDnMgoxv2Jp6BQmLhQp9PsipzvVESFjZMnk7M4ZrNjJLXpF0esQgoYJNzL0C66xZOxpTpyh4PGzRpcryvQAvrAHoJ8957THA87duDh/PWiqPg7Jd2uLeOLwzkKZMIfFU2bQBG0fyOGS+2sqRZbyx/dfE8LW8C/e2lAFpsqqU3CSnQg5nCwOX2AnPVm+D1qepp+ToiwjN6nalbzDSbuOu7o4jcnwvBx5BR1RmZhUTOKM7FYnvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQF92D6aXjWAyQOEMK5Jcma24YynAx5KoW1FpjaIjOQ=;
 b=Yri0l143odI7BhHfsmhLCtA6YEbdWEj4GKnPSZb6YbDaMtid/DOZzZ/N5lBnO3kHQwr0ggS0P7MzHo0H1pWuRqFhBCMCl/8cU5/KIxmOKigIVNPhxlg0aA3/++bHV2GfN5wr4OSYAaV0RBY4ueY6V2Xn5pqah8Z8aqX2vlPZCZQeAN+Ro/uhybPx+aVu4QMIPTP2mtnc2nn/9yZj+hIrFPXlKOgWKmkAnFzTPEPHY2rN7wmENrBGKM0AivagNxKUjb/gYzn4z1WRt1YTFFtIDW9OsNSEN0POmUtIy8x/Q+erW5Ok2AqKpjTS0i2gMSkh7xB89xu5EYQwRgMGo+ECcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 12:35:08 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 12:35:08 +0000
Message-ID: <e8843f0e-61ec-4425-ba25-62b85b0e5371@intel.com>
Date: Wed, 18 Mar 2026 20:42:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/13] intel_iommu: Handle PASID entry addition for
 pc_inv_dsc request
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-8-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260306034409.184873-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|PH0PR11MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc396d5-95ff-4807-400d-08de84eac9ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|42112799006|56012099003|22082099003|18002099003|3613699012;
X-Microsoft-Antispam-Message-Info: T1jg0bynbjzr9eHMhaNM2pDcbdS66R4wvjQTM4PMMvxj1ix+1s6FF5BP+nsu6rivymgVeE3y9JcEofn13gzZXEnISIFHVLREYDdHEohsWigSIjaVDIdqzac8EJkxBsNhrACTTUuN4DnNW5kkLwj6b8D5ANfHX2x2Yg+TVDELhpimDzI1h7akvrYOdtAovo0s7FtNCiRKMN7sjIF4k//nAJYHFtCLROshPCVtVVWc8BL+zrRky/MwUJi+udNlighqPz6dkx08untz9comCubyV8lOUIwJv7yu6Urn55mdX7I/Zt6+ZMEbILF7GUteGqQhOvjjq/vwvXfjprzKS9qkI+SlVx2QWOKnwyDZMDFPp/ajw1wjvmJFIr34LlNrYxLcFAHN2apy/q+dYA/xghqgMslkik8NYCrqhqEO1QxSX1z6UW8rTRizLI3Z2Z/NHZvUP/1wU5hYTt5BuhHpA3+qKbkmVbFo+oCAk/5BF/Gtw6tdlqTg/h1fkiReQ77hddms6jTyezXJpgnx6AcNWYbggMdtdS8aVoC04UHVC/W5Igcz9UO/lV/G6dAf7nTWtzIhIOcbI6pe29muSXhhdZuYKtGLmbcertu3vkqxp1FUgurhhQ9ijg22/hcR/tZFbD5axCuLFEXvBdWstYk5N2PLDGFPZ98HhvTFkOgJqH33NUV41D7ZqzSGEIreoTFltDXt+sIt1EoJpdCgRFycHvKALZR6KeEm0t7WQBm9AO09DgeCqM314uFFjLc5oJBm+WppBDY9+qIBMaMrClbaNsaxowo3BbWUmhIvUZ/puLFzL9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(42112799006)(56012099003)(22082099003)(18002099003)(3613699012);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V08rTExKY1VCUG81ai9lTnVCMWZsTHZvVERwVmRBY0J4SHFMazBqbW9ZTUNH?=
 =?utf-8?B?S09iY3FVWEI0VWd4eHg2TTlSZ3NhRFUxVjNqUGp3S2RjVmdKQVVuYTVkMTBV?=
 =?utf-8?B?Mjc2d2NnRlRGbVdXd1QxVTRtNjdYSWlwQ002SjBUbzROWU1vdVludnVWdEZL?=
 =?utf-8?B?b0ZmNmtrT0xRSkg1czRadDNzYktoTGc2NHFTOEdOTXhPdDZ0WGt6ek9hQVV1?=
 =?utf-8?B?ZVNuMm1YZlhYSlhKMlNodWlzeGNyeklPcGlWWXUyaHdnTjFOVmM1alJhNDNo?=
 =?utf-8?B?Rys5TUwrby9TenZKbmRHMWxRLzJObjVXU0xXKzIrT094US90ZjR2T1NaV09H?=
 =?utf-8?B?K0c4MlgxaFc3SzJOL3BraEdPb1lTaU9kWUtSVmZDS2FoeGE5ZlVIVStLWDlt?=
 =?utf-8?B?OElYbkRhVUcyeXkray9TU0pML1NRQ1pBeG1CbU1iWXk5VWVIK2g5b0ExY3U4?=
 =?utf-8?B?UjMrNmJMeFV0MGQ0Q25TdVYxQ2d5UW1NSE5JOTFkRGNrNnRPTlRzVkhtTG8y?=
 =?utf-8?B?QTdhN1dDRDQxYVF4U0tvRGE1YjQ0WVVuME1xTWdwRW1nYzNYOGRSUnpIaG5H?=
 =?utf-8?B?Q3YyL0RBVEFBY0tIUnVpNXdUSEdnMzF6YnJ6YWFXd2M4T3RrQldkejM2WWRL?=
 =?utf-8?B?RWxtMG40dVBFY21ETUUxTHUwdTAvNnNHWXdCbExxUCt0TitDV29nQTZ6N1RI?=
 =?utf-8?B?eDBNMnZTNjBQNmo3RStPOEY4VXY1SkdhWnh4V0kzNSs3Y1ZXZ2RlQ0h3RC9s?=
 =?utf-8?B?K0pKc0VKVlplOHUvaTRKN2RtK3RSSHViaGdSNDVDeGpLT0Q0b0lGTm1BQW9F?=
 =?utf-8?B?bHI3RDRzSmg4MWdidFo4WFNLZmlXR0ZlYlJLZFYxdzBnYlRINUFZbXZ0eHRI?=
 =?utf-8?B?VVY2ekRiZ056c0xqVkxNMzhHcmlhNklLVWNOZWFDdUtZR1YzTHQ3NHBLdUls?=
 =?utf-8?B?d3I4R1VteEJ0d1Q4YjBvWUt4TWZTTm5Cb3I5Tm5EcExiNExBc1VVSHFreEpF?=
 =?utf-8?B?STUxQkVJUEFZRE5wSU1wTGJEMVpOZFVwTzRoK2h3U0psbk5zTHFQcjZ0M0I4?=
 =?utf-8?B?VTdLVWw4OTV4ektMZDBnLzdTaDdGM29vMi9iL0RIUUdiSCtSNm9ZalI5NUpx?=
 =?utf-8?B?U0tPajU3MHd2T1JrQlZvTXhhWUlQbjJKbFRGaGI4UjNxWDJJRGowblZwc3BG?=
 =?utf-8?B?ZVBEUGErS3k4NkNXVUdOUFZNa0Jray94K0ZWV2ZyVHhQWTZvbU5SZlVXT2o2?=
 =?utf-8?B?Zk1aRUFUbHFDdzdqUzhiWHNRNXpud0o4aFl1UEcyNUtJUXNmNDQrOWpsWk5H?=
 =?utf-8?B?dHllMkdoOEwvSDI3QkgwbjNJbHZmcXlyOEQzMk93ZlNFUFdhSStOb0JuR2kw?=
 =?utf-8?B?N3JiNGJBTk5uOXp4YzhCR0dpaFRjdWttSVAwbVExWWdIMFIyUC9jUUE1Z2ht?=
 =?utf-8?B?YitsZ1JjNFRUdjBqZ3U5MVNCNlZiSUZRSnBGT3dNZ09mL1BsWHhzdS9SMGlU?=
 =?utf-8?B?VmJZMXloV3gxQkgyNFV0K1hIUEtBbkxmcVBLbzdqQ0lHYnAraGo0TTJxU2w1?=
 =?utf-8?B?ZFpLbTN0eTBLTHVsbzdCNkJFbWNLZUFwRzlJeitnT1oxWkJnMFN5ZkU1WWor?=
 =?utf-8?B?dFZ3aFV3cE9RazhNT2dHV1ZTbTRxZzlyd2l4Z2ZXZDZSeS9BMitvUTRFY0ow?=
 =?utf-8?B?Y2I5aFc5L1g3MHJIWXZybDV2WWVCSVEzQUI5YWtwRElHM0gvSVBXWHpScG9L?=
 =?utf-8?B?L0VObkJTeXd0eUZGT3lmdDVlMFc3OFdwd0k4VU5iQU9vQkk3SnBBRUhTbm5E?=
 =?utf-8?B?OENZV0dBVjRBbVREb2Z5b2hOVXpValA0ajk2ZmdwU2tFTkNldUd6NURtM3dq?=
 =?utf-8?B?V1hrTmZOekRaNkdEQzZTVVhKZUtzZzVLZVNrb0hncnliM2V2QmltekpLM1Nj?=
 =?utf-8?B?M1c4TGhQTnJWWkNmWFdiTlo0dng4OGJhYUZpSVY2WUg5dFRweDFwcG1PSEZk?=
 =?utf-8?B?djY0OSs5YmN0QWdBbW9La2NjM3BPT3ZGaGZmTTFTdlZTRmloUXJrUlMwQWF0?=
 =?utf-8?B?Mnk3K1ZsK3RrSW5ySkVwNkxPZy9UNUpOZ0IzRFNLd2VkczEwdnZDRjhNN2FH?=
 =?utf-8?B?VmY4TmpMVDEramNqZkV4dVFyZzljS0FORWhieENvZ0pGWk9neFZ0R1QxczNa?=
 =?utf-8?B?dTlPT2h1dVJRWlN4ejNRbHZQRnYvbVZTa0lWOW9mVlF6R09HZHl3SXIyVmx5?=
 =?utf-8?B?TGVaN053Y0h1QVZUREQ2MDVMdUgxQmJKVTU5VmtOWWk5SVp3SjgrajlPSzFq?=
 =?utf-8?B?dzBJRktEMmhkVmdFaFM3M1RsRVczd2kyMnNGWC9OSVl3aE9JNzVyZz09?=
X-Exchange-RoutingPolicyChecked: GNxxohl1q0QfRqXRJ2AUiW1zrFyMCcfG9qdyT20BF7ggFMS/jQwLNZG3Ps5vz1PyFqgYUc8FKQXXRtOPT5lc3BZPR3N5SKAtmFImSPtvHv5f2i8B5VcE5OIe76mdcUry7J8aypHBOuKSH3/tTxZRCyre4mqNvqA+vPF4uDNw4JHULE+VKTSvEnQbXcCjpjSkFBvhoojoxYISvggd8PzdxRc1TWN5ea/8+/eH+Z/h/PteSoHgZDRkj/WYnEarYzxMov5BD+lgfXOCaJwF9HC/ZZjbQOU9XbbPnAPTAiJquyjav1004duG3xjkbpDGZYj8BSikNRpJMdoq7J1TQ6nCXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc396d5-95ff-4807-400d-08de84eac9ef
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 12:35:08.2097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HX8Rw2ik26J6u0QVUNg0cYaGEO5HWlvEtOLI8WDsQkZ+CuEKP96vHQp6H1ARtpvHgasXOMO0NqreOdJnP8CGbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5925
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/6/26 11:44, Zhenzhong Duan wrote:
> Structure VTDAddressSpace includes some elements suitable for emulated
> device and passthrough device without PASID, e.g., address space,
> different memory regions, etc, it is also protected by vtd iommu lock,
> all these are useless and become a burden for passthrough device with
> PASID.
> 
> When there are lots of PASIDs used in one device, the AS and MRs are
> all registered to memory core and impact the whole system performance.
> 
> So instead of using VTDAddressSpace to cache pasid entry for each pasid
> of a passthrough device, we define a light weight structure
> VTDACCELPASIDCacheEntry with only necessary elements for each pasid. We
> will use this struct as a parameter to conduct binding/unbinding to
> nested hwpt and to record the current binded nested hwpt. It's also
> designed to support PASID_0.

PASID_0 of passthrough device still need to register MRs in case guest
does not operate in scalable mode. So for PASID_0, you will have both
VTDAPASIDCacheEntry and VTDACCELPASIDCacheEntry. Is it?

> When guest creates new PASID entries, QEMU will capture the pc_inv_dsc
> (pasid cache invalidation) request, walk through each pasid in each
> passthrough device for valid pasid entries, create a new
> VTDACCELPASIDCacheEntry if not existing yet.

I think this idea is ok, but we need to be clear about the
boundary between the usages of the two pasid cache structures.

> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_accel.h    |  13 +++
>   hw/i386/intel_iommu_internal.h |   8 ++
>   hw/i386/intel_iommu.c          |   3 +
>   hw/i386/intel_iommu_accel.c    | 170 +++++++++++++++++++++++++++++++++
>   4 files changed, 194 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index e5f0b077b4..a77fd06fe0 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -12,6 +12,13 @@
>   #define HW_I386_INTEL_IOMMU_ACCEL_H
>   #include CONFIG_DEVICES
>   
> +typedef struct VTDACCELPASIDCacheEntry {
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    VTDPASIDEntry pe;

let's use pasid_entry here as we already used it in the 
VTDPASIDCacheEntry. Sometimees, it may help when for searching related
code.

> +    uint32_t pasid;
> +    QLIST_ENTRY(VTDACCELPASIDCacheEntry) next;
> +} VTDACCELPASIDCacheEntry;
> +
>   #ifdef CONFIG_VTD_ACCEL
>   bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                             Error **errp);
> @@ -20,6 +27,7 @@ bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
>   void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>                                         uint32_t pasid, hwaddr addr,
>                                         uint64_t npages, bool ih);
> +void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info);
>   void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops);
>   #else
>   static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
> @@ -49,6 +57,11 @@ static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
>   {
>   }
>   
> +static inline void vtd_pasid_cache_sync_accel(IntelIOMMUState *s,
> +                                              VTDPASIDCacheInfo *pc_info)
> +{
> +}
> +
>   static inline void vtd_iommu_ops_update_accel(PCIIOMMUOps *ops)
>   {
>   }
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index c7e107fe87..ede4db6d2d 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -616,6 +616,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>   
>   #define PASID_0                             0
> +#define VTD_SM_CONTEXT_ENTRY_PDTS(x)        extract64((x)->val[0], 9, 3)
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>   #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
> @@ -646,6 +647,7 @@ typedef struct VTDPIOTLBInvInfo {
>   #define VTD_PASID_DIR_BITS_MASK       (0x3fffULL)
>   #define VTD_PASID_DIR_INDEX(pasid)    (((pasid) >> 6) & VTD_PASID_DIR_BITS_MASK)
>   #define VTD_PASID_DIR_FPD             (1ULL << 1) /* Fault Processing Disable */
> +#define VTD_PASID_TABLE_ENTRY_NUM     (1ULL << 6)
>   #define VTD_PASID_TABLE_BITS_MASK     (0x3fULL)
>   #define VTD_PASID_TABLE_INDEX(pasid)  ((pasid) & VTD_PASID_TABLE_BITS_MASK)
>   #define VTD_PASID_ENTRY_FPD           (1ULL << 1) /* Fault Processing Disable */
> @@ -711,6 +713,7 @@ typedef struct VTDHostIOMMUDevice {
>       PCIBus *bus;
>       uint8_t devfn;
>       HostIOMMUDevice *hiod;
> +    QLIST_HEAD(, VTDACCELPASIDCacheEntry) pasid_cache_list;
>   } VTDHostIOMMUDevice;
>   
>   /*
> @@ -768,6 +771,11 @@ static inline int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
>       return memcmp(p1, p2, sizeof(*p1));
>   }
>   
> +static inline uint32_t vtd_sm_ce_get_pdt_entry_num(VTDContextEntry *ce)
> +{
> +    return 1U << (VTD_SM_CONTEXT_ENTRY_PDTS(ce) + 7);
> +}
> +
>   int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base, uint32_t pasid,
>                                     VTDPASIDDirEntry *pdire);
>   int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s, uint32_t pasid,
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 744b5967b2..984adc639a 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3202,6 +3202,8 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>       g_hash_table_foreach(s->vtd_address_spaces, vtd_pasid_cache_sync_locked,
>                            pc_info);
>       vtd_iommu_unlock(s);
> +
> +    vtd_pasid_cache_sync_accel(s, pc_info);
>   }
>   
>   static void vtd_replay_pasid_bindings_all(IntelIOMMUState *s)
> @@ -4760,6 +4762,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>       vtd_hiod->devfn = (uint8_t)devfn;
>       vtd_hiod->iommu_state = s;
>       vtd_hiod->hiod = hiod;
> +    QLIST_INIT(&vtd_hiod->pasid_cache_list);
>   
>       if (!vtd_check_hiod(s, vtd_hiod, errp)) {
>           g_free(vtd_hiod);
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index c2757f3bcd..0acf3ae77f 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -257,6 +257,176 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>                            vtd_flush_host_piotlb_locked, &piotlb_info);
>   }
>   
> +static void vtd_find_add_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
> +                            VTDPASIDEntry *pe)
> +{
> +    VTDACCELPASIDCacheEntry *vtd_pce;
> +
> +    QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
> +        if (vtd_pce->pasid == pasid) {
> +            if (vtd_pasid_entry_compare(pe, &vtd_pce->pe)) {
> +                vtd_pce->pe = *pe;
> +            }
> +            return;
> +        }
> +    }
> +
> +    vtd_pce = g_malloc0(sizeof(VTDACCELPASIDCacheEntry));
> +    vtd_pce->vtd_hiod = vtd_hiod;
> +    vtd_pce->pasid = pasid;
> +    vtd_pce->pe = *pe;
> +    QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
> +}
> +
> +/*
> + * This function walks over PASID range within [start, end) in a single
> + * PASID table for entries matching @info type/did, then create
> + * VTDACCELPASIDCacheEntry if not exist yet.
> + */
> +static void vtd_sm_pasid_table_walk_one(VTDHostIOMMUDevice *vtd_hiod,
> +                                        dma_addr_t pt_base,
> +                                        int start,
> +                                        int end,
> +                                        VTDPASIDCacheInfo *info)
> +{
> +    IntelIOMMUState *s = vtd_hiod->iommu_state;
> +    VTDPASIDEntry pe;
> +    int pasid;
> +
> +    for (pasid = start; pasid < end; pasid++) {
> +        if (vtd_get_pe_in_pasid_leaf_table(s, pasid, pt_base, &pe) ||
> +            !vtd_pe_present(&pe)) {
> +            continue;
> +        }
> +
> +        if ((info->type == VTD_INV_DESC_PASIDC_G_DSI ||
> +             info->type == VTD_INV_DESC_PASIDC_G_PASID_SI) &&
> +            (info->did != VTD_SM_PASID_ENTRY_DID(&pe))) {
> +            /*
> +             * VTD_PASID_CACHE_DOMSI and VTD_PASID_CACHE_PASIDSI
> +             * requires domain id check. If domain id check fail,
> +             * go to next pasid.
> +             */
> +            continue;
> +        }
> +
> +        vtd_find_add_pc(vtd_hiod, pasid, &pe);
> +    }
> +}
> +
> +/*
> + * In VT-d scalable mode translation, PASID dir + PASID table is used.
> + * This function aims at looping over a range of PASIDs in the given
> + * two level table to identify the pasid config in guest.
> + */
> +static void vtd_sm_pasid_table_walk(VTDHostIOMMUDevice *vtd_hiod,
> +                                    dma_addr_t pdt_base,
> +                                    int start, int end,
> +                                    VTDPASIDCacheInfo *info)
> +{
> +    VTDPASIDDirEntry pdire;
> +    int pasid = start;
> +    int pasid_next;
> +    dma_addr_t pt_base;
> +
> +    while (pasid < end) {
> +        pasid_next = (pasid + VTD_PASID_TABLE_ENTRY_NUM) &
> +                     ~(VTD_PASID_TABLE_ENTRY_NUM - 1);
> +        pasid_next = pasid_next < end ? pasid_next : end;
> +
> +        if (!vtd_get_pdire_from_pdir_table(pdt_base, pasid, &pdire)
> +            && vtd_pdire_present(&pdire)) {
> +            pt_base = pdire.val & VTD_PASID_TABLE_BASE_ADDR_MASK;
> +            vtd_sm_pasid_table_walk_one(vtd_hiod, pt_base, pasid, pasid_next,
> +                                        info);
> +        }
> +        pasid = pasid_next;
> +    }
> +}
> +
> +static void vtd_replay_pasid_bind_for_dev(VTDHostIOMMUDevice *vtd_hiod,
> +                                          int start, int end,
> +                                          VTDPASIDCacheInfo *pc_info)
> +{
> +    IntelIOMMUState *s = vtd_hiod->iommu_state;
> +    VTDContextEntry ce;
> +    int dev_max_pasid = 1 << vtd_hiod->hiod->caps.max_pasid_log2;
> +
> +    if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_hiod->bus),
> +                                  vtd_hiod->devfn, &ce)) {
> +        VTDPASIDCacheInfo walk_info = *pc_info;
> +        uint32_t ce_max_pasid = vtd_sm_ce_get_pdt_entry_num(&ce) *
> +                                VTD_PASID_TABLE_ENTRY_NUM;
> +
> +        end = MIN(end, MIN(dev_max_pasid, ce_max_pasid));
> +
> +        vtd_sm_pasid_table_walk(vtd_hiod, VTD_CE_GET_PASID_DIR_TABLE(&ce),
> +                                start, end, &walk_info);
> +    }
> +}
> +
> +/*
> + * This function replays the guest pasid bindings by walking the two level
> + * guest PASID table. For each valid pasid entry, it creates an entry
> + * VTDACCELPASIDCacheEntry dynamically if not exist yet. This entry holds
> + * info specific to a pasid
> + */
> +void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
> +{
> +    int start = PASID_0, end = 1 << s->pasid;
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    GHashTableIter as_it;
> +
> +    if (!s->fsts) {
> +        return;
> +    }
> +
> +    /*
> +     * VTDPASIDCacheInfo honors PCI pasid but VTDACCELPASIDCacheEntry honors
> +     * iommu pasid
> +     */
> +    if (pc_info->pasid == PCI_NO_PASID) {
> +        pc_info->pasid = PASID_0;
> +    }
> +
> +    switch (pc_info->type) {
> +    case VTD_INV_DESC_PASIDC_G_PASID_SI:
> +        start = pc_info->pasid;
> +        end = pc_info->pasid + 1;
> +        /* fall through */
> +    case VTD_INV_DESC_PASIDC_G_DSI:
> +        /*
> +         * loop all assigned devices, do domain id check in
> +         * vtd_sm_pasid_table_walk_one() after get pasid entry.
> +         */
> +        break;
> +    case VTD_INV_DESC_PASIDC_G_GLOBAL:
> +        /* loop all assigned devices */
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    /*
> +     * In this replay, one only needs to care about the devices which are
> +     * backed by host IOMMU. Those devices have a corresponding vtd_hiod
> +     * in s->vtd_host_iommu_dev. For devices not backed by host IOMMU, it
> +     * is not necessary to replay the bindings since their cache should be
> +     * created in the future DMA address translation.
> +     *
> +     * VTD translation callback never accesses vtd_hiod and its corresponding
> +     * cached pasid entry, so no iommu lock needed here.
> +     */
> +    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
> +        if (!object_dynamic_cast(OBJECT(vtd_hiod->hiod),
> +                                 TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +            continue;
> +        }
> +        vtd_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
> +    }
> +}
> +
>   static uint64_t vtd_get_host_iommu_quirks(uint32_t type,
>                                             void *caps, uint32_t size)
>   {


