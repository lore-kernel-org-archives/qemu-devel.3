Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A21CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 13:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqA9-0000ew-El; Mon, 20 Oct 2025 09:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAqA7-0000eQ-Dl
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:42:59 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAqA4-00037f-K5
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 09:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760967777; x=1792503777;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=X98RcGw/v8RNu8hETfeGfKY/tGUSLYHSoLjzGpSTgiY=;
 b=WfY80zBk8DlzfgIF9TMVE8vwnWi9XzykCujnPTBUtIFge35pO/+cQQYf
 K/952WeALjwNwe03olS4zBpFh1rgosAqZDmsTwRSaxxSYVxsRKLABhF3c
 2RZO7E50z8nE1rM3g1/K6urFUG7u3shnA1RVPmohKfmj9bZgHJWC5KGtB
 gtj9DrMwXc0at5eampFmJ0phbVNB3hyN13pOf0efwN9N0p3B1bGtZz/aR
 84/Qx3q2DQu7AjFsjKM8fWUKJO2arO88C2qvYSY2g297DGDXwDUtQkVpn
 O/MLu0juFQLPNtDcWuVnANbXM+hMtaCi/N6ZwTV3pr/tPIdVKeMmrQzE6 Q==;
X-CSE-ConnectionGUID: 6zTQvZywRR6f8GbhTCjh5g==
X-CSE-MsgGUID: MkzJj/E8SX6IcKfVC5RiDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66945383"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="66945383"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 06:42:52 -0700
X-CSE-ConnectionGUID: wSQMe3hlQyq/8+HtyNFkVQ==
X-CSE-MsgGUID: Lb/22RohQG+N2duIJoHIxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="183277528"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 06:42:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 06:42:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 06:42:51 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.42) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 06:42:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQcUesC++J0Aya8PtSXAFJxHjTEB7hb96Xdt6CRCSuqw51LrIsZQBRVihRGHj5Gjvnk0R7pg0O2NpHq6BT6RZ5jFszR2dVDZlRhVxR+P2b6s2BPgvQp7znPSsS77oz09NxeKJTnaPkZ/Eh3Tv9PPDiYPlQRD4IMEIYNrLCW1eY+KTtvWDAQc9nDSlTIJX62UFsl9HTVIWdJXlNI6WPRUfwXdVQ2qcU8nin08vywkE0EuWu64czcD56U/uWQtKcChfVR92nvKbwzIIu8Jt1d2Bx0cyZ1LBTSqsgyCTtUuQXemFyf2fMS/Pbxn6884bkgjxnL4QrIqQiMMmlFTf2TFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X98RcGw/v8RNu8hETfeGfKY/tGUSLYHSoLjzGpSTgiY=;
 b=AofWAhS8RbC3hnZF2FrOiDy/nT40qG2pxyxiG28/rQRmtHWCkonNAyY7AfYvh5+zp5JSSmIJVDrYc5T2N87wvdUhQMR6FHRx1EyMPkn8xnvuzh5tq0DveC0aQuHvx/FeJYvAoGeSWTP0I1HxZYTpoOwFhATKUkKQEICIXUDMN7dWjpR5lGxkF7QQkEAEdpytplPiyDfRbf121a+XauMq1Gjr+PeG+lpcF8mY8d7+l8fJf615r8suuXtT/NPVtRYiWbyGbB08qokrGAm5yfF+QJ8z41zfN95jmH3EA9XLQPf3vx5xDD+DYdYxEYJ7qK4OmsuUspjZL/NSqpSIgQRicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by MN2PR11MB4520.namprd11.prod.outlook.com (2603:10b6:208:265::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Mon, 20 Oct
 2025 13:42:47 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 13:42:47 +0000
Message-ID: <d158193a-c834-4fb9-b36d-487f3be4ab6f@intel.com>
Date: Mon, 20 Oct 2025 21:49:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/22] intel_iommu: Bind/unbind guest page table to host
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-16-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250918085803.796942-16-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0079.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::8) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|MN2PR11MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8a928d-72a9-43e9-9fef-08de0fde8d9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVFFMUs5Z1ozMmZpdXlHL09oMG1acGtaYWNvZElvd0lNb1NYMDhMOW5PYTdv?=
 =?utf-8?B?aWYxV1RMVThySVVpTGpBbVY5d1d2bUg5QnZ6T2N1U1pOcEFyWmFCY0drMWY5?=
 =?utf-8?B?VWhFZlhpK2M1T3JGdVhBbS9DeDdicEIwcGdSeEx4TXBEWjFrZFEwODlONmNI?=
 =?utf-8?B?WUtVd2VyZVZHQ2ZrL3RKVzVqVlI3WUJVRzBhdXJrOEpyNVB0a0k0TW5HUDNL?=
 =?utf-8?B?MzVITE9iajBnR2VFVmRmYVlHZElTS05xMVBJWitvOUQzOGNsOHBoaFFPd2I4?=
 =?utf-8?B?MGFLVjd5OE51UVp2NHhuTUJBQ2l5T3FwcEQwTFNtRld1TTYvUkhQOE05VFNn?=
 =?utf-8?B?bkNuNmxiaXU4ZWdBei9EY2FGalMvc3k2K2QxUm0wTGRCMVNtNzFZSlh1NmNn?=
 =?utf-8?B?eFRwZm5ZeXVQQXY2V0RFTCtDRWdKc1ZxOXR6RC9xZzBmaVp0QVdKeWNoVWFo?=
 =?utf-8?B?RE5HNXdGUDRWSXlSc2RwRm9ESVhrRThjVHdvVHNLdDNkVzYwbEJ0TUoxaXhx?=
 =?utf-8?B?VWcwZitsRW9xVVBYTUM5OURTaXR1R2hnR1owZ2hMTXA0dFBsciswa3NhaE5M?=
 =?utf-8?B?UWhmTVlHMUtSQXF2M2l3cFZSUkFSSmdyaWQxenFvZnBrSVU4aSs2RHhyd0l3?=
 =?utf-8?B?eW5VS0NvTXg1US83MUlUNEg1NlUrczh1RWhrb0ZzN0ZMYzROUlR4WDQvbVJW?=
 =?utf-8?B?NDRIeHZSYXA4TmpWOWFWTW4zZ2w3V05BdUduVzJjYzl6MHUrdE54U0Z6dWlY?=
 =?utf-8?B?UTF0UWhkMHdMSFZtVk1JT3dYdFRjRlB1ZCt6SE1ab0tydkVwQXA5NEtobkJT?=
 =?utf-8?B?V1Vqd2pqTUcreFFTSUgyWis3NnptRGhEZ05UbkgzaWFjQncyMW9lbzhxRFRP?=
 =?utf-8?B?UlNYQ1Zrd0M0NDdBMGpCWldMWG85UjdqQUw2NWRkb0lOWXF6bUg0Z0hEY0pF?=
 =?utf-8?B?WFNWdjY2QjdPUXFuUUI4RlJQTnFKckp1MktuU2UvRjlWdzJWeXVVOHB0Ky9B?=
 =?utf-8?B?dHlKZVRwaEQ5elM4R1ZCWWdDQzYrM3k4VFI3Sk1uQWh0MWRRNUFMV2duUlc2?=
 =?utf-8?B?RTNTY1Y1UytINVRGVzFQNHY4TlE2Z0hpSDM3dy81cjVOcFZKQmtxSW1BeGJk?=
 =?utf-8?B?UHI2Tjh2RmpuQlNKZ1FIVmoxOGJZZ254VlZUbVB6Tzk2dkZBRjBsa3NHdVZR?=
 =?utf-8?B?VlViR3NoRmlDdEZLMzc3MFBuQzZzS1hoWmR1dHNyM2ZiN0NnUnBvREdtb2d0?=
 =?utf-8?B?ZGhjRGovT0pSY1d1ZDBCd2ZycHA4RzlpdXpZaktDbklyK3R5UW12VnpDSWgr?=
 =?utf-8?B?dGJIWFhrT0FCaWNoYmZUWnlCa3JUK0cyeFFLRkQrWWd3bzZBcW9EVFBXcmFx?=
 =?utf-8?B?QTU4OXJJMXZ4SW1NdnpIU1hZbno0TE8xZkdLQUt6T25NL1EydHYyK081aWlz?=
 =?utf-8?B?NXk1YlJjbFRVSi9qK1ZhZnU4NDJLWENVUmNtY3l1NG1hakJpb0ZIc2pMQTN1?=
 =?utf-8?B?QjZEMjgrZGtEdTZqdGxMWWlUMVhFTUx2ZDVVcXV3eXA3a3pUQXVNcFg4VnlV?=
 =?utf-8?B?MW4ydmlPSHVJMkpHR1ZaUk51VnVjSys0aUZJQ3Q2azRjWUFVcjdmY2ZJZ212?=
 =?utf-8?B?Q1BTNjJwN3k4c1FjM2krUFlka3ZmamFYcktYVWlva01zTU9md0VuaVRyZFFN?=
 =?utf-8?B?RzMyd2cvR2ZkRSttR2dQV1hDRVpxL1B3eTFLdTliK0REMlBVZzhYaUV1MXQv?=
 =?utf-8?B?MmhUSWR5YUM5dC9JT1AxQUpXTUNZN2xsZXRNWlFYcXBBK1lJT2VBekFpUmlz?=
 =?utf-8?B?MVFWK1ZkcU9lTVlINTJLMWtkZGVodlhvamdwMEl5dUpWZjZCMUIrTUFNVWZO?=
 =?utf-8?B?RzhDRy9LSVBDRzF1dlBLa3ljWGlYeGZGS1hwZGVRaTlGN3JtNnQ3MWExRzd5?=
 =?utf-8?B?aWlBTG0wYUM5cG0wRFpGYUVRTlk2SEpOeExFdEdyWldxK0FGd3NYUkVQaGVh?=
 =?utf-8?B?eVhLa0NwdE1nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1VsWjZVc0tsbkVlRnRHSjhyRjIyNWVBbHkwUGVDV1JaUXVEUmF3UkhLV1d2?=
 =?utf-8?B?Q1k0WHBnaGZiVFF0Vis4TUFaSEZTWFJMLzBzVi9EU3lGSi9rWlhxNFlaNXp0?=
 =?utf-8?B?dHMyaitKWStCc0RKNVQzUEFENkEzL052SGdOa3U0SkJQaHNwb0RVbEl2b0pX?=
 =?utf-8?B?L3lpdkZCZnpkTmhkYVhoSFo3VDhrTlVRdWNrUHZoMDkzVVRNdlVMYU9oa0Yz?=
 =?utf-8?B?TDRsL3h1a2svZ3k2TVRDRStkK0ozdUF3M0tkaWJxOWRiNDFmRXVEZDRkSTM0?=
 =?utf-8?B?Nyt2cGtIaU02WkQvNjRIOVlXdTBnbytoRkszeDVDeDlReUF3OUJBa3kwWUVE?=
 =?utf-8?B?cHBEMzBqb0dLbXQ5bklNQUVaUDRISDNsR2taV1h6SFFTRnZ5M2dPZGg0NXNm?=
 =?utf-8?B?RE9FSzNRWGhIeHZOVERtd3Zic1VRejdiSk1lNk94alJoRmhXTTVkaWNRSlNq?=
 =?utf-8?B?bmZXZUhFMkE2OUFwZHliMUdVNFhodWRNeWxFWjB3cUhyMnJMRFlxaDRHWUN4?=
 =?utf-8?B?NGdIeWoyYkVzdVA3bEZRRUY5NEJRaHo5WWF1SmI3MmVydFhZa2VKQkpQM0Y5?=
 =?utf-8?B?ckF0Uk5IYk9ZZG9TYzU0V3pYUFNSRVBHaUhrU21VZEZ2bG54VXZHelJ4dDMy?=
 =?utf-8?B?L2RQQTZwYk9SRGRxL21yK0pXN1lYSDBlZGRJeWRUa1RQTEd5RGxaQndKUDVx?=
 =?utf-8?B?ZnhZNWFWT0FpVHhKbnVxWTUxenhXa2J0alcweC9XUVNIdGtWWldmVzVEalZN?=
 =?utf-8?B?eFUzMkRPMEx3bDVtL2RLVHVWQ3FUNHQxRFQ3L3o1YVN3VTBvQzVRWTErVVVt?=
 =?utf-8?B?c2k1K0lvaFhSY3JTTENsWWRvZWU2SVpta2FHVm1wdStzMno2V2xWeXFQN1RZ?=
 =?utf-8?B?WW5ZeFFHVkxEcHBTNHdXbC90MzNvYUN5cWRMUk5LNWxrcWdJZ29uL3BUaU56?=
 =?utf-8?B?TGppN1hUbC9BVHlnSzk4RHZlRjFMeEg1MjRmenBkeWlFNHJiUUVsVHVIT3Iv?=
 =?utf-8?B?Z3JYejJiaVJib1V5U2dNM0xxdzdZRWppLzNPOHpUQXlvdGIwZWhlTUgyT08w?=
 =?utf-8?B?bTQvN0xWQlllbmFRQU5xV3JXcmRNSHU0YUZYUWN5NnpBbnhnM0xURlA3VlRB?=
 =?utf-8?B?UHFiM29uTzVhQjFFeG0xelM2Ky9YMU9VS042c1p0aVk3c24wTGxmbFJlem50?=
 =?utf-8?B?Tk5xc3NYd0F6MTRLVHk4dkRTVHErc1JFMW56L0FSYkh6a3R6UVpTeFZ0S0Z6?=
 =?utf-8?B?N1Q0UlViR0ZqZTBXU1JCZ09JNDNmSmhNd1NSWU02M3dvTEcwUUlXY1p3Nml1?=
 =?utf-8?B?djFlVVVFcUZzeFQwMFBac0pJbXlWYW13Vy9YUU1xOUpnbUtqbDNrQlptNXdX?=
 =?utf-8?B?K3cvZkhDekc3YmZXWVVUVHpWclYyMnE1VEdJSTlNK3FXOGl6Q1UwTm9LbjRN?=
 =?utf-8?B?c0YvQ2tUR2pxTmVwdnBaQS8wMjdXMkJ1dlNjd0ovdGpVaFlGaFhWTkY2Q28w?=
 =?utf-8?B?dEFCb2tYWWE5dFpjT0pQZldieE1YdUdLd2RiZHVxOXN0OWp5dFBxcTNCdzhx?=
 =?utf-8?B?eEJCQkRJOURsOGZLTXN1Sk9jSTcxL05XVnM3MWJRK2wzNGpBMHcxQWVQajJi?=
 =?utf-8?B?WnpCZWg1ejExRmg2UDlBSm5wQ2ZqQVlNZVZ0bGorZGR5S3ZuN09yd3BNTFhT?=
 =?utf-8?B?aFdlVjBXSFlCKzFOQUF0YzRMSXozV2xhK3dKTFlLUFhKcjJDcUdsM2ZqU1BG?=
 =?utf-8?B?RytSWU1YNVNRTUl4VGREVGtLZGNCZWhTK1J3RlZZUUVPdTBONnk0YUFrR25q?=
 =?utf-8?B?ZFFsS3NiVWloejlrbG04U3NrS1IrL0diTzBib0Y2TjlPbHQxUkswUTY2TGY3?=
 =?utf-8?B?RC9KUlQwUW5KWDlLT1FyR0U3citCa2RrZkl3STZqOExOUENleGxobEpMQXZ1?=
 =?utf-8?B?WXlWSnhmOHNDTVhuUEo0K1FDZ2VmMVo1WTFQdC9sZHlrT2tIaC9PbmZWZldp?=
 =?utf-8?B?aEFzN0tnTTZvdFZFZytHSGtHNEl2ek9aZDBjSnBPczlkeUtMaDhsN054TnQ3?=
 =?utf-8?B?dUdkR2dqRGlNbmQxUld0OHdRM3VhWUpFVVVUR0lVTlhFNnRXcytjZ2gzeUNq?=
 =?utf-8?Q?1XSxucJSJzgCtx+8BUgMz4z2U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8a928d-72a9-43e9-9fef-08de0fde8d9f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:42:47.0481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIOlj7WXU8Z5h6eh6pqmK0a25wK2bQ9CNURnbt4/SNfEgfepQPUx4PmRA9BhOCsydH21lET7RWygM8QgaLgR4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4520
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Zhenzhong,

I guess you need to rebase this series on top of the below series. So
let's resume review after rebase is done. thanks.

https://lore.kernel.org/qemu-devel/20251016074544.377637-1-zhenzhong.duan@intel.com/

Regards,
Yi Liu

