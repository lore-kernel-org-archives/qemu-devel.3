Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837FACD4F5B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIFW-0001eJ-NW; Fri, 22 May 2026 01:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQIFU-0001dp-JU
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:16:40 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wQIFR-0008W3-Ne
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779426997; x=1810962997;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KuRpd6xrWvAeIOhZx+9EtsZajA7mc7ggF51A+OCIUaw=;
 b=Wn2CohkxLM+0b3JfDRnmX2th+lt0ya7YlqmwlVNOqUYvABLZ8YjVz9YP
 wItn0KTdUq7Q7dU+2TG54EZnzAu6ib8kuZa1WTa0ayeq+iFWVG8+mBnyh
 SmFr2T8TvUSHZ5NBTLkL8O6Uj3Q2P/P0hEmM0vdLrJ21CmMOl3bATGguX
 N87LCMweiiikBxnWQ5cUgDweMzGSqirOFxgRh4bKCXxYRDPAZOOQBqc8g
 bCMIAVM22ndOKZxo1WQYE3Ht35VUZK/boXpiUwEE032/d39vVpKA+RqoG
 RmOC4Egpx3+hLJrqY83Yjf/lnN4a1Y7+NoQQ4e3ZmXNSyZmAdDLYwLOMI Q==;
X-CSE-ConnectionGUID: 6ZelofSCSraGyO2nZTn8Eg==
X-CSE-MsgGUID: liFuPJNyRuKDNQR8mbywVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="91462923"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="91462923"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 22:16:35 -0700
X-CSE-ConnectionGUID: pwPe/9M4QNW7B2yxvML2hA==
X-CSE-MsgGUID: r6DTdc1cQ2WGwItjp/xPAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; d="scan'208";a="236566283"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 22:16:35 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 22:16:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 22:16:34 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 22:16:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOFkSAmdDRS07LrGvzrR/EPZpkt/cidFDAy1poZAssew2PIM+fTakDwiErj0zEJUTGOdUCKIFohJbe7R7NudhJ4C8l1XY9d4hgvHHwzX29GvoSA/ftd3bSBtvHv82HorW3Je++iH6JSdRnIPsBcQ/GtulQwBimVqGY0nZRetoN0TgkwKrZ/PvpnlJBu0ru1L0XYvFWf25e01VZ5q7AaNDdjixP7eCrDHjyeszYkkDApYIlLh1DuPFYexq9n2AQLoGAGXa8gPG7nFEldK++7HC4Egk4tc6e3fHsjOA1QW7ITVUejPp1DbK7q6BBjO1pWBeJxEoGXprXMRwhElXtIb5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6Uys9dN1l8lLHdIA0E2WIUwhcSfAZ29ynXHzIoABqU=;
 b=KVfjFRrWzW+9lI2dHqj9f/uojchPrH3aSuOiTW2Q5MFdqhMyEdLLv7zQi1EqwpIlcwtApiMA1G0EdJqbtTHs01N3umQup5HTfREgXGFE3UZGHf9Xg4woud0BNbk1s9ffVgA/7CySC/NkTmWNu+1/izlrnbt2kDcZdvc8rRkybTOnJ+Axsd7mtQPUFzG5c3og1LDcehyDUAKA/n7CGfUaRfHHDylqxcQTGiFgeLwGRvYH93vNUGuQLAWVJxDjisPZbNrFhicfA/5dPf39q3mAcPPiLZNjHR4xeKkIK/DfxoneI4/KwJWa1nRttzoXNK6v/8hCCwoVpFDTaUmQTn7+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by PH8PR11MB9534.namprd11.prod.outlook.com (2603:10b6:510:39f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Fri, 22 May
 2026 05:16:25 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 05:16:25 +0000
Message-ID: <7bb33397-20a1-42a4-a2ee-3537295141f7@intel.com>
Date: Fri, 22 May 2026 13:24:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/15] intel_iommu_accel: Handle PASID entry addition
 for pc_inv_dsc request
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-10-zhenzhong.duan@intel.com>
 <44c1dd56-a37a-42ca-b8f3-9ac69aa1f33b@intel.com>
 <IA3PR11MB9136BDEC87472A1BD0E93B09920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136BDEC87472A1BD0E93B09920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:d10:33::15) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|PH8PR11MB9534:EE_
