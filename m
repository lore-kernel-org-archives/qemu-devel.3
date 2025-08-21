Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EABCA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0ty-0001Sa-Dw; Thu, 21 Aug 2025 04:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1up0tv-0001Rh-Kr
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:44:03 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1up0tq-0000ic-Vf
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755765839; x=1787301839;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Bi1rEGfCk4x/6D1PkvVwI6Gs7AuYnA9t3rkEXyD31kU=;
 b=X/5GnL4/1zPSyVk6U5o8xPje4qvijq+atorjMUkQwphYvKle1XG/WNzo
 h99QC4GMt13DjNpWpaqdN/MBPu9UO3ZiKvoq13rZYW5UEszMoLS4phOoP
 zAWWZ0iN3VzVMVzDe0O1BlTp+OJunRhpSgf3v4tmFfG4xPdIhJ3pj7FvI
 3UeOVVFqtuDDTN0nL3p7MjRHTfTACuhkPHxQUH412TMJnA7jayp5bLmIO
 tP/FlgLz8vbDP11nG4PIOSGcuyHke/zVdgR0VD9lTCZyqFQE75bCZfyZo
 +hWEXStoW26tI36vL/ymmU5JVokU5iI7NgpXB+6eZXMwhyNUDOkwpxLVt g==;
X-CSE-ConnectionGUID: g3zVdWqJR6OV+Vxv1eHQuQ==
X-CSE-MsgGUID: YIZ1cNmVQuiHl2BTuxZ0BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58194249"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; d="scan'208";a="58194249"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 01:43:55 -0700
X-CSE-ConnectionGUID: r0xzQcTHThi6XzSoIc8IGw==
X-CSE-MsgGUID: wiAMzMWLQHubRPM8W5VpAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; d="scan'208";a="167568432"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 01:43:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:43:54 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 01:43:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.47)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:43:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGI+o9tVm/jPJycVJ1f1A6IDdmkjDGsmd1TbQDlD3t2klMtYGsdtI+ZbM2xWdUkSEU6YmNVo3v42vqOOzKpnb6R+qj47zXDodNoolux9MvqeVo+5p88ixYtWGsK0JrzVkVY/Uqdy6/R6IXfI8m+zt0+OXT3JHRcP0+TuwqPdEx6JCKw71kw7f/PFGs4gVooAxjf7NGXKdReZpG6BPF1iBi9nFp97nQCbkxUEEG2w/a67FoUyMfKkapJ4zngjLbRaSurmER4qfEKeWx+e/wupfdDZWnmHRtfgdfyR+VwYwiMIYwar6qFPofpGxB1be/cWWPY43eovztH8OYRUYGfSuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpiDlcmQ9t/WiN4kj+MB07LtgGp2YgOr00kQAmRXW1M=;
 b=rv4cF1GLjhUNlHjfV1Calu6pcK39l9FWfWIytPzmu2uVBCcraIjKNhB6okDxKfkgQtP/RhNW3y3/kkNI2aK7sISIZujUbbsJwLtmWUTkNy7q+Wa0NSSXoOFFo9wCacS/vA95kxa9moyLs6S0GvOQ8yYZbT6L/7d1SWozRj0hDuBHBiqUYhbwnrh5nSAK4piqSEWTG+OtdYkra0rYBvpeoH+HALY17cn+LoAbWrkvz8BJoJN+rs6ObSga7ZzC2vFpbgDW6pAgXmnJm8N+q2mkPNBHXF5OinbkggZI1brErBTQRRv6M726XKa54rQcClgDlNlgm6NK/mjNBa5mc2iPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by PH7PR11MB8600.namprd11.prod.outlook.com (2603:10b6:510:30a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 08:43:52 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 08:43:52 +0000
Message-ID: <5d3d46b3-ce2d-455a-b8bd-57213f9ea093@intel.com>
Date: Thu, 21 Aug 2025 16:50:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <DS4PPF93A1BBECD1D6A6FEA7C800E6EDD069232A@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <DS4PPF93A1BBECD1D6A6FEA7C800E6EDD069232A@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::10)
 To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|PH7PR11MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: b5d95fa6-eb45-4e4f-a58e-08dde08edb0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|366016|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1d5c1RDUWR3NW5ZYVNXUjZYUVZUYWIxVzNxODFWc1V0SXJVVHQwbEd0bVBN?=
 =?utf-8?B?dUVramlRNXVxVGFmazQvYytBTEhoTXcrZ2pKd1lnOHJlQmlTMEVpSlpOR1Vt?=
 =?utf-8?B?WkxVcXRmSWhUcktQaWNWS0QyelpUUkRCMGhVS1gxTlk1bUR0eWpzeVJSenor?=
 =?utf-8?B?Z3JQcllCVlZnR2dYM0dmb2tOVmMvWnlQekttbm5mbVFLNVUwbUlya3lsdi9G?=
 =?utf-8?B?M2p5VWd2OGFwSmJjWG9BQm1ORWpQSldRcWNYV09NSDQ5aHVLelY4NWVoaWt6?=
 =?utf-8?B?eDh3U3A2VlVQNmpWeEFBdVAwcUdYeWJ3N2sxWlhWb0ZSNDlseUVyYmE3SFl5?=
 =?utf-8?B?U0s3eGY2NktxRGJKbUE5UzJIb2ZKblF1VW1STTJ2U0pjc1EvK01aRkNiYU9B?=
 =?utf-8?B?QWtBRXZjTmxFUjhnUEVhQ2xsSjdoRWc1VXcyL1kvM2R2Q0NKbThTb0c0cXZU?=
 =?utf-8?B?Q2hmNWVkWDRpcWtBWkMzOHdCTmxXaTM3dWg0S1o2VExWbjJTSUpJeGlRQm9I?=
 =?utf-8?B?UlZMa3dwMnRVWkZOaTkzSUM3TTFFZVV2T1FZeDRRVFZXR0E4cVl1TjhNRWZC?=
 =?utf-8?B?ejJHY0ZaZDFZSVNoYXhKNlA3TzVkUWNSWVpsdHBqN0lPbzlneTRia3ZoTXJ0?=
 =?utf-8?B?RE4zNnBSY0FqNEdOMlBTcUJKWCthUHo1RTBiblBjNnBHZldtQ1ppUWtTR1lX?=
 =?utf-8?B?cVFqUXJpeFo5NnEvUnRST3FiMkhaV1FadWZnSENudy80Y0pEUEVmOE5PQkJq?=
 =?utf-8?B?NFhwSVhtMDYzOWRveUZ3bERiY3dWQk05TjZJN3Y2NDFJYlc0aWN0LzREamxt?=
 =?utf-8?B?MVhaV2JldVZGc25Hbm1KZ0UwY1Nid2c1Uy9xL0M3WHE1MHRXSzJSZS8xNVhz?=
 =?utf-8?B?aTZFejhNa0p6SDZ1OUlhcVR1eFhzYjZlandlR3I0VDl6Zjg4WGNEaVQ3ZHFK?=
 =?utf-8?B?K2svQVFnSndITnZpa0ZMbW11M2oraFdVMGxwMkhUS1VnOE91U1ZvWm84a0xC?=
 =?utf-8?B?WHhyM2tIcVFFV2Q4bFV0Q1I2MGx6VFoxdGczR0pYYU1LRVNYbTNnYmRyOHNJ?=
 =?utf-8?B?b2dQVWF6NzZzVVpRMjRSQVM2NjMxUEZjM3djY1VIMjZ4M1JxTTBiTXh2WHpr?=
 =?utf-8?B?TytqZnNrV2ZhRW11VnVNVExNRU91YjAyNXBHUGhHa3RoNDlXUitWaDZHSzVs?=
 =?utf-8?B?V0lkcldyNk9nUzV6d3pJUXIzT05jaHVMM3RBcXBEdEZBZjBNekRPQTFIY09G?=
 =?utf-8?B?NU1uK3RNUGFCU2hWN0tKdDZiQ0I5cGtMYysxR1RYSnBEdU5WdlRYSFhFQkkx?=
 =?utf-8?B?elRiNlh2K1laNlQrSTlMZlI0RUlYOFVFZzJ3aFRMYndSRjFpcjZlM21tRHpG?=
 =?utf-8?B?andvVHRpNUdNQmVSZ29hamJiWUVpdDFpa25lVWpIV2tlSmpYeFlHOXp1RG1m?=
 =?utf-8?B?a3lKUWZEVU8yVEVTZzFvUERMb1hYcWhtNHRQNDJjbXVzMGk0UWxacFBwSDRD?=
 =?utf-8?B?YTA3L3NHR012NDVkSzRkeER5d1I0bXFaSGZrNGMvV2NtR2grWHJ2enpBSlht?=
 =?utf-8?B?U1M3UTRxTWxWMldqNnBKNms0QnR4QzNXUWhDZXh4NHd3ZmJ1QXdKeEdzTy9r?=
 =?utf-8?B?U2dNaWpnNXZmMHdkaFFGVk1jY3JVNmcrMmJaaVEyMDJSbmNvUFJXSW9xSC9E?=
 =?utf-8?B?dXp3ZGY5RXY3QytjMGxMeWRibWFvN2hmTWE5c2JEWlpLaEdRbUdlNmdDQWZP?=
 =?utf-8?B?LzZXaDVxOFRwMkkwWWc3TTdXT2haa3BYdGJPQ3RjN2lCNUxSa0dvUTY2UFBM?=
 =?utf-8?B?SmpBQThPeGxjbUZILzVLZmE5Um12b3B4UDVzWXZGZEJnbEtkUm9OMHp2N0dJ?=
 =?utf-8?B?RTRPV21YWHVDNFF5WHZ5UUhwNWNCYmg0VXZESThIUjBOenkvWFJiTldpNzI0?=
 =?utf-8?Q?N9wPhhJ+z3M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzdITjluVWRLUDVmWHJlOFlIR3prWWRVZ01VaUxDdEFoYTB5NVFkdGVZbWls?=
 =?utf-8?B?NHZtTWFRZTM1dEx6Z2QxdVplbkhEUjFKTUt1Rkk2SkFhME8rWmttWmFHMG9F?=
 =?utf-8?B?VVFtdlVZazFOdmZUdXhoZStFc1hDenF0c3pPSE13eDVZaWlrOFFEaUtlTDhy?=
 =?utf-8?B?Yml6MmZpQ2tqWkhSYzlMcXVtZ2djQVc4aVZybTB2NDM3dWcrRGo0MHEyYWFW?=
 =?utf-8?B?aDJmSThweHFiTi94SzhJODZVdkhwVVlyRy9mcWs3aHo2ZzlJSGpQSEwzVU81?=
 =?utf-8?B?Vm9STmFGT3RKVk1jZHdtZ1dRRWpvTFFxOENVZEVid0sxUG5abitNc2s3T1hY?=
 =?utf-8?B?WmF2dytMZU5FUFNkcURsOHJ2cVg3YXIzdG9JbGNINzhaaWFONklXU0xibGhM?=
 =?utf-8?B?QmVVMjFscFVDSlB1ZkxneEYrQ1p3a1RrSTBBU2l1a2FyVU51Um0vMkx4VHNx?=
 =?utf-8?B?OUNaekJLTUdFK1FQV1hzQU8wZ1Jpbk8xT2ZOVURkSHNoNjhkRVI2d3Y2ZmdP?=
 =?utf-8?B?QVJUYU5BaVZEaDROR0RiQkRzRC9vaTQ4OE51SUlNeGFTdUp6WVpKS0g2Kyty?=
 =?utf-8?B?WUtudld0Z0RkUmkySzdJRzJxd25aQ3NwVUhwcm10LzRzMGJBV2RvTklMOWpl?=
 =?utf-8?B?SnphSVQzc3UyRTdLQWFrdUxzYzFLc0ZCdWhjU2ZJWjBFaWljMlo1T3Q4VU4w?=
 =?utf-8?B?R0lXMzBpWDBaTlZvL1hMUWZDREpmRHQ5YU94UzVnRjdjMzVEaWpyaitlTEJL?=
 =?utf-8?B?UzI0MUptYjNObUZOUDFCYldPWU01WHY2azh4WUlTdWdzM2h3eHhOQ3pwaytY?=
 =?utf-8?B?ZnZ6UmRZTXl5RGJyandYclpGV2JPdFQ3ckRvb1VkYkNjS1V3bjNOU2hzd0FX?=
 =?utf-8?B?dTROZnF5MXU1MVBwSTJrSmxhazRsK01HRmNiK0dDTGRmWWMxaWZ6dXdUY3NQ?=
 =?utf-8?B?MDQxbTBTWkxVZVAyczRtcXcvN3pXSDBMV3Y3VTlUL3FPQ3Y3R0hQcGcxL3VY?=
 =?utf-8?B?ZS9FZG92dXl6SjI0bmg2S3FWM3dHOHpUNG1iK3YweWlZNEtvOG1lUFp3ZWxJ?=
 =?utf-8?B?NXRoQjYrMzhlT0JXOUt5MXFMRDlIallmam9CSkJUeVdnY21xZUJJWlh3VlVv?=
 =?utf-8?B?dVFyT1A2K1BqNkN0eEdjb2Q2Y2NzMkpFcmlURGtVU3hCMldCNlV2TGdXMGNl?=
 =?utf-8?B?a3R5ZGcwenZ4cStYL2xkaTV6cjNjakhtVEd4d2kveXZHelVybklKVnByTDZO?=
 =?utf-8?B?bHZaRENydkt1WFFjK2FxMHpKUEJQVDVuTXYvWUpKeWYxS3huZjFEbnA5alcr?=
 =?utf-8?B?OCtuUTVpSkhPa3RwT1FlajZnK3NCZkJHaDZDSHdPVVJNeUt0VGtpbE5VdGNB?=
 =?utf-8?B?U2FLanBHNnBONjFxT2pmZldjTUlSUTBaajN1ZFJrMjhKTUVIa0NFM0NSdzd0?=
 =?utf-8?B?cVBzNUoxS3l6a1ZjbWJxWmhmWkx6VTZ6RzRlcFEzeklmbWxjbXptRWZZVEI5?=
 =?utf-8?B?OFFnUWhIdkMyZGFKbjVSMW9wcVlqWTZEWXVydFNuTUErU1M3WGZMNkRqZThk?=
 =?utf-8?B?NG1Idm5VRTFPM0VYS0xUZXFpZmlPKzgwUEpnU2pvU2kwYktibDVyOFBkUi80?=
 =?utf-8?B?bzJJWnJha21PU09kOGJvbCtnMW95V0tSRWxiV1M5cXJmdGxLOThMR0ZLZElW?=
 =?utf-8?B?MEdxd1NEcnpHZlRYMjRXQkdCM1A5U0U1NEVLd29ldVNoRVErZlZJVDRDMEtV?=
 =?utf-8?B?MWNDTkFCTElqTVBBNklmTXhmVU1VTmdpZ1VuOHVIZXN0NFRRZDMxOWVmL1o1?=
 =?utf-8?B?M0pWOWhNZDlzRjdMSktLWU9DbnkwMUt2SFJjTVpJNk1qVWxsS0h3U3l4TmNW?=
 =?utf-8?B?Q21ScGZGeFRGV2lpd0VDdmZudUhpMytraGl1MWVoSXk3ZVJleEI3dWpkUk1N?=
 =?utf-8?B?MTBQL3MzWEJkVTB2QXowVXRmbjFNMmlaYVRTbnhrU2dNdys0WkZNTmV5UjVO?=
 =?utf-8?B?Q01DUVhSQ2VpWXFXRjB2M1pObWVGRVNLN2x4b0JxZmlLZ3JDZGlxbjdUWFlV?=
 =?utf-8?B?d3R1K3dQTFc2YTliV3BOeURSekRHNnVsOXVycTdZTEptWjRnZTU1Z1cxT1BH?=
 =?utf-8?Q?pigrQFHswtOGbcIS0PgFYF4n0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d95fa6-eb45-4e4f-a58e-08dde08edb0c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 08:43:52.4120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvaYaCJbTMyiXw+EOENpUJEnESulZCDQfAMFOfZBnwuv/mPi9waL82Yom7V7LmaN16zjddJWmo8FbqNkEMo82g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8600
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=yi.l.liu@intel.com;
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

