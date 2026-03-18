Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FB4103E160
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2pUk-0007ev-9m; Wed, 18 Mar 2026 07:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2pUj-0007eF-69; Wed, 18 Mar 2026 07:55:25 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2pUg-00023L-Vc; Wed, 18 Mar 2026 07:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773834923; x=1805370923;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EYfShifcb3TIU/Zy2s41uz94E4hV+Te6By/zaBsUIeA=;
 b=acB5a98H0aJtcDXKjdIHOSKOQUKIJRD1YSKH29mJfnnXUmBe5WSTiXse
 8IQToBjtcdrmAMGA1AzVQt/qOSUcfy/Kbv/F/q2j/dkgUAfTq10AOhGsK
 WhRtTZvW0NOWO/UZWtTu8J2MhX2Adh0TUVrisNFwZMP3T+pnXe4HDgT0G
 GUQbzpy/u7+YaUE7DDNqjUHfDma6CABhpO0cHU7ial35xLoEDGp6PvoDv
 1tOXmOff0sMWrlUIRMg3Qirc72rWfg3njeC7r8nN2hAGDqjO7ktDDFY2I
 49BK6Yx3V67vTDj4FKBwDjEzet/INmxsni0JyeU8L6t4m4NPzgeB1PTzj A==;
X-CSE-ConnectionGUID: j+vbcn/KTU2cLA+HInUfaw==
X-CSE-MsgGUID: UPzG+kExQDeazMfWDLQHWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74915088"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="74915088"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 04:55:21 -0700
X-CSE-ConnectionGUID: 7ZBw/2V3Tw6Dj9xV412NDA==
X-CSE-MsgGUID: z8a6ktmgTd67QpQH27RFRg==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 04:55:20 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 04:55:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 04:55:19 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 04:55:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H45Nor/3hI4XUikqJqoOYm0iaT3gsHQNdg0twYM9mQerRoG5nTKfP7PsfrjKArTS3gUNQNQ4xryAqj72t7ggPeDL0dvsWmwdAUt3CFtisORHMGl7SeTelQBf8Pu2LSB6S8oeWGMlmn7qlZ0+UOD/tLMJlre0Ty8BgTx1hAkfhWUQpN7GGmMe34RT85Bg7wN/X13J5oepwPttGIrJrPri6pHKYuhVpfJQuWhzZ65SfZydn6vJ5osJVdebAjzNdjWJjzi3WzHPwDgTiOcoI92Ov539O4SIaA5/acaFjN2P7JPSJC1XLTQlH2JzzKmxMFTa30zd1lZj6AukAfogptBs4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNIxC02PaLaY84957roAujkXo6hriH0CPvANSal3uLQ=;
 b=C317vNLptfLebm2W+J5GwpcvH6iHeCkCq2UlOGhxMl0YCW7RcdWHHO/h1DoJ2sfT5hzBsGDPekac/B8yDrazF5Oh+kv2lHuVPgxXE2SdvVpMu6BeH2pxN0tCRL91dYNYJQP+wIxAfy3uaLvdw+43TPsTdAqYQWglJnRhh0u+80ZrqRIDIzArUAcPCbQ6IhXp41NEUXE2WqpOJ1yU1lfFtvw/Zv+zssT93T7BD3Hr4zlWhrNgyDFLy94cabAXtQ5c5ZCnhjoTvJT6AcoXINpKYSKwIj7lO/UgSKNLCyLqzHVfX2w8l2VluVqMUWBIrXd0zUi/SZAqY0dyMJIpXEOZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DM4PR11MB7206.namprd11.prod.outlook.com (2603:10b6:8:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 11:55:15 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 11:55:15 +0000
Message-ID: <5bd68a1d-ee61-4ef6-92b4-f893373250a0@intel.com>
Date: Wed, 18 Mar 2026 20:03:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/13] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>, <qemu-arm@nongnu.org>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260306034409.184873-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0046.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:3::9)
 To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DM4PR11MB7206:EE_
