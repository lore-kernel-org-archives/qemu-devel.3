Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7851BCA1000
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 02:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usu3X-0001iW-3s; Sun, 31 Aug 2025 22:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1usu3T-0001gF-UT
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 22:14:00 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1usu3L-0003Lj-PD
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 22:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756692832; x=1788228832;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=e3AQP5H8GDMG+08tbrHTony/A/2JwjDyPUYWI0fBKT8=;
 b=TbYF7O4spKh2bluByzCPWL9+9IUL2t7rJbCSKIyhoi9BjMXg3JdFAc5l
 LlSuWdCoHzI+EdXDX6nRJFWi9GNCoUKOuVCidFBqXzTHjRp6JCXqurw3t
 oP4e0T+pySGMhqQsEhv+XcKjmwsPIRZLIDKo2HycPSGwm+NqBMNf8ZXok
 vYYZlMpHUKIzZtKfO9WcyYJXc+hmMFQUATEP4GuURo2Z0G8JX586jTmcQ
 MV/9V24kaD8NzkB0IE3BwKVoFq/UChakak20ay5y+Q5lcoi9/esw9iH6P
 1kOazBgsU2qpAEhz+OigKWqY/Lho/XjWisJnyXF3f0n7RE08mteD46IdH w==;
X-CSE-ConnectionGUID: wDB/NNZpTyiEzY9HGeMzXA==
X-CSE-MsgGUID: VwU73r4YROS11LhfsmZ1BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58811352"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58811352"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2025 19:13:45 -0700
X-CSE-ConnectionGUID: bj/ZP6KQTeqxRnslvi07/Q==
X-CSE-MsgGUID: K72DP9dERrq68sljo33erQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="194528504"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2025 19:13:45 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 19:13:44 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 31 Aug 2025 19:13:44 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.81) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 19:13:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xu+2tij4IU1AEdFWkOzsmv7MMry39ssak/ssWn3kf0uHLVhYa/8HuYwytgaaOaOp6UqBHGAqeoEPNYsz52qkNNrwcrUu2LWpxKARNejA4GpJNm7k2U8nd/lVwjpzIY+xrUZTx6G2BXnLusMGVF5eQIpHjtNHxHxhlLuko5SbdH17LlMKxhqTvkMu/jHkqxyDImuDvArAa5kU8mBMQi7vC9k8vwiQtZtCqJoFyr2Zam5dg0Rm0c3GQcfcEG6Mxl6RgMLzBm/8EeZOxIS0z331y6drvcD4bf7GQAaStf28WemFNZG/Er38VMcaujhWUyLTwnGLhF3pA5+WIUe4LTxqjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3AQP5H8GDMG+08tbrHTony/A/2JwjDyPUYWI0fBKT8=;
 b=jyeXK3HDl6p994l2hTqC4QXrfSoLSr8BgBCxg0pDV5fftwAH0D/26aUs7VyZGS7+v6d5ell0bATZa/CQ1KRgnzURbVMk+yLuYNcJv6XIxxT5rnpDwkEsKXGRJZ/QFT3hmclrMgUq3Zo+ThobEIxkswpjoqEVUrk0Xg+0aiQR3Bnoc77TSKnTHjT58C7Aim1aFMX7X5EcLc/jjEvJRJ9+UQuxsoUmPlui3amMNQaG5thhGtthAtSjByvLC+JDYmkY4tAiXTS4TUtCiYNKLmPTfxP/q6jJITE/5kF4He2TAQJGTqpUMP60M6oNkSLVuR90AwBTo79AGinbDJb0qZ3snQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB7734.namprd11.prod.outlook.com (2603:10b6:8:df::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.21; Mon, 1 Sep 2025 02:13:42 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 02:13:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>
Subject: RE: [PATCH] vfio/container: Remap only populated parts in a section
Thread-Topic: [PATCH] vfio/container: Remap only populated parts in a section
Thread-Index: AQHcDMr9Ap6MRYQc10GVaAw/xMLNqbR4FPYAgAWb3iA=
Date: Mon, 1 Sep 2025 02:13:41 +0000
Message-ID: <IA3PR11MB91363501F1A6ED40098AF8249207A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250814032414.301387-1-zhenzhong.duan@intel.com>
 <0286f864-9aaa-4a49-8975-cb1af3bb1270@oracle.com>
In-Reply-To: <0286f864-9aaa-4a49-8975-cb1af3bb1270@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB7734:EE_
x-ms-office365-filtering-correlation-id: 2407712f-8b22-442e-2fae-08dde8fd2bf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a3Z2eXVWZms1TzJxblkxaEpxb1pHT3BHMXJTaHhKd1lSQmtqSk9wcG1iOFNZ?=
 =?utf-8?B?YlloQkRCYXZNUmswcUltQkR2UXB4VzVxVnZxZ0RXdmZtM2VGUEFrRHorczdE?=
 =?utf-8?B?YU5EOXVBTzFrMFduSmNMTklTRkhKQ0hkSzdzNjN3emRia1pSc2VJR0x2eE5x?=
 =?utf-8?B?aEt2QlVzWWw4b3hNTzVBMFdORHFnS2UvRGpaSXVDOHFudGY1bjFTeVhlZk9S?=
 =?utf-8?B?OWV1Y0RjN2dBS21NTE96c1kvWlFoZTlZbE1rVUo0Y1IyVVlpRjkxV2pJTGVU?=
 =?utf-8?B?VVJqR3ZJYTdNaWl6Z25BNS9MMUVhQnVCZ1c4WWF4S25NS1c1STZKODRzRkFq?=
 =?utf-8?B?OUZwZS90OU1nVlYwazlhd29acXpvTHZtOFNSUWhmZHovcFkxazF3Z3NYS3Jh?=
 =?utf-8?B?V2FJTjRzaHlUQzNPMld4OU9jVHhHaUQzcFRYVGJHNEtaWEhxVFVkV1RzKytB?=
 =?utf-8?B?WHp5Tnd1bTEweEJ3bWFQaldWYWhGbW9CTnh0VisydExTMEpIaEo3Tk4vTStB?=
 =?utf-8?B?NENOR1dHUmxxbjV4blp4Vnd3dXZHNi96cHBjYzN2eGZXNEMrL05IWGR5V0FT?=
 =?utf-8?B?NWYxZEVzV2NBVkc2bEdjTElEZkZtbHZNcmhiNmRUU1hvanRpb0l0NmFJcXdz?=
 =?utf-8?B?NDg2b2F5MzkyQ0J2ck1JRk9WZDNoRTh5a0VzU1RaaXVsQ3dKOUpaLzRUcytv?=
 =?utf-8?B?L3RsaTBKeTdSUTNPSkRQSFNZMkt4WU5BQ09iUER6bk1Cbm1hK250dDd0cThF?=
 =?utf-8?B?Q1FJU3p1M0NHNXM5djJNazMvR21qV0F6SldLOWxLN3UyYmx1aVMxQ2dlS2NL?=
 =?utf-8?B?RVhPUVdJQjg1cXI0bTZRa0IrQ2NLVkJEVzFjcWtXQWozajBHcnJPNGI0VXlt?=
 =?utf-8?B?UzYzUFRJSjBqZ0ZqZmhqa2xNdjg3RHZSM05XeWJKZm96U1J1aFJCcFN3VzlQ?=
 =?utf-8?B?NW9KTkhvbzFwS3NUaVNjdEMzWko1T2hkSnJaOVpqb0h6UzB0MG5XaVJhVkd2?=
 =?utf-8?B?TUNkaEhpaElIcVJnQmlLYVJLeHNCcTRjMHlmQ1VZT29CRTVWeWhkS0VpSldI?=
 =?utf-8?B?am8wM01hcnVRMFlpdTBrS20xcVVwcUdiN0xCb0d0QjFNQmJrUjNhS2llOSsy?=
 =?utf-8?B?WXlRaitDNlEyYnR4dnJlSUpoQXhmR3hhdDNnYk1hTXdpazI3WVhSREE5Q243?=
 =?utf-8?B?Nlo4eUowQXFSVWZaVngzaG9taFgyd2NBVjVjU2hPM0RsWG9wRFBtUC9RNjJt?=
 =?utf-8?B?QWY1LzRrak4zcDl5SUJMSkdJNFlPTmdGSzdnYnkvSVpvWHhRSWN5SnA3OHhZ?=
 =?utf-8?B?Uk5sNVg2YVBkWUhveUYwVk5ESFVIL2dVTm1DWVhnWjZDSG5pbk85WTlZYkRo?=
 =?utf-8?B?NE10d3V5YkFlSlJ4ZTNDV1R5bnNvUDJjVWR4U2tnZDNrQmw3bUMrNlZ6WWYz?=
 =?utf-8?B?andNb2gyQk12QjRvc1FiaGs5Tm5oK05aY1FPYU12dE1sTC8zUllQenVud3Br?=
 =?utf-8?B?cDk4MDdXem4xSGtwckpCNVNEWHZQdTlhclhNVGlQUm8vVGxGVldsT0lEaEF2?=
 =?utf-8?B?S0pNOGdQZzl5UzdTS2w2aE1YS1V4MWhzYWY5QklYVGIxTnprbnhsR2NpSnlH?=
 =?utf-8?B?QWZaOWxCbWZwaUpJa3lQOHNCa1ZtQ25WeW1FL1FRZHo1bXJkSGVSZGZhcjl1?=
 =?utf-8?B?MzNPdVY2K0ZoWGlmTWFzaERKa0tmUXhBMTlRTHVDK1p1ODlnU3cyNmxxcXUy?=
 =?utf-8?B?Zm8vSDVVVStTNGxFejlIb3pxamJLTzJhSVpoQlBKcFkrVXVHUS83czh3dWs4?=
 =?utf-8?B?MnEzRXBlZkhiZldHeFJiQnVXMjZlVWhEdE11cW4wVU5wN1pKRTk1ekdLMmxa?=
 =?utf-8?B?ckFpbXBZNGtOZ2ZVb2E3Q0FIODQyaElFOE9iNlRhTUgwQ1I4eUo0YUt3bnN4?=
 =?utf-8?B?bUlVcDR6UmxjUzg1WTdZZlVpbHRGZlhNU0x4ZWoxVHo0dmhrVklnd0ZSOUIr?=
 =?utf-8?B?UE1VRmhyN2ZBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1BmMjMzNXZVcjhsZHB5Z0lRRkxPRXBxSGNXaytySm14cVVUUVp2QzZJUWJS?=
 =?utf-8?B?NmdnZG1weUZXaEYxY3F2Y3NKSnVGeVpwNjNYM3pmMFJ2TFhBYnpRd1oxdU1W?=
 =?utf-8?B?S1N2THFySWx2d29xRVRoc0gzQ2dPZDlmVkVHQUNPaEJvZWR3eCs4RGxkTFBp?=
 =?utf-8?B?ZkVuYzZITUhPVWpYQVB5eTRzMXZ0WDRwTXYvUTFGUUpIcDZ6VnhKZ1VKbjZu?=
 =?utf-8?B?bFdLbCs4QzRGcE41UzhaU295TVJoV3FMUXplRy81cHppQjhqeTA1bGJFQnF6?=
 =?utf-8?B?azBreTM3bVBSRWFzTjROT2wzYm0vYjErSVBmSDJuYXZLY2V3QmxtUWxseG03?=
 =?utf-8?B?SlVqUFZzS3F6TGt1QllhTHUzZzB2UFlzM1JhejFRRUloK1d4M0FPd0J2SUk0?=
 =?utf-8?B?bjlEZDlkUnArNS9mVGVRQjhZZW1UazB1L3paUDVDcXNtcTJYc25qUWZENmUw?=
 =?utf-8?B?Vy93K09ubXpKZXMvR3k4SzN4UTZhR2lmaUs3MllqT0ZKV0tMbGQxYmFvcFFR?=
 =?utf-8?B?cVdJVmZKSEpBZkgrMStzNHcyVzBBVXhvaXNXclY3YWdXU0o5K1FFWW85MGR5?=
 =?utf-8?B?QXhudWE0b3IxbHJMbGNITzlLMkw5M0lqU3JiNDQ3OHVpL0tGWXNRUkRtcU1E?=
 =?utf-8?B?RjFyYmM5RlVxd1g5Qk1hYzY0V0JsbFNUSlBQU3J6RGpDSWh0Q0ljdThNQ0RW?=
 =?utf-8?B?WlllQXpWL2RNblZZbWsxbGIvSXhpMHJQREJGVG1WZnovbFVTNndudDFjTFE1?=
 =?utf-8?B?ZWFWaVVENDVzaWJvVEczRVFGa24rbWZQYkorT0NxVi9pNnpVcmNYa1c2UGY4?=
 =?utf-8?B?UExwTmM5SmFyNGhwdDhaaHI1RU5YaUN6TXVtMmtyeXFvNUMyM3JCYWdiT0w2?=
 =?utf-8?B?WjhuUktqTzcvdzBLRDZjVzFaUHp1b0pCMlNKNmVabnhpcjYxMHlvK29ZMWd1?=
 =?utf-8?B?OVN3blBVQXhMSStRZzFXWlB5bFVZMCtCeE40UkFna0I0MTE5NXAzc1NXWllL?=
 =?utf-8?B?enJPeHorcVpWay9ncllkQUN2NUcrWEZMVDBkaVdHSGE4NnFLeXJZc0dmYUNH?=
 =?utf-8?B?dGR0R2lrNEhreXk3Q0F3Z0Y4ZEJKcW85QmpJSW40clZubEh2bVFoazA3enVh?=
 =?utf-8?B?dHJpbFR5ZmVHdWRXSUs0b2VjRlpvaFdEakl3Y3E3MTVYcXBsQkJWd1FCeHFm?=
 =?utf-8?B?K3pybUsxbEpUcWdiT1VXdkZad2s5dGpTNFJtWHZMRFF4OFJYN3NoQ2E0dVJK?=
 =?utf-8?B?TlBrNGVkR0d3RDFDSlJ2NE1Za2l0R01Kcndoc2JYckJoQ2Q2aytpU2FhZDBt?=
 =?utf-8?B?RVBrT2ZISm81aVlOa3hNQ0RTS1JpUERQYlhpUFNGeWpwb3RzYlk1a3FDb0Rq?=
 =?utf-8?B?bm8xa1FSaUJIV05RemZlUUpBKzlnNzIwOGE0NnJrbzF3Yzh3M0dZc2NUZWdY?=
 =?utf-8?B?d25aN1o0bmJuR2JDYjM2WkJtNHI5K1czaU9VY05pRDZ2VkhrQ0ZVYkJyMTlm?=
 =?utf-8?B?Q2pXR1Z1NlRBdE5WVW96bTZWQjROSTc5dDhWdVUvelE1VFJwRGVlbXdzZjFH?=
 =?utf-8?B?aUlqY1JUSFdnaGF1N2dsMXYyVjZNbzQzL2VIVThubCtzWUlQTm1mcllORzlQ?=
 =?utf-8?B?aXBRUkZrbVQyYjExVEVUZHVoN1VZbXlvN2YxR1grVnl6NE54MWFXTEQzYXVF?=
 =?utf-8?B?cDJhZE9wL0V4YmV1bGNwVmJKeW5VNFA3NnM2VW83Q1UrNnlpSzdNVERENXVx?=
 =?utf-8?B?SCtxYWlNU0YrcXNxMG92Z0dCR3pPcUNrUkpPQ1FVS29xMG5ia2lNd1Y0cHFj?=
 =?utf-8?B?aW9jY2xma2xoaUphK0Vza1BVOHJVeHhIVHVrNWIxcnF3VHhnUVVvR3ZTK1Jp?=
 =?utf-8?B?ejJMSVNReFJvM001ZkhoQ1FUeEtWQytPMTFqMEJHME8yZjZyb0tySmN5QzVS?=
 =?utf-8?B?SDdieUpManNJUzMySWJKeXdmUWNBdlFBekpkS2wrZ3MrVUd6US9LTUtVMXQ1?=
 =?utf-8?B?SWQ2SVU1OCtCdnUzMHhZMkJxU2ZVOGIzYU1rMEg0RnJMQW5nU211eWdwclFt?=
 =?utf-8?B?YmhLdk5yZEJKRExFWmpneSt2d3BHYUF4ang4ZTZzNndUeUUrY1hhSmQrb2Za?=
 =?utf-8?Q?3mmLX9ojifUuFkeCBqd3tBs1e?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2407712f-8b22-442e-2fae-08dde8fd2bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 02:13:41.7545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGpndya9zBsXf53mMlM+ZmbGkRzuAlqrvEvXwNfigzLdELHNuPDWDA9bkTu/Sl6b0xHsbYVyP8zaAE1MKBm7OWyNxlSo5b3Mmo6Y55Wdz4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7734
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlbiBTaXN0YXJlIDxz
dGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZmaW8vY29u
dGFpbmVyOiBSZW1hcCBvbmx5IHBvcHVsYXRlZCBwYXJ0cyBpbiBhIHNlY3Rpb24NCj4NCj5PbiA4
LzEzLzIwMjUgMTE6MjQgUE0sIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSWYgdGhlcmUgYXJl
IG11bHRpcGxlIGNvbnRhaW5lcnMgYW5kIHVubWFwLWFsbCBmYWlscyBmb3Igc29tZSBjb250YWlu
ZXIsIHdlDQo+PiBuZWVkIHRvIHJlbWFwIHZhZGRyIGZvciB0aGUgb3RoZXIgY29udGFpbmVycyBm
b3Igd2hpY2ggdW5tYXAtYWxsDQo+c3VjY2VlZGVkLg0KPj4gV2hlbiByYW0gZGlzY2FyZCBpcyBl
bmFibGVkLCB3ZSBzaG91bGQgb25seSByZW1hcCBwb3B1bGF0ZWQgcGFydHMgaW4gYQ0KPj4gc2Vj
dGlvbiBpbnN0ZWFkIG9mIHRoZSB3aG9sZSBzZWN0aW9uLg0KPj4NCj4+IEV4cG9ydCB2ZmlvX3Jh
bV9kaXNjYXJkX25vdGlmeV9wb3B1bGF0ZSgpIGFuZCB1c2UgaXQgdG8gZG8gcG9wdWxhdGlvbi4N
Cj4+DQo+PiBGaXhlczogZWJhMWY2NTdjYmIxICgidmZpby9jb250YWluZXI6IHJlY292ZXIgZnJv
bSB1bm1hcC1hbGwtdmFkZHINCj5mYWlsdXJlIikNCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9u
ZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+IGJ0dzogSSBkaWRu
J3QgZmluZCBlYXN5IHRvIHRlc3QgdGhpcyBjb3JuZXIgY2FzZSwgb25seSBjb2RlIGluc3BlY3Rp
bmcNCj4NCj5UaGFua3MgWmhlbnpob25nLCB0aGlzIGxvb2tzIGNvcnJlY3QuDQo+DQo+SG93ZXZl
ciwgSSBuZXZlciBsaWtlZCBwYXRjaA0KPiAgIGViYTFmNjU3Y2JiMSAoInZmaW8vY29udGFpbmVy
OiByZWNvdmVyIGZyb20gdW5tYXAtYWxsLXZhZGRyIGZhaWx1cmUiKQ0KPg0KPkkgdGhpbmsgaXQg
YWRkcyB0b28gbXVjaCBjb21wbGV4aXR5IGZvciBhIHJhcmUgY2FzZS4gIEluIGZhY3QsIGlmIHdl
DQo+ZXhhbWluZSBhbGwgdGhlIHBvc3NpYmxlIGVycm9yIHJldHVybiBjb2RlcywgSSBiZWxpZXZl
IHRoZXkgYWxsIHdvdWxkDQo+YmUgY2F1c2VkIGJ5IG90aGVyIHFlbXUgYXBwbGljYXRpb24gYnVn
cywgb3Iga2VybmVsIGJ1Z3M6DQo+DQo+dmZpb19kbWFfZG9fdW5tYXAoKQ0KPiAgIHJldHVybnMg
LUVCVVNZIGlmIGFuIG1kZXYgZXhpc3RzLiAgcWVtdSBibG9ja3MgbGl2ZSB1cGRhdGUgYmxvY2tl
cg0KPiAgICAgd2hlbiBtZGV2IGlzIHByZXNlbnQuICBJZiB0aGlzIG9jY3VycywgdGhlIGJsb2Nr
ZXIgaGFzIGEgYnVnLg0KPiAgIHJldHVybnMgLUVJTlZBTCBpZiB0aGUgdmFkZHIgd2FzIGFscmVh
ZHkgaW52YWxpZGF0ZWQuICBxZW11IGFscmVhZHkNCj4gICAgIGludmFsaWRhdGVkIGl0LCBvciBu
ZXZlciByZW1hcHBlZCB0aGUgdmFkZHIgYWZ0ZXIgYSBwcmV2aW91cyBsaXZlDQo+ICAgICB1cGRh
dGUuICBCb3RoIGFyZSBxZW11IGJ1Z3MuDQo+DQo+aW9wdF91bm1hcF9hbGwNCj4gICBpb3B0X3Vu
bWFwX2lvdmFfcmFuZ2UNCj4gICAgIC1FQlVTWSAtIHFlbXUgaXMgY29uY3VycmVudGx5IHBlcmZv
cm1pbmcgb3RoZXIgZG1hIG1hcCBvciB1bm1hcA0KPiAgICAgICAgICAgICAgb3BlcmF0aW9ucy4g
IGEgYnVnLg0KPg0KPiAgICAgLUVERUFETE9DSyAtIFNvbWV0aGluZyBpcyBub3QgcmVzcG9uZGlu
ZyB0byB1bm1hcCByZXF1ZXN0cy4NCj4NCj5UaGVyZWZvcmUsIEkgdGhpbmsgd2Ugc2hvdWxkIGp1
c3QgcmV2ZXJ0IGViYTFmNjU3Y2JiMSwgYW5kIGFzc2VydCB0aGF0DQo+dGhlIHFlbXUgdmZpb19k
bWFfdW5tYXBfdmFkZHJfYWxsKCkgY2FsbCBzdWNjZWVkcy4NCj4NCj5UaG91Z2h0cz8NCg0KSSBh
Z3JlZSBpdCdzIGEgcmFyZSBjYXNlIGFuZCB5b3VyIHN1Z2dlc3Rpb24gd2lsbCBtYWtlIGNvZGUg
c2ltcGxlLCBidXQgSSBmZWVsIGl0J3MgYWdncmVzc2l2ZSB0byBraWxsIFFFTVUgaW5zdGFuY2Ug
aWYgbGl2ZSB1cGRhdGUgZmFpbHMsIHRyeSB0byByZXN0b3JlIGFuZCBrZWVwIGN1cnJlbnQgaW5z
dGFuY2UgcnVubmluZyBpcyBpbXBvcnRhbnQgaW4gY2xvdWQgZW52IGFuZCBsb29rcyBtb3JlIG1v
ZGVyYXRlLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQoNCg==