X-MS-Office365-Filtering-Correlation-Id: f01af0b5-fda8-4026-801c-08deb7c1452c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|42112799006|376014|11063799006|4143699003|3613699012|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bKMDbWOmjLs4FGa67TOpeVbWI8Utn0Iao6ebUfEQg7x23qnyvP70gT9s9IG3uPDXVDdEu/4t01CdW3hy3ihWwBoCXxnXmHRkr0kvUoFJj/hXbmeHM7d5QVDvruszGcmPK+u1V/u7hzqoqn+0mZsBCQ65Svj4N+nblz4BUeYLBBtmrQ6nornicXLaMuwOvCICHBAzx/tskNkO8o+qFVMOROle02vbDBDQ13JkYwUAp9Kmz8mKdlN2b73wuEfQQRwDSjpRIg13g1C6BdQwGY+ZwPSiqYVH+g9yvAd6kSG8oLNlyKd8HHB/ESjtjVh6lIva2WyPieGWYKxGXcTX7gdOx9F1GsXn5Bs7Th6f8TzQoOAjI4xkOfslqzoTLJGpgriUwcfewhyI50IQ1aKEErVophSYpZr4kxgseeGvWgxJhnbYUktcAUaW3hovrCawEY2HbBzxkgSiM8fi28fphVYOMU0j+5axn7BCofs0iWQQBuWiL7LrySxMQ9s1ZauhQRSjJ58DnaQifQlfLVa+f7kHkC8QKy56wzqrt+7DOm/z3pd9/li2MKe104pU5JZzIaa/TyRgm7QQvg7g7BgxOZSssSP3vOVk4WwhnBTL8DfZgkvDJ89yXo0q8o03zs/MbYqMVeAcy7yRFjZH1xaYMLPvQpVD7ca4QKT2wPYK/tK4FiS3YySyKFvOlARCsk+Xf4v3o+mPeZJASUXUyCsYaSmZ++JIBnBrjvKp/dRiR7yFgpt/oMpe4QmhfmLBo7ePFxeY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(42112799006)(376014)(11063799006)(4143699003)(3613699012)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnZMSmxhYlJxUmJPUjNRZVhQdWRhSzNkckw5Tm85Vk5TN2NOTklHQVI0bmlq?=
 =?utf-8?B?RlFzTm9GS0t3emxoTjJ4M1JEZGdqK3AxOXZjTWc5OVZlRFdmWXJDK3h5ajhE?=
 =?utf-8?B?MlJCSmJ4OEVEcC93Nnd4VXlPUitSTTZTb2F1d1V2UVdkNlZBSDZ1VTFoNys1?=
 =?utf-8?B?WHNCM3VWK2NnUTAxaXlKTmE4RXBid2RBQzJBanlZanIrTFhOWURaWmNyL0Zz?=
 =?utf-8?B?cFNDMkx1TGZvMWpoUENEeWlCY3U0WGdEWWx1K3c5Mi9lRjhnMVFBQjB1bjRw?=
 =?utf-8?B?K0xlK3dKVEliRFJkbldWNHhhUENVS2FFVW9lRHE0cmZZWGExOU9oa0RFd05Z?=
 =?utf-8?B?K3ZSN3VsMUI5SUZlMUh4QWhwV0NSTWE2TUlmaktIMy81WHpUeFQ0bTUyOWU5?=
 =?utf-8?B?T0d3eG5ZbVZLMGw2VitDQmU2TG85SXZXdHVvV3N4UVJ6TERtS205OGtYQnZ3?=
 =?utf-8?B?VDZ2eGthM3VzU2J6VTMvVXE5aGRRWEcrVkVTWHlwR2l0WGRGb3F2UkVOYXM1?=
 =?utf-8?B?T3hNNFRwWHkvdVltR0cwODB2ekUydlNSeXpLL0dxcVFDdGM5RVphT2lsWnBE?=
 =?utf-8?B?b3NOeWorUVFvLzdTVkZpcG9iSVplVXU0OXFaVjB5dW5XNmdEdXYzWWVtUzVR?=
 =?utf-8?B?SUVxbzVtV05XL2QrMzdjU2VyV2J4NHIxb05lOGVUcTZMbGdzbkkvYzltL3dZ?=
 =?utf-8?B?OHAyWnRTWlpvLzQ4c2UrUmpBTmNxbDdOZnBlb2poOXFnaVlyL0hZQ3BsSERM?=
 =?utf-8?B?NHRmbXh1Ti9aN2tRWHhxbXZsQ01QNTl2TkU4SjNEZllORnQwUnZjQmIrRkdr?=
 =?utf-8?B?RmwyempKRXNBdE14TUJQWFBKdzU2Yjd3R1BUcVJ3NUpNRC8yNVN0dHdOK0hz?=
 =?utf-8?B?VGUrVVZBb3BoZjVGZ1o1TFZXRmlkQ2NPUk5NQ2RHOStqbG9PVkpsRG44TXlB?=
 =?utf-8?B?ZjJJSE5kRE1XWGJBb2N4bnA5Q3Izbk42ZDVVb1ZUS2NHSVFEK2Y1b00zTm1E?=
 =?utf-8?B?SEdubithd2RqczZrQTBTYUNDZFZ3b0ZmU1RrOUFVMUM1Z1VFdmN4QlpYd2w5?=
 =?utf-8?B?QkJLVUVPMFJQUlExcmtQOGlsVlhKVjRDaGlicUhLTWVjMWxrNGNCQmlqWEx1?=
 =?utf-8?B?OGFCYUkreWxQamRpUGowcVZMbkIzSDhaQ2cyeTVmUENnak80QjNiYXQwaGhx?=
 =?utf-8?B?dDFBM3NodC9VdmpEZ0dYenVXazhLZVlmaVdrZngxbWVjUFRndjh5SGVnVW9a?=
 =?utf-8?B?VXllVXRhUWNvOVQzcUdIYmpZMjk3aDNCcnhMUFl1Y2dzTHIzWUtneTJUVGFr?=
 =?utf-8?B?cFZzNlUxcndRT0UxZVJhNm5nd2dvK2FNSC9KVGwvWktBdkFsTEt5Y3Y3cWc1?=
 =?utf-8?B?NVZxQ0tLOFFmRlRDeWdXQnR3VHRoTStIM0xjdmZmdzE5TFVqMW5tZU82T2pn?=
 =?utf-8?B?UnNUL2xZa2dMTGtEUGJ1QXpXTGxqWUxQUjNIOVUrdldNNUxCblVlL0JtTlk4?=
 =?utf-8?B?N3RlZDNxem1GZFpiVnYvREloeWxGOVpqVnJYL3M3WFNCbTR6N3FNZjFQWjVv?=
 =?utf-8?B?ZkNOZE52WGg2ZWFHckVsa09rSXVYTC9SNkk5YkxIN0c5NzJhaDczN2JrQk1C?=
 =?utf-8?B?TTNuL2NiTWpmVU1QeFJpR0RkanFDRGhBY1NYSVl5YUpJdEdrU2dqOTBYNEtE?=
 =?utf-8?B?UEdTYm84Y1RHOGs2eEhZYS9FRjBId3ZzZXVHYUEwY0g1L1BaY2FkZTZ3Qkhz?=
 =?utf-8?B?ZzZWQjdlTzFOcEpSR2FIYlYvZXBqQzVoaUNJVHJxbTdqdUpJZEhVM3lqa0Ns?=
 =?utf-8?B?UkR4NXNVQWs3aERoOG5LaVc4Z2FqUm8zZUJlZlJWdlF3STF2RFRENTF6UmN5?=
 =?utf-8?B?d3JORk96Yyt6TFZmSjVTVnBNOVA3WEtDQ0RzYmhXV1Bkd1gxbW9SVEl0WVds?=
 =?utf-8?B?TGcvUE9mVVV4Ukp6TzdvZnM3RURjb1NENzNyOGJKQ0o4RlVldHFweDR3emFR?=
 =?utf-8?B?Ym8zSE01MEs2aDRUcXZFOVBLc2hZYXI4ZVNoVzhSTHUwYnBuT3hTVFJYVnht?=
 =?utf-8?B?RDdESnhVYldIaTVaek9LNE00Ni93bzZia1BhZnBtN2xneFN4cDV5ZHVEVEJH?=
 =?utf-8?B?dDVNTUxndEZ0anJNOXdscExKamY2SENLUGFTVWtCL0xzVjdTbC8xRGZmcEFv?=
 =?utf-8?B?WTFrYTVlMTJiYVhTWENrdVNvdmZscGM3ZndVbmhjZ0xSSkkzRW04L2tpcFVG?=
 =?utf-8?B?TVRTNytIWTdocGhuZHNyYm50WTJSOVgvdm5xTXdMWno2a1Fsc1V3bDlYZEhl?=
 =?utf-8?B?TW5Gby83em9BaTh5NTlWNkQ3YXN4aHVBenpLVGMzU09yNk8zbCtFZz09?=
