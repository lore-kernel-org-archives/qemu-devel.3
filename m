Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EAF0C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1kYA-00077G-A8; Wed, 02 Sep 2026 08:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1x1kY3-00076V-AF
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:58:39 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1x1kY1-0003QW-FL
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788353917; x=1819889917;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yfJugPHnob5lU7rDz1rpREojElrMl/y0N9rlVmiTrDg=;
 b=HYoEeehqshhdi/hlI/+4r4WiJ1keIa7/ZQTmrrkQJUE6847LpqOqqrV7
 PnJf9JruDKodr1FmLgIx7kTIBaFIGTICU+q3zbz3K5xnQGKhxRleoNZjo
 ZfkNRv4CkfhRMe4bBGdN/FG9Mk0ecM8ytUFtIIvGxJt5KOK6lJ2UqpxEW
 OJQ5svQd5BUNS3ZXiH0fXBL1BgwuvrkjkFJw1XvBwookpEXW7ux1LIV+T
 nGBwWCawqYwy+wjCFswQcqG3Rq4QLi3bAGcXXizj2H1VXjFTsj+Kp8a4v
 GlpiQjNnbnKLx0T10h477UkYagt5xZIWsSdRHrEgfq80Z5Tu1zAItlhwx w==;
X-CSE-ConnectionGUID: 9CrDcoE7RSyETIMZPjjn5A==
X-CSE-MsgGUID: VzOZC9+LQKOstFTZgCr1qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88856514"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="88856514"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 05:58:33 -0700
X-CSE-ConnectionGUID: +9EWW0YAR5eOupl6ANB7sw==
X-CSE-MsgGUID: TyUmH5aHS/2gCCfFK+V3aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="274669113"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 05:58:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 05:58:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 05:58:31 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.37) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 05:58:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyE+NzPgMEfn9wqEtKfABHEZpT6/1WL001nN7a9tWxzdZtDngJIyHqeLMzEwkVtAob/xo4pxxYKcoLcPZQqLoJuI0y2zQ/nh+kT/Sm5vyqXPYpV1KVz34Ewrm+Pt387VT1z/OkIUFr1a4fID/V8tRzBuzACF/mtEnVUqmWc2tbD2OrkNX/WOGJiDwH+0vNVTxJs8foLehn09cGCIgLbCzdurv7ccWky0W/3+8InhOKi5g5qHyHYGrus1gcZBetIqkHeRzOaJgYPfKP/4OBKYpWypLqQpWwW4+WNu5D3ZQqslLDAv1jclLQUVpOPCNsTRA8g8taoF68q9WFrTDggKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTNSZtOrizWtfhzoAmKhuwHktHoX8sBVKAj33aZOSqs=;
 b=xAOG+dg9pNGYEakWqSjj5Jj+AoZvKFNDTZBi4XVQhIT2c8WVX2YfpDFag03Xx3H9TINnIbORlTLMui2Imun+UZdoS72WD7iB4YGXHiUAD2mWVabcKWbBm+pH267ZY3lGhYu13MLi0UXv3zeeW6o2vaxkdU/IeQCHgXmTFMzibg0LtuckqvtqgbdVHKccWqlEnH5E4x51cBl2z3mX/nCXk7mBz3sYh/H9lmYEYHX0deCOOiQwDEI9NwxHxQPSOgYWTPvj1dFHhN/pOJGB2KdT8g2Z+Lze8LYnzGkr5H1aKzYkT6ayOXvDhcOjraFlLA68W7I62qZybRUU+7l9oJrBRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS0PR11MB8666.namprd11.prod.outlook.com (2603:10b6:8:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:58:28 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 12:58:28 +0000
Message-ID: <4d3c8138-1667-4aa8-ba4f-8e6bdcd95556@intel.com>
Date: Wed, 2 Sep 2026 21:06:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] backends/iommufd: Introduce
 iommufd_backend_alloc_faultq
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowangio@gmail.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260831095200.1279366-1-zhenzhong.duan@intel.com>
 <20260831095200.1279366-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260831095200.1279366-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS0PR11MB8666:EE_