X-MS-Office365-Filtering-Correlation-Id: 892b711a-d863-44c9-a4da-08de84e537dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: RGWhdB/uo7+MOVukxGJrApH9v3SL7Te4wfMY8qv1s8QwB4KwcnXBuICwGd8TaqKxRbYf62RLO1j3lyD08N25AGJEyWSeVNwFGxzIhy/z3Ym/QhOfLT6CdMgKnBAxdMWlU4fZ/ym3pa5hWMZSbLbRO8rNXXM6ZEm7qQOgMS5yfcIE/ZAeY+9lS0p7/8VkFSufyvAhcMRDY+fGgIw1R/wJNcfev2BJeibA2DvNL/vO2RQZypEqVJOJHv7KLAHP9YVC93qDVDebgBjMjmFlZmbCVc4IoEetRk7dfQ1u9XKpgGVf7PAVlj8bopaReGZ6zupbuppd9VO7CUrSVE72wofoRdVzXE/vAoreGsHJFUwtlQG0uztDov1a75+yiRjmVZbnq/3dbYnVqpoSouNF/BRtIu5EJMCJZkddM12NiiQydTDBOxWakY0Y7P4qBEvVnN5AL29QznC2QUOxHKTy/ROIWDCPWLZpOg4fhYWGcwX8S7lAGG3HenjcugGL3yWPRT4O0Czhs6K7jPS1xBREAWFnZ0ChLgGp0jcB1jkpSTFxY1NGdUJ47rRP9MDTZK6DRMZBXOdqAtZZ4zS274Xyawh+qzL0SaR8oekFCGxp1HOa8crOumQ+nha4rq3qMpb4aF/HgjRTSCmmu1N2bQGso/RdY137PWalodzGSZemcSiBkgrHbLUjnzUoN34cqZmMjWe0/xHO5FgFmCVwhRqO459o2Wg7VqgA4lGELY5P6oDLgS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(7416014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHlnazl5K1hhaEVIT1ZodTYxdE5jSHhFZjRNYk5NaTBGS2hGZDU5VElja1Mv?=
 =?utf-8?B?QnJtdDNuWk1WNzFCNUVJdnFUY0tHTWNoeGtVWFJnTFV1VVJHYnRNMW1UNDcx?=
 =?utf-8?B?cGJjazE4Ym8zOEQ2ZmFyekpaaWI1VktLaklOeFp4RVE5Y2hGdzdmeGwwK2JY?=
 =?utf-8?B?YW55VUVsTzFYQWVOTXBVV1lGM2t5aXA5N0xISGU0K01QSHJ2UUJEeGJielNh?=
 =?utf-8?B?N2RmTU1kcThQNStLYTdSQ2h4a1ZWM0U2VlEwL1lrS2NvQ2ZqT21oOWd6UmJz?=
 =?utf-8?B?Z3l1YmNQdVFENGpONkl2dGhZbzVNa2ZUTmR5K2s3eXI4cWpvZWw0RTNoYWxz?=
 =?utf-8?B?L1BBMmJCVmN5WEE4dmJCSkppU3JIdWR2c3EwVVkreVRablRmWGRuSmw0RWpz?=
 =?utf-8?B?MnY3cGlkUzQzcURxUVRMUEpVSkc2alJBK2EzUFU4bTgxU0ExV29BUE5uUXpG?=
 =?utf-8?B?ZHlqS01lR0NlS203L1Jxak1wbHhQYTZQUG5Xb050bHJCQjZzMWxmcW9uZUR4?=
 =?utf-8?B?NHl4NWZ6TkkwS0tLNG83QkY4YWdrUXQwRjFEZ2pGSmd1Y0VGOG5UWitYTmRj?=
 =?utf-8?B?UlJoSElicHpmZ3cwUk9NQ3ErVGpXRFg0NEcyd1dpZ0xtUUlUam1XTnBKalIz?=
 =?utf-8?B?ZTZYbTQ3NXJ1bWZCQXR3enZrTW5ZMlcrWVgwQTRQMld4U1FLSGpCVEg4RVRV?=
 =?utf-8?B?eVQ0NjlFN0lFaDNjZGtmeU43QldMUlZybCtkQkxXVk5BNkJJMEZrNU15dno1?=
 =?utf-8?B?dk9CL29tUW9LOXpMNGFWY0M5bHdOUG5kSkFjT1ljL2ZaK0dVUEc5M0xjQWUv?=
 =?utf-8?B?SkJrSXA3bmNuTHZwOEh4TmpOZm01b3JtL0NYR3EvNTgreThYWHlBMGI2WVZm?=
 =?utf-8?B?VzJOQURVZGNVbitLc3FJeE9wK2gvZFIzc1FhQjdwdm1MYVZlb3oyejlnRE03?=
 =?utf-8?B?akpLUTczV0ZYNXJRZU9lN3kvYWtRMEdYME1PbXNtdW5ST29rMkg1NmtTZWxC?=
 =?utf-8?B?UUVuOG54QWtZVFQ5NVJ3OExuNU0zNjlZdGRjWGhtWkNJb0dJb3JtWTJJd2g2?=
 =?utf-8?B?UFlVc3VOay9LUFEvRVdraEI3OWU4SHFoZHh0SXJjeFBYWDdNZTVyNW5uQVh6?=
 =?utf-8?B?dWZWcDNHZ0R5NFNJdUZZRm1tZWl3S2dlbVVRQkh0UzQrRndWQjNJNUVTSXVX?=
 =?utf-8?B?ZUI3My9wNUkyZ1ZrRzVBSU9mTUtaUkUwQjd3eklBUFFsdkgyMmZyeXdoTExa?=
 =?utf-8?B?Z0lEL01KWlYrZ2lpUlR1QXp6Z09QQ1Bxa2h3dFJxYnEzV1YyZS9YUjhBYndC?=
 =?utf-8?B?cjBYbzZWL0liSFVUMFZlaks2bjVXb3Y3YmNmbU9oeWlLYnFPQWFJVjVlc1U4?=
 =?utf-8?B?N1RLRVM2dnNiSnVWSXRZN2ViS0pWT0NqVlZtSUpmbS9lNU1aQnZMSCs2d1Iz?=
 =?utf-8?B?MWRYbHI1RzdQMDlueTQ3cVczd2YyVlJHeU9iWmQ0aVRqTnVLdVE5cE0yVUYy?=
 =?utf-8?B?bnU5TGpxTEFlNkJ4TW8wWHU4NDZ5N2lPM3dLeEM1eEVGKzY1Uy9VVnFMZWZs?=
 =?utf-8?B?aWVDa1Y4WXJBQ2srcXFuSEJJM2p2dTk4RXpPa01WYytyQTlFYnh6amI2VGZZ?=
 =?utf-8?B?WmlLQXltRUx0Tnh1b1JnNXRVRkkyWmMyZVkrUFI0TFNoYUVnQ3ZWWElmTjhS?=
 =?utf-8?B?dDRYQ015a1MyUEUxTkdnR3NySVowdmxXWEVTd0JTUUl6LytvbHpoT0hNSHNX?=
 =?utf-8?B?Wi9Nd1ZSMVIxUnF6WXBOMUZuWkQ1NWhnUHBacmd0aEhtL01rS0J5bGFnWVBE?=
 =?utf-8?B?TUFnNWpkaS93MEp4K1FxWUpmMnBVaFQyelJqZ3pqNXlSUmFCV1NNYlJMS0xI?=
 =?utf-8?B?S29ia01XbnhrU0g0YjUwWDhhY01OSzJFclkrL3poeEd1djMyQ3UyRkthSFlo?=
 =?utf-8?B?bS9rUjRVZkk5NTZFOHVLeDFWSCtzRlZFcVBrYy9FbFlRM1lnRjVjTS9HdGNa?=
 =?utf-8?B?aEdkR0JsMWVtNVBBdmdpd0tHMmdZd2V5TlRaN0VZbStvcmwxUUpjdG9IYnNR?=
 =?utf-8?B?Q01Gbm04MXFYY2tVcHg0M0JTMG40NEpjcEdlUUJabUdTbXhzTXBOL3Bpcjln?=
 =?utf-8?B?aUpCaEpCTVdiS2R6S2NRcjZ6b0VxSTBqNmhkY0FRZE9kdGJtTmN2b1JnbVVO?=
 =?utf-8?B?QWl5ZlBjVXlSMG9BK0NJN2NTN0o3OGFJRmRneU5XWFdqbTdrRExYWllWRmpp?=
 =?utf-8?B?bE96VUpPemdvSk9sbnhPU29Za2Z4VXFPYlYyV3JXdkJBWE5sOFNYNmZNV1pJ?=
 =?utf-8?B?cGRWQXBxM2ZYU1R2YXVFbjFlZ0NDN2htY1lvQ3ROYW1GZm0vclpKdz09?=
X-Exchange-RoutingPolicyChecked: Xog+fXtlbv3gatwDLAMEOXA/AWA5A0aRVPIXngNkmd+6Ftw4C28RZ9X9Jl8c3t1qNr9olTRfjgFMhl/Gml5qiGUJc+Noi0H1rHjPMJWU7y3CEhWIiCXJT1cH5mmQUe5Qmd0R2uw47uTO+R5Q2tUS/HB96mLRQqyltAvAXif9eJy/+GMhXP57VxVYH2HAlBVZnZcQg8mrSUAB0Pk2NMoCLercCoPgx0f8J7zSPYyoPuufOQ0Lqrn8snj+WQWlFQunfFPXhUyOM92EOlYwk+WNcrVUqPm9ACQvHGj5p7OnDvyuOBHVRW5NertGbCniMe0GE/tv6lfCrRNDnKrVJ/3ZMQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 892b711a-d863-44c9-a4da-08de84e537dd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 11:55:15.6335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBWJLeTrxdsVQAGz2NhE/VcrMyXQPsEgQ846UAbhowP/vpoRkr5FnlTJthwqaZco0izvo/5UmS3zQz4UEH/OwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7206
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yi.l.liu@intel.com;
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

On 3/6/26 11:43, Zhenzhong Duan wrote:
> Same for the two wrappers and their call sites.
> 
> Suggested-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/system/iommufd.h    | 16 +++++++++++-----
>   backends/iommufd.c          |  9 +++++----
>   hw/arm/smmuv3-accel.c       | 12 ++++++++----
>   hw/i386/intel_iommu_accel.c |  8 +++++---
>   hw/vfio/iommufd.c           | 10 +++++-----
>   5 files changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 80d72469a9..80c8423654 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -124,14 +124,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
>        *
>        * @idev: host IOMMU device backed by IOMMUFD backend.
>        *
> +     * @pasid: pasid of host IOMMU device.

this comment is a bit misleading although I know what you mean. Perhaps
"pasid of AS" or "target pasid of attach". Other parts LGTM.

Yi Liu <yi.l.liu@intel.com>

> +     *
>        * @hwpt_id: ID of IOMMUFD hardware page table.
>        *
>        * @errp: pass an Error out when attachment fails.
>        *
>        * Returns: true on success, false on failure.
>        */
> -    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t hwpt_id,
> -                        Error **errp);
> +    bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t pasid,
> +                        uint32_t hwpt_id, Error **errp);
>       /**
>        * @detach_hwpt: detach host IOMMU device from IOMMUFD hardware page table.
>        * VFIO and VDPA device can have different implementation.
> @@ -140,15 +142,19 @@ struct HostIOMMUDeviceIOMMUFDClass {
>        *
>        * @idev: host IOMMU device backed by IOMMUFD backend.
>        *
> +     * @pasid: pasid of host IOMMU device.
> +     *
>        * @errp: pass an Error out when attachment fails.
>        *
>        * Returns: true on success, false on failure.
>        */
> -    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, Error **errp);
> +    bool (*detach_hwpt)(HostIOMMUDeviceIOMMUFD *idev, uint32_t pasid,
> +                        Error **errp);
>   };
>   
>   bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> -                                           uint32_t hwpt_id, Error **errp);
> -bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           uint32_t pasid, uint32_t hwpt_id,
>                                              Error **errp);
> +bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                           uint32_t pasid, Error **errp);
>   #endif
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 13822df82f..153edf4f79 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -505,23 +505,24 @@ bool iommufd_backend_alloc_vdev(IOMMUFDBackend *be, uint32_t dev_id,
>   }
>   
>   bool host_iommu_device_iommufd_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> -                                           uint32_t hwpt_id, Error **errp)
> +                                           uint32_t pasid, uint32_t hwpt_id,
> +                                           Error **errp)
>   {
>       HostIOMMUDeviceIOMMUFDClass *idevc =
>           HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
>   
>       g_assert(idevc->attach_hwpt);
> -    return idevc->attach_hwpt(idev, hwpt_id, errp);
> +    return idevc->attach_hwpt(idev, pasid, hwpt_id, errp);
>   }
>   
>   bool host_iommu_device_iommufd_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> -                                           Error **errp)
> +                                           uint32_t pasid, Error **errp)
>   {
>       HostIOMMUDeviceIOMMUFDClass *idevc =
>           HOST_IOMMU_DEVICE_IOMMUFD_GET_CLASS(idev);
>   
>       g_assert(idevc->detach_hwpt);
> -    return idevc->detach_hwpt(idev, errp);
> +    return idevc->detach_hwpt(idev, pasid, errp);
>   }
>   
>   static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index f5cd4df336..6b04344959 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -294,7 +294,8 @@ bool smmuv3_accel_install_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>           return false;
>       }
>   
> -    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID, hwpt_id,
> +                                               errp)) {
>           if (s1_hwpt) {
>               iommufd_backend_free_id(idev->iommufd, s1_hwpt->hwpt_id);
>               g_free(s1_hwpt);
> @@ -436,7 +437,8 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>   
>       /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
>       hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
> -    if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID, hwpt_id,
> +                                               errp)) {
>           goto free_bypass_hwpt;
>       }
>       accel->viommu = viommu;
> @@ -524,7 +526,8 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>       idev = accel_dev->idev;
>       accel = accel_dev->s_accel;
>       /* Re-attach the default s2 hwpt id */
> -    if (!host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, NULL)) {
> +    if (!host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID,
> +                                               idev->hwpt_id, NULL)) {
>           error_report("Unable to attach the default HW pagetable: idev devid "
>                        "0x%x", idev->devid);
>       }
> @@ -720,7 +723,8 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
>   
>       hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
>       QLIST_FOREACH(accel_dev, &accel->device_list, next) {
> -        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev, hwpt_id,
> +        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
> +                                                   IOMMU_NO_PASID, hwpt_id,
>                                                      &local_err)) {
>               error_append_hint(&local_err, "Failed to attach GBPA hwpt %u for "
>                                 "idev devid %u", hwpt_id, accel_dev->idev->devid);
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 67d54849f2..45c08c8f6f 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -121,7 +121,8 @@ static bool vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>           }
>       }
>   
> -    ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
> +    ret = host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID, hwpt_id,
> +                                                errp);
>       trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, ret);
>       if (ret) {
>           /* Destroy old fs_hwpt if it's a replacement */
> @@ -145,7 +146,7 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>       bool ret;
>   
>       if (s->dmar_enabled && s->root_scalable) {
> -        ret = host_iommu_device_iommufd_detach_hwpt(idev, errp);
> +        ret = host_iommu_device_iommufd_detach_hwpt(idev, IOMMU_NO_PASID, errp);
>           trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
>       } else {
>           /*
> @@ -153,7 +154,8 @@ static bool vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>            * we fallback to the default HWPT which contains shadow page table.
>            * So guest DMA could still work.
>            */
> -        ret = host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
> +        ret = host_iommu_device_iommufd_attach_hwpt(idev, IOMMU_NO_PASID,
> +                                                    idev->hwpt_id, errp);
>           trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
>                                              ret);
>       }
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index b4c5e81b1d..005f97fe25 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -924,21 +924,21 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, const void *data)
>   
>   static bool
>   host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> -                                           uint32_t hwpt_id, Error **errp)
> +                                           uint32_t pasid, uint32_t hwpt_id,
> +                                           Error **errp)
>   {
>       VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
>   
> -    return !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
> -                                                hwpt_id, errp);
> +    return !iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, pasid, hwpt_id, errp);
>   }
>   
>   static bool
>   host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> -                                           Error **errp)
> +                                           uint32_t pasid, Error **errp)
>   {
>       VFIODevice *vbasedev = HOST_IOMMU_DEVICE(idev)->agent;
>   
> -    return iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, IOMMU_NO_PASID, errp);
> +    return iommufd_cdev_pasid_detach_ioas_hwpt(vbasedev, pasid, errp);
>   }
>   
>   static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,


