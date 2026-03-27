Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB785F532CC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ykx-0003bQ-1p; Fri, 27 Mar 2026 00:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5ykv-0003bD-Bd
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:25:09 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5yks-0005Xp-CE
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774585506; x=1806121506;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZO+fEXsTVzfBkO0QExq5HYwfZcDdpaO3MKlhVoIEC24=;
 b=hnsMZjJ2iVv5HXfQkQ9q27VdvjVUw8hWS28aB2Yi6PR2lqSiA6Qakz74
 OCEb1mQiYf0DbOXgk4z729rNThrX9mW1nDZOumFI4Y7mBN5er6noBMszX
 7uJtBdiVp+5bRkxGvawOahNG3GFk5QGgaSgurYYX+im/GJ9ce57Ey4IAs
 KpnXZtiHShwOiGlMGHWI7IdjqLo7FoNEY+5axntnwD8mdJxs5loazeBi/
 Fo8/MCd5E+8mouuGtzOTGjL7kzThvTVAPcNwcu3O2FzZs74aYZjwXc5fY
 LCQLTxDJiONfGUY8UTrubyG4Myseiq6Q8fZ3eAe9cjCyD/l22c1lm7mBC g==;
X-CSE-ConnectionGUID: 3j1CdgPFRCWfxbPoPieJEA==
X-CSE-MsgGUID: c5kNjkKLR02VKqF2LKztdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74838539"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="74838539"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:24:59 -0700
X-CSE-ConnectionGUID: C7TyONFLRxa2PQ2DPshUUw==
X-CSE-MsgGUID: /BkIlzw/TK6BHaoQ3ScsQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="225215901"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:24:59 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:24:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 21:24:58 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:24:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnzIwRs6pRd7ZU2ISNb/D0yr0XWxRgu9G5nLGIFQ84zjD+GoagJRXoCuleM7nYlurKzDigjOT1a/ZpzQp+3skKPthhW57doYo2Y4z8aiWyGV7Uc9U9gOAZzTZh0BRmSim+785xXpNSQAS+419tRdoRC9Fjn3x+mRi+aWo3JGyUzQoZNQ3AiYbsKiCPAzNniw4xEuyXK3SvVw4c7fbdoex9WfDNsDPJLTbcFs58j5VCChhc06NAFKPnX04fbnNhqePg4I+lb/Ha1v80xuE2AvdichQpkw5M95doPqW3zsvNU6TFqcvKzcrLaJOgUZvFRLwReAU1Qh16mslbQrlC0s+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6+SQ1Lb/+OWwkXdyNeT3bk5ZBjX1QiySktljLR5xvE=;
 b=LmEhoEVHr0aMiCyumCRXl1FBhsJ9bN84DlsYXJ7vNxrM4AuY5n8BEzaNP2Xh8l7J3Wai+/KJsbS6XDwTv+aeTL3KImBLiTnDdgtT+VqyzSDrFmLIXQr44mEYMq8SqV9lVmEf6Bj0H6NZGTejFzLwQaOFRi56jdFmQjb1hWAQWukjF/axOtvwYTKWHAeXhG8mhiJcW6LEyoD24nQA5rRbvd1moTOtw5o51LjP6vGCpm8FAcv86BBztaY55vkDFWiSKq/I0Av8JymuVvfolOXwSoyZazt6C7MeKbT02m8Fb376upyN26AOb+eAxUabo77q5u8DqB0YzOMfe3hXkODzsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA1PR11MB9614.namprd11.prod.outlook.com (2603:10b6:806:4c4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 04:24:57 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 04:24:57 +0000
Message-ID: <1e3b2e0f-a6e1-4355-b440-e9e37c7981b5@intel.com>
Date: Fri, 27 Mar 2026 12:32:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] intel_iommu_accel: Support pasid
 binding/unbinding and PIOTLB flushing
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-12-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260326091130.321483-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0024.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::7) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA1PR11MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1aa5b3-b782-44a3-90b1-08de8bb8cd6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: mMV3tQlP3tvVhTkAvhZ/QqG00gOeQVyHSDFJSAL8gLmjCKGK5aP3IQn9hNndFIDe2ixluvAzSTfKHlzByV8PIFZzQq0rRUK+scBuNjR5ZQehYA1SYAMeAxWyTeESo1rkTHZ9pUAJBFlVwaGyn8DKosm1tojLZWVRrnBxucFnRdWpUJQAwbJ4uCne61pc3F3KlTF+8tlElQf2HSwddiQVi6IeqDpQZ35oY387e4/bRbYi1r64SmKNSSKh9V75OK0h4liPuevGWeYiNLlDvbnDpcAkqgoDp1o4ftlC8nY6bMi+tRnQ1a5w+9Gfs0AgRphm3kPayz5eTfg2qxPkSzzI5qqNcUyw2CwIgA38XQF9KP0W+Z/PNqR/5Q2osxooMJ0o/1JBqj8xsMcmShXhlYYSgQHyUczdXqWQ+rEpXijnqcW57oea59wjGeaDKY1aGhQVtHQfSCLku8/bEcRsX9qkGHn0oYmLgNj5vw+6uq4Q77y9BuaX8ObZDTxjXWw5tjYwu/OWrw2iLQpu9AZaD4LVbTj9umwn3O9KYds+ziefTv18TuBHw3CJ1UEhMFRMTieG8hzrxAQu5k/0l23E8ebmxfxElDI7CiphAtmo9DlMRyhwmtMAVyw12pELWtow7I13E2ROutLFopDDyk3Pt7/4bS/dIRFX2P0YU4N6DBihZGTB/aebBuxjLU78dXmaMHrduZFthigUBvFFq1+uYdiURjmRkvCPjQLnqM1hqRynCUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(376014)(7416014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alltRmxqR1NPTGQyeEFLYzZST2p1RXY0OEVWNzJVUHJ4U3pkdlRteHBlTXlj?=
 =?utf-8?B?N243NXM1UXpXTDlUR3FZOWhZTndIQWpsb2d0em94emlQejNJWngzNEtHNWhv?=
 =?utf-8?B?dG96WHVocUZiVk5icmFxK1hrZEZSNEZ2Zno3ZWhySnNSUTNaaXljRlhQRVFM?=
 =?utf-8?B?dVlBQ1FJT0pjWmxDTzlLSTdmN1pQYlJTTzd6bFVJVzExOHVtTlZxMGwzQWdF?=
 =?utf-8?B?cUxZcWxnNkRERnNBZXpHOCtyU1Blb1lvclRETmpSeU9OM0pMWUp2WmZrNWFl?=
 =?utf-8?B?ZTBlTDhpeWd1ZnlLcDY0Wmo1eVN4ZjczaENPT1JhajBMcFpQU0dIaTdQcDla?=
 =?utf-8?B?K2xRQ1ZkdjgzQzBubWsyNzNOMCtvalpvaGViVFZ5UStJajFXOVRDdnBad2pN?=
 =?utf-8?B?ZTFTQVVrSXBHd2NyQ2xtbnNvQlJKNnRkZCszR1J6WUx3NWsvdUFMZWhFNUJn?=
 =?utf-8?B?M0xTcXNlMjZYclRWVnRFMVJhNkEvQ0tXbXZqbitRaXlET21ybEVMVmpnVXd5?=
 =?utf-8?B?V2g4VXQrdG9vMDFzYjI5L2x3TmovdUl5R2p4OEJMQVNnR1A1ZzQxbVdDeVpG?=
 =?utf-8?B?MXl2bks3QWsycjNOZU1TZ2xNeCtzSHdJckxzd1RCeU9tNnd6cHF2RFVZNmI5?=
 =?utf-8?B?MVhXY1gvWml4NTIyUFpSYU9UMkpsMUd3cUlKQ0pjQmJDR1BtazgwUEduOFBm?=
 =?utf-8?B?TTRCK0RlSkJldDRmRGRPNElGYTJYMHBTWlpnT2d3MGRJYUhYaTdIRVNqZlp6?=
 =?utf-8?B?YzJQcHBiNmNNKzZZOTdXc2VlZDU0RXoyaWJaNzNDa3dSRTE1UXZRa2ViSTA5?=
 =?utf-8?B?UWJYaFdYU3p0eExib0pUQzJyd1hrbmU0cGNUeW9CekRiM3VBKy8zNzhXTkpF?=
 =?utf-8?B?a3pma3E3MVR1aFI5L1FJRyt3Q2xjLzMzQ3I5dDJFNVZneVJDN0dtbnFVaGFG?=
 =?utf-8?B?SENMZVFhUE5keGxDYzQwV1Rad3dQcHppTmg2SmMrUnF3dGQ1UjFIZWFQODI5?=
 =?utf-8?B?OHNEcXNkTmRTaTZTNDc2ek4rcG5leFc5a05PbHJYQko2RWFka2hBb1I4RHVa?=
 =?utf-8?B?OU1CNXpLNzM1cFoxazYwbExkdFlaQk9SZk1Cb1I0RnlFaXEybklZY0tqeXdw?=
 =?utf-8?B?QVU3RHZRTzYvTWdZbVN2MFRwWHc1MVRMaXczVStGQ3crMkwvdWhlSXc4aDk5?=
 =?utf-8?B?bjBHZ1poRGZndXdSRUYvbE5Dc1RIUzdQZ0tMeWpObnpGd2FwSDNjNzd5bSsv?=
 =?utf-8?B?ZjU3MkpJTWRTOHBrS2UraThpVk4yZ1k2ajJsSTdYUURIdEFrYUp5MmZrWWhk?=
 =?utf-8?B?U25rRDFodVVSQThybTBSUE9HaTlYTzhrY3oxVlJJZ3pmMDZZRDl2eng1K1hq?=
 =?utf-8?B?eEhmUmZFV2wzK1lHZTc3aTZKeW9UTXNjSkpHM3dIWkJxYzY4NEFnTnVJUlF2?=
 =?utf-8?B?Vk94SWFub2tBNk9IMDRwTTlZOTE4VzV5TEl4UHVlV0lWNzdsSEV2TTNrdWJh?=
 =?utf-8?B?WXZPSi92WjlocHNxOHJWUmxhTkVzSEgwRG9Xb3FyaXFMbjBVNnB1RERSRlJt?=
 =?utf-8?B?bmhTekFXVmZZb3VGZk9Xa0ppRmlhRXJvakc1bU1zYUJpcWQwNHNmeE9UU1gv?=
 =?utf-8?B?RGVha1E2ZzhyazQ0bHJzZjl4NkR6S3I5Tk9hUmtycnRDQTFtTlBYVWZySm0w?=
 =?utf-8?B?N3lHVFhmUFRzQ0pkWFJZS2ZjZWw2YUpHY3pFS1NRMzJWb2RiNlBON1FOQ0xa?=
 =?utf-8?B?Qk1QTUIyWU9peHpUY2ltRlJUZGlESHJTMWNoMmpXUFRqeE9sNmw3bldEeHov?=
 =?utf-8?B?NE5jSjc2MEZUU2JsSnVVY1pDU3dJT0hjK2NldW9aL0N5SGdUOWJ2cFJld2Jh?=
 =?utf-8?B?cVh0YlB4ZUdmSTRPV0t2SFhveThQSzc5dG8xZ0VMS0NsWi94WEV0MDRKOU8y?=
 =?utf-8?B?M1M5Ri8yWmxWVUxlYitjOUZzZWw1aU1SazhIOXcybjVhUHR4SVg0QnBGWmZ6?=
 =?utf-8?B?ZVROUmMrTlBacHBodnVkVDVpL1pnMnVKUUg2T05QTlM3dHFZaEVGT1VVYzRj?=
 =?utf-8?B?bDQ4KzlxT1RmQ3NTcGVFRDcxS2tGNklmeXNxMFkzaUJTNGxCWWlDdHRzeUdT?=
 =?utf-8?B?ck1MS1ZxZHF1dVowZzYzWDdhbXlXWUtGeXQ1Z0FwNm1KUS9UNlJ2bmNmckpX?=
 =?utf-8?B?MW8rWVZEY1lxTnNxWnVYanZMRU9OZGFpTE9WNmRMTWF3d2V3cXJpYWorcUxx?=
 =?utf-8?B?RWFDSVVFM2xhamRIbXY4aEc3Y2ExNWViWGJzTFpDdjMwM24yaUprclJQNG9M?=
 =?utf-8?B?aHU2cjRPWEIrNDlVN3hCbU5zVXZVamg2cEpabXl4WjJEckxWN2lHQT09?=
X-Exchange-RoutingPolicyChecked: ZUKjjeaKE0BIyUtYBzUfpdK7h6BQIV4AUdI8l/2QU47xfPTuUdXKd8/wtUtOLcSd68K9FVKtN85hdBqs4myj9VtfzAagpccU9j6C2l8I26fC3M8kU8F9YxqH3zcwUYq1mi35ascmFL6YS7j4GaaPTdZQhNzgHgxi3wwsl5WUqOyvhUlXrRTBd6Nf5/yJXksh8tQ0sUz81GTS1rxTj7ccJk0ARDmt6sNqYdnZuzgByHxA+LU2bGDAnYtKLO4zK27lMNRh1s9xkjaaUWFt7Dzv+q/3dD9vX/jmam/SL30y14zCnkPxGutSIq/iG+5gZlTbZ3mcyiezbioAFI8mqgDFfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1aa5b3-b782-44a3-90b1-08de8bb8cd6a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 04:24:57.1133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PuzYbe2ONlLz7tZmY0Jy45nQcmRyv9se47c25PcvgZNrXuCu3GOw0iLr0sSMxu3z59YCQa0KbsP1ds1HEy0qPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9614
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yi.l.liu@intel.com;
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
> We just switched to use VTDAccelPASIDCacheEntry to cache pasid entry of
> passthrough device, also need to switch the binding/unbinding and PIOTLB
> flushing functions to use the same structure.
 > > After the switching, we could remove accel related code from
> vtd_pasid_cache_[reset/sync]_locked() to make intel_iommu.c cleaner.
> 
> The VTDAddressSpace of PASID_0 is still useful as VTD supports a legacy
> mode which needs shadow page table instead of nested page table.
This patch does quite a few things. But I don't have a good idea to
split it. So wish to have a nice description.

FYI.

Subject:
intel_iommu: Switch to VTDAccelPASIDCacheEntry for PASID bind/unbind and 
PIOTLB invalidation

Commit message:
This patch switches from VTDAddressSpace to VTDAccelPASIDCacheEntry for
handling PASID bind/unbind operations and PIOTLB invalidations in
passthrough scenarios. VTDAccelPASIDCacheEntry was introduced to cache
PASID entries for passthrough devices and is now ready to propagate
PASID bind/unbind operations and PIOTLB invalidations to the host.
Unlike the previous approach, VTDAccelPASIDCacheEntry supports both
PASID_0 (rid_pasid) and other valid PASIDs, so this switch drops the
PASID_0 limitations that existed in the prior PASID bind/unbind and
PIOTLB invalidation path. For PASID_0 of passthrough devices,
VTDAddressSpace continues to handle shadow page modifications to the
host, but no longer manages PASID bind/unbind operations or PIOTLB
invalidations for passthrough scenarios.

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_accel.h   |   2 +-
>   include/hw/i386/intel_iommu.h |   2 -
>   hw/i386/intel_iommu.c         |  17 +----
>   hw/i386/intel_iommu_accel.c   | 125 +++++++++++++++++-----------------
>   4 files changed, 64 insertions(+), 82 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index 1fb7ca0af6..c72856a8ff 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -16,6 +16,7 @@ typedef struct VTDAccelPASIDCacheEntry {
>       VTDHostIOMMUDevice *vtd_hiod;
>       VTDPASIDEntry pasid_entry;
>       uint32_t pasid;
> +    uint32_t fs_hwpt_id;
>       QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
>   } VTDAccelPASIDCacheEntry;
>   
> @@ -23,7 +24,6 @@ typedef struct VTDAccelPASIDCacheEntry {
>   bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                             Error **errp);
>   VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
> -bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
>   void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>                                         uint32_t pasid, hwaddr addr,
>                                         uint64_t npages, bool ih);
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 95c76015e4..1842ba5840 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -154,8 +154,6 @@ struct VTDAddressSpace {
>        * with the guest IOMMU pgtables for a device.
>        */
>       IOVATree *iova_tree;
> -
> -    uint32_t fs_hwpt_id;
>   };
>   
>   struct VTDIOTLBEntry {
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index b022f3cb9e..f53642a611 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -86,8 +86,6 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>           VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
>           if (pc_entry->valid) {
>               pc_entry->valid = false;
> -            /* It's fatal to get failure during reset */
> -            vtd_propagate_guest_pasid(vtd_as, &error_fatal);
>           }
>       }
>   }
> @@ -3126,8 +3124,6 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>       VTDPASIDEntry pe;
>       IOMMUNotifier *n;
>       uint16_t did;
> -    const char *err_prefix = "Attaching to HWPT failed: ";
> -    Error *local_err = NULL;
>   
>       if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
>           if (!pc_entry->valid) {
> @@ -3148,9 +3144,6 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>               vtd_address_space_unmap(vtd_as, n);
>           }
>           vtd_switch_address_space(vtd_as);
> -
> -        err_prefix = "Detaching from HWPT failed: ";
> -        goto do_bind_unbind;
>       }
>   
>       /*
> @@ -3178,20 +3171,12 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>       if (!pc_entry->valid) {
>           pc_entry->pasid_entry = pe;
>           pc_entry->valid = true;
> -    } else if (vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
> -        err_prefix = "Replacing HWPT attachment failed: ";
> -    } else {
> +    } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
>           return;
>       }
>   
>       vtd_switch_address_space(vtd_as);
>       vtd_address_space_sync(vtd_as);
> -
> -do_bind_unbind:
> -    /* TODO: Fault event injection into guest, report error to QEMU for now */
> -    if (!vtd_propagate_guest_pasid(vtd_as, &local_err)) {
> -        error_reportf_err(local_err, "%s", err_prefix);
> -    }
>   }
>   
>   static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index e9e67eb1a0..26543489fb 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -111,23 +111,24 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
>   }
>   
>   static void vtd_destroy_old_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,