X-MS-Office365-Filtering-Correlation-Id: 0798274a-9781-49c4-b9fa-08df08f1e23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|42112799006|1800799024|23010399003|7416014|376014|10067099003|18002099003|4143699003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: ovRKoo4H/1KvQe0y5WoRHOQZEKqSzIV2gUy9TrIq+ejpOaWUoNloHt7vRB6Zl88uMT8CVK24fSJLJmoo4bgmVCJOmTCm8Uim2w7//ZVGKZKkQ5ob0ljyHD9rHPKJf/HsUVt6PF0GqzAKiPUCpbmTT8sr7rcToKex5uyZTFZin8hHdlqZAW/Z8VFtGvJm+VcP95FKqpogm/9A8xSj5DT3QmDFh14kw8+N1QI6nTjPjtt8Rwig3ysf/xJrExOo5euxCN8baCEWF3z+4OHTVgfLTL30xoX2ly/H0Dj3vttfXCbUcoJt/qCaT6RStz81Cb8J7DBSWY9B7ONnZVJaB9oaSV3MwZ7m8CrF+YASCELUaoAP4SbVRzpUCUr8ArJGKU7unYoiwaGsKfXXzB8JDSGOqiJjk3/pvNfOORILU446gJAuPjl9goTxlrC/g5vdGBBuZ4C7ElNzQiJgLYUducm/Wt8zDf7pwYTQWQf30FB/+PDkY18AdlMrF3SnlRT3C9SXdkVR86iZelWQIUbwDTY7IqrzRgrD2fwqqHnzC8I3CslBHBNdCykVRB17vdBWjpd6rPzCG5z8MhJzs5oypymKY3TYzbbTrXcZ0oTg3WFsPpv0JJbeFCHXEgBcxWcbYIfeiUiFY4SpnQsSplhoWOQuurCTlc2rpah9HTtss0IErpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(1800799024)(23010399003)(7416014)(376014)(10067099003)(18002099003)(4143699003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFZRS2I3Vm4raFcwd0pKNnhYR1JiMnFPTklwMi9QdjJQbEJveFd1M2hFUE1s?=
 =?utf-8?B?a1JDR09mek9aajVZMDMzR3BMNXpDVHNFNms0R1pGRFo0WVJEZGZ3VURVNHc3?=
 =?utf-8?B?ZURSUk1iUk9Ia3dIRUR4eThWNGcvRFRPTXhvWWhnaFhkTGZZb1M0bjlaLzRj?=
 =?utf-8?B?bnNndlRXNC9OQW9WTzVPbEpMWmNQUkhDaERpQ2IvU1FKSEFxY3c4cGUrRlRn?=
 =?utf-8?B?UTJ3SEp3QTc3cU1LZjVFUThKL055RTMwSnJwcitNTSt4VmV6aVR6ZU1ZbzlR?=
 =?utf-8?B?VE5ZdnRxRHZEaXI2OU4rM2szeXpmVndyVm9Ic0x5MXlpL25ubTUzZ1B2bHgr?=
 =?utf-8?B?QVJ0VnJOMkwyZ2p4UU9kYmx5MmZzUEZoNVhxQVVZYzhGTlFrMTRoaDhMRnJL?=
 =?utf-8?B?UGRCSnc1elZUZ1VwNXYyN2xUb2Z4OGI4TUhVOTdrTXpCSTBSNzNrSnhKRHFJ?=
 =?utf-8?B?cXdKdUdySHllMU05VmEvb1V6U0Z1MUx5UFkzaGVjTlJwTVFHZTdCUkgrU3Ur?=
 =?utf-8?B?aTlDQkdwL2ZobHpRWlJxSHpEVVl4a2VGcTM1NnRPMTJDY1dwOUxwVm1JS0t5?=
 =?utf-8?B?ZXZZUVZHeFAxWm1nZzdOTDRIbkNMY3BiRm9Qa0oreFc3MGNPWUJMYVhIUnZM?=
 =?utf-8?B?bUdvRXZFeWhmakJwNWwyUUVLbDRaWWNyQ0pNNHBJTE9aUTNRRGtvZDFmeUs2?=
 =?utf-8?B?UkF2QllpazhPL1ZrWkZUSHZVKzFRQTFLRGhYTDM1WHgySmlQRzFSNXc4Z3NY?=
 =?utf-8?B?ZXJaR1JQL2VuQzlWalk0L2dhL1lWalZpUUJiZE5GRDRaQzgxNDl6bEdMWkYr?=
 =?utf-8?B?c0ZnTHVpemVJNmJwR2hWL0lobEphdENZbTRYT3ZOSkZnd3pCTnhHbjFPMjZv?=
 =?utf-8?B?VjFNaUN6SHU3alZFR2ZLTGhwNzh1ZDBsUExVU0IvQkxmcGRQRzdQbkxPY2dK?=
 =?utf-8?B?M2VaME9XcGZaaWRpRWtsWXF2Wk9GcWtuMHA2Q0NmaWFzZU0vc3pKcVZndG5z?=
 =?utf-8?B?OUxRWUYyclRsY25xU20zQllURGNRdkNaY29WSXYwamhZVEVHMTRDbFNnQmZS?=
 =?utf-8?B?emtBNG0veEdwTmNlNzlKdGt6YjFucnZFYlIwZTIzV3hJZkFGNXk1WVIrUlFN?=
 =?utf-8?B?MzlFSGtJVjJkMDhRNGpjRHFBNUUzN2MxMThGRlRXY255dDc3L3lETjFmNVJr?=
 =?utf-8?B?SzRVMUNiZU8ySTFUUGxpOFd0T3NiQk5lbm9ubllCeno3OUIyYWx3bWRkL1hZ?=
 =?utf-8?B?dVdPbFZCbmQvekNQU3c5dG1uZThDcUdyWDFmNDZzbmV4NHVObjVKYVFTUjla?=
 =?utf-8?B?ZStKdlJmSWwxZU5tNXR2ejRHSUpLTGc3V0FTTzdnNDRDZFY2VFRYMGJtalBM?=
 =?utf-8?B?VnEycFFGL0ZiVUpoK3dJRS9lSXd4VEsvbXZmUnpYUU5nYXpqY29LY24ydXd6?=
 =?utf-8?B?QlVZU2IxUTJOa0hldUMwdFMxaUhNVGN6Q3pwMHFNYXJUUW1rOVVaSjVDY0xL?=
 =?utf-8?B?Q3o4SHdRLzdyR2p4T2FzT3pMOXZhVGJ4SUhyUjNaa3pZaWNjemFvYlRoZHhw?=
 =?utf-8?B?K1ZzMnVnSk05dW15S1VwaG1lL1VoYndNcEp3U25xR1NHb1V1VE4vTEljYU5r?=
 =?utf-8?B?ekpwQ3RTb2YwYzFDVW4vTmFZRDVOcW9sNHNpWUJ3RkMrZVVaT3dEOEx2Uldq?=
 =?utf-8?B?S1UreGVnR1Vrc1Q0ZWJ6OWdrbWdlTUU2WXdNb2owb1p4VHlXbTBUaDZUVUdl?=
 =?utf-8?B?N0tERnAyVTB4M0dZQy9wbzB1SE9yb0JqejlsVXNLZjIrOTRoQ3pRRHZhcnFK?=
 =?utf-8?B?NzE1dVRTQjh4UUZhbUNMdWhPZzZRSDRCbmRNOVZhMnFyWGlLdkhyeUROdjFR?=
 =?utf-8?B?ZkN1L1hkOE83UTdNRitjc2QvK2M3cjg0Q0llVXhjMEJnSkFtS3FEYTd6WXEw?=
 =?utf-8?B?ZlErT0NUZmRKR1VBeUlPeU1xbHdoNWpUOEdFcmp2WUdwVGFocmJxYU82OVVL?=
 =?utf-8?B?bDlRTEpXRXhBRWE2bU93bWdERUp2bk9JeGRKQytkWnlCbEU0U0IyKytzZi9H?=
 =?utf-8?B?ZllKT1poWDk4UmlpWnd2UlRRZWhEd1ZHdThVU2lBZ2p2N3R0TjhtV1BCK2k2?=
 =?utf-8?B?OWNvZ2NFb2U5SCtjc2xHZkMvY0FpNmpHRlhsRWdPQk5tcUsyRVhJL0pMNjBR?=
 =?utf-8?B?T3hMZGtFc2ZLWk1vRk5MZU9HOVNBQlZ5czAzdWJyTDRXTDVmR1pVR0RqV1FV?=
 =?utf-8?B?aVZkcDFmMlR5WWJ0dFgxeFlqa2J0V05lRDA2RGZGZUo5d1piZGpGUXF2UWtR?=
 =?utf-8?B?dDc1bDRCaGk2ajIxd1pXQWtSWFZ4cGI3SENRZDludzc1amt0TW1oUT09?=