X-Exchange-RoutingPolicyChecked: I4gXlC6pVhyj6RW7hC+YyuSqSSRl9FSRCQEpVLm+MDLC56+9WIGqM8c0h4qkRrJmxAWzrtPKt3J3NuKnyCcE4Am7rjwAl3UrtUpPg/Y6jfLka0S5qQEVaPYrYZ/On4sqAAMEXTnP0vT9wUYW6zeaULq1Wxe3jg6+gDCzJOTXYcaWcIAszflQVMqqa3pWp3Svhsb2bdFwEehVqnHRTvqs/cwL/Q+vxyBICMHCFf5zPy7xht8mtII8p4IabbmX+hT0o/utctgm+Hv1Zgp2BkVLfCT0De8W1jub7RzCOB/99PGKCaCtO3c5JAUc5QQxv0b5Oc7eLApAJiH7z92iZBOe7Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: f01af0b5-fda8-4026-801c-08deb7c1452c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 05:16:25.3765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZ5/7I3lbupsV0ZBXrTtTVW8wP6o05ilV1Q7ORK5vI4+kXlpI+uVaCoOeEOJ5Ucx+i9QYFShWLBx13nsAbyvlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9534
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

On 5/22/26 10:44, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v5 09/15] intel_iommu_accel: Handle PASID entry addition for
>> pc_inv_dsc request
>>
>> On 5/9/26 12:08, Zhenzhong Duan wrote:
>>> Structure VTDAddressSpace includes some elements suitable for emulated
>>> device and passthrough device without PASID, e.g., address space,
>>> different memory regions, etc, it is also protected by vtd iommu lock,
>>> all these are useless and become a burden for passthrough device with
>>> PASID.
>>>
>>> When there are lots of PASIDs used in one device, the AS and MRs are
>>> all registered to memory core and impact the whole system performance.
>>>
>>> So instead of using VTDAddressSpace to cache pasid entry for each pasid
>>> of a passthrough device, we define a light weight structure
>>> VTDAccelPASIDCacheEntry with only necessary elements for each pasid. We
>>> will use this struct as a parameter to conduct binding/unbinding to
>>> nested hwpt and to record the current bound nested hwpt. It's also
>>> designed to support IOMMU_NO_PASID.
>>>
>>> VTDAccelPASIDCacheEntry is designed to only be used in intel_iommu_accel.c,
>>> similarly VTDPASIDCacheEntry should only be used in hw/i386/intel_iommu.c
>>>
>>> When guest creates new PASID entries, QEMU will capture the pc_inv_dsc
>>> (pasid cache invalidation) request, walk through each pasid in each
>>> passthrough device for valid pasid entries, create a new
>>> VTDAccelPASIDCacheEntry if not existing yet.
>>>
>>> IOMMU_NO_PASID of passthrough device still need to register MRs in case
>>> guest does not operate in scalable mode. So for IOMMU_NO_PASID, we have
>>> both VTDAPASIDCacheEntry and VTDAccelPASIDCacheEntry.
>>
>> The implementation LGTM. But I got a question to ask here.
>> VTDAPASIDCacheEntry is cached in VTDAddressSpace, while
>> VTDAccelPASIDCacheEntry is cached in VTDHostIOMMUDevice. A natural
>> question is why usingVTDHostIOMMUDevice instead of VTDAddressSpace. I
>> think it might be valuable to mark the reason of this choice. This
>> would help maintaining it in future as we might forgot the reason. :)
> 
> Hmm, you mean why not putting VTDAccelPASIDCacheEntry list in VTDAddressSpace?
> There is explanation above, paste here:
> 
>    VTDAccelPASIDCacheEntry is designed to only be used in intel_iommu_accel.c,
>    similarly VTDPASIDCacheEntry should only be used in hw/i386/intel_iommu.c


hmmm. code isolation is a good reason. Is there any other reason?