vtd_hiod can be retrived from vtd_pce?

> -                                    VTDAddressSpace *vtd_as)
> +                                    VTDAccelPASIDCacheEntry *vtd_pce)
>   {
>       HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>   
> -    if (!vtd_as->fs_hwpt_id) {
> +    if (!vtd_pce->fs_hwpt_id) {
>           return;
>       }
> -    iommufd_backend_free_id(idev->iommufd, vtd_as->fs_hwpt_id);
> -    vtd_as->fs_hwpt_id = 0;
> +    iommufd_backend_free_id(idev->iommufd, vtd_pce->fs_hwpt_id);
> +    vtd_pce->fs_hwpt_id = 0;
>   }
>   
> -static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> -                                      VTDAddressSpace *vtd_as, Error **errp)
> +static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                      Error **errp)
>   {
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
>       HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> -    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
> -    uint32_t hwpt_id = idev->hwpt_id;
> +    VTDPASIDEntry *pe = &vtd_pce->pasid_entry;
> +    uint32_t hwpt_id = idev->hwpt_id, pasid = vtd_pce->pasid;
>       bool ret;
>   
>       /*
> @@ -147,14 +148,13 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>           }
>       }
>   
> -    ret = host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID, hwpt_id,
> -                                                errp);
> -    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
> +    ret = host_iommu_device_iommufd_attach_hwpt(idev, pasid, hwpt_id, errp);
> +    trace_vtd_device_attach_hwpt(idev->devid, pasid, hwpt_id, ret);
>       if (ret) {
>           /* Destroy old fs_hwpt if it's a replacement */
> -        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
> +        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_pce);
>           if (vtd_pe_pgtt_is_fst(pe)) {
> -            vtd_as->fs_hwpt_id = hwpt_id;
> +            vtd_pce->fs_hwpt_id = hwpt_id;
>           }
>       } else if (vtd_pe_pgtt_is_fst(pe)) {
>           iommufd_backend_free_id(idev->iommufd, hwpt_id);
> @@ -163,16 +163,17 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>       return ret;
>   }
>   
> -static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> -                                      VTDAddressSpace *vtd_as, Error **errp)
> +static bool vtd_device_detach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                      Error **errp)
>   {
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
>       HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> -    IntelIOMMUState *s = vtd_as->iommu_state;
> -    uint32_t pasid = vtd_as->pasid;
> +    IntelIOMMUState *s = vtd_hiod->iommu_state;
> +    uint32_t pasid = vtd_pce->pasid;
>       bool ret;
>   
> -    if (s->dmar_enabled && s->root_scalable) {
> -        ret = host_iommu_device_iommufd_detach_hwpt(idev, IOMMU_NO_PASID, errp);
> +    if (pasid != IOMMU_NO_PASID || (s->dmar_enabled && s->root_scalable)) {
> +        ret = host_iommu_device_iommufd_detach_hwpt(idev, pasid, errp);
>           trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
>       } else {
>           /*
> @@ -180,72 +181,47 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>            * we fallback to the default HWPT which contains shadow page table.
>            * So guest DMA could still work.
>            */
> -        ret = host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID,
> +        ret = host_iommu_device_iommufd_attach_hwpt(idev, pasid,
>                                                       idev->hwpt_id, errp);
>           trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
>                                              ret);
>       }
>   
>       if (ret) {
> -        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_as);
> +        vtd_destroy_old_fs_hwpt(vtd_hiod, vtd_pce);
>       }
>   
>       return ret;
>   }
>   
> -bool vtd_propagate_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
> -{
> -    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> -    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
> -
> -    /* Ignore emulated device or legacy VFIO backed device */
> -    if (!vtd_as->iommu_state->fsts || !vtd_hiod) {
> -        return true;
> -    }
> -
> -    if (pc_entry->valid) {
> -        return vtd_device_attach_iommufd(vtd_hiod, vtd_as, errp);
> -    }
> -
> -    return vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
> -}
> -
>   /*
> - * This function is a loop function for the s->vtd_address_spaces
> - * list with VTDPIOTLBInvInfo as execution filter. It propagates
> - * the piotlb invalidation to host.
> + * This function is a loop function for the s->vtd_host_iommu_dev
> + * and vtd_hiod->pasid_cache_list lists with VTDPIOTLBInvInfo as
> + * execution filter. It propagates the piotlb invalidation to host.
>    */
> -static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
> -                                         gpointer user_data)
> +static void vtd_flush_host_piotlb(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                  VTDPIOTLBInvInfo *piotlb_info)
>   {
> -    VTDPIOTLBInvInfo *piotlb_info = user_data;
> -    VTDAddressSpace *vtd_as = value;
> -    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
> -    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
> +    VTDPASIDEntry *pe = &vtd_pce->pasid_entry;
>       uint16_t did;
>   
> -    if (!vtd_hiod) {
> -        return;
> -    }
> -
> -    assert(vtd_as->pasid == PCI_NO_PASID);
> -
>       /* Nothing to do if there is no first stage HWPT attached */
> -    if (!pc_entry->valid ||
> -        !vtd_pe_pgtt_is_fst(&pc_entry->pasid_entry)) {
> +    if (!vtd_pe_pgtt_is_fst(pe)) {
>           return;
>       }
>   
> -    did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
> +    did = VTD_SM_PASID_ENTRY_DID(pe);
>   
> -    if (piotlb_info->domain_id == did && piotlb_info->pasid == PASID_0) {
> +    if (piotlb_info->domain_id == did && piotlb_info->pasid == vtd_pce->pasid) {

have you considered to use IOMMU_NO_PASID instead of PASID_0 before
this? When reading this change, I'm wondering why this changes
PASID_0 to vtd_pce->pasid while other parts of this patch changes
IOMMU_NO_PASID to vtd_pce->pasid. I think we've already have the 
consensus that IOMMU_NO_PASID is 0, so you may have a patch to switch
using IOMMU_NO_PASID instead of PASID_0.

>           HostIOMMUDeviceIOMMUFD *idev =
>               HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>           uint32_t entry_num = 1; /* Only implement one request for simplicity */
>           Error *local_err = NULL;
>           struct iommu_hwpt_vtd_s1_invalidate *cache = piotlb_info->inv_data;
>   
> -        if (!iommufd_backend_invalidate_cache(idev->iommufd, vtd_as->fs_hwpt_id,
> +        if (!iommufd_backend_invalidate_cache(idev->iommufd,
> +                                              vtd_pce->fs_hwpt_id,
>                                                 IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
>                                                 sizeof(*cache), &entry_num, cache,
>                                                 &local_err)) {
> @@ -261,6 +237,8 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>   {
>       struct iommu_hwpt_vtd_s1_invalidate cache_info = { 0 };
>       VTDPIOTLBInvInfo piotlb_info;
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    GHashTableIter as_it;

s/as_it/hiod_it/

>       cache_info.addr = addr;
>       cache_info.npages = npages;
> @@ -271,12 +249,19 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>       piotlb_info.inv_data = &cache_info;
>   
>       /*
> -     * Go through each vtd_as instance in s->vtd_address_spaces, find out
> -     * affected host devices which need host piotlb invalidation. Piotlb
> -     * invalidation should check pasid cache per architecture point of view.
> +     * Go through each vtd_pce in vtd_hiod->pasid_cache_list for each host
> +     * device, find out affected host device pasid which need host piotlb
> +     * invalidation. Piotlb invalidation should check pasid cache per
> +     * architecture point of view.
>        */
> -    g_hash_table_foreach(s->vtd_address_spaces,
> -                         vtd_flush_host_piotlb_locked, &piotlb_info);
> +    g_hash_table_iter_init(&as_it, s->vtd_host_iommu_dev);
> +    while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_hiod)) {
> +        VTDAccelPASIDCacheEntry *vtd_pce;
> +
> +        QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
> +            vtd_flush_host_piotlb(vtd_pce, &piotlb_info);
> +        }
> +    }
>   }
>   
>   static void vtd_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
> @@ -284,6 +269,7 @@ static void vtd_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
>   {
>       VTDPASIDEntry pe;
>       uint16_t did;
> +    Error *local_err = NULL;
>   
>       /*
>        * VTD_INV_DESC_PASIDC_G_DSI and VTD_INV_DESC_PASIDC_G_PASID_SI require
> @@ -309,6 +295,9 @@ static void vtd_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
>            * to be either all-zero or non-present. Either case means existing
>            * pasid cache should be invalidated.
>            */
> +        if (!vtd_device_detach_iommufd(vtd_pce, &local_err)) {
> +            error_reportf_err(local_err, "%s", "Detaching from HWPT failed: ");
> +        }
>           QLIST_REMOVE(vtd_pce, next);
>           g_free(vtd_pce);
>   
> @@ -333,11 +322,17 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>                                 VTDPASIDEntry *pe)
>   {
>       VTDAccelPASIDCacheEntry *vtd_pce;
> +    Error *local_err = NULL;
>   
>       QLIST_FOREACH(vtd_pce, &vtd_hiod->pasid_cache_list, next) {
>           if (vtd_pce->pasid == pasid) {
>               if (vtd_pasid_entry_compare(pe, &vtd_pce->pasid_entry)) {
>                   vtd_pce->pasid_entry = *pe;
> +
> +                if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
> +                    error_reportf_err(local_err, "%s",
> +                                      "Replacing HWPT attachment failed: ");
> +                }
>               }
>               return;
>           }
> @@ -348,6 +343,10 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>       vtd_pce->pasid = pasid;
>       vtd_pce->pasid_entry = *pe;
>       QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
> +
> +    if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
> +        error_reportf_err(local_err, "%s", "Attaching to HWPT failed: ");
> +    }
>   }
>   
>   /*