X-Exchange-RoutingPolicyChecked: vOIZkCUZLWLq7IP7Xs4JU+9DK38UAt1dnJeYKdMLKPOzqE2uAuqyJZnOYITmVn9fWocgiwP09R6LZEV6NYP8MRNB8341byAVaxx2DwBu6DfkTj8jptCXc9TuozHCVy3hkTecSg0ikGfatyPOy5vLR/mSTta43I2j7twUAPmON/S27wCEcdkGugaSWW3Ga7qfCnL8xg3kmMrR18vTas2XTfbegDxokpg9Hc9cyq4oyIeUVyRdCrXT2ldCDWupiF2TZI+yGKU1xgPGEZ7ECl5apKB6Jo52flPb82JWW7Zgx8vjW5geC1IDDMH/Dfjr9/Wgt1FeIDNLuGNc3JtmWm6EAg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0798274a-9781-49c4-b9fa-08df08f1e23a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:58:28.7004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyF9+yA6TSXqm2YtIFBUmUI0CgEy7vEQvTH3EoT7OsBFDNZngp5n+eRTw6cNuHyCsdtMUiAIA9ZIbWUGtbcv6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8666
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 8/31/26 17:51, Zhenzhong Duan wrote:
> Add a new helper for IOMMU_FAULT_QUEUE_ALLOC ioctl to allocate a fault
> handling object which will be used in hwpt allocation.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   include/system/iommufd.h |  3 +++
>   backends/iommufd.c       | 21 +++++++++++++++++++++
>   backends/trace-events    |  1 +
>   3 files changed, 25 insertions(+)
> 
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 17bf1a3727..36b34b4899 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -106,6 +106,9 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
>                                      uint32_t *out_veventq_id,
>                                      uint32_t *out_veventq_fd, Error **errp);
>   
> +bool iommufd_backend_alloc_faultq(IOMMUFDBackend *be, uint32_t *out_fault_id,
> +                                  uint32_t *out_fault_fd, Error **errp);
> +
>   bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
>                                       uint32_t queue_type, uint32_t index,
>                                       uint64_t addr, uint64_t length,
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 15f2a51350..2775eef741 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -554,6 +554,27 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
>       return true;
>   }
>   
> +bool iommufd_backend_alloc_faultq(IOMMUFDBackend *be, uint32_t *out_fault_id,
> +                                  uint32_t *out_fault_fd, Error **errp)
> +{
> +    int ret, fd = be->fd;
> +    struct iommu_fault_alloc cmd = {
> +        .size = sizeof(cmd),
> +    };
> +
> +    ret = ioctl(fd, IOMMU_FAULT_QUEUE_ALLOC, &cmd);
> +    trace_iommufd_backend_alloc_faultq(fd, cmd.out_fault_id, cmd.out_fault_fd,
> +                                       ret);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "Failed to allocate fault queue");
> +        return false;
> +    }
> +
> +    *out_fault_id = cmd.out_fault_id;
> +    *out_fault_fd = cmd.out_fault_fd;
> +    return true;
> +}
> +
>   bool iommufd_backend_alloc_hw_queue(IOMMUFDBackend *be, uint32_t viommu_id,
>                                       uint32_t queue_type, uint32_t index,
>                                       uint64_t addr, uint64_t length,
> diff --git a/backends/trace-events b/backends/trace-events
> index 9b7b9b7d68..b1c1d89dd8 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -17,6 +17,7 @@ iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, u
>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>   iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
> +iommufd_backend_alloc_faultq(int iommufd, uint32_t fault_id, uint32_t fault_fd, int ret) " iommufd=%d fault_id=%u fault_fd=%u (%d)"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>   iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
>   iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"

LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

