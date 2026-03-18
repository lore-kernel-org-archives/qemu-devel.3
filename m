Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDFF103E16A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 12:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2pmv-0004CT-Rx; Wed, 18 Mar 2026 08:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2pmq-0004CA-W4
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:14:09 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2pmn-0008E4-1y
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 08:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773836045; x=1805372045;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jNOgPHYep9a+e7XLCdkBTxbdT42PvP5YOiTgl/9e9XM=;
 b=DIkcw+vq9oSosHbDh/FZ4+5XRh1WQIyL1/izfBKwundJD0midmnflli7
 an0f4kG1+pNYZyYJggsX3y9OBLwMzmWwvpxzFfyVfxITiTiguzxU0GoV1
 DiGgXjDyya+NQp0OlAC/iXJTyLJxg2N4PGfzHhuWdyo0m5UZoOg2vbO0R
 7OTmu4MxrNlI+9DLjhcYoQiAFDeOD6zr24MZ6xrBb7H8JIWYPkYB7AaZ9
 H64KS9ROrcz3hAR+TttaaLyRpz+QeOgPBk0i5Ch5w3AxyH2a/uWmmxG2N
 DJlRLBQ3Z2Utt98xqv/6NdOqpHuoPRIC2+Cyt8p5e/EyjHlfVzwHdA7/t g==;