On 2025/8/21 15:19, Duan, Zhenzhong wrote:
> Kindly ping, any more comments?

Do you have enough comments for a new version. I plan to have a look
either this version or a new version next week. :)

Regards,
Yi Liu

> Thanks
> Zhenzhong
> 
>> -----Original Message-----
>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Subject: [PATCH v4 00/20] intel_iommu: Enable stage-1 translation for
>> passthrough device
>>
>> Hi,
>>
>> For passthrough device with intel_iommu.x-flts=on, we don't do shadowing
>> of
>> guest page table for passthrough device but pass stage-1 page table to host
>> side to construct a nested domain. There was some effort to enable this
>> feature
>> in old days, see [1] for details.
>>
>> The key design is to utilize the dual-stage IOMMU translation (also known as
>> IOMMU nested translation) capability in host IOMMU. As the below diagram
>> shows,
>> guest I/O page table pointer in GPA (guest physical address) is passed to host
>> and be used to perform the stage-1 address translation. Along with it,
>> modifications to present mappings in the guest I/O page table should be
>> followed
>> with an IOTLB invalidation.
>>
>>         .-------------.  .---------------------------.
>>         |   vIOMMU    |  | Guest I/O page table      |
>>         |             |  '---------------------------'
>>         .----------------/
>>         | PASID Entry |--- PASID cache flush --+
>>         '-------------'                        |
>>         |             |                        V
>>         |             |           I/O page table pointer in GPA
>>         '-------------'
>>     Guest
>>     ------| Shadow |---------------------------|--------
>>           v        v                           v
>>     Host
>>         .-------------.  .------------------------.
>>         |   pIOMMU    |  | Stage1 for GIOVA->GPA  |
>>         |             |  '------------------------'
>>         .----------------/  |
>>         | PASID Entry |     V (Nested xlate)
>>         '----------------\.--------------------------------------.
>>         |             |   | Stage2 for GPA->HPA, unmanaged domain|
>>         |             |   '--------------------------------------'
>>         '-------------'
>> For history reason, there are different namings in different VTD spec rev,
>> Where:
>> - Stage1 = First stage = First level = flts
>> - Stage2 = Second stage = Second level = slts
>> <Intel VT-d Nested translation>
>>
>> This series reuse VFIO device's default hwpt as nested parent instead of
>> creating new one. This way avoids duplicate code of a new memory listener,
>> all existing feature from VFIO listener can be shared, e.g., ram discard,
>> dirty tracking, etc. Two limitations are: 1) not supporting VFIO device
>> under a PCI bridge with emulated device, because emulated device wants
>> IOMMU AS and VFIO device stick to system AS; 2) not supporting kexec or
>> reboot from "intel_iommu=on,sm_on" to "intel_iommu=on,sm_off", because
>> VFIO device's default hwpt is created with NEST_PARENT flag, kernel
>> inhibit RO mappings when switch to shadow mode.
>>
>> This series is also a prerequisite work for vSVA, i.e. Sharing guest
>> application address space with passthrough devices.
>>
>> There are some interactions between VFIO and vIOMMU
>> * vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
>>   subsystem. VFIO calls them to register/unregister HostIOMMUDevice
>>   instance to vIOMMU at vfio device realize stage.
>> * vIOMMU registers PCIIOMMUOps get_viommu_cap to PCI subsystem.
>>   VFIO calls it to get vIOMMU exposed capabilities.
>> * vIOMMU calls HostIOMMUDeviceIOMMUFD interface [at|de]tach_hwpt
>>   to bind/unbind device to IOMMUFD backed domains, either nested
>>   domain or not.
>>
>> See below diagram:
>>
>>         VFIO Device                                 Intel IOMMU
>>     .-----------------.                         .-------------------.
>>     |                 |                         |
>> |
>>     |       .---------|PCIIOMMUOps              |.-------------.    |
>>     |       | IOMMUFD |(set/unset_iommu_device) || Host IOMMU  |
>> |
>>     |       | Device  |------------------------>|| Device list |    |
>>     |       .---------|(get_viommu_cap)         |.-------------.    |
>>     |                 |                         |       |
>> |
>>     |                 |                         |       V
>> |
>>     |       .---------|  HostIOMMUDeviceIOMMUFD |  .-------------.  |
>>     |       | IOMMUFD |            (attach_hwpt)|  | Host IOMMU
>> |  |
>>     |       | link    |<------------------------|  |   Device    |  |
>>     |       .---------|            (detach_hwpt)|  .-------------.  |
>>     |                 |                         |       |
>> |
>>     |                 |                         |       ...
>> |
>>     .-----------------.                         .-------------------.
>>
>> Below is an example to enable stage-1 translation for passthrough device:
>>
>>     -M q35,...
>>     -device intel-iommu,x-scalable-mode=on,x-flts=on...
>>     -object iommufd,id=iommufd0 -device vfio-pci,iommufd=iommufd0,...
>>
>> Test done:
>> - VFIO devices hotplug/unplug
>> - different VFIO devices linked to different iommufds
>> - vhost net device ping test
>>
>> PATCH1-6:  Some preparing work
>> PATCH7-8:  Compatibility check between vIOMMU and Host IOMMU
>> PATCH9-17: Implement stage-1 page table for passthrough device
>> PATCH18-19:Workaround for ERRATA_772415_SPR17
>> PATCH20:   Enable stage-1 translation for passthrough device
>>
>> Qemu code can be found at [2]
>>
>> Fault report isn't supported in this series, we presume guest kernel always
>> construct correct stage1 page table for passthrough device. For emulated
>> devices, the emulation code already provided stage1 fault injection.
>>
>> TODO:
>> - Fault report to guest when HW stage1 faults
>>
>> [1]
>> https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1
>> -yi.l.liu@intel.com/
>> [2] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting.v4
>>
>> Thanks
>> Zhenzhong
>>
>> Changelog:
>> v4:
>> - s/VIOMMU_CAP_STAGE1/VIOMMU_CAP_HW_NESTED (Eric, Nicolin,
>> Donald, Shameer)
>> - clarify get_viommu_cap() return pure emulated caps and explain reason in
>> commit log (Eric)
>> - retrieve the ce only if vtd_as->pasid in vtd_as_to_iommu_pasid_locked (Eric)
>> - refine doc comment and commit log in patch10-11 (Eric)
>>
>> v3:
>> - define enum type for VIOMMU_CAP_* (Eric)
>> - drop inline flag in the patch which uses the helper (Eric)
>> - use extract64 in new introduced MACRO (Eric)
>> - polish comments and fix typo error (Eric)
>> - split workaround patch for ERRATA_772415_SPR17 to two patches (Eric)
>> - optimize bind/unbind error path processing
>>
>> v2:
>> - introduce get_viommu_cap() to get STAGE1 flag to create nested parent
>> hwpt (Liuyi)
>> - reuse VFIO's default hwpt as parent hwpt of nested translation (Nicolin,
>> Liuyi)
>> - abandon support of VFIO device under pcie-to-pci bridge to simplify design
>> (Liuyi)
>> - bypass RO mapping in VFIO's default hwpt if ERRATA_772415_SPR17 (Liuyi)
>> - drop vtd_dev_to_context_entry optimization (Liuyi)
>>
>> v1:
>> - simplify vendor specific checking in vtd_check_hiod (Cedric, Nicolin)
>> - rebase to master
>>
>> rfcv3:
>> - s/hwpt_id/id in iommufd_backend_invalidate_cache()'s parameter
>> (Shameer)
>> - hide vtd vendor specific caps in a wrapper union (Eric, Nicolin)
>> - simplify return value check of get_cap() (Eric)
>> - drop realize_late (Cedric, Eric)
>> - split patch13:intel_iommu: Add PASID cache management infrastructure
>> (Eric)
>> - s/vtd_pasid_cache_reset/vtd_pasid_cache_reset_locked (Eric)
>> - s/vtd_pe_get_domain_id/vtd_pe_get_did (Eric)
>> - refine comments (Eric, Donald)
>>
>> rfcv2:
>> - Drop VTDPASIDAddressSpace and use VTDAddressSpace (Eric, Liuyi)
>> - Move HWPT uAPI patches ahead(patch1-8) so arm nesting could easily
>> rebase
>> - add two cleanup patches(patch9-10)
>> - VFIO passes iommufd/devid/hwpt_id to vIOMMU instead of
>> iommufd/devid/ioas_id
>> - add vtd_as_[from|to]_iommu_pasid() helper to translate between vtd_as
>> and
>>   iommu pasid, this is important for dropping VTDPASIDAddressSpace
>>
>>
>> Yi Liu (3):
>>   intel_iommu: Replay pasid bindings after context cache invalidation
>>   intel_iommu: Propagate PASID-based iotlb invalidation to host
>>   intel_iommu: Replay all pasid bindings when either SRTP or TE bit is
>>     changed
>>
>> Zhenzhong Duan (17):
>>   intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
>>     vtd_ce_get_pasid_entry
>>   hw/pci: Introduce pci_device_get_viommu_cap()
>>   intel_iommu: Implement get_viommu_cap() callback
>>   vfio/iommufd: Force creating nested parent domain
>>   hw/pci: Export pci_device_get_iommu_bus_devfn() and return bool
>>   intel_iommu: Introduce a new structure VTDHostIOMMUDevice
>>   intel_iommu: Check for compatibility with IOMMUFD backed device when
>>     x-flts=on
>>   intel_iommu: Fail passthrough device under PCI bridge if x-flts=on
>>   intel_iommu: Introduce two helpers vtd_as_from/to_iommu_pasid_locked
>>   intel_iommu: Handle PASID entry removal and update
>>   intel_iommu: Handle PASID entry addition
>>   intel_iommu: Introduce a new pasid cache invalidation type FORCE_RESET
>>   intel_iommu: Stick to system MR for IOMMUFD backed host device when
>>     x-fls=on
>>   intel_iommu: Bind/unbind guest page table to host
>>   vfio: Add a new element bypass_ro in VFIOContainerBase
>>   Workaround for ERRATA_772415_SPR17
>>   intel_iommu: Enable host device when x-flts=on in scalable mode
>>
>> MAINTAINERS                           |   1 +
>> hw/i386/intel_iommu_internal.h        |  68 +-
>> include/hw/i386/intel_iommu.h         |   9 +-
>> include/hw/iommu.h                    |  17 +
>> include/hw/pci/pci.h                  |  27 +
>> include/hw/vfio/vfio-container-base.h |   1 +
>> hw/i386/intel_iommu.c                 | 941
>> +++++++++++++++++++++++++-
>> hw/pci/pci.c                          |  23 +-
>> hw/vfio/iommufd.c                     |  22 +-
>> hw/vfio/listener.c                    |  13 +-
>> hw/i386/trace-events                  |   8 +
>> 11 files changed, 1088 insertions(+), 42 deletions(-)
>> create mode 100644 include/hw/iommu.h
>>
>>
>> base-commit: 92c05be4dfb59a71033d4c57dac944b29f7dabf0
>> --
>> 2.47.1
> 

