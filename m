Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98370FB3D00
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w79rr-0001Qc-Vb; Mon, 30 Mar 2026 06:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w79rh-0001ID-EJ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:29:05 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w79rY-0005G8-SB
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 06:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774866533; x=1806402533;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WbclhvQMhgFYGznzeo5N0ka83be5zOHb4JZ9DX3vYf0=;
 b=JmToehN8/0sGEncbcdbbE5+22OAwlAodqH1WTzcp9WDP6P2vqrENL3lZ
 KSFlC2H5gzUFJErmjU/1F7BmUzbbOk7CWNVQGVqsj626uYa2DnIsbE/ZH
 Lqp3+S5S0OtW4p26IJd4t01sFDtw+7yrBFGh80borIfbQfnZFXorfpHS/
 IEDpGYfB1IUBgWh1MBDTSmqNIEs5PltS8f5E4GFCSV7FhHn4TyjGNv198
 lnMMUs4h9hZrwoJXm1Cnx21xOClj0NFLIWHw3CUxPaucmj7/FWhdNSYeU
 AB0F+X0kZtoiVzQk6GTSg25HwIeWwOQgSBR1mFJGxMP9ZeunRjyOpmNlR w==;
X-CSE-ConnectionGUID: b+vXPafuRHaFg8k8PDvt5g==
X-CSE-MsgGUID: 30sfa8sbRN+DOSq2qqPfmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75966926"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="75966926"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 03:28:50 -0700
X-CSE-ConnectionGUID: UsutoxdiREGmuQsaJzG4eg==
X-CSE-MsgGUID: bJEnIioLT4eN+1Cms26OQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="230934057"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 03:28:50 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 03:28:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 03:28:48 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.32)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 03:28:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eeXzFRpXvvo/lU1C6YD5GWNfnd/DLZjrzXP1oY27FLbWdJUcdVXoQyUajTXR+8qLJZ8426Jpqh+w+c778SjsE6TkOaKkwYzLx/Z3WL8SJbUxMFLae9iFbFmsgkbVeFWw8dVENNIG8p0wufKDmWVjq+13BnuzMd2+zBM5WloeaQq/pTCw1ZZgjEneRhA5t01NEanukz0pXGHYowQWdDW3ATud351mINXyc67uSJDQajILE3tULEcYXM/wHV3rtf6I180ae7qe3mmXNydyJlyC1/i3+ToqXeZhq2Soz667Jzq46yND9qyIjW3hG4WU3pN+0jpzy7kIBSLQEQ9y9pUI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNeRNPBteE5UfWdUOI5o5YGcnI0iul/1dgNklYBlKNM=;
 b=gtByW2nT7FH8DLHdi+8R/atyvO87rS88LfW5lah+2HA0MQkNgua3UB4eauc93J47yKJ+pYGCpgrj9SlxUSDMT1vxqRiD8JF0o3q4Pucj6DsYrm0zppRjIkKCcDnkpuFCrHKPlOJkc9WLOTlM4PxccTj8Ne/s7esJjVX4rYw99BvTNpuzj8ME1gMJW2CJhHiXbDf7aQ8fUVOF3WuRk1/QIeC5YzuYnCxC/mjqOdRpxWBotG8cfUt9hOm1FnUYT+y13hh6l0g7e0ViX4U4OC6gAU52PabOmJc81b2hDF/3uEme7Qefqmcl6en9ypsAkLPIVJI+Y388HkGHC4Y7WIoPnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by IA3PR11MB9424.namprd11.prod.outlook.com (2603:10b6:208:583::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Mon, 30 Mar
 2026 10:28:46 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 10:28:46 +0000
Message-ID: <482dc339-9f80-46b2-8f14-6a5359897bb7@intel.com>
Date: Mon, 30 Mar 2026 18:36:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] intel_iommu_accel: Add pasid bits size check
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
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-14-zhenzhong.duan@intel.com>
 <0ae09582-4e0d-4fcd-a7ad-5b6b0b470b93@intel.com>
 <IA3PR11MB913609282D514B085ABFA3279252A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB913609282D514B085ABFA3279252A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0002.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::11) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|IA3PR11MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: d29e7275-dbb6-4d18-c7ab-08de8e471fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|42112799006|1800799024|376014|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: YBOwFMV+xcoHuJKkcI1xu/aBfvyLZT+QE8QVen9MOZ4QotgLHulcP16Ypw6hYS9KAQWgIavzaM+G78QmbCpfCwarLw4x8QEnF7UW2MvyISVKiZg4Gl0d2cmMgITeogSRNc96ySOG9kUsYt79V0HkgKm3a6AqNYPHisgaViiX9gjD/UtMX04gty+mucOpKLqo0SLmpdNK8sJn7R18iDFbU/8VXu9gBt15JXRxx1QkE05+UQo2B/1O/Q/uIith5fSpbArq2cg9bWTvHTFjEmj/kESQA0clZaYsLmo8CCy8Dy20Qzo9pqEgFBn5X/GxcyZ/4lezamIJp9MqcpAcxG4xOhkVZLgaGFUApnMO5liVmdEm/rJLN6gQ2suMIsbdZr6EtO8DZyr+93oGXk48CDCL81/C26qXJsaxDlnOwNXNg1tU6sdM/pBRzurBKWYISRUJuSwdvBDhOCDgLZwH6jriY+9G0x0QJuhiNEsnnm8vZsPjDfQC9xnIamydQxBNYxXuogSokAai577eOdSKoKD9j8dDpLxioZYbc4+79vUb1JOtWGSfWgdM8tzr3ct6lqsTjPN65mOa/LbpgTikwdzxsMjs1IVImuaHFCITXhDMMmz6wV0cPgHHjyjx3ZvKjuQYCTbovXJb1xZwqibDf5OQnSSmGU3vuuE4Bm+zC09Rq0nj6fU11t3/qgysclkEV3IcQjebAWDoT5YHzoYj2PKSXgove9cEDm3yt6JudzUGgZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(1800799024)(376014)(7416014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHNTTXFnRFYvcG11ZnlCVFFWeEdkd2Q2QlZFemk1Um5hWTFJVFhNMjhmRUJN?=
 =?utf-8?B?YUNpdmN3aVVNSFNTZHhoMUEwamhMYS95WjE0a3FuUXJHMktCbjdxUlREclhE?=
 =?utf-8?B?RVFsRmg4UmtXZjJOVGdQdldNdzRjY2krb3NRKy9OYWg4WjRqWGdlWkRrcWcr?=
 =?utf-8?B?eEpYb1FmV2QvVHpKOHJOWmpqQVNYOFpTUFEyZWhUSTJDclovWjkzdTBkbEJx?=
 =?utf-8?B?Wk5ZU3JEZWkwNjlPS2NJNjFVeXlDd1NWaHc1MzBIVHk5NW02WGU4bVEwc1F3?=
 =?utf-8?B?ZkhMTjZiNEUyV2RXeXljcGtqb01KcjUxeDRoTzZ5bXJJc3ovK3J6NEM0ZkNa?=
 =?utf-8?B?akIxN1ZmSk1XL3hka0x5bnkxNi9sK1dncVVRMmRCdGw2U1BadlI2SFJPMW5W?=
 =?utf-8?B?MDJ5d2szektwTzZtQW1zTU12Tmpyb05xMHcxMWpDaGNSUEM5UFdXelRndm9H?=
 =?utf-8?B?MXB2UW8zeng5L2xCT1lQY3gzUDRYNHpqcFpxRkVldWZXRElzck9tdUxtdzBI?=
 =?utf-8?B?TTlpNWFXZUcwSVdocytLYXdYbVd1UlptcTNBVFdhTlZTVHRRRUJlMW1OSEVP?=
 =?utf-8?B?SGw4L3UrcG9MUU9wR0h2NkgyVXpYVUlwOHZORHBmc09kbEw0cDZsalUvUGZQ?=
 =?utf-8?B?OXVCNnJFb0E3NzY4cS9rTkQyR2JpenMzRTdqOGpWM2Q5aW9tZ3FEQjRvRCtU?=
 =?utf-8?B?NkNvak5jNVQyM0RDejdpakpDS1NrT1NYbndaMkxtakFqZkhFUm5IdkhhcjNS?=
 =?utf-8?B?TkhneVRWM2tSOHdLbHJ2T1FBSkVHbXZydFIvWXU5dHV0VzE4bU84U2owUms3?=
 =?utf-8?B?cEhIQW5iNC9kV0g5cVJOcHF3RERzNlRCRHhaSlNuTWZGdGtJWURuUlErd1A3?=
 =?utf-8?B?eVMzS0VNMzhGbHhQeEYvUHpBeDRRMnlqM0w4VkFJL0hsRjFiL0FiQ3NFU04y?=
 =?utf-8?B?WXlDaSs4eS9zckF2ZTZzdU9QbmIrUngxNVNCWTVqbzNkU216MHF5MkJralBu?=
 =?utf-8?B?TXRZNUd1QjkvUS9rN2tVT1JGZzV2QWcyQno0RzArOGtyZ3JDL3pqbVNya25G?=
 =?utf-8?B?K1o3NjZQU2ZCc2VxUmtzOVkwZDg4c1N1aCthVHpHeGg2cE5XZWQrOFV4aEtC?=
 =?utf-8?B?ZDhUQ3EzQi81cklzZ2czd01xZklmWE0wMlMzMk9hMnZWc3FXTDEwbDZEallV?=
 =?utf-8?B?SFFacGJobnhOZW9uRlJ5Vkk4ZEcrNyt0cjVzRmtIT0tXYVJNSkFvT05UWDBY?=
 =?utf-8?B?RkJvWWRkczRpN2Z6YzdRZmFwQlNJcDdLZGlvRUVJQ2tOQ0tIdUJEekR3ZkdI?=
 =?utf-8?B?RGczT0VVSzE0QTBpQ2NOY05scmlqbmlRMkVwVUpYbEorY3RGR0JucXdNVFRh?=
 =?utf-8?B?K21nY3VObFg2dEZRYjhneTJ6VEhrdzQvYjJaOXBDTVpEVytUWXZsNnh1YlFp?=
 =?utf-8?B?cWMwYnVxL1JMUDMzUUV3OURZUVdnQ216Nmc4UUlMK1p1Z3ByZDlFU0VYMzFj?=
 =?utf-8?B?S2NncUY0WVhldDFlWHgrN3NVT21yaURXVVpIVzFTWlJxZDZla2NielhUZ3Bm?=
 =?utf-8?B?N05DNG0waDFxWmxISWx4ZWRzWURtcVdjQ3NYMXJUQy9Gakl0bjlQaUhiZ2dF?=
 =?utf-8?B?RlprZWl3ai9FNWgvNzFXNDNiL2l2Zmd5aHk0MmJwa0drNmJQcUt4d0o4WGEy?=
 =?utf-8?B?Yy9Ha2NXbG9uQUU0VEpxa1BMekVvMXRqcE0wZDJuOWlZenNST0sxbEVpMnpv?=
 =?utf-8?B?UVhaN1ZveFBudGhsMGR4b1NsQWZnbW96U2xzeGIxczBDZUozNkFuU0h1aExB?=
 =?utf-8?B?WG0yQTFTaDRhV3d6UlBnekxlbFNZYVdoR1V2N3EwaVd3N2l6dXpsM2FRVmRV?=
 =?utf-8?B?TFZTZ0FDUzJqQU1sRmVLUlMyVzA1Q3U3a3VsdThleDMydHhzblU1VFZJN2FE?=
 =?utf-8?B?VzAxNnZOcTc1dXZoOTZCdUREUFA2TW5QSW44NS9wZmwyd2lxZzhPdGsvSi9T?=
 =?utf-8?B?WThJbTBxT3FJWkJIeGhZRWlYZkpCSHpqanJtWXJIemd4c1BkRG9jd1MvRnhQ?=
 =?utf-8?B?ZGxPdEVGTmlRcTVSd2dnLzJVQ2JKdkgrYUpvaXhUS3lVM1lRdG0xamJiUlFR?=
 =?utf-8?B?RVpKeEVWMWpQcEpqQ0I1dTFUUGZWcGo4WTBkY1NtUU9TWUJITXVOeUxnZXk4?=
 =?utf-8?B?NVNuaFIvcitFcE1zeStjS2hCcy9weE9sVzJ6NEZsOWhNWFFYL3V0OVNyWXJp?=
 =?utf-8?B?b3BEQmpmNks1cWkwY2lZMVlncG90MmRseXFncDdVc2x3ekdYd2kwa3l1VE85?=
 =?utf-8?B?a1VwR0hzb3hZKzdvY1hqc3NDZ0MvbGhhK2N2Y2k1N3hJMW4vREhQZz09?=
X-Exchange-RoutingPolicyChecked: Ia4B5MlF2ATSlxqsMQyjBL7j2Lyhn4ym9NmFyeA/Tk5UbovCmPRCombili0GtZGiTl2X+3z7FziEizCZqG1vwD8K4RTfWswHrre0oV/LkWtYUG5cVvPtbUaq/nyC2arWN92ptC1OYI2HsMTwK84YmtCSSkMIlY4QMx2NlSTMPLtN7C6tydN5THi5C3IHrXwQfsH/impUMEfsFam9g5r6/yb15Hwy7xHaxa4R+YxOwV3m5H/yOIZz9S81PzEA6uN1C2dK3geboQ3mt2IpSPNOKSaWwGdGQiaTf8RqOzh8wONNCEiK0ChaRm5A7RVePgmA8V+SzL/5P4V8r6wV4ssEfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d29e7275-dbb6-4d18-c7ab-08de8e471fdd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 10:28:46.4479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SRtwZSXZwG5oruU1FtrQqEdaLw8UgGNRbACB26JcAM7P9Hd96L3V4qKNNXfhn6t7K0vfdCLpufB26Qm3/VscA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9424
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

On 3/30/26 17:06, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Subject: Re: [PATCH v2 13/14] intel_iommu_accel: Add pasid bits size check
>>
>> On 3/26/26 17:11, Zhenzhong Duan wrote:
>>> If pasid bits size is bigger than host side, host could fail to emulate
>>> all bindings in guest. Add a check to fail device plug early.
>>>
>>> Pasid bits size should also be no more than 20 bits according to PCI spec.
>>
>> this has been enforced in the prior patch. right? hence just drop it. Or
>> you may be merge them into one patch.
> 
> Yes, will delete it.
> 
>>
>>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>    hw/i386/intel_iommu_internal.h | 1 +
>>>    hw/i386/intel_iommu_accel.c    | 8 ++++++++
>>>    2 files changed, 9 insertions(+)
>>>
>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
>>> index f3cb6cff1c..d11064b527 100644
>>> --- a/hw/i386/intel_iommu_internal.h
>>> +++ b/hw/i386/intel_iommu_internal.h
>>> @@ -196,6 +196,7 @@
>>>    #define VTD_ECAP_SRS                (1ULL << 31)
>>>    #define VTD_ECAP_NWFS               (1ULL << 33)
>>>    #define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap = deposit64((x)->ecap, 35, 5, v))
>>> +#define VTD_ECAP_PSS(ecap)          extract64(ecap, 35, 5)
>>
>> perhaps VTD_ECAP_GET_PSS. I'm also wondering if we should have a set
>> of macros to get other caps as well. Like "s->ecap & VTD_ECAP_SMTS"
>> may be VTD_EAP_GET_SMTS(s->ecap, VTD_ECAP_SMTS)".
> 
> Currently VTD_ECAP_PSS is an implicit VTD_ECAP_GET_PSS like other definitions.
> 
> I'm not sure if we should follow arm's style to use VTD_ECAP_GET_PSS or vtd's style to use VTD_ECAP_PSS.

Hmmm. The existing list is already a mixture.. Some covers both SET and
GET depending on how caller uses it, while some only covers SET (like
VTD_ECAP_MHMV and VTD_ECAP_IRO). Then adding the PSS macros here is 
fine. You may use a explicit GET/SET for PSS if you don't have a good
idea. :)