X-CSE-ConnectionGUID: d15bzkSCQu6DEv/Zqq8dSQ==
X-CSE-MsgGUID: IN3l/6LXQUa77lCA7TBpFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85201885"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="85201885"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 05:13:50 -0700
X-CSE-ConnectionGUID: 9VueaulZR4S4c7U6wjiYlQ==
X-CSE-MsgGUID: gYlX2fQfTkWiKRlGKyZGCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="227548747"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 05:13:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 05:13:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 05:13:49 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 05:13:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lw4JezoTRonhzNqRK4CvBzFISiIlZ4+0dRxB+/IHb8LGp81Z91ZzBBemQ8KNAYhg0s2Vy6IokZxiGesRgEuzMGR3ndTcgi+NR9Z+4HailaSfjGfujX1ub/QeIydj61FgMyWZlroECa1lH/6DYccPYp01jkJnwrgsiXEwVg5zA0mddDCxrE9ecU4tp/raz1N9AOgTn09SViWgzeRAy8NayIfUfpLkhRnAn3fPYbTydEyuDXt5hUxKcNV1aXhAH8FZ3eIJEqvoK5hH0FvItWCPuiOHe/XhdL9CBCdtfH0XUQtpnJMu12inbPFnSxN9D5YO7FzLYhMacMIQdfD2H0Xe4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+Ut7GtnrlmcAyKNCUi+Cr234l0bhAI9uF3yLepKmsg=;
 b=VAGsoslHOESgbrQRSlx8WrJ6OtiqkG9iuICdzsJVHS3WvihksKgoZbe+nXdJIu+HcbHvPDsAO19jDygvAqJt6aWb3+1RLq2pkAiEObraXSqi5KB9Dt5Ye98hvMk9H1S4M8CJGNwzCQfLEnLLtxPNDM1FZYwwi7LD6G+XaHiRvIyprWMyfD4ChN5ObLxjPaXShefgIQnui9n6mu2LoUycoD6/I80Hijm9/EDrCzM+Ay0Wmd4eV5COmCmXzssJPEIvt2ju2HbGfSCrHyR1ZsUpJm9kZP0Ld9EgiXKpu3ntmljQl6K6wrmbd9YPFPUhU2m3P/mlPrJ8J1Q6BwBzS414Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by CO1PR11MB5044.namprd11.prod.outlook.com (2603:10b6:303:92::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 12:13:44 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 12:13:44 +0000
Message-ID: <5a782ac7-1916-4be4-9947-ded11cc33cbe@intel.com>
Date: Wed, 18 Mar 2026 20:21:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/13] intel_iommu: Export some functions
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-7-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260306034409.184873-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0028.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:5::8)
 To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|CO1PR11MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: 449d98c6-5259-4e66-1082-08de84e7cc9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|42112799006|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 0LNrkzZkGVOAp4ot6zywR8Hh0pzjyu74J1ZgNi1IJpp06a74stIF73DudMF2LFREZT6Y5X5NNnUTyTTIFwFNqaMoA6H1FsnXnxqsMwVkbk3bFhJ5C53z9yxQd86jje0wKwfuLhJ6X8HXvfS3b4Zxao3PQIRIjpNBNEakmR22LcexBXLkGXO02hnkAcE4uAi+J7XcRQCePMpshxyeR2Q9WmTrDdVxsXgC/4+GUwP+T+br2c9WIlqzex3xL+qIhPXvM6c6wxJU6yEviZ9jH6qiJD/VVI14eoyYTnfW9qCdeLSjZYRTd9gX+Zpcxeh/3KRHN+q23/UOeriNP//6ibpDCEzlz+XlK9+hquQG/AZYOVwhdP8vMRtrvgKcuFVgSuUChaagDL5fB5R6gQCDX5tK8G7PmiHkvn/py2gU4FYh+xRHtJ6RVFXJMKsOXg98ZneVcUOlh8NRgl9N+R/+R8MklMGvq7okf8+nx6DEO0vFAaKywKejNCuEl3WL/tvw9jUPav1q78RzTtWRLYEjcSdUocrF+OBykCRQSkPnL3/y3YtyweeEm0AmxOiNFi+uCqUsM6NC7aHGmSX05fiNK9RtkDYxIiXL1IpG4dICznrzvh5LKhX/A6kz5ARAJJTgaEut468Swal43waOJz4csVY01ul3a7ZMu5NKGPa9gx3XssYn0O5Trs3XKHpGvTyPPkinXaJVLuaqPsdC56SKT7yl+7+OUdjemHukggcRQlgXTKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmkzNjhFVm11cGNJKzVtNXN5allERHVCTjN3MG14cUhjZVhZY3REZ2lHVFJa?=
 =?utf-8?B?YzVjVmMxb203ZTdGekVsVmlMMEJWbWQrbGxuY3J6ZU5UbFZoQkhQNXZhZ0Iy?=
 =?utf-8?B?YzlPWkJEMkdPY0k4ZXJpRnhMZHVMeDRna2NvNVVld0huRWNJKzlOakN1Znh1?=
 =?utf-8?B?ckZCU2J3K0N2UXFNaXJJTk9wMEhsb29lc1JnSHRwUTV0R2F2bFgweTJnUmlM?=
 =?utf-8?B?SFltWHlscXdzaGZSM3pQK0Q4YUMxbnRNY0VjcWJQZS8vVkdtdk00RDNuNm9U?=
 =?utf-8?B?VCtLRTdIcEVyaHlPbjBnZDhVNTdhOEM3by83N0pWbUkwc29DeE5xVkZxckFT?=
 =?utf-8?B?V1lpa1RUNmJqMnVDRTNVVjlsUzRjY0dtZzE3VWpLUGN4Z0pMK1BYclFVSGlm?=
 =?utf-8?B?R2tURVBGcWUvcDlZQ29TUlIrQ0puVWVwT205eG9ZNExqT3Z0SFVnKzczRUlq?=
 =?utf-8?B?dUQ5SVFDbkE0UWpEcnVyT0Y5MkdoMmwzd2p5bE4rMmsvVkRmdklrYzhINmh1?=
 =?utf-8?B?TXlsVXEzNzlRVEMwNVZmd0VwRWp5bTE4blNXekpwODRibzJjaXdOc2tBazVE?=
 =?utf-8?B?QVNmbGJnMW00dEFOK2xJV0Q5dnVZYy8wRzk2WVVlY3RSZnc4anNrNkgxcmJa?=
 =?utf-8?B?Z2JDdWxIMVpaalNnd1VTWkJkalVBdy82VDU2NDk4UDRtT2RvNWQrYVE5TjZW?=
 =?utf-8?B?alB4bVNGMjFCSnJxSEJzakZtOTFDeWE3NDM5MGNaaXo5blBjdU5RL2xnaE9Y?=
 =?utf-8?B?VUZLeUJoQmM3Mm1SOG9DUms2OENCOHVFRXoxRWxNSHoxbnd6NlpsS1pPcWN6?=
 =?utf-8?B?U3krbzVJVGpPRTB4c2ZvYlczVkpIT1JrWHRyVTg1OHUvcW8yekowRFlqMEg0?=
 =?utf-8?B?TVZLS2NMenVPdElTVm5OUmhXYnZ3WWdQTnZnd00xN0hSdWlOZ2x3Wnd3N2RL?=
 =?utf-8?B?WHhMalFSNFZ3NTYwUHE5dmx4OWI5NDNKdG1aVkdiSEdIUUFDZ1d1akY5U2Nn?=
 =?utf-8?B?Z3RRMWJmRUV2ajVqeDB1YTZ5S0U2Z1BmTmNwT1J5YTZZSm9sWTlqNWszUnFy?=
 =?utf-8?B?WERMeTVucDhDNVhvb0Z2THNpaytvNEU5QXp2UlNTKzBYcURzVXhhdFR6Zy8r?=
 =?utf-8?B?eGpha0RsclhkQ0ZDK0dYemw2emtIZGtnRE4zSXhRRmtrVEErTDFpR1ZUcDFo?=
 =?utf-8?B?TXZKYzA2WUREdXIrNDQzTUI3Z2FoZ3JmNGY3RS9jNWhGYldqQ1o3MW16dzRB?=
 =?utf-8?B?aUxyUnlOUFhkbnNINm4wOC9IbGtjV3I4ZDVZS1lybVhSTGY2bWNHYVVXQTFX?=
 =?utf-8?B?c2FIU0hmalFka2lNZ0ZKblhnaDJ2MVNCOGNQS0tKQ1gxa3VEMzRkWTFxNUNz?=
 =?utf-8?B?dEpaTE5vQkdRMjE4Vk1BZWoxMUFlMHN6aElCWkVIZHlrM0ZTK281QkpVNmxr?=
 =?utf-8?B?WFR1Z3VpUHJuS0xSZDM5a2Jsb2lGOVRDeUVtNlZmdXQvZXg3RHVPRkRWTkdJ?=
 =?utf-8?B?YU9mWWJORGVodmFsajhWbUQ5U05WQkR6OFZxNXRmVjkvaDd1cktDbkNSSk5V?=
 =?utf-8?B?U01aTitQWFFkcngyMDhOYmRkNThLbXJ0WC9jbTh3Ky9Tc1pZem95WmlBRE40?=
 =?utf-8?B?ZFdUNk1oNFVzckdQbXh3TUxsVG1HeHBYa0Voc3pZNTkvNmRhMEx4cVg5TzlX?=
 =?utf-8?B?MjhLOHdYNlNLNnVpVnA5M1kxaHNZN3ozSlBVdTlKU3V3TFlLTy9qRmFhZy9y?=
 =?utf-8?B?NTBIT1QrbklaZDdvNDV2QUJIU3Y3VDVSNU42TU5rUmhJSTlITlcvb3Y1U0Z6?=
 =?utf-8?B?cDFVczdNWnJScXIxSFlqWjFYd3h1NXNTbTNXQ3hIbFo4NDUwNFhFNzB6UDBD?=
 =?utf-8?B?OGkwZ3J4SjNrb21FOGZwZDhvc3JZMHV1ZjZlaHg1aytjRzBydnVWYmhIUFUx?=
 =?utf-8?B?MkxPMmpJdG92MDZIZE8yMWdQM3VPOWlqaXBxNVJRNmVRbTZtNXVpKzQ0SVk1?=
 =?utf-8?B?aHRJcUNDS1RPNmhqSjFGWTRZSzlJK2ZNMXh5NkNsVVRVb2dEekNpWFpUZTJJ?=
 =?utf-8?B?eS9LOTNYQ0l4NGRPQ2M1Vmk2YnVPRG1qNm9GU0NPeUVLVGd4MFhJUGFoR2x1?=
 =?utf-8?B?VTlkMjNEYXBnUlJ5NGk0cVY1alNQOVcrZ1BMaFE5Um1YdXp5a1FQUjVnOHFr?=
 =?utf-8?B?VUV5SUU0QVRDTDZEVTBYRFZpV1NTYUphQlpqV21laFFIaXlmenZycnl0OWdx?=
 =?utf-8?B?dmFTSjJBQ3dsZW1RYkprVlVtUE9UYnpOVVJWZWEwcmM5M2s2NHAydW9Jc2pn?=
 =?utf-8?B?SlBVc2RzMHpVRGNXaVUyU3lDZ0huMXR4SXJVTE4rSUVWL3A1djliUT09?=
