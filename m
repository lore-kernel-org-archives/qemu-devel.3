Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653FC10BA422
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5yi7-0000yO-J7; Fri, 27 Mar 2026 00:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5yi5-0000xS-FN
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:22:13 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5yi3-00053K-Tb
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774585332; x=1806121332;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3Ii+lNz2a5doEPma4mel8NGEygkl4jiK3EcDplZjx/4=;
 b=ScIeFCPY3LNUFLFI77JLi7fE8WW9yhUVcwzMRNlmkJWtiBAgSOaO+HQ6
 jJpq2gWrSVKJgCQ/usjlos+RT1Y+e1DMNtcwOGEqT9qIlq82IxuKRpd1c
 1mgkVoQmXvKU15d5QX3w0oiYc88n3zmbkkuySpMbAZgCSZ72A9jB/dsfi
 5dfIS5qvoyReaPQSEenUjzxNLD8qgiLv40vTOvEr5KV5L2VJpMC09OwVf
 Nn2GcfFsysC3QFRboFFxcTHxXx+f5+GUiC/Qtv405f58OvmoSbnmPTRBb
 4BBGXU6rwCcCG5VeO+XQVmovkz1hd7RkmXrY6gyFMDu3hJrfO736cfAg8 w==;
X-CSE-ConnectionGUID: EiJM1meYTAG5XddUUGN/SA==
X-CSE-MsgGUID: TPi0guwiS62uwiqA1QQbwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="101114969"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="101114969"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:22:09 -0700
X-CSE-ConnectionGUID: fCbfE86aQGixjh4are/GHg==
X-CSE-MsgGUID: 9T0gNqN3Ry+2VZwELSZjDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="221889820"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:22:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:22:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 21:22:08 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:22:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XM/Hw4DivGW+u8K5Qfvjp7ob+idbukC2gXIIG1A3P5a9D1jUdbfCaxwm39E7zhAq3holoLxJLxDJu+Z7exIS6qaDTrYMEnworfphJ8uwmmZu2v0z9vxK9gtV++dY/p+RZDtUpKqeK147oEMGz1kl4nHKN3u1pRouiJZrKPkt2QXMWEwAKD2mO2rWDDgkSx/tKibxhCriHsgahpvdj5tfFy3uVgu19xxH0ZDbhAh0EUa/8p5BID+kHbUqPd1goZNN9yA9pSuNCgCYdfyh6jkRwOVps7CCdPijrgF5dHto25+Xi7qvhqJQBnW0yXLx2DvtQStBjc3EBTVNZpMkHxsbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlOxRxbSuPZ0dK1yqjUrd6ip4y9RZ3/Z0GBBkzpe3Jo=;
 b=YiZZWYWxHUBeNqWuv5c2C7PdoQqaydAZi877Lv/Dycgnu6ILnHcaz2+NrpdGjn6wycKWR9mk5cW3NzRQ6Lfads6xgknIqL0r1AvHe6N7DhvkW4LtOGyWLusbx71ztAyaQGd71z8UkwM9R/zghVfAAyZYtupdywQsFGxC2LYqIapOIPCi7HjfwfniQlCLeONZ7NFWMfKDBX/nfWsuV4mUsL/bE6B7KFSoRO+hwIzbEkLx5Bur3D8fhE5FC1L1mTJv32Y/exaLK2Dx2aVezbZ9o17LNzsg/rZg7bY1M0Ivu4oKQtJ+xQa2ZM8Qxxlm/Jp2Ms7YCZpi2wniRS+VW+zebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA1PR11MB9614.namprd11.prod.outlook.com (2603:10b6:806:4c4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 04:22:03 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 04:22:03 +0000
Message-ID: <5cd0604b-15ff-492d-a4b5-7959476c06f7@intel.com>
Date: Fri, 27 Mar 2026 12:29:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260326091130.321483-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0058.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::17) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA1PR11MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e689ec-895e-4a40-be12-08de8bb865bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|42112799006|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9LltYepBR6Lc9rtWRWUz44abSxsfLn87pzsEjGHAjfg8LXnK68PkmHZYLThc1+FgkH4ZTlaSKO4rZIZ7p/WgYFTHXD+RAZLVjg1PhOWoayjizHmFikKSgE0qkSoTPNCokUmfaaE2KCywZNlVcs9TzOgWyWGWZE+sz4ncxr6iGrS89ZtssqNoRtRKQ7IKdVD00vZCWCGi8Az77DBY/ZGXkGtfal9yNvxnjrrghhau1I3xe2rTg/Rc36YI4sDo8oXTHf6okQUWw9Rb5RqL5dyow5Agalk9lnxnLTfF/g6FMCGgSflhDV3x2oitQSKsWgbyA9HDc6x907vKeQnMblqoe95eNn6iWlUmTb0UqjwclmvxhpYyfo9Z48MjxgwDgRNaPB0ufPWSc2oTajqvCbisXdi6EZP23JgIxZ66eOzqmymtJBDLUFYq6ldqhTYo8WZ1tgWnqxeeO475y8+LlXD57yMzoeoBdEBUOqLouRWnPFDcSbfovIxk8VOyoRlRuJCmCVPdUhq7aZHL6l8v8cMtPTmX+19mkalzgRBkWz3a0aJnqRtFCTWjKagzyTvhvWtXv/imdINUBUsUENomoO5mRo7ZXrjoCd/RLZ235XDFF0PG9UwNarp3bSXg/Rx0Q+J0zymEZUAy02AQnkO5h77eQBGoQV+D0kS1DrLbPZQmEFeP0ukqWJ8M6B8U+n/yKYsh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(42112799006)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk5oL2E4c0ZLSzZCNmlaejFwTE5QVEovaXRud3NlUEl1NjFnUDdTRExRZnJ2?=
 =?utf-8?B?Rm91T2w0RnFDUzk3TzRJSmdaSjBjb3hDRHA3SUE0QVVycUxERFNtUy9ZdGw1?=
 =?utf-8?B?Y3o1V25tMi9QellXQ3FZVDNwMHh0NmRHV2VvanY3ZmFFK201MWNJaXNvZHBx?=
 =?utf-8?B?dDluendvOWlwN0dFN2ppbWR5TjhxMWJPTUlPV1o0amNvTEZ6RldYSFBJSThB?=
 =?utf-8?B?cG5QNmJxM0F6Y2xqbktYU2IwWlkxQ0NqQUltL3JZMzJHSGhyeEtCSFlRa3JJ?=
 =?utf-8?B?dHVUNEhmNzk2eUxKMFptbW9jbTNWcGJyQk5obWJycEFpTlFsZDZLVDJoL0xp?=
 =?utf-8?B?NStKY2lta0FyQ0dwTUE3VlFhN0lUQ0VMRWNtcS9FNWc2K29JVndzbjFRaTI5?=
 =?utf-8?B?N1phckw3WGx1azZVeU9nZ0tOWldvVnRxL21jMU5IaDVQa2ViTmY2bG9jeDJY?=
 =?utf-8?B?V3g3eWltRTN0aG42OFdwZkhlTFJ4eEtRWFlWL1BublBSb0NLbnRvQlNmL3F0?=
 =?utf-8?B?OXhrNU4rS1FoV2lBVGVGSkY4dURzaFdpalBlWXoxT0xLQVlOK0VvL2FCVDg5?=
 =?utf-8?B?aWIwY2pLbGRURHB4K1l5Z0tnbTdqNllud1pMUVUyM1B5SVR3eUtvckxrcktl?=
 =?utf-8?B?UkR3NmZWaXhOcDFMazVDakZDZXMwa251bHFqZlZJQ3NYSXdCdXF3WTY2dGkx?=
 =?utf-8?B?RWNWMXR5VHpqbWNNblZKVWxjSkJiWFY1OEhxVDRNN1FjZ01NbldSK0xGSnJa?=
 =?utf-8?B?ZU0vMzdzQW9HcjNZSDJMRzZUSmRpaHZ0TEFWaDhvbmVTa0s1UTVTUHh4QWEr?=
 =?utf-8?B?bmxpbm44YWtGeTVwZzl6R1VFTy9KNmlvbkZhajFJODVRKy8xVjJ4Z3k3QUY1?=
 =?utf-8?B?UDVXaHdpWXFaRmhlNnRBam5BbXZ3VlpkNitiMzZBQ283QTVIT1JtMTJucFBt?=
 =?utf-8?B?Rm9JbzBUVHVneDYybk4rRkhSYlJRejZTWE5TUEgxQVExMTJldkNiZmh1WXIz?=
 =?utf-8?B?SGdtWkNCRGZuc2o4ZXN3RjVDZEtNMi9xWXVzRzRXOHg3eEF0bHhUeWxOV0pV?=
 =?utf-8?B?aWh2ZnU5N1g2d2lGbTdUdW9nMlczR0k1TGtJM0ttRktiNnloeXMxVWZtS0Er?=
 =?utf-8?B?YkdldkNhVW9TdEI2SENqQ3FuL1ExSzc1VndUKzlSNk1BcVRNbE1tSW0xK3pm?=
 =?utf-8?B?T1JveTdhRFZOVHNNYkFGa1RZVXR3NjNreUVhakgrQ2lxSUhVQnB1dllTR1hz?=
 =?utf-8?B?NEk4SzFsQTRsbHUra0c2QWZ3WGtpd3NnU1F2MjRMUmlINThhSlZvcStjZjFC?=
 =?utf-8?B?V1cxZUp4Q3hycUwrcEprR3l6eG1JRkJUUHl4V21pWW42RTUzSTJUVU1MdUM3?=
 =?utf-8?B?U3g4Y1UzeS9LK3hBOG9pVUtpQWFpc3Z5ZjF2YXMwTkxJT0tlZUw5Qm8ycE1T?=
 =?utf-8?B?TUVxanIwb0VmbzVmNE9WbFFNMGxmNDZFcHV5MGd5bXFSbSsrVzM4a3hRZEli?=
 =?utf-8?B?emVGWWZiVUlkdHNKSmphekpJRktHa3BJUzQ4c0VnYVhENkc1TDNRaXNJQ2dj?=
 =?utf-8?B?cy8yQmFLZC8vd3FDSElKT0tQVkVXYi8yRThRb3ZkNVg3SHRNSG1QSTcvSWh1?=
 =?utf-8?B?cWpMMXBFQXlFVlYyaVdmOHpDTlVyT2hpTmNyTy9EZjRGQ3Y3ZUZyc0tQVHRn?=
 =?utf-8?B?SEpNSFhRejNMNzZuOEdxdEVkNHl4WEtyYTFBZ1BYeXNoZktReXFDNUJ5UWhW?=
 =?utf-8?B?WVFiR0pUSzBjN1JCa1V6OVI4RktDZlRTUHZLL29rY2NodlVqVXRYVXJYM0gw?=
 =?utf-8?B?c3I3NHB5RUduOGd4SXRIQjh1Y2VLeHBiR2w3UXhybmdzMElIdWFhTEhKY3dC?=
 =?utf-8?B?bThCcHZ0K3VYYjhBVFliemRFSUh6a05FbkV2dmc3dHEweXVtR3JOZVdCVGpr?=
 =?utf-8?B?VHZENS9xaDVDeGZtNWl5cFhHaEtGZVEvMmM2NGZsUUx3UjNjbmYyaGJQZ2NU?=
 =?utf-8?B?TXl0M1hBQS9pZzQ5dndDcmJNWElyMUJneVdJYjVUVU1hUkZQczQ5YUZIeVlm?=
 =?utf-8?B?a0YwRk5YTThEakNFV1pjRjk0QXljYm0wOEorejhzckVtLzhSaHloR3ZvQ1BQ?=
 =?utf-8?B?ZTVpMnZkOEFqUDJkYkhvWVJuV2FnY0tycFptM0cxc3NzNTZNdHNPdzc2YS9D?=
 =?utf-8?B?eXFBMmk0RTlpNFZSbWNpU1hIaXlRaUpYU2dTaExKSGNibjY1YXFVV2JnV3Mx?=
 =?utf-8?B?SlA1NWxnREI2TUZZc1BrUXcwRWo0TnZzYzVTajZRdHVqWnE0R0ZPMlNYbmF3?=
 =?utf-8?B?WkwwcWFXTzF3SDg2dUcxMTNuUXdIM1AxKzZnaFFvYytLUlA0N01ZQT09?=