/* ECAP_REG */
/* (offset >> 4) << 8 */
#define VTD_ECAP_IRO                (DMAR_IOTLB_REG_OFFSET << 4)
#define VTD_ECAP_QI                 (1ULL << 1)
#define VTD_ECAP_DT                 (1ULL << 2)
/* Interrupt Remapping support */
#define VTD_ECAP_IR                 (1ULL << 3)
#define VTD_ECAP_EIM                (1ULL << 4)
#define VTD_ECAP_PT                 (1ULL << 6)
#define VTD_ECAP_SC                 (1ULL << 7)
#define VTD_ECAP_PRS                (1ULL << 29)
#define VTD_ECAP_MHMV               (15ULL << 20)
#define VTD_ECAP_SRS                (1ULL << 31)
#define VTD_ECAP_NWFS               (1ULL << 33)
#define VTD_ECAP_PSS                (7ULL << 35) /* limit: 
MemTxAttrs::pid */
#define VTD_ECAP_PASID              (1ULL << 40)
#define VTD_ECAP_PDS                (1ULL << 42)
#define VTD_ECAP_SMTS               (1ULL << 43)
#define VTD_ECAP_SSTS               (1ULL << 46)
#define VTD_ECAP_FSTS               (1ULL << 47)

> 
>>
>>>    #define VTD_ECAP_PASID              (1ULL << 40)
>>>    #define VTD_ECAP_PDS                (1ULL << 42)
>>>    #define VTD_ECAP_SMTS               (1ULL << 43)
>>> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
>>> index 2fd26690b9..e73695ff83 100644
>>> --- a/hw/i386/intel_iommu_accel.c
>>> +++ b/hw/i386/intel_iommu_accel.c
>>> @@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s,
>> VTDHostIOMMUDevice *vtd_hiod,
>>>        HostIOMMUDevice *hiod = vtd_hiod->hiod;
>>>        struct HostIOMMUDeviceCaps *caps = &hiod->caps;
>>>        struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
>>> +    uint8_t hpasid = VTD_ECAP_PSS(vtd->ecap_reg) + 1;
>>>        PCIBus *bus = vtd_hiod->bus;
>>>        PCIDevice *pdev = bus->devices[vtd_hiod->devfn];
>>>
>>> @@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s,
>> VTDHostIOMMUDevice *vtd_hiod,
>>>            return false;
>>>        }
>>>
>>> +    /* Only do the check when host device support PASIDs */
>>> +    if (caps->max_pasid_log2 && s->pasid > hpasid) {
>>> +        error_setg(errp, "PASID bits size %d > host IOMMU PASID bits size %d",
>>> +                   s->pasid, hpasid);
>>> +        return false;
>>> +    }
>>> +
>>>        if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
>>>            error_setg(errp, "Host device downstream to a PCI bridge is "
>>>                       "unsupported when x-flts=on");
> 