X-Exchange-RoutingPolicyChecked: p4QxbANF+ImHA8WbIYiy4EIKCxAAKm7agYT19nWjE6pYTXta/IWBNY0Shg5vYe1e+CYHYRNX/u7XDO8jkYISHExbpfxNu6rpe8SygZEjvGiBSLWz4EuJT0PS4YsXoRJKtRBgIqNpOrKOgbOXM5kc8ljXyFk3znhayPSEhW3EX9QQGsrE6E+FNfBtnv67CRi+y5KrekN0r03c5Mi/zTYwK+Uo9SWy9uCDmgoH9tmDrNreRCSYxI9G1MSDKl1n84Tb04M7KNOc5yEq1VoycKmIqYp9OpYLJgkLskK6f8/WMtUEwPtzqujZG686u9kQ9ClUU4XZXUTWinAeGBm3SjuOsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 449d98c6-5259-4e66-1082-08de84e7cc9c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 12:13:44.2303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BVx8zRy/mZbDfjAduUrP9gkeLCppQtl9nU/IDdwrZBza1JnCVogNQxto2BTu4AscQFoIwtgGXtnsewKfbbq0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5044
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

On 3/6/26 11:44, Zhenzhong Duan wrote:
> Export some functions for accel code usages. Inline functions and MACROs
> are moved to internal header files. Then accel code in following patches
> could access them.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
> ---
>   hw/i386/intel_iommu_internal.h | 31 +++++++++++++++++++++++++
>   hw/i386/intel_iommu.c          | 42 ++++++++--------------------------
>   2 files changed, 40 insertions(+), 33 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index db4f186a3e..c7e107fe87 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -620,6 +620,12 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>   #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
>   
> +/* context entry operations */
> +#define VTD_CE_GET_PASID_DIR_TABLE(ce) \
> +    ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
> +#define VTD_CE_GET_PRE(ce) \
> +    ((ce)->val[0] & VTD_SM_CONTEXT_ENTRY_PRE)
> +
>   typedef struct VTDPASIDCacheInfo {
>       uint8_t type;
>       uint16_t did;
> @@ -746,4 +752,29 @@ static inline bool vtd_pe_pgtt_is_fst(VTDPASIDEntry *pe)
>   {
>       return (VTD_SM_PASID_ENTRY_PGTT(pe) == VTD_SM_PASID_ENTRY_FST);
>   }
> +
> +static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
> +{
> +    return pdire->val & 1;
> +}
> +
> +static inline bool vtd_pe_present(VTDPASIDEntry *pe)
> +{
> +    return pe->val[0] & VTD_PASID_ENTRY_P;
> +}
> +
> +static inline int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
> +{
> +    return memcmp(p1, p2, sizeof(*p1));
> +}
> +
> +int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base, uint32_t pasid,
> +                                  VTDPASIDDirEntry *pdire);
> +int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s, uint32_t pasid,
> +                                   dma_addr_t addr, VTDPASIDEntry *pe);
> +int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
> +                             uint8_t devfn, VTDContextEntry *ce);
> +int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
> +                           VTDPASIDEntry *pe, uint32_t pasid);
> +VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid);
>   #endif
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index e5b9689fae..744b5967b2 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -42,12 +42,6 @@
>   #include "migration/vmstate.h"
>   #include "trace.h"
>   
> -/* context entry operations */
> -#define VTD_CE_GET_PASID_DIR_TABLE(ce) \
> -    ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
> -#define VTD_CE_GET_PRE(ce) \
> -    ((ce)->val[0] & VTD_SM_CONTEXT_ENTRY_PRE)
> -
>   /*
>    * Paging mode for first-stage translation (VTD spec Figure 9-6)
>    * 00: 4-level paging, 01: 5-level paging
> @@ -831,18 +825,12 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>       }
>   }
>   
> -static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
> -{
> -    return pdire->val & 1;
> -}
> -
>   /**
>    * Caller of this function should check present bit if wants
>    * to use pdir entry for further usage except for fpd bit check.
>    */
> -static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
> -                                         uint32_t pasid,
> -                                         VTDPASIDDirEntry *pdire)
> +int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base, uint32_t pasid,
> +                                  VTDPASIDDirEntry *pdire)
>   {
>       uint32_t index;
>       dma_addr_t addr, entry_size;
> @@ -860,15 +848,8 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
>       return 0;
>   }
>   
> -static inline bool vtd_pe_present(VTDPASIDEntry *pe)
> -{
> -    return pe->val[0] & VTD_PASID_ENTRY_P;
> -}
> -
> -static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
> -                                          uint32_t pasid,
> -                                          dma_addr_t addr,
> -                                          VTDPASIDEntry *pe)
> +int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s, uint32_t pasid,
> +                                   dma_addr_t addr, VTDPASIDEntry *pe)
>   {
>       uint8_t pgtt;
>       uint32_t index;
> @@ -954,8 +935,8 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
>       return 0;
>   }
>   
> -static int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
> -                                  VTDPASIDEntry *pe, uint32_t pasid)
> +int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
> +                           VTDPASIDEntry *pe, uint32_t pasid)
>   {
>       dma_addr_t pasid_dir_base;
>   
> @@ -1526,8 +1507,8 @@ static int vtd_ce_pasid_0_check(IntelIOMMUState *s, VTDContextEntry *ce)
>   }
>   
>   /* Map a device to its corresponding domain (context-entry) */
> -static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
> -                                    uint8_t devfn, VTDContextEntry *ce)
> +int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
> +                             uint8_t devfn, VTDContextEntry *ce)
>   {
>       VTDRootEntry re;
>       int ret_fr;
> @@ -1909,7 +1890,7 @@ static VTDAddressSpace *vtd_get_as_by_sid_and_pasid(IntelIOMMUState *s,
>                                vtd_find_as_by_sid_and_pasid, &key);
>   }
>   
> -static VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
> +VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
>   {
>       return vtd_get_as_by_sid_and_pasid(s, sid, PCI_NO_PASID);
>   }
> @@ -3133,11 +3114,6 @@ static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
>       return vtd_ce_get_pasid_entry(s, &ce, pe, vtd_as->pasid);
>   }
>   
> -static int vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
> -{
> -    return memcmp(p1, p2, sizeof(*p1));
> -}
> -
>   /* Update or invalidate pasid cache based on the pasid entry in guest memory. */
>   static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>                                           gpointer user_data)