X-Exchange-RoutingPolicyChecked: kelLvYiPdDfkUf0xvSUr+fRvsYvt6Pz8DuUW1XSu8pjFMKyYbPvqTzrL9+SJ6Sg9XgIqKTht7RleknKEqmd31eeSTxp+7mSTNQA9vPvo5ZD0E/6XokgfDlEOon+Xv7nFJ1QFYWSgGg0yWqYV8epu5u/BZW09RUCAUFBYf0W0y73yqm0PK44idKi1+gv4bkNDQVdMEU/C0h2r8vIdeWGdGJcgbiZqeg+6W5qLGVsQ48lTaPNnPUVaWNi/KQnBpNj24UhuBFMhlwB9PlH/TbbqKE87PEx7jrXbxjpcEjH+mmRaoCd/6UITd+OSSFCcVbRPn9nYag3rdQLYc+MYQtO45g==
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e689ec-895e-4a40-be12-08de8bb865bb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 04:22:03.3129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4yXm01Aqwj9tOuB++NokDVzbpgr5XooqOE4R26Avyg2Rb1vhMyMdVSF4lDsh/WCpaAAzher+dl0CcCxSEld/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9614
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yi.l.liu@intel.com;
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
> When both device and vIOMMU have PASID enabled, then guest may setup
> pasid attached translation.
> 
> We need to create the nesting parent hwpt with IOMMU_HWPT_ALLOC_PASID
> flag because according to uAPI, any domain attached to the non-PASID
> part of the device must also be flagged, otherwise attaching a PASID
> will blocked.

echo the comment on the commit message.

https://lore.kernel.org/qemu-devel/a33c785a-ab94-4dc2-85eb-10b7d288f661@intel.com/


